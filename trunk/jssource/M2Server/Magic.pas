//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit Magic;

interface

uses
  Windows, Classes, Grobal2, ObjBase, SDK;
type
  TMagicManager = class
  private
  public
    function MagBigHealing(PlayObject: TBaseObject; nPower, nX, nY: integer):
      Boolean;
    function MagPushArround(PlayObject: TBaseObject; nPushLevel: integer):
      integer;
    function MagTurnUndead(BaseObject, TargeTBaseObject: TBaseObject; nTargetX,
      nTargetY: Integer; nLevel: Integer): Boolean;
    function MagMakeHolyCurtain(BaseObject: TBaseObject; nPower: Integer; nX,
      nY: Integer): Integer;
    function MagMakeGroupTransparent(BaseObject: TBaseObject; nX, nY: Integer;
      nHTime: Integer): Boolean;
    function MagTamming(BaseObject, TargeTBaseObject: TBaseObject; nTargetX,
      nTargetY: Integer; nMagicLevel: Integer): Boolean;
    function MagSaceMove(BaseObject: TBaseObject; nLevel: integer): Boolean;
    function MagMakeFireCross(PlayObject: TBaseObject; nDamage, nHTime, nX, nY:
      Integer): Integer;
    function MagBigExplosion(BaseObject: TBaseObject; nPower, nX, nY: Integer;
      nRage: Integer): Boolean;
    function MagBigExplosionEx(BaseObject: TBaseObject; nPower, nX, nY: Integer;
      nRage: Integer): Boolean;
    function MagElecBlizzard(BaseObject: TBaseObject; nPower: integer): Boolean;
    function MabMabe(BaseObject, TargeTBaseObject: TBaseObject; nPower, nLevel,
      nTargetX, nTargetY: Integer): Boolean;
    function MagMakeSlave(PlayObject: TBaseObject; UserMagic: pTUserMagic):
      Boolean;
    function MagMakeClone(PlayObject: TBaseObject; UserMagic: pTUserMagic):
      Boolean;
    function MagMakeSinSuSlave(PlayObject: TBaseObject; UserMagic: pTUserMagic):
      Boolean;
    function MagMakeAngelSlave(PlayObject: TBaseObject; UserMagic: pTUserMagic):
      Boolean;
    function MagWindTebo(PlayObject: TBaseObject; UserMagic: pTUserMagic):
      Boolean;
    function MagGroupLightening(PlayObject: TBaseObject; UserMagic: pTUserMagic;
      nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject; var boSpellFire:
      Boolean): Boolean;
    function MagGroupAmyounsul(PlayObject: TBaseObject; UserMagic: pTUserMagic;
      nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagGroupAmyounsul2(PlayObject: TBaseObject; MasterObject:
      TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
      TargeTBaseObject: TBaseObject): Boolean;
    function MagGroupDeDing(PlayObject: TBaseObject; UserMagic: pTUserMagic;
      nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagGroupMb(PlayObject: TBaseObject; UserMagic: pTUserMagic;
      nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;

    function MagHbFireBall(PlayObject: TBaseObject; UserMagic: pTUserMagic;
      nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;

    function KnockBack(PlayObject: TBaseObject; nPushLevel: integer): integer;
    function FlameField(BaseObject: TBaseObject; nPower, nX, nY: Integer; nRage:
      Integer): Boolean;
    function CheckBeeline(nX, nY, sX, sY: Integer): Boolean;
    function SkillWW(PlayObject: TBaseObject; UserMagic: pTUserMagic;
      TargeTBaseObject: TBaseObject): Boolean;
    function SkillTW(PlayObject: TBaseObject; UserMagic: pTUserMagic;
      TargeTBaseObject: TBaseObject): Boolean;
    function SkillZW(PlayObject: TBaseObject; UserMagic: pTUserMagic;
      TargeTBaseObject: TBaseObject): Boolean;
    function SkillTT(PlayObject: TBaseObject; UserMagic: pTUserMagic;
      TargeTBaseObject: TBaseObject): Boolean;
    function SkillZT(PlayObject: TBaseObject; UserMagic: pTUserMagic;
      TargeTBaseObject: TBaseObject): Boolean;
    function SkillZZ(PlayObject: TBaseObject; UserMagic: pTUserMagic;
      TargeTBaseObject: TBaseObject): Boolean;

    constructor Create();
    destructor Destroy; override;
    function MagMakePrivateTransparent(BaseObject: TBaseObject; nHTime:
      Integer): Boolean;
    function IsWarrSkill(wMagIdx: Integer): Boolean;
    function DoSpell(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX,
      nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;

  end;
function MPow(UserMagic: pTUserMagic): Integer;
function GetPower(nPower: Integer; UserMagic: pTUserMagic): Integer;
function GetPower13(nInt: Integer; UserMagic: pTUserMagic): Integer;
function GetRPow(wInt: Integer): Word;
function CheckAmulet(PlayObject: TBaseObject; nCount: Integer; nType: Integer;
  var Idx: Integer): Boolean;
procedure UseAmulet(PlayObject: TBaseObject; nCount: Integer; nType: Integer; var
  Idx: Integer);
function GetJointPower(nPower, nDander, nScale: Integer): Integer;

implementation

uses HUtil32, M2Share, Event, Envir, ItmUnit, sysutils, PlugFun, ObjClone;

function MPow(UserMagic: pTUserMagic): Integer;
begin
  try
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower
      - UserMagic.MagicInfo.wPower);
  except
    MainOutMessage('[Exception] UnMagic.MPow');
  end;
end;

function GetPower(nPower: Integer; UserMagic: pTUserMagic): Integer;
begin
  try
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  except
    MainOutMessage('[Exception] UnMagic.GetPower');
  end;
end;

function GetJointPower(nPower, nDander, nScale: Integer): Integer;
begin
  try
    Result := Trunc(nPower * (nScale / 100));
    //Result:=ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  except
    MainOutMessage('[Exception] UnMagic.GetJointPower');
  end;
end;

function GetPower13(nInt: Integer; UserMagic: pTUserMagic): Integer;
var
  d10: Double;
  d18: Double;
begin
  try
    d10 := nInt / 3.0;
    d18 := nInt - d10;
    Result := ROUND(d18 / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower -
      UserMagic.MagicInfo.btDefPower)));
  except
    MainOutMessage('[Exception] UnMagic.GetPower13');
  end;
end;

function GetRPow(wInt: Integer): Word;
begin
  try
    if HiWord(wInt) > LoWord(wInt) then
    begin
      Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
    end
    else
      Result := LoWord(wInt);
  except
    MainOutMessage('[Exception] UnMagic.GetRPow');
  end;
end;
//nType 为指定类型 1 为护身符 2 为毒药

function CheckAmulet(PlayObject: TBaseObject; nCount: Integer; nType: Integer;
  var Idx: Integer): Boolean;
var
  AmuletStdItem: TItem;
  UserItem: pTUserItem;
begin
  try
    Result := False;
    Idx := 0;
    {if PlayObject.m_NotCheckAmulet then begin
      Result:=True;
      Idx:=-1;
      exit;
    end;    }
    //人型怪不减毒符
    if (PlayObject.m_btRaceServer = RC_PLAYCLONE) and
      g_Config.boCloneNotCheckAmulet2 then
    begin
      Idx := -(TPlayCloneObject(PlayObject).m_AmuletIdx);
      Result := True;
      exit;
    end;
    if PlayObject.m_boHero then
    begin //000086
      //    UserItem:=Nil;
      case nType of
        1:
          begin
            if nCount = 1 then
            begin
              UserItem := pTUserItem(PlayObject.m_HeroAmu51Porc);
              if (UserItem <> nil) and (UserItem.wIndex > 0) then
              begin
                AmuletStdItem := UserEngine.GetStdItem(UserItem.wIndex);
                if (AmuletStdItem <> nil) and
                  (AmuletStdItem.StdMode = 25) and
                  (AmuletStdItem.Shape = 5) and
                  (ROUND(UserItem.Dura / 100) >= nCount) then
                begin
                  if (PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0) and
                    (PlayObject.m_UseItems[U_ARMRINGL].MakeIndex =
                      UserItem.MakeIndex) then
                  begin
                    Idx := U_ARMRINGL;
                  end
                  else if (PlayObject.m_UseItems[U_BUJUK].wIndex > 0) and
                    (PlayObject.m_UseItems[U_BUJUK].MakeIndex =
                      UserItem.MakeIndex) then
                  begin
                    Idx := U_BUJUK;
                  end
                  else
                    Idx := 151;
                  Result := True;
                  exit;
                end;
              end;
            end
            else
            begin
              UserItem := pTUserItem(PlayObject.m_HeroAmu55Porc);
              if (UserItem <> nil) and (UserItem.wIndex > 0) then
              begin
                AmuletStdItem := UserEngine.GetStdItem(UserItem.wIndex);
                if (AmuletStdItem <> nil) and
                  (AmuletStdItem.StdMode = 25) and
                  (AmuletStdItem.Shape = 5) and
                  (ROUND(UserItem.Dura / 100) >= nCount) then
                begin
                  if (PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0) and
                    (PlayObject.m_UseItems[U_ARMRINGL].MakeIndex =
                      UserItem.MakeIndex) then
                  begin
                    Idx := U_ARMRINGL;
                  end
                  else if (PlayObject.m_UseItems[U_BUJUK].wIndex > 0) and
                    (PlayObject.m_UseItems[U_BUJUK].MakeIndex =
                      UserItem.MakeIndex) then
                  begin
                    Idx := U_BUJUK;
                  end
                  else
                    Idx := 155;
                  Result := True;
                  exit;
                end;
              end;
            end;
          end;
        2:
          begin
            UserItem := pTUserItem(PlayObject.m_HeroAttackAmuPorc);
            if (UserItem <> nil) and (UserItem.wIndex > 0) then
            begin
              AmuletStdItem := UserEngine.GetStdItem(UserItem.wIndex);
              if (AmuletStdItem <> nil) and
                (AmuletStdItem.StdMode = 25) and
                (AmuletStdItem.Shape < 3) and
                (ROUND(UserItem.Dura / 100) >= nCount) then
              begin
                if (PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0) and
                  (PlayObject.m_UseItems[U_ARMRINGL].MakeIndex =
                    UserItem.MakeIndex) then
                begin
                  Idx := U_ARMRINGL;
                end
                else if (PlayObject.m_UseItems[U_BUJUK].wIndex > 0) and
                  (PlayObject.m_UseItems[U_BUJUK].MakeIndex = UserItem.MakeIndex)
                    then
                begin
                  Idx := U_BUJUK;
                end
                else
                  Idx := 200;
                Result := True;
                exit;
              end;
            end;
          end;
      end;
    end
    else
    begin //000086
      if PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0 then
      begin
        AmuletStdItem :=
          UserEngine.GetStdItem(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
        if (AmuletStdItem <> nil) and (AmuletStdItem.StdMode = 25) then
        begin
          case nType of
            1:
              begin
                if (AmuletStdItem.Shape = 5) and
                  (ROUND(PlayObject.m_UseItems[U_ARMRINGL].Dura / 100) >= nCount)
                  then
                begin
                  Idx := U_ARMRINGL;
                  Result := True;
                  exit;
                end;
              end;
            2:
              begin
                if (AmuletStdItem.Shape <= 2) and
                  (ROUND(PlayObject.m_UseItems[U_ARMRINGL].Dura / 100) >= nCount)
                  then
                begin
                  Idx := U_ARMRINGL;
                  Result := True;
                  exit;
                end;
              end;
          end;
        end;
      end;

      if PlayObject.m_UseItems[U_BUJUK].wIndex > 0 then
      begin
        AmuletStdItem :=
          UserEngine.GetStdItem(PlayObject.m_UseItems[U_BUJUK].wIndex);
        if (AmuletStdItem <> nil) and (AmuletStdItem.StdMode = 25) then
        begin
          case nType of //
            1:
              begin
                if (AmuletStdItem.Shape = 5) and
                  (ROUND(PlayObject.m_UseItems[U_BUJUK].Dura / 100) >= nCount)
                  then
                begin
                  Idx := U_BUJUK;
                  Result := True;
                  exit;
                end;
              end;
            2:
              begin
                if (AmuletStdItem.Shape <= 2) and
                  (ROUND(PlayObject.m_UseItems[U_BUJUK].Dura / 100) >= nCount)
                  then
                begin
                  Idx := U_BUJUK;
                  Result := True;
                  exit;
                end;
              end;
          end;
        end;
      end;
    end; //000086
  except
    MainOutMessage('[Exception] UnMagic.CheckAmulet');
  end;
end;
//nType 为指定类型 1 为护身符 2 为毒药

procedure UseAmulet(PlayObject: TBaseObject; nCount: Integer; nType: Integer; var
  Idx: Integer);
resourcestring
  sExceptMsg = '[Exception] UseAmulet nCode=%d';
var
  UserItem: pTUserItem;
  nCheckCode: Integer;
  I: Integer;
  UserItem34: pTUserItem;
begin
  nCheckCode := 0;
  try
    try
      UserItem := nil;
      //if PlayObject.m_NotCheckAmulet then exit;
      if Idx > 100 then
      begin
        nCheckCode := 1;
        case Idx of
          151: UserItem := pTUserItem(PlayObject.m_HeroAmu51Porc);
          155: UserItem := pTUserItem(PlayObject.m_HeroAmu55Porc);
          200: UserItem := pTUserItem(PlayObject.m_HeroAttackAmuPorc);
        end;
        nCheckCode := 2;
        if (UserItem <> nil) then
        begin
          nCheckCode := 3;
          if UserItem.Dura > nCount * 100 then
          begin
            Dec(UserItem.Dura, nCount * 100);
            PlayObject.SendMsg(PlayObject, RM_BAG_DURACHANGE2, UserItem.wIndex,
              UserItem.MakeIndex, UserItem.Dura, UserItem.DuraMax, '');
          end
          else
          begin
            UserItem.Dura := 0;
            if PlayObject.m_btRaceServer = RC_PLAYOBJECT then
              TPlayObject(PlayObject).SendDelItems(UserItem);
                //符毒用完消失
            for I := 0 to PlayObject.m_ItemList.Count - 1 do
            begin
              UserItem34 := PlayObject.m_ItemList.Items[I];
              if (UserItem34 <> nil) and (UserItem34.MakeIndex =
                UserItem.MakeIndex) then
              begin
                PlayObject.m_ItemList.Delete(I);
                Dispose(UserItem34);
                break;
              end;
            end;
          end;
          nCheckCode := 4;
        end;
      end
      else
      begin
        nCheckCode := 5;
        if (PlayObject.m_btRaceServer = RC_PLAYCLONE) and
          g_Config.boCloneNotCheckAmulet2 then
          exit;
        if idx in [0..MAXUSEITEMS] then
        begin
          if PlayObject.m_UseItems[Idx].Dura > nCount * 100 then
          begin
            Dec(PlayObject.m_UseItems[Idx].Dura, nCount * 100);
            PlayObject.SendMsg(PlayObject, RM_DURACHANGE, Idx,
              PlayObject.m_UseItems[Idx].Dura, PlayObject.m_UseItems[Idx].DuraMax,
              0, '');
          end
          else
          begin
            nCheckCode := 6;
            PlayObject.m_UseItems[Idx].Dura := 0;
            if PlayObject.m_btRaceServer = RC_PLAYOBJECT then
              TPlayObject(PlayObject).SendDelItems(@PlayObject.m_UseItems[Idx]);
                //符毒用完消失
            PlayObject.m_UseItems[Idx].wIndex := 0;
          end;
        end;
        nCheckCode := 7;
      end;
    except
      MainOutMessage(Format(sExceptMsg, [nCheckCode]));
    end;
  except
    MainOutMessage('[Exception] UnMagic.UseAmulet');
  end;
end;

function TMagicManager.MagPushArround(PlayObject: TBaseObject; nPushLevel:
  integer): integer; //00492204
var
  i, nDir, levelgap, push: integer;
  BaseObject: TBaseObject;
begin
  try
    Result := 0;
    for i := 0 to PlayObject.m_VisibleActors.Count - 1 do
    begin
      BaseObject :=
        TBaseObject(pTVisibleBaseObject(PlayObject.m_VisibleActors[i]).BaseObject);
      if (abs(PlayObject.m_nCurrX - BaseObject.m_nCurrX) <= 1) and
        (abs(PlayObject.m_nCurrY - BaseObject.m_nCurrY) <= 1) then
      begin
        if (not BaseObject.m_boDeath) and (BaseObject <> PlayObject) then
        begin
          if (PlayObject.m_Abil.Level > BaseObject.m_Abil.Level) and (not
            BaseObject.m_boStickMode) then
          begin
            levelgap := PlayObject.m_Abil.Level - BaseObject.m_Abil.Level;
            if (Random(20) < 6 + nPushLevel * 3 + levelgap) then
            begin
              if PlayObject.IsProperTarget(BaseObject) then
              begin
                push := 1 + _MAX(0, nPushLevel - 1) + Random(2);
                nDir := GetNextDirection(PlayObject.m_nCurrX,
                  PlayObject.m_nCurrY, BaseObject.m_nCurrX, BaseObject.m_nCurrY);
                BaseObject.CharPushed(nDir, push);
                Inc(Result);
              end;
            end;
          end;
        end;
      end;
    end;

  except
    MainOutMessage('[Exception] TMagicManager.MagPushArround');
  end;
end;

function TMagicManager.MagBigHealing(PlayObject: TBaseObject; nPower, nX, nY:
  integer): Boolean; //00492E50
var
  i: integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
begin
  try
    Result := False;
    BaseObjectList := TList.Create;
    PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nX, nY, 1,
      BaseObjectList);
    for i := 0 to BaseObjectList.Count - 1 do
    begin
      BaseObject := TBaseObject(BaseObjectList[i]);
      if PlayObject.IsProperFriend(BaseObject) then
      begin
        if BaseObject.m_WAbil.HP < BaseObject.m_WAbil.MaxHP then
        begin
          BaseObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0,
            '', 800);
          Result := True;
        end;
        if PlayObject.m_boAbilSeeHealGauge then
        begin
          PlayObject.SendMsg(BaseObject, RM_10414, 0, 0, 0, 0, '');
            //?? RM_INSTANCEHEALGUAGE
        end;
      end;
    end;
    BaseObjectList.Free;
  except
    MainOutMessage('[Exception] TMagicManager.MagBigHealing');
  end;
end;

constructor TMagicManager.Create; //0049214C
begin
  try

  except
    MainOutMessage('[Exception] TMagicManager.Create');
  end;
end;

destructor TMagicManager.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TMagicManager.Destroy');
  end;
end;

function TMagicManager.IsWarrSkill(wMagIdx: Integer): Boolean; //492190
begin
  try
    Result := False;
    if wMagIdx in [SKILL_ONESWORD {3}, SKILL_ILKWANG {4}, SKILL_YEDO {7},
      SKILL_ERGUM {12}, SKILL_BANWOL {25}, SKILL_FIRESWORD {26}, SKILL_MOOTEBO
      {27}, SKILL_CROSSMOON, SKILL_TWINBLADE, SKILL_43, SKILL_73] then
      Result := True;
  except
    MainOutMessage('[Exception] TMagicManager.IsWarrSkill');
  end;
end;

function TMagicManager.DoSpell(PlayObject: TBaseObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean; //0049350C
var
  boTrain: Boolean;
  boSpellFail: Boolean;
  boSpellFire: Boolean;
  //  n15,n16,n17 :Integer;
  n14 {,nX,nY}: Integer;
  n18: Integer;
  n1C: Integer;
  //  n2C         :Integer;
  nPower: Integer;
  StdItem: TItem;
  nAmuletIdx: Integer;
  //  n199        :Integer;
  //  nHookStatus :Integer;
  //  I           :Integer;

  function MPow(UserMagic: pTUserMagic): Integer; //004921C8
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower
      - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer; //00493314
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
  function GetPower13(nInt: Integer): Integer; //0049338C
  var
    d10: Double;
    d18: Double;
  begin
    d10 := nInt / 3.0;
    d18 := nInt - d10;
    Result := ROUND(d18 / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower -
      UserMagic.MagicInfo.btDefPower)));
  end;
  function GetRPow(wInt: Integer): Word;
  begin
    if HiWord(wInt) > LoWord(wInt) then
    begin
      Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
    end
    else
      Result := LoWord(wInt);
  end;
  procedure sub_4934B4(PlayObject: TBaseObject);
  begin
    if PlayObject.m_UseItems[U_ARMRINGL].Dura < 100 then
    begin
      PlayObject.m_UseItems[U_ARMRINGL].Dura := 0;
      if PlayObject.m_btRaceServer = RC_PLAYOBJECT then
        TPlayObject(PlayObject).SendDelItems(@PlayObject.m_UseItems[U_ARMRINGL]);
      PlayObject.m_UseItems[U_ARMRINGL].wIndex := 0;
    end;
  end;

