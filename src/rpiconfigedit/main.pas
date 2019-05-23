unit main;


{
Raspberry Pi Config Editor

https://techpluscode.de/rpiconfigedit/
https://techpluscode.de/rpiconfigedit-en/


(C) 2019 Thomas Angielsky



The project needs the package ConfEd.

Version 1.0

}



{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ActnList,
  ExtCtrls, ComCtrls, StdCtrls, ComboEx, Spin, Grids, LCLIntf, Buttons, confed,
  about, functions, SynEdit, SynHighlighterAny, Translations, language, Types,
  wifisetup;


const
  BOOT_CONFIG_TXT = '/boot/config.txt';
  FILE_LANGUAGE = 'language.conf';
  FILE_CONFIG = 'rpiconfigedit.conf';
  BACKUP_EXTENSION = '.bak';
  URL_RASPBERRYPIORG = 'https://raspberrypi.org/';
  URL_TECHPLUSCODE = 'https://techpluscode.de/rpiconfigedit';


type

  TPropLine=(plProp,plCommentNoProp,plCommentProp,plNone);


  { TMainForm }

  TMainForm = class(TForm)
    ActionRaspberryWeb2: TAction;
    ActionHelp2: TAction;
    ActionSaveConfig2: TAction;
    ActionOpenConfig2: TAction;
    ActionNewConfig2: TAction;
    ActionListIcon: TActionList;
    ActionSaveWifi: TAction;
    ActionSaveSSH: TAction;
    ActionSetupPage: TAction;
    ActionLanguageEN: TAction;
    ActionLanguageDE: TAction;
    ActionTechPlusCode: TAction;
    ActionRaspberryWeb: TAction;
    ActionAbout: TAction;
    ActionNewConfig: TAction;
    ActionHelp: TAction;
    ActionSaveConfigAs: TAction;
    ActionClose: TAction;
    ActionSaveConfig: TAction;
    ActionOpenConfig: TAction;
    ActionOpenBootConfig: TAction;
    ActionListMenue: TActionList;
    ConfigPanel1: TConfigPanel;
    ConfigPanel10: TConfigPanel;
    ConfigPanel11: TConfigPanel;
    ConfigPanel12: TConfigPanel;
    ConfigPanel13: TConfigPanel;
    ConfigPanel14: TConfigPanel;
    ConfigPanel15: TConfigPanel;
    ConfigPanel16: TConfigPanel;
    cpDpiGroup: TConfigPanel;
    cpDpiMode: TConfigPanel;
    cpDpiTimings1: TConfigPanel;
    cpHdmiTimings: TConfigPanel;
    cpHdmiCvt: TConfigPanel;
    cpDisableCameraLed: TConfigPanel;
    cpDisableL2Cache: TConfigPanel;
    cpDisableTouchscreen: TConfigPanel;
    cpEnableDpiLcd: TConfigPanel;
    cpLcdRotate: TConfigPanel;
    cpDtparamAudio: TConfigPanel;
    cpDtparamI2CARM: TConfigPanel;
    cpDtparamI2S: TConfigPanel;
    cpDtparamSPI: TConfigPanel;
    cpEdidContextType: TConfigPanel;
    cpGPUMem: TConfigPanel;
    cpGPUMem1024: TConfigPanel;
    cpGPUMem256: TConfigPanel;
    cpGPUMem512: TConfigPanel;
    cpEdidContentType: TConfigPanel;
    cpHdmiForceMode: TConfigPanel;
    cpIgnoreLcd: TConfigPanel;
    cpMaxUsbCurrent: TConfigPanel;
    cpLcdFramerate: TConfigPanel;
    cpStartX: TConfigPanel;
    cpStartDebug: TConfigPanel;
    cpDisableOverscan: TConfigPanel;
    cpFramebufferIgnoreAlpha: TConfigPanel;
    cpFramebufferDepth: TConfigPanel;
    cpFramebufferWidth: TConfigPanel;
    cpFramebufferHeight: TConfigPanel;
    cpOverscanLeft: TConfigPanel;
    cpOverscanBottom: TConfigPanel;
    cpOverscanTop: TConfigPanel;
    cpOverscanRight: TConfigPanel;
    cpDisplayRotate: TConfigPanel;
    ConfigPanel2: TConfigPanel;
    ConfigPanel3: TConfigPanel;
    ConfigPanel4: TConfigPanel;
    ConfigPanel5: TConfigPanel;
    ConfigPanel6: TConfigPanel;
    ConfigPanel7: TConfigPanel;
    ConfigPanel8: TConfigPanel;
    ConfigPanel9: TConfigPanel;
    cpAvoidWarnings: TConfigPanel;
    cpHdmiIgnoreCecInit: TConfigPanel;
    cpHdmiForceEdidAudio: TConfigPanel;
    cpHdmiForceEdid3d: TConfigPanel;
    cpHdmiIgnoreCec: TConfigPanel;
    cpHdmiIgnoreEdid: TConfigPanel;
    cpHdmiGroup: TConfigPanel;
    cpHdmiEdidFile: TConfigPanel;
    cpHdmiMode: TConfigPanel;
    cpHdmiBlanking: TConfigPanel;
    cpCecOsdName: TConfigPanel;
    cpHdmiDrive: TConfigPanel;
    cpConfigHdmiBoost: TConfigPanel;
    cpHdmiSafe: TConfigPanel;
    cpSdtvDisableColourburst: TConfigPanel;
    cpSdTVMode: TConfigPanel;
    cpSdTVAspect: TConfigPanel;
    cpArmControl: TConfigPanel;
    cpBootcodeDelay: TConfigPanel;
    cpBootDelay: TConfigPanel;
    cpBootDelayMs: TConfigPanel;
    cpDecodeMPG2: TConfigPanel;
    cpDecodeWVC1: TConfigPanel;
    cpDisableAudioDither: TConfigPanel;
    cpDisableSplash: TConfigPanel;
    cpFixupFile: TConfigPanel;
    cpStartFile: TConfigPanel;
    cpUsbBootMode: TConfigPanel;
    ImageListIcon: TImageList;
    ImageListMenue: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label34: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabelBootDelay: TLabel;
    MenuItem1: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem2: TMenuItem;
    N13: TMenuItem;
    N12: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    N9: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    N4: TMenuItem;
    N3: TMenuItem;
    N1: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    N2: TMenuItem;
    N8: TMenuItem;
    N7: TMenuItem;
    N6: TMenuItem;
    N5: TMenuItem;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel2: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    Panel24: TPanel;
    Panel25: TPanel;
    Panel26: TPanel;
    Panel27: TPanel;
    Panel28: TPanel;
    Panel29: TPanel;
    Panel3: TPanel;
    Panel30: TPanel;
    Panel31: TPanel;
    Panel32: TPanel;
    Panel33: TPanel;
    Panel34: TPanel;
    Panel35: TPanel;
    Panel36: TPanel;
    Panel37: TPanel;
    Panel38: TPanel;
    Panel39: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    PopupMenuHelp: TPopupMenu;
    PopupMenuFile: TPopupMenu;
    PopupMenuTotal: TPopupMenu;
    SaveDialog1: TSaveDialog;
    ScrollBox1: TScrollBox;
    ScrollBox10: TScrollBox;
    ScrollBox11: TScrollBox;
    ScrollBox12: TScrollBox;
    ScrollBox13: TScrollBox;
    ScrollBox14: TScrollBox;
    ScrollBox15: TScrollBox;
    ScrollBox17: TScrollBox;
    ScrollBox18: TScrollBox;
    ScrollBox19: TScrollBox;
    ScrollBox2: TScrollBox;
    ScrollBox20: TScrollBox;
    ScrollBox3: TScrollBox;
    ScrollBox4: TScrollBox;
    ScrollBox5: TScrollBox;
    ScrollBox6: TScrollBox;
    ScrollBox7: TScrollBox;
    ScrollBox8: TScrollBox;
    ScrollBox9: TScrollBox;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Splitter2: TSplitter;
    StatusBar1: TStatusBar;
    SynAnySyn1: TSynAnySyn;
    SynEdit1: TSynEdit;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    TabSheet15: TTabSheet;
    TabSheet16: TTabSheet;
    TabSheet17: TTabSheet;
    TabSheet18: TTabSheet;
    TabSheet19: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet20: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheetEditor: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheetEmpty: TTabSheet;
    TreeView1: TTreeView;
    procedure ActionAboutExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure ActionHelp2Execute(Sender: TObject);
    procedure ActionHelpExecute(Sender: TObject);
    procedure ActionLanguageDEExecute(Sender: TObject);
    procedure ActionLanguageENExecute(Sender: TObject);
    procedure ActionNewConfig2Execute(Sender: TObject);
    procedure ActionNewConfigExecute(Sender: TObject);
    procedure ActionOpenBootConfigExecute(Sender: TObject);
    procedure ActionOpenConfig2Execute(Sender: TObject);
    procedure ActionOpenConfigExecute(Sender: TObject);
    procedure ActionRaspberryWeb2Execute(Sender: TObject);
    procedure ActionRaspberryWebExecute(Sender: TObject);
    procedure ActionSaveConfig2Execute(Sender: TObject);
    procedure ActionSaveConfigAsExecute(Sender: TObject);
    procedure ActionSaveConfigExecute(Sender: TObject);
    procedure ActionSaveSSHExecute(Sender: TObject);
    procedure ActionSaveWifiExecute(Sender: TObject);
    procedure ActionSetupPageExecute(Sender: TObject);
    procedure ActionTechPlusCodeExecute(Sender: TObject);
    procedure cpBootcodeDelayValueChange(Sender: TObject);
    procedure cpBootDelayMsValueChange(Sender: TObject);
    procedure cpBootDelayValueChange(Sender: TObject);
    procedure cpDpiGroupValueChange(Sender: TObject);
    procedure cpHdmiGroupValueChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
  private
    Language : string;
    ConfigFilename : string;
    TreeviewChange : boolean;
    FirstStart : boolean;

    procedure AddModes(cp: TConfigPanel; group : string);
    function IsPropComment(s : string; cp : TConfigPanel) : TPropLine;
    function FileChangedGoOn: boolean;
    procedure LoadConfigTxt(Filename: string);
    procedure NewConfigTxt;
    procedure SaveConfigTxt(Filename: string);
    procedure SearchComponents(Component: TWinControl);
    function SearchReplaceConfig(cp : TConfigPanel) : boolean;
    procedure SetEdit(prop, value: string);
    procedure UpdateConfigPanelsFromEditor;
    procedure UpdateEditorFromConfigPanels;
    procedure UpdateLabelBootDelay;
    procedure UpdatePageControl(s : string);
    procedure UpdateFilename;
  public
    procedure UpdateLanguage;

  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

uses Inifiles, setup;


{ TMainForm }


function TMainForm.IsPropComment(s : string; cp : TConfigPanel) : TPropLine;
var
  p,q,i : integer;
  eq : boolean;
begin
  result:=plNone;
  p:=Pos('#',s);
  q:=Pos(Uppercase(cp.Prop),Uppercase(s));

  if q>0 then
    begin
      //Check if next char is a =
      eq:=false;
      i:=q+length(cp.prop)-1;
      while i<length(s) do
        begin
          i:=i+1;
          if copy(s,i,1)='=' then
            begin
              eq:=true;
              break;
            end
          else if copy(s,i,1)=' ' then
            begin
            end
          else
            begin
              break;
            end;
        end;
       if eq=false then q:=0;
    end;

  if p>0 then
    begin
      //comment
      if q>0 then
        begin
          //Prop found
          if q>p then result:=plCommentProp
          else result:=plProp;
        end else result:=plCommentNoProp;
    end
  else
    begin
      //no comment
      if q>0 then result:=plProp;
    end;
end;





function TMainForm.SearchReplaceConfig(cp : TConfigPanel) : boolean;
var
  i,p,q : integer;
  s,vor,nach,kommentar : string;
  geaendert : boolean;

{
1. Search all props in text - no comments
   if found first, then set NewValue, set all other a #

2. If nothing was found, then search for prop in comments
   if found first, then delete comment line and set NewValue

3. If nothing was found, add new line at the end of the text.

}
begin
  result:=false;

  geaendert:=false;
  for i:=0 to SynEdit1.Lines.Count-1 do
    if IsPropComment(SynEdit1.Lines[i],cp)=plProp then
      begin
        if geaendert=false then
          begin
            //Set prop to NewValue
            if cp.ConfigLine<>'' then
              SynEdit1.Lines[i]:=cp.ConfigLine
            else SynEdit1.Lines[i]:='# '+trim(SynEdit1.Lines[i]);
            geaendert:=true;
          end
        else
          begin
            //all other props are comment
            SynEdit1.Lines[i]:='# '+SynEdit1.Lines[i];
          end;
      end;
  if geaendert=false then
    begin
      //2. If nothing was found, then search for prop in comments
      //   if found first, then delete comment line and set NewValue
      for i:=0 to SynEdit1.Lines.Count-1 do
        if IsPropComment(SynEdit1.Lines[i],cp)=plCommentProp then
          begin
            if geaendert=false then
              begin
                //Set prop to NewValue
                //Delete comment
                //..
                if cp.ConfigLine<>'' then SynEdit1.Lines[i]:=cp.ConfigLine;
                geaendert:=true;
                break;
              end;
          end;

    end;

  if geaendert=false then
    begin
      if cp.ConfigLine<>'' then SynEdit1.Lines.Add(cp.ConfigLine);
    end;

end;



procedure TMainForm.SetEdit(prop,value : string);
var
  unknown : boolean;
  cp : TConfigPanel;
  i : integer;
begin
  unknown:=true;


  for i:=0 to ComponentCount-1 do
    begin
      if Components[i] is TConfigPanel then
        begin
          cp:=TConfigPanel(Components[i]);
          if cp.Prop=prop then  //found ConfigPanel
            begin
              unknown:=not cp.ReadConfig(value);
              if unknown=false then break;
            end;
        end;
    end;

end;



procedure TMainForm.NewConfigTxt;
begin
  LoadConfigTxt('');
end;


procedure TMainForm.SearchComponents(Component : TWinControl);
var
  k : integer;
  cp : TConfigPanel;
begin
  if (Component is TConfigPanel) then
    begin
      cp:=TConfigPanel(Component);

      if ConfigSetup.CreateNewConfigOnSave then
        begin
          if ConfigSetup.AddCommentsOnSave then
            if (ConfigSetup.NoLineForDefaultValue=true) and (cp.Value<>cp.DefaultValue) then
              begin
                SynEdit1.Lines.Add('# '+cp.Title);
                SynEdit1.Lines.Add('# '+cp.Comment);
              end;
          if cp.ConfigLine<>'' then SynEdit1.Lines.Add(cp.ConfigLine);
        end
      else
        begin
           SearchReplaceConfig(cp);
        end;
    end;

  for k:=0 To Component.ControlCount-1 do
    if Component.Controls[k] is TWinControl then
     SearchComponents(TWinControl(Component.Controls[k]));

end;

procedure TMainForm.UpdateEditorFromConfigPanels;
var
  i,j,k : integer;
  cp : TConfigPanel;
  TabSheet : TTabSheet;
begin
  if ConfigSetup.CreateNewConfigOnSave=true then
    SynEdit1.Lines.Clear;

  for i:=0 to TreeView1.Items.Count-1 do
    begin
      //is there a page for that?
      for j:=0 to PageControl1.PageCount-1 do
        begin
          if PageControl1.Pages[j].Caption=Trans.Code(TreeView1.Items[i].Text) then
            begin
              TabSheet:=PageControl1.Pages[j];
              SearchComponents(TabSheet);

              break;
            end;
        end;
    end;

end;


procedure TMainForm.UpdateConfigPanelsFromEditor;
var
  i,j,p : integer;
  s : string;
  prop,value : string;
  cp : TConfigPanel;
begin

  for i:=0 to ComponentCount-1 do
    begin
      if Components[i] is TConfigPanel then
        begin
          cp:=TConfigPanel(Components[i]);
          cp.SetToDefaultValue;
        end;
    end;


  //Interprete the config.txt file into the visual editor

  for i:=0 to SynEdit1.Lines.Count-1 do
    begin
      s:=trim(SynEdit1.Lines[i]);
      if (s<>'') then
        if (copy(s,1,1)<>'#') then
            for j:=0 to ComponentCount-1 do
              begin
                if Components[j] is TConfigPanel then
                  begin
                    cp:=TConfigPanel(Components[j]);
                    if IsPropComment(s,cp)=plProp then
                      begin
                        //Property found
                        //read it
                        cp.ReadValueFromString(s);
                        break;
                      end;
                  end;
              end;
    end;
  cpBootcodeDelayValueChange(nil);
end;

procedure TMainForm.SaveConfigTxt(Filename : string);
var
  i,j,k : integer;

begin
  UpdateFilename;

  Screen.Cursor:=crHourglass;

  UpdateEditorFromConfigPanels;

  if FileExists(Filename) and (ConfigSetup.CreateBackupfiles=true) then
    begin
      //Create Backup-file
      RenameFile(Filename,ChangeFileExt(Filename,BACKUP_EXTENSION));
    end;

  try
    SynEdit1.Lines.SaveToFile(Filename);
    SynEdit1.Modified:=false;
  except
    MessageDlg(Trans.Text('Msg-SpeichernFehler')
      +#10#13+Filename,mtWarning,[mbOk],0);
  end;

  Screen.Cursor:=crDefault;
end;

procedure TMainForm.LoadConfigTxt(Filename : string);
var
  i,j,p : integer;
  s : string;
  prop,value : string;
  cp : TConfigPanel;

begin
  Screen.Cursor:=crHourglass;
  if Filename='' then
    begin
      //create a new file
      Filename:=Trans.Text('neue_config.txt');
      SynEdit1.Lines.Clear;
    end
  else
    begin
      //load a file
      try
        SynEdit1.Lines.LoadFromFile(Filename);
      except
        MessageDlg(Trans.Text('Msg-DateiOeffenFehler')+#10#13+Filename,
          mtWarning,[mbOK],0);
      end;
    end;

  ConfigFilename:=Filename;
  UpdateFilename;

  UpdateConfigPanelsFromEditor;

  Screen.Cursor:=crDefault;
end;

procedure TMainForm.ActionOpenBootConfigExecute(Sender: TObject);
begin
  if FileExists(BOOT_CONFIG_TXT) then LoadConfigTxt(BOOT_CONFIG_TXT);
end;

procedure TMainForm.ActionOpenConfig2Execute(Sender: TObject);
begin
  ActionOpenConfigExecute(Sender);
end;

procedure TMainForm.ActionOpenConfigExecute(Sender: TObject);
begin
  if FileChangedGoOn=false then exit;

  if FileExists(ConfigFilename)=true then OpenDialog1.Filename:=ConfigFilename;
  if OpenDialog1.Execute then
    begin
      ConfigFilename:=OpenDialog1.Filename;
      LoadConfigTxt(ConfigFilename);
    end;
end;

procedure TMainForm.ActionRaspberryWeb2Execute(Sender: TObject);
begin
  ActionRaspberryWebExecute(Sender);
end;

procedure TMainForm.ActionRaspberryWebExecute(Sender: TObject);
begin
  OpenUrl(URL_RASPBERRYPIORG);
end;

procedure TMainForm.ActionSaveConfig2Execute(Sender: TObject);
begin
  ActionSaveConfigExecute(Sender);
end;

procedure TMainForm.ActionSaveConfigAsExecute(Sender: TObject);
begin
  if FileExists(ConfigFilename)=true then SaveDialog1.Filename:=ConfigFilename;
  if SaveDialog1.Execute then
    begin
      ConfigFilename:=SaveDialog1.Filename;
      SaveConfigTxt(ConfigFilename);
    end;

end;

procedure TMainForm.ActionSaveConfigExecute(Sender: TObject);
begin
  if ConfigFilename=Trans.Text('neue_config.txt') then
     ActionSaveConfigAsExecute(Sender)
  else SaveConfigTxt(ConfigFilename);
end;

procedure TMainForm.ActionSaveSSHExecute(Sender: TObject);
var sl : TStringList;
begin
  SelectDirectoryDialog1.Title:=Trans.Text('DateiSpeichernSSH');
  if SelectDirectoryDialog1.Execute then
    begin
      sl:=TStringList.Create;
      sl.SaveToFile(SelectDirectoryDialog1.FileName+PathDelim+'ssh');
      MessageDlg(Trans.Text('SSHgespeichert')+#10#13
        +SelectDirectoryDialog1.FileName+PathDelim+'ssh',mtInformation,[mbOk],0);
      sl.Free;
    end;
end;

procedure TMainForm.ActionSaveWifiExecute(Sender: TObject);
begin
  WifiSetupForm.ShowModal;
end;

procedure TMainForm.ActionSetupPageExecute(Sender: TObject);
begin
  SetupForm.ShowModal;
end;

procedure TMainForm.ActionTechPlusCodeExecute(Sender: TObject);
begin
  OpenUrl(URL_TECHPLUSCODE);
end;

procedure TMainForm.ActionHelpExecute(Sender: TObject);
var Url : string;
begin
  Url:='';
  case PageControl1.ActivePage.Tag of
    1 : Url:='https://www.raspberrypi.org/documentation/configuration/config-txt/memory.md';
    2 : Url:='https://www.raspberrypi.org/documentation/configuration/config-txt/codeclicence.md';
    3 : Url:='https://www.raspberrypi.org/documentation/configuration/config-txt/video.md';
    4 : Url:='https://www.raspberrypi.org/documentation/configuration/config-txt/audio.md';
    5 : Url:='https://www.raspberrypi.org/documentation/configuration/config-txt/camera.md';
    6 : Url:='https://www.raspberrypi.org/documentation/configuration/config-txt/boot.md';
    7 : Url:='https://www.raspberrypi.org/documentation/configuration/device-tree.md';
    8 : Url:='https://www.raspberrypi.org/documentation/configuration/config-txt/gpio.md';
    9 : Url:='https://www.raspberrypi.org/documentation/configuration/config-txt/overclocking.md';
    10 : Url:='https://www.raspberrypi.org/documentation/configuration/config-txt/conditional.md';
    11 : Url:='https://www.raspberrypi.org/documentation/configuration/config-txt/misc.md';
  end;
  if Url<>'' then OpenUrl(Url)
  else MessageDlg(Trans.Text('Info'),Trans.Text('Msg-Keine Hilfe'),mtInformation,[mbOK],0);
end;

procedure TMainForm.ActionLanguageDEExecute(Sender: TObject);
begin
  Trans.Language:='DE';
  UpdateLanguage;
end;

procedure TMainForm.ActionLanguageENExecute(Sender: TObject);
begin
  Trans.Language:='EN';
  UpdateLanguage;
end;

procedure TMainForm.ActionNewConfig2Execute(Sender: TObject);
begin
  ActionNewConfigExecute(Sender);
end;

function TMainForm.FileChangedGoOn : boolean;
begin
  result:=true;
  if SynEdit1.Modified=true then
   if MessageDlg(Trans.Text('Datei geändert'),
     Trans.Text('Msg-Datei geändert'),mtConfirmation,mbYesNoCancel,0)<>mrYes then result:=false;
end;

procedure TMainForm.ActionNewConfigExecute(Sender: TObject);
begin
  if FileChangedGoOn=false then exit;

  if MessageDlg(Trans.Text('Neue Config.txt anlegen'),
    Trans.Text('Msg-NeueConfig'),mtConfirmation,mbYesNoCancel,0)=mrYes then NewConfigTxt;
end;

procedure TMainForm.ActionAboutExecute(Sender: TObject);
begin
  AboutForm.ShowModal;
end;

procedure TMainForm.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ActionHelp2Execute(Sender: TObject);
begin
  ActionHelpExecute(Sender);
end;

procedure TMainForm.cpBootcodeDelayValueChange(Sender: TObject);
begin
  cpBootDelay.Enabled:=cpBootcodeDelay.Value='0x200';
  cpBootDelayMs.Enabled:=cpBootDelay.Enabled;
  UpdateLabelBootDelay;
end;

procedure TMainForm.cpBootDelayMsValueChange(Sender: TObject);
begin
  UpdateLabelBootDelay;
end;

procedure TMainForm.UpdateLabelBootDelay;
begin
  LabelBootDelay.Caption:=IntToStr(StrInt(cpBootDelay.Value)*1000
    +StrInt(cpBootDelayMs.Value))+' ms';
end;

procedure TMainForm.cpBootDelayValueChange(Sender: TObject);
begin
  UpdateLabelBootDelay;
end;

procedure TMainForm.AddModes(cp : TConfigPanel; group : string);
begin
  if group='1' then
    begin
      cp.ComboboxAddLine('','');
      cp.ComboboxAddLine('1','VGA (640x480)');
      cp.ComboboxAddLine('2','480p - 60Hz ');
      cp.ComboboxAddLine('3','480p - 60Hz 16:9 aspect ratio');
      cp.ComboboxAddLine('4','720p - 60Hz ');
      cp.ComboboxAddLine('5','1080i - 60Hz ');
      cp.ComboboxAddLine('6','480i - 60Hz ');
      cp.ComboboxAddLine('7','480i - 60Hz 16:9 aspect ratio');
      cp.ComboboxAddLine('8','240p - 60Hz ');
      cp.ComboboxAddLine('9','240p - 60Hz 16:9 aspect ratio');
      cp.ComboboxAddLine('10','480i - 60Hz pixel quadrupling');
      cp.ComboboxAddLine('11','480i - 60Hz pixel quadrupling, 16:9 aspect ratio');
      cp.ComboboxAddLine('12','240p - 60Hz pixel quadrupling');
      cp.ComboboxAddLine('13','240p - 60Hz pixel quadrupling, 16:9 aspect ratio');
      cp.ComboboxAddLine('14','480p - 60Hz pixel doubling');
      cp.ComboboxAddLine('15','480p - 60Hz pixel doubling, 16:9 aspect ratio');
      cp.ComboboxAddLine('16','1080p - 60Hz ');
      cp.ComboboxAddLine('17','576p - 50Hz ');
      cp.ComboboxAddLine('18','576p - 50Hz 16:9 aspect ratio');
      cp.ComboboxAddLine('19','720p - 50Hz ');
      cp.ComboboxAddLine('20','1080i - 50Hz ');
      cp.ComboboxAddLine('21','576i - 50Hz ');
      cp.ComboboxAddLine('22','576i - 50Hz 16:9 aspect ratio');
      cp.ComboboxAddLine('23','288p - 50Hz ');
      cp.ComboboxAddLine('24','288p - 50Hz 16:9 aspect ratio');
      cp.ComboboxAddLine('25','576i - 50Hz pixel quadrupling');
      cp.ComboboxAddLine('26','576i - 50Hz pixel quadrupling, 16:9 aspect ratio');
      cp.ComboboxAddLine('27','288p - 50Hz pixel quadrupling');
      cp.ComboboxAddLine('28','288p - 50Hz pixel quadrupling, 16:9 aspect ratio');
      cp.ComboboxAddLine('29','576p - 50Hz pixel doubling');
      cp.ComboboxAddLine('30','576p - 50Hz pixel doubling, 16:9 aspect ratio');
      cp.ComboboxAddLine('31','1080p - 50Hz ');
      cp.ComboboxAddLine('32','1080p - 24Hz ');
      cp.ComboboxAddLine('33','1080p - 25Hz ');
      cp.ComboboxAddLine('34','1080p - 30Hz ');
      cp.ComboboxAddLine('35','480p - 60Hz pixel quadrupling');
      cp.ComboboxAddLine('36','480p - 60Hz pixel quadrupling, 16:9 aspect ratio');
      cp.ComboboxAddLine('37','576p - 50Hz pixel quadrupling');
      cp.ComboboxAddLine('38','576p - 50Hz pixel quadrupling, 16:9 aspect ratio');
      cp.ComboboxAddLine('39','1080i - 50Hz reduced blanking');
      cp.ComboboxAddLine('40','1080i - 100Hz ');
      cp.ComboboxAddLine('41','720p - 100Hz ');
      cp.ComboboxAddLine('42','576p - 100Hz ');
      cp.ComboboxAddLine('43','576p - 100Hz 16:9 aspect ratio');
      cp.ComboboxAddLine('44','576i - 100Hz ');
      cp.ComboboxAddLine('45','576i - 100Hz 16:9 aspect ratio');
      cp.ComboboxAddLine('46','1080i - 120Hz ');
      cp.ComboboxAddLine('47','720p - 120Hz ');
      cp.ComboboxAddLine('48','480p - 120Hz ');
      cp.ComboboxAddLine('49','480p - 120Hz 16:9 aspect ratio');
      cp.ComboboxAddLine('50','480i - 120Hz ');
      cp.ComboboxAddLine('51','480i - 120Hz 16:9 aspect ratio');
      cp.ComboboxAddLine('52','576p - 200Hz ');
      cp.ComboboxAddLine('53','576p - 200Hz 16:9 aspect ratio');
      cp.ComboboxAddLine('54','576i - 200Hz ');
      cp.ComboboxAddLine('55','576i - 200Hz 16:9 aspect ratio');
      cp.ComboboxAddLine('56','480p - 240Hz ');
      cp.ComboboxAddLine('57','480p - 240Hz 16:9 aspect ratio');
      cp.ComboboxAddLine('58','480i - 240Hz ');
      cp.ComboboxAddLine('59','480i - 240Hz 16:9 aspect ratio');
    end
  else if group='2' then
    begin
      cp.Enabled:=true;
      cp.ComboboxAddLine('','');
      cp.ComboboxAddLine('1','640x350 - 85Hz ');
      cp.ComboboxAddLine('2','640x400 - 85Hz ');
      cp.ComboboxAddLine('3','720x400 - 85Hz ');
      cp.ComboboxAddLine('4','640x480 - 60Hz ');
      cp.ComboboxAddLine('5','640x480 - 72Hz ');
      cp.ComboboxAddLine('6','640x480 - 75Hz ');
      cp.ComboboxAddLine('7','640x480 - 85Hz ');
      cp.ComboboxAddLine('8','800x600 - 56Hz ');
      cp.ComboboxAddLine('9','800x600 - 60Hz ');
      cp.ComboboxAddLine('10','800x600 - 72Hz ');
      cp.ComboboxAddLine('11','800x600 - 75Hz ');
      cp.ComboboxAddLine('12','800x600 - 85Hz ');
      cp.ComboboxAddLine('13','800x600 - 120Hz ');
      cp.ComboboxAddLine('14','848x480 - 60Hz ');
      cp.ComboboxAddLine('15','1024x768 - 43Hz incompatible with the Raspberry Pi');
      cp.ComboboxAddLine('16','1024x768 - 60Hz ');
      cp.ComboboxAddLine('17','1024x768 - 70Hz ');
      cp.ComboboxAddLine('18','1024x768 - 75Hz ');
      cp.ComboboxAddLine('19','1024x768 - 85Hz ');
      cp.ComboboxAddLine('20','1024x768 - 120Hz ');
      cp.ComboboxAddLine('21','1152x864 - 75Hz ');
      cp.ComboboxAddLine('22','1280x768 -  reduced blanking');
      cp.ComboboxAddLine('23','1280x768 - 60Hz ');
      cp.ComboboxAddLine('24','1280x768 - 75Hz ');
      cp.ComboboxAddLine('25','1280x768 - 85Hz ');
      cp.ComboboxAddLine('26','1280x768 - 120Hz reduced blanking');
      cp.ComboboxAddLine('27','1280x800 -  reduced blanking');
      cp.ComboboxAddLine('28','1280x800 - 60Hz ');
      cp.ComboboxAddLine('29','1280x800 - 75Hz ');
      cp.ComboboxAddLine('30','1280x800 - 85Hz ');
      cp.ComboboxAddLine('31','1280x800 - 120Hz reduced blanking');
      cp.ComboboxAddLine('32','1280x960 - 60Hz ');
      cp.ComboboxAddLine('33','1280x960 - 85Hz ');
      cp.ComboboxAddLine('34','1280x960 - 120Hz reduced blanking');
      cp.ComboboxAddLine('35','1280x1024 - 60Hz ');
      cp.ComboboxAddLine('36','1280x1024 - 75Hz ');
      cp.ComboboxAddLine('37','1280x1024 - 85Hz ');
      cp.ComboboxAddLine('38','1280x1024 - 120Hz reduced blanking');
      cp.ComboboxAddLine('39','1360x768 - 60Hz ');
      cp.ComboboxAddLine('40','1360x768 - 120Hz reduced blanking');
      cp.ComboboxAddLine('41','1400x1050 -  reduced blanking');
      cp.ComboboxAddLine('42','1400x1050 - 60Hz ');
      cp.ComboboxAddLine('43','1400x1050 - 75Hz ');
      cp.ComboboxAddLine('44','1400x1050 - 85Hz ');
      cp.ComboboxAddLine('45','1400x1050 - 120Hz reduced blanking');
      cp.ComboboxAddLine('46','1440x900 -  reduced blanking');
      cp.ComboboxAddLine('47','1440x900 - 60Hz ');
      cp.ComboboxAddLine('48','1440x900 - 75Hz ');
      cp.ComboboxAddLine('49','1440x900 - 85Hz ');
      cp.ComboboxAddLine('50','1440x900 - 120Hz reduced blanking');
      cp.ComboboxAddLine('51','1600x1200 - 60Hz ');
      cp.ComboboxAddLine('52','1600x1200 - 65Hz ');
      cp.ComboboxAddLine('53','1600x1200 - 70Hz ');
      cp.ComboboxAddLine('54','1600x1200 - 75Hz ');
      cp.ComboboxAddLine('55','1600x1200 - 85Hz ');
      cp.ComboboxAddLine('56','1600x1200 - 120Hz reduced blanking');
      cp.ComboboxAddLine('57','1680x1050 -  reduced blanking');
      cp.ComboboxAddLine('58','1680x1050 - 60Hz ');
      cp.ComboboxAddLine('59','1680x1050 - 75Hz ');
      cp.ComboboxAddLine('60','1680x1050 - 85Hz ');
      cp.ComboboxAddLine('61','1680x1050 - 120Hz reduced blanking');
      cp.ComboboxAddLine('62','1792x1344 - 60Hz ');
      cp.ComboboxAddLine('63','1792x1344 - 75Hz ');
      cp.ComboboxAddLine('64','1792x1344 - 120Hz reduced blanking');
      cp.ComboboxAddLine('65','1856x1392 - 60Hz ');
      cp.ComboboxAddLine('66','1856x1392 - 75Hz ');
      cp.ComboboxAddLine('67','1856x1392 - 120Hz reduced blanking');
      cp.ComboboxAddLine('68','1920x1200 -  reduced blanking');
      cp.ComboboxAddLine('69','1920x1200 - 60Hz ');
      cp.ComboboxAddLine('70','1920x1200 - 75Hz ');
      cp.ComboboxAddLine('71','1920x1200 - 85Hz ');
      cp.ComboboxAddLine('72','1920x1200 - 120Hz reduced blanking');
      cp.ComboboxAddLine('73','1920x1440 - 60Hz ');
      cp.ComboboxAddLine('74','1920x1440 - 75Hz ');
      cp.ComboboxAddLine('75','1920x1440 - 120Hz reduced blanking');
      cp.ComboboxAddLine('76','2560x1600 -  reduced blanking');
      cp.ComboboxAddLine('77','2560x1600 - 60Hz ');
      cp.ComboboxAddLine('78','2560x1600 - 75Hz ');
      cp.ComboboxAddLine('79','2560x1600 - 85Hz ');
      cp.ComboboxAddLine('80','2560x1600 - 120Hz reduced blanking');
      cp.ComboboxAddLine('81','1366x768 - 60Hz ');
      cp.ComboboxAddLine('82','1920x1080 - 60Hz 1080p');
      cp.ComboboxAddLine('83','1600x900 -  reduced blanking');
      cp.ComboboxAddLine('84','2048x1152 -  reduced blanking');
      cp.ComboboxAddLine('85','1280x720 - 60Hz 720p');
      cp.ComboboxAddLine('86','1366x768 -  reduced blanking');
      cp.ComboboxAddLine('87','timings');
    end

end;

procedure TMainForm.cpDpiGroupValueChange(Sender: TObject);
begin
  cpDpiMode.ComboboxClear;
  if cpDpiGroup.Value='1' then
    begin
      cpDpiMode.Enabled:=true;
      AddModes(cpDpiMode,cpDpiGroup.Value);
    end
  else if cpDpiGroup.Value='2' then
    begin
      cpDpiMode.Enabled:=true;
      AddModes(cpDpiMode,cpDpiGroup.Value);
    end
  else
    begin
      //
    end;

end;

procedure TMainForm.cpHdmiGroupValueChange(Sender: TObject);
begin
  cpHdmiMode.ComboboxClear;
  if cpHdmiGroup.Value='1' then
    begin
      cpHdmiMode.Enabled:=true;
      AddModes(cpHdmiMode,cpHdmiGroup.Value);
    end
  else if cpHdmiGroup.Value='2' then
    begin
      cpHdmiMode.Enabled:=true;
      AddModes(cpHdmiMode,cpHdmiGroup.Value);
    end
  else
    begin
      //cpHdmiMode.Enabled:=false;
    end;
end;

procedure TMainForm.FormActivate(Sender: TObject);
var Ini : TInifile;
begin
  if FirstStart=true then
    begin
      FirstStart:=False;

      Trans.Filename:=ExtractFilePath(Paramstr(0))+FILE_LANGUAGE;
      SetupForm.Filename:=ExtractFilePath(Paramstr(0))+FILE_CONFIG;

      Trans.ReadLanguages;
      //Trans.SetDefaultLanguage;
      SetupForm.LoadConfig;



      UpdateLanguage;

      try
        Ini:=TInifile.Create(SetupForm.Filename);
        RestoreWindowPosition(MainForm,Ini);
        RestoreWindowPosition(SetupForm,Ini);

      finally
        Ini.Free;
      end;


      {
      //Doesn't working:
      SynAnySyn1.Keywords.Clear;
      for i:=0 to ComponentCount-1 do
        begin
          if Components[i] is TConfigPanel then
            begin
              cp:=TConfigPanel(Components[i]);
              SynAnySyn1.Keywords.Add(cp.Prop);
            end;
        end;


      Memo1.Lines.Assign(SynAnySyn1.Keywords);  }


      NewConfigTxt;

      if ParamCount>0 then
        if FileExists(ParamStr(1)) then LoadConfigTxt(ParamStr(1));

    end;
end;

procedure TMainForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var Ini : TInifile;
begin
  try
    Ini:=TInifile.Create(SetupForm.Filename);
    WriteWindowPosition(MainForm,Ini);
    WriteWindowPosition(SetupForm,Ini);

  finally
    Ini.Free;
  end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if FileChangedGoOn=false then Canclose:=false;
end;

procedure TMainForm.UpdatePageControl(s : string);
var
  i : integer;
  found : boolean;
begin
  found:=false;
  for i:=0 to PageControl1.PageCount-1 do
    if PageControl1.Pages[i].Caption=s then
      begin
        PageControl1.ActivePage:=PageControl1.Pages[i];
        found:=true;
        break;
      end;
  if found=false then
    PageControl1.ActivePage:=TabSheetEmpty;

  if PageControl1.ActivePage=TabSheetEditor then
   UpdateEditorFromConfigPanels
  else UpdateConfigPanelsFromEditor;

end;

procedure TMainForm.UpdateFilename;
begin
  Caption:=Application.Title+' - '+ConfigFilename;
end;

procedure TMainForm.UpdateLanguage;
var
  s : string;
  i,j : integer;
  TabSheet : TTabSheet;
  TreeNode,SubNode,SubNode2 : TTreeNode;
  cp : TConfigPanel;
begin
  if Trans.Language='DE' then Speedbutton10.Down:=true
  else Speedbutton11.Down:=true;

  Trans.ReadTranslations;
  Synedit1.ChangeStamp;

  //Menue
  MenuItem16.Caption:=Trans.Text('Datei');
  ActionNewConfig.Caption:=Trans.Text('NeueDatei');
  ActionOpenConfig.Caption:=Trans.Text('DateiOeffnen');
  ActionOpenBootConfig.Caption:=Trans.Text('BootConfigOeffnen');
  ActionSaveConfig.Caption:=Trans.Text('DateiSpeichern');
  ActionSaveConfigAs.Caption:=Trans.Text('DateiSpeichernUnter');
  ActionSaveSSH.Caption:=Trans.Text('DateiSpeichernSSH');
  ActionSaveWIFI.Caption:=Trans.Text('DateiSpeichernWIFI');
  ActionClose.Caption:=Trans.Text('Beenden');


  ActionNewConfig2.Caption:=Trans.Text('Neu');
  ActionOpenConfig2.Caption:=Trans.Text('Öffnen');
  ActionSaveConfig2.Caption:=Trans.Text('Speichern');
  ActionHelp2.Caption:=Trans.Text('Hilfe');
  ActionRaspberryWeb2.Caption:=Trans.Text('Raspberrypi.org');

  ActionSetupPage.Caption:=Trans.Text('Einstellungen');

  MenuItem17.Caption:=Trans.Text('Hilfe');
  MenuItem1.Caption:=Trans.Text('Tools');
  ActionHelp.Caption:=Trans.Text('Hilfe');
  ActionAbout.Caption:=Trans.Text('Info');
  ActionRaspberryWeb.Caption:=Trans.Text('Raspberrypi.org');
  ActionTechPlusCode.Caption:=Trans.Text('Techpluscode.de');


  OpenDialog1.Title:=Trans.Text('DateiOeffnen');
  OpenDialog1.Filter:=Trans.Text('OpenDialogFilter');
  SaveDialog1.Title:=Trans.Text('DateiSpeichernUnter');
  SaveDialog1.Filter:=Trans.Text('OpenDialogFilter');
  SelectDirectoryDialog1.Title:=Trans.Text('DateiSpeichernSSH');


  //Treeview
  TreeviewChange:=false;
  TreeView1.Items.Clear;

  TreeView1.Items.Add(nil,Trans.Text('Editor'));
  TreeNode:=TreeView1.Items.Add(nil,Trans.Text('Einstellungen'));

  //TreeView1.Items.AddChild(TreeNode,Trans.Text('Raspberry Pi'));
  TreeView1.Items.AddChild(TreeNode,Trans.Text('Boot'));

  SubNode:=TreeView1.Items.AddChild(TreeNode,Trans.Text('Hardware'));
  TreeView1.Items.AddChild(SubNode,Trans.Text('Kamera'));
  TreeView1.Items.AddChild(TreeNode,Trans.Text('Speicher'));
  TreeView1.Items.AddChild(TreeNode,Trans.Text('USB'));
  TreeView1.Items.AddChild(TreeNode,Trans.Text('Audio'));
  SubNode:=TreeView1.Items.AddChild(TreeNode,Trans.Text('Video'));
  TreeView1.Items.AddChild(SubNode,Trans.Text('SDTV'));
  SubNode2:=TreeView1.Items.AddChild(SubNode,Trans.Text('HDMI'));
  TreeView1.Items.AddChild(SubNode2,Trans.Text('HDMI Display'));
  TreeView1.Items.AddChild(SubNode2,Trans.Text('HDMI Timings'));
  TreeView1.Items.AddChild(SubNode2,Trans.Text('HDMI EDID'));
  TreeView1.Items.AddChild(SubNode2,Trans.Text('HDMI Custom'));
  SubNode2:=TreeView1.Items.AddChild(SubNode,Trans.Text('LCD'));
  TreeView1.Items.AddChild(SubNode2,Trans.Text('LCD2'));
  TreeView1.Items.AddChild(TreeNode,Trans.Text('Codecs'));
  SubNode:=TreeView1.Items.AddChild(TreeNode,Trans.Text('Overclocking'));
  TreeView1.Items.AddChild(SubNode,Trans.Text('Overvoltage'));
  TreeView1.Items.AddChild(TreeNode,Trans.Text('Warnungen'));
  TreeView1.Items.AddChild(TreeNode,Trans.Text('Verschiedene'));
  TreeviewChange:=true;

  TreeView1.Selected:=TreeView1.Items[2];
  TreeView1Change(nil,TreeView1.Selected);

  //Pages
  Label30.Caption:=Trans.Text('Msg-Keine Einstellungen');

  //Lazarus
  TranslateUnitResourceStrings('LCLStrConsts',
    ExtractFilePath(Paramstr(0))+'lclstrconsts.'+lowercase(Trans.Language)+'.po');

  //ConfigSetup
  with ConfigSetup do
    begin
      TextNoLineForDefaultValue:=Trans.Text('Msg-Kein Eintrag in config.txt');
      TextDefault:=Trans.Text('Standard');
    end;


  //TConfigPanel's
  for i:=0 to ComponentCount-1 do
    if Components[i] is TConfigPanel then
      begin
        cp:=TConfigPanel(Components[i]);
        if Trans.Text(cp.Prop)<>'' then cp.Title:=Trans.Text(cp.Prop);
         if Trans.Text(cp.Prop+' comment')<>'' then
          cp.Comment:=Trans.Text(cp.Prop+' comment');
      end;

  //Special Panel's
  cpDtparamI2CARM.Title:=Trans.Text('dtparam-i2c');
  cpDtparamI2CARM.Comment:=Trans.Text('dtparam-i2c comment');
  cpDtparamI2S.Title:=Trans.Text('dtparam-i2s');
  cpDtparamI2S.Comment:=Trans.Text('dtparam-i2s comment');
  cpDtparamSPI.Title:=Trans.Text('dtparam-spi');
  cpDtparamSPI.Comment:=Trans.Text('dtparam-spi comment');
  cpDtparamAudio.Title:=Trans.Text('dtparam-audio');
  cpDtparamAudio.Comment:=Trans.Text('dtparam-audio comment');


  //Desktop
  Label14.Caption:=Trans.Text('Txt-Verzögerung');
  Label12.Caption:=Trans.Text('Msg-start_x mit Kamera');
  Label10.Caption:=Trans.Text('Msg_Einstellung ab B+');
  Label34.Caption:=Trans.Text('Msg_Einstellung ab 3B');
  Label2.Caption:=Trans.Text('Datei');
  Label4.Caption:=Trans.Text('Einstellungen');
  Label3.Caption:=Trans.Text('Hilfe und Info');
  Label5.Caption:=Trans.Text('Menue');
  Label6.Caption:=Trans.Text('Tools');
  Label8.Caption:=Trans.Text('Msg-Pi Display');


  //Buttons
  SpeedButton16.Caption:=Trans.Text('SSH');
  SpeedButton17.Caption:=Trans.Text('Wifi');

end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  i : integer;
  cp : TConfigPanel;
begin
  FirstStart:=true;
  PageControl1.ShowTabs:=false;


  ActionOpenBootConfig.Enabled:=FileExists(BOOT_CONFIG_TXT);


  Treeview1.Selected:=Treeview1.Items[2];
  UpdatePageControl(Treeview1.Selected.Text);

end;

procedure TMainForm.SpeedButton14Click(Sender: TObject);
begin
  ActionSetupPageExecute(Sender);
end;

procedure TMainForm.SpeedButton15Click(Sender: TObject);
var P : TPoint;
begin
  //Funktioniert nicht mit SpeedButton15
  //P:=ClientToScreen(Point(SpeedButton15.Left+5,SpeedButton15.Top+SpeedButton15.Height));
  P:=ClientToScreen(Point(Panel39.Left-5,SpeedButton15.Top+SpeedButton15.Height));
  PopupMenuHelp.Popup(P.X, P.Y);
end;

procedure TMainForm.SpeedButton8Click(Sender: TObject);
var P : TPoint;
begin
  P:=ClientToScreen(Point(Panel34.Left,Panel34.Top+Panel34.Height));
  PopupMenuTotal.Popup(P.X, P.Y);
end;

procedure TMainForm.SpeedButton9Click(Sender: TObject);
var P : TPoint;
begin
  P:=ClientToScreen(Point(SpeedButton9.Left,SpeedButton9.Top+SpeedButton9.Height));
  PopupMenuFile.Popup(P.X, P.Y);
end;

procedure TMainForm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  if TreeviewChange=false then exit;
  if Node=nil then exit;

  UpdatePageControl(Trans.Code(Node.Text));
end;



end.

