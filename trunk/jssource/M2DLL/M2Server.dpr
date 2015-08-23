library M2Server;

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
  SDK in '..\SDK\SDK.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  EDcode in '..\Common\EDcode.pas',
  EngineAPI in '..\PlugInCommon\EngineAPI.pas',
  EngineType in '..\PlugInCommon\EngineType.pas',
  PlugMain in 'PlugMain.pas',
  PlacingItem in 'PlacingItem.pas',
  PlugShare in 'PlugShare.pas',
  PlugHook in 'PlugHook.pas',
  PlugMagic in 'PlugMagic.pas';

{$R *.res}

function Init(nVer:Integer):Boolean;stdcall;
begin
  Result:=False;
  if nVer=M2PLUG_VERSION then begin
    //InitPlug;
    //MainOutMessage(PChar(GetLevelItemGameCount()));
    //nCheck:=0;
    Result:=True;
  end;
end;

procedure UnInit();stdcall;
begin
  //UnInitPlug;
end;

procedure Initialize(var nCheck:Integer);stdcall;
var
  Str:String;
begin
  Str:=String(GetLevelItemGameCount());
  if CalcFileCRC(Str) = -43059996 then nCheck:=101;
end;

exports
  Init       Name 'M2Server_Init',
  UnInit     Name 'M2Server_UnInit',
  Initialize Name 'M2Server_Initialize';

begin
end.
