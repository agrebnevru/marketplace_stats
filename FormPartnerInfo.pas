unit FormPartnerInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Data.DB, Data.Win.ADODB, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Menus;

type
  TParthnerInfo = class(TForm)
    PanelFilter: TPanel;
    PanelBottom: TPanel;
    DataSourcePLInfo: TDataSource;
    ADOQueryPLInfo: TADOQuery;
    DBGridPLInfo: TDBGrid;
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
    DateTimePickerPLInfoFrom: TDateTimePicker;
    DateTimePickerPLInfoTo: TDateTimePicker;
    StaticTextPLInfoDateTo: TStaticText;
    StaticTextPLInfoDateFrom: TStaticText;
    ButtonPLInfoFilter: TButton;
    PopMenuPLInfo: TPopupMenu;
    PMPL_Delete: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure ButtonPLInfoFilterClick(Sender: TObject);
    procedure PMPL_DeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PLInfoApplyFilter();
    procedure PLShowInformation();
    constructor Create(AOwner: TComponent; aPartnerData: TStrings); overload;
  end;

implementation

uses MPStats;

{$R *.dfm}

var
  PartnerID: Integer;
  PartnerData: TStrings;
  query: String;

constructor TParthnerInfo.Create(AOwner: TComponent; aPartnerData: TStrings);
begin
  inherited Create(AOwner);
  PartnerData := aPartnerData;
  PartnerID := StrToInt(PartnerData.Values['P_BITRIX_ID']);
end;

procedure TParthnerInfo.PLInfoApplyFilter();
begin
  query := 'SELECT * FROM MPStats_parthners_info WHERE P_ID = '
    + IntToStr(PartnerID)
    + ' AND P_DATE_INFO BETWEEN DateValue("'
    + DateToStr(DateTimePickerPLInfoFrom.Date) + '") and DateValue("'
    + DateToStr(DateTimePickerPLInfoTo.Date) + '")';
  ADOQueryPLInfo.SQL.Clear;
  ADOQueryPLInfo.SQL.Add(query);
  ADOQueryPLInfo.open;
end;

procedure TParthnerInfo.PLShowInformation();
begin
  STDataID.Caption := IntToStr(PartnerID);
  STDataCODE.Caption := PartnerData.Values['P_CODE'];
  STDataNAME.Caption := PartnerData.Values['P_NAME'];
  STDataSITE.Caption := PartnerData.Values['P_SITE'];
end;

procedure TParthnerInfo.PMPL_DeleteClick(Sender: TObject);
begin
  ADOQueryPLInfo.Delete;
end;

procedure TParthnerInfo.FormShow(Sender: TObject);
begin
  PLShowInformation();
  PLInfoApplyFilter();
end;

procedure TParthnerInfo.ButtonPLInfoFilterClick(Sender: TObject);
begin
   PLInfoApplyFilter();
end;

end.
