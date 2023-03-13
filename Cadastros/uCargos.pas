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
    DBGrid1: TDBGrid;
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
  public
    { Public declarations }
  end;

var
  FrmCargos: TFrmCargos;

implementation

{$R *.dfm}

uses uModulo;

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

dm.tb_Cargos.Insert;

end;

procedure TFrmCargos.BtnSalvarClick(Sender: TObject);
begin
associarCampos;
dm.tb_Cargos.Post;
MessageDlg('Salvo com sucesso!', mtInformation, mbOKCancel, 0);
end;

procedure TFrmCargos.FormCreate(Sender: TObject);
begin
dm.tb_Cargos.Active := true;
end;

end.