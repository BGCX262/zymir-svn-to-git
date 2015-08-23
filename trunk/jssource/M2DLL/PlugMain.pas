unit PlugMain;

interface

procedure InitPlug();
procedure InitializePlug();
procedure UnInitPlug();
procedure InitShareObject();


implementation
uses PlacingItem,EngineApi,PlugShare,EngineType,PlugHook,PlugMagic;

procedure InitializePlug();
begin
  PLItem_Init;
end;

procedure InitPlug();
begin
  InitShareObject();
  MagicInitPlug();
  OldPlayObjectOperateMessage:=TPlayObject_GetHookPlayOperateMessage();
  TPlayObject_SetHookPlayOperateMessage(@ObjectOperateMessage);
end;

procedure UnInitPlug();
begin
  MagicUnInitPlug();
  PLItem_UnInit;
end;

procedure InitShareObject();
begin
  TMemoryManager_Get(@g_MemMgr);
end;

end.
