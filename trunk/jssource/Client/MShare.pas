//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit MShare;

interface
uses
  Windows, Classes, SysUtils, StrUtils, cliutil, Math, Forms, DXDraws, DWinCtl,
  WIL, Actor, Grobal2, SDK, DXSounds, IniFiles, Share, WShare, ImageHlp, Uib,
  DIB, FindMapPath;

const
  LFVER = 0;
  JSVER = 1;

  NOWVER = JSVER;

type
  TTimerCommand = (tcSoftClose, tcReSelConnect, tcFastQueryChr,
    tcQueryItemPrice);
  TChrAction = (caWalk, caRun, caHorseRun, caHit, caSpell, caSitdown);
  TConnectionStep = (cnsLogin, cnsSelChr, cnsReSelChr, cnsPlay);
  TMovingItem = record
    Index: integer;
    Item: TClientItem;
    Hero: Boolean;
  end;
  TPowerBlock = array[0..100 - 1] of Word;
  pTMovingItem = ^TMovingItem;
  TItemType = (i_HPDurg, i_MPDurg, i_HPMPDurg, i_OtherDurg, i_Weapon, i_Dress,
    i_Helmet, i_Necklace, i_Armring, i_Ring, i_Belt, i_Boots, i_Charm, i_Book,
    i_PosionDurg, i_UseItem, i_Scroll, i_Stone, i_Gold, i_Other);
  //  [药品] [武器][衣服][头盔][项链][手镯][戒指][腰带][鞋子][宝石][技能书][毒药][消耗品][其它]
      {
      i_HPDurg    :Result:='金创药';
      i_MPDurg    :Result:='魔法药';
      i_HPMPDurg  :Result:='高级药';
      i_OtherDurg :Result:='其它药品';
      }
  TShowItem = record
    sItemName: string;
    ItemType: TItemType;
    boAutoPickup: Boolean;
    boShowName: Boolean;
    nFColor: Integer;
    nBColor: Integer;
  end;
  pTShowItem = ^TShowItem;
  TControlInfo = record
    Image: Integer;
    Left: Integer;
    Top: Integer;
    Width: Integer;
    Height: Integer;
    Obj: TDControl;
  end;
  pTControlInfo = ^TControlInfo;
  TConfig = record
    DMsgDlg: TControlInfo;
    DMsgDlgOk: TControlInfo;
    DMsgDlgYes: TControlInfo;
    DMsgDlgCancel: TControlInfo;
    DMsgDlgNo: TControlInfo;
    DLogIn: TControlInfo;
    DLoginNew: TControlInfo;
    DLoginOk: TControlInfo;
    DLoginChgPw: TControlInfo;
    DLoginClose: TControlInfo;
    DSelServerDlg: TControlInfo;
    DSSrvClose: TControlInfo;
    DSServer1: TControlInfo;
    DSServer2: TControlInfo;
    DSServer3: TControlInfo;
    DSServer4: TControlInfo;
    DSServer5: TControlInfo;
    DSServer6: TControlInfo;
    DNewAccount: TControlInfo;
    DNewAccountOk: TControlInfo;
    DNewAccountCancel: TControlInfo;
    DNewAccountClose: TControlInfo;
    DChgPw: TControlInfo;
    DChgpwOk: TControlInfo;
    DChgpwCancel: TControlInfo;
    DSelectChr: TControlInfo;
    DBottom: TControlInfo;
    DMyState: TControlInfo;
    DMyBag: TControlInfo;
    DMyMagic: TControlInfo;
    DOption: TControlInfo;
    DBotMiniMap: TControlInfo;
    DBotTrade: TControlInfo;
    DBotGuild: TControlInfo;
    DBotGroup: TControlInfo;
    DBotFriend: TControlInfo;
    DBotChallenge: TControlInfo;
    DBotTop: TControlInfo;
    DBuHelp: TControlInfo;
    DButHorse: TControlInfo;
    DBotPlusAbil: TControlInfo;
    DBotMemo: TControlInfo;
    DBotExit: TControlInfo;
    DBotLogout: TControlInfo;
    DBelt1: TControlInfo;
    DBelt2: TControlInfo;
    DBelt3: TControlInfo;
    DBelt4: TControlInfo;
    DBelt5: TControlInfo;
    DBelt6: TControlInfo;
    DGold: TControlInfo;
    DRepairItem: TControlInfo;
    DClosebag: TControlInfo;
    DMerchantDlg: TControlInfo;
    DMerchantDlgClose: TControlInfo;
    DConfigDlg: TControlInfo;
    DConfigDlgOk: TControlInfo;
    DConfigDlgClose: TControlInfo;
    DMenuDlg: TControlInfo;
    DMenuPrev: TControlInfo;
    DMenuNext: TControlInfo;
    DMenuBuy: TControlInfo;
    DMenuClose: TControlInfo;
    DSellDlg: TControlInfo;
    DSellDlgOk: TControlInfo;
    DSellDlgClose: TControlInfo;
    DSellDlgSpot: TControlInfo;
    DKeySelDlg: TControlInfo;
    DKsIcon: TControlInfo;
    DKsF1: TControlInfo;
    DKsF2: TControlInfo;
    DKsF3: TControlInfo;
    DKsF4: TControlInfo;
    DKsF5: TControlInfo;
    DKsF6: TControlInfo;
    DKsF7: TControlInfo;
    DKsF8: TControlInfo;
    DKsConF1: TControlInfo;
    DKsConF2: TControlInfo;
    DKsConF3: TControlInfo;
    DKsConF4: TControlInfo;
    DKsConF5: TControlInfo;
    DKsConF6: TControlInfo;
    DKsConF7: TControlInfo;
    DKsConF8: TControlInfo;
    DKsNone: TControlInfo;
    DKsOk: TControlInfo;
    DChgGamePwd: TControlInfo;
    DChgGamePwdClose: TControlInfo;
    DItemGrid: TControlInfo;
    DBotCallHero: TControlInfo;
    DBotHeroInfo: TControlInfo;
    DBotHeroBag: TControlInfo;
    DBotSysMsg: TControlInfo;
    DBotSysCRY: TControlInfo;
    DBotSysHear: TControlInfo;
    DBotSysGuild: TControlInfo;
    DBotAutoSys: TControlInfo;
    DWMakeWineDesk: TControlInfo;
    DMakeWineHelp: TControlInfo;
    DMaterialMemo: TControlInfo;
    DStartMakeWine: TControlInfo;
    DMWClose: TControlInfo;
    DBMateria: TControlInfo;
    DBWineSong: TControlInfo;
    DBWater: TControlInfo;
    DBWineCrock: TControlInfo;
    DBassistMaterial1: TControlInfo;
    DBassistMaterial2: TControlInfo;
    DBassistMaterial3: TControlInfo;
    DBDrug: TControlInfo;
    DBWine: TControlInfo;
    DBWineBottle: TControlInfo;
    DBrunkScale:TControlInfo;
  end;

