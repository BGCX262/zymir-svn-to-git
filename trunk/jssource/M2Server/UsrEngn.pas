//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit UsrEngn;

interface
uses
  Windows, Classes, SysUtils, StrUtils, Forms, ObjBase, MudUtil, ObjNpc, Envir,
  ItmUnit, Grobal2, SDK;

type
  TUserEngine = class
    m_LoadPlaySection: TRTLCriticalSection;
    m_LoadPlayList: TStringList; //从DB读取人物数据
    m_PlayObjectList: TStringList; //在线人物列表
    m_HeroObjectList: TStringList; //在线英雄列表
    m_OffLineList: TGStringList; //挂机列表
    m_PlayObjectFreeList: TList; //0x10
    m_ChangeHumanDBGoldList: TList; //0x14
    dwShowOnlineTick: LongWord; //0x18
    dwSendOnlineHumTime: LongWord; //0x1C
    dwProcessMapDoorTick: LongWord; //0x20
    dwProcessMissionsTime: LongWord; //0x24
    dwRegenMonstersTick: LongWord; //0x28
    CalceTime: LongWord; //0x2C
    m_dwProcessLoadPlayTick: LongWord; //0x30
    dwTime_34: LongWord; //0x34
    m_nCurrMonGen: Integer; //0x38
    m_nMonGenListPosition: Integer; //0x3C
    m_nMonGenCertListPosition: Integer; //0x40
    m_nProcHumIDx2: Integer;
    //0x44 处理人物开始索引（每次处理人物数限制）
    m_nHeroHumIDx: Integer;
    nProcessHumanLoopTime2: Integer;
    nProcessHeroLoopTime: Integer;
    nMerchantPosition: Integer; //0x4C
    nNpcPosition: Integer; //0x50
    StdItemList: TList; //List_54
    g_OpenItemArray:array of TOpenItem; //解包物品列表
    //    StdItemListEx             :TList;
    MonsterList: TList; //List_58
    m_MonGenList: TList; //List_5C
    m_MonFreeList: TList;
    m_MagicList2: TList; //List_60
    m_AdminList: TGList; //List_64
    m_MerchantList: TGList; //List_68
    QuestNPCList: TList; //0x6C
    List_70: TList;
    m_ChangeServerList: TList;
    m_MagicEventList: TList; //0x78
    nMonsterCount: Integer; //怪物总数
    nMonsterProcessPostion: Integer;
    //0x80处理怪物总数位置，用于计算怪物总数
    n84: Integer;
    nMonsterProcessCount: Integer;
    //0x88处理怪物数，用于统计处理怪物个数
    boItemEvent: Boolean; //ItemEvent
    n90: Integer;
    dwProcessMonstersTick: LongWord;
    dwProcessMerchantTimeMin: Integer;
    dwProcessMerchantTimeMax: Integer;
    dwProcessNpcTimeMin: LongWord;
    dwProcessNpcTimeMax: LongWord;
    m_NewHumanList: TList;
    m_ListOfGateIdx: TList;
    m_ListOfSocket: TList;
    OldMagicList: TList;
    MaxPlayObjectCount: Integer;
    MaxHeroObjectCount: Integer;
  private
    procedure ProcessHumans();
    procedure ProcessMonsters();
    procedure ProcessMerchants();
    procedure ProcessNpcs();
    //    procedure ProcessMissions();
    //    procedure Process4AECFC();
    procedure ProcessEvents();
    procedure ProcessMapDoor();
    procedure ProcessStatMapManCount();
    procedure NPCinitialize;
    procedure MerchantInitialize;
    function MonGetRandomItems(mon: TBaseObject): integer;
    function RegenMonsters(MonGen: pTMonGenInfo; nCount: integer): Boolean;
    //    procedure WriteShiftUserData;

    function AddBaseObject(sMapName: string; nX, nY: Integer; nMonRace: Integer;
      sMonName: string; Master: TBaseObject = nil; boClone: Boolean = False):
      TBaseObject;
    //    procedure GenShiftUserData();
    procedure KickOnlineUser(sChrName: string);

    function SendSwitchData(PlayObject: TPlayObject; nServerIndex: Integer):
      Boolean;
    procedure SendChangeServer(PlayObject: TPlayObject; nServerIndex: Integer);
    procedure AddToHumanFreeList(PlayObject: TPlayObject);

    procedure GetHumData(PlayObject: TPlayObject; var HumanRcd: THumDataInfo);
    function GetHomeInfo(nJob: Integer; var nX: Integer; var nY: Integer):
      string;
    function GetRandHomeX(PlayObject: TPlayObject): Integer;
    function GetRandHomeY(PlayObject: TPlayObject): Integer;
    //    function  GetSwitchData(sChrName:String;nCode:Integer):pTSwitchDataInfo;
    procedure LoadSwitchData(SwitchData: pTSwitchDataInfo; var PlayObject:
      TPlayObject);
    procedure DelSwitchData(SwitchData: pTSwitchDataInfo);
    procedure MonInitialize(BaseObject: TBaseObject; sMonName: string);
    //    function  MapRageHuman(sMapName:String;nMapX,nMapY,nRage:Integer):Boolean;
    function GetOnlineHumCount(): Integer;
    function GetUserCount(): Integer;
    function GetLoadPlayCount(): Integer;
    function GetHeroCount(): Integer;
    function GetMaxHeroCount(): Integer;
    function GetMaxOnlineCount(): Integer;
    function GetOffLineCount(): Integer;

  public
    constructor Create();
    destructor Destroy; override;
    function GetGenMonCount(MonGen: pTMonGenInfo): Integer;
    procedure Initialize();
    procedure ClearItemList(); virtual;
    procedure SwitchMagicList();
    function KickOnlineLevel(MinLevel, MaxLevel: Integer; boOffLine: Boolean =
      False): Integer;
    function KickOnlineName(sChrName: string; boIn: Boolean): Integer;
    procedure SaveHumanRcd(PlayObject: TPlayObject);
    procedure Run();
    procedure PrcocessData();
    procedure KickAllOnLine();
    function RegenMonsterByName(sMap: string; nX, nY: Integer; sMonName: string;
      Master: TBaseObject = nil; boClone: Boolean = False): TBaseObject;
    function GetStdItem(nItemIdx: Integer): TItem; overload;
    function GetStdItem(sItemName: string): TItem; overload;
    function GetStdItemNameEx(nStdMode,nShape:Integer): string;
    //    function GetStdItemEx(nItemIdx:Integer):pTStdItem;overload;
    //    function GetStdItemEx(sItemName:String):pTStdItem;overload;
    function GetStdItemWeight(nItemIdx: Integer): Integer;
    function GetStdItemName(nItemIdx: Integer): string;
    function GetStdItemIdx(sItemName: string): Integer;
    function FindOtherServerUser(sName: string; var nServerIndex): Boolean;
    procedure CryCry(wIdent: Word; pMap: TEnvirnoment; nX, nY, nWide: Integer;
      btFColor, btBColor: Byte; sMsg: string);
    procedure ProcessUserMessage(PlayObject: TPlayObject; DefMsg:
      pTDefaultMessage; Buff: PChar);
    procedure SendServerGroupMsg(nCode, nServerIdx: Integer; sMsg: string);
    function GetMonRace(sMonName: string): Integer;
    function GetPlayObject(sName: string; boHero: Boolean = False): TPlayObject;
    function GetPlayObjectEx(sName: string): TPlayObject;
    procedure KickPlayObjectEx(sName: string);
    function FindMerchant(Merchant: TObject): TMerchant;
    function FindNPC(GuildOfficial: TObject): TGuildOfficial;
    function CopyToUserItemFromName(sItemName: string; Item: pTUserItem):
      Boolean;
    function GetMapOfRangeHumanCount(Envir: TEnvirnoment; nX, nY, nRange:
      integer): Integer;
    function GetHumPermission(sUserName: string; var sIPaddr: string; var
      btPermission: Byte): Boolean;
    procedure AddUserOpenInfo(UserOpenInfo: pTUserOpenInfo);
    function OpenDoor(Envir: TEnvirnoment; nX, nY: Integer): Boolean;
    function CloseDoor(Envir: TEnvirnoment; Door: pTDoorInfo): Boolean;
    procedure SendDoorStatus(Envir: TEnvirnoment; nX, nY: Integer; wIdent, wX:
      Word; nDoorX, nDoorY, nA: Integer; sStr: string);
    function FindMagic(sMagicName: string; boHero: Boolean): pTMagic; overload;
    function FindMagic(nMagIdx: Integer; boHero: Boolean): pTMagic; overload;
    procedure AddMerchant(Merchant: TMerchant);
    function GetMerchantList(Envir: TEnvirnoment; nX, nY, nRange: Integer;
      TmpList: TList): Integer;
    function GetNpcList(Envir: TEnvirnoment; nX, nY, nRange: Integer; TmpList:
      TList): Integer;
    procedure ReloadMerchantList();
    procedure ReloadNpcList();
    procedure HumanExpire(sAccount: string);
    function GetMapMonster(Envir: TEnvirnoment; List: TList): Integer;
    function GetMapRangeMonster(Envir: TEnvirnoment; nX, nY, nRange: Integer;
      List: TList): Integer;
    function GetMapHuman(sMapName: string): Integer;
    function GetMapRageHuman(Envir: TEnvirnoment; nRageX, nRageY, nRage:
      Integer; List: TList): Integer;
    procedure SendBroadCastMsg(sMsg: string; MsgType: TMsgType);
    procedure SendBroadCastMsgExt(sMsg: string; MsgType: TMsgType);
    procedure SendBroadSocket(DefMsg: pTDefaultMessage; sMsg: string);
    procedure sub_4AE514(GoldChangeInfo: pTGoldChangeInfo);
    procedure ClearMonSayMsg();
    procedure SendQuestMsg(sQuestName: string);
    procedure SendDefMessage(wIdent: Word; nRecog: Integer; nParam, nTag,
      nSeries: Word; sMsg: string);
    procedure DemoRun();
    procedure ClearMerchantData();
    procedure AddOffLine(PlayObject: TPlayObject);
    procedure DelOffLine(sName: string);
    function GetOffLine(sName: string): TPlayObject;
    procedure KickAllOffLine();
    property MonsterCount: Integer read nMonsterCount;
    property OnlinePlayObject: Integer read GetOnlineHumCount;
    property PlayObjectCount: Integer read GetUserCount;
    property HeroObjectCount: Integer read GetHeroCount;
    property MaxHerCount: Integer read GetMaxHeroCount;
    property MaxHumCount: Integer read GetMaxOnlineCount;
    property LoadPlayCount: Integer read GetLoadPlayCount;
    property OffLinePlayCount: Integer read GetOffLineCount;

  end;
var
  g_dwEngineTick: LongWord;
  g_dwEngineRunTime: LongWord;

implementation

uses IdSrvClient, Guild, ObjMon, M2Share, EDcode, ObjGuard, ObjAxeMon,
  ObjMon2, ObjMon3, ObjMon4, ObjClone, Event, InterMsgClient, InterServerMsg,
  ObjRobot, HUtil32, svMain,
  Castle, InfinityStorage, PlugFun;
var
  nEngRemoteRun: Integer = -1;
  { TUserEngine }

constructor TUserEngine.Create();
begin
  try
    InitializeCriticalSection(m_LoadPlaySection);
    m_LoadPlayList := TStringList.Create;
    m_PlayObjectList := TStringList.Create;
    m_HeroObjectList := TStringList.Create;
    m_OffLineList := TGStringList.Create;
    m_PlayObjectFreeList := TList.Create;
    m_ChangeHumanDBGoldList := TList.Create;
    dwShowOnlineTick := GetTickCount;
    dwSendOnlineHumTime := GetTickCount;
    dwProcessMapDoorTick := GetTickCount;
    dwProcessMissionsTime := GetTickCount;
    dwProcessMonstersTick := GetTickCount;
    dwRegenMonstersTick := GetTickCount;
    m_dwProcessLoadPlayTick := GetTickCount;
    dwTime_34 := GetTickCount;
    m_nCurrMonGen := 0;
    m_nMonGenListPosition := 0;
    m_nMonGenCertListPosition := 0;
    m_nProcHumIDx2 := 0;
    m_nHeroHumIDx := 0;
    nProcessHumanLoopTime2 := 0;
    nProcessHeroLoopTime := 0;
    nMerchantPosition := 0;
    nNpcPosition := 0;
    StdItemList := TList.Create; //List_54
    //StdItemListEx             := TList.Create;
    MonsterList := TList.Create;
    m_MonGenList := TList.Create;
    m_MonFreeList := TList.Create;
    m_MagicList2 := TList.Create;
    m_AdminList := TGList.Create;
    m_MerchantList := TGList.Create;
    QuestNPCList := TList.Create;
    List_70 := TList.Create;
    m_ChangeServerList := TList.Create;
    m_MagicEventList := TList.Create;
    boItemEvent := False;
    n90 := 1800000;
    dwProcessMerchantTimeMin := 0;
    dwProcessMerchantTimeMax := 0;
    dwProcessNpcTimeMin := 0;
    dwProcessNpcTimeMax := 0;
    m_NewHumanList := TList.Create;
    m_ListOfGateIdx := TList.Create;
    m_ListOfSocket := TList.Create;
    OldMagicList := TList.Create;
    MaxPlayObjectCount := 0;
    MaxHeroObjectCount := 0;
  except
    MainOutMessage('[Exception] TUserEngine.Create');
  end;
end;

destructor TUserEngine.Destroy;
var
  I: Integer;
  II: Integer;
  MonInfo: pTMonInfo;
  MonGenInfo: pTMonGenInfo;
  MagicEvent: pTMagicEvent;
  tmpList: TList;
begin
  try
    for I := 0 to m_LoadPlayList.Count - 1 do
    begin
      Dispose(pTUserOpenInfo(m_LoadPlayList.Objects[I]));
    end;
    m_LoadPlayList.Free;
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      TPlayObject(m_PlayObjectList.Objects[I]).Free;
    end;
    m_PlayObjectList.Free;

    for I := 0 to m_HeroObjectList.Count - 1 do
    begin
      TPlayObject(m_HeroObjectList.Objects[I]).Free;
    end;
    m_HeroObjectList.Free;

    m_OffLineList.Free;

    for I := 0 to m_PlayObjectFreeList.Count - 1 do
    begin
      TPlayObject(m_PlayObjectFreeList.Items[I]).Free;
    end;
    m_PlayObjectFreeList.Free;

    for I := 0 to m_ChangeHumanDBGoldList.Count - 1 do
    begin
      Dispose(pTGoldChangeInfo(m_ChangeHumanDBGoldList.Items[I]));
    end;
    m_ChangeHumanDBGoldList.Free;

    for I := 0 to StdItemList.Count - 1 do
    begin
      TItem(UserEngine.StdItemList.Items[I]).Free; //07.05.17修改
    end;
    StdItemList.Free;

    { For I:=0 to StdItemListEx.Count-1 do begin
       Dispose(pTStdItem(StdItemListEx.Items[i]));
     end;
     StdItemListEx.Free;}

    for I := 0 to MonsterList.Count - 1 do
    begin
      MonInfo := MonsterList.Items[I];
      if MonInfo.ItemList <> nil then
      begin
        for II := 0 to MonInfo.ItemList.Count - 1 do
        begin
          Dispose(pTMonItem(MonInfo.ItemList.Items[II]));
        end;
        MonInfo.ItemList.Free;
      end;
      Dispose(MonInfo);
    end;
    MonsterList.Free;

    for I := 0 to m_MonGenList.Count - 1 do
    begin
      MonGenInfo := m_MonGenList.Items[I];
      for II := 0 to MonGenInfo.CertList.Count - 1 do
      begin
        TBaseObject(MonGenInfo.CertList.Items[II]).Free;
      end;
      Dispose(pTMonGenInfo(m_MonGenList.Items[I]));
    end;
    m_MonGenList.Free;

    for I := 0 to m_MonFreeList.Count - 1 do
    begin
      TBaseObject(m_MonFreeList.Items[I]).Free;
    end;
    m_MonFreeList.Free;

    for I := 0 to m_MagicList2.Count - 1 do
    begin
      Dispose(pTMagic(m_MagicList2.Items[i]));
    end;
    m_MagicList2.Free;
    m_AdminList.Free;
    for I := 0 to m_MerchantList.Count - 1 do
    begin
      TMerchant(m_MerchantList.Items[i]).Free;
    end;
    m_MerchantList.Free;
    for I := 0 to QuestNPCList.Count - 1 do
    begin
      TNormNpc(QuestNPCList.Items[i]).Free;
    end;
    QuestNPCList.Free;
    List_70.Free;
    for I := 0 to m_ChangeServerList.Count - 1 do
    begin
      Dispose(pTSwitchDataInfo(m_ChangeServerList.Items[i]));
    end;
    m_ChangeServerList.Free;
    for I := 0 to m_MagicEventList.Count - 1 do
    begin
      MagicEvent := m_MagicEventList.Items[I];
      if MagicEvent.BaseObjectList <> nil then
        MagicEvent.BaseObjectList.Free;

      Dispose(MagicEvent);
    end;
    m_MagicEventList.Free;
    m_NewHumanList.Free;
    m_ListOfGateIdx.Free;
    m_ListOfSocket.Free;
    for I := 0 to OldMagicList.Count - 1 do
    begin
      tmpList := TList(OldMagicList.Items[I]);
      for II := 0 to tmpList.Count - 1 do
      begin
        Dispose(pTMagic(tmpList.Items[II]));
      end;
      tmpList.Free;
    end;
    OldMagicList.Free;
    DeleteCriticalSection(m_LoadPlaySection);
    inherited;
  except
    MainOutMessage('[Exception] TUserEngine.Destroy');
  end;
end;

procedure TUserEngine.Initialize; //004B200C
var
  i: Integer;
  MonGen: pTMonGenInfo;
begin
  try
    MerchantInitialize();
    NPCinitialize();
    for i := 0 to m_MonGenList.Count - 1 do
    begin
      MonGen := m_MonGenList.Items[i];
      if MonGen <> nil then
      begin
        MonGen.nRace := GetMonRace(MonGen.sMonName);
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.Initialize');
  end;
end;

function TUserEngine.GetMonRace(sMonName: string): Integer; //004ACDD8
var
  i: integer;
  MonInfo: pTMonInfo;
begin
  try
    Result := -1;
    for i := 0 to MonsterList.Count - 1 do
    begin
      MonInfo := MonsterList.Items[i];
      if CompareText(MonInfo.sName, sMonName) = 0 then
      begin
        Result := MonInfo.btRace;
        break;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetMonRace');
  end;
end;

procedure TUserEngine.MerchantInitialize; //004AC96C
var
  I: Integer;
  Merchant: TMerchant;
  sCaption: string;
begin
  try
    sCaption := FrmMain.Caption;
    m_MerchantList.Lock;
    try
      for I := m_MerchantList.Count - 1 downto 0 do
      begin
        Merchant := TMerchant(m_MerchantList.Items[i]);
        Merchant.m_PEnvir := g_MapManager.FindMap(Merchant.m_sMapName);
        if Merchant.m_PEnvir <> nil then
        begin
          //FrmMain.Caption:=sCaption+ ' ' + Merchant.m_sCharName;
          Merchant.Initialize; //FFFE
          if Merchant.m_boAddtoMapSuccess and (not Merchant.m_boIsHide) then
          begin
            MainOutMessage('交易NPC初始化失败...' + Merchant.m_sCharName
              +
              ' ' + Merchant.m_sMapName + '(' + IntToStr(Merchant.m_nCurrX) + ':'
              + IntToStr(Merchant.m_nCurrY) + ')');
            m_MerchantList.Delete(i);
            Merchant.Free;
          end
          else
          begin
            Merchant.LoadNPCScript();
            Merchant.LoadNPCData();
          end;
        end
        else
        begin
          MainOutMessage(Merchant.m_sCharName +
            ' - 交易NPC初始化失败... (m.PEnvir=nil)');
          m_MerchantList.Delete(i);
          Merchant.Free;
        end;
        ///FrmMain.Caption:=sCaption + Merchant.m_sCharName;
        FrmMain.Caption := sCaption + '[正在初始化交易NPC(' +
          IntToStr(m_MerchantList.Count) + '/' + IntToStr(m_MerchantList.Count -
          I)
          + ')]';

      end;
    finally
      FrmMain.Caption := sCaption;
      m_MerchantList.UnLock;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.MerchantInitialize');
  end;
