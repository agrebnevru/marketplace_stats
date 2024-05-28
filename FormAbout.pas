unit FormAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TAboutForm = class(TForm)
    Ok: TButton;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    STAppVersion: TStaticText;
    GBAppUpdateLoginAndPass: TGroupBox;
    EditPassord: TEdit;
    EditLogin: TEdit;
    procedure OkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  Login = 'MPStats';
  Password = 'vj8P7Mq57M5Gw48097qvt8';

var
  AboutForm: TAboutForm;

implementation

uses MPStats;

{$R *.dfm}

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  STAppVersion.Caption := MainForm.GetMyVersion(true);
  EditLogin.Text := Login;
  EditPassord.Text := Password;
end;

procedure TAboutForm.OkClick(Sender: TObject);
begin
  AboutForm.close;
end;

end.
