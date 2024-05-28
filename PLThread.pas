unit PLThread;

interface

uses
  System.Classes, SysUtils, StrUtils, Math,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TThreadPL = class(TThread)
  private
    { Private declarations }
    IdHTTP1: TIdHTTP;
    Mode, ParthnerCount, PID, ResultCount: Integer;
    ParthnerData, ParthnerDataInfo: TStrings;
    DebugString: String;
    DebugMode, Finish: boolean;
    procedure GetPageCountAndStart();
    procedure GetPageWithParthnerList(Page: Integer);
    procedure GetParthner(ParthnerID: Integer);
    procedure GetParthnerDateInfo(ParthnerID: Integer; HTML: String);
    procedure SetProgress();
    // debug mode
    procedure Debug(mes: String);
    procedure DebugSetProgress();
  protected
    procedure Execute; override;
  public
    constructor Create(aDebugMode: boolean; aMode, aData: Integer);
  end;

implementation

uses Dialogs, windows, MPStats;

const
  urlParthnerList =
    'http://marketplace.1c-bitrix.ru/partners/index.php?PAGEN_1=';
  urlPartherDetail1 = 'http://www.1c-bitrix.ru/partners/';
  urlPartherDetail2 = '.php?offcomposite=Y';
  perPage = 25;

{ TThreadPL }

constructor TThreadPL.Create(aDebugMode: boolean; aMode, aData: Integer);
begin
  inherited Create(True);
  DebugMode := aDebugMode;
  ResultCount := 0;
  Finish := False;
  {
  Mode:
  1 - Get all parthners and Parthners info
  2 - Get one parthner info
  }
  Mode := aMode;
  if Mode = 1 then
  begin
    ParthnerCount := aData;
  end
  else
  begin
    PID := aData;
  end;
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

procedure TThreadPL.GetPageCountAndStart();
var
  cntPage, i: Integer;
begin
  Debug('GetPageCountAndStart - start');
  cntPage := Math.Ceil(ParthnerCount / perPage);
  if DebugMode = True then
  begin
    cntPage := 1;
    Debug('DEBUG MODE - cntPage = ' + IntToStr(cntPage));
  end;
  For i := 1 to cntPage do
  begin
    GetPageWithParthnerList(i);
  end;
  Finish := True;
  Synchronize(SetProgress);
end;

procedure TThreadPL.GetPageWithParthnerList(Page: Integer);
var
  HTML, ParthnerID, localUrl: String;
  pos1, pos2, pos3, count, limiter: Integer;
  SearchList: TStringList;
begin
  Debug('GetPageWithParthnerList - start');
  SearchList := TStringList.Create;
  limiter := 30;
  SearchList.CommaText := 'Search1=class="text">, Search2=name=", Search3="></';
  localUrl := urlParthnerList + IntToStr(Page);
  Debug('localUrl = ' + localUrl);
  count := 0;
  if DebugMode = True then
  begin
    Debug('DEBUG MODE - limiter = 5');
    limiter := 5;
  end;
  IdHTTP1 := TIdHTTP.Create(nil);
  IdHTTP1.ReadTimeout := 10000;
  Try
    HTML := IdHTTP1.Get(localUrl);
    IdHTTP1.Free;
    pos1 := PosEx(SearchList.Values['Search1'], HTML, 1000);
    while (pos1 > 0) AND (count < limiter) do
    begin
      pos2 := PosEx(SearchList.Values['Search2'], HTML, pos1) +
        Length(SearchList.Values['Search2']);
      pos3 := PosEx(SearchList.Values['Search3'], HTML, pos2);
      ParthnerID := copy(HTML, pos2, (pos3 - pos2));
      Debug('Copy partner ID = ' + ParthnerID);
      GetParthner(StrToInt(ParthnerID));
      // for next each
      Inc(count);
      pos1 := PosEx(SearchList.Values['Search1'], HTML, pos1 + 100);
    end;
  Except
    MessageBox(0, 'В данный момент сервера 1С-Битрикс не доступны.', PROG_NAME, MB_ICONINFORMATION);
  End;
  SearchList.Free;
end;

procedure TThreadPL.GetParthner(ParthnerID: Integer);
var
  HTML, localUrl, P_CODE, P_NAME, P_SITE: String;
  SearchList: TStringList;
  pos1, pos2, count: Integer;
  GoodHttpGet: boolean;
