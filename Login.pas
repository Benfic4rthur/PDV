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
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

uses Menu, uModulo, uUsuarios;

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
WindowState := wsMaximized;
pnlLogin.Top := (self.Height div 2) - (pnlLogin.Height div 2);
pnlLogin.Left := (self.Width div 2) - (pnlLogin.Width div 2);
end;

procedure TFrmLogin.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
    centralizarPainel;
end;

procedure TFrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = 13 then
login;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
    centralizarPainel;
end;

procedure TFrmLogin.login;
begin

dm.query_usuarios.Close;
dm.query_usuarios.SQL.clear;
dm.query_usuarios.SQL.Add('Select * from usuarios where usuario = :usuario and senha = :senha');
dm.query_usuarios.ParamByName('usuario').AsString := txtUsuario.Text;
dm.query_usuarios.ParamByName('senha').AsString := txtSenha.Text;
dm.query_usuarios.Open;
//verificar se cpf ja existe ao salvar novo
if not dm.query_usuarios.IsEmpty then
        begin
      nomeUsuario := dm.query_usuarios['usuario'];
      cargoUsuario := dm.query_usuarios['cargo'];
      FrmMenu := TFrmMenu.Create(FrmLogin);
      txtSenha.Text := '';
      FrmMenu.ShowModal;
end
else
begin
MessageDlg('Credenciais invalidas', TMsgDlgType.mtInformation, mbOKCancel, 0);
txtUsuario.Text := '';
txtSenha.Text := '';
txtUsuario.SetFocus;
end;
end;

end.
