//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit ObjMon4;

interface
uses
  Windows, SysUtils, Classes, Grobal2, ObjBase, ObjMon, Envir;

type
  TPsycheMonster = class(TAnimalObject)
    m_nAttackRange: Integer;
    m_dwThinkTick: LongWord; //0x550
    m_boDupMode: Boolean; //0x555
  private
    procedure FlyAttack(Target: TBaseObject);
    function Think(): Boolean; //004A8E54
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    function AttackTarget: Boolean;
    procedure RecalcAbilitys(); override;
  end;

  TEvilGuardUnit = class(TAnimalObject)
    m_TargetBaseObject: TBaseObject;
  private
    procedure sub_4A6B30(TargeTBaseObject: TBaseObject);
  public
    constructor Create(); override;
    function IsProperTarget(BaseObject: TBaseObject): boolean; override; //FFF4
    procedure Run; override;
    function GetShowName(): string; override;
  end;

  TEvilMonUnit = class(TAnimalObject)
  public
    constructor Create(); override;
    procedure Run; override;
    function GetShowName(): string; override;
    procedure Die(); override;
    procedure MakeGhost; override;
  end;

  TMissionMonUnit = class(TAnimalObject)
    m_dwThinkTick: LongWord;
    m_boDupMode: Boolean;
  public
    constructor Create(); override;
    procedure Run; override;
    procedure MoveTo(Envir: TEnvirnoment; nDMapX, nDMapY: Integer);
    function Think(): Boolean; //004A8E54
    //function  GetShowName():String;override;
    //procedure Die();override;
    //procedure MakeGhost;override;
  end;

implementation
uses M2Share, Hutil32;

constructor TMissionMonUnit.Create();
begin
  inherited;
  m_boDupMode := False;
  m_dwThinkTick := GetTickCount();
end;

procedure TMissionMonUnit.MoveTo(Envir: TEnvirnoment; nDMapX, nDMapY: Integer);
begin
  try
    if (m_Master2 <> nil) and
      not m_boGhost and
      not m_boDeath and
      (Envir = m_PEnvir) and
      (m_Master2.m_PEnvir <> m_PEnvir) and
      (abs(nDMapX - m_nCurrX) < m_Abil.MaxMP) and
      (abs(nDMapY - m_nCurrY) < m_Abil.MaxMP) then
    begin
      SpaceMove(m_Master2.m_PEnvir.sMapName, m_Master2.m_nCurrX,
        m_Master2.m_nCurrY, 1);
    end;
  except
    MainOutMessage('[Exception] TMissionMonUnit.MoveTo');
  end;
end;

function TMissionMonUnit.Think(): Boolean; //004A8E54
var
  nOldX, nOldY: integer;
begin
  try
    Result := False;
    if (GetTickCount - m_dwThinkTick) > 3 * 1000 then
    begin
      m_dwThinkTick := GetTickCount();
      if m_PEnvir.GetXYObjCount(m_nCurrX, m_nCurrY) >= 2 then
        m_boDupMode := True;
    end;
    if m_boDupMode then
    begin
      nOldX := m_nCurrX;
      nOldY := m_nCurrY;
      WalkTo(Random(8), False);
      if (nOldX <> m_nCurrX) or (nOldY <> m_nCurrY) then
      begin
        m_boDupMode := False;
        Result := True;
      end;
    end;
  except
    MainOutMessage('[Exception] TMissionMonUnit.Think');
  end;
end;

procedure TMissionMonUnit.Run;
var
  nX, nY: Integer;
