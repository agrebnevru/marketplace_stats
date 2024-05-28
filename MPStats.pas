unit MPStats;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ImgList, Vcl.ComCtrls,
  Vcl.Menus, Data.DB, Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  DateUtils, IniFiles, ShellApi, System.ImageList;

type
  TMainForm = class(TForm)
    TrayIcon: TTrayIcon;
    ProgImages: TImageList;
    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    Options1: TMenuItem;
    MainMenuOptions: TMenuItem;
    N1: TMenuItem;
    MainMenuExit: TMenuItem;
    About: TMenuItem;
    MainPageControl: TPageControl;
    TabSheetAll: TTabSheet;
    PanelAllFilter: TPanel;
    PanelAllMain: TPanel;
    DBGridAll: TDBGrid;
    DataSourceAll: TDataSource;
    ADOConn: TADOConnection;
    ADOQueryAll: TADOQuery;
    TrayPopupMenu: TPopupMenu;
    TrayPopupMenuExit: TMenuItem;
    PanelAllFilterLeft: TPanel;
    DateTimePickerAllFrom: TDateTimePicker;
    StaticTextALLDateFrom: TStaticText;
    StaticTextAllDateTo: TStaticText;
    DateTimePickerAllTo: TDateTimePicker;
    PanelAllFilterRight: TPanel;
    ButtonAllFilter: TButton;
    ButtonAllGetData: TButton;
    PopMenuAll: TPopupMenu;
    PMAll_Delete: TMenuItem;
    TimerStatusBar: TTimer;
    MainMenuActions: TMenuItem;
    MainMenuActionsGetAll: TMenuItem;
    TabSheetParthnersList: TTabSheet;
    PanelPLFilter: TPanel;
    PanelPLMain: TPanel;
    DBGridPL: TDBGrid;
    PanelPLFilterLeft: TPanel;
    StaticTextPLParCode: TStaticText;
    StaticTextPLPartName: TStaticText;
    Panel1: TPanel;
    ButtonPLFilter: TButton;
    ButtonPLGetData: TButton;
    EditPLParCode: TEdit;
    EditPLParName: TEdit;
    DataSourcePL: TDataSource;
    ADOQueryPL: TADOQuery;
    PopMenuPL: TPopupMenu;
    N2: TMenuItem;
    TrayPopupMenuShowHide: TMenuItem;
    PMPL_Delete: TMenuItem;
    PMPL_PLInfoGetData: TMenuItem;
    PMPL_ShowInfo: TMenuItem;
    PMPL_ShowModuleList: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    PMPL_MLInfoGetData: TMenuItem;
    DataSourceAG: TDataSource;
    ADOQueryAG: TADOQuery;
    PopMenuAG: TPopupMenu;
    PMAG_Refresh: TMenuItem;
    N6: TMenuItem;
    PMAG_Delete: TMenuItem;
    PanelDebugMode: TPanel;
    TabSheetDebug: TTabSheet;
    MemoDebug: TMemo;
    N3: TMenuItem;
    PMAG_ModuleInfo: TMenuItem;
    PanelAppUpdate: TPanel;
    PMPL_GoToSite: TMenuItem;
    PMPL_GoToPartnerCard: TMenuItem;
    DataSourceTopMP: TDataSource;
    ADOQueryTopMP: TADOQuery;
    PopupMenuTopMP: TPopupMenu;
    TabSheetStats: TTabSheet;
    PageControlStats: TPageControl;
    TSAutoGet: TTabSheet;
    TSTopMP: TTabSheet;
    TSFullStats: TTabSheet;
    PCAutoGet: TPageControl;
    TabSheetAutoGetPartnersInfo: TTabSheet;
    TabSheetAutoGetModulesInfo: TTabSheet;
    DBGridAG: TDBGrid;
    PanelAGFilter: TPanel;
    DBGridTopMP: TDBGrid;
    PanelTopMPFilter: TPanel;
    DBGridFS: TDBGrid;
    PanelFSFilter: TPanel;
    procedure MainMenuExitClick(Sender: TObject);
    procedure AboutClick(Sender: TObject);
    procedure TrayPopupMenuExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TrayIconDblClick(Sender: TObject);
    procedure ButtonAllFilterClick(Sender: TObject);
    procedure ButtonAllGetDataClick(Sender: TObject);
    procedure PMAll_DeleteClick(Sender: TObject);
    procedure TimerStatusBarTimer(Sender: TObject);
    procedure MainMenuActionsGetAllClick(Sender: TObject);
    procedure ButtonPLFilterClick(Sender: TObject);
    procedure TrayPopupMenuShowHideClick(Sender: TObject);
    procedure ButtonPLGetDataClick(Sender: TObject);
    procedure EditPLParCodeKeyPress(Sender: TObject; var Key: Char);
    procedure EditPLParNameKeyPress(Sender: TObject; var Key: Char);
    procedure PMPL_ShowInfoClick(Sender: TObject);
    procedure PMPL_PLInfoGetDataClick(Sender: TObject);
    procedure PMPL_MLInfoGetDataClick(Sender: TObject);
    procedure PMPL_ShowModuleListClick(Sender: TObject);
    procedure MainMenuOptionsClick(Sender: TObject);
    procedure PMAG_RefreshClick(Sender: TObject);
    procedure PMAG_ModuleInfoClick(Sender: TObject);
    procedure PanelAppUpdateClick(Sender: TObject);
    procedure PMPL_GoToPartnerCardClick(Sender: TObject);
    procedure PMPL_GoToSiteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    { Settings }
    function CheckIssetFileSettings(): boolean;
    procedure ApplySettingsToApplication();
    procedure PrepareApplication();
    { ALL }
    function ALLTodayAlreadyGet(): Boolean;
    procedure AllGetDataStartThread(CalledFromPL: Boolean);
    procedure AllGetData();
    procedure AllAddRow(Count: Integer);
    procedure AllApplyFilter();
    { Parthner list & Parthner Info }
    procedure PLAndPLInfoAddRow(ParthnerData, ParthnerDataInfo: TStrings);
    { Parthner list }
    function PLRowAlreadyIsset(PBitrixID: Integer): Boolean;
    function PLYesterdayAndTodayDifferentParCountAndAllIsset(): Integer;
    procedure PLGetDataStartThread(ParthnerCount: Integer);
    procedure PLOneGetDataStartThread(aPartnerID: Integer);
    procedure PLGetData();
    procedure PLApplyFilter();
    procedure PLAddRow(ParthnerData: TStrings);
    { Parthner list info }
    function PLInfoTodayAlreadyGet(ParthnerID: Integer): Boolean;
    procedure PLInfoAddRow(ParthnerDataInfo: TStrings);
    { Module list }
    function MLInfoTodayAlreadyGet(ParthnerID: Integer; ModuleCode: String): Boolean;
    procedure MLGetDataStartThread(ParthnerID: Integer; PartnerCode: String);
    procedure MLOneGetDataStartThread(ParthnerID: Integer; PartnerCode, ModuleCode: String);
    procedure MLInfoAddRow(ModuleDataInfo: TStrings);
    { One Module }
    procedure OneGetDataModuleStartThread(ParthnerID: Integer; PartnerCode, ModuleCode: String);
    { One Parthner }
    procedure OneGetDataParthnerStartThread(ParthnerID: Integer);
    { Get start }
    procedure AutoGetStart();
    { Top30 marketplace }
    procedure Top30MPAutoGetStart();
    procedure Top30MPAutoGetFinish();
    procedure Top30MPApplyFilter();
    { Auto Get }
    function AGAlreadyIssetModule(Code: String): boolean;
    function AGAlreadyIssetPartner(P_ID: Integer): boolean;
    function AGAlreadyIsset(IsPartnerOrModule: Integer; Code: String): boolean;
    procedure AGApplyFilter();
    procedure AGAutoGetStart();
    procedure AGStartGetProcess(PartnerID: Integer; LastModuleCode: String);
    procedure AGAutoGetFinish();
    procedure AGChangeAGModule(Code: String; P_ID: Integer);
    procedure AGChangeAGPartner(P_ID: Integer);
    procedure AGDeleteRowModule(Code: String);
    procedure AGAddRowModule(Code: String; P_ID: Integer);
    procedure AGDeleteRowPartner(P_ID: Integer);
    procedure AGAddRowPartner(P_ID: Integer);
    procedure AGAddRow(ModuleCode: String; P_ID: Integer);
    { AppUpdate }
    function GetMyVersion(Formated: Boolean): String;
    procedure CheckVersion(Version: String);
    procedure AppUpdateStartThread();
    { Other }
    procedure TrayBalloonHint(HintMessage: String);
    procedure ProgStatus(StatusMessage: String);
    procedure BlockButtons(block: Boolean);
    { Debug mode }
    procedure Debug(mes: String);
  end;

