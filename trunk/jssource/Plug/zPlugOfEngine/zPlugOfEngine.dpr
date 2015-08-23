library zPlugOfEngine;

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
  Windows,
  SysUtils,
  Classes,
  PlugMain in 'PlugMain.pas',
  PlayUserCmd in 'PlayUserCmd.pas',
  PlugShare in 'PlugShare.pas',
  EngineAPI in '..\PlugInCommon\EngineAPI.pas',
  HUtil32 in '..\PlugInCommon\HUtil32.pas',
  PlayUser in 'PlayUser.pas',
  EngineType in '..\PlugInCommon\EngineType.pas';

{$R *.res}
const
  PlugName = '晋升游戏引擎功能插件';
  LoadPlus = '正在加载晋升游戏引擎功能插件....';
type
  TMsgProc          = procedure(Msg:PChar;nMsgLen:Integer;nMode:Integer);stdcall;
  TFindProc         = function(sProcName:PChar;nNameLen:Integer):Pointer;stdcall;
  TFindObj          = function(sObjName:PChar;nNameLen:Integer):TObject;stdcall;
  TSetProc          = function(ProcAddr:Pointer;ProcName:PChar;nNameLen:Integer):Boolean;stdcall;

function Init(AppHandle:HWnd;MsgProc:TMsgProc;FindProc:TFindProc;SetProc:TSetProc;FindObj:TFindObj):PChar;stdcall;
begin
  MsgProc(LoadPlus,length(LoadPlus),0);
  InitPlug();
  Result:=PlugName;
end;

procedure UnInit();
begin
  UnInitPlug();
end;

function GetFunAddr(nIndex:Integer):Pointer;stdcall;
begin
  Result:=nil;
end;


exports
  Init,UnInit,GetFunAddr;
begin

end.
