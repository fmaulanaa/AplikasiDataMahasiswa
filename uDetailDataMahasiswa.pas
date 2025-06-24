unit uDetailDataMahasiswa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, DB;

type
  TFormDetailDataMahasiswa = class(TForm)
    eNIM: TEdit;
    eNamaLengkap: TEdit;
    eProgramStudi: TEdit;
    eFakultas: TEdit;
    eNomorHP: TEdit;
    eEmail: TEdit;
    eAgama: TEdit;
    eJenisKelamin: TEdit;
    eTanggalLahir: TEdit;
    eAlamatDomisili: TMemo;
    DBImage1: TDBImage;
    bTutup: TButton;

    procedure bTutupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure AturReadonlySemuaInput;
  public
    procedure TampilkanDetail(id: Integer);
  end;

var
  FormDetailDataMahasiswa: TFormDetailDataMahasiswa;

implementation

uses
  uDM;

{$R *.dfm}

procedure TFormDetailDataMahasiswa.AturReadonlySemuaInput;
begin
  eNIM.ReadOnly := True;
  eNamaLengkap.ReadOnly := True;
  eProgramStudi.ReadOnly := True;
  eFakultas.ReadOnly := True;
  eNomorHP.ReadOnly := True;
  eEmail.ReadOnly := True;
  eAgama.ReadOnly := True;
  eJenisKelamin.ReadOnly := True;
  eTanggalLahir.ReadOnly := True;
  eAlamatDomisili.ReadOnly := True;
end;

procedure TFormDetailDataMahasiswa.FormCreate(Sender: TObject);
begin
  AturReadonlySemuaInput;
end;

procedure TFormDetailDataMahasiswa.bTutupClick(Sender: TObject);
begin
  Close;
end;

procedure TFormDetailDataMahasiswa.TampilkanDetail(id: Integer);
begin
  with dm.aDataMahasiswa do
  begin
    Close;
    SQL.Text := 'SELECT * FROM mahasiswa WHERE ID = :id';
    Parameters.ParamByName('id').Value := id;
    Open;

    if not IsEmpty then
    begin
      eNIM.Text := FieldByName('NIM').AsString;
      eNamaLengkap.Text := FieldByName('NamaLengkap').AsString;
      eProgramStudi.Text := FieldByName('ProgramStudi').AsString;
      eFakultas.Text := FieldByName('Fakultas').AsString;
      eAlamatDomisili.Lines.Text := FieldByName('AlamatDomisili').AsString;
      eNomorHP.Text := FieldByName('NomorHP').AsString;
      eEmail.Text := FieldByName('Email').AsString;
      eAgama.Text := FieldByName('Agama').AsString;
      eJenisKelamin.Text := FieldByName('JenisKelamin').AsString;
      eTanggalLahir.Text := FormatDateTime('dd-mm-yyyy', FieldByName('TanggalLahir').AsDateTime);

      // Tampilkan foto jika ada
      if not FieldByName('foto').IsNull then
        DBImage1.Picture.Assign(FieldByName('foto'))
      else
        DBImage1.Picture := nil;
    end
    else
    begin
      ShowMessage('Data dengan ID tersebut tidak ditemukan.');
      Close;
    end;
  end;
end;

end.
