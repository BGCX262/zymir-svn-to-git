//CHECK
//��Ҫɾ����һ��ע�ͣ���ע��Ϊ�����ļ��Ƿ��ѱ��Զ������쳣����
unit ObjMon3;

interface

uses
  Windows, Classes, Grobal2, ObjBase, ObjMon, ObjMon2;

type

  TRonObject = class(TMonster)
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure AroundAttack;
    procedure Run; override;
  end;

  TMinorNumaObject = class(TATMonster)
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TSandMobObject = class(TStickMonster)
  private
    m_dwAppearStart: LongWord;

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TRockManObject = class(TATMonster)
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TMagicMonObject = class(TMonster)
  private
    m_boUseMagic: Boolean;

    procedure LightingAttack(nDir: Integer);

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TBoneKingMonster = class(TMonster)
  private
    m_nDangerLevel: Integer;
    m_SlaveObjectList: TList; //0x55C

    procedure CallSlave;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
    //0FFED
    procedure Run; override;
  end;

  TPercentMonster = class(TAnimalObject)
    n54C: Integer;
    m_dwThinkTick: LongWord;
    bo554: Boolean;
    m_boDupMode: Boolean;
  private
    function Think: Boolean;
    //    function MakeClone(sMonName:String;OldMon:TBaseObject):TBaseObject;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    function AttackTarget(): Boolean; virtual;
    procedure Run; override;
  end;

  TMagicMonster = class(TAnimalObject)
    n54C: Integer;
    m_dwThinkTick: LongWord;
    m_dwSpellTick: LongWord;
    bo554: Boolean;
    m_boDupMode: Boolean;
  private
    function Think: Boolean;
    //    function MakeClone(sMonName:String;OldMon:TBaseObject):TBaseObject;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    function AttackTarget(): Boolean; virtual;
    procedure Run; override;
  end;

  TFireballMonster = class(TMagicMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TFireMonster = class(TMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TFrostTiger = class(TMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TGreenMonster = class(TMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TRedMonster = class(TMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TKhazard = class(TMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  {  TRunAway = class(TMonster)
    private
    public
      constructor Create();override;
      destructor Destroy; override;
      procedure Run; override;
    end;         }

  TTeleMonster = class(TMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TDefendMonster = class(TMonster)
  private
    //    m_GuardObjects  :TList;

    //    procedure CallGuard(mapmap:string; xx,yy:integer);
  public
    callguardrun: boolean;
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TClone = class(TMonster)
  private
    procedure LightingAttack(nDir: Integer);

  public
    constructor Create(); override;
    //    function  Operate(ProcessMsg:pTProcessMessage):boolean; override;
    procedure Struck(hiter: TBaseObject); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

implementation

uses
  UsrEngn, M2Share, Event, SysUtils;

constructor TRonObject.Create;
begin
  try
    inherited;
    m_dwSearchTime := Random(1500) + 1500;
  except
    MainOutMessage('[Exception] TRonObject.Create');
  end;
end;

destructor TRonObject.Destroy;
begin
  try
    inherited;
  except
    MainOutMessage('[Exception] TRonObject.Destroy');
  end;
end;

procedure TRonObject.AroundAttack;
var
  xTargetList: TList;
  BaseObject: TBaseObject;
  wHitMode: Word;
  i: Integer;
begin
  try
    wHitMode := 0;
    GetAttackDir(m_TargetCret, m_btDirection);

    xTargetList := TList.Create;
    GetMapBaseObjects(m_PEnvir, m_nCurrX, m_nCurrY, 1, xTargetList);

    if (xTargetList.Count > 0) then
    begin
      for i := xTargetList.Count - 1 downto 0 do
      begin
        BaseObject := TBaseObject(xTargetList.Items[i]);

        if (BaseObject <> nil) then
        begin
          _Attack(wHitMode, BaseObject); //CM_HIT

          xTargetList.Delete(i);
        end;
      end;
    end;
    xTargetList.Free;

    SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  except
    MainOutMessage('[Exception] TRonObject.AroundAttack');
  end;
end;

procedure TRonObject.Run;
begin
  try
    try
      if (not m_boDeath) and (not m_boGhost) and (m_wStatusTimeArr[POISON_STONE
        {5 0x6A}] = 0) then
      begin
        if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret =
          nil)) then
        begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();
        end;

        if (m_TargetCret <> nil) and
          (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 6) and
          (abs(m_nCurrY - m_TargetCret.m_nCurrY) < 6) and
          (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then
        begin

          m_dwHitTick := GetTickCount();
          AroundAttack;
        end;
      end;
    except
      MainOutMessage('[Exception] TRonObject.Run');
    end;
    inherited;
  except
    MainOutMessage('[Exception] TRonObject.Run');
  end;
end;

constructor TMinorNumaObject.Create;
begin
  try
    inherited;
  except
    MainOutMessage('[Exception] TMinorNumaObject.Create');
  end;
end;

destructor TMinorNumaObject.Destroy;
begin
  try
    inherited;
  except
    MainOutMessage('[Exception] TMinorNumaObject.Destroy');
  end;
end;

procedure TMinorNumaObject.Run;
begin
  try
    try
      if (not m_boDeath) then
      begin
        if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret =
          nil)) then
        begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();
        end;
      end;
    except
      MainOutMessage('[Exception] TMinorNumaObject.Run');
    end;
    inherited;
  except
    MainOutMessage('[Exception] TMinorNumaObject.Run');
  end;
end;

constructor TSandMobObject.Create;
begin
  try
    inherited;
    //m_boHideMode := TRUE;
    nComeOutValue := 8;
  except
    MainOutMessage('[Exception] TSandMobObject.Create');
  end;
end;

destructor TSandMobObject.Destroy;
begin
  try
    inherited;
  except
    MainOutMessage('[Exception] TSandMobObject.Destroy');
  end;
end;

procedure TSandMobObject.Run;
begin
  try
    try
      if (not m_boDeath) and (not m_boGhost) then
      begin
        if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then
        begin
          m_dwWalkTick := GetTickCount;

          if (m_boFixedHideMode) then
          begin
            if (((m_WAbil.HP > (m_WAbil.MaxHP / 20)) and CheckComeOut())) then
              m_dwAppearStart := GetTickCount;
          end
          else
          begin
            if ((m_WAbil.HP > 0) and (m_WAbil.HP < (m_WAbil.MaxHP / 20)) and
              (GetTickCount - m_dwAppearStart > 3000)) then
              ComeDown
            else if (m_TargetCret <> nil) then
            begin
              if (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 15) and (abs(m_nCurrY
                - m_TargetCret.m_nCurrY) > 15) then
              begin
                ComeDown;
                exit;
              end;
            end;

            if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
              SearchTarget();

            if (not m_boFixedHideMode) then
            begin
              if (AttackTarget) then
                inherited;
            end;
          end;
        end;
      end;
    except
      MainOutMessage('[Exception] TSandMobObject.Run');
    end;
    inherited;
  except
    MainOutMessage('[Exception] TSandMobObject.Run');
  end;
end;

constructor TRockManObject.Create;
begin
  try
    inherited;
    //m_dwSearchTick := 2500 + Random(1500);
    //m_dwSearchTime := GetTickCount();

    m_boHideMode := TRUE;
  except
    MainOutMessage('[Exception] TRockManObject.Create');
  end;
end;

destructor TRockManObject.Destroy;
begin
  try
    inherited;
  except
    MainOutMessage('[Exception] TRockManObject.Destroy');
  end;
end;

procedure TRockManObject.Run;
begin
  try
    {if (not m_fIsDead) and (not m_fIsGhost) then begin
    if (m_fHideMode) then begin
     if (CheckComeOut(8)) then
      ComeOut;

     m_dwWalkTime := GetTickCount + 1000;
    end else begin
     if ((GetTickCount - m_dwSearchEnemyTime > 8000) or ((GetTickCount - m_dwSearchEnemyTime > 1000) and (m_pTargetObject=nil))) then begin
      m_dwSearchEnemyTime := GetTickCount;
      MonsterNormalAttack;

      if (m_pTargetObject=nil) then
       ComeDown;
     end;
    end;
   end;}

    inherited;
  except
    MainOutMessage('[Exception] TRockManObject.Run');
  end;
end;

{ TMagicMonObject }

constructor TMagicMonObject.Create;
begin
  try
    inherited;
    m_dwSearchTime := Random(1500) + 1500;
    m_boUseMagic := False;
  except
    MainOutMessage('[Exception] TMagicMonObject.Create');
  end;
end;

destructor TMagicMonObject.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TMagicMonObject.Destroy');
  end;
end;

procedure TMagicMonObject.LightingAttack(nDir: Integer);
begin
  try

  except
    MainOutMessage('[Exception] TMagicMonObject.LightingAttack');
  end;
end;

procedure TMagicMonObject.Run;
var
  nAttackDir: Integer;
  nX, nY: Integer;
begin
  try
    try
      if (not m_boDeath) and
        (not bo554) and
        (not m_boGhost) and
        (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
      begin

        //Ѫ������һ��ʱ��ʼ��ħ������
        if m_WAbil.HP < m_WAbil.MaxHP div 2 then
          m_boUseMagic := True
        else
          m_boUseMagic := False;

        if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)
          then
        begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();
        end;
        if m_Master2 = nil then
          exit;

        nX := abs(m_nCurrX - m_Master2.m_nCurrX);
        nY := abs(m_nCurrY - m_Master2.m_nCurrY);

        if (nX <= 5) and (nY <= 5) then
        begin
          if m_boUseMagic or ((nX = 5) or (nY = 5)) then
          begin
            if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then
            begin
              m_dwHitTick := GetTickCount();
              nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY,
                m_Master2.m_nCurrX, m_Master2.m_nCurrY);
              LightingAttack(nAttackDir);
            end;
          end;
        end;
      end;
    except
      MainOutMessage('[Exception] TMagicMonObject.Run');
    end;
    inherited Run;
  except
    MainOutMessage('[Exception] TMagicMonObject.Run');
  end;
end;

{ TBoneKingMonster }

constructor TBoneKingMonster.Create;
begin
  try
    inherited;
    m_dwSearchTime := Random(1500) + 1500;
    m_nViewRange := 8;
    m_btDirection := 5;
    m_nDangerLevel := 5;
    m_SlaveObjectList := TList.Create;
  except
    MainOutMessage('[Exception] TBoneKingMonster.Create');
  end;
end;

destructor TBoneKingMonster.Destroy;
begin
  try
    m_SlaveObjectList.Free;
    inherited;
  except
    MainOutMessage('[Exception] TBoneKingMonster.Destroy');
  end;
end;

procedure TBoneKingMonster.CallSlave;
const
  sMonName: array[0..2] of string = ('BoneCaptain', 'BoneArcher',
    'BoneSpearman');
var
  I: Integer;
  nC: Integer;
  n10, n14: Integer;
  BaseObject: TBaseObject;
begin
  try
    nC := Random(6) + 6;
    GetFrontPosition(n10, n14);

    for I := 1 to nC do
    begin
      if m_SlaveObjectList.Count >= 30 then
        break;
      BaseObject := UserEngine.RegenMonsterByName(m_sMapName, n10, n14,
        sMonName[Random(3)]);
      if BaseObject <> nil then
      begin
        m_SlaveObjectList.Add(BaseObject);
      end;
    end; // for
  except
    MainOutMessage('[Exception] TBoneKingMonster.CallSlave');
  end;
end;

procedure TBoneKingMonster.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
var
  WAbil: pTAbility;
  nPower: Integer;
begin
  try
    WAbil := @m_WAbil;
    nPower := GetAttackPower(LoWord(WAbil.DC), SmallInt(HiWord(WAbil.DC) -
      LoWord(WAbil.DC)));
    HitMagAttackTarget(TargeTBaseObject, 0, nPower, True);
  except
    MainOutMessage('[Exception] TBoneKingMonster.Attack');
  end;
end;

procedure TBoneKingMonster.Run;
var
  I: Integer;
  //n10:Integer;
  BaseObject: TBaseObject;
begin
  try
    try
      if (not m_boGhost) and
        (not m_boDeath) and
        (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) and
        (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then
      begin
        //    n10:=0;

        if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret =
          nil)) then
        begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();

          if (m_nDangerLevel > m_WAbil.HP / m_WAbil.MaxHP * 5) and
            (m_nDangerLevel > 0) then
          begin
            Dec(m_nDangerLevel);
            CallSlave();
          end;
          if m_WAbil.HP = m_WAbil.MaxHP then
            m_nDangerLevel := 5;
        end;

        for I := m_SlaveObjectList.Count - 1 downto 0 do
        begin
          BaseObject := TBaseObject(m_SlaveObjectList.Items[I]);
          if BaseObject.m_boDeath or BaseObject.m_boGhost then
            m_SlaveObjectList.Delete(I);
        end; // for
      end;
    except
      MainOutMessage('[Exception] TBoneKingMonster.Run');
    end;
    inherited;
  except
    MainOutMessage('[Exception] TBoneKingMonster.Run');
  end;
end;

constructor TPercentMonster.Create;
begin
  try
    inherited;
    m_boDupMode := False;
    bo554 := False;
    m_dwThinkTick := GetTickCount();
    m_nViewRange := 5;
    m_nRunTime := 250;
    m_dwSearchTime := 3000 + Random(2000);
    m_dwSearchTick := GetTickCount();
    m_btRaceServer := 80;
  except
    MainOutMessage('[Exception] TPercentMonster.Create');
  end;
end;

destructor TPercentMonster.Destroy;
begin
  try
    inherited;
  except
    MainOutMessage('[Exception] TPercentMonster.Destroy');
  end;
end;
{function TPercentMonster.MakeClone(sMonName: String;OldMon:TBaseObject): TBaseObject; //004A8C58
var
  ElfMon:TBaseObject;
begin
Try
  Result:=nil;
  ElfMon:=UserEngine.RegenMonsterByName(m_PEnvir.sMapName,m_nCurrX,m_nCurrY,sMonName);
  if ElfMon <> nil then begin
    ElfMon.m_Master:=OldMon.m_Master;
    ElfMon.m_dwMasterRoyaltyTick:=OldMon.m_dwMasterRoyaltyTick;
    ElfMon.m_btSlaveMakeLevel:=OldMon.m_btSlaveMakeLevel;
    ElfMon.m_btSlaveExpLevel:=OldMon.m_btSlaveExpLevel;
    ElfMon.RecalcAbilitys;
    ElfMon.RefNameColor;
    if OldMon.m_Master <> nil then
      OldMon.m_Master.m_SlaveList.Add(ElfMon);
    ElfMon.m_WAbil:=OldMon.m_WAbil;
    ElfMon.m_wStatusTimeArr:=OldMon.m_wStatusTimeArr;
    ElfMon.m_TargetCret:=OldMon.m_TargetCret;
    ElfMon.m_dwTargetFocusTick:=OldMon.m_dwTargetFocusTick;
    ElfMon.m_LastHiter:=OldMon.m_LastHiter;
    ElfMon.m_LastHiterTick:=OldMon.m_LastHiterTick;
    ElfMon.m_btDirection:=OldMon.m_btDirection;
    Result:=ElfMon;
  end;
Except
  MainOutMessage('[Exception] TPercentMonster.MakeClone');
End;
end;   }

function TPercentMonster.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  try
    Result := inherited Operate(ProcessMsg);

  except
    MainOutMessage('[Exception] TPercentMonster.Operate');
  end;
end;

function TPercentMonster.Think(): Boolean; //004A8E54
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
    MainOutMessage('[Exception] TPercentMonster.Think');
  end;
end;

function TPercentMonster.AttackTarget(): Boolean; //004A8F34
var
  btDir: Byte;
begin
  try
    Result := False;
    if m_TargetCret <> nil then
    begin
      if GetAttackDir(m_TargetCret, btDir) then
      begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
        begin
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          Attack(m_TargetCret, btDir); //FFED
          BreakHolySeizeMode();
        end;
        Result := True;
      end
      else
      begin
        if m_TargetCret.m_PEnvir = m_PEnvir then
        begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
          //004A8FE3
        end
        else
        begin
          DelTargetCreat(); {0FFF1h}
          //004A9009
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TPercentMonster.AttackTarget');
  end;
end;

procedure TPercentMonster.Run; //004A9020
var
  nX, nY: Integer;
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
        begin
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
          if not m_boRunAwayMode then
          begin
            if not m_boNoAttackMode then
            begin
              if m_TargetCret <> nil then
              begin
                if AttackTarget {FFEB} then
                begin
                  inherited;
                  exit;
                end;
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
                //  sysmsg('recalling to my master',c_red,t_hint);
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
      MainOutMessage('[Exception] TPercentMonster.Run');
    end;
    inherited;
  except
    MainOutMessage('[Exception] TPercentMonster.Run');
  end;
end;

constructor TMagicMonster.Create; //004A8B74
begin
  try
    inherited;
    m_boDupMode := False;
    bo554 := False;
    m_dwThinkTick := GetTickCount();
    m_nViewRange := 8;
    m_nRunTime := 250;
    m_dwSearchTime := 3000 + Random(2000);
    m_dwSearchTick := GetTickCount();
    m_btRaceServer := 215;
  except
    MainOutMessage('[Exception] TMagicMonster.Create');
  end;
end;

destructor TMagicMonster.Destroy; //004A8C24
begin
  try
    inherited;
  except
    MainOutMessage('[Exception] TMagicMonster.Destroy');
  end;
end;
{function TMagicMonster.MakeClone(sMonName: String;OldMon:TBaseObject): TBaseObject; //004A8C58
var
  ElfMon:TBaseObject;
begin
Try
  Result:=nil;
  ElfMon:=UserEngine.RegenMonsterByName(m_PEnvir.sMapName,m_nCurrX,m_nCurrY,sMonName,OldMon.m_Master);
  if ElfMon <> nil then begin
    ElfMon.m_Master:=OldMon.m_Master;
    ElfMon.m_AllMaster:=OldMon.m_AllMaster;
    ElfMon.m_dwMasterRoyaltyTick:=OldMon.m_dwMasterRoyaltyTick;
    ElfMon.m_btSlaveMakeLevel:=OldMon.m_btSlaveMakeLevel;
    ElfMon.m_btSlaveExpLevel:=OldMon.m_btSlaveExpLevel;
    ElfMon.RecalcAbilitys;
    ElfMon.RefNameColor;
    if OldMon.m_Master <> nil then
      OldMon.m_Master.m_SlaveList.Add(ElfMon);
    ElfMon.m_WAbil:=OldMon.m_WAbil;
    ElfMon.m_wStatusTimeArr:=OldMon.m_wStatusTimeArr;
    ElfMon.m_TargetCret:=OldMon.m_TargetCret;
    ElfMon.m_dwTargetFocusTick:=OldMon.m_dwTargetFocusTick;
    ElfMon.m_LastHiter:=OldMon.m_LastHiter;
    ElfMon.m_LastHiterTick:=OldMon.m_LastHiterTick;
    ElfMon.m_btDirection:=OldMon.m_btDirection;
    Result:=ElfMon;
  end;
Except
  MainOutMessage('[Exception] TMagicMonster.MakeClone');
End;
end;     }

function TMagicMonster.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  try
    Result := inherited Operate(ProcessMsg);

  except
    MainOutMessage('[Exception] TMagicMonster.Operate');
  end;
end;

function TMagicMonster.Think(): Boolean; //004A8E54
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
    MainOutMessage('[Exception] TMagicMonster.Think');
  end;
end;

function TMagicMonster.AttackTarget(): Boolean; //004A8F34
var
  bt06: Byte;
  //PlayObject:TPlayObject;
//  npower:integer;
//  UserMagic: pTUserMagic;
begin
  try
    Result := False;
    if m_TargetCret <> nil then
    begin
      if m_TargetCret = m_Master2 then
      begin //nicky
        m_TargetCret := nil;
      end
      else
      begin
        if GetAttackDir(m_TargetCret, bt06) then
        begin
          if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
          begin
            m_dwHitTick := GetTickCount();
            m_dwTargetFocusTick := GetTickCount();
            // Attack(m_TargetCret,bt06);  //FFED
          end;
          Result := True;
        end
        else
        begin
          if m_TargetCret.m_PEnvir = m_PEnvir then
          begin
            SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
            //004A8FE3
          end
          else
          begin
            DelTargetCreat(); {0FFF1h}
            //004A9009
          end;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TMagicMonster.AttackTarget');
  end;
end;

procedure TMagicMonster.Run; //004A9020
var
  nX, nY: Integer;
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
        begin
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
          if not m_boRunAwayMode then
          begin
            if not m_boNoAttackMode then
            begin
              if m_TargetCret <> nil then
              begin
                if AttackTarget {FFEB} then
                begin
                  inherited;
                  exit;
                end;
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
                //  sysmsg('recalling to my master',c_red,t_hint);
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
      MainOutMessage('[Exception] TMagicMonster.Run');
    end;
    inherited;

  except
    MainOutMessage('[Exception] TMagicMonster.Run');
  end;
end;
{ end }

{TFireballMonster}

constructor TFireballMonster.Create; //004A9690
begin
  try
    inherited;
    m_dwSpellTick := GetTickCount();
    m_dwSearchTime := Random(1500) + 1500;
  except
    MainOutMessage('[Exception] TFireballMonster.Create');
  end;
end;

destructor TFireballMonster.Destroy;
begin
  try
    inherited;
  except
    MainOutMessage('[Exception] TFireballMonster.Destroy');
  end;
end;

procedure TFireballMonster.Run; //004A9720
var
  baseobject: TBaseObject;
  //playobject:TPlayObject;
  nPower: integer;
  //UserMagic: pTUserMagic;
//    m_DefMsg                  :TDefaultMessage;
//      n08,nAttackDir:Integer;
begin
  try
    try
      if not m_boDeath and
        not bo554 and
        not m_boGhost then
      begin
        if m_targetcret <> nil then
        begin
          if self.MagCanHitTarget(m_targetcret.m_nCurrX, m_targetcret.m_nCurrY,
            m_targetcret) then
          begin
            if self.IsProperTarget(m_targetcret) then
            begin
              if (abs(m_nTargetX - m_nCurrX) <= 8) and (abs(m_nTargety -
                m_nCurry) <= 8) then
              begin
                nPower := Random(SmallInt(HiWord(m_wabil.MC) -
                  LoWord(m_WAbil.MC)) + 1) + LoWord(m_WAbil.MC);
                if nPower > 0 then
                begin
                  BaseObject := GetPoseCreate();
                  if (BaseObject <> nil) and
                    IsProperTarget(BaseObject) and
                    (m_nAntiMagic >= 0) then
                  begin
                    nPower := BaseObject.GetMagStruckDamage(Self, nPower);
                    if nPower > 0 then
                    begin
                      BaseObject.StruckDamage(nPower, self);
                      if (GetTickCount - m_dwSpellTick) >
                        LongWord(m_nNextHitTime) then
                      begin
                        m_dwSpellTick := GetTickCount();
                        self.SendRefMsg(RM_SPELL, 48, m_targetcret.m_nCurrX,
                          m_targetcret.m_nCurry, 48, '');
                        self.SendRefMsg(RM_MAGICFIRE, 0,
                          MakeWord(2, 48),
                          MakeLong(m_targetcret.m_nCurrX,
                          m_targetcret.m_nCurry),
                          Integer(m_TargetCret),
                          '');

                        self.SendDelayMsg(TBaseObject(RM_STRUCK), RM_DELAYMAGIC,
                          nPower, MakeLong(m_targetcret.m_nCurrX,
                          m_targetcret.m_nCurrY), 2, integer(m_targetcret), '',
                          600);
                      end; //if npower
                    end; //if wait
                  end;
                end;
              end;
            end;
          end;
          BreakHolySeizeMode();
        end
        else
          m_targetcret := nil;
        if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret =
          nil)) then
        begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();
        end;
      end;
    except
      MainOutMessage('[Exception] TFireballMonster.Run');
    end;
    inherited;
  except
    MainOutMessage('[Exception] TFireballMonster.Run');
  end;