begin
  try
    if (m_Master2 <> nil) and
      not m_boGhost and
      not m_boDeath and
      not m_boFixedHideMode and
      not m_boStoneMode and
      (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
    begin
      if Think then
      begin //检测是否重叠，重叠则随机移动一格
        inherited;
        exit;
      end;
      if m_boWalkWaitLocked then
      begin
        if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then
        begin
          m_boWalkWaitLocked := False;
        end;
      end;
      if not m_boWalkWaitLocked and (Integer(GetTickCount - m_dwWalkTick) >
        m_nWalkSpeed) then
      begin
        m_dwWalkTick := GetTickCount();
        Inc(m_nWalkCount);
        if m_nWalkCount > m_nWalkStep then
        begin
          m_nWalkCount := 0;
          m_boWalkWaitLocked := True;
          m_dwWalkWaitTick := GetTickCount();
        end; //004A9151
        if (m_Master2.m_PEnvir = m_PEnvir) and
          (abs(m_Master2.m_nCurrX - m_nCurrX) < m_Abil.MaxMP) and
          (abs(m_Master2.m_nCurrY - m_nCurrY) < m_Abil.MaxMP) then
        begin
          m_nTargetX := -1;
          m_Master2.GetBackPosition(nX, nY);
          if (abs(m_nCurrX - nX) > 1) or (abs(m_nCurrY - nY {nX}) > 1) then
          begin //004A922D
            m_nTargetX := nX;
            m_nTargetY := nY;
            GotoTargetXY();
          end;
        end;
      end;
    end;
    inherited;
  except
    MainOutMessage('[Exception] TMissionMonUnit.Run');
  end;
end;

constructor TEvilMonUnit.Create();
begin
  inherited;
end;

procedure TEvilMonUnit.Run;
var
  n14: Byte;
begin
  try
    if m_boMission then
    begin
      m_nTargetX := m_nMissionX;
      m_nTargetY := m_nMissionY;
      if Integer(GetTickCount - m_dwHitTick) >= m_nNextHitTime then
      begin
        m_dwHitTick := GetTickCount();
        GotoTargetXY();
      end;
    end
    else {// else MakeGhost;} if m_MissIonEx then
      begin
        if Integer(GetTickCount - m_dwHitTick) >= m_nNextHitTime then
        begin
          m_dwHitTick := GetTickCount();
          GetMissionXY(m_nTargetX, m_nTargetY);
          if m_nTargetY > -1 then
          begin
            n14 := GetNextDirection(m_nCurrX, m_nCurrY, m_nTargetX, m_nTargetY);
            WalkTo(n14, False);
            //GotoTargetXY();
          end
          else
            MakeGhost;
        end;
      end;
    inherited;
  except
    MainOutMessage('[Exception] TEvilMonUnit.Run');
  end;
end;

function TEvilMonUnit.GetShowName(): string;
var
  sShowName: string;
begin
  try
    sShowName := m_sCharName;
    Result := FilterShowName(sShowName);
    m_OldShowName := Result;
    m_NewShowName := Result;
  except
    MainOutMessage('[Exception] TEvilMonUnit.GetShowName');
  end;
end;

procedure TEvilMonUnit.Die();
begin
  try
    if m_MissIonEx then
    begin
      if m_ExpHitter <> nil then
      begin
        ScatterBagItems(m_ExpHitter);
      end
      else if m_LastHiter <> nil then
      begin
        ScatterBagItems(m_LastHiter);
      end
      else if m_Master2 <> nil then
      begin
        ScatterBagItems(m_Master2);
      end;
      m_Master2.NpcGotoLable(g_FunctionNPC, '@KillMissionMob', False);
    end;
    inherited;
  except
    MainOutMessage('[Exception] TEvilMonUnit.Die');
  end;
  //
end;

procedure TEvilMonUnit.MakeGhost;
begin
  try
    if (m_Master2 <> nil) and (m_MissIonEx) then
    begin
      if Random(m_btCoolEye) = 0 then
      begin
        if m_ExpHitter <> nil then
        begin
          ScatterBagItems(m_ExpHitter);
        end
        else if m_LastHiter <> nil then
        begin
          ScatterBagItems(m_LastHiter);
        end
        else if m_Master2 <> nil then
        begin
          ScatterBagItems(m_Master2);
        end;
      end;
    end;
    inherited;
  except
    MainOutMessage('[Exception] TEvilMonUnit.MakeGhost');
  end;
end;

//TEvilGuardUnit

constructor TEvilGuardUnit.Create();
begin
  inherited;
  m_nViewRange := 5;
  m_boRun := True;
  m_TargetBaseObject := nil;
end;

function TEvilGuardUnit.IsProperTarget(BaseObject: TBaseObject): boolean;
begin
  Result := BaseObject.m_MissIonEx;
  if (BaseObject.m_btRaceServer >= RC_ANIMAL) and
    (BaseObject.m_Master2 = nil) then
  begin
    Result := True;
  end;
end;

function TEvilGuardUnit.GetShowName(): string;
var
  sShowName: string;
begin
  try
    sShowName := m_sCharName;
    Result := FilterShowName(sShowName);
    m_OldShowName := Result;
    m_NewShowName := Result;
  except
    MainOutMessage('[Exception] TEvilGuardUnit.GetShowName');
  end;
end;

procedure TEvilGuardUnit.Run;
var
  I: integer;
  BaseObject: TBaseObject;
  //  nAbs             :Integer;
  nCheck: Integer;
  nRage: Integer;
begin
  try
    m_nViewRange := m_btCoolEye;
    nCheck := 999;
    if not m_boDeath and
      not m_boGhost then
    begin
      if Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed then
      begin
        m_dwWalkTick := GetTickCount();
        if (m_TargetBaseObject = nil) or
          (m_TargetBaseObject.m_boGhost) or
          (m_TargetBaseObject.m_boDeath) or
          (m_PEnvir <> m_TargetBaseObject.m_PEnvir) or
          (abs(m_nCurrX - m_TargetBaseObject.m_nCurrX) > m_nViewRange) or
          (abs(m_nCurrY - m_TargetBaseObject.m_nCurrY) > m_nViewRange) then
        begin
          m_TargetBaseObject := nil;
          for I := m_VisibleActors.Count - 1 downto 0 do
          begin
            BaseObject :=
              TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
            if BaseObject.m_boDeath then
              Continue;
            if IsProperTarget(BaseObject) and
              (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_nViewRange) and
              (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_nViewRange) then
            begin
              nRage := (abs(m_nCurrX - BaseObject.m_nCurrX)) + (abs(m_nCurrY -
                BaseObject.m_nCurrY));
              if nRage < nCheck then
              begin
                m_TargetBaseObject := BaseObject;
                nCheck := nRage;
              end;
              if nCheck = 1 then
                break;
            end;
          end;
        end;
        if m_TargetBaseObject <> nil then
        begin
          SetTargetCreat(m_TargetBaseObject);
        end
        else
        begin
          DelTargetCreat();
        end;
      end;
      if m_TargetBaseObject <> nil then
      begin
        if Integer(GetTickCount - m_dwHitTick) >= m_nNextHitTime then
        begin
          m_dwHitTick := GetTickCount();
          sub_4A6B30(m_TargetBaseObject);
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TEvilGuardUnit.Run');
  end;
  inherited;
end;

procedure TEvilGuardUnit.sub_4A6B30(TargeTBaseObject: TBaseObject); //004A6B30
var
  nPower: Integer;
  WAbil: pTAbility;
begin
  try
    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY,
      TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY);
    WAbil := @m_WAbil;
    nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) +
      LoWord(WAbil.DC));
    if nPower > 0 then
      nPower := TargeTBaseObject.GetHitStruckDamage(Self, nPower);
    if nPower > 0 then
    begin
      TargeTBaseObject.SetLastHiter(Self);
      TargeTBaseObject.m_ExpHitter := nil;
      TargeTBaseObject.StruckDamage(nPower, self);
      TargeTBaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower,
        TargeTBaseObject.m_WAbil.HP, TargeTBaseObject.m_WAbil.MaxHP, Integer(Self),
        '',
        _MAX(abs(m_nCurrX - TargeTBaseObject.m_nCurrX), abs(m_nCurrY -
          TargeTBaseObject.m_nCurrY)) * 50 + 600);
    end;
    SendRefMsg(RM_FLYAXE, m_btDirection, m_nCurrX, m_nCurrY,
      Integer(TargeTBaseObject), '');
  except
    MainOutMessage('[Exception] TEvilGuardUnit.sub_4A6B30');
  end;
