//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理

//分身(人型怪物)处理单元
unit ObjClone;

interface
uses
  Windows, Classes, SysUtils, ObjBase, StrUtils, SDK, Grobal2, Envir, ItmUnit,
    ObjMon,
  INIFiles;

type
  TPlayCloneObject = class(TATMonster)
    m_dwRunMagicIntervalTime: LongWord;
    m_dwRunTime: LongWord;
    m_AmuletIdx: Integer;
    m_ButchItemList: TList;
    m_ButchNotItemDelGold: Boolean;
    m_ButchAllItems: Boolean;

    m_boCloneButchItem: Boolean;
    m_nCloneButchCls: Byte;
    m_nCloneButchUserItemRate: Integer;
    m_nCloneButchCount: Integer;
    m_nCloneButchRate: Integer;
    m_nDropUseItemRate: Integer;
  private
    function HeroWarrAttackTarget(): Boolean;
    function HeroWizardAttackTarget(): Boolean;
    function HeroTaosAttackTarget(): Boolean;
    function HeroGetCrsHitCount(): Integer;
    function HeroGetWideCount(): Integer;
    function DoSpell(UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
      BaseObject: TBaseObject): boolean;
    function GetSpellPoint(UserMagic: pTUserMagic): Integer;
    function CanMotaebo(BaseObject: TBaseObject; nMagicLevel: Integer): Boolean;
    function DoMotaebo(nDir: Byte; nMagicLevel: Integer): Boolean;
    function LoadMonitems(FileName: string; var ItemList: TList): Integer;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    function GetFeature(BaseObject: TBaseObject): Integer; override;
    //procedure MoveToEx();
    procedure GotoTargetXY(); override;
    function AttackTarget(): Boolean; override; //FFEB
    procedure MakeGhost; override;
    procedure LoadUserData(boClone: Boolean);
    function GetShowName(): string; override;
  end;

implementation
uses
  M2Share, Hutil32;

constructor TPlayCloneObject.Create();
begin
  inherited;
  m_boCloneNoDropItem := True;
  m_dwRunMagicIntervalTime := g_Config.dwRunMagicIntervalTime;
  m_nSoftVersionDateEx := VERSION_NUMBER;
  m_dwClientTickEx := VERSION_NUMBER;
  m_dwClientTick := VERSION_NUMBER;
  m_dwRunTime := 0;
  m_AmuletIdx := 0;
  m_ButchItemList := nil;
  m_boCloneButchItem := False;
  m_ButchNotItemDelGold := True;
  m_ButchAllItems := False;
  m_nDropUseItemRate := g_Config.nDieDropUseItemRate;
end;

destructor TPlayCloneObject.Destroy;
var
  i: integer;
begin
  //m_ButchItemList.Free;
  if m_ButchItemList <> nil then
  begin
    for I := 0 to m_ButchItemList.Count - 1 do
      Dispose(pTUserItem(m_ButchItemList.Items[I]));
    m_ButchItemList.Free;
  end;
  m_ButchItemList := nil;
  inherited;
end;

function TPlayCloneObject.GetShowName(): string;
begin
  try
    if (m_CloneHum <> nil) and (g_Config.boCloneShowMasterName) then
    begin
        m_OldShowName := m_CloneHum.m_OldShowName;
        m_NewShowName := m_OldShowName;
        Result := m_OldShowName;
    end
    else
    begin
      if (m_UseItems[U_STRAW].wIndex > 0) and (g_Config.boCloneShowMystery) then
      begin
        Result := '神秘人';
        m_OldShowName := Result;
        m_NewShowName := GetAddName(Result, 0);
      end
      else
        Result := inherited GetShowName();
    end;
  except
    MainOutMessage('[Exception] TPlayCloneObject.GetShowName');
  end;
end;

procedure TPlayCloneObject.Run;
begin
  try
    //人型怪MP用不完
    m_WAbil.MP := 1000;
    m_WAbil.MaxMP := 1000;
    m_Abil.MP := 1000;
    m_Abil.MaxMP := 1000;
    if (m_dwRunTime > 0) and (GetTickCount > m_dwRunTime) then
      MakeGhost;
  except
    MainOutMessage('[Exception] TPlayCloneObject.Run');
  end;
  inherited;
end;

procedure TPlayCloneObject.MakeGhost;
begin
  if m_CloneHum <> nil then
  begin
    m_CloneHum.m_Clone := nil;
    m_CloneHum.m_CallCloneTick := GetTickCount;
    m_CloneHum.SysMsg(sPlayCloneMakeGhostMsg, c_Green, t_System);
  end;
  inherited;
end;

procedure TPlayCloneObject.LoadUserData(boClone: Boolean);
var
  INI: TINIFile;
  sFileName: string;
  sItemName: string;
  I: integer;
  //  StdItem:TItem;
  sMagic, sMagicName: string;
  Magic: pTMagic;
  UserMagic, UserMagic18: pTUserMagic;
  PlayObject: TBaseObject;
