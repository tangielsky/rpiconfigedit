unit wifisetup;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TWifiSetupForm }

  TWifiSetupForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    EditSSID: TEdit;
    EditPSK: TEdit;
    EditCountry: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure UpdateLanguage;

  public
    function ShowModal: Integer; override;

  end;

var
  WifiSetupForm: TWifiSetupForm;

implementation

uses Main, language;

{$R *.lfm}

{ TWifiSetupForm }

procedure TWifiSetupForm.Button1Click(Sender: TObject);
var sl : TStringList;
begin
  Close;
  MainForm.SelectDirectoryDialog1.Title:=Trans.Text('DateiSpeichernWIFI');
  if MainForm.SelectDirectoryDialog1.Execute then
    begin
      sl:=TStringList.Create;            sl.Add('');
      sl.Add('ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev');
      sl.Add('update_config=1');
      sl.Add('country='+EditCountry.Text);
      sl.Add('network={');
      sl.Add('  ssid="'+EditSSID.Text+'"');
      sl.Add('  psk="'+EditPSK.Text+'"');
      sl.Add('}');
      sl.SaveToFile(MainForm.SelectDirectoryDialog1.FileName+PathDelim+'wpa_supplicant.conf');
      MessageDlg(Trans.Text('Wifigespeichert')+#10#13
        +MainForm.SelectDirectoryDialog1.FileName+PathDelim+'wpa_supplicant.conf',mtInformation,[mbOk],0);
      sl.Free;
   end;

end;

procedure TWifiSetupForm.Button2Click(Sender: TObject);
begin
  Close;
end;


procedure TWifiSetupForm.UpdateLanguage;
begin
  Caption:=Trans.Text('WifiSetup');
  Label3.Caption:=Trans.Text('Laendercode');
  Button1.Caption:=Trans.Text('Ok');
  Button2.Caption:=Trans.Text('Abbruch');
end;

function TWifiSetupForm.ShowModal: Integer;
begin
  UpdateLanguage;

  Result:=inherited ShowModal;
end;

end.

