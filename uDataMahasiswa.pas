unit uDataMahasiswa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ComObj;

type
  TformDataMahasiswa = class(TForm)
    bTambah: TButton;
    bUbah: TButton;
    bHapus: TButton;
    bBatal: TButton;
    bTutup: TButton;
    eCari: TEdit;
    bCari: TButton;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    bDetail: TButton;
    bDownloadData: TButton;
    procedure bTutupClick(Sender: TObject);
    procedure bBatalClick(Sender: TObject);
    procedure bCariClick(Sender: TObject);
    procedure bHapusClick(Sender: TObject);
    procedure bTambahClick(Sender: TObject);
    procedure bUbahClick(Sender: TObject);
    procedure bDetailClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bDownloadDataClick(Sender: TObject);
  private
    { Private declarations }
    procedure InisialisasiData;
  public
    { Public declarations }
  end;

var
  formDataMahasiswa: TformDataMahasiswa;

implementation

uses uDM, uDataMahasiswaTambah, uDetailDataMahasiswa;

{$R *.dfm}
procedure TformDataMahasiswa.InisialisasiData;
begin
  if not DM.aDataMahasiswa.Active then
    DM.aDataMahasiswa.Open;

  DBGrid1.DataSource := DM.dDataMahasiswa;
end;

procedure TformDataMahasiswa.FormCreate(Sender: TObject);
begin
  InisialisasiData;
end;


procedure TformDataMahasiswa.bTutupClick(Sender: TObject);
begin
Close;
end;

procedure TformDataMahasiswa.bBatalClick(Sender: TObject);
begin
  dm.aDataMahasiswa.Active := False;
  dm.aDataMahasiswa.SQL.Text := 'SELECT * FROM mahasiswa';
  dm.aDataMahasiswa.Active := True;
  eCari.Text := '';
end;

procedure TformDataMahasiswa.bCariClick(Sender: TObject);
begin
  dm.aDataMahasiswa.Active := False;
  dm.aDataMahasiswa.SQL.Text := 'SELECT * FROM mahasiswa WHERE NamaLengkap LIKE ''%' + eCari.Text + '%''';
  dm.aDataMahasiswa.Active := True;
end;

