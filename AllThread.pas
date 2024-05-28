unit AllThread;

interface

uses
  System.Classes, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP;

type
  TThreadAll = class(TThread)
  private
    { Private declarations }
    IdHTTP1: TIdHTTP;
    DebugMode, CalledFromPL, Finish: boolean;
    DebugString, Result: String;
    procedure SetProgress;
    // debug mode
    procedure Debug(mes: String);
    procedure DebugSetProgress;
  protected
    procedure Execute; override;
  public
    constructor Create(aDebugMode, aCalledFromPL: boolean);
  end;

implementation

uses Dialogs, SysUtils, StrUtils, windows, MPStats;

const
  url = 'http://marketplace.1c-bitrix.ru/partners/';
  perPage = 25;

  { ThreadAll }

constructor TThreadAll.Create(aDebugMode, aCalledFromPL: boolean);
begin
  inherited Create(True);
  DebugMode := aDebugMode;
  CalledFromPL := aCalledFromPL;
  Finish := False;
end;

function DeleteLineBreaks(const S: string): string;
var
  Source, SourceEnd: PChar;
  S2: String;
begin
  S2 := Trim(AnsiReplaceStr(S, ' ', ''));
  Source := Pointer(S2);
  SourceEnd := Source + Length(S2);
  while Source < SourceEnd do
  begin
    case Source^ of
      #10:
        Source^ := #32;
      #13:
        Source^ := #32;
    end;
    Inc(Source);
  end;
  Result := S2;
end;

procedure TThreadAll.Execute;
var
  html, search1, search2, search3: String;
  pos1, pos2, move: Integer;
begin
  { Place thread code here }
  Debug('Execute');
  search1 := '<a name="nav_start"></a><font class="">';
  search2 := ' ';
  move := 20;
  search3 := '<';
  Debug('url = ' + url);

  IdHTTP1 := TIdHTTP.Create(nil);
  IdHTTP1.ReadTimeout := 10000;
  Try
    html := IdHTTP1.Get(url);
    IdHTTP1.Free;
    pos1 := pos(search1, html);
    pos2 := pos1 + Length(search1);
    html := copy(html, pos2, move);
    pos1 := LastDelimiter(search2, html);
    pos2 := pos(search3, html);
    html := copy(html, (pos1 + 1), (pos2 - pos1 - 1));
    Result := StringReplace(DeleteLineBreaks(html), ' ', '', [rfreplaceall]);
  Except
    MessageBox(0, 'В данный момент сервера 1С-Битрикс не доступны.', PROG_NAME, MB_ICONINFORMATION);
  End;
  Finish := True;
  Synchronize(SetProgress);
end;

procedure TThreadAll.SetProgress;
begin
  Debug('SetProgress');
  { Place synchronize code here }
  Try
    if StrToInt(Result) > 0 then
    begin
      MainForm.AllAddRow(StrToInt(Result));
      MainForm.ProgStatus('Number of partners: ' + Result);
    end;
  Finally
    if CalledFromPL = True then
    begin
      Debug('CalledFromPL = True');
      MainForm.PLGetData;
    end;
    if Finish then
    begin
      Debug('Finish');
      MainForm.BlockButtons(False);
      MainForm.TrayBalloonHint('Сбор данных завершен.');
      Debug(' ---------------------------------------------- ');
    end;
  End;
end;

procedure TThreadAll.Debug(mes: String);
begin
  if DebugMode = True then
  begin
    DebugString := 'TThreadAll: ' + mes;
    Synchronize(DebugSetProgress);
  end;
end;

procedure TThreadAll.DebugSetProgress;
begin
  MainForm.Debug(DebugString);
end;

end.
