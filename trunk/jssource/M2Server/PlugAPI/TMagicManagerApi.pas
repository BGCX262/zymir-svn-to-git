//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit TMagicManagerApi;

interface
uses Windows, M2Share, EngineType, SysUtils, ObjBase, grobal2, Magic;

function TMagicManager_GetMagicManager(): TMagicManager; stdcall;
function TMagicManager_DoSpell(MagicManager: TMagicManager; PlayObject:
  TPlayObject; UserMagic: PTUSERMAGIC; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean; stdcall;

function TMagicManager_MPow(UserMagic: PTUSERMAGIC): Integer; stdcall;
function TMagicManager_GetPower(nPower: Integer; UserMagic: PTUSERMAGIC):
  Integer; stdcall;
function TMagicManager_GetPower13(nInt: Integer; UserMagic: PTUSERMAGIC):
  Integer; stdcall;
function TMagicManager_GetRPow(wInt: Integer): Word; stdcall;
function TMagicManager_IsWarrSkill(MagicManager: TMagicManager; wMagIdx:
  Integer): Boolean; stdcall;

function TMagicManager_MagBigHealing(MagicManager: TMagicManager; PlayObject:
  TBaseObject; nPower, nX, nY: integer): Boolean; stdcall;
function TMagicManager_MagPushArround(MagicManager: TMagicManager; PlayObject:
  TBaseObject; nPushLevel: integer): integer; stdcall;
function TMagicManager_MagPushArroundTaos(MagicManager: TMagicManager;
  PlayObject: TBaseObject; nPushLevel: integer): integer; stdcall;
function TMagicManager_MagTurnUndead(MagicManager: TMagicManager; BaseObject,
  TargeTBaseObject: TBaseObject; nTargetX, nTargetY: Integer; nLevel: Integer):
  Boolean; stdcall;
function TMagicManager_MagMakeHolyCurtain(MagicManager: TMagicManager;
  BaseObject: TBaseObject; nPower: Integer; nX, nY: Integer): Integer; stdcall;
function TMagicManager_MagMakeGroupTransparent(MagicManager: TMagicManager;
  BaseObject: TBaseObject; nX, nY: Integer; nHTime: Integer): Boolean; stdcall;
function TMagicManager_MagTamming(MagicManager: TMagicManager; BaseObject,
  TargeTBaseObject: TBaseObject; nTargetX, nTargetY: Integer; nMagicLevel:
  Integer): Boolean; stdcall;
function TMagicManager_MagSaceMove(MagicManager: TMagicManager; BaseObject:
  TBaseObject; nLevel: integer): Boolean; stdcall;
function TMagicManager_MagMakeFireCross(MagicManager: TMagicManager; PlayObject:
  TPlayObject; nDamage, nHTime, nX, nY: Integer): Integer; stdcall;
function TMagicManager_MagBigExplosion(MagicManager: TMagicManager; BaseObject:
  TBaseObject; nPower, nX, nY: Integer; nRage: Integer): Boolean; stdcall;
function TMagicManager_MagElecBlizzard(MagicManager: TMagicManager; BaseObject:
  TBaseObject; nPower: integer): Boolean; stdcall;
function TMagicManager_MabMabe(MagicManager: TMagicManager; BaseObject,
  TargeTBaseObject: TBaseObject; nPower, nLevel, nTargetX, nTargetY: Integer):
  Boolean; stdcall;
function TMagicManager_MagMakeSlave(MagicManager: TMagicManager; PlayObject:
  TPlayObject; UserMagic: PTUSERMAGIC): Boolean; stdcall;
function TMagicManager_MagMakeSinSuSlave(MagicManager: TMagicManager;
  PlayObject: TPlayObject; UserMagic: PTUSERMAGIC): Boolean; stdcall;
function TMagicManager_MagWindTebo(MagicManager: TMagicManager; PlayObject:
  TPlayObject; UserMagic: PTUSERMAGIC): Boolean; stdcall;
function TMagicManager_MagGroupLightening(MagicManager: TMagicManager;
  PlayObject: TPlayObject; UserMagic: PTUSERMAGIC; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject; var boSpellFire: Boolean): Boolean; stdcall;
function TMagicManager_MagGroupAmyounsul(MagicManager: TMagicManager;
  PlayObject: TPlayObject; UserMagic: PTUSERMAGIC; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean; stdcall;
function TMagicManager_MagGroupDeDing(MagicManager: TMagicManager; PlayObject:
  TPlayObject; UserMagic: PTUSERMAGIC; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean; stdcall;
function TMagicManager_MagGroupMb(MagicManager: TMagicManager; PlayObject:
  TPlayObject; UserMagic: PTUSERMAGIC; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean; stdcall;
function TMagicManager_MagHbFireBall(MagicManager: TMagicManager; PlayObject:
  TPlayObject; UserMagic: PTUSERMAGIC; nTargetX, nTargetY: Integer; var
  TargeTBaseObject: TBaseObject): Boolean; stdcall;
function TMagicManager_MagLightening(MagicManager: TMagicManager; PlayObject:
  TPlayObject; UserMagic: PTUSERMAGIC; nTargetX, nTargetY: Integer; var
  TargeTBaseObject: TBaseObject): Boolean; stdcall;
procedure TMagicManager_SetHookDoSpell(doSpell: _TDOSPELL); stdcall;
implementation

procedure TMagicManager_SetHookDoSpell(doSpell: _TDOSPELL); stdcall;
begin
  try
    m_HookDoSpell := @doSpell;
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_SetHookDoSpell');
  end;
end;

function TMagicManager_MagLightening(MagicManager: TMagicManager; PlayObject:
  TPlayObject; UserMagic: PTUSERMAGIC; nTargetX, nTargetY: Integer; var
  TargeTBaseObject: TBaseObject): Boolean; stdcall;
begin
  try
    Result := True;
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagLightening');
  end;
end;

function TMagicManager_MagHbFireBall(MagicManager: TMagicManager; PlayObject:
  TPlayObject; UserMagic: PTUSERMAGIC; nTargetX, nTargetY: Integer; var
  TargeTBaseObject: TBaseObject): Boolean; stdcall;
begin
  try
    Result := MagicManager.MagHbFireBall(PlayObject, UserMagic, nTargetX,
      nTargetY, TargeTBaseObject);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagHbFireBall');
  end;
end;

function TMagicManager_MagGroupMb(MagicManager: TMagicManager; PlayObject:
  TPlayObject; UserMagic: PTUSERMAGIC; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean; stdcall;
begin
  try
    Result := MagicManager.MagGroupMb(PlayObject, UserMagic, nTargetX, nTargetY,
      TargetBaseObject);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagGroupMb');
  end;
end;

function TMagicManager_MagGroupDeDing(MagicManager: TMagicManager; PlayObject:
  TPlayObject; UserMagic: PTUSERMAGIC; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean; stdcall;
begin
  try
    Result := MagicManager.MagGroupDeDing(PlayObject, UserMagic, nTargetX,
      nTargetY, TargeTBaseObject);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagGroupDeDing');
  end;
end;

function TMagicManager_MagGroupAmyounsul(MagicManager: TMagicManager;
  PlayObject: TPlayObject; UserMagic: PTUSERMAGIC; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean; stdcall;
begin
  try
    Result := MagicManager.MagGroupAmyounsul(PlayObject, UserMagic, nTargetX,
      nTargetY, TargetBaseObject);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagGroupAmyounsul');
  end;
end;

function TMagicManager_MagGroupLightening(MagicManager: TMagicManager;
  PlayObject: TPlayObject; UserMagic: PTUSERMAGIC; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject; var boSpellFire: Boolean): Boolean; stdcall;
begin
  try
    Result := MagicManager.MagGroupLightening(PlayObject, UserMagic, nTargetX,
      nTargetY, TargeTBaseObject, boSpellFire);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagGroupLightening');
  end;
end;

function TMagicManager_MagWindTebo(MagicManager: TMagicManager; PlayObject:
  TPlayObject; UserMagic: PTUSERMAGIC): Boolean; stdcall;
begin
  try
    Result := MagicManager.MagWindTebo(PlayObject, UserMagic);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagWindTebo');
  end;
end;

function TMagicManager_MagMakeSinSuSlave(MagicManager: TMagicManager;
  PlayObject: TPlayObject; UserMagic: PTUSERMAGIC): Boolean; stdcall;
begin
  try
    Result := MagicManager.MagMakeSinSuSlave(PlayObject, UserMagic);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagMakeSinSuSlave');
  end;
end;

function TMagicManager_MagMakeSlave(MagicManager: TMagicManager; PlayObject:
  TPlayObject; UserMagic: PTUSERMAGIC): Boolean; stdcall;
begin
  try
    Result := MagicManager.MagMakeSlave(PlayObject, UserMagic);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagMakeSlave');
  end;
end;

function TMagicManager_MabMabe(MagicManager: TMagicManager; BaseObject,
  TargeTBaseObject: TBaseObject; nPower, nLevel, nTargetX, nTargetY: Integer):
  Boolean; stdcall;
begin
  try
    Result := MagicManager.MabMabe(BaseObject, TargeTBaseObject, nPower, nLevel,
      nTargetX, nTargetY);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MabMabe');
  end;
end;

function TMagicManager_MagElecBlizzard(MagicManager: TMagicManager; BaseObject:
  TBaseObject; nPower: integer): Boolean; stdcall;
begin
  try
    Result := MagicManager.MagElecBlizzard(BaseObject, nPower);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagElecBlizzard');
  end;
end;

function TMagicManager_MagBigExplosion(MagicManager: TMagicManager; BaseObject:
  TBaseObject; nPower, nX, nY: Integer; nRage: Integer): Boolean; stdcall;
begin
  try
    Result := MagicManager.MagBigExplosion(BaseObject, nPower, nX, nY, nRage);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagBigExplosion');
  end;
end;

function TMagicManager_MagMakeFireCross(MagicManager: TMagicManager; PlayObject:
  TPlayObject; nDamage, nHTime, nX, nY: Integer): Integer; stdcall;
begin
  try
    Result := MagicManager.MagMakeFireCross(PlayObject, nDamage, nHTime, nX,
      nY);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagMakeFireCross');
  end;
end;

function TMagicManager_MagSaceMove(MagicManager: TMagicManager; BaseObject:
  TBaseObject; nLevel: integer): Boolean; stdcall;
begin
  try
    Result := MagicManager.MagSaceMove(BaseObject, nLevel);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagSaceMove');
  end;
end;

function TMagicManager_MagTamming(MagicManager: TMagicManager; BaseObject,
  TargeTBaseObject: TBaseObject; nTargetX, nTargetY: Integer; nMagicLevel:
  Integer): Boolean; stdcall;
begin
  try
    Result := MagicManager.MagTamming(BaseObject, TargeTBaseObject, nTargetX,
      nTargetY, nMagicLevel);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagTamming');
  end;
end;

function TMagicManager_MagMakeGroupTransparent(MagicManager: TMagicManager;
  BaseObject: TBaseObject; nX, nY: Integer; nHTime: Integer): Boolean; stdcall;
begin
  try
    Result := MagicManager.MagMakeGroupTransparent(BaseObject, nX, nY, nHTime);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagMakeGroupTransparent');
  end;
end;

function TMagicManager_MagMakeHolyCurtain(MagicManager: TMagicManager;
  BaseObject: TBaseObject; nPower: Integer; nX, nY: Integer): Integer; stdcall;
begin
  try
    Result := MagicManager.MagMakeHolyCurtain(BaseObject, nPower, nX, nY);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagMakeHolyCurtain');
  end;
end;

function TMagicManager_MagTurnUndead(MagicManager: TMagicManager; BaseObject,
  TargeTBaseObject: TBaseObject; nTargetX, nTargetY: Integer; nLevel: Integer):
  Boolean; stdcall;
begin
  try
    Result := MagicManager.MagTurnUndead(BaseObject, TargeTBaseObject, nTargetX,
      nTargetY, nLevel);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagTurnUndead');
  end;
end;

function TMagicManager_MagPushArroundTaos(MagicManager: TMagicManager;
  PlayObject: TBaseObject; nPushLevel: integer): integer; stdcall;
begin
  try
    Result := MagicManager.MagPushArround(PlayObject, nPushLevel);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagPushArroundTaos');
  end;
end;

function TMagicManager_MagPushArround(MagicManager: TMagicManager; PlayObject:
  TBaseObject; nPushLevel: integer): integer; stdcall;
begin
  try
    Result := MagicManager.MagPushArround(PlayObject, nPushLevel);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagPushArround');
  end;
end;

function TMagicManager_MagBigHealing(MagicManager: TMagicManager; PlayObject:
  TBaseObject; nPower, nX, nY: integer): Boolean; stdcall;
begin
  try
    Result := MagicManager.MagBigHealing(PlayObject, nPower, nX, nY);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MagBigHealing');
  end;
end;

function TMagicManager_IsWarrSkill(MagicManager: TMagicManager; wMagIdx:
  Integer): Boolean; stdcall;
begin
  try
    Result := MagicManager.IsWarrSkill(wMagIdx);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_IsWarrSkill');
  end;
end;

function TMagicManager_GetRPow(wInt: Integer): Word; stdcall;
begin
  try
    Result := GetRPow(wInt);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_GetRPow');
  end;
end;

function TMagicManager_GetPower13(nInt: Integer; UserMagic: PTUSERMAGIC):
  Integer; stdcall;
begin
  try
    Result := GetPower13(nInt, UserMagic);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_GetPower13');
  end;
end;

function TMagicManager_GetPower(nPower: Integer; UserMagic: PTUSERMAGIC):
  Integer; stdcall;
begin
  try
    Result := GetPower(nPower, UserMagic);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_GetPower');
  end;
end;

function TMagicManager_MPow(UserMagic: PTUSERMAGIC): Integer; stdcall;
begin
  try
    Result := MPow(UserMagic);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_MPow');
  end;
end;

function TMagicManager_GetMagicManager(): TMagicManager; stdcall;
begin
  try
    Result := MagicManager;
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_GetMagicManager');
  end;
end;

function TMagicManager_DoSpell(MagicManager: TMagicManager; PlayObject:
  TPlayObject; UserMagic: PTUSERMAGIC; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean; stdcall;
begin
  try
    Result := MagicManager.DoSpell(PlayObject, UserMagic, nTargetX, nTargetY,
      TargeTBaseObject);
  except
    MainOutMessage('[Exception] UnTMagicManagerApi.TMagicManager_DoSpell');
  end;
end;

end.