end;

constructor TFireMonster.Create; //004A9690
begin
  try
    inherited;
    m_dwSearchTime := Random(1500) + 1500;
  except
    MainOutMessage('[Exception] TFireMonster.Create');
  end;
end;

destructor TFireMonster.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TFireMonster.Destroy');
  end;
end;

procedure TFireMonster.Run; //004A9720
var
  FireBurnEvent: TFireBurnEvent;
  nx, ny, ndamage, ntime: integer;
begin
  try
    try
      if not m_boDeath and
        not bo554 and
        not m_boGhost and
        (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
      begin
        // do sqaure around boss
        ntime := 20;
        ndamage := 10;
        nx := m_ncurrx;
        ny := m_ncurry;
        //bx:=bx+1;
       // by:=by+1;

        if m_PEnvir.GetEvent(nX, nY - 1) = nil then
        begin
          FireBurnEvent := TFireBurnEvent.Create(self, nX, nY - 1, ET_FIRE, nTime
            * 1000, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end; //0492CFC   x //
        if m_PEnvir.GetEvent(nX, nY - 2) = nil then
        begin
          FireBurnEvent := TFireBurnEvent.Create(self, nX, nY - 2, ET_FIRE, nTime
            * 1000, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end; //0492CFC   x

        if m_PEnvir.GetEvent(nX - 1, nY) = nil then
        begin
          FireBurnEvent := TFireBurnEvent.Create(self, nX - 1, nY, ET_FIRE, nTime
            * 1000, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end; //0492D4D //
        if m_PEnvir.GetEvent(nX - 2, nY) = nil then
        begin
          FireBurnEvent := TFireBurnEvent.Create(self, nX - 2, nY, ET_FIRE, nTime
            * 1000, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end; //0492D4D

        if m_PEnvir.GetEvent(nX, nY) = nil then
        begin
          FireBurnEvent := TFireBurnEvent.Create(self, nX, nY, ET_FIRE, nTime *
            1000, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end; //00492D9C

        if m_PEnvir.GetEvent(nX + 1, nY) = nil then
        begin
          FireBurnEvent := TFireBurnEvent.Create(self, nX + 1, nY, ET_FIRE, nTime
            * 1000, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end; //00492DED
        if m_PEnvir.GetEvent(nX + 2, nY) = nil then
        begin
          FireBurnEvent := TFireBurnEvent.Create(self, nX + 2, nY, ET_FIRE, nTime
            * 1000, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end; //00492DED

        if m_PEnvir.GetEvent(nX, nY + 1) = nil then
        begin
          FireBurnEvent := TFireBurnEvent.Create(self, nX, nY + 1, ET_FIRE, nTime
            * 1000, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end; //00492E3E
        if m_PEnvir.GetEvent(nX, nY + 2) = nil then
        begin
          FireBurnEvent := TFireBurnEvent.Create(self, nX, nY + 2, ET_FIRE, nTime
            * 1000, nDamage);
          g_EventManager.AddEvent(FireBurnEvent);
        end; //00492E3E

        {do flames behind}
       {if m_PEnvir.GetEvent(bx,by) = nil then begin  //behind
           FireBurnEvent:=TFireBurnEvent.Create(Self,bx,by,ET_FIRE,ntime * 1000 ,ndamage);
           g_EventManager.AddEvent(FireBurnEvent);
       end;
       if m_PEnvir.GetEvent(bx+1,by+1) = nil then begin  //behind
           FireBurnEvent:=TFireBurnEvent.Create(Self,bx+1,by+1,ET_FIRE,ntime * 1000 ,ndamage);
           g_EventManager.AddEvent(FireBurnEvent);
       end;
       if m_PEnvir.GetEvent(fx,fy) = nil then begin  //behind
           FireBurnEvent:=TFireBurnEvent.Create(Self,fx,fy,ET_FIRE,ntime * 1000 ,ndamage);
           g_EventManager.AddEvent(FireBurnEvent);
       end;
       if m_PEnvir.GetEvent(fx+1,fy+1) = nil then begin  //behind
           FireBurnEvent:=TFireBurnEvent.Create(Self,fx+1,fy+1,ET_FIRE,ntime * 1000 ,ndamage);
           g_EventManager.AddEvent(FireBurnEvent);
       end;    }

       {if m_PEnvir.GetEvent(bx-1,by) = nil then begin  //behind
           FireBurnEvent:=TFireBurnEvent.Create(Self,bx-1,by,ET_FIRE,ntime * 1000 ,ndamage);
           g_EventManager.AddEvent(FireBurnEvent);
       end;
       if m_PEnvir.GetEvent(bx-2,by) = nil then begin  //behind
           FireBurnEvent:=TFireBurnEvent.Create(Self,bx-2,by,ET_FIRE,ntime * 1000 ,ndamage);
           g_EventManager.AddEvent(FireBurnEvent);
       end;
       if m_PEnvir.GetEvent(bx-2,by+1) = nil then begin  //down left
           FireBurnEvent:=TFireBurnEvent.Create(Self,bx-2,by+1,ET_FIRE,ntime * 1000 ,ndamage);
           g_EventManager.AddEvent(FireBurnEvent);
       end;
       if m_PEnvir.GetEvent(bx-2,by+2) = nil then begin  //down left
           FireBurnEvent:=TFireBurnEvent.Create(Self,bx-2,by+2,ET_FIRE,ntime * 1000 ,ndamage);
           g_EventManager.AddEvent(FireBurnEvent);
       end;
       if m_PEnvir.GetEvent(fx,fy) = nil then begin  //front
           FireBurnEvent:=TFireBurnEvent.Create(Self,fx,fy,ET_FIRE,ntime * 1000 ,ndamage);
           g_EventManager.AddEvent(FireBurnEvent);
       end;
       if m_PEnvir.GetEvent(fx-1,fy) = nil then begin  //front
           FireBurnEvent:=TFireBurnEvent.Create(Self,fx-1,fy,ET_FIRE,ntime * 1000 ,ndamage);
           g_EventManager.AddEvent(FireBurnEvent);
       end;
       if m_PEnvir.GetEvent(fx+1,fy) = nil then begin  //front
           FireBurnEvent:=TFireBurnEvent.Create(Self,fx+1,fy,ET_FIRE,ntime * 1000 ,ndamage);
           g_EventManager.AddEvent(FireBurnEvent);
       end;
       if m_PEnvir.GetEvent(fx+2,fy) = nil then begin  //front
           FireBurnEvent:=TFireBurnEvent.Create(Self,fx+2,fy,ET_FIRE,ntime * 1000 ,ndamage);
           g_EventManager.AddEvent(FireBurnEvent);
       end;
       if m_PEnvir.GetEvent(fx+2,fy-1) = nil then begin  //front
           FireBurnEvent:=TFireBurnEvent.Create(Self,fx+2,fy-1,ET_FIRE,ntime * 1000 ,ndamage);
           g_EventManager.AddEvent(FireBurnEvent);
       end;
       if m_PEnvir.GetEvent(fx+2,fy-2) = nil then begin  //front
           FireBurnEvent:=TFireBurnEvent.Create(Self,fx+2,fy-2,ET_FIRE,ntime * 1000 ,ndamage);
           g_EventManager.AddEvent(FireBurnEvent);
       end;  }

        if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret =
          nil)) then
        begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();
        end;
      end;
    except
      MainOutMessage('[Exception] TFireMonster.Run');
    end;
    inherited;
  except
    MainOutMessage('[Exception] TFireMonster.Run');
  end;
end;

{ TFrostTigerMonster }

constructor TFrostTiger.Create; //004A9690
begin
  try
    inherited;
    m_dwSearchTime := Random(1500) + 1500;
  except
    MainOutMessage('[Exception] TFrostTiger.Create');
  end;
end;

destructor TFrostTiger.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TFrostTiger.Destroy');
  end;
end;

procedure TFrostTiger.Run; //004A9720
//var
//BaseObject:TBaseObject;
//dosay:boolean;
begin
  try
    try
      if not m_boDeath and
        not bo554 and
        not m_boGhost and
        (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
      begin

        if m_TargetCret = nil then
        begin
          if m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] = 0 then
          begin
            MagicManager.MagMakePrivateTransparent(Self, 180);
          end;
        end
        else
        begin
          //mainoutmessage('process say');
           // ProcessSayMsg('I see you ' + m_TargetCret.m_sCharName + ', you will be sorry!');
          //  dosay:=true;
          m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] := 0;
        end;

        if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret =
          nil)) then
        begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();
        end;
      end;
    except
      MainOutMessage('[Exception] TFrostTiger.Run');
    end;
    inherited;
  except
    MainOutMessage('[Exception] TFrostTiger.Run');
  end;
end;

{ TGreenMonster }

constructor TGreenMonster.Create; //004A9690
begin
  try
    inherited;
    m_dwSearchTime := Random(1500) + 1500;
  except
    MainOutMessage('[Exception] TGreenMonster.Create');
  end;
end;

destructor TGreenMonster.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TGreenMonster.Destroy');
  end;
end;

procedure TGreenMonster.Run; //004A9720
begin
  try
    try
      if not m_boDeath and
        not bo554 and
        not m_boGhost and
        (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
      begin
        if m_TargetCret <> nil then
        begin
          m_nTargetX := m_TargetCret.m_nCurrX;
          m_nTargetY := m_TargetCret.m_nCurrY;
          if (abs(m_nTargetX - m_nCurrX) = 1) and (abs(m_nTargety - m_nCurry) =
            1) then
          begin
            if (Random(m_TargetCret.m_btAntiPoison + 7) <= 6) and
              (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) then
            begin
              m_TargetCret.MakePosion(POISON_DECHEALTH, 30, 1);
            end;
          end;
        end;
        if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret =
          nil)) then
        begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();
        end;
      end;
    except
      MainOutMessage('[Exception] TGreenMonster.Run');
    end;
    inherited;
  except
    MainOutMessage('[Exception] TGreenMonster.Run');
  end;
end;

{ TRedMonster }

constructor TRedMonster.Create; //004A9690
begin
  try
    inherited;
    m_dwSearchTime := Random(1500) + 1500;
  except
    MainOutMessage('[Exception] TRedMonster.Create');
  end;
end;

destructor TRedMonster.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TRedMonster.Destroy');
  end;
end;

procedure TRedMonster.Run; //004A9720
begin
  try
    try
      if not m_boDeath and
        not bo554 and
        not m_boGhost and
        (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
      begin
        if m_TargetCret <> nil then
        begin
          m_nTargetX := m_TargetCret.m_nCurrX;
          m_nTargetY := m_TargetCret.m_nCurrY;
          if (abs(m_nTargetX - m_nCurrX) = 1) and (abs(m_nTargety - m_nCurry) =
            1) then
          begin
            if (Random(m_TargetCret.m_btAntiPoison + 7) <= 6) and
              (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) then
            begin
              m_TargetCret.MakePosion(POISON_DAMAGEARMOR, 30, 1);
            end;
          end;
        end;
        if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret =
          nil)) then
        begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();
        end;
      end;
    except
      MainOutMessage('[Exception] TRedMonster.Run');
    end;
    inherited;
  except
    MainOutMessage('[Exception] TRedMonster.Run');
  end;
end;

{ khazard }

constructor TKhazard.Create; //004A9690
begin
  try
    inherited;
    m_dwSearchTime := Random(1500) + 1500;
  except
    MainOutMessage('[Exception] TKhazard.Create');
  end;
end;

destructor TKhazard.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TKhazard.Destroy');
  end;
end;

procedure TKhazard.Run; //004A9720
var
  time1, nx, ny: integer;
begin
  try
    //time1:=-1;
    try
      if not m_boDeath and
        not bo554 and
        not m_boGhost and
        (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
      begin
        time1 := random(2);
        if m_TargetCret <> nil then
        begin
          m_nTargetX := m_TargetCret.m_nCurrX;
          m_nTargetY := m_TargetCret.m_nCurrY;
          if (abs(m_nTargetX - m_nCurrX) = 2) and (abs(m_nTargety - m_nCurry) =
            2) then
          begin
            if time1 = 0 then
            begin //do drag back on random
              GetFrontPosition(nx, ny);
              m_TargetCret.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
              m_TargetCret.SpaceMove(M_sMapName, nx, ny, 0);
              if (Random(1) = 0) and (Random(m_TargetCret.m_btAntiPoison + 7) <=
                6) then
              begin
                m_TargetCret.MakePosion(POISON_DECHEALTH, 35, 2);
                exit;
              end;
            end
            else
            begin
              if m_TargetCret.m_wAbil.HP <= m_TargetCret.m_wAbil.MaxHP div 2
                then
                //if target below half hp
                GetFrontPosition(nx, ny);
              m_TargetCret.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
              m_TargetCret.SpaceMove(M_sMapName, nx, ny, 0);
              if (Random(1) = 0) and (Random(m_TargetCret.m_btAntiPoison + 7) <=
                6) then
              begin
                m_TargetCret.MakePosion(POISON_DECHEALTH, 35, 2);
                exit;
              end;
            end;
          end;
        end;
        if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret =
          nil)) then
        begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();
        end;
      end;
    except
      MainOutMessage('[Exception] TKhazard.Run');
    end;
    inherited;
  except
    MainOutMessage('[Exception] TKhazard.Run');
  end;
end;
{ end }

{ runaway }
{constructor TRunAway.Create; //004A9690
begin
Try
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
Except
  MainOutMessage('[Exception] TRunAway.Create');
End;
end;

destructor TRunAway.Destroy;
begin
Try

  inherited;
Except
  MainOutMessage('[Exception] TRunAway.Destroy');
End;
end;

procedure TRunAway.Run;//004A9720
var
time1,nx,ny:integer;
borunaway:boolean;
begin
Try
  Try
  borunaway:=false;
  if not m_boDeath and
     not bo554 and
     not m_boGhost then begin
if m_TargetCret <> nil then begin
      m_nTargetX:=m_TargetCret.m_nCurrX;
     m_nTargetY:=m_TargetCret.m_nCurrY;
 if (m_wabil.HP <= round(m_wabil.MaxHP div 2)) and (borunaway=false) then begin //if health less then 1/2
    GetFrontPosition(nx,ny);
       SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
       SpaceMove(M_sMapName, nx - 2, ny - 2, 0);  //move backwards 3 spaces
    borunaway:=true;
    end else begin
 if m_wabil.HP >= round(m_wabil.MaxHP div 2) then begin
    borunaway:=false;
 end;
 end;
  if borunaway then begin
     if Integer(GetTickCount - LongWord(time1)) > 5000 then begin
  if (abs(m_nTargetX-m_ncurrx)=1) and (abs(m_nTargety-m_ncurry)=1) then begin
     walkto(random(4),true);
  end else begin
     walkto(random(7),true);
  end;
     end else begin
//       time1:=GetTickCount();
     end;
     end;
     end;
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  Except
    MainOutMessage('[Exception] TRunAway.Run');
  end;
  inherited;
Except
  MainOutMessage('[Exception] TRunAway.Run');
End;
end;    }
{ end }

{ Tele mob }

constructor TTeleMonster.Create; //004A9690
begin
  try
    inherited;
    m_dwSearchTime := Random(1500) + 1500;
  except
    MainOutMessage('[Exception] TTeleMonster.Create');
  end;
end;

destructor TTeleMonster.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TTeleMonster.Destroy');
  end;
end;

procedure TTeleMonster.Run; //004A9720
begin
  try
    try
      if not m_boDeath and
        not bo554 and
        not m_boGhost and
        (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
      begin
        //if it finds a target tele to him!
        if m_TargetCret <> nil then
        begin
          if (abs(m_nCurrX - m_nTargetX) > 5) or
            (abs(m_nCurrY - m_nTargetY) > 5) then
          begin
            // if 5 spaces away teleport to the enemy!
            SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
            SpaceMove(m_TargetCret.M_sMapName, m_TargetCret.m_nCurrX,
              m_TargetCret.m_nCurrY, 0);
          end;
        end;
        //end
        if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret =
          nil)) then
        begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();
        end;
      end;
    except
      MainOutMessage('[Exception] TTeleMonster.Run');
    end;
    inherited;
  except
    MainOutMessage('[Exception] TTeleMonster.Run');
  end;
