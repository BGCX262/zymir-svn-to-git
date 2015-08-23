//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit WShare;

interface
uses
  Classes, SysUtils, Graphics, Actor, StrUtils, Windows, grobal2, Share,
  INIFiles;

const
  DEBUGOPEN = 0;
  DEBUGCLOSE = 1;
  WGDEBUG = DEBUGCLOSE;

type
  TWGInfo = record
    boShowRedHPLable: Boolean; //显示血条
    boShowBlueMpLable: Boolean; //显示蓝条
    boShowHPNumber: Boolean; //数字显血
    boShowJobLevel: Boolean; //职业等级
    boDuraAlert: Boolean; //持久警告
    boMagicLock: Boolean; //魔法锁定
    boMagicFixupLock: Boolean; //锁定模式
    boAutoPuckUpItem: Boolean; //自动捡物
    boAutoPuckItemFil: Boolean; //捡取过滤
    boExpShowFil:Boolean;//经验显示经验
    boMoveRedShow: Boolean; //去血显示
    boParalyCan: Boolean; //防石化
    boShowAllItem: Boolean; //显示物品
    boShowAllItemFil: Boolean; //显示过滤
    boCanRunHuman: Boolean; //穿过人物
    boCanRunMon: Boolean; //穿过怪物
    boCanRunNpc: Boolean; //穿过NPC
    boShowTopInfo: Boolean; //项部信息
    boShowDura: Boolean; //显示持久
    boShowName: Boolean; //显示人名
    boShowAllName: Boolean; //显示全名
    boAutoMagic: Boolean; //自动练功
    nAutoMagicIdx: Integer; //技能键
    sAutoMagicName:String[12];//技能名称
    nAutoMagicTime: LongWord; //技能时间
    boShowGroupMember: Boolean; //队员显示
    coShowCropsColor: Byte; //特殊物品颜色
    boCropsItemShow: Boolean; //特殊变色显示
    boCropsItemHit: Boolean; //特殊物品提示
    boCanStartRun: Boolean; //免助跑
    boAutoDownDrup: Boolean; //自动放药
    boAutoOpenItem: Boolean; //自动解包
    boMoveSlow: Boolean; //免负重
    nHitTime: Byte; //攻击间隔
    nSpellTime: Byte; //魔法间隔
    nMoveTime: Byte; //移动间隔
    boAttackEffect: Boolean; //攻击效果
    boAttackEffectCls: Boolean; //攻击类型 True半月，False烈火
    boClearMapDieActor: Boolean; //清理战场
    nClearMapDieActorTime: LongWord; //清理间隔
    boFriendHit: Boolean; //好友提示
    boBlacklistHit: Boolean; //黑名单提示
    boBlackListSys: Boolean; //黑名单发言过滤
    boCropsMonHit: Boolean; //特殊怪物接近提示
    boCropsAutoLock: Boolean; //特殊怪物自动锁定
    boCropsChangeColor: Boolean; //特殊怪物变色显示
    nCropsColorEff: Byte; //颜色
    boCloseShift: Boolean; //免Shift
    boCanLongHit: Boolean; //刀刀刺杀
    boCanWideHit: Boolean; //智能半月
    boCanCrsHit: Boolean; //智能抱月
    boCanLongSword: Boolean; //智能开天斩
    boCanAutoFireHit: Boolean; //自动烈火
    boCanAutoLongFire:Boolean;//自动逐日剑法
    boCanFireSide: Boolean; //烈火近身
    boCanLeoShout: Boolean; //智能狮吼
    boCanShield: Boolean; //自动开盾
    boCanShieldCls: Boolean; //开盾类型
    boCanFirewind: Boolean; //接近抗拒
    boCanAutoAddHp: Boolean; //自动补血
    nCanAutoAddHpCount: Integer; //补血线
    dwCanAutoAddHpTick: LongWord; //补血间隔
    boCanAutoAmyounsul: Boolean; //自动放毒
    btCanAmyounsulCls: Byte; //放毒类型
    boCanCrossingOver: Boolean; //红绿毒互换
    boCanCloak: Boolean; //自动隐身
    boCanCloakCls: Boolean; //隐身类型
    boCanHolyShield: Boolean; //持续加防
    dwCanHolyShieldTick: LongWord;
    boCanDejiwonho: Boolean; //持续加魔
    dwCanDejiwonhoTick: LongWord;
    boCanAttack: Boolean; //持续加攻
    dwCanAttackTick: LongWord;
    boAutoHp: Boolean;
    boAutoHpName: string[14];
    boAutoHpTick: LongWord;
    boAutoHpCount: Integer;
    boAutoCropsHp: Boolean;
    boAutoCropsHpName: string[14];
    boAutoCropsHpTick: LongWord;
    boAutoCropsHpCount: Integer;
    boAutoMp: Boolean;
    boAutoMpName: string[14];
    boAutoMpTick: LongWord;
    boAutoMpCount: Integer;
    boAutoCropsMp: Boolean;
    boAutoCropsMpName: string[14];
    boAutoCropsMpTick: LongWord;
    boAutoCropsMpCount: Integer;
    boAutoHpProtect: Boolean;
    boAutoHpProtectName: string[14];
    boAutoHpProtectCount: Integer;
    boAutoHpOrotectTick: LongWord;
    boAutoDownHorse: Boolean;
    boHeroAutoMagic: Boolean;
    boHeroCallBoneFamm: Boolean;
    boHeroCallDogz: Boolean;
    boHeroCallFairy: Boolean;
    boCanLongHit2: Boolean;
    boDisableStruck: Boolean;
    wHeroMinHPTail:Word;//英雄低血逃跑
    boBacchusprotect:Boolean;
    boAutoDrink:Boolean;//自动饮酒
    boAutoDrinkCount:integer;
    boHeroAutoDrink:Boolean;//英雄自动饮酒
    boHeroAutoDrinkCount:integer;
    boHookKey:Boolean;//启动自定义热键
    bHookey1ShiftState:Byte;
    bHookey1key:Word;
    bHookey2ShiftState:Byte;
    bHookey2key:Word;
    bHookey3ShiftState:Byte;
    bHookey3key:Word;
    bHookey4ShiftState:Byte;
    bHookey4key:Word;
    bHookey5ShiftState:Byte;
    bHookey5key:Word;
    bHookey6ShiftState:Byte;
    bHookey6key:Word;
    bHookey7ShiftState:Byte;
    bHookey7key:Word;
  end;
  TItemFiltrate = record
    sItemName: string[16];
    boItemShow: Boolean;
    boItemPick: Boolean;
    boItemCorps: Boolean;
    boItemHit: Boolean;
  end;
  pTItemFiltrate = ^TItemFiltrate;
 (*
  TOpenItem = record
    sItemName: string[20];
    sBItemName: string[20];
    sHitTime: LongWord;
  end;
  pTOpenItem = ^TOpenItem;
  //移到了grobal2里定义
   *)
var
  LevelUseItem: array[0..13] of string = (
    '衣服',
    '武器',
    '配带',
    '项链',
    '头盔',
    '手镯',
    '手镯',
    '戒指',
    '戒指',
    '消耗品',
    '腰带',
    '靴子',
    '宝石',
    '斗笠'
    );
  CropsItem: array[0..6] of string[14] = (
    '随机传送卷', '地牢逃脱卷', '回城卷', '行会回城卷',
    '随机传送石', '盟重传送石', '比奇传送石'
    );

  g_ItemFiltrateList: TList;
  g_OpenItemArray:array of TOpenItem; //解包物品列表
//  g_OpenItemList: TList;
  g_CorpsMonList: TStringList;
  g_dwCanAutoAddHpTime: LongWord = 0;
  g_dwCanHolyShieldTime: LongWord = 0;
  g_dwCanDejiwonhoTime: LongWord = 0;
  g_dwCanAttackTime: LongWord = 0;
  g_dwAutoHpTick: LongWord = 0;
  g_dwAutoCropsHpTick: LongWord = 0;
  g_dwAutoMpTick: LongWord = 0;
  g_nAutoDrinkTick:LongWord = 0;
  g_nHeroAutoDrinkTick:LongWord = 0;
  g_dwAutoCropsMpTick: LongWord = 0;
  g_dwAutoHpOrotectTick: LongWord = 0;
  g_WgInfo: TWGInfo = (
    boShowRedHPLable: True;
    boShowBlueMpLable: True;
    boShowHPNumber: True;
    boShowJobLevel: False;
    boDuraAlert: True;
    boMagicLock: True;
    boMagicFixupLock: False;
    boAutoPuckUpItem: True;
    boAutoPuckItemFil: False;
    boExpShowFil:False;
    boMoveRedShow: True;
    boParalyCan: False;
    boShowAllItem: True;
    boShowAllItemFil: False;
    boCanRunHuman: False;
    boCanRunMon: False;
    boCanRunNpc: False;
    boShowTopInfo: False;
    boShowDura: False;
    boShowName: False;
    boShowAllName: False;
    boAutoMagic: False;
    nAutoMagicIdx: 0;
    sAutoMagicName:'';
    nAutoMagicTime: 5 * 1000;
    boShowGroupMember: False;
    coShowCropsColor: 249;
    boCropsItemShow: False;
    boCropsItemHit: True;
    boCanStartRun: True;
    boAutoDownDrup: True;
    boAutoOpenItem: True;
    boMoveSlow: True;
    nHitTime: 0;
    nSpellTime: 0;
    boAttackEffect: False;
    boAttackEffectCls: False;
    boClearMapDieActor: False;
    nClearMapDieActorTime: 10 * 1000;
    boFriendHit: True;
    boBlacklistHit: True;
    boBlackListSys: True;
    boCropsMonHit: False;
    boCropsAutoLock: False;
    boCropsChangeColor: False;
    nCropsColorEff: 9;
    boCloseShift: False;
    boCanLongHit: False;
    boCanWideHit: False;
    boCanCrsHit: False; //智能抱月
    boCanLongSword: False; //智能开天斩
    boCanAutoFireHit: False;
    boCanAutoLongFire:True;//自动逐日剑法
    boCanFireSide: False;
    boCanLeoShout: False;
    boCanShield: False;
    boCanShieldCls: False;
    boCanFirewind: False;
    boCanAutoAddHp: False;
    nCanAutoAddHpCount: 200;
    dwCanAutoAddHpTick: 4 * 1000;
    boCanAutoAmyounsul: False;
    btCanAmyounsulCls: 0;
    boCanCrossingOver: False;
    boCanCloak: False;
    boCanCloakCls: False;
    boCanHolyShield: False;
    dwCanHolyShieldTick: 200 * 1000;
    boCanDejiwonho: False;
    dwCanDejiwonhoTick: 200 * 1000;
    boCanAttack: False;
    dwCanAttackTick: 200 * 1000;
    boAutoHp: False;
    boAutoHpName: '';
    boAutoHpTick: 4 * 1000;
    boAutoHpCount: 200;
    boAutoCropsHp: False;
    boAutoCropsHpName: '';
    boAutoCropsHpTick: 1000;
    boAutoCropsHpCount: 200;
    boAutoMp: False;
    boAutoMpName: '';
    boAutoMpTick: 4 * 1000;
    boAutoMpCount: 80;
    boAutoCropsMp: False;
    boAutoCropsMpName: '';
    boAutoCropsMpTick: 1000;
    boAutoCropsMpCount: 80;
    boAutoHpProtect: False;
    boAutoHpProtectName: '';
    boAutoHpProtectCount: 100;
    boAutoHpOrotectTick: 10 * 1000;
    boAutoDownHorse: True;
    boHeroAutoMagic: True;
    boHeroCallBoneFamm: False;
    boHeroCallDogz: False;
    boHeroCallFairy: True;
    boCanLongHit2: False;
    boDisableStruck: True;
    wHeroMinHPTail:0;//英雄低血逃跑
    boBacchusprotect:False;
    boAutoDrink:False;//自动饮酒
    boAutoDrinkCount:10;
    boHeroAutoDrink:False;//英雄自动饮酒
    boHeroAutoDrinkCount:10;
    boHookKey:False;//启动自定义热键
    bHookey1ShiftState:0;
    bHookey1key:0;
    bHookey2ShiftState:0;
    bHookey2key:0;
    bHookey3ShiftState:0;
    bHookey3key:0;
    bHookey4ShiftState:0;
    bHookey4key:0;
    bHookey5ShiftState:0;
    bHookey5key:0;
    bHookey6ShiftState:0;
    bHookey6key:0;
    bHookey7ShiftState:0;
    bHookey7key:0;
    );
  WayTag: array[0..7] of string[2] = ('↑', '↗', '→', '↘', '↓', '↙',
    '←', '↖');
  WideAttack: array[0..2] of Integer = (7, 1, 2);

