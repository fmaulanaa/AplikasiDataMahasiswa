program Mahasiswa;

uses
  Forms,
  uDataMahasiswa in 'uDataMahasiswa.pas' {formDataMahasiswa},
  uDM in 'uDM.pas' {DM: TDataModule},
  uDataMahasiswaTambah in 'uDataMahasiswaTambah.pas' {fDataMahasiswaTambah},
  uUtama in 'uUtama.pas' {fUtama},
  uDetailDataMahasiswa in 'uDetailDataMahasiswa.pas' {FormDetailDataMahasiswa};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfUtama, fUtama);
  Application.CreateForm(TformDataMahasiswa, formDataMahasiswa);
  Application.CreateForm(TfDataMahasiswaTambah, fDataMahasiswaTambah);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormDetailDataMahasiswa, FormDetailDataMahasiswa);
  Application.Run;
end.