begin
  Debug('GetParthner - start');
  Debug('Partner ID = ' + IntToStr(ParthnerID));
  GoodHttpGet := True;
  SearchList := TStringList.Create;
  localUrl := urlPartherDetail1 + IntToStr(ParthnerID) + urlPartherDetail2;
  Debug('localUrl = ' + localUrl);

  IdHTTP1 := TIdHTTP.Create(nil);
  IdHTTP1.ReadTimeout := 10000;
  Try
    HTML := IdHTTP1.Get(localUrl);
    IdHTTP1.Free;
  Except
    GoodHttpGet := False;
    MessageBox(0, 'В данный момент сервера 1С-Битрикс не доступны.', PROG_NAME, MB_ICONINFORMATION);
  End;

  if GoodHttpGet = True then
  begin
    // get code
    SearchList.CommaText :=
      'Search1=mp_sc_list_solutions, Search2=marketplace.1c-bitrix.ru/solutions/, Search3=.';
    pos1 := PosEx(SearchList.Values['Search1'], HTML, 1000);
    if pos1 > 0 then
    begin
      pos1 := pos1 + Length(SearchList.Values['Search1']);
      pos1 := PosEx(SearchList.Values['Search2'], HTML, pos1);
      if pos1 > 0 then
      begin
        pos1 := pos1 + Length(SearchList.Values['Search2']);
        pos2 := PosEx(SearchList.Values['Search3'], HTML, pos1);
        P_CODE := copy(HTML, pos1, (pos2 - pos1));
      end
      else
      begin
        P_CODE := '';
      end;
    end;

    // get name
    SearchList.CommaText := 'Search1=<h1>, Search2=>, Search3=</';
    pos1 := PosEx(SearchList.Values['Search1'], HTML, 1000);
    if pos1 > 0 then
    begin
      pos1 := pos1 + Length(SearchList.Values['Search1']);
      pos1 := PosEx(SearchList.Values['Search2'], HTML, pos1) +
        Length(SearchList.Values['Search2']);
      pos2 := PosEx(SearchList.Values['Search3'], HTML, pos1);
      P_NAME := copy(HTML, pos1, (pos2 - pos1));
    end;

    // get site
    SearchList.CommaText := 'Search1=pt_card_hd_link, Search2=_blank">, Search3=</';
    pos1 := PosEx(SearchList.Values['Search1'], HTML, 1000);
    if pos1 > 0 then
    begin
      pos1 := pos1 + Length(SearchList.Values['Search1']);
      pos1 := PosEx(SearchList.Values['Search2'], HTML, pos1) +
        Length(SearchList.Values['Search2']);
      pos2 := PosEx(SearchList.Values['Search3'], HTML, pos1);
      P_SITE := copy(HTML, pos1, (pos2 - pos1));
    end;

    SearchList.Free;

    // result
    ParthnerData := TStringList.Create();
    ParthnerData.Add(Format('%s=%s', ['P_BITRIX_ID', IntToStr(ParthnerID)]));
    ParthnerData.Add(Format('%s=%s', ['P_CODE', P_CODE]));
    ParthnerData.Add(Format('%s=%s', ['P_NAME', P_NAME]));
    ParthnerData.Add(Format('%s=%s', ['P_SITE', P_SITE]));

    GetParthnerDateInfo(ParthnerID, HTML);
  end
  else
  begin
    Finish := True;
    Synchronize(SetProgress);
  end;

end;

procedure TThreadPL.GetParthnerDateInfo(ParthnerID: Integer; HTML: String);
var
  P_DATE_INFO, P_COUNT_EMPLOYEE_STRING, P_COUNT_CERTIFICATE_STRING,
    P_COUNT_PROJECT_STRING, tmp, tmp2: String;
  SearchList: TStringList;
  pos1, pos2, count, P_COUNT_MODULE, P_COUNT_MODULE_B24, P_COUNT_EMPLOYEE,
    P_COUNT_CERTIFICATE, P_COUNT_PROJECT: Integer;
