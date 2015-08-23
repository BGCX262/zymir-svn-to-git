//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit UserEngineApi;

interface
uses Windows, M2Share, EngineType, SysUtils, UsrEngn, grobal2;

function TUserEngine_Create(): TUserEngine; stdcall;
procedure TUserEngine_Free(UserEngine: TUserEngine); stdcall;
function TUserEngine_GetUserEngine(): TUserEngine; stdcall;

function TUserEngine_GetPlayObject(szPlayName: PChar; boGetHide: Boolean):
  TPlayObject; stdcall;

function TUserEngine_GetLoadPlayList(): TStringList; stdcall;
function TUserEngine_GetPlayObjectList(): TStringList; stdcall;
function TUserEngine_GetLoadPlayCount(): Integer; stdcall;
function TUserEngine_GetPlayObjectCount(): Integer; stdcall;
function TUserEngine_GetStdItemByName(pszItemName: PChar): pTStdItem; stdcall;
function TUserEngine_GetStdItemByIndex(nIndex: Integer): pTStdItem; stdcall;
function TUserEngine_CopyToUserItemFromName(const pszItemName: PChar; UserItem:
  pTUserItem): BOOL; stdcall;
function TUserEngine_GetClientItem(UserItem: pTUserItem; var ClientItem:
  TClientItem): Boolean; stdcall;

procedure TUserEngine_SetHookRun(UserEngineRun: _TOBJECTACTION); stdcall;
function TUserEngine_GetHookRun(): _TOBJECTACTION; stdcall;
procedure TUserEngine_SetHookClientUserMessage(ClientMsg: _TOBJECTCLIENTMSG);
  stdcall;

implementation
uses
  PlugApi, ItmUnit;

function TUserEngine_GetClientItem(UserItem: pTUserItem; var ClientItem:
  TClientItem): Boolean; stdcall;
var
  Item: TItem;
begin
  try
    Result := False;
    Item := UserEngine.GetStdItem(UserItem.wIndex);
    if Item <> nil then
    begin
      Item.GetStandardItem(ClientItem.S);
      Item.GetItemAddValue(UserItem, ClientItem.S);
      ClientItem.S.Name := GetItemName(UserItem);

      ClientItem.Dura := UserItem.Dura;
      ClientItem.DuraMax := UserItem.DuraMax;
      ClientItem.MakeIndex := UserItem.MakeIndex;

      GetMapItemInfo(UserItem, ClientItem.S);
      Result := True;
    end;
  except
    MainOutMessage('[Exception] UnUserEngineApi.TUserEngine_GetClientItem');
  end;
end;

procedure TUserEngine_SetHookRun(UserEngineRun: _TOBJECTACTION); stdcall;
begin
  try
    m_HookUserEngineRun := UserEngineRun;
  except
    MainOutMessage('[Exception] UnUserEngineApi.TUserEngine_SetHookRun');
  end;
end;

function TUserEngine_GetHookRun(): _TOBJECTACTION; stdcall;
begin
  try
    Result := m_HookUserEngineRun;
  except
    MainOutMessage('[Exception] UnUserEngineApi.TUserEngine_GetHookRun');
  end;
end;

procedure TUserEngine_SetHookClientUserMessage(ClientMsg: _TOBJECTCLIENTMSG);
  stdcall;
begin
  try
    m_HookClientUserMessage := @ClientMsg;
  except
    MainOutMessage('[Exception] UnUserEngineApi.TUserEngine_SetHookClientUserMessage');
  end;
end;

function TUserEngine_CopyToUserItemFromName(const pszItemName: PChar; UserItem:
  pTUserItem): BOOL; stdcall;
begin
  try
    Result := UserEngine.CopyToUserItemFromName(pszItemName, UserItem);
  except
    MainOutMessage('[Exception] UnUserEngineApi.TUserEngine_CopyToUserItemFromName');
  end;
end;

function TUserEngine_GetPlayObjectCount(): Integer; stdcall;
begin
  try
    Result := UserEngine.PlayObjectCount;
  except
    MainOutMessage('[Exception] UnUserEngineApi.TUserEngine_GetPlayObjectCount');
  end;
end;

function TUserEngine_GetLoadPlayCount(): Integer; stdcall;
begin
  try
    Result := UserEngine.LoadPlayCount;
  except
    MainOutMessage('[Exception] UnUserEngineApi.TUserEngine_GetLoadPlayCount');
  end;
end;

function TUserEngine_GetPlayObjectList(): TStringList; stdcall;
begin
  try
    Result := UserEngine.m_PlayObjectList;
  except
    MainOutMessage('[Exception] UnUserEngineApi.TUserEngine_GetPlayObjectList');
  end;
end;

function TUserEngine_GetLoadPlayList(): TStringList; stdcall;
begin
  try
    Result := UserEngine.m_LoadPlayList;
  except
    MainOutMessage('[Exception] UnUserEngineApi.TUserEngine_GetLoadPlayList');
  end;
end;

function TUserEngine_GetPlayObject(szPlayName: PChar; boGetHide: Boolean):
  TPlayObject; stdcall;
begin
  try
    Result := UserEngine.GetPlayObject(szPlayName);
  except
    MainOutMessage('[Exception] UnUserEngineApi.TUserEngine_GetPlayObject');
  end;
end;

function TUserEngine_GetUserEngine(): TUserEngine; stdcall;
begin
  try
    Result := UserEngine;
  except
    MainOutMessage('[Exception] UnUserEngineApi.TUserEngine_GetUserEngine');
  end;
end;

procedure TUserEngine_Free(UserEngine: TUserEngine); stdcall;
begin
  try
    UserEngine.Free;
  except
    MainOutMessage('[Exception] UnUserEngineApi.TUserEngine_Free');
  end;
end;

function TUserEngine_Create(): TUserEngine; stdcall;
begin
  try
    Result := TUserEngine.Create;
  except
    MainOutMessage('[Exception] UnUserEngineApi.TUserEngine_Create');
  end;
end;

function TUserEngine_GetStdItemByName(pszItemName: PChar): pTStdItem; stdcall;
begin
  try
    //Result:=UserEngine.GetStdItemEx(pszItemName);
  except
    MainOutMessage('[Exception] UnUserEngineApi.TUserEngine_GetStdItemByName');
  end;
end;

function TUserEngine_GetStdItemByIndex(nIndex: Integer): pTStdItem; stdcall;
begin
  try
    //Result:=UserEngine.GetStdItemEx(nIndex);
  except
    MainOutMessage('[Exception] UnUserEngineApi.TUserEngine_GetStdItemByIndex');
  end;
end;

end.