procedure TformDataMahasiswa.bHapusClick(Sender: TObject);
begin
  if MessageDlg('Data akan dihapus, Lanjutkan?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
  dm.aDataMahasiswa.Delete;
  end;
end;

procedure TformDataMahasiswa.bTambahClick(Sender: TObject);
begin
  if not DM.aDataMahasiswa.Active then
    DM.aDataMahasiswa.Open;

  fDataMahasiswaTambah.isTambah := True; // ? mode tambah
  fDataMahasiswaTambah.Caption := 'Tambah Data Mahasiswa';
  fDataMahasiswaTambah.eNamaLengkap.Clear;
  fDataMahasiswaTambah.eNIM.Clear;
  fDataMahasiswaTambah.eProgramStudi.Clear;
  fDataMahasiswaTambah.eFakultas.Clear;
  fDataMahasiswaTambah.eAlamatDomisili.Clear;
  fDataMahasiswaTambah.eNomorHP.Clear;
  fDataMahasiswaTambah.eEmail.Clear;
  fDataMahasiswaTambah.RadioGroup1.ItemIndex := -1;
  fDataMahasiswaTambah.eAgama.ItemIndex := -1;
  fDataMahasiswaTambah.DateTimePicker1.Date := Now;
  fDataMahasiswaTambah.Image1.Picture := nil;
  fDataMahasiswaTambah.DBImage1.Picture := nil;

  fDataMahasiswaTambah.ShowModal;
end;

procedure TformDataMahasiswa.bUbahClick(Sender: TObject);
begin
  if not DM.aDataMahasiswa.Active then
    DM.aDataMahasiswa.Open;

  if DM.aDataMahasiswa.IsEmpty then
  begin
    ShowMessage('Tidak ada data yang dipilih untuk diubah!');
    Exit;
  end;

  fDataMahasiswaTambah.isTambah := False; // mode ubah data
  fDataMahasiswaTambah.Caption := 'Ubah Data Mahasiswa';

  // Isi komponen form berdasarkan field database
  fDataMahasiswaTambah.eNIM.Text := DM.aDataMahasiswa.FieldByName('NIM').AsString;
  fDataMahasiswaTambah.eNamaLengkap.Text := DM.aDataMahasiswa.FieldByName('NamaLengkap').AsString;
  fDataMahasiswaTambah.eProgramStudi.Text := DM.aDataMahasiswa.FieldByName('ProgramStudi').AsString;
  fDataMahasiswaTambah.eFakultas.Text := DM.aDataMahasiswa.FieldByName('Fakultas').AsString;
  fDataMahasiswaTambah.eAlamatDomisili.Text := DM.aDataMahasiswa.FieldByName('AlamatDomisili').AsString;
  fDataMahasiswaTambah.eNomorHP.Text := DM.aDataMahasiswa.FieldByName('NomorHP').AsString;
  fDataMahasiswaTambah.eEmail.Text := DM.aDataMahasiswa.FieldByName('Email').AsString;

  // Jenis Kelamin (RadioGroup: 0 = Laki-laki, 1 = Perempuan)
  if DM.aDataMahasiswa.FieldByName('JenisKelamin').AsString = 'Laki-laki' then
    fDataMahasiswaTambah.RadioGroup1.ItemIndex := 0
  else
    fDataMahasiswaTambah.RadioGroup1.ItemIndex := 1;

  // Agama (ComboBox)
  fDataMahasiswaTambah.eAgama.Text := DM.aDataMahasiswa.FieldByName('Agama').AsString;

  // Tanggal Lahir
  fDataMahasiswaTambah.DateTimePicker1.Date := DM.aDataMahasiswa.FieldByName('TanggalLahir').AsDateTime;

  // Foto (dari field "foto" bertipe OLE Object)
  fDataMahasiswaTambah.DBImage1.Picture.Assign(DM.aDataMahasiswa.FieldByName('foto'));

  fDataMahasiswaTambah.ShowModal;
end;



procedure TformDataMahasiswa.bDetailClick(Sender: TObject);
var
  idMahasiswa: Integer;
begin
  if not DM.aDataMahasiswa.Active then
    DM.aDataMahasiswa.Open;

  if not DM.aDataMahasiswa.IsEmpty then
  begin
    idMahasiswa := DM.aDataMahasiswa.FieldByName('ID').AsInteger;

    FormDetailDataMahasiswa := TFormDetailDataMahasiswa.Create(Self);
    try
      FormDetailDataMahasiswa.TampilkanDetail(idMahasiswa);
      FormDetailDataMahasiswa.ShowModal;
    finally
      FormDetailDataMahasiswa.Free;
      FormDetailDataMahasiswa := nil;
    end;
  end
  else
    ShowMessage('Tidak ada data yang dipilih.');
end;

procedure TformDataMahasiswa.bDownloadDataClick(Sender: TObject);
var
  ExcelApp, Workbook, Worksheet: OleVariant;
  RowIndex, ColIndex: Integer;
  SavePath: string;
begin
  if not dm.aDataMahasiswa.Active then
    dm.aDataMahasiswa.Open;

  try
    // Buat instance Excel
    ExcelApp := CreateOleObject('Excel.Application');
    ExcelApp.Visible := False;
    Workbook := ExcelApp.Workbooks.Add;
    Worksheet := Workbook.Worksheets[1];

    // Tulis header kolom
    for ColIndex := 0 to dm.aDataMahasiswa.FieldCount - 1 do
    begin
      Worksheet.Cells[1, ColIndex + 1] := dm.aDataMahasiswa.Fields[ColIndex].FieldName;
    end;

    // Tulis isi data
    dm.aDataMahasiswa.First;
    RowIndex := 2;
    while not dm.aDataMahasiswa.Eof do
    begin
      for ColIndex := 0 to dm.aDataMahasiswa.FieldCount - 1 do
      begin
        Worksheet.Cells[RowIndex, ColIndex + 1] := dm.aDataMahasiswa.Fields[ColIndex].AsString;
      end;
      Inc(RowIndex);
      dm.aDataMahasiswa.Next;
    end;

    // Tentukan lokasi penyimpanan file
    SavePath := ExtractFilePath(Application.ExeName) + 'DataMahasiswa.xlsx';

    // Simpan file Excel
    Workbook.SaveAs(SavePath);
    Workbook.Close(False);
    ExcelApp.Quit;

    ShowMessage('Data berhasil diekspor ke file Excel (.xlsx): ' + SavePath);
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan saat ekspor ke Excel: ' + E.Message);
  end;
end;





end.