end;

//TPsycheMonster-----------------

constructor TPsycheMonster.Create();
begin
  try
    inherited;
    m_nViewRange := 5;
    m_nAttackRange := 5;
    m_boDupMode := False;
    m_dwThinkTick := GetTickCount();
  except
    MainOutMessage('[Exception] TPsycheMonster.Create');
  end;
end;

destructor TPsycheMonster.Destroy;
begin
  try
    inherited;
  except
    MainOutMessage('[Exception] TPsycheMonster.Destroy');
  end;
end;

function TPsycheMonster.Think(): Boolean; //004A8E54
var
  nOldX, nOldY: integer;
begin
  try
    Result := False;
    if (GetTickCount - m_dwThinkTick) > 3 * 1000 then
    begin
      m_dwThinkTick := GetTickCount();
      if m_PEnvir.GetXYObjCount(m_nCurrX, m_nCurrY) >= 2 then
        m_boDupMode := True;
      if not IsProperTarget {FFFF4}(m_TargetCret) then
        m_TargetCret := nil;
    end; //004A8ED2
    if m_boDupMode then
    begin
      nOldX := m_nCurrX;
      nOldY := m_nCurrY;
      WalkTo(Random(8), False);
      if (nOldX <> m_nCurrX) or (nOldY <> m_nCurrY) then
      begin
        m_boDupMode := False;
        Result := True;
      end;
    end;
  except
    MainOutMessage('[Exception] TMonster.Think');
  end;
