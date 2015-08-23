//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit ObjNpc;

interface
uses
  Windows, Classes, SysUtils, StrUtils, ObjBase, Grobal2, SDK, IniFiles,
  DateUtils, FindMapPath;
type
  TUpgradeInfo = record //0x40
    sUserName: string[ActorNameLen]; //0x00
    UserItem: TUserItem; //0x10
    btDc: Byte; //0x28
    btSc: Byte; //0x29
    btMc: Byte; //0x2A
    btDura: Byte; //0x2B
    n2C: Integer;
    dtTime: TDateTime; //0x30
    dwGetBackTick: LongWord; //0x38
    n3C: Integer;
  end;
  pTUpgradeInfo = ^TUpgradeInfo;
  TItemPrice = record
    wIndex: Word;
    nPrice: Integer;
  end;
  pTItemPrice = ^TItemPrice;
  TGoods = record //0x1C
    sItemName: string[14];
    nCount: Integer;
    dwRefillTime: LongWord;
    dwRefillTick: LongWord;
  end;
  pTGoods = ^TGoods;
  TQuestActionInfo = record //0x1C
    TCmdList: TStringList;
    nCmdCode: Integer; //0x00
    sParam1: string; //0x04
    nParam1: Integer; //0x08
    sParam2: string; //0x0C
    nParam2: Integer; //0x10
    sParam3: string; //0x14
    nParam3: Integer; //0x18
    sParam4: string;
    nParam4: Integer;
    sParam5: string;
    nParam5: Integer;
    sParam6: string;
    nParam6: Integer;
    sParam7: string;
    nParam7: Integer;
  end;
  pTQuestActionInfo = ^TQuestActionInfo;
  TQuestConditionInfo = record //0x14
    TCmdList: TStringList;
    nCmdCode: Integer; //0x00
    sParam1: string; //0x04
    nParam1: Integer; //0x08
    sParam2: string; //0x0C
    nParam2: Integer; //0x10
    sParam3: string;
    nParam3: Integer;
    sParam4: string;
    nParam4: Integer;
    sParam5: string;
    nParam5: Integer;
    sParam6: string;
    nParam6: Integer;
    sParam7: string;
    nParam7: Integer;
  end;
  pTQuestConditionInfo = ^TQuestConditionInfo;
  TSayingProcedure = record //0x14
    ConditionList: TList; //0x00
    ActionList: TList; //0x04
    sSayMsg: string; //0x08
    ElseActionList: TList; //0x0C
    sElseSayMsg: string; //0x10
  end;
  pTSayingProcedure = ^TSayingProcedure;
  TSayingRecord = record //0x08
    sLabel: string;
    ProcedureList: TList; //0x04
    boExtJmp: boolean; //是否允许外部跳转
  end;
  pTSayingRecord = ^TSayingRecord;

  TNormNpc = class(TAnimalObject) //0x564
    n54C: Integer; //0x54C
    m_nFlag: ShortInt;
    //0x550 //用于标识此NPC是否有效，用于重新加载NPC列表(-1 为无效)
    m_ScriptList: TList; //0x554   //脚本标题列表
    m_sFilePath: string; //0x558 脚本文件所在目录
    m_boIsHide: Boolean; //0x55C 此NPC是否是隐藏的，不显示在地图中
    m_boIsQuest: Boolean;
    //0x55D NPC类型为地图任务型的，加载脚本时的脚本文件名为 角色名-地图号.txt
    m_sPath: string; //0x560
    m_QuestConditionInfo: pTQuestConditionInfo;
    m_QuestActionInfo: pTQuestActionInfo;
    m_FPath: TPath;
    m_MissionMap: string[MapNameLen];
    m_nMissionX: Integer;
    m_nMissionY: Integer;
  private
    procedure ScriptActionError(PlayObject: TPlayObject; sErrMsg: string;
      QuestActionInfo: pTQuestActionInfo; sCmd: string);
    procedure ScriptConditionError(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo; sCmd: string);
    procedure ScriptListError(PlayObject: TPlayObject; List: TStringList);
    procedure SetIntegerVal(PlayObject: TPlayObject; Name: string; Int:
      Integer);

    procedure ExeAction(PlayObject: TPlayObject; sParam1, sParam2, sParam3:
      string; nParam1, nParam2, nParam3: Integer);
    procedure ActionOfChangeLevel(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfMarry(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfMaster(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfUnMarry(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfUnMaster(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGiveItem(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);

    procedure ActionOfGetMarry(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGetMaster(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfClearSkill(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfDelNoJobSkill(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfDelSkill(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfAddSkill(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfCHANGETRANPOINT(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSkillLevel(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfChangePkPoint(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfChangeExp(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfChangeCreditPoint(PlayObject: TPlayObject;
      QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeJob(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    //    procedure ActionOfRecallGroupMembers(PlayObject:TPlayObject;QuestActionInfo:pTQuestActionInfo);
    procedure ActionOfClearNameList(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    //    procedure ActionOfMapTing(PlayObject:TPlayObject;QuestActionInfo:pTQuestActionInfo);
    procedure ActionOfMission(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfMobPlace(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo; nX, nY, nCount, nRange: Integer);
    procedure ActionOfSetMemberType(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSetMemberLevel(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);

    procedure ActionOfGameGold(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGamePoint(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfAutoAddGameGold(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo; nPoint, nTime: integer);
    procedure ActionOfAutoSubGameGold(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo; nPoint, nTime: integer);
    procedure ActionOfChangeHairStyle(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfLineMsg(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfChangeNameColor(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfClearPassword(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfReNewLevel(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfChangeGender(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfKillSlave(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfKillMonExpRate(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfPowerRate(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfChangeMode(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfChangePerMission(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfKill(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfKick(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfBonusPoint(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfRestReNewLevel(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfDelMarry(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfDelMaster(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfClearNeedItems(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfClearMakeItems(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfUpgradeItems(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfUpgradeItemsEx(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSetItemState(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGiveStateItem(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfMonGenEx(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfClearMapMon(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);

    procedure ActionOfSetMapMode(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfPkZone(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfRestBonusPoint(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfTakeCastleGold(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfHumanHP(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfHumanMP(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGuildBuildPoint(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGuildAuraePoint(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGuildstabilityPoint(PlayObject: TPlayObject;
      QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildFlourishPoint(PlayObject: TPlayObject;
      QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfOpenMagicBox(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSetRankLevelName(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGmExecute(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGuildChiefItemCount(PlayObject: TPlayObject;
      QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddNameDateList(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfDelNameDateList(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfMobFireBurn(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfMessageBox(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSetScriptFlag(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfAutoGetExp(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfRecallmob(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfReCallMobEx(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfMoveMobTo(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfClearItemMap(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSetIcon(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfChangeDiploid(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfOpenBoxs(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfAddGuildMember(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfDelGuildMember(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGloryChange(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfAddAttackSabukAll(PlayObject: TPlayObject;
      QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSendTopMsg(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSendCenterMsg(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSendEditTopMsg(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfChangeHeroLoyal(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfAddRandomMapGate(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfDelRandomMapGate(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGetRandomMapGate(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSetItemsLight(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfOpenPlayDrink(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfPlayDrinkMsg(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfCloseDrink(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSaveHero(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGetHero(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfFOUNTAIN(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfDECMAKEWINETIME(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSETGUILDFOUNTAIN(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGIVEGUILDFOUNTAIN(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGIVECASTLEFOUNTAIN(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGETGOODMAKEWINE(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfOPENMAKEWINE(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfOPENWebBrowser(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfQUERYREFINEITEM(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfVar(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfLoadVar(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSaveVar(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfCalcVar(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);

    procedure ActionOfGuildRecall(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGroupAddList(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfClearList(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGroupRecall(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGroupMoveMap(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfCHALLENGMAPMOVE(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGETCHALLENGEBAKITEM(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGuildMove(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGuildMapMove(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);

    //夜猫仔新增
    procedure ActionOfTakeOnItem(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfTakeOffItem(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfHCall(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfAddTextList(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfDelTextList(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfUSEBONUSPOINT(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfChangeHumAbility(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfThrowItem(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfChangeHeroLevel(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfChangeHeroJob(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfChangeHeroPKPoint(PlayObject: TPlayObject;
      QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeHeroExp(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfClearHeroSkill(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSetOnTimer(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSetOffTimer(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);

    procedure ActionOfAddUserDate(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfDelUserDate(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfClearCodeList(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGetRandomName(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfThroughHum(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGuildNoticeMsg(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfRepairAll(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfStartTakeGold(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);

    procedure ActionOfCreateHero(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);

    procedure ActionOfDelayCall(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfClearDelayGoto(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);

    procedure ActionOfGameDiamond(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGameGird(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfDeleteHero(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfOfflincPlay(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);

    function ConditionOfCheckGameDiamond(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGameGird(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckItemState(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCHECKGUILDFOUNTAIN(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfISONMAKEWINE(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfKILLBYHUM(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfKILLBYMON(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCHECKDRUNKRATE(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCheckCastlewar(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfMapHumIsSameGuild(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHeroLevel(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHeroJob(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHeroPKPoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfOffLinePlayerCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckUserDate(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCodeList(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckListText(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfIsHigh(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo): Boolean;
    function ConditionOfCheckOnLinePlayCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMapName(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMapMobCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfFindMapPath(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSkill(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo): Boolean;
    function ConditionOfCheckDiploid(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckItemLevel(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSideSlaveName(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGloryPoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHeroLoyal(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCheckGroupCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseDir(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseLevel(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseGender(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseMarry(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckLevelEx(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSlaveCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckBonusPoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckAccountIPList(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckNameIPList(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMarry(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMarryCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMaster(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo): Boolean;
    function ConditionOfHaveMaster(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseMaster(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfPoseHaveMaster(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCheckIsMaster(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseIsMaster(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHaveGuild(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsGuildMaster(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsCastleaGuild(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsCastleMaster(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMemberType(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMemBerLevel(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGameGold(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGamePoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckNameListPostion(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //    function  ConditionOfCheckGuildList(PlayObject:TPlayObject;QuestConditionInfo:pTQuestConditionInfo):Boolean;
    function ConditionOfCheckReNewLevel(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSlaveLevel(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSlaveName(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCheckCreditPoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckOfGuild(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPayMent(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckUseItem(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckBagSize(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckListCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckDC(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMC(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSC(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHP(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMP(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo): Boolean;
    function ConditionOfCheckItemType(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckExp(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCastleGold(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPasswordErrorCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfIsLockPassword(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfIsLockStorage(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGuildBuildPoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGuildAuraePoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckStabilityPoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckFlourishPoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckContribution(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckRangeMonCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckItemAddValue(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckInMapRange(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsAttackGuild(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsDefenseGuild(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCastleDoorStatus(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //function  ConditionOfCheckIsAttackAllyGuild(PlayObject:TPlayObject;QuestConditionInfo:pTQuestConditionInfo):Boolean;
    //function  ConditionOfCheckIsDefenseAllyGuild(PlayObject:TPlayObject;QuestConditionInfo:pTQuestConditionInfo):Boolean;
    function ConditionOfCheckCastleChageDay(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCastleWarDay(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckOnlineLongMin(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckChiefItemCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckNameDateList(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMapHumanCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMapMonCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckVar(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo): Boolean;
    function ConditionOfCheckServerName(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCheckMap(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo): Boolean;
    //    function  ConditionOfCheckPos(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
        //function  ConditionOfReviveSlave(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMagicLvl(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGroupClass(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function GetDynamicVarList(PlayObject: TPlayObject; sType: string; var
      sName: string): TList;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Initialize(); override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override; //FFFB
    function GetShowName(): string; override;
    procedure Click(PlayObject: TPlayObject); virtual; //FFEB
    procedure UserSelect(PlayObject: TPlayObject; sData: string); virtual; //FFEA
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string;
      sVariable: string); virtual; //FFE9
    function GetLineVariableText(PlayObject: TPlayObject; sMsg: string): string;
    procedure GotoLable(PlayObjectEx: TPlayObject; sLabel: string; boExtJmp:
      Boolean);
    function sub_49ADB8(sMsg, sStr, sText: string): string;
    procedure LoadNPCScript();
    procedure ClearScript(); virtual;
    procedure SendMsgToUser(PlayObject: TPlayObject; sMsg: string);
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); virtual;
  end;
  TMerchant = class(TNormNpc) //0x594
    m_sScript: string; //0x568
    n56C: Integer;
    m_nPriceRate: Integer; //0x570   物品价格倍率 默认为 100%
    bo574: Boolean;
    m_boCastle: Boolean; //0x575
    dwRefillGoodsTick: LongWord; //0x578
    dwRefillGoodsTime: LongWord;
    dwClearExpreUpgradeTick: LongWord; //0x57C
    m_ItemTypeList: TList;
    //0x580  NPC买卖物品类型列表，脚本中前面的 +1 +30 之类的
    m_RefillGoodsList: TList; //0x584
    m_GoodsList: TList; //0x588
    m_ItemPriceList: TList; //0x58C
    m_UpgradeWeaponList: TList;
    m_boCanMove: Boolean;
    m_dwMoveTime: LongWord;
    m_dwMoveTick: LongWord;
    m_boCanAutoColor: Byte;
    //    m_nAutoColorIdx     :Byte;
    m_dwAutoColorTime: LongWord;
    //    m_dwAutoColorTick   :LongWord;
    m_boBuy: Boolean;
    m_boSell: Boolean;
    m_boSellOff: Boolean;
    m_boMakeDrug: Boolean;
    m_boPrices: Boolean;
    m_boStorage: Boolean;
    m_boPlayDrink: Boolean;
    m_boGetback: Boolean;
    m_boUpgradenow: Boolean;
    m_boGetBackupgnow: Boolean;
    m_boRepair: Boolean;
    m_boS_repair: Boolean;
    m_boSendmsg: Boolean;
    m_boGetMarry: Boolean;
    m_boGetMaster: Boolean;
    m_boUseItemName: Boolean;
    m_boHero: Boolean;
    m_boDealGold: Boolean;
    m_boBatchBuy: Boolean;
    m_boInPutInteger: Boolean;
    m_boInPutString: Boolean;
  private
    procedure ClearExpreUpgradeListData();
    function CheckItemType(nStdMode: Integer): Boolean;
    procedure CheckItemPrice(nIndex: Integer);
    function GetRefillList(nIndex: Integer): TList;
    procedure AddItemPrice(nIndex, nPrice: Integer);

    function GetSellItemPrice(nPrice: integer): Integer;
    function AddItemToGoodsList(UserItem: pTUserItem): Boolean;
    procedure GetBackupgWeapon(User: TPlayObject);
    procedure UpgradeWapon(User: TPlayObject);
    procedure ChangeUseItemName(PlayObject: TPlayObject; sLabel, sItemName:
      string);
    procedure SaveUpgradingList;
    //    procedure GetMarry(PlayObject:TPlayObject;sDearName:String);
    //    procedure GetMaster(PlayObject:TPlayObject;sMasterName:String);
  public
    constructor Create(); override;
    destructor Destroy; override;
    function GetUserItemPrice(UserItem: pTUserItem): Integer;
    function GetItemPrice(nIndex: Integer): Integer;
    function GetUserPrice(PlayObject: TPlayObject; nPrice: Integer): Integer;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure Run; override;
    procedure UserSelect(PlayObject: TPlayObject; sData: string); override;
    procedure LoadNPCData();
    procedure SaveNPCData();
    procedure LoadUpgradeList();
    procedure RefillGoods();
    procedure LoadNPCScript();
    procedure Click(PlayObject: TPlayObject); override;
    procedure ClearScript(); override;
    procedure ClearData();
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string;
      sVariable: string); override; //FFE9
    procedure ClientBuyItem(PlayObject: TPlayObject; sItemName: string; nInt:
      Integer);
    procedure ClientGetDetailGoodsList(PlayObject: TPlayObject; sItemName:
      string; nInt: Integer);
    procedure ClientQuerySellPrice(PlayObject: TPlayObject; UserItem:
      pTUserItem);
    function ClientSellItem(PlayObject: TPlayObject; UserItem: pTUserItem):
      Boolean;
    procedure ClientMakeDrugItem(PlayObject: TPlayObject; sItemName: string);
    procedure ClientQueryRepairCost(PlayObject: TPlayObject; UserItem:
      pTUserItem);
    function ClientRepairItem(PlayObject: TPlayObject; UserItem: pTUserItem):
      Boolean;
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); override;
  end;
  TGuildOfficial = class(TNormNpc) //0x568
  private
    function ReQuestBuildGuild(PlayObject: TPlayObject;
      sGuildName: string): Integer;
    function ReQuestGuildWar(PlayObject: TPlayObject;
      sGuildName: string): Integer;
    procedure DoNate(PlayObject: TPlayObject);
    procedure ReQuestCastleWar(PlayObject: TPlayObject; sIndex: string);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string;
      sVariable: string); override; //FFE9
    procedure Run; override; //FFFB
    procedure Click(PlayObject: TPlayObject); override; //FFEB
    procedure UserSelect(PlayObject: TPlayObject; sData: string); override;
    //FFEA
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); override;
  end;
  TTrainer = class(TNormNpc) //0x574
    n564: Integer;
    m_dw568: LongWord;
    n56C: Integer;
    n570: Integer;
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override;
  end;
  //  TCastleManager = class(TMerchant)
  TCastleOfficial = class(TMerchant)
  private
    procedure HireArcher(sIndex: string; PlayObject: TPlayObject);
    procedure HireGuard(sIndex: string; PlayObject: TPlayObject);
    procedure RepairDoor(PlayObject: TPlayObject);
    procedure RepairWallNow(nWallIndex: Integer; PlayObject: TPlayObject);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Click(PlayObject: TPlayObject); override; //FFEB
    procedure UserSelect(PlayObject: TPlayObject; sData: string); override;
    //FFEA
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string;
      sVariable: string); override; //FFE9
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); override;
  end;
implementation

uses Castle, M2Share, HUtil32, LocalDB, Envir, Guild, EDcode, ObjMon2,
     Event, ItmUnit, PlugFun;

procedure TCastleOfficial.Click(PlayObject: TPlayObject); //004A4588
begin
  try
    if m_Castle = nil then
    begin
      PlayObject.SysMsg('NPC不属于城堡！！！', c_Red, t_Hint);
      exit;
    end;
    if TUserCastle(m_Castle).IsMasterGuild(TGUild(PlayObject.m_MyGuild)) or
      (PlayObject.m_btPermission >= 3) then
      inherited;
  except
    MainOutMessage('[Exception] TCastleOfficial.Click');
  end;
end;

procedure TCastleOfficial.GetVariableText(PlayObject: TPlayObject;
  var sMsg: string; sVariable: string);
var
  sText: string;
  CastleDoor: TCastleDoor;
begin
  try
    inherited;
    if m_Castle = nil then
    begin
      sMsg := '????';
      exit;
    end;
    if sVariable = '$CASTLEGOLD' then
    begin
      sText := IntToStr(TUserCastle(m_Castle).m_nTotalGold);
      sMsg := sub_49ADB8(sMsg, '<$CASTLEGOLD>', sText);
    end
    else if sVariable = '$TODAYINCOME' then
    begin
      sText := IntToStr(TUserCastle(m_Castle).m_nTodayIncome);
      sMsg := sub_49ADB8(sMsg, '<$TODAYINCOME>', sText);
    end
    else if sVariable = '$CASTLEDOORSTATE' then
    begin
      CastleDoor := TCastleDoor(TUserCastle(m_Castle).m_MainDoor.BaseObject);
      if CastleDoor.m_boDeath then
        sText := '损坏'
      else if CastleDoor.m_boOpened then
        sText := '打开'
      else
        sText := '关闭';
      sMsg := sub_49ADB8(sMsg, '<$CASTLEDOORSTATE>', sText);
    end
    else if sVariable = '$REPAIRDOORGOLD' then
    begin
      sText := IntToStr(g_Config.nRepairDoorPrice);
      sMsg := sub_49ADB8(sMsg, '<$REPAIRDOORGOLD>', sText);
    end
    else if sVariable = '$REPAIRWALLGOLD' then
    begin
      sText := IntToStr(g_Config.nRepairWallPrice);
      sMsg := sub_49ADB8(sMsg, '<$REPAIRWALLGOLD>', sText);
    end
    else if sVariable = '$GUARDFEE' then
    begin
      sText := IntToStr(g_Config.nHireGuardPrice);
      sMsg := sub_49ADB8(sMsg, '<$GUARDFEE>', sText);
    end
    else if sVariable = '$ARCHERFEE' then
    begin
      sText := IntToStr(g_Config.nHireArcherPrice);
      sMsg := sub_49ADB8(sMsg, '<$ARCHERFEE>', sText);
    end
    else if sVariable = '$GUARDRULE' then
    begin
      sText := '无效';
      sMsg := sub_49ADB8(sMsg, '<$GUARDRULE>', sText);
    end;

  except
    MainOutMessage('[Exception] TCastleOfficial.GetVariableText');
  end;
end;

procedure TCastleOfficial.UserSelect(PlayObject: TPlayObject; sData: string);
var
  s18, s20, sMsg, sLabel: string;
  boCanJmp: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TCastleManager::UserSelect... ';
begin
  try
    inherited;
    try
      //    PlayObject.m_nScriptGotoCount:=0;
      if m_Castle = nil then
      begin
        PlayObject.SysMsg('NPC不属于城堡！！！', c_Red, t_Hint);
        exit;
      end;
      if (sData <> '') and (sData[1] = '@') then
      begin
        sMsg := GetValidStr3(sData, sLabel, [#13]);
        s18 := '';
        PlayObject.m_sScriptLable := sData;
        if TUserCastle(m_Castle).IsMasterGuild(TGUild(PlayObject.m_MyGuild)) and
          (PlayObject.IsGuildMaster) then
        begin
          boCanJmp := PlayObject.LableIsCanJmp(sLabel);
          if CompareText(sLabel, sSL_SENDMSG) = 0 then
          begin
            if sMsg = '' then
              exit;
          end;
          GotoLable(PlayObject, sLabel, not boCanJmp);
          //GotoLable(PlayObject,sLabel,not PlayObject.LableIsCanJmp(sLabel));
          if not boCanJmp then
            exit;
          if CompareText(sLabel, sSL_SENDMSG) = 0 then
          begin
            SendCustemMsg(PlayObject, sMsg);
            PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
          end
          else if CompareText(sLabel, sCASTLENAME) = 0 then
          begin
            sMsg := Trim(sMsg);
            if sMsg <> '' then
            begin
              TUserCastle(m_Castle).m_sName := sMsg;
              TUserCastle(m_Castle).Save;
              TUserCastle(m_Castle).m_MasterGuild.RefMemberName;
              s18 := '城堡名称更改成功...';
            end
            else
            begin
              s18 := '城堡名称更改失败！！！';
            end;
            PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
          end
          else if CompareText(sLabel, sWITHDRAWAL) = 0 then
          begin
            case TUserCastle(m_Castle).WithDrawalGolds(PlayObject,
              Str_ToInt(sMsg, 0)) of
              -4: s18 := '输入的金币数不正确！！！';
              -3: s18 := '您无法携带更多的东西了。';
              -2: s18 := '该城内没有这么多金币.';
              -1: s18 := '只有行会 ' + TUserCastle(m_Castle).m_sOwnGuild +
                ' 的掌门人才能使用！！！';
              1: GotoLable(PlayObject, sMAIN, False);
            end;
            PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
          end
          else if CompareText(sLabel, sRECEIPTS) = 0 then
          begin
            case TUserCastle(m_Castle).ReceiptGolds(PlayObject, Str_ToInt(sMsg,
              0)) of
              -4: s18 := '输入的金币数不正确！！！';
              -3: s18 := '你已经达到在城内存放货物的限制了。';
              -2: s18 := '你没有那么多金币.';
              -1: s18 := '只有行会 ' + TUserCastle(m_Castle).m_sOwnGuild +
                ' 的掌门人才能使用！！！';
              1: GotoLable(PlayObject, sMAIN, False);
            end;
            PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
          end
          else if CompareText(sLabel, sOPENMAINDOOR) = 0 then
          begin
            TUserCastle(m_Castle).MainDoorControl(False);
          end
          else if CompareText(sLabel, sCLOSEMAINDOOR) = 0 then
          begin
            TUserCastle(m_Castle).MainDoorControl(True);
          end
          else if CompareText(sLabel, sREPAIRDOORNOW) = 0 then
          begin
            RepairDoor(PlayObject);
            GotoLable(PlayObject, sMAIN, False);
          end
          else if CompareText(sLabel, sREPAIRWALLNOW1) = 0 then
          begin
            RepairWallNow(1, PlayObject);
            GotoLable(PlayObject, sMAIN, False);
          end
          else if CompareText(sLabel, sREPAIRWALLNOW2) = 0 then
          begin
            RepairWallNow(2, PlayObject);
            GotoLable(PlayObject, sMAIN, False);
          end
          else if CompareText(sLabel, sREPAIRWALLNOW3) = 0 then
          begin
            RepairWallNow(3, PlayObject);
            GotoLable(PlayObject, sMAIN, False);
          end
          else if CompareLStr(sLabel, sHIREGUARDNOW, length(sHIREGUARDNOW)) then
          begin
            s20 := Copy(sLabel, length(sHIREGUARDNOW) + 1, length(sLabel));
            HireGuard(s20, PlayObject);
            PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, '');
            //GotoLable(PlayObject,sHIREGUARDOK,False);
          end
          else if CompareLStr(sLabel, sHIREARCHERNOW, length(sHIREARCHERNOW))
            then
          begin
            s20 := Copy(sLabel, length(sHIREARCHERNOW) + 1, length(sLabel));
            HireArcher(s20, PlayObject);
            PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, '');
          end
          else if CompareText(sLabel, sEXIT) = 0 then
          begin
            PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self), 0,
              0,
              '');
          end
          else if CompareText(sLabel, sBACK) = 0 then
          begin
            if PlayObject.m_sScriptGoBackLable = '' then
              PlayObject.m_sScriptGoBackLable := sMAIN;
            GotoLable(PlayObject, PlayObject.m_sScriptGoBackLable, False);
          end;
        end
        else
        begin
          s18 := '你不是城堡管理员.';
          PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
        end;
      end;
    except
      MainOutMessage(sExceptionMsg);
    end;
    //  inherited;

  except
    MainOutMessage('[Exception] TCastleOfficial.UserSelect');
  end;
end;

procedure TCastleOfficial.HireGuard(sIndex: string; PlayObject: TPlayObject);
//004A413C
var
  n10: Integer;
  ObjUnit: pTObjUnit;
begin
  try
    if m_Castle = nil then
    begin
      PlayObject.SysMsg('NPC不属于城堡！！！', c_Red, t_Hint);
      exit;
    end;
    if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nHireGuardPrice then
    begin
      n10 := Str_ToInt(sIndex, 0) - 1;
      if n10 <= MAXCALSTEGUARD then
      begin
        if TUserCastle(m_Castle).m_Guard[n10].BaseObject = nil then
        begin
          if not TUserCastle(m_Castle).m_boUnderWar then
          begin
            ObjUnit := @TUserCastle(m_Castle).m_Guard[n10];
            ObjUnit.BaseObject :=
              UserEngine.RegenMonsterByName(TUserCastle(m_Castle).m_sMapName,
              ObjUnit.nX,
              ObjUnit.nY,
              ObjUnit.sName);
            if ObjUnit.BaseObject <> nil then
            begin
              Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nHireGuardPrice);
              ObjUnit.BaseObject.m_Castle := TUserCastle(m_Castle);
              TGuardUnit(ObjUnit.BaseObject).m_nX550 := ObjUnit.nX;
              TGuardUnit(ObjUnit.BaseObject).m_nY554 := ObjUnit.nY;
              TGuardUnit(ObjUnit.BaseObject).m_nDirection := 3;
              PlayObject.SysMsg('雇佣成功.', c_Green, t_Hint);
            end;

          end
          else
          begin
            PlayObject.SysMsg('现在无法雇佣！！！', c_Red, t_Hint);
          end;
        end
        else
        begin
          PlayObject.SysMsg('守卫已被雇佣.', c_Red, t_Hint);
        end;
      end
      else
      begin
        PlayObject.SysMsg('指令错误！！！', c_Red, t_Hint);
      end;
    end
    else
    begin
      PlayObject.SysMsg('城内资金不足！！！', c_Red, t_Hint);
    end;
    {
    if UserCastle.m_nTotalGold >= g_Config.nHireGuardPrice then begin
      n10:=Str_ToInt(sIndex,0) - 1;
      if n10 <= MAXCALSTEGUARD then begin
        if UserCastle.m_Guard[n10].BaseObject = nil then begin
          if not UserCastle.m_boUnderWar then begin
            ObjUnit:=@UserCastle.m_Guard[n10];
            ObjUnit.BaseObject:=UserEngine.RegenMonsterByName(UserCastle.m_sMapName,
                                                            ObjUnit.nX,
                                                            ObjUnit.nY,
                                                            ObjUnit.sName);
            if ObjUnit.BaseObject <> nil then begin
              Dec(UserCastle.m_nTotalGold,g_Config.nHireGuardPrice);
              ObjUnit.BaseObject.m_Castle:=UserCastle;
              TGuardUnit(ObjUnit.BaseObject).m_nX550:=ObjUnit.nX;
              TGuardUnit(ObjUnit.BaseObject).m_nY554:=ObjUnit.nY;
              TGuardUnit(ObjUnit.BaseObject).m_n558:=3;
              PlayObject.SysMsg('雇佣成功.',c_Green,t_Hint);
            end;

          end else begin
            PlayObject.SysMsg('现在无法雇佣！！！',c_Red,t_Hint);
          end;
        end
      end else begin
        PlayObject.SysMsg('指令错误！！！',c_Red,t_Hint);
      end;
    end else begin
      PlayObject.SysMsg('城内资金不足！！！',c_Red,t_Hint);
    end;
    }
  except
    MainOutMessage('[Exception] TCastleOfficial.HireGuard');
  end;
end;

procedure TCastleOfficial.HireArcher(sIndex: string; PlayObject: TPlayObject);
//004A433C
var
  n10: Integer;
  ObjUnit: pTObjUnit;
begin
  try
    if m_Castle = nil then
    begin
      PlayObject.SysMsg('NPC不属于城堡！！！', c_Red, t_Hint);
      exit;
    end;

    if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nHireArcherPrice then
    begin
      n10 := Str_ToInt(sIndex, 0) - 1;
      if n10 <= MAXCASTLEARCHER then
      begin
        if TUserCastle(m_Castle).m_Archer[n10].BaseObject = nil then
        begin
          if not TUserCastle(m_Castle).m_boUnderWar then
          begin
            ObjUnit := @TUserCastle(m_Castle).m_Archer[n10];
            ObjUnit.BaseObject :=
              UserEngine.RegenMonsterByName(TUserCastle(m_Castle).m_sMapName,
              ObjUnit.nX,
              ObjUnit.nY,
              ObjUnit.sName);
            if ObjUnit.BaseObject <> nil then
            begin
              Dec(TUserCastle(m_Castle).m_nTotalGold,
                g_Config.nHireArcherPrice);
              ObjUnit.BaseObject.m_Castle := TUserCastle(m_Castle);
              TGuardUnit(ObjUnit.BaseObject).m_nX550 := ObjUnit.nX;
              TGuardUnit(ObjUnit.BaseObject).m_nY554 := ObjUnit.nY;
              TGuardUnit(ObjUnit.BaseObject).m_nDirection := 3;
              PlayObject.SysMsg('雇佣成功.', c_Green, t_Hint);
            end;

          end
          else
          begin
            PlayObject.SysMsg('现在无法雇佣！！！', c_Red, t_Hint);
          end;
        end
        else
        begin
          PlayObject.SysMsg('守卫已被雇佣.', c_Red, t_Hint);
        end;
      end
      else
      begin
        PlayObject.SysMsg('指令错误！！！', c_Red, t_Hint);
      end;
    end
    else
    begin
      PlayObject.SysMsg('城内资金不足！！！', c_Red, t_Hint);
    end;
    {
    if UserCastle.m_nTotalGold >= g_Config.nHireArcherPrice then begin
      n10:=Str_ToInt(sIndex,0) - 1;
      if n10 <= MAXCASTLEARCHER then begin
        if UserCastle.m_Archer[n10].BaseObject = nil then begin
          if not UserCastle.m_boUnderWar then begin
            ObjUnit:=@UserCastle.m_Archer[n10];
            ObjUnit.BaseObject:=UserEngine.RegenMonsterByName(UserCastle.m_sMapName,
                                                            ObjUnit.nX,
                                                            ObjUnit.nY,
                                                            ObjUnit.sName);
            if ObjUnit.BaseObject <> nil then begin
              Dec(UserCastle.m_nTotalGold,g_Config.nHireArcherPrice);
              ObjUnit.BaseObject.m_Castle:=UserCastle;
              TGuardUnit(ObjUnit.BaseObject).m_nX550:=ObjUnit.nX;
              TGuardUnit(ObjUnit.BaseObject).m_nY554:=ObjUnit.nY;
              TGuardUnit(ObjUnit.BaseObject).m_n558:=3;
              PlayObject.SysMsg('雇佣成功.',c_Green,t_Hint);
            end;

          end else begin
            PlayObject.SysMsg('现在无法雇佣！！！',c_Red,t_Hint);
          end;
        end else begin
          PlayObject.SysMsg('早已雇佣！！！',c_Red,t_Hint);
        end;
      end else begin
        PlayObject.SysMsg('指令错误！！！',c_Red,t_Hint);
      end;
    end else begin
      PlayObject.SysMsg('城内资金不足！！！',c_Red,t_Hint);
    end;
    }
  except
    MainOutMessage('[Exception] TCastleOfficial.HireArcher');
  end;
end;
{ TMerchant }

procedure TMerchant.AddItemPrice(nIndex: Integer; nPrice: Integer); //0049F2AC
var
  ItemPrice: pTItemPrice;
begin
  try
    New(ItemPrice);
    ItemPrice.wIndex := nIndex;
    ItemPrice.nPrice := nPrice;
    m_ItemPriceList.Add(ItemPrice);
    FrmDB.SaveGoodPriceRecord(Self, m_sScript + '-' + m_sMapName);
  except
    MainOutMessage('[Exception] TMerchant.AddItemPrice');
  end;
end;

procedure TMerchant.CheckItemPrice(nIndex: Integer); //0049F1BC
var
  I: Integer;
  ItemPrice: pTItemPrice;
  //n10:Integer;
  StdItem: TItem;
begin
  try
    for I := 0 to m_ItemPriceList.Count - 1 do
    begin
      ItemPrice := m_ItemPriceList.Items[i];
      if ItemPrice.wIndex = nIndex then
      begin
        {n10:=ItemPrice.nPrice;
        if ROUND(n10 * 1.1) > n10 then begin
          n10:=ROUND(n10 * 1.1);
        end else Inc(n10);}
        exit;
      end;
    end;
    StdItem := UserEngine.GetStdItem(nIndex);
    if StdItem <> nil then
    begin
      AddItemPrice(nIndex, ROUND(StdItem.Price * 1.1));
    end;
  except
    MainOutMessage('[Exception] TMerchant.CheckItemPrice');
  end;
end;

function TMerchant.GetRefillList(nIndex: Integer): TList; //0049F118
var
  I: Integer;
  List: TList;
begin
  try
    Result := nil;
    if nIndex <= 0 then
      exit;
    for I := 0 to m_GoodsList.Count - 1 do
    begin
      List := TList(m_GoodsList.Items[i]);
      if List.Count > 0 then
      begin
        if pTUserItem(List.Items[0]).wIndex = nIndex then
        begin
          Result := List;
          Break;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TMerchant.GetRefillList');
  end;
end;

procedure TMerchant.RefillGoods; //0049F950
  procedure RefillItems(var List: TList; sItemName: string; nInt: Integer);
    //0049F824
  var
    I: Integer;
    UserItem: pTUserItem;
  begin
    if List = nil then
    begin
      List := TList.Create;
      m_GoodsList.Add(List);
    end;
    for I := 0 to nInt - 1 do
    begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
      begin
        List.Insert(0, UserItem);
      end
      else
      begin
        Dispose(UserItem);
        break;
      end;
    end;
  end;
  procedure DelReFillItem(var List: TList; nInt: Integer); //0049F8F8
  var
    I: Integer;
  begin
    for I := List.Count - 1 downto 0 do
    begin
      if nInt <= 0 then
        break;
      Dispose(pTUserItem(List.Items[i]));
      List.Delete(i);
      Dec(nInt);
    end;
  end;

var
  I {,II}: Integer;
  Goods: pTGoods;
  nIndex, nRefillCount: Integer;
  RefillList {,RefillList20}: TList;
  //  bo21:Boolean;
resourcestring
  sExceptionMsg = '[Exception] TMerchant::RefillGoods %s/%d:%d [%s] Code:%d';
begin //0049F950
  try
    for I := 0 to m_RefillGoodsList.Count - 1 do
    begin
      Goods := m_RefillGoodsList.Items[i];

      if (GetTickCount - Goods.dwRefillTick) > Goods.dwRefillTime then
      begin
        Goods.dwRefillTick := GetTickCount();
        nIndex := UserEngine.GetStdItemIdx(Goods.sItemName);
        if nIndex >= 0 then
        begin
          //memo.Lines.Add('test');
          RefillList := GetRefillList(nIndex);
          nRefillCount := 0;
          if RefillList <> nil then
            nRefillCount := RefillList.Count;
          if Goods.nCount > nRefillCount then
          begin
            CheckItemPrice(nIndex);
            RefillItems(RefillList, Goods.sItemName, Goods.nCount - nRefillCount)
              {0714修改限制每次刷新最大为200个};
            FrmDB.SaveGoodRecord(Self, m_sScript + '-' + m_sMapName);
            FrmDB.SaveGoodPriceRecord(Self, m_sScript + '-' + m_sMapName);
          end;
          {if Goods.nCount < nRefillCount then begin
            DelReFillItem(RefillList,nRefillCount - Goods.nCount);
            FrmDB.SaveGoodRecord(Self,m_sScript + '-' + m_sMapName);
            FrmDB.SaveGoodPriceRecord(Self,m_sScript + '-' + m_sMapName);
          end; }
        end; //0049FB83
      end;
    end;
    {for I := 0 to m_GoodsList.Count - 1 do begin
      RefillList20:=TList(m_GoodsList.Items[I]);
      if RefillList20.Count > 1000 then begin
        bo21:=False;
        for II := 0 to m_RefillGoodsList.Count - 1 do begin
          Goods:=m_RefillGoodsList.Items[II];
          nIndex:=UserEngine.GetStdItemIdx(Goods.sItemName);
          if pTItemPrice(RefillList20.Items[0]).wIndex = nIndex then begin
            bo21:=True;
            break;
          end;
        end;
        if not bo21 then begin
          DelReFillItem(RefillList20,RefillList20.Count - 1000);
        end else begin
          DelReFillItem(RefillList20,RefillList20.Count - 5000);
        end;
      end; //0049FC79
    end;}
  except
    on e: Exception do
      MainOutMessage(format(sExceptionMsg, [m_sCharName, m_nCurrX, m_nCurrY,
        e.Message, nCheck]));
  end;
end;

function TMerchant.CheckItemType(nStdMode: Integer): Boolean; //0049F374
var
  I: Integer;
begin
  try
    Result := False;
    for I := 0 to m_ItemTypeList.Count - 1 do
    begin
      if Integer(m_ItemTypeList.Items[i]) = nStdMode then
      begin
        Result := True;
        break;
      end;
    end;
  except
    MainOutMessage('[Exception] TMerchant.RefillGoods');
  end;
end;

function TMerchant.GetItemPrice(nIndex: Integer): Integer; //0049F374
var
  I: Integer;
  ItemPrice: pTItemPrice;
  StdItem: TItem;
begin
  try
    Result := -1;
    for I := 0 to m_ItemPriceList.Count - 1 do
    begin
      ItemPrice := m_ItemPriceList.Items[i];
      if ItemPrice.wIndex = nIndex then
      begin
        Result := ItemPrice.nPrice;
        break;
      end;
    end; // for
    if Result < 0 then
    begin
      StdItem := UserEngine.GetStdItem(nIndex);
      if StdItem <> nil then
      begin
        if CheckItemType(StdItem.StdMode) then
          Result := StdItem.Price;
      end;
    end;
  except
    MainOutMessage('[Exception] TMerchant.GetItemPrice');
  end;
end;

procedure TMerchant.SaveUpgradingList(); //0049FF84
begin
  try
    try
      //FrmDB.SaveUpgradeWeaponRecord(m_sCharName,m_UpgradeWeaponList);
      FrmDB.SaveUpgradeWeaponRecord(m_sScript + '-' + m_sMapName,
        m_UpgradeWeaponList);
    except
      MainOutMessage('Failure in saving upgradinglist - ' + m_sCharName);
    end;
  except
    MainOutMessage('[Exception] TMerchant.SaveUpgradingList');
  end;
end;

procedure TMerchant.UpgradeWapon(User: TPlayObject); //004A0920
  procedure sub_4A0218(ItemList: TList; var btDc: Byte; var btSc: Byte; var
    btMc: Byte; var btDura: Byte);
  var
    I, II: Integer;
    DuraList: TList;
    UserItem: pTUserItem;
    StdItem: TItem;
    StdItem80: TStdItem;
    DelItemList: TStringList;
    nDc, nSc, nMc, nDcMin, nDcMax, nScMin, nScMax, nMcMin, nMcMax, nDura,
      nItemCount: Integer;
  begin
    nDcMin := 0;
    nDcMax := 0;
    nScMin := 0;
    nScMax := 0;
    nMcMin := 0;
    nMcMax := 0;
    nDura := 0;
    nItemCount := 0;
    DelItemList := nil;
    DuraList := TList.Create;
    for I := ItemList.Count - 1 downto 0 do
    begin
      UserItem := ItemList.Items[I];
      if UserEngine.GetStdItemName(UserItem.wIndex) = g_Config.sBlackStone then
      begin
        DuraList.Add(Pointer(ROUND(UserItem.Dura / 1.0E3)));
        if DelItemList = nil then
          DelItemList := TStringList.Create;
        DelItemList.AddObject(g_Config.sBlackStone,
          TObject(UserItem.MakeIndex));
        DisPose(UserItem);
        ItemList.Delete(I);
      end
      else
      begin
        if IsAccessory(UserItem.wIndex) then
        begin
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem <> nil then
          begin
            StdItem.GetStandardItem(StdItem80);
            StdItem.GetItemAddValue(UserItem, StdItem80);
            nDc := 0;
            nSc := 0;
            nMc := 0;
            case StdItem80.StdMode of
              19, 20, 21:
                begin //004A0421
                  nDc := HiWord(StdItem80.DC) + LoWord(StdItem80.DC);
                  nSc := HiWord(StdItem80.SC) + LoWord(StdItem80.SC);
                  nMc := HiWord(StdItem80.MC) + LoWord(StdItem80.MC);
                end;
              22, 23:
                begin //004A046E
                  nDc := HiWord(StdItem80.DC) + LoWord(StdItem80.DC);
                  nSc := HiWord(StdItem80.SC) + LoWord(StdItem80.SC);
                  nMc := HiWord(StdItem80.MC) + LoWord(StdItem80.MC);
                end;
              24, 26:
                begin
                  nDc := HiWord(StdItem80.DC) + LoWord(StdItem80.DC) + 1;
                  nSc := HiWord(StdItem80.SC) + LoWord(StdItem80.SC) + 1;
                  nMc := HiWord(StdItem80.MC) + LoWord(StdItem80.MC) + 1;
                end;
            end;
            if nDcMin < nDc then
            begin
              nDcMax := nDcMin;
              nDcMin := nDc;
            end
            else
            begin
              if nDcMax < nDc then
                nDcMax := nDc;
            end;
            if nScMin < nSc then
            begin
              nScMax := nScMin;
              nScMin := nSc;
            end
            else
            begin
              if nScMax < nSc then
                nScMax := nSc;
            end;
            if nMcMin < nMc then
            begin
              nMcMax := nMcMin;
              nMcMin := nMc;
            end
            else
            begin
              if nMcMax < nMc then
                nMcMax := nMc;
            end;
            if DelItemList = nil then
              DelItemList := TStringList.Create;
            DelItemList.AddObject(StdItem.Name, TObject(UserItem.MakeIndex));
            //004A06DB
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('26' + #9 +
                User.m_sMapName + #9 +
                IntToStr(User.m_nCurrX) + #9 +
                IntToStr(User.m_nCurrY) + #9 +
                User.m_sCharName + #9 +
                //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                StdItem.Name + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                '0');
            DisPose(UserItem);
            ItemList.Delete(I);
          end;
        end;
      end;
    end; // for
    for I := 0 to DuraList.Count - 1 do
    begin
      for II := DuraList.Count - 1 downto i + 1 do
      begin
        if Integer(DuraList.Items[II]) > Integer(DuraList.Items[II - 1]) then
          DuraList.Exchange(II, II - 1);
      end; // for
    end; // for
    for I := 0 to DuraList.Count - 1 do
    begin
      nDura := nDura + Integer(DuraList.Items[I]);
      Inc(nItemCount);
      if nItemCount >= 5 then
        break;
    end;
    btDura := ROUND(_MIN(5, nItemCount) + _MIN(5, nItemCount) * ((nDura /
      nItemCount) / 5.0));
    btDc := nDcMin div 5 + nDcMax div 3;
    btSc := nScMin div 5 + nScMax div 3;
    btMc := nMcMin div 5 + nMcMax div 3;
    if DelItemList <> nil then
      User.SendMsg(Self, RM_SENDDELITEMLIST, 0, Integer(DelItemList), 0, 0, '');

    if DuraList <> nil then
      DuraList.Free;

  end;
var
  I: Integer;
  bo0D: Boolean;
  UpgradeInfo: pTUpgradeInfo;
  StdItem: TItem;
begin
  try
    bo0D := False;
    for I := 0 to m_UpgradeWeaponList.Count - 1 do
    begin
      UpgradeInfo := m_UpgradeWeaponList.Items[I];
      if UpgradeInfo.sUserName = User.m_sCharName then
      begin
        GotoLable(User, sUPGRADEING, False);
        exit;
      end;
    end;
    if (User.m_UseItems[U_WEAPON].wIndex <> 0) and (User.m_nGold >=
      g_Config.nUpgradeWeaponPrice) and
      (User.CheckItems(g_Config.sBlackStone) <> nil) then
    begin
      StdItem := UserEngine.GetStdItem(User.m_UseItems[U_WEAPON].wIndex);
      if StdItem.nRule[RULE_NOLEVEL] then
      begin
        SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0,
          '你身上的武器禁止在此处升级！！');
        exit;
      end;
      User.DecGold(g_Config.nUpgradeWeaponPrice);
      //    if m_boCastle or g_Config.boGetAllNpcTax then UserCastle.IncRateGold(g_Config.nUpgradeWeaponPrice);
      if m_boCastle or g_Config.boGetAllNpcTax then
      begin
        if m_Castle <> nil then
        begin
          TUserCastle(m_Castle).IncRateGold(g_Config.nUpgradeWeaponPrice);
        end
        else if g_Config.boGetAllNpcTax then
        begin
          g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
        end;
      end;
      User.GoldChanged();
      New(UpgradeInfo);
      UpgradeInfo.sUserName := User.m_sCharName;
      UpgradeInfo.UserItem := User.m_UseItems[U_WEAPON];

      //004A0B2F
      if StdItem.NeedIdentify = 1 then
        AddGameDataLog('25' + #9 +
          User.m_sMapName + #9 +
          IntToStr(User.m_nCurrX) + #9 +
          IntToStr(User.m_nCurrY) + #9 +
          User.m_sCharName + #9 +
          //UserEngine.GetStdItemName(User.m_UseItems[U_WEAPON].wIndex) + #9 +
          StdItem.Name + #9 +
          IntToStr(User.m_UseItems[U_WEAPON].MakeIndex) + #9 +
          '1' + #9 +
          '0');
      User.SendDelItems(@User.m_UseItems[U_WEAPON]);
      User.m_UseItems[U_WEAPON].wIndex := 0;
      User.RecalcAbilitys();
      User.FeatureChanged();
      User.SendMsg(User, RM_ABILITY, 0, 0, 0, 0, '');
      sub_4A0218(User.m_ItemList, UpgradeInfo.btDc, UpgradeInfo.btSc,
        UpgradeInfo.btMc, UpgradeInfo.btDura);
      UpgradeInfo.dtTime := Now();
      UpgradeInfo.dwGetBackTick := GetTickCount();
      m_UpgradeWeaponList.Add(UpgradeInfo);
      SaveUpgradingList();
      bo0D := True;
    end;
    if bo0D then
      GotoLable(User, sUPGRADEOK, False)
    else
      GotoLable(User, sUPGRADEFAIL, False);
  except
    MainOutMessage('[Exception] TMerchant.UpgradeWapon');
  end;
end;

procedure TMerchant.GetBackupgWeapon(User: TPlayObject); //004A0CB8
var
  I: Integer;
  UpgradeInfo: pTUpgradeInfo;
  n10, {n14,} n18, n1C, n90: Integer;
  UserItem: pTUserItem;
  StdItem: TItem;
begin
  try
    n18 := 0;
    UpgradeInfo := nil;
    if not User.IsEnoughBag then
    begin
      //    User.SysMsg('你的背包已经满了，无法再携带任何物品了！！！',0);
      GotoLable(User, sGETBACKUPGFULL, False);
      exit;
    end;
    for I := 0 to m_UpgradeWeaponList.Count - 1 do
    begin
      if pTUpgradeInfo(m_UpgradeWeaponList.Items[I]).sUserName = User.m_sCharName
        then
      begin
        n18 := 1;
        if ((GetTickCount -
          pTUpgradeInfo(m_UpgradeWeaponList.Items[I]).dwGetBackTick) >
          g_Config.dwUPgradeWeaponGetBackTime) or (User.m_btPermission >= 4)
            then
        begin
          UpgradeInfo := m_UpgradeWeaponList.Items[I];
          m_UpgradeWeaponList.Delete(I);
          SaveUpgradingList();
          n18 := 2;
          break;
        end;
      end;
    end;
    //004A0DC2
    if UpgradeInfo <> nil then
    begin
      case UpgradeInfo.btDura of //
        0..8:
          begin //004A0DE5
            //       n14:=_MAX(3000,UpgradeInfo.UserItem.DuraMax shr 1);
            if UpgradeInfo.UserItem.DuraMax > 3000 then
            begin
              Dec(UpgradeInfo.UserItem.DuraMax, 3000);
            end
            else
            begin
              UpgradeInfo.UserItem.DuraMax := UpgradeInfo.UserItem.DuraMax shr
                1;
            end;
            if UpgradeInfo.UserItem.Dura > UpgradeInfo.UserItem.DuraMax then
              UpgradeInfo.UserItem.Dura := UpgradeInfo.UserItem.DuraMax;
          end;
        9..15:
          begin //004A0E41
            if Random(UpgradeInfo.btDura) < 6 then
            begin
              if UpgradeInfo.UserItem.DuraMax > 1000 then
                Dec(UpgradeInfo.UserItem.DuraMax, 1000);
              if UpgradeInfo.UserItem.Dura > UpgradeInfo.UserItem.DuraMax then
                UpgradeInfo.UserItem.Dura := UpgradeInfo.UserItem.DuraMax;
            end;

          end;
        18..255:
          begin
            case Random(UpgradeInfo.btDura - 18) of
              1..4: Inc(UpgradeInfo.UserItem.DuraMax, 1000);
              5..7: Inc(UpgradeInfo.UserItem.DuraMax, 2000);
              8..255: Inc(UpgradeInfo.UserItem.DuraMax, 4000)
            end;
          end;
      end; // case
      if (UpgradeInfo.btDc = UpgradeInfo.btMc) and (UpgradeInfo.btMc =
        UpgradeInfo.btSc) then
      begin
        n1C := Random(3);
      end
      else
      begin
        n1C := -1;
      end;
      if ((UpgradeInfo.btDc >= UpgradeInfo.btMc) and (UpgradeInfo.btDc >=
        UpgradeInfo.btSc)) or
        (n1C = 0) then
      begin
        n90 := _MIN(11, UpgradeInfo.btDc);
        n10 := _MIN(85, n90 shl 3 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] -
          UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);
        //      n10:=_MIN(85,n90 * 8 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] - UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);

        if Random(g_Config.nUpgradeWeaponDCRate) < n10 then
        begin //if Random(100) < n10 then begin
          UpgradeInfo.UserItem.btValue[10] := 10;

          if (n10 > 63) and (Random(g_Config.nUpgradeWeaponDCTwoPointRate) = 0)
            then //if (n10 > 63) and (Random(30) = 0) then
            UpgradeInfo.UserItem.btValue[10] := 11;

          if (n10 > 79) and (Random(g_Config.nUpgradeWeaponDCThreePointRate) = 0)
            then //if (n10 > 79) and (Random(200) = 0) then
            UpgradeInfo.UserItem.btValue[10] := 12;
        end
        else
          UpgradeInfo.UserItem.btValue[10] := 1; //004A0F89
      end;

      if ((UpgradeInfo.btMc >= UpgradeInfo.btDc) and (UpgradeInfo.btMc >=
        UpgradeInfo.btSc)) or
        (n1C = 1) then
      begin
        n90 := _MIN(11, UpgradeInfo.btMc);
        n10 := _MIN(85, n90 shl 3 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] -
          UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);

        if Random(g_Config.nUpgradeWeaponMCRate) < n10 then
        begin //if Random(100) < n10 then begin
          UpgradeInfo.UserItem.btValue[10] := 20;

          if (n10 > 63) and (Random(g_Config.nUpgradeWeaponMCTwoPointRate) = 0)
            then //if (n10 > 63) and (Random(30) = 0) then
            UpgradeInfo.UserItem.btValue[10] := 21;

          if (n10 > 79) and (Random(g_Config.nUpgradeWeaponMCThreePointRate) = 0)
            then //if (n10 > 79) and (Random(200) = 0) then
            UpgradeInfo.UserItem.btValue[10] := 22;
        end
        else
          UpgradeInfo.UserItem.btValue[10] := 1;
      end;

      if ((UpgradeInfo.btSc >= UpgradeInfo.btMc) and (UpgradeInfo.btSc >=
        UpgradeInfo.btDc)) or
        (n1C = 2) then
      begin
        n90 := _MIN(11, UpgradeInfo.btMc);
        n10 := _MIN(85, n90 shl 3 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] -
          UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);

        if Random(g_Config.nUpgradeWeaponSCRate) < n10 then
        begin //if Random(100) < n10 then begin
          UpgradeInfo.UserItem.btValue[10] := 30;

          if (n10 > 63) and (Random(g_Config.nUpgradeWeaponSCTwoPointRate) = 0)
            then //if (n10 > 63) and (Random(30) = 0) then
            UpgradeInfo.UserItem.btValue[10] := 31;

          if (n10 > 79) and (Random(g_Config.nUpgradeWeaponSCThreePointRate) = 0)
            then //if (n10 > 79) and (Random(200) = 0) then
            UpgradeInfo.UserItem.btValue[10] := 32;
        end
        else
          UpgradeInfo.UserItem.btValue[10] := 1;
      end;
      New(UserItem);
      UserItem^ := UpgradeInfo.UserItem;
      DisPose(UpgradeInfo);
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      //004A120E
      if StdItem.NeedIdentify = 1 then
        AddGameDataLog('24' + #9 +
          User.m_sMapName + #9 +
          IntToStr(User.m_nCurrX) + #9 +
          IntToStr(User.m_nCurrY) + #9 +
          User.m_sCharName + #9 +
          //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
          StdItem.Name + #9 +
          IntToStr(UserItem.MakeIndex) + #9 +
          '1' + #9 +
          '0');
      User.AddItemToBag(UserItem);
      User.SendAddItem(UserItem);
    end;
    case n18 of //
      0: GotoLable(User, sGETBACKUPGFAIL, False);
      1: GotoLable(User, sGETBACKUPGING, False);
      2: GotoLable(User, sGETBACKUPGOK, False);
    end; // case

  except
    MainOutMessage('[Exception] TMerchant.GetBackupgWeapon');
  end;
end;

function TMerchant.GetUserPrice(PlayObject: TPlayObject; nPrice: Integer):
  Integer; //0049F6E0
var
  n14: Integer;
begin
  try
    {
    if m_boCastle then begin
      if UserCastle.IsMasterGuild(TGuild(PlayObject.m_MyGuild)) then begin
        n14:=_MAX(60,ROUND(m_nPriceRate * 8.0000000000000000001e-1));//80%
        Result:=ROUND(nPrice / 1.0e2 * n14); //100
      end else begin
        Result:=ROUND(nPrice / 1.0e2 * m_nPriceRate);
      end;
    end else begin
      Result:=ROUND(nPrice / 1.0e2 * m_nPriceRate);
    end;
    }
    if m_boCastle then
    begin
      //    if UserCastle.IsMasterGuild(TGuild(PlayObject.m_MyGuild)) then begin
      if (m_Castle <> nil) and
        TUserCastle(m_Castle).IsMasterGuild(TGuild(PlayObject.m_MyGuild)) then
      begin
        n14 := _MAX(60, ROUND(m_nPriceRate * (g_Config.nCastleMemberPriceRate /
          100))); //80%
        Result := ROUND(nPrice / 100 * n14); //100
      end
      else
      begin
        Result := ROUND(nPrice / 100 * m_nPriceRate);
      end;
    end
    else
    begin
      Result := ROUND(nPrice / 100 * m_nPriceRate);
    end;
  except
    MainOutMessage('[Exception] TMerchant.GetUserPrice');
  end;
end;

procedure TMerchant.UserSelect(PlayObject: TPlayObject; sData: string);
//004A1820
  procedure SuperRepairItem(User: TPlayObject); //004A159C
  begin
    User.SendMsg(Self, RM_SENDUSERSREPAIR, 0, Integer(Self), 0, 0, '');
  end;
  procedure BuyItem(User: TPlayObject; nInt: integer); //004A1378
  var
    I, n10, nStock, nPrice: Integer;
    nSubMenu: ShortInt;
    sSendMsg, sName: string;
    UserItem: pTUserItem;
    StdItem: TItem;
    List14: TList;
    //    sUserItemName:String;
  begin
    sSendMsg := '';
    n10 := 0;
    for I := 0 to m_GoodsList.Count - 1 do
    begin
      List14 := TList(m_GoodsList.Items[i]);
      UserItem := List14.Items[0];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      //MainOutMessage('到期1');
      if StdItem <> nil then
      begin
        //MainOutMessage('到期2');
        //取自定义物品名称
        sName := GetItemName(UserItem);

        nPrice := GetUserPrice(User, GetItemPrice(UserItem.wIndex));
        nStock := List14.Count;
        if (StdItem.StdMode <= 4) or
          (StdItem.StdMode = 42) or
          (StdItem.StdMode = 31) then
          nSubMenu := 0
        else
          nSubMenu := 1;
        sSendMsg := sSendMsg + sName + '/' + IntToStr(nSubMenu) + '/' +
          IntToStr(nPrice) + '/' + IntToStr(nStock) + '/';
        //MainOutMessage(sSendMsg);
        Inc(n10);
      end; // else MainOutMessage('到期3');
    end; // for
    User.SendMsg(Self, RM_SENDGOODSLIST, 0, Integer(Self), n10, 0, sSendMsg);
    //MainOutMessage(sSendMsg);
  end;
  procedure SellItem(User: TPlayObject; nSell: Integer); //004A1544
  begin
    User.SendMsg(Self, RM_SENDUSERSELL, 0, Integer(Self), nSell, 0, '');
  end;
  procedure RepairItem(User: TPlayObject); //004A1570
  begin
    User.SendMsg(Self, RM_SENDUSERREPAIR, 0, Integer(Self), 0, 0, '');
  end;
  procedure MakeDurg(User: TPlayObject); //004A16A0
  var
    I: Integer;
    List14: TList;
    UserItem: pTUserItem;
    StdItem: TItem;
    sSendMsg: string;
    //    nSubMenu:Integer;
    //    nPrice:Integer;
    //    nStock:Integer;
  begin
    sSendMsg := '';
    for I := 0 to m_GoodsList.Count - 1 do
    begin
      List14 := TList(m_GoodsList.Items[i]);
      if List14.Count <= 0 then
        Continue; //0807 增加，防止在制药物品列表为空时出错
      UserItem := List14.Items[0];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem <> nil then
      begin
        sSendMsg := sSendMsg + StdItem.Name + '/' + IntToStr(0) + '/' +
          IntToStr(g_Config.nMakeDurgPrice) + '/' + IntToStr(1) + '/';
      end;
    end;
    if sSendMsg <> '' then
      User.SendMsg(Self, RM_USERMAKEDRUGITEMLIST, 0, Integer(Self), 0, 0,
        sSendMsg);
  end;
  procedure ItemPrices(User: TPlayObject); //
  begin

  end;
  procedure Storage(User: TPlayObject); //004A1648
  begin
    User.SendMsg(Self, RM_USERSTORAGEITEM, 0, Integer(Self), 0, 0, '');
  end;
  procedure PlayDrink(User: TPlayObject); //004A1648
  begin
    User.SendMsg(Self, RM_PLAYDRINK, 0, Integer(Self), 0, 0, '');
  end;
  procedure GetBack(User: TPlayObject); //004A1674
  begin
    User.SendMsg(Self, RM_USERGETBACKITEM, 0, Integer(Self), 0, 0, '');
  end;
var
  sLabel, s18, sMsg, sTemp, sVal, sName, sPic: string;
  boCanJmp: Boolean;
  nCheckCode, nVal: Byte;
  I: Integer;
resourcestring
  sExceptionMsg = '[Exception] TMerchant::UserSelect... Data: %s %d';
begin //004A1820
  inherited;
  if not (ClassNameIs(TMerchant.ClassName)) then
    exit; //如果类名不是 TMerchant 则不执行以下处理函数
  nCheckCode := 0;
  try
    //    PlayObject.m_nScriptGotoCount:=0;
    //    if not m_boCastle or not UserCastle.m_boUnderWar then begin
    nCheckCode := 0;
    if not m_boCastle or not ((m_Castle <> nil) and
      TUserCastle(m_Castle).m_boUnderWar) then
    begin
      nCheckCode := 1;
      if {not PlayObject.m_boDeath and}(sData <> '') and (sData[1] = '@') then
      begin
        nCheckCode := 2;
        sMsg := GetValidStr3(sData, sLabel, [#13]);
        PlayObject.m_ServerStrVal[0] := sMsg;
        s18 := '';
        PlayObject.m_sScriptLable := sData;
        nCheckCode := 3;
        boCanJmp := PlayObject.LableIsCanJmp(sLabel);
        nCheckCode := 4;
        if CompareText(sLabel, sSL_SENDMSG) = 0 then
        begin
          if sMsg = '' then
            exit;
        end;
        if CompareText(sLabel, sSL_BUHERO) = 0 then
        begin
          if (not m_boHero) or (sMsg = '') then
            exit;
        end;
        if CompareLStr(sLabel, sSL_BATCHBUY, length(sSL_BATCHBUY) {@@BatchBuy})
          then
        begin
          I := Str_ToInt(sMsg, 0);
          if I > 0 then
          begin
            sTemp := ArrestStringEx(sLabel, '(', ')', sVal);
            sPic := GetValidStr3(sVal, sName, [',']);
            sVal := GetValidStr3(sLabel, sTemp, ['(']);
            s18 := Copy(sTemp, Length(sSL_BATCHBUY) + 1, Length(sSL_BATCHBUY));
            PlayObject.m_ServerIntVal[0] := I;
            PlayObject.m_ServerIntVal[1] := I * Integer(Str_ToInt(sPic, 0));
            PlayObject.m_ServerStrVal[1] := sName;
            //MainOutMessage(Format('%s %s %s %s %s',[sTemp,s18,sVal,sName,sPic]));
            GotoLable(PlayObject, '@BatchBuy' + s18, False);
            exit;
          end;
          GotoLable(PlayObject, '@BatchBuyFail', False);
          exit;
        end;
        if CompareText(sLabel, sSL_DEALGOLD) = 0 then
        begin
          if m_boDealGold and (PlayObject.m_DealGoldBase <> nil) and
            (PlayObject.m_DealGoldBase.m_btRaceServer = RC_PLAYOBJECT) then
          begin
            i := Str_ToInt(sMsg, -1);
            if I > 0 then
            begin
              if PlayObject.m_nGameGold >= I then
              begin
                Dec(PlayObject.m_nGameGold, I);
                Inc(TPlayObject(PlayObject.m_DealGoldBase).m_nGameGold, I);
                PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self),
                  0, 0, '');
                PlayObject.SysMsg(Format(g_sDealGoldOk,
                  [PlayObject.m_DealGoldBase.m_sCharName, I]), c_Red, t_System);
                PlayObject.m_DealGoldBase.SysMsg(Format(g_sDealGoldPostOk,
                  [PlayObject.m_sCharName, I]), c_Red, t_System);
                PlayObject.GameGoldChanged;
                PlayObject.m_DealGoldBase.GameGoldChanged;
                PlayObject.m_DealGoldBase := nil;
                exit;
              end;
              PlayObject.m_DealGoldBase := nil;
              GotoLable(PlayObject, '@dealgoldFail', False);
              exit;
            end;
            PlayObject.m_DealGoldBase := nil;
            GotoLable(PlayObject, '@dealgoldPlayError', False);
            exit;
          end;
          PlayObject.m_DealGoldBase := nil;
          GotoLable(PlayObject, '@dealgoldInputFail', False);
          exit;
        end;
        if CompareLStr(Uppercase(sLabel), sSL_INPUTSTRING,
          Length(sSL_INPUTSTRING)) then
        begin
          if m_boInPutString then
          begin
            if CheckFilterList(sMsg) then
            begin
              GotoLable(PlayObject, sSL_ISINFILTERLIST, False);
            end
            else
            begin
              sTemp := Copy(sLabel, 2, Length(sLabel) - 1);
              sVal := Copy(sLabel, Length(sSL_INPUTSTRING) + 1, Length(sLabel) -
                Length(sSL_INPUTSTRING));
              nVal := Str_ToInt(sVal, 0);
              if (nVal > 99) then
                nVal := 0;
              PlayObject.m_StrVal[nVal] := sMsg;
              GotoLable(PlayObject, sTemp, False);
            end;
          end;
          exit;
        end;
        if CompareLStr(Uppercase(sLabel), sSL_INPUTINTEGER,
          Length(sSL_INPUTINTEGER)) then
        begin
          if m_boInPutInteger then
          begin
            sTemp := Copy(sLabel, 2, Length(sLabel) - 1);
            sVal := Copy(sLabel, Length(sSL_INPUTINTEGER) + 1, Length(sLabel) -
              Length(sSL_INPUTINTEGER));
            nVal := Str_ToInt(sVal, 0);
            if (nVal > 99) then
              nVal := 0;
            PlayObject.m_DyValEx[nVal] := _MIN(High(Integer), Str_ToInt(sMsg,
              0));
            GotoLable(PlayObject, sTemp, False);
          end;
          exit;
        end;
        nCheckCode := 5;
        GotoLable(PlayObject, sLabel, not boCanJmp);
        nCheckCode := 6;
        if not boCanJmp then
          exit;

        //先执行标签再实现功能，如仓库取物品
        {if CompareText(sLabel,sSL_BUHERO) = 0 then begin    //先检测是允许再执行标签,如召唤英雄
           if m_boHero then begin
              if CheckNameSafety(sMsg) then begin
                 g_FunctionNPC.GotoLable(PlayObject,sSE_HeroNameFilter,boCanJmp);
              end else PlayObject.m_CreateHeroName:=sMsg;
           end else PlayObject.m_CreateHeroName:='';
        end else }
        nCheckCode := 7;
        if CompareText(sLabel, sSL_BUHERO) = 0 then
        begin
          PlayObject.m_CreateHeroName := sMsg;
        end
        else if CompareText(sLabel, sSL_SENDMSG) = 0 then
        begin
          if m_boSendmsg then
            SendCustemMsg(PlayObject, sMsg);
        end
        else if CompareText(sLabel, sSUPERREPAIR) = 0 then
        begin
          if m_boS_repair then
            SuperRepairItem(PlayObject);
        end
        else if CompareText(sLabel, sBUY) = 0 then
        begin
          if m_boBuy then
            BuyItem(PlayObject, 0);
        end
        else if CompareText(sLabel, sSELL) = 0 then
        begin
          if m_boSell then
            SellItem(PlayObject, 0);
        end
        else if CompareText(sLabel, sSELLOFF) = 0 then
        begin
          if m_boSellOff then
            SellItem(PlayObject, 255);
        end
        else if CompareText(sLabel, sREPAIR) = 0 then
        begin
          if m_boRepair then
            RepairItem(PlayObject);
        end
        else if CompareText(sLabel, sMAKEDURG) = 0 then
        begin
          if m_boMakeDrug then
            MakeDurg(PlayObject);
        end
        else if CompareText(sLabel, sPRICES) = 0 then
        begin
          if m_boPrices then
            ItemPrices(PlayObject);
        end
        else if CompareText(sLabel, sSTORAGE) = 0 then
        begin
          if m_boStorage then
            Storage(PlayObject);
        end
        else if CompareText(sLabel, sPLAYDRINK) = 0 then
        begin
          if m_boPlayDrink then
            PlayDrink(PlayObject);
        end
        else if CompareText(sLabel, sGETBACK) = 0 then
        begin
          if m_boGetback then
            GetBack(PlayObject);
        end
        else if CompareText(sLabel, sUPGRADENOW) = 0 then
        begin
          if m_boUpgradenow then
            UpgradeWapon(PlayObject);
        end
        else if CompareText(sLabel, sGETBACKUPGNOW) = 0 then
        begin
          if m_boGetBackupgnow then
            GetBackupgWeapon(PlayObject);
        end
        else if CompareText(sLabel, sGETMARRY) = 0 then
        begin
          if m_boGetMarry then
            GetBackupgWeapon(PlayObject);
        end
        else if CompareText(sLabel, sGETMASTER) = 0 then
        begin
          if m_boGetMaster then
            GetBackupgWeapon(PlayObject);
        end
        else if CompareLStr(sLabel, sUSEITEMNAME, Length(sUSEITEMNAME)) then
        begin
          if m_boUseItemName then
            ChangeUseItemName(PlayObject, sLabel, sMsg);
        end
        else if CompareText(sLabel, sEXIT) = 0 then
        begin
          PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self), 0, 0,
            '');
        end
        else if CompareText(sLabel, sBACK) = 0 then
        begin
          nCheckCode := 8;
          if PlayObject.m_sScriptGoBackLable = '' then
            PlayObject.m_sScriptGoBackLable := sMAIN;
          nCheckCode := 9;
          GotoLable(PlayObject, PlayObject.m_sScriptGoBackLable, False);
          nCheckCode := 10;
        end;
      end; //004A1A3E
    end; //004A187E
  except
    MainOutMessage(format(sExceptionMsg, [sData, nCheckCode]));
  end;
end;

procedure TMerchant.Run(); //004A2ECC
var
  nCheckCode, nInteger: Integer;
  dwGoodsTick, dwDataTick: LongWord;
resourcestring
  sExceptionMsg1 = '[Exception] TMerchant::Run... Code = %d';
  sExceptionMsg2 = '[Exception] TMerchant::Run -> Move Code = %d';
begin
  try
    //inherited;
    //exit;
    nCheckCode := 0;
    try
      if (GetTickCount - dwRefillGoodsTick) > dwRefillGoodsTime then
      begin
        //if (GetTickCount - dwTick578) > 3000 then begin
        dwGoodsTick := GetTickCount;
        dwRefillGoodsTick := GetTickCount();
        RefillGoods();
        dwMerchantGoodsTimeMin := GetTickCount - dwGoodsTick;
        if dwMerchantGoodsTimeMin > dwMerchantGoodsTimeMax then
        begin
          dwMerchantGoodsTimeMax := dwMerchantGoodsTimeMin;
          dwMerchantGoodsName := m_sCharName;
        end;
      end;
      nCheckCode := 1;
      if (GetTickCount - dwClearExpreUpgradeTick) > 10 * 60 * 1000 then
      begin
        dwDataTick := GetTickCount;
        dwClearExpreUpgradeTick := GetTickCount();
        ClearExpreUpgradeListData();
        dwMerchantDataTimeMin := GetTickCount - dwDataTick;
        if dwMerchantDataTimeMin > dwMerchantDataTimeMax then
        begin
          dwMerchantDataTimeMax := dwMerchantDataTimeMin;
          dwMerchantDataName := m_sCharName;
        end;
      end;
      nCheckCode := 2;
      if not (m_wAppr in [55..69]) then
      begin
        if (Random(50) = 0) and (not (m_wAppr in [72..74])) then
        begin
          TurnTo(Random(8));
        end
        else
        begin
          if Random(50) = 0 then
          begin
            if not (m_wAppr in [72..74]) then
              SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '')
            else
              SendRefMsg(RM_HIT, 0, m_nCurrX, m_nCurrY, 0, '');
          end;
        end;
      end;
      nCheckCode := 3;
      //    if m_boCastle and (UserCastle.m_boUnderWar)then begin
      if m_boCastle and (m_Castle <> nil) and TUserCastle(m_Castle).m_boUnderWar
        then
      begin
        if not m_boFixedHideMode then
        begin
          SendRefMsg(RM_DISAPPEAR, 0, 0, 0, 0, '');
          m_boFixedHideMode := True;
        end;
      end
      else
      begin
        if m_boFixedHideMode then
        begin
          m_boFixedHideMode := False;
          SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
        end;
      end;
      nCheckCode := 4;
    except
      on e: Exception do
      begin
        MainOutMessage(format(sExceptionMsg1, [nCheckCode]));
        MainOutMessage(E.Message);
      end;
    end;
    try
      if m_boCanMove and (GetTickCount - m_dwMoveTick > m_dwMoveTime * 1000)
        then
      begin
        m_dwMoveTick := GetTickCount();
        SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
        MapRandomMove(m_sMapName, 0);
      end;
      if m_boCanAutoColor = 1 then
      begin
        //宝宝变色
        if (GetTickCount - m_dwAutoChangeColorTick) > m_dwAutoColorTime then
        begin
          m_dwAutoChangeColorTick := GetTickCount();
          case m_nAutoChangeIdx of //
            0: nInteger := STATE_TRANSPARENT;
            1: nInteger := POISON_STONE;
            2: nInteger := POISON_DONTMOVE;
            3: nInteger := POISON_68;
            4: nInteger := POISON_DECHEALTH;
            5: nInteger := POISON_LOCKSPELL;
            6: nInteger := POISON_DAMAGEARMOR;
          else
            begin
              m_nAutoChangeIdx := 0;
              nInteger := STATE_TRANSPARENT;
            end;
          end;
          Inc(m_nAutoChangeIdx);
          m_nCharStatus := LongWord(m_nCharStatusEx and $FFFFF) or (($80000000
            shr nInteger) or 0);
          StatusChanged();
        end;
      end
      else if m_boCanAutoColor = 2 then
      begin
        m_boCanAutoColor := 0;
        case m_nAutoChangeIdx of //
          0: nInteger := STATE_TRANSPARENT;
          1: nInteger := POISON_STONE;
          2: nInteger := POISON_DONTMOVE;
          3: nInteger := POISON_68;
          4: nInteger := POISON_DECHEALTH;
          5: nInteger := POISON_LOCKSPELL;
          6: nInteger := POISON_DAMAGEARMOR;
        else
          nInteger := STATE_TRANSPARENT;
        end;
        m_nCharStatus := LongWord(m_nCharStatusEx and $FFFFF) or (($80000000 shr
          nInteger) or 0);
        StatusChanged();
      end;
    except
      on e: Exception do
      begin
        MainOutMessage(format(sExceptionMsg2, [nCheckCode]));
        MainOutMessage(E.Message);
      end;
    end;
    inherited;
  except
    MainOutMessage('[Exception] TMerchant.UserSelect');
  end;
end;

function TMerchant.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  try
    Result := inherited Operate(ProcessMsg);

  except
    MainOutMessage('[Exception] TMerchant.Operate');
  end;
end;

procedure TMerchant.LoadNPCData; //0049F044
var
  sFile: string;
begin
  try
    sFile := m_sScript + '-' + m_sMapName;
    FrmDB.LoadGoodRecord(Self, sFile);
    FrmDB.LoadGoodPriceRecord(Self, sFile);
    LoadUpgradeList();
  except
    MainOutMessage('[Exception] TMerchant.LoadNPCData');
  end;
end;

procedure TMerchant.SaveNPCData;
var
  sFile: string;
begin
  try
    sFile := m_sScript + '-' + m_sMapName;
    FrmDB.SaveGoodRecord(Self, sFile);
    FrmDB.SaveGoodPriceRecord(Self, sFile);
  except
    MainOutMessage('[Exception] TMerchant.SaveNPCData');
  end;
end;

constructor TMerchant.Create; //0049EC70
begin
  try
    inherited;
    m_btRaceImg := RCC_MERCHANT;
    m_wAppr := 0;
    m_nPriceRate := 100;
    m_boCastle := False;
    m_ItemTypeList := TList.Create;
    m_RefillGoodsList := TList.Create;
    m_GoodsList := TList.Create;
    m_ItemPriceList := TList.Create;
    m_UpgradeWeaponList := TList.Create;
    dwRefillGoodsTick := 0 {GetTickCount()};
    dwRefillGoodsTime := 30000 + Random(60000);
    dwClearExpreUpgradeTick := GetTickCount();
    m_boBuy := False;
    m_boSell := False;
    m_boSellOff := False;
    m_boMakeDrug := False;
    m_boPrices := False;
    m_boStorage := False;
    m_boPlayDrink := False;
    m_boGetback := False;
    m_boUpgradenow := False;
    m_boGetBackupgnow := False;
    m_boRepair := False;
    m_boS_repair := False;
    m_boGetMarry := False;
    m_boGetMaster := False;
    m_boUseItemName := False;
    m_dwMoveTick := GetTickCount();
    m_boCanAutoColor := 0;
    m_dwAutoColorTime := GetTickCount();
  except
    MainOutMessage('[Exception] TMerchant.Create');
  end;
end;

destructor TMerchant.Destroy; //0049ED70
var
  I: Integer;
  II: Integer;
  List: TList;
begin
  try
    m_ItemTypeList.Free;
    for I := 0 to m_RefillGoodsList.Count - 1 do
    begin
      DisPose(pTGoods(m_RefillGoodsList.Items[i]));
    end;
    m_RefillGoodsList.Free;
    for I := 0 to m_GoodsList.Count - 1 do
    begin
      List := TList(m_GoodsList.Items[I]);
      for II := 0 to List.Count - 1 do
      begin
        Dispose(pTUserItem(List.Items[II]));
      end;
      List.Free;
    end;
    m_GoodsList.Free;

    for I := 0 to m_ItemPriceList.Count - 1 do
    begin
      Dispose(pTItemPrice(m_ItemPriceList.Items[I]));
    end;
    m_ItemPriceList.Free;
    for I := 0 to m_UpgradeWeaponList.Count - 1 do
    begin
      Dispose(pTUpgradeInfo(m_UpgradeWeaponList.Items[I]));
    end;
    m_UpgradeWeaponList.Free;
    inherited;
  except
    MainOutMessage('[Exception] TMerchant.Destroy');
  end;
end;

procedure TMerchant.ClearExpreUpgradeListData; //004A01A0
var
  I: Integer;
  UpgradeInfo: pTUpgradeInfo;
begin
  try
    for I := m_UpgradeWeaponList.Count - 1 downto 0 do
    begin
      UpgradeInfo := m_UpgradeWeaponList.Items[I];
      if Integer(ROUND(Now - UpgradeInfo.dtTime)) >=
        g_Config.nClearExpireUpgradeWeaponDays then
      begin
        Dispose(UpgradeInfo);
        m_UpgradeWeaponList.Delete(I);
      end;
    end;
  except
    MainOutMessage('[Exception] TMerchant.ClearExpreUpgradeListData');
  end;
end;

procedure TMerchant.LoadNPCScript; //0049EF7C
var
  sC: string;
begin
  try
    m_ItemTypeList.Clear;
    m_sPath := sMarket_Def;
    sC := m_sScript + '-' + m_sMapName;
    FrmDB.LoadScriptFile(Self, sMarket_Def, sC, True);
    //  call    sub_49ABE0
  except
    on e: Exception do
    begin
      MainOutMessage('[Exception] TMerchant.LoadNPCScript');
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TMerchant.Click(PlayObject: TPlayObject); //0049FF24
begin
  try
    //  GotoLable(PlayObject,'@main');
    inherited;
  except
    MainOutMessage('[Exception] TMerchant.Click');
  end;
end;

procedure TMerchant.GetVariableText(PlayObject: TPlayObject;
  var sMsg: string; sVariable: string); //0049FD04
var
  sText {,s14}: string;
  //  n18:Integer;
begin
  try
    inherited;
    if sVariable = '$PRICERATE' then
    begin
      sText := IntToStr(m_nPriceRate);
      sMsg := sub_49ADB8(sMsg, '<$PRICERATE>', sText);
    end;
    if sVariable = '$UPGRADEWEAPONFEE' then
    begin
      sText := IntToStr(g_Config.nUpgradeWeaponPrice);
      sMsg := sub_49ADB8(sMsg, '<$UPGRADEWEAPONFEE>', sText);
    end;
    if sVariable = '$USERWEAPON' then
    begin
      if PlayObject.m_UseItems[U_WEAPON].wIndex <> 0 then
      begin
        sText :=
          UserEngine.GetStdItemName(PlayObject.m_UseItems[U_WEAPON].wIndex);
      end
      else
      begin
        sText := 'Weapon';
      end;
      sMsg := sub_49ADB8(sMsg, '<$USERWEAPON>', sText);
    end;

  except
    MainOutMessage('[Exception] TMerchant.GetVariableText');
  end;
end;
//取物品价格

function TMerchant.GetUserItemPrice(UserItem: pTUserItem): Integer; //0049F428
var
  n10: Integer;
  StdItem: TItem;
  n20: real;
  nC: Integer;
  n14: Integer;
begin
  try
    n10 := GetItemPrice(UserItem.wIndex);
    if n10 > 0 then
    begin
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (StdItem <> nil) and
        (StdItem.StdMode > 4) and
        (StdItem.DuraMax > 0) and
        (UserItem.DuraMax > 0) then
      begin
        if StdItem.StdMode = 40 then
        begin //肉
          if UserItem.Dura <= UserItem.DuraMax then
          begin
            n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax -
              UserItem.Dura));
            n10 := _MAX(2, ROUND(n10 - n20));
          end
          else
          begin
            n10 := n10 + ROUND(n10 / UserItem.DuraMax * 2.0 * (UserItem.Dura
              - UserItem.DuraMax));
            //修复肉的价格如果当前持久大于最大持久UserItem.DuraMax -UserItem.Dura
           //成了负数价格会比正常的减少
          end;
        end; //0049F528
        if (StdItem.StdMode = 43) then
        begin
          if UserItem.DuraMax < 10000 then
            UserItem.DuraMax := 10000;
          if UserItem.Dura <= UserItem.DuraMax then
          begin
            n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax -
              UserItem.Dura));
            n10 := _MAX(2, ROUND(n10 - n20));
          end
          else
          begin
            n10 := n10 + ROUND(n10 / UserItem.DuraMax * 1.3 * (UserItem.Dura
              - UserItem.DuraMax));
            //修复矿的价格如果当前持久大于最大持久UserItem.DuraMax -UserItem.Dura
            //成了负数价格会比正常的减少
          end;
        end; //0049F5C5
        if StdItem.StdMode > 4 then
        begin
          n14 := 0;
          nC := 0;
          while (True) do
          begin
            if (StdItem.StdMode = 5) or (StdItem.StdMode = 6) then
            begin
              if (nC <> 4) or (nC <> 9) then
              begin
                if nC = 6 then
                begin
                  if UserItem.btValue[nC] > 10 then
                  begin
                    n14 := n14 + (UserItem.btValue[nC] - 10) * 2;
                  end;
                end
                else
                begin
                  n14 := n14 + UserItem.btValue[nC];
                end;
              end;
            end
            else
            begin
              Inc(n14, UserItem.btValue[nC]);
            end;
            Inc(nC);
            if nC >= 8 then
              break;
          end; // while
          if n14 > 0 then
          begin
            n10 := n10 + (n10 div 8 * n14);
            //080609物品价格BUG n10 div 8 * n14
          end;
          n10 := ROUND(n10 / StdItem.DuraMax * UserItem.DuraMax);
          n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax -
            UserItem.Dura));
          n10 := _MAX(2, ROUND(n10 - n20));
        end; //0049F6BF
      end; //0049F6BF
    end;
    Result := n10;
  except
    MainOutMessage('[Exception] TMerchant.GetUserItemPrice');
  end;
end;

procedure TMerchant.ClientBuyItem(PlayObject: TPlayObject; sItemName: string;
  nInt: Integer); //004A2334
var
  I, II: Integer;
  bo29: Boolean;
  List20: TList;
  //  ItemPrice:pTItemPrice;
  UserItem: pTUserItem;
  StdItem: TItem;
  n1C, nPrice: Integer;
  sUserItemName: string;
begin
  try
    bo29 := False;
    n1C := 1;
    for I := 0 to m_GoodsList.Count - 1 do
    begin
      if bo29 or (bo574) then
        break;
      List20 := TList(m_GoodsList.Items[i]);
      //if List20.Count <= 0 then Continue;
      UserItem := List20.Items[0];

      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem <> nil then
      begin
        //取自定义物品名称
        sUserItemName := GetItemName(UserItem);
        if PlayObject.IsAddWeightAvailable(StdItem.Weight) then
        begin
          if sUserItemName = sItemName then
          begin
            for II := 0 to List20.Count - 1 do
            begin
              UserItem := List20.Items[II];
              if (StdItem.StdMode <= 4) or
                (StdItem.StdMode = 42) or
                (StdItem.StdMode = 31) or
                (UserItem.MakeIndex = nInt) then
              begin

                nPrice := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
                if (PlayObject.m_nGold >= nPrice) and (nPrice > 0) then
                begin
                  if PlayObject.AddItemToBag(UserItem) then
                  begin
                    Dec(PlayObject.m_nGold, nPrice);
                    if m_boCastle or g_Config.boGetAllNpcTax then
                    begin
                      if m_Castle <> nil then
                      begin
                        TUserCastle(m_Castle).IncRateGold(nPrice);
                      end
                      else if g_Config.boGetAllNpcTax then
                      begin
                        g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
                      end;
                    end;
                    {
                    if m_boCastle or g_Config.boGetAllNpcTax then
                      UserCastle.IncRateGold(nPrice);
                    }
                    PlayObject.SendAddItem(UserItem);
                    //004A25DC
                    if StdItem.NeedIdentify = 1 then
                      AddGameDataLog('9' + #9 +
                        PlayObject.m_sMapName + #9 +
                        IntToStr(PlayObject.m_nCurrX) + #9 +
                        IntToStr(PlayObject.m_nCurrY) + #9 +
                        PlayObject.m_sCharName + #9 +
                        //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                        StdItem.Name + #9 +
                        IntToStr(UserItem.MakeIndex) + #9 +
                        '1' + #9 +
                        m_sCharName);

                    List20.Delete(II);
                    if List20.Count <= 0 then
                    begin
                      List20.Free;
                      m_GoodsList.Delete(i);
                    end;
                    n1C := 0;
                  end
                  else
                    n1C := 2;
                end
                else
                  n1C := 3;
                bo29 := True;
                break;
              end;
            end;
          end;
        end
        else
          n1C := 2; //004A2639
      end;
    end; // for
    if n1C = 0 then
    begin
      PlayObject.SendMsg(Self, RM_BUYITEM_SUCCESS, 0, PlayObject.m_nGold, nInt,
        0, '');
    end
    else
    begin
      PlayObject.SendMsg(Self, RM_BUYITEM_FAIL, 0, n1C, 0, 0, '');
    end;

  except
    MainOutMessage('[Exception] TMerchant.ClientBuyItem');
  end;
end;

procedure TMerchant.ClientGetDetailGoodsList(PlayObject: TPlayObject; sItemName:
  string;
  nInt: Integer); //004A26F0
var
  I, II, n18: Integer;
  List20: TList;
  UserItem: pTUserItem;
  Item: TItem;
  StdItem: TStdItem;
  OClientItem2: TOClientItem2;
  ClientItem: TClientItem;
  OClientItem: TOClientItem;
  s1C: string;

begin
  try
    try
      if Assigned(m_HookClientGetDetailGoodsList) then
        m_HookClientGetDetailGoodsList(Self, PlayObject, PChar(sItemName),
          nInt);
    except
      MainOutMessage('[Exception] TMerchant.ClientGetDetailGoodsList->HookApi');
    end;
    if (PlayObject.m_nSoftVersionDateEx = 0) {and (PlayObject.m_dwClientTick=0)}
      then
    begin
      n18 := 0;
      for I := 0 to m_GoodsList.Count - 1 do
      begin
        List20 := TList(m_GoodsList.Items[i]);
        //if List20.Count <= 0 then Continue;
        UserItem := List20.Items[0];

        Item := UserEngine.GetStdItem(UserItem.wIndex);
        if (Item <> nil) and (Item.Name = sItemName) then
        begin
          if (List20.Count - 1) < nInt then
          begin
            nInt := _MAX(0, List20.Count - 10);
          end;
          for II := List20.Count - 1 downto 0 do
          begin
            UserItem := List20.Items[II];
            Item.GetStandardItem(StdItem);
            Item.GetItemAddValue(UserItem, StdItem);
            CopyStdItemToOStdItem(@StdItem, @OClientItem.S);

            OClientItem.Dura := UserItem.Dura;
            OClientItem.DuraMax := GetUserPrice(PlayObject,
              GetUserItemPrice(UserItem));
            OClientItem.MakeIndex := UserItem.MakeIndex;
            s1C := s1C + EncodeBuffer(@OClientItem, SizeOf(TOClientItem)) + '/';
            Inc(n18);
            if n18 >= 10 then
              break;
          end;
          break;
        end;
      end;
      PlayObject.SendMsg(Self, RM_SENDDETAILGOODSLIST, 0, Integer(Self), n18,
        nInt, s1C);
    end
    else if PlayObject.m_dwClientTickEx > 20080108 then
    begin
      n18 := 0;
      for I := 0 to m_GoodsList.Count - 1 do
      begin
        List20 := TList(m_GoodsList.Items[i]);
        if List20.Count <= 0 then
          Continue;
        UserItem := List20.Items[0];

        Item := UserEngine.GetStdItem(UserItem.wIndex);
        if (Item <> nil) and (Item.Name = sItemName) then
        begin
          if (List20.Count - 1) < nInt then
          begin
            nInt := _MAX(0, List20.Count - 10);
          end;
          for II := List20.Count - 1 downto 0 do
          begin
            UserItem := List20.Items[II];
            Item.GetStandardItem(ClientItem.S);
            Item.GetItemAddValue(UserItem, ClientItem.S);
            ClientItem.Desc := Item.sDesc;
            ClientItem.Shine := 0;
            //PlayObject.GetItemState(UserItem,ITEMSTATE_SHINE);
            ClientItem.Dura := UserItem.Dura;
            ClientItem.DuraMax := GetUserPrice(PlayObject,
              GetUserItemPrice(UserItem));
            ClientItem.MakeIndex := UserItem.MakeIndex;
            s1C := s1C + EncodeBuffer(@ClientItem, SizeOf(TClientItem)) + '/';
            Inc(n18);
            if n18 >= 10 then
              break;
          end;
          break;
        end;
      end;
      PlayObject.SendMsg(Self, RM_SENDDETAILGOODSLIST, 0, Integer(Self), n18,
        nInt, s1C);
    end
    else
    begin
      n18 := 0;
      for I := 0 to m_GoodsList.Count - 1 do
      begin
        List20 := TList(m_GoodsList.Items[i]);
        if List20.Count <= 0 then
          Continue;
        UserItem := List20.Items[0];

        Item := UserEngine.GetStdItem(UserItem.wIndex);
        if (Item <> nil) and (Item.Name = sItemName) then
        begin
          if (List20.Count - 1) < nInt then
          begin
            nInt := _MAX(0, List20.Count - 10);
          end;
          for II := List20.Count - 1 downto 0 do
          begin
            UserItem := List20.Items[II];
            Item.GetStandardItem(OClientItem2.S);
            Item.GetItemAddValue(UserItem, OClientItem2.S);
            OClientItem2.Dura := UserItem.Dura;
            OClientItem2.DuraMax := GetUserPrice(PlayObject,
              GetUserItemPrice(UserItem));
            OClientItem2.MakeIndex := UserItem.MakeIndex;
            s1C := s1C + EncodeBuffer(@OClientItem2, SizeOf(TOClientItem2)) +
              '/';
            Inc(n18);
            if n18 >= 10 then
              break;
          end;
          break;
        end;
      end;
      PlayObject.SendMsg(Self, RM_SENDDETAILGOODSLIST, 0, Integer(Self), n18,
        nInt, s1C);
    end;
  except
    MainOutMessage('[Exception] TMerchant.ClientGetDetailGoodsList');
  end;
end;

procedure TMerchant.ClientQuerySellPrice(PlayObject: TPlayObject;
  UserItem: pTUserItem); //004A1B84
var
  nC: Integer;
begin
  try
    nC := GetSellItemPrice(GetUserItemPrice(UserItem));
    if (nC >= 0) then
    begin
      PlayObject.SendMsg(Self, RM_SENDBUYPRICE, 0, nC, 0, 0, '');
    end
    else
    begin
      PlayObject.SendMsg(Self, RM_SENDBUYPRICE, 0, 0, 0, 0, '');
    end;
  except
    MainOutMessage('[Exception] TMerchant.ClientQuerySellPrice');
  end;
end;

function TMerchant.GetSellItemPrice(nPrice: integer): Integer; //0049F7A4
begin
  try
    Result := ROUND(nPrice / 2.0);
  except
    MainOutMessage('[Exception] TMerchant.GetSellItemPrice');
  end;
end;

function TMerchant.ClientSellItem(PlayObject: TPlayObject;
  UserItem: pTUserItem): Boolean; //004A1CD8
  function sub_4A1C84(UserItem: pTUserItem): Boolean;
  var
    StdItem: TItem;
  begin
    Result := True;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) and ((StdItem.StdMode = 25) or (StdItem.StdMode = 30))
      then
    begin
      if UserItem.Dura < 4000 then
        Result := False;
    end;
  end;
var
  nPrice: integer;
  StdItem: TItem;
begin //004A1CD8
  Result := False;
  nPrice := GetSellItemPrice(GetUserItemPrice(UserItem));
  if (nPrice > 0) and (not bo574) and
    sub_4A1C84(UserItem) then
  begin
    if PlayObject.IncGold(nPrice) then
    begin
      {
      if m_boCastle or g_Config.boGetAllNpcTax then
        UserCastle.IncRateGold(nPrice);
      }
      if m_boCastle or g_Config.boGetAllNpcTax then
      begin
        if m_Castle <> nil then
        begin
          TUserCastle(m_Castle).IncRateGold(nPrice);
        end
        else if g_Config.boGetAllNpcTax then
        begin
          g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
        end;
      end;
      PlayObject.SendMsg(Self, RM_USERSELLITEM_OK, 0, PlayObject.m_nGold, 0, 0,
        '');
      AddItemToGoodsList(UserItem);
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      //004A1E95
      if StdItem.NeedIdentify = 1 then
        AddGameDataLog('10' + #9 +
          PlayObject.m_sMapName + #9 +
          IntToStr(PlayObject.m_nCurrX) + #9 +
          IntToStr(PlayObject.m_nCurrY) + #9 +
          PlayObject.m_sCharName + #9 +
          //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
          StdItem.Name + #9 +
          IntToStr(UserItem.MakeIndex) + #9 +
          '1' + #9 +
          m_sCharName);
      Result := True;
    end
    else
    begin //004A1EA0
      PlayObject.SendMsg(Self, RM_USERSELLITEM_FAIL, 0, 0, 0, 0, '');
    end;
  end
  else
  begin
    PlayObject.SendMsg(Self, RM_USERSELLITEM_FAIL, 0, 0, 0, 0, '');
  end;

end;

function TMerchant.AddItemToGoodsList(UserItem: pTUserItem): Boolean; //004A1BF8
var
  //  n10:Integer;
  ItemList: TList;
begin
  try
    Result := False;
    if UserItem.Dura <= 0 then
      exit;
    ItemList := GetRefillList(UserItem.wIndex);
    if ItemList = nil then
    begin
      ItemList := TList.Create;
      m_GoodsList.Add(ItemList);
    end;
    ItemList.Insert(0, UserItem);
    Result := True;
  except
    MainOutMessage('[Exception] TMerchant.ClientSellItem');
  end;
end;

procedure TMerchant.ClientMakeDrugItem(PlayObject: TPlayObject;
  sItemName: string); //004A2B6C
  function sub_4A28FC(PlayObject: TPlayObject; sItemName: string): Boolean;
    //004A28FC
  var
    I, II, n1C: Integer;
    List10: TStringList;
    s20: string;
    List28: TStringList;
    UserItem: pTUserItem;
  begin
    Result := False;
    List10 := GetMakeItemInfo(sItemName);
    if List10 = nil then
      exit;
    Result := True;
    for I := 0 to List10.Count - 1 do
    begin
      s20 := List10.Strings[I];
      n1C := Integer(List10.Objects[I]);
      for II := 0 to PlayObject.m_ItemList.Count - 1 do
      begin
        if
          UserEngine.GetStdItemName(pTUserItem(PlayObject.m_ItemList.Items[II]).wIndex) = s20 then
          Dec(n1C);
      end;
      if n1C > 0 then
      begin
        Result := False;
        break;
      end;
    end; // for
    if Result then
    begin
      List28 := nil;
      for I := 0 to List10.Count - 1 do
      begin
        s20 := List10.Strings[I];
        n1C := Integer(List10.Objects[I]);
        for II := PlayObject.m_ItemList.Count - 1 downto 0 do
        begin
          if n1C <= 0 then
            break;
          UserItem := PlayObject.m_ItemList.Items[II];
          if UserEngine.GetStdItemName(UserItem.wIndex) = s20 then
          begin
            if List28 = nil then
              List28 := TStringList.Create;
            List28.AddObject(s20, TObject(UserItem.MakeIndex));
            Dispose(UserItem);
            PlayObject.m_ItemList.Delete(II);
            Dec(n1C);
          end;
        end;
      end;
      if List28 <> nil then
      begin
        PlayObject.SendMsg(Self, RM_SENDDELITEMLIST, 0, Integer(List28), 0, 0,
          '');
      end;
    end;
  end;
var
  I: Integer;
  List1C: TList;
  MakeItem, UserItem: pTUserItem;
  StdItem: TItem;
  n14: Integer;
begin
  try
    n14 := 1;
    for I := 0 to m_GoodsList.Count - 1 do
    begin
      List1C := TList(m_GoodsList.Items[I]);
      //if List1C.Count <= 0 then Continue;
      MakeItem := List1C.Items[0];
      StdItem := UserEngine.GetStdItem(MakeItem.wIndex);
      if (StdItem <> nil) and (StdItem.Name = sItemName) then
      begin
        if PlayObject.m_nGold >= g_Config.nMakeDurgPrice then
        begin
          if sub_4A28FC(PlayObject, sItemName) then
          begin
            New(UserItem);
            UserEngine.CopyToUserItemFromName(sItemName, UserItem);
            if PlayObject.AddItemToBag(UserItem) then
            begin
              Dec(PlayObject.m_nGold, g_Config.nMakeDurgPrice);
              PlayObject.SendAddItem(UserItem);
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              //004A2D89
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('2' + #9 +
                  PlayObject.m_sMapName + #9 +
                  IntToStr(PlayObject.m_nCurrX) + #9 +
                  IntToStr(PlayObject.m_nCurrY) + #9 +
                  PlayObject.m_sCharName + #9 +
                  //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                  StdItem.Name + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '1' + #9 +
                  m_sCharName);
              n14 := 0;
              break;
            end
            else
            begin
              DisPose(UserItem);
              n14 := 2;
            end;
          end
          else
            n14 := 4;
        end
        else
          n14 := 3; //004A2DB4
      end;
    end; // for
    if n14 = 0 then
    begin
      PlayObject.SendMsg(Self, RM_MAKEDRUG_SUCCESS, 0, PlayObject.m_nGold, 0, 0,
        '');
    end
    else
    begin
      PlayObject.SendMsg(Self, RM_MAKEDRUG_FAIL, 0, n14, 0, 0, '');
    end;

  except
    MainOutMessage('[Exception] TMerchant.ClientMakeDrugItem');
  end;
end;

procedure TMerchant.ClientQueryRepairCost(PlayObject: TPlayObject;
  UserItem: pTUserItem); //004A1F30
var
  nPrice, nRepairPrice: Integer;
begin
  try
    nPrice := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
    if (nPrice > 0) and (UserItem.DuraMax > UserItem.Dura) then
    begin
      if UserItem.DuraMax > 0 then
      begin
        nRepairPrice := ROUND(nPrice div 3 / UserItem.DuraMax * (UserItem.DuraMax
          - UserItem.Dura));
      end
      else
      begin
        nRepairPrice := nPrice;
      end;
      if (PlayObject.m_sScriptLable = sSUPERREPAIR) then
      begin
        if m_boS_repair then
          nRepairPrice := nRepairPrice * g_Config.nSuperRepairPriceRate {3}
        else
          nRepairPrice := -1;
      end
      else
      begin
        if not m_boRepair then
          nRepairPrice := -1;
      end;
      PlayObject.SendMsg(Self, RM_SENDREPAIRCOST, 0, nRepairPrice, 0, 0, '');
    end
    else
    begin
      PlayObject.SendMsg(Self, RM_SENDREPAIRCOST, 0, -1, 0, 0, '');
    end;
  except
    MainOutMessage('[Exception] TMerchant.ClientQueryRepairCost');
  end;
end;

function TMerchant.ClientRepairItem(PlayObject: TPlayObject;
  UserItem: pTUserItem): Boolean; //004A2024
var
  nPrice, nRepairPrice: Integer;
  StdItem: Titem;
  boCanRepair: Boolean;
begin
  try
    Result := False;
    boCanRepair := True;
    if (PlayObject.m_sScriptLable = sSUPERREPAIR) and not m_boS_repair then
    begin
      boCanRepair := False;
    end;
    if (PlayObject.m_sScriptLable <> sSUPERREPAIR) and not m_boRepair then
    begin
      boCanRepair := False;
    end;
    if PlayObject.m_sScriptLable = '@fail_s_repair' then
    begin
      SendMsgToUser(PlayObject,
        '对不起, 我不能修理这个物品\ \ \<返回/@main>');
      PlayObject.SendMsg(Self, RM_USERREPAIRITEM_FAIL, 0, 0, 0, 0, '');
      exit;
    end;
    nPrice := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
    if PlayObject.m_sScriptLable = sSUPERREPAIR then
    begin
      nPrice := nPrice * g_Config.nSuperRepairPriceRate {3};
    end;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem <> nil then
    begin
      if boCanRepair and (nPrice > 0) and (UserItem.DuraMax > UserItem.Dura) and
        (StdItem.StdMode <> 43) then
      begin
        if UserItem.DuraMax > 0 then
        begin
          nRepairPrice := ROUND(nPrice div 3 / UserItem.DuraMax *
            (UserItem.DuraMax - UserItem.Dura));
        end
        else
        begin
          nRepairPrice := nPrice;
        end;
        if PlayObject.DecGold(nRepairPrice) then
        begin
          //        if m_boCastle or g_Config.boGetAllNpcTax then UserCastle.IncRateGold(nRepairPrice);
          if m_boCastle or g_Config.boGetAllNpcTax then
          begin
            if m_Castle <> nil then
            begin
              TUserCastle(m_Castle).IncRateGold(nRepairPrice);
            end
            else if g_Config.boGetAllNpcTax then
            begin
              g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
            end;
          end;
          if PlayObject.m_sScriptLable = sSUPERREPAIR then
          begin
            UserItem.Dura := UserItem.DuraMax;
            PlayObject.SendMsg(Self, RM_USERREPAIRITEM_OK, 0,
              PlayObject.m_nGold, UserItem.Dura, UserItem.DuraMax, '');
            GotoLable(PlayObject, sSUPERREPAIROK, False);
          end
          else
          begin
            Dec(UserItem.DuraMax, (UserItem.DuraMax - UserItem.Dura) div
              g_Config.nRepairItemDecDura {30});
            UserItem.Dura := UserItem.DuraMax;
            PlayObject.SendMsg(Self, RM_USERREPAIRITEM_OK, 0,
              PlayObject.m_nGold, UserItem.Dura, UserItem.DuraMax, '');
            GotoLable(PlayObject, sREPAIROK, False);
          end;
          Result := True;
        end
        else
          PlayObject.SendMsg(Self, RM_USERREPAIRITEM_FAIL, 0, 0, 0, 0, '');
        //004A2238
      end
      else
        PlayObject.SendMsg(Self, RM_USERREPAIRITEM_FAIL, 0, 0, 0, 0, '');
      //004A2253
    end;

  except
    MainOutMessage('[Exception] TMerchant.ClientRepairItem');
  end;
end;

procedure TMerchant.ClearScript;
begin
  try
    m_boBuy := False;
    m_boSell := False;
    m_boSellOff := False;
    m_boMakeDrug := False;
    m_boPrices := False;
    m_boStorage := False;
    m_boPlayDrink := False;
    m_boGetback := False;
    m_boUpgradenow := False;
    m_boGetBackupgnow := False;
    m_boRepair := False;
    m_boS_repair := False;
    m_boGetMarry := False;
    m_boGetMaster := False;
    m_boUseItemName := False;
    m_boHero := False;
    m_boDealGold := False;
    m_boBatchBuy := False;
    inherited;
  except
    MainOutMessage('[Exception] TMerchant.ClearScript');
  end;
end;

procedure TMerchant.LoadUpgradeList; //004A006C
var
  I: Integer;
begin
  try
    for I := 0 to m_UpgradeWeaponList.Count - 1 do
    begin
      Dispose(pTUpgradeInfo(m_UpgradeWeaponList.Items[I]));
    end; // for
    m_UpgradeWeaponList.Clear;
    try
      //FrmDB.LoadUpgradeWeaponRecord(m_sCharName,m_UpgradeWeaponList);
      FrmDB.LoadUpgradeWeaponRecord(m_sScript + '-' + m_sMapName,
        m_UpgradeWeaponList);
    except
      MainOutMessage('Failure in loading upgradinglist - ' + m_sCharName);
    end;
  except
    MainOutMessage('[Exception] TMerchant.LoadUpgradeList');
  end;
end;

{procedure TMerchant.GetMarry(PlayObject: TPlayObject; sDearName: String);
var
  MarryHuman:TPlayObject;
begin
Try
  MarryHuman:=UserEngine.GeTPlayObject(sDearName);
  if (MarryHuman <> nil) and
     (MarryHuman.m_PEnvir = PlayObject.m_PEnvir) and
     (abs(PlayObject.m_nCurrX - MarryHuman.m_nCurrX) < 5) and
     (abs(PlayObject.m_nCurrY - MarryHuman.m_nCurrY) < 5) then begin
    SendMsgToUser(MarryHuman,PlayObject.m_sCharName + ' 向你求婚，你是否愿意嫁给他为妻？');
  end else begin
    Self.SendMsgToUser(PlayObject,sDearName + ' 没有在你身边，你的请求无效！！！');
  end;

Except
  MainOutMessage('[Exception] TMerchant.GetMarry');
End;
end;   }

{procedure TMerchant.GetMaster(PlayObject: TPlayObject; sMasterName: String);
begin
Try

Except
  MainOutMessage('[Exception] TMerchant.GetMaster');
End;
end;   }

procedure TMerchant.SendCustemMsg(PlayObject: TPlayObject; sMsg: string);
begin
  try
    inherited;

  except
    MainOutMessage('[Exception] TMerchant.SendCustemMsg');
  end;
end;
//清除临时文件，包括交易库存，价格表

procedure TMerchant.ClearData;
var
  I, II: Integer;
  UserItem: pTUserItem;
  ItemList: TList;
  ItemPrice: pTItemPrice;
resourcestring
  sExceptionMsg = '[Exception] TMerchant::ClearData';
begin
  try
    try
      for I := 0 to m_GoodsList.Count - 1 do
      begin
        ItemList := TList(m_GoodsList.Items[I]);
        for II := 0 to ItemList.Count - 1 do
        begin
          UserItem := ItemList.Items[II];
          Dispose(UserItem);
        end;
        ItemList.Free;
      end;
      m_GoodsList.Clear;
      for I := 0 to m_ItemPriceList.Count - 1 do
      begin
        ItemPrice := m_ItemPriceList.Items[I];
        Dispose(ItemPrice);
      end;
      m_ItemPriceList.Clear;
      SaveNPCData();
    except
      on e: Exception do
      begin
        MainOutMessage(sExceptionMsg);
        MainOutMessage(E.Message);
      end;
    end;
  except
    MainOutMessage('[Exception] TMerchant.ClearData');
  end;
end;

procedure TMerchant.ChangeUseItemName(PlayObject: TPlayObject;
  sLabel, sItemName: string);
var
  sWhere: string;
  btWhere: Byte;
  UserItem: pTUserItem;
  //  nLabelLen:Integer;
  sMsg: string;
  //  sItemNewName:String;
  //  StdItem:pTStdItem;
begin
  try
    if not PlayObject.m_boChangeItemNameFlag then
    begin
      exit;
    end;
    PlayObject.m_boChangeItemNameFlag := False;

    sWhere := Copy(sLabel, length(sUSEITEMNAME) + 1, length(sLabel) -
      length(sUSEITEMNAME));
    btWhere := Str_ToInt(sWhere, -1);
    if btWhere in [Low(THumanUseItems)..High(THumanUseItems)] then
    begin
      UserItem := @PlayObject.m_UseItems[btWhere];
      if UserItem.wIndex = 0 then
      begin
        sMsg := format(g_sYourUseItemIsNul, [GetUseItemName(btWhere)]);
        PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0,
          sMsg);
        exit;
      end;

      if UserItem.btValue[13] = 1 then
      begin
        ItemUnit.DelCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
      end;

      if sItemName <> '' then
      begin
        ItemUnit.AddCustomItemName(UserItem.MakeIndex, UserItem.wIndex,
          sItemName);
        UserItem.btValue[13] := 1;
      end
      else
      begin
        ItemUnit.DelCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
        UserItem.btValue[13] := 0;
      end;
      ItemUnit.SaveCustomItemName();
      PlayObject.SendMsg(PlayObject, RM_SENDUSEITEMS, 0, 0, 0, 0, '');
      PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, '');
    end;
  except
    MainOutMessage('[Exception] TMerchant.ChangeUseItemName');
  end;
end;

{ TTrainer }

constructor TTrainer.Create; //004A385C
begin
  try
    inherited;
    m_dw568 := GetTickCount();
    n56C := 0;
    n570 := 0;
  except
    MainOutMessage('[Exception] TTrainer.Create');
  end;
end;

destructor TTrainer.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TTrainer.Destroy');
  end;
end;

function TTrainer.Operate(ProcessMsg: pTProcessMessage): Boolean; //004A38C4
begin
  try
    Result := False;
    if (ProcessMsg.wIdent = RM_STRUCK) or (ProcessMsg.wIdent = RM_MAGSTRUCK)
      then
    begin
      //  if (ProcessMsg.wIdent = RM_10101) or (ProcessMsg.wIdent = RM_MAGSTRUCK) then begin

      if (ProcessMsg.BaseObject = Self) { and (ProcessMsg.nParam3 <> 0)} then
      begin
        Inc(n56C, ProcessMsg.wParam);
        m_dw568 := GetTickCount();
        Inc(n570);

        ProcessSayMsg('破坏力为: ' + IntToStr(ProcessMsg.wParam) +
          ', 平均值为: ' + IntToStr(n56C div n570));
      end;
    end;
    if ProcessMsg.wIdent = RM_MAGSTRUCK then
      Result := inherited Operate(ProcessMsg);
  except
    MainOutMessage('[Exception] TTrainer.Operate');
  end;
end;

procedure TTrainer.Run; //004A3A18
begin
  try
    if n570 > 0 then
    begin
      if (GetTickCount - m_dw568) > 3 * 1000 then
      begin
        ProcessSayMsg('总破坏力为: ' + IntToStr(n56C) + ', 平均值为: '
          + IntToStr(n56C div n570));
        n570 := 0;
        n56C := 0;
      end;
    end;
    inherited;
  except
    MainOutMessage('[Exception] TTrainer.Run');
  end;
end;

{ TNormNpc }

procedure TNormNpc.ActionOfDelayCall(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
begin
  try
    if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.sParam2 <> '') then
    begin
      PlayObject.m_DelayNpc.NormNpc := Self;
      PlayObject.m_DelayNpc.sLable := QuestActionInfo.sParam2;
      PlayObject.m_DelayNpc.nDelayTime := GetTickCount +
        LongWord(QuestActionInfo.nParam1);
      PlayObject.m_DelayNpc.bLock := True;
    end
    else
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CREATEHERO);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfDelayCall');
  end;
end;

procedure TNormNpc.ActionOfClearDelayGoto(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  try
    PlayObject.m_DelayNpc.bLock := False;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfClearDelayGoto');
  end;
end;

procedure TNormNpc.ActionOfGameDiamond(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  nCount: Integer;
  cMethod: Char;
begin
  try
    nCount := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nCount < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GAMEDIAMOND);
      exit;
    end;

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          if nCount >= 0 then
          begin
            PlayObject.m_nGameDiamond := nCount;
          end
          else
            PlayObject.m_nGameDiamond := 0;
        end;
      '-':
        begin
          if PlayObject.m_nGameDiamond > nCount then
          begin
            Dec(PlayObject.m_nGameDiamond, nCount);
          end
          else
          begin
            PlayObject.m_nGameDiamond := 0;
          end;
        end;
      '+':
        begin
          Inc(PlayObject.m_nGameDiamond, nCount);
        end;
    end;
    PlayObject.RefDiamondGird;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGameDiamond');
  end;
end;

procedure TNormNpc.ActionOfGameGird(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  nCount: Integer;
  cMethod: Char;
begin
  try
    nCount := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nCount < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GAMEGIRD);
      exit;
    end;

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          if nCount >= 0 then
          begin
            PlayObject.m_nGameGird := nCount;
          end
          else
            PlayObject.m_nGameGird := 0;
        end;
      '-':
        begin
          if PlayObject.m_nGameGird > nCount then
          begin
            Dec(PlayObject.m_nGameGird, nCount);
          end
          else
          begin
            PlayObject.m_nGameGird := 0;
          end;
        end;
      '+':
        begin
          Inc(PlayObject.m_nGameGird, nCount);
        end;
    end;
    PlayObject.RefDiamondGird;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGameGird');
  end;
end;

procedure TNormNpc.ActionOfAddTextList(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  LoadList: TStringList;
  sListFileName: string;
begin
  try
    if (QuestActionInfo.sParam1 = '') or (QuestActionInfo.sParam2 = '') then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AddTextList);
      exit;
    end;
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
    LoadList := TStringList.Create;
    try
      if FileExists(sListFileName) then
      begin
        LoadList.LoadFromFile(sListFileName);
      end;
      LoadList.Add(QuestActionInfo.sParam2);
      LoadList.SaveToFile(sListFileName);
    finally
      LoadList.Free;
    end;
  except
    MainOutMessage('loading fail.... => ' + sListFileName);
  end;
end;

procedure TNormNpc.ActionOfChangeHumAbility(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  btWhere, nPoint: Integer;
  cMethod: Char;
begin
  try
    btWhere := QuestActionInfo.nParam1 - 1;
    nPoint := Str_ToInt(QuestActionInfo.sParam3, -1);
    //MainOutMessage(IntToStr(btWhere));
    if not (btWhere in [0..9]) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHUMABILITY);
      exit;
    end;
    if (nPoint < 0) or (nPoint > High(Word)) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHUMABILITY);
      exit;
    end;
    cMethod := QuestActionInfo.sParam2[1];
    case cMethod of
      '+':
        begin
          if (PlayObject.m_TempAbil[btWhere].nAddWord + nPoint) > High(Word)
            then
            PlayObject.m_TempAbil[btWhere].nAddWord := High(Word)
          else
            Inc(PlayObject.m_TempAbil[btWhere].nAddWord, nPoint);
        end;
      '-':
        begin
          if PlayObject.m_TempAbil[btWhere].nAddWord < nPoint then
            PlayObject.m_TempAbil[btWhere].nAddWord := 0
          else
            Dec(PlayObject.m_TempAbil[btWhere].nAddWord, nPoint);
        end;
      '=': PlayObject.m_TempAbil[btWhere].nAddWord := nPoint;
    else
      begin
        ScriptActionError(PlayObject, '', QuestActionInfo,
          sSC_CHANGEHUMABILITY);
        exit;
      end;
    end;
    if (QuestActionInfo.nParam4 > 0) and (PlayObject.m_TempAbil[btWhere].nAddWord
      > 0) then
    begin
      PlayObject.m_TempAbil[btWhere].nAddTick := GetTickCount +
        LongWord(QuestActionInfo.nParam4 * 1000);
    end
    else
      PlayObject.m_TempAbil[btWhere].nAddTick := 0;
    PlayObject.RecalcAbilitys;
    PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangeHumAbility');
  end;
end;

procedure TNormNpc.ActionOfUSEBONUSPOINT(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  btWhere: Byte;
  nPoint: Word;
  cMethod: Char;
  Int: PWord;
begin
  try
    btWhere := QuestActionInfo.nParam1;
    nPoint := QuestActionInfo.nParam3;
    Int := nil;
    if not (btWhere in [1..9]) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_USEBONUSPOINT);
      exit;
    end;
    if QuestActionInfo.sParam2 = '' then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_USEBONUSPOINT);
      exit;
    end;
    case btWhere of
      1: Int := @PlayObject.m_BonusAbil.DC;
      2: Int := @PlayObject.m_BonusAbil.MC;
      3: Int := @PlayObject.m_BonusAbil.SC;
      4: Int := @PlayObject.m_BonusAbil.AC;
      5: Int := @PlayObject.m_BonusAbil.MAC;
      6: Int := @PlayObject.m_BonusAbil.HP;
      7: Int := @PlayObject.m_BonusAbil.MP;
      8: Int := @PlayObject.m_BonusAbil.Hit;
      9: Int := @PlayObject.m_BonusAbil.Speed;
    end;
    cMethod := QuestActionInfo.sParam2[1];
    case cMethod of
      '=': Int^ := nPoint;
      '+':
        begin
          if (Int^ + nPoint) > High(Word) then
            Int^ := High(Word)
          else
            Inc(Int^, nPoint);
        end;
      '-':
        begin
          if Int^ < nPoint then
            Int^ := 0
          else
            Dec(Int^, nPoint);
        end;
    else
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_USEBONUSPOINT);
    end;
    PlayObject.RecalcAbilitys;
    PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
    PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfUseBonusPoint');
  end;
end;

procedure TNormNpc.ActionOfDelTextList(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  LoadList: TStringList;
  sListFileName: string;
  Idx: Integer;
begin
  try
    if (QuestActionInfo.sParam1 = '') or (QuestActionInfo.sParam2 = '') then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AddTextList);
      exit;
    end;
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
    LoadList := TStringList.Create;
    try
      if FileExists(sListFileName) then
      begin
        LoadList.LoadFromFile(sListFileName);
        Idx := LoadList.IndexOf(QuestActionInfo.sParam2);
        if Idx <> -1 then
        begin
          LoadList.Delete(Idx);
          LoadList.SaveToFile(sListFileName);
        end;
      end;
    finally
      LoadList.Free;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.DelTextList');
  end;
end;

procedure TNormNpc.ActionOfHCall(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  UserPlayObject: TPlayObject;
begin
  try
    if QuestActionInfo.sParam2 = '' then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HCall);
      exit;
    end;
    UserPlayObject := UserEngine.GetPlayObject(QuestActionInfo.sParam1, False);
    if (UserPlayObject <> nil) and (g_ManageNPC <> nil) then
    begin
      UserPlayObject.NpcGotoLable(g_ManageNPC, QuestActionInfo.sParam2, False);
      //g_ManageNPC.GotoLable(UserPlayObject,QuestActionInfo.sParam2,False);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfHCall');
  end;
end;

procedure TNormNpc.ActionOfTakeOffItem(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  btWhere: Integer;
  //StdItem:TItem;
  sUserItemName: string;
  UserItem: pTUserItem;
begin
  try
    btWhere := QuestActionInfo.nParam2;
    if QuestActionInfo.sParam1 = '' then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_TakeOffItem);
      exit;
    end;
    if btWhere in [0..MAXUSEITEMS] then
    begin
      with PlayObject do
      begin
        if m_UseItems[btWhere].wIndex > 0 then
        begin
          //StdItem:=UserEngine.GetStdItem(m_UseItems[btWhere].wIndex);
          {if (StdItem <> nil) and
             (StdItem.StdMode in [15,19,20,21,22,23,24,26]) then begin
            if (not m_boUserUnLockDurg) and (m_UseItems[btWhere].btValue[7] <> 0)then begin
              exit;
            end;
          end;
          if not m_boUserUnLockDurg and ((StdItem.Reserved and 2) <> 0)then begin
            exit;
          end;
          if (StdItem.Reserved and 4) <> 0 then begin
            exit;
          end;
          if InDisableTakeOffList(m_UseItems[btWhere].wIndex) then begin
            exit;
          end;    }
          //取自定义物品名称
          sUserItemName := GetItemName(@m_UseItems[btWhere]);

          if CompareText(sUserItemName, QuestActionInfo.sParam1) = 0 then
          begin
            New(UserItem);
            UserItem^ := m_UseItems[btWhere];
            if AddItemToBag(UserItem) then
            begin
              SendDelItems(UserItem);
              m_UseItems[btWhere].wIndex := 0;
              SendAddItem(UserItem);
              RecalcAbilitys();
              SendMsg(Self, RM_ABILITY, 0, 0, 0, 0, '');
              SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');
              if btWhere = U_STRAW then
                RefShowName;
              FeatureChanged();

              //SendDefMessage(SM_TAKEOFFITEM,btWhere,0,0,Integer(m_boHero),'');
              //if (g_FunctionNPC <> nil) and (not m_boHero) then
                //g_FunctionNPC.GotoLable(Self,'@TakeOff' + sItemName,False);
            end
            else
            begin
              Dispose(UserItem);
            end;
          end;
        end;
      end;
      //PlayObject.SendDefMessage(SM_TAKEOFFITEM,QuestActionInfo.nParam2,0,0,0,QuestActionInfo.sParam1);
    end
    else
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_TakeOffItem);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfTakeOffItem');
  end;
end;

procedure TNormNpc.ActionOfThrowItem(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  Envir: TEnvirnoment;
  //  StdItem:TItem;
  UserItem: pTUserItem;
  I: integer;
  nX, nY: Integer;
begin
  try
    Envir := g_MapManager.FindMap(QuestActionInfo.sParam1);
    if (Envir = nil) or
      (QuestactionInfo.nParam2 = 0) or
      (QuestactionInfo.nParam3 = 0) or
      (QuestActionInfo.nParam4 = 0) or
      (QuestActionInfo.sParam5 = '') then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ThrowItem);
      exit;
    end;
    New(UserItem);
    for I := 0 to QuestActionInfo.nParam6 - 1 do
    begin
      if UserEngine.CopyToUserItemFromName(QuestActionInfo.sParam5, UserItem)
        then
      begin
        if Envir.GetRangeXY(QuestactionInfo.nParam2, QuestactionInfo.nParam3,
          QuestActionInfo.nParam4, nX, nY) then
          PlayObject.DropItemDownEx(UserItem, QuestActionInfo.nParam4, Envir,
            nX, nY);
      end;
    end;
    Dispose(UserItem);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfActionOfThrowItem');
  end;
end;

procedure TNormNpc.ActionOfTakeOnItem(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  UserItem, TakeOffItem: pTUserItem;
  StdItem {,StdItem20}: TItem;
  StdItem58: TStdItem;
  i, n14, btWhere: Integer;
  sUserItemName: string;
begin
  try
    btWhere := QuestActionInfo.nParam2;
    if QuestActionInfo.sParam1 = '' then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_TakeOnItem);
      exit;
    end;
    StdItem := nil;
    n14 := -1;
    if btWhere in [0..MAXUSEITEMS] then
    begin
      with PlayObject do
      begin
        UserItem := nil;
        for I := 0 to m_ItemList.Count - 1 do
        begin
          UserItem := m_ItemList.Items[i];
          if (UserItem <> nil) then
          begin
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            sUserItemName := GetItemName(UserItem);
            if StdItem <> nil then
            begin
              if CompareText(sUserItemName, QuestActionInfo.sParam1) = 0 then
              begin
                n14 := i;
                break;
              end;
            end;
          end;
          UserItem := nil;
        end;
        if (StdItem <> nil) and (UserItem <> nil) then
        begin
          if CheckUserItems(btWhere, StdItem) then
          begin
            StdItem.GetStandardItem(StdItem58);
            StdItem.GetItemAddValue(UserItem, StdItem58);
            StdItem58.Name := GetItemName(UserItem);
            if CheckTakeOnItems(btWhere, StdItem58) and
              CheckItemBindUse(UserItem) then
            begin
              TakeOffItem := nil;
              if m_UseItems[btWhere].wIndex > 0 then
              begin
                New(TakeOffItem);
                TakeOffItem^ := m_UseItems[btWhere];
              end; //if m_UseItems[btWhere].wIndex
              if (StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26]) and
                //004DAEC7
              (UserItem.btValue[8] <> 0) then
                UserItem.btValue[8] := 0;

              m_UseItems[btWhere] := UserItem^;
              SendMsgItem(SM_TAKEONITEM, UserItem.MakeIndex, btWhere, 0,
                Integer(m_boHero), UserItem);
              DelBagItem(n14);
              if TakeOffItem <> nil then
              begin
                AddItemToBag(TakeOffItem);
                SendAddItem(TakeOffItem);
              end;
              RecalcAbilitys();
              SendMsg(Self, RM_ABILITY, 0, 0, 0, 0, '');
              SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');
              if btWhere = U_STRAW then
                RefShowName;
              FeatureChanged();
            end;
          end;
        end;
      end;
    end
    else
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_TakeOnItem);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfTakeOnItem');
  end;
end;

//创建英雄

procedure TNormNpc.ActionOfCreateHero(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  btHero: Byte;
begin
  try
    if PlayObject.m_boHero then
      exit;
    if QuestActionInfo.sParam3 = 'TRUE' then
    begin
      btHero := 1;
      if (PlayObject.m_HeroName <> '') or (PlayObject.m_HeroName2 <> '') then
      begin //已经有英雄
        GotoLable(PlayObject, sSL_HaveHero, False);
        exit;
      end;
    end
    else
    begin
      btHero := 0;
      if (PlayObject.m_HeroName <> '') or (PlayObject.m_HeroName1 <> '') then
      begin //已经有英雄
        GotoLable(PlayObject, sSL_HaveHero, False);
        exit;
      end;
    end;
    if PlayObject.m_CreateHeroName = '' then
    begin //请先给您的英雄取名字
      GotoLable(PlayObject, sSL_SetHeroName, False);
      exit;
    end;
    if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.sParam2 <> '') then
    begin
      FrontEngine.AddToLoadRcdList(PlayObject.m_sUserID,
        PlayObject.m_CreateHeroName,
        PlayObject.m_sIPaddr,
        False,
        0,
        btHero,
        0,
        0,
        0,
        -1,
        -1,
        True,
        QuestActionInfo.nParam1,
        QuestActionInfo.nParam2,
        True, PlayObject);
      GotoLable(PlayObject, sSL_CreateingHero, False);
    end
    else
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CREATEHERO);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfCreateHero');
  end;
end;

procedure TNormNpc.ActionOfAddNameDateList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  LoadList: TStringList;
  boFound: Boolean;
  sListFileName, sLineText, sHumName, sDate: string;
begin
  try
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
    LoadList := TStringList.Create;
    if FileExists(sListFileName) then
    begin
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
    end;
    boFound := False;
    for I := 0 to LoadList.Count - 1 do
    begin
      sLineText := Trim(LoadList.Strings[i]);
      sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
      if CompareText(sHumName, PlayObject.m_sCharName) = 0 then
      begin
        LoadList.Strings[I] := PlayObject.m_sCharName + #9 + DateToStr(Date);
        boFound := True;
        break;
      end;
    end;
    if not boFound then
      LoadList.Add(PlayObject.m_sCharName + #9 + DateToStr(Date));

    try
      LoadList.SaveToFile(sListFileName);
    except
      MainOutMessage('saving fail.... => ' + sListFileName);
    end;
    LoadList.Free;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfAddNameDateList');
  end;
end;

procedure TNormNpc.ActionOfDelNameDateList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  LoadList: TStringList;
  sLineText, sListFileName, sHumName, sDate: string;
  boFound: Boolean;
begin
  try
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
    LoadList := TStringList.Create;
    if FileExists(sListFileName) then
    begin
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
    end;
    boFound := False;
    for I := 0 to LoadList.Count - 1 do
    begin
      sLineText := Trim(LoadList.Strings[i]);
      sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
      if CompareText(sHumName, PlayObject.m_sCharName) = 0 then
      begin
        LoadList.Delete(i);
        boFound := True;
        break;
      end;
    end;
    if boFound then
    begin
      try
        LoadList.SaveToFile(sListFileName);
      except
        MainOutMessage('saving fail.... => ' + sListFileName);
      end;
    end;
    LoadList.Free;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfDelNameDateList');
  end;
end;

procedure TNormNpc.ActionOfAddSkill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  //  I: Integer;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
  nLevel: Integer;
begin
  try
    nLevel := _MIN(3, Str_ToInt(QuestActionInfo.sParam2, 0));
    Magic := UserEngine.FindMagic(QuestActionInfo.sParam1, PlayObject.m_boHero);
    if Magic <> nil then
    begin
      if not PlayObject.IsTrainingSkill(Magic.wMagicId) then
      begin
        New(UserMagic);
        UserMagic.MagicInfo := Magic;
        UserMagic.wMagIdx := Magic.wMagicId;
        UserMagic.btKey := 0;
        UserMagic.btLevel := nLevel;
        UserMagic.nTranPoint := 0;
        PlayObject.m_MagicList.Add(UserMagic);
        PlayObject.SendAddMagic(UserMagic);
        PlayObject.RecalcAbilitys();
        PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
        PlayObject.SendMsg(PlayObject, RM_SUBABILITY, 0, 0, 0, 0, '');
        PlayObject.m_boUseThrusting := True;
        if g_Config.boShowScriptActionMsg then
        begin
          PlayObject.SysMsg(Magic.sMagicName + '练习成功。', c_Green,
            t_Hint);
        end;

      end;
    end
    else
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDSKILL);
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfAddSkill');
  end;
end;


procedure TNormNpc.ActionOfAutoAddGameGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo; nPoint, nTime: Integer);
//var
//  sMsg:String;
begin
  try
    if CompareText(QuestActionInfo.sParam1, 'START') = 0 then
    begin
      if (nPoint > 0) and (nTime > 0) then
      begin
        PlayObject.m_nIncGameGold := nPoint;
        PlayObject.m_dwIncGameGoldTime := LongWord(nTime * 1000);
        PlayObject.m_dwIncGameGoldTick := GetTickCount();
        PlayObject.m_boIncGameGold := True;
        exit;
      end;
    end;
    if CompareText(QuestActionInfo.sParam1, 'STOP') = 0 then
    begin
      PlayObject.m_boIncGameGold := False;
      exit;
    end;
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AUTOADDGAMEGOLD);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfAutoAddGameGold');
  end;
end;

//SETAUTOGETEXP 时间 点数 是否安全区 地图号

procedure TNormNpc.ActionOfAutoGetExp(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nTime, nPoint: Integer;
  boIsSafeZone: Boolean;
  sMap: string;
  Envir: TEnvirnoment;
begin
  try
    Envir := nil;
    nTime := Str_ToInt(QuestActionInfo.sParam1, -1);
    nPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
    boIsSafeZone := False;
    if QuestActionInfo.sParam3 <> '' then
      boIsSafeZone := QuestActionInfo.sParam3[1] = '1';
    sMap := QuestActionInfo.sParam4;
    if sMap <> '' then
    begin
      Envir := g_MapManager.FindMap(sMap);
    end;

    if (nTime <= 0) or (nPoint <= 0) or ((sMap <> '') and (Envir = nil)) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETAUTOGETEXP);
      exit;
    end;
    PlayObject.m_boAutoGetExpInSafeZone := boIsSafeZone;
    PlayObject.m_AutoGetExpEnvir := Envir;
    PlayObject.m_nAutoGetExpTime := nTime * 1000;
    PlayObject.m_nAutoGetExpPoint := nPoint;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfAutoGetExp');
  end;
end;

procedure TNormNpc.ActionOfAutoSubGameGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo; nPoint, nTime: integer);
//var
//  sMsg:String;
begin
  try
    if CompareText(QuestActionInfo.sParam1, 'START') = 0 then
    begin
      if (nPoint > 0) and (nTime > 0) then
      begin
        PlayObject.m_nDecGameGold := nPoint;
        PlayObject.m_dwDecGameGoldTime := LongWord(nTime * 1000);
        PlayObject.m_dwDecGameGoldTick := 0;
        PlayObject.m_boDecGameGold := True;
        exit;
      end;
    end;
    if CompareText(QuestActionInfo.sParam1, 'STOP') = 0 then
    begin
      PlayObject.m_boDecGameGold := False;
      exit;
    end;
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AUTOSUBGAMEGOLD);

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfAutoSubGameGold');
  end;
end;

procedure TNormNpc.ActionOfChangeCreditPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  //  boChgOK:Boolean;
  nCreditPoint: Integer;
  //  nLv:Integer;
  //  nOldLevel:Integer;
  cMethod: Char;
  //  dwInt:LongWord;
begin
  try
    //  boChgOK:=False;
    nCreditPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nCreditPoint < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CREDITPOINT);
      exit;
    end;

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          if nCreditPoint >= 0 then
          begin
            PlayObject.m_btCreditPoint := nCreditPoint;
          end;
        end;
      '-':
        begin
          if PlayObject.m_btCreditPoint > nCreditPoint then
          begin
            Dec(PlayObject.m_btCreditPoint, nCreditPoint);
          end
          else
          begin
            PlayObject.m_btCreditPoint := 0;
          end;
        end;
      '+':
        begin
          Inc(PlayObject.m_btCreditPoint, nCreditPoint);
          if PlayObject.m_btCreditPoint < 0 then
            PlayObject.m_btCreditPoint := 0;
        end;
    else
      begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CREDITPOINT);
        exit;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangeCreditPoint');
  end;
end;

procedure TNormNpc.ActionOfChangeHeroExp(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  //  boChgOK:Boolean;
  nExp: Integer;
  //  nLv:Integer;
  //  nOldLevel:Integer;
  cMethod: Char;
  dwInt: LongWord;
begin
  try
    //  boChgOK:=False;
    if PlayObject.m_Hero = nil then
      exit;
    nExp := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nExp < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ChangeHeroExp);
      exit;
    end;
    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          if nExp >= 0 then
          begin
            PlayObject.m_Hero.m_Abil.Exp := LongWord(nExp);
            //dwInt:=LongWord(nExp);
          end;
        end;
      '-':
        begin
          if PlayObject.m_Hero.m_Abil.Exp > LongWord(nExp) then
          begin
            Dec(PlayObject.m_Hero.m_Abil.Exp, LongWord(nExp));
          end
          else
          begin
            PlayObject.m_Hero.m_Abil.Exp := 0;
          end;
        end;
      '+':
        begin
          //if PlayObject.m_Hero.m_Abil.Exp >= LongWord(nExp) then begin
          if LongWord(nExp) > (High(LongWord) - PlayObject.m_Hero.m_Abil.Exp)
            then
          begin
            dwInt := High(LongWord) - PlayObject.m_Hero.m_Abil.Exp;
          end
          else
          begin
            dwInt := LongWord(nExp);
          end;
          {end else begin
              if (LongWord(nExp) - PlayObject.m_Hero.m_Abil.Exp) > (High(LongWord) - LongWord(nExp)) then begin
                dwInt:=High(LongWord) - LongWord(nExp);
              end else begin
                dwInt:=LongWord(nExp);
              end;
          end; }
          Inc(PlayObject.m_Hero.m_Abil.Exp, dwInt);
          //PlayObject.GetExp(dwInt);
          PlayObject.m_Hero.SendMsg(PlayObject.m_Hero, RM_WINEXP, 0, dwInt, 0,
            0,
            '');
        end;
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangeCreditPoint');
  end;
end;

procedure TNormNpc.ActionOfChangeExp(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  //  boChgOK:Boolean;
  nExp2: Integer;
  nExp: LongWord;
  //  nLv:Integer;
  //  nOldLevel:Integer;
  cMethod: Char;
  dwInt: LongWord;
begin
  try
    //  boChgOK:=False;
    nExp2 := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nExp2 < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEEXP);
      exit;
    end;
    nExp := LongWord(nExp2);

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          PlayObject.m_Abil.Exp := nExp;
        end;
      '-':
        begin
          if PlayObject.m_Abil.Exp > nExp then
          begin
            Dec(PlayObject.m_Abil.Exp, nExp);
          end
          else
          begin
            PlayObject.m_Abil.Exp := 0;
          end;
        end;
      '+':
        begin
          //if PlayObject.m_Abil.Exp >= nExp then begin
          if nExp > (High(LongWord) - PlayObject.m_Abil.Exp) then
          begin
            dwInt := High(LongWord) - PlayObject.m_Abil.Exp;
          end
          else
          begin
            dwInt := nExp;
          end;
          {end else begin
            if (nExp - PlayObject.m_Abil.Exp) > (High(LongWord) - nExp) then begin
              dwInt:=High(LongWord) - nExp;
            end else begin
              dwInt:=nExp;
            end;
          end;}
          //Inc(PlayObject.m_Abil.Exp,dwInt);
          PlayObject.GetExp(dwInt);
          //PlayObject.SendMsg(PlayObject,RM_WINEXP,0,dwInt,0,0,'');
        end;
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangeExp');
  end;
end;

procedure TNormNpc.ActionOfChangeHairStyle(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nHair: Integer;
begin
  try
    nHair := Str_ToInt(QuestActionInfo.sParam1, -1);
    if (QuestActionInfo.sParam1 <> '') and (nHair >= 0) then
    begin
      PlayObject.m_btHair := _MIN(1, nHair);
      PlayObject.FeatureChanged;
    end
    else
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HAIRSTYLE);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangeHairStyle');
  end;
end;

procedure TNormNpc.ActionOfChangeHeroJob(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nJob: Integer;
begin
  try
    nJob := -1;
    if PlayObject.m_Hero = nil then
      exit;
    if CompareLStr(QuestActionInfo.sParam1, sWarrior, Length(sWarrior)) then
      nJob := jWarr;
    if CompareLStr(QuestActionInfo.sParam1, sWizard, Length(sWizard)) then
      nJob := jWizard;
    if CompareLStr(QuestActionInfo.sParam1, sTaos, Length(sTaos)) then
      nJob := jTaos;
    if nJob < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ChangeHeroJob);
      exit;
    end;
    if PlayObject.m_Hero.m_btJob <> nJob then
    begin
      PlayObject.m_Hero.m_btJob := nJob;
      PlayObject.m_Hero.HasLevelUp(0);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangeHeroJob');
  end;
end;

procedure TNormNpc.ActionOfChangeJob(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nJob: Integer;
begin
  try
    nJob := -1;
    if CompareLStr(QuestActionInfo.sParam1, sWarrior, Length(sWarrior)) then
      nJob := jWarr;
    if CompareLStr(QuestActionInfo.sParam1, sWizard, Length(sWizard)) then
      nJob := jWizard;
    if CompareLStr(QuestActionInfo.sParam1, sTaos, Length(sTaos)) then
      nJob := jTaos;

    if nJob < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEJOB);
      exit;
    end;

    if PlayObject.m_btJob <> nJob then
    begin
      PlayObject.m_btJob := nJob;
      {
      PlayObject.RecalcLevelAbilitys();
      PlayObject.RecalcAbilitys();
      }
      PlayObject.HasLevelUp(0);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangeJob');
  end;
end;

procedure TNormNpc.ActionOfChangeHeroLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nLevel: Integer;
  nOldLevel: Integer;
  cMethod: Char;
  boChgOK: Boolean;
  nLv: Integer;
begin
  try
    boChgOK := False;
    if PlayObject.m_Hero = nil then
      exit;
    nOldLevel := PlayObject.m_Hero.m_Abil.Level;
    nLevel := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nLevel < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ChangeHeroLevel);
      exit;
    end;
    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          if (nLevel > 0) and (nLevel <= MAXLEVEL) then
          begin
            PlayObject.m_Hero.m_Abil.Level := nLevel;
            boChgOK := True;
          end;
        end;
      '-':
        begin
          nLv := _MAX(0, PlayObject.m_Hero.m_Abil.Level - nLevel);
          nLv := _MIN(MAXLEVEL, nLv);
          PlayObject.m_Hero.m_Abil.Level := nLv;
          boChgOK := True;
        end;
      '+':
        begin
          nLv := _MAX(0, PlayObject.m_Hero.m_Abil.Level + nLevel);
          nLv := _MIN(MAXLEVEL, nLv);
          PlayObject.m_Hero.m_Abil.Level := nLv;
          boChgOK := True;
        end;
    end;
    if boChgOK then
      PlayObject.m_Hero.HasLevelUp(nOldLevel);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangeHeroLevel');
  end;
end;

procedure TNormNpc.ActionOfChangeLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boChgOK: Boolean;
  nLevel: Integer;
  nLv: Integer;
  nOldLevel: Integer;
  cMethod: Char;
begin
  try
    boChgOK := False;
    nOldLevel := PlayObject.m_Abil.Level;
    nLevel := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nLevel < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGELEVEL);
      exit;
    end;

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          if (nLevel > 0) and (nLevel <= MAXLEVEL) then
          begin
            PlayObject.m_Abil.Level := nLevel;
            boChgOK := True;
          end;
        end;
      '-':
        begin
          nLv := _MAX(0, PlayObject.m_Abil.Level - nLevel);
          nLv := _MIN(MAXLEVEL, nLv);
          PlayObject.m_Abil.Level := nLv;
          boChgOK := True;
        end;
      '+':
        begin
          nLv := _MAX(0, PlayObject.m_Abil.Level + nLevel);
          nLv := _MIN(MAXLEVEL, nLv);
          PlayObject.m_Abil.Level := nLv;
          boChgOK := True;
        end;
    end;
    if boChgOK then
      PlayObject.HasLevelUp(nOldLevel);

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangeLevel');
  end;
end;

procedure TNormNpc.ActionOfChangeHeroPKPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nPKPoint: Integer;
  nPoint: Integer;
  nOldPKLevel: Integer;
  cMethod: Char;
begin
  try
    if PlayObject.m_Hero = nil then
      exit;
    nOldPKLevel := PlayObject.m_Hero.PKLevel;
    nPKPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nPKPoint < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ChangeHeroPKPoint);
      exit;
    end;

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          if (nPKPoint >= 0) then
          begin
            PlayObject.m_Hero.m_nPkPoint := nPKPoint;
          end;
        end;
      '-':
        begin
          nPoint := _MAX(0, PlayObject.m_Hero.m_nPkPoint - nPKPoint);
          PlayObject.m_Hero.m_nPkPoint := nPoint;
        end;
      '+':
        begin
          nPoint := _MAX(0, PlayObject.m_Hero.m_nPkPoint + nPKPoint);
          PlayObject.m_Hero.m_nPkPoint := nPoint;
        end;
    end;
    if nOldPKLevel <> PlayObject.m_Hero.PKLevel then
      PlayObject.m_Hero.RefNameColor;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangeHeroPKPoint');
  end;
end;

procedure TNormNpc.ActionOfChangePkPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nPKPoint: Integer;
  nPoint: Integer;
  nOldPKLevel: Integer;
  cMethod: Char;
begin
  try
    nOldPKLevel := PlayObject.PKLevel;
    nPKPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nPKPoint < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEPKPOINT);
      exit;
    end;

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          if (nPKPoint >= 0) then
          begin
            PlayObject.m_nPkPoint := nPKPoint;
          end;
        end;
      '-':
        begin
          nPoint := _MAX(0, PlayObject.m_nPkPoint - nPKPoint);
          PlayObject.m_nPkPoint := nPoint;
        end;
      '+':
        begin
          nPoint := _MAX(0, PlayObject.m_nPkPoint + nPKPoint);
          PlayObject.m_nPkPoint := nPoint;
        end;
    end;
    if nOldPKLevel <> PlayObject.PKLevel then
      PlayObject.RefNameColor;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangePkPoint');
  end;
end;

procedure TNormNpc.ActionOfClearMapMon(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  MonList: TList;
  Mon: TBaseObject;
  II: Integer;
begin
  try
    MonList := TList.Create;
    UserEngine.GetMapMonster(g_MapManager.FindMap(QuestActionInfo.sParam1),
      MonList);
    for II := 0 to MonList.Count - 1 do
    begin
      Mon := TBaseObject(MonList.Items[II]);
      if (Mon.m_Master2 <> nil) and (not Mon.m_boAutoGhost) then
        Continue;
      if GetNoClearMonList(Mon.m_sCharName) then
        Continue;
      if Mon.m_boAutoGhost then
      begin
        Mon.m_Master2 := nil;
        Mon.m_AllMaster := nil;
      end;
      Mon.m_boNoItem := True;
      Mon.MakeGhost;
    end;
    MonList.Free;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfClearMapMon');
  end;
end;

procedure TNormNpc.ActionOfClearNameList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  LoadList: TStringList;
  sListFileName: string;
begin
  try
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
    LoadList := TStringList.Create;
    {
    if FileExists(sListFileName) then begin
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
    end;
    }
    LoadList.Clear;
    try
      LoadList.SaveToFile(sListFileName);
    except
      MainOutMessage('saving fail.... => ' + sListFileName);
    end;
    LoadList.Free;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfClearNameList');
  end;
end;

procedure TNormNpc.ActionOfDelUserDate(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  LoadList: TStringList;
  sListFileName: string;
  sName, sTime, sTop: string;
  I: integer;
begin
  try
    if QuestActionInfo.sParam1 = '' then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DelUserDate);
      exit;
    end;
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
    LoadList := TStringList.Create;
    try
      if FileExists(sListFileName) then
      begin
        LoadList.LoadFromFile(sListFileName);
        for I := 0 to LoadList.Count - 1 do
        begin
          sTop := LoadList.Strings[I];
          if (Length(sTop) > 0) and (sTop[1] <> ';') then
          begin
            sTime := GetValidStr3(sTop, sName, [' ', ',', #9]);
            if CompareText(PlayObject.m_sCharName, sName) = 0 then
            begin
              LoadList.Delete(I);
              break;
            end;
          end;
        end;
      end;
    finally
      LoadList.SaveToFile(sListFileName);
      LoadList.Free;
    end;
  except
    MainOutMessage('Save fail.... => ' + sListFileName)
  end;
end;

procedure TNormNpc.ActionOfStartTakeGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  BaseObject: TBaseObject;
begin
  try
    BaseObject := PlayObject.GetPoseCreate();
    if (BaseObject <> nil) and (BaseObject <> PlayObject) and
      (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and
      (not BaseObject.m_boHero) then
    begin
      if (BaseObject.GetPoseCreate = PlayObject) then
      begin
        PlayObject.m_DealGoldBase := BaseObject;
        GotoLable(PlayObject, '@StartDealGold', False);
        exit;
      end;
    end;
    GotoLable(PlayObject, '@DealGoldPost', False);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfStartTakeGold');
  end;
end;

procedure TNormNpc.ActionOfRepairAll(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  I: integer;
  UserItem: pTUserItem;
  StdItem: TItem;
begin
  try
    for I := Low(THumItems) to High(THumItems) do
    begin
      UserItem := @PlayObject.m_UseItems[I];
      if (UserItem.wIndex > 0) and (UserItem.Dura < UserItem.DuraMax) then
      begin
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if StdItem.nRule[RULE_DEATH] then
          Continue;
        if StdItem.ItemType in [ITEM_WEAPON, ITEM_ARMOR, ITEM_ACCESSORY] then
        begin
          UserItem.Dura := UserItem.DuraMax;
          PlayObject.SysMsg(Format(sRepairItemMsg, [StdItem.Name]), c_Green,
            t_Hint);
          PlayObject.SendMsg(PlayObject, RM_DURACHANGE, i, UserItem.Dura,
            UserItem.DuraMax, 0, '');
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfRepairAll');
  end;
end;

procedure TNormNpc.ActionOfGuildNoticeMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  FColor: Integer;
  BColor: Integer;
  SendObject: TPlayObject;
  I, II: integer;
  sSendMsg: string;
  GuildRank: pTGuildRank;
begin
  try
    FColor := Str_ToInt(QuestactionINfo.sParam1, -1);
    BColor := Str_ToInt(QuestactionINfo.sParam2, -1);
    if (not (FColor in [0..255])) or ((not (BColor in [0..255]))) or
      (QuestactionInfo.sParam3 = '') then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GuildNoticeMsg);
      exit;
    end;
    sSendMsg := PlayObject.GetSelfInfo(QuestactionInfo.sParam3);
    if CompareText(QuestactionInfo.sParam4, 'SELF') = 0 then
    begin
      PlayObject.SysColorMsg(sSendMsg, FColor, BColor);
    end
    else if CompareText(QuestactionInfo.sParam4, 'GROUP') = 0 then
    begin
      PlayObject.SysColorMsg(sSendMsg, FColor, BColor);
      for i := 0 to PlayObject.m_GroupMembers.Count - 1 do
      begin
        SendObject := TPlayObject(PlayObject.m_GroupMembers.Objects[I]);
        if SendObject = PlayObject then
          Continue;
        SendObject.SysColorMsg(sSendMsg, FColor, BColor);
      end;
    end
    else if CompareText(QuestactionInfo.sParam4, 'GUILD') = 0 then
    begin
      PlayObject.SysColorMsg(sSendMsg, FColor, BColor);
      if PlayObject.IsGuildMaster then
      begin
        for I := 0 to TGuild(PlayObject.m_MyGuild).m_RankList.Count - 1 do
        begin
          GuildRank := TGuild(PlayObject.m_MyGuild).m_RankList.Items[I];
          for II := 0 to GuildRank.MemberList.Count - 1 do
          begin
            SendObject := TPlayObject(GuildRank.MemberList.Objects[II]);
            if SendObject = PlayObject then
              Continue;
            if SendObject <> nil then
              SendObject.SysColorMsg(sSendMsg, FColor, BColor);
          end;
        end;
      end;
    end
    else
    begin
      for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do
      begin
        SendObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[I]);
        if SendObject <> nil then
          SendObject.SysColorMsg(sSendMsg, FColor, BColor);
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGuildNoticeMsg');
  end;
end;

procedure TNormNpc.ActionOfThroughHum(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  nMode: Integer;
  nTime: Integer;
begin
  try
    nMode := Str_ToInt(QuestActionInfo.sParam1, -1);
    nTime := Str_ToInt(QuestActionInfo.sParam2, -1);
    if (nMode < 0) or (nTime < 0) or (not (nMode in [0..2])) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ThroughHum);
      exit;
    end;
    PlayObject.m_btThrough := nMode;
    PlayObject.m_dwThroughTick := GetTickCount + LongWord(nTime * 1000);
    PlayObject.SendServerConfig();
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfThroughHum')
  end;
end;

procedure TNormNpc.ActionOfGetRandomName(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  n18: Integer;
  LoadList: TStringList;
  sListFileName: string;
  sName: string;
  nIdx: Integer;
begin
  try
    if QuestActionInfo.sParam1 = '' then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GetRandomName);
      exit;
    end;
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sListFileName);
    try
      if LoadList.Count <= 0 then
        exit;
      nIdx := Random(LoadList.Count);
      sName := LoadList.Strings[nIdx];
      n18 := GetValNameNo(QuestActionInfo.sParam2);
      case n18 of
        2000..2999: g_Config.GlobalStrVal[n18 - 2000] := sName;
        3000..3999: g_Config.GlobaDyMStrVal[n18 - 3000] := sName;
        700..799: PlayObject.m_StrVal[n18 - 700] := sName;
      else
        begin
          ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GetRandomName);
          exit;
        end;
      end;
    finally
      LoadList.Free;
    end;
  except
    MainOutMessage('Load fail.... => ' + sListFileName)
  end;
end;

procedure TNormNpc.ActionOfClearCodeList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  LoadList: TStringList;
  sListFileName: string;
  I: integer;
begin
  try
    if PlayObject.m_ServerStrVal[0] = '' then
      exit;
    if QuestActionInfo.sParam1 = '' then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ClearCodeList);
      exit;
    end;
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sListFileName);
    try
      for I := 0 to LoadList.Count - 1 do
      begin
        if CompareText(LoadList.Strings[I], PlayObject.m_ServerStrVal[0]) = 0
          then
        begin
          LoadList.Delete(I);
          break;
        end;
      end;
      LoadList.SaveToFile(sListFileName);
    finally
      LoadList.Free;
    end;
  except
    MainOutMessage('Save fail.... => ' + sListFileName)
  end;
end;

procedure TNormNpc.ActionOfAddUserDate(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  LoadList: TStringList;
  sListFileName: string;
  sName, sTime, sTop: string;
  I: integer;
begin
  try
    if QuestActionInfo.sParam1 = '' then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AddUserDate);
      exit;
    end;
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
    LoadList := TStringList.Create;
    try
      if FileExists(sListFileName) then
      begin
        LoadList.LoadFromFile(sListFileName);
        for I := 0 to LoadList.Count - 1 do
        begin
          sTop := LoadList.Strings[I];
          if (Length(sTop) > 0) and (sTop[1] <> ';') then
          begin
            sTime := GetValidStr3(sTop, sName, [' ', ',', #9]);
            if CompareText(PlayObject.m_sCharName, sName) = 0 then
            begin
              LoadList.Strings[I] := PlayObject.m_sCharName + #9 +
                DateToStr(Now);
              exit;
            end;
          end;
        end;
      end;
      LoadList.Add(PlayObject.m_sCharName + #9 + DateToStr(Now));
    finally
      LoadList.SaveToFile(sListFileName);
      LoadList.Free;
    end;
  except
    MainOutMessage('Save fail.... => ' + sListFileName)
  end;
end;

procedure TNormNpc.ActionOfSetOffTimer(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  nIdx: Integer;
  I: Integer;
  OnTimer: pTOnTimer;
begin
  try
    nIdx := Str_ToInt(QuestActionInfo.sParam1, -1);
    if (nIdx < 0) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SetOffTimer);
      exit;
    end;
    for I := PlayObject.m_OnTimerList.Count - 1 downto 0 do
    begin
      OnTimer := PlayObject.m_OnTimerList.Items[I];
      if OnTimer.nIdx = nIdx then
      begin
        Dispose(OnTimer);
        PlayObject.m_OnTimerList.Delete(I);
        exit;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfSetOffTimer')
  end;
end;

procedure TNormNpc.ActionOfSetOnTimer(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  nTimer: LongWord;
  nIdx: Integer;
  I: integer;
  OnTimer: pTOnTimer;
begin
  try
    nIdx := Str_ToInt(QuestActionInfo.sParam1, -1);
    nTimer := Str_ToInt(QuestActionInfo.sParam2, -1);
    if (nIdx < 0) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SetOnTimer);
      exit;
    end;
    for I := PlayObject.m_OnTimerList.Count - 1 downto 0 do
    begin
      OnTimer := PlayObject.m_OnTimerList.Items[I];
      if OnTimer.nIdx = nIdx then
      begin
        OnTimer.RunCount := QuestActionInfo.nParam3;
        OnTimer.Interval := nTimer * 1000;
        OnTimer.NextTimer := GetTickCount + OnTimer.Interval;
        exit;
      end;
    end;
    New(OnTimer);
    OnTimer.nIdx := nIdx;
    OnTimer.RunCount := QuestActionInfo.nParam3;
    OnTimer.Interval := nTimer * 1000;
    OnTimer.NextTimer := GetTickCount + OnTimer.Interval;
    PlayObject.m_OnTimerList.Add(OnTimer);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfSetOnTimer');
  end;
end;

procedure TNormNpc.ActionOfCLEARHEROSKILL(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  UserMagic: pTUserMagic;
begin
  try
    if PlayObject.m_Hero = nil then
      exit;
    for I := PlayObject.m_Hero.m_MagicList.Count - 1 downto 0 do
    begin
      UserMagic := PlayObject.m_Hero.m_MagicList.Items[I];
      if QuestActionInfo.sParam1 = '' then
      begin
        TPlayObject(PlayObject.m_Hero).SendDelMagic(UserMagic);
        Dispose(UserMagic);
        PlayObject.m_Hero.m_MagicList.Delete(I);
      end
      else
      begin
        if CompareText(UserMagic.MagicInfo.sMagicName, QuestActionInfo.sParam1)
          = 0 then
        begin
          TPlayObject(PlayObject.m_Hero).SendDelMagic(UserMagic);
          Dispose(UserMagic);
          PlayObject.m_Hero.m_MagicList.Delete(I);
          break;
        end;
      end;
    end;
    PlayObject.m_Hero.RecalcAbilitys();
    PlayObject.m_Hero.SendMsg(PlayObject.m_Hero, RM_ABILITY, 0, 0, 0, 0, '');
    PlayObject.m_Hero.SendMsg(PlayObject.m_Hero, RM_SUBABILITY, 0, 0, 0, 0, '');
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfClearHeroSkill');
  end;
end;

procedure TNormNpc.ActionOfClearSkill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  UserMagic: pTUserMagic;
begin
  try
    for I := PlayObject.m_MagicList.Count - 1 downto 0 do
    begin
      UserMagic := PlayObject.m_MagicList.Items[I];
      PlayObject.SendDelMagic(UserMagic);
      Dispose(UserMagic);
      PlayObject.m_MagicList.Delete(I);
    end;
    PlayObject.RecalcAbilitys();
    PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
    PlayObject.SendMsg(PlayObject, RM_SUBABILITY, 0, 0, 0, 0, '');
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfClearSkill');
  end;
end;

procedure TNormNpc.ActionOfDelNoJobSkill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  UserMagic: pTUserMagic;
begin
  try
    for I := PlayObject.m_MagicList.Count - 1 downto 0 do
    begin
      UserMagic := PlayObject.m_MagicList.Items[I];
      if UserMagic.MagicInfo.btJob <> PlayObject.m_btJob then
      begin
        PlayObject.SendDelMagic(UserMagic);
        Dispose(UserMagic);
        PlayObject.m_MagicList.Delete(I);
      end;
    end;
    PlayObject.RecalcAbilitys;
    PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
    PlayObject.SendMsg(PlayObject, RM_SUBABILITY, 0, 0, 0, 0, '');
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfDelNoJobSkill');
  end;
end;

procedure TNormNpc.ActionOfDelSkill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sMagicName: string;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
begin
  try
    sMagicName := QuestActionInfo.sParam1;
    Magic := UserEngine.FindMagic(sMagicName, PlayObject.m_boHero);
    if Magic = nil then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DELSKILL);
      exit;
    end;
    for I := 0 to PlayObject.m_MagicList.Count - 1 do
    begin
      UserMagic := PlayObject.m_MagicList.Items[I];
      if UserMagic.MagicInfo = Magic then
      begin
        PlayObject.m_MagicList.Delete(I);
        PlayObject.SendDelMagic(UserMagic);
        Dispose(UserMagic);
        PlayObject.RecalcAbilitys();
        PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
        PlayObject.SendMsg(PlayObject, RM_SUBABILITY, 0, 0, 0, 0, '');
        break;
      end;
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfDelSkill');
  end;
end;

procedure TNormNpc.ActionOfSendTopMsg(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
//var
  //m_DefMsg:TDefaultMessage;
begin
  try
    if QuestActionInfo.sParam3 = '' then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SENDTOPMSG);
      exit;
    end;
    PlayObject.SendDefMessagebyClass(SM_SELFTOP,
      0,
      MakeWord(QuestActionInfo.nParam1, QuestActionInfo.nParam2),
      0,
      0,
      QuestActionInfo.sParam3,
      QuestActionInfo.sParam4);
    //m_DefMsg:=MakeDefaultMsg(SM_SELFTOP,0,MakeWord(QuestActionInfo.nParam1,QuestActionInfo.nParam2),0,0);
    //UserEngine.SendBroadSocket(@m_DefMsg,EncodeString(QuestActionInfo.sParam3));
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfSendTopMsg');
  end;
end;

procedure TNormNpc.ActionOfSendCenterMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
//var
  //m_DefMsg:TDefaultMessage;
begin
  try
    if QuestActionInfo.sParam3 = '' then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SENDCENTERMSG);
      exit;
    end;
    PlayObject.SendDefMessagebyClass(SM_SELFCENET,
      15000,
      MakeWord(QuestActionInfo.nParam1, QuestActionInfo.nParam2),
      0,
      0,
      QuestActionInfo.sParam3,
      QuestActionInfo.sParam4);
    //m_DefMsg:=MakeDefaultMsg(SM_SELFCENET,15000,MakeWord(QuestActionInfo.nParam1,QuestActionInfo.nParam2),0,0);
    //UserEngine.SendBroadSocket(@m_DefMsg,EncodeString(QuestActionInfo.sParam3));
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfSendCenterMsg');
  end;
end;

procedure TNormNpc.ActionOfAddRandomMapGate(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nEnvir, DEnvir: TEnvirnoment;
  nX, nY, dX, dY, I: Integer;
  MapGate: pTMapGate;
  GateObj: pTGateObj;
begin
  try
    nEnvir := g_MapManager.FindMap(QuestActionInfo.sParam2);
    dEnvir := g_MapManager.FindMap(QuestActionInfo.sParam5);
    nX := QuestActionInfo.nParam3;
    nY := QuestActionInfo.nParam4;
    dX := Str_ToInt(QuestActionInfo.sParam6, -1);
    dY := Str_ToInt(QuestActionInfo.sParam7, -1);
    if (nEnvir = nil) or (dEnvir = nil) or (dX < 0) or (dY < 0) then
    begin
      ScriptActionError(PlayObject, '地图参数不正确', QuestActionInfo,
        sSC_ADDRANDOMMAPGATE);
      exit;
    end;
    if nEnvir.m_MapGeteList <> nil then
    begin
      for I := 0 to nEnvir.m_MapGeteList.Count - 1 do
      begin
        MapGate := nEnvir.m_MapGeteList.Items[I];
        if CompareStr(MapGate.sIdx, QuestActionInfo.sParam1) = 0 then
        begin
          ScriptActionError(PlayObject, '地图标志[' + QuestActionInfo.sParam1
            + ']已存在', QuestActionInfo, sSC_ADDRANDOMMAPGATE);
          exit;
        end;
      end;
    end;
    New(GateObj);
    GateObj.boFlag := False;
    GateObj.DEnvir := DEnvir;
    GateObj.nDMapX := dX;
    GateObj.nDMapY := dY;
    if nEnvir.AddToMap(nX, nY, OS_GATEOBJECT, TObject(GateObj)) = GateObj then
    begin
      New(MapGate);
      MapGate.sIdx := QuestActionInfo.sParam1;
      MapGate.nX := nX;
      MapGate.nY := nY;
      MapGate.GetObj := GateObj;
      if nEnvir.m_MapGeteList = nil then
        nEnvir.m_MapGeteList := TList.Create;
      nEnvir.m_MapGeteList.Add(MapGate);
    end
    else
      Dispose(GateObj);
    //SEnvir.AddToMap(nSMapX,nSMapY,OS_GATEOBJECT,TObject(GateObj));
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfAddRandomMapGate');
  end;
end;

procedure TNormNpc.ActionOfDelRandomMapGate(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nEnvir: TEnvirnoment;
  I: integer;
  MapGate: pTMapGate;
begin
  try
    nEnvir := g_MapManager.FindMap(QuestActionInfo.sParam2);
    if (nEnvir = nil) then
    begin
      ScriptActionError(PlayObject, '地图参数不正确', QuestActionInfo,
        sSC_DELRANDOMMAPGATE);
      exit;
    end;
    if nEnvir.m_MapGeteList <> nil then
    begin
      for I := 0 to nEnvir.m_MapGeteList.Count - 1 do
      begin
        MapGate := nEnvir.m_MapGeteList.Items[I];
        if CompareStr(MapGate.sIdx, QuestActionInfo.sParam1) = 0 then
        begin
          nEnvir.DeleteFromMap(MapGate.nX, MapGate.nY, OS_GATEOBJECT,
            TObject(MapGate.GetObj));
          if nEnvir.m_MapGeteList.Count <= 0 then
          begin
            nEnvir.m_MapGeteList.Free;
            nEnvir.m_MapGeteList := nil;
          end;
          exit;
        end;
      end;
    end;
    ScriptActionError(PlayObject, '地图标志[' + QuestActionInfo.sParam1 +
      ']不存在', QuestActionInfo, sSC_DELRANDOMMAPGATE);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfDelRandomMapGate(');
  end;
end;

procedure TNormNpc.ActionOfGetRandomMapGate(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nEnvir: TEnvirnoment;
  I: integer;
  MapGate: pTMapGate;
begin
  try
    nEnvir := g_MapManager.FindMap(QuestActionInfo.sParam2);
    if (nEnvir = nil) then
    begin
      ScriptActionError(PlayObject, '地图参数不正确', QuestActionInfo,
        sSC_GETRANDOMMAPGATE);
      exit;
    end;
    if nEnvir.m_MapGeteList <> nil then
    begin
      for I := 0 to nEnvir.m_MapGeteList.Count - 1 do
      begin
        MapGate := nEnvir.m_MapGeteList.Items[I];
        if CompareStr(MapGate.sIdx, QuestActionInfo.sParam1) = 0 then
        begin
          SetIntegerVal(PlayObject, QuestActionInfo.sParam3, MapGate.nX);
          SetIntegerVal(PlayObject, QuestActionInfo.sParam4, MapGate.nY);
          SetIntegerVal(PlayObject, QuestActionInfo.sParam5,
            MapGate.GetObj.nDMapX);
          SetIntegerVal(PlayObject, QuestActionInfo.sParam6,
            MapGate.GetObj.nDMapY);
          exit;
        end;
      end;
    end;
    ScriptActionError(PlayObject, '地图标志[' + QuestActionInfo.sParam1 +
      ']不存在', QuestActionInfo, sSC_GETRANDOMMAPGATE);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGetRandomMapGate');
  end;
end;

procedure TNormNpc.SetIntegerVal(PlayObject: TPlayObject; Name: string; Int:
  Integer);
var
  n14: Integer;
begin
  try
    n14 := GetValNameNo(Name);
    if n14 >= 0 then
    begin
      case n14 of //
        0..99:
          begin
            PlayObject.m_nVal[n14] := Int;
          end;
        1000..1999:
          begin
            g_Config.GlobalVal[n14 - 1000] := Int;
          end;
        200..299:
          begin
            PlayObject.m_DyVal[n14 - 200] := Int;
          end;
        300..399:
          begin
            PlayObject.m_nMval[n14 - 300] := Int;
          end;
        4000..4999:
          begin
            g_Config.GlobaDyMval[n14 - 4000] := Int;
          end;
        900..999:
          begin
            PlayObject.m_DyValEx[n14 - 900] := Int;
          end;
      end;
    end;
  except
  end;
end;

procedure TNormNpc.ActionOfChangeHeroLoyal(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nCount: Integer;
  cMethod: Char;
  HeroObject: TPlayObject;
begin
  try
    if PlayObject.m_Hero = nil then
      exit;
    HeroObject := TPlayObject(PlayObject.m_Hero);
    nCount := Str_ToInt(QuestActionInfo.sParam2, -1);
    if (nCount < 0) or (nCount > 10000) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHEROLOYAL);
      exit;
    end;
    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          HeroObject.HeroChangeGlory(nCount, 2);
        end;
      '-':
        begin
          HeroObject.HeroChangeGlory(nCount, 1);
        end;
      '+':
        begin
          HeroObject.HeroChangeGlory(nCount, 0);
        end;
    else
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHEROLOYAL);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangeHeroLoyal');
  end;
end;

procedure TNormNpc.ActionOfSendEditTopMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
//var
//  m_DefMsg:TDefaultMessage;
begin
  try
    if QuestActionInfo.sParam3 = '' then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SENDEDITTOPMSG);
      exit;
    end;
    PlayObject.SendDefMessagebyClass(SM_SELFSYS,
      15000,
      MakeWord(QuestActionInfo.nParam1, QuestActionInfo.nParam2),
      0,
      0,
      QuestActionInfo.sParam3,
      QuestActionInfo.sParam4);
    //m_DefMsg:=MakeDefaultMsg(SM_SELFSYS,15000,MakeWord(QuestActionInfo.nParam1,QuestActionInfo.nParam2),0,0);
    //UserEngine.SendBroadSocket(@m_DefMsg,EncodeString(QuestActionInfo.sParam3));
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfSendEditTopMsg');
  end;
end;

procedure TNormNpc.ActionOfAddAttackSabukAll(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  CurCastle: TUserCastle;
  sFileName, sConfigFile: string;
  LoadLis: TStringList;
  I: Integer;
begin
  try
    if QuestActionInfo.nParam1 >= g_CastleManager.m_CastleList.Count then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDATTACKSABUKALL);
      exit;
    end;
    CurCastle :=
      TUserCastle(g_CastleManager.m_CastleList.Items[QuestActionInfo.nParam1]);
    if not DirectoryExists(g_Config.sCastleDir + CurCastle.m_sConfigDir) then
    begin
      CreateDir(g_Config.sCastleDir + CurCastle.m_sConfigDir);
    end;
    sConfigFile := 'AttackSabukWall.txt';
    sFileName := g_Config.sCastleDir + CurCastle.m_sConfigDir + '\' +
      sConfigFile;
    LoadLis := TStringList.Create;
    for i := 0 to g_GuildManager.GuildList.Count - 1 do
    begin
      LoadLis.Add(Format('%s    "%s"',
        [TGuild(g_GuildManager.GuildList.Items[i]).sGuildName,
        FormatDateTime('yyyy-mm-dd', Now)]));
    end;
    try
      LoadLis.SaveToFile(sFileName);
    except
      MainOutMessage('保存攻城信息失败: ' + sFileName);
    end;
    LoadLis.Free;
    CurCastle.LoadAttackSabukWall;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfAddAttackSabukAll');
  end;
end;

procedure TNormNpc.ActionOfGloryChange(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  nCount: Integer;
  nOldGlory: Word;
  cMethod: Char;
begin
  try
    nOldGlory := PlayObject.m_nGloryPoint;
    nCount := Str_ToInt(QuestActionInfo.sParam2, -1);
    if (nCount < 0) or (nCount > 65535) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GLORYCHANGE);
      exit;
    end;
    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          if (nCount >= 0) then
          begin
            PlayObject.m_nGloryPoint := _MIN(High(Word), nCount);
          end;
        end;
      '-':
        begin
          nCount := _MAX(0, PlayObject.m_nGloryPoint - nCount);
          PlayObject.m_nGloryPoint := nCount;
        end;
      '+':
        begin
          nCount := _MIN(High(Word), PlayObject.m_nGloryPoint + nCount);
          PlayObject.m_nGloryPoint := nCount;
        end;
    end;
    if nOldGlory <> PlayObject.m_nGloryPoint then
      PlayObject.GameGoldChanged;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGloryChange');
  end;
end;

procedure TNormNpc.ActionOfGameGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGameGold: Integer;
  nOldGameGold: Integer;
  cMethod: Char;
begin
  try
    nOldGameGold := PlayObject.m_nGameGold;
    nGameGold := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nGameGold < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GAMEGOLD);
      exit;
    end;

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          if (nGameGold >= 0) then
          begin
            PlayObject.m_nGameGold := _MIN(High(Integer), nGameGold);
          end;
        end;
      '-':
        begin
         if QuestActionInfo.nParam3>0 then
           nGameGold := _MAX(0, PlayObject.m_nGameGold - (nGameGold*QuestActionInfo.nParam3))
         else
          nGameGold := _MAX(0, PlayObject.m_nGameGold - nGameGold);
          PlayObject.m_nGameGold := nGameGold;
        end;
      '+':
        begin
          if QuestActionInfo.nParam3>0 then
           nGameGold := _MAX(High(Integer), PlayObject.m_nGameGold + (nGameGold*QuestActionInfo.nParam3))
         else
           nGameGold := _MIN(High(Integer), PlayObject.m_nGameGold + nGameGold);
          PlayObject.m_nGameGold := nGameGold;
        end;
    end;
    //'%d'#9'%s'#9'%d'#9'%d'#9'%s'#9'%s'#9'%d'#9'%s'#9'%s'
    if g_boGameLogGameGold then
    begin
      AddGameDataLog(format(g_sGameLogMsg1, [LOG_GAMEGOLD,
        PlayObject.m_sMapName,
          PlayObject.m_nCurrX,
          PlayObject.m_nCurrY,
          PlayObject.m_sCharName,
          g_Config.sGameGoldName,
          nGameGold,
          cMethod,
          m_sCharName]));
    end;
    if nOldGameGold <> PlayObject.m_nGameGold then
      PlayObject.GameGoldChanged;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGameGold');
  end;
end;

procedure TNormNpc.ActionOfGamePoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGamePoint: Integer;
  nOldGamePoint: Integer;
  cMethod: Char;
begin
  try
    nOldGamePoint := PlayObject.m_nGamePoint;
    nGamePoint := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nGamePoint < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GAMEPOINT);
      exit;
    end;

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          if (nGamePoint >= 0) then
          begin
            PlayObject.m_nGamePoint := _MIN(High(Integer), nGamePoint);
          end;
        end;
      '-':
        begin
          nGamePoint := _MAX(0, PlayObject.m_nGamePoint - nGamePoint);
          PlayObject.m_nGamePoint := nGamePoint;
        end;
      '+':
        begin
          nGamePoint := _MIN(High(Integer), PlayObject.m_nGamePoint +
            nGamePoint);
          PlayObject.m_nGamePoint := nGamePoint;
        end;
    end;
    //'%d'#9'%s'#9'%d'#9'%d'#9'%s'#9'%s'#9'%d'#9'%s'#9'%s'
    if g_boGameLogGamePoint then
    begin
      AddGameDataLog(format(g_sGameLogMsg1, [LOG_GAMEPOINT,
        PlayObject.m_sMapName,
          PlayObject.m_nCurrX,
          PlayObject.m_nCurrY,
          PlayObject.m_sCharName,
          g_Config.sGamePointName,
          nGamePoint,
          cMethod,
          m_sCharName]));
    end;
    if nOldGamePoint <> PlayObject.m_nGamePoint then
      PlayObject.GameGoldChanged;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGamePoint');
  end;
end;

procedure TNormNpc.ActionOfGetMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseBaseObject: TBaseObject;
begin
  try
    PoseBaseObject := PlayObject.GetPoseCreate();
    if (PoseBaseObject <> nil) and (PoseBaseObject.m_btRaceServer =
      RC_PLAYOBJECT) and (PoseBaseObject.m_btGender <> PlayObject.m_btGender)
        then
    begin
      PlayObject.m_sDearName := PoseBaseObject.m_sCharName;
      PlayObject.RefShowName;
      PoseBaseObject.RefShowName;
    end
    else
    begin
      GotoLable(PlayObject, '@MarryError', False);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGetMarry');
  end;
end;

procedure TNormNpc.ActionOfGetMaster(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseBaseObject: TBaseObject;
begin
  try
    PoseBaseObject := PlayObject.GetPoseCreate();
    if (PoseBaseObject <> nil) and (PoseBaseObject.m_btRaceServer =
      RC_PLAYOBJECT) and (PoseBaseObject.m_btGender <> PlayObject.m_btGender)
        then
    begin
      PlayObject.m_sMasterName := PoseBaseObject.m_sCharName;
      PlayObject.RefShowName;
      PoseBaseObject.RefShowName;
    end
    else
    begin
      GotoLable(PlayObject, '@MasterError', False);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGetMaster');
  end;
end;

procedure TNormNpc.ActionOfLineMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMsg: string;
begin
  try
    sMsg := GetLineVariableText(PlayObject, QuestActionInfo.sParam2);
    sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.m_sCharName);
    sMsg := AnsiReplaceText(sMsg, '%d', m_sCharName);
    if PlayObject.m_PEnvir <> nil then
      sMsg := AnsiReplaceText(sMsg, '%m', PlayObject.m_PEnvir.sMapDesc)
    else
      sMsg := AnsiReplaceText(sMsg, '%m', '未知');
    sMsg := AnsiReplaceText(sMsg, '%x', IntToStr(PlayObject.m_nCurrX));
    sMsg := AnsiReplaceText(sMsg, '%y', IntToStr(PlayObject.m_nCurrY));
    case QuestActionInfo.nParam1 of
      0: UserEngine.SendBroadCastMsg(sMsg, t_System);
      1: UserEngine.SendBroadCastMsg('(*) ' + sMsg, t_System);
      2: UserEngine.SendBroadCastMsg('[' + m_sCharName + ']' + sMsg, t_System);
      3: UserEngine.SendBroadCastMsg('[' + PlayObject.m_sCharName + ']' + sMsg,
          t_System);
      4: ProcessSayMsg(sMsg);
      5: PlayObject.SysMsg(sMsg, c_Red, t_Say);
      6: PlayObject.SysMsg(sMsg, c_Green, t_Say);
      7: PlayObject.SysMsg(sMsg, c_Blue, t_Say);
      8: PlayObject.SendGroupText(sMsg);
      9:
        begin
          if PlayObject.m_MyGuild <> nil then
          begin
            TGuild(PlayObject.m_MyGuild).SendGuildMsg(sMsg);
            UserEngine.SendServerGroupMsg(SS_208, nServerIndex,
              TGuild(PlayObject.m_MyGuild).sGuildName + '/' +
              PlayObject.m_sCharName + '/' + sMsg);
          end;
        end;
    else
      begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSENDMSG);
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfLineMsg');
  end;
end;

{procedure TNormNpc.ActionOfMapTing(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
Try

Except
  MainOutMessage('[Exception] TNormNpc.ActionOfMapTing');
End;
end;  }

procedure TNormNpc.ActionOfMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  sSayMsg: string;
begin
  try
    if PlayObject.m_sDearName <> '' then
      exit;
    PoseHuman := TPlayObject(PlayObject.GetPoseCreate());
    if PoseHuman = nil then
    begin
      GotoLable(PlayObject, '@MarryCheckDir', False);
      exit;
    end;
    if QuestActionInfo.sParam1 = '' then
    begin
      if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then
      begin
        GotoLable(PlayObject, '@HumanTypeErr', False);
        exit;
      end;
      if PoseHuman.GetPoseCreate = PlayObject then
      begin
        if PlayObject.m_btGender <> PoseHuman.m_btGender then
        begin
          GotoLable(PlayObject, '@StartMarry', False);
          GotoLable(PoseHuman, '@StartMarry', False);
          if (PlayObject.m_btGender = gMan) and (PoseHuman.m_btGender = gWoMan)
            then
          begin
            sSayMsg := AnsiReplaceText(g_sStartMarryManMsg, '%n', m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
            UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
            sSayMsg := AnsiReplaceText(g_sStartMarryManAskQuestionMsg, '%n',
              m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
            UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          end
          else if (PlayObject.m_btGender = gWoMan) and (PoseHuman.m_btGender =
            gMan) then
          begin
            sSayMsg := AnsiReplaceText(g_sStartMarryWoManMsg, '%n',
              m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
            UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
            sSayMsg := AnsiReplaceText(g_sStartMarryWoManAskQuestionMsg, '%n',
              m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
            UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          end;
          PlayObject.m_boStartMarry := True;
          PoseHuman.m_boStartMarry := True;
        end
        else
        begin
          GotoLable(PoseHuman, '@MarrySexErr', False);
          GotoLable(PlayObject, '@MarrySexErr', False);
        end;
      end
      else
      begin
        GotoLable(PlayObject, '@MarryDirErr', False);
        GotoLable(PoseHuman, '@MarryCheckDir', False);
      end;
      exit;
    end;
    if CompareText(QuestActionInfo.sParam1, 'REQUESTMARRY' {sREQUESTMARRY}) = 0
      then
    begin
      if PlayObject.m_boStartMarry and PoseHuman.m_boStartMarry then
      begin
        if (PlayObject.m_btGender = gMan) and (PoseHuman.m_btGender = gWoMan)
          then
        begin
          sSayMsg := AnsiReplaceText(g_sMarryManAnswerQuestionMsg, '%n',
            m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          sSayMsg := AnsiReplaceText(g_sMarryManAskQuestionMsg, '%n',
            m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          GotoLable(PlayObject, '@WateMarry', False);
          GotoLable(PoseHuman, '@RevMarry', False);
        end;
      end;
      exit;
    end;
    if CompareText(QuestActionInfo.sParam1, 'RESPONSEMARRY' {sRESPONSEMARRY}) = 0
      then
    begin
      if (PlayObject.m_btGender = gWoMan) and (PoseHuman.m_btGender = gMan) then
      begin
        if CompareText(QuestActionInfo.sParam2, 'OK') = 0 then
        begin
          if PlayObject.m_boStartMarry and PoseHuman.m_boStartMarry then
          begin
            sSayMsg := AnsiReplaceText(g_sMarryWoManAnswerQuestionMsg, '%n',
              m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
            UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
            sSayMsg := AnsiReplaceText(g_sMarryWoManGetMarryMsg, '%n',
              m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
            UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
            GotoLable(PlayObject, '@EndMarry', False);
            GotoLable(PoseHuman, '@EndMarry', False);
            PlayObject.m_boStartMarry := False;
            PoseHuman.m_boStartMarry := False;
            PlayObject.m_sDearName := PoseHuman.m_sCharName;
            PlayObject.m_DearHuman := PoseHuman;
            PoseHuman.m_sDearName := PlayObject.m_sCharName;
            PoseHuman.m_DearHuman := PlayObject;
            PlayObject.RefShowName;
            PoseHuman.RefShowName;
          end;
        end
        else
        begin
          if PlayObject.m_boStartMarry and PoseHuman.m_boStartMarry then
          begin
            GotoLable(PlayObject, '@EndMarryFail', False);
            GotoLable(PoseHuman, '@EndMarryFail', False);
            PlayObject.m_boStartMarry := False;
            PoseHuman.m_boStartMarry := False;
            sSayMsg := AnsiReplaceText(g_sMarryWoManDenyMsg, '%n', m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
            UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
            sSayMsg := AnsiReplaceText(g_sMarryWoManCancelMsg, '%n',
              m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
            UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          end;
        end;
      end;
      exit;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfMarry');
  end;
end;

procedure TNormNpc.ActionOfMaster(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  //  sSayMsg:String;
begin
  try
    if PlayObject.m_sMasterName <> '' then
      exit;
    PoseHuman := TPlayObject(PlayObject.GetPoseCreate());
    if PoseHuman = nil then
    begin
      GotoLable(PlayObject, '@MasterCheckDir', False);
      exit;
    end;
    if QuestActionInfo.sParam1 = '' then
    begin
      if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then
      begin
        GotoLable(PlayObject, '@HumanTypeErr', False);
        exit;
      end;
      if PoseHuman.GetPoseCreate = PlayObject then
      begin
        GotoLable(PlayObject, '@StartGetMaster', False);
        GotoLable(PoseHuman, '@StartMaster', False);
        PlayObject.m_boStartMaster := True;
        PoseHuman.m_boStartMaster := True;
      end
      else
      begin
        GotoLable(PlayObject, '@MasterDirErr', False);
        GotoLable(PoseHuman, '@MasterCheckDir', False);
      end;
      exit;
    end;
    if CompareText(QuestActionInfo.sParam1, 'REQUESTMASTER') = 0 then
    begin
      if PlayObject.m_boStartMaster and PoseHuman.m_boStartMaster then
      begin
        PlayObject.m_PoseBaseObject := PoseHuman;
        PoseHuman.m_PoseBaseObject := PlayObject;
        GotoLable(PlayObject, '@WateMaster', False);
        GotoLable(PoseHuman, '@RevMaster', False);
      end;
      exit;
    end;
    if CompareText(QuestActionInfo.sParam1, 'RESPONSEMASTER') = 0 then
    begin
      if CompareText(QuestActionInfo.sParam2, 'OK') = 0 then
      begin
        if (PlayObject.m_PoseBaseObject = PoseHuman) and
          (PoseHuman.m_PoseBaseObject = PlayObject) then
        begin
          if PlayObject.m_boStartMaster and PoseHuman.m_boStartMaster then
          begin
            GotoLable(PlayObject, '@EndMaster', False);
            GotoLable(PoseHuman, '@EndMaster', False);
            PlayObject.m_boStartMaster := False;
            PoseHuman.m_boStartMaster := False;
            if PlayObject.m_sMasterName = '' then
            begin
              PlayObject.m_sMasterName := PoseHuman.m_sCharName;
              PlayObject.m_boMaster := True;
            end;
            PlayObject.m_MasterList.Add(PoseHuman);
            PoseHuman.m_sMasterName := PlayObject.m_sCharName;
            PoseHuman.m_boMaster := False;
            PlayObject.RefShowName;
            PoseHuman.RefShowName;
          end;
        end;
      end
      else
      begin
        if PlayObject.m_boStartMaster and PoseHuman.m_boStartMaster then
        begin
          GotoLable(PlayObject, '@EndMasterFail', False);
          GotoLable(PoseHuman, '@EndMasterFail', False);
          PlayObject.m_boStartMaster := False;
          PoseHuman.m_boStartMaster := False;
        end;
      end;
      exit;
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfMaster');
  end;
end;

procedure TNormNpc.ActionOfMessageBox(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  try
    PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0,
      GetLineVariableText(PlayObject, QuestActionInfo.sParam1));
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfMessageBox');
  end;
end;

procedure TNormNpc.ActionOfMission(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  try
    if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.nParam2 > 0) and
      (QuestActionInfo.nParam3 > 0) then
    begin
      g_sMissionMap := QuestActionInfo.sParam1;
      g_nMissionX := QuestActionInfo.nParam2;
      g_nMissionY := QuestActionInfo.nParam3;
    end
    else
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MISSION);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfMission');
  end;
end;

//MOBFIREBURN MAP X Y TYPE TIME POINT

procedure TNormNpc.ActionOfMobFireBurn(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMap: string;
  nX, nY, nType, nTime, nPoint: Integer;
  FireBurnEvent: TFireBurnEvent;
  Envir: TEnvirnoment;
  OldEnvir: TEnvirnoment;
begin
  try
    sMap := QuestActionInfo.sParam1;
    nX := Str_ToInt(QuestActionInfo.sParam2, -1);
    nY := Str_ToInt(QuestActionInfo.sParam3, -1);
    nType := Str_ToInt(QuestActionInfo.sParam4, -1);
    nTime := Str_ToInt(QuestActionInfo.sParam5, -1);
    nPoint := Str_ToInt(QuestActionInfo.sParam6, -1);
    if (sMap = '') or (nX < 0) or (nY < 0) or (nType < 0) or (nTime < 0) or
      (nPoint < 0) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBFIREBURN);
      exit;
    end;
    Envir := g_MapManager.FindMap(sMap);
    if Envir <> nil then
    begin
      OldEnvir := PlayObject.m_PEnvir;
      PlayObject.m_PEnvir := Envir;
      FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, nType, nTime *
        1000, nPoint);
      FireBurnEvent.m_boIsVisible := False;
      g_EventManager.AddEvent(FireBurnEvent);
      PlayObject.m_PEnvir := OldEnvir;
      exit;
    end;
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBFIREBURN);

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfMobFireBurn');
  end;
end;

procedure TNormNpc.ActionOfMobPlace(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo; nX, nY, nCount, nRange: Integer);
var
  I: integer;
  nRandX, nRandY: Integer;
  Mon: TBaseObject;
begin
  try
    if QuestActionInfo.sParam2 <> '' then
    begin
      Mon := UserEngine.RegenMonsterByName(m_MissionMap, m_nMissionX,
        m_nMissionY, QuestActionInfo.sParam1, PlayObject);
      if Mon <> nil then
      begin
        if Mon is TAnimalObject then
        begin
          if m_FPath <> nil then
            TAnimalObject(Mon).m_FPath := @m_FPath
          else
            TAnimalObject(Mon).m_FPath := nil;
          TAnimalObject(Mon).m_FPathIdx := 1;
          Mon.m_MissIonEx := True;
          Mon.m_Master2 := PlayObject;
          if PlayObject.m_AllMaster <> nil then
            Mon.m_AllMaster := PlayObject.m_AllMaster
          else
            Mon.m_AllMaster := PlayObject;
          Mon.m_dwMasterRoyaltyTick := GetTickCount + 24 * 60 * 60 * 1000;
          Mon.m_btSlaveMakeLevel := 3;
          Mon.m_btSlaveExpLevel := 0;
          Mon.m_boAutoGhost := True;
          Mon.m_boRun := True;
        end;
      end
      else
      begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBPLACE);
      end;
    end
    else
    begin
      for I := 0 to nCount - 1 do
      begin
        nRandX := Random(nRange * 2 + 1) + (nX - nRange);
        nRandY := Random(nRange * 2 + 1) + (nY - nRange);
        Mon := UserEngine.RegenMonsterByName(g_sMissionMap, nRandX, nRandY,
          QuestActionInfo.sParam1);
        if Mon <> nil then
        begin
          Mon.m_boMission := True;
          Mon.m_nMissionX := g_nMissionX;
          Mon.m_nMissionY := g_nMissionY;
          Mon.m_boRun := True;
        end
        else
        begin
          ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBPLACE);
          break;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfMobPlace');
  end;
end;

{procedure TNormNpc.ActionOfRecallGroupMembers(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
Try

Except
  MainOutMessage('[Exception] TNormNpc.ActionOfRecallGroupMembers');
End;
end; }

procedure TNormNpc.ActionOfSetRankLevelName(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sRankLevelName: string;
begin
  try
    sRankLevelName := QuestActionInfo.sParam1;
    if sRankLevelName = '' then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETRANKLEVELNAME);
      exit;
    end;
    PlayObject.m_sRankLevelName := sRankLevelName;
    PlayObject.RefShowName;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfSetRankLevelName');
  end;
end;

procedure TNormNpc.ActionOfSetScriptFlag(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boFlag: Boolean;
  nWhere: Integer;
begin
  try
    nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
    boFlag := Str_ToInt(QuestActionInfo.sParam2, -1) = 1;
    case nWhere of //
      0:
        begin
          PlayObject.m_boSendMsgFlag := boFlag;
        end;
      1:
        begin
          PlayObject.m_boChangeItemNameFlag := boFlag;
        end;
    else
      begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETSCRIPTFLAG);
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfSetScriptFlag');
  end;
end;

procedure TNormNpc.ActionOfSkillLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
  nLevel: Integer;
  cMethod: Char;
begin
  try
    nLevel := Str_ToInt(QuestActionInfo.sParam3, 0);
    if nLevel < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SKILLLEVEL);
      exit;
    end;
    cMethod := QuestActionInfo.sParam2[1];
    Magic := UserEngine.FindMagic(QuestActionInfo.sParam1, PlayObject.m_boHero);
    if Magic <> nil then
    begin
      for I := 0 to PlayObject.m_MagicList.Count - 1 do
      begin
        UserMagic := PlayObject.m_MagicList.Items[I];
        if UserMagic.MagicInfo = Magic then
        begin
          case cMethod of
            '=':
              begin
                if nLevel >= 0 then
                begin
                  nLevel := _MAX(3, nLevel);
                  UserMagic.btLevel := nLevel;
                end;
              end;
            '-':
              begin
                if UserMagic.btLevel >= nLevel then
                begin
                  Dec(UserMagic.btLevel, nLevel);
                end
                else
                begin
                  UserMagic.btLevel := 0;
                end;
              end;
            '+':
              begin
                if UserMagic.btLevel + nLevel <= 3 then
                begin
                  Inc(UserMagic.btLevel, nLevel);
                end
                else
                begin
                  UserMagic.btLevel := 3;
                end;
              end;
          end;
          PlayObject.SendDelayMsg(PlayObject, RM_MAGIC_LVEXP, 0,
            UserMagic.MagicInfo.wMagicId, UserMagic.btLevel,
            UserMagic.nTranPoint,
            '', 100);
          break;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfSkillLevel');
  end;
end;

procedure TNormNpc.ActionOfCHANGETRANPOINT(PlayObject: TPlayObject; QuestActionInfo:
 pTQuestActionInfo);
var
  I: Integer;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
  TRANPOINT: Integer;
  cMethod: Char;
begin
  try
    TRANPOINT := Str_ToInt(QuestActionInfo.sParam3, 0);
    if TRANPOINT < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSc_CHANGETRANPOINT);
      exit;
    end;
    cMethod := QuestActionInfo.sParam2[1];
    Magic := UserEngine.FindMagic(QuestActionInfo.sParam1, PlayObject.m_boHero);
    if Magic <> nil then
    begin
      for I := 0 to PlayObject.m_MagicList.Count - 1 do
      begin
        UserMagic := PlayObject.m_MagicList.Items[I];
        if UserMagic.MagicInfo = Magic then
        begin
          case cMethod of
            '=':
              begin
                if TRANPOINT >= 0 then
                begin
                  UserMagic.nTranPoint:=TRANPOINT;
                end;
              end;
            '-':
              begin
                if UserMagic.nTranPoint >= TRANPOINT then
                begin
                  Dec(UserMagic.nTranPoint, TRANPOINT);
                end
                else
                begin
                  UserMagic.nTranPoint := 0;
                end;
              end;
            '+':
              begin
                 Inc(UserMagic.nTranPoint, TRANPOINT);
              end;
          end;
          PlayObject.SendDelayMsg(PlayObject, RM_MAGIC_LVEXP, 0,
            UserMagic.MagicInfo.wMagicId, UserMagic.btLevel,
            UserMagic.nTranPoint,
            '', 100);
          break;
        end;
      end;
    end;

  except
       MainOutMessage('[Exception] TNormNpc.ActionOfCHANGETRANPOINT');
  end;
end;

procedure TNormNpc.ActionOfTakeCastleGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGold: Integer;
begin
  try
    nGold := Str_ToInt(QuestActionInfo.sParam1, -1);
    if (nGold < 0) or (m_Castle = nil) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_TAKECASTLEGOLD);
      exit;
    end;

    if nGold <= TUserCastle(m_Castle).m_nTotalGold then
    begin
      Dec(TUserCastle(m_Castle).m_nTotalGold, nGold);
    end
    else
    begin
      TUserCastle(m_Castle).m_nTotalGold := 0;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfTakeCastleGold');
  end;
end;

procedure TNormNpc.ActionOfUnMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  LoadList: TStringList;
  sUnMarryFileName: string;
begin
  try
    if PlayObject.m_sDearName = '' then
    begin
      GotoLable(PlayObject, '@ExeMarryFail', False);
      exit;
    end;
    PoseHuman := TPlayObject(PlayObject.GetPoseCreate);
    if PoseHuman = nil then
    begin
      GotoLable(PlayObject, '@UnMarryCheckDir', False);
    end;
    if PoseHuman <> nil then
    begin
      if QuestActionInfo.sParam1 = '' then
      begin
        if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then
        begin
          GotoLable(PlayObject, '@UnMarryTypeErr', False);
          exit;
        end;
        if PoseHuman.GetPoseCreate = PlayObject then
        begin
          if (PlayObject.m_sDearName = PoseHuman.m_sCharName)
            {and (PosHum.AddInfo.sDearName = Hum.sName)}then
          begin
            GotoLable(PlayObject, '@StartUnMarry', False);
            GotoLable(PoseHuman, '@StartUnMarry', False);
            exit;
          end;
        end;
      end;
    end;
    if (CompareText(QuestActionInfo.sParam1, 'REQUESTUNMARRY' {sREQUESTUNMARRY})
      = 0) then
    begin
      if (QuestActionInfo.sParam2 = '') then
      begin
        if PoseHuman <> nil then
        begin
          PlayObject.m_boStartUnMarry := True;
          if PlayObject.m_boStartUnMarry and PoseHuman.m_boStartUnMarry then
          begin
            UserEngine.SendBroadCastMsg('[' + m_sCharName + ']: ' + '我宣布'
              {sUnMarryMsg8}+ PoseHuman.m_sCharName + ' ' + '与' {sMarryMsg0} +
              PlayObject.m_sCharName + ' ' + ' ' + '正式脱离夫妻关系。'
              {sUnMarryMsg9}, t_Say);
            PlayObject.m_sDearName := '';
            PoseHuman.m_sDearName := '';
            Inc(PlayObject.m_btMarryCount);
            Inc(PoseHuman.m_btMarryCount);
            PlayObject.m_boStartUnMarry := False;
            PoseHuman.m_boStartUnMarry := False;
            PlayObject.RefShowName;
            PoseHuman.RefShowName;
            GotoLable(PlayObject, '@UnMarryEnd', False);
            GotoLable(PoseHuman, '@UnMarryEnd', False);
          end
          else
          begin
            GotoLable(PlayObject, '@WateUnMarry', False);
            //          GotoLable(PoseHuman,'@RevUnMarry',False);
          end;
        end;
        exit;
      end
      else
      begin
        //强行离婚
        if (CompareText(QuestActionInfo.sParam2, 'FORCE') = 0) then
        begin
          UserEngine.SendBroadCastMsg('[' + m_sCharName + ']: ' + '我宣布'
            {sUnMarryMsg8}+ PlayObject.m_sCharName + ' ' + '与' {sMarryMsg0} +
            PlayObject.m_sDearName + ' ' + ' ' +
            '已经正式脱离夫妻关系！！！' {sUnMarryMsg9}, t_Say);
          PoseHuman := UserEngine.GeTPlayObject(PlayObject.m_sDearName);
          if PoseHuman <> nil then
          begin
            PoseHuman.m_sDearName := '';
            Inc(PoseHuman.m_btMarryCount);
            PoseHuman.RefShowName;
          end
          else
          begin
            sUnMarryFileName := g_Config.sEnvirDir + 'UnMarry.txt';
            LoadList := TStringList.Create;
            if FileExists(sUnMarryFileName) then
            begin
              LoadList.LoadFromFile(sUnMarryFileName);
            end;
            LoadList.Add(PlayObject.m_sDearName);
            LoadList.SaveToFile(sUnMarryFileName);
            LoadList.Free;
          end;
          PlayObject.m_sDearName := '';
          Inc(PlayObject.m_btMarryCount);
          GotoLable(PlayObject, '@UnMarryEnd', False);
          PlayObject.RefShowName;
        end;
        exit;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfUnMarry');
  end;
end;

procedure TNormNpc.ClearScript; //0049E914
{var
  III,IIII: Integer;
  I,II: Integer;
  Script:pTScript;
  SayingRecord:pTSayingRecord;
  SayingProcedure:pTSayingProcedure; }
begin
  try
    m_ScriptList.Clear;
    {for I := 0 to m_ScriptList.Count - 1 do begin
      Script:=m_ScriptList.Items[i];
      for II := 0 to Script.RecordList.Count - 1 do begin
        SayingRecord:=Script.RecordList.Items[II];
        for III := 0 to SayingRecord.ProcedureList.Count - 1 do begin
          SayingProcedure:=SayingRecord.ProcedureList.Items[III];
          for IIII := 0 to SayingProcedure.ConditionList.Count - 1 do begin
            Dispose(pTQuestConditionInfo(SayingProcedure.ConditionList.Items[IIII]));
          end;
          for IIII := 0 to SayingProcedure.ActionList.Count - 1 do begin
            Dispose(pTQuestActionInfo(SayingProcedure.ActionList.Items[IIII]));
          end;
          for IIII := 0 to SayingProcedure.ElseActionList.Count - 1 do begin
            Dispose(pTQuestActionInfo(SayingProcedure.ElseActionList.Items[IIII]));
          end;
          SayingProcedure.ConditionList.Free;
          SayingProcedure.ActionList.Free;
          SayingProcedure.ElseActionList.Free;
          Dispose(SayingProcedure);
        end;    // for
        SayingRecord.ProcedureList.Free;
        Dispose(SayingRecord);
      end;    // for
      Script.RecordList.Free;
      Dispose(Script);
    end;    // for
    m_ScriptList.Clear; }
  except
    MainOutMessage('[Exception] TNormNpc.ClearScript');
  end;
end;

procedure TNormNpc.Click(PlayObject: TPlayObject); //0049EC18
begin
  try
    PlayObject.m_nScriptGotoCount := 0;
    PlayObject.m_sScriptGoBackLable := '';
    PlayObject.m_sScriptCurrLable := '';
    if PlayObject.m_boHero then
    begin
      if PlayObject.m_HeroHuman <> nil then
        GotoLable(TPlayObject(PlayObject.m_HeroHuman), '@main', False);
    end
    else
      GotoLable(PlayObject, '@main', False);
  except
    MainOutMessage('[Exception] TNormNpc.Click');
  end;
end;

function TNormNpc.ConditionOfCheckAccountIPList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sCharName: string;
  sCharAccount: string;
  sCharIPaddr: string;
  sLine: string;
  sName: string;
  sIPaddr: string;
begin
  try
    Result := False;
    sCharName := PlayObject.m_sCharName;
    sCharAccount := PlayObject.m_sUserID;
    sCharIPaddr := PlayObject.m_sIPaddr;
    LoadList := TStringList.Create;
    try
      if FileExists(g_Config.sEnvirDir + QuestConditionInfo.sParam1) then
      begin
        LoadList.LoadFromFile(g_Config.sEnvirDir + QuestConditionInfo.sParam1);
        for I := 0 to LoadList.Count - 1 do
        begin
          sLine := LoadList.Strings[i];
          if sLine[1] = ';' then
            Continue;
          sIPaddr := GetValidStr3(sLine, sName, [' ', '/', #9]);
          sIPaddr := Trim(sIPaddr);
          if (sName = sCharAccount) and (sIPaddr = sCharIPaddr) then
          begin
            Result := True;
            break;
          end;
        end;
      end
      else
      begin
        ScriptConditionError(PlayObject, QuestConditionInfo,
          sSC_CHECKACCOUNTIPLIST);
      end;
    finally
      LoadList.Free
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckAccountIPList');
  end;
end;

function TNormNpc.ConditionOfCheckBagSize(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nSize: Integer;
begin
  try
    Result := False;
    nSize := QuestConditionInfo.nParam1;
    if (nSize <= 0) or (nSize > MAXBAGITEM) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKBAGSIZE);
      exit;
    end;
    if PlayObject.m_ItemList.Count + nSize <= MAXBAGITEM then
      Result := True;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckBagSize');
  end;
end;

function TNormNpc.ConditionOfCheckBonusPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nTotlePoint: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    nTotlePoint := m_BonusAbil.DC +
      m_BonusAbil.MC +
      m_BonusAbil.SC +
      m_BonusAbil.AC +
      m_BonusAbil.MAC +
      m_BonusAbil.HP +
      m_BonusAbil.MP +
      m_BonusAbil.Hit +
      m_BonusAbil.Speed +
      m_BonusAbil.X2;

    nTotlePoint := nTotlePoint + m_nBonusPoint;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if nTotlePoint = QuestConditionInfo.nParam2 then
          Result := True;
      '>': if nTotlePoint > QuestConditionInfo.nParam2 then
          Result := True;
      '<': if nTotlePoint < QuestConditionInfo.nParam2 then
          Result := True;
    else if nTotlePoint >= QuestConditionInfo.nParam2 then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckBonusPoint');
  end;
end;

function TNormNpc.ConditionOfCheckHP(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMin, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=':
        begin
          if PlayObject.m_WAbil.MaxHP = nMax then
          begin
            Result := True;
          end;
        end;
      '>':
        begin
          if PlayObject.m_WAbil.MaxHP > nMax then
          begin
            Result := True;
          end;
        end;
      '<':
        begin
          if PlayObject.m_WAbil.MaxHP < nMax then
          begin
            Result := True;
          end;
        end;
    else
      begin
        if PlayObject.m_WAbil.MaxHP >= nMax then
        begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  try
    Result := False;
    cMethodMin := QuestConditionInfo.sParam1[1];
    cMethodMax := QuestConditionInfo.sParam1[3];
    nMin := Str_ToInt(QuestConditionInfo.sParam2, -1);
    nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);
    if (nMin < 0) or (nMax < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKHP);
      exit;
    end;

    case cMethodMin of
      '=':
        begin
          if (m_WAbil.HP = nMin) then
          begin
            Result := CheckHigh;
          end;
        end;
      '>':
        begin
          if (PlayObject.m_WAbil.HP > nMin) then
          begin
            Result := CheckHigh;
          end;
        end;
      '<':
        begin
          if (PlayObject.m_WAbil.HP < nMin) then
          begin
            Result := CheckHigh;
          end;
        end;
    else
      begin
        if (PlayObject.m_WAbil.HP >= nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckHP');
  end;
end;

function TNormNpc.ConditionOfCheckMP(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMin, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=':
        begin
          if PlayObject.m_WAbil.MaxMP = nMax then
          begin
            Result := True;
          end;
        end;
      '>':
        begin
          if PlayObject.m_WAbil.MaxMP > nMax then
          begin
            Result := True;
          end;
        end;
      '<':
        begin
          if PlayObject.m_WAbil.MaxMP < nMax then
          begin
            Result := True;
          end;
        end;
    else
      begin
        if PlayObject.m_WAbil.MaxMP >= nMax then
        begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  try
    Result := False;
    cMethodMin := QuestConditionInfo.sParam1[1];
    cMethodMax := QuestConditionInfo.sParam1[3];
    nMin := Str_ToInt(QuestConditionInfo.sParam2, -1);
    nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);
    if (nMin < 0) or (nMax < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMP);
      exit;
    end;

    case cMethodMin of
      '=':
        begin
          if (m_WAbil.MP = nMin) then
          begin
            Result := CheckHigh;
          end;
        end;
      '>':
        begin
          if (PlayObject.m_WAbil.MP > nMin) then
          begin
            Result := CheckHigh;
          end;
        end;
      '<':
        begin
          if (PlayObject.m_WAbil.MP < nMin) then
          begin
            Result := CheckHigh;
          end;
        end;
    else
      begin
        if (PlayObject.m_WAbil.MP >= nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckMP');
  end;
end;

function TNormNpc.ConditionOfCheckDC(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMin, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=':
        begin
          if HiWord(PlayObject.m_WAbil.DC) = nMax then
          begin
            Result := True;
          end;
        end;
      '>':
        begin
          if HiWord(PlayObject.m_WAbil.DC) > nMax then
          begin
            Result := True;
          end;
        end;
      '<':
        begin
          if HiWord(PlayObject.m_WAbil.DC) < nMax then
          begin
            Result := True;
          end;
        end;
    else
      begin
        if HiWord(PlayObject.m_WAbil.DC) >= nMax then
        begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  try
    Result := False;
    cMethodMin := QuestConditionInfo.sParam1[1];
    cMethodMax := QuestConditionInfo.sParam1[3];
    nMin := Str_ToInt(QuestConditionInfo.sParam2, -1);
    nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);
    if (nMin < 0) or (nMax < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKDC);
      exit;
    end;

    case cMethodMin of
      '=':
        begin
          if (LoWord(PlayObject.m_WAbil.DC) = nMin) then
          begin
            Result := CheckHigh;
          end;
        end;
      '>':
        begin
          if (LoWord(PlayObject.m_WAbil.DC) > nMin) then
          begin
            Result := CheckHigh;
          end;
        end;
      '<':
        begin
          if (LoWord(PlayObject.m_WAbil.DC) < nMin) then
          begin
            Result := CheckHigh;
          end;
        end;
    else
      begin
        if (LoWord(PlayObject.m_WAbil.DC) >= nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
    end;

    Result := False;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckDC');
  end;
end;

function TNormNpc.ConditionOfCheckMC(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMin, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=':
        begin
          if HiWord(PlayObject.m_WAbil.MC) = nMax then
          begin
            Result := True;
          end;
        end;
      '>':
        begin
          if HiWord(PlayObject.m_WAbil.MC) > nMax then
          begin
            Result := True;
          end;
        end;
      '<':
        begin
          if HiWord(PlayObject.m_WAbil.MC) < nMax then
          begin
            Result := True;
          end;
        end;
    else
      begin
        if HiWord(PlayObject.m_WAbil.MC) >= nMax then
        begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  try
    Result := False;
    cMethodMin := QuestConditionInfo.sParam1[1];
    cMethodMax := QuestConditionInfo.sParam1[3];
    nMin := Str_ToInt(QuestConditionInfo.sParam2, -1);
    nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);
    if (nMin < 0) or (nMax < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMC);
      exit;
    end;

    case cMethodMin of
      '=':
        begin
          if (LoWord(PlayObject.m_WAbil.MC) = nMin) then
          begin
            Result := CheckHigh;
          end;
        end;
      '>':
        begin
          if (LoWord(PlayObject.m_WAbil.MC) > nMin) then
          begin
            Result := CheckHigh;
          end;
        end;
      '<':
        begin
          if (LoWord(PlayObject.m_WAbil.MC) < nMin) then
          begin
            Result := CheckHigh;
          end;
        end;
    else
      begin
        if (LoWord(PlayObject.m_WAbil.MC) >= nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckMC');
  end;
end;

function TNormNpc.ConditionOfCheckSC(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMin, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=':
        begin
          if HiWord(PlayObject.m_WAbil.SC) = nMax then
          begin
            Result := True;
          end;
        end;
      '>':
        begin
          if HiWord(PlayObject.m_WAbil.SC) > nMax then
          begin
            Result := True;
          end;
        end;
      '<':
        begin
          if HiWord(PlayObject.m_WAbil.SC) < nMax then
          begin
            Result := True;
          end;
        end;
    else
      begin
        if HiWord(PlayObject.m_WAbil.SC) >= nMax then
        begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  try
    Result := False;
    cMethodMin := QuestConditionInfo.sParam1[1];
    cMethodMax := QuestConditionInfo.sParam1[3];
    nMin := Str_ToInt(QuestConditionInfo.sParam2, -1);
    nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);
    if (nMin < 0) or (nMax < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSC);
      exit;
    end;

    case cMethodMin of
      '=':
        begin
          if (LoWord(PlayObject.m_WAbil.SC) = nMin) then
          begin
            Result := CheckHigh;
          end;
        end;
      '>':
        begin
          if (LoWord(PlayObject.m_WAbil.SC) > nMin) then
          begin
            Result := CheckHigh;
          end;
        end;
      '<':
        begin
          if (LoWord(PlayObject.m_WAbil.SC) < nMin) then
          begin
            Result := CheckHigh;
          end;
        end;
    else
      begin
        if (LoWord(PlayObject.m_WAbil.SC) >= nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckSC');
  end;
end;

function TNormNpc.ConditionOfCheckExp(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  dwExp: LongWord;
begin
  try
    Result := False;
    dwExp := Str_ToInt(QuestConditionInfo.sParam2, 0);
    if dwExp = 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKEXP);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_Abil.Exp = dwExp then
          Result := True;
      '>': if PlayObject.m_Abil.Exp > dwExp then
          Result := True;
      '<': if PlayObject.m_Abil.Exp < dwExp then
          Result := True;
    else if PlayObject.m_Abil.Exp >= dwExp then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckExp');
  end;
end;

function TNormNpc.ConditionOfCheckFlourishPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGuild;
begin
  try
    Result := False;
    nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nPoint < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKFLOURISHPOINT);
      exit;
    end;
    if PlayObject.m_MyGuild = nil then
    begin
      exit;
    end;
    Guild := TGuild(PlayObject.m_MyGuild);
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if Guild.nFlourishing = nPoint then
          Result := True;
      '>': if Guild.nFlourishing > nPoint then
          Result := True;
      '<': if Guild.nFlourishing < nPoint then
          Result := True;
    else if Guild.nFlourishing >= nPoint then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckFlourishPoint');
  end;
end;

function TNormNpc.ConditionOfCheckChiefItemCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nCount: Integer;
  Guild: TGuild;
begin
  try
    Result := False;
    nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nCount < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKFLOURISHPOINT);
      exit;
    end;
    if PlayObject.m_MyGuild = nil then
    begin
      exit;
    end;
    Guild := TGuild(PlayObject.m_MyGuild);
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if Guild.nChiefItemCount = nCount then
          Result := True;
      '>': if Guild.nChiefItemCount > nCount then
          Result := True;
      '<': if Guild.nChiefItemCount < nCount then
          Result := True;
    else if Guild.nChiefItemCount >= nCount then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckChiefItemCount');
  end;
end;

function TNormNpc.ConditionOfCheckGuildAuraePoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGuild;
begin
  try
    Result := False;
    nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nPoint < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKAURAEPOINT);
      exit;
    end;
    if PlayObject.m_MyGuild = nil then
    begin
      exit;
    end;
    Guild := TGuild(PlayObject.m_MyGuild);
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if Guild.nAurae = nPoint then
          Result := True;
      '>': if Guild.nAurae > nPoint then
          Result := True;
      '<': if Guild.nAurae < nPoint then
          Result := True;
    else if Guild.nAurae >= nPoint then
      Result := True;
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckGuildAuraePoint');
  end;
end;

function TNormNpc.ConditionOfCheckGuildBuildPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGuild;
begin
  try
    Result := False;
    nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nPoint < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKBUILDPOINT);
      exit;
    end;
    if PlayObject.m_MyGuild = nil then
    begin
      exit;
    end;
    Guild := TGuild(PlayObject.m_MyGuild);
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if Guild.nBuildPoint = nPoint then
          Result := True;
      '>': if Guild.nBuildPoint > nPoint then
          Result := True;
      '<': if Guild.nBuildPoint < nPoint then
          Result := True;
    else if Guild.nBuildPoint >= nPoint then
      Result := True;
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckGuildBuildPoint');
  end;
end;

function TNormNpc.ConditionOfCheckStabilityPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGuild;
begin
  try
    Result := False;
    nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nPoint < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKSTABILITYPOINT);
      exit;
    end;
    if PlayObject.m_MyGuild = nil then
    begin
      exit;
    end;
    Guild := TGuild(PlayObject.m_MyGuild);
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if Guild.nStability = nPoint then
          Result := True;
      '>': if Guild.nStability > nPoint then
          Result := True;
      '<': if Guild.nStability < nPoint then
          Result := True;
    else if Guild.nStability >= nPoint then
      Result := True;
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckStabilityPoint');
  end;
end;

function TNormNpc.ConditionOfCheckGameGold(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGameGold: Integer;
begin
  try
    Result := False;
    nGameGold := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nGameGold < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEGOLD);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_nGameGold = nGameGold then
          Result := True;
      '>': if PlayObject.m_nGameGold > nGameGold then
          Result := True;
      '<': if PlayObject.m_nGameGold < nGameGold then
          Result := True;
    else if PlayObject.m_nGameGold >= nGameGold then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckGameGold');
  end;
end;

function TNormNpc.ConditionOfCheckGamePoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGamePoint: Integer;
begin
  try
    Result := False;
    nGamePoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nGamePoint < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEPOINT);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_nGamePoint = nGamePoint then
          Result := True;
      '>': if PlayObject.m_nGamePoint > nGamePoint then
          Result := True;
      '<': if PlayObject.m_nGamePoint < nGamePoint then
          Result := True;
    else if PlayObject.m_nGamePoint >= nGamePoint then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckGamePoint');
  end;
end;

function TNormNpc.ConditionOfCheckGameDiamond(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nCount < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKGAMEDIAMOND);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_nGameDiamond = nCount then
          Result := True;
      '>': if PlayObject.m_nGameDiamond > nCount then
          Result := True;
      '<': if PlayObject.m_nGameDiamond < nCount then
          Result := True;
    else if PlayObject.m_nGameDiamond >= nCount then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckGameDiamond');
  end;
end;

function TNormNpc.ConditionOfMapHumIsSameGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  Envir: TEnvirnoment;
  I: integer;
  TempObject: TPlayObject;
  Guild: TGuild;
begin
  try
    Result := False;
    //if PlayObject.m_MyGuild=Nil then exit;
    if QuestConditionInfo.sParam1 = '' then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_MAPHUMISSAMEGUILD);
      exit;
    end;
    Envir := g_MapManager.FindMap(QuestConditionInfo.sParam1);
    if Envir = nil then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_MAPHUMISSAMEGUILD);
      exit;
    end;
    if QuestConditionInfo.sParam2 = '' then
    begin
      Guild := TGuild(PlayObject.m_MyGuild);
    end
    else
    begin
      Guild := g_GuildManager.FindGuild(QuestConditionInfo.sParam2);
    end;
    if Guild <> nil then
    begin
      Result := True;
      for i := UserEngine.m_PlayObjectList.Count - 1 downto 0 do
      begin
        TempObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[I]);
        if (TempObject <> nil) and
          (TempObject.m_PEnvir = Envir) then
        begin
          if TempObject.m_MyGuild <> Guild then
          begin
            Result := False;
            break;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckGameDiamond');
  end;
end;

function TNormNpc.ConditionOfCheckCastlewar(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  Castle: TUserCastle;
begin
  try
    Result := False;
    if QuestConditionInfo.sParam1 = '' then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CheckCastlewar);
      exit;
    end;
    Castle := g_CastleManager.Find(QuestConditionInfo.sParam1);
    if Castle = nil then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CheckCastlewar);
      exit;
    end;
    Result := Castle.m_boUnderWar;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckCastlewar');
  end;
end;

function TNormNpc.ConditionOfCheckGameGird(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nCount < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEGIRD);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_nGameGird = nCount then
          Result := True;
      '>': if PlayObject.m_nGameGird > nCount then
          Result := True;
      '<': if PlayObject.m_nGameGird < nCount then
          Result := True;
    else if PlayObject.m_nGameGird >= nCount then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckGameGird');
  end;
end;

function TNormNpc.ConditionOfCheckGroupCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nCount: Integer;
begin
  try
    Result := False;
    if PlayObject.m_GroupOwner = nil then
      exit;
    nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nCount < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGROUPCOUNT);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_GroupOwner.m_GroupMembers.Count = nCount then
          Result := True;
      '>': if PlayObject.m_GroupOwner.m_GroupMembers.Count > nCount then
          Result := True;
      '<': if PlayObject.m_GroupOwner.m_GroupMembers.Count < nCount then
          Result := True;
    else if PlayObject.m_GroupOwner.m_GroupMembers.Count >= nCount then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckGroupCount');
  end;
end;

function TNormNpc.ConditionOfCheckHaveGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
    //  Result:=PlayObject.m_MyGuild = nil;
    Result := PlayObject.m_MyGuild <> nil; // 01-16 更正检查结果反了
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckHaveGuild');
  end;
end;

function TNormNpc.ConditionOfCheckInMapRange(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sMapName: string;
  nX, nY, nRange: Integer;
begin
  try
    Result := False;
    sMapName := QuestConditionInfo.sParam1;
    nX := Str_ToInt(QuestConditionInfo.sParam2, -1);
    nY := Str_ToInt(QuestConditionInfo.sParam3, -1);
    nRange := Str_ToInt(QuestConditionInfo.sParam4, -1);
    if (sMapName = '') or (nX < 0) or (nY < 0) or (nRange < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKINMAPRANGE);
      exit;
    end;
    if CompareText(PlayObject.m_sMapName, sMapName) <> 0 then
      exit;
    if (abs(PlayObject.m_nCurrX - nX) <= nRange) and (abs(PlayObject.m_nCurrY -
      nY) <= nRange) then
      Result := True;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckInMapRange');
  end;
end;

function TNormNpc.ConditionOfCheckIsAttackGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
    Result := False;
    if m_Castle = nil then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISATTACKGUILD);
      exit;
    end;
    if PlayObject.m_MyGuild = nil then
      exit;
    Result := TUserCastle(m_Castle).IsAttackGuild(TGuild(PlayObject.m_MyGuild));
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckIsAttackGuild');
  end;
end;

function TNormNpc.ConditionOfCheckCastleChageDay(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nDay: Integer;
  cMethod: Char;
  nChangeDay: Integer;
begin
  try
    Result := False;
    nDay := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if (nDay < 0) or (m_Castle = nil) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CASTLECHANGEDAY);
      exit;
    end;
    nChangeDay := GetDayCount(Now, TUserCastle(m_Castle).m_ChangeDate);
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if nChangeDay = nDay then
          Result := True;
      '>': if nChangeDay > nDay then
          Result := True;
      '<': if nChangeDay < nDay then
          Result := True;
    else if nChangeDay >= nDay then
      Result := True;
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckCastleChageDay');
  end;
end;

function TNormNpc.ConditionOfCheckCastleWarDay(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nDay: Integer;
  cMethod: Char;
  nWarDay: Integer;
begin
  try
    Result := False;
    nDay := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if (nDay < 0) or (m_Castle = nil) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CASTLEWARDAY);
      exit;
    end;
    nWarDay := GetDayCount(Now, TUserCastle(m_Castle).m_WarDate);
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if nWarDay = nDay then
          Result := True;
      '>': if nWarDay > nDay then
          Result := True;
      '<': if nWarDay < nDay then
          Result := True;
    else if nWarDay >= nDay then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckCastleWarDay');
  end;
end;

function TNormNpc.ConditionOfCheckCastleDoorStatus(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nDay: Integer;
  //  cMethod:Char;
  nDoorStatus: Integer;
  CastleDoor: TCastleDoor;
begin
  try
    Result := False;
    nDay := Str_ToInt(QuestConditionInfo.sParam2, -1);
    nDoorStatus := -1;
    if CompareText(QuestConditionInfo.sParam1, '损坏') = 0 then
      nDoorStatus := 0;
    if CompareText(QuestConditionInfo.sParam1, '开启') = 0 then
      nDoorStatus := 1;
    if CompareText(QuestConditionInfo.sParam1, '关闭') = 0 then
      nDoorStatus := 2;

    if (nDay < 0) or (m_Castle = nil) or (nDoorStatus < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCASTLEDOOR);
      exit;
    end;
    CastleDoor := TCastleDoor(TUserCastle(m_Castle).m_MainDoor.BaseObject);

    case nDoorStatus of
      0: if CastleDoor.m_boDeath then
          Result := True;
      1: if CastleDoor.m_boOpened then
          Result := True;
      2: if not CastleDoor.m_boOpened then
          Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckCastleDoorStatus');
  end;
end;

{function TNormNpc.ConditionOfCheckIsAttackAllyGuild(
  PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result:=False;
  if m_Castle = nil then begin
    ScriptConditionError(PlayObject,QuestConditionInfo,sSC_ISATTACKALLYGUILD);
    exit;
  end;
  if PlayObject.m_MyGuild = nil then exit;
  Result:=TUserCastle(m_Castle).IsAttackAllyGuild(TGuild(PlayObject.m_MyGuild));
end;  }

{function TNormNpc.ConditionOfCheckIsDefenseAllyGuild(
  PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result:=False;
  if m_Castle = nil then begin
    ScriptConditionError(PlayObject,QuestConditionInfo,sSC_ISDEFENSEALLYGUILD);
    exit;
  end;

  if PlayObject.m_MyGuild = nil then exit;
  Result:=TUserCastle(m_Castle).IsDefenseAllyGuild(TGuild(PlayObject.m_MyGuild));
end;}

function TNormNpc.ConditionOfCheckIsDefenseGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
    Result := False;
    if m_Castle = nil then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISDEFENSEGUILD);
      exit;
    end;

    if PlayObject.m_MyGuild = nil then
      exit;
    Result :=
      TUserCastle(m_Castle).IsDefenseGuild(TGuild(PlayObject.m_MyGuild));
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckIsDefenseGuild');
  end;
end;

function TNormNpc.ConditionOfCheckIsCastleaGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
    Result := False;
    //  if (PlayObject.m_MyGuild <> nil) and (UserCastle.m_MasterGuild = PlayObject.m_MyGuild) then
    if g_CastleManager.IsCastleMember(PlayObject) <> nil then
      Result := True;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckIsCastleaGuild');
  end;
end;

function TNormNpc.ConditionOfCheckIsCastleMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
    Result := False;
    //if PlayObject.IsGuildMaster and (UserCastle.m_MasterGuild = PlayObject.m_MyGuild) then
    if PlayObject.IsGuildMaster and (g_CastleManager.IsCastleMember(PlayObject)
      <> nil) then
      Result := True;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckIsCastleMaster');
  end;
end;

function TNormNpc.ConditionOfCheckIsGuildMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
    Result := PlayObject.IsGuildMaster;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckIsGuildMaster');
  end;
end;

function TNormNpc.ConditionOfCheckIsMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
    Result := False;
    if (PlayObject.m_sMasterName <> '') and (PlayObject.m_boMaster) then
      Result := True;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckIsMaster');
  end;
end;

function TNormNpc.ConditionOfCheckListCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try

  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckListCount');
  end;
end;

function TNormNpc.ConditionOfCheckHeroLoyal(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount: Integer;
  cMethod: Char;
  HeroObject: TPlayObject;
begin
  try
    Result := False;
    if PlayObject.m_Hero = nil then
      exit;
    HeroObject := TPlayObject(PlayObject.m_Hero);
    nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if (nCount < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKHEROLOYAL);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if nCount = HeroObject.m_nGloryPoint then
          Result := True;
      '>': if HeroObject.m_nGloryPoint > nCount then
          Result := True;
      '<': if HeroObject.m_nGloryPoint < nCount then
          Result := True;
    else if HeroObject.m_nGloryPoint >= nCount then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckHeroLoyal');
  end;
end;

function TNormNpc.ConditionOfCheckGloryPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if (nCount < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGLORYPOINT);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if nCount = PlayObject.m_nGloryPoint then
          Result := True;
      '>': if PlayObject.m_nGloryPoint > nCount then
          Result := True;
      '<': if PlayObject.m_nGloryPoint < nCount then
          Result := True;
    else if PlayObject.m_nGloryPoint >= nCount then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckGloryPoint');
  end;
end;

function TNormNpc.ConditionOfCheckSideSlaveName(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nSide: Integer;
  nCount, myCount, I: Integer;
  cMethod: Char;
  BaseObject: TBaseObject;
begin
  try
    Result := False;
    nSide := Str_ToInt(QuestConditionInfo.sParam2, 0);
    nCount := Str_ToInt(QuestConditionInfo.sParam4, -1);
    if (nSide <= 0) or (nCount < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKSIDESLAVENAME);
      exit;
    end;
    myCount := 0;
    for I := 0 to PlayObject.m_SlaveList.Count - 1 do
    begin
      BaseObject := PlayObject.m_SlaveList.Items[i];
      if (not BaseObject.m_boDeath) and
        (not BaseObject.m_boGhost) and
        (abs(BaseObject.m_nCurrX - PlayObject.m_nCurrX) <= nSide) and
        (abs(BaseObject.m_nCurrY - PlayObject.m_nCurrY) <= nSide) then
      begin
        if QuestConditionInfo.sParam1 <> '*' then
        begin
          if CompareStr(BaseObject.m_sCharName, QuestConditionInfo.sParam1) = 0
            then
            Inc(myCount);
        end
        else
          Inc(myCount);
      end;
    end;
    cMethod := QuestConditionInfo.sParam3[1];
    case cMethod of
      '=': if nCount = myCount then
          Result := True;
      '>': if myCount > nCount then
          Result := True;
      '<': if myCount < nCount then
          Result := True;
    else if myCount >= nCount then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckSideSlaveName');
  end;
end;

function TNormNpc.ConditionOfCheckItemLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  //  I: Integer;
  nWhere, nAddValue: Integer;
  UserItem: pTUserItem;
  cMethod: Char;
begin
  try
    Result := False;
    nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
    nAddValue := Str_ToInt(QuestConditionInfo.sParam3, -1);
    if (not (nWhere in [Low(THumanUseItems)..High(THumanUseItems)])) or
    (nAddValue < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKITEMADDVALUE);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam2[1];
    UserItem := @PlayObject.m_UseItems[nWhere];
    if UserItem.wIndex = 0 then
    begin
      exit;
    end;
    case cMethod of
      '=': if nAddValue = UserItem.btValue[14] then
          Result := True;
      '>': if UserItem.btValue[14] > nAddValue then
          Result := True;
      '<': if UserItem.btValue[14] < nAddValue then
          Result := True;
    else if UserItem.btValue[14] >= nAddValue then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckItemLevel');
  end;
end;

function TNormNpc.ConditionOfCheckItemAddValue(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  //  I: Integer;
  nWhere, nValueIdx, nAddValue: Integer;
  UserItem: pTUserItem;
  cMethod: Char;
begin
  try
    Result := False;
    nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
    nValueIdx := Str_ToInt(QuestConditionInfo.sParam2, -1);
    nAddValue := Str_ToInt(QuestConditionInfo.sParam4, -1);
    if (not (nWhere in [Low(THumanUseItems)..High(THumanUseItems)])) or
    (nAddValue < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKITEMADDVALUE);
      exit;
    end;
    if not (nValueIdx in [0..15]) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKITEMADDVALUE);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam3[1];
    UserItem := @PlayObject.m_UseItems[nWhere];
    if UserItem.wIndex = 0 then
    begin
      exit;
    end;
    case cMethod of
      '=': if nAddValue = UserItem.btValue[nValueIdx] then
          Result := True;
      '>': if UserItem.btValue[nValueIdx] > nAddValue then
          Result := True;
      '<': if UserItem.btValue[nValueIdx] < nAddValue then
          Result := True;
    else if UserItem.btValue[nValueIdx] >= nAddValue then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckItemAddValue');
  end;
end;

function TNormNpc.ConditionOfCheckItemType(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nWhere: Integer;
  nType: Integer;
  UserItem: pTUserItem;
  Stditem: Titem;
begin
  try
    Result := False;
    nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
    nType := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if not (nWhere in [Low(THumanUseItems)..High(THumanUseItems)]) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMTYPE);
      exit;
    end;
    UserItem := @PlayObject.m_UseItems[nWhere];
    if UserItem.wIndex = 0 then
      exit;
    Stditem := UserEngine.GetStdItem(UserItem.wIndex);
    if (Stditem <> nil) and (Stditem.StdMode = nType) then
    begin
      Result := True;
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckItemType');
  end;
end;

function TNormNpc.ConditionOfCheckHeroJob(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
    Result := False;
    if PlayObject.m_Hero = nil then
      exit;
    if CompareLStr(QuestConditionInfo.sParam1, sWarrior, Length(sWarrior)) then
    begin
      if PlayObject.m_Hero.m_btJob = jWarr then
        Result := True;
    end
    else if CompareLStr(QuestConditionInfo.sParam1, sWizard, Length(sWizard))
      then
    begin
      if PlayObject.m_Hero.m_btJob = jWizard then
        Result := True;
    end
    else if CompareLStr(QuestConditionInfo.sParam1, sTaos, Length(sTaos)) then
    begin
      if PlayObject.m_Hero.m_btJob = jTaos then
        Result := True;
    end
    else
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CheckHeroJob);
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckHeroJob');
  end;
end;

function TNormNpc.ConditionOfCheckDiploid(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMode: Char;
  nLevel: Integer;
begin
  try
    Result := False;
    nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if (nLevel < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKDIPLOID);
      exit;
    end;
    cMode := QuestConditionInfo.sParam2[1];
    case cMode of
      '>': if PlayObject.m_btDiploidRate > nLevel then
          Result := True;
      '<': if PlayObject.m_btDiploidRate < nLevel then
          Result := True;
      '=': if PlayObject.m_btDiploidRate = nLevel then
          Result := True;
    else if PlayObject.m_btDiploidRate >= nLevel then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckDiploid');
  end;
end;

function TNormNpc.ConditionOfCHECKSKILL(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMode: Char;
  nLevel: Integer;
  I: Integer;
  UserMagic: pTUserMagic;
begin
  try
    Result := False;
    nLevel := Str_ToInt(QuestConditionInfo.sParam3, -1);
    if (nLevel < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSKILL);
      exit;
    end;
    cMode := QuestConditionInfo.sParam2[1];
    for i := 0 to PlayObject.m_MagicList.Count - 1 do
    begin
      UserMagic := PlayObject.m_MagicList.Items[I];
      if CompareText(QuestConditionInfo.sParam1, UserMagic.MagicInfo.sMagicName)
        = 0 then
      begin
        case cMode of
          '>': if UserMagic.btLevel > nLevel then
              Result := True;
          '<': if UserMagic.btLevel < nLevel then
              Result := True;
          '=': if UserMagic.btLevel = nLevel then
              Result := True;
        else if UserMagic.btLevel >= nLevel then
          Result := True;
        end;
        break;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckSkill');
  end;
end;

function TNormNpc.ConditionOfFindMapPath(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  Envir: TEnvirnoment;
  oX, oY, nX, nY: Integer;
begin
  Result := False;
  Envir := g_MapManager.FindMap(QuestConditionInfo.sParam1);
  oX := Str_ToInt(QuestConditionInfo.sParam2, -1);
  oY := Str_ToInt(QuestConditionInfo.sParam3, -1);
  nX := Str_ToInt(QuestConditionInfo.sParam4, -1);
  nY := Str_ToInt(QuestConditionInfo.sParam5, -1);
  if (Envir = nil) or (oX < 0) or (oY < 0) or (nX < 0) or (nY < 0) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_FindMapPath);
    exit;
  end;
  //if Envir.Flag.boMission then begin
  if m_FPath = nil then
  begin
    g_MapFind.LoadMap(Envir);
    g_MapFind.SetStartPos(oX, oY, 0);
    m_FPath := g_MapFind.FindPath(nX, nY);
    if High(m_FPath) < 2 then
    begin
      m_FPath := nil
    end
    else
    begin
      Result := True;
      m_MissionMap := QuestConditionInfo.sParam1;
      m_nMissionX := oX;
      m_nMissionY := oY;
    end;
  end
  else
    Result := True;
  //end else ScriptConditionError(PlayObject,QuestConditionInfo,sSC_FindMapPath);
end;

function TNormNpc.ConditionOfCheckMapMobCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nX, nY, nCount, nCheck: Integer;
  nSX, nSY, nEX, nEY, iX, iY: Integer;
  Envir: TEnvirnoment;
  cMode: Char;
  MapCellInfo: pTMapCellinfo;
  I: integer;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  try
    Result := False;
    nX := Str_ToInt(QuestConditionInfo.sParam2, -1);
    nY := Str_ToInt(QuestConditionInfo.sParam3, -1);
    nCount := Str_ToInt(QuestConditionInfo.sParam6, -1);
    Envir := g_MapManager.FindMap(QuestConditionInfo.sParam1);
    if (Envir = nil) or (nX < 0) or (nY < 0) or (nCount < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CheckMapMobCount);
      exit;
    end;
    cMode := QuestConditionInfo.sParam5[1];
    nCheck := 0;
    nSX := nX - QuestConditionInfo.nParam7;
    nEX := nX + QuestConditionInfo.nParam7;
    nSY := nY - QuestConditionInfo.nParam7;
    nEY := nY + QuestConditionInfo.nParam7;
    for iX := nSX to nEX do
    begin
      for iY := nSY to nEY do
      begin
        if Envir.GetMapCellInfo(iX, iY, MapCellInfo) and (MapCellInfo.ObjList <>
          nil) then
        begin
          for I := 0 to MapCellInfo.ObjList.Count - 1 do
          begin
            OSObject := MapCellInfo.ObjList.Items[i];
            if OSObject.btType = OS_MOVINGOBJECT then
            begin
              BaseObject := TBaseObject(OSObject.CellObj);
              if (BaseObject <> nil) and
                (not BaseObject.m_boGhost) and
                (BaseObject.m_btRaceServer <> RC_PLAYOBJECT) and
                (not BaseObject.m_boDeath) then
              begin
                if CompareText(QuestConditionInfo.sParam4,
                  BaseObject.m_sCharName) = 0 then
                  Inc(nCheck);
              end;
            end;
          end;
        end;
      end;
    end;
    case cMode of
      '>': Result := (nCheck > nCount);
      '<': Result := (nCheck < nCount);
      '=': Result := (nCount = nCheck);
    else
      Result := (nCheck >= nCount);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckMapMobCount');
  end;
end;

function TNormNpc.ConditionOfCheckMapName(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  CheckObject: TPlayObject;
begin
  try
    Result := False;
    if QuestConditionInfo.sParam2 <> '' then
    begin
      if CompareText(QuestConditionInfo.sParam1, 'SELF') = 0 then
        CheckObject := PlayObject
      else
        CheckObject := UserEngine.GetPlayObject(QuestConditionInfo.sParam1);
      if (CheckObject <> nil) and (CheckObject.m_PEnvir <> nil) then
      begin
        Result := CompareText(CheckObject.m_PEnvir.sMapName,
          QuestConditionInfo.sParam2) = 0;
      end;
    end
    else
    begin
      if PlayObject.m_PEnvir <> nil then
        Result := (CompareText(PlayObject.m_PEnvir.sMapName,
          QuestConditionInfo.sParam2) = 0);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckMapName');
  end;
end;

function TNormNpc.ConditionOfCheckOnLinePlayCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMode: Char;
  nCount: Integer;
begin
  try
    Result := False;
    nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if (QuestConditionInfo.sParam1 = '') or (nCount < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CheckOnLinePlayCount);
      exit;
    end;
    cMode := QuestConditionInfo.sParam1[1];
    case cMode of
      '>': Result := (UserEngine.PlayObjectCount > nCount);
      '<': Result := (UserEngine.PlayObjectCount < nCount);
      '=': Result := (UserEngine.PlayObjectCount = nCount);
    else
      Result := (UserEngine.PlayObjectCount >= nCount);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckOnLinePlayCount');
  end;
end;

function TNormNpc.ConditionOfIsHigh(PlayObject: TPlayObject; QuestConditionInfo:
  pTQuestConditionInfo): Boolean;
var
  cMode: Char;
begin
  try
    Result := False;
    if QuestConditionInfo.sParam1 = '' then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_IsHigh);
      exit;
    end;
    cMode := QuestConditionInfo.sParam1[1];
    case cMode of
      'L': Result := g_HighLevelHuman = PlayObject;
      'P': Result := g_HighPKPointHuman = PlayObject;
      'D': Result := g_HighDCHuman = PlayObject;
      'M': Result := g_HighMCHuman = PlayObject;
      'S': Result := g_HighSCHuman = PlayObject;
    else
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_IsHigh);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfIsHigh');
  end;
end;

function TNormNpc.ConditionOfCheckListText(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  LoadList: TStringList;
  sListFileName: string;
  I: integer;
begin
  try
    Result := False;
    if QuestConditionInfo.sParam2 = '' then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CheckListText);
      exit;
    end;
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sListFileName);
    try
      for I := 0 to LoadList.Count - 1 do
      begin
        if CompareText(LoadList.Strings[I], QuestConditionInfo.sParam2) = 0 then
        begin
          Result := True;
          break;
        end;
      end;
    finally
      LoadList.Free;
    end;
  except
    MainOutMessage('Load fail.... => ' + sListFileName);
  end;
end;

function TNormNpc.ConditionOfCheckCodeList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  LoadList: TStringList;
  sListFileName: string;
  I: integer;
begin
  try
    Result := False;
    if PlayObject.m_ServerStrVal[0] = '' then
      exit;
    if QuestConditionInfo.sParam1 = '' then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CheckCodeList);
      exit;
    end;
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sListFileName);
    try
      for I := 0 to LoadList.Count - 1 do
      begin
        if CompareText(LoadList.Strings[I], PlayObject.m_ServerStrVal[0]) = 0
          then
        begin
          Result := True;
          break;
        end;
      end;
    finally
      LoadList.Free;
    end;
  except
    MainOutMessage('Load fail.... => ' + sListFileName);
  end;
end;

function TNormNpc.ConditionOfCheckUserDate(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  LoadList: TStringList;
  sListFileName: string;
  sName, sTime, sTop: string;
  I: integer;
  DateTime: TDateTime;
  DateCount: Integer;
  DayCount, n18: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    DayCount := Str_ToInt(Questconditioninfo.sParam3, -1);
    if (QuestConditionInfo.sParam1 = '') or (DayCount < 0) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKUSERDATE);
      exit;
    end;
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1;
    LoadList := TStringList.Create;
    try
      if FileExists(sListFileName) then
      begin
        LoadList.LoadFromFile(sListFileName);
        for I := 0 to LoadList.Count - 1 do
        begin
          sTop := LoadList.Strings[I];
          if (Length(sTop) > 0) and (sTop[1] <> ';') then
          begin
            sTime := GetValidStr3(sTop, sName, [' ', ',', #9]);
            if CompareText(PlayObject.m_sCharName, sName) = 0 then
            begin
              DateTime := StrToDate(sTime);
              DateCount := DaysBetween(DateTime, Now);
              cMethod := QuestConditionInfo.sParam2[1];
              case cMethod of
                '=': if DayCount = DateCount then
                    Result := True;
                '>': if DateCount > DayCount then
                    Result := True;
                '<': if DateCount < DayCount then
                    Result := True;
              else if DateCount >= DayCount then
                Result := True;
              end;
              n18 := GetValNameNo(Questconditioninfo.sParam4);
              if n18 >= 0 then
              begin
                case n18 of
                  0..99: PlayObject.m_nVal[n18] := DateCount;
                  1000..1999: g_Config.GlobalVal[n18 - 1000] := DateCount;
                  200..299: PlayObject.m_DyVal[n18 - 200] := DateCount;
                  300..399: PlayObject.m_nMval[n18 - 300] := DateCount;
                  4000..4999: g_Config.GlobaDyMval[n18 - 4000] := DateCount;
                  900..999: PlayObject.m_DyValEx[n18 - 900] := DateCount;
                else
                  ScriptConditionError(PlayObject, QuestConditionInfo,
                    sSC_CheckUserDate);
                end;
              end;
              n18 := GetValNameNo(Questconditioninfo.sParam5);
              if n18 >= 0 then
              begin
                case n18 of
                  0..99: PlayObject.m_nVal[n18] := _Max(0, DayCount -
                      DateCount);
                  1000..1999: g_Config.GlobalVal[n18 - 1000] := _Max(0, DayCount
                      - DateCount);
                  200..299: PlayObject.m_DyVal[n18 - 200] := _Max(0, DayCount -
                      DateCount);
                  300..399: PlayObject.m_nMval[n18 - 300] := _Max(0, DayCount -
                      DateCount);
                  4000..4999: g_Config.GlobaDyMval[n18 - 4000] := _Max(0,
                      DayCount - DateCount);
                  900..999: PlayObject.m_DyValEx[n18 - 900] := _Max(0, DayCount
                      - DateCount);
                else
                  ScriptConditionError(PlayObject, QuestConditionInfo,
                    sSC_CheckUserDate);
                end;
              end;
              break;
            end;
          end;
        end;
      end
      else
        ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CheckUserDate);
    finally
      LoadList.Free;
    end;
  except
    MainOutMessage('Load fail.... => ' + sListFileName)
  end;
end;

function TNormNpc.ConditionOfOffLinePlayerCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    if PlayObject.m_Hero = nil then
      exit;
    nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nLevel < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_OffLinePlayerCount);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if UserEngine.OffLinePlayCount = nLevel then
          Result := True;
      '>': if UserEngine.OffLinePlayCount > nLevel then
          Result := True;
      '<': if UserEngine.OffLinePlayCount < nLevel then
          Result := True;
    else if UserEngine.OffLinePlayCount >= nLevel then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfOffLinePlayerCount');
  end;
end;

function TNormNpc.ConditionOfCheckHeroPKPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    if PlayObject.m_Hero = nil then
      exit;
    nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nLevel < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CheckHeroPKPoint);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_Hero.m_nPkPoint = nLevel then
          Result := True;
      '>': if PlayObject.m_Hero.m_nPkPoint > nLevel then
          Result := True;
      '<': if PlayObject.m_Hero.m_nPkPoint < nLevel then
          Result := True;
    else if PlayObject.m_Hero.m_nPkPoint >= nLevel then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckHeroPKPoint');
  end;
end;

function TNormNpc.ConditionOfCheckHeroLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    if PlayObject.m_Hero = nil then
      exit;
    nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nLevel < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CheckHeroLevel);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_Hero.m_Abil.Level = nLevel then
          Result := True;
      '>': if PlayObject.m_Hero.m_Abil.Level > nLevel then
          Result := True;
      '<': if PlayObject.m_Hero.m_Abil.Level < nLevel then
          Result := True;
    else if PlayObject.m_Hero.m_Abil.Level >= nLevel then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckHeroLevel');
  end;
end;

function TNormNpc.ConditionOfCheckLevelEx(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nLevel < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKLEVELEX);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_Abil.Level = nLevel then
          Result := True;
      '>': if PlayObject.m_Abil.Level > nLevel then
          Result := True;
      '<': if PlayObject.m_Abil.Level < nLevel then
          Result := True;
    else if PlayObject.m_Abil.Level >= nLevel then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckLevelEx');
  end;
end;

function TNormNpc.ConditionOfCheckNameListPostion(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sCharName: string;
  nNamePostion, nPostion: Integer;
  sLine: string;
begin
  try
    Result := False;
    nNamePostion := -1;
    sCharName := PlayObject.m_sCharName;
    LoadList := TStringList.Create;
    try
      if FileExists(g_Config.sEnvirDir + QuestConditionInfo.sParam1) then
      begin
        LoadList.LoadFromFile(g_Config.sEnvirDir + QuestConditionInfo.sParam1);
        for I := 0 to LoadList.Count - 1 do
        begin
          sLine := Trim(LoadList.Strings[i]);
          if sLine[1] = ';' then
            Continue;
          if CompareText(sLine, sCharName) = 0 then
          begin
            nNamePostion := I;
            break;
          end;
        end;
      end
      else
      begin
        ScriptConditionError(PlayObject, QuestConditionInfo,
          sSC_CHECKNAMELISTPOSITION);
      end;
    finally
      LoadList.Free
    end;
    nPostion := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nPostion < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKNAMELISTPOSITION);
      exit;
    end;
    if nNamePostion >= nPostion then
      Result := True;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckNameListPostion');
  end;
end;

function TNormNpc.ConditionOfCheckMarry(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
    Result := False;
    if PlayObject.m_sDearName <> '' then
      Result := True;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckMarry');
  end;
end;

function TNormNpc.ConditionOfCheckMarryCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nCount < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMARRYCOUNT);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_btMarryCount = nCount then
          Result := True;
      '>': if PlayObject.m_btMarryCount > nCount then
          Result := True;
      '<': if PlayObject.m_btMarryCount < nCount then
          Result := True;
    else if PlayObject.m_btMarryCount >= nCount then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckMarryCount');
  end;
end;

function TNormNpc.ConditionOfCheckMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
    Result := False;
    if (PlayObject.m_sMasterName <> '') and (not PlayObject.m_boMaster) then
      Result := True;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckMaster');
  end;
end;

function TNormNpc.ConditionOfCheckMemBerLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nLevel < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKMEMBERLEVEL);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_nMemberLevel = nLevel then
          Result := True;
      '>': if PlayObject.m_nMemberLevel > nLevel then
          Result := True;
      '<': if PlayObject.m_nMemberLevel < nLevel then
          Result := True;
    else if PlayObject.m_nMemberLevel >= nLevel then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckMemBerLevel');
  end;
end;

function TNormNpc.ConditionOfCheckMemberType(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nType: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    nType := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nType < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMEMBERTYPE);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_nMemberType = nType then
          Result := True;
      '>': if PlayObject.m_nMemberType > nType then
          Result := True;
      '<': if PlayObject.m_nMemberType < nType then
          Result := True;
    else if PlayObject.m_nMemberType >= nType then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckMemberType');
  end;
end;

function TNormNpc.ConditionOfCheckNameIPList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sCharName: string;
  sCharAccount: string;
  sCharIPaddr: string;
  sLine: string;
  sName: string;
  sIPaddr: string;
begin
  try
    Result := False;
    sCharName := PlayObject.m_sCharName;
    sCharAccount := PlayObject.m_sUserID;
    sCharIPaddr := PlayObject.m_sIPaddr;
    LoadList := TStringList.Create;
    try
      if FileExists(g_Config.sEnvirDir + QuestConditionInfo.sParam1) then
      begin
        LoadList.LoadFromFile(g_Config.sEnvirDir + QuestConditionInfo.sParam1);
        for I := 0 to LoadList.Count - 1 do
        begin
          sLine := LoadList.Strings[i];
          if sLine[1] = ';' then
            Continue;
          sIPaddr := GetValidStr3(sLine, sName, [' ', '/', #9]);
          sIPaddr := Trim(sIPaddr);
          if (sName = sCharName) and (sIPaddr = sCharIPaddr) then
          begin
            Result := True;
            break;
          end;
        end;
      end
      else
      begin
        ScriptConditionError(PlayObject, QuestConditionInfo,
          sSC_CHECKNAMEIPLIST);
      end;
    finally
      LoadList.Free
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckNameIPList');
  end;
end;

function TNormNpc.ConditionOfCheckPoseDir(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
begin
  try
    Result := False;
    PoseHuman := PlayObject.GetPoseCreate();
    if (PoseHuman <> nil) and (PoseHuman.GetPoseCreate = PlayObject) and
      (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then
    begin
      case QuestConditionInfo.nParam1 of
        1: if PoseHuman.m_btGender = PlayObject.m_btGender then
            Result := True; //要求相同性别
        2: if PoseHuman.m_btGender <> PlayObject.m_btGender then
            Result := True; //要求不同性别
      else
        Result := True; //无参数时不判别性别
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckPoseDir');
  end;
end;

function TNormNpc.ConditionOfCheckPoseGender(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
  btSex: Byte;
begin
  try
    Result := False;
    btSex := 0;
    if CompareText(QuestConditionInfo.sParam1, 'MAN') = 0 then
    begin
      btSex := 0;
    end
    else if CompareText(QuestConditionInfo.sParam1, '男') = 0 then
    begin
      btSex := 0;
    end
    else if CompareText(QuestConditionInfo.sParam1, 'WOMAN') = 0 then
    begin
      btSex := 1;
    end
    else if CompareText(QuestConditionInfo.sParam1, '女') = 0 then
    begin
      btSex := 1;
    end;
    PoseHuman := PlayObject.GetPoseCreate();
    if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then
    begin
      if PoseHuman.m_btGender = btSex then
        Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckPoseGender');
  end;
end;

function TNormNpc.ConditionOfCheckPoseIsMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
begin
  try
    Result := False;
    PoseHuman := PlayObject.GetPoseCreate();
    if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then
    begin
      if (TPlayObject(PoseHuman).m_sMasterName <> '') and
        (TPlayObject(PoseHuman).m_boMaster) then
        Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckPoseIsMaster');
  end;
end;

function TNormNpc.ConditionOfCheckPoseLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  PoseHuman: TBaseObject;
  cMethod: Char;
begin
  try
    Result := False;
    nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nLevel < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKPOSELEVEL);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    PoseHuman := PlayObject.GetPoseCreate();
    if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then
    begin
      case cMethod of
        '=': if PoseHuman.m_Abil.Level = nLevel then
            Result := True;
        '>': if PoseHuman.m_Abil.Level > nLevel then
            Result := True;
        '<': if PoseHuman.m_Abil.Level < nLevel then
            Result := True;
      else if PoseHuman.m_Abil.Level >= nLevel then
        Result := True;
      end;
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckPoseLevel');
  end;
end;

function TNormNpc.ConditionOfCheckPoseMarry(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
begin
  try
    Result := False;
    PoseHuman := PlayObject.GetPoseCreate();
    if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then
    begin
      if TPlayObject(PoseHuman).m_sDearName <> '' then
        Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckPoseMarry');
  end;
end;

function TNormNpc.ConditionOfCheckPoseMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
begin
  try
    Result := False;
    PoseHuman := PlayObject.GetPoseCreate();
    if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then
    begin
      if (TPlayObject(PoseHuman).m_sMasterName <> '') and not
        (TPlayObject(PoseHuman).m_boMaster) then
        Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckPoseMaster');
  end;
end;

function TNormNpc.ConditionOfCheckServerName(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
//var
///  sServerName:String;
begin
  try
    Result := False;
    if QuestConditionInfo.sParam1 = g_Config.sServerName then
      Result := True;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckServerName');
  end;
end;

function TNormNpc.ConditionOfCheckSlaveCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean; //检测宝宝数量
var
  nCount: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nCount < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSLAVECOUNT);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_SlaveList.Count = nCount then
          Result := True;
      '>': if PlayObject.m_SlaveList.Count > nCount then
          Result := True;
      '<': if PlayObject.m_SlaveList.Count < nCount then
          Result := True;
    else if PlayObject.m_SlaveList.Count >= nCount then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckSlaveCount');
  end;
end;

function TNormNpc.ConditionOfCheckMap(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
    if QuestConditionInfo.sParam1 = PlayObject.m_sMapName then
      Result := True
    else
      Result := False;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckMap');
  end;
end;

{function TNormNpc.ConditionOfCheckPos(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo):Boolean;
var
  nX,nY:integer;
begin
Try
  nX:=QuestConditionInfo.nParam2;
  nY:=QuestConditionInfo.nParam3;

  if (QuestConditionInfo.sParam1 = PlayObject.m_sMapName) and (nX = PlayObject.m_nCurrX) and (nY = PlayObject.m_nCurrY) then
    Result:=True
  else
    Result:=False;
Except
  MainOutMessage('[Exception] TNormNpc.ConditionOfCheckPos');
End;
end;

{function TNormNpc.ConditionOfReviveSlave(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo):Boolean;
var
 I,n14,resultc,nSlaveCount:Integer;
  s18,s20,s24:String;
  myFile:TextFile;
  LoadList,templist:TStringList;
  sFileName,SLineText,Petname,lvl,lvlexp:String;
begin
Try
resultc:=-1;
  sFileName:=g_Config.sEnvirDir + 'PetData\' + PlayObject.m_sCharName + '.txt';

  if FileExists(sFileName) then begin
    LoadList:=TStringList.Create;
  //  Templist:=TStringList.Create;
    LoadList.LoadFromFile(sFileName);
            if playobject.m_btJob = jTaos then begin
        nSlavecount:=1;
          end else begin
         nSlavecount:=5;
          end;
  for I := 0 to LoadList.Count - 1 do begin
      s18:=Trim(LoadList.Strings[I]);
      if (s18 <> '') and (s18[1] <> ';') then begin
       s18:=GetValidStr3(s18,PetName, ['/']);
       s18:=GetValidStr3(s18,lvl, ['/']);
       s18:=GetValidStr3(s18,lvlexp, ['/']);
     //PlayObject.ReviveSlave(PetName,str_ToInt(lvl,0),str_ToInt(lvlexp,0),nslavecount,10 * 24 * 60 * 60);
     resultc:=i;
      end;
  end;
if loadlist.count > 0 then begin
result:=true;
  AssignFile(myFile, sFileName);
   ReWrite(myFile);
   CloseFile(myFile);
end;
  end;
Except
  MainOutMessage('[Exception] TNormNpc.ConditionOfReviveSlave');
End;
end;    }

function TNormNpc.ConditionOfCheckMagicLvl(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  UserMagic: pTUserMagic;
begin
  try
    Result := False;
    for I := 0 to PlayObject.m_MagicList.Count - 1 do
    begin
      UserMagic := PlayObject.m_MagicList.Items[I];
      if CompareText(UserMagic.MagicInfo.sMagicName, QuestConditionInfo.sParam1)
        = 0 then
      begin
        if (UserMagic.btLevel = QuestConditionInfo.nParam2) then
          Result := True;

        break;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckMagicLvl');
  end;
end;

function TNormNpc.ConditionOfCheckGroupClass(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I, nCount, nJob: Integer;
  cMethod: Char;
  PlayObjectEx: TPlayObject;
begin
  try
    Result := False;
    nJob := -1;
    nCount := 0;

    if CompareLStr(QuestConditionInfo.sParam1, sWarrior, Length(sWarrior)) then
      nJob := jWarr;
    if CompareLStr(QuestConditionInfo.sParam1, sWizard, Length(sWizard)) then
      nJob := jWizard;
    if CompareLStr(QuestConditionInfo.sParam1, sTaos, Length(sTaos)) then
      nJob := jTaos;

    if nJob < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHANGEJOB);
      exit;
    end;

    if PlayObject.m_GroupOwner <> nil then
    begin
      for I := 0 to PlayObject.m_GroupMembers.Count - 1 do
      begin
        PlayObjectEx := TPlayObject(PlayObject.m_GroupMembers.Objects[i]);

        if PlayObjectEx.m_btJob = nJob then
          Inc(nCount);

      end;
    end;

    cMethod := QuestConditionInfo.sParam2[1];
    case cMethod of
      '=': if nCount = QuestConditionInfo.nParam3 then
          Result := True;
      '>': if nCount > QuestConditionInfo.nParam3 then
          Result := True;
      '<': if nCount < QuestConditionInfo.nParam3 then
          Result := True;
    else if nCount >= QuestConditionInfo.nParam3 then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckGroupClass');
  end;
end;

constructor TNormNpc.Create; //0049AA38
begin
  try
    inherited;
    m_boSuperMan := True;
    m_btRaceServer := RC_NPC;
    m_nLight := 2;
    m_btAntiPoison := 99;
    m_ScriptList := TList.Create;
    m_boStickMode := True;
    m_sFilePath := '';
    m_boIsHide := False;
    m_boIsQuest := True;
    m_FPath := nil;
    New(m_QuestConditionInfo);
    New(m_QuestActionInfo);
  except
    MainOutMessage('[Exception] TNormNpc.Create');
  end;
end;

destructor TNormNpc.Destroy; //0049AAE4
//var
//  I: Integer;
begin
  try

    ClearScript();
    {
    for I := 0 to ScriptList.Count - 1 do begin
      Dispose(pTScript(ScriptList.Items[I]));
    end;
    }
    m_ScriptList.Free;
    Dispose(m_QuestConditionInfo);
    Dispose(m_QuestActionInfo);
    inherited;
  except
    MainOutMessage('[Exception] TNormNpc.Destroy');
  end;
end;

procedure TNormNpc.ExeAction(PlayObject: TPlayObject; sParam1, sParam2,
  sParam3: string; nParam1, nParam2, nParam3: Integer);
var
  nInt1 {,nInt2,nInt3}: Integer;
  dwInt: LongWord;
  //  BaseObject:TBaseObject;
begin
  try
    //================================================
    //更改人物当前经验值
    //EXEACTION CHANGEEXP 0 经验数  设置为指定经验值
    //EXEACTION CHANGEEXP 1 经验数  增加指定经验
    //EXEACTION CHANGEEXP 2 经验数  减少指定经验
    //================================================
    if CompareText(sParam1, 'CHANGEEXP') = 0 then
    begin
      nInt1 := Str_ToInt(sParam2, -1);
      case nInt1 of //
        0:
          begin
            if nParam3 >= 0 then
            begin
              PlayObject.m_Abil.Exp := LongWord(nParam3);
              PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
            end;
          end;
        1:
          begin
            //if PlayObject.m_Abil.Exp >= LongWord(nParam3) then begin
            if LongWord(nParam3) > (High(LongWord) - PlayObject.m_Abil.Exp) then
            begin
              dwInt := High(LongWord) - PlayObject.m_Abil.Exp;
            end
            else
            begin
              dwInt := LongWord(nParam3);
            end;
            {end else begin
              if (LongWord(nParam3) - PlayObject.m_Abil.Exp) > (High(LongWord) - LongWord(nParam3)) then begin
                dwInt:=High(LongWord) - LongWord(nParam3);
              end else begin
                dwInt:=LongWord(nParam3);
              end;
            end;  }
            //Inc(PlayObject.m_Abil.Exp,dwInt);
            PlayObject.GetExp(dwInt);
            //PlayObject.HasLevelUp(PlayObject.m_Abil.Level -1);
          end;
        2:
          begin
            if PlayObject.m_Abil.Exp > LongWord(nParam3) then
            begin
              Dec(PlayObject.m_Abil.Exp, LongWord(nParam3));
            end
            else
            begin
              PlayObject.m_Abil.Exp := 0;
            end;
            PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
          end;
      end;
      PlayObject.SysMsg('您当前经验点数为: ' +
        IntToStr(PlayObject.m_Abil.Exp) + '/' +
        IntToStr(PlayObject.m_Abil.MaxExp), c_Green, t_Hint);
      exit;
    end;

    //================================================
    //更改人物当前等级
    //EXEACTION CHANGELEVEL 0 等级数  设置为指定等级
    //EXEACTION CHANGELEVEL 1 等级数  增加指定等级
    //EXEACTION CHANGELEVEL 2 等级数  减少指定等级
    //================================================
    if CompareText(sParam1, 'CHANGELEVEL') = 0 then
    begin
      nInt1 := Str_ToInt(sParam2, -1);
      case nInt1 of //
        0:
          begin
            if nParam3 >= 0 then
            begin
              PlayObject.m_Abil.Level := LongWord(nParam3);
              PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
            end;
          end;
        1:
          begin
            if PlayObject.m_Abil.Level >= LongWord(nParam3) then
            begin
              if (PlayObject.m_Abil.Level - LongWord(nParam3)) >
                LongWord(High(Word) - PlayObject.m_Abil.Level) then
              begin
                dwInt := High(Word) - PlayObject.m_Abil.Level;
              end
              else
              begin
                dwInt := LongWord(nParam3);
              end;
            end
            else
            begin
              if (LongWord(nParam3) - PlayObject.m_Abil.Level) > (High(Word) -
                LongWord(nParam3)) then
              begin
                dwInt := High(LongWord) - LongWord(nParam3);
              end
              else
              begin
                dwInt := LongWord(nParam3);
              end;
            end;
            Inc(PlayObject.m_Abil.Level, dwInt);
            PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
          end;
        2:
          begin
            if PlayObject.m_Abil.Level > LongWord(nParam3) then
            begin
              Dec(PlayObject.m_Abil.Level, LongWord(nParam3));
            end
            else
            begin
              PlayObject.m_Abil.Level := 0;
            end;
            PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
          end;
      end;
      PlayObject.SysMsg('您当前等级为: ' +
        IntToStr(PlayObject.m_Abil.Level), c_Green, t_Hint);
      exit;
    end;

    //================================================
    //杀死人物
    //EXEACTION KILL 0 人物死亡,不显示凶手信息
    //EXEACTION KILL 1 人物死亡不掉物品,不显示凶手信息
    //EXEACTION KILL 2 人物死亡,显示凶手信息为NPC
    //EXEACTION KILL 3 人物死亡不掉物品,显示凶手信息为NPC
    //================================================
    if CompareText(sParam1, 'KILL') = 0 then
    begin
      nInt1 := Str_ToInt(sParam2, -1);
      case nInt1 of //
        1:
          begin
            PlayObject.m_boNoItem := True;
            PlayObject.Die;
          end;
        2:
          begin
            PlayObject.SetLastHiter(Self);
            PlayObject.Die;
          end;
        3:
          begin
            PlayObject.m_boNoItem := True;
            PlayObject.SetLastHiter(Self);
            PlayObject.Die;
          end;
      else
        begin
          PlayObject.Die;
        end;
      end;
      exit;
    end;

    //================================================
    //踢人物下线
    //EXEACTION KICK
    //================================================
    if CompareText(sParam1, 'KICK') = 0 then
    begin
      PlayObject.m_boKickFlag := True;
      exit;
    end;

    //==============================================================================
  except
    MainOutMessage('[Exception] TNormNpc.ExeAction');
  end;
end;

function TNormNpc.GetLineVariableText(PlayObject: TPlayObject;
  sMsg: string): string;
var
  nC: Integer;
  s10: string;
begin
  try
    nC := 0;
    while (True) do
    begin
      if TagCount(sMsg, '>') < 1 then
        break;
      ArrestStringEx(sMsg, '<', '>', s10);
      GetVariableText(PlayObject, sMsg, s10);
      Inc(nC);
      if nC >= 101 then
        break;
    end;
    Result := sMsg;
  except
    MainOutMessage('[Exception] TNormNpc.GetLineVariableText');
  end;
end;

procedure TNormNpc.GetVariableText(PlayObject: TPlayObject; var sMsg: string;
  sVariable: string); //0049AEA4
var
  sText, s14: string;
  I: Integer;
  n18: Integer;
  wHour: Word;
  wMinute: Word;
  wSecond: Word;
  nSecond: Integer;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  IntDays: Int64;
  Castle: TUserCastle;
begin
  try
    //全局信息
    if sVariable = '$STATSERVERTIME' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$STATSERVERTIME>',
        FormatDateTime('dddddd,dddd,hh:mm:nn', g_dwRunStartTick));
      exit;
    end;
    if sVariable = '$RUNDATETIME' then
    begin
      IntDays := MinutesBetween(Now, g_dwDiyStartTick);
      sMsg := sub_49ADB8(sMsg, '<$RUNDATETIME>', IntToStr(IntDays div 60));
      exit;
    end;
    if sVariable = '$SERVERNAME' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$SERVERNAME>', g_Config.sServerName);
      exit;
    end;
    if sVariable = '$SERVERIP' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$SERVERIP>', g_Config.sServerIPaddr);
      exit;
    end;
    if sVariable = '$WEBSITE' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$WEBSITE>', g_Config.sWebSite);
      exit;
    end;
    if sVariable = '$BBSSITE' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BBSSITE>', g_Config.sBbsSite);
      exit;
    end;
    if sVariable = '$CLIENTDOWNLOAD' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CLIENTDOWNLOAD>', g_Config.sClientDownload);
      exit;
    end;
    if sVariable = '$QQ' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$QQ>', g_Config.sQQ);
      exit;
    end;
    if sVariable = '$PHONE' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$PHONE>', g_Config.sPhone);
      exit;
    end;
    if sVariable = '$BANKACCOUNT0' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT0>', g_Config.sBankAccount0);
      exit;
    end;
    if sVariable = '$BANKACCOUNT1' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT1>', g_Config.sBankAccount1);
      exit;
    end;
    if sVariable = '$BANKACCOUNT2' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT2>', g_Config.sBankAccount2);
      exit;
    end;
    if sVariable = '$BANKACCOUNT3' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT3>', g_Config.sBankAccount3);
      exit;
    end;
    if sVariable = '$BANKACCOUNT4' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT4>', g_Config.sBankAccount4);
      exit;
    end;
    if sVariable = '$BANKACCOUNT5' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT5>', g_Config.sBankAccount5);
      exit;
    end;
    if sVariable = '$BANKACCOUNT6' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT6>', g_Config.sBankAccount6);
      exit;
    end;
    if sVariable = '$BANKACCOUNT7' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT7>', g_Config.sBankAccount7);
      exit;
    end;
    if sVariable = '$BANKACCOUNT8' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT8>', g_Config.sBankAccount8);
      exit;
    end;
    if sVariable = '$BANKACCOUNT9' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT9>', g_Config.sBankAccount9);
      exit;
    end;
    if sVariable = '$GAMEGOLDNAME' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$GAMEGOLDNAME>', g_Config.sGameGoldName);
      exit;
    end;
    if sVariable = '$GAMEPOINTNAME' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$GAMEPOINTNAME>', g_Config.sGamePointName);
      exit;
    end;
    if sVariable = '$USERCOUNT' then
    begin
      sText := IntToStr(UserEngine.PlayObjectCount);
      sMsg := sub_49ADB8(sMsg, '<$USERCOUNT>', sText);
      exit;
    end;
    if sVariable = '$MACRUNTIME' then
    begin
      sText := CurrToStr(GetTickCount / (24 * 60 * 60 * 1000));
      sMsg := sub_49ADB8(sMsg, '<$MACRUNTIME>', sText);
      exit;
    end;
    if sVariable = '$SERVERRUNTIME' then
    begin
      nSecond := (GetTickCount() - g_dwStartTick) div 1000;
      wHour := nSecond div 3600;
      wMinute := (nSecond div 60) mod 60;
      wSecond := nSecond mod 60;
      sText := format('%d:%d:%d', [wHour, wMinute, wSecond]);
      sMsg := sub_49ADB8(sMsg, '<$SERVERRUNTIME>', sText);
      exit;
    end;
    if sVariable = '$DATETIME' then
    begin
      //    sText:=DateTimeToStr(Now);
      sText := FormatDateTime('dddddd,dddd,hh:mm:ss', Now);
      sMsg := sub_49ADB8(sMsg, '<$DATETIME>', sText);
      exit;
    end;

    if sVariable = '$HIGHLEVELINFO' then
    begin
      if g_HighLevelHuman <> nil then
      begin
        sText := TPlayObject(g_HighLevelHuman).GetMyInfo;
      end
      else
        sText := '????';
      sMsg := sub_49ADB8(sMsg, '<$HIGHLEVELINFO>', sText);
      exit;
    end;
    if sVariable = '$HIGHPKINFO' then
    begin
      if g_HighPKPointHuman <> nil then
      begin
        sText := TPlayObject(g_HighPKPointHuman).GetMyInfo;
      end
      else
        sText := '????';
      sMsg := sub_49ADB8(sMsg, '<$HIGHPKINFO>', sText);
      exit;
    end;
    if sVariable = '$HIGHDCINFO' then
    begin
      if g_HighDCHuman <> nil then
      begin
        sText := TPlayObject(g_HighDCHuman).GetMyInfo;
      end
      else
        sText := '????';
      sMsg := sub_49ADB8(sMsg, '<$HIGHDCINFO>', sText);
      exit;
    end;
    if sVariable = '$HIGHMCINFO' then
    begin
      if g_HighMCHuman <> nil then
      begin
        sText := TPlayObject(g_HighMCHuman).GetMyInfo;
      end
      else
        sText := '????';
      sMsg := sub_49ADB8(sMsg, '<$HIGHMCINFO>', sText);
      exit;
    end;
    if sVariable = '$HIGHSCINFO' then
    begin
      if g_HighSCHuman <> nil then
      begin
        sText := TPlayObject(g_HighSCHuman).GetMyInfo;
      end
      else
        sText := '????';
      sMsg := sub_49ADB8(sMsg, '<$HIGHSCINFO>', sText);
      exit;
    end;
    if sVariable = '$HIGHONLINEINFO' then
    begin
      if g_HighOnlineHuman <> nil then
      begin
        sText := TPlayObject(g_HighOnlineHuman).GetMyInfo;
      end
      else
        sText := '????';
      sMsg := sub_49ADB8(sMsg, '<$HIGHONLINEINFO>', sText);
      exit;
    end;

    //个人信息
    if sVariable = '$MAP' then
    begin
      if PlayObject.m_PEnvir <> nil then
        sMsg := sub_49ADB8(sMsg, '<$MAP>', PlayObject.m_PEnvir.sMapName)
      else
        sMsg := sub_49ADB8(sMsg, '<$MAP>', '');
      exit;
    end;
    if sVariable = '$DEALGOLDPLAY' then
    begin
      if PlayObject.m_DealGoldBase <> nil then
        sMsg := sub_49ADB8(sMsg, '<$DEALGOLDPLAY>',
          PlayObject.m_DealGoldBase.m_sCharName)
      else
        sMsg := sub_49ADB8(sMsg, '<$DEALGOLDPLAY>', '????');
      exit;
    end;
    if sVariable = '$X' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$X>', IntToStr(PlayObject.m_nCurrX));
      exit;
    end;
    if sVariable = '$Y' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$Y>', IntToStr(PlayObject.m_nCurrY));
      exit;
    end;
    if sVariable = '$RANDOMNO' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$RANDOMNO>', IntToStr(PlayObject.m_RandomNo));
      exit;
    end;
    if sVariable = '$HUMANSHOWNAME' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$HUMANSHOWNAME>',
        AnsiReplaceText(PlayObject.m_OldShowName, '\', '/'));
      exit;
    end;
    if sVariable = '$KILLER' then
    begin
      sText := '';
      if PlayObject.m_ExpHitter <> nil then
        sText := PlayObject.m_ExpHitter.m_sCharName
      else if PlayObject.m_LastHiter <> nil then
        sText := PlayObject.m_LastHiter.m_sCharName;
      sMsg := sub_49ADB8(sMsg, '<$KILLER>', sText);
      exit;
    end;
    if sVariable = '$RELEVEL' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$RELEVEL>', IntToStr(PlayObject.m_btReLevel));
      exit;
    end;
    if sVariable = '$SFNAME' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$SFNAME>', PlayObject.m_sMasterName);
      exit;
    end;
    if sVariable = '$FQNAME' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$FQNAME>', PlayObject.m_sDearName);
      exit;
    end;
    if sVariable = '$HERONAME' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$HERONAME>', PlayObject.m_HeroName);
      exit;
    end;
    if sVariable = '$GAMEDIAMOND' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$GAMEDIAMOND>',
        IntToStr(PlayObject.m_nGameDiamond));
      exit;
    end;
    if sVariable = '$GLORYPOINT' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$GLORYPOINT>',
        IntToStr(PlayObject.m_nGloryPoint));
      exit;
    end;
    if sVariable = '$DIPLOIDRATE' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$DIPLOIDRATE>',
        IntToStr(PlayObject.m_btDiploidRate));
      exit;
    end;
    if sVariable = '$GAMEGIRD' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$GAMEGIRD>', IntToStr(PlayObject.m_nGameGird));
      exit;
    end;
    if sVariable = '$USERNAME' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$USERNAME>', PlayObject.m_sCharName);
      exit;
    end;
    if sVariable = '$USERID' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$USERID>', PlayObject.m_sUserID);
      exit;
    end;
    if sVariable = '$USERALLNAME' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$USERALLNAME>', PlayObject.m_OldShowName);
      exit;
    end;
    if sVariable = '$GUILDNAME' then
    begin
      if PlayObject.m_MyGuild <> nil then
      begin
        sMsg := sub_49ADB8(sMsg, '<$GUILDNAME>',
          TGuild(PlayObject.m_MyGuild).sGuildName);
      end
      else
      begin
        sMsg := '无';
      end;
      exit;
    end;
    if sVariable = '$RANKNAME' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$RANKNAME>', PlayObject.m_sGuildRankName);
      exit;
    end;

    if sVariable = '$LEVEL' then
    begin
      sText := IntToStr(PlayObject.m_Abil.Level);
      sMsg := sub_49ADB8(sMsg, '<$LEVEL>', sText);
      exit;
    end;

    if sVariable = '$HP' then
    begin
      sText := IntToStr(PlayObject.m_WAbil.HP);
      sMsg := sub_49ADB8(sMsg, '<$HP>', sText);
      exit;
    end;
    if sVariable = '$MAXHP' then
    begin
      sText := IntToStr(PlayObject.m_WAbil.MaxHP);
      sMsg := sub_49ADB8(sMsg, '<$MAXHP>', sText);
      exit;
    end;

    if sVariable = '$MP' then
    begin
      sText := IntToStr(PlayObject.m_WAbil.MP);
      sMsg := sub_49ADB8(sMsg, '<$MP>', sText);
      exit;
    end;
    if sVariable = '$MAXMP' then
    begin
      sText := IntToStr(PlayObject.m_WAbil.MaxMP);
      sMsg := sub_49ADB8(sMsg, '<$MAXMP>', sText);
      exit;
    end;

    if sVariable = '$AC' then
    begin
      sText := IntToStr(LoWord(PlayObject.m_WAbil.AC));
      sMsg := sub_49ADB8(sMsg, '<$AC>', sText);
      exit;
    end;
    if sVariable = '$MAXAC' then
    begin
      sText := IntToStr(HiWord(PlayObject.m_WAbil.AC));
      sMsg := sub_49ADB8(sMsg, '<$MAXAC>', sText);
      exit;
    end;
    if sVariable = '$MAC' then
    begin
      sText := IntToStr(LoWord(PlayObject.m_WAbil.MAC));
      sMsg := sub_49ADB8(sMsg, '<$MAC>', sText);
      exit;
    end;
    if sVariable = '$MAXMAC' then
    begin
      sText := IntToStr(HiWord(PlayObject.m_WAbil.MAC));
      sMsg := sub_49ADB8(sMsg, '<$MAXMAC>', sText);
      exit;
    end;

    if sVariable = '$DC' then
    begin
      sText := IntToStr(LoWord(PlayObject.m_WAbil.DC));
      sMsg := sub_49ADB8(sMsg, '<$DC>', sText);
      exit;
    end;
    if sVariable = '$MAXDC' then
    begin
      sText := IntToStr(HiWord(PlayObject.m_WAbil.DC));
      sMsg := sub_49ADB8(sMsg, '<$MAXDC>', sText);
      exit;
    end;

    if sVariable = '$MC' then
    begin
      sText := IntToStr(LoWord(PlayObject.m_WAbil.MC));
      sMsg := sub_49ADB8(sMsg, '<$MC>', sText);
      exit;
    end;
    if sVariable = '$MAXMC' then
    begin
      sText := IntToStr(HiWord(PlayObject.m_WAbil.MC));
      sMsg := sub_49ADB8(sMsg, '<$MAXMC>', sText);
      exit;
    end;

    if sVariable = '$SC' then
    begin
      sText := IntToStr(LoWord(PlayObject.m_WAbil.SC));
      sMsg := sub_49ADB8(sMsg, '<$SC>', sText);
      exit;
    end;
    if sVariable = '$MAXSC' then
    begin
      sText := IntToStr(HiWord(PlayObject.m_WAbil.SC));
      sMsg := sub_49ADB8(sMsg, '<$MAXSC>', sText);
      exit;
    end;

    if sVariable = '$EXP' then
    begin
      sText := IntToStr(PlayObject.m_Abil.Exp);
      sMsg := sub_49ADB8(sMsg, '<$EXP>', sText);
      exit;
    end;
    if sVariable = '$MAXEXP' then
    begin
      sText := IntToStr(PlayObject.m_Abil.MaxExp);
      sMsg := sub_49ADB8(sMsg, '<$MAXEXP>', sText);
      exit;
    end;

    if sVariable = '$PKPOINT' then
    begin
      sText := IntToStr(PlayObject.m_nPkPoint);
      sMsg := sub_49ADB8(sMsg, '<$PKPOINT>', sText);
      exit;
    end;
    if sVariable = '$CREDITPOINT' then
    begin
      sText := IntToStr(PlayObject.m_btCreditPoint);
      sMsg := sub_49ADB8(sMsg, '<$CREDITPOINT>', sText);
      exit;
    end;

    if sVariable = '$HW' then
    begin
      sText := IntToStr(PlayObject.m_WAbil.HandWeight);
      sMsg := sub_49ADB8(sMsg, '<$HW>', sText);
      exit;
    end;
    if sVariable = '$MAXHW' then
    begin
      sText := IntToStr(PlayObject.m_WAbil.MaxHandWeight);
      sMsg := sub_49ADB8(sMsg, '<$MAXHW>', sText);
      exit;
    end;

    if sVariable = '$BW' then
    begin
      sText := IntToStr(PlayObject.m_WAbil.Weight);
      sMsg := sub_49ADB8(sMsg, '<$BW>', sText);
      exit;
    end;
    if sVariable = '$MAXBW' then
    begin
      sText := IntToStr(PlayObject.m_WAbil.MaxWeight);
      sMsg := sub_49ADB8(sMsg, '<$MAXBW>', sText);
      exit;
    end;

    if sVariable = '$WW' then
    begin
      sText := IntToStr(PlayObject.m_WAbil.WearWeight);
      sMsg := sub_49ADB8(sMsg, '<$WW>', sText);
      exit;
    end;
    if sVariable = '$MAXWW' then
    begin
      sText := IntToStr(PlayObject.m_WAbil.MaxWearWeight);
      sMsg := sub_49ADB8(sMsg, '<$MAXWW>', sText);
      exit;
    end;

    if sVariable = '$GOLDCOUNT' then
    begin
      sText := IntToStr(PlayObject.m_nGold) + '/' +
        IntToStr(PlayObject.m_nGoldMax);
      sMsg := sub_49ADB8(sMsg, '<$GOLDCOUNT>', sText);
      exit;
    end;
    if sVariable = '$GAMEGOLD' then
    begin
      sText := IntToStr(PlayObject.m_nGameGold);
      sMsg := sub_49ADB8(sMsg, '<$GAMEGOLD>', sText);
      exit;
    end;
    if sVariable = '$GAMEPOINT' then
    begin
      sText := IntToStr(PlayObject.m_nGamePoint);
      sMsg := sub_49ADB8(sMsg, '<$GAMEPOINT>', sText);
      exit;
    end;
    if sVariable = '$GAMEDIAMOND' then
    begin
      sText := IntToStr(PlayObject.m_nGameDiamond);
      sMsg := sub_49ADB8(sMsg, '<$GAMEDIAMOND>', sText);
      exit;
    end;
    if sVariable = '$GAMEGIRD' then
    begin
      sText := IntToStr(PlayObject.m_nGameGird);
      sMsg := sub_49ADB8(sMsg, '<$GAMEGIRD>', sText);
      exit;
    end;
    if sVariable = '$HUNGER' then
    begin
      sText := IntToStr(PlayObject.GetMyStatus);
      sMsg := sub_49ADB8(sMsg, '<$HUNGER>', sText);
      exit;
    end;
    if sVariable = '$LOGINTIME' then
    begin
      sText := DateTimeToStr(PlayObject.m_dLogonTime);
      sMsg := sub_49ADB8(sMsg, '<$LOGINTIME>', sText);
      exit;
    end;
    if sVariable = '$LOGINLONG' then
    begin
      sText := IntToStr((GetTickCount - PlayObject.m_dwLogonTick) div 60000) +
        '分钟';
      sMsg := sub_49ADB8(sMsg, '<$LOGINLONG>', sText);
      exit;
    end;
    if sVariable = '$DRESS' then
    begin
      sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_DRESS].wIndex);
      sMsg := sub_49ADB8(sMsg, '<$DRESS>', sText);
      exit;
    end
    else if sVariable = '$WEAPON' then
    begin
      sText :=
        UserEngine.GetStdItemName(PlayObject.m_UseItems[U_WEAPON].wIndex);
      sMsg := sub_49ADB8(sMsg, '<$WEAPON>', sText);
      exit;
    end
    else if sVariable = '$RIGHTHAND' then
    begin
      sText :=
        UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RIGHTHAND].wIndex);
      sMsg := sub_49ADB8(sMsg, '<$RIGHTHAND>', sText);
      exit;
    end
    else if sVariable = '$HELMET' then
    begin
      sText :=
        UserEngine.GetStdItemName(PlayObject.m_UseItems[U_HELMET].wIndex);
      sMsg := sub_49ADB8(sMsg, '<$HELMET>', sText);
      exit;
    end
    else if sVariable = '$NECKLACE' then
    begin
      sText :=
        UserEngine.GetStdItemName(PlayObject.m_UseItems[U_NECKLACE].wIndex);
      sMsg := sub_49ADB8(sMsg, '<$NECKLACE>', sText);
      exit;
    end
    else if sVariable = '$RING_R' then
    begin
      sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGR].wIndex);
      sMsg := sub_49ADB8(sMsg, '<$RING_R>', sText);
      exit;
    end
    else if sVariable = '$RING_L' then
    begin
      sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGL].wIndex);
      sMsg := sub_49ADB8(sMsg, '<$RING_L>', sText);
      exit;
    end
    else if sVariable = '$ARMRING_R' then
    begin
      sText :=
        UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGR].wIndex);
      sMsg := sub_49ADB8(sMsg, '<$ARMRING_R>', sText);
      exit;
    end
    else if sVariable = '$ARMRING_L' then
    begin
      sText :=
        UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
      sMsg := sub_49ADB8(sMsg, '<$ARMRING_L>', sText);
      exit;
    end
    else if sVariable = '$BUJUK' then
    begin
      sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BUJUK].wIndex);
      sMsg := sub_49ADB8(sMsg, '<$BUJUK>', sText);
      exit;
    end
    else if sVariable = '$BELT' then
    begin
      sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BELT].wIndex);
      sMsg := sub_49ADB8(sMsg, '<$BELT>', sText);
      exit;
    end
    else if sVariable = '$BOOTS' then
    begin
      sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BOOTS].wIndex);
      sMsg := sub_49ADB8(sMsg, '<$BOOTS>', sText);
      exit;
    end
    else if sVariable = '$CHARM' then
    begin
      sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_CHARM].wIndex);
      sMsg := sub_49ADB8(sMsg, '<$CHARM>', sText);
      exit;
    end
    else if sVariable = '$IPADDR' then
    begin
      sText := PlayObject.m_sIPaddr;
      sMsg := sub_49ADB8(sMsg, '<$IPADDR>', sText);
      exit;
    end
    else if sVariable = '$IPLOCAL' then
    begin
      sText := PlayObject.m_sIPLocal; // GetIPLocal(PlayObject.m_sIPaddr);
      sMsg := sub_49ADB8(sMsg, '<$IPLOCAL>', sText);
      exit;
    end
    else if sVariable = '$ALCOHOL' then
    begin
      sText :=IntToStr(PlayObject.m_WineRec.Alcoho); ////酒量;
      sMsg := sub_49ADB8(sMsg, '<$ALCOHOL>', sText);
      exit;
    end
    else if sVariable = '$MEDICINEVALUE' then
    begin
      sText :=IntToStr(PlayObject.m_MedicineRec.MedicineValue); //药力值
      sMsg := sub_49ADB8(sMsg, '<$MEDICINEVALUE>', sText);
      exit;
    end
    else if sVariable = '$GUILDFOUNTAIN' then
    begin
      if PlayObject.m_MyGuild = nil then
      begin
        sText := '无';
      end
      else
      begin
        sText := IntToStr(TGuild(PlayObject.m_MyGuild).nGuildFountain);//行会泉水量
      end;
      sMsg := sub_49ADB8(sMsg, '<$GUILDFOUNTAIN>', sText);
      exit;
    end
    else if sVariable = '$CASTLEFOUNTAIN' then
    begin
       Castle := g_CastleManager.IsCastleMember(PlayObject); //是否沙成员
      if Castle=nil then
      begin
        sText := '无';
      end
      else
      begin
        sText := IntToStr(Castle.nCastleFountain);//沙城泉水量
      end;
      sMsg := sub_49ADB8(sMsg, '<$CASTLEFOUNTAIN>', sText);
      exit;
    end
    else if sVariable = '$GUILDBUILDPOINT' then
    begin
      if PlayObject.m_MyGuild = nil then
      begin
        sText := '无';
      end
      else
      begin
        sText := IntToStr(TGuild(PlayObject.m_MyGuild).nBuildPoint);
      end;
      sMsg := sub_49ADB8(sMsg, '<$GUILDBUILDPOINT>', sText);
      exit;
    end
    else if sVariable = '$GUILDAURAEPOINT' then
    begin
      if PlayObject.m_MyGuild = nil then
      begin
        sText := '无';
      end
      else
      begin
        sText := IntToStr(TGuild(PlayObject.m_MyGuild).nAurae);
      end;
      sMsg := sub_49ADB8(sMsg, '<$GUILDAURAEPOINT>', sText);
      exit;
    end
    else if sVariable = '$GUILDSTABILITYPOINT' then
    begin
      if PlayObject.m_MyGuild = nil then
      begin
        sText := '无';
      end
      else
      begin
        sText := IntToStr(TGuild(PlayObject.m_MyGuild).nStability);
      end;
      sMsg := sub_49ADB8(sMsg, '<$GUILDSTABILITYPOINT>', sText);
      exit;
    end;
    if sVariable = '$GUILDFLOURISHPOINT' then
    begin
      if PlayObject.m_MyGuild = nil then
      begin
        sText := '无';
      end
      else
      begin
        sText := IntToStr(TGuild(PlayObject.m_MyGuild).nFlourishing);
      end;
      sMsg := sub_49ADB8(sMsg, '<$GUILDFLOURISHPOINT>', sText);
      exit;
    end;

    //其它信息
    if sVariable = '$REQUESTCASTLEWARITEM' then
    begin
      sText := g_Config.sZumaPiece;
      sMsg := sub_49ADB8(sMsg, '<$REQUESTCASTLEWARITEM>', sText);
      exit;
    end;
    if sVariable = '$REQUESTCASTLEWARDAY' then
    begin
      sText := g_Config.sZumaPiece;
      sMsg := sub_49ADB8(sMsg, '<$REQUESTCASTLEWARDAY>', sText);
      exit;
    end;
    if sVariable = '$REQUESTBUILDGUILDITEM' then
    begin
      sText := g_Config.sWomaHorn;
      sMsg := sub_49ADB8(sMsg, '<$REQUESTBUILDGUILDITEM>', sText);
      exit;
    end;

    if sVariable = '$GUILDWARFEE' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$GUILDWARFEE>',
        IntToStr(g_Config.nGuildWarPrice));
      exit;
    end;
    if sVariable = '$BUILDGUILDFEE' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BUILDGUILDFEE>',
        IntToStr(g_Config.nBuildGuildPrice));
      exit;
    end;

    if CompareLStr(sVariable, '$HUMAN(', Length('$HUMAN(')) then
    begin
      ArrestStringEx(sVariable, '(', ')', s14);
      boFoundVar := False;
      for I := 0 to PlayObject.m_DynamicVarList.Count - 1 do
      begin
        DynamicVar := PlayObject.m_DynamicVarList.Items[I];
        if CompareText(DynamicVar.sName, s14) = 0 then
        begin
          case DynamicVar.VarType of
            vInteger:
              begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                  IntToStr(DynamicVar.nInternet));
                boFoundVar := True;
              end;
            vString:
              begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                  DynamicVar.sString);
                boFoundVar := True;
              end;
          end;
          break;
        end;
      end;
      if not boFoundVar then
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', '??');

      exit;
    end;
    if CompareLStr(sVariable, '$GUILD(', Length('$GUILD(')) then
    begin
      if PlayObject.m_MyGuild = nil then
        exit;
      ArrestStringEx(sVariable, '(', ')', s14);
      boFoundVar := False;
      for I := 0 to TGuild(PlayObject.m_MyGuild).m_DynamicVarList.Count - 1 do
      begin
        DynamicVar := TGuild(PlayObject.m_MyGuild).m_DynamicVarList.Items[I];
        if CompareText(DynamicVar.sName, s14) = 0 then
        begin
          case DynamicVar.VarType of
            vInteger:
              begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                  IntToStr(DynamicVar.nInternet));
                boFoundVar := True;
              end;
            vString:
              begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                  DynamicVar.sString);
                boFoundVar := True;
              end;
          end;
          break;
        end;
      end;
      if not boFoundVar then
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', '??');
      exit;
    end;
    if CompareLStr(sVariable, '$GLOBAL(', Length('$GLOBAL(')) then
    begin
      ArrestStringEx(sVariable, '(', ')', s14);
      boFoundVar := False;
      for I := 0 to g_DynamicVarList.Count - 1 do
      begin
        DynamicVar := g_DynamicVarList.Items[I];
        if CompareText(DynamicVar.sName, s14) = 0 then
        begin
          case DynamicVar.VarType of
            vInteger:
              begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                  IntToStr(DynamicVar.nInternet));
                boFoundVar := True;
              end;
            vString:
              begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                  DynamicVar.sString);
                boFoundVar := True;
              end;
          end;
          break;
        end;
      end;
      if not boFoundVar then
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', '??');
      exit;
    end;
    if CompareLStr(sVariable, '$STR(', Length('$STR(')) then
    begin
      ArrestStringEx(sVariable, '(', ')', s14);
      n18 := GetValNameNo(s14);
      if n18 >= 0 then
      begin
        case n18 of
          0..99:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                IntToStr(PlayObject.m_nVal[n18]));
            end;
          1000..1999:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                IntToStr(g_Config.GlobalVal[n18 - 1000]));
            end;
          200..299:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                IntToStr(PlayObject.m_DyVal[n18 - 200]));
            end;
          300..399:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                IntToStr(PlayObject.m_nMval[n18 - 300]));
            end;
          4000..4999:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                IntToStr(g_Config.GlobaDyMval[n18 - 4000]));
            end;
          900..999:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                IntToStr(PlayObject.m_DyValEx[n18 - 900]));
            end;
          2000..2999:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                g_Config.GlobalStrVal[n18 - 2000]);
            end;
          3000..3999:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                g_Config.GlobaDyMStrVal[n18 - 3000]);
            end;
          700..799:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                PlayObject.m_StrVal[n18 - 700]);
            end;
          800..820:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                PlayObject.m_ServerStrVal[n18 - 800]);
            end;
          850..870:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
                IntToStr(PlayObject.m_ServerIntVal[n18 - 850]));
            end;
        end;
      end;
    end;
    //游戏命令变量
    if sVariable = '$CMD_DATE' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_DATE>', g_GameCommand.DATA.sCmd);
      exit;
    end;
    if sVariable = '$CMD_ALLOWMSG' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_ALLOWMSG>', g_GameCommand.ALLOWMSG.sCmd);
      exit;
    end;

    if sVariable = '$CMD_LETSHOUT' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_LETSHOUT>', g_GameCommand.LETSHOUT.sCmd);
      exit;
    end;
    if sVariable = '$CMD_LETTRADE' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_LETTRADE>', g_GameCommand.LETTRADE.sCmd);
      exit;
    end;

    if sVariable = '$CMD_LETGUILD' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_LETGUILD>', g_GameCommand.LETGUILD.sCmd);
      exit;
    end;

    if sVariable = '$CMD_ENDGUILD' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_ENDGUILD>', g_GameCommand.ENDGUILD.sCmd);
      exit;
    end;

    if sVariable = '$CMD_BANGUILDCHAT' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_BANGUILDCHAT>',
        g_GameCommand.BANGUILDCHAT.sCmd);
      exit;
    end;

    if sVariable = '$CMD_AUTHALLY' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_AUTHALLY>', g_GameCommand.AUTHALLY.sCmd);
      exit;
    end;

    if sVariable = '$CMD_AUTH' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_AUTH>', g_GameCommand.AUTH.sCmd);
      exit;
    end;

    if sVariable = '$CMD_AUTHCANCEL' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_AUTHCANCEL>',
        g_GameCommand.AUTHCANCEL.sCmd);
      exit;
    end;

    if sVariable = '$CMD_USERMOVE' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_USERMOVE>', g_GameCommand.USERMOVE.sCmd);
      exit;
    end;

    if sVariable = '$CMD_SEARCHING' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_SEARCHING>',
        g_GameCommand.SEARCHING.sCmd);
      exit;
    end;

    if sVariable = '$CMD_ALLOWGROUPCALL' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_ALLOWGROUPCALL>',
        g_GameCommand.ALLOWGROUPCALL.sCmd);
      exit;
    end;

    if sVariable = '$CMD_GROUPRECALLL' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_GROUPRECALLL>',
        g_GameCommand.GROUPRECALLL.sCmd);
      exit;
    end;

    if sVariable = '$CMD_ATTACKMODE' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_ATTACKMODE>',
        g_GameCommand.ATTACKMODE.sCmd);
      exit;
    end;

    if sVariable = '$CMD_REST' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_REST>', g_GameCommand.REST.sCmd);
      exit;
    end;

    if sVariable = '$CMD_STORAGESETPASSWORD' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGESETPASSWORD>',
        g_GameCommand.SETPASSWORD.sCmd);
      exit;
    end;
    if sVariable = '$CMD_STORAGECHGPASSWORD' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGECHGPASSWORD>',
        g_GameCommand.CHGPASSWORD.sCmd);
      exit;
    end;
    if sVariable = '$CMD_STORAGELOCK' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGELOCK>', g_GameCommand.LOCK.sCmd);
      exit;
    end;
    if sVariable = '$CMD_STORAGEUNLOCK' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGEUNLOCK>',
        g_GameCommand.UNLOCKSTORAGE.sCmd);
      exit;
    end;
    if sVariable = '$CMD_UNLOCK' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$CMD_UNLOCK>', g_GameCommand.UNLOCK.sCmd);
      exit;
    end;

    //城堡信息
    if sVariable = '' then
      exit;
    //  Castle:=Nil;
    if m_Castle <> nil then
    begin
      Castle := TUserCastle(m_Castle);
    end
    else
    begin
      Castle :=
        g_CastleManager.GetCastle(Str_ToInt(sVariable[Length(sVariable)], 0));
    end;
    if {sVariable = '$OWNERGUILD'} CompareLStr(sVariable, '$OWNERGUILD',
      Length('$OWNERGUILD')) then
    begin
      if Castle <> nil then
      begin
        sText := Castle.m_sOwnGuild;
        if sText = '' then
          sText := '游戏管理';
      end
      else
      begin
        sText := '????';
      end;
      sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      exit;
    end; //0049AF32

    if {sVariable = '$CASTLENAME'} CompareLStr(sVariable, '$CASTLENAME',
      Length('$CASTLENAME')) then
    begin
      if Castle <> nil then
      begin
        sText := Castle.m_sName;
      end
      else
      begin
        sText := '????';
      end;
      sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      exit;
    end;
    if {sVariable = '$LORD'} CompareLStr(sVariable, '$LORD', Length('$LORD'))
      then
    begin
      if Castle <> nil then
      begin
        if Castle.m_MasterGuild <> nil then
        begin
          sText := Castle.m_MasterGuild.GetChiefName();
        end
        else
          sText := '城堡管理员';
      end
      else
      begin
        sText := '????';
      end;
      sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      exit;
    end; //0049AF32

    if {sVariable = '$CASTLEWARDATE'} CompareLStr(sVariable, '$CASTLEWARDATE',
      Length('$CASTLEWARDATE')) then
    begin
      {if m_Castle = nil then begin
        m_Castle:=g_CastleManager.GetCastle(0);
      end; }
      if Castle <> nil then
      begin
        if not Castle.m_boUnderWar then
        begin
          sText := Castle.GetWarDate();
          if sText <> '' then
          begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
          end
          else
            sMsg := '暂时没有行会攻城 .\ \<返回/@main>';
        end
        else
          sMsg := '正在攻城当中.\ \<返回/@main>';
      end
      else
      begin
        sText := '????';
      end;
      exit;
    end;

    if {sVariable = '$LISTOFWAR'} CompareLStr(sVariable, '$LISTOFWAR',
      Length('$LISTOFWAR')) then
    begin
      if Castle <> nil then
      begin
        sText := Castle.GetAttackWarList();
      end
      else
      begin
        sText := '????';
      end;
      if sText <> '' then
      begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end
      else
        sMsg := '暂时没有行会攻城 .\ \<back/@main>';
      exit;
    end;

    if {sVariable = '$CASTLECHANGEDATE'} CompareLStr(sVariable,
      '$CASTLECHANGEDATE', Length('$CASTLECHANGEDATE')) then
    begin
      if Castle <> nil then
      begin
        sText := DateTimeToStr(Castle.m_ChangeDate);
      end
      else
      begin
        sText := '????';
      end;
      sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      exit;
    end;

    if {sVariable = '$CASTLEWARLASTDATE'} CompareLStr(sVariable,
      '$CASTLEWARLASTDATE', Length('$CASTLEWARLASTDATE')) then
    begin
      if Castle <> nil then
      begin
        sText := DateTimeToStr(Castle.m_WarDate);
      end
      else
      begin
        sText := '????';
      end;
      sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      exit;
    end;
    if {sVariable = '$CASTLEGETDAYS'} CompareLStr(sVariable, '$CASTLEGETDAYS',
      Length('$CASTLEGETDAYS')) then
    begin
      if Castle <> nil then
      begin
        sText := IntToStr(GetDayCount(Now, Castle.m_ChangeDate));
      end
      else
      begin
        sText := '????';
      end;
      sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      exit;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.GetVariableText');
  end;
end;

procedure TNormNpc.GotoLable(PlayObjectEx: TPlayObject; sLabel: string;
  boExtJmp: Boolean); //0049E584
var
  I, II, III: Integer;
  List1C: TStringList;
  bo11: Boolean;
  //  n18:Integer;
  n20: Integer;
  sSendMsg: string;
  Script: pTScript;
  Script3C: pTScript;
  SayingRecord: pTSayingRecord;
  SayingProcedure: pTSayingProcedure;
  UserItem: pTUserItem;
  sC: string;
  nCheckCode: integer;
  PlayObject: TPlayObject;

  function CheckQuestStatus(ScriptInfo: pTScript): Boolean; //0049BA00
  var
    I: Integer;
  begin
    Result := True;
    if not ScriptInfo.boQuest then
      exit;
    I := 0;
    while (True) do
    begin
      if (ScriptInfo.QuestInfo[I].nRandRage > 0) and
        (Random(ScriptInfo.QuestInfo[I].nRandRage) <> 0) then
      begin
        Result := False;
        break;
      end;
      if PlayObject.GetQuestFalgStatus(ScriptInfo.QuestInfo[I].wFlag) <>
        ScriptInfo.QuestInfo[I].btValue then
      begin
        Result := False;
        break;
      end;
      Inc(I);
      if I >= 10 then
        break;
    end; // while
  end;
  function CheckItemW(sItemType: string; nParam: Integer): pTUserItem; //0049BA7C
  var
    nCount: Integer;
  begin
    Result := nil;
    if CompareLStr(sItemType, '[NECKLACE]', 4) then
    begin
      if PlayObject.m_UseItems[U_NECKLACE].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_NECKLACE];
      end;
      exit;
    end;
    if CompareLStr(sItemType, '[RING]', 4) then
    begin
      if PlayObject.m_UseItems[U_RINGL].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_RINGL];
      end;
      if PlayObject.m_UseItems[U_RINGR].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_RINGR];
      end;
      exit;
    end;
    if CompareLStr(sItemType, '[ARMRING]', 4) then
    begin
      if PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_ARMRINGL];
      end;
      if PlayObject.m_UseItems[U_ARMRINGR].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_ARMRINGR];
      end;
      exit;
    end;
    if CompareLStr(sItemType, '[WEAPON]', 4) then
    begin
      if PlayObject.m_UseItems[U_WEAPON].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_WEAPON];
      end;
      exit;
    end;
    if CompareLStr(sItemType, '[HELMET]', 4) then
    begin
      if PlayObject.m_UseItems[U_HELMET].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_HELMET];
      end;
      exit;
    end;
    if CompareLStr(sItemType, '[BUJUK]', 4) then
    begin
      if PlayObject.m_UseItems[U_BUJUK].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_BUJUK];
      end;
      exit;
    end;
    if CompareLStr(sItemType, '[BELT]', 4) then
    begin
      if PlayObject.m_UseItems[U_BELT].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_BELT];
      end;
      exit;
    end;
    if CompareLStr(sItemType, '[BOOTS]', 4) then
    begin
      if PlayObject.m_UseItems[U_BOOTS].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_BOOTS];
      end;
      exit;
    end;
    if CompareLStr(sItemType, '[CHARM]', 4) then
    begin
      if PlayObject.m_UseItems[U_CHARM].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_CHARM];
      end;
      exit;
    end;
    Result := PlayObject.sub_4C4CD4(sItemType, nCount);
    if nCount < nParam then
      Result := nil;
  end;
  function CheckStringList(sHumName, sListFileName: string): Boolean; //0049B47C
  var
    I: Integer;
    LoadList: TStringList;
  begin
    Result := False;
    sListFileName := g_Config.sEnvirDir + sListFileName;
    if FileExists(sListFileName) then
    begin
      LoadList := TStringList.Create;
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
      for I := 0 to LoadList.Count - 1 do
      begin
        if CompareText(Trim(LoadList.Strings[I]), sHumName) = 0 then
        begin
          Result := True;
          break;
        end;
      end;
      LoadList.Free;
    end
    else
    begin
      MainOutMessage('file not found => ' + sListFileName);
    end;
  end;

  procedure GetValStringAndInteger(var Str: string; var Int: Integer);
  begin
    Str := GetLineVariableText(PlayObject, Str);
    Int := Str_ToInt(Str, 0);
  end;

  procedure ChangQuestCheckConditionVal(QuestConditionInfo:
    pTQuestConditionInfo);
  var
    i: Integer;
  begin
    for i := 1 to 6 do
    begin
      case i of
        1: GetValStringAndInteger(QuestConditionInfo.sParam1,
            QuestConditionInfo.nParam1);
        2: GetValStringAndInteger(QuestConditionInfo.sParam2,
            QuestConditionInfo.nParam2);
        3: GetValStringAndInteger(QuestConditionInfo.sParam3,
            QuestConditionInfo.nParam3);
        4: GetValStringAndInteger(QuestConditionInfo.sParam4,
            QuestConditionInfo.nParam4);
        5: GetValStringAndInteger(QuestConditionInfo.sParam5,
            QuestConditionInfo.nParam5);
        6: GetValStringAndInteger(QuestConditionInfo.sParam6,
            QuestConditionInfo.nParam6);
        7: GetValStringAndInteger(QuestConditionInfo.sParam7,
            QuestConditionInfo.nParam7);
      end;
    end;
  end;

  function QuestCheckCondition(ConditionList: TList): Boolean; //0049BCA8
  resourcestring
    sErrorMsg = 'Condition %d %s %s %s %s %s %s';
  var
    I, II: Integer;
    QuestConditionInfo: pTQuestConditionInfo;
    n10, n14, n18, n1C, nMaxDura, nDura: Integer;
    Hour, Min, Sec, MSec: Word;
    Envir: TEnvirnoment;
    StdItem: TItem;
    sName: string;
    boFlag: Boolean;
  begin
    Result := True;
    for I := 0 to ConditionList.Count - 1 do
    begin
      PlayObject := PlayObjectEx;
      QuestConditionInfo := ConditionList.Items[i];
      //通用三方执行脚本支持
      if QuestConditionInfo.TCmdList <> nil then
      begin
        boFlag := False;
        for II := 0 to QuestConditionInfo.TCmdList.Count - 1 do
        begin
          sName := QuestConditionInfo.TCmdList.Strings[II];
          if CompareText(sName, '$HERO') = 0 then
          begin
            if PlayObject.m_Hero <> nil then
              PlayObject := TPlayObject(PlayObject.m_Hero)
            else
              PlayObject := nil;
          end
          else
          begin
            sName := GetLineVariableText(PlayObject, sName);
            PlayObject := UserEngine.GetPlayObject(sName);
          end;
          if PlayObject = nil then
          begin
            ScriptListError(PlayObjectEx, QuestConditionInfo.TCmdList);
            boFlag := True;
            break;
          end;
        end;
        if boFlag then
          Continue;
      end;
      //070911 增加通用脚本变量支持
      m_QuestConditionInfo^ := QuestConditionInfo^;
      ChangQuestCheckConditionVal(m_QuestConditionInfo);
      QuestConditionInfo := m_QuestConditionInfo;
      try
        case QuestConditionInfo.nCmdCode of //
          nCHECK:
            begin
              n14 := Str_ToInt(QuestConditionInfo.sParam1, 0);
              n18 := Str_ToInt(QuestConditionInfo.sParam2, 0);
              n10 := PlayObject.GetQuestFalgStatus(n14);
              if n10 = 0 then
              begin
                if n18 <> 0 then
                  Result := False;
              end
              else
              begin
                if n18 = 0 then
                  Result := False;
              end;
            end;
          nRANDOM:
            begin
              if Random(QuestConditionInfo.nParam1) <> 0 then
                Result := False;
            end;
          nGENDER:
            begin
              if CompareText(QuestConditionInfo.sParam1, sMAN) = 0 then
              begin
                if PlayObject.m_btGender <> gMan then
                  Result := False;
              end
              else
              begin
                if PlayObject.m_btGender <> gWoMan then
                  Result := False;
              end;
            end;
          nSC_DAYTIME:
            begin
              if CompareText(QuestConditionInfo.sParam1, sSUNRAISE) = 0 then
              begin
                if g_nGameTime <> 0 then
                  Result := False;
              end;
              if CompareText(QuestConditionInfo.sParam1, sDAY) = 0 then
              begin
                if g_nGameTime <> 1 then
                  Result := False;
              end;
              if CompareText(QuestConditionInfo.sParam1, sSUNSET) = 0 then
              begin
                if g_nGameTime <> 2 then
                  Result := False;
              end;
              if CompareText(QuestConditionInfo.sParam1, sNIGHT) = 0 then
              begin
                if g_nGameTime <> 3 then
                  Result := False;
              end;
            end;
          {nCHECKOPEN: begin
            n14:=Str_ToInt(QuestConditionInfo.sParam1,0);
            n18:=Str_ToInt(QuestConditionInfo.sParam2,0);
            n10:=PlayObject.GetQuestUnitOpenStatus(n14);
            if n10 = 0 then begin
              if n18 <> 0 then Result:=False;
            end else begin
              if n18 = 0 then Result:=False;
            end;
          end;}
          {nCHECKUNIT: begin
            n14:=Str_ToInt(QuestConditionInfo.sParam1,0);
            n18:=Str_ToInt(QuestConditionInfo.sParam2,0);
            n10:=PlayObject.GetQuestUnitStatus(n14);
            if n10 = 0 then begin
              if n18 <> 0 then Result:=False;
            end else begin
              if n18 = 0 then Result:=False;
            end;
          end;}
          nCHECKLEVEL: if PlayObject.m_Abil.Level < QuestConditionInfo.nParam1
            then
              Result := False;
          nCHECKJOB:
            begin
              if CompareLStr(QuestConditionInfo.sParam1, sWarrior,
                Length(sWarrior)) then
              begin
                if PlayObject.m_btJob <> jWarr then
                  Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, sWizard,
                Length(sWizard)) then
              begin
                if PlayObject.m_btJob <> jWizard then
                  Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, sTaos, Length(sTaos))
                then
              begin
                if PlayObject.m_btJob <> jTaos then
                  Result := False;
              end;
            end;
          //nCHECKBBCOUNT: if PlayObject.m_SlaveList.Count < QuestConditionInfo.nParam1 then Result:=False;
          //nCHECKCREDITPOINT:;
          nCHECKITEM:
            begin
              UserItem := PlayObject.QuestCheckItem(QuestConditionInfo.sParam1,
                n1C, nMaxDura, nDura);
              if n1C < QuestConditionInfo.nParam2 then
                Result := False;
            end;
          nCHECKITEMW:
            begin
              UserItem := CheckItemW(QuestConditionInfo.sParam1,
                QuestConditionInfo.nParam2);
              if UserItem = nil then
                Result := False;
            end;
          nCHECKGOLD: if PlayObject.m_nGold < QuestConditionInfo.nParam1 then
              Result := False;
          //nISTAKEITEM: if sC <> QuestConditionInfo.sParam1 then Result:=False;
          nSC_CHECKDURA:
            begin
              UserItem := PlayObject.QuestCheckItem(QuestConditionInfo.sParam1,
                n1C, nMaxDura, nDura);
              if ROUND(nDura / 1000) < QuestConditionInfo.nParam2 then
                Result := False;
            end;
          nSC_CHECKDURAEVA:
            begin
              UserItem := PlayObject.QuestCheckItem(QuestConditionInfo.sParam1,
                n1C, nMaxDura, nDura);
              if n1C > 0 then
              begin
                if ROUND(nMaxDura / n1C / 1000) < QuestConditionInfo.nParam2
                  then
                  Result := False;
              end
              else
                Result := False;
            end;
          nDAYOFWEEK:
            begin
              if CompareLStr(QuestConditionInfo.sParam1, sSUN, Length(sSUN))
                then
              begin
                if DayOfWeek(Now) <> 1 then
                  Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, sMON, Length(sMON))
                then
              begin
                if DayOfWeek(Now) <> 2 then
                  Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, sTUE, Length(sTUE))
                then
              begin
                if DayOfWeek(Now) <> 3 then
                  Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, sWED, Length(sWED))
                then
              begin
                if DayOfWeek(Now) <> 4 then
                  Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, sTHU, Length(sTHU))
                then
              begin
                if DayOfWeek(Now) <> 5 then
                  Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, sFRI, Length(sFRI))
                then
              begin
                if DayOfWeek(Now) <> 6 then
                  Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, sSAT, Length(sSAT))
                then
              begin
                if DayOfWeek(Now) <> 7 then
                  Result := False;
              end;
            end;
          nHOUR:
            begin
              if (QuestConditionInfo.nParam1 <> 0) and
                (QuestConditionInfo.nParam2 = 0) then
                QuestConditionInfo.nParam2 := QuestConditionInfo.nParam1;
              DecodeTime(Time, Hour, Min, Sec, MSec);
              if (Hour < QuestConditionInfo.nParam1) or (Hour >
                QuestConditionInfo.nParam2) then
                Result := False;
            end;
          nMIN:
            begin
              if (QuestConditionInfo.nParam1 <> 0) and
                (QuestConditionInfo.nParam2 = 0) then
                QuestConditionInfo.nParam2 := QuestConditionInfo.nParam1;
              DecodeTime(Time, Hour, Min, Sec, MSec);
              if (Min < QuestConditionInfo.nParam1) or (Min >
                QuestConditionInfo.nParam2) then
                Result := False;
            end;
          nCHECKPKPOINT: if PlayObject.PKLevel < QuestConditionInfo.nParam1 then
              Result := False;

          //nCHECKLUCKYPOINT: if PlayObject.m_nBodyLuckLevel < QuestConditionInfo.nParam1 then Result:=False;
          nCHECKMONMAP:
            begin
              Envir := g_MapManager.FindMap(QuestConditionInfo.sParam1);
              if Envir <> nil then
              begin
                if UserEngine.GetMapMonster(Envir, nil) <
                  QuestConditionInfo.nParam2 then
                  Result := False;
              end;

            end;
          //nCHECKMONAREA:;
          nCHECKHUM:
            begin //0049C4CB
              if UserEngine.GetMapHuman(QuestConditionInfo.sParam1) <
                QuestConditionInfo.nParam2 then
                Result := False;
            end;

          nCHECKBAGGAGE:
            begin
              if PlayObject.IsEnoughBag then
              begin
                if QuestConditionInfo.sParam1 <> '' then
                begin
                  Result := False;
                  StdItem := UserEngine.GetStdItem(QuestConditionInfo.sParam1);
                  if StdItem <> nil then
                  begin
                    if PlayObject.IsAddWeightAvailable(StdItem.Weight) then
                      Result := True;
                  end;
                end;
              end
              else
                Result := False;
            end;
          nCHECKNAMELIST: if not CheckStringList(PlayObject.m_sCharName, m_sPath
              + QuestConditionInfo.sParam1) then
              Result := False;
          nCHECKACCOUNTLIST: if not CheckStringList(PlayObject.m_sUserID, m_sPath
              + QuestConditionInfo.sParam1) then
              Result := False;
          nCHECKIPLIST: if not CheckStringList(PlayObject.m_sIPaddr, m_sPath +
              QuestConditionInfo.sParam1) then
              Result := False;
          nEQUAL:
            begin //0049C5AC
              n10 := GetValNameNo(QuestConditionInfo.sParam1);
              if n10 >= 0 then
              begin
                case n10 of //
                  0..99:
                    begin
                      if PlayObject.m_nVal[n10] <> QuestConditionInfo.nParam2
                        then
                        Result := False;
                    end;
                  1000..1999:
                    begin
                      if g_Config.GlobalVal[n10 - 1000] <>
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  200..299:
                    begin
                      if PlayObject.m_DyVal[n10 - 200] <>
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  300..399:
                    begin
                      if PlayObject.m_nMval[n10 - 300] <>
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  4000..4999:
                    begin
                      if g_Config.GlobaDyMval[n10 - 4000] <>
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  850..870:
                    begin
                      if PlayObject.m_ServerIntVal[n10 - 850] <>
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  900..999:
                    begin
                      if PlayObject.m_DyValEx[n10 - 900] <>
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  2000..2999:
                    begin
                      if (CompareText(g_Config.GlobalStrVal[n10 - 2000],
                        QuestConditionInfo.sParam2) <> 0) then
                        Result := False;
                    end;
                  3000..3999:
                    begin
                      if (CompareText(g_Config.GlobaDyMStrVal[n10 - 3000],
                        QuestConditionInfo.sParam2) <> 0) then
                        Result := False;
                    end;
                  700..799:
                    begin
                      if (CompareText(PlayObject.m_StrVal[n10 - 700],
                        QuestConditionInfo.sParam2) <> 0) then
                        Result := False;
                    end;
                  800..820:
                    begin
                      if (CompareText(PlayObject.m_ServerStrVal[n10 - 800],
                        QuestConditionInfo.sParam2) <> 0) then
                        Result := False;
                    end;
                else
                  ScriptConditionError(PlayObject, QuestConditionInfo, sEQUAL);
                end; // case
              end
              else
                Result := False;
            end;
          nLARGE:
            begin //0049C658
              n10 := GetValNameNo(QuestConditionInfo.sParam1);
              if n10 >= 0 then
              begin
                case n10 of //
                  0..99:
                    begin
                      if PlayObject.m_nVal[n10] <= QuestConditionInfo.nParam2
                        then
                        Result := False;
                    end;
                  1000..1999:
                    begin
                      if g_Config.GlobalVal[n10 - 1000] <=
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  200..299:
                    begin
                      if PlayObject.m_DyVal[n10 - 200] <=
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  300..399:
                    begin
                      if PlayObject.m_nMval[n10 - 300] <=
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  4000..4999:
                    begin
                      if g_Config.GlobaDyMval[n10 - 4000] <=
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  850..870:
                    begin
                      if PlayObject.m_ServerIntVal[n10 - 850] <=
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  900..999:
                    begin
                      if PlayObject.m_DyValEx[n10 - 900] <=
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                else
                  ScriptConditionError(PlayObject, QuestConditionInfo, sLARGE);
                end; // case
              end
              else
                Result := False;
            end;

          nSMALL:
            begin //0049C704
              n10 := GetValNameNo(QuestConditionInfo.sParam1);
              if n10 >= 0 then
              begin
                case n10 of //
                  0..99:
                    begin
                      if PlayObject.m_nVal[n10] >= QuestConditionInfo.nParam2
                        then
                        Result := False;
                    end;
                  1000..1999:
                    begin
                      if g_Config.GlobalVal[n10 - 1000] >=
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  200..299:
                    begin
                      if PlayObject.m_DyVal[n10 - 200] >=
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  300..399:
                    begin
                      if PlayObject.m_nMval[n10 - 300] >=
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  4000..4999:
                    begin
                      if g_Config.GlobaDyMval[n10 - 4000] >=
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  850..870:
                    begin
                      if PlayObject.m_ServerIntVal[n10 - 850] >=
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                  900..999:
                    begin
                      if PlayObject.m_DyValEx[n10 - 900] >=
                        QuestConditionInfo.nParam2 then
                        Result := False;
                    end;
                else
                  ScriptConditionError(PlayObject, QuestConditionInfo, sSMALL);
                end;
              end
              else
                Result := False;
            end;
          //nSC_ISSYSOP: if not (PlayObject.m_btPermission >= 4) then Result:=False;
          nSC_ISADMIN: if not (PlayObject.m_btPermission >= 6) then
              Result := False;
          nSC_CHECKGROUPCOUNT: if not ConditionOfCheckGroupCount(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKPOSEDIR: if not ConditionOfCheckPoseDir(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKPOSELEVEL: if not ConditionOfCheckPoseLevel(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKPOSEGENDER: if not ConditionOfCheckPoseGender(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKLEVELEX: if not ConditionOfCheckLevelEx(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKBONUSPOINT: if not ConditionOfCheckBonusPoint(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKMARRY: if not ConditionOfCheckMarry(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKPOSEMARRY: if not ConditionOfCheckPoseMarry(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKMARRYCOUNT: if not ConditionOfCheckMarryCount(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKMASTER: if not ConditionOfCheckMaster(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_HAVEMASTER: if not ConditionOfHaveMaster(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKPOSEMASTER: if not ConditionOfCheckPoseMaster(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_POSEHAVEMASTER: if not ConditionOfPoseHaveMaster(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKISMASTER: if not ConditionOfCheckIsMaster(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_HASGUILD: if not ConditionOfCheckHaveGuild(PlayObject,
              QuestConditionInfo) then
              Result := False;

          nSC_ISGUILDMASTER: if not ConditionOfCheckIsGuildMaster(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKCASTLEMASTER: if not
            ConditionOfCheckIsCastleMaster(PlayObject, QuestConditionInfo) then
              Result := False;
          nSC_ISCASTLEGUILD: if not ConditionOfCheckIsCastleaGuild(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_ISATTACKGUILD: if not ConditionOfCheckIsAttackGuild(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_ISDEFENSEGUILD: if not ConditionOfCheckIsDefenseGuild(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKCASTLEDOOR: if not
            ConditionOfCheckCastleDoorStatus(PlayObject, QuestConditionInfo)
              then
              Result := False;
          //nSC_ISATTACKALLYGUILD  :if not ConditionOfCheckIsAttackAllyGuild(PlayObject,QuestConditionInfo) then Result:=False;
          //nSC_ISDEFENSEALLYGUILD :if not ConditionOfCheckIsDefenseAllyGuild(PlayObject,QuestConditionInfo) then Result:=False;
          nSC_CHECKPOSEISMASTER: if not ConditionOfCheckPoseIsMaster(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKNAMEIPLIST: if not ConditionOfCheckNameIPList(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKACCOUNTIPLIST: if not
            ConditionOfCheckAccountIPList(PlayObject, QuestConditionInfo) then
              Result := False;
          nSC_CHECKSLAVECOUNT: if not ConditionOfCheckSlaveCount(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_ISNEWHUMAN: if not PlayObject.m_boNewHuman then
              Result := False;
          nSC_CHECKMEMBERTYPE: if not ConditionOfCheckMemberType(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKMEMBERLEVEL: if not ConditionOfCheckMemBerLevel(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKGAMEGOLD: if not ConditionOfCheckGameGold(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKGAMEPOINT: if not ConditionOfCheckGamePoint(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKNAMELISTPOSITION: if not
            ConditionOfCheckNameListPostion(PlayObject, QuestConditionInfo) then
              Result := False;
          //nSC_CHECKGUILDLIST:     if not ConditionOfCheckGuildList(PlayObject,QuestConditionInfo) then Result:=False;
          nSC_CHECKGUILDLIST:
            begin
              if PlayObject.m_MyGuild <> nil then
              begin
                if not CheckStringList(TGuild(PlayObject.m_MyGuild).sGuildName,
                  m_sPath + QuestConditionInfo.sParam1) then
                  Result := False;
              end
              else
                Result := False;
            end;
          nSC_CHECKRENEWLEVEL: if not ConditionOfCheckReNewLevel(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKSLAVELEVEL: if not ConditionOfCheckSlaveLevel(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKSLAVENAME: if not ConditionOfCheckSlaveName(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKCREDITPOINT: if not ConditionOfCheckCreditPoint(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKOFGUILD: if not ConditionOfCheckOfGuild(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKPAYMENT: if not ConditionOfCheckPayMent(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKUSEITEM: if not ConditionOfCheckUseItem(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKBAGSIZE: if not ConditionOfCheckBagSize(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKLISTCOUNT: if not ConditionOfCheckListCount(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKDC: if not ConditionOfCheckDC(PlayObject, QuestConditionInfo)
            then
              Result := False;
          nSC_CHECKMC: if not ConditionOfCheckMC(PlayObject, QuestConditionInfo)
            then
              Result := False;
          nSC_CHECKSC: if not ConditionOfCheckSC(PlayObject, QuestConditionInfo)
            then
              Result := False;
          nSC_CHECKHP: if not ConditionOfCheckHP(PlayObject, QuestConditionInfo)
            then
              Result := False;
          nSC_CHECKMP: if not ConditionOfCheckMP(PlayObject, QuestConditionInfo)
            then
              Result := False;
          nSC_CHECKITEMTYPE: if not ConditionOfCheckItemType(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKEXP: if not ConditionOfCheckExp(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKCASTLEGOLD: if not ConditionOfCheckCastleGold(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_PASSWORDERRORCOUNT: if not
            ConditionOfCheckPasswordErrorCount(PlayObject, QuestConditionInfo)
              then
              Result := False;
          nSC_ISLOCKPASSWORD: if not ConditionOfIsLockPassword(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_ISLOCKSTORAGE: if not ConditionOfIsLockStorage(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKBUILDPOINT: if not
            ConditionOfCheckGuildBuildPoint(PlayObject, QuestConditionInfo) then
              Result := False;
          nSC_CHECKAURAEPOINT: if not
            ConditionOfCheckGuildAuraePoint(PlayObject, QuestConditionInfo) then
              Result := False;
          nSC_CHECKSTABILITYPOINT: if not
            ConditionOfCheckStabilityPoint(PlayObject, QuestConditionInfo) then
              Result := False;
          nSC_CHECKFLOURISHPOINT: if not
            ConditionOfCheckFlourishPoint(PlayObject, QuestConditionInfo) then
              Result := False;
          nSC_CHECKCONTRIBUTION: if not ConditionOfCheckContribution(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKRANGEMONCOUNT: if not
            ConditionOfCheckRangeMonCount(PlayObject, QuestConditionInfo) then
              Result := False;
          nSC_CHECKITEMADDVALUE: if not ConditionOfCheckItemAddValue(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKINMAPRANGE: if not ConditionOfCheckInMapRange(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CASTLECHANGEDAY: if not ConditionOfCheckCastleChageDay(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CASTLEWARDAY: if not ConditionOfCheckCastleWarDay(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_ONLINELONGMIN: if not ConditionOfCheckOnlineLongMin(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKGUILDCHIEFITEMCOUNT: if not
            ConditionOfCheckChiefItemCount(PlayObject, QuestConditionInfo) then
              Result := False;
          nSC_CHECKNAMEDATELIST: if not ConditionOfCheckNameDateList(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKMAPHUMANCOUNT: if not
            ConditionOfCheckMapHumanCount(PlayObject, QuestConditionInfo) then
              Result := False;
          nSC_CHECKMAPMONCOUNT: if not ConditionOfCheckMapMonCount(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKVAR: if not ConditionOfCheckVar(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKSERVERNAME: if not ConditionOfCheckServerName(PlayObject,
              QuestConditionInfo) then
              Result := False;

          nSC_CHECKMAP: if not ConditionOfCheckMap(PlayObject,
              QuestConditionInfo) then
              Result := False;
          //nSC_CHECKPOS            :if not ConditionOfCheckPos(PlayObject,QuestConditionInfo) then Result:=False;
          //nSC_REVIVESLAVE         :if not ConditionOfReviveSlave(PlayObject,QuestConditionInfo) then Result:=False;
          nSC_CHECKMAGICLVL: if not ConditionOfCheckMagicLvl(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKGROUPCLASS: if not ConditionOfCheckGroupClass(PlayObject,
              QuestConditionInfo) then
              Result := False;

          nSC_CHECKGAMEDIAMOND: if not ConditionOfCheckGameDiamond(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKGAMEGIRD: if not ConditionOfCheckGameGird(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_ISGROUPMASTER: Result := (PlayObject.m_GroupOwner = PlayObject);
          nSC_ISONMAP:
            begin
              Result := False;
              if (PlayObject.m_PEnvir <> nil) then
              begin
                if CompareText(PlayObject.m_PEnvir.sMapName,
                  QuestConditionInfo.sParam1) = 0 then
                  Result := True;
              end;
            end;
          nSC_HAVEHERO: Result := ((PlayObject.m_HeroName <> '') or
              (PlayObject.m_HeroName1 <> ''));
          nSC_INSAFEZONE: Result := PlayObject.InSafeZone;
          nSC_ISDUPMODE:
            begin
              Result := False;
              if (PlayObject.m_PEnvir <> nil) and
                (PlayObject.m_PEnvir.GetXYObjCount(PlayObject.m_nCurrX,
                PlayObject.m_nCurrY) > 1) then
                Result := True;
            end;
          nSC_CHECKITEMSTATE: if not ConditionOfCheckItemState(PlayObject,
              QuestConditionInfo) then
              Result := False;
          nSC_CHECKONLINE: if
            UserEngine.GetPlayObject(QuestConditionInfo.sParam1) = nil then
              Result := False;
          nSC_CHECKCONTAINSTEXT: Result :=
            AnsiContainsText(QuestConditionInfo.sParam1,
              QuestConditionInfo.sParam2);
          nSC_COMPARETEXT: Result := CompareText(QuestConditionInfo.sParam1,
              QuestConditionInfo.sParam2) = 0;
          nSC_CHECKCASTLEWAR: Result := ConditionOfCheckCastlewar(PlayObject,
              QuestConditionInfo);
          nSC_MAPHUMISSAMEGUILD: Result :=
            ConditionOfMapHumIsSameGuild(PlayObject, QuestConditionInfo);
          nSC_CHECKHEROONLINE: Result := PlayObject.m_Hero <> nil;
          nSC_CHECKHEROLEVEL: Result := ConditionOfCheckHeroLevel(PlayObject,
              QuestConditionInfo);
          nSC_CHECKHEROJOB: Result := ConditionOfCheckHeroJob(PlayObject,
              QuestConditionInfo);
          nSC_CHECKHEROPKPOINT: Result :=
            ConditionOfCheckHeroPKPoint(PlayObject, QuestConditionInfo);
          nSC_OFFLINEPLAYERCOUNT: Result :=
            ConditionOfOffLinePlayerCount(PlayObject, QuestConditionInfo);
          nSC_CHECKUSERDATE: Result := ConditionOfCheckUserDate(PlayObject,
              QuestConditionInfo);
          nSC_CHECKRANDOMNO: Result := Str_ToInt(PlayObject.m_ServerStrVal[0], 0)
            = PlayObject.m_RandomNo;
          nSC_CHECKCODELIST: Result := ConditionOfCheckCodeList(PlayObject,
              QuestConditionInfo);
          nSC_ISHIGH: Result := ConditionOfIsHigh(PlayObject,
              QuestConditionInfo);
          nSC_CHECKONLINEPLAYCOUNT: Result :=
            ConditionOfCheckOnLinePlayCount(PlayObject, QuestConditionInfo);
          nSC_CHECKMAPNAME: Result := ConditionOfCheckMapName(PlayObject,
              QuestConditionInfo);
          nSC_CHECKMAPMOBCOUNT: Result :=
            ConditionOfCheckMapMobCount(PlayObject, QuestConditionInfo);
          nSC_FINDMAPPATH: Result := ConditionOfFindMapPath(PlayObject,
              QuestConditionInfo);
          nSC_CHECKSKILL: Result := ConditionOfCheckSkill(PlayObject,
              QuestConditionInfo);
          nSC_CHECKDIPLOID: Result := ConditionOfCheckDiploid(PlayObject,
              QuestConditionInfo);
          nSC_CHECKITEMLEVEL: Result := ConditionOfCheckItemLevel(PlayObject,
              QuestConditionInfo);
          nSC_CHECKSIDESLAVENAME: Result :=
            ConditionOfCheckSideSlaveName(PlayObject, QuestConditionInfo);
          nSC_CHECKGLORYPOINT: Result := ConditionOfCheckGloryPoint(PlayObject,
              QuestConditionInfo);
          nSC_CHECKLISTTEXT: Result := ConditionOfCheckListText(PlayObject,
              QuestConditionInfo);
          nSC_CHECKSIGNMAP: Result := (PlayObject.m_sDieMap <> '');
          nSC_CHECKBAGGAGE: ;
          nSC_CHECKHEROLOYAL: Result := ConditionOfCheckHeroLoyal(PlayObject,
              QuestConditionInfo);
          nSC_CHECKISSAVEHERO: Result := ((PlayObject.m_HeroName1 <> '') or
              (PlayObject.m_HeroName2 <> ''));
          nSC_CHECKGUILDFOUNTAIN:Result := ConditionOfCHECKGUILDFOUNTAIN(PlayObject,
              QuestConditionInfo);
          nSC_ISONMAKEWINE:Result := ConditionOfISONMAKEWINE(PlayObject,QuestConditionInfo);
          nSC_KILLBYHUM:Result:= ConditionOfKILLBYHUM(PlayObject,QuestConditionInfo);
          nSC_KILLBYMON:Result:= ConditionOfKILLBYMON(PlayObject,QuestConditionInfo);
          nSC_CHECKDRUNKRATE:Result:= ConditionOfCHECKDRUNKRATE(PlayObject,QuestConditionInfo);
        end;
      except
        try
          MainOutMessage(Format(sErrorMsg, [QuestConditionInfo.nCmdCode,
            QuestConditionInfo.sParam1,
              QuestConditionInfo.sParam2,
              QuestConditionInfo.sParam3,
              QuestConditionInfo.sParam4,
              QuestConditionInfo.sParam5,
              QuestConditionInfo.sParam6]));
        except
          MainOutMessage('[Exception] QuestConditionInfo');
        end;
      end;
      if not Result then
        break;
    end;
  end;
  function JmpToLable(sLabel: string): Boolean;
  begin
    Result := False;
    Inc(PlayObject.m_nScriptGotoCount);
    if PlayObject.m_nScriptGotoCount > g_Config.nScriptGotoCountLimit {10} then
      exit;
    GotoLable(PlayObject, sLabel, False);
    Result := True;
  end;
  procedure GoToQuest(nQuest: Integer); //0049C898
  var
    I: Integer;
    Script: pTScript;
  begin
    for I := 0 to m_ScriptList.Count - 1 do
    begin
      Script := m_ScriptList.Items[I];
      if Script.nQuest = nQuest then
      begin
        PlayObject.m_Script := Script;
        PlayObject.m_NPC := Self;
        GotoLable(PlayObject, sMAIN, False);
        break;
      end;
    end;
  end;

  procedure AddList(sHumName, sListFileName: string); //0049B620
  var
    I: Integer;
    LoadList: TStringList;
    s10: string;
    bo15: Boolean;
  begin
    sListFileName := g_Config.sEnvirDir + sListFileName;
    LoadList := TStringList.Create;
    if FileExists(sListFileName) then
    begin
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
    end;
    bo15 := False;
    for I := 0 to LoadList.Count - 1 do
    begin
      s10 := Trim(LoadList.Strings[i]);
      if CompareText(sHumName, s10) = 0 then
      begin
        bo15 := True;
        break;
      end;
    end;
    if not bo15 then
    begin
      LoadList.Add(sHumName);
      try
        LoadList.SaveToFile(sListFileName);
      except
        MainOutMessage('saving fail.... => ' + sListFileName);
      end;
    end;

    LoadList.Free;
  end;
  procedure DelList(sHumName, sListFileName: string); //0049B7F8
  var
    I: Integer;
    LoadList: TStringList;
    s10: string;
    bo15: Boolean;
  begin
    sListFileName := g_Config.sEnvirDir + sListFileName;
    LoadList := TStringList.Create;
    if FileExists(sListFileName) then
    begin
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
    end;
    bo15 := False;
    for I := 0 to LoadList.Count - 1 do
    begin
      s10 := Trim(LoadList.Strings[i]);
      if CompareText(sHumName, s10) = 0 then
      begin
        LoadList.Delete(i);
        bo15 := True;
        break;
      end;
    end;
    if bo15 then
    begin
      try
        LoadList.SaveToFile(sListFileName);
      except
        MainOutMessage('saving fail.... => ' + sListFileName);
      end;
    end;
    LoadList.Free;
  end;
  procedure TakeItem(sItemName: string; nItemCount: Integer); //0049C998
  var
    I: Integer;
    UserItem: pTUserItem;
    StdItem: TItem;
  begin
    if CompareText(sItemName, sSTRING_GOLDNAME) = 0 then
    begin
      PlayObject.DecGold(nItemCount);
      PlayObject.GoldChanged();
      //0049CADB
      if g_boGameLogGold then
        AddGameDataLog('10' + #9 +
          PlayObject.m_sMapName + #9 +
          IntToStr(PlayObject.m_nCurrX) + #9 +
          IntToStr(PlayObject.m_nCurrY) + #9 +
          PlayObject.m_sCharName + #9 +
          sSTRING_GOLDNAME + #9 +
          IntToStr(nItemCount) + #9 +
          '1' + #9 +
          m_sCharName);
      exit;
    end;
    for I := PlayObject.m_ItemList.Count - 1 downto 0 do
    begin
      if nItemCount <= 0 then
        break;
      UserItem := PlayObject.m_ItemList.Items[i];
      if CompareText(UserEngine.GetStdItemName(UserItem.wIndex), sItemName) = 0
        then
      begin
        //0049CC24
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if StdItem.NeedIdentify = 1 then
          AddGameDataLog('10' + #9 +
            PlayObject.m_sMapName + #9 +
            IntToStr(PlayObject.m_nCurrX) + #9 +
            IntToStr(PlayObject.m_nCurrY) + #9 +
            PlayObject.m_sCharName + #9 +
            sItemName + #9 +
            IntToStr(UserItem.MakeIndex) + #9 +
            '1' + #9 +
            m_sCharName);
        PlayObject.SendDelItems(UserItem);
        sC := UserEngine.GetStdItemName(UserItem.wIndex);
        Dispose(UserItem);
        PlayObject.m_ItemList.Delete(I);
        Dec(nItemCount);
      end;
    end;
  end;
  procedure GiveItem(sItemName: string; nItemCount: Integer); //0049D1D0
  var
    I: Integer;
    UserItem: pTUserItem;
    StdItem: TItem;
  begin

    if CompareText(sItemName, sSTRING_GOLDNAME) = 0 then
    begin
      PlayObject.IncGold(nItemCount);
      PlayObject.GoldChanged();
      //0049D2FE
      if g_boGameLogGold then
        AddGameDataLog('9' + #9 +
          PlayObject.m_sMapName + #9 +
          IntToStr(PlayObject.m_nCurrX) + #9 +
          IntToStr(PlayObject.m_nCurrY) + #9 +
          PlayObject.m_sCharName + #9 +
          sSTRING_GOLDNAME + #9 +
          IntToStr(nItemCount) + #9 +
          '1' + #9 +
          m_sCharName);
      exit;
    end;
    if UserEngine.GetStdItemIdx(sItemName) > 0 then
    begin
      //      if nItemCount > 50 then nItemCount:=50;//11.22 限制数量大小
      if not (nItemCount in [1..50]) then
        nItemCount := 1; //12.28 改上一条

      for I := 0 to nItemCount - 1 do
      begin //nItemCount 为0时出死循环
        if PlayObject.IsEnoughBag then
        begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
          begin
            PlayObject.m_ItemList.Add((UserItem));
            PlayObject.SendAddItem(UserItem);
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            //0049D46B
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('9' + #9 +
                PlayObject.m_sMapName + #9 +
                IntToStr(PlayObject.m_nCurrX) + #9 +
                IntToStr(PlayObject.m_nCurrY) + #9 +
                PlayObject.m_sCharName + #9 +
                sItemName + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                m_sCharName);
          end
          else
            Dispose(UserItem);
        end
        else
        begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
          begin
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            //0049D5A5
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('9' + #9 +
                PlayObject.m_sMapName + #9 +
                IntToStr(PlayObject.m_nCurrX) + #9 +
                IntToStr(PlayObject.m_nCurrY) + #9 +
                PlayObject.m_sCharName + #9 +
                sItemName + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                m_sCharName);
            PlayObject.DropItemDown(UserItem, 3, False, PlayObject, nil);
          end;
          Dispose(UserItem);
        end;
      end;
    end;
  end;
  procedure TakeWItem(sItemName: string; nItemCount: Integer); //0049CCF8
  var
    I: Integer;
    sName: string;
  begin
    if CompareLStr(sItemName, '[NECKLACE]', 4) then
    begin
      if PlayObject.m_UseItems[U_NECKLACE].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_NECKLACE]);
        sC :=
          UserEngine.GetStdItemName(PlayObject.m_UseItems[U_NECKLACE].wIndex);
        PlayObject.m_UseItems[U_NECKLACE].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[RING]', 4) then
    begin
      if PlayObject.m_UseItems[U_RINGL].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_RINGL]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGL].wIndex);
        PlayObject.m_UseItems[U_RINGL].wIndex := 0;
        exit;
      end;
      if PlayObject.m_UseItems[U_RINGR].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_RINGR]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGR].wIndex);
        PlayObject.m_UseItems[U_RINGR].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[ARMRING]', 4) then
    begin
      if PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_ARMRINGL]);
        sC :=
          UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
        PlayObject.m_UseItems[U_ARMRINGL].wIndex := 0;
        exit;
      end;
      if PlayObject.m_UseItems[U_ARMRINGR].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_ARMRINGR]);
        sC :=
          UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGR].wIndex);
        PlayObject.m_UseItems[U_ARMRINGR].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[WEAPON]', 4) then
    begin
      if PlayObject.m_UseItems[U_WEAPON].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_WEAPON]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_WEAPON].wIndex);
        PlayObject.m_UseItems[U_WEAPON].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[HELMET]', 4) then
    begin
      if PlayObject.m_UseItems[U_HELMET].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_HELMET]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_HELMET].wIndex);
        PlayObject.m_UseItems[U_HELMET].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[DRESS]', 4) then
    begin
      if PlayObject.m_UseItems[U_DRESS].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_DRESS]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_DRESS].wIndex);
        PlayObject.m_UseItems[U_DRESS].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_BUJUK]', 4) then
    begin
      if PlayObject.m_UseItems[U_BUJUK].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_BUJUK]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BUJUK].wIndex);
        PlayObject.m_UseItems[U_BUJUK].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_BELT]', 4) then
    begin
      if PlayObject.m_UseItems[U_BELT].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_BELT]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BELT].wIndex);
        PlayObject.m_UseItems[U_BELT].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_BOOTS]', 4) then
    begin
      if PlayObject.m_UseItems[U_BOOTS].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_BOOTS]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BOOTS].wIndex);
        PlayObject.m_UseItems[U_BOOTS].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_CHARM]', 4) then
    begin
      if PlayObject.m_UseItems[U_CHARM].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_CHARM]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_CHARM].wIndex);
        PlayObject.m_UseItems[U_CHARM].wIndex := 0;
        exit;
      end;
    end;
    for I := Low(THumanUseItems) to High(THumanUseItems) do
    begin
      if nItemCount <= 0 then
        exit;
      if PlayObject.m_UseItems[i].wIndex > 0 then
      begin
        sName := UserEngine.GetStdItemName(PlayObject.m_UseItems[i].wIndex);
        if CompareText(sName, sItemName) = 0 then
        begin
          PlayObject.SendDelItems(@PlayObject.m_UseItems[i]);
          PlayObject.m_UseItems[i].wIndex := 0;
          Dec(nItemCount);
        end;
      end;
    end;
  end;

  procedure ChangQuestCheckActionVal(QuestActionInfo: pTQuestActionInfo);
  var
    i: Integer;
  begin
    for i := 1 to 7 do
    begin
      case i of
        1: GetValStringAndInteger(QuestActionInfo.sParam1,
            QuestActionInfo.nParam1);
        2: GetValStringAndInteger(QuestActionInfo.sParam2,
            QuestActionInfo.nParam2);
        3: GetValStringAndInteger(QuestActionInfo.sParam3,
            QuestActionInfo.nParam3);
        4: GetValStringAndInteger(QuestActionInfo.sParam4,
            QuestActionInfo.nParam4);
        5: GetValStringAndInteger(QuestActionInfo.sParam5,
            QuestActionInfo.nParam5);
        6: GetValStringAndInteger(QuestActionInfo.sParam6,
            QuestActionInfo.nParam6);
        7: GetValStringAndInteger(QuestActionInfo.sParam7,
            QuestActionInfo.nParam7);
      end;
    end;
  end;

  function QuestActionProcess(ActionList: TList): Boolean; //0049D660
  resourcestring
    sErrorMsg = 'ActionProcess %d %s %s %s %s %s %s';
  var
    I, II: Integer;
    QuestActionInfo: pTQuestActionInfo;
    n14, n18, n1C, n28, n2C: Integer;
    s18, s1C: string;
    n20X, n24Y, n34, n38, n3C, n40: Integer;
    s4C, s50: string;
    s44, s48: string;
    Envir: TEnvirnoment;
    List58: TList;
    User: TPlayObject;
    boFlag: Boolean;
    sName: string;
  begin
    Result := True;
    n18 := 0;
    n34 := 0;
    n38 := 0;
    n3C := 0;
    n40 := 0;
    for I := 0 to ActionList.Count - 1 do
    begin
      PlayObject := PlayObjectEx;
      QuestActionInfo := ActionList.Items[i];
      //通用三方执行脚本支持
      if QuestActionInfo.TCmdList <> nil then
      begin
        boFlag := False;
        for II := 0 to QuestActionInfo.TCmdList.Count - 1 do
        begin
          sName := QuestActionInfo.TCmdList.Strings[II];
          if CompareText(sName, '$HERO') = 0 then
          begin
            if PlayObject.m_Hero <> nil then
              PlayObject := TPlayObject(PlayObject.m_Hero)
            else
              PlayObject := nil;
          end
          else
          begin
            sName := GetLineVariableText(PlayObject, sName);
            PlayObject := UserEngine.GetPlayObject(sName);
          end;
          {sName:=GetLineVariableText(PlayObject,sName);
          PlayObject:=UserEngine.GetPlayObject(sName); }
          if PlayObject = nil then
          begin
            ScriptListError(PlayObjectEx, QuestActionInfo.TCmdList);
            boFlag := True;
            break;
          end;
        end;
        if boFlag then
          Continue;
      end;
      //070911 增加通用脚本变量支持
      m_QuestActionInfo^ := QuestActionInfo^;
      ChangQuestCheckActionVal(m_QuestActionInfo);
      QuestActionInfo := m_QuestActionInfo;
      try
        case QuestActionInfo.nCmdCode of //
          nSET:
            begin
              n28 := Str_ToInt(QuestActionInfo.sParam1, 0);
              n2C := Str_ToInt(QuestActionInfo.sParam2, 0);
              PlayObject.SetQuestFlagStatus(n28, n2C);
            end;
          nTAKE: TakeItem(QuestActionInfo.sParam1, QuestActionInfo.nParam2);
          //nGIVE: GiveItem(QuestActionInfo.sParam1,QuestActionInfo.nParam2);
          nSC_GIVE: ActionOfGiveItem(PlayObject, QuestActionInfo);
          nTAKEW: TakeWItem(QuestActionInfo.sParam1, QuestActionInfo.nParam2);
          nCLOSE: PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0,
              Integer(Self), 0, 0, '');
          nRESET:
            begin
              for II := 0 to QuestActionInfo.nParam2 - 1 do
              begin
                PlayObject.SetQuestFlagStatus(QuestActionInfo.nParam1 + II, 0);
              end;
            end;
          {nSETOPEN: begin
            n28:=Str_ToInt(QuestActionInfo.sParam1,0);
            n2C:=Str_ToInt(QuestActionInfo.sParam2,0);
            PlayObject.SetQuestUnitOpenStatus(n28,n2C);
          end;
          nSETUNIT: begin
            n28:=Str_ToInt(QuestActionInfo.sParam1,0);
            n2C:=Str_ToInt(QuestActionInfo.sParam2,0);
            PlayObject.SetQuestUnitStatus(n28,n2C);
          end; }
          {nRESETUNIT: begin
            for II := 0 to QuestActionInfo.nParam2 - 1 do begin
              PlayObject.SetQuestUnitStatus(QuestActionInfo.nParam1 + II,0);
            end;
          end;}
          nBREAK: Result := False;
          nTIMERECALL:
            begin
              PlayObject.m_boTimeRecall := True;
              PlayObject.m_sMoveMap := PlayObject.m_sMapName;
              PlayObject.m_nMoveX := PlayObject.m_nCurrX;
              PlayObject.m_nMoveY := PlayObject.m_nCurrY;
              PlayObject.m_dwTimeRecallTick := GetTickCount +
                LongWord(QuestActionInfo.nParam1 * 60 * 1000);
            end;
          nSC_PARAM1:
            begin
              n34 := QuestActionInfo.nParam1;
              s44 := QuestActionInfo.sParam1;
            end;
          nSC_PARAM2:
            begin
              n38 := QuestActionInfo.nParam1;
              s48 := QuestActionInfo.sParam1;
            end;
          nSC_PARAM3:
            begin
              n3C := QuestActionInfo.nParam1;
              s4C := QuestActionInfo.sParam1;
            end;
          nSC_PARAM4:
            begin
              n40 := QuestActionInfo.nParam1;
              s50 := QuestActionInfo.sParam1;
            end;
          nSC_EXEACTION:
            begin
              n40 := QuestActionInfo.nParam1;
              s50 := QuestActionInfo.sParam1;
              ExeAction(PlayObject, QuestActionInfo.sParam1,
                QuestActionInfo.sParam2, QuestActionInfo.sParam3,
                QuestActionInfo.nParam1, QuestActionInfo.nParam2,
                QuestActionInfo.nParam3);
            end;
          nMAPMOVE:
            begin
              PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
              PlayObject.SpaceMove(QuestActionInfo.sParam1,
                QuestActionInfo.nParam2, QuestActionInfo.nParam3, 0);
              //bo11:=True;
            end;
          nSC_Gotonow:
            begin
              PlayObject.SendDefMessage(SM_Gotonow,QuestActionInfo.nParam1,
              QuestActionInfo.nParam2,0,0,'');
            end;
          nSC_ChangeSKILL:
            begin
                PlayObject.ChangeSKILL(QuestActionInfo.nParam1,
                                     QuestActionInfo.nParam2);
             end;
          nSC_MAKEWINENPCMOVE: //酒馆老板娘走动
            begin
            if (m_wAppr=71) and (not PlayObject.m_boNPCMOVE) then
             begin
               SendRefMsg(RM_WALK, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
               PlayObject.m_boNPCMOVE:=True;//防止玩家让NPC重复移动
             end;
             end;
          nSC_GETGOODMAKEWINE:ActionOfGETGOODMAKEWINE(PlayObject, QuestActionInfo);
          nSC_FOUNTAIN:ActionOfFOUNTAIN(PlayObject, QuestActionInfo);
          nSC_SETGUILDFOUNTAIN:ActionOfSETGUILDFOUNTAIN(PlayObject, QuestActionInfo);
          nSC_GIVEGUILDFOUNTAIN:ActionOfGIVEGUILDFOUNTAIN(PlayObject, QuestActionInfo);
          nSC_GIVECASTLEFOUNTAIN:ActionOfGIVECASTLEFOUNTAIN(PlayObject, QuestActionInfo);
          nSC_DECMAKEWINETIME:ActionOfDECMAKEWINETIME(PlayObject, QuestActionInfo);
          nSC_OPENMAKEWINE:ActionOfOPENMAKEWINE(PlayObject, QuestActionInfo);
          nSC_QUERYREFINEITEM:ActionOfQUERYREFINEITEM(PlayObject, QuestActionInfo);
          nSC_WebBrowser:ActionOfOPENWebBrowser(PlayObject, QuestActionInfo);
          nMAP:
            begin
              PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
              PlayObject.MapRandomMove(QuestActionInfo.sParam1, 0);
              //bo11:=True;
            end;
          nTAKECHECKITEM:
            begin
              if UserItem <> nil then
              begin
                PlayObject.QuestTakeCheckItem(UserItem);
              end
              else
              begin
                ScriptActionError(PlayObject, '', QuestActionInfo,
                  sTAKECHECKITEM);
              end;
            end;
          nMONGEN:
            begin
              for II := 0 to QuestActionInfo.nParam2 - 1 do
              begin
                n20X := Random(QuestActionInfo.nParam3 * 2 + 1) + (n38 -
                  QuestActionInfo.nParam3);
                n24Y := Random(QuestActionInfo.nParam3 * 2 + 1) + (n3C -
                  QuestActionInfo.nParam3);
                UserEngine.RegenMonsterByName(s44, n20X, n24Y,
                  QuestActionInfo.sParam1);
              end;
            end;
          nMONCLEAR:
            begin
              List58 := TList.Create;
              UserEngine.GetMapMonster(g_MapManager.FindMap(QuestActionInfo.sParam1), List58);
              for II := 0 to List58.Count - 1 do
              begin
                TBaseObject(List58.Items[II]).m_boNoItem := True;
                TBaseObject(List58.Items[II]).m_WAbil.HP := 0;
              end; // for
              List58.Free;
            end;
          nSC_PERCENT:
            begin
              n14 := GetValNameNo(QuestActionInfo.sParam1);
              if n14 >= 0 then
              begin
                case n14 of //
                  0..99:
                    begin
                      PlayObject.m_nVal[n14] := Trunc(PlayObject.m_nVal[n14] /
                        QuestActionInfo.nParam2 * 100)
                    end;
                  1000..1999:
                    begin
                      g_Config.GlobalVal[n14 - 1000] :=
                        Trunc(g_Config.GlobalVal[n14 - 1000] /
                        QuestActionInfo.nParam2 * 100)
                    end;
                  200..299:
                    begin
                      PlayObject.m_DyVal[n14 - 200] :=
                        Trunc(PlayObject.m_DyVal[n14 - 200] /
                        QuestActionInfo.nParam2 * 100)
                    end;
                  300..399:
                    begin
                      PlayObject.m_nMval[n14 - 300] :=
                        Trunc(PlayObject.m_nMval[n14 - 300] /
                        QuestActionInfo.nParam2 * 100)
                    end;
                  4000..4999:
                    begin
                      g_Config.GlobaDyMval[n14 - 4000] :=
                        Trunc(g_Config.GlobaDyMval[n14 - 4000] /
                        QuestActionInfo.nParam2 * 100)
                    end;
                  900..999:
                    begin
                      PlayObject.m_DyValEx[n14 - 900] :=
                        Trunc(PlayObject.m_DyValEx[n14 - 900] /
                        QuestActionInfo.nParam2 * 100)
                    end;
                else
                  ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MUL);
                end;
              end
              else
              begin
                ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MUL);
              end;
            end;
          nSC_MUL:
            begin
              n14 := GetValNameNo(QuestActionInfo.sParam1);
              if n14 >= 0 then
              begin
                case n14 of //
                  0..99:
                    begin
                      if QuestActionInfo.sParam3 = '' then
                        PlayObject.m_nVal[n14] := PlayObject.m_nVal[n14] *
                          QuestActionInfo.nParam2
                      else
                        PlayObject.m_nVal[n14] := QuestActionInfo.nParam2 *
                          QuestActionInfo.nParam3;
                    end;
                  1000..1999:
                    begin
                      if QuestActionInfo.sParam3 = '' then
                        g_Config.GlobalVal[n14 - 1000] := g_Config.GlobalVal[n14
                          - 1000] * QuestActionInfo.nParam2
                      else
                        g_Config.GlobalVal[n14 - 1000] := QuestActionInfo.nParam2
                          * QuestActionInfo.nParam3;
                    end;
                  200..299:
                    begin
                      if QuestActionInfo.sParam3 = '' then
                        PlayObject.m_DyVal[n14 - 200] := PlayObject.m_DyVal[n14
                          - 200] * QuestActionInfo.nParam2
                      else
                        PlayObject.m_DyVal[n14 - 200] := QuestActionInfo.nParam2
                          * QuestActionInfo.nParam3;
                    end;
                  300..399:
                    begin
                      if QuestActionInfo.sParam3 = '' then
                        PlayObject.m_nMval[n14 - 300] := PlayObject.m_nMval[n14
                          - 300] * QuestActionInfo.nParam2
                      else
                        PlayObject.m_nMval[n14 - 300] := QuestActionInfo.nParam2
                          * QuestActionInfo.nParam3;
                    end;
                  4000..4999:
                    begin
                      if QuestActionInfo.sParam3 = '' then
                        g_Config.GlobaDyMval[n14 - 4000] :=
                          g_Config.GlobaDyMval[n14 - 4000] *
                          QuestActionInfo.nParam2
                      else
                        g_Config.GlobaDyMval[n14 - 4000] :=
                          QuestActionInfo.nParam2 * QuestActionInfo.nParam3;
                    end;
                  900..999:
                    begin
                      if QuestActionInfo.sParam3 = '' then
                        PlayObject.m_DyValEx[n14 - 900] :=
                          PlayObject.m_DyValEx[n14 - 900] *
                          QuestActionInfo.nParam2
                      else
                        PlayObject.m_DyValEx[n14 - 900] :=
                          QuestActionInfo.nParam2 * QuestActionInfo.nParam3;
                    end;
                else
                  ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MUL);
                end;
              end
              else
              begin
                ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MUL);
              end;
            end;
          nSC_DVI:
            begin
              n14 := GetValNameNo(QuestActionInfo.sParam1);
              if n14 >= 0 then
              begin
                case n14 of //
                  0..99:
                    begin
                      if QuestActionInfo.sParam3 = '' then
                        PlayObject.m_nVal[n14] := PlayObject.m_nVal[n14] div
                          QuestActionInfo.nParam2
                      else
                        PlayObject.m_nVal[n14] := QuestActionInfo.nParam2 div
                          QuestActionInfo.nParam3;
                    end;
                  1000..1999:
                    begin
                      if QuestActionInfo.sParam3 = '' then
                        g_Config.GlobalVal[n14 - 1000] := g_Config.GlobalVal[n14
                          - 1000] div QuestActionInfo.nParam2
                      else
                        g_Config.GlobalVal[n14 - 1000] := QuestActionInfo.nParam2
                          div QuestActionInfo.nParam3;
                    end;
                  200..299:
                    begin
                      if QuestActionInfo.sParam3 = '' then
                        PlayObject.m_DyVal[n14 - 200] := PlayObject.m_DyVal[n14
                          - 200] div QuestActionInfo.nParam2
                      else
                        PlayObject.m_DyVal[n14 - 200] := QuestActionInfo.nParam2
                          div QuestActionInfo.nParam3;
                    end;
                  300..399:
                    begin
                      if QuestActionInfo.sParam3 = '' then
                        PlayObject.m_nMval[n14 - 300] := PlayObject.m_nMval[n14
                          - 300] div QuestActionInfo.nParam2
                      else
                        PlayObject.m_nMval[n14 - 300] := QuestActionInfo.nParam2
                          div QuestActionInfo.nParam3;
                    end;
                  4000..4999:
                    begin
                      if QuestActionInfo.sParam3 = '' then
                        g_Config.GlobaDyMval[n14 - 4000] :=
                          g_Config.GlobaDyMval[n14 - 4000] div
                          QuestActionInfo.nParam2
                      else
                        g_Config.GlobaDyMval[n14 - 4000] :=
                          QuestActionInfo.nParam2 div QuestActionInfo.nParam3;
                    end;
                  900..999:
                    begin
                      if QuestActionInfo.sParam3 = '' then
                        PlayObject.m_DyValEx[n14 - 900] :=
                          PlayObject.m_DyValEx[n14 - 900] div
                          QuestActionInfo.nParam2
                      else
                        PlayObject.m_DyValEx[n14 - 900] :=
                          QuestActionInfo.nParam2 div QuestActionInfo.nParam3;
                    end;
                else
                  ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DVI);
                end;
              end
              else
              begin
                ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DVI);
              end;
            end;
          {nSC_DEC:begin
            n14:=GetValNameNo(QuestActionInfo.sParam1);
            if n14 >= 0 then begin
              case n14 of    //
                0..99: begin
                  PlayObject.m_nVal[n14]:=_Max(0,QuestActionInfo.nParam2-QuestActionInfo.nParam3);
                end;
                100..199: begin
                  g_Config.GlobalVal[n14 - 100]:=_Max(0,QuestActionInfo.nParam2-QuestActionInfo.nParam3);
                end;
                200..299: begin
                  PlayObject.m_DyVal[n14 - 200]:=_Max(0,QuestActionInfo.nParam2-QuestActionInfo.nParam3);
                end;
                300..399: begin
                  PlayObject.m_nMval[n14 - 300]:=_Max(0,QuestActionInfo.nParam2-QuestActionInfo.nParam3);
                end;
                400..499: begin
                  g_Config.GlobaDyMval[n14 - 400]:=_Max(0,QuestActionInfo.nParam2-QuestActionInfo.nParam3);
                end;
                else begin
                  ScriptActionError(PlayObject,'',QuestActionInfo,sMOV);
                end;
              end;
            end else begin
              ScriptActionError(PlayObject,'',QuestActionInfo,sMOV);
            end;
          end; }
          nMOV:
            begin
              n14 := GetValNameNo(QuestActionInfo.sParam1);
              if n14 >= 0 then
              begin
                case n14 of //
                  0..99:
                    begin
                      PlayObject.m_nVal[n14] := QuestActionInfo.nParam2;
                    end;
                  1000..1999:
                    begin
                      g_Config.GlobalVal[n14 - 1000] := QuestActionInfo.nParam2;
                    end;
                  200..299:
                    begin
                      PlayObject.m_DyVal[n14 - 200] := QuestActionInfo.nParam2;
                    end;
                  300..399:
                    begin
                      PlayObject.m_nMval[n14 - 300] := QuestActionInfo.nParam2;
                    end;
                  4000..4999:
                    begin
                      g_Config.GlobaDyMval[n14 - 4000] :=
                        QuestActionInfo.nParam2;
                    end;
                  900..999:
                    begin
                      PlayObject.m_DyValEx[n14 - 900] :=
                        QuestActionInfo.nParam2;
                    end;
                  2000..2999:
                    begin
                      g_Config.GlobalStrVal[n14 - 2000] :=
                        QuestActionInfo.sParam2;
                    end;
                  3000..3999:
                    begin
                      g_Config.GlobaDyMStrVal[n14 - 3000] :=
                        QuestActionInfo.sParam2;
                    end;
                  700..799:
                    begin
                      PlayObject.m_StrVal[n14 - 700] := QuestActionInfo.sParam2;
                    end;
                else
                  ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
                end;
              end
              else
              begin
                ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
              end;
            end;
          nINC:
            begin
              n14 := GetValNameNo(QuestActionInfo.sParam1);
              if n14 >= 0 then
              begin
                case n14 of //
                  0..99:
                    begin
                      if QuestActionInfo.nParam2 > 1 then
                      begin
                        Inc(PlayObject.m_nVal[n14], QuestActionInfo.nParam2);
                      end
                      else
                      begin
                        Inc(PlayObject.m_nVal[n14]);
                      end;
                    end;
                  1000..1999:
                    begin
                      if QuestActionInfo.nParam2 > 1 then
                      begin
                        Inc(g_Config.GlobalVal[n14 - 1000],
                          QuestActionInfo.nParam2);
                      end
                      else
                      begin
                        Inc(g_Config.GlobalVal[n14 - 1000]);
                      end;
                    end;
                  200..299:
                    begin
                      if QuestActionInfo.nParam2 > 1 then
                      begin
                        Inc(PlayObject.m_DyVal[n14 - 200],
                          QuestActionInfo.nParam2);
                      end
                      else
                      begin
                        Inc(PlayObject.m_DyVal[n14 - 200]);
                      end;
                    end;
                  300..399:
                    begin
                      if QuestActionInfo.nParam2 > 1 then
                      begin
                        Inc(PlayObject.m_nMval[n14 - 300],
                          QuestActionInfo.nParam2);
                      end
                      else
                      begin
                        Inc(PlayObject.m_nMval[n14 - 300]);
                      end;
                    end;
                  4000..4999:
                    begin
                      if QuestActionInfo.nParam2 > 1 then
                      begin
                        Inc(g_Config.GlobaDyMval[n14 - 4000],
                          QuestActionInfo.nParam2);
                      end
                      else
                      begin
                        Inc(g_Config.GlobaDyMval[n14 - 4000]);
                      end;
                    end;
                  900..999:
                    begin
                      if QuestActionInfo.nParam2 > 1 then
                      begin
                        Inc(PlayObject.m_DyValEx[n14 - 900],
                          QuestActionInfo.nParam2);
                      end
                      else
                      begin
                        Inc(PlayObject.m_DyValEx[n14 - 900]);
                      end;
                    end;
                  2000..2999:
                    begin
                      if QuestActionInfo.sParam2 <> '' then
                        g_Config.GlobalStrVal[n14 - 2000] :=
                          g_Config.GlobalStrVal[n14 - 2000] +
                          QuestActionInfo.sParam2;
                    end;
                  3000..3999:
                    begin
                      if QuestActionInfo.sParam2 <> '' then
                        g_Config.GlobaDyMStrVal[n14 - 3000] :=
                          g_Config.GlobaDyMStrVal[n14 - 3000] +
                          QuestActionInfo.sParam2;
                    end;
                  700..799:
                    begin
                      if QuestActionInfo.sParam2 <> '' then
                        PlayObject.m_StrVal[n14 - 700] := PlayObject.m_StrVal[n14
                          - 700] + QuestActionInfo.sParam2;
                    end;
                else
                  begin
                    ScriptActionError(PlayObject, '', QuestActionInfo, sINC);
                  end;
                end; // case
              end
              else
              begin
                ScriptActionError(PlayObject, '', QuestActionInfo, sINC);
              end;
            end;
          nDEC:
            begin
              n14 := GetValNameNo(QuestActionInfo.sParam1);
              if n14 >= 0 then
              begin
                case n14 of //
                  0..99:
                    begin
                      if QuestActionInfo.nParam2 > 1 then
                      begin
                        Dec(PlayObject.m_nVal[n14], QuestActionInfo.nParam2);
                      end
                      else
                      begin
                        Dec(PlayObject.m_nVal[n14]);
                      end;
                    end;
                  1000..1999:
                    begin
                      if QuestActionInfo.nParam2 > 1 then
                      begin
                        Dec(g_Config.GlobalVal[n14 - 1000],
                          QuestActionInfo.nParam2);
                      end
                      else
                      begin
                        Dec(g_Config.GlobalVal[n14 - 1000]);
                      end;
                    end;
                  200..299:
                    begin
                      if QuestActionInfo.nParam2 > 1 then
                      begin
                        Dec(PlayObject.m_DyVal[n14 - 200],
                          QuestActionInfo.nParam2);
                      end
                      else
                      begin
                        Dec(PlayObject.m_DyVal[n14 - 200]);
                      end;
                    end;
                  300..399:
                    begin
                      if QuestActionInfo.nParam2 > 1 then
                      begin
                        Dec(PlayObject.m_nMval[n14 - 300],
                          QuestActionInfo.nParam2);
                      end
                      else
                      begin
                        Dec(PlayObject.m_nMval[n14 - 300]);
                      end;
                    end;
                  4000..4999:
                    begin
                      if QuestActionInfo.nParam2 > 1 then
                      begin
                        Dec(g_Config.GlobaDyMval[n14 - 4000],
                          QuestActionInfo.nParam2);
                      end
                      else
                      begin
                        Dec(g_Config.GlobaDyMval[n14 - 4000]);
                      end;
                    end;
                  900..999:
                    begin
                      if QuestActionInfo.nParam2 > 1 then
                      begin
                        Dec(PlayObject.m_DyValEx[n14 - 900],
                          QuestActionInfo.nParam2);
                      end
                      else
                      begin
                        Dec(PlayObject.m_DyValEx[n14 - 900]);
                      end;
                    end;
                  2000..2999:
                    begin
                      if QuestActionInfo.sParam2 <> '' then
                        g_Config.GlobalStrVal[n14 - 2000] :=
                          AnsiReplaceText(g_Config.GlobalStrVal[n14 - 2000],
                          QuestActionInfo.sParam2, '')
                    end;
                  3000..3999:
                    begin
                      if QuestActionInfo.sParam2 <> '' then
                        g_Config.GlobaDyMStrVal[n14 - 3000] :=
                          AnsiReplaceText(g_Config.GlobaDyMStrVal[n14 - 3000],
                          QuestActionInfo.sParam2, '')
                    end;
                  700..799:
                    begin
                      if QuestActionInfo.sParam2 <> '' then
                        PlayObject.m_StrVal[n14 - 700] :=
                          AnsiReplaceText(PlayObject.m_StrVal[n14 - 700],
                          QuestActionInfo.sParam2, '')
                    end;
                else
                  begin
                    ScriptActionError(PlayObject, '', QuestActionInfo, sDEC);
                  end;
                end;
              end
              else
              begin
                ScriptActionError(PlayObject, '', QuestActionInfo, sDEC);
              end;
            end;
          nSUM:
            begin
              n18 := 0;
              s18 := '';
              n14 := GetValNameNo(QuestActionInfo.sParam1);
              if n14 >= 0 then
              begin
                case n14 of //
                  0..99:
                    begin
                      n18 := PlayObject.m_nVal[n14];
                    end;
                  1000..1999:
                    begin
                      n18 := g_Config.GlobalVal[n14 - 1000];
                    end;
                  200..299:
                    begin
                      n18 := PlayObject.m_DyVal[n14 - 200];
                    end;
                  300..399:
                    begin
                      n18 := PlayObject.m_nMval[n14 - 300];
                    end;
                  4000..4999:
                    begin
                      n18 := g_Config.GlobaDyMval[n14 - 4000];
                    end;
                  900..999:
                    begin
                      n18 := PlayObject.m_DyValEx[n14 - 900];
                    end;
                  2000..2999:
                    begin
                      s18 := g_Config.GlobalStrVal[n14 - 2000];
                    end;
                  3000..3999:
                    begin
                      s18 := g_Config.GlobaDyMStrVal[n14 - 3000];
                    end;
                  700..799:
                    begin
                      s18 := PlayObject.m_StrVal[n14 - 700];
                    end;
                else
                  begin
                    ScriptActionError(PlayObject, '', QuestActionInfo, sSUM);
                  end;
                end; // case
              end
              else
              begin
                ScriptActionError(PlayObject, '', QuestActionInfo, sSUM);
              end;
              n1C := 0;
              s1C := '';
              n14 := GetValNameNo(QuestActionInfo.sParam2);
              if n14 >= 0 then
              begin
                case n14 of //
                  0..99:
                    begin
                      n1C := PlayObject.m_nVal[n14];
                    end;
                  1000..1999:
                    begin
                      n1C := g_Config.GlobalVal[n14 - 1000];
                    end;
                  200..299:
                    begin
                      n1C := PlayObject.m_DyVal[n14 - 200];
                    end;
                  300..399:
                    begin
                      n1C := PlayObject.m_nMval[n14 - 300];
                    end;
                  4000..4999:
                    begin
                      n1C := g_Config.GlobaDyMval[n14 - 4000];
                    end;
                  900..999:
                    begin
                      n1C := PlayObject.m_DyValEx[n14 - 900];
                    end;
                  2000..2999:
                    begin
                      s1C := g_Config.GlobalStrVal[n14 - 2000];
                    end;
                  3000..3999:
                    begin
                      s1C := g_Config.GlobaDyMStrVal[n14 - 3000];
                    end;
                  700..799:
                    begin
                      s1C := PlayObject.m_StrVal[n14 - 700];
                    end;
                else
                  begin
                    ScriptActionError(PlayObject, '', QuestActionInfo, sSUM);
                  end;
                end;
              end
              else
              begin
                //ScriptActionError(PlayObject,'',QuestActionInfo,sSUM);
              end;
              n14 := GetValNameNo(QuestActionInfo.sParam1);
              if n14 >= 0 then
              begin
                case n14 of //
                  0..99:
                    begin
                      PlayObject.m_nVal[99] := PlayObject.m_nVal[99] + n18 +
                        n1C;
                    end;
                  1000..1999:
                    begin
                      g_Config.GlobalVal[999] := g_Config.GlobalVal[999] + n18 +
                        n1C;
                    end;
                  200..299:
                    begin
                      PlayObject.m_DyVal[99] := PlayObject.m_DyVal[99] + n18 +
                        n1C;
                    end;
                  300..399:
                    begin
                      PlayObject.m_nMval[99] := PlayObject.m_nMval[99] + n18 +
                        n1C;
                    end;
                  4000..4999:
                    begin
                      g_Config.GlobaDyMval[999] := g_Config.GlobaDyMval[999] +
                        n18 + n1C;
                    end;
                  900..999:
                    begin
                      PlayObject.m_DyValEx[99] := PlayObject.m_DyValEx[99] + n18
                        + n1C;
                    end;
                  2000..2999:
                    begin
                      g_Config.GlobalStrVal[999] := g_Config.GlobalStrVal[999] +
                        s18 + s1C;
                    end;
                  3000..3999:
                    begin
                      g_Config.GlobaDyMStrVal[999] :=
                        g_Config.GlobaDyMStrVal[999] + s18 + s1C;
                    end;
                  700..799:
                    begin
                      PlayObject.m_StrVal[99] := PlayObject.m_StrVal[99] + s18 +
                        s1C;
                    end;
                end;
              end;
            end;
          nBREAKTIMERECALL: PlayObject.m_boTimeRecall := False;

          nCHANGEMODE:
            begin
              case QuestActionInfo.nParam1 of
                1: PlayObject.CmdChangeAdminMode('', 10, '',
                    Str_ToInt(QuestActionInfo.sParam2, 0) = 1);
                2: PlayObject.CmdChangeSuperManMode('', 10, '',
                    Str_ToInt(QuestActionInfo.sParam2, 0) = 1);
                3: PlayObject.CmdChangeObMode('', 10, '',
                    Str_ToInt(QuestActionInfo.sParam2, 0) = 1);
              else
                begin
                  ScriptActionError(PlayObject, '', QuestActionInfo,
                    sCHANGEMODE);
                end;
              end;
            end;
          nPKPOINT:
            begin
              if QuestActionInfo.nParam1 = 0 then
              begin
                PlayObject.m_nPkPoint := 0;
              end
              else
              begin
                if QuestActionInfo.nParam1 < 0 then
                begin
                  if (PlayObject.m_nPkPoint + QuestActionInfo.nParam1) >= 0 then
                  begin
                    Inc(PlayObject.m_nPkPoint, QuestActionInfo.nParam1);
                  end
                  else
                    PlayObject.m_nPkPoint := 0;
                end
                else
                begin
                  if (PlayObject.m_nPkPoint + QuestActionInfo.nParam1) > 10000
                    then
                  begin
                    PlayObject.m_nPkPoint := 10000;
                  end
                  else
                  begin
                    Inc(PlayObject.m_nPkPoint, QuestActionInfo.nParam1);
                  end;
                end;
              end;
              PlayObject.RefNameColor();
            end;
          nCHANGEXP:
            begin

            end;
          nSC_RECALLMOB: ActionOfRecallmob(PlayObject, QuestActionInfo);
          {
          nSC_RECALLMOB: begin
            if QuestActionInfo.nParam3 <= 1 then begin
              PlayObject.MakeSlave(QuestActionInfo.sParam1,3,Str_ToInt(QuestActionInfo.sParam2,0),100,10 * 24 * 60 * 60);
            end else begin
              PlayObject.MakeSlave(QuestActionInfo.sParam1,3,Str_ToInt(QuestActionInfo.sParam2,0),100,QuestActionInfo.nParam3 * 60)
            end;
          end;
          }
          nKICK:
            begin
              PlayObject.m_boReconnection := True;
              PlayObject.m_boSoftClose := True;
            end;
          nMOVR:
            begin
              n14 := GetValNameNo(QuestActionInfo.sParam1);
              if (QuestActionInfo.nParam3 < QuestActionInfo.nParam2) then
                n18 := Random(QuestActionInfo.nParam2)
              else
                n18 := Random(QuestActionInfo.nParam3 - QuestActionInfo.nParam2)
                  + QuestActionInfo.nParam2;
              if n14 >= 0 then
              begin
                case n14 of //
                  0..99:
                    begin
                      PlayObject.m_nVal[n14] := n18;
                    end;
                  1000..1999:
                    begin
                      g_Config.GlobalVal[n14 - 1000] := n18;
                    end;
                  200..299:
                    begin
                      PlayObject.m_DyVal[n14 - 200] := n18;
                    end;
                  300..399:
                    begin
                      PlayObject.m_nMval[n14 - 300] := n18;
                    end;
                  4000..4999:
                    begin
                      g_Config.GlobaDyMval[n14 - 4000] := n18;
                    end;
                  900..999:
                    begin
                      PlayObject.m_DyValEx[n14 - 900] := n18;
                    end;
                else
                  begin
                    ScriptActionError(PlayObject, '', QuestActionInfo, sMOVR);
                  end;
                end; // case
              end
              else
              begin
                ScriptActionError(PlayObject, '', QuestActionInfo, sMOVR);
              end;
            end;
          nEXCHANGEMAP:
            begin
              Envir := g_MapManager.FindMap(QuestActionInfo.sParam1);
              if Envir <> nil then
              begin
                List58 := TList.Create;
                UserEngine.GetMapRageHuman(Envir, 0, 0, 1000, List58);
                if List58.Count > 0 then
                begin
                  User := TPlayObject(List58.Items[0]);
                  User.MapRandomMove(Self.m_sMapName, 0);
                end;
                List58.Free;
                PlayObject.MapRandomMove(QuestActionInfo.sParam1, 0);
              end
              else
              begin
                ScriptActionError(PlayObject, '', QuestActionInfo,
                  sEXCHANGEMAP);
              end;

            end;
          nRECALLMAP:
            begin
              Envir := g_MapManager.FindMap(QuestActionInfo.sParam1);
              if Envir <> nil then
              begin
                List58 := TList.Create;
                UserEngine.GetMapRageHuman(Envir, 0, 0, 1000, List58);
                for II := 0 to List58.Count - 1 do
                begin
                  User := TPlayObject(List58.Items[II]);
                  User.MapRandomMove(Self.m_sMapName, 0);
                  if II > 20 then
                    break;
                end;
                List58.Free;
              end
              else
              begin
                ScriptActionError(PlayObject, '', QuestActionInfo, sRECALLMAP);
              end;
            end;
          nADDBATCH: List1C.AddObject(QuestActionInfo.sParam1, TObject(n18));
          nBATCHDELAY: n18 := QuestActionInfo.nParam1 * 1000;
          nBATCHMOVE:
            begin
              for II := 0 to List1C.Count - 1 do
              begin
                PlayObject.SendDelayMsg(Self, RM_10155, 0, 0, 0, 0,
                  List1C.Strings[II], Integer(List1C.Objects[II]) + n20);
                Inc(n20, Integer(List1C.Objects[II]));
              end;
            end;
          nPLAYDICE:
            begin //0049E209
              PlayObject.m_sPlayDiceLabel := QuestActionInfo.sParam2;
              PlayObject.SendMsg(Self,
                RM_PLAYDICE,
                QuestActionInfo.nParam1,
                MakeLong(MakeWord(PlayObject.m_DyVal[0], PlayObject.m_DyVal[1]),
                MakeWord(PlayObject.m_DyVal[2], PlayObject.m_DyVal[3])),
                MakeLong(MakeWord(PlayObject.m_DyVal[4], PlayObject.m_DyVal[5]),
                MakeWord(PlayObject.m_DyVal[6], PlayObject.m_DyVal[7])),
                MakeLong(MakeWord(PlayObject.m_DyVal[8], PlayObject.m_DyVal[9]),
                0),
                QuestActionInfo.sParam2);
              bo11 := True;
            end;
          nADDNAMELIST: AddList(PlayObject.m_sCharName, m_sPath +
              QuestActionInfo.sParam1);
          nDELNAMELIST: DelList(PlayObject.m_sCharName, m_sPath +
              QuestActionInfo.sParam1);
          nADDGUILDLIST: if PlayObject.m_MyGuild <> nil then
              AddList(TGuild(PlayObject.m_MyGuild).sGuildName, m_sPath +
                QuestActionInfo.sParam1);
          nDELGUILDLIST: if PlayObject.m_MyGuild <> nil then
              DelList(TGuild(PlayObject.m_MyGuild).sGuildName, m_sPath +
                QuestActionInfo.sParam1);
          //nSC_LINEMSG,
          nSENDMSG: ActionOfLineMsg(PlayObject, QuestActionInfo);

          nADDACCOUNTLIST: AddList(PlayObject.m_sUserID, m_sPath +
              QuestActionInfo.sParam1);
          nDELACCOUNTLIST: DelList(PlayObject.m_sUserID, m_sPath +
              QuestActionInfo.sParam1);
          nADDIPLIST: AddList(PlayObject.m_sIPaddr, m_sPath +
              QuestActionInfo.sParam1);
          nDELIPLIST: DelList(PlayObject.m_sIPaddr, m_sPath +
              QuestActionInfo.sParam1);
          nGOQUEST: GoToQuest(QuestActionInfo.nParam1);
          nENDQUEST: PlayObject.m_Script := nil;
          nGOTO:
            begin
              if not JmpToLable(QuestActionInfo.sParam1) then
              begin
                //ScriptActionError(PlayObject,'',QuestActionInfo,sGOTO);
                MainOutMessage('[脚本死循环] NPC:' + m_sCharName +
                  ' 位置:' + m_sMapName + '(' + IntToStr(m_nCurrX) + ':' +
                  IntToStr(m_nCurrY) + ')' +
                  ' 命令:' + sGOTO + ' ' + QuestActionInfo.sParam1);
                Result := False;
                exit;
              end;
            end;

          //nSC_HAIRCOLOR:;
          //nSC_WEARCOLOR:;
          nSC_HAIRSTYLE: ActionOfChangeHairStyle(PlayObject, QuestActionInfo);
          {nSC_MONRECALL:;
          nSC_HORSECALL:;
          nSC_HAIRRNDCOL:;
          nSC_KILLHORSE:;
          nSC_RANDSETDAILYQUEST:;}

          //nSC_RECALLGROUPMEMBERS: ActionOfRecallGroupMembers(PlayObject,QuestActionInfo);
          nSC_CLEARNAMELIST: ActionOfClearNameList(PlayObject, QuestActionInfo);
          //nSC_MAPTING:         ActionOfMapTing(PlayObject,QuestActionInfo);
          nSC_CHANGELEVEL: ActionOfChangeLevel(PlayObject, QuestActionInfo);
          nSC_MARRY: ActionOfMarry(PlayObject, QuestActionInfo);
          nSC_MASTER: ActionOfMaster(PlayObject, QuestActionInfo);
          nSC_UNMASTER: ActionOfUnMaster(PlayObject, QuestActionInfo);
          nSC_UNMARRY: ActionOfUnMarry(PlayObject, QuestActionInfo);
          nSC_GETMARRY: ActionOfGetMarry(PlayObject, QuestActionInfo);
          nSC_GETMASTER: ActionOfGetMaster(PlayObject, QuestActionInfo);
          nSC_CLEARSKILL: ActionOfClearSkill(PlayObject, QuestActionInfo);
          nSC_DELNOJOBSKILL: ActionOfDelNoJobSkill(PlayObject, QuestActionInfo);
          nSC_DELSKILL: ActionOfDelSkill(PlayObject, QuestActionInfo);
          nSC_ADDSKILL: ActionOfAddSkill(PlayObject, QuestActionInfo);
          nSC_SKILLLEVEL: ActionOfSkillLevel(PlayObject, QuestActionInfo);
          nSC_CHANGETRANPOINT:ActionOfCHANGETRANPOINT(PlayObject, QuestActionInfo);
          nSC_CHANGEPKPOINT: ActionOfChangePkPoint(PlayObject, QuestActionInfo);
          nSC_CHANGEEXP: ActionOfChangeExp(PlayObject, QuestActionInfo);
          nSC_CHANGEJOB: ActionOfChangeJob(PlayObject, QuestActionInfo);
          nSC_MISSION: ActionOfMission(PlayObject, QuestActionInfo);
          nSC_MOBPLACE: ActionOfMobPlace(PlayObject, QuestActionInfo, n34, n38,
              n3C, n40);
          nSC_SETMEMBERTYPE: ActionOfSetMemberType(PlayObject, QuestActionInfo);
          nSC_SETMEMBERLEVEL: ActionOfSetMemberLevel(PlayObject,
              QuestActionInfo);
          //        nSC_SETMEMBERTYPE:   PlayObject.m_nMemberType:=Str_ToInt(QuestActionInfo.sParam1,0);
          //        nSC_SETMEMBERLEVEL:  PlayObject.m_nMemberType:=Str_ToInt(QuestActionInfo.sParam1,0);
          nSC_GAMEGOLD: ActionOfGameGold(PlayObject, QuestActionInfo);
          nSC_GAMEPOINT: ActionOfGamePoint(PlayObject, QuestActionInfo);
          nSC_AUTOADDGAMEGOLD: ActionOfAutoAddGameGold(PlayObject,
              QuestActionInfo, n34, n38);
          nSC_AUTOSUBGAMEGOLD: ActionOfAutoSubGameGold(PlayObject,
              QuestActionInfo, n34, n38);
          nSC_CHANGENAMECOLOR: ActionOfChangeNameColor(PlayObject,
              QuestActionInfo);
          nSC_CLEARPASSWORD: ActionOfClearPassword(PlayObject, QuestActionInfo);
          nSC_RENEWLEVEL: ActionOfReNewLevel(PlayObject, QuestActionInfo);
          nSC_KILLSLAVE: ActionOfKillSlave(PlayObject, QuestActionInfo);
          nSC_CHANGEGENDER: ActionOfChangeGender(PlayObject, QuestActionInfo);
          nSC_KILLMONEXPRATE: ActionOfKillMonExpRate(PlayObject,
              QuestActionInfo);
          nSC_POWERRATE: ActionOfPowerRate(PlayObject, QuestActionInfo);
          nSC_CHANGEMODE: ActionOfChangeMode(PlayObject, QuestActionInfo);
          nSC_CHANGEPERMISSION: ActionOfChangePerMission(PlayObject,
              QuestActionInfo);
          nSC_KILL: ActionOfKill(PlayObject, QuestActionInfo);
          nSC_KICK: ActionOfKick(PlayObject, QuestActionInfo);
          nSC_BONUSPOINT: ActionOfBonusPoint(PlayObject, QuestActionInfo);
          nSC_RESTRENEWLEVEL: ActionOfRestReNewLevel(PlayObject,
              QuestActionInfo);
          nSC_DELMARRY: ActionOfDelMarry(PlayObject, QuestActionInfo);
          nSC_DELMASTER: ActionOfDelMaster(PlayObject, QuestActionInfo);
          nSC_CREDITPOINT: ActionOfChangeCreditPoint(PlayObject,
              QuestActionInfo);
          nSC_CLEARNEEDITEMS: ActionOfClearNeedItems(PlayObject,
              QuestActionInfo);
          nSC_CLEARMAEKITEMS: ActionOfClearMakeItems(PlayObject,
              QuestActionInfo);
          nSC_SETSENDMSGFLAG: PlayObject.m_boSendMsgFlag := True;
          nSC_UPGRADEITEMS: ActionOfUpgradeItems(PlayObject, QuestActionInfo);
          nSC_UPGRADEITEMSEX: ActionOfUpgradeItemsEx(PlayObject,
              QuestActionInfo);
          nSC_SETITEMSTATE: ActionOfSetItemState(PlayObject, QuestActionInfo);
          nSC_GIVESTATEITEM: ActionOfGiveStateItem(PlayObject, QuestActionInfo);
          nSC_MONGENEX: ActionOfMonGenEx(PlayObject, QuestActionInfo);
          nSC_CLEARMAPMON: ActionOfClearMapMon(PlayObject, QuestActionInfo);
          nSC_SETMAPMODE: ActionOfSetMapMode(PlayObject, QuestActionInfo);
          nSC_PKZONE: ActionOfPkZone(PlayObject, QuestActionInfo);
          nSC_RESTBONUSPOINT: ActionOfRestBonusPoint(PlayObject,
              QuestActionInfo);
          nSC_TAKECASTLEGOLD: ActionOfTakeCastleGold(PlayObject,
              QuestActionInfo);
          nSC_HUMANHP: ActionOfHumanHP(PlayObject, QuestActionInfo);
          nSC_HUMANMP: ActionOfHumanMP(PlayObject, QuestActionInfo);
          nSC_BUILDPOINT: ActionOfGuildBuildPoint(PlayObject, QuestActionInfo);
          nSC_AURAEPOINT: ActionOfGuildAuraePoint(PlayObject, QuestActionInfo);
          nSC_STABILITYPOINT: ActionOfGuildstabilityPoint(PlayObject,
              QuestActionInfo);
          nSC_FLOURISHPOINT: ActionOfGuildflourishPoint(PlayObject,
              QuestActionInfo);
          nSC_OPENMAGICBOX: ActionOfOpenMagicBox(PlayObject, QuestActionInfo);
          nSC_SETRANKLEVELNAME: ActionOfSetRankLevelName(PlayObject,
              QuestActionInfo);
          nSC_GMEXECUTE: ActionOfGmExecute(PlayObject, QuestActionInfo);
          nSC_GUILDCHIEFITEMCOUNT: ActionOfGuildChiefItemCount(PlayObject,
              QuestActionInfo);
          nSC_ADDNAMEDATELIST: ActionOfAddNameDateList(PlayObject,
              QuestActionInfo);
          nSC_DELNAMEDATELIST: ActionOfDelNameDateList(PlayObject,
              QuestActionInfo);
          nSC_MOBFIREBURN: ActionOfMobFireBurn(PlayObject, QuestActionInfo);
          nSC_MESSAGEBOX: ActionOfMessageBox(PlayObject, QuestActionInfo);
          nSC_SETSCRIPTFLAG: ActionOfSetScriptFlag(PlayObject, QuestActionInfo);
          nSC_SETAUTOGETEXP: ActionOfAutoGetExp(PlayObject, QuestActionInfo);
          nSC_VAR: ActionOfVar(PlayObject, QuestActionInfo);
          nSC_LOADVAR: ActionOfLoadVar(PlayObject, QuestActionInfo);
          nSC_SAVEVAR: ActionOfSaveVar(PlayObject, QuestActionInfo);
          nSC_CALCVAR: ActionOfCalcVar(PlayObject, QuestActionInfo);

          nSC_GUILDRECALL: ActionOfGuildRecall(PlayObject, QuestActionInfo);
          nSC_GROUPADDLIST: ActionOfGroupAddList(PlayObject, QuestActionInfo);
          nSC_CLEARLIST: ActionOfClearList(PlayObject, QuestActionInfo);
          nSC_GROUPMOVE: ActionOfGroupRecall(PlayObject, QuestActionInfo);
          nSC_GROUPMAPMOVE: ActionOfGroupMoveMap(PlayObject, QuestActionInfo);
          nSC_CHALLENGMAPMOVE:ActionOfCHALLENGMAPMOVE(PlayObject, QuestActionInfo);
          nSC_GETCHALLENGEBAKITEM:ActionOfGETCHALLENGEBAKITEM(PlayObject, QuestActionInfo);
          nSC_CREATEHERO: ActionOfCreateHero(PlayObject, QuestActionInfo);
          nSC_DELAYCALL: ActionOfDelayCall(PlayObject, QuestActionInfo);
          nSC_CLEARDELAYGOTO: ActionOfClearDelayGoto(PlayObject,
              QuestActionInfo);
          nSC_GAMEDIAMOND: ActionOfGameDiamond(PlayObject, QuestActionInfo);
          nSC_GAMEGIRD: ActionOfGameGird(PlayObject, QuestActionInfo);

          nSC_GUILDMOVE: ActionOfGuildMove(PlayObject, QuestActionInfo);
          nSC_GUILDMAPMOVE: ActionOfGuildMapMove(PlayObject, QuestActionInfo);
          nSC_DELETEHERO: ActionOfDeleteHero(PlayObject, QuestActionInfo);
          nSC_OPENUSERMARKET: PlayObject.SendMsg(PlayObject, CM_SELLOFFITEMLIST,
              0, 0, QuestActionInfo.nParam1, 0, '');
          nSC_OFFLINEPLAY: ActionOfOfflincPlay(PlayObject, QuestActionInfo);
          nSC_GOHOME: PlayObject.EatUseItems(3);
          nSC_TAKEONITEM: ActionOfTakeOnItem(PlayObject, QuestActionInfo);
          nSC_TAKEOFFITEM: ActionOfTakeOffItem(PlayObject, QuestActionInfo);
          nSC_HCALL: ActionOfHCall(PlayObject, QuestActionInfo);
          nSC_ADDTEXTLIST: ActionOfADDTEXTLIST(PlayObject, QuestActionInfo);
          nSC_DELTEXTLIST: ActionOfDELTEXTLIST(PlayObject, QuestActionInfo);
          nSC_USEBONUSPOINT: ActionOfUSEBONUSPOINT(PlayObject, QuestActionInfo);
          nSC_CHANGEHUMABILITY: ActionOfChangeHumAbility(PlayObject,
              QuestActionInfo);
          nSC_THROWITEM: ActionOfThrowItem(PlayObject, QuestActionInfo);
          nSC_CHANGEHEROLEVEL: ActionOfChangeHeroLevel(PlayObject,
              QuestActionInfo);
          nSC_CHANGEHEROJOB: ActionOfChangeHeroJob(PlayObject, QuestActionInfo);
          nSC_CHANGEHEROPKPOINT: ActionOfChangeHeroPKPoint(PlayObject,
              QuestActionInfo);
          nSC_CHANGEHEROEXP: ActionOfChangeHeroExp(PlayObject, QuestActionInfo);
          nSC_CLEARHEROSKILL: ActionOfClearHeroSkill(PlayObject,
              QuestActionInfo);
          nSC_SETONTIMER: ActionOfSetOnTimer(PlayObject, QuestActionInfo);
          nSC_SETOFFTIMER: ActionOfSetOffTimer(PlayObject, QuestActionInfo);
          nSC_ADDUSERDATE: ActionOfAddUserDate(PlayObject, QuestActionInfo);
          nSC_DELUSERDATE: ActionOfDELUserDate(PlayObject, QuestActionInfo);
          nSC_SETRANDOMNO: PlayObject.m_RandomNo := Random(89999) + 10000;
          nSC_CLEARCODELIST: ActionOfClearCodeList(PlayObject, QuestActionInfo);
          nSC_GETRANDOMNAME: ActionOfGetRandomName(PlayObject, QuestActionInfo);
          nSC_SETOFFLINEPLAY:
            begin
              if CompareText(QuestActionInfo.sParam1, 'ON') = 0 then
                PlayObject.m_boAutoOffLine := True
              else
                PlayObject.m_boAutoOffLine := False;
            end;
          nSC_THROUGHHUM: ActionOfThroughHum(PlayObject, QuestActionInfo);
          nSC_KICKOFFLINE: UserEngine.KickAllOffLine;
          nSC_GUILDNOTICEMSG: ActionOfGuildNoticeMsg(PlayObject,
              QuestActionInfo);
          nSC_REPAIRALL: ActionOfRepairAll(PlayObject, QuestActionInfo);
          nSC_STARTTAKEGOLD: ActionOfStartTakeGold(PlayObject, QuestActionInfo);
          nSC_RECALLMOBEX: ActionOfReCallMobEx(PlayObject, QuestActionInfo);
          nSC_MOVEMOBTO: ActionOfMoveMobTo(PlayObject, QuestActionInfo);
          nSC_CLEARITEMMAP: ActionOfClearItemMap(PlayObject, QuestActionInfo);
          nSC_SETICON: ActionOfSetIcon(PlayObject, QuestActionInfo);
          nSC_CHANGEDIPLOID: ActionOfChangeDiploid(PlayObject, QuestActionInfo);
          nSC_SETATTRIBUTE: ;
          nSC_QUERYBAGITEMS: PlayObject.SendMsg(Self, CM_QUERYBAGITEMS, 0, 0, 0,
              0, '');
          nSC_TAGMAPMOVE: ;
          nSC_OPENYBDEAL: ;
          nSC_OPENBOOKS: PlayObject.SendDefMessage(SM_OPENBOOKS,
              QuestActionInfo.nParam1, 0, 0, 0, '');
          nSC_OPENBOXS: ActionOfOpenBoxs(PlayObject, QuestActionInfo);
          nSC_KICKALLPLAY: UserEngine.KickAllOnLine();
          nSC_ADDGUILDMEMBER: ActionOfAddGuildMember(PlayObject,
              QuestActionInfo);
          nSC_DELGUILDMEMBER: ActionOfDelGuildMember(PlayObject,
              QuestActionInfo);
          nSC_GLORYCHANGE: ActionOfGloryChange(PlayObject, QuestActionInfo);
          nSC_ADDATTACKSABUKALL: ActionOfAddAttackSabukAll(PlayObject,
              QuestActionInfo);
          nSC_QUERYYBSELL: ;
          nSC_QUERYYBDEAL: ;
          nSC_TAGMAPINFO: ;
          nSC_RECALLPLAYER: ;
          nSC_SENDTOPMSG: ActionOfSendTopMsg(PlayObject, QuestActionInfo);
          nSC_SENDCENTERMSG: ActionOfSendCenterMsg(PlayObject, QuestActionInfo);
          nSC_SENDEDITTOPMSG: ActionOfSendEditTopMsg(PlayObject,
              QuestActionInfo);
          nSC_CHANGEHEROLOYAL: ActionOfChangeHeroLoyal(PlayObject,
              QuestActionInfo);
          nSC_ADDRANDOMMAPGATE: ActionOfAddRandomMapGate(PlayObject,
              QuestActionInfo);
          nSC_DELRANDOMMAPGATE: ActionOfDelRandomMapGate(PlayObject,
              QuestActionInfo);
          nSC_GETRANDOMMAPGATE: ActionOfGetRandomMapGate(PlayObject,
              QuestActionInfo);
          nSC_SETITEMSLIGHT: ActionOfSetItemsLight(PlayObject, QuestActionInfo);
          nSC_SETOFFLINEFUNC: PlayObject.m_sOffLineFunc :=
            QuestActionInfo.sParam1;
          nSC_OPENPLAYDRINK: ActionOfOpenPlayDrink(PlayObject, QuestActionInfo);
          nSC_PLAYDRINKMSG: ActionOfPlayDrinkMsg(PlayObject, QuestActionInfo);
          nSC_CLOSEDRINK: ActionOfCloseDrink(PlayObject, QuestActionInfo);
          nSC_SAVEHERO: ActionOfSaveHero(PlayObject, QuestActionInfo);
          nSC_GETHERO: ActionOfGetHero(PlayObject, QuestActionInfo);
        end;
      except
        try
          MainOutMessage(Format(sErrorMsg, [QuestActionInfo.nCmdCode,
            QuestActionInfo.sParam1,
              QuestActionInfo.sParam2,
              QuestActionInfo.sParam3,
              QuestActionInfo.sParam4,
              QuestActionInfo.sParam5,
              QuestActionInfo.sParam6]));
        except
          MainOutMessage('[Exception] QuestActionInfo');
        end;
      end;
    end;
  end;

  procedure SendMerChantSayMsg(sMsg: string; boFlag: Boolean); //0049E3E0
  var
    s10, s14: string;
    nC: Integer;
  begin
    s14 := sMsg;
    nC := 0;
    while (True) do
    begin
      if TagCount(s14, '>') < 1 then
        break;
      s14 := ArrestStringEx(s14, '<', '>', s10);
      GetVariableText(PlayObject, sMsg, s10);
      Inc(nC);
      if nC >= 101 then
        break;
    end;
    PlayObject.GetScriptLabel(sMsg);
    if boFlag then
    begin
      PlayObject.SendFirstMsg(Self, RM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName + '/'
        + sMsg);
    end
    else
    begin
      PlayObject.SendMsg(Self, RM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName + '/' +
        sMsg);
    end;
  end;
resourcestring
  sException = '[Exception] TNormNpc::GotoLable %s %s %s %d';
begin //0049E584
  nCheckCode := 0;
  PlayObject := PlayObjectEx;
  if (PlayObject.m_btRaceServer <> RC_PLAYOBJECT) { or PlayObject.m_boHero }
    then
    exit;
  try
    Script := nil;
    List1C := TStringList.Create;
    //  n18:=1000;
    n20 := 0;
    nCheckCode := 1;
    if PlayObject.m_NPC <> Self then
    begin
      nCheckCode := 2;
      PlayObject.m_NPC := nil;
      PlayObject.m_Script := nil;
      FillChar(PlayObject.m_nVal, SizeOf(PlayObject.m_nVal), #0);
    end;
    nCheckCode := 3;
    if CompareText(sLabel, '@main') = 0 then
    begin
      nCheckCode := 4;
      for I := 0 to m_ScriptList.Count - 1 do
      begin
        nCheckCode := 5;
        Script3C := m_ScriptList.Items[i];
        nCheckCode := 6;
        for II := 0 to Script3C.RecordList.Count - 1 do
        begin
          nCheckCode := 7;
          SayingRecord := Script3C.RecordList.Items[II];
          nCheckCode := 8;
          if CompareText(sLabel, SayingRecord.sLabel) = 0 then
          begin
            nCheckCode := 9;
            Script := Script3C;
            PlayObject.m_Script := Script;
            PlayObject.m_NPC := Self;
            break;
          end;
          nCheckCode := 10;
          if Script <> nil then
            break;
        end;
      end;
    end; //0049E6CB
    nCheckCode := 11;
    if (Script = nil) then
    begin
      nCheckCode := 12;
      if (PlayObject.m_Script <> nil) then
      begin
        nCheckCode := 13;
        for I := m_ScriptList.Count - 1 downto 0 do
        begin
          nCheckCode := 14;
          if m_ScriptList.Items[i] = PlayObject.m_Script then
          begin
            nCheckCode := 15;
            Script := m_ScriptList.Items[i];
          end;
        end;
      end; //0049E72F
      nCheckCode := 16;
      if (Script = nil) then
      begin
        nCheckCode := 17;
        for I := m_ScriptList.Count - 1 downto 0 do
        begin
          nCheckCode := 18;
          if CheckQuestStatus(pTScript(m_ScriptList.Items[i])) then
          begin
            nCheckCode := 19;
            Script := m_ScriptList.Items[i];
            PlayObject.m_Script := Script;
            PlayObject.m_NPC := Self;
          end;
        end;
      end;
    end; //0049E79B
    nCheckCode := 20;
    //跳转到指定示签，执行
    if (Script <> nil) then
    begin
      nCheckCode := 21;
      for II := 0 to Script.RecordList.Count - 1 do
      begin
        nCheckCode := 22;
        SayingRecord := Script.RecordList.Items[II];
        nCheckCode := 23;
        if CompareText(sLabel, SayingRecord.sLabel) = 0 then
        begin
          nCheckCode := 24;
          if boExtJmp and not SayingRecord.boExtJmp then
            break;
          nCheckCode := 25;
          sSendMsg := '';
          for III := 0 to SayingRecord.ProcedureList.Count - 1 do
          begin
            nCheckCode := 26;
            SayingProcedure := SayingRecord.ProcedureList.Items[III];
            bo11 := False;
            nCheckCode := 27;
            PlayObject := PlayObjectEx;
            if QuestCheckCondition(SayingProcedure.ConditionList) then
            begin
              nCheckCode := 28;
              sSendMsg := sSendMsg + SayingProcedure.sSayMsg;
              nCheckCode := 29;
              if not QuestActionProcess(SayingProcedure.ActionList) then
                break;
              nCheckCode := 30;
              if bo11 then
                SendMerChantSayMsg(sSendMsg, True);
              nCheckCode := 31;
            end
            else
            begin //0049E865
              nCheckCode := 32;
              sSendMsg := sSendMsg + SayingProcedure.sElseSayMsg;
              nCheckCode := 33;
              if not QuestActionProcess(SayingProcedure.ElseActionList) then
                break;
              nCheckCode := 34;
              if bo11 then
                SendMerChantSayMsg(sSendMsg, True);
              nCheckCode := 35;
            end; //0049E8A2
            PlayObject := PlayObjectEx;
          end; //for III := 0 to SayingRecord.List04.Count - 1 do begin
          if sSendMsg <> '' then
            SendMerChantSayMsg(sSendMsg, False);
          nCheckCode := 36;
          break;
        end; //if CompareText(sLabel,SayingRecord.s00) = 0 then begin
      end; //for II := 0 to XXXInfo.List58.Count - 1 do begin
    end; //if (XXXInfo <> nil) then begin
    nCheckCode := 37;
    List1C.Free;
    nCheckCode := 38;
  except
    if not (ClassNameIs(TMerchant.ClassName)) then
      MainOutMessage(Format(sException, ['NormNpc', PlayObject.m_sCharName,
        sLabel, nCheckCode]))
    else
      MainOutMessage(Format(sException, [TMerchant(Self).m_sScript,
        PlayObject.m_sCharName, sLabel, nCheckCode]));
  end;
end;

procedure TNormNpc.LoadNPCScript; //0049EAF0
var
  s08: string;
begin
  try
    if m_boIsQuest then
    begin
      m_sPath := sNpc_def;
      s08 := m_sCharName + '-' + m_sMapName;
      FrmDB.LoadNpcScript(Self, m_sFilePath, s08);
    end
    else
    begin //0049EB8E
      m_sPath := m_sFilePath;
      FrmDB.LoadNpcSCRIPT(Self, m_sFilePath, m_sCharName);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.GotoLable');
  end;
end;

function TNormNpc.Operate(ProcessMsg: pTProcessMessage): Boolean; //0049AB64
begin
  try
    Result := inherited Operate(ProcessMsg);
  except
    MainOutMessage('[Exception] TNormNpc.Operate');
  end;
end;

function TNormNpc.GetShowName(): string;
var
  n14: Integer;
begin
  try
    Result := m_sCharName;
    n14 := GetValNameNo(m_sCharName);
    case n14 of
      2000..2999:
        begin
          Result := g_Config.GlobalStrVal[n14 - 2000];
          Result := AnsiReplaceText(Result, '/', '\');
        end;
      3000..3999:
        begin
          Result := g_Config.GlobaDyMStrVal[n14 - 3000];
          Result := AnsiReplaceText(Result, '/', '\');
        end;
    end;
    m_OldShowName := Result;
    m_NewShowName := GetAddName(Result, 0);
  except
    MainOutMessage('[Exception] TMerchant.GetShowName');
  end;
end;

procedure TNormNpc.Run; //0049ABCC
begin
  try
    if m_Master2 <> nil then
    begin
      m_Master2 := nil; //不允许召唤为宝宝
      m_AllMaster := nil;
    end;

    inherited;
  except
    MainOutMessage('[Exception] TNormNpc.Run');
  end;
end;

procedure TNormNpc.ScriptActionError(PlayObject: TPlayObject; sErrMsg: string;
  QuestActionInfo: pTQuestActionInfo; sCmd: string);
var
  sMsg: string;
resourcestring
  sOutMessage =
    '[脚本错误] %s 脚本命令:%s NPC名称:%s 地图:%s(%d:%d) 参数1:%s 参数2:%s 参数3:%s 参数4:%s 参数5:%s 参数6:%s 参数7:%s';
begin
  try
    sMsg := format(sOutMessage, [sErrMsg,
      sCmd,
        m_sCharName,
        m_sMapName,
        m_nCurrX,
        m_nCurrY,
        QuestActionInfo.sParam1,
        QuestActionInfo.sParam2,
        QuestActionInfo.sParam3,
        QuestActionInfo.sParam4,
        QuestActionInfo.sParam5,
        QuestActionInfo.sParam6,
        QuestActionInfo.sParam7]);
    {
    sMsg:='脚本命令:' + sCmd +
          ' NPC名称:' + m_sCharName +
          ' 地图:' + m_sMapName +
          ' 座标:' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) +
          ' 参数1:' + QuestActionInfo.sParam1 +
          ' 参数2:' + QuestActionInfo.sParam2 +
          ' 参数3:' + QuestActionInfo.sParam3 +
          ' 参数4:' + QuestActionInfo.sParam4 +
          ' 参数5:' + QuestActionInfo.sParam5 +
          ' 参数6:' + QuestActionInfo.sParam6;
    }
    MainOutMessage(sMsg);
  except
    MainOutMessage('[Exception] TNormNpc.ScriptActionError');
  end;
end;

procedure TNormNpc.ScriptListError(PlayObject: TPlayObject; List: TStringList);
var
  sMsg: string;
  I: Integer;
begin
  try
    sMsg := '[多级脚本使用错误] NPC名称:' + m_sCharName + ' ';
    for i := 0 to List.Count - 1 do
    begin
      sMsg := sMsg + List.Strings[I] + ' ';
    end;
    MainOutMessage(sMsg);
  except
    MainOutMessage('[Exception] TNormNpc.ScriptListError');
  end;
end;

procedure TNormNpc.ScriptConditionError(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; sCmd: string);
var
  sMsg: string;
begin
  try
    sMsg := 'Cmd:' + sCmd +
      ' NPC名称:' + m_sCharName +
      ' 地图:' + m_sMapName +
      ' 座标:' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) +
      ' 参数1:' + QuestConditionInfo.sParam1 +
      ' 参数2:' + QuestConditionInfo.sParam2 +
      ' 参数3:' + QuestConditionInfo.sParam3 +
      ' 参数4:' + QuestConditionInfo.sParam4 +
      ' 参数5:' + QuestConditionInfo.sParam5 +
      ' 参数6:' + QuestConditionInfo.sParam6 +
      ' 参数7:' + QuestConditionInfo.sParam7;
    MainOutMessage('[脚本参数不正确] ' + sMsg);
  except
    MainOutMessage('[Exception] TNormNpc.ScriptConditionError');
  end;
end;

procedure TNormNpc.SendMsgToUser(PlayObject: TPlayObject; sMsg: string);
//0049AD14
begin
  try
    PlayObject.SendMsg(Self, RM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName + '/' +
      sMsg);
  except
    MainOutMessage('[Exception] TNormNpc.SendMsgToUser');
  end;
end;

function TNormNpc.sub_49ADB8(sMsg, sStr, sText: string): string; //0049ADB8
var
  n10: Integer;
  s14, s18: string;
begin
  try
    n10 := Pos(sStr, sMsg);
    if n10 > 0 then
    begin
      s14 := Copy(sMsg, 1, n10 - 1);
      s18 := Copy(sMsg, Length(sStr) + n10, Length(sMsg));
      Result := s14 + sText + s18;
    end
    else
      Result := sMsg;
  except
    MainOutMessage('[Exception] TNormNpc.sub_49ADB8');
  end;
end;

procedure TNormNpc.UserSelect(PlayObject: TPlayObject; sData: string); //0049EC28
var
  sMsg, sLabel: string;
begin
  try

    try
      PlayObject.m_nScriptGotoCount := 0;

      //==============================================
      //处理脚本命令 @back 返回上级标签内容
      if (sData <> '') and (sData[1] = '@') then
      begin
        sMsg := GetValidStr3(sData, sLabel, [#13]);
        if (PlayObject.m_sScriptCurrLable <> sLabel) then
        begin
          if (sLabel <> sBACK) then
          begin
            PlayObject.m_sScriptGoBackLable := PlayObject.m_sScriptCurrLable;
            PlayObject.m_sScriptCurrLable := sLabel;
          end
          else
          begin
            if PlayObject.m_sScriptCurrLable <> '' then
            begin
              PlayObject.m_sScriptCurrLable := '';
            end
            else
            begin
              PlayObject.m_sScriptGoBackLable := '';
            end;
          end;
        end;
      end;
    except
      MainOutMessage('[Exception] TNormNpc.UserSelect');
    end;
    //==============================================
  except
    MainOutMessage('[Exception] TNormNpc.UserSelect');
  end;
end;

procedure TNormNpc.ActionOfChangeNameColor(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nColor: Integer;
begin
  try
    nColor := QuestActionInfo.nParam1;
    if (nColor < 0) or (nColor > 255) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGENAMECOLOR);
      exit;
    end;
    PlayObject.m_btNameColor := nColor;
    PlayObject.RefNameColor();
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangeNameColor');
  end;
end;

procedure TNormNpc.ActionOfClearPassword(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  try
    PlayObject.m_sStoragePwd := '';
    PlayObject.m_boPasswordLocked := False;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfClearPassword');
  end;
end;

procedure TNormNpc.ActionOfAddGuildMember(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Guild: TGuild;
  BaseObject: TPlayObject;
begin
  try
    Guild := g_GuildManager.FindGuild(QuestActionInfo.sParam1);
    BaseObject := UserEngine.GetPlayObjectEx(QuestActionInfo.sParam2);
    if (Guild = nil) or (BaseObject = nil) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDGUILDMEMBER);
      exit;
    end;
    if (BaseObject.m_MyGuild = nil) then
    begin
      Guild.AddMember(BaseObject);
      UserEngine.SendServerGroupMsg(SS_207, nServerIndex, Guild.sGuildName);
      BaseObject.m_MyGuild := Guild;
      BaseObject.m_sGuildRankName := Guild.GetRankName(BaseObject,
        BaseObject.m_nGuildRankNo);
      BaseObject.RefShowName();
      BaseObject.SysMsg('你已加入行会: ' + Guild.sGuildName +
        ' 当前封号为: ' + BaseObject.m_sGuildRankName, c_Green, t_Hint);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfAddGuildMember');
  end;
end;

procedure TNormNpc.ActionOfDelGuildMember(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Guild: TGuild;
  BaseObject: TPlayObject;
begin
  try
    Guild := g_GuildManager.FindGuild(QuestActionInfo.sParam1);
    BaseObject := UserEngine.GetPlayObjectEx(QuestActionInfo.sParam2);
    if (Guild = nil) or (BaseObject = nil) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DELGUILDMEMBER);
      exit;
    end;
    if (not BaseObject.IsGuildMaster) and
      (Guild.IsMember(BaseObject.m_sCharName)) then
    begin
      Guild.DelMember(BaseObject.m_sCharName);
      BaseObject.m_MyGuild := nil;
      BaseObject.RefRankInfo(0, '');
      BaseObject.RefShowName(); //10/31
      UserEngine.SendServerGroupMsg(SS_207, nServerIndex, Guild.sGuildName);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfDelGuildMember');
  end;
end;

procedure TNormNpc.ActionOfOpenBoxs(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  i: Integer;
  sSendMsg: string;
  Idx, Count: Integer;
  boAdd: Boolean;
begin
  try
    if (QuestActionInfo.nParam1 >= BoxsList.Count) then
    begin
      ScriptActionError(PlayObject, '宝箱[' + QuestActionInfo.sParam1 +
        ']配置不存在。', QuestActionInfo, sSC_OPENBOXS);
      exit;
    end;
    sSendMsg := '';
    boAdd := False;
    for I := Low(PlayObject.OpenBoxItem) to High(PlayObject.OpenBoxItem) - 2 do
    begin
      Count := 0;
      while True do
      begin
        if Count > 50 then
          Break;
        Idx := Random(3);
        if Idx = 0 then
          boAdd := True;
        GetBoxsItem(QuestActionInfo.nParam1, Idx, PlayObject.OpenBoxItem[I]);
        if PlayObject.OpenBoxItem[I].S.Name <> '' then
          break;
        Inc(Count);
      end;
      sSendMsg := sSendMsg +
        PlayObject.MakeBoxClientItem(PlayObject.OpenBoxItem[I]) + '/';
    end;
    if boAdd then
      GetBoxsItem(QuestActionInfo.nParam1, Random(3), PlayObject.OpenBoxItem[7])
    else
      GetBoxsItem(QuestActionInfo.nParam1, 0, PlayObject.OpenBoxItem[7]);
    if PlayObject.OpenBoxItem[7].S.Name <> '' then
    begin
      sSendMsg := sSendMsg +
        PlayObject.MakeBoxClientItem(PlayObject.OpenBoxItem[7]) + '/';
      PlayObject.OpenBoxsSet := GetBoxsItem(QuestActionInfo.nParam1, 3,
        PlayObject.OpenBoxItem[8]);
      PlayObject.OpenBoxGetItem := PlayObject.OpenBoxItem[8];
      PlayObject.m_boOpenBox := True;
      sSendMsg := sSendMsg +
        PlayObject.MakeBoxClientItem(PlayObject.OpenBoxItem[8]) + '/';
      //EncodeBuffer(@PlayObject.OpenBoxItem[8],SizeOf(TClientItem)) + '/';

      PlayObject.m_DefMsg := MakeDefaultMsg(SM_OPENARK_ITEM2, 0, 0, 0, 0);
      PlayObject.SendSocket(@PlayObject.m_DefMsg, sSendMsg);
    end
    else
      ScriptActionError(PlayObject, '宝箱[' + QuestActionInfo.sParam1 +
        ']配置不完整！', QuestActionInfo, sSC_OPENBOXS);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfOpenBoxs');
  end;
end;

procedure TNormNpc.ActionOfChangeDiploid(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nCount: Integer;
  cMethod: Char;
begin
  nCount := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (nCount < 0) or (nCount > 200) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEDIPLOID);
    exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        PlayObject.m_btDiploidRate := nCount;
      end;
    '-':
      begin
        if PlayObject.m_btDiploidRate > nCount then
        begin
          Dec(PlayObject.m_btDiploidRate, nCount);
        end
        else
        begin
          PlayObject.m_btDiploidRate := 0;
        end;
      end;
    '+':
      begin
        if (PlayObject.m_btDiploidRate + nCount) > 200 then
        begin
          PlayObject.m_btDiploidRate := 200;
        end
        else
        begin
          Inc(PlayObject.m_btDiploidRate, nCount);
        end;
      end;
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEDIPLOID);
  end;
  try
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangeDiploid');
  end;
end;

procedure TNormNpc.ActionOfSetIcon(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  nIcon: Integer;
  nIconIdx: Integer;
begin
  try
    nIcon := Str_ToInt(QuestActionInfo.sParam1, -1);
    nIconIdx := Str_ToInt(QuestActionInfo.sParam2, -1);
    if (not (nIcon in [0..4])) or (nIconIdx < 0) or (nIconIdx > High(Word)) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETICON);
      exit;
    end;
    if CompareText(QuestActionInfo.sParam3, 'HERO') = 0 then
    begin
      if PlayObject.m_Hero = nil then
        exit;
      PlayObject.m_Hero.m_nIconIdx[nIcon] := Word(nIconIdx);
      PlayObject.m_Hero.RefShowName;
    end
    else
    begin
      PlayObject.m_nIconIdx[nIcon] := Word(nIconIdx);
      PlayObject.RefShowName;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfSetIcon');
  end;
end;

procedure TNormNpc.ActionOfClearItemMap(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  n18, n14, I, nX, nY, nRaad: Integer;
  Envir: TEnvirnoment;
  sItemName: string;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  try
    Envir := g_MapManager.FindMap(QuestActionInfo.sParam1);
    nX := Str_ToInt(QuestActionInfo.sParam2, -1);
    nY := Str_ToInt(QuestActionInfo.sParam3, -1);
    nRaad := Str_ToInt(QuestActionInfo.sParam4, -1);
    sItemName := QuestActionInfo.sParam5;
    if (Envir = nil) or (nX < 0) or (nY < 0) or (nRaad < 0) or (nX >
      Envir.Header.wWidth) or (nY > Envir.Header.wHeight) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARITEMMAP);
      exit;
    end;
    for n18 := nX - nRaad to nX + nRaad do
    begin
      for n14 := nY - nRaad to nY + nRaad do
      begin
        if Envir.GetMapCellInfo(n18, n14, MapCellInfo) and (MapCellInfo.ObjList
          <> nil) then
        begin
          I := 0;
          while (True) do
          begin
            if MapCellInfo.ObjList.Count <= I then
              break;
            OSObject := MapCellInfo.ObjList.Items[I];
            if OSObject <> nil then
            begin
              if OSObject.btType = OS_ITEMOBJECT then
              begin
                if sItemName = '' then
                begin
                  Dispose(pTMapItem(OSObject.CellObj));
                  Dispose(OSObject);
                  MapCellInfo.ObjList.Delete(I);
                  if MapCellInfo.ObjList.Count > 0 then
                    Continue;
                  MapCellInfo.ObjList.Free;
                  MapCellInfo.ObjList := nil;
                  break;
                end
                else
                begin
                  if CompareText(pTMapItem(OSObject.CellObj).Name, sItemName) = 0
                    then
                  begin
                    Dispose(pTMapItem(OSObject.CellObj));
                    Dispose(OSObject);
                    MapCellInfo.ObjList.Delete(I);
                    if MapCellInfo.ObjList.Count > 0 then
                      Continue;
                    MapCellInfo.ObjList.Free;
                    MapCellInfo.ObjList := nil;
                    break;
                  end;
                end;
              end;
            end;
            Inc(I);
          end;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfClearItemMap');
  end;
end;

procedure TNormNpc.ActionOfMoveMobTo(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  oX, oY, nX, nY: Integer;
  oEnvir, nEnvir: TEnvirnoment;
  boAll: Boolean;
  MapCellInfo: pTMapCellinfo;
  I: integer;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  try
    boAll := False;
    oX := Str_ToInt(QuestActionInfo.sParam3, -1);
    oY := Str_ToInt(QuestActionInfo.sParam4, -1);
    nX := Str_ToInt(QuestActionInfo.sParam6, -1);
    nY := Str_ToInt(QuestActionInfo.sParam7, -1);
    oEnvir := g_MapManager.FindMap(QuestActionInfo.sParam2);
    nEnvir := g_MapManager.FindMap(QuestActionInfo.sParam5);
    if (oEnvir = nil) or (nEnvir = nil) or (oX < 0) or (oY < 0) or (nX < 0) or
      (nY < 0) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MoveMobTo);
      exit;
    end;
    if CompareText(QuestActionInfo.sParam1, 'ALL') = 0 then
      boAll := True;
    if oEnvir.GetMapCellInfo(oX, oY, MapCellInfo) and (MapCellInfo.ObjList <>
      nil) then
    begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do
      begin
        OSObject := MapCellInfo.ObjList.Items[i];
        if OSObject.btType = OS_MOVINGOBJECT then
        begin
          BaseObject := TBaseObject(OSObject.CellObj);
          if (BaseObject <> nil) and
            (not BaseObject.m_boGhost) and
            (BaseObject.m_btRaceServer <> RC_PLAYOBJECT) and
            (not BaseObject.m_boDeath) then
          begin
            if boAll then
            begin
              BaseObject.SpaceMove(QuestActionInfo.sParam5, nX, nY, 1);
            end
            else if CompareText(QuestActionInfo.sParam1, BaseObject.m_sCharName)
              = 0 then
            begin
              BaseObject.SpaceMove(QuestActionInfo.sParam5, nX, nY, 1);
              break;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfMoveMobTo');
  end;
end;

procedure TNormNpc.ActionOfReCallMobEx(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  nX, nY: Integer;
  nColor: Byte;
  Mon: TBaseObject;
begin
  try
    nX := Str_ToInt(QuestActionInfo.sParam3, -1);
    nY := Str_ToInt(QuestActionInfo.sParam4, -1);
    nColor := Str_ToInt(QuestActionInfo.sParam2, m_btNameColor);
    if (nX < 0) or (nY < 0) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_RECALLMOBEX);
      exit;
    end;
    Mon := PlayObject.MakeSlaveEx(QuestActionInfo.sParam1, nX, nY, 100, 15 * 24
      * 60 * 60);
    if Mon <> nil then
    begin
      //MainOutMessage(IntToStr(nColor));
      Mon.m_btChangeNameColor := nColor;
      Mon.RefNameColor;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfReCallMobEx');
  end;
end;
//RECALLMOB 怪物名称 等级 叛变时间 变色(0,1) 固定颜色(1 - 7)
//变色为0 时固定颜色才起作用

procedure TNormNpc.ActionOfRecallmob(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  //  boAutoChangeColor:Boolean;
  Mon: TBaseObject;
begin
  try
    if QuestActionInfo.nParam3 <= 1 then
    begin
      Mon := PlayObject.MakeSlave(QuestActionInfo.sParam1, 3,
        Str_ToInt(QuestActionInfo.sParam2, 0), 100, 15 * 24 * 60 * 60);
    end
    else
    begin
      Mon := PlayObject.MakeSlave(QuestActionInfo.sParam1, 3,
        Str_ToInt(QuestActionInfo.sParam2, 0), 100, QuestActionInfo.nParam3 * 60)
    end;
    if Mon <> nil then
    begin
      if (QuestActionInfo.sParam4 <> '') and (QuestActionInfo.sParam4[1] = '1')
        then
      begin
        Mon.m_boAutoChangeColor := True;
      end
      else if QuestActionInfo.nParam5 > 0 then
      begin
        Mon.m_boFixColor := True;
        Mon.m_nFixColorIdx := QuestActionInfo.nParam5 - 1;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfRecallmob');
  end;
end;

procedure TNormNpc.ActionOfReNewLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nReLevel, nLevel: Integer;
  nBounsuPoint: Integer;
begin
  try
    nReLevel := Str_ToInt(QuestActionInfo.sParam1, -1);
    nLevel := Str_ToInt(QuestActionInfo.sParam2, -1);
    nBounsuPoint := Str_ToInt(QuestActionInfo.sParam3, -1);
    if (nReLevel < 0) or (nLevel < 0) or (nBounsuPoint < 0) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_RENEWLEVEL);
      exit;
    end;

    if (PlayObject.m_btReLevel + nReLevel) <= High(Byte) then
    begin
      Inc(PlayObject.m_btReLevel, nReLevel);
      if nLevel > 0 then
        PlayObject.m_Abil.Level := nLevel;
      if g_Config.boReNewLevelClearExp then
        PlayObject.m_Abil.Exp := 0;
      Inc(PlayObject.m_nBonusPoint, nBounsuPoint);
      PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
      PlayObject.HasLevelUp(0);
      PlayObject.RefShowName();
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfReNewLevel');
  end;
end;

procedure TNormNpc.ActionOfChangeGender(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGender: Integer;
begin
  try
    nGender := Str_ToInt(QuestActionInfo.sParam1, -1);
    if not (nGender in [0, 1]) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEGENDER);
      exit;
    end;

    PlayObject.m_btGender := nGender;
    PlayObject.FeatureChanged;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangeGender');
  end;
end;

//杀死宝宝

procedure TNormNpc.ActionOfKillSlave(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  Slave: TBaseObject;
begin
  try
    for I := 0 to PlayObject.m_SlaveList.Count - 1 do
    begin
      Slave := TBaseObject(PlayObject.m_SlaveList.Items[I]);
      if QuestActionInfo.sParam1 = '' then
      begin
        Slave.m_WAbil.HP := 0;
      end
      else
      begin
        if CompareText(Slave.m_sCharName, QuestActionInfo.sParam1) = 0 then
          Slave.m_WAbil.HP := 0;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfKillSlave');
  end;
end;

procedure TNormNpc.ActionOfKillMonExpRate(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate: Integer;
  nTime: Integer;
begin
  try
    nRate := Str_ToInt(QuestActionInfo.sParam1, -1);
    nTime := Str_ToInt(QuestActionInfo.sParam2, -1);
    if (nRate < 0) or (nTime < 0) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_KILLMONEXPRATE);
      exit;
    end;
    PlayObject.m_nKillMonExpRate := nRate;
    //PlayObject.m_dwKillMonExpRateTime:=_MIN(High(Word),nTime);
    PlayObject.m_dwKillMonExpRateTime := LongWord(nTime);
    if PlayObject.m_dwClientTickEx > 20070801 then
      PlayObject.SendRefMsg(RM_SHOWEFFECT, Effect_76, Integer(PlayObject),
        PlayObject.m_nCurrX, PlayObject.m_nCurrY, '');

    if g_Config.boShowScriptActionMsg then
    begin
      PlayObject.SysMsg(format(g_sChangeKillMonExpRateMsg,
        [PlayObject.m_nKillMonExpRate / 100,
        PlayObject.m_dwKillMonExpRateTime]),
          c_Green, t_Hint);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfKillMonExpRate');
  end;
end;

procedure TNormNpc.ActionOfMonGenEx(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sMapName, sMonName: string;
  nMapX, nMapY, nRange, nCount: Integer;
  nRandX, nRandY: Integer;
begin
  try
    sMapName := QuestActionInfo.sParam1;
    nMapX := Str_ToInt(QuestActionInfo.sParam2, -1);
    nMapY := Str_ToInt(QuestActionInfo.sParam3, -1);
    sMonName := QuestActionInfo.sParam4;
    nRange := QuestActionInfo.nParam5;
    nCount := QuestActionInfo.nParam6;
    if (sMapName = '') or (nMapX <= 0) or (nMapY <= 0) or (sMapName = '') or
      (nRange <= 0) or (nCount <= 0) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MONGENEX);
      exit;
    end;
    for I := 0 to nCount - 1 do
    begin
      nRandX := Random(nRange * 2 + 1) + (nMapX - nRange);
      nRandY := Random(nRange * 2 + 1) + (nMapY - nRange);
      if UserEngine.RegenMonsterByName(sMapName, nRandX, nRandY, sMonName) = nil
        then
      begin
        //ScriptActionError(PlayObject,'',QuestActionInfo,sSC_MONGENEX);
        break;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfMonGenEx');
  end;
end;

procedure TNormNpc.ActionOfOpenMagicBox(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Monster: TBaseObject;
  sMonName: string;
  nX, nY: Integer;
begin
  try
    sMonName := QuestActionInfo.sParam1;
    if sMonName = '' then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_OPENMAGICBOX);
      exit;
    end;
    PlayObject.GetFrontPosition(nX, nY);
    Monster := UserEngine.RegenMonsterByName(PlayObject.m_PEnvir.sMapName, nX,
      nY, sMonName);
    if Monster = nil then
    begin
      exit;
    end;
    Monster.Die;

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfOpenMagicBox');
  end;
end;

procedure TNormNpc.ActionOfPkZone(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nX, nY: Integer;
  FireBurnEvent: TFireBurnEvent;
  nMinX, nMaxX, nMinY, nMaxY: Integer;
  nRange, nType, nTime, nPoint: Integer;
begin
  try

    nRange := Str_ToInt(QuestActionInfo.sParam1, -1);
    nType := Str_ToInt(QuestActionInfo.sParam2, -1);
    nTime := Str_ToInt(QuestActionInfo.sParam3, -1);
    nPoint := Str_ToInt(QuestActionInfo.sParam4, -1);
    if (nRange < 0) or (nType < 0) or (nTime < 0) or (nPoint < 0) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_PKZONE);
      exit;
    end;
    {
    nMinX:=PlayObject.m_nCurrX - nRange;
    nMaxX:=PlayObject.m_nCurrX + nRange;
    nMinY:=PlayObject.m_nCurrY - nRange;
    nMaxY:=PlayObject.m_nCurrY + nRange;
    }
    nMinX := m_nCurrX - nRange;
    nMaxX := m_nCurrX + nRange;
    nMinY := m_nCurrY - nRange;
    nMaxY := m_nCurrY + nRange;
    for nX := nMinX to nMaxX do
    begin
      for nY := nMinY to nMaxY do
      begin
        if ((nX < nMaxX) and (nY = nMinY)) or
          ((nY < nMaxY) and (nX = nMinX)) or
          (nX = nMaxX) or (nY = nMaxY) then
        begin
          FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, nType, nTime
            * 1000, nPoint);
          g_EventManager.AddEvent(FireBurnEvent);
        end;
      end;
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfPkZone');
  end;
end;

procedure TNormNpc.ActionOfPowerRate(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate: Integer;
  nTime: Integer;
begin
  try
    nRate := Str_ToInt(QuestActionInfo.sParam1, -1);
    nTime := Str_ToInt(QuestActionInfo.sParam2, -1);
    if (nRate < 0) or (nTime < 0) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_POWERRATE);
      exit;
    end;

    PlayObject.m_nPowerRate := nRate;
    //PlayObject.m_dwPowerRateTime:=_MIN(High(Word),nTime);
    PlayObject.m_dwPowerRateTime := LongWord(nTime);
    if g_Config.boShowScriptActionMsg then
    begin
      PlayObject.SysMsg(format(g_sChangePowerRateMsg, [PlayObject.m_nPowerRate /
        100, PlayObject.m_dwPowerRateTime]), c_Green, t_Hint);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfPowerRate');
  end;
end;

procedure TNormNpc.ActionOfChangeMode(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMode: Integer;
  boOpen: Boolean;
begin
  try
    nMode := QuestActionInfo.nParam1;
    boOpen := Str_ToInt(QuestActionInfo.sParam2, -1) = 1;
    if nMode in [1..3] then
    begin
      case nMode of //
        1:
          begin
            PlayObject.m_boAdminMode := boOpen;
            if PlayObject.m_boAdminMode then
              PlayObject.SysMsg(sGameMasterMode, c_Green, t_Hint)
            else
              PlayObject.SysMsg(sReleaseGameMasterMode, c_Green, t_Hint);
          end;
        2:
          begin
            PlayObject.m_boSuperMan := boOpen;
            if PlayObject.m_boSuperMan then
              PlayObject.SysMsg(sSupermanMode, c_Green, t_Hint)
            else
              PlayObject.SysMsg(sReleaseSupermanMode, c_Green, t_Hint);
          end;
        3:
          begin
            PlayObject.m_boObMode := boOpen;
            if PlayObject.m_boObMode then
              PlayObject.SysMsg(sObserverMode, c_Green, t_Hint)
            else
              PlayObject.SysMsg(g_sReleaseObserverMode, c_Green, t_Hint);
          end;
      end;
    end
    else
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEMODE);
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangeMode');
  end;
end;

procedure TNormNpc.ActionOfChangePerMission(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nPermission: Integer;
begin
  try
    nPermission := Str_ToInt(QuestActionInfo.sParam1, -1);
    if nPermission in [0..10] then
    begin
      PlayObject.m_btPermission := nPermission;
    end
    else
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEPERMISSION);
      exit;
    end;
    if g_Config.boShowScriptActionMsg then
    begin
      PlayObject.SysMsg(format(g_sChangePermissionMsg,
        [PlayObject.m_btPermission]), c_Green, t_Hint);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfChangePerMission');
  end;
end;

//给予置属性装备

procedure TNormNpc.ActionOfGiveStateItem(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sItemName: string;
  UserItem: pTUserItem;
  StdItem: TItem;
  //  I:integer;
begin
  try
    sItemName := QuestActionInfo.sParam1;
    if sItemName = '' then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GiveStateItem);
      exit;
    end;
    if UserEngine.GetStdItemIdx(sItemName) > 0 then
    begin
      if PlayObject.IsEnoughBag then
      begin
        New(UserItem);
        if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
        begin
          PlayObject.SetItemState(UserItem, ITEMSTATE_DROP,
            QuestActionInfo.nParam2);
          PlayObject.SetItemState(UserItem, ITEMSTATE_DEAL,
            QuestActionInfo.nParam3);
          PlayObject.SetItemState(UserItem, ITEMSTATE_STORAGE,
            QuestActionInfo.nParam4);
          PlayObject.SetItemState(UserItem, ITEMSTATE_REPAIR,
            QuestActionInfo.nParam5);
          PlayObject.SetItemState(UserItem, ITEMSTATE_SELL,
            QuestActionInfo.nParam6);
          PlayObject.SetItemState(UserItem, ITEMSTATE_SCATTER,
            QuestActionInfo.nParam7);
          PlayObject.m_ItemList.Add((UserItem));
          PlayObject.SendAddItem(UserItem);
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem.NeedIdentify = 1 then
            AddGameDataLog('9' + #9 +
              PlayObject.m_sMapName + #9 +
              IntToStr(PlayObject.m_nCurrX) + #9 +
              IntToStr(PlayObject.m_nCurrY) + #9 +
              PlayObject.m_sCharName + #9 +
              sItemName + #9 +
              IntToStr(UserItem.MakeIndex) + #9 +
              '1' + #9 +
              m_sCharName);
        end
        else
          Dispose(UserItem);
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGiveStateItem');
  end;
  //QuestActionInfo.
end;

procedure TNormNpc.ActionOfGiveItem(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  UserItem: pTUserItem;
  StdItem: TItem;
  sItemName: string;
  nItemCount: Integer;
begin
  try
    sItemName := QuestActionInfo.sParam1;
    nItemCount := Str_ToInt(QuestActionInfo.sParam2, 1);
    if (sItemName = '') then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GIVE);
      exit;
    end;

    if CompareText(sItemName, sSTRING_GOLDNAME) = 0 then
    begin
      PlayObject.IncGold(nItemCount);
      PlayObject.GoldChanged();
      //0049D2FE
      if g_boGameLogGold then
        AddGameDataLog('9' + #9 +
          PlayObject.m_sMapName + #9 +
          IntToStr(PlayObject.m_nCurrX) + #9 +
          IntToStr(PlayObject.m_nCurrY) + #9 +
          PlayObject.m_sCharName + #9 +
          sSTRING_GOLDNAME + #9 +
          IntToStr(nItemCount) + #9 +
          '1' + #9 +
          m_sCharName);
      exit;
    end;
    //MainOutMessage('sItemName:'+sItemName);
    if UserEngine.GetStdItemIdx(sItemName) > 0 then
    begin
      //    if nItemCount > 50 then nItemCount:=50;//11.22 限制数量大小
      if not (nItemCount in [1..MAXBAGITEM]) then
        nItemCount := 1; //12.28 改上一条
      for I := 0 to nItemCount - 1 do
      begin //nItemCount 为0时出死循环
        if PlayObject.IsEnoughBag then
        begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
          begin
            PlayObject.m_ItemList.Add((UserItem));
            PlayObject.SendAddItem(UserItem);
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            //0049D46B
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('9' + #9 +
                PlayObject.m_sMapName + #9 +
                IntToStr(PlayObject.m_nCurrX) + #9 +
                IntToStr(PlayObject.m_nCurrY) + #9 +
                PlayObject.m_sCharName + #9 +
                sItemName + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                m_sCharName);
          end
          else
            Dispose(UserItem);
        end
        else
        begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
          begin
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            //0049D5A5
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('9' + #9 +
                PlayObject.m_sMapName + #9 +
                IntToStr(PlayObject.m_nCurrX) + #9 +
                IntToStr(PlayObject.m_nCurrY) + #9 +
                PlayObject.m_sCharName + #9 +
                sItemName + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                m_sCharName);
            PlayObject.DropItemDown(UserItem, 3, False, PlayObject, nil);
          end;
          Dispose(UserItem);
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGiveItem');
  end;
end;

procedure TNormNpc.ActionOfGmExecute(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sData: string;
  btOldPermission: Byte;
  sParam1, sParam2, sParam3, sParam4, sParam5, sParam6: string;
begin
  try
    sParam1 := QuestActionInfo.sParam1;
    sParam2 := QuestActionInfo.sParam2;
    sParam3 := QuestActionInfo.sParam3;
    sParam4 := QuestActionInfo.sParam4;
    sParam5 := QuestActionInfo.sParam5;
    sParam6 := QuestActionInfo.sParam6;
    if CompareText(sParam2, 'Self') = 0 then
      sParam2 := PlayObject.m_sCharName;

    sData := format('@%s %s %s %s %s %s', [sParam1,
      sParam2,
        sParam3,
        sParam4,
        sParam5,
        sParam6]);
    btOldPermission := PlayObject.m_btPermission;
    try
      PlayObject.m_btPermission := 10;
      PlayObject.ProcessUserLineMsg(sData);
    finally
      PlayObject.m_btPermission := btOldPermission;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGmExecute');
  end;
end;

procedure TNormNpc.ActionOfGuildAuraePoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nAuraePoint: Integer;
  cMethod: Char;
  Guild: TGuild;
begin
  try
    nAuraePoint := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nAuraePoint < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AURAEPOINT);
      exit;
    end;
    if PlayObject.m_MyGuild = nil then
    begin
      PlayObject.SysMsg(g_sScriptGuildAuraePointNoGuild, c_Red, t_Hint);
      exit;
    end;
    Guild := TGuild(PlayObject.m_MyGuild);

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          Guild.nAurae := nAuraePoint;
        end;
      '-':
        begin
          if Guild.nAurae >= nAuraePoint then
          begin
            Guild.nAurae := Guild.nAurae - nAuraePoint;
          end
          else
          begin
            Guild.nAurae := 0;
          end;
        end;
      '+':
        begin
          if (High(Integer) - Guild.nAurae) >= nAuraePoint then
          begin
            Guild.nAurae := Guild.nAurae + nAuraePoint;
          end
          else
          begin
            Guild.nAurae := High(Integer);
          end;
        end;
    end;
    if g_Config.boShowScriptActionMsg then
    begin
      PlayObject.SysMsg(format(g_sScriptGuildAuraePointMsg, [Guild.nAurae]),
        c_Green, t_Hint);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGuildAuraePoint');
  end;
end;

procedure TNormNpc.ActionOfGuildBuildPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);

var
  nBuildPoint: Integer;
  cMethod: Char;
  Guild: TGuild;
begin
  try
    nBuildPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nBuildPoint < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_BuildPoint);
      exit;
    end;
    if PlayObject.m_MyGuild = nil then
    begin
      PlayObject.SysMsg(g_sScriptGuildBuildPointNoGuild, c_Red, t_Hint);
      exit;
    end;
    Guild := TGuild(PlayObject.m_MyGuild);

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          Guild.nBuildPoint := nBuildPoint;
        end;
      '-':
        begin
          if Guild.nBuildPoint >= nBuildPoint then
          begin
            Guild.nBuildPoint := Guild.nBuildPoint - nBuildPoint;
          end
          else
          begin
            Guild.nBuildPoint := 0;
          end;
        end;
      '+':
        begin
          if (High(Integer) - Guild.nBuildPoint) >= nBuildPoint then
          begin
            Guild.nBuildPoint := Guild.nBuildPoint + nBuildPoint;
          end
          else
          begin
            Guild.nBuildPoint := High(Integer);
          end;
        end;
    end;
    if g_Config.boShowScriptActionMsg then
    begin
      PlayObject.SysMsg(format(g_sScriptGuildBuildPointMsg,
        [Guild.nBuildPoint]), c_Green, t_Hint);
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGuildBuildPoint');
  end;
end;

procedure TNormNpc.ActionOfGuildChiefItemCount(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nItemCount: Integer;
  cMethod: Char;
  Guild: TGuild;
begin
  try
    nItemCount := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nItemCount < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo,
        sSC_GUILDCHIEFITEMCOUNT);
      exit;
    end;
    if PlayObject.m_MyGuild = nil then
    begin
      PlayObject.SysMsg(g_sScriptGuildFlourishPointNoGuild, c_Red, t_Hint);
      exit;
    end;
    Guild := TGuild(PlayObject.m_MyGuild);

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          Guild.nChiefItemCount := nItemCount;
        end;
      '-':
        begin
          if Guild.nChiefItemCount >= nItemCount then
          begin
            Guild.nChiefItemCount := Guild.nChiefItemCount - nItemCount;
          end
          else
          begin
            Guild.nChiefItemCount := 0;
          end;
        end;
      '+':
        begin
          if (High(Integer) - Guild.nChiefItemCount) >= nItemCount then
          begin
            Guild.nChiefItemCount := Guild.nChiefItemCount + nItemCount;
          end
          else
          begin
            Guild.nChiefItemCount := High(Integer);
          end;
        end;
    end;
    if g_Config.boShowScriptActionMsg then
    begin
      PlayObject.SysMsg(format(g_sScriptChiefItemCountMsg,
        [Guild.nChiefItemCount]), c_Green, t_Hint);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGuildChiefItemCount');
  end;
end;

procedure TNormNpc.ActionOfGuildFlourishPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);

var
  nFlourishPoint: Integer;
  cMethod: Char;
  Guild: TGuild;
begin
  try
    nFlourishPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nFlourishPoint < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_FlourishPoint);
      exit;
    end;
    if PlayObject.m_MyGuild = nil then
    begin
      PlayObject.SysMsg(g_sScriptGuildFlourishPointNoGuild, c_Red, t_Hint);
      exit;
    end;
    Guild := TGuild(PlayObject.m_MyGuild);

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          Guild.nFlourishing := nFlourishPoint;
        end;
      '-':
        begin
          if Guild.nFlourishing >= nFlourishPoint then
          begin
            Guild.nFlourishing := Guild.nFlourishing - nFlourishPoint;
          end
          else
          begin
            Guild.nFlourishing := 0;
          end;
        end;
      '+':
        begin
          if (High(Integer) - Guild.nFlourishing) >= nFlourishPoint then
          begin
            Guild.nFlourishing := Guild.nFlourishing + nFlourishPoint;
          end
          else
          begin
            Guild.nFlourishing := High(Integer);
          end;
        end;
    end;
    if g_Config.boShowScriptActionMsg then
    begin
      PlayObject.SysMsg(format(g_sScriptGuildFlourishPointMsg,
        [Guild.nFlourishing]), c_Green, t_Hint);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGuildFlourishPoint');
  end;
end;

procedure TNormNpc.ActionOfGuildstabilityPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);

var
  nStabilityPoint: Integer;
  cMethod: Char;
  Guild: TGuild;
begin
  try
    nStabilityPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nStabilityPoint < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_StabilityPoint);
      exit;
    end;
    if PlayObject.m_MyGuild = nil then
    begin
      PlayObject.SysMsg(g_sScriptGuildStabilityPointNoGuild, c_Red, t_Hint);
      exit;
    end;
    Guild := TGuild(PlayObject.m_MyGuild);

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          Guild.nStability := nStabilityPoint;
        end;
      '-':
        begin
          if Guild.nStability >= nStabilityPoint then
          begin
            Guild.nStability := Guild.nStability - nStabilityPoint;
          end
          else
          begin
            Guild.nStability := 0;
          end;
        end;
      '+':
        begin
          if (High(Integer) - Guild.nStability) >= nStabilityPoint then
          begin
            Guild.nStability := Guild.nStability + nStabilityPoint;
          end
          else
          begin
            Guild.nStability := High(Integer);
          end;
        end;
    end;
    if g_Config.boShowScriptActionMsg then
    begin
      PlayObject.SysMsg(format(g_sScriptGuildStabilityPointMsg,
        [Guild.nStability]), c_Green, t_Hint);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGuildstabilityPoint');
  end;
end;

procedure TNormNpc.ActionOfHumanHP(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nHP: Integer;
  cMethod: Char;
begin
  try
    nHP := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nHP < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HUMANHP);
      exit;
    end;
    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          PlayObject.m_WAbil.HP := nHP;
        end;
      '-':
        begin
          if PlayObject.m_WAbil.HP >= nHP then
          begin
            Dec(PlayObject.m_WAbil.HP, nHP);
          end
          else
          begin
            PlayObject.m_WAbil.HP := 0;
          end;
        end;
      '+':
        begin
          Inc(PlayObject.m_WAbil.HP, nHP);
          if PlayObject.m_WAbil.HP > PlayObject.m_WAbil.MaxHP then
            PlayObject.m_WAbil.HP := PlayObject.m_WAbil.MaxHP;
        end;
    end;
    if g_Config.boShowScriptActionMsg then
    begin
      PlayObject.SysMsg(format(g_sScriptChangeHumanHPMsg,
        [PlayObject.m_WAbil.MaxHP]), c_Green, t_Hint);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfHumanHP');
  end;
end;

procedure TNormNpc.ActionOfHumanMP(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMP: Integer;
  cMethod: Char;
begin
  try
    nMP := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nMP < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HUMANMP);
      exit;
    end;
    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          PlayObject.m_WAbil.MP := nMP;
        end;
      '-':
        begin
          if PlayObject.m_WAbil.MP >= nMP then
          begin
            Dec(PlayObject.m_WAbil.MP, nMP);
          end
          else
          begin
            PlayObject.m_WAbil.MP := 0;
          end;
        end;
      '+':
        begin
          Inc(PlayObject.m_WAbil.MP, nMP);
          if PlayObject.m_WAbil.MP > PlayObject.m_WAbil.MaxMP then
            PlayObject.m_WAbil.MP := PlayObject.m_WAbil.MaxMP;
        end;
    end;
    if g_Config.boShowScriptActionMsg then
    begin
      PlayObject.SysMsg(format(g_sScriptChangeHumanMPMsg,
        [PlayObject.m_WAbil.MaxMP]), c_Green, t_Hint);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfHumanMP');
  end;
end;

procedure TNormNpc.ActionOfKick(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  try
    PlayObject.m_boKickFlag := True;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfKick');
  end;
end;

procedure TNormNpc.ActionOfKill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMode: Integer;
begin
  try
    nMode := Str_ToInt(QuestActionInfo.sParam1, -1);
    if nMode in [0..3] then
    begin
      case nMode of //
        1:
          begin
            PlayObject.m_boNoItem := True;
            PlayObject.Die;
          end;
        2:
          begin
            PlayObject.SetLastHiter(Self);
            PlayObject.Die;
          end;
        3:
          begin
            PlayObject.m_boNoItem := True;
            PlayObject.SetLastHiter(Self);
            PlayObject.Die;
          end;
      else
        begin
          PlayObject.Die;
        end;
      end;
    end
    else
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_KILL);
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfKill');
  end;
end;

procedure TNormNpc.ActionOfBonusPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nBonusPoint: Integer;
  //  nPoint:Integer;
  //  nOldPKLevel:Integer;
  cMethod: Char;
begin
  try
    nBonusPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
    if (nBonusPoint < 0) or (nBonusPoint > 10000) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_BONUSPOINT);
      exit;
    end;

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          FillChar(PlayObject.m_BonusAbil, SizeOf(TNakedAbility), #0);
          PlayObject.HasLevelUp(0);
          PlayObject.m_nBonusPoint := nBonusPoint;
          PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
        end;
      '-':
        begin
          {if PlayObject.m_nBonusPoint > nBonusPoint then Dec(PlayObject.m_nBonusPoint,nBonusPoint)
          else PlayObject.m_nBonusPoint:=0;
          PlayObject.SendMsg(PlayObject,RM_ADJUST_BONUS,0,0,0,0,''); }
        end;
      '+':
        begin
          Inc(PlayObject.m_nBonusPoint, nBonusPoint);
          PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
        end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfBonusPoint');
  end;
end;

procedure TNormNpc.ActionOfDelMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  try
    PlayObject.m_sDearName := '';
    PlayObject.RefShowName;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfDelMarry');
  end;
end;

procedure TNormNpc.ActionOfDelMaster(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  try
    PlayObject.m_sMasterName := '';
    PlayObject.RefShowName;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfDelMaster');
  end;
end;

procedure TNormNpc.ActionOfRestBonusPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nTotleUsePoint: Integer;
begin
  try
    nTotleUsePoint := PlayObject.m_BonusAbil.DC +
      PlayObject.m_BonusAbil.MC +
      PlayObject.m_BonusAbil.SC +
      PlayObject.m_BonusAbil.AC +
      PlayObject.m_BonusAbil.MAC +
      PlayObject.m_BonusAbil.HP +
      PlayObject.m_BonusAbil.MP +
      PlayObject.m_BonusAbil.Hit +
      PlayObject.m_BonusAbil.Speed +
      PlayObject.m_BonusAbil.X2;
    FillChar(PlayObject.m_BonusAbil, SizeOf(TNakedAbility), #0);

    Inc(PlayObject.m_nBonusPoint, nTotleUsePoint);
    PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
    PlayObject.HasLevelUp(0);
    PlayObject.SysMsg('分配点数已复位！！！', c_Red, t_Hint);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfRestBonusPoint');
  end;
end;

procedure TNormNpc.ActionOfRestReNewLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  try
    PlayObject.m_btReLevel := 0;
    PlayObject.HasLevelUp(0);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfRestReNewLevel');
  end;
end;

procedure TNormNpc.ActionOfSetMapMode(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Envir: TEnvirnoment;
  sMapName: string;
  sMapMode, sParam1, sParam2 {,sParam3,sParam4}: string;
begin
  try
    sMapName := QuestActionInfo.sParam1;
    sMapMode := QuestActionInfo.sParam2;
    sParam1 := QuestActionInfo.sParam3;
    sParam2 := QuestActionInfo.sParam4;
    //  sParam3:=QuestActionInfo.sParam5;
    //  sParam4:=QuestActionInfo.sParam6;

    Envir := g_MapManager.FindMap(sMapName);
    if (Envir = nil) or (sMapMode = '') then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETMAPMODE);
      exit;
    end;
    if CompareText(sMapMode, 'SAFE') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boSAFE := True;
      end
      else
      begin
        Envir.Flag.boSAFE := False;
      end;
    end
    else if CompareText(sMapMode, 'DARK') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boDarkness := True;
      end
      else
      begin
        Envir.Flag.boDarkness := False;
      end;
    end
    else if CompareText(sMapMode, 'FIGHT') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boFightZone := True;
      end
      else
      begin
        Envir.Flag.boFightZone := False;
      end;
    end
    else if CompareText(sMapMode, 'FIGHT3') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boFight3Zone := True;
      end
      else
      begin
        Envir.Flag.boFight3Zone := False;
      end;
    end
    else if CompareText(sMapMode, 'DAY') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boDayLight := True;
      end
      else
      begin
        Envir.Flag.boDayLight := False;
      end;
    end
    else if CompareText(sMapMode, 'QUIZ') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boQUIZ := True;
      end
      else
      begin
        Envir.Flag.boQUIZ := False;
      end;
    end
    else if CompareText(sMapMode, 'NORECONNECT') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boNORECONNECT := True;
        Envir.Flag.sNoReconnectMap := sParam1;
      end
      else
      begin
        Envir.Flag.boNORECONNECT := False;
      end;
    end
    else if CompareText(sMapMode, 'MUSIC') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boMUSIC := True;
        Envir.Flag.sMusic := sParam1;
      end
      else
      begin
        Envir.Flag.boMUSIC := False;
      end;
    end
    else if CompareText(sMapMode, 'EXPRATE') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boEXPRATE := True;
        Envir.Flag.nEXPRATE := Str_ToInt(sParam1, -1);
      end
      else
      begin
        Envir.Flag.boEXPRATE := False;
      end;
    end
    else if CompareText(sMapMode, 'PKWINLEVEL') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boPKWINLEVEL := True;
        Envir.Flag.nPKWINLEVEL := Str_ToInt(sParam1, -1);
      end
      else
      begin
        Envir.Flag.boPKWINLEVEL := False;
      end;
    end
    else if CompareText(sMapMode, 'PKWINEXP') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boPKWINEXP := True;
        Envir.Flag.nPKWINEXP := Str_ToInt(sParam1, -1);
      end
      else
      begin
        Envir.Flag.boPKWINEXP := False;
      end;
    end
    else if CompareText(sMapMode, 'PKLOSTLEVEL') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boPKLOSTLEVEL := True;
        Envir.Flag.nPKLOSTLEVEL := Str_ToInt(sParam1, -1);
      end
      else
      begin
        Envir.Flag.boPKLOSTLEVEL := False;
      end;
    end
    else if CompareText(sMapMode, 'PKLOSTEXP') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boPKLOSTEXP := True;
        Envir.Flag.nPKLOSTEXP := Str_ToInt(sParam1, -1);
      end
      else
      begin
        Envir.Flag.boPKLOSTEXP := False;
      end;
    end
    else if CompareText(sMapMode, 'DECHP') = 0 then
    begin
      if (sParam1 <> '') and (sParam2 <> '') then
      begin
        Envir.Flag.boDECHP := True;
        Envir.Flag.nDECHPTIME := Str_ToInt(sParam1, -1);
        Envir.Flag.nDECHPPOINT := Str_ToInt(sParam2, -1);
      end
      else
      begin
        Envir.Flag.boDECHP := False;
      end;
    end
    else if CompareText(sMapMode, 'DECGAMEGOLD') = 0 then
    begin
      if (sParam1 <> '') and (sParam2 <> '') then
      begin
        Envir.Flag.boDECGAMEGOLD := True;
        Envir.Flag.nDECGAMEGOLDTIME := Str_ToInt(sParam1, -1);
        Envir.Flag.nDECGAMEGOLD := Str_ToInt(sParam2, -1);
      end
      else
      begin
        Envir.Flag.boDECGAMEGOLD := False;
      end;
    end
    else if CompareText(sMapMode, 'RUNHUMAN') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boRUNHUMAN := True;
      end
      else
      begin
        Envir.Flag.boRUNHUMAN := False;
      end;
    end
    else if CompareText(sMapMode, 'RUNMON') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boRUNMON := True;
      end
      else
      begin
        Envir.Flag.boRUNMON := False;
      end;
    end
    else if CompareText(sMapMode, 'NEEDHOLE') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boNEEDHOLE := True;
      end
      else
      begin
        Envir.Flag.boNEEDHOLE := False;
      end;
    end
    else if CompareText(sMapMode, 'NORECALL') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boNORECALL := True;
      end
      else
      begin
        Envir.Flag.boNORECALL := False;
      end;
    end
    else if CompareText(sMapMode, 'NOGUILDRECALL') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boNOGUILDRECALL := True;
      end
      else
      begin
        Envir.Flag.boNOGUILDRECALL := False;
      end;
    end
    else if CompareText(sMapMode, 'NODEARRECALL') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boNODEARRECALL := True;
      end
      else
      begin
        Envir.Flag.boNODEARRECALL := False;
      end;
    end
    else if CompareText(sMapMode, 'NOMASTERRECALL') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boNOMASTERRECALL := True;
      end
      else
      begin
        Envir.Flag.boNOMASTERRECALL := False;
      end;
    end
    else if CompareText(sMapMode, 'NORANDOMMOVE') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boNORANDOMMOVE := True;
      end
      else
      begin
        Envir.Flag.boNORANDOMMOVE := False;
      end;
    end
    else if CompareText(sMapMode, 'NODRUG') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boNODRUG := True;
      end
      else
      begin
        Envir.Flag.boNODRUG := False;
      end;
    end
    else if CompareText(sMapMode, 'MINE') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boMINE := True;
      end
      else
      begin
        Envir.Flag.boMINE := False;
      end;
    end
    else if CompareText(sMapMode, 'MINE2') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boMINE2 := True;
      end
      else
      begin
        Envir.Flag.boMINE2 := False;
      end;
    end
    else if CompareText(sMapMode, 'NOTHROWITEM') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boNOTHROWITEM := True;
      end
      else
      begin
        Envir.Flag.boNOTHROWITEM := False;
      end;
    end
    else if CompareText(sMapMode, 'NODROPITEM') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boNODROPITEM := True;
      end
      else
      begin
        Envir.Flag.boNODROPITEM := False;
      end;
    end
    else if CompareText(sMapMode, 'NOPOSITIONMOVE') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boNOPOSITIONMOVE := True;
      end
      else
      begin
        Envir.Flag.boNOPOSITIONMOVE := False;
      end;
    end
    else if CompareText(sMapMode, 'NOHORSE') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boNOHORSE := True;
      end
      else
      begin
        Envir.Flag.boNOHORSE := False;
      end;
    end
    else if CompareText(sMapMode, 'NOCHAT') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.Flag.boNOCHAT := True;
      end
      else
      begin
        Envir.Flag.boNOCHAT := False;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfSetMapMode');
  end;
end;

procedure TNormNpc.ActionOfSetMemberLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nLevel: Integer;
  cMethod: Char;
begin
  try
    nLevel := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nLevel < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETMEMBERLEVEL);
      exit;
    end;
    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          PlayObject.m_nMemberLevel := nLevel;
        end;
      '-':
        begin
          Dec(PlayObject.m_nMemberLevel, nLevel);
          if PlayObject.m_nMemberLevel < 0 then
            PlayObject.m_nMemberLevel := 0;
        end;
      '+':
        begin
          Inc(PlayObject.m_nMemberLevel, nLevel);
          if PlayObject.m_nMemberLevel > 65535 then
            PlayObject.m_nMemberLevel := 65535;
        end;
    end;
    if g_Config.boShowScriptActionMsg then
    begin
      PlayObject.SysMsg(format(g_sChangeMemberLevelMsg,
        [PlayObject.m_nMemberLevel]), c_Green, t_Hint);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfSetMemberLevel');
  end;
end;

procedure TNormNpc.ActionOfSetMemberType(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nType: Integer;
  cMethod: Char;
begin
  try
    nType := Str_ToInt(QuestActionInfo.sParam2, -1);
    if nType < 0 then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETMEMBERTYPE);
      exit;
    end;
    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=':
        begin
          PlayObject.m_nMemberType := nType;
        end;
      '-':
        begin
          Dec(PlayObject.m_nMemberType, nType);
          if PlayObject.m_nMemberType < 0 then
            PlayObject.m_nMemberType := 0;
        end;
      '+':
        begin
          Inc(PlayObject.m_nMemberType, nType);
          if PlayObject.m_nMemberType > 65535 then
            PlayObject.m_nMemberType := 65535;
        end;
    end;
    if g_Config.boShowScriptActionMsg then
    begin
      PlayObject.SysMsg(format(g_sChangeMemberTypeMsg,
        [PlayObject.m_nMemberType]), c_Green, t_Hint);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfSetMemberType');
  end;
end;

{function TNormNpc.ConditionOfCheckGuildList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
Try
  Result:=False;
Except
  MainOutMessage('[Exception] TNormNpc.ConditionOfCheckGuildList');
End;
end;  }

function TNormNpc.ConditionOfCheckRangeMonCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sMapName: string;
  nX, nY, nRange, nCount: Integer;
  cMethod: Char;
  nMapRangeCount: Integer;
  Envir: TEnvirnoment;
  MonList: TList;
  BaseObject: TBaseObject;
  //  X:Integer;
begin
  try
    try
      Result := False;
      //exit;
      sMapName := QuestConditionInfo.sParam1;
      nX := Str_ToInt(QuestConditionInfo.sParam2, -1);
      nY := Str_ToInt(QuestConditionInfo.sParam3, -1);
      nRange := Str_ToInt(QuestConditionInfo.sParam4, -1);
      cMethod := QuestConditionInfo.sParam5[1];
      nCount := Str_ToInt(QuestConditionInfo.sParam6, -1);
      Envir := g_MapManager.FindMap(sMapName);
      if (Envir = nil) or (nX < 0) or (nY < 0) or (nRange < 0) or (nCount < 0)
        then
      begin
        ScriptConditionError(PlayObject, QuestConditionInfo,
          sSC_CHECKRANGEMONCOUNT);
        exit;
      end;
      MonList := TList.Create;
      try
        Envir.GetRangeBaseObject(nX, nY, nRange, True, MonList);
        //  x:=nMapRangeCount ;
        for I := MonList.Count - 1 downto 0 do
        begin
          BaseObject := TBaseObject(MonList.Items[I]);
          if BaseObject.m_btRaceServer in [RC_135, RC_136] then
            Continue;
          if (BaseObject.m_btRaceServer < RC_ANIMAL) or
            (BaseObject.m_btRaceServer = RC_ARCHERGUARD) or (BaseObject.m_Master2
            <> nil) then
            MonList.Delete(I);
        end;
        nMapRangeCount := MonList.Count;
        case cMethod of
          '=': if nMapRangeCount = nCount then
              Result := True;
          '>': if nMapRangeCount > nCount then
              Result := True;
          '<': if nMapRangeCount < nCount then
              Result := True;
        else if nMapRangeCount >= nCount then
          Result := True;
        end;
        //MainOutMessage(Format('%d/%d/%d/%d/%d/%s',[nX,nY,x,nMapRangeCount,nCount,cMethod]));
      finally
        MonList.Free;
      end;
    except
      MainOutMessage('[Exception] TNormNpc.ConditionOfCheckRangeMonCount');
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckRangeMonCount');
  end;
end;

function TNormNpc.ConditionOfCheckReNewLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nLevel < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKLEVELEX);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_btReLevel = nLevel then
          Result := True;
      '>': if PlayObject.m_btReLevel > nLevel then
          Result := True;
      '<': if PlayObject.m_btReLevel < nLevel then
          Result := True;
    else if PlayObject.m_btReLevel >= nLevel then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckReNewLevel');
  end;
end;

function TNormNpc.ConditionOfCheckSlaveLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean; //宝宝等级
var
  I: Integer;
  nLevel: Integer;
  cMethod: Char;
  BaseObject: TBaseObject;
  nSlaveLevel: Integer;
begin
  try
    Result := False;
    nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nLevel < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKLEVELEX);
      exit;
    end;
    nSlaveLevel := -1;
    for I := 0 to PlayObject.m_SlaveList.Count - 1 do
    begin
      BaseObject := TBaseObject(PlayObject.m_SlaveList.Items[I]);
      if BaseObject.m_Abil.Level > nSlaveLevel then
        nSlaveLevel := BaseObject.m_Abil.Level;
    end;
    if nSlaveLevel < 0 then
      exit;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if nSlaveLevel = nLevel then
          Result := True;
      '>': if nSlaveLevel > nLevel then
          Result := True;
      '<': if nSlaveLevel < nLevel then
          Result := True;
    else if nSlaveLevel >= nLevel then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckSlaveLevel');
  end;
end;

function TNormNpc.ConditionOfCheckUseItem(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nWhere: Integer;
  //  UserItem:pTUserItem;
  //  StdItem:pTStdItem;
begin
  try
    Result := False;
    nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
    if (nWhere < 0) or (nWhere > High(THumanUseItems)) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKUSEITEM);
      exit;
    end;
    if PlayObject.m_UseItems[nWhere].wIndex > 0 then
      Result := True;

  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckUseItem');
  end;
end;

function TNormNpc.ConditionOfCheckVar(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sType: string;
  //  VarType        :TVarType;
  sVarName: string;
  sVarValue: string;
  nVarValue: Integer;
  sName: string;
  sMethod: string;
  cMethod: Char;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '变量%s已存在，变量类型:%s';
  sVarTypeError =
    '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  try
    Result := False;
    sType := QuestConditionInfo.sParam1;
    sVarName := QuestConditionInfo.sParam2;
    sMethod := QuestConditionInfo.sParam3;
    nVarValue := Str_ToInt(QuestConditionInfo.sParam4, 0);
    sVarValue := QuestConditionInfo.sParam4;
    boFoundVar := False;
    if (sType = '') or (sVarName = '') or (sMethod = '') then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKVAR);
      exit;
    end;
    cMethod := sMethod[1];
    DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
    if DynamicVarList = nil then
    begin
      ScriptConditionError(PlayObject {,format(sVarTypeError,[sType])},
        QuestConditionInfo, sSC_CHECKVAR);
      exit;
    end;
    for I := 0 to DynamicVarList.Count - 1 do
    begin
      DynamicVar := DynamicVarList.Items[I];
      if CompareText(DynamicVar.sName, sVarName) = 0 then
      begin
        case DynamicVar.VarType of
          vInteger:
            begin
              case cMethod of
                '=': if DynamicVar.nInternet = nVarValue then
                    Result := True;
                '>': if DynamicVar.nInternet > nVarValue then
                    Result := True;
                '<': if DynamicVar.nInternet < nVarValue then
                    Result := True;
              else if DynamicVar.nInternet >= nVarValue then
                Result := True;
              end;
            end;
          vString:
            begin
              case cMethod of
                '=': if (CompareText(DynamicVar.sString, sVarValue) = 0) then
                    Result := True;
              else
                ScriptConditionError(PlayObject, QuestConditionInfo,
                  sSC_CHECKVAR);
              end;
            end;
        end;

        boFoundVar := True;
        break;
      end;
    end;
    if not boFoundVar then
      ScriptConditionError(PlayObject, {format(sVarFound,[sVarName,sType]),}
        QuestConditionInfo, sSC_CHECKVAR);

  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckVar');
  end;
end;

function TNormNpc.ConditionOfHaveMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
    Result := False;
    if PlayObject.m_sMasterName <> '' then
      Result := True;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfHaveMaster');
  end;
end;

function TNormNpc.ConditionOfPoseHaveMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
begin
  try
    Result := False;
    PoseHuman := PlayObject.GetPoseCreate();
    if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then
    begin
      if (TPlayObject(PoseHuman).m_sMasterName <> '') then
        Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfPoseHaveMaster');
  end;
end;

procedure TNormNpc.ActionOfUnMaster(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  //  LoadList:TStringList;
  //  sUnMarryFileName:String;
  sMsg: string;
begin
  try
    if PlayObject.m_sMasterName = '' then
    begin
      GotoLable(PlayObject, '@ExeMasterFail', False);
      exit;
    end;
    PoseHuman := TPlayObject(PlayObject.GetPoseCreate);
    if PoseHuman = nil then
    begin
      GotoLable(PlayObject, '@UnMasterCheckDir', False);
    end;
    if PoseHuman <> nil then
    begin
      if QuestActionInfo.sParam1 = '' then
      begin
        if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then
        begin
          GotoLable(PlayObject, '@UnMasterTypeErr', False);
          exit;
        end;
        if PoseHuman.GetPoseCreate = PlayObject then
        begin
          if (PlayObject.m_sMasterName = PoseHuman.m_sCharName) then
          begin
            if PlayObject.m_boMaster then
            begin
              GotoLable(PlayObject, '@UnIsMaster', False);
              exit;
            end;
            if PlayObject.m_sMasterName <> PoseHuman.m_sCharName then
            begin
              GotoLable(PlayObject, '@UnMasterError', False);
              exit;
            end;

            GotoLable(PlayObject, '@StartUnMaster', False);
            GotoLable(PoseHuman, '@WateUnMaster', False);
            exit;
          end;
        end;
      end;
    end;
    if (CompareText(QuestActionInfo.sParam1, 'REQUESTUNMASTER' {sREQUESTUNMARRY})
      = 0) then
    begin
      if (QuestActionInfo.sParam2 = '') then
      begin
        if PoseHuman <> nil then
        begin
          PlayObject.m_boStartUnMaster := True;
          if PlayObject.m_boStartUnMaster and PoseHuman.m_boStartUnMaster then
          begin
            sMsg := AnsiReplaceText(g_sNPCSayUnMasterOKMsg, '%n', m_sCharName);
            sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.m_sCharName);
            sMsg := AnsiReplaceText(sMsg, '%d', PoseHuman.m_sCharName);
            UserEngine.SendBroadCastMsg(sMsg, t_Say);
            PlayObject.m_sMasterName := '';
            PoseHuman.m_sMasterName := '';
            PlayObject.m_boStartUnMaster := False;
            PoseHuman.m_boStartUnMaster := False;
            PlayObject.RefShowName;
            PoseHuman.RefShowName;
            GotoLable(PlayObject, '@UnMasterEnd', False);
            GotoLable(PoseHuman, '@UnMasterEnd', False);
          end
          else
          begin
            GotoLable(PlayObject, '@WateUnMaster', False);
            GotoLable(PoseHuman, '@RevUnMaster', False);
          end;
        end;
        exit;
      end
      else
      begin
        //强行出师
        if (CompareText(QuestActionInfo.sParam2, 'FORCE') = 0) then
        begin
          sMsg := AnsiReplaceText(g_sNPCSayForceUnMasterMsg, '%n', m_sCharName);
          sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.m_sCharName);
          sMsg := AnsiReplaceText(sMsg, '%d', PlayObject.m_sMasterName);
          UserEngine.SendBroadCastMsg(sMsg, t_Say);

          PoseHuman := UserEngine.GeTPlayObject(PlayObject.m_sMasterName);
          if PoseHuman <> nil then
          begin
            PoseHuman.m_sMasterName := '';
            PoseHuman.RefShowName;
          end
          else
          begin
            g_UnForceMasterList.Lock;
            try
              g_UnForceMasterList.Add(PlayObject.m_sMasterName);
              SaveUnForceMasterList();
            finally
              g_UnForceMasterList.UnLock;
            end;
          end;
          PlayObject.m_sMasterName := '';
          GotoLable(PlayObject, '@UnMasterEnd', False);
          PlayObject.RefShowName;
        end;
        exit;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfUnMaster');
  end;
end;

function TNormNpc.ConditionOfCheckCastleGold(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGold: Integer;
begin
  try
    Result := False;
    nGold := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if (nGold < 0) or (m_Castle = nil) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCASTLEGOLD);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if TUserCastle(m_Castle).m_nTotalGold = nGold then
          Result := True;
      '>': if TUserCastle(m_Castle).m_nTotalGold > nGold then
          Result := True;
      '<': if TUserCastle(m_Castle).m_nTotalGold < nGold then
          Result := True;
    else if TUserCastle(m_Castle).m_nTotalGold >= nGold then
      Result := True;
    end;
    {
    Result:=False;
    nGold:=Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nGold < 0 then begin
      ScriptConditionError(PlayObject,QuestConditionInfo,sSC_CHECKCASTLEGOLD);
      exit;
    end;
    cMethod:=QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if UserCastle.m_nTotalGold = nGold then Result:=True;
      '>': if UserCastle.m_nTotalGold > nGold then Result:=True;
      '<': if UserCastle.m_nTotalGold < nGold then Result:=True;
      else if UserCastle.m_nTotalGold >= nGold then Result:=True;
    end;
    }
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckCastleGold');
  end;
end;

function TNormNpc.ConditionOfCheckContribution(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nContribution: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    nContribution := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nContribution < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKCONTRIBUTION);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_wContribution = nContribution then
          Result := True;
      '>': if PlayObject.m_wContribution > nContribution then
          Result := True;
      '<': if PlayObject.m_wContribution < nContribution then
          Result := True;
    else if PlayObject.m_wContribution >= nContribution then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckContribution');
  end;
end;

function TNormNpc.ConditionOfCheckCreditPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCreditPoint: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    nCreditPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nCreditPoint < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKCREDITPOINT);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_btCreditPoint = nCreditPoint then
          Result := True;
      '>': if PlayObject.m_btCreditPoint > nCreditPoint then
          Result := True;
      '<': if PlayObject.m_btCreditPoint < nCreditPoint then
          Result := True;
    else if PlayObject.m_btCreditPoint >= nCreditPoint then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckCreditPoint');
  end;
end;

procedure TNormNpc.ActionOfClearNeedItems(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  nNeed: Integer;
  UserItem: pTUserItem;
  StdItem: TItem;
begin
  try
    nNeed := Str_ToInt(QuestActionInfo.sParam1, -1);
    if (nNeed < 0) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARNEEDITEMS);
      exit;
    end;
    for I := PlayObject.m_ItemList.Count - 1 downto 0 do
    begin
      UserItem := PlayObject.m_ItemList.Items[I];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (StdItem <> nil) and (StdItem.Need = LongWord(nNeed)) then
      begin
        PlayObject.SendDelItems(UserItem);
        Dispose(UserItem);
        PlayObject.m_ItemList.Delete(I);
      end;
    end;

    for I := PlayObject.m_StorageItemList.Count - 1 downto 0 do
    begin
      UserItem := PlayObject.m_StorageItemList.Items[I];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (StdItem <> nil) and (StdItem.Need = LongWord(nNeed)) then
      begin
        Dispose(UserItem);
        PlayObject.m_StorageItemList.Delete(I);
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfClearNeedItems');
  end;
end;

procedure TNormNpc.ActionOfClearMakeItems(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  nMakeIndex: Integer;
  sItemName: string;
  UserItem: pTUserItem;
  StdItem: TItem;
  boMatchName: Boolean;
begin
  try
    sItemName := QuestActionInfo.sParam1;
    nMakeIndex := QuestActionInfo.nParam2;
    boMatchName := QuestActionInfo.sParam3 = '1';
    if (sItemName = '') or (nMakeIndex <= 0) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARMAKEITEMS);
      exit;
    end;
    for I := PlayObject.m_ItemList.Count - 1 downto 0 do
    begin
      UserItem := PlayObject.m_ItemList.Items[I];
      if UserItem.MakeIndex <> nMakeIndex then
        Continue;
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if not boMatchName or ((StdItem <> nil) and (CompareText(StdItem.Name,
        sItemName) = 0)) then
      begin
        PlayObject.SendDelItems(UserItem);
        Dispose(UserItem);
        PlayObject.m_ItemList.Delete(I);
      end;
    end;

    for I := PlayObject.m_StorageItemList.Count - 1 downto 0 do
    begin
      //UserItem:=PlayObject.m_ItemList.Items[I];
      UserItem := PlayObject.m_StorageItemList.Items[I]; //Jason 0714修正
      if UserItem.MakeIndex <> nMakeIndex then
        Continue;
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if not boMatchName or ((StdItem <> nil) and (CompareText(StdItem.Name,
        sItemName) = 0)) then
      begin
        Dispose(UserItem);
        PlayObject.m_StorageItemList.Delete(I);
      end;
    end;

    for I := Low(PlayObject.m_UseItems) to High(PlayObject.m_UseItems) do
    begin
      UserItem := @PlayObject.m_UseItems[I];
      if UserItem.MakeIndex <> nMakeIndex then
        Continue;
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if not boMatchName or ((StdItem <> nil) and (CompareText(StdItem.Name,
        sItemName) = 0)) then
      begin
        UserItem.wIndex := 0;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfClearMakeItems');
  end;
end;

procedure TNormNpc.SendCustemMsg(PlayObject: TPlayObject; sMsg: string);
begin
  try
    if not g_Config.boSendCustemMsg then
    begin
      PlayObject.SysMsg(g_sSendCustMsgCanNotUseNowMsg, c_Red, t_Hint);
      exit;
    end;
    if PlayObject.m_boSendMsgFlag then
    begin
      PlayObject.m_boSendMsgFlag := False;
      UserEngine.SendBroadCastMsg(PlayObject.m_sCharName + ': ' + sMsg, t_Cust);
    end
    else
    begin

    end;
  except
    MainOutMessage('[Exception] TNormNpc.SendCustemMsg');
  end;
end;

function TNormNpc.ConditionOfCheckOfGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
    Result := False;
    if QuestConditionInfo.sParam1 = '' then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKOFGUILD);
      exit;
    end;
    if (PlayObject.m_MyGuild <> nil) then
    begin
      if CompareText(TGuild(PlayObject.m_MyGuild).sGuildName,
        QuestConditionInfo.sParam1) = 0 then
      begin
        Result := True;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckOfGuild');
  end;
end;

function TNormNpc.ConditionOfCheckOnlineLongMin(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nOnlineMin: Integer;
  nOnlineTime: Integer;
begin
  try
    Result := False;
    nOnlineMin := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nOnlineMin < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ONLINELONGMIN);
      exit;
    end;
    nOnlineTime := (GetTickCount - PlayObject.m_dwLogonTick) div 60000;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if nOnlineTime = nOnlineMin then
          Result := True;
      '>': if nOnlineTime > nOnlineMin then
          Result := True;
      '<': if nOnlineTime < nOnlineMin then
          Result := True;
    else if nOnlineTime >= nOnlineMin then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckOnlineLongMin');
  end;
end;

function TNormNpc.ConditionOfCheckPasswordErrorCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nErrorCount: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    nErrorCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if nErrorCount < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_PASSWORDERRORCOUNT);
      exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if PlayObject.m_btPwdFailCount = nErrorCount then
          Result := True;
      '>': if PlayObject.m_btPwdFailCount > nErrorCount then
          Result := True;
      '<': if PlayObject.m_btPwdFailCount < nErrorCount then
          Result := True;
    else if PlayObject.m_btPwdFailCount >= nErrorCount then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckPasswordErrorCount');
  end;
end;

function TNormNpc.ConditionOfIsLockPassword(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
    Result := PlayObject.m_boPasswordLocked;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfIsLockPassword');
  end;
end;

function TNormNpc.ConditionOfIsLockStorage(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
    Result := not PlayObject.m_boCanGetBackItem;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfIsLockStorage');
  end;
end;

function TNormNpc.ConditionOfCheckPayMent(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nPayMent: Integer;
begin
  try
    Result := False;
    nPayMent := Str_ToInt(QuestConditionInfo.sParam1, -1);
    if nPayMent < 1 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKPAYMENT);
      exit;
    end;

    if PlayObject.m_nPayMent = nPayMent then
      Result := True;

  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckPayMent');
  end;
end;

function TNormNpc.ConditionOfCheckSlaveName(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean; //宝宝名称
var
  I: Integer;
  sSlaveName: string;
  BaseObject: TBaseObject;
begin
  try
    Result := False;
    sSlaveName := QuestConditionInfo.sParam1;
    if sSlaveName = '' then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSLAVENAME);
      exit;
    end;

    for I := 0 to PlayObject.m_SlaveList.Count - 1 do
    begin
      BaseObject := TBaseObject(PlayObject.m_SlaveList.Items[I]);
      if CompareText(sSlaveName, BaseObject.m_sCharName) = 0 then
      begin
        Result := True;
        break;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckSlaveName');
  end;
end;

procedure TNormNpc.ActionOfUpgradeItems(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate, nWhere, nValType, nPoint, nAddPoint: Integer;
  UserItem: pTUserItem;
  StdItem: TItem;
begin
  try
    nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
    nRate := Str_ToInt(QuestActionInfo.sParam2, -1);
    nPoint := Str_ToInt(QuestActionInfo.sParam3, -1);
    if (nWhere < 0) or (nWhere > High(THumanUseItems)) or (nRate < 0) or (nPoint
      < 0) or (nPoint > 255) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_UPGRADEITEMS);
      exit;
    end;
    UserItem := @PlayObject.m_UseItems[nWhere];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (UserItem.wIndex <= 0) or (StdItem = nil) then
    begin
      PlayObject.SysMsg('你身上没有戴指定物品！！！', c_Red,
        t_Hint);
      exit;
    end;
    nRate := Random(nRate);
    nPoint := Random(nPoint);
    nValType := Random(14);
    if nRate <> 0 then
    begin
      PlayObject.SysMsg('装备升级失败！！！', c_Red, t_Hint);
      exit;
    end;
    if nValType = 14 then
    begin
      nAddPoint := (nPoint * 1000);
      if UserItem.DuraMax + nAddPoint > High(Word) then
      begin
        nAddPoint := High(Word) - UserItem.DuraMax;
      end;

      UserItem.DuraMax := UserItem.DuraMax + nAddPoint;
    end
    else
    begin
      nAddPoint := nPoint;
      if UserItem.btValue[nValType] + nAddPoint > High(Byte) then
      begin
        nAddPoint := High(Byte) - UserItem.btValue[nValType];
      end;

      UserItem.btValue[nValType] := UserItem.btValue[nValType] + nAddPoint;
    end;
    PlayObject.SendUpdateItem(UserItem);
    PlayObject.SysMsg('装备升级成功', c_Green, t_Hint);
    PlayObject.SysMsg(StdItem.Name + ': ' +
      IntToStr(UserItem.Dura) + '/' +
      IntToStr(UserItem.DuraMax) + '/' +
      IntToStr(UserItem.btValue[0]) + '/' +
      IntToStr(UserItem.btValue[1]) + '/' +
      IntToStr(UserItem.btValue[2]) + '/' +

      IntToStr(UserItem.btValue[3]) + '/' +
      IntToStr(UserItem.btValue[4]) + '/' +
      IntToStr(UserItem.btValue[5]) + '/' +
      IntToStr(UserItem.btValue[6]) + '/' +
      IntToStr(UserItem.btValue[7]) + '/' +
      IntToStr(UserItem.btValue[8]) + '/' +
      IntToStr(UserItem.btValue[9]) + '/' +
      IntToStr(UserItem.btValue[10]) + '/' +
      IntToStr(UserItem.btValue[11]) + '/' +
      IntToStr(UserItem.btValue[12]) + '/' +
      IntToStr(UserItem.btValue[13])
      , c_Blue, t_Hint);

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfUpgradeItems');
  end;
end;

//检查装备属性

function TNormNpc.ConditionOfCheckItemState(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nWhere, nValType: Integer;
  UserItem: pTUserItem;
  StdItem: TItem;
begin
  try
    Result := False;
    nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
    nValType := Str_ToInt(QuestConditionInfo.sParam2, -1);
    if (not (nWhere in [0..13])) or (not (nValType in [0..5])) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMSTATE);
      exit;
    end;
    UserItem := @PlayObject.m_UseItems[nWhere];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (UserItem.wIndex <= 0) or (StdItem = nil) then
      exit;
    Result := PlayObject.CheckItemState(UserItem, nValType, False);
    //if ((128 shr nValType) and (UserItem.btValue[15])) <> 0 then Result:=True;
  except
    MainOutmessage('[Exception] TNormNpc.ConditionOfCheckItemState');
  end;
end;

//判断是否开启行会泉水仓库
function TNormNpc.ConditionOfCHECKGUILDFOUNTAIN(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
 Result := TGuild(PlayObject.m_MyGuild).bGuildFountainOpen;
end;

//判断是否在酿哪种酒
function TNormNpc.ConditionOfISONMAKEWINE(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
 Result:=False;

if QuestConditionInfo.nParam1=0 then
begin
  if PlayObject.m_boISONMAKEWINE<>0 then
    Result:=True;
   exit;
end;

if PlayObject.m_boISONMAKEWINE=0 then  Exit;

if PlayObject.m_boISONMAKEWINE=QuestConditionInfo.nParam1 then
  Result:=True;
end;

function  TNormNpc.ConditionOfKILLBYHUM(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
   Result:=PlayObject.m_boKILLBYHUM;
  except
      MainOutmessage('[Exception] TNormNpc.ConditionOfKILLBYHUM');
  end;
end;

function TNormNpc.ConditionOfKILLBYMON(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  try
   Result:=not PlayObject.m_boKILLBYHUM;
  except
      MainOutmessage('[Exception] TNormNpc.ConditionOfKILLBYMON');
  end;
end;

//检测人物醉酒度
function TNormNpc.ConditionOfCHECKDRUNKRATE(PlayObject: TPlayObject;
   QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nDRUNKRATE: Integer;
  cMethod: Char;
begin
  try
    Result:=False;
    if (QuestConditionInfo.sParam1<>'') and (QuestConditionInfo.nParam2>=0) and (QuestConditionInfo.nParam2<=100)  then
    begin
        nDRUNKRATE:=0;
        if (PlayObject.m_WineRec.WineValue>0) and (PlayObject.m_WineRec.Alcoho>0) then
          nDRUNKRATE:=Round(PlayObject.m_WineRec.Alcoho/ PlayObject.m_WineRec.WineValue*100)
        else
          nDRUNKRATE:=0;
        cMethod := QuestConditionInfo.sParam1[1];
        case cMethod of
          '=': if nDRUNKRATE = QuestConditionInfo.nParam2 then
              Result := True;
          '>': if nDRUNKRATE > QuestConditionInfo.nParam2 then
              Result := True;
          '<': if nDRUNKRATE < QuestConditionInfo.nParam2 then
              Result := True;
        else if nDRUNKRATE >= QuestConditionInfo.nParam2 then
          Result := True;
        end;
    end;
  except
      MainOutmessage('[Exception] TNormNpc.ConditionOfCHECKDRUNKRATE');
  end;
end;

procedure TNormNpc.ActionOfOpenPlayDrink(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Idx: Integer;
begin
  Idx := Str_ToInt(QuestActionInfo.sParam1, -1);
  if (Idx < 0) or (idx > 2) or (QuestActionInfo.sParam2 = '') then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_OPENPLAYDRINK);
    exit;
  end;
  if QuestActionInfo.sParam3 = 'DRINK' then
    PlayObject.SendDefMessage(SM_PLAYDRINK, Integer(Self), 4, Idx, 0,
      QuestActionInfo.sParam2)
  else
    PlayObject.SendDefMessage(SM_PLAYDRINK, Integer(Self), 0, Idx, 0,
      QuestActionInfo.sParam2);
end;

procedure TNormNpc.ActionOfPlayDrinkMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Idx: Integer;
begin
  Idx := Str_ToInt(QuestActionInfo.sParam1, -1);
  if (Idx < 1) or (idx > 2) or (QuestActionInfo.sParam2 = '') then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_PLAYDRINKMSG);
    exit;
  end;
  PlayObject.GetScriptLabel(QuestActionInfo.sParam2);
  PlayObject.SendDefMessage(SM_PLAYDRINK, Integer(Self), 1, Idx, 0,
    QuestActionInfo.sParam2);
end;

procedure TNormNpc.ActionOfCloseDrink(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
begin
  PlayObject.SendDefMessage(SM_PLAYDRINK, 0, 2, 0, 0, '');
end;

procedure TNormNpc.ActionOfSaveHero(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
begin
  if PlayObject.m_HeroName = '' then
  begin
    GotoLable(PlayObject, '~PlayDrink_NotHero', False);
    exit;
  end;
  if PlayObject.m_Hero = nil then
  begin
    GotoLable(PlayObject, '~PlayDrink_HeroBegin', False);
    exit;
  end;

  if PlayObject.m_HeroClass then
  begin
    PlayObject.m_HeroName2 := PlayObject.m_Hero.m_sCharName;
    PlayObject.m_HeroLevel2 := PlayObject.m_Hero.m_Abil.Level;
    PlayObject.m_HeroJob2 := PlayObject.m_Hero.m_btJob;
    PlayObject.m_HeroGender2 := PlayObject.m_Hero.m_btGender;
  end
  else
  begin
    PlayObject.m_HeroName1 := PlayObject.m_Hero.m_sCharName;
    PlayObject.m_HeroLevel1 := PlayObject.m_Hero.m_Abil.Level;
    PlayObject.m_HeroJob1 := PlayObject.m_Hero.m_btJob;
    PlayObject.m_HeroGender1 := PlayObject.m_Hero.m_btGender;
  end;
  PlayObject.m_Hero.MakeGhost;
  PlayObject.m_HeroName := '';
  GotoLable(PlayObject, '~PlayDrink_HeroOk', False);
end;

//减少酿酒的时间
procedure TNormNpc.ActionOfDECMAKEWINETIME(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
var
nDecTime:Integer;
begin
try
  if (PlayObject.m_boISONMAKEWINE = 0) or (PlayObject.m_boISONMAKEWINE<>QuestActionInfo.nParam2) then
  begin
    GotoLable(PlayObject, '@NoIsInMakeWine', False);
    exit;
  end;

  if (QuestActionInfo.nParam3=0) and (QuestActionInfo.nParam1>60) then
     nDecTime:=60
   else
     nDecTime:=QuestActionInfo.nParam1;

   PlayObject.m_dtMakeWineTime:=IncSecond(PlayObject.m_dtMakeWineTime,-nDecTime);
  GotoLable(PlayObject, '@DecMakeWineTimeOK', False);
  except
    MainOutmessage('[Exception] TNormNpc.ActionOfDECMAKEWINETIME');
  end;
end;

//开启关闭行会泉水
procedure TNormNpc.ActionOfSETGUILDFOUNTAIN(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
begin
  if  QuestActionInfo.nParam1=0 then
  begin
     TGuild(PlayObject.m_MyGuild).bGuildFountainOpen:=True;
    GotoLable(PlayObject, '@OpenGuildFountain', False);
  end
  else
  begin
    TGuild(PlayObject.m_MyGuild).bGuildFountainOpen:=False;
    GotoLable(PlayObject, '@CloseGuildFountain', False);
  end;
end;

//领取行会泉水
procedure TNormNpc.ActionOfGIVEGUILDFOUNTAIN(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
var
  I: Integer;
  UserItem: pTUserItem;
  StdItem: TItem;
  sItemName: string;
  nItemCount: Integer;
begin
try
if TGuild(PlayObject.m_MyGuild).nGuildFountain<g_Config.nDecGuildFountain then
begin
      GotoLable(PlayObject, '@NOGIVEFOUNTAIN', False);
end else
begin
if  now-PlayObject.m_dtGetGuildFountain>=1 then
begin
    sItemName := QuestActionInfo.sParam1;
    nItemCount :=QuestActionInfo.nParam2;
    if sItemName = '' then   exit;
    TGuild(PlayObject.m_MyGuild).nGuildFountain:=TGuild(PlayObject.m_MyGuild).nGuildFountain
          -g_Config.nDecGuildFountain;
      if not (nItemCount in [1..MAXBAGITEM]) then
        nItemCount := 1;
      for I := 0 to nItemCount - 1 do
      begin
        if PlayObject.IsEnoughBag then
        begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
          begin
            PlayObject.m_ItemList.Add((UserItem));
            PlayObject.SendAddItem(UserItem);
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            //0049D46B
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('9' + #9 +
                PlayObject.m_sMapName + #9 +
                IntToStr(PlayObject.m_nCurrX) + #9 +
                IntToStr(PlayObject.m_nCurrY) + #9 +
                PlayObject.m_sCharName + #9 +
                sItemName + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                m_sCharName);
          end
          else
            Dispose(UserItem);
        end
        else
        begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
          begin
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            //0049D5A5
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('9' + #9 +
                PlayObject.m_sMapName + #9 +
                IntToStr(PlayObject.m_nCurrX) + #9 +
                IntToStr(PlayObject.m_nCurrY) + #9 +
                PlayObject.m_sCharName + #9 +
                sItemName + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                m_sCharName);
            PlayObject.DropItemDown(UserItem, 3, False, PlayObject, nil);
          end;
          Dispose(UserItem);
        end;
      end;
   PlayObject.m_dtGetGuildFountain:=now;
   PlayObject.WeightChanged();
   GotoLable(PlayObject, '@GIVEFOUNTAIN_OK', False);
end else
   GotoLable(PlayObject, '@NOGIVEFOUNTAIN1', False);
end;
  except
    MainOutmessage('[Exception] TNormNpc.ActionOfGIVEGUILDFOUNTAIN');
  end;
end;

//领取沙城泉水
procedure TNormNpc.ActionOfGIVECASTLEFOUNTAIN(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
var
  I: Integer;
  UserItem: pTUserItem;
  StdItem: TItem;
  sItemName: string;
  nItemCount: Integer;
  Castle: TUserCastle;
begin
try
Castle := g_CastleManager.IsCastleMember(PlayObject); //是沙成员加沙的泉水
if (Castle<>nil) then//                     Castle.nCastleFountain:=Castle.nCastleFountain+1;
if Castle.nCastleFountain<g_Config.nDecGuildFountain then
begin
      GotoLable(PlayObject, '@NOGIVECASTLEFOUNTAIN', False);
end else
begin
if  now-PlayObject.m_dtGetCastleFountain>=1 then
begin
    sItemName := QuestActionInfo.sParam1;
    nItemCount :=QuestActionInfo.nParam2;
    if sItemName = '' then   exit;
     Castle.nCastleFountain:=Castle.nCastleFountain-g_Config.nDecGuildFountain;
      if not (nItemCount in [1..MAXBAGITEM]) then
        nItemCount := 1;
      for I := 0 to nItemCount - 1 do
      begin
        if PlayObject.IsEnoughBag then
        begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
          begin
            PlayObject.m_ItemList.Add((UserItem));
            PlayObject.SendAddItem(UserItem);
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            //0049D46B
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('9' + #9 +
                PlayObject.m_sMapName + #9 +
                IntToStr(PlayObject.m_nCurrX) + #9 +
                IntToStr(PlayObject.m_nCurrY) + #9 +
                PlayObject.m_sCharName + #9 +
                sItemName + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                m_sCharName);
          end
          else
            Dispose(UserItem);
        end
        else
        begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
          begin
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            //0049D5A5
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('9' + #9 +
                PlayObject.m_sMapName + #9 +
                IntToStr(PlayObject.m_nCurrX) + #9 +
                IntToStr(PlayObject.m_nCurrY) + #9 +
                PlayObject.m_sCharName + #9 +
                sItemName + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                m_sCharName);
            PlayObject.DropItemDown(UserItem, 3, False, PlayObject, nil);
          end;
          Dispose(UserItem);
        end;
      end;
   PlayObject.m_dtGetCastleFountain:=now;
   PlayObject.WeightChanged();
   GotoLable(PlayObject, '@GIVECASTLEFOUNTAIN_OK', False);
end else
   GotoLable(PlayObject, '@GIVECASTLEFOUNTAIN1', False);
end;
  except
    MainOutmessage('[Exception] TNormNpc.ActionOfGIVEGUILDFOUNTAIN');
  end;
end;



//设置泉水喷发
procedure TNormNpc.ActionOfFOUNTAIN(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
var
   nStartX:Integer;
   nEndY:Integer;
  Envir:TEnvirnoment;
  mEvent:TFOUNTAIN;
begin
try
    if (QuestActionInfo.nParam4 > 0) and (QuestActionInfo.sParam1<>'') then
     begin
        Envir:= g_MapManager.FindMap(QuestActionInfo.sParam1);
        if Envir<>NIl then
        begin
         nStartX :=QuestActionInfo.nParam2;
         nEndY   :=QuestActionInfo.nParam3;
         mEvent:=TFOUNTAIN.Create(Envir,nStartX,nEndY,ET_FOUNTAIN,QuestActionInfo.nParam4*1000);
         g_EventManager.AddEvent(mEvent);
        end;
      end;
  except
    MainOutmessage('TNormNpc.ActionOfFOUNTAIN');
  end;
end;

//取酒
procedure TNormNpc.ActionOfGETGOODMAKEWINE(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
var
  I: Integer;
  UserItem: pTUserItem;
  StdItem: TItem;
  bGetOk:Boolean;
begin
try
bGetOk:=False;
PlayObject.m_boNPCMOVE:=False; //防止玩家重复让NPC移动
case PlayObject.m_boISONMAKEWINE of
  0:
   begin
    if PlayObject.m_sMapName='0170' then
     GotoLable(PlayObject, '@NoMakeWine', False);
    exit;
   end;
  1:
   begin
    if Now>IncSecond(PlayObject.m_dtMakeWineTime,g_Config.nMakeWineTime) then
     bGetOk:=True;
   end;
  2:
   begin
     if Now>IncSecond(PlayObject.m_dtMakeWineTime,g_Config.nMakeWineTime1) then
      bGetOk:=True;
     end;
end;
  if  bGetOk then
   begin
      New(UserItem);
      Move(PlayObject.m_WineItem,UserItem^,SizeOf(TUserItem));
      PlayObject.m_dtMakeWineTime:=0;//酿酒的时间
      PlayObject.m_boISONMAKEWINE:=0;//普通酒
      FillChar(PlayObject.m_WineItem,SizeOf(TUserItem),#0);
      PlayObject.m_ItemList.Add(UserItem);
      PlayObject.SendAddItem(UserItem);
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if PlayObject.m_sMapName='0170' then
        GotoLable(PlayObject, '@EndMakeWine', False);
      if StdItem.NeedIdentify = 1 then
        AddGameDataLog('9' + #9 +PlayObject.m_sMapName + #9 +
            IntToStr(PlayObject.m_nCurrX) + #9 +IntToStr(PlayObject.m_nCurrY)
            + #9 +PlayObject.m_sCharName + #9 +StdItem.Name + #9 +
            IntToStr(UserItem.MakeIndex) + #9 +'1' + #9 +m_sCharName);
      if Random(g_Config.nMakeWineRate)= 0 then //酒曲
      begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(UserEngine.GetStdItemNameEx(13,StdItem.Shape),UserItem) then
           begin
              PlayObject.m_ItemList.Add(UserItem);
              PlayObject.SendAddItem(UserItem);
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              if StdItem.NeedIdentify = 1 then
                   AddGameDataLog('9' + #9 +PlayObject.m_sMapName + #9 +
                      IntToStr(PlayObject.m_nCurrX) + #9 +IntToStr(PlayObject.m_nCurrY)
                      + #9 +PlayObject.m_sCharName + #9 +StdItem.Name + #9 +
                      IntToStr(UserItem.MakeIndex) + #9 +'1' + #9 +m_sCharName);
           end else
             Dispose(UserItem);;
      end;
      PlayObject.WeightChanged();
   end else
   begin
       if PlayObject.m_sMapName='0170' then
         GotoLable(PlayObject, '@NoMakeWineTimeOver', False);
   end;
except
    MainOutmessage('[Exception] TNormNpc.ActionOfGETGOODMAKEWINE');
end;
end;

//打开酿酒台
procedure TNormNpc.ActionOfOPENMAKEWINE(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
begin
    PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self),
                  0, 0, '');
    PlayObject.SendDefMessage(SM_OPENMAKEWINE,
      QuestActionInfo.nParam1,
      0,
      0,
      0,
      '');
end;

procedure TNormNpc.ActionOfQUERYREFINEITEM(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
begin
    PlayObject.SendDefMessage(SM_UERYREFINEITEM,
      0,
      0,
      0,
      0,
      '');
end;

//打开WEB窗口
procedure TNormNpc.ActionOfOPENWebBrowser(PlayObject: TPlayObject; QuestActionInfo:
 pTQuestActionInfo);
begin
 if QuestActionInfo.sParam1<>'' then
    PlayObject.SendDefMessage(SM_WebBrowser,
      0,
      0,
      0,
      0,
      QuestActionInfo.sParam1);
end;


procedure TNormNpc.ActionOfGetHero(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  DefMsg: TDefaultMessage;
  ClientGetHero: TClientGetHero;
begin
  if (PlayObject.m_HeroName1 <> '') or (PlayObject.m_HeroName2 <> '') then
  begin
    ClientGetHero.HeroName1 := PlayObject.m_HeroName1;
    ClientGetHero.HeroLevel1 := PlayObject.m_HeroLevel1;
    ClientGetHero.HeroJob1 := PlayObject.m_HeroJob1;
    ClientGetHero.HeroGender1 := PlayObject.m_HeroGender1;
    ClientGetHero.HeroName2 := PlayObject.m_HeroName2;
    ClientGetHero.HeroLevel2 := PlayObject.m_HeroLevel2;
    ClientGetHero.HeroJob2 := PlayObject.m_HeroJob2;
    ClientGetHero.HeroGender2 := PlayObject.m_HeroGender2;
    DefMsg := MakeDefaultMsg(SM_PLAYDRINK, 0, 3, 0, 0);
    PlayObject.SendSocket(@DefMsg, EncodeBuffer(@ClientGetHero,
      SizeOf(TClientGetHero)));
    //GotoLable(PlayObject,'~GetHero_Ok',False);
  end;
  //GotoLable(PlayObject,'~GetHero_Bak',False);
end;

procedure TNormNpc.ActionOfSetItemsLight(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nWhere, nRate: Integer;
  UserItem: pTUserItem;
  StdItem: TItem;
  //  bt15:Byte;
begin
  try
    nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
    nRate := Str_ToInt(QuestActionInfo.sParam2, -1);
    if (not (nWhere in [0..12])) or (not (nRate in [0, 1])) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETITEMSLIGHT);
      exit;
    end;
    UserItem := @PlayObject.m_UseItems[nWhere];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (UserItem.wIndex <= 0) or (StdItem = nil) then
    begin
      PlayObject.SysMsg('你身上没有戴指定物品！！！', c_Red,
        t_Hint);
      exit;
    end;
    PlayObject.SetItemState(UserItem, ITEMSTATE_SHINE, nRate);
    PlayObject.SendUpdateItem(UserItem);
  except
    MainOutmessage('[Exception] TNormNpc.ActionOfSetItemState');
  end;
end;

//设置装备属性

procedure TNormNpc.ActionOfSetItemState(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nWhere, nValType, nRate: Integer;
  UserItem: pTUserItem;
  StdItem: TItem;
  //  bt15:Byte;
begin
  try
    nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
    nValType := Str_ToInt(QuestActionInfo.sParam2, -1);
    nRate := Str_ToInt(QuestActionInfo.sParam3, -1);
    if (not (nWhere in [0..13])) or (not (nValType in [0..5])) or (not (nRate in
      [0, 1])) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETITEMSTATE);
      exit;
    end;
    UserItem := @PlayObject.m_UseItems[nWhere];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (UserItem.wIndex <= 0) or (StdItem = nil) then
    begin
      PlayObject.SysMsg('你身上没有戴指定物品！！！', c_Red,
        t_Hint);
      exit;
    end;
    PlayObject.SetItemState(UserItem, nValType, nRate);
  except
    MainOutmessage('[Exception] TNormNpc.ActionOfSetItemState');
  end;
end;

procedure TNormNpc.ActionOfUpgradeItemsEx(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate, nWhere, nValType, nPoint, nAddPoint: Integer;
  UserItem: pTUserItem;
  StdItem: TItem;
  nUpgradeItemStatus: Integer;
  nRatePoint: Integer;
begin
  try
    nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
    nValType := Str_ToInt(QuestActionInfo.sParam2, -1);
    nRate := Str_ToInt(QuestActionInfo.sParam3, -1);
    nPoint := Str_ToInt(QuestActionInfo.sParam4, -1);
    nUpgradeItemStatus := Str_ToInt(QuestActionInfo.sParam5, -1);
    if (nValType < 0) or (nValType > 14) or (nWhere < 0) or (nWhere >
      High(THumanUseItems)) or (nRate < 0) or (nPoint < 0) or (nPoint > 255)
        then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_UPGRADEITEMSEX);
      exit;
    end;
    UserItem := @PlayObject.m_UseItems[nWhere];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (UserItem.wIndex <= 0) or (StdItem = nil) then
    begin
      PlayObject.SysMsg('你身上没有戴指定物品！！！', c_Red,
        t_Hint);
      exit;
    end;
    nRatePoint := Random(nRate * 10);
    nPoint := _MAX(1, Random(nPoint));

    if not (nRatePoint in [0..10]) then
    begin
      case nUpgradeItemStatus of //
        0:
          begin
            PlayObject.SysMsg('装备升级未成功！！！', c_Red, t_Hint);
          end;
        1:
          begin
            PlayObject.SendDelItems(UserItem);
            UserItem.wIndex := 0;
            PlayObject.SysMsg('装备破碎！！！', c_Red, t_Hint);
          end;
        2:
          begin
            PlayObject.SysMsg('装备升级失败，装备属性恢复默认！！！', c_Red, t_Hint);
            if nValType <> 14 then
              UserItem.btValue[nValType] := 0;
          end;
      end;
      exit;
    end;
    if nValType = 14 then
    begin
      nAddPoint := (nPoint * 1000);
      if UserItem.DuraMax + nAddPoint > High(Word) then
      begin
        nAddPoint := High(Word) - UserItem.DuraMax;
      end;

      UserItem.DuraMax := UserItem.DuraMax + nAddPoint;
    end
    else
    begin
      nAddPoint := nPoint;
      if UserItem.btValue[nValType] + nAddPoint > High(Byte) then
      begin
        nAddPoint := High(Byte) - UserItem.btValue[nValType];
      end;

      UserItem.btValue[nValType] := UserItem.btValue[nValType] + nAddPoint;
    end;
    PlayObject.SendUpdateItem(UserItem);
    PlayObject.SysMsg('装备升级成功', c_Green, t_Hint);
    PlayObject.SysMsg(StdItem.Name + ': ' +
      IntToStr(UserItem.Dura) + '/' +
      IntToStr(UserItem.DuraMax) + '-' +
      IntToStr(UserItem.btValue[0]) + '/' +
      IntToStr(UserItem.btValue[1]) + '/' +
      IntToStr(UserItem.btValue[2]) + '/' +
      IntToStr(UserItem.btValue[3]) + '/' +
      IntToStr(UserItem.btValue[4]) + '/' +
      IntToStr(UserItem.btValue[5]) + '/' +
      IntToStr(UserItem.btValue[6]) + '/' +
      IntToStr(UserItem.btValue[7]) + '/' +
      IntToStr(UserItem.btValue[8]) + '/' +
      IntToStr(UserItem.btValue[9]) + '/' +
      IntToStr(UserItem.btValue[10]) + '/' +
      IntToStr(UserItem.btValue[11]) + '/' +
      IntToStr(UserItem.btValue[12]) + '/' +
      IntToStr(UserItem.btValue[13])
      , c_Blue, t_Hint);

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfUpgradeItemsEx');
  end;
end;
//声明变量
//VAR 数据类型(Integer String) 类型(HUMAN GUILD GLOBAL) 变量值

procedure TNormNpc.ActionOfVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  VarType: TVarType;
  sVarName: string;
  sVarValue: string;
  nVarValue: Integer;
  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '变量%s已存在，变量类型:%s';
  sVarTypeError =
    '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  try
    sType := QuestActionInfo.sParam2;
    sVarName := QuestActionInfo.sParam3;
    sVarValue := QuestActionInfo.sParam4;
    nVarValue := Str_ToInt(QuestActionInfo.sParam4, 0);
    VarType := vNone;
    if CompareText(QuestActionInfo.sParam1, 'Integer') = 0 then
      VarType := vInteger;
    if CompareText(QuestActionInfo.sParam1, 'String') = 0 then
      VarType := vString;

    if (sType = '') or (sVarName = '') or (VarType = vNone) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_VAR);
      exit;
    end;
    New(DynamicVar);
    DynamicVar.sName := sVarName;
    DynamicVar.VarType := VarType;
    DynamicVar.nInternet := nVarValue;
    DynamicVar.sString := sVarValue;
    boFoundVar := False;
    DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
    if DynamicVarList = nil then
    begin
      Dispose(DynamicVar);
      ScriptActionError(PlayObject, format(sVarTypeError, [sType]),
        QuestActionInfo, sSC_VAR);
      exit;
    end;
    for I := 0 to DynamicVarList.Count - 1 do
    begin
      if CompareText(pTDynamicVar(DynamicVarList.Items[I]).sName, sVarName) = 0
        then
      begin
        boFoundVar := True;
        break;
      end;
    end;
    if not boFoundVar then
    begin
      DynamicVarList.Add(DynamicVar);
    end
    else
    begin
      Dispose(DynamicVar); //2007-8-17 增加防止内存泄露
      ScriptActionError(PlayObject, format(sVarFound, [sVarName, sType]),
        QuestActionInfo, sSC_VAR);
    end;

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfVar');
  end;
end;
//读取变量值
//LOADVAR 变量类型 变量名 文件名

procedure TNormNpc.ActionOfLoadVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  sVarName: string;
  sFileName: string;
  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
  IniFile: TIniFile;
resourcestring
  sVarFound = '变量%s不存在，变量类型:%s';
  sVarTypeError =
    '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  try
    sType := QuestActionInfo.sParam1;
    sVarName := QuestActionInfo.sParam2;
    sFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam3;
    if (sType = '') or (sVarName = '') or not FileExists(sFileName) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_LOADVAR);
      exit;
    end;
    boFoundVar := False;
    DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
    if DynamicVarList = nil then
    begin
      ScriptActionError(PlayObject, format(sVarTypeError, [sType]),
        QuestActionInfo, sSC_VAR);
      exit;
    end;
    IniFile := TIniFile.Create(sFileName);
    for I := 0 to DynamicVarList.Count - 1 do
    begin
      DynamicVar := DynamicVarList.Items[I];
      if CompareText(DynamicVar.sName, sVarName) = 0 then
      begin
        case DynamicVar.VarType of
          vInteger: DynamicVar.nInternet := IniFile.ReadInteger(sName,
              DynamicVar.sName, 0);
          vString: DynamicVar.sString := IniFile.ReadString(sName,
              DynamicVar.sName, '');
        end;
        boFoundVar := True;
        break;
      end;
    end;

    if not boFoundVar then
      ScriptActionError(PlayObject, format(sVarFound, [sVarName, sType]),
        QuestActionInfo, sSC_LOADVAR);
    IniFile.Free;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfLoadVar');
  end;
end;

//保存变量值
//SAVEVAR 变量类型 变量名 文件名

procedure TNormNpc.ActionOfSaveVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  sVarName: string;
  sFileName: string;
  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
  IniFile: TIniFile;
resourcestring
  sVarFound = '变量%s不存在，变量类型:%s';
  sVarTypeError =
    '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  try
    sType := QuestActionInfo.sParam1;
    sVarName := QuestActionInfo.sParam2;
    sFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam3;
    if (sType = '') or (sVarName = '') or not FileExists(sFileName) then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SAVEVAR);
      exit;
    end;
    boFoundVar := False;
    DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
    if DynamicVarList = nil then
    begin
      ScriptActionError(PlayObject, format(sVarTypeError, [sType]),
        QuestActionInfo, sSC_VAR);
      exit;
    end;
    IniFile := TIniFile.Create(sFileName);
    for I := 0 to DynamicVarList.Count - 1 do
    begin
      DynamicVar := DynamicVarList.Items[I];
      if CompareText(DynamicVar.sName, sVarName) = 0 then
      begin
        case DynamicVar.VarType of
          vInteger: IniFile.WriteInteger(sName, DynamicVar.sName,
              DynamicVar.nInternet);
          vString: IniFile.WriteString(sName, DynamicVar.sName,
              DynamicVar.sString);
        end;
        boFoundVar := True;
        break;
      end;
    end;

    if not boFoundVar then
      ScriptActionError(PlayObject, format(sVarFound, [sVarName, sType]),
        QuestActionInfo, sSC_SAVEVAR);
    IniFile.Free;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfSaveVar');
  end;
end;
//对变量进行运算(+、-、*、/)

procedure TNormNpc.ActionOfCalcVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  sVarName: string;
  sName: string;
  sVarValue: string;
  nVarValue: Integer;
  sMethod: string;
  cMethod: Char;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '变量%s不存在，变量类型:%s';
  sVarTypeError =
    '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
  sVarModError =
    '变量操作错误，变量类型:%s 字符串变量只支持(=)';
begin
  try
    sType := QuestActionInfo.sParam1;
    sVarName := QuestActionInfo.sParam2;
    sMethod := QuestActionInfo.sParam3;
    sVarValue := QuestActionInfo.sParam4;
    nVarValue := Str_ToInt(QuestActionInfo.sParam4, 0);

    if (sType = '') or (sVarName = '') or (sMethod = '') then
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CALCVAR);
      exit;
    end;
    boFoundVar := False;
    cMethod := sMethod[1];
    DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
    if DynamicVarList = nil then
    begin
      ScriptActionError(PlayObject, format(sVarTypeError, [sType]),
        QuestActionInfo, sSC_CALCVAR);
      exit;
    end;
    for I := 0 to DynamicVarList.Count - 1 do
    begin
      DynamicVar := DynamicVarList.Items[I];
      if CompareText(DynamicVar.sName, sVarName) = 0 then
      begin
        case DynamicVar.VarType of
          vInteger:
            begin
              case cMethod of
                '=': DynamicVar.nInternet := nVarValue;
                '+': DynamicVar.nInternet := DynamicVar.nInternet + nVarValue;
                '-': DynamicVar.nInternet := DynamicVar.nInternet - nVarValue;
                '*': DynamicVar.nInternet := DynamicVar.nInternet * nVarValue;
                '/': DynamicVar.nInternet := DynamicVar.nInternet div nVarValue;
              end;
            end;
          vString:
            begin
              case cMethod of
                '=': DynamicVar.sString := sVarValue;
              else
                ScriptActionError(PlayObject, format(sVarModError, [sType]),
                  QuestActionInfo, sSC_CALCVAR);
              end;
            end;
        end;
        boFoundVar := True;
        break;
      end;
    end;

    if not boFoundVar then
      ScriptActionError(PlayObject, format(sVarFound, [sVarName, sType]),
        QuestActionInfo, sSC_CALCVAR);

  except
    MainOutMessage('[Exception] TNormNpc.ActionOfCalcVar');
  end;
end;

procedure TNormNpc.ActionOfGuildRecall(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  try
    if PlayObject.m_MyGuild <> nil then
    begin
      //PlayObject.GuildRecall('GuildRecall','');
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGuildRecall');
  end;
end;

procedure TNormNpc.ActionOfGroupAddList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  ffile: string;
  I: integer;
begin
  try
    ffile := QuestActionInfo.sParam1;
    if PlayObject.m_GroupOwner <> nil then
    begin
      for I := 0 to PlayObject.m_GroupMembers.Count - 1 do
      begin
        PlayObject := TPlayObject(PlayObject.m_GroupMembers.Objects[i]);
        //AddListEx(PlayObject.m_sCharName,ffile);
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGroupAddList');
  end;
end;

//if DeleteFile(fileName)

procedure TNormNpc.ActionOfClearList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  ffile: string;
  myFile: TextFile;
begin
  try

    ffile := g_Config.sEnvirDir + QuestActionInfo.sParam1;
    if FileExists(ffile) then
    begin
      AssignFile(myFile, ffile);
      ReWrite(myFile);
      CloseFile(myFile);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfClearList');
  end;
end;

procedure TNormNpc.ActionOfGuildMove(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  i, II: integer;
  GuildRank: pTGuildRank;
  PlayObjectEx: TPlayObject;
  //  sMapName:String;
begin
  try
    if PlayObject.IsGuildMaster then
    begin
      PlayObject.MapRandomMove(QuestActionInfo.sParam1, 0);
      for I := 0 to TGuild(PlayObject.m_MyGuild).m_RankList.Count - 1 do
      begin
        GuildRank := TGuild(PlayObject.m_MyGuild).m_RankList.Items[I];
        for II := 0 to GuildRank.MemberList.Count - 1 do
        begin
          PlayObjectEx := TPlayObject(GuildRank.MemberList.Objects[II]);
          if PlayObject = PlayObjectEx then
            Continue;
          if (PlayObjectEx <> nil) and (PlayObjectEx.m_boAllowGuildReCall) then
          begin
            PlayObject.RecallHuman(PlayObjectEx.m_sCharName);
            //PlayObjectEx.MapRandomMove(sMapName,0);
          end;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGuildMove');
  end;
end;

//离线挂机

procedure TNormNpc.ActionOfOfflincPlay(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
begin
  try
    if not PlayObject.m_boSafeOffLine then
    begin
      PlayObject.m_boNpcOffLine := True;
      PlayObject.m_dwSafeOffLine := 0;
      PlayObject.m_dwOffLineAddExpTime := QuestActionInfo.nParam1 * 1000;
      PlayObject.m_nOffLineAddExp := QuestActionInfo.nParam2;
      PlayObject.m_dwOffLineAddExpTick := GetTickCount +
        PlayObject.m_dwOffLineAddExpTime;
      if QuestActionInfo.nParam3 > 0 then
        PlayObject.m_dwSafeOffLine := GetTickCount +
          LongWord(QuestActionInfo.nParam3 * 60 * 1000);
      //PlayObject.SendUpdateMsg(PlayObject,RM_OFFLINE,0,0,0,0,'');
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfOfflincPlay');
  end;
end;

procedure TNormNpc.ActionOfDeleteHero(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
begin
  try
    if PlayObject.m_HeroName = '' then
    begin
      GotoLable(PlayObject, sSL_NotHaveHero, False);
      exit;
    end;
    if PlayObject.m_Hero <> nil then
    begin
      GotoLable(PlayObject, sSL_LogOutHeroFirst, False);
      exit;
    end;
    FrontEngine.AddCorpsRcdList(PlayObject.m_sUserID, PlayObject.m_HeroName, '',
      CORPS_DELETEHERO, PlayObject);
    PlayObject.m_HeroName := '';
    GotoLable(PlayObject, sSL_DeleteHeroOK, False);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfDeleteHero');
  end;
end;

procedure TNormNpc.ActionOfGuildMapMove(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  i, II: integer;
  GuildRank: pTGuildRank;
  PlayObjectEx: TPlayObject;
  //  sMapName:String;
begin
  try
    if PlayObject.IsGuildMaster then
    begin
      for I := 0 to TGuild(PlayObject.m_MyGuild).m_RankList.Count - 1 do
      begin
        GuildRank := TGuild(PlayObject.m_MyGuild).m_RankList.Items[I];
        for II := 0 to GuildRank.MemberList.Count - 1 do
        begin
          PlayObjectEx := TPlayObject(GuildRank.MemberList.Objects[II]);
          if (PlayObjectEx <> nil) and (PlayObjectEx.m_boAllowGuildReCall) then
          begin
            PlayObjectEx.SpaceMove(QuestActionInfo.sParam1,
              QuestActionInfo.nParam2, QuestActionInfo.nParam3, 0);
          end;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGuildMapMove');
  end;
end;

procedure TNormNpc.ActionOfGroupRecall(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: integer;
  PlayObjectEx: TPlayObject;
begin
  try
    if (PlayObject.m_GroupOwner = PlayObject) and (PlayObject.m_PEnvir <> nil)
      then
    begin
      PlayObject.MapRandomMove(QuestActionInfo.sParam1, 0);
      for I := 0 to PlayObject.m_GroupMembers.Count - 1 do
      begin
        PlayObjectEx := TPlayObject(PlayObject.m_GroupMembers.Objects[i]);
        if PlayObjectEx = PlayObject then
          Continue;
        PlayObject.RecallHuman(PlayObjectEx.m_sCharName);
      end;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGroupRecall');
  end;
end;

procedure TNormNpc.ActionOfGroupMoveMap(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I, nX, nY: integer;
  PlayObjectEx: TPlayObject;
  Envir: TEnvirnoment;
  boFlag: Boolean;
begin
  try
    boFlag := False;
    nX := Str_ToInt(QuestActionInfo.sParam2, -1);
    nY := Str_ToInt(QuestActionInfo.sParam3, -1);
    if PlayObject.m_GroupOwner = PlayObject then
    begin
      Envir := g_MapManager.FindMap(QuestActionInfo.sParam1);
      if Envir <> nil then
      begin
        boFlag := True;
        if (nX < 0) or (nY < 0) then
        begin
          PlayObject.MapRandomMove(QuestActionInfo.sParam1, 0);
          for I := 0 to PlayObject.m_GroupMembers.Count - 1 do
          begin
            PlayObjectEx := TPlayObject(PlayObject.m_GroupMembers.Objects[i]);
            if PlayObjectEx = PlayObject then
              Continue;
            PlayObject.RecallHuman(PlayObjectEx.m_sCharName);
          end;
        end
        else
        begin
          if Envir.CanWalk(nX, nY, True) then
          begin
            for I := 0 to PlayObject.m_GroupMembers.Count - 1 do
            begin
              PlayObjectEx := TPlayObject(PlayObject.m_GroupMembers.Objects[i]);
              PlayObjectEx.SpaceMove(QuestActionInfo.sParam1, nX, nY, 0);
            end;
          end;
        end;
      end;
    end;

    if not boFlag then
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GROUPMAPMOVE);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGroupMoveMap');
  end;
end;

//移动到挑战地图
procedure TNormNpc.ActionOfCHALLENGMAPMOVE(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
var
  nX, nY: integer;
  Envir: TEnvirnoment;
  boFlag: Boolean;
begin
  try
    boFlag := False;
    nX := Str_ToInt(QuestActionInfo.sParam2, -1);
    nY := Str_ToInt(QuestActionInfo.sParam3, -1);
    if (PlayObject.m_boChallengeOK) and (PlayObject.m_Challenge<>nil) then
    begin
      Envir := g_MapManager.FindMap(QuestActionInfo.sParam1);
      if Envir <> nil then
      begin
        boFlag := True;
        if (nX < 0) or (nY < 0) then
        begin
          PlayObject.MapRandomMove(QuestActionInfo.sParam1, 0);
          PlayObject.m_Challenge.MapRandomMove(QuestActionInfo.sParam1, 0);
        end
        else
        begin
          if Envir.CanWalk(nX, nY, True) then
           PlayObject.SpaceMove(QuestActionInfo.sParam1, nX, nY, 0);
           PlayObject.m_Challenge.MapRandomMove(QuestActionInfo.sParam1, 0);
        end;
      end;
    end;
     if not boFlag then
      ScriptActionError(PlayObject, '', QuestActionInfo, sSc_CHALLENGMAPMOVE);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfCHALLENGMAPMOVE');
  end;
end;

procedure TNormNpc.ActionOfGETCHALLENGEBAKITEM(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
var
  boFlag: Boolean;
begin
  try
    boFlag := False;
    if (PlayObject.pChallengeItem<>nil) and (PlayObject.m_Challenge<>nil) then
    begin
      PlayObject.GetBackChallengeItems();
      PlayObject.SendDefMessage(SM_CancelChallege, 0, 0, 0, 0, '');
      PlayObject.SysMsg(ChallengeActionCancelMsg {'挑战取消'}, c_Green, t_Hint);
      PlayObject.m_boChallengeing := False;
      PlayObject.m_dwChallengeTime:=0;
      PlayObject.m_Challenge.GetBackChallengeItems();
      PlayObject.m_Challenge.SendDefMessage(SM_CancelChallege, 0, 0, 0, 0, '');
      PlayObject.m_Challenge.SysMsg(ChallengeActionCancelMsg {'挑战取消'}, c_Green, t_Hint);
      PlayObject.m_Challenge.m_boChallengeing := False;
      PlayObject.m_Challenge.m_dwChallengeTime:=0;
      PlayObject.m_Challenge. m_Challenge := nil;
      PlayObject. m_Challenge := nil;
      boFlag := True;
    end;
     if not boFlag then
      ScriptActionError(PlayObject, '', QuestActionInfo, sSc_CHALLENGMAPMOVE);
  except
    MainOutMessage('[Exception] TNormNpc.ActionOfGETCHALLENGEBAKITEM');
  end;
end;
procedure TNormNpc.Initialize;
begin
  try
    inherited;
    m_Castle := g_CastleManager.InCastleWarArea(Self);
  except
    MainOutMessage('[Exception] TNormNpc.Initialize');
  end;
end;

function TNormNpc.ConditionOfCheckNameDateList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sListFileName, sLineText, sHumName, sDate: string;
  boDeleteExprie, boNoCompareHumanName: Boolean;
  dOldDate: TDateTime;
  cMethod: Char;
  nValNo, nValNoDay, nDayCount, nDay: Integer;
begin
  try
    Result := False;
    nDayCount := Str_ToInt(QuestConditionInfo.sParam3, -1);
    nValNo := GetValNameNo(QuestConditionInfo.sParam4);
    nValNoDay := GetValNameNo(QuestConditionInfo.sParam5);
    boDeleteExprie := CompareText(QuestConditionInfo.sParam6, '清理') = 0;
    boNoCompareHumanName := CompareText(QuestConditionInfo.sParam6, '1') = 0;
    cMethod := QuestConditionInfo.sParam2[1];
    if nDayCount < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKNAMEDATELIST);
      exit;
    end;
    sListFileName := g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1;
    if FileExists(sListFileName) then
    begin
      LoadList := TStringList.Create;
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
      for I := 0 to LoadList.Count - 1 do
      begin
        sLineText := Trim(LoadList.Strings[I]);
        sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
        if (CompareText(sHumName, PlayObject.m_sCharName) = 0) or
          boNoCompareHumanName then
        begin
          nDay := High(Integer);
          if TryStrToDateTime(sDate, dOldDate) then
            nDay := GetDayCount(Now, dOldDate);
          case cMethod of
            '=': if nDay = nDayCount then
                Result := True;
            '>': if nDay > nDayCount then
                Result := True;
            '<': if nDay < nDayCount then
                Result := True;
          else if nDay >= nDayCount then
            Result := True;
          end;
          if nValNo >= 0 then
          begin
            case nValNo of
              0..99:
                begin
                  PlayObject.m_nVal[nValNo] := nDay;
                end;
              1000..1999:
                begin
                  g_Config.GlobalVal[nValNo - 1000] := nDay;
                end;
              200..299:
                begin
                  PlayObject.m_DyVal[nValNo - 200] := nDay;
                end;
              300..399:
                begin
                  PlayObject.m_nMval[nValNo - 300] := nDay;
                end;
              4000..4999:
                begin
                  g_Config.GlobaDyMval[nValNo - 4000] := nDay;
                end;
              900..999:
                begin
                  PlayObject.m_DyValEx[nValNo - 900] := nDay;
                end;
            end;
          end;

          if nValNoDay >= 0 then
          begin
            case nValNoDay of
              0..99:
                begin
                  PlayObject.m_nVal[nValNoDay] := nDayCount - nDay;
                end;
              1000..1999:
                begin
                  g_Config.GlobalVal[nValNoDay - 1000] := nDayCount - nDay;
                end;
              200..299:
                begin
                  PlayObject.m_DyVal[nValNoDay - 200] := nDayCount - nDay;
                end;
              300..399:
                begin
                  PlayObject.m_nMval[nValNoDay - 300] := nDayCount - nDay;
                end;
            end;
          end;
          if not Result then
          begin
            if boDeleteExprie then
            begin
              LoadList.Delete(I);
              try
                LoadList.SaveToFile(sListFileName);
              except
                MainOutMessage('Save fail.... => ' + sListFileName);
              end;
            end;
          end;
          break;
        end;
      end;
      LoadList.Free;
    end
    else
    begin
      MainOutMessage('file not found => ' + sListFileName);
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckNameDateList');
  end;
end;
//CHECKMAPHUMANCOUNT MAP = COUNT

function TNormNpc.ConditionOfCheckMapHumanCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount, nHumanCount: Integer;
  cMethod: Char;
begin
  try
    Result := False;
    nCount := Str_ToInt(QuestConditionInfo.sParam3, -1);
    if nCount < 0 then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKMAPHUMANCOUNT);
      exit;
    end;
    nHumanCount := UserEngine.GetMapHuman(QuestConditionInfo.sParam1);

    cMethod := QuestConditionInfo.sParam2[1];
    case cMethod of
      '=': if nHumanCount = nCount then
          Result := True;
      '>': if nHumanCount > nCount then
          Result := True;
      '<': if nHumanCount < nCount then
          Result := True;
    else if nHumanCount >= nCount then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckMapHumanCount');
  end;
end;

function TNormNpc.ConditionOfCheckMapMonCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount, nMonCount: Integer;
  cMethod: Char;
  Envir: TEnvirnoment;
begin
  try
    Result := False;
    nCount := Str_ToInt(QuestConditionInfo.sParam3, -1);
    Envir := g_MapManager.FindMap(QuestConditionInfo.sParam1);
    if (nCount < 0) or (Envir = nil) then
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKMAPMONCOUNT);
      exit;
    end;

    nMonCount := UserEngine.GetMapMonster(Envir, nil);

    cMethod := QuestConditionInfo.sParam2[1];
    case cMethod of
      '=': if nMonCount = nCount then
          Result := True;
      '>': if nMonCount > nCount then
          Result := True;
      '<': if nMonCount < nCount then
          Result := True;
    else if nMonCount >= nCount then
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TNormNpc.ConditionOfCheckMapMonCount');
  end;
end;

function TNormNpc.GetDynamicVarList(PlayObject: TPlayObject;
  sType: string; var sName: string): TList;
begin
  Result := nil;
  try
    if CompareLStr(sType, 'HUMAN', length('HUMAN')) then
    begin
      Result := PlayObject.m_DynamicVarList;
      sName := PlayObject.m_sCharName;
    end
    else if CompareLStr(sType, 'GUILD', length('GUILD')) then
    begin
      if PlayObject.m_MyGuild = nil then
        exit;
      Result := TGuild(PlayObject.m_MyGuild).m_DynamicVarList;
      sName := TGuild(PlayObject.m_MyGuild).sGuildName;
    end
    else if CompareLStr(sType, 'GLOBAL', length('GLOBAL')) then
    begin
      Result := g_DynamicVarList;
      sName := 'GLOBAL';
    end;
  except
    MainOutMessage('[Exception] TNormNpc.GetDynamicVarList');
  end;
end;

{ TGuildOfficial }

procedure TGuildOfficial.Click(PlayObject: TPlayObject); //004A30F4
begin
  try
    //  GotoLable(PlayObject,'@main');
    inherited;
  except
    MainOutMessage('[Exception] TGuildOfficial.Click');
  end;
end;

procedure TGuildOfficial.GetVariableText(PlayObject: TPlayObject;
  var sMsg: string; sVariable: string);
var
  I, II: Integer;
  sText: string;
  List: TStringList;
  sStr: string;
begin
  try
    inherited;
    if sVariable = '$REQUESTCASTLELIST' then
    begin
      sText := '';
      List := TStringList.Create;
      g_CastleManager.GetCastleNameList(List);
      for I := 0 to List.Count - 1 do
      begin
        II := I + 1;
        if ((II div 2) * 2 = II) then
          sStr := '\'
        else
          sStr := '';

        sText := sText + format('<%s/@requestcastlewarnow%d> %s',
          [List.Strings[I], I, sStr]);
      end;
      sText := sText + '\ \';
      List.Free;
      sMsg := sub_49ADB8(sMsg, '<$REQUESTCASTLELIST>', sText);
    end;
  except
    MainOutMessage('[Exception] TGuildOfficial.GetVariableText');
  end;
end;

procedure TGuildOfficial.Run; //004A37F0
begin
  try
    if Random(40) = 0 then
    begin
      TurnTo(Random(8));
    end
    else
    begin
      if Random(30) = 0 then
        SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    end;
    inherited;
  except
    MainOutMessage('[Exception] TGuildOfficial.Run');
  end;
end;

procedure TGuildOfficial.UserSelect(PlayObject: TPlayObject; sData: string);
var
  sMsg, sLabel: string;
  boCanJmp: Boolean;
  nCheckCode: Byte;
resourcestring
  sExceptionMsg = '[Exception] TGuildOfficial::UserSelect %d %s %s %s';
begin

  try

    inherited;
    nCheckCode := 1;
    try
      //    PlayObject.m_nScriptGotoCount:=0;
      if (sData <> '') and (sData[1] = '@') then
      begin
        nCheckCode := 2;
        sMsg := GetValidStr3(sData, sLabel, [#13]);
        nCheckCode := 3;
        boCanJmp := PlayObject.LableIsCanJmp(sLabel);
        nCheckCode := 4;
        GotoLable(PlayObject, sLabel, not boCanJmp);
        nCheckCode := 5;
        //GotoLable(PlayObject,sLabel,not PlayObject.LableIsCanJmp(sLabel));
        if not boCanJmp then
          exit;
        nCheckCode := 6;
        if CompareText(sLabel, sBUILDGUILDNOW) = 0 then
        begin
          nCheckCode := 7;
          ReQuestBuildGuild(PlayObject, sMsg);
          nCheckCode := 8;
        end
        else if CompareText(sLabel, sSCL_GUILDWAR) = 0 then
        begin
          nCheckCode := 9;
          ReQuestGuildWar(PlayObject, sMsg);
          nCheckCode := 10;
        end
        else if CompareText(sLabel, sDONATE) = 0 then
        begin
          nCheckCode := 11;
          DoNate(PlayObject);
          nCheckCode := 12;
        end
        else if CompareLStr(sLabel, sREQUESTCASTLEWAR,
          length(sREQUESTCASTLEWAR)) then
        begin
          nCheckCode := 13;
          ReQuestCastleWar(PlayObject, Copy(sLabel, length(sREQUESTCASTLEWAR)
            + 1, length(sLabel) - length(sREQUESTCASTLEWAR)));
          nCheckCode := 14;
        end
        else if CompareText(sLabel, sEXIT) = 0 then
        begin
          nCheckCode := 15;
          PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self), 0,
            0,
            '');
          nCheckCode := 16;
        end
        else if CompareText(sLabel, sBACK) = 0 then
        begin
          nCheckCode := 17;
          if PlayObject.m_sScriptGoBackLable = '' then
            PlayObject.m_sScriptGoBackLable := sMAIN;
          nCheckCode := 18;
          GotoLable(PlayObject, PlayObject.m_sScriptGoBackLable, False);
          nCheckCode := 19;
        end;
      end;
    except
      MainOutMessage(Format(sExceptionMsg, [nCheckCode, PlayObject.m_sCharName,
        m_sCharName, sData]));
    end;
    //  inherited;
  except
    MainOutMessage('[Exception] TGuildOfficial.UserSelect');
  end;
end;

function TGuildOfficial.ReQuestBuildGuild(PlayObject: TPlayObject; sGuildName:
  string): Integer; //004A3124
var
  UserItem: pTUserItem;
  //  sKey:String;
begin
  try
    Result := 0;
    sGuildName := Trim(sGuildName);
    UserItem := nil;
    if sGuildName = '' then
    begin
      Result := -4;
    end;
    if PlayObject.m_MyGuild = nil then
    begin
      if PlayObject.m_nGold >= g_Config.nBuildGuildPrice then
      begin
        UserItem := PlayObject.CheckItems(g_Config.sWomaHorn);
        if UserItem = nil then
        begin
          Result := -3; //'你没有准备好需要的全部物品。'
        end;
      end
      else
        Result := -2; //'缺少创建费用。'
    end
    else
      Result := -1; //'您已经加入其它行会。'
    if Result = 0 then
    begin
      if g_GuildManager.AddGuild(sGuildName, PlayObject.m_sCharName) then
      begin
        UserEngine.SendServerGroupMsg(SS_205, nServerIndex, sGuildName + '/' +
          PlayObject.m_sCharName);
        PlayObject.SendDelItems(UserItem);
        PlayObject.DelBagItem(UserItem.MakeIndex, g_Config.sWomaHorn);
        PlayObject.DecGold(g_Config.nBuildGuildPrice);
        PlayObject.GoldChanged();
        PlayObject.m_MyGuild :=
          g_GuildManager.MemberOfGuild(PlayObject.m_sCharName);
        if PlayObject.m_MyGuild <> nil then
        begin
          PlayObject.m_sGuildRankName :=
            TGuild(PlayObject.m_MyGuild).GetRankName(PlayObject,
            PlayObject.m_nGuildRankNo);
          //RefShowName();
          PlayObject.RefShowName(); //Jason 0714
        end;
      end
      else
        Result := -4;
    end;
    if Result >= 0 then
    begin
      PlayObject.SendMsg(Self, RM_BUILDGUILD_OK, 0, 0, 0, 0, '');
    end
    else
    begin
      PlayObject.SendMsg(Self, RM_BUILDGUILD_FAIL, 0, Result, 0, 0, '');
    end;
  except
    MainOutMessage('[Exception] TGuildOfficial.ReQuestBuildGuild');
  end;
end;

function TGuildOfficial.ReQuestGuildWar(PlayObject: TPlayObject; sGuildName:
  string): Integer; //004A3368
begin
  try
    if g_GuildManager.FindGuild(sGuildName) <> nil then
    begin
      if PlayObject.m_nGold >= g_Config.nGuildWarPrice then
      begin
        PlayObject.DecGold(g_Config.nGuildWarPrice);
        PlayObject.GoldChanged();
        PlayObject.ReQuestGuildWar(sGuildName);
      end
      else
      begin
        PlayObject.SysMsg('金币不足', c_Red, t_Hint);
      end;
    end
    else
    begin
      PlayObject.SysMsg(sGuildName + ' 行会不存在.', c_Red, t_Hint);
    end;
    Result := 1;
  except
    MainOutMessage('[Exception] TGuildOfficial.ReQuestGuildWar');
  end;
end;

procedure TGuildOfficial.DoNate(PlayObject: TPlayObject); //004A346C
begin
  try
    PlayObject.SendMsg(Self, RM_DONATE_OK, 0, 0, 0, 0, '');
  except
    MainOutMessage('[Exception] TGuildOfficial.DoNate');
  end;
end;

procedure TGuildOfficial.ReQuestCastleWar(PlayObject: TPlayObject; sIndex:
  string); //004A3498
var
  UserItem: pTUserItem;
  Castle: TUserCastle;
  nIndex: Integer;
begin
  try
    //  if PlayObject.IsGuildMaster and
    //     (not UserCastle.IsMasterGuild(TGuild(PlayObject.m_MyGuild))) then begin
    nIndex := Str_ToInt(sIndex, -1);
    if nIndex < 0 then
      nIndex := 0;

    Castle := g_CastleManager.GetCastle(nIndex);
    if PlayObject.IsGuildMaster and
      not Castle.IsMember(PlayObject) then
    begin

      UserItem := PlayObject.CheckItems(g_Config.sZumaPiece);
      if UserItem <> nil then
      begin
        if Castle.AddAttackerInfo(TGuild(PlayObject.m_MyGuild)) then
        begin
          PlayObject.SendDelItems(UserItem);
          PlayObject.DelBagItem(UserItem.MakeIndex, g_Config.sZumaPiece);
          GotoLable(PlayObject, '~@request_ok', False);
        end
        else
        begin
          PlayObject.SysMsg('已经申请过了！！！.', c_Red, t_Hint);
        end;

      end
      else
      begin
        PlayObject.SysMsg(Format('没有发现%s.', [g_Config.sZumaPiece]),
          c_Red, t_Hint);
      end;
    end
    else
    begin
      PlayObject.SysMsg('请求被取消.', c_Red, t_Hint);
    end;
  except
    MainOutMessage('[Exception] TGuildOfficial.ReQuestCastleWar');
  end;
end;

procedure TCastleOfficial.RepairDoor(PlayObject: TPlayObject); //004A3FB8
begin
  try
    if m_Castle = nil then
    begin
      PlayObject.SysMsg('NPC不属于城堡！！！', c_Red, t_Hint);
      exit;
    end;
    if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nRepairDoorPrice then
    begin
      if TUserCastle(m_Castle).RepairDoor then
      begin
        Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nRepairDoorPrice);
        PlayObject.SysMsg('修理成功。', c_Green, t_Hint);
      end
      else
      begin
        PlayObject.SysMsg('城门不需要修理！！！', c_Green, t_Hint);
      end;
    end
    else
    begin
      PlayObject.SysMsg('城内资金不足！！！', c_Red, t_Hint);
    end;
    {
    if UserCastle.m_nTotalGold >= g_Config.nRepairDoorPrice then begin
      if UserCastle.RepairDoor then begin
        Dec(UserCastle.m_nTotalGold,g_Config.nRepairDoorPrice);
        PlayObject.SysMsg('修理成功。',c_Green,t_Hint);
      end else begin
        PlayObject.SysMsg('城门不需要修理！！！',c_Green,t_Hint);
      end;
    end else begin
      PlayObject.SysMsg('城内资金不足！！！',c_Red,t_Hint);
    end;
    }
  except
    MainOutMessage('[Exception] TCastleOfficial.RepairDoor');
  end;
end;

procedure TCastleOfficial.RepairWallNow(nWallIndex: Integer;
  PlayObject: TPlayObject); //004A4074
begin
  try
    if m_Castle = nil then
    begin
      PlayObject.SysMsg('NPC不属于城堡！！！', c_Red, t_Hint);
      exit;
    end;

    if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nRepairWallPrice then
    begin
      if TUserCastle(m_Castle).RepairWall(nWallIndex) then
      begin
        Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nRepairWallPrice);
        PlayObject.SysMsg('修理成功。', c_Green, t_Hint);
      end
      else
      begin
        PlayObject.SysMsg('城墙不能修理！！！', c_Green, t_Hint);
      end;
    end
    else
    begin
      PlayObject.SysMsg('城内资金不足！！！', c_Red, t_Hint);
    end;
    {
    if UserCastle.m_nTotalGold >= g_Config.nRepairWallPrice then begin
      if UserCastle.RepairWall(nWallIndex) then begin
        Dec(UserCastle.m_nTotalGold,g_Config.nRepairWallPrice);
        PlayObject.SysMsg('修理成功。',c_Green,t_Hint);
      end else begin
        PlayObject.SysMsg('城门不需要修理！！！',c_Green,t_Hint);
      end;
    end else begin
      PlayObject.SysMsg('城内资金不足！！！',c_Red,t_Hint);
    end;
    }
  except
    MainOutMessage('[Exception] TCastleOfficial.RepairWallNow');
  end;
end;

constructor TCastleOfficial.Create;
begin
  try
    inherited;

  except
    MainOutMessage('[Exception] TCastleOfficial.Create');
  end;
end;

destructor TCastleOfficial.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TCastleOfficial.Destroy');
  end;
end;

constructor TGuildOfficial.Create;
begin
  try
    inherited;
    m_btRaceImg := RCC_MERCHANT;
    m_wAppr := 8;
  except
    MainOutMessage('[Exception] TGuildOfficial.Create');
  end;
end;

destructor TGuildOfficial.Destroy;
begin
  try

    inherited;
  except
    MainOutMessage('[Exception] TGuildOfficial.Destroy');
  end;
end;

procedure TGuildOfficial.SendCustemMsg(PlayObject: TPlayObject;
  sMsg: string);
begin
  try
    inherited;

  except
    MainOutMessage('[Exception] TGuildOfficial.SendCustemMsg');
  end;
end;

procedure TCastleOfficial.SendCustemMsg(PlayObject: TPlayObject;
  sMsg: string);
begin
  try
    if not g_Config.boSubkMasterSendMsg then
    begin
      PlayObject.SysMsg(g_sSubkMasterMsgCanNotUseNowMsg, c_Red, t_Hint);
      exit;
    end;
    if PlayObject.m_boSendMsgFlag then
    begin
      PlayObject.m_boSendMsgFlag := False;
      UserEngine.SendBroadCastMsg(PlayObject.m_sCharName + ': ' + sMsg,
        t_Castle);
    end
    else
    begin

    end;
  except
    MainOutMessage('[Exception] TCastleOfficial.SendCustemMsg');
  end;
end;

end.