end;
{ end }

{ Defend Monster }

constructor TDefendMonster.Create; //004A9690
begin
  try
    inherited;
    m_dwSearchTime := Random(1500) + 1500;
  except
    MainOutMessage('[Exception] TDefendMonster.Create');
  end;
end;

destructor TDefendMonster.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TDefendMonster.Destroy');
  end;
end;

procedure TDefendMonster.Run; //004A9720
begin
  try
    {if not m_boDeath and
       not bo554 and
       not m_boGhost then begin
    //if it finds a target 15 spaces away start sequence
    if (m_TargetCret <> nil) and (callguardrun=false) then begin

             // call guards!
             mainoutmessage('CALL GUARD' + inttostr(m_nCurrX) + ' ' + inttostr(m_nCurrY));
             callguard(m_sMapName,m_nCurrX,m_nCurrY);
            end;

      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
         (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
        m_dwSearchEnemyTick:=GetTickCount();
        SearchTarget();
      end;
    end;   }
    inherited;
  except
    MainOutMessage('[Exception] TDefendMonster.Run');
  end;
end;

{procedure TDefendMonster.callguard(mapmap:string; xx,yy:integer);
var
  I: Integer;
  nC:Integer;
  nx,ny:Integer;
  sMonName:array[0..3] of String;
  BaseObject:TBaseObject;
begin
Try
  nC:=7; //how many areas around the boss
 // GetFrontPosition(nx,ny);
  sMonName[0]:='Hen';
 // sMonName[1]:=sZuma2;
 // sMonName[2]:=sZuma3;
 // sMonName[3]:=sZuma4;
    nx:=xx;
    ny:=yy;

  for I := 0 to nC do begin
  { case i of
    0: begin
    Dec(nY);
    end;
    1: begin
       Inc(nX);
       Dec(nY);
      end;
    2: begin
     Inc(nX)
     end;
    3: begin
    Inc(nX);
       Inc(nY);
       end;
    4: begin
     Inc(nY);
     end;
    5: begin
             Dec(nX);
       Inc(nY);
       end;
    6: begin
     Dec(nX);
     end;
    7: begin
             Dec(nX);
        Dec(nY);
        end;
    end;
   // if m_GuardObjects.Count >= 5 then break;
    BaseObject:=UserEngine.RegenMonsterByName(mapmap,nx,ny,sMonName[0]);
    if BaseObject <> nil then begin
      m_GuardObjects.Add(BaseObject);
    end;
  end;    // for
  callguardrun:=true;//tell it its already been run!
Except
  MainOutMessage('[Exception] TDefendMonster.callguard');
End;
end;  }

constructor TClone.Create; //004AA4B4
begin
  try
    inherited;
    m_dwSearchTime := Random(1500) + 1500;
  except
    MainOutMessage('[Exception] TClone.Create');
  end;
end;

destructor TClone.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TClone.Destroy');
  end;
end;

{function TClone.Operate(ProcessMsg:pTProcessMessage):boolean;
 begin
  if (ProcessMsg.wIdent = RM_STRUCK) or (ProcessMsg.wIdent = RM_MAGSTRUCK) or (ProcessMsg.wIdent = RM_SPELL) then begin
   if m_master <> nil then begin
    if m_master.m_WAbil.mp <= 0 then m_wabil.HP:=0;//kill slave if your mp is 0
     if (ProcessMsg.wIdent = RM_SPELL) then begin
      mainoutmessage('rmSpell: ' + inttostr(processmsg.nParam3));
      dec(m_master.m_wabil.mp,ProcessMsg.nParam3);
      end else begin
      mainoutmessage('rmHit: ' + inttostr(processmsg.wParam));
      dec(m_master.m_wabil.mp,ProcessMsg.wParam);
   end;
   end;
end;
end;         }

procedure TClone.LightingAttack(nDir: Integer);
var
  nSX, nSY, nTX, nTY, nPwr: Integer;
  WAbil: pTAbility;
begin
  try
    m_btDirection := nDir;
    SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
    if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, nDir, 1, nSX, nSY) then
    begin
      m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, nDir, 9, nTX, nTY);
      WAbil := @m_WAbil;
      nPwr := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) +
        LoWord(WAbil.DC));
      MagPassThroughMagic(nSX, nSY, nTX, nTY, nDir, nPwr, True);
    end;
    BreakHolySeizeMode();
  except
    MainOutMessage('[Exception] TClone.Operate');
  end;
