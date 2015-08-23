library JsPlugOfScript;

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
  Windows,
  Classes,
  EngineAPI in '..\PlugInCommon\EngineAPI.pas',
  EngineType in '..\PlugInCommon\EngineType.pas',
  HUtil32 in '..\PlugInCommon\HUtil32.pas',
  FrmReg in 'FrmReg.pas' {FormReg},
  Share in 'Share.pas',
  GetHardInfo in 'GetHardInfo.pas';

{$R *.res}
const
  PlugName1  = '东华网络专用脚本加密插件(未注册)';
  PlugName2  = '东华网络专用脚本加密插件(已注册)';
  LoadPlus   = '正在加载东华网络专用脚本加密插件....';
  ScriptPorc = 'PlugOfScript';

type
  TMsgProc  = procedure(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;
  TFindProc = function(sProcName: PChar; nNameLen: Integer): Pointer; stdcall;
  TFindObj  = function(sObjName: PChar; nNameLen: Integer): TObject; stdcall;
  TSetProc  = function(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer): Boolean; stdcall;

function Init(AppHandle: HWnd; MsgProc: TMsgProc; FindProc: TFindProc; SetProc: TSetProc; FindObj: TFindObj): PChar; stdcall;
begin
  MsgProc(LoadPlus, length(LoadPlus), 0);
  if InitScript() then
  begin
    SetProc(@GetScriptText,ScriptPorc,length(ScriptPorc));
    Result := PlugName2;
  end else Result := PlugName1;
end;

procedure UnInit();stdcall;
begin
  UnInitScript();
end;


exports
  Init, UnInit;

begin
end.