begin
  try
    if boClone and (m_Master2 <> nil) then
    begin
      PlayObject := m_Master2;
      if PlayObject <> nil then
      begin
        if g_Config.nPlayCloneTime > 0 then
          m_dwRunTime := GetTickCount + g_Config.nPlayCloneTime;
        m_btRaceServer := RC_PLAYCLONE;
        m_btDirection := PlayObject.m_btDirection;
        m_WAbil := PlayObject.m_WAbil;
        m_Abil := PlayObject.m_Abil;
        m_UseItems := PlayObject.m_UseItems;
        m_btSpeedPoint := PlayObject.m_btSpeedPoint;
        m_btHitPoint := PlayObject.m_btHitPoint;
        m_btJob := PlayObject.m_btJob;
        m_btGender := PlayObject.m_btGender;
        m_btHair := PlayObject.m_btHair;
        m_boCloneButchItem := False;
        m_boCloneNoDropItem := True;
        case m_btJob of
          JOB_WARR:
            begin
              m_nNextHitTime := g_Config.nWarrAttackTick;
              m_nWalkSpeed := g_Config.nWarrWalkTime;
            end;
          JOB_WIZARD:
            begin
              m_nNextHitTime := g_Config.nWizardAttackTick;
              m_nWalkSpeed := g_Config.nWizardWalkTime;
            end;
          JOB_TAOS:
            begin
              m_nNextHitTime := g_Config.nTaosAttackTick;
              m_nWalkSpeed := g_Config.nTaosWalkTime;
            end;
        end;
        m_dwWalkWait := m_nWalkSpeed;
        for i := 0 to m_ItemList.Count - 1 do
        begin
          Dispose(PTUserItem(m_ItemList.Items[i]));
        end;
        m_ItemList.Clear;
        for I := 0 to PlayObject.m_MagicList.Count - 1 do
        begin
          UserMagic := PlayObject.m_MagicList.Items[i];
          New(UserMagic18);
          UserMagic18^ := UserMagic^;
          m_MagicList.Add(UserMagic18);
          if UserMagic18.wMagIdx in [Low(m_HeroMagic)..High(m_HeroMagic)] then
            m_HeroMagic[UserMagic18.wMagIdx] := UserMagic18;
        end;
        RecalcAbilitys;
      end;
    end
    else
    begin
      sFileName := g_Config.sEnvirDir + MONUSEITEMS + m_sCharName + '.txt';
      INI := TINiFile.Create(sFileName);
      //m_NotCheckAmulet:=g_Config.boCloneNotCheckAmulet;
      try
        if INI <> nil then
        begin
          m_boCloneNoDropItem := not INI.ReadBool('Info', 'DropUseItem', False);
          m_nDropUseItemRate := INI.ReadInteger('Info', 'DropUseItemRate',
            g_Config.nDieDropUseItemRate);
          m_boCloneButchItem := INI.ReadBool('Info', 'ButchUseItem', False);
          m_nCloneButchCls := INI.ReadInteger('Info', 'ButchChargeClass', 1);
          m_nCloneButchCount := INI.ReadInteger('Info', 'ButchChargeCount', 1);
          m_ButchNotItemDelGold := INI.ReadBool('Info', 'ButchNotItemDelGold',
            True);
          m_ButchAllItems := INI.ReadBool('Info', 'ButchAllItems', False);
          m_nCloneButchRate := INI.ReadInteger('Info', 'ButchRate', 10);
          m_nCloneButchUserItemRate := INI.ReadInteger('Info',
            'ButchUserItemRate', 3);
          m_btJob := INI.ReadInteger('Info', 'Job', 0);
          m_btGender := INI.ReadInteger('Info', 'Gender', 0);
          m_btHair := _MIN(1, INI.ReadInteger('Info', 'Hair', 1));
          if m_btJob > 2 then
            m_btJob := 0;
          if m_btGender > 1 then
            m_btGender := 0;
          sFileName := g_Config.sEnvirDir + MONUSEITEMS + m_sCharName +
            '-Item.txt';
          LoadMonitems(sFileName, m_ButchItemList);
          //if FileExists(sFileName) then m_ButchItemList.LoadFromFile(sFileName);
          sMagic := Ini.ReadString('Info', 'UseSkill', '');
          while (sMagic <> '') do
          begin
            sMagic := GetValidStr3(sMagic, sMagicName, [',']);
            Magic := UserEngine.FindMagic(sMagicName, False);
            if Magic <> nil then
            begin

              New(UserMagic);
              UserMagic.MagicInfo := Magic;
              UserMagic.wMagIdx := Magic.wMagicId;
              UserMagic.btLevel := 3;
              UserMagic.btKey := 0;
              UserMagic.nTranPoint := 0;
              m_MagicList.Add(UserMagic);
              if Magic.wMagicID in [Low(m_HeroMagic)..High(m_HeroMagic)] then
                m_HeroMagic[Magic.wMagicId] := UserMagic;
            end;
          end;
          for I := Low(m_UseItems) to High(m_UseItems) do
          begin
            sItemName := Ini.ReadString('UseItems', 'UseItems' + IntToStr(I),
              '');
            if sItemName <> '' then
            begin
              UserEngine.CopyToUserItemFromName(sItemName, @m_UseItems[I]);
            end;
          end;
        end;
        if (m_Abil.HP = 0) or (m_Abil.MP = 0) then
        begin
          RecalcLevelAbilitys;
          m_WAbil.HP := m_Abil.MaxHP;
          m_WAbil.MP := m_Abil.MaxMP;
          m_WAbil.MaxHP := m_Abil.MaxHP;
          m_WAbil.MaxMP := m_Abil.MaxMP;
          m_Abil.HP := m_Abil.MaxHP;
          m_Abil.MP := m_Abil.MaxMP;
        end;
        m_Abil.AC := m_WAbil.AC;
        m_Abil.MAC := m_WAbil.MAC;
        m_Abil.DC := m_WAbil.DC;
        m_Abil.MC := m_WAbil.DC;
        m_Abil.SC := m_WAbil.DC;
        RecalcAbilitys;
      finally
        INI.Free;
      end;
    end;
  except
    MainOutMessage('[Exception] TPlayCloneObject.LoadUserData');
  end;
end;

function TPlayCloneObject.GetFeature(BaseObject: TBaseObject): Integer;
var
  nDress, nWeapon, nHair: Integer;
  StdItem: TItem;
  //  bo25:Boolean;
  //  I:integer;
begin
  try
    nDress := 0;
    //衣服
    if m_UseItems[U_DRESS].wIndex > 0 then
    begin
      StdItem := UserEngine.GetStdItem(m_UseItems[U_DRESS].wIndex);
      if StdItem <> nil then
      begin
        nDress := StdItem.Shape * 2;
      end;
    end;
    Inc(nDress, m_btGender);
    nWeapon := 0;
    //武器
    if m_UseItems[U_WEAPON].wIndex > 0 then
    begin
      StdItem := UserEngine.GetStdItem(m_UseItems[U_WEAPON].wIndex);
      if StdItem <> nil then
      begin
        nWeapon := StdItem.Shape * 2;
      end;
    end;
    Inc(nWeapon, m_btGender);
    nHair := m_btHair * 2 + m_btGender;
    if m_UseItems[U_STRAW].wIndex > 0 then
    begin
     StdItem := UserEngine.GetStdItem(m_UseItems[U_STRAW].wIndex);
      if StdItem <> nil then
      if StdItem.Shape=0 then
        nHair := 6 + m_btGender
      else
        nHair := 8 + m_btGender;//王者斗笠
    end;
    Result := MakeHumanFeature(0, nDress, nWeapon, nHair);
  except
    MainOutMessage('[Exception] TPlayCloneObject.GetFeature');
  end;
end;

procedure TPlayCloneObject.GotoTargetXY();
var
  nX, nY, nDir: Integer;
  //  btDir:Byte;
begin
  try
    if (abs(m_nCurrX - m_nTargetX) > 2) or
      (abs(m_nCurrY - m_nTargetY) > 2) then
    begin
      if abs(m_nTargetX - m_nCurrX) > 1 then
      begin
        if (m_nTargetX > m_nCurrX) then
          nX := m_nCurrX + 2
        else
          nX := m_nCurrX - 2;
      end
      else
        nX := m_nTargetX;
      if abs(m_nTargetY - m_nCurrY) > 1 then
      begin
        if (m_nTargetY > m_nCurrY) then
          nY := m_nCurrY + 2
        else
          nY := m_nCurrY - 2;
      end
      else
        nY := m_nTargetY;
      nDir := GetNextDirection(m_nCurrX, m_nCurrY, nX, nY);
      if RunTo(nDir, False, nX, nY) then
      begin //006072
        if m_boTransparent and (m_boHideMode) then
          m_wStatusTimeArr[STATE_TRANSPARENT] := 1; //004CB212
        Dec(m_nHealthTick, 60);
        Dec(m_nSpellTick, 10);
        m_nSpellTick := _MAX(0, m_nSpellTick);
        Dec(m_nPerHealth);
        Dec(m_nPerSpell);
      end
      else
        inherited; //006072
    end
    else
      inherited;
  except
    MainOutMessage('[Exception] TPlayObject.HeroTail');
  end;
