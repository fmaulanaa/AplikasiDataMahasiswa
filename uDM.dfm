object DM: TDM
  OldCreateOrder = False
  Left = 197
  Top = 67
  Height = 245
  Width = 368
  object CON: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\Administra' +
      'tor\Desktop\Aplikasi Data Mahasiswa\mahasiswa.mdb;Persist Securi' +
      'ty Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 16
  end
  object aDataMahasiswa: TADOQuery
    Active = True
    Connection = CON
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM mahasiswa')
    Left = 104
    Top = 24
  end
  object dDataMahasiswa: TDataSource
    DataSet = aDataMahasiswa
    Left = 96
    Top = 112
  end
end
