unit confed;

{
Package with visual components for the
Raspberry Pi Config Editor

https://techpluscode.de/rpiconfigedit/
https://techpluscode.de/rpiconfigedit-en/


(C) Thomas Angielsky

Has to be installed and Lazarus recompiled.
Not useful for any other application!
}


{$mode objfpc}{$H+}

interface

uses
  LCLType, LMessages, LCLProc, Messages, SysUtils, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Spin, LResources, LCLIntf;


type

  TConfigPanelStyle = (cpsCheckbox,cpsEdit,cpsSpinEdit,cpsCombobox);

  { TConfigSetup }
  TConfigSetup = class
    NoLineForDefaultValue : boolean;
    TextNoLineForDefaultValue : string;
    TextDefault : string;

    CreateNewConfigOnSave : boolean;
    AddCommentsOnSave : boolean;
  end;


  { TConfigPanel }
  TConfigPanel = class(TPanel)
   private
     { Private-Deklarationen }
     Checkbox : TCheckbox;
     Edit : TEdit;
     SpinEdit : TSpinEdit;
     Combobox : TCombobox;

     LabelTitle : TLabel;
     LabelComment : TLabel;
     LabelConfigLine : TLabel;

     FLeftEdit : integer;
     FWidthEdit : integer;
     FStyle : TConfigPanelStyle;

     FProp : string;
     FValue : string;
     FDefaultValue : string;
     FValues : TStringList;
     FOnValueChange : TNotifyEvent;

     ValueSet : boolean;

     procedure UpdateLabelConfigLine;
     procedure SetProp(value : string);
     procedure SetDefaultValue(value : string);
     procedure SetValues(value : TStringList);
     function GetItems : TStrings;
     procedure SetItems(value : TStrings);

     function GetTitle : string;
     procedure SetTitle(value : string);
     function GetComment : string;
     procedure SetComment(value : string);
     procedure SetStyle(value : TConfigPanelStyle);
     procedure SetLeftEdit(value : integer);
     procedure SetWidthEdit(value : integer);

     procedure CheckBoxChange(Sender : TObject);
     procedure EditChange(Sender : TObject);
     procedure SpinEditChange(Sender : TObject);
     procedure ComboboxChange(Sender : TObject);
     procedure SetValue(value: string);


   protected
     { Protected-Deklarationen }
   public
     { Public-Deklarationen }
     constructor Create(AOwner : TComponent); override;
     destructor Destroy; override;
     procedure Resize; override;

     procedure ComboboxAddLine(code: string; value: string);
     procedure ComboboxClear;

     function ConfigLine : string;
     function ReadConfig(s: string) : boolean;
     procedure SetToDefaultValue;
     procedure ReadValueFromString(s : string);

   published
     { Published-Deklarationen }
     property Title : string read GetTitle write SetTitle;
     property Comment : string read GetComment write SetComment;
     property LeftEdit : integer read FLeftEdit write SetLeftEdit;
     property WidthEdit : integer read FWidthEdit write SetWidthEdit;
     property Style : TConfigPanelStyle read FStyle write SetStyle;
     property Prop : string read FProp write SetProp;
     property Value : string read FValue write SetValue;
     property DefaultValue : string read FDefaultValue write SetDefaultValue;
     property Values : TStringList read FValues write SetValues;
     property Items : TStrings read GetItems write SetItems;
     property OnValueChange: TNotifyEvent read FOnValueChange write FOnValueChange;
   end;



procedure Register;


var
  ConfigSetup : TConfigSetup;


implementation


procedure Register;
begin
  RegisterComponents('Mylib',[TConfigPanel]);
end;


function StrInt(ss : string) : integer;
var
  ww,hh : integer;
begin
  val(ss,ww,hh);
  result:=ww;
end;




{ TConfigPanel }


function TConfigPanel.ConfigLine: string;
begin
  result:=FProp+'='+FValue;

  if ((FDefaultValue=FValue) and (ConfigSetup.NoLineForDefaultValue=true))
    then result:='';
  if (self.Enabled=false) then result:='';
end;

function TConfigPanel.ReadConfig(s: string) : boolean;
begin
  SetValue(s);
  result:=ValueSet;
end;

procedure TConfigPanel.UpdateLabelConfigLine;
begin
  LabelConfigLine.Caption:=FProp+'='+FValue;
  if FDefaultValue=FValue then
    begin
      if ConfigSetup.NoLineForDefaultValue=true then
        LabelConfigLine.Caption:=ConfigSetup.TextNoLineForDefaultValue
      else LabelConfigLine.Caption:=LabelConfigLine.Caption+' ('+ConfigSetup.TextDefault+')';
    end;

