unit FormModuleList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Menus, Data.DB, Data.Win.ADODB, ShellApi;

type
  TModuleList = class(TForm)
    GBPartnerInformation: TGroupBox;
    PanelPartnerInfo: TPanel;
    STPartnerInfoID: TStaticText;
    STPartnerInfoCode: TStaticText;
    STPartnerInfoName: TStaticText;
    STPartnerInfoSite: TStaticText;
    STDataID: TStaticText;
    STDataCODE: TStaticText;
    STDataNAME: TStaticText;
    STDataSITE: TStaticText;
    PanelFilter: TPanel;
    StaticTextMLName: TStaticText;
    StaticTextMLCode: TStaticText;
    ButtonMLInfoFilter: TButton;
    DBGridMLInfo: TDBGrid;
    ADOQueryML: TADOQuery;
    DataSourceML: TDataSource;
    PopMenuML: TPopupMenu;
    PMML_Delete: TMenuItem;
    EditMLCode: TEdit;
    EditMLName: TEdit;
    StaticText1: TStaticText;
    EditMLPriceFrom: TEdit;
    StaticText2: TStaticText;
    EditMLPriceTo: TEdit;
    StaticText3: TStaticText;
    CMMLInstallCnt: TComboBox;
    PMML_SetAG: TMenuItem;
    N1: TMenuItem;
    PMML_Refresh: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    PMML_GoToModuleCard: TMenuItem;
    PMML_GoToModuleDemoSite: TMenuItem;
    procedure ButtonMLInfoFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditMLCodeKeyPress(Sender: TObject; var Key: Char);
    procedure EditMLPriceFromKeyPress(Sender: TObject; var Key: Char);
    procedure EditMLPriceToKeyPress(Sender: TObject; var Key: Char);
    procedure EditMLNameKeyPress(Sender: TObject; var Key: Char);
    procedure PMML_DeleteClick(Sender: TObject);
    procedure PopMenuMLPopup(Sender: TObject);
    procedure PMML_SetAGClick(Sender: TObject);
    procedure PMML_RefreshClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure PMML_GoToModuleCardClick(Sender: TObject);
    procedure PMML_GoToModuleDemoSiteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetSubFilter(): String;
    procedure MLInfoApplyFilter();
    procedure MLShowInformation();
    constructor Create(AOwner: TComponent; aPartnerData: TStrings); overload;
  end;

var
  ModuleList: TModuleList;

implementation

uses FormModuleInfo, MPStats;

{$R *.dfm}

var
  PartnerID: Integer;
  PartnerData: TStrings;
  query: String;

constructor TModuleList.Create(AOwner: TComponent; aPartnerData: TStrings);
begin
  inherited Create(AOwner);
  PartnerData := aPartnerData;
  PartnerID := StrToInt(PartnerData.Values['P_BITRIX_ID']);
end;

procedure TModuleList.EditMLCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    MLInfoApplyFilter;
    Key := #0;
  end;
end;

procedure TModuleList.EditMLNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    MLInfoApplyFilter;
    Key := #0;
  end;
end;

procedure TModuleList.EditMLPriceFromKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    MLInfoApplyFilter;
    Key := #0;
  end;
end;

procedure TModuleList.EditMLPriceToKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    MLInfoApplyFilter;
    Key := #0;
  end;
end;

function TModuleList.GetSubFilter(): String;
var
  subQuery: String;
