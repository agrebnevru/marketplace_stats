unit FormSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, IniFiles;

type
  TSettingsForm = class(TForm)
    TCSettings: TTabControl;
    PSButtons: TPanel;
    BSOk: TButton;
    StaticText1: TStaticText;
    ESDBFilePath: TEdit;
    BSBrowser: TButton;
    BSCancel: TButton;
    ODS: TOpenDialog;
    StaticText2: TStaticText;
    CBShowAGTab: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    CBApplyFiltersOnStart: TCheckBox;
    Label3: TLabel;
    CBDebugMode: TCheckBox;
    Label4: TLabel;
    CBAGOn: TCheckBox;
    Label5: TLabel;
    CBTopMPOn: TCheckBox;
    procedure BSBrowserClick(Sender: TObject);
    procedure BSCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BSOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadSettings();
    procedure SaveSettings();
  end;

var
  SettingsForm: TSettingsForm;

implementation

uses MPStats;

{$R *.dfm}

var
  IniSettings: TIniFile;
  SettingsFilePath: String;

procedure TSettingsForm.LoadSettings();
begin
  SettingsFilePath := ExtractFileDir(Application.ExeName) + '\settings.ini';
  if MainForm.CheckIssetFileSettings = True then
  begin
    IniSettings := TiniFile.Create(SettingsFilePath);
    ESDBFilePath.Text := IniSettings.ReadString('dbfile','path','');
    CBShowAGTab.Checked := IniSettings.ReadBool('settings','show_auto_get_tab',false);
    CBApplyFiltersOnStart.Checked := IniSettings.ReadBool('settings','apply_filters_on_start',false);
    CBAGOn.Checked := IniSettings.ReadBool('settings','auto_get_on',false);
    CBTopMPOn.Checked := IniSettings.ReadBool('settings','top30_mp_on',false);
    // for debug
    CBDebugMode.Checked := IniSettings.ReadBool('settings','bebug_mode',false);
  end;
end;

procedure TSettingsForm.SaveSettings();
begin
  IniSettings := TiniFile.Create(SettingsFilePath);
  IniSettings.WriteString('dbfile','path',ESDBFilePath.Text);
  IniSettings.WriteBool('settings','show_auto_get_tab',CBShowAGTab.Checked);
  IniSettings.WriteBool('settings','apply_filters_on_start',CBApplyFiltersOnStart.Checked);
  IniSettings.WriteBool('settings','auto_get_on',CBAGOn.Checked);
  IniSettings.WriteBool('settings','top30_mp_on',CBTopMPOn.Checked);
  // for debug
  IniSettings.WriteBool('settings','bebug_mode',CBDebugMode.Checked);
  MainForm.ApplySettingsToApplication();
end;

procedure TSettingsForm.BSBrowserClick(Sender: TObject);
begin
  if ODS.Execute then
  begin
    ESDBFilePath.Text := ODS.FileName;
  end;
end;

procedure TSettingsForm.BSCancelClick(Sender: TObject);
begin
  SettingsForm.Close;
end;

procedure TSettingsForm.BSOkClick(Sender: TObject);
begin
  SaveSettings();
  SettingsForm.Close;
end;

procedure TSettingsForm.FormShow(Sender: TObject);
begin
  LoadSettings();
end;

end.