end;

procedure TUserEngine.NPCinitialize; //004ACC24
var
  I: Integer;
  NormNpc: TNormNpc;
  sCaption: string;
begin
  try
    sCaption := FrmMain.Caption;
    for I := QuestNPCList.Count - 1 downto 0 do
    begin
      NormNpc := TNormNpc(QuestNPCList.Items[i]);
      NormNpc.m_PEnvir := g_MapManager.FindMap(NormNpc.m_sMapName);
      if NormNpc.m_PEnvir <> nil then
      begin
        NormNpc.Initialize; //FFFE
        if NormNpc.m_boAddtoMapSuccess and (not NormNpc.m_boIsHide) then
        begin
          MainOutMessage(NormNpc.m_sCharName + ' Npc初始化失败... ');
          QuestNPCList.Delete(i);
          NormNpc.Free;
        end
        else
        begin
          NormNpc.LoadNPCScript();
        end;
      end
      else
      begin
        MainOutMessage(NormNpc.m_sCharName +
          ' Npc初始化失败... (npc.PEnvir=nil) ');
        QuestNPCList.Delete(i);
        NormNpc.Free;
      end;
      FrmMain.Caption := sCaption + '[正在初始化管理NPC(' +
        IntToStr(QuestNPCList.Count) + '/' + IntToStr(QuestNPCList.Count - I) +
        ')]';

    end;
    // FrmMain.Caption:=sCaption;
  except
    MainOutMessage('[Exception] TUserEngine.NPCinitialize');
  end;
end;

function TUserEngine.GetLoadPlayCount: Integer; //004AE7F0
begin
  try
    Result := m_LoadPlayList.Count;
  except
    MainOutMessage('[Exception] TUserEngine.GetLoadPlayCount:');
  end;
end;

function TUserEngine.GetOffLineCount(): Integer;
begin
  try
    Result := m_OffLineList.Count;
  except
    MainOutMessage('[Exception] TUserEngine.GetOffLineCount');
  end;
end;

function TUserEngine.GetMaxOnlineCount(): Integer;
var
  I: Integer;
begin
  try
    I := m_PlayObjectList.Count;
    if I > MaxPlayObjectCount then
      MaxPlayObjectCount := I;
    Result := MaxPlayObjectCount;
  except
    MainOutMessage('[Exception] TUserEngine.GetMaxOnlineCount');
  end;
end;

function TUserEngine.GetOnlineHumCount: Integer; //004AE7F0
{var
  I : Integer;}
begin
  try
    {I:= m_PlayObjectList2.Count;
    if I > MaxPlayObjectCount then
       MaxPlayObjectCount:=I;}
    Result := m_PlayObjectList.Count;
  except
    MainOutMessage('[Exception] TUserEngine.GetOnlineHumCount:');
  end;
end;

function TUserEngine.GetUserCount: Integer; //004AE7C0
begin
  try
    Result := m_PlayObjectList.Count;
  except
    MainOutMessage('[Exception] TUserEngine.GetUserCount:');
  end;
end;

function TUserEngine.GetMaxHeroCount(): Integer;
var
  I: Integer;
begin
  try
    I := m_HeroObjectList.Count;
    if I > MaxHeroObjectCount then
      MaxHeroObjectCount := I;
    Result := MaxHeroObjectCount;
  except
    MainOutMessage('[Exception] TUserEngine.GetMaxHeroCount');
  end;
end;

function TUserEngine.GetHeroCount: Integer;
begin
  try
    Result := m_HeroObjectList.Count;
  except
    MainOutMessage('[Exception] TUserEngine.GetHeroCount:');
  end;
end;

procedure TUserEngine.ProcessHumans;
  function IsLogined(sChrName: string): Boolean; //004AFC68
  var
    i: Integer;
  begin
    Result := False;
    if FrontEngine.InSaveRcdList(sChrName) then
    begin
      Result := True;
    end
    else
    begin
      for i := 0 to m_PlayObjectList.Count - 1 do
      begin
        if CompareText(m_PlayObjectList.Strings[i], sChrName) = 0 then
        begin
          Result := True;
          break;
        end;
      end;
    end;
  end;
  function MakeNewHeroHuman(UserOpenInfo: pTUserOpenInfo): TPlayObject;
  resourcestring
    sExceptionMsg = '[Exception] TUserEngine::MakeNewHeroHuman';
    sChangeServerFail1 = 'chg-server-fail-1 [%d] -> [%d] [%s]';
    sChangeServerFail2 = 'chg-server-fail-2 [%d] -> [%d] [%s]';
    sChangeServerFail3 = 'chg-server-fail-3 [%d] -> [%d] [%s]';
    sChangeServerFail4 = 'chg-server-fail-4 [%d] -> [%d] [%s]';
    sErrorEnvirIsNil = '[Error] PlayObject.PEnvir = nil';
  var
    PlayObject: TPlayObject;
    MasterObject: TPlayObject;
    Abil: pTAbility;
    nX, nY: Integer;
    Create: Boolean;
    Envir: TEnvirnoment;
    //label
      //ReGetMap;
  begin
    Result := nil;
    try
      Create := False;
      PlayObject := TPlayObject.Create;
      MasterObject := TPlayObject(UserOpenInfo.LoadUser.PlayObject);
      //主人对像
      if MasterObject <> nil then
      begin
        MasterObject.GetFrontPosition(nX, nY);
        GetHumData(PlayObject, UserOpenInfo.HumanRcd);
        PlayObject.m_boHero := True;
        PlayObject.m_sHomeMap := MasterObject.m_sHomeMap;
        PlayObject.m_sMapName := MasterObject.m_sMapName;
        PlayObject.m_btRaceServer := RC_PLAYOBJECT;
        PlayObject.m_nCurrX := nX;
        PlayObject.m_nCurrY := nY;
        if PlayObject.m_Abil.Level = 0 then
        begin
          Abil := @PlayObject.m_Abil;
          Abil.Level := 1;
          Abil.AC := 0;
          Abil.MAC := 0;
          Abil.DC := MakeLong(1, 2);
          Abil.MC := MakeLong(1, 2);
          Abil.SC := MakeLong(1, 2);
          Abil.MP := 15;
          Abil.HP := 15;
          Abil.MaxHP := 15;
          Abil.MaxMP := 15;
          Abil.Exp := 0;
          Abil.MaxExp := 100;
          Abil.Weight := 0;
          Abil.MaxWeight := 30;
          PlayObject.m_boNewHuman := True;
          PlayObject.m_HeroClass := MasterObject.m_HeroClass;
        end;
        //Abil.HP:=223;
        //Abil.MaxHP:=223;
        Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
        if Envir = nil then
          exit;
        if PlayObject.m_Abil.HP <= 0 then
        begin
          PlayObject.ClearStatusTime(); //死亡清理负驸加属性
          PlayObject.m_Abil.HP := 14;
        end;
        PlayObject.AbilCopyToWAbil();
        PlayObject.m_PEnvir := Envir;
        PlayObject.m_boReadyRun := False;
        PlayObject.m_sUserID := UserOpenInfo.LoadUser.sAccount;
        PlayObject.m_sIPaddr := MasterObject.m_sIPaddr;
        PlayObject.m_sIPLocal := MasterObject.m_sIPLocal;
        PlayObject.m_nSocket := MasterObject.m_nSocket;
        PlayObject.m_nGSocketIdx := MasterObject.m_nGSocketIdx;
        PlayObject.m_nGateIdx := MasterObject.m_nGateIdx;
        PlayObject.m_nSessionID := 0;
        PlayObject.m_nPayMent := MasterObject.m_nPayMent;
        PlayObject.m_nPayMode := MasterObject.m_nPayMode;
        PlayObject.m_dwLoadTick := UserOpenInfo.LoadUser.dwNewUserTick;
        MasterObject.m_Hero := PlayObject;
        MasterObject.m_HeroClass := PlayObject.m_HeroClass;
        PlayObject.m_nViewRange := 10; //英雄视线
        PlayObject.m_HeroHuman := MasterObject;
        PlayObject.m_AllMaster := MasterObject;
        PlayObject.m_HeroName := MasterObject.m_sCharName;
        PlayObject.m_nSoftVersionDate := MasterObject.m_nSoftVersionDate;
        PlayObject.m_nSoftVersionDateEx := MasterObject.m_nSoftVersionDateEx;
        PlayObject.m_dwClientTick := MasterObject.m_dwClientTick;
        PlayObject.m_dwClientTickEx := MasterObject.m_dwClientTickEx;
        case PlayObject.m_btJob of
          JOB_WARR:
            begin
              PlayObject.m_dwHitIntervalTime := g_Config.nWarrAttackTick;
              PlayObject.m_dwRunIntervalTime := g_Config.nWarrWalkTime;
            end;
          JOB_WIZARD:
            begin
              PlayObject.m_dwHitIntervalTime := g_Config.nWizardAttackTick;
              PlayObject.m_dwRunIntervalTime := g_Config.nWizardWalkTime;
            end;
          JOB_TAOS:
            begin
              PlayObject.m_dwHitIntervalTime := g_Config.nTaosAttackTick;
              PlayObject.m_dwRunIntervalTime := g_Config.nTaosWalkTime;
            end;
        end;
        //PlayObject.m_Master2:=MasterObject;      //要删除
        Create := True;
      end;
      if not Create then
        PlayObject.Free
      else
        Result := PlayObject;
    except
      MainOutMessage(sExceptionMsg);
    end;
  end;

  function MakeNewHuman(UserOpenInfo: pTUserOpenInfo): TPlayObject; //004AFD28
  var
    PlayObject: TPlayObject;
    Abil: pTAbility;
    Envir: TEnvirnoment;
    nC: integer;
    SwitchDataInfo: pTSwitchDataInfo;
    Castle: TUserCastle;
  resourcestring
    sExceptionMsg = '[Exception] TUserEngine::MakeNewHuman';
    sChangeServerFail1 = 'chg-server-fail-1 [%d] -> [%d] [%s]';
    sChangeServerFail2 = 'chg-server-fail-2 [%d] -> [%d] [%s]';
    sChangeServerFail3 = 'chg-server-fail-3 [%d] -> [%d] [%s]';
    sChangeServerFail4 = 'chg-server-fail-4 [%d] -> [%d] [%s]';
    sErrorEnvirIsNil = '[Error] PlayObject.PEnvir = nil';
  label
    ReGetMap;
  begin
    Result := nil;
    try
      PlayObject := TPlayObject.Create;

      if not g_Config.boVentureServer then
      begin
        UserOpenInfo.sChrName := '';
        UserOpenInfo.LoadUser.nSessionID := 0;
        //GetSwitchData(UserOpenInfo.sChrName,UserOpenInfo.LoadUser.nSessionID);
      end; // else SwitchDataInfo:=nil;//004AFD95

      SwitchDataInfo := nil;

      if SwitchDataInfo = nil then
      begin
        GetHumData(PlayObject, UserOpenInfo.HumanRcd);
        PlayObject.m_btRaceServer := RC_PLAYOBJECT;
        if PlayObject.m_sHomeMap = '' then
        begin
          ReGetMap:
          PlayObject.m_sHomeMap := GetHomeInfo(PlayObject.m_btJob,
            PlayObject.m_nHomeX, PlayObject.m_nHomeY);
          PlayObject.m_sMapName := PlayObject.m_sHomeMap;
          //MainOutMessage(format('%d+%s',[1,PlayObject.m_sMapName]));
          PlayObject.m_nCurrX := GetRandHomeX(PlayObject);
          PlayObject.m_nCurrY := GetRandHomeY(PlayObject);
          if PlayObject.m_Abil.Level = 0 then
          begin
            Abil := @PlayObject.m_Abil;
            Abil.Level := 1;
            Abil.AC := 0;
            Abil.MAC := 0;
            Abil.DC := MakeLong(1, 2);
            Abil.MC := MakeLong(1, 2);
            Abil.SC := MakeLong(1, 2);
            Abil.MP := 15;
            Abil.HP := 15;
            Abil.MaxHP := 15;
            Abil.MaxMP := 15;
            Abil.Exp := 0;
            Abil.MaxExp := 100;
            Abil.Weight := 0;
            Abil.MaxWeight := 30;
            PlayObject.m_boNewHuman := True;
          end;

        end;

        Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
        //MainOutMessage(format('%d+%s',[2,PlayObject.m_sMapName]));
        if Envir <> nil then
        begin
          if Envir.Flag.boFight3Zone then
          begin //是否在行会战争地图死亡
            if (PlayObject.m_Abil.HP <= 0) and (PlayObject.m_nFightZoneDieCount
              < 3) then
            begin
              PlayObject.m_Abil.HP := PlayObject.m_Abil.MaxHP;
              PlayObject.m_Abil.MP := PlayObject.m_Abil.MaxMP;
              PlayObject.m_boDieInFight3Zone := True;
            end
            else
              PlayObject.m_nFightZoneDieCount := 0;
          end;
        end;

        PlayObject.m_MyGuild :=
          g_GuildManager.MemberOfGuild(PlayObject.m_sCharName);
        Castle := g_CastleManager.InCastleWarArea(Envir, PlayObject.m_nCurrX,
          PlayObject.m_nCurrY);
        {
        if (Envir <> nil) and ((UserCastle.m_MapPalace = Envir) or
          (UserCastle.m_boUnderWar and UserCastle.InCastleWarArea(PlayObject.m_PEnvir,PlayObject.m_nCurrX,PlayObject.m_nCurrY))) then begin
        }
        if (Envir <> nil) and (Castle <> nil) and ((Castle.m_MapPalace = Envir)
          or Castle.m_boUnderWar) then
        begin
          Castle := g_CastleManager.IsCastleMember(PlayObject);

          //if not UserCastle.IsMember(PlayObject) then begin
          if Castle = nil then
          begin
            PlayObject.m_sMapName := PlayObject.m_sHomeMap;
            //MainOutMessage(format('%d+%s',[3,PlayObject.m_sMapName]));
            PlayObject.m_nCurrX := PlayObject.m_nHomeX - 2 + Random(5);
            PlayObject.m_nCurrY := PlayObject.m_nHomeY - 2 + Random(5);
          end
          else
          begin
            {
            if UserCastle.m_MapPalace = Envir then begin
              PlayObject.m_sMapName:=UserCastle.GetMapName();
              PlayObject.m_nCurrX:=UserCastle.GetHomeX;
              PlayObject.m_nCurrY:=UserCastle.GetHomeY;
            end;
            }
            if Castle.m_MapPalace = Envir then
            begin
              PlayObject.m_sMapName := Castle.GetMapName();
              //MainOutMessage(format('%d+%s',[4,PlayObject.m_sMapName]));
              PlayObject.m_nCurrX := Castle.GetHomeX;
              PlayObject.m_nCurrY := Castle.GetHomeY;
            end;

          end;
        end; //004B00C0

        //if (PlayObject.nC4 <= 1) and (PlayObject.m_Abil.Level >= 1) then Jsaon 0715
          //PlayObject.nC4:=2;
        if g_MapManager.FindMap(PlayObject.m_sMapName) = nil then
          PlayObject.m_Abil.HP := 0;
        if PlayObject.m_Abil.HP <= 0 then
        begin
          PlayObject.ClearStatusTime();
          if PlayObject.PKLevel < 2 then
          begin
            Castle := g_CastleManager.IsCastleMember(PlayObject);
            //            if UserCastle.m_boUnderWar and (UserCastle.IsMember(PlayObject)) then begin
            if (Castle <> nil) and Castle.m_boUnderWar then
            begin
              PlayObject.m_sMapName := Castle.m_sHomeMap;
              //MainOutMessage(format('%d+%s',[5,PlayObject.m_sMapName]));
              PlayObject.m_nCurrX := Castle.GetHomeX;
              PlayObject.m_nCurrY := Castle.GetHomeY;
            end
            else
            begin
              PlayObject.m_sMapName := PlayObject.m_sHomeMap;
              //MainOutMessage(format('%d+%s',[6,PlayObject.m_sMapName]));
              PlayObject.m_nCurrX := PlayObject.m_nHomeX - 2 + Random(5);
              PlayObject.m_nCurrY := PlayObject.m_nHomeY - 2 + Random(5);
            end;
          end
          else
          begin //004B0201
            PlayObject.m_sMapName := g_Config.sRedDieHomeMap {'3'};
            //MainOutMessage(format('%d+%s',[7,PlayObject.m_sMapName]));
            PlayObject.m_nCurrX := Random(13) + g_Config.nRedDieHomeX {839};
            PlayObject.m_nCurrY := Random(13) + g_Config.nRedDieHomeY {668};
          end;
          PlayObject.m_Abil.HP := 14;
        end; //004B023D

        PlayObject.AbilCopyToWAbil();
        Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
        //MainOutMessage(format('%d+%s',[8,PlayObject.m_sMapName]));
        if Envir = nil then
        begin
          //MainOutMessage('到了1983');
          PlayObject.m_nSessionID := UserOpenInfo.LoadUser.nSessionID;
          PlayObject.m_nSocket := UserOpenInfo.LoadUser.nSocket;
          PlayObject.m_nGateIdx := UserOpenInfo.LoadUser.nGateIdx;
          PlayObject.m_nGSocketIdx := UserOpenInfo.LoadUser.nGSocketIdx;
          PlayObject.m_WAbil := PlayObject.m_Abil;
          PlayObject.m_nServerIndex :=
            g_MapManager.GetMapOfServerIndex(PlayObject.m_sMapName);
          if PlayObject.m_Abil.HP <> 14 then
          begin
            MainOutMessage(format(sChangeServerFail1, [nServerIndex,
              PlayObject.m_nServerIndex, PlayObject.m_sMapName]));
            {MainOutMessage('chg-server-fail-1 [' +
                           IntToStr(nServerIndex) +
                           '] -> [' +
                           IntToStr(PlayObject.m_nServerIndex) +
                           '] [' +
                           PlayObject.m_sMapName +
                           ']');}
          end;
          SendSwitchData(PlayObject, PlayObject.m_nServerIndex);
          SendChangeServer(PlayObject, PlayObject.m_nServerIndex);
          PlayObject.Free;
          exit;
        end;
        nC := 0;
        while (True) do
        begin //004B03CC
          if Envir.CanWalk(PlayObject.m_nCurrX, PlayObject.m_nCurrY, True) then
            break;
          PlayObject.m_nCurrX := PlayObject.m_nCurrX - 3 + Random(6);
          PlayObject.m_nCurrY := PlayObject.m_nCurrY - 3 + Random(6);

          Inc(nC);
          if nC >= 5 then
            break;
        end;

        if not Envir.CanWalk(PlayObject.m_nCurrX, PlayObject.m_nCurrY, True)
          then
        begin
          MainOutMessage(format(sChangeServerFail2, [nServerIndex,
            PlayObject.m_nServerIndex, PlayObject.m_sMapName]));
          {  MainOutMessage('chg-server-fail-2 [' +
                           IntToStr(nServerIndex) +
                           '] -> [' +
                           IntToStr(PlayObject.m_nServerIndex) +
                           '] [' +
                           PlayObject.m_sMapName +
                           ']');}
          PlayObject.m_sMapName := g_Config.sHomeMap;
          Envir := g_MapManager.FindMap(g_Config.sHomeMap);
          PlayObject.m_nCurrX := g_Config.nHomeX;
          PlayObject.m_nCurrY := g_Config.nHomeY;
        end;

        PlayObject.m_PEnvir := Envir;
        if PlayObject.m_PEnvir = nil then
        begin
          MainOutMessage(sErrorEnvirIsNil);
          goto ReGetMap;
        end
        else
        begin
          PlayObject.m_boReadyRun := False;
        end;
      end
      else
      begin //004B0561
        GetHumData(PlayObject, UserOpenInfo.HumanRcd);
        PlayObject.m_sMapName := SwitchDataInfo.sMap;
        PlayObject.m_nCurrX := SwitchDataInfo.wX;
        PlayObject.m_nCurrY := SwitchDataInfo.wY;
        PlayObject.m_Abil := SwitchDataInfo.Abil;
        PlayObject.m_WAbil := SwitchDataInfo.Abil;
        LoadSwitchData(SwitchDataInfo, PlayObject);
        DelSwitchData(SwitchDataInfo);
        Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
        if Envir <> nil then
        begin
          MainOutMessage(format(sChangeServerFail3, [nServerIndex,
            PlayObject.m_nServerIndex, PlayObject.m_sMapName]));
          {MainOutMessage('chg-server-fail-3 [' +
                         IntToStr(nServerIndex) +
                         '] -> [' +
                         IntToStr(PlayObject.m_nServerIndex) +
                         '] [' +
                         PlayObject.m_sMapName +
                         ']');}
          PlayObject.m_sMapName := g_Config.sHomeMap;
          g_MapManager.FindMap(g_Config.sHomeMap);
          PlayObject.m_nCurrX := g_Config.nHomeX;
          PlayObject.m_nCurrY := g_Config.nHomeY;
        end
        else
        begin
          if not Envir.CanWalk(PlayObject.m_nCurrX, PlayObject.m_nCurrY, True)
            then
          begin
            MainOutMessage(format(sChangeServerFail4, [nServerIndex,
              PlayObject.m_nServerIndex, PlayObject.m_sMapName]));
            {MainOutMessage('chg-server-fail-4 [' +
                           IntToStr(nServerIndex) +
                           '] -> [' +
                           IntToStr(PlayObject.m_nServerIndex) +
                           '] [' +
                           PlayObject.m_sMapName +
                           ']');}
            PlayObject.m_sMapName := g_Config.sHomeMap;
            Envir := g_MapManager.FindMap(g_Config.sHomeMap);
            PlayObject.m_nCurrX := g_Config.nHomeX;
            PlayObject.m_nCurrY := g_Config.nHomeY;
          end;
          PlayObject.AbilCopyToWAbil();
          PlayObject.m_PEnvir := Envir;
          if PlayObject.m_PEnvir = nil then
          begin
            MainOutMessage(sErrorEnvirIsNil);
            goto ReGetMap;
          end
          else
          begin
            PlayObject.m_boReadyRun := False;
            PlayObject.m_boLoginNoticeOK := True;
            PlayObject.bo6AB := True;
          end;
        end;
      end; //004B085C
      PlayObject.m_sUserID := UserOpenInfo.LoadUser.sAccount;
      PlayObject.m_sIPaddr := UserOpenInfo.LoadUser.sIPaddr;
      PlayObject.m_sIPLocal := GetIPLocal(PlayObject.m_sIPaddr);
      PlayObject.m_nSocket := UserOpenInfo.LoadUser.nSocket;
      PlayObject.m_nGSocketIdx := UserOpenInfo.LoadUser.nGSocketIdx;
      PlayObject.m_nGateIdx := UserOpenInfo.LoadUser.nGateIdx;
      PlayObject.m_nSessionID := UserOpenInfo.LoadUser.nSessionID;
      PlayObject.m_nPayMent := UserOpenInfo.LoadUser.nPayMent;
      PlayObject.m_nPayMode := UserOpenInfo.LoadUser.nPayMode;
      PlayObject.m_dwLoadTick := UserOpenInfo.LoadUser.dwNewUserTick;
      PlayObject.m_nSoftVersionDate := UserOpenInfo.LoadUser.nSoftVersionDate;
      PlayObject.m_nSoftVersionDateEx :=
        GetExVersionNO(UserOpenInfo.LoadUser.nSoftVersionDate,
        PlayObject.m_nSoftVersionDate);
      Result := PlayObject;
    except
      MainOutMessage(sExceptionMsg);
    end;
  end;
