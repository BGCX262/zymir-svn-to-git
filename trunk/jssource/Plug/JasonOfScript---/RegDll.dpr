library RegDll;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  RSA,
  HUtil32 in '..\PlugInCommon\HUtil32.pas',
  Share in 'Share.pas';

{$R *.res}

function GetRegInfo(UserName,HardwareID:PChar;LoMsg:Pointer;LoMsgLen:Integer):Integer;stdcall;
var
  CommonalityKey, CommonalityMode, PrivateKey: string;
  Script: TRSA;
  Tempstrn: String;
begin
  GetMode(IntToStr(FormatHardwareID(HardwareID)),IntToStr(FormatUserName(UserName)),CommonalityKey, CommonalityMode, PrivateKey);
  Script := TRSA.Create(nil);
  try
    Script.Server := True;
    Script.CommonalityMode := CommonalityMode;
    Script.PrivateKey := PrivateKey;
    Tempstrn := Script.EncryptStr('302682675416074797175010037341|242125495024981486632021295333|OK');
    Move(Tempstrn[1],LoMsg^,Length(Tempstrn) + 1);
    Result := Length(Tempstrn) + 1;
  finally
    Script.Free;
  end;
end;

exports
  GetRegInfo;

begin
end.