end;

function TPlayCloneObject.AttackTarget(): Boolean;
begin
  try
    Result := False;
    if m_TargetCret <> nil then
    begin
      if m_Abil.Level > 6 then
      begin
        case m_btJob of
          Job_Warr: Result := HeroWarrAttackTarget;
          JOB_WIZARD: Result := HeroWizardAttackTarget;
          JOB_TAOS: Result := HeroTaosAttackTarget;
        else
          Result := inherited AttackTarget();
        end
      end
      else
        Result := inherited AttackTarget();
      if (not Result) and (m_TargetCret <> nil) then
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
    MainOutMessage('[Exception] TPlayCloneObject.AttackTarget');
  end;
end;

//道士英雄攻击处理

function TPlayCloneObject.HeroTaosAttackTarget(): Boolean; //004A8E54
var
  btDir: Byte;
  //  boSet:Boolean;
  UserMagic: pTUserMagic;
  nCheckCode: Integer;
  TargeTBaseObject: TBaseObject;
  TargeX, TargeY: Integer;
  MySideCount, AttackSideCount: Integer;
  n14: Byte;
  boAmuporc: Byte;
  nAmuporcCount: Integer;
  boMove: Boolean;

  procedure RefTaosCorpsItem();
  var
    AmuletStdItem: TItem;
  begin
    boAmuporc := 0;
    if (UserMagic <> nil) or (m_TargetCret = nil) then
      exit;
    if (not g_Config.boCloneNotCheckAmulet2) then
    begin
      if m_UseItems[U_BUJUK].wIndex > 0 then
      begin
        AmuletStdItem := UserEngine.GetStdItem(m_UseItems[U_BUJUK].wIndex);
        if (AmuletStdItem <> nil) and (AmuletStdItem.StdMode = 25) then
        begin
          nAmuporcCount := ROUND(m_UseItems[U_BUJUK].Dura / 100);
          case AmuletStdItem.Shape of
            5:
              begin //护身符
                boAmuporc := 1;
              end;
            1:
              begin //灰色药粉
                boAmuporc := 2;
              end;
            2:
              begin //黄色药粉
                boAmuporc := 3;
              end;
          end;
        end;
      end;
    end;
  end;

  procedure CheckAttack(btBy: Byte);
  begin
    if (TargeTBaseObject = nil) or (UserMagic <> nil) then
      exit;
    (*if (m_Master2=Nil) or g_Config.boCloneMakeSlave then begin
      if (m_SlaveList.Count < g_Config.nFairyCount) and
         (m_HeroMagic[72{召唤月灵}]<>Nil) and
         ((boAmuporc = 1) or (g_Config.boCloneNotCheckAmulet2))  then begin
        UserMagic:=GetMagicInfoEx(72);
      end else
      if (m_SlaveList.Count < g_Config.nDragonCount) and
         (m_HeroMagic[30{召唤神兽}]<>Nil) and
         ((boAmuporc = 1) or (g_Config.boCloneNotCheckAmulet2)) then begin
        UserMagic:=GetMagicInfoEx(30);
      end else
      if (m_SlaveList.Count < g_Config.nSkeletonCount) and
         (m_HeroMagic[17{召唤骷髅}]<>Nil) and
         ((boAmuporc = 1) or (g_Config.boCloneNotCheckAmulet2)) then begin
        UserMagic:=GetMagicInfoEx(17);
      end;
      if (UserMagic<>nil) then exit;
    end;  *)
    if (not m_boOpenShield) and
      (m_HeroMagic[SKILL_75 {护体神盾}] <> nil) and
      ((GetTickCount - m_dwOpenShieldTick) > g_Config.nShieldTick) and
      (Random(3) = 0) then
    begin
      UserMagic := GetMagicInfoEx(SKILL_75);
    end
    else if (m_HeroMagic[34 {解毒术}] <> nil) and
      ((TargeTBaseObject.m_wStatusTimeArr[POISON_DECHEALTH] <> 0) or
      (TargeTBaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] <> 0) or
      (TargeTBaseObject.m_wStatusTimeArr[POISON_STONE] <> 0)) and
      (Random(btBy) = 0) then
    begin
      UserMagic := GetMagicInfoEx(34);
    end
    else if (m_HeroMagic[50 {无极真气}] <> nil) and
      (m_wStatusArrValue[STATE_SC] = 0) and
      (Random(btBy) = 0) then
    begin
      UserMagic := GetMagicInfoEx(50);
    end
    else if (m_HeroMagic[SKILL_ENERGYREPULSOR] {气功波} <> nil) and
      (m_Abil.Level > m_TargetCret.m_Abil.Level) and
      (MySideCount > 0) and
      (Random(btBy) = 0) then
    begin
      UserMagic := GetMagicInfoEx(SKILL_ENERGYREPULSOR);
    end
    else if (m_HeroMagic[2 {治愈术}] <> nil) and
      (TargeTBaseObject.m_WAbil.HP < TargeTBaseObject.m_WAbil.MaxHP) and
      (Random(btBy) = 0) then
    begin
      UserMagic := GetMagicInfoEx(2);
    end
    else if (m_HeroMagic[52 {诅咒术}] <> nil) and
      (TargeTBaseObject.m_wStatusTimeArr[STATE_ARRAYDC] = 0) and
      (TargeTBaseObject.m_wStatusTimeArr[STATE_ARRAYMC] = 0) and
      (TargeTBaseObject.m_wStatusTimeArr[STATE_ARRAYSC] = 0) and
      ((boAmuporc = 1) or (g_Config.boCloneNotCheckAmulet2)) then
    begin
      UserMagic := GetMagicInfoEx(52);
    end
    else if (m_HeroMagic[15 {神圣战甲术}] <> nil) and
      (TargeTBaseObject.m_wStatusTimeArr[STATE_DEFENCEUP] = 0) and
      ((boAmuporc = 1) or (g_Config.boCloneNotCheckAmulet2)) then
    begin
      UserMagic := GetMagicInfoEx(15);
    end
    else if (m_HeroMagic[14 {幽灵盾}] <> nil) and
      (TargeTBaseObject.m_wStatusTimeArr[STATE_MAGDEFENCEUP] = 0) and
      ((boAmuporc = 1) or (g_Config.boCloneNotCheckAmulet2)) then
    begin
      UserMagic := GetMagicInfoEx(14);
    end;
  end;

  procedure ProtectHuman(btBy: Byte);
  begin
    if (m_Master2 = nil) or (UserMagic <> nil) then
      exit;
    TargeTBaseObject := m_Master2;
    TargeX := m_Master2.m_nCurrX;
    TargeY := m_Master2.m_nCurrY;
    CheckAttack(btBy);
  end;

  procedure ProtectSelf(btBy: Byte);
  begin
    if UserMagic <> nil then
      exit;
    TargeTBaseObject := Self;
    TargeX := m_nCurrX;
    TargeY := m_nCurrY;
    CheckAttack(btBy);
  end;

  procedure AttackMonster(btBy: Byte);
  begin
    if (UserMagic <> nil) or (m_TargetCret = nil) then
      exit;
    TargeTBaseObject := m_TargetCret;
    TargeX := m_TargetCret.m_nCurrX;
    TargeY := m_TargetCret.m_nCurrY;
    if (m_HeroMagic[38 {群体施毒术}] <> nil) and
      (TargeTBaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) and
      ((boAmuporc = 3) or (g_Config.boCloneNotCheckAmulet2)) and
      (AttackSideCount > 1) and
      (Random(5) <> 0) then
    begin
      m_CloneAmuletIdx := True;
      m_AmuletIdx := 2;
      UserMagic := GetMagicInfoEx(38);
    end
    else if (m_HeroMagic[38 {群体施毒术}] <> nil) and
      (TargeTBaseObject.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and
      ((boAmuporc = 2) or (g_Config.boCloneNotCheckAmulet2)) and
      (AttackSideCount > 1) and
      (Random(5) <> 0) then
    begin
      m_CloneAmuletIdx := False;
      m_AmuletIdx := 1;
      UserMagic := GetMagicInfoEx(38);
    end
    else if (m_HeroMagic[6 {施毒术}] <> nil) and
      (TargeTBaseObject.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and
      ((boAmuporc = 2) or (g_Config.boCloneNotCheckAmulet2)) and
      (Random(5) <> 0) then
    begin
      m_CloneAmuletIdx := False;
      m_AmuletIdx := 1;
      UserMagic := GetMagicInfoEx(6);
    end
    else if (m_HeroMagic[6 {施毒术}] <> nil) and
      (TargeTBaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) and
      ((boAmuporc = 3) or (g_Config.boCloneNotCheckAmulet2)) and
      (Random(5) <> 0) then
    begin
      m_CloneAmuletIdx := True;
      m_AmuletIdx := 2;
      UserMagic := GetMagicInfoEx(6);
    end
    else if (m_HeroMagic[18 {隐身术}] <> nil) and
      (m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] = 0) and
      (TargeTBaseObject.m_btRaceServer <> RC_PLAYOBJECT) and
      ((boAmuporc = 1) or (g_Config.boCloneNotCheckAmulet2)) and
      (MySideCount > 0) and
      (Random(btBy) = 0) and
      (not TargeTBaseObject.m_boCoolEye) then
    begin
      UserMagic := GetMagicInfoEx(18);
    end
    else if (m_HeroMagic[13 {灵魂火符}] <> nil) and
      ((boAmuporc = 1) or (g_Config.boCloneNotCheckAmulet2)) and
      ((m_Master2 = nil) or (Random(5) <> 0)) then
    begin
      UserMagic := GetMagicInfoEx(13);
    end;
  end;

  procedure ProtectSlave(btBy: Byte);
  var
    SlaveObject: TBaseObject;
    //    I          :Integer;
  begin
    if (UserMagic <> nil) or (m_Master2 = nil) then
      exit;
    //    SlaveObject:=Nil;
    if (Random(2) = 0) or (m_Master2.m_SlaveList.Count = 0) then
    begin
      if m_SlaveList.Count <= 0 then
        exit;
      SlaveObject := m_SlaveList.Items[Random(m_SlaveList.Count)];
      if (SlaveObject <> nil) and
        (abs(m_nCurrX - SlaveObject.m_nCurrX) < g_Config.nMagicAttackRage) and
        (abs(m_nCurrY - SlaveObject.m_nCurrY) < g_Config.nMagicAttackRage) then
      begin
        TargeTBaseObject := SlaveObject;
        TargeX := SlaveObject.m_nCurrX;
        TargeY := SlaveObject.m_nCurrY;
        CheckAttack(btBy);
      end;
    end
    else
    begin
      if m_Master2.m_SlaveList.Count <= 0 then
        exit;
      SlaveObject :=
        m_Master2.m_SlaveList.Items[Random(m_Master2.m_SlaveList.Count)];
      if (SlaveObject <> nil) and
        (abs(m_nCurrX - SlaveObject.m_nCurrX) < g_Config.nMagicAttackRage) and
        (abs(m_nCurrY - SlaveObject.m_nCurrY) < g_Config.nMagicAttackRage) then
      begin
        TargeTBaseObject := SlaveObject;
        TargeX := SlaveObject.m_nCurrX;
        TargeY := SlaveObject.m_nCurrY;
        CheckAttack(btBy);
      end;
    end;
  end;

begin
  Result := False;
  // boSet:=True;
  UserMagic := nil;
  nCheckCode := 0;
  try
    if (m_TargetCret <> nil) then
    begin
      nCheckCode := 1;
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) < g_Config.nMagicAttackRage) and
        (abs(m_nCurrY - m_TargetCret.m_nCurrY) < g_Config.nMagicAttackRage) then
      begin
        boMove := True;
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
        begin
          m_dwHitTick := GetTickCount;
          RefTaosCorpsItem;
          if (m_WAbil.MP > 15) then
            ProtectSelf(15);
         // if ((m_WAbil.HP / m_WAbil.MaxHP * 100) > 20) then
        //  begin
            MySideCount := GetMapBaseObjectCount(m_PEnvir, m_nCurrX, m_nCurrY,
              2);
            AttackSideCount := GetMapBaseObjectCount(m_TargetCret.m_PEnvir,
              m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 1);
            AttackMonster(3);
            if (UserMagic = nil) and
              (m_Master2 <> nil) and
              (abs(m_nCurrX - m_Master2.m_nCurrX) < g_Config.nMagicAttackRage)
                and
              (abs(m_nCurrY - m_Master2.m_nCurrY) < g_Config.nMagicAttackRage)
                then
            begin
              ProtectHuman(6);
              ProtectSlave(3);
            end;
         // end;
          nCheckCode := 3;
          if UserMagic <> nil then
          begin
            nCheckCode := 4;
            boMove := False;
            DoSpell(UserMagic, TargeX, TargeY, TargeTBaseObject);
            m_dwHitTick := GetTickCount;
          end
          else if (m_HeroMagic[13 {灵魂火符}] = nil) then
          begin
            nCheckCode := 5;
            if GetAttackDir(m_TargetCret, btDir) then
            begin
              nCheckCode := 6;
              //boSet:=False;
              nCheckCode := 7;
              AttackDir(nil, 0, btDir);
              m_dwHitTick := GetTickCount;
              nCheckCode := 8;
              boMove := False;
            end;
          end;
        end;
        if (boMove) and (m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] = 0) and
          ((GetTickCount - m_dwRunMagicIntervalTime) > g_Config.nRunMagTick) then
        begin
          m_dwRunMagicIntervalTime := GetTickCount;
          if (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 3) and
            (abs(m_nCurrY - m_TargetCret.m_nCurrY) < 3) then
          begin
            if (m_Master2 <> nil) and
              (m_PEnvir = m_Master2.m_PEnvir) and
              ((abs(m_nCurrX - m_Master2.m_nCurrX) > (g_Config.nMagicAttackRage
                - 2)) or
              (abs(m_nCurrY - m_Master2.m_nCurrY) > (g_Config.nMagicAttackRage -
                2))) then
            begin
              n14 := GetNextDirection(m_nCurrX, m_nCurrY, m_Master2.m_nCurrX,
                m_Master2.m_nCurrY);
              m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n14, 5, m_nTargetX,
                m_nTargetY);
            end
            else
            begin
              n14 := GetNextDirection(m_TargetCret.m_nCurrX,
                m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
              m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX,
                m_TargetCret.m_nCurrY, n14, 5, m_nTargetX, m_nTargetY);
            end;
            if (m_nTargetX > 0) and (m_nTargetY > 0) then
            begin
              GotoTargetXY;
            end;
            SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          end;
        end;
        Result := True;
      end; //if (abs(m_nCurrX - m_TargetCret.m_nCurrX) < g_Config.nMagicAttackRage) and
      if m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] <> 0 then
        Result := True;
    end
    else if (m_Master2 <> nil) and
      ((abs(m_nCurrX - m_Master2.m_nCurrX) < 3) or (abs(m_nCurrY -
        m_Master2.m_nCurrY) < 3)) and
      (m_Master2.m_PEnvir = m_PEnvir) then
    begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
      begin
        m_dwHitTick := GetTickCount;
        nCheckCode := 20;
        nCheckCode := 21;
        if m_WAbil.MP > 15 then
        begin
          nCheckCode := 22;
          RefTaosCorpsItem;
          ProtectHuman(3);
          ProtectSelf(3);
          if (m_SlaveList.Count > 0) or (m_Master2.m_SlaveList.Count > 0) then
            ProtectSlave(3);
          if UserMagic <> nil then
          begin
            Result := True;
            DoSpell(UserMagic, TargeX, TargeY, TargeTBaseObject);
          end;
        end;
      end;
    end;

  except
    MainOutMessage('[Exception] TPlayCloneObject.HeroTaosAttackTarget nCode ' +
      IntToStr(nCheckCode));
  end;