var
  dwUsrRotTime: LongWord;
  dwCheckTime: LongWord; //0x10
  dwCurTick: LongWord;
  nCheck30: Integer; //0x30
  boCheckTimeLimit: Boolean; //0x31
  nIdx: Integer;
  PlayObject: TPlayObject;
  I: Integer;
  UserOpenInfo: pTUserOpenInfo;
  GoldChangeInfo: pTGoldChangeInfo;
  LineNoticeMsg: string;
  LineNotice: pTLineNotice;
resourcestring
  sExceptionMsg1 =
    '[Exception] TUserEngine::ProcessHumans -> Ready, Save, Load... Code:=%d';
  sExceptionMsg2 =
    '[Exception] TUserEngine::ProcessHumans ClosePlayer.Delete - Free';
  sExceptionMsg3 = '[Exception] TUserEngine::ProcessHumans ClosePlayer.Delete';
  sExceptionMsg4 = '[Exception] TUserEngine::ProcessHumans RunNotice';
  sExceptionMsg5 =
    '[Exception] TUserEngine::ProcessHumans Human.Operate Code: %d';
  sExceptionMsg6 =
    '[Exception] TUserEngine::ProcessHumans Human.Finalize Code: %d';
  sExceptionMsg7 =
    '[Exception] TUserEngine::ProcessHumans RunSocket.CloseUser Code: %d';
  sExceptionMsg8 = '[Exception] TUserEngine::ProcessHumans';
  sExceptionMsg9 = '[Exception] TUserEngine::ProcessHumans->Hero';
  sExceptionMsg10 = '[Exception] TUserEngine::ProcessHumans RunHero';
begin
  try
    nCheck30 := 0;
    dwCheckTime := GetTickCount();

    if (GetTickCount - m_dwProcessLoadPlayTick) > 200 then
    begin
      m_dwProcessLoadPlayTick := GetTickCount();
      try
        EnterCriticalSection(m_LoadPlaySection);
        try

          for i := 0 to m_LoadPlayList.Count - 1 do
          begin
            if not FrontEngine.IsFull and not
              IsLogined(m_LoadPlayList.Strings[i]) then
            begin
              UserOpenInfo := pTUserOpenInfo(m_LoadPlayList.Objects[i]);
              if UserOpenInfo.LoadUser.boLoadHero then
                PlayObject := MakeNewHeroHuman(UserOpenInfo)
              else
                PlayObject := MakeNewHuman(UserOpenInfo);

              if PlayObject <> nil then
              begin

                //PlayObject.m_boClientFlag:=UserOpenInfo.LoadUser.boClinetFlag; //将客户端标志传到人物数据中
                if PlayObject.m_boHero then
                begin //英雄加入列表
                  m_HeroObjectList.AddObject(m_LoadPlayList.Strings[i],
                    PlayObject);
                end
                else
                begin
                  m_PlayObjectList.AddObject(m_LoadPlayList.Strings[i],
                    PlayObject);
                  SendServerGroupMsg(SS_201, nServerIndex,
                    PlayObject.m_sCharName);
                  m_NewHumanList.Add(PlayObject);
                end;
              end;

            end
            else
            begin //004B0BF9
              KickOnlineUser(m_LoadPlayList.Strings[i]);
              UserOpenInfo := pTUserOpenInfo(m_LoadPlayList.Objects[i]);
              if not UserOpenInfo.LoadUser.boLoadHero then
              begin //非英雄发送数据
                m_ListOfGateIdx.Add(Pointer(UserOpenInfo.LoadUser.nGateIdx));
                //004B0C39
                m_ListOfSocket.Add(Pointer(UserOpenInfo.LoadUser.nSocket));
              end;
            end;
            Dispose(pTUserOpenInfo(m_LoadPlayList.Objects[I]));
          end; //004B0C96
          m_LoadPlayList.Clear;
          for I := 0 to m_ChangeHumanDBGoldList.Count - 1 do
          begin
            GoldChangeInfo := m_ChangeHumanDBGoldList.Items[I];
            PlayObject := GeTPlayObject(GoldChangeInfo.sGameMasterName);
            if PlayObject <> nil then
            begin
              PlayObject.GoldChange(GoldChangeInfo.sGetGoldUser,
                GoldChangeInfo.nGold);
            end;
            Dispose(GoldChangeInfo);
          end;
          m_ChangeHumanDBGoldList.Clear;
        finally
          LeaveCriticalSection(m_LoadPlaySection);
        end;

        //004B0D4A
        for I := 0 to m_NewHumanList.Count - 1 do
        begin
          PlayObject := TPlayObject(m_NewHumanList.Items[I]);
          RunSocket.SetGateUserList(PlayObject.m_nGateIdx, PlayObject.m_nSocket,
            PlayObject);

        end;
        m_NewHumanList.Clear;

        for i := 0 to m_ListOfGateIdx.Count - 1 do
        begin
          RunSocket.CloseUser(Integer(m_ListOfGateIdx.Items[i]),
            Integer(m_ListOfSocket.Items[i])); //GateIdx,nSocket

        end;
        m_ListOfGateIdx.Clear;
        m_ListOfSocket.Clear;
      except
        on e: Exception do
        begin
          MainOutMessage(format(sExceptionMsg1, [0]));
          MainOutMessage(E.Message);
        end;
      end;
    end; //004B0E1E

    try
      for I := 0 to m_PlayObjectFreeList.Count - 1 do
      begin
        PlayObject := TPlayObject(m_PlayObjectFreeList.Items[i]);
        if (GetTickCount - PlayObject.m_dwGhostTick) >
          g_Config.dwHumanFreeDelayTime {5 * 60 * 1000} then
        begin
          try
            TPlayObject(m_PlayObjectFreeList.Items[i]).Free;
          except
            MainOutMessage(sExceptionMsg2);
          end;

          m_PlayObjectFreeList.Delete(i);
          break;
        end
        else
        begin
          if PlayObject.m_boSwitchData and (PlayObject.m_boRcdSaved) then
          begin
            if SendSwitchData(PlayObject, PlayObject.m_nServerIndex) or
              (PlayObject.m_nWriteChgDataErrCount > 20) then
            begin
              PlayObject.m_boSwitchData := False;
              PlayObject.m_boSwitchDataSended := True;
              PlayObject.m_dwChgDataWritedTick := GetTickCount();
            end
            else
              Inc(PlayObject.m_nWriteChgDataErrCount);
          end;
          if PlayObject.m_boSwitchDataSended and ((GetTickCount -
            PlayObject.m_dwChgDataWritedTick) > 100) then
          begin
            PlayObject.m_boSwitchDataSended := False;
            if not PlayObject.m_boHero then
              SendChangeServer(PlayObject, PlayObject.m_nServerIndex);
          end;
        end;
      end;
    except
      MainOutMessage(sExceptionMsg3);
    end; //004B0F91

    //游戏人物循环处理
    boCheckTimeLimit := False; //004B0F91
    try
      dwCurTick := GetTickCount();
      nIdx := m_nProcHumIDx2;
      while True do
      begin
        if m_PlayObjectList.Count <= nIdx then
          break;
        PlayObject := TPlayObject(m_PlayObjectList.Objects[nIdx]);
        try
          if Assigned(m_HookUserEngineRun) then
            m_HookUserEngineRun(PlayObject);
        except
        end;
        if Integer(dwCurTick - PlayObject.m_dwRunTick) > PlayObject.m_nRunTime
          then
        begin
          PlayObject.m_dwRunTick := dwCurTick;
          if not PlayObject.m_boGhost then
          begin //下线处理
            if not PlayObject.m_boLoginNoticeOK then
            begin
{$IF CATEXCEPTION = TRYEXCEPTION}
              try
{$IFEND}
                PlayObject.RunNotice();
{$IF CATEXCEPTION = TRYEXCEPTION}
              except
                MainOutMessage(sExceptionMsg4);
              end;
{$IFEND}
            end
            else
            begin //004B1058
              try
                if PlayObject.m_boOffLineLogin then
                begin
                  PlayObject.m_boOffLineLogin := False;
                  PlayObject.UserOffLineLogon;
                end
                else if not PlayObject.m_boReadyRun then
                begin
                  PlayObject.m_boReadyRun := True; //004B1075
                  PlayObject.UserLogon; //BaseObject.0FFFEh;
                end
                else
                begin
                  if (GetTickCount() - PlayObject.m_dwSearchTick) >
                    PlayObject.m_dwSearchTime then
                  begin
                    PlayObject.m_dwSearchTick := GetTickCount();
                    PlayObject.SearchViewRange;
                    PlayObject.GameTimeChanged;
                  end; //004B10C4

                  //循环发送系统消息开始
                  LineNotice := nil;
                  if (LineNoticeList2.Count > 0) and
                    ((GetTickCount() - PlayObject.m_dwShowLineNoticeTick2) >
                    g_Config.dwShowLineNoticeTime2) then
                  begin
                    PlayObject.m_dwShowLineNoticeTick2 := GetTickCount();
                    if LineNoticeList2.Count > PlayObject.m_nShowLineNoticeIdx2
                      then
                    begin
                      LineNotice :=
                        LineNoticeList2.Items[PlayObject.m_nShowLineNoticeIdx2];
                    end;
                    Inc(PlayObject.m_nShowLineNoticeIdx2);
                    if (LineNoticeList2.Count <=
                      PlayObject.m_nShowLineNoticeIdx2) then
                      PlayObject.m_nShowLineNoticeIdx2 := 0;
                  end
                  else if (GetTickCount() - PlayObject.m_dwShowLineNoticeTick) >
                    g_Config.dwShowLineNoticeTime then
                  begin
                    PlayObject.m_dwShowLineNoticeTick := GetTickCount();
                    if LineNoticeList.Count > PlayObject.m_nShowLineNoticeIdx
                      then
                    begin
                      LineNotice :=
                        LineNoticeList.Items[PlayObject.m_nShowLineNoticeIdx];
                    end;
                    Inc(PlayObject.m_nShowLineNoticeIdx);
                    if (LineNoticeList.Count <= PlayObject.m_nShowLineNoticeIdx)
                      then
                      PlayObject.m_nShowLineNoticeIdx := 0;
                  end;
                  if (LineNotice <> nil) and (g_ManageNPC <> nil) then
                  begin
                    LineNoticeMsg := g_ManageNPC.GetLineVariableText(PlayObject,
                      LineNotice.sNoticeMsg);
                    case LineNotice.nNoticeClass of
                      0:
                        begin
                          PlayObject.SendDefMessage(SM_SELFTOP,
                            0,
                            MakeWord(LineNotice.nNoticefColor,
                            LineNotice.nNoticebColor),
                            0,
                            0,
                            LineNoticeMsg);
                        end;
                      1:
                        begin
                          PlayObject.SysColorMsg(LineNoticeMsg,
                            LineNotice.nNoticefColor, LineNotice.nNoticebColor);
                        end;
                      2:
                        begin
                          PlayObject.SendDefMessage(SM_SELFCENET,
                            15000,
                            MakeWord(LineNotice.nNoticefColor,
                            LineNotice.nNoticebColor),
                            0,
                            0,
                            LineNoticeMsg);
                        end;
                      3:
                        begin
                          PlayObject.SendDefMessage(SM_SELFSYS,
                            15000,
                            MakeWord(LineNotice.nNoticefColor,
                            LineNotice.nNoticebColor),
                            0,
                            0,
                            LineNoticeMsg);
                        end;
                    else
                      begin
                        PlayObject.SysMsg(LineNoticeMsg,
                          TMsgColor(g_Config.nLineNoticeColor), t_Notice);
                      end;
                    end;
                  end;
                  //循环发送系统消息结束

                  PlayObject.Run(); //游戏运行

                  //自动保存人物信息
                  if not FrontEngine.IsFull and ((GetTickCount() -
                    PlayObject.m_dwSaveRcdTick) > g_Config.dwSaveHumanRcdTime)
                      then
                  begin
                    PlayObject.m_dwSaveRcdTick := GetTickCount();

                    PlayObject.DealCancelA();

                    SaveHumanRcd(PlayObject);

                  end;
                end; //004B119F
              except
                on e: Exception do
                begin
                  MainOutMessage(format(sExceptionMsg5, [0]));
                  MainOutMessage(E.Message);
                end;
              end;
            end;
          end
          else
          begin //if not PlayObject.boIsGhost then begin  //CODE:004B11C5
            try
              if PlayObject.m_Hero <> nil then
                //主人下线后，英雄自动下线
                PlayObject.m_Hero.MakeGhost;
              m_PlayObjectList.Delete(nIdx);
              nCheck30 := 2;

              //if not PlayObject.m_boHero then  //非英雄发送数据
              PlayObject.Disappear();

              nCheck30 := 3;
            except
              on e: Exception do
              begin
                MainOutMessage(format(sExceptionMsg6, [nCheck30]));
                MainOutMessage(E.Message);
              end;
            end; //004B1232
            try

              AddToHumanFreeList(PlayObject);

              nCheck30 := 4;
              PlayObject.DealCancelA();

              SaveHumanRcd(PlayObject);

              //if not PlayObject.m_boHero then  //非英雄发送数据
              RunSocket.CloseUser(PlayObject.m_nGateIdx, PlayObject.m_nSocket);

            except
              MainOutMessage(format(sExceptionMsg7, [nCheck30]));
            end; //004B12BA

            //if not PlayObject.m_boHero then  //非英雄发送数据
            SendServerGroupMsg(SS_202, nServerIndex, PlayObject.m_sCharName);
            Continue;
          end;
        end; //if (dwTime14 - PlayObject.dw368) > PlayObject.dw36C then begin
        Inc(nIdx); //004B12E6
        if (GetTickCount - dwCheckTime) > g_dwHumLimit then
        begin
          boCheckTimeLimit := True;
          m_nProcHumIDx2 := nIdx;
          break;
        end;
      end; //while True do begin
      if not boCheckTimeLimit then
        m_nProcHumIDx2 := 0;
    except
      MainOutMessage(sExceptionMsg8);
    end;
    Inc(nProcessHumanLoopTime2);
    g_nProcessHumanLoopTime2 := nProcessHumanLoopTime2;
    if m_nProcHumIDx2 = 0 then
    begin
      nProcessHumanLoopTime2 := 0;
      g_nProcessHumanLoopTime2 := nProcessHumanLoopTime2;
      dwUsrRotTime := GetTickCount - g_dwUsrRotCountTick2;
      dwUsrRotCountMin := dwUsrRotTime;
      g_dwUsrRotCountTick2 := GetTickCount();
      if dwUsrRotCountMax2 < dwUsrRotTime then
        dwUsrRotCountMax2 := dwUsrRotTime;
    end;
    g_nHumCountMin2 := GetTickCount - dwCheckTime;
    if g_nHumCountMax2 < g_nHumCountMin2 then
      g_nHumCountMax2 := g_nHumCountMin2;

    //英雄循环处理
    boCheckTimeLimit := False; //004B0F91
    try
      dwCurTick := GetTickCount();
      nIdx := m_nHeroHumIDx;
      while True do
      begin
        if m_HeroObjectList.Count <= nIdx then
          break;
        PlayObject := TPlayObject(m_HeroObjectList.Objects[nIdx]);
        if Integer(dwCurTick - PlayObject.m_dwRunTick) > PlayObject.m_nRunTime
          then
        begin
          PlayObject.m_dwRunTick := dwCurTick;
          if not PlayObject.m_boGhost then
          begin //下线处理
            if not PlayObject.m_boReadyRun then
            begin
              PlayObject.m_boReadyRun := True; //004B1075
              PlayObject.HeroLogon; //BaseObject.0FFFEh;
            end
            else
            begin
              //if (PlayObject.m_btAttatckMode=0) and (not PlayObject.m_HeroboLocked) then begin
              if (GetTickCount() - PlayObject.m_dwSearchTick) >
                PlayObject.m_dwSearchTime then
              begin
                PlayObject.m_dwSearchTick := GetTickCount();
                PlayObject.SearchViewRange;
              end;
              //end;
{$IF CATEXCEPTION = TRYEXCEPTION}
              try
{$IFEND}
                PlayObject.RunHero;
{$IF CATEXCEPTION = TRYEXCEPTION}
              except
                MainOutMessage(sExceptionMsg10);
              end;
{$IFEND}

              //自动保存人物信息
              if not FrontEngine.IsFull and ((GetTickCount() -
                PlayObject.m_dwSaveRcdTick) > g_Config.dwSaveHumanRcdTime) then
              begin
                PlayObject.m_dwSaveRcdTick := GetTickCount();

                PlayObject.DealCancelA();

                SaveHumanRcd(PlayObject);
              end;
            end;
          end
          else
          begin
            //mainoutmessage('有到');
            try
              m_HeroObjectList.Delete(nIdx);
              nCheck30 := 2;

              //if not PlayObject.m_boHero then  //非英雄发送数据
              PlayObject.Disappear();

              nCheck30 := 3;
            except
              on e: Exception do
              begin
                MainOutMessage(format(sExceptionMsg6, [nCheck30]));
                MainOutMessage(E.Message);
              end;
            end; //004B1232
            try

              AddToHumanFreeList(PlayObject);

              nCheck30 := 4;
              PlayObject.DealCancelA();

              SaveHumanRcd(PlayObject);

              //if not PlayObject.m_boHero then  //非英雄发送数据
              //RunSocket.CloseUser(PlayObject.m_nGateIdx,PlayObject.m_nSocket);

            except
              MainOutMessage(format(sExceptionMsg7, [nCheck30]));
            end; //004B12BA

            //if not PlayObject.m_boHero then  //非英雄发送数据
            //SendServerGroupMsg(SS_202,nServerIndex,PlayObject.m_sCharName);
            Continue;
          end;
        end;
        Inc(nIdx); //004B12E6
        if (GetTickCount - dwCheckTime) > g_dwHumLimit then
        begin
          boCheckTimeLimit := True;
          m_nHeroHumIDx := nIdx;
          break;
        end;
      end; //wilth do
      if not boCheckTimeLimit then
        m_nHeroHumIDx := 0;
    except
      MainOutMessage(sExceptionMsg9);
    end;
    Inc(nProcessHeroLoopTime);
    g_nProcessHeroLoopTime := nProcessHeroLoopTime;
    if m_nHeroHumIDx = 0 then
    begin
      nProcessHeroLoopTime := 0;
      g_nProcessHeroLoopTime := nProcessHeroLoopTime;
      dwUsrRotTime := GetTickCount - g_dwHeroRotCountTick;
      dwHeroRotCountMin := dwUsrRotTime;
      g_dwHeroRotCountTick := GetTickCount();
      if dwHeroRotCountMax < dwUsrRotTime then
        dwHeroRotCountMax := dwUsrRotTime;
    end;
    g_nHeroCountMin := GetTickCount - dwCheckTime;
    if g_nHeroCountMax < g_nHeroCountMin then
      g_nHeroCountMax := g_nHeroCountMin;

  except
    MainOutMessage('[Exception] TUserEngine.ProcessHumans');
  end;
