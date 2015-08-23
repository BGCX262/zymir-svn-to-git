//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit ObjAxeMon;

interface
uses
  Windows, Classes, Grobal2, ObjBase, ObjMon;
type
  TDualAxeMonster = class(TMonster)
    bo558: Boolean;
    m_nAttackCount: Integer; //0x55C
    m_nAttackMax: Integer; //0x560
  private
    procedure FlyAxeAttack(Target: TBaseObject);
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override; //FFEB
    procedure Run; override;
  end;
  TThornDarkMonster = class(TDualAxeMonster)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TArcherMonster = class(TDualAxeMonster)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
implementation

uses M2Share, HUtil32;

{ TDualAxeMonster }

procedure TDualAxeMonster.FlyAxeAttack(Target: TBaseObject);
var
  WAbil: pTAbility;
  nDamage: Integer;
begin
  try
    if m_PEnvir.CanFly(m_nCurrX, m_nCurrY, Target.m_nCurrX, Target.m_nCurrY)
      then
    begin
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, Target.m_nCurrX,
        Target.m_nCurrY);
      WAbil := @m_WAbil;
      nDamage := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) +
        LoWord(WAbil.DC));
      if nDamage > 0 then
      begin
        nDamage := Target.GetHitStruckDamage(Self, nDamage);
      end;
      if nDamage > 0 then
      begin
        Target.StruckDamage(nDamage, self);
        Target.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
          Target.m_WAbil.HP, Target.m_WAbil.MaxHP, Integer(Self), '',
          _MAX(abs(m_nCurrX - Target.m_nCurrX), abs(m_nCurrY - Target.m_nCurrY))
            * 50 + 600);
      end;
      SendRefMsg(RM_FLYAXE, m_btDirection, m_nCurrX, m_nCurrY, Integer(Target),
        '');
    end;

  except
    MainOutMessage('[Exception] TDualAxeMonster.FlyAxeAttack');
  end;
end;

function TDualAxeMonster.AttackTarget: Boolean; //00459B14
begin
  try
    Result := False;
    if m_TargetCret = nil then
      exit;
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
    begin
      m_dwHitTick := GetTickCount();
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 7) and (abs(m_nCurrX -
        m_TargetCret.m_nCurrX) <= 7) then
      begin
        if (m_nAttackMax - 1) > m_nAttackCount then
        begin
          Inc(m_nAttackCount);
          m_dwTargetFocusTick := GetTickCount();
          FlyAxeAttack(m_TargetCret);
        end
        else
        begin
          if Random(5) = 0 then
          begin
            m_nAttackCount := 0;
          end;
        end;
        Result := True;
        exit;
      end;
      if m_TargetCret.m_PEnvir = m_PEnvir then
      begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrX -
          m_TargetCret.m_nCurrX) <= 11) then
        begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end
      else
      begin
        DelTargetCreat();
      end;
    end;
  except
    MainOutMessage('[Exception] TDualAxeMonster.AttackTarget:');
  end;
end;

constructor TDualAxeMonster.Create;
begin
  try
    inherited;
    bo558 := False;
    m_nViewRange := 5;
    m_nRunTime := 250;
    m_dwSearchTime := 3000;
    m_nAttackCount := 0;
    m_nAttackMax := 2;
    m_dwSearchTick := GetTickCount();
  except
    MainOutMessage('[Exception] TDualAxeMonster.Create');
  end;
end;

destructor TDualAxeMonster.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TDualAxeMonster.Destroy');
  end;
end;

procedure TDualAxeMonster.Run; //00459C98
var
  I: Integer;
  nAbs: Integer;
  nRage: Integer;
  BaseObject: TBaseObject;
  TargetBaseObject: TBaseObject;
begin
  try
    nRage := 9999;
    TargetBaseObject := nil;
    if not m_boDeath and
      not bo558 and
      not m_boGhost and
      (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
    begin

      if (GetTickCount - m_dwSearchEnemyTick) >= 5000 then
      begin
        m_dwSearchEnemyTick := GetTickCount();
        for I := 0 to m_VisibleActors.Count - 1 do
        begin
          BaseObject :=
            TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
          if BaseObject.m_boDeath then
            Continue;
          if IsProperTarget(BaseObject) then
          begin
            if not BaseObject.m_boHideMode or m_boCoolEye then
            begin
              nAbs := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY -
                BaseObject.m_nCurrY);
              if nAbs < nRage then
              begin
                nRage := nAbs;
                TargetBaseObject := BaseObject;
              end;
            end;
          end;
        end;
        if TargetBaseObject <> nil then
        begin
          SetTargetCreat(TargetBaseObject);
        end;
      end;

      if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) and (m_TargetCret
        <> nil) then
      begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) and (abs(m_nCurrX -
          m_TargetCret.m_nCurrX) <= 4) then
        begin
          if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrX -
            m_TargetCret.m_nCurrX) <= 2) then
          begin
            if Random(5) = 0 then
            begin
              GetBackPosition(m_nTargetX, m_nTargetY);
            end;
          end
          else
          begin
            GetBackPosition(m_nTargetX, m_nTargetY);
          end;
        end;
      end;
    end;
    inherited;
  except
    MainOutMessage('[Exception] TDualAxeMonster.Run');
  end;
end;

{ TThornDarkMonster }

constructor TThornDarkMonster.Create; //00459EE4
begin
  try
    inherited;
    m_nAttackMax := 3;
  except
    MainOutMessage('[Exception] TThornDarkMonster.Create');
  end;
end;

destructor TThornDarkMonster.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TThornDarkMonster.Destroy');
  end;
end;

{ TArcherMonster }

constructor TArcherMonster.Create;
begin
  try
    inherited;
    m_nAttackMax := 6;
  except
    MainOutMessage('[Exception] TArcherMonster.Create');
  end;
end;

destructor TArcherMonster.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TArcherMonster.Destroy');
  end;
end;
end.

