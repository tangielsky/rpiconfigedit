unit functions;

{$mode objfpc}{$H+}

interface

uses
  LCLType, LCLProc, LMessages, LResources, Classes,
  SysUtils, Forms, Controls, Inifiles, TypInfo ;

function StrInt(ss : string) : longint;

procedure WriteWindowPosition(Form : TForm; Ini : TInifile);
procedure RestoreWindowPosition(Form: TForm; Ini: TInifile);

implementation

function StrInt(ss : string) : longint;
var
  ww : longint;
  hh : integer;
begin
  val(ss,ww,hh);
  StrInt:=ww;
end;


procedure WriteWindowPosition(Form: TForm; Ini: TInifile);
begin
  Ini.WriteInteger('Windows',Form.Name+'_Left',Form.Left);
  Ini.WriteInteger('Windows',Form.Name+'_Top',Form.Top);
  Ini.WriteInteger('Windows',Form.Name+'_Width',Form.Width);
  Ini.WriteInteger('Windows',Form.Name+'_Height',Form.Height);
  Ini.WriteString('Windows',Form.Name+'_WindowState',
    GetEnumName(TypeInfo(TWindowState),
    Ord(Form.WindowState)));
end;

procedure RestoreWindowPosition(Form: TForm; Ini: TInifile);
var
  l,t,w,h : integer;
  ws : string;
begin
  l:=Ini.ReadInteger('Windows',Form.Name+'_Left',0);
  t:=Ini.ReadInteger('Windows',Form.Name+'_Top',0);
  w:=Ini.ReadInteger('Windows',Form.Name+'_Width',1164);
  h:=Ini.ReadInteger('Windows',Form.Name+'_Height',800);
  ws:=Ini.ReadString('Windows',Form.Name+'_WindowState','wsNormal');

  if Form.BorderStyle=bsSizeable then
    begin
      Form.SetBounds(l,t,w,h);

      try
        Form.Windowstate:=TWindowState(GetEnumValue(TYpeinfo(TWindowState),ws));
      except
      end;
    end
   else
    begin
      Form.Left:=l; Form.Top:=t;
    end;
end;



end.