begin
  Debug('GetParthnerDateInfo - start');
  SearchList := TStringList.Create;

  // get count module
  count := 1;
  P_COUNT_MODULE := 0;
  SearchList.CommaText := 'Search1=mp_sc_ls_container';
  pos1 := PosEx(SearchList.Values['Search1'], HTML, 1000);
  if pos1 > 0 then
  begin
    Repeat
      Inc(P_COUNT_MODULE);
      // for next each
      Inc(count);
      pos1 := PosEx(SearchList.Values['Search1'], HTML, pos1 + 100);
    Until (pos1 < 1) OR (count > 500);
  end;

  // get count module b24
  count := 1;
  P_COUNT_MODULE_B24 := 0;
  SearchList.CommaText := 'Search1=bitrix24.ru/apps/?app';
  pos1 := PosEx(SearchList.Values['Search1'], HTML, 1000);
  if pos1 > 0 then
  begin
    Repeat
      Inc(P_COUNT_MODULE_B24);
      // for next each
      Inc(count);
      pos1 := PosEx(SearchList.Values['Search1'], HTML, pos1 + 100);
    Until (pos1 < 1) OR (count > 500);
  end;
  if P_COUNT_MODULE_B24 > 0 then
  begin
    P_COUNT_MODULE_B24 := Round(P_COUNT_MODULE_B24/3);
    P_COUNT_MODULE := P_COUNT_MODULE-P_COUNT_MODULE_B24;
  end;

  // get count employee
  count := 1;
  P_COUNT_EMPLOYEE := 0;
  P_COUNT_EMPLOYEE_STRING := '';
  SearchList.CommaText :=
    'Search1=pt_card_info, Search2=center">, Search3=</td, Search4=num_';
  pos1 := PosEx(SearchList.Values['Search1'], HTML, 1000) +
    Length(SearchList.Values['Search1']);
  pos1 := PosEx(SearchList.Values['Search2'], HTML, pos1) +
    Length(SearchList.Values['Search1']);
  pos2 := PosEx(SearchList.Values['Search3'], HTML, pos1);
  tmp := copy(HTML, pos1, (pos2 - pos1));
  tmp := DeleteLineBreaks(tmp);
  pos1 := PosEx(SearchList.Values['Search4'], tmp, 1);
  if pos1 > 0 then
  begin
    pos1 := pos1 + Length(SearchList.Values['Search4']);
    Repeat
      tmp2 := copy(tmp, pos1, 1);
      P_COUNT_EMPLOYEE_STRING := P_COUNT_EMPLOYEE_STRING + tmp2;
      // for next each
      Inc(count);
      pos1 := PosEx(SearchList.Values['Search4'], tmp, pos1);
      if pos1 > 0 then
      begin
        pos1 := pos1 + Length(SearchList.Values['Search4']);
      end;
    Until (pos1 < 1) OR (count > 5);
  end;
  if P_COUNT_EMPLOYEE_STRING <> '' then
  begin
    P_COUNT_EMPLOYEE := StrToInt(P_COUNT_EMPLOYEE_STRING);
  end;

  // get count sertificater
  count := 1;
  P_COUNT_CERTIFICATE := 0;
  P_COUNT_CERTIFICATE_STRING := '';
  pos1 := PosEx(SearchList.Values['Search1'], HTML, 1000) +
    Length(SearchList.Values['Search1']);
  pos1 := PosEx(SearchList.Values['Search2'], HTML, pos1) +
    Length(SearchList.Values['Search1']);
  pos1 := PosEx(SearchList.Values['Search2'], HTML, pos1) +
    Length(SearchList.Values['Search1']);
  pos2 := PosEx(SearchList.Values['Search3'], HTML, pos1);
  tmp := copy(HTML, pos1, (pos2 - pos1));
  tmp := DeleteLineBreaks(tmp);
  pos1 := PosEx(SearchList.Values['Search4'], tmp, 1);
  if pos1 > 0 then
  begin
    pos1 := pos1 + Length(SearchList.Values['Search4']);
    Repeat
      tmp2 := copy(tmp, pos1, 1);
      P_COUNT_CERTIFICATE_STRING := P_COUNT_CERTIFICATE_STRING + tmp2;
      // for next each
      Inc(count);
      pos1 := PosEx(SearchList.Values['Search4'], tmp, pos1);
      if pos1 > 0 then
      begin
        pos1 := pos1 + +Length(SearchList.Values['Search4']);
      end;
    Until (pos1 < 1) OR (count > 5);
  end;
  if P_COUNT_CERTIFICATE_STRING <> '' then
  begin
    P_COUNT_CERTIFICATE := StrToInt(P_COUNT_CERTIFICATE_STRING);
  end;

  // get count project
  count := 1;
  P_COUNT_PROJECT := 0;
  P_COUNT_PROJECT_STRING := '';
  pos1 := PosEx(SearchList.Values['Search1'], HTML, 1000) +
    Length(SearchList.Values['Search1']);
  pos1 := PosEx(SearchList.Values['Search2'], HTML, pos1) +
    Length(SearchList.Values['Search1']);
  pos1 := PosEx(SearchList.Values['Search2'], HTML, pos1) +
    Length(SearchList.Values['Search1']);
  pos1 := PosEx(SearchList.Values['Search2'], HTML, pos1) +
    Length(SearchList.Values['Search1']);
  pos2 := PosEx(SearchList.Values['Search3'], HTML, pos1);
  tmp := copy(HTML, pos1, (pos2 - pos1));
  tmp := DeleteLineBreaks(tmp);
  pos1 := PosEx(SearchList.Values['Search4'], tmp, 1);
  if pos1 > 0 then
  begin
    pos1 := pos1 + Length(SearchList.Values['Search4']);
    Repeat
      tmp2 := copy(tmp, pos1, 1);
      P_COUNT_PROJECT_STRING := P_COUNT_PROJECT_STRING + tmp2;
      // for next each
      Inc(count);
      pos1 := PosEx(SearchList.Values['Search4'], tmp, pos1);
      if pos1 > 0 then
      begin
        pos1 := pos1 + +Length(SearchList.Values['Search4']);
      end;
    Until (pos1 < 1) OR (count > 5);
  end;
  if P_COUNT_PROJECT_STRING <> '' then
  begin
    P_COUNT_PROJECT := StrToInt(P_COUNT_PROJECT_STRING);
  end;

  // result
  ParthnerDataInfo := TStringList.Create();
  ParthnerDataInfo.Add(Format('%s=%s', ['P_ID', IntToStr(ParthnerID)]));
  ParthnerDataInfo.Add(Format('%s=%s', ['P_DATE_INFO', DateToStr(Now)]));
  ParthnerDataInfo.Add(Format('%s=%s', ['P_COUNT_MODULE', IntToStr(P_COUNT_MODULE)]));
  ParthnerDataInfo.Add(Format('%s=%s', ['P_COUNT_MODULE_B24', IntToStr(P_COUNT_MODULE_B24)]));
  ParthnerDataInfo.Add(Format('%s=%s', ['P_COUNT_EMPLOYEE', IntToStr(P_COUNT_EMPLOYEE)]));
  ParthnerDataInfo.Add(Format('%s=%s', ['P_COUNT_CERTIFICATE', IntToStr(P_COUNT_CERTIFICATE)]));
  ParthnerDataInfo.Add(Format('%s=%s', ['P_COUNT_PROJECT', IntToStr(P_COUNT_PROJECT)]));

  Inc(ResultCount);

  Synchronize(SetProgress);

