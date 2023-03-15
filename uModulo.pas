unit uModulo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet;

type
  Tdm = class(TDataModule)
    fd: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    tb_Cargos: TFDTable;
    query_cargos: TFDQuery;
    query_cargosid: TFDAutoIncField;
    query_cargoscargo: TStringField;
    DScargos: TDataSource;
    tb_Funcionarios: TFDTable;
    query_funcionarios: TFDQuery;
    DSfuncionarios: TDataSource;
    query_funcionariosid: TFDAutoIncField;
    query_funcionariosnome: TStringField;
    query_funcionarioscpf: TStringField;
    query_funcionariostelefone: TStringField;
    query_funcionariosendereco: TStringField;
    query_funcionarioscargo: TStringField;
    query_funcionariosdata: TDateField;
    tb_Usuarios: TFDTable;
    query_usuarios: TFDQuery;
    query_usuariosid: TFDAutoIncField;
    query_usuariosnome: TStringField;
    query_usuariosusuario: TStringField;
    query_usuariossenha: TStringField;
    query_usuariosidfuncionario: TStringField;
    query_usuarioscargo: TStringField;
    DSusuarios: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;
  //declaração das variaveis globais
  idfuncionario : String;
  nomeFuncionario: String;
  cargoFuncionario : String;
  chamada : String;
  nomeUsuario: String;
  cargoUsuario: String;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uFuncionarios, uUsuarios;

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
fd.Connected := True;
end;

end.
