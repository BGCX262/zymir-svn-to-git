//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit FunctionConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Spin, Grids, grobal2, ExtCtrls;

type
  TfrmFunctionConfig = class(TForm)
    FunctionConfigControl: TPageControl;
    MonSaySheet: TTabSheet;
    TabSheet1: TTabSheet;
    PasswordSheet: TTabSheet;
    GroupBox1: TGroupBox;
    CheckBoxEnablePasswordLock: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBoxLockGetBackItem: TCheckBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    EditErrorPasswordCount: TSpinEdit;
    CheckBoxErrorCountKick: TCheckBox;
    ButtonPasswordLockSave: TButton;
    GroupBox4: TGroupBox;
    CheckBoxLockWalk: TCheckBox;
    CheckBoxLockRun: TCheckBox;
    CheckBoxLockHit: TCheckBox;
    CheckBoxLockSpell: TCheckBox;
    CheckBoxLockSendMsg: TCheckBox;
    CheckBoxLockInObMode: TCheckBox;
    CheckBoxLockLogin: TCheckBox;
    CheckBoxLockUseItem: TCheckBox;
    CheckBoxLockDropItem: TCheckBox;
    CheckBoxLockDealItem: TCheckBox;
    MagicPageControl: TPageControl;
    TabSheet11: TTabSheet;
    TabSheetGeneral: TTabSheet;
    GroupBox7: TGroupBox;
    CheckBoxHungerSystem: TCheckBox;
    ButtonGeneralSave: TButton;
    GroupBoxHunger: TGroupBox;
    CheckBoxHungerDecPower: TCheckBox;
    CheckBoxHungerDecHP: TCheckBox;
    ButtonSkillSave: TButton;
    TabSheet32: TTabSheet;
    TabSheet33: TTabSheet;
    TabSheet34: TTabSheet;
    TabSheet35: TTabSheet;
    TabSheet36: TTabSheet;
    GroupBox17: TGroupBox;
    Label12: TLabel;
    EditMagicAttackRage: TSpinEdit;
    GroupBox8: TGroupBox;
    Label13: TLabel;
    EditUpgradeWeaponMaxPoint: TSpinEdit;
    Label15: TLabel;
    EditUpgradeWeaponPrice: TSpinEdit;
    Label16: TLabel;
    EditUPgradeWeaponGetBackTime: TSpinEdit;
    Label17: TLabel;
    EditClearExpireUpgradeWeaponDays: TSpinEdit;
    Label18: TLabel;
    Label19: TLabel;
    GroupBox18: TGroupBox;
    ScrollBarUpgradeWeaponDCRate: TScrollBar;
    Label20: TLabel;
    EditUpgradeWeaponDCRate: TEdit;
    Label21: TLabel;
    ScrollBarUpgradeWeaponDCTwoPointRate: TScrollBar;
    EditUpgradeWeaponDCTwoPointRate: TEdit;
    Label22: TLabel;
    ScrollBarUpgradeWeaponDCThreePointRate: TScrollBar;
    EditUpgradeWeaponDCThreePointRate: TEdit;
    GroupBox19: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    ScrollBarUpgradeWeaponSCRate: TScrollBar;
    EditUpgradeWeaponSCRate: TEdit;
    ScrollBarUpgradeWeaponSCTwoPointRate: TScrollBar;
    EditUpgradeWeaponSCTwoPointRate: TEdit;
    ScrollBarUpgradeWeaponSCThreePointRate: TScrollBar;
    EditUpgradeWeaponSCThreePointRate: TEdit;
    GroupBox20: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    ScrollBarUpgradeWeaponMCRate: TScrollBar;
    EditUpgradeWeaponMCRate: TEdit;
    ScrollBarUpgradeWeaponMCTwoPointRate: TScrollBar;
    EditUpgradeWeaponMCTwoPointRate: TEdit;
    ScrollBarUpgradeWeaponMCThreePointRate: TScrollBar;
    EditUpgradeWeaponMCThreePointRate: TEdit;
    ButtonUpgradeWeaponSave: TButton;
    GroupBox21: TGroupBox;
    ButtonMasterSave: TButton;
    GroupBox22: TGroupBox;
    EditMasterOKLevel: TSpinEdit;
    Label29: TLabel;
    GroupBox23: TGroupBox;
    EditMasterOKCreditPoint: TSpinEdit;
    Label30: TLabel;
    EditMasterOKBonusPoint: TSpinEdit;
    Label31: TLabel;
    GroupBox24: TGroupBox;
    ScrollBarMakeMineHitRate: TScrollBar;
    EditMakeMineHitRate: TEdit;
    Label32: TLabel;
    Label33: TLabel;
    ScrollBarMakeMineRate: TScrollBar;
    EditMakeMineRate: TEdit;
    GroupBox25: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    ScrollBarStoneTypeRate: TScrollBar;
    EditStoneTypeRate: TEdit;
    ScrollBarGoldStoneMax: TScrollBar;
    EditGoldStoneMax: TEdit;
    Label36: TLabel;
    ScrollBarSilverStoneMax: TScrollBar;
    EditSilverStoneMax: TEdit;
    Label37: TLabel;
    ScrollBarSteelStoneMax: TScrollBar;
    EditSteelStoneMax: TEdit;
    Label38: TLabel;
    EditBlackStoneMax: TEdit;
    ScrollBarBlackStoneMax: TScrollBar;
    ButtonMakeMineSave: TButton;
    GroupBox26: TGroupBox;
    Label39: TLabel;
    EditStoneMinDura: TSpinEdit;
    Label40: TLabel;
    EditStoneGeneralDuraRate: TSpinEdit;
    Label41: TLabel;
    EditStoneAddDuraRate: TSpinEdit;
    Label42: TLabel;
    EditStoneAddDuraMax: TSpinEdit;
    TabSheet37: TTabSheet;
    GroupBox27: TGroupBox;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    ScrollBarWinLottery1Max: TScrollBar;
    EditWinLottery1Max: TEdit;
    ScrollBarWinLottery2Max: TScrollBar;
    EditWinLottery2Max: TEdit;
    ScrollBarWinLottery3Max: TScrollBar;
    EditWinLottery3Max: TEdit;
    ScrollBarWinLottery4Max: TScrollBar;
    EditWinLottery4Max: TEdit;
    EditWinLottery5Max: TEdit;
    ScrollBarWinLottery5Max: TScrollBar;
    Label48: TLabel;
    ScrollBarWinLottery6Max: TScrollBar;
    EditWinLottery6Max: TEdit;
    EditWinLotteryRate: TEdit;
    ScrollBarWinLotteryRate: TScrollBar;
    Label49: TLabel;
    GroupBox28: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    EditWinLottery1Gold: TSpinEdit;
    EditWinLottery2Gold: TSpinEdit;
    EditWinLottery3Gold: TSpinEdit;
    EditWinLottery4Gold: TSpinEdit;
    Label54: TLabel;
    EditWinLottery5Gold: TSpinEdit;
    Label55: TLabel;
    EditWinLottery6Gold: TSpinEdit;
    ButtonWinLotterySave: TButton;
    TabSheet38: TTabSheet;
    GroupBox29: TGroupBox;
    Label56: TLabel;
    EditReNewNameColor1: TSpinEdit;
    LabelReNewNameColor1: TLabel;
    Label58: TLabel;
    EditReNewNameColor2: TSpinEdit;
    LabelReNewNameColor2: TLabel;
    Label60: TLabel;
    EditReNewNameColor3: TSpinEdit;
    LabelReNewNameColor3: TLabel;
    Label62: TLabel;
    EditReNewNameColor4: TSpinEdit;
    LabelReNewNameColor4: TLabel;
    Label64: TLabel;
    EditReNewNameColor5: TSpinEdit;
    LabelReNewNameColor5: TLabel;
    Label66: TLabel;
    EditReNewNameColor6: TSpinEdit;
    LabelReNewNameColor6: TLabel;
    Label68: TLabel;
    EditReNewNameColor7: TSpinEdit;
    LabelReNewNameColor7: TLabel;
    Label70: TLabel;
    EditReNewNameColor8: TSpinEdit;
    LabelReNewNameColor8: TLabel;
    Label72: TLabel;
    EditReNewNameColor9: TSpinEdit;
    LabelReNewNameColor9: TLabel;
    Label74: TLabel;
    EditReNewNameColor10: TSpinEdit;
    LabelReNewNameColor10: TLabel;
    ButtonReNewLevelSave: TButton;
    GroupBox30: TGroupBox;
    Label57: TLabel;
    EditReNewNameColorTime: TSpinEdit;
    Label59: TLabel;
    TabSheet39: TTabSheet;
    ButtonMonUpgradeSave: TButton;
    GroupBox32: TGroupBox;
    Label65: TLabel;
    LabelMonUpgradeColor1: TLabel;
    Label67: TLabel;
    LabelMonUpgradeColor2: TLabel;
    Label69: TLabel;
    LabelMonUpgradeColor3: TLabel;
    Label71: TLabel;
    LabelMonUpgradeColor4: TLabel;
    Label73: TLabel;
    LabelMonUpgradeColor5: TLabel;
    Label75: TLabel;
    LabelMonUpgradeColor6: TLabel;
    Label76: TLabel;
    LabelMonUpgradeColor7: TLabel;
    Label77: TLabel;
    LabelMonUpgradeColor8: TLabel;
    EditMonUpgradeColor1: TSpinEdit;
    EditMonUpgradeColor2: TSpinEdit;
    EditMonUpgradeColor3: TSpinEdit;
    EditMonUpgradeColor4: TSpinEdit;
    EditMonUpgradeColor5: TSpinEdit;
    EditMonUpgradeColor6: TSpinEdit;
    EditMonUpgradeColor7: TSpinEdit;
    EditMonUpgradeColor8: TSpinEdit;
    GroupBox31: TGroupBox;
    Label61: TLabel;
    Label63: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    EditMonUpgradeKillCount1: TSpinEdit;
    EditMonUpgradeKillCount2: TSpinEdit;
    EditMonUpgradeKillCount3: TSpinEdit;
    EditMonUpgradeKillCount4: TSpinEdit;
    EditMonUpgradeKillCount5: TSpinEdit;
    EditMonUpgradeKillCount6: TSpinEdit;
    EditMonUpgradeKillCount7: TSpinEdit;
    EditMonUpLvNeedKillBase: TSpinEdit;
    EditMonUpLvRate: TSpinEdit;
    Label84: TLabel;
    CheckBoxReNewChangeColor: TCheckBox;
    GroupBox33: TGroupBox;
    CheckBoxReNewLevelClearExp: TCheckBox;
    GroupBox34: TGroupBox;
    Label85: TLabel;
    EditPKFlagNameColor: TSpinEdit;
    LabelPKFlagNameColor: TLabel;
    Label87: TLabel;
    EditPKLevel1NameColor: TSpinEdit;
    LabelPKLevel1NameColor: TLabel;
    Label89: TLabel;
    EditPKLevel2NameColor: TSpinEdit;
    LabelPKLevel2NameColor: TLabel;
    Label91: TLabel;
    EditAllyAndGuildNameColor: TSpinEdit;
    LabelAllyAndGuildNameColor: TLabel;
    Label93: TLabel;
    EditWarGuildNameColor: TSpinEdit;
    LabelWarGuildNameColor: TLabel;
    Label95: TLabel;
    EditInFreePKAreaNameColor: TSpinEdit;
    LabelInFreePKAreaNameColor: TLabel;
    TabSheet40: TTabSheet;
    Label86: TLabel;
    EditMonUpgradeColor9: TSpinEdit;
    LabelMonUpgradeColor9: TLabel;
    GroupBox35: TGroupBox;
    CheckBoxMasterDieMutiny: TCheckBox;
    Label88: TLabel;
    EditMasterDieMutinyRate: TSpinEdit;
    Label90: TLabel;
    EditMasterDieMutinyPower: TSpinEdit;
    Label92: TLabel;
    EditMasterDieMutinySpeed: TSpinEdit;
    GroupBox36: TGroupBox;
    Label94: TLabel;
    Label96: TLabel;
    CheckBoxSpiritMutiny: TCheckBox;
    EditSpiritMutinyTime: TSpinEdit;
    EditSpiritPowerRate: TSpinEdit;
    ButtonSpiritMutinySave: TButton;
    GroupBox40: TGroupBox;
    CheckBoxMonSayMsg: TCheckBox;
    ButtonMonSayMsgSave: TButton;
    ButtonUpgradeWeaponDefaulf: TButton;
    ButtonMakeMineDefault: TButton;
    ButtonWinLotteryDefault: TButton;
    TabSheet42: TTabSheet;
    GroupBox44: TGroupBox;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    ScrollBarWeaponMakeUnLuckRate: TScrollBar;
    EditWeaponMakeUnLuckRate: TEdit;
    ScrollBarWeaponMakeLuckPoint1: TScrollBar;
    EditWeaponMakeLuckPoint1: TEdit;
    ScrollBarWeaponMakeLuckPoint2: TScrollBar;
    EditWeaponMakeLuckPoint2: TEdit;
    ScrollBarWeaponMakeLuckPoint2Rate: TScrollBar;
    EditWeaponMakeLuckPoint2Rate: TEdit;
    EditWeaponMakeLuckPoint3: TEdit;
    ScrollBarWeaponMakeLuckPoint3: TScrollBar;
    Label110: TLabel;
    ScrollBarWeaponMakeLuckPoint3Rate: TScrollBar;
    EditWeaponMakeLuckPoint3Rate: TEdit;
    ButtonWeaponMakeLuckDefault: TButton;
    ButtonWeaponMakeLuckSave: TButton;
    GroupBox47: TGroupBox;
    Label112: TLabel;
    CheckBoxBBMonAutoChangeColor: TCheckBox;
    EditBBMonAutoChangeColorTime: TSpinEdit;
    Label14: TLabel;
    TabSheet2: TTabSheet;
    GroupBox49: TGroupBox;
    CheckBoxHeroPickUp: TCheckBox;
    CheckBoxHeroAutoToxin: TCheckBox;
    CheckBoxAddWeaponPace: TCheckBox;
    CheckBoxHeroKillAddPK: TCheckBox;
    CheckBox5: TCheckBox;
    GroupBox50: TGroupBox;
    GroupBox51: TGroupBox;
    Label113: TLabel;
    SpinEditHeroCallTime: TSpinEdit;
    SpinEditHeroExp: TSpinEdit;
    Label114: TLabel;
    Label115: TLabel;
    SpinEditWarrAkTime: TSpinEdit;
    Label116: TLabel;
    Label117: TLabel;
    SpinEditWizardAkTime: TSpinEdit;
    Label118: TLabel;
    Label119: TLabel;
    SpinEditTaosAkTime: TSpinEdit;
    Label120: TLabel;
    GroupBox52: TGroupBox;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    SpinEditWarrWalkTime: TSpinEdit;
    SpinEditWizardWalkTime: TSpinEdit;
    SpinEditTaosWalkTime: TSpinEdit;
    Label127: TLabel;
    SpinEditBlazeTickTime: TSpinEdit;
    Label128: TLabel;
    CheckBoxBump: TCheckBox;
    GroupBox53: TGroupBox;
    RadioButtonAttack: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    GroupBox54: TGroupBox;
    CheckBoxHeroShowName: TCheckBox;
    Label129: TLabel;
    EditHeroName: TEdit;
    EditHeroName2: TEdit;
    Label130: TLabel;
    Label131: TLabel;
    LabeltHeroNameColor: TLabel;
    EditHeroNameColor: TSpinEdit;
    ButtonHeroSave: TButton;
    TabSheet5: TTabSheet;
    PageControl1: TPageControl;
    TabSheet7: TTabSheet;
    GroupBox55: TGroupBox;
    CheckBoxAllowJointAttack: TCheckBox;
    GroupBox56: TGroupBox;
    SpinEditEnergyStepUpRate: TSpinEdit;
    Label132: TLabel;
    Label133: TLabel;
    TabSheet8: TTabSheet;
    GroupBox57: TGroupBox;
    Label135: TLabel;
    SpinEditSkillWWPowerRate: TSpinEdit;
    Label136: TLabel;
    TabSheet9: TTabSheet;
    GroupBox58: TGroupBox;
    Label137: TLabel;
    Label138: TLabel;
    SpinEditSkillTWPowerRate: TSpinEdit;
    TabSheet10: TTabSheet;
    GroupBox59: TGroupBox;
    Label139: TLabel;
    Label140: TLabel;
    SpinEditSkillZWPowerRate: TSpinEdit;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    GroupBox60: TGroupBox;
    Label141: TLabel;
    Label142: TLabel;
    SpinEditSkillTTPowerRate: TSpinEdit;
    GroupBox61: TGroupBox;
    Label143: TLabel;
    Label144: TLabel;
    SpinEditSkillZTPowerRate: TSpinEdit;
    TabSheet14: TTabSheet;
    GroupBox62: TGroupBox;
    Label145: TLabel;
    Label146: TLabel;
    SpinEditSkillZZPowerRate: TSpinEdit;
    GroupBox63: TGroupBox;
    SpinEditHPStoneStartRate: TSpinEdit;
    Label147: TLabel;
    Label148: TLabel;
    SpinEditHPStoneIntervalTime: TSpinEdit;
    Label149: TLabel;
    Label150: TLabel;
    SpinEditHPStoneAddRate: TSpinEdit;
    Label151: TLabel;
    Label152: TLabel;
    SpinEditMPStoneStartRate: TSpinEdit;
    Label153: TLabel;
    SpinEditMPStoneIntervalTime: TSpinEdit;
    Label154: TLabel;
    Label155: TLabel;
    SpinEditMPStoneAddRate: TSpinEdit;
    Label156: TLabel;
    Label157: TLabel;
    SpinEditHPStoneDecDura: TSpinEdit;
    Label158: TLabel;
    Label159: TLabel;
    SpinEditMPStoneDecDura: TSpinEdit;
    Label160: TLabel;
    GroupBox64: TGroupBox;
    CheckBoxCloseShowHp: TCheckBox;
    GroupBox65: TGroupBox;
    CheckBoxMonShowLevel: TCheckBox;
    EditMonLevelMsg: TEdit;
    Label134: TLabel;
    PageControl2: TPageControl;
    TabSheet17: TTabSheet;
    GroupBox10: TGroupBox;
    Label4: TLabel;
    Label10: TLabel;
    EditSwordLongPowerRate: TSpinEdit;
    GroupBox9: TGroupBox;
    CheckBoxLimitSwordLong: TCheckBox;
    TabSheet19: TTabSheet;
    GroupBox45: TGroupBox;
    Label111: TLabel;
    EditTammingCount: TSpinEdit;
    GroupBox38: TGroupBox;
    Label98: TLabel;
    EditMagTammingLevel: TSpinEdit;
    GroupBox39: TGroupBox;
    Label99: TLabel;
    Label100: TLabel;
    EditMagTammingTargetLevel: TSpinEdit;
    EditMagTammingHPRate: TSpinEdit;
    TabSheet18: TTabSheet;
    GroupBox46: TGroupBox;
    CheckBoxFireCrossInSafeZone: TCheckBox;
    TabSheet20: TTabSheet;
    GroupBox37: TGroupBox;
    Label97: TLabel;
    EditMagTurnUndeadLevel: TSpinEdit;
    TabSheet23: TTabSheet;
    GroupBox15: TGroupBox;
    Label9: TLabel;
    EditElecBlizzardRange: TSpinEdit;
    TabSheet22: TTabSheet;
    GroupBox13: TGroupBox;
    Label7: TLabel;
    EditFireBoomRage: TSpinEdit;
    TabSheet21: TTabSheet;
    GroupBox14: TGroupBox;
    Label8: TLabel;
    EditSnowWindRange: TSpinEdit;
    TabSheet24: TTabSheet;
    GroupBox16: TGroupBox;
    Label11: TLabel;
    EditAmyOunsulPoint: TSpinEdit;
    TabSheet6: TTabSheet;
    GroupBox6: TGroupBox;
    GridBoneFamm: TStringGrid;
    GroupBox5: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EditBoneFammName: TEdit;
    EditBoneFammCount: TSpinEdit;
    TabSheet3: TTabSheet;
    GroupBox12: TGroupBox;
    GridDogz: TStringGrid;
    GroupBox11: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    EditDogzName: TEdit;
    EditDogzCount: TSpinEdit;
    TabSheet4: TTabSheet;
    GroupBox41: TGroupBox;
    Label101: TLabel;
    Label102: TLabel;
    EditMabMabeHitRandRate: TSpinEdit;
    EditMabMabeHitMinLvLimit: TSpinEdit;
    GroupBox43: TGroupBox;
    Label104: TLabel;
    EditMabMabeHitMabeTimeRate: TSpinEdit;
    GroupBox42: TGroupBox;
    Label103: TLabel;
    EditMabMabeHitSucessRate: TSpinEdit;
    TabSheet25: TTabSheet;
    GroupBox48: TGroupBox;
    CheckBoxGroupMbAttackPlayObject: TCheckBox;
    CheckBoxGroupMbAttackMonObject: TCheckBox;
    CheckBoxGroupMbAttackHeroObject: TCheckBox;
    TabSheet15: TTabSheet;
    GroupBox66: TGroupBox;
    CheckBoxFastenAttackPlayObject: TCheckBox;
    CheckBoxFastenAttackSlaveObject: TCheckBox;
    CheckBoxFastenAttackHeroObject: TCheckBox;
    CheckBoxInfinityStorage: TCheckBox;
    TabSheet16: TTabSheet;
    GroupBox67: TGroupBox;
    GridFairy: TStringGrid;
    GroupBox68: TGroupBox;
    Label161: TLabel;
    Label162: TLabel;
    EditFairyName: TEdit;
    EditFairyCount: TSpinEdit;
    EditFairyDuntRate: TSpinEdit;
    Label163: TLabel;
    Label164: TLabel;
    Label165: TLabel;
    EditFairyAttackRate: TSpinEdit;
    Label166: TLabel;
    EditInfinityStorage: TSpinEdit;
    TabSheet26: TTabSheet;
    GroupBox69: TGroupBox;
    Label167: TLabel;
    EditMagicDeDingTime: TSpinEdit;
    Label168: TLabel;
    TabSheet27: TTabSheet;
    TabSheet28: TTabSheet;
    GroupBox70: TGroupBox;
    Label169: TLabel;
    Label170: TLabel;
    EditFireHitSkillTime: TSpinEdit;
    GroupBox72: TGroupBox;
    Label173: TLabel;
    EditTwinHitSkillRange: TSpinEdit;
    TabSheet29: TTabSheet;
    TabSheet30: TTabSheet;
    GroupBox73: TGroupBox;
    Label174: TLabel;
    Label175: TLabel;
    EditLongSwordTime: TSpinEdit;
    GroupBox74: TGroupBox;
    Label176: TLabel;
    EditLongSwordRate: TSpinEdit;
    Label177: TLabel;
    CheckBoxOfflineSaveExp: TCheckBox;
    GroupBox75: TGroupBox;
    CheckBoxOpenSelfShop: TCheckBox;
    CheckBoxSafeZoneShop: TCheckBox;
    CheckBoxMapShop: TCheckBox;
    GroupBox76: TGroupBox;
    Label178: TLabel;
    EditSellOffGoldTaxRate: TSpinEdit;
    Label179: TLabel;
    Label180: TLabel;
    EditSellOffGameGoldTaxRate: TSpinEdit;
    Label181: TLabel;
    ButtonSaveSellOff: TButton;
    GroupBox77: TGroupBox;
    Label182: TLabel;
    EditPlayCloneName: TEdit;
    CheckBoxCloneShowMaster: TCheckBox;
    TabSheet31: TTabSheet;
    GroupBox78: TGroupBox;
    Label183: TLabel;
    EditUenhancerTime: TSpinEdit;
    GroupBox79: TGroupBox;
    Label185: TLabel;
    EditUenhancerRate: TSpinEdit;
    Label186: TLabel;
    GroupBox80: TGroupBox;
    Label184: TLabel;
    EditPlayCloneTime: TSpinEdit;
    Label187: TLabel;
    GroupBox81: TGroupBox;
    Label188: TLabel;
    EditSellOffItemCount: TSpinEdit;
    Label189: TLabel;
    EditCallCloneTime: TSpinEdit;
    Label190: TLabel;
    CheckBoxChangeMapCloseFire: TCheckBox;
    CheckBoxPlayDethCloseFire: TCheckBox;
    CheckBoxPlayGhostCloseFire: TCheckBox;
    GroupBox82: TGroupBox;
    Label191: TLabel;
    Label192: TLabel;
    EditFireCrossMaxTime: TSpinEdit;
    GroupBox83: TGroupBox;
    Label193: TLabel;
    Label194: TLabel;
    EditTwinHitMaxCount: TSpinEdit;
    EditTwinHitCount: TSpinEdit;
    TabSheet41: TTabSheet;
    GroupBox71: TGroupBox;
    Label171: TLabel;
    Label172: TLabel;
    EditShieldTime: TSpinEdit;
    GroupBox84: TGroupBox;
    RadioShieldDrok: TRadioButton;
    RadioShieldEgg: TRadioButton;
    GroupBox85: TGroupBox;
    EditShieldAttackRate: TSpinEdit;
    Label195: TLabel;
    Label196: TLabel;
    GroupBox86: TGroupBox;
    Label197: TLabel;
    EditShieldSmashRate: TSpinEdit;
    Label199: TLabel;
    EditShieldTick: TSpinEdit;
    Label200: TLabel;
    GroupBox87: TGroupBox;
    CheckBoxShieldErgum: TCheckBox;
    CheckBoxShieldYEDO: TCheckBox;
    CheckBoxShieldFire: TCheckBox;
    CheckBoxCheckBoxShieldLong: TCheckBox;
    GroupBox88: TGroupBox;
    Label198: TLabel;
    Label201: TLabel;
    Label202: TLabel;
    EditHeroFealtyCallAdd: TSpinEdit;
    EditHeroFealtyExp: TSpinEdit;
    EditHeroFealtyExpAdd: TSpinEdit;
    EditHeroFealtyCallDel: TSpinEdit;
    Label203: TLabel;
    Label204: TLabel;
    EditHeroFealtyDeathDel: TSpinEdit;
    EditHeroFourMagic: TSpinEdit;
    Label205: TLabel;
    Label206: TLabel;
    GroupBox89: TGroupBox;
    CheckBoxCloneMakeSlave: TCheckBox;
    TabSheet46: TTabSheet;
    PageControl3: TPageControl;
    TabSheet44: TTabSheet;
    TabSheet47: TTabSheet;
    TabSheet43: TTabSheet;
    GroupBox90: TGroupBox;
    Label207: TLabel;
    Label208: TLabel;
    seLongFireHitSkillTime: TSpinEdit;
    GroupBox92: TGroupBox;
    Label211: TLabel;
    Label212: TLabel;
    seEditVampirePower: TSpinEdit;
    GroupBox91: TGroupBox;
    Label209: TLabel;
    Label210: TLabel;
    seEditLongFireHitPower: TSpinEdit;
    GroupBox93: TGroupBox;
    Label213: TLabel;
    Label214: TLabel;
    seEditMeteorRainPower: TSpinEdit;
    GroupBox94: TGroupBox;
    Label215: TLabel;
    seEditVampireHpRate: TSpinEdit;
    RadioShieldNil: TRadioButton;
    GroupBox95: TGroupBox;
    CheckBoxAutoOpenShield: TCheckBox;
    TabSheet45: TTabSheet;
    GroupBox96: TGroupBox;
    CheckBoxPlayObjectReduceMP: TCheckBox;
    CheckBoxShieldShowEffect: TCheckBox;
    GroupBox97: TGroupBox;
    Label216: TLabel;
    Label217: TLabel;
    seMeteorRainTime: TSpinEdit;
    CheckBox1: TCheckBox;
    grp1: TGroupBox;
    Label218: TLabel;
    seEditAttackPower: TSpinEdit;
    Label219: TLabel;
    TabSheet48: TTabSheet;
    GroupBox98: TGroupBox;
    Label220: TLabel;
    Label221: TLabel;
    sEditSkill82Time: TSpinEdit;
    GroupBox99: TGroupBox;
    Label222: TLabel;
    sEditskill82Rate: TSpinEdit;
    ts1: TTabSheet;
    PageControl4: TPageControl;
    ts2: TTabSheet;
    TabSheet49: TTabSheet;
    btnSaveMakeWine: TButton;
    GroupBox104: TGroupBox;
    GridMedicineExp: TStringGrid;
    GroupBox105: TGroupBox;
    GridSkill84Exp: TStringGrid;
    TabSheet50: TTabSheet;
    GroupBox106: TGroupBox;
    Label239: TLabel;
    seMinDrinkValue83: TSpinEdit;
    Label240: TLabel;
    GroupBox107: TGroupBox;
    GroupBox109: TGroupBox;
    Label243: TLabel;
    Label244: TLabel;
    seHPUpUseTime: TSpinEdit;
    Label245: TLabel;
    seMinDrinkValue84: TSpinEdit;
    Label246: TLabel;
    PageControl5: TPageControl;
    ts3: TTabSheet;
    ts4: TTabSheet;
    grp2: TGroupBox;
    lbl1: TLabel;
    Label223: TLabel;
    Label226: TLabel;
    Label227: TLabel;
    seMakeWineTime: TSpinEdit;
    seMakeWineTime1: TSpinEdit;
    GroupBox100: TGroupBox;
    Label224: TLabel;
    Label228: TLabel;
    SEdtMakeWineRate: TSpinEdit;
    GroupBox101: TGroupBox;
    lbl2: TLabel;
    Label225: TLabel;
    Label229: TLabel;
    seDesMedicineValue: TSpinEdit;
    seDesMedicineTick: TSpinEdit;
    GroupBox103: TGroupBox;
    Label236: TLabel;
    Label237: TLabel;
    Label238: TLabel;
    seInFountainTime: TSpinEdit;
    seDecGuildFountain: TSpinEdit;
    GroupBox111: TGroupBox;
    Label249: TLabel;
    Label251: TLabel;
    Label254: TLabel;
    SEDRUNKTick: TSpinEdit;
    seHighDRUNKTick: TSpinEdit;
    GroupBox110: TGroupBox;
    Label247: TLabel;
    Label248: TLabel;
    Label235: TLabel;
    Label234: TLabel;
    Label232: TLabel;
    Label233: TLabel;
    Label231: TLabel;
    Label230: TLabel;
    seDecMaxAlcoholTime: TSpinEdit;
    seIncAlcoholValue: TSpinEdit;
    seMaxAlcoholValue: TSpinEdit;
    seDesDrinkTick: TSpinEdit;
    seIncAlcoholTick: TSpinEdit;
    GroupBox108: TGroupBox;
    Label241: TLabel;
    Label242: TLabel;
    Label250: TLabel;
    Label253: TLabel;
    Label252: TLabel;
    lbl3: TLabel;
    sewinequality: TSpinEdit;
    seTempAbil: TSpinEdit;
    SeSpeedupAlcoholTick: TSpinEdit;
    seGettempAbilRate: TSpinEdit;
    Label255: TLabel;
    Label256: TLabel;
    seHighAlcoholTick: TSpinEdit;
    Label258: TLabel;
    selowDRUNKTick: TSpinEdit;
    Label259: TLabel;
    Label260: TLabel;
    selowAlcoholTick: TSpinEdit;
    Label262: TLabel;
    seRUNKValue: TSpinEdit;
    Label263: TLabel;
    Label257: TLabel;
    Label261: TLabel;
    seskill84MaxLevel: TSpinEdit;
    Label264: TLabel;
    seClearHeroGhostTick: TSpinEdit;
    Label265: TLabel;
    seDecAlcoholValue: TSpinEdit;
    GroupBox102: TGroupBox;
    Label266: TLabel;
    SeMakeMedicineWineMinQuality: TSpinEdit;
    GridSkill83Abil: TStringGrid;
    Label267: TLabel;
    Seskill84HPUpTick: TSpinEdit;
    Label268: TLabel;
    SeMedicineIncAbil: TSpinEdit;
    TabSheet51: TTabSheet;
    GroupBox112: TGroupBox;
    Label269: TLabel;
    Label270: TLabel;
    SeSkill57DecDamage: TSpinEdit;
    ts5: TTabSheet;
    Label271: TLabel;
    SeChallengeTime: TSpinEdit;
    Label272: TLabel;
    RadioGroup1: TRadioGroup;
    btnChallengeSave: TButton;
    procedure CheckBoxEnablePasswordLockClick(Sender: TObject);
    procedure CheckBoxLockGetBackItemClick(Sender: TObject);
    procedure CheckBoxLockDealItemClick(Sender: TObject);
    procedure CheckBoxLockDropItemClick(Sender: TObject);
    procedure CheckBoxLockWalkClick(Sender: TObject);
    procedure CheckBoxLockRunClick(Sender: TObject);
    procedure CheckBoxLockHitClick(Sender: TObject);
    procedure CheckBoxLockSpellClick(Sender: TObject);
    procedure CheckBoxLockSendMsgClick(Sender: TObject);
    procedure CheckBoxLockInObModeClick(Sender: TObject);
    procedure EditErrorPasswordCountChange(Sender: TObject);
    procedure ButtonPasswordLockSaveClick(Sender: TObject);
    procedure CheckBoxErrorCountKickClick(Sender: TObject);
    procedure CheckBoxLockLoginClick(Sender: TObject);
    procedure CheckBoxLockUseItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxHungerSystemClick(Sender: TObject);
    procedure CheckBoxHungerDecHPClick(Sender: TObject);
    procedure CheckBoxHungerDecPowerClick(Sender: TObject);
    procedure ButtonGeneralSaveClick(Sender: TObject);
    procedure CheckBoxLimitSwordLongClick(Sender: TObject);
    procedure ButtonSkillSaveClick(Sender: TObject);
    procedure EditBoneFammNameChange(Sender: TObject);
    procedure EditBoneFammCountChange(Sender: TObject);
    procedure EditSwordLongPowerRateChange(Sender: TObject);
    procedure EditFireBoomRageChange(Sender: TObject);
    procedure EditSnowWindRangeChange(Sender: TObject);
    procedure EditElecBlizzardRangeChange(Sender: TObject);
    procedure EditDogzCountChange(Sender: TObject);
    procedure EditDogzNameChange(Sender: TObject);
    procedure GridBoneFammSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure EditAmyOunsulPointChange(Sender: TObject);
    procedure EditMagicAttackRageChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponDCRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponDCTwoPointRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponDCThreePointRateChange(
      Sender: TObject);
    procedure ScrollBarUpgradeWeaponSCRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponSCTwoPointRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponSCThreePointRateChange(
      Sender: TObject);
    procedure ScrollBarUpgradeWeaponMCRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponMCTwoPointRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponMCThreePointRateChange(
      Sender: TObject);
    procedure EditUpgradeWeaponMaxPointChange(Sender: TObject);
    procedure EditUpgradeWeaponPriceChange(Sender: TObject);
    procedure EditUPgradeWeaponGetBackTimeChange(Sender: TObject);
    procedure EditClearExpireUpgradeWeaponDaysChange(Sender: TObject);
    procedure ButtonUpgradeWeaponSaveClick(Sender: TObject);
    procedure EditMasterOKLevelChange(Sender: TObject);
    procedure ButtonMasterSaveClick(Sender: TObject);
    procedure EditMasterOKCreditPointChange(Sender: TObject);
    procedure EditMasterOKBonusPointChange(Sender: TObject);
    procedure ScrollBarMakeMineHitRateChange(Sender: TObject);
    procedure ScrollBarMakeMineRateChange(Sender: TObject);
    procedure ScrollBarStoneTypeRateChange(Sender: TObject);
    procedure ScrollBarGoldStoneMaxChange(Sender: TObject);
    procedure ScrollBarSilverStoneMaxChange(Sender: TObject);
    procedure ScrollBarSteelStoneMaxChange(Sender: TObject);
    procedure ScrollBarBlackStoneMaxChange(Sender: TObject);
    procedure ButtonMakeMineSaveClick(Sender: TObject);
    procedure EditStoneMinDuraChange(Sender: TObject);
    procedure EditStoneGeneralDuraRateChange(Sender: TObject);
    procedure EditStoneAddDuraRateChange(Sender: TObject);
    procedure EditStoneAddDuraMaxChange(Sender: TObject);
    procedure ButtonWinLotterySaveClick(Sender: TObject);
    procedure EditWinLottery1GoldChange(Sender: TObject);
    procedure EditWinLottery2GoldChange(Sender: TObject);
    procedure EditWinLottery3GoldChange(Sender: TObject);
    procedure EditWinLottery4GoldChange(Sender: TObject);
    procedure EditWinLottery5GoldChange(Sender: TObject);
    procedure EditWinLottery6GoldChange(Sender: TObject);
    procedure ScrollBarWinLottery1MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery2MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery3MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery4MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery5MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery6MaxChange(Sender: TObject);
    procedure ScrollBarWinLotteryRateChange(Sender: TObject);
    procedure ButtonReNewLevelSaveClick(Sender: TObject);
    procedure EditReNewNameColor1Change(Sender: TObject);
    procedure EditReNewNameColor2Change(Sender: TObject);
    procedure EditReNewNameColor3Change(Sender: TObject);
    procedure EditReNewNameColor4Change(Sender: TObject);
    procedure EditReNewNameColor5Change(Sender: TObject);
    procedure EditReNewNameColor6Change(Sender: TObject);
    procedure EditReNewNameColor7Change(Sender: TObject);
    procedure EditReNewNameColor8Change(Sender: TObject);
    procedure EditReNewNameColor9Change(Sender: TObject);
    procedure EditReNewNameColor10Change(Sender: TObject);
    procedure EditReNewNameColorTimeChange(Sender: TObject);
    procedure FunctionConfigControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure ButtonMonUpgradeSaveClick(Sender: TObject);
    procedure EditMonUpgradeColor1Change(Sender: TObject);
    procedure EditMonUpgradeColor2Change(Sender: TObject);
    procedure EditMonUpgradeColor3Change(Sender: TObject);
    procedure EditMonUpgradeColor4Change(Sender: TObject);
    procedure EditMonUpgradeColor5Change(Sender: TObject);
    procedure EditMonUpgradeColor6Change(Sender: TObject);
    procedure EditMonUpgradeColor7Change(Sender: TObject);
    procedure EditMonUpgradeColor8Change(Sender: TObject);
    procedure EditMonUpgradeColor9Change(Sender: TObject);
    procedure CheckBoxReNewChangeColorClick(Sender: TObject);
    procedure CheckBoxReNewLevelClearExpClick(Sender: TObject);
    procedure EditPKFlagNameColorChange(Sender: TObject);
    procedure EditPKLevel1NameColorChange(Sender: TObject);
    procedure EditPKLevel2NameColorChange(Sender: TObject);
    procedure EditAllyAndGuildNameColorChange(Sender: TObject);
    procedure EditWarGuildNameColorChange(Sender: TObject);
    procedure EditInFreePKAreaNameColorChange(Sender: TObject);
    procedure EditMonUpgradeKillCount1Change(Sender: TObject);
    procedure EditMonUpgradeKillCount2Change(Sender: TObject);
    procedure EditMonUpgradeKillCount3Change(Sender: TObject);
    procedure EditMonUpgradeKillCount4Change(Sender: TObject);
    procedure EditMonUpgradeKillCount5Change(Sender: TObject);
    procedure EditMonUpgradeKillCount6Change(Sender: TObject);
    procedure EditMonUpgradeKillCount7Change(Sender: TObject);
    procedure EditMonUpLvNeedKillBaseChange(Sender: TObject);
    procedure EditMonUpLvRateChange(Sender: TObject);
    procedure CheckBoxMasterDieMutinyClick(Sender: TObject);
    procedure EditMasterDieMutinyRateChange(Sender: TObject);
    procedure EditMasterDieMutinyPowerChange(Sender: TObject);
    procedure EditMasterDieMutinySpeedChange(Sender: TObject);
    procedure ButtonSpiritMutinySaveClick(Sender: TObject);
    procedure CheckBoxSpiritMutinyClick(Sender: TObject);
    procedure EditSpiritMutinyTimeChange(Sender: TObject);
    procedure EditSpiritPowerRateChange(Sender: TObject);
    procedure EditMagTurnUndeadLevelChange(Sender: TObject);
    procedure EditMagTammingLevelChange(Sender: TObject);
    procedure EditMagTammingTargetLevelChange(Sender: TObject);
    procedure EditMagTammingHPRateChange(Sender: TObject);
    procedure ButtonMonSayMsgSaveClick(Sender: TObject);
    procedure CheckBoxMonSayMsgClick(Sender: TObject);
    procedure ButtonUpgradeWeaponDefaulfClick(Sender: TObject);
    procedure ButtonMakeMineDefaultClick(Sender: TObject);
    procedure ButtonWinLotteryDefaultClick(Sender: TObject);
    procedure EditMabMabeHitRandRateChange(Sender: TObject);
    procedure EditMabMabeHitMinLvLimitChange(Sender: TObject);
    procedure EditMabMabeHitSucessRateChange(Sender: TObject);
    procedure EditMabMabeHitMabeTimeRateChange(Sender: TObject);
    procedure ButtonWeaponMakeLuckDefaultClick(Sender: TObject);
    procedure ButtonWeaponMakeLuckSaveClick(Sender: TObject);
    procedure ScrollBarWeaponMakeUnLuckRateChange(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint1Change(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint2Change(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint2RateChange(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint3Change(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint3RateChange(Sender: TObject);
    procedure EditTammingCountChange(Sender: TObject);
    procedure CheckBoxFireCrossInSafeZoneClick(Sender: TObject);
    procedure CheckBoxBBMonAutoChangeColorClick(Sender: TObject);
    procedure EditBBMonAutoChangeColorTimeChange(Sender: TObject);
    procedure CheckBoxGroupMbAttackPlayObjectClick(Sender: TObject);
    procedure EditHeroNameColorChange(Sender: TObject);
    procedure ButtonHeroSaveClick(Sender: TObject);
    procedure CheckBoxHeroPickUpClick(Sender: TObject);
    procedure CheckBoxHeroAutoToxinClick(Sender: TObject);
    procedure CheckBoxAddWeaponPaceClick(Sender: TObject);
    procedure CheckBoxHeroKillAddPKClick(Sender: TObject);
    procedure SpinEditBlazeTickTimeChange(Sender: TObject);
    procedure CheckBoxBumpClick(Sender: TObject);
    procedure RadioButtonAttackClick(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure CheckBoxHeroShowNameClick(Sender: TObject);
    procedure SpinEditWarrAkTimeChange(Sender: TObject);
    procedure SpinEditWizardAkTimeChange(Sender: TObject);
    procedure SpinEditTaosAkTimeChange(Sender: TObject);
    procedure SpinEditWarrWalkTimeChange(Sender: TObject);
    procedure SpinEditWizardWalkTimeChange(Sender: TObject);
    procedure SpinEditTaosWalkTimeChange(Sender: TObject);
    procedure EditHeroNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditHeroName2Change(Sender: TObject);
    procedure SpinEditHeroExpChange(Sender: TObject);
    procedure SpinEditHeroCallTimeChange(Sender: TObject);
    procedure CheckBoxGroupMbAttackMonObjectClick(Sender: TObject);
    procedure CheckBoxGroupMbAttackHeroObjectClick(Sender: TObject);
    procedure SpinEditSkillZZPowerRateChange(Sender: TObject);
    procedure SpinEditSkillZTPowerRateChange(Sender: TObject);
    procedure SpinEditSkillTTPowerRateChange(Sender: TObject);
    procedure SpinEditSkillZWPowerRateChange(Sender: TObject);
    procedure SpinEditSkillTWPowerRateChange(Sender: TObject);
    procedure SpinEditSkillWWPowerRateChange(Sender: TObject);
    procedure CheckBoxAllowJointAttackClick(Sender: TObject);
    procedure SpinEditEnergyStepUpRateChange(Sender: TObject);
    procedure CheckBoxCloseShowHpClick(Sender: TObject);
    procedure CheckBoxMonShowLevelClick(Sender: TObject);
    procedure EditMonLevelMsgChange(Sender: TObject);
    procedure SpinEditHPStoneStartRateChange(Sender: TObject);
    procedure SpinEditMPStoneStartRateChange(Sender: TObject);
    procedure SpinEditHPStoneIntervalTimeChange(Sender: TObject);
    procedure SpinEditMPStoneIntervalTimeChange(Sender: TObject);
    procedure SpinEditHPStoneAddRateChange(Sender: TObject);
    procedure SpinEditMPStoneAddRateChange(Sender: TObject);
    procedure SpinEditHPStoneDecDuraChange(Sender: TObject);
    procedure SpinEditMPStoneDecDuraChange(Sender: TObject);
    procedure CheckBoxFastenAttackPlayObjectClick(Sender: TObject);
    procedure CheckBoxFastenAttackSlaveObjectClick(Sender: TObject);
    procedure CheckBoxFastenAttackHeroObjectClick(Sender: TObject);
    procedure CheckBoxInfinityStorageClick(Sender: TObject);
    procedure EditFairyCountChange(Sender: TObject);
    procedure EditFairyDuntRateChange(Sender: TObject);
    procedure EditFairyAttackRateChange(Sender: TObject);
    procedure EditInfinityStorageChange(Sender: TObject);
    procedure EditMagicDeDingTimeChange(Sender: TObject);
    procedure EditFireHitSkillTimeChange(Sender: TObject);
    procedure EditTwinHitSkillRangeChange(Sender: TObject);
    procedure EditLongSwordTimeChange(Sender: TObject);
    procedure EditLongSwordRateChange(Sender: TObject);
    procedure CheckBoxOfflineSaveExpClick(Sender: TObject);
    procedure CheckBoxOpenSelfShopClick(Sender: TObject);
    procedure CheckBoxMapShopClick(Sender: TObject);
    procedure CheckBoxSafeZoneShopClick(Sender: TObject);
    procedure EditSellOffGoldTaxRateChange(Sender: TObject);
    procedure EditSellOffGameGoldTaxRateChange(Sender: TObject);
    procedure ButtonSaveSellOffClick(Sender: TObject);
    procedure CheckBoxCloneShowMasterClick(Sender: TObject);
    procedure EditUenhancerTimeChange(Sender: TObject);
    procedure EditUenhancerRateChange(Sender: TObject);
    procedure EditPlayCloneTimeChange(Sender: TObject);
    procedure EditSellOffItemCountChange(Sender: TObject);
    procedure EditCallCloneTimeChange(Sender: TObject);
    procedure CheckBoxChangeMapCloseFireClick(Sender: TObject);
    procedure CheckBoxPlayDethCloseFireClick(Sender: TObject);
    procedure CheckBoxPlayGhostCloseFireClick(Sender: TObject);
    procedure EditFireCrossMaxTimeChange(Sender: TObject);
    procedure EditTwinHitMaxCountChange(Sender: TObject);
    procedure EditTwinHitCountChange(Sender: TObject);
    procedure EditShieldTimeChange(Sender: TObject);
    procedure EditShieldTickChange(Sender: TObject);
    procedure EditShieldAttackRateChange(Sender: TObject);
    procedure EditShieldSmashRateChange(Sender: TObject);
    procedure CheckBoxShieldYEDOClick(Sender: TObject);
    procedure CheckBoxShieldErgumClick(Sender: TObject);
    procedure CheckBoxShieldFireClick(Sender: TObject);
    procedure CheckBoxCheckBoxShieldLongClick(Sender: TObject);
    procedure RadioShieldDrokClick(Sender: TObject);
    procedure RadioShieldEggClick(Sender: TObject);
    procedure EditHeroFealtyCallAddChange(Sender: TObject);
    procedure EditHeroFealtyExpChange(Sender: TObject);
    procedure EditHeroFealtyExpAddChange(Sender: TObject);
    procedure EditHeroFealtyDeathDelChange(Sender: TObject);
    procedure EditHeroFealtyCallDelChange(Sender: TObject);
    procedure EditHeroFourMagicChange(Sender: TObject);
    procedure CheckBoxCloneMakeSlaveClick(Sender: TObject);
    procedure seLongFireHitSkillTimeChange(Sender: TObject);
    procedure seEditLongFireHitPowerChange(Sender: TObject);
    procedure seEditMeteorRainPowerChange(Sender: TObject);
    procedure seEditVampirePowerChange(Sender: TObject);
    procedure seEditVampireHpRateChange(Sender: TObject);
    procedure RadioShieldNilClick(Sender: TObject);
    procedure CheckBoxAutoOpenShieldClick(Sender: TObject);
    procedure CheckBoxPlayObjectReduceMPClick(Sender: TObject);
    procedure CheckBoxShieldShowEffectClick(Sender: TObject);
    procedure seMeteorRainTimeChange(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure seEditAttackPowerChange(Sender: TObject);
    procedure sEditSkill82TimeChange(Sender: TObject);
    procedure sEditskill82RateChange(Sender: TObject);
    procedure seMakeWineTimeChange(Sender: TObject);
    procedure seMakeWineTime1Change(Sender: TObject);
    procedure SEdtMakeWineRateChange(Sender: TObject);
    procedure seDesMedicineValueChange(Sender: TObject);
    procedure seDesMedicineTickChange(Sender: TObject);
    procedure seIncAlcoholTickChange(Sender: TObject);
    procedure seDesDrinkTickChange(Sender: TObject);
    procedure seMaxAlcoholValueChange(Sender: TObject);
    procedure seIncAlcoholValueChange(Sender: TObject);
    procedure seDecGuildFountainChange(Sender: TObject);
    procedure seInFountainTimeChange(Sender: TObject);
    procedure seMinDrinkValue83Change(Sender: TObject);
    procedure seMinDrinkValue84Change(Sender: TObject);
//    procedure seHPUpTickChange(Sender: TObject);
    procedure seHPUpUseTimeChange(Sender: TObject);
    procedure btnSaveMakeWineClick(Sender: TObject);
    procedure seDecMaxAlcoholTimeChange(Sender: TObject);
    procedure GridMedicineExpSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
    procedure GridSkill84ExpSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
    procedure sewinequalityChange(Sender: TObject);
    procedure seTempAbilChange(Sender: TObject);
    procedure seGettempAbilRateChange(Sender: TObject);
    procedure SeSpeedupAlcoholTickChange(Sender: TObject);
    procedure SEDRUNKTickChange(Sender: TObject);
    procedure seskill84MaxLevelChange(Sender: TObject);
    procedure seHighDRUNKTickChange(Sender: TObject);
    procedure seHighAlcoholTickChange(Sender: TObject);
    procedure selowDRUNKTickChange(Sender: TObject);
    procedure selowAlcoholTickChange(Sender: TObject);
    procedure seRUNKValueChange(Sender: TObject);
    procedure seClearHeroGhostTickChange(Sender: TObject);
    procedure seDecAlcoholValueChange(Sender: TObject);
    procedure SeMakeMedicineWineMinQualityChange(Sender: TObject);
    procedure SeMedicineIncAbilChange(Sender: TObject);
    procedure Seskill84HPUpTickChange(Sender: TObject);
    procedure GridSkill83AbilSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
    procedure SeSkill57DecDamageChange(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure SeChallengeTimeChange(Sender: TObject);
    procedure btnChallengeSaveClick(Sender: TObject);

  private
    boOpened: Boolean;
    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure RefReNewLevelConf;
    procedure RefUpgradeWeapon;
    procedure RefMakeMine;
    procedure RefWinLottery;
    procedure RefMonUpgrade;
    procedure RefGeneral;
    procedure RefSpiritMutiny;
    procedure RefMagicSkill;
    procedure RefMonSayMsg;
    procedure RefSellOff;
    procedure RefWeaponMakeLuck();
    procedure RefHero();
    procedure RefWine();
    procedure RefChallenge();
    { Private declarations }
  public
    procedure Open;
    { Public declarations }
  end;

var
  frmFunctionConfig: TfrmFunctionConfig;

implementation

uses M2Share, HUtil32, SDK;

{$R *.dfm}

{ TfrmFunctionConfig }

procedure TfrmFunctionConfig.RefHero();
begin
  try
    SpinEditHeroCallTime.Value := Trunc(g_Config.nHeroCallTick / 1000);
    seClearHeroGhostTick.Value := Trunc(g_Config.nClearHeroGhostTick / 1000);
    EditHeroNameColor.Value := g_Config.nHeroNameColor;
    LabeltHeroNameColor.Color := GetRGB(EditHeroNameColor.Value);
    SpinEditHeroExp.Value := g_config.nHeroKillMonExp;
    SpinEditBlazeTickTime.Value := Trunc(g_Config.nHeroMagicBlazeTick / 1000);
    case g_Config.nHeroWarrDefaultMagic of
      0: RadioButtonAttack.Checked := True;
      1: RadioButton2.Checked := True;
      2: RadioButton3.Checked := True;
    end;
    SpinEditWarrAkTime.Value := g_Config.nWarrAttackTick;
    SpinEditWizardAkTime.Value := g_Config.nWizardAttackTick;
    SpinEditTaosAkTime.Value := g_Config.nTaosAttackTick;
    SpinEditWarrWalkTime.Value := g_Config.nWarrWalkTime;
    SpinEditWizardWalkTime.Value := g_Config.nWizardWalkTime;
    SpinEditTaosWalkTime.Value := g_Config.nTaosWalkTime;

    CheckBoxHeroPickUp.Checked := g_Config.bHeroPickUpItem;
    CheckBoxHeroAutoToxin.Checked := g_Config.bHeroAutoPoison;
    CheckBoxAddWeaponPace.Checked := g_Config.bHeroAddWeaponSpeed;
    CheckBoxHeroKillAddPK.Checked := g_Config.bHeroKillManAddPK;
    CheckBox1.Checked:=g_Config.boHeroExpMode;
    CheckBoxBump.Checked := g_Config.bHeroUseBump;
    CheckBoxHeroShowName.Checked := g_Config.bHeroShowMasterName;
    EditHeroName.Text := g_Config.sHeroName;
    EditHeroName2.Text := g_Config.sHeroNameSuffix;
    EditHeroFealtyCallAdd.Value := g_Config.nHeroFealtyCallAdd;
    EditHeroFealtyExp.Value := g_Config.nHeroFealtyExp;
    EditHeroFealtyExpAdd.Value := g_Config.nHeroFealtyExpAdd;
    EditHeroFealtyDeathDel.Value := g_Config.nHeroFealtyDeathDel;
    EditHeroFealtyCallDel.Value := g_Config.nHeroFealtyCallDel;
    EditHeroFourMagic.Value := g_Config.nHeroFourMagic;
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.RefHero');
  end;
end;

procedure TfrmFunctionConfig.ModValue;
begin
  try
    boModValued := True;
    ButtonPasswordLockSave.Enabled := True;
    ButtonSaveSellOff.Enabled := True;
    ButtonGeneralSave.Enabled := True;
    ButtonSkillSave.Enabled := True;
    ButtonUpgradeWeaponSave.Enabled := True;
    ButtonMasterSave.Enabled := True;
    ButtonMakeMineSave.Enabled := True;
    ButtonWinLotterySave.Enabled := True;
    ButtonReNewLevelSave.Enabled := True;
    ButtonMonUpgradeSave.Enabled := True;
    ButtonSpiritMutinySave.Enabled := True;
    ButtonMonSayMsgSave.Enabled := True;
    ButtonHeroSave.Enabled := True;
    btnSaveMakeWine.Enabled := True;
    btnChallengeSave.Enabled:=True;
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ModValue');
  end;
end;

procedure TfrmFunctionConfig.uModValue;
begin
  try
    boModValued := False;
    ButtonPasswordLockSave.Enabled := False;
    ButtonSaveSellOff.Enabled := False;
    ButtonGeneralSave.Enabled := False;
    ButtonSkillSave.Enabled := False;
    ButtonUpgradeWeaponSave.Enabled := False;
    ButtonMasterSave.Enabled := False;
    ButtonMakeMineSave.Enabled := False;
    ButtonWinLotterySave.Enabled := False;
    ButtonReNewLevelSave.Enabled := False;
    ButtonMonUpgradeSave.Enabled := False;
    ButtonSpiritMutinySave.Enabled := False;
    ButtonMonSayMsgSave.Enabled := False;
    ButtonHeroSave.Enabled := False;
    btnSaveMakeWine.Enabled := False;
    btnChallengeSave.Enabled:=False;
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.uModValue');
  end;
end;

procedure TfrmFunctionConfig.FunctionConfigControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  try
    if boModValued then
    begin
      if
        Application.MessageBox('参数设置已经被修改，是否确认不保存修改的设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) = IDYES then
      begin
        uModValue
      end
      else
        AllowChange := False;
    end;
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.FunctionConfigControlChanging');
  end;
end;

procedure TfrmFunctionConfig.Open;
var
  I: Integer;
begin
  try
    boOpened := False;
    uModValue();

    RefGeneral();
    CheckBoxHungerSystem.Checked := g_Config.boHungerSystem;
    CheckBoxHungerDecHP.Checked := g_Config.boHungerDecHP;
    CheckBoxHungerDecPower.Checked := g_Config.boHungerDecPower;

    CheckBoxHungerSystemClick(CheckBoxHungerSystem);

    CheckBoxEnablePasswordLock.Checked := g_Config.boPasswordLockSystem;
    CheckBoxLockGetBackItem.Checked := g_Config.boLockGetBackItemAction;
    CheckBoxLockDealItem.Checked := g_Config.boLockDealAction;
    CheckBoxLockDropItem.Checked := g_Config.boLockDropAction;
    CheckBoxLockWalk.Checked := g_Config.boLockWalkAction;
    CheckBoxLockRun.Checked := g_Config.boLockRunAction;
    CheckBoxLockHit.Checked := g_Config.boLockHitAction;
    CheckBoxLockSpell.Checked := g_Config.boLockSpellAction;
    CheckBoxLockSendMsg.Checked := g_Config.boLockSendMsgAction;
    CheckBoxLockInObMode.Checked := g_Config.boLockInObModeAction;

    CheckBoxLockLogin.Checked := g_Config.boLockHumanLogin;
    CheckBoxLockUseItem.Checked := g_Config.boLockUserItemAction;

    CheckBoxEnablePasswordLockClick(CheckBoxEnablePasswordLock);
    CheckBoxLockLoginClick(CheckBoxLockLogin);
    CheckBox1.Checked:=g_Config.boHeroExpMode;
    EditErrorPasswordCount.Value := g_Config.nPasswordErrorCountLock;

    EditBoneFammName.Text := g_Config.sSkeleton;
    EditBoneFammCount.Value := g_Config.nSkeletonCount;

    for I := Low(g_Config.SkeletonArray) to High(g_Config.SkeletonArray) do
    begin
      if g_Config.SkeletonArray[I].nHumLevel <= 0 then
        break;

      GridBoneFamm.Cells[0, I + 1] :=
        IntToStr(g_Config.SkeletonArray[I].nHumLevel);
      GridBoneFamm.Cells[1, I + 1] := g_Config.SkeletonArray[I].sMonName;
      GridBoneFamm.Cells[2, I + 1] :=
        IntToStr(g_Config.SkeletonArray[I].nCount);
      GridBoneFamm.Cells[3, I + 1] :=
        IntToStr(g_Config.SkeletonArray[I].nLevel);
    end;

    EditFairyName.Text := g_Config.sFairy;
    EditFairyCount.Value := g_Config.nFairyCount;
    EditPlayCloneName.Text := g_Config.sPlayCloneName;
    CheckBoxCloneShowMaster.Checked := g_Config.boCloneShowMasterName;
    CheckBoxCloneMakeSlave.Checked := g_Config.boCloneMakeSlave;
    EditPlayCloneTime.Value := g_Config.nPlayCloneTime div 1000;
    EditCallCloneTime.Value := g_Config.nCallCloneTime div 1000;

    for I := Low(g_Config.FairyArray) to High(g_Config.FairyArray) do
    begin
      if g_Config.FairyArray[I].nHumLevel <= 0 then
        break;

      GridFairy.Cells[0, I + 1] := IntToStr(g_Config.FairyArray[I].nHumLevel);
      GridFairy.Cells[1, I + 1] := g_Config.FairyArray[I].sMonName;
      GridFairy.Cells[2, I + 1] := IntToStr(g_Config.FairyArray[I].nCount);
      GridFairy.Cells[3, I + 1] := IntToStr(g_Config.FairyArray[I].nLevel);
    end;

    EditDogzName.Text := g_Config.sDragon;
    EditDogzCount.Value := g_Config.nDragonCount;
    for I := Low(g_Config.DragonArray) to High(g_Config.DragonArray) do
    begin
      if g_Config.DragonArray[I].nHumLevel <= 0 then
        break;
      GridDogz.Cells[0, I + 1] := IntToStr(g_Config.DragonArray[I].nHumLevel);
      GridDogz.Cells[1, I + 1] := g_Config.DragonArray[I].sMonName;
      GridDogz.Cells[2, I + 1] := IntToStr(g_Config.DragonArray[I].nCount);
      GridDogz.Cells[3, I + 1] := IntToStr(g_Config.DragonArray[I].nLevel);
    end;

    RefMagicSkill();

    RefUpgradeWeapon();
    RefMakeMine();
    RefWinLottery();
    EditMasterOKLevel.Value := g_Config.nMasterOKLevel;
    EditMasterOKCreditPoint.Value := g_Config.nMasterOKCreditPoint;
    EditMasterOKBonusPoint.Value := g_Config.nMasterOKBonusPoint;

    RefReNewLevelConf();
    RefMonUpgrade();
    RefSpiritMutiny();
    RefMonSayMsg();
    RefSellOff();
    RefWeaponMakeLuck();
    RefHero();
    RefWine();
    RefChallenge();
    boOpened := True;
    FunctionConfigControl.ActivePageIndex := 0;
    ShowModal;
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.Open');
  end;
end;

procedure TfrmFunctionConfig.FormCreate(Sender: TObject);
var
i:integer;
begin
  try
    GridBoneFamm.Cells[0, 0] := '人物等级';
    GridBoneFamm.Cells[1, 0] := '怪物名称';
    GridBoneFamm.Cells[2, 0] := '数量';
    GridBoneFamm.Cells[3, 0] := '等级';

    GridDogz.Cells[0, 0] := '人物等级';
    GridDogz.Cells[1, 0] := '怪物名称';
    GridDogz.Cells[2, 0] := '数量';
    GridDogz.Cells[3, 0] := '等级';

    GridFairy.Cells[0, 0] := '人物等级';
    GridFairy.Cells[1, 0] := '怪物名称';
    GridFairy.Cells[2, 0] := '数量';
    GridFairy.Cells[3, 0] := '等级';

    GridMedicineExp.ColWidths[0] := 30;
    GridMedicineExp.ColWidths[1] := 100;
    GridMedicineExp.Cells[0, 0] := '等级';
    GridMedicineExp.Cells[1, 0] := '经验值';

    GridSkill83Abil.ColWidths[0] := 30;
    GridSkill83Abil.ColWidths[1] := 70;
    GridSkill83Abil.ColWidths[2] := 70;
    GridSkill83Abil.Cells[0, 0] := '等级';
    GridSkill83Abil.Cells[1, 0] := '属性值';
    GridSkill83Abil.Cells[2, 0] := '酒量值';

    for I := 1 to GridSkill83Abil.RowCount do
    begin
      GridSkill83Abil.Cells[0, I] := IntToStr(I-1);
    end;

    for I := 1 to GridMedicineExp.RowCount - 1 do
    begin
      GridMedicineExp.Cells[0, I] := IntToStr(I);
    end;

    GridSkill84Exp.ColWidths[0] := 30;
    GridSkill84Exp.ColWidths[1] := 100;
    GridSkill84Exp.Cells[0, 0] := '等级';
    GridSkill84Exp.Cells[1, 0] := '经验值';
    for I := 1 to GridSkill84Exp.RowCount do
    begin
      GridSkill84Exp.Cells[0, I] := IntToStr(I-1);
    end;

    PageControl4.ActivePageIndex := 0;
    PageControl5.ActivePageIndex := 0;
    FunctionConfigControl.ActivePageIndex := 0;
    MagicPageControl.ActivePageIndex := 0;
    PageControl1.ActivePageIndex := 0;
    PageControl2.ActivePageIndex := 0;
    PageControl3.ActivePageIndex := 0;
{$IF (SoftVersion = VERPRO) or (SoftVersion = VERENT)}
    CheckBoxHungerDecPower.Visible := True;
{$ELSE}
    CheckBoxHungerDecPower.Visible := False;
{$IFEND}

{$IF SoftVersion = VERDEMO}
    Caption := '功能设置[演示版本，所有设置调整有效，但不能保存]'
{$IFEND}
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.FormCreate');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxEnablePasswordLockClick(
  Sender: TObject);
begin
  try
    case CheckBoxEnablePasswordLock.Checked of
      True:
        begin
          CheckBoxLockGetBackItem.Enabled := True;
          CheckBoxLockLogin.Enabled := True;
        end;
      False:
        begin
          CheckBoxLockGetBackItem.Checked := False;
          CheckBoxLockLogin.Checked := False;

          CheckBoxLockGetBackItem.Enabled := False;
          CheckBoxLockLogin.Enabled := False;
        end;
    end;
    if not boOpened then
      exit;
    g_Config.boPasswordLockSystem := CheckBoxEnablePasswordLock.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxEnablePasswordLockClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxLockGetBackItemClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boLockGetBackItemAction := CheckBoxLockGetBackItem.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxLockGetBackItemClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxLockDealItemClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boLockDealAction := CheckBoxLockDealItem.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxLockDealItemClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxLockDropItemClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boLockDropAction := CheckBoxLockDropItem.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxLockDropItemClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxLockUseItemClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boLockUserItemAction := CheckBoxLockUseItem.Checked;
    ModValue();

  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxLockUseItemClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxLockLoginClick(Sender: TObject);
begin
  try
    case CheckBoxLockLogin.Checked of //
      True:
        begin
          CheckBoxLockWalk.Enabled := True;
          CheckBoxLockRun.Enabled := True;
          CheckBoxLockHit.Enabled := True;
          CheckBoxLockSpell.Enabled := True;
          CheckBoxLockInObMode.Enabled := True;
          CheckBoxLockSendMsg.Enabled := True;
          CheckBoxLockDealItem.Enabled := True;
          CheckBoxLockDropItem.Enabled := True;
          CheckBoxLockUseItem.Enabled := True;
        end;
      False:
        begin
          CheckBoxLockWalk.Checked := False;
          CheckBoxLockRun.Checked := False;
          CheckBoxLockHit.Checked := False;
          CheckBoxLockSpell.Checked := False;
          CheckBoxLockInObMode.Checked := False;
          CheckBoxLockSendMsg.Checked := False;
          CheckBoxLockDealItem.Checked := False;
          CheckBoxLockDropItem.Checked := False;
          CheckBoxLockUseItem.Checked := False;

          CheckBoxLockWalk.Enabled := False;
          CheckBoxLockRun.Enabled := False;
          CheckBoxLockHit.Enabled := False;
          CheckBoxLockSpell.Enabled := False;
          CheckBoxLockInObMode.Enabled := False;
          CheckBoxLockSendMsg.Enabled := False;
          CheckBoxLockDealItem.Enabled := False;
          CheckBoxLockDropItem.Enabled := False;
          CheckBoxLockUseItem.Enabled := False;
        end;
    end;
    if not boOpened then
      exit;
    g_Config.boLockHumanLogin := CheckBoxLockLogin.Checked;
    ModValue();

  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxLockLoginClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxLockWalkClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boLockWalkAction := CheckBoxLockWalk.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxLockWalkClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxLockRunClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boLockRunAction := CheckBoxLockRun.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxLockRunClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxLockHitClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boLockHitAction := CheckBoxLockHit.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxLockHitClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxLockSpellClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boLockSpellAction := CheckBoxLockSpell.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxLockSpellClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxLockSendMsgClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boLockSendMsgAction := CheckBoxLockSendMsg.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxLockSendMsgClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxLockInObModeClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boLockInObModeAction := CheckBoxLockInObMode.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxLockInObModeClick');
  end;
end;

procedure TfrmFunctionConfig.EditErrorPasswordCountChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nPasswordErrorCountLock := EditErrorPasswordCount.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditErrorPasswordCountChange');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxErrorCountKickClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nPasswordErrorCountLock := EditErrorPasswordCount.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxErrorCountKickClick');
  end;
end;

procedure TfrmFunctionConfig.ButtonPasswordLockSaveClick(Sender: TObject);
begin
  try
{$IF SoftVersion <> VERDEMO}
    Config.WriteBool('Setup', 'PasswordLockSystem',
      g_Config.boPasswordLockSystem);
    Config.WriteBool('Setup', 'PasswordLockDealAction',
      g_Config.boLockDealAction);
    Config.WriteBool('Setup', 'PasswordLockDropAction',
      g_Config.boLockDropAction);
    Config.WriteBool('Setup', 'PasswordLockGetBackItemAction',
      g_Config.boLockGetBackItemAction);
    Config.WriteBool('Setup', 'PasswordLockWalkAction',
      g_Config.boLockWalkAction);
    Config.WriteBool('Setup', 'PasswordLockRunAction',
      g_Config.boLockRunAction);
    Config.WriteBool('Setup', 'PasswordLockHitAction',
      g_Config.boLockHitAction);
    Config.WriteBool('Setup', 'PasswordLockSpellAction',
      g_Config.boLockSpellAction);
    Config.WriteBool('Setup', 'PasswordLockSendMsgAction',
      g_Config.boLockSendMsgAction);
    Config.WriteBool('Setup', 'PasswordLockInObModeAction',
      g_Config.boLockInObModeAction);
    Config.WriteBool('Setup', 'PasswordLockUserItemAction',
      g_Config.boLockUserItemAction);

    Config.WriteBool('Setup', 'PasswordLockHumanLogin',
      g_Config.boLockHumanLogin);
    Config.WriteInteger('Setup', 'PasswordErrorCountLock',
      g_Config.nPasswordErrorCountLock);

{$IFEND}
    uModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonPasswordLockSaveClick');
  end;
end;

procedure TfrmFunctionConfig.RefChallenge;
begin
   try
    SeChallengeTime.Value:=g_Config.nChallengeTime div 60000;
    RadioGroup1.ItemIndex:=g_Config.nChallengeGoldIndex;
   except
    MainOutMessage('[Exception] TfrmFunctionConfig.RefChallenge');
  end;
end;

procedure TfrmFunctionConfig.RefGeneral();
begin
  try
    EditPKFlagNameColor.Value := g_Config.btPKFlagNameColor;
    EditPKLevel1NameColor.Value := g_Config.btPKLevel1NameColor;
    EditPKLevel2NameColor.Value := g_Config.btPKLevel2NameColor;
    EditAllyAndGuildNameColor.Value := g_Config.btAllyAndGuildNameColor;
    EditWarGuildNameColor.Value := g_Config.btWarGuildNameColor;
    EditInFreePKAreaNameColor.Value := g_Config.btInFreePKAreaNameColor;
    CheckBoxCloseShowHp.Checked := g_Config.boCloseShowHp;
    SpinEditHPStoneStartRate.Value := g_Config.HPStoneStartRate;
    SpinEditMPStoneStartRate.Value := g_Config.MPStoneStartRate;
    SpinEditHPStoneIntervalTime.Value := Trunc(g_Config.HPStoneIntervalTime /
      1000);
    SpinEditMPStoneIntervalTime.Value := Trunc(g_Config.MPStoneIntervalTime /
      1000);
    SpinEditHPStoneAddRate.Value := g_Config.HPStoneAddRate;
    SpinEditMPStoneAddRate.Value := g_Config.MPStoneAddRate;
    SpinEditHPStoneDecDura.Value := g_Config.HPStoneDecDura;
    SpinEditMPStoneDecDura.Value := g_Config.MPStoneDecDura;
    CheckBoxInfinityStorage.Checked := g_Config.boInfinityStorage;
    EditInfinityStorage.Value := g_Config.nInfinityStorageCount;
    EditInfinityStorage.Enabled := not CheckBoxInfinityStorage.Checked;
    CheckBoxOfflineSaveExp.Checked := g_Config.boOfflineSaveExp;

  except
    MainOutMessage('[Exception] TfrmFunctionConfig.RefGeneral');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxHungerSystemClick(Sender: TObject);
begin
  try
    if CheckBoxHungerSystem.Checked then
    begin
      CheckBoxHungerDecHP.Enabled := True;
      CheckBoxHungerDecPower.Enabled := True;
    end
    else
    begin
      CheckBoxHungerDecHP.Checked := False;
      CheckBoxHungerDecPower.Checked := False;
      CheckBoxHungerDecHP.Enabled := False;
      CheckBoxHungerDecPower.Enabled := False;
    end;

    if not boOpened then
      exit;
    g_Config.boHungerSystem := CheckBoxHungerSystem.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxHungerSystemClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxHungerDecHPClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boHungerDecHP := CheckBoxHungerDecHP.Checked;
    ModValue();

  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxHungerDecHPClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxHungerDecPowerClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boHungerDecPower := CheckBoxHungerDecPower.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxHungerDecPowerClick');
  end;
end;

procedure TfrmFunctionConfig.btnChallengeSaveClick(Sender: TObject);
begin
  try
    Config.WriteInteger('Setup', 'ChallengeTime', g_Config.nChallengeTime*60000);
    Config.WriteInteger('Setup', 'ChallengeGoldIndex', g_Config.nChallengeGoldIndex);
    uModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.btnChallengeSaveClick');
  end;
end;

procedure TfrmFunctionConfig.btnSaveMakeWineClick(Sender: TObject);
var
  I: Integer;
  dwExp: LongWord;
  NeedExps: TLevelNeedExp;
  Need83S:TSkill83Exp;
begin
  try
      Config.WriteInteger('setup', 'MakeWineTime', g_Config.nMakeWineTime);
      Config.WriteInteger('setup', 'MakeWineTime1', g_Config.nMakeWineTime1);
      Config.WriteInteger('setup', 'MakeMedicineWineMinQuality', g_Config.nMakeMedicineWineMinQuality);
      Config.WriteInteger('setup', 'MakeWineRate', g_Config.nMakeWineRate);
      Config.WriteInteger('setup', 'DesMedicineValue', g_Config.nDesMedicineValue);
      Config.WriteInteger('setup', 'DecMaxAlcoholTime', g_Config.nDecMaxAlcoholTime);
      Config.WriteInteger('setup', 'DesMedicineTick', g_Config.nDesMedicineTick);
      Config.WriteInteger('setup', 'IncAlcoholTick', g_Config.nIncAlcoholTick);
      Config.WriteInteger('setup', 'DesDrinkTick', g_Config.nDesDrinkTick);
      Config.WriteInteger('setup', 'MaxAlcoholValue', g_Config.nMaxAlcoholValue);
      Config.WriteInteger('setup', 'MedicineIncAbil', g_Config.nMedicineIncAbil);
      Config.WriteInteger('setup', 'IncAlcoholValue', g_Config.nIncAlcoholValue);
      Config.WriteInteger('setup', 'DecAlcoholValue', g_Config.nDecAlcoholValue);
      Config.WriteInteger('setup', 'DecGuildFountain', g_Config.nDecGuildFountain);
      Config.WriteInteger('setup', 'InFountainTime', g_Config.nInFountainTime);
      Config.WriteInteger('setup', 'MinDrinkValue83', g_Config.nMinDrinkValue83);
      Config.WriteInteger('setup', 'MinDrinkValue84', g_Config.nMinDrinkValue84);
      Config.WriteInteger('setup', 'HPUpUseTime', g_Config.nHPUpUseTime);
      Config.WriteInteger('setup','Winequality',g_Config.nWinequality);
      Config.WriteInteger('setup','TempAbil', g_Config.nTempAbil);
      Config.WriteInteger('setup','SpeedupAlcoholTick', g_Config.nSpeedupAlcoholTick);
      Config.WriteInteger('setup','GettempAbilRate',g_Config.nGettempAbilRate);
      Config.WriteInteger('setup','DRUNKTick',g_Config.nDRUNKTick);
      Config.WriteInteger('setup','HighDRUNKTick',g_Config.nHighDRUNKTick);
      Config.WriteInteger('setup','HighAlcoholTick',g_Config.nHighAlcoholTick);
      Config.WriteInteger('setup','lowDRUNKTick',g_Config.nlowDRUNKTick );
      Config.WriteInteger('setup','lowAlcoholTick',g_Config.nlowAlcoholTick);
      Config.WriteInteger('setup','RUNKValue',g_Config.nRUNKValue);
      Config.WriteInteger('setup','skill84MaxLevel',g_Config.nskill84MaxLevel);
      Config.WriteInteger('setup','skill84HPUpTick',g_Config.nskill84HPUpTick);
   //   Config.WriteInteger('setup', 'HPUpTick', g_Config.nHPUpTick);

    for I := 1 to GridMedicineExp.RowCount - 1 do
    begin
      dwExp := Str_ToInt(GridMedicineExp.Cells[1, I], 0);
      if (dwExp <= 0) then
      begin
        Application.MessageBox(PChar('等级 ' + IntToStr(I) +
          ' 药力值升级经验设置错误！！！'), '错误信息', MB_OK +
          MB_ICONERROR);
        GridMedicineExp.Row := I;
        GridMedicineExp.SetFocus;
        exit;
      end;
      NeedExps[I] := dwExp;
    end;
    g_Config.dwMedicineExps := NeedExps;
    for I := 1 to high(g_Config.dwMedicineExps) do
    begin
      ExpConf.WriteString('MedicineExp', 'Level' + IntToStr(I),IntToStr(g_Config.dwMedicineExps[I]));
    end;

    for I := 1 to GridSkill84Exp.RowCount - 1 do
    begin
      dwExp := Str_ToInt(GridSkill84Exp.Cells[1, I], 0);
      if (dwExp <= 0) then
      begin
        Application.MessageBox(PChar('等级 ' + IntToStr(I) +
          '酒气护身升级经验设置错误！！！'), '错误信息', MB_OK +
          MB_ICONERROR);
        GridSkill84Exp.Row := I;
        GridSkill84Exp.SetFocus;
        exit;
      end;
      NeedExps[I] := dwExp;
    end;
    g_Config.dwskill84Exps := NeedExps;
    for I := 1 to high(g_Config.dwskill84Exps) do
    begin
      ExpConf.WriteString('skill84Exp', 'Level' + IntToStr(I),IntToStr(g_Config.dwskill84Exps[I]));
    end;

    for I := 1 to GridSkill83Abil.RowCount do
    begin
      dwExp := Str_ToInt(GridSkill83Abil.Cells[1, I], 0);
      if (dwExp < 0) then
      begin
        Application.MessageBox(PChar('等级 ' + IntToStr(I) +
          '先天元力属性设置错误！！！'), '错误信息', MB_OK +
          MB_ICONERROR);
        GridSkill83Abil.Row := I;
        GridSkill83Abil.SetFocus;
        exit;
      end;
      Need83S[I-1] := dwExp;
    end;
    g_Config.dwskill83Abils := Need83S;
    for I := 0 to high(g_Config.dwskill83Abils) do
    begin
      ExpConf.WriteString('skill83Abil', 'Level' + IntToStr(I),IntToStr(g_Config.dwskill83Abils[I]));
    end;

    for I := 1 to GridSkill83Abil.RowCount do
    begin
      dwExp := Str_ToInt(GridSkill83Abil.Cells[2, I], 0);
      if (dwExp < 0) then
      begin
        Application.MessageBox(PChar('等级 ' + IntToStr(I) +
          '先天元力酒量设置错误！！！'), '错误信息', MB_OK +
          MB_ICONERROR);
        GridSkill83Abil.Row := I;
        GridSkill83Abil.SetFocus;
        exit;
      end;
      Need83S[I-1] := dwExp;
    end;
    g_Config.dwskill83Exps  := Need83S;
    for I := 0 to high(g_Config.dwskill83Exps ) do
    begin
      ExpConf.WriteString('skill83Exp', 'Level' + IntToStr(I),IntToStr(g_Config.dwskill83Exps[I]));
    end;

    uModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.btnSaveMakeWineClick');
  end;
end;

procedure TfrmFunctionConfig.ButtonGeneralSaveClick(Sender: TObject);
begin
  try
{$IF SoftVersion <> VERDEMO}
    g_Config.nInfinityStorageCount := EditInfinityStorage.Value;
    Config.WriteBool('Setup', 'HungerSystem', g_Config.boHungerSystem);
    Config.WriteBool('Setup', 'HungerDecHP', g_Config.boHungerDecHP);
    Config.WriteBool('Setup', 'HungerDecPower', g_Config.boHungerDecPower);
    Config.WriteBool('Setup', 'CloseShowHP', g_Config.boCloseShowHP);
    Config.WriteBool('Setup', 'InfinityStorage', g_Config.boInfinityStorage);
    Config.WriteInteger('Setup', 'InfinityStorageCount',
      g_Config.nInfinityStorageCount);

    Config.WriteInteger('Setup', 'PKFlagNameColor', g_Config.btPKFlagNameColor);
    Config.WriteInteger('Setup', 'AllyAndGuildNameColor',
      g_Config.btAllyAndGuildNameColor);
    Config.WriteInteger('Setup', 'WarGuildNameColor',
      g_Config.btWarGuildNameColor);
    Config.WriteInteger('Setup', 'InFreePKAreaNameColor',
      g_Config.btInFreePKAreaNameColor);
    Config.WriteInteger('Setup', 'PKLevel1NameColor',
      g_Config.btPKLevel1NameColor);
    Config.WriteInteger('Setup', 'PKLevel2NameColor',
      g_Config.btPKLevel2NameColor);

    Config.WriteInteger('Setup', 'HPStoneStartRate', g_Config.HPStoneStartRate);
    Config.WriteInteger('Setup', 'MPStoneStartRate', g_Config.MPStoneStartRate);
    Config.WriteInteger('Setup', 'HPStoneIntervalTime',
      g_Config.HPStoneIntervalTime);
    Config.WriteInteger('Setup', 'MPStoneIntervalTime',
      g_Config.MPStoneIntervalTime);
    Config.WriteInteger('Setup', 'HPStoneAddRate', g_Config.HPStoneAddRate);
    Config.WriteInteger('Setup', 'MPStoneAddRate', g_Config.MPStoneAddRate);
    Config.WriteInteger('Setup', 'HPStoneDecDura', g_Config.HPStoneDecDura);
    Config.WriteInteger('Setup', 'MPStoneDecDura', g_Config.MPStoneDecDura);
    Config.WriteBool('Setup', 'OfflineSaveExp', g_Config.boOfflineSaveExp);
{$IFEND}
    uModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonGeneralSaveClick');
  end;
end;

procedure TfrmFunctionConfig.EditMagicAttackRageChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMagicAttackRage := EditMagicAttackRage.Value;
    ModValue();

  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMagicAttackRageChange');
  end;
end;

procedure TfrmFunctionConfig.RefMagicSkill;
begin
  try
    EditSwordLongPowerRate.Value := g_Config.nSwordLongPowerRate;
    CheckBoxLimitSwordLong.Checked := g_Config.boLimitSwordLong;
    EditFireBoomRage.Value := g_Config.nFireBoomRage;
    EditSnowWindRange.Value := g_Config.nSnowWindRange;
    EditElecBlizzardRange.Value := g_Config.nElecBlizzardRange;
    EditMagicAttackRage.Value := g_Config.nMagicAttackRage;
    EditAmyOunsulPoint.Value := g_Config.nAmyOunsulPoint;
    EditMagTurnUndeadLevel.Value := g_Config.nMagTurnUndeadLevel;
    EditMagTammingLevel.Value := g_Config.nMagTammingLevel;
    EditMagTammingTargetLevel.Value := g_Config.nMagTammingTargetLevel;
    EditMagTammingHPRate.Value := g_Config.nMagTammingHPRate;
    EditTammingCount.Value := g_Config.nMagTammingCount;
    EditMabMabeHitRandRate.Value := g_Config.nMabMabeHitRandRate;
    EditMabMabeHitMinLvLimit.Value := g_Config.nMabMabeHitMinLvLimit;
    EditMabMabeHitSucessRate.Value := g_Config.nMabMabeHitSucessRate;
    EditMabMabeHitMabeTimeRate.Value := g_Config.nMabMabeHitMabeTimeRate;
    CheckBoxFireCrossInSafeZone.Checked :=
      g_Config.boDisableInSafeZoneFireCross;
    CheckBoxChangeMapCloseFire.Checked := g_Config.boChangeMapCloseFire;
    CheckBoxPlayDethCloseFire.Checked := g_Config.boPlayDethCloseFire;
    CheckBoxPlayGhostCloseFire.Checked := g_Config.boPlayGhostCloseFire;
    EditFireCrossMaxTime.Value := g_Config.dwFireCrossMaxTime div 1000;
    CheckBoxPlayObjectReduceMP.Checked := g_Config.boPlayObjectReduceMP;

    CheckBoxGroupMbAttackPlayObject.Checked :=
      g_Config.boGroupMbAttackPlayObject;
    CheckBoxGroupMbAttackMonObject.Checked := g_Config.boGroupMbAttackMonObject;
    CheckBoxGroupMbAttackHeroObject.Checked :=
      g_Config.boGroupMbAttackHeroObject;
    CheckBoxFastenAttackPlayObject.Checked := g_Config.boFastenAttackPlayObject;
    CheckBoxFastenAttackHeroObject.Checked := g_Config.boFastenAttackHeroObject;
    CheckBoxFastenAttackHeroObject.Checked := g_Config.boFastenAttackHeroObject;
    CheckBoxAllowJointAttack.Checked := g_Config.boAllowJointAttack;
    SpinEditEnergyStepUpRate.Value := g_Config.nEnergyStepUpRate;
    SpinEditSkillWWPowerRate.Value := g_Config.nSkillWWPowerRate;
    SpinEditSkillTWPowerRate.Value := g_Config.nSkillTWPowerRate;
    SpinEditSkillZWPowerRate.Value := g_Config.nSkillZWPowerRate;
    SpinEditSkillTTPowerRate.Value := g_Config.nSkillTTPowerRate;
    SpinEditSkillZTPowerRate.Value := g_Config.nSkillZTPowerRate;
    SpinEditSkillZZPowerRate.Value := g_Config.nSkillZZPowerRate;

    seLongFireHitSkillTime.Value := g_COnfig.nLongFireHitSkillTime div 1000;
    seEditLongFireHitPower.Value := g_Config.nLongFireHitPower;
    seEditAttackPower.Value:=g_Config.nAttackPower;
    sEditSkill82Time.Value:=g_Config.nSkill82Time;
    sEditSkill82Rate.Value:=g_Config.nSkill82Rate;
    seSkill57DecDamage.Value:=g_Config.nSkill57DecDamage;
    seEditMeteorRainPower.Value := g_COnfig.nMeteorRainPower;
    seMeteorRainTime.Value := g_Config.nMeteorRainTime div 1000;
    seEditVampirePower.Value := g_Config.nVampirePower;
    seEditVampireHpRate.Value := g_Config.nVampireHpRate;

    EditMagicDeDingTime.Value := g_Config.dwMagicDeDingTime div 1000;
    EditFireHitSkillTime.Value := g_Config.nFireHitSkillTime div 1000;
    EditTwinHitSkillRange.Value := g_Config.nTwinHitSkillRange;
    EditTwinHitMaxCount.Value := g_Config.nTwinHitMaxCount;
    EditTwinHitCount.Value := g_Config.nTwinHitCount;
    EditUenhancerTime.Value := g_Config.nUenhancerTime;
    EditUenhancerRate.Value := g_Config.nUenhancerRate;
    EditLongSwordTime.Value := g_Config.nLongSwordTime div 1000;
    EditLongSwordRate.Value := g_Config.nLongSwordRate;
    EditFairyAttackRate.Value := g_Config.nFairyAttackRate;
    EditFairyDuntRate.Value := g_Config.nFairyDuntRate;
    EditFairyCount.Value := g_Config.nFairyCount;

    EditShieldTime.Value := g_Config.nShieldTime div 1000;
    EditShieldTick.Value := g_Config.nShieldTick div 1000;
    EditShieldAttackRate.Value := g_Config.nShieldAttackRate;
    EditShieldSmashRate.Value := g_Config.nShieldSmashRate;
    RadioShieldNil.Checked := g_Config.boShieldAttackEff = 0;
    RadioShieldDrok.Checked := g_Config.boShieldAttackEff = 1;
    RadioShieldEgg.Checked := g_Config.boShieldAttackEff = 2;
    CheckBoxAutoOpenShield.Checked := g_Config.boAutoOpenShield;
    CheckBoxShieldYEDO.Checked := g_Config.boShieldYEDO;
    CheckBoxShieldErgum.Checked := g_Config.boShieldErgum;
    CheckBoxShieldFire.Checked := g_Config.boShieldFire;
    CheckBoxCheckBoxShieldLong.Checked := g_Config.boShieldLong;
    CheckBoxShieldShowEffect.Checked := g_Config.boShieldShowEffect;
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.RefMagicSkill');
  end;
end;

procedure TfrmFunctionConfig.EditBoneFammCountChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nSkeletonCount := EditBoneFammCount.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditBoneFammCountChange');
  end;
end;

procedure TfrmFunctionConfig.EditDogzCountChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nDragonCount := EditDogzCount.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditDogzCountChange');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxLimitSwordLongClick(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boLimitSwordLong := CheckBoxLimitSwordLong.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxLimitSwordLongClick');
  end;
end;

procedure TfrmFunctionConfig.EditSwordLongPowerRateChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nSwordLongPowerRate := EditSwordLongPowerRate.Value;
    ModValue()
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditSwordLongPowerRateChange');
  end;
end;

procedure TfrmFunctionConfig.EditBoneFammNameChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditBoneFammNameChange');
  end;
end;

procedure TfrmFunctionConfig.EditDogzNameChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditDogzNameChange');
  end;
end;

procedure TfrmFunctionConfig.EditFireBoomRageChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nFireBoomRage := EditFireBoomRage.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditFireBoomRageChange');
  end;
end;

procedure TfrmFunctionConfig.EditSnowWindRangeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nSnowWindRange := EditSnowWindRange.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditSnowWindRangeChange');
  end;
end;

procedure TfrmFunctionConfig.EditElecBlizzardRangeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nElecBlizzardRange := EditElecBlizzardRange.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditElecBlizzardRangeChange');
  end;
end;

procedure TfrmFunctionConfig.EditMagTurnUndeadLevelChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMagTurnUndeadLevel := EditMagTurnUndeadLevel.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMagTurnUndeadLevelChange');
  end;
end;

procedure TfrmFunctionConfig.GridBoneFammSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  try
    if not boOpened then
      exit;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.GridBoneFammSetEditText');
  end;
end;

procedure TfrmFunctionConfig.GridMedicineExpSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
  try
    if not boOpened then
      exit;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.GridMedicineExpSetEditText');
  end;
end;

procedure TfrmFunctionConfig.GridSkill83AbilSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
  try
    if not boOpened then
      exit;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.GridSkill83AbilSetEditText');
  end;
end;

procedure TfrmFunctionConfig.GridSkill84ExpSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
  try
    if not boOpened then
      exit;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.GridSkill84ExpSetEditText');
  end;
end;

procedure TfrmFunctionConfig.EditAmyOunsulPointChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nAmyOunsulPoint := EditAmyOunsulPoint.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditAmyOunsulPointChange');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxFireCrossInSafeZoneClick(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boDisableInSafeZoneFireCross :=
      CheckBoxFireCrossInSafeZone.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxFireCrossInSafeZoneClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxGroupMbAttackPlayObjectClick(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boGroupMbAttackPlayObject :=
      CheckBoxGroupMbAttackPlayObject.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxGroupMbAttackPlayObjectClick');
  end;
end;

procedure TfrmFunctionConfig.ButtonSkillSaveClick(Sender: TObject);
var
  I: Integer;
  RecallArray: array[0..9] of TRecallMigic;
  Rect: TGridRect;
begin
  try
    FillChar(RecallArray, SizeOf(RecallArray), #0);

    g_Config.sSkeleton := Trim(EditBoneFammName.Text);
    g_Config.sDragon := Trim(EditDogzName.Text);
    g_Config.sFairy := Trim(EditFairyName.Text);
    g_Config.sPlayCloneName := Trim(EditPlayCloneName.Text);

    for I := Low(RecallArray) to High(RecallArray) do
    begin
      RecallArray[I].nHumLevel := Str_ToInt(GridBoneFamm.Cells[0, I + 1], -1);
      RecallArray[I].sMonName := Trim(GridBoneFamm.Cells[1, I + 1]);
      RecallArray[I].nCount := Str_ToInt(GridBoneFamm.Cells[2, I + 1], -1);
      RecallArray[I].nLevel := Str_ToInt(GridBoneFamm.Cells[3, I + 1], -1);
      if GridBoneFamm.Cells[0, I + 1] = '' then
        break;
      if (RecallArray[I].nHumLevel <= 0) then
      begin
        Application.MessageBox('人物等级设置错误！！！',
          '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 0;
        Rect.Top := I + 1;
        Rect.Right := 0;
        Rect.Bottom := I + 1;
        GridBoneFamm.Selection := Rect;
        exit;
      end;
      if UserEngine.GetMonRace(RecallArray[I].sMonName) <= 0 then
      begin
        Application.MessageBox('怪物名称设置错误！！！',
          '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 1;
        Rect.Top := I + 1;
        Rect.Right := 1;
        Rect.Bottom := I + 1;
        GridBoneFamm.Selection := Rect;
        exit;
      end;
      if RecallArray[I].nCount <= 0 then
      begin
        Application.MessageBox('召唤数量设置错误！！！',
          '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 2;
        Rect.Top := I + 1;
        Rect.Right := 2;
        Rect.Bottom := I + 1;
        GridBoneFamm.Selection := Rect;
        exit;
      end;
      if RecallArray[I].nLevel < 0 then
      begin
        Application.MessageBox('召唤等级设置错误！！！',
          '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 3;
        Rect.Top := I + 1;
        Rect.Right := 3;
        Rect.Bottom := I + 1;
        GridBoneFamm.Selection := Rect;
        exit;
      end;
    end;

    for I := Low(RecallArray) to High(RecallArray) do
    begin
      RecallArray[I].nHumLevel := Str_ToInt(GridDogz.Cells[0, I + 1], -1);
      RecallArray[I].sMonName := Trim(GridDogz.Cells[1, I + 1]);
      RecallArray[I].nCount := Str_ToInt(GridDogz.Cells[2, I + 1], -1);
      RecallArray[I].nLevel := Str_ToInt(GridDogz.Cells[3, I + 1], -1);
      if GridDogz.Cells[0, I + 1] = '' then
        break;
      if (RecallArray[I].nHumLevel <= 0) then
      begin
        Application.MessageBox('人物等级设置错误！！！',
          '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 0;
        Rect.Top := I + 1;
        Rect.Right := 0;
        Rect.Bottom := I + 1;
        GridDogz.Selection := Rect;
        exit;
      end;
      if UserEngine.GetMonRace(RecallArray[I].sMonName) <= 0 then
      begin
        Application.MessageBox('怪物名称设置错误！！！',
          '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 1;
        Rect.Top := I + 1;
        Rect.Right := 1;
        Rect.Bottom := I + 1;
        GridDogz.Selection := Rect;
        exit;
      end;
      if RecallArray[I].nCount <= 0 then
      begin
        Application.MessageBox('召唤数量设置错误！！！',
          '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 2;
        Rect.Top := I + 1;
        Rect.Right := 2;
        Rect.Bottom := I + 1;
        GridDogz.Selection := Rect;
        exit;
      end;
      if RecallArray[I].nLevel < 0 then
      begin
        Application.MessageBox('召唤等级设置错误！！！',
          '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 3;
        Rect.Top := I + 1;
        Rect.Right := 3;
        Rect.Bottom := I + 1;
        GridDogz.Selection := Rect;
        exit;
      end;
    end;

    for I := Low(RecallArray) to High(RecallArray) do
    begin
      RecallArray[I].nHumLevel := Str_ToInt(GridFairy.Cells[0, I + 1], -1);
      RecallArray[I].sMonName := Trim(GridFairy.Cells[1, I + 1]);
      RecallArray[I].nCount := Str_ToInt(GridFairy.Cells[2, I + 1], -1);
      RecallArray[I].nLevel := Str_ToInt(GridFairy.Cells[3, I + 1], -1);
      if GridFairy.Cells[0, I + 1] = '' then
        break;
      if (RecallArray[I].nHumLevel <= 0) then
      begin
        Application.MessageBox('人物等级设置错误！！！',
          '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 0;
        Rect.Top := I + 1;
        Rect.Right := 0;
        Rect.Bottom := I + 1;
        GridFairy.Selection := Rect;
        exit;
      end;
      if UserEngine.GetMonRace(RecallArray[I].sMonName) <= 0 then
      begin
        Application.MessageBox('怪物名称设置错误！！！',
          '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 1;
        Rect.Top := I + 1;
        Rect.Right := 1;
        Rect.Bottom := I + 1;
        GridFairy.Selection := Rect;
        exit;
      end;
      if RecallArray[I].nCount <= 0 then
      begin
        Application.MessageBox('召唤数量设置错误！！！',
          '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 2;
        Rect.Top := I + 1;
        Rect.Right := 2;
        Rect.Bottom := I + 1;
        GridFairy.Selection := Rect;
        exit;
      end;
      if RecallArray[I].nLevel < 0 then
      begin
        Application.MessageBox('召唤等级设置错误！！！',
          '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 3;
        Rect.Top := I + 1;
        Rect.Right := 3;
        Rect.Bottom := I + 1;
        GridFairy.Selection := Rect;
        exit;
      end;
    end;
    Config.ReadString('Names', 'PlayCloneName', g_Config.sPlayCloneName);
    Config.WriteBool('Setup', 'CloneShowMasterName',
      g_Config.boCloneShowMasterName);
    Config.WriteInteger('Setup', 'PlayCloneTime', g_Config.nPlayCloneTime);
    Config.WriteInteger('Setup', 'CallCloneTime', g_Config.nCallCloneTime);
    Config.WriteBool('Setup', 'CloneMakeSlave', g_Config.boCloneMakeSlave);

    FillChar(g_Config.SkeletonArray, SizeOf(g_Config.SkeletonArray), #0);
    for I := Low(g_Config.SkeletonArray) to High(g_Config.SkeletonArray) do
    begin
      Config.WriteInteger('Setup', 'SkeletonHumLevel' + IntToStr(I), 0);
      Config.WriteString('Setup', 'Skeleton' + IntToStr(I), '');
      Config.WriteInteger('Setup', 'SkeletonCount' + IntToStr(I), 0);
      Config.WriteInteger('Setup', 'SkeletonLevel' + IntToStr(I), 0);
    end;
    for I := Low(g_Config.SkeletonArray) to High(g_Config.SkeletonArray) do
    begin
      if GridBoneFamm.Cells[0, I + 1] = '' then
        break;
      g_Config.SkeletonArray[I].nHumLevel := Str_ToInt(GridBoneFamm.Cells[0, I +
        1], -1);
      g_Config.SkeletonArray[I].sMonName := Trim(GridBoneFamm.Cells[1, I + 1]);
      g_Config.SkeletonArray[I].nCount := Str_ToInt(GridBoneFamm.Cells[2, I + 1],
        -1);
      g_Config.SkeletonArray[I].nLevel := Str_ToInt(GridBoneFamm.Cells[3, I + 1],
        -1);

      Config.WriteInteger('Setup', 'SkeletonHumLevel' + IntToStr(I),
        g_Config.SkeletonArray[I].nHumLevel);
      Config.WriteString('Setup', 'Skeleton' + IntToStr(I),
        g_Config.SkeletonArray[I].sMonName);
      Config.WriteInteger('Setup', 'SkeletonCount' + IntToStr(I),
        g_Config.SkeletonArray[I].nCount);
      Config.WriteInteger('Setup', 'SkeletonLevel' + IntToStr(I),
        g_Config.SkeletonArray[I].nLevel);
    end;

    FillChar(g_Config.DragonArray, SizeOf(g_Config.DragonArray), #0);
    for I := Low(g_Config.DragonArray) to High(g_Config.DragonArray) do
    begin
      Config.WriteInteger('Setup', 'DragonHumLevel' + IntToStr(I), 0);
      Config.WriteString('Setup', 'Dragon' + IntToStr(I), '');
      Config.WriteInteger('Setup', 'DragonCount' + IntToStr(I), 0);
      Config.WriteInteger('Setup', 'DragonLevel' + IntToStr(I), 0);
    end;
    for I := Low(g_Config.DragonArray) to High(g_Config.DragonArray) do
    begin
      if GridDogz.Cells[0, I + 1] = '' then
        break;

      g_Config.DragonArray[I].nHumLevel := Str_ToInt(GridDogz.Cells[0, I + 1],
        -1);
      g_Config.DragonArray[I].sMonName := Trim(GridDogz.Cells[1, I + 1]);
      g_Config.DragonArray[I].nCount := Str_ToInt(GridDogz.Cells[2, I + 1], -1);
      g_Config.DragonArray[I].nLevel := Str_ToInt(GridDogz.Cells[3, I + 1], -1);

      Config.WriteInteger('Setup', 'DragonHumLevel' + IntToStr(I),
        g_Config.DragonArray[I].nHumLevel);
      Config.WriteString('Setup', 'Dragon' + IntToStr(I),
        g_Config.DragonArray[I].sMonName);
      Config.WriteInteger('Setup', 'DragonCount' + IntToStr(I),
        g_Config.DragonArray[I].nCount);
      Config.WriteInteger('Setup', 'DragonLevel' + IntToStr(I),
        g_Config.DragonArray[I].nLevel);
    end;

    FillChar(g_Config.FairyArray, SizeOf(g_Config.FairyArray), #0);
    for I := Low(g_Config.FairyArray) to High(g_Config.FairyArray) do
    begin
      Config.WriteInteger('Setup', 'FairyHumLevel' + IntToStr(I), 0);
      Config.WriteString('Setup', 'Fairy' + IntToStr(I), '');
      Config.WriteInteger('Setup', 'FairyCount' + IntToStr(I), 0);
      Config.WriteInteger('Setup', 'FairyLevel' + IntToStr(I), 0);
    end;
    for I := Low(g_Config.FairyArray) to High(g_Config.FairyArray) do
    begin
      if GridFairy.Cells[0, I + 1] = '' then
        break;

      g_Config.FairyArray[I].nHumLevel := Str_ToInt(GridFairy.Cells[0, I + 1],
        -1);
      g_Config.FairyArray[I].sMonName := Trim(GridFairy.Cells[1, I + 1]);
      g_Config.FairyArray[I].nCount := Str_ToInt(GridFairy.Cells[2, I + 1], -1);
      g_Config.FairyArray[I].nLevel := Str_ToInt(GridFairy.Cells[3, I + 1], -1);

      Config.WriteInteger('Setup', 'FairyHumLevel' + IntToStr(I),
        g_Config.FairyArray[I].nHumLevel);
      Config.WriteString('Setup', 'Fairy' + IntToStr(I),
        g_Config.FairyArray[I].sMonName);
      Config.WriteInteger('Setup', 'FairyCount' + IntToStr(I),
        g_Config.FairyArray[I].nCount);
      Config.WriteInteger('Setup', 'FairyLevel' + IntToStr(I),
        g_Config.FairyArray[I].nLevel);
    end;

{$IF SoftVersion <> VERDEMO}
    Config.WriteBool('Setup', 'LimitSwordLong', g_Config.boLimitSwordLong);
    Config.WriteInteger('Setup', 'SwordLongPowerRate',
      g_Config.nSwordLongPowerRate);
    Config.WriteInteger('Setup', 'SkeletonCount', g_Config.nSkeletonCount);
    Config.WriteString('Names', 'Skeleton', g_Config.sSkeleton);
    Config.WriteInteger('Setup', 'DragonCount', g_Config.nDragonCount);
    Config.WriteString('Names', 'Dragon', g_Config.sDragon);
    Config.WriteInteger('Setup', 'FairyCount', g_Config.nFairyCount);
    Config.WriteString('Names', 'Fairy', g_Config.sFairy);
    Config.WriteInteger('Setup', 'FairyDuntRate', g_Config.nFairyDuntRate);
    Config.WriteInteger('Setup', 'FairyAttackRate', g_Config.nFairyAttackRate);
    Config.WriteInteger('Setup', 'FireBoomRage', g_Config.nFireBoomRage);
    Config.WriteInteger('Setup', 'SnowWindRange', g_Config.nSnowWindRange);
    Config.WriteInteger('Setup', 'ElecBlizzardRange',
      g_Config.nElecBlizzardRange);
    Config.WriteInteger('Setup', 'AmyOunsulPoint', g_Config.nAmyOunsulPoint);

    Config.WriteInteger('Setup', 'MagicAttackRage', g_Config.nMagicAttackRage);
    Config.WriteInteger('Setup', 'MagTurnUndeadLevel',
      g_Config.nMagTurnUndeadLevel);
    Config.WriteInteger('Setup', 'MagTammingLevel', g_Config.nMagTammingLevel);
    Config.WriteInteger('Setup', 'MagTammingTargetLevel',
      g_Config.nMagTammingTargetLevel);
    Config.WriteInteger('Setup', 'MagTammingTargetHPRate',
      g_Config.nMagTammingHPRate);
    Config.WriteInteger('Setup', 'MagTammingCount', g_Config.nMagTammingCount);

    Config.WriteInteger('Setup', 'MabMabeHitRandRate',
      g_Config.nMabMabeHitRandRate);
    Config.WriteInteger('Setup', 'MabMabeHitMinLvLimit',
      g_Config.nMabMabeHitMinLvLimit);
    Config.WriteInteger('Setup', 'MabMabeHitSucessRate',
      g_Config.nMabMabeHitSucessRate);
    Config.WriteInteger('Setup', 'MabMabeHitMabeTimeRate',
      g_Config.nMabMabeHitMabeTimeRate);

    Config.WriteBool('Setup', 'DisableInSafeZoneFireCross',
      g_Config.boDisableInSafeZoneFireCross);
    Config.WriteBool('Setup', 'ChangeMapCloseFire',
      g_Config.boChangeMapCloseFire);
    Config.WriteBool('Setup', 'PlayDethCloseFire',
      g_Config.boPlayDethCloseFire);
    Config.WriteBool('Setup', 'PlayGhostCloseFire',
      g_Config.boPlayGhostCloseFire);
    Config.WriteInteger('Setup', 'FireCrossMaxTime',
      g_Config.dwFireCrossMaxTime);

    Config.WriteBool('Setup', 'GroupMbAttackPlayObject',
      g_Config.boGroupMbAttackPlayObject);
    Config.WriteBool('Setup', 'GroupMbAttackMonObject',
      g_Config.boGroupMbAttackMonObject);
    Config.WriteBool('Setup', 'GroupMbAttackHeroObject',
      g_Config.boGroupMbAttackHeroObject);
    Config.WriteBool('Setup', 'FastenAttackPlayObject',
      g_Config.boFastenAttackPlayObject);
    Config.WriteBool('Setup', 'FastenAttackHeroObject',
      g_Config.boFastenAttackHeroObject);
    Config.WriteBool('Setup', 'FastenAttackSlaveObject',
      g_Config.boFastenAttackSlaveObject);

    Config.WriteBool('Setup', 'AllowJointAttack', g_Config.boAllowJointAttack);
    Config.WriteInteger('Setup', 'EnergyStepUpRate',
      g_Config.nEnergyStepUpRate);
    Config.WriteInteger('Setup', 'SkillWWPowerRate',
      g_Config.nSkillWWPowerRate);
    Config.WriteInteger('Setup', 'SkillTWPowerRate',
      g_Config.nSkillTWPowerRate);
    Config.WriteInteger('Setup', 'SkillZWPowerRate',
      g_Config.nSkillZWPowerRate);
    Config.WriteInteger('Setup', 'SkillTTPowerRate',
      g_Config.nSkillTTPowerRate);
    Config.WriteInteger('Setup', 'SkillZTPowerRate',
      g_Config.nSkillZTPowerRate);
    Config.WriteInteger('Setup', 'SkillZZPowerRate',
      g_Config.nSkillZZPowerRate);
    Config.WriteInteger('Setup', 'MagicDeDingTime', g_Config.dwMagicDeDingTime);

    Config.WriteInteger('Setup', 'FireHitSkillTime',
      g_Config.nFireHitSkillTime);
    Config.WriteInteger('Setup', 'TwinHitSkillRange',
      g_Config.nTwinHitSkillRange);
    Config.WriteInteger('Setup', 'TwinHitMaxCount', g_Config.nTwinHitMaxCount);
    Config.WriteInteger('Setup', 'TwinHitCount', g_Config.nTwinHitCount);
    Config.WriteInteger('Setup', 'LongSwordTime', g_Config.nLongSwordTime);
    Config.WriteInteger('Setup', 'LongSwordRate', g_Config.nLongSwordRate);
    Config.WriteInteger('Setup', 'UenhancerTime', g_Config.nUenhancerTime);
    Config.WriteInteger('Setup', 'UenhancerRate', g_Config.nUenhancerRate);
    Config.WriteInteger('Setup', 'LongFireHitSkillTime',
      g_Config.nLongFireHitSkillTime);
    Config.WriteInteger('Setup', 'LongFireHitPower',
      g_Config.nLongFireHitPower);
    Config.WriteInteger('Setup', 'MeteorRainPower', g_Config.nMeteorRainPower);
    Config.WriteInteger('Setup', 'MeteorRainTime', g_Config.nMeteorRainTime);
    Config.WriteInteger('Setup', 'VampirePower', g_Config.nVampirePower);
    Config.WriteInteger('Setup', 'AttackPower', g_Config.nAttackPower);
    Config.WriteInteger('Setup', 'Skill82Time', g_Config.nSkill82Time);
    Config.WriteInteger('Setup', 'Skill82Rate', g_Config.nSkill82Rate);
    Config.WriteInteger('Setup', 'Skill57DecDamage', g_Config.nSkill57DecDamage);
    Config.WriteInteger('Setup', 'VampireHpRate', g_Config.nVampireHpRate);
    Config.WriteBool('Setup', 'PlayObjectReduceMP',
      g_Config.boPlayObjectReduceMP);

    Config.WriteBool('Setup', 'ShieldFire', g_Config.boShieldFire);
    Config.WriteBool('Setup', 'ShieldLong', g_Config.boShieldLong);
    Config.WriteBool('Setup', 'ShieldErgum', g_Config.boShieldErgum);
    Config.WriteBool('Setup', 'ShieldYEDO', g_Config.boShieldYEDO);
    Config.WriteBool('Setup', 'AutoOpenShield', g_Config.boAutoOpenShield);
    Config.WriteInteger('Setup', 'ShieldAttackEff', g_Config.boShieldAttackEff);
    Config.WriteInteger('Setup', 'ShieldSmashRate', g_Config.nShieldSmashRate);
    Config.WriteInteger('Setup', 'ShieldAttackRate',
      g_Config.nShieldAttackRate);
    Config.WriteInteger('Setup', 'ShieldTick', g_Config.nShieldTick);
    Config.WriteInteger('Setup', 'ShieldTime', g_Config.nShieldTime);
    Config.WriteBool('Setup', 'ShieldShowEffect', g_Config.boShieldShowEffect);
{$IFEND}
    uModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonSkillSaveClick');
  end;
end;

procedure TfrmFunctionConfig.RefUpgradeWeapon();
begin
  try
    ScrollBarUpgradeWeaponDCRate.Position := g_Config.nUpgradeWeaponDCRate;
    ScrollBarUpgradeWeaponDCTwoPointRate.Position :=
      g_Config.nUpgradeWeaponDCTwoPointRate;
    ScrollBarUpgradeWeaponDCThreePointRate.Position :=
      g_Config.nUpgradeWeaponDCThreePointRate;

    ScrollBarUpgradeWeaponMCRate.Position := g_Config.nUpgradeWeaponMCRate;
    ScrollBarUpgradeWeaponMCTwoPointRate.Position :=
      g_Config.nUpgradeWeaponMCTwoPointRate;
    ScrollBarUpgradeWeaponMCThreePointRate.Position :=
      g_Config.nUpgradeWeaponMCThreePointRate;

    ScrollBarUpgradeWeaponSCRate.Position := g_Config.nUpgradeWeaponSCRate;
    ScrollBarUpgradeWeaponSCTwoPointRate.Position :=
      g_Config.nUpgradeWeaponSCTwoPointRate;
    ScrollBarUpgradeWeaponSCThreePointRate.Position :=
      g_Config.nUpgradeWeaponSCThreePointRate;

    EditUpgradeWeaponMaxPoint.Value := g_Config.nUpgradeWeaponMaxPoint;
    EditUpgradeWeaponPrice.Value := g_Config.nUpgradeWeaponPrice;
    EditUPgradeWeaponGetBackTime.Value := g_Config.dwUPgradeWeaponGetBackTime div
      1000;
    EditClearExpireUpgradeWeaponDays.Value :=
      g_Config.nClearExpireUpgradeWeaponDays;
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.RefUpgradeWeapon');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponDCRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarUpgradeWeaponDCRate.Position;
    EditUpgradeWeaponDCRate.Text := IntToStr(nPostion);
    if not boOpened then
      exit;
    g_Config.nUpgradeWeaponDCRate := nPostion;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarUpgradeWeaponDCRateChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponDCTwoPointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarUpgradeWeaponDCTwoPointRate.Position;
    EditUpgradeWeaponDCTwoPointRate.Text := IntToStr(nPostion);
    if not boOpened then
      exit;
    g_Config.nUpgradeWeaponDCTwoPointRate := nPostion;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarUpgradeWeaponDCTwoPointRateChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponDCThreePointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarUpgradeWeaponDCThreePointRate.Position;
    EditUpgradeWeaponDCThreePointRate.Text := IntToStr(nPostion);
    if not boOpened then
      exit;
    g_Config.nUpgradeWeaponDCThreePointRate := nPostion;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarUpgradeWeaponDCThreePointRateChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponSCRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarUpgradeWeaponSCRate.Position;
    EditUpgradeWeaponSCRate.Text := IntToStr(nPostion);
    if not boOpened then
      exit;
    g_Config.nUpgradeWeaponSCRate := nPostion;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarUpgradeWeaponSCRateChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponSCTwoPointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarUpgradeWeaponSCTwoPointRate.Position;
    EditUpgradeWeaponSCTwoPointRate.Text := IntToStr(nPostion);
    if not boOpened then
      exit;
    g_Config.nUpgradeWeaponSCTwoPointRate := nPostion;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarUpgradeWeaponSCTwoPointRateChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponSCThreePointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarUpgradeWeaponSCThreePointRate.Position;
    EditUpgradeWeaponSCThreePointRate.Text := IntToStr(nPostion);
    if not boOpened then
      exit;
    g_Config.nUpgradeWeaponSCThreePointRate := nPostion;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarUpgradeWeaponSCThreePointRateChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponMCRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarUpgradeWeaponMCRate.Position;
    EditUpgradeWeaponMCRate.Text := IntToStr(nPostion);
    if not boOpened then
      exit;
    g_Config.nUpgradeWeaponMCRate := nPostion;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarUpgradeWeaponMCRateChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponMCTwoPointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarUpgradeWeaponMCTwoPointRate.Position;
    EditUpgradeWeaponMCTwoPointRate.Text := IntToStr(nPostion);
    if not boOpened then
      exit;
    g_Config.nUpgradeWeaponMCTwoPointRate := nPostion;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarUpgradeWeaponMCTwoPointRateChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponMCThreePointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarUpgradeWeaponMCThreePointRate.Position;
    EditUpgradeWeaponMCThreePointRate.Text := IntToStr(nPostion);
    if not boOpened then
      exit;
    g_Config.nUpgradeWeaponMCThreePointRate := nPostion;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarUpgradeWeaponMCThreePointRateChange');
  end;
end;

procedure TfrmFunctionConfig.EditUpgradeWeaponMaxPointChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nUpgradeWeaponMaxPoint := EditUpgradeWeaponMaxPoint.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditUpgradeWeaponMaxPointChange');
  end;
end;

procedure TfrmFunctionConfig.EditUpgradeWeaponPriceChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nUpgradeWeaponPrice := EditUpgradeWeaponPrice.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditUpgradeWeaponPriceChange');
  end;
end;

procedure TfrmFunctionConfig.EditUPgradeWeaponGetBackTimeChange(Sender:
  TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.dwUPgradeWeaponGetBackTime := EditUPgradeWeaponGetBackTime.Value *
      1000;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditUPgradeWeaponGetBackTimeChange');
  end;
end;

procedure TfrmFunctionConfig.EditClearExpireUpgradeWeaponDaysChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nClearExpireUpgradeWeaponDays :=
      EditClearExpireUpgradeWeaponDays.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditClearExpireUpgradeWeaponDaysChange');
  end;
end;

procedure TfrmFunctionConfig.ButtonUpgradeWeaponSaveClick(Sender: TObject);
begin
  try
{$IF SoftVersion <> VERDEMO}
    Config.WriteInteger('Setup', 'UpgradeWeaponMaxPoint',
      g_Config.nUpgradeWeaponMaxPoint);
    Config.WriteInteger('Setup', 'UpgradeWeaponPrice',
      g_Config.nUpgradeWeaponPrice);
    Config.WriteInteger('Setup', 'ClearExpireUpgradeWeaponDays',
      g_Config.nClearExpireUpgradeWeaponDays);
    Config.WriteInteger('Setup', 'UPgradeWeaponGetBackTime',
      g_Config.dwUPgradeWeaponGetBackTime);

    Config.WriteInteger('Setup', 'UpgradeWeaponDCRate',
      g_Config.nUpgradeWeaponDCRate);
    Config.WriteInteger('Setup', 'UpgradeWeaponDCTwoPointRate',
      g_Config.nUpgradeWeaponDCTwoPointRate);
    Config.WriteInteger('Setup', 'UpgradeWeaponDCThreePointRate',
      g_Config.nUpgradeWeaponDCThreePointRate);

    Config.WriteInteger('Setup', 'UpgradeWeaponMCRate',
      g_Config.nUpgradeWeaponMCRate);
    Config.WriteInteger('Setup', 'UpgradeWeaponMCTwoPointRate',
      g_Config.nUpgradeWeaponMCTwoPointRate);
    Config.WriteInteger('Setup', 'UpgradeWeaponMCThreePointRate',
      g_Config.nUpgradeWeaponMCThreePointRate);

    Config.WriteInteger('Setup', 'UpgradeWeaponSCRate',
      g_Config.nUpgradeWeaponSCRate);
    Config.WriteInteger('Setup', 'UpgradeWeaponSCTwoPointRate',
      g_Config.nUpgradeWeaponSCTwoPointRate);
    Config.WriteInteger('Setup', 'UpgradeWeaponSCThreePointRate',
      g_Config.nUpgradeWeaponSCThreePointRate);
{$IFEND}
    uModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonUpgradeWeaponSaveClick');
  end;
end;

procedure TfrmFunctionConfig.ButtonUpgradeWeaponDefaulfClick(
  Sender: TObject);
begin
  try
    if Application.MessageBox('是否确认恢复默认设置？',
      '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then
    begin
      exit;
    end;
    g_Config.nUpgradeWeaponMaxPoint := 20;
    g_Config.nUpgradeWeaponPrice := 10000;
    g_Config.nClearExpireUpgradeWeaponDays := 8;
    g_Config.dwUPgradeWeaponGetBackTime := 60 * 60 * 1000;

    g_Config.nUpgradeWeaponDCRate := 100;
    g_Config.nUpgradeWeaponDCTwoPointRate := 30;
    g_Config.nUpgradeWeaponDCThreePointRate := 200;

    g_Config.nUpgradeWeaponMCRate := 100;
    g_Config.nUpgradeWeaponMCTwoPointRate := 30;
    g_Config.nUpgradeWeaponMCThreePointRate := 200;

    g_Config.nUpgradeWeaponSCRate := 100;
    g_Config.nUpgradeWeaponSCTwoPointRate := 30;
    g_Config.nUpgradeWeaponSCThreePointRate := 200;
    RefUpgradeWeapon();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonUpgradeWeaponDefaulfClick');
  end;
end;

procedure TfrmFunctionConfig.EditMasterOKLevelChange(Sender: TObject);
begin
  try
    if EditMasterOKLevel.Text = '' then
    begin
      EditMasterOKLevel.Text := '0';
      exit;
    end;
    if not boOpened then
      exit;
    g_Config.nMasterOKLevel := EditMasterOKLevel.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMasterOKLevelChange');
  end;
end;

procedure TfrmFunctionConfig.EditMasterOKCreditPointChange(
  Sender: TObject);
begin
  try
    if EditMasterOKCreditPoint.Text = '' then
    begin
      EditMasterOKCreditPoint.Text := '0';
      exit;
    end;
    if not boOpened then
      exit;
    g_Config.nMasterOKCreditPoint := EditMasterOKCreditPoint.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMasterOKCreditPointChange');
  end;
end;

procedure TfrmFunctionConfig.EditMasterOKBonusPointChange(Sender: TObject);
begin
  try
    if EditMasterOKBonusPoint.Text = '' then
    begin
      EditMasterOKBonusPoint.Text := '0';
      exit;
    end;
    if not boOpened then
      exit;
    g_Config.nMasterOKBonusPoint := EditMasterOKBonusPoint.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMasterOKBonusPointChange');
  end;
end;

procedure TfrmFunctionConfig.ButtonMasterSaveClick(Sender: TObject);
begin
  try
{$IF SoftVersion <> VERDEMO}
    Config.WriteInteger('Setup', 'MasterOKLevel', g_Config.nMasterOKLevel);
    Config.WriteInteger('Setup', 'MasterOKCreditPoint',
      g_Config.nMasterOKCreditPoint);
    Config.WriteInteger('Setup', 'MasterOKBonusPoint',
      g_Config.nMasterOKBonusPoint);
{$IFEND}
    uModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonMasterSaveClick');
  end;
end;

procedure TfrmFunctionConfig.ButtonMakeMineSaveClick(Sender: TObject);
begin
  try
{$IF SoftVersion <> VERDEMO}
    Config.WriteInteger('Setup', 'MakeMineHitRate', g_Config.nMakeMineHitRate);
    Config.WriteInteger('Setup', 'MakeMineRate', g_Config.nMakeMineRate);
    Config.WriteInteger('Setup', 'StoneTypeRate', g_Config.nStoneTypeRate);
    Config.WriteInteger('Setup', 'StoneTypeRateMin',
      g_Config.nStoneTypeRateMin);
    Config.WriteInteger('Setup', 'GoldStoneMin', g_Config.nGoldStoneMin);
    Config.WriteInteger('Setup', 'GoldStoneMax', g_Config.nGoldStoneMax);
    Config.WriteInteger('Setup', 'SilverStoneMin', g_Config.nSilverStoneMin);
    Config.WriteInteger('Setup', 'SilverStoneMax', g_Config.nSilverStoneMax);
    Config.WriteInteger('Setup', 'SteelStoneMin', g_Config.nSteelStoneMin);
    Config.WriteInteger('Setup', 'SteelStoneMax', g_Config.nSteelStoneMax);
    Config.WriteInteger('Setup', 'BlackStoneMin', g_Config.nBlackStoneMin);
    Config.WriteInteger('Setup', 'BlackStoneMax', g_Config.nBlackStoneMax);
    Config.WriteInteger('Setup', 'StoneMinDura', g_Config.nStoneMinDura);
    Config.WriteInteger('Setup', 'StoneGeneralDuraRate',
      g_Config.nStoneGeneralDuraRate);
    Config.WriteInteger('Setup', 'StoneAddDuraRate',
      g_Config.nStoneAddDuraRate);
    Config.WriteInteger('Setup', 'StoneAddDuraMax', g_Config.nStoneAddDuraMax);
{$IFEND}
    uModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonMakeMineSaveClick');
  end;
end;

procedure TfrmFunctionConfig.ButtonMakeMineDefaultClick(Sender: TObject);
begin
  try
    if Application.MessageBox('是否确认恢复默认设置？',
      '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then
    begin
      exit;
    end;
    g_Config.nMakeMineHitRate := 4;
    g_Config.nMakeMineRate := 12;
    g_Config.nStoneTypeRate := 120;
    g_Config.nStoneTypeRateMin := 56;
    g_Config.nGoldStoneMin := 1;
    g_Config.nGoldStoneMax := 2;
    g_Config.nSilverStoneMin := 3;
    g_Config.nSilverStoneMax := 20;
    g_Config.nSteelStoneMin := 21;
    g_Config.nSteelStoneMax := 45;
    g_Config.nBlackStoneMin := 46;
    g_Config.nBlackStoneMax := 56;
    g_Config.nStoneMinDura := 3000;
    g_Config.nStoneGeneralDuraRate := 13000;
    g_Config.nStoneAddDuraRate := 20;
    g_Config.nStoneAddDuraMax := 10000;
    RefMakeMine();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonMakeMineDefaultClick');
  end;
end;

procedure TfrmFunctionConfig.RefMakeMine();
begin
  try
    ScrollBarMakeMineHitRate.Position := g_Config.nMakeMineHitRate;
    ScrollBarMakeMineHitRate.Min := 0;
    ScrollBarMakeMineHitRate.Max := 10;

    ScrollBarMakeMineRate.Position := g_Config.nMakeMineRate;
    ScrollBarMakeMineRate.Min := 0;
    ScrollBarMakeMineRate.Max := 50;

    ScrollBarStoneTypeRate.Position := g_Config.nStoneTypeRate;
    ScrollBarStoneTypeRate.Min := g_Config.nStoneTypeRateMin;
    ScrollBarStoneTypeRate.Max := 500;

    ScrollBarGoldStoneMax.Min := 1;
    ScrollBarGoldStoneMax.Max := g_Config.nSilverStoneMax;

    ScrollBarSilverStoneMax.Min := g_Config.nGoldStoneMax;
    ScrollBarSilverStoneMax.Max := g_Config.nSteelStoneMax;

    ScrollBarSteelStoneMax.Min := g_Config.nSilverStoneMax;
    ScrollBarSteelStoneMax.Max := g_Config.nBlackStoneMax;

    ScrollBarBlackStoneMax.Min := g_Config.nSteelStoneMax;
    ScrollBarBlackStoneMax.Max := g_Config.nStoneTypeRate;

    ScrollBarGoldStoneMax.Position := g_Config.nGoldStoneMax;
    ScrollBarSilverStoneMax.Position := g_Config.nSilverStoneMax;
    ScrollBarSteelStoneMax.Position := g_Config.nSteelStoneMax;
    ScrollBarBlackStoneMax.Position := g_Config.nBlackStoneMax;

    EditStoneMinDura.Value := g_Config.nStoneMinDura div 1000;
    EditStoneGeneralDuraRate.Value := g_Config.nStoneGeneralDuraRate div 1000;
    EditStoneAddDuraRate.Value := g_Config.nStoneAddDuraRate;
    EditStoneAddDuraMax.Value := g_Config.nStoneAddDuraMax div 1000;
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.RefMakeMine');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarMakeMineHitRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarMakeMineHitRate.Position;
    EditMakeMineHitRate.Text := IntToStr(nPostion);
    if not boOpened then
      exit;
    g_Config.nMakeMineHitRate := nPostion;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarMakeMineHitRateChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarMakeMineRateChange(Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarMakeMineRate.Position;
    EditMakeMineRate.Text := IntToStr(nPostion);
    if not boOpened then
      exit;
    g_Config.nMakeMineRate := nPostion;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarMakeMineRateChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarStoneTypeRateChange(Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarStoneTypeRate.Position;
    EditStoneTypeRate.Text := IntToStr(nPostion);
    if not boOpened then
      exit;
    ScrollBarBlackStoneMax.Max := nPostion;
    g_Config.nStoneTypeRate := nPostion;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarStoneTypeRateChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarGoldStoneMaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarGoldStoneMax.Position;
    EditGoldStoneMax.Text := IntToStr(g_Config.nGoldStoneMin) + '-' +
      IntToStr(g_Config.nGoldStoneMax);
    if not boOpened then
      exit;
    g_Config.nSilverStoneMin := nPostion + 1;
    ScrollBarSilverStoneMax.Min := nPostion + 1;
    g_Config.nGoldStoneMax := nPostion;
    EditSilverStoneMax.Text := IntToStr(g_Config.nSilverStoneMin) + '-' +
      IntToStr(g_Config.nSilverStoneMax);
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarGoldStoneMaxChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarSilverStoneMaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarSilverStoneMax.Position;
    EditSilverStoneMax.Text := IntToStr(g_Config.nSilverStoneMin) + '-' +
      IntToStr(g_Config.nSilverStoneMax);
    if not boOpened then
      exit;
    ScrollBarGoldStoneMax.Max := nPostion - 1;
    g_Config.nSteelStoneMin := nPostion + 1;
    ScrollBarSteelStoneMax.Min := nPostion + 1;
    g_Config.nSilverStoneMax := nPostion;
    EditGoldStoneMax.Text := IntToStr(g_Config.nGoldStoneMin) + '-' +
      IntToStr(g_Config.nGoldStoneMax);
    EditSteelStoneMax.Text := IntToStr(g_Config.nSteelStoneMin) + '-' +
      IntToStr(g_Config.nSteelStoneMax);
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarSilverStoneMaxChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarSteelStoneMaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarSteelStoneMax.Position;
    EditSteelStoneMax.Text := IntToStr(g_Config.nSteelStoneMin) + '-' +
      IntToStr(g_Config.nSteelStoneMax);
    if not boOpened then
      exit;
    ScrollBarSilverStoneMax.Max := nPostion - 1;
    g_Config.nBlackStoneMin := nPostion + 1;
    ScrollBarBlackStoneMax.Min := nPostion + 1;
    g_Config.nSteelStoneMax := nPostion;
    EditSilverStoneMax.Text := IntToStr(g_Config.nSilverStoneMin) + '-' +
      IntToStr(g_Config.nSilverStoneMax);
    EditBlackStoneMax.Text := IntToStr(g_Config.nBlackStoneMin) + '-' +
      IntToStr(g_Config.nBlackStoneMax);
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarSteelStoneMaxChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarBlackStoneMaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarBlackStoneMax.Position;
    EditBlackStoneMax.Text := IntToStr(g_Config.nBlackStoneMin) + '-' +
      IntToStr(g_Config.nBlackStoneMax);
    if not boOpened then
      exit;
    ScrollBarSteelStoneMax.Max := nPostion - 1;
    ScrollBarStoneTypeRate.Min := nPostion;
    g_Config.nBlackStoneMax := nPostion;
    EditSteelStoneMax.Text := IntToStr(g_Config.nSteelStoneMin) + '-' +
      IntToStr(g_Config.nSteelStoneMax);
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarBlackStoneMaxChange');
  end;
end;

procedure TfrmFunctionConfig.EditStoneMinDuraChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nStoneMinDura := EditStoneMinDura.Value * 1000;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditStoneMinDuraChange');
  end;
end;

procedure TfrmFunctionConfig.EditStoneGeneralDuraRateChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nStoneGeneralDuraRate := EditStoneGeneralDuraRate.Value * 1000;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditStoneGeneralDuraRateChange');
  end;
end;

procedure TfrmFunctionConfig.EditStoneAddDuraRateChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nStoneAddDuraRate := EditStoneAddDuraRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditStoneAddDuraRateChange');
  end;
end;

procedure TfrmFunctionConfig.EditStoneAddDuraMaxChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nStoneAddDuraMax := EditStoneAddDuraMax.Value * 1000;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditStoneAddDuraMaxChange');
  end;
end;

procedure TfrmFunctionConfig.RefWine;
var
i:Integer;
begin
   try
      seMakeWineTime.Value:=g_Config.nMakeWineTime;
      seMakeWineTime1.Value:=g_Config.nMakeWineTime1;
      seMakeMedicineWineMinQuality.Value:=g_Config.nMakeMedicineWineMinQuality;
      SEdtMakeWineRate.Value:=g_Config.nMakeWineRate;
      seDesMedicineValue.Value:=g_Config.nDesMedicineValue;
      seDecMaxAlcoholTime.Value:=g_Config.nDecMaxAlcoholTime;
      seDesMedicineTick.Value:=g_Config.nDesMedicineTick;
      seIncAlcoholTick.Value:=g_Config.nIncAlcoholTick;
      seDesDrinkTick.Value:=g_Config.nDesDrinkTick;
      seMaxAlcoholValue.Value:=g_Config.nMaxAlcoholValue;
      seMedicineIncAbil.Value:=g_Config.nMedicineIncAbil;
      seIncAlcoholValue.Value:=g_Config.nIncAlcoholValue;
      seDecAlcoholValue.Value:=g_Config.nDecAlcoholValue;
      seDecGuildFountain.Value:=g_Config.nDecGuildFountain;
      seInFountainTime.Value:=g_Config.nInFountainTime;
      seMinDrinkValue83.Value:=g_Config.nMinDrinkValue83;
      seMinDrinkValue84.Value:=g_Config.nMinDrinkValue84;
      seHPUpUseTime.Value:=g_Config.nHPUpUseTime;
      sewinequality.Value := g_Config.nWinequality;
      seTempAbil.Value := g_Config.nTempAbil;
      SeSpeedupAlcoholTick.Value := g_Config.nSpeedupAlcoholTick;
      seGettempAbilRate.Value := g_Config.nGettempAbilRate;
      seDRUNKTick.Value := g_Config.nDRUNKTick;
      seHighDRUNKTick.Value := g_Config.nHighDRUNKTick;
      seHighAlcoholTick.Value := g_Config.nHighAlcoholTick;
      selowDRUNKTick.Value := g_Config.nlowDRUNKTick;
      selowAlcoholTick.Value := g_Config.nlowAlcoholTick;
      seRUNKValue .Value := g_Config.nRUNKValue ;
      seskill84MaxLevel.Value := g_Config.nskill84MaxLevel;
      seskill84HPUpTick.Value := g_Config.nskill84HPUpTick;
   //   seHPUpTick.Value:=g_Config.nHPUpTick;

    for I := 1 to GridMedicineExp.RowCount - 1 do
    begin
      GridMedicineExp.Cells[1, I] := IntToStr(g_Config.dwMedicineExps[I]);
    end;

    for I := 1 to GridSkill84Exp.RowCount - 1 do
    begin
      GridSkill84Exp.Cells[1, I] := IntToStr(g_Config.dwskill84Exps[I]);
    end;

    for I := 1 to GridSkill83Abil.RowCount do
    begin
      GridSkill83Abil.Cells[1, I] := IntToStr(g_Config.dwskill83Abils[I-1]);
    end;

     for I := 1 to GridSkill83Abil.RowCount do
    begin
      GridSkill83Abil.Cells[2, I] := IntToStr(g_Config.dwskill83Exps[I-1]);
    end;

  except
    MainOutMessage('[Exception] TfrmFunctionConfig.RefWine');
  end;
end;

procedure TfrmFunctionConfig.RefWinLottery;
begin
  try
    ScrollBarWinLotteryRate.Max := 100000;
    ScrollBarWinLotteryRate.Position := g_Config.nWinLotteryRate;
    ScrollBarWinLottery1Max.Max := g_Config.nWinLotteryRate;
    ScrollBarWinLottery1Max.Min := g_Config.nWinLottery1Min;
    ScrollBarWinLottery2Max.Max := g_Config.nWinLottery1Max;
    ScrollBarWinLottery2Max.Min := g_Config.nWinLottery2Min;
    ScrollBarWinLottery3Max.Max := g_Config.nWinLottery2Max;
    ScrollBarWinLottery3Max.Min := g_Config.nWinLottery3Min;
    ScrollBarWinLottery4Max.Max := g_Config.nWinLottery3Max;
    ScrollBarWinLottery4Max.Min := g_Config.nWinLottery4Min;
    ScrollBarWinLottery5Max.Max := g_Config.nWinLottery4Max;
    ScrollBarWinLottery5Max.Min := g_Config.nWinLottery5Min;
    ScrollBarWinLottery6Max.Max := g_Config.nWinLottery5Max;
    ScrollBarWinLottery6Max.Min := g_Config.nWinLottery6Min;
    ScrollBarWinLotteryRate.Min := g_Config.nWinLottery1Max;

    ScrollBarWinLottery1Max.Position := g_Config.nWinLottery1Max;
    ScrollBarWinLottery2Max.Position := g_Config.nWinLottery2Max;
    ScrollBarWinLottery3Max.Position := g_Config.nWinLottery3Max;
    ScrollBarWinLottery4Max.Position := g_Config.nWinLottery4Max;
    ScrollBarWinLottery5Max.Position := g_Config.nWinLottery5Max;
    ScrollBarWinLottery6Max.Position := g_Config.nWinLottery6Max;

    EditWinLottery1Gold.Value := g_Config.nWinLottery1Gold;
    EditWinLottery2Gold.Value := g_Config.nWinLottery2Gold;
    EditWinLottery3Gold.Value := g_Config.nWinLottery3Gold;
    EditWinLottery4Gold.Value := g_Config.nWinLottery4Gold;
    EditWinLottery5Gold.Value := g_Config.nWinLottery5Gold;
    EditWinLottery6Gold.Value := g_Config.nWinLottery6Gold;
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.RefWinLottery');
  end;
end;

procedure TfrmFunctionConfig.ButtonWinLotterySaveClick(Sender: TObject);
begin
  try
{$IF SoftVersion <> VERDEMO}
    Config.WriteInteger('Setup', 'WinLottery1Gold', g_Config.nWinLottery1Gold);
    Config.WriteInteger('Setup', 'WinLottery2Gold', g_Config.nWinLottery2Gold);
    Config.WriteInteger('Setup', 'WinLottery3Gold', g_Config.nWinLottery3Gold);
    Config.WriteInteger('Setup', 'WinLottery4Gold', g_Config.nWinLottery4Gold);
    Config.WriteInteger('Setup', 'WinLottery5Gold', g_Config.nWinLottery5Gold);
    Config.WriteInteger('Setup', 'WinLottery6Gold', g_Config.nWinLottery6Gold);
    Config.WriteInteger('Setup', 'WinLottery1Min', g_Config.nWinLottery1Min);
    Config.WriteInteger('Setup', 'WinLottery1Max', g_Config.nWinLottery1Max);
    Config.WriteInteger('Setup', 'WinLottery2Min', g_Config.nWinLottery2Min);
    Config.WriteInteger('Setup', 'WinLottery2Max', g_Config.nWinLottery2Max);
    Config.WriteInteger('Setup', 'WinLottery3Min', g_Config.nWinLottery3Min);
    Config.WriteInteger('Setup', 'WinLottery3Max', g_Config.nWinLottery3Max);
    Config.WriteInteger('Setup', 'WinLottery4Min', g_Config.nWinLottery4Min);
    Config.WriteInteger('Setup', 'WinLottery4Max', g_Config.nWinLottery4Max);
    Config.WriteInteger('Setup', 'WinLottery5Min', g_Config.nWinLottery5Min);
    Config.WriteInteger('Setup', 'WinLottery5Max', g_Config.nWinLottery5Max);
    Config.WriteInteger('Setup', 'WinLottery6Min', g_Config.nWinLottery6Min);
    Config.WriteInteger('Setup', 'WinLottery6Max', g_Config.nWinLottery6Max);
    Config.WriteInteger('Setup', 'WinLotteryRate', g_Config.nWinLotteryRate);
{$IFEND}
    uModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonWinLotterySaveClick');
  end;
end;

procedure TfrmFunctionConfig.ButtonWinLotteryDefaultClick(Sender: TObject);
begin
  try
    if Application.MessageBox('是否确认恢复默认设置？',
      '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then
    begin
      exit;
    end;

    g_Config.nWinLottery1Gold := 1000000;
    g_Config.nWinLottery2Gold := 200000;
    g_Config.nWinLottery3Gold := 100000;
    g_Config.nWinLottery4Gold := 10000;
    g_Config.nWinLottery5Gold := 1000;
    g_Config.nWinLottery6Gold := 500;
    g_Config.nWinLottery6Min := 1;
    g_Config.nWinLottery6Max := 4999;
    g_Config.nWinLottery5Min := 14000;
    g_Config.nWinLottery5Max := 15999;
    g_Config.nWinLottery4Min := 16000;
    g_Config.nWinLottery4Max := 16149;
    g_Config.nWinLottery3Min := 16150;
    g_Config.nWinLottery3Max := 16169;
    g_Config.nWinLottery2Min := 16170;
    g_Config.nWinLottery2Max := 16179;
    g_Config.nWinLottery1Min := 16180;
    g_Config.nWinLottery1Max := 16185;
    g_Config.nWinLotteryRate := 30000;
    RefWinLottery();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonWinLotteryDefaultClick');
  end;
end;

procedure TfrmFunctionConfig.EditWinLottery1GoldChange(Sender: TObject);
begin
  try
    if EditWinLottery1Gold.Text = '' then
    begin
      EditWinLottery1Gold.Text := '0';
      exit;
    end;
    if not boOpened then
      exit;
    g_Config.nWinLottery1Gold := EditWinLottery1Gold.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditWinLottery1GoldChange');
  end;
end;

procedure TfrmFunctionConfig.EditWinLottery2GoldChange(Sender: TObject);
begin
  try
    if EditWinLottery2Gold.Text = '' then
    begin
      EditWinLottery2Gold.Text := '0';
      exit;
    end;
    if not boOpened then
      exit;
    g_Config.nWinLottery2Gold := EditWinLottery2Gold.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditWinLottery2GoldChange');
  end;
end;

procedure TfrmFunctionConfig.EditWinLottery3GoldChange(Sender: TObject);
begin
  try
    if EditWinLottery3Gold.Text = '' then
    begin
      EditWinLottery3Gold.Text := '0';
      exit;
    end;
    if not boOpened then
      exit;
    g_Config.nWinLottery3Gold := EditWinLottery3Gold.Value;
    ModValue();

  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditWinLottery3GoldChange');
  end;
end;

procedure TfrmFunctionConfig.EditWinLottery4GoldChange(Sender: TObject);
begin
  try
    if EditWinLottery4Gold.Text = '' then
    begin
      EditWinLottery4Gold.Text := '0';
      exit;
    end;
    if not boOpened then
      exit;
    g_Config.nWinLottery4Gold := EditWinLottery4Gold.Value;
    ModValue();

  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditWinLottery4GoldChange');
  end;
end;

procedure TfrmFunctionConfig.EditWinLottery5GoldChange(Sender: TObject);
begin
  try
    if EditWinLottery5Gold.Text = '' then
    begin
      EditWinLottery5Gold.Text := '0';
      exit;
    end;
    if not boOpened then
      exit;
    g_Config.nWinLottery5Gold := EditWinLottery5Gold.Value;
    ModValue();

  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditWinLottery5GoldChange');
  end;
end;

procedure TfrmFunctionConfig.EditWinLottery6GoldChange(Sender: TObject);
begin
  try
    if EditWinLottery6Gold.Text = '' then
    begin
      EditWinLottery6Gold.Text := '0';
      exit;
    end;
    if not boOpened then
      exit;
    g_Config.nWinLottery6Gold := EditWinLottery6Gold.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditWinLottery6GoldChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery1MaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarWinLottery1Max.Position;
    EditWinLottery1Max.Text := IntToStr(g_Config.nWinLottery1Min) + '-' +
      IntToStr(g_Config.nWinLottery1Max);
    if not boOpened then
      exit;
    g_Config.nWinLottery1Max := nPostion;
    ScrollBarWinLottery2Max.Max := nPostion - 1;
    ScrollBarWinLotteryRate.Min := nPostion;
    EditWinLottery1Max.Text := IntToStr(g_Config.nWinLottery1Min) + '-' +
      IntToStr(g_Config.nWinLottery1Max);
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarWinLottery1MaxChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery2MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarWinLottery2Max.Position;
    EditWinLottery2Max.Text := IntToStr(g_Config.nWinLottery2Min) + '-' +
      IntToStr(g_Config.nWinLottery2Max);
    if not boOpened then
      exit;
    g_Config.nWinLottery1Min := nPostion + 1;
    ScrollBarWinLottery1Max.Min := nPostion + 1;
    g_Config.nWinLottery2Max := nPostion;
    EditWinLottery2Max.Text := IntToStr(g_Config.nWinLottery2Min) + '-' +
      IntToStr(g_Config.nWinLottery2Max);
    EditWinLottery1Max.Text := IntToStr(g_Config.nWinLottery1Min) + '-' +
      IntToStr(g_Config.nWinLottery1Max);
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarWinLottery2MaxChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery3MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarWinLottery3Max.Position;
    EditWinLottery3Max.Text := IntToStr(g_Config.nWinLottery3Min) + '-' +
      IntToStr(g_Config.nWinLottery3Max);
    if not boOpened then
      exit;
    g_Config.nWinLottery2Min := nPostion + 1;
    ScrollBarWinLottery2Max.Min := nPostion + 1;
    g_Config.nWinLottery3Max := nPostion;
    EditWinLottery3Max.Text := IntToStr(g_Config.nWinLottery3Min) + '-' +
      IntToStr(g_Config.nWinLottery3Max);
    EditWinLottery2Max.Text := IntToStr(g_Config.nWinLottery2Min) + '-' +
      IntToStr(g_Config.nWinLottery2Max);
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarWinLottery3MaxChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery4MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarWinLottery4Max.Position;
    EditWinLottery4Max.Text := IntToStr(g_Config.nWinLottery4Min) + '-' +
      IntToStr(g_Config.nWinLottery4Max);
    if not boOpened then
      exit;
    g_Config.nWinLottery3Min := nPostion + 1;
    ScrollBarWinLottery3Max.Min := nPostion + 1;
    g_Config.nWinLottery4Max := nPostion;
    EditWinLottery4Max.Text := IntToStr(g_Config.nWinLottery4Min) + '-' +
      IntToStr(g_Config.nWinLottery4Max);
    EditWinLottery3Max.Text := IntToStr(g_Config.nWinLottery3Min) + '-' +
      IntToStr(g_Config.nWinLottery3Max);
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarWinLottery4MaxChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery5MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarWinLottery5Max.Position;
    EditWinLottery5Max.Text := IntToStr(g_Config.nWinLottery5Min) + '-' +
      IntToStr(g_Config.nWinLottery5Max);
    if not boOpened then
      exit;
    g_Config.nWinLottery4Min := nPostion + 1;
    ScrollBarWinLottery4Max.Min := nPostion + 1;
    g_Config.nWinLottery5Max := nPostion;
    EditWinLottery5Max.Text := IntToStr(g_Config.nWinLottery5Min) + '-' +
      IntToStr(g_Config.nWinLottery5Max);
    EditWinLottery4Max.Text := IntToStr(g_Config.nWinLottery4Min) + '-' +
      IntToStr(g_Config.nWinLottery4Max);
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarWinLottery5MaxChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery6MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarWinLottery6Max.Position;
    EditWinLottery6Max.Text := IntToStr(g_Config.nWinLottery6Min) + '-' +
      IntToStr(g_Config.nWinLottery6Max);
    if not boOpened then
      exit;
    g_Config.nWinLottery5Min := nPostion + 1;
    ScrollBarWinLottery5Max.Min := nPostion + 1;
    g_Config.nWinLottery6Max := nPostion;
    EditWinLottery6Max.Text := IntToStr(g_Config.nWinLottery6Min) + '-' +
      IntToStr(g_Config.nWinLottery6Max);
    EditWinLottery5Max.Text := IntToStr(g_Config.nWinLottery5Min) + '-' +
      IntToStr(g_Config.nWinLottery5Max);
    ModValue();

  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarWinLottery6MaxChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarWinLotteryRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  try
    nPostion := ScrollBarWinLotteryRate.Position;
    EditWinLotteryRate.Text := IntToStr(nPostion);
    if not boOpened then
      exit;
    ScrollBarWinLottery1Max.Max := nPostion;
    g_Config.nWinLotteryRate := nPostion;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarWinLotteryRateChange');
  end;
end;

procedure TfrmFunctionConfig.SeChallengeTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nChallengeTime:= SeChallengeTime.Value*60000;
  ModValue();
end;

procedure TfrmFunctionConfig.seClearHeroGhostTickChange(Sender: TObject);
begin
  try
    if seClearHeroGhostTick.Text = '' then
    begin
      seClearHeroGhostTick.Text := '0';
      exit;
    end;
    if not boOpened then
      exit;
    g_Config.nClearHeroGhostTick := seClearHeroGhostTick.Value * 1000;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.seClearHeroGhostTickChange');
  end;
end;

procedure TfrmFunctionConfig.seDecAlcoholValueChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nDecAlcoholValue:= seDecAlcoholValue.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seDecGuildFountainChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nDecGuildFountain:= seDecGuildFountain.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seDecMaxAlcoholTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nDecMaxAlcoholTime:= seDecMaxAlcoholTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seDesDrinkTickChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nDesDrinkTick:= seDesDrinkTick.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seDesMedicineTickChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nDesMedicineTick:= seDesMedicineTick.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seDesMedicineValueChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nDesMedicineValue:= seDesMedicineValue.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.sEditskill82RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nSkill82Rate:=SEditskill82Rate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.sEditSkill82TimeChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nSkill82Time:=SEditskill82Time.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SEDRUNKTickChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nDRUNKTick := SEDRUNKTick.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SEdtMakeWineRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMakeWineRate:= SEdtMakeWineRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seEditAttackPowerChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nAttackPower := seEditAttackPower.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seEditLongFireHitPowerChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nLongFireHitPower := seEditLongFireHitPower.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seEditMeteorRainPowerChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMeteorRainPower := seEditMeteorRainPower.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seEditVampireHpRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nVampireHpRate := seEditVampireHpRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seEditVampirePowerChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nVampirePower := seEditVampirePower.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.seGettempAbilRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nGettempAbilRate := seGettempAbilRate.Value;
  ModValue();
end;

{
procedure TfrmFunctionConfig.seHPUpTickChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nHPUpTick:= seHPUpTick.Value;
  ModValue();
end;
 }
procedure TfrmFunctionConfig.seHighAlcoholTickChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nHighAlcoholTick:= seHighAlcoholTick.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seHighDRUNKTickChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nHighDRUNKTick:= seHighDRUNKTick.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seHPUpUseTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nHPUpUseTime:= seHPUpUseTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seIncAlcoholTickChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nIncAlcoholTick:= seIncAlcoholTick.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seIncAlcoholValueChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nIncAlcoholValue:= seIncAlcoholValue.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seInFountainTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nInFountainTime:= seInFountainTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seLongFireHitSkillTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nLongFireHitSkillTime := seLongFireHitSkillTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.selowAlcoholTickChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nlowAlcoholTick := selowAlcoholTick.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.selowDRUNKTickChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nlowDRUNKTick:= selowDRUNKTick.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SeMakeMedicineWineMinQualityChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMakeMedicineWineMinQuality:= SeMakeMedicineWineMinQuality.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seMakeWineTime1Change(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMakeWineTime1:= seMakeWineTime1.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seMakeWineTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMakeWineTime:= seMakeWineTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seMaxAlcoholValueChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMaxAlcoholValue:= seMaxAlcoholValue.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SeMedicineIncAbilChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMedicineIncAbil:= SeMedicineIncAbil.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seMeteorRainTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMeteorRainTime := seMeteorRainTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.seMinDrinkValue83Change(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMinDrinkValue83:= seMinDrinkValue83.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seMinDrinkValue84Change(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMinDrinkValue84:= seMinDrinkValue84.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seRUNKValueChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nRUNKValue:= seRUNKValue.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SeSkill57DecDamageChange(Sender: TObject);
begin
 if not boOpened then
    exit;
  g_Config.nSkill57DecDamage:=SeSkill57DecDamage.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.Seskill84HPUpTickChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nskill84HPUpTick:= Seskill84HPUpTick.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seskill84MaxLevelChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nskill84MaxLevel:= seskill84MaxLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SeSpeedupAlcoholTickChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSpeedupAlcoholTick:= SeSpeedupAlcoholTick.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.seTempAbilChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nTempAbil:= seTempAbil.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.sewinequalityChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nWinequality:= sewinequality.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.RefReNewLevelConf();
begin
  try
    EditReNewNameColor1.Value := g_Config.ReNewNameColor[0];
    EditReNewNameColor2.Value := g_Config.ReNewNameColor[1];
    EditReNewNameColor3.Value := g_Config.ReNewNameColor[2];
    EditReNewNameColor4.Value := g_Config.ReNewNameColor[3];
    EditReNewNameColor5.Value := g_Config.ReNewNameColor[4];
    EditReNewNameColor6.Value := g_Config.ReNewNameColor[5];
    EditReNewNameColor7.Value := g_Config.ReNewNameColor[6];
    EditReNewNameColor8.Value := g_Config.ReNewNameColor[7];
    EditReNewNameColor9.Value := g_Config.ReNewNameColor[8];
    EditReNewNameColor10.Value := g_Config.ReNewNameColor[9];
    EditReNewNameColorTime.Value := g_Config.dwReNewNameColorTime div 1000;
    CheckBoxReNewChangeColor.Checked := g_Config.boReNewChangeColor;
    CheckBoxReNewLevelClearExp.Checked := g_Config.boReNewLevelClearExp;
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.RefReNewLevelConf');
  end;
end;

procedure TfrmFunctionConfig.ButtonReNewLevelSaveClick(Sender: TObject);
{$IF SoftVersion <> VERDEMO}
var
  I: Integer;
{$IFEND}
begin
  try
{$IF SoftVersion <> VERDEMO}
    for I := Low(g_Config.ReNewNameColor) to High(g_Config.ReNewNameColor) do
    begin
      Config.WriteInteger('Setup', 'ReNewNameColor' + IntToStr(I),
        g_Config.ReNewNameColor[I]);
    end;
    Config.WriteInteger('Setup', 'ReNewNameColorTime',
      g_Config.dwReNewNameColorTime);
    Config.WriteBool('Setup', 'ReNewChangeColor', g_Config.boReNewChangeColor);
    Config.WriteBool('Setup', 'ReNewLevelClearExp',
      g_Config.boReNewLevelClearExp);
{$IFEND}
    uModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonReNewLevelSaveClick');
  end;
end;

procedure TfrmFunctionConfig.EditReNewNameColor1Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditReNewNameColor1.Value;
    LabelReNewNameColor1.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.ReNewNameColor[0] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditReNewNameColor1Change');
  end;
end;

procedure TfrmFunctionConfig.EditReNewNameColor2Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditReNewNameColor2.Value;
    LabelReNewNameColor2.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.ReNewNameColor[1] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditReNewNameColor2Change');
  end;
end;

procedure TfrmFunctionConfig.EditReNewNameColor3Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditReNewNameColor3.Value;
    LabelReNewNameColor3.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.ReNewNameColor[2] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditReNewNameColor3Change');
  end;
end;

procedure TfrmFunctionConfig.EditReNewNameColor4Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditReNewNameColor4.Value;
    LabelReNewNameColor4.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.ReNewNameColor[3] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditReNewNameColor4Change');
  end;
end;

procedure TfrmFunctionConfig.EditReNewNameColor5Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditReNewNameColor5.Value;
    LabelReNewNameColor5.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.ReNewNameColor[4] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditReNewNameColor5Change');
  end;
end;

procedure TfrmFunctionConfig.EditReNewNameColor6Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditReNewNameColor6.Value;
    LabelReNewNameColor6.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.ReNewNameColor[5] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditReNewNameColor6Change');
  end;
end;

procedure TfrmFunctionConfig.EditReNewNameColor7Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditReNewNameColor7.Value;
    LabelReNewNameColor7.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.ReNewNameColor[6] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditReNewNameColor7Change');
  end;
end;

procedure TfrmFunctionConfig.EditReNewNameColor8Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditReNewNameColor8.Value;
    LabelReNewNameColor8.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.ReNewNameColor[7] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditReNewNameColor8Change');
  end;
end;

procedure TfrmFunctionConfig.EditReNewNameColor9Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditReNewNameColor9.Value;
    LabelReNewNameColor9.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.ReNewNameColor[8] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditReNewNameColor9Change');
  end;
end;

procedure TfrmFunctionConfig.EditReNewNameColor10Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditReNewNameColor10.Value;
    LabelReNewNameColor10.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.ReNewNameColor[9] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditReNewNameColor10Change');
  end;
end;

procedure TfrmFunctionConfig.EditReNewNameColorTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.dwReNewNameColorTime := EditReNewNameColorTime.Value * 1000;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditReNewNameColorTimeChange');
  end;
end;

procedure TfrmFunctionConfig.RefMonUpgrade();
begin
  try
    EditMonUpgradeColor1.Value := g_Config.SlaveColor[0];
    EditMonUpgradeColor2.Value := g_Config.SlaveColor[1];
    EditMonUpgradeColor3.Value := g_Config.SlaveColor[2];
    EditMonUpgradeColor4.Value := g_Config.SlaveColor[3];
    EditMonUpgradeColor5.Value := g_Config.SlaveColor[4];
    EditMonUpgradeColor6.Value := g_Config.SlaveColor[5];
    EditMonUpgradeColor7.Value := g_Config.SlaveColor[6];
    EditMonUpgradeColor8.Value := g_Config.SlaveColor[7];
    EditMonUpgradeColor9.Value := g_Config.SlaveColor[8];
    EditMonUpgradeKillCount1.Value := g_Config.MonUpLvNeedKillCount[0];
    EditMonUpgradeKillCount2.Value := g_Config.MonUpLvNeedKillCount[1];
    EditMonUpgradeKillCount3.Value := g_Config.MonUpLvNeedKillCount[2];
    EditMonUpgradeKillCount4.Value := g_Config.MonUpLvNeedKillCount[3];
    EditMonUpgradeKillCount5.Value := g_Config.MonUpLvNeedKillCount[4];
    EditMonUpgradeKillCount6.Value := g_Config.MonUpLvNeedKillCount[5];
    EditMonUpgradeKillCount7.Value := g_Config.MonUpLvNeedKillCount[6];
    EditMonUpLvNeedKillBase.Value := g_Config.nMonUpLvNeedKillBase;
    EditMonUpLvRate.Value := g_Config.nMonUpLvRate;

    CheckBoxMasterDieMutiny.Checked := g_Config.boMasterDieMutiny;
    EditMasterDieMutinyRate.Value := g_Config.nMasterDieMutinyRate;
    EditMasterDieMutinyPower.Value := g_Config.nMasterDieMutinyPower;
    EditMasterDieMutinySpeed.Value := g_Config.nMasterDieMutinySpeed;

    CheckBoxMasterDieMutinyClick(CheckBoxMasterDieMutiny);

    CheckBoxBBMonAutoChangeColor.Checked := g_Config.boBBMonAutoChangeColor;
    EditBBMonAutoChangeColorTime.Value := g_Config.dwBBMonAutoChangeColorTime div
      1000;
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.RefMonUpgrade');
  end;
end;

procedure TfrmFunctionConfig.ButtonMonUpgradeSaveClick(Sender: TObject);
{$IF SoftVersion <> VERDEMO}
var
  I: Integer;
{$IFEND}
begin
  try
{$IF SoftVersion <> VERDEMO}
    Config.WriteInteger('Setup', 'MonUpLvNeedKillBase',
      g_Config.nMonUpLvNeedKillBase);
    Config.WriteInteger('Setup', 'MonUpLvRate', g_Config.nMonUpLvRate);
    for I := Low(g_Config.MonUpLvNeedKillCount) to
      High(g_Config.MonUpLvNeedKillCount) do
    begin
      Config.WriteInteger('Setup', 'MonUpLvNeedKillCount' + IntToStr(I),
        g_Config.MonUpLvNeedKillCount[I]);
    end;

    for I := Low(g_Config.SlaveColor) to High(g_Config.SlaveColor) do
    begin
      Config.WriteInteger('Setup', 'SlaveColor' + IntToStr(I),
        g_Config.SlaveColor[I]);
    end;
    Config.WriteBool('Setup', 'MasterDieMutiny', g_Config.boMasterDieMutiny);
    Config.WriteInteger('Setup', 'MasterDieMutinyRate',
      g_Config.nMasterDieMutinyRate);
    Config.WriteInteger('Setup', 'MasterDieMutinyPower',
      g_Config.nMasterDieMutinyPower);
    Config.WriteInteger('Setup', 'MasterDieMutinyPower',
      g_Config.nMasterDieMutinySpeed);

    Config.WriteBool('Setup', 'BBMonAutoChangeColor',
      g_Config.boBBMonAutoChangeColor);
    Config.WriteInteger('Setup', 'BBMonAutoChangeColorTime',
      g_Config.dwBBMonAutoChangeColorTime);
{$IFEND}
    uModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonMonUpgradeSaveClick');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor1Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditMonUpgradeColor1.Value;
    LabelMonUpgradeColor1.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.SlaveColor[0] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeColor1Change');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor2Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditMonUpgradeColor2.Value;
    LabelMonUpgradeColor2.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.SlaveColor[1] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeColor2Change');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor3Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditMonUpgradeColor3.Value;
    LabelMonUpgradeColor3.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.SlaveColor[2] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeColor3Change');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor4Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditMonUpgradeColor4.Value;
    LabelMonUpgradeColor4.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.SlaveColor[3] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeColor4Change');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor5Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditMonUpgradeColor5.Value;
    LabelMonUpgradeColor5.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.SlaveColor[4] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeColor5Change');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor6Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditMonUpgradeColor6.Value;
    LabelMonUpgradeColor6.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.SlaveColor[5] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeColor6Change');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor7Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditMonUpgradeColor7.Value;
    LabelMonUpgradeColor7.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.SlaveColor[6] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeColor7Change');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor8Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditMonUpgradeColor8.Value;
    LabelMonUpgradeColor8.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.SlaveColor[7] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeColor8Change');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor9Change(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditMonUpgradeColor9.Value;
    LabelMonUpgradeColor9.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.SlaveColor[8] := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeColor9Change');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxReNewChangeColorClick(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boReNewChangeColor := CheckBoxReNewChangeColor.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxReNewChangeColorClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxReNewLevelClearExpClick(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boReNewLevelClearExp := CheckBoxReNewLevelClearExp.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxReNewLevelClearExpClick');
  end;
end;

procedure TfrmFunctionConfig.EditPKFlagNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditPKFlagNameColor.Value;
    LabelPKFlagNameColor.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.btPKFlagNameColor := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditPKFlagNameColorChange');
  end;
end;

procedure TfrmFunctionConfig.EditPKLevel1NameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditPKLevel1NameColor.Value;
    LabelPKLevel1NameColor.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.btPKLevel1NameColor := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditPKLevel1NameColorChange');
  end;
end;

procedure TfrmFunctionConfig.EditPKLevel2NameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditPKLevel2NameColor.Value;
    LabelPKLevel2NameColor.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.btPKLevel2NameColor := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditPKLevel2NameColorChange');
  end;
end;

procedure TfrmFunctionConfig.EditAllyAndGuildNameColorChange(
  Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditAllyAndGuildNameColor.Value;
    LabelAllyAndGuildNameColor.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.btAllyAndGuildNameColor := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditAllyAndGuildNameColorChange');
  end;
end;

procedure TfrmFunctionConfig.EditWarGuildNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditWarGuildNameColor.Value;
    LabelWarGuildNameColor.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.btWarGuildNameColor := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditWarGuildNameColorChange');
  end;
end;

procedure TfrmFunctionConfig.EditInFreePKAreaNameColorChange(
  Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditInFreePKAreaNameColor.Value;
    LabelInFreePKAreaNameColor.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.btInFreePKAreaNameColor := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditInFreePKAreaNameColorChange');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount1Change(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.MonUpLvNeedKillCount[0] := EditMonUpgradeKillCount1.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeKillCount1Change');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount2Change(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.MonUpLvNeedKillCount[1] := EditMonUpgradeKillCount2.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeKillCount2Change');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount3Change(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.MonUpLvNeedKillCount[2] := EditMonUpgradeKillCount3.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeKillCount3Change');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount4Change(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.MonUpLvNeedKillCount[3] := EditMonUpgradeKillCount4.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeKillCount4Change');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount5Change(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.MonUpLvNeedKillCount[4] := EditMonUpgradeKillCount5.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeKillCount5Change');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount6Change(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.MonUpLvNeedKillCount[5] := EditMonUpgradeKillCount6.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeKillCount6Change');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount7Change(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.MonUpLvNeedKillCount[6] := EditMonUpgradeKillCount7.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpgradeKillCount7Change');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpLvNeedKillBaseChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMonUpLvNeedKillBase := EditMonUpLvNeedKillBase.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpLvNeedKillBaseChange');
  end;
end;

procedure TfrmFunctionConfig.EditMonUpLvRateChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMonUpLvRate := EditMonUpLvRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonUpLvRateChange');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxMasterDieMutinyClick(Sender: TObject);
begin
  try
    if CheckBoxMasterDieMutiny.Checked then
    begin
      EditMasterDieMutinyRate.Enabled := True;
      EditMasterDieMutinyPower.Enabled := True;
      EditMasterDieMutinySpeed.Enabled := True;
    end
    else
    begin
      EditMasterDieMutinyRate.Enabled := False;
      EditMasterDieMutinyPower.Enabled := False;
      EditMasterDieMutinySpeed.Enabled := False;
    end;
    if not boOpened then
      exit;
    g_Config.boMasterDieMutiny := CheckBoxMasterDieMutiny.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxMasterDieMutinyClick');
  end;
end;

procedure TfrmFunctionConfig.EditMasterDieMutinyRateChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMasterDieMutinyRate := EditMasterDieMutinyRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMasterDieMutinyRateChange');
  end;
end;

procedure TfrmFunctionConfig.EditMasterDieMutinyPowerChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMasterDieMutinyPower := EditMasterDieMutinyPower.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMasterDieMutinyPowerChange');
  end;
end;

procedure TfrmFunctionConfig.EditMasterDieMutinySpeedChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMasterDieMutinySpeed := EditMasterDieMutinySpeed.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMasterDieMutinySpeedChange');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxBBMonAutoChangeColorClick(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boBBMonAutoChangeColor := CheckBoxBBMonAutoChangeColor.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxBBMonAutoChangeColorClick');
  end;
end;

procedure TfrmFunctionConfig.EditBBMonAutoChangeColorTimeChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.dwBBMonAutoChangeColorTime := EditBBMonAutoChangeColorTime.Value *
      1000;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditBBMonAutoChangeColorTimeChange');
  end;
end;

procedure TfrmFunctionConfig.RefSpiritMutiny();
begin
  try
    CheckBoxSpiritMutiny.Checked := g_Config.boSpiritMutiny;
    EditSpiritMutinyTime.Value := g_Config.dwSpiritMutinyTime div (60 * 1000);
    EditSpiritPowerRate.Value := g_Config.nSpiritPowerRate;
    CheckBoxSpiritMutinyClick(CheckBoxSpiritMutiny);
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.RefSpiritMutiny');
  end;
end;

procedure TfrmFunctionConfig.ButtonSpiritMutinySaveClick(Sender: TObject);
begin
  try
{$IF SoftVersion <> VERDEMO}
    Config.WriteBool('Setup', 'SpiritMutiny', g_Config.boSpiritMutiny);
    Config.WriteInteger('Setup', 'SpiritMutinyTime',
      g_Config.dwSpiritMutinyTime);
    Config.WriteInteger('Setup', 'SpiritPowerRate', g_Config.nSpiritPowerRate);
{$IFEND}
    uModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonSpiritMutinySaveClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxSpiritMutinyClick(Sender: TObject);
begin
  try
    if CheckBoxSpiritMutiny.Checked then
    begin
      EditSpiritMutinyTime.Enabled := True;
      //    EditSpiritPowerRate.Enabled:=True;
    end
    else
    begin
      EditSpiritMutinyTime.Enabled := False;
      EditSpiritPowerRate.Enabled := False;
    end;
    if not boOpened then
      exit;
    g_Config.boSpiritMutiny := CheckBoxSpiritMutiny.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxSpiritMutinyClick');
  end;
end;

procedure TfrmFunctionConfig.EditSpiritMutinyTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.dwSpiritMutinyTime := EditSpiritMutinyTime.Value * 60 * 1000;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditSpiritMutinyTimeChange');
  end;
end;

procedure TfrmFunctionConfig.EditSpiritPowerRateChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nSpiritPowerRate := EditSpiritPowerRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditSpiritPowerRateChange');
  end;
end;

procedure TfrmFunctionConfig.EditMagTammingLevelChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMagTammingLevel := EditMagTammingLevel.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMagTammingLevelChange');
  end;
end;

procedure TfrmFunctionConfig.EditMagTammingTargetLevelChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMagTammingTargetLevel := EditMagTammingTargetLevel.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMagTammingTargetLevelChange');
  end;
end;

procedure TfrmFunctionConfig.EditMagTammingHPRateChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMagTammingHPRate := EditMagTammingHPRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMagTammingHPRateChange');
  end;
end;

procedure TfrmFunctionConfig.EditTammingCountChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMagTammingCount := EditTammingCount.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditTammingCountChange');
  end;
end;

procedure TfrmFunctionConfig.EditMabMabeHitRandRateChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMabMabeHitRandRate := EditMabMabeHitRandRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMabMabeHitRandRateChange');
  end;
end;

procedure TfrmFunctionConfig.EditMabMabeHitMinLvLimitChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMabMabeHitMinLvLimit := EditMabMabeHitMinLvLimit.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMabMabeHitMinLvLimitChange');
  end;
end;

procedure TfrmFunctionConfig.EditMabMabeHitSucessRateChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMabMabeHitSucessRate := EditMabMabeHitSucessRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMabMabeHitSucessRateChange');
  end;
end;

procedure TfrmFunctionConfig.EditMabMabeHitMabeTimeRateChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMabMabeHitMabeTimeRate := EditMabMabeHitMabeTimeRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMabMabeHitMabeTimeRateChange');
  end;
end;

procedure TfrmFunctionConfig.RefMonSayMsg;
begin
  try
    CheckBoxMonSayMsg.Checked := g_Config.boMonSayMsg;
    CheckBoxMonShowLevel.Checked := g_Config.boMonShowLevel;
    EditMonLevelMsg.Text := g_Config.boMonShowLevelMsg;
    EditMonLevelMsg.Enabled := g_Config.boMonShowLevel;
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.RefMonSayMsg');
  end;
end;

procedure TfrmFunctionConfig.ButtonMonSayMsgSaveClick(Sender: TObject);
begin
  try
{$IF SoftVersion <> VERDEMO}
    Config.WriteBool('Setup', 'MonSayMsg', g_Config.boMonSayMsg);
    Config.WriteBool('Setup', 'MonShowLevel', g_Config.boMonShowLevel);
    Config.WriteString('Setup', 'MonShowLevelMsg', g_Config.boMonShowLevelMsg);
{$IFEND}
    uModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonMonSayMsgSaveClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxMonSayMsgClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boMonSayMsg := CheckBoxMonSayMsg.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxMonSayMsgClick');
  end;
end;

procedure TfrmFunctionConfig.RefWeaponMakeLuck;
begin
  try
    ScrollBarWeaponMakeUnLuckRate.Min := 1;
    ScrollBarWeaponMakeUnLuckRate.Max := 50;
    ScrollBarWeaponMakeUnLuckRate.Position := g_Config.nWeaponMakeUnLuckRate;

    ScrollBarWeaponMakeLuckPoint1.Min := 1;
    ScrollBarWeaponMakeLuckPoint1.Max := 10;
    ScrollBarWeaponMakeLuckPoint1.Position := g_Config.nWeaponMakeLuckPoint1;

    ScrollBarWeaponMakeLuckPoint2.Min := 1;
    ScrollBarWeaponMakeLuckPoint2.Max := 10;
    ScrollBarWeaponMakeLuckPoint2.Position := g_Config.nWeaponMakeLuckPoint2;

    ScrollBarWeaponMakeLuckPoint3.Min := 1;
    ScrollBarWeaponMakeLuckPoint3.Max := 10;
    ScrollBarWeaponMakeLuckPoint3.Position := g_Config.nWeaponMakeLuckPoint3;

    ScrollBarWeaponMakeLuckPoint2Rate.Min := 1;
    ScrollBarWeaponMakeLuckPoint2Rate.Max := 50;
    ScrollBarWeaponMakeLuckPoint2Rate.Position :=
      g_Config.nWeaponMakeLuckPoint2Rate;

    ScrollBarWeaponMakeLuckPoint3Rate.Min := 1;
    ScrollBarWeaponMakeLuckPoint3Rate.Max := 50;
    ScrollBarWeaponMakeLuckPoint3Rate.Position :=
      g_Config.nWeaponMakeLuckPoint3Rate;
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.RefWeaponMakeLuck');
  end;
end;

procedure TfrmFunctionConfig.ButtonWeaponMakeLuckDefaultClick(
  Sender: TObject);
begin
  try
    if Application.MessageBox('是否确认恢复默认设置？',
      '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then
    begin
      exit;
    end;
    g_Config.nWeaponMakeUnLuckRate := 20;
    g_Config.nWeaponMakeLuckPoint1 := 1;
    g_Config.nWeaponMakeLuckPoint2 := 3;
    g_Config.nWeaponMakeLuckPoint3 := 7;
    g_Config.nWeaponMakeLuckPoint2Rate := 6;
    g_Config.nWeaponMakeLuckPoint3Rate := 40;
    RefWeaponMakeLuck();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonWeaponMakeLuckDefaultClick');
  end;
end;

procedure TfrmFunctionConfig.ButtonWeaponMakeLuckSaveClick(
  Sender: TObject);
begin
  try
{$IF SoftVersion <> VERDEMO}
    Config.WriteInteger('Setup', 'WeaponMakeUnLuckRate',
      g_Config.nWeaponMakeUnLuckRate);
    Config.WriteInteger('Setup', 'WeaponMakeLuckPoint1',
      g_Config.nWeaponMakeLuckPoint1);
    Config.WriteInteger('Setup', 'WeaponMakeLuckPoint2',
      g_Config.nWeaponMakeLuckPoint2);
    Config.WriteInteger('Setup', 'WeaponMakeLuckPoint3',
      g_Config.nWeaponMakeLuckPoint3);
    Config.WriteInteger('Setup', 'WeaponMakeLuckPoint2Rate',
      g_Config.nWeaponMakeLuckPoint2Rate);
    Config.WriteInteger('Setup', 'WeaponMakeLuckPoint3Rate',
      g_Config.nWeaponMakeLuckPoint3Rate);
{$IFEND}
    uModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonWeaponMakeLuckSaveClick');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeUnLuckRateChange(
  Sender: TObject);
var
  nInteger: Integer;
begin
  try
    nInteger := ScrollBarWeaponMakeUnLuckRate.Position;
    EditWeaponMakeUnLuckRate.Text := IntToStr(nInteger);
    if not boOpened then
      exit;
    g_Config.nWeaponMakeUnLuckRate := nInteger;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarWeaponMakeUnLuckRateChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint1Change(
  Sender: TObject);
var
  nInteger: Integer;
begin
  try
    nInteger := ScrollBarWeaponMakeLuckPoint1.Position;
    EditWeaponMakeLuckPoint1.Text := IntToStr(nInteger);
    if not boOpened then
      exit;
    g_Config.nWeaponMakeLuckPoint1 := nInteger;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint1Change');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint2Change(
  Sender: TObject);
var
  nInteger: Integer;
begin
  try
    nInteger := ScrollBarWeaponMakeLuckPoint2.Position;
    EditWeaponMakeLuckPoint2.Text := IntToStr(nInteger);
    if not boOpened then
      exit;
    g_Config.nWeaponMakeLuckPoint2 := nInteger;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint2Change');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint2RateChange(
  Sender: TObject);
var
  nInteger: Integer;
begin
  try
    nInteger := ScrollBarWeaponMakeLuckPoint2Rate.Position;
    EditWeaponMakeLuckPoint2Rate.Text := IntToStr(nInteger);
    if not boOpened then
      exit;
    g_Config.nWeaponMakeLuckPoint2Rate := nInteger;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint2RateChange');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint3Change(
  Sender: TObject);
var
  nInteger: Integer;
begin
  try
    nInteger := ScrollBarWeaponMakeLuckPoint3.Position;
    EditWeaponMakeLuckPoint3.Text := IntToStr(nInteger);
    if not boOpened then
      exit;
    g_Config.nWeaponMakeLuckPoint3 := nInteger;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint3Change');
  end;
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint3RateChange(
  Sender: TObject);
var
  nInteger: Integer;
begin
  try
    nInteger := ScrollBarWeaponMakeLuckPoint3Rate.Position;
    EditWeaponMakeLuckPoint3Rate.Text := IntToStr(nInteger);
    if not boOpened then
      exit;
    g_Config.nWeaponMakeLuckPoint3Rate := nInteger;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint3RateChange');
  end;
end;

procedure TfrmFunctionConfig.EditHeroNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  try
    btColor := EditHeroNameColor.Value;
    LabeltHeroNameColor.Color := GetRGB(btColor);
    if not boOpened then
      exit;
    g_Config.nHeroNameColor := btColor;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditHeroNameColorChange');
  end;
end;

procedure TfrmFunctionConfig.ButtonHeroSaveClick(Sender: TObject);
begin
  try
    Config.WriteInteger('Setup', 'nHeroCallTick', g_Config.nHeroCallTick);
    Config.WriteInteger('Setup', 'nClearHeroGhostTick',g_Config.nClearHeroGhostTick);
    Config.WriteInteger('Setup', 'nHeroNameColor', g_Config.nHeroNameColor);
    Config.WriteInteger('Setup', 'nHeroKillMonExp', g_Config.nHeroKillMonExp);
    Config.WriteInteger('Setup', 'nHeroMagicBlazeTick',
      g_Config.nHeroMagicBlazeTick);
    Config.WriteInteger('Setup', 'nHeroWarrDefaultMagic',
      g_Config.nHeroWarrDefaultMagic);
    Config.WriteInteger('Setup', 'nWarrAttackTick', g_Config.nWarrAttackTick);
    Config.WriteInteger('Setup', 'nWizardAttackTick',
      g_Config.nWizardAttackTick);
    Config.WriteInteger('Setup', 'nTaosAttackTick', g_Config.nTaosAttackTick);
    Config.WriteInteger('Setup', 'nWarrWalkTime', g_Config.nWarrWalkTime);
    Config.WriteInteger('Setup', 'nWizardWalkTime', g_Config.nWizardWalkTime);
    Config.WriteInteger('Setup', 'nTaosWalkTime', g_Config.nTaosWalkTime);
    Config.WriteString('Setup', 'sHeroName', g_Config.sHeroName);
    Config.WriteString('Setup', 'sHeroNameSuffix', g_Config.sHeroNameSuffix);
    Config.WriteBool('Setup', 'bHeroPickUpItem', g_Config.bHeroPickUpItem);
    Config.WriteBool('Setup', 'bHeroAutoPoison', g_Config.bHeroAutoPoison);
    Config.WriteBool('Setup', 'bHeroAddWeaponSpeed',
      g_Config.bHeroAddWeaponSpeed);
    Config.WriteBool('Setup', 'bHeroKillManAddPK', g_Config.bHeroKillManAddPK);
    Config.WriteBool('Setup', 'bHeroUseBump', g_Config.bHeroUseBump);
    Config.WriteBool('Setup', 'bHeroShowMasterName',
      g_Config.bHeroShowMasterName);
    Config.WriteInteger('Setup', 'HeroFealtyCallDel',
      g_Config.nHeroFealtyCallDel);
    Config.WriteInteger('Setup', 'HeroFealtyDeathDel',
      g_Config.nHeroFealtyDeathDel);
    Config.WriteInteger('Setup', 'HeroFealtyExpAdd',
      g_Config.nHeroFealtyExpAdd);
    Config.WriteInteger('Setup', 'HeroFealtyExp', g_Config.nHeroFealtyExp);
    Config.WriteInteger('Setup', 'HeroFealtyCallAdd',
      g_Config.nHeroFealtyCallAdd);
    Config.WriteInteger('Setup', 'HeroFourMagic', g_Config.nHeroFourMagic);
    Config.WriteBool('Server','HeroExpMode',g_Config.boHeroExpMode);
    uModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.ButtonHeroSaveClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxHeroPickUpClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.bHeroPickUpItem := CheckBoxHeroPickUp.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxHeroPickUpClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxHeroAutoToxinClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.bHeroAutoPoison := CheckBoxHeroAutoToxin.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxHeroAutoToxinClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBox1Click(Sender: TObject);
begin
   try
    if not boOpened then
      exit;
    g_Config.boHeroExpMode := CheckBox1.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckHeroExpModeClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxAddWeaponPaceClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.bHeroAddWeaponSpeed := CheckBoxAddWeaponPace.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxAddWeaponPaceClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxHeroKillAddPKClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.bHeroKillManAddPK := CheckBoxHeroKillAddPK.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxHeroKillAddPKClick');
  end;
end;

procedure TfrmFunctionConfig.SpinEditBlazeTickTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nHeroMagicBlazeTick := SpinEditBlazeTickTime.Value * 1000;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditBlazeTickTimeChange');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxBumpClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.bHeroUseBump := CheckBoxBump.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxBumpClick');
  end;
end;

procedure TfrmFunctionConfig.RadioButtonAttackClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nHeroWarrDefaultMagic := 0;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.RadioButtonAttackClick');
  end;
end;

procedure TfrmFunctionConfig.RadioGroup1Click(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nChallengeGoldIndex:=Byte(RadioGroup1.ItemIndex);
  ModValue();
end;

procedure TfrmFunctionConfig.RadioButton2Click(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nHeroWarrDefaultMagic := 1;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.RadioButton2Click');
  end;
end;

procedure TfrmFunctionConfig.RadioButton3Click(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nHeroWarrDefaultMagic := 2;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.RadioButton3Click');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxHeroShowNameClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.bHeroShowMasterName := CheckBoxHeroShowName.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxHeroShowNameClick');
  end;
end;

procedure TfrmFunctionConfig.SpinEditWarrAkTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nWarrAttackTick := SpinEditWarrAkTime.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditWarrAkTimeChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditWizardAkTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nWizardAttackTick := SpinEditWizardAkTime.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditWizardAkTimeChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditTaosAkTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nTaosAttackTick := SpinEditTaosAkTime.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditTaosAkTimeChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditWarrWalkTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nWarrWalkTime := SpinEditWarrWalkTime.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditWarrWalkTimeChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditWizardWalkTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nWizardWalkTime := SpinEditWizardWalkTime.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditWizardWalkTimeChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditTaosWalkTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nTaosWalkTime := SpinEditTaosWalkTime.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditTaosWalkTimeChange');
  end;
end;

procedure TfrmFunctionConfig.EditHeroNameKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  try
    if not boOpened then
      exit;
    g_Config.sHeroName := EditHeroName.Text;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditHeroNameKeyDown');
  end;
end;

procedure TfrmFunctionConfig.EditHeroName2Change(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.sHeroNameSuffix := EditHeroName2.Text;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditHeroName2Change');
  end;
end;

procedure TfrmFunctionConfig.SpinEditHeroExpChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nHeroKillMonExp := SpinEditHeroExp.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditHeroExpChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditHeroCallTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nHeroCallTick := _Max(30, SpinEditHeroCallTime.Value) * 1000;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditHeroCallTimeChange');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxGroupMbAttackMonObjectClick(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boGroupMbAttackMonObject := CheckBoxGroupMbAttackMonObject.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxGroupMbAttackMonObjectClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxGroupMbAttackHeroObjectClick(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boGroupMbAttackHeroObject :=
      CheckBoxGroupMbAttackHeroObject.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxGroupMbAttackHeroObjectClick');
  end;
end;

procedure TfrmFunctionConfig.SpinEditSkillZZPowerRateChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nSkillZZPowerRate := SpinEditSkillZZPowerRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditSkillZZPowerRateChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditSkillZTPowerRateChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nSkillZTPowerRate := SpinEditSkillZTPowerRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditSkillZTPowerRateChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditSkillTTPowerRateChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nSkillTTPowerRate := SpinEditSkillTTPowerRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditSkillTTPowerRateChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditSkillZWPowerRateChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nSkillZWPowerRate := SpinEditSkillZWPowerRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditSkillZWPowerRateChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditSkillTWPowerRateChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nSkillTWPowerRate := SpinEditSkillTWPowerRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditSkillTWPowerRateChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditSkillWWPowerRateChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nSkillWWPowerRate := SpinEditSkillWWPowerRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditSkillWWPowerRateChange');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxAllowJointAttackClick(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boAllowJointAttack := CheckBoxAllowJointAttack.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxAllowJointAttackClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxAutoOpenShieldClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boAutoOpenShield := CheckBoxAutoOpenShield.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditEnergyStepUpRateChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nEnergyStepUpRate := SpinEditEnergyStepUpRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditEnergyStepUpRateChange');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxCloseShowHpClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boCloseShowHp := CheckBoxCloseShowHp.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxCloseShowHpClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxMonShowLevelClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boMonShowLevel := CheckBoxMonShowLevel.Checked;
    EditMonLevelMsg.Enabled := g_Config.boMonShowLevel;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxMonShowLevelClick');
  end;
end;

procedure TfrmFunctionConfig.EditMonLevelMsgChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boMonShowLevelMsg := EditMonLevelMsg.Text;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMonLevelMsgChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditHPStoneStartRateChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.HPStoneStartRate := SpinEditHPStoneStartRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditHPStoneStartRateChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditMPStoneStartRateChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.MPStoneStartRate := SpinEditMPStoneStartRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditMPStoneStartRateChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditHPStoneIntervalTimeChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.HPStoneIntervalTime := SpinEditHPStoneIntervalTime.Value * 1000;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditHPStoneIntervalTimeChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditMPStoneIntervalTimeChange(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.MPStoneIntervalTime := SpinEditMPStoneIntervalTime.Value * 1000;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditMPStoneIntervalTimeChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditHPStoneAddRateChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.HPStoneAddRate := SpinEditHPStoneAddRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditHPStoneAddRateChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditMPStoneAddRateChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.MPStoneAddRate := SpinEditMPStoneAddRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditMPStoneAddRateChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditHPStoneDecDuraChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.HPStoneDecDura := SpinEditHPStoneDecDura.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditHPStoneDecDuraChange');
  end;
end;

procedure TfrmFunctionConfig.SpinEditMPStoneDecDuraChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.MPStoneDecDura := SpinEditMPStoneDecDura.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.SpinEditMPStoneDecDuraChange');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxFastenAttackPlayObjectClick(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boFastenAttackPlayObject := CheckBoxFastenAttackPlayObject.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxFastenAttackPlayObjectClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxFastenAttackSlaveObjectClick(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boFastenAttackSlaveObject :=
      CheckBoxFastenAttackSlaveObject.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxFastenAttackSlaveObjectClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxFastenAttackHeroObjectClick(
  Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boFastenAttackHeroObject := CheckBoxFastenAttackHeroObject.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxFastenAttackHeroObjectClick');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxInfinityStorageClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boInfinityStorage := CheckBoxInfinityStorage.Checked;
    EditInfinityStorage.Enabled := not CheckBoxInfinityStorage.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxInfinityStorageClick');
  end;
end;

procedure TfrmFunctionConfig.EditFairyCountChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nFairyCount := EditFairyCount.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditFairyCountChange');
  end;
end;

procedure TfrmFunctionConfig.EditFairyDuntRateChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nFairyDuntRate := EditFairyDuntRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditFairyDuntRateChange');
  end;
end;

procedure TfrmFunctionConfig.EditFairyAttackRateChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nFairyAttackRate := EditFairyAttackRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditFairyAttackRateChange');
  end;
end;

procedure TfrmFunctionConfig.EditInfinityStorageChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditInfinityStorageChange');
  end;
end;

procedure TfrmFunctionConfig.EditMagicDeDingTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.dwMagicDeDingTime := EditMagicDeDingTime.Value * 1000;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditMagicDeDingTimeChange');
  end;
end;

procedure TfrmFunctionConfig.EditFireHitSkillTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nFireHitSkillTime := EditFireHitSkillTime.Value * 1000;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditFireHitSkillTimeChange');
  end;
end;

procedure TfrmFunctionConfig.EditTwinHitSkillRangeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nTwinHitSkillRange := EditTwinHitSkillRange.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditTwinHitSkillRangeChange');
  end;
end;

procedure TfrmFunctionConfig.EditLongSwordTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nLongSwordTime := EditLongSwordTime.Value * 1000;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditLongSwordTimeChange');
  end;
end;

procedure TfrmFunctionConfig.EditLongSwordRateChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nLongSwordRate := EditLongSwordRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.EditLongSwordRateChange');
  end;
end;

procedure TfrmFunctionConfig.CheckBoxOfflineSaveExpClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boOfflineSaveExp := CheckBoxOfflineSaveExp.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmFunctionConfig.CheckBoxOfflineSaveExpClick');
  end;
end;

procedure TfrmFunctionConfig.RefSelloff;
begin
  CheckBoxOpenSelfShop.Checked := g_Config.boOpenSelfShop;
  CheckBoxSafeZoneShop.Enabled := CheckBoxOpenSelfShop.Checked;
  CheckBoxMapShop.Enabled := CheckBoxOpenSelfShop.Checked;
  CheckBoxMapShop.Checked := g_Config.boMapShop;
  CheckBoxSafeZoneShop.Checked := g_Config.boSafeZoneShop;
  EditSellOffGoldTaxRate.Value := g_Config.nSellOffGoldTaxRate;
  EditSellOffGameGoldTaxRate.Value := g_Config.nSellOffGameGoldTaxRate;
  EditSellOffItemCount.Value := g_Config.nSellOffItemCount;
end;

procedure TfrmFunctionConfig.CheckBoxOpenSelfShopClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boOpenSelfShop := CheckBoxOpenSelfShop.Checked;
  ModValue();
  CheckBoxSafeZoneShop.Enabled := CheckBoxOpenSelfShop.Checked;
  CheckBoxMapShop.Enabled := CheckBoxOpenSelfShop.Checked;
end;

procedure TfrmFunctionConfig.CheckBoxMapShopClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boMapShop := CheckBoxMapShop.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxSafeZoneShopClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boSafeZoneShop := CheckBoxSafeZoneShop.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSellOffGoldTaxRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSellOffGoldTaxRate := EditSellOffGoldTaxRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSellOffGameGoldTaxRateChange(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSellOffGameGoldTaxRate := EditSellOffGameGoldTaxRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonSaveSellOffClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'OpenSelfShop', g_Config.boOpenSelfShop);
  Config.WriteBool('Setup', 'SafeZoneShop', g_Config.boSafeZoneShop);
  Config.WriteBool('Setup', 'MapShop', g_Config.boMapShop);

  Config.WriteInteger('Setup', 'SellOffGoldTaxRate',
    g_Config.nSellOffGoldTaxRate);
  Config.WriteInteger('Setup', 'SellOffGameGoldTaxRate',
    g_Config.nSellOffGameGoldTaxRate);
  Config.WriteInteger('Setup', 'SellOffItemCount', g_Config.nSellOffItemCount);

{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.CheckBoxCloneShowMasterClick(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boCloneShowMasterName := CheckBoxCloneShowMaster.Checked;
  ModValue();
end;

{}

procedure TfrmFunctionConfig.EditUenhancerTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nUenhancerTime := EditUenhancerTime.Value;
    ModValue();
  except
  end;
end;

procedure TfrmFunctionConfig.EditUenhancerRateChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nUenhancerRate := EditUenhancerRate.Value;
    ModValue();
  except
  end;
end;

procedure TfrmFunctionConfig.EditPlayCloneTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nPlayCloneTime := EditPlayCloneTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSellOffItemCountChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSellOffItemCount := EditSellOffItemCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditCallCloneTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nCallCloneTime := EditCallCloneTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxChangeMapCloseFireClick(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boChangeMapCloseFire := CheckBoxChangeMapCloseFire.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxPlayDethCloseFireClick(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boPlayDethCloseFire := CheckBoxPlayDethCloseFire.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxPlayGhostCloseFireClick(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boPlayGhostCloseFire := CheckBoxPlayGhostCloseFire.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxPlayObjectReduceMPClick(Sender: TObject);
begin
  if not boOpened then
    Exit;
  g_Config.boPlayObjectReduceMP := CheckBoxPlayObjectReduceMP.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditFireCrossMaxTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.dwFireCrossMaxTime := EditFireCrossMaxTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditTwinHitMaxCountChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nTwinHitMaxCount := EditTwinHitMaxCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditTwinHitCountChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nTwinHitCount := EditTwinHitCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditShieldTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nShieldTime := EditShieldTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditShieldTickChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nShieldTick := EditShieldTick.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditShieldAttackRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nShieldAttackRate := EditShieldAttackRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditShieldSmashRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nShieldSmashRate := EditShieldSmashRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxShieldYEDOClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boShieldYEDO := CheckBoxShieldYEDO.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxShieldErgumClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boShieldErgum := CheckBoxShieldErgum.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxShieldFireClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boShieldFire := CheckBoxShieldFire.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxShieldShowEffectClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boShieldShowEffect := CheckBoxShieldShowEffect.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxCheckBoxShieldLongClick(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boShieldLong := CheckBoxCheckBoxShieldLong.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.RadioShieldDrokClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boShieldAttackEff := 1;
  ModValue();
end;

procedure TfrmFunctionConfig.RadioShieldEggClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boShieldAttackEff := 2;
  ModValue();
end;

procedure TfrmFunctionConfig.RadioShieldNilClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boShieldAttackEff := 0;
  ModValue();
end;

procedure TfrmFunctionConfig.EditHeroFealtyCallAddChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nHeroFealtyCallAdd := EditHeroFealtyCallAdd.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditHeroFealtyExpChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nHeroFealtyExp := EditHeroFealtyExp.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditHeroFealtyExpAddChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nHeroFealtyExpAdd := EditHeroFealtyExpAdd.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditHeroFealtyDeathDelChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nHeroFealtyDeathDel := EditHeroFealtyDeathDel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditHeroFealtyCallDelChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nHeroFealtyCallDel := EditHeroFealtyCallDel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditHeroFourMagicChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nHeroFourMagic := EditHeroFourMagic.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxCloneMakeSlaveClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boCloneMakeSlave := CheckBoxCloneMakeSlave.Checked;
  ModValue();
end;

end.

