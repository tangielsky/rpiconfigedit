unit language;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, Inifiles;

type
  { TTranslate }

  TTranslate = class
    private
      FLanguage : string;
      FFilename : string;
      FLanguages : TStringList;
      slCode,slTranslation : TStringList;
      procedure SetLanguage(value : string);
    public
      constructor Create;
      destructor Destroy;
      function Text(s : string) : string;
      function Code(s: string): string;
      function ExistsLanguageFile: boolean;
      procedure ReadLanguages;
      procedure ReadTranslations;
      procedure SetDefaultLanguage;
      procedure SaveLanguage;
    published
      property Language : string read FLanguage write SetLanguage;
      property Filename : string read FFilename write FFilename;
      property Languages : TStringList read FLanguages;
  end;


var
  Trans : TTranslate;

implementation

{ TTranslate }

procedure TTranslate.SetLanguage(value: string);
var
  i : integer;
begin
  for i:=0 to FLanguages.Count-1 do
    if value=FLanguages[i] then
      begin
        FLanguage:=value;
        break;
      end;
end;

constructor TTranslate.Create;
begin
  inherited Create;
  FLanguage:='DE';
  FFilename:='';

  FLanguages:=TStringList.Create;
  slCode:=TStringList.Create;
  slTranslation:=TStringList.Create;
end;

destructor TTranslate.Destroy;
begin
  slCode.Free;
  slTranslation.Free;
  FLanguages.Free;

  inherited Destroy;
end;

function TTranslate.Text(s: string): string;
var i : integer;
begin
  result:='';
  for i:=0 to slCode.Count-1 do
    if s+'-'+FLanguage=slCode[i] then
      begin
        result:=slTranslation[i];
        break;
      end;
end;

function TTranslate.Code(s: string): string;
var i : integer;
begin
  result:='???';
  for i:=0 to slTranslation.Count-1 do
    if s=slTranslation[i] then
      begin
        result:=copy(slCode[i],1,length(slCode[i])-3);
        break;
      end;
end;

procedure TTranslate.ReadLanguages;
var
  Ini : TInifile;
  i : integer;
  s : string;
begin
  if ExistsLanguageFile=false then exit;

  try
    Ini:=TInifile.Create(FFilename);

    FLanguages.Clear;
    for i:=1 to Ini.ReadInteger('Languages','Count',0) do
      FLanguages.Add(Ini.ReadString('Languages','Language'+IntToStr(i),''));
  finally
    Ini.Free;
  end;

end;


procedure TTranslate.ReadTranslations;
var
  Ini : TInifile;
  i : integer;
  s : string;
begin
  if ExistsLanguageFile=false then exit;

  slCode.Clear;
  slTranslation.Clear;

  try
    Ini:=TInifile.Create(FFilename);

    Ini.ReadSection('Translations',slCode);

    for i:=0 to slCode.Count-1 do
      begin
        s:=Ini.ReadString('Translations',slCode[i],'');
        slTranslation.Add(s);
      end;
  finally
    Ini.Free;
  end;

end;

procedure TTranslate.SetDefaultLanguage;
var
  Ini : TInifile;
  i : integer;
  s : string;
begin
  if ExistsLanguageFile=false then exit;

  try
    Ini:=TInifile.Create(FFilename);
    FLanguage:=Ini.ReadString('Languages','Default','DE');
  finally
    Ini.Free;
  end;

end;

procedure TTranslate.SaveLanguage;
var
  Ini : TInifile;
  i : integer;
  s : string;
begin
  if ExistsLanguageFile=false then exit;

  try
    Ini:=TInifile.Create(FFilename);
    Ini.WriteString('Languages','Default',FLanguage);
  finally
    Ini.Free;
  end;
end;

function TTranslate.ExistsLanguageFile : boolean;
begin
  if FileExists(FFilename)=false then
    begin
      MessageDlg(Text('Achtung'),Text('Sprachdatei nicht gefunden'),mtWarning,[mbOK],0);
      result:=false;
    end
  else result:=true;
end;



initialization
  Trans:=TTranslate.Create;

finalization
  Trans.Free;

end.

