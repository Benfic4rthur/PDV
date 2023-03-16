unit Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFrmMenu = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Produtos1: TMenuItem;
    Fornecedores1: TMenuItem;
    Clientes1: TMenuItem;
    Estoque1: TMenuItem;
    Movimentaes1: TMenuItem;
    Relatrios1: TMenuItem;
    Sair1: TMenuItem;
    Usuarios1: TMenuItem;
    Funcionarios1: TMenuItem;
    Cargo1: TMenuItem;
    Sair2: TMenuItem;
    procedure Usuarios1Click(Sender: TObject);
    procedure Funcionarios1Click(Sender: TObject);
    procedure Cargo1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Fornecedores1Click(Sender: TObject);
    procedure Sair2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

uses uUsuarios, uFuncionarios, uCargos, uModulo, uFornecedores;

procedure TFrmMenu.Cargo1Click(Sender: TObject);
begin
FrmCargos := TFrmCargos.Create(self);
FrmCargos.ShowModal;
end;

procedure TFrmMenu.FormShow(Sender: TObject);
begin
if (cargoUsuario = 'Administrador') or (cargoUsuario = 'Gerente') then
begin
Usuarios1.Enabled := true;
end;

end;

procedure TFrmMenu.Fornecedores1Click(Sender: TObject);
begin
FrmFornecedores := TFrmFornecedores.Create(self);
FrmFornecedores.ShowModal;
end;

procedure TFrmMenu.Funcionarios1Click(Sender: TObject);
begin
FrmFuncionarios := TFrmFuncionarios.Create(self);
FrmFuncionarios.ShowModal;
end;

procedure TFrmMenu.Sair2Click(Sender: TObject);
begin
close;
end;

procedure TFrmMenu.Usuarios1Click(Sender: TObject);
begin
FrmUsuarios := TFrmUsuarios.Create(self);
FrmUsuarios.ShowModal;
end;

end.