begin //0049350C
  Result := False;
  if IsWarrSkill(UserMagic.wMagIdx) then
    exit;

  if (abs(PlayObject.m_nCurrX - nTargetX) > g_Config.nMagicAttackRage) or
    (abs(PlayObject.m_nCurrY - nTargetY) > g_Config.nMagicAttackRage) then
  begin
    exit;
  end;

  if not (UserMagic.wMagIdx in [60..65]) then
    PlayObject.SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX,
      nTargetY, UserMagic.MagicInfo.wMagicId, '');
  if (TargeTBaseObject <> nil) and (TargeTBaseObject.m_boDeath) then
    TargeTBaseObject := nil;
  boTrain := False;
  boSpellFail := False;
  boSpellFire := True;
  //  nPower:=0;
  if (PlayObject.m_nSoftVersionDateEx = 0) and (PlayObject.m_dwClientTick = 0)
    {and (UserMagic.MagicInfo.wMagicId > 400)} then
    exit;

  case UserMagic.MagicInfo.wMagicId of //
    SKILL_FIREBALL {1},
    SKILL_FIREBALL2 {5}:
      begin //火球术 大火球
        if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY,
          TargeTBaseObject) then
        begin
          if PlayObject.IsProperTarget(TargeTBaseObject) then
          begin
            if (TargeTBaseObject.m_nAntiMagic <= Random(10)) and
              (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and
              (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then
            begin
              with PlayObject do
              begin
                nPower := GetAttackPower(GetPower(MPow(UserMagic)) +
                  LoWord(m_WAbil.MC),
                  SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
                //pwr := GetPower (MPow(UserMagic)) + (Lobyte(WAbil.MC) + Random(Hibyte(WAbil.MC)-Lobyte(WAbil.MC) + 1));
                //鸥百 嘎澜, 饶俊 瓤苞唱鸥巢
                //target.SendDelayMsg (user, RM_MAGSTRUCK, 0, pwr, 0, 0, '', 1200 + _MAX(Abs(CX-xx),Abs(CY-yy)) * 50 );
              end;
              //rm-delaymagic俊辑 selecttarget阑 贸府茄促.
              PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower,
                MakeLong(nTargetX, nTargetY), 2, integer(TargeTBaseObject), '',
                600);
              if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
                boTrain := True;
            end
            else
              TargeTBaseObject := nil;
          end
          else
            TargeTBaseObject := nil;
        end
        else
          TargeTBaseObject := nil;
      end;
    SKILL_HEALLING {2}:
      begin
        if TargeTBaseObject = nil then
        begin
          TargeTBaseObject := PlayObject;
          nTargetX := PlayObject.m_nCurrX;
          nTargetY := PlayObject.m_nCurrY;
        end;
        if PlayObject.IsProperFriend {0FFF3}(TargeTBaseObject) then
        begin
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
            LoWord(PlayObject.m_WAbil.SC) * 2,
            SmallInt(HiWord(PlayObject.m_WAbil.SC) -
              LoWord(PlayObject.m_WAbil.SC)) * 2 + 1);
          if TargeTBaseObject.m_WAbil.HP < TargeTBaseObject.m_WAbil.MaxHP then
          begin
            TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPower,
              0, 0, '', 800);
            boTrain := True;
          end;
          if PlayObject.m_boHero then
          begin
            if PlayObject.m_HeroHuman.m_boAbilSeeHealGauge then
              PlayObject.m_HeroHuman.SendMsg(TargeTBaseObject, RM_10414, 0, 0,
                0, 0, '');
          end
          else
          begin
            if PlayObject.m_boAbilSeeHealGauge then
              PlayObject.SendMsg(TargeTBaseObject, RM_10414, 0, 0, 0, 0, '');
          end;
        end;
      end;
    SKILL_AMYOUNSUL {6}:
      begin //施毒术
        (*
        boSpellFail:=True;

        if PlayObject.IsProperTarget(TargeTBaseObject) then begin
          if PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0 then begin
            StdItem:=UserEngine.GetStdItem(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
            if (StdItem <> nil) and (StdItem.StdMode = 25) and (StdItem.Shape <= 2) then begin
              if PlayObject.m_UseItems[U_ARMRINGL].Dura >= 100 then begin
                Dec(PlayObject.m_UseItems[U_ARMRINGL].Dura,100);
                PlayObject.SendMsg(PlayObject,RM_DURACHANGE,5,PlayObject.m_UseItems[U_ARMRINGL].Dura,PlayObject.m_UseItems[U_ARMRINGL].DuraMax,0,'');
                if Random(TargeTBaseObject.m_btAntiPoison + 7) <= 6 then begin
                  case StdItem.Shape of
                    1: begin //0493F94
                      nPower:=GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                      TargeTBaseObject.SendDelayMsg(PlayObject,RM_POISON,POISON_DECHEALTH{中毒类型 - 绿毒},nPower,Integer(PlayObject),ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)){UserMagic.btLevel},'',1000);
                    end;
                    2: begin //00493FE9
                      nPower:=GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                      TargeTBaseObject.SendDelayMsg(PlayObject,RM_POISON,POISON_DAMAGEARMOR{中毒类型 - 红毒},nPower,Integer(PlayObject),ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)){UserMagic.btLevel},'',1000);
                    end;
                  end; //0049403C
                  if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
                    boTrain:=True;
                end; //00494058
                PlayObject.SetTargetCreat(TargeTBaseObject);
                boSpellFail:=False;
              end; //0049406B
              if PlayObject.m_UseItems[U_ARMRINGL].Dura < 100 then begin
                PlayObject.m_UseItems[U_ARMRINGL].Dura:=0;
                PlayObject.SendDelItems(@PlayObject.m_UseItems[U_ARMRINGL]);
                PlayObject.m_UseItems[U_ARMRINGL].wIndex:=0;
              end;
            end;
          end;
        end;
        *)
        boSpellFail := True;

        if PlayObject.IsProperTarget(TargeTBaseObject) then
        begin

          if CheckAmulet(PlayObject, 1, 2, nAmuletIdx) then
          begin
            if nAmuletIdx < 0 then
            begin
              if Random(TargeTBaseObject.m_btAntiPoison + 7) <= 6 then
              begin
                case nAmuletIdx of
                  -1:
                    begin //0493F94
                      nPower := GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC)
                        * 2;
                      TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON,
                        POISON_DECHEALTH {中毒类型 - 绿毒}, nPower,
                        Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower
                        / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '',
                        1000);
                    end;
                  -2:
                    begin //00493FE9
                      nPower := GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC)
                        * 2;
                      TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON,
                        POISON_DAMAGEARMOR {中毒类型 - 红毒}, nPower,
                        Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower
                        / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '',
                        1000);
                    end;
                end; //0049403C
                if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or
                  (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
                  boTrain := True;
              end; //00494058
              PlayObject.SetTargetCreat(TargeTBaseObject);
              boSpellFail := False;
            end
            else
            begin
              StdItem := nil;
              if nAmuletIdx in [0..High(THumanUseItems)] then
              begin
                StdItem :=
                  UserEngine.GetStdItem(PlayObject.m_UseItems[nAmuletIdx].wIndex);
              end
              else
              begin
                if PlayObject.m_HeroAttackAmuPorc <> nil then
                  StdItem :=
                    UserEngine.GetStdItem(pTUserItem(PlayObject.m_HeroAttackAmuPorc).wIndex);
              end;
              if StdItem <> nil then
              begin
                UseAmulet(PlayObject, 1, 2, nAmuletIdx);
                if Random(TargeTBaseObject.m_btAntiPoison + 7) <= 6 then
                begin
                  case StdItem.Shape of
                    1:
                      begin //0493F94
                        nPower := GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC)
                          * 2;
                        TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON,
                          POISON_DECHEALTH {中毒类型 - 绿毒}, nPower,
                          Integer(PlayObject), ROUND(UserMagic.btLevel / 3 *
                          (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel},
                          '', 1000);
                      end;
                    2:
                      begin //00493FE9
                        nPower := GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC)
                          * 2;
                        TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON,
                          POISON_DAMAGEARMOR {中毒类型 - 红毒}, nPower,
                          Integer(PlayObject), ROUND(UserMagic.btLevel / 3 *
                          (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel},
                          '', 1000);
                      end;
                  end; //0049403C
                  if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or
                    (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
                    boTrain := True;
                end; //00494058
                PlayObject.SetTargetCreat(TargeTBaseObject);
                boSpellFail := False;
              end;
            end;
          end; //0049406B
        end;
      end;
    SKILL_FIREWIND {8}:
      begin //抗拒火环  00493754
        if MagPushArround(PlayObject, UserMagic.btLevel) > 0 then
          boTrain := True;
      end;
    SKILL_FIRE {9}:
      begin //地狱火 00493778
        n1C := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY,
          nTargetX, nTargetY);
        if PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX,
          PlayObject.m_nCurrY, n1C, 1, n14, n18) then
        begin
          PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX,
            PlayObject.m_nCurrY, n1C, 5, nTargetX, nTargetY);
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
            LoWord(PlayObject.m_WAbil.MC),
            SmallInt(HiWord(PlayObject.m_WAbil.MC) -
              LoWord(PlayObject.m_WAbil.MC)) + 1);
          if PlayObject.MagPassThroughMagic(n14, n18, nTargetX, nTargetY, n1C,
            nPower, False) > 0 then
            boTrain := True;
        end;
      end;
    SKILL_SHOOTLIGHTEN {10}:
      begin //疾光电影 0049386A
        n1C := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY,
          nTargetX, nTargetY);
        if PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX,
          PlayObject.m_nCurrY, n1C, 1, n14, n18) then
        begin
          PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX,
            PlayObject.m_nCurrY, n1C, 8, nTargetX, nTargetY);
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
            LoWord(PlayObject.m_WAbil.MC),
            SmallInt(HiWord(PlayObject.m_WAbil.MC) -
              LoWord(PlayObject.m_WAbil.MC)) + 1);
          if PlayObject.MagPassThroughMagic(n14, n18, nTargetX, nTargetY, n1C,
            nPower, True) > 0 then
            boTrain := True;
        end;
      end;
    SKILL_LIGHTENING {11}:
      begin //雷电术 0049395C
        if PlayObject.IsProperTarget(TargeTBaseObject) then
        begin
          if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then
          begin
            nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
              LoWord(PlayObject.m_WAbil.MC),
              SmallInt(HiWord(PlayObject.m_WAbil.MC) -
                LoWord(PlayObject.m_WAbil.MC)) + 1);
            if TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD then
              nPower := ROUND(nPower * 1.5);
            PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower,
              MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '',
              600);
            if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
              boTrain := True;
          end
          else
            TargeTBaseObject := nil
        end
        else
          TargeTBaseObject := nil;
      end;
    SKILL_FIRECHARM {13},
    SKILL_HANGMAJINBUB {14},
    SKILL_DEJIWONHO {15},
    SKILL_HOLYSHIELD {16},
    SKILL_SKELLETON {17},
    SKILL_CLOAK {18},
    SKILL_52 {52},
    SKILL_53,
      SKILL_BIGCLOAK {19}:
      begin //004940BC
        boSpellFail := True;
        if CheckAmulet(PlayObject, 1, 1, nAmuletIdx) then
        begin
          UseAmulet(PlayObject, 1, 1, nAmuletIdx);
          {
          if BaseObject.m_UseItems[U_ARMRINGL].Dura >= 100 then Dec(BaseObject.m_UseItems[U_ARMRINGL].Dura,100)
          else BaseObject.m_UseItems[U_ARMRINGL].Dura:=0;
          BaseObject.SendMsg(BaseObject,RM_DURACHANGE,U_ARMRINGL,BaseObject.m_UseItems[U_ARMRINGL].Dura,BaseObject.m_UseItems[U_ARMRINGL].DuraMax,0,'');
          }
          case UserMagic.MagicInfo.wMagicId of //
            SKILL_53:
              begin //噬血术
                if TargeTBaseObject <> nil then
                 // if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX,PlayObject.m_nCurrY, TargeTBaseObject) then
                  begin
                    if PlayObject.IsProperTarget(TargeTBaseObject) then
                    begin
                      if Random(10) >= TargeTBaseObject.m_nAntiMagic then
                      begin
                        //if (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
                        nPower :=
                          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
                          LoWord(PlayObject.m_WAbil.SC),
                          SmallInt(HiWord(PlayObject.m_WAbil.SC) -LoWord(PlayObject.m_WAbil.SC)) + 1);
                        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC,Trunc(g_Config.nAttackPower / 100 *
                              nPower), MakeLong(nTargetX, nTargetY), 5,Integer(TargeTBaseObject), '', 1000);
                        PlayObject.SendRefMsg(RM_SKILL53,0,nTargetX, nTargetY,0, '');
                        if Random(g_Config.nVampireHpRate) <= (UserMagic.btLevel
                          + 3) then
                        begin
                          if PlayObject.m_WAbil.HP < PlayObject.m_WAbil.MaxHP
                            then
                          begin
                            nPower := Trunc(g_Config.nVampirePower / 100 *nPower);
                            if nPower > 0 then
                              PlayObject.SendDelayMsg(PlayObject, RM_MAGHEALING,0, nPower, 0, 0, '', 3000);
                          end;
                        end;
                        if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
                          boTrain := True;
                        //end; //00494463
                      end; //00494463
                    end; //00494463
                  end; //0049426D
              end;
            SKILL_FIRECHARM {13}:
              begin //灵魂火符 0049415F
                if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX,
                  PlayObject.m_nCurrY, TargeTBaseObject) then
                begin
                  if PlayObject.IsProperTarget(TargeTBaseObject) then
                  begin
                    if Random(10) >= TargeTBaseObject.m_nAntiMagic then
                    begin
                      if (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and
                        (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then
                      begin
                        nPower :=
                          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
                          LoWord(PlayObject.m_WAbil.SC),SmallInt(HiWord(PlayObject.m_WAbil.SC) -
                            LoWord(PlayObject.m_WAbil.SC)) + 1);
                        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC,
                          nPower, MakeLong(nTargetX, nTargetY), 2,
                          Integer(TargeTBaseObject), '', 1200);
                        if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
                          boTrain := True;
                      end; //00494463
                    end; //00494463
                  end; //00494463
                end
                else
                  TargeTBaseObject := nil; //0049426D
              end;
            SKILL_HANGMAJINBUB {14}:
              begin //幽灵盾 00494277
                nPower := PlayObject.GetAttackPower(GetPower13(60) +
                  LoWord(PlayObject.m_WAbil.SC) * 10,
                  SmallInt(HiWord(PlayObject.m_WAbil.SC) -
                  LoWord(PlayObject.m_WAbil.SC)) + 1);
                if PlayObject.MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower,
                  SKILL_HANGMAJINBUB {1}) > 0 then
                  boTrain := True;
              end;
            SKILL_DEJIWONHO {15}:
              begin //神圣战甲术 004942E5
                nPower := PlayObject.GetAttackPower(GetPower13(60) +
                  LoWord(PlayObject.m_WAbil.SC) * 10,
                  SmallInt(HiWord(PlayObject.m_WAbil.SC) -
                  LoWord(PlayObject.m_WAbil.SC)) + 1);
                if PlayObject.MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower,
                  SKILL_DEJIWONHO {0}) > 0 then
                  boTrain := True;
              end;
            SKILL_HOLYSHIELD {16}:
              begin //捆魔咒 00494353
                if MagMakeHolyCurtain(PlayObject, GetPower13(40) +
                  GetRPow(PlayObject.m_WAbil.SC) * 3, nTargetX, nTargetY) > 0 then
                  boTrain := True;
              end;
            SKILL_SKELLETON {17}:
              begin //召唤骷髅 004943A2
                if MagMakeSlave(PlayObject, UserMagic) then
                begin
                  boTrain := True;
                end;
                (*
                if not PlayObject.sub_4DD704 then begin
                  if PlayObject.MakeSlave(g_Config.sBoneFamm,UserMagic.btLevel,g_Config.nBoneFammCount{1},10 * 24 * 60 * 60) <> nil then
                    boTrain:=True;
                end;
                *)
              end;
            SKILL_CLOAK {18}:
              begin //隐身术 004943DF
                if MagMakePrivateTransparent(PlayObject, GetPower13(30) +
                  GetRPow(PlayObject.m_WAbil.SC) * 3) then
                  boTrain := True;
              end;
            SKILL_BIGCLOAK {19}:
              begin //集体隐身术
                if MagMakeGroupTransparent(PlayObject, nTargetX, nTargetY,
                  GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC) * 3) then
                  boTrain := True;
              end;
            SKILL_52:
              begin //诅咒术
                nPower := PlayObject.GetAttackPower(GetPower13(60) +
                  LoWord(PlayObject.m_WAbil.SC) * 10,
                  SmallInt(HiWord(PlayObject.m_WAbil.SC) -
                  LoWord(PlayObject.m_WAbil.SC)) + 1);
                if PlayObject.MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower,
                  SKILL_54) > 0 then
                  boTrain := True;
              end;
          end; // case
          boSpellFail := False;
        end;

      end;
    SKILL_TAMMING {20}:
      begin //诱惑之光 00493A51
        if PlayObject.IsProperTarget(TargeTBaseObject) then
        begin
          if MagTamming(PlayObject, TargeTBaseObject, nTargetX, nTargetY,
            UserMagic.btLevel) then
            boTrain := True;
        end;
      end;
    SKILL_SPACEMOVE {21}:
      begin //瞬息移动 00493ADD
        PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
          MakeWord(UserMagic.MagicInfo.btEffectType,
          UserMagic.MagicInfo.btEffect), MakeLong(nTargetX, nTargetY),
          Integer(TargeTBaseObject), '');
        boSpellFire := False;
        if MagSaceMove(PlayObject, UserMagic.btLevel) then
          boTrain := True;
      end;
    SKILL_EARTHFIRE {22}:
      begin //火墙  00493B40
        if MagMakeFireCross(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
            LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC))
            + 1),
          GetPower(10) + (Word(GetRPow(PlayObject.m_WAbil.MC)) shr 1),
          nTargetX,
          nTargetY) > 0 then
          boTrain := True;
      end;
    SKILL_FIREBOOM {23}:
      begin //爆裂火焰 00493BD5
        if MagBigExplosion(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
            LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC)
            - LoWord(PlayObject.m_WAbil.MC)) + 1),
          nTargetX,
          nTargetY,
          g_Config.nFireBoomRage {1}) then
          boTrain := True;
      end;
    SKILL_LIGHTFLOWER {24}:
      begin //地狱雷光 00493CB1
        if MagElecBlizzard(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
          LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC) -
          LoWord(PlayObject.m_WAbil.MC)) + 1)) then
          boTrain := True;
      end;
    SKILL_SHOWHP {28}:
      begin
        if (TargeTBaseObject <> nil) and not TargeTBaseObject.m_boShowHP then
        begin
          if Random(6) <= (UserMagic.btLevel + 3) then
          begin
            TargeTBaseObject.m_dwShowHPTick := GetTickCount();
            TargeTBaseObject.m_dwShowHPInterval :=
              GetPower13(GetRPow(PlayObject.m_WAbil.SC) * 2 + 30) * 1000;
            TargeTBaseObject.SendDelayMsg(TargeTBaseObject, RM_DOOPENHEALTH, 0,
              0, 0, 0, '', 1500);
            boTrain := True;
          end;
        end;
      end;
    SKILL_BIGHEALLING {29}:
      begin //群体治疗术 00493E42
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
          LoWord(PlayObject.m_WAbil.SC) * 2,
          SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC))
            * 2 + 1);
        if MagBigHealing(PlayObject, nPower, nTargetX, nTargetY) then
          boTrain := True;
      end;
    SKILL_72,
      SKILL_SINSU:
      begin //召唤神兽
        boSpellFail := True;
        if CheckAmulet(PlayObject, 5, 1, nAmuletIdx) then
        begin
          UseAmulet(PlayObject, 5, 1, nAmuletIdx);
          {
          if BaseObject.m_UseItems[U_ARMRINGL].Dura >= 500 then Dec(BaseObject.m_UseItems[U_ARMRINGL].Dura,500)
          else BaseObject.m_UseItems[U_ARMRINGL].Dura:=0;
          BaseObject.SendMsg(BaseObject,RM_DURACHANGE,5,BaseObject.m_UseItems[U_ARMRINGL].Dura,BaseObject.m_UseItems[U_ARMRINGL].DuraMax,0,'');
          }
  //        if (UserMagic.MagicInfo.wMagicId = 30) and not PlayObject.sub_4DD704 then begin
          if MagMakeSinSuSlave(PlayObject, UserMagic) then
          begin
            boTrain := True;
          end;
          //          if PlayObject.MakeSlave(g_Config.sDogz,UserMagic.btLevel,1,10 * 24 * 60 * 60) <> nil then
          //            boTrain:=True;
          //        end;
          boSpellFail := False;
        end;
      end;
    {SKILL_ANGEL: begin     //狮子吼
      boSpellFail:=True;
      if CheckAmulet(PlayObject,2,1,nAmuletIdx) then begin
        UseAmulet(PlayObject,2,1,nAmuletIdx);

        if MagMakeAngelSlave(PlayObject,UserMagic) then
          boTrain:=True;

        boSpellFail:=False;
      end;
    end; }
    SKILL_SHIELD {31}:
      begin //魔法盾 00493D15
        if PlayObject.MagBubbleDefenceUp(UserMagic.btLevel,
          GetPower(GetRPow(PlayObject.m_WAbil.MC) + 15)) then
          boTrain := True;
      end;
    SKILL_80 {80}:
      begin //道力盾 00493D15
        if PlayObject.MagBubbleDefenceUp(UserMagic.btLevel,
          GetPower(GetRPow(PlayObject.m_WAbil.MC) + 15)) then
          boTrain := True;
      end;
    SKILL_57,SKILL_81://四级魔法盾,四级道力盾
      begin // 00493D15
        if PlayObject.MagBubbleDefenceUp57(UserMagic.btLevel,
          GetPower(GetRPow(PlayObject.m_WAbil.MC) + 15)) then
          boTrain := True;
      end;
     SKILL_82://乾坤大挪移
      begin
         if UserMagic.btLevel<3 then
         begin
         if Random(g_Config.nSkill82Rate) <= (UserMagic.btLevel+ 3) then
           begin
             PlayObject.SendDelayMsg(PlayObject, RM_SKILL_82, 0,nTargetX, nTargetY, 0, '',200);
             //PlayObject.SpaceMove(PlayObject.m_sMapName,nTargetX, nTargetY, 1);
             boTrain := True;
           end;
         end else
         begin
           PlayObject.SendDelayMsg(PlayObject, RM_SKILL_82, 0,nTargetX, nTargetY, 0, '',200);
           //PlayObject.SpaceMove(PlayObject.m_sMapName,nTargetX, nTargetY, 1);
           boTrain := True;
         end;
      end;
    SKILL_84://酒气护体
    begin
      try
      if not PlayObject.m_boskill84open then
       begin
         if (PlayObject.m_SKILL84Rec.SKILL84Level>0) and
          // (GetTickCount>(PlayObject.m_dwskill84Time+(g_Config.nHPUpTick*1000))) and
          (PlayObject.m_WineRec.Alcoho>0) and
           ((PlayObject.m_WineRec.Alcoho / PlayObject.m_WineRec.WineValue*100)>=g_Config.nMinDrinkValue84) then
         begin
           PlayObject.m_dwskill84Time:=GetTickCount;
           PlayObject.m_boskill84open:=True;
           PlayObject.m_skill84Abil:=Round(PlayObject.m_SKILL84Rec.SKILL84Level*g_Config.nskill84HPUpTick);
           PlayObject.RecalcAbilitys;
           PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
           PlayObject.SysMsg('生命值瞬间提升,持续'+inttostr(g_Config.nHPUpUseTime)+'秒',c_Green,t_Hint);
           PlayObject.SysMsg('你的酒气护体已经在激发状态',c_Green,t_Hint);
         end else
         begin
          PlayObject.SysMsg('等级需达1级以上，且醉酒度不低于'+inttostr(g_Config.nMinDrinkValue84)+'%时,才能使用此技能',c_Red, t_System);
         end;
       end else
         PlayObject.SysMsg('你的酒气护体已在激发状态,剩余时间'+inttostr(round((PlayObject.m_dwskill84Time+(g_Config.nHPUpUseTime*1000)-GetTickCount)/1000))+'秒',c_Green,t_Hint);
        boTrain := True;
      except

      end;
    end;

    SKILL_KILLUNDEAD {32}:
      begin //00493A97  圣言术
        if PlayObject.IsProperTarget(TargeTBaseObject) then
        begin
          if MagTurnUndead(PlayObject, TargeTBaseObject, nTargetX, nTargetY,
            UserMagic.btLevel) then
            boTrain := True;
        end;
      end;
    SKILL_SNOWWIND {33}:
      begin //00493C43 冰咆哮
        if MagBigExplosion(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
            LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC)
            - LoWord(PlayObject.m_WAbil.MC)) + 1),
          nTargetX,
          nTargetY,
          g_Config.nSnowWindRange {1}) then
          boTrain := True;
      end;
    SKILL_UNAMYOUNSUL {34}:
      begin //解毒术
        if TargeTBaseObject = nil then
        begin
          TargeTBaseObject := PlayObject;
          nTargetX := PlayObject.m_nCurrX;
          nTargetY := PlayObject.m_nCurrY;
        end;

        if PlayObject.IsProperFriend(TargeTBaseObject) then
        begin
          if Random(7) - (UserMagic.btLevel + 1) < 0 then
          begin
            if TargeTBaseObject.m_wStatusTimeArr[POISON_DECHEALTH] <> 0 then
            begin
              TargeTBaseObject.m_wStatusTimeArr[POISON_DECHEALTH] := 1;
              boTrain := True;
            end;
            if TargeTBaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] <> 0 then
            begin
              TargeTBaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] := 1;
              boTrain := True;
            end;
            if TargeTBaseObject.m_wStatusTimeArr[POISON_STONE] <> 0 then
            begin
              TargeTBaseObject.m_wStatusTimeArr[POISON_STONE] := 1;
              boTrain := True;
            end;
          end;
        end;

      end;
    SKILL_WINDTEBO {35}: if MagWindTebo(PlayObject, UserMagic) then
        boTrain := True;

    //冰焰
    SKILL_MABE {36}:
      begin
        with PlayObject do
        begin
          nPower := GetAttackPower(GetPower(MPow(UserMagic)) +
            LoWord(m_WAbil.MC),
            SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
        end;
        if MabMabe(PlayObject, TargeTBaseObject, nPower, UserMagic.btLevel,
          nTargetX, nTargetY) then
          boTrain := True;
      end;
    SKILL_GROUPLIGHTENING {37 群体雷电术}:
      begin
        if MagGroupLightening(PlayObject, UserMagic, nTargetX, nTargetY,
          TargeTBaseObject, boSpellFire) then
          boTrain := True;
      end;
    SKILL_GROUPAMYOUNSUL {38 群体施毒术}:
      begin
        if MagGroupAmyounsul(PlayObject, UserMagic, nTargetX, nTargetY,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_GROUPDEDING {39 地钉}:
      begin
        if GetTickCount > PlayObject.m_dwMagicDeDingTick then
        begin
          PlayObject.m_dwMagicDeDingTick := GetTickCount +
            g_Config.dwMagicDeDingTime;
          if MagGroupDeDing(PlayObject, UserMagic, nTargetX, nTargetY,
            TargeTBaseObject) then
            boTrain := True;
        end
        else
        begin
          boSpellFail := True;
          PlayObject.SysMsg(Format(sMagicDeDingTime,
            [(PlayObject.m_dwMagicDeDingTick - GetTickCount) div 1000]),
            c_Red, t_System);
        end;

      end;
    SKILL_ANGEL:
      begin //狮子吼
        if MagGroupMb(PlayObject, UserMagic, nTargetX, nTargetY,
          TargeTBaseObject) then
          boTrain := True;
      end;
    //法师
    SKILL_44:
      begin //结冰掌
        if MagHbFireBall(PlayObject, UserMagic, nTargetX, nTargetY,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_45:
      begin //灭天火
        if PlayObject.IsProperTarget(TargeTBaseObject) then
        begin
          if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then
          begin
            nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
              LoWord(PlayObject.m_WAbil.MC),
              SmallInt(HiWord(PlayObject.m_WAbil.MC) -
                LoWord(PlayObject.m_WAbil.MC)) + 1);
            if TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD then
              nPower := ROUND(nPower * 1.5);
            PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower,
              MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '',
              600);
            if g_Config.boPlayObjectReduceMP then
              TargeTBaseObject.DamageSpell(nPower);
            if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
              boTrain := True;
          end
          else
            TargeTBaseObject := nil
        end
        else
          TargeTBaseObject := nil;
      end;
    SKILL_46:
      begin //分身术
        if MagMakeClone(PlayObject, UserMagic) then
        begin
          boTrain := True;
        end;
        //if PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX,PlayObject.m_nCurrY,PlayObject.m_btDirection,4,nTargetX,nTargetY) then
          //boTrain:=True;
      end;
    SKILL_47:
      begin //火龙气焰
        if MagBigExplosion(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
            LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC)
            - LoWord(PlayObject.m_WAbil.MC)) + 1),
          nTargetX,
          nTargetY,
          g_Config.nFireBoomRage {1}) then
          boTrain := True;
      end;
    //道士
    SKILL_ENERGYREPULSOR:
      begin //气功波
        if MagPushArround(PlayObject, UserMagic.btLevel) > 0 then
          boTrain := True;
      end;
    SKILL_49:
      begin //净化术
        boTrain := True;
      end;
    SKILL_UENHANCER:
      begin //无极真气 Uenhancer
        TargeTBaseObject := PlayObject;
        nTargetX := PlayObject.m_nCurrX;
        nTargetY := PlayObject.m_nCurrY;
        nPower := (g_Config.nUenhancerTime div 2) + (UserMagic.btLevel + 1) +
          Random((UserMagic.btLevel + 1) * 2);
        n14 := PlayObject.GetAttackPower(LoWord(PlayObject.m_WAbil.SC),
          SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC))
          + 1);
        if TargeTBaseObject.AttPowerUp(Trunc(n14 * (g_Config.nUenhancerRate /
          100)), nPower) then
          boTrain := True;
      end;
    SKILL_51:
      begin //灵魂召唤术
        boTrain := True;
      end;

    SKILL_54:
      begin //骷髅咒
        boTrain := True;
      end;
    SKILL_74:
      begin //流星火雨
        if GetTickCount > PlayObject.m_MeteorRainTime then
        begin
          PlayObject.m_MeteorRainTime := GetTickCount +
            g_Config.nMeteorRainTime;
          nPower := Trunc((PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
            LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC)
            - LoWord(PlayObject.m_WAbil.MC)) + 1)) * (g_Config.nMeteorRainPower /
            100));
          if MagBigExplosionEx(PlayObject,
            nPower,
            nTargetX,
            nTargetY,
            g_Config.nSnowWindRange {1}) then
          begin

            boTrain := True;
          end;
        end
        else
        begin
          boSpellFail := True;
          PlayObject.SysMsg(Format(sMagicDeDingTime,
            [(PlayObject.m_MeteorRainTime - GetTickCount) div 1000]),
            c_Red, t_System);
        end;
      end;
    SKILL_71:
      begin //擒龙手
        if (TargeTBaseObject <> nil) and
          (PlayObject.IsProperTarget(TargeTBaseObject)) then
        begin
          if (Random(3) - (UserMagic.btLevel + 1)) < 0 then
          begin
            if (PlayObject.m_Abil.Level >= TargeTBaseObject.m_Abil.Level) and
              ((TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) or
                (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT)) and
              (not (TargeTBaseObject.m_boDeath or TargeTBaseObject.m_boGhost or
                (TargeTBaseObject = PlayObject))) and
              (not ((TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) and (not
                g_Config.boFastenAttackPlayObject) and (not
                TargeTBaseObject.m_boHero))) and
              (not ((TargeTBaseObject.m_AllMaster <> nil) and (not
                g_Config.boFastenAttackSlaveObject) and
                (TargeTBaseObject.m_AllMaster.m_btRaceServer = RC_PLAYOBJECT)))
                and
              (not ((TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) and
                (TargeTBaseObject.m_boHero) and (not
                g_Config.boFastenAttackHeroObject))) then
            begin
              PlayObject.GetFrontPosition(nTargetX, nTargetY);
              TargeTBaseObject.SpaceMove(PlayObject.m_PEnvir.sMapName, nTargetX,
                nTargetY, 1);
              boTrain := True;
            end;
          end;
        end;
      end;
    SKILL_60:
      begin //破魂斩
        boSpellFail := True;
        if (TargeTBaseObject <> nil) and
          (PlayObject <> nil) and
          (SkillWW(PlayObject, UserMagic, TargeTBaseObject)) then
        begin
          boTrain := True;
          boSpellFail := False;
          boSpellFire := False;
        end;
      end;
    SKILL_61:
      begin //劈星斩
        boSpellFail := True;
        if (TargeTBaseObject <> nil) and
          (PlayObject <> nil) and
          (SkillTW(PlayObject, UserMagic, TargeTBaseObject)) then
        begin
          boTrain := True;
          boSpellFail := False;
          boSpellFire := False;
        end;
      end;
    SKILL_62:
      begin //雷霆一击
        boSpellFail := True;
        if (TargeTBaseObject <> nil) and
          (PlayObject <> nil) and
          (SkillZW(PlayObject, UserMagic, TargeTBaseObject)) then
        begin
          boTrain := True;
          boSpellFail := False;
          boSpellFire := False;
        end;
      end;
    SKILL_63:
      begin //噬魂沼泽
        boSpellFail := True;
        if (TargeTBaseObject <> nil) and
          (PlayObject <> nil) and
          (SkillTT(PlayObject, UserMagic, TargeTBaseObject)) then
        begin
          boTrain := True;
          boSpellFail := False;
          boSpellFire := True;
        end;
      end;
    SKILL_64:
      begin //末日审判
        boSpellFail := True;
        if (TargeTBaseObject <> nil) and
          (PlayObject <> nil) and
          (SkillZT(PlayObject, UserMagic, TargeTBaseObject)) then
        begin
          boTrain := True;
          boSpellFail := False;
          boSpellFire := True;
        end;
      end;
    SKILL_65:
      begin //火龙气焰
        boSpellFail := True;
        if (TargeTBaseObject <> nil) and
          (PlayObject <> nil) and
          (SkillZZ(PlayObject, UserMagic, TargeTBaseObject)) then
        begin
          boTrain := True;
          boSpellFail := False;
          boSpellFire := True;
        end;
      end;
    SKILL_75:
      begin //护体神盾
        //boSpellFire:=g_Config.boShieldShowEffect;
        if (not PlayObject.m_boOpenShield) then
        begin
          if (GetTickCount - PlayObject.m_dwOpenShieldTick) >
            g_Config.nShieldTick then
          begin
            PlayObject.m_boOpenShield := True;
            if g_Config.nShieldTime > 0 then
              PlayObject.m_dwOpenShieldTime := GetTickCount +
                g_Config.nShieldTime
            else
              PlayObject.m_dwOpenShieldTime := 0;
            boTrain := True;
            if PlayObject.m_btRaceServer = RC_PLAYOBJECT then
              PlayObject.SysMsg(sOpenShieldMsg, c_Green, t_System);
          end
          else if PlayObject.m_btRaceServer = RC_PLAYOBJECT then
            PlayObject.SysMsg(Format(sOpenShieldTickMsg, [(g_Config.nShieldTick
              div 1000) - (GetTickCount - PlayObject.m_dwOpenShieldTick) div
              1000]), c_Red, t_System);
        end
        else
        begin
          if PlayObject.m_btRaceServer = RC_PLAYOBJECT then
            PlayObject.SysMsg(sOpenShieldOKMsg, c_Red, t_System);
        end;
      end;
    SKILL_100:
      begin
        boTrain := True;
      end;
    SKILL_101:
      begin
        boTrain := True;
      end;
  else
    begin
      boTrain := True;
      if (TargeTBaseObject <> nil) and
        (PlayObject <> TargeTBaseObject) and
        (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) and
        (not TargeTBaseObject.m_boHero) then
      begin
        TargeTBaseObject.NpcGotoLable(g_FunctionNPC, Format('@MagTagFunc%d',
          [UserMagic.wMagIdx]), False);
      end
      else
        PlayObject.NpcGotoLable(g_FunctionNPC, Format('@MagSelfFunc%d',
          [UserMagic.wMagIdx]), False);
      {if (TargeTBaseObject<>Nil) and (PlayObject<>TargeTBaseObject) then begin
        if (TBaseObject_btRaceServer(TargeTBaseObject)^=0) and (not TBaseObject_boHero(TargeTBaseObject)) then
          TNormNpc_GotoLable(NormNpc,TargeTBaseObject,PChar(Format(sMagTagFunc,[UserMagic.wMagIdx])));
      end else TNormNpc_GotoLable(NormNpc,PlayObject,PChar(Format(sMagSelfFun,[UserMagic.wMagIdx])));}
      {Try
        if Assigned(m_HookDoSpell) and (PlayObject.m_btRaceServer = RC_PLAYOBJECT) and (not PlayObject.m_boHero) then begin
          boTrain:=m_HookDoSpell(Self,TPlayObject(PlayObject),UserMagic,nTargetX,nTargetY,TargeTBaseObject,nHookStatus);
        end;
      Except
        MainOutMessage('[Exception] TMagicManager.DoSpell->HookApi');
      end; }
    end;
  end;
  if boSpellFail then
    exit;
  if boSpellFire then
  begin
    PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
      MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
      MakeLong(nTargetX, nTargetY),
      Integer(TargeTBaseObject),
      '');
  end;
  if (UserMagic.btLevel < 3) and (boTrain) then
  begin
    if UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] <=
      PlayObject.m_Abil.Level then
    begin
      PlayObject.TrainSkill(UserMagic, Random(3) + 1);
      if not PlayObject.CheckMagicLevelup(UserMagic) then
      begin
        PlayObject.SendDelayMsg(PlayObject, RM_MAGIC_LVEXP, 0,
          UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint,
          '', 1000);
      end;
    end;
  end;
  Result := True;