function GetFiltrateItem(sItemName: string): pTItemFiltrate;
function GetOpenItem(sItemName: string): string;
procedure ChangeShowItem(sIteName: string);
procedure GameNameHit(Actor: TActor);
function CheckBlockListSys(Ident: Integer; sMsg: string): Boolean;
procedure ChangeMonShow(sMonName: string; boFlag: Boolean);
function GetWideCount(): Integer;
procedure AutoAttckMagic(ident, x, y: integer);
procedure TaosAutoAmyounsul(nMagid: Integer);
procedure pAutoOpenItem(sName: string);
function GetUseAmulet(nClas: byte): TClientItem;
function GetItembyName(sName: string): Integer;
function GetDrinkItem:integer;
function GetHeroDrinkItem:integer;
function GetItembyNameEX(nClas:Integer): Integer;
function PlayEatItem(sName:string;nClas:Integer): Integer;
procedure GetHeroOpenItem(nCls: Integer);
procedure GetHeroEatItem(nCls: Integer);
function GetHeroItembyAniCount(nAniCount: Integer): Boolean;
procedure SaveWgInfo(sFileDir: string);
procedure LoadWgInfo(sFileDir: string);
procedure RefWgInfo();
implementation
uses MShare, CLMain, ClFunc, Hutil32, FrmWg, Fstate;

procedure RefWgInfo();
begin
  g_WgInfo.boShowRedHPLable := True; //显示血条
  g_WgInfo.boShowBlueMpLable := False; //显示蓝条
  g_WgInfo.boShowHPNumber := True; //数字显血
  g_WgInfo.boShowJobLevel := False; //职业等级
  g_WgInfo.boDuraAlert := False; //持久警告
  g_WgInfo.boMagicLock := True; //魔法锁定
  g_WgInfo.boMagicFixupLock := False; //锁定模式
  g_WgInfo.boAutoPuckUpItem := False; //自动捡物
  g_WgInfo.boAutoPuckItemFil := False; //捡取过滤
  g_WgInfo.boExpShowFil:=False;//经验显示过滤
  g_WgInfo.boMoveRedShow := False; //去血显示
  g_WgInfo.boParalyCan := False; //防石化
{$IF OEMVER   = 0}
  g_WgInfo.boShowAllItem := True; //显示物品
{$IFEND}
{$IF OEMVER   = 1}
  g_WgInfo.boShowAllItem := False; //显示物品
{$IFEND}
  g_WgInfo.boShowAllItemFil := False; //显示过滤
  g_WgInfo.boCanRunHuman := True; //穿过人物
  g_WgInfo.boCanRunMon := True; //穿过怪物
  g_WgInfo.boCanRunNpc := False; //穿过NPC
  g_WgInfo.boShowTopInfo := False; //项部信息
  g_WgInfo.boShowDura := False; //显示持久
  g_WgInfo.boShowName := False; //显示人名
  g_WgInfo.boShowAllName := False; //显示全名
  g_WgInfo.boAutoMagic := False; //自动练功
  g_WgInfo.nAutoMagicIdx := 0; //技能键
  g_WgInfo.sAutoMagicName:='';//自动练功持能名称
  g_WgInfo.nAutoMagicTime := 0; //技能时间
  g_WgInfo.boShowGroupMember := False; //队员显示
  //coShowCropsColor      :=;      //特殊物品颜色
  g_WgInfo.boCropsItemShow := False; //特殊变色显示
  g_WgInfo.boCropsItemHit := False; //特殊物品提示
  g_WgInfo.boCanStartRun := True; //免助跑
  g_WgInfo.boAutoDownDrup := True; //自动放药
  g_WgInfo.boAutoOpenItem := True; //自动解包
  g_WgInfo.boMoveSlow := True; //免负重
  g_WgInfo.nHitTime := 0; //攻击间隔
  g_WgInfo.nSpellTime := 0; //魔法间隔
  g_WgInfo.nMoveTime := 0; //移动间隔
  g_WgInfo.boAttackEffect := False; //攻击效果
  g_WgInfo.boAttackEffectCls := False; //攻击类型 True半月，False烈火
  g_WgInfo.boClearMapDieActor := False; //清理战场
  g_WgInfo.nClearMapDieActorTime := 0; //清理间隔
  g_WgInfo.boFriendHit := False; //好友提示
  g_WgInfo.boBlacklistHit := False; //黑名单提示
  g_WgInfo.boBlackListSys := True; //黑名单发言过滤
  g_WgInfo.boCropsMonHit := False; //特殊怪物接近提示
  g_WgInfo.boCropsAutoLock := False; //特殊怪物自动锁定
  g_WgInfo.boCropsChangeColor := False; //特殊怪物变色显示
  //nCropsColorEff        :=;      //颜色
  g_WgInfo.boCloseShift := False; //免Shift
  g_WgInfo.boCanLongHit := False; //刀刀刺杀
  g_WgInfo.boCanWideHit := False; //智能半月
  g_WgInfo.boCanCrsHit := False; //智能抱月
  g_WgInfo.boCanLongSword := False; //智能开天斩
  g_WgInfo.boCanAutoFireHit := False; //自动烈火
  g_WgInfo.boCanAutoLongFire:=True;//自动逐日剑法
  g_WgInfo.boCanFireSide := False; //烈火近身
  g_WgInfo.boCanLeoShout := False; //智能狮吼
  g_WgInfo.boCanShield := False; //自动开盾
  g_WgInfo.boCanShieldCls := False; //开盾类型
  g_WgInfo.boCanFirewind := False; //接近抗拒
  g_WgInfo.boCanAutoAddHp := False; //自动补血
  g_WgInfo.nCanAutoAddHpCount := 0; //补血线
  g_WgInfo.dwCanAutoAddHpTick := 0; //补血间隔
  g_WgInfo.boCanAutoAmyounsul := True; //自动放毒
  g_WgInfo.btCanAmyounsulCls := 0; //放毒类型
  g_WgInfo.boCanCrossingOver := True; //红绿毒互换
  g_WgInfo.boCanCloak := False; //自动隐身
  g_WgInfo.boCanCloakCls := False; //隐身类型
  g_WgInfo.boCanHolyShield := False; //持续加防
  g_WgInfo.boCanDejiwonho := False; //持续加魔
  g_WgInfo.boCanAttack := False; //持续加攻
  g_WgInfo.boAutoHp := False;
  g_WgInfo.boAutoHpCount := 10;
  g_WgInfo.boAutoCropsHp := False;
  g_WgInfo.boAutoCropsHpCount := 10;
  g_WgInfo.boAutoMp := False;
  g_WgInfo.boAutoMpCount := 10;
  g_WgInfo.boAutoCropsMp := False;
  g_WgInfo.boAutoCropsMpCount := 10;
  g_WgInfo.boAutoHpProtect := False;
  g_WgInfo.boAutoHpProtectCount := 10;
  g_WgInfo.boAutoDownHorse := True;
  g_WgInfo.boHeroAutoMagic := False;
  g_WgInfo.boHeroCallBoneFamm := False;
  g_WgInfo.boHeroCallDogz := False;
  g_WgInfo.boHeroCallFairy := True;
  g_WgInfo.boCanLongHit2 := False;
  g_WgInfo.boDisableStruck := True;
  g_WgInfo.wHeroMinHPTail:=0;//英雄低血逃跑
  g_WgInfo.boBacchusprotect:=False;
  g_WgInfo.boAutoDrink:=False;//自动饮酒
  g_WgInfo.boAutoDrinkCount:=10;
  g_WgInfo.boHeroAutoDrink:=False;//英雄自动饮酒
  g_WgInfo.boHeroAutoDrinkCount:=10;
  g_WgInfo.boHookKey:=False;//启动自定义热键
  g_WgInfo.bHookey1ShiftState:=0;
  g_WgInfo.bHookey1key:=0;
  g_WgInfo.bHookey2ShiftState:=0;
  g_WgInfo.bHookey2key:=0;
  g_WgInfo.bHookey3ShiftState:=0;
  g_WgInfo.bHookey3key:=0;
  g_WgInfo.bHookey4ShiftState:=0;
  g_WgInfo.bHookey4key:=0;
  g_WgInfo.bHookey5ShiftState:=0;
  g_WgInfo.bHookey5key:=0;
  g_WgInfo.bHookey6ShiftState:=0;
  g_WgInfo.bHookey6key:=0;
  g_WgInfo.bHookey7ShiftState:=0;
  g_WgInfo.bHookey7key:=0;
end;

procedure LoadWgInfo(sFileDir: string);
const
  IniClass = 'Assistant';
  IniClassSD = 'AssistantSD';
  sOpenItem = '%s'#9'%s';
  sItemFiltrate = '%s'#9'%s'#9'%s'#9'%s'#9'%s';
var
  INI: TINIFile;
  I: integer;
  ItemFiltrate: pTItemFiltrate;
  OpenItem: pTOpenItem;
  StrList: TStringList;
  Str, sName, n1, n2, n3, n4, sFileName: string;
