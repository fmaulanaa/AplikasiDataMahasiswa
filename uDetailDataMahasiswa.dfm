object FormDetailDataMahasiswa: TFormDetailDataMahasiswa
  Left = 522
  Top = 134
  Width = 459
  Height = 427
  Caption = 'Form Detail Data Mahasiswa'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object eNIM: TEdit
    Left = 56
    Top = 24
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object eNamaLengkap: TEdit
    Left = 56
    Top = 56
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object eProgramStudi: TEdit
    Left = 56
    Top = 88
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object eFakultas: TEdit
    Left = 56
    Top = 120
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object eNomorHP: TEdit
    Left = 56
    Top = 152
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 4
  end
  object eEmail: TEdit
    Left = 56
    Top = 184
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 5
  end
  object eAgama: TEdit
    Left = 56
    Top = 216
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 6
  end
  object eJenisKelamin: TEdit
    Left = 56
    Top = 248
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 7
  end
  object eTanggalLahir: TEdit
    Left = 56
    Top = 280
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 8
  end
  object eAlamatDomisili: TMemo
    Left = 208
    Top = 192
    Width = 185
    Height = 89
    Lines.Strings = (
      'eAlamatDomisili')
    ReadOnly = True
    TabOrder = 9
  end
  object DBImage1: TDBImage
    Left = 232
    Top = 24
    Width = 137
    Height = 137
    DataField = 'foto'
    DataSource = DM.dDataMahasiswa
    TabOrder = 10
  end
  object bTutup: TButton
    Left = 184
    Top = 328
    Width = 75
    Height = 25
    Caption = '&Tutup'
    TabOrder = 11
    OnClick = bTutupClick
  end
end