end;

//火龙气焰

function TMagicManager.SkillZZ(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  TargeTBaseObject: TBaseObject): Boolean;
var
  Master: TBaseObject;
  nTargeX, nTargeY: Integer;
  //  nTargetX,nTargetY:Integer;
  nPower, nPower2: Integer;
begin
  try
    Result := False;
    try
      if PlayObject.m_HeroHuman = nil then
        exit;
      Master := PlayObject.m_HeroHuman;
      nTargeX := TargeTBaseObject.m_nCurrX;
      nTargeY := TargeTBaseObject.m_nCurrY;
      if (abs(Master.m_nCurrX - nTargeX) < g_Config.nMagicAttackRage) and
        (abs(Master.m_nCurrY - nTargeY) < g_Config.nMagicAttackRage) then
      begin
        Master.SendRefMsg(RM_SPELL3, MakeWord(UserMagic.MagicInfo.btEffectType,
          UserMagic.MagicInfo.btEffect), nTargeX, nTargeY, UserMagic.wMagIdx - 10,
          '');
        PlayObject.SendRefMsg(RM_SPELL,
          MakeWord(UserMagic.MagicInfo.btEffectType,
          UserMagic.MagicInfo.btEffect), nTargeX, nTargeY, UserMagic.wMagIdx - 10,
          '');

        nPower := Master.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) +
          LoWord(Master.m_WAbil.MC),
          SmallInt(HiWord(Master.m_WAbil.MC) - LoWord(Master.m_WAbil.MC)) + 1);
        nPower2 := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic)
          + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC))
            + 1);
        //nPower:=Round((nPower+nPower2)*0.5);
        //nPower:=GetJointPower(nPower,PlayObject.m_HeroDanderCount,g_Config.nSkillZZPowerRate);
        nPower := Trunc((nPower + nPower2) * (g_Config.nSkillZZPowerRate /
          100));

        MagBigExplosion(Master,
          nPower,
          nTargeX,
          nTargeY,
          2);
        Master.SendRefMsg(RM_MAGICFIRE, 0,
          MakeWord(UserMagic.MagicInfo.btEffectType,
            UserMagic.MagicInfo.btEffect),
          MakeLong(nTargeX, nTargeY),
          Integer(TargeTBaseObject),
          '');
        Result := True;
      end;
    except
      MainOutMessage('[Exception] TMagicManager.SkillZZ');
    end;
  except
    MainOutMessage('[Exception] TMagicManager.DoSpell');
  end;
