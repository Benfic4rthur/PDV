unit uCargos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls;

type
  TFrmCargos = class(TForm)
    lblNome: TLabel;
    TxtNomeFuncionario: TEdit;
    grid: TDBGrid;
    BtnNovo: TSpeedButton;
    BtnSalvar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure associarCampos;
    procedure listar;
  public
    { Public declarations }
  end;

var
  FrmCargos: TFrmCargos;

implementation

{$R *.dfm}
uses
 uModulo;


procedure TFrmCargos.associarCampos;
begin
 dm.tb_Cargos.FieldByName('cargo').Value := TxtNomeFuncionario.Text;
end;

procedure TFrmCargos.BtnNovoClick(Sender: TObject);
begin
btnSalvar.Enabled := true;
TxtNomeFuncionario.Enabled := true;
TxtNomeFuncionario.Text := '';
TxtNomeFuncionario.setFocus;

dm.fd.StartTransaction;
dm.tb_Cargos.Insert;

end;

procedure TFrmCargos.BtnSalvarClick(Sender: TObject);
var
cargo : string;
begin
if Trim(TxtNomeFuncionario.Text) = '' then
begin
      MessageDlg('Preencha o cargo!', TMsgDlgType.mtWarning, mbOKCancel, 0);
      TxtNomeFuncionario.SetFocus;
      exit;
end;
//verificar se cargo ja existe
dm.query_cargos.SQL.clear;
dm.query_cargos.SQL.Add('Select * from cargos where cargo = ' + QuotedStr(Trim(TxtNomeFuncionario.Text)) );
dm.query_cargos.Open;

if not dm.query_cargos.IsEmpty then
begin
cargo := dm.query_cargos['cargo'];
MessageDlg('o cargo '+ cargo + ' j� esta cadastrado!', mtInformation, mbOKCancel, 0);
TxtNomeFuncionario.Text := '';
TxtNomeFuncionario.SetFocus;
exit;
end;


associarCampos;
dm.tb_Cargos.Post;
dm.fd.Commit;
MessageDlg('Salvo com sucesso!', mtInformation, mbOKCancel, 0);
TxtNomeFuncionario.Text := '';
TxtNomeFuncionario.Enabled := false;
btnSalvar.Enabled := false;
listar;
end;

procedure TFrmCargos.FormCreate(Sender: TObject);
begin
dm.tb_Cargos.Active := true;
listar;
end;

procedure TFrmCargos.listar;
begin
dm.query_cargos.Close;
dm.query_cargos.SQL.clear;
dm.query_cargos.SQL.Add('Select * from cargos');
dm.query_cargos.Open;
end;

end.