end;

procedure TUserEngine.ProcessMerchants; //004B1B8C
var
  dwRunTick, dwCurrTick: LongWord;
  i: integer;
  MerchantNPC: TMerchant;
  boProcessLimit: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::ProcessMerchants';
begin
  try
    dwRunTick := GetTickCount();
    boProcessLimit := False;
    try
      dwCurrTick := GetTickCount();
      m_MerchantList.Lock;
      try
        for i := nMerchantPosition to m_MerchantList.Count - 1 do
        begin
          MerchantNPC := m_MerchantList.Items[i];
          if not MerchantNPC.m_boGhost then
          begin
            if Integer(dwCurrTick - MerchantNPC.m_dwRunTick) >
              MerchantNPC.m_nRunTime then
            begin
              if (GetTickCount - MerchantNPC.m_dwSearchTick) >
                MerchantNPC.m_dwSearchTime then
              begin
                MerchantNPC.m_dwSearchTick := GetTickCount();
                MerchantNPC.SearchViewRange();
              end; //004B1C3C
              if Integer(dwCurrTick - MerchantNPC.m_dwRunTick) >
                MerchantNPC.m_nRunTime then
              begin
                MerchantNPC.m_dwRunTick := dwCurrTick;
                MerchantNPC.Run; {FFFFB}
              end;
            end; //004B1C6B
          end
          else
          begin //004B1C6B
            if (GetTickCount - MerchantNPC.m_dwGhostTick) > 60 * 1000 then
            begin
              MerchantNPC.Free;
              m_MerchantList.Delete(i);
              break;
            end;
          end;
          if (GetTickCount - dwRunTick) > g_dwNpcLimit2 then
          begin
            nMerchantPosition := i + 1;
            boProcessLimit := True;
            Break;
          end; //004B1C8C
        end; //004B1C98
      finally
        m_MerchantList.UnLock;
      end;
      if not boProcessLimit then
      begin
        nMerchantPosition := 0;
      end; //004B1CA6
    except
      MainOutMessage(sExceptionMsg);
    end;
    dwProcessMerchantTimeMin := GetTickCount - dwRunTick;
    if dwProcessMerchantTimeMin > dwProcessMerchantTimeMax then
      dwProcessMerchantTimeMax := dwProcessMerchantTimeMin;
    if dwProcessNpcTimeMin > dwProcessNpcTimeMax then
      dwProcessNpcTimeMax := dwProcessNpcTimeMin;
  except
    MainOutMessage('[Exception] TUserEngine.ProcessMerchants');
  end;
end;

{procedure TUserEngine.ProcessMissions;
begin
Try

Except
  MainOutMessage('[Exception] TUserEngine.ProcessMissions');
End;
end; }

procedure TUserEngine.ProcessMonsters;

//004B1638
var
  dwCurrentTick: LongWord;
  dwRunTick: LongWord;
  dwMonProcTick: LongWord;
  MonGen: pTMonGenInfo;
  nGenCount: Integer;
  nGenModCount: Integer;
  boProcessLimit: Boolean;
  boRegened: Boolean;
  I: Integer;
  nProcessPosition: Integer;
  nMakeMonsterCount: Integer;
  Monster: TAnimalObject;
  tCode: Integer;
  //nActiveHumCount  :Integer;
  function GetZenTime(dwTime: LongWord): LongWord;
  var
    r: Real;
  begin
    if dwTime < 30 * 60 * 1000 then
    begin
      r := (GetUserCount - g_Config.nUserFull) / g_Config.nZenFastStep;
      if r > 0 then
      begin
        if r > 6 then
          r := 6;
        Result := dwTime - Round((dwTime / 10) * r)
      end
      else
        Result := dwTime;
    end
    else
      Result := dwTime;
  end;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::ProcessMonsters %d';
  sExceptionMsg2 = '[Exception] TUserEngine::ProcessMonsters %d %s %s %d:%d';
begin
  try
    tCode := 0;
    dwRunTick := GetTickCount();
    try
      tCode := 1990;
      boProcessLimit := False;
      dwCurrentTick := GetTickCount();
      MonGen := nil;
      //刷新怪物开始
      if ((GetTickCount - dwRegenMonstersTick) > g_Config.dwRegenMonstersTime)
        then
      begin
        dwRegenMonstersTick := GetTickCount();
        if m_nCurrMonGen < m_MonGenList.Count then
        begin
          MonGen := m_MonGenList.Items[m_nCurrMonGen];
        end;
        if m_nCurrMonGen < m_MonGenList.Count - 1 then
        begin
          Inc(m_nCurrMonGen);
        end
        else
        begin
          m_nCurrMonGen := 0;
        end;
        if (MonGen <> nil) and
          (MonGen.sMonName <> '') and
          (MonGen.Envir <> nil) and
          (TEnvirnoment(MonGen.Envir).m_boMakeMon) and //智能刷怪控制
        (not g_Config.boVentureServer) then
        begin

          //MonGen.boMonGhost:=False;
          if (MonGen.dwStartTick = 0) or ((GetTickCount - MonGen.dwStartTick) >
            GetZenTime(MonGen.dwZenTime)) then
          begin
            nGenCount := GetGenMonCount(MonGen);
            boRegened := True;
            if g_Config.nMonGenRate <= 0 then
              g_Config.nMonGenRate := 10; //防止除法错误
            nGenModCount := _MAX(1, ROUND(_MAX(1, MonGen.nCount) /
              (g_Config.nMonGenRate / 10)));
            nMakeMonsterCount := nGenModCount - nGenCount;
            if nMakeMonsterCount < 0 then
              nMakeMonsterCount := 0;
            //GetMapHuman(MonGen.sMapName);
            {if MonGen.boNoManNoMon then begin              //智能刷怪控制
              nActiveHumCount:=GetMapHuman(MonGen.sMapName);
              if (nActiveHumCount > 0) then begin
                MonGen.dwNoHumTime:=GetTickCount();
                boRegened := RegenMonsters(MonGen, nMakeMonsterCount);
              end else begin
                if ((GetTickCount - MonGen.dwNoHumTime) > 10 * 1000) then
                  MonGen.boMonGhost:=True;
              end;
            end else }
            if (nMakeMonsterCount > 0) then
            begin //0806 增加 控制刷怪数量比例
              boRegened := RegenMonsters(MonGen, nMakeMonsterCount);
            end;
            if boRegened then
            begin
              MonGen.dwStartTick := GetTickCount();
            end;
          end;
          g_sMonGenInfo1 := MonGen.sMonName + ',' + IntToStr(m_nCurrMonGen) + '/'
            + IntToStr(m_MonGenList.Count);
        end
        else
        begin
          if (MonGen <> nil) then
            MonGen.dwStartTick := 0;
        end;
      end;
      g_nMonGenTime := GetTickCount - dwCurrentTick;
      if g_nMonGenTime > g_nMonGenTimeMin then
        g_nMonGenTimeMin := g_nMonGenTime;
      if g_nMonGenTime > g_nMonGenTimeMax then
        g_nMonGenTimeMax := g_nMonGenTime;

      //刷新怪物结束

      dwMonProcTick := GetTickCount();
      nMonsterProcessCount := 0;
      tCode := 1;
      //004B187B
      for I := m_nMonGenListPosition to m_MonGenList.Count - 1 do
      begin
        MonGen := m_MonGenList.Items[I];
        tCode := 11;
        if m_nMonGenCertListPosition < MonGen.CertList.Count then
        begin
          nProcessPosition := m_nMonGenCertListPosition;
        end
        else
        begin //4B18A8
          nProcessPosition := 0;
        end;
        m_nMonGenCertListPosition := 0;
        //4B18B5
        while (True) do
        begin
          if nProcessPosition >= MonGen.CertList.Count then
            break;
          Monster := MonGen.CertList.Items[nProcessPosition];
          tCode := 12;
          //Jason 0626增加
         { if Monster=Nil then begin
            MonGen.CertList.Delete(nProcessPosition);
            Continue;
          end; }
          tCode := 1211;
          //if MonGen.boMonGhost then   //智能刷怪
            //Monster.MakeGhost;
          //Monster.m_Envir.
          if MonGen.boNoManNoMon and Monster.m_PEnvir.m_boClearMon then
          begin
            Monster.MakeGhost();
          end;

          if not Monster.m_boGhost then
          begin
            tCode := 1212;
            if (dwMonProcTick - Monster.m_dwRunTick) >
              LongWord(Monster.m_nRunTime) then
            begin
              tCode := 1213;
              Monster.m_dwRunTick := dwMonProcTick;

              if (dwCurrentTick - Monster.m_dwSearchTick) >
                Monster.m_dwSearchTime then
              begin
                Monster.m_dwSearchTick := GetTickCount();
                tCode := 13;
                try
                  Monster.SearchViewRange();
                except
                  //MainOutMessage(format(sExceptionMsg,[tCode]));
                  //Monster.MakeGhost;
                end;
              end;
              tCode := 14;

              tCode := 141;

              if (not Monster.m_boIsVisibleActive) and
                (not Monster.m_boRun) and
                (Monster.m_Castle = nil) and
                (Monster.m_nProcessRunCount < g_Config.nProcessMonsterInterval2)
                and
                (Monster.m_TargetCret = nil) and
                (Monster.m_MsgList.Count <= 0) {Jason 0716} then
              begin
                Inc(Monster.m_nProcessRunCount);
              end
              else
              begin
                tCode := 143;
                Monster.m_nProcessRunCount := 0;
                try
                  Monster.Run;
                except
                  //MainOutMessage(format(sExceptionMsg,[tCode]));
                  //Monster.MakeGhost;
                end;
                tCode := 144;
              end;

              Inc(nMonsterProcessCount);
            end;
            Inc(nMonsterProcessPostion);
            tCode := 144;
          end
          else
          begin
            if (GetTickCount - Monster.m_dwGhostTick) > 5 * 60 * 1000 then
            begin
              tCode := 145;
              MonGen.CertList.Delete(nProcessPosition);
              tCode := 146;
              Monster.Free;
              Continue;
            end;
          end;

          Inc(nProcessPosition);
          if (GetTickCount - dwMonProcTick) > g_dwMonLimit then
          begin
            g_sMonGenInfo2 := Monster.m_sCharName + '/' + IntToStr(I) + '/' +
              IntToStr(nProcessPosition);
            boProcessLimit := True;
            m_nMonGenCertListPosition := nProcessPosition;
            break;
          end;
        end; //while (True) do begin
        if boProcessLimit then
          break;
      end; //for I:= m_nMonGenListPosition to MonGenList.Count -1 do begin
      //004B1A5D
      tCode := 147;
      tCode := 2;
      if m_MonGenList.Count <= I then
      begin
        m_nMonGenListPosition := 0;
        nMonsterCount := nMonsterProcessPostion;
        nMonsterProcessPostion := 0;
        n84 := (n84 + nMonsterProcessCount) div 2;
      end; //4B1AAF
      tCode := 148;
      if not boProcessLimit then
      begin
        m_nMonGenListPosition := 0;
      end
      else
      begin
        m_nMonGenListPosition := I;
      end;
      tCode := 149;
      g_nMonProcTime := GetTickCount - dwMonProcTick;
      if g_nMonProcTime > g_nMonProcTimeMin then
        g_nMonProcTimeMin := g_nMonProcTime;
      if g_nMonProcTime > g_nMonProcTimeMax then
        g_nMonProcTimeMax := g_nMonProcTime;

    except
      on e: Exception do
      begin
        MainOutMessage(format(sExceptionMsg, [tCode]));
        MainOutMessage(E.Message);
      end;
    end;
    g_nMonTimeMin := GetTickCount - dwRunTick;
    if g_nMonTimeMax < g_nMonTimeMin then
      g_nMonTimeMax := g_nMonTimeMin;
  except
    MainOutMessage('[Exception] TUserEngine.ProcessMonsters');
  end;
end;

function TUserEngine.GetGenMonCount(MonGen: pTMonGenInfo): Integer; //4AE19C
var
  I: Integer;
  nCount: Integer;
  BaseObject: TBaseObject;
begin
  try
    nCount := 0;
    for I := 0 to MonGen.CertList.Count - 1 do
    begin
      BaseObject := TBaseObject(MonGen.CertList.Items[I]);
      if not BaseObject.m_boDeath and not BaseObject.m_boGhost then
        Inc(nCount);
    end;
    Result := nCount;
  except
    MainOutMessage('[Exception] TUserEngine.GetGenMonCount');
  end;
end;

procedure TUserEngine.ProcessNpcs;
var
  dwRunTick, dwCurrTick: LongWord;
  i: integer;
  NPC: TNormNpc;
  boProcessLimit: Boolean;
begin
  try
    dwRunTick := GetTickCount();
    boProcessLimit := False;
    try
      dwCurrTick := GetTickCount();
      for i := nNpcPosition to QuestNPCList.Count - 1 do
      begin
        NPC := QuestNPCList.Items[i];
        if not NPC.m_boGhost then
        begin
          if Integer(dwCurrTick - NPC.m_dwRunTick) > NPC.m_nRunTime then
          begin
            if (GetTickCount - NPC.m_dwSearchTick) > NPC.m_dwSearchTime then
            begin
              NPC.m_dwSearchTick := GetTickCount();
              NPC.SearchViewRange();
            end;
            if Integer(dwCurrTick - NPC.m_dwRunTick) > NPC.m_nRunTime then
            begin
              NPC.m_dwRunTick := dwCurrTick;
              NPC.Run; {FFFFB}
            end;
          end;
        end
        else
        begin
          if (GetTickCount - NPC.m_dwGhostTick) > 60 * 1000 then
          begin
            NPC.Free;
            QuestNPCList.Delete(i);
            break;
          end;
        end;
        if (GetTickCount - dwRunTick) > g_dwNpcLimit2 then
        begin
          nNpcPosition := i + 1;
          boProcessLimit := True;
          Break;
        end;
      end;
      if not boProcessLimit then
      begin
        nNpcPosition := 0;
      end;
    except
      MainOutMessage('[Exceptioin] TUserEngine.ProcessNpcs');
    end;
    dwProcessNpcTimeMin := GetTickCount - dwRunTick;
    if dwProcessNpcTimeMin > dwProcessNpcTimeMax then
      dwProcessNpcTimeMax := dwProcessNpcTimeMin;
  except
    MainOutMessage('[Exception] TUserEngine.ProcessNpcs');
  end;
end;
//004ADE3C

function TUserEngine.RegenMonsterByName(sMap: string; nX, nY: Integer;
  sMonName: string; Master: TBaseObject = nil; boClone: Boolean = False):
  TBaseObject;
var
  nRace: Integer;
  BaseObject: TBaseObject;
  n18, II: Integer;
  MonGen: pTMonGenInfo;
  nCheckCode: Byte;
  CorpsIdx, sColor, sTemp: string;
  nIconIdx: array[0..4] of Word;
  boAdd: Boolean;