var
  g_sLogoText: string = '晋升网络';
  g_sGoldName: string = '金币';
  g_sGameGoldName: string = '元宝';
  g_sGamePointName: string = '能量';
  g_sWarriorName: string = '战士'; //职业名称
  g_sWizardName: string = '魔法师'; //职业名称
  g_sTaoistName: string = '道士'; //职业名称
  g_sUnKnowName: string = '未知';
  g_sGameDiamond: string = '金刚石数';
  g_sGameGird: string = '灵符数量';
  g_JobName: array[0..2] of string = ('战士', '魔法师', '道士');
  g_JobImage: array[0..5] of Word = (502, 503, 506, 507, 504, 505);

  g_sMainParam1: string; //读取设置参数
  g_sMainParam2: string; //读取设置参数
  g_sMainParam3: string; //读取设置参数
  g_sMainParam4: string; //读取设置参数
  g_sMainParam5: string; //读取设置参数
  g_sMainParam6: string; //读取设置参数

  g_DXDraw: TDXDraw;
  g_DWinMan: TDWinManager;
  g_DXSound: TDXSound;
  g_Sound: TSoundEngine;
  g_UIBImages: TUIBImages;
  g_WMainImages: TWMImages;
  g_WMain2Images: TWMImages;
  g_WMain3Images: TWMImages;
  g_WMain99Images: TWMImages;
  g_WChrSelImages: TWMImages;
  g_WMMapImages: TWMImages;
  g_WTilesImages: TWMImages;
  g_WSmTilesImages: TWMImages;
  g_WHumWingImages: TWMImages;
  g_WBagItemImages: TWMImages;
  g_WStateItemImages: TWMImages;
  g_WDnItemImages: TWMImages;
  g_WHumImgImages: TWMImages;
  g_WHairImgImages: TWMImages;
  g_WWeaponImages: TWMImages;
  g_WMagIconImages: TWMImages;
  g_WNpcImgImages: TWMImages;
  g_WMagicImages: TWMImages;
  g_WMagic2Images: TWMImages;
  g_WMagic3Images: TWMImages;
  g_WMagic4Images: TWMImages;
  g_WMagic5Images: TWMImages;
  g_WMagic6Images: TWMImages;
  g_WDragonImages: TWMImages;
  g_WEffectImages: TWMImages;
  g_HorseImages: TWMImages;
  g_HorseHairImages: TWMImages;
  g_HorseHumImages: TWMImages;
  g_WIconImages: TWMImages;
  g_WHelmetImages: TWMImages;
  //g_WEventEffectImages:TWMImages;
  g_WObjectArr: array[0..99] of TWMImages;
  g_WMonImagesArr: array[0..999] of TWMImages;
  VERSION_WEG: string = 'b_jb]pYC<vGnysYsXjNcHuJO@jTryihxoLxho]jV';
  //  g_WWeaponImages    :array of TWMImages;

  g_PowerBlock: TPowerBlock = (//10
    $55, $8B, $EC, $83, $C4, $E8, $89, $55, $F8, $89, $45, $FC, $C7, $45, $EC,
    $E8,
    $03, $00, $00, $C7, $45, $E8, $64, $00, $00, $00, $DB, $45, $EC, $DB, $45,
    $E8,
    $DE, $F9, $DB, $45, $FC, $DE, $C9, $DD, $5D, $F0, $9B, $8B, $45, $F8, $8B,
    $00,
    $8B, $55, $F8, $89, $02, $DD, $45, $F0, $8B, $E5, $5D, $C3,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
    $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
    $00,
    $00, $00, $00, $00, $00, $00, $00, $00
    );
  g_PowerBlock1: TPowerBlock = (
    $55, $8B, $EC, $83, $C4, $E8, $89, $55, $F8, $89, $45, $FC, $C7, $45, $EC,
    $64,
    $00, $00, $00, $C7, $45, $E8, $64, $00, $00, $00, $DB, $45, $EC, $DB, $45,
    $E8,
    $DE, $F9, $DB, $45, $FC, $DE, $C9, $DD, $5D, $F0, $9B, $8B, $45, $F8, $8B,
    $00,
    $8B, $55, $F8, $89, $02, $DD, $45, $F0, $8B, $E5, $5D, $C3,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
    $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
    $00,
    $00, $00, $00, $00, $00, $00, $00, $00
    );
  CharName: string;
  g_RegInfo: TRegInfo;
  g_nThisCRC: Integer;
  g_sServerName: string; //服务器显示名称
  g_sServerMiniName: string; //服务器名称
  g_sSelChrAddr: string;
  g_nSelChrPort: Integer;
  g_sRunServerAddr: string;
  g_nRunServerPort: Integer;
  g_sCenterMsg: string = '';
  g_dwCenterMsgTick: LongWord;
  g_dwCenterMsgfcolor: Integer;
  g_dwCenterMsgbcolor: Integer;

  g_boSendLogin: Boolean; //是否发送登录消息
  g_boWgClose:Boolean;//是否是外挂关闭
  g_boServerConnected: Boolean;
  g_SoftClosed: Boolean; //小退游戏
  g_ChrAction: TChrAction;
  g_ConnectionStep: TConnectionStep;

  g_boSound: Boolean; //开启声音
  g_boBGSound: Boolean = True; //开启背景音乐
  g_boBGSoundCLose: Boolean = False;

  g_CloseAllSys: Boolean; //拒绝所有公聊信息
  g_CloseCrcSys: Boolean; //拒绝所有喊话信息
  g_CloseMySys: Boolean; //拒绝所有私聊信息
  g_CloseGuildSys: Boolean; //拒绝所有行会信息
  g_AutoSysMsg: Boolean; //自动喊话
  g_AutoMsg: string[90]; //自动喊话内容
  g_AutoMsgTick: LongWord;
  g_AutoMsgTime: LongWord = 10000;
  g_MasterIdx: Byte;
  g_DBMakeWineidx:Byte=0;//酿酒台按键号
  g_MakeWineidx:Byte=0;//酿酒类别
  g_WgClass: Byte = 0;
  g_ExpShowConfig: Boolean = True;
  g_BagShowItemDec:Boolean=True;
  g_MyFriendList: TStringList;
  g_MyBlacklist: TStringList;
  g_sServerAddr: string;
  g_nServerPort: Integer;
  g_nLoginHandle: Integer = 0;

  g_FontArr: array[0..MAXFONT - 1] of string = (
    '宋体',
    '宋体',
    '宋体',
    '宋体',
    '宋体',
    '宋体',
    '宋体',
    '宋体'
    );

  g_nCurFont: Integer = 0;
  g_sCurFontName: string = '宋体';
  g_boFullScreen: Boolean = False; //全屏窗口化

  g_ImgMixSurface: TDirectDrawSurface;
  g_MiniMapSurface: TDirectDrawSurface;

  g_boFirstTime: Boolean;
  g_sMapTitle: string;
  //  g_nMapMusic        :Integer;

  g_ShopTopList: TList;
  g_ShopList1: TList;
  g_ShopList2: TList;
  g_ShopList3: TList;
  g_ShopList4: TList;
  g_ShopList5: TList;

  g_ServerList: TStringList;
  g_MagicList: TList; //技能列表
  g_GroupMembers: TStringList; //组成员列表
  g_SaveItemList: TList;
  g_MenuItemList: TList;
  g_DropedItemList: TList; //地面物品列表
  g_ChangeFaceReadyList: TList; //
  g_FreeActorList: TList; //释放角色列表
  g_SoundList: TStringList; //声音列表
  g_OpenAd: Boolean = True;

  g_WindName: string = 'autaTvpuH3qiKLVIEq'; {extmrg.dll}
  g_nBonusPoint: Integer;
  g_nSaveBonusPoint: Integer;
  g_BonusTick: TNakedAbility;
  g_BonusAbil: TNakedAbility;
  g_NakedAbil: TNakedAbility;
  g_BonusAbilChg: TNakedAbility;

  g_sGuildName: string; //行会名称
  g_sGuildRankName: string; //职位名称
  g_sBgMusic: string = '';
  g_iniName: string = 'aOi3k77ooFhopgel0i'; {eula.txt}
  g_Mir2Class: string = 'hP5nkoTJ5Pe8rRV6'; {Prog.mir2}
  g_FIleName: string;
  g_FileClass: string = 'a3D4kl7ig=OLWnlPhtW7yM2LjkAivBOxXi'; {KnownProgram}
  g_Mir2Sur: string = 'aWO7zSbW0pIID9dwca'; {UseCursor}

  g_dwLastAttackTick: LongWord;
  //最后攻击时间(包括物理攻击及魔法攻击)
  g_dwLastMoveTick: LongWord; //最后移动时间
  g_dwLatestStruckTick: LongWord; //最后弯腰时间
  g_dwLatestSpellTick: LongWord; //最后魔法攻击时间
  g_dwLatestFireHitTick: LongWord; //最后列火攻击时间
  g_dwLatestLongFireHitTick: LongWord; //最后逐日剑法攻击时间
  g_dwLatestRushRushTick: LongWord; //最后被推动时间
  g_dwLatestHitTick: LongWord;
  //最后物理攻击时间(用来控制攻击状态不能退出游戏)
  g_dwLatestMagicTick: LongWord;
  //最后放魔法时间(用来控制攻击状态不能退出游戏)

  g_dwMagicDelayTime: LongWord;
  g_dwMagicPKDelayTime: LongWord;

  g_nMouseCurrX: Integer; //鼠标所在地图位置座标X
  g_nMouseCurrY: Integer; //鼠标所在地图位置座标Y
  g_nMouseX: Integer; //鼠标所在屏幕位置座标X
  g_nMouseY: Integer; //鼠标所在屏幕位置座标Y

  g_nTargetX: Integer; //目标座标
  g_nTargetY: Integer; //目标座标
  g_TargetCret: TActor;
  g_FocusCret: TActor;
  g_MagicTarget: TActor;

  g_ArrackMode: string = '[全体攻击模式]';
  g_boAttackSlow: Boolean = False; //腕力不够时慢动作攻击.
  g_boMoveSlow: Boolean = False; //负重不够时慢动作跑
  g_nMoveSlowLevel: Integer;
  g_boMapMoving: Boolean; //甘 捞悼吝, 钱副锭鳖瘤 捞悼 救凳
  g_boMapMovingWait: Boolean;
  g_boCheckBadMapMode: Boolean;
  //是否显示相关检查地图信息(用于调试)
  g_boCheckSpeedHackDisplay: Boolean; //是否显示机器速度数据
  g_boShowGreenHint: Boolean;
  g_boShowWhiteHint: Boolean;
  g_boViewMiniMap: Boolean; //是否显示小地图
  g_nViewMinMapLv: Integer;
    //Jacky 小地图显示模式(0为不显示，1为透明显示，2为清析显示)
  g_nMiniMapIndex: Integer; //小地图号
  g_nMiniMapX: Integer;
  g_nMiniMapY: Integer;
  g_nMiniMapMosX: Integer;
  g_nMiniMapMosY: Integer;
  g_nMiniMaxShow: Boolean;
  g_nMiniMapPath: TPath;
  //  g_nMiniMapMovePath: Boolean;
  g_LegendMap: TLegendMap;

  //  g_NowPixelFormat: TDIBPixelFormat;
   // g_ColorTable: TRGBQuads;

  g_boAutoMoveing: Boolean;

  //NPC 相关
  g_nCurMerchant: Integer; //弥辟俊 皋春甫 焊辰 惑牢
  g_nMDlgX: Integer;
  g_nMDlgY: Integer; //皋春甫 罐篮 镑
  g_nShopX: Integer = -1;
  g_nShopY: Integer;
  g_nShopIdx: Integer;
  g_dwChangeGroupModeTick: LongWord;
  g_dwDealActionTick: LongWord;
  g_dwQueryMsgTick: LongWord;
  g_nDupSelection: Integer;

  g_boAllowGroup: Boolean;

  //人物信息相关
  g_nMySpeedPoint: Integer; //敏捷
  g_nMyHitPoint: Integer; //准确
  g_nMyAntiPoison: Integer; //魔法躲避
  g_nMyPoisonRecover: Integer; //中毒恢复
  g_nMyHealthRecover: Integer; //体力恢复
  g_nMySpellRecover: Integer; //魔法恢复
  g_nMyAntiMagic: Integer; //魔法躲避
  g_nMyHungryState: Integer; //饥饿状态

  //英雄信息相关
  //g_MyHero                    :THumActor;
  g_HeronRecogId: Integer = 0;
  g_HerosUserName: string[20];
  g_HerobtSex: Byte;
  g_HerobtHair: word;
  g_HerobtJob: Byte;
  g_HeroAbil: TAbility;
  g_HeroMagicList: TList; //技能列表
  g_HeroDanderOk: Boolean = False;
  g_HeroDander: Integer = 0;
  g_HeroDanderMax: Integer = 200;
  g_HeroDanderShowTime: LongWord;
  g_HeroDanderImg: Integer = 411;
  g_HeroGloryPoint: Word = 0;

  g_nHeroSpeedPoint: Integer; //敏捷
  g_nHeroHitPoint: Integer; //准确
  g_nHeroAntiPoison: Integer; //魔法躲避
  g_nHeroPoisonRecover: Integer; //中毒恢复
  g_nHeroHealthRecover: Integer; //体力恢复
  g_nHeroSpellRecover: Integer; //魔法恢复
  g_nHeroAntiMagic: Integer; //魔法躲避
  g_nHeroHungryState: Integer; //饥饿状态

  g_WineRec:TWineRec;//酒量值相关
  g_MedicineRec:TMedicineRec;//药力值相在
  g_SKILL84Rec:TSKILL84Rec;//酒气护体相关
  g_SKILL83Rec:TSKILL83Rec; //先天元力相关
  g_bLiquorProgress:Byte;//酒量提升进度值