const
  PROG_NAME = 'MPStats';

var
  MainForm: TMainForm;
  DebugMode, YouCanClose, ApplyFiltersOnStart, AutoGetOn, Top30MP: Boolean;
  query, SettingsFilePath, DBFilePath: String;
  IniSettings: TIniFile;
  Count: Integer;

implementation

{$R *.dfm}

uses AllThread, PLThread, MLThread, AppUpdateThread,
    FormSettings, FormAbout, FormModuleList, FormModuleInfo, FormPartnerInfo;

{ Settings }
function TMainForm.CheckIssetFileSettings(): boolean;
var
  readedDbVer: Integer;
begin
  SettingsFilePath := ExtractFileDir(Application.ExeName) + '\settings.ini';
  if not FileExists(SettingsFilePath) then
  begin
    IniSettings := TiniFile.Create(SettingsFilePath);
    IniSettings.WriteString('dbfile','path','');
    IniSettings.WriteInteger('dbfile','db_version',1);
  end
  else
  begin
    IniSettings := TiniFile.Create(SettingsFilePath);
    readedDbVer := IniSettings.ReadInteger('dbfile','db_version',0);
    if readedDbVer < 1 then
    begin
      IniSettings.WriteInteger('dbfile','db_version',1);
    end;
  end;
  Result := True;
end;

procedure TMainForm.ApplySettingsToApplication();
begin
  IniSettings := TiniFile.Create(SettingsFilePath);
  DBFilePath := IniSettings.ReadString('dbfile','path','');
  MainForm.TSAutoGet.TabVisible := IniSettings.ReadBool('settings','show_auto_get_tab',false);
  ApplyFiltersOnStart := IniSettings.ReadBool('settings','apply_filters_on_start',false);
  AutoGetOn := IniSettings.ReadBool('settings','auto_get_on',false);
  Top30MP := IniSettings.ReadBool('settings','top30_mp_on',false);
  // debug mode
  DebugMode := IniSettings.ReadBool('settings','bebug_mode',false);
  MainForm.PanelDebugMode.Visible := DebugMode;
  PanelDebugMode.Visible := DebugMode;
  TabSheetDebug.TabVisible := DebugMode;
  if DebugMode = True then
  begin
    MainForm.Caption := PROG_NAME + ' [DEBUG MODE ON]';
  end
  else
  begin
    MainForm.Caption := PROG_NAME;
  end;
end;

procedure TMainForm.PrepareApplication();
var
  connString: WideString;
  connPrivide: String;
  ErrorCode: Integer;
  Errors: TStringList;