end;

//法师英雄攻击处理

function TPlayCloneObject.HeroWizardAttackTarget(): Boolean; //004A8E54
var
  //  btDir:Byte;
  n14: Integer;
  UserMagic: pTUserMagic;
  MySideCount: Integer;
  AttackSideCount: Integer;
  boMove: Boolean;
  //  nX,nY:Integer;
    //BaseObjectList   :TList;
begin
  try
    Result := False;
    if (m_TargetCret <> nil) then
    begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) < g_Config.nMagicAttackRage) and
        (abs(m_nCurrY - m_TargetCret.m_nCurrY) < g_Config.nMagicAttackRage) and
        (m_TargetCret.m_PEnvir = m_PEnvir) then
      begin //006329
        boMove := True;
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
        begin
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          //if (m_WAbil.MP > 30) and ((m_WAbil.HP / m_WAbil.MaxHP * 100) > 20)
       //     then
      //    begin //006279
            MySideCount := GetMapBaseObjectCount(m_PEnvir, m_nCurrX, m_nCurrY,
              1);
            AttackSideCount := GetMapBaseObjectCount(m_TargetCret.m_PEnvir,
              m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 1);
            UserMagic := nil;
            if (not m_boOpenShield) and
              (m_HeroMagic[SKILL_75 {护体神盾}] <> nil) and
              ((GetTickCount - m_dwOpenShieldTick) > g_Config.nShieldTick) and
              (Random(3) = 0) then
            begin
              UserMagic := GetMagicInfoEx(SKILL_75);
            end
            else if (m_HeroMagic[31 {魔法盾}] <> nil) and
              (m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP] = 0) then
            begin
              UserMagic := GetMagicInfoEx(31);
            end
            else if (m_HeroMagic[SKILL_57 {四级魔法盾}] <> nil) and
              (m_wStatusTimeArr[STATE_MAGIC57] = 0) then
            begin
              UserMagic := GetMagicInfoEx(SKILL_57);
            end
            else if (m_HeroMagic[8] {抗拒火环} <> nil) and
              (m_Abil.Level > m_TargetCret.m_Abil.Level) and
              (MySideCount > 0) and
              (Random(3) = 0) then
            begin
              UserMagic := GetMagicInfoEx(8);
            end
            else if (m_HeroMagic[24] {地狱雷光} <> nil) and
              (MySideCount > 4) and
              (Random(3) = 0) then
            begin
              UserMagic := GetMagicInfoEx(24);
            end
            else if (m_HeroMagic[47] {火龙烈焰} <> nil) and
              (AttackSideCount > 1) and
              (Random(3) = 0) then
            begin
              UserMagic := GetMagicInfoEx(47);
            end
            else if (m_HeroMagic[33] {冰咆哮} <> nil) and
              (AttackSideCount > 1) and
              (Random(3) = 0) then
            begin
              UserMagic := GetMagicInfoEx(33);
            end
            else if (m_HeroMagic[23] {爆裂火焰} <> nil) and
              (AttackSideCount > 1) and
              (Random(3) = 0) then
            begin
              UserMagic := GetMagicInfoEx(23);
            end
            else if (m_HeroMagic[45] {灭天火} <> nil) and
              ((Random(2) = 0) or (m_HeroMagic[11] = nil)) then
            begin
              UserMagic := GetMagicInfoEx(45);
            end
            else if (m_HeroMagic[11] {雷电术} <> nil) then
            begin
              UserMagic := GetMagicInfoEx(11);
            end
            else if (m_HeroMagic[1] {火球术} <> nil) then
            begin
              UserMagic := GetMagicInfoEx(1);
            end;
            if UserMagic <> nil then
            begin
              DoSpell(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY,
                m_TargetCret);
              BreakHolySeizeMode();
              boMove := False;
            end;
        //  end; //006279
        end; //Jason 1210更改
        if boMove and (m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] = 0) and
          ((GetTickCount - m_dwRunMagicIntervalTime) > g_Config.nRunMagTick) then
        begin
          m_dwRunMagicIntervalTime := GetTickCount;
          if (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 3) and
            (abs(m_nCurrY - m_TargetCret.m_nCurrY) < 3) then
          begin
            if (m_Master2 <> nil) and
              (m_PEnvir = m_Master2.m_PEnvir) and
              ((abs(m_nCurrX - m_Master2.m_nCurrX) > (g_Config.nMagicAttackRage
                - 2)) or
              (abs(m_nCurrY - m_Master2.m_nCurrY) > (g_Config.nMagicAttackRage -
                2))) then
            begin
              n14 := GetNextDirection(m_nCurrX, m_nCurrY, m_Master2.m_nCurrX,
                m_Master2.m_nCurrY);
              m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n14, 5, m_nTargetX,
                m_nTargetY);
            end
            else
            begin
              n14 := GetNextDirection(m_TargetCret.m_nCurrX,
                m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
              m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX,
                m_TargetCret.m_nCurrY, n14, 5, m_nTargetX, m_nTargetY);
            end;
            if (m_nTargetX > 0) and (m_nTargetY > 0) then
            begin
              GotoTargetXY;
            end;
            SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          end;
        end;
        Result := True;
      end; //006329
    end;
  except
    MainOutMessage('[Exception] TPlayCloneObject.HeroWizardAttackTarget');
  end;