end;

procedure TPsycheMonster.Run;
var
  nX, nY, n14: Integer;
begin
  try
    try
      if not m_boGhost and
        not m_boDeath and
        not m_boFixedHideMode and
        not m_boStoneMode and
        (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
      begin
        if Think then
        begin //检测是否重叠，重叠则随机移动一格
          inherited;
          exit;
        end;
        if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret =
            nil)) then
        begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();
        end;
        if m_boWalkWaitLocked then
        begin
          if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then
          begin
            m_boWalkWaitLocked := False;
          end;
        end;
        if not m_boRunAwayMode then
        begin
          if not m_boNoAttackMode then
          begin
            if m_TargetCret <> nil then
            begin
              if AttackTarget {FFEB} then
              begin
                //inherited;
                //exit;
              end;
            end;
          end;
        end;
        if not m_boWalkWaitLocked and (Integer(GetTickCount - m_dwWalkTick) >
          m_nWalkSpeed) then
        begin
          m_dwWalkTick := GetTickCount();
          Inc(m_nWalkCount);
          if m_nWalkCount > m_nWalkStep then
          begin
            m_nWalkCount := 0;
            m_boWalkWaitLocked := True;
            m_dwWalkWaitTick := GetTickCount();
          end; //004A9151
          if not m_boRunAwayMode then
          begin
            if not m_boNoAttackMode then
            begin
              if m_TargetCret <> nil then
              begin
                if (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 3) and
                  (abs(m_nCurrY - m_TargetCret.m_nCurrY) < 3) then
                begin
                  if (m_Master2 <> nil) and
                    (m_PEnvir = m_Master2.m_PEnvir) and
                    ((abs(m_nCurrX - m_Master2.m_nCurrX) >
                      (g_Config.nMagicAttackRage - 2)) or
                    (abs(m_nCurrY - m_Master2.m_nCurrY) >
                      (g_Config.nMagicAttackRage - 2))) then
                  begin
                    n14 := GetNextDirection(m_nCurrX, m_nCurrY,
                      m_Master2.m_nCurrX, m_Master2.m_nCurrY);
                    m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n14, 5,
                      m_nTargetX, m_nTargetY);
                  end
                  else
                  begin
                    n14 := GetNextDirection(m_TargetCret.m_nCurrX,
                      m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
                    m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX,
                      m_TargetCret.m_nCurrY, n14, 5, m_nTargetX, m_nTargetY);
                  end;
                  if m_nTargetX > 0 then
                    GotoTargetXY();
                  inherited;
                  exit;
                end
                else

              end
              else
              begin
                m_nTargetX := -1;
                if m_boMission then
                begin
                  m_nTargetX := m_nMissionX;
                  m_nTargetY := m_nMissionY;
                end; //004A91D3
              end;
            end; //004A91D3  if not bo2C0 then begin
            if m_Master2 <> nil then
            begin
              if m_TargetCret = nil then
              begin
                m_Master2.GetBackPosition(nX, nY);
                if (abs(m_nTargetX - nX) > 1) or (abs(m_nTargetY - nY {nX}) > 1)
                  then
                begin //004A922D
                  m_nTargetX := nX;
                  m_nTargetY := nY;
                  if (abs(m_nCurrX - nX) <= 2) and (abs(m_nCurrY - nY) <= 2)
                    then
                  begin
                    if m_PEnvir.GetMovingObject(nX, nY, True) <> nil then
                    begin
                      m_nTargetX := m_nCurrX;
                      m_nTargetY := m_nCurrY;
                    end //004A92A5
                  end;
                end; //004A92A5
              end; //004A92A5 if m_TargetCret = nil then begin
              if (not m_Master2.m_boSlaveRelax) and
                ((m_PEnvir <> m_Master2.m_PEnvir) or
                (abs(m_nCurrX - m_Master2.m_nCurrX) > 20) or
                (abs(m_nCurrY - m_Master2.m_nCurrY) > 20)) then
              begin
                SpaceMove(m_Master2.m_PEnvir.sMapName, m_nTargetX, m_nTargetY,
                  1);
              end; // 004A937E
            end; // 004A937E if m_Master <> nil then begin
          end
          else
          begin //004A9344
            if (m_dwRunAwayTime > 0) and ((GetTickCount - m_dwRunAwayStart) >
              m_dwRunAwayTime) then
            begin
              m_boRunAwayMode := False;
              m_dwRunAwayTime := 0;
            end;
          end; //004A937E
          if (m_Master2 <> nil) and m_Master2.m_boSlaveRelax then
          begin
            inherited;
            exit;
          end; //004A93A6
          if m_nTargetX <> -1 then
          begin
            GotoTargetXY(); //004A93B5 0FFEF
          end
          else
          begin
            if m_TargetCret = nil then
              Wondering(); // FFEE   //Jacky
          end; //004A93D8
        end; //004A93D8  if not bo510 and ((GetTickCount - m_dwWalkTick) > n4FC) then begin
      end; //004A93D8
    except
      MainOutMessage('[Exception] TMonster.Run');
    end;
    inherited;
  except
    MainOutMessage('[Exception] TPsycheMonster.Run');
  end;