begin
  subQuery := '';
  subQuery := subQuery + ' WHERE P_ID = ' + IntToStr(PartnerID);
  // Module code
  if length(EditMLCode.Text) > 0 then
  begin
    subQuery := subQuery + ' AND M_CODE LIKE ''%' + (EditMLCode.Text) + '%''';
  end;
  // Module name
  if length(EditMLName.Text) > 0 then
  begin
    subQuery := subQuery + ' AND M_NAME LIKE ''%' + (EditMLName.Text) + '%''';
  end;
  // Module price >
  if length(EditMLPriceFrom.Text) > 0 then
  begin
    subQuery := subQuery + ' AND M_NAME LIKE ''%' + (EditMLPriceFrom.Text) + '%''';
  end;
  // Module price <
  if length(EditMLPriceTo.Text) > 0 then
  begin
    subQuery := subQuery + ' AND M_NAME LIKE ''%' + (EditMLPriceTo.Text) + '%''';
  end;
  // Install count
  if CMMLInstallCnt.ItemIndex > 0 then
  begin
    subQuery := subQuery + ' AND M_INSTALL_COUNT = ''' + (CMMLInstallCnt.Text) + '''';
  end;
  Result := subQuery;
end;

procedure TModuleList.MLInfoApplyFilter();
var
  MCount: Integer;
begin
  query := 'SELECT * FROM MPStats_modules_info AS t2 '
    + 'INNER JOIN ('
    + 'SELECT M_CODE AS MC, max(M_DATA_INFO) AS MDI FROM MPStats_modules_info WHERE P_ID = '
    + IntToStr(PartnerID) + ' GROUP BY M_CODE'
    + ') AS t ON (t.MC=t2.M_CODE) AND (t.MDI=t2.M_DATA_INFO)';
  query := query + GetSubFilter();
  query := query + ' ORDER BY M_DATA_INFO DESC';
  ADOQueryML.SQL.Clear;
  ADOQueryML.SQL.Add(query);
  ADOQueryML.Active := True;
end;

procedure TModuleList.MLShowInformation();
begin
  PartnerID := StrToInt(PartnerData.Values['P_BITRIX_ID']);
  STDataID.Caption := IntToStr(PartnerID);
  STDataCODE.Caption := PartnerData.Values['P_CODE'];
  STDataNAME.Caption := PartnerData.Values['P_NAME'];
  STDataSITE.Caption := PartnerData.Values['P_SITE'];
end;

procedure TModuleList.N2Click(Sender: TObject);
var
  FormPLInfo: TModuleInfo;
  ModuleData: TStrings;
  PartnerID: Integer;
begin
  // Prepare data
  ModuleData := TStringList.Create();
  ModuleData.Add(Format('%s=%s', ['M_CODE', DBGridMLInfo.DataSource.DataSet.FieldByName('M_CODE').AsString]));
  ModuleData.Add(Format('%s=%s', ['M_NAME', DBGridMLInfo.DataSource.DataSet.FieldByName('M_NAME').AsString]));

  // Show form
  FormPLInfo := TModuleInfo.Create(Application, PartnerData, ModuleData);
  FormPLInfo.Show;
end;

procedure TModuleList.PMML_DeleteClick(Sender: TObject);
begin
  ADOQueryML.Delete;
end;

procedure TModuleList.PMML_GoToModuleCardClick(Sender: TObject);
var
  localUrl, M_CODE: String;
begin
  M_CODE := DBGridMLInfo.DataSource.DataSet.FieldByName('M_CODE').AsString;
  localUrl := 'http://marketplace.1c-bitrix.ru/solutions/' + M_CODE + '/';
  ShellExecute(0, 'open', PChar(localUrl), nil, nil, SW_SHOW);
end;

procedure TModuleList.PMML_GoToModuleDemoSiteClick(Sender: TObject);
var
  M_DEMO_LINK: String;
begin
  M_DEMO_LINK := DBGridMLInfo.DataSource.DataSet.FieldByName('M_DEMO_LINK').AsString;
  ShellExecute(0, 'open', PChar(M_DEMO_LINK), nil, nil, SW_SHOW);
end;

procedure TModuleList.PMML_RefreshClick(Sender: TObject);
var
  ModuleCode: String;
begin
  ModuleCode := DBGridMLInfo.DataSource.DataSet.FieldByName('M_CODE').AsString;
  if ModuleCode <> '' then
  begin
    MainForm.MLOneGetDataStartThread(PartnerID, '', ModuleCode);
  end;
end;

procedure TModuleList.PMML_SetAGClick(Sender: TObject);
var
  M_CODE: String;
begin
  M_CODE := DBGridMLInfo.DataSource.DataSet.FieldByName('M_CODE').AsString;
  MainForm.AGChangeAGModule(M_CODE, PartnerID);
end;

procedure TModuleList.PopMenuMLPopup(Sender: TObject);
var
  M_CODE, M_DEMO_LINK: String;
begin
  M_CODE := DBGridMLInfo.DataSource.DataSet.FieldByName('M_CODE').AsString;
  M_DEMO_LINK := DBGridMLInfo.DataSource.DataSet.FieldByName('M_DEMO_LINK').AsString;
  PMML_SetAG.Checked := MainForm.AGAlreadyIssetModule(M_CODE);
  if (M_DEMO_LINK <> '') and (Length(M_DEMO_LINK)>5) then
  begin
    PMML_GoToModuleDemoSite.Enabled := True;
  end
  else
  begin
    PMML_GoToModuleDemoSite.Enabled := False;
  end;
end;

procedure TModuleList.ButtonMLInfoFilterClick(Sender: TObject);
begin
  MLInfoApplyFilter;
end;

procedure TModuleList.FormShow(Sender: TObject);
begin
  MLShowInformation;
  MLInfoApplyFilter;
end;

end.