end;

function TPlayCloneObject.CanMotaebo(BaseObject: TBaseObject; nMagicLevel:
  Integer): Boolean;
var
  nC: Integer;
begin
  Result := False;
  if (m_Abil.Level > BaseObject.m_Abil.Level) and (not BaseObject.m_boStickMode)
    then
  begin
    nC := m_Abil.Level - BaseObject.m_Abil.Level;
    if Random(20) < ((nMagicLevel * 4) + 6 + nC) then
    begin
      if IsProperTarget(BaseObject) then
        Result := True;
    end;
  end;
end;

function TPlayCloneObject.DoMotaebo(nDir: Byte; nMagicLevel: Integer): Boolean;
var
  bo35: Boolean;
  I, nDmg, n24, n28: Integer;
  PoseCreate: TBaseObject;
  BaseObject_30: TBaseObject;
  BaseObject_34: TBaseObject;
  nX, nY: integer;
begin
  try
    Result := False;
    bo35 := True;
    m_btDirection := nDir;
    BaseObject_34 := nil;
    n24 := nMagicLevel + 1;
    n28 := n24;
    PoseCreate := GetPoseCreate();
    if PoseCreate <> nil then
    begin
      for I := 0 to _MAX(2, nMagicLevel + 1) do
      begin
        PoseCreate := GetPoseCreate();
        if PoseCreate <> nil then
        begin
          n28 := 0;
          if not CanMotaebo(PoseCreate, nMagicLevel) then
            break;
          if nMagicLevel >= 3 then
          begin
            if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2,
              nX, nY) then
            begin
              BaseObject_30 := m_PEnvir.GetMovingObject(nX, nY, True);
              if (BaseObject_30 <> nil) and CanMotaebo(BaseObject_30,
                nMagicLevel) then
                BaseObject_30.CharPushed(m_btDirection, 1); //004C3237
            end; //004C323C
          end; //004C323C if nMagicLevel >= 3 then begin
          BaseObject_34 := PoseCreate;
          if PoseCreate.CharPushed(m_btDirection, 1) <> 1 then
            break;
          GetFrontPosition(nX, nY); //sub_004B2790
          if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nX, nY, False)
            > 0 then
          begin
            m_nCurrX := nX;
            m_nCurrY := nY;
            SendRefMsg(RM_RUSH, nDir, m_nCurrX, m_nCurrY, 0, '');
            bo35 := False;
            Result := True;
          end;
          Dec(n24);
        end; //004C32D7  if PoseCreate <> nil  then begin
      end; //004C32DD for i:=0 to _MAX(2,nMagicLevel + 1) do begin
    end
    else
    begin //004C32E8 if PoseCreate <> nil  then begin
      bo35 := False;
      for i := 0 to _MAX(2, nMagicLevel + 1) do
      begin
        GetFrontPosition(nX, nY); //sub_004B2790
        if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nX, nY, False)
          > 0 then
        begin
          m_nCurrX := nX;
          m_nCurrY := nY;
          SendRefMsg(RM_RUSH, nDir, m_nCurrX, m_nCurrY, 0, '');
          Dec(n28);
        end
        else
        begin
          if m_PEnvir.CanWalk(nX, nY, True) then
            n28 := 0
          else
          begin
            bo35 := True;
            break;
          end;
        end;
      end; //004C33AD
    end; //004C33B3
    if (BaseObject_34 <> nil) then
    begin //004C33B3
      if n24 < 0 then
        n24 := 0;
      nDmg := Random((n24 + 1) * 10) + ((n24 + 1) * 10);
      nDmg := BaseObject_34.GetHitStruckDamage(Self, nDmg);
      BaseObject_34.StruckDamage(nDmg, self);
      BaseObject_34.SendRefMsg(RM_STRUCK, nDmg, BaseObject_34.m_WAbil.HP,
        BaseObject_34.m_WAbil.MaxHP, Integer(Self), '');
      if BaseObject_34.m_btRaceServer <> RC_PLAYOBJECT then
      begin
        BaseObject_34.SendMsg(BaseObject_34, RM_STRUCK, nDmg,
          BaseObject_34.m_WAbil.HP, BaseObject_34.m_WAbil.MaxHP, Integer(Self),
          '');
      end;
    end; //004C3464
    if bo35 then
    begin
      GetFrontPosition(nX, nY); //sub_004B2790
      SendRefMsg(RM_RUSHKUNG, m_btDirection, nX, nY, 0, '');
      //SysMsg(sMateDoTooweak{冲撞力不够！！！},c_Red,t_Hint);
    end;
    if n28 > 0 then
    begin
      if n24 < 0 then
        n24 := 0;
      nDmg := Random(n24 * 10) + ((n24 + 1) * 3);
      nDmg := GetHitStruckDamage(Self, nDmg);
      StruckDamage(nDmg, self);
      SendRefMsg(RM_STRUCK, nDmg, m_WAbil.HP, m_WAbil.MaxHP, 0, '');
    end;

  except
    MainOutMessage('[Exception] TPlayCloneObject.DoMotaebo');
  end;
