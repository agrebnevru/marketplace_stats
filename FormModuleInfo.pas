unit FormModuleInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.Menus, Data.DB, Data.Win.ADODB;

type
  TModuleInfo = class(TForm)
    GBPartnerInformation: TGroupBox;
    PanelPartnerInfo: TPanel;
    STPartnerInfoID: TStaticText;
    STPartnerInfoCode: TStaticText;
    STPartnerInfoName: TStaticText;
    STPartnerInfoSite: TStaticText;
    STPDataID: TStaticText;
    STPDataCODE: TStaticText;
    STPDataNAME: TStaticText;
    STPDataSITE: TStaticText;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    StaticText1: TStaticText;
    StaticText3: TStaticText;
    STMDataCode: TStaticText;
    STMDataName: TStaticText;
    DBGridMInfo: TDBGrid;
    PanelFilter: TPanel;
    ButtonMIFilter: TButton;
    DateTimePickerMInfoTo: TDateTimePicker;
    StaticTextPLInfoDateTo: TStaticText;
    DateTimePickerMInfoFrom: TDateTimePicker;
    StaticTextPLInfoDateFrom: TStaticText;
    DataSourceMInfo: TDataSource;
    ADOQueryMInfo: TADOQuery;
    PopMenuMInfo: TPopupMenu;
    PMPL_Delete: TMenuItem;
    procedure ButtonMIFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PInfoApplyFilter();
    procedure PInfoShowInformation();
    constructor Create(AOwner: TComponent; aPartnerData, aModuleData: TStrings); overload;
  end;

var
  ModuleInfo: TModuleInfo;

implementation

{$R *.dfm}

var
  PartnerData, ModuleData: TStrings;
  query: String;

constructor TModuleInfo.Create(AOwner: TComponent; aPartnerData, aModuleData: TStrings);
begin
  inherited Create(AOwner);
  PartnerData := aPartnerData;
  ModuleData := aModuleData;
end;

procedure TModuleInfo.PInfoApplyFilter();
begin
  query := 'SELECT * FROM MPStats_modules_info WHERE M_CODE = '''
    + ModuleData.Values['M_CODE'] + ''''
    + ' AND M_DATA_INFO BETWEEN DateValue("'
    + DateToStr(DateTimePickerMInfoFrom.Date) + '") and DateValue("'
    + DateToStr(DateTimePickerMInfoTo.Date) + '")'
    + 'ORDER BY M_DATA_INFO DESC';
  ADOQueryMInfo.SQL.Clear;
  ADOQueryMInfo.SQL.Add(query);
  ADOQueryMInfo.open;
end;

procedure TModuleInfo.PInfoShowInformation();
begin
  STPDataID.Caption := PartnerData.Values['P_BITRIX_ID'];
  STPDataCODE.Caption := PartnerData.Values['P_CODE'];
  STPDataNAME.Caption := PartnerData.Values['P_NAME'];
  STPDataSITE.Caption := PartnerData.Values['P_SITE'];

  STMDataName.Caption := ModuleData.Values['M_NAME'];
  STMDataCode.Caption := ModuleData.Values['M_CODE'];
end;

procedure TModuleInfo.ButtonMIFilterClick(Sender: TObject);
begin
  PInfoApplyFilter();
end;

procedure TModuleInfo.FormShow(Sender: TObject);
begin
  PInfoShowInformation;
  PInfoApplyFilter;
end;

end.
