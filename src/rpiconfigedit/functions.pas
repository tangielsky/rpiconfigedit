unit functions;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

function StrInt(ss : string) : longint;

implementation

function StrInt(ss : string) : longint;
var
  ww : longint;
  hh : integer;
begin
  val(ss,ww,hh);
  StrInt:=ww;
end;



end.