end;

//战士英雄攻击处理

function TPlayCloneObject.HeroWarrAttackTarget(): Boolean; //004A8E54
var
  btDir: Byte;
  btAttack: Byte;
  UserMagic: pTUserMagic;
  nRate: Byte;
  nSpellPoint: Integer;
  n14: Integer;
begin
  try
    Result := False;
    UserMagic := nil;
    if (m_TargetCret <> nil) then
    begin
      if (m_HeroMagic[43 {开天斩}] <> nil) and ((not m_boLongSwordSkill) or
        (not m_boLongSwordSkillCls)) and ((GetTickCount - m_HeroLongSword) >
        g_Config.nLongSwordTime) then
      begin
        m_HeroLongSword := GetTickCount;
        m_boLongSwordSkill := True;
        if (Random(10) - (g_Config.nLongSwordRate div 10)) < 0 then
          m_boLongSwordSkillCls := True
        else
          m_boLongSwordSkillCls := False;
      end
      else if (m_HeroMagic[26 {烈火剑法}] <> nil) and (not m_boFireHitSkill)
        and ((GetTickCount - m_HeroFireTick) > g_Config.nHeroMagicBlazeTick) then
      begin
        m_HeroFireTick := GetTickCount;
        m_boFireHitSkill := True;
      end;
      if m_boLongSwordSkill and (Integer(GetTickCount - m_dwHitTick) >
        m_nNextHitTime) then
      begin
        if m_boLongSwordSkillCls then
        begin
          nRate := 4;
          btAttack := 10;
        end
        else
        begin
          nRate := 2;
          btAttack := 11;
        end;
        if ((m_TargetCret.m_nCurrX = m_nCurrX) and (abs(m_TargetCret.m_nCurrY -
          m_nCurrY) <= nRate)) or
          ((m_TargetCret.m_nCurrY = m_nCurrY) and (abs(m_TargetCret.m_nCurrX -
            m_nCurrX) <= nRate)) or
          ((abs(m_TargetCret.m_nCurrY - m_nCurrY) = nRate) and
            (abs(m_TargetCret.m_nCurrX - m_nCurrX) = nRate)) then
        begin
          //GetAttackDir(m_TargetCret,btDir,nRate) then begin
          m_HeroLongSword := GetTickCount;
          btDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,
            m_TargetCret.m_nCurrY);
          AttackDir(nil, btAttack, btDir);
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          Result := True;
          if Random(15) = 0 then
            Result := False;
          exit;
        end;
      end;
     (* if //((m_WAbil.HP / m_WAbil.MaxHP * 100) < 20) and
        ((GetTickCount - m_dwRunMagicIntervalTime) > g_Config.nRunMagTick) then
      begin
        m_dwRunMagicIntervalTime := GetTickCount;
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 3) and
          (abs(m_nCurrY - m_TargetCret.m_nCurrY) < 3) then
        begin
          if (m_Master2 <> nil) and
            (m_PEnvir = m_Master2.m_PEnvir) and
            ((abs(m_nCurrX - m_Master2.m_nCurrX) > (g_Config.nMagicAttackRage -
              2)) or
            (abs(m_nCurrY - m_Master2.m_nCurrY) > (g_Config.nMagicAttackRage -
              2))) then
          begin
            n14 := GetNextDirection(m_nCurrX, m_nCurrY, m_Master2.m_nCurrX,
              m_Master2.m_nCurrY);
            m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n14, 5, m_nTargetX,
              m_nTargetY);
          end
          else
          begin
            n14 := GetNextDirection(m_TargetCret.m_nCurrX,
              m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
            m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX,
              m_TargetCret.m_nCurrY, n14, 5, m_nTargetX, m_nTargetY);
          end;
          if (m_nTargetX > 0) and (m_nTargetY > 0) then
          begin
            GotoTargetXY;
          end;
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
        Result := True;
        exit;
      end;  *)
      if GetAttackDir(m_TargetCret, btDir) then
      begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
        begin
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          btAttack := 0; //普通攻击
          if (m_HeroMagic[SKILL_MOOTEBO {野蛮冲撞}] <> nil) and
            (Random(4) = 0) and
            (m_Abil.Level > m_TargetCret.m_Abil.Level) and
            ((GetTickCount - m_dwDoMotaeboTick) > 3 * 1000) then
          begin
            m_dwDoMotaeboTick := GetTickCount();
            UserMagic := GetMagicInfoEx(SKILL_MOOTEBO);
            if (UserMagic <> nil) and (CanMotaebo(m_TargetCret,
              UserMagic.btLevel)) then
            begin
              nSpellPoint := GetSpellPoint(UserMagic);
              if m_WAbil.MP >= nSpellPoint then
              begin
                if nSpellPoint > 0 then
                begin
                  DamageSpell(nSpellPoint);
                  HealthSpellChanged();
                end;
                if DoMotaebo(btDir, UserMagic.btLevel) then
                begin
                  Result := True;
                  exit;
                end;
              end;
            end;
          end;
          if (m_MagicPowerHitSkill <> nil) and (m_UseItems[U_WEAPON].Dura > 0)
            then
          begin
            Dec(m_btAttackSkillCount);
            if m_btAttackSkillPointCount = m_btAttackSkillCount then
            begin
              m_boPowerHit := True;
              btAttack := 3; //攻杀剑术
            end;
            if m_btAttackSkillCount <= 0 then
            begin
              m_btAttackSkillCount := 7 - m_MagicPowerHitSkill.btLevel;
              m_btAttackSkillPointCount := Random(m_btAttackSkillCount);
            end;
          end;
          {if (btAttack=0) and (m_HeroMagic[43]) and ((GetTickCount-m_HeroLongSword)>g_Config.nLongSwordTime) then begin
            m_HeroLongSword:=GetTickCount;
            m_boLongSwordSkill:=True;
            if (Random(10)-(g_Config.nLongSwordRate div 10)) <0 then m_boLongSwordSkillCls:=True
            else m_boLongSwordSkillCls:=False;
            if m_boLongSwordSkillCls then btAttack:=10
            else btAttack:=11;
          end else }
          if (btAttack = 0) and (m_HeroMagic[26 {烈火剑法}] <> nil) and
            (m_boFireHitSkill or ((GetTickCount - m_HeroFireTick) >
            g_Config.nHeroMagicBlazeTick)) then
          begin
            m_HeroFireTick := GetTickCount;
            m_boFireHitSkill := True;
            btAttack := 7; //烈火剑法   HeroGetCrsHitCount
          end
          else if (not m_boOpenShield) and
            (m_HeroMagic[SKILL_75 {护体神盾}] <> nil) and
            ((GetTickCount - m_dwOpenShieldTick) > g_Config.nShieldTick) and
            (Random(3) = 0) then
          begin
            UserMagic := GetMagicInfoEx(SKILL_75);
            btAttack := 255;
          end
          else if (m_HeroMagic[40 {抱月刀法}] <> nil) and
            (HeroGetCrsHitCount > 1) then
          begin
            btAttack := 8;
            if (m_HeroMagic[41 {狮子吼}] <> nil) and (Random(10) = 1) then
            begin
              UserMagic := GetMagicInfoEx(41);
              if UserMagic <> nil then
              begin
                btAttack := 255;
              end;
            end;
          end
          else if (g_Config.nHeroWarrDefaultMagic <> 2) and
            (m_HeroMagic[25 {半月弯刀}] <> nil) and
            (HeroGetWideCount > 0) then
          begin
            btAttack := 5;
            if (m_HeroMagic[41 {狮子吼}] <> nil) and (Random(10) = 1) then
            begin
              UserMagic := Self.GetMagicInfoEx(41);
              if UserMagic <> nil then
              begin
                btAttack := 255;
              end;
            end;
          end
          else
          begin
            case g_Config.nHeroWarrDefaultMagic of
              1: if (m_HeroMagic[12] <> nil) and (btAttack = 0) then
                  btAttack := 4; //刺杀剑术
              2: if (m_HeroMagic[25] <> nil) and (btAttack = 0) then
                  btAttack := 5; //半月弯刀
            end;
          end;
          if btAttack = 255 then
            DoSpell(UserMagic, m_nCurrX, m_nCurrY, nil)
          else
            AttackDir(m_TargetCret, btAttack, btDir);
          BreakHolySeizeMode();
        end;
        Result := True;
        if Random(30) = 0 then
          Result := False;
      end
      else if (not m_boFireHitSkill) and (m_HeroMagic[12] <> nil) and
        (((m_TargetCret.m_nCurrX = m_nCurrX) and (abs(m_TargetCret.m_nCurrY -
          m_nCurrY) = 2)) or
        ((m_TargetCret.m_nCurrY = m_nCurrY) and (abs(m_TargetCret.m_nCurrX -
          m_nCurrX) = 2)) or
        ((abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2) and
          (abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2))) then
      begin
        if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then
        begin
          btAttack := 4; //
          btDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,
            m_TargetCret.m_nCurrY);
          AttackDir(nil, btAttack, btDir);
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
        end;
        Result := True;
      end;
    end;
  except
    MainOutMessage('[Exception] TPlayCloneObject.HeroWarrAttackTarget');
  end;