begin
  YouCanClose := False;
  DebugMode := False;
  BlockButtons(true);
  MainPageControl.TabIndex := 0;
  ADOConn.Connected := False;
  TabSheetParthnersList.TabVisible := False;
  TSAutoGet.TabVisible := False;
  ErrorCode := -1;
  Errors := TStringList.Create;
  Errors.Add('Ошибка чтения файла настроек');
  Errors.Add('Отсутствует файл базы');
  Errors.Add('Отсутствует подключение к базе');
  if CheckIssetFileSettings() = True then
  begin
    ApplySettingsToApplication();
  end
  else
  begin
    ErrorCode := 0;
  end;
  if not FileExists(DBFilePath) then
  begin
    ErrorCode := 1;
  end;
  // no errors, try to connect to db
  if ErrorCode = -1 then
  begin
    connPrivide := 'Microsoft.Jet.OLEDB.4.0';
    connString := 'Provider=Microsoft.Jet.OLEDB.4.0;'
      + 'User ID=Admin;'
      + 'Data Source=' + DBFilePath + ';'
      + 'Mode=Share Deny None;'
      + 'Jet OLEDB:System database="";'
      + 'Jet OLEDB:Registry Path="";'
      + 'Jet OLEDB:Database Password="";'
      + 'Jet OLEDB:Engine Type=5;'
      + 'Jet OLEDB:Database Locking Mode=1;'
      + 'Jet OLEDB:Global Partial Bulk Ops=2;'
      + 'Jet OLEDB:Global Bulk Transactions=1;'
      + 'Jet OLEDB:New Database Password="";'
      + 'Jet OLEDB:Create System Database=False;'
      + 'Jet OLEDB:Encrypt Database=False;'
      + 'Jet OLEDB:Don''t Copy Locale on Compact=False;'
      + 'Jet OLEDB:Compact Without Replica Repair=False;'
      + 'Jet OLEDB:SFP=False;';
    try
      ADOConn.Provider := connPrivide;
      ADOConn.ConnectionString := connString;
      ADOConn.Mode := cmShareDenyNone;
      ADOConn.LoginPrompt := False;
      ADOConn.Connected := True;
      ADOConn.Execute('SELECT * FROM MPStats_all');
    except
      ErrorCode := 2;
      MessageBox(0, 'Отсутствует подключение к базе!' + #10#13 +
        'Проверьте правильность пути к файлу базы в настройках.', PROG_NAME, MB_ICONERROR);
    end;
  end;
  // no errors after connect to db
  if ErrorCode = -1 then
  begin
    TabSheetParthnersList.TabVisible := True;
    BlockButtons(false);
    ButtonAllFilter.Enabled := True;
    if ApplyFiltersOnStart = True then
    begin
      AllApplyFilter;
      PLApplyFilter;
      AGApplyFilter;
    end;
    if (AutoGetOn = True) or (Top30MP = True) then
    begin
      AutoGetStart();
    end;
    AppUpdateStartThread();
  end
  else
  begin
    StatusBar.SimpleText := Errors[ErrorCode];
  end;
end;

{ ALL }
function TMainForm.ALLTodayAlreadyGet(): Boolean;
var
  currentCnt: Integer;
