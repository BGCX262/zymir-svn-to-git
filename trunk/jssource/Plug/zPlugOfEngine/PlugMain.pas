unit PlugMain;

interface
uses
  Windows,SysUtils, EngineAPI;
  
procedure InitPlug();
procedure UnInitPlug();
procedure InitShareObject();
implementation

uses PlayUserCmd,PlugShare, PlayUser;

procedure InitPlug();
begin
  SetDemoNotice(2);
  InitShareObject();
  InitPlayUserCmd();
  InitPlayUser();
end;

procedure UnInitPlug();
begin
  UnInitPlayUserCmd();
  UnInitPlayUser();
end;

procedure InitShareObject();
begin
  //TMemoryManager_Get(@g_MemMgr);
end;
end.
