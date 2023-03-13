unit uFuncionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Data.DB,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids;

type
  TFrmFuncionarios = class(TForm)
    TxtBuscarNome: TEdit;
    RbCpf: TRadioButton;
    RbNome: TRadioButton;
    TxtBuscarCpf: TMaskEdit;
    Label1: TLabel;
    lblNome: TLabel;
    TxtNomeFuncionario: TEdit;
    CpfMaskFuncionario: TMaskEdit;
    LblCpfFuncionario: TLabel;
    LblTelefoneFuncionario: TLabel;
    MaskEdit1: TMaskEdit;
    LblEnderecoFuncionario: TLabel;
    TxtEnderecoFuncionario: TEdit;
    LblCargoFuncionario: TLabel;
    ComboBox1: TComboBox;
    DBGrid1: TDBGrid;
    BtnNovo: TSpeedButton;
    BtnSalvar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnExcluir: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFuncionarios: TFrmFuncionarios;

implementation

{$R *.dfm}

end.