end;

//末日审判

function TMagicManager.SkillZT(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  TargeTBaseObject: TBaseObject): Boolean;
var
  Master: TBaseObject;
  SelfBase: TBaseObject;
  nTargeX, nTargeY: Integer;
  //  nTargetX,nTargetY:Integer;
  //  n1C,n2C:Byte;
  nPower, nPower2: Integer;
begin
  try
    Result := False;
    try
      if PlayObject.m_HeroHuman = nil then
        exit;
      if PlayObject.m_btJob = JOB_WIZARD then
      begin
        Master := PlayObject;
        SelfBase := PlayObject.m_HeroHuman;
      end
      else
      begin
        Master := PlayObject.m_HeroHuman;
        SelfBase := PlayObject;
      end;
      nTargeX := TargeTBaseObject.m_nCurrX;
      nTargeY := TargeTBaseObject.m_nCurrY;
      if (abs(Master.m_nCurrX - nTargeX) < g_Config.nMagicAttackRage) and
        (abs(Master.m_nCurrY - nTargeY) < g_Config.nMagicAttackRage) and
        (abs(SelfBase.m_nCurrX - nTargeX) < g_Config.nMagicAttackRage) and
        (abs(SelfBase.m_nCurrY - nTargeY) < g_Config.nMagicAttackRage) then
      begin
        Master.SendRefMsg(RM_SPELL3, MakeWord(1, UserMagic.MagicInfo.btEffect),
          nTargeX, nTargeY, UserMagic.wMagIdx - 10, '');
        SelfBase.SendRefMsg(RM_SPELL3, MakeWord(2,
          UserMagic.MagicInfo.btEffect), nTargeX, nTargeY, UserMagic.wMagIdx - 10,
          '');

        nPower := Master.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) +
          LoWord(Master.m_WAbil.MC),
          SmallInt(HiWord(Master.m_WAbil.MC) - LoWord(Master.m_WAbil.MC)) + 1);
        nPower2 := SelfBase.GetAttackPower(GetPower(MPow(UserMagic), UserMagic)
          + LoWord(SelfBase.m_WAbil.SC),
          SmallInt(HiWord(SelfBase.m_WAbil.SC) - LoWord(SelfBase.m_WAbil.SC)) +
            1);
        //nPower:=Round((nPower+nPower2)*0.5);
        //nPower:=GetJointPower(nPower,PlayObject.m_HeroDanderCount,g_Config.nSkillZTPowerRate);
        nPower := Trunc((nPower + nPower2) * (g_Config.nSkillZTPowerRate /
          100));

        MagBigExplosion(PlayObject.m_HeroHuman,
          nPower,
          nTargeX,
          nTargeY,
          2);

        PlayObject.m_HeroHuman.SendRefMsg(RM_MAGICFIRE, 0,
          MakeWord(UserMagic.MagicInfo.btEffectType,
            UserMagic.MagicInfo.btEffect),
          MakeLong(nTargeX, nTargeY),
          Integer(TargeTBaseObject),
          '');
        Result := True;
      end;
    except
      MainOutMessage('[Exception] TMagicManager.SkillZT');
    end;
  except
    MainOutMessage('[Exception] TMagicManager.SkillZT');
  end;