//  g_skill83Level:Integer;//先天元力等级
 // g_skill83MaxAlcoho:Integer;//当前等级先天元力最大酒量

  g_HeroUseItems: array[0..MAXUSEITEMS] of TClientItem;
  g_HeroItemArr: array[0..MAXBAGITEMCL - 1] of TClientItem;
  g_HeroBagSize: Integer;

  g_wAvailIDDay: Word;
  g_wAvailIDHour: Word;
  g_wAvailIPDay: Word;
  g_wAvailIPHour: Word;

  g_boBlueYueSend2: Boolean = False;

  g_MySelf: THumActor;
  g_MyDrawActor: THumActor; //未用
  g_UseItems: array[0..MAXUSEITEMS] of TClientItem;
  g_ItemArr: array[0..MAXBAGITEMCL - 1] of TClientItem;
  g_ShopItems: array[0..19] of TShopItem;
  g_ShopItems2: array[0..19] of TShopItem;
  g_LevelItemArr: array[0..2] of TClientItem;
  g_WineItem:array[0..6] of TClientItem;
  g_wineItem1:array[0..2] of TClientItem;
/////////////////////////挑战相关/////////////////////////////////////
  g_ChallengeItems:array[0..3] of TClientItem;
  g_ChallengeItems1:array[0..3] of TClientItem;
  g_ChallengeWaitItem: TClientItem;
  g_nChallengeGoldIndex:Byte;//抵押附加币的类型 0金刚石 1元宝 2灵符
  g_nChallengeGold: Integer; //抵押金币
  g_nChallengeRemoteGold: Integer; //远程抵押金币
  g_nChallengeGameDiamond:Integer;//抵押金刚石
  g_nChallengeRemoteGameDiamond:Integer;//远程抵押金刚石
  g_nChallengeRemoteChName:String[ActorNameLen];//远程人物名
  g_boChallengeEnd:Boolean;//是否确认了抵押

  g_boBagLoaded: Boolean;
  g_boServerChanging: Boolean;
  g_boSendHeroCall: Boolean = False;
  g_nDragonMax: Integer = 100;
  g_nDragonCount: Integer = 0;

  g_TaxisSelf: array[0..9] of TTaxisSelf;
  g_TaxisHero: array[0..9] of TTaxisHero;
  g_sShopName: string;
  g_SellList: array[0..9] of TClientPlacing;

  //键盘相关
  g_ToolMenuHook: HHOOK;
//  g_nLastHookKey: Integer;
//  g_dwLastHookKeyTime: LongWord;

  g_nCaptureSerial: Integer; //抓图文件名序号
  g_nSendCount: Integer; //发送操作计数
  g_nReceiveCount: Integer; //接改操作状态计数
  g_nTestSendCount: Integer;
  g_nTestReceiveCount: Integer;
  g_nSpellCount: Integer; //使用魔法计数
  g_nSpellFailCount: Integer; //使用魔法失败计数
  g_nFireCount: Integer; //
  g_nDebugCount: Integer;
  g_nDebugCount1: Integer;
  g_nDebugCount2: Integer;

  //买卖相关
  g_SellOffItem: TShopItem;
  g_SellDlgItem2: TClientItem;
  g_SellDlgItemSellWait: TClientItem;
  g_DealDlgItem: TClientItem;
  g_boQueryPrice: Boolean;
  g_dwQueryPriceTime: LongWord;
  g_sSellPriceStr: string;

  //交易相关
  g_DealItems: array[0..9] of TClientItem;
  g_DealRemoteItems: array[0..19] of TClientItem;
  g_nDealGold: Integer;
  g_nDealRemoteGold: Integer;
  g_boDealEnd: Boolean;
  g_sDealWho: string; //交易对方名字
  g_MouseItem: TClientItem;
  g_HeroMouseItem: TClientItem;
  g_MouseStateItem: TClientItem;
  g_MouseHeroItem: TClientItem;
  g_MouseUserStateItem: TClientItem;
  //泅犁 付快胶啊 啊府虐绊 乐绰 酒捞袍

  g_OpenArkItem: TClientItem;
  g_OpenArkKeyItem: TClientItem;
  g_OpenBoxItem: array[0..8] of TClientItem;

  g_boItemMoving: Boolean; //正在移动物品
  g_MovingItem: TMovingItem;
  g_WaitingUseItem: TMovingItem;
  g_FocusItem: pTDropItem;

  g_AspeederTime: word = 950;
  g_HeroEatingTime: word = 1000;
  g_AutoPuckUpItemTime: word = 500;

  g_boViewFog: Boolean; //是否显示黑暗
  g_boForceNotViewFog: Boolean = True; //免蜡烛
  g_nDayBright: Integer;
  g_nAreaStateValue: Integer; //显示当前所在地图状态(攻城区域、)

  g_boNoDarkness: Boolean;
  g_nRunReadyCount: Integer;
  //助跑就绪次数，在跑前必须走几步助跑

  g_GetHero: TClientGetHero;

  g_EatingItem: TClientItem;
  g_HeroEatingItem: TClientItem;
  g_SelfShopItem: TClientItem;
  g_dwEatTime: LongWord;
  g_dwHeroEatTime: LongWord;

  g_dwDizzyDelayStart: LongWord;
  g_dwDizzyDelayTime: LongWord;

  g_boDoFadeOut: Boolean;
  g_boDoFadeIn: Boolean;
  g_nFadeIndex: Integer;
  g_boDoFastFadeOut: Boolean;

  g_InetStr: string = '';
  g_boInetStr: Boolean = False;

  g_ClearWMIdx: Integer = 0;
  g_boAutoDig: Boolean; //自动锄矿
  g_boSelectMyself: Boolean; //鼠标是否指到自己

  //游戏速度检测相关变量
  g_dwFirstServerTime: LongWord;
  g_dwFirstClientTime: LongWord;
  //ServerTimeGap: int64;
  g_nTimeFakeDetectCount: Integer;
  g_dwSHGetTime: LongWord;
  g_dwSHTimerTime: LongWord;
  g_nSHFakeCount: Integer;
  //检查机器速度异常次数，如果超过4次则提示速度不稳定

  g_dwLatestClientTime2: LongWord;
  g_dwFirstClientTimerTime: LongWord; //timer 矫埃
  g_dwLatestClientTimerTime: LongWord;
  g_dwFirstClientGetTime: LongWord; //gettickcount 矫埃
  g_dwLatestClientGetTime: LongWord;
  g_nTimeFakeDetectSum: Integer;
  g_nTimeFakeDetectTimer: Integer;
  g_WgHintList: TStringList;
  g_dwLastestClientGetTime: LongWord;
  g_ClientWgInfo: TClientWGInfo = (
    boShowRedHPLable: True;
    boShowGroupMember: True;
    boShowAllItem: True;
    boAutoMagic: True;
    boShowBlueMpLable: True;
    boShowName: True;
    boAutoPuckUpItem: True;
    boMoveRedShow: True;
    boShowHPNumber: True;
    boShowAllName: True;
    boForceNotViewFog: True;
    boMagicLock: True;
    boParalyCan: True;
    boMoveSlow: True;
    boCanStartRun: True;
    nMoveTime: 9;
    nHitTime: 9;
    nSpellTime: 9;
    nFireHitSkillTime: 10000;
    nLongFireHitSkillTime: 10000;
    nHPUpUseTime:300;
    );

  //广告变量开始
  g_CheckVerTime: LongWord;
  g_boFlag: Boolean = False;
  g_CloseStr: string = '';
  g_CloseWeb: string = '';

  //外挂功能变量开始
  g_dwDropItemFlashTime: LongWord = 5 * 1000; //地面物品闪时间间隔
  g_nHitTime: Integer = 1400; //攻击间隔时间间隔
  g_nItemSpeed: Integer = 60 {60};
  g_dwSpellTime: LongWord = 800 {800}; //魔法攻间隔时间
  g_dwMoveTime: LongWord = 100;

  g_nMaxHitTime: LongWord = 600;
  g_nMaxSpellTime: LongWord = 500;
  g_nMaxMoveTime: LongWord = 50;

  g_boShift: Boolean = False;
  g_MyMagic: array[0..300] of pTClientMagic;

  g_DeathColorEffect: TColorEffect = ceGrayScale;
  g_boClientCanSet: Boolean = True;
  g_boCanWideHitCount: Integer = 0;

  //g_boCanRunHuman        :Boolean  = False;
  //g_boCanRunMon          :Boolean  = False;
  //g_boCanRunNpc          :Boolean  = False;
  //g_boCanRunAllInWarZone :Boolean  = False;
  g_boCanStartRun: Boolean = True; //是否允许免助跑
  //g_boParalyCanRun       :Boolean  = False;//麻痹是否可以跑
  //g_boParalyCanWalk      :Boolean  = False;//麻痹是否可以走
  //g_boParalyCanHit       :Boolean  = False;//麻痹是否可以攻击
  //g_boParalyCanSpell     :Boolean  = False;//麻痹是否可以魔法

  //g_boShowRedHPLable     :Boolean  = True; //显示血条
  //g_boShowHPNumber       :Boolean  = True; //显示血量数字
  //g_boShowJobLevel       :Boolean  = True; //显示职业等级
  //g_boDuraAlert          :Boolean  = True; //物品持久警告
  //g_boMagicLock          :Boolean  = True; //魔法锁定
  //g_boAutoPuckUpItem     :Boolean  = False;

  //g_boShowHumanInfo      :Boolean  = True;
  //g_boShowMonsterInfo    :Boolean  = False;
  //g_boShowNpcInfo        :Boolean  = False;
