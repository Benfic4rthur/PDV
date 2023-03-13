unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TFrmLogin = class(TForm)
    Panel1: TPanel;
    ImgFundo: TImage;
    pnlLogin: TPanel;
    ImgLogin: TImage;
    txtUsuario: TEdit;
    txtSenha: TEdit;
    btnLogin: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
    procedure centralizarPainel;
    procedure login;

  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

uses Menu;

procedure TFrmLogin.btnLoginClick(Sender: TObject);
begin
  if trim(txtUsuario.text) = '' then
  begin
      MessageDlg('Preencha o usuário!', TMsgDlgType.mtWarning, mbOKCancel, 0);
      txtUsuario.SetFocus;
      exit;
  end;
  if trim(txtSenha.text) = '' then
  begin
      MessageDlg('Preencha a senha!', TMsgDlgType.mtWarning, mbOKCancel, 0);
      txtSenha.SetFocus;
      exit;
  end;
  login;
end;

procedure TFrmLogin.centralizarPainel;
begin
pnlLogin.Top := (self.Height div 2) - (pnlLogin.Height div 2);
pnlLogin.Left := (self.Width div 2) - (pnlLogin.Width div 2);
end;

procedure TFrmLogin.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
    centralizarPainel;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
    centralizarPainel;
end;

procedure TFrmLogin.login;
begin
FrmMenu := TFrmMenu.Create(FrmLogin);
FrmMenu.ShowModal;
//aqui vem a validação do login
end;

end.
