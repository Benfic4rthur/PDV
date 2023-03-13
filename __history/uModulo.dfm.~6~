object dm: Tdm
  OldCreateOrder = False
  Height = 423
  Width = 812
  object fd: TFDConnection
    Params.Strings = (
      'Database=pdv'
      'User_Name=root'
      'Password=admin'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 8
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\Arthur Benfica\Documents\Embarcadero\Studio\Projects\PD' +
      'V\libmysql.dll'
    Left = 728
    Top = 8
  end
  object tb_Cargos: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    TableName = 'pdv.cargos'
    Left = 24
    Top = 72
    object tb_Cargosid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object tb_Cargoscargo: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cargo'
      Origin = 'cargo'
      Size = 25
    end
  end
  object query_cargos: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select * from cargos;')
    Left = 24
    Top = 144
    object query_cargosid: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object query_cargoscargo: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Cargo'
      FieldName = 'cargo'
      Origin = 'cargo'
      Size = 25
    end
  end
end