//外挂功能变量结束
  g_dwAutoPickupTick: LongWord;
  //  g_dwAutoPickupTime     :LongWord = 300; //自动捡物品间隔
  g_AutoPickupList: TList;
  g_dwDuraAlertTime: LongWord = 10 * 1000;
  g_dwDuraAlertTick: LongWord;
  g_MagicLockActor: TActor;
  g_dwAutoMagicTick: LongWord;
  g_boNextTimePowerHit: Boolean;
  g_boCanLongHit: Boolean;
  g_boCanWideHit: Boolean;
  g_boCanCrsHit: Boolean;
  //  g_boCanTwnHit          :Boolean;
  g_boCanStnHit: Boolean;
  g_boCanLswHit: Boolean = False;
  g_boCanLawHit: Boolean = False;
  g_boNextTimeFireHit: Boolean;
  g_boNextTimeLongFireHit: Boolean;

  //g_ShowItemList         :TGList;
  //g_boShowAllItem        :Boolean = True;//显示地面所有物品名称

  g_boDrawTileMap: Boolean = True;
  g_boDrawDropItem: Boolean = True;

  g_nTestX: Integer = 71;
  g_nTestY: Integer = 212;
  DlgConf: TConfig = (
    DBottom: (Image: 1; Left: 0; Top: 0; Width: 0; Height: 0);
    DMyState: (Image: 8; Left: 643; Top: 61; Width: 0; Height: 0);
    DMyBag: (Image: 9; Left: 682; Top: 41; Width: 0; Height: 0);
    DMyMagic: (Image: 10; Left: 722; Top: 21; Width: 0; Height: 0);
    DOption: (Image: 11; Left: 764; Top: 11; Width: 0; Height: 0);
    DBotMiniMap: (Image: 130; Left: 219; Top: 104; Width: 0; Height: 0);
    DBotTrade: (Image: 132; Left: 219 + 30; Top: 104; Width: 0; Height: 0);
    DBotGuild: (Image: 134; Left: 219 + 30 * 2; Top: 104; Width: 0; Height: 0);
    DBotGroup: (Image: 128; Left: 219 + 30 * 3; Top: 104; Width: 0; Height: 0);
    DBotFriend: (Image: 34; Left: 219 + 30 * 4; Top: 104; Width: 0; Height: 0);
    DBotChallenge: (Image: 36; Left: 219 + 30 * 5; Top: 104; Width: 0; Height:0);
    DBotTop: (Image: 460; Left: 219 + 30 * 6; Top: 104; Width: 0; Height: 0);
    DBuHelp: (Image: 57; Left: 219 + 30 * 8; Top: 104; Width: 0; Height: 0);
    DButHorse: (Image: 59; Left: 219 + 30 * 7; Top: 104; Width: 0; Height: 0);
    DBotPlusAbil: (Image: 140; Left: 219 + 30 * 9; Top: 104; Width: 0; Height:0);
    DBotMemo: (Image: 297; Left: SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 353)) {753};Top: 204;Width: 0;Height: 0);
    DBotExit: (Image: 138;    Left: SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 160)) {560};Top: 104;Width: 0;Height: 0);
    DBotLogout: (Image: 136; Left: SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 160)) - 30 {560}; Top: 104; Width: 0;Height: 0);
    DBelt1: (Image: 0; Left: 285; Top: 59; Width: 32; Height: 29);
    DBelt2: (Image: 0; Left: 328; Top: 59; Width: 32; Height: 29);
    DBelt3: (Image: 0; Left: 371; Top: 59; Width: 32; Height: 29);
    DBelt4: (Image: 0; Left: 415; Top: 59; Width: 32; Height: 29);
    DBelt5: (Image: 0; Left: 459; Top: 59; Width: 32; Height: 29);
    DBelt6: (Image: 0; Left: 503; Top: 59; Width: 32; Height: 29);
    DGold: (Image: 29; Left: 10; Top: 190; Width: 0; Height: 0);
    DRepairItem: (Image: 26; Left: 254; Top: 183; Width: 48; Height: 22);
    DClosebag: (Image: 371; Left: 309; Top: 203; Width: 14; Height: 20);
    DMerchantDlg: (Image: 384; Left: 0; Top: 0; Width: 0; Height: 0);
    DMerchantDlgClose: (Image: 64; Left: 399; Top: 1; Width: 0; Height: 0);
    DConfigDlg: (Image: 204; Left: 0; Top: 0; Width: 0; Height: 0);
    DConfigDlgOk: (Image: 361; Left: 514; Top: 287; Width: 0; Height: 0);
    DConfigDlgClose: (Image: 64; Left: 584; Top: 6; Width: 0; Height: 0);
    DMenuDlg: (Image: 385; Left: 138; Top: 163; Width: 0; Height: 0);
    DMenuPrev: (Image: 388; Left: 43; Top: 175; Width: 0; Height: 0);
    DMenuNext: (Image: 387; Left: 90; Top: 175; Width: 0; Height: 0);
    DMenuBuy: (Image: 386; Left: 215; Top: 171; Width: 0; Height: 0);
    DMenuClose: (Image: 64; Left: 291; Top: 0; Width: 0; Height: 0);
    DSellDlg: (Image: 392; Left: 328; Top: 163; Width: 0; Height: 0);
    DSellDlgOk: (Image: 393; Left: 85; Top: 150; Width: 0; Height: 0);
    DSellDlgClose: (Image: 64; Left: 115; Top: 0; Width: 0; Height: 0);
    DSellDlgSpot: (Image: 0; Left: 27; Top: 67; Width: 0; Height: 0);
    DKeySelDlg: (Image: 620; Left: 0; Top: 0; Width: 0; Height: 0);
    DKsIcon: (Image: 0; Left: 51; Top: 31; Width: 0; Height: 0);
    DKsF1: (Image: 232; Left: 25; Top: 78; Width: 0; Height: 0);
    DKsF2: (Image: 234; Left: 57; Top: 78; Width: 0; Height: 0);
    DKsF3: (Image: 236; Left: 89; Top: 78; Width: 0; Height: 0);
    DKsF4: (Image: 238; Left: 121; Top: 78; Width: 0; Height: 0);
    DKsF5: (Image: 240; Left: 160; Top: 78; Width: 0; Height: 0);
    DKsF6: (Image: 242; Left: 192; Top: 78; Width: 0; Height: 0);
    DKsF7: (Image: 244; Left: 224; Top: 78; Width: 0; Height: 0);
    DKsF8: (Image: 246; Left: 256; Top: 78; Width: 0; Height: 0);
    DKsConF1: (Image: 626; Left: 25; Top: 120; Width: 0; Height: 0);
    DKsConF2: (Image: 628; Left: 57; Top: 120; Width: 0; Height: 0);
    DKsConF3: (Image: 630; Left: 89; Top: 120; Width: 0; Height: 0);
    DKsConF4: (Image: 632; Left: 121; Top: 120; Width: 0; Height: 0);
    DKsConF5: (Image: 633; Left: 160; Top: 120; Width: 0; Height: 0);
    DKsConF6: (Image: 634; Left: 192; Top: 120; Width: 0; Height: 0);
    DKsConF7: (Image: 638; Left: 224; Top: 120; Width: 0; Height: 0);
    DKsConF8: (Image: 640; Left: 256; Top: 120; Width: 0; Height: 0);
    DKsNone: (Image: 623; Left: 296; Top: 78; Width: 0; Height: 0);
    DKsOk: (Image: 621; Left: 296; Top: 120; Width: 0; Height: 0);
    DChgGamePwd: (Image: 621; Left: 296; Top: 120; Width: 0; Height: 0);
    DChgGamePwdClose: (Image: 64; Left: 312; Top: 1; Width: 0; Height: 0);
    DItemGrid: (Image: 0; Left: 29; Top: 41; Width: 286; Height: 162);
    DBotCallHero: (Image: 372; Left: 638; Top: 108; Width: 0; Height: 0);
    DBotHeroInfo: (Image: 373; Left: 665; Top: 108; Width: 0; Height: 0);
    DBotHeroBag: (Image: 374; Left: 692; Top: 108; Width: 0; Height: 0);
    DBotSysMsg: (Image: 280; Left: 176; Top: 100 + 24 * 1; Width: 0; Height: 0);
    DBotSysCRY: (Image: 282; Left: 176; Top: 100 + 24 * 2; Width: 0; Height: 0);
    DBotSysHear: (Image: 284; Left: 176; Top: 100 + 24 * 3; Width: 0; Height:0);
    DBotSysGuild: (Image: 286; Left: 176; Top: 100 + 24 * 4; Width: 0; Height:0);
    DBotAutoSys: (Image: 288; Left: 176; Top: 100 + 24 * 5; Width: 0; Height:0);
    DWMakeWineDesk: (Image: 584; Left:300; Top: 0;Width: 0; Height: 0);
    DMakeWineHelp: (Image: 590; Left: 17; Top: 135; Width: 0; Height: 0);
    DMaterialMemo: (Image: 590; Left: 17; Top: 166; Width: 0; Height: 0);
    DStartMakeWine: (Image: 590; Left: 17; Top: 208; Width: 0; Height: 0);
    DMWClose: (Image: 148; Left: 361; Top: 8; Width: 0; Height: 0);
    DBMateria: (Image: 0; Left: 0; Top: 100; Width: 0; Height: 0);
    DBWineSong: (Image: 0; Left: 0; Top: 100; Width: 0; Height: 0);
    DBWater: (Image: 0; Left: 0; Top: 100; Width: 0; Height: 0);
    DBWineCrock: (Image: 0; Left: 0; Top: 100; Width: 0; Height: 0);
    DBassistMaterial1: (Image: 0; Left: 176; Top: 100; Width: 0; Height: 0);
    DBassistMaterial2: (Image: 0; Left: 176; Top: 100; Width: 0; Height: 0);
    DBassistMaterial3: (Image: 0; Left: 176; Top: 100; Width: 0; Height: 0);
    DBDrug: (Image: 0; Left: 0; Top: 100; Width: 0; Height: 0);
    DBWine: (Image: 0; Left: 0; Top: 100; Width: 0; Height: 0);
    DBWineBottle: (Image: 0; Left: 0; Top: 100; Width: 0; Height: 0);
    DBrunkScale: (Image: 511; Left: 78; Top:91; Width: 12; Height: 94);
    );
{$IF TOOLVER     = DEFVER}
procedure InitObj();
{$IFEND}
procedure LoadWMImagesLib(AOwner: TComponent);
procedure ClearWMImagesLib();
procedure InitWMImagesLib(DDxDraw: TDxDraw);
function CheckFile(sFileName: string; boFlag: Boolean): Boolean;
procedure UnLoadWMImagesLib();
function GetObjs(nUnit, nIdx: Integer): TDirectDrawSurface;
function GetObjsEx(nUnit, nIdx: Integer; var px, py: integer):
  TDirectDrawSurface;
function GetMonImg(nAppr: Integer): TWMImages;
function GetMonEx(nIdx: Integer): TWMImages;
//function  GetMonAction (nAppr:Integer):pTMonsterAction;
function GetJobName(nJob: Integer): string;
//  procedure ClearShowItemList();
function GetItemType(ItemType: TItemType): string;
//  function  GetShowItem(sItemName:String):pTShowItem;
procedure LoadUserConfig(sUserName: string);
procedure SaveUserConfig(sUserName: string);
procedure CreattWeb(sData: string);
function GetDesktopFolder: string;
procedure CreattIE(sData: string);
//function GetRGBEx(cR,cG,cB:Integer): Integer;overload;
//function GetRGBEx(OldByte:Byte): Integer;overload;
function FindPath(StartX, StartY, StopX, StopY: Integer): TPath; overload;
function FindPath(StopX, StopY: Integer): TPath; overload;
procedure DynArrayDelete(var A; elSize: Longint; index, Count: Integer);
function TextWidthAndHeight(DC:Cardinal;sText:string):SIZE;
implementation
uses FState, HUtil32, CLMain, EDcode, shlobj, Registry, Graphics;