end;

procedure TClone.Struck(hiter: TBaseObject);
begin
  try
    if hiter = nil then
      exit;
    {m_btDirection:=hiter.m_btDirection;
    n550:=Random(4) + (n550 + 4);
    n550:=_MIN(20,n550);
    m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,m_btDirection,n550,m_nTargetX,m_nTargetY);}
  except
    MainOutMessage('[Exception] TClone.Struck');
  end;
end;

procedure TClone.Run; //004AA604
var
  //  n08,
  nAttackDir: Integer;
begin
  try
    //  n08:=9999;
    try
      if (not m_boDeath) and
        (not bo554) and
        (not m_boGhost) and
        (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) and
        ((GetTickCount - m_dwSearchEnemyTick) > 8000) then
      begin

        if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)
          then
        begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();
          //nicky
          //SearchMobF;
        end;
        if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) and
          (m_TargetCret <> nil) and
          (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) and
          (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 4) then
        begin
          if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and
            (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 2) and
            (Random(3) <> 0) then
          begin
            inherited;
            exit;
          end;
          GetBackPosition(m_nTargetX, m_nTargetY);
        end;
        if (m_TargetCret <> nil) and
          (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 6) and
          (abs(m_nCurrY - m_TargetCret.m_nCurrY) < 6) and
          (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then
        begin

          m_dwHitTick := GetTickCount();
          nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY,
            m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          LightingAttack(nAttackDir);
        end;
      end;
    except
      MainOutMessage('[Exception] TClone.Run');
    end;
    inherited;
  except
    MainOutMessage('[Exception] TClone.Run');
  end;
end;

end.

