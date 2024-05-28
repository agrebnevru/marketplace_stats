unit MLThread;

interface

uses
  System.Classes, SysUtils, StrUtils,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TThreadML = class(TThread)
  private
    { Private declarations }
    IdHTTP1: TIdHTTP;
    Mode, PartnerID, ResultCount, CalledFrom: Integer;
    DebugString, PartnerCode, GlobalModuleCode: String;
    ModuleData: TStrings;
    DebugMode, Finish: boolean;
    procedure GetPageWithModuleList();
    procedure GetPageWithTop30MP();
    procedure GetModuleInfo(ModuleCode: String; Index: Integer);
    procedure SetProgress;
    // debug mode
    procedure Debug(mes: String);
    procedure DebugSetProgress;
  protected
    procedure Execute; override;
  public
    constructor Create(aDebugMode: boolean; aCalledFrom: Integer; aMode, aPartnerID: Integer; aPartnerCode, aModuleCode: String);
  end;

implementation

uses Dialogs, windows, MPStats;

const
  urlPartherDetail1 = 'http://www.1c-bitrix.ru/partners/';
  urlPartherDetail2 = '.php?offcomposite=Y';
  urlModuleDetail1 = 'http://marketplace.1c-bitrix.ru/solutions/';
  urlModuleDetail2 = '/?update_sys_new=Y';
  urlModuleTop30MP = 'http://marketplace.1c-bitrix.ru/solutions/?category=14&subcategory=&PAYMENT_SHOW=NOT_FREE';

  { TThreadML }

constructor TThreadML.Create(aDebugMode: boolean; aCalledFrom: Integer; aMode, aPartnerID: Integer; aPartnerCode, aModuleCode: String);
begin
  inherited Create(True);
  DebugMode := aDebugMode;
  {
  CalledFrom:
  1 - AutoGet (AG)
  2 - Top30 marketplace (Top30MP)
  }
  CalledFrom := aCalledFrom;
  ResultCount := 0;
  Finish := False;
  PartnerID := aPartnerID;
  PartnerCode := aPartnerCode;
  {
  Mode:
  1 - Get all modules and module info
  2 - Get one module info
  3 - Get top internet-magazine
  }
  Mode := aMode;
  if Mode = 2 then
  begin
    GlobalModuleCode := aModuleCode;
  end;
end;

procedure TThreadML.GetPageWithModuleList();
var
  HTML, localUrl, ModuleCode: String;
  SearchList, ModuleCodeList: TStringList;
  pos1, pos2, count, i: Integer;
begin
  Debug('GetPageWithModuleList - start');
  SearchList := TStringList.Create;
  ModuleCodeList := TStringList.Create;
  localUrl := urlPartherDetail1 + IntToStr(PartnerID) + urlPartherDetail2;
  Debug('localUrl = ' + localUrl);

  IdHTTP1 := TIdHTTP.Create(nil);
  IdHTTP1.ReadTimeout := 10000;
  Try
    HTML := IdHTTP1.Get(localUrl);
    IdHTTP1.Free;
    // get module list
    count := 0;
    SearchList.CommaText := 'Search1=http://marketplace.1c-bitrix.ru/solutions/, Search2=/';
    pos1 := PosEx(SearchList.Values['Search1'], HTML, 1000);
    while (pos1 > 0) AND (count < 500) do
    begin
      pos1 := pos1 + Length(SearchList.Values['Search1']);
      pos2 := PosEx(SearchList.Values['Search2'], HTML, pos1);
      ModuleCode := copy(HTML, pos1, (pos2-pos1));
      if ModuleCodeList.IndexOf(ModuleCode) < 0 then
      begin
        ModuleCodeList.Add(ModuleCode);
      end;
      // for next each
      Inc(count);
      pos1 := PosEx(SearchList.Values['Search1'], HTML, pos1 + 100);
    end;
    // go next
    for i := 0 to ModuleCodeList.Count-1 do
    begin
      GetModuleInfo(ModuleCodeList[i],0);
    end;
  Except
    MessageBox(0, 'В данный момент сервера 1С-Битрикс не доступны.', PROG_NAME, MB_ICONINFORMATION);
  End;
  ModuleCodeList.Free;
  Finish := True;
  Synchronize(SetProgress);
end;

procedure TThreadML.GetPageWithTop30MP();
var
  HTML, localUrl, ModuleCode: String;
  SearchList, ModuleCodeList: TStringList;
  pos1, pos2, count, i: Integer;