end;

procedure TThreadPL.Execute;
begin
  Debug('Execute');
  { Place thread code here }
  if Mode = 1 then
  begin
    if ParthnerCount > 0 then
    begin
      GetPageCountAndStart();
    end;
  end
  else
  begin
    if PID > 0 then
    begin
      GetParthner(PID);
    end;
  end;
end;

procedure TThreadPL.SetProgress;
begin
  Debug('SetProgress');
  { Place synchronize code here }
  Try
    if (ParthnerDataInfo <> nil) and (ParthnerDataInfo.Count > 0) then
    begin
      MainForm.ProgStatus( 'Pregress: processed ' + IntToStr(ResultCount) + ' | PID[' + ParthnerDataInfo.Values['P_ID'] + ']' );
    end;
    if Mode = 1 then
    begin
      if (ParthnerData <> nil) and (ParthnerDataInfo <> nil) and (ParthnerData.Count > 0) and (ParthnerDataInfo.Count > 0) then
      begin
        MainForm.PLAndPLInfoAddRow(ParthnerData, ParthnerDataInfo);
        ParthnerData.Free;
        ParthnerDataInfo.Free;
      end;
    end
    else
    begin
      if (ParthnerDataInfo <> nil) and (ParthnerDataInfo.Count > 0) then
      begin
        MainForm.PLInfoAddRow(ParthnerDataInfo);
        ParthnerDataInfo.Free;
      end;
      Finish := True;
    end;
  Finally
    if Finish then
    begin
      MainForm.BlockButtons(False);
      MainForm.TrayBalloonHint('Сбор данных завершен.');
      Debug(' ---------------------------------------------- ');
    end;
  End;
end;

procedure TThreadPL.Debug(mes: String);
begin
  if DebugMode = True then
  begin
    DebugString := 'TThreadPL: ' + mes;
    Synchronize(DebugSetProgress);
  end;
end;

procedure TThreadPL.DebugSetProgress;
begin
  MainForm.Debug(DebugString);
end;

end.