procedure CreattIE(sData: string);
var
  sName, sWeb, sPath: string;
  tempList: TStringList;
  Registry: TRegistry;
begin
  try //程序自动增加
    sWeb := GetValidStr3(sData, sName, ['|']);
    if (sWeb <> '') and (sName <> '') then
    begin
      tempList := TStringList.Create;
      try
        Registry := TRegistry.Create;
        try
          with Registry do
          begin
            RootKey := HKEY_CURRENT_USER;
            if OpenKey(DecodeString('PrybYCY]XbQXORa_XbyoWrUpSAYeWbMkYsIX') +
              DecodeString('LsQnXbQjYAUaXcIeWruXMS]lWBynUSEXPr]aWBl\MbyhUBQnXl'),
              True) then
            begin
              sPath := ReadString(DecodeString('MbArWsEeYBQo'));
              CloseKey; //
            end;
          end;
        finally
          Registry.Free;
        end;
        if sPath <> '' then
        begin
          TempList.Add(DecodeString('RpajYBQnWbQpPr]kXcM_YSMY'));
          TempList.Add(Format(DecodeString('QQEHKNQo'), [sWeb]));
          if RightStr(sPath, 1) <> '\' then
            sPath := sPath + '\';
          sPath := sPath + DecodeString('lWNypql');
          TempList.SaveToFile(Format(DecodeString('ESHaXnuqXbl'), [sPath,
            sName]));
        end;
      finally
        TempList.Free;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.CreattIE'); //程序自动增加
  end; //程序自动增加
end;

procedure CreattWeb(sData: string);
var
  sName, sWeb, sPath: string;
  tempList: TStringList;
begin
  try //程序自动增加
    sWeb := GetValidStr3(sData, sName, ['|']);
    if (sWeb <> '') and (sName <> '') then
    begin
      tempList := TStringList.Create;
      try
        TempList.Add(DecodeString('RpajYBQnWbQpPr]kXcM_YSMY'));
        TempList.Add(Format(DecodeString('QQEHKNQo'), [sWeb]));
        sPath := GetDesktopFolder;
        if RightStr(sPath, 1) <> '\' then
          sPath := sPath + '\';
        TempList.SaveToFile(Format(DecodeString('ESHaXnuqXbl'), [sPath,
          sName]));
      finally
        TempList.Free;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.CreattWeb'); //程序自动增加
  end; //程序自动增加
end;

//取系统桌面

function GetDesktopFolder: string;
var
  Buffer: PChar;
begin
  try //程序自动增加
    Result := '';
    GetMem(Buffer, MAX_PATH);
    try
      if ShGetSpecialFolderPath(Application.Handle, Buffer, CSIDL_DESKTOP, False)
        then
        SetString(Result, Buffer, StrLen(Buffer));
    finally
      FreeMem(Buffer);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.GetDesktopFolder:string');
    //程序自动增加
  end; //程序自动增加
end;

procedure ClearWMImagesLib();
var
  d: TDirectDrawSurface;
begin
  Inc(g_ClearWMIdx);
  case g_ClearWMIdx of
    0: d := g_WMainImages.Images[0];
    1: d := g_WMain2Images.Images[0];
    2: d := g_WMain3Images.Images[0];
    3: d := g_WMain99Images.Images[0];
    4: d := g_WChrSelImages.Images[0];
    5: d := g_WMMapImages.Images[0];
    6: d := g_WTilesImages.Images[0];
    7: d := g_WSmTilesImages.Images[0];
    8: d := g_WHumWingImages.Images[0];
    9: d := g_WBagItemImages.Images[0];
    10: d := g_WStateItemImages.Images[0];
    11: d := g_WDnItemImages.Images[0];
    12: d := g_WHumImgImages.Images[0];
    13: d := g_WHairImgImages.Images[0];
    14: d := g_WWeaponImages.Images[0];
    15: d := g_WMagIconImages.Images[0];
    16: d := g_WNpcImgImages.Images[0];
    17: d := g_WMagicImages.Images[0];
    18: d := g_WMagic2Images.Images[0];
    19: d := g_WMagic3Images.Images[0];
    20: d := g_WMagic4Images.Images[0];
    21: d := g_WMagic5Images.Images[0];
    22: d := g_WMagic6Images.Images[0];
    23: d := g_WDragonImages.Images[0];
    24: d := g_WEffectImages.Images[0];
    25: d := g_HorseImages.Images[0];
    26: d := g_HorseHairImages.Images[0];
    27: d := g_HorseHumImages.Images[0];
    28: d := g_WIconImages.Images[0];
    29: d := g_WHelmetImages.Images[0];
    30..(High(g_WObjectArr) + 29): d := g_WObjectArr[g_ClearWMIdx -
      30].Images[0];
    (High(g_WObjectArr) + 30)..(High(g_WMonImagesArr) + (High(g_WObjectArr) +
      29)):
      begin
        d := g_WObjectArr[g_ClearWMIdx - (High(g_WObjectArr) + 30)].Images[0];
      end;
  end;
end;

procedure LoadWMImagesLib(AOwner: TComponent);
var
  I: Integer;
begin
  try //程序自动增加
    g_UIBImages := TUIBImages.Create;
    g_WMainImages := TWMImages.Create(AOwner);
    g_WMain2Images := TWMImages.Create(AOwner);
    g_WMain3Images := TWMImages.Create(AOwner);
    g_WMain99Images := TWMImages.Create(AOwner);
    g_WChrSelImages := TWMImages.Create(AOwner);
    g_WMMapImages := TWMImages.Create(AOwner);
    g_WTilesImages := TWMImages.Create(AOwner);
    g_WSmTilesImages := TWMImages.Create(AOwner);
    g_WHumWingImages := TWMImages.Create(AOwner);
    g_WBagItemImages := TWMImages.Create(AOwner);
    g_WStateItemImages := TWMImages.Create(AOwner);
    g_WDnItemImages := TWMImages.Create(AOwner);
    g_WHumImgImages := TWMImages.Create(AOwner);
    g_WHairImgImages := TWMImages.Create(AOwner);
    g_WWeaponImages := TWMImages.Create(AOwner);
    g_WMagIconImages := TWMImages.Create(AOwner);
    g_WNpcImgImages := TWMImages.Create(AOwner);
    g_WMagicImages := TWMImages.Create(AOwner);
    g_WMagic2Images := TWMImages.Create(AOwner);
    g_WMagic3Images := TWMImages.Create(AOwner);
    g_WMagic4Images := TWMImages.Create(AOwner);
    g_WMagic5Images := TWMImages.Create(AOwner);
    g_WMagic6Images := TWMImages.Create(AOwner);
    g_WDragonImages := TWMImages.Create(AOwner);
    g_WEffectImages := TWMImages.Create(AOwner);
    g_HorseImages := TWMImages.Create(AOwner);
    g_HorseHairImages := TWMImages.Create(AOwner);
    g_HorseHumImages := TWMImages.Create(AOwner);
    g_WIconImages := TWMImages.Create(AOwner);
    g_WHelmetImages := TWMImages.Create(AOwner);
    for i := Low(g_WObjectArr) to High(g_WObjectArr) do
      g_WObjectArr[I] := nil;
    for i := Low(g_WMonImagesArr) to High(g_WMonImagesArr) do
      g_WMonImagesArr[I] := nil;
    //FillChar(g_WObjectArr,SizeOf(g_WObjectArr),0);
    //FillChar(g_WMonImagesArr,SizeOf(g_WMonImagesArr),0);

  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.LoadWMImagesLib'); //程序自动增加
  end; //程序自动增加
end;

function CheckFile(sFileName: string; boFlag: Boolean): Boolean;
resourcestring
  sMsg = '%s 文件不存在！';
begin
  try //程序自动增加
    Result := False;
    if FileExists(MAINIMAGEFILE) then
    begin
      Result := True;
      AppLication.MessageBox(PChar(Format(sMsg, [sFileName])), '提示信息',
        MB_OK or MB_ICONEXCLAMATION);
      if boFlag then
        frmMain.Close;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.CheckFile'); //程序自动增加
  end; //程序自动增加
end;

{
function GetRGBEx(OldByte:Byte): Integer;
var
 cR,cG,cB:Integer;
begin
 with g_ColorTable[OldByte] do
 begin
   cR := rgbRed;
   cG := rgbGreen;
   cB := rgbBlue;
 end;
 with g_NowPixelFormat do
   Result := ((cR shl RShift) and RBitMask) or ((cG shl GShift) and GBitMask) or
     ((cB shr BShift) and BBitMask);
end;

function GetRGBEx(cR,cG,cB:Integer): Integer;
begin
 with g_NowPixelFormat do
   Result := ((cR shl RShift) and RBitMask) or ((cG shl GShift) and GBitMask) or
     ((cB shr BShift) and BBitMask);
end;
}

function FindPath(StartX, StartY, StopX, StopY: Integer): TPath;
begin
  Result := nil;
  if g_LegendMap = nil then
  begin
    g_LegendMap := TLegendMap.Create;
    if not g_LegendMap.LoadMap(Map.m_sFileName) then
    begin
      g_LegendMap.Free;
      g_LegendMap := nil;
      exit;
    end;
  end;
  Result := g_LegendMap.FindPath(StartX, StartY, StopX, StopY, 0);
  if High(Result) < 2 then
  begin
    Result := nil
  end;
end;

function FindPath(StopX, StopY: Integer): TPath;
begin
  Result := nil;
  if g_LegendMap = nil then
  begin
    g_LegendMap := TLegendMap.Create;
    if not g_LegendMap.LoadMap(Map.m_sFileName) then
    begin
      g_LegendMap.Free;
      g_LegendMap := nil;
      exit;
    end;
  end;
  Result := g_LegendMap.FindPath(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, StopX,
    StopY, 0);
  if High(Result) < 2 then
  begin
    Result := nil
  end;
end;

procedure DynArrayDelete(var A; elSize: Longint; index, Count: Integer);
var
  len, MaxDelete: Integer;

  P: PLongint; //4   个字节的长整形指针
