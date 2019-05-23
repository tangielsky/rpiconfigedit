unit setup;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Buttons, Inifiles, LCLIntf;

type

  { TSetupForm }

  TSetupForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    ColorButton2: TColorButton;
    ColorButton1: TColorButton;
    ComboBoxLanguage: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    SpeedButton4: TSpeedButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    FFilename : string;


  public
    function ShowModal: Integer; override;
    procedure UpdateLanguage;
    procedure LoadConfig;
    procedure SaveConfig;

    property Filename : string read FFilename write FFilename;
  end;

var
  SetupForm: TSetupForm;

implementation

{$R *.lfm}

uses language, main, confed;

{ TSetupForm }

procedure TSetupForm.Button1Click(Sender: TObject);
begin
  if ComboBoxLanguage.ItemIndex<>-1 then
    begin
      Trans.Language:=copy(ComboBoxLanguage.Items[ComboBoxLanguage.ItemIndex],1,2);
      MainForm.UpdateLanguage;
    end;

  ConfigSetup.NoLineForDefaultValue:=CheckBox1.Checked;
  ConfigSetup.AddCommentsOnSave:=CheckBox2.Checked;
  ConfigSetup.CreateNewConfigOnSave:=CheckBox3.Checked;
  ConfigSetup.CreateBackupfiles:=CheckBox4.Checked;


  MainForm.SynAnySyn1.KeyAttri.Foreground:=ColorButton1.ButtonColor;
  MainForm.SynAnySyn1.SpaceAttri.Foreground:=MainForm.SynAnySyn1.KeyAttri.Foreground;
  MainForm.SynAnySyn1.StringAttri.Foreground:=MainForm.SynAnySyn1.KeyAttri.Foreground;
  MainForm.SynAnySyn1.VariableAttri.Foreground:=MainForm.SynAnySyn1.KeyAttri.Foreground;

  MainForm.SynAnySyn1.PreprocessorAttri.Foreground:=ColorButton2.ButtonColor;

  SaveConfig;
  Close;
end;

procedure TSetupForm.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TSetupForm.SpeedButton4Click(Sender: TObject);
begin
  OpenUrl(URL_TECHPLUSCODE+Trans.Text('Link-Einstellungen'));
end;

function TSetupForm.ShowModal: Integer;
var i : integer;
begin
  UpdateLanguage;

  ComboBoxLanguage.ItemIndex:=-1;
  for i:=0 to ComboBoxLanguage.Items.Count-1 do
    if Trans.Language=copy(ComboBoxLanguage.Items[i],1,2) then
      begin
        ComboBoxLanguage.ItemIndex:=i;
        break;
      end;

  CheckBox1.Checked:=ConfigSetup.NoLineForDefaultValue;
  CheckBox2.Checked:=ConfigSetup.AddCommentsOnSave;
  CheckBox3.Checked:=ConfigSetup.CreateNewConfigOnSave;
  CheckBox4.Checked:=ConfigSetup.CreateBackupfiles;

  ColorButton1.ButtonColor:=MainForm.SynAnySyn1.KeyAttri.Foreground;
  ColorButton2.ButtonColor:=MainForm.SynAnySyn1.PreprocessorAttri.Foreground;

  Result:=inherited ShowModal;
end;

procedure TSetupForm.UpdateLanguage;
begin
  Caption:=Trans.Text('Einstellungen');
  TabSheet1.Caption:=Trans.Text('Sprache');
  TabSheet2.Caption:=Trans.Text('Editor');
  Label6.Caption:=Trans.Text('Sprache');
  Button1.Caption:=Trans.Text('Ok');
  Button2.Caption:=Trans.Text('Abbruch');
  Checkbox1.Caption:=Trans.Text('NoLineForDefaultValue');
  Checkbox2.Caption:=Trans.Text('AddCommentsOnSave');
  Checkbox3.Caption:=Trans.Text('CreateNewConfigOnSave');
  Checkbox4.Caption:=Trans.Text('CreateBackupfiles');
  Label1.Caption:=Trans.Text('Keywords');
  Label2.Caption:=Trans.Text('Comments');
end;


procedure TSetupForm.LoadConfig;
var
  Ini : TInifile;
  i : integer;
  s : string;
begin
  try
    Ini:=TInifile.Create(FFilename);
    Trans.Language:=Ini.ReadString('Setup','Language','DE');
    ConfigSetup.NoLineForDefaultValue:=Ini.ReadBool('Setup','NoLineForDefaultValue',true);
    ConfigSetup.AddCommentsOnSave:=Ini.ReadBool('Setup','AddCommentsOnSave',false);
    ConfigSetup.CreateNewConfigOnSave:=Ini.ReadBool('Setup','CreateNewConfigOnSave',false);
    ConfigSetup.CreateBackupfiles:=Ini.ReadBool('Setup','CreateBackupfiles',true);

    MainForm.SynAnySyn1.KeyAttri.Foreground:=
      Ini.ReadInteger('Setup','Keywords',ColorToRGB(clGreen));
    MainForm.SynAnySyn1.SpaceAttri.Foreground:=MainForm.SynAnySyn1.KeyAttri.Foreground;
    MainForm.SynAnySyn1.StringAttri.Foreground:=MainForm.SynAnySyn1.KeyAttri.Foreground;
    MainForm.SynAnySyn1.VariableAttri.Foreground:=MainForm.SynAnySyn1.KeyAttri.Foreground;

    MainForm.SynAnySyn1.PreprocessorAttri.Foreground:=
      Ini.ReadInteger('Setup','Comments',ColorToRGB(clGray));

  finally
    Ini.Free;
  end;
end;

procedure TSetupForm.SaveConfig;
var
  Ini : TInifile;
  i : integer;
  s : string;
begin
  try
    Ini:=TInifile.Create(FFilename);
    Ini.WriteString('Setup','Language',Trans.Language);
    Ini.WriteBool('Setup','NoLineForDefaultValue',ConfigSetup.NoLineForDefaultValue);
    Ini.WriteBool('Setup','AddCommentsOnSave',ConfigSetup.AddCommentsOnSave);
    Ini.WriteBool('Setup','CreateNewConfigOnSave',ConfigSetup.CreateNewConfigOnSave);
    Ini.WriteBool('Setup','CreateBackupfiles',ConfigSetup.CreateBackupfiles);
    Ini.WriteInteger('Setup','Keywords',ColorToRGB(ColorButton1.ButtonColor));
    Ini.WriteInteger('Setup','Comments',ColorToRGB(ColorButton2.ButtonColor));
  finally
    Ini.Free;
  end;
end;


end.