begin
  query := 'SELECT count(*) AS CNT FROM MPStats_all WHERE DATE_INFO = DateValue('''
    + DateToStr(Now) + ''')';
  ADOQueryAll.SQL.Clear;
  ADOQueryAll.SQL.Text := query;
  try
    ADOQueryAll.open;
    currentCnt := ADOQueryAll.FieldByName('CNT').AsInteger;
  finally
    ADOQueryAll.Close;
  end;
  AllApplyFilter;
  if currentCnt < 1 then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

procedure TMainForm.AllGetDataStartThread(CalledFromPL: Boolean);
var
  ThreadA: TThreadAll;
begin
  ThreadA := TThreadAll.Create(DebugMode, CalledFromPL);
  ThreadA.FreeOnTerminate := True;
  ThreadA.Priority := tpNormal;
  ThreadA.Start;
end;

procedure TMainForm.AllGetData();
begin
  BlockButtons(true);
  if ALLTodayAlreadyGet = False then
  begin
    AllGetDataStartThread(False);
  end
  else
  begin
    MessageBox(0, 'Сегодня информация уже собиралась!' + #10#13 +
      'Не будим напрягать Битрикс!', PROG_NAME, MB_ICONINFORMATION);
    BlockButtons(False);
  end;
end;

procedure TMainForm.AllAddRow(Count: Integer);
begin
  query := 'INSERT INTO MPStats_all(DATE_INFO,COUNT_PARTHNERS) VALUES(''' +
    DateToStr(Now) + ''', ' + IntToStr(Count) + ')';
  ADOQueryAll.SQL.Clear;
  ADOQueryAll.SQL.Add(query);
  ADOQueryAll.ExecSQL;
  AllApplyFilter;
end;

procedure TMainForm.AllApplyFilter();
begin
  query := 'SELECT * FROM MPStats_all WHERE DATE_INFO BETWEEN DateValue("'
    + DateToStr(DateTimePickerAllFrom.Date) + '") and DateValue("'
    + DateToStr(DateTimePickerAllTo.Date) + '")'
    + ' ORDER BY DATE_INFO DESC';
  ADOQueryAll.SQL.Clear;
  ADOQueryAll.SQL.Add(query);
  ADOQueryAll.open;
end;

procedure TMainForm.PMAll_DeleteClick(Sender: TObject);
begin
  ADOQueryAll.Delete;
end;

procedure TMainForm.ButtonAllFilterClick(Sender: TObject);
begin
  AllApplyFilter;
end;

procedure TMainForm.ButtonAllGetDataClick(Sender: TObject);
begin
  AllGetData;
end;

{ Parthner list & Parthner Info }
procedure TMainForm.PLAndPLInfoAddRow(ParthnerData, ParthnerDataInfo : TStrings);
begin
  PLAddRow(ParthnerData);
  PLInfoAddRow(ParthnerDataInfo);
end;

{ Parthner list }
function TMainForm.PLRowAlreadyIsset(PBitrixID: Integer): Boolean;
var
  currentCnt: Integer;
begin
  currentCnt := 0;
  query := 'SELECT count(*) AS CNT FROM MPStats_parthners WHERE ('
  + 'P_BITRIX_ID = ' + IntToStr(PBitrixID)
  + ')';
  ADOQueryPL.SQL.Clear;
  ADOQueryPL.SQL.Text := query;
  try
    ADOQueryPL.open;
    currentCnt := ADOQueryPL.FieldByName('CNT').AsInteger;
  finally
    ADOQueryPL.Close;
  end;
  PLApplyFilter;
  if currentCnt < 1 then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

function TMainForm.PLYesterdayAndTodayDifferentParCountAndAllIsset(): Integer;
var
  cntYesterday, cntToday, cntPL: Integer;
begin
  // yesterday
  query := 'SELECT COUNT_PARTHNERS FROM MPStats_all WHERE DATE_INFO = DateValue("'
    + DateToStr(Yesterday) + '")';
  ADOQueryAll.SQL.Clear;
  ADOQueryAll.SQL.Text := query;
  try
    ADOQueryAll.open;
    cntYesterday := ADOQueryAll.FieldByName('COUNT_PARTHNERS').AsInteger;
  finally
    ADOQueryAll.Close;
  end;
  // today
  query := 'SELECT COUNT_PARTHNERS FROM MPStats_all WHERE DATE_INFO = DateValue("'
    + DateToStr(Now) + '")';
  ADOQueryAll.SQL.Clear;
  ADOQueryAll.SQL.Text := query;
  try
    ADOQueryAll.open;
    cntToday := ADOQueryAll.FieldByName('COUNT_PARTHNERS').AsInteger;
  finally
    ADOQueryAll.Close;
  end;
  AllApplyFilter;
  // count parthner list table
  query := 'SELECT count(*) AS CNT FROM MPStats_parthners';
  ADOQueryAll.SQL.Clear;
  ADOQueryAll.SQL.Text := query;
  try
    ADOQueryAll.open;
    cntPL := ADOQueryAll.FieldByName('CNT').AsInteger;
  finally
    ADOQueryAll.Close;
  end;
  if (cntYesterday = cntToday) AND (cntPL = cntToday) then
  begin
    Result := 0;
  end
  else
  begin
    Result := cntToday;
  end;
end;

procedure TMainForm.PLGetDataStartThread(ParthnerCount: Integer);
var
  ThreadP: TThreadPL;
begin
  ThreadP := TThreadPL.Create(DebugMode, 1, ParthnerCount); // 1 - all parthners
  ThreadP.FreeOnTerminate := True;
  ThreadP.Priority := tpNormal;
  ThreadP.Start;
end;

procedure TMainForm.PLOneGetDataStartThread(aPartnerID: Integer);
var
  ThreadP: TThreadPL;
begin
  BlockButtons(True);
  ThreadP := TThreadPL.Create(DebugMode, 2, aPartnerID); // 2 - one opartner
  ThreadP.FreeOnTerminate := True;
  ThreadP.Priority := tpNormal;
  ThreadP.Start;
end;

procedure TMainForm.PLGetData();
var
  ParthnerCount, buttonSelected: Integer;
begin
  buttonSelected := MessageDlg('Вы уверены, что хотите собрать статистику по ВСЕМ партнерам?', mtConfirmation, mbOKCancel, 0);
  if buttonSelected = mrOK then
  begin
    BlockButtons(True);
    if ALLTodayAlreadyGet = False then
    begin
      AllGetDataStartThread(True);
    end
    else
    begin
      ParthnerCount := PLYesterdayAndTodayDifferentParCountAndAllIsset;
      if ParthnerCount > 0 then
      begin
        PLGetDataStartThread(ParthnerCount);
      end;
    end;
  end;
end;

procedure TMainForm.PanelAppUpdateClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'http://imyie.ru/mpstats/', nil, nil, SW_SHOW);
end;

procedure TMainForm.PLAddRow(ParthnerData: TStrings);
begin
  if PLRowAlreadyIsset(StrToInt(ParthnerData.Values['P_BITRIX_ID'])) = False then
  begin
    query := 'INSERT INTO MPStats_parthners '
      + '(P_BITRIX_ID,P_CODE,P_NAME,P_SITE) VALUES('''
      + ParthnerData.Values['P_BITRIX_ID'] + ''', '''
      + ParthnerData.Values['P_CODE'] + ''', '''
      + ParthnerData.Values['P_NAME'] + ''', '''
      + ParthnerData.Values['P_SITE'] + ''''
      + ')';
    ADOQueryPL.SQL.Clear;
    ADOQueryPL.SQL.Add(query);
    ADOQueryPL.ExecSQL;
    PLApplyFilter;
  end;
end;

procedure TMainForm.PLApplyFilter();
begin
  query := 'SELECT * FROM MPStats_parthners';
  if (length(EditPLParCode.Text) > 0) or
     (length(EditPLParName.Text) > 0)
     then
  begin
    query := query + ' WHERE ';
    // Partner code
    if length(EditPLParCode.Text) > 0 then
    begin
      query := query + ' P_CODE LIKE ''%' + (EditPLParCode.Text) + '%''';
    end;
    // Partner name
    if length(EditPLParName.Text) > 0 then
    begin
      if length(EditPLParCode.Text) > 0 then
      begin
        query := query + ' AND';
      end;
      //
      query := query + ' P_NAME LIKE ''%' + (EditPLParName.Text) + '%''';
    end;
  end;
  ADOQueryPL.SQL.Clear;
  ADOQueryPL.SQL.Add(query);
  ADOQueryPL.Active := True;
end;

procedure TMainForm.EditPLParCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    PLApplyFilter;
    Key := #0;
  end;
end;

procedure TMainForm.ButtonPLFilterClick(Sender: TObject);
begin
  PLApplyFilter;
end;

procedure TMainForm.ButtonPLGetDataClick(Sender: TObject);
begin
  PLGetData;
end;

procedure TMainForm.PMPL_PLInfoGetDataClick(Sender: TObject);
var
  PartnerID: Integer;
begin
  PartnerID := DBGridPL.DataSource.DataSet.FieldByName('P_BITRIX_ID').AsInteger;
  PLOneGetDataStartThread(PartnerID);
end;

procedure TMainForm.PMPL_ShowInfoClick(Sender: TObject);
var
  FormPLInfo: TParthnerInfo;
  PartnerData: TStrings;
  PartnerID: Integer;