end;

procedure TConfigPanel.SetProp(value: string);
begin
  if value<>FProp then
    begin
      FProp:=value;
      UpdateLabelConfigLine;
    end;
end;

procedure TConfigPanel.SetDefaultValue(value: string);
begin
  if value<>FDefaultValue then
    begin
      FDefaultValue:=value;
      UpdateLabelConfigLine;
    end;
end;



procedure TConfigPanel.SetValues(value: TStringList);
begin
  if value<>FValues then FValues.Assign(value);
end;

function TConfigPanel.GetItems: TStrings;
begin
  result:=Combobox.Items;
end;

procedure TConfigPanel.SetItems(value: TStrings);
begin
  Combobox.Items:=value;
end;

function TConfigPanel.GetTitle: string;
begin
  result:=LabelTitle.Caption;
end;

procedure TConfigPanel.SetTitle(value: string);
begin
  LabelTitle.Caption:=value;
  Checkbox.Caption:=value;
end;

function TConfigPanel.GetComment: string;
begin
  result:=LabelComment.Caption;
end;

procedure TConfigPanel.SetComment(value: string);
begin
  LabelComment.Caption:=value;
end;

procedure TConfigPanel.SetStyle(value: TConfigPanelStyle);
begin
  if value=FStyle then exit;

  FStyle:=value;

  Checkbox.Visible:=false;
  Edit.Visible:=false;
  SpinEdit.Visible:=false;
  Combobox.Visible:=false;
  LabelTitle.Visible:=true;


  if FStyle=cpsCheckbox then
    begin
      LabelTitle.Visible:=false;
      Checkbox.Visible:=true;
      Checkbox.Left:=0;
    end
  else if FStyle=cpsEdit then
    begin
      Edit.Visible:=true;
      Edit.Left:=FLeftEdit;
    end
  else if FStyle=cpsSpinEdit then
    begin
      SpinEdit.Visible:=true;
      SpinEdit.Left:=FLeftEdit;
    end
  else if FStyle=cpsCombobox then
    begin
      Combobox.Visible:=true;
      Combobox.Left:=FLeftEdit;
    end;
end;

procedure TConfigPanel.SetLeftEdit(value: integer);
begin
  FLeftEdit:=value;
  LabelConfigLine.Left:=FLeftEdit;
  LabelComment.Left:=FLeftEdit;
  LabelComment.Width:=ClientWidth-LabelComment.Left;
  LabelComment.Height:=ClientHeight-LabelComment.Top;

  Edit.Left:=FLeftEdit;
  SpinEdit.Left:=FLeftEdit;
  Combobox.Left:=FLeftEdit;
end;

procedure TConfigPanel.SetWidthEdit(value: integer);
begin
  FWidthEdit:=value;

  Edit.Width:=FWidthEdit;
  SpinEdit.Width:=FWidthEdit;
  Combobox.Width:=FWidthEdit;
end;

procedure TConfigPanel.CheckBoxChange(Sender: TObject);
begin
  if Checkbox.Checked=false then SetValue(FValues[0])
  else SetValue(FValues[1]);
end;

procedure TConfigPanel.EditChange(Sender: TObject);
begin
  SetValue(Edit.Text);
end;

procedure TConfigPanel.SpinEditChange(Sender: TObject);
begin
  SetValue(IntToStr(SpinEdit.Value));
end;

procedure TConfigPanel.ComboboxChange(Sender: TObject);
begin
  SetValue(FValues[Combobox.ItemIndex]);
end;

