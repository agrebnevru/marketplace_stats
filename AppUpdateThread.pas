unit AppUpdateThread;

interface

uses
  System.Classes, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP;

type
  TThreadAppUpdate = class(TThread)
  private
    { Private declarations }
    IdHTTP1: TIdHTTP;
    DebugMode, Finish: boolean;
    DebugString, Version: String;
    procedure SetProgress;
    // debug mode
    procedure Debug(mes: String);
    procedure DebugSetProgress;
  protected
    procedure Execute; override;
  public
    constructor Create(aDebugMode: boolean);
  end;

implementation

uses Dialogs, SysUtils, StrUtils, windows, MPStats;

const
  url = 'http://imyie.ru/mpstats/version.txt';

{ TThreadAppUpdate }

constructor TThreadAppUpdate.Create(aDebugMode: boolean);
begin
  inherited Create(True);
  DebugMode := aDebugMode;
  Finish := False;
end;

procedure TThreadAppUpdate.Execute;
begin
  { Place thread code here }
  Debug('Execute');

  IdHTTP1 := TIdHTTP.Create(nil);
  IdHTTP1.ReadTimeout := 10000;
  Try
    Version := IdHTTP1.Get(url);
    IdHTTP1.Free;
    Finish := True;
  Except
    //
    Version := '0000';
  End;

  Synchronize(SetProgress);

end;

procedure TThreadAppUpdate.SetProgress;
begin
  Debug('SetProgress');
  { Place synchronize code here }
  Try
    MainForm.CheckVersion(Version);
  Finally
    //
  End;
end;

procedure TThreadAppUpdate.Debug(mes: String);
begin
  if DebugMode = True then
  begin
    DebugString := 'TThreadAppUpdate: ' + mes;
    Synchronize(DebugSetProgress);
  end;
end;

procedure TThreadAppUpdate.DebugSetProgress;
begin
  MainForm.Debug(DebugString);
end;

end.
