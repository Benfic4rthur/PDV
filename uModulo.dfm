object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 640
  Width = 981
  object fd: TFDConnection
    Params.Strings = (
      'Database=pdv'
      'User_Name=root'
      'Password=admin'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\Arthur Benfica\Documents\Embarcadero\Studio\Projects\PD' +
      'V\libmysql.dll'
    Left = 872
    Top = 24
  end
  object tb_Cargos: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    TableName = 'pdv.cargos'
    Left = 40
    Top = 104
  end
  object query_cargos: TFDQuery
    Active = True
    Connection = fd
    SQL.Strings = (
      'select * from cargos')
    Left = 40
    Top = 176
    object query_cargosid: TFDAutoIncField
      DisplayLabel = 'ID'
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object query_cargoscargo: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Cargo'
      FieldName = 'cargo'
      Origin = 'cargo'
      Size = 25
    end
  end
  object DScargos: TDataSource
    DataSet = query_cargos
    Left = 104
    Top = 176
  end
end