constructor TConfigPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);


  ValueSet:=false;

  Caption:='';
  BorderStyle:=bsNone;
  BevelOuter:=bvNone;

  FLeftEdit:=110;
  FOnValueChange:=nil;
  FValues:=TStringList.Create;

  Checkbox:=TCheckbox.Create(nil);
  Checkbox.Caption:='';
  Checkbox.Visible:=false;
  Checkbox.Top:=0;
  Checkbox.OnChange:=@CheckBoxChange;
  InsertControl(Checkbox);

  Combobox:=TCombobox.Create(nil);
  Combobox.Visible:=false;

  {$IFDEF UNIX}
  Combobox.Style:=csDropDownList;
  {$ENDIF}

  {$IFDEF WINDOWS}
   Combobox.Style:=csOwnerDrawFixed;
  {$ENDIF}

  Combobox.Top:=0;
  Combobox.OnChange:=@ComboboxChange;
  InsertControl(Combobox);

  Edit:=TEdit.Create(nil);
  Edit.Visible:=false;
  Edit.Top:=0;
  Edit.OnChange:=@EditChange;
  InsertControl(Edit);

  SpinEdit:=TSpinEdit.Create(nil);
  SpinEdit.Visible:=false;
  SpinEdit.Top:=0;
  SpinEdit.OnChange:=@SpinEditChange;
  InsertControl(SpinEdit);

  LabelTitle:=TLabel.Create(nil);
  LabelTitle.Visible:=false;
  LabelTitle.Left:=0;
  LabelTitle.Top:=0;
  LabelTitle.Caption:='';
  InsertControl(LabelTitle);

  LabelConfigLine:=TLabel.Create(nil);
  LabelConfigLine.Top:=Edit.Height+5;
  LabelConfigLine.Left:=FLeftEdit;
  LabelConfigLine.Font.Color:=clGrayText;
  LabelConfigLine.Font.Style:=[fsItalic];
  InsertControl(LabelConfigLine);

  LabelComment:=TLabel.Create(nil);
  LabelComment.Autosize:=false;
  LabelComment.WordWrap:=true;
  LabelComment.Top:=LabelConfigLine.Top+LabelConfigLine.Height+3;
  LabelComment.Anchors:=[akTop,akLeft,AkRight,akBottom];
  LabelComment.Caption:='';
  InsertControl(LabelComment);

  FStyle:=cpsEdit;
  SetStyle(cpsCheckbox);
  SetLeftEdit(FLeftEdit);
  SetWidthEdit(100);

  FProp:='';
  FValue:='';
  FDefaultValue:='';
end;

destructor TConfigPanel.Destroy;
begin
  FValues.Free;
  Checkbox.Free;
  Edit.Free;
  SpinEdit.Free;
  Combobox.Free;
  LabelTitle.Free;
  LabelComment.Free;
  LabelConfigLine.Free;
  inherited Destroy;
end;

procedure TConfigPanel.Resize;
begin
  inherited Resize;

  if FWidthEdit=-1 then
    begin
      Edit.Width:=Width-Edit.Left;
      SpinEdit.Width:=Width-SpinEdit.Left;
      Combobox.Width:=Width-Combobox.Left;
    end;

end;

procedure TConfigPanel.ComboboxAddLine(code: string; value: string);
begin
  Combobox.Items.Add(value);
  FValues.Add(code);
end;

procedure TConfigPanel.ComboboxClear;
begin
  Combobox.Items.Clear;
  FValues.Clear;
end;


procedure TConfigPanel.SetValue(value: string);
var i : integer;
begin
  ValueSet:=false;

  if FStyle=cpsCombobox then
    begin
      for i:=0 to FValues.Count-1 do
        if FValues[i]=value then
          begin
            Combobox.ItemIndex:=i;
            FValue:=value;
            ValueSet:=true;
            break;
          end;
    end
  else if FStyle=cpsEdit then
    begin
      FValue:=value;
      Edit.Text:=FValue;
      ValueSet:=true;
    end
  else if FStyle=cpsSpinEdit then
    begin
      if FValues.Count>=2 then
        begin
          SpinEdit.MinValue:=StrInt(Values[0]);
          SpinEdit.MaxValue:=StrInt(Values[1]);
        end;
      FValue:=value;
      SpinEdit.Value:=StrInt(FValue);
      ValueSet:=true;
    end
  else if FStyle=cpsCheckbox then
    begin
      if FValues.Count>=2 then
        if Uppercase(FValues[1])=Uppercase(value) then
          begin
            Checkbox.Checked:=true;
            FValue:=value;
            ValueSet:=true;
          end
        else
        if Uppercase(FValues[0])=Uppercase(value) then
          begin
            Checkbox.Checked:=false;
            FValue:=value;
            ValueSet:=true;
          end;
    end;

  UpdateLabelConfigLine;

  if (value=FValue) and Assigned(FOnValueChange) then FOnValueChange(Self);
end;


procedure TConfigPanel.SetToDefaultValue;
begin
  SetValue(FDefaultValue);

end;

procedure TConfigPanel.ReadValueFromString(s : string);
var
  p : integer;
  v : string;
begin
    v:='';
    p:=Pos(Uppercase(FProp),Uppercase(s));
    if p>0 then v:=copy(s,p+length(FProp),length(s)-p-length(FProp)+1);

    //= entfernen
    p:=Pos('=',v);
    if p>0 then v:=trim(copy(v,p+1,length(v)-p));

    //Kommentar vorhanden?
    p:=Pos('#',v);
    if p>0 then v:=copy(v,1,p-1);

    SetValue(trim(v));
end;




initialization
{$I confed.lrs}

ConfigSetup:=TConfigSetup.Create;

finalization
  ConfigSetup.Free;

end.