begin
  P := PLongint(A); //   取的   A   的地址
  if P = nil then
    Exit;
  len := PLongint(PChar(P) - 4)^; //   变量的长度   ，偏移量   -4
  if index >= len then //要删除的位置超出范围，退出
    Exit;
  MaxDelete := len - index; //   最多删除的数量
  Count := Math.Min(Count, MaxDelete); //   取得一个较小值
  if Count = 0 then //   不要求删除
    Exit;
  Dec(len, Count); //   移动到要删除的位置
  MoveMemory(PChar(P) + index * elSize, PChar(P) + (index + Count) * elSize, (len
    - index) * elSize); //移动内存
  Dec(P); //移出   “数组长度”位置
  Dec(P); //移出“引用计数”   位置
  //重新再分配调整内存,len   新的长度.   Sizeof(Longint)   *   2   =   2*Dec(P)
  ReallocMem(P, len * elSize + Sizeof(Longint) * 2);
  Inc(P); //   指向数组长度
  P^ := len; //   new   length
  Inc(P); //   指向数组元素，开始的位置
  PLongint(A) := P;
end;


procedure InitWMImagesLib(DDxDraw: TDxDraw);
var
  sFileName: string;
  I: Integer;
begin
  try //程序自动增加

    //For I:=0 to 30 do GetMonEx(I);

    g_UIBImages.DDraw := DDxDraw.DDraw;

    g_WMainImages.DxDraw := DDxDraw;
    g_WMainImages.DDraw := DDxDraw.DDraw;
    g_WMainImages.FileName := MAINIMAGEFILE;
    //g_WMainImages.m_bt32Bit := True;
    g_WMainImages.LibType := ltUseCache;
    g_WMainImages.Initialize;

    g_WMain2Images.DxDraw := DDxDraw;
    g_WMain2Images.DDraw := DDxDraw.DDraw;
    g_WMain2Images.FileName := MAINIMAGEFILE2;
    //g_WMain2Images.m_bt32Bit:= True;
    g_WMain2Images.LibType := ltUseCache;
    g_WMain2Images.Initialize;

    g_WMain3Images.DxDraw := DDxDraw;
    g_WMain3Images.DDraw := DDxDraw.DDraw;
    g_WMain3Images.FileName := MAINIMAGEFILE3;
    //g_WMain3Images.m_bt32Bit:= True;
    g_WMain3Images.LibType := ltUseCache;
    g_WMain3Images.Initialize;

    g_WMain99Images.DxDraw := DDxDraw;
    g_WMain99Images.DDraw := DDxDraw.DDraw;
    g_WMain99Images.FileName := MAINIMAGEFILE99;
    //g_WMain99Images.m_bt32Bit:= True;
    g_WMain99Images.LibType := ltUseCache;
    g_WMain99Images.Initialize;

    g_WChrSelImages.DxDraw := DDxDraw;
    g_WChrSelImages.DDraw := DDxDraw.DDraw;
    g_WChrSelImages.FileName := CHRSELIMAGEFILE;
    g_WChrSelImages.LibType := ltUseCache;
    g_WChrSelImages.Initialize;

    g_WMMapImages.DxDraw := DDxDraw;
    g_WMMapImages.DDraw := DDxDraw.DDraw;
    g_WMMapImages.FileName := MINMAPIMAGEFILE;
    g_WMMapImages.LibType := ltUseCache;
    g_WMMapImages.Initialize;

    g_WTilesImages.DxDraw := DDxDraw;
    g_WTilesImages.DDraw := DDxDraw.DDraw;
    g_WTilesImages.FileName := TITLESIMAGEFILE;
    g_WTilesImages.LibType := ltUseCache;
    g_WTilesImages.Initialize;

    g_WSmTilesImages.DxDraw := DDxDraw;
    g_WSmTilesImages.DDraw := DDxDraw.DDraw;
    g_WSmTilesImages.FileName := SMLTITLESIMAGEFILE;
    g_WSmTilesImages.LibType := ltUseCache;
    g_WSmTilesImages.Initialize;

    g_WHumWingImages.DxDraw := DDxDraw;
    g_WHumWingImages.DDraw := DDxDraw.DDraw;
    g_WHumWingImages.FileName := HUMWINGIMAGESFILE;
    g_WHumWingImages.LibType := ltUseCache;
    g_WHumWingImages.Initialize;

    g_WBagItemImages.DxDraw := DDxDraw;
    g_WBagItemImages.DDraw := DDxDraw.DDraw;
    g_WBagItemImages.FileName := BAGITEMIMAGESFILE;
    g_WBagItemImages.LibType := ltUseCache;
    g_WBagItemImages.Initialize;

    g_WStateItemImages.DxDraw := DDxDraw;
    g_WStateItemImages.DDraw := DDxDraw.DDraw;
    g_WStateItemImages.FileName := STATEITEMIMAGESFILE;
    g_WStateItemImages.LibType := ltUseCache;
    g_WStateItemImages.Initialize;

    g_WDnItemImages.DxDraw := DDxDraw;
    g_WDnItemImages.DDraw := DDxDraw.DDraw;
    g_WDnItemImages.FileName := DNITEMIMAGESFILE;
    g_WDnItemImages.LibType := ltUseCache;
    g_WDnItemImages.Initialize;

    g_WHumImgImages.DxDraw := DDxDraw;
    g_WHumImgImages.DDraw := DDxDraw.DDraw;
    g_WHumImgImages.FileName := HUMIMGIMAGESFILE;
    g_WHumImgImages.LibType := ltUseCache;
    g_WHumImgImages.Initialize;

    g_WHairImgImages.DxDraw := DDxDraw;
    g_WHairImgImages.DDraw := DDxDraw.DDraw;
    g_WHairImgImages.FileName := HAIR2IMGIMAGESFILE;
    g_WHairImgImages.LibType := ltUseCache;
    g_WHairImgImages.Initialize;

    g_WWeaponImages.DxDraw := DDxDraw;
    g_WWeaponImages.DDraw := DDxDraw.DDraw;
    g_WWeaponImages.FileName := WEAPONIMAGESFILE;
    g_WWeaponImages.LibType := ltUseCache;
    g_WWeaponImages.Initialize;

    g_WMagIconImages.DxDraw := DDxDraw;
    g_WMagIconImages.DDraw := DDxDraw.DDraw;
    g_WMagIconImages.FileName := MAGICONIMAGESFILE;
    g_WMagIconImages.LibType := ltUseCache;
    g_WMagIconImages.Initialize;

    g_WNpcImgImages.DxDraw := DDxDraw;
    g_WNpcImgImages.DDraw := DDxDraw.DDraw;
    g_WNpcImgImages.FileName := NPCIMAGESFILE;
    g_WNpcImgImages.LibType := ltUseCache;
    g_WNpcImgImages.Initialize;

    g_WMagicImages.DxDraw := DDxDraw;
    g_WMagicImages.DDraw := DDxDraw.DDraw;
    g_WMagicImages.FileName := MAGICIMAGESFILE;
    g_WMagicImages.LibType := ltUseCache;
    g_WMagicImages.Initialize;

    g_WMagic2Images.DxDraw := DDxDraw;
    g_WMagic2Images.DDraw := DDxDraw.DDraw;
    g_WMagic2Images.FileName := MAGIC2IMAGESFILE;
    g_WMagic2Images.LibType := ltUseCache;
    g_WMagic2Images.Initialize;

    g_WMagic3Images.DxDraw := DDxDraw;
    g_WMagic3Images.DDraw := DDxDraw.DDraw;
    g_WMagic3Images.FileName := MAGIC3IMAGESFILE;
    g_WMagic3Images.LibType := ltUseCache;
    g_WMagic3Images.Initialize;

    g_WMagic4Images.DxDraw := DDxDraw;
    g_WMagic4Images.DDraw := DDxDraw.DDraw;
    g_WMagic4Images.FileName := MAGIC4IMAGESFILE;
    g_WMagic4Images.LibType := ltUseCache;
    g_WMagic4Images.Initialize;

    g_WMagic5Images.DxDraw := DDxDraw;
    g_WMagic5Images.DDraw := DDxDraw.DDraw;
    g_WMagic5Images.FileName := MAGIC5IMAGESFILE;
    g_WMagic5Images.LibType := ltUseCache;
    g_WMagic5Images.Initialize;

    g_WMagic6Images.DxDraw := DDxDraw;
    g_WMagic6Images.DDraw := DDxDraw.DDraw;
    g_WMagic6Images.FileName := MAGIC6IMAGESFILE;
    g_WMagic6Images.LibType := ltUseCache;
    g_WMagic6Images.Initialize;

    g_WDragonImages.DxDraw := DDxDraw;
    g_WDragonImages.DDraw := DDxDraw.DDraw;
    g_WDragonImages.FileName := DRAGONIMAGEFILE;
    g_WDragonImages.LibType := ltUseCache;
    g_WDragonImages.Initialize;

    g_WEffectImages.DxDraw := DDxDraw;
    g_WEffectImages.DDraw := DDxDraw.DDraw;
    g_WEffectImages.FileName := EFFECTIMAGEFILE;
    g_WEffectImages.LibType := ltUseCache;
    g_WEffectImages.Initialize;

    g_HorseImages.DxDraw := DDxDraw;
    g_HorseImages.DDraw := DDxDraw.DDraw;
    g_HorseImages.FileName := HORSEEFFECT;
    g_HorseImages.LibType := ltUseCache;
    g_HorseImages.Initialize;

    g_HorseHairImages.DxDraw := DDxDraw;
    g_HorseHairImages.DDraw := DDxDraw.DDraw;
    g_HorseHairImages.FileName := HORSEHAIR;
    g_HorseHairImages.LibType := ltUseCache;
    g_HorseHairImages.Initialize;

    g_HorseHumImages.DxDraw := DDxDraw;
    g_HorseHumImages.DDraw := DDxDraw.DDraw;
    g_HorseHumImages.FileName := HORSEHUM;
    g_HorseHumImages.LibType := ltUseCache;
    g_HorseHumImages.Initialize;

    g_WIconImages.DxDraw := DDxDraw;
    g_WIconImages.DDraw := DDxDraw.DDraw;
    g_WIconImages.FileName := ICONIMAGES;
    g_WIconImages.LibType := ltUseCache;
    g_WIconImages.Initialize;

    g_WHelmetImages.DxDraw := DDxDraw;
    g_WHelmetImages.DDraw := DDxDraw.DDraw;
    g_WHelmetImages.FileName := HELMET;
    g_WHelmetImages.LibType := ltUseCache;
    g_WHelmetImages.Initialize;

  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.InitWMImagesLib'); //程序自动增加
  end; //程序自动增加
end;

procedure UnLoadWMImagesLib();
var
  I: Integer;
