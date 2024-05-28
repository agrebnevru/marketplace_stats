program MPStats_;

uses
  Vcl.Forms,
  MPStats in 'MPStats.pas' {MainForm},
  FormAbout in 'FormAbout.pas' {AboutForm},
  AllThread in 'AllThread.pas',
  PLThread in 'PLThread.pas',
  FormPartnerInfo in 'FormPartnerInfo.pas' {ParthnerInfo},
  MLThread in 'MLThread.pas',
  FormModuleList in 'FormModuleList.pas' {ModuleList},
  FormSettings in 'FormSettings.pas' {Form1},
  FormModuleInfo in 'FormModuleInfo.pas' {ModuleInfo},
  AppUpdateThread in 'AppUpdateThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  //Application.CreateForm(TSettingsForm, SettingsForm);
  //Application.CreateForm(TModuleInfo, ModuleInfo);
  //Application.CreateForm(TAboutForm, AboutForm);
  //Application.CreateForm(TModuleList, ModuleList);
  //Application.CreateForm(TParthnerInfo, ParthnerInfo);
  Application.Run;
end.