end;

function TPlayCloneObject.HeroGetCrsHitCount(): Integer;
var
  nC, n10, nX, nY: Integer;
  BaseObject: TBaseObject;
begin
  try
    Result := 0;
    nC := 0;
    while (True) do
    begin
      n10 := (m_btDirection + g_Config.CrsAttack[nC]) mod 8;
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n10, 1, nX, nY) then
      begin
        BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
        if (BaseObject <> nil) and IsProperTarget(BaseObject) then
        begin
          Inc(Result);
        end;
      end;
      Inc(nC);
      if nC >= 6 then
        break;
    end;
  except
    MainOutMessage('[Exception] TPlayCloneObject.HeroGetCrsHitCount');
  end;
end;

function TPlayCloneObject.HeroGetWideCount(): Integer;
var
  nC, n10, nX, nY: Integer;
  BaseObject: TBaseObject;
begin
  try
    Result := 0;
    nC := 0;
    while (True) do
    begin
      n10 := (m_btDirection + g_Config.WideAttack[nC]) mod 8;
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n10, 1, nX, nY) then
      begin
        BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
        if (BaseObject <> nil) and IsProperTarget(BaseObject) then
        begin
          Inc(Result);
        end;
      end;
      Inc(nC);
      if nC >= 3 then
        break;
    end;
  except
    MainOutMessage('[Exception] TPlayCloneObject.HeroGetWideCount');
  end;