begin
  try
    nCheckCode := 0;
    try
      boAdd := False;
      CorpsIdx := GetValidStr3(sMonName, sMonName, ['|']);
      if CorpsIdx <> '' then
      begin
        sColor := GetValidStr3(CorpsIdx, CorpsIdx, ['|']);
        for II := Low(nIconIdx) to High(nIconIdx) do
        begin
          CorpsIdx := GetValidStr3(CorpsIdx, sTemp, ['\']); //特殊图标
          nIconIdx[II] := Str_ToInt(sTemp, 0);
        end;
        boAdd := True;
      end;

      if boClone then
        nRace := MONSTER_CLONE
      else
        nRace := GetMonRace(sMonName);
      nCheckCode := 1;
      BaseObject := AddBaseObject(sMap, nX, nY, nRace, sMonName, Master,
        boClone);
      nCheckCode := 2;
      if BaseObject <> nil then
      begin
        nCheckCode := 3;
        n18 := m_MonGenList.Count - 1;
        if n18 < 0 then
          n18 := 0;
        nCheckCode := 4;
        MonGen := m_MonGenList.Items[n18];
        nCheckCode := 5;
        MonGen.CertList.Add(BaseObject);
        nCheckCode := 6;
        if boAdd then
        begin
          BaseObject.m_btChangeNameColor := StrToIntDef(sColor, 255);
          for II := Low(BaseObject.m_nIconIdx) to High(BaseObject.m_nIconIdx) do
            BaseObject.m_nIconIdx[II] := nIconIdx[II];
        end;
      end;
      Result := BaseObject;
    except
      MainOutMessage('[Exception] TUserEngine.RegenMonsterByName nCode=' +
        IntToStr(nCheckCode));
    end;
  except
    MainOutMessage('[Exception] TUserEngine.RegenMonsterByName');
  end;
end;

procedure TUserEngine.Run; //004B20B8
//var
//  i:integer;
//  dwProcessTick:LongWord;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::Run';
begin
  try
    CalceTime := GetTickCount;
    try
      {
      ProcessHumans();
      if (GetTickCount() - dwProcessMonstersTick) > g_dwProcessMonstersTime then begin
        dwProcessMonstersTick:=GetTickCount();
        ProcessMonsters();
      end;
      dwProcessTick:=GetTickCount();
      ProcessMerchants();
      dwProcessMerchantTimeMin:=GetTickCount - dwProcessTick;
      dwProcessTick:=GetTickCount();

      ProcessNpcs();
      dwProcessNpcTimeMin:=GetTickCount - dwProcessTick;
      if (GetTickCount() - dwProcessMissionsTime) > 1000 then begin
        dwProcessMissionsTime:=GetTickCount();
        ProcessMissions();
        Process4AECFC();
        ProcessEvents();
      end;
      if (GetTickCount() - dwProcessMapDoorTick) > 500 then begin
        dwProcessMapDoorTick:=GetTickCount();
        ProcessMapDoor();
      end;
      }
      if (GetTickCount() - dwShowOnlineTick) >
        g_Config.dwConsoleShowUserCountTime then
      begin
        //      if (GetTickCount() - dwShowOnlineTime) > 5000 then begin
        dwShowOnlineTick := GetTickCount();
        NoticeManager.LoadingNotice;
        //        MainOutMessage(TimeToStr(Now) + ' 在线数: ' + IntToStr(GetUserCount));
        MainOutMessage('在线数: ' + IntToStr(GetUserCount) + '(' +
          IntToStr(GetUserCount - GetOffLineCount) + '/' +
          IntToStr(GetOffLineCount) + ')');
        //        UserCastle.Save;
        g_CastleManager.Save;
      end;
      if (GetTickCount() - dwSendOnlineHumTime) > 10000 then
      begin
        dwSendOnlineHumTime := GetTickCount();
        FrmIDSoc.SendOnlineHumCountMsg(GetOnlineHumCount);
        //        GuildManager.Run;
        //        UserCastle.Run;
        //        for i:=0 to DenySayMsgList.Count - 1 do begin
        //          //
        //        end;
      end;
    except
      on e: Exception do
      begin
        MainOutMessage(sExceptionMsg);
        MainOutMessage(E.Message);
      end;
    end;
    //    dwUsrTimeMin:=GetTickCount() - CalceTime;
    //    if dwUsrTimeMax < dwUsrTimeMin then dwUsrTimeMax:=dwUsrTimeMin;

  except
    MainOutMessage('[Exception] TUserEngine.Run');
  end;
end;

{function TUserEngine.GetStdItemEx(nItemIdx:Integer):pTStdItem;
begin
Try
  Result:=Nil;
  Dec(nItemIdx);
  if (nItemIdx>=0) and (StdItemListEx.Count > nItemIdx) then begin
    Result:=StdItemListEx.Items[nItemIdx];
    if Result.Name='' then Result:=Nil;
  end;
Except
  MainOutMessage('[Exception] TUserEngine.GetStdItemEx');
End;
end;

function TUserEngine.GetStdItemEx(sItemName:String):pTStdItem;
var
  I: Integer;
  StdItem:pTStdItem;
begin
Try
  Result:=Nil;
  if sItemName='' then exit;
  For I:=0 to StdItemListEx.Count -1 do begin
    StdItem:=StdItemListEx.Items[I];
    if CompareText(StdItem.Name,sItemName)=0 then begin
      Result:=StdItem;
      Break;
    end;
  end;
Except
  MainOutMessage('[Exception] TUserEngine.GetStdItemEx');
End;
end;     }

function TUserEngine.GetStdItem(nItemIdx: Integer): TItem; //004AC2F8
begin
  try
    Result := nil;
    Dec(nItemIdx);
    if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then
    begin
      Result := StdItemList.Items[nItemIdx];
      //MainOutMessage(Result.Name); //输出文本
      if Result.Name = '' then
        Result := nil;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetStdItem');
  end;
end;

function TUserEngine.GetStdItem(sItemName: string): TItem; //004AC348
var
  I: Integer;
  StdItem: TItem;
begin
  try
    Result := nil;
    if sItemName = '' then
      exit;
    for I := 0 to StdItemList.Count - 1 do
    begin
      StdItem := StdItemList.Items[i];
      if CompareText(StdItem.Name, sItemName) = 0 then
      begin
        Result := StdItem;
        break;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetStdItem');
  end;
end;

function TUserEngine.GetStdItemNameEx(nStdMode,nShape:Integer): string;
var
  I: Integer;
  StdItem: TItem;
begin
  try
    Result :='';
    for I := 0 to StdItemList.Count - 1 do
    begin
      StdItem := StdItemList.Items[i];
      if (StdItem.StdMode=nStdMode) and (StdItem.Shape=nShape) then
      begin
        Result := StdItem.Name;
        break;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetStdItemNameEx');
  end;
end;

function TUserEngine.GetStdItemWeight(nItemIdx: Integer): Integer; //004AC2B0
var
  StdItem: TItem;
begin
  try
    Dec(nItemIdx);
    if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then
    begin
      StdItem := StdItemList.Items[nItemIdx];
      Result := StdItem.Weight;
    end
    else
    begin
      Result := 0;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetStdItemWeight');
  end;
end;

function TUserEngine.GetStdItemName(nItemIdx: Integer): string; //004AC1AC
begin
  try
    Result := '';
    Dec(nItemIdx);
    if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then
    begin
      Result := TItem(StdItemList.Items[nItemIdx]).Name;

    end
    else
      Result := '';
  except
    MainOutMessage('[Exception] TUserEngine.GetStdItemName');
  end;
end;

function TUserEngine.FindOtherServerUser(sName: string;
  var nServerIndex): Boolean;
begin
  try
    Result := False;
  except
    MainOutMessage('[Exception] TUserEngine.FindOtherServerUser');
  end;
end;

//004AEA00

procedure TUserEngine.CryCry(wIdent: Word; pMap: TEnvirnoment; nX, nY,
  nWide: Integer; btFColor, btBColor: Byte; sMsg: string);
var
  i: integer;
  PlayObject: TPlayObject;
begin
  try
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
      if not PlayObject.m_boGhost and
        (PlayObject.m_PEnvir = pMap) and
        (PlayObject.m_boBanShout) and
        (abs(PlayObject.m_nCurrX - nX) < nWide) and
        (abs(PlayObject.m_nCurrY - nY) < nWide) then
      begin

        //PlayObject.SendMsg(nil,wIdent,0,0,$FFFF,0,sMsg);
        PlayObject.SendMsg(nil, wIdent, 0, btFColor, btBColor, 0, sMsg);
        //MainOutMessage(Format('%d/%d',[btFColor,btBColor]));
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.CryCry');
  end;
end;

procedure TUserEngine.DemoRun;
begin
  try
    try
      Run();
    except
      MainOutMessage('[Exception] TUserEngine.DemoRun');
    end;
  except
    MainOutMessage('[Exception] TUserEngine.DemoRun');
  end;
end;

function TUserEngine.MonGetRandomItems(mon: TBaseObject): Integer; //004AD2E8
var
  i: integer;
  ItemList: TList;
  iname: string;
  MonItem: pTMonItem;
  UserItem: pTUserItem;
  StdItem: TItem;
  Monster: pTMonInfo;
begin
  try
    try
      ItemList := nil;
      for i := 0 to MonsterList.Count - 1 do
      begin
        Monster := MonsterList.Items[i];
        if CompareText(Monster.sName, mon.m_sCharName) = 0 then
        begin
          ItemList := Monster.Itemlist;
          break;
        end;
      end;
      if ItemList <> nil then
      begin
        for i := 0 to ItemList.Count - 1 do
        begin
          MonItem := pTMonItem(ItemList[i]);
          if Random(MonItem.MaxPoint) <= MonItem.SelPoint then
          begin
            if CompareText(MonItem.ItemName, sSTRING_GOLDNAME) = 0 then
            begin
              mon.m_nGold := mon.m_nGold + (MonItem.Count div 2) +
                Random(MonItem.Count);
            end
            else
            begin
              //蜡聪农 酒捞袍 捞亥飘....
              iname := '';
              ////if (BoUniqueItemEvent) and (not mon.BoAnimal) then begin
              ////   if GetUniqueEvnetItemName (iname, numb) then begin
                    //numb; //iname
              ////   end;
              ////end;
              if iname = '' then
                iname := MonItem.ItemName;

              New(UserItem);
              if CopyToUserItemFromName(iname, UserItem) then
              begin
                UserItem.Dura := Round((UserItem.DuraMax / 100) * (20 +
                  Random(80)));

                StdItem := GetStdItem(UserItem.wIndex);
                ////if pstd <> nil then
                ////   if pstd.StdMode = 50 then begin  //惑前鼻
                ////      pu.Dura := numb;
                ////   end;
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
                mon.m_ItemList.Add(UserItem)
              end
              else
                Dispose(UserItem);
            end;
          end;
        end;
      end;
      Result := 1;
    except
      MainOutMessage('[Exception] TUserEngine.MonGetRandomItems');
    end;
  except
    MainOutMessage('[Exception] TUserEngine.MonGetRandomItems');
  end;
end;

//004AC404

function TUserEngine.CopyToUserItemFromName(sItemName: string; Item:
  pTUserItem): Boolean;
var
  I: Integer;
  StdItem: TItem;
begin
  try
    Result := False;
    if sItemName <> '' then
    begin
      for I := 0 to StdItemList.Count - 1 do
      begin
        StdItem := StdItemList.Items[i];
        if CompareText(StdItem.Name, sItemName) = 0 then
        begin
          FillChar(Item^, SizeOf(TUserItem), #0);
          Item.wIndex := i + 1;
          Item.MakeIndex := GetItemNumber();
          if (StdItem.StdMode=2) and (StdItem.Reserved=56) then //泉水罐刷出的为Dura为零
           Item.Dura:=0
          else
          Item.Dura := StdItem.DuraMax;
          Item.DuraMax := StdItem.DuraMax;
          Result := True;
          break;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.CopyToUserItemFromName');
  end;
end;

procedure TUserEngine.ProcessUserMessage(PlayObject: TPlayObject; DefMsg:
  pTDefaultMessage; Buff: PChar); //004B232C
var
  sMsg: string;
  //  I:integer;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::ProcessUserMessage..';
begin
  try
    if (DefMsg = nil) or (PlayObject = nil) then
      exit;
    try
      if Buff = nil then
        sMsg := ''
      else
        sMsg := StrPas(Buff);

      case DefMsg.Ident of
        CM_SPELL:
          begin //3017
            //if PlayObject.GetSpellMsgCount <=2 then  //如果队排里有超过二个魔法操作，则不加入队排
            if g_Config.boSpellSendUpdateMsg then
            begin //使用UpdateMsg 可以防止消息队列里有多个操作
              PlayObject.SendUpdateMsg(PlayObject,
                DefMsg.Ident,
                DefMsg.Tag,
                LoWord(DefMsg.Recog),
                HiWord(DefMsg.Recog),
                MakeLong(DefMsg.Param,
                DefMsg.Series),
                '');
            end
            else
            begin
              PlayObject.SendMsg(PlayObject,
                DefMsg.Ident,
                DefMsg.Tag,
                LoWord(DefMsg.Recog),
                HiWord(DefMsg.Recog),
                MakeLong(DefMsg.Param,
                DefMsg.Series),
                '');
            end;
          end;

        CM_QUERYUSERNAME:
          begin //80
            PlayObject.SendMsg(PlayObject, DefMsg.Ident, 0, DefMsg.Recog,
              DefMsg.Param {x}, DefMsg.Tag {y}, '');
          end;

        CM_DROPITEM,
          CM_TAKEONITEM,
          CM_TAKEOFFITEM,
          CM_1005,

        CM_MERCHANTDLGSELECT,
          CM_MERCHANTQUERYSELLPRICE,
          CM_USERSELLITEM,
          CM_USERBUYITEM,
          CM_USERGETDETAILITEM,

        CM_CREATEGROUP,
          CM_ADDGROUPMEMBER,
          CM_DELGROUPMEMBER,
          CM_USERREPAIRITEM,
          CM_MERCHANTQUERYREPAIRCOST,
          CM_DEALTRY,
          CM_DEALADDITEM,
          CM_DEALDELITEM,

        CM_USERSTORAGEITEM,
          CM_USERTAKEBACKSTORAGEITEM,
          //      CM_WANTMINIMAP,
        CM_USERMAKEDRUGITEM,

        CM_SHOPBUY,
          CM_LEVELITEM,
          CM_1100..CM_1106,
          CM_SELFSHOPBUY,

        //      CM_GUILDHOME,
        CM_GUILDADDMEMBER,
          CM_GUILDDELMEMBER,
          CM_GUILDUPDATENOTICE,
          CM_AUTOADDGROUP,
          CM_GETADDRESS,
          CM_SENDDATA,
          CM_SHOPSEND,
          CM_PLAYDRINK,
          CM_GUILDUPDATERANKINFO:
          begin
            PlayObject.SendMsg(PlayObject,
              DefMsg.Ident,
              DefMsg.Series,
              DefMsg.Recog,
              DefMsg.Param,
              DefMsg.Tag,
              DecodeString(sMsg));
          end;
        CM_PASSWORD,
          CM_CHGPASSWORD,

        CM_SETPASSWORD:
          begin
            PlayObject.SendMsg(PlayObject,
              DefMsg.Ident,
              DefMsg.Param,
              DefMsg.Recog,
              DefMsg.Series,
              DefMsg.Tag,
              DecodeString(sMsg));
          end;
        CM_ADJUST_BONUS:
          begin //1043
            PlayObject.SendMsg(PlayObject,
              DefMsg.Ident,
              DefMsg.Series,
              DefMsg.Recog,
              DefMsg.Param,
              DefMsg.Tag,
              sMsg);
          end;
        CM_HORSERUN,
          CM_TURN,
          CM_WALK,
          CM_SITDOWN,
          CM_RUN,
          CM_HIT,
          CM_HEAVYHIT,
          CM_BIGHIT,

        CM_POWERHIT,
          CM_LONGHIT,
          CM_CRSHIT,
          CM_TWINHIT,
          CM_WIDEHIT,
          CM_LONGSWORD1,
          CM_LONGSWORD2,
          CM_LONGFIRESWORD,
          CM_FIREHIT:
          begin
            if g_Config.boActionSendActionMsg then
            begin //使用UpdateMsg 可以防止消息队列里有多个操作
              PlayObject.SendActionMsg(PlayObject,
                DefMsg.Ident,
                DefMsg.Tag,
                LoWord(DefMsg.Recog), {x}
                HiWord(DefMsg.Recog), {y}
                0,
                '');
            end
            else
            begin
              PlayObject.SendMsg(PlayObject,
                DefMsg.Ident,
                DefMsg.Tag,
                LoWord(DefMsg.Recog), {x}
                HiWord(DefMsg.Recog), {y}
                0,
                '');
            end;
          end;
        CM_SAY:
          begin
            PlayObject.SendMsg(PlayObject, CM_SAY, 0, 0, 0, 0,
              DecodeString(sMsg));
          end;
      else
        begin
          { Try
             if g_HookClientUserMessage.Count > 0 then begin
               For I:=0 to g_HookClientUserMessage.Count-1 do
                 if Assigned(g_HookClientUserMessage.Items[I]) then
                   if not _TOBJECTCLIENTMSG(g_CheckClientDropItem.Items[I])(PlayObject,DefMsg,Buff) then exit;
             end;
           Except
             MainOutMessage('[Exception] TPlayObject.ClientDropItem->HookApi');
           end;}
          PlayObject.SendMsg(PlayObject,
            DefMsg.Ident,
            DefMsg.Series,
            DefMsg.Recog,
            DefMsg.Param,
            DefMsg.Tag,
            sMsg);
        end;
      end;
      if PlayObject.m_boReadyRun then
      begin
        case DefMsg.Ident of
          CM_TURN, CM_WALK, CM_SITDOWN, CM_RUN, CM_HIT, CM_HEAVYHIT, CM_BIGHIT,
            CM_POWERHIT, CM_LONGHIT,
            CM_LONGSWORD1,
            CM_LONGSWORD2,
            CM_LONGFIRESWORD,
            CM_WIDEHIT, CM_FIREHIT, CM_CRSHIT, CM_TWINHIT:
            begin
              Dec(PlayObject.m_dwRunTick, 100);
            end;
        end;
      end;
    except
      MainOutMessage(sExceptionMsg);
    end;
  except
    MainOutMessage('[Exception] TUserEngine.ProcessUserMessage');
  end;
end;
//004AF728

procedure TUserEngine.SendServerGroupMsg(nCode, nServerIdx: Integer;
  sMsg: string);
begin
  try
    if nServerIndex = 0 then
    begin
      FrmSrvMsg.SendSocketMsg(IntToStr(nCode) + '/' +
        EncodeString(IntToStr(nServerIdx)) + '/' + EncodeString(sMsg));
    end
    else
    begin
      FrmMsgClient.SendSocket(IntToStr(nCode) + '/' +
        EncodeString(IntToStr(nServerIdx)) + '/' + EncodeString(sMsg));
    end;
  except
    MainOutMessage('[Exception] TUserEngine.SendServerGroupMsg');
  end;
end;

function TUserEngine.AddBaseObject(sMapName: string; nX, nY: Integer; nMonRace:
  Integer; sMonName: string; Master: TBaseObject = nil; boClone: Boolean =
  False):
  TBaseObject; //004AD56C
var
  Map: TEnvirnoment;
  Cert: TBaseObject;
  n1C, n20, n24: Integer;
  p28: Pointer;
begin
  try
    try
      Result := nil;
      Cert := nil;

      Map := g_MapManager.FindMap(sMapName);
      if Map = nil then
        exit;
      case nMonRace of
        SUPREGUARD: Cert := TSuperGuard.Create;
        PETSUPREGUARD: Cert := TPetSuperGuard.Create;
        ARCHER_POLICE: Cert := TArcherPolice.Create;
        ANIMAL_CHICKEN:
          begin
            Cert := TMonster.Create;
            Cert.m_boAnimal := True;
            Cert.m_nMeatQuality := Random(3500) + 3000;
            Cert.m_nBodyLeathery := 50;
          end;
        ANIMAL_DEER:
          begin
            if Random(30) = 0 then
            begin
              Cert := TChickenDeer.Create;
              Cert.m_boAnimal := True;
              Cert.m_nMeatQuality := Random(20000) + 10000;
              Cert.m_nBodyLeathery := 150;
            end
            else
            begin
              Cert := TMonster.Create;
              Cert.m_boAnimal := True;
              Cert.m_nMeatQuality := Random(8000) + 8000;
              Cert.m_nBodyLeathery := 150;
            end;
          end;
        ANIMAL_WOLF:
          begin
            Cert := TATMonster.Create;
            Cert.m_boAnimal := True;
            Cert.m_nMeatQuality := Random(8000) + 8000;
            Cert.m_nBodyLeathery := 150;
          end;
        TRAINER: Cert := TTrainer.Create;
        MONSTER_CLONE: Cert := TPlayCloneObject.Create;

        MONSTER_OMA: Cert := TMonster.Create;
        MONSTER_OMAKNIGHT: Cert := TATMonster.Create;
        MONSTER_SPITSPIDER: Cert := TSpitSpider.Create;
        83: Cert := TSlowATMonster.Create;
        84: Cert := TScorpion.Create;
        MONSTER_STICK: Cert := TStickMonster.Create;
        86: Cert := TATMonster.Create;
        MONSTER_DUALAXE: Cert := TDualAxeMonster.Create;
        88: Cert := TATMonster.Create;
        89: Cert := TATMonster.Create;
        90: Cert := TGasAttackMonster.Create;
        91: Cert := TMagCowMonster.Create;
        92: Cert := TCowKingMonster.Create;
        MONSTER_THONEDARK: Cert := TThornDarkMonster.Create;
        MONSTER_LIGHTZOMBI: Cert := TLightingZombi.Create;
        MONSTER_DIGOUTZOMBI:
          begin
            Cert := TDigOutZombi.Create;
            if Random(2) = 0 then
              Cert.bo2BA2 := True;
          end;
        MONSTER_ZILKINZOMBI:
          begin
            Cert := TZilKinZombi.Create;
            if Random(4) = 0 then
              Cert.bo2BA2 := True;
          end;
        97:
          begin
            Cert := TCowMonster.Create;
            if Random(2) = 0 then
              Cert.bo2BA2 := True;
          end;

        MONSTER_WHITESKELETON: Cert := TWhiteSkeleton.Create;
        MONSTER_SCULTURE:
          begin
            Cert := TScultureMonster.Create;
            Cert.bo2BA2 := True;
          end;
        MONSTER_SCULTUREKING: Cert := TScultureKingMonster.Create;
        MONSTER_BEEQUEEN: Cert := TBeeQueen.Create;
        104: Cert := TArcherMonster.Create;
        105: Cert := TGasMothMonster.Create; //楔蛾
        106: Cert := TGasDungMonster.Create;
        107: Cert := TCentipedeKingMonster.Create;
        MONSTER_MOONFAIRY: Cert := TPsycheMonster.Create; //月灵
        110: Cert := TCastleDoor.Create;
        111: Cert := TWallStructure.Create;
        MONSTER_ARCHERGUARD: Cert := TArcherGuard.Create;
        MONSTER_ELFMONSTER: Cert := TElfMonster.Create;
        MONSTER_ELFWARRIOR: Cert := TElfWarriorMonster.Create;
        115: Cert := TBigHeartMonster.Create;
        116: Cert := TSpiderHouseMonster.Create;
        117: Cert := TExplosionSpider.Create;
        118: Cert := THighRiskSpider.Create;
        119: Cert := TBigPoisionSpider.Create;
        120: Cert := TSoccerBall.Create;
        130: Cert := TDoubleCriticalMonster.Create;
        131: Cert := TRonObject.Create;
        132: Cert := TSandMobObject.Create;
        133: Cert := TMagicMonObject.Create;
        134: Cert := TBoneKingMonster.Create;
        MONSTER_135: Cert := TEvilGuardUnit.Create;
        136: Cert := TEvilMonUnit.Create;

        RC_153: Cert := TMissionMonUnit.Create();

        200: Cert := TElectronicScolpionMon.Create;

        201: Cert := TClone.Create;
        203: Cert := TTeleMonster.Create;
        206: Cert := TKhazard.Create;
        208: Cert := TGreenMonster.Create;
        209: Cert := TRedMonster.Create;
        210: Cert := TFrostTiger.Create;
        214: Cert := TFireMonster.Create;
        215: Cert := TFireBallMonster.Create;
      end;

      if Cert <> nil then
      begin
        MonInitialize(Cert, sMonName);
        Cert.m_Master2 := Master;
        Cert.m_PEnvir := Map;
        Cert.m_sMapName := sMapName;
        Cert.m_nCurrX := nX;
        Cert.m_nCurrY := nY;
        Cert.m_btDirection := Random(8);
        Cert.m_sCharName := sMonName;
        Cert.m_WAbil := Cert.m_Abil;
        if Random(100) < Cert.m_btCoolEye then
          Cert.m_boCoolEye := True;
        MonGetRandomItems(Cert); //取得怪物爆物品内容
        if nMonRace = MONSTER_CLONE then
          TPlayCloneObject(Cert).LoadUserData(boClone);
        Cert.Initialize(); //004ADC97 $0FFFE
        if Cert.m_boAddtoMapSuccess then
        begin
          p28 := nil;
          if Cert.m_PEnvir.Header.wWidth < 50 then
            n20 := 2
          else
            n20 := 3;
          if (Cert.m_PEnvir.Header.wHeight < 250) then
          begin
            if (Cert.m_PEnvir.Header.wHeight < 30) then
              n24 := 2
            else
              n24 := 20;
          end
          else
            n24 := 50;

          n1C := 0;
          while (True) do
          begin
            if not Cert.m_PEnvir.CanWalk(Cert.m_nCurrX, Cert.m_nCurrY, False)
              then
            begin
              if (Cert.m_PEnvir.Header.wWidth - n24 - 1) > Cert.m_nCurrX then
              begin
                Inc(Cert.m_nCurrX, n20);
              end
              else
              begin //004ADD9D
                Cert.m_nCurrX := Random(Cert.m_PEnvir.Header.wWidth div 2) +
                  n24;
                if Cert.m_PEnvir.Header.wHeight - n24 - 1 > Cert.m_nCurrY then
                begin
                  Inc(Cert.m_nCurrY, n20);
                end
                else
                begin //004ADDBE
                  Cert.m_nCurrY := Random(Cert.m_PEnvir.Header.wHeight div 2) +
                    n24;
                end;
              end;
            end
            else
            begin //004ADDC0
              p28 := Cert.m_PEnvir.AddToMap(Cert.m_nCurrX, Cert.m_nCurrY,
                OS_MOVINGOBJECT, Cert);
              break;
            end;
            Inc(n1C);
            if n1C >= 31 then
              break;
          end;

          if p28 = nil then
          begin
            //        Map.DelObjectCount2(Cert);
            Cert.Free;
            Cert := nil;
          end;
        end;
      end;
      Result := Cert;
    except
      MainOutMessage('[Exception] TuserEngine.AddBaseObject');
    end;
  except
    MainOutMessage('[Exception] TUserEngine.AddBaseObject');
  end;
end;
//====================================================
//功能:创建怪物对象
//返回值：在指定时间内创建完对象，则返加TRUE，如果超过指定时间则返回FALSE
//====================================================

function TUserEngine.RegenMonsters(MonGen: pTMonGenInfo; nCount: integer):
  Boolean; //004ADF04
var
  dwStartTick: LongWord;

  nX: Integer;
  nY: Integer;
  i: Integer;
  Cert: TBaseObject;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::RegenMonsters';
begin
  try
    Result := True;
    dwStartTick := GetTickCount();
    try
      if MonGen.nRace > 0 then
      begin
        if Random(100) < MonGen.nMissionGenRate then
        begin
          nX := (MonGen.nX - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
          nY := (MonGen.nY - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
          for i := 0 to nCount - 1 do
          begin
            Cert := AddBaseObject(MonGen.sMapName, ((nX - 10) + Random(20)), ((nY
              - 10) + Random(20)), MonGen.nRace, MonGen.sMonName);
            if Cert <> nil then
            begin
              Move(MonGen.nIconIdx, Cert.m_nIconIdx, SizeOf(Cert.m_nIconIdx));
              Cert.m_btChangeNameColor := MonGen.nColor;
              MonGen.CertList.Add(Cert);
            end;
            if (GetTickCount - dwStartTick) > g_dwZenLimit then
            begin
              Result := False;
              Break;
            end;
          end; //4AE058
        end
        else
        begin //004AE063
          for i := 0 to nCount - 1 do
          begin
            nX := (MonGen.nX - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
            nY := (MonGen.nY - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
            Cert := AddBaseObject(MonGen.sMapName, nX, nY, MonGen.nRace,
              MonGen.sMonName);
            if Cert <> nil then
            begin
              Move(MonGen.nIconIdx, Cert.m_nIconIdx, SizeOf(Cert.m_nIconIdx));
              Cert.m_btChangeNameColor := MonGen.nColor;
              MonGen.CertList.Add(Cert);
            end;
            if (GetTickCount - dwStartTick) > g_dwZenLimit then
            begin
              Result := False;
              break;
            end;
          end;
        end;
      end;
    except
      MainOutMessage(sExceptionMsg);
    end;
  except
    MainOutMessage('[Exception] TUserEngine.RegenMonsters');
  end;
end;
{procedure TUserEngine.WriteShiftUserData();
//004AF510
begin
Try

Except
  MainOutMessage('[Exception] TUserEngine.WriteShiftUserData');
End;
end;  }

function TUserEngine.GetPlayObject(sName: string; boHero: Boolean = False):
  TPlayObject; //004AE640
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  try
    try
      Result := nil;
      if boHero then
      begin
        for i := 0 to m_HeroObjectList.Count - 1 do
        begin
          if CompareText(m_HeroObjectList.Strings[i], sName) = 0 then
          begin
            PlayObject := TPlayObject(m_HeroObjectList.Objects[i]);
            if not PlayObject.m_boGhost then
            begin
              if not (PlayObject.m_boPasswordLocked and PlayObject.m_boObMode
                and
                PlayObject.m_boAdminMode) then
                Result := PlayObject;
            end;
            Break;
          end;
        end;
      end
      else
      begin
        for i := 0 to m_PlayObjectList.Count - 1 do
        begin
          if CompareText(m_PlayObjectList.Strings[i], sName) = 0 then
          begin
            PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
            if not PlayObject.m_boGhost then
            begin
              if not (PlayObject.m_boPasswordLocked and PlayObject.m_boObMode
                and
                PlayObject.m_boAdminMode) then
                Result := PlayObject;
            end;
            Break;
          end;
        end;
      end;
    except
      MainOutMessage('[Exception] TUserEngine.GetPlayObject');
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetPlayObject');
  end;
end;

procedure TUserEngine.KickPlayObjectEx(sName: string);
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    try
      for i := 0 to m_PlayObjectList.Count - 1 do
      begin
        if CompareText(m_PlayObjectList.Strings[i], sName) = 0 then
        begin
          PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
          PlayObject.m_boEmergencyClose := True;
          Break;
        end;
      end;
    finally
      LeaveCriticalSection(ProcessHumanCriticalSection);
    end;
  except
    MainOutMessage('[Exception] TUserEngine.KickPlayObjectEx');
  end;
end;

function TUserEngine.GetPlayObjectEx(sName: string): TPlayObject; //004AE640
var
  I: Integer;
begin
  try
    Result := nil;
    EnterCriticalSection(ProcessHumanCriticalSection);
    try
      for I := 0 to m_PlayObjectList.Count - 1 do
      begin
        if CompareText(m_PlayObjectList.Strings[I], sName) = 0 then
        begin
          Result := TPlayObject(m_PlayObjectList.Objects[I]);
          Break;
        end;
      end;
    finally
      LeaveCriticalSection(ProcessHumanCriticalSection);
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetPlayObjectEx');
  end;
end;

function TUserEngine.FindMerchant(Merchant: TObject): TMerchant; //004AC858
var
  I: Integer;
begin
  try
    Result := nil;
    m_MerchantList.Lock;
    try
      for I := 0 to m_MerchantList.Count - 1 do
      begin
        if TObject(m_MerchantList.Items[i]) = Merchant then
        begin
          Result := TMerchant(m_MerchantList.Items[i]);
          break;
        end;
      end;
    finally
      m_MerchantList.UnLock;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.FindMerchant');
  end;
end;

function TUserEngine.FindNPC(GuildOfficial: TObject): TGuildOfficial; //004ACB24
var
  I: Integer;
begin
  try
    Result := nil;
    for I := 0 to QuestNPCList.Count - 1 do
    begin
      if TObject(QuestNPCList.Items[i]) = GuildOfficial then
      begin
        Result := TGuildOfficial(QuestNPCList.Items[i]);
        break;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.FindNPC');
  end;
end;

//4AE810

function TUserEngine.GetMapOfRangeHumanCount(Envir: TEnvirnoment; nX, nY,
  nRange: integer): Integer;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    Result := 0;
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
      if not PlayObject.m_boGhost and (PlayObject.m_PEnvir = Envir) then
      begin
        if (abs(PlayObject.m_nCurrX - nX) < nRange) and (abs(PlayObject.m_nCurrY
          - nY) < nRange) then
          Inc(Result);
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetMapOfRangeHumanCount');
  end;
end;

function TUserEngine.GetHumPermission(sUserName: string; var sIPaddr: string; var
  btPermission: Byte): Boolean; //4AE590
var
  I: Integer;
  AdminInfo: pTAdminInfo;
begin
  try
    Result := False;
    btPermission := g_Config.nStartPermission;
    m_AdminList.Lock;
    try
      for I := 0 to m_AdminList.Count - 1 do
      begin
        AdminInfo := m_AdminList.Items[I];
        if CompareText(AdminInfo.sChrName, sUserName) = 0 then
        begin
          btPermission := AdminInfo.nLv;
          sIPaddr := AdminInfo.sIPaddr;
          Result := True;
          break;
        end;
      end;
    finally
      m_AdminList.UnLock;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetHumPermission');
  end;
end;

{procedure TUserEngine.GenShiftUserData;
//004AEF6C
begin
Try

Except
  MainOutMessage('[Exception] TUserEngine.GenShiftUserData');
End;
end;    }

//004AE3FC

procedure TUserEngine.AddUserOpenInfo(UserOpenInfo: pTUserOpenInfo);
begin
  try
    EnterCriticalSection(m_LoadPlaySection);
    try
      m_LoadPlayList.AddObject(UserOpenInfo.sChrName, Tobject(UserOpenInfo));
    finally
      LeaveCriticalSection(m_LoadPlaySection);
    end;
  except
    MainOutMessage('[Exception] TUserEngine.AddUserOpenInfo');
  end;
end;

procedure TUserEngine.KickAllOnLine();
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      PlayObject.m_boKickFlag := True;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.KickAllOnLine');
  end;
end;

function TUserEngine.KickOnlineName(sChrName: string; boIn: Boolean): Integer;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := 0;
  try
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if boIn then
      begin
        if AnsiContainsText(PlayObject.m_sCharName, sChrName) then
        begin
          PlayObject.m_boEmergencyClose := True;
          Inc(Result);
        end;
      end
      else
      begin
        if CompareText(PlayObject.m_sCharName, sChrName) = 0 then
        begin
          PlayObject.m_boEmergencyClose := True;
          Inc(Result);
          break;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.KickOnlineUser');
  end;
end;

function TUserEngine.KickOnlineLevel(MinLevel, MaxLevel: Integer; boOffLine:
  Boolean): Integer;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := 0;
  try
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if boOffLine then
      begin
        if (PlayObject.m_Abil.Level >= MinLevel) and (PlayObject.m_Abil.Level <=
          MaxLevel) and PlayObject.m_boSafeOffLine then
        begin
          PlayObject.m_boEmergencyClose := True;
          Inc(Result);
        end;
      end
      else if (PlayObject.m_Abil.Level >= MinLevel) and (PlayObject.m_Abil.Level
        <= MaxLevel) then
      begin
        PlayObject.m_boEmergencyClose := True;
        Inc(Result);
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.KickOnlineUser');
  end;
end;

//004AEB80

procedure TUserEngine.KickOnlineUser(sChrName: string);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if CompareText(PlayObject.m_sCharName, sChrName) = 0 then
      begin
        PlayObject.m_boKickFlag := True;
        break;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.KickOnlineUser');
  end;
end;
//004AF85C

function TUserEngine.SendSwitchData(PlayObject: TPlayObject; nServerIndex:
  Integer): Boolean;
begin
  try
    Result := True;
  except
    MainOutMessage('[Exception] TUserEngine.SendSwitchData');
  end;
end;
//004AF988

procedure TUserEngine.SendChangeServer(PlayObject: TPlayObject; nServerIndex:
  Integer);
var
  sIPaddr: string;
  nPort: Integer;
resourcestring
  sMsg = '%s/%d';
begin
  try
    if GetMultiServerAddrPort(nServerIndex, sIPaddr, nPort) then
    begin
      PlayObject.SendDefMessage(SM_RECONNECT, 0, 0, 0, 0, format(sMsg, [sIPaddr,
        nPort]));
    end;
  except
    MainOutMessage('[Exception] TUserEngine.SendChangeServer');
  end;
end;

procedure TUserEngine.SaveHumanRcd(PlayObject: TPlayObject); //004AE488
var
  SaveRcd: pTSaveRcd;
begin
  try
    New(SaveRcd);
    FillChar(SaveRcd^, SizeOf(TSaveRcd), #0);
    SaveRcd.sAccount := PlayObject.m_sUserID;
    SaveRcd.sChrName := PlayObject.m_sCharName;
    SaveRcd.nSessionID := PlayObject.m_nSessionID;
    SaveRcd.PlayObject := PlayObject;
    PlayObject.MakeSaveRcd(SaveRcd.HumanRcd);
    FrontEngine.AddToSaveRcdList(SaveRcd);
  except
    MainOutMessage('[Exception] TUserEngine.SaveHumanRcd');
  end;
end;

procedure TUserEngine.AddToHumanFreeList(PlayObject: TPlayObject); //004AE45C
begin
  try
    PlayObject.m_dwGhostTick := GetTickCount();
    m_PlayObjectFreeList.Add(PlayObject);
  except
    MainOutMessage('[Exception] TUserEngine.AddToHumanFreeList');
  end;
end;
//004AEE98
{function TUserEngine.GetSwitchData(sChrName: String; nCode: Integer): pTSwitchDataInfo;
var
  i:integer;
  SwitchData:pTSwitchDataInfo;
begin
Try
  Result:=nil;
  for I := 0 to m_ChangeServerList.Count - 1 do begin
    SwitchData:=m_ChangeServerList.Items[i];
    if (CompareText(SwitchData.sChrName,sChrName) = 0) and (SwitchData.nCode = nCode) then begin
      Result:=SwitchData;
      break;
    end;
  end;
Except
  MainOutMessage('[Exception] TUserEngine.GetSwitchData');
End;
end;  }

procedure TUserEngine.GetHumData(PlayObject: TPlayObject;
  var HumanRcd: THumDataInfo); //004B3050
var
  HumData: pTHumData;
  HumItems: pTHumItems;
  BagItems: pTBagItems;
  UserItem: PTUserItem;
  HumMagic: pTHumMagic;
  UserMagic: pTUserMagic;
  MagicInfo: pTMagic;
  StdItem: TItem;
  StorageItems: pTStorageItems;
  I: integer;
begin
  try
    HumData := @HumanRcd.Data;

    PlayObject.m_HeroName := HumData.sHeroName; //英雄名称
    PlayObject.m_boHero := HumData.boHero; //是否英雄

    PlayObject.m_sCharName := HumData.sChrName;
    PlayObject.m_sMapName := HumData.sCurMap;
    PlayObject.m_nCurrX := HumData.wCurX;
    PlayObject.m_nCurrY := HumData.wCurY;
    PlayObject.m_btDirection := HumData.btDir;
    PlayObject.m_btHair := _MIN(1, HumData.btHair);
    PlayObject.m_btGender := HumData.btSex;
    PlayObject.m_btJob := HumData.btJob;
    PlayObject.m_nGold := HumData.nGold;

    if PlayObject.m_btJob > 2 then
      PlayObject.m_btJob := 0;
    if PlayObject.m_btGender > 1 then
      PlayObject.m_btGender := 0;

    PlayObject.m_Abil.Level := HumData.Abil.Level;
    PlayObject.m_Abil.HP := HumData.Abil.HP;
    PlayObject.m_Abil.MP := HumData.Abil.MP;
    PlayObject.m_Abil.MaxHP := HumData.Abil.MaxHP;
    PlayObject.m_Abil.MaxMP := HumData.Abil.MaxMP;
    PlayObject.m_Abil.Exp := HumData.Abil.Exp;
    PlayObject.m_Abil.MaxExp := HumData.Abil.MaxExp;
    PlayObject.m_Abil.Weight := HumData.Abil.Weight;
    PlayObject.m_Abil.MaxWeight := HumData.Abil.MaxWeight;
    PlayObject.m_Abil.WearWeight := HumData.Abil.WearWeight;
    PlayObject.m_Abil.MaxWearWeight := HumData.Abil.MaxWearWeight;
    PlayObject.m_Abil.HandWeight := HumData.Abil.HandWeight;
    PlayObject.m_Abil.MaxHandWeight := HumData.Abil.MaxHandWeight;

    //PlayObject.m_Abil:=HumData.Abil;

    PlayObject.m_wStatusTimeArr := HumData.wStatusTimeArr;
    PlayObject.m_sHomeMap := HumData.sHomeMap;
    PlayObject.m_nHomeX := HumData.wHomeX;
    PlayObject.m_nHomeY := HumData.wHomeY;

    PlayObject.m_sDieMap := HumData.sDieMap;
    PlayObject.m_nDieX := HumData.wDieX;
    PlayObject.m_nDieY := HumData.wDieY;

    PlayObject.m_nKillMonCount := HumData.nKillMonCount;

    PlayObject.m_BonusAbil := HumData.BonusAbil; // 08/09
    PlayObject.m_nBonusPoint := HumData.nBonusPoint; // 08/09
    PlayObject.m_btCreditPoint := HumData.btCreditPoint;
    PlayObject.m_btReLevel := HumData.btReLevel;

    PlayObject.m_sMasterName := HumData.sMasterName;
    PlayObject.m_boMaster := HumData.boMaster;
    PlayObject.m_sDearName := HumData.sDearName;
    PlayObject.m_nMasterCount := HumData.btMasterCount;

    PlayObject.m_sStoragePwd := HumData.sStoragePwd;
    if PlayObject.m_sStoragePwd <> '' then
      PlayObject.m_boPasswordLocked := True;

    PlayObject.m_nGameGold := HumData.nGameGold;
    PlayObject.m_nGamePoint := HumData.nGamePoint;
    PlayObject.m_nGameDiamond := HumData.nGameDiamond;
    PlayObject.m_nGameGird := HumData.nGameGird;
    PlayObject.m_nPayMentPoint := HumData.nPayMentPoint;
    PlayObject.m_nGloryPoint := HumData.nGloryPoint;

    PlayObject.m_HeroName1 := HumData.HeroName1;
    PlayObject.m_HeroLevel1 := HumData.HeroLevel1;
    PlayObject.m_HeroJob1 := HumData.HeroJob1;
    PlayObject.m_HeroGender1 := HumData.HeroGender1;
    PlayObject.m_HeroName2 := HumData.HeroName2;
    PlayObject.m_HeroLevel2 := HumData.HeroLevel2;
    PlayObject.m_HeroJob2 := HumData.HeroJob2;
    PlayObject.m_HeroGender2 := HumData.HeroGender2;
    PlayObject.m_HeroClass := HumData.HeroClass;

    PlayObject.m_nPkPoint := HumData.nPkPoint;
    if HumData.btAllowGroup > 0 then
      PlayObject.m_boAllowGroup := True
    else
      PlayObject.m_boAllowGroup := False;
    PlayObject.btB22 := HumData.btF9;
    PlayObject.m_btAttatckMode := HumData.btAttatckMode;
    PlayObject.m_nIncHealth := HumData.btIncHealth;
    PlayObject.m_nIncSpell := HumData.btIncSpell;
    PlayObject.m_nIncHealing := HumData.btIncHealing;
    PlayObject.m_nFightZoneDieCount := HumData.btFightZoneDieCount;
    PlayObject.m_sUserID := HumData.sAccount;
    //PlayObject.nC4                  := HumData.btEE;
    PlayObject.m_boLockLogon := HumData.boLockLogon;

    PlayObject.m_wContribution := HumData.wContribution;
    //PlayObject.btC8                 := HumData.btEF;
    PlayObject.m_nHungerStatus := HumData.nHungerStatus;
    PlayObject.m_boAllowGuildReCall := HumData.boAllowGuildReCall;
    PlayObject.m_wGroupRcallTime := HumData.wGroupRcallTime;
    PlayObject.m_dBodyLuck := HumData.dBodyLuck;
    PlayObject.m_boAllowGroupReCall := HumData.boAllowGroupReCall;
    //PlayObject.m_QuestUnitOpen      := HumData.QuestOpen;
    //PlayObject.m_QuestUnit          := HumData.QuestUnit;
    PlayObject.m_QuestFlag := HumData.QuestFlag;

    for i := Low(PlayObject.m_nIconIdx) to High(PlayObject.m_nIconIdx) do
      PlayObject.m_nIconIdx[i] := HumData.nIconIdx[i];

    PlayObject.m_btDiploidRate := HumData.nDiploidRate;

    HumItems := @HumanRcd.Data.HumItems;
    for I := Low(THumItems) to high(THumItems) do
    begin
      PlayObject.m_UseItems[I] := HumItems^[I];
    end;
    { PlayObject.m_UseItems[U_DRESS]     := HumItems[U_DRESS];
     PlayObject.m_UseItems[U_WEAPON]    := HumItems[U_WEAPON];
     PlayObject.m_UseItems[U_RIGHTHAND] := HumItems[U_RIGHTHAND];
     PlayObject.m_UseItems[U_NECKLACE]  := HumItems[U_HELMET];
     PlayObject.m_UseItems[U_HELMET]    := HumItems[U_NECKLACE];
     PlayObject.m_UseItems[U_ARMRINGL]  := HumItems[U_ARMRINGL];
     PlayObject.m_UseItems[U_ARMRINGR]  := HumItems[U_ARMRINGR];
     PlayObject.m_UseItems[U_RINGL]     := HumItems[U_RINGL];
     PlayObject.m_UseItems[U_RINGR]     := HumItems[U_RINGR];
     PlayObject.m_UseItems[U_BUJUK]     := HumItems[U_BUJUK];
     PlayObject.m_UseItems[U_BELT]      := HumItems[U_BELT];
     PlayObject.m_UseItems[U_BOOTS]     := HumItems[U_BOOTS];
     PlayObject.m_UseItems[U_CHARM]     := HumItems[U_CHARM];
     PlayObject.m_UseItems[U_STRAW]     := HumItems[U_STRAW]; }
    if g_Config.boOfflineSaveExp then
    begin
      PlayObject.m_nKillMonExpRate := HumanRcd.Data.nMentExp;
      PlayObject.m_dwKillMonExpRateTime := HumanRcd.Data.nMentExpTime;
      if PlayObject.m_nKillMonExpRate < 100 then
        PlayObject.m_nKillMonExpRate := 100;
    end;

    BagItems := @HumanRcd.Data.BagItems;
    for I := Low(TBagItems) to high(TBagItems) do
    begin
      if BagItems[i].wIndex > 0 then
      begin
        New(UserItem);
        UserItem^ := BagItems[i];
        PlayObject.m_ItemList.Add(UserItem);
      end;
    end;
    HumMagic := @HumanRcd.Data.Magic;
    for I := Low(THumMagic) to high(THumMagic) do
    begin
      MagicInfo := UserEngine.FindMagic(HumMagic[i].wMagIdx, HumData.boHero);
      if MagicInfo <> nil then
      begin
        New(UserMagic);
        UserMagic.MagicInfo := MagicInfo;
        UserMagic.wMagIdx := HumMagic[i].wMagIdx;
        UserMagic.btLevel := HumMagic[i].btLevel;
        UserMagic.btKey := HumMagic[i].btKey;
        UserMagic.nTranPoint := HumMagic[i].nTranPoint;
        PlayObject.m_MagicList.Add(UserMagic);
      end;
    end;

    HumMagic := @HumanRcd.Data.Magic1;//技能列表2
    for I := Low(THumMagic) to high(THumMagic) do
    begin
      MagicInfo := UserEngine.FindMagic(HumMagic[i].wMagIdx, HumData.boHero);
      if MagicInfo <> nil then
      begin
        New(UserMagic);
        UserMagic.MagicInfo := MagicInfo;
        UserMagic.wMagIdx := HumMagic[i].wMagIdx;
        UserMagic.btLevel := HumMagic[i].btLevel;
        UserMagic.btKey := HumMagic[i].btKey;
        UserMagic.nTranPoint := HumMagic[i].nTranPoint;
        PlayObject.m_MagicList.Add(UserMagic);
      end;
    end;

 //酒馆数据
    PlayObject.m_WineRec.WineValue := HumData.dwWineValue;
    PlayObject.m_WineRec.Alcoho := HumData.dwAlcoho;

    PlayObject.m_MedicineRec.MedicineValue := HumData.dwMedicineValue;
    PlayObject.m_MedicineRec.MedicineLevel := HumData.dwMedicineLevel;

    PlayObject.m_SKILL84Rec.SKILL84Level := HumData.dwSKILL84Level;
    PlayObject.m_SKILL84Rec.SKILL84Exp := HumData.dwSKILL84Exp;

    PlayObject.m_boISONMAKEWINE := HumData.boISONMAKEWINE;
    PlayObject.m_dtGetGuildFountain := HumData.dtGetGuildFountain;
    PlayObject.m_dtGetCastleFountain := HumData.dtGetCastleFountain;
    PlayObject.m_dtMakeWineTime := HumData.dtMakeWineTime;
    PlayObject.m_WineItem := HumData.WineItem;
    PlayObject.m_dtAlcohoTime := HumData.dtAlcohoTime;//饮普通酒时间
    PlayObject.m_dtMedicineAlcohoTime := HumData.dtMedicineAlcohoTime;//饮药酒时间
    PlayObject.m_bLiquorProgress := HumData.bLiquorProgress;//酒量提升进度值
 //   PlayObject.m_skill83Level:=HumData.skill83Level;//先天元力等级
    PlayObject.m_CallCloneTick := HumData.CallCloneTick;//分身
    PlayObject.m_dwOpenShieldTick := HumData.dwOpenShieldTick;//护体神
    
    StorageItems := @HumanRcd.Data.StorageItems;
    for I := Low(TStorageItems) to high(TStorageItems) do
    begin
      if StorageItems[I].wIndex > 0 then
      begin
        New(UserItem);
        UserItem^ := StorageItems[I];
        PlayObject.m_StorageItemList.Add(UserItem);
      end;
    end;
    if not PlayObject.m_boHero then
    begin
      LoadStorageItems(PlayObject.m_StorageItemList, PlayObject.m_sCharName);
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetHumData');
  end;
end;
//004B1E50

function TUserEngine.GetHomeInfo(nJob: Integer; var nX, nY: Integer): string;
var
  I: Integer;
  Point: pTStartPoint;
begin
  try
    if g_Config.boJobHomePoint then
    begin
      case nJob of
        jWarr:
          begin
            Result := g_Config.sWarriorHomeMap;
            nX := g_Config.nWarriorHomeX;
            nY := g_Config.nWarriorHomeY;
          end;
        jWizard:
          begin
            Result := g_Config.sWizardHomeMap;
            nX := g_Config.nWizardHomeX;
            nY := g_Config.nWizardHomeY;
          end;
        jTaos:
          begin
            Result := g_Config.sTaoistHomeMap;
            nX := g_Config.nTaoistHomeX;
            nY := g_Config.nTaoistHomeY;
          end;
      else
        begin
          Result := g_Config.sHomeMap;
          nX := g_Config.nHomeX;
          nY := g_Config.nHomeY;
        end;
      end;
    end
    else
    begin
      g_StartPoint.Lock;
      try
        if g_StartPoint.Count > 0 then
        begin
          if g_StartPoint.Count > 1 then
            I := Random(g_Config.nStartPointSize {2})
          else
            I := 0;
          Point := g_StartPoint.Items[I];
          Result := Point.sMapName;
          nX := Point.nX;
          nY := Point.nY;
        end
        else
        begin
          Result := g_Config.sHomeMap;
          nX := g_Config.nHomeX;
          nX := g_Config.nHomeY;
        end;
      finally
        g_StartPoint.UnLock;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetHomeInfo');
  end;
end;
//004DA6DC

function TUserEngine.GetRandHomeX(PlayObject: TPlayObject): Integer;
begin
  try
    Result := Random(3) + (PlayObject.m_nHomeX - 2);
  except
    MainOutMessage('[Exception] TUserEngine.GetRandHomeX');
  end;
end;
//004DA708

function TUserEngine.GetRandHomeY(PlayObject: TPlayObject): Integer;
begin
  try
    Result := Random(3) + (PlayObject.m_nHomeY - 2);
  except
    MainOutMessage('[Exception] TUserEngine.GetRandHomeY');
  end;
end;
//004AF2DC

procedure TUserEngine.LoadSwitchData(SwitchData: pTSwitchDataInfo; var
  PlayObject: TPlayObject);
var
  nCount: Integer;
  SlaveInfo: pTSlaveInfo;
begin
  try
    try
      if SwitchData.boC70 then
      begin

      end;

      PlayObject.m_boBanShout := SwitchData.boBanShout;
      PlayObject.m_boHearWhisper := SwitchData.boHearWhisper;
      PlayObject.m_boBanGuildChat := SwitchData.boBanGuildChat;
      PlayObject.m_boBanGuildChat := SwitchData.boBanGuildChat;
      PlayObject.m_boAdminMode := SwitchData.boAdminMode;
      PlayObject.m_boObMode := SwitchData.boObMode;

      nCount := 0;
      while (True) do
      begin
        if SwitchData.BlockWhisperArr[nCount] = '' then
          break;
        PlayObject.m_BlockWhisperList.Add(SwitchData.BlockWhisperArr[nCount]);
        Inc(nCount);
        if nCount >= High(SwitchData.BlockWhisperArr) then
          break;
      end;

      nCount := 0;
      while (True) do
      begin //004AF3CA
        if SwitchData.SlaveArr[nCount].sSlaveName = '' then
          break;
        New(SlaveInfo);
        SlaveInfo^ := SwitchData.SlaveArr[nCount];
        PlayObject.SendDelayMsg(PlayObject, RM_10401, 0, Integer(SlaveInfo), 0,
          0, '', 500);
        Inc(nCount);
        if nCount >= 5 then
          break;
      end;

      nCount := 0;
      while (True) do
      begin //004AF3CA
        PlayObject.m_wStatusArrValue[nCount] := SwitchData.StatusValue[nCount];
        PlayObject.m_dwStatusArrTimeOutTick[nCount] :=
          SwitchData.StatusTimeOut[nCount];
        Inc(nCount);
        if nCount >= 6 then
          break;
      end;
    except
      MainOutMessage('[Exception] TUserEngine.LoadSwitchData');
    end;
  except
    MainOutMessage('[Exception] TUserEngine.LoadSwitchData');
  end;
end;
//004AF4A4

procedure TUserEngine.DelSwitchData(SwitchData: pTSwitchDataInfo);
var
  I: Integer;
  SwitchDataInfo: pTSwitchDataInfo;
begin
  try
    for I := 0 to m_ChangeServerList.Count - 1 do
    begin
      SwitchDataInfo := m_ChangeServerList.Items[i];
      if SwitchDataInfo = SwitchData then
      begin
        Dispose(SwitchDataInfo);
        m_ChangeServerList.Delete(I);
        break;
      end;
    end; // for
  except
    MainOutMessage('[Exception] TUserEngine.DelSwitchData');
  end;
end;

//004AE398

function TUserEngine.FindMagic(nMagIdx: Integer; boHero: Boolean): pTMagic;
var
  I: Integer;
  Magic: pTMagic;
begin
  try
    Result := nil;
    if boHero then
    begin
      for I := 0 to m_MagicList2.Count - 1 do
      begin
        Magic := m_MagicList2.Items[i];
        if (Magic.sDescr = '英雄') and (Magic.wMagicId = nMagIdx) then
        begin
          Result := Magic;
          break;
        end;
      end;
    end
    else
    begin
      for I := 0 to m_MagicList2.Count - 1 do
      begin
        Magic := m_MagicList2.Items[i];
        if (Magic.sDescr <> '英雄') and (Magic.wMagicId = nMagIdx) then
        begin
          Result := Magic;
          break;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.FindMagic');
  end;
end;

//004ACE94

procedure TUserEngine.MonInitialize(BaseObject: TBaseObject; sMonName: string);
var
  I: Integer;
  Monster: pTMonInfo;
begin
  try
    try
      for I := 0 to MonsterList.Count - 1 do
      begin
        Monster := MonsterList.Items[i];
        if CompareText(Monster.sName, sMonName) = 0 then
        begin
          BaseObject.m_btRaceServer := Monster.btRace;
          BaseObject.m_btRaceImg := Monster.btRaceImg;
          BaseObject.m_wAppr := Monster.wAppr;
          BaseObject.m_Abil.Level := Monster.wLevel;
          BaseObject.m_btLifeAttrib := Monster.btLifeAttrib;
          BaseObject.m_btCoolEye := Monster.wCoolEye;
          BaseObject.m_dwFightExp := Monster.dwExp;
          BaseObject.m_Abil.HP := Monster.wHP;
          BaseObject.m_Abil.MaxHP := Monster.wHP;
          BaseObject.m_btMonsterWeapon := LoByte(Monster.wMP);
          BaseObject.m_Abil.MP := Monster.wMP;
          //BaseObject.m_Abil.MP:=0;
          BaseObject.m_Abil.MaxMP := Monster.wMP;
          BaseObject.m_Abil.AC := MakeLong(Monster.wAC, Monster.wAC);
          BaseObject.m_Abil.MAC := MakeLong(Monster.wMAC, Monster.wMAC);
          BaseObject.m_Abil.DC := MakeLong(Monster.wDC, Monster.wMaxDC);
          BaseObject.m_Abil.MC := MakeLong(Monster.wMC, Monster.wMC);
          BaseObject.m_Abil.SC := MakeLong(Monster.wSC, Monster.wSC);
          BaseObject.m_btSpeedPoint := Monster.wSpeed;
          BaseObject.m_btHitPoint := Monster.wHitPoint;
          BaseObject.m_nWalkSpeed := Monster.wWalkSpeed;
          BaseObject.m_nWalkStep := Monster.wWalkStep;
          BaseObject.m_dwWalkWait := Monster.wWalkWait;
          BaseObject.m_nNextHitTime := Monster.wAttackSpeed;
          BaseObject.m_boNastyMode := Monster.boAggro;
          BaseObject.m_boNoTame := Monster.boTame;
          break;
        end;
      end;
    except
      MainOutMessage('[Exception] TUserEngine.MonInitialize');
    end;
  except
    MainOutMessage('[Exception] TUserEngine.MonInitialize');
  end;
end;

function TUserEngine.OpenDoor(Envir: TEnvirnoment; nX,
  nY: Integer): Boolean; //004AC698
var
  Door: pTDoorInfo;
begin
  try
    Result := False;
    Door := Envir.GetDoor(nX, nY);
    if (Door <> nil) and not Door.Status.boOpened and not Door.Status.bo01 then
    begin
      Door.Status.boOpened := True;
      Door.Status.dwOpenTick := GetTickCount();
      SendDoorStatus(Envir, nX, nY, RM_DOOROPEN, 0, nX, nY, 0, '');
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.OpenDoor');
  end;
end;

function TUserEngine.CloseDoor(Envir: TEnvirnoment; Door: pTDoorInfo): Boolean;
//004AC77B
begin
  try
    Result := False;
    if (Door <> nil) and (Door.Status.boOpened) then
    begin
      Door.Status.boOpened := False;
      SendDoorStatus(Envir, Door.nX, Door.nY, RM_DOORCLOSE, 0, Door.nX, Door.nY,
        0, '');
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.CloseDoor');
  end;
end;

procedure TUserEngine.SendDoorStatus(Envir: TEnvirnoment; nX, nY: Integer;
  wIdent, wX: Word; nDoorX, nDoorY, nA: Integer; sStr: string); //004AC518
var
  I: Integer;
  n10, n14: Integer;
  n1C, n20, n24, n28: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  try
    n1C := nX - 12;
    n24 := nX + 12;
    n20 := nY - 12;
    n28 := nY + 12;
    for n10 := n1C to n24 do
    begin
      for n14 := n20 to n28 do
      begin
        if Envir.GetMapCellInfo(n10, n14, MapCellInfo) and (MapCellInfo.ObjList
          <> nil) then
        begin
          for I := 0 to MapCellInfo.ObjList.Count - 1 do
          begin
            OSObject := MapCellInfo.ObjList.Items[i];
            if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then
            begin
              BaseObject := TBaseObject(OSObject.CellObj);
              if (BaseObject <> nil) and
                (not BaseObject.m_boGhost) and
                (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then
              begin
                BaseObject.SendMsg(BaseObject, wIdent, wX, nDoorX, nDoorY, nA,
                  sStr);
              end;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.SendDoorStatus');
  end;
end;

procedure TUserEngine.ProcessStatMapManCount();
var
  I: Integer;
  //  II    :Integer;
  Envir: TEnvirnoment;
  //  Door  :pTDoorInfo;
  PlayObject: TPlayObject;
begin
  try
    for I := 0 to g_MapManager.Count - 1 do
    begin
      Envir := TEnvirnoment(g_MapManager.Items[I]);
      if Envir.Flag.boNoManNoMon then
      begin
        Envir.m_boMakeMon := False;
        if g_Config.boNoManClearMon and ((GetTickCount - Envir.m_dwNoManTick) >
          g_Config.dwNoManClearMonTime) then
        begin
          Envir.m_boClearMon := True;
        end;
      end
      else
      begin
        Envir.m_boMakeMon := True;
      end;
    end;
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if (not PlayObject.m_boDeath) and
        (not PlayObject.m_boGhost) and
        (PlayObject.m_PEnvir <> nil) then
      begin
        PlayObject.m_PEnvir.m_boMakeMon := True;
        PlayObject.m_PEnvir.m_boClearMon := False;
        PlayObject.m_PEnvir.m_dwNoManTick := GetTickCount();
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.ProcessStatMapManCount');
  end;
end;

procedure TUserEngine.ProcessMapDoor; //004AC78C
var
  I: Integer;
  II: Integer;
  Envir: TEnvirnoment;
  Door: pTDoorInfo;
begin
  try
    try
      for I := 0 to g_MapManager.Count - 1 do
      begin
        Envir := TEnvirnoment(g_MapManager.Items[I]);
        for II := 0 to Envir.m_DoorList.Count - 1 do
        begin
          Door := Envir.m_DoorList.Items[II];
          if Door.Status.boOpened then
          begin
            if (GetTickCount - Door.Status.dwOpenTick) > 5 * 1000 then
              CloseDoor(Envir, Door);
          end;
        end;
      end;
    except
      MainOutMessage('[Exception] TUserEngine.ProcessMapDoor');
    end;
  except
    MainOutMessage('[Exception] TUserEngine.ProcessMapDoor');
  end;
end;

procedure TUserEngine.ProcessEvents; //004AED70
var
  I, II, III: Integer;
  MagicEvent: pTMagicEvent;
  BaseObject: TBaseObject;
begin
  try
    try
      for I := m_MagicEventList.Count - 1 downto 0 do
      begin
        MagicEvent := m_MagicEventList.Items[I];
        if MagicEvent <> nil then
        begin
          for II := MagicEvent.BaseObjectList.Count - 1 downto 0 do
          begin
            BaseObject := TBaseObject(MagicEvent.BaseObjectList.Items[II]);
            if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (not
              BaseObject.m_boHolySeize) then
            begin
              MagicEvent.BaseObjectList.Delete(II);
            end;
          end;
          if (MagicEvent.BaseObjectList.Count <= 0) or
            ((GetTickCount - MagicEvent.dwStartTick) > MagicEvent.dwTime) or
            ((GetTickCount - MagicEvent.dwStartTick) > 180000) then
          begin
            MagicEvent.BaseObjectList.Free;
            III := 0;
            while (True) do
            begin
              if MagicEvent.Events[III] <> nil then
              begin
                MagicEvent.Events[III].Close();
              end;
              Inc(III);
              if III >= 8 then
                break;
            end;
            Dispose(MagicEvent);
            m_MagicEventList.Delete(I);
          end;
        end;
      end;
    except
      MainOutMessage('[Exception] TUserEngine.ProcessEvents');
    end;
  except
    MainOutMessage('[Exception] TUserEngine.ProcessEvents');
  end;
end;

{procedure TUserEngine.Process4AECFC; //004AECFC
begin
Try

Except
  MainOutMessage('[Exception] TUserEngine.Process4AECFC');
End;
end;  }

function TUserEngine.FindMagic(sMagicName: string; boHero: Boolean): pTMagic;
//004AE2E4
var
  I: Integer;
  Magic: pTMagic;
begin
  try
    Result := nil;
    if boHero then
    begin
      for I := 0 to m_MagicList2.Count - 1 do
      begin
        Magic := m_MagicList2.Items[i];
        if (Magic.sDescr = '英雄') and (CompareText(Magic.sMagicName,
          sMagicName) = 0) then
        begin
          Result := Magic;
          break;
        end;
      end;
    end
    else
    begin
      for I := 0 to m_MagicList2.Count - 1 do
      begin
        Magic := m_MagicList2.Items[i];
        if (Magic.sDescr <> '英雄') and (CompareText(Magic.sMagicName,
          sMagicName) = 0) then
        begin
          Result := Magic;
          break;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.FindMagic');
  end;
end;

function TUserEngine.GetMapRangeMonster(Envir: TEnvirnoment; nX, nY, nRange:
  Integer; List: TList): Integer;
var
  I, II: Integer;
  MonGen: pTMonGenInfo;
  BaseObject: TBaseObject;
begin
  try
    Result := 0;
    if Envir = nil then
      exit;
    for I := 0 to m_MonGenList.Count - 1 do
    begin
      MonGen := m_MonGenList.Items[I];
      if (MonGen = nil) then
        Continue;
      if (MonGen.Envir <> nil) and (MonGen.Envir <> Envir) then
        Continue;

      for II := 0 to MonGen.CertList.Count - 1 do
      begin
        BaseObject := TBaseObject(MonGen.CertList.Items[II]);
        if not BaseObject.m_boDeath and not BaseObject.m_boGhost and
          (BaseObject.m_PEnvir = Envir) and (abs(BaseObject.m_nCurrX - nX) <=
          nRange) and (abs(BaseObject.m_nCurrY - nY) <= nRange) then
        begin
          if List <> nil then
            List.Add(BaseObject);
          Inc(Result);
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetMapRangeMonster');
  end;
end;

procedure TUserEngine.AddMerchant(Merchant: TMerchant);
begin
  try
    UserEngine.m_MerchantList.Lock;
    try
      UserEngine.m_MerchantList.Add(Merchant);
    finally
      UserEngine.m_MerchantList.UnLock;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.AddMerchant');
  end;
end;

function TUserEngine.GetMerchantList(Envir: TEnvirnoment; nX, nY,
  nRange: Integer; TmpList: TList): Integer; //004ACB84
var
  I: Integer;
  Merchant: TMerchant;
begin
  try
    m_MerchantList.Lock;
    try
      for I := 0 to m_MerchantList.Count - 1 do
      begin
        Merchant := TMerchant(m_MerchantList.Items[i]);
        if (Merchant.m_PEnvir = Envir) and
          (abs(Merchant.m_nCurrX - nX) <= nRange) and
          (abs(Merchant.m_nCurrY - nY) <= nRange) then
        begin

          TmpList.Add(Merchant);
        end;
      end; // for
    finally
      m_MerchantList.UnLock;
    end;
    Result := TmpList.Count
  except
    MainOutMessage('[Exception] TUserEngine.GetMerchantList');
  end;
end;

function TUserEngine.GetNpcList(Envir: TEnvirnoment; nX, nY,
  nRange: Integer; TmpList: TList): Integer;
var
  I: Integer;
  Npc: TNormNpc;
begin
  try
    for I := 0 to QuestNPCList.Count - 1 do
    begin
      Npc := TNormNpc(QuestNPCList.Items[i]);
      if (Npc.m_PEnvir = Envir) and
        (abs(Npc.m_nCurrX - nX) <= nRange) and
        (abs(Npc.m_nCurrY - nY) <= nRange) then
      begin

        TmpList.Add(Npc);
      end;
    end; // for
    Result := TmpList.Count
  except
    MainOutMessage('[Exception] TUserEngine.GetNpcList');
  end;
end;

procedure TUserEngine.ReloadMerchantList();
var
  I: Integer;
  Merchant: TMerchant;
begin
  try
    m_MerchantList.Lock;
    try
      for I := 0 to m_MerchantList.Count - 1 do
      begin
        Merchant := TMerchant(m_MerchantList.Items[i]);
        if not Merchant.m_boGhost then
        begin
          Merchant.ClearScript;
          Merchant.LoadNPCScript;
          //Merchant.LoadNPCData;   //Jason 0716
        end;
      end; // for
    finally
      m_MerchantList.UnLock;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.ReloadMerchantList');
  end;
end;

procedure TUserEngine.ReloadNpcList();
var
  I: Integer;
  Npc: TNormNpc;
begin
  try
    for I := 0 to QuestNPCList.Count - 1 do
    begin
      Npc := TNormNpc(QuestNPCList.Items[i]);
      Npc.ClearScript;
      Npc.LoadNPCScript;
      //Npc.LoadNPCData;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.ReloadNpcList');
  end;
end;

function TUserEngine.GetMapMonster(Envir: TEnvirnoment; List: TList): Integer;
//004AE20C
var
  I, II: Integer;
  MonGen: pTMonGenInfo;
  BaseObject: TBaseObject;
begin
  try
    Result := 0;
    if Envir = nil then
      exit;
    for I := 0 to m_MonGenList.Count - 1 do
    begin
      MonGen := m_MonGenList.Items[I];
      if MonGen = nil then
        Continue;
      for II := 0 to MonGen.CertList.Count - 1 do
      begin
        BaseObject := TBaseObject(MonGen.CertList.Items[II]);
        if not BaseObject.m_boDeath and not BaseObject.m_boGhost and
          (BaseObject.m_PEnvir = Envir) and ((BaseObject.m_Master2 = nil) or
          (BaseObject.m_boAutoGhost)) then
        begin
          if List <> nil then
            List.Add(BaseObject);
          Inc(Result);
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetMapMonster');
  end;
end;

procedure TUserEngine.HumanExpire(sAccount: string); //004AFBB0
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    if not g_Config.boKickExpireHuman then
      exit;
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if CompareText(PlayObject.m_sUserID, sAccount) = 0 then
      begin
        PlayObject.m_boExpire := True;
        break;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.HumanExpire');
  end;
end;

function TUserEngine.GetMapHuman(sMapName: string): Integer; //004AE954
var
  I: Integer;
  Envir: TEnvirnoment;
  PlayObject: TPlayObject;
begin
  Result := 0;
  try
    Envir := g_MapManager.FindMap(sMapName);
    if Envir = nil then
      exit;
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if not PlayObject.m_boDeath and not PlayObject.m_boGhost and
        (PlayObject.m_PEnvir = Envir) then
        Inc(Result);
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetMapHuman');
  end;
end;

function TUserEngine.GetMapRageHuman(Envir: TEnvirnoment; nRageX,
  nRageY, nRage: Integer; List: TList): Integer; //004AE8AC
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    Result := 0;
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if not PlayObject.m_boDeath and
        not PlayObject.m_boGhost and
        (PlayObject.m_PEnvir = Envir) and
        (abs(PlayObject.m_nCurrX - nRageX) <= nRage) and
        (abs(PlayObject.m_nCurrY - nRageY) <= nRage) then
      begin
        List.Add(PlayObject);
        Inc(Result);
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetMapRageHuman');
  end;
end;

function TUserEngine.GetStdItemIdx(sItemName: string): Integer; //004AC1FC
var
  I: Integer;
  //StdItem:pTStdItem;
  StdItem: TItem; //07.05.17修改
begin
  try
    Result := -1;
    if sItemName = '' then
      exit;
    for I := 0 to StdItemList.Count - 1 do
    begin
      StdItem := StdItemList.Items[I];
      //MainOutMessage('StdItem:'+StdItem.Name);
      if CompareText(StdItem.Name, sItemName) = 0 then
      begin
        Result := I + 1;
        break;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.GetStdItemIdx');
  end;
end;
//==========================================
//向每个人物发送消息
//线程安全
//==========================================

procedure TUserEngine.SendBroadSocket(DefMsg: pTDefaultMessage; sMsg: string);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    try
      EnterCriticalSection(ProcessHumanCriticalSection);
      for I := 0 to m_PlayObjectList.Count - 1 do
      begin
        PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
        if not PlayObject.m_boGhost then
          PlayObject.SendSocket(DefMsg, sMsg);
      end;
    finally
      LeaveCriticalSection(ProcessHumanCriticalSection);
    end;
  except
    MainOutMessage('[Exception] TUserEngine.SendBroadCastMsgExt');
  end;
end;
//==========================================
//向每个人物发送消息
//线程安全
//==========================================

procedure TUserEngine.SendBroadCastMsgExt(sMsg: string; MsgType: TMsgType);
//004AEAF0
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    try
      EnterCriticalSection(ProcessHumanCriticalSection);
      for I := 0 to m_PlayObjectList.Count - 1 do
      begin
        PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
        if not PlayObject.m_boGhost then
          PlayObject.SysMsg(sMsg, c_Red, MsgType);
        //PlayObject.SendSocket();
      end;
    finally
      LeaveCriticalSection(ProcessHumanCriticalSection);
    end;
  except
    MainOutMessage('[Exception] TUserEngine.SendBroadCastMsgExt');
  end;
end;

procedure TUserEngine.SendBroadCastMsg(sMsg: string; MsgType: TMsgType);
//004AEAF0
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
      if not PlayObject.m_boGhost then
        PlayObject.SysMsg(sMsg, c_Red, MsgType);
    end;
  except
    MainOutMessage('[Exception] TUserEngine.SendBroadCastMsg');
  end;
end;

procedure TUserEngine.sub_4AE514(GoldChangeInfo: pTGoldChangeInfo); //004AE514
var
  GoldChange: pTGoldChangeInfo;
begin
  try
    New(GoldChange);
    GoldChange^ := GoldChangeInfo^;
    EnterCriticalSection(m_LoadPlaySection);
    try
      m_ChangeHumanDBGoldList.Add(GoldChange);
    finally
      LeaveCriticalSection(m_LoadPlaySection);
    end;
  except
    MainOutMessage('[Exception] TUserEngine.sub_4AE514');
  end;
end;

procedure TUserEngine.ClearMonSayMsg;
var
  I, II: Integer;
  MonGen: pTMonGenInfo;
  MonBaseObject: TBaseObject;
begin
  try
    for I := 0 to m_MonGenList.Count - 1 do
    begin
      MonGen := m_MonGenList.Items[I];
      for II := 0 to MonGen.CertList.Count - 1 do
      begin
        MonBaseObject := TBaseObject(MonGen.CertList.Items[II]);
        MonBaseObject.m_SayMsgList := nil;
      end;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.ClearMonSayMsg');
  end;
end;

procedure TUserEngine.PrcocessData;
var
  dwUsrTimeTick: LongWord;
  sMsg: string;
  nCheck: Byte;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::ProcessData %d';
begin
  try
    if g_Config.boVerNoTime then
      exit;
    nCheck := 0;
    try
      nCheck := 0;
      dwUsrTimeTick := GetTickCount();
      nCheck := 1;
      ProcessHumans();
      nCheck := 2;
      if g_Config.boSendOnlineCount and (GetTickCount - g_dwSendOnlineTick >
        g_Config.dwSendOnlineTime) then
      begin
        g_dwSendOnlineTick := GetTickCount();
        nCheck := 3;
        sMsg := Format(g_sSendOnlineCountMsg, [ROUND(GetOnlineHumCount *
            (g_Config.nSendOnlineCountRate / 10))]);
        //sMsg:=AnsiReplaceText(g_sSendOnlineCountMsg,'%c',IntToStr());
        SendBroadCastMsg(sMsg, t_System)
      end;
      nCheck := 4;
      //ProcessMonsters();

      if (GetTickCount() - dwProcessMonstersTick) >
        g_Config.dwProcessMonstersTime then
      begin
        dwProcessMonstersTick := GetTickCount();
        nCheck := 5;
        ProcessStatMapManCount();

        ProcessMonsters();
      end;
      nCheck := 6;

      ProcessMerchants();
      nCheck := 7;
      ProcessNpcs();
      nCheck := 8;
      if (GetTickCount() - dwProcessMissionsTime) > 2000 then
      begin
        dwProcessMissionsTime := GetTickCount();
        nCheck := 9;
        {ProcessMissions();
        nCheck:=10;
        Process4AECFC();
        nCheck:=11; }
        ProcessEvents();
        nCheck := 12;

        if dwProcessMerchantTimeMax > 0 then
          Dec(dwProcessMerchantTimeMax);
        if dwProcessNpcTimeMax > 0 then
          Dec(dwProcessNpcTimeMax);
        if dwMerchantGoodsTimeMax > 0 then
          Dec(dwMerchantGoodsTimeMax);
        if dwMerchantDataTimeMax > 0 then
          Dec(dwMerchantDataTimeMax);
      end;

      if (GetTickCount() - dwProcessMapDoorTick) > 500 then
      begin
        dwProcessMapDoorTick := GetTickCount();
        nCheck := 13;
        ProcessMapDoor();

      end;
      if (GetTickCount > g_Config.dwCheckTime) then
      begin
        g_Config.boCheckNow := False;
      end;
      nCheck := 14;
      g_nUsrTimeMin2 := GetTickCount() - dwUsrTimeTick;
      if g_nUsrTimeMax2 < g_nUsrTimeMin2 then
        g_nUsrTimeMax2 := g_nUsrTimeMin2;
    except
      MainOutMessage(Format(sExceptionMsg, [nCheck]));
    end;
  except
    MainOutMessage('[Exception] TUserEngine.PrcocessData');
  end;
end;

{function TUserEngine.MapRageHuman(sMapName: String; nMapX, nMapY,
  nRage: Integer): Boolean;
var
  nX,nY:Integer;
  Envir:TEnvirnoment;
begin
Try
  Result:=False;
  Envir:=g_MapManager.FindMap(sMapName);
  if Envir <> nil then begin
    for nX:= nMapX - nRage to nMapX + nRage do begin
      for nY:= nMapY - nRage to nMapY + nRage do begin
        if Envir.GetXYHuman(nMapX, nMapY) then begin
          Result:=True;
          exit;
        end;
      end;
    end;
  end;
Except
  MainOutMessage('[Exception] TUserEngine.MapRageHuman');
End;
end;  }

procedure TUserEngine.SendDefMessage(wIdent: Word; nRecog: Integer; nParam,
  nTag, nSeries: Word; sMsg: string);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if not PlayObject.m_boDeath and not PlayObject.m_boGhost then
        PlayObject.SendDefMessage(wIdent, nRecog, nParam, nTag, nSeries, sMsg);
    end;
  except
    MainOutMessage('[Exception] TUserEngine.SendDefMessage');
  end;
end;

procedure TUserEngine.SendQuestMsg(sQuestName: string);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if not PlayObject.m_boDeath and not PlayObject.m_boGhost then
        PlayObject.NpcGotoLable(g_ManageNPC, sQuestName, False);
      //g_ManageNPC.GotoLable(PlayObject,sQuestName,False);
    end;
  except
    MainOutMessage('[Exception] TUserEngine.SendQuestMsg');
  end;
end;

procedure TUserEngine.ClearItemList();
var
  I: Integer;
begin
  try
    I := 0;
    while (True) do
    begin
      StdItemList.Exchange(Random(StdItemList.Count), StdItemList.Count - 1);
      Inc(I);
      if I >= StdItemList.Count then
        break;
    end;
    ClearMerchantData();
  except
    MainOutMessage('[Exception] TUserEngine.ClearItemList');
  end;
end;

procedure TUserEngine.SwitchMagicList();
begin
  try
    if m_MagicList2.Count > 0 then
    begin
      OldMagicList.Add(m_MagicList2);
      m_MagicList2 := TList.Create;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.SwitchMagicList');
  end;
end;

procedure TUserEngine.ClearMerchantData();
var
  I: Integer;
  Merchant: TMerchant;
begin
  try
    m_MerchantList.Lock;
    try
      for I := 0 to m_MerchantList.Count - 1 do
      begin
        Merchant := TMerchant(m_MerchantList.Items[I]);
        Merchant.ClearData();
      end;
    finally
      m_MerchantList.UnLock;
    end;
  except
    MainOutMessage('[Exception] TUserEngine.ClearMerchantData');
  end;
end;

procedure TUserEngine.AddOffLine(PlayObject: TPlayObject);
begin
  m_OffLineList.Lock;
  try
    m_OffLineList.AddObject(PlayObject.m_sCharName, PlayObject);
  finally
    m_OffLineList.UnLock;
  end;
end;

function TUserEngine.GetOffLine(sName: string): TPlayObject;
var
  I: Integer;
begin
  Result := nil;
  m_OffLineList.Lock;
  try
    for i := m_OffLineList.Count - 1 downto 0 do
    begin
      if CompareText(m_OffLineList.Strings[i], sName) = 0 then
      begin
        Result := TPlayObject(m_OffLineList.Objects[I]);
        break;
      end;
    end;
  finally
    m_OffLineList.UnLock;
  end;
end;

procedure TUserEngine.DelOffLine(sName: string);
var
  I: Integer;
begin
  m_OffLineList.Lock;
  try
    for i := m_OffLineList.Count - 1 downto 0 do
    begin
      if CompareText(m_OffLineList.Strings[i], sName) = 0 then
      begin
        m_OffLineList.Delete(I);
        break;
      end;
    end;
  finally
    m_OffLineList.UnLock;
  end;
end;

procedure TUserEngine.KickAllOffLine();
var
  I: Integer;
begin
  m_OffLineList.Lock;
  try
    for i := m_OffLineList.Count - 1 downto 0 do
    begin
      TPlayObject(m_OffLineList.Objects[I]).MakeGhost;
    end;
    m_OffLineList.Clear;
  finally
    m_OffLineList.UnLock;
  end;
end;

initialization
  begin

  end;
finalization
  begin

  end;
end.