begin
  Debug('GetPageWithTop30MP - start');
  SearchList := TStringList.Create;
  ModuleCodeList := TStringList.Create;
  localUrl := urlModuleTop30MP;
  Debug('localUrl = ' + localUrl);

  IdHTTP1 := TIdHTTP.Create(nil);
  IdHTTP1.ReadTimeout := 10000;
  Try
    HTML := IdHTTP1.Get(localUrl);
    IdHTTP1.Free;
    // get module list
    count := 0;
    SearchList.CommaText := 'Search1=item-wrap, Search2=/solutions/, Search3=/';
    pos1 := PosEx(SearchList.Values['Search1'], HTML, 1000);
    pos1 := PosEx(SearchList.Values['Search2'], HTML, pos1+Length(SearchList.Values['Search1']));
    while (pos1 > 0) AND (count < 30) do
    begin
      pos1 := pos1 + Length(SearchList.Values['Search2']);
      pos2 := PosEx(SearchList.Values['Search3'], HTML, pos1);
      ModuleCode := copy(HTML, pos1, (pos2-pos1));
      if ModuleCodeList.IndexOf(ModuleCode) < 0 then
      begin
        ModuleCodeList.Add(ModuleCode);
      end;
      // for next each
      Inc(count);
      pos1 := PosEx(SearchList.Values['Search1'], HTML, pos1 + 100);
      pos1 := PosEx(SearchList.Values['Search2'], HTML, pos1 + Length(SearchList.Values['Search1']));
    end;
    // go next
    for i := 0 to ModuleCodeList.Count-1 do
    begin
      GetModuleInfo(ModuleCodeList[i],(i+1));
    end;
  Except
    MessageBox(0, 'В данный момент сервера 1С-Битрикс не доступны.', PROG_NAME, MB_ICONINFORMATION);
  End;
  ModuleCodeList.Free;
  Finish := True;
  Synchronize(SetProgress);

end;

procedure TThreadML.GetModuleInfo(ModuleCode: String; Index: Integer);
var
  HTML, localUrl, M_NAME, M_FREE, M_OLD_PRICE, M_PRICE, M_DATE,
    M_VERSION, M_INSTALL_COUNT, M_DEMO_LINK: String;
  SearchList: TStringList;
  pos1, pos2: Integer;
  GoodHttpGet: boolean;
begin
  Debug('GetModuleInfo - start');
  Debug('Module code = ' + ModuleCode);
  GoodHttpGet := True;
  SearchList := TStringList.Create;
  localUrl := urlModuleDetail1 + ModuleCode + urlModuleDetail2;
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
    // check module active
    SearchList.CommaText := 'Search1=<name>';
    pos1 := PosEx(SearchList.Values['Search1'], HTML, 1);
    if pos1 > 0 then
    begin
      // get PartnerID if empty
      if PartnerID < 1 then
      begin
        Debug( 'PartnerID is empty' );
        SearchList.CommaText := 'Search1=1c-bitrix.ru/partners/, Search2=.php';
        pos1 := PosEx(SearchList.Values['Search1'], HTML, 1) + Length(SearchList.Values['Search1']);
        pos2 := PosEx(SearchList.Values['Search2'], HTML, pos1);
        PartnerID := StrToInt( copy(HTML, pos1, (pos2 - pos1)) );
        Debug( 'PartnerID = ' + IntToStr(PartnerID) );
      end;

      // get module name
      SearchList.CommaText := 'Search1=<name>, Search2=</name>';
      pos1 := PosEx(SearchList.Values['Search1'], HTML, 1) + Length(SearchList.Values['Search1']);
      pos2 := PosEx(SearchList.Values['Search2'], HTML, pos1);
      M_NAME := copy(HTML, pos1, (pos2 - pos1));

      // get module is free
      SearchList.CommaText := 'Search1=<freeModule>, Search2=</freeModule>';
      pos1 := PosEx(SearchList.Values['Search1'], HTML, 1) + Length(SearchList.Values['Search1']);
      pos2 := PosEx(SearchList.Values['Search2'], HTML, pos1);
      M_FREE := copy(HTML, pos1, (pos2 - pos1));

      // get module old price
      SearchList.CommaText := 'Search1=<oldPrice>, Search2=</oldPrice>';
      pos1 := PosEx(SearchList.Values['Search1'], HTML, 1) + Length(SearchList.Values['Search1']);
      pos2 := PosEx(SearchList.Values['Search2'], HTML, pos1);
      M_OLD_PRICE := copy(HTML, pos1, (pos2 - pos1));
      pos1 := PosEx(' ', M_OLD_PRICE, 1);
      if pos1 > 0 then
      begin
        M_OLD_PRICE := copy(M_OLD_PRICE, 0, pos1);
      end;

      // get module price
      SearchList.CommaText := 'Search1=<price>, Search2=</price>';
      pos1 := PosEx(SearchList.Values['Search1'], HTML, 1) + Length(SearchList.Values['Search1']);
      pos2 := PosEx(SearchList.Values['Search2'], HTML, pos1);
      M_PRICE := copy(HTML, pos1, (pos2 - pos1));
      pos1 := PosEx(' ', M_PRICE, 1);
      if pos1 > 0 then
      begin
        M_PRICE := copy(M_PRICE, 0, pos1);
      end;

      // get module date
      SearchList.CommaText := 'Search1=<date>, Search2=</date>';
      pos1 := PosEx(SearchList.Values['Search1'], HTML, 1) + Length(SearchList.Values['Search1']);
      pos2 := PosEx(SearchList.Values['Search2'], HTML, pos1);
      M_DATE := copy(HTML, pos1, (pos2 - pos1));

      // get module version
      SearchList.CommaText := 'Search1=<version>, Search2=</version>';
      pos1 := PosEx(SearchList.Values['Search1'], HTML, 1) + Length(SearchList.Values['Search1']);
      pos2 := PosEx(SearchList.Values['Search2'], HTML, pos1);
      M_VERSION := copy(HTML, pos1, (pos2 - pos1));

      // get module install count
      SearchList.CommaText := 'Search1=<instCnt>, Search2=</instCnt>';
      pos1 := PosEx(SearchList.Values['Search1'], HTML, 1) + Length(SearchList.Values['Search1']);
      pos2 := PosEx(SearchList.Values['Search2'], HTML, pos1);
      M_INSTALL_COUNT := copy(HTML, pos1, (pos2 - pos1));

      // get module demo link
      SearchList.CommaText := 'Search1=<demoLink>, Search2=</demoLink>';
      pos1 := PosEx(SearchList.Values['Search1'], HTML, 1) + Length(SearchList.Values['Search1']);
      pos2 := PosEx(SearchList.Values['Search2'], HTML, pos1);
      M_DEMO_LINK := copy(HTML, pos1, (pos2 - pos1));

      // Result
      ModuleData := TStringList.Create();
      ModuleData.Add(Format('%s=%s', ['P_ID', IntToStr(PartnerID)]));
      ModuleData.Add(Format('%s=%s', ['M_CODE', ModuleCode]));
      ModuleData.Add(Format('%s=%s', ['M_DATA_INFO', DateToStr(Now)]));
      ModuleData.Add(Format('%s=%s', ['M_NAME', M_NAME]));
      ModuleData.Add(Format('%s=%s', ['M_FREE', M_FREE]));
      ModuleData.Add(Format('%s=%s', ['M_OLD_PRICE', M_OLD_PRICE]));
      ModuleData.Add(Format('%s=%s', ['M_PRICE', M_PRICE]));
      ModuleData.Add(Format('%s=%s', ['M_DATE', M_DATE]));
      ModuleData.Add(Format('%s=%s', ['M_VERSION', M_VERSION]));
      ModuleData.Add(Format('%s=%s', ['M_INSTALL_COUNT', M_INSTALL_COUNT]));
      ModuleData.Add(Format('%s=%s', ['M_DEMO_LINK', M_DEMO_LINK]));
      if Index > 0 then
      begin
        ModuleData.Add(Format('%s=%s', ['M_TOP_PLACE', IntToStr(Index)]));
      end;
    end;

    Inc(ResultCount);

    Synchronize(SetProgress);
  end
  else
  begin
    Finish := True;
    Synchronize(SetProgress);
  end;

