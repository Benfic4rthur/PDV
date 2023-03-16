unit uUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids;

type
  TFrmUsuarios = class(TForm)
    lblNome: TLabel;
    edtUsuario: TEdit;
    bdgridUsuarios: TDBGrid;
    BtnNovo: TSpeedButton;
    BtnSalvar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    Label1: TLabel;
    EdtBuscarNome: TEdit;
    EdtSenha: TEdit;
    Label2: TLabel;
    btnBuscar: TSpeedButton;
    Label3: TLabel;
    EdtNome: TEdit;
    procedure btnBuscarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure EdtBuscarNomeChange(Sender: TObject);
    procedure bdgridUsuariosCellClick(Column: TColumn);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
  private
    { Private declarations }
    procedure limparCampos;
    procedure habilitarCampos;
    procedure desabilitarCampos;
    procedure listar;
    procedure associarCampos;
    procedure buscarNome;
  public
    { Public declarations }
  end;

var
  FrmUsuarios: TFrmUsuarios;
  usuarioAntigo: string;

implementation

{$R *.dfm}

uses uModulo, uFuncionarios;


procedure TFrmUsuarios.associarCampos;
begin
dm.tb_Usuarios.FieldByName('nome').Value := EdtNome.Text;
dm.tb_Usuarios.FieldByName('usuario').Value := edtUsuario.Text;
dm.tb_Usuarios.FieldByName('senha').Value := EdtSenha.Text;
dm.tb_Usuarios.FieldByName('cargo').Value := cargoFuncionario;
dm.tb_Usuarios.FieldByName('idfuncionario').Value := idFuncionario;
end;

procedure TFrmUsuarios.bdgridUsuariosCellClick(Column: TColumn);
begin
habilitarCampos;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;
  dm.tb_usuarios.Edit;

  edtNome.Text := dm.query_usuarios.FieldByName('nome').Value;
  edtUsuario.Text := dm.query_usuarios.FieldByName('usuario').Value;
  edtSenha.Text := dm.query_usuarios.FieldByName('senha').Value;
  id := dm.query_usuarios.FieldByName('id').Value;
  usuarioAntigo := dm.query_usuarios.FieldByName('usuario').Value;
end;

procedure TFrmUsuarios.btnBuscarClick(Sender: TObject);
begin
chamada := 'Func';
FrmFuncionarios := TFrmFuncionarios.Create(self);
FrmFuncionarios.Show;
habilitarCampos;

end;

procedure TFrmUsuarios.BtnEditarClick(Sender: TObject);
begin
var
usuario : string;
begin
//se o campo texto for vazio, entra na valida��o
if Trim(EdtNome.Text) = '' then
begin
//valida se algo foi digitado no campo texto nome
      MessageDlg('Preencha o nome do usu�rio!', TMsgDlgType.mtWarning, mbOKCancel, 0);
      EdtNome.SetFocus;
      exit;
end;
if Trim(edtUsuario.Text) = '' then
begin
  // valida se um usuario foi digitado
  MessageDlg('Preencha o usu�rio de ' + EdtNome.text + '!', TMsgDlgType.mtWarning, mbOKCancel, 0);
  edtUsuario.SetFocus;
  exit;
end;
if Trim(EdtSenha.Text) = '' then
begin
  // valida se uma senha foi digitada
  MessageDlg('Preencha a senha do usu�rio!', TMsgDlgType.mtWarning, mbOKCancel, 0);
  EdtSenha.SetFocus;
  exit;
end;
if usuarioAntigo <> edtUsuario.Text then
  begin
      //sql que busca o funcionario na tabela conforme o cpf escrito no campo de texto
      dm.query_usuarios.Close;
      dm.query_usuarios.SQL.clear;
      dm.query_usuarios.SQL.Add('Select * from usuarios where usuario = ' + QuotedStr(Trim(edtUsuario.Text)) );
      dm.query_usuarios.Open;
      //verificar se cpf ja existe ao salvar novo
      if not dm.query_usuarios.IsEmpty then
        begin
      usuario := dm.query_usuarios['usuario'];
      listar;
      MessageDlg('o usuario '+ usuario + ' j� esta cadastrado!', mtInformation, mbOKCancel, 0);
      edtUsuario.Text := '';

      edtUsuario.SetFocus;
      exit;

        end;
  end;
//associarCampos;
dm.query_usuarios.Close;
dm.query_usuarios.SQL.clear;
//faz um update na base no campo cargo que tenha o id igual ao passado
dm.query_usuarios.SQL.Add('Update usuarios set nome = :nome, usuario = :usuario, senha = :senha where id = :id');
dm.query_usuarios.paramByName('nome').Value := EdtNome.text;
dm.query_usuarios.paramByName('usuario').Value := edtUsuario.text;
dm.query_usuarios.paramByName('senha').Value := EdtSenha.text;
dm.query_usuarios.paramByName('id').value := id;
dm.query_usuarios.ExecSql;
listar;


MessageDlg('Editado com sucesso!', mtInformation, mbOKCancel, 0);
limparCampos;
desabilitarCampos;
BtnEditar.Enabled := false;
BtnExcluir.Enabled := false;
listar;
desabilitarCampos;
end;
end;