begin
  // Prepare data
  PartnerData := TStringList.Create();
  PartnerData.Add(Format('%s=%s', ['P_BITRIX_ID', DBGridPL.DataSource.DataSet.FieldByName('P_BITRIX_ID').AsString]));
  PartnerData.Add(Format('%s=%s', ['P_CODE', DBGridPL.DataSource.DataSet.FieldByName('P_CODE').AsString]));
  PartnerData.Add(Format('%s=%s', ['P_NAME', DBGridPL.DataSource.DataSet.FieldByName('P_NAME').AsString]));
  PartnerData.Add(Format('%s=%s', ['P_SITE', DBGridPL.DataSource.DataSet.FieldByName('P_SITE').AsString]));

  // Show form
  PartnerID := DBGridPL.DataSource.DataSet.FieldByName('P_BITRIX_ID').AsInteger;
  FormPLInfo := TParthnerInfo.Create(Application, PartnerData);
  FormPLInfo.Show;
end;

procedure TMainForm.PMPL_ShowModuleListClick(Sender: TObject);
var
  FormML: TModuleList;
  PartnerData: TStrings;
  PartnerID: Integer;
begin
  // Prepare data
  PartnerData := TStringList.Create();
  PartnerData.Add(Format('%s=%s', ['P_BITRIX_ID', DBGridPL.DataSource.DataSet.FieldByName('P_BITRIX_ID').AsString]));
  PartnerData.Add(Format('%s=%s', ['P_CODE', DBGridPL.DataSource.DataSet.FieldByName('P_CODE').AsString]));
  PartnerData.Add(Format('%s=%s', ['P_NAME', DBGridPL.DataSource.DataSet.FieldByName('P_NAME').AsString]));
  PartnerData.Add(Format('%s=%s', ['P_SITE', DBGridPL.DataSource.DataSet.FieldByName('P_SITE').AsString]));

  // Show form
  PartnerID := DBGridPL.DataSource.DataSet.FieldByName('P_BITRIX_ID').AsInteger;
  FormML := TModuleList.Create(Application, PartnerData);
  FormML.Show;
end;

{ Parthner list info }
function TMainForm.PLInfoTodayAlreadyGet(ParthnerID: Integer): Boolean;
var
  currentCnt: Integer;