end;

//噬魂沼泽

function TMagicManager.SkillTT(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  TargeTBaseObject: TBaseObject): Boolean;
var
  Master: TBaseObject;
  nTargeX, nTargeY: Integer;
  //  nTargetX,nTargetY:Integer;
  //  n1C,n2C:Byte;
  nPower, nPower2: Integer;
  I: Integer;
  BaseObjectList: TList;
  attactTBaseObject: TBaseObject;
begin
  try
    Result := False;
    try
      if PlayObject.m_HeroHuman = nil then
        exit;
      Master := PlayObject.m_HeroHuman;
      nTargeX := TargeTBaseObject.m_nCurrX;
      nTargeY := TargeTBaseObject.m_nCurrY;
      if (abs(Master.m_nCurrX - nTargeX) < g_Config.nMagicAttackRage) and
        (abs(Master.m_nCurrY - nTargeY) < g_Config.nMagicAttackRage) then
      begin
        Master.SendRefMsg(RM_SPELL3, MakeWord(UserMagic.MagicInfo.btEffectType,
          UserMagic.MagicInfo.btEffect), nTargeX, nTargeY, UserMagic.wMagIdx - 10,
          '');
        PlayObject.SendRefMsg(RM_SPELL,
          MakeWord(UserMagic.MagicInfo.btEffectType,
          UserMagic.MagicInfo.btEffect), nTargeX, nTargeY, UserMagic.wMagIdx - 10,
          '');

        nPower := Master.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) +
          LoWord(Master.m_WAbil.SC),
          SmallInt(HiWord(Master.m_WAbil.SC) - LoWord(Master.m_WAbil.SC)) + 1);
        nPower2 := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic)
          + LoWord(PlayObject.m_WAbil.SC),
          SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC))
            + 1);
        //nPower:=Round((nPower+nPower2)*0.5);
        //nPower:=GetJointPower(nPower,PlayObject.m_HeroDanderCount,g_Config.nSkillTTPowerRate);
        nPower := Trunc((nPower + nPower2) * (g_Config.nSkillTTPowerRate /
          100));

        BaseObjectList := TList.Create;
        Master.GetMapBaseObjects(TargeTBaseObject.m_PEnvir, nTargeX, nTargeY, 3,
          BaseObjectList);
        for I := 0 to BaseObjectList.Count - 1 do
        begin
          attactTBaseObject := TBaseObject(BaseObjectList.Items[i]);
          if Master.IsProperTarget(attactTBaseObject) then
          begin
            Master.SetTargetCreat(attactTBaseObject);
            attactTBaseObject.SendDelayMsg(Master, RM_MAGSTRUCK, 0, nPower, 0, 0,
              '', 600);
            MagGroupAmyounsul2(PlayObject, TBaseObject(Master), UserMagic,
              nTargeX, nTargeY, attactTBaseObject);
          end;
        end;
        BaseObjectList.Free;

        {if Master.IsProperTarget(TargeTBaseObject) then
          TargeTBaseObject.SendDelayMsg (Master, RM_MAGSTRUCK, 0, nPower, 0, 0, '', 600);
        MagGroupAmyounsul2(PlayObject,TBaseObject(Master),UserMagic,nTargeX,nTargeY,TargeTBaseObject);}
        Master.SendRefMsg(RM_MAGICFIRE, 0,
          MakeWord(UserMagic.MagicInfo.btEffectType,
            UserMagic.MagicInfo.btEffect),
          MakeLong(nTargeX, nTargeY),
          Integer(TargeTBaseObject),
          '');
        Result := True;
      end;
    except
      MainOutMessage('[Exception] TMagicManager.SkillTT');
    end;
  except
    MainOutMessage('[Exception] TMagicManager.SkillTT');
  end;
end;

//雷霆一击

function TMagicManager.SkillZW(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  TargeTBaseObject: TBaseObject): Boolean;
var
  Master: TBaseObject;
  SelfBase: TBaseObject;
  nTargeX, nTargeY: Integer;
  nTargetX, nTargetY: Integer;
  n1C {,n2C}: Byte;
  nPower, nPower2: Integer;
  n14, n18 {,n15,n17,nX,nY}: Integer;
begin
  try
    Result := False;
    try
      if PlayObject.m_HeroHuman = nil then
        exit;
      if PlayObject.m_btJob = Job_Warr then
      begin
        Master := PlayObject;
        SelfBase := PlayObject.m_HeroHuman;
      end
      else
      begin
        Master := PlayObject.m_HeroHuman;
        SelfBase := PlayObject;
      end;
      nTargeX := TargeTBaseObject.m_nCurrX;
      nTargeY := TargeTBaseObject.m_nCurrY;
      if (abs(Master.m_nCurrX - nTargeX) < 3) and
        (abs(Master.m_nCurrY - nTargeY) < 3) and
        (abs(SelfBase.m_nCurrX - nTargeX) < g_Config.nMagicAttackRage) and
        (abs(SelfBase.m_nCurrY - nTargeY) < g_Config.nMagicAttackRage) and
        (CheckBeeline(Master.m_nCurrX, Master.m_nCurrY, nTargeX, nTargeY)) then
      begin
        n1C := GetNextDirection(Master.m_nCurrX, Master.m_nCurrY, nTargeX,
          nTargeY);
        SelfBase.SendRefMsg(RM_SPELL3,
          MakeWord(UserMagic.MagicInfo.btEffectType,
          UserMagic.MagicInfo.btEffect), nTargeX, nTargeY, UserMagic.wMagIdx - 10,
          '');
        Master.SendRefMsg(RM_10056, n1C, Integer(Master), Master.m_nCurrX,
          Master.m_nCurrY, '');

        nPower := Master.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) +
          LoWord(Master.m_WAbil.DC),
          SmallInt(HiWord(Master.m_WAbil.DC) - LoWord(Master.m_WAbil.DC)) + 1);
        nPower2 := SelfBase.GetAttackPower(GetPower(MPow(UserMagic), UserMagic)
          + LoWord(SelfBase.m_WAbil.MC),
          SmallInt(HiWord(SelfBase.m_WAbil.MC) - LoWord(SelfBase.m_WAbil.MC)) +
            1);
        //nPower:=Round((nPower+nPower2)*0.5);
        //nPower:=GetJointPower(nPower,PlayObject.m_HeroDanderCount,g_Config.nSkillZWPowerRate);
        nPower := Trunc((nPower + nPower2) * (g_Config.nSkillZWPowerRate /
          100));

        Master.m_PEnvir.GetNextPosition(Master.m_nCurrX, Master.m_nCurrY, n1C,
          1, n14, n18);
        Master.m_PEnvir.GetNextPosition(Master.m_nCurrX, Master.m_nCurrY, n1C,
          2, nTargetX, nTargetY);
        PlayObject.m_HeroHuman.MagPassThroughMagic2(n14, n18, nTargetX,
          nTargetY, n1C, nPower, True);
        SelfBase.SendRefMsg(RM_MAGICFIRE, 0,
          MakeWord(UserMagic.MagicInfo.btEffectType,
            UserMagic.MagicInfo.btEffect),
          MakeLong(TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY),
          Integer(TargeTBaseObject),
          '');
        Result := True;
      end;
    except
      MainOutMessage('[Exception] TMagicManager.SkillZW');
    end;
  except
    MainOutMessage('[Exception] TMagicManager.SkillZW');
  end;
end;

//劈星斩

function TMagicManager.SkillTW(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  TargeTBaseObject: TBaseObject): Boolean;
var
  Master: TBaseObject;
  SelfBase: TBaseObject;
  nTargeX, nTargeY: Integer;
  //  nTargetX,nTargetY:Integer;
  n1C {,n2C}: Byte;
  nPower, nPower2: Integer;
begin
  try
    Result := False;
    try
      if PlayObject.m_HeroHuman = nil then
        exit;
      if PlayObject.m_btJob = Job_Warr then
      begin
        Master := PlayObject;
        SelfBase := PlayObject.m_HeroHuman;
      end
      else
      begin
        Master := PlayObject.m_HeroHuman;
        SelfBase := PlayObject;
      end;
      nTargeX := TargeTBaseObject.m_nCurrX;
      nTargeY := TargeTBaseObject.m_nCurrY;
      if (abs(Master.m_nCurrX - nTargeX) < 5) and
        (abs(Master.m_nCurrY - nTargeY) < 5) and
        (abs(SelfBase.m_nCurrX - nTargeX) < g_Config.nMagicAttackRage) and
        (abs(SelfBase.m_nCurrY - nTargeY) < g_Config.nMagicAttackRage) and
        (CheckBeeline(Master.m_nCurrX, Master.m_nCurrY, nTargeX, nTargeY)) then
      begin
        n1C := GetNextDirection(Master.m_nCurrX, Master.m_nCurrY, nTargeX,
          nTargeY);
        SelfBase.SendRefMsg(RM_SPELL3,
          MakeWord(UserMagic.MagicInfo.btEffectType,
          UserMagic.MagicInfo.btEffect), nTargeX, nTargeY, UserMagic.wMagIdx - 10,
          '');
        Master.SendRefMsg(RM_10057, n1C, Integer(Master), Master.m_nCurrX,
          Master.m_nCurrY, '');

        nPower := Master.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) +
          LoWord(Master.m_WAbil.DC),
          SmallInt(HiWord(Master.m_WAbil.DC) - LoWord(Master.m_WAbil.DC)) + 1);
        nPower2 := SelfBase.GetAttackPower(GetPower(MPow(UserMagic), UserMagic)
          + LoWord(SelfBase.m_WAbil.SC),
          SmallInt(HiWord(SelfBase.m_WAbil.SC) - LoWord(SelfBase.m_WAbil.SC)) +
            1);
        //nPower:=Round((nPower+nPower2)*0.5);
        nPower := Trunc((nPower + nPower2) * (g_Config.nSkillTWPowerRate /
          100));
        //nPower:=GetJointPower(nPower,PlayObject.m_HeroDanderCount,g_Config.nSkillTWPowerRate);
        if TargeTBaseObject.InSafeZone then
        begin
          if (TargeTBaseObject.m_btRaceServer <> RC_PLAYOBJECT) and
            (TargeTBaseObject.m_AllMaster = nil) then
            TargeTBaseObject.SendDelayMsg(PlayObject.m_HeroHuman, RM_MAGSTRUCK,
              0, nPower, 0, 0, '', 600)
        end
        else
          TargeTBaseObject.SendDelayMsg(PlayObject.m_HeroHuman, RM_MAGSTRUCK, 0,
            nPower, 0, 0, '', 600);

        SelfBase.SendRefMsg(RM_MAGICFIRE, 0,
          MakeWord(UserMagic.MagicInfo.btEffectType,
            UserMagic.MagicInfo.btEffect),
          MakeLong(TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY),
          Integer(TargeTBaseObject),
          '');
        Result := True;
      end;
    except
      MainOutMessage('[Exception] TMagicManager.SkillWW');
    end;
  except
    MainOutMessage('[Exception] TMagicManager.SkillTW');
  end;
end;

//破魂斩

function TMagicManager.SkillWW(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  TargeTBaseObject: TBaseObject): Boolean;
var
  Master: TBaseObject;
  nTargeX, nTargeY: Integer;
  nTargetX, nTargetY: Integer;
  n1C, n2C: Byte;
  nPower, nPower2: Integer;
  n14, n18, n15, n17, nX, nY: Integer;