begin
  try //程序自动增加
    if not (g_WgClass in [1, 2]) then
      exit;
{
    if g_WgClass = 1 then
    begin
      sFileName := JsDefInfo + GameAssistantDir;
      ini := TINIFile.Create(sFileName);
      try
        g_WgInfo.boAutoHpName := Ini.ReadString(IniClass, 'AutoHpName',
          g_WgInfo.boAutoHpName);
        g_WgInfo.boAutoMpName := Ini.ReadString(IniClass, 'AutoMpName',
          g_WgInfo.boAutoMpName);
        g_WgInfo.boAutoCropsHpName := Ini.ReadString(IniClass,
            'AutoCropsHpName', g_WgInfo.boAutoCropsHpName);
      finally
        Ini.Free;
      end;
    end;
    }
    sFileName := sFileDir + GameAssistantDir;
    if not FileExists(sFileName) then
    begin
      sFileName := JsDefInfo + GameAssistantDir;
    end;
    if FileExists(sFileName) then
    begin
      ini := TINIFile.Create(sFileName);
      try
        if g_WgClass = 1 then
        begin
          g_WgInfo.boDuraAlert := Ini.ReadBool(IniClassSD, 'DuraAlert',g_WgInfo.boDuraAlert);
          g_WgInfo.boAutoPuckUpItem := Ini.ReadBool(IniClassSD,'AutoPuckUpItem', g_WgInfo.boAutoPuckUpItem);
          g_WgInfo.boAutoPuckItemFil := Ini.ReadBool(IniClassSD,'AutoPuckItemFil', g_WgInfo.boAutoPuckItemFil);
          g_WgInfo.boExpShowFil := Ini.ReadBool(IniClassSD,'ExpShowFil', g_WgInfo.boExpShowFil);
          g_WgInfo.boCloseShift := Ini.ReadBool(IniClassSD, 'CloseShift',g_WgInfo.boCloseShift);
          g_WgInfo.boShowName := Ini.ReadBool(IniClassSD, 'ShowName',g_WgInfo.boShowName);
          g_WgInfo.boShowAllItem := Ini.ReadBool(IniClassSD,'ShowAllItem',g_WgInfo.boShowAllItem);
          g_WgInfo.boShowAllItemFil := Ini.ReadBool(IniClassSD,'ShowAllItemFil', g_WgInfo.boShowAllItemFil);
          g_WgInfo.boCanLongHit := Ini.ReadBool(IniClassSD, 'CanLongHit',g_WgInfo.boCanLongHit);
          g_WgInfo.boCanAutoFireHit := Ini.ReadBool(IniClassSD,'CanAutoFireHit', g_WgInfo.boCanAutoFireHit);
          g_WgInfo.boCanAutoLongFire := Ini.ReadBool(IniClassSD,'CanAutoLongFire', g_WgInfo.boCanAutoLongFire);
          g_WgInfo.boCanCloak := Ini.ReadBool(IniClassSD, 'CanCloak',g_WgInfo.boCanCloak);
          g_WgInfo.boCanWideHit := Ini.ReadBool(IniClassSD, 'CanWideHit',g_WgInfo.boCanWideHit);
          g_WgInfo.boCanShield := Ini.ReadBool(IniClassSD, 'CanShield',g_WgInfo.boCanShield);
          g_WgInfo.boAutoHp := Ini.ReadBool(IniClassSD, 'AutoHp',g_WgInfo.boAutoHp);
          g_WgInfo.boAutoHpTick := Ini.ReadInteger(IniClassSD, 'AutoHpTick',g_WgInfo.boAutoHpTick);
          g_WgInfo.boAutoHpCount := Ini.ReadInteger(IniClassSD, 'AutoHpCount',g_WgInfo.boAutoHpCount);
          g_WgInfo.boAutoCropsHp := Ini.ReadBool(IniClassSD, 'AutoCropsHp',g_WgInfo.boAutoCropsHp);
          g_WgInfo.boAutoCropsHpTick := Ini.ReadInteger(IniClassSD,'AutoCropsHpTick', g_WgInfo.boAutoCropsHpTick);
          g_WgInfo.boAutoCropsHpCount := Ini.ReadInteger(IniClassSD,'AutoCropsHpCount', g_WgInfo.boAutoCropsHpCount);
          g_WgInfo.boAutoMp := Ini.ReadBool(IniClassSD, 'AutoMp',g_WgInfo.boAutoMp);
          g_WgInfo.boAutoMpTick := Ini.ReadInteger(IniClassSD, 'AutoMpTick',g_WgInfo.boAutoMpTick);
          g_WgInfo.boAutoMpCount := Ini.ReadInteger(IniClassSD, 'AutoMpCount',g_WgInfo.boAutoMpCount);
          g_WgInfo.boAutoHpProtect := Ini.ReadBool(IniClassSD, 'AutoHpProtect',g_WgInfo.boAutoHpProtect);
          g_WgInfo.boAutoHpOrotectTick := Ini.ReadInteger(IniClassSD,'AutoHpOrotectTick', g_WgInfo.boAutoHpOrotectTick);
          g_WgInfo.boAutoHpProtectCount := Ini.ReadInteger(IniClassSD,'AutoHpProtectCount', g_WgInfo.boAutoHpProtectCount);
          g_WgInfo.boAutoHpProtectName:= Ini.ReadString(IniClassSD,'AutoHpProtectName',g_WgInfo.boAutoHpProtectName);
          g_WgInfo.sAutoMagicName:= Ini.ReadString(IniClassSD,'AutoMagicName',g_WgInfo.sAutoMagicName);
          g_WgInfo.nAutoMagicIdx := Ini.ReadInteger(IniClassSD, 'AutoMagicIdx',g_WgInfo.nAutoMagicIdx);
          g_WgInfo.wHeroMinHPTail := Ini.ReadInteger(IniClassSD, 'HeroMinHPTail',g_WgInfo.wHeroMinHPTail);//英雄低血逃跑
          g_WgInfo.boBacchusprotect := Ini.ReadBool(IniClassSD,'Bacchusprotect', g_WgInfo.boBacchusprotect);
          g_WgInfo.boAutoDrink:= Ini.ReadBool(IniClassSD,'AutoDrink', g_WgInfo.boAutoDrink);
          g_WgInfo.boAutoDrinkCount:= Ini.ReadInteger(IniClassSD,'AutoDrinkCount',g_WgInfo.boAutoDrinkCount);//自动饮酒
          g_WgInfo.boHeroAutoDrink:= Ini.ReadBool(IniClassSD,'HeroAutoDrink',g_WgInfo.boHeroAutoDrink);
          g_WgInfo.boHeroAutoDrinkCount:= Ini.ReadInteger(IniClassSD,'HeroAutoDrinkCount',g_WgInfo.boHeroAutoDrinkCount);//英雄自动饮酒
          g_WgInfo.boHeroCallBoneFamm := Ini.ReadBool(IniClassSD,'HeroCallBoneFamm', g_WgInfo.boHeroCallBoneFamm);
          g_WgInfo.boHeroCallDogz := Ini.ReadBool(IniClassSD,'HeroCallDogz',g_WgInfo.boHeroCallDogz);
          g_WgInfo.boHeroCallFairy := Ini.ReadBool(IniClassSD,'HeroCallFairy',g_WgInfo.boHeroCallFairy);
          g_WgInfo.boHookKey:= Ini.ReadBool(IniClassSD,'HookKey',g_WgInfo.boHookKey);
          g_WgInfo.bHookey1ShiftState:= Ini.ReadInteger(IniClassSD,'Hookey1ShiftState',g_WgInfo.bHookey1ShiftState);
          g_WgInfo.bHookey1key:= Ini.ReadInteger(IniClassSD,'Hookey1key',g_WgInfo.bHookey1key);
          g_WgInfo.bHookey2ShiftState:= Ini.ReadInteger(IniClassSD,'Hookey2ShiftState',g_WgInfo.bHookey2ShiftState);
          g_WgInfo.bHookey2key:= Ini.ReadInteger(IniClassSD,'Hookey2key',g_WgInfo.bHookey2key);
          g_WgInfo.bHookey3ShiftState:= Ini.ReadInteger(IniClassSD,'Hookey3ShiftState',g_WgInfo.bHookey3ShiftState);
          g_WgInfo.bHookey3key:= Ini.ReadInteger(IniClassSD,'Hookey3key',g_WgInfo.bHookey3key);
          g_WgInfo.bHookey4ShiftState:= Ini.ReadInteger(IniClassSD,'Hookey4ShiftState',g_WgInfo.bHookey4ShiftState);
          g_WgInfo.bHookey4key:= Ini.ReadInteger(IniClassSD,'Hookey4key',g_WgInfo.bHookey4key);
          g_WgInfo.bHookey5ShiftState:= Ini.ReadInteger(IniClassSD,'Hookey5ShiftState',g_WgInfo.bHookey5ShiftState);
          g_WgInfo.bHookey5key:= Ini.ReadInteger(IniClassSD,'Hookey5key',g_WgInfo.bHookey5key);
          g_WgInfo.bHookey6ShiftState:= Ini.ReadInteger(IniClassSD,'Hookey6ShiftState',g_WgInfo.bHookey6ShiftState);
          g_WgInfo.bHookey6key:= Ini.ReadInteger(IniClassSD,'Hookey6key',g_WgInfo.bHookey6key);
          g_WgInfo.bHookey7ShiftState:= Ini.ReadInteger(IniClassSD,'Hookey7ShiftState',g_WgInfo.bHookey7ShiftState);
          g_WgInfo.bHookey7key:= Ini.ReadInteger(IniClassSD,'Hookey7key',g_WgInfo.bHookey7key);
          for i := Low(CropsItem) to High(CropsItem) do
          begin
            if CropsItem[I] = g_WgInfo.boAutoHpProtectName then
            begin
              FrmDlg.DWgDown2.Tag := I;
              break;
            end;
          end;

        end
        else
        begin
          g_WgInfo.boShowRedHPLable := Ini.ReadBool(IniClass, 'ShowRedHPLable',g_WgInfo.boShowRedHPLable);
          g_WgInfo.boShowBlueMpLable := Ini.ReadBool(IniClass,'ShowBlueMpLable', g_WgInfo.boShowBlueMpLable);
          g_WgInfo.boShowHPNumber := Ini.ReadBool(IniClass, 'ShowHPNumber',g_WgInfo.boShowHPNumber);
          g_WgInfo.boDuraAlert := Ini.ReadBool(IniClass, 'DuraAlert',g_WgInfo.boDuraAlert);
          g_WgInfo.boMagicLock := Ini.ReadBool(IniClass, 'MagicLock',g_WgInfo.boMagicLock);
          g_WgInfo.boMagicFixupLock := Ini.ReadBool(IniClass, 'MagicFixupLock',g_WgInfo.boMagicFixupLock);
          g_WgInfo.boAutoPuckUpItem := Ini.ReadBool(IniClass, 'AutoPuckUpItem',g_WgInfo.boAutoPuckUpItem);
          g_WgInfo.boAutoPuckItemFil := Ini.ReadBool(IniClass, 'AutoPuckItemFil', g_WgInfo.boAutoPuckItemFil);
          g_WgInfo.boMoveRedShow := Ini.ReadBool(IniClass, 'MoveRedShow',g_WgInfo.boMoveRedShow);
          g_WgInfo.boParalyCan := Ini.ReadBool(IniClass, 'ParalyCan',g_WgInfo.boParalyCan);
          g_WgInfo.boShowAllItem := Ini.ReadBool(IniClass, 'ShowAllItem',g_WgInfo.boShowAllItem);
          g_WgInfo.boShowAllItemFil := Ini.ReadBool(IniClass, 'ShowAllItemFil',g_WgInfo.boShowAllItemFil);
          g_WgInfo.boCanRunHuman := Ini.ReadBool(IniClass, 'CanRunHuman',g_WgInfo.boCanRunHuman);
          g_WgInfo.boCanRunMon := Ini.ReadBool(IniClass, 'CanRunMon',g_WgInfo.boCanRunMon);
          g_WgInfo.boCanRunNpc := Ini.ReadBool(IniClass, 'CanRunNpc',g_WgInfo.boCanRunNpc);
          g_WgInfo.boShowTopInfo := Ini.ReadBool(IniClass, 'ShowTopInfo',g_WgInfo.boShowTopInfo);
          g_WgInfo.boShowDura := Ini.ReadBool(IniClass, 'ShowDura',g_WgInfo.boShowDura);
          g_WgInfo.boShowName := Ini.ReadBool(IniClass, 'ShowName',g_WgInfo.boShowName);
          g_WgInfo.boShowAllName := Ini.ReadBool(IniClass, 'ShowAllName',g_WgInfo.boShowAllName);
          g_WgInfo.boAutoMagic := Ini.ReadBool(IniClass, 'AutoMagic',g_WgInfo.boAutoMagic);
          g_WgInfo.nAutoMagicIdx := Ini.ReadInteger(IniClass,'AutoMagicIdx',g_WgInfo.nAutoMagicIdx);
          g_WgInfo.nAutoMagicTime := Ini.ReadInteger(IniClass,'AutoMagicTime',g_WgInfo.nAutoMagicTime);
          g_WgInfo.boShowGroupMember := Ini.ReadBool(IniClass,'ShowGroupMember', g_WgInfo.boShowGroupMember);
          g_WgInfo.coShowCropsColor := Ini.ReadInteger(IniClass,'ShowCropsColor', g_WgInfo.coShowCropsColor);
          g_WgInfo.boCropsItemShow := Ini.ReadBool(IniClass, 'CropsItemShow',g_WgInfo.boCropsItemShow);
          g_WgInfo.boCropsItemHit := Ini.ReadBool(IniClass, 'CropsItemHit',g_WgInfo.boCropsItemHit);
          g_WgInfo.boCanStartRun := Ini.ReadBool(IniClass, 'CanStartRun',g_WgInfo.boCanStartRun);
          g_WgInfo.boAutoDownDrup := Ini.ReadBool(IniClass, 'AutoDownDrup',g_WgInfo.boAutoDownDrup);
          g_WgInfo.boAutoOpenItem := Ini.ReadBool(IniClass, 'AutoOpenItem',g_WgInfo.boAutoOpenItem);
          g_WgInfo.boMoveSlow := Ini.ReadBool(IniClass, 'MoveSlow',g_WgInfo.boMoveSlow);
          g_WgInfo.nHitTime := Ini.ReadInteger(IniClass, 'HitTime', g_WgInfo.nHitTime);
          g_WgInfo.nSpellTime := Ini.ReadInteger(IniClass, 'SpellTime',g_WgInfo.nSpellTime);
          g_WgInfo.nMoveTime := Ini.ReadInteger(IniClass, 'MoveTime',g_WgInfo.nMoveTime);
          g_WgInfo.boAttackEffect := Ini.ReadBool(IniClass, 'AttackEffect',g_WgInfo.boAttackEffect);
          g_WgInfo.boAttackEffectCls := Ini.ReadBool(IniClass,'AttackEffectCls', g_WgInfo.boAttackEffectCls);
          g_WgInfo.boClearMapDieActor := Ini.ReadBool(IniClass,'ClearMapDieActor', g_WgInfo.boClearMapDieActor);
          g_WgInfo.nClearMapDieActorTime := Ini.ReadInteger(IniClass,'ClearMapDieActorTime', g_WgInfo.nClearMapDieActorTime);
          g_WgInfo.boFriendHit := Ini.ReadBool(IniClass, 'FriendHit',g_WgInfo.boFriendHit);
          g_WgInfo.boBlacklistHit := Ini.ReadBool(IniClass, 'BlacklistHit',g_WgInfo.boBlacklistHit);
          g_WgInfo.boBlackListSys := Ini.ReadBool(IniClass, 'BlackListSys',g_WgInfo.boBlackListSys);
          g_WgInfo.boCropsMonHit := Ini.ReadBool(IniClass, 'CropsMonHit',g_WgInfo.boCropsMonHit);
          g_WgInfo.boCropsAutoLock := Ini.ReadBool(IniClass, 'CropsAutoLock',g_WgInfo.boCropsAutoLock);
          g_WgInfo.boCropsChangeColor := Ini.ReadBool(IniClass,'CropsChangeColor', g_WgInfo.boCropsChangeColor);
          g_WgInfo.nCropsColorEff := Ini.ReadInteger(IniClass, 'CropsColorEff',g_WgInfo.nCropsColorEff);
          g_WgInfo.boCloseShift := Ini.ReadBool(IniClass, 'CloseShift',g_WgInfo.boCloseShift);
          g_WgInfo.boCanLongHit := Ini.ReadBool(IniClass, 'CanLongHit',g_WgInfo.boCanLongHit);
          g_WgInfo.boCanWideHit := Ini.ReadBool(IniClass, 'CanWideHit',g_WgInfo.boCanWideHit);
          g_WgInfo.boCanCrsHit := Ini.ReadBool(IniClass, 'CanCrsHit',g_WgInfo.boCanCrsHit);
          g_WgInfo.boCanLongSword := Ini.ReadBool(IniClass, 'CanLongSword',g_WgInfo.boCanLongSword);
          g_WgInfo.boCanAutoFireHit := Ini.ReadBool(IniClass, 'CanAutoFireHit',g_WgInfo.boCanAutoFireHit);
          g_WgInfo.boCanAutoLongFire := Ini.ReadBool(IniClass,'CanAutoLongFire', g_WgInfo.boCanAutoLongFire);
          g_WgInfo.boCanFireSide := Ini.ReadBool(IniClass, 'CanFireSide',g_WgInfo.boCanFireSide);
          g_WgInfo.boCanLeoShout := Ini.ReadBool(IniClass, 'CanLeoShout',g_WgInfo.boCanLeoShout);
          g_WgInfo.boCanShield := Ini.ReadBool(IniClass, 'CanShield',g_WgInfo.boCanShield);
          g_WgInfo.boCanShieldCls := Ini.ReadBool(IniClass, 'CanShieldCls',g_WgInfo.boCanShieldCls);
          g_WgInfo.boCanFirewind := Ini.ReadBool(IniClass, 'CanFirewind',g_WgInfo.boCanFirewind);
          g_WgInfo.boCanAutoAddHp := Ini.ReadBool(IniClass, 'CanAutoAddHp',g_WgInfo.boCanAutoAddHp);
          g_WgInfo.nCanAutoAddHpCount := Ini.ReadInteger(IniClass,'CanAutoAddHpCount', g_WgInfo.nCanAutoAddHpCount);
          g_WgInfo.dwCanAutoAddHpTick := Ini.ReadInteger(IniClass,'CanAutoAddHpTick', g_WgInfo.dwCanAutoAddHpTick);
          g_WgInfo.boCanAutoAmyounsul := Ini.ReadBool(IniClass,'CanAutoAmyounsul', g_WgInfo.boCanAutoAmyounsul);
          g_WgInfo.btCanAmyounsulCls := Ini.ReadInteger(IniClass,'CanAmyounsulCls', g_WgInfo.btCanAmyounsulCls);
          g_WgInfo.boCanCrossingOver := Ini.ReadBool(IniClass,'CanCrossingOver', g_WgInfo.boCanCrossingOver);
          g_WgInfo.boCanCloak := Ini.ReadBool(IniClass, 'CanCloak',g_WgInfo.boCanCloak);
          g_WgInfo.boCanCloakCls := Ini.ReadBool(IniClass, 'CanCloakCls',g_WgInfo.boCanCloakCls);
          g_WgInfo.boCanHolyShield := Ini.ReadBool(IniClass, 'CanHolyShield',g_WgInfo.boCanHolyShield);
          g_WgInfo.dwCanHolyShieldTick := Ini.ReadInteger(IniClass,'CanHolyShieldTick', g_WgInfo.dwCanHolyShieldTick);
          g_WgInfo.boCanDejiwonho := Ini.ReadBool(IniClass, 'CanDejiwonho',g_WgInfo.boCanDejiwonho);
          g_WgInfo.dwCanDejiwonhoTick := Ini.ReadInteger(IniClass,'CanDejiwonhoTick', g_WgInfo.dwCanDejiwonhoTick);
          g_WgInfo.boCanAttack := Ini.ReadBool(IniClass, 'CanAttack',g_WgInfo.boCanAttack);
          g_WgInfo.dwCanAttackTick := Ini.ReadInteger(IniClass, 'CanAttackTick',g_WgInfo.dwCanAttackTick);
          g_WgInfo.boAutoHp := Ini.ReadBool(IniClass, 'AutoHp', g_WgInfo.boAutoHp);
          g_WgInfo.boAutoHpName := Ini.ReadString(IniClass, 'AutoHpName',g_WgInfo.boAutoHpName);
          g_WgInfo.boAutoHpTick := Ini.ReadInteger(IniClass, 'AutoHpTick',g_WgInfo.boAutoHpTick);
          g_WgInfo.boAutoHpCount := Ini.ReadInteger(IniClass, 'AutoHpCount',g_WgInfo.boAutoHpCount);
          g_WgInfo.boAutoCropsHp := Ini.ReadBool(IniClass, 'AutoCropsHp',g_WgInfo.boAutoCropsHp);
          g_WgInfo.boAutoCropsHpName := Ini.ReadString(IniClass,'AutoCropsHpName', g_WgInfo.boAutoCropsHpName);
          g_WgInfo.boAutoCropsHpTick := Ini.ReadInteger(IniClass,'AutoCropsHpTick', g_WgInfo.boAutoCropsHpTick);
          g_WgInfo.boAutoCropsHpCount := Ini.ReadInteger(IniClass,'AutoCropsHpCount', g_WgInfo.boAutoCropsHpCount);
          g_WgInfo.boAutoMp := Ini.ReadBool(IniClass, 'AutoMp',g_WgInfo.boAutoMp);
          g_WgInfo.boAutoMpName := Ini.ReadString(IniClass, 'AutoMpName',g_WgInfo.boAutoMpName);
          g_WgInfo.boAutoMpTick := Ini.ReadInteger(IniClass, 'AutoMpTick',g_WgInfo.boAutoMpTick);
          g_WgInfo.boAutoMpCount := Ini.ReadInteger(IniClass, 'AutoMpCount',g_WgInfo.boAutoMpCount);
          g_WgInfo.boAutoCropsHp := Ini.ReadBool(IniClass, 'AutoCropsMp',g_WgInfo.boAutoCropsHp);
          g_WgInfo.boAutoCropsMpName := Ini.ReadString(IniClass,'AutoCropsMpName', g_WgInfo.boAutoCropsMpName);
          g_WgInfo.boAutoCropsMpTick := Ini.ReadInteger(IniClass,'AutoCropsMpTick', g_WgInfo.boAutoCropsMpTick);
          g_WgInfo.boAutoCropsMpCount := Ini.ReadInteger(IniClass,'AutoCropsMpCount', g_WgInfo.boAutoCropsMpCount);
          g_WgInfo.boAutoHpProtect := Ini.ReadBool(IniClass, 'AutoHpProtect',g_WgInfo.boAutoHpProtect);
          g_WgInfo.boAutoHpProtectName := Ini.ReadString(IniClass,'AutoHpProtectName', g_WgInfo.boAutoHpProtectName);
          g_WgInfo.boAutoHpOrotectTick := Ini.ReadInteger(IniClass,'AutoHpOrotectTick', g_WgInfo.boAutoHpOrotectTick);
          g_WgInfo.boAutoHpProtectCount := Ini.ReadInteger(IniClass,'AutoHpProtectCount', g_WgInfo.boAutoHpProtectCount);
          g_WgInfo.boAutoDownHorse := Ini.ReadBool(IniClass, 'AutoDownHorse',g_WgInfo.boAutoDownHorse);
          g_WgInfo.boHeroAutoMagic := Ini.ReadBool(IniClass, 'HeroAutoMagic',g_WgInfo.boHeroAutoMagic);
          //g_WgInfo.btHeroCallMobClass:=Ini.ReadInteger(IniClass,'HeroCallMobClass',g_WgInfo.btHeroCallMobClass);
          g_WgInfo.boHeroCallBoneFamm := Ini.ReadBool(IniClass,'HeroCallBoneFamm', g_WgInfo.boHeroCallBoneFamm);
          g_WgInfo.boHeroCallDogz := Ini.ReadBool(IniClass, 'HeroCallDogz',g_WgInfo.boHeroCallDogz);
          g_WgInfo.boHeroCallFairy := Ini.ReadBool(IniClass, 'HeroCallFairy',g_WgInfo.boHeroCallFairy);
          g_WgInfo.boCanLongHit2 := Ini.ReadBool(IniClass, 'CanLongHit2',g_WgInfo.boCanLongHit2);
          g_WgInfo.boDisableStruck := Ini.ReadBool(IniClass, 'DisableStruck',g_WgInfo.boDisableStruck);
        end;
      finally
        Ini.Free;
      end;
    end;
    sFileName := sFileDir + MonHintDir;
    if (not FileExists(sFileName)) or (g_WgClass = 1) then
    begin
      sFileName := JsDefInfo + MonHintDir;
    end;
    if FileExists(sFileName) then
    begin
      g_CorpsMonList.Clear;
      g_CorpsMonList.LoadFromFile(sFileName);
    end;
    sFileName := sFileDir + ItemUntieDir;
    if (not FileExists(sFileName)) or (g_WgClass = 1) then
    begin
      sFileName := JsDefInfo + ItemUntieDir;
    end;
   {
    if FileExists(sFileName) then
    begin
      StrList := TStringLIst.Create;
      try
        StrList.Clear;
        StrList.LoadFromFile(sFileName);
        for I := 0 to StrList.Count - 1 do
        begin
          Str := StrList.Strings[I];
          Str := GetValidStr3(Str, sName, [#9]);
          if (Str <> '') and (sName <> '') then
          begin
            New(OpenItem);
            OpenItem.sItemName := sName;
            OpenItem.sBItemName := Str;
            OpenItem.sHitTime := 0;
            g_OpenItemList.Add(OpenItem);
          end;
        end;
      finally
        StrList.Free;
      end;
    end;
    if g_OpenItemList.Count <= 0 then
    begin
      New(OpenItem);
      OpenItem.sItemName := '强效金创药';
      OpenItem.sBItemName := '超级金创药';
      OpenItem.sHitTime := 0;
      g_OpenItemList.Add(OpenItem);
      New(OpenItem);
      OpenItem.sItemName := '强效魔法药';
      OpenItem.sBItemName := '超级魔法药';
      OpenItem.sHitTime := 0;
      g_OpenItemList.Add(OpenItem);
    end;
    }
    sFileName := sFileDir + ItemFiltrateDir;
    if (not FileExists(sFileName)) or (g_WgClass = 1) then
    begin
      sFileName := JsDefInfo + ItemFiltrateDir;
    end;
    if FileExists(sFileName) then
    begin
      StrList := TStringList.Create;
      try
        StrList.Clear;
        StrList.LoadFromFile(sFileName);
        for I := 0 to StrList.Count - 1 do
        begin
          Str := StrList.Strings[I];
          Str := GetValidStr3(Str, sName, [#9]);
          Str := GetValidStr3(Str, n1, [#9]);
          Str := GetValidStr3(Str, n2, [#9]);
          Str := GetValidStr3(Str, n3, [#9]);
          if (sName <> '') and (n1 <> '') and (n2 <> '') and (n3 <> '') and (str
            <> '') then
          begin
            New(ItemFiltrate);
            with ItemFiltrate^ do
            begin
              sItemName := sName;
              if n1 = '1' then
                boItemShow := True
              else
                boItemShow := False;
              if n2 = '1' then
                boItemPick := True
              else
                boItemPick := False;
              if n3 = '1' then
                boItemCorps := True
              else
                boItemCorps := False;
              if str = '1' then
                boItemHit := True
              else
                boItemHit := False;
            end;
            g_ItemFiltrateList.Add(ItemFiltrate);
          end;
        end;
      finally
        StrList.Free;
      end;
    end;
    if Assigned(FormWgMain) then
      FormWgMain.RefWgBut;
  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.LoadWgInfo'); //程序自动增加
  end; //程序自动增加
end;

procedure SaveWgInfo(sFileDir: string);
const
  IniClass = 'Assistant';
  IniClassSD = 'AssistantSD';
  sOpenItem = '%s'#9'%s';
  sItemFiltrate = '%s'#9'%s'#9'%s'#9'%s'#9'%s';
var
  INI: TINIFile;
  I: integer;
  ItemFiltrate: pTItemFiltrate;
  OpenItem: pTOpenItem;
  StrList: TStringList;
  sName, s1, s2, s3, s4: string;
begin
  try //程序自动增加
    if not (g_WgClass in [1, 2]) then
      exit;
    Ini := TINIFile.Create(sFileDir + GameAssistantDir);
    try
      if g_WgClass = 1 then
      begin
        Ini.WriteBool(IniClassSD, 'DuraAlert', g_WgInfo.boDuraAlert);
        Ini.WriteBool(IniClassSD, 'AutoPuckUpItem', g_WgInfo.boAutoPuckUpItem);
        Ini.WriteBool(IniClassSD, 'AutoPuckItemFil',g_WgInfo.boAutoPuckItemFil);
        Ini.WriteBool(IniClassSD, 'ExpShowFil',g_WgInfo.boExpShowFil);
        Ini.WriteBool(IniClassSD, 'CloseShift', g_WgInfo.boCloseShift);
        Ini.WriteBool(IniClassSD, 'ShowName', g_WgInfo.boShowName);
        Ini.WriteBool(IniClassSD, 'ShowAllItem', g_WgInfo.boShowAllItem);
        Ini.WriteBool(IniClassSD, 'ShowAllItemFil', g_WgInfo.boShowAllItemFil);
        Ini.WriteBool(IniClassSD, 'CanLongHit', g_WgInfo.boCanLongHit);
        Ini.WriteBool(IniClassSD, 'CanAutoFireHit', g_WgInfo.boCanAutoFireHit);
        Ini.WriteBool(IniClassSD, 'CanAutoLongFire', g_WgInfo.boCanAutoLongFire);
        Ini.WriteBool(IniClassSD, 'CanCloak', g_WgInfo.boCanCloak);
        Ini.WriteBool(IniClassSD, 'CanWideHit', g_WgInfo.boCanWideHit);
        Ini.WriteBool(IniClassSD, 'CanShield', g_WgInfo.boCanShield);
        Ini.WriteBool(IniClassSD, 'AutoHp', g_WgInfo.boAutoHp);
     //   Ini.WriteString(IniClassSD, 'AutoHpName', g_WgInfo.boAutoHpName);
        Ini.WriteInteger(IniClassSD, 'AutoHpTick', g_WgInfo.boAutoHpTick);
        Ini.WriteInteger(IniClassSD, 'AutoHpCount', g_WgInfo.boAutoHpCount);
        Ini.WriteBool(IniClassSD, 'AutoCropsHp', g_WgInfo.boAutoCropsHp);
      //  Ini.WriteString(IniClassSD, 'AutoCropsHpName',g_WgInfo.boAutoCropsHpName);
        Ini.WriteInteger(IniClassSD, 'AutoCropsHpTick',g_WgInfo.boAutoCropsHpTick);
        Ini.WriteInteger(IniClassSD, 'AutoCropsHpCount',g_WgInfo.boAutoCropsHpCount);
        Ini.WriteBool(IniClassSD, 'AutoMp', g_WgInfo.boAutoMp);
     //   Ini.WriteString(IniClassSD, 'AutoMpName', g_WgInfo.boAutoMpName);
        Ini.WriteInteger(IniClassSD, 'AutoMpTick', g_WgInfo.boAutoMpTick);
        Ini.WriteInteger(IniClassSD, 'AutoMpCount', g_WgInfo.boAutoMpCount);
        Ini.WriteBool(IniClassSD, 'AutoCropsMp', g_WgInfo.boAutoCropsHp);
      //  Ini.WriteString(IniClassSD, 'AutoCropsMpName',g_WgInfo.boAutoCropsMpName);
      //  Ini.WriteInteger(IniClassSD, 'AutoCropsMpTick',g_WgInfo.boAutoCropsMpTick);
      //  Ini.WriteInteger(IniClassSD, 'AutoCropsMpCount',g_WgInfo.boAutoCropsMpCount);
        Ini.WriteBool(IniClassSD, 'AutoHpProtect', g_WgInfo.boAutoHpProtect);
        Ini.WriteBool(IniClassSD, 'Bacchusprotect', g_WgInfo.boBacchusprotect);
        Ini.WriteString(IniClassSD, 'AutoHpProtectName',g_WgInfo.boAutoHpProtectName);
        Ini.WriteString(IniClassSD, 'AutoMagicName',g_WgInfo.sAutoMagicName);
        Ini.WriteInteger(IniClassSD, 'AutoMagicIdx', g_WgInfo.nAutoMagicIdx);
        Ini.WriteInteger(IniClassSD, 'HeroMinHPTail', g_WgInfo.wHeroMinHPTail);
        Ini.WriteInteger(IniClassSD, 'AutoHpOrotectTick',g_WgInfo.boAutoHpOrotectTick);
        Ini.WriteInteger(IniClassSD, 'AutoHpProtectCount',g_WgInfo.boAutoHpProtectCount);
        Ini.WriteBool(IniClassSD, 'HeroCallBoneFamm',g_WgInfo.boHeroCallBoneFamm);
        Ini.WriteBool(IniClassSD, 'HeroCallDogz', g_WgInfo.boHeroCallDogz);
        Ini.WriteBool(IniClassSD, 'HeroCallFairy', g_WgInfo.boHeroCallFairy);
        Ini.WriteBool(IniClassSD,'AutoDrink',g_WgInfo.boAutoDrink);
        Ini.WriteInteger(IniClassSD,'AutoDrinkCount',g_WgInfo.boAutoDrinkCount);
        Ini.WriteBool(IniClassSD,'HeroAutoDrink',g_WgInfo.boHeroAutoDrink);
        Ini.WriteInteger(IniClassSD,'HeroAutoDrinkCount',g_WgInfo.boHeroAutoDrinkCount);
        Ini.WriteBool(IniClassSD,'HookKey',g_WgInfo.boHookKey);
        Ini.WriteInteger(IniClassSD,'Hookey1ShiftState',g_WgInfo.bHookey1ShiftState);
        Ini.WriteInteger(IniClassSD,'Hookey1key',g_WgInfo.bHookey1key);
        Ini.WriteInteger(IniClassSD,'Hookey2ShiftState',g_WgInfo.bHookey2ShiftState);
        Ini.WriteInteger(IniClassSD,'Hookey2key',g_WgInfo.bHookey2key);
        Ini.WriteInteger(IniClassSD,'Hookey3ShiftState',g_WgInfo.bHookey3ShiftState);
        Ini.WriteInteger(IniClassSD,'Hookey3key',g_WgInfo.bHookey3key);
        Ini.WriteInteger(IniClassSD,'Hookey4ShiftState',g_WgInfo.bHookey4ShiftState);
        Ini.WriteInteger(IniClassSD,'Hookey4key',g_WgInfo.bHookey4key);
        Ini.WriteInteger(IniClassSD,'Hookey5ShiftState',g_WgInfo.bHookey5ShiftState);
        Ini.WriteInteger(IniClassSD,'Hookey5key',g_WgInfo.bHookey5key);
        Ini.WriteInteger(IniClassSD,'Hookey6ShiftState',g_WgInfo.bHookey6ShiftState);
        Ini.WriteInteger(IniClassSD,'Hookey6key',g_WgInfo.bHookey6key);
        Ini.WriteInteger(IniClassSD,'Hookey7ShiftState',g_WgInfo.bHookey7ShiftState);
        Ini.WriteInteger(IniClassSD,'Hookey7key',g_WgInfo.bHookey7key);
      end
      else
      begin
        Ini.WriteBool(IniClass, 'ShowRedHPLable', g_WgInfo.boShowRedHPLable);
        Ini.WriteBool(IniClass, 'ShowBlueMpLable', g_WgInfo.boShowBlueMpLable);
        Ini.WriteBool(IniClass, 'ShowHPNumber', g_WgInfo.boShowHPNumber);
        Ini.WriteBool(IniClass, 'DuraAlert', g_WgInfo.boDuraAlert);
        Ini.WriteBool(IniClass, 'MagicLock', g_WgInfo.boMagicLock);
        Ini.WriteBool(IniClass, 'MagicFixupLock', g_WgInfo.boMagicFixupLock);
        Ini.WriteBool(IniClass, 'AutoPuckUpItem', g_WgInfo.boAutoPuckUpItem);
        Ini.WriteBool(IniClass, 'AutoPuckItemFil', g_WgInfo.boAutoPuckItemFil);
        Ini.WriteBool(IniClass, 'MoveRedShow', g_WgInfo.boMoveRedShow);
        Ini.WriteBool(IniClass, 'ParalyCan', g_WgInfo.boParalyCan);
        Ini.WriteBool(IniClass, 'ShowAllItem', g_WgInfo.boShowAllItem);
        Ini.WriteBool(IniClass, 'ShowAllItemFil', g_WgInfo.boShowAllItemFil);
        Ini.WriteBool(IniClass, 'CanRunHuman', g_WgInfo.boCanRunHuman);
        Ini.WriteBool(IniClass, 'CanRunMon', g_WgInfo.boCanRunMon);
        Ini.WriteBool(IniClass, 'CanRunNpc', g_WgInfo.boCanRunNpc);
        Ini.WriteBool(IniClass, 'ShowTopInfo', g_WgInfo.boShowTopInfo);
        Ini.WriteBool(IniClass, 'ShowDura', g_WgInfo.boShowDura);
        Ini.WriteBool(IniClass, 'ShowName', g_WgInfo.boShowName);
        Ini.WriteBool(IniClass, 'ShowAllName', g_WgInfo.boShowAllName);
        Ini.WriteBool(IniClass, 'AutoMagic', g_WgInfo.boAutoMagic);
        Ini.WriteInteger(IniClass, 'AutoMagicIdx', g_WgInfo.nAutoMagicIdx);
        Ini.WriteInteger(IniClass, 'AutoMagicTime', g_WgInfo.nAutoMagicTime);
        Ini.WriteBool(IniClass, 'ShowGroupMember', g_WgInfo.boShowGroupMember);
        Ini.WriteInteger(IniClass, 'ShowCropsColor', g_WgInfo.coShowCropsColor);
        Ini.WriteBool(IniClass, 'CropsItemShow', g_WgInfo.boCropsItemShow);
        Ini.WriteBool(IniClass, 'CropsItemHit', g_WgInfo.boCropsItemHit);
        Ini.WriteBool(IniClass, 'CanStartRun', g_WgInfo.boCanStartRun);
        Ini.WriteBool(IniClass, 'AutoDownDrup', g_WgInfo.boAutoDownDrup);
        Ini.WriteBool(IniClass, 'AutoOpenItem', g_WgInfo.boAutoOpenItem);
        Ini.WriteBool(IniClass, 'MoveSlow', g_WgInfo.boMoveSlow);
        Ini.WriteInteger(IniClass, 'HitTime', g_WgInfo.nHitTime);
        Ini.WriteInteger(IniClass, 'SpellTime', g_WgInfo.nSpellTime);
        Ini.WriteInteger(IniClass, 'MoveTime', g_WgInfo.nMoveTime);
        Ini.WriteBool(IniClass, 'AttackEffect', g_WgInfo.boAttackEffect);
        Ini.WriteBool(IniClass, 'AttackEffectCls', g_WgInfo.boAttackEffectCls);
        Ini.WriteBool(IniClass, 'ClearMapDieActor',g_WgInfo.boClearMapDieActor);
        Ini.WriteInteger(IniClass, 'ClearMapDieActorTime',g_WgInfo.nClearMapDieActorTime);
        Ini.WriteBool(IniClass, 'FriendHit', g_WgInfo.boFriendHit);
        Ini.WriteBool(IniClass, 'BlacklistHit', g_WgInfo.boBlacklistHit);
        Ini.WriteBool(IniClass, 'BlackListSys', g_WgInfo.boBlackListSys);
        Ini.WriteBool(IniClass, 'CropsMonHit', g_WgInfo.boCropsMonHit);
        Ini.WriteBool(IniClass, 'CropsAutoLock', g_WgInfo.boCropsAutoLock);
        Ini.WriteBool(IniClass, 'CropsChangeColor',g_WgInfo.boCropsChangeColor);
        Ini.WriteInteger(IniClass, 'CropsColorEff', g_WgInfo.nCropsColorEff);
        Ini.WriteBool(IniClass, 'CloseShift', g_WgInfo.boCloseShift);
        Ini.WriteBool(IniClass, 'CanLongHit', g_WgInfo.boCanLongHit);
        Ini.WriteBool(IniClass, 'CanWideHit', g_WgInfo.boCanWideHit);
        Ini.WriteBool(IniClass, 'CanCrsHit', g_WgInfo.boCanCrsHit);
        Ini.WriteBool(IniClass, 'CanLongSword', g_WgInfo.boCanLongSword);
        Ini.WriteBool(IniClass, 'CanAutoFireHit', g_WgInfo.boCanAutoFireHit);
        Ini.WriteBool(IniClass, 'CanAutoLongFire', g_WgInfo. boCanAutoLongFire);
        Ini.WriteBool(IniClass, 'CanFireSide', g_WgInfo.boCanFireSide);
        Ini.WriteBool(IniClass, 'CanLeoShout', g_WgInfo.boCanLeoShout);
        Ini.WriteBool(IniClass, 'CanShield', g_WgInfo.boCanShield);
        Ini.WriteBool(IniClass, 'CanShieldCls', g_WgInfo.boCanShieldCls);
        Ini.WriteBool(IniClass, 'CanFirewind', g_WgInfo.boCanFirewind);
        Ini.WriteBool(IniClass, 'CanAutoAddHp', g_WgInfo.boCanAutoAddHp);
        Ini.WriteInteger(IniClass, 'CanAutoAddHpCount',g_WgInfo.nCanAutoAddHpCount);
        Ini.WriteInteger(IniClass, 'CanAutoAddHpTick',g_WgInfo.dwCanAutoAddHpTick);
        Ini.WriteBool(IniClass, 'CanAutoAmyounsul',g_WgInfo.boCanAutoAmyounsul);
        Ini.WriteInteger(IniClass, 'CanAmyounsulCls',g_WgInfo.btCanAmyounsulCls);
        Ini.WriteBool(IniClass, 'CanCrossingOver', g_WgInfo.boCanCrossingOver);
        Ini.WriteBool(IniClass, 'CanCloak', g_WgInfo.boCanCloak);
        Ini.WriteBool(IniClass, 'CanCloakCls', g_WgInfo.boCanCloakCls);
        Ini.WriteBool(IniClass, 'CanHolyShield', g_WgInfo.boCanHolyShield);
        Ini.WriteInteger(IniClass, 'CanHolyShieldTick',g_WgInfo.dwCanHolyShieldTick);
        Ini.WriteBool(IniClass, 'CanDejiwonho', g_WgInfo.boCanDejiwonho);
        Ini.WriteInteger(IniClass, 'CanDejiwonhoTick',g_WgInfo.dwCanDejiwonhoTick);
        Ini.WriteBool(IniClass, 'CanAttack', g_WgInfo.boCanAttack);
        Ini.WriteInteger(IniClass, 'CanAttackTick', g_WgInfo.dwCanAttackTick);
        Ini.WriteBool(IniClass, 'AutoHp', g_WgInfo.boAutoHp);
        Ini.WriteString(IniClass, 'AutoHpName', g_WgInfo.boAutoHpName);
        Ini.WriteInteger(IniClass, 'AutoHpTick', g_WgInfo.boAutoHpTick);
        Ini.WriteInteger(IniClass, 'AutoHpCount', g_WgInfo.boAutoHpCount);
        Ini.WriteBool(IniClass, 'AutoCropsHp', g_WgInfo.boAutoCropsHp);
        Ini.WriteString(IniClass, 'AutoCropsHpName',g_WgInfo.boAutoCropsHpName);
        Ini.WriteInteger(IniClass, 'AutoCropsHpTick',g_WgInfo.boAutoCropsHpTick);
        Ini.WriteInteger(IniClass, 'AutoCropsHpCount',g_WgInfo.boAutoCropsHpCount);
        Ini.WriteBool(IniClass, 'AutoMp', g_WgInfo.boAutoMp);
        Ini.WriteString(IniClass, 'AutoMpName', g_WgInfo.boAutoMpName);
        Ini.WriteInteger(IniClass, 'AutoMpTick', g_WgInfo.boAutoMpTick);
        Ini.WriteInteger(IniClass, 'AutoMpCount', g_WgInfo.boAutoMpCount);
        Ini.WriteBool(IniClass, 'AutoCropsMp', g_WgInfo.boAutoCropsHp);
        Ini.WriteString(IniClass, 'AutoCropsMpName',g_WgInfo.boAutoCropsMpName);
        Ini.WriteInteger(IniClass, 'AutoCropsMpTick',g_WgInfo.boAutoCropsMpTick);
        Ini.WriteInteger(IniClass, 'AutoCropsMpCount',g_WgInfo.boAutoCropsMpCount);
        Ini.WriteBool(IniClass, 'AutoHpProtect', g_WgInfo.boAutoHpProtect);
        Ini.WriteString(IniClass, 'AutoHpProtectName',g_WgInfo.boAutoHpProtectName);
        Ini.WriteInteger(IniClass, 'AutoHpOrotectTick',g_WgInfo.boAutoHpOrotectTick);
        Ini.WriteInteger(IniClass, 'AutoHpProtectCount',g_WgInfo.boAutoHpProtectCount);
        Ini.WriteBool(IniClass, 'AutoDownHorse', g_WgInfo.boAutoDownHorse);
        Ini.WriteBool(IniClass, 'HeroAutoMagic', g_WgInfo.boHeroAutoMagic);
        //Ini.WriteInteger(IniClass,'HeroCallMobClass',g_WgInfo.btHeroCallMobClass);
        Ini.WriteBool(IniClass, 'HeroCallBoneFamm',g_WgInfo.boHeroCallBoneFamm);
        Ini.WriteBool(IniClass, 'HeroCallDogz', g_WgInfo.boHeroCallDogz);
        Ini.WriteBool(IniClass, 'HeroCallFairy', g_WgInfo.boHeroCallFairy);
        Ini.WriteBool(IniClass, 'CanLongHit2', g_WgInfo.boCanLongHit2);
        Ini.WriteBool(IniClass, 'DisableStruck', g_WgInfo.boDisableStruck);
      end;
    finally
      Ini.Free;
    end;
    StrList := TStringList.Create;
    try
      try
        if g_CorpsMonList.Count > 0 then
          g_CorpsMonList.SaveToFile(sFileDir + MonHintDir);
      except
      end;
    {
      try
        StrList.Clear;
        for I := 0 to g_OpenItemList.Count - 1 do
        begin
          OpenItem := g_OpenItemList.Items[I];
          StrList.Add(Format(sOpenItem, [OpenItem.sItemName,
            OpenItem.sBItemName]));
        end;
        if StrList.Count > 0 then
          StrList.SaveToFile(sFileDir + ItemUntieDir);
      except
      end;
      }
      try
        StrList.Clear;
        for I := 0 to g_ItemFiltrateList.Count - 1 do
        begin
          ItemFiltrate := g_ItemFiltrateList.Items[I];
          sName := ItemFiltrate.sItemName;
          if ItemFiltrate.boItemShow then
            s1 := '1'
          else
            s1 := '0';
          if ItemFiltrate.boItemPick then
            s2 := '1'
          else
            s2 := '0';
          if ItemFiltrate.boItemCorps then
            s3 := '1'
          else
            s3 := '0';
          if ItemFiltrate.boItemHit then
            s4 := '1'
          else
            s4 := '0';
          StrList.Add(Format(sItemFiltrate, [sName, s1, s2, s3, s4]));
        end;
        if StrList.Count > 0 then
          StrList.SaveToFile(sFileDir + ItemFiltrateDir);
      except
      end;
    finally
      StrList.Clear;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.SaveWgInfo'); //程序自动增加
  end; //程序自动增加
end;

procedure GetHeroEatItem(nCls: Integer);
var
  I: integer;
  boEat: Boolean;
begin
  try //程序自动增加
    boeat := False;
    for I := MAXBAGITEMCL - 1 downto 0 do
    begin
      if (g_HeroItemArr[I].S.Name <> '') and
        (g_HeroItemArr[I].S.StdMode = 0) then
      begin
        if (g_HeroItemArr[I].S.AC > 0) and (nCls = 1) then
        begin
          FrmMain.HeroEatItem(I);
          boeat := True;
          break;
        end
        else if (g_HeroItemArr[I].S.Mac > 0) and (nCls = 2) then
        begin
          FrmMain.HeroEatItem(I);
          boeat := True;
          break;
        end;
      end;
    end;
    if not boEat then
      GetHeroOpenItem(nCls);
  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.GetHeroEatItem'); //程序自动增加
  end; //程序自动增加
end;

function GetHeroItembyAniCount(nAniCount: Integer): Boolean;
var
  I: integer;
begin
  try //程序自动增加
    Result := False;
    for I := MAXBAGITEMCL - 1 downto 0 do
    begin
      if (g_HeroItemArr[I].S.Name <> '') and
        (g_HeroItemArr[I].S.StdMode = 0) and
        (g_HeroItemArr[I].S.AniCount = nAniCount) then
      begin
        Result := True;
        break;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.GetHeroItembyAniCount');
    //程序自动增加
  end; //程序自动增加
end;

procedure GetHeroOpenItem(nCls: Integer);
var
  I: integer;
  boEat: Boolean;
begin
  try //程序自动增加
    boEat := False;
    for I := MAXBAGITEMCL - 1 downto 0 do
    begin
      if (g_HeroItemArr[I].S.Name <> '') and
        (g_HeroItemArr[I].S.StdMode = 31) and
        (g_HeroItemArr[I].S.AniCount in [1..3]) then
      begin
        if not GetHeroItembyAniCount(g_HeroItemArr[I].S.Shape) then
        begin
          //DScreen.AddHitMsg (g_HeroItemArr[I].S.Name);
          FrmMain.HeroEatItem(I);
          boEat := True;
          Break;
        end;
      end;
    end;
    if not boEat then
    begin
      case nCls of
        1:
        begin
          if (g_HeroEatingItem.S.Name = '') And ((g_HeroAbil.HP / g_HeroAbil.maxHP
          * 100) < 20) then
          DScreen.AddHitMsg('英雄的HP类药品已经用完。');
        end;
        2:
        begin
          If (g_HeroEatingItem.S.Name = '') And ((g_HeroAbil.MP / g_HeroAbil.maxMP
          * 100) < 10) Then
           DScreen.AddHitMsg('英雄的Mp类药品已经用完。');
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.GetHeroOpenItem'); //程序自动增加
  end; //程序自动增加
end;

//自动解包

procedure pAutoOpenItem(sName: string);
var
  II: integer;
  OpenItemName: string;
begin
  try
    OpenItemName := GetOpenItem(sName);
    if OpenItemName <> '' then
    begin
      for II := 0 to MAXBAGITEMCL - 1 do
      begin
        if CompareText(g_ItemArr[II].S.Name, OpenItemName) = 0 then
        begin
          FrmMain.EatOpenItem(II);
          break;
        end;
      end;
    end;
  except
    DebugOutStr('[Exception] UnWShare.pAutoOpenItem'); //程序自动增加
  end;
end;

function GetItembyName(sName: string): Integer;
var
  I: integer;
begin
  try //程序自动增加
    Result := -1;
    for I := MAXBAGITEMCL - 1 downto 0 do
    begin
      if g_ItemArr[I].S.Name = sName then
      begin
        Result := I;
        break;
      end;
    end;

  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.GetItembyName'); //程序自动增加
  end; //程序自动增加
end;

function GetDrinkItem:integer;
var
  I: integer;
begin
  try //程序自动增加
    Result := -1;
    for I := MAXBAGITEMCL - 1 downto 0 do
    begin
      if (g_ItemArr[I].S.Name<>'') and (g_ItemArr[I].S.StdMode=60) then
      begin
        Result := I;
        break;
      end;
    end;

  except //程序自动增加
    DebugOutStr('[Exception]  GetDrinkItem'); //程序自动增加
  end; //程序自动增加
end;

function GetHeroDrinkItem:integer;
var
  I: integer;
begin
  try //程序自动增加
    Result := -1;
    for I := MAXBAGITEMCL - 1 downto 0 do
    begin
      if (g_HeroItemArr[I].S.Name<>'') and (g_HeroItemArr[I].S.StdMode=60) then
      begin
        Result := I;
        break;
      end;
    end;

  except //程序自动增加
    DebugOutStr('[Exception]  GetHeroDrinkItem'); //程序自动增加
  end; //程序自动增加
end;

//ncals 1 hp 2 mp 3特殊药品
function GetItembyNameEX(nClas:Integer): Integer;
var
  I: integer;
begin
  try //程序自动增加
    Result := -1;
    for I := MAXBAGITEMCL - 1 downto 0 do
    begin
      if (g_ItemArr[I].S.Name <> '') and (g_ItemArr[I].S.StdMode=0) then
      begin
        case nClas of
         1:
          begin
            if (g_ItemArr[I].S.AC>0) and (g_ItemArr[I].S.Shape<>1) then
             begin
               Result := I;
               break;
            end;
          end;
         2:
          begin
            if (g_ItemArr[I].S.MAC>0) and (g_ItemArr[I].S.Shape<>1) then
             begin
               Result := I;
               break;
            end;
          end;
          3:
          begin
            if (g_ItemArr[I].S.AC>0) and (g_ItemArr[I].S.Shape=1) then
             begin
               Result := I;
               break;
            end;
          end;
         end;
      end;
    end;

  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.GetItembyNameEX'); //程序自动增加
  end; //程序自动增加
end;

//ncals 1 hp 2 mp 3特殊药品
function PlayEatItem(sName:string;nClas:Integer): Integer;
function GetItembyAniCount(nAniCount: Integer): Integer;
var
  I: integer;
begin
  try
    Result := -1;
    for I := MAXBAGITEMCL - 1 downto 0 do
    begin
      if (g_ItemArr[i].S.Name <> '') and
        (g_ItemArr[i].S.StdMode = 31) and
        (g_ItemArr[i].S.AniCount = nAniCount) then
      begin
        Result := i;
        break;
      end;
    end;
  except
    DebugOutStr('[Exception] UnWShare.GetItembyAniCount');
  end;
end;
procedure SetwgInfo(sName:string;nClas:Integer);
begin
  case nClas of
  1:g_wgInfo.boAutoHpName:=sName;
  2:g_wgInfo.boAutoMpName:=sName;
  3:g_wgInfo.boAutoCropsHpName:=sName;
  end;
end;
var
  II: integer;
begin
  try
      Result := -1;
     if sName='' then
     begin //吃药名称为空的
      ii:=GetItembyNameEX(nClas); //按类型取包里药品
      if II>-1 then
      begin
       SetwgInfo(g_ItemArr[II].S.Name,nClas); //设置吃药名称
       FrmMain.EatItem(II);//吃药
       Result:=II;
      end else
      begin
         ii:=GetItembyAniCount(nClas); //取打包物品
         if II>-1 then
         begin
            FrmMain.EatOpenItem(II);//解包
            Result:=II;
         end;
      end;
     end else
     begin //已经设置了吃药名称的
        II := GetItembyName(sname); //查找包里有没有指定的药
        If II > -1 Then
        begin
          FrmMain.EatItem(II);//吃药
          Result:=II;
        end
        Else
        begin
           SetwgInfo('',nClas);//清空自动吃药的名称
           PlayEatItem('',nClas);
        end;
     end;
  except
    DebugOutStr('[Exception] UnWShare.PlayEatItem'); //程序自动增加
  end;
end;
//取符、毒，5为符，2为绿毒，3为红毒
function GetUseAmulet(nClas: byte): TClientItem;
var
  I: integer;
  Item: TClientItem;
begin
  try //程序自动增加
    //if nClas<>
    FillChar(Item, SizeOf(TClientItem), #0);
    for I := MAXBAGITEMCL - 1 downto 0 do
    begin
      if (g_ItemArr[I].S.Name <> '') and
        (g_ItemArr[I].S.StdMode = 25) and
        (g_ItemArr[I].S.Shape = nClas) and
        (g_ItemArr[I].Dura >= 100) then
      begin
        Item := g_ItemArr[I];
        g_ItemArr[I].S.Name := '';
        //DScreen.AddHitMsg (Item.S.Name);
        break;
      end;
    end;
    Result := Item;
  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.GetUseAmulet'); //程序自动增加
  end; //程序自动增加
end;

procedure TaosAutoAmyounsul(nMagid: Integer);
resourcestring
  sTest1 = '你的[%s]已经用完。';
var
  Item: TClientItem;
  nFlg: Byte;
  II: integer;
begin
  try //程序自动增加
    if (g_MySelf = nil) or (g_WaitingUseItem.Item.S.Name <> '') then
      exit;
    FillChar(Item, SizeOf(TClientItem), #0);
    case nMagid of
      6, 38:
        begin //用毒
          if g_wgInfo.boCanCrossingOver then
            Inc(g_wgInfo.btCanAmyounsulCls);
          if g_wgInfo.btCanAmyounsulCls > 1 then
            g_wgInfo.btCanAmyounsulCls := 0;
          nFlg := g_wgInfo.btCanAmyounsulCls + 1;
          if (g_UseItems[U_BUJUK].S.Name = '') or
            (g_UseItems[U_BUJUK].S.StdMode <> 25) or
            (g_UseItems[U_BUJUK].S.Shape <> nFlg) or
            (g_UseItems[U_BUJUK].Dura < 100) then
          begin
            Item := GetUseAmulet(nFlg);
            if Item.S.Name = '' then
            begin
              if nFlg = 1 then
                DScreen.AddHitMsg(Format(sTest1, ['灰色药粉']))
              else
                DScreen.AddHitMsg(Format(sTest1, ['黄色药粉']));
            end;
          end;
        end;
      13..19, 30, 52, 53:
        begin //用符
          if (g_UseItems[U_BUJUK].S.StdMode = 25) and
            (g_UseItems[U_BUJUK].S.Shape = 5) and
            (g_UseItems[U_BUJUK].Dura <= 100) then
            pAutoOpenItem(g_UseItems[U_BUJUK].S.Name);
          //护身符如果是最后一张就先解包
          if (g_UseItems[U_BUJUK].S.Name = '') or
            (g_UseItems[U_BUJUK].S.StdMode <> 25) or
            (g_UseItems[U_BUJUK].S.Shape <> 5) or
            (g_UseItems[U_BUJUK].Dura < 100) then
          begin
            Item := GetUseAmulet(5);
            if Item.S.Name = '' then
              DScreen.AddHitMsg(Format(sTest1, ['护身符']));
          end;
        end;
    end;
    //DScreen.AddHitMsg (Format(sTest1,[Item.S.Name]));
    if Item.S.Name <> '' then
    begin
      g_WaitingUseItem.Item := Item;
      g_WaitingUseItem.Index := U_BUJUK;
      g_WaitingUseItem.Hero := False;
      FrmMain.SendTakeOnItem(U_BUJUK, Item.MakeIndex, Item.S.Name);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.TaosAutoAmyounsul'); //程序自动增加
  end; //程序自动增加
end;

procedure AutoAttckMagic(ident, x, y: integer);
begin
  try //程序自动增加
    if (g_MySelf <> nil) and
      (abs(g_MySelf.m_nCurrX - X) <= 2) and
      (abs(g_MySelf.m_nCurrY - Y) <= 2) then
    begin
      if (g_wgInfo.boCanShield) and //接近魔法盾
      (g_WgInfo.boCanShieldCls) and
        (g_MyMagic[31] <> nil) and
        (g_MySelf.m_nState and $00100000 {STATE_BUBBLEDEFENCEUP} = 0) and
        (g_MySelf.m_Abil.MP > 20) and
        (GetTickCount - g_dwLatestSpellTick > g_dwSpellTime) then
      begin
        g_dwLatestSpellTick := GetTickCount;
        g_dwMagicDelayTime := 0;
        FrmMain.UseMagic(g_nMouseX, g_nMouseY, g_MyMagic[31]);
      end
      else if (g_WgInfo.boCanFirewind) and //接近抗拒火环
      (g_MyMagic[8] <> nil) and
        (g_MySelf.m_Abil.MP > 10) and
        (abs(g_MySelf.m_nCurrX - X) <= 1) and
        (abs(g_MySelf.m_nCurrY - Y) <= 1) and
        (GetTickCount - g_dwLatestSpellTick > g_dwSpellTime) then
      begin
        g_dwLatestSpellTick := GetTickCount;
        g_dwMagicDelayTime := 0;
        FrmMain.UseMagic(g_nMouseX, g_nMouseY, g_MyMagic[8]);
      end
      else if (g_Wginfo.boCanCloak) and //接近隐身
      (g_wgInfo.boCanCloakCls) and
        (g_MySelf.m_Abil.MP > 10) and
        (g_MyMagic[18] <> nil) and
        (g_MySelf.m_nState and $00800000 = 0) and
        ((GetTickCount - g_dwLatestSpellTick) > g_dwSpellTime) then
      begin
        g_dwLatestSpellTick := GetTickCount;
        g_dwMagicDelayTime := 0;
        FrmMain.UseMagic(g_nMouseX, g_nMouseY, g_MyMagic[18]);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.AutoAttckMagic'); //程序自动增加
  end; //程序自动增加
end;

function GetWideCount(): Integer;
var
  nC, n10, nX, nY: Integer;
  Actor: TActor;
begin
  try //程序自动增加
    Result := 0;
    nC := 0;
    while (True) do
    begin
      n10 := (g_MySelf.m_btDir + WideAttack[nC]) mod 8;
      if GetNextPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, n10, 1, nX, nY)
        then
      begin
        Actor := PlayScene.FindActorXY(nx, ny);
        if (Actor <> nil) and (not Actor.m_boDeath) then
          Inc(Result);
      end;
      Inc(nC);
      if nC >= 3 then
        break;
    end;
    {Result:=0;
    nC:=0;
    while (True) do begin
      n10:=(m_btDirection + g_Config.WideAttack[nC]) mod 8;
      if m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,n10,1,nX,nY) then begin
        BaseObject:=m_PEnvir.GetMovingObject(nX,nY,True);
        if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
          Inc(Result);
        end;
      end;
      Inc(nC);
      if nC >= 3 then break;
    end;   }
  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.GetWideCount'); //程序自动增加
  end; //程序自动增加
end;

procedure ChangeMonShow(sMonName: string; boFlag: Boolean);
var
  Actor: TActor;
  i: integer;
begin
  try //程序自动增加
    for I := 0 to PlayScene.m_ActorList.Count - 1 do
    begin
      Actor := TActor(PlayScene.m_ActorList.Items[I]);
      if Actor <> nil then
        if CompareText(sMonName, Actor.m_sUserName) = 0 then
          Actor.m_boChangeEff := boFlag;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.ChangeMonShow'); //程序自动增加
  end; //程序自动增加
end;

function CheckBlockListSys(Ident: Integer; sMsg: string): Boolean;
var
  I: integer;
  sUserName: string;
begin
  try //程序自动增加
    Result := True;
    case Ident of
      SM_HEAR,
        SM_GROUPMESSAGE,
        SM_GUILDMESSAGE:
        begin
          GetValidStr3(sMsg, sUserName, [':']);
        end;
      SM_CRY:
        begin
          GetValidStr3(sMsg, sUserName, [':']);
          sUserName := RightStr(sUserName, Length(sUserName) - 3);
        end;
      SM_WHISPER: GetValidStr3(sMsg, sUserName, ['=']);
    end;
    if sUserName <> '' then
    begin
      i := g_MyBlacklist.IndexOf(sUserName);
      if I > -1 then
        Result := False;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.CheckBlockListSys'); //程序自动增加
  end; //程序自动增加
end;

procedure GameNameHit(Actor: TActor);
resourcestring
  sFTest = '你的好友[%s]出现在坐标(%d:%d)，方向%s';
  sBTest = '你的敌人[%s]出现在坐标(%d:%d)，方向%s';
  sMTest = '[%s]出现在坐标(%d:%d)，方向%s';
var
  I: integer;
begin
  try //程序自动增加
    if (g_MySelf = nil) or (Actor = nil) then
      exit;
    i := -1;
    if Actor.m_btRace = 0 then
    begin
      if g_WgInfo.boFriendHit then
      begin
        i := g_MyFriendList.IndexOf(Actor.m_sUserName);
        if i > -1 then
        begin
          with Actor do
            DScreen.AddChatBoardString(Format(sFTest, [m_sUserName, m_nCurrX,
              m_nCurrY, WayTag[GetNextDirection(g_MySelf.m_nCurrX,
                g_MySelf.m_nCurrY, m_nCurrX, m_nCurrY)]]),
                clBlue,
              clWhite);
        end;
      end;
      if g_WgInfo.boBlacklistHit then
      begin
        i := g_MyBlacklist.IndexOf(Actor.m_sUserName);
        if i > -1 then
        begin
          with Actor do
            DScreen.AddChatBoardString(Format(sBTest, [m_sUserName, m_nCurrX,
              m_nCurrY, WayTag[GetNextDirection(g_MySelf.m_nCurrX,
                g_MySelf.m_nCurrY, m_nCurrX, m_nCurrY)]]),
                clRed,
              clWhite);
        end;
      end;
    end
    else
    begin
      i := g_CorpsMonList.IndexOf(Actor.m_sUserName);
      if I > -1 then
      begin
        Actor.m_boChangeEff := True;
        if g_WgInfo.boCropsMonHit then
        begin
          with Actor do
            DScreen.AddChatBoardString(Format(sMTest, [m_sUserName, m_nCurrX,
              m_nCurrY, WayTag[GetNextDirection(g_MySelf.m_nCurrX,
                g_MySelf.m_nCurrY, m_nCurrX, m_nCurrY)]]),
                clRed,
              clWhite);
        end;
        if g_WgInfo.boCropsAutoLock then
          g_MagicLockActor := Actor;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.GameNameHit'); //程序自动增加
  end; //程序自动增加
end;

function GetFiltrateItem(sItemName: string): pTItemFiltrate;
var
  ItemFiltrate: pTItemFiltrate;
  I: integer;
begin
  try //程序自动增加
    Result := nil;
    for I := 0 to g_ItemFiltrateList.Count - 1 do
    begin
      ItemFiltrate := g_ItemFiltrateList.Items[I];
      if CompareText(sItemName, ItemFiltrate.sItemName) = 0 then
      begin
        Result := ItemFiltrate;
        break;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.GetFiltrateItem'); //程序自动增加
  end; //程序自动增加
end;

function GetOpenItem(sItemName: string): string;
var
  I: integer;
  OpenItem: pTOpenItem;
begin
  try //程序自动增加
    Result := '';
    for I := 0 to High(g_OpenItemArray) do
    begin
      OpenItem := @g_OpenItemArray[I];
      if CompareText(sItemName, OpenItem.sItemName) = 0 then
      begin
        Result := OpenItem.sBItemName;
        break;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.GetOpenItem'); //程序自动增加
  end; //程序自动增加
end;

procedure ChangeShowItem(sIteName: string);
var
  I: integer;
  DropItem: PTDropItem;
  ItemFiltrate: pTItemFiltrate;
begin
  try //程序自动增加
    for I := 0 to g_DropedItemList.Count - 1 do
    begin
      DropItem := g_DropedItemList.Items[I];
      if CompareText(sIteName, DropItem.Name) = 0 then
      begin
        ItemFiltrate := GetFiltrateItem(sIteName);
        DropItem.boItemPick := ItemFiltrate.boItemPick;
        DropItem.boItemShow := ItemFiltrate.boItemShow;
        DropItem.boItemCorps := ItemFiltrate.boItemCorps;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] UnWShare.ChangeShowItem'); //程序自动增加
  end; //程序自动增加
end;

initialization
  begin
    g_ItemFiltrateList := TList.Create;
 //   g_OpenItemList := TList.Create;
    g_CorpsMonList := TStringList.Create;
  end;

finalization
  begin
    g_ItemFiltrateList.Free;
 //   g_OpenItemList.Free;
    g_CorpsMonList.Free;
  end;

end.