begin
  query := 'SELECT count(*) AS CNT FROM MPStats_parthners_info '
    + 'WHERE ('
    + ' P_ID = ' + IntToStr(ParthnerID) + ' AND '
    + ' P_DATE_INFO = DateValue(''' + DateToStr(Now) + ''')'
    + ')';
  ADOQueryPL.SQL.Clear;
  ADOQueryPL.SQL.Text := query;
  try
    ADOQueryPL.open;
    currentCnt := ADOQueryPL.FieldByName('CNT').AsInteger;
  finally
    ADOQueryPL.Close;
  end;
  PLApplyFilter;
  if currentCnt < 1 then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

procedure TMainForm.PLInfoAddRow(ParthnerDataInfo: TStrings);
begin
  if PLInfoTodayAlreadyGet(StrToInt(ParthnerDataInfo.Values['P_ID'])) = False then
  begin
    query := 'INSERT INTO MPStats_parthners_info ' +
      '(P_ID,P_DATE_INFO,P_COUNT_MODULE,P_COUNT_MODULE_B24,P_COUNT_EMPLOYEE,P_COUNT_CERTIFICATE,P_COUNT_PROJECT) '
      + 'VALUES ('''
      + ParthnerDataInfo.Values['P_ID'] + ''', '''
      + ParthnerDataInfo.Values['P_DATE_INFO'] + ''', '''
      + ParthnerDataInfo.Values['P_COUNT_MODULE'] + ''', '''
      + ParthnerDataInfo.Values['P_COUNT_MODULE_B24'] + ''', '''
      + ParthnerDataInfo.Values['P_COUNT_EMPLOYEE'] + ''', '''
      + ParthnerDataInfo.Values['P_COUNT_CERTIFICATE'] + ''', '''
      + ParthnerDataInfo.Values['P_COUNT_PROJECT'] + ''''
      + ')';
    ADOQueryPL.SQL.Clear;
    ADOQueryPL.SQL.Add(query);
    ADOQueryPL.ExecSQL;
    PLApplyFilter;
  end;
end;

{ Module list }
function TMainForm.MLInfoTodayAlreadyGet(ParthnerID: Integer; ModuleCode: String): Boolean;
var
  currentCnt: Integer;
begin
  query := 'SELECT count(*) AS CNT FROM MPStats_modules_info '
    + 'WHERE ('
    + ' P_ID = ' + IntToStr(ParthnerID) + ' AND '
    + ' M_CODE = ''' + ModuleCode + ''' AND '
    + ' M_DATA_INFO = DateValue(''' + DateToStr(Now) + ''')'
    + ')';
  ADOQueryPL.SQL.Clear;
  ADOQueryPL.SQL.Text := query;
  try
    ADOQueryPL.open;
    currentCnt := ADOQueryPL.FieldByName('CNT').AsInteger;
  finally
    ADOQueryPL.Close;
  end;
  PLApplyFilter;
  if currentCnt < 1 then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

procedure TMainForm.MLGetDataStartThread(ParthnerID: Integer; PartnerCode: String);
var
  ThreadM: TThreadML;
begin
  BlockButtons(True);
  ThreadM := TThreadML.Create(DebugMode, 0, 1, ParthnerID, PartnerCode, ''); // 1 - all modules
  ThreadM.FreeOnTerminate := True;
  ThreadM.Priority := tpNormal;
  ThreadM.Start;
end;

procedure TMainForm.MLOneGetDataStartThread(ParthnerID: Integer; PartnerCode, ModuleCode: String);
var
  ThreadM: TThreadML;
begin
  BlockButtons(True);
  ThreadM := TThreadML.Create(DebugMode, 0, 2, ParthnerID, PartnerCode, ModuleCode); // 1 - all modules
  ThreadM.FreeOnTerminate := True;
  ThreadM.Priority := tpNormal;
  ThreadM.Start;
end;


procedure TMainForm.MLInfoAddRow(ModuleDataInfo: TStrings);
var
  Fields: String;
begin
  if MLInfoTodayAlreadyGet(StrToInt(ModuleDataInfo.Values['P_ID']), ModuleDataInfo.Values['M_CODE']) = False then
  begin
    if (ModuleDataInfo.Values['M_TOP_PLACE'] <> '' ) and (StrToInt(ModuleDataInfo.Values['M_TOP_PLACE']) > 0) then
    begin
      Fields := 'P_ID,M_CODE,M_DATA_INFO,M_NAME,M_FREE,M_OLD_PRICE,M_PRICE,'
        + 'M_DATE,M_VERSION,M_INSTALL_COUNT,M_DEMO_LINK, M_TOP_PLACE';
    end
    else
    begin
      Fields := 'P_ID,M_CODE,M_DATA_INFO,M_NAME,M_FREE,M_OLD_PRICE,M_PRICE,'
        + 'M_DATE,M_VERSION,M_INSTALL_COUNT,M_DEMO_LINK';
    end;
    query := 'INSERT INTO MPStats_modules_info (' + Fields + ') '
      + 'VALUES ('''
      + ModuleDataInfo.Values['P_ID'] + ''', '''
      + ModuleDataInfo.Values['M_CODE'] + ''', '''
      + ModuleDataInfo.Values['M_DATA_INFO'] + ''', '''
      + ModuleDataInfo.Values['M_NAME'] + ''', '''
      + ModuleDataInfo.Values['M_FREE'] + ''', '''
      + ModuleDataInfo.Values['M_OLD_PRICE'] + ''', '''
      + ModuleDataInfo.Values['M_PRICE'] + ''', '''
      + ModuleDataInfo.Values['M_DATE'] + ''', '''
      + ModuleDataInfo.Values['M_VERSION'] + ''', '''
      + ModuleDataInfo.Values['M_INSTALL_COUNT'] + ''', '''
      + ModuleDataInfo.Values['M_DEMO_LINK'] + '''';
    if (ModuleDataInfo.Values['M_TOP_PLACE'] <> '' ) and (StrToInt(ModuleDataInfo.Values['M_TOP_PLACE']) > 0) then
    begin
      query := query + ', ''' + ModuleDataInfo.Values['M_TOP_PLACE'] + '''';
    end;
    query := query + ')';
    ADOQueryPL.SQL.Clear;
    ADOQueryPL.SQL.Add(query);
    ADOQueryPL.ExecSQL;
    PLApplyFilter;
  end;
end;

procedure TMainForm.PMPL_GoToPartnerCardClick(Sender: TObject);
var
  localUrl, PartnerID: String;
begin
  PartnerID := DBGridPL.DataSource.DataSet.FieldByName('P_BITRIX_ID').AsString;
  localUrl := 'http://www.1c-bitrix.ru/partners/' + PartnerID + '.php';
  ShellExecute(0, 'open', PChar(localUrl), nil, nil, SW_SHOW);
end;

procedure TMainForm.PMPL_GoToSiteClick(Sender: TObject);
var
  localUrl: String;
begin
  localUrl := 'http://' + DBGridPL.DataSource.DataSet.FieldByName('P_SITE').AsString;
  ShellExecute(0, 'open', PChar(localUrl), nil, nil, SW_SHOW);
end;

procedure TMainForm.PMPL_MLInfoGetDataClick(Sender: TObject);
var
  PartnerID: Integer;
  PartnerCode: String;
begin
  PartnerID := DBGridPL.DataSource.DataSet.FieldByName('P_BITRIX_ID').AsInteger;
  PartnerCode := DBGridPL.DataSource.DataSet.FieldByName('P_CODE').AsString;
  if PartnerCode <> '' then
  begin
    MLGetDataStartThread(PartnerID, PartnerCode);
  end;
end;

{ One Module }
procedure TMainForm.OneGetDataModuleStartThread(ParthnerID: Integer; PartnerCode, ModuleCode: String);
var
  ThreadM: TThreadML;
begin
  ThreadM := TThreadML.Create(DebugMode, 0, 2, ParthnerID, PartnerCode, ModuleCode); // 2 - one modules
  ThreadM.FreeOnTerminate := True;
  ThreadM.Priority := tpNormal;
  ThreadM.Start;
end;

{ One Parthner }
procedure TMainForm.OneGetDataParthnerStartThread(ParthnerID: Integer);
var
  ThreadP: TThreadPL;
begin
  ThreadP := TThreadPL.Create(DebugMode, 2, ParthnerID); // 2 - one partner
  ThreadP.FreeOnTerminate := True;
  ThreadP.Priority := tpNormal;
  ThreadP.Start;
end;

{ Get start }
procedure TMainForm.AutoGetStart();
begin
  if (AutoGetOn = True) or (Top30MP = True) then
  begin
    if Top30MP = True then
    begin
      Top30MPAutoGetStart();
    end
    else if AutoGetOn = True then
    begin
      AGAutoGetStart();
    end;
  end;
end;

{ Top30 marketplace }
procedure TMainForm.Top30MPAutoGetStart();
var
  ThreadM: TThreadML;
begin
  BlockButtons(True);
  ThreadM := TThreadML.Create(DebugMode, 2, 3, 0, '', ''); // 3 - Get top internet-magazine
  ThreadM.FreeOnTerminate := True;
  ThreadM.Priority := tpNormal;
  ThreadM.Start;
end;

procedure TMainForm.Top30MPAutoGetFinish();
begin
  Top30MPApplyFilter();
  if AutoGetOn = True then
  begin
    AGAutoGetStart();
  end
  else
  begin
    BlockButtons(False);
    TrayBalloonHint('Сбор данных Топ30 завершен.');
  end;
end;

procedure TMainForm.Top30MPApplyFilter();
begin
  query := 'SELECT TOP 30 * '
    + 'FROM MPStats_modules_info '
    + 'WHERE M_DATA_INFO = DateValue(''' + DateToStr(Now) + ''')'
    + ' AND M_TOP_PLACE > 0 ';
  Debug( query );
  ADOQueryTopMP.SQL.Clear;
  ADOQueryTopMP.SQL.Add(query);
  ADOQueryTopMP.Active := True;
end;

{ Auto Get }
function TMainForm.AGAlreadyIssetModule(Code: String): boolean;
begin
  Result := AGAlreadyIsset(1,Code);
end;

function TMainForm.AGAlreadyIssetPartner(P_ID: Integer): boolean;
begin
  Result := AGAlreadyIsset(2,IntTOStr(P_ID));
end;

function TMainForm.AGAlreadyIsset(IsPartnerOrModule: Integer; Code: String): boolean;
var
  currentCnt: Integer;
begin
  query := 'SELECT count(*) AS CNT FROM MPStats_auto_get_info ';
  if IsPartnerOrModule = 2 then
  begin
    query := query + ' WHERE P_ID = ' + Code;
  end
  else
  begin
    query := query + ' WHERE M_CODE = ''' + Code + '''';
  end;
  ADOQueryAG.SQL.Clear;
  ADOQueryAG.SQL.Text := query;
  try
    ADOQueryAG.open;
    currentCnt := ADOQueryAG.FieldByName('CNT').AsInteger;
  finally
    ADOQueryAG.Close;
  end;
  AGApplyFilter;
  if currentCnt < 1 then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

procedure TMainForm.AGChangeAGModule(Code: String; P_ID: Integer);
begin
  if AGAlreadyIssetModule(Code) = True then
  begin
    AGDeleteRowModule(Code);
  end
  else
  begin
    AGAddRowModule(Code,P_ID);
  end;
end;

procedure TMainForm.AGChangeAGPartner(P_ID: Integer);
begin
  if AGAlreadyIssetPartner(P_ID) = True then
  begin
    AGDeleteRowPartner(P_ID);
  end
  else
  begin
    AGAddRowPartner(P_ID);
  end;
end;

procedure TMainForm.AGDeleteRowModule(Code: String);
begin
  query := 'DELETE FROM MPStats_auto_get_info WHERE M_CODE = ''' + Code + '''';
  ADOQueryAG.SQL.Clear;
  ADOQueryAG.SQL.Add(query);
  ADOQueryAG.ExecSQL;
  AGApplyFilter;
end;

procedure TMainForm.AGAddRowModule(Code: String; P_ID: Integer);
begin
  if (Code <> '') and (P_ID > 0) then
  begin
    AGAddRow(Code,P_ID);
  end;
end;

procedure TMainForm.AGDeleteRowPartner(P_ID: Integer);
begin
  query := 'DELETE FROM MPStats_auto_get_info WHERE P_ID = ' + IntToStr(P_ID);
  ADOQueryAG.SQL.Clear;
  ADOQueryAG.SQL.Add(query);
  ADOQueryAG.ExecSQL;
  AGApplyFilter;
end;

procedure TMainForm.AGAddRowPartner(P_ID: Integer);
begin
  if P_ID > 0 then
  begin
    AGAddRow('',P_ID);
  end;
end;

procedure TMainForm.AGAddRow(ModuleCode: String; P_ID: Integer);
begin
  query := 'INSERT INTO MPStats_auto_get_info (M_CODE,P_ID) '
    + 'VALUES(''' + ModuleCode + ''',' + IntToStr(P_ID) + ')';
  ADOQueryAG.SQL.Clear;
  ADOQueryAG.SQL.Add(query);
  ADOQueryAG.ExecSQL;
  AGApplyFilter;
end;

procedure TMainForm.AGApplyFilter();
begin
  query := 'SELECT DISTINCT '
    + 't2.M_CODE AS M_CODE, '
    + 't2.M_NAME AS M_NAME, '
    + 't1.P_ID AS P_ID '
    + 'FROM MPStats_auto_get_info AS t1 '
    + 'LEFT JOIN MPStats_modules_info AS t2 ON t1.M_CODE=t2.M_CODE';
  ADOQueryAG.SQL.Clear;
  ADOQueryAG.SQL.Add(query);
  ADOQueryAG.Active := True;
end;

procedure TMainForm.AGAutoGetStart();
var
  ModuleCode: String;
  P_ID: Integer;
begin
  BlockButtons(true);
  DBGridAG.Enabled := False;
  ADOQueryAG.First;
  ModuleCode := DBGridAG.DataSource.DataSet.FieldByName('M_CODE').AsString;
  P_ID := DBGridAG.DataSource.DataSet.FieldByName('P_ID').AsInteger;
  AGStartGetProcess(P_ID,ModuleCode);
end;

procedure TMainForm.AGStartGetProcess(PartnerID: Integer; LastModuleCode: String);
var
  ThreadM: TThreadML;
  Next_ModuleCode: String;
  Next_P_ID: Integer;
begin
  if MLInfoTodayAlreadyGet(PartnerID, LastModuleCode) = True then
  begin
    ADOQueryAG.Next;
    Next_ModuleCode := DBGridAG.DataSource.DataSet.FieldByName('M_CODE').AsString;
    Next_P_ID := DBGridAG.DataSource.DataSet.FieldByName('P_ID').AsInteger;
  end
  else
  begin
    Next_ModuleCode := LastModuleCode;
    LastModuleCode := '';
  end;
  if LastModuleCode = Next_ModuleCode then
  begin
    AGAutoGetFinish();  
  end
  else
  begin
    if MLInfoTodayAlreadyGet(PartnerID, Next_ModuleCode) = False then
    begin
      ThreadM := TThreadML.Create(DebugMode, 1, 2, PartnerID, '', Next_ModuleCode); // 2 - one module info
      ThreadM.FreeOnTerminate := True;
      ThreadM.Priority := tpNormal;
      ThreadM.Start;
    end
    else
    begin
      AGStartGetProcess(PartnerID,Next_ModuleCode);    
    end;
  end;
end;

procedure TMainForm.AGAutoGetFinish();
begin
  BlockButtons(false);
  DBGridAG.Enabled := True;
  ADOQueryAG.First;
  MainForm.TrayBalloonHint('Автосбор данных завершен.');  
end;

procedure TMainForm.PMAG_ModuleInfoClick(Sender: TObject);
var
  FormPLInfo: TModuleInfo;
  MIPartnerData, ModuleData: TStrings;
  PartnerID: Integer;
begin
  // Prepare data\
  MIPartnerData := TStringList.Create();
  MIPartnerData.Add(Format('%s=%s', ['P_BITRIX_ID', DBGridPL.DataSource.DataSet.FieldByName('P_BITRIX_ID').AsString]));
  MIPartnerData.Add(Format('%s=%s', ['P_CODE', DBGridPL.DataSource.DataSet.FieldByName('P_CODE').AsString]));
  MIPartnerData.Add(Format('%s=%s', ['P_NAME', DBGridPL.DataSource.DataSet.FieldByName('P_NAME').AsString]));
  MIPartnerData.Add(Format('%s=%s', ['P_SITE', DBGridPL.DataSource.DataSet.FieldByName('P_SITE').AsString]));
  ModuleData := TStringList.Create();
  ModuleData.Add(Format('%s=%s', ['M_CODE', DBGridAG.DataSource.DataSet.FieldByName('M_CODE').AsString]));
  ModuleData.Add(Format('%s=%s', ['M_NAME', DBGridAG.DataSource.DataSet.FieldByName('M_NAME').AsString]));

  // Show form
  FormPLInfo := TModuleInfo.Create(Application, MIPartnerData, ModuleData);
  FormPLInfo.Show;
end;

procedure TMainForm.PMAG_RefreshClick(Sender: TObject);
begin
  AGApplyFilter;
  DBGridAG.Enabled := True;
end;

{ AppUpdate }
function TMainForm.GetMyVersion(Formated: Boolean): String;
type
  TVerInfo = Packed Record
    Nevazhno: array[0..47] of Byte;
    Minor, Major, Build, Release: Word;
  end;
var
  s: TResourceStream;
  v: TVerInfo;
begin
  Result := '';
  try
    s:= TResourceStream.Create(HInstance,'#1',RT_VERSION);
    if s.Size>0 then begin
      s.Read(v,SizeOf(v));
      if Formated = True then
      begin
        Result := Format('%d.%d.%d.%d', [v.Major, v.Minor, v.Release, v.Build]);
      end
      else
      begin
        Result := IntToStr(v.Major) + IntToStr(v.Minor) + IntToStr(v.Release)
          + IntToStr(v.Build);
      end;
    end;
    s.Free;
  except;
    //
  end;
end;

procedure TMainForm.CheckVersion(Version: String);
var
  currentVer, readedVer: Integer;
begin
  currentVer := StrToInt( GetMyVersion(false) );
  readedVer := StrToInt( Version );
  Debug('currentVer = ' + IntToStr(currentVer) );
  Debug('readedVer = ' + IntToStr(readedVer) );
  if (readedVer > 0) and (readedVer > currentVer) then
  begin
    PanelAppUpdate.Visible := True;
  end;
end;

procedure TMainForm.AppUpdateStartThread();
var
  ThreadAppUpdate: TThreadAppUpdate;
begin
  PanelAppUpdate.Visible := False;
  ThreadAppUpdate := TThreadAppUpdate.Create(DebugMode);
  ThreadAppUpdate.FreeOnTerminate := True;
  ThreadAppUpdate.Priority := tpNormal;
  ThreadAppUpdate.Start;
end;

{ Other }
procedure TMainForm.BlockButtons(block: Boolean);
begin
  ButtonAllGetData.Enabled := not(block);
  MainMenuActionsGetAll.Enabled := not(block);
  ButtonPLGetData.Enabled := not(block);
  PMPL_MLInfoGetData.Enabled := not(block);
  PMPL_PLInfoGetData.Enabled := not(block);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  PrepareApplication();
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := YouCanClose;
  if YouCanClose = False then
  begin
    MainForm.Hide;
  end;
end;

procedure TMainForm.EditPLParNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    PLApplyFilter;
    Key := #0;
  end;
end;

procedure TMainForm.TrayPopupMenuExitClick(Sender: TObject);
begin
  YouCanClose := True;
  MainForm.Close;
end;

procedure TMainForm.MainMenuActionsGetAllClick(Sender: TObject);
begin
  AllGetData;
end;

procedure TMainForm.MainMenuExitClick(Sender: TObject);
begin
  YouCanClose := True;
  MainForm.Close;
end;

procedure TMainForm.MainMenuOptionsClick(Sender: TObject);
begin
  SettingsForm := TSettingsForm.Create(Application);
  SettingsForm.ShowModal;
end;

procedure TMainForm.TrayPopupMenuShowHideClick(Sender: TObject);
begin
  if MainForm.Showing = True then
  begin
    MainForm.Hide;
  end
  else
  begin
    MainForm.Show;
  end;
end;

procedure TMainForm.TrayIconDblClick(Sender: TObject);
begin
  if MainForm.Showing = True then
  begin
    MainForm.Hide;
  end
  else
  begin
    MainForm.Show;
  end;
end;

procedure TMainForm.TimerStatusBarTimer(Sender: TObject);
begin
  StatusBar.SimpleText := '';
  TimerStatusBar.Enabled := False;
end;

procedure TMainForm.ProgStatus(StatusMessage: String);
begin
  TimerStatusBar.Enabled := False;
  StatusBar.SimpleText := StatusMessage;
  TimerStatusBar.Enabled := True;
end;

procedure TMainForm.TrayBalloonHint(HintMessage: String);
begin
  TrayIcon.BalloonTitle := PROG_NAME;
  TrayIcon.BalloonHint := HintMessage;
  TrayIcon.ShowBalloonHint;
end;

procedure TMainForm.AboutClick(Sender: TObject);
begin
  AboutForm := TAboutForm.Create(Application);
  AboutForm.Show;
end;

{ Debug mode }
procedure TMainForm.Debug(mes: String);
var
  today: TDateTime;
begin
  today := Time;
  MemoDebug.Lines.Add('[' + TimeToStr(today) + '] ' + mes);
end;

end.
