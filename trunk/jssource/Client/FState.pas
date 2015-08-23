//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit FState;                                                                  

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,ComCtrls,
  DWinCtl, StdCtrls, DXDraws, Grids, Grobal2, clFunc, hUtil32, cliUtil,MapUnit,
  SoundUtil, {SHDocVw_EWB, EwbCore, EmbeddedWB,} ExtCtrls,RzButton;

type
  TPlayDrink = (pdDD, pdDrink, pdSelf, pdNPC, pdMsg);

const
  BOTTOMBOARD800 = 371; //主操作介面图形号
  BOTTOMBOARD1024 = 371; //主操作介面图形号
  VIEWCHATLINE = 9;
  MAXSTATEPAGE = 4;
  LISTLINEHEIGHT = 13;
  MAXMENU = 10;

  AdjustAbilHints: array[0..8] of string = (
    '攻击力',
    '魔法力 (魔法师)',
    '道术力 (道士)',
    '防御',
    '魔法防御',
    'HP值',
    'MP值',
    '准确',
    '敏捷'
    );

  SellItemHints: array[0..12] of string = (
    '所有',
    '衣服',
    '武器',
    '头盔',
    '项链',
    '勋章',
    '手镯',
    '戒指',
    '腰带',
    '鞋子',
    '宝石',
    '其它',
    '我的'
    );

type
  TSpotDlgMode = (dmSell, dmRepair, dmStorage, dmSellOff, dmPlayDrink);

  TClickPoint = record
    rc: TRect;
    RStr: string;
  end;
  pTClickPoint = ^TClickPoint;
  TDiceInfo = record
    nDicePoint: Integer; //0x66C
    nPlayPoint: Integer; //0x670 当前骰子点数
    nX: Integer; //0x674
    nY: Integer; //0x678
    n67C: Integer; //0x67C
    n680: Integer; //0x680
    dwPlayTick: LongWord; //0x684
  end;
  pTDiceInfo = ^TDiceInfo;
  TFrmDlg = class(TForm)
    DHeroDlg: TDWindow;
    DStateWin: TDWindow;
    DBackground: TDWindow;
    DItemBag: TDWindow;
    DBottom: TDWindow;
    DMyState: TDButton;
    DMyBag: TDButton;
    DMyMagic: TDButton;
    DOption: TDButton;
    DGold: TDButton;
    DPrevState: TDButton;
    DCloseBag: TDButton;
    DCloseState: TDButton;
    DLogIn: TDWindow;
    DSelectChr: TDWindow;
    DLoginNew: TDButton;
    DLoginOk: TDButton;
    DNewAccount: TDWindow;
    DNewAccountOk: TDButton;
    DLoginClose: TDButton;
    DNewAccountClose: TDButton;
    DscSelect1: TDButton;
    DscSelect2: TDButton;
    DscStart: TDButton;
    DscNewChr: TDButton;
    DscEraseChr: TDButton;
    DscCredits: TDButton;
    DscExit: TDButton;
    DCreateChr: TDWindow;
    DccWarrior: TDButton;
    DccWizzard: TDButton;
    DccMonk: TDButton;
    DccReserved: TDButton;
    DccMale: TDButton;
    DccFemale: TDButton;
    DccLeftHair: TDButton;
    DccRightHair: TDButton;
    DccOk: TDButton;
    DccClose: TDButton;
    DItemGrid: TDGrid;
    DLoginChgPw: TDButton;
    DMsgDlg: TDWindow;
    DMsgDlgOk: TDButton;
    DMsgDlgYes: TDButton;
    DMsgDlgCancel: TDButton;
    DMsgDlgNo: TDButton;
    DNextState: TDButton;
    DSWNecklace: TDButton;
    DSWLight: TDButton;
    DSWArmRingR: TDButton;
    DSWArmRingL: TDButton;
    DSWRingR: TDButton;
    DSWRingL: TDButton;
    DSWWeapon: TDButton;
    DSWDress: TDButton;
    DSWHelmet: TDButton;
    DSWBujuk: TDButton;
    DSWBelt: TDButton;
    DSWBoots: TDButton;
    DSWCharm: TDButton;

    DBelt1: TDButton;
    DBelt2: TDButton;
    DBelt3: TDButton;
    DBelt4: TDButton;
    DBelt5: TDButton;
    DBelt6: TDButton;
    DChgPw: TDWindow;
    DChgpwOk: TDButton;
    DChgpwCancel: TDButton;
    DMenuDlg: TDWindow;
    DMenuPrev: TDButton;
    DMenuNext: TDButton;
    DMenuBuy: TDButton;
    DMenuClose: TDButton;
    DSellDlg: TDWindow;
    DSellDlgOk: TDButton;
    DSellDlgClose: TDButton;
    DSellDlgSpot: TDButton;
    DStMag1: TDButton;
    DStMag2: TDButton;
    DStMag3: TDButton;
    DStMag4: TDButton;
    DStMag5: TDButton;
    DKeySelDlg: TDWindow;
    DKsIcon: TDButton;
    DKsF1: TDButton;
    DKsF2: TDButton;
    DKsF3: TDButton;
    DKsF4: TDButton;
    DKsNone: TDButton;
    DKsOk: TDButton;
    DBotGroup: TDButton;
    DBotTrade: TDButton;
    DBotMiniMap: TDButton;
    DBotFriend: TDButton;
    DGroupDlg: TDWindow;
    DGrpAllowGroup: TDButton;
    DGrpDlgClose: TDButton;
    DGrpCreate: TDButton;
    DGrpAddMem: TDButton;
    DGrpDelMem: TDButton;
    DBotLogout: TDButton;
    DBotExit: TDButton;
    DBotGuild: TDButton;
    DStPageUp: TDButton;
    DStPageDown: TDButton;
    DDealRemoteDlg: TDWindow;
    DDealDlg: TDWindow;
    DDRGrid: TDGrid;
    DDGrid: TDGrid;
    DDealOk: TDButton;
    DDealClose: TDButton;
    DDGold: TDButton;
    DDRGold: TDButton;
    DSelServerDlg: TDWindow;
    DSSrvClose: TDButton;
    DSServer1: TDButton;
    DSServer2: TDButton;
    DUserState1: TDWindow;
    DCloseUS1: TDButton;
    DWeaponUS1: TDButton;
    DHelmetUS1: TDButton;
    DNecklaceUS1: TDButton;
    DDressUS1: TDButton;
    DLightUS1: TDButton;
    DArmringRUS1: TDButton;
    DRingRUS1: TDButton;
    DArmringLUS1: TDButton;
    DRingLUS1: TDButton;

    DBujukUS1: TDButton;
    DBeltUS1: TDButton;
    DBootsUS1: TDButton;
    DCharmUS1: TDButton;

    DSServer3: TDButton;
    DSServer4: TDButton;
    DGuildDlg: TDWindow;
    DGDHome: TDButton;
    DGDList: TDButton;
    DGDChat: TDButton;
    DGDAddMem: TDButton;
    DGDDelMem: TDButton;
    DGDEditNotice: TDButton;
    DGDEditGrade: TDButton;
    DGDAlly: TDButton;
    DGDBreakAlly: TDButton;
    DGDWar: TDButton;
    DGDCancelWar: TDButton;
    DGDUp: TDButton;
    DGDDown: TDButton;
    DGDClose: TDButton;
    DGuildEditNotice: TDWindow;
    DGEClose: TDButton;
    DGEOk: TDButton;
    DSServer5: TDButton;
    DSServer6: TDButton;
    DNewAccountCancel: TDButton;
    DAdjustAbility: TDWindow;
    DPlusDC: TDButton;
    DPlusMC: TDButton;
    DPlusSC: TDButton;
    DPlusAC: TDButton;
    DPlusMAC: TDButton;
    DPlusHP: TDButton;
    DPlusMP: TDButton;
    DPlusHit: TDButton;
    DPlusSpeed: TDButton;
    DMinusDC: TDButton;
    DMinusMC: TDButton;
    DMinusSC: TDButton;
    DMinusAC: TDButton;
    DMinusMAC: TDButton;
    DMinusMP: TDButton;
    DMinusHP: TDButton;
    DMinusHit: TDButton;
    DMinusSpeed: TDButton;
    DAdjustAbilClose: TDButton;
    DAdjustAbilOk: TDButton;
    DBotPlusAbil: TDButton;
    DKsF5: TDButton;
    DKsF6: TDButton;
    DKsF7: TDButton;
    DKsF8: TDButton;
    DEngServer1: TDButton;
    DConfigDlg: TDWindow;
    DConfigDlgClose: TDButton;
    DConfigDlgOK: TDButton;
    DKsConF1: TDButton;
    DKsConF2: TDButton;
    DKsConF3: TDButton;
    DKsConF4: TDButton;
    DKsConF5: TDButton;
    DKsConF6: TDButton;
    DKsConF7: TDButton;
    DKsConF8: TDButton;
    DBotMemo: TDButton;
    DFriendDlg: TDWindow;
    DFrdClose: TDButton;
    DFrdAdd: TDButton;
    DFrdDel: TDButton;
    DFrdBlacklist: TDButton;
    DFrdFriend: TDButton;
    DFrdMaster: TDButton;
    DMLReply: TDButton;
    DMLRead: TDButton;
    DMLLock: TDButton;
    DMLDel: TDButton;
    DMLBlock: TDButton;
    DBLDel: TDButton;
    DBLAdd: TDButton;
    DMemoB2: TDButton;
    DMemoB1: TDButton;
    DMailListDlg: TDWindow;
    DMailListClose: TDButton;
    DMailListPgUp: TDButton;
    DMailListPgDn: TDButton;
    DBlockListDlg: TDWindow;
    DBLPgUp: TDButton;
    DBLPgDn: TDButton;
    DBlockListClose: TDButton;
    DMemo: TDWindow;
    DMemoClose: TDButton;
    DButton1: TDButton;
    DButton2: TDButton;
    DChgGamePwd: TDWindow;
    DChgGamePwdClose: TDButton;
    DBotChallenge: TDButton;
    DBotTop: TDButton;
    DBotCallHero: TDButton;
    DBotHeroInfo: TDButton;
    DBotHeroBag: TDButton;
    DBotSysMsg: TDButton;
    DBotSysCRY: TDButton;
    DBotSysHear: TDButton;
    DBotSysGuild: TDButton;
    DBotAutoSys: TDButton;
    DBotFrdDown: TDButton;
    DBotFrdUp: TDButton;
    DBotMaster: TDButton;
    DMerchantDlg: TDWindow;
    DMerchantDlgClose: TDButton;
    DHeroStateWindow: TDWindow;
    DBotHeroMp: TDButton;
    DBotHeroHP: TDButton;
    DBotHeroHead: TDButton;
    DBotHeroExp: TDButton;
    DCloseHeroState: TDButton;
    DPrevHeroState: TDButton;
    DNextHeroState: TDButton;
    DHeroMag1: TDButton;
    DHeroPageUp: TDButton;
    DHeroPageDown: TDButton;
    DHeroWeapon: TDButton;
    DHeroHelmet: TDButton;
    DHeroNecklace: TDButton;
    DHeroLight: TDButton;
    DHeroArmRingL: TDButton;
    DHeroRingL: TDButton;
    DHeroRingR: TDButton;
    DHeroArmRingR: TDButton;
    DHeroBujuk: TDButton;
    DHeroBelt: TDButton;
    DHeroBoots: TDButton;
    DHeroCharm: TDButton;
    DHeroDress: TDButton;
    DShopWin: TDWindow;
    DBotShopClose: TDButton;
    DBotList1: TDButton;
    DBotList2: TDButton;
    DBotList3: TDButton;
    DBotList4: TDButton;
    DBotList5: TDButton;
    DBotBuy: TDButton;
    DBotSend: TDButton;
    DBotClose2: TDButton;
    DButFront: TDButton;
    DButNext: TDButton;
    DButShopImg: TDButton;
    DHeroItemBag: TDWindow;
    DHeroBagClose: TDButton;
    DHeroItemGrid: TDGrid;
    DRenewChr: TDWindow;
    DButRenewChr: TDButton;
    DButRenewClose: TDButton;
    DItemLeve: TDWindow;
    DButItemLeve: TDButton;
    DItemLeveClose: TDButton;
    DButLevel: TDButton;
    DButItem1: TDButton;
    DButItem3: TDButton;
    DButItem2: TDButton;
    DTaxis: TDWindow;
    DTaxisClose: TDButton;
    DTaxisMaster: TDButton;
    DTaxisHero: TDButton;
    DTaxisSelf: TDButton;
    DTaxisSelfBt: TDWindow;
    DTaxisWazird: TDButton;
    DTaxisWarr: TDButton;
    DTaxisAll: TDButton;
    DTaxisTaos: TDButton;
    DTaxisShow: TDWindow;
    DTaxisDown: TDButton;
    DTaxisUp: TDButton;
    DTaxisTop: TDButton;
    DTaxisSelfTop: TDButton;
    DTaxisBottom: TDButton;
    DOpenArk: TDWindow;
    DArkClose: TDButton;
    DArkOpen: TDButton;
    DWPlacing: TDWindow;
    DBPlacingClose: TDButton;
    DBPlacingPnd: TDButton;
    DBPlacingBuy: TDButton;
    DBPlacingCancel: TDButton;
    DBPlacingFront: TDButton;
    DBReload: TDButton;
    DBPlacingNext: TDButton;
    DSelfShop: TDWindow;
    DButSelfShop: TDButton;
    DShopClose: TDButton;
    DShopStart: TDButton;
    DShopExit: TDButton;
    DGridShop: TDGrid;
    DPicPut: TDWindow;
    DPicOk: TDButton;
    DPicClose: TDButton;
    DPicClose2: TDButton;
    DSelfShop2: TDWindow;
    DGridShop2: TDGrid;
    DShopClose2: TDButton;
    DShopStart2: TDButton;
    DShopExit2: TDButton;
    DButHorse: TDButton;
    DBuHelp: TDButton;
    DArkItem0: TDButton;
    DArkItem1: TDButton;
    DArkItem2: TDButton;
    DArkItem7: TDButton;
    DArkItem8: TDButton;
    DArkItem3: TDButton;
    DArkItem6: TDButton;
    DArkItem4: TDButton;
    DArkItem5: TDButton;
    DWBooks: TDWindow;
    DBookClose: TDButton;
    DBookNext: TDButton;
    DBookPrior: TDButton;
    DWgInfo: TDWindow;
    DWgMagic: TDButton;
    DWgProtect: TDButton;
    DWgBisic: TDButton;
    DWgClose: TDButton;
    DWgHint: TDButton;
    DWgTring: TDButton;
    DWgTop: TDButton;
    DWgDown: TDButton;
    DWgDown2: TDButton;
    DButtonLingfu: TDButton;
    DButtonPayment: TDButton;
    DPlayDrink: TDWindow;
    DPlayDrinkClose: TDButton;
    DPlayDrinkDrink: TDButton;
    DPlayDrinkGoBack: TDButton;
    DDish2: TDButton;
    DDish1: TDButton;
    DGetHero: TDWindow;
    DGetHero1: TDButton;
    DGetHero2: TDButton;
    DGetHeroClose: TDButton;
    DCompeteDrink: TDWindow;
    DCompeteDrinkClose: TDButton;
    DCompeteDrinkGo: TDButton;
    DCompeteDrink3: TDButton;
    DCompeteDrink1: TDButton;
    DCompeteDrink2: TDButton;
    DDrink1: TDButton;
    DDrink2: TDButton;
    DDrink4: TDButton;
    DDrink3: TDButton;
    DDrink5: TDButton;
    DDrink6: TDButton;
    DCompeteDrinkBG: TDButton;
    DHeroMag2: TDButton;
    DHeroMag3: TDButton;
    DHeroMag4: TDButton;
    DHeroMag5: TDButton;
    DHeroMag6: TDButton;
    DStMag6: TDButton;
    DMiniMapDlg: TDWindow;
    DWMakeWineDesk: TDWindow;
    DMakeWineHelp: TDButton;
    DMaterialMemo: TDButton;
    DStartMakeWine: TDButton;
    DMWClose: TDButton;
    DBMateria: TDButton;
    DBWineSong: TDButton;
    DBWater: TDButton;
    DBWineCrock: TDButton;
    DBassistMaterial1: TDButton;
    DBassistMaterial2: TDButton;
    DBassistMaterial3: TDButton;
    DBDrug: TDButton;
    DBWine: TDButton;
    DBWineBottle: TDButton;
    DDrunkScale: TDButton;
    DLiquorProgress: TDButton;
    DHeroLiquorProgress: TDButton;
    DButton3: TDButton;
    DButton4: TDButton;
    DNewWG: TDWindow;
    DNewWgBt1: TDButton;
    DNewWgBt2: TDButton;
    DNewWgBt3: TDButton;
    DNewWgBt4: TDButton;
    DNewWgBt5: TDButton;
    DNewWgClose: TDButton;
    DNewWg1: TDWindow;
    DNewWg2: TDWindow;
    DNewWg3: TDWindow;
    DNewWg4: TDWindow;
    DNewWg5: TDWindow;
    DCheckBox1: TDCheckBox;
    DCheckBox5: TDCheckBox;
    DCheckBox2: TDCheckBox;
    DCheckBox6: TDCheckBox;
    DCheckBox3: TDCheckBox;
    DCheckBox7: TDCheckBox;
    DCheckBox4: TDCheckBox;
    DCheckBox8: TDCheckBox;
    DCheckBox17: TDCheckBox;
    DEdit3: TDEdit;
    DEdit4: TDEdit;
    DCheckBox18: TDCheckBox;
    DEdit5: TDEdit;
    DEdit6: TDEdit;
    DCheckBox19: TDCheckBox;
    DEdit7: TDEdit;
    DEdit8: TDEdit;
    DCheckBox20: TDCheckBox;
    DEdit9: TDEdit;
    DEdit10: TDEdit;
    DCheckBox21: TDCheckBox;
    DEdit11: TDEdit;
    DCheckBox22: TDCheckBox;
    DEdit12: TDEdit;
    DCheckBox23: TDCheckBox;
    DEdit13: TDEdit;
    DComboBox2: TDComboBox;
    DCheckBox9: TDCheckBox;
    DCheckBox13: TDCheckBox;
    DComboBox3: TDComboBox;
    DCheckBox10: TDCheckBox;
    DCheckBox14: TDCheckBox;
    DCheckBox11: TDCheckBox;
    DCheckBox15: TDCheckBox;
    DCheckBox12: TDCheckBox;
    DCheckBox16: TDCheckBox;
    DEdit2: TDEdit;
    DCheckBox24: TDCheckBox;
    DHooKKey2: TDHooKKey;
    DHooKKey3: TDHooKKey;
    DHooKKey4: TDHooKKey;
    DHooKKey5: TDHooKKey;
    DHooKKey6: TDHooKKey;
    DHooKKey7: TDHooKKey;
    DHooKKey8: TDHooKKey;
    DHooKKey9: TDHooKKey;
    DHooKKey10: TDHooKKey;
    DHooKKey11: TDHooKKey;
    DHooKKey12: TDHooKKey;
    DHooKKey13: TDHooKKey;
    DHooKKey14: TDHooKKey;
    DHooKKey15: TDHooKKey;
    DWgUpDown: TDUpDown;
    DWgBTUp: TDButton;
    DWgBtMove: TDButton;
    DWgBtDown: TDButton;
    DCheckBox25: TDCheckBox;
    DCheckBox26: TDCheckBox;
    DCheckBox27: TDCheckBox;
    DCheckBox28: TDCheckBox;
    DNewWgBt6: TDButton;
    DNewWg6: TDWindow;
    DWgBtMove1: TDButton;
    DWgBTUp1: TDButton;
    DWgBtDown1: TDButton;
    DWgUpDown1: TDUpDown;
    DWChallenge: TDWindow;
    DChallengeClose: TDButton;
    DChallengeGrid: TDGrid;
    DChallengeOK: TDButton;
    DChallengeCancel: TDButton;
    DChallengeGrid1: TDGrid;
    DChallengeGold: TDButton;
    DChallengeGameDiamond: TDButton;
    //DEdit1: TDEdit;

    procedure DBottomInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DBottomDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMyStateDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DOptionClick();
    procedure DItemBagDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DRepairItemDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DRepairItemInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DStateWinDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure FormCreate(Sender: TObject);
    procedure DPrevStateDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLoginNewDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DscSelect1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DccCloseDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DItemGridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DItemGridDblClick(Sender: TObject);
    procedure DMsgDlgOkDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMsgDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMsgDlgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DCloseBagDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBackgroundBackgroundClick(Sender: TObject);
    procedure DItemGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DBelt1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure FormDestroy(Sender: TObject);
    procedure DBelt1DblClick(Sender: TObject);
    procedure DLoginCloseClick(Sender: TObject; X, Y: Integer);
    procedure DLoginOkClick(Sender: TObject; X, Y: Integer);
    procedure DLoginNewClick(Sender: TObject; X, Y: Integer);
    procedure DLoginChgPwClick(Sender: TObject; X, Y: Integer);
    procedure DNewAccountOkClick(Sender: TObject; X, Y: Integer);
    procedure DNewAccountCloseClick(Sender: TObject; X, Y: Integer);
    procedure DccCloseClick(Sender: TObject; X, Y: Integer);
    procedure DChgpwOkClick(Sender: TObject; X, Y: Integer);
    procedure DscSelect1Click(Sender: TObject; X, Y: Integer);
    procedure DCloseStateClick(Sender: TObject; X, Y: Integer);
    procedure DPrevStateClick(Sender: TObject; X, Y: Integer);
    procedure DNextStateClick(Sender: TObject; X, Y: Integer);
    procedure DSWWeaponClick(Sender: TObject; X, Y: Integer);
    procedure DMsgDlgOkClick(Sender: TObject; X, Y: Integer);
    procedure DCloseBagClick(Sender: TObject; X, Y: Integer);
    procedure DBelt1Click(Sender: TObject; X, Y: Integer);
    procedure DMyStateClick(Sender: TObject; X, Y: Integer);
    procedure DStateWinClick(Sender: TObject; X, Y: Integer);
    procedure DSWWeaponMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBelt1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DMerchantDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMerchantDlgShowText(Sender: TObject; dsurface:
      TDirectDrawSurface; Msg, SelectStr: string; X, Y: Word;
      Points: TList; var AddPoints: Boolean);
    procedure DMerchantDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DMerchantDlgClick(Sender: TObject; X, Y: Integer);
    procedure DMerchantDlgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DMerchantDlgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DMenuCloseClick(Sender: TObject; X, Y: Integer);
    procedure DMenuDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMenuDlgClick(Sender: TObject; X, Y: Integer);
    procedure DSellDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSellDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DSellDlgSpotClick(Sender: TObject; X, Y: Integer);
    procedure DSellDlgSpotDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSellDlgSpotMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DSellDlgOkClick(Sender: TObject; X, Y: Integer);
    procedure DMenuBuyClick(Sender: TObject; X, Y: Integer);
    procedure DMenuPrevClick(Sender: TObject; X, Y: Integer);
    procedure DMenuNextClick(Sender: TObject; X, Y: Integer);
    procedure DGoldClick(Sender: TObject; X, Y: Integer);
    procedure DSWLightDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBackgroundMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DStateWinMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DLoginOkSound(Sender: TObject;
      Clicksound: TClickSound);
    procedure DStMag1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DStMag1Click(Sender: TObject; X, Y: Integer);
    procedure DKsIconDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DKsF1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DKsOkClick(Sender: TObject; X, Y: Integer);
    procedure DKsF1Click(Sender: TObject; X, Y: Integer);
    procedure DKeySelDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotGroupDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGrpAllowGroupDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGrpDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotGroupClick(Sender: TObject; X, Y: Integer);
    procedure DGrpCreateClick(Sender: TObject; X, Y: Integer);
    procedure DGroupDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGrpAddMemClick(Sender: TObject; X, Y: Integer);
    procedure DGrpDelMemClick(Sender: TObject; X, Y: Integer);
    procedure DBotLogoutClick(Sender: TObject; X, Y: Integer);
    procedure DBotExitClick(Sender: TObject; X, Y: Integer);
    procedure DStPageUpClick(Sender: TObject; X, Y: Integer);
    procedure DBottomMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DDealOkClick(Sender: TObject; X, Y: Integer);
    procedure DDealCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotTradeClick(Sender: TObject; X, Y: Integer);
    procedure DDealRemoteDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DDealDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DDGridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DDGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DDGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DDRGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DDRGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DDGoldClick(Sender: TObject; X, Y: Integer);
    procedure DSServer1Click(Sender: TObject; X, Y: Integer);
    procedure DSSrvCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotMiniMapClick(Sender: TObject; X, Y: Integer);
    procedure DMenuDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DUserState1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DUserState1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DWeaponUS1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DCloseUS1Click(Sender: TObject; X, Y: Integer);
    procedure DNecklaceUS1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotGuildClick(Sender: TObject; X, Y: Integer);
    procedure DGuildDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGDUpClick(Sender: TObject; X, Y: Integer);
    procedure DGDDownClick(Sender: TObject; X, Y: Integer);
    procedure DGDCloseClick(Sender: TObject; X, Y: Integer);
    procedure DGDHomeClick(Sender: TObject; X, Y: Integer);
    procedure DGDListClick(Sender: TObject; X, Y: Integer);
    procedure DGDAddMemClick(Sender: TObject; X, Y: Integer);
    procedure DGDDelMemClick(Sender: TObject; X, Y: Integer);
    procedure DGDEditNoticeClick(Sender: TObject; X, Y: Integer);
    procedure DGDEditGradeClick(Sender: TObject; X, Y: Integer);
    procedure DGECloseClick(Sender: TObject; X, Y: Integer);
    procedure DGEOkClick(Sender: TObject; X, Y: Integer);
    procedure DGuildEditNoticeDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGDChatClick(Sender: TObject; X, Y: Integer);
    procedure DGoldDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DNewAccountDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DAdjustAbilCloseClick(Sender: TObject; X, Y: Integer);
    procedure DAdjustAbilityDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotPlusAbilClick(Sender: TObject; X, Y: Integer);
    procedure DPlusDCClick(Sender: TObject; X, Y: Integer);
    procedure DMinusDCClick(Sender: TObject; X, Y: Integer);
    procedure DAdjustAbilOkClick(Sender: TObject; X, Y: Integer);
    procedure DBotPlusAbilDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DAdjustAbilityMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DUserState1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DEngServer1Click(Sender: TObject; X, Y: Integer);
    procedure DGDAllyClick(Sender: TObject; X, Y: Integer);
    procedure DGDBreakAllyClick(Sender: TObject; X, Y: Integer);
    procedure DSelServerDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotSysCRYMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DFrdFriendDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotFriendClick(Sender: TObject; X, Y: Integer);
    procedure DFrdCloseClick(Sender: TObject; X, Y: Integer);
    procedure DChgGamePwdCloseClick(Sender: TObject; X, Y: Integer);
    procedure DChgGamePwdDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotSysMsgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBotSysMsgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotSysMsgClick(Sender: TObject; X, Y: Integer);
    procedure DFrdBlacklistDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DFrdFriendClick(Sender: TObject; X, Y: Integer);
    procedure DFriendDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DFrdAddClick(Sender: TObject; X, Y: Integer);
    procedure DBotFrdUpClick(Sender: TObject; X, Y: Integer);
    procedure DFriendDlgClick(Sender: TObject; X, Y: Integer);
    procedure DFrdDelClick(Sender: TObject; X, Y: Integer);
    procedure DBotCallHeroClick(Sender: TObject; X, Y: Integer);
    procedure DBotHeroInfoClick(Sender: TObject; X, Y: Integer);
    procedure DHeroDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DCloseHeroStateClick(Sender: TObject; X, Y: Integer);
    procedure DHeroStateWindowDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DHeroPageDownClick(Sender: TObject; X, Y: Integer);
    procedure DHeroMag1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DHeroBujukDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DHeroBeltMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBotHeroBagClick(Sender: TObject; X, Y: Integer);
    procedure DBotMemoClick(Sender: TObject; X, Y: Integer);
    procedure DBotClose2Click(Sender: TObject; X, Y: Integer);
    procedure DBotList1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotList1Click(Sender: TObject; X, Y: Integer);
    procedure DShopWinDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DHeroStateWindowMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure DButFrontClick(Sender: TObject; X, Y: Integer);
    procedure DShopWinClick(Sender: TObject; X, Y: Integer);
    procedure DButShopImgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotBuyClick(Sender: TObject; X, Y: Integer);
    procedure DBotHeroExpDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DHeroMag1DirectPaintt(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DHeroItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DHeroItemGridDblClick(Sender: TObject);
    procedure DHeroItemGridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DHeroWeaponClick(Sender: TObject; X, Y: Integer);
    procedure DBotHeroHeadClick(Sender: TObject; X, Y: Integer);
    procedure DHeroItemGridGridMouseMove(Sender: TObject; ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DHeroItemBagDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DHeroItemBagMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DRenewChrDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DRenewChrClick(Sender: TObject; X, Y: Integer);
    procedure DBotMemoDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotTopClick(Sender: TObject; X, Y: Integer);
    procedure DItemBagMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DButLevelClick(Sender: TObject; X, Y: Integer);
    procedure DItemLeveCloseClick(Sender: TObject; X, Y: Integer);
    procedure DButItem2DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DButItem1Click(Sender: TObject; X, Y: Integer);
    procedure DButItem1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DButItemLeveClick(Sender: TObject; X, Y: Integer);
    procedure DTaxisSelfClick(Sender: TObject; X, Y: Integer);
    procedure DTaxisAllDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DTaxisShowDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DTaxisShowClick(Sender: TObject; X, Y: Integer);
    procedure DTaxisShowDblClick(Sender: TObject);
    procedure DFriendDlgDblClick(Sender: TObject);
    procedure DItemBagMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DHeroItemBagMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DOpenArkDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DArkCloseClick(Sender: TObject; X, Y: Integer);
    procedure DArkOpenClick(Sender: TObject; X, Y: Integer);
    procedure DOpenArkClick(Sender: TObject; X, Y: Integer);
    procedure DWPlacingDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBPlacingCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBPlacingNextClick(Sender: TObject; X, Y: Integer);
    procedure DWPlacingClick(Sender: TObject; X, Y: Integer);
    procedure DSelfShopDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DButSelfShopClick(Sender: TObject; X, Y: Integer);
    procedure DGridShopGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DPicPutClick(Sender: TObject; X, Y: Integer);
    procedure DShopStartClick(Sender: TObject; X, Y: Integer);
    procedure DPicCloseClick(Sender: TObject; X, Y: Integer);
    procedure DPicPutDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGridShopGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DGridShopGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DShopCloseClick(Sender: TObject; X, Y: Integer);
    procedure DSelfShop2DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DShopClose2Click(Sender: TObject; X, Y: Integer);
    procedure DGridShop2GridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DGridShop2GridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DGridShop2GridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DShopStart2Click(Sender: TObject; X, Y: Integer);
    procedure DButHorseClick(Sender: TObject; X, Y: Integer);
    procedure DBuHelpClick(Sender: TObject; X, Y: Integer);
    procedure DShopWinMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DGroupDlgClick(Sender: TObject; X, Y: Integer);
    procedure DBotChallengeClick(Sender: TObject; X, Y: Integer);
    procedure DArkItem0DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DArkItem0MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DArkItem1DblClick(Sender: TObject);
    procedure DWBooksDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBookCloseDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBookCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBookNextClick(Sender: TObject; X, Y: Integer);
    procedure DBookPriorClick(Sender: TObject; X, Y: Integer);
    procedure DWgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DWgBisicClick(Sender: TObject; X, Y: Integer);
    procedure DWgInfoDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DWgTopClick(Sender: TObject; X, Y: Integer);
    procedure DWgInfoClick(Sender: TObject; X, Y: Integer);
    procedure DButtonLingfuDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DButtonLingfuClick(Sender: TObject; X, Y: Integer);
    procedure DBotSendClick(Sender: TObject; X, Y: Integer);
    procedure DPlayDrinkDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DDish2DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DDish2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DPlayDrinkMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DDish2Click(Sender: TObject; X, Y: Integer);
    procedure DPlayDrinkGoBackClick(Sender: TObject; X, Y: Integer);
    procedure DPlayDrinkDrinkClick(Sender: TObject; X, Y: Integer);
    procedure DPlayDrinkClick(Sender: TObject; X, Y: Integer);
    procedure DPlayDrinkMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DPlayDrinkMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DGetHeroDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGetHeroCloseClick(Sender: TObject; X, Y: Integer);
    procedure DGetHero1Click(Sender: TObject; X, Y: Integer);
    procedure DCompeteDrinkDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DCompeteDrinkBGDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DCompeteDrink1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DCompeteDrinkMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DCompeteDrink1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DDrink2DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DCompeteDrink3Click(Sender: TObject; X, Y: Integer);
    procedure DCompeteDrinkGoClick(Sender: TObject; X, Y: Integer);
    procedure DDrink1Click(Sender: TObject; X, Y: Integer);
    procedure DHeroMag1Click(Sender: TObject; X, Y: Integer);
    procedure DHeroMag1ClickSound(Sender: TObject; Clicksound: TClickSound);
    procedure DMiniMapDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMiniMapDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DMiniMapDlgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBotGroupMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DGrpAllowGroupClick(Sender: TObject; X, Y: Integer);
    procedure DSdWGCloseDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DWMakeWineDeskDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMakeWineHelpDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMWCloseClick(Sender: TObject; X, Y: Integer);
    procedure DMWCloseDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMakeWineHelpClick(Sender: TObject; X, Y: Integer);
    procedure DWMakeWineDeskMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBMateriaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBMateriaDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBMateriaClick(Sender: TObject; X, Y: Integer);
    procedure DLiquorProgressDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
    procedure DDrunkScaleDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
    procedure DDrunkScaleMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DLiquorProgressMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DHeroLiquorProgressDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
    procedure DHeroLiquorProgressMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DHeroDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DButton3DirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
    procedure DButton3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DButton4MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DButton4DirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
    procedure DButSelfShopDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
    procedure DNewWg1DirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
    procedure DNewWgBt1DirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
    procedure DNewWgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DNewWgBt1Click(Sender: TObject; X, Y: Integer);
    procedure DCheckBox1Click(Sender: TObject; X, Y: Integer);
    procedure DComboBox2Click(Sender: TObject; X, Y: Integer);
    procedure DComboBox3Click(Sender: TObject; X, Y: Integer);
    procedure DCheckBox4MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DNewWg1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DEdit3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DCheckBox25Click(Sender: TObject; X, Y: Integer);
    procedure DHooKKey3MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure DHooKKey3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DButtonPaymentClick(Sender: TObject; X, Y: Integer);
    procedure DChallengeCloseClick(Sender: TObject; X, Y: Integer);
    procedure DChallengeOKDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
    procedure DWChallengeDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
    procedure DChallengeGoldClick(Sender: TObject; X, Y: Integer);
    procedure DChallengeGrid1GridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DChallengeGrid1GridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DChallengeGrid1GridSelect(Sender: TObject; ACol, ARow: Integer; Shift: TShiftState);
    procedure DChallengeGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DChallengeGameDiamondClick(Sender: TObject; X, Y: Integer);
    procedure DChallengeOKClick(Sender: TObject; X, Y: Integer);
  private
    DlgTemp: TList;
    magcur, magtop: integer;
    EdDlgEdit: TEdit;
    EdPicEdit: TEdit;
    //EdHpCountEdit:TEdit;
    Memo:TMemo;
    //EmbeddedWB: TEwbCore;
    WebPanel: TPanel;
    BottonPanel: TPanel;
    ExitWebBtn: TRzBitBtn;

    ViewDlgEdit: Boolean;
    msglx, msgly: integer;
    MenuTop: integer;

    MagKeyIcon, MagKeyCurKey: integer;
    MagKeyMagName: string;
    MagicPage: integer;
    HeroMagIcPage: Integer;

    m_dwBlinkTime: LongWord;
    m_boViewBlink: Boolean;

    BlinkTime: longword;
    BlinkCount: integer; //0..9荤捞甫 馆汗
    FirMemoIdx: Integer;
    FirCheckIdx: Integer;
    FirCheckCount: Integer;
    FirCheckName: string[ActorNameLen];

    procedure HideAllControls;
    procedure RestoreHideControls;
    procedure PageChanged(Sender: TObject);
    procedure DealItemReturnBag(mitem: TClientItem);
    procedure DealZeroGold;
    procedure OpenSoundOption;
    procedure EdDlgEditKeyPress(Sender: TObject; var Key: Char);
  public
    m_PlayDrinkNpc: Integer;
    m_PlayDrinkIdx: Byte;
    m_PlayDrinkName: string;
    m_PlayDrinkMsgTop: string;
    m_PlayDrinkMsgBoom: string;
    m_PlayDrinkAddPointsTop: Boolean;
    m_PlayDrinkPointsTop: TList;
    m_PlayDrinkAddPointsBoom: Boolean;
    m_PlayDrinkPointsBoom: TList;
    m_PlayDrinkItem: array[0..1] of TClientItem;
    m_PlayDrinkSelectMenuStr: string;
    m_PlayDrinkStart: Boolean;
    m_PlayDrinkStartIdx: Byte;
    m_PlayDrinkTime: LongWord;

    //m_CompeteDrinkNpc:Integer;
    m_CompeteDrinkIdx: Byte;
    m_CompeteDrinkName: string;
    m_CompeteDrinkNpcCount: Byte;
    m_CompeteDrinkSelfCount: Byte;
    m_CompeteDrinkTempNpcCount: Byte;
    m_CompeteDrinkTempSelfCount: Byte;
    m_CompeteDrinkTempTime: LongWord;
    m_CompeteButTime: LongWord;
    m_CompeteNpcIdx: Byte;
    m_COmpeteSelfIdx: Byte;
    m_ComPeteWilIdx: Byte;
    m_CompeteNpcDrink: Boolean;
    m_CompeteSelfDrink: Boolean;
    //m_CompeteDrinkMsgTop:String;
    //m_CompeteDrinkMsgBoom:String;
    //m_CompeteDrinkAddPointsTop:Boolean;
    //m_CompeteDrinkPointsTop:TList;
    //m_CompeteDrinkAddPointsBoom:Boolean;
    //m_CompeteDrinkPointsBoom:TList;
    //m_CompeteDrinkSelectMenuStr:String;
    m_CompeteDrinkStart: Boolean;
    m_CompeteDrinkStartIdx: Byte;
    m_CompeteDrinkTime: LongWord;
    m_CompeteDrinkType: TPlayDrink;
    m_CompeteDrinkButIdx: Byte;
    m_CompeteDrinkButTime: LongWord;
    m_CompeteDrinkButCls: Boolean;
    m_CompeteDrinkDrinkIdx: Byte;
    m_CompeteDrinkIdxList: TList;
    m_CompeteDrinkNpcSelectTime: LongWord;
    m_CompeteDrinkNpcSelectMaxTime: LongWord;

    EdPlacingEdit: TEdit;
    StatePage2: integer;
    MsgText: string;
    DialogSize: integer;
    RenewChrIdx: Integer;

    HeroStatePage: Integer;
    ShopIdx: Byte;
    ShopButId: Byte;
    ShopButTick: Longword;
    CheckShopIdx: Integer;
    ShopPage: Integer;
    ShowItem: pTNewFileItem;
    ShowItemIdx: Integer;
    showWineidx:integer;
    ShowItemTime: LongWord;
    showWineTime: LongWord;
    HeroBagImage: Integer;
    //    m_nMinMapX: Integer;
     //   m_nMinMapY: Integer;
    m_nLevelIdx: Integer;
    m_nLevelTick: LongWord;
    m_nTaxisTitleIdx: Integer;
    m_nTaxisListIdx: Integer;
    m_nPageMax: Integer;
    m_nPageidx: Integer;
    m_nTaxisCkIdx: Integer;
    m_dwTaxisTime: LongWord;
    m_nMouseIdx: integer;
    m_boShowGold: Boolean;
    m_nOpenArkIdx: integer;
    m_dwOpenArkTick: LongWord;
    m_boOpenArk: Boolean;
    m_boOpenBox: Boolean;
    m_LightIdx: Byte;
    m_LightTick: LongWord;
    m_nOpenIdx: Byte;
    m_nOpenEffIdx: Byte;
    m_dwOpenEffTick: LongWord;
    m_boOpenEff: Boolean;
    m_boOpenMove: Boolean;
    m_boOpenMoveEnd: Boolean;
    m_boOpenMoveTick: LongWord;
    m_nOpenMoveTick: LongWord;
    m_boOpenMoveTime: LongWord;
    m_nOpenEndMoveTick: LongWord;
    m_nOpenEndIdx: Byte;
    m_nOpenMoveGold: Integer;
    m_nOpenMoveGameGold: Integer;
    m_newwgidx : Integer;

    m_SellIdx: integer;
    m_SellFind: Integer;
    m_SellPageMax: Integer;
    m_SellPageIdx: Integer;
    m_SellTime: LongWord;
    m_SellFindStr: string;
    m_SellClientPlacing: TClientPlacing;
    m_Selliname, m_Selld1, m_Selld2, m_Selld3,m_Selld4: string;

    m_nPlacingIdx: integer;
    m_boRING: Boolean;
    m_boARMRING: Boolean;
    m_boAutoGroup: Boolean;
    m_nOpenBooksIdx: Byte;
    m_nBooksIdx: Byte;

    {
    m_n66C:Integer;
    m_n688:Integer;
    m_n6A4:Integer;
    m_n6A8:Integer;
    }
//    m_Dicea:array[0..35] of Integer;

    m_nDiceCount: Integer;
    m_boPlayDice: Boolean;
    m_Dice: array[0..9] of TDiceInfo;
    m_WgIdx: Byte;
    m_WgHintIdx: Byte;

    MerchantName: string;
    MerchantFace: integer;
    MDlgStr: string;
    MDlgPoints: TList;
    RequireAddPoints: Boolean;
    NpcTempList: TStringList;
    AutoColorIdx: Byte;
    AutoTick: LongWord;
    SelectMenuStr: string;
    LastestClickTime: longword;
    SpotDlgMode: TSpotDlgMode;

    MenuList: TList; //list of PTClientGoods
    MenuIndex: integer;
    CurDetailItem: string;
    MenuTopLine: integer;
    BoDetailMenu: Boolean;
    BoStorageMenu: Boolean;
    BoNoDisplayMaxDura: Boolean;
    BoMakeDrugMenu: Boolean;
    NAHelps: TStringList;
    NewAccountTitle: string;

    DlgEditText: string;
    DlgPic: Integer;
    DlgBut: Boolean;
    DlgCls: Boolean;
    DlgShopTime: LongWord;
    DlgShopItem: TShopItem;
    UserState1: TUserStateInfo;

    m_HelpTick: LongWord;

    Guild: string;
    GuildFlag: string;
    GuildCommanderMode: Boolean;
    GuildStrs: TStringList;
    GuildStrs2: TStringList;
    GuildNotice: TStringList;
    GuildMembers: TStringList;
    GuildTopLine: integer;
    GuildEditHint: string;
    GuildChats: TStringList;
    BoGuildChat: Boolean;

    // procedure EmbeddedWBCloseQuery(Sender: TObject; var CanClose: Boolean);
     //procedure WebCloseQuery();
     //procedure WebBtnChick(Sender: TObject);
     //procedure OpenGameWeb(Url:String);

    procedure Initialize;
    procedure OpenMyStatus;
    procedure OpenUserState(UserState: TUserStateInfo);
    procedure OpenItemBag;
    procedure ViewBottomBox(visible: Boolean);
    procedure CancelItemMoving;
    procedure DropMovingItem;
    procedure OpenAdjustAbility;

    procedure ShowSelectServerDlg;
    function DMessageDlg(msgstr: string; DlgButtons: TMsgDlgButtons):
      TModalResult;
    function DPicDlg(msgstr: string): Boolean;
    procedure ShowMDlg(face: integer; mname, msgstr: string);
    procedure ShowGuildDlg;
    procedure ShowGuildEditNotice;
    procedure ShowGuildEditGrade;

    procedure ResetMenuDlg;
    procedure ShowShopMenuDlg;
    procedure ShowShopSellDlg;
    procedure CloseDSellDlg;
    procedure CloseMDlg;
    procedure CloseDrink;

    procedure ToggleShowGroupDlg;
    procedure OpenDealDlg;
    procedure OPenChallengeDlg;
    procedure CloseDealDlg;

    procedure OpenFriendDlg;

    procedure SoldOutGoods(itemserverindex: integer);
    procedure DelStorageItem(itemserverindex: integer);
    procedure GetMouseItemInfo(var iname, line1, line2, line3,line31: string; var
      useable: boolean; boHero: Boolean = False);
    procedure SetMagicKeyDlg(icon: integer; magname: string; var curkey: word);
    procedure AddGuildChat(str: string);
    procedure ShowWgWindows();
    procedure ShopSellWindows();
    procedure SetMiniMapSize(flag: Byte);
    function CheckItemStdMode(Sender: TObject;StdMode:Integer):Boolean;
    procedure OpenMakeWineDesk();
  end;

var
  FrmDlg: TFrmDlg;
implementation

uses
  ClMain, MShare, Share, SDK, Actor, magiceff, FrmWg, WShare, WIl;

{$R *.DFM}

{
   ##  MovingItem.Index
      1~n : 啊规芒狼 酒捞袍 鉴辑
      -1~-8 : 厘馒芒俊辑狼 酒捞袍 鉴辑
      -97 : 背券芒狼 捣
      -98 : 捣
      -99 : 迫扁 芒俊辑狼 酒捞袍 鉴辑
      -20~29: 背券芒俊辑狼 酒捞袍 鉴辑
}

procedure TFrmDlg.FormCreate(Sender: TObject);
begin
  try //程序自动增加
    m_CompeteDrinkIdx := 0;
    m_CompeteDrinkName := '晋升网络';
    { m_CompeteDrinkMsgTop:='';
     m_CompeteDrinkMsgBoom:='';
     m_CompeteDrinkAddPointsTop:=False;
     m_CompeteDrinkPointsTop:=TList.Create;
     m_CompeteDrinkAddPointsBoom:=False;
     m_CompeteDrinkPointsBoom:=TList.Create;
     m_CompeteDrinkSelectMenuStr:='';  }
    m_CompeteDrinkStart := False;
    m_CompeteDrinkStartIdx := 0;
    m_CompeteDrinkTime := 0;
    m_newwgidx := 0;
    m_PlayDrinkIdx := 0;
    m_PlayDrinkName := '晋升网络';
    m_PlayDrinkMsgTop := '';
    m_PlayDrinkMsgBoom := '';
    m_PlayDrinkAddPointsTop := False;
    m_PlayDrinkPointsTop := TList.Create;
    ;
    m_PlayDrinkAddPointsBoom := False;
    m_PlayDrinkPointsBoom := TList.Create;
    m_CompeteDrinkIdxList := TList.Create;
    FillChar(m_PlayDrinkItem, SizeOf(m_PlayDrinkItem), #0);
    m_PlayDrinkNpc := 0;
    m_PlayDrinkSelectMenuStr := '';
    m_CompeteDrinkDrinkIdx := 255;
    m_CompeteDrinkButIdx := 255;
    m_PlayDrinkStart := False;
    m_WgIdx := 0;
    m_WgHintIdx := 0;
    m_HelpTick := GetTickCount;
    DlgCls := False;
    DlgShopTime := GetTickCount;
    m_nPlacingIdx := -1;
    m_boRING := False;
    m_boARMRING := False;
    g_OpenArkItem.S.Name := '';
    g_OpenArkKeyItem.S.Name := '';
    m_nOpenArkIdx := 0;
    m_boAutoGroup := False;
    m_dwOpenArkTick := GetTickCount;
    m_boOpenArk := False;
    m_boOpenBox := False;
    StatePage2 := 0;
    HeroStatePage := 0;
    m_dwTaxisTime := GetTickCount;
    m_SellTime := GetTickCount;
    DlgTemp := TList.Create;
    DialogSize := 1; //扁夯 农扁
    m_nDiceCount := 0;
    m_boPlayDice := False;
    magcur := 0;
    magtop := 0;
    m_nMouseIdx := 0;
    m_boShowGold := False;
    MDlgPoints := TList.Create;
    SelectMenuStr := '';
    MenuList := TList.Create;
    MenuIndex := -1;
    MenuTopLine := 0;
    NpcTempList := TStringLIst.Create;
    m_nTaxisTitleIdx := 0;
    m_nTaxisListIdx := 0;
    m_nPageMax := 0;
    m_nPageidx := 0;
    BoDetailMenu := FALSE;
    BoStorageMenu := FALSE;
    BoNoDisplayMaxDura := FALSE;
    BoMakeDrugMenu := FALSE;
    MagicPage := 0;
    HeroMagIcPage := 0;
    m_nTaxisCkIdx := -1;
    NAHelps := TStringList.Create;
    BlinkTime := GetTickCount;
    BlinkCount := 0;
    m_dwBlinkTime := GetTickCount;
    m_boViewBlink := True;
    m_nLevelIdx := -1;
    m_nLevelTick := GetTickCount;

    g_SellDlgItem2.S.Name := '';
    g_SellOffItem.Item.S.Name := '';
    FillChar(g_ChallengeWaitItem,Sizeof(TClientItem),#0);
    Guild := '';
    GuildFlag := '';
    GuildCommanderMode := FALSE;
    GuildStrs := TStringList.Create;
    GuildStrs2 := TStringList.Create; //归诀侩
    GuildNotice := TStringList.Create;
    GuildMembers := TStringList.Create;
    GuildChats := TStringList.Create;

    EdPicEdit := TEdit.Create(FrmMain.Owner);
    with EdPicEdit do
    begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Size := 9;
      Font.Name := '宋体';
      MaxLength := 10;
      Height := 18;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;
      OnKeyPress := EdDlgEditKeyPress;
      Visible := FALSE;
    end;

    EdPlacingEdit := TEdit.Create(FrmMain.Owner);
    with EdPlacingEdit do
    begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Size := 9;
      Font.Name := '宋体';
      MaxLength := 14;
      Height := 18;
      Ctl3d := FALSE;
      BorderStyle := bsSingle; {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
    end;

    EdDlgEdit := TEdit.Create(FrmMain.Owner);
    with EdDlgEdit do
    begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Size := 10;
      MaxLength := 30;
      Height := 16;
      Ctl3d := FALSE;
      BorderStyle := bsSingle; {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
    end;

    Memo := TMemo.Create(FrmMain.Owner);
    with Memo do
    begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Size := 10;
      Ctl3d := FALSE;
      BorderStyle := bsSingle; {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
    end;

  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.FormCreate'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.FormDestroy(Sender: TObject);
begin
  try //程序自动增加
    DlgTemp.Free;
    MDlgPoints.Free; //埃窜洒..
    m_PlayDrinkPointsTop.Free;
    m_PlayDrinkPointsBoom.Free;
    m_CompeteDrinkIdxList.Free;
    //m_CompeteDrinkPointsTop.Free;
    //m_CompeteDrinkPointsBoom.Free;
    MenuList.Free;
    NAHelps.Free;
    GuildStrs.Free;
    GuildStrs2.Free;
    GuildNotice.Free;
    GuildMembers.Free;
    GuildChats.Free;
    NpcTempList.Free;

  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.FormDestroy'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.HideAllControls;
var
  i: integer;
  c: TControl;
begin
  try //程序自动增加
    DlgTemp.Clear;
    with FrmMain do
      for i := 0 to ControlCount - 1 do
      begin
        c := Controls[i];
        if c is TEdit then
          if (c.Visible) and (c <> EdDlgEdit) then
          begin
            DlgTemp.Add(c);
            c.Visible := FALSE;
          end;
      end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.HideAllControls'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.RestoreHideControls;
var
  i: integer;
  c: TControl;
begin
  try //程序自动增加
    for i := 0 to DlgTemp.Count - 1 do
    begin
      TControl(DlgTemp[i]).Visible := TRUE;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.RestoreHideControls'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.Initialize; //霸烙阑 府胶配绢且锭付促 龋免凳
var
  i: integer;
  d: TDirectDrawSurface;
  dd: TDirectDrawSurface;
begin
  try //程序自动增加
    g_DWinMan.ClearAll;

    DBackground.Left := 0;
    DBackground.Top := 0;
    DBackground.Width := SCREENWIDTH;
    DBackground.Height := SCREENHEIGHT;
    DBackground.Background := TRUE;
    g_DWinMan.AddDControl(DBackground, TRUE);

    {-----------------------------------------------------------}

    //皋技瘤 促捞倔肺弊 芒
    d := g_WMainImages.Images[360];
    if d <> nil then
    begin
      DMsgDlg.SetImgIndex(g_WMainImages, 360);
      DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
      DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
    end;
    DMsgDlgOk.SetImgIndex(g_WMainImages, 361);
    DMsgDlgYes.SetImgIndex(g_WMainImages, 363);
    DMsgDlgCancel.SetImgIndex(g_WMainImages, 365);
    DMsgDlgNo.SetImgIndex(g_WMainImages, 367);
    DMsgDlgOk.Top := 126;
    DMsgDlgYes.Top := 126;
    DMsgDlgCancel.Top := 126;
    DMsgDlgNo.Top := 126;

    {-----------------------------------------------------------}

    //肺弊牢 芒
    {d := g_WMainImages.Images[60];
    if d <> nil then begin
       DLogIn.SetImgIndex (g_WMainImages, 60);
       DLogIn.Left := (SCREENWIDTH - d.Width) div 2;
       DLogIn.Top := (SCREENHEIGHT - d.Height) div 2;
    end;
    DLoginNew.SetImgIndex (g_WMainImages, 61);
    DLoginNew.Left := 25;
    DLoginNew.Top  := 207;
    DLoginOk.SetImgIndex (g_WMainImages, 62);
    DLoginOk.Left := 169;
    DLoginOk.Top := 163;
    DLoginChgPw.SetImgIndex (g_WMainImages, 53);
    DLoginChgPw.Left := 130;
    DLoginChgPw.Top  := 207;
    DLoginClose.SetImgIndex (g_WMainImages, 64);
    DLoginClose.Left := 252;
    DLoginClose.Top := 28;   }
    d := g_WMain3Images.Images[18];
    if d <> nil then
    begin
      DLogIn.SetImgIndex(g_WMain3Images, 18);
      DLogIn.Left := (SCREENWIDTH - d.Width) div 2;
      DLogIn.Top := (SCREENHEIGHT - d.Height) div 2;
    end;
    DLoginNew.SetImgIndex(g_WMainImages, 61);
    DLoginNew.Left := 32;
    DLoginNew.Top := 173;
    DLoginOk.SetImgIndex(g_WMain3Images, 10);
    DLoginOk.Left := 164;
    DLoginOk.Top := 172;
    DLoginChgPw.SetImgIndex(g_WMain3Images, 28);
    DLoginChgPw.Left := 164;
    DLoginChgPw.Top := 215;
    DLoginClose.SetImgIndex(g_WMainImages, 64);
    DLoginClose.Left := 258;
    DLoginClose.Top := 24;

    {-----------------------------------------------------------}
    //服务器选择窗口
    if not EnglishVersion then
    begin
      d := g_WMainImages.Images[160]; //81];
      if d <> nil then
      begin
        DSelServerDlg.SetImgIndex(g_WMainImages, 160);
        DSelServerDlg.Left := (SCREENWIDTH - d.Width) div 2;
        DSelServerDlg.Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      DSSrvClose.SetImgIndex(g_WMainImages, 64);
      DSSrvClose.Left := 448;
      DSSrvClose.Top := 33;

      DSServer1.SetImgIndex(g_WMainImages, 161); //82);
      DSServer1.Left := 134;
      DSServer1.Top := 102;
      DSServer2.SetImgIndex(g_WMainImages, 162); //83);
      DSServer2.Left := 236;
      DSServer2.Top := 101;
      DSServer3.SetImgIndex(g_WMainImages, 163);
      DSServer3.Left := 87;
      DSServer3.Top := 190;
      DSServer4.SetImgIndex(g_WMainImages, 164);
      DSServer4.Left := 280;
      DSServer4.Top := 190;
      DSServer5.SetImgIndex(g_WMainImages, 165);
      DSServer5.Left := 134;
      DSServer5.Top := 280;
      DSServer6.SetImgIndex(g_WMainImages, 166);
      DSServer6.Left := 236;
      DSServer6.Top := 280;
      DEngServer1.Visible := FALSE;
    end
    else
    begin
      d := g_WMainImages.Images[256]; //81];
      if d <> nil then
      begin
        DSelServerDlg.SetImgIndex(g_WMainImages, 256);
        DSelServerDlg.Left := (SCREENWIDTH - d.Width) div 2;
        DSelServerDlg.Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      DSSrvClose.SetImgIndex(g_WMainImages, 64);
      DSSrvClose.Left := 245;
      DSSrvClose.Top := 31;
      {
            DEngServer1.SetImgIndex (g_WMainImages, 257);
            DEngServer1.Left := 65;
            DEngServer1.Top  := 204;
      }

      DSServer1.SetImgIndex(g_WMain3Images, 2);
      DSServer1.Left := 65;
      DSServer1.Top := 100;

      DSServer2.SetImgIndex(g_WMain3Images, 2);
      DSServer2.Left := 65;
      DSServer2.Top := 145;

      DSServer3.SetImgIndex(g_WMain3Images, 2);
      DSServer3.Left := 65;
      DSServer3.Top := 190;

      DSServer4.SetImgIndex(g_WMain3Images, 2);
      DSServer4.Left := 65;
      DSServer4.Top := 235;

      DSServer5.SetImgIndex(g_WMain3Images, 2);
      DSServer5.Left := 65;
      DSServer5.Top := 280;

      DSServer6.SetImgIndex(g_WMain3Images, 2);
      DSServer6.Left := 65;
      DSServer6.Top := 325;

      DEngServer1.Visible := FALSE;
      DSServer1.Visible := FALSE;
      DSServer2.Visible := FALSE;
      DSServer3.Visible := FALSE;
      DSServer4.Visible := FALSE;
      DSServer5.Visible := FALSE;
      DSServer6.Visible := FALSE;

    end;

    {-----------------------------------------------------------}

    //登录窗口
    d := g_WMainImages.Images[63];
    if d <> nil then
    begin
      DNewAccount.SetImgIndex(g_WMainImages, 63);
      DNewAccount.Left := (SCREENWIDTH - d.Width) div 2;
      DNewAccount.Top := (SCREENHEIGHT - d.Height) div 2;
    end;
    DNewAccountOk.SetImgIndex(g_WMainImages, 62);
    DNewAccountOk.Left := 158;
    DNewAccountOk.Top := 417;
    DNewAccountCancel.SetImgIndex(g_WMainImages, 52);
    DNewAccountCancel.Left := 447;
    DNewAccountCancel.Top := 419;
    DNewAccountClose.SetImgIndex(g_WMainImages, 64);
    DNewAccountClose.Left := 587;
    DNewAccountClose.Top := 33;

    {-----------------------------------------------------------}

    //修改密码窗口
    d := g_WMainImages.Images[50];
    if d <> nil then
    begin
      DChgPw.SetImgIndex(g_WMainImages, 50);
      DChgPw.Left := (SCREENWIDTH - d.Width) div 2;
      DChgPw.Top := (SCREENHEIGHT - d.Height) div 2;
    end;
    DChgpwOk.SetImgIndex(g_WMainImages, 81);
    DChgPwOk.Left := 181;
    DChgPwOk.Top := 253;
    DChgpwCancel.SetImgIndex(g_WMainImages, 52);
    DChgPwCancel.Left := 276;
    DChgPwCancel.Top := 252;

    {-----------------------------------------------------------}

    //选择角色窗口
    DSelectChr.Left := 0;
    DSelectChr.Top := 0;
    DSelectChr.Width := SCREENWIDTH;
    DSelectChr.Height := SCREENHEIGHT;
    DscSelect1.SetImgIndex(g_WMainImages, 66);
    DscSelect2.SetImgIndex(g_WMainImages, 67);
    DscStart.SetImgIndex(g_WMainImages, 68);
    DscNewChr.SetImgIndex(g_WMainImages, 69);
    DscEraseChr.SetImgIndex(g_WMainImages, 70);
    DscCredits.SetImgIndex(g_WMain3Images, 405);
    DscExit.SetImgIndex(g_WMainImages, 72);

    DscSelect1.Left := (SCREENWIDTH - 800) div 2 + 134 {134};
    DscSelect1.Top := (SCREENHEIGHT - 600) div 2 + 454 {454};
    DscSelect2.Left := (SCREENWIDTH - 800) div 2 + 685 {685};
    DscSelect2.Top := (SCREENHEIGHT - 600) div 2 + 454 {454};
    DscStart.Left := (SCREENWIDTH - 800) div 2 + 385 {385};
    DscStart.Top := (SCREENHEIGHT - 600) div 2 + 456 {456};
    DscNewChr.Left := (SCREENWIDTH - 800) div 2 + 348 {348};
    DscNewChr.Top := (SCREENHEIGHT - 600) div 2 + 486 {486};
    DscEraseChr.Left := (SCREENWIDTH - 800) div 2 + 347 {347};
    DscEraseChr.Top := (SCREENHEIGHT - 600) div 2 + 506 {506};
    DscCredits.Left := (SCREENWIDTH - 800) div 2 + 346 {362};
    DscCredits.Top := (SCREENHEIGHT - 600) div 2 + 527 {527};
    DscExit.Left := (SCREENWIDTH - 800) div 2 + 379 {379};
    DscExit.Top := (SCREENHEIGHT - 600) div 2 + 547 {547};

    {-----------------------------------------------------------}

    //恢复角色窗口
    d := g_WMain3Images.Images[406];
    if d <> nil then
    begin
      DRenewChr.SetImgIndex(g_WMain3Images, 406);
      DRenewChr.Left := (SCREENWIDTH - d.Width) div 2;
      DRenewChr.Top := (SCREENHEIGHT - d.Height) div 2;
    end;
    DButRenewClose.SetImgIndex(g_WMainImages, 64);
    DButRenewClose.Left := 247;
    DButRenewClose.Top := 30;
    DButRenewChr.SetImgIndex(g_WMain3Images, 407);
    DButRenewChr.Left := 100;
    DButRenewChr.Top := 360;
    //创建角色窗口
    d := g_WMainImages.Images[73];
    if d <> nil then
    begin
      DCreateChr.SetImgIndex(g_WMainImages, 73);
      DCreateChr.Left := (SCREENWIDTH - d.Width) div 2;
      DCreateChr.Top := (SCREENHEIGHT - d.Height) div 2;
    end;
    DccWarrior.SetImgIndex(g_WMainImages, 74);
    DccWizzard.SetImgIndex(g_WMainImages, 75);
    DccMonk.SetImgIndex(g_WMainImages, 76);
    //DccReserved.SetImgIndex (g_WMainImages.Images[76], TRUE);
    DccMale.SetImgIndex(g_WMainImages, 77);
    DccFemale.SetImgIndex(g_WMainImages, 78);
    DccLeftHair.SetImgIndex(g_WMainImages, 79);
    DccRightHair.SetImgIndex(g_WMainImages, 80);
    DccOk.SetImgIndex(g_WMainImages, 62);
    DccClose.SetImgIndex(g_WMainImages, 64);
    DccWarrior.Left := 48;
    DccWarrior.Top := 157;
    DccWizzard.Left := 93;
    DccWizzard.Top := 157;
    DccMonk.Left := 138;
    DccMonk.Top := 157;
    //DccReserved.Left := 183;
    //DccReserved.Top := 157;
    DccMale.Left := 93;
    DccMale.Top := 231;
    DccFemale.Left := 138;
    DccFemale.Top := 231;
    DccLeftHair.Left := 76;
    DccLeftHair.Top := 308;
    DccRightHair.Left := 170;
    DccRightHair.Top := 308;
    DccOk.Left := 104;
    DccOk.Top := 361;
    DccClose.Left := 248;
    DccClose.Top := 31;

    //比酒设置
    d := g_WMain2Images.Images[341];
    if d <> nil then
    begin
      DCompeteDrink.SetImgIndex(g_WMain2Images, 341);
      DCompeteDrink.Left := (SCREENWIDTH - d.Width) div 2;
      ;
      DCompeteDrink.Top := (SCREENHEIGHT - d.Height) div 2 - 100;
    end;

    DCompeteDrinkClose.SetImgIndex(g_WMain3Images, 233);
    DCompeteDrinkClose.Left := 428; // 399;
    DCompeteDrinkClose.Top := 35;

    DCompeteDrink1.SetImgIndex(g_WMain2Images, 348);
    DCompeteDrink1.Left := 394; // 399;
    DCompeteDrink1.Top := 240;

    DCompeteDrink2.SetImgIndex(g_WMain2Images, 350);
    DCompeteDrink2.Left := 349; // 399;
    DCompeteDrink2.Top := 248;

    DCompeteDrink3.SetImgIndex(g_WMain2Images, 352);
    DCompeteDrink3.Left := 342; // 399;
    DCompeteDrink3.Top := 293;

    DCompeteDrinkGo.SetImgIndex(g_WMain2Images, 358);
    DCompeteDrinkGo.Left := 391; // 399;
    DCompeteDrinkGo.Top := 287;

    DDrink1.SetImgIndex(g_WMain2Images, 363);
    DDrink1.Left := 105; // 399;
    DDrink1.Top := 170;

    DDrink2.SetImgIndex(g_WMain2Images, 363);
    DDrink2.Left := 160; // 399;
    DDrink2.Top := 142;

    DDrink3.SetImgIndex(g_WMain2Images, 363);
    DDrink3.Left := 224; // 399;
    DDrink3.Top := 142;

    DDrink4.SetImgIndex(g_WMain2Images, 363);
    DDrink4.Left := 281; // 399;
    DDrink4.Top := 170;

    DDrink5.SetImgIndex(g_WMain2Images, 363);
    DDrink5.Left := 224; // 399;
    DDrink5.Top := 189;

    DDrink6.SetImgIndex(g_WMain2Images, 363);
    DDrink6.Left := 160; // 399;
    DDrink6.Top := 189;

    DCompeteDrinkBG.SetImgIndex(g_WMain2Images, 339);
    DCompeteDrinkBG.Left := 0; // 399;
    DCompeteDrinkBG.Top := 0;

    // 取回英雄设置
    d := g_WMain2Images.Images[501];
    if d <> nil then
    begin
      DGetHero.SetImgIndex(g_WMain2Images, 501);
      DGetHero.Left := (SCREENWIDTH - d.Width) div 2;
      ;
      DGetHero.Top := (SCREENHEIGHT - d.Height) div 2;
    end;

    DGetHeroClose.SetImgIndex(g_WMainImages, 64);
    DGetHeroClose.Left := 244; // 399;
    DGetHeroClose.Top := 16;

    DGetHero1.SetImgIndex(g_WMain2Images, 508);
    DGetHero1.Left := 67; // 399;
    DGetHero1.Top := 171;

    DGetHero2.SetImgIndex(g_WMain2Images, 508);
    DGetHero2.Left := 185; // 399;
    DGetHero2.Top := 171;

    //请酒设置
    d := g_WMain2Images.Images[340];
    if d <> nil then
    begin
      DPlayDrink.SetImgIndex(g_WMain2Images, 340);
      DPlayDrink.Left := 0;
      DPlayDrink.Top := 0;
    end;
    DPlayDrinkClose.SetImgIndex(g_WMain3Images, 233);
    DPlayDrinkClose.Left := 376; // 399;
    DPlayDrinkClose.Top := 39;

    DPlayDrinkDrink.SetImgIndex(g_WMain2Images, 354);
    DPlayDrinkDrink.Left := 285; // 399;
    DPlayDrinkDrink.Top := 262;

    DPlayDrinkGoBack.SetImgIndex(g_WMain2Images, 356);
    DPlayDrinkGoBack.Left := 335; // 399;
    DPlayDrinkGoBack.Top := 262;

    DDish1.SetImgIndex(g_WMain2Images, 365);
    DDish1.Left := 120; // 399;
    DDish1.Top := 138;

    DDish2.SetImgIndex(g_WMain2Images, 365);
    DDish2.Left := 203; // 399;
    DDish2.Top := 169;


    //内挂配置             1
    d := g_WMain3Images.Images[360];
    if d <> nil then
    begin
      DWgInfo.SetImgIndex(g_WMain3Images, 360);
      DWgInfo.Left := SCREENWIDTH - d.Width - 20;
      DWgInfo.Top := 20;
    end;
    {DEdit1.Left:=20;
    DEdit1.Top:=20;
    DEdit1.Width:=30;
    DEdit1.Height:=30;}
    //DEdit1.SetImgIndex (g_WMain3Images,354);
    DWgBisic.Left := 11; // 399;
    DWgBisic.Top := 11;
    DWgBisic.SetImgIndex(g_WMain3Images, 354);
    DWgProtect.Left := 61; // 399;
    DWgProtect.Top := 11;
    DWgProtect.SetImgIndex(g_WMain3Images, 355);
    DWgMagic.Left := 111; // 399;
    DWgMagic.Top := 11;
    DWgMagic.SetImgIndex(g_WMain3Images, 356);
    DWgTring.Left := 11; // 399;
    DWgTring.Top := 35;
    DWgTring.SetImgIndex(g_WMain3Images, 357);
    DWgHint.Left := 61; // 399;
    DWgHint.Top := 35;
    DWgHint.SetImgIndex(g_WMain3Images, 358);
    DWgClose.Left := 191; // 399;
    DWgClose.Top := 7;
    DWgClose.SetImgIndex(g_WMain3Images, 234);
    DWgTop.Left := 168;
    DWgTop.Top := 67;
    DWgTop.SetImgIndex(g_WMain3Images, 351);
    DWgDown.Left := 168;
    DWgDown.Top := 246;
    DWgDown.SetImgIndex(g_WMain3Images, 352);
    DWgDown2.Left := 158;
    DWgDown2.Top := 245;
    DWgDown2.SetImgIndex(g_WMain3Images, 352);

    {-----------------------------------------------------------}
    d := g_WMainImages.Images[50];
    if d <> nil then
    begin
      DChgGamePwd.SetImgIndex(g_WMainImages, 689);
      DChgGamePwd.Left := (SCREENWIDTH - d.Width) div 2;
      DChgGamePwd.Top := (SCREENHEIGHT - d.Height) div 2;
    end;
    DChgGamePwdClose.Left := 291; // 399;
    DChgGamePwdClose.Top := 8;
    DChgGamePwdClose.SetImgIndex(g_WMainImages, 64);

    d := g_WMain99Images.Images[43]; //惑怕
    if d <> nil then
    begin
      DPicPut.SetImgIndex(g_WMain99Images, 43);
      DPicPut.Left := (SCREENWIDTH - d.Width) div 2;
      ;
      DPicPut.Top := (SCREENHEIGHT - d.Height) div 2;
    end;
    DPicClose.SetImgIndex(g_WMain2Images, 148);
    DPicClose.Left := 190;
    DPicClose.Top := 3;

    DPicClose2.SetImgIndex(g_WMain3Images, 210);
    DPicClose2.Left := 88;
    DPicClose2.Top := 105;
    DPicOk.SetImgIndex(g_WMain3Images, 212);
    DPicOk.Left := 149;
    DPicOk.Top := 105;

    //个人商店
    d := g_WMain99Images.Images[44]; //惑怕
    if d <> nil then
    begin
      DSelfShop.SetImgIndex(g_WMain99Images, 44);
      DSelfShop.Left := (SCREENWIDTH - d.Width) div 2;
      ;
      DSelfShop.Top := (SCREENHEIGHT - d.Height) div 4;
    end;

    DShopClose.SetImgIndex(g_WMain2Images, 148);
    DShopClose.Left := 191;
    DShopClose.Top := 4;
    DShopStart.SetImgIndex(g_WMain99Images, 45);
    DShopStart.Left := 90;
    DShopStart.Top := 235;
    DShopExit.SetImgIndex(g_WMain99Images, 47);
    DShopExit.Left := 144;
    DShopExit.Top := 235;

    DGridShop.Left := 14;
    DGridShop.Top := 33;
    DGridShop.Width := 180;
    DGridShop.Height := 130;

    //书
    d := g_UIBImages.Images[13];
    if d <> nil then
    begin
      DWBooks.Width := d.Width;
      DWBooks.Height := d.Height;
      DWBooks.Left := (SCREENWIDTH - d.Width) div 2;
      ;
      DWBooks.Top := (SCREENHEIGHT - d.Height) div 8;
      DWBooks.FaceIndex := 13;
    end;
    d := g_UIBImages.Images[14];
    if d <> nil then
    begin
      DBookClose.Width := d.Width;
      DBookClose.Height := d.Height;
      DBookClose.Left := 507;
      DBookClose.top := 2;
      DBookClose.FaceIndex := 14;
    end;
    d := g_UIBImages.Images[18];
    if d <> nil then
    begin
      DBookPrior.Width := d.Width;
      DBookPrior.Height := d.Height;
      DBookPrior.Left := 54;
      DBookPrior.top := 320;
      DBookPrior.FaceIndex := 18;
    end;
    d := g_UIBImages.Images[16];
    if d <> nil then
    begin
      DBookNext.Width := d.Width;
      DBookNext.Height := d.Height;
      DBookNext.Left := 410;
      DBookNext.top := 320;
      DBookNext.FaceIndex := 16;
    end;

    //查看个人商店
    d := g_WMain99Images.Images[44]; //惑怕
    if d <> nil then
    begin
      DSelfShop2.SetImgIndex(g_WMain99Images, 44);
      DSelfShop2.Left := (SCREENWIDTH - d.Width) div 2;
      ;
      DSelfShop2.Top := (SCREENHEIGHT - d.Height) div 4;
    end;

    DShopClose2.SetImgIndex(g_WMain2Images, 148);
    DShopClose2.Left := 191;
    DShopClose2.Top := 4;
    DShopStart2.SetImgIndex(g_WMain99Images, 49);
    DShopStart2.Left := 90;
    DShopStart2.Top := 235;
    DShopExit2.SetImgIndex(g_WMain99Images, 47);
    DShopExit2.Left := 144;
    DShopExit2.Top := 235;

    DGridShop2.Left := 14;
    DGridShop2.Top := 33;
    DGridShop2.Width := 180;
    DGridShop2.Height := 130;

    //英雄背包窗口
    d := g_WMain3Images.Images[375]; //惑怕
    if d <> nil then
    begin
      DHeroItemBag.SetImgIndex(g_WMain3Images, 375);
      DHeroItemBag.Left := 0;
      DHeroItemBag.Top := 100;
    end;
    DHeroBagClose.SetImgIndex(g_WMainImages, 371);
    DHeroBagClose.Left := 208;
    DHeroBagClose.Top := 0;

    DWPlacing.SetImgIndex(g_WMain99Images, 42);
    DWPlacing.Left := 0;
    DWPlacing.Top := 0;

    DBPlacingClose.SetImgIndex(g_WMainImages, 371);
    DBPlacingClose.Left := 446;
    DBPlacingClose.Top := 6;

    DBPlacingPnd.SetImgIndex(g_WMain3Images, 183);
    DBPlacingPnd.Left := 145;
    DBPlacingPnd.Top := 326;
    DBPlacingBuy.SetImgIndex(g_WMain3Images, 179);
    DBPlacingBuy.Left := 330;
    DBPlacingBuy.Top := 326;
    DBPlacingCancel.SetImgIndex(g_WMain3Images, 181);
    DBPlacingCancel.Left := 397;
    DBPlacingCancel.Top := 326;

    DBPlacingFront.SetImgIndex(g_WMainImages, 388);
    DBPlacingFront.Left := 216;
    DBPlacingFront.Top := 355;
    DBReload.SetImgIndex(g_WMain3Images, 177);
    DBReload.Left := 259;
    DBReload.Top := 356;
    DBPlacingNext.SetImgIndex(g_WMainImages, 387);
    DBPlacingNext.Left := 303;
    DBPlacingNext.Top := 355;

    //英雄状态窗口
    d := g_WMain3Images.Images[384]; //惑怕
    if d <> nil then
    begin
      DHeroStateWindow.SetImgIndex(g_WMain3Images, 384);
      DHeroStateWindow.Left := SCREENWIDTH - d.Width;
      DHeroStateWindow.Top := 0;
    end;
    DBotHeroHead.SetImgIndex(g_WMain3Images, 365);
    DBotHeroHead.Left := 18;
    DBotHeroHead.Top := 18;
    DBotHeroHP.SetImgIndex(g_WMain3Images, 386);
    DBotHeroHP.Left := 75;
    DBotHeroHP.Top := 24;
    DBotHeroMP.SetImgIndex(g_WMain3Images, 387);
    DBotHeroMP.Left := 80;
    DBotHeroMP.Top := 37;
    DBotHeroExp.SetImgIndex(g_WMain3Images, 388);
    DBotHeroExp.Left := 80;
    DBotHeroExp.Top := 50;

    DCloseHeroState.SetImgIndex(g_WMainImages, 371);
    DCloseHeroState.Left := 8;
    DCloseHeroState.Top := 39;
    DPrevHeroState.SetImgIndex(g_WMainImages, 373);
    DNextHeroState.SetImgIndex(g_WMainImages, 372);
    DPrevHeroState.Left := 7;
    DPrevHeroState.Top := 128;
    DNextHeroState.Left := 7;
    DNextHeroState.Top := 187;

    DHeroMag1.Left := 38 + 9;
    DHeroMag1.Top := 52 + 7;
    DHeroMag1.Width := 31;
    DHeroMag1.Height := 33;

    DHeroMag2.Left := 38 + 9;
    DHeroMag2.Top := 52 + 44;
    DHeroMag2.Width := 31;
    DHeroMag2.Height := 33;

    DHeroMag3.Left := 38 + 9;
    DHeroMag3.Top := 52 + 82;
    DHeroMag3.Width := 31;
    DHeroMag3.Height := 33;

    DHeroMag4.Left := 38 + 9;
    DHeroMag4.Top := 52 + 119;
    DHeroMag4.Width := 31;
    DHeroMag4.Height := 33;

    DHeroMag5.Left := 38 + 9;
    DHeroMag5.Top := 52 + 156;
    DHeroMag5.Width := 31;
    DHeroMag5.Height := 33;

    DHeroMag6.Left := 38 + 9;
    DHeroMag6.Top := 52 + 194;
    DHeroMag6.Width := 31;
    DHeroMag6.Height := 33;

    DHeroNecklace.Left := 38 + 130;
    DHeroNecklace.Top := 52 + 35;
    DHeroNecklace.Width := 34;
    DHeroNecklace.Height := 31;
    DHeroHelmet.Left := 38 + 77;
    DHeroHelmet.Top := 52 + 41;
    DHeroHelmet.Width := 18;
    DHeroHelmet.Height := 18;
    DHeroLight.Left := 38 + 130;
    DHeroLight.Top := 52 + 73;
    DHeroLight.Width := 34;
    DHeroLight.Height := 31;
    DHeroArmRingR.Left := 38 + 4;
    DHeroArmRingR.Top := 52 + 124;
    DHeroArmRingR.Width := 34;
    DHeroArmRingR.Height := 31;
    DHeroArmRingL.Left := 38 + 130;
    DHeroArmRingL.Top := 52 + 124;
    DHeroArmRingL.Width := 34;
    DHeroArmRingL.Height := 31;
    DHeroRingR.Left := 38 + 4;
    DHeroRingR.Top := 52 + 163;
    DHeroRingR.Width := 34;
    DHeroRingR.Height := 31;
    DHeroRingL.Left := 38 + 130;
    DHeroRingL.Top := 52 + 163;
    DHeroRingL.Width := 34;
    DHeroRingL.Height := 31;
    DHeroWeapon.Left := 38 + 9;
    DHeroWeapon.Top := 52 + 28;
    DHeroWeapon.Width := 47;
    DHeroWeapon.Height := 87;
    DHeroDress.Left := 38 + 58;
    DHeroDress.Top := 52 + 70;
    DHeroDress.Width := 53;
    DHeroDress.Height := 112;

    DHeroBujuk.Left := 42;
    DHeroBujuk.Top := 254;
    DHeroBujuk.Width := 34;
    DHeroBujuk.Height := 31;

    DHeroBelt.Left := 84;
    DHeroBelt.Top := 254;
    DHeroBelt.Width := 34;
    DHeroBelt.Height := 31;

    DHeroBoots.Left := 126;
    DHeroBoots.Top := 254;
    DHeroBoots.Width := 34;
    DHeroBoots.Height := 31;

    DHeroCharm.Left := 168;
    DHeroCharm.Top := 254;
    DHeroCharm.Width := 34;
    DHeroCharm.Height := 31;

    DHeroPageUp.SetImgIndex(g_WMainImages, 398);
    DHeroPageDown.SetImgIndex(g_WMainImages, 396);
    DHeroPageUp.Left := 213;
    DHeroPageUp.Top := 113;
    DHeroPageDown.Left := 213;
    DHeroPageDown.Top := 143;

    DHeroLiquorProgress.Left:=104;
    DHeroLiquorProgress.Top:=278;
    DHeroLiquorProgress.Width:=76;
    DHeroLiquorProgress.Height:=8;



    //人物状态窗口
    d := g_WMain3Images.Images[207]; //惑怕
    if d <> nil then
    begin
      DStateWin.SetImgIndex(g_WMain3Images, 207);
      DStateWin.Left := SCREENWIDTH - d.Width;
      DStateWin.Top := 0;
    end;
    DSWNecklace.Left := 38 + 130;
    DSWNecklace.Top := 52 + 35;
    DSWNecklace.Width := 34;
    DSWNecklace.Height := 31;
    DSWHelmet.Left := 38 + 77;
    DSWHelmet.Top := 52 + 41;
    DSWHelmet.Width := 18;
    DSWHelmet.Height := 18;
    DSWLight.Left := 38 + 130;
    DSWLight.Top := 52 + 73;
    DSWLight.Width := 34;
    DSWLight.Height := 31;
    DSWArmRingR.Left := 38 + 4;
    DSWArmRingR.Top := 52 + 124;
    DSWArmRingR.Width := 34;
    DSWArmRingR.Height := 31;
    DSWArmRingL.Left := 38 + 130;
    DSWArmRingL.Top := 52 + 124;
    DSWArmRingL.Width := 34;
    DSWArmRingL.Height := 31;
    DSWRingR.Left := 38 + 4;
    DSWRingR.Top := 52 + 163;
    DSWRingR.Width := 34;
    DSWRingR.Height := 31;
    DSWRingL.Left := 38 + 130;
    DSWRingL.Top := 52 + 163;
    DSWRingL.Width := 34;
    DSWRingL.Height := 31;
    DSWWeapon.Left := 38 + 9;
    DSWWeapon.Top := 52 + 28;
    DSWWeapon.Width := 47;
    DSWWeapon.Height := 87;
    DSWDress.Left := 38 + 58;
    DSWDress.Top := 52 + 70;
    DSWDress.Width := 53;
    DSWDress.Height := 112;

    DSWBujuk.Left := 42;
    DSWBujuk.Top := 254;
    DSWBujuk.Width := 34;
    DSWBujuk.Height := 31;

    DSWBelt.Left := 84;
    DSWBelt.Top := 254;
    DSWBelt.Width := 34;
    DSWBelt.Height := 31;

    DSWBoots.Left := 126;
    DSWBoots.Top := 254;
    DSWBoots.Width := 34;
    DSWBoots.Height := 31;

    DSWCharm.Left := 168;
    DSWCharm.Top := 254;
    DSWCharm.Width := 34;
    DSWCharm.Height := 31;

    DStMag1.Left := 38 + 8;
    DStMag1.Top := 52 + 7;
    DStMag1.Width := 31;
    DStMag1.Height := 33;

    DStMag2.Left := 38 + 8;
    DStMag2.Top := 52 + 44;
    DStMag2.Width := 31;
    DStMag2.Height := 33;

    DStMag3.Left := 38 + 8;
    DStMag3.Top := 52 + 82;
    DStMag3.Width := 31;
    DStMag3.Height := 33;

    DStMag4.Left := 38 + 8;
    DStMag4.Top := 52 + 119;
    DStMag4.Width := 31;
    DStMag4.Height := 33;

    DStMag5.Left := 38 + 8;
    DStMag5.Top := 52 + 156;
    DStMag5.Width := 31;
    DStMag5.Height := 33;

    DStMag6.Left := 38 + 8;
    DStMag6.Top := 52 + 193;
    DStMag6.Width := 31;
    DStMag6.Height := 33;

    DStPageUp.SetImgIndex(g_WMainImages, 398);
    DStPageDown.SetImgIndex(g_WMainImages, 396);
    DStPageUp.Left := 213;
    DStPageUp.Top := 113;
    DStPageDown.Left := 213;
    DStPageDown.Top := 143;

    DCloseState.SetImgIndex(g_WMainImages, 371);
    DCloseState.Left := 8;
    DCloseState.Top := 39;
    DPrevState.SetImgIndex(g_WMainImages, 373);
    DNextState.SetImgIndex(g_WMainImages, 372);
    DPrevState.Left := 7;
    DPrevState.Top := 128;
    DNextState.Left := 7;
    DNextState.Top := 187;

    DLiquorProgress.Left:=104;
    DLiquorProgress.Top:=278;
    DLiquorProgress.Width:=76;
    DLiquorProgress.Height:=8;


    {-----------------------------------------------------------}

    //人物状态窗口(查看别人信息)
    d := g_WMain3Images.Images[207]; //惑怕
    if d <> nil then
    begin
      DUserState1.SetImgIndex(g_WMain3Images, 207);
      DUserState1.Left := SCREENWIDTH - d.Width - d.Width;
      DUserState1.Top := 0;
    end;
    DNecklaceUS1.Left := 38 + 130;
    DNecklaceUS1.Top := 52 + 35;
    DNecklaceUS1.Width := 34;
    DNecklaceUS1.Height := 31;

    DHelmetUS1.Left := 38 + 77;
    DHelmetUS1.Top := 52 + 41;
    DHelmetUS1.Width := 18;
    DHelmetUS1.Height := 18;

    DLightUS1.Left := 38 + 130;
    DLightUS1.Top := 52 + 73;
    DLightUS1.Width := 34;
    DLightUS1.Height := 31;

    DArmRingRUS1.Left := 38 + 4;
    DArmRingRUS1.Top := 52 + 124;
    DArmRingRUS1.Width := 34;
    DArmRingRUS1.Height := 31;

    DArmRingLUS1.Left := 38 + 130;
    DArmRingLUS1.Top := 52 + 124;
    DArmRingLUS1.Width := 34;
    DArmRingLUS1.Height := 31;

    DRingRUS1.Left := 38 + 4;
    DRingRUS1.Top := 52 + 163;
    DRingRUS1.Width := 34;
    DRingRUS1.Height := 31;

    DRingLUS1.Left := 38 + 130;
    DRingLUS1.Top := 52 + 163;
    DRingLUS1.Width := 34;
    DRingLUS1.Height := 31;

    DWeaponUS1.Left := 38 + 9;
    DWeaponUS1.Top := 52 + 28;
    DWeaponUS1.Width := 47;
    DWeaponUS1.Height := 87;

    DDressUS1.Left := 38 + 58;
    DDressUS1.Top := 52 + 70;
    DDressUS1.Width := 53;
    DDressUS1.Height := 112;

    DBujukUS1.Left := 42;
    DBujukUS1.Top := 254;
    DBujukUS1.Width := 34;
    DBujukUS1.Height := 31;

    DBeltUS1.Left := 84;
    DBeltUS1.Top := 254;
    DBeltUS1.Width := 34;
    DBeltUS1.Height := 31;

    DBootsUS1.Left := 126;
    DBootsUS1.Top := 254;
    DBootsUS1.Width := 34;
    DBootsUS1.Height := 31;

    DCharmUS1.Left := 168;
    DCharmUS1.Top := 254;
    DCharmUS1.Width := 34;
    DCharmUS1.Height := 31;

    DCloseUS1.SetImgIndex(g_WMainImages, 371);
    DCloseUS1.Left := 8;
    DCloseUS1.Top := 39;

    {-------------------------------------------------------------}

     //背包物品窗口
    d := g_WMain2Images.Images[180];
    if d <> nil then
      DItemBag.SetImgIndex(g_WMain2Images, 180)
    else
      DItemBag.SetImgIndex(g_WMain3Images, 6);

    DItemBag.Left := 0;
    DItemBag.Top := 0;

    DButLevel.SetImgIndex(g_WMain2Images, 183);
    DButLevel.Left := 299;
    DButLevel.Top := 212;

    DItemGrid.Left := 29;
    DItemGrid.Top := 41;
    DItemGrid.Width := 286;
    DItemGrid.Height := 162;

    DHeroItemGrid.Left := 16;
    DHeroItemGrid.Top := 13;
    DHeroItemGrid.Width := 180;
    DHeroItemGrid.Height := 61;

    //开宝箱窗口
    d := g_WMain3Images.Images[510]; //惑怕
    if d <> nil then
    begin
      DOpenArk.SetImgIndex(g_WMain3Images, 510);
      DOpenArk.Left := SCREENWIDTH div 2;
      DOpenArk.Top := SCREENHEIGHT div 2 div 2;
    end;
    DArkClose.SetImgIndex(g_WMain3Images, 233);
    DArkClose.Left := DOpenArk.Width;
    DArkClose.Top := 5;
    DArkOpen.SetImgIndex(g_WMain3Images, 511);
    DArkOpen.Left := 77;
    DArkOpen.Top := 175;
    DArkItem0.SetImgIndex(g_WMain3Images, 514);
    DArkItem0.Left := (0 * 54) + 26;
    DArkItem0.Top := 30;
    DArkItem1.SetImgIndex(g_WMain3Images, 514);
    DArkItem1.Left := (1 * 54) + 26;
    DArkItem1.Top := 30;
    DArkItem2.SetImgIndex(g_WMain3Images, 514);
    DArkItem2.Left := (2 * 54) + 26;
    DArkItem2.Top := 30;
    DArkItem3.SetImgIndex(g_WMain3Images, 514);
    DArkItem3.Left := (2 * 54) + 26;
    DArkItem3.Top := 78;
    DArkItem4.SetImgIndex(g_WMain3Images, 514);
    DArkItem4.Left := (2 * 54) + 26;
    DArkItem4.Top := 126;
    DArkItem5.SetImgIndex(g_WMain3Images, 514);
    DArkItem5.Left := (1 * 54) + 26;
    DArkItem5.Top := 126;
    DArkItem6.SetImgIndex(g_WMain3Images, 514);
    DArkItem6.Left := (0 * 54) + 26;
    DArkItem6.Top := 126;
    DArkItem7.SetImgIndex(g_WMain3Images, 514);
    DArkItem7.Left := (0 * 54) + 26;
    DArkItem7.Top := 78;
    DArkItem8.SetImgIndex(g_WMain3Images, 513);
    DArkItem8.Left := (1 * 54) + 21;
    DArkItem8.Top := 73;

    //dsurface.Draw (SurfaceX(Left)+(ii*54)+26, SurfaceY(Top)+30, d.ClientRect, d, TRUE);
//物品升级
    d := g_WMain3Images.Images[462]; //惑怕
    if d <> nil then
    begin
      DItemLeve.SetImgIndex(g_WMain3Images, 462);
      DItemLeve.Left := SCREENWIDTH div 2;
      DItemLeve.Top := SCREENHEIGHT div 2 div 2;
    end;
    DButItemLeve.SetImgIndex(g_WMain3Images, 463);
    DButItemLeve.Left := 91;
    DButItemLeve.Top := 176;
    DItemLeveClose.SetImgIndex(g_WMain3Images, 233);
    DItemLeveClose.Left := 232;
    DItemLeveClose.Top := 0;
    DButItem1.Left := 102;
    DButItem1.Top := 34;
    DButItem2.Left := 41;
    DButItem2.Top := 111;
    DButItem3.Left := 162;
    DButItem3.Top := 113;
    {dd := g_WMain3Images.Images[513];
    if dd <> nil then begin
     DThroneClose.SetImgIndex (g_WMain3Images, 513);
     DThroneClose.Left := d.Width div 2 - dd.Width div 2;
     DThroneClose.Top := d.Height;
    end;   }

    //DButThroneKey

    {-----------------------------------------------------------}

    //主控面板
{$IF SWH = SWH800}
    d := g_WMain3Images.Images[BOTTOMBOARD800];
{$ELSEIF SWH = SWH1024}
    d := g_WMain3Images.Images[BOTTOMBOARD1024];
{$IFEND}
    if d <> nil then
    begin
      DBottom.Left := 0;
      DBottom.Top := SCREENHEIGHT - d.Height;
      DBottom.Width := d.Width;
      DBottom.Height := d.Height;
    end;

    {-----------------------------------------------------------}

    //功能按钮
    DMyState.SetImgIndex(g_WMainImages, 8);
    DMyState.Left := SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 243))
      {643};
    DMyState.Top := 61;
    DMyBag.SetImgIndex(g_WMainImages, 9);
    DMyBag.Left := SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 282)) {682};
    DMyBag.Top := 41;
    DMyMagic.SetImgIndex(g_WMainImages, 10);
    DMyMagic.Left := SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 322))
      {722};
    DMyMagic.Top := 21;
    DOption.SetImgIndex(g_WMainImages, 11);
    DOption.Left := SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 364)) {764};
    DOption.Top := 11;

    DButSelfShop.SetImgIndex(g_WMain2Images, 154);
    DButSelfShop.Left := 600;
    DButSelfShop.Top := 64;

    {-----------------------------------------------------------}

    //快捷按钮
    DBotMiniMap.SetImgIndex(g_WMainImages, DlgConf.DBotMiniMap.Image {130});
    DBotMiniMap.Left := DlgConf.DBotMiniMap.Left {219};
    DBotMiniMap.Top := DlgConf.DBotMiniMap.Top {104};
    DBotTrade.SetImgIndex(g_WMainImages, DlgConf.DBotTrade.Image {132});
    DBotTrade.Left := DlgConf.DBotTrade.Left {219 + 30}; //560 - 30;
    DBotTrade.Top := DlgConf.DBotTrade.Top {104};
    DBotGuild.SetImgIndex(g_WMainImages, DlgConf.DBotGuild.Image {134});
    DBotGuild.Left := DlgConf.DBotGuild.Left {219 + 30*2};
    DBotGuild.Top := DlgConf.DBotGuild.Top {104};
    DBotGroup.SetImgIndex(g_WMainImages, DlgConf.DBotGroup.Image {128});
    DBotGroup.Left := DlgConf.DBotGroup.Left {219 + 30*3};
    DBotGroup.Top := DlgConf.DBotGroup.Top {104};
    DBotFriend.SetImgIndex(g_WMain3Images, DlgConf.DBotFriend.Image {530});
    DBotFriend.Left := DlgConf.DBotFriend.Left {219 + 30*4};
    DBotFriend.Top := DlgConf.DBotFriend.Top {104};
    DBotChallenge.SetImgIndex(g_WMain3Images, DlgConf.DBotChallenge.Image
      {530});
    DBotChallenge.Left := DlgConf.DBotChallenge.Left {219 + 30*5};
    DBotChallenge.Top := DlgConf.DBotChallenge.Top {104};
    DBotTop.SetImgIndex(g_WMain3Images, DlgConf.DBotTop.Image {530});
    DBotTop.Left := DlgConf.DBotTop.Left {219 + 30*6};
    DBotTop.Top := DlgConf.DBotTop.Top {104};

    DBuHelp.SetImgIndex(g_WMain99Images, DlgConf.DBuHelp.Image);
    DBuHelp.Left := DlgConf.DBuHelp.Left {219 + 30*6};
    DBuHelp.Top := DlgConf.DBuHelp.Top {104};
    DButHorse.SetImgIndex(g_WMain99Images, DlgConf.DButHorse.Image);
    DButHorse.Left := DlgConf.DButHorse.Left {219 + 30*6};
    DButHorse.Top := DlgConf.DButHorse.Top {104};

    DBotPlusAbil.SetImgIndex(g_WMainImages, DlgConf.DBotPlusAbil.Image {140});
    DBotPlusAbil.Left := DlgConf.DBotPlusAbil.Left {219 + 30*7};
    DBotPlusAbil.Top := DlgConf.DBotPlusAbil.Top {104};

    DBotMemo.SetImgIndex(g_WMain3Images, DlgConf.DBotMemo.Image {532});
    DBotMemo.Left := DlgConf.DBotMemo.Left {753};
    DBotMemo.Top := DlgConf.DBotMemo.Top {204};

    DBotExit.SetImgIndex(g_WMainImages, DlgConf.DBotExit.Image {138});
    DBotExit.Left := DlgConf.DBotExit.Left {560};
    DBotExit.Top := DlgConf.DBotExit.Top {104};
    DBotLogout.SetImgIndex(g_WMainImages, DlgConf.DBotLogout.Image {136});
    DBotLogout.Left := DlgConf.DBotLogout.Left {560 - 30};
    DBotLogout.Top := DlgConf.DBotLogout.Top {104};

    DBotCallHero.SetImgIndex(g_WMain3Images, DlgConf.DBotCallHero.Image);
    DBotCallHero.Left := DlgConf.DBotCallHero.Left;
    DBotCallHero.Top := DlgConf.DBotCallHero.Top;
    DBotHeroInfo.SetImgIndex(g_WMain3Images, DlgConf.DBotHeroInfo.Image);
    DBotHeroInfo.Left := DlgConf.DBotHeroInfo.Left;
    DBotHeroInfo.Top := DlgConf.DBotHeroInfo.Top;
    DBotHeroBag.SetImgIndex(g_WMain3Images, DlgConf.DBotHeroBag.Image);
    DBotHeroBag.Left := DlgConf.DBotHeroBag.Left;
    DBotHeroBag.Top := DlgConf.DBotHeroBag.Top;
    DBotSysMsg.SetImgIndex(g_WMain3Images, DlgConf.DBotSysMsg.Image);
    DBotSysMsg.Left := DlgConf.DBotSysMsg.Left;
    DBotSysMsg.Top := DlgConf.DBotSysMsg.Top;
    DBotSysCRY.SetImgIndex(g_WMain3Images, DlgConf.DBotSysCRY.Image);
    DBotSysCRY.Left := DlgConf.DBotSysCRY.Left;
    DBotSysCRY.Top := DlgConf.DBotSysCRY.Top;
    DBotSysHear.SetImgIndex(g_WMain3Images, DlgConf.DBotSysHear.Image);
    DBotSysHear.Left := DlgConf.DBotSysHear.Left;
    DBotSysHear.Top := DlgConf.DBotSysHear.Top;
    DBotSysGuild.SetImgIndex(g_WMain3Images, DlgConf.DBotSysGuild.Image);
    DBotSysGuild.Left := DlgConf.DBotSysGuild.Left;
    DBotSysGuild.Top := DlgConf.DBotSysGuild.Top;
    DBotAutoSys.SetImgIndex(g_WMain3Images, DlgConf.DBotAutoSys.Image);
    DBotAutoSys.Left := DlgConf.DBotAutoSys.Left;
    DBotAutoSys.Top := DlgConf.DBotAutoSys.Top;

    {-----------------------------------------------------------}

    //Belt 快捷栏
    DBelt1.Left := SCREENWIDTH div 2 - 115; //285;
    DBelt1.Width := 32;
    DBelt1.Top := 59;
    DBelt1.Height := 29;

    DBelt2.Left := DBelt1.Left + 43; //328;
    DBelt2.Width := 32;
    DBelt2.Top := 59;
    DBelt2.Height := 29;

    DBelt3.Left := DBelt2.Left + 43; //371;
    DBelt3.Width := 32;
    DBelt3.Top := 59;
    DBelt3.Height := 29;

    DBelt4.Left := DBelt3.Left + 43; //415;
    DBelt4.Width := 32;
    DBelt4.Top := 59;
    DBelt4.Height := 29;

    DBelt5.Left := DBelt4.Left + 43; //459;
    DBelt5.Width := 32;
    DBelt5.Top := 59;
    DBelt5.Height := 29;

    DBelt6.Left := DBelt5.Left + 43; //503;
    DBelt6.Width := 32;
    DBelt6.Top := 59;
    DBelt6.Height := 29;

   DDrunkScale.SetImgIndex(g_WMain2Images,DlgConf.DBrunkScale.Image);
   DDrunkScale.Left:=78;
   DDrunkScale.Top:=91;
   DDrunkScale.Width:=12;
   DDrunkScale.Height:=94;

    {-----------------------------------------------------------}

    //酒捞袍 啊规狼 滚瓢甸
    DGold.SetImgIndex(g_WMainImages, 29); //捣农扁 3俺 鞍澜
    DGold.Left := 17;
    DGold.Top := 218;

    {DRepairItem.SetImgIndex (g_WMainImages, 26);
    DRepairItem.Left := 254;
    DRepairItem.Top := 183;
    DRepairItem.Width := 48;
    DRepairItem.Height := 22; }
    DClosebag.SetImgIndex(g_WMainImages, 371);
    DCloseBag.Left := 336;
    DCloseBag.Top := 59;
    DCloseBag.Width := 14;
    DCloseBag.Height := 20;

    {-----------------------------------------------------------}

    //惑牢 措拳芒
    d := g_WMainImages.Images[384];
    if d <> nil then
    begin
      DMerchantDlg.Left := 0;
      DMerchantDlg.Top := 0;
      DMerchantDlg.SetImgIndex(g_WMainImages, 384);
    end;
    DMerchantDlgClose.Left := 399;
    DMerchantDlgClose.Top := 1;
    DMerchantDlgClose.SetImgIndex(g_WMainImages, 64);
    {-----------------------------------------------------------}
    //配置窗口
    d := g_WMainImages.Images[204];
    if d <> nil then
    begin
      DConfigDlg.SetImgIndex(g_WMainImages, 204);
      DConfigDlg.Left := (SCREENWIDTH - d.Width) div 2;
      DConfigDlg.Top := (SCREENHEIGHT - d.Height) div 2;
    end;
    DConfigDlgOk.SetImgIndex(g_WMainImages, 361);
    DConfigDlgOk.Left := 514;
    DConfigDlgOk.Top := 287;
    DConfigDlgClose.Left := 584;
    DConfigDlgClose.Top := 6;
    DConfigDlgClose.SetImgIndex(g_WMainImages, 64);

    {-----------------------------------------------------------}

    //皋春芒
    d := g_WMainImages.Images[385];
    if d <> nil then
    begin
      DMenuDlg.Left := 138;
      DMenuDlg.Top := 163;
      DMenuDlg.SetImgIndex(g_WMainImages, 385);
    end;
    DMenuPrev.Left := 43;
    DMenuPrev.Top := 175;
    DMenuPrev.SetImgIndex(g_WMainImages, 388);
    DMenuNext.Left := 90;
    DMenuNext.Top := 175;
    DMenuNext.SetImgIndex(g_WMainImages, 387);
    DMenuBuy.Left := 215;
    DMenuBuy.Top := 171;
    DMenuBuy.SetImgIndex(g_WMainImages, 386);
    DMenuClose.Left := 291;
    DMenuClose.Top := 0;
    DMenuClose.SetImgIndex(g_WMainImages, 64);

    {-----------------------------------------------------------}

    //迫扁芒
    d := g_WMainImages.Images[392];
    if d <> nil then
    begin
      DSellDlg.Left := 328;
      DSellDlg.Top := 163;
      DSellDlg.SetImgIndex(g_WMainImages, 392);
    end;
    DSellDlgOk.Left := 85;
    DSellDlgOk.Top := 150;
    DSellDlgOk.SetImgIndex(g_WMainImages, 393);
    DSellDlgClose.Left := 115;
    DSellDlgClose.Top := 0;
    DSellDlgClose.SetImgIndex(g_WMainImages, 64);
    DSellDlgSpot.Left := 27;
    DSellDlgSpot.Top := 67;
    DSellDlgSpot.Width := 61;
    DSellDlgSpot.Height := 52;

    {-----------------------------------------------------------}
    d := g_WMain3Images.Images[126];
    if d <> nil then
    begin
      DKeySelDlg.Left := (SCREENWIDTH - d.Width) div 2;
      DKeySelDlg.Top := (SCREENHEIGHT - d.Height) div 2;
      DKeySelDlg.SetImgIndex(g_WMain3Images, 126);
    end;
    DKsIcon.Left := 51;
    DKsIcon.Top := 31;
    DKsF1.SetImgIndex(g_WMainImages, 232);
    DKsF1.Left := 25;
    DKsF1.Top := 78;
    DKsF2.SetImgIndex(g_WMainImages, 234);
    DKsF2.Left := 57;
    DKsF2.Top := 78;
    DKsF3.SetImgIndex(g_WMainImages, 236);
    DKsF3.Left := 89;
    DKsF3.Top := 78;
    DKsF4.SetImgIndex(g_WMainImages, 238);
    DKsF4.Left := 121;
    DKsF4.Top := 78;
    DKsF5.SetImgIndex(g_WMainImages, 240);
    DKsF5.Left := 160;
    DKsF5.Top := 78;
    DKsF6.SetImgIndex(g_WMainImages, 242);
    DKsF6.Left := 192;
    DKsF6.Top := 78;
    DKsF7.SetImgIndex(g_WMainImages, 244);
    DKsF7.Left := 224;
    DKsF7.Top := 78;
    DKsF8.SetImgIndex(g_WMainImages, 246);
    DKsF8.Left := 256;
    DKsF8.Top := 78;

    DKsConF1.SetImgIndex(g_WMain3Images, 132);
    DKsConF1.Left := 25;
    DKsConF1.Top := 120;
    DKsConF2.SetImgIndex(g_WMain3Images, 134);
    DKsConF2.Left := 57;
    DKsConF2.Top := 120;
    DKsConF3.SetImgIndex(g_WMain3Images, 136);
    DKsConF3.Left := 89;
    DKsConF3.Top := 120;
    DKsConF4.SetImgIndex(g_WMain3Images, 138);
    DKsConF4.Left := 121;
    DKsConF4.Top := 120;
    DKsConF5.SetImgIndex(g_WMain3Images, 140);
    DKsConF5.Left := 160;
    DKsConF5.Top := 120;
    DKsConF6.SetImgIndex(g_WMain3Images, 142);
    DKsConF6.Left := 192;
    DKsConF6.Top := 120;
    DKsConF7.SetImgIndex(g_WMain3Images, 144);
    DKsConF7.Left := 224;
    DKsConF7.Top := 120;
    DKsConF8.SetImgIndex(g_WMain3Images, 146);
    DKsConF8.Left := 256;
    DKsConF8.Top := 120;

    DKsNone.SetImgIndex(g_WMain3Images, 129);
    DKsNone.Left := 296;
    DKsNone.Top := 78;

    DKsOk.SetImgIndex(g_WMain3Images, 127);
    DKsOk.Left := 296;
    DKsOk.Top := 120;
    {-----------------------------------------------------------}
    //弊缝 芒
    d := g_WMainImages.Images[120];
    if d <> nil then
    begin
      DGroupDlg.Left := (SCREENWIDTH - d.Width) div 2;
      DGroupDlg.Top := (SCREENHEIGHT - d.Height) div 2;
      DGroupDlg.SetImgIndex(g_WMainImages, 120);
    end;
    DGrpDlgClose.SetImgIndex(g_WMainImages, 64);
    DGrpDlgClose.Left := 260;
    DGrpDlgClose.Top := 0;
    DGrpAllowGroup.SetImgIndex(g_WMainImages, 122);
    DGrpAllowGroup.Left := 20;
    DGrpAllowGroup.Top := 18;
    DGrpCreate.SetImgIndex(g_WMainImages, 123);
    DGrpCreate.Left := 21 + 1;
    DGrpCreate.Top := 202 + 1;
    DGrpAddMem.SetImgIndex(g_WMainImages, 124);
    DGrpAddMem.Left := 96 + 1;
    DGrpAddMem.Top := 202 + 1;
    DGrpDelMem.SetImgIndex(g_WMainImages, 125);
    DGrpDelMem.Left := 171 + 1;
    DGrpDelMem.Top := 202 + 1;

    {-----------------------------------------------------------}

    d := g_WMainImages.Images[389]; //郴 背券芒
    if d <> nil then
    begin
      DDealDlg.Left := SCREENWIDTH - d.Width;
      DDealDlg.Top := 0;
      DDealDlg.SetImgIndex(g_WMainImages, 389);
    end;
    DDGrid.Left := 21;
    DDGrid.Top := 56;
    DDGrid.Width := 36 * 5;
    DDGrid.Height := 33 * 2;
    DDealOk.SetImgIndex(g_WMainImages, 391);
    DDealOk.Left := 155;
    DDealOk.Top := 193 - 65;
    DDealClose.SetImgIndex(g_WMainImages, 64);
    DDealClose.Left := 220;
    DDealClose.Top := 42;
    DDGold.SetImgIndex(g_WMainImages, 28);
    DDGold.Left := 11;
    DDGold.Top := 202 - 65;

    d := g_WMainImages.Images[390]; //惑措规 背券芒
    if d <> nil then
    begin
      DDealRemoteDlg.Left := DDealDlg.Left - d.Width;
      DDealRemoteDlg.Top := 0;
      DDealRemoteDlg.SetImgIndex(g_WMainImages, 390);
    end;
    DDRGrid.Left := 21;
    DDRGrid.Top := 56;
    DDRGrid.Width := 36 * 5;
    DDRGrid.Height := 33 * 2;
    DDRGold.SetImgIndex(g_WMainImages, 28);
    DDRGold.Left := 11;
    DDRGold.Top := 202 - 65;

    {-----------------------------------------------------------}
    //巩颇芒
    d := g_WMainImages.Images[180];
    if d <> nil then
    begin
      DGuildDlg.Left := 0;
      DGuildDlg.Top := 0;
      DGuildDlg.SetImgIndex(g_WMainImages, 180);
    end;
    DGDClose.Left := 584;
    DGDClose.Top := 6;
    DGDClose.SetImgIndex(g_WMainImages, 64);
    DGDHome.Left := 13;
    DGDHome.Top := 411;
    DGDHome.SetImgIndex(g_WMainImages, 198);
    DGDList.Left := 13;
    DGDList.Top := 429;
    DGDList.SetImgIndex(g_WMainImages, 200);
    DGDChat.Left := 94;
    DGDChat.Top := 429;
    DGDChat.SetImgIndex(g_WMainImages, 190);
    DGDAddMem.Left := 243;
    DGDAddMem.Top := 411;
    DGDAddMem.SetImgIndex(g_WMainImages, 182);
    DGDDelMem.Left := 243;
    DGDDelMem.Top := 429;
    DGDDelMem.SetImgIndex(g_WMainImages, 192);
    DGDEditNotice.Left := 325;
    DGDEditNotice.Top := 411;
    DGDEditNotice.SetImgIndex(g_WMainImages, 196);
    DGDEditGrade.Left := 325;
    DGDEditGrade.Top := 429;
    DGDEditGrade.SetImgIndex(g_WMainImages, 194);
    DGDAlly.Left := 407;
    DGDAlly.Top := 411;
    DGDAlly.SetImgIndex(g_WMainImages, 184);
    DGDBreakAlly.Left := 407;
    DGDBreakAlly.Top := 429;
    DGDBreakAlly.SetImgIndex(g_WMainImages, 186);
    DGDWar.Left := 529;
    DGDWar.Top := 411;
    DGDWar.SetImgIndex(g_WMainImages, 202);
    DGDCancelWar.Left := 529;
    DGDCancelWar.Top := 429;
    DGDCancelWar.SetImgIndex(g_WMainImages, 188);

    DGDUp.Left := 595;
    DGDUp.Top := 239;
    DGDUp.SetImgIndex(g_WMainImages, 373);
    DGDDown.Left := 595;
    DGDDown.Top := 291;
    DGDDown.SetImgIndex(g_WMainImages, 372);

    //巩颇 傍瘤荤亲 俊叼飘
    DGuildEditNotice.SetImgIndex(g_WMainImages, 204);
    DGEOk.SetImgIndex(g_WMainImages, 361);
    DGEOk.Left := 514;
    DGEOk.Top := 287;
    DGEClose.SetImgIndex(g_WMainImages, 64);
    DGEClose.Left := 584;
    DGEClose.Top := 6;

    {-----------------------------------------------------------}
    //瓷仿摹 炼例芒
    DAdjustAbility.SetImgIndex(g_WMainImages, 226);
    DAdjustAbilClose.SetImgIndex(g_WMainImages, 64);
    DAdjustAbilClose.Left := 316;
    DAdjustAbilClose.Top := 1;
    DAdjustAbilOk.SetImgIndex(g_WMainImages, 62);
    DAdjustAbilOk.Left := 220;
    DAdjustAbilOk.Top := 298;

    DPlusDC.SetImgIndex(g_WMainImages, 227);
    DPlusDC.Left := 217;
    DPlusDC.Top := 101;
    DPlusMC.SetImgIndex(g_WMainImages, 227);
    DPlusMC.Left := 217;
    DPlusMC.Top := 121;
    DPlusSC.SetImgIndex(g_WMainImages, 227);
    DPlusSC.Left := 217;
    DPlusSC.Top := 140;
    DPlusAC.SetImgIndex(g_WMainImages, 227);
    DPlusAC.Left := 217;
    DPlusAC.Top := 160;
    DPlusMAC.SetImgIndex(g_WMainImages, 227);
    DPlusMAC.Left := 217;
    DPlusMAC.Top := 181;
    DPlusHP.SetImgIndex(g_WMainImages, 227);
    DPlusHP.Left := 217;
    DPlusHP.Top := 201;
    DPlusMP.SetImgIndex(g_WMainImages, 227);
    DPlusMP.Left := 217;
    DPlusMP.Top := 220;
    DPlusHit.SetImgIndex(g_WMainImages, 227);
    DPlusHit.Left := 217;
    DPlusHit.Top := 240;
    DPlusSpeed.SetImgIndex(g_WMainImages, 227);
    DPlusSpeed.Left := 217;
    DPlusSpeed.Top := 261;

    DMinusDC.SetImgIndex(g_WMainImages, 228);
    DMinusDC.Left := 227;
    DMinusDC.Top := 101;
    DMinusMC.SetImgIndex(g_WMainImages, 228);
    DMinusMC.Left := 227;
    DMinusMC.Top := 121;
    DMinusSC.SetImgIndex(g_WMainImages, 228);
    DMinusSC.Left := 227;
    DMinusSC.Top := 140;
    DMinusAC.SetImgIndex(g_WMainImages, 228);
    DMinusAC.Left := 227;
    DMinusAC.Top := 160;
    DMinusMAC.SetImgIndex(g_WMainImages, 228);
    DMinusMAC.Left := 227;
    DMinusMAC.Top := 181;
    DMinusHP.SetImgIndex(g_WMainImages, 228);
    DMinusHP.Left := 227;
    DMinusHP.Top := 201;
    DMinusMP.SetImgIndex(g_WMainImages, 228);
    DMinusMP.Left := 227;
    DMinusMP.Top := 220;
    DMinusHit.SetImgIndex(g_WMainImages, 228);
    DMinusHit.Left := 227;
    DMinusHit.Top := 240;
    DMinusSpeed.SetImgIndex(g_WMainImages, 228);
    DMinusSpeed.Left := 227;
    DMinusSpeed.Top := 261;

    //排行榜
    d := g_WMain3Images.Images[420];
    if d <> nil then
    begin
      DTaxis.SetImgIndex(g_WMain3Images, 420);
      DTaxis.Left := SCREENWIDTH div 2 - d.Width div 2;
      DTaxis.Top := 0;
    end;
    DTaxisClose.SetImgIndex(g_WMainImages, 64);
    DTaxisClose.Left := 325;
    DTaxisClose.Top := 47;
    DTaxisSelf.SetImgIndex(g_WMain3Images, 443);
    DTaxisSelf.Left := 29;
    DTaxisSelf.Top := 59;
    DTaxisHero.SetImgIndex(g_WMain3Images, 444);
    DTaxisHero.Left := 123;
    DTaxisHero.Top := 59;
    DTaxisMaster.SetImgIndex(g_WMain3Images, 445);
    DTaxisMaster.Left := 220;
    DTaxisMaster.Top := 59;

    DTaxisSelfBt.SetImgIndex(g_WMain3Images, 422);
    DTaxisSelfBt.Left := 25;
    DTaxisSelfBt.Top := 91;

    DTaxisAll.SetImgIndex(g_WMain3Images, 427);
    DTaxisAll.Left := 60;
    DTaxisAll.Top := 20;
    DTaxisWarr.SetImgIndex(g_WMain3Images, 431);
    DTaxisWarr.Left := 60;
    DTaxisWarr.Top := 20 + 1 * 55;
    DTaxisWazird.SetImgIndex(g_WMain3Images, 433);
    DTaxisWazird.Left := 60;
    DTaxisWazird.Top := 20 + 2 * 55;
    DTaxisTaos.SetImgIndex(g_WMain3Images, 435);
    DTaxisTaos.Left := 60;
    DTaxisTaos.Top := 20 + 3 * 55;

    DTaxisShow.SetImgIndex(g_WMain3Images, 423);
    DTaxisShow.Left := 25;
    DTaxisShow.Top := 91;
    DTaxisTop.SetImgIndex(g_WMain3Images, 450);
    DTaxisTop.Left := 0;
    DTaxisTop.Top := 250;
    DTaxisUp.SetImgIndex(g_WMain3Images, 452);
    DTaxisUp.Left := 56;
    DTaxisUp.Top := 250;
    DTaxisDown.SetImgIndex(g_WMain3Images, 454);
    DTaxisDown.Left := 56 + 52;
    DTaxisDown.Top := 250;
    DTaxisBottom.SetImgIndex(g_WMain3Images, 456);
    DTaxisBottom.Left := 56 + 52 * 2;
    DTaxisBottom.Top := 250;
    DTaxisSelfTop.SetImgIndex(g_WMain3Images, 458);
    DTaxisSelfTop.Left := 56 * 2 + 52 * 2 + 5;
    DTaxisSelfTop.Top := 250;

    //好友系统
    d := g_WMain3Images.Images[475];
    if d <> nil then
    begin
      DFriendDlg.SetImgIndex(g_WMain3Images, 475);
      DFriendDlg.Left := (SCREENWIDTH - d.Width) div 2; //SCREENWIDTH div 4;
      DFriendDlg.Top := SCREENHEIGHT div 4; //- 30;
    end;
    DBotMaster.SetImgIndex(g_WMain3Images, 478);
    DBotMaster.Left := 9;
    DBotMaster.Top := 38;
    DFrdClose.SetImgIndex(g_WMainImages, 371);
    DFrdClose.Left := 193;
    DFrdClose.Top := 2;
    DFrdAdd.SetImgIndex(g_WMain3Images, 485);
    DFrdAdd.Left := 31;
    DFrdAdd.Top := 231;
    DFrdDel.SetImgIndex(g_WMain3Images, 484);
    DFrdDel.Left := 97;
    DFrdDel.Top := 231;
    DFrdFriend.SetImgIndex(g_WMain3Images, 481);
    DFrdFriend.Left := 17;
    DFrdFriend.Top := 20;
    DFrdMaster.SetImgIndex(g_WMain3Images, 482);
    DFrdMaster.Left := 63;
    DFrdMaster.Top := 20;
    DFrdBlacklist.SetImgIndex(g_WMain3Images, 483);
    DFrdBlacklist.Left := 109;
    DFrdBlacklist.Top := 20;
    DBotFrdUp.SetImgIndex(g_WMainImages, 398);
    DBotFrdUp.Left := 165;
    DBotFrdUp.Top := 100;
    DBotFrdDown.SetImgIndex(g_WMainImages, 396);
    DBotFrdDown.Left := 165;
    DBotFrdDown.Top := 150;

    d := g_WMainImages.Images[536];
    if d <> nil then
    begin
      DMailListDlg.SetImgIndex(g_WMainImages, 536);
      DMailListDlg.Left := 512;
      DMailListDlg.Top := 0;
    end;
    DMailListClose.SetImgIndex(g_WMainImages, 371);
    DMailListClose.Left := 247;
    DMailListClose.Top := 5;
    DMailListPgUp.SetImgIndex(g_WMainImages, 373);
    DMailListPgUp.Left := 259;
    DMailListPgUp.Top := 102;
    DMailListPgDn.SetImgIndex(g_WMainImages, 372);
    DMailListPgDn.Left := 259;
    DMailListPgDn.Top := 154;
    DMLReply.SetImgIndex(g_WMainImages, 564);
    DMLReply.Left := 90;
    DMLReply.Top := 233;
    DMLRead.SetImgIndex(g_WMainImages, 566);
    DMLRead.Left := 124;
    DMLRead.Top := 233;
    DMLDel.SetImgIndex(g_WMainImages, 556);
    DMLDel.Left := 158;
    DMLDel.Top := 233;
    DMLLock.SetImgIndex(g_WMainImages, 568);
    DMLLock.Left := 192;
    DMLLock.Top := 233;
    DMLBlock.SetImgIndex(g_WMainImages, 570);
    DMLBlock.Left := 226;
    DMLBlock.Top := 233;

    d := g_WMainImages.Images[536];
    if d <> nil then
    begin
      DBlockListDlg.SetImgIndex(g_WMainImages, 536);
      DBlockListDlg.Left := 512;
      DBlockListDlg.Top := 0;
    end;
    DBlockListClose.SetImgIndex(g_WMainImages, 371);
    DBlockListClose.Left := 247;
    DBlockListClose.Top := 5;
    DBLPgUp.SetImgIndex(g_WMainImages, 373);
    DBLPgUp.Left := 259;
    DBLPgUp.Top := 102;
    DBLPgDn.SetImgIndex(g_WMainImages, 372);
    DBLPgDn.Left := 259;
    DBLPgDn.Top := 154;
    DBLAdd.SetImgIndex(g_WMainImages, 554);
    DBLAdd.Left := 192;
    DBLAdd.Top := 233;
    DBLDel.SetImgIndex(g_WMainImages, 556);
    DBLDel.Left := 226;
    DBLDel.Top := 233;

    d := g_WMainImages.Images[537];
    if d <> nil then
    begin
      DMemo.SetImgIndex(g_WMainImages, 537);
      DMemo.Left := 290;
      DMemo.Top := 0;
    end;
    DMemoClose.SetImgIndex(g_WMainImages, 371);
    DMemoClose.Left := 205;
    DMemoClose.Top := 1;
    DMemoB1.SetImgIndex(g_WMainImages, 544);
    DMemoB1.Left := 58;
    DMemoB1.Top := 114;
    DMemoB2.SetImgIndex(g_WMainImages, 538);
    DMemoB2.Left := 126;
    DMemoB2.Top := 114;

 //酿酒台
    d := g_WMain2Images.Images[584];
    if d <> nil then
    begin
      DWMakeWineDesk.SetImgIndex(g_WMain2Images, 584);
      DMWClose.SetImgIndex(g_WMain2Images, 148);
      DStartMakeWine.SetImgIndex(g_WMain2Images,DlgConf.DStartMakeWine.Image {590});
      DMaterialMemo.SetImgIndex(g_WMain2Images, 590);
      DMakeWineHelp.SetImgIndex(g_WMain2Images,590);

    DWMakeWineDesk.Left := SCREENWIDTH - d.Width - 20;
    DWMakeWineDesk.Top := 20;

    DMakeWineHelp.Left:=17;
    DMakeWineHelp.Top:=135;

    DMaterialMemo.Left:=17;
    DMaterialMemo.Top:=166;

    DStartMakeWine.Left:=17;
    DStartMakeWine.Top:=208;

    DMWClose.Left:=361;
    DMWClose.Top:=8;

    DBMateria.Top:=222;
    DBMateria.Left:=112;
    DBMateria.Width:=33;
    DBMateria.Height:=32;

    DBWineSong.Top:=208;
    DBWineSong.Left:=161;
    DBWineSong.Width:=34;
    DBWineSong.Height:=32;

    DBWater.Top:=242;
    DBWater.Left:=161;
    DBWater.Width:=34;
    DBWater.Height:=32;

    DBWineCrock.Top:=222;
    DBWineCrock.Left:=206;
    DBWineCrock.Width:=35;
    DBWineCrock.Height:=33;

    DBassistMaterial1.Top:=222;
    DBassistMaterial1.Left:=257;
    DBassistMaterial1.Width:=33;
    DBassistMaterial1.Height:=32;

    DBassistMaterial2.Top:=222;
    DBassistMaterial2.Left:=292;
    DBassistMaterial2.Width:=33;
    DBassistMaterial2.Height:=32;

    DBassistMaterial3.Top:=222;
    DBassistMaterial3.Left:=328;
    DBassistMaterial3.Width:=33;
    DBassistMaterial3.Height:=32;

    DBDrug.Top:=223;
    DBDrug.Left:=148;
    DBDrug.Width:=33;
    DBDrug.Height:=32;

    DBWine.Top:=223;
    DBWine.Left:=219;
    DBWine.Width:=33;
    DBWine.Height:=32;

    DBWineBottle.Top:=223;
    DBWineBottle.Left:=290;
    DBWineBottle.Width:=33;
    DBWineBottle.Height:=32;
    end;
     //全景地图配置
    {d := g_WMMapImages.Images[0];
    if d <> nil then
    begin
      DMiniMapDlg.Left := 0;
      DMiniMapDlg.Top := 0;
      DMiniMapDlg.Width := 800;
      DMiniMapDlg.Height := 300;
      DMiniMapDlg.SetImgIndex(g_WMMapImages, 0);
    end; }
    //商铺配置
    d := g_WMain3Images.Images[298];
    if d <> nil then
    begin
      DShopWin.Left := 0;
      DShopWin.Top := 0;
      DShopWin.SetImgIndex(g_WMain3Images, 298);
    end;
    DBotShopClose.SetImgIndex(g_WMainImages, 371);
    DBotShopClose.Left := 606;
    DBotShopClose.Top := 5;
    DBotList1.SetImgIndex(g_WMain3Images, 299);
    DBotList1.Left := 177;
    DBotList1.Top := 13;
    DBotList2.SetImgIndex(g_WMain3Images, 300);
    DBotList2.Left := 177 + 58 * 1;
    DBotList2.Top := 13;
    DBotList3.SetImgIndex(g_WMain3Images, 301);
    DBotList3.Left := 177 + 58 * 2;
    DBotList3.Top := 13;
    DBotList4.SetImgIndex(g_WMain3Images, 302);
    DBotList4.Left := 177 + 58 * 3;
    DBotList4.Top := 13;
    DBotList5.SetImgIndex(g_WMain3Images, 303);
    DBotList5.Left := 177 + 58 * 4;
    DBotList5.Top := 13;

    d := g_UIBImages.Images[38];
    if d <> nil then
    begin
      DButtonLingfu.Left := 330;
      DButtonLingfu.Top := 333;
      DButtonLingfu.Width := d.Width;
      DButtonLingfu.Height := d.Height;
      DButtonLingfu.FaceIndex := 38;
    end;

    d := g_UIBImages.Images[36];
    if d <> nil then
    begin
      DButtonPayment.Left := 410;
      DButtonPayment.Top := 333;
      DButtonPayment.Width := d.Width;
      DButtonPayment.Height := d.Height;
      DButtonPayment.FaceIndex := 36;
    end;

    DBotBuy.SetImgIndex(g_WMain3Images, 304);
    DBotBuy.Left := 329;
    DBotBuy.Top := 365;
    DBotSend.SetImgIndex(g_WMain3Images, 305);
    DBotSend.Left := 387;
    DBotSend.Top := 365;
    DBotClose2.SetImgIndex(g_WMain3Images, 306);
    DBotClose2.Left := 445;
    DBotClose2.Top := 365;
    DButFront.SetImgIndex(g_WMainImages, 388);
    DButFront.Left := 197;
    DButFront.Top := 349;
    DButNext.SetImgIndex(g_WMainImages, 387);
    DButNext.Left := 287;
    DButNext.Top := 349;
    DButShopImg.SetImgIndex(g_WEffectImages, 380);
    DButShopImg.Left := 20;
    DButShopImg.Top := 35;

    d := g_WMain3Images.Images[385];
    if d <> nil then
    begin
      DHeroDlg.Left := 0;
      DHeroDlg.Top := 0;
      DHeroDlg.SetImgIndex(g_WMain3Images, 385);
    end;

    //盛大新内挂
  d := g_WMain2Images.Images[607]; //惑怕
  if d <> nil then
  begin
    DNewWg.SetImgIndex(g_WMain2Images, 607);
    DNewWg.Left := SCREENWIDTH div 2 - d.Width div 2;
    DNewWg.Top := SCREENHEIGHT div 2 - d.Height + 70;

  DNewWgBt1.SetImgIndex(g_WMain2Images, 609);
  DNewWgBt1.Left := 10;
  DNewWgBt1.Top := 12;
  DNewWgBt2.SetImgIndex(g_WMain2Images, 609);
  DNewWgBt2.Left := 58;
  DNewWgBt2.Top := 12;
  DNewWgBt3.SetImgIndex(g_WMain2Images, 609);
  DNewWgBt3.Left := 106;
  DNewWgBt3.Top := 12;
  DNewWgBt4.SetImgIndex(g_WMain2Images, 609);
  DNewWgBt4.Left := 154;
  DNewWgBt4.Top := 12;
  DNewWgBt6.SetImgIndex(g_WMain2Images, 609);
  DNewWgBt6.Left := 202;
  DNewWgBt6.Top := 12;
  DNewWgBt5.SetImgIndex(g_WMain2Images, 609);
  DNewWgBt5.Left := 250;
  DNewWgBt5.Top := 12;
  DNewWgClose.SetImgIndex(g_WMain2Images, 279);
  DNewWgClose.Left := 393;
  DNewWgClose.Top := 2;

  DNewWg1.Top := 37;
  DNewWg1.Left := 15;
  DNewWg1.Width := 383;
  DNewWg1.Height := 207;
  DNewWg2.Top := 37;
  DNewWg2.Left := 15;
  DNewWg2.Width := 383;
  DNewWg2.Height := 207;
  DNewWg3.Top := 37;
  DNewWg3.Left := 15;
  DNewWg3.Width := 383;
  DNewWg3.Height := 207;
  DNewWg4.Top := 37;
  DNewWg4.Left := 15;
  DNewWg4.Width := 383;
  DNewWg4.Height := 207;
  DNewWg5.Top := 37;
  DNewWg5.Left := 15;
  DNewWg5.Width := 383;
  DNewWg5.Height := 207;
  DNewWg6.Top := 37;
  DNewWg6.Left := 15;
  DNewWg6.Width := 383;
  DNewWg6.Height := 207;

  DCheckBox1.SetImgIndex(g_WMain2Images, 228);
  DCheckBox1.Top := 32;
  DCheckBox1.Left := 22;
  DCheckBox2.SetImgIndex(g_WMain2Images, 228);
  DCheckBox2.Top := 56;
  DCheckBox2.Left := 22;
  DCheckBox3.SetImgIndex(g_WMain2Images, 228);
  DCheckBox3.Top := 80;
  DCheckBox3.Left := 22;
  DCheckBox4.SetImgIndex(g_WMain2Images, 228);
  DCheckBox4.Top := 104;
  DCheckBox4.Left := 22;
  DCheckBox5.SetImgIndex(g_WMain2Images, 228);
  DCheckBox5.Top := 32;
  DCheckBox5.Left := 147;
  DCheckBox6.SetImgIndex(g_WMain2Images, 228);
  DCheckBox6.Top := 56;
  DCheckBox6.Left := 147;
  DCheckBox7.SetImgIndex(g_WMain2Images, 228);
  DCheckBox7.Top := 80;
  DCheckBox7.Left := 147;
  DCheckBox8.SetImgIndex(g_WMain2Images, 228);
  DCheckBox8.Top := 104;
  DCheckBox8.Left := 147;

  DCheckBox9.SetImgIndex(g_WMain2Images, 228);
  DCheckBox9.Top := 32;
  DCheckBox9.Left := 22;
  DCheckBox10.SetImgIndex(g_WMain2Images, 228);
  DCheckBox10.Top := 56;
  DCheckBox10.Left := 22;
  DCheckBox11.SetImgIndex(g_WMain2Images, 228);
  DCheckBox11.Top := 80;
  DCheckBox11.Left := 22;
  DCheckBox12.SetImgIndex(g_WMain2Images, 228);
  DCheckBox12.Top := 104;
  DCheckBox12.Left := 22;
  DCheckBox13.SetImgIndex(g_WMain2Images, 228);
  DCheckBox13.Top := 152;
  DCheckBox13.Left := 22;
  DCheckBox14.SetImgIndex(g_WMain2Images, 228);
  DCheckBox14.Top := 176;
  DCheckBox14.Left := 22;

  DCheckBox15.SetImgIndex(g_WMain2Images, 228);
  DCheckBox15.Top := 32;
  DCheckBox15.Left := 147;

  DCheckBox16.SetImgIndex(g_WMain2Images, 228);
  DCheckBox16.Top := 32;
  DCheckBox16.Left := 263;
  //DEdit2.SetImgIndex(g_WMain2Images, 752);
  DEdit2.Left := 334;
  DEdit2.Top := 32;
  DEdit2.Width := 28;
  DEdit2.Height := 16;


 { DComboBox1.Item.Add('dsfadfasd');
  DComboBox1.Item.Add('dsfadfasd');
  DComboBox1.Item.Add('dsfadfasd');
  DComboBox1.Item.Add('在人在有为在在');  }

  DCheckBox17.SetImgIndex(g_WMain2Images, 228);
  DCheckBox17.Top := 32;
  DCheckBox17.Left := 22;
  DCheckBox18.SetImgIndex(g_WMain2Images, 228);
  DCheckBox18.Top := 56;
  DCheckBox18.Left := 22;
  DCheckBox19.SetImgIndex(g_WMain2Images, 228);
  DCheckBox19.Top := 104;
  DCheckBox19.Left := 22;
  DCheckBox20.SetImgIndex(g_WMain2Images, 228);
  DCheckBox20.Top := 152;
  DCheckBox20.Left := 22;

  DCheckBox21.SetImgIndex(g_WMain2Images, 228);
  DCheckBox21.Top := 32;
  DCheckBox21.Left := 224;
  DCheckBox22.SetImgIndex(g_WMain2Images, 228);
  DCheckBox22.Top := 80;
  DCheckBox22.Left := 224;
  DCheckBox23.SetImgIndex(g_WMain2Images, 228);
  DCheckBox23.Top := 176;
  DCheckBox23.Left := 224;

  DCheckBox24.SetImgIndex(g_WMain2Images, 228);
  DCheckBox24.Top := 6;
  DCheckBox24.Left := 9;

  DCheckBox25.SetImgIndex(g_WMain2Images, 228);
  DCheckBox25.Top := 56;
  DCheckBox25.Left := 147;

  DCheckBox26.SetImgIndex(g_WMain2Images, 228);
  DCheckBox26.Top := 80;
  DCheckBox26.Left := 147;

  DCheckBox27.SetImgIndex(g_WMain2Images, 228);
  DCheckBox27.Top := 104;
  DCheckBox27.Left := 147;

  DCheckBox28.SetImgIndex(g_WMain2Images, 228);
  DCheckBox28.Top := 152;
  DCheckBox28.Left := 147;

  //DEdit3.SetImgIndex(g_WMain2Images, 752);
  DEdit3.Left := 72;
  DEdit3.Top := 32;
  DEdit3.Width := 43;
  DEdit3.Height := 16;
  //DEdit4.SetImgIndex(g_WMain2Images, 752);
  DEdit4.Left := 123;
  DEdit4.Top := 32;
  DEdit4.Width := 28;
  DEdit4.Height := 16;

  //DEdit5.SetImgIndex(g_WMain2Images, 752);
  DEdit5.Left := 72;
  DEdit5.Top := 56;
  DEdit5.Width := 43;
  DEdit5.Height := 16;
  //DEdit6.SetImgIndex(g_WMain2Images, 752);
  DEdit6.Left := 123;
  DEdit6.Top := 56;
  DEdit6.Width := 28;
  DEdit6.Height := 16;

  //DEdit7.SetImgIndex(g_WMain2Images, 752);
  DEdit7.Left := 72;
  DEdit7.Top := 104;
  DEdit7.Width := 43;
  DEdit7.Height := 16;
  //DEdit8.SetImgIndex(g_WMain2Images, 752);
  DEdit8.Left := 123;
  DEdit8.Top := 104;
  DEdit8.Width := 28;
  DEdit8.Height := 16;

  //DEdit9.SetImgIndex(g_WMain2Images, 752);
  DEdit9.Left := 72;
  DEdit9.Top := 152;
  DEdit9.Width := 43;
  DEdit9.Height := 16;
  //DEdit10.SetImgIndex(g_WMain2Images, 752);
  DEdit10.Left := 123;
  DEdit10.Top := 152;
  DEdit10.Width := 28;
  DEdit10.Height := 16;

  //DEdit11.SetImgIndex(g_WMain2Images, 752);
  DEdit11.Left := 247;
  DEdit11.Top := 32;
  DEdit11.Width := 28;
  DEdit11.Height := 16;

  //DEdit12.SetImgIndex(g_WMain2Images, 752);
  DEdit12.Left := 247;
  DEdit12.Top := 80;
  DEdit12.Width := 28;
  DEdit12.Height := 16;

  //DEdit13.SetImgIndex(g_WMain2Images, 752);
  DEdit13.Left := 281;
  DEdit13.Top := 152;
  DEdit13.Width := 43;
  DEdit13.Height := 16;
  
  DWgUpDown.SetImgIndex(g_WMain2Images, 291);
  DWgUpDown.Top := 1;
  DWgUpDown.Left := 367;
  DWgUpDown.Height := 205;

  DWgBTUp.SetImgIndex(g_WMain2Images, 292);
  DWgBTDown.SetImgIndex(g_WMain2Images, 294);
  DWgBTMove.SetImgIndex(g_WMain2Images, 581);

  DWgUpDown1.SetImgIndex(g_WMain2Images, 291);
  DWgUpDown1.Top := 1;
  DWgUpDown1.Left := 367;
  DWgUpDown1.Height := 205;

  DWgBTUp1.SetImgIndex(g_WMain2Images, 292);
  DWgBTDown1.SetImgIndex(g_WMain2Images, 294);
  DWgBTMove1.SetImgIndex(g_WMain2Images, 581);


  DComboBox2.left := 72;
  DComboBox2.top := 176;
  DComboBox2.Height := 20;
  DComboBox2.width := 80;

  DComboBox3.left := 263;
  DComboBox3.top := 56;
  DComboBox3.Height := 20;
  DComboBox3.width := 112;
  {DUpDown1.SetImgIndex(g_WMain2Images, 291);
  DButton3.SetImgIndex(g_WMain2Images, 292);
  DButton1.SetImgIndex(g_WMain2Images, 294);
  DButton2.SetImgIndex(g_WMain2Images, 581);  }

  {DCheckBox1.SetImgIndex(g_WMain2Images, 228);
  DCheckBox1.Top := 32;
  DCheckBox1.Left := 147;  }

  //新内挂自定义按键
  DHooKKey2.Left := 108;
  DHooKKey2.Top := 44;
  DHooKKey2.Width := 128;
  DHooKKey2.Height := 18;
  DHooKKey3.Left := 244;
  DHooKKey3.Top := 44;
  DHooKKey3.Width := 128;
  DHooKKey3.Height := 18;

  DHooKKey4.Left := 108;
  DHooKKey4.Top := 66;
  DHooKKey4.Width := 128;
  DHooKKey4.Height := 18;
  DHooKKey5.Left := 244;
  DHooKKey5.Top := 66;
  DHooKKey5.Width := 128;
  DHooKKey5.Height := 18;

  DHooKKey6.Left := 108;
  DHooKKey6.Top := 88;
  DHooKKey6.Width := 128;
  DHooKKey6.Height := 18;
  DHooKKey7.Left := 244;
  DHooKKey7.Top := 88;
  DHooKKey7.Width := 128;
  DHooKKey7.Height := 18;

  DHooKKey8.Left := 108;
  DHooKKey8.Top := 110;
  DHooKKey8.Width := 128;
  DHooKKey8.Height := 18;
  DHooKKey9.Left := 244;
  DHooKKey9.Top := 110;
  DHooKKey9.Width := 128;
  DHooKKey9.Height := 18;

  DHooKKey10.Left := 108;
  DHooKKey10.Top := 132;
  DHooKKey10.Width := 128;
  DHooKKey10.Height := 18;
  DHooKKey11.Left := 244;
  DHooKKey11.Top := 132;
  DHooKKey11.Width := 128;
  DHooKKey11.Height := 18;

  DHooKKey12.Left := 108;
  DHooKKey12.Top := 154;
  DHooKKey12.Width := 128;
  DHooKKey12.Height := 18;
  DHooKKey13.Left := 244;
  DHooKKey13.Top := 154;
  DHooKKey13.Width := 128;
  DHooKKey13.Height := 18;

  DHooKKey14.Left := 108;
  DHooKKey14.Top := 176;
  DHooKKey14.Width := 128;
  DHooKKey14.Height := 18;
  DHooKKey15.Left := 244;
  DHooKKey15.Top := 176;
  DHooKKey15.Width := 128;
  DHooKKey15.Height := 18;

//挑战
  d := g_WMain3Images.Images[465]; //惑怕
  if d <> nil then
  begin
    DWChallenge.SetImgIndex(g_WMain3Images, 465);
    DWChallenge.Left := SCREENWIDTH - d.Width - 20;
    DWChallenge.Top := 20;
    DChallengeClose.SetImgIndex(g_WMain3Images,234);
    DChallengeClose.Top:=1;
    DChallengeClose.Left:=239;
    DChallengeOK.SetImgIndex(g_WMain3Images,463);
    DChallengeOK.Top:=231;
    DChallengeOK.Left:=72;
    DChallengeCancel.SetImgIndex(g_WMain3Images,466);
    DChallengeCancel.Top:=231;
    DChallengeCancel.Left:=123;
    DChallengeGrid.Top:=52;
    DChallengeGrid.Left:=24;
    DChallengeGrid.Width:=152;
    DChallengeGrid.Height:=39;
    DChallengeGrid1.Top:=155;
    DChallengeGrid1.Left:=26;
    DChallengeGrid1.Width:=152;
    DChallengeGrid1.Height:=39;
    DChallengeGold.Top:=194;
    DChallengeGold.Left:=26;
    DChallengeGold.Width:=45;
    DChallengeGold.Height:=25;
    DChallengeGameDiamond.Top:=160;
    DChallengeGameDiamond.Left:=175;
    DChallengeGameDiamond.Width:=41;
    DChallengeGameDiamond.Height:=39;
  end;

  end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.Initialize'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------------------}

//惑怕芒 凯扁

procedure TFrmDlg.OpenSoundOption;
begin
  try //程序自动增加
    g_boSound := not g_boSound;
    if g_boSound then
    begin
      DScreen.AddChatBoardString('[音效 开]', clWhite, clBlack);
    end
    else
    begin
      DScreen.AddChatBoardString('[音效 关]', clWhite, clBlack);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.OpenSoundOption'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.OpenMyStatus;
begin
  try //程序自动增加
    DStateWin.Visible := not DStateWin.Visible;
    PageChanged(nil);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.OpenMyStatus'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.OpenUserState(UserState: TUserStateInfo);
begin
  try //程序自动增加
    UserState1 := UserState;
    DUserState1.Visible := TRUE;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.OpenUserState'); //程序自动增加
  end; //程序自动增加
end;

//啊规 凯扁

procedure TFrmDlg.OpenItemBag;
begin
  try //程序自动增加
    DItemBag.Visible := not DItemBag.Visible;
    if DItemBag.Visible then
      ArrangeItemBag;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.OpenItemBag'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.OpenMakeWineDesk;
var
d: TDirectDrawSurface;
begin
 d := g_WMain2Images.Images[584]; //惑怕
 if d <> nil then
 begin
      g_DBMakeWineidx:=0;
      DItemBag.Visible:=True;
      case g_MakeWineidx of
      0:
       begin
        DBMateria.Visible:=True;
        DBWineSong.Visible:=True;
        DBWater.Visible:=True;
        DBWineCrock.Visible:=True;
        DBassistMaterial1.Visible:=True;
        DBassistMaterial2.Visible:=True;
        DBassistMaterial3.Visible:=True;
        DBDrug.Visible:=False;
        DBWine.Visible:=False;
        DBWineBottle.Visible:=False;
       end;
      1:
       begin
        DBMateria.Visible:=False;
        DBWineSong.Visible:=False;
        DBWater.Visible:=False;
        DBWineCrock.Visible:=False;
        DBassistMaterial1.Visible:=False;
        DBassistMaterial2.Visible:=False;
        DBassistMaterial3.Visible:=False;
        DBDrug.Visible:=True;
        DBWine.Visible:=True;
        DBWineBottle.Visible:=True;
       end;
      end;
    DWMakeWineDesk.Visible:=True;
end else
   DMessageDlg('由于你的客户端太旧了不支持酒馆,请更新客户端!',[mbOk]);
end;

//窍窜 惑怕官 焊扁

procedure TFrmDlg.ViewBottomBox(visible: Boolean);
begin
  try //程序自动增加
    DBottom.Visible := visible;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.ViewBottomBox'); //程序自动增加
  end; //程序自动增加
end;

// 酒捞袍 付快胶肺 捞悼吝 秒家

procedure TFrmDlg.CancelItemMoving;
var
  idx, n: integer;
begin
  try //程序自动增加
    if g_boItemMoving then
    begin
      g_boItemMoving := FALSE;
      if g_MovingItem.Hero then
      begin
        idx := g_MovingItem.Index;
        if idx < 0 then
        begin
          if (idx <= -20) and (idx > -30) then
          begin
          end
          else
          begin
            n := -(idx + 1);
            if n in [0..MAXUSEITEMS] then
            begin
              g_HeroUseItems[n] := g_MovingItem.Item;
            end;
          end;
        end
        else if idx in [0..MAXBAGITEM - 1] then
        begin
          if g_HeroItemArr[idx].S.Name = '' then
          begin
            g_HeroItemArr[idx] := g_MovingItem.Item;
          end
          else
          begin
            AddItemHeroBag(g_MovingItem.Item);
          end;
        end;
        g_MovingItem.Item.S.Name := '';
        ArrangeItemHeroBag;
      end
      else
      begin
        idx := g_MovingItem.Index;
        if idx < 0 then
        begin
          if (idx <= -20) and (idx > -30) then
          begin
            AddDealItem(g_MovingItem.Item);
          end
          else
          begin
            n := -(idx + 1);
            if n in [0..MAXUSEITEMS] then
            begin
              g_UseItems[n] := g_MovingItem.Item;
            end;
          end;
        end
        else if idx in [0..MAXBAGITEM - 1] then
        begin
          if g_ItemArr[idx].S.Name = '' then
          begin
            g_ItemArr[idx] := g_MovingItem.Item;
          end
          else
          begin
            AddItemBag(g_MovingItem.Item);
          end;
        end;
        g_MovingItem.Item.S.Name := '';
        ArrangeItemBag;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.CancelItemMoving'); //程序自动增加
  end; //程序自动增加
end;

//捞悼吝牢 酒捞袍阑 官蹿俊 冻绢 哆覆...
//啊规(骇飘)俊辑 滚赴巴父 龋免凳

procedure TFrmDlg.DropMovingItem;
var
  idx: integer;
begin
  try //程序自动增加
    if g_boItemMoving then
    begin
      g_boItemMoving := FALSE;
      if g_MovingItem.Item.S.Name <> '' then
      begin
        if g_MovingItem.Hero then
          FrmMain.SendHeroDropItem(g_MovingItem.Item.S.Name,
            g_MovingItem.Item.MakeIndex)
        else
          FrmMain.SendDropItem(g_MovingItem.Item.S.Name,
            g_MovingItem.Item.MakeIndex);
        AddDropItem(g_MovingItem.Item);
        g_MovingItem.Item.S.Name := '';
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DropMovingItem'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.OpenAdjustAbility;
begin
  try //程序自动增加
    DAdjustAbility.Left := 0;
    DAdjustAbility.Top := 0;
    g_nSaveBonusPoint := g_nBonusPoint;
    FillChar(g_BonusAbilChg, sizeof(TNakedAbility), #0);
    DAdjustAbility.Visible := TRUE;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.OpenAdjustAbility'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBackgroundBackgroundClick(Sender: TObject);
var
  dropgold: integer;
  valstr: string;
begin
  try //程序自动增加
    if g_boItemMoving then
    begin
      DBackground.WantReturn := TRUE;
      if g_MovingItem.Item.S.Name = g_sGoldName {'金币'} then
      begin
        g_boItemMoving := FALSE;
        g_MovingItem.Item.S.Name := '';
        DialogSize := 1;
        DMessageDlg('你想放下多少' + g_sGoldName + '?', [mbOk, mbAbort]);
        GetValidStrVal(DlgEditText, valstr, [' ']);
        dropgold := Str_ToInt(valstr, 0);
        //
        FrmMain.SendDropGold(dropgold);
      end;
      if g_MovingItem.Index >= 0 then
        DropMovingItem;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBackgroundBackgroundClick');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBackgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  try //程序自动增加
    if g_boItemMoving then
    begin
      DBackground.WantReturn := TRUE;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBackgroundMouseDown'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBottomMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  function ExtractUserName(line: string): string;
  var
    uname: string;
  begin
    GetValidStr3(line, line, ['(', '!', '*', '/', ')']);
    GetValidStr3(line, uname, [' ', '=', ':']);
    if uname <> '' then
      if (uname[1] = '/') or (uname[1] = '(') or (uname[1] = ' ') or (uname[1] =
        '[') then
        uname := '';
    Result := uname;
  end;
var
  n: integer;
  str: string;
begin
  try //程序自动增加
    //盲泼芒俊 努腐窍搁, '/'庇加富 老锭 努腐茄 措拳甫 茄荤恩狼 捞抚捞 庇富措惑磊啊 登霸 茄促.
    if (X >= 208) and (X <= 208 + 374) and (Y >= SCREENHEIGHT - 130) and (Y <=
      SCREENHEIGHT - 130 + 12 * 9) then
    begin
      n := DScreen.ChatBoardTop + (Y - (SCREENHEIGHT - 130)) div 12;
      if (n < DScreen.ChatStrs.Count) then
      begin
        if not PlayScene.EdChat.Visible then
        begin
          PlayScene.EdChat.Visible := TRUE;
          PlayScene.EdChat.SetFocus;
        end;
        PlayScene.EdChat.Text := '/' + ExtractUserName(DScreen.ChatStrs[n]) +
          ' ';
        PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
        PlayScene.EdChat.SelLength := 0;
      end
      else
        PlayScene.EdChat.Text := '';
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBottomMouseDown'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------------------}

////皋技瘤 促捞倔肺弊 冠胶

function TFrmDlg.DMessageDlg(msgstr: string; DlgButtons: TMsgDlgButtons):
  TModalResult;
const
  XBase = 324;
var
  I: Integer;
  lx, ly: integer;
  d: TDirectDrawSurface;
  procedure ShowDice();
  var
    I: Integer;
    bo05: Boolean;
  begin
    if m_nDiceCount = 1 then
    begin
      if m_Dice[0].n67C < 20 then
      begin
        if GetTickCount - m_Dice[0].dwPlayTick > 100 then
        begin
          if m_Dice[0].n67C div 5 = 4 then
          begin
            m_Dice[0].nPlayPoint := Random(6) + 1;
          end
          else
          begin
            m_Dice[0].nPlayPoint := m_Dice[0].n67C div 5 + 8;
          end;
          m_Dice[0].dwPlayTick := GetTickCount();
          Inc(m_Dice[0].n67C);
        end;
        exit;
      end; //00491461
      m_Dice[0].nPlayPoint := m_Dice[0].nDicePoint;
      if GetTickCount - m_Dice[0].dwPlayTick > 1500 then
      begin
        DMsgDlg.Visible := False;
      end;
      exit;
    end; //004914AD

    bo05 := True;
    for I := 0 to m_nDiceCount - 1 do
    begin
      if m_Dice[I].n67C < m_Dice[I].n680 then
      begin
        if GetTickCount - m_Dice[I].dwPlayTick > 100 then
        begin
          if m_Dice[I].n67C div 5 = 4 then
          begin
            m_Dice[I].nPlayPoint := Random(6) + 1;
          end
          else
          begin
            m_Dice[I].nPlayPoint := m_Dice[I].n67C div 5 + 8;
          end;
          m_Dice[I].dwPlayTick := GetTickCount();
          Inc(m_Dice[I].n67C);
        end;
        bo05 := False;
      end
      else
      begin //004915E4
        m_Dice[I].nPlayPoint := m_Dice[I].nDicePoint;
        if GetTickCount - m_Dice[I].dwPlayTick < 2000 then
        begin
          bo05 := False;
        end;
      end;
    end; //for
    if bo05 then
    begin
      DMsgDlg.Visible := False;
    end;

  end;
begin
  try //程序自动增加
    if DConfigDlg.Visible then
    begin //打开提示框时关闭选项框
      DOptionClick();
    end;

    lx := XBase;
    ly := 126;
    case DialogSize of
      0: //累篮芭
        begin
          d := g_WMainImages.Images[381];
          if d <> nil then
          begin
            DMsgDlg.SetImgIndex(g_WMainImages, 381);
            DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
            DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
            msglx := 39;
            msgly := 38;
            lx := 90;
            ly := 36;
          end;
        end;
      1: //承绊 奴芭
        begin
          d := g_WMainImages.Images[360];
          if d <> nil then
          begin
            DMsgDlg.SetImgIndex(g_WMainImages, 360);
            DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
            DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
            msglx := 39;
            msgly := 38;
            lx := XBase;
            ly := 126;
          end;
        end;
      2: //辨篮芭
        begin
          d := g_WMainImages.Images[380];
          if d <> nil then
          begin
            DMsgDlg.SetImgIndex(g_WMainImages, 380);
            DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
            DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
            msglx := 23;
            msgly := 20;
            lx := 90;
            ly := 305;
          end;
        end;
    end;
    MsgText := msgstr;
    ViewDlgEdit := FALSE;
    DMsgDlg.Floating := TRUE; //皋技瘤 冠胶啊 栋促丛..
    DMsgDlgOk.Visible := FALSE;
    DMsgDlgYes.Visible := FALSE;
    DMsgDlgCancel.Visible := FALSE;
    DMsgDlgNo.Visible := FALSE;
    DMsgDlg.Left := (SCREENWIDTH - DMsgDlg.Width) div 2;
    DMsgDlg.Top := (SCREENHEIGHT - DMsgDlg.Height) div 2;

    for I := 0 to m_nDiceCount - 1 do
    begin
      m_Dice[I].n67C := 0;
      m_Dice[I].n680 := Random(m_nDiceCount + 2) * 5 + 10;
      m_Dice[I].nPlayPoint := 1;
      m_Dice[I].dwPlayTick := GetTickCount();
    end;

    if mbCancel in DlgButtons then
    begin
      DMsgDlgCancel.Left := lx;
      DMsgDlgCancel.Top := ly;
      DMsgDlgCancel.Visible := TRUE;
      lx := lx - 110;
    end;
    if mbNo in DlgButtons then
    begin
      DMsgDlgNo.Left := lx;
      DMsgDlgNo.Top := ly;
      DMsgDlgNo.Visible := TRUE;
      lx := lx - 110;
    end;
    if mbYes in DlgButtons then
    begin
      DMsgDlgYes.Left := lx;
      DMsgDlgYes.Top := ly;
      DMsgDlgYes.Visible := TRUE;
      lx := lx - 110;
    end;
    if (mbOk in DlgButtons) or (lx = XBase) then
    begin
      DMsgDlgOk.Left := lx;
      DMsgDlgOk.Top := ly;
      DMsgDlgOk.Visible := TRUE;
      lx := lx - 110;
    end;
    HideAllControls;
    DMsgDlg.ShowModal;
    if mbAbort in DlgButtons then
    begin
      ViewDlgEdit := TRUE; //俊靛飘 牧飘费捞 焊咯具 窍绰 版快.
      DMsgDlg.Floating := FALSE;
      with EdDlgEdit do
      begin
        Text := '';
        Width := DMsgDlg.Width - 70;
        Left := (SCREENWIDTH - EdDlgEdit.Width) div 2;
        Top := (SCREENHEIGHT - EdDlgEdit.Height) div 2 - 10;
      end;
    end;
    Result := mrOk;

    while TRUE do
    begin
      if not DMsgDlg.Visible then
        break;
      //FrmMain.DXTimerTimer (self, 0);
      FrmMain.ProcOnIdle;
      Application.ProcessMessages;

      if m_nDiceCount > 0 then
      begin
        m_boPlayDice := True;

        for I := 0 to m_nDiceCount - 1 do
        begin
          m_Dice[I].nX := ((DMsgDlg.Width div 2 + 6) - ((m_nDiceCount * 32 +
            m_nDiceCount) div 2)) + (I * 32 + I);
          m_Dice[I].nY := DMsgDlg.Height div 2 - 14;
        end;

        ShowDice();

      end;

      if Application.Terminated then
        exit;
    end;

    EdDlgEdit.Visible := FALSE;
    RestoreHideControls;
    DlgEditText := EdDlgEdit.Text;
    if PlayScene.EdChat.Visible then
      PlayScene.EdChat.SetFocus;
    ViewDlgEdit := FALSE;
    Result := DMsgDlg.DialogResult;
    DialogSize := 1; //扁夯惑怕
    m_nDiceCount := 0;
    m_boPlayDice := False;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMessageDlg'); //程序自动增加
  end; //程序自动增加
end;

function TFrmDlg.DPicDlg(msgstr: string): Boolean;
begin
  try //程序自动增加
    Result := False;
    DlgPic := 0;
    DlgBut := False;

    EdPicEdit.Visible := True;
    EdPicEdit.Left := DPicPut.Left + 91;
    EdPicEdit.Top := DPicPut.Top + 41;
    EdPicEdit.Width := 90;
    DPicPut.ShowModal;
    while TRUE do
    begin
      if not DPicPut.Visible then
        break;
      //FrmMain.DXTimerTimer (self, 0);
      FrmMain.ProcOnIdle;
      Application.ProcessMessages;

      if Application.Terminated then
        exit;
    end;
    EdPicEdit.Visible := False;
    DlgPic := Str_ToInt(EdPicEdit.Text, 0);
    Result := DlgBut;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DPicDlg'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMsgDlgOkClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if Sender = DMsgDlgOk then
      DMsgDlg.DialogResult := mrOk;
    if Sender = DMsgDlgYes then
      DMsgDlg.DialogResult := mrYes;
    if Sender = DMsgDlgCancel then
      DMsgDlg.DialogResult := mrCancel;
    if Sender = DMsgDlgNo then
      DMsgDlg.DialogResult := mrNo;
    DMsgDlg.Visible := FALSE;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMsgDlgOkClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMsgDlgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  try //程序自动增加
    if Key = 13 then
    begin
      if DMsgDlgOk.Visible and not (DMsgDlgYes.Visible or DMsgDlgCancel.Visible
        or DMsgDlgNo.Visible) then
      begin
        DMsgDlg.DialogResult := mrOk;
        DMsgDlg.Visible := FALSE;
      end;
      if DMsgDlgYes.Visible and not (DMsgDlgOk.Visible or DMsgDlgCancel.Visible
        or DMsgDlgNo.Visible) then
      begin
        DMsgDlg.DialogResult := mrYes;
        DMsgDlg.Visible := FALSE;
      end;
    end;
    if Key = 27 then
    begin
      if DMsgDlgCancel.Visible then
      begin
        DMsgDlg.DialogResult := mrCancel;
        DMsgDlg.Visible := FALSE;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMsgDlgKeyDown'); //程序自动增加
  end; //程序自动增加
end;
{
procedure TFrmDlg.DMsgDlgOkDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  tGame:pGameInfo;
  tServer:pServerInfo;
  tStr:String;
begin
Try //程序自动增加
   with Sender as TDButton do begin
      if not Downed then
         d := WLib.Images[FaceIndex]
      else d := WLib.Images[FaceIndex+1];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      tGame:=GameList.Items[SelServerIndex];
      if (Name = 'DSServer1') and (tGame.ServerList.Count > 0) then begin
         tServer:=tGame.ServerList[0];
         tStr:=tServer.CaptionName;
      end;
      if (Name = 'DSServer2') and (tGame.ServerList.Count > 1) then begin
         tServer:=tGame.ServerList[1];
         tStr:=tServer.CaptionName;
      end;
      if (Name = 'DSServer3') and (tGame.ServerList.Count > 2) then begin
         tServer:=tGame.ServerList[2];
         tStr:=tServer.CaptionName;
      end;
      if (Name = 'DSServer4') and (tGame.ServerList.Count > 3) then begin
         tServer:=tGame.ServerList[3];
         tStr:=tServer.CaptionName;
      end;
      if (Name = 'DSServer5') and (tGame.ServerList.Count > 4) then begin
         tServer:=tGame.ServerList[4];
         tStr:=tServer.CaptionName;
      end;
      if (Name = 'DSServer6') and (tGame.ServerList.Count > 5) then begin
         tServer:=tGame.ServerList[5];
         tStr:=tServer.CaptionName;
      end;
          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Size :=12;
          BoldTextOut (dsurface, SurfaceX(Left + (d.Width - dsurface.Canvas.TextWidth(tStr)) div 2), SurfaceY(Top + (d.Height -dsurface.Canvas.TextHeight(tStr)) div 2), clYellow, clBlack, tStr);
          dsurface.Canvas.Font.Size :=9;
//          dsurface.Canvas.Font:=oFont;
          dsurface.Canvas.Release;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TFrmDlg.DMsgDlgOkDirectPaint'); //程序自动增加
End; //程序自动增加
end;
}

procedure TFrmDlg.DMsgDlgOkDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  tStr: string;
  Color: TColor;
  nStatus: Integer;
begin
  try //程序自动增加
    try
      nStatus := -1;
      with Sender as TDButton do
      begin
        if not Downed then
          d := WLib.Images[FaceIndex]
        else
          d := WLib.Images[FaceIndex + 1];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

        if (Name = 'DSServer1') and (g_ServerList.Count >= 1) then
        begin
          tStr := g_ServerList.Strings[0];
          nStatus := Integer(g_ServerList.Objects[0]);
        end;
        if (Name = 'DSServer2') and (g_ServerList.Count >= 2) then
        begin
          tStr := g_ServerList.Strings[1];
          nStatus := Integer(g_ServerList.Objects[1]);
        end;
        if (Name = 'DSServer3') and (g_ServerList.Count >= 3) then
        begin
          tStr := g_ServerList.Strings[2];
          nStatus := Integer(g_ServerList.Objects[2]);
        end;
        if (Name = 'DSServer4') and (g_ServerList.Count >= 4) then
        begin
          tStr := g_ServerList.Strings[3];
          nStatus := Integer(g_ServerList.Objects[3]);
        end;
        if (Name = 'DSServer5') and (g_ServerList.Count >= 5) then
        begin
          tStr := g_ServerList.Strings[4];
          nStatus := Integer(g_ServerList.Objects[4]);
        end;
        if (Name = 'DSServer6') and (g_ServerList.Count >= 6) then
        begin
          tStr := g_ServerList.Strings[5];
          nStatus := Integer(g_ServerList.Objects[5]);
        end;
        Color := GetRGB(255) {clYellow};
        {case nStatus of    //
          0: begin
            tStr:=tStr + '(维护)';
            Color:=clDkGray;
          end;
          1: begin
            tStr:=tStr + '(空闲)';
            Color:=clLime;
          end;
          2: begin
            tStr:=tStr + '(良好)';
            Color:=clGreen;
          end;
          3: begin
            tStr:=tStr + '(繁忙)';
            Color:=clMaroon;
          end;
          4: begin
            tStr:=tStr + '(满员)';
            Color:=clRed;
          end;
        end;}
        SetBkMode(dsurface.Canvas.Handle, TRANSPARENT);
        dsurface.Canvas.Font.Size := 11;
        dsurface.Canvas.Font.Style := [fsBold];
        if TDButton(Sender).Downed then
        begin
          BoldTextOut(dsurface, SurfaceX(Left + (d.Width -
            dsurface.Canvas.TextWidth(tStr)) div 2) + 2, SurfaceY(Top + (d.Height
            - dsurface.Canvas.TextHeight(tStr)) div 2) + 2, Color {clYellow},
            clBlack, tStr);
        end
        else
        begin
          BoldTextOut(dsurface, SurfaceX(Left + (d.Width -
            dsurface.Canvas.TextWidth(tStr)) div 2), SurfaceY(Top + (d.Height -
            dsurface.Canvas.TextHeight(tStr)) div 2), Color {clYellow}, clBlack,
            tStr);
        end;
        dsurface.Canvas.Font.Style := [];
        dsurface.Canvas.Font.Size := 9;
        dsurface.Canvas.Release;
      end;
    except
      on e: Exception do
      begin
        ShowMessage(E.Message);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMsgDlgOkDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMWCloseClick(Sender: TObject; X, Y: Integer);
var
i:Integer;
begin
case g_MakeWineidx of
0:
begin
    for I := Low(g_WineItem) to High(g_WineItem) do
      if g_WineItem[i].S.Name <> '' then
        AddItemBag(g_WineItem[i]);
    ArrangeItemBag;
    FillChar(g_WineItem, Sizeof(TClientItem) * 7, #0);
end;
1:
begin
    for I := Low(g_WineItem1) to High(g_WineItem1) do
      if g_WineItem1[i].S.Name <> '' then
        AddItemBag(g_WineItem1[i]);
    ArrangeItemBag;
    FillChar(g_WineItem1, Sizeof(TClientItem) * 3, #0);
end;
end;
DWMakeWineDesk.Visible:=False;
DItemBag.Visible:=False;
g_DBMakeWineidx:=0;//酿酒台按键号

end;

procedure TFrmDlg.DMWCloseDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  dd: TDirectDrawSurface;
  d:TDButton;
  begin
    if Sender is TDButton then
    begin
      d := TDButton(Sender);
      if not d.Downed then
      begin
        dd := d.WLib.Images[d.FaceIndex];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
      end
      else
      begin
        dd := d.WLib.Images[d.FaceIndex + 1];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
      end;
    end;
end;

procedure TFrmDlg.DMsgDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  I: Integer;
  d: TDirectDrawSurface;
  ly: integer;
  str, data: string;
  nX, nY: Integer;
begin
  try //程序自动增加
    with Sender as TDWindow do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      if m_boPlayDice then
      begin
        for I := 0 to m_nDiceCount - 1 do
        begin
          d := FrmMain.GetWBagItemImg(m_Dice[I].nPlayPoint + 376 - 1, nX, nY);
          if d <> nil then
          begin
            dsurface.Draw(SurfaceX(Left) + m_Dice[I].nX + nX - 14, SurfaceY(Top)
              + m_Dice[I].nY + nY + 38, d.ClientRect, d, TRUE);
          end;
        end;
      end;

      SetBkMode(dsurface.Canvas.Handle, TRANSPARENT);
      ly := msgly;
      str := MsgText;
      while TRUE do
      begin
        if str = '' then
          break;
        str := GetValidStr3(str, data, ['\']);
        if data <> '' then
          BoldTextOut(dsurface, SurfaceX(Left + msglx), SurfaceY(Top + ly),
            clWhite, clBlack, data);
        ly := ly + 14;
      end;
      dsurface.Canvas.Release;
    end;
    if ViewDlgEdit then
    begin
      if not EdDlgEdit.Visible then
      begin
        EdDlgEdit.Visible := TRUE;
        EdDlgEdit.SetFocus;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMsgDlgDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------------------}

//肺弊牢 芒

procedure TFrmDlg.DLoginNewDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    with Sender as TDButton do
    begin
      if TDButton(Sender).Downed then
      begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DLoginNewDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DLoginNewClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
 //   DMessageDlg('[提示信息]: 请先关闭游戏，使用登录器注册帐号。', [mbOk]);
    LoginScene.NewClick;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DLoginNewClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DLoginOkClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    LoginScene.OkClick;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DLoginOkClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DLoginCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    FrmMain.Close;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DLoginCloseClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DLiquorProgressDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  rc:TRect;
begin
try
with DLiquorProgress do
 begin
if g_MySelf <> nil then
begin
  d := g_WMain2Images.Images[575];
  if d <> nil then
    dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d,True);
  d := g_WMain2Images.Images[576];
  if d <> nil then
  begin
    rc := d.ClientRect;
    rc.Right := Round((rc.Right-rc.Left) / 100 * g_MySelf.m_bLiquorProgress);
    dsurface.Draw(SurfaceX(Left), SurfaceY(Top), rc, d, True);
  end;
end;
 end;
except

end;
end;

procedure TFrmDlg.DLiquorProgressMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
try
 if g_MySelf<>nil then
 begin
    with DLiquorProgress do
      DScreen.ShowHint(SurfaceX(Left), SurfaceY(Top+Height+20),
       '酒量提升进度'+IntToStr(g_MySelf.m_bLiquorProgress)+'%', clWhite,True);
 end;
except

end;
end;

procedure TFrmDlg.DLoginChgPwClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
   // DMessageDlg('[提示信息]: 请先关闭游戏，使用登录器修改密码。', [mbOk]);
    LoginScene.ChgPwClick;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DLoginChgPwClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DLoginOkSound(Sender: TObject;
  Clicksound: TClickSound);
begin
  try //程序自动增加
    case Clicksound of
      csNorm: PlaySound(s_norm_button_click);
      csStone: PlaySound(s_rock_button_click);
      csGlass: PlaySound(s_glass_button_click);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DLoginOkSound'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------------------}
//辑滚 急琶 芒
{
procedure TFrmDlg.ShowSelectServerDlg;
var
  tGame:pGameInfo;
  tServer:pServerInfo;
begin
Try //程序自动增加
  tGame:=GameList.Items[SelServerIndex];
   case tGame.ServerList.Count of
     1:begin
         DSServer1.Visible:=True;
         DSServer1.Top:=204;
         DSServer2.Visible:=False;
         DSServer3.Visible:=False;
         DSServer4.Visible:=False;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
       end;
     2:begin
         DSServer1.Visible:=True;
         DSServer1.Top:=200;
         DSServer2.Visible:=True;
         DSServer2.Top:=250;
         DSServer3.Visible:=False;
         DSServer4.Visible:=False;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
       end;
     3:begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=False;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
       end;
     4:begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=True;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
       end;
     5:begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=True;
         DSServer5.Visible:=True;
         DSServer6.Visible:=False;
       end;
     6:begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=True;
         DSServer5.Visible:=True;
         DSServer6.Visible:=True;
       end;
   end;
   DSelServerDlg.Visible := TRUE;
Except //程序自动增加
  DebugOutStr('[Exception] TFrmDlg.ShowSelectServerDlg'); //程序自动增加
End; //程序自动增加
end;
}

procedure TFrmDlg.ShowSelectServerDlg;
begin
  try //程序自动增加
    case g_ServerList.Count of
      1:
        begin
          DSServer1.Visible := True;
          DSServer1.Top := 204;
          DSServer2.Visible := False;
          DSServer3.Visible := False;
          DSServer4.Visible := False;
          DSServer5.Visible := False;
          DSServer6.Visible := False;
        end;
      2:
        begin
          DSServer1.Visible := True;
          DSServer1.Top := 190;
          DSServer2.Visible := True;
          DSServer2.Top := 235;
          DSServer3.Visible := False;
          DSServer4.Visible := False;
          DSServer5.Visible := False;
          DSServer6.Visible := False;
        end;
      3:
        begin
          DSServer1.Visible := True;
          DSServer2.Visible := True;
          DSServer3.Visible := True;
          DSServer4.Visible := False;
          DSServer5.Visible := False;
          DSServer6.Visible := False;
        end;
      4:
        begin
          DSServer1.Visible := True;
          DSServer2.Visible := True;
          DSServer3.Visible := True;
          DSServer4.Visible := True;
          DSServer5.Visible := False;
          DSServer6.Visible := False;
        end;
      5:
        begin
          DSServer1.Visible := True;
          DSServer2.Visible := True;
          DSServer3.Visible := True;
          DSServer4.Visible := True;
          DSServer5.Visible := True;
          DSServer6.Visible := False;
        end;
      6:
        begin
          DSServer1.Visible := True;
          DSServer2.Visible := True;
          DSServer3.Visible := True;
          DSServer4.Visible := True;
          DSServer5.Visible := True;
          DSServer6.Visible := True;
        end;
    else
      begin
        DSServer1.Visible := True;
        DSServer2.Visible := True;
        DSServer3.Visible := True;
        DSServer4.Visible := True;
        DSServer5.Visible := True;
        DSServer6.Visible := True;
      end;
    end;
    DSelServerDlg.Visible := TRUE;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.ShowSelectServerDlg'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DSelServerDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加

  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DSelServerDlgDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;
{
procedure TFrmDlg.DSServer1Click(Sender: TObject; X, Y: Integer);
var
  svname: string;
  tGame:pGameInfo;
  tServer:pServerInfo;
begin
Try //程序自动增加
   svname := '';
   tGame:=GameList.Items[SelServerIndex];
   if Sender = DSServer1 then begin
     tServer:=tGame.ServerList.Items[0];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if Sender = DSServer2 then begin //辑滚 4锅..
     tServer:=tGame.ServerList.Items[1];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if Sender = DSServer3 then begin //辑滚 1锅..
     tServer:=tGame.ServerList.Items[2];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if Sender = DSServer4 then begin //辑滚 2锅..
     tServer:=tGame.ServerList.Items[3];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if Sender = DSServer5 then begin //辑滚 3锅..
     tServer:=tGame.ServerList.Items[4];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if Sender = DSServer6 then begin //辑滚 4锅..
     tServer:=tGame.ServerList.Items[5];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if svname <> '' then begin
      if BO_FOR_TEST then begin
         svname := '泅公辑滚';
         ServerMiniName := '泅公';
      end;
      FrmMain.SendSelectServer (svname);
      DSelServerDlg.Visible := FALSE;
      ServerName := svname;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TFrmDlg.DSServer1Click'); //程序自动增加
End; //程序自动增加
end;
}

procedure TFrmDlg.DSServer1Click(Sender: TObject; X, Y: Integer);
var
  svname: string;
begin
  try //程序自动增加
    svname := '';
    if Sender = DSServer1 then
    begin
      svname := g_ServerList.Strings[0];
      g_sServerMiniName := svname;
    end;
    if Sender = DSServer2 then
    begin //辑滚 4锅..
      svname := g_ServerList.Strings[1];
      g_sServerMiniName := svname;
    end;
    if Sender = DSServer3 then
    begin //辑滚 1锅..
      svname := g_ServerList.Strings[2];
      g_sServerMiniName := svname;
    end;
    if Sender = DSServer4 then
    begin //辑滚 2锅..
      svname := g_ServerList.Strings[3];
      g_sServerMiniName := svname;
    end;
    if Sender = DSServer5 then
    begin //辑滚 3锅..
      svname := g_ServerList.Strings[4];
      g_sServerMiniName := svname;
    end;
    if Sender = DSServer6 then
    begin //辑滚 4锅..
      svname := g_ServerList.Strings[5];
      g_sServerMiniName := svname;
    end;
    if svname <> '' then
    begin
      if BO_FOR_TEST then
      begin
        svname := '晋升网络';
        g_sServerMiniName := '晋升网络';
      end;
      FrmMain.SendSelectServer(svname);
      DSelServerDlg.Visible := FALSE;
      g_sServerName := svname;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DSServer1Click'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DEngServer1Click(Sender: TObject; X, Y: Integer);
var
  svname: string;
begin
  try //程序自动增加
    svname := 'DragonServer';
    g_sServerMiniName := svname;

    if svname <> '' then
    begin
      FrmMain.SendSelectServer(svname);
      DSelServerDlg.Visible := FALSE;
      g_sServerName := svname;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DEngServer1Click'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DSSrvCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DSelServerDlg.Visible := FALSE;
    FrmMain.Close;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DSSrvCloseClick'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------------------}
//货 拌沥 父甸扁 芒

procedure TFrmDlg.DNewAccountOkClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    LoginScene.NewAccountOk;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DNewAccountOkClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DNewWg1DirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
var
  d : TDWindow;
  I : Integer;
  nTop : Integer;
begin
  d := TDWindow(Sender);
  with dsurface.Canvas do begin
    SetBkMode(Handle, TRANSPARENT);
    if d = DNewWg1 then begin
      Font.Style := Canvas.Font.Style + [fsBold];
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 13, d.SurfaceY(d.Top) + 13,clSilver,clBlack,'基本功能设置');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 138, d.SurfaceY(d.Top) + 13,clSilver,clBlack,'物品设置');
      Font.Style := Canvas.Font.Style - [fsBold];
    end else
    if d = DNewWg2 then begin
      Font.Style := Canvas.Font.Style + [fsBold];
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 13, d.SurfaceY(d.Top) + 13,clSilver,clBlack,'普通药品');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 13, d.SurfaceY(d.Top) + 82,clSilver,clBlack,'特殊药品');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 13, d.SurfaceY(d.Top) + 130,clSilver,clBlack,'随机保护');

      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 215, d.SurfaceY(d.Top) + 13,clSilver,clBlack,'自动饮酒');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 215, d.SurfaceY(d.Top) + 58,clSilver,clBlack,'自动饮酒(英雄)');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 215, d.SurfaceY(d.Top) + 130,clSilver,clBlack,'英雄保护设置');
      Font.Style := Canvas.Font.Style - [fsBold];
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 224, d.SurfaceY(d.Top) + 154,clSilver,clBlack,'躲避血量：       HP');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 22, d.SurfaceY(d.Top) + 178,clSilver,clBlack,'卷轴类型');
    end else
    if d = DNewWg3 then begin
      Font.Style := Canvas.Font.Style + [fsBold];
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 13, d.SurfaceY(d.Top) + 13,clSilver,clBlack,'战士技能');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 138, d.SurfaceY(d.Top) + 13,clSilver,clBlack,'道士技能');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 253, d.SurfaceY(d.Top) + 13,clSilver,clBlack,'自动练功');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 13, d.SurfaceY(d.Top) + 130,clSilver,clBlack,'法师技能');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 138, d.SurfaceY(d.Top) + 130,clSilver,clBlack,'通用技能');
      Font.Style := Canvas.Font.Style - [fsBold];
    end else
    if d = DNewWg4 then begin
      Font.Style := Canvas.Font.Style + [fsBold];
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 12, d.SurfaceY(d.Top) + 26,clSilver,clBlack,'功能描述');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 138, d.SurfaceY(d.Top) + 26,clSilver,clBlack,'默认快捷键');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 270, d.SurfaceY(d.Top) + 26,clSilver,clBlack,'自定义快捷键');
      //BoldTextOut(dsurface,d.SurfaceX(d.Left) + 13, d.SurfaceY(d.Top) + 130,clSilver,clBlack,'法师技能');
      Font.Style := Canvas.Font.Style - [fsBold];
      dsurface.Canvas.Pen.Color := clSilver;
      MoveTo(d.SurfaceX(d.Left) + 12,d.SurfaceY(d.Top) + 40);
      LineTo(d.SurfaceX(d.Left) + 372,d.SurfaceY(d.Top) + 40);
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 12, d.SurfaceY(d.Top) + 48,clSilver,clBlack,'召唤英雄');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 12, d.SurfaceY(d.Top) + 70,clSilver,clBlack,'英雄攻击目标');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 12, d.SurfaceY(d.Top) + 92,clSilver,clBlack,'使用合击技');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 12, d.SurfaceY(d.Top) + 114,clSilver,clBlack,'切换英雄状态');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 12, d.SurfaceY(d.Top) + 136,clSilver,clBlack,'英雄守护');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 12, d.SurfaceY(d.Top) + 158,clSilver,clBlack,'切换攻击模式');
      BoldTextOut(dsurface,d.SurfaceX(d.Left) + 12, d.SurfaceY(d.Top) + 180,clSilver,clBlack,'切换小地图');
    end else
    if d = DNewWg5 then begin
      if g_WgHintList.Count > DWgUpDown.Position then begin
        nTop := 9;
        for I := DWgUpDown.Position to _MIN(g_WgHintList.Count - 1,DWgUpDown.Position + 12) do begin
          if (g_WgHintList[i] <> '') and (g_WgHintList[i][1] = ' ') then
            BoldTextOut(dsurface,d.SurfaceX(d.Left) + 7, d.SurfaceY(d.Top) + nTop,clSilver,clBlack,g_WgHintList[i])
          else
            BoldTextOut(dsurface,d.SurfaceX(d.Left) + 7, d.SurfaceY(d.Top) + nTop,clWhite,clBlack,g_WgHintList[i]);
          Inc(nTop,15);
        end;
      end;
    end else
    if d = DNewWg6 then begin

    end;
  Release;
  end;
end;

procedure TFrmDlg.DNewWg1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
DScreen.ClearHint;
end;

procedure TFrmDlg.DNewWgBt1Click(Sender: TObject; X, Y: Integer);
begin
  m_NewWgIdx := TDButton(Sender).Tag;
  case m_newwgidx of
  0:begin
    DNewWg2.Visible := False;
    DNewWg3.Visible := False;
    DNewWg4.Visible := False;
    DNewWg5.Visible := False;
    DNewWg1.Visible := True;
    DNewWg6.Visible := False;
  end;
  1:begin
    DNewWg2.Visible := True;
    DNewWg3.Visible := False;
    DNewWg4.Visible := False;
    DNewWg5.Visible := False;
    DNewWg1.Visible := False;
    DNewWg6.Visible := False;
  end;
  2:begin
    DNewWg2.Visible := False;
    DNewWg3.Visible := True;
    DNewWg4.Visible := False;
    DNewWg5.Visible := False;
    DNewWg1.Visible := False;
    DNewWg6.Visible := False;
  end;
  3:begin
    DNewWg2.Visible := False;
    DNewWg3.Visible := False;
    DNewWg4.Visible := True;
    DNewWg5.Visible := False;
    DNewWg1.Visible := False;
    DNewWg6.Visible := False;
  end;
  4:begin
    DNewWg2.Visible := False;
    DNewWg3.Visible := False;
    DNewWg4.Visible := False;
    DNewWg5.Visible := False;
    DNewWg1.Visible := False;
    DWgUpDown1.Position := 0;
    DWgUpDown1.MaxPosition := g_WgHintList.Count - 1 - 12;
    DNewWg6.Visible := True;
  end;
  5:begin
    DWgUpDown.Position := 0;
    DWgUpDown.MaxPosition := g_WgHintList.Count - 1 - 12;
    DNewWg2.Visible := False;
    DNewWg3.Visible := False;
    DNewWg4.Visible := False;
    DNewWg5.Visible := True;
    DNewWg1.Visible := False;
    DNewWg6.Visible := False;
  end;
end;
end;

procedure TFrmDlg.DNewWgBt1DirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
const
  Hints : array[0..5] of string = ('基本','保护','技能','按键','便签','帮助');
var
  d: TDButton;
  dd: TDirectDrawSurface;
begin
  if Sender is TDButton then
  begin
    d := TDButton(Sender);
    if d.Tag = m_newwgidx then
    begin
      dd := d.WLib.Images[d.FaceIndex];
      if dd <> nil then
        dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
          dd, TRUE);
    end
    else
    begin
      dd := d.WLib.Images[d.FaceIndex - 1];
      if dd <> nil then
        dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top) + 2, dd.ClientRect,
          dd, TRUE);
    end;

    if dd <> nil then
    begin
      with dsurface.Canvas do
      begin
        SetBkMode(dsurface.Canvas.Handle, TRANSPARENT);
        if d.Tag = m_newwgidx then
          BoldTextOut(dsurface,
            d.SurfaceX(d.Left) + dd.Width div 2 - dsurface.Canvas.TextWidth(Hints[d.Tag]) div 2,
            d.SurfaceY(d.Top) + dd.Height div 2 - dsurface.Canvas.TextHeight(Hints[d.Tag]) div 2 , clwhite, clBlack,
            Hints[d.Tag])
        else
          BoldTextOut(dsurface,
          d.SurfaceX(d.Left) + dd.Width div 2 - dsurface.Canvas.TextWidth(Hints[d.Tag]) div 2,
          d.SurfaceY(d.Top) + 6, clwhite, clBlack,
          Hints[d.Tag]);
        dsurface.Canvas.Release;
      end;
    end;
  end;
end;

procedure TFrmDlg.DNewWgCloseClick(Sender: TObject; X, Y: Integer);
begin
DNewWg.Visible := False;
end;

procedure TFrmDlg.DNewAccountCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    LoginScene.NewAccountClose;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DNewAccountCloseClick');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DNewAccountDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  i: integer;
begin
  try //程序自动增加
    with dsurface.Canvas do
    begin
      with DNewAccount do
      begin
        d := DMenuDlg.WLib.Images[FaceIndex];
        //d:=g_UIBImages.Images[22];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      SetBkMode(Handle, TRANSPARENT);
      Font.Color := clSilver;
      for i := 0 to NAHelps.Count - 1 do
      begin
        //TextOut (79 + 386 + 10, 64 + 119 + 5 + i*14, NAHelps[i]);
        TextOut((SCREENWIDTH div 2 - 320) + 386 + 10, (SCREENHEIGHT div 2 - 238)
          + 119 + 5 + i * 14, NAHelps[i]);
      end;
      BoldTextOut(dsurface, 79 + 283, 64 + 57, clWhite, clBlack,
        NewAccountTitle);
      Release;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DNewAccountDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------------------}
////Chg pw 冠胶

procedure TFrmDlg.DChgpwOkClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if Sender = DChgpwOk then
      LoginScene.ChgpwOk;
    if Sender = DChgpwCancel then
      LoginScene.ChgpwCancel;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DChgpwOkClick'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------------------}
//某腐磐 急琶

procedure TFrmDlg.DscSelect1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    with Sender as TDButton do
    begin
      if Downed then
      begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(Left, Top, d.ClientRect, d, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DscSelect1DirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DscSelect1Click(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if Sender = DscSelect1 then
      SelectChrScene.SelChrSelect1Click;
    if Sender = DscSelect2 then
      SelectChrScene.SelChrSelect2Click;
    if Sender = DscStart then
      SelectChrScene.SelChrStartClick;
    if Sender = DscNewChr then
      SelectChrScene.SelChrNewChrClick;
    if Sender = DscEraseChr then
      SelectChrScene.SelChrEraseChrClick;
    if Sender = DscCredits then
      SelectChrScene.SelChrCreditsClick;
    if Sender = DscExit then
      SelectChrScene.SelChrExitClick;
    if Sender = DButRenewClose then
      FrmDlg.DRenewChr.Visible := False;
    if Sender = DButRenewChr then
      SelectChrScene.SelRenewChr;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DscSelect1Click'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------------------}
//货 某腐磐 父甸扁 芒

procedure TFrmDlg.DccCloseDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    with Sender as TDButton do
    begin
      if Downed then
      begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end
      else
      begin
        d := nil;
        if Sender = DccWarrior then
        begin
          with SelectChrScene do
            if ChrArr[NewIndex].UserChr.Job = 0 then
              d := WLib.Images[55];
        end;
        if Sender = DccWizzard then
        begin
          with SelectChrScene do
            if ChrArr[NewIndex].UserChr.Job = 1 then
              d := WLib.Images[56];
        end;
        if Sender = DccMonk then
        begin
          with SelectChrScene do
            if ChrArr[NewIndex].UserChr.Job = 2 then
              d := WLib.Images[57];
        end;
        if Sender = DccMale then
        begin
          with SelectChrScene do
            if ChrArr[NewIndex].UserChr.Sex = 0 then
              d := WLib.Images[58];
        end;
        if Sender = DccFemale then
        begin
          with SelectChrScene do
            if ChrArr[NewIndex].UserChr.Sex = 1 then
              d := WLib.Images[59];
        end;
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DccCloseDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DccCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if Sender = DccClose then
      SelectChrScene.SelChrNewClose;
    if Sender = DccWarrior then
      SelectChrScene.SelChrNewJob(0);
    if Sender = DccWizzard then
      SelectChrScene.SelChrNewJob(1);
    if Sender = DccMonk then
      SelectChrScene.SelChrNewJob(2);
    if Sender = DccReserved then
      SelectChrScene.SelChrNewJob(3);
    if Sender = DccMale then
      SelectChrScene.SelChrNewm_btSex(0);
    if Sender = DccFemale then
      SelectChrScene.SelChrNewm_btSex(1);
    if Sender = DccLeftHair then
      SelectChrScene.SelChrNewPrevHair;
    if Sender = DccRightHair then
      SelectChrScene.SelChrNewNextHair;
    if Sender = DccOk then
      SelectChrScene.SelChrNewOk;
    if Sender = DButRenewClose then
      SelectChrScene.SelChrNewOk;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DccCloseClick'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------------------}

//惑怕芒...

{------------------------------------------------------------------------}

procedure TFrmDlg.DStateWinDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  i, l, m, pgidx, magline, bbx, bby, mmx, idx, ax, ay, trainlv: integer;
  pm: PTClientMagic;
  d: TDirectDrawSurface;
  hcolor, old, keyimg: integer;
  iname, d1, d2, d3,d4: string;
  useable: Boolean;
  rc:TRect;
begin
  try //程序自动增加
    if g_MySelf = nil then
      exit;
    with DStateWin do
    begin
       d := g_UIBImages.Images[23];// WLib.Images[FaceIndex];
      if d = nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);

      case StatePage2 of
        0:
          begin //馒侩惑怕
            pgidx := 29;
            if g_MySelf <> nil then
              if g_MySelf.m_btSex = 1 then
                pgidx := 30;
            bbx := Left + 38;
            bby := Top + 52;
            d := g_WMain3Images.Images[pgidx];
            if d <> nil then
              dsurface.Draw(SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d,True);
            bbx := bbx - 7;
            bby := bby + 44;
            //渴, 公扁, 赣府 胶鸥老
            {idx := 440 + g_MySelf.m_btHair div 2; //赣府 胶鸥老
            if g_MySelf.m_btSex = 1 then idx := 480 + g_MySelf.m_btHair div 2;
            if idx > 0 then begin
               d := g_WMainImages.GetCachedImage (idx, ax, ay);
               if d <> nil then
                  dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
            end;        }
            //Jason
            //idx := HUMANFRAME * (g_MySelf.m_btHair + g_MySelf.m_btSex+1)-1; //赣府 胶鸥老
            idx := HUMANFRAME * (g_MySelf.m_btHair + 1) - 1;
            if idx > 0 then
            begin
              d := g_WHairImgImages.GetCachedImage(idx, ax, ay);
              if d <> nil then
                dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay),d.ClientRect, d, TRUE);
            end;
            if g_UseItems[U_DRESS].S.Name <> '' then
            begin
              idx := g_UseItems[U_DRESS].S.Looks;
              //渴 if Myself.m_btSex = 1 then idx := 80; //咯磊渴
              if idx >= 0 then
              begin
                //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                d := FrmMain.GetWStateImg(idx, ax, ay);
                if d <> nil then
                  dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay),d.ClientRect, d, TRUE);
              end;
            end;
            if g_UseItems[U_WEAPON].S.Name <> '' then
            begin
              idx := g_UseItems[U_WEAPON].S.Looks;
              if idx >= 0 then
              begin
                //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                d := FrmMain.GetWStateImg(idx, ax, ay);
                if d <> nil then
                  dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay),d.ClientRect, d, TRUE);
              end;
            end;
            if g_UseItems[U_STRAW].S.Name <> '' then
            begin
                if g_UseItems[U_STRAW].S.Shape=0 then
                 idx := 1188//g_UseItems[U_STRAW].S.Looks;斗笠
                else
                 idx := g_UseItems[U_STRAW].S.Looks;//王者斗笠
                if idx >= 0 then
                begin
                  //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                  d := FrmMain.GetWStateImg(idx, ax, ay);
                  if d <> nil then
                    dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay),d.ClientRect, d, TRUE);
                end;
            end
            else
            begin
              if g_UseItems[U_HELMET].S.Name <> '' then
              begin
                idx := g_UseItems[U_HELMET].S.Looks;
                if idx >= 0 then
                begin
                  //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                  d := FrmMain.GetWStateImg(idx, ax, ay);
                  if d <> nil then
                    dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, TRUE);
                end;
              end;
            end;
          end;
        1:
          begin //瓷仿摹
            l := Left + 111; //66;
            m := Top + 98;
            with dsurface.Canvas do
            begin
              SetBkMode(Handle, TRANSPARENT);
              Font.Color := clWhite;
              TextOut(SurfaceX(l + 0), SurfaceY(m + 0),
                IntToStr(LoWord(g_MySelf.m_Abil.AC)) + '-' +
                IntToStr(HiWord(g_MySelf.m_Abil.AC)));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 20),
                IntToStr(LoWord(g_MySelf.m_Abil.MAC)) + '-' +
                IntToStr(HiWord(g_MySelf.m_Abil.MAC)));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 40),
                IntToStr(LoWord(g_MySelf.m_Abil.DC)) + '-' +
                IntToStr(HiWord(g_MySelf.m_Abil.DC)));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 60),
                IntToStr(LoWord(g_MySelf.m_Abil.MC)) + '-' +
                IntToStr(HiWord(g_MySelf.m_Abil.MC)));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 80),
                IntToStr(LoWord(g_MySelf.m_Abil.SC)) + '-' +
                IntToStr(HiWord(g_MySelf.m_Abil.SC)));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 100),
                IntToStr(g_MySelf.m_Abil.HP) + '/' +
                IntToStr(g_MySelf.m_Abil.MaxHP));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 120),
                IntToStr(g_MySelf.m_Abil.MP) + '/' +
                IntToStr(g_MySelf.m_Abil.MaxMP));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 140),
                IntToStr(g_MySelf.m_MedicineRec.MedicineValue) + '/' +
                IntToStr(g_MySelf.m_MedicineRec.MaxMedicineValue));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 160),
                IntToStr(g_MySelf.m_WineRec.WineValue));
              Release;
            end;
          end;
        2:
          begin //瓷仿摹 汲疙芒
            bbx := Left + 38;
            bby := Top + 52;
            d := g_WMain3Images.Images[32];
            if d <> nil then
              dsurface.Draw(SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d,True);

            bbx := bbx + 20;
            bby := bby + 10;
            with dsurface.Canvas do
            begin
              SetBkMode(Handle, TRANSPARENT);
              mmx := bbx + 85;
              Font.Color := clSilver;
              TextOut(bbx, bby, '当前经验');
              TextOut(mmx, bby, IntToStr(g_MySelf.m_Abil.Exp));

              TextOut(bbx, bby + 14 * 1, '升级经验');
              TextOut(mmx, bby + 14 * 1, IntToStr(g_MySelf.m_Abil.MaxExp));

              TextOut(bbx, bby + 14 * 2, '背包重量');
              if g_MySelf.m_Abil.Weight > g_MySelf.m_Abil.MaxWeight then
                Font.Color := clRed;
              TextOut(mmx, bby + 14 * 2, IntToStr(g_MySelf.m_Abil.Weight) + '/'
                + IntToStr(g_MySelf.m_Abil.MaxWeight));

              Font.Color := clSilver;
              TextOut(bbx, bby + 14 * 3, '穿戴重量');
              if g_MySelf.m_Abil.WearWeight > g_MySelf.m_Abil.MaxWearWeight then
                Font.Color := clRed;
              TextOut(mmx, bby + 14 * 3, IntToStr(g_MySelf.m_Abil.WearWeight) +
                '/' + IntToStr(g_MySelf.m_Abil.MaxWearWeight));

              Font.Color := clSilver;
              TextOut(bbx, bby + 14 * 4, '腕力');
              if g_MySelf.m_Abil.HandWeight > g_MySelf.m_Abil.MaxHandWeight then
                Font.Color := clRed;
              TextOut(mmx, bby + 14 * 4, IntToStr(g_MySelf.m_Abil.HandWeight) +
                '/' + IntToStr(g_MySelf.m_Abil.MaxHandWeight));

              Font.Color := clSilver;
              TextOut(bbx, bby + 14 * 5, '精确度');
              TextOut(mmx, bby + 14 * 5, IntToStr(g_nMyHitPoint));

              TextOut(bbx, bby + 14 * 6, '敏捷度');
              TextOut(mmx, bby + 14 * 6, IntToStr(g_nMySpeedPoint));

              TextOut(bbx, bby + 14 * 7, '魔法防御');
              TextOut(mmx, bby + 14 * 7, '+' + IntToStr(g_nMyAntiMagic * 10) +
                '%');

              TextOut(bbx, bby + 14 * 8, '中毒防御');
              TextOut(mmx, bby + 14 * 8, '+' + IntToStr(g_nMyAntiPoison * 10) +
                '%');

              TextOut(bbx, bby + 14 * 9, '中毒恢复');
              TextOut(mmx, bby + 14 * 9, '+' + IntToStr(g_nMyPoisonRecover * 10)
                + '%');

              TextOut(bbx, bby + 14 * 10, '体力恢复');
              TextOut(mmx, bby + 14 * 10, '+' + IntToStr(g_nMyHealthRecover * 10)
                + '%');

              TextOut(bbx, bby + 14 * 11, '魔法恢复');
              TextOut(mmx, bby + 14 * 11, '+' + IntToStr(g_nMySpellRecover * 10)
                + '%');
              //{$IF SOFTNEWVER   = VERWOWUYU}
              //TextOut (bbx, bby+14*12, '王城贡献');
              //TextOut (bbx, bby+14*13, '元气数值');
              //{$ELSE}
              TextOut(bbx, bby + 14 * 12, g_sGameDiamond);
              TextOut(bbx, bby + 14 * 13, g_sGameGird);
              //{$IFEND}
              TextOut(mmx, bby + 14 * 12, IntToStr(g_MySelf.m_nGameDiamond));
              TextOut(mmx, bby + 14 * 13, IntToStr(g_MySelf.m_nGameGird));
              TextOut (bbx, bby+14*14, '元宝数量');
              TextOut (mmx, bby+14*14,  IntToStr(g_MySelf.m_nGameGold));

              Release;
            end;
          end;
        3:
          begin //魔法 芒
            bbx := Left + 38;
            bby := Top + 52;
            d := g_WMain99Images.Images[61];
            if d <> nil then
              dsurface.Draw(SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d,True);

            //虐 钎矫, lv, exp
            magtop := MagicPage * 6;
            magline := _MIN(MagicPage * 6 + 6, g_MagicList.Count);
            for i := magtop to magline - 1 do
            begin
              pm := PTClientMagic(g_MagicList[i]);
              m := i - magtop;
              keyimg := 0;
              case byte(pm.Key) of
                {
                byte('1'): keyimg := 248;
                byte('2'): keyimg := 249;
                byte('3'): keyimg := 250;
                byte('4'): keyimg := 251;
                byte('5'): keyimg := 252;
                byte('6'): keyimg := 253;
                byte('7'): keyimg := 254;
                byte('8'): keyimg := 255;
                }
                byte('1'): keyimg := 156;
                byte('2'): keyimg := 157;
                byte('3'): keyimg := 158;
                byte('4'): keyimg := 159;
                byte('5'): keyimg := 160;
                byte('6'): keyimg := 161;
                byte('7'): keyimg := 162;
                byte('8'): keyimg := 163;
                byte('E'): keyimg := 148;
                byte('F'): keyimg := 149;
                byte('G'): keyimg := 150;
                byte('H'): keyimg := 151;
                byte('I'): keyimg := 152;
                byte('J'): keyimg := 153;
                byte('K'): keyimg := 154;
                byte('L'): keyimg := 155;
              end;
              if keyimg > 0 then
              begin
                d := g_WMain3Images.Images[keyimg];
                if d <> nil then
                  dsurface.Draw(bbx + 145, bby + 8 + m * 37, d.ClientRect, d,TRUE);
              end;
             if pm.Def.wMagicID = 84 then //处理酒气护体显示
             begin
              d := g_WMainImages.Images[112]; //lv
              if d <> nil then
                dsurface.Draw(bbx + 48+60, bby + 8 +m * 37, d.ClientRect, d,TRUE);
              DButton3.Left:=38+48;
              DButton3.Top:= 52+8 +15+ m * 37;
              DButton3.Width:=92;
              DButton3.Height:=8;
              DButton3.Visible:=True;
              {
              d :=  g_WMain2Images.Images[577];
              if d <> nil then
                dsurface.Draw(bbx + 48, bby + 8 +15+ m * 37, d.ClientRect, d,TRUE);
                d := g_WMain2Images.Images[578];
              if d <> nil then
              begin
                try
                  rc := d.ClientRect;
                  rc.Right := Round((rc.Right-rc.Left) / 100 *
                    (Round(g_MySelf.m_SKILL84Rec.SKILL84Exp /g_MySelf.m_SKILL84Rec.MaxSKILL84Exp*100)));
                  dsurface.Draw(bbx + 48, bby + 8 +15+ m * 37, rc, d, True);
                except

                end;
              end; }
             end else
             begin
              d := g_WMainImages.Images[112]; //lv
              if d <> nil then
                dsurface.Draw(bbx + 48, bby + 8 + 15 + m * 37, d.ClientRect, d,
                  TRUE);
              d := g_WMainImages.Images[111]; //exp
              if d <> nil then
                dsurface.Draw(bbx + 48 + 26, bby + 8 + 15 + m * 37,d.ClientRect, d, TRUE);
             end;
            end;
            //显示人物技能等级名称
            with dsurface.Canvas do
            begin
              SetBkMode(Handle, TRANSPARENT);
              Font.Color := clSilver;
              for i := magtop to magline - 1 do
              begin
                pm := PTClientMagic(g_MagicList[i]);
                m := i - magtop;
                if not (pm.Level in [0..4]) then
                  pm.Level := 0;
                if ((pm.Def.wMagicID = 57) or (pm.Def.wMagicID = 81)) then
                  TextOut(bbx + 48, bby + 8 + m * 37, Copy(pm.Def.sMagicName, 1,
                    Length(pm.Def.sMagicName) - 1))
                else
                  TextOut(bbx + 48, bby + 8 + m * 37, pm.Def.sMagicName);
                if pm.Level in [0..4] then
                begin
                  if ((pm.Def.wMagicID = 57) or (pm.Def.wMagicID = 81)) then
                    trainlv := 4
                  else
                    trainlv := pm.Level;
                end
                else
                  trainlv := 0;
                 if pm.Def.wMagicID = 84 then
                 begin
                   TextOut(bbx + 48 + 80, bby + 8 +  m * 37,IntToStr(g_MySelf.m_SKILL84Rec.SKILL84Level));
                 end else
                 begin
                   if pm.Def.wMagicID = 83 then
                   begin
                     //先天原力等级显示
                   TextOut(bbx + 48 + 16, bby + 8 + 15 + m * 37,IntToStr(g_MySelf.m_SKILL83Rec.skill83Level));
                     if g_MySelf.m_SKILL83Rec.skill83Level < 3 then
                      begin
                         TextOut(bbx + 48 + 46, bby + 8 + 15 + m * 37,IntToStr(g_MySelf.m_WineRec.WineValue) + '/' +
                           IntToStr(g_MySelf.m_SKILL83Rec.MaxWineValue));
                        end
                      else
                         TextOut(bbx + 48 + 46, bby + 8 + 15 + m * 37, '-');
                   end else
                   begin
                    TextOut(bbx + 48 + 16, bby + 8 + 15 + m * 37,IntToStr(trainlv));
                    if pm.Def.MaxTrain[_MIN(3, trainlv)] > 0 then
                    begin
                     if trainlv < 3 then
                      begin
                         TextOut(bbx + 48 + 46, bby + 8 + 15 + m * 37,IntToStr(pm.CurTrain) + '/' +
                           IntToStr(pm.Def.MaxTrain[trainlv]));
                        end
                      else
                         TextOut(bbx + 48 + 46, bby + 8 + 15 + m * 37, '-');
                    end;
                  end;
                 end;
              end;
              Release;
            end;
          end;
      end;
      //原为打开，本代码为显示人物身上所带物品信息，显示位置为人物下方
      if g_MouseStateItem.S.Name <> '' then
      begin
        g_MouseItem := g_MouseStateItem;
        GetMouseItemInfo(iname, d1, d2, d3,d4, useable);
        if iname <> '' then
        begin
          if (g_MouseItem.Dura = 0) and (not((g_MouseItem.S.StdMode=2) and (g_MouseItem.S.reserved=56)))   then
            hcolor := clRed
          else
            hcolor := clWhite;
      //    if  (g_MouseItem.S.StdMode=2) and (g_MouseItem.S.reserved=56) then
      //     hcolor := clWhite;
          with dsurface.Canvas do
          begin
            SetBkMode(Handle, TRANSPARENT);
            old := Font.Size;
            Font.Size := 9;
            Font.Color := clYellow;
            TextOut(SurfaceX(Left + 37), SurfaceY(Top + 309), iname);
            Font.Color := hcolor;
            TextOut(SurfaceX(Left + 37 + TextWidth(iname)), SurfaceY(Top + 309),
              d1);
            TextOut(SurfaceX(Left + 37), SurfaceY(Top + 309 + TextHeight('A') +
              2), d2);
            TextOut(SurfaceX(Left + 37), SurfaceY(Top + 309 + (TextHeight('A') +
              2) * 2), d3+d4);
            Font.Size := old;
            Release;
          end;
        end;
        g_MouseItem.S.Name := '';
      end;

      //捞抚
      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        Font.Color := g_MySelf.m_nNameColor;
        TextOut(SurfaceX(Left + 122 - TextWidth(CharName) div 2),
          SurfaceY(Top + 23), g_MySelf.m_sUserName);
        if StatePage2 = 0 then
        begin
          Font.Color := clSilver;
          TextOut(SurfaceX(Left + 45), SurfaceY(Top + 55),
            g_sGuildName + ' ' + g_sGuildRankName);
        end;
        Release;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DStateWinDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DSWLightDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  idx: integer;
  d: TDirectDrawSurface;
  tidx: integer;
  ClientItem: TClientItem;
  Button: TDButton;
begin
  try //程序自动增加
    if StatePage2 = 0 then
    begin
      if Sender is TDButton then
      begin
        Button := TDButton(Sender);
        ClientItem.S.Name := '';
        if Sender = DSWNecklace then
          ClientItem := g_UseItems[U_NECKLACE];
        if Sender = DSWLight then
          ClientItem := g_UseItems[U_RIGHTHAND];
        if Sender = DSWArmRingR then
          ClientItem := g_UseItems[U_ARMRINGR];
        if Sender = DSWArmRingL then
          ClientItem := g_UseItems[U_ARMRINGL];
        if Sender = DSWRingR then
          ClientItem := g_UseItems[U_RINGR];
        if Sender = DSWRingL then
          ClientItem := g_UseItems[U_RINGL];
        if Sender = DSWBujuk then
          ClientItem := g_UseItems[U_BUJUK];
        if Sender = DSWBelt then
          ClientItem := g_UseItems[U_BELT];
        if Sender = DSWBoots then
          ClientItem := g_UseItems[U_BOOTS];
        if Sender = DSWCharm then
          ClientItem := g_UseItems[U_CHARM];
        if ClientItem.S.Name <> '' then
        begin
          idx := ClientItem.S.Looks;
          d := FrmMain.GetWStateImg(idx);
          if d <> nil then
            dsurface.Draw(Button.SurfaceX(Button.Left + (Button.Width - d.Width)
              div 2),
              Button.SurfaceY(Button.Top + (Button.Height - d.Height) div 2),
              d.ClientRect, d, TRUE);
          if ClientItem.Shine <> 0 then
          begin
            d := g_WMain2Images.Images[260 + m_LightIdx];
            if d <> nil then
              DrawBlend(dsurface,
                Button.SurfaceX(Button.Left - 21),
                Button.SurfaceY(Button.Top - 23),
                d, 1);
          end;
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DSWLightDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DStateWinClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if StatePage2 = 3 then
    begin
      X := DStateWin.LocalX(X) - DStateWin.Left;
      Y := DStateWin.LocalY(Y) - DStateWin.Top;
      if (X >= 33) and (X <= 33 + 166) and (Y >= 55) and (Y <= 55 + 37 * 5) then
      begin
        magcur := (Y - 55) div 37;
        if (magcur + magtop) >= g_MagicList.Count then
          magcur := (g_MagicList.Count - 1) - magtop;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DStateWinClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DCloseStateClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DStateWin.Visible := FALSE;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DCloseStateClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DPrevStateDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    with Sender as TDButton do
    begin
      if TDButton(Sender).Downed then
      begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DPrevStateDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.PageChanged(Sender: TObject);
begin
  try //程序自动增加
    DScreen.ClearHint;
  if (Sender = DPrevHeroState) or (Sender = DNextHeroState) then
   begin
      case HeroStatePage of
      3:
        begin
          DHeroMag1.Visible := TRUE;
          DHeroMag2.Visible := TRUE;
          DHeroMag3.Visible := TRUE;
          DHeroMag4.Visible := TRUE;
          DHeroMag5.Visible := TRUE;
          DHeroMag6.Visible := TRUE;
          DHeroPageUp.Visible := TRUE;
          DHeroPageDown.Visible := TRUE;
          HeroMagIcPage := 0;
        end;
    else
      begin
        DHeroMag1.Visible := FALSE;
        DHeroMag2.Visible := FALSE;
        DHeroMag3.Visible := FALSE;
        DHeroMag4.Visible := FALSE;
        DHeroMag5.Visible := FALSE;
        DHeroMag6.Visible := FALSE;
        DHeroPageUp.Visible := FALSE;
        DHeroPageDown.Visible := FALSE;
      end;
    end;
   end else
   begin
    case StatePage2 of
      3:
        begin //魔法 惑怕芒
          DStMag1.Visible := TRUE;
          DStMag2.Visible := TRUE;
          DStMag3.Visible := TRUE;
          DStMag4.Visible := TRUE;
          DStMag5.Visible := TRUE;
          DStMag6.Visible := TRUE;
          DStPageUp.Visible := TRUE;
          DStPageDown.Visible := TRUE;
          MagicPage := 0;
        end;
    else
      begin
        DStMag1.Visible := FALSE;
        DStMag2.Visible := FALSE;
        DStMag3.Visible := FALSE;
        DStMag4.Visible := FALSE;
        DStMag5.Visible := FALSE;
        DStMag6.Visible := FALSE;
        DStPageUp.Visible := FALSE;
        DStPageDown.Visible := FALSE;
      end;
    end;
   end;

   if StatePage2=1 then
      DLiquorProgress.Visible:=True
   else
      DLiquorProgress.Visible:=False;

   if HeroStatePage=1 then
      DHeroLiquorProgress.Visible:=True
   else
      DHeroLiquorProgress.Visible:=False;
  DButton3.Visible:=False;
  DButton4.Visible:=False;
  
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.PageChanged'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DPrevStateClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if Sender = DPrevHeroState then
    begin
      Dec(HeroStatePage);
      if HeroStatePage < 0 then
        HeroStatePage := MAXSTATEPAGE - 1;
      PageChanged(Sender);
    end
    else
    begin
      Dec(StatePage2);
      if StatePage2 < 0 then
        StatePage2 := MAXSTATEPAGE - 1;
      PageChanged(Sender);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DPrevStateClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DNextStateClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if Sender = DNextHeroState then
    begin
      Inc(HeroStatePage);
      if HeroStatePage > MAXSTATEPAGE - 1 then
        HeroStatePage := 0;
      PageChanged(Sender);
    end
    else
    begin
      Inc(StatePage2);
      if StatePage2 > MAXSTATEPAGE - 1 then
        StatePage2 := 0;
      PageChanged(Sender);
    end;

{  if StatePage2=1 then
    DLiquorProgress.Visible:=True
 else
    DLiquorProgress.Visible:=False;

 if HeroStatePage=1 then
    DHeroLiquorProgress.Visible:=True
 else
    DHeroLiquorProgress.Visible:=False;
   DButton3.Visible:=False;
  DButton4.Visible:=False;}       
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DNextStateClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DSWWeaponClick(Sender: TObject; X, Y: Integer);
var
  where, n, sel: integer;
  flag, movcancel: Boolean;
begin
  try //程序自动增加
    if g_MySelf = nil then
      exit;
    if StatePage2 <> 0 then
      exit;
    if g_boItemMoving then
    begin
      flag := FALSE;
      movcancel := FALSE;
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) or
        (g_MovingItem.Index = -99) then
        exit;
      if (g_MovingItem.Item.S.Name = '') or (g_WaitingUseItem.Item.S.Name <> '')
        then
        exit;
      if g_MovingItem.Hero then
        exit;
      where := GetTakeOnPosition(g_MovingItem.Item.S.StdMode);
      if g_MovingItem.Index >= 0 then
      begin
        case where of
          U_DRESS:
            begin
              if Sender = DSWDress then
              begin
                if g_MySelf.m_btSex = 0 then //巢磊
                  if g_MovingItem.Item.S.StdMode <> 10 then //巢磊渴
                    exit;
                if g_MySelf.m_btSex = 1 then //咯磊
                  if g_MovingItem.Item.S.StdMode <> 11 then //咯磊渴
                    exit;
                flag := TRUE;
              end;
            end;
          U_WEAPON:
            begin
              if Sender = DSWWEAPON then
              begin
                flag := TRUE;
              end;
            end;
          U_NECKLACE:
            begin
              if Sender = DSWNecklace then
                flag := TRUE;
            end;
          U_RIGHTHAND:
            begin
              if Sender = DSWLight then
                flag := TRUE;
            end;
          U_HELMET, U_STRAW:
            begin
              if Sender = DSWHelmet then
                flag := TRUE;
            end;
          U_RINGR, U_RINGL:
            begin
              if Sender = DSWRingL then
              begin
                where := U_RINGL;
                flag := TRUE;
              end;
              if Sender = DSWRingR then
              begin
                where := U_RINGR;
                flag := TRUE;
              end;
            end;
          U_ARMRINGR, U_ARMRINGL:
            begin
              if Sender = DSWArmRingL then
              begin
                where := U_ARMRINGL;
                flag := TRUE;
              end;
              if Sender = DSWArmRingR then
              begin
                where := U_ARMRINGR;
                flag := TRUE;
              end;
            end;
          U_BUJUK:
            begin
              if Sender = DSWBujuk then
              begin
                where := U_BUJUK;
                flag := TRUE;
              end;
              if Sender = DSWArmRingL then
              begin
                where := U_ARMRINGL;
                flag := TRUE;
              end;
             { if Sender=DSWBujuk then
              begin
               if (g_MovingItem.Item.S.StdMode=2) and (g_MovingItem.Item.S.reserved=56) then
                flag := TRUE;
              end; }
            end;
          U_BELT:
            begin
              if Sender = DSWBelt then
              begin
                where := U_BELT;
                flag := TRUE;
              end;
            end;
          U_BOOTS:
            begin
              if Sender = DSWBoots then
              begin
                where := U_BOOTS;
                flag := TRUE;
              end;
            end;
          U_CHARM:
            begin
              if Sender = DSWCharm then
              begin
                where := U_CHARM;
                flag := TRUE;
              end;
            end;
        end;
      end
      else
      begin
        n := -(g_MovingItem.Index + 1);
        if n in [0..MAXUSEITEMS] then
        begin
          ItemClickSound(g_MovingItem.Item.S);
          g_UseItems[n] := g_MovingItem.Item;
          g_MovingItem.Item.S.Name := '';
          g_boItemMoving := FALSE;
        end;
      end;
      if flag then
      begin
        ItemClickSound(g_MovingItem.Item.S);
        g_WaitingUseItem := g_MovingItem;
        g_WaitingUseItem.Index := where;

        FrmMain.SendTakeOnItem(where, g_MovingItem.Item.MakeIndex,
          g_MovingItem.Item.S.Name);
        g_MovingItem.Item.S.Name := '';
        g_boItemMoving := FALSE;
      end;
    end
    else
    begin
      flag := FALSE;
      if (g_MovingItem.Item.S.Name <> '') or (g_WaitingUseItem.Item.S.Name <> '')
        then
        exit;
      sel := -1;
      if Sender = DSWDress then
        sel := U_DRESS;
      if Sender = DSWWeapon then
        sel := U_WEAPON;
      if Sender = DSWHelmet then
      begin
        sel := U_HELMET;
        if g_UseItems[U_STRAW].S.Name <> '' then
          sel := U_STRAW;
      end;
      if Sender = DSWNecklace then
        sel := U_NECKLACE;
      if Sender = DSWLight then
        sel := U_RIGHTHAND;
      if Sender = DSWRingL then
        sel := U_RINGL;
      if Sender = DSWRingR then
        sel := U_RINGR;
      if Sender = DSWArmRingL then
        sel := U_ARMRINGL;
      if Sender = DSWArmRingR then
        sel := U_ARMRINGR;

      if Sender = DSWBujuk then
        sel := U_BUJUK;
      if Sender = DSWBelt then
        sel := U_BELT; //
      if Sender = DSWBoots then
        sel := U_BOOTS;
      if Sender = DSWCharm then
        sel := U_CHARM;

      if sel >= 0 then
      begin
        if g_UseItems[sel].S.Name <> '' then
        begin
          ItemClickSound(g_UseItems[sel].S);
          g_MovingItem.Index := -(sel + 1);
          g_MovingItem.Item := g_UseItems[sel];
          g_MovingItem.Hero := False;
          g_UseItems[sel].S.Name := '';
          g_boItemMoving := TRUE;
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DSWWeaponClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DSWWeaponMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
  sel: integer;
  iname, d1, d2, d3,d4: string;
  useable: Boolean;
  hcolor: TColor;
  Butt: TDButton;
begin
  try //程序自动增加
    if StatePage2 <> 0 then
      exit;
    DScreen.ClearHint;
    sel := -1;
    Butt := TDButton(Sender);
    if Sender = DSWDress then
      sel := U_DRESS;
    if Sender = DSWWeapon then
      sel := U_WEAPON;
    if Sender = DSWHelmet then
      sel := U_HELMET;
    if Sender = DSWNecklace then
      sel := U_NECKLACE;
    if Sender = DSWLight then
      sel := U_RIGHTHAND;
    if Sender = DSWRingL then
      sel := U_RINGL;
    if Sender = DSWRingR then
      sel := U_RINGR;
    if Sender = DSWArmRingL then
      sel := U_ARMRINGL;
    if Sender = DSWArmRingR then
      sel := U_ARMRINGR;
    if Sender = DSWBujuk then
      sel := U_BUJUK;
    if Sender = DSWBelt then
      sel := U_BELT;
    if Sender = DSWBoots then
      sel := U_BOOTS;
    if Sender = DSWCharm then
      sel := U_CHARM;

    if sel >= 0 then
    begin
      g_MouseStateItem := g_UseItems[sel];
      if (sel = U_HELMET) and (g_UseItems[U_STRAW].MakeIndex > 0) then
      begin
        g_MouseItem := g_UseItems[U_STRAW];
        GetMouseItemInfo(iname, d1, d2, d3,d4, useable);
        if iname <> '' then
        begin
          if g_UseItems[U_STRAW].Dura = 0 then
            hcolor := clRed
          else
            hcolor := clWhite;
          with Butt as TDButton do

            DScreen.ShowHint(SurfaceX(Left + 30),
              SurfaceY(Top - 10),
              iname + '\' + d1 + '\' + d2 + '\' + d3+d4, hcolor, FALSE);
        end;
      end;
      //原为注释掉 显示人物身上带的物品信息
     { g_MouseItem := g_UseItems[sel];
      GetMouseItemInfo (iname, d1, d2, d3, useable);
      if iname <> '' then begin
         if g_UseItems[sel].Dura = 0 then hcolor := clRed
         else hcolor := clWhite;

         nLocalX:=Butt.LocalX(X - Butt.Left);
         nLocalY:=Butt.LocalY(Y - Butt.Top);
         nHintX:=Butt.SurfaceX(Butt.Left) + DStateWin.SurfaceX(DStateWin.Left) + nLocalX;
         nHintY:=Butt.SurfaceY(Butt.Top) + DStateWin.SurfaceY(DStateWin.Top) + nLocalY; }

        { with Sender as TDButton do
            DScreen.ShowHint (SurfaceX(Left - 30),
                              SurfaceY(Top + 50),
                              iname + d1 + '\' + d2 + '\' + d3, hcolor, FALSE);}

         {with Butt as TDButton do
          DScreen.ShowHint(nHintX,nHintY,
                             iname + d1 + '\' + d2 + '\' + d3, hcolor, FALSE);}
      //end;
      g_MouseItem.S.Name := '';
      //

    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DSWWeaponMouseMove'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DStateWinMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  try //程序自动增加
    DScreen.ClearHint;
    g_MouseStateItem.S.Name := '';
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DStateWinMouseMove'); //程序自动增加
  end; //程序自动增加
end;

//惑怕芒 : 魔法 其捞瘤

procedure TFrmDlg.DStMag1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  idx, icon: integer;
  d: TDirectDrawSurface;
  pm: PTClientMagic;
begin
  try //程序自动增加
    with Sender as TDButton do
    begin
      idx := _Max(Tag + MagicPage * 6, 0);
      if idx < g_MagicList.Count then
      begin
        pm := PTClientMagic(g_MagicList[idx]);
        if pm.Def.wMagicID<>75 then
        icon := pm.Def.btEffect * 2
        else
        icon:=0;
        if icon >= 0 then
        begin //酒捞能捞 绝绰芭..
          if not Downed then
          begin
            d := g_WMagIconImages.Images[icon];
            if d = nil then
              d := g_WMagIconImages.Images[0];
            if d <> nil then
              dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d,
                TRUE);
          end
          else
          begin
            d := g_WMagIconImages.Images[icon + 1];
            if d = nil then
              d := g_WMagIconImages.Images[1];
            if d <> nil then
              dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d,
                TRUE);
          end;
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DStMag1DirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DStMag1Click(Sender: TObject; X, Y: Integer);
var
  i, idx: integer;
  selkey: word;
  keych: char;
  pm: PTClientMagic;
begin
  try //程序自动增加
    if StatePage2 = 3 then
    begin
      idx := TDButton(Sender).Tag + magtop;
      if (idx >= 0) and (idx < g_MagicList.Count) then
      begin

        pm := PTClientMagic(g_MagicList[idx]);
        if pm.Def.wMagicID=83 then Exit;
        selkey := word(pm.Key);
        if pm.Def.wMagicID<>75 then
          SetMagicKeyDlg(pm.Def.btEffect * 2, pm.Def.sMagicName, selkey)
        else
          SetMagicKeyDlg(0, pm.Def.sMagicName, selkey);
        keych := char(selkey);

        for i := 0 to g_MagicList.Count - 1 do
        begin
          pm := PTClientMagic(g_MagicList[i]);
          if pm.Key = keych then
          begin
            pm.Key := #0;
            FrmMain.SendMagicKeyChange(pm.Def.wMagicId, #0);
          end;
        end;
        pm := PTClientMagic(g_MagicList[idx]);
        //if pm.Def.EffectType <> 0 then begin //八过篮 虐汲沥阑 给窃.
        pm.Key := keych;
        FrmMain.SendMagicKeyChange(pm.Def.wMagicId, keych);
        //end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DStMag1Click'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DStPageUpClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if Sender = DStPageUp then
    begin
      if MagicPage > 0 then
        Dec(MagicPage);
    end
    else
    begin
      if MagicPage < (g_MagicList.Count + 4) div 5 - 1 then
        Inc(MagicPage);
    end;
  DButton3.Visible:=False;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DStPageUpClick'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------------------}

//官蹿 惑怕

{------------------------------------------------------------------------}

procedure TFrmDlg.DBottomDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
//ResourceString
  //sTest2  = '“F12”键 打开游戏设置';
const
  BOXWIDTH = (SCREENWIDTH div 2 - 214) * 2;
var
  d: TDirectDrawSurface;
  rc: TRect;
  btop, sx, sy, i, fcolor, bcolor: integer;
  r: Real;
  str: string;
begin
  try //程序自动增加
{$IF SWH = SWH800}
    d := g_WMain3Images.Images[BOTTOMBOARD800];
{$ELSEIF SWH = SWH1024}
    d := g_WMain3Images.Images[BOTTOMBOARD1024];
{$IFEND}
    if d <> nil then
      dsurface.Draw(DBottom.Left, DBottom.Top, d.ClientRect, d, TRUE);
    btop := 0;
    if d <> nil then
    begin
      with d.ClientRect do
        rc := Rect(Left, Top, Right, Top + 120);
      btop := SCREENHEIGHT - d.height;
      dsurface.Draw(0,
        btop,
        rc,
        d, TRUE);
      with d.ClientRect do
        rc := Rect(Left, Top + 120, Right, Bottom);
      dsurface.Draw(0,
        btop + 120,
        rc,
        d, FALSE);
    end;
    if (GetTickCount - m_LightTick) > 200 then
    begin
      m_LightTick := GetTickCount;
      Inc(m_LightIdx);
      if m_LightIdx > 5 then
        m_LightIdx := 0;
    end;
    d := nil;
    case g_nDayBright of
      0: d := g_WMainImages.Images[15]; //早上
      1: d := g_WMainImages.Images[12]; //白天
      2: d := g_WMainImages.Images[13]; //傍晚
      3: d := g_WMainImages.Images[14]; //晚上
    end;
    if d <> nil then
      dsurface.Draw(SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 348)) {748},
        79 + DBottom.Top, d.ClientRect, d, FALSE);

    //怒气值显示
    if (g_HeronRecogId <> 0) and (g_HeroDander > 0) then
    begin
      d := g_WMain3Images.Images[410];
      if d <> nil then
        dsurface.Draw(603, SCREENHEIGHT - d.Height, d.ClientRect, d, True);
      if g_HeroDanderOk then
      begin
        if ((GetTIckCount - g_HeroDanderShowTime) > 300) then
        begin
          g_HeroDanderShowTime := GetTickCount;
          if g_HeroDanderImg = 411 then
            g_HeroDanderImg := 412
          else
            g_HeroDanderImg := 411;
        end;
      end
      else
        g_HeroDanderImg := 411;

      d := g_WMain3Images.Images[g_HeroDanderImg];
      if d <> nil then
      begin
        rc := d.ClientRect;
        rc.Right := d.ClientRect.Right - 2;
        rc.Top := Round(rc.Bottom / g_HeroDanderMax * (g_HeroDanderMax -
          g_HeroDander));
        dsurface.Draw(605, btop + 106 + rc.Top, rc, d, True);
      end;
    end;

    if g_MySelf <> nil then
    begin
      //显示HP及MP 图形
      if (g_MySelf.m_Abil.MaxHP > 0) and (g_MySelf.m_Abil.MaxMP > 0) then
      begin
        if (g_MySelf.m_btJob = 0) and (g_MySelf.m_Abil.Level < 28) then
        begin //武士
          d := g_WMainImages.Images[5];
          if d <> nil then
          begin
            rc := d.ClientRect;
            rc.Right := d.ClientRect.Right - 2;
            dsurface.Draw(38, btop + 90, rc, d, FALSE);
          end;
          d := g_WMainImages.Images[6];
          if d <> nil then
          begin
            rc := d.ClientRect;
            rc.Right := d.ClientRect.Right - 2;
            rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxHP *
              (g_MySelf.m_Abil.MaxHP - g_MySelf.m_Abil.HP));
            dsurface.Draw(38, btop + 90 + rc.Top, rc, d, FALSE);
          end;
        end
        else
        begin
          d := g_WMainImages.Images[4];
          if d <> nil then
          begin
            //HP 图形
            rc := d.ClientRect;
            rc.Right := d.ClientRect.Right div 2 - 1;
            rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxHP *
              (g_MySelf.m_Abil.MaxHP - g_MySelf.m_Abil.HP));
            dsurface.Draw(40, btop + 91 + rc.Top, rc, d, FALSE);
            //MP 图形
            rc := d.ClientRect;
            rc.Left := d.ClientRect.Right div 2 + 1;
            rc.Right := d.ClientRect.Right - 1;
            rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxMP *
              (g_MySelf.m_Abil.MaxMP - g_MySelf.m_Abil.MP));
            dsurface.Draw(40 + rc.Left, btop + 91 + rc.Top, rc, d, FALSE);
          end;
        end;
      end;

(*
      //龙影剑法
      if g_MyMagic[42] <> nil then
      begin

        d := g_UIBImages.Images[24];
        if d <> nil then
          dsurface.Draw(78, 91 + DBottom.Top, d.ClientRect, d, FALSE);
        d := g_UIBImages.Images[25];
        if d <> nil then
        begin
          rc := d.ClientRect;
          rc.Right := d.ClientRect.Right - 2;
          rc.Top := Round(rc.Bottom / g_nDragonMax * (g_nDragonMax -
            g_nDragonCount));
          dsurface.Draw(78, 91 + DBottom.Top + rc.Top, rc, d, True);
        end;
        //if d <> Nil then
          //dsurface.Draw (78, 91+DBottom.Top, d.ClientRect, d, FALSE);
      end;
 *)

      //等级
      d := g_UIBImages.Images[20];
      if d <> nil then
        dsurface.Draw(SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 321)), 150
          + DBottom.Top, d.ClientRect, d, FALSE);

      with dsurface.Canvas do
      begin
        PomiTextOut(dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 -
          260)) {660}, SCREENHEIGHT - 104, IntToStr(g_MySelf.m_Abil.Level));
        SetBkMode(dsurface.Canvas.Handle, TRANSPARENT);
        //g_ArrackMode
        BoldTextOut(dsurface, 635, DBottom.Top + 126, clwhite, clBlack,
          g_ArrackMode);
        //if g_WgClass<>0 then BoldTextOut (dsurface,SCREENWIDTH-135,SCREENHEIGHT-TextHeight('A'),clLime,clBlack,sTest2);
        Str := IntToStr(g_MySelf.m_nGloryPoint);
        BoldTextOut(dsurface, 771 - (TextWidthAndHeight(Handle,Str).cx{TextWidth(Str)} div 2), DBottom.Top + 154,clwhite, clBlack, Str);
        dsurface.Canvas.Release;
      end;
      //
      if (g_MySelf.m_Abil.MaxExp > 0) and (g_MySelf.m_Abil.MaxWeight > 0) then
      begin
        d := g_WMainImages.Images[7];
        if d <> nil then
        begin
          //经验条
          rc := d.ClientRect;
          if g_MySelf.m_Abil.Exp > 0 then
            r := g_MySelf.m_Abil.MaxExp / g_MySelf.m_Abil.Exp
          else
            r := 0;
          if r > 0 then
            rc.Right := Round(rc.Right / r)
          else
            rc.Right := 0;
          {
          dsurface.Draw (666, 527, rc, d, FALSE);
          PomiTextOut (dsurface, 660, 528, IntToStr(Myself.Abil.Exp));
          }
          dsurface.Draw(SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 266))
            {666}, SCREENHEIGHT - 73, rc, d, FALSE);
          //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 260)){660}, SCREENHEIGHT - 72, FloatToStrFixFmt (100 * g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp, 3, 2) + '%');
          //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 260)){660}, SCREENHEIGHT - 57, IntToStr(g_MySelf.m_Abil.MaxExp));

          //背包重量条

          rc := d.ClientRect;
          if g_MySelf.m_Abil.Weight > 0 then
            r := g_MySelf.m_Abil.MaxWeight / g_MySelf.m_Abil.Weight
          else
            r := 0;
          if r > 0 then
            rc.Right := Round(rc.Right / r)
          else
            rc.Right := 0;
          {
          dsurface.Draw (666, 560, rc, d, FALSE);
          PomiTextOut (dsurface, 660, 561, IntToStr(Myself.Abil.Weight));
          }
          dsurface.Draw(SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 266))
            {666}, SCREENHEIGHT - 40, rc, d, FALSE);
          //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 260)){660}, SCREENHEIGHT - 39, IntToStr(g_MySelf.m_Abil.Weight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWeight));
          //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 260)){660}, SCREENHEIGHT - 24, IntToStr(g_MySelf.m_Abil.MaxWeight));
        end;
      end;
      //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 355)){755}, SCREENHEIGHT - 15, IntToStr(g_nMyHungryState));
      //饥饿程度
    {  if g_nMyHungryState in [1..4] then begin
        d := g_WMainImages.Images[16 + g_nMyHungryState-1];
        if d <> nil then begin
          dsurface.Draw (SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 354)), 553, d.ClientRect, d, TRUE);
        end;

      end;   }

    end;

    //显示聊天框文字
    sx := 208;
    sy := SCREENHEIGHT - 130;
    with DScreen do
    begin
      SetBkMode(dsurface.Canvas.Handle, OPAQUE);
      for i := ChatBoardTop to ChatBoardTop + VIEWCHATLINE - 1 do
      begin
        if i > ChatStrs.Count - 1 then
          break;
        fcolor := integer(ChatStrs.Objects[i]);
        bcolor := integer(ChatBks[i]);
        dsurface.Canvas.Font.Color := fcolor;
        dsurface.Canvas.Brush.Color := bcolor;
        dsurface.Canvas.TextOut(sx, sy + (i - ChatBoardTop) * 12,
          ChatStrs.Strings[i]);
      end;
      i := 0;
      while (ChatADStrs.Count > I) and (I < 2) do
      begin
        if GetTickCount < LongWord(ChatADBks.Objects[I]) then
        begin
          dsurface.Canvas.Brush.Color := clBlack;
          rc.Left := sx;
          rc.Top := sy + i * 12;
          rc.Right := sx + BOXWIDTH + 12;
          rc.Bottom := sy + (i + 1) * 12;
          dsurface.Canvas.FillRect(rc);
          fcolor := integer(ChatADStrs.Objects[i]);
          bcolor := StrToInt(ChatADBks.Strings[I]);
          dsurface.Canvas.Font.Color := fcolor;
          dsurface.Canvas.Brush.Color := bcolor;
          dsurface.Canvas.TextOut(sx, sy + i * 12, ChatADStrs.Strings[i]);
          inc(I);
        end
        else
        begin
          ChatADStrs.Delete(I);
          ChatADBks.Delete(I);
        end;
      end;
    end;
    dsurface.Canvas.Release;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBottomDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

{--------------------------------------------------------------}
//官蹿 惑怕官狼 4俺 滚瓢

procedure TFrmDlg.DBottomInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
{$IF SWH = SWH800}
    d := g_WMain3Images.Images[BOTTOMBOARD800];
{$ELSEIF SWH = SWH1024}
    d := g_WMain3Images.Images[BOTTOMBOARD1024];
{$IFEND}
    if d <> nil then
    begin
      if d.Pixels[X, Y] > 0 then
        IsRealArea := TRUE
      else
        IsRealArea := FALSE;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBottomInRealArea'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMyStateDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDButton;
  dd: TDirectDrawSurface;
begin
  try //程序自动增加
    if Sender is TDButton then
    begin
      d := TDButton(Sender);
      if d.Downed then
      begin
        dd := d.WLib.Images[d.FaceIndex];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMyStateDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

//弊缝, 背券, 甘 滚瓢

procedure TFrmDlg.DBotGroupDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDButton;
  dd: TDirectDrawSurface;
begin
  try //程序自动增加
    if Sender is TDButton then
    begin
      d := TDButton(Sender);
      if not d.Downed then
      begin
        dd := d.WLib.Images[d.FaceIndex];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
      end
      else
      begin
        dd := d.WLib.Images[d.FaceIndex + 1];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotGroupDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotGroupMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    DGrpAllowGroupClick(Self, 0, 0)
  else
    ToggleShowGroupDlg;
end;

procedure TFrmDlg.DBotPlusAbilDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDButton;
  dd: TDirectDrawSurface;
begin
  try //程序自动增加
    if Sender is TDButton then
    begin
      d := TDButton(Sender);
      if not d.Downed then
      begin
        if (BlinkCount mod 2 = 0) and (not DAdjustAbility.Visible) then
          dd := d.WLib.Images[d.FaceIndex]
        else
          dd := d.WLib.Images[d.FaceIndex + 2];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
      end
      else
      begin
        dd := d.WLib.Images[d.FaceIndex + 1];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
      end;

      if GetTickCount - BlinkTime >= 500 then
      begin
        BlinkTime := GetTickCount;
        Inc(BlinkCount);
        if BlinkCount >= 10 then
          BlinkCount := 0;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotPlusAbilDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMyStateClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if Sender = DMyState then
    begin
      StatePage2 := 0;
      OpenMyStatus;
    end;
    if Sender = DMyBag then
      OpenItemBag;
    if Sender = DMyMagic then
    begin
      StatePage2 := 3;
      OpenMyStatus;
    end;
    if Sender = DOption then
      DOptionClick;

{   if StatePage2=1 then
    DLiquorProgress.Visible:=True
   else
    DLiquorProgress.Visible:=False;
    DButton3.Visible:=False; }
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMyStateClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DOptionClick();
begin
  try //程序自动增加
    g_boSound := not g_boSound;
    if g_boSound then
    begin
      DScreen.AddChatBoardString('[音效 开]', clWhite, clBlack);
    end
    else
    begin
      DScreen.AddChatBoardString('[音效 关]', clWhite, clBlack);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DOptionClick'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------------------}

// 骇飘

{------------------------------------------------------------------------}

procedure TFrmDlg.DBelt1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  idx,n: integer;
  sText:string;
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    with Sender as TDButton do
    begin
      idx := Tag;
      if idx in [0..5] then
      begin
        if g_ItemArr[idx].S.Name <> '' then
        begin
          d := FrmMain.GetWBagItemImg(g_ItemArr[idx].S.Looks);
          if d <> nil then
          begin
            dsurface.Draw(SurfaceX(Left + (Width - d.Width) div 2), SurfaceY(Top
              + (Height - d.Height) div 2), d.ClientRect, d, TRUE);
            if (g_ItemArr[idx].Dura>1) and (g_ItemArr[idx].S.StdMode=0) then
             begin
               sText:=IntToStr(g_ItemArr[idx].Dura);
               n := TextWidthAndHeight(dsurface.Canvas.Handle,sText).cx;//dsurface.Canvas.TextWidth(sText);
               SetBkMode(dsurface.Canvas.Handle,TRANSPARENT);
               dsurface.Canvas.Font.Color := clWhite;
               dsurface.Canvas.Font.Style:=[fsBold];
               dsurface.Canvas.TextOut(SurfaceX(Left + d.Width-n),SurfaceY(Top),sText);
               dsurface.Canvas.Font.Style:=dsurface.Canvas.Font.Style-[fsBold];
               dsurface.Canvas.Release;
           end;
          end;
        end;
      end;
      PomiTextOut(dsurface, SurfaceX(Left + 13), SurfaceY(Top + 19), IntToStr(idx
        + 1));
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBelt1DirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBelt1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  idx: integer;
begin
  try //程序自动增加
    idx := TDButton(Sender).Tag;
    if idx in [0..5] then
    begin
      if g_ItemArr[idx].S.Name <> '' then
      begin
        g_MouseItem := g_ItemArr[idx];
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBelt1MouseMove'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBMateriaClick(Sender: TObject; X, Y: Integer);
var
  idx: integer;
  temp: TClientItem;
begin
    idx := TDButton(Sender).Tag;
    if idx in [0..6] then
    begin
      if not g_boItemMoving then
      begin
       case g_MakeWineidx of
       0:
        begin
          if g_WineItem[idx].S.Name <> '' then
           begin
             ItemClickSound(g_WineItem[idx].S);
             g_boItemMoving := TRUE;
             g_MovingItem.Index := idx;
             g_MovingItem.Item := g_WineItem[idx];
             g_MovingItem.Hero := False;
             g_WineItem[idx].S.Name := '';
           end;
        end;
       1:
        begin
          if g_WineItem1[idx].S.Name <> '' then
           begin
             ItemClickSound(g_WineItem1[idx].S);
             g_boItemMoving := TRUE;
             g_MovingItem.Index := idx;
             g_MovingItem.Item := g_WineItem1[idx];
             g_MovingItem.Hero := False;
             g_WineItem1[idx].S.Name := '';
           end;
        end;
       end;
      end
      else
      begin
        if g_MovingItem.Hero then
          exit;
        if  not CheckItemStdMode(Sender,g_MovingItem.Item.S.StdMode) then
          exit;//检查物品是不是酿酒台所需的物品  
       case g_MakeWineidx of
       0:
        begin
          if g_WineItem[idx].S.Name <> '' then
          begin
            temp := g_WineItem[idx];
            g_WineItem[idx] := g_MovingItem.Item;
            g_MovingItem.Index := idx;
            g_MovingItem.Item := temp;
            g_MovingItem.Hero := False;
          end
          else
          begin
            g_WineItem[idx] := g_MovingItem.Item;
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
          end;
        end;
       1:
        begin
          if g_WineItem1[idx].S.Name <> '' then
          begin
            temp := g_WineItem1[idx];
            g_WineItem1[idx] := g_MovingItem.Item;
            g_MovingItem.Index := idx;
            g_MovingItem.Item := temp;
            g_MovingItem.Hero := False;
          end
          else
          begin
            g_WineItem1[idx] := g_MovingItem.Item;
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
          end;
        end;
       end;
      end;
    end;
end;

procedure TFrmDlg.DBMateriaDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  idx,n: integer;
  sText:string;
  d: TDirectDrawSurface;
begin
if g_DBMakeWineidx<>1 then
begin
    with Sender as TDButton do
    begin
      idx := Tag;
      if idx in [0..6] then
      begin
        case g_MakeWineidx of
         0:
          begin
            if g_WineItem[idx].S.Name <> '' then
            begin
              d := FrmMain.GetWBagItemImg(g_WineItem[idx].S.Looks);
             if d <> nil then
              begin
                dsurface.Draw(SurfaceX(Left + (Width - d.Width) div 2),
                  SurfaceY(Top+ (Height - d.Height) div 2), d.ClientRect, d, TRUE);
               end;
             end;
          end;
         1:
          begin
            if g_WineItem1[idx].S.Name <> '' then
            begin
              d := FrmMain.GetWBagItemImg(g_WineItem1[idx].S.Looks);
             if d <> nil then
              begin
                dsurface.Draw(SurfaceX(Left + (Width - d.Width) div 2),
                  SurfaceY(Top+ (Height - d.Height) div 2), d.ClientRect, d, TRUE);
               end;
             end;
          end;
        end;
      end;
    end;
end;
end;

procedure TFrmDlg.DBMateriaMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
//  nLocalX, nLocalY: Integer;
//  nHintX, nHintY: Integer;
  Butt: TDButton;
begin
   Butt := TDButton(Sender);
  {  nLocalX := Butt.LocalX(X - Butt.Left);
    nLocalY := Butt.LocalY(Y - Butt.Top);
    nHintX := Butt.SurfaceX(Butt.Left) + DBottom.SurfaceX(DBottom.Left) +
      nLocalX;
    nHintY := Butt.SurfaceY(Butt.Top) + DBottom.SurfaceY(DBottom.Top) + nLocalY;
     }
    with Sender as TDButton do
      DScreen.ShowHint(SurfaceX(Left), SurfaceY(Top - 15), Butt.Caption, clWhite,
        False);
end;

procedure TFrmDlg.DBelt1Click(Sender: TObject; X, Y: Integer);
var
  idx: integer;
  temp: TClientItem;
begin
  try //程序自动增加
    idx := TDButton(Sender).Tag;
    if idx in [0..5] then
    begin
      if not g_boItemMoving then
      begin
        if g_ItemArr[idx].S.Name <> '' then
        begin
          ItemClickSound(g_ItemArr[idx].S);
          g_boItemMoving := TRUE;
          g_MovingItem.Index := idx;
          g_MovingItem.Item := g_ItemArr[idx];
          g_MovingItem.Hero := False;
          g_ItemArr[idx].S.Name := '';
        end;
      end
      else
      begin
        if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then
          exit;
        if g_MovingItem.Hero then
          exit;
        if (g_MovingItem.Item.S.StdMode <= 3) then
        begin //器记,澜侥,胶农费
          //ItemClickSound (MovingItem.Item.S.StdMode);
          if g_ItemArr[idx].S.Name <> '' then
          begin
            temp := g_ItemArr[idx];
            g_ItemArr[idx] := g_MovingItem.Item;
            g_MovingItem.Index := idx;
            g_MovingItem.Item := temp;
            g_MovingItem.Hero := False;
          end
          else
          begin
            g_ItemArr[idx] := g_MovingItem.Item;
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
          end;
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBelt1Click'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBelt1DblClick(Sender: TObject);
var
  ii, idx: integer;
  sName: string;
  cu:TClientItem;
begin
  try //程序自动增加
    idx := TDButton(Sender).Tag;
    if idx in [0..5] then
    begin
      if g_ItemArr[idx].S.Name <> '' then
      begin
        if (g_ItemArr[idx].S.StdMode <= 4) or (g_ItemArr[idx].S.StdMode = 31)
          then
        begin //荤侩且 荐 乐绰 酒捞袍
          sname := g_ItemArr[idx].S.Name;
          FrmMain.EatItem(idx);
          if (g_ItemArr[idx].Dura<=1) and (g_ItemArr[idx].S.StdMode=0) then
          begin
          II := GetItembyName(sName);
          if (II = -1) or (ii in [0..5]) then
            pAutoOpenItem(sName);
          end;
        end;
      end
      else
      begin
        if g_boItemMoving and (g_MovingItem.Index = idx) and
          (g_MovingItem.Item.S.StdMode <= 4) or (g_MovingItem.Item.S.StdMode =
          31) then
        begin
          sname := g_MovingItem.Item.S.Name;
         { if (g_MovingItem.Item.Dura>1) and (g_MovingItem.Item.S.StdMode=0) then
            begin
              Dec(g_MovingItem.Item.Dura);
              cu:=g_MovingItem.Item;
              FrmMain.EatItem(-1);
              g_ItemArr[idx]:=cu;
              Exit;
            end else }
              FrmMain.EatItem(-1);
             II := GetItembyName(sName);
             if (II = -1) or (ii in [0..5]) then
            pAutoOpenItem(sName);
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBelt1DblClick'); //程序自动增加
  end; //程序自动增加
end;

{----------------------------------------------------------}

//酒捞袍 啊规

{----------------------------------------------------------}

procedure TFrmDlg.GetMouseItemInfo(var iname, line1, line2, line3,line31: string; var
  useable: boolean; boHero: Boolean = False);
  function GetDuraStr(dura, maxdura: integer): string;
  begin
    if not BoNoDisplayMaxDura then
      Result := IntToStr(Round(dura / 1000)) + '/' + IntToStr(Round(maxdura /
        1000))
    else
      Result := IntToStr(Round(dura / 1000));
  end;
  function GetDura100Str(dura, maxdura: integer): string;
  begin
    if not BoNoDisplayMaxDura then
      Result := IntToStr(Round(dura / 100)) + '/' + IntToStr(Round(maxdura /
        100))
    else
      Result := IntToStr(Round(dura / 100));
  end;
var
  sWgt: string;
  //MySelf :THumActor;
  NewStdItem: TNewStdItem;
  MyAbil: TAbility;
  MySex: Byte;
  MyJob: Byte;
  I: integer;
begin
  try //程序自动增加
    if boHero then
    begin //MySelf:=g_MyHero
      MyAbil := g_HeroAbil;
      MySex := g_HerobtSex;
      MyJob := g_HerobtJob;
    end
    else
    begin
      MyAbil := g_MySelf.m_Abil;
      MySex := g_MySelf.m_btSex;
      MyJob := g_MySelf.m_btJob;
    end; //MySelf:=g_MySelf;
    if g_MySelf = nil then
      exit;
    iname := '';
    line1 := '';
    line2 := '';
    line3 := '';
    useable := TRUE;

    if g_MouseItem.S.Name <> '' then
    begin
      iname := g_MouseItem.S.Name + ' ';
      sWgt := '重量';
      case g_MouseItem.S.StdMode of
        255:
          begin
            line2 := '数量 ' + GetGoldStr(g_MouseItem.S.DuraMax);
          end;
        0:
          begin //药品
            if g_MouseItem.S.AC > 0 then
              line1 := '+' + IntToStr(g_MouseItem.S.AC) + 'HP ';
            if g_MouseItem.S.MAC > 0 then
              line1 := line1 + '+' + IntToStr(g_MouseItem.S.MAC) + 'MP';
            line1 := line1 + ' 重量' + IntToStr(g_MouseItem.S.Weight);
          end;
        1..3:
          begin
            line1 := line1 + ' 重量' + IntToStr(g_MouseItem.S.Weight);
            if g_MouseItem.S.StdMode = 2 then
            begin
              if g_MouseItem.S.Shape = 9 then
              begin
                line2 := '修复装备持久 ' + IntToStr(Round(g_MouseItem.dura
                  / 100)) + ' 点'
              end
              else if g_MouseItem.S.Shape = 99 then
              begin
                Move(g_MouseItem.S, NewStdItem, SizeOf(NewStdItem));
                if NewStdItem.sMapName <> '' then
                begin
                  line2 := Format('地图[%s]  坐标[%d,%d]',
                    [NewStdItem.sMapName, g_MouseItem.Dura,
                      g_MouseItem.DuraMax]);
                  line3 := '双击使用';
                end
                else
                begin
                  line2 := '尚未绑定';
                  line3 := '双击绑定';
                end;
              end
              else  if (g_MouseItem.S.Shape = 1) and (g_MouseItem.S.reserved=56) then
              begin
                line2 := '容量 ' + GetDura100Str(g_MouseItem.Dura,
                  g_MouseItem.DuraMax);
              end else
              begin
                 line2 := '使用 ' + GetDuraStr(g_MouseItem.Dura,
                  g_MouseItem.DuraMax) + ' 次';
              end;
            end;
          end;
        4:
          begin
            line1 := line1 + ' 重量' + IntToStr(g_MouseItem.S.Weight);
            line3 := '需要等级' + IntToStr(g_MouseItem.S.DuraMax);
            useable := FALSE;
            case g_MouseItem.S.Shape of
              0:
                begin
                  line2 := '武士秘籍';
                  if (MyJob = 0) and (MyAbil.Level >= g_MouseItem.S.DuraMax)
                    then
                    useable := TRUE;
                end;
              1:
                begin
                  line2 := '法师秘籍';
                  if (MyJob = 1) and (MyAbil.Level >= g_MouseItem.S.DuraMax)
                    then
                    useable := TRUE;
                end;
              2:
                begin
                  line2 := '道士秘籍';
                  if (MyJob = 2) and (MyAbil.Level >= g_MouseItem.S.DuraMax)
                    then
                    useable := TRUE;
                end;
              3:
                begin
                  line2 := '合击秘籍';
                  if (boHero) and (MyAbil.Level >= g_MouseItem.S.DuraMax) then
                    useable := TRUE;
                end;
            end;
          end;
        5..6: //武器
          begin
            useable := FALSE;
            if g_MouseItem.S.Reserved and $01 <> 0 then
              iname := '(*)' + iname;
            if g_MouseItem.S.AniCount > 0 then
             // iname := iname + '+' + IntToStr(g_MouseItem.S.AniCount) + ' ';
             line1 := line1 +'等级'+IntToStr(g_MouseItem.S.AniCount) + ' ';
             line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight) +
              ' 持久' + GetDuraStr(g_MouseItem.Dura, g_MouseItem.DuraMax);
            if g_MouseItem.S.DC > 0 then
              line2 := '攻击' + IntToStr(LoWord(g_MouseItem.S.DC)) + '-' +
                IntToStr(HiWord(g_MouseItem.S.DC));
            if g_MouseItem.S.MC > 0 then
              line2 := line2 + '魔法' + IntToStr(LoWord(g_MouseItem.S.MC)) +
                '-' + IntToStr(HiWord(g_MouseItem.S.MC));
            if g_MouseItem.S.SC > 0 then
              line2 := line2 + '道术' + IntToStr(LoWord(g_MouseItem.S.SC)) +
                '-' + IntToStr(HiWord(g_MouseItem.S.SC)) + ' ';

            if (g_MouseItem.S.Source <= -1) and (g_MouseItem.S.Source >= -50)
              then
              line2 := line2 + '神圣+' + IntToStr(-g_MouseItem.S.Source) +
                ' ';
            if (g_MouseItem.S.Source <= -51) and (g_MouseItem.S.Source >= -100)
              then
              line2 := line2 + '神圣-' + IntToStr(-g_MouseItem.S.Source - 50)
                + ' ';

            if HiWord(g_MouseItem.S.AC) > 0 then
              line3 := line3 + '准确+' + IntToStr(HiWord(g_MouseItem.S.AC))+ ' ';
            if HiWord(g_MouseItem.S.MAC) > 0 then
            begin
              if HiWord(g_MouseItem.S.MAC) > 10 then
                line3 := line3 + '攻击速度+' +
                  IntToStr(HiWord(g_MouseItem.S.MAC) - 10) + ' '
              else
                line3 := line3 + '攻击速度-' +
                  IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
            end;
            if LoWord(g_MouseItem.S.AC) > 0 then
              line3 := line3 + '幸运+' + IntToStr(LoWord(g_MouseItem.S.AC))+ ' ';
            if LoWord(g_MouseItem.S.MAC) > 0 then
              line3 := line3 + '诅咒+' + IntToStr(LoWord(g_MouseItem.S.MAC))+ ' ';
            case g_MouseItem.S.Need of
              0:
                begin
                  if MyAbil.Level >= g_MouseItem.S.NeedLevel then
                    useable := TRUE;
                  line3 := line3 + '需要等级' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              10:
                begin
                  if (MyJob = LoWord(g_MouseItem.S.NeedLevel)) and (MyAbil.Level
                    >= HiWord(g_MouseItem.S.NeedLevel)) then
                    useable := TRUE;
                  line3 := line3 + '需要' +
                    GetJobName(LoWord(g_MouseItem.S.NeedLevel)) + '&等级' +
                    IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
              11:
                begin
                  if (MyJob = LoWord(g_MouseItem.S.NeedLevel)) and (MyAbil.DC >=
                    HiWord(g_MouseItem.S.NeedLevel)) then
                    useable := TRUE;
                  line3 := line3 + '需要' +
                    GetJobName(LoWord(g_MouseItem.S.NeedLevel)) + '&攻击力' +
                    IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
              12:
                begin
                  if (MyJob = LoWord(g_MouseItem.S.NeedLevel)) and (MyAbil.SC >=
                    HiWord(g_MouseItem.S.NeedLevel)) then
                    useable := TRUE;
                  line3 := line3 + '需要' +
                    GetJobName(LoWord(g_MouseItem.S.NeedLevel)) + '&魔法力' +
                    IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
              13:
                begin
                  if (MyJob = LoWord(g_MouseItem.S.NeedLevel)) and (MyAbil.MC >=
                    HiWord(g_MouseItem.S.NeedLevel)) then
                    useable := TRUE;
                  line3 := line3 + '需要' +
                    GetJobName(LoWord(g_MouseItem.S.NeedLevel)) + '&精神力' +
                    IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
              1:
                begin
                  if HiWord(MyAbil.DC) >= g_MouseItem.S.NeedLevel then
                    useable := TRUE;
                  line3 := line3 + '需要攻击力' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              2:
                begin
                  if HiWord(MyAbil.MC) >= g_MouseItem.S.NeedLevel then
                    useable := TRUE;
                  line3 := line3 + '需要魔法力' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              3:
                begin
                  if HiWord(MyAbil.SC) >= g_MouseItem.S.NeedLevel then
                    useable := TRUE;
                  line3 := line3 + '需要精神力' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              4:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生等级' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              40:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生&等级' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              41:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生&攻击力' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              42:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生&魔法力' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              43:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生&道术' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              44:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生&声望点' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              5:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要声望点' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              6:
                begin
                  useable := TRUE;
                  line3 := line3 + '行会成员专用';
                end;
              60:
                begin
                  useable := TRUE;
                  line3 := line3 + '行会掌门专用';
                end;
              7:
                begin
                  useable := TRUE;
                  line3 := line3 + '沙城成员专用';
                end;
              70:
                begin
                  useable := TRUE;
                  line3 := line3 + '沙城城主专用';
                end;
              8:
                begin
                  useable := TRUE;
                  line3 := line3 + '会员专用';
                end;
              81:
                begin
                  useable := TRUE;
                  line3 := line3 + '会员类型 =' +
                    IntToStr(LoWord(g_MouseItem.S.NeedLevel)) +
                      ' 会员等级 >='
                    + IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
              82:
                begin
                  useable := TRUE;
                  line3 := line3 + '会员类型 >=' +
                    IntToStr(LoWord(g_MouseItem.S.NeedLevel)) +
                      ' 会员等级 >='
                    + IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
            end;
          end;
        7:
          begin //气血石等
            line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight);
            case g_MouseItem.S.Shape of
              0: line2 := '使用 ' + GetDuraStr(g_MouseItem.Dura,
                  g_MouseItem.DuraMax) + ' 次';
              1: line2 := 'HP ' + GetDuraStr(g_MouseItem.Dura,
                  g_MouseItem.DuraMax) + ' 万';
              2: line2 := 'MP ' + GetDuraStr(g_MouseItem.Dura,
                  g_MouseItem.DuraMax) + ' 万';
              3: line2 := 'HPMP ' + GetDuraStr(g_MouseItem.Dura,
                  g_MouseItem.DuraMax) + ' 万';
            end;
          end;
        8:
          begin //酿酒材料
           if g_MouseItem.S.Source=0 then
            line1 := line1 + '品质1'
           else
            line1 := line1 + '品质'+inttostr(g_MouseItem.S.AC)
          end;
        10, 11: //男衣服, 女衣服
          begin
            useable := FALSE;
            if g_MouseItem.S.Reserved > 0 then
             // iname := iname + '+' + IntToStr(g_MouseItem.S.Reserved) + ' ';
            line1 := line1 +'等级'+IntToStr(g_MouseItem.S.Reserved) + ' ';
            line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight)+
            ' 持久' + GetDuraStr(g_MouseItem.Dura, g_MouseItem.DuraMax)+' ';
            //line1 := line1 + '重量' + IntToStr(MouseItem.S.Weight) +
            //      ' 持久'+ IntToStr(Round(MouseItem.Dura/1000)) + '/' + IntToStr(Round(MouseItem.DuraMax/1000));
            if g_MouseItem.S.AC > 0 then
              line2 := '防御' + IntToStr(LoWord(g_MouseItem.S.AC)) + '-' +
                IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
            if g_MouseItem.S.MAC > 0 then
              line2 := line2 + '魔御' + IntToStr(LoWord(g_MouseItem.S.MAC)) +
                '-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
            if g_MouseItem.S.DC > 0 then
              line2 := line2 + '攻击' + IntToStr(LoWord(g_MouseItem.S.DC)) +
                '-' + IntToStr(HiWord(g_MouseItem.S.DC)) + ' ';
            if g_MouseItem.S.MC > 0 then
              line2 := line2 + '魔法' + IntToStr(LoWord(g_MouseItem.S.MC)) +
                '-' + IntToStr(HiWord(g_MouseItem.S.MC)) + ' ';
            if g_MouseItem.S.SC > 0 then
              line2 := line2 + '道术' + IntToStr(LoWord(g_MouseItem.S.SC)) +
                '-' + IntToStr(HiWord(g_MouseItem.S.SC));

            if LoByte(g_MouseItem.S.Source) > 0 then
              line3 := line3 + '幸运+' + IntToStr(LoByte(g_MouseItem.S.Source))
                + ' ';
            if HiByte(g_MouseItem.S.Source) > 0 then
              line3 := line3 + '诅咒+' + IntToStr(HiByte(g_MouseItem.S.Source))
                + ' ';

            case g_MouseItem.S.Need of
              0:
                begin
                  if MyAbil.Level >= g_MouseItem.S.NeedLevel then
                    useable := TRUE;
                  line3 := line3 + '需要等级' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              10:
                begin
                  if (MyJob = LoWord(g_MouseItem.S.NeedLevel)) and (MyAbil.Level
                    >= HiWord(g_MouseItem.S.NeedLevel)) then
                    useable := TRUE;
                  line3 := line3 + '需要' +
                    GetJobName(LoWord(g_MouseItem.S.NeedLevel)) + '&等级' +
                    IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
              11:
                begin
                  if (MyJob = LoWord(g_MouseItem.S.NeedLevel)) and (MyAbil.DC >=
                    HiWord(g_MouseItem.S.NeedLevel)) then
                    useable := TRUE;
                  line3 := line3 + '需要' +
                    GetJobName(LoWord(g_MouseItem.S.NeedLevel)) + '&攻击力' +
                    IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
              12:
                begin
                  if (MyJob = LoWord(g_MouseItem.S.NeedLevel)) and (MyAbil.SC >=
                    HiWord(g_MouseItem.S.NeedLevel)) then
                    useable := TRUE;
                  line3 := line3 + '需要' +
                    GetJobName(LoWord(g_MouseItem.S.NeedLevel)) + '&魔法力' +
                    IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
              13:
                begin
                  if (MyJob = LoWord(g_MouseItem.S.NeedLevel)) and (MyAbil.MC >=
                    HiWord(g_MouseItem.S.NeedLevel)) then
                    useable := TRUE;
                  line3 := line3 + '需要' +
                    GetJobName(LoWord(g_MouseItem.S.NeedLevel)) + '&精神力' +
                    IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
              1:
                begin
                  if HiWord(MyAbil.DC) >= g_MouseItem.S.NeedLevel then
                    useable := TRUE;
                  line3 := line3 + '需要攻击力' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              2:
                begin
                  if HiWord(MyAbil.MC) >= g_MouseItem.S.NeedLevel then
                    useable := TRUE;
                  line3 := line3 + '需要魔法力' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              3:
                begin
                  if HiWord(MyAbil.SC) >= g_MouseItem.S.NeedLevel then
                    useable := TRUE;
                  line3 := line3 + '需要精神力' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              4:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生等级' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              40:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生&等级' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              41:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生&攻击力' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              42:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生&魔法力' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              43:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生&道术' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              44:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生&声望点' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              5:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要声望点' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              6:
                begin
                  useable := TRUE;
                  line3 := line3 + '行会成员专用';
                end;
              60:
                begin
                  useable := TRUE;
                  line3 := line3 + '行会掌门专用';
                end;
              7:
                begin
                  useable := TRUE;
                  line3 := line3 + '沙城成员专用';
                end;
              70:
                begin
                  useable := TRUE;
                  line3 := line3 + '沙城城主专用';
                end;
              8:
                begin
                  useable := TRUE;
                  line3 := line3 + '会员专用';
                end;
              81:
                begin
                  useable := TRUE;
                  line3 := line3 + '会员类型 =' +
                    IntToStr(LoWord(g_MouseItem.S.NeedLevel)) +
                      ' 会员等级 >='
                    + IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
              82:
                begin
                  useable := TRUE;
                  line3 := line3 + '会员类型 >=' +
                    IntToStr(LoWord(g_MouseItem.S.NeedLevel)) +
                      ' 会员等级 >='
                    + IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
            end;
          end;
        12:
        begin
            line1 := line1 + '重量' + IntToStr(g_MouseItem.S.Weight);
            line2 :=g_MouseItem.Desc;
        end;
        15, 16, //头盔,捧备
        19, 20, 21, //项链
        22, 23, //戒指
        24, 26, //手镯
        51, 30,
          52, 62, 27, //鞋
        53, 63, 28,
          54, 64, 29: //腰带
          begin
            useable := FALSE;
            if g_MouseItem.S.Reserved > 0 then
             // iname := iname + '+' + IntToStr(g_MouseItem.S.Reserved) + ' ';
            line1 := line1 +'等级'+IntToStr(g_MouseItem.S.Reserved) + ' ';
            line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight)+
            ' 持久' + GetDuraStr(g_MouseItem.Dura, g_MouseItem.DuraMax)+' ';
            case g_MouseItem.S.StdMode of
              19: //项链
                begin
                  if g_MouseItem.S.AC > 0 then
                    line2 := line2 + '魔法躲避+' +
                      IntToStr(HiWord(g_MouseItem.S.AC)) + '0% ';
                  if LoWord(g_MouseItem.S.MAC) > 0 then
                    line2 := line2 + '诅咒+' +
                      IntToStr(LoWord(g_MouseItem.S.MAC)) + ' ';
                  if HiWord(g_MouseItem.S.MAC) > 0 then
                    line2 := line2 + '幸运+' +
                      IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                  //箭磊 钎矫救凳 + IntToStr(Hibyte(MouseItem.S.MAC)) + ' ';
                end;
              20, 24: //项链 及 手镯: MaxAC -> Hit,  MaxMac -> Speed
                begin
                  if g_MouseItem.S.AC > 0 then
                    line2 := line2 + '准确+' +
                      IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                  if g_MouseItem.S.MAC > 0 then
                    line2 := line2 + '敏捷+' +
                      IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                end;
              21: //项链
                begin
                  if HiWord(g_MouseItem.S.AC) > 0 then
                    line2 := line2 + '体力恢复+' +
                      IntToStr(HiWord(g_MouseItem.S.AC)) + '0% ';
                  if HiWord(g_MouseItem.S.MAC) > 0 then
                    line2 := line2 + '魔法恢复+' +
                      IntToStr(HiWord(g_MouseItem.S.MAC)) + '0% ';
                  if LoWord(g_MouseItem.S.AC) > 0 then
                    line2 := line2 + '攻击速度+' +
                      IntToStr(LoWord(g_MouseItem.S.AC)) + ' ';
                  if LoWord(g_MouseItem.S.MAC) > 0 then
                    line2 := line2 + '攻击速度-' +
                      IntToStr(LoWord(g_MouseItem.S.MAC)) + ' ';
                end;
              23: //戒指
                begin
                  if HiWord(g_MouseItem.S.AC) > 0 then
                    line2 := line2 + '毒物躲避+' +
                      IntToStr(HiWord(g_MouseItem.S.AC)) + '0% ';
                  if HiWord(g_MouseItem.S.MAC) > 0 then
                    line2 := line2 + '中毒恢复+' +
                      IntToStr(HiWord(g_MouseItem.S.MAC)) + '0% ';
                  if LoWord(g_MouseItem.S.AC) > 0 then
                    line2 := line2 + '攻击速度+' +
                      IntToStr(LoWord(g_MouseItem.S.AC)) + ' ';
                  if LoWord(g_MouseItem.S.MAC) > 0 then
                    line2 := line2 + '攻击速度-' +
                      IntToStr(LoWord(g_MouseItem.S.MAC)) + ' ';
                end;
              // 62,28:  //Boots
                  //begin

                    { if HiWord(g_MouseItem.S.AC) > 0 then
                        line2 := line2 + 'Hands WL+' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                     if HiWord(g_MouseItem.S.MAC) > 0 then
                        line2 := line2 + 'Body WL+' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                     if LoWord(g_MouseItem.S.MAC) > 0 then
                        line2 := line2 + 'Bag WL+' + IntToStr(LoWord(g_MouseItem.S.MAC)) + ' '; }
                  //end;
               {63: //Charm
                  begin
                     if LoWord(g_MouseItem.S.AC) > 0 then line2 := line2 + 'HP+' + IntToStr(LoWord(g_MouseItem.S.AC)) + ' ';
                     if HiWord(g_MouseItem.S.AC) > 0 then line2 := line2 + 'MP+' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                     if LoWord(g_MouseItem.S.MAC) > 0 then line2 := line2 + 'Curse+' + IntToStr(LoWord(g_MouseItem.S.MAC)) + ' ';
                     if HiWord(g_MouseItem.S.MAC) > 0 then line2 := line2 + 'Luck+' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                  end;  }
            else
              begin //52,62,28
                if g_MouseItem.S.AC > 0 then
                  line2 := line2 + '防御' + IntToStr(LoWord(g_MouseItem.S.AC))
                    + '-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                if g_MouseItem.S.MAC > 0 then
                  line2 := line2 + '魔御' + IntToStr(LoWord(g_MouseItem.S.MAC))
                    + '-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                if (g_MouseItem.S.StdMode in [52, 62, 28]) and
                  (g_MouseItem.S.AniCount > 0) then
                  line2 := line2 + '负重+' + IntToStr(g_MouseItem.S.AniCount)
                    +
                    ' ';
              end;
            end;
            if g_MouseItem.S.DC > 0 then
              line2 := line2 + '攻击' + IntToStr(LoWord(g_MouseItem.S.DC)) +
                '-' + IntToStr(HiWord(g_MouseItem.S.DC)) + ' ';
            if g_MouseItem.S.MC > 0 then
              line2 := line2 + '魔法' + IntToStr(LoWord(g_MouseItem.S.MC)) +
                '-' + IntToStr(HiWord(g_MouseItem.S.MC)) + ' ';
            if g_MouseItem.S.SC > 0 then
              line2 := line2 + '道术' + IntToStr(LoWord(g_MouseItem.S.SC)) +
                '-' + IntToStr(HiWord(g_MouseItem.S.SC)) + ' ';

            if (g_MouseItem.S.Source <= -1) and (g_MouseItem.S.Source >= -50)
              then
              line2 := line2 + '神圣+' + IntToStr(-g_MouseItem.S.Source);
            if (g_MouseItem.S.Source <= -51) and (g_MouseItem.S.Source >= -100)
              then
              line2 := line2 + '神圣-' + IntToStr(-g_MouseItem.S.Source - 50);

            case g_MouseItem.S.Need of
              0:
                begin
                  if MyAbil.Level >= g_MouseItem.S.NeedLevel then
                    useable := TRUE;
                  line3 := line3 + '需要等级' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              10:
                begin
                  if (MyJob = LoWord(g_MouseItem.S.NeedLevel)) and (MyAbil.Level
                    >= HiWord(g_MouseItem.S.NeedLevel)) then
                    useable := TRUE;
                  line3 := line3 + '需要' +
                    GetJobName(LoWord(g_MouseItem.S.NeedLevel)) + '&等级' +
                    IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
              11:
                begin
                  if (MyJob = LoWord(g_MouseItem.S.NeedLevel)) and (MyAbil.DC >=
                    HiWord(g_MouseItem.S.NeedLevel)) then
                    useable := TRUE;
                  line3 := line3 + '需要' +
                    GetJobName(LoWord(g_MouseItem.S.NeedLevel)) + '&攻击力' +
                    IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
              12:
                begin
                  if (MyJob = LoWord(g_MouseItem.S.NeedLevel)) and (MyAbil.SC >=
                    HiWord(g_MouseItem.S.NeedLevel)) then
                    useable := TRUE;
                  line3 := line3 + '需要' +
                    GetJobName(LoWord(g_MouseItem.S.NeedLevel)) + '&魔法力' +
                    IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
              13:
                begin
                  if (MyJob = LoWord(g_MouseItem.S.NeedLevel)) and (MyAbil.MC >=
                    HiWord(g_MouseItem.S.NeedLevel)) then
                    useable := TRUE;
                  line3 := line3 + '需要' +
                    GetJobName(LoWord(g_MouseItem.S.NeedLevel)) + '&精神力' +
                    IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
              1:
                begin
                  if HiWord(MyAbil.DC) >= g_MouseItem.S.NeedLevel then
                    useable := TRUE;
                  line3 := line3 + '需要攻击力' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              2:
                begin
                  if HiWord(MyAbil.MC) >= g_MouseItem.S.NeedLevel then
                    useable := TRUE;
                  line3 := line3 + '需要魔法力' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              3:
                begin
                  if HiWord(MyAbil.SC) >= g_MouseItem.S.NeedLevel then
                    useable := TRUE;
                  line3 := line3 + '需要精神力' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              4:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生等级' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              40:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生&等级' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              41:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生&攻击力' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              42:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生&魔法力' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              43:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生&道术' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              44:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要转生&声望点' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              5:
                begin
                  useable := TRUE;
                  line3 := line3 + '需要声望点' +
                    IntToStr(g_MouseItem.S.NeedLevel);
                end;
              6:
                begin
                  useable := TRUE;
                  line3 := line3 + '行会成员专用';
                end;
              60:
                begin
                  useable := TRUE;
                  line3 := line3 + '行会掌门专用';
                end;
              7:
                begin
                  useable := TRUE;
                  line3 := line3 + '沙城成员专用';
                end;
              70:
                begin
                  useable := TRUE;
                  line3 := line3 + '沙城城主专用';
                end;
              8:
                begin
                  useable := TRUE;
                  line3 := line3 + '会员专用';
                end;
              81:
                begin
                  useable := TRUE;
                  line3 := line3 + '会员类型 =' +
                    IntToStr(LoWord(g_MouseItem.S.NeedLevel)) +
                      ' 会员等级 >='
                    + IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
              82:
                begin
                  useable := TRUE;
                  line3 := line3 + '会员类型 >=' +
                    IntToStr(LoWord(g_MouseItem.S.NeedLevel)) +
                      ' 会员等级 >='
                    + IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                end;
            end;
            if g_MouseItem.S.Shape=188 then
           begin
               line31 :=' 伤害吸收' +IntToStr(g_MouseItem.S.Source)+'%';
           end;
          end;
        25: //护身符及毒药
          begin
            line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight);
            case g_MouseItem.S.Shape of
              1, 2, 5:
                begin
                  line2 := '使用 ' + GetDura100Str(g_MouseItem.Dura,
                    g_MouseItem.DuraMax);
                end;
              9:
                begin
                  line2 := '容量 ' + Format('%d/%d', [g_MouseItem.Dura,
                    g_MouseItem.DuraMax]);
                end;
            else
              line2 := '使用 ' + GetDura100Str(g_MouseItem.Dura,
                g_MouseItem.DuraMax);
            end;
          end;
        40: //肉
          begin
            line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight) + ' 品质' +
              GetDuraStr(g_MouseItem.Dura, g_MouseItem.DuraMax);
          end;
        42: //药材
          begin
            line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight) + ' 药材';
          end;
        43: //矿石
          begin
            line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight) + ' 纯度' +
              IntToStr(Round(g_MouseItem.Dura / 1000));
          end;
        48:
          begin
            line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight);
            line3 := '双击打开宝箱';
          end;
        49:
          begin
            line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight);
            line3 := '开启宝箱钥匙，移动到宝箱内既可';
          end;
        55, 58:
          begin
            line1 := line1 + '重量' + IntToStr(g_MouseItem.S.Weight);
            i := GetTakeOnPosition(g_MouseItem.S.Shape);
            if I in [0..13] then
              line1 := line1 + ' 用于[' + LevelUseItem[I] + ']'
            else
              line1 := line1 + ' 用于[所有]';
            if HiWord(g_MouseItem.S.Need) = 0 then
            begin
              line1 := line1 + '等级' + IntToStr(g_MouseItem.S.Need) +
                '以下装备';
            end
            else
            begin
              line1 := line1 + '等级' + IntToStr(HiWord(g_MouseItem.S.Need)) + '~等级'
                + IntToStr(LoWord(g_MouseItem.S.Need)) + '装备';
            end;
            line2 := '';
            if (g_MouseItem.S.StdMode = 55) and (g_MouseItem.S.Source in [1, 2])
              then
            begin
              case g_MouseItem.S.Source of
                1:
                  begin
                    if HiWord(g_MouseItem.S.AC) > 0 then
                      line2 := line2 + '防御+' +
                        IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                    if HiWord(g_MouseItem.S.MAC) > 0 then
                      line2 := line2 + '魔御+' +
                        IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                  end;
                2:
                  begin
                    if HiWord(g_MouseItem.S.DC) > 0 then
                      line2 := line2 + '攻击+' +
                        IntToStr(HiWord(g_MouseItem.S.DC)) + ' ';
                    if HiWord(g_MouseItem.S.MC) > 0 then
                      line2 := line2 + '魔法+' +
                        IntToStr(HiWord(g_MouseItem.S.MC)) + ' ';
                    if HiWord(g_MouseItem.S.SC) > 0 then
                      line2 := line2 + '道术+' +
                        IntToStr(HiWord(g_MouseItem.S.SC)) + ' ';
                  end;
              end;
            end
            else
            begin
              case g_MouseItem.S.Shape of
                5, 6:
                  begin
                    if HiWord(g_MouseItem.S.DC) > 0 then
                      line2 := line2 + '攻击+' +
                        IntToStr(HiWord(g_MouseItem.S.DC)) + ' ';
                    if HiWord(g_MouseItem.S.MC) > 0 then
                      line2 := line2 + '魔法+' +
                        IntToStr(HiWord(g_MouseItem.S.MC)) + ' ';
                    if HiWord(g_MouseItem.S.SC) > 0 then
                      line2 := line2 + '道术+' +
                        IntToStr(HiWord(g_MouseItem.S.SC)) + ' ';
                    if HiWord(g_MouseItem.S.AC) > 0 then
                      line2 := line2 + '准确+' +
                        IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                    if LoWord(g_MouseItem.S.AC) > 0 then
                      line2 := line2 + '幸运+' +
                        IntToStr(LoWord(g_MouseItem.S.AC)) + ' ';
                    if LoWord(g_MouseItem.S.MAC) > 0 then
                      line2 := line2 + '诅咒+' +
                        IntToStr(LoWord(g_MouseItem.S.MAC)) + ' ';
                    if HiWord(g_MouseItem.S.MAC) > 0 then
                    begin
                      if HiWord(g_MouseItem.S.MAC) > 10 then
                        line2 := line2 + '攻击速度+' +
                          IntToStr(HiWord(g_MouseItem.S.MAC) - 10) + ' '
                      else
                        line2 := line2 + '攻击速度-' +
                          IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                    end;
                  end;
                10, 11:
                  begin
                    if HiWord(g_MouseItem.S.AC) > 0 then
                      line2 := line2 + '防御+' +
                        IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                    if HiWord(g_MouseItem.S.MAC) > 0 then
                      line2 := line2 + '魔御+' +
                        IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                    if HiWord(g_MouseItem.S.DC) > 0 then
                      line2 := line2 + '攻击+' +
                        IntToStr(HiWord(g_MouseItem.S.DC)) + ' ';
                    if HiWord(g_MouseItem.S.MC) > 0 then
                      line2 := line2 + '魔法+' +
                        IntToStr(HiWord(g_MouseItem.S.MC)) + ' ';
                    if HiWord(g_MouseItem.S.SC) > 0 then
                      line2 := line2 + '道术+' +
                        IntToStr(HiWord(g_MouseItem.S.SC)) + ' ';
                  end;
                15, 19, 20, 21, 22, 23, 24, 26, 30, 62, 28, 63, 64, 27, 16:
                  begin
                    case g_MouseItem.S.Shape of
                      19:
                        begin
                          if HiWord(g_MouseItem.S.AC) > 0 then
                            line2 := line2 + '魔法躲避+' +
                              IntToStr(HiWord(g_MouseItem.S.AC)) + '% ';
                          //if LoWord(g_MouseItem.S.MAC) > 0 then line2 := line2 + '诅咒+' + IntToStr(LoWord(g_MouseItem.S.MAC)) + ' ';
                          if HiWord(g_MouseItem.S.MAC) > 0 then
                            line2 := line2 + '幸运+' +
                              IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                        end;
                      20, 24:
                        begin
                          if HiWord(g_MouseItem.S.AC) > 0 then
                            line2 := line2 + '准确+' +
                              IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                          if HiWord(g_MouseItem.S.MAC) > 0 then
                            line2 := line2 + '敏捷+' +
                              IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                        end;
                      21:
                        begin
                          if HiWord(g_MouseItem.S.AC) > 0 then
                            line2 := line2 + '体力恢复+' +
                              IntToStr(HiWord(g_MouseItem.S.AC)) + '0% ';
                          if HiWord(g_MouseItem.S.MAC) > 0 then
                            line2 := line2 + '魔法恢复+' +
                              IntToStr(HiWord(g_MouseItem.S.MAC)) + '0% ';
                          //if LoWord(g_MouseItem.S.AC)  > 0 then line2 := line2 + '攻击速度+' + IntToStr(LoWord(g_MouseItem.S.AC)) + ' ';
                          //if LoWord(g_MouseItem.S.MAC) > 0 then line2 := line2 + '攻击速度-' + IntToStr(LoWord(g_MouseItem.S.MAC)) + ' ';
                        end;
                      23:
                        begin
                          if HiWord(g_MouseItem.S.AC) > 0 then
                            line2 := line2 + '毒物躲避+' +
                              IntToStr(HiWord(g_MouseItem.S.AC)) + '0% ';
                          if HiWord(g_MouseItem.S.MAC) > 0 then
                            line2 := line2 + '中毒恢复+' +
                              IntToStr(HiWord(g_MouseItem.S.MAC)) + '0% ';
                          //if LoWord(g_MouseItem.S.AC)  > 0 then line2 := line2 + '攻击速度+' + IntToStr(LoWord(g_MouseItem.S.AC)) + ' ';
                          //if LoWord(g_MouseItem.S.MAC) > 0 then line2 := line2 + '攻击速度-' + IntToStr(LoWord(g_MouseItem.S.MAC)) + ' ';
                        end;
                    else
                      begin
                        if HiWord(g_MouseItem.S.AC) > 0 then
                          line2 := line2 + '防御+' +
                            IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                        if HiWord(g_MouseItem.S.MAC) > 0 then
                          line2 := line2 + '魔御+' +
                            IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                      end;
                    end;
                    if HiWord(g_MouseItem.S.DC) > 0 then
                      line2 := line2 + '攻击+' +
                        IntToStr(HiWord(g_MouseItem.S.DC)) + ' ';
                    if HiWord(g_MouseItem.S.MC) > 0 then
                      line2 := line2 + '魔法+' +
                        IntToStr(HiWord(g_MouseItem.S.MC)) + ' ';
                    if HiWord(g_MouseItem.S.SC) > 0 then
                      line2 := line2 + '道术+' +
                        IntToStr(HiWord(g_MouseItem.S.SC)) + ' ';
                  end;
              end;
            end;
            line3 := '成功机率' + IntToStr(g_MouseItem.S.DuraMax) + '% ';
            if g_MouseItem.S.StdMode = 58 then
            begin
              if g_MouseItem.S.NeedLevel > 0 then
                line3 := line3 + '失败减去相同升级属性机率' +
                  IntToStr(g_MouseItem.S.NeedLevel) + '% ';
            end
            else
            begin
              if g_MouseItem.S.NeedLevel > 100 then
              begin
                line3 := line3 + '失败装备[消失]机率' +
                  IntToStr(g_MouseItem.S.NeedLevel - 100) + '% '
              end
              else if g_MouseItem.S.NeedLevel > 0 then
                line3 := line3 + '失败升级属性[清零]机率' +
                  IntToStr(g_MouseItem.S.NeedLevel) + '% ';
            end;
          end;
        56:
          begin
            line1 := line1 + '重量' + IntToStr(g_MouseItem.S.Weight);
            i := GetTakeOnPosition(g_MouseItem.S.Shape);
            if I in [0..13] then
            begin
              line1 := line1 + ' 用于[' + LevelUseItem[I] + ']';
            end
            else
              line1 := line1 + ' 用于[所有]';
            //line1 := line1 + '+' + IntToStr(g_MouseItem.S.Need) + '以下装备';
            if HiWord(g_MouseItem.S.Need) = 0 then
            begin
              line1 := line1 + '等级' + IntToStr(g_MouseItem.S.Need) +
                '以下装备';
            end
            else
            begin
              line1 := line1 + '等级' + IntToStr(HiWord(g_MouseItem.S.Need)) + '~等级'
                + IntToStr(LoWord(g_MouseItem.S.Need)) + '装备';
            end;
            line2 := '随机增加 ' + IntToStr(g_MouseItem.S.AniCount) +
              '点属性';
            line3 := '成功机率' + IntToStr(g_MouseItem.S.DuraMax) + '% ';
            if g_MouseItem.S.NeedLevel > 100 then
            begin
              line3 := line3 + '失败装备[消失]机率' +
                IntToStr(g_MouseItem.S.NeedLevel - 100) + '% '
            end
            else if g_MouseItem.S.NeedLevel > 0 then
              line3 := line3 + '失败升级属性[清零]机率' +
                IntToStr(g_MouseItem.S.NeedLevel) + '% ';
          end;
        57:
          begin
            line1 := line1 + '重量' + IntToStr(g_MouseItem.S.Weight);
            line2 := '升级附加宝石，提高升级机率';
            if g_MouseItem.S.DuraMax > 0 then
              line3 := line3 + '成功机率增加' +
                IntToStr(g_MouseItem.S.DuraMax) + '% ';
            {if g_MouseItem.S.NeedLevel > 100 then begin
              line3 := line3 + '失败[消失]几率增加'+IntToStr(g_MouseItem.S.NeedLevel-100)+'% ';
            end else
            if g_MouseItem.S.NeedLevel > 0 then
              line3 := line3 + '失败[清零]几率增加'+IntToStr(g_MouseItem.S.NeedLevel)+'% '; }
          end;
       60:
         begin
            line1 := line1 + '重量' + IntToStr(g_MouseItem.S.Weight)+' 容量' + GetDuraStr(g_MouseItem.Dura,
                  g_MouseItem.DuraMax);
            line2 := '品质' + IntToStr(g_MouseItem.S.Source)+' 酒精度'+IntToStr(g_MouseItem.S.Reserved)+'°';
            line3 :=g_MouseItem.Desc;
         end   
      else
        begin
          line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight);
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.GetMouseItemInfo'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DItemBagDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d0, d1, d2, d3,d4: string;
  n: integer;
  useable: Boolean;
  d: TDirectDrawSurface;
  //boShow:Boolean;
begin
  try //程序自动增加
    if g_MySelf = nil then
      exit;
    //boShow:=False;
    with DItemBag do
    begin
      //boShow:=(FaceIndex<>6);
      d := WLib.Images[FaceIndex];
      if d <> nil then
      begin
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

        d := WLib.Images[182];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left + 234), SurfaceY(Top + 207), d.ClientRect,
            d, TRUE);
        {end else begin
          d := g_WMain2Images.Images[180];
          if d <> nil then begin
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
          end else begin
            d := g_WMain3Images.Images[6];
            if d <> nil then
              dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
          end;}
      end;

      GetMouseItemInfo(d0, d1, d2, d3,d4,useable);

      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        Font.Color := clWhite;
        TextOut(SurfaceX(Left + 70), SurfaceY(Top + 213),
          GetGoldStr(g_MySelf.m_nGold));
        //if boShow then
           //TextOut (SurfaceX(Left+182), SurfaceY(Top+213),g_sGameGoldName+' '+ GetGoldStr(g_MySelf.m_nGameGold));
        //TextOut (SurfaceX(Left+71), SurfaceY(Top+212), GetGoldStr(g_MySelf.m_nGold));
        //盛大物品栏
        if d0 <> '' then
        begin
          n := TextWidth(d0);
          Font.Color := clYellow;
          TextOut(SurfaceX(Left + 75 {70}), SurfaceY(Top + 243 {215}), d0);
          Font.Color := clWhite;
          TextOut(SurfaceX(Left + 75 {70}) + n, SurfaceY(Top + 243 {215}), d1);
          TextOut(SurfaceX(Left + 75 {70}), SurfaceY(Top + 243 {215} + 14), d2);
          if not useable then
            Font.Color := clRed;
          TextOut(SurfaceX(Left + 75 {70}), SurfaceY(Top + 243 {215} + 14 * 2),
            d3);
          n := TextWidth(d3);
          Font.Color := clWhite;
          TextOut(SurfaceX(Left + 75 {70})+n, SurfaceY(Top + 243 {215} + 14 * 2),d4);
        end
        else if m_boShowGold then
        begin
          TextOut(SurfaceX(Left + 75 {70}), SurfaceY(Top + 243 {215}),
            g_sGameGoldName + '数量： ' + GetGoldStr(g_MySelf.m_nGameGold));
          TextOut(SurfaceX(Left + 75 {70}), SurfaceY(Top + 243 {215} + 14),
            g_sGameGird + '： ' + GetGoldStr(g_MySelf.m_nGameGird));
          TextOut(SurfaceX(Left + 75 {70}), SurfaceY(Top + 243 {215} + 28),
            g_sGameDiamond + '： ' + GetGoldStr(g_MySelf.m_nGameDiamond));
        end
        else
          TextOut(SurfaceX(Left + 75 {70}), SurfaceY(Top + 243 {215}),
            '使用 Alt + R 刷新人物背包物品');
        Release;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DItemBagDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DRepairItemInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
begin
  try //程序自动增加
    { if (X >= 0) and (Y >= 0) and (X <= DRepairItem.Width) and
        (Y <= DRepairItem.Height) then
           IsRealArea := TRUE
     else IsRealArea := FALSE;  }
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DRepairItemInRealArea');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DRepairItemDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    { with DRepairItem do begin
        d := WLib.Images[FaceIndex];
        if DRepairItem.Downed and (d <> nil) then
           dsurface.Draw (SurfaceX(254), SurfaceY(183), d.ClientRect, d, TRUE);
     end;}
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DRepairItemDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DCloseBagDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    with DCloseBag do
    begin
      if DCloseBag.Downed then
      begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DCloseBagDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DCloseBagClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DItemBag.Visible := FALSE;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DCloseBagClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DItemGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  idx: integer;
  temp: TClientItem;
  iname, d1, d2, d3: string;
  useable: Boolean;
  hcolor: TColor;
begin
  try //程序自动增加
    m_nMouseIdx := 0;
    if ssRight in Shift then
    begin
      if g_boItemMoving then
        DItemGridGridSelect(self, ACol, ARow, Shift);
    end
    else
    begin
      idx := ACol + ARow * DItemGrid.ColCount + 6 {骇飘傍埃};
      if idx in [6..MAXBAGITEM - 1] then
      begin
        g_MouseItem := g_ItemArr[idx];
        m_nMouseIdx := idx;
        {if (g_MouseItem.S.Name<>'') then begin
         with DItemGrid do
                DScreen.ShowHint (SurfaceX(Left + ACol*ColWidth),
                                  SurfaceY(Top + (ARow+1)*RowHeight),
                                  g_MouseItem.Desc,clWhite, FALSE);  }
        //end;
        if g_MouseItem.S.Name <> '' then
        begin
          iname := '';
          if (GetTakeOnPosition(g_MouseItem.S.StdMode) <> -1) then
          begin
            iname := '右键穿装备';
            if (g_MouseItem.S.StdMode = 30) and
              (g_MouseItem.S.Shape in [51..100]) then
              iname := iname + '\使用 Ctrl + M 快速切换骑马状态';
          end;
         if g_BagShowItemDec then
         begin
          iname := iname + '\' + g_MouseItem.Desc;
          with DItemGrid do
            DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
              SurfaceY(Top + (ARow + 1) * RowHeight),
              iname, clWhite, FALSE);
         end;
        end
        else
        begin
          m_nMouseIdx := 0;
          DScreen.ClearHint;
        end;
        {GetMouseItemInfo (iname, d1, d2, d3, useable);
        if iname <> '' then begin
           if useable then hcolor := clWhite
           else hcolor := clRed;
           with DItemGrid do
              DScreen.ShowHint (SurfaceX(Left + ACol*ColWidth),
                                SurfaceY(Top + (ARow+1)*RowHeight),
                                iname + d1 + '\' + d2 + '\' + d3, hcolor, FALSE);
        end;
        g_MouseItem.S.Name := '';}
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DItemGridGridMouseMove');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DItemGridGridSelect(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
  idx, mi: integer;
  temp: TClientItem;
begin
  try //程序自动增加
    idx := ACol + ARow * DItemGrid.ColCount + 6 {骇飘傍埃};
    if idx in [6..MAXBAGITEM - 1] then
    begin
      if not g_boItemMoving then
      begin
        if g_ItemArr[idx].S.Name <> '' then
        begin
          g_boItemMoving := TRUE;
          g_MovingItem.Index := idx;
          g_MovingItem.Item := g_ItemArr[idx];
          g_MovingItem.Hero := False;
          g_ItemArr[idx].S.Name := '';
          ItemClickSound(g_ItemArr[idx].S);
        end;
      end
      else
      begin
        //ItemClickSound (MovingItem.Item.S.StdMode);
        mi := g_MovingItem.Index;
        if (mi = -97) or (mi = -98) then
          exit;
        if (mi < 0) and (mi >= -14 {-9}) then
        begin
          if g_MovingItem.Hero then
            exit;
          g_WaitingUseItem := g_MovingItem;
          FrmMain.SendTakeOffItem(-(g_MovingItem.Index + 1),
            g_MovingItem.Item.MakeIndex, g_MovingItem.Item.S.Name);
          g_MovingItem.Item.S.name := '';
          g_boItemMoving := FALSE;
        end
        else
        begin
          if (mi <= -20) and (mi > -30) then
            DealItemReturnBag(g_MovingItem.Item);
          if g_MovingItem.Hero then
          begin
            if g_WaitingUseItem.Item.S.Name = '' then
            begin
              g_WaitingUseItem := g_MovingItem;
              FrmMain.SendHeroItemToMasterBag(g_MovingItem.Item.MakeIndex,
                g_MovingItem.Item.S.Name);
              g_MovingItem.Item.S.name := '';
              g_boItemMoving := FALSE;
            end;
            exit;
          end;
          if g_ItemArr[idx].S.Name <> '' then
          begin
           if ((g_MovingItem.Item.S.StdMode=9) and (g_MovingItem.Item.S.Shape=1) and
           (g_ItemArr[idx].S.StdMode=2) and (g_ItemArr[idx].S.reserved=56)) or
           ((g_MovingItem.Item.S.StdMode=0) and (g_ItemArr[idx].S.StdMode=0) and
           (g_MovingItem.Item.S.Name=g_ItemArr[idx].S.Name) and (g_MovingItem.Item.S.reserved=1) and
           (g_ItemArr[idx].S.reserved=1)) then //泉水叠加到泉水罐 或药品叠加
           begin
            g_WaitingUseItem := g_MovingItem;
            frmMain.SendItemFold(g_MovingItem.Item.MakeIndex,g_ItemArr[idx].MakeIndex,0);
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
           end else
           begin
            temp := g_ItemArr[idx];
            g_ItemArr[idx] := g_MovingItem.Item;
            g_MovingItem.Index := idx;
            g_MovingItem.Item := temp;
            g_MovingItem.Hero := False;
           end;
          end
          else
          begin
            g_ItemArr[idx] := g_MovingItem.Item;
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
          end;
        end;
      end;
    end;
    ArrangeItemBag;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DItemGridGridSelect'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DItemGridDblClick(Sender: TObject);
var
  idx, i: integer;
  keyvalue: TKeyBoardState;
  cu: TClientItem;
begin
  try //程序自动增加
    idx := DItemGrid.Col + DItemGrid.Row * DItemGrid.ColCount + 6;
    if idx in [6..MAXBAGITEM - 1] then
    begin
      if g_ItemArr[idx].S.Name <> '' then
      begin
        FillChar(keyvalue, sizeof(TKeyboardState), #0);
        GetKeyboardState(keyvalue);
        if keyvalue[VK_CONTROL] = $80 then
        begin
          //骇飘芒栏肺 颗辫
          cu := g_ItemArr[idx];
          g_ItemArr[idx].S.Name := '';
          AddItemBag(cu);
        end
        else if (g_ItemArr[idx].S.StdMode <= 4) or (g_ItemArr[idx].S.StdMode =
          31) or (g_ItemArr[idx].S.StdMode = 48) or (g_ItemArr[idx].S.StdMode = 60)then
        begin //数量且 荐 乐绰 酒捞袍
          //DScreen.AddSysMsg(format('%d/%d',[g_ItemArr[idx].S.StdMode,g_ItemArr[idx].S.reserved]));
          if (g_ItemArr[idx].S.StdMode = 48) and (g_ItemArr[idx].S.Shape in
            [1..5]) then
          begin
            if (g_OpenArkItem.S.Name = '') and (not m_boOpenBox) then
            begin
              m_boOpenArk := False;
              m_boOpenBox := False;
              m_nOpenArkIdx := 0;
              g_OpenArkItem := g_ItemArr[idx];
              g_ItemArr[idx].S.Name := '';
              g_OpenArkKeyItem.S.Name := '';
              DOpenArk.Visible := True;
              FillChar(g_OpenBoxItem, sizeof(g_OpenBoxItem), #0);
              PlaySoundEx(bmg_SelectBoxFlash);
            end;
          end
          else
            FrmMain.EatItem(idx);
        end;
      end
      else
      begin
        if g_boItemMoving and (g_MovingItem.Item.S.Name <> '') and (not
          g_MovingItem.Hero) then
        begin
          FillChar(keyvalue, sizeof(TKeyboardState), #0);
          GetKeyboardState(keyvalue);
          if keyvalue[VK_CONTROL] = $80 then
          begin
            //骇飘芒栏肺 颗辫
            cu := g_MovingItem.Item;
            g_MovingItem.Item.S.Name := '';
            g_boItemMoving := FALSE;
            AddItemBag(cu);
          end
          else if (g_MovingItem.Index = idx) and
            (g_MovingItem.Item.S.StdMode <= 4) or (g_ItemArr[idx].S.StdMode = 31)
            or (g_ItemArr[idx].S.StdMode = 48) or (g_ItemArr[idx].S.StdMode = 60) then
          begin
            if (g_MovingItem.Item.S.StdMode = 48) and (g_MovingItem.Item.S.Shape
              in [1..5]) then
            begin
              if (g_OpenArkItem.S.Name = '') and (not m_boOpenBox) then
              begin
                m_boOpenArk := False;
                m_boOpenBox := False;
                m_nOpenArkIdx := 0;
                g_OpenArkItem := g_MovingItem.Item;
                g_boItemMoving := FALSE;
                g_MovingItem.Item.S.Name := '';
                g_OpenArkKeyItem.S.Name := '';
                DOpenArk.Visible := True;
                FillChar(g_OpenBoxItem, sizeof(g_OpenBoxItem), #0);
                PlaySoundEx(bmg_SelectBoxFlash);
              end;
            end
            else
            begin
             { if (g_MovingItem.Item.Dura>1) and (g_MovingItem.Item.S.StdMode=0) then
              begin
                Dec(g_MovingItem.Item.Dura);
                cu:=g_MovingItem.Item;
                FrmMain.EatItem(-1);
                g_ItemArr[idx]:=cu;
              end else }
              FrmMain.EatItem(-1);
            end;
          end;
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DItemGridDblClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
var
  idx,n: integer;
  sText:string;
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    idx := ACol + ARow * DItemGrid.ColCount + 6;
    if idx in [6..MAXBAGITEM - 1] then
    begin
      if g_ItemArr[idx].S.Name <> '' then
      begin
        d := FrmMain.GetWBagItemImg(g_ItemArr[idx].S.Looks);
        if d <> nil then
          with DItemGrid do
          begin
            dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
              d.ClientRect,
              d, TRUE);
          if (g_ItemArr[idx].Dura>1) and (g_ItemArr[idx].S.StdMode=0) then
           begin
             sText:=IntToStr(g_ItemArr[idx].Dura);
             n := dsurface.Canvas.TextWidth(sText);
             SetBkMode(dsurface.Canvas.Handle,TRANSPARENT);
             dsurface.Canvas.Font.Color := clWhite;
             dsurface.Canvas.Font.Style:=[fsBold];
             dsurface.Canvas.TextOut(SurfaceX(Rect.Left + d.Width-n),SurfaceY(Rect.Top),sText);
             dsurface.Canvas.Font.Style:=dsurface.Canvas.Font.Style-[fsBold];
             dsurface.Canvas.Release;
           end;
          end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DItemGridGridPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGoldClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if g_MySelf = nil then
      exit;
    if not g_boItemMoving then
    begin
      if g_MySelf.m_nGold > 0 then
      begin
        PlaySound(s_money);
        g_boItemMoving := TRUE;
        g_MovingItem.Index := -98; //捣
        g_MovingItem.Item.S.Name := g_sGoldName {'金币'};
      end;
    end
    else
    begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then
      begin //捣父..
        g_boItemMoving := FALSE;
        g_MovingItem.Item.S.Name := '';
        if g_MovingItem.Index = -97 then
        begin //背券芒俊辑 颗
          DealZeroGold;
        end;
      end;
    end;
    ;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGoldClick'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------------------}

//惑牢 措拳 芒

{------------------------------------------------------------------------}

procedure TFrmDlg.ShowMDlg(face: integer; mname, msgstr: string);
var
  i: integer;
begin
  try //程序自动增加
    CloseDrink;
    DMerchantDlg.Left := 0; //扁夯 困摹
    DMerchantDlg.Top := 0;
    MerchantFace := face;
    MerchantName := mname;
    MDlgStr := msgstr;
    DMerchantDlg.Visible := TRUE;
    DItemBag.Left := 475; //啊规困摹 函版
    DItemBag.Top := 0;
    for i := 0 to MDlgPoints.Count - 1 do
      Dispose(pTClickPoint(MDlgPoints[i]));
    MDlgPoints.Clear;
    RequireAddPoints := TRUE;
    AutoTick := GetTickCount;
    AutoColorIdx := 0;
    LastestClickTime := GetTickCount;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.ShowMDlg'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.ResetMenuDlg;
var
  i: integer;
begin
  try //程序自动增加
    CloseDSellDlg;
    for i := 0 to g_MenuItemList.Count - 1 do //技何 皋春档 努府绢 窃.
      Dispose(PTClientItem(g_MenuItemList[i]));
    g_MenuItemList.Clear;

    for i := 0 to MenuList.Count - 1 do
      Dispose(PTClientGoods(MenuList[i]));
    MenuList.Clear;

    //CurDetailItem := '';
    MenuIndex := -1;
    MenuTopLine := 0;
    BoDetailMenu := FALSE;
    BoStorageMenu := FALSE;
    BoMakeDrugMenu := FALSE;

    DSellDlg.Visible := FALSE;
    DMenuDlg.Visible := FALSE;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.ResetMenuDlg'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.ShowShopMenuDlg;
begin
  try //程序自动增加
    MenuIndex := -1;

    DMerchantDlg.Left := 0; //扁夯 困摹
    DMerchantDlg.Top := 0;
    DMerchantDlg.Visible := TRUE;

    DSellDlg.Visible := FALSE;

    DMenuDlg.Left := 0;
    DMenuDlg.Top := 176;
    DMenuDlg.Visible := TRUE;
    MenuTop := 0;

    DItemBag.Left := 475;
    DItemBag.Top := 0;
    DItemBag.Visible := TRUE;

    LastestClickTime := GetTickCount;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.ShowShopMenuDlg'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.ShowShopSellDlg;
begin
  try //程序自动增加
    DSellDlg.Left := 260;
    DSellDlg.Top := 176;
    DSellDlg.Visible := TRUE;

    DMenuDlg.Visible := FALSE;

    DItemBag.Left := 475;
    DItemBag.Top := 0;
    DItemBag.Visible := TRUE;

    LastestClickTime := GetTickCount;
    g_sSellPriceStr := '';
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.ShowShopSellDlg'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.CloseDrink;
var
  i: integer;
begin
  for i := 0 to m_PlayDrinkPointsTop.Count - 1 do
    Dispose(pTClickPoint(m_PlayDrinkPointsTop[i]));
  for i := 0 to m_PlayDrinkPointsBoom.Count - 1 do
    Dispose(pTClickPoint(m_PlayDrinkPointsBoom[i]));
  m_PlayDrinkPointsBoom.Clear;
  m_PlayDrinkPointsTop.Clear;
  if m_PlayDrinkItem[0].S.Name <> '' then
    AddItemBag(m_PlayDrinkItem[0]);
  if m_PlayDrinkItem[1].S.Name <> '' then
    AddItemBag(m_PlayDrinkItem[1]);
  m_PlayDrinkItem[0].S.Name := '';
  m_PlayDrinkItem[1].S.Name := '';
  DPlayDrink.Visible := False;
  DCompeteDrink.Visible := False;
end;

procedure TFrmDlg.CloseMDlg;
var
  i: integer;
begin
  try //程序自动增加
    MDlgStr := '';
    DMerchantDlg.Visible := FALSE;
    for i := 0 to MDlgPoints.Count - 1 do
      Dispose(PTClickPoint(MDlgPoints[i]));
    MDlgPoints.Clear;
    //皋春芒档 摧澜
    DItemBag.Left := 0;
    DItemBag.Top := 0;
    DMenuDlg.Visible := FALSE;
    CloseDSellDlg;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.CloseMDlg'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.CloseDSellDlg;
begin
  try //程序自动增加
    DSellDlg.Visible := FALSE;
    if g_SellDlgItem2.S.Name <> '' then
      AddItemBag(g_SellDlgItem2);
    g_SellDlgItem2.S.Name := '';
    g_SellOffItem.Item.S.Name := '';
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.CloseDSellDlg'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMerchantDlgShowText(Sender: TObject; dsurface:
  TDirectDrawSurface; Msg, SelectStr: string; X, Y: Word;
  Points: TList; var AddPoints: Boolean);
var
  str, data, fdata, cmdstr, cmdmsg, cmdparam: string;
  lx, ly, sx: integer;
  drawcenter: Boolean;
  pcp: PTClickPoint;
  boColor: Boolean;
  Color: TColor;
  sColor, sTemp: string;
  Idx: Integer;

  function ColorText(sStr: string; DefColor: TColor; boDef, boLength: Boolean):
      string;
  var
    sdata, sfdata, scmdstr, scmdparam, scmdcolor: string;
  begin
    Result := '';
    sdata := sStr;
    with Sender as TDWindow do
    begin
      while (pos('{', sdata) > 0) and (pos('}', sdata) > 0) and (sdata <> '') do
      begin
        if sdata[1] <> '{' then
        begin
          sdata := '{' + GetValidStr3(sdata, sfdata, ['{']);
        end;
        sdata := ArrestStringEx(sdata, '{', '}', scmdstr);
        if scmdstr <> '' then
        begin
          scmdparam := GetValidStr3(scmdstr, scmdstr, ['=']);
          scmdcolor := GetValidStr3(scmdparam, scmdparam, ['=']);
        end;
        if sfdata <> '' then
        begin
          if boLength then
          begin
            Result := Result + sfdata;
          end
          else
          begin
            BoldTextOut(dsurface, SurfaceX(Left + lx + sx), SurfaceY(Top + ly),
              DefColor, clBlack, sfdata);
            sx := sx + dsurface.Canvas.TextWidth(sfdata);
          end;
        end;
        Color := DefColor;
        if CompareText(scmdparam, 'FCOLOR') = 0 then
        begin
          Color := GetRGB(Lobyte(Str_ToInt(scmdcolor, 255)));
        end
        else if CompareText(scmdparam, 'AUTOCOLOR') = 0 then
        begin
          NpcTempList.Clear;
          if ExtractStrings([','], [], PChar(scmdcolor), NpcTempList) > 0 then
          begin
            Idx := AutoColorIdx mod NpcTempList.Count;
            scmdcolor := NpcTempList.Strings[Idx];
          end;
          Color := GetRGB(Lobyte(Str_ToInt(scmdcolor, 255)));
        end;
        if boDef then
          Color := DefColor;
        if boLength then
        begin
          Result := Result + scmdstr;
        end
        else
        begin
          BoldTextOut(dsurface, SurfaceX(Left + lx + sx), SurfaceY(Top + ly),
            Color, clBlack, scmdstr);
          sx := sx + dsurface.Canvas.TextWidth(scmdstr);
        end;
      end; //end while
      if sdata <> '' then
      begin
        if boLength then
        begin
          Result := Result + sdata;
        end
        else
        begin
          BoldTextOut(dsurface, SurfaceX(Left + lx + sx), SurfaceY(Top + ly),
            DefColor, clBlack, sdata);
          sx := sx + dsurface.Canvas.TextWidth(sdata);
        end;
      end;
    end;
  end;

begin
  try //程序自动增加
    with Sender as TDWindow do
    begin
      SetBkMode(dsurface.Canvas.Handle, TRANSPARENT);
      lx := x;
      ly := y;
      str := Msg;
      drawcenter := FALSE;
      while TRUE do
      begin
        if str = '' then
          break;
        str := GetValidStr3(str, data, ['\']);
        if data <> '' then
        begin
          sx := 0;
          fdata := '';
          while (pos('<', data) > 0) and (pos('>', data) > 0) and (data <> '')
            do
          begin
            if data[1] <> '<' then
            begin
              data := '<' + GetValidStr3(data, fdata, ['<']);
            end;
            data := ArrestStringEx(data, '<', '>', cmdstr);

            //fdata + cmdstr + data
            if cmdstr <> '' then
            begin
              if Uppercase(cmdstr) = 'C' then
              begin
                drawcenter := TRUE;
                continue;
              end;
              if UpperCase(cmdstr) = '/C' then
              begin
                drawcenter := FALSE;
                continue;
              end;
              cmdparam := GetValidStr3(cmdstr, cmdstr, ['/']);
              //cmdparam : 努腐 登菌阑 锭 静烙
            end
            else
            begin
              DMenuDlg.Visible := FALSE;
              DSellDlg.Visible := FALSE;
            end;

            if fdata <> '' then
            begin
              ColorText(fdata, clwhite, False, False);
              {if fdata<>'' then begin
                BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, fdata);
                sx := sx + dsurface.Canvas.TextWidth(fdata);
              end;}
            end;
            if cmdstr <> '' then
            begin
              boColor := False;
              if CompareLStr(cmdparam, 'FCOLOR', length('FCOLOR')) then
              begin
                boColor := True;
                sColor := GetValidStr3(cmdparam, sTemp, ['=']);
                Color := GetRGB(Lobyte(Str_ToInt(sColor, 255)));
                //DScreen.AddChatBoardString (sColor, GetRGB(255), GetRGB(0));
              end
              else if CompareLStr(cmdparam, 'AUTOCOLOR', length('AUTOCOLOR'))
                then
              begin
                boColor := True;
                sColor := GetValidStr3(cmdparam, sTemp, ['=']);
                NpcTempList.Clear;
                if ExtractStrings([','], [], PChar(sColor), NpcTempList) > 0
                  then
                begin
                  Idx := AutoColorIdx mod NpcTempList.Count;
                  sColor := NpcTempList.Strings[Idx];
                end;
                Color := GetRGB(Lobyte(Str_ToInt(sColor, 255)));
              end;
              if boColor then
              begin
                BoldTextOut(dsurface, SurfaceX(Left + lx + sx), SurfaceY(Top +
                  ly), Color, clBlack, cmdstr);
                sx := sx + dsurface.Canvas.TextWidth(cmdstr);
              end
              else
              begin
                if (AddPoints) and (cmdparam <> '') then
                begin
                  new(pcp);
                  pcp.rc := Rect(lx + sx, ly, lx + sx +
                    dsurface.Canvas.TextWidth(ColorText(cmdstr, clRed, False,
                    True)), ly + 14);
                  pcp.RStr := cmdparam;
                  Points.Add(pcp);
                end;
                if cmdparam = '' then
                begin
                  ColorText(cmdstr, clRed, False, False);
                  //BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clRed, clBlack, cmdstr);
                end
                else
                begin
                  dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style +
                    [fsUnderline];
                  if SelectStr = cmdparam then
                    ColorText(cmdstr, clRed, True, False)
                      //BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clRed, clBlack, cmdstr)
                  else
                    ColorText(cmdstr, clYellow, False, False);
                  dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style -
                    [fsUnderline];
                  //BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clYellow, clBlack, cmdstr);
                end;

              end;
            end;
          end;
          if data <> '' then
            ColorText(data, clwhite, False, False);
          //BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, data);
        end;
        ly := ly + 16;
      end;
      dsurface.Canvas.Release;
      AddPoints := FALSE;
    end;
    if (GetTickCount - AutoTick) > 500 then
    begin
      AutoTick := GetTickCount;
      Inc(AutoColorIdx); //自动变色间隔
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMerchantDlgDirectPaint');
    //程序自动增加
  end; //程序自动增加
  //
end;
//惑牢 措拳芒

procedure TFrmDlg.DMerchantDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  with Sender as TDWindow do
  begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end;
  DMerchantDlgShowText(Sender, dsurface, MDlgStr, SelectMenuStr, 30, 20,
    MDlgPoints, RequireAddPoints);
end;

procedure TFrmDlg.DMerchantDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    CloseMDlg;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMerchantDlgCloseClick');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMenuDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  function SX(x: integer): integer;
  begin
    Result := DMenuDlg.SurfaceX(DMenuDlg.Left + x);
  end;
  function SY(y: integer): integer;
  begin
    Result := DMenuDlg.SurfaceY(DMenuDlg.Top + y);
  end;
var
  i, lh, k, m, menuline: integer;
  d: TDirectDrawSurface;
  pg: PTClientGoods;
  str: string;
begin
  try //程序自动增加
    with dsurface.Canvas do
    begin
      with DMenuDlg do
      begin
        d := DMenuDlg.WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      SetBkMode(dsurface.Canvas.Handle, TRANSPARENT);
      SetBkMode(Handle, TRANSPARENT);
      //title
      Font.Color := clWhite;
      if not BoStorageMenu then
      begin
        TextOut(SX(19), SY(11), '物品列表');
        TextOut(SX(156), SY(11), '价格');
        TextOut(SX(245), SY(11), '持久力');
        lh := LISTLINEHEIGHT;
        menuline := _MIN(MAXMENU, MenuList.Count - MenuTop);
        //惑前 府胶飘
        for i := MenuTop to MenuTop + menuline - 1 do
        begin
          m := i - MenuTop;
          if i = MenuIndex then
          begin
            Font.Color := clRed;
            TextOut(SX(12), SY(32 + m * lh), char(7));
          end
          else
            Font.Color := clWhite;
          pg := PTClientGoods(MenuList[i]);
          TextOut(SX(19), SY(32 + m * lh), pg.Name);
          if pg.SubMenu >= 1 then
            TextOut(SX(245), SY(32 + m * lh), '>>>>');
          //TextOut (SX(137), SY(32 + m*lh), #31);
          TextOut(SX(156), SY(32 + m * lh), IntToStr(pg.Price) + ' ' +
            g_sGoldName {金币'});
          str := '';
          if pg.Grade = -1 then
            str := '-'
          else
            TextOut(SX(245), SY(32 + m * lh), IntToStr(pg.Grade));
          {else for k:=0 to pg.Grade-1 do
             str := str + '*';
          if Length(str) >= 4 then begin
             Font.Color := clYellow;
             TextOut (SX(245), SY(32 + m*lh), str);
          end else
             TextOut (SX(245), SY(32 + m*lh), str);}
        end;
      end
      else
      begin
        TextOut(SX(19), SY(11), '托管物品列表' + Format(' (%d件)',
          [MenuList.Count]));
        TextOut(SX(156), SY(11), '持久力');
        TextOut(SX(245), SY(11), '');
        lh := LISTLINEHEIGHT;
        menuline := _MIN(MAXMENU, MenuList.Count - MenuTop);
        //惑前 府胶飘
        for i := MenuTop to MenuTop + menuline - 1 do
        begin
          m := i - MenuTop;
          if i = MenuIndex then
          begin
            Font.Color := clRed;
            TextOut(SX(12), SY(32 + m * lh), char(7));
          end
          else
            Font.Color := clWhite;
          pg := PTClientGoods(MenuList[i]);
          TextOut(SX(19), SY(32 + m * lh), pg.Name);
          if pg.SubMenu >= 1 then
            TextOut(SX(137), SY(32 + m * lh), #31);
          TextOut(SX(156), SY(32 + m * lh), IntToStr(pg.Stock) + '/' +
            IntToStr(pg.Grade));
        end;
      end;
      //TextOut (0, 0, IntToStr(MenuTopLine));

      Release;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMenuDlgDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMenuDlgClick(Sender: TObject; X, Y: Integer);
var
  lx, ly, idx: integer;
  iname, d1, d2, d3,d4: string;
  useable: Boolean;
begin
  try //程序自动增加
    DScreen.ClearHint;
    lx := DMenuDlg.LocalX(X) - DMenuDlg.Left;
    ly := DMenuDlg.LocalY(Y) - DMenuDlg.Top;
    if (lx >= 14) and (lx <= 279) and (ly >= 32) then
    begin
      idx := (ly - 32) div LISTLINEHEIGHT + MenuTop;
      if idx < MenuList.Count then
      begin
        PlaySound(s_glass_button_click);
        MenuIndex := idx;
      end;
    end;

    if BoStorageMenu then
    begin
      if (MenuIndex >= 0) and (MenuIndex < g_SaveItemList.Count) then
      begin
        g_MouseItem := PTClientItem(g_SaveItemList[MenuIndex])^;
        GetMouseItemInfo(iname, d1, d2, d3,d4, useable);
        if iname <> '' then
        begin
          lx := 240;
          ly := 32 + (MenuIndex - MenuTop) * LISTLINEHEIGHT;
          with Sender as TDButton do
            DScreen.ShowHint(DMenuDlg.SurfaceX(Left + lx),
              DMenuDlg.SurfaceY(Top + ly),
              iname + d1 + '\' + d2 + '\' + d3+d4 + '\' + g_MouseItem.Desc,
              clYellow, FALSE);
        end;
        g_MouseItem.S.Name := '';
      end;
    end
    else
    begin
      if (MenuIndex >= 0) and (MenuIndex < g_MenuItemList.Count) and
        (PTClientGoods(MenuList[MenuIndex]).SubMenu = 0) then
      begin
        g_MouseItem := PTClientItem(g_MenuItemList[MenuIndex])^;
        BoNoDisplayMaxDura := TRUE;
        GetMouseItemInfo(iname, d1, d2, d3,d4, useable);
        BoNoDisplayMaxDura := FALSE;
        if iname <> '' then
        begin
          lx := 240;
          ly := 32 + (MenuIndex - MenuTop) * LISTLINEHEIGHT;
          with Sender as TDButton do
            DScreen.ShowHint(DMenuDlg.SurfaceX(Left + lx),
              DMenuDlg.SurfaceY(Top + ly),
              iname + d1 + '\' + d2 + '\' + d3+d4 + '\' + g_MouseItem.Desc,
              clYellow, FALSE);
        end;
        g_MouseItem.S.Name := '';
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMenuDlgClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMenuDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  try //程序自动增加
    with DMenuDlg do
      if (X < SurfaceX(Left + 10)) or (X > SurfaceX(Left + Width - 20)) or (Y <
        SurfaceY(Top + 30)) or (Y > SurfaceY(Top + Height - 50)) then
      begin
        DScreen.ClearHint;
      end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMenuDlgMouseMove'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMakeWineHelpClick(Sender: TObject; X, Y: Integer);
var
  bmwine:Boolean;
  i:Integer;
begin
    if g_DBMakeWineidx=3 then exit;
    
    if Sender = DMakeWineHelp then
      g_DBMakeWineidx := 1;
    if Sender = DMaterialMemo then
      g_DBMakeWineidx := 2;
    if Sender = DStartMakeWine then
     begin
       bmwine:=False;
       case g_MakeWineidx of
           0:
             begin
                if g_WineItem[0].S.Name = '' then  bmwine:=True else
                if g_WineItem[2].S.Name = '' then  bmwine:=True else
                if g_WineItem[3].S.Name = '' then  bmwine:=True else
                if g_WineItem[4].S.Name = '' then  bmwine:=True else
                if g_WineItem[5].S.Name = '' then  bmwine:=True else
                if g_WineItem[6].S.Name = '' then  bmwine:=True;
             end;
           1:
             begin
               for I := Low(g_WineItem1) to High(g_WineItem1) do
                if g_WineItem1[i].S.Name = '' then
                begin
                  bmwine:=True;
                  Break;
                end;
             end;
         end;
         if not bmwine then
            g_DBMakeWineidx := 3;
     end;
end;

procedure TFrmDlg.DMakeWineHelpDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  dd: TDirectDrawSurface;
  d:TDButton;
  str:string;
  ndtop:Integer;
begin
    if Sender is TDButton then
    begin
      d := TDButton(Sender);
      if not d.Downed then
      begin
        dd := d.WLib.Images[d.FaceIndex];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
         ndtop:=4;
         if d.MouseEntry=msIn then
             d.Tag:=$00ADD6EF
          else
            d.Tag:=$008CC6EF;
      end
      else
      begin
        dd := d.WLib.Images[d.FaceIndex + 1];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
        ndtop:=5;
        d.Tag:=$004AA5EF;
      end;
        SetBkMode(dsurface.Canvas.Handle, TRANSPARENT);
        dsurface.Canvas.Font.Size := 10;
        dsurface.Canvas.Font.Style := [fsBold];
        BoldTextOut(dsurface,d.SurfaceX(d.Left+8),d.SurfaceY(d.Top+ndtop),d.Tag,clBlack,TDButton(Sender).Caption);
        dsurface.Canvas.Font.Style := [];
        dsurface.Canvas.Font.Size := 9;
        dsurface.Canvas.Release; 
    end;
end;

procedure TFrmDlg.DMenuBuyClick(Sender: TObject; X, Y: Integer);
var
  pg: PTClientGoods;
begin
  try //程序自动增加
    if GetTickCount < LastestClickTime then
      exit; //努腐阑 磊林 给窍霸 力茄
    if (MenuIndex >= 0) and (MenuIndex < MenuList.Count) then
    begin
      pg := PTClientGoods(MenuList[MenuIndex]);
      LastestClickTime := GetTickCount + 5000;
      if pg.SubMenu > 0 then
      begin
        FrmMain.SendGetDetailItem(g_nCurMerchant, 0, pg.Name);
        MenuTopLine := 0;
        CurDetailItem := pg.Name;
      end
      else
      begin
        if BoStorageMenu then
        begin
          FrmMain.SendTakeBackStorageItem(g_nCurMerchant, pg.Price {MakeIndex},
            pg.Name);
          exit;
        end;
        if BoMakeDrugMenu then
        begin
          FrmMain.SendMakeDrugItem(g_nCurMerchant, pg.Name);
          exit;
        end;
        FrmMain.SendBuyItem(g_nCurMerchant, pg.Stock, pg.Name)
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMenuBuyClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMenuPrevClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if not BoDetailMenu then
    begin
      if MenuTop > 0 then
        Dec(MenuTop, MAXMENU - 1);
      if MenuTop < 0 then
        MenuTop := 0;
    end
    else
    begin
      if MenuTopLine > 0 then
      begin
        MenuTopLine := _MAX(0, MenuTopLine - 10);
        FrmMain.SendGetDetailItem(g_nCurMerchant, MenuTopLine, CurDetailItem);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMenuPrevClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMenuNextClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if not BoDetailMenu then
    begin
      if MenuTop + MAXMENU < MenuList.Count then
        Inc(MenuTop, MAXMENU - 1);
    end
    else
    begin
      MenuTopLine := MenuTopLine + 10;
      FrmMain.SendGetDetailItem(g_nCurMerchant, MenuTopLine, CurDetailItem);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMenuNextClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.SoldOutGoods(itemserverindex: integer);
var
  i: integer;
  pg: PTClientGoods;
begin
  try //程序自动增加
    for i := 0 to MenuList.Count - 1 do
    begin
      pg := PTClientGoods(MenuList[i]);
      if (pg.Grade >= 0) and (pg.Stock = itemserverindex) then
      begin
        Dispose(pg);
        MenuList.Delete(i);
        if i < g_MenuItemList.Count then
          g_MenuItemList.Delete(i);
        if MenuIndex > MenuList.Count - 1 then
          MenuIndex := MenuList.Count - 1;
        break;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.SoldOutGoods'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DelStorageItem(itemserverindex: integer);
var
  i: integer;
  pg: PTClientGoods;
begin
  try //程序自动增加
    for i := 0 to MenuList.Count - 1 do
    begin
      pg := PTClientGoods(MenuList[i]);
      if (pg.Price = itemserverindex) then
      begin //焊包格废牢版款 Price = ItemServerIndex烙.
        Dispose(pg);
        MenuList.Delete(i);
        if i < g_SaveItemList.Count then
          g_SaveItemList.Delete(i);
        if MenuIndex > MenuList.Count - 1 then
          MenuIndex := MenuList.Count - 1;
        break;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DelStorageItem'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMenuCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DMenuDlg.Visible := FALSE;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMenuCloseClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMerchantDlgClick(Sender: TObject; X, Y: Integer);
var
  i, L, T: integer;
  p: PTClickPoint;
  TempStr, sName, sUrl: string;
begin
  try //程序自动增加
    if GetTickCount < LastestClickTime then
      exit; //努腐阑 磊林 给窍霸 力茄
    L := DMerchantDlg.Left;
    T := DMerchantDlg.Top;
    with DMerchantDlg do
      for i := 0 to MDlgPoints.Count - 1 do
      begin
        p := PTClickPoint(MDlgPoints[i]);
        if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right))
          and
          (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom))
            then
        begin
          PlaySound(s_glass_button_click);
          if CompareLStr(p.RStr, '@RMST://', Length('@RMST://')) then
          begin
            TempStr := Copy(p.RStr, Length('@RMST://') + 1, Length(p.RStr));
            sUrl := GetValidStr3(TempStr, sName, ['|']);
            if sUrl <> '' then
            begin
              g_boBGSound := True;
              PlayBgMusic(sUrl, True, False);
              //DScreen.AddHitMsg(sUrl);
            end;
            //
            exit;
          end;
          FrmMain.SendMerchantDlgSelect(g_nCurMerchant, p.RStr);
          LastestClickTime := GetTickCount + 5000; //5檬饶俊 数量 啊瓷
          break;
        end;
      end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMerchantDlgClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMerchantDlgMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, L, T: integer;
  p: PTClickPoint;
begin
  try //程序自动增加
    if GetTickCount < LastestClickTime then
      exit; //努腐阑 磊林 给窍霸 力茄
    SelectMenuStr := '';
    L := DMerchantDlg.Left;
    T := DMerchantDlg.Top;
    with DMerchantDlg do
      for i := 0 to MDlgPoints.Count - 1 do
      begin
        p := PTClickPoint(MDlgPoints[i]);
        if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right))
          and
          (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom))
            then
        begin
          SelectMenuStr := p.RStr;
          break;
        end;
      end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMerchantDlgMouseDown');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMerchantDlgMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  try //程序自动增加
    SelectMenuStr := '';
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMerchantDlgMouseUp'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DSellDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  actionname: string;
begin
  try //程序自动增加
    with DSellDlg do
    begin
      d := DMenuDlg.WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        Font.Color := clWhite;
        actionname := '';
        case SpotDlgMode of
          dmSell: actionname := '卖: ';
          dmRepair: actionname := '修理: ';
          dmStorage: actionname := '托管物品';
          dmSellOff: actionname := '价格: ';
          dmPlayDrink: actionname := '请酒';
        end;
        TextOut(SurfaceX(Left + 8), SurfaceY(Top + 6), actionname +
          g_sSellPriceStr);
        Release;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DSellDlgDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DSellDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    CloseDSellDlg;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DSellDlgCloseClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DSellDlgSpotClick(Sender: TObject; X, Y: Integer);
var
  temp: TClientItem;
  param: string;
  nPic: integer;
  sStr: string;
begin
  try //程序自动增加
    if not g_boItemMoving then
    begin
      g_sSellPriceStr := '';
      if g_SellDlgItem2.S.Name <> '' then
      begin
        ItemClickSound(g_SellDlgItem2.S);
        g_boItemMoving := TRUE;
        g_MovingItem.Index := -99; //sell 芒俊辑 唱咳..
        g_MovingItem.Item := g_SellDlgItem2;
        g_MovingItem.Hero := False;
        g_SellDlgItem2.S.Name := '';
        g_SellOffItem.Item.S.Name := '';
      end;
    end
    else
    begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then
        exit;
      if g_MovingItem.Hero then
        exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then
      begin //啊规,骇飘俊辑 柯巴父
        ItemClickSound(g_MovingItem.Item.S);
        if SpotDlgMode = dmSellOff then
        begin
          g_boItemMoving := FALSE;
          if DPicDlg('请输入出售价格') and (DlgPic > 0) and (DlgPic <
            High(Integer)) then
          begin
            if g_SellDlgItem2.S.Name <> '' then
            begin
              AddItemBag(g_SellDlgItem2);
              ArrangeItemBag;
            end;
            g_SellDlgItem2 := g_MovingItem.Item;
            g_SellOffItem.Item := g_MovingItem.Item;
            g_SellOffItem.boCls := DlgCls;
            g_SellOffItem.nPic := DlgPic;
            if DlgCls then
              g_sSellPriceStr := Format('%s %s', [GetGoldStr(DlgPic),
                g_sGameGoldName])
            else
              g_sSellPriceStr := Format('%s %s', [GetGoldStr(DlgPic),
                g_sGoldName]);
          end
          else
          begin
            AddItemBag(g_MovingItem.Item);
            g_SellOffItem.Item.S.Name := '';
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
            ArrangeItemBag;
          end;
          g_MovingItem.Item.S.Name := '';
          exit;
        end;
        if (SpotDlgMode = dmPlayDrink) and (g_MovingItem.Item.S.StdMode <> 60)
          then
          exit;
        g_sSellPriceStr := '';
        if g_SellDlgItem2.S.Name <> '' then
        begin //磊府俊 乐栏搁
          temp := g_SellDlgItem2;
          g_SellDlgItem2 := g_MovingItem.Item;
          g_MovingItem.Index := -99; //sell 芒俊辑 唱咳..
          g_MovingItem.Item := temp;
          g_MovingItem.Hero := False;
        end
        else
        begin
          g_SellDlgItem2 := g_MovingItem.Item;
          g_MovingItem.Item.S.name := '';
          g_boItemMoving := FALSE;
        end;
        g_boQueryPrice := TRUE;
        g_dwQueryPriceTime := GetTickCount;
      end;
    end;

  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DSellDlgSpotClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DSellDlgSpotDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  n:integer;
  sText:String;
begin
  try //程序自动增加
    if g_SellDlgItem2.S.Name <> '' then
    begin
      d := FrmMain.GetWBagItemImg(g_SellDlgItem2.S.Looks);
      if d <> nil then
        with DSellDlgSpot do
        begin
          dsurface.Draw(SurfaceX(Left + (Width - d.Width) div 2),
            SurfaceY(Top + (Height - d.Height) div 2),
            d.ClientRect,
            d, TRUE);
            if (g_SellDlgItem2.Dura>1) and (g_SellDlgItem2.S.StdMode=0) then
             begin
               sText:=IntToStr(g_SellDlgItem2.Dura);
               n := dsurface.Canvas.TextWidth(sText);
               SetBkMode(dsurface.Canvas.Handle,TRANSPARENT);
               dsurface.Canvas.Font.Color := clWhite;
               dsurface.Canvas.Font.Style:=[fsBold];
               dsurface.Canvas.TextOut(SurfaceX(Left + d.Width-n),SurfaceY(Top),sText);
               dsurface.Canvas.Font.Style:=dsurface.Canvas.Font.Style-[fsBold];
               dsurface.Canvas.Release;
             end;
        end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DSellDlgSpotDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DSellDlgSpotMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  try //程序自动增加
    g_MouseItem := g_SellDlgItem2;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DSellDlgSpotMouseMove');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DSellDlgOkClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if (g_SellDlgItem2.S.Name = '') and (g_SellDlgItemSellWait.S.Name = '') then
      exit;
    if GetTickCount < LastestClickTime then
      exit; //努腐阑 磊林 给窍霸 力茄
    case SpotDlgMode of
      dmSell: FrmMain.SendSellItem(g_nCurMerchant, g_SellDlgItem2.MakeIndex,
          g_SellDlgItem2.S.Name);
      dmRepair: FrmMain.SendRepairItem(g_nCurMerchant, g_SellDlgItem2.MakeIndex,
          g_SellDlgItem2.S.Name);
      dmStorage: FrmMain.SendStorageItem(g_nCurMerchant,
          g_SellDlgItem2.MakeIndex, g_SellDlgItem2.S.Name);
      dmSellOff: FrmMain.SendSellOffItem(g_nCurMerchant,
          g_SellOffItem.Item.MakeIndex, g_SellOffItem.nPic,
            g_SellOffItem.boCls);
      dmPlayDrink: FrmMain.SendPlayDrinkItem(g_nCurMerchant,
          g_SellDlgItem2.MakeIndex);
    end;
    g_SellDlgItemSellWait := g_SellDlgItem2;
    g_SellDlgItem2.S.Name := '';
    g_SellOffItem.Item.S.Name := '';
    LastestClickTime := GetTickCount + 5000;
    g_sSellPriceStr := '';
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DSellDlgOkClick'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------------------}

//魔法 虐 汲沥 芒 (促捞倔 肺弊)

{------------------------------------------------------------------------}

procedure TFrmDlg.SetMagicKeyDlg(icon: integer; magname: string; var curkey:
  word);
begin
  try //程序自动增加
    MagKeyIcon := icon;
    MagKeyMagName := magname;
    MagKeyCurKey := curkey;

    DKeySelDlg.Left := (SCREENWIDTH - DKeySelDlg.Width) div 2;
    DKeySelDlg.Top := (SCREENHEIGHT - DKeySelDlg.Height) div 2;
    HideAllControls;
    DKeySelDlg.ShowModal;

    while TRUE do
    begin
      if not DKeySelDlg.Visible then
        break;
      //FrmMain.DXTimerTimer (self, 0);
      FrmMain.ProcOnIdle;
      Application.ProcessMessages;
      if Application.Terminated then
        exit;
    end;

    RestoreHideControls;
    curkey := MagKeyCurKey;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.SetMagicKeyDlg'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.SetMiniMapSize(flag: Byte);
begin
  case flag of
    0: DMiniMapDlg.Visible := False;
    1:
      begin
        g_nMiniMaxShow := False;
        DMiniMapDlg.Left := SCREENWIDTH - 120;
        DMiniMapDlg.Top := 0;
        DMiniMapDlg.Width := 120;
        DMiniMapDlg.Height := 120;
       // DBottom.Visible :=True;
      end;
    2:
      begin
        g_nMiniMaxShow := False;
        DMiniMapDlg.Left := SCREENWIDTH - 150;
        DMiniMapDlg.Top := 0;
        DMiniMapDlg.Width := 150;
        DMiniMapDlg.Height := 150;
       // DBottom.Visible :=True;
      end;
    3:
      begin
     //   DBottom.Visible := False;
        g_nMiniMaxShow := True;
        DMiniMapDlg.Left := 0;
        DMiniMapDlg.Top := 0;
        DMiniMapDlg.Width := 800;
        DMiniMapDlg.Height := 600;
      end;
  end;
end;

procedure TFrmDlg.DKeySelDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    with DKeySelDlg do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      //魔法快捷键
      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        Font.Color := clSilver;
        TextOut(SurfaceX(Left + 95), SurfaceY(Top + 38), MagKeyMagName +
          ' 快捷键设置为.');
        Release;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DKeySelDlgDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DKsIconDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    with DksIcon do
    begin
      d := g_WMagIconImages.Images[MagKeyIcon];
      if d = nil then
        d := g_WMagIconImages.Images[0];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DKsIconDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DKsF1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  b: TDButton;
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    b := nil;
    case MagKeyCurKey of
      word('1'): b := DKsF1;
      word('2'): b := DKsF2;
      word('3'): b := DKsF3;
      word('4'): b := DKsF4;
      word('5'): b := DKsF5;
      word('6'): b := DKsF6;
      word('7'): b := DKsF7;
      word('8'): b := DKsF8;
      word('E'): b := DKsConF1;
      word('F'): b := DKsConF2;
      word('G'): b := DKsConF3;
      word('H'): b := DKsConF4;
      word('I'): b := DKsConF5;
      word('J'): b := DKsConF6;
      word('K'): b := DKsConF7;
      word('L'): b := DKsConF8;
    else
      b := DKsNone;
    end;
    if b = Sender then
    begin
      with b do
      begin
        d := WLib.Images[FaceIndex + 1];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
    end;
    with Sender as TDButton do
    begin
      if Downed then
      begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DKsF1DirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DKsOkClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DKeySelDlg.Visible := FALSE;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DKsOkClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DKsF1Click(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if Sender = DKsF1 then
      MagKeyCurKey := integer('1');
    if Sender = DKsF2 then
      MagKeyCurKey := integer('2');
    if Sender = DKsF3 then
      MagKeyCurKey := integer('3');
    if Sender = DKsF4 then
      MagKeyCurKey := integer('4');
    if Sender = DKsF5 then
      MagKeyCurKey := integer('5');
    if Sender = DKsF6 then
      MagKeyCurKey := integer('6');
    if Sender = DKsF7 then
      MagKeyCurKey := integer('7');
    if Sender = DKsF8 then
      MagKeyCurKey := integer('8');
    if Sender = DKsConF1 then
      MagKeyCurKey := integer('E');
    if Sender = DKsConF2 then
      MagKeyCurKey := integer('F');
    if Sender = DKsConF3 then
      MagKeyCurKey := integer('G');
    if Sender = DKsConF4 then
      MagKeyCurKey := integer('H');
    if Sender = DKsConF5 then
      MagKeyCurKey := integer('I');
    if Sender = DKsConF6 then
      MagKeyCurKey := integer('J');
    if Sender = DKsConF7 then
      MagKeyCurKey := integer('K');
    if Sender = DKsConF8 then
      MagKeyCurKey := integer('L');
    if Sender = DKsNone then
      MagKeyCurKey := 0;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DKsF1Click'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------------------}

//扁夯芒狼 固聪 滚瓢

{------------------------------------------------------------------------}

procedure TFrmDlg.DBotMiniMapClick(Sender: TObject; X, Y: Integer);
begin
  if not g_boViewMiniMap then
  begin
    if GetTickCount > g_dwQueryMsgTick then
    begin
      g_dwQueryMsgTick := GetTickCount + 3000;
      frmMain.SendWantMiniMap;
      g_nViewMinMapLv := 1;
      SetMiniMapSize(1);
    end;
  end
  else
  begin
    if g_nViewMinMapLv >= 2 then
    begin
      g_nViewMinMapLv := 0;
      g_boViewMiniMap := FALSE;
      SetMiniMapSize(0);
    end
    else
    begin
      Inc(g_nViewMinMapLv);
      SetMiniMapSize(2);
    end;
  end;
end;

procedure TFrmDlg.DBotTradeClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if GetTickCount > g_dwQueryMsgTick then
    begin
      g_dwQueryMsgTick := GetTickCount + 3000;
      FrmMain.SendDealTry;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotTradeClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotGuildClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if DGuildDlg.Visible then
    begin
      DGuildDlg.Visible := FALSE;
    end
    else if GetTickCount > g_dwQueryMsgTick then
    begin
      g_dwQueryMsgTick := GetTickCount + 3000;
      FrmMain.SendGuildDlg;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotGuildClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotGroupClick(Sender: TObject; X, Y: Integer);
begin
  {  try //程序自动增加
      ToggleShowGroupDlg;
    except //程序自动增加
      DebugOutStr('[Exception] TFrmDlg.DBotGroupClick'); //程序自动增加
    end; //程序自动增加 }
end;

{------------------------------------------------------------------------}

//弊缝 促捞倔肺弊

{------------------------------------------------------------------------}

procedure TFrmDlg.ToggleShowGroupDlg;
begin
  try //程序自动增加
    DGroupDlg.Visible := not DGroupDlg.Visible;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.ToggleShowGroupDlg'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGroupDlgClick(Sender: TObject; X, Y: Integer);
var
  nX, nY: integer;
begin
  nX := X - DGroupDlg.Left;
  nY := Y - DGroupDlg.Top;
  if (nx > 24) and (nx < 130) and (nY > 48) and (nY < 70) then
  begin
    m_boAutoGroup := not m_boAutoGroup;
    if (g_GroupMembers.Count > 0) and
      (g_MySelf <> nil) and
      (CompareText(g_MySelf.m_sUserName, g_GroupMembers[0]) = 0) then
    begin
      FrmMain.SendAutoGroup(m_boAutoGroup);
    end;
  end;
end;

procedure TFrmDlg.DGroupDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
const
  boShow: array[Boolean] of Byte = (0, 1);
var
  d: TDirectDrawSurface;
  lx, ly, n: integer;
begin
  try //程序自动增加
    with DGroupDlg do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      d := g_WMain3Images.Images[488 + boShow[m_boAutoGroup]];
      if d <> nil then
      begin
        dsurface.Draw(SurfaceX(24) + Left, SurfaceY(48) + Top, d.ClientRect, d,
          TRUE);
      end;
      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        Font.Color := clSilver;
        BoldTextOut(Dsurface, SurfaceX(47) + Left, SurfaceY(51) + Top, clwhite,
          clBlack, '自动招幕队员');
        //TextOut (SurfaceX(50) + Left,SurfaceY(51) + Top, '自动招幕队员');
        if g_GroupMembers.Count > 0 then
        begin
          lx := SurfaceX(28) + Left;
          ly := SurfaceY(80) + Top;
          TextOut(lx, ly, g_GroupMembers[0]);

          //
          for n := 1 to g_GroupMembers.Count - 1 do
          begin
            lx := SurfaceX(28) + Left + ((n - 1) mod 2) * 100;
            ly := SurfaceY(80 + 16) + Top + ((n - 1) div 2) * 16;
            TextOut(lx, ly, g_GroupMembers[n]);
          end;
        end;
        Release;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGroupDlgDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGrpDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DGroupDlg.Visible := FALSE;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGrpDlgCloseClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGrpAllowGroupClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if GetTickCount > g_dwChangeGroupModeTick then
    begin
      g_boAllowGroup := not g_boAllowGroup;
      if g_boAllowGroup then
        DScreen.AddChatBoardString('允许组队', clWhite, clRed)
      else
        DScreen.AddChatBoardString('不允许组队', clWhite, clRed);
      g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5檬
      FrmMain.SendGroupMode(g_boAllowGroup);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGrpAllowGroupClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGrpAllowGroupDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    with Sender as TDButton do
    begin
      if Downed then
      begin
        d := WLib.Images[FaceIndex - 1];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end
      else
      begin
        if g_boAllowGroup then
        begin
          d := WLib.Images[FaceIndex];
          if d <> nil then
            dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGrpAllowGroupDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGrpCreateClick(Sender: TObject; X, Y: Integer);
var
  who: string;
begin
  try //程序自动增加
    if (GetTickCount > g_dwChangeGroupModeTick) and (g_GroupMembers.Count = 0)
      then
    begin
      DialogSize := 1;
      DMessageDlg('输入你想加入编组的人的名字.', [mbOk, mbAbort]);
      who := Trim(DlgEditText);
      if who <> '' then
      begin
        g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5檬
        FrmMain.SendCreateGroup(Trim(DlgEditText), m_boAutoGroup);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGrpCreateClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGrpAddMemClick(Sender: TObject; X, Y: Integer);
var
  who: string;
begin
  try //程序自动增加
    if (GetTickCount > g_dwChangeGroupModeTick) and (g_GroupMembers.Count > 0)
      then
    begin
      DialogSize := 1;
      DMessageDlg('输入你想加入编组的人的名字.', [mbOk, mbAbort]);
      who := Trim(DlgEditText);
      if who <> '' then
      begin
        g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5檬
        FrmMain.SendAddGroupMember(Trim(DlgEditText));
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGrpAddMemClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGrpDelMemClick(Sender: TObject; X, Y: Integer);
var
  who: string;
begin
  try //程序自动增加
    if (GetTickCount > g_dwChangeGroupModeTick) and (g_GroupMembers.Count > 0)
      then
    begin
      DialogSize := 1;
      DMessageDlg('输入你想从编组中删除的人的名字.', [mbOk,
        mbAbort]);
      who := Trim(DlgEditText);
      if who <> '' then
      begin
        g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5檬
        FrmMain.SendDelGroupMember(Trim(DlgEditText));
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGrpDelMemClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotLogoutClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    //强行退出
{            g_dwLatestStruckTick:=GetTickCount() + 10001;
    g_dwLatestMagicTick:=GetTickCount() + 10001;
    g_dwLatestHitTick:=GetTickCount() + 10001;
    //
if (GetTickCount - g_dwLatestStruckTick > 10000) and
(GetTickCount - g_dwLatestMagicTick > 10000) and
(GetTickCount - g_dwLatestHitTick > 10000) or
(g_MySelf.m_boDeath) then begin  }
    FrmMain.AppLogOut;
    {  end else
         DScreen.AddChatBoardString ('战斗中不能退出游戏.', clYellow, clRed); }
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotLogoutClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotExitClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    //强行退出
{             g_dwLatestStruckTick:=GetTickCount() + 10001;
    g_dwLatestMagicTick:=GetTickCount() + 10001;
    g_dwLatestHitTick:=GetTickCount() + 10001;
    //
if (GetTickCount - g_dwLatestStruckTick > 10000) and
(GetTickCount - g_dwLatestMagicTick > 10000) and
(GetTickCount - g_dwLatestHitTick > 10000) or
(g_MySelf.m_boDeath) then begin           }
    FrmMain.AppExit;
    { end else
        DScreen.AddChatBoardString ('战斗中不能退出游戏.', clYellow, clRed); }
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotExitClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotPlusAbilClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    FrmDlg.OpenAdjustAbility;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotPlusAbilClick'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------------------}

//背券 促捞倔肺弊

{------------------------------------------------------------------------}

procedure TFrmDlg.OpenDealDlg;
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    DDealRemoteDlg.Left := SCREENWIDTH - 236 - 100;
    DDealRemoteDlg.Top := 0;
    DDealDlg.Left := SCREENWIDTH - 236 - 100;
    DDealDlg.Top := DDealRemoteDlg.Height - 15;
    DItemBag.Left := 0; //475;
    DItemBag.Top := 0;
    DItemBag.Visible := TRUE;
    DDealDlg.Visible := TRUE;
    DDealRemoteDlg.Visible := TRUE;

    FillCHar(g_DealItems, sizeof(TClientItem) * 10, #0);
    FillCHar(g_DealRemoteItems, sizeof(TClientItem) * 20, #0);
    g_nDealGold := 0;
    g_nDealRemoteGold := 0;
    g_boDealEnd := FALSE;

    //酒捞袍 啊规俊 儡惑捞 乐绰瘤 八荤
    ArrangeItembag;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.OpenDealDlg'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.OPenChallengeDlg;
begin
  try
  FillChar(g_ChallengeItems1, Sizeof(TClientItem) * 4, #0);
  FillChar(g_ChallengeItems, Sizeof(TClientItem) * 4, #0);
  g_nChallengeGold:=0; //抵押金币
  g_nChallengeRemoteGold:=0; //远程抵押金币
  g_nChallengeGameDiamond:=0;//抵押金刚石
  g_nChallengeRemoteGameDiamond:=0;//远程抵押金刚石
  g_nChallengeRemoteChName:='';//远程人物名
  g_boChallengeEnd:=False;
  DWChallenge.Visible:=True;
  except
    DebugOutStr('[Exception] TFrmDlg.OPenChallengeDlg');
  end;
end;


procedure TFrmDlg.CloseDealDlg;
begin
  try //程序自动增加
    DDealDlg.Visible := FALSE;
    DDealRemoteDlg.Visible := FALSE;

    //酒捞袍 啊规俊 儡惑捞 乐绰瘤 八荤
    ArrangeItembag;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.CloseDealDlg'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DDealOkClick(Sender: TObject; X, Y: Integer);
var
  mi: integer;
begin
  try //程序自动增加
    if GetTickCount > g_dwDealActionTick then
    begin
      //CloseDealDlg;
      FrmMain.SendDealEnd;
      g_dwDealActionTick := GetTickCount + 4000;
      g_boDealEnd := TRUE;
      //掉 芒俊辑 付快胶肺 缠绊 乐绰 巴阑 掉芒栏肺 持绰促. 付快胶俊 巢绰 儡惑(汗荤)阑 绝矩促.
      if g_boItemMoving then
      begin
        mi := g_MovingItem.Index;
        if (mi <= -20) and (mi > -30) then
        begin //掉 芒俊辑 柯巴父
          AddDealItem(g_MovingItem.Item);
          g_boItemMoving := FALSE;
          g_MovingItem.Item.S.name := '';
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DDealOkClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DDealCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if GetTickCount > g_dwDealActionTick then
    begin
      CloseDealDlg;
      FrmMain.SendCancelDeal;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DDealCloseClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DDealRemoteDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    with DDealRemoteDlg do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        Font.Color := clWhite;
        TextOut(SurfaceX(Left + 64), SurfaceY(Top + 196 - 65),
          GetGoldStr(g_nDealRemoteGold));
        TextOut(SurfaceX(Left + 59 + (106 - TextWidth(g_sDealWho)) div 2),
          SurfaceY(Top + 3) + 3, g_sDealWho);
        Release;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DDealRemoteDlgDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DDealDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    with DDealDlg do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        Font.Color := clWhite;
        TextOut(SurfaceX(Left + 64), SurfaceY(Top + 196 - 65),
          GetGoldStr(g_nDealGold));
        TextOut(SurfaceX(Left + 59 + (106 - TextWidth(CharName)) div 2),
          SurfaceY(Top + 3) + 3, CharName);
        Release;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DDealDlgDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DealItemReturnBag(mitem: TClientItem);
begin
  try //程序自动增加
    if not g_boDealEnd then
    begin
      g_DealDlgItem := mitem;
      FrmMain.SendDelDealItem(g_DealDlgItem);
      g_dwDealActionTick := GetTickCount + 4000;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DealItemReturnBag'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DDGridGridSelect(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
  temp: TClientItem;
  mi, idx: integer;
begin
  try //程序自动增加
    if not g_boDealEnd and (GetTickCount > g_dwDealActionTick) then
    begin
      if not g_boItemMoving then
      begin
        idx := ACol + ARow * DDGrid.ColCount;
        if idx in [0..9] then
          if g_DealItems[idx].S.Name <> '' then
          begin
            g_boItemMoving := TRUE;
            g_MovingItem.Index := -idx - 20;
            g_MovingItem.Item := g_DealItems[idx];
            g_MovingItem.Hero := False;
            g_DealItems[idx].S.Name := '';
            ItemClickSound(g_MovingItem.Item.S);
          end;
      end
      else
      begin
        mi := g_MovingItem.Index;
        if (mi >= 0) or (mi <= -20) and (mi > -30) then
        begin //啊规,俊辑 柯巴父
          ItemClickSound(g_MovingItem.Item.S);
          g_boItemMoving := FALSE;
          if mi >= 0 then
          begin
            g_DealDlgItem := g_MovingItem.Item;
            //辑滚俊 搬苞甫 扁促府绰悼救 焊包
            FrmMain.SendAddDealItem(g_DealDlgItem);
            g_dwDealActionTick := GetTickCount + 4000;
          end
          else
            AddDealItem(g_MovingItem.Item);
          g_MovingItem.Item.S.name := '';
        end;
        if mi = -98 then
          DDGoldClick(self, 0, 0);
      end;
      ArrangeItemBag;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DDGridGridSelect'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DDGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
var
  idx,n: integer;
  d: TDirectDrawSurface;
  sText:String;
begin
  try //程序自动增加
    idx := ACol + ARow * DDGrid.ColCount;
    if idx in [0..9] then
    begin
      if g_DealItems[idx].S.Name <> '' then
      begin
        d := FrmMain.GetWBagItemImg(g_DealItems[idx].S.Looks);
        if d <> nil then
          with DDGrid do
          begin
            dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
              d.ClientRect,
              d, TRUE);
              if (g_DealItems[idx].Dura>1) and (g_DealItems[idx].S.StdMode=0) then
               begin
                 sText:=IntToStr(g_DealItems[idx].Dura);
                 n := dsurface.Canvas.TextWidth(sText);
                 SetBkMode(dsurface.Canvas.Handle,TRANSPARENT);
                 dsurface.Canvas.Font.Color := clWhite;
                 dsurface.Canvas.Font.Style:=[fsBold];
                 dsurface.Canvas.TextOut(SurfaceX(Rect.Left + d.Width-n),SurfaceY(Rect.Top),sText);
                 dsurface.Canvas.Font.Style:=dsurface.Canvas.Font.Style-[fsBold];
                 dsurface.Canvas.Release;
               end;
          end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DDGridGridPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DDGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
  idx: integer;
begin
  try //程序自动增加
    idx := ACol + ARow * DDGrid.ColCount;
    if idx in [0..9] then
    begin
      g_MouseItem := g_DealItems[idx];
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DDGridGridMouseMove'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DDRGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
var
  idx,n: integer;
  d: TDirectDrawSurface;
  sText:String;
begin
  try //程序自动增加
    idx := ACol + ARow * DDRGrid.ColCount;
    if idx in [0..19] then
    begin
      if g_DealRemoteItems[idx].S.Name <> '' then
      begin
        d := FrmMain.GetWBagItemImg(g_DealRemoteItems[idx].S.Looks);
        if d <> nil then
          with DDRGrid do
          begin
            dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
              d.ClientRect,
              d, TRUE);
              if (g_DealRemoteItems[idx].Dura>1) and (g_DealRemoteItems[idx].S.StdMode=0) then
               begin
                 sText:=IntToStr(g_DealRemoteItems[idx].Dura);
                 n := dsurface.Canvas.TextWidth(sText);
                 SetBkMode(dsurface.Canvas.Handle,TRANSPARENT);
                 dsurface.Canvas.Font.Color := clWhite;
                 dsurface.Canvas.Font.Style:=[fsBold];
                 dsurface.Canvas.TextOut(SurfaceX(Rect.Left + d.Width-n),SurfaceY(Rect.Top),sText);
                 dsurface.Canvas.Font.Style:=dsurface.Canvas.Font.Style-[fsBold];
                 dsurface.Canvas.Release;
               end;
          end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DDRGridGridPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DDRGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  idx: integer;
begin
  try //程序自动增加
    idx := ACol + ARow * DDRGrid.ColCount;
    if idx in [0..19] then
    begin
      g_MouseItem := g_DealRemoteItems[idx];
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DDRGridGridMouseMove'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DealZeroGold;
begin
  try //程序自动增加
    if not g_boDealEnd and (g_nDealGold > 0) then
    begin
      g_dwDealActionTick := GetTickCount + 4000;
      FrmMain.SendChangeDealGold(0);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DealZeroGold'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DEdit3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
int:integer;
begin
 if Sender=DEdit2 then
 begin
  Int := StrToInt(Trim(DEdit2.Text));
  if (Int > 0) and (Int < 10000) then
  begin
    g_WgInfo.nAutoMagicTime := Int * 1000;
  end;
 end else if Sender=DEdit3 then
   g_WgInfo.boAutoHpCount:=Str_ToInt(Trim(DEdit3.Text),0)
 else if Sender=DEdit4 then
   g_WgInfo.boAutoHpTick:=_MAX(1,Str_ToInt(Trim(DEdit4.Text),0))* 1000
 else if Sender=DEdit5 then
    g_WgInfo.boAutoMpCount:=Str_ToInt(Trim(DEdit5.Text),0)
 else if Sender=DEdit6 then
    g_WgInfo.boAutoMpTick:=Str_ToInt(Trim(DEdit6.Text),0)* 1000
 else if Sender=DEdit7 then
    g_WgInfo.boAutoCropsHpCount:=Str_ToInt(Trim(DEdit7.Text),0)
 else if Sender=DEdit8 then
    g_WgInfo.boAutoCropsHpTick:=_MAX(1,Str_ToInt(Trim(DEdit8.Text),0))* 1000
 else if Sender=DEdit9 then
    g_WgInfo.boAutoHpProtectCount:=Str_ToInt(Trim(DEdit9.Text),0)
 else if Sender=DEdit10 then
    g_WgInfo.boAutoHpOrotectTick:=_MAX(1,Str_ToInt(Trim(DEdit10.Text),0))* 1000
 else if Sender=DEdit11 then
    g_WgInfo.boAutoDrinkCount:=Str_ToInt(Trim(DEdit11.Text),0)
 else if Sender=DEdit12 then
    g_WgInfo.boHeroAutoDrinkCount:=Str_ToInt(Trim(DEdit12.Text),0)
 else if Sender=DEdit13 then
 begin
    g_WgInfo.wHeroMinHPTail:=Str_ToInt(Trim(DEdit13.Text),0);
    Frmmain.SendHeroMinHPTail(Integer(g_WgInfo.wHeroMinHPTail));
 end;
end;

procedure TFrmDlg.DDGoldClick(Sender: TObject; X, Y: Integer);
var
  dgold: integer;
  valstr: string;
begin
  try //程序自动增加
    if g_MySelf = nil then
      exit;
    if not g_boDealEnd and (GetTickCount > g_dwDealActionTick) then
    begin
      if not g_boItemMoving then
      begin
        if g_nDealGold > 0 then
        begin
          PlaySound(s_money);
          g_boItemMoving := TRUE;
          g_MovingItem.Index := -97; //背券 芒俊辑狼 捣
          g_MovingItem.Item.S.Name := g_sGoldName {'金币'};
          g_MovingItem.Hero := False;
        end;
      end
      else
      begin
        if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then
        begin //捣父..
          if (g_MovingItem.Index = -98) then
          begin //啊规芒俊辑 柯 捣
            if g_MovingItem.Item.S.Name = g_sGoldName {'金币'} then
            begin
              //倔付甫 滚副 扒瘤 拱绢夯促.
              DialogSize := 1;
              g_boItemMoving := FALSE;
              g_MovingItem.Item.S.Name := '';
              DMessageDlg('你想支付多少'+ g_sGoldName + '?',
                [mbOk, mbAbort]);
              GetValidStrVal(DlgEditText, valstr, [' ']);
              dgold := Str_ToInt(valstr, 0);
              if (dgold <= (g_nDealGold + g_MySelf.m_nGold)) and (dgold > 0)
                then
              begin
                FrmMain.SendChangeDealGold(dgold);
                g_dwDealActionTick := GetTickCount + 4000;
              end
              else
                dgold := 0;
            end;
          end;
          g_boItemMoving := FALSE;
          g_MovingItem.Item.S.Name := '';
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DDGoldClick'); //程序自动增加
  end; //程序自动增加
end;

{--------------------------------------------------------------}

procedure TFrmDlg.DUserState1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  i, l, m, pgidx, bbx, bby, idx, ax, ay, sex, hair: integer;
  d: TDirectDrawSurface;
  hcolor, keyimg: integer;
  iname, d1, d2, d3,d4: string;
  useable: Boolean;
begin
  try //程序自动增加
    with DUserState1 do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      sex := DRESSfeature(UserState1.Feature) mod 2;
      hair := HAIRfeature(UserState1.Feature);
      if sex = 1 then
        pgidx := 30
      else
        pgidx := 29;
      bbx := Left + 38;
      bby := Top + 52;
      d := g_WMain3Images.Images[pgidx];
      if d <> nil then
        dsurface.Draw(SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);

      bbx := bbx - 7;
      bby := bby + 44;
      //idx := HUMANFRAME * (Hair*2 + Sex+1)-1; //赣府 胶鸥老
      idx := HUMANFRAME * (Hair + 1) - 1;
      if idx > 0 then
      begin
        d := g_WHairImgImages.GetCachedImage(idx, ax, ay);
        if d <> nil then
          dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d,
            TRUE);
      end;

      if UserState1.UseItems[U_DRESS].S.Name <> '' then
      begin
        idx := UserState1.UseItems[U_DRESS].S.Looks;
        //渴 if m_btSex = 1 then idx := 80; //咯磊渴
        if idx >= 0 then
        begin
          //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
          d := FrmMain.GetWStateImg(idx, ax, ay);
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect,
              d, TRUE);
        end;
      end;
      if UserState1.UseItems[U_WEAPON].S.Name <> '' then
      begin
        idx := UserState1.UseItems[U_WEAPON].S.Looks;
        if idx >= 0 then
        begin
          //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
          d := FrmMain.GetWStateImg(idx, ax, ay);
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect,
              d, TRUE);
        end;
      end;
      if UserState1.UseItems[U_STRAW].S.Name <> '' then
      begin
         if UserState1.UseItems[U_STRAW].S.Shape=0 then
           idx := 1188//斗笠
          else
            idx := UserState1.UseItems[U_STRAW].S.Looks;//王者斗笠
          if idx >= 0 then
          begin
            //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
            d := FrmMain.GetWStateImg(idx, ax, ay);
            if d <> nil then
              dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay),
                d.ClientRect, d, TRUE);
          end;
      end
      else
      begin
        if UserState1.UseItems[U_HELMET].S.Name <> '' then
        begin
          idx := UserState1.UseItems[U_HELMET].S.Looks;
          if idx >= 0 then
          begin
            //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
            d := FrmMain.GetWStateImg(idx, ax, ay);
            if d <> nil then
              dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay),
                d.ClientRect, d, TRUE);
          end;
        end;
      end;

      //原为打开，显示其它人物信息里的装备信息，显示在人物下方
      //DScreen.AddChatBoardString ('到了', GetRGB(0), GetRGB(255));
      if g_MouseUserStateItem.S.Name <> '' then
      begin
        //DScreen.AddChatBoardString (g_MouseUserStateItem.S.Name, GetRGB(0), GetRGB(255));
        g_MouseItem := g_MouseUserStateItem;
        GetMouseItemInfo(iname, d1, d2, d3,d4, useable);
        if iname <> '' then
        begin
          if g_MouseItem.Dura = 0 then
            hcolor := clRed
          else
            hcolor := clWhite;
          with dsurface.Canvas do
          begin
            SetBkMode(Handle, TRANSPARENT);
            Font.Color := clYellow;
            TextOut(SurfaceX(Left + 37), SurfaceY(Top + 309), iname);
            Font.Color := hcolor;
            TextOut(SurfaceX(Left + 37 + TextWidth(iname)), SurfaceY(Top + 309),
              d1);
            TextOut(SurfaceX(Left + 37), SurfaceY(Top + 309 + TextHeight('A') +
              2), d2);
            TextOut(SurfaceX(Left + 37), SurfaceY(Top + 309 + (TextHeight('A') +
              2) * 2), d3+d4);
            Release;
          end;
        end;
        g_MouseItem.S.Name := '';
      end;

      //捞抚
      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        Font.Color := UserState1.NameColor;
        TextOut(SurfaceX(Left + 122 - TextWidth(UserState1.UserName) div 2),
          SurfaceY(Top + 23), UserState1.UserName);
        Font.Color := clSilver;
        TextOut(SurfaceX(Left + 45), SurfaceY(Top + 58),
          UserState1.GuildName + ' ' + UserState1.GuildRankName);
        Release;
      end;

    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DUserState1DirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DUserState1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  try //程序自动增加
    X := DUserState1.LocalX(X) - DUserState1.Left;
    Y := DUserState1.LocalY(Y) - DUserState1.Top;
    if (X > 42) and (X < 201) and (Y > 54) and (Y < 71) then
    begin
      //DScreen.AddSysMsg (IntToStr(X) + ' ' + IntToStr(Y) + ' ' + UserState1.GuildName);
      if UserState1.GuildName <> '' then
      begin
        PlayScene.EdChat.Visible := TRUE;
        PlayScene.EdChat.SetFocus;
        SetImeMode(PlayScene.EdChat.Handle, LocalLanguage);
        PlayScene.EdChat.Text := UserState1.GuildName;
        PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
        PlayScene.EdChat.SelLength := 0;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DUserState1MouseDown'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DUserState1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  try //程序自动增加
    g_MouseUserStateItem.S.Name := '';
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DUserState1MouseMove'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DWeaponUS1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  sel: integer;
  iname, d1, d2, d3,d4: string;
  useable: Boolean;
  hcolor: TColor;
begin
  try //程序自动增加
    DScreen.ClearHint;
    sel := -1;
    if Sender = DDressUS1 then
      sel := U_DRESS;
    if Sender = DWeaponUS1 then
      sel := U_WEAPON;
    if Sender = DHelmetUS1 then
      sel := U_HELMET;
    if Sender = DNecklaceUS1 then
      sel := U_NECKLACE;
    if Sender = DLightUS1 then
      sel := U_RIGHTHAND;
    if Sender = DRingLUS1 then
      sel := U_RINGL;
    if Sender = DRingRUS1 then
      sel := U_RINGR;
    if Sender = DArmRingLUS1 then
      sel := U_ARMRINGL;
    if Sender = DArmRingRUS1 then
      sel := U_ARMRINGR;

    if Sender = DBujukUS1 then
      sel := U_BUJUK;
    if Sender = DBeltUS1 then
      sel := U_BELT;
    if Sender = DBootsUS1 then
      sel := U_BOOTS;
    if Sender = DCharmUS1 then
      sel := U_CHARM;

    if sel >= 0 then
    begin
      g_MouseUserStateItem := UserState1.UseItems[sel];
      if (sel = U_HELMET) and (UserState1.UseItems[U_STRAW].MakeIndex > 0) then
      begin
        g_MouseItem := UserState1.UseItems[U_STRAW];
        GetMouseItemInfo(iname, d1, d2, d3,d4, useable);
        if iname <> '' then
        begin
          if UserState1.UseItems[U_STRAW].Dura = 0 then
            hcolor := clRed
          else
            hcolor := clWhite;
          with Sender as TDButton do
            DScreen.ShowHint(SurfaceX(Left + 30),
              SurfaceY(Top - 10),
              iname + '\' + d1 + '\' + d2 + '\' + d3+d4, hcolor, FALSE);
        end;
      end;
      //g_MouseUserStateItem := UserState1.UseItems[sel];
      //原为注释掉 显示人物身上带的物品信息
     { g_MouseItem := UserState1.UseItems[sel];
      GetMouseItemInfo (iname, d1, d2, d3, useable);
      if iname <> '' then begin
         if UserState1.UseItems[sel].Dura = 0 then hcolor := clRed
         else hcolor := clWhite;
         with Sender as TDButton do
            DScreen.ShowHint (SurfaceX(Left - 30),
                              SurfaceY(Top + 50),
                              iname + d1 + '\' + d2 + '\' + d3, hcolor, FALSE);
      end; }
      g_MouseItem.S.Name := '';
      //
    end;

  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DWeaponUS1MouseMove'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DCloseUS1Click(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DUserState1.Visible := FALSE;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DCloseUS1Click'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DNecklaceUS1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  idx: integer;
  d: TDirectDrawSurface;
  ClientItem: TClientItem;
  Button: TDButton;
begin
  try //程序自动增加
    if Sender is TDButton then
    begin
      Button := TDButton(Sender);
      ClientItem.S.Name := '';
      if Sender = DNecklaceUS1 then
        ClientItem := UserState1.UseItems[U_NECKLACE];
      if Sender = DLightUS1 then
        ClientItem := UserState1.UseItems[U_RIGHTHAND];
      if Sender = DArmRingRUS1 then
        ClientItem := UserState1.UseItems[U_ARMRINGR];
      if Sender = DArmRingLUS1 then
        ClientItem := UserState1.UseItems[U_ARMRINGL];
      if Sender = DRingRUS1 then
        ClientItem := UserState1.UseItems[U_RINGR];
      if Sender = DRingLUS1 then
        ClientItem := UserState1.UseItems[U_RINGL];
      if Sender = DBujukUS1 then
        ClientItem := UserState1.UseItems[U_BUJUK];
      if Sender = DBeltUS1 then
        ClientItem := UserState1.UseItems[U_BELT];
      if Sender = DBootsUS1 then
        ClientItem := UserState1.UseItems[U_BOOTS];
      if Sender = DCharmUS1 then
        ClientItem := UserState1.UseItems[U_CHARM];
      if ClientItem.S.Name <> '' then
      begin
        idx := ClientItem.S.Looks;
        d := FrmMain.GetWStateImg(idx);
        if d <> nil then
          dsurface.Draw(Button.SurfaceX(Button.Left + (Button.Width - d.Width)
            div 2),
            Button.SurfaceY(Button.Top + (Button.Height - d.Height) div 2),
            d.ClientRect, d, TRUE);
        if ClientItem.Shine <> 0 then
        begin
          d := g_WMain2Images.Images[260 + m_LightIdx];
          if d <> nil then
            DrawBlend(dsurface,
              Button.SurfaceX(Button.Left - 21),
              Button.SurfaceY(Button.Top - 23),
              d, 1);
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DNecklaceUS1DirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.ShowGuildDlg;
begin
  try //程序自动增加
    DGuildDlg.Visible := TRUE; //not DGuildDlg.Visible;
    DGuildDlg.Top := -3;
    DGuildDlg.Left := 0;
    if DGuildDlg.Visible then
    begin
      if GuildCommanderMode then
      begin
        DGDAddMem.Visible := TRUE;
        DGDDelMem.Visible := TRUE;
        DGDEditNotice.Visible := TRUE;
        DGDEditGrade.Visible := TRUE;
        DGDAlly.Visible := TRUE;
        DGDBreakAlly.Visible := TRUE;
        DGDWar.Visible := TRUE;
        DGDCancelWar.Visible := TRUE;
      end
      else
      begin
        DGDAddMem.Visible := FALSE;
        DGDDelMem.Visible := FALSE;
        DGDEditNotice.Visible := FALSE;
        DGDEditGrade.Visible := FALSE;
        DGDAlly.Visible := FALSE;
        DGDBreakAlly.Visible := FALSE;
        DGDWar.Visible := FALSE;
        DGDCancelWar.Visible := FALSE;
      end;

    end;
    GuildTopLine := 0;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.ShowGuildDlg'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.ShowGuildEditNotice;
var
  d: TDirectDrawSurface;
  i: integer;
  data: string;
begin
  try //程序自动增加
    with DGuildEditNotice do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
      begin
        Left := (SCREENWIDTH - d.Width) div 2;
        Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      HideAllControls;
      DGuildEditNotice.ShowModal;

      Memo.Left := SurfaceX(Left + 16);
      Memo.Top := SurfaceY(Top + 36);
      Memo.Width := 571;
      Memo.Height := 246;
      Memo.Lines.Assign(GuildNotice);
      Memo.Visible := TRUE;

      while TRUE do
      begin
        if not DGuildEditNotice.Visible then
          break;
        FrmMain.ProcOnIdle;
        Application.ProcessMessages;
        if Application.Terminated then
          exit;
      end;

      DGuildEditNotice.Visible := FALSE;
      RestoreHideControls;

      if DMsgDlg.DialogResult = mrOk then
      begin
        data := '';
        for i := 0 to Memo.Lines.Count - 1 do
        begin
          if Memo.Lines[i] = '' then
            data := data + Memo.Lines[i] + ' '#13
          else
            data := data + Memo.Lines[i] + #13;
        end;
        if Length(data) > 4000 then
        begin
          data := Copy(data, 1, 4000);
          DMessageDlg('由于句子太长，最后的部分被移除了.',
            [mbOk]);
        end;
        FrmMain.SendGuildUpdateNotice(data, 0);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.ShowGuildEditNotice'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.ShowGuildEditGrade;
var
  d: TDirectDrawSurface;
  data: string;
  i: integer;
begin
  try //程序自动增加
    if GuildMembers.Count <= 0 then
    begin
      DMessageDlg('请点击[名单]按扭以调出行会成员列表.',
        [mbOk]);
      exit;
    end;

    with DGuildEditNotice do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
      begin
        Left := (SCREENWIDTH - d.Width) div 2;
        Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      HideAllControls;
      DGuildEditNotice.ShowModal;

      Memo.Left := SurfaceX(Left + 16);
      Memo.Top := SurfaceY(Top + 36);
      Memo.Width := 571;
      Memo.Height := 246;
      Memo.Lines.Assign(GuildMembers);
      Memo.Visible := TRUE;

      while TRUE do
      begin
        if not DGuildEditNotice.Visible then
          break;
        FrmMain.ProcOnIdle;
        Application.ProcessMessages;
        if Application.Terminated then
          exit;
      end;

      DGuildEditNotice.Visible := FALSE;
      RestoreHideControls;

      if DMsgDlg.DialogResult = mrOk then
      begin
        //GuildMembers.Assign (Memo.Lines);
        //搬苞... 巩颇殿鞭阑 诀单捞飘 茄促.
        data := '';
        for i := 0 to Memo.Lines.Count - 1 do
        begin
          data := data + Memo.Lines[i] + #13; //辑滚俊辑 颇教窃.
        end;
        if Length(data) > 6000 then
        begin
          data := Copy(data, 1, 6000);
          DMessageDlg('由于句子太长，最后的部分被移除了.',
            [mbOk]);
        end;
        FrmMain.SendGuildUpdateGrade(data);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.ShowGuildEditGrade'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGuildDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  i, n, bx, by: integer;
begin
  try //程序自动增加
    with DGuildDlg do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        Font.Color := clWhite;
        TextOut(Left + 320, Top + 13, Guild);

        bx := Left + 24;
        by := Top + 41;
        for i := GuildTopLine to GuildStrs.Count - 1 do
        begin
          n := i - GuildTopLine;
          if n * 14 > 356 then
            break;
          if Integer(GuildStrs.Objects[i]) <> 0 then
            Font.Color := TColor(GuildStrs.Objects[i])
          else
          begin
            if BoGuildChat then
              Font.Color := GetRGB(2)
            else
              Font.Color := clSilver;
          end;
          TextOut(bx, by + n * 14, GuildStrs[i]);
        end;

        Release;
      end;

    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGuildDlgDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGDUpClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if GuildTopLine > 0 then
      Dec(GuildTopLine, 3);
    if GuildTopLine < 0 then
      GuildTopLine := 0;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGDUpClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGDDownClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if GuildTopLine + 12 < GuildStrs.Count then
      Inc(GuildTopLine, 3);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGDDownClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGDCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DGuildDlg.Visible := FALSE;
    BoGuildChat := FALSE;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGDCloseClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGDHomeClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if GetTickCount > g_dwQueryMsgTick then
    begin
      g_dwQueryMsgTick := GetTickCount + 3000;
      FrmMain.SendGuildHome;
      BoGuildChat := FALSE;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGDHomeClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGDListClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if GetTickCount > g_dwQueryMsgTick then
    begin
      g_dwQueryMsgTick := GetTickCount + 3000;
      FrmMain.SendGuildMemberList;
      BoGuildChat := FALSE;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGDListClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGDAddMemClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DMessageDlg('[' + Guild + '] 输入你想加为行会成员的角色名。',
      [mbOk, mbAbort]);
    if DlgEditText <> '' then
      FrmMain.SendGuildAddMem(DlgEditText);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGDAddMemClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGDDelMemClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DMessageDlg('[' + Guild + '] 输入你想从行会中删除的角色名。',
      [mbOk, mbAbort]);
    if DlgEditText <> '' then
      FrmMain.SendGuildDelMem(DlgEditText);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGDDelMemClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGDEditNoticeClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    GuildEditHint := '[修改行会公告内容]';
    ShowGuildEditNotice;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGDEditNoticeClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGDEditGradeClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    GuildEditHint :=
      '[修改行会成员的等级和职位。#警告：不能 增加/删除 行会成员。]';
    ShowGuildEditGrade;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGDEditGradeClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGDAllyClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if mrOk =
      DMessageDlg('和对方行会结盟应该在 [允许结盟] 的状态下。\'
      +
      '而且你应该面对对方行会首领。\' +
      '你想结盟吗？', [mbOk, mbCancel]) then
      FrmMain.SendSay('@联盟');
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGDAllyClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGDBreakAllyClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DMessageDlg('请输入你想取消结盟的行会的名字。', [mbOk,
      mbAbort]);
    if DlgEditText <> '' then
      FrmMain.SendSay('@取消联盟 ' + DlgEditText);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGDBreakAllyClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGuildEditNoticeDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    with DGuildEditNotice do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        Font.Color := clSilver;

        TextOut(Left + 18, Top + 291, GuildEditHint);
        Release;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGuildEditNoticeDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGECloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DGuildEditNotice.Visible := FALSE;
    Memo.Visible := FALSE;
    DMsgDlg.DialogResult := mrCancel;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGECloseClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGEOkClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DGECloseClick(self, 0, 0);
    DMsgDlg.DialogResult := mrOk;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGEOkClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.AddGuildChat(str: string);
var
  i: integer;
begin
  try //程序自动增加
    GuildChats.Add(str);
    if GuildChats.Count > 500 then
    begin
      for i := 0 to 100 do
        GuildChats.Delete(0);
    end;
    if BoGuildChat then
      GuildStrs.Assign(GuildChats);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.AddGuildChat'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGDChatClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    BoGuildChat := not BoGuildChat;
    if BoGuildChat then
    begin
      GuildStrs2.Assign(GuildStrs);
      GuildStrs.Assign(GuildChats);
    end
    else
      GuildStrs.Assign(GuildStrs2);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGDChatClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGoldDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    if g_MySelf = nil then
      exit;
    with DGold do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGoldDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

{--------------------------------------------------------------}
//瓷仿摹 炼沥 芒

procedure TFrmDlg.DAdjustAbilCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DAdjustAbility.Visible := FALSE;
    g_nBonusPoint := g_nSaveBonusPoint;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DAdjustAbilCloseClick');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DAdjustAbilityDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  procedure AdjustAb(abil: byte; val: word; var lov, hiv: Word);
  var
    lo, hi: byte;
    i: integer;
  begin
    lo := Lobyte(abil);
    hi := Hibyte(abil);
    lov := 0;
    hiv := 0;
    for i := 1 to val do
    begin
      if lo + 1 < hi then
      begin
        Inc(lo);
        Inc(lov);
      end
      else
      begin
        Inc(hi);
        Inc(hiv);
      end;
    end;
  end;
var
  d: TDirectDrawSurface;
  l, m, adc, amc, asc, aac, amac: integer;
  ldc, lmc, lsc, lac, lmac, hdc, hmc, hsc, hac, hmac: Word;
begin
  try //程序自动增加
    if g_MySelf = nil then
      exit;
    with dsurface.Canvas do
    begin
      with DAdjustAbility do
      begin
        d := DMenuDlg.WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      SetBkMode(Handle, TRANSPARENT);
      Font.Color := clSilver;

      l := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 36;
      m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 22;

      TextOut(l, m, '恭喜：你已经到了下一个等级了!.');
      TextOut(l, m + 14, '选择你想要提高的能力。');
      TextOut(l, m + 14 * 2, '这样做的选择你只可以做一次。');
      TextOut(l, m + 14 * 3, '最好能很小心的选择。');

      Font.Color := clWhite;
      //泅犁狼 瓷仿摹
      l := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 100; //66;
      m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 101;

      adc := (g_BonusAbil.DC + g_BonusAbilChg.DC) div g_BonusTick.DC;
      amc := (g_BonusAbil.MC + g_BonusAbilChg.MC) div g_BonusTick.MC;
      asc := (g_BonusAbil.SC + g_BonusAbilChg.SC) div g_BonusTick.SC;
      aac := (g_BonusAbil.AC + g_BonusAbilChg.AC) div g_BonusTick.AC;
      amac := (g_BonusAbil.MAC + g_BonusAbilChg.MAC) div g_BonusTick.MAC;

      {adc := (g_BonusAbilChg.DC) div g_BonusTick.DC;
      amc := (g_BonusAbilChg.MC) div g_BonusTick.MC;
      asc := (g_BonusAbilChg.SC) div g_BonusTick.SC;
      aac := (g_BonusAbilChg.AC) div g_BonusTick.AC;
      amac := (g_BonusAbilChg.MAC) div g_BonusTick.MAC;}

      AdjustAb(g_NakedAbil.DC, adc, ldc, hdc);
      AdjustAb(g_NakedAbil.MC, amc, lmc, hmc);
      AdjustAb(g_NakedAbil.SC, asc, lsc, hsc);
      AdjustAb(g_NakedAbil.AC, aac, lac, hac);
      AdjustAb(g_NakedAbil.MAC, amac, lmac, hmac);
      //lac  := 0;  hac := aac;
      //lmac := 0;  hmac := amac;

      TextOut(l + 0, m + 0, IntToStr(LoWord(g_MySelf.m_Abil.DC) + ldc) + '-' +
        IntToStr(HiWord(g_MySelf.m_Abil.DC) + hdc));
      TextOut(l + 0, m + 20, IntToStr(LoWord(g_MySelf.m_Abil.MC) + lmc) + '-' +
        IntToStr(HiWord(g_MySelf.m_Abil.MC) + hmc));
      TextOut(l + 0, m + 40, IntToStr(LoWord(g_MySelf.m_Abil.SC) + lsc) + '-' +
        IntToStr(HiWord(g_MySelf.m_Abil.SC) + hsc));
      TextOut(l + 0, m + 60, IntToStr(LoWord(g_MySelf.m_Abil.AC) + lac) + '-' +
        IntToStr(HiWord(g_MySelf.m_Abil.AC) + hac));
      TextOut(l + 0, m + 80, IntToStr(LoWord(g_MySelf.m_Abil.MAC) + lmac) + '-'
        + IntToStr(HiWord(g_MySelf.m_Abil.MAC) + hmac));
      TextOut(l + 0, m + 100, IntToStr(g_MySelf.m_Abil.MaxHP + (g_BonusAbil.HP +
        g_BonusAbilChg.HP) div g_BonusTick.HP));
      TextOut(l + 0, m + 120, IntToStr(g_MySelf.m_Abil.MaxMP + (g_BonusAbil.MP +
        g_BonusAbilChg.MP) div g_BonusTick.MP));
      TextOut(l + 0, m + 140, IntToStr(g_nMyHitPoint + (g_BonusAbil.Hit +
        g_BonusAbilChg.Hit) div g_BonusTick.Hit));
      TextOut(l + 0, m + 160, IntToStr(g_nMySpeedPoint + (g_BonusAbil.Speed +
        g_BonusAbilChg.Speed) div g_BonusTick.Speed));

      Font.Color := clYellow;
      TextOut(l + 0, m + 180, IntToStr(g_nBonusPoint));

      Font.Color := clWhite;
      l := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 155; //66;
      m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 101;

      if g_BonusAbilChg.DC > 0 then
        Font.Color := clWhite
      else
        Font.Color := clSilver;
      TextOut(l + 0, m + 0, IntToStr(g_BonusAbilChg.DC + g_BonusAbil.DC) + '/' +
        IntToStr(g_BonusTick.DC));

      if g_BonusAbilChg.MC > 0 then
        Font.Color := clWhite
      else
        Font.Color := clSilver;
      TextOut(l + 0, m + 20, IntToStr(g_BonusAbilChg.MC + g_BonusAbil.MC) + '/'
        + IntToStr(g_BonusTick.MC));

      if g_BonusAbilChg.SC > 0 then
        Font.Color := clWhite
      else
        Font.Color := clSilver;
      TextOut(l + 0, m + 40, IntToStr(g_BonusAbilChg.SC + g_BonusAbil.SC) + '/'
        + IntToStr(g_BonusTick.SC));

      if g_BonusAbilChg.AC > 0 then
        Font.Color := clWhite
      else
        Font.Color := clSilver;
      TextOut(l + 0, m + 60, IntToStr(g_BonusAbilChg.AC + g_BonusAbil.AC) + '/'
        + IntToStr(g_BonusTick.AC));

      if g_BonusAbilChg.MAC > 0 then
        Font.Color := clWhite
      else
        Font.Color := clSilver;
      TextOut(l + 0, m + 80, IntToStr(g_BonusAbilChg.MAC + g_BonusAbil.MAC) + '/'
        + IntToStr(g_BonusTick.MAC));

      if g_BonusAbilChg.HP > 0 then
        Font.Color := clWhite
      else
        Font.Color := clSilver;
      TextOut(l + 0, m + 100, IntToStr(g_BonusAbilChg.HP + g_BonusAbil.HP) + '/'
        + IntToStr(g_BonusTick.HP));

      if g_BonusAbilChg.MP > 0 then
        Font.Color := clWhite
      else
        Font.Color := clSilver;
      TextOut(l + 0, m + 120, IntToStr(g_BonusAbilChg.MP + g_BonusAbil.MP) + '/'
        + IntToStr(g_BonusTick.MP));

      if g_BonusAbilChg.Hit > 0 then
        Font.Color := clWhite
      else
        Font.Color := clSilver;
      TextOut(l + 0, m + 140, IntToStr(g_BonusAbilChg.Hit + g_BonusAbil.Hit) +
        '/' + IntToStr(g_BonusTick.Hit));

      if g_BonusAbilChg.Speed > 0 then
        Font.Color := clWhite
      else
        Font.Color := clSilver;
      TextOut(l + 0, m + 160, IntToStr(g_BonusAbilChg.Speed + g_BonusAbil.Speed)
        + '/' + IntToStr(g_BonusTick.Speed));

      Release;
    end;

  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DAdjustAbilityDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DPlusDCClick(Sender: TObject; X, Y: Integer);
var
  incp: integer;
begin
  try //程序自动增加
    if g_nBonusPoint > 0 then
    begin
      if IsKeyPressed(VK_CONTROL) and (g_nBonusPoint > 10) then
        incp := 10
      else
        incp := 1;
      Dec(g_nBonusPoint, incp);
      if Sender = DPlusDC then
        Inc(g_BonusAbilChg.DC, incp);
      if Sender = DPlusMC then
        Inc(g_BonusAbilChg.MC, incp);
      if Sender = DPlusSC then
        Inc(g_BonusAbilChg.SC, incp);
      if Sender = DPlusAC then
        Inc(g_BonusAbilChg.AC, incp);
      if Sender = DPlusMAC then
        Inc(g_BonusAbilChg.MAC, incp);
      if Sender = DPlusHP then
        Inc(g_BonusAbilChg.HP, incp);
      if Sender = DPlusMP then
        Inc(g_BonusAbilChg.MP, incp);
      if Sender = DPlusHit then
        Inc(g_BonusAbilChg.Hit, incp);
      if Sender = DPlusSpeed then
        Inc(g_BonusAbilChg.Speed, incp);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DPlusDCClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DMiniMapDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
resourcestring
  stext1 = '左键放大，右键寻路';
  stext2 = '  左键点击缩小(或M键),右键按下自动寻路';
var
  d: TDirectDrawSurface;
  mx, my, i: integer;
  dc, rc: TRect;
  actor: TActor;
  x, y, cX, cY: integer;
  btColor: Byte;
  TempStr: string;
begin
  if g_MySelf = nil then
    Exit;
  with DMiniMapDlg do
  begin
    d := nil;
    if GetTickCount > m_dwBlinkTime + 300 then
    begin
      m_dwBlinkTime := GetTickCount;
      m_boViewBlink := not m_boViewBlink;
    end;
    if g_nMiniMapIndex < 0 then
      exit; //Jacky
    if g_nMiniMapIndex > 100000 then
    begin
      I := g_nMiniMapIndex - 100000;
      case I of
        301: d := g_UIBImages.Images[12];
        302..310: d := g_UIBImages.Images[I - 275];
      end;
    end
    else
      d := FrmMain.GetWMMapImg(g_nMiniMapIndex);
    if d = nil then
    begin
      Visible := False;
      exit;
    end;
    cx := -1;
    cy := 0;
    if g_nViewMinMapLv = 1 then
    begin
      mx := (g_MySelf.m_nCurrX * 48) div 32;
      my := (g_MySelf.m_nCurrY * 32) div 32;
      rc.Left := _MAX(0, mx - 60);
      rc.Top := _MAX(0, my - 60);
      rc.Right := _MIN(d.ClientRect.Right, rc.Left + Width);
      rc.Bottom := _MIN(d.ClientRect.Bottom, rc.Top + Height);
      dsurface.Draw(Left, Top, rc, d, FALSE);
      if g_nMiniMapX >= 0 then
      begin
        cX := (g_nMiniMapX + rc.Left - (SCREENWIDTH - 120)) * 32 div 48;
        cy := (g_nMiniMapY + rc.Top) * 32 div 32;
      end;
      for I := 0 to PlayScene.m_ActorList.Count - 1 do
      begin
        actor := TActor(PlayScene.m_ActorList.Items[I]);
        if (actor <> nil) and
          (actor <> g_MySelf) and
          (not actor.m_boDeath) and
          (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) < 12) and
          (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) < 12) then
        begin
          mx := (SCREENWIDTH - 120) + (actor.m_nCurrX * 48) div 32 - rc.Left;
          my := (actor.m_nCurrY * 32) div 32 - rc.Top;
          case actor.m_btRace of //
            50, 12: btColor := 215;
            0: btColor := 151;
          else
            btColor := 249;
          end;
          for x := -1 to 1 do
            for y := -1 to 1 do
            begin
              //if g_boFullScreen then
              dsurface.Pixels[mx + X, my + Y] := btColor
                //else
                //dsurface.Pixels[mx + X, my + Y] := GetRGBEx(btColor);//GetRGB(btColor);
            end;

        end;
      end;

      if not m_boViewBlink then
      begin
        mx := (SCREENWIDTH - 120) + (g_MySelf.m_nCurrX * 48) div 32 - rc.Left;
        my := (g_MySelf.m_nCurrY * 32) div 32 - rc.Top;
        for x := -1 to 1 do
          for y := -1 to 1 do
            dsurface.Pixels[mx + x, my + y] := Integer($FFFFFFFF);
      end;
    end
    else if g_nViewMinMapLv = 2 then
    begin
      dc.Left := DMiniMapDlg.Left;
      dc.Top := DMiniMapDlg.Top;
      dc.Right := SCREENWIDTH;
      dc.Bottom := Height;
      rc.Left := 0;
      rc.Top := 0;
      rc.Right := d.ClientRect.Right;
      rc.Bottom := d.ClientRect.Bottom;

      dsurface.StretchDraw(dc, rc, d, False);

      if g_nMiniMapX >= 0 then
      begin
        cX := (g_nMiniMapX - dc.Left) * 32 * d.ClientRect.Right div Width div
          48;
        cy := g_nMiniMapY * d.ClientRect.Bottom div Height;
      end;
      for I := 0 to PlayScene.m_ActorList.Count - 1 do
      begin
        actor := TActor(PlayScene.m_ActorList.Items[I]);
        if (actor <> nil) and
          (actor <> g_MySelf) and
          (not actor.m_boDeath) and
          (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) < 12) and
          (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) < 12) then
        begin

          mx := dc.Left + Trunc((actor.m_nCurrX * 48) * (Width /
            d.ClientRect.Right)) div 32;
          my := Trunc(actor.m_nCurrY * (Height / d.ClientRect.Bottom));
          case actor.m_btRace of
            50, 12: btColor := 215;
            0: btColor := 151;
          else
            btColor := 249;
          end;
          for x := -1 to 1 do
            for y := -1 to 1 do
            begin
              //if g_boFullScreen then
              dsurface.Pixels[mx + X, my + Y] := btColor
                //else
                //dsurface.Pixels[mx + X, my + Y] := GetRGBEX(btColor);//GetRGB(btColor);
            end;

        end;
      end;
      if not m_boViewBlink then
      begin
        SetBkMode(dsurface.Canvas.Handle, TRANSPARENT);
        if (g_nMiniMapPath <> nil) and (High(g_nMiniMapPath) > 2) then
        begin
          dsurface.Canvas.Pen.Color := clRed;
          mx := dc.Left + Trunc((g_nMiniMapPath[0].X * 48) * (Width /
            d.ClientRect.Right)) div 32;
          my := Trunc(g_nMiniMapPath[0].Y * (Height / d.ClientRect.Bottom));
          dsurface.Canvas.MoveTo(mx, my);
          for I := Low(g_nMiniMapPath) to High(g_nMiniMapPath) do
          begin
            mx := dc.Left + Trunc((g_nMiniMapPath[I].X * 48) * (Width /
              d.ClientRect.Right)) div 32;
            my := Trunc(g_nMiniMapPath[I].Y * (Height / d.ClientRect.Bottom));
            dsurface.Canvas.LineTo(mx, my);
          end;
        end;
        mx := dc.Left + Trunc((g_MySelf.m_nCurrX * 48) * (Width /
          d.ClientRect.Right)) div 32;
        my := Trunc(g_MySelf.m_nCurrY * (Height / d.ClientRect.Bottom));
        dsurface.Canvas.Release;
        for x := -1 to 1 do
          for y := -1 to 1 do
            dsurface.Pixels[mx + x, my + y] := Integer($FFFFFFFF);
      end;
    end;

    //显示坐标
    TempStr := '';
    if cx > -1 then
    begin
      g_nMiniMapMosX := cX;
      g_nMiniMapMosY := cY;
      TempStr := Format('坐标(%d,%d)', [cx, cy]);
      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        if g_nMiniMaxShow then
        begin
          TempStr := TempStr + stext2;
          BoldTextOut(dsurface,
            Left { + (Width div 2) - (dsurface.Canvas.TextWidth(TempStr) div 2)},
            Top,
            clLime,
            clBlack,
            TempStr);
        end
        else
        begin
          BoldTextOut(dsurface,
            Left + (Width div 2) - (TextWidthAndHeight(dsurface.Canvas.Handle,stext1).cx{dsurface.Canvas.TextWidth(stext1)} div 2),
            Top,
            clLime,
            clBlack,
            stext1);
          if TempStr <> '' then
            BoldTextOut(dsurface,
              Left + (Width -TextWidthAndHeight(dsurface.Canvas.Handle,TempStr).cx{dsurface.Canvas.TextWidth(TempStr)}),
              Height - 14,
              clwhite,
              clBlack,
              TempStr);
        end;
        Release;
      end;
    end;
  end;
  //
end;

procedure TFrmDlg.DMiniMapDlgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
  begin
    g_nViewMinMapLv := 2;
    if g_nMiniMaxShow then
      SetMiniMapSize(2)
    else
      SetMiniMapSize(3);
  end
  else if (ssRight in Shift) and (g_nViewMinMapLv = 2) then
  begin
    g_nMiniMapPath := FindPath(g_nMiniMapMosX, g_nMiniMapMosY);
    if High(g_nMiniMapPath) > 2 then
    begin
      g_boAutoMoveing := False;
      DScreen.AddChatBoardString(Format('设置自动移动终点成功(%d,%d)，使用Ctrl + Z 开始移动！', [g_nMiniMapMosX, g_nMiniMapMosY]), GetRGB(180), clWhite);
      //DScreen.AddChatBoardString(Format('设置自动移动终点成功(%d/%d)，使用Ctrl + Z 开始移动！',[g_nMiniMapPath[high(g_nMiniMapPath)].X,g_nMiniMapPath[high(g_nMiniMapPath)].Y]),GetRGB(180), clWhite);
    end
    else
    begin
      DScreen.AddChatBoardString('设置自动移动终点失败，无法到达终点！', GetRGB(56), clWhite);
    end;
  end;

end;

procedure TFrmDlg.DMiniMapDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  g_nMiniMapX := X;
  g_nMiniMapY := Y;
end;

procedure TFrmDlg.DMinusDCClick(Sender: TObject; X, Y: Integer);
var
  decp: integer;
begin
  try //程序自动增加
    if IsKeyPressed(VK_CONTROL) and (g_nBonusPoint - 10 > 0) then
      decp := 10
    else
      decp := 1;
    if Sender = DMinusDC then
      if g_BonusAbilChg.DC >= decp then
      begin
        Dec(g_BonusAbilChg.DC, decp);
        Inc(g_nBonusPoint, decp);
      end;
    if Sender = DMinusMC then
      if g_BonusAbilChg.MC >= decp then
      begin
        Dec(g_BonusAbilChg.MC, decp);
        Inc(g_nBonusPoint, decp);
      end;
    if Sender = DMinusSC then
      if g_BonusAbilChg.SC >= decp then
      begin
        Dec(g_BonusAbilChg.SC, decp);
        Inc(g_nBonusPoint, decp);
      end;
    if Sender = DMinusAC then
      if g_BonusAbilChg.AC >= decp then
      begin
        Dec(g_BonusAbilChg.AC, decp);
        Inc(g_nBonusPoint, decp);
      end;
    if Sender = DMinusMAC then
      if g_BonusAbilChg.MAC >= decp then
      begin
        Dec(g_BonusAbilChg.MAC, decp);
        Inc(g_nBonusPoint, decp);
      end;
    if Sender = DMinusHP then
      if g_BonusAbilChg.HP >= decp then
      begin
        Dec(g_BonusAbilChg.HP, decp);
        Inc(g_nBonusPoint, decp);
      end;
    if Sender = DMinusMP then
      if g_BonusAbilChg.MP >= decp then
      begin
        Dec(g_BonusAbilChg.MP, decp);
        Inc(g_nBonusPoint, decp);
      end;
    if Sender = DMinusHit then
      if g_BonusAbilChg.Hit >= decp then
      begin
        Dec(g_BonusAbilChg.Hit, decp);
        Inc(g_nBonusPoint, decp);
      end;
    if Sender = DMinusSpeed then
      if g_BonusAbilChg.Speed >= decp then
      begin
        Dec(g_BonusAbilChg.Speed, decp);
        Inc(g_nBonusPoint, decp);
      end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMinusDCClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DAdjustAbilOkClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    FrmMain.SendAdjustBonus(g_nBonusPoint, g_BonusAbilChg);
    g_BonusAbil.DC := g_BonusAbil.DC + g_BonusAbilChg.DC;
    g_BonusAbil.MC := g_BonusAbil.MC + g_BonusAbilChg.MC;
    g_BonusAbil.SC := g_BonusAbil.SC + g_BonusAbilChg.SC;
    g_BonusAbil.AC := g_BonusAbil.AC + g_BonusAbilChg.AC;
    g_BonusAbil.MAC := g_BonusAbil.MAC + g_BonusAbilChg.MAC;
    DAdjustAbility.Visible := FALSE;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DAdjustAbilOkClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DAdjustAbilityMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  i, lx, ly: integer;
  flag: Boolean;
begin
  try //程序自动增加
    with DAdjustAbility do
    begin
      lx := LocalX(X - Left);
      ly := LocalY(Y - Top);
      flag := FALSE;
      if (lx >= 50) and (lx < 150) then
        for i := 0 to 8 do
        begin //DC,MC,SC..狼 腮飘啊 唱坷霸 茄促.
          if (ly >= 98 + i * 20) and (ly < 98 + (i + 1) * 20) then
          begin
            DScreen.ShowHint(SurfaceX(Left) + lx + 10,
              SurfaceY(Top) + ly + 5,
              AdjustAbilHints[i],
              clWhite,
              FALSE);
            flag := TRUE;
            break;
          end;
        end;
      if not flag then
        DScreen.ClearHint;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DAdjustAbilityMouseMove');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotSysCRYMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
//  nLocalX, nLocalY: Integer;
//  nHintX, nHintY: Integer;
  Butt: TDButton;
  sMsg: string;
begin
  try //程序自动增加
    if not (Sender is TDButton) then
    begin
      DScreen.ClearHint;
      exit;
    end;
    Butt := TDButton(Sender);
    if Sender = DBotMiniMap then
      sMsg := '小地图';
    if Sender = DBotTrade then
      sMsg := '物品交易';
    if Sender = DBotGuild then
      sMsg := '行会信息';
    if Sender = DBotGroup then
      sMsg := '组队控制';
    //if Sender = DBotPlusAbil then sMsg:= 'Ability(M)';
    if Sender = DBotFriend then
      sMsg := '关系系统';
    if Sender = DBotChallenge then
      sMsg := '挑战';
    if Sender = DBotTop then
      sMsg := '排行榜';
    if Sender = DBotMemo then
      sMsg := '商铺';
    if Sender = DBuHelp then
      sMsg := '帮助';
    if Sender = DButHorse then
      sMsg := '骑马';
    if Sender = DBotLogout then
      sMsg := '小退(Alt-X)';
    if Sender = DBotExit then
      sMsg := '退出(Alt-Q)';

    if Sender = DMyState then
      sMsg := '状态信息';
    if Sender = DMyBag then
      sMsg := '背包信息';
    if Sender = DMyMagic then
      sMsg := '技能信息';
    if Sender = DOption then
      sMsg := '音效开关';
    if Sender = DBotCallHero then
      sMsg := '召唤英雄';
    if Sender = DBotHeroInfo then
      sMsg := '英雄状态信息';
    if Sender = DBotHeroBag then
      sMsg := '英雄包裹';
    if Sender = DButItemLeve then
      sMsg := '点击确定升级';
    if Sender = DButLevel then
      sMsg := '升级装备';
    if (Sender = DArkOpen) and (m_boOpenBox) and (not m_boOpenArk)
      { and (not m_boOpenMove) }then
      sMsg := '点击试试手气，可能可以多次使用哦';
    if Sender = DBPlacingPnd then
      sMsg := '查询';
    if Sender = DBPlacingBuy then
      sMsg := '购买';
    if Sender = DBPlacingCancel then
      sMsg := '关闭';
    if Sender = DBPlacingFront then
      sMsg := '上一页';
    if Sender = DBReload then
      sMsg := '刷新';
    if Sender = DBPlacingNext then
      sMsg := '下一页';
    if Sender = DButSelfShop then
      sMsg := '开启摆摊';
    if Sender =DDrunkScale then
      sMsg:='醉酒度';
  //  nLocalX := Butt.LocalX(X - Butt.Left);
 //   nLocalY := Butt.LocalY(Y - Butt.Top);
   // nHintX := Butt.SurfaceX(Butt.Left) + DBottom.SurfaceX(DBottom.Left)+ nLocalX;
   // nHintY := Butt.SurfaceY(Butt.Top) + DBottom.SurfaceY(DBottom.Top) + nLocalY;
    with Sender as TDButton do
      DScreen.ShowHint(SurfaceX(Left), SurfaceY(Top - 20), sMsg, clWhite,
        False);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotSysCRYMouseMove'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DFrdFriendDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    with Sender as TDButton do
    begin
      if not TDButton(Sender).Downed then
      begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end
      else
      begin
        d := WLib.Images[FaceIndex + 1];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DFrdFriendDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotFriendClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    OpenFriendDlg();
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotFriendClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.OpenFriendDlg();
begin
  try //程序自动增加
    DFriendDlg.Visible := not DFriendDlg.Visible;
    if DFriendDlg.Visible then
    begin
      g_MasterIdx := 0;
      FirMemoIdx := 0;
      FirCheckIdx := -1;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.OpenFriendDlg'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DFrdCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    OpenFriendDlg();
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DFrdCloseClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DChallengeCloseClick(Sender: TObject; X, Y: Integer);
begin
  DWChallenge.Visible:=False;
  FrmMain.SendCancelChallege;
end;

procedure TFrmDlg.DChallengeGameDiamondClick(Sender: TObject; X, Y: Integer);
var
  valstr,sGold: string;
  nTemp:integer;
begin
   if g_boChallengeEnd then Exit;//确认了抵押不准再取回
    case g_nChallengeGoldIndex of
    0:sGold:=g_sGameDiamond;
    1:sGold:=g_sGameGoldName;
    2:sGold:=g_sGameGird;
    end;
    DialogSize := 1;
    DMessageDlg('你想抵押多少' + sGold + '?', [mbOk, mbAbort]);
    GetValidStrVal(DlgEditText, valstr, [' ']);
    nTemp:= Str_ToInt(valstr, 0);
    case g_nChallengeGoldIndex of
      0:
        begin
          if g_MySelf.m_nGameDiamond+g_nChallengeGameDiamond>nTemp then
          begin
            g_MySelf.m_nGameDiamond :=(g_MySelf.m_nGameDiamond+g_nChallengeGameDiamond)-nTemp;
            g_nChallengeGameDiamond :=nTemp;
            frmMain.SendChangeChallengeGameDiamond(g_nChallengeGameDiamond);
          end;
        end;
      1:
        begin
          if g_MySelf.m_nGameGold+g_nChallengeGameDiamond>nTemp then
          begin
            g_MySelf.m_nGameGold :=(g_MySelf.m_nGameGold+g_nChallengeGameDiamond)-nTemp;
            g_nChallengeGameDiamond :=nTemp;
            frmMain.SendChangeChallengeGameDiamond(g_nChallengeGameDiamond);
          end;
        end;
      2:
        begin
          if g_MySelf.m_nGameGird+g_nChallengeGameDiamond>nTemp then
          begin
            g_MySelf.m_nGameGird:=(g_MySelf.m_nGameGird+g_nChallengeGameDiamond)-nTemp;
            g_nChallengeGameDiamond :=nTemp;
            frmMain.SendChangeChallengeGameDiamond(g_nChallengeGameDiamond);
          end;
        end;
    end;
end;

procedure TFrmDlg.DChallengeGoldClick(Sender: TObject; X, Y: Integer);
var
  valstr: string;
  nTemp:Integer;
begin
   if g_boChallengeEnd then Exit;//确认了抵押不准再取回
        DialogSize := 1;
        DMessageDlg('你想抵押多少' + g_sGoldName + '?', [mbOk, mbAbort]);
        GetValidStrVal(DlgEditText, valstr, [' ']);
        nTemp:= Str_ToInt(valstr, 0);
        if g_MySelf.m_nGold+g_nChallengeGold>nTemp then
        begin
          g_MySelf.m_nGold :=(g_MySelf.m_nGold+g_nChallengeGold)-nTemp;
          g_nChallengeGold :=nTemp;
          frmMain.SendChangeChallengeGold(g_nChallengeGold);
        end;
end;

procedure TFrmDlg.DChallengeGrid1GridMouseMove(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
  idx: integer;
begin
  try
    idx := ACol;
    if idx in [0..3] then
    begin
      g_MouseItem := g_ChallengeItems1[idx];
    end;
  except
    DebugOutStr('[Exception] TFrmDlg.DChallengeGrid1'); //程序自动增加
  end;
end;

procedure TFrmDlg.DChallengeGrid1GridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState; dsurface: TDirectDrawSurface);
var
  idx,n: integer;
  d: TDirectDrawSurface;
  sText:string;
begin
  try
    idx := ACol;
    if idx in [0..3] then
    begin
      if g_ChallengeItems1[idx].S.Name <> '' then
      begin
        d := FrmMain.GetWBagItemImg(g_ChallengeItems1[idx].S.Looks);
        if d <> nil then
          with DChallengeGrid1 do
          begin
            dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
              d.ClientRect,
              d, TRUE);
              if (g_ChallengeItems1[idx].Dura>1) and (g_ChallengeItems1[idx].S.StdMode=0) then
               begin
                 sText:=IntToStr(g_ChallengeItems1[idx].Dura);
                 n := dsurface.Canvas.TextWidth(sText);
                 SetBkMode(dsurface.Canvas.Handle,TRANSPARENT);
                 dsurface.Canvas.Font.Color := clWhite;
                 dsurface.Canvas.Font.Style:=[fsBold];
                 dsurface.Canvas.TextOut(SurfaceX(Rect.Left + d.Width-n),SurfaceY(Rect.Top),sText);
                 dsurface.Canvas.Font.Style:=dsurface.Canvas.Font.Style-[fsBold];
                 dsurface.Canvas.Release;
               end;
          end;
      end;
    end;
  except
    DebugOutStr('[Exception] TFrmDlg.DChallengeGrid1');
  end;
end;

procedure TFrmDlg.DChallengeGrid1GridSelect(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
  mi, idx: integer;
begin
  try
   if g_boChallengeEnd then Exit;//确认了抵押不准再取回
    idx := ACol;
      if not g_boItemMoving then
      begin
        if (idx in [0..3]) and (g_ChallengeWaitItem.S.Name='') and (g_ChallengeItems1[idx].S.Name <> '') then
          begin
            g_boItemMoving := TRUE;
            g_MovingItem.Item :=g_ChallengeItems1[idx];
            g_ChallengeWaitItem:=g_ChallengeItems1[idx];
            g_MovingItem.Hero := False;
            g_ChallengeItems1[idx].S.Name := '';
            ItemClickSound(g_MovingItem.Item.S);
            FrmMain.SendDelChallengeItem(g_MovingItem.Item,Word(idx));
          end;
      end
      else
      begin
         if (idx in [0..3]) and (g_ChallengeWaitItem.S.Name='') and (g_ChallengeItems1[idx].S.Name='') and (not g_MovingItem.Hero) then
          begin
            g_ChallengeItems1[idx]:= g_MovingItem.Item;
            g_ChallengeWaitItem:=g_ChallengeItems1[idx];
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
            FrmMain.SendADDChallengeItem(g_ChallengeItems1[idx],Word(idx));
          end;
      end;
  except
    DebugOutStr('[Exception] TFrmDlg.DChallengeGrid1'); //程序自动增加
  end;
end;

procedure TFrmDlg.DChallengeGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState; dsurface: TDirectDrawSurface);
var
  idx,n: integer;
  d: TDirectDrawSurface;
  sText:string;
begin
  try
    idx := ACol;
    if idx in [0..3] then
    begin
      if g_ChallengeItems[idx].S.Name <> '' then
      begin
        d := FrmMain.GetWBagItemImg(g_ChallengeItems[idx].S.Looks);
        if d <> nil then
          with DChallengeGrid1 do
          begin
            dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
              d.ClientRect,
              d, TRUE);
              if (g_ChallengeItems[idx].Dura>1) and (g_ChallengeItems[idx].S.StdMode=0) then
               begin
                 sText:=IntToStr(g_ChallengeItems[idx].Dura);
                 n := dsurface.Canvas.TextWidth(sText);
                 SetBkMode(dsurface.Canvas.Handle,TRANSPARENT);
                 dsurface.Canvas.Font.Color := clWhite;
                 dsurface.Canvas.Font.Style:=[fsBold];
                 dsurface.Canvas.TextOut(SurfaceX(Rect.Left + d.Width-n),SurfaceY(Rect.Top),sText);
                 dsurface.Canvas.Font.Style:=dsurface.Canvas.Font.Style-[fsBold];
                 dsurface.Canvas.Release;
               end;
          end;
      end;
    end;
  except
    DebugOutStr('[Exception] TFrmDlg.DChallengeGrid');
  end;

end;

procedure TFrmDlg.DChallengeOKClick(Sender: TObject; X, Y: Integer);
begin
      FrmMain.SendChallengeEnd;
      g_boChallengeEnd:= TRUE;
end;

procedure TFrmDlg.DChallengeOKDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
var
  dd: TDirectDrawSurface;
  d:TDButton;
begin
    if Sender is TDButton then
    begin
      d := TDButton(Sender);
      if d.Downed then
      begin
        dd := d.WLib.Images[d.FaceIndex];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
      end;
    end;
end;

procedure TFrmDlg.DCheckBox1Click(Sender: TObject; X, Y: Integer);
begin
  if Sender=DCheckBox1 then
    g_WgInfo.boShowName:=DCheckBox1.Checked
  else if Sender=DCheckBox2 then
    g_WgInfo.boDuraAlert:=DCheckBox2.Checked
  else if Sender=DCheckBox3 then
    g_WgInfo.boCloseShift:=DCheckBox3.Checked
  else if Sender=DCheckBox4 then
    g_WgInfo.boExpShowFil:=DCheckBox4.Checked
  else if Sender=DCheckBox5 then
    g_WgInfo.boShowAllItem:=DCheckBox5.Checked
  else if Sender=DCheckBox6 then
    g_WgInfo.boShowAllItemFil:=DCheckBox6.Checked
  else if Sender=DCheckBox7 then
    g_WgInfo.boAutoPuckUpItem:=DCheckBox7.Checked
  else if Sender=DCheckBox8 then
    g_WgInfo.boAutoPuckItemFil:=DCheckBox8.Checked
  else if Sender=DCheckBox9 then
    g_WgInfo.boCanLongHit:=DCheckBox9.Checked
  else if Sender=DCheckBox10 then
    g_WgInfo.boCanWideHit:=DCheckBox10.Checked
  else if Sender=DCheckBox11 then
    g_WgInfo.boCanAutoFireHit:=DCheckBox11.Checked
  else if Sender=DCheckBox12 then
    g_WgInfo.boCanAutoLongFire:=DCheckBox12.Checked
  else if Sender=DCheckBox13 then
    g_WgInfo.boCanShield:=DCheckBox13.Checked
  else if Sender=DCheckBox14 then begin
    if (g_HeronRecogId > 0) and (g_HerobtJob = 1) then
    begin
      g_WgInfo.boHeroAutoMagic := DCheckBox14.Checked;
      Frmmain.SendHeroFun(Integer(g_WgInfo.boHeroAutoMagic), 0);
    end;
  end else if Sender=DCheckBox15 then
    g_WgInfo.boCanCloak:=DCheckBox15.Checked
  else if Sender=DCheckBox16 then
    g_WgInfo.boAutoMagic:=DCheckBox16.Checked
  else if Sender=DCheckBox17 then
    g_WgInfo.boAutoHp:= DCheckBox17.Checked
  else if Sender=DCheckBox18 then
    g_WgInfo.boAutoMp:= DCheckBox18.Checked
  else if Sender=DCheckBox19 then
    g_WgInfo.boAutoCropsHp:=DCheckBox19.Checked
  else if Sender=DCheckBox20 then
    g_WgInfo.boAutoHpProtect:=DCheckBox20.Checked
  else if Sender=DCheckBox21 then
    g_WgInfo.boAutoDrink:=DCheckBox21.Checked
  else if Sender=DCheckBox22 then
    g_WgInfo.boHeroAutoDrink:=DCheckBox22.Checked
  else if Sender=DCheckBox24 then
    g_WgInfo.boHookKey:=DCheckBox24.Checked
  else if Sender=DCheckBox28 then
    g_WgInfo.boBacchusprotect:=DCheckBox28.Checked;
end;

procedure TFrmDlg.DCheckBox25Click(Sender: TObject; X, Y: Integer);
begin
if Sender=DCheckBox25 then
begin
 if DCheckBox25.Checked then
 begin
   DCheckBox26.Checked:=False;
   DCheckBox27.Checked:=False;
 end;
end else if Sender=DCheckBox26 then
begin
  if DCheckBox26.Checked then
  begin
   DCheckBox25.Checked:=False;
   DCheckBox27.Checked:=False;
  end;
end else if Sender=DCheckBox27 then
begin
 if DCheckBox27.Checked then
 begin
  DCheckBox25.Checked:=False;
  DCheckBox26.Checked:=False;
 end;
end;
g_WgInfo.boHeroCallBoneFamm :=DCheckBox25.Checked;
g_WgInfo.boHeroCallDogz :=DCheckBox26.Checked;
g_WgInfo.boHeroCallFairy :=DCheckBox27.Checked;
FrmMain.SendHeroMob();
end;

procedure TFrmDlg.DCheckBox4MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
if DCheckBox4.MouseEntry=msIn then
begin
    with DCheckBox4 do
      DScreen.ShowHint(SurfaceX(Left), SurfaceY(Top+Height+20),
       '选中此项将隐藏低于2000的经验值增长提示', clYellow,True);
end;
end;

procedure TFrmDlg.DChgGamePwdCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DChgGamePwd.Visible := False;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DChgGamePwdCloseClick');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DChgGamePwdDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  lx, ly, sx: integer;
begin
  try //程序自动增加
    with Sender as TDWindow do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      SetBkMode(dsurface.Canvas.Handle, TRANSPARENT);
      BoldTextOut(dsurface, SurfaceX(Left + 15), SurfaceY(Top + 13), clWhite,
        clBlack, g_sGamePointName);

      dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style + [fsUnderline];
      BoldTextOut(dsurface, SurfaceX(Left + 12), SurfaceY(Top + 190), clYellow,
        clBlack, g_sGameGoldName);
      dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style - [fsUnderline];
      dsurface.Canvas.Release;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DChgGamePwdDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotSysMsgMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
  Butt: TDButton;
  sMsg: string;
begin
  try //程序自动增加
    if not (Sender is TDButton) then
    begin
      DScreen.ClearHint;
      exit;
    end;
    Butt := TDButton(Sender);
    if Sender = DBotSysMsg then
      sMsg := '拒绝所有公聊信息';
    if Sender = DBotSysCRY then
      sMsg := '拒绝所有喊话信息';
    if Sender = DBotSysHear then
      sMsg := '拒绝所有私聊信息';
    if Sender = DBotSysGuild then
      sMsg := '拒绝行会聊天信息';
    if Sender = DBotAutoSys then
      sMsg := '自动喊话开关';

    nLocalX := Butt.LocalX(X - Butt.Left);
    nLocalY := Butt.LocalY(Y - Butt.Top);
    nHintX := Butt.SurfaceX(Butt.Left) + DBottom.SurfaceX(DBottom.Left) +
      nLocalX;
    nHintY := Butt.SurfaceY(Butt.Top) + DBottom.SurfaceY(DBottom.Top) + nLocalY;
    with Sender as TDButton do
      DScreen.ShowHint(SurfaceX(Left - Canvas.TextWidth(sMsg) - 10),
        SurfaceY(Top), sMsg, clWhite, False);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotSysMsgMouseMove'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotSysMsgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDButton;
  dd: TDirectDrawSurface;
  Show: Boolean;
begin
  try //程序自动增加
    if Sender is TDButton then
    begin
      d := TDButton(Sender);
      Show := False;
      if (Sender = DBotSysMsg) then
        Show := g_CloseAllSys;
      if Sender = DBotSysCRY then
        Show := g_CloseCrcSys;
      if Sender = DBotSysHear then
        Show := g_CloseMySys;
      if Sender = DBotSysGuild then
        Show := g_CloseGuildSys;
      if Sender = DBotAutoSys then
        Show := not g_AutoSysMsg;
      if not Show then
      begin
        dd := d.WLib.Images[d.FaceIndex];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
      end
      else
      begin
        dd := d.WLib.Images[d.FaceIndex + 1];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotSysMsgDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotSysMsgClick(Sender: TObject; X, Y: Integer);
var
  d: TDButton;
  sMsg: string;
  BgColor: Integer;
begin
  try //程序自动增加
    if Sender is TDButton then
    begin
      d := TDButton(Sender);
      BgColor := clBlack;
      if (Sender = DBotSysMsg) then
      begin
        g_CloseAllSys := not g_CloseAllSys;
        if not g_CloseAllSys then
        begin
          sMsg := '允许接收公聊信息';
          BgColor := clWhite;
        end
        else
          sMsg := '拒绝接收公聊信息';
      end;
      if Sender = DBotSysCRY then
      begin
        g_CloseCrcSys := not g_CloseCrcSys;
        if not g_CloseCrcSys then
        begin
          sMsg := '允许接收(黄颜色字体)喊话';
          BgColor := clWhite;
        end
        else
          sMsg := '拒绝接收(黄颜色字体)喊话';
      end;
      if Sender = DBotSysHear then
      begin
        g_CloseMySys := not g_CloseMySys;
        if not g_CloseMySys then
        begin
          sMsg := '允许接收私聊信息';
          BgColor := clWhite;
        end
        else
          sMsg := '拒绝接收私聊信息';
      end;
      if Sender = DBotSysGuild then
      begin
        g_CloseGuildSys := not g_CloseGuildSys;
        if not g_CloseGuildSys then
        begin
          sMsg := '允许接收行会聊天信息';
          BgColor := clWhite;
        end
        else
          sMsg := '拒绝收行会聊天信息';
      end;
      if Sender = DBotAutoSys then
      begin
        BgColor := clWhite;
        g_AutoSysMsg := not g_AutoSysMsg;
        if g_AutoSysMsg then
        begin
          sMsg :=
            '启用了自动喊话功能，聊天框中的内容已记录为喊话内容';
          if PlayScene.EdChat.Text <> '' then
            g_AutoMsgTick := GetTickCount;
          g_AutoMsg := PlayScene.EdChat.Text;
        end
        else
          sMsg := '自动喊话已关闭';
      end;
      DScreen.AddChatBoardString(sMsg, clGreen, BgColor);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotSysMsgClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DFrdBlacklistDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDButton;
  dd: TDirectDrawSurface;
begin
  try //程序自动增加
    case g_MasterIdx of
      0: d := DFrdFriend;
      1: d := DFrdMaster;
      2: d := DFrdBlacklist;
    end;
    if d <> nil then
    begin
      dd := d.WLib.Images[d.FaceIndex];
      if dd <> nil then
        dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd,
          TRUE);
    end;
  with DBotMaster do
  begin
    if g_MasterIdx = 1 then
    begin
      Visible := True;
      //d := DBotMaster;
      dd := WLib.Images[FaceIndex];
      if dd <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), dd.ClientRect, dd,
          True);
    end
    else
      DBotMaster.Visible := False;
  end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DFrdBlacklistDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DFrdFriendClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if Sender = DFrdFriend then
      g_MasterIdx := 0;
    if Sender = DFrdMaster then
      g_MasterIdx := 1;
    if Sender = DFrdBlacklist then
      g_MasterIdx := 2;
    FirMemoIdx := 0;
    FirCheckIdx := -1;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DFrdFriendClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DFriendDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  function SX(x: integer): integer;
  begin
    Result := DFriendDlg.SurfaceX(DFriendDlg.Left + x);
  end;
  function SY(y: integer): integer;
  begin
    Result := DFriendDlg.SurfaceY(DFriendDlg.Top + y);
  end;
var
  i, lh, k, m, menuline: integer;
  d: TDirectDrawSurface;
  pg: PTClientGoods;
  str: string;
  nM: Byte;
  List: TStringList;
begin
  try //程序自动增加
    with dsurface.Canvas do
    begin
      with DFriendDlg do
      begin
        d := DFriendDlg.WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      SetBkMode(dsurface.Canvas.Handle, TRANSPARENT);
      //SetBkMode (Handle, TRANSPARENT);

      Font.Color := clWhite;
      if g_MasterIdx = 0 then
        List := g_MyFriendList
      else
        List := g_MyBlacklist;
      nM := List.Count div 10;
      if (nM * 10) < List.Count then
        Inc(nM);
      if FirMemoIdx > nM then
        FirMemoIdx := nM;
      if FirMemoIdx <= 0 then
        inc(FirMemoIdx);
      lh := 0;
      FirCheckName := '';
      for I := ((FirMemoIdx - 1) * 10 + 1) to (FirMemoIdx - 1) * 10 + 10 do
      begin
        if I > List.Count then
          break;
        if FirCheckIdx = lh then
        begin
          Font.Color := clRed;
          FirCheckName := List.Strings[I - 1];
        end
        else
          Font.Color := clWhite;
        TextOut(SX(38), SY(52 + lh * 15), List.Strings[I - 1]);
        Inc(lh);
      end;
      FirCheckCount := lh;
      Release;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DFriendDlgDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DFrdAddClick(Sender: TObject; X, Y: Integer);
var
  who: string[ActorNameLen];
begin
  try //程序自动增加
    DialogSize := 1;
    if g_MasterIdx = 0 then
    begin
      DMessageDlg('添加新的好友.', [mbOk, mbAbort]);
      who := Trim(DlgEditText);
      if who <> '' then
      begin
        if g_MyFriendList.IndexOf(who) <> -1 then
        begin
          DMessageDlg('该角色名已经在你的好友列表当中。',
            [mbOk]);
        end
        else
        begin
          FirMemoIdx := 255;
          g_MyFriendList.Add(who);
        end;
      end;
    end
    else
    begin
      DMessageDlg('添加新的黑名单.', [mbOk, mbAbort]);
      who := Trim(DlgEditText);
      if who <> '' then
      begin
        if g_MyBlacklist.IndexOf(who) <> -1 then
        begin
          DMessageDlg('该角色名已经在你的黑名单当中。', [mbOk]);
        end
        else
        begin
          FirMemoIdx := 255;
          g_MyBlacklist.Add(who);
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DFrdAddClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotFrdUpClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if Sender = DBotFrdUp then
      Dec(FirMemoIdx);
    if Sender = DBotFrdDown then
      Inc(FirMemoIdx);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotFrdUpClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DFriendDlgClick(Sender: TObject; X, Y: Integer);
var
  lx, ly, idx: integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
begin
  try //程序自动增加
    lx := DFriendDlg.LocalX(X) - DFriendDlg.Left;
    ly := DFriendDlg.LocalY(Y) - DFriendDlg.Top;
    if (lx >= 38) and (lx <= 150) and (ly >= 52) and (ly <= 250) then
    begin
      idx := (ly - 52) div 15;
      if idx < FirCheckCount then
      begin
        PlaySound(s_glass_button_click);
        FirCheckIdx := idx;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DFriendDlgClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DFrdDelClick(Sender: TObject; X, Y: Integer);
var
  DelName: string;
  Idx: Integer;
begin
  try //程序自动增加
    DelName := FirCheckName;
    if DelName <> '' then
    begin
      if DMessageDlg(Format('你确认删除 [%s] 吗？', [DelName]), [mbYes,
        mbNo]) = mrYes then
      begin
        if g_MasterIdx = 0 then
        begin
          Idx := g_MyFriendList.IndexOf(DelName);
          if Idx > -1 then
            g_MyFriendList.Delete(Idx);
        end
        else
        begin
          Idx := g_MyBlacklist.IndexOf(DelName);
          if Idx > -1 then
            g_MyBlacklist.Delete(Idx);
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DFrdDelClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotCallHeroClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    FrmMain.SendHeroCall;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotCallHeroClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotHeroInfoClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if g_HeronRecogId = 0 then
      exit;
    DHeroStateWindow.Visible := not DHeroStateWindow.Visible;
    PageChanged(DNextHeroState);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotHeroInfoClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  hcolor, old, keyimg: integer;
  sLevel,sHeroGloryPoint: string;
  i:integer;
  rc: TRect;
begin
  try //程序自动增加
    with DHeroDlg do
    begin
      d := g_UIBImages.Images[21];
      if d = nil then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      if g_HeronRecogId <> 0 then
        d := WLib.Images[365 + g_HerobtJob + g_HerobtSex * 3]
      else
        d := WLib.Images[365];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left + 18), SurfaceY(Top + 18), d.ClientRect, d,
          TRUE);

      d := g_WMain2Images.Images[513];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left+35), SurfaceY(Top+12), d.ClientRect, d,
          True);
      try
        d := g_WMain2Images.Images[582];
        if (d <> nil) and (g_WineRec.WineValue<>0) then
        begin
          rc := d.ClientRect;
          rc.Right := d.ClientRect.Right-2;
          rc.Top := Round(rc.Bottom /g_WineRec.WineValue * (g_WineRec.WineValue-g_WineRec.Alcoho));
          dsurface.Draw(SurfaceX(Left+35), SurfaceY(Top+12)+rc.Top, rc, d, True);
        end;
      except

      end;

      if g_HeronRecogId <> 0 then
      begin
        with dsurface.Canvas do
        begin
          SetBkMode(Handle, TRANSPARENT);
          Font.Color := clwhite;
          sHeroGloryPoint:=Format('%f', [g_HeroGloryPoint/100])+'%';
          TextOut(SurfaceX(80), SurfaceY(6), g_HerosUserName);
          sLevel := IntToStr(g_HeroAbil.Level);
          TextOut(SurfaceX(14 - TextWidthAndHeight(Handle,sLevel).cx{TextWidth(sLevel)} div 2), SurfaceY(61), sLevel);
          TextOut(SurfaceX(101), SurfaceY(62), sHeroGloryPoint);
          Release;
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DHeroDlgDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
sMsg:string;
begin
  try
     sMsg:=sMsg+'体力值: '+IntToStr(g_HeroAbil.HP)+'/'+IntToStr(g_HeroAbil.MaxHP)+'\';
     sMsg:=sMsg+'魔法值: '+IntToStr(g_HeroAbil.MP)+'/'+IntToStr(g_HeroAbil.MaxMP)+'\';
     sMsg:=sMsg+'经验值: '+IntToStr(Round(g_HeroAbil.Exp/g_HeroAbil.MaxExp*100))+'%\';
     sMsg:=sMsg+'忠城度: '+IntToStr(Round(g_HeroGloryPoint/100))+'%\';
     sMsg:=sMsg+'醉酒度: '+IntToStr(Round(g_WineRec.Alcoho/g_WineRec.WineValue*100))+'%';
    with DHeroDlg do
      DScreen.ShowHint(SurfaceX(Left+Width),SurfaceY(Top+20),sMsg, clWhite,True);
  except

  end;
end;

procedure TFrmDlg.DCloseHeroStateClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DHeroDlg.Visible := not DHeroDlg.Visible;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DCloseHeroStateClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroStateWindowDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  i, l, m, pgidx, magline, bbx, bby, mmx, idx, ax, ay, trainlv: integer;
  pm: PTClientMagic;
  d: TDirectDrawSurface;
  hcolor, old, keyimg: integer;
  iname, d1, d2, d3,d4: string;
  useable: Boolean;
  rc:TRect;
begin
  try //程序自动增加
    with DHeroStateWindow do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      case HeroStatePage of
        0:
          begin
            pgidx := 380;
            if g_HeronRecogId <> 0 then
              if g_HerobtSex = 1 then
                pgidx := 381;
            bbx := Left + 39;
            bby := Top + 51;
            d := g_WMain3Images.Images[pgidx];
            if d <> nil then
              dsurface.Draw(SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d,
                FALSE);
            bbx := bbx - 7;
            bby := bby + 44;
            //idx := HUMANFRAME * (g_HerobtHair + g_HerobtSex+1)-1; //赣府 胶鸥老
            idx := HUMANFRAME * (g_HerobtHair + 1) - 1;
            if idx > 0 then
            begin
              d := g_WHairImgImages.GetCachedImage(idx, ax, ay);
              if d <> nil then
                dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay),
                  d.ClientRect, d, TRUE);
            end;
            if g_HeroUseItems[U_DRESS].S.Name <> '' then
            begin
              idx := g_HeroUseItems[U_DRESS].S.Looks;
              //渴 if Myself.m_btSex = 1 then idx := 80; //咯磊渴
              if idx >= 0 then
              begin
                //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                d := FrmMain.GetWStateImg(idx, ax, ay);
                if d <> nil then
                  dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay),
                    d.ClientRect, d, TRUE);
              end;
            end;
            if g_HeroUseItems[U_WEAPON].S.Name <> '' then
            begin
              idx := g_HeroUseItems[U_WEAPON].S.Looks;
              if idx >= 0 then
              begin
                //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                d := FrmMain.GetWStateImg(idx, ax, ay);
                if d <> nil then
                  dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay),
                    d.ClientRect, d, TRUE);
              end;
            end;
            if g_HeroUseItems[U_STRAW].S.Name <> '' then
            begin
                if g_HeroUseItems[U_STRAW].S.Shape=0 then
                 idx := 1188//g_HeroUseItems[U_STRAW].S.Looks;斗笠
                else
                 idx := g_HeroUseItems[U_STRAW].S.Looks;//王者斗笠
                if idx >= 0 then
                begin
                  //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                  d := FrmMain.GetWStateImg(idx, ax, ay);
                  if d <> nil then
                    dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay),
                      d.ClientRect, d, TRUE);
                end;
            end
            else
            begin
              if g_HeroUseItems[U_HELMET].S.Name <> '' then
              begin
                idx := g_HeroUseItems[U_HELMET].S.Looks;
                if idx >= 0 then
                begin
                  //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                  d := FrmMain.GetWStateImg(idx, ax, ay);
                  if d <> nil then
                    dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay),
                      d.ClientRect, d, TRUE);
                end;
              end;
            end;

            with dsurface.Canvas do
            begin
              SetBkMode(Handle, TRANSPARENT);
              Font.Color := clSilver;
              TextOut(SurfaceX(Left + 122 - TextWidth(g_HerosUserName) div 2),
                SurfaceY(Top + 55), g_HerosUserName);
              Release;
            end;
          end;
        1:
          begin //瓷仿摹
            bbx := Left + 39;
            bby := Top + 51;
            d := g_UIBImages.Images[22];
            if d = nil then
              d := g_WMain3Images.Images[383];
            if d <> nil then
              dsurface.Draw(SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d,
                FALSE);
            l := Left + 111; //66;
            m := Top + 97;
            with dsurface.Canvas do
            begin
              SetBkMode(Handle, TRANSPARENT);
              Font.Color := clWhite;
              TextOut(SurfaceX(l + 0), SurfaceY(m + 0),
                IntToStr(LoWord(g_HeroAbil.AC)) + '-' +
                IntToStr(HiWord(g_HeroAbil.AC)));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 20),
                IntToStr(LoWord(g_HeroAbil.MAC)) + '-' +
                IntToStr(HiWord(g_HeroAbil.MAC)));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 40),
                IntToStr(LoWord(g_HeroAbil.DC)) + '-' +
                IntToStr(HiWord(g_HeroAbil.DC)));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 60),
                IntToStr(LoWord(g_HeroAbil.MC)) + '-' +
                IntToStr(HiWord(g_HeroAbil.MC)));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 80),
                IntToStr(LoWord(g_HeroAbil.SC)) + '-' +
                IntToStr(HiWord(g_HeroAbil.SC)));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 100), IntToStr(g_HeroAbil.HP)
                + '/' + IntToStr(g_HeroAbil.MaxHP));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 120), IntToStr(g_HeroAbil.MP)
                + '/' + IntToStr(g_HeroAbil.MaxMP));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 140),
                IntToStr(g_MedicineRec.MedicineValue) + '/' +
                IntToStr(g_MedicineRec.MaxMedicineValue));
              TextOut(SurfaceX(l + 0), SurfaceY(m + 160),
                IntToStr(g_WineRec.WineValue));
              Release;
            end;
          end;
        2:
          begin
            bbx := Left + 58;
            bby := Top + 62;
            with dsurface.Canvas do
            begin
              SetBkMode(Handle, TRANSPARENT);
              mmx := bbx + 85;
              Font.Color := clSilver;
              TextOut(bbx, bby, '当前经验');
              TextOut(mmx, bby, IntToStr(g_HeroAbil.Exp));

              TextOut(bbx, bby + 14 * 1, '升级经验');
              TextOut(mmx, bby + 14 * 1, IntToStr(g_HeroAbil.MaxExp));

              TextOut(bbx, bby + 14 * 2, '背包重量');
              if g_HeroAbil.Weight > g_HeroAbil.MaxWeight then
                Font.Color := clRed;
              TextOut(mmx, bby + 14 * 2, IntToStr(g_HeroAbil.Weight) + '/' +
                IntToStr(g_HeroAbil.MaxWeight));

              Font.Color := clSilver;
              TextOut(bbx, bby + 14 * 3, '穿戴重量');
              if g_HeroAbil.WearWeight > g_HeroAbil.MaxWearWeight then
                Font.Color := clRed;
              TextOut(mmx, bby + 14 * 3, IntToStr(g_HeroAbil.WearWeight) + '/' +
                IntToStr(g_HeroAbil.MaxWearWeight));

              Font.Color := clSilver;
              TextOut(bbx, bby + 14 * 4, '腕力');
              if g_HeroAbil.HandWeight > g_HeroAbil.MaxHandWeight then
                Font.Color := clRed;
              TextOut(mmx, bby + 14 * 4, IntToStr(g_HeroAbil.HandWeight) + '/' +
                IntToStr(g_HeroAbil.MaxHandWeight));

              Font.Color := clSilver;
              TextOut(bbx, bby + 14 * 5, '精确度');
              TextOut(mmx, bby + 14 * 5, IntToStr(g_nHeroHitPoint));

              TextOut(bbx, bby + 14 * 6, '敏捷度');
              TextOut(mmx, bby + 14 * 6, IntToStr(g_nHeroSpeedPoint));

              TextOut(bbx, bby + 14 * 7, '魔法防御');
              TextOut(mmx, bby + 14 * 7, '+' + IntToStr(g_nHeroAntiMagic * 10) +
                '%');

              TextOut(bbx, bby + 14 * 8, '中毒防御');
              TextOut(mmx, bby + 14 * 8, '+' + IntToStr(g_nHeroAntiPoison * 10)
                +
                '%');

              TextOut(bbx, bby + 14 * 9, '中毒恢复');
              TextOut(mmx, bby + 14 * 9, '+' + IntToStr(g_nHeroPoisonRecover *
                10) + '%');

              TextOut(bbx, bby + 14 * 10, '体力恢复');
              TextOut(mmx, bby + 14 * 10, '+' + IntToStr(g_nHeroHealthRecover *
                10) + '%');

              TextOut(bbx, bby + 14 * 11, '魔法恢复');
              TextOut(mmx, bby + 14 * 11, '+' + IntToStr(g_nHeroSpellRecover *
                10) + '%');

              Release;
            end;
          end;
        3:
          begin //魔法 芒
            bbx := Left + 39;
            bby := Top + 51;
            d := g_WMain99Images.Images[62]; // g_WMain3Images.Images[382];
            if d <> nil then
              dsurface.Draw(SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d,
                FALSE);

            //虐 钎矫, lv, exp
            magtop := HeroMagicPage * 6;
            magline := _MIN(HeroMagicPage * 6 + 6, g_HeroMagicList.Count);
            for i := magtop to magline - 1 do
            begin
              pm := PTClientMagic(g_HeroMagicList[i]);
              m := i - magtop;
             if pm.Def.wMagicID = 84 then //处理酒气护体显示
             begin
              d := g_WMainImages.Images[112]; //lv
              if d <> nil then
                dsurface.Draw(bbx + 48+92, bby + 8 +m * 37, d.ClientRect, d,TRUE);
              DButton4.Left:=39+48;
              DButton4.Top:= 51+8 +15+ m * 37;
              DButton4.Width:=92;
              DButton4.Height:=8;
              DButton4.Visible:=True;
             {
              d :=  g_WMain2Images.Images[577];
              if d <> nil then
                dsurface.Draw(bbx + 48, bby + 8 +15+ m * 37, d.ClientRect, d,TRUE);
                d := g_WMain2Images.Images[578];
              if d <> nil then
              begin
               try
                 rc := d.ClientRect;
                 rc.Right := Round((rc.Right-rc.Left) / 100 *
                      (Round(g_SKILL84Rec.SKILL84Exp /g_SKILL84Rec.MaxSKILL84Exp*100)));
                 dsurface.Draw(bbx + 48, bby + 8 +15+ m * 37, rc, d, True);
               except

                end;
              end;
               }
             end else
             begin
              d := g_WMainImages.Images[112]; //lv
              if d <> nil then
                dsurface.Draw(bbx + 48, bby + 8 + 15 + m * 37, d.ClientRect, d,
                  TRUE);
              d := g_WMainImages.Images[111]; //exp
              if d <> nil then
                dsurface.Draw(bbx + 48 + 26, bby + 8 + 15 + m * 37,d.ClientRect, d, TRUE);
             end;
            end;
            //显示英雄技能名称等级
            with dsurface.Canvas do
            begin
              SetBkMode(Handle, TRANSPARENT);
              Font.Color := clSilver;
              for i := magtop to magline - 1 do
              begin
                pm := PTClientMagic(g_HeroMagicList[i]);
                m := i - magtop;
                if not (pm.Level in [0..4]) then
                  pm.Level := 0;
                //080603修改增加英雄技能开关显示
                if (pm.Def.wMagicID <> 3) and (pm.Def.wMagicID <> 4) and
                  (pm.Def.wMagicID <> 7) and (pm.Def.wMagicID <> 83)  then
                begin
                  if Byte(pm.Key) <> 0 then
                  begin
                    if ((pm.Def.wMagicID = 57) or (pm.Def.wMagicID = 81)) then
                      TextOut(bbx + 48, bby + 8 + m * 37,
                        copy(pm.Def.sMagicName, 1, Length(pm.Def.sMagicName) - 1)
                          + '[关]')
                    else
                      TextOut(bbx + 48, bby + 8 + m * 37, pm.Def.sMagicName +
                        '[关]');
                  end
                  else
                  begin
                    if ((pm.Def.wMagicID = 57) or (pm.Def.wMagicID = 81)) then
                      TextOut(bbx + 48, bby + 8 + m * 37,
                        copy(pm.Def.sMagicName, 1, Length(pm.Def.sMagicName) - 1))
                    else
                      TextOut(bbx + 48, bby + 8 + m * 37, pm.Def.sMagicName);
                  end;
                end
                else
                begin
                  if ((pm.Def.wMagicID = 57) or (pm.Def.wMagicID = 81)) then
                    TextOut(bbx + 48, bby + 8 + m * 37, copy(pm.Def.sMagicName,
                      1, Length(pm.Def.sMagicName) - 1))
                  else
                    TextOut(bbx + 48, bby + 8 + m * 37, pm.Def.sMagicName);
                end;
                if pm.Level in [0..4] then
                begin
                  if ((pm.Def.wMagicID = 57) or (pm.Def.wMagicID = 81)) then
                    trainlv := 4
                  else
                    trainlv := pm.Level;
                end
                else
                  trainlv := 0;

                 if pm.Def.wMagicID = 84 then
                 begin
                   TextOut(bbx + 48 + 108, bby + 8 +  m * 37,IntToStr(g_SKILL84Rec.SKILL84Level));
                 end else
                 begin
                   if pm.Def.wMagicID = 83 then
                   begin
                     //先天原力等级显示
                   TextOut(bbx + 48 + 16, bby + 8 + 15 + m * 37,IntToStr(g_SKILL83Rec.skill83Level));
                     if g_SKILL83Rec.skill83Level < 3 then
                      begin
                         TextOut(bbx + 48 + 46, bby + 8 + 15 + m * 37,IntToStr(g_WineRec.WineValue) + '/' +
                           IntToStr(g_SKILL83Rec.MaxWineValue));
                        end
                      else
                         TextOut(bbx + 48 + 46, bby + 8 + 15 + m * 37, '-');
                   end else
                   begin
                    TextOut(bbx + 48 + 16, bby + 8 + 15 + m * 37,IntToStr(trainlv));
                    if pm.Def.MaxTrain[_MIN(3, trainlv)] > 0 then
                    begin
                     if trainlv < 3 then
                      begin
                         TextOut(bbx + 48 + 46, bby + 8 + 15 + m * 37,IntToStr(pm.CurTrain) + '/' +
                           IntToStr(pm.Def.MaxTrain[trainlv]));
                        end
                      else
                         TextOut(bbx + 48 + 46, bby + 8 + 15 + m * 37, '-');
                    end;
                  end;
                 end;
              end;
              Release;
            end;
          end;
      end;
      if g_MouseHeroItem.S.Name <> '' then
      begin
        g_MouseItem := g_MouseHeroItem;
        GetMouseItemInfo(iname, d1, d2, d3,d4, useable, True);
        if iname <> '' then
        begin
          if g_MouseItem.Dura = 0 then
            hcolor := clRed
          else
            hcolor := clWhite;
          with dsurface.Canvas do
          begin
            SetBkMode(Handle, TRANSPARENT);
            old := Font.Size;
            Font.Size := 9;
            Font.Color := clYellow;
            TextOut(SurfaceX(Left + 37), SurfaceY(Top + 309), iname);
            Font.Color := hcolor;
            TextOut(SurfaceX(Left + 37 + TextWidth(iname)), SurfaceY(Top + 309),
              d1);
            TextOut(SurfaceX(Left + 37), SurfaceY(Top + 309 + TextHeight('A') +
              2), d2);
            TextOut(SurfaceX(Left + 37), SurfaceY(Top + 309 + (TextHeight('A') +
              2) * 2), d3+d4);
            Font.Size := old;
            Release;
          end;
        end;
        g_MouseItem.S.Name := '';
      end;
    end;

  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DHeroStateWindowDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroPageDownClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if Sender = DHeroPageUp then
    begin
      if HeroMagicPage > 0 then
        Dec(HeroMagicPage);
    end
    else
    begin
      if HeroMagicPage < (g_HeroMagicList.Count + 4) div 5 - 1 then
        Inc(HeroMagicPage);
    end;
  DButton4.Visible:=False;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DHeroPageDownClick'); //程序自动增加
  end; //程序自动增加
end;

//客户端英雄技能键单击

procedure TFrmDlg.DHeroMag1Click(Sender: TObject; X, Y: Integer);
var
  pm: PTClientMagic;
  idx: integer;
begin
  with Sender as TDButton do
  begin
    idx := _Max(Tag + HeroMagicPage * 6, 0);
    if idx < g_HeroMagicList.Count then
    begin
      pm := PTClientMagic(g_HeroMagicList[idx]);
      //080603增加英雄技能开关功能
      if (pm.Def.wMagicID <> 3) and (pm.Def.wMagicID <> 4) and (pm.Def.wMagicID
        <> 7) and (pm.Def.wMagicID <> 83) then
      begin
        PlaySound(s_norm_button_click);
        if byte(pm.Key) <> byte('1') then
          pm.key := '1'
        else
          pm.key := #0;
        frmMain.SendMagicKeyChange(Pm.Def.wMagicID, pm.Key, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DHeroMag1ClickSound(Sender: TObject; Clicksound: TClickSound);
begin

end;

//客户端画英雄技能键

procedure TFrmDlg.DHeroMag1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  idx, icon: integer;
  d: TDirectDrawSurface;
  pm: PTClientMagic;
begin
  try //程序自动增加
    with Sender as TDButton do
    begin
      idx := _Max(Tag + HeroMagicPage * 6, 0);
      if idx < g_HeroMagicList.Count then
      begin
        pm := PTClientMagic(g_HeroMagicList[idx]);
        if pm.Def.wMagicID<>75 then
        icon := pm.Def.btEffect * 2
        else
        icon:=0;
        if icon >= 0 then
        begin
          d := g_WMagIconImages.Images[icon];
          if d = nil then
            d := g_WMagIconImages.Images[0];
          if d <> nil then
          begin
            //080603增加英雄技能开关功能
            if Byte(pm.Key) > 0 then
              DrawBlend(dsurface, SurfaceX(Left), SurfaceY(Top), d, 0)
            else
              dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d,
                TRUE);
          end;
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DHeroMag1DirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroBujukDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  idx: integer;
  d: TDirectDrawSurface;
  tidx: integer;
  sel: Integer;
begin
  try //程序自动增加
    if HeroStatePage = 0 then
    begin
      sel := -1;
      if Sender = DHeroDress then
        sel := U_DRESS;
      if Sender = DHeroWeapon then
        sel := U_WEAPON;
      if Sender = DHeroHelmet then
        sel := U_HELMET;
      if Sender = DHeroNecklace then
        sel := U_NECKLACE;
      if Sender = DHeroLight then
        sel := U_RIGHTHAND;
      if Sender = DHeroRingL then
        sel := U_RINGL;
      if Sender = DHeroRingR then
        sel := U_RINGR;
      if Sender = DHeroArmRingL then
        sel := U_ARMRINGL;
      if Sender = DHeroArmRingR then
        sel := U_ARMRINGR;
      if Sender = DHeroBujuk then
        sel := U_BUJUK;
      if Sender = DHeroBelt then
        sel := U_BELT;
      if Sender = DHeroBoots then
        sel := U_BOOTS;
      if Sender = DHeroCharm then
        sel := U_CHARM;
      if (sel > -1) and (sel < MAXUSEITEMS) then
      begin
        with TDButton(Sender) do
        begin
          if g_HeroUseItems[sel].S.Name <> '' then
          begin
            idx := g_HeroUseItems[sel].S.Looks;
            if idx >= 0 then
            begin
              d := FrmMain.GetWStateImg(idx);
              if d <> nil then
                dsurface.Draw(SurfaceX(Left + (Width - d.Width) div 2),
                  SurfaceY(Top + (Height - d.Height) div 2),
                  d.ClientRect, d, TRUE);
            end;
            if g_HeroUseItems[sel].Shine <> 0 then
            begin
              d := g_WMain2Images.Images[260 + m_LightIdx];
              if d <> nil then
                DrawBlend(dsurface,
                  SurfaceX(Left - 20),
                  SurfaceY(Top - 22),
                  d, 1);
            end;
          end;
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DHeroBujukDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroBeltMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
  sel: integer;
  iname, d1, d2, d3,d4: string;
  useable: Boolean;
  hcolor: TColor;
  Butt: TDButton;
begin
  try //程序自动增加
    if HeroStatePage <> 0 then
      exit;
    DScreen.ClearHint;
    sel := -1;
    Butt := TDButton(Sender);
    if Sender = DHeroDress then
      sel := U_DRESS;
    if Sender = DHeroWeapon then
      sel := U_WEAPON;
    if Sender = DHeroHelmet then
      sel := U_HELMET;
    if Sender = DHeroNecklace then
      sel := U_NECKLACE;
    if Sender = DHeroLight then
      sel := U_RIGHTHAND;
    if Sender = DHeroRingL then
      sel := U_RINGL;
    if Sender = DHeroRingR then
      sel := U_RINGR;
    if Sender = DHeroArmRingL then
      sel := U_ARMRINGL;
    if Sender = DHeroArmRingR then
      sel := U_ARMRINGR;
    if Sender = DHeroBujuk then
      sel := U_BUJUK;
    if Sender = DHeroBelt then
      sel := U_BELT;
    if Sender = DHeroBoots then
      sel := U_BOOTS;
    if Sender = DHeroCharm then
      sel := U_CHARM;

    if sel >= 0 then
    begin
      g_MouseHeroItem := g_HeroUseItems[sel];
      if (sel = U_HELMET) and (g_HeroUseItems[U_STRAW].MakeIndex > 0) then
      begin
        g_MouseItem := g_HeroUseItems[U_STRAW];
        GetMouseItemInfo(iname, d1, d2, d3,d4, useable);
        if iname <> '' then
        begin
          if g_HeroUseItems[U_STRAW].Dura = 0 then
            hcolor := clRed
          else
            hcolor := clWhite;
          with Butt as TDButton do

            DScreen.ShowHint(SurfaceX(Left + 30),
              SurfaceY(Top - 10),
              iname + '\' + d1 + '\' + d2 + '\' + d3+d4, hcolor, FALSE);
        end;
      end;
      g_MouseItem.S.Name := '';
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DHeroBeltMouseMove'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotHeroBagClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if g_HeronRecogId = 0 then
      exit;
    DHeroItemBag.Visible := not DHeroItemBag.Visible;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotHeroBagClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotMemoClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if not DShopWin.Visible then
    begin
      ShopIdx := 0;
      CheckShopIdx := -1;
      ShowItem := nil;
      ShowItemIdx := 0;
      FrmMain.SendShopList(ShopIdx);
      DShopWin.Visible := True;
      DShopWin.FMovie := False; //让窗口不能移动
      FirMemoIdx := 0;
       FirCheckIdx := -1;
     end else
        DShopWin.Visible :=False;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotMemoClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotClose2Click(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DShopWin.Visible := False;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotClose2Click'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotList1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDButton;
  dd: TDirectDrawSurface;
begin
  try //程序自动增加
    case ShopIdx of
      0: d := DBotList1;
      1: d := DBotList2;
      2: d := DBotList3;
      3: d := DBotList4;
      4: d := DBotList5;
    end;
    if d <> nil then
    begin
      dd := d.WLib.Images[d.FaceIndex];
      if dd <> nil then
        dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd,
          TRUE);
    end;
  {  if g_MasterIdx = 1 then
    begin
      DBotMaster.Visible := True;
      d := DBotMaster;
      dd := d.WLib.Images[d.FaceIndex];
      if dd <> nil then
        dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd,
          TRUE);
    end
    else
      DBotMaster.Visible := False;}
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotList1DirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotList1Click(Sender: TObject; X, Y: Integer);
var
  OldId: Integer;
begin
  try //程序自动增加
    if Sender is TDButton then
    begin
      OldId := ShopIdx;
      if Sender = DBotList1 then
        ShopIdx := 0;
      if Sender = DBotList2 then
        ShopIdx := 1;
      if Sender = DBotList3 then
        ShopIdx := 2;
      if Sender = DBotList4 then
        ShopIdx := 3;
      if Sender = DBotList5 then
        ShopIdx := 4;
      if OldId <> ShopIdx then
      begin
        CheckShopIdx := -1;
        ShopPage := 0;
        ShowItem := nil;
        ShowItemIdx := 0;
        FrmMain.SendShopList(ShopIdx);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotList1Click'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DShopWinDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  I, n, X: integer;
  Item: pTNewFileItem;
  sTop, sPic: string[14];
  sName, sHit, sPic2: string[18];
  ShowList: TList;
  magtop: Integer;
  magline: Integer;
  sMsg, sBody: string;
begin
  try //程序自动增加
    with DShopWin do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      for I := 0 to g_ShopTopList.Count - 1 do
      begin
        if I > 4 then
          break;
        Item := g_ShopTopList.Items[I];
        d := FrmMain.GetWBagItemImg(Item.sItem);
        if d <> nil then
        begin
          dsurface.Draw(SurfaceX(555 + (45 - d.Width) div 2 - 1),
            SurfaceY(65 + (30 - d.Height) div 2 + 1 + I * 65),
            d.ClientRect,
            d, TRUE);
        end;
      end;
      case ShopIdx of
        0: ShowList := g_ShopList1;
        1: ShowList := g_ShopList2;
        2: ShowList := g_ShopList3;
        3: ShowList := g_ShopList4;
        4: ShowList := g_ShopList5;
      end;
      magtop := ShopPage * 10;
      magline := _MIN(ShopPage * 10 + 10, ShowList.Count);
      n := 0;
      X := 0;
      for i := magtop to magline - 1 do
      begin
        Item := ShowList.Items[I];
        d := FrmMain.GetWBagItemImg(Item.sItem);
        if d <> nil then
        begin
          dsurface.Draw(SurfaceX(185 + (n * 172) + (35 - d.Width) div 2 - 1),
            SurfaceY(65 + (35 - d.Height) div 2 + 1 + (X div 2) * 55),
            d.ClientRect,
            d, TRUE);
        end;
        Inc(n);
        Inc(X);
        if n > 1 then
          n := 0;
      end;
      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        Font.Color := clwhite;
        for I := 0 to g_ShopTopList.Count - 1 do
        begin
          if I > 4 then
            break;
          Item := g_ShopTopList.Items[I];
          sTop := Item.sName;
          sPic := Format('%d %s', [Item.sPrict, g_sGameGoldName]);
          if CheckShopIdx > 9999 then
          begin
            if CheckShopIdx = (I + 10000) then
              Font.Color := clRed
            else
              Font.Color := clwhite;
          end;
          TextOut(SurfaceX(526), SurfaceY(100 + I * 65), sTop);
          TextOut(SurfaceX(526), SurfaceY(113 + I * 65), sPic);
        end;
        magtop := ShopPage * 10;
        magline := _MIN(ShopPage * 10 + 10, ShowList.Count);
        n := 0;
        X := 0;
        Font.Color := clwhite;
        for i := magtop to magline - 1 do
        begin
          Item := ShowList.Items[I];
          sName := Item.sName;
          GetValidStr3(Item.sText, sMsg, ['|']);
          sHit := sMsg;
          sPic2 := Format('%d %s', [Item.sPrict, g_sGameGoldName]);
          if CheckShopIdx = i then
            Font.Color := clRed
          else
            Font.Color := clwhite;
          TextOut(SurfaceX(229 + (n * 172)),
            SurfaceY(62 + (X div 2) * 54),
            sName);
          TextOut(SurfaceX(229 + (n * 172)),
            SurfaceY(81 + (X div 2) * 54),
            sHit);
          TextOut(SurfaceX(229 + (n * 172)),
            SurfaceY(95 + (X div 2) * 54),
            sPic2);

          Inc(n);
          Inc(X);
          if n > 1 then
            n := 0;
        end;
        if ShowItem <> nil then
        begin
          sBody := ShowItem.sText;
          n := 0;
          Font.Color := clwhite;
          while TRUE do
          begin
            if sBody = '' then
              break;
            sBody := GetValidStr3(sBody, sMsg, ['|']);
            if sMsg = '' then
              break;
            if n > 0 then
            begin
              TextOut(SurfaceX(25),
                SurfaceY(268 + ((n - 1) * 18)),
                sMsg);
            end;
            inc(n);
          end;

        end;
        Release;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DShopWinDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroStateWindowMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  try //程序自动增加
    DScreen.ClearHint;
    g_MouseHeroItem.S.Name := '';
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DHeroStateWindowMouseMove');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DButFrontClick(Sender: TObject; X, Y: Integer);
var
  ShowList: TList;
begin
  try //程序自动增加
    if Sender = DButFront then
    begin
      if ShopPage > 0 then
        Dec(ShopPage);
    end
    else
    begin
      case ShopIdx of
        0: ShowList := g_ShopList1;
        1: ShowList := g_ShopList2;
        2: ShowList := g_ShopList3;
        3: ShowList := g_ShopList4;
        4: ShowList := g_ShopList5;
      end;
      if ShopPage < (ShowList.Count + 9) div 10 - 1 then
        Inc(ShopPage);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DButFrontClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DShopWinClick(Sender: TObject; X, Y: Integer);
var
  Idx: Integer;
  nX, nY: Integer;
  ShowList: TList;
begin
  try //程序自动增加
    if (X > 517) and (x < 614) and (Y > 65) and (Y < 385) then
    begin
      Idx := Y div 65 - 1;
      if (Idx) < g_ShopTopList.Count then
      begin
        ShowItem := g_ShopTopList.Items[Idx];
        ShowItemIdx := 0;
        CheckShopIdx := Idx + 10000;
        PlaySound(s_glass_button_click);
      end;
    end
    else if (x > 179) and (Y > 59) and (x < 509) and (Y < 326) then
    begin
      case ShopIdx of
        0: ShowList := g_ShopList1;
        1: ShowList := g_ShopList2;
        2: ShowList := g_ShopList3;
        3: ShowList := g_ShopList4;
        4: ShowList := g_ShopList5;
      end;
      Idx := ShopPage * 10;
      nX := X - 179;
      nY := Y - 59;
      Idx := Idx + nX div 179;
      Idx := Idx + nY div 53 * 2;
      if Idx < ShowList.Count then
      begin
        ShowItem := ShowList.Items[Idx];
        ShowItemIdx := 0;
        CheckShopIdx := Idx;
        PlaySound(s_glass_button_click);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DShopWinClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DButShopImgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDButton;
  dd: TDirectDrawSurface;
  n: integer;
begin
  try //程序自动增加
    if Sender is TDButton then
    begin
      d := TDButton(Sender);
      if ShowItem <> nil then
      begin
        n := ShowItem.sEffect;
        if ShowItemIdx < n then
          ShowItemIdx := n;
        if ShowItemIdx > (n + ShowItem.sEffectCount - 1) then
          ShowItemIdx := n;
        dd := d.WLib.Images[ShowItemIdx];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
        if (GetTickCount - ShowItemTime) > 300 then
        begin
          ShowItemTime := GetTickCount;
          Inc(ShowItemIdx);
        end;
      end
      else
      begin
        dd := d.WLib.Images[d.FaceIndex];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DButShopImgDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotBuyClick(Sender: TObject; X, Y: Integer);
var
  DelName: string;
  Idx: Integer;
begin
  try //程序自动增加
    if ShowItem <> nil then
    begin
      if DMessageDlg(Format('确定购买物品 [%s] 吗？', [ShowItem.sName]),
        [mbYes, mbNo]) = mrYes then
      begin
        FrmMain.SendShopBuy(ShowItem.sName);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotBuyClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotHeroExpDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  Bot: TDButton;
  rc: TRect;
  r: Real;
begin
  try //程序自动增加
    with Sender as TDButton do
    begin
      if g_HeronRecogId = 0 then
        exit;
      Bot := TDButton(Sender);
      if Sender = DBotHeroHP then
      begin
        if g_HeroAbil.HP > 0 then
        begin
          d := WLib.Images[Bot.FaceIndex];
          if d <> nil then
          begin
            rc := d.ClientRect;
            if g_HeroAbil.HP > 0 then
              r := g_HeroAbil.MaxHP / g_HeroAbil.HP
            else
              r := 0;
            if r > 0 then
              rc.Right := Round(rc.Right / r)
            else
              rc.Right := 0;
            dsurface.Draw(SurfaceX(Left), SurfaceY(Top), rc, d, FALSE);
          end;
        end;
      end
      else if Sender = DBotHeroMP then
      begin
        if g_HeroAbil.MP > 0 then
        begin
          d := WLib.Images[Bot.FaceIndex];
          if d <> nil then
          begin
            rc := d.ClientRect;
            if g_HeroAbil.MP > 0 then
              r := g_HeroAbil.MaxMP / g_HeroAbil.MP
            else
              r := 0;
            if r > 0 then
              rc.Right := Round(rc.Right / r)
            else
              rc.Right := 0;
            dsurface.Draw(SurfaceX(Left), SurfaceY(Top), rc, d, FALSE);
          end;
        end;
      end
      else if Sender = DBotHeroExp then
      begin
        if g_HeroAbil.Exp > 0 then
        begin
          d := WLib.Images[Bot.FaceIndex];
          if d <> nil then
          begin
            rc := d.ClientRect;
            if g_HeroAbil.Exp > 0 then
              r := g_HeroAbil.MaxExp / g_HeroAbil.Exp
            else
              r := 0;
            if r > 0 then
              rc.Right := Round(rc.Right / r)
            else
              rc.Right := 0;
            dsurface.Draw(SurfaceX(Left), SurfaceY(Top), rc, d, FALSE);
          end;
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotHeroExpDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroMag1DirectPaintt(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
  try //程序自动增加
    //
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotHeroHeadDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroItemGridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDirectDrawSurface);
var
  idx,n: integer;
  d: TDirectDrawSurface;
  sText:string;
begin
  try //程序自动增加
    idx := ACol + ARow * DHeroItemGrid.ColCount + 6;
    if idx in [6..MAXBAGITEM - 1] then
    begin
      if g_HeroItemArr[idx].S.Name <> '' then
      begin
        d := FrmMain.GetWBagItemImg(g_HeroItemArr[idx].S.Looks);
        if d <> nil then
          with DHeroItemGrid do
          begin
            dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
              d.ClientRect,
              d, TRUE);
          if (g_HeroItemArr[idx].Dura>1) and (g_HeroItemArr[idx].S.StdMode=0) then
           begin
             sText:=IntToStr(g_HeroItemArr[idx].Dura);
             n := dsurface.Canvas.TextWidth(sText);
             SetBkMode(dsurface.Canvas.Handle,TRANSPARENT);
             dsurface.Canvas.Font.Color := clWhite;
             dsurface.Canvas.Font.Style:=[fsBold];
             dsurface.Canvas.TextOut(SurfaceX(Rect.Left + d.Width-n),SurfaceY(Rect.Top),sText);
             dsurface.Canvas.Font.Style:=dsurface.Canvas.Font.Style-[fsBold];
             dsurface.Canvas.Release;
           end;
          end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DHeroItemGridGridPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroItemGridDblClick(Sender: TObject);
var
  idx, i: integer;
  keyvalue: TKeyBoardState;
  cu: TClientItem;
begin
  try //程序自动增加
    idx := DHeroItemGrid.Col + DHeroItemGrid.Row * DHeroItemGrid.ColCount + 6;
    if idx in [6..MAXBAGITEM - 1] then
    begin
      if g_HeroItemArr[idx].S.Name <> '' then
      begin
        FillChar(keyvalue, sizeof(TKeyboardState), #0);
        GetKeyboardState(keyvalue);
        if keyvalue[VK_CONTROL] = $80 then
        begin
          cu := g_HeroItemArr[idx];
          g_HeroItemArr[idx].S.Name := '';
          AddItemHeroBag(cu);
        end
        else if CheckHeroEatItem(g_HeroItemArr[idx]) then
        begin
          FrmMain.HeroEatItem(Idx);
          //FrmMain.SendHeroEat (g_ItemArr[idx].MakeIndex,g_ItemArr[idx]);
        end;
      end
      else
      begin
        if g_boItemMoving and (g_MovingItem.Item.S.Name <> '') and
          (g_MovingItem.Hero) then
        begin
          FillChar(keyvalue, sizeof(TKeyboardState), #0);
          GetKeyboardState(keyvalue);
          if keyvalue[VK_CONTROL] = $80 then
          begin
            cu := g_MovingItem.Item;
            g_MovingItem.Item.S.Name := '';
            //g_MovingItem.Hero:=True;
            g_boItemMoving := FALSE;
            AddItemHeroBag(cu);
          end
          else if (g_MovingItem.Index = idx) and
            (CheckHeroEatItem(g_HeroItemArr[idx])) then
          begin
            {  if (g_MovingItem.Item.Dura>1) and (g_MovingItem.Item.S.StdMode=0) then
              begin
                Dec(g_MovingItem.Item.Dura);
                cu:=g_MovingItem.Item;
                FrmMain.HeroEatItem(-1);
                g_HeroItemArr[idx]:=cu;
              end else  }
               FrmMain.HeroEatItem(-1);
          end;
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DHeroItemGridDblClick');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroItemGridGridSelect(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  idx, mi: integer;
  temp: TClientItem;
begin
  try //程序自动增加
    idx := ACol + ARow * DHeroItemGrid.ColCount + 6;
    if idx in [6..MAXBAGITEM - 1] then
    begin
      if not g_boItemMoving then
      begin
        if g_HeroItemArr[idx].S.Name <> '' then
        begin
          g_boItemMoving := TRUE;
          g_MovingItem.Index := idx;
          g_MovingItem.Item := g_HeroItemArr[idx];
          g_MovingItem.Hero := True;
          g_HeroItemArr[idx].S.Name := '';
          ItemClickSound(g_HeroItemArr[idx].S);
        end;
      end
      else
      begin
        mi := g_MovingItem.Index;
        if (mi = -97) or (mi = -98) or (mi = -99) then
          exit;
        if (mi < 0) and (mi >= -14 {-9}) then
        begin
          if not g_MovingItem.Hero then
            exit;
          g_WaitingUseItem := g_MovingItem;
          FrmMain.SendHeroTakeOffItem(-(g_MovingItem.Index + 1),
            g_MovingItem.Item.MakeIndex, g_MovingItem.Item.S.Name);
          g_MovingItem.Item.S.name := '';
          g_boItemMoving := FALSE;
        end
        else
        begin
          //if (mi <= -20) and (mi > -30) then
             //DealItemReturnBag (g_MovingItem.Item);
          if not g_MovingItem.Hero then
          begin
            if g_WaitingUseItem.Item.S.Name = '' then
            begin
              g_WaitingUseItem := g_MovingItem;
              FrmMain.SendMasterItemToHeroBag(g_MovingItem.Item.MakeIndex,
                g_MovingItem.Item.S.Name);
              g_MovingItem.Item.S.name := '';
              g_boItemMoving := FALSE;
            end;
            exit;
          end;
          if g_HeroItemArr[idx].S.Name <> '' then
          begin
           if ((g_MovingItem.Item.S.StdMode=9) and (g_MovingItem.Item.S.Shape=1) and
           (g_HeroItemArr[idx].S.StdMode=2) and (g_HeroItemArr[idx].S.reserved=56)) or
           ((g_MovingItem.Item.S.StdMode=0) and (g_HeroItemArr[idx].S.StdMode=0) and
           (g_MovingItem.Item.S.Name=g_HeroItemArr[idx].S.Name)) then //泉水叠加到泉水罐 或药品叠加
           begin
            g_WaitingUseItem := g_MovingItem;
            frmMain.SendItemFold(g_MovingItem.Item.MakeIndex,g_HeroItemArr[idx].MakeIndex,1);
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
           end else
           begin
            temp := g_HeroItemArr[idx];
            g_HeroItemArr[idx] := g_MovingItem.Item;
            g_MovingItem.Index := idx;
            g_MovingItem.Item := temp;
            g_MovingItem.Hero := True;
            end;
          end
          else
          begin
            g_HeroItemArr[idx] := g_MovingItem.Item;
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
          end;
        end;
      end;
    end;
    ArrangeItemHeroBag;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DHeroItemGridGridSelect');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroLiquorProgressDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  rc:TRect;
begin
try
with DHeroLiquorProgress do
begin
  d := g_WMain2Images.Images[575];
  if d <> nil then
    dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d,True);
  d := g_WMain2Images.Images[576];
  if d <> nil then
  begin
    rc := d.ClientRect;
    rc.Right := Round((rc.Right-rc.Left) / 100 * g_bLiquorProgress);
    dsurface.Draw(SurfaceX(Left), SurfaceY(Top), rc, d, True);
  end;
end;
except

end;
end;

procedure TFrmDlg.DHeroLiquorProgressMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
try
 if g_MySelf<>nil then
 begin
    with DHeroLiquorProgress do
      DScreen.ShowHint(SurfaceX(Left), SurfaceY(Top+Height+20),
       '酒量提升进度'+IntToStr(g_bLiquorProgress)+'%', clWhite,True);
 end;
except

end;
end;

procedure TFrmDlg.DHeroWeaponClick(Sender: TObject; X, Y: Integer);
var
  where, n, sel: integer;
  flag, movcancel: Boolean;
begin
  try //程序自动增加
    if g_HeronRecogId = 0 then
      exit;
    if HeroStatePage <> 0 then
      exit;
    if g_boItemMoving then
    begin
      flag := FALSE;
      movcancel := FALSE;
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) or
        (g_MovingItem.Index = -99) then
        exit;
      if (g_MovingItem.Item.S.Name = '') or (g_WaitingUseItem.Item.S.Name <> '')
        then
        exit;
      if not g_MovingItem.Hero then
        exit;
      where := GetTakeOnPosition(g_MovingItem.Item.S.StdMode);
      if g_MovingItem.Index >= 0 then
      begin
        case where of
          U_DRESS:
            begin
              if Sender = DHeroDress then
              begin
                if g_HerobtSex = 0 then //巢磊
                  if g_MovingItem.Item.S.StdMode <> 10 then //巢磊渴
                    exit;
                if g_HerobtSex = 1 then //咯磊
                  if g_MovingItem.Item.S.StdMode <> 11 then //咯磊渴
                    exit;
                flag := TRUE;
              end;
            end;
          U_WEAPON:
            begin
              if Sender = DHeroWEAPON then
              begin
                flag := TRUE;
              end;
            end;
          U_NECKLACE:
            begin
              if Sender = DHeroNecklace then
                flag := TRUE;
            end;
          U_RIGHTHAND:
            begin
              if Sender = DHeroLight then
                flag := TRUE;
            end;
          U_HELMET, U_STRAW:
            begin
              if Sender = DHeroHelmet then
                flag := TRUE;
            end;
          U_RINGR, U_RINGL:
            begin
              if Sender = DHeroRingL then
              begin
                where := U_RINGL;
                flag := TRUE;
              end;
              if Sender = DHeroRingR then
              begin
                where := U_RINGR;
                flag := TRUE;
              end;
            end;
          U_ARMRINGR, U_ARMRINGL:
            begin
              if Sender = DHeroArmRingL then
              begin
                where := U_ARMRINGL;
                flag := TRUE;
              end;
              if Sender = DHeroArmRingR then
              begin
                where := U_ARMRINGR;
                flag := TRUE;
              end;
            end;
          U_BUJUK:
            begin
              if Sender = DHeroBujuk then
              begin
                where := U_BUJUK;
                flag := TRUE;
              end;
              if Sender = DHeroArmRingL then
              begin
                where := U_ARMRINGL;
                flag := TRUE;
              end;
            end;
          U_BELT:
            begin
              if Sender = DHeroBelt then
              begin
                where := U_BELT;
                flag := TRUE;
              end;
            end;
          U_BOOTS:
            begin
              if Sender = DHeroBoots then
              begin
                where := U_BOOTS;
                flag := TRUE;
              end;
            end;
          U_CHARM:
            begin
              if Sender = DHeroCharm then
              begin
                where := U_CHARM;
                flag := TRUE;
              end;
            end;
        end;
      end
      else
      begin
        n := -(g_MovingItem.Index + 1);
        if n in [0..MAXUSEITEMS] then
        begin
          ItemClickSound(g_MovingItem.Item.S);
          g_HeroUseItems[n] := g_MovingItem.Item;
          g_MovingItem.Item.S.Name := '';
          g_boItemMoving := FALSE;
        end;
      end;
      if flag then
      begin
        ItemClickSound(g_MovingItem.Item.S);
        if g_MovingItem.Item.S.StdMode=42 then //火龙神品
        begin
         if g_HeroUseItems[U_BUJUK].S.StdMode=25 then //火龙之心在身上
         begin
            g_WaitingUseItem := g_MovingItem;
            g_WaitingUseItem.Index := where;
            FrmMain.SendHeroIncFireDrakeHeartDander(g_MovingItem.Item.MakeIndex);
            g_MovingItem.Item.S.Name := '';
            g_boItemMoving := FALSE;
         end else
         begin   //没在身上把火龙神品放回包裹
           AddItemHeroBag(g_MovingItem.Item);
           g_MovingItem.Item.S.Name := '';
           g_boItemMoving := FALSE;
         end;
        end else
        begin  //非火龙神品
         g_WaitingUseItem := g_MovingItem;
         g_WaitingUseItem.Index := where;
         FrmMain.SendHeroTakeOnItem(where, g_MovingItem.Item.MakeIndex,
          g_MovingItem.Item.S.Name);
         g_MovingItem.Item.S.Name := '';
         g_boItemMoving := FALSE;
        end;
      end;
    end
    else
    begin
      flag := FALSE;
      if (g_MovingItem.Item.S.Name <> '') or (g_WaitingUseItem.Item.S.Name <> '')
        then
        exit;
      sel := -1;
      if Sender = DHeroDress then
        sel := U_DRESS;
      if Sender = DHeroWeapon then
        sel := U_WEAPON;
      if Sender = DHeroHelmet then
      begin
        sel := U_HELMET;
        if g_HeroUseItems[U_STRAW].S.Name <> '' then
          sel := U_STRAW;
      end;
      if Sender = DHeroNecklace then
        sel := U_NECKLACE;
      if Sender = DHeroLight then
        sel := U_RIGHTHAND;
      if Sender = DHeroRingL then
        sel := U_RINGL;
      if Sender = DHeroRingR then
        sel := U_RINGR;
      if Sender = DHeroArmRingL then
        sel := U_ARMRINGL;
      if Sender = DHeroArmRingR then
        sel := U_ARMRINGR;

      if Sender = DHeroBujuk then
        sel := U_BUJUK;
      if Sender = DHeroBelt then
        sel := U_BELT; //
      if Sender = DHeroBoots then
        sel := U_BOOTS;
      if Sender = DHeroCharm then
        sel := U_CHARM;

      if sel >= 0 then
      begin
        if g_HeroUseItems[sel].S.Name <> '' then
        begin
          ItemClickSound(g_HeroUseItems[sel].S);
          g_MovingItem.Index := -(sel + 1);
          g_MovingItem.Item := g_HeroUseItems[sel];
          g_MovingItem.Hero := True;
          g_HeroUseItems[sel].S.Name := '';
          g_boItemMoving := TRUE;
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DHeroWeaponClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHooKKey3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
if Sender=DHooKKey3 then
begin
  g_WgInfo.bHookey1ShiftState:=Byte(Shift);
  g_WgInfo.bHookey1key:=Key;
  if (g_WgInfo.bHookey1ShiftState=g_WgInfo.bHookey2ShiftState) and (g_WgInfo.bHookey1key=g_WgInfo.bHookey2key) then
  begin
     g_WgInfo.bHookey2ShiftState:=0;
     g_WgInfo.bHookey2key:=0;
     DHooKKey5.Text:='';
  end;
  if (g_WgInfo.bHookey1ShiftState=g_WgInfo.bHookey3ShiftState) and (g_WgInfo.bHookey1key=g_WgInfo.bHookey3key) then
  begin
    g_WgInfo.bHookey3ShiftState:=0;
     g_WgInfo.bHookey3key:=0;
     DHooKKey7.Text:='';
  end;
  if (g_WgInfo.bHookey1ShiftState=g_WgInfo.bHookey4ShiftState) and (g_WgInfo.bHookey1key=g_WgInfo.bHookey4key) then
  begin
    g_WgInfo.bHookey4ShiftState:=0;
     g_WgInfo.bHookey4key:=0;
     DHooKKey9.Text:='';
  end;
  if (g_WgInfo.bHookey1ShiftState=g_WgInfo.bHookey5ShiftState) and (g_WgInfo.bHookey1key=g_WgInfo.bHookey5key) then
  begin
    g_WgInfo.bHookey5ShiftState:=0;
     g_WgInfo.bHookey5key:=0;
     DHooKKey11.Text:='';
  end;
  if (g_WgInfo.bHookey1ShiftState=g_WgInfo.bHookey6ShiftState) and (g_WgInfo.bHookey1key=g_WgInfo.bHookey6key) then
  begin
    g_WgInfo.bHookey6ShiftState:=0;
     g_WgInfo.bHookey6key:=0;
     DHooKKey13.Text:='';
  end;
  if (g_WgInfo.bHookey1ShiftState=g_WgInfo.bHookey7ShiftState) and (g_WgInfo.bHookey1key=g_WgInfo.bHookey7key) then
  begin
    g_WgInfo.bHookey7ShiftState:=0;
     g_WgInfo.bHookey7key:=0;
     DHooKKey15.Text:='';
  end;
end else if Sender=DHooKKey5 then
begin
  g_WgInfo.bHookey2ShiftState:=Byte(Shift);
  g_WgInfo.bHookey2key:=Key;
  if (g_WgInfo.bHookey2ShiftState=g_WgInfo.bHookey1ShiftState) and (g_WgInfo.bHookey2key=g_WgInfo.bHookey1key) then
  begin
    g_WgInfo.bHookey1ShiftState:=0;
     g_WgInfo.bHookey1key:=0;
     DHooKKey3.Text:='';
  end;
  if (g_WgInfo.bHookey2ShiftState=g_WgInfo.bHookey3ShiftState) and (g_WgInfo.bHookey2key=g_WgInfo.bHookey3key) then
  begin
    g_WgInfo.bHookey3ShiftState:=0;
    g_WgInfo.bHookey3key:=0;
    DHooKKey7.Text:='';
  end;
  if (g_WgInfo.bHookey2ShiftState=g_WgInfo.bHookey4ShiftState) and (g_WgInfo.bHookey2key=g_WgInfo.bHookey4key) then
  begin
    g_WgInfo.bHookey4ShiftState:=0;
     g_WgInfo.bHookey4key:=0;
     DHooKKey9.Text:='';
  end;
   if (g_WgInfo.bHookey2ShiftState=g_WgInfo.bHookey5ShiftState) and (g_WgInfo.bHookey2key=g_WgInfo.bHookey5key) then
  begin
    g_WgInfo.bHookey5ShiftState:=0;
     g_WgInfo.bHookey5key:=0;
     DHooKKey11.Text:='';
  end;
   if (g_WgInfo.bHookey2ShiftState=g_WgInfo.bHookey6ShiftState) and (g_WgInfo.bHookey2key=g_WgInfo.bHookey6key) then
  begin
    g_WgInfo.bHookey6ShiftState:=0;
     g_WgInfo.bHookey6key:=0;
     DHooKKey13.Text:='';
  end;
   if (g_WgInfo.bHookey2ShiftState=g_WgInfo.bHookey7ShiftState) and (g_WgInfo.bHookey2key=g_WgInfo.bHookey7key) then
  begin
    g_WgInfo.bHookey7ShiftState:=0;
     g_WgInfo.bHookey7key:=0;
     DHooKKey15.Text:='';
  end;
end else if Sender=DHooKKey7 then
begin
  g_WgInfo.bHookey3ShiftState:=Byte(Shift);
  g_WgInfo.bHookey3key:=Key;
  if (g_WgInfo.bHookey3ShiftState=g_WgInfo.bHookey1ShiftState) and (g_WgInfo.bHookey3key=g_WgInfo.bHookey1key) then
  begin
    g_WgInfo.bHookey1ShiftState:=0;
    g_WgInfo.bHookey1key:=0;
    DHooKKey3.Text:='';
  end;
  if (g_WgInfo.bHookey3ShiftState=g_WgInfo.bHookey2ShiftState) and (g_WgInfo.bHookey3key=g_WgInfo.bHookey2key) then
  begin
     g_WgInfo.bHookey2ShiftState:=0;
     g_WgInfo.bHookey2key:=0;
     DHooKKey5.Text:='';
  end;
  if (g_WgInfo.bHookey3ShiftState=g_WgInfo.bHookey4ShiftState) and (g_WgInfo.bHookey3key=g_WgInfo.bHookey4key) then
  begin
    g_WgInfo.bHookey4ShiftState:=0;
     g_WgInfo.bHookey4key:=0;
     DHooKKey9.Text:='';
  end;
  if (g_WgInfo.bHookey3ShiftState=g_WgInfo.bHookey5ShiftState) and (g_WgInfo.bHookey3key=g_WgInfo.bHookey5key) then
  begin
    g_WgInfo.bHookey5ShiftState:=0;
     g_WgInfo.bHookey5key:=0;
     DHooKKey11.Text:='';
  end;
  if (g_WgInfo.bHookey3ShiftState=g_WgInfo.bHookey6ShiftState) and (g_WgInfo.bHookey3key=g_WgInfo.bHookey6key) then
  begin
    g_WgInfo.bHookey6ShiftState:=0;
     g_WgInfo.bHookey6key:=0;
     DHooKKey13.Text:='';
  end;
  if (g_WgInfo.bHookey3ShiftState=g_WgInfo.bHookey7ShiftState) and (g_WgInfo.bHookey3key=g_WgInfo.bHookey7key) then
  begin
    g_WgInfo.bHookey7ShiftState:=0;
     g_WgInfo.bHookey7key:=0;
     DHooKKey15.Text:='';
  end;
end else if Sender=DHooKKey9 then
begin
  g_WgInfo.bHookey4ShiftState:=Byte(Shift);
  g_WgInfo.bHookey4key:=Key;
  if (g_WgInfo.bHookey4ShiftState=g_WgInfo.bHookey1ShiftState) and (g_WgInfo.bHookey4key=g_WgInfo.bHookey1key) then
  begin
    g_WgInfo.bHookey1ShiftState:=0;
    g_WgInfo.bHookey1key:=0;
    DHooKKey3.Text:='';
  end;
  if (g_WgInfo.bHookey4ShiftState=g_WgInfo.bHookey2ShiftState) and (g_WgInfo.bHookey4key=g_WgInfo.bHookey2key) then
  begin
     g_WgInfo.bHookey2ShiftState:=0;
     g_WgInfo.bHookey2key:=0;
     DHooKKey5.Text:='';
  end;
  if (g_WgInfo.bHookey4ShiftState=g_WgInfo.bHookey3ShiftState) and (g_WgInfo.bHookey4key=g_WgInfo.bHookey3key) then
  begin
    g_WgInfo.bHookey3ShiftState:=0;
    g_WgInfo.bHookey3key:=0;
    DHooKKey7.Text:='';
  end;
  if (g_WgInfo.bHookey4ShiftState=g_WgInfo.bHookey5ShiftState) and (g_WgInfo.bHookey4key=g_WgInfo.bHookey5key) then
  begin
    g_WgInfo.bHookey5ShiftState:=0;
     g_WgInfo.bHookey5key:=0;
     DHooKKey11.Text:='';
  end;
  if (g_WgInfo.bHookey4ShiftState=g_WgInfo.bHookey6ShiftState) and (g_WgInfo.bHookey4key=g_WgInfo.bHookey6key) then
  begin
    g_WgInfo.bHookey6ShiftState:=0;
     g_WgInfo.bHookey6key:=0;
     DHooKKey13.Text:='';
  end;
  if (g_WgInfo.bHookey4ShiftState=g_WgInfo.bHookey7ShiftState) and (g_WgInfo.bHookey4key=g_WgInfo.bHookey7key) then
  begin
    g_WgInfo.bHookey7ShiftState:=0;
     g_WgInfo.bHookey7key:=0;
     DHooKKey15.Text:='';
  end;
end else if Sender=DHooKKey11 then
begin
  g_WgInfo.bHookey5ShiftState:=Byte(Shift);
  g_WgInfo.bHookey5key:=Key;
  if (g_WgInfo.bHookey5ShiftState=g_WgInfo.bHookey1ShiftState) and (g_WgInfo.bHookey5key=g_WgInfo.bHookey1key) then
  begin
    g_WgInfo.bHookey1ShiftState:=0;
    g_WgInfo.bHookey1key:=0;
    DHooKKey3.Text:='';
  end;
  if (g_WgInfo.bHookey5ShiftState=g_WgInfo.bHookey2ShiftState) and (g_WgInfo.bHookey5key=g_WgInfo.bHookey2key) then
  begin
     g_WgInfo.bHookey2ShiftState:=0;
     g_WgInfo.bHookey2key:=0;
     DHooKKey5.Text:='';
  end;
  if (g_WgInfo.bHookey5ShiftState=g_WgInfo.bHookey3ShiftState) and (g_WgInfo.bHookey5key=g_WgInfo.bHookey3key) then
  begin
    g_WgInfo.bHookey3ShiftState:=0;
    g_WgInfo.bHookey3key:=0;
    DHooKKey7.Text:='';
  end;
  if (g_WgInfo.bHookey5ShiftState=g_WgInfo.bHookey4ShiftState) and (g_WgInfo.bHookey5key=g_WgInfo.bHookey4key) then
  begin
    g_WgInfo.bHookey4ShiftState:=0;
     g_WgInfo.bHookey4key:=0;
     DHooKKey9.Text:='';
  end;
  if (g_WgInfo.bHookey5ShiftState=g_WgInfo.bHookey6ShiftState) and (g_WgInfo.bHookey5key=g_WgInfo.bHookey6key) then
  begin
    g_WgInfo.bHookey6ShiftState:=0;
     g_WgInfo.bHookey6key:=0;
     DHooKKey13.Text:='';
  end;
  if (g_WgInfo.bHookey5ShiftState=g_WgInfo.bHookey7ShiftState) and (g_WgInfo.bHookey5key=g_WgInfo.bHookey7key) then
  begin
    g_WgInfo.bHookey7ShiftState:=0;
     g_WgInfo.bHookey7key:=0;
     DHooKKey15.Text:='';
  end;
end else if Sender=DHooKKey13 then
begin
  g_WgInfo.bHookey6ShiftState:=Byte(Shift);
  g_WgInfo.bHookey6key:=Key;
  if (g_WgInfo.bHookey6ShiftState=g_WgInfo.bHookey1ShiftState) and (g_WgInfo.bHookey6key=g_WgInfo.bHookey1key) then
  begin
    g_WgInfo.bHookey1ShiftState:=0;
    g_WgInfo.bHookey1key:=0;
    DHooKKey3.Text:='';
  end;
  if (g_WgInfo.bHookey6ShiftState=g_WgInfo.bHookey2ShiftState) and (g_WgInfo.bHookey6key=g_WgInfo.bHookey2key) then
  begin
     g_WgInfo.bHookey2ShiftState:=0;
     g_WgInfo.bHookey2key:=0;
     DHooKKey5.Text:='';
  end;
  if (g_WgInfo.bHookey6ShiftState=g_WgInfo.bHookey3ShiftState) and (g_WgInfo.bHookey6key=g_WgInfo.bHookey3key) then
  begin
    g_WgInfo.bHookey3ShiftState:=0;
    g_WgInfo.bHookey3key:=0;
    DHooKKey7.Text:='';
  end;
  if (g_WgInfo.bHookey6ShiftState=g_WgInfo.bHookey4ShiftState) and (g_WgInfo.bHookey6key=g_WgInfo.bHookey4key) then
  begin
    g_WgInfo.bHookey4ShiftState:=0;
     g_WgInfo.bHookey4key:=0;
     DHooKKey9.Text:='';
  end;
  if (g_WgInfo.bHookey6ShiftState=g_WgInfo.bHookey5ShiftState) and (g_WgInfo.bHookey6key=g_WgInfo.bHookey5key) then
  begin
    g_WgInfo.bHookey5ShiftState:=0;
     g_WgInfo.bHookey5key:=0;
     DHooKKey11.Text:='';
  end;
  if (g_WgInfo.bHookey6ShiftState=g_WgInfo.bHookey7ShiftState) and (g_WgInfo.bHookey6key=g_WgInfo.bHookey7key) then
  begin
    g_WgInfo.bHookey7ShiftState:=0;
     g_WgInfo.bHookey7key:=0;
     DHooKKey15.Text:='';
  end;
end else if Sender=DHooKKey15 then
begin
  g_WgInfo.bHookey7ShiftState:=Byte(Shift);
  g_WgInfo.bHookey7key:=Key;
  if (g_WgInfo.bHookey7ShiftState=g_WgInfo.bHookey1ShiftState) and (g_WgInfo.bHookey7key=g_WgInfo.bHookey1key) then
  begin
    g_WgInfo.bHookey1ShiftState:=0;
    g_WgInfo.bHookey1key:=0;
    DHooKKey3.Text:='';
  end;
  if (g_WgInfo.bHookey7ShiftState=g_WgInfo.bHookey2ShiftState) and (g_WgInfo.bHookey7key=g_WgInfo.bHookey2key) then
  begin
     g_WgInfo.bHookey2ShiftState:=0;
     g_WgInfo.bHookey2key:=0;
     DHooKKey5.Text:='';
  end;
  if (g_WgInfo.bHookey7ShiftState=g_WgInfo.bHookey3ShiftState) and (g_WgInfo.bHookey7key=g_WgInfo.bHookey3key) then
  begin
    g_WgInfo.bHookey3ShiftState:=0;
    g_WgInfo.bHookey3key:=0;
    DHooKKey7.Text:='';
  end;
  if (g_WgInfo.bHookey7ShiftState=g_WgInfo.bHookey4ShiftState) and (g_WgInfo.bHookey7key=g_WgInfo.bHookey4key) then
  begin
    g_WgInfo.bHookey4ShiftState:=0;
     g_WgInfo.bHookey4key:=0;
     DHooKKey9.Text:='';
  end;
  if (g_WgInfo.bHookey7ShiftState=g_WgInfo.bHookey5ShiftState) and (g_WgInfo.bHookey7key=g_WgInfo.bHookey5key) then
  begin
    g_WgInfo.bHookey5ShiftState:=0;
     g_WgInfo.bHookey5key:=0;
     DHooKKey11.Text:='';
  end;
  if (g_WgInfo.bHookey7ShiftState=g_WgInfo.bHookey6ShiftState) and (g_WgInfo.bHookey7key=g_WgInfo.bHookey6key) then
  begin
    g_WgInfo.bHookey6ShiftState:=0;
     g_WgInfo.bHookey6key:=0;
     DHooKKey13.Text:='';
  end;
end;
end;

procedure TFrmDlg.DHooKKey3MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
if Button=mbRight then
begin
    TDHooKKey(Sender).Text:='';
    if Sender=DHooKKey3 then
    begin
    g_WgInfo.bHookey1ShiftState:=0;
    g_WgInfo.bHookey1key:=0;
    end else if Sender=DHooKKey5 then
    begin
    g_WgInfo.bHookey2ShiftState:=0;
    g_WgInfo.bHookey2key:=0;
    end else if Sender=DHooKKey7 then
    begin
    g_WgInfo.bHookey3ShiftState:=0;
    g_WgInfo.bHookey3key:=0;
    end else if Sender=DHooKKey9 then
    begin
    g_WgInfo.bHookey4ShiftState:=0;
    g_WgInfo.bHookey4key:=0;
    end else if Sender=DHooKKey11 then
    begin
    g_WgInfo.bHookey5ShiftState:=0;
    g_WgInfo.bHookey5key:=0;
    end else if Sender=DHooKKey13 then
    begin
    g_WgInfo.bHookey6ShiftState:=0;
    g_WgInfo.bHookey6key:=0;
    end else if Sender=DHooKKey15 then
    begin
    g_WgInfo.bHookey7ShiftState:=0;
    g_WgInfo.bHookey7key:=0;
    end;
end;
end;

procedure TFrmDlg.DBotHeroHeadClick(Sender: TObject; X, Y: Integer);
var
  idx, mi: integer;
  temp: TClientItem;
begin
  try //程序自动增加
    if not g_boItemMoving then
      exit;
    mi := g_MovingItem.Index;
    if (mi = -97) or (mi = -98) then
      exit;
    if (mi < 0) and (mi >= -14 {-9}) then
    begin
      if not g_MovingItem.Hero then
        exit;
      g_WaitingUseItem := g_MovingItem;
      FrmMain.SendHeroTakeOffItem(-(g_MovingItem.Index + 1),
        g_MovingItem.Item.MakeIndex, g_MovingItem.Item.S.Name);
      g_MovingItem.Item.S.name := '';
      g_boItemMoving := FALSE;
    end
    else
    begin
      if not g_MovingItem.Hero then
      begin
        if g_WaitingUseItem.Item.S.Name = '' then
        begin
          g_WaitingUseItem := g_MovingItem;
          FrmMain.SendMasterItemToHeroBag(g_MovingItem.Item.MakeIndex,
            g_MovingItem.Item.S.Name);
          g_MovingItem.Item.S.name := '';
          g_boItemMoving := FALSE;
        end;
      end;
    end;
    ArrangeItemHeroBag;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotHeroHeadClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroItemGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  idx: integer;
  temp: TClientItem;
  iname, d1, d2, d3: string;
  useable: Boolean;
  hcolor: TColor;
begin
  try //程序自动增加
    m_nMouseIdx := 0;
    if ssRight in Shift then
    begin
      if g_boItemMoving then
        DHeroItemGridGridSelect(self, ACol, ARow, Shift);
    end
    else
    begin
      idx := ACol + ARow * DHeroItemGrid.ColCount + 6 {骇飘傍埃};
      if idx in [6..MAXBAGITEM - 1] then
      begin
        g_HeroMouseItem := g_HeroItemArr[idx];
        m_nMouseIdx := idx;
        if g_HeroMouseItem.S.Name <> '' then
        begin
          iname := '';
          if (GetTakeOnPosition(g_HeroMouseItem.S.StdMode) <> -1) then
          begin
            iname := '右键穿装备';
            if (g_HeroMouseItem.S.StdMode = 30) and
              (g_HeroMouseItem.S.Shape in [51..100]) then
              iname := iname + '\使用 Ctrl + M 快速切换骑马状态';
          end;
         if g_BagShowItemDec then
         begin
          iname := iname + '\' + g_HeroMouseItem.Desc;
          with DHeroItemGrid do
            DScreen.ShowHint(SurfaceX(Left + ACol * ColWidth),
              SurfaceY(Top + (ARow + 1) * RowHeight),
              iname, clWhite, FALSE);
         end;
        end
        else
        begin
          m_nMouseIdx := 0;
          DScreen.ClearHint;
        end;
      end;
    end;

    {   m_nMouseIdx:=0;
    if ssRight in Shift then begin
       if g_boItemMoving then
          DItemGridGridSelect (self, ACol, ARow, Shift);
    end else begin
       idx := ACol + ARow * DItemGrid.ColCount + 6{骇飘傍埃};
    { if idx in [6..MAXBAGITEM-1] then begin
        g_MouseItem := g_ItemArr[idx];
        m_nMouseIdx:=idx;
        if (g_MouseItem.S.Name<>'') and(GetLevelPosition(g_MouseItem.S.StdMode)) then begin
         with DItemGrid do
              DScreen.ShowHint (SurfaceX(Left + ACol*ColWidth),
                                SurfaceY(Top + (ARow+1)*RowHeight),
                                '右键穿装备',clWhite, FALSE);
        end else begin
           m_nMouseIdx:=0;
           DScreen.ClearHint;
        end;  }
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DHeroItemGridGridMouseMove');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroItemBagDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d0, d1, d2, d3,d4: string;
  n: integer;
  useable: Boolean;
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    if (g_HeronRecogId = 0) or (HeroBagImage = 0) then
    begin
      Visible := False;
      exit;
    end;
    with DHeroItemBag do
    begin
      d := WLib.Images[HeroBagImage];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      if g_HeroMouseItem.S.Name <> '' then
      begin
        g_MouseItem := g_HeroMouseItem;
        GetMouseItemInfo(d0, d1, d2, d3,d4, useable, True);
        with dsurface.Canvas do
        begin
          SetBkMode(Handle, TRANSPARENT);
          Font.Color := clWhite;

          if (d0 <> '') and (g_HeroMouseItem.S.Name <> '') then
          begin
            n := TextWidth(d0);
            Font.Color := clYellow;
            TextOut(SurfaceX(Left + 13 {70}), SurfaceY(Top + d.Height - 54),
              d0);
            Font.Color := clWhite;
            TextOut(SurfaceX(Left + 13 {70}) + n, SurfaceY(Top + d.Height - 54),
              d1);
            TextOut(SurfaceX(Left + 13 {70}), SurfaceY(Top + d.Height - 54 +
              14), d2);
            if not useable then
              Font.Color := clRed;
            TextOut(SurfaceX(Left + 13 {70}), SurfaceY(Top + d.Height - 54 + 14
              * 2), d3);
            Font.Color := clWhite;
            n := TextWidth(d3);
            TextOut(SurfaceX(Left + 13+n {70}), SurfaceY(Top + d.Height - 54 + 14
              * 2), d4);
          end;
          Release;
        end;
        g_MouseItem.S.Name := '';
      end;
      //g_MouseItem.S.Name:='';
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DHeroItemBagDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroItemBagMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  try //程序自动增加
    DScreen.ClearHint;
    g_HeroMouseItem.S.Name := '';
    m_nMouseIdx := 0;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DHeroItemBagMouseMove');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DRenewChrDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  hcolor, old, keyimg: integer;
  sMan: string;
  I: integer;
  n: integer;
begin
  try //程序自动增加
    with DRenewChr do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      n := 0;
      with SelectChrScene do
      begin
        for I := Low(RenewChr) to high(RenewChr) do
        begin
          if RenewChr[I].Name <> '' then
          begin
            with dsurface.Canvas do
            begin
              SetBkMode(Handle, TRANSPARENT);
              if I = RenewChrIdx - 1 then
              begin
                Font.Color := clRed;
                TextOut(SurfaceX(55), SurfaceY(125 + n * 16), '√');
              end
              else
                Font.Color := clwhite;
              TextOut(SurfaceX(65), SurfaceY(125 + n * 16), RenewChr[I].Name);
              TextOut(SurfaceX(70 + 80), SurfaceY(125 + n * 16),
                IntToStr(RenewChr[I].Level) + '级');
              TextOut(SurfaceX(70 + 80 + 43), SurfaceY(125 + n * 16),
                GetJobName(RenewChr[I].Job));
              if RenewChr[I].Sex = 0 then
                sMan := '男'
              else
                sMan := '女';
              TextOut(SurfaceX(70 + 80 + 40 + 60), SurfaceY(125 + n * 16),
                sMan);
              //sLevel:=IntToStr(g_MyHero.m_Abil.Level);
              //TextOut (SurfaceX(14-TextWidth(sLevel) div 2), SurfaceY(61),sLevel);
              Release;
            end;
            Inc(n);
          end;
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DRenewChrDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DRenewChrClick(Sender: TObject; X, Y: Integer);
var
  lx, ly, idx: integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
begin
  try //程序自动增加
    lx := DRenewChr.LocalX(X) - DRenewChr.Left;
    ly := DRenewChr.LocalY(Y) - DRenewChr.Top;
    if (lx >= 24) and (lX <= 242) and (lY >= 120) and (lY <= 343) then
    begin
      idx := (lY - 120) div 16;
      if idx in [0..high(SelectChrScene.RenewChr) - 1] then
      begin
        PlaySound(s_glass_button_click);
        RenewChrIdx := idx + 1;
        exit;
      end;
    end;
    RenewChrIdx := 0;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DRenewChrClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotMemoDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDButton;
  dd: TDirectDrawSurface;
begin
  try //程序自动增加

    d := TDButton(Sender);
    if {not} d.Downed then
    begin
      {if GetTickCount-ShopButTick > 100 then begin
        ShopButTick:=GetTickCount;
        Inc(ShopButId);
        if ShopButId > 3 then ShopButId:=0;
        if ShopButId < 0 then ShopButId:=0;
      end;     }
      {dd := d.WLib.Images[307{+ShopButId];
      if dd <> nil then
          dsurface.Draw (d.SurfaceX(d.Left-4), d.SurfaceY(d.Top-2), dd.ClientRect, dd, TRUE);
    end else begin}
      dd := d.WLib.Images[d.FaceIndex];
      if dd <> nil then
        dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd,
          TRUE);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotMemoDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.ShowWgWindows();
var
i:integer;
pm: PTClientMagic;
d: TDirectDrawSurface;
begin
  try //程序自动增加
    case g_WgClass of
      1:
      begin
     d := g_WMain2Images.Images[607]; //惑怕
     if d <> nil then
     begin
      DCheckBox1.Checked := g_WgInfo.boShowName;
      DCheckBox2.Checked := g_WgInfo.boDuraAlert;
      DCheckBox3.Checked := g_WgInfo.boCloseShift;
      DCheckBox4.Checked := g_WgInfo.boExpShowFil;
      DCheckBox5.Checked := g_WgInfo.boShowAllItem;
      DCheckBox6.Checked := g_WgInfo.boShowAllItemFil;
      DCheckBox7.Checked := g_WgInfo.boAutoPuckUpItem;
      DCheckBox8.Checked := g_WgInfo.boAutoPuckItemFil;
      DCheckBox9.Checked := g_WgInfo.boCanLongHit;
      DCheckBox10.Checked := g_WgInfo.boCanWideHit;
      DCheckBox11.Checked := g_WgInfo.boCanAutoFireHit;
      DCheckBox12.Checked := g_WgInfo.boCanAutoLongFire;
      DCheckBox13.Checked := g_WgInfo.boCanShield;
      DCheckBox14.Checked := g_WgInfo.boHeroAutoMagic;
      if (g_HeronRecogId > 0) and (g_HerobtJob = 1) then
        DCheckBox14.Enabled:=True
      else
       DCheckBox14.Enabled:=False;
      DCheckBox15.Checked := g_WgInfo.boCanCloak;
      DCheckBox16.Checked := g_WgInfo.boAutoMagic;
      DCheckBox17.Checked := g_WgInfo.boAutoHp;
      DCheckBox18.Checked := g_WgInfo.boAutoMp;
      DCheckBox19.Checked := g_WgInfo.boAutoCropsHp;
      DCheckBox20.Checked := g_WgInfo.boAutoHpProtect;
      DCheckBox21.Checked := g_WgInfo.boAutoDrink;
      DCheckBox22.Checked := g_WgInfo.boHeroAutoDrink;
      DCheckBox24.Checked := g_WgInfo.boHookKey;
      DCheckBox25.Checked := g_WgInfo.boHeroCallBoneFamm;
      DCheckBox26.Checked := g_WgInfo.boHeroCallDogz;
      DCheckBox27.Checked := g_WgInfo.boHeroCallFairy;
      if (g_HeronRecogId > 0) and (g_HerobtJob = 2) then
      begin
        DCheckBox25.Enabled:=True;
        DCheckBox26.Enabled:=True;
        DCheckBox27.Enabled:=True;
      end else
      begin
       DCheckBox25.Enabled:=False;
       DCheckBox26.Enabled:=False;
       DCheckBox27.Enabled:=False;
      end;  
      DEdit2.Text:=IntToStr(_MAX(1,g_WgInfo.nAutoMagicTime div 1000));
      DEdit3.Text:=IntToStr(g_WgInfo.boAutoHpCount);
      DEdit4.Text:=IntToStr(_MAX(1,g_WgInfo.boAutoHpTick div 1000));
      DEdit5.Text:=IntToStr(g_WgInfo.boAutoMpCount);
      DEdit6.Text:=IntToStr(_MAX(1,g_WgInfo.boAutoMpTick div 1000));
      DEdit7.Text:=IntToStr(g_WgInfo.boAutoCropsHpCount);
      DEdit8.Text:=IntToStr(_Max(1,g_WgInfo.boAutoCropsHpTick div 1000));
      DEdit9.Text:=IntToStr(g_WgInfo.boAutoHpProtectCount);
      DEdit10.Text:=IntToStr(_Max(1,g_WgInfo.boAutoHpOrotectTick div 1000));
      DEdit11.Text:=IntToStr(g_WgInfo.boAutoDrinkCount);
      DEdit12.Text:=IntToStr(g_WgInfo.boHeroAutoDrinkCount);
      DEdit13.Text:=IntToStr(g_WgInfo.wHeroMinHPTail);
      DComboBox2.Text:=g_WgInfo.boAutoHpProtectName;
      DHooKKey3.SetKey(g_WgInfo.bHookey1key,TShiftState(g_WgInfo.bHookey1ShiftState));
      DHooKKey5.SetKey(g_WgInfo.bHookey2key,TShiftState(g_WgInfo.bHookey2ShiftState));
      DHooKKey7.SetKey(g_WgInfo.bHookey3key,TShiftState(g_WgInfo.bHookey3ShiftState));
      DHooKKey9.SetKey(g_WgInfo.bHookey4key,TShiftState(g_WgInfo.bHookey4ShiftState));
      DHooKKey11.SetKey(g_WgInfo.bHookey5key,TShiftState(g_WgInfo.bHookey5ShiftState));
      DHooKKey13.SetKey(g_WgInfo.bHookey6key,TShiftState(g_WgInfo.bHookey6ShiftState));
      DHooKKey15.SetKey(g_WgInfo.bHookey7key,TShiftState(g_WgInfo.bHookey7ShiftState));
      DComboBox3.Item.Clear;
      For i := 0 To g_MagicList.Count - 1 Do
      begin
        pm:=PTClientMagic(g_MagicList[i]);
        DComboBox3.Item.Add(pm.Def.sMagicName);
        if pm.Def.sMagicName=g_WgInfo.sAutoMagicName then
         g_WgInfo.nAutoMagicIdx:=pm.Def.wMagicID;
      end;
      DComboBox3.Text:=g_WgInfo.sAutoMagicName;
      DNewWG.Visible:=not DNewWG.Visible;
     end else
     begin
       DMessageDlg('您的客户端太旧了不支持新内挂,请更新客户端!',[mbOk]);
       DWgInfo.Visible := not DWgInfo.Visible;
     end;
      end;
      2:
        begin
          if not Assigned(FormWgMain) then
          begin
            FormWgMain := TFormWgMain.Create(FrmMain);

            FormWgMain.RefWgWindow;
            FormWgMain.ParentWindow := FrmMain.Handle;
            FormWgMain.Show;
            FormWgMain.RefWgBut;
          end
          else
            FormWgMain.Visible := not FormWgMain.Visible;
        end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.ShowWgWindows'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBotTopClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    FillChar(g_TaxisSelf, SizeOf(TTaxisSelf) * 10, #0);
    FillChar(g_TaxisHero, SizeOf(TTaxisHero) * 10, #0);
    DTaxis.Visible := not DTaxis.Visible;
    m_nTaxisTitleIdx := 0;
    DTaxisShow.Visible := False;
    DTaxisSelfBt.Visible := True;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBotTopClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DItemBagMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  iname: string;
begin
  try //程序自动增
    //DScreen.AddChatBoardString (Format('%d/%d',[x,]), 122, 0);
    if ((X - DItemBag.Left) > 234) and ((Y - DItemBag.Top) > 207) and ((X -
      DItemBag.Left) < 274) and ((Y - DItemBag.Top) < 227) then
    begin
      g_MouseItem.S.Name := '';
      m_nMouseIdx := 0;
      m_boShowGold := True;
    end
    else
    begin
      DScreen.ClearHint;
      g_MouseItem.S.Name := '';
      m_nMouseIdx := 0;
      m_boShowGold := False;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DItemBagMouseMove'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DButLevelClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DItemLeve.Visible := True;
    m_nLevelIdx := -1;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DButLevelClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DItemLeveCloseClick(Sender: TObject; X, Y: Integer);
var
  I: Integer;
begin
  try //程序自动增加
    DItemLeve.Visible := False;
    for I := Low(g_LevelItemArr) to High(g_LevelItemArr) do
    begin
      if g_LevelItemArr[I].S.Name <> '' then
        AddItemBag(g_LevelItemArr[I]);
      g_LevelItemArr[I].S.Name := '';
    end;
    //AddItemBag (cu);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DItemLeveCloseClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DButItem2DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  dd: TDButton;
  idx: Integer;
begin
  try //程序自动增加
    if Sender is TDButton then
    begin
      dd := TDButton(Sender);
      if g_LevelItemArr[dd.Tag - 1].S.Name = '' then
        exit;
      idx := g_LevelItemArr[dd.Tag - 1].S.Looks;
      if idx >= 0 then
      begin
        d := FrmMain.GetWBagItemImg(idx);
        if d <> nil then
          dsurface.Draw(dd.SurfaceX(dd.Left + (dd.Width - d.Width) div 2),
            dd.SurfaceY(dd.Top + (dd.Height - d.Height) div 2),
            d.ClientRect, d, TRUE);
      end;
      if (m_nLevelIdx >= 0) and (Sender = DButItem1) then
      begin
        d := g_WMain3Images.Images[600 + m_nLevelIdx];
        if d <> nil then
          dsurface.Draw(dd.SurfaceX(dd.Left - 15),
            dd.SurfaceY(dd.Top - 14),
            d.ClientRect, d, TRUE);
        if (GetTickCount - m_nLevelTick) > 118 then
        begin
          m_nLevelTick := GetTickCount;
          Inc(m_nLevelIdx);
        end;
        if m_nLevelIdx > 17 then
          m_nLevelIdx := -1;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DButItem2DirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DButItem1Click(Sender: TObject; X, Y: Integer);
var
  dd: TDButton;
  sel: Integer;
  temp: TClientItem;
begin
  try //程序自动增加
    if g_MySelf = nil then
      exit;
    if Sender is TDButton then
    begin
      dd := TDButton(Sender);
      sel := dd.Tag - 1;
      if g_boItemMoving then
      begin
        if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then
          exit;
        if (g_MovingItem.Index < 0) and (g_MovingItem.Index > -500) then
          exit;
        if (g_MovingItem.Hero) or (g_MovingItem.Item.S.Name = '') then
          exit;
        if (sel = 0) and (not GetLevelPosition(g_MovingItem.Item.S.StdMode))
          then
          exit;
        if (sel = 1) and (not (g_MovingItem.Item.S.StdMode in [55, 56, 58]))
          then
          exit;
        if (sel = 2) and (g_MovingItem.Item.S.StdMode <> 57) then
          exit;
        if g_LevelItemArr[sel].S.Name = '' then
        begin
          g_LevelItemArr[sel] := g_MovingItem.Item;
          g_MovingItem.Item.S.Name := '';
          g_boItemMoving := False;
        end
        else
        begin
          temp := g_LevelItemArr[sel];
          g_LevelItemArr[sel] := g_MovingItem.Item;
        //  g_MovingItem.Index := -(sel + 500);
          g_MovingItem.Item := temp;
          g_MovingItem.Hero := False;
          ItemClickSound(temp.S);
        end;
      end
      else
      begin
        if g_MovingItem.Item.S.Name <> '' then
          exit;
        if g_LevelItemArr[sel].S.Name <> '' then
        begin
        //  g_MovingItem.Index := -(sel + 500);
          g_MovingItem.Item := g_LevelItemArr[sel];
          g_MovingItem.Hero := False;
          g_LevelItemArr[sel].S.Name := '';
          g_boItemMoving := TRUE;
          ItemClickSound(g_LevelItemArr[sel].S);
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DButItem1Click'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DButItem1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  dd: TDButton;
  nLocalX, nLocalY, nHintX, nHintY: integer;
  sMsg: string;
begin
  try //程序自动增加
    if g_MySelf = nil then
      exit;
    if Sender is TDButton then
    begin
      dd := TDButton(Sender);
      g_MouseItem := g_LevelItemArr[dd.Tag - 1];
    end;
    if Sender = DButItem1 then
      sMsg := '需要升级的装备';
    if Sender = DButItem2 then
      sMsg := '升级主要宝石';
    if Sender = DButItem3 then
      sMsg := '升级附加宝石(可以不放)';

    nLocalX := dd.LocalX(X - dd.Left);
    nLocalY := dd.LocalY(Y - dd.Top);
    nHintX := dd.SurfaceX(dd.Left) + DItemLeve.SurfaceX(DItemLeve.Left) +
      nLocalX;
    nHintY := dd.SurfaceY(dd.Top) + DItemLeve.SurfaceY(DItemLeve.Top) + nLocalY;
    with Sender as TDButton do
      DScreen.ShowHint(SurfaceX(Left), SurfaceY(Top - 20), sMsg, clWhite,
        False);

  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DButItem1MouseMove'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DButItemLeveClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if g_LevelItemArr[0].S.Name = '' then
    begin
      DScreen.AddChatBoardString('缺少升级装备。', clRed, clwhite);
      exit;
    end;
    if g_LevelItemArr[1].S.Name = '' then
    begin
      DScreen.AddChatBoardString('缺少升级宝石。', clRed, clwhite);
      exit;
    end;
    {if (g_LevelItemArr[1].S.StdMode=55) and
       (g_LevelItemArr[1].S.Shape<>0) and
       (g_LevelItemArr[1].S.Shape<>g_LevelItemArr[0].S.StdMode) then begin
      DMessageDlg('升级宝石与装备不匹配！',[mbOK]);
      exit;
    end;
    if (g_LevelItemArr[1].S.StdMode=56) and
       (g_LevelItemArr[1].S.Shape<>0) and
       (g_LevelItemArr[1].S.Shape<>g_LevelItemArr[0].S.StdMode) then begin
      DMessageDlg('升级宝石与装备不匹配！',[mbOK]);
      exit;
    end;}
    if g_LevelItemArr[2].S.Name = '' then
      FrmMain.SendLevelItem(g_LevelItemArr[0].MakeIndex,
        g_LevelItemArr[1].MakeIndex,
        0)
    else
      FrmMain.SendLevelItem(g_LevelItemArr[0].MakeIndex,
        g_LevelItemArr[1].MakeIndex,
        g_LevelItemArr[2].MakeIndex);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DButItemLeveClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DTaxisSelfClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if Sender is TDButton then
    begin
      if (GetTickCount - m_dwTaxisTime) > 500 then
      begin
        m_dwTaxisTime := GetTickCount;
      end
      else
        exit;
      if Sender = DTaxisSelfTop then
      begin
        FrmMain.SendTaxis(-1, m_nTaxisTitleIdx, m_nTaxisListIdx);
      end
      else if Sender = DTaxisUp then
      begin
        if m_nPageidx > 0 then
          FrmMain.SendTaxis(m_nTaxisTitleIdx, m_nTaxisListIdx, m_nPageidx - 1);
      end
      else if Sender = DTaxisDown then
      begin
        if m_nPageidx < m_nPageMax then
          FrmMain.SendTaxis(m_nTaxisTitleIdx, m_nTaxisListIdx, m_nPageidx + 1);
      end
      else if Sender = DTaxisBottom then
      begin
        if m_nPageidx < m_nPageMax then
          FrmMain.SendTaxis(m_nTaxisTitleIdx, m_nTaxisListIdx, m_nPageMax);
      end
      else if Sender = DTaxisTop then
      begin
        if m_nPageidx > 0 then
          FrmMain.SendTaxis(m_nTaxisTitleIdx, m_nTaxisListIdx, 0);
      end
      else if Sender = DTaxisSelf then
      begin
        FillChar(g_TaxisSelf, SizeOf(TTaxisSelf) * 10, #0);
        FillChar(g_TaxisHero, SizeOf(TTaxisHero) * 10, #0);
        m_nTaxisTitleIdx := 0;
        DTaxisShow.Visible := False;
        DTaxisSelfBt.Visible := True;
      end
      else if Sender = DTaxisHero then
      begin
        FillChar(g_TaxisSelf, SizeOf(TTaxisSelf) * 10, #0);
        FillChar(g_TaxisHero, SizeOf(TTaxisHero) * 10, #0);
        m_nTaxisTitleIdx := 1;
        DTaxisShow.Visible := False;
        DTaxisSelfBt.Visible := True;
      end
      else if Sender = DTaxisMaster then
      begin
        FillChar(g_TaxisSelf, SizeOf(TTaxisSelf) * 10, #0);
        FillChar(g_TaxisHero, SizeOf(TTaxisHero) * 10, #0);
        m_nTaxisTitleIdx := 2;
        m_nTaxisListIdx := 0;
        DTaxisSelfBt.Visible := False;
        DTaxisShow.Visible := True;
        FrmMain.SendTaxis(m_nTaxisTitleIdx, 0, 0);
      end
      else if Sender = DTaxisAll then
      begin
        m_nTaxisListIdx := 0;
        DTaxisSelfBt.Visible := False;
        DTaxisShow.Visible := True;
        FrmMain.SendTaxis(m_nTaxisTitleIdx, m_nTaxisListIdx, 0);
      end
      else if Sender = DTaxisWarr then
      begin
        m_nTaxisListIdx := 1;
        DTaxisSelfBt.Visible := False;
        DTaxisShow.Visible := True;
        FrmMain.SendTaxis(m_nTaxisTitleIdx, m_nTaxisListIdx, 0);
      end
      else if Sender = DTaxisWazird then
      begin
        m_nTaxisListIdx := 2;
        DTaxisSelfBt.Visible := False;
        DTaxisShow.Visible := True;
        FrmMain.SendTaxis(m_nTaxisTitleIdx, m_nTaxisListIdx, 0);
      end
      else if Sender = DTaxisTaos then
      begin
        m_nTaxisListIdx := 3;
        DTaxisSelfBt.Visible := False;
        DTaxisShow.Visible := True;
        FrmMain.SendTaxis(m_nTaxisTitleIdx, m_nTaxisListIdx, 0);
      end
      else
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DTaxisSelfClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DTaxisAllDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDButton;
  dd: TDirectDrawSurface;
  idx: integer;
begin
  try //程序自动增加
    if Sender is TDButton then
    begin
      d := TDButton(Sender);
      idx := d.FaceIndex;
      if m_nTaxisTitleIdx = 1 then
      begin
        if Sender = DTaxisAll then
          Inc(idx, 2)
        else
          Inc(idx, 6);
      end;
      if not d.Downed then
      begin
        dd := d.WLib.Images[idx];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
      end
      else
      begin
        dd := d.WLib.Images[idx + 1];
        if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DTaxisAllDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DTaxisShowDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  function SX(x: integer): integer;
  begin
    Result := DTaxisShow.SurfaceX(DTaxisShow.Left + x);
  end;
  function SY(y: integer): integer;
  begin
    Result := DTaxisShow.SurfaceY(DTaxisShow.Top + y);
  end;
var
  d: TDirectDrawSurface;
  i: integer;
begin
  try //程序自动增加
    with Sender as TDWindow do
    begin
      d := WLib.Images[FaceIndex + m_nTaxisTitleIdx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      with dsurface.Canvas do
      begin
        SetBkMode(dsurface.Canvas.Handle, TRANSPARENT);
        if m_nTaxisTitleIdx = 1 then
        begin
          for I := Low(g_TaxisHero) to High(g_TaxisHero) do
          begin
            if g_TaxisHero[I].sName <> '' then
            begin
              if m_nTaxisCkIdx = I then
                Font.Color := clYellow
              else
                Font.Color := clWhite;
              TextOut(SX(11), SY(26 + I * 22), IntToStr(g_TaxisHero[I].nTop));
              TextOut(SX(39), SY(26 + I * 22), g_TaxisHero[I].sName);
              TextOut(SX(133), SY(26 + I * 22), g_TaxisHero[I].sHeroName);
              TextOut(SX(249), SY(26 + I * 22),
                IntToStr(g_TaxisHero[I].nLevel));
            end;
          end;
        end
        else
        begin
          for I := Low(g_TaxisSelf) to High(g_TaxisSelf) do
          begin
            if g_TaxisSelf[I].sName <> '' then
            begin
              if m_nTaxisCkIdx = I then
                Font.Color := clYellow
              else
                Font.Color := clWhite;
              TextOut(SX(26), SY(26 + I * 22), IntToStr(g_TaxisSelf[I].nTop));
              TextOut(SX(90), SY(26 + I * 22), g_TaxisSelf[I].sName);
              TextOut(SX(235), SY(26 + I * 22),
                IntToStr(g_TaxisSelf[I].nLevel));
            end;
          end;
        end;
        Release;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DTaxisShowDirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DTaxisShowClick(Sender: TObject; X, Y: Integer);
var
  ly: integer;
begin
  try //程序自动增加
    ly := DTaxis.LocalY(Y) - DTaxisShow.Top;
    m_nTaxisCkIdx := ly div 22 - 1;
    if m_nTaxisCkIdx in [0..9] then
      PlaySound(s_glass_button_click);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DTaxisShowClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DTaxisShowDblClick(Sender: TObject);
var
  sName: string;
begin
  try //程序自动增加
    sName := '';
    if m_nTaxisCkIdx in [0..9] then
    begin
      if m_nTaxisTitleIdx = 1 then
      begin
        if g_TaxisHero[m_nTaxisCkIdx].sName <> '' then
          sName := g_TaxisHero[m_nTaxisCkIdx].sHeroName;
      end
      else
      begin
        if g_TaxisSelf[m_nTaxisCkIdx].sName <> '' then
          sName := g_TaxisSelf[m_nTaxisCkIdx].sName;
      end;
      if sName <> '' then
      begin
        PlayScene.SetEditChar(sName);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DTaxisShowDblClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DFriendDlgDblClick(Sender: TObject);
begin
  try //程序自动增加
    if FirCheckName <> '' then
      PlayScene.SetEditChar(FirCheckName);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DFriendDlgDblClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DItemBagMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  idx, where: integer;
begin
  try //程序自动增加
    if (Button = mbRight) then
    begin
      idx := m_nMouseIdx;
      if (idx in [6..MAXBAGITEM - 1]) and (g_ItemArr[idx].S.Name <> '') and
        (g_WaitingUseItem.Item.S.Name = '') then
      begin
       if g_ItemArr[idx].S.StdMode=0 then
         FrmMain.EatItem(idx)
       else
       begin
        where := GetTakeOnPosition(g_ItemArr[idx].S.StdMode);
        if where in [0..MAXUSEITEMS] then
        begin
          if where = U_RINGL then
          begin
            if m_boRING then
              Inc(where);
            m_boRING := not m_boRING;
          end
          else if where = U_ARMRINGL then
          begin
            if m_boARMRING then
              Inc(where);
            m_boARMRING := not m_boARMRING;
          end;
          ItemClickSound(g_ItemArr[idx].S);
          g_WaitingUseItem.Hero := False;
          g_WaitingUseItem.Item := g_ItemArr[idx];
          g_WaitingUseItem.Index := where;
          FrmMain.SendTakeOnItem(where, g_ItemArr[idx].MakeIndex,
            g_ItemArr[idx].S.Name);
          g_ItemArr[idx].S.Name := '';
        end;
       end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DItemBagMouseDown'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DHeroItemBagMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  idx, where: integer;
begin
  try //程序自动增加
    if (Button = mbRight) then
    begin
      idx := m_nMouseIdx;
      if (idx in [6..MAXBAGITEM - 1]) and (g_HeroItemArr[idx].S.Name <> '') and
        (g_WaitingUseItem.Item.S.Name = '') then
      begin
       if g_HeroItemArr[idx].S.StdMode=0 then
          FrmMain.HeroEatItem(Idx)
       else
       begin
        where := GetTakeOnPosition(g_HeroItemArr[idx].S.StdMode);
        if where in [0..MAXUSEITEMS] then
        begin
          if where = U_RINGL then
          begin
            if m_boRING then
              Inc(where);
            m_boRING := not m_boRING;
          end
          else if where = U_ARMRINGL then
          begin
            if m_boARMRING then
              Inc(where);
            m_boARMRING := not m_boARMRING;
          end;
          ItemClickSound(g_HeroItemArr[idx].S);
          g_WaitingUseItem.Hero := True;
          g_WaitingUseItem.Item := g_HeroItemArr[idx];
          g_WaitingUseItem.Index := where;
          FrmMain.SendHeroTakeOnItem(where, g_HeroItemArr[idx].MakeIndex,
            g_HeroItemArr[idx].S.Name);
          g_HeroItemArr[idx].S.Name := '';
        end;
       end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DHeroItemBagMouseDown');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DOpenArkDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  WMImg: TWMImages;
  Idx, II: integer;
begin
  try //程序自动增加
    {if g_OpenArkItem.S.Name='' then begin
      DOpenArk.Visible:=False;
      exit;
    end;}
    with DOpenArk do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      if m_boOpenBox and (not m_boOpenArk) then
      begin
        g_OpenArkItem.S.Name := '';
        g_OpenArkKeyItem.S.Name := '';
        DArkItem0.Visible := True;
        DArkItem1.Visible := True;
        DArkItem2.Visible := True;
        DArkItem3.Visible := True;
        DArkItem4.Visible := True;
        DArkItem5.Visible := True;
        DArkItem6.Visible := True;
        DArkItem7.Visible := True;
        DArkItem8.Visible := True;
        if (m_boOpenMove) and (not m_boOpenMoveEnd) then
        begin
          if (GetTickCount - m_boOpenMoveTime) > m_boOpenMoveTick then
          begin
            m_boOpenMoveTime := GetTickCount;
            Inc(m_nOpenIdx);
            if m_nOpenIdx = 8 then
              m_nOpenIdx := 0;

            if (m_nOpenEndIdx < 255) and
              ((GetTickCount - m_nOpenEndMoveTick) > 3000) then
            begin
              if m_boOpenMoveTick < m_nOpenMoveTick then
                Inc(m_boOpenMoveTick, 30);
              if m_boOpenMoveTick > m_nOpenMoveTick then
                m_boOpenMoveTick := m_nOpenMoveTick;
              if (m_boOpenMoveTick = m_nOpenMoveTick) and (m_nOpenIdx =
                m_nOpenEndIdx) then
              begin
                m_boOpenMoveEnd := True;
                m_boOpenMove := False;
              end;
            end;

            if (m_nOpenEndIdx = 255) or ((GetTickCount - m_nOpenEndMoveTick) <
              3000) then
            begin
              if m_boOpenMoveTick > 30 then
                Dec(m_boOpenMoveTick, 30)
              else
                m_boOpenMoveTick := 0;
            end;

          end;
        end;
      end
      else
      begin
        WMImg := nil;
        if (g_OpenArkItem.S.Name <> '') and (g_OpenArkItem.S.Shape in [1..5])
          then
        begin
          if g_OpenArkItem.S.Shape in [1..4] then
            WMImg := g_WMain3Images
          else
            WMImg := g_WMain2Images;
          case g_OpenArkItem.S.Shape of
            1: idx := 520;
            2: idx := 540;
            3: idx := 560;
            4: idx := 580;
            5: idx := 130;
          end;
          if g_OpenArkKeyItem.S.Name <> '' then
            Inc(Idx);
          if WMImg <> nil then
            d := WMImg.Images[Idx + m_nOpenArkIdx];
          if d <> nil then
            dsurface.Draw(SurfaceX(Left) - 60, SurfaceY(Top) - 95, d.ClientRect,
              d, TRUE);

          if WMImg <> nil then
            d := WMImg.Images[Idx + m_nOpenArkIdx + 7];
          if d <> nil then
            DrawBlend(dsurface, SurfaceX(Left) - 60, SurfaceY(Top) - 95, d, 1);

          if m_boOpenArk then
          begin
            if GetTickCount > m_dwOpenArkTick then
            begin
              m_dwOpenArkTick := GetTickCount + 100;
              Inc(m_nOpenArkIdx);
            end;
            if m_nOpenArkIdx > 4 then
            begin
              m_boOpenArk := False;
            end;
          end;
        end
        else
          g_OpenArkItem.S.Name := '';
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DOpenArkDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DArkCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DOpenArk.Visible := False;
    if g_OpenArkItem.S.Name <> '' then
      AddItemBag(g_OpenArkItem);
    if g_OpenArkKeyItem.S.Name <> '' then
      AddItemBag(g_OpenArkKeyItem);
    if m_boOpenBox then
      FrmMain.SendOpenGetItem();
    g_OpenArkItem.S.Name := '';
    g_OpenArkKeyItem.S.Name := '';
    m_boOpenBox := False;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DArkCloseClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DArkOpenClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    //m_boOpenMoveEnd:=True;
                 // m_boOpenMove:=False;
    try
      if (not m_boOpenBox) or m_boOpenArk or m_boOpenMove or m_boOpenMoveEnd
        then
        exit;
      m_nOpenMoveGold := 0;
      m_nOpenMoveGameGold := 0;
      m_boOpenMove := True;
      m_nOpenEffIdx := Random(8);
      m_nOpenIdx := Random(8);
      m_nOpenMoveTick := 200 + Random(100);
      m_boOpenMoveTick := m_nOpenMoveTick;
      m_boOpenMoveTime := GetTickCount;
      m_nOpenEndMoveTick := GetTickCount;
      m_nOpenEndIdx := 255;
      FrmMain.SendOpenMove();
    finally
      if not m_boOpenMove and m_boOpenMoveEnd and m_boOpenBox then
      begin
        //DScreen.AddChatBoardString (format('%d/%d',[m_nOpenMoveGold,m_nOpenMoveGameGold]), GetRGB(255), GetRGB(0));
        if (m_nOpenMoveGold > 0) or (m_nOpenMoveGameGold > 0) then
        begin
          if
            DMessageDlg(Format('是否确定要再次启动宝箱转盘，再次启动需要[金币:%d]和[%s:%d] ！', [m_nOpenMoveGold, g_sGameGoldName, m_nOpenMoveGameGold]), [mbYes, mbNo]) =
            mrYes then
          begin
            if (g_MySelf.m_nGold >= m_nOpenMoveGold) and (g_MySelf.m_nGameGold
              >= m_nOpenMoveGameGold) then
            begin
              m_boOpenMove := True;
              m_boOpenMoveEnd := False;
              m_nOpenEffIdx := Random(8);
              //m_nOpenIdx:=Random(8);
              m_nOpenMoveTick := 200 + Random(100);
              m_boOpenMoveTick := m_nOpenMoveTick;
              m_boOpenMoveTime := GetTickCount;
              m_nOpenEndMoveTick := GetTickCount;
              m_nOpenEndIdx := 255;
              FrmMain.SendOpenMove();
            end
            else
              DMessageDlg('你身上的金币或者' + g_sGameGoldName +
                '好像不太够哦。', [mbOk]);
          end;
          //
        end
        else
          DMessageDlg('宝箱已经损坏，无法再次启动转盘。',
            [mbOk]);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DArkOpenClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DOpenArkClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if (g_boItemMoving) and (g_OpenArkItem.S.Name <> '') then
    begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then
        exit;
      if (g_MovingItem.Item.S.Name = '') or (g_WaitingUseItem.Item.S.Name <> '')
        then
        exit;
      if g_MovingItem.Hero then
        exit;
      if (g_MovingItem.Item.S.StdMode = 49) and (g_MovingItem.Item.S.Shape =
        g_OpenArkItem.S.AniCount) then
      begin
        ItemClickSound(g_MovingItem.Item.S);
        g_OpenArkKeyItem := g_MovingItem.Item;
        g_MovingItem.Item.S.Name := '';
        g_boItemMoving := FALSE;
        m_nOpenArkIdx := 0;
        m_dwOpenArkTick := GetTickCount;
        m_boOpenArk := True;
        PlaySoundEx(bmg_Openbox);
        m_boOpenMoveEnd := False;
        FrmMain.SendOpenArk(g_OpenArkItem.MakeIndex,
          g_OpenArkKeyItem.MakeIndex);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DOpenArkClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DWPlacingDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  function SX(x: integer): integer;
  begin
    Result := DWPlacing.SurfaceX(DWPlacing.Left + x);
  end;
  function SY(y: integer): integer;
  begin
    Result := DWPlacing.SurfaceY(DWPlacing.Top + y);
  end;
var
  d: TDirectDrawSurface;
  i,n: integer;
  iname, d1, d2, d3, d4: string;
  useable: Boolean;
begin
  try //程序自动增加
    with DWPlacing do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      if m_SellClientPlacing.Item.S.Name <> '' then
      begin
        d := FrmMain.GetWBagItemImg(m_SellClientPlacing.Item.S.Looks);
        if d <> nil then
          with DWPlacing do
            dsurface.Draw(SX(19) + (32 - d.Width) div 2,
              SY(272) + (32 - d.Height) div 2,
              d.ClientRect, d, TRUE);
      end;

      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        BoldTextOut(Dsurface, SX(170), SY(15), clWindow, clBlack,
          '物品类别：' + SellItemHints[m_SellIdx]);
        BoldTextOut(Dsurface, SX(380), SY(17), clWindow, clBlack,
          Format('页 %d/%d', [m_SellPageIdx + 1, m_SellPageMax + 1]));
        BoldTextOut(Dsurface, SX(25), SY(46), clSkyBlue, clBlack, '类别');
        BoldTextOut(Dsurface, SX(80), SY(46), clSkyBlue, clBlack,
          '物品名称');
        BoldTextOut(Dsurface, SX(220), SY(46), clSkyBlue, clBlack,
          '卖家名称');
        BoldTextOut(Dsurface, SX(340), SY(46), clSkyBlue, clBlack,
          '物品价格');

        for I := Low(g_SellList) to High(g_SellList) do
        begin
          if g_SellList[I].Item.S.Name <> '' then
          begin
            if I = m_nPlacingIdx then
              Font.Color := clRed
            else
            begin
              Font.Color := clwhite;
              if g_SellList[I].sName = g_MySelf.m_sUserName then
                Font.Color := clyellow;
            end;
            TextOut(SX(25), SY(69 + I * 19), SellItemHints[m_SellIdx]);
            TextOut(SX(80), SY(69 + I * 19), g_SellList[I].Item.S.Name);
            TextOut(SX(220), SY(69 + I * 19), g_SellList[I].sName);
            if g_SellList[I].nSell then
            begin
              TextOut(SX(340), SY(69 + I * 19), '已成功出售');
            end
            else
            begin
              if g_SellList[I].nPicCls then
                TextOut(SX(340), SY(69 + I * 19), '￥ ' +
                  GetGoldStr(g_SellList[I].nPrice) + ' ' + g_sGameGoldName)
              else
                TextOut(SX(340), SY(69 + I * 19), '￥ ' +
                  GetGoldStr(g_SellList[I].nPrice) + ' ' + g_sGoldName);
            end;

          end;
        end;
        Font.Color := clwhite;
        if m_SellClientPlacing.Item.S.Name <> '' then
        begin

          TextOut(SX(58), SY(275), '时间: ' +
            DateTimeToStr(m_SellClientPlacing.nTime));
          if m_SellClientPlacing.nPicCls then
            TextOut(SX(58), SY(290), '价格: ' +
              GetGoldStr(m_SellClientPlacing.nPrice) + ' ' + g_sGameGoldName)
          else
            TextOut(SX(58), SY(290), '价格: ' +
              GetGoldStr(m_SellClientPlacing.nPrice) + ' ' + g_sGoldName);

          TextOut(SX(228), SY(267), m_Selliname + m_Selld1);
          TextOut(SX(228), SY(267 + 15 * 1), m_Selld2);
          TextOut(SX(228), SY(267 + 15 * 2), m_Selld3+m_Selld4);
        end;
        Release;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DWPlacingDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.ShopSellWindows();
begin
  try //程序自动增加
    DWPlacing.Visible := True;
    with EdPlacingEdit do
    begin
      Text := '';
      Width := 129;
      Left := 11;
      Top := 328;
      Visible := DWPlacing.Visible;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.ShopSellWindows'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBPlacingCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DWPlacing.Visible := not DWPlacing.Visible;
    with EdPlacingEdit do
    begin
      Text := '';
      Width := 129;
      Left := 11;
      Top := 328;
      Visible := DWPlacing.Visible;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBPlacingCloseClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBPlacingNextClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if Sender is TDButton then
    begin
      if GetTickCount > m_SellTime then
      begin
        m_SellTime := GetTickCount + 500;
      end
      else
        exit;
      if Sender = DBReload then
      begin
        FrmMain.SendSellOffGetList(m_SellIdx, m_SellPageIdx, m_SellFind,
          m_SellFindStr);
      end
      else if Sender = DBPlacingFront then
      begin
        if m_SellPageIdx > 0 then
          FrmMain.SendSellOffGetList(m_SellIdx, m_SellPageIdx - 1, m_SellFind,
            m_SellFindStr);
      end
      else if Sender = DBPlacingNext then
      begin
        if m_SellPageIdx < m_SellPageMax then
          FrmMain.SendSellOffGetList(m_SellIdx, m_SellPageIdx + 1, m_SellFind,
            m_SellFindStr);
      end
      else if Sender = DBPlacingPnd then
      begin
        if Trim(EdPlacingEdit.Text) <> '' then
        begin
          m_SellFindStr := Trim(EdPlacingEdit.Text);
          FrmMain.SendSellOffGetList(m_SellIdx, 0, 1, m_SellFindStr);
        end;
      end
      else if Sender = DBPlacingBuy then
      begin
        if m_SellClientPlacing.Item.S.Name <> '' then
        begin
          if DMessageDlg(Format('确定购买物品 [%s] 吗？',
            [m_SellClientPlacing.Item.S.Name]), [mbYes, mbNo]) = mrYes then
          begin
            FrmMain.SendSellOffBuy(m_SellClientPlacing.Item.MakeIndex);
          end;
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBPlacingNextClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DWPlacingClick(Sender: TObject; X, Y: Integer);
var
  useable: Boolean;
begin
  try //程序自动增加
    if (x > 12) and (Y > 65) and (X < 456) and (Y < 254) then
    begin
      m_nPlacingIdx := (Y - 65) div 19;
      if g_SellList[m_nPlacingIdx].Item.S.Name <> '' then
        m_SellClientPlacing := g_SellList[m_nPlacingIdx];
      g_MouseItem := m_SellClientPlacing.Item;
      GetMouseItemInfo(m_Selliname, m_Selld1, m_Selld2, m_Selld3,m_Selld4, useable);
      g_MouseItem.S.Name := '';
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DWPlacingClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DSelfShopDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  function SX(x: integer): integer;
  begin
    Result := DSelfShop.SurfaceX(DSelfShop.Left + x);
  end;
  function SY(y: integer): integer;
  begin
    Result := DSelfShop.SurfaceY(DSelfShop.Top + y);
  end;
var
  d: TDirectDrawSurface;
  i: integer;
begin
  try //程序自动增加
    if g_MySelf = nil then
      exit;
    if g_MySelf <> nil then
      DShopStart.Visible := not g_MySelf.m_boIsShop;
    with DSelfShop do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      if g_MySelf <> nil then
      begin
        with dsurface.Canvas do
        begin
          SetBkMode(Handle, TRANSPARENT);
          BoldTextOut(Dsurface, SX(18), SY(11), clwhite, clBlack,
            g_MySelf.m_sUserName + ' 的个人商店');

          Release;
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DSelfShopDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DButSelfShopClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DSelfShop.Visible := True;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DButSelfShopClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DButSelfShopDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    with Sender as TDButton do
    begin
      if not TDButton(Sender).Downed then
      begin
        d := g_WMain99Images.Images[63];
        if d=nil then
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end
      else
      begin
       d := g_WMain99Images.Images[64];
        if d=nil then
        d := WLib.Images[FaceIndex + 1];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DButSelfShopDirectPaint');
    //程序自动增加
  end; //程序自动增加

end;

procedure TFrmDlg.DGridShopGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
var
  idx,n: integer;
  d: TDirectDrawSurface;
  sText:string;
begin
  try //程序自动增加
    idx := ACol + ARow * DGridShop.ColCount;
    if idx in [0..19] then
    begin
      if g_ShopItems[idx].Item.S.Name <> '' then
      begin
        d := FrmMain.GetWBagItemImg(g_ShopItems[idx].Item.S.Looks);
        if d <> nil then
          with DGridShop do
          begin
            dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
              d.ClientRect,
              d, TRUE);
           if (g_ShopItems[idx].Item.Dura>1) and (g_ShopItems[idx].Item.S.StdMode=0) then
           begin
             sText:=IntToStr(g_ShopItems[idx].Item.Dura);
             n := dsurface.Canvas.TextWidth(sText);
             SetBkMode(dsurface.Canvas.Handle,TRANSPARENT);
             dsurface.Canvas.Font.Color := clWhite;
             dsurface.Canvas.Font.Style:=[fsBold];
             dsurface.Canvas.TextOut(SurfaceX(Rect.Left + d.Width-n),SurfaceY(Rect.Top),sText);
             dsurface.Canvas.Font.Style:=dsurface.Canvas.Font.Style-[fsBold];
             dsurface.Canvas.Release;
           end;
          end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGridShopGridPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DPicPutClick(Sender: TObject; X, Y: Integer);
var
  lx, ly, idx: integer;
begin
  try //程序自动增加
    lx := DPicPut.LocalX(X) - DPicPut.Left;
    ly := DPicPut.LocalY(Y) - DPicPut.Top;
    if (lx >= 19) and (lx <= 90) and (ly >= 68) and (ly <= 86) then
      DlgCls := True;
    if (lx >= 110) and (lx <= 185) and (ly >= 68) and (ly <= 86) then
      DlgCls := False;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DPicPutClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.EdDlgEditKeyPress(Sender: TObject; var Key: Char);
begin
  try //程序自动增加
    if not (Key in ['0'..'9']) then
      Key := #0;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.EdDlgEditKeyPress'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DShopStartClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if GetTickCount > DlgShopTime then
    begin
      DMessageDlg('请输入店铺名称，最多八个汉字。', [mbOk,
        mbAbort]);
      if DlgEditText <> '' then
      begin
        FrmMain.SendShopItems(DlgEditText);
        DlgShopTime := GetTickCount + 5000;
      end
      else
      begin
        DMessageDlg('请输入店铺名称。', [mbOk]);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DShopStartClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DPicCloseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if Sender = DPicClose then
      DlgBut := False;
    if Sender = DPicOk then
      DlgBut := False;
    if Sender = DPicClose2 then
      DlgBut := True;
    DPicPut.Visible := False;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DPicCloseClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DPicPutDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  function SX(x: integer): integer;
  begin
    Result := DPicPut.SurfaceX(DPicPut.Left + x);
  end;
  function SY(y: integer): integer;
  begin
    Result := DPicPut.SurfaceY(DPicPut.Top + y);
  end;
var
  d: TDirectDrawSurface;
  i: integer;
begin
  try //程序自动增加
    with DPicPut do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      d := g_WMain3Images.Images[353];
      if d <> nil then
      begin
        if DlgCls then
          dsurface.Draw(SX(18), SY(65), d.ClientRect, d, TRUE)
        else
          dsurface.Draw(SX(108), SY(65), d.ClientRect, d, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DPicPutDirectPaint'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGridShopGridSelect(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
  idx, mi: integer;
  temp: TClientItem;
begin
  try //程序自动增加
    if g_MySelf.m_boIsShop then
      exit;
    idx := ACol + ARow * DGridShop.ColCount;
    if idx in [0..19] then
    begin
      if not g_boItemMoving then
      begin
        if g_ShopItems[idx].Item.S.Name <> '' then
        begin
          g_boItemMoving := TRUE;
          g_MovingItem.Index := idx;
          g_MovingItem.Item := g_ShopItems[idx].Item;
          g_MovingItem.Hero := False;
          g_ShopItems[idx].Item.S.Name := '';
          ItemClickSound(g_ShopItems[idx].Item.S);
        end;
      end
      else
      begin
        mi := g_MovingItem.Index;
        if (mi <= 0) or g_MovingItem.Hero then
          exit;
        if g_ShopItems[idx].Item.S.Name = '' then
        begin
          g_boItemMoving := FALSE;
          if DPicDlg('请输入出售价格') and (DlgPic > 0) and (DlgPic <
            High(Integer)) then
          begin
            g_ShopItems[idx].Item := g_MovingItem.Item;
            g_ShopItems[idx].boCls := DlgCls;
            g_ShopItems[idx].nPic := DlgPic;
          end
          else
          begin
            AddItemBag(g_MovingItem.Item);
            g_ShopItems[idx].Item.S.Name := '';
          end;
          g_MovingItem.Item.S.Name := '';
        end;
      end;
    end;
    ArrangeItemBag;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGridShopGridSelect'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGridShopGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  idx: integer;
  temp: TClientItem;
  iname, d1, d2, d3, d4,d5: string;
  useable: Boolean;
  hcolor: TColor;
begin
  try
    idx := ACol + ARow * DGridShop.ColCount;
    if idx in [0..19] then
    begin
      g_MouseItem := g_ShopItems[idx].Item;
      m_nMouseIdx := idx;
      if g_MouseItem.S.Name <> '' then
      begin
        GetMouseItemInfo(iname, d1, d2, d3,d5, useable);
        hcolor := clWhite;
        if g_ShopItems[idx].boCls then
          d4 := Format('出售价格 %s %s', [GetGoldStr(g_ShopItems[idx].nPic),
            g_sGameGoldName])
        else
          d4 := Format('出售价格 %s %s', [GetGoldStr(g_ShopItems[idx].nPic),
            g_sGoldName]);
        with DGridShop do
          DScreen.ShowHint(SurfaceX(Left + +ACol * ColWidth),
            SurfaceY(Top + (ARow + 1) * RowHeight),
            iname + d1 + '\' + d2 + '\' + d3+d5 + '\' + d4 + '\' +
            g_MouseItem.Desc, hcolor, FALSE);
      end
      else
      begin
        DScreen.ClearHint;
      end;
      g_MouseItem.S.Name := '';
    end;
  except
    DebugOutStr('[Exception] TFrmDlg.DGridShopGridMouseMove');
  end;
end;

procedure TFrmDlg.DShopCloseClick(Sender: TObject; X, Y: Integer);
var
  i: integer;
begin
  try //程序自动增加
    for I := Low(g_ShopItems) to High(g_ShopItems) do
      if g_ShopItems[i].Item.S.Name <> '' then
        AddItemBag(g_ShopItems[i].Item);
    ArrangeItemBag;
    FillChar(g_ShopItems, Sizeof(TShopItem) * 20, #0);
    DSelfShop.Visible := False;
    if g_MySelf.m_boIsShop then
      FrmMain.SendCloseShopItems;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DShopCloseClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DSdWGCloseDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDButton;
  dd: TDirectDrawSurface;
begin
  try //程序自动增加
    if Sender is TDButton then
    begin
      d := TDButton(Sender);
      if d.Downed then
      begin
        dd := d.WLib.Images[d.FaceIndex+1];
      end else
        dd := d.WLib.Images[d.FaceIndex];
      if dd <> nil then
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DMyStateDirectPaint'); //程序自动增加
  end; //程序自动增加

end;

procedure TFrmDlg.DSelfShop2DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  function SX(x: integer): integer;
  begin
    Result := DSelfShop2.SurfaceX(DSelfShop2.Left + x);
  end;
  function SY(y: integer): integer;
  begin
    Result := DSelfShop2.SurfaceY(DSelfShop2.Top + y);
  end;
var
  d: TDirectDrawSurface;
  i: integer;
  str: string;
begin
  try //程序自动增加
    with DSelfShop2 do
    begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        BoldTextOut(Dsurface, SX(18), SY(11), clwhite, clBlack, g_sShopName +
          ' 的个人商店');
        if DlgShopItem.Item.S.Name <> '' then
        begin
          if DlgShopItem.boCls then
            Str := ' ' + g_sGameGoldName
          else
            Str := ' ' + g_sGoldName;
          BoldTextOut(Dsurface, SX(91), SY(177), clwhite, clBlack,
            DlgShopItem.Item.S.Name);
          BoldTextOut(Dsurface, SX(91), SY(207), clwhite, clBlack,
            GetGoldStr(DlgShopItem.nPic) + Str);
        end;
        Release;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DSelfShop2DirectPaint');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DShopClose2Click(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    DSelfShop2.Visible := False;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DShopClose2Click'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGridShop2GridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  idx: integer;
  temp: TClientItem;
  iname, d1, d2, d3, d4,d5: string;
  useable: Boolean;
  hcolor: TColor;
begin
  try //程序自动增加
    idx := ACol + ARow * DGridShop2.ColCount;
    if idx in [0..19] then
    begin
      g_MouseItem := g_ShopItems2[idx].Item;
      m_nMouseIdx := idx;
      if g_MouseItem.S.Name <> '' then
      begin
        GetMouseItemInfo(iname, d1, d2, d3,d5, useable);
        hcolor := clWhite;
        if g_ShopItems2[idx].boCls then
          d4 := Format('出售价格 %s %s',
            [GetGoldStr(g_ShopItems2[idx].nPic), g_sGameGoldName])
        else
          d4 := Format('出售价格 %s %s',
            [GetGoldStr(g_ShopItems2[idx].nPic), g_sGoldName]);
        with DGridShop2 do
          DScreen.ShowHint(SurfaceX(Left + +ACol * ColWidth),
            SurfaceY(Top + (ARow + 1) * RowHeight),
            iname + d1 + '\' + d2 + '\' + d3+d5 + '\' + d4 + '\' +
            g_MouseItem.Desc, hcolor, FALSE);
      end
      else
      begin
        DScreen.ClearHint;
      end;
      g_MouseItem.S.Name := '';
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGridShop2GridMouseMove');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DGridShop2GridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
var
  idx,n: integer;
  d: TDirectDrawSurface;
  sText:string;
begin
  try
    idx := ACol + ARow * DGridShop2.ColCount;
    if idx in [0..19] then
    begin
      if g_ShopItems2[idx].Item.S.Name <> '' then
      begin
        d := FrmMain.GetWBagItemImg(g_ShopItems2[idx].Item.S.Looks);
        if d <> nil then
          with DGridShop2 do
          begin
            dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
              d.ClientRect,
              d, TRUE);
              if (g_ShopItems2[idx].Item.Dura>1) and (g_ShopItems2[idx].Item.S.StdMode=0) then
               begin
                 sText:=IntToStr(g_ShopItems2[idx].Item.Dura);
                 n := dsurface.Canvas.TextWidth(sText);
                 SetBkMode(dsurface.Canvas.Handle,TRANSPARENT);
                 dsurface.Canvas.Font.Color := clWhite;
                 dsurface.Canvas.Font.Style:=[fsBold];
                 dsurface.Canvas.TextOut(SurfaceX(Rect.Left + d.Width-n),SurfaceY(Rect.Top),sText);
                 dsurface.Canvas.Font.Style:=dsurface.Canvas.Font.Style-[fsBold];
                 dsurface.Canvas.Release;
               end;
          end;
      end;
    end;
  except
    DebugOutStr('[Exception] TFrmDlg.DGridShop2GridPaint');
  end;
end;

procedure TFrmDlg.DGridShop2GridSelect(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  idx, mi: integer;
begin
  try //程序自动增加
    idx := ACol + ARow * DGridShop2.ColCount;
    if idx in [0..19] then
    begin
      if (not g_boItemMoving) and (g_ShopItems2[idx].Item.S.Name <> '') then
      begin
        ItemClickSound(g_ShopItems2[idx].Item.S);
        DlgShopItem := g_ShopItems2[idx];
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGridShop2GridSelect'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DShopStart2Click(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if DlgShopItem.Item.S.Name <> '' then
    begin
      if g_SelfShopItem.S.Name = '' then
      begin
        g_SelfShopItem := DlgShopItem.Item;
        FrmMain.SendSelfShopBuy(g_nShopIdx, g_nShopX, g_nShopY,
          DlgShopItem.Item.MakeIndex);
      end;
    end
    else
      DMessageDlg('请先选择要购买的物品。', [mbOk]);
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DShopStart2Click'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DButHorseClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if (g_Myself <> nil) then
    begin
      g_boAutoDig := False;
      g_TargetCret := nil;
      if g_MySelf.m_btHorse = 0 then
        FrmMain.SendSay('@骑马')
      else
        FrmMain.SendSay('@下马');
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DButHorseClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DBuHelpClick(Sender: TObject; X, Y: Integer);
begin
  try //程序自动增加
    if (g_Myself <> nil) and (GetTickCount > m_HelpTick) then
    begin
      m_HelpTick := GetTickCount + 2000;
      FrmMain.SendSay('@帮助');
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DBuHelpClick'); //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DShopWinMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  Idx, nII: Integer;
  nX, nY: Integer;
  ShowList: TList;
  NewFileItem: pTNewFileItem;
  iname, d1, d2, d3, d4,d5: string;
  useable: Boolean;
begin
  try //程序自动增加
    NewFileItem := nil;
    nX := 0;
    nY := 0;
    if (X > 517) and (x < 614) and (Y > 65) and (Y < 385) then
    begin
      Idx := Y div 65 - 1;
      if (Idx) < g_ShopTopList.Count then
      begin
        NewFileItem := g_ShopTopList.Items[Idx];
        nX := 515;
        nY := 125 + Idx * 65;
        {SurfaceY(65+(30-d.Height) div 2 + 1+I*65),
        d.ClientRect,
        d, TRUE);}
      end;
    end
    else if (x > 179) and (Y > 59) and (x < 509) and (Y < 326) then
    begin
      case ShopIdx of
        0: ShowList := g_ShopList1;
        1: ShowList := g_ShopList2;
        2: ShowList := g_ShopList3;
        3: ShowList := g_ShopList4;
        4: ShowList := g_ShopList5;
      end;

      Idx := ShopPage * 10;
      nX := X - 179;
      nY := Y - 59;
      Idx := Idx + nX div 179;
      Idx := Idx + nY div 53 * 2;
      if Idx < ShowList.Count then
      begin
        nII := Idx mod 10;
        NewFileItem := ShowList.Items[Idx];
        nX := 175 + (nII mod 2) * 172;
        nY := 110 + (nII div 2) * 55;
      end;
    end
    else
      DScreen.ClearHint;
    if NewFileItem <> nil then
    begin
      g_MouseItem := NewFileItem.Item;
      if g_MouseItem.S.Name <> '' then
      begin
        GetMouseItemInfo(iname, d1, d2, d3,d5, useable);
        with DShopWin do
          DScreen.ShowHint(nX,
            nY,
            iname + d1 + '\' + d2 + '\' + d3+d5 + '\' + d4 + '\' +
            g_MouseItem.Desc, clYellow, FALSE);
      end
      else
      begin
        DScreen.ClearHint;
      end;
      g_MouseItem.S.Name := '';
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DShopWinMouseMove'); //程序自动增加
  end; //程序自动增加
end;

//申请挑战
procedure TFrmDlg.DBotChallengeClick(Sender: TObject; X, Y: Integer);
begin
  try
      FrmMain.SendChallengeTry;
  except
    DebugOutStr('[Exception] TFrmDlg.DBotChallengeClick');
  end;
end;

procedure TFrmDlg.DArkItem0DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDButton;
  dd: TDirectDrawSurface;
begin
  if Sender is TDButton then
  begin
    d := TDButton(Sender);
    if (not m_boOpenBox) or m_boOpenArk then
      d.Visible := False;
    dd := d.WLib.Images[d.FaceIndex];
    if dd <> nil then
      dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd,
        TRUE);
    if g_OpenBoxItem[d.Tag].S.Name <> '' then
    begin
      dd := FrmMain.GetWBagItemImg(g_OpenBoxItem[d.Tag].S.Looks);
      if dd <> nil then
      begin
        if d.Tag = 8 then
          dsurface.Draw(d.SurfaceX(d.Left + 7) + (36 - dd.Width) div 2,
            d.SurfaceY(d.Top + 7) + (33 - dd.Height) div 2, dd.ClientRect, dd,
            TRUE)
        else
          dsurface.Draw(d.SurfaceX(d.Left + 2) + (36 - dd.Width) div 2,
            d.SurfaceY(d.Top + 2) + (33 - dd.Height) div 2, dd.ClientRect, dd,
            TRUE);
      end;
    end;
    if d.Tag = m_nOpenIdx then
    begin
      dd := g_WMain3Images.Images[600 + m_nOpenEffIdx * 2 +
        Integer(m_boOpenEff)];
      if dd <> nil then
      begin
        if d.Tag = 8 then
          dsurface.Draw(d.SurfaceX(d.Left - 5), d.SurfaceY(d.Top - 6),
            dd.ClientRect, dd, TRUE)
        else
          dsurface.Draw(d.SurfaceX(d.Left - 10), d.SurfaceY(d.Top - 11),
            dd.ClientRect, dd, TRUE);
      end;
    end;
    if (GetTickCount - m_dwOpenEffTick) > 200 then
    begin
      m_dwOpenEffTick := GetTickCount;
      m_boOpenEff := not m_boOpenEff;
    end;
  end;
end;

procedure TFrmDlg.DArkItem0MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  idx: integer;
  temp: TClientItem;
  iname, d1, d2, d3, d4, d5,d6: string;
  useable: Boolean;
  hcolor: TColor;
  d: TDButton;
begin
  try //程序自动增加
    if Sender is TDButton then
    begin
      d := TDButton(Sender);
      g_MouseItem := g_OpenBoxItem[d.Tag];
      m_nMouseIdx := idx;
      if g_MouseItem.S.Name <> '' then
      begin
        GetMouseItemInfo(iname, d1, d2, d3,d6, useable);
        hcolor := clWhite;
        //if g_ShopItems[idx].boCls then d4:=Format('出售价格 %s %s',[GetGoldStr(g_ShopItems[idx].nPic),g_sGameGoldName])
        //else d4:=Format('出售价格 %s %s',[GetGoldStr(g_ShopItems[idx].nPic),g_sGoldName]);
        if d.Tag = m_nOpenIdx then
        begin
          d5 := '双击获取';
        end
        else
          d5 := '';
        with DGridShop do
          DScreen.ShowHint(d.SurfaceX(d.Left),
            d.SurfaceY(d.Top + d.Height),
            iname + d1 + '\' + d2 + '\' + d3+d6 + '\' + d4 + '\' + g_MouseItem.Desc
            + '\' + d5, hcolor, FALSE);
      end
      else
      begin
        DScreen.ClearHint;
      end;
      g_MouseItem.S.Name := '';
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFrmDlg.DGridShopGridMouseMove');
    //程序自动增加
  end; //程序自动增加
end;

procedure TFrmDlg.DArkItem1DblClick(Sender: TObject);
var
  d: TDButton;
begin
  if Sender is TDButton then
  begin
    d := TDButton(Sender);
    if m_boOpenBox and (d.Tag = m_nOpenEndIdx) then
    begin
      frmMain.SendOpenGetItem();
      DOpenArk.Visible := False;
      g_OpenArkItem.S.Name := '';
      g_OpenArkKeyItem.S.Name := '';
      m_boOpenBox := False;
    end;
  end;
  //m_boOpenMoveEnd
end;

procedure TFrmDlg.DWBooksDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  function SX(x: integer): integer;
  begin
    Result := DSelfShop.SurfaceX(DSelfShop.Left + x);
  end;
  function SY(y: integer): integer;
  begin
    Result := DSelfShop.SurfaceY(DSelfShop.Top + y);
  end;
var
  d: TDirectDrawSurface;
  i: integer;
begin
  with DWBooks do
  begin
    d := g_UIBImages.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    if m_nBooksIdx in [0..4] then
    begin
      d := g_UIBImages.Images[m_nBooksIdx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left + 43), SurfaceY(Top + 31), d.ClientRect, d,
          TRUE);
    end;
  end;
  {d := g_WMain3Images.Images[353];
  if d<>nil then begin
    if DlgCls then dsurface.Draw (SX(18), SY(65), d.ClientRect, d, TRUE)
    else dsurface.Draw (SX(108), SY(65), d.ClientRect, d, TRUE);
  end; }
end;

procedure TFrmDlg.DWChallengeDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  rc: TRect;
  sText,sGold:String;
begin
try
  with DWChallenge do
  begin
    d :=WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      with dsurface.Canvas do
      begin
      case g_nChallengeGoldIndex of
       0:sGold:='金刚石';
       1:sGold:='元宝';
       2:sGold:='灵符';
      end;
        SetBkMode(Handle,TRANSPARENT);
        Font.Color := clWhite;
        TextOut(SurfaceX(Left+54), SurfaceY(Top+271),'挑战中将以武馆教头的挑战规');
        TextOut(SurfaceX(Left+29), SurfaceY(Top+286),'则做为评判胜负的标准，如果你同');
        TextOut(SurfaceX(Left+29), SurfaceY(Top+301),'意就开始挑战吧。');
        TextOut(SurfaceX(Left+178), SurfaceY(Top+60),sGold);//对方金刚石
        TextOut(SurfaceX(Left+178), SurfaceY(Top+161),sGold);//自已金刚石
        Font.Color := clLime;

        TextOut(SurfaceX(Left+100), SurfaceY(Top+102),InttoStr(g_nChallengeRemoteGold));//对方金币
        TextOut(SurfaceX(Left+100), SurfaceY(Top+203),InttoStr(g_nChallengeGold));//自已金币

        sText:=IntToStr(g_nChallengeGameDiamond);
        TextOut(SurfaceX(Left+178 + (DChallengeGrid1.ColWidth -TextWidth(sText)) div 2 -1), SurfaceY(Top+176),sText);//自已金刚石数量
        sText:=InttoStr(g_nChallengeRemoteGameDiamond);
        TextOut(SurfaceX(Left+178 + (DChallengeGrid.ColWidth -TextWidth(sText)) div 2 -1), SurfaceY(Top+75),sText);//对方金刚石数量
        Font.Color := clYellow;
        TextOut(SurfaceX(Left+32), SurfaceY(Top+136),CharName);//自已名字
        TextOut(SurfaceX(Left+32), SurfaceY(Top+35),g_nChallengeRemoteChName);//对方名字
        Release;
      end;
  end;
except
 DebugOutStr('[Exception] TFrmDlg.DWChallenge');
end;
end;

procedure TFrmDlg.DBookCloseDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDButton;
  dd: TDirectDrawSurface;
begin
  if Sender is TDButton then
  begin
    d := TDButton(Sender);
    if not d.Downed then
    begin
      dd := g_UIBImages.Images[d.FaceIndex];
      if dd <> nil then
        dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd,
          TRUE);
    end
    else
    begin
      dd := g_UIBImages.Images[d.FaceIndex + 1];
      if dd <> nil then
        dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd,
          TRUE);
    end;
  end;
end;

procedure TFrmDlg.DBookCloseClick(Sender: TObject; X, Y: Integer);
begin
  DWBooks.Visible := False;
end;

procedure TFrmDlg.DBookNextClick(Sender: TObject; X, Y: Integer);
var
  d: TDirectDrawSurface;
begin
  if m_nBooksIdx < 4 then
  begin
    Inc(m_nBooksIdx);
    DBookPrior.Visible := True;
    if m_nBooksIdx = 4 then
    begin
      d := g_UIBImages.Images[5];
      if d <> nil then
      begin
        DBookNext.Width := d.Width;
        DBookNext.Height := d.Height;
        DBookNext.Left := 371;
        DBookNext.top := 318;
        DBookNext.FaceIndex := 5;
      end;
    end;
  end
  else
  begin
    DWBooks.Visible := False;
    FrmMain.SendClientMessage(CM_OPENBOOKS, 0, 0, 0, 0);
  end;
end;

procedure TFrmDlg.DBookPriorClick(Sender: TObject; X, Y: Integer);
var
  d: TDirectDrawSurface;
begin
  if m_nBooksIdx > 0 then
  begin
    if m_nBooksIdx = 4 then
    begin
      d := g_UIBImages.Images[16];
      if d <> nil then
      begin
        FrmDlg.DBookNext.Width := d.Width;
        FrmDlg.DBookNext.Height := d.Height;
        FrmDlg.DBookNext.Left := 410;
        FrmDlg.DBookNext.top := 320;
        FrmDlg.DBookNext.FaceIndex := 16;
      end;
    end;
    Dec(m_nBooksIdx);
    if m_nBooksIdx = 0 then
      DBookPrior.Visible := False;
  end
  else
    DBookPrior.Visible := False;
end;

procedure TFrmDlg.DWgCloseClick(Sender: TObject; X, Y: Integer);
begin
  DWgInfo.Visible := False;
end;

procedure TFrmDlg.DWgBisicClick(Sender: TObject; X, Y: Integer);
var
  d: TDButton;
begin
  if Sender is TDButton then
  begin
    m_WgIdx := TDButton(Sender).Tag;
  end;
end;

procedure TFrmDlg.DWgInfoDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  with DWgInfo do
  begin
    d := nil;
    case m_WgIdx of
      0:
        begin
          d := g_WMain2Images.Images[156];
          if d = nil then
            d := g_WMain3Images.Images[360];
        end;
      1: d := g_WMain3Images.Images[359];
      2:
        begin
          d := g_WMain2Images.Images[157];
          if d = nil then
            d := g_WMain3Images.Images[464];
        end;
      3: d := g_WMain3Images.Images[362];
      4: d := g_WMain3Images.Images[363];
    end;
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    d := g_WMain3Images.Images[353];
    if d <> nil then
    begin
      case m_WgIdx of
        0:
          begin
            if DWgTop.Visible then
              DWgTop.Visible := False;
            if DWgDown.Visible then
              DWgDown.Visible := False;
            if DWgDown2.Visible then
              DWgDown2.Visible := False;
            if g_WgInfo.boShowAllItem then
              dsurface.Draw(SurfaceX(Left + 22), SurfaceY(Top + 84),
                d.ClientRect, d, TRUE);
            if g_WgInfo.boShowAllItemFil then
              dsurface.Draw(SurfaceX(Left + 22), SurfaceY(Top + 123),
                d.ClientRect, d, TRUE);
            if g_WgInfo.boCloseShift then
              dsurface.Draw(SurfaceX(Left + 22), SurfaceY(Top + 162),
                d.ClientRect, d, TRUE);
            if g_WgInfo.boDuraAlert then
              dsurface.Draw(SurfaceX(Left + 22), SurfaceY(Top + 201),
                d.ClientRect, d, TRUE);
            if g_WgInfo.boAutoPuckUpItem then
              dsurface.Draw(SurfaceX(Left + 110), SurfaceY(Top + 84),
                d.ClientRect, d, TRUE);
            if g_WgInfo.boAutoPuckItemFil then
              dsurface.Draw(SurfaceX(Left + 110), SurfaceY(Top + 123),
                d.ClientRect, d, TRUE);
            if g_WgInfo.boShowName then
              dsurface.Draw(SurfaceX(Left + 110), SurfaceY(Top + 162),
                d.ClientRect, d, TRUE);
          end;
        1:
          begin
            if DWgTop.Visible then
              DWgTop.Visible := False;
            if DWgDown.Visible then
              DWgDown.Visible := False;
            if not DWgDown2.Visible then
              DWgDown2.Visible := True;
            //if not EdHpCountEdit.Visible then EdHpCountEdit.Visible:=True;
            if g_WgInfo.boAutoHp then
              dsurface.Draw(SurfaceX(Left + 34), SurfaceY(Top + 98),
                d.ClientRect, d, TRUE);
            if g_WgInfo.boAutoMp then
              dsurface.Draw(SurfaceX(Left + 34), SurfaceY(Top + 128),
                d.ClientRect, d, TRUE);
            if g_WgInfo.boAutoCropsHp then
              dsurface.Draw(SurfaceX(Left + 34), SurfaceY(Top + 180),
                d.ClientRect, d, TRUE);
            if g_WgInfo.boAutoHpProtect then
              dsurface.Draw(SurfaceX(Left + 34), SurfaceY(Top + 217),
                d.ClientRect, d, TRUE);
            with dsurface.Canvas do
            begin
              SetBkMode(Handle, TRANSPARENT);
              BoldTextOut(Dsurface, SurfaceX(Left + 89), SurfaceY(Top + 102),
                clwhite, clBlack, IntToStr(g_WgInfo.boAutoHpCount));
              BoldTextOut(Dsurface, SurfaceX(Left + 147), SurfaceY(Top + 102),
                clwhite, clBlack, IntToStr(g_WgInfo.boAutoHpTick div 1000));
              BoldTextOut(Dsurface, SurfaceX(Left + 89), SurfaceY(Top + 132),
                clwhite, clBlack, IntToStr(g_WgInfo.boAutoMpCount));
              BoldTextOut(Dsurface, SurfaceX(Left + 147), SurfaceY(Top + 132),
                clwhite, clBlack, IntToStr(g_WgInfo.boAutoMpTick div 1000));
              BoldTextOut(Dsurface, SurfaceX(Left + 89), SurfaceY(Top + 185),
                clwhite, clBlack, IntToStr(g_WgInfo.boAutoCropsHpCount));
              BoldTextOut(Dsurface, SurfaceX(Left + 147), SurfaceY(Top + 185),
                clwhite, clBlack, IntToStr(g_WgInfo.boAutoCropsHpTick div
                  1000));
              BoldTextOut(Dsurface, SurfaceX(Left + 89), SurfaceY(Top + 222),
                clwhite, clBlack, IntToStr(g_WgInfo.boAutoHpProtectCount));
              BoldTextOut(Dsurface, SurfaceX(Left + 146), SurfaceY(Top + 222),
                clwhite, clBlack, IntToStr(g_WgInfo.boAutoHpOrotectTick div
                1000));
              BoldTextOut(Dsurface, SurfaceX(Left + 88), SurfaceY(Top + 247),
                clwhite, clBlack, CropsItem[DWgDown2.tag]);
              Release;
            end;
          end;
        2:
          begin
            if DWgTop.Visible then
              DWgTop.Visible := False;
            if DWgDown.Visible then
              DWgDown.Visible := False;
            if DWgDown2.Visible then
              DWgDown2.Visible := False;
            if g_WgInfo.boCanLongHit then
              dsurface.Draw(SurfaceX(Left + 27), SurfaceY(Top + 85),
                d.ClientRect, d, TRUE);
            if g_WgInfo.boCanAutoFireHit then
              dsurface.Draw(SurfaceX(Left + 27), SurfaceY(Top + 119),
                d.ClientRect, d, TRUE);
            if g_WgInfo.boCanCloak then
              dsurface.Draw(SurfaceX(Left + 27), SurfaceY(Top + 153),
                d.ClientRect, d, TRUE);

            if g_WgInfo.boCanWideHit then
              dsurface.Draw(SurfaceX(Left + 110), SurfaceY(Top + 85),
                d.ClientRect, d, TRUE);
            if g_WgInfo.boCanShield then
              dsurface.Draw(SurfaceX(Left + 110), SurfaceY(Top + 119),
                d.ClientRect, d, TRUE);
            if g_HeronRecogId > 0 then
            begin
              if g_HerobtJob = 1 then
              begin
                if g_WgInfo.boHeroAutoMagic then
                  dsurface.Draw(SurfaceX(Left + 27), SurfaceY(Top + 187),
                    d.ClientRect, d, TRUE);
              end
              else if g_HerobtJob = 2 then
              begin
                //case g_WgInfo.btHeroCallMobClass of
                if g_WgInfo.boHeroCallBoneFamm then
                  dsurface.Draw(SurfaceX(Left + 27), SurfaceY(Top + 234),
                    d.ClientRect, d, TRUE);
                if g_WgInfo.boHeroCallDogz then
                  dsurface.Draw(SurfaceX(Left + 81), SurfaceY(Top + 234),
                    d.ClientRect, d, TRUE);
                if g_WgInfo.boHeroCallFairy then
                  dsurface.Draw(SurfaceX(Left + 133), SurfaceY(Top + 234),
                    d.ClientRect, d, TRUE);
                //end;
              end;
            end;
          end;
        3:
          begin
            if DWgTop.Visible then
              DWgTop.Visible := False;
            if DWgDown.Visible then
              DWgDown.Visible := False;
            if DWgDown2.Visible then
              DWgDown2.Visible := False;
            if g_WgInfo.boAutoMagic then
              dsurface.Draw(SurfaceX(Left + 30), SurfaceY(Top + 110),
                d.ClientRect, d, TRUE);
            with dsurface.Canvas do
            begin
              SetBkMode(Handle, TRANSPARENT);
              BoldTextOut(Dsurface, SurfaceX(Left + 136), SurfaceY(Top + 114),
                clwhite, clBlack, IntToStr(g_WgInfo.nAutoMagicTime div 1000));
              Release;
            end;
          end;
        4:
          begin
            if not DWgTop.Visible then
              DWgTop.Visible := True;
            if not DWgDown.Visible then
              DWgDown.Visible := True;
            if DWgDown2.Visible then
              DWgDown2.Visible := False;
            with dsurface.Canvas do
            begin
              SetBkMode(Handle, TRANSPARENT);
              case m_WgHintIdx of
                0:
                  begin
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top +
                      70), clwhite, clBlack, '【黑名单】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 1 * 15), clwhite, clBlack,
                      '鼠标点中指定角色同时按');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 2 * 15), clwhite, clBlack,
                      'Alt+S 既可将该玩家加入');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 3 * 15), clwhite, clBlack,
                      '黑名单，再次使用鼠标点');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 4 * 15), clwhite, clBlack,
                      '中指定角色同时按Alt+S');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 5 * 15), clwhite, clBlack,
                      '既可将该玩家移出黑名单');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 6 * 15), clwhite, clBlack,
                      '在将玩家加入黑名单后，');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 7 * 15), clwhite, clBlack,
                      '您将屏蔽该玩家的喊话。');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 8 * 15), clwhite, clBlack,
                      '（或使用命令@加入黑名');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 9 * 15), clwhite, clBlack,
                      '单+空格+玩家名既可将玩');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 10 * 15), clwhite, clBlack,
                      '家加入黑名单。再次输入');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 11 * 15), clwhite, clBlack,
                      '@清除黑名单+空格+玩家名');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 12 * 15), clwhite, clBlack,
                      '可将该玩家移出黑名单）');
                  end;
                1:
                  begin
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top +
                      70), clwhite, clBlack, '【编组添加】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 1 * 15), clwhite, clBlack,
                      '鼠标点中要组队的角色同');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 2 * 15), clwhite, clBlack,
                        '时按Alt+W 既可自动和');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 3 * 15), clwhite, clBlack, '该角色组队');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 5 * 15), clwhite, clBlack, '【编组删除】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 6 * 15), clwhite, clBlack,
                      '鼠标点中要删除的角色同');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 7 * 15), clwhite, clBlack,
                      '时按Alt+E 既可自动把该');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 8 * 15), clwhite, clBlack, '角色从队伍中删除');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 10 * 15), clwhite, clBlack, '【人名显示】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 11 * 15), clwhite, clBlack,
                      '显示屏幕范围内所有角色');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 12 * 15), clwhite, clBlack, '的名字');
                  end;
                2:
                  begin
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top +
                      70), clwhite, clBlack, '');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 1 * 15), clwhite, clBlack, '【持久警告】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 2 * 15), clwhite, clBlack,
                      '对既将损坏的装各，在对');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 3 * 15), clwhite, clBlack,
                        '话框中进行提前报警');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 4 * 15), clwhite, clBlack, '');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 5 * 15), clwhite, clBlack, '【物品显示】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 6 * 15), clwhite, clBlack,
                      '显示屏幕范围内地上的所');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 7 * 15), clwhite, clBlack, '有物品');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 8 * 15), clwhite, clBlack, '');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 9 * 15), clwhite, clBlack, '【自动捡物】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 10 * 15), clwhite, clBlack,
                      '只要站在需要拾取的物品');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 11 * 15), clwhite, clBlack,
                      '上既可自动拣取该物品');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 12 * 15), clwhite, clBlack, '');
                  end;
                3:
                  begin
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top +
                      70), clwhite, clBlack, '【显示过滤】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 1 * 15), clwhite, clBlack,
                      '只显示屏幕范围内地面上');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 2 * 15), clwhite, clBlack, '的贵重物品');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 3 * 15), clwhite, clBlack, '');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 4 * 15), clwhite, clBlack, '【拣物过滤】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 5 * 15), clwhite, clBlack,
                      '同“自动拣物”功能，');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 6 * 15), clwhite, clBlack,
                      '但只自动拣取贵重物品');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 7 * 15), clwhite, clBlack, '');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 8 * 15), clwhite, clBlack, '');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 9 * 15), clwhite, clBlack, '');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 10 * 15), clwhite, clBlack, '');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 11 * 15), clwhite, clBlack, '');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 12 * 15), clwhite, clBlack, '');
                  end;
                4:
                  begin
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top +
                      70), clwhite, clBlack, '【自动补血】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 1 * 15), clwhite, clBlack,
                      '开启后还须手动设置，');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 2 * 15), clwhite, clBlack,
                      '可设定自动补血间隔时间');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 3 * 15), clwhite, clBlack,
                      '和使用金创药的HP下限');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 4 * 15), clwhite, clBlack, '【自动补魔】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 5 * 15), clwhite, clBlack,
                        '开启后必须手动设置');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 6 * 15), clwhite, clBlack,
                      '可设定自动补魔间隔时间');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 7 * 15), clwhite, clBlack,
                      '和使用魔法药的MP下限');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 8 * 15), clwhite, clBlack, '【特殊药品】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 9 * 15), clwhite, clBlack,
                      '开启后必须手动设置，');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 10 * 15), clwhite, clBlack,
                      '可设定自动补药间隔时间');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 11 * 15), clwhite, clBlack,
                      '和使用特殊药品的HP下限');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 12 * 15), clwhite, clBlack, '');
                  end;
                5:
                  begin
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top +
                      70), clwhite, clBlack, '【自动练功】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 1 * 15), clwhite, clBlack,
                      '用于自动修炼技能。可设');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 2 * 15), clwhite, clBlack,
                      '定自动练功的技能以及时');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 3 * 15), clwhite, clBlack,
                      '间间隔。开启后须使用一');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 4 * 15), clwhite, clBlack,
                      '次要自动练功的技能，然');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 5 * 15), clwhite, clBlack,
                      '后该技能既可按设定的间');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 6 * 15), clwhite, clBlack,
                      '隔时间自动重复使用。');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 7 * 15), clwhite, clBlack, '【随机保护】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 8 * 15), clwhite, clBlack,
                      '开启后还须设定HP下限');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 9 * 15), clwhite, clBlack,
                      '和使用的卷轴或回城石，');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 10 * 15), clwhite, clBlack,
                      '当HP达到设定的下限时');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 11 * 15), clwhite, clBlack,
                      '即会自动使用设定的卷轴');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 12 * 15), clwhite, clBlack, '或回城石进行保护');
                  end;
                6:
                  begin
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top +
                      70), clwhite, clBlack, '【刀刀刺杀】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 1 * 15), clwhite, clBlack,
                      '挥出的每一刀攻击都是刺');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 2 * 15), clwhite, clBlack, '杀攻击');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 3 * 15), clwhite, clBlack, '');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 4 * 15), clwhite, clBlack, '【自动烈火】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 5 * 15), clwhite, clBlack,
                      '每隔10秒将自动使用烈');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 6 * 15), clwhite, clBlack, '火剑法');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 7 * 15), clwhite, clBlack, '');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 8 * 15), clwhite, clBlack, '【智能半月】');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 9 * 15), clwhite, clBlack,
                      '攻击多个怪物时会自动启');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 10 * 15), clwhite, clBlack, '用半月弯刀');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 11 * 15), clwhite, clBlack, '');
                    BoldTextOut(Dsurface, SurfaceX(Left + 30), SurfaceY(Top + 70
                      + 12 * 15), clwhite, clBlack, '');
                  end;
              end;
              Release;
            end;
          end;
      end;
    end;
  end;
  {   }
end;

procedure TFrmDlg.DWgTopClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DWgTop then
  begin
    if m_WgHintIdx > 0 then
      Dec(m_WgHintIdx);
  end
  else if Sender = DWgDown then
  begin
    if m_WgHintIdx < 6 then
      Inc(m_WgHintIdx);
  end
  else if Sender = DWgDown2 then
  begin
    if DWgDown2.Tag >= High(CropsItem) then
      DWgDown2.Tag := 0
    else
      DWgDown2.Tag := DWgDown2.Tag + 1;
    g_WgInfo.boAutoHpProtectName := CropsItem[DWgDown2.Tag];
  end;
end;

procedure TFrmDlg.DWMakeWineDeskDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  rc: TRect;
begin
  with DWMakeWineDesk do
  begin
    d :=WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
if g_DBMakeWineidx<>1 then
 begin
  case g_MakeWineidx of
    0: d := g_WMain2Images.Images[585];
    1: d := g_WMain2Images.Images[587];
  end;
    if d <> nil then
     dsurface.Draw(SurfaceX(Left+97), SurfaceY(Top+199), d.ClientRect, d, True);
 end;
 case g_DBMakeWineidx of
  0,2:
  begin
   d := g_WMain2Images.Images[586];
    if d <> nil then
     dsurface.Draw(SurfaceX(Left+101), SurfaceY(Top+9), d.ClientRect, d, TRUE);
  if g_DBMakeWineidx=2 then
  begin
      d := g_WMain2Images.Images[589];
    if d <> nil then
     dsurface.Draw(SurfaceX(Left+102), SurfaceY(Top+11), d.ClientRect, d, True);
       SetBkMode(dsurface.Canvas.Handle, TRANSPARENT);
    case g_MakeWineidx of
     0:
      begin
      BoldTextOut(dsurface,SurfaceX(Left + 108), SurfaceY(Top + 20), GetRGB(255), clBlack,
            '材料的品质是酒品质的基础，品质越好，才越');
       BoldTextOut(dsurface,SurfaceX(Left + 108), SurfaceY(Top + 35), GetRGB(255), clBlack,
            '有可能酿出好酒。还有，如果你有比我这里清');
       BoldTextOut(dsurface,SurfaceX(Left + 108), SurfaceY(Top + 50), GetRGB(255), clBlack,
            '水更甘甜的水，那用它来酿酒就更好了。');
      end;
     1:
      begin
      BoldTextOut(dsurface,SurfaceX(Left + 108), SurfaceY(Top + 20), GetRGB(255), clBlack,
            '药酒的功效主要源自药材，不同的药材会有不');
       BoldTextOut(dsurface,SurfaceX(Left + 108), SurfaceY(Top + 35), GetRGB(255), clBlack,
            '同的效果。据说还有一些独特的药酒，可能会');
       BoldTextOut(dsurface,SurfaceX(Left + 108), SurfaceY(Top + 50), GetRGB(255), clBlack,
            '对配制药酒的瓶子另有要求。');
      end;
    end;
        dsurface.Canvas.Release;
  end;
  end;
  1:
  begin
     case g_MakeWineidx of
        0: d := g_WMain2Images.Images[592];
        1: d := g_WMain2Images.Images[593];
     end;
     if d <> nil then
       dsurface.Draw(SurfaceX(Left+99), SurfaceY(Top-1), d.ClientRect, d, TRUE);
  end;
  3:
  begin
     d := g_WMain2Images.Images[588];
     if d <> nil then
     dsurface.Draw(SurfaceX(Left+101), SurfaceY(Top+9), d.ClientRect, d, TRUE);
  end;
 end;
   with dsurface.Canvas do
    begin
      SetBkMode(Handle, TRANSPARENT);
      Font.Color := clWhite;
      TextOut(SurfaceX(Left + 20), SurfaceY(Top + 111),'酒馆老板娘');
      Release;
    end;
{$REGION '提示鼠标上物品在酿酒台的位示'}
if (g_DBMakeWineidx=0) or (g_DBMakeWineidx=2) then
begin
  if   g_boItemMoving then
   begin
      d := g_WMainImages.Images[394];
      if (g_MovingItem.Item.S.Name<>'') and (d <> nil) then
       case g_MovingItem.Item.S.StdMode of
        60:
        begin
          if (g_MakeWineidx=1) and (g_WineItem1[DBWine.Tag].S.Name='') then
              DrawBlendEx(dsurface,SurfaceX(Left+DBWine.Left+5),
                 SurfaceY(Top+DBWine.Top+5),d,0,0,DBWine.Width-8,DBWine.Height-8,0);
         end;
        8:
        begin
          if g_MakeWineidx=0 then
          begin
            if g_WineItem[DBMateria.Tag].S.Name='' then
              DrawBlendEx(dsurface,SurfaceX(Left+DBMateria.Left+5),
                SurfaceY(Top+DBMateria.Top+6),d,0,0,DBMateria.Width-8,DBMateria.Height-8,0);
            if g_WineItem[DBassistMaterial1.Tag].S.Name='' then
              DrawBlendEx(dsurface,SurfaceX(Left+DBassistMaterial1.Left+5),
                SurfaceY(Top+DBassistMaterial1.Top+6),d,0,0,DBassistMaterial1.Width-8,DBassistMaterial1.Height-8,0);
            if g_WineItem[DBassistMaterial2.Tag].S.Name='' then
              DrawBlendEx(dsurface,SurfaceX(Left+DBassistMaterial2.Left+5),
                SurfaceY(Top+DBassistMaterial2.Top+6),d,0,0,DBassistMaterial2.Width-8,DBassistMaterial2.Height-8,0);
            if g_WineItem[DBassistMaterial3.Tag].S.Name='' then
              DrawBlendEx(dsurface,SurfaceX(Left+DBassistMaterial3.Left+5),
                SurfaceY(Top+DBassistMaterial3.Top+6),d,0,0,DBassistMaterial3.Width-8,DBassistMaterial3.Height-8,0);
          end;
        end;
        9:
        begin
          if (g_MakeWineidx=0) and (g_WineItem[DBWater.Tag].S.Name='') then
              DrawBlendEx(dsurface,SurfaceX(Left+DBWater.Left+4),
                SurfaceY(Top+DBWater.Top+4),d,0,0,DBWater.Width-8,DBWater.Height-8,0);
        end;
        12:
        begin
          if g_MakeWineidx=0 then
            begin
             if g_WineItem[DBWineCrock.Tag].S.Name=''  then
             DrawBlendEx(dsurface,SurfaceX(Left+DBWineCrock.Left+5),
                SurfaceY(Top+DBWineCrock.Top+6),d,0,0,DBWineCrock.Width-8,DBWineCrock.Height-8,0);
            end
          else
           begin
             if g_WineItem1[DBWineBottle.Tag].S.Name=''  then
              DrawBlendEx(dsurface,SurfaceX(Left+DBWineBottle.Left+5),
                SurfaceY(Top+DBWineBottle.Top+6),d,0,0,DBWineBottle.Width-8,DBWineBottle.Height-8,0);
           end;
         end;
        13:
        begin
          if (g_MakeWineidx=0) and (g_WineItem[DBWineSong.Tag].S.Name='') then
            DrawBlendEx(dsurface,SurfaceX(Left+DBWineSong.Left+4),
                SurfaceY(Top+DBWineSong.Top+5),d,0,0,DBWineSong.Width-8,DBWineSong.Height-8,0);
        end;
        14:
        begin
          if (g_MakeWineidx=1) and (g_WineItem1[DBDrug.Tag].S.Name='') then
            DrawBlendEx(dsurface,SurfaceX(Left+DBDrug.Left+5),
                SurfaceY(Top+DBDrug.Top+5),d,0,0,DBDrug.Width-8,DBDrug.Height-8,0);
        end;
        end;
   end;
end;
{$ENDREGION}

   //////放下物显示//////////
{$REGION '放下物显示'}
if (g_DBMakeWineidx=0) or (g_DBMakeWineidx=2) then
begin
   if g_WineItem[0].S.Name<>'' then
   begin
     d := g_WMain2Images.Images[601];
      if d <> nil then
     dsurface.Draw(SurfaceX(Left+295), SurfaceY(Top+147), d.ClientRect, d, TRUE);
   end;
   if g_WineItem[1].S.Name<>'' then
   begin
     d := g_WMain2Images.Images[596];
      if d <> nil then
     dsurface.Draw(SurfaceX(Left+122), SurfaceY(Top+109), d.ClientRect, d, TRUE);
   end;
   if g_WineItem[2].S.Name<>'' then
   begin
     d := g_WMain2Images.Images[597];
     if d <> nil then
     dsurface.Draw(SurfaceX(Left+156), SurfaceY(Top+167), d.ClientRect, d, TRUE);
   end;
   if g_WineItem[4].S.Name<>'' then
   begin
     d := g_WMain2Images.Images[600];
     if d <> nil then
     dsurface.Draw(SurfaceX(Left+331), SurfaceY(Top+137), d.ClientRect, d, TRUE);
   end;
   if g_WineItem[5].S.Name<>'' then
   begin
     d := g_WMain2Images.Images[599];
      if d <> nil then
     dsurface.Draw(SurfaceX(Left+289), SurfaceY(Top+119), d.ClientRect, d, TRUE);
   end;
   if g_WineItem[6].S.Name<>'' then
   begin
     d := g_WMain2Images.Images[598];
      if d <> nil then
     dsurface.Draw(SurfaceX(Left+236), SurfaceY(Top+124), d.ClientRect, d, TRUE);
   end;
   if g_WineItem1[0].S.Name<>'' then
   begin
     d := g_WMain2Images.Images[603];
      if d <> nil then
     dsurface.Draw(SurfaceX(Left+245), SurfaceY(Top+107), d.ClientRect, d, TRUE);
   end;
   if g_WineItem1[1].S.Name<>'' then
   begin
     d := g_WMain2Images.Images[602];
      if d <> nil then
     dsurface.Draw(SurfaceX(Left+161), SurfaceY(Top+139), d.ClientRect, d, TRUE);
   end;
end;
{$ENDREGION}
 ////////////////////////

    if g_DBMakeWineidx=3 then
    begin
        if showWineidx < 610 then
          showWineidx := 610;
        if showWineidx >= (610 + 19) then
        begin
          DWMakeWineDesk.Visible:=False;
          DItemBag.Visible:=False;
          g_DBMakeWineidx:=0;//酿酒台按键号
          showWineidx := 610;
          FrmMain.SendMakeWine(); 
        end;
        d := g_WMain2Images.Images[showWineidx];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left+166), SurfaceY(Top+9), d.ClientRect, d, TRUE);
        if (GetTickCount - showWineTime) > 150 then
        begin
          showWineTime:= GetTickCount;
          Inc(showWineidx);
        end;
    end;
  end;
end;

procedure TFrmDlg.DWMakeWineDeskMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   DScreen.ClearHint;
end;

procedure TFrmDlg.DWgInfoClick(Sender: TObject; X, Y: Integer);
var
  Old: Byte;
  boChange: Boolean;
  Int: Integer;
begin
  x := abs(DWgInfo.Left - X);
  y := abs(DWgInfo.Top - Y);
  case m_WgIdx of
    0:
      begin
        if (x > 25) and (Y > 85) and (x < 93) and (y < 102) then
        begin
          g_WgInfo.boShowAllItem := not g_WgInfo.boShowAllItem;
        end
        else if (x > 25) and (Y > 123) and (x < 93) and (y < 141) then
        begin
          g_WgInfo.boShowAllItemFil := not g_WgInfo.boShowAllItemFil;
        end
        else if (x > 25) and (Y > 160) and (x < 93) and (y < 180) then
        begin
          g_WgInfo.boCloseShift := not g_WgInfo.boCloseShift;
        end
        else if (x > 25) and (Y > 200) and (x < 93) and (y < 220) then
        begin
          g_WgInfo.boDuraAlert := not g_WgInfo.boDuraAlert;
        end
        else if (x > 113) and (Y > 85) and (x < 180) and (y < 102) then
        begin
          g_WgInfo.boAutoPuckUpItem := not g_WgInfo.boAutoPuckUpItem;
        end
        else if (x > 113) and (Y > 123) and (x < 180) and (y < 141) then
        begin
          g_WgInfo.boAutoPuckItemFil := not g_WgInfo.boAutoPuckItemFil;
        end
        else if (x > 113) and (Y > 160) and (x < 180) and (y < 180) then
        begin
          g_WgInfo.boShowName := not g_WgInfo.boShowName;
        end;
      end;
    1:
      begin
        if (x > 37) and (Y > 99) and (x < 54) and (y < 115) then
        begin
          g_WgInfo.boAutoHp := not g_WgInfo.boAutoHp;
        end
        else if (x > 37) and (Y > 128) and (x < 54) and (y < 145) then
        begin
          g_WgInfo.boAutoMp := not g_WgInfo.boAutoMp;
        end
        else if (x > 37) and (Y > 181) and (x < 54) and (y < 198) then
        begin
          g_WgInfo.boAutoCropsHp := not g_WgInfo.boAutoCropsHp;
        end
        else if (x > 37) and (Y > 218) and (x < 54) and (y < 236) then
        begin
          g_WgInfo.boAutoHpProtect := not g_WgInfo.boAutoHpProtect;
        end
        else if (x > 86) and (Y > 98) and (x < 115) and (y < 115) then
        begin
          DMessageDlg('请输入数值.', [mbOk, mbAbort]);
          Int := Str_ToInt(Trim(DlgEditText), -1);
          if (Int > 0) and (Int < 10000) then
          begin
            g_WgInfo.boAutoHpCount := Int;
          end
          else
            DMessageDlg('您输入的数值不正确，请重新输入',
              [mbOK]);
        end
        else if (x > 86) and (Y > 129) and (x < 115) and (y < 145) then
        begin
          DMessageDlg('请输入数值.', [mbOk, mbAbort]);
          Int := Str_ToInt(Trim(DlgEditText), -1);
          if (Int > 0) and (Int < 10000) then
          begin
            g_WgInfo.boAutoMpCount := Int;
          end
          else
            DMessageDlg('您输入的数值不正确，请重新输入',
              [mbOK]);
        end
        else if (x > 86) and (Y > 181) and (x < 115) and (y < 198) then
        begin
          DMessageDlg('请输入数值.', [mbOk, mbAbort]);
          Int := Str_ToInt(Trim(DlgEditText), -1);
          if (Int > 0) and (Int < 10000) then
          begin
            g_WgInfo.boAutoCropsHpCount := Int;
          end
          else
            DMessageDlg('您输入的数值不正确，请重新输入',
              [mbOK]);
        end
        else if (x > 86) and (Y > 218) and (x < 115) and (y < 235) then
        begin
          DMessageDlg('请输入数值.', [mbOk, mbAbort]);
          Int := Str_ToInt(Trim(DlgEditText), -1);
          if (Int > 0) and (Int < 10000) then
          begin
            g_WgInfo.boAutoHpProtectCount := Int;
          end
          else
            DMessageDlg('您输入的数值不正确，请重新输入',
              [mbOK]);
        end
        else if (x > 143) and (Y > 99) and (x < 160) and (y < 115) then
        begin
          DMessageDlg('请输入数值.', [mbOk, mbAbort]);
          Int := Str_ToInt(Trim(DlgEditText), -1);
          if (Int > 0) and (Int < 100) then
          begin
            g_WgInfo.boAutoHpTick := Int * 1000;
          end
          else
            DMessageDlg('您输入的数值不正确，请重新输入',
              [mbOK]);
        end
        else if (x > 143) and (Y > 128) and (x < 160) and (y < 147) then
        begin
          DMessageDlg('请输入数值.', [mbOk, mbAbort]);
          Int := Str_ToInt(Trim(DlgEditText), -1);
          if (Int > 0) and (Int < 100) then
          begin
            g_WgInfo.boAutoMpTick := Int * 1000;
          end
          else
            DMessageDlg('您输入的数值不正确，请重新输入',
              [mbOK]);
        end
        else if (x > 143) and (Y > 182) and (x < 160) and (y < 198) then
        begin
          DMessageDlg('请输入数值.', [mbOk, mbAbort]);
          Int := Str_ToInt(Trim(DlgEditText), -1);
          if (Int > 0) and (Int < 100) then
          begin
            g_WgInfo.boAutoCropsHpTick := Int * 1000;
          end
          else
            DMessageDlg('您输入的数值不正确，请重新输入',
              [mbOK]);
        end
        else if (x > 143) and (Y > 218) and (x < 160) and (y < 236) then
        begin
          DMessageDlg('请输入数值.', [mbOk, mbAbort]);
          Int := Str_ToInt(Trim(DlgEditText), -1);
          if (Int > 0) and (Int < 100) then
          begin
            g_WgInfo.boAutoHpOrotectTick := Int * 1000;
          end
          else
            DMessageDlg('您输入的数值不正确，请重新输入',
              [mbOK]);
        end;
      end;
    2:
      begin
        if (x > 33) and (Y > 86) and (x < 97) and (y < 100) then
        begin
          g_WgInfo.boCanLongHit := not g_WgInfo.boCanLongHit;
        end
        else if (x > 33) and (Y > 118) and (x < 97) and (y < 136) then
        begin
          g_WgInfo.boCanAutoFireHit := not g_WgInfo.boCanAutoFireHit;
        end
        else if (x > 33) and (Y > 152) and (x < 97) and (y < 171) then
        begin
          g_WgInfo.boCanCloak := not g_WgInfo.boCanCloak;
        end
        else if (x > 33) and (Y > 186) and (x < 97) and (y < 205) then
        begin
          if (g_HeronRecogId > 0) and (g_HerobtJob = 1) then
          begin
            g_WgInfo.boHeroAutoMagic := not g_WgInfo.boHeroAutoMagic;
            Frmmain.SendHeroFun(Integer(g_WgInfo.boHeroAutoMagic), 0);
          end;
        end
        else if (x > 113) and (Y > 86) and (x < 179) and (y < 100) then
        begin
          g_WgInfo.boCanWideHit := not g_WgInfo.boCanWideHit;
        end
        else if (x > 113) and (Y > 118) and (x < 179) and (y < 136) then
        begin
          g_WgInfo.boCanShield := not g_WgInfo.boCanShield;
        end
        else if (g_HeronRecogId > 0) and (g_HerobtJob = 2) then
        begin
          if (x > 30) and (Y > 233) and (x < 75) and (y < 250) then
          begin
            g_WgInfo.boHeroCallBoneFamm := not g_WgInfo.boHeroCallBoneFamm;
            boChange := True;
          end
          else if (x > 84) and (Y > 233) and (x < 129) and (y < 250) then
          begin
            g_WgInfo.boHeroCallDogz := not g_WgInfo.boHeroCallDogz;
            boChange := True;
          end
          else if (x > 136) and (Y > 233) and (x < 180) and (y < 250) then
          begin
            g_WgInfo.boHeroCallFairy := not g_WgInfo.boHeroCallFairy;
            boChange := True;
          end;
          if boChange then
          begin
            FrmMain.SendHeroMob();
          end;
        end;
      end;
    3:
      begin
        if (x > 34) and (Y > 111) and (x < 51) and (y < 128) then
        begin
          g_WgInfo.boAutoMagic := not g_WgInfo.boAutoMagic;
        end
        else if (x > 132) and (Y > 110) and (x < 160) and (y < 128) then
        begin
          DMessageDlg('请输入数值.', [mbOk, mbAbort]);
          Int := Str_ToInt(Trim(DlgEditText), -1);
          if (Int > 0) and (Int < 10000) then
          begin
            g_WgInfo.nAutoMagicTime := Int * 1000;
          end
          else
            DMessageDlg('您输入的数值不正确，请重新输入',
              [mbOK]);
        end;
      end;
  end;
end;
{$REGION '没用的'}
{procedure TFrmDlg.EmbeddedWBCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
end;

procedure TFrmDlg.WebCloseQuery();
begin
Try
  BottonPanel.Free;
  BottonPanel:=Nil;
  ExitWebBtn.Free;
  EmbeddedWB.Free;
  WebPanel.Free;
  ExitWebBtn:=Nil;
  EmbeddedWB:=Nil;
  WebPanel:=Nil;
Except
end;
end;     }

{procedure TFrmDlg.WebBtnChick(Sender: TObject);
begin
Try
  PostMessage(EmbeddedWB.Handle,WM_CLOSE,0,0);
Except
end;
end;    }

{procedure TFrmDlg.OpenGameWeb(Url:String);
begin
  if (g_MySelf=Nil) or (BottonPanel<>Nil) or (Url='') then exit;
  WebPanel:=TPanel.Create(FrmMain.Owner);
  with WebPanel do begin
    Align      := alClient;
    BevelOuter := bvNone;
    Color      := clBlack;
    Parent     := FrmMain;
  end;
  EmbeddedWB:=TEwbCore.Create(FrmMain.Owner);
  with EmbeddedWB do begin
    Left                   :=0;
    Top                    :=0;
    Width                  :=WebPanel.Width;
    Height                 :=WebPanel.Height;
    //DialogBoxes.DisableAll :=True;
    DisabledPopupMenus:=[rcmAll];
    UserInterfaceOptions:=[DontUseScrollBars];
    OnCloseQuery:=EmbeddedWBCloseQuery;
    ParentWindow:= WebPanel.Handle;

  end;
  BottonPanel:=TPanel.Create(FrmMain.Owner);
  with BottonPanel do begin
    Align      := alBottom;
    BevelOuter := bvNone;
    Color      := clBlack;
    Height     := 25;
    Parent     := WebPanel;
  end;
  //if ExitWebBtn=Nil then
  ExitWebBtn:=TRzBitBtn.Create(FrmMain.Owner);
  with ExitWebBtn do begin
    Align      := alRight;
    Color      := clBlack;
    Caption    := '返 回';
    Font.Color := clWhite;
    Parent     := BottonPanel;
    OnClick    := WebBtnChick;
  end;
  EmbeddedWB.Navigate(Url);
end;
       }
{EdHpCountEdit
}
{$ENDREGION}
procedure TFrmDlg.DButtonLingfuDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    with Sender as TDButton do
    begin
      if not TDButton(Sender).Downed then
      begin
        d := g_UIBImages.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end
      else
      begin
        d := g_UIBImages.Images[FaceIndex + 1];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
    end;
  except
    DebugOutStr('[Exception] TFrmDlg.DButtonLingfuDirectPaint');
    //程序自动增加
  end;
end;

procedure TFrmDlg.DButtonPaymentClick(Sender: TObject; X, Y: Integer);
begin
    FrmMain.SendShopPay();
end;

procedure TFrmDlg.DButton3DirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  rc:TRect;
begin
with DButton3 do
 begin
    d :=  g_WMain2Images.Images[577];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d,TRUE);
     if g_MySelf<>nil then
     begin
       d := g_WMain2Images.Images[578];
        if (d <> nil) and (g_MySelf.m_SKILL84Rec.SKILL84Exp>0) then
        begin
          try
            rc := d.ClientRect;
            rc.Right := Round((rc.Right-rc.Left) / 100 *
              (Round(g_MySelf.m_SKILL84Rec.SKILL84Exp /g_MySelf.m_SKILL84Rec.MaxSKILL84Exp*100)));
            dsurface.Draw(SurfaceX(Left), SurfaceY(Top), rc, d, True);
          except

          end;
        end;
     end;
 end;
end;

procedure TFrmDlg.DButton3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
try
 if g_MySelf<>nil then
 begin
    with DButton3 do
      DScreen.ShowHint(SurfaceX(Left), SurfaceY(Top),
       '当前经验:'+IntToStr(g_MySelf.m_SKILL84Rec.SKILL84Exp)+'/'+IntToStr(g_MySelf.m_SKILL84Rec.MaxSKILL84Exp),
        $00ADD6EF,True);
 end;
except

end;
end;

procedure TFrmDlg.DButton4DirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  rc:TRect;
begin
with DButton4 do
 begin
    d :=  g_WMain2Images.Images[577];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d,TRUE);
       d := g_WMain2Images.Images[578];
        if (d <> nil) and (g_SKILL84Rec.SKILL84Exp>0) then
        begin
          try
            rc := d.ClientRect;
            rc.Right := Round((rc.Right-rc.Left) / 100 *
            (Round(g_SKILL84Rec.SKILL84Exp /g_SKILL84Rec.MaxSKILL84Exp*100)));
            dsurface.Draw(SurfaceX(Left), SurfaceY(Top), rc, d, True);
          except

          end;
        end;
 end;
end;

procedure TFrmDlg.DButton4MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
try
    with DButton4 do
      DScreen.ShowHint(SurfaceX(Left), SurfaceY(Top),
       '当前经验:'+IntToStr(g_SKILL84Rec.SKILL84Exp)+'/'+IntToStr(g_SKILL84Rec.MaxSKILL84Exp),
        $00ADD6EF,True);
except

end;
end;

procedure TFrmDlg.DButtonLingfuClick(Sender: TObject; X, Y: Integer);
var
  sCount: string;
  nCount: Integer;
begin
if g_MySelf.m_nGameGold>=1 then
begin
  DMessageDlg('请输入需要兑换的灵符数量(1-1000)：', [mbOk,
    mbAbort]);
  sCount := Trim(DlgEditText);
  nCount := StrToIntDef(sCount, -1);
  if (nCount > 0) and (nCount <= 1000) then
  begin
    FrmMain.SendShopLingfu(nCount);
  end
  else
    DMessageDlg('你输入的灵符数量不正确，请重新输入!', [mbOk]);
end else
   DMessageDlg('您的元宝数量为0,不能进行兑换!', [mbOk]);
end;

procedure TFrmDlg.DBotSendClick(Sender: TObject; X, Y: Integer);
var
  sCount: string;
begin
  if ShowItem <> nil then
  begin
    DMessageDlg('请输入你要赠送的人物游戏名称：', [mbOk,
      mbAbort]);
    sCount := Trim(DlgEditText);
    if sCount <> '' then
    begin
      if DMessageDlg(Format('确定向玩家 [%s] 赠送物品 [%s] 吗？',
        [sCount, ShowItem.sName]), [mbYes, mbNo]) = mrYes then
      begin
        FrmMain.SendShopSend(ShowItem.sName, sCount);
      end;
    end;
  end;
end;

procedure TFrmDlg.DPlayDrinkDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  with DPlayDrink do
  begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    d := WLib.Images[364];
    if d <> nil then
    begin
      dsurface.Draw(SurfaceX(Left + 93), SurfaceY(Top + 193), d.ClientRect, d,
        TRUE);
      dsurface.Draw(SurfaceX(Left + 277), SurfaceY(Top + 200), d.ClientRect, d,
        TRUE);
    end;
    if m_PlayDrinkStart then
    begin
      d := g_WMain2Images.Images[370 + m_PlayDrinkIdx * 20 +
        m_PlayDrinkStartIdx];
      if (GetTickCount - m_PlayDrinkTime) > 150 then
      begin
        Inc(m_PlayDrinkStartIdx);
        if m_PlayDrinkStartIdx > 10 then
          m_PlayDrinkStart := False;
        m_PlayDrinkTime := GetTickCount;
      end;
    end
    else
      d := g_WMain2Images.Images[342 + m_PlayDrinkIdx];
    if d <> nil then
    begin
      dsurface.Draw(SurfaceX(Left + 17), SurfaceY(Top + 20), d.ClientRect, d,
        TRUE);
    end;
    with dsurface.Canvas do
    begin
      SetBkMode(Handle, TRANSPARENT);
      Font.Color := clwhite;
      TextOut(SurfaceX(Left + 62 - TextWidth(m_PlayDrinkName) div 2),
        SurfaceY(Top + 97), m_PlayDrinkName);
      Release;
    end;
    //m_PlayDrinkMsgTop:='酒意需要品味，生命的动人之处常会在不经意\之间显现。再来些酒，我们在小酌中慢慢体会\吧。';
    //m_PlayDrinkMsgBoom:='小提示：请将包裹栏中的酒放至酒碟上。';
    DMerchantDlgShowText(Sender, dsurface, m_PlayDrinkMsgTop,
      m_PlayDrinkSelectMenuStr, 115, 53, m_PlayDrinkPointsTop,
      m_PlayDrinkAddPointsTop);
    DMerchantDlgShowText(Sender, dsurface, m_PlayDrinkMsgBoom,
      m_PlayDrinkSelectMenuStr, 30, 263, m_PlayDrinkPointsBoom,
      m_PlayDrinkAddPointsBoom);
  end;
end;

procedure TFrmDlg.DDish2DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDButton;
  dd: TDirectDrawSurface;
  Idx: Byte;
begin
  try
    if Sender = DDish1 then
      Idx := 0
    else
      Idx := 1;
    if Sender is TDButton then
    begin
      d := TDButton(Sender);
      dd := d.WLib.Images[d.FaceIndex];
      if dd <> nil then
      begin
        if d.Tag = 1 then
        begin
          DrawBlend(dsurface, d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd, 0);
          if m_PlayDrinkItem[Idx].S.Name <> '' then
          begin
            dd := g_WMain2Images.Images[363];
            if dd <> nil then
            begin
              DrawBlend(dsurface, d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd, 0);
            end;
          end;
        end
        else
        begin
          dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect,
            dd, TRUE);
          if m_PlayDrinkItem[Idx].S.Name <> '' then
          begin
            dd := g_WMain2Images.Images[363];
            if dd <> nil then
            begin
              dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top),
                dd.ClientRect, dd, TRUE);
            end;
          end;
        end;
      end;
    end;
  except
    DebugOutStr('[Exception] TFrmDlg.DDish2DirectPaint');
  end;
end;

procedure TFrmDlg.DDish2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Sender is TDButton then
  begin
    TDButton(Sender).Tag := 1;
  end;
end;

procedure TFrmDlg.DPlayDrinkMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  DDish1.Tag := 0;
  DDish2.Tag := 0;
end;

procedure TFrmDlg.DDish2Click(Sender: TObject; X, Y: Integer);
var
  temp: TClientItem;
  param: string;
  nPic: integer;
  sStr: string;
  Idx: Byte;
begin
  if Sender = DDish1 then
    Idx := 0
  else
    Idx := 1;
  if not g_boItemMoving then
  begin
    if m_PlayDrinkItem[Idx].S.Name <> '' then
    begin
      ItemClickSound(g_MovingItem.Item.S);
      g_boItemMoving := TRUE;
      g_MovingItem.Index := -99; //sell 芒俊辑 唱咳..
      g_MovingItem.Item := m_PlayDrinkItem[Idx];
      g_MovingItem.Hero := False;
      m_PlayDrinkItem[Idx].S.Name := '';
    end;
  end
  else
  begin
    if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then
      exit;
    if g_MovingItem.Hero or (g_MovingItem.Item.S.StdMode <> 60) then
      exit;
    if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then
    begin //啊规,骇飘俊辑 柯巴父
      ItemClickSound(g_MovingItem.Item.S);
      //g_boItemMoving := FALSE;
      if m_PlayDrinkItem[Idx].S.Name <> '' then
      begin //磊府俊 乐栏搁
        temp := m_PlayDrinkItem[Idx];
        m_PlayDrinkItem[Idx] := g_MovingItem.Item;
        g_MovingItem.Index := -99; //sell 芒俊辑 唱咳..
        g_MovingItem.Item := temp;
        g_MovingItem.Hero := False;
      end
      else
      begin
        m_PlayDrinkItem[Idx] := g_MovingItem.Item;
        g_MovingItem.Item.S.name := '';
        g_boItemMoving := FALSE;
      end;
    end;
  end;
end;

procedure TFrmDlg.DPlayDrinkGoBackClick(Sender: TObject; X, Y: Integer);
begin
  CloseDrink;
end;

procedure TFrmDlg.DPlayDrinkDrinkClick(Sender: TObject; X, Y: Integer);
var
  i: integer;
begin
  if m_PlayDrinkItem[0].S.Name = '' then
  begin
    m_PlayDrinkMsgTop :=
      '年轻人，你不是请我喝酒吗？我的酒呢？';
    for i := 0 to FrmDlg.m_PlayDrinkPointsTop.Count - 1 do
      Dispose(pTClickPoint(FrmDlg.m_PlayDrinkPointsTop[i]));
    m_PlayDrinkPointsTop.Clear;
    m_PlayDrinkAddPointsTop := True;
    exit;
  end;
  if m_PlayDrinkItem[1].S.Name = '' then
  begin
    m_PlayDrinkMsgTop :=
      '年轻人，你请我喝酒，怎么自己不喝呢？';
    for I := 0 to m_PlayDrinkPointsTop.Count - 1 do
      Dispose(pTClickPoint(m_PlayDrinkPointsTop[i]));
    m_PlayDrinkPointsTop.Clear;
    m_PlayDrinkAddPointsTop := True;
    exit;
  end;
  DPlayDrinkDrink.Visible := False;
  m_PlayDrinkStartIdx := 0;
  m_PlayDrinkStart := True;
  m_PlayDrinkTime := GetTickCount;
  FrmMain.SendPlayDrink(m_PlayDrinkItem[0].MakeIndex,
    m_PlayDrinkItem[1].MakeIndex);
  m_PlayDrinkItem[0].S.Name := '';
  m_PlayDrinkItem[1].S.Name := '';
end;

procedure TFrmDlg.DPlayDrinkClick(Sender: TObject; X, Y: Integer);
var
  i, L, T: integer;
  p: PTClickPoint;
  TempStr, sName, sUrl: string;
begin
  if GetTickCount < LastestClickTime then
    exit; //努腐阑 磊林 给窍霸 力茄
  L := TDWindow(Sender).Left;
  T := TDWindow(Sender).Top;
  with Sender as TDWindow do
  begin
    for i := 0 to m_PlayDrinkPointsTop.Count - 1 do
    begin
      p := PTClickPoint(m_PlayDrinkPointsTop[i]);
      if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
        (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then
      begin
        PlaySound(s_glass_button_click);
        FrmMain.SendMerchantDlgSelect(m_PlayDrinkNpc, p.RStr);
        LastestClickTime := GetTickCount + 5000; //5檬饶俊 数量 啊瓷
        exit;
      end;
    end;
    for i := 0 to m_PlayDrinkPointsBoom.Count - 1 do
    begin
      p := PTClickPoint(m_PlayDrinkPointsBoom[i]);
      if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
        (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then
      begin
        PlaySound(s_glass_button_click);
        if CompareLStr(p.RStr, '$PlayDrink_Npc', Length('$PlayDrink_Npc')) then
        begin
          FrmMain.SendPlayDrinkSend(m_PlayDrinkNpc, m_CompeteDrinkDrinkIdx, 2);
          exit;
        end
        else if CompareLStr(p.RStr, '$PlayDrink_Self', Length('$PlayDrink_Self'))
          then
        begin
          FrmMain.SendPlayDrinkSend(m_PlayDrinkNpc, m_CompeteDrinkDrinkIdx, 1);
          exit;
        end;
        FrmMain.SendMerchantDlgSelect(m_PlayDrinkNpc, p.RStr);
        LastestClickTime := GetTickCount + 5000; //5檬饶俊 数量 啊瓷
        break;
      end;
    end;
  end;
end;

procedure TFrmDlg.DPlayDrinkMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, L, T: integer;
  p: PTClickPoint;
begin
  if GetTickCount < LastestClickTime then
    exit; //努腐阑 磊林 给窍霸 力茄
  m_PlayDrinkSelectMenuStr := '';
  L := TDWindow(Sender).Left;
  T := TDWindow(Sender).Top;
  with Sender as TDWindow do
  begin
    for i := 0 to m_PlayDrinkPointsTop.Count - 1 do
    begin
      p := PTClickPoint(m_PlayDrinkPointsTop[i]);
      if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
        (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then
      begin
        m_PlayDrinkSelectMenuStr := p.RStr;
        exit;
      end;
    end;
    for i := 0 to m_PlayDrinkPointsBoom.Count - 1 do
    begin
      p := PTClickPoint(m_PlayDrinkPointsBoom[i]);
      if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
        (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then
      begin
        m_PlayDrinkSelectMenuStr := p.RStr;
        break;
      end;
    end;
  end;
end;

procedure TFrmDlg.DPlayDrinkMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  m_PlayDrinkSelectMenuStr := '';
end;

procedure TFrmDlg.DGetHeroDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  with DGetHero do
  begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    if g_GetHero.HeroName1 <> '' then
    begin
      d := WLib.Images[g_JobImage[g_GetHero.HeroJob1 * 2 +
        g_GetHero.HeroGender1]];
      if d <> nil then
      begin
        dsurface.Draw(SurfaceX(Left + 31), SurfaceY(Top + 76), d.ClientRect, d,
          TRUE);
      end;
      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        Font.Color := GetRgb(147);
        TextOut(SurfaceX(Left + 33), SurfaceY(Top + 59), g_GetHero.HeroName1);
        Font.Color := GetRgb(243);
        TextOut(SurfaceX(Left + 70), SurfaceY(Top + 192),
          IntToStr(g_GetHero.HeroLevel1));
        TextOut(SurfaceX(Left + 70), SurfaceY(Top + 208),
          g_JobName[g_GetHero.HeroJob1]);
        Release;
      end;
    end;
    if g_GetHero.HeroName2 <> '' then
    begin
      d := WLib.Images[g_JobImage[g_GetHero.HeroJob2 * 2 +
        g_GetHero.HeroGender2]];
      if d <> nil then
      begin
        dsurface.Draw(SurfaceX(Left + 149), SurfaceY(Top + 76), d.ClientRect, d,
          TRUE);
      end;
      with dsurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        Font.Color := GetRgb(147);
        TextOut(SurfaceX(Left + 151), SurfaceY(Top + 59), g_GetHero.HeroName2);
        Font.Color := GetRgb(243);
        TextOut(SurfaceX(Left + 188), SurfaceY(Top + 192),
          IntToStr(g_GetHero.HeroLevel2));
        TextOut(SurfaceX(Left + 188), SurfaceY(Top + 208),
          g_JobName[g_GetHero.HeroJob2]);
        Release;
      end;
    end;
  end;
end;

procedure TFrmDlg.DGetHeroCloseClick(Sender: TObject; X, Y: Integer);
begin
  DGetHero.Visible := False;
end;

procedure TFrmDlg.DGetHero1Click(Sender: TObject; X, Y: Integer);
begin
  FrmMain.SendGetHero(TDButton(Sender).Tag);
  DGetHero.Visible := False;
end;

procedure TFrmDlg.DCompeteDrinkDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  rc: TRect;
  Count: Integer;
begin
  if g_MySelf = nil then
    exit;
  with DCompeteDrink do
  begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

    if m_CompeteNpcDrink then
    begin
      if m_CompeteDrinkNpcCount >= 200 then
        Count := 13
      else
        Count := 10;
      d := g_WMain2Images.Images[370 + m_CompeteDrinkIdx * 20 +
        m_PlayDrinkStartIdx];
      if (GetTickCount - m_PlayDrinkTime) > 150 then
      begin
        Inc(m_PlayDrinkStartIdx);
        if m_PlayDrinkStartIdx > Count then
        begin
          m_CompeteNpcDrink := False;
          if m_CompeteDrinkNpcCount < 200 then
            m_CompeteDrinkType := pdDD;
        end;
        m_PlayDrinkTime := GetTickCount;
      end;
    end
    else
    begin
      if m_CompeteDrinkNpcCount >= 200 then
        d := g_WMain2Images.Images[370 + m_CompeteDrinkIdx * 20 + 14]
      else
        d := g_WMain2Images.Images[342 + m_CompeteDrinkIdx];
    end;
    if d <> nil then
      dsurface.Draw(SurfaceX(Left + 17), SurfaceY(Top + 20), d.ClientRect, d,
        TRUE);

    if m_CompeteSelfDrink then
    begin
      if m_CompeteDrinkSelfCount >= 200 then
        Count := 13
      else
        Count := 10;
      d := g_WMain2Images.Images[430 + g_MySelf.m_btSex * 20 +
        m_PlayDrinkStartIdx];
      if (GetTickCount - m_PlayDrinkTime) > 150 then
      begin
        Inc(m_PlayDrinkStartIdx);
        if m_PlayDrinkStartIdx > Count then
        begin
          m_CompeteSelfDrink := False;
          if m_CompeteDrinkSelfCount < 200 then
            m_CompeteDrinkType := pdDD;
        end;
        m_PlayDrinkTime := GetTickCount;
      end;
    end
    else
    begin
      if m_CompeteDrinkSelfCount >= 200 then
        d := g_WMain2Images.Images[430 + g_MySelf.m_btSex * 20 + 14]
      else
        d := g_WMain2Images.Images[337 + g_MySelf.m_btSex];
    end;
    if d <> nil then
      dsurface.Draw(SurfaceX(Left + 17), SurfaceY(Top + 249), d.ClientRect, d,
        TRUE);

    d := g_WMain2Images.Images[369];
    if d <> nil then
    begin
      if (GetTickCount - m_CompeteDrinkTempTime) > 10 then
      begin
        if (m_CompeteDrinkTempNpcCount > 0) and (m_CompeteDrinkNpcCount < 220)
          then
        begin
          Inc(m_CompeteDrinkNpcCount);
          Dec(m_CompeteDrinkTempNpcCount);
        end;
        if (m_CompeteDrinkTempSelfCount > 0) and (m_CompeteDrinkSelfCount < 220)
          then
        begin
          Inc(m_CompeteDrinkSelfCount);
          Dec(m_CompeteDrinkTempSelfCount);
        end;
        m_CompeteDrinkTempTime := GetTickCount;
      end;
      rc := d.ClientRect;
      rc.Right := m_CompeteDrinkNpcCount;
      dsurface.Draw(SurfaceX(Left + 111), SurfaceY(Top + 97), rc, d, TRUE);

      rc := d.ClientRect;
      rc.Right := m_CompeteDrinkSelfCount;
      dsurface.Draw(SurfaceX(Left + 111), SurfaceY(Top + 326), rc, d, TRUE);

      rc := d.ClientRect;
      rc.Left := rc.Right - 3;
      dsurface.Draw(SurfaceX(Left + 311), SurfaceY(Top + 97), rc, d, TRUE);
      dsurface.Draw(SurfaceX(Left + 311), SurfaceY(Top + 326), rc, d, TRUE);
    end;

    with dsurface.Canvas do
    begin
      SetBkMode(Handle, TRANSPARENT);
      Font.Color := clwhite;
      TextOut(SurfaceX(Left + 62 - TextWidth(m_CompeteDrinkName) div 2),
        SurfaceY(Top + 96), m_CompeteDrinkName);
      TextOut(SurfaceX(Left + 62 - TextWidth(g_MySelf.m_sUserName) div 2),
        SurfaceY(Top + 325), g_MySelf.m_sUserName);
      Release;
    end;
    DMerchantDlgShowText(Sender, dsurface, m_PlayDrinkMsgTop,
      m_PlayDrinkSelectMenuStr, 115, 44, m_PlayDrinkPointsTop,
      m_PlayDrinkAddPointsTop);
    DMerchantDlgShowText(Sender, dsurface, m_PlayDrinkMsgBoom,
      m_PlayDrinkSelectMenuStr, 115, 270, m_PlayDrinkPointsBoom,
      m_PlayDrinkAddPointsBoom);
  end;
  if (m_CompeteDrinkType = pdNpc) then
  begin
    if (GetTickCount - m_CompeteDrinkNpcSelectMaxTime) > 3500 then
    begin
      m_CompeteDrinkType := pdMsg;
      m_CompeteDrinkDrinkIdx := Random(m_CompeteDrinkIdxList.Count);
      FrmMain.SendPlayDrinkSend(m_PlayDrinkNpc,
        Integer(m_CompeteDrinkIdxList.Items[m_CompeteDrinkDrinkIdx]), 0);
    end;
    if GetTickCount > m_CompeteDrinkNpcSelectTime then
    begin
      if m_CompeteDrinkDrinkIdx = 5 then
        m_CompeteDrinkDrinkIdx := 0
      else
        Inc(m_CompeteDrinkDrinkIdx);
      {case m_CompeteDrinkDrinkIdx of
        0:if DDrink1.Visible then break;
        1:if DDrink2.Visible then break;
        2:if DDrink3.Visible then break;
        3:if DDrink4.Visible then break;
        4:if DDrink5.Visible then break;
        5:if DDrink6.Visible then break;
      end; }
      m_CompeteDrinkNpcSelectTime := GetTickCount + 150;
    end;
  end;
end;

procedure TFrmDlg.DCompeteDrinkBGDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  rc: TRect;
begin
  with DCompeteDrinkBG do
  begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawBlend(dsurface, SurfaceX(Left), SurfaceY(Top), d, 0);
    d := WLib.Images[334 + m_ComPeteWilIdx];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left + 225 - d.Width div 2), SurfaceY(Top + 133),
        d.ClientRect, d, TRUE);

    d := WLib.Images[366 + m_CompeteNpcIdx];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left + 145), SurfaceY(Top + 169), d.ClientRect, d,
        TRUE);

    d := WLib.Images[345 + m_CompeteSelfIdx];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left + 238), SurfaceY(Top + 169), d.ClientRect, d,
        TRUE);
  end;
  if (GetTickCount - m_CompeteButTime) > 1500 then
    DCompeteDrinkBG.Visible := False;
end;

procedure TFrmDlg.DCompeteDrink1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if DDrink1.Tag >= 90 then
    DDrink1.Tag := DDrink1.Tag - 90;
  if DDrink2.Tag >= 90 then
    DDrink2.Tag := DDrink2.Tag - 90;
  if DDrink3.Tag >= 90 then
    DDrink3.Tag := DDrink3.Tag - 90;
  if DDrink4.Tag >= 90 then
    DDrink4.Tag := DDrink4.Tag - 90;
  if DDrink5.Tag >= 90 then
    DDrink5.Tag := DDrink5.Tag - 90;
  if DDrink6.Tag >= 90 then
    DDrink6.Tag := DDrink6.Tag - 90;
  if DCompeteDrink1.Tag >= 90 then
    DCompeteDrink1.Tag := DCompeteDrink1.Tag - 90;
  if DCompeteDrink2.Tag >= 90 then
    DCompeteDrink2.Tag := DCompeteDrink2.Tag - 90;
  if DCompeteDrink3.Tag >= 90 then
    DCompeteDrink3.Tag := DCompeteDrink3.Tag - 90;
  if (Sender is TDButton) and (TDButton(Sender).Tag < 90) and (m_CompeteDrinkType
    = pdSelf) then
    TDButton(Sender).Tag := TDButton(Sender).Tag + 90;
end;

procedure TFrmDlg.DCompeteDrinkMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if DDrink1.Tag >= 90 then
    DDrink1.Tag := DDrink1.Tag - 90;
  if DDrink2.Tag >= 90 then
    DDrink2.Tag := DDrink2.Tag - 90;
  if DDrink3.Tag >= 90 then
    DDrink3.Tag := DDrink3.Tag - 90;
  if DDrink4.Tag >= 90 then
    DDrink4.Tag := DDrink4.Tag - 90;
  if DDrink5.Tag >= 90 then
    DDrink5.Tag := DDrink5.Tag - 90;
  if DDrink6.Tag >= 90 then
    DDrink6.Tag := DDrink6.Tag - 90;
  if DCompeteDrink1.Tag >= 90 then
    DCompeteDrink1.Tag := DCompeteDrink1.Tag - 90;
  if DCompeteDrink2.Tag >= 90 then
    DCompeteDrink2.Tag := DCompeteDrink2.Tag - 90;
  if DCompeteDrink3.Tag >= 90 then
    DCompeteDrink3.Tag := DCompeteDrink3.Tag - 90;
end;

procedure TFrmDlg.DComboBox2Click(Sender: TObject; X, Y: Integer);
begin
g_WgInfo.boAutoHpProtectName:=DComboBox2.Text;
end;

procedure TFrmDlg.DComboBox3Click(Sender: TObject; X, Y: Integer);
var
i:integer;
pm: PTClientMagic;
begin
      For i := 0 To g_MagicList.Count - 1 Do
      begin
        pm:=PTClientMagic(g_MagicList[i]);
        if pm.Def.sMagicName=DComboBox3.Text then
        begin
         g_WgInfo.nAutoMagicIdx:=pm.Def.wMagicID;
         g_WgInfo.sAutoMagicName:=DComboBox3.Text;
         Break
        end;
      end;
end;

procedure TFrmDlg.DCompeteDrink1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDButton;
  dd: TDirectDrawSurface;
begin
  if Sender is TDButton then
  begin
    d := TDButton(Sender);
    if d.Tag >= 90 then
      dd := d.WLib.Images[d.FaceIndex + 1]
    else
      dd := d.WLib.Images[d.FaceIndex];
    if dd <> nil then
    begin
      dsurface.Draw(d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd,
        TRUE);
    end;
    if (d.Tag = m_CompeteDrinkButIdx) or (d.Tag = (m_CompeteDrinkButIdx + 90))
      then
    begin
      dd := d.WLib.Images[361 + Integer(m_CompeteDrinkButCls)];
      if dd <> nil then
        DrawBlend(dsurface, d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd, 1);
    end;
    if (GetTickCount - m_CompeteDrinkButTime) > 200 then
    begin
      m_CompeteDrinkButCls := not m_CompeteDrinkButCls;
      m_CompeteDrinkButTime := GetTickCount;
    end;
  end;
end;

procedure TFrmDlg.DDrink2DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  rc: TRect;
begin
  with Sender as TDButton do
  begin
    if ((m_CompeteDrinkType = pdSelf) and (Tag >= 90)) then
      d := WLib.Images[329]
    else
      d := WLib.Images[FaceIndex];
    if d <> nil then
    begin
      if (m_CompeteDrinkType = pdDD) and (m_CompeteDrinkDrinkIdx = 255) then
      begin
        DrawBlend(dsurface, SurfaceX(Left), SurfaceY(Top), d, 0)
      end
      else
      begin
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
    end;
    if Tag = m_CompeteDrinkDrinkIdx then
    begin
      d := WLib.Images[329];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      //DrawBlend (dsurface,SurfaceX(Left),SurfaceY(Top),d,0)
    end;
  end;
end;

procedure TFrmDlg.DDrunkScaleDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  rc:TRect;
begin
try
  with DDrunkScale do
  begin
  if g_MySelf <> nil then
  begin
    d := g_WMain2Images.Images[511];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    d := g_WMain2Images.Images[583];
    if (d <> nil) and (g_MySelf.m_WineRec.WineValue<>0) then
    begin
      rc := d.ClientRect;
      rc.Right := d.ClientRect.Right - 2;
       rc.Top := Round(rc.Bottom /g_MySelf.m_WineRec.WineValue * (g_MySelf.m_WineRec.WineValue-g_MySelf.m_WineRec.Alcoho));
       dsurface.Draw(SurfaceX(Left), SurfaceY(Top) + rc.Top, rc, d, True);
    end;
  end;
  end;
except

end;
end;

procedure TFrmDlg.DDrunkScaleMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
nt:integer;
begin
try
if g_MySelf<>nil then
begin
     if  g_MySelf.m_WineRec.Alcoho>0 then
        nt:=Round(g_MySelf.m_WineRec.Alcoho / g_MySelf.m_WineRec.WineValue*100)
      else
         nt:=0;
    with DDrunkScale do
       DScreen.ShowHint(SurfaceX(Left), SurfaceY(Top+Height+20),
      '醉酒度'+IntToStr(nt)+'%', clWhite,True)
end;
except

end;
end;

procedure TFrmDlg.DCompeteDrink3Click(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do
  begin
    if m_CompeteDrinkType = pdDD then
    begin
      if Tag >= 90 then
        m_CompeteDrinkButIdx := Tag - 90
      else
        m_CompeteDrinkButIdx := Tag;
      DCompeteDrinkGo.Visible := True;
    end;
  end;
end;

procedure TFrmDlg.DCompeteDrinkGoClick(Sender: TObject; X, Y: Integer);
begin
  if m_CompeteDrinkButIdx in [0..2] then
  begin
    FrmMain.SendPlayDrinkGame(m_PlayDrinkNpc, m_CompeteDrinkButIdx);
    DCompeteDrinkGo.Visible := False;
  end;
end;

procedure TFrmDlg.DDrink1Click(Sender: TObject; X, Y: Integer);
var
  i: integer;
begin
  with Sender as TDButton do
  begin
    if (m_CompeteDrinkType = pdSelf) then
    begin
      if Tag >= 0 then
        Tag := Tag - 90;
      m_CompeteDrinkDrinkIdx := Tag;
      m_PlayDrinkMsgBoom :=
        '呵呵，这回不用选了！<对方/$PlayDrink_Npc> <自己/$PlayDrink_Self>';
      for i := 0 to m_PlayDrinkPointsBoom.Count - 1 do
        Dispose(pTClickPoint(m_PlayDrinkPointsBoom[i]));
      m_PlayDrinkPointsBoom.Clear;
      m_PlayDrinkAddPointsBoom := True;
    end;
  end;
end;

function TFrmDlg.CheckItemStdMode(Sender: TObject;StdMode:Integer):Boolean;
begin
  Result:=True;
  case StdMode of
     60:
      begin
        if Sender<>DBWine  then
            Result:=False;
      end;
     8:
      begin
        if (Sender<>DBMateria) and (Sender<>DBassistMaterial1)
            and  (Sender<>DBassistMaterial2) and (Sender<>DBassistMaterial3) then
            Result:=False;
      end;
     9:
       begin
         if Sender<>DBWater  then
            Result:=False;
       end;
     12:
       begin
          if (Sender<>DBWineCrock) and (Sender<>DBWineBottle) then
            Result:=False;
       end;
     13:
       begin
          if Sender<>DBWineSong then
            Result:=False;
       end;
     14:
       begin
          if Sender<>DBDrug then
            Result:=False;
       end;
    else
    begin
      Result:=False;
    end;   
     end;
end;

end.

