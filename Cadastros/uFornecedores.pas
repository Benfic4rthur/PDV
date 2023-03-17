unit uFornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons;

type
  TFrmFornecedores = class(TForm)
    Label1: TLabel;
    lblNome: TLabel;
    LblTelefoneFuncionario: TLabel;
    LblEnderecoFuncionario: TLabel;
    BtnNovo: TSpeedButton;
    BtnSalvar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    edtBuscarNome: TEdit;
    edtNome: TEdit;
    telefoneMask: TMaskEdit;
    edtEndereco: TEdit;
    bdgridFornecedores: TDBGrid;
    Label2: TLabel;
    cnpjMaskedt: TMaskEdit;
    Label3: TLabel;
    edtEmail: TEdit;
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtBuscarNomeChange(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure bdgridFornecedoresCellClick(Column: TColumn);
    procedure BtnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure limparCampos;
    procedure habilitarCampos;
    procedure desabilitarCampos;
    procedure listar;
    procedure associarCampos;

    procedure buscarPornome;
  public
    { Public declarations }
  end;

var
  FrmFornecedores: TFrmFornecedores;
  id: String;

implementation

{$R *.dfm}

uses uModulo;

procedure TFrmFornecedores.associarCampos;
begin
dm.tb_Fornecedores.FieldByName('nome').Value := edtNome.Text;
dm.tb_Fornecedores.FieldByName('cnpj').Value := cnpjMaskedt.Text;
dm.tb_Fornecedores.FieldByName('telefone').Value := telefoneMask.Text;
dm.tb_Fornecedores.FieldByName('endereco').Value := edtEndereco.Text;
dm.tb_Fornecedores.FieldByName('email').Value := edtEmail.Text;
dm.tb_Fornecedores.FieldByName('datacadastro').Value := DateToStr(Date);
end;

procedure TFrmFornecedores.bdgridFornecedoresCellClick(Column: TColumn);
begin
//ao clicar na linha dentro do datagrid
  habilitarCampos;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;

  dm.tb_Funcionarios.Edit;
//pega os valores da base e joga nos campos aos quais são associados
edtNome.Text := dm.query_fornecedores.FieldByName('nome').Value;
if dm.query_fornecedores.FieldByName('cnpj').Value <> null Then
cnpjMaskedt.Text := dm.query_fornecedores.FieldByName('cnpj').Value;
if dm.query_fornecedores.FieldByName('telefone').Value <> null Then
telefoneMask.Text := dm.query_fornecedores.FieldByName('telefone').Value;
if dm.query_fornecedores.FieldByName('endereco').Value <> null Then
edtEndereco.Text := dm.query_fornecedores.FieldByName('endereco').Value;
if dm.query_fornecedores.FieldByName('email').Value <> null Then
edtEmail.Text := dm.query_fornecedores.FieldByName('email').Value;
id := dm.query_fornecedores.FieldByName('id').Value;
end;

procedure TFrmFornecedores.BtnEditarClick(Sender: TObject);
begin
if Trim(edtNome.Text) = '' then
begin
//valida se algo foi digitado no campo texto
      MessageDlg('Preencha o nome do fornecedor!', TMsgDlgType.mtWarning, mbOKCancel, 0);
      edtNome.SetFocus;
      exit;
end;
if Trim(cnpjMaskedt.EditText) = '__.___.___/____-__' then
begin
  // campo de entrada com a máscara de CPF está vazio
  MessageDlg('Preencha o CNPJ do fornecedor.', TMsgDlgType.mtWarning, mbOKCancel, 0);
  cnpjMaskedt.SetFocus;
  exit;
end;

associarCampos;
dm.query_fornecedores.Close;
dm.query_fornecedores.SQL.clear;
//faz um update na base no campo cargo que tenha o id igual ao passado
dm.query_fornecedores.SQL.Add('Update funcionarios set nome = :nome, cnpj = :cnpj, telefone = :telefone, endereco = :endereco, email = :email where id = :id');
dm.query_fornecedores.paramByName('nome').Value := edtNome.text;
dm.query_fornecedores.paramByName('cnpj').Value := cnpjMaskedt.text;
dm.query_fornecedores.paramByName('telefone').Value := telefoneMask.text;
dm.query_fornecedores.paramByName('endereco').Value := edtEndereco.text;
dm.query_fornecedores.paramByName('email').Value := edtEndereco.text;
dm.query_fornecedores.paramByName('id').value := id;
dm.query_fornecedores.ExecSql;
listar;

limparCampos;
MessageDlg('Editado com sucesso!', mtInformation, mbOKCancel, 0);
desabilitarCampos;
BtnEditar.Enabled := false;
BtnExcluir.Enabled := false;
listar;
desabilitarCampos;

end;

procedure TFrmFornecedores.BtnExcluirClick(Sender: TObject);
begin
if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
begin
  // Captura o ID do registro a ser excluído
  var id := dm.query_fornecedores.FieldByName('id').Value;

  // Cria uma instrução SQL DELETE com a cláusula WHERE
  var sql := 'DELETE FROM fornecedores WHERE id = :id';

  // Executa a instrução SQL passando o valor do ID como parâmetro
  dm.query_fornecedores.SQL.Text := sql;
  dm.query_fornecedores.Params.ParamByName('id').Value := id;
  dm.query_fornecedores.ExecSQL;

  listar;
  MessageDlg('Deletado com sucesso!', mtInformation, [mbOK], 0);

  // Desabilita os botões de editar e excluir, limpa o campo de texto e atualiza a lista
  btnEditar.Enabled := false;
  BtnExcluir.Enabled := false;
  limparcampos;
  desabilitarcampos;
  end;
end;

procedure TFrmFornecedores.BtnNovoClick(Sender: TObject);
begin
habilitarCampos;
edtNome.SetFocus;
btnSalvar.Enabled := true;
dm.tb_Fornecedores.Insert;
end;

procedure TFrmFornecedores.BtnSalvarClick(Sender: TObject);
begin
if Trim(edtNome.Text) = '' then
begin
//valida se algo foi digitado no campo texto
      MessageDlg('Preencha o nome do fornecedor!', TMsgDlgType.mtWarning, mbOKCancel, 0);
      edtNome.SetFocus;
      exit;
end;
if Trim(cnpjMaskedt.EditText) = '__.___.___/____-__' then
begin
  // campo de entrada com a máscara de CPF está vazio
  MessageDlg('Preencha o CNPJ do fornecedor.', TMsgDlgType.mtWarning, mbOKCancel, 0);
  cnpjMaskedt.SetFocus;
  exit;
end;

//associa os campos de cargo da datagrid com o cargo da table
associarCampos;
dm.tb_Fornecedores.Post;
dm.fd.Commit;
listar;
MessageDlg('Salvo com sucesso!', mtInformation, mbOKCancel, 0);
limparCampos;
desabilitarCampos;
btnSalvar.Enabled := false;
btnExcluir.Enabled := false;
BtnEditar.Enabled := false;
end;

procedure TFrmFornecedores.buscarPornome;
begin
       dm.query_fornecedores.Close;
       dm.query_fornecedores.SQL.Clear;
       dm.query_fornecedores.SQL.Add('SELECT * from fornecedores where nome LIKE :nome');
       dm.query_fornecedores.ParamByName('nome').value := edtBuscarNome.Text + '%';
       dm.query_fornecedores.Open;
end;

procedure TFrmFornecedores.desabilitarCampos;
begin
edtNome.Enabled := false;
cnpjMaskedt.Enabled:= false;
telefoneMask.Enabled := false;
edtEndereco.Enabled := false;
edtEmail.Enabled := false;
end;

procedure TFrmFornecedores.edtBuscarNomeChange(Sender: TObject);
begin
buscarPornome
end;

procedure TFrmFornecedores.FormCreate(Sender: TObject);
begin
listar;
end;

procedure TFrmFornecedores.FormShow(Sender: TObject);
begin
listar;
desabilitarCampos;
dm.tb_Fornecedores.Active := true;
end;

procedure TFrmFornecedores.habilitarCampos;
begin
edtNome.Enabled := true;
cnpjMaskedt.Enabled:= true;
telefoneMask.Enabled := true;
edtEndereco.Enabled := true;
edtEmail.Enabled := true;
end;

procedure TFrmFornecedores.limparCampos;
begin
edtNome.Text := '';
cnpjMaskedt.Text := '';
telefoneMask.Text := '';
edtEndereco.Text := '';
edtEmail.Text := '';
end;

procedure TFrmFornecedores.listar;
begin
dm.query_fornecedores.Close;
dm.query_fornecedores.SQL.clear;
dm.query_fornecedores.SQL.Add('Select * from fornecedores');
dm.query_fornecedores.Open;
end;

end.