begin
  try
    Result := False;
    try
      if PlayObject.m_HeroHuman = nil then
        exit;
      Master := PlayObject.m_HeroHuman;
      nTargeX := TargeTBaseObject.m_nCurrX;
      nTargeY := TargeTBaseObject.m_nCurrY;
      n1C := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, nTargeX,
        nTargeY);
      n2C := GetNextDirection(Master.m_nCurrX, Master.m_nCurrY, nTargeX,
        nTargeY);
      if (abs(PlayObject.m_nCurrX - nTargeX) < 7) and
        (abs(PlayObject.m_nCurrY - nTargeY) < 7) and
        (abs(Master.m_nCurrX - nTargeX) < 7) and
        (abs(Master.m_nCurrY - nTargeY) < 7) and
        (PlayObject.m_btDirection = n1C) and
        (Master.m_btDirection = n2C) then
      begin
        Master.SendRefMsg(RM_10054, n2C, Integer(Master), Master.m_nCurrX,
          Master.m_nCurrY, '');
        PlayObject.SendRefMsg(RM_10054, n1C, Integer(PlayObject),
          PlayObject.m_nCurrX, PlayObject.m_nCurrY, '');
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic)
          + LoWord(PlayObject.m_WAbil.DC),
          SmallInt(HiWord(PlayObject.m_WAbil.DC) -
            LoWord(PlayObject.m_WAbil.DC)));
        //nPower:=nPower+Trunc(PlayObject.m_HeroDanderCount/5);
        //nPower:=GetJointPower(nPower,PlayObject.m_HeroDanderCount,g_Config.nSkillWWPowerRate);
        //nPower:=Round(nPower*(UserMagic.btLevel*0.1+0.3));
        nPower2 := Master.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) +
          LoWord(Master.m_WAbil.DC),
          SmallInt(HiWord(Master.m_WAbil.DC) - LoWord(Master.m_WAbil.DC)) + 1);
        //nPower2:=Round(nPower2*(UserMagic.btLevel*0.1+0.3));
        //nPower2:=GetJointPower(nPower2,PlayObject.m_HeroDanderCount,g_Config.nSkillWWPowerRate);
        nPower := Trunc((nPower + nPower2) * (g_Config.nSkillWWPowerRate /
          100));
        Master.m_PEnvir.GetNextPosition(Master.m_nCurrX, Master.m_nCurrY, n2C,
          1, n14, n18);
        PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX,
          PlayObject.m_nCurrY, n1C, 1, n15, n17);
        Master.m_PEnvir.GetNextPosition(Master.m_nCurrX, Master.m_nCurrY, n2C,
          6, nTargetX, nTargetY);
        PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX,
          PlayObject.m_nCurrY, n1C, 6, nX, nY);
        Master.MagPassThroughMagic2(n14, n18, nTargetX, nTargetY, n2C, nPower,
          True);
        PlayObject.MagPassThroughMagic2(n15, n17, nX, nY, n1C, nPower, True);
        Result := True;
      end;
    except
      MainOutMessage('[Exception] TMagicManager.SkillWW');
    end;
  except
    MainOutMessage('[Exception] TMagicManager.SkillWW');
  end;
end;

//检测是否在同一条直线上

function TMagicManager.CheckBeeline(nX, nY, sX, sY: Integer): Boolean;
begin
  try
    Result := False;
    if nX = sX then
      Result := True;
    if nY = sY then
      Result := True;
    if abs(nX - sX) = abs(nY - sY) then
      Result := True;
  except
    MainOutMessage('[Exception] TMagicManager.CheckBeeline');
  end;
end;

function TMagicManager.MagMakePrivateTransparent(BaseObject: TBaseObject;
  nHTime: Integer): Boolean; //004930E8
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  try
    Result := False;
    if BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] > 0 then
      exit; //4930FE
    BaseObjectList := TList.Create;
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, BaseObject.m_nCurrX,
      BaseObject.m_nCurrY, 9, BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do
    begin
      TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
      if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) and
        (TargeTBaseObject.m_TargetCret = BaseObject) then
      begin
        if (abs(TargeTBaseObject.m_nCurrX - BaseObject.m_nCurrX) > 1) or
          (abs(TargeTBaseObject.m_nCurrY - BaseObject.m_nCurrY) > 1) or
          (Random(2) = 0) then
        begin
          TargeTBaseObject.m_TargetCret := nil;
        end;
      end;
    end;
    BaseObjectList.Free;
    BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] := nHTime; //004931D2
    BaseObject.m_nCharStatus := BaseObject.GetCharStatus();
    BaseObject.StatusChanged();
    BaseObject.m_boHideMode := True;
    BaseObject.m_boTransparent := True;
    Result := True;
  except
    MainOutMessage('[Exception] TMagicManager.MagMakePrivateTransparent');
  end;
end;

function TMagicManager.MagTamming(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nMagicLevel: Integer): Boolean; //00492368
var
  n14: Integer;
begin
  try
    Result := False;
    if (TargeTBaseObject.m_btRaceServer <> RC_PLAYOBJECT) and ((Random(4 -
      nMagicLevel) = 0)) then
    begin
      TargeTBaseObject.m_TargetCret := nil;
      if TargeTBaseObject.m_AllMaster = BaseObject then
      begin
        TargeTBaseObject.OpenHolySeizeMode((nMagicLevel * 5 + 10) * 1000);
        Result := True;
      end
      else
      begin
        if Random(2) = 0 then
        begin
          if TargeTBaseObject.m_Abil.Level <= BaseObject.m_Abil.Level + 2 then
          begin
            if Random(3) = 0 then
            begin
              if Random((BaseObject.m_Abil.Level + 20) + (nMagicLevel * 5)) >
                (TargeTBaseObject.m_Abil.Level + g_Config.nMagTammingTargetLevel
                {10}) then
              begin
                if not (TargeTBaseObject.m_boNoTame) and
                  (TargeTBaseObject.m_btLifeAttrib <> LA_UNDEAD) and
                  (TargeTBaseObject.m_Abil.Level < g_Config.nMagTammingLevel
                    {50}) and
                  (BaseObject.m_SlaveList.Count < g_Config.nMagTammingCount
                    {(nMagicLevel + 2)}) then
                begin
                  n14 := TargeTBaseObject.m_WAbil.MaxHP div
                    g_Config.nMagTammingHPRate {100};
                  if n14 <= 2 then
                    n14 := 2
                  else
                    Inc(n14, n14);
                  if (TargeTBaseObject.m_Master2 <> BaseObject) and (Random(n14)
                    = 0) then
                  begin
                    TargeTBaseObject.BreakCrazyMode();
                    if TargeTBaseObject.m_Master2 <> nil then
                    begin
                      TargeTBaseObject.m_WAbil.HP := TargeTBaseObject.m_WAbil.HP
                        div 10;
                    end;
                    TargeTBaseObject.m_Master2 := BaseObject;
                    if BaseObject.m_AllMaster <> nil then
                      TargeTBaseObject.m_AllMaster := BaseObject.m_AllMaster
                    else
                      TargeTBaseObject.m_AllMaster := BaseObject;

                    //                  TargeTBaseObject.m_PEnvir.AddObject2(Self);
                    TargeTBaseObject.m_dwMasterRoyaltyTick :=
                      LongWord((Random(BaseObject.m_Abil.Level * 2) + (nMagicLevel
                      shl 2) * 5 + 20) * 60 * 1000) + GetTickCount;
                    TargeTBaseObject.m_btSlaveMakeLevel := nMagicLevel;
                    if TargeTBaseObject.m_dwMasterTick = 0 then
                      TargeTBaseObject.m_dwMasterTick := GetTickCount();
                    TargeTBaseObject.BreakHolySeizeMode();
                    if LongWord(1500 - nMagicLevel * 200) <
                      LongWord(TargeTBaseObject.m_nWalkSpeed) then
                    begin
                      TargeTBaseObject.m_nWalkSpeed := 1500 - nMagicLevel * 200;
                    end;
                    if LongWord(2000 - nMagicLevel * 200) <
                      LongWord(TargeTBaseObject.m_nNextHitTime) then
                    begin
                      TargeTBaseObject.m_nNextHitTime := 2000 - nMagicLevel *
                        200;
                    end;
                    TargeTBaseObject.RefShowName();
                    BaseObject.m_SlaveList.Add(TargeTBaseObject);
                  end
                  else
                  begin //004925F2
                    if Random(14) = 0 then
                      TargeTBaseObject.m_WAbil.HP := 0;
                  end;
                end
                else
                begin //00492615
                  if (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) and
                    (Random(20) = 0) then
                    TargeTBaseObject.m_WAbil.HP := 0;
                end;
              end
              else
              begin //00492641
                if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) and
                  (Random(20) = 0) then
                  TargeTBaseObject.OpenCrazyMode(Random(20) + 10);
              end;
            end
            else
            begin //00492674
              if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then
                TargeTBaseObject.OpenCrazyMode(Random(20) + 10); //变红
            end;
          end; //004926B0
        end
        else
        begin //00492699
          TargeTBaseObject.OpenHolySeizeMode((nMagicLevel * 5 + 10) * 1000);
        end;
        Result := True;
      end;
    end
    else
    begin
      if Random(2) = 0 then
        Result := True;
    end;

  except
    MainOutMessage('[Exception] TMagicManager.MagTamming');
  end;
end;

function TMagicManager.MagTurnUndead(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nLevel: Integer): Boolean; //004926D4
var
  n14: Integer;
begin
  try
    Result := False;
    if TargeTBaseObject.m_boSuperMan or not (TargeTBaseObject.m_btLifeAttrib =
      LA_UNDEAD) then
      exit;
    TAnimalObject(TargeTBaseObject).Struck {FFEC}(BaseObject);
    if TargeTBaseObject.m_TargetCret = nil then
    begin
      TAnimalObject(TargeTBaseObject).m_boRunAwayMode := True;
      TAnimalObject(TargeTBaseObject).m_dwRunAwayStart := GetTickCount();
      TAnimalObject(TargeTBaseObject).m_dwRunAwayTime := 10 * 1000;
    end;
    BaseObject.SetTargetCreat(TargeTBaseObject);
    if (Random(2) + (BaseObject.m_Abil.Level - 1)) >
      TargeTBaseObject.m_Abil.Level then
    begin
      if TargeTBaseObject.m_Abil.Level < g_Config.nMagTurnUndeadLevel then
      begin
        n14 := BaseObject.m_Abil.Level - TargeTBaseObject.m_Abil.Level;
        if Random(100) < ((nLevel shl 3) - nLevel + 15 + n14) then
        begin
          TargeTBaseObject.SetLastHiter(BaseObject);
          TargeTBaseObject.m_WAbil.HP := 0;
          Result := True;
        end
      end;
    end; //004927CB
  except
    MainOutMessage('[Exception] TMagicManager.MagTurnUndead');
  end;
end;

function TMagicManager.MagWindTebo(PlayObject: TBaseObject;
  UserMagic: pTUserMagic): Boolean;
var
  PoseBaseObject: TBaseObject;
begin
  try
    Result := False;
    PoseBaseObject := PlayObject.GetPoseCreate;
    if (PoseBaseObject <> nil) and
      (PoseBaseObject <> PlayObject) and
      (not PoseBaseObject.m_boDeath) and
      (not PoseBaseObject.m_boGhost) and
      (PlayObject.IsProperTarget(PoseBaseObject)) and
      (not PoseBaseObject.m_boStickMode) then
    begin
      if (abs(PlayObject.m_nCurrX - PoseBaseObject.m_nCurrX) <= 1) and
        (abs(PlayObject.m_nCurrY - PoseBaseObject.m_nCurrY) <= 1) and
        (PlayObject.m_Abil.Level > PoseBaseObject.m_Abil.Level) then
      begin
        if Random(20) < UserMagic.btLevel * 6 + 6 + (PlayObject.m_Abil.Level -
          PoseBaseObject.m_Abil.Level) then
        begin
          PoseBaseObject.CharPushed(GetNextDirection(PlayObject.m_nCurrX,
            PlayObject.m_nCurrY, PoseBaseObject.m_nCurrX,
            PoseBaseObject.m_nCurrY), _MAX(0, UserMagic.btLevel - 1) + 1);
          Result := True;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TMagicManager.MagWindTebo');
  end;
end;

function TMagicManager.MagSaceMove(BaseObject: TBaseObject;
  nLevel: integer): Boolean; //04927D8
var
  Envir: TEnvirnoment;
begin
  try
    Result := False;
    if Random(11) < nLevel * 2 + 4 then
    begin
      BaseObject.SendRefMsg(RM_SPACEMOVE_FIRE2, 0, 0, 0, 0, '');
      if BaseObject is TBaseObject then
      begin
        Envir := BaseObject.m_PEnvir;
        BaseObject.MapRandomMove(BaseObject.m_sHomeMap, 1);
        if (Envir <> BaseObject.m_PEnvir) and (BaseObject.m_btRaceServer =
          RC_PLAYOBJECT) then
        begin
          TPlayObject(BaseObject).m_boTimeRecall := False;
        end;
      end;
      Result := True;
    end; //00492899
  except
    MainOutMessage('[Exception] TMagicManager.MagSaceMove');
  end;
end;

