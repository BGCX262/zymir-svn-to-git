//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit TBaseObjectApi;

interface
uses Windows, M2Share, EngineType, SysUtils, ObjBase, grobal2;

function TBaseObject_Create(): TBaseObject; stdcall;
procedure TBaseObject_Free(BaseObject: TBaseObject); stdcall;
function TBaseObject_sMapFileName(BaseObject: TBaseObject): _LPTSHORTSTRING;
  stdcall;
function TBaseObject_sMapName(BaseObject: TBaseObject): _LPTSHORTSTRING;
  stdcall;
function TBaseObject_sMapNameA(BaseObject: TBaseObject): _LPTMAPNAME; stdcall;
function TBaseObject_sCharName(BaseObject: TBaseObject): _LPTSHORTSTRING;
  stdcall;
function TBaseObject_sCharNameA(BaseObject: TBaseObject): _LPTACTORNAME;
  stdcall;

function TBaseObject_nCurrX(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_nCurrY(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_btDirection(BaseObject: TBaseObject): PByte; stdcall;
function TBaseObject_btGender(BaseObject: TBaseObject): PByte; stdcall;
function TBaseObject_btHair(BaseObject: TBaseObject): PByte; stdcall;
function TBaseObject_btJob(BaseObject: TBaseObject): PByte; stdcall;
function TBaseObject_nGold(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_Ability(BaseObject: TBaseObject): _LPTABILITY; stdcall;

function TBaseObject_WAbility(BaseObject: TBaseObject): _LPTABILITY; stdcall;
function TBaseObject_nCharStatus(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_sHomeMap(BaseObject: TBaseObject): _LPTSHORTSTRING;
  stdcall;
function TBaseObject_nHomeX(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_nHomeY(BaseObject: TBaseObject): PInteger; stdcall;

function TBaseObject_boOnHorse(BaseObject: TBaseObject): PBoolean; stdcall;
function TBaseObject_btHorseType(BaseObject: TBaseObject): PByte; stdcall;
function TBaseObject_btDressEffType(BaseObject: TBaseObject): PByte; stdcall;
function TBaseObject_nPkPoint(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_boAllowGroup(BaseObject: TBaseObject): PBoolean; stdcall;
function TBaseObject_boAllowGuild(BaseObject: TBaseObject): PBoolean; stdcall;
function TBaseObject_nFightZoneDieCount(BaseObject: TBaseObject): PInteger;
  stdcall;
function TBaseObject_nBonusPoint(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_nHungerStatus(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_boAllowGuildReCall(BaseObject: TBaseObject): PBoolean;
  stdcall;
function TBaseObject_duBodyLuck(BaseObject: TBaseObject): PDouble; stdcall;
function TBaseObject_nBodyLuckLevel(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_wGroupRcallTime(BaseObject: TBaseObject): PWord; stdcall;
function TBaseObject_boAllowGroupReCall(BaseObject: TBaseObject): PBoolean;
  stdcall;
function TBaseObject_nCharStatusEx(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_dwFightExp(BaseObject: TBaseObject): PLongWord; stdcall;
function TBaseObject_nViewRange(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_wAppr(BaseObject: TBaseObject): PWord; stdcall;
function TBaseObject_btRaceServer(BaseObject: TBaseObject): PByte; stdcall;
function TBaseObject_btRaceImg(BaseObject: TBaseObject): PByte; stdcall;
function TBaseObject_btHitPoint(BaseObject: TBaseObject): PByte; stdcall;
function TBaseObject_nHitPlus(BaseObject: TBaseObject): PShortInt; stdcall;
function TBaseObject_nHitDouble(BaseObject: TBaseObject): PShortInt; stdcall;
function TBaseObject_boRecallSuite(BaseObject: TBaseObject): PBoolean; stdcall;
function TBaseObject_nHealthRecover(BaseObject: TBaseObject): PShortInt;
  stdcall;
function TBaseObject_nSpellRecover(BaseObject: TBaseObject): PShortInt; stdcall;
function TBaseObject_btAntiPoison(BaseObject: TBaseObject): PByte; stdcall;
function TBaseObject_nPoisonRecover(BaseObject: TBaseObject): PShortInt;
  stdcall;
function TBaseObject_nAntiMagic(BaseObject: TBaseObject): PShortInt; stdcall;
function TBaseObject_nLuck(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_nPerHealth(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_nPerHealing(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_nPerSpell(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_btGreenPoisoningPoint(BaseObject: TBaseObject): PByte;
  stdcall;
function TBaseObject_nGoldMax(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_btSpeedPoint(BaseObject: TBaseObject): PByte; stdcall;
function TBaseObject_btPermission(BaseObject: TBaseObject): PByte; stdcall;
function TBaseObject_nHitSpeed(BaseObject: TBaseObject): PShortInt; stdcall;
function TBaseObject_TargetCret(BaseObject: TBaseObject): PTBaseObject; stdcall;
function TBaseObject_LastHiter(BaseObject: TBaseObject): PTBaseObject; stdcall;
function TBaseObject_ExpHiter(BaseObject: TBaseObject): PTBaseObject; stdcall;
function TBaseObject_btLifeAttrib(BaseObject: TBaseObject): PByte; stdcall;
function TBaseObject_GroupOwner(BaseObject: TBaseObject): TBaseObject; stdcall;
function TBaseObject_GroupMembersList(BaseObject: TBaseObject): TStringList;
  stdcall;
function TBaseObject_boHearWhisper(BaseObject: TBaseObject): PBoolean; stdcall;
function TBaseObject_boBanShout(BaseObject: TBaseObject): PBoolean; stdcall;
function TBaseObject_boBanGuildChat(BaseObject: TBaseObject): PBoolean; stdcall;
function TBaseObject_boAllowDeal(BaseObject: TBaseObject): PBoolean; stdcall;
//function  TBaseObject_nSlaveType(BaseObject:TBaseObject):PInteger;stdcall;
function TBaseObject_Master(BaseObject: TBaseObject): PTBaseObject; stdcall;
function TBaseObject_btAttatckMode(BaseObject: TBaseObject): PByte; stdcall;
function TBaseObject_nNameColor(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_nLight(BaseObject: TBaseObject): PInteger; stdcall;
function TBaseObject_ItemList(BaseObject: TBaseObject): TList; stdcall;
function TBaseObject_MagicList(BaseObject: TBaseObject): TList; stdcall;
function TBaseObject_MyGuild(BaseObject: TBaseObject): TGuild; stdcall;
function TBaseObject_UseItems(BaseObject: TBaseObject): _LPTPLAYUSEITEMS;
  stdcall;
function TBaseObject_btMonsterWeapon(BaseObject: TBaseObject): PByte; stdcall;
function TBaseObject_PEnvir(BaseObject: TBaseObject): PTEnvirnoment; stdcall;
function TBaseObject_boGhost(BaseObject: TBaseObject): PBoolean; stdcall;
function TBaseObject_boDeath(BaseObject: TBaseObject): PBoolean; stdcall;
function TBaseObject_boHero(BaseObject: TBaseObject): Boolean; stdcall;

function TBaseObject_DeleteBagItem(BaseObject: TBaseObject; UserItem:
  _LPTUSERITEM): BOOL; stdcall;
function TBaseObject_AddCustomData(BaseObject: TBaseObject; Data: Pointer):
  Integer; stdcall;
function TBaseObject_GetCustomData(BaseObject: TBaseObject; nIndex: Integer):
  Pointer; stdcall;

procedure TBaseObject_SendMsg(SelfObject, BaseObject: TBaseObject; wIdent,
  wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: PChar); stdcall;
procedure TBaseObject_SendRefMsg(BaseObject: TBaseObject; wIdent, wParam: Word;
  nParam1, nParam2, nParam3: Integer; pszMsg: PChar); stdcall;

procedure TBaseObject_SysMsg(BaseObject: TBaseObject; pszMsg: PChar; MsgColor:
  TMsgColor; MsgType: TMsgType); stdcall;
function TBaseObject_GetFrontPosition(BaseObject: TBaseObject; var nX: Integer;
  var nY: Integer): Boolean; stdcall;
function TBaseObject_GetRecallXY(BaseObject: TBaseObject; nX, nY: Integer;
  nRange: Integer; var nDX: Integer; var nDY: Integer): Boolean; stdcall;
procedure TBaseObject_SpaceMove(BaseObject: TBaseObject; pszMap: PChar; nX, nY:
  Integer; nInt: Integer); stdcall;
procedure TBaseObject_FeatureChanged(BaseObject: TBaseObject); stdcall;
procedure TBaseObject_StatusChanged(BaseObject: TBaseObject); stdcall;
function TBaseObject_GetFeatureToLong(BaseObject: TBaseObject): Integer;
  stdcall;
function TBaseObject_GetFeature(SelfObject, BaseObject: TBaseObject): Integer;
  stdcall;
function TBaseObject_GetCharColor(SelfObject, BaseObject: TBaseObject): Byte;
  stdcall;
function TBaseObject_GetNamecolor(BaseObject: TBaseObject): Byte; stdcall;
procedure TBaseObject_GoldChanged(BaseObject: TBaseObject); stdcall;
procedure TBaseObject_GameGoldChanged(BaseObject: TBaseObject); stdcall;
function TBaseObject_MagCanHitTarget(BaseObject: TBaseObject; nX, nY: Integer;
  TargeTBaseObject: TBaseObject): Boolean; stdcall;

function TBaseObject_IsProtectTarget(AObject, BObject: TBaseObject): Boolean;
  stdcall;
function TBaseObject_IsAttackTarget(AObject, BObject: TBaseObject): Boolean;
  stdcall;
function TBaseObject_IsProperTarget(AObject, BObject: TBaseObject): Boolean;
  stdcall;
function TBaseObject_IsProperFriend(AObject, BObject: TBaseObject): Boolean;
  stdcall;
procedure TBaseObject_TrainSkillPoint(BaseObject: TBaseObject; UserMagic:
  pTUserMagic; nTranPoint: Integer); stdcall;
function TBaseObject_GetAttackPower(BaseObject: TBaseObject; nBasePower, nPower:
  Integer): Integer; stdcall;
function TBaseObject_MakeSlave(BaseObject: TBaseObject; pszMonName: PChar;
  nMakeLevel, nExpLevel, nMaxMob, nType: Integer; dwRoyaltySec: LongWord):
  TBaseObject; stdcall;
procedure TBaseObject_MakeGhost(BaseObject: TBaseObject); stdcall;
procedure TBaseObject_RefNameColor(BaseObject: TBaseObject); stdcall;
//AddItem 占用内存由自己处理，API内部会自动申请内存
function TBaseObject_AddItemToBag(BaseObject: TBaseObject; AddItem: PTUSERITEM):
  BOOL; stdcall;
function TBaseObject_AddItemToStorage(BaseObject: TBaseObject; AddItem:
  PTUSERITEM): BOOL; stdcall;
procedure TBaseObject_ClearBagItem(BaseObject: TBaseObject); stdcall;
procedure TBaseObject_ClearStorageItem(BaseObject: TBaseObject); stdcall;

procedure TBaseObject_SetHookGetFeature(ObjectActionFeature:
  _TOBJECTACTIONFEATURE); stdcall;
procedure TBaseObject_SetHookEnterAnotherMap(EnterAnotherMap:
  _TOBJECTACTIONENTERMAP); stdcall;
procedure TBaseObject_SetHookObjectDie(ObjectDie: _TOBJECTACTIONEX); stdcall;
procedure TBaseObject_SetHookChangeCurrMap(ChangeCurrMap: _TOBJECTACTIONEX);
  stdcall;

implementation

procedure TBaseObject_SetHookChangeCurrMap(ChangeCurrMap: _TOBJECTACTIONEX);
  stdcall;
begin
  try
    m_HookChangeCurrMap := @ChangeCurrMap;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_SetHookChangeCurrMap');
  end;
end;

procedure TBaseObject_SetHookObjectDie(ObjectDie: _TOBJECTACTIONEX); stdcall;
begin
  try
    m_HookObjectDie := ObjectDie;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_SetHookObjectDie');
  end;
end;

procedure TBaseObject_SetHookEnterAnotherMap(EnterAnotherMap:
  _TOBJECTACTIONENTERMAP); stdcall;
begin
  try
    m_HookEnterAnotherMap := EnterAnotherMap;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_SetHookEnterAnotherMap');
  end;
end;

procedure TBaseObject_SetHookGetFeature(ObjectActionFeature:
  _TOBJECTACTIONFEATURE); stdcall;
begin
  try
    m_HookGetFeature := ObjectActionFeature;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_SetHookGetFeature');
  end;
end;

procedure TBaseObject_ClearStorageItem(BaseObject: TBaseObject); stdcall;
begin
  try
    BaseObject.ClearStorageItem;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_ClearStorageItem');
  end;
end;

procedure TBaseObject_ClearBagItem(BaseObject: TBaseObject); stdcall;
begin
  try
    BaseObject.ClearBagItem;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_ClearBagItem');
  end;
end;

function TBaseObject_AddItemToStorage(BaseObject: TBaseObject; AddItem:
  PTUSERITEM): BOOL; stdcall;
var
  UserItem: PTUserItem;
begin
  try
    New(UserItem);
    UserItem^ := AddItem^;
    Result := BaseObject.IsStorage;
    if Result then
      BaseObject.m_StorageItemList.Add(UserItem)
    else
      Dispose(UserItem);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_AddItemToStorage');
  end;
end;

function TBaseObject_AddItemToBag(BaseObject: TBaseObject; AddItem: PTUSERITEM):
  BOOL; stdcall;
var
  UserItem: PTUserItem;
begin
  try
    New(UserItem);
    UserItem^ := AddItem^;
    Result := BaseObject.AddItemToBag(UserItem);
    if not Result then
      Dispose(UserItem);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_AddItemToBag');
  end;
end;

procedure TBaseObject_RefNameColor(BaseObject: TBaseObject); stdcall;
begin
  try
    BaseObject.RefNameColor;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_RefNameColor');
  end;
end;

procedure TBaseObject_MakeGhost(BaseObject: TBaseObject); stdcall;
begin
  try
    BaseObject.MakeGhost;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_MakeGhost');
  end;
end;

function TBaseObject_MakeSlave(BaseObject: TBaseObject; pszMonName: PChar;
  nMakeLevel, nExpLevel, nMaxMob, nType: Integer; dwRoyaltySec: LongWord):
  TBaseObject; stdcall;
begin
  try
    Result := BaseObject.MakeSlave(pszMonName, nMakeLevel, nExpLevel, nMaxMob,
      dwRoyaltySec);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_MakeSlave');
  end;
end;

function TBaseObject_GetAttackPower(BaseObject: TBaseObject; nBasePower, nPower:
  Integer): Integer; stdcall;
begin
  try
    Result := BaseObject.GetAttackPower(nBasePower, nPower);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_GetAttackPower');
  end;
end;

procedure TBaseObject_TrainSkillPoint(BaseObject: TBaseObject; UserMagic:
  pTUserMagic; nTranPoint: Integer); stdcall;
begin
  try
    BaseObject.TrainSkill(UserMagic, nTranPoint);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_TrainSkillPoint');
  end;
end;

function TBaseObject_IsProperFriend(AObject, BObject: TBaseObject): Boolean;
  stdcall;
begin
  try
    Result := AObject.IsProperFriend(BObject);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_IsProperFriend');
  end;
end;

function TBaseObject_IsProperTarget(AObject, BObject: TBaseObject): Boolean;
  stdcall;
begin
  try
    Result := AObject.IsProperTarget(BObject);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_IsProperTarget');
  end;
end;

function TBaseObject_IsAttackTarget(AObject, BObject: TBaseObject): Boolean;
  stdcall;
begin
  try
    Result := AObject.IsAttackTarget(BObject);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_IsAttackTarget');
  end;
end;

function TBaseObject_IsProtectTarget(AObject, BObject: TBaseObject): Boolean;
  stdcall;
begin
  try
    Result := AObject.IsProtectTarget(BObject);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_IsProtectTarget');
  end;
end;

function TBaseObject_MagCanHitTarget(BaseObject: TBaseObject; nX, nY: Integer;
  TargeTBaseObject: TBaseObject): Boolean; stdcall;
begin
  try
    Result := BaseObject.MagCanHitTarget(nX, nY, TargeTBaseObject);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_MagCanHitTarget');
  end;
end;

procedure TBaseObject_GameGoldChanged(BaseObject: TBaseObject); stdcall;
begin
  try
    BAseObject.GameGoldChanged;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_GameGoldChanged');
  end;
end;

procedure TBaseObject_GoldChanged(BaseObject: TBaseObject); stdcall;
begin
  try
    BaseObject.GoldChanged;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_GoldChanged');
  end;
end;

function TBaseObject_GetNamecolor(BaseObject: TBaseObject): Byte; stdcall;
begin
  try
    Result := BaseObject.m_btNameColor;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_GetNamecolor');
  end;
end;

function TBaseObject_GetCharColor(SelfObject, BaseObject: TBaseObject): Byte;
  stdcall;
begin
  try
    Result := SelfObject.GetCharColor(BaseObject);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_GetCharColor');
  end;
end;

function TBaseObject_GetFeature(SelfObject, BaseObject: TBaseObject): Integer;
  stdcall;
begin
  try
    SelfObject.GetFeature(BaseObject);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_GetFeature');
  end;
end;

function TBaseObject_GetFeatureToLong(BaseObject: TBaseObject): Integer;
  stdcall;
begin
  try
    Result := BaseObject.GetFeatureToLong;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_GetFeatureToLong');
  end;
end;

procedure TBaseObject_StatusChanged(BaseObject: TBaseObject); stdcall;
begin
  try
    BaseObject.StatusChanged;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_StatusChanged');
  end;
end;

procedure TBaseObject_FeatureChanged(BaseObject: TBaseObject); stdcall;
begin
  try
    BaseObject.FeatureChanged;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_FeatureChanged');
  end;
end;

procedure TBaseObject_SpaceMove(BaseObject: TBaseObject; pszMap: PChar; nX, nY:
  Integer; nInt: Integer); stdcall;
begin
  try
    BaseObject.SpaceMove(pszMap, nX, nY, nInt);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_SpaceMove');
  end;
end;

function TBaseObject_GetRecallXY(BaseObject: TBaseObject; nX, nY: Integer;
  nRange: Integer; var nDX: Integer; var nDY: Integer): Boolean; stdcall;
var
  nStX, nStY, nEndX, nEndY, X, Y: integer;
begin
  try
    nDx := nX;
    nDy := nY;
    Result := BaseObject.m_PEnvir.CanWalk(nX, nY, False);
    if not Result then
    begin
      nStx := nX - nRange;
      nSty := nY - nRange;
      nEndX := nX + nRange;
      nEndY := nY + nRange;
      for X := nStX to nEndX do
      begin
        for Y := nStY to nEndY do
        begin
          Result := BaseObject.m_PEnvir.CanWalk(X, Y, False);
          if Result then
          begin
            nDX := X;
            nDY := Y;
            exit;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_GetRecallXY');
  end;
end;

function TBaseObject_GetFrontPosition(BaseObject: TBaseObject; var nX: Integer;
  var nY: Integer): Boolean; stdcall;
begin
  try
    Result := BaseObject.GetFrontPosition(nX, nY);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_GetFrontPosition');
  end;
end;

procedure TBaseObject_SysMsg(BaseObject: TBaseObject; pszMsg: PChar; MsgColor:
  TMsgColor; MsgType: TMsgType); stdcall;
begin
  try
    BaseObject.SysMsg(pszMsg, MsgColor, MsgType);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_SysMsg');
  end;
end;

procedure TBaseObject_SendRefMsg(BaseObject: TBaseObject; wIdent, wParam: Word;
  nParam1, nParam2, nParam3: Integer; pszMsg: PChar); stdcall;
begin
  try
    BaseObject.SendRefMsg(wIdent, wParam, nParam1, nParam2, nParam3, pszMsg);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_SendRefMsg');
  end;
end;

procedure TBaseObject_SendMsg(SelfObject, BaseObject: TBaseObject; wIdent,
  wParam: Word; nParam1, nParam2, nParam3: Integer; pszMsg: PChar); stdcall;
begin
  try
    SelfObject.SendMsg(BaseObject, wIdent, wParam, nParam1, nParam2, nParam3,
      pszMsg);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_SendMsg');
  end;
end;

function TBaseObject_GetCustomData(BaseObject: TBaseObject; nIndex: Integer):
  Pointer; stdcall;
begin
  try
    //Result:=BaseObject.m_CustomDataList.Items[nIndex];
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_GetCustomData');
  end;
end;

function TBaseObject_AddCustomData(BaseObject: TBaseObject; Data: Pointer):
  Integer; stdcall;
begin
  try
    //Result:=BaseObject.m_CustomDataList.Add(Data);
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_AddCustomData');
  end;
end;

function TBaseObject_DeleteBagItem(BaseObject: TBaseObject; UserItem:
  _LPTUSERITEM): BOOL; stdcall;
var
  i: integer;
  UserItem32: pTUserItem;
begin
  try
    Result := False;
    if UserItem <> nil then
    begin
      for I := 0 to BaseObject.m_ItemList.Count - 1 do
      begin
        UserItem32 := BaseObject.m_ItemList.Items[I];
        if UserItem32.MakeIndex = UserItem.nMakeIndex then
        begin
          BaseObject.m_ItemList.Delete(I);
          Dispose(UserItem32);
          Result := True;
          Break;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_DeleteBagItem');
  end;
end;

function TBaseObject_boHero(BaseObject: TBaseObject): Boolean; stdcall;
begin
  try
    Result := BaseObject.m_boHero;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_boHero');
  end;
end;

function TBaseObject_boDeath(BaseObject: TBaseObject): PBoolean; stdcall;
begin
  try
    Result := @BaseObject.m_boDeath;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_boDeath');
  end;
end;

function TBaseObject_boGhost(BaseObject: TBaseObject): PBoolean; stdcall;
begin
  try
    Result := @BaseObject.m_boGhost;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_boGhost');
  end;
end;

function TBaseObject_PEnvir(BaseObject: TBaseObject): PTEnvirnoment; stdcall;
begin
  try
    Result := @BaseObject.m_PEnvir;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_PEnvir');
  end;
end;

function TBaseObject_btMonsterWeapon(BaseObject: TBaseObject): PByte; stdcall;
begin
  try
    Result := @BaseObject.m_btMonsterWeapon;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btMonsterWeapon');
  end;
end;

function TBaseObject_UseItems(BaseObject: TBaseObject): _LPTPLAYUSEITEMS;
  stdcall;
begin
  try
    Result := @BaseObject.m_UseItems;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_UseItems');
  end;
end;

function TBaseObject_MyGuild(BaseObject: TBaseObject): TGuild; stdcall;
begin
  try
    Result := BaseObject.m_MyGuild;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_MyGuild');
  end;
end;

function TBaseObject_MagicList(BaseObject: TBaseObject): TList; stdcall;
begin
  try
    Result := BaseObject.m_MagicList;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_MagicList');
  end;
end;

function TBaseObject_ItemList(BaseObject: TBaseObject): TList; stdcall;
begin
  try
    Result := BaseObject.m_ItemList;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_ItemList');
  end;
end;

function TBaseObject_nLight(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nLight;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nLight');
  end;
end;

function TBaseObject_nNameColor(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_btNameColor;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nNameColor');
  end;
end;

function TBaseObject_btAttatckMode(BaseObject: TBaseObject): PByte; stdcall;
begin
  try
    Result := @BaseObject.m_boNoAttackMode;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btAttatckMode');
  end;
end;

function TBaseObject_Master(BaseObject: TBaseObject): PTBaseObject; stdcall;
begin
  try
    Result := @BaseObject.m_Master2;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_Master');
  end;
end;

function TBaseObject_boAllowDeal(BaseObject: TBaseObject): PBoolean; stdcall;
begin
  try
    Result := @BaseObject.m_boAllowDeal;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_boAllowDeal');
  end;
end;

function TBaseObject_boBanGuildChat(BaseObject: TBaseObject): PBoolean; stdcall;
begin
  try
    Result := @BaseObject.m_boBanGuildChat;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_boBanGuildChat');
  end;
end;

function TBaseObject_boBanShout(BaseObject: TBaseObject): PBoolean; stdcall;
begin
  try
    Result := @BaseObject.m_boBanShout;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_boBanShout');
  end;
end;

function TBaseObject_boHearWhisper(BaseObject: TBaseObject): PBoolean; stdcall;
begin
  try
    Result := @BaseObject.m_boHearWhisper;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_boHearWhisper');
  end;
end;

function TBaseObject_GroupMembersList(BaseObject: TBaseObject): TStringList;
  stdcall;
begin
  try
    Result := BaseObject.m_GroupMembers;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_GroupMembersList');
  end;
end;

function TBaseObject_GroupOwner(BaseObject: TBaseObject): TBaseObject; stdcall;
begin
  try
    Result := BaseObject.m_GroupOwner;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_GroupOwner');
  end;
end;

function TBaseObject_btLifeAttrib(BaseObject: TBaseObject): PByte; stdcall;
begin
  try
    Result := @BaseObject.m_btLifeAttrib;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btLifeAttrib');
  end;
end;

function TBaseObject_ExpHiter(BaseObject: TBaseObject): PTBaseObject; stdcall;
begin
  try
    Result := @BaseObject.m_ExpHitter;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_ExpHiter');
  end;
end;

function TBaseObject_LastHiter(BaseObject: TBaseObject): PTBaseObject; stdcall;
begin
  try
    Result := @BaseObject.m_LastHiter;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_LastHiter');
  end;
end;

function TBaseObject_TargetCret(BaseObject: TBaseObject): PTBaseObject; stdcall;
begin
  try
    Result := @BaseObject.m_TargetCret;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_TargetCret');
  end;
end;

function TBaseObject_nHitSpeed(BaseObject: TBaseObject): PShortInt; stdcall;
begin
  try
    Result := @BaseObject.m_nHitSpeed;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nHitSpeed');
  end;
end;

function TBaseObject_btPermission(BaseObject: TBaseObject): PByte; stdcall;
begin
  try
    Result := @BaseObject.m_btPermission;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btPermission');
  end;
end;

function TBaseObject_btSpeedPoint(BaseObject: TBaseObject): PByte; stdcall;
begin
  try
    Result := @BaseObject.m_btSpeedPoint;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btSpeedPoint');
  end;
end;

function TBaseObject_nGoldMax(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nGoldMax;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nGoldMax');
  end;
end;

function TBaseObject_btGreenPoisoningPoint(BaseObject: TBaseObject): PByte;
  stdcall;
begin
  try
    Result := @BaseObject.m_btGreenPoisoningPoint;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btGreenPoisoningPoint');
  end;
end;

function TBaseObject_nPerSpell(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nPerSpell;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nPerSpell');
  end;
end;

function TBaseObject_nPerHealing(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nPerHealing;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nPerHealing');
  end;
end;

function TBaseObject_nPerHealth(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nPerHealth;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nPerHealth');
  end;
end;

function TBaseObject_nLuck(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nLuck;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nLuck');
  end;
end;

function TBaseObject_nAntiMagic(BaseObject: TBaseObject): PShortInt; stdcall;
begin
  try
    Result := @BaseObject.m_nAntiMagic;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nAntiMagic');
  end;
end;

function TBaseObject_nPoisonRecover(BaseObject: TBaseObject): PShortInt;
  stdcall;
begin
  try
    Result := @BaseObject.m_nPoisonRecover;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nPoisonRecover');
  end;
end;

function TBaseObject_btAntiPoison(BaseObject: TBaseObject): PByte; stdcall;
begin
  try
    Result := @BaseObject.m_btAntiPoison;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btAntiPoison');
  end;
end;

function TBaseObject_nSpellRecover(BaseObject: TBaseObject): PShortInt; stdcall;
begin
  try
    Result := @BaseObject.m_nSpellRecover;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nSpellRecover');
  end;
end;

function TBaseObject_nHealthRecover(BaseObject: TBaseObject): PShortInt;
  stdcall;
begin
  try
    Result := @BaseObject.m_nHealthRecover;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nHealthRecover');
  end;
end;

function TBaseObject_boRecallSuite(BaseObject: TBaseObject): PBoolean; stdcall;
begin
  try
    Result := @BaseObject.m_boRecallSuite;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_boRecallSuite');
  end;
end;

function TBaseObject_nHitDouble(BaseObject: TBaseObject): PShortInt; stdcall;
begin
  try
    Result := @BaseObject.m_nHitDouble;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nHitDouble');
  end;
end;

function TBaseObject_nHitPlus(BaseObject: TBaseObject): PShortInt; stdcall;
begin
  try
    Result := @BaseObject.m_nHitPlus;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nHitPlus');
  end;
end;

function TBaseObject_btHitPoint(BaseObject: TBaseObject): PByte; stdcall;
begin
  try
    Result := @BaseObject.m_btHitPoint;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btHitPoint');
  end;
end;

function TBaseObject_btRaceImg(BaseObject: TBaseObject): PByte; stdcall;
begin
  try
    Result := @BaseObject.m_btRaceImg;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btRaceImg');
  end;
end;

function TBaseObject_btRaceServer(BaseObject: TBaseObject): PByte; stdcall;
begin
  try
    Result := @BaseObject.m_btRaceServer;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btRaceServer');
  end;
end;

function TBaseObject_wAppr(BaseObject: TBaseObject): PWord; stdcall;
begin
  try
    Result := @BaseObject.m_wAppr;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_wAppr');
  end;
end;

function TBaseObject_nViewRange(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nViewRange;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nViewRange');
  end;
end;

function TBaseObject_dwFightExp(BaseObject: TBaseObject): PLongWord; stdcall;
begin
  try
    Result := @BaseObject.m_dwFightExp;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_dwFightExp');
  end;
end;

function TBaseObject_nCharStatusEx(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nCharStatusEx;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nCharStatusEx');
  end;
end;

function TBaseObject_boAllowGroupReCall(BaseObject: TBaseObject): PBoolean;
  stdcall;
begin
  try
    Result := @BaseObject.m_boAllowGroupReCall
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_boAllowGroupReCall');
  end;
end;

function TBaseObject_wGroupRcallTime(BaseObject: TBaseObject): PWord; stdcall;
begin
  try
    Result := @BaseObject.m_wGroupRcallTime;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_wGroupRcallTime');
  end;
end;

function TBaseObject_nBodyLuckLevel(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nBodyLuckLevel
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nBodyLuckLevel');
  end;
end;

function TBaseObject_duBodyLuck(BaseObject: TBaseObject): PDouble; stdcall;
begin
  try
    Result := @BaseObject.m_dBodyLuck;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_duBodyLuck');
  end;
end;

function TBaseObject_boAllowGuildReCall(BaseObject: TBaseObject): PBoolean;
  stdcall;
begin
  try
    Result := @BaseObject.m_boAllowGuildReCall;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_boAllowGuildReCall');
  end;
end;

function TBaseObject_nHungerStatus(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nHungerStatus;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nHungerStatus');
  end;
end;

function TBaseObject_nBonusPoint(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nBonusPoint;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nBonusPoint');
  end;
end;

function TBaseObject_nFightZoneDieCount(BaseObject: TBaseObject): PInteger;
  stdcall;
begin
  try
    Result := @BaseObject.m_nFightZoneDieCount;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nFightZoneDieCount');
  end;
end;

function TBaseObject_boAllowGuild(BaseObject: TBaseObject): PBoolean; stdcall;
begin
  try
    Result := @BaseObject.m_boAllowGuild;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_boAllowGuild');
  end;
end;

function TBaseObject_boAllowGroup(BaseObject: TBaseObject): PBoolean; stdcall;
begin
  try
    Result := @BaseObject.m_boAllowGroup;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_boAllowGroup');
  end;
end;

function TBaseObject_nPkPoint(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nPkPoint;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nPkPoint');
  end;
end;

function TBaseObject_btDressEffType(BaseObject: TBaseObject): PByte; stdcall;
begin
  try
    Result := @BaseObject.m_btDressEffType;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btDressEffType');
  end;
end;

function TBaseObject_btHorseType(BaseObject: TBaseObject): PByte; stdcall;
begin
  try
    Result := @BaseObject.m_btHorseType;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btHorseType');
  end;
end;

function TBaseObject_boOnHorse(BaseObject: TBaseObject): PBoolean; stdcall;
begin
  try
    Result := @BaseObject.m_boOnHorse;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_boOnHorse');
  end;
end;

function TBaseObject_nHomeY(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nHomeY;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nHomeY');
  end;
end;

function TBaseObject_nHomeX(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nHomeX;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nHomeX');
  end;
end;

function TBaseObject_sHomeMap(BaseObject: TBaseObject): _LPTSHORTSTRING;
  stdcall;
begin
  try
    Result := @BaseObject.m_sHomeMap;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_sHomeMap');
  end;
end;

function TBaseObject_nCharStatus(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nCharStatus
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nCharStatus');
  end;
end;

function TBaseObject_WAbility(BaseObject: TBaseObject): _LPTABILITY; stdcall;
begin
  try
    Result := @BaseObject.m_WAbil;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_WAbility');
  end;
end;

function TBaseObject_Ability(BaseObject: TBaseObject): _LPTABILITY; stdcall;
begin
  try
    Result := @BaseObject.m_Abil;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_Ability');
  end;
end;

function TBaseObject_nGold(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nGold;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nGold');
  end;
end;

function TBaseObject_btJob(BaseObject: TBaseObject): PByte; stdcall;
begin
  try
    Result := @BaseObject.m_btJob;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btJob');
  end;
end;

function TBaseObject_btHair(BaseObject: TBaseObject): PByte; stdcall;
begin
  try
    Result := @BaseObject.m_bthair;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btHair');
  end;
end;

function TBaseObject_btGender(BaseObject: TBaseObject): PByte; stdcall;
begin
  try
    Result := @BaseObject.m_btGender;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btGender');
  end;
end;

function TBaseObject_btDirection(BaseObject: TBaseObject): PByte; stdcall;
begin
  try
    Result := @BaseObject.m_btDirection;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_btDirection');
  end;
end;

function TBaseObject_nCurrY(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nCurrY;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nCurrY');
  end;
end;

function TBaseObject_nCurrX(BaseObject: TBaseObject): PInteger; stdcall;
begin
  try
    Result := @BaseObject.m_nCurrX;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_nCurrX');
  end;
end;

function TBaseObject_Create(): TBaseObject; stdcall;
begin
  try
    Result := TBaseObject.Create;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_Create');
  end;
end;

procedure TBaseObject_Free(BaseObject: TBaseObject); stdcall;
begin
  try
    BaseObject.Free;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_Free');
  end;
end;

function TBaseObject_sMapFileName(BaseObject: TBaseObject): _LPTSHORTSTRING;
  stdcall;
begin
  try
    Result := @BaseObject.m_PEnvir.sMapFile;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_sMapFileName');
  end;
end;

function TBaseObject_sMapName(BaseObject: TBaseObject): _LPTSHORTSTRING;
  stdcall;
begin
  try
    Result := @BaseObject.m_sMapName;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_sMapName');
  end;
end;

function TBaseObject_sMapNameA(BaseObject: TBaseObject): _LPTMAPNAME; stdcall;
begin
  try
    Result := @BaseObject.m_sMapName;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_sMapNameA');
  end;
end;

function TBaseObject_sCharName(BaseObject: TBaseObject): _LPTSHORTSTRING;
  stdcall;
begin
  try
    Result := @BaseObject.m_sCharName;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_sCharName');
  end;
end;

function TBaseObject_sCharNameA(BaseObject: TBaseObject): _LPTACTORNAME;
  stdcall;
begin
  try
    Result := @BaseObject.m_sCharName;
  except
    MainOutMessage('[Exception] UnTBaseObjectApi.TBaseObject_sCharNameA');
  end;
end;
end.

