unit uDataMahasiswaTambah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, DBCtrls, ExtDlgs, jpeg;

type
  TfDataMahasiswaTambah = class(TForm)
    eNIM: TEdit;
    Label1: TLabel;
    eNamaLengkap: TEdit;
    eNomorHP: TEdit;
    eEmail: TEdit;
    RadioGroup1: TRadioGroup;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label8: TLabel;
    eAgama: TComboBox;
    Label9: TLabel;
    Label10: TLabel;
    DBImage1: TDBImage;
    bSimpan: TButton;
    bBatal: TButton;
    Button3: TButton;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    eAlamatDomisili: TMemo;
    eFakultas: TEdit;
    eProgramStudi: TEdit;
    procedure bBatalClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure bSimpanClick(Sender: TObject);
  private
    { Private declarations }
  public
  isTambah: Boolean;
    { Public declarations }
  end;

var
  fDataMahasiswaTambah: TfDataMahasiswaTambah;

implementation

uses uDM, uDataMahasiswa, Clipbrd;

{$R *.dfm}

procedure TfDataMahasiswaTambah.bBatalClick(Sender: TObject);
begin
  Close;
end;

procedure TfDataMahasiswaTambah.Button3Click(Sender: TObject);
begin
  if not OpenPictureDialog1.Execute then Exit;
  Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
end;


procedure TfDataMahasiswaTambah.bSimpanClick(Sender: TObject);
begin
  if Trim(eNIM.Text) = '' then
  begin
    ShowMessage('NIM tidak boleh kosong!');
    Exit;
  end;

  if not dm.aDataMahasiswa.Active then
    dm.aDataMahasiswa.Open;

  try
    if isTambah then
      dm.aDataMahasiswa.Append
    else
      dm.aDataMahasiswa.Edit;

    with dm.aDataMahasiswa do
    begin
      FieldByName('NamaLengkap').AsString := eNamaLengkap.Text;
      FieldByName('NIM').AsString := eNIM.Text;       
      FieldByName('ProgramStudi').AsString := eProgramStudi.Text;
      FieldByName('Fakultas').AsString := 'Fakultas Ilmu Komputer';
      FieldByName('AlamatDomisili').AsString := eAlamatDomisili.Text;
      FieldByName('NomorHP').AsString := eNomorHP.Text;
      FieldByName('Email').AsString := eEmail.Text;


      if RadioGroup1.ItemIndex = 0 then
        FieldByName('JenisKelamin').AsString := 'Laki-laki'
      else if RadioGroup1.ItemIndex = 1 then
        FieldByName('JenisKelamin').AsString := 'Perempuan';

      FieldByName('TanggalLahir').AsDateTime := DateTimePicker1.Date;
      FieldByName('Agama').AsString := eAgama.Text;

      if not Image1.Picture.Graphic.Empty then
      begin
        Clipboard.Assign(Image1.Picture.Graphic);
        DBImage1.PasteFromClipboard;
      end;
    end;

    dm.aDataMahasiswa.Post;
    ShowMessage('Data berhasil disimpan.');
    Close;

  except
    on E: Exception do
      ShowMessage('Gagal menyimpan: ' + E.Message);
  end;
end;
end.