end;

procedure TThreadML.Execute;
begin
  Debug('Execute');
  { Place thread code here }
  {
  Mode:
  1 - Get all modules and module info
  2 - Get one module info
  3 - Get top internet-magazine
  }
  if Mode = 2 then
  begin
    Debug('Mode = 2 - Get one module info');
    if GlobalModuleCode <> '' then
    begin
      GetModuleInfo(GlobalModuleCode, 0);
    end;
  end
  else if Mode = 3 then
  begin
    Debug('Mode = 3 - Get top internet-magazine');
    GetPageWithTop30MP();
  end
  else
  begin
    Debug('Mode = 1 - Get all modules and module info');
    if PartnerID > 0 then
    begin
      GetPageWithModuleList();
    end;
  end;
end;

procedure TThreadML.SetProgress;
begin
  Debug('SetProgress');
  { Place synchronize code here }
  Try
    if ModuleData.Count > 0 then
    begin
      MainForm.ProgStatus( 'Pregress: processed ' + IntToStr(ResultCount) + ' | Module[' + ModuleData.Values['M_CODE'] + ']' );
      MainForm.MLInfoAddRow(ModuleData);
    end;
    ModuleData.Free;
    if Mode = 2 then
    begin
      Finish := True;
    end;
  Finally
    if CalledFrom = 1 then
    begin
      Debug('CalledFrom = 1 - AutoGet (AG)');
      MainForm.AGStartGetProcess(PartnerID,GlobalModuleCode);
    end;
    if Finish then
    begin
      if CalledFrom = 2 then
      begin
        Debug('CalledFrom = 2 - Top30 marketplace (Top30MP)');
        MainForm.Top30MPAutoGetFinish();
      end;
      if CalledFrom = 0 then
      begin
        MainForm.BlockButtons(False);
        MainForm.TrayBalloonHint('Сбор данных завершен.');
      end;
    end;
  End;
end;

procedure TThreadML.Debug(mes: String);
begin
  if DebugMode = True then
  begin
    DebugString := 'TThreadML: ' + mes;
    Synchronize(DebugSetProgress);
  end;
end;

procedure TThreadML.DebugSetProgress;
begin
  MainForm.Debug(DebugString);
end;

end.
