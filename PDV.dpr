program PDV;

uses
  Vcl.Forms,
  Login in 'Login.pas' {FrmLogin},
  Menu in 'Menu.pas' {FrmMenu},
  uUsuarios in 'Cadastros\uUsuarios.pas' {FrmUsuarios},
  uFuncionarios in 'Cadastros\uFuncionarios.pas' {FrmFuncionarios},
  uCargos in 'Cadastros\uCargos.pas' {FrmCargos},
  uModulo in 'uModulo.pas' {dm: TDataModule},
  uFornecedores in 'Cadastros\uFornecedores.pas' {FrmFornecedores};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmFornecedores, FrmFornecedores);
  Application.Run;
end.
