{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit configedits;

{$warn 5023 off : no warning about unused units}
interface

uses
  confed, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('confed', @confed.Register);
end;

initialization
  RegisterPackage('configedits', @Register);
end.