end;

function TPlayCloneObject.DoSpell(UserMagic: pTUserMagic; nTargetX,
  nTargetY: Integer; BaseObject: TBaseObject): boolean; //004C6968
var
  nSpellPoint: integer;
begin
  try
    Result := False;
    if not MagicManager.IsWarrSkill(UserMagic.wMagIdx) then
    begin
      nSpellPoint := GetSpellPoint(UserMagic);
      if nSpellPoint > 0 then
      begin
        if m_WAbil.MP < nSpellPoint then
          exit;
        DamageSpell(nSpellPoint);
        HealthSpellChanged();
      end;
      Result := MagicManager.DoSpell(Self, UserMagic, nTargetX, nTargetY,
        BaseObject);
    end;
  except
    on e: Exception do
    begin
      MainOutMessage(format('[Exception] TPlayCloneObject.DoSpell MagID:%d X:%d Y:%d', [UserMagic.wMagIdx, nTargetX, nTargetY]));
      MainOutMessage(E.Message);
    end;
  end;
end;

function TPlayCloneObject.GetSpellPoint(UserMagic: pTUserMagic): Integer;
  //004C6910
begin
  try
    Result := 0;
    if UserMagic = nil then
      exit;

    Result := ROUND(UserMagic.MagicInfo.wSpell / (UserMagic.MagicInfo.btTrainLv
      + 1) * (UserMagic.btLevel + 1)) + UserMagic.MagicInfo.btDefSpell;
  except
    MainOutMessage('[Exception] TPlayCloneObject.GetSpellPoint');
  end;
end;

function TPlayCloneObject.LoadMonitems(FileName: string; var ItemList: TList):
  Integer; //00485ABC
var
  //s24:String;
  LoadList: TStringList;
  I: integer;
  s28, s2C, s30: string;
  n18, n1C: Integer;
  UserItem: pTUserItem;
  StdItem: TItem;
begin
  try
    Result := 0;
    //s24:=g_Config.sEnvirDir + 'MonItems\' + MonName + '.txt';
    if FileExists(FileName) then
    begin
      LoadList := TStringList.Create;
      LoadList.LoadFromFile(FileName);
      for I := 0 to LoadList.Count - 1 do
      begin
        s28 := LoadList.Strings[I];
        if (s28 <> '') and (s28[1] <> ';') then
        begin
          s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
          n18 := Str_ToInt(s30, -1);
          s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
          n1C := Str_ToInt(s30, -1);
          s28 := GetValidStr3(s28, s30, [' ', #9]);
          if s30 <> '' then
          begin
            if s30[1] = '"' then
              ArrestStringEx(s30, '"', '"', s30);
          end;
          s2C := s30;
          s28 := GetValidStr3(s28, s30, [' ', #9]);
          //20:=Str_ToInt(s30,1);
          if (n18 > 0) and (n1C > 0) and (s2C <> '') then
          begin
            if Random(n1C) <= (n18 - 1) then
            begin
              if (CompareText(s2C, sSTRING_GOLDNAME) <> 0) then
              begin
                New(UserItem);
                if UserEngine.CopyToUserItemFromName(s2C, UserItem) then
                begin
                  UserItem.Dura := Round((UserItem.DuraMax / 100) * (20 +
                    Random(80)));
                  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
                  if Random(g_Config.nMonRandomAddValue {10}) = 0 then
                    StdItem.RandomUpgradeItem(UserItem);
                  if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then
                  begin
                    if (StdItem.Shape = 130) or (StdItem.Shape = 131) or
                      (StdItem.Shape = 132) then
                    begin
                      StdItem.RandomUpgradeUnknownItem(UserItem);
                    end;
                  end;
                  if ItemList = nil then
                    ItemList := TList.Create;
                  ItemList.Add(UserItem);
                  Inc(Result);
                end
                else
                  Dispose(UserItem);
              end;
            end;
          end;
        end;
      end;
      LoadList.Free;
    end;

  except
    MainOutMessage('[Exception] TFrmDB.LoadMonitems');
  end;
end;

end.