procedure TFrmUsuarios.BtnExcluirClick(Sender: TObject);
begin
//cria um if que compara o resultado selecionado pelo cliente para excluir ou n�o da base
if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
begin
  // Captura o ID do registro a ser exclu�do
  var id := dm.query_usuarios.FieldByName('id').Value;

  // Cria uma instru��o SQL DELETE com a cl�usula WHERE
  var sql := 'DELETE FROM usuarios WHERE id = :id';

  // Executa a instru��o SQL passando o valor do ID como par�metro
  dm.query_usuarios.SQL.Text := sql;
  dm.query_usuarios.Params.ParamByName('id').Value := id;
  dm.query_usuarios.ExecSQL;

  listar;
  MessageDlg('Deletado com sucesso!', mtInformation, [mbOK], 0);

  // Desabilita os bot�es de editar e excluir, limpa o campo de texto e atualiza a lista

  limparcampos;
  desabilitarcampos;
end;
end;

procedure TFrmUsuarios.BtnNovoClick(Sender: TObject);
begin
btnBuscar.Enabled := true;
habilitarCampos;
edtUsuario.SetFocus;
btnSalvar.Enabled := true;
dm.tb_usuarios.Insert;
//dm.fd.StartTransaction;
end;

procedure TFrmUsuarios.BtnSalvarClick(Sender: TObject);
begin
var
usuario : string;
begin
//se o campo texto for vazio, entra na valida��o
if Trim(EdtNome.Text) = '' then
begin
//valida se algo foi digitado no campo texto nome
      MessageDlg('Preencha o nome do usu�rio!', TMsgDlgType.mtWarning, mbOKCancel, 0);
      EdtNome.SetFocus;
      exit;
end;
if Trim(edtUsuario.Text) = '' then
begin
  // valida se um usuario foi digitado
  MessageDlg('Preencha o usu�rio de ' + EdtNome.text + '!', TMsgDlgType.mtWarning, mbOKCancel, 0);
  edtUsuario.SetFocus;
  exit;
end;
if Trim(EdtSenha.Text) = '' then
begin
  // valida se uma senha foi digitada
  MessageDlg('Preencha a senha do usu�rio!', TMsgDlgType.mtWarning, mbOKCancel, 0);
  EdtSenha.SetFocus;
  exit;
end;
//sql que busca o funcionario na tabela conforme o cpf escrito no campo de texto
dm.query_usuarios.Close;
dm.query_usuarios.SQL.clear;
dm.query_usuarios.SQL.Add('Select * from usuarios where usuario = ' + QuotedStr(Trim(edtUsuario.Text)) );
dm.query_usuarios.Open;
//verificar se cpf ja existe ao salvar novo
if not dm.query_usuarios.IsEmpty then
begin
usuario := dm.query_usuarios['usuario'];
MessageDlg('o usuario '+ usuario + ' j� esta cadastrado!', mtInformation, mbOKCancel, 0);
edtUsuario.Text := '';
edtUsuario.SetFocus;
exit;
end;
//associa os campos de cargo da datagrid com o cargo da table
associarCampos;
dm.tb_usuarios.Post;
//dm.fd.Commit;
listar;
MessageDlg('Salvo com sucesso!', mtInformation, mbOKCancel, 0);
listar;
limparCampos;
desabilitarCampos;
btnSalvar.Enabled := false;
btnExcluir.Enabled := false;
BtnEditar.Enabled := false;

end;

end;

procedure TFrmUsuarios.buscarNome;
begin
dm.query_usuarios.Close;
       dm.query_usuarios.SQL.Clear;
       dm.query_usuarios.SQL.Add('SELECT * from usuarios where nome LIKE :nome and cargo <> :cargo');
       dm.query_usuarios.ParamByName('nome').Value := EdtBuscarNome.Text + '%';
       dm.query_usuarios.ParamByName('cargo').Value := 'Administrador';
       dm.query_usuarios.Open;
end;

procedure TFrmUsuarios.desabilitarCampos;
begin
EdtNome.Enabled := false;
EdtSenha.Enabled:= false;
edtUsuario.Enabled := false;
end;

procedure TFrmUsuarios.EdtBuscarNomeChange(Sender: TObject);
begin
buscarNome;
end;

procedure TFrmUsuarios.FormActivate(Sender: TObject);
begin
EdtNome.Text := nomeFuncionario;
btnBuscar.Enabled := false;
end;

procedure TFrmUsuarios.FormShow(Sender: TObject);
begin
listar;
desabilitarCampos;
dm.tb_usuarios.Active := true;
end;

procedure TFrmUsuarios.habilitarCampos;
begin
EdtSenha.Enabled:= true;
edtUsuario.Enabled := true;
end;

procedure TFrmUsuarios.limparCampos;
begin
EdtNome.Text := '';
EdtSenha.Text := '';
edtUsuario.Text := '';
end;

procedure TFrmUsuarios.listar;
begin
dm.query_usuarios.Close;
dm.query_usuarios.SQL.clear;
dm.query_usuarios.SQL.Add('Select * from usuarios where cargo <> :cargo');
dm.query_usuarios.ParamByName('cargo').Value := 'Administrador';
dm.query_usuarios.Open;

end;

end.