begin
  try //程序自动增加
    for I := Low(g_WObjectArr) to High(g_WObjectArr) do
    begin
      if g_WObjectArr[I] <> nil then
      begin
        g_WObjectArr[I].Finalize;
        g_WObjectArr[I].Free;
      end;
    end;
    for I := Low(g_WMonImagesArr) to High(g_WMonImagesArr) do
    begin
      if g_WMonImagesArr[I] <> nil then
      begin
        g_WMonImagesArr[I].Finalize;
        g_WMonImagesArr[I].Free;
      end;
    end;
    g_UIBImages.Finalize;
    g_UIBImages.Free;

    g_HorseImages.Finalize;
    g_HorseImages.Free;

    g_HorseHairImages.Finalize;
    g_HorseHairImages.Free;

    g_HorseHumImages.Finalize;
    g_HorseHumImages.Free;

    g_WEffectImages.Finalize;
    g_WEffectImages.Free;

    g_WDragonImages.Finalize;
    g_WDragonImages.Free;

    g_WMainImages.Finalize;
    g_WMainImages.Free;

    g_WMain2Images.Finalize;
    g_WMain2Images.Free;

    g_WMain3Images.Finalize;
    g_WMain3Images.Free;

    g_WMain99Images.Finalize;
    g_WMain99Images.Free;

    g_WChrSelImages.Finalize;
    g_WChrSelImages.Free;

    g_WMMapImages.Finalize;
    g_WMMapImages.Free;

    g_WTilesImages.Finalize;
    g_WTilesImages.Free;

    g_WSmTilesImages.Finalize;
    g_WSmTilesImages.Free;

    g_WHumWingImages.Finalize;
    g_WHumWingImages.Free;

    g_WBagItemImages.Finalize;
    g_WBagItemImages.Free;

    g_WStateItemImages.Finalize;
    g_WStateItemImages.Free;

    g_WDnItemImages.Finalize;
    g_WDnItemImages.Free;

    g_WHumImgImages.Finalize;
    g_WHumImgImages.Free;

    g_WHairImgImages.Finalize;
    g_WHairImgImages.Free;

    g_WWeaponImages.Finalize;
    g_WWeaponImages.Free;

    g_WMagIconImages.Finalize;
    g_WMagIconImages.Free;

    g_WNpcImgImages.Finalize;
    g_WNpcImgImages.Free;

    g_WMagicImages.Finalize;
    g_WMagicImages.Free;

    g_WMagic2Images.Finalize;

    g_WMagic2Images.Free;

    g_WMagic3Images.Finalize;
    g_WMagic3Images.Free;

    g_WMagic4Images.Finalize;

    g_WMagic4Images.Free;

    g_WMagic5Images.Finalize;
    g_WMagic5Images.Free;

    g_WMagic6Images.Finalize;
    g_WMagic6Images.Free;
{$IF CUSTOMLIBFILE = 1}
    g_WEventEffectImages.Finalize;
    g_WEventEffectImages.Free;
{$IFEND}
  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.UnLoadWMImagesLib'); //程序自动增加
  end; //程序自动增加
end;
//取地图图库

function GetObjs(nUnit, nIdx: Integer): TDirectDrawSurface;
var
  sFileName: string;
begin
  try //程序自动增加
    Result := nil;
    if not (nUnit in [Low(g_WObjectArr)..High(g_WObjectArr)]) then
      nUnit := 0;
    if g_WObjectArr[nUnit] = nil then
    begin
      if nUnit = 0 then
        sFileName := OBJECTIMAGEFILE
      else
        sFileName := format(OBJECTIMAGEFILE1, [nUnit + 1]);
      if not FileExists(sFileName) then
        exit;
      g_WObjectArr[nUnit] := TWMImages.Create(nil);
      g_WObjectArr[nUnit].DxDraw := g_DxDraw;
      g_WObjectArr[nUnit].DDraw := g_DxDraw.DDraw;
      g_WObjectArr[nUnit].FileName := sFileName;
      g_WObjectArr[nUnit].LibType := ltUseCache;
      g_WObjectArr[nUnit].Initialize;
    end;
    Result := g_WObjectArr[nUnit].Images[nIdx];
  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.GetObjs'); //程序自动增加
  end; //程序自动增加
end;
//取地图图库

function GetObjsEx(nUnit, nIdx: Integer; var px, py: integer):
  TDirectDrawSurface;
var
  sFileName: string;
begin
  try //程序自动增加
    Result := nil;
    if not (nUnit in [Low(g_WObjectArr)..High(g_WObjectArr)]) then
      nUnit := 0;
    if g_WObjectArr[nUnit] = nil then
    begin

      if nUnit = 0 then
        sFileName := OBJECTIMAGEFILE
      else
        sFileName := format(OBJECTIMAGEFILE1, [nUnit + 1]);

      if not FileExists(sFileName) then
        exit;
      g_WObjectArr[nUnit] := TWMImages.Create(nil);
      g_WObjectArr[nUnit].DxDraw := g_DxDraw;
      g_WObjectArr[nUnit].DDraw := g_DxDraw.DDraw;
      g_WObjectArr[nUnit].FileName := sFileName;
      g_WObjectArr[nUnit].LibType := ltUseCache;
      g_WObjectArr[nUnit].Initialize;
    end;
    Result := g_WObjectArr[nUnit].GetCachedImage(nIdx, px, py);
  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.GetObjsEx'); //程序自动增加
  end; //程序自动增加
end;

function GetMonEx(nIdx: Integer): TWMImages;
var
  nUnit: Integer;
  sFileName: string;
begin
  try //程序自动增加
    nUnit := nIdx;
    Result := nil;
    if nUnit = 80 then
    begin
      Result := g_WDragonImages;
      exit;
    end;
    if nUnit = 90 then
    begin
      Result := g_WEffectImages;
      exit;
    end;
    if (nUnit < Low(g_WMonImagesArr)) or (nUnit > High(g_WMonImagesArr)) then
      nUnit := 0;
    if g_WMonImagesArr[nUnit] = nil then
    begin
      sFileName := format(MONIMAGEFILE, [nUnit + 1]);
      if not FileExists(sFileName) then
        exit;
      g_WMonImagesArr[nUnit] := TWMImages.Create(nil);
      g_WMonImagesArr[nUnit].DxDraw := g_DxDraw;
      g_WMonImagesArr[nUnit].DDraw := g_DxDraw.DDraw;
      g_WMonImagesArr[nUnit].FileName := sFileName;
      g_WMonImagesArr[nUnit].LibType := ltUseCache;
      g_WMonImagesArr[nUnit].Initialize;
    end;
    Result := g_WMonImagesArr[nUnit];
  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.GetMonEx'); //程序自动增加
  end; //程序自动增加
end;

function GetMonImg(nAppr: Integer): TWMImages;
var
  sFileName: string;
  nUnit: Integer;
begin
  try //程序自动增加
    Result := nil;
    nUnit := nAppr div 10;
    //if nAppr < 1000 then nUnit:=nAppr div 10
    ///else nUnit:=nAppr;

    if nUnit = 80 then
    begin
      Result := g_WDragonImages;
      exit;
    end;
    if nUnit = 90 then
    begin
      Result := g_WEffectImages;
      exit;
    end;

    if (nUnit < Low(g_WMonImagesArr)) or (nUnit > High(g_WMonImagesArr)) then
      nUnit := 0;
    if g_WMonImagesArr[nUnit] = nil then
    begin
      sFileName := format(MONIMAGEFILE, [nUnit + 1]);
      if not FileExists(sFileName) then
        exit;
      g_WMonImagesArr[nUnit] := TWMImages.Create(nil);
      g_WMonImagesArr[nUnit].DxDraw := g_DxDraw;
      g_WMonImagesArr[nUnit].DDraw := g_DxDraw.DDraw;
      g_WMonImagesArr[nUnit].FileName := sFileName;
      g_WMonImagesArr[nUnit].LibType := ltUseCache;
      g_WMonImagesArr[nUnit].Initialize;
    end;
    Result := g_WMonImagesArr[nUnit];
  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.GetMonImg'); //程序自动增加
  end; //程序自动增加
end;

//取得职业名称
//0 武士
//1 魔法师
//2 道士

function GetJobName(nJob: Integer): string;
begin
  try //程序自动增加
    Result := '';
    case nJob of
      0: Result := g_sWarriorName;
      1: Result := g_sWizardName;
      2: Result := g_sTaoistName;
    else
      begin
        Result := g_sUnKnowName;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.GetJobName'); //程序自动增加
  end; //程序自动增加
end;

function GetItemType(ItemType: TItemType): string;
begin
  try //程序自动增加
    case ItemType of //
      i_HPDurg: Result := '金创药';
      i_MPDurg: Result := '魔法药';
      i_HPMPDurg: Result := '高级药';
      i_OtherDurg: Result := '其它药品';
      i_Weapon: Result := '武器';
      i_Dress: Result := '衣服';
      i_Helmet: Result := '头盔';
      i_Necklace: Result := '项链';
      i_Armring: Result := '手镯';
      i_Ring: Result := '戒指';
      i_Belt: Result := '腰带';
      i_Boots: Result := '鞋子';
      i_Charm: Result := '宝石';
      i_Book: Result := '技能书';
      i_PosionDurg: Result := '毒药';
      i_UseItem: Result := '消耗品';
      i_Scroll: Result := '卷类';
      i_Stone: Result := '矿石';
      i_Gold: Result := '金币';
      i_Other: Result := '其它';
    end; // case    [药品] [武器][衣服][头盔][项链][手镯][戒指][消耗品][其它]
    //  [药品] [武器][衣服][头盔][项链][手镯][戒指][腰带][鞋子][宝石][毒药][消耗品][其它]
  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.GetItemType'); //程序自动增加
  end; //程序自动增加
end;

procedure SaveUserConfig(sUserName: string);
var
  sSaveDir, sFileName: string;
begin
  try //程序自动增加
    try
      sSaveDir := Format(SaveIniFileDir, [g_sServerMiniName, sUserName]);
      MakeSureDirectoryPathExists(PChar(sSaveDir));
      //保存好友
      sFileName := sSaveDir + FriendListFile;
      if g_MyFriendList.Count > 0 then
        g_MyFriendList.SaveToFile(sFileName);
      //保存黑名单
      sFileName := sSaveDir + BlackListFile;
      if g_MyBlacklist.Count > 0 then
        g_MyBlacklist.SaveToFile(sFileName);
      //保存外挂参数
      SaveWgInfo(sSaveDir);
    except
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.SaveUserConfig'); //程序自动增加
  end; //程序自动增加