end;

procedure TPsycheMonster.FlyAttack(Target: TBaseObject);
var
  WAbil: pTAbility;
  nDamage: Integer;
  SkillIdx: integer;
begin
  try
    //if m_PEnvir.CanFly(m_nCurrX,m_nCurrY,Target.m_nCurrX,Target.m_nCurrY) then begin
    if (Random(10) - (g_Config.nFairyDuntRate div 10)) < 0 then
      SkillIdx := 101
    else
      SkillIdx := 100;
    SendRefMsg(RM_SPELL, SkillIdx, Target.m_nCurrX, Target.m_nCurrY, SkillIdx,
      '');
    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, Target.m_nCurrX,
      Target.m_nCurrY);
    WAbil := @m_WAbil;
    nDamage := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) +
      LoWord(WAbil.DC));
    if SkillIdx = 101 then
      nDamage := Trunc(g_Config.nFairyAttackRate / 100 * nDamage);
    if nDamage > 0 then
      nDamage := Target.GetHitStruckDamage(Self, nDamage);
    if nDamage > 0 then
    begin
      Target.m_LastHiter := Self;
      Target.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
        Target.m_WAbil.HP, Target.m_WAbil.MaxHP, Integer(Self), '',
        _MAX(abs(m_nCurrX - Target.m_nCurrX), abs(m_nCurrY - Target.m_nCurrY)) *
          50 + 600);
      Target.StruckDamage(nDamage, self);
    end;
    SendRefMsg(RM_MAGICFIRE, 0,
      MakeWord(1, SkillIdx),
      MakeLong(Target.m_nCurrX, Target.m_nCurrY),
      Integer(Target), '');
    // end;
  except
    MainOutMessage('[Exception] TPsycheMonster.FlyAttack');
  end;
end;

function TPsycheMonster.AttackTarget: Boolean;
begin
  try
    Result := False;
    if m_TargetCret <> nil then
    begin
      if (m_TargetCret.m_PEnvir = m_PEnvir) and
        (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= m_nAttackRange) and
        (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= m_nAttackRange) then
      begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
        begin
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          FlyAttack(m_TargetCret);
          BreakHolySeizeMode();
        end;
        Result := True;
      end
      else
      begin
        if m_TargetCret.m_PEnvir = m_PEnvir then
        begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end
        else
        begin
          DelTargetCreat();
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TPsycheMonster.AttackTarget:Boolean');
  end;
end;

procedure TPsycheMonster.RecalcAbilitys();
begin
  try
    inherited;
    m_nNextHitTime := 1500 - m_btSlaveMakeLevel * 100;
    m_nWalkSpeed := 500 - m_btSlaveMakeLevel * 50;
    m_dwWalkTick := GetTickCount + 2000;
  except
    MainOutMessage('[Exception] TPsycheMonster.RecalcAbilitys');
  end;
end;

end.