function TMagicManager.MagGroupAmyounsul2(PlayObject: TBaseObject; MasterObject:
  TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  I, X, magpwr: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower, nPower2: Integer;
begin
  try
    Result := True;
    BaseObjectList := TList.Create;
    try
      MasterObject.GetMapBaseObjects(MasterObject.m_PEnvir, nTargetX, nTargetY,
        2, BaseObjectList);

      nPower := GetPower13(40, UserMagic) + GetRPow(MasterObject.m_WAbil.SC) *
        2;
      nPower2 := GetPower13(40, UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2;
      nPower := Round((nPower + nPower2) * 0.5);
      nPower := GetJointPower(nPower, PlayObject.m_HeroDanderCount,
        g_Config.nSkillTTPowerRate);

      for I := 0 to BaseObjectList.Count - 1 do
      begin
        BaseObject := TBaseObject(BaseObjectList.Items[I]);
        if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (MasterObject =
          BaseObject) then
          Continue;
        if MasterObject.IsProperTarget(BaseObject) then
        begin //001420
          //nPower:=GetPower13(40,UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2;
  //        magpwr:=nPower;
          X := Round(nPower * 0.1);
          magpwr := nPower - Round(X * 0.5) + Random(X);
          BaseObject.SendDelayMsg(MasterObject,
            RM_POISON,
            POISON_DECHEALTH {中毒类型 - 绿毒},
            magpwr,
            Integer(MasterObject),
            ROUND(UserMagic.btLevel / 3 * (magpwr / g_Config.nAmyOunsulPoint))
              {UserMagic.btLevel},
            '',
            1000);
          MasterObject.SetTargetCreat(BaseObject);
        end; //001420
      end; //end for
    finally
      BaseObjectList.Free;
    end;
  except
    MainOutMessage('[Exception] TMagicManager.MagGroupAmyounsul2');
  end;
end;

function TMagicManager.MagGroupAmyounsul(PlayObject: TBaseObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
  StdItem: TItem;
  nAmuletIdx: Integer;
  //  n199           :Integer;
begin
  try
    Result := False;
    BaseObjectList := TList.Create;
    PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY,
      _MAX(1, UserMagic.btLevel), BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do
    begin
      BaseObject := TBaseObject(BaseObjectList.Items[I]);
      if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject =
        BaseObject) then
        Continue;
      if PlayObject.IsProperTarget(BaseObject) then
      begin
        if CheckAmulet(PlayObject, 1, 2, nAmuletIdx) then
        begin
          if nAmuletIdx < 0 then
          begin
            if Random(BaseObject.m_btAntiPoison + 7) <= 6 then
            begin
              case nAmuletIdx of
                -1:
                  begin
                    nPower := GetPower13(40, UserMagic) +
                      GetRPow(PlayObject.m_WAbil.SC) * 2;
                    BaseObject.SendDelayMsg(PlayObject, RM_POISON,
                      POISON_DECHEALTH {中毒类型 - 绿毒}, nPower,
                      Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower /
                      g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                  end;
                -2:
                  begin
                    nPower := GetPower13(30, UserMagic) +
                      GetRPow(PlayObject.m_WAbil.SC) * 2;
                    BaseObject.SendDelayMsg(PlayObject, RM_POISON,
                      POISON_DAMAGEARMOR {中毒类型 - 红毒}, nPower,
                      Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower /
                      g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                  end;
              end;
              if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or
                (BaseObject.m_btRaceServer >= RC_ANIMAL) then
                Result := True;
            end;
            PlayObject.SetTargetCreat(BaseObject);
          end
          else
          begin
            StdItem := nil;
            if nAmuletIdx in [0..High(THumanUseItems)] then
            begin
              StdItem :=
                UserEngine.GetStdItem(PlayObject.m_UseItems[nAmuletIdx].wIndex);
            end
            else
            begin
              if PlayObject.m_HeroAttackAmuPorc <> nil then
                StdItem :=
                  UserEngine.GetStdItem(pTUserItem(PlayObject.m_HeroAttackAmuPorc).wIndex);
            end;
            if StdItem <> nil then
            begin
              UseAmulet(PlayObject, 1, 2, nAmuletIdx);
              if Random(BaseObject.m_btAntiPoison + 7) <= 6 then
              begin
                case StdItem.Shape of
                  1:
                    begin
                      nPower := GetPower13(40, UserMagic) +
                        GetRPow(PlayObject.m_WAbil.SC) * 2;
                      BaseObject.SendDelayMsg(PlayObject, RM_POISON,
                        POISON_DECHEALTH {中毒类型 - 绿毒}, nPower,
                        Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower
                        / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '',
                        1000);
                    end;
                  2:
                    begin
                      nPower := GetPower13(30, UserMagic) +
                        GetRPow(PlayObject.m_WAbil.SC) * 2;
                      BaseObject.SendDelayMsg(PlayObject, RM_POISON,
                        POISON_DAMAGEARMOR {中毒类型 - 红毒}, nPower,
                        Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower
                        / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '',
                        1000);
                    end;
                end;
                if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or
                  (BaseObject.m_btRaceServer >= RC_ANIMAL) then
                  Result := True;
                //BaseObject.SetLastHiter(PlayObject);
                //PlayObject.SetTargetCreat(BaseObject);
              end;
            end;
            PlayObject.SetTargetCreat(BaseObject);
          end;
        end;
      end;
    end;
    BaseObjectList.Free;
  except
    MainOutMessage('[Exception] TMagicManager.MagGroupAmyounsul');
  end;
end;

function TMagicManager.MagGroupDeDing(PlayObject: TBaseObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
begin
  try
    Result := False;
    BaseObjectList := TList.Create;
    PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY,
      _MAX(1, UserMagic.btLevel), BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do
    begin
      BaseObject := TBaseObject(BaseObjectList.Items[i]);
      if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject =
        BaseObject) then
        Continue;
      if PlayObject.IsProperTarget(BaseObject) then
      begin
        nPower := PlayObject.GetAttackPower(LoWord(PlayObject.m_WAbil.DC),
          SmallInt((HiWord(PlayObject.m_WAbil.DC) -
          LoWord(PlayObject.m_WAbil.DC))));
        if (Random(BaseObject.m_btSpeedPoint) >= PlayObject.m_btHitPoint) then
        begin
          nPower := 0;
        end;
        if nPower > 0 then
        begin
          nPower := BaseObject.GetHitStruckDamage(PlayObject, nPower);
        end;
        if nPower > 0 then
        begin //004C21FC
          BaseObject.StruckDamage(nPower, PlayObject);
          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower,
            MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 1,
            Integer(BaseObject), '', 200);
        end;
        if BaseObject.m_btRaceServer >= RC_ANIMAL then
          Result := True;
      end;
      PlayObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX,
        BaseObject.m_nCurrY, 1, '');
    end;
    BaseObjectList.Free;
  except
    MainOutMessage('[Exception] TMagicManager.MagGroupDeDing');
  end;
end;

function TMagicManager.MagGroupLightening(PlayObject: TBaseObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject; var boSpellFire: Boolean): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
begin
  try
    Result := False;
    boSpellFire := False;
    BaseObjectList := TList.Create;
    PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY,
      _MAX(1, UserMagic.btLevel), BaseObjectList);
    PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
      MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
      MakeLong(nTargetX, nTargetY),
      Integer(TargeTBaseObject),
      '');
    for I := 0 to BaseObjectList.Count - 1 do
    begin
      BaseObject := TBaseObject(BaseObjectList.Items[i]);
      if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject =
        BaseObject) then
        Continue;
      if PlayObject.IsProperTarget(BaseObject) then
      begin
        if (Random(10) >= BaseObject.m_nAntiMagic) then
        begin
          {if BaseObject<>TargeTBaseObject then
            PlayObject.SendRefMsg(RM_MAGICFIRE,0,
                                  MakeWord(UserMagic.MagicInfo.btEffectType,UserMagic.MagicInfo.btEffect),
                                  MakeLong(BaseObject.m_nCurrX,BaseObject.m_nCurrY),
                                  Integer(BaseObject),
                                  '');}
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic),
            UserMagic) + LoWord(PlayObject.m_WAbil.MC),
            SmallInt(HiWord(PlayObject.m_WAbil.MC) -
              LoWord(PlayObject.m_WAbil.MC)) + 1);
          if BaseObject.m_btLifeAttrib = LA_UNDEAD then
            nPower := ROUND(nPower * 1.5);

          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower,
            MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2,
            Integer(BaseObject), '', 600);
          if BaseObject.m_btRaceServer >= RC_ANIMAL then
            Result := True;
        end;
        if (BaseObject.m_nCurrX <> nTargetX) or (BaseObject.m_nCurrY <> nTargetY)
          then
          PlayObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX,
            BaseObject.m_nCurrY, 4 {type}, '');
      end;
    end;
    BaseObjectList.Free;
  except
    MainOutMessage('[Exception] TMagicManager.MagGroupLightening');
  end;
end;

function TMagicManager.MagHbFireBall(PlayObject: TBaseObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargetBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
  nDir: Integer;
  levelgap: Integer;
  push: Integer;
begin
  try
    Result := False;
    if not PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY,
      TargetBaseObject) then
    begin
      TargeTBaseObject := nil;
      exit;
    end;
    if not PlayObject.IsProperTarget(TargeTBaseObject) then
    begin
      TargeTBaseObject := nil;
      exit;
    end;
    if (TargeTBaseObject.m_nAntiMagic > Random(10)) or
      (abs(TargeTBaseObject.m_nCurrX - nTargetX) > 1) or
      (abs(TargeTBaseObject.m_nCurrY - nTargetY) > 1) then
    begin
      TargeTBaseObject := nil;
      exit;
    end;
    with PlayObject do
    begin
      nPower := GetAttackPower(GetPower(MPow(UserMagic), UserMagic) +
        LoWord(m_WAbil.MC),
        SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
    end;
    PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower,
      MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
    if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
      Result := True;

    if (PlayObject.m_Abil.Level > TargetBaseObject.m_Abil.Level) and (not
      TargetBaseObject.m_boStickMode) then
    begin
      levelgap := PlayObject.m_Abil.Level - TargetBaseObject.m_Abil.Level;
      if (Random(20) < 6 + UserMagic.btLevel * 3 + levelgap) then
      begin
        push := Random(UserMagic.btLevel) - 1;
        if push > 0 then
        begin
          nDir := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY,
            TargetBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY);
          PlayObject.SendDelayMsg(PlayObject, RM_DELAYPUSHED, nDir,
            MakeLong(nTargetX, nTargetY), push, Integer(TargeTBaseObject), '',
            600);
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TMagicManager.MagHbFireBall');
  end;
end;

//火墙

function TMagicManager.MagMakeFireCross(PlayObject: TBaseObject; nDamage,
  nHTime, nX, nY: Integer): Integer; //00492C9C
var
  FireBurnEvent: TFireBurnEvent;
resourcestring
  sDisableInSafeZoneFireCross = '安全区不允许使用...';
begin
  try
    Result := 0;
    if g_Config.boDisableInSafeZoneFireCross and
      PlayObject.InSafeZone(PlayObject.m_PEnvir, nX, nY) then
    begin
      PlayObject.SysMsg(sDisableInSafeZoneFireCross, c_Red, t_Notice);
      exit;
    end;
    if PlayObject.m_PEnvir.GetEvent(nX, nY - 1) = nil then
    begin
      FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY - 1, ET_FIRE,
        nHTime * 1000, nDamage);
      g_EventManager.AddEvent(FireBurnEvent);
    end; //0492CFC   x
    if PlayObject.m_PEnvir.GetEvent(nX - 1, nY) = nil then
    begin
      FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX - 1, nY, ET_FIRE,
        nHTime * 1000, nDamage);
      g_EventManager.AddEvent(FireBurnEvent);
    end; //0492D4D
    if PlayObject.m_PEnvir.GetEvent(nX, nY) = nil then
    begin
      FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, ET_FIRE, nHTime
        * 1000, nDamage);
      g_EventManager.AddEvent(FireBurnEvent);
    end; //00492D9C
    if PlayObject.m_PEnvir.GetEvent(nX + 1, nY) = nil then
    begin
      FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX + 1, nY, ET_FIRE,
        nHTime * 1000, nDamage);
      g_EventManager.AddEvent(FireBurnEvent);
    end; //00492DED
    if PlayObject.m_PEnvir.GetEvent(nX, nY + 1) = nil then
    begin
      FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY + 1, ET_FIRE,
        nHTime * 1000, nDamage);
      g_EventManager.AddEvent(FireBurnEvent);
    end; //00492E3E
    Result := 1;
  except
    MainOutMessage('[Exception] TMagicManager.MagMakeFireCross');
  end;
end;

function TMagicManager.MagBigExplosionEx(BaseObject: TBaseObject; nPower, nX,
  nY: Integer; nRage: Integer): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  try
    Result := False;
    BaseObjectList := TList.Create;
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage,
      BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do
    begin
      TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
      if BaseObject.IsProperTarget(TargeTBaseObject) then
      begin
        BaseObject.SetTargetCreat(TargeTBaseObject);
        TargeTBaseObject.SendDelayMsg(BaseObject, RM_MAGSTRUCK, 0, nPower, 0, 0,
          '', 2000);
        Result := True;
      end;
    end;
    BaseObjectList.Free;
  except
    MainOutMessage('[Exception] TMagicManager.MagBigExplosion');
  end;
end;

function TMagicManager.MagBigExplosion(BaseObject: TBaseObject; nPower, nX,
  nY: Integer; nRage: Integer): Boolean; //00492F4C
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  try
    Result := False;
    BaseObjectList := TList.Create;
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage,
      BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do
    begin
      TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
      if BaseObject.IsProperTarget(TargeTBaseObject) then
      begin
        BaseObject.SetTargetCreat(TargeTBaseObject);
        TargeTBaseObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
        Result := True;
      end;
    end;
    BaseObjectList.Free;
  except
    MainOutMessage('[Exception] TMagicManager.MagBigExplosion');
  end;
end;

function TMagicManager.MagElecBlizzard(BaseObject: TBaseObject;
  nPower: integer): Boolean; //00493010
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  nPowerPoint: Integer;
begin
  try
    Result := False;
    BaseObjectList := TList.Create;
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, BaseObject.m_nCurrX,
      BaseObject.m_nCurrY, g_Config.nElecBlizzardRange {2}, BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do
    begin
      TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
      if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then
      begin
        nPowerPoint := nPower div 10;
      end
      else
        nPowerPoint := nPower;

      if BaseObject.IsProperTarget(TargeTBaseObject) then
      begin
        //BaseObject.SetTargetCreat(TargeTBaseObject);
        TargeTBaseObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPowerPoint, 0, 0,
          '');
        Result := True;
      end;
    end;
    BaseObjectList.Free;
  except
    MainOutMessage('[Exception] TMagicManager.MagElecBlizzard');
  end;
end;

//捆魔咒

function TMagicManager.MagMakeHolyCurtain(BaseObject: TBaseObject; nPower:
  Integer; nX, nY: Integer): Integer; //004928C0
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  MagicEvent: pTMagicEvent;
  HolyCurtainEvent: THolyCurtainEvent;
begin
  try
    Result := 0;
    if BaseObject.m_PEnvir.CanWalk(nX, nY, True) then
    begin
      BaseObjectList := TList.Create;
      MagicEvent := nil;
      BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, 1,
        BaseObjectList);
      for I := 0 to BaseObjectList.Count - 1 do
      begin
        TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
        if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) and
          ((Random(4) + (BaseObject.m_Abil.Level - 1)) >
            TargeTBaseObject.m_Abil.Level) and
          {(TargeTBaseObject.m_Abil.Level < 50) and}
        ((TargeTBaseObject.m_AllMaster = nil) or
          ((TargeTBaseObject.m_AllMaster <> nil) and
            (TargeTBaseObject.m_AllMaster.m_btRaceServer <> RC_PLAYOBJECT))) then
        begin
          TargeTBaseObject.OpenHolySeizeMode(nPower * 1000);
          if MagicEvent = nil then
          begin
            New(MagicEvent);
            FillChar(MagicEvent^, SizeOf(TMagicEvent), #0);
            MagicEvent.BaseObjectList := TList.Create;
            MagicEvent.dwStartTick := GetTickCount();
            MagicEvent.dwTime := nPower * 1000;
          end;
          MagicEvent.BaseObjectList.Add(TargeTBaseObject);
          Inc(Result);
        end
        else
        begin //00492A02
          Result := 0;
        end;
      end;
      BaseObjectList.Free;
      if (Result > 0) and (MagicEvent <> nil) then
      begin
        HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX -
          1, nY - 2, ET_HOLYCURTAIN, nPower * 1000);
        g_EventManager.AddEvent(HolyCurtainEvent);
        MagicEvent.Events[0] := HolyCurtainEvent;
        HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX +
          1, nY - 2, ET_HOLYCURTAIN, nPower * 1000);
        g_EventManager.AddEvent(HolyCurtainEvent);
        MagicEvent.Events[1] := HolyCurtainEvent;
        HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX -
          2, nY - 1, ET_HOLYCURTAIN, nPower * 1000);
        g_EventManager.AddEvent(HolyCurtainEvent);
        MagicEvent.Events[2] := HolyCurtainEvent;
        HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX +
          2, nY - 1, ET_HOLYCURTAIN, nPower * 1000);
        g_EventManager.AddEvent(HolyCurtainEvent);
        MagicEvent.Events[3] := HolyCurtainEvent;
        HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX -
          2, nY + 1, ET_HOLYCURTAIN, nPower * 1000);
        g_EventManager.AddEvent(HolyCurtainEvent);
        MagicEvent.Events[4] := HolyCurtainEvent;
        HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX +
          2, nY + 1, ET_HOLYCURTAIN, nPower * 1000);
        g_EventManager.AddEvent(HolyCurtainEvent);
        MagicEvent.Events[5] := HolyCurtainEvent;
        HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX -
          1, nY + 2, ET_HOLYCURTAIN, nPower * 1000);
        g_EventManager.AddEvent(HolyCurtainEvent);
        MagicEvent.Events[6] := HolyCurtainEvent;
        HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX +
          1, nY + 2, ET_HOLYCURTAIN, nPower * 1000);
        g_EventManager.AddEvent(HolyCurtainEvent);
        MagicEvent.Events[7] := HolyCurtainEvent;
        UserEngine.m_MagicEventList.Add(MagicEvent);
      end
      else
      begin
        if MagicEvent <> nil then
        begin
          MagicEvent.BaseObjectList.Free;
          Dispose(MagicEvent);
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TMagicManager.MagMakeHolyCurtain');
  end;
end;

