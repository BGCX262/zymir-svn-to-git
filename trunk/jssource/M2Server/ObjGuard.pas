//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit ObjGuard;

interface
uses
  Windows, Classes, Grobal2, ObjNpc;
type
  TSuperGuard = class(TNormNpc)
  public
    n564: Integer;
    m_boAttackPet: Boolean;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override; //FFFB
  end;

  TPetSuperGuard = class(TSuperGuard)
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
implementation

uses ObjBase, M2Share;

{ TSuperGuard }

function TSuperGuard.AttackTarget(): Boolean; //004977B4
var
  nOldX, nOldY: Integer;
  btOldDir: Byte;
  wHitMode: Word;
begin
  try
    Result := False;
    if m_TargetCret.m_PEnvir = m_PEnvir then
    begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
      begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        nOldX := m_nCurrX;
        nOldY := m_nCurrY;
        btOldDir := m_btDirection;
        m_TargetCret.GetBackPosition(m_nCurrX, m_nCurrY);
        m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY,
          m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
        wHitMode := 0;
        _Attack(wHitMode, m_TargetCret);
        m_TargetCret.SetLastHiter(Self);
        m_TargetCret.m_ExpHitter := nil;
        m_nCurrX := nOldX;
        m_nCurrY := nOldY;
        m_btDirection := btOldDir;
        TurnTo(m_btDirection);
        BreakHolySeizeMode();
      end;
      Result := True;
    end
    else
    begin
      DelTargetCreat();
    end;

  except
    MainOutMessage('[Exception] TSuperGuard.AttackTarget');
  end;
end;

constructor TSuperGuard.Create; //004976B0
begin
  try
    inherited;
    m_nViewRange := 7;
    m_nLight := 4;
    m_boAttackPet := True;
  except
    MainOutMessage('[Exception] TSuperGuard.Create');
  end;
end;

destructor TSuperGuard.Destroy; //00497718
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TSuperGuard.Destroy');
  end;
end;

function TSuperGuard.Operate(ProcessMsg: pTProcessMessage): Boolean; //0049774C
begin
  try
    Result := inherited Operate(ProcessMsg);
  except
    MainOutMessage('[Exception] TSuperGuard.Operate');
  end;
end;

procedure TSuperGuard.Run; //00497924
var
  I: Integer;
  BaseObject: TBaseObject;
begin
  try
    if m_Master2 <> nil then
    begin
      m_Master2 := nil; //不允许召唤为宝宝
      m_AllMaster := nil;
    end;

    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
    begin
      for I := 0 to m_VisibleActors.Count - 1 do
      begin
        BaseObject :=
          TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject.m_boDeath then
          Continue;
        if (BaseObject.PKLevel >= 2) or ((BaseObject.m_btRaceServer >=
          RC_MONSTER) and (not BaseObject.m_boMission) and
          (BaseObject.m_btRaceServer <> RC_153)) then
        begin
          if m_boAttackPet then
          begin
            SetTargetCreat(BaseObject);
            break;
          end
          else
          begin
            if BaseObject.m_Master2 = nil then
            begin
              SetTargetCreat(BaseObject);
              break;
            end
            else
            begin
              if BaseObject.m_TargetCret = self then
              begin
                SetTargetCreat(BaseObject);
                break;
              end;
            end;
          end;
        end;
      end;
    end;
    if m_TargetCret <> nil then
      AttackTarget();
    inherited;
  except
    MainOutMessage('[Exception] TSuperGuard.Run');
  end;
end;

constructor TPetSuperGuard.Create;
begin
  try
    inherited;
    m_nViewRange := 7;
    m_nLight := 4;
    m_boAttackPet := False;
  except
    MainOutMessage('[Exception] TPetSuperGuard.Create');
  end;
end;

destructor TPetSuperGuard.Destroy;
begin
  try
    inherited;
  except
    MainOutMessage('[Exception] TPetSuperGuard.Destroy');
  end;
end;

end.

