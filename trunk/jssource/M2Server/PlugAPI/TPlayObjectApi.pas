//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit TPlayObjectApi;

interface
uses Windows, M2Share, EngineType, SysUtils, ObjBase, grobal2, ObjNpc;

function TPlayObject_nSoftVersionDate(PlayObject: TPlayObject): PInteger;
  stdcall;
function TPlayObject_nSoftVersionDateEx(PlayObject: TPlayObject): PInteger;
  stdcall;
function TPlayObject_dLogonTime(PlayObject: TPlayObject): PDateTime; stdcall;
function TPlayObject_dwLogonTick(PlayObject: TPlayObject): PLongWord; stdcall;
function TPlayObject_nMemberType(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_nMemberLevel(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_nGameGold(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_nGamePoint(PlayObject: TPlayObject): PInteger; stdcall;
function TPlayObject_nPayMentPoint(PlayObject: TPlayObject): PInteger; stdcall;
//function  TPlayObject_nClientFlag(PlayObject:TPlayObject):PInteger;stdcall;
//  function  TPlayObject_nClientFlagMode(PlayObject:TPlayObject):PInteger;stdcall;
function TPlayObject_dwClientTick(PlayObject: TPlayObject): PLongWord; stdcall;
//function  TPlayObject_sBankPassword(PlayObject:TPlayObject):_LPTBANKPWD;stdcall;
//function  TPlayObject_nBankGold(PlayObject:TPlayObject):PInteger;stdcall;
function TPlayObject_Create(): TPlayObject; stdcall;
procedure TPlayObject_Free(PlayObject: TPlayObject); stdcall;
procedure TPlayObject_SendSocket(PlayObject: TPlayObject; DefMsg:
  PTDEFAULTMESSAGE; pszMsg: PChar); stdcall;
procedure TPlayObject_SendDefMessage(PlayObject: TPlayObject; wIdent: Word;
  nRecog: Integer; nParam, nTag, nSeries: Word; pszMsg: PChar); stdcall;
procedure TPlayObject_SendAddItem(PlayObject: TPlayObject; AddItem: PTUSERITEM);
  stdcall;
procedure TPlayObject_SendDelItem(PlayObject: TPlayObject; AddItem: PTUSERITEM);
  stdcall;
function TPlayObject_TargetInNearXY(PlayObject: TPlayObject; Target:
  TBaseObject; nX, nY: Integer): Boolean; stdcall;
//procedure TPlayObject_SetBankPassword(PlayObject:TPlayObject;pszPassword:PChar);stdcall;

procedure TPlayObject_SetHookCreate(PlayObjectCreate: _TOBJECTACTION); stdcall;
function TPlayObject_GetHookCreate(): _TOBJECTACTION; stdcall;
procedure TPlayObject_SetHookDestroy(PlayObjectDestroy: _TOBJECTACTION);
  stdcall;
function TPlayObject_GetHookDestroy(): _TOBJECTACTION; stdcall;
procedure TPlayObject_SetHookUserLogin1(PlayObjectUserLogin: _TOBJECTACTION);
  stdcall;
procedure TPlayObject_SetHookUserLogin2(PlayObjectUserLogin: _TOBJECTACTION);
  stdcall;
procedure TPlayObject_SetHookUserLogin3(PlayObjectUserLogin: _TOBJECTACTION);
  stdcall;
procedure TPlayObject_SetHookUserLogin4(PlayObjectUserLogin: _TOBJECTACTION);
  stdcall;

procedure TPlayObject_SetHookUserCmd(PlayObjectUserCmd: _TOBJECTUSERCMD);
  stdcall;
function TPlayObject_GetHookUserCmd(): _TOBJECTUSERCMD; stdcall;

procedure TPlayObject_SetHookPlayOperateMessage(PlayObjectOperateMessage:
  _TOBJECTOPERATEMESSAGE); stdcall;
function TPlayObject_GetHookPlayOperateMessage(): _TOBJECTOPERATEMESSAGE;
  stdcall;
procedure TPlayObject_SetHookClientQueryBagItems(ClientQueryBagItems:
  _TOBJECTACTION); stdcall;
procedure TPlayObject_SetHookClientQueryUserState(ClientQueryUserState:
  _TOBJECTACTIONXY); stdcall;
procedure TPlayObject_SetHookSendActionGood(SendActionGood: _TOBJECTACTION);
  stdcall;
procedure TPlayObject_SetHookSendActionFail(SendActionFail: _TOBJECTACTION);
  stdcall;

procedure TPlayObject_SetHookSendWalkMsg(ObjectActioinXYD: _TOBJECTACTIONXYD);
  stdcall;
procedure TPlayObject_SetHookSendHorseRunMsg(ObjectActioinXYD:
  _TOBJECTACTIONXYD); stdcall;
procedure TPlayObject_SetHookSendRunMsg(ObjectActioinXYD: _TOBJECTACTIONXYD);
  stdcall;
procedure TPlayObject_SetHookSendDeathMsg(ObjectActioinXYDM:
  _TOBJECTACTIONXYDM); stdcall;
procedure TPlayObject_SetHookSendSkeletonMsg(ObjectActioinXYD:
  _TOBJECTACTIONXYD); stdcall;
procedure TPlayObject_SetHookSendAliveMsg(ObjectActioinXYD: _TOBJECTACTIONXYD);
  stdcall;
procedure TPlayObject_SetHookSendSpaceMoveMsg(ObjectActioinXYDWS:
  _TOBJECTACTIONXYDWS); stdcall;
procedure TPlayObject_SetHookSendChangeFaceMsg(ObjectActioinObject:
  _TOBJECTACTIONOBJECT); stdcall;
procedure TPlayObject_SetHookSendUseitemsMsg(ObjectActioin: _TOBJECTACTION);
  stdcall;
procedure TPlayObject_SetHookSendUserLevelUpMsg(ObjectActioinObject:
  _TOBJECTACTION); stdcall;
procedure TPlayObject_SetHookSendUserAbilieyMsg(ObjectActioinObject:
  _TOBJECTACTION); stdcall;
procedure TPlayObject_SetHookSendUserStatusMsg(ObjectActioinXYDWS:
  _TOBJECTACTIONXYDWS); stdcall;
procedure TPlayObject_SetHookSendUserStruckMsg(ObjectActioinObject:
  _TOBJECTACTIONOBJECT); stdcall;
procedure TPlayObject_SetHookSendUseMagicMsg(ObjectActioin: _TOBJECTACTION);
  stdcall;
procedure TPlayObject_SetHookSendSocket(SendSocket: _TPLAYSENDSOCKET); stdcall;
procedure TPlayObject_SetHookSendGoodsList(SendGoodsList:
  _TOBJECTACTIONSENDGOODS); stdcall;
procedure TPlayObject_SetCheckClientDropItem(ActionDropItem:
  _TOBJECTACTIONITEM); stdcall;
procedure TPlayObject_SetCheckClientDealItem(ActionItem: _TOBJECTACTIONITEM);
  stdcall;
procedure TPlayObject_SetCheckClientStorageItem(ActionItem: _TOBJECTACTIONITEM);
  stdcall;
procedure TPlayObject_SetCheckClientRepairItem(ActionItem: _TOBJECTACTIONITEM);
  stdcall;
procedure TPlayObject_SetHookCheckUserItems(ObjectActioin:
  _TOBJECTACTIONCHECKUSEITEM); stdcall;
procedure TPlayObject_SetHookRun(PlayRun: _TOBJECTACTION); stdcall;
procedure TPlayObject_SetHookFilterMsg(FilterMsg: _TOBJECTFILTERMSG); stdcall;

function TPlayObject_CheckPlaySideNpc(PlayObject: TPlayObject; NormNpc:
  TNormNpc): TNormNpc; stdcall;

implementation

{Try
    if g_CheckClientDropItem.Count > 0 then begin
      For I:=0 to g_CheckClientDropItem.Count-1 do
        if Assigned(g_CheckClientDropItem.Items[I]) then
          if not _TOBJECTACTIONITEM(g_CheckClientDropItem.Items[I])(Self,PChar(sItemName)) then exit;
    end;
  Except
    MainOutMessage('[Exception] TPlayObject.ClientDropItem->HookApi');
  end;
  Try
    if g_CheckClientStorageItem.Count > 0 then begin
      For I:=0 to g_CheckClientStorageItem.Count-1 do begin
        if Assigned(g_CheckClientStorageItem.Items[I]) then
          if not _TOBJECTACTIONITEM(g_CheckClientStorageItem.Items[I])(Self,PChar(sMsg)) then begin
            boCheck:=False;
            Break;
          end;
      end;
    end;
  Except
    MainOutMessage('[Exception] TPlayObject.ClientAddDealItem->HookApi');
  end;}

function TPlayObject_CheckPlaySideNpc(PlayObject: TPlayObject; NormNpc:
  TNormNpc): TNormNpc; stdcall;
var
  Merchant: TMerchant;
begin
  try
    Result := nil;
    Merchant := UserEngine.FindMerchant(NormNpc);
    if (Merchant <> nil) and
      ((Merchant.m_PEnvir = PlayObject.m_PEnvir) and
      (abs(Merchant.m_nCurrX - PlayObject.m_nCurrX) < 15) and
      (abs(Merchant.m_nCurrY - PlayObject.m_nCurrY) < 15)) then
      Result := Merchant;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_CheckPlaySideNpc');
  end;
end;

procedure TPlayObject_SetHookFilterMsg(FilterMsg: _TOBJECTFILTERMSG); stdcall;
begin
  try
    m_HookFilterMsg := FilterMsg;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookFilterMsg');
  end;
end;

procedure TPlayObject_SetHookRun(PlayRun: _TOBJECTACTION); stdcall;
begin
  try
    m_HookRun := PlayRun;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookRun');
  end;
end;

procedure TPlayObject_SetHookCheckUserItems(ObjectActioin:
  _TOBJECTACTIONCHECKUSEITEM); stdcall;
begin
  try
    m_HookCheckUserItems := @ObjectActioin;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookCheckUserItems');
  end;
end;

procedure TPlayObject_SetCheckClientRepairItem(ActionItem: _TOBJECTACTIONITEM);
  stdcall;
begin
  try
    m_CheckClientRepairItem := @ActionItem;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetCheckClientRepairItem');
  end;
end;

procedure TPlayObject_SetCheckClientStorageItem(ActionItem: _TOBJECTACTIONITEM);
  stdcall;
begin
  try
    m_CheckClientStorageItem := @ActionItem;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetCheckClientStorageItem');
  end;
end;

procedure TPlayObject_SetCheckClientDealItem(ActionItem: _TOBJECTACTIONITEM);
  stdcall;
begin
  try
    m_CheckClientDealItem := @ActionItem;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetCheckClientDealItem');
  end;
end;

procedure TPlayObject_SetCheckClientDropItem(ActionDropItem: _TOBJECTACTIONITEM);
  stdcall;
begin
  try
    m_CheckClientDropItem := @ActionDropItem;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetCheckClientDropItem');
  end;
end;

procedure TPlayObject_SetHookSendGoodsList(SendGoodsList:
  _TOBJECTACTIONSENDGOODS); stdcall;
begin
  try
    m_HookSendGoodsList := @SendGoodsList;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendGoodsList');
  end;
end;

procedure TPlayObject_SetHookSendSocket(SendSocket: _TPLAYSENDSOCKET); stdcall;
begin
  try
    m_HookSendSocket := @SendSocket;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendSocket');
  end;
end;

procedure TPlayObject_SetHookSendUseMagicMsg(ObjectActioin: _TOBJECTACTION);
  stdcall;
begin
  try
    m_HookSendUseMagicMsg := @ObjectActioin;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendUseMagicMsg');
  end;
end;

procedure TPlayObject_SetHookSendUserStruckMsg(ObjectActioinObject:
  _TOBJECTACTIONOBJECT); stdcall;
begin
  try
    m_HookSendUserStruckMsg := @ObjectActioinObject;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendUserStruckMsg');
  end;
end;

procedure TPlayObject_SetHookSendUserStatusMsg(ObjectActioinXYDWS:
  _TOBJECTACTIONXYDWS); stdcall;
begin
  try
    m_HookSendUserStatusMsg := @ObjectActioinXYDWS;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendUserStatusMsg');
  end;
end;

procedure TPlayObject_SetHookSendUserAbilieyMsg(ObjectActioinObject:
  _TOBJECTACTION); stdcall;
begin
  try
    m_HookSendUserAbilieyMsg := @ObjectActioinObject;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendUserAbilieyMsg');
  end;
end;

procedure TPlayObject_SetHookSendUserLevelUpMsg(ObjectActioinObject:
  _TOBJECTACTION); stdcall;
begin
  try
    m_HookSendUserLevelUpMsg := @ObjectActioinObject;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendUserLevelUpMsg');
  end;
end;

procedure TPlayObject_SetHookSendUseitemsMsg(ObjectActioin: _TOBJECTACTION);
  stdcall;
begin
  try
    m_HookSendUseitemsMsg := @ObjectActioin;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendUseitemsMsg');
  end;
end;

procedure TPlayObject_SetHookSendChangeFaceMsg(ObjectActioinObject:
  _TOBJECTACTIONOBJECT); stdcall;
begin
  try
    m_HookSendChangeFaceMsg := @ObjectActioinObject;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendChangeFaceMsg');
  end;
end;

procedure TPlayObject_SetHookSendSpaceMoveMsg(ObjectActioinXYDWS:
  _TOBJECTACTIONXYDWS); stdcall;
begin
  try
    m_HookSendSpaceMoveMsg := @ObjectActioinXYDWS;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendSpaceMoveMsg');
  end;
end;

procedure TPlayObject_SetHookSendAliveMsg(ObjectActioinXYD: _TOBJECTACTIONXYD);
  stdcall;
begin
  try
    m_HookSendAliveMsg := @ObjectActioinXYD;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendAliveMsg');
  end;
end;

procedure TPlayObject_SetHookSendSkeletonMsg(ObjectActioinXYD:
  _TOBJECTACTIONXYD); stdcall;
begin
  try
    m_HookSendSkeletonMsg := @ObjectActioinXYD;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendSkeletonMsg');
  end;
end;

procedure TPlayObject_SetHookSendDeathMsg(ObjectActioinXYDM: _TOBJECTACTIONXYDM);
  stdcall;
begin
  try
    m_HookSendDeathMsg := @ObjectActioinXYDM;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendDeathMsg');
  end;
end;

procedure TPlayObject_SetHookSendRunMsg(ObjectActioinXYD: _TOBJECTACTIONXYD);
  stdcall;
begin
  try
    m_HookSendRunMsg := @ObjectActioinXYD;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendRunMsg');
  end;
end;

procedure TPlayObject_SetHookSendHorseRunMsg(ObjectActioinXYD:
  _TOBJECTACTIONXYD); stdcall;
begin
  try
    m_HookSendHorseRunMsg := @ObjectActioinXYD;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendHorseRunMsg');
  end;
end;

procedure TPlayObject_SetHookSendWalkMsg(ObjectActioinXYD: _TOBJECTACTIONXYD);
  stdcall;
begin
  try
    m_HookSendWalkMsg := @ObjectActioinXYD;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendWalkMsg');
  end;
end;

procedure TPlayObject_SetHookSendActionGood(SendActionGood: _TOBJECTACTION);
  stdcall;
begin
  try
    m_HookSendActionGood := @SendActionGood;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendActionGood');
  end;
end;

procedure TPlayObject_SetHookSendActionFail(SendActionFail: _TOBJECTACTION);
  stdcall;
begin
  try
    m_HookSendActionFail := @SendActionFail;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookSendActionFail');
  end;
end;

procedure TPlayObject_SetHookClientQueryUserState(ClientQueryUserState:
  _TOBJECTACTIONXY); stdcall;
begin
  try
    m_HookClientQueryUserState := @ClientQueryUserState;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookClientQueryUserState');
  end;
end;

procedure TPlayObject_SetHookClientQueryBagItems(ClientQueryBagItems:
  _TOBJECTACTION); stdcall;
begin
  try
    m_HookClientQueryBagItems := @ClientQueryBagItems;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookClientQueryBagItems');
  end;
end;

procedure TPlayObject_SetHookPlayOperateMessage(PlayObjectOperateMessage:
  _TOBJECTOPERATEMESSAGE); stdcall;
begin
  try
    m_HookPlayOperateMessage := PlayObjectOperateMessage;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookPlayOperateMessage');
  end;
end;

function TPlayObject_GetHookPlayOperateMessage(): _TOBJECTOPERATEMESSAGE;
  stdcall;
begin
  try
    Result := m_HookPlayOperateMessage;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_GetHookPlayOperateMessage');
  end;
end;

procedure TPlayObject_SetHookUserCmd(PlayObjectUserCmd: _TOBJECTUSERCMD);
  stdcall;
begin
  try
    m_HookUserCmd := PlayObjectUserCmd;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookUserCmd');
  end;
end;

function TPlayObject_GetHookUserCmd(): _TOBJECTUSERCMD; stdcall;
begin
  try
    Result := m_HookUserCmd;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_GetHookUserCmd');
  end;
end;

procedure TPlayObject_SetHookUserLogin1(PlayObjectUserLogin: _TOBJECTACTION);
  stdcall;
begin
  try
    m_HookUserLogin1 := @PlayObjectUserLogin;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookUserLogin1');
  end;
end;

procedure TPlayObject_SetHookUserLogin2(PlayObjectUserLogin: _TOBJECTACTION);
  stdcall;
begin
  try
    m_HookUserLogin2 := @PlayObjectUserLogin;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookUserLogin2');
  end;
end;

procedure TPlayObject_SetHookUserLogin3(PlayObjectUserLogin: _TOBJECTACTION);
  stdcall;
begin
  try
    m_HookUserLogin3 := @PlayObjectUserLogin;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookUserLogin3');
  end;
end;

procedure TPlayObject_SetHookUserLogin4(PlayObjectUserLogin: _TOBJECTACTION);
  stdcall;
begin
  try
    m_HookUserLogin4 := @PlayObjectUserLogin;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookUserLogin4');
  end;
end;

procedure TPlayObject_SetHookDestroy(PlayObjectDestroy: _TOBJECTACTION);
  stdcall;
begin
  try
    m_HookDestroy := PlayObjectDestroy;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookDestroy');
  end;
end;

function TPlayObject_GetHookDestroy(): _TOBJECTACTION; stdcall;
begin
  try
    Result := m_HookDestroy;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_GetHookDestroy');
  end;
end;

procedure TPlayObject_SetHookCreate(PlayObjectCreate: _TOBJECTACTION); stdcall;
begin
  try
    m_HookCreate := PlayObjectCreate;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SetHookCreate');
  end;
end;

function TPlayObject_GetHookCreate(): _TOBJECTACTION; stdcall;
begin
  try
    Result := m_HookCreate;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_GetHookCreate');
  end;
end;

function TPlayObject_TargetInNearXY(PlayObject: TPlayObject; Target:
  TBaseObject; nX, nY: Integer): Boolean; stdcall;
begin
  try
    Result := PlayObject.CretInNearXY(Target, nX, nY);
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_TargetInNearXY');
  end;
end;

procedure TPlayObject_SendDelItem(PlayObject: TPlayObject; AddItem: PTUSERITEM);
  stdcall;
begin
  try
    PlayObject.SendDelItems(AddItem);
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SendDelItem');
  end;
end;

procedure TPlayObject_SendAddItem(PlayObject: TPlayObject; AddItem: PTUSERITEM);
  stdcall;
begin
  try
    PlayObject.SendAddItem(AddItem);
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SendAddItem');
  end;
end;

procedure TPlayObject_SendDefMessage(PlayObject: TPlayObject; wIdent: Word;
  nRecog: Integer; nParam, nTag, nSeries: Word; pszMsg: PChar); stdcall;
begin
  try
    PlayObject.SendDefMessage(wIdent, nRecog, nParam, nTag, nSeries, pszMsg);
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SendDefMessage');
  end;
end;

procedure TPlayObject_SendSocket(PlayObject: TPlayObject; DefMsg:
  PTDEFAULTMESSAGE; pszMsg: PChar); stdcall;
begin
  try
    PlayObject.SendSocket(DefMsg, pszMsg);
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_SendSocket');
  end;
end;

procedure TPlayObject_Free(PlayObject: TPlayObject); stdcall;
begin
  try
    PlayObject.Free;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_Free');
  end;
end;

function TPlayObject_Create(): TPlayObject; stdcall;
begin
  try
    Result := TPlayObject.Create;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_Create');
  end;
end;

function TPlayObject_dwClientTick(PlayObject: TPlayObject): PLongWord; stdcall;
begin
  try
    Result := @PlayObject.m_dwClientTick;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_dwClientTick');
  end;
end;

{function  TPlayObject_nClientFlagMode(PlayObject:TPlayObject):PInteger;stdcall;
begin
  //Result:=@PlayObject.m_nClientFlagMode;
Except
  MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_nClientFlag');
End;
Except
  MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_dwClientTick');
End;
end;

function  TPlayObject_nClientFlag(PlayObject:TPlayObject):PInteger;stdcall;
begin
Try
  Result:=@PlayObject.m_boClientFlag;
end; }

function TPlayObject_nPayMentPoint(PlayObject: TPlayObject): PInteger; stdcall;
begin
  try
    Result := @PlayObject.m_nPayMentPoint;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_nPayMentPoint');
  end;
end;

function TPlayObject_nGamePoint(PlayObject: TPlayObject): PInteger; stdcall;
begin
  try
    Result := @PlayObject.m_nGamePoint;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_nGamePoint');
  end;
end;

function TPlayObject_nGameGold(PlayObject: TPlayObject): PInteger; stdcall;
begin
  try
    Result := @PlayObject.m_nGameGold;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_nGameGold');
  end;
end;

function TPlayObject_nMemberLevel(PlayObject: TPlayObject): PInteger; stdcall;
begin
  try
    Result := @PlayObject.m_nMemberLevel;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_nMemberLevel');
  end;
end;

function TPlayObject_nMemberType(PlayObject: TPlayObject): PInteger; stdcall;
begin
  try
    Result := @PlayObject.m_nMemberType;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_nMemberType');
  end;
end;

function TPlayObject_dwLogonTick(PlayObject: TPlayObject): PLongWord; stdcall;
begin
  try
    Result := @PlayObject.m_dwLogonTick;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_dwLogonTick');
  end;
end;

function TPlayObject_dLogonTime(PlayObject: TPlayObject): PDateTime; stdcall;
begin
  try
    Result := @PlayObject.m_dLogonTime;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_dLogonTime');
  end;
end;

function TPlayObject_nSoftVersionDateEx(PlayObject: TPlayObject): PInteger;
  stdcall;
begin
  try
    Result := @PlayObject.m_nSoftVersionDateEx;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_nSoftVersionDateEx');
  end;
end;

function TPlayObject_nSoftVersionDate(PlayObject: TPlayObject): PInteger;
  stdcall;
begin
  try
    Result := @PlayObject.m_nSoftVersionDate;
  except
    MainOutMessage('[Exception] UnTPlayObjectApi.TPlayObject_nSoftVersionDate');
  end;
end;

initialization
  begin

  end;

finalization
  begin
  end;

end.