function TMagicManager.MagMakeGroupTransparent(BaseObject: TBaseObject; nX, nY,
  nHTime: Integer): Boolean; //0049320C
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  try
    Result := False;
    BaseObjectList := TList.Create;
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, 1,
      BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do
    begin
      TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
      if BaseObject.IsProperFriend(TargeTBaseObject) then
      begin
        if TargeTBaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] = 0 then
        begin //00493287
          TargeTBaseObject.SendDelayMsg(TargeTBaseObject, RM_TRANSPARENT, 0,
            nHTime, 0, 0, '', 800);
          Result := True;
        end;
      end
    end;
    BaseObjectList.Free;
  except
    MainOutMessage('[Exception] TMagicManager.MagMakeGroupTransparent');
  end;
end;
//=====================================================================================
//名称：
//功能：
//参数：
//     BaseObject       魔法发起人
//     TargeTBaseObject 受攻击角色
//     nPower           魔法力大小
//     nLevel           技能修炼等级
//     nTargetX         目标座标X
//     nTargetY         目标座标Y
//返回值：
//=====================================================================================

function TMagicManager.MabMabe(BaseObject, TargeTBaseObject: TBaseObject;
  nPower, nLevel,
  nTargetX, nTargetY: Integer): Boolean;
var
  nLv: Integer;
begin
  try
    Result := False;
    if BaseObject.MagCanHitTarget(BaseObject.m_nCurrX, BaseObject.m_nCurrY,
      TargeTBaseObject) then
    begin
      if BaseObject.IsProperTarget(TargeTBaseObject) then
      begin
        if (TargeTBaseObject.m_nAntiMagic <= Random(10)) and
          (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and
          (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then
        begin
          BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower div 3,
            MakeLong(nTargetX, nTargetY), 2, integer(TargeTBaseObject), '', 600);
          if (Random(2) + (BaseObject.m_Abil.Level - 1)) >
            TargeTBaseObject.m_Abil.Level then
          begin
            nLv := BaseObject.m_Abil.Level - TargeTBaseObject.m_Abil.Level;
            if (Random(g_Config.nMabMabeHitRandRate {100}) <
              _MAX(g_Config.nMabMabeHitMinLvLimit, (nLevel * 8) - nLevel + 15 +
              nLv)) {or (Random(abs(nLv))} then
            begin
              // if (Random(100) < ((nLevel shl 3) - nLevel + 15 + nLv)) {or (Random(abs(nLv))} then begin
              if (Random(g_Config.nMabMabeHitSucessRate {21}) < nLevel * 2 + 4)
                then
              begin
                if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then
                begin
                  BaseObject.SetPKFlag(BaseObject);
                  BaseObject.SetTargetCreat(TargeTBaseObject);
                end;
                TargeTBaseObject.SetLastHiter(BaseObject);
                nPower := TargeTBaseObject.GetMagStruckDamage(BaseObject,
                  nPower);
                BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower,
                  MakeLong(nTargetX, nTargetY), 2, integer(TargeTBaseObject), '',
                  600);
                if not TargeTBaseObject.m_boUnParalysis then
                  TargeTBaseObject.SendDelayMsg(BaseObject, RM_POISON,
                    POISON_STONE {中毒类型 - 麻痹}, nPower div
                    g_Config.nMabMabeHitMabeTimeRate {20} + Random(nLevel),
                    Integer(BaseObject), nLevel, '', 650);
                Result := True;
              end;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TMagicManager.MabMabe');
  end;
end;

function TMagicManager.MagMakeSinSuSlave(PlayObject: TBaseObject;
  UserMagic: pTUserMagic): Boolean;
var
  I: Integer;
  sMonName: string;
  nMakelevel, nExpLevel: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
begin
  try
    Result := False;
    if not PlayObject.sub_4DD704 then
    begin
      if UserMagic.wMagIdx = SKILL_72 then
      begin
        sMonName := g_Config.sFairy;
        nMakelevel := UserMagic.btLevel;
        nExpLevel := UserMagic.btLevel;
        nCount := g_Config.nFairyCount;
        dwRoyaltySec := 30 * 24 * 60 * 60;
        for I := Low(g_Config.FairyArray) to High(g_Config.FairyArray) do
        begin
          if g_Config.FairyArray[I].nHumLevel = 0 then
            break;
          if PlayObject.m_Abil.Level >= g_Config.FairyArray[I].nHumLevel then
          begin
            sMonName := g_Config.FairyArray[I].sMonName;
            nExpLevel := g_Config.FairyArray[I].nLevel;
            nCount := g_Config.FairyArray[I].nCount;
          end;
        end;

        if PlayObject.MakeSlave(sMonName, nMakelevel, nExpLevel, nCount,
          dwRoyaltySec) <> nil then
          Result := True
        else
          PlayObject.RecallSlave(sMonName);
      end
      else
      begin
        sMonName := g_Config.sDragon;
        nMakelevel := UserMagic.btLevel;
        nExpLevel := UserMagic.btLevel;
        nCount := g_Config.nDragonCount;
        dwRoyaltySec := 30 * 24 * 60 * 60;
        for I := Low(g_Config.DragonArray) to High(g_Config.DragonArray) do
        begin
          if g_Config.DragonArray[I].nHumLevel = 0 then
            break;
          if PlayObject.m_Abil.Level >= g_Config.DragonArray[I].nHumLevel then
          begin
            sMonName := g_Config.DragonArray[I].sMonName;
            nExpLevel := g_Config.DragonArray[I].nLevel;
            nCount := g_Config.DragonArray[I].nCount;
          end;
        end;

        if PlayObject.MakeSlave(sMonName, nMakelevel, nExpLevel, nCount,
          dwRoyaltySec) <> nil then
          Result := True
        else
          PlayObject.RecallSlave(sMonName);
      end;
    end;
    //          if PlayObject.MakeSlave(g_Config.sDogz,UserMagic.btLevel,1,10 * 24 * 60 * 60) <> nil then
    //            boTrain:=True;
  except
    MainOutMessage('[Exception] TMagicManager.MagMakeSinSuSlave');
  end;
end;

function TMagicManager.MagMakeSlave(PlayObject: TBaseObject; UserMagic:
  pTUserMagic): Boolean;
var
  I: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
begin
  try
    Result := False;
    if not PlayObject.sub_4DD704 then
    begin
      sMonName := g_Config.sSkeleton;
      nMakeLevel := UserMagic.btLevel;
      nExpLevel := UserMagic.btLevel;
      nCount := g_Config.nSkeletonCount;
      dwRoyaltySec := 30 * 24 * 60 * 60;
      for I := Low(g_Config.SkeletonArray) to High(g_Config.SkeletonArray) do
      begin
        if g_Config.SkeletonArray[I].nHumLevel = 0 then
          break;
        if PlayObject.m_Abil.Level >= g_Config.SkeletonArray[I].nHumLevel then
        begin
          sMonName := g_Config.SkeletonArray[I].sMonName;
          nExpLevel := g_Config.SkeletonArray[I].nLevel;
          nCount := g_Config.SkeletonArray[I].nCount;
        end;
      end;

      if PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, nCount,
        dwRoyaltySec) <> nil then
        Result := True;
    end;
  except
    MainOutMessage('[Exception] TMagicManager.MagMakeSlave');
  end;
end;

function TMagicManager.MagMakeClone(PlayObject: TBaseObject; UserMagic:
  pTUserMagic): Boolean;
//var
  {I: Integer;
  sMonName:String;
  nMakeLevel,nExpLevel:Integer;
  nCount:Integer;
  dwRoyaltySec:LongWord;}
  //PlayClone:TPlayCloneObject;
var
  nTargetX, nTargetY: Integer;
  MonObj: TBaseObject;
  Time: Integer;
begin
  try
    Result := False;

    if PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX,
      PlayObject.m_nCurrY, PlayObject.m_btDirection, 4, nTargetX, nTargetY) then
    begin
      if PlayObject.m_Clone = nil then
      begin
        if (GetTickCount - PlayObject.m_CallCloneTick) > g_Config.nCallCloneTime
          then
        begin
          PlayObject.m_CallCloneTick := GetTickCount;
          MonObj := UserEngine.RegenMonsterByName(PlayObject.m_PEnvir.sMapName,
            nTargetX, nTargetY, g_Config.sPlayCloneName, PlayObject, True);
          if MonObj <> nil then
          begin
            PlayObject.m_Clone := MonObj;
            MonObj.m_Master2 := PlayObject;
            if PlayObject.m_AllMaster <> nil then
              MonObj.m_AllMaster := PlayObject.m_AllMaster
            else
              MonObj.m_AllMaster := PlayObject;
            MonObj.m_CloneHum := PlayObject;
            MonObj.m_dwMasterRoyaltyTick := GetTickCount + 24 * 60 * 60 * 1000;
            MonObj.m_btSlaveMakeLevel := 0;
            MonObj.m_btSlaveExpLevel := 0;
            MonObj.RecalcAbilitys;
            {if MonObj.m_WAbil.HP < MonObj.m_WAbil.MaxHP then begin
              MonObj.m_WAbil.HP := MonObj.m_WAbil.HP + (MonObj.m_WAbil.MaxHP - MonObj.m_WAbil.HP) div 2;
            end;}
            MonObj.RefNameColor;
            //m_SlaveList.Add (MonObj);
            Result := True;
          end;
        end
        else
        begin
          Time := (g_Config.nCallCloneTime - (GetTickCount -
            PlayObject.m_CallCloneTick)) div 1000;
          PlayObject.SysMsg(Format(sMagicDeDingTime, [_MAX(Time, 1)]), c_Red,
            t_Hint);
        end;
      end
      else if not PlayObject.m_Clone.m_boDeath then
        PlayObject.m_Clone.SpaceMove(PlayObject.m_PEnvir.sMapName, nTargetX,
          nTargetY, 1);
    end;

    {if not PlayObject.sub_4DD704 then begin
     sMonName:=g_Config.sSkeleton;
     nMakeLevel:=UserMagic.btLevel;
     nExpLevel:=UserMagic.btLevel;
     nCount:=g_Config.nSkeletonCount;
     dwRoyaltySec:=10 * 24 * 60 * 60;
     for I := Low(g_Config.SkeletonArray) to High(g_Config.SkeletonArray) do begin
       if g_Config.SkeletonArray[I].nHumLevel = 0 then break;
       if PlayObject.m_Abil.Level >= g_Config.SkeletonArray[I].nHumLevel then begin
         sMonName:=g_Config.SkeletonArray[I].sMonName;
         nExpLevel:=g_Config.SkeletonArray[I].nLevel;
         nCount:=g_Config.SkeletonArray[I].nCount;
       end;
     end;}

     //PlayClone := TPlayCloneObject.Create(PlayObject);
    Result := True;
  except
    MainOutMessage('[Exception] TMagicManager.MagMakeClone');
  end;
end;

function TMagicManager.MagMakeAngelSlave(PlayObject: TBaseObject; UserMagic:
  pTUserMagic): Boolean;
var
  //  I: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel: Integer;
  dwRoyaltySec: LongWord;
begin
  try
    Result := False;
    if not PlayObject.sub_4DD704 then
    begin
      sMonName := g_Config.sAngel;
      nMakeLevel := UserMagic.btLevel;
      nExpLevel := UserMagic.btLevel;
      //nCount:=g_Config.nSkeletonCount;
      dwRoyaltySec := 30 * 24 * 60 * 60;

      if PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, 1, dwRoyaltySec)
        <> nil then
        Result := True;
    end;
  except
    MainOutMessage('[Exception] TMagicManager.MagMakeAngelSlave');
  end;
end;

//狮子吼

function TMagicManager.MagGroupMb(PlayObject: TBaseObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  //  nPower         :Integer;
  //  StdItem        :pTStdItem;
  nTime: Integer;
begin
  try
    Result := False;
    BaseObjectList := TList.Create;
    nTime := 5 * UserMagic.btLevel + 1;
    PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, PlayObject.m_nCurrX,
      PlayObject.m_nCurrY, UserMagic.btLevel + 2, BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do
    begin
      BaseObject := TBaseObject(BaseObjectList.Items[I]);
      if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject =
        BaseObject) then
        Continue;
      if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and (not
        g_Config.boGroupMbAttackPlayObject) and (not BaseObject.m_boHero) then
        Continue;
      if (BaseObject.m_AllMaster <> nil) and
        (BaseObject.m_AllMaster.m_btRaceServer = RC_PLAYOBJECT) and (not
        g_Config.boGroupMbAttackMonObject) then
        Continue;
      if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and (BaseObject.m_boHero)
        and (not g_Config.boGroupMbAttackHeroObject) then
        Continue;
      if PlayObject.IsProperTarget(BaseObject) then
      begin
        if not BaseObject.m_boUnParalysis and (Random(BaseObject.m_btAntiPoison)
          = 0) then
        begin
          if (BaseObject.m_Abil.Level < PlayObject.m_Abil.Level) or
            (Random(PlayObject.m_Abil.Level - BaseObject.m_Abil.Level) = 0) then
          begin
            BaseObject.MakePosion(POISON_STONE, nTime, 0);
            BaseObject.m_boFastParalysis := True;
          end;
        end;
      end;
      if (BaseObject.m_btRaceServer >= RC_ANIMAL) then
        Result := True;
    end;
    BaseObjectList.Free;
  except
    MainOutMessage('[Exception] TMagicManager.MagGroupMb');
  end;
end;

function TMagicManager.KnockBack(PlayObject: TBaseObject; nPushLevel: integer):
  integer; //00492204
var
  i, nDir, {levelgap,} push: integer;
  BaseObject: TBaseObject;
  //   UserMagic:pTUsermagic;
begin
  try
    Result := 0;
    for i := 0 to PlayObject.m_VisibleActors.Count - 1 do
    begin
      BaseObject :=
        TBaseObject(pTVisibleBaseObject(PlayObject.m_VisibleActors[i]).BaseObject);
      if (abs(PlayObject.m_nCurrX - BaseObject.m_nCurrX) <= 1) and
        (abs(PlayObject.m_nCurrY - BaseObject.m_nCurrY) <= 1) then
      begin
        if (not BaseObject.m_boDeath) and (BaseObject <> PlayObject) then
        begin
          if (PlayObject.m_Abil.Level > BaseObject.m_Abil.Level) and (not
            BaseObject.m_boStickMode) then
          begin
            // levelgap := PlayObject.m_Abil.Level - BaseObject.m_Abil.Level;
            // if (Random(20) < 6 + nPushLevel * 3 + levelgap) then begin
            if Random(20) < ((nPushLevel * 4) + 6) then
            begin
              if PlayObject.IsProperTarget(BaseObject) then
              begin
                push := nPushLevel + 2;
                nDir := GetNextDirection(PlayObject.m_nCurrX,
                  PlayObject.m_nCurrY, BaseObject.m_nCurrX, BaseObject.m_nCurrY);
                BaseObject.CharPushed(nDir, push);
                Inc(Result);
              end;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TMagicManager.KnockBack');
  end;
end;

function TMagicManager.FlameField(BaseObject: TBaseObject; nPower, nX, nY:
  Integer; nRage: Integer): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  try
    Result := False;
    BaseObjectList := TList.Create;
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage,
      BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do
    begin
      TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
      if BaseObject.IsProperTarget(TargeTBaseObject) then
      begin
        BaseObject.SetTargetCreat(TargeTBaseObject);
        TargeTBaseObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
        Result := True;
      end;
    end;
    BaseObjectList.Free;
  except
    MainOutMessage('[Exception] TMagicManager.FlameField');
  end;
end;

end.