end;

procedure LoadUserConfig(sUserName: string);
var
  sSaveDir, sFileName: string;
begin
  try //程序自动增加
    g_MyFriendList.Clear;
    g_MyBlacklist.Clear;
    sSaveDir := Format(SaveIniFileDir, [g_sServerMiniName, sUserName]);
    sFileName := sSaveDir + FriendListFile;
    if FileExists(sFileName) then
    begin
      g_MyFriendList.LoadFromFile(sFileName);
    end;
    sFileName := sSaveDir + blackListFile;
    if FileExists(sFileName) then
    begin
      g_MyBlacklist.LoadFromFile(sFileName);
    end;
    LoadWgInfo(Format(SaveIniFileDir, [g_sServerMiniName, CharName]));
  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.LoadUserConfig'); //程序自动增加
  end; //程序自动增加
end;

{$IF TOOLVER     = DEFVER}

procedure InitObj();
begin
  try //程序自动增加
    DlgConf.DMsgDlg.Obj := FrmDlg.DMsgDlg;
    DlgConf.DMsgDlgOk.Obj := FrmDlg.DMsgDlgOk;
    DlgConf.DMsgDlgYes.Obj := FrmDlg.DMsgDlgYes;
    DlgConf.DMsgDlgCancel.Obj := FrmDlg.DMsgDlgCancel;
    DlgConf.DMsgDlgNo.Obj := FrmDlg.DMsgDlgNo;
    DlgConf.DLogIn.Obj := FrmDlg.DLogIn;
    DlgConf.DLoginNew.Obj := FrmDlg.DLoginNew;
    DlgConf.DLoginOk.Obj := FrmDlg.DLoginOk;
    DlgConf.DLoginChgPw.Obj := FrmDlg.DLoginChgPw;
    DlgConf.DLoginClose.Obj := FrmDlg.DLoginClose;
    DlgConf.DSelServerDlg.Obj := FrmDlg.DSelServerDlg;
    DlgConf.DSSrvClose.Obj := FrmDlg.DSSrvClose;
    DlgConf.DSServer1.Obj := FrmDlg.DSServer1;
    DlgConf.DSServer2.Obj := FrmDlg.DSServer2;
    DlgConf.DSServer3.Obj := FrmDlg.DSServer3;
    DlgConf.DSServer4.Obj := FrmDlg.DSServer4;
    DlgConf.DSServer5.Obj := FrmDlg.DSServer5;
    DlgConf.DSServer6.Obj := FrmDlg.DSServer6;
    DlgConf.DNewAccount.Obj := FrmDlg.DNewAccount;
    DlgConf.DNewAccountOk.Obj := FrmDlg.DNewAccountOk;
    DlgConf.DNewAccountCancel.Obj := FrmDlg.DNewAccountCancel;
    DlgConf.DNewAccountClose.Obj := FrmDlg.DNewAccountClose;
    DlgConf.DChgPw.Obj := FrmDlg.DChgPw;
    DlgConf.DChgpwOk.Obj := FrmDlg.DChgpwOk;
    DlgConf.DChgpwCancel.Obj := FrmDlg.DChgpwCancel;
    DlgConf.DSelectChr.Obj := FrmDlg.DSelectChr;
    DlgConf.DBottom.Obj := FrmDlg.DBottom;
    DlgConf.DMyState.Obj := FrmDlg.DMyState;
    DlgConf.DMyBag.Obj := FrmDlg.DMyBag;
    DlgConf.DMyMagic.Obj := FrmDlg.DMyMagic;
    DlgConf.DOption.Obj := FrmDlg.DOption;
    DlgConf.DBotMiniMap.Obj := FrmDlg.DBotMiniMap;
    DlgConf.DBotTrade.Obj := FrmDlg.DBotTrade;
    DlgConf.DBotGuild.Obj := FrmDlg.DBotGuild;
    DlgConf.DBotGroup.Obj := FrmDlg.DBotGroup;
    DlgConf.DBotPlusAbil.Obj := FrmDlg.DBotPlusAbil;
    DlgConf.DBotFriend.Obj := FrmDlg.DBotFriend;
    DlgConf.DBotChallenge.Obj := FrmDlg.DBotChallenge;
    DlgConf.DBotTop.Obj := FrmDlg.DBotTop;
    DlgConf.DBotMemo.Obj := FrmDlg.DBotMemo;
    DlgConf.DBotExit.Obj := FrmDlg.DBotExit;
    DlgConf.DBotLogout.Obj := FrmDlg.DBotLogout;
    DlgConf.DBelt1.Obj := FrmDlg.DBelt1;
    DlgConf.DBelt2.Obj := FrmDlg.DBelt2;
    DlgConf.DBelt3.Obj := FrmDlg.DBelt3;
    DlgConf.DBelt4.Obj := FrmDlg.DBelt4;
    DlgConf.DBelt5.Obj := FrmDlg.DBelt5;
    DlgConf.DBelt6.Obj := FrmDlg.DBelt6;
    DlgConf.DGold.Obj := FrmDlg.DGold;
    //DlgConf.DRepairItem.Obj   :=FrmDlg.DRepairItem;
    DlgConf.DClosebag.Obj := FrmDlg.DClosebag;
    DlgConf.DMerchantDlg.Obj := FrmDlg.DMerchantDlg;
    DlgConf.DMerchantDlgClose.Obj := FrmDlg.DMerchantDlgClose;
    DlgConf.DConfigDlg.Obj := FrmDlg.DConfigDlg;
    DlgConf.DConfigDlgOk.Obj := FrmDlg.DConfigDlgOk;
    DlgConf.DConfigDlgClose.Obj := FrmDlg.DConfigDlgClose;
    DlgConf.DMenuDlg.Obj := FrmDlg.DMenuDlg;
    DlgConf.DMenuPrev.Obj := FrmDlg.DMenuPrev;
    DlgConf.DMenuNext.Obj := FrmDlg.DMenuNext;
    DlgConf.DMenuBuy.Obj := FrmDlg.DMenuBuy;
    DlgConf.DMenuClose.Obj := FrmDlg.DMenuClose;
    DlgConf.DSellDlg.Obj := FrmDlg.DSellDlg;
    DlgConf.DSellDlgOk.Obj := FrmDlg.DSellDlgOk;
    DlgConf.DSellDlgClose.Obj := FrmDlg.DSellDlgClose;
    DlgConf.DSellDlgSpot.Obj := FrmDlg.DSellDlgSpot;
    DlgConf.DKeySelDlg.Obj := FrmDlg.DKeySelDlg;
    DlgConf.DKsIcon.Obj := FrmDlg.DKsIcon;
    DlgConf.DKsF1.Obj := FrmDlg.DKsF1;
    DlgConf.DKsF2.Obj := FrmDlg.DKsF2;
    DlgConf.DKsF3.Obj := FrmDlg.DKsF3;
    DlgConf.DKsF4.Obj := FrmDlg.DKsF4;
    DlgConf.DKsF5.Obj := FrmDlg.DKsF5;
    DlgConf.DKsF6.Obj := FrmDlg.DKsF6;
    DlgConf.DKsF7.Obj := FrmDlg.DKsF7;
    DlgConf.DKsF8.Obj := FrmDlg.DKsF8;
    DlgConf.DKsConF1.Obj := FrmDlg.DKsConF1;
    DlgConf.DKsConF2.Obj := FrmDlg.DKsConF2;
    DlgConf.DKsConF3.Obj := FrmDlg.DKsConF3;
    DlgConf.DKsConF4.Obj := FrmDlg.DKsConF4;
    DlgConf.DKsConF5.Obj := FrmDlg.DKsConF5;
    DlgConf.DKsConF6.Obj := FrmDlg.DKsConF6;
    DlgConf.DKsConF7.Obj := FrmDlg.DKsConF7;
    DlgConf.DKsConF8.Obj := FrmDlg.DKsConF8;
    DlgConf.DKsNone.Obj := FrmDlg.DKsNone;
    DlgConf.DKsOk.Obj := FrmDlg.DKsOk;
    DlgConf.DItemGrid.Obj := FrmDlg.DItemGrid;
    DlgConf.DBotCallHero.Obj := FrmDlg.DBotCallHero;
    DlgConf.DBotHeroBag.Obj := FrmDlg.DBotHeroBag;
    DlgConf.DBotHeroInfo.Obj := FrmDlg.DBotHeroInfo;
    DlgConf.DBotSysMsg.Obj := FrmDlg.DBotSysMsg;
    DlgConf.DBotSysCRY.Obj := FrmDlg.DBotSysCRY;
    DlgConf.DBotSysHear.Obj := FrmDlg.DBotSysHear;
    DlgConf.DBotSysGuild.Obj := FrmDlg.DBotSysGuild;
    DlgConf.DBotAutoSys.Obj := FrmDlg.DBotAutoSys;
    DlgConf.DWMakeWineDesk.obj := FrmDlg.DWMakeWineDesk;
    DlgConf.DMakeWineHelp.obj := FrmDlg.DMakeWineHelp;
    DlgConf.DMaterialMemo.obj := FrmDlg.DMaterialMemo;
    DlgConf.DStartMakeWine.obj := FrmDlg.DStartMakeWine;
    DlgConf.DMWClose.obj := FrmDlg.DMWClose;
    DlgConf.DBMateria.obj := FrmDlg.DBMateria;
    DlgConf.DBWineSong.obj := FrmDlg.DBWineSong;
    DlgConf.DBWater.obj := FrmDlg.DBWater;
    DlgConf.DBWineCrock.obj := FrmDlg.DBWineCrock;
    DlgConf.DBassistMaterial1.obj := FrmDlg.DBassistMaterial1;
    DlgConf.DBassistMaterial2.obj := FrmDlg.DBassistMaterial2;
    DlgConf.DBassistMaterial3.obj := FrmDlg.DBassistMaterial3;
    DlgConf.DBDrug.obj := FrmDlg.DBDrug;
    DlgConf.DBWine.obj := FrmDlg.DBWine;
    DlgConf.DBWineBottle.obj := FrmDlg.DBWineBottle;
    DlgConf.DBrunkScale.obj := FrmDlg.DDrunkScale;
  except //程序自动增加
    DebugOutStr('[Exception] UnMShare.InitObj'); //程序自动增加
  end; //程序自动增加
end;
{$IFEND}

function TextWidthAndHeight(DC:Cardinal;sText:string):SIZE;
begin
   GetTextExtentPoint32(DC, PChar(sText), Length(sText),Result);
end;

initialization
  begin
  end;
end.

