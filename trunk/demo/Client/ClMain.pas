unit ClMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXDraws, DirectX, DXClass, DrawScrn, IntroScn, PlayScn, MapUnit, WIL, Grobal2,
  Actor, DIB, StdCtrls, CliUtil, ExtCtrls, HUtil32, EdCode,
  DWinCtl, ClFunc, magiceff, SoundUtil, DXSounds, clEvent, Wave, IniFiles,
  JSocket;

const
   BO_FOR_TEST = True;
   EnglishVersion = TRUE;
   BoNeedPatch = TRUE;

   LocalLanguage: TImeMode = imChinese;
   //SERVERADDR: string = '211.174.174.130'; //'194.153.73.54'; //'210.121.143.205';
   //TESTSERVERADDR = '211.174.174.250';
   //kornetworldaddress = '211.48.62.250'; //ÄÚ³Ý¿ùµå
   SERVERADDR: string = '127.0.0.1'; //'194.153.73.54'; //'210.121.143.205';
   TESTSERVERADDR = '127.0.0.1';
   kornetworldaddress = '127.0.0.1'; //ÄÚ³Ý¿ùµå
   NEARESTPALETTEINDEXFILE = 'Data\npal.idx';

   SCREENWIDTH = 800;
   SCREENHEIGHT = 600;
   MAXBAGITEMCL = 52;
   ENEMYCOLOR = 69;

   MAXFONT = 8;
   FontArr: array[0..MAXFONT-1] of string = (
                'ËÎÌå',
                'Courier New',
                'MS Sans Serif',
                'Microsoft Sans Serif',
                'Courier New',
                'Arial',
                'MS Sans Serif',
                'Microsoft Sans Serif');

   CurFont: integer = 0;
   CurFontName: string = 'ËÎÌå';

type
  TKornetWorld = record
    CPIPcode:  string;
    SVCcode:   string;
    LoginID:   string;
    CheckSum:  string;
  end;

  TOneClickMode = (toNone, toKornetWorld);
  TTimerCommand = (tcSoftClose, tcReSelConnect, tcFastQueryChr, tcQueryItemPrice);
  TChrAction = (caWalk, caRun, caHit, caSpell, caSitdown);
  TConnectionStep = (cnsLogin, cnsSelChr, cnsReSelChr, cnsPlay);
  TMovingItem = record
    Index: integer; //ItemArr Index
    Item: TClientItem;
  end;
  PTMovingItem = ^TMovingItem;

  TFrmMain = class(TDxForm)
    CSocket: TClientSocket;
    Timer1: TTimer;
    MouseTimer: TTimer;
    WaitMsgTimer: TTimer;
    SelChrWaitTimer: TTimer;
    CmdTimer: TTimer;
    MinTimer: TTimer;
    SpeedHackTimer: TTimer;
    WProgUse: TWMImages;
    DWinMan: TDWinManager;
    WMagic: TWMImages;
    DXDraw1: TDXDraw;
    WSmTiles: TWMImages;
    WTiles: TWMImages;
    WEffectImg: TWMImages;
    WChrSel: TWMImages;
    WMon18Img: TWMImages;
    WObjects2: TWMImages;
    DXSound: TDXSound;
    WObjects3: TWMImages;
    WMagIcon: TWMImages;
    WMMap: TWMImages;
    Wobjects1: TWMImages;
    WObjects6: TWMImages;
    WObjects7: TWMImages;
    WMon12Img: TWMImages;
    WMon8Img: TWMImages;
    WObjects4: TWMImages;
    WMon13Img: TWMImages;
    WMon9Img: TWMImages;
    WMon10Img: TWMImages;
    WObjects5: TWMImages;
    WWeapon: TWMImages;
    WMon11Img: TWMImages;
    WMon14Img: TWMImages;
    WMon16Img: TWMImages;
    WMon17Img: TWMImages;
    WMon2Img: TWMImages;
    WNPCImg: TWMImages;
    WHairImg: TWMImages;
    WMon15Img: TWMImages;
    WMon3Img: TWMImages;
    WHumImg: TWMImages;
    WProgUse2: TWMImages;
    WMon6Img: TWMImages;
    WMon7Img: TWMImages;
    WMagic2: TWMImages;
    WStateItem: TWMImages;
    WMon4Img: TWMImages;
    WMon5Img: TWMImages;
    WMonImg: TWMImages;
    WDnItem: TWMImages;
    WBagItem: TWMImages;
    procedure DXDraw1Initialize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DXDraw1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DXDraw1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DXDraw1Finalize(Sender: TObject);
    procedure CSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure Timer1Timer(Sender: TObject);
    procedure DXDraw1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MouseTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DXDraw1DblClick(Sender: TObject);
    procedure WaitMsgTimerTimer(Sender: TObject);
    procedure SelChrWaitTimerTimer(Sender: TObject);
    procedure DXDraw1Click(Sender: TObject);
    procedure CmdTimerTimer(Sender: TObject);
    procedure MinTimerTimer(Sender: TObject);
    procedure CheckHackTimerTimer(Sender: TObject);
    procedure SendTimeTimerTimer(Sender: TObject);
    procedure SpeedHackTimerTimer(Sender: TObject);
  private
    SocStr, BufferStr: string;
    WarningLevel: integer;
    TimerCmd: TTimerCommand;
    MakeNewId: string; //Áö±Ý¸¸µé·Á°íÇÏ´Â ¾ÆÀÌµð

    ActionLockTime: longword;
    LastHitTime: longword;
    ActionFailLock: Boolean;
    FailAction, FailDir: integer;
    ActionKey: word;

    CursorSurface: TDirectDrawSurface;
    mousedowntime: longword;
    WaitingMsg: TDefaultMessage;
    WaitingStr: string;
    WhisperName: string;

    procedure ProcessKeyMessages;
    procedure ProcessActionMessages;
    procedure CheckSpeedHack (rtime: Longword);
    procedure DecodeMessagePacket (datablock: string);
    procedure ActionFailed;
    function  GetMagicByKey (Key: char): PTClientMagic;
    procedure UseMagic (tx, ty: integer; pcm: PTClientMagic);
    procedure UseMagicSpell (who, effnum, targetx, targety, magic_id: integer);
    procedure UseMagicFire (who, efftype, effnum, targetx, targety, target: integer);
    procedure UseMagicFireFail (who: integer);
    procedure CloseAllWindows;
    procedure ClearDropItems;
    procedure ResetGameVariables;
    procedure ChangeServerClearGameVariables;
    procedure _DXDrawMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure AttackTarget (target: TActor);

    function  CheckDoorAction (dx, dy: integer): Boolean;
    procedure ClientGetPasswdSuccess (body: string);
    procedure ClientGetNeedUpdateAccount (body: string);
    procedure ClientGetSelectServer;
    procedure ClientGetReceiveChrs (body: string);
    procedure ClientGetStartPlay (body: string);
    procedure ClientGetReconnect (body: string);
    procedure ClientGetMapDescription (body: string);
    procedure ClientGetAdjustBonus (bonus: integer; body: string);
    procedure ClientGetAddItem (body: string);
    procedure ClientGetUpdateItem (body: string);
    procedure ClientGetDelItem (body: string);
    procedure ClientGetDelItems (body: string);
    procedure ClientGetBagItmes (body: string);
    procedure ClientGetDropItemFail (iname: string; sindex: integer);
    procedure ClientGetShowItem (itemid, x, y, looks: integer; itmname: string);
    procedure ClientGetHideItem (itemid, x, y: integer);
    procedure ClientGetSenduseItems (body: string);
    procedure ClientGetAddMagic (body: string);
    procedure ClientGetDelMagic (magid: integer);
    procedure ClientGetMyMagics (body: string);
    procedure ClientGetMagicLvExp (magid, maglv, magtrain: integer);
    procedure ClientGetDuraChange (uidx, newdura, newduramax: integer);
    procedure ClientGetMerchantSay (merchant, face: integer; saying: string);
    procedure ClientGetSendGoodsList (merchant, count: integer; body: string);
    procedure ClientGetSendMakeDrugList (merchant: integer; body: string);
    procedure ClientGetSendUserSell (merchant: integer);
    procedure ClientGetSendUserRepair (merchant: integer);
    procedure ClientGetSendUserStorage (merchant: integer);
    procedure ClientGetSaveItemList (merchant: integer; bodystr: string);
    procedure ClientGetSendDetailGoodsList (merchant, count, topline: integer; bodystr: string);
    procedure ClientGetSendNotice (body: string);
    procedure ClientGetGroupMembers (bodystr: string);
    procedure ClientGetOpenGuildDlg (bodystr: string);
    procedure ClientGetSendGuildMemberList (body: string);
    procedure ClientGetDealRemoteAddItem (body: string);
    procedure ClientGetDealRemoteDelItem (body: string);
    procedure ClientGetReadMiniMap (mapindex: integer);
    procedure ClientGetChangeGuildName (body: string);
    procedure ClientGetSendUserState (body: string);
  public
    LoginId, LoginPasswd, CharName: string;
    Certification: integer;
    ActionLock: Boolean;
    //MainSurface: TDirectDrawSurface;
    function  GetObjs (wunit, idx: integer): TDirectDrawSurface;
    function  GetObjsEx (wunit, idx: integer; var px, py: integer): TDirectDrawSurface;

    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure ProcOnIdle;
    procedure AppOnIdle (Sender: TObject; var Done: Boolean);
    procedure AppLogout;
    procedure AppExit;
    procedure PrintScreenNow;
    procedure EatItem (idx: integer);

    procedure SendClientMessage (msg, Recog, param, tag, series: integer);
    procedure SendLogin (uid, passwd: string);
    procedure SendNewAccount (ue: TUserEntryInfo; ua: TUserEntryAddInfo);
    procedure SendUpdateAccount (ue: TUserEntryInfo; ua: TUserEntryAddInfo);
    procedure SendSelectServer (svname: string);
    procedure SendChgPw (id, passwd, newpasswd: string);
    procedure SendNewChr (uid, uname, shair, sjob, ssex: string);
    procedure SendQueryChr;
    procedure SendDelChr (chrname: string);
    procedure SendSelChr (chrname: string);
    procedure SendRunLogin;
    procedure SendSay (str: string);
    procedure SendActMsg (ident, x, y, dir: integer);
    procedure SendSpellMsg (ident, x, y, dir, target: integer);
    procedure SendQueryUserName (targetid, x, y: integer);
    procedure SendDropItem (name: string; itemserverindex: integer);
    procedure SendPickup;
    procedure SendTakeOnItem (where: byte; itmindex: integer; itmname: string);
    procedure SendTakeOffItem (where: byte; itmindex: integer; itmname: string);
    procedure SendEat (itmindex: integer; itmname: string);
    procedure SendButchAnimal (x, y, dir, actorid: integer);
    procedure SendMagicKeyChange (magid: integer; keych: char);
    procedure SendMerchantDlgSelect (merchant: integer; rstr: string);
    procedure SendQueryPrice (merchant, itemindex: integer; itemname: string);
    procedure SendQueryRepairCost (merchant, itemindex: integer; itemname: string);
    procedure SendSellItem (merchant, itemindex: integer; itemname: string);
    procedure SendRepairItem (merchant, itemindex: integer; itemname: string);
    procedure SendStorageItem (merchant, itemindex: integer; itemname: string);
    procedure SendGetDetailItem (merchant, menuindex: integer; itemname: string);
    procedure SendBuyItem (merchant, itemserverindex: integer; itemname: string);
    procedure SendTakeBackStorageItem (merchant, itemserverindex: integer; itemname: string);
    procedure SendMakeDrugItem (merchant: integer; itemname: string);
    procedure SendDropGold (dropgold: integer);
    procedure SendGroupMode (onoff: Boolean);
    procedure SendCreateGroup (withwho: string);
    procedure SendWantMiniMap;
    procedure SendDealTry; //¾Õ¿¡ »ç¶÷ÀÌ ÀÖ´ÂÁö °Ë»ç
    procedure SendGuildDlg;
    procedure SendCancelDeal;
    procedure SendAddDealItem (ci: TClientItem);
    procedure SendDelDealItem (ci: TClientItem);
    procedure SendChangeDealGold (gold: integer);
    procedure SendDealEnd;
    procedure SendAddGroupMember (withwho: string);
    procedure SendDelGroupMember (withwho: string);
    procedure SendGuildHome;
    procedure SendGuildMemberList;
    procedure SendGuildAddMem (who: string);
    procedure SendGuildDelMem (who: string);
    procedure SendGuildUpdateNotice (notices: string);
    procedure SendGuildUpdateGrade (rankinfo: string);
    procedure SendSpeedHackUser;  //SpeedHaker »ç¿ëÀÚ¸¦ ¼­¹ö¿¡ Åëº¸ÇÑ´Ù.
    procedure SendAdjustBonus (remain: integer; babil: TNakedAbility);

    function  TargetInSwordLongAttackRange (ndir: integer): Boolean;
    function  TargetInSwordWideAttackRange (ndir: integer): Boolean;
    procedure OnProgramException (Sender: TObject; E: Exception);
    procedure SendSocket (sendstr: string);
    function  ServerAcceptNextAction: Boolean;
    function  CanNextAction: Boolean;
    function  CanNextHit: Boolean;
    function  IsUnLockAction (action, adir: integer): Boolean;
    procedure ActiveCmdTimer (cmd: TTimerCommand);
    function  IsGroupMember (uname: string): Boolean;
  end;

  function  CheckMirProgram: Boolean;
  procedure PomiTextOut (dsurface: TDirectDrawSurface; x, y: integer; str: string);
  procedure WaitAndPass (msec: longword);
  function  GetRGB (c256: byte): integer;
  procedure DebugOutStr (msg: string);

var
  FrmMain: TFrmMain;
  DScreen: TDrawScreen;
  IntroScene: TIntroScene;
  LoginScene: TLoginScene;
  SelectChrScene: TSelectChrScene;
  PlayScene: TPlayScene;
  LoginNoticeScene: TLoginNotice;
  DropedItemList: TList;
  Sound: TSoundEngine;
  ChangeFaceReadyList: TList;

  MainParam1, MainParam2, MainParam3, MainParam4, MainParam5, MainParam6: string;

  SoundList: TStringList;
  //DObjList: TList;  //¹Ù´Ú¿¡ º¯°æµÈ ÁöÇüÀÇ Ç¥Çö
  EventMan: TClEventManager;

  KornetWorld: TKornetWorld;

  ServerName: string;        //·þÎñÆ÷Ãû
  ServerMiniName: string;
  MapTitle: string;
  GuildName: string;  //¼Ò¼Ó¹®ÆÄÀÇ ÀÌ¸§
  GuildRankName: string;  //¹®ÆÄ¿¡¼­ÀÇ Á÷Ã¥ÀÌ¸§
  Map: TMap;
  MySelf: THumActor;
  MyDrawActor: THumActor;
  UseItems: array[0..8] of TClientItem;
  ItemArr: array[0..MAXBAGITEMCL-1] of TClientItem;
  DealItems: array[0..9] of TClientItem;
  DealRemoteItems: array[0..19] of TClientItem;
  SaveItemList: TList;
  MenuItemList: TList;
  DealGold, DealRemoteGold: integer;
  BoDealEnd: Boolean;
  DealWho: string; //°Å·¡ÇÏ´Â »ó´ëÆí
  MagicList: TList;
  MouseItem, MouseStateItem, MouseUserStateItem: TClientItem; //ÇöÀç ¸¶¿ì½º°¡ °¡¸®Å°°í ÀÖ´Â ¾ÆÀÌÅÛ
  FreeActorList: TList; //
  BoServerChanging: Boolean;
  BoBagLoaded: Boolean;

  FirstServerTime: longword;
  FirstClientTime: longword;
  //ServerTimeGap: int64;
  TimeFakeDetectCount: integer;

  SHGetTime: longword;
  SHTimerTime: longword;
  SHFakeCount: integer;

  LatestClientTime2: longword;
  FirstClientTimerTime: longword; //timer ½Ã°£
  LatestClientTimerTime: longword;
  FirstClientGetTime: longword; //gettickcount ½Ã°£
  LatestClientGetTime: longword;
  TimeFakeDetectSum: integer;
  TimeFakeDetectTimer: integer;

  BonusPoint, SaveBonusPoint: integer;
  BonusTick: TNakedAbility;
  BonusAbil: TNakedAbility;
  NakedAbil: TNakedAbility;
  BonusAbilChg: TNakedAbility;

  SellDlgItem: TClientItem;
  SellDlgItemSellWait: TClientItem;
  DealDlgItem: TClientItem;
  BoQueryPrice: Boolean;
  QueryPriceTime: longword;
  SellPriceStr: string;

  BoOneClick: Boolean;
  OneClickMode: TOneClickMode;

  BoFirstTime: Boolean;
  ConnectionStep: TConnectionStep;
  ServerConnected: Boolean;
  ViewFog: Boolean;
  DayBright: integer;
  AreaStateValue: integer;
  MyHungryState: integer;

  LastAttackTime: longword;  //ÃÖ±ÙÀÇ°ø°Ý ½Ã°£, °ø°ÝµµÁß Å¬¸¯½Ç¼ö·Î ÀÌµ¿ÇÏ´Â °ÍÀ» ¸·À½
  LastMoveTime: longword;
  ItemMoving: Boolean;
  MovingItem: TMovingItem;
  WaitingUseItem: TMovingItem;
  EatingItem: TClientItem;
  EatTime: longword; //timeout...

  LatestStruckTime: longword;
  LatestSpellTime: longword;
  LatestFireHitTime: longword;
  LatestRushRushTime: longword;
  LatestHitTime: longword;   //³²À» °ø°ÝÇÏ°í Á¢¼ÓÀ» Á¾·á ¸øÇÏ°Ô
  LatestMagicTime: longword; //¸¶¹ýÀ» »ç¿ëÇÏ°í Á¢¼ÓÀ» Á¾·á ¸øÇÏ°Ô
  DizzyDelayStart: longword;
  DizzyDelayTime: integer;

  DoFadeOut: Boolean;
  DoFadeIn: Boolean;
  FadeIndex: integer;
  DoFastFadeOut: Boolean;

  BoAttackSlow: Boolean; //¹«°Ô ÃÊ°ú·Î °ø°ÝÀ» ´À¸®°Ô ÇÑ´Ù.
  BoMoveSlow: Boolean; //³Ê¹« ¸¹ÀÌ µé¾ú°Å³ª, ¹«°Å¿î ¿ÊÀ» ÀÔ¾î¼­ ¿òÁ÷ÀÓÀÌ µÐÇØÁø´Ù.
  MoveSlowLevel: integer;
  MapMoving: Boolean; //¸Ê ÀÌµ¿Áß, Ç®¸±¶§±îÁö ÀÌµ¿ ¾ÈµÊ
  MapMovingWait: Boolean;
  CheckBadMapMode: Boolean;
  BoCheckSpeedHackDisplay: Boolean;
  BoViewMiniMap: Boolean;
  MiniMapIndex: integer;

  MCX: integer; //¸¶¿ì½º°¡ °¡¸®Å°´Â cell À§Ä¡
  MCY: integer;
  MouseX, MouseY: integer; //¸¶¿ì½º°¡ °¡¸®Å°´Â ½ºÅ©¸° ÁÂÇ¥

  TargetX: integer;  //°¡°íÀÚ ÇÏ´Â ¸ñÀûÁö
  TargetY: integer;
  TargetCret, FocusCret, MagicTarget: TActor;
  BoAutoDig: Boolean;
  BoSelectMyself: Boolean;
  FocusItem: PTDropItem;
  MagicDelayTime: longword;
  MagicPKDelayTime: longword;
  ChrAction: TChrAction;
  NoDarkness: Boolean;
  RunReadyCount: integer; //3¹ß ÀÌ»ó °È´Ù°¡ ¶Ú´Ù.

  SoftClosed: Boolean;
  SelChrAddr: string;
  SelChrPort: integer;
  ImgMixSurface: TDirectDrawSurface;
  MiniMapSurface: TDirectDrawSurface;

  CurMerchant: integer; //ÃÖ±Ù¿¡ ¸Þ´º¸¦ º¸³½ »óÀÎ
  MDlgX, MDlgY: integer;   //¸Þ´º¸¦ ¹ÞÀº °÷
  changegroupmodetime: longword;
  dealactiontime: longword;
  querymsgtime: longword;
  DupSelection: integer;

  AllowGroup: Boolean;
  GroupMembers: TStringList;
  MySpeedPoint, MyHitPoint, MyAntiPoison, MyPoisonRecover,
  MyHealthRecover, MySpellRecover, MyAntiMagic: integer;

  AvailIDDay, AvailIDHour: word;
  AvailIPDay, AvailIPHour: word;


  CaptureSerial: integer;
  SendCount, ReceiveCount: integer;
  TestSendCount, TestReceiveCount: integer;
  SpellCount, SpellFailCount, FireCount: integer;
  DebugCount, DebugCount1, DebugCount2: integer;

  LastestClientGetTime: longword;
  ToolMenuHook: HHOOK;
  LastHookKey: integer;
  LastHookKeyTime: longword;

   BoNextTimePowerHit: Boolean;
   BoCanLongHit: Boolean;
   BoCanWideHit: Boolean;
   BoNextTimeFireHit: Boolean;


implementation

uses FState;

{$R *.DFM}


function  CheckMirProgram: Boolean;
var
   pstr, cstr: array[0..255] of char;
   mirapphandle: HWnd;
begin
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
end;

procedure PomiTextOut (dsurface: TDirectDrawSurface; x, y: integer; str: string);
var
   i, n: integer;
   d: TDirectDrawSurface;
begin
   for i:=1 to Length(str) do begin
      n := byte(str[i]) - byte('0');
      if n in [0..9] then begin //Êý×Ö
         d := FrmMain.WProgUse.Images[30 + n];
         if d <> nil then
            dsurface.Draw (x + i*8, y, d.ClientRect, d, TRUE);
      end else begin
         if str[i] = '-' then begin   //¡®-¡¯
            d := FrmMain.WProgUse.Images[40];
            if d <> nil then
               dsurface.Draw (x + i*8, y, d.ClientRect, d, TRUE);
         end;
      end;
   end;
end;

procedure WaitAndPass (msec: longword);
var
   start: longword;
begin
   start := GetTickCount;
   while GetTickCount - start < msec do begin
      Application.ProcessMessages;
   end;
end;

function  GetRGB (c256: byte): integer;
var
   i: integer;
begin
   with FrmMain.DxDraw1 do
      Result := RGB(DefColorTable[c256].rgbRed, DefColorTable[c256].rgbGreen, DefColorTable[c256].rgbBlue);
end;

procedure DebugOutStr (msg: string);
var
   flname: string;
   fhandle: TextFile;
begin
   //exit;
   flname := '.\!debug.txt';
   if FileExists(flname) then begin
      AssignFile (fhandle, flname);
      Append (fhandle);
   end else begin
      AssignFile (fhandle, flname);
      Rewrite (fhandle);
   end;
   WriteLn (fhandle, TimeToStr(Time) + ' ' + msg);
   CloseFile (fhandle);
end;

function KeyboardHookProc (Code: Integer; WParam: Longint; var Msg: TMsg): Longint; stdcall;
begin
   if ((WParam = 9){ or (WParam = 13)}) and (LastHookKey = 18) and (GetTickCount - LastHookKeyTime < 500) then begin
      if FrmMain.WindowState <> wsMinimized then begin
         FrmMain.WindowState := wsMinimized;
      end else
         Result := CallNextHookEx(ToolMenuHook, Code, WParam, Longint(@Msg));
      exit;
   end;
   LastHookKey := WParam;
   LastHookKeyTime := GetTickCount;

   Result := CallNextHookEx(ToolMenuHook, Code, WParam, Longint(@Msg));
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
   flname, str: string;
   ini: TIniFile;
begin

   Randomize;

   ini := TIniFile.Create ('.\mir.ini');
   if ini <> nil then begin
      if EnglishVersion then begin
         SERVERADDR := ini.ReadString ('Setup', 'ServerAddr', SERVERADDR);
         LocalLanguage := imOpen;
      end;
      CurFontName := ini.ReadString ('Setup', 'FontName', CurFontName);
      ini.Free;
   end;


   //»ç¿îµå °ü·Ã ÃÊ±âÈ­
   if DxSound.Initialized then begin
      Sound := TSoundEngine.Create (DxSound.DSound);
   end else begin
      Sound := nil;
   end;

   ToolMenuHook := SetWindowsHookEx(WH_KEYBOARD, @KeyboardHookProc, 0, GetCurrentThreadID);

   SoundList := TStringList.Create;
   flname := '.\wav\sound.lst';
   LoadSoundList (flname);
   //if FileExists (flname) then
   //   SoundList.LoadFromFile (flname);

   DScreen := TDrawScreen.Create;
   IntroScene := TIntroScene.Create;
   LoginScene := TLoginScene.Create;
   SelectChrScene := TSelectChrScene.Create;
   PlayScene := TPlayScene.Create;
   LoginNoticeScene := TLoginNotice.Create;

   Map := TMap.Create;
   DropedItemList := TList.Create;
   MagicList := TList.Create;
   FreeActorList := TList.Create;
   //DObjList := TList.Create;
   EventMan := TClEventManager.Create;
   ChangeFaceReadyList := TList.Create;

   Myself := nil;
   FillChar (UseItems, sizeof(TClientItem)*9, #0);
   FillChar (ItemArr, sizeof(TClientItem)*MAXBAGITEMCL, #0);
   FillChar (DealItems, sizeof(TClientItem)*10, #0);
   FillChar (DealRemoteItems, sizeof(TClientItem)*20, #0);
   SaveItemList := TList.Create;
   MenuItemList := TList.Create;
   WaitingUseItem.Item.S.Name := '';  //Âø¿ëÃ¢ ¼­¹ö¿Í Åë½Å°£¿¡ ÀÓ½ÃÀúÀå
   EatingItem.S.Name := '';

   TargetX := -1;
   TargetY := -1;
   TargetCret := nil;
   FocusCret := nil;
   FocusItem := nil;
   MagicTarget := nil;
   DebugCount := 0;
   DebugCount1 := 0;
   DebugCount2 := 0;
   TestSendCount := 0;
   TestReceiveCount := 0;
   BoServerChanging := FALSE;
   BoBagLoaded := FALSE;
   BoAutoDig := FALSE;

   LatestClientTime2 := 0;
   FirstClientTime := 0;
   FirstServerTime := 0;
   FirstClientTimerTime := 0;
   LatestClientTimerTime := 0;
   FirstClientGetTime := 0;
   LatestClientGetTime := 0;

   TimeFakeDetectCount := 0;
   TimeFakeDetectTimer := 0;
   TimeFakeDetectSum := 0;

   SHGetTime := 0;
   SHTimerTime := 0;
   SHFakeCount := 0;


   DayBright := 3; //¹ã
   AreaStateValue := 0;
   ConnectionStep := cnsLogin;
   ServerConnected := FALSE;
   SocStr := '';
   WarningLevel := 0;  //ºÒ·®ÆÐÅ¶ ¼ö½Å È½¼ö (ÆÐÅ¶º¹»ç °¡´É¼º ÀÖÀ½)
   ActionFailLock := FALSE;
   MapMoving := FALSE;
   MapMovingWait := FALSE;
   CheckBadMapMode := True;//FALSE;
   BoCheckSpeedHackDisplay := FALSE;
   BoViewMiniMap := FALSE;
   FailDir := 0;
   FailAction := 0;
   DupSelection := 0;

   LastAttackTime := GetTickCount;
   LastMoveTime := GetTickCount;
   LatestSpellTime := GetTickCount;

   BoFirstTime := TRUE;
   ItemMoving := FALSE;
   DoFadeIn := FALSE;
   DoFadeOut := FALSE;
   DoFastFadeOut := FALSE;
   BoAttackSlow := FALSE;
   BoMoveSlow := FALSE;
   BoNextTimePowerHit := FALSE;
   BoCanLongHit := FALSE;
   BoCanWideHit := FALSE;
   BoNextTimeFireHit := FALSE;

   NoDarkness := FALSE;
   SoftClosed := FALSE;
   BoQueryPrice := FALSE;
   SellPriceStr := '';

   AllowGroup := FALSE;
   GroupMembers := TStringList.Create;

   MainWinHandle := DxDraw1.Handle;

   //¿øÅ¬¸¯, ÄÚ³Ý¿ùµå µî..
   BoOneClick := FALSE;
   OneClickMode := toNone;

   CSocket.Active := FALSE;
   CSocket.Port := 7000;
   if MainParam1 = '' then CSocket.Address := SERVERADDR
   else begin
      if (MainParam1 <> '') and (MainParam2 = '') then  //ÆÄ¶ó¸ÞÅÍ 1°³
         CSocket.Address := MainParam1;
      if (MainParam2 <> '') and (MainParam3 = '') then begin  //ÆÄ¶ó¸ÞÅÍ 2°³ ÀÎ°æ¿ì
         CSocket.Address := MainParam1;
         CSocket.Port := Str_ToInt (MainParam2, 0);
      end;
      if (MainParam3 <> '') then begin  //ÆÄ¶ó¸ÞÅÍ 3°³ÀÎ°æ¿ì, ÅëÇÕ Á¢¼Ó
         if CompareText (MainParam1, '/KWG') = 0 then begin
            //ÄÚ³Ý ¿ùµå ¿ë
            CSocket.Address := kornetworldaddress;  //game.megapass.net';
            CSocket.Port := 9000;
            BoOneClick := TRUE;
            OneClickMode := toKornetWorld;
            with KornetWorld do begin
               CPIPcode := MainParam2;
               SVCcode  := MainParam3;
               LoginID  := MainParam4;
               CheckSum := MainParam5; //'dkskxhdkslxlkdkdsaaaasa';
            end;
         end else begin
            //ÀÏ¹Ý ¿øÅ¬¸¯ ÅëÇÕ °ÔÀÌÆ®¿ë
            CSocket.Address := MainParam2;
            CSocket.Port := Str_ToInt (MainParam3, 0);
            BoOneClick := TRUE;
         end;
      end;
   end;
   if BO_FOR_TEST then
      CSocket.Address := TESTSERVERADDR; 
   cSocket.Active := TRUE;

   //MainSurface := nil;
   DebugOutStr ('----------------------- started ------------------------');

   Application.OnException := OnProgramException;
   Application.OnIdle := AppOnIdle;
   Font.Charset:=GB2312_CHARSET;
   Font.name:='ËÎÌå';
end;

procedure TFrmMain.OnProgramException (Sender: TObject; E: Exception);
begin
   DebugOutStr (E.Message);
end;

procedure TFrmMain.WMSysCommand(var Message: TWMSysCommand);
begin
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
   inherited;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
   if ToolMenuHook <> 0 then UnhookWindowsHookEx(ToolMenuHook);
   //SoundCloseProc;
   //DXTimer.Enabled := FALSE;
   Timer1.Enabled := FALSE;
   MinTimer.Enabled := FALSE;

   WTiles.Finalize;
   WObjects1.Finalize;
   WObjects2.Finalize;
   WObjects3.Finalize;
   WObjects4.Finalize;
   WObjects5.Finalize;
   WObjects6.Finalize;
   WObjects7.Finalize;
   WSmTiles.Finalize;
   WHumImg.Finalize;
   WHairImg.Finalize;
   WWeapon.Finalize;
   WMagic.Finalize;
   WMagic2.Finalize;
   WMagIcon.Finalize;
   WMonImg.Finalize;
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
   WNpcImg.Finalize;
   WEffectImg.Finalize;
   WProgUse.Finalize;
   WProgUse2.Finalize;
   WChrSel.Finalize;
   WMMap.Finalize;
   WBagItem.Finalize;
   WStateItem.Finalize;
   WDnItem.Finalize;
   DScreen.Finalize;
   PlayScene.Finalize;
   LoginNoticeScene.Finalize;

   DScreen.Free;
   IntroScene.Free;
   LoginScene.Free;
   SelectChrScene.Free;
   PlayScene.Free;
   LoginNoticeScene.Free;
   SaveItemList.Free;
   MenuItemList.Free;

   DebugOutStr ('----------------------- closed -------------------------');
   Map.Free;
   DropedItemList.Free;
   MagicList.Free;
   FreeActorList.Free;
   ChangeFaceReadyList.Free;
   //if MainSurface <> nil then MainSurface.Free;

   Sound.Free;
   SoundList.Free;
   //DObjList.Free;
   EventMan.Free;

end;

function ComposeColor(Dest, Src: TRGBQuad; Percent: Integer): TRGBQuad;
begin
  with Result do
  begin
    rgbRed := Src.rgbRed+((Dest.rgbRed-Src.rgbRed)*Percent div 256);
    rgbGreen := Src.rgbGreen+((Dest.rgbGreen-Src.rgbGreen)*Percent div 256);
    rgbBlue := Src.rgbBlue+((Dest.rgbBlue-Src.rgbBlue)*Percent div 256);
    rgbReserved := 0;
  end;
end;

procedure TFrmMain.DXDraw1Initialize(Sender: TObject);
begin
  
   if BoFirstTime then begin
      BoFirstTime := FALSE;

      DxDraw1.SurfaceWidth := SCREENWIDTH;
      DxDraw1.SurfaceHeight := SCREENHEIGHT;

      DxDraw1.Surface.Canvas.Font.Assign (FrmMain.Font);

      FrmMain.Font.Name := CurFontName;
      FrmMain.Canvas.Font.Name := CurFontName;
      DxDraw1.Surface.Canvas.Font.Name := CurFontName;
      PlayScene.EdChat.Font.Name := CurFontName;

      //MainSurface := TDirectDrawSurface.Create (FrmMain.DXDraw1.DDraw);
      //MainSurface.SystemMemory := TRUE;
      //MainSurface.SetSize (SCREENWIDTH, SCREENHEIGHT);

      WTiles.DDraw := DxDraw1.DDraw;
      WObjects1.DDraw := DxDraw1.DDraw;
      WObjects2.DDraw := DxDraw1.DDraw;
      WObjects3.DDraw := DxDraw1.DDraw;
      WObjects4.DDraw := DxDraw1.DDraw;
      WObjects5.DDraw := DxDraw1.DDraw;
      WObjects6.DDraw := DxDraw1.DDraw;
      WObjects7.DDraw := DxDraw1.DDraw;
      WSmTiles.DDraw := DxDraw1.DDraw;
      WProgUse.DDraw := DxDraw1.DDraw;
      WProgUse2.DDraw := DxDraw1.DDraw;
      WChrSel.DDraw := DxDraw1.DDraw;
      WMMap.DDraw := DxDraw1.DDraw;
      WBagItem.DDraw := DxDraw1.DDraw;
      WStateItem.DDraw := DxDraw1.DDraw;
      WDnItem.DDraw := DxDraw1.DDraw;
      WHumImg.DDraw := DxDraw1.DDraw;
      WHairImg.DDraw := DxDraw1.DDraw;
      WWeapon.DDraw := DxDraw1.DDraw;
      WMagic.DDraw := DxDraw1.DDraw;
      WMagic2.DDraw := DxDraw1.DDraw;
      WMagIcon.DDraw := DxDraw1.DDraw;
      WMonImg.DDraw := DxDraw1.DDraw;
      WMon2Img.DDraw := DxDraw1.DDraw;
      WMon3Img.DDraw := DxDraw1.DDraw;
      WMon4Img.DDraw := DxDraw1.DDraw;
      WMon5Img.DDraw := DxDraw1.DDraw;
      WMon6Img.DDraw := DxDraw1.DDraw;
      WMon7Img.DDraw := DxDraw1.DDraw;
      WMon8Img.DDraw := DxDraw1.DDraw;
      WMon9Img.DDraw := DxDraw1.DDraw;
      WMon10Img.DDraw := DxDraw1.DDraw;
      WMon11Img.DDraw := DxDraw1.DDraw;
      WMon12Img.DDraw := DxDraw1.DDraw;
      WMon13Img.DDraw := DxDraw1.DDraw;
      WMon14Img.DDraw := DxDraw1.DDraw;
      WMon15Img.DDraw := DxDraw1.DDraw;
      WMon16Img.DDraw := DxDraw1.DDraw;
      WMon17Img.DDraw := DxDraw1.DDraw;
      WMon18Img.DDraw := DxDraw1.DDraw;
      WNpcImg.DDraw := DxDraw1.DDraw;
      WEffectImg.DDraw := DxDraw1.DDraw;
      WTiles.Initialize;
      WObjects1.Initialize;
      WObjects2.Initialize;
      WObjects3.Initialize;
      WObjects4.Initialize;
      WObjects5.Initialize;
      WObjects6.Initialize;
      WObjects7.Initialize;
      WSmTiles.Initialize;
      WProgUse.Initialize;
      WProgUse2.Initialize;
      WChrSel.Initialize;
      WMMap.Initialize;
      WBagItem.Initialize;
      WStateItem.Initialize;
      WDnItem.Initialize;
      WHumImg.Initialize;
      WHairImg.Initialize;
      WWeapon.Initialize;
      WMagic.Initialize;
      WMagic2.Initialize;
      WMagIcon.Initialize;
      WMonImg.Initialize;
      WMon2Img.Initialize;
      WMon3Img.Initialize;
      WMon4Img.Initialize;
      WMon5Img.Initialize;
      WMon6Img.Initialize;
      WMon7Img.Initialize;
      WMon8Img.Initialize;
      WMon9Img.Initialize;
      WMon10Img.Initialize;
      WMon11Img.Initialize;
      WMon12Img.Initialize;
      WMon13Img.Initialize;
      WMon14Img.Initialize;
      WMon15Img.Initialize;
      WMon16Img.Initialize;
      WMon17Img.Initialize;
      WMon18Img.Initialize;
      WNpcImg.Initialize;
      WEffectImg.Initialize;

      DXDraw1.DefColorTable := WProgUse.MainPalette;
      DXDraw1.ColorTable := DXDraw1.DefColorTable;
      DXDraw1.UpdatePalette;

      //256 Blend utility
      if not LoadNearestIndex (NEARESTPALETTEINDEXFILE) then begin
         BuildNearestIndex (DXDraw1.ColorTable);
         SaveNearestIndex (NEARESTPALETTEINDEXFILE);
      end;
      BuildColorLevels (DXDraw1.ColorTable);

      DScreen.Initialize;
      PlayScene.Initialize;
      FrmDlg.Initialize;

      if doFullScreen in DxDraw1.Options then begin
         //Screen.Cursor := crNone;
      end else begin
         Left := 0;
         Top := 0;
         Width := SCREENWIDTH;
         Height := SCREENHEIGHT;
         NoDarkness := TRUE;
         UseDIBSurface := TRUE;
      end;

      ImgMixSurface := TDirectDrawSurface.Create (FrmMain.DXDraw1.DDraw);
      ImgMixSurface.SystemMemory := TRUE;
      ImgMixSurface.SetSize (300, 350);
      MiniMapSurface := TDirectDrawSurface.Create (FrmMain.DXDraw1.DDraw);
      MiniMapSurface.SystemMemory := TRUE;
      MiniMapSurface.SetSize (540, 360);

      //DXDraw1.Surface.SystemMemory := TRUE;
   end;

end;

procedure TFrmMain.DXDraw1Finalize(Sender: TObject);
begin
   //DXTimer.Enabled := FALSE;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CSocket.Active:=False;
   
   //Savebags ('.\Data\' + ServerName + '.' + CharName + '.itm', @ItemArr);
   //DxTimer.Enabled := FALSE;
end;


{------------------------------------------------------------}


function  TFrmMain.GetObjs (wunit, idx: integer): TDirectDrawSurface;
begin
   case wunit of
      0:    Result := WObjects1.Images[idx];
      1:    Result := WObjects2.Images[idx];
      2:    Result := WObjects3.Images[idx];
      3:    Result := WObjects4.Images[idx];
      4:    Result := WObjects5.Images[idx];
      5:    Result := WObjects6.Images[idx];
      6:    Result := WObjects7.Images[idx];
      else  Result := WObjects1.Images[idx];
   end;
end;

function  TFrmMain.GetObjsEx (wunit, idx: integer; var px, py: integer): TDirectDrawSurface;
begin
   case wunit of
      0:    Result := WObjects1.GetCachedImage (idx, px, py);
      1:    Result := WObjects2.GetCachedImage (idx, px, py);
      2:    Result := WObjects3.GetCachedImage (idx, px, py);
      3:    Result := WObjects4.GetCachedImage (idx, px, py);
      4:    Result := WObjects5.GetCachedImage (idx, px, py);
      5:    Result := WObjects6.GetCachedImage (idx, px, py);
      6:    Result := WObjects7.GetCachedImage (idx, px, py);
      else  Result := WObjects1.GetCachedImage (idx, px, py);
   end;
end;

procedure TFrmMain.ProcOnIdle;
var
   done: Boolean;
begin
   AppOnIdle (self, done);
   //DXTimerTimer (self, 0);
end;

procedure TFrmMain.AppOnIdle (Sender: TObject; var Done: Boolean);
//procedure TFrmMain.DXTimerTimer(Sender: TObject; LagCount: Integer);
var
   i, j: integer;
   p: TPoint;
   DF: DDBLTFX;
   d: TDirectDrawSurface;
begin
   Done := TRUE;
   if not DXDraw1.CanDraw then exit;

   ProcessKeyMessages;
   ProcessActionMessages;
   DScreen.DrawScreen (DxDraw1.Surface);
   DWinMan.DirectPaint (DxDraw1.Surface);
   DScreen.DrawScreenTop (DxDraw1.Surface);
   DScreen.DrawHint (DxDraw1.Surface);

   if ItemMoving then begin
      if (MovingItem.Item.S.Name <> '½ð±Ò') then
         d := FrmMain.WBagItem.Images[MovingItem.Item.S.Looks]
      else d := FrmMain.WBagItem.Images[115]; //½ð±Ò
      if d <> nil then begin
         GetCursorPos (p);
         DxDraw1.Surface.Draw (p.x-(d.ClientRect.Right div 2), p.y-(d.ClientRect.Bottom div 2), d.ClientRect, d, TRUE);
      end;
   end;
   if DoFadeOut then begin
      if FadeIndex < 1 then FadeIndex := 1;
      MakeDark (DxDraw1.Surface, FadeIndex);
      if FadeIndex <= 1 then DoFadeOut := FALSE
      else Dec (FadeIndex, 2);
   end else
   if DoFadeIn then begin
      if FadeIndex > 29 then FadeIndex := 29;
      MakeDark (DxDraw1.Surface, FadeIndex);
      if FadeIndex >= 29 then DoFadeIn := FALSE
      else Inc (FadeIndex, 2);
   end else
   if DoFastFadeOut then begin
      if FadeIndex < 1 then FadeIndex := 1;
      MakeDark (DxDraw1.Surface, FadeIndex);
      if FadeIndex > 1 then Dec (FadeIndex, 4);
   end;
   DxDraw1.Primary.Draw (0, 0, DxDraw1.Surface.ClientRect, DxDraw1.Surface, FALSE);
end;

procedure TFrmMain.AppLogout;
begin
   if mrOk = FrmDlg.DMessageDlg ('ÊÇ·ñ×¢Ïú?', [mbOk, mbCancel]) then begin
      SendClientMessage (CM_SOFTCLOSE, 0, 0, 0, 0);
      PlayScene.ClearActors;
      CloseAllWindows;
      if not BoOneClick then begin
         SoftClosed := TRUE;
         ActiveCmdTimer (tcSoftClose);
      end else begin
         ActiveCmdTimer (tcReSelConnect);
      end;
      if BoBagLoaded then
         Savebags ('.\Data\' + ServerName + '.' + CharName + '.itm', @ItemArr);
      BoBagLoaded := FALSE;
   end;
end;

procedure TFrmMain.AppExit;
begin
   if mrOk = FrmDlg.DMessageDlg ('ÄãÕæµÄÒªÍË³öÓÎÏ·Âð?', [mbOk, mbCancel]) then begin
      if BoBagLoaded then    //±£´æ×°±¸
         Savebags ('.\Data\' + ServerName + '.' + CharName + '.itm', @ItemArr);
      BoBagLoaded := FALSE;   
      FrmMain.Close;
   end;
end;

//¿½±´ÆÁÄ»
procedure TFrmMain.PrintScreenNow;
   function IntToStr2(n: integer): string;
   begin
      if n < 10 then Result := '0' + IntToStr(n)
      else Result := IntToStr(n);
   end;
var
   i, k, n, checksum: integer;
   flname: string;
   dib: TDIB;
   ddsd: DDSURFACEDESC;
   sptr, dptr: PByte;
begin
   if not DXDraw1.CanDraw then exit;
   //ÕÒÒ»¸öÎ´Ê¹ÓÃµÄÎÄ¼þÃû
   while TRUE do begin
      flname := 'Images' + IntToStr2(CaptureSerial) + '.bmp';
      if not FileExists (flname) then break;
      Inc (CaptureSerial);
   end;
   dib := TDIB.Create;
   dib.BitCount := 8;
   dib.Width := SCREENWIDTH;
   dib.Height := SCREENHEIGHT;
   dib.ColorTable := WProgUse.MainPalette;
   dib.UpdatePalette;

   ddsd.dwSize := SizeOf(ddsd);
   checksum := 0;   //Ð£ÑéºÍ
   try
      DXDraw1.Primary.Lock (TRect(nil^), ddsd);
      for i := (600-120) to SCREENHEIGHT-10 do begin
         sptr := PBYTE(integer(ddsd.lpSurface) + (SCREENHEIGHT - 1 - i)*ddsd.lPitch + 200);
         for k:=0 to 400-1 do begin
            checksum := checksum + byte(pbyte(integer(sptr) + k)^);
         end;
      end;
   finally
      DXDraw1.Primary.Unlock ();
   end;

   try
      SetBkMode (DXDraw1.Primary.Canvas.Handle, TRANSPARENT);
      DXDraw1.Primary.Canvas.Font.Color := clWhite;
      n := 0;
      if Myself <> nil then begin
         DXDraw1.Primary.Canvas.TextOut (0, 0, ServerName + ' ' + Myself.UserName);
         Inc (n, 1);
      end;
      DXDraw1.Primary.Canvas.TextOut (0, (n)*12,   'CheckSum=' + IntToStr(checksum));
      DXDraw1.Primary.Canvas.TextOut (0, (n+1)*12,  DateToStr(Date));
      DXDraw1.Primary.Canvas.TextOut (0, (n+2)*12, TimeToStr(Time));
      DXDraw1.Primary.Canvas.Release;
      DXDraw1.Primary.Lock (TRect(nil^), ddsd);
      for i := 0 to dib.Height-1 do begin
         sptr := PBYTE(integer(ddsd.lpSurface) + (dib.Height - 1 - i)*ddsd.lPitch);
         dptr := PBYTE(integer(dib.PBits) + i*800);
         Move (sptr^, dptr^, 800);
      end;
   finally
      DXDraw1.Primary.Unlock ();
   end;
   dib.SaveToFile (flname);
   dib.Clear;
   dib.Free;
end;


{------------------------------------------------------------}

procedure TFrmMain.ProcessKeyMessages;
begin
   case ActionKey of
      VK_F1, VK_F2, VK_F3, VK_F4, VK_F5, VK_F6, VK_F7, VK_F8:
         begin
            UseMagic (MouseX, MouseY, GetMagicByKey (char ((ActionKey-VK_F1) + byte('1')) )); //½ºÅ©¸° ÁÂÇ¥
            ActionKey := 0;
            TargetX := -1;
            exit;
         end;
   end;
end;

procedure TFrmMain.ProcessActionMessages;
var
   mx, my, dx, dy, crun: integer;
   ndir, adir, mdir: byte;
   bowalk, bostop: Boolean;
label
   LB_WALK;
begin
   if Myself = nil then exit;

   //Move
   if (TargetX >= 0) and CanNextAction and ServerAcceptNextAction then begin //ActionLockÀÌ Ç®¸®¸é, ActionLockÀº µ¿ÀÛÀÌ ³¡³ª±â Àü¿¡ Ç®¸°´Ù.
      if (TargetX <> Myself.XX) or (TargetY <> Myself.YY) then begin
         mx := Myself.XX;
         my := Myself.YY;
         dx := TargetX;
         dy := TargetY;
         ndir := GetNextDirection (mx, my, dx, dy);
         case ChrAction of
            caWalk: begin
               LB_WALK:
               crun := Myself.CanWalk;
               {DScreen.AddSysMsg ('caWalk ' + IntToStr(Myself.XX) + ' ' +
                                              IntToStr(Myself.YY) + ' ' +
                                              IntToStr(TargetX) + ' ' +
                                              IntToStr(TargetY)+' :'+inttostr(crun));
               }
               if IsUnLockAction (CM_WALK, ndir) and (crun > 0) then begin
                  GetNextPosXY (ndir, mx, my);
                  bowalk := TRUE;
                  bostop := FALSE;
                  if not PlayScene.CanWalk (mx, my) then begin
                     bowalk := FALSE;
                     adir := 0;
                     if not bowalk then begin  //ÀÔ±¸ °Ë»ç
                        mx := Myself.XX;
                        my := Myself.YY;
                        GetNextPosXY (ndir, mx, my);
                        if CheckDoorAction (mx, my) then
                           bostop := TRUE;
                     end;
                     if not bostop and not PlayScene.CrashMan(mx,my) then begin //»ç¶÷Àº ÀÚµ¿À¸·Î ÇÇÇÏÁö ¾ÊÀ½..
                        mx := Myself.XX;
                        my := Myself.YY;
                        adir := PrivDir(ndir);
                        GetNextPosXY (adir, mx, my);
                        if not Map.CanMove(mx,my) then begin
                           mx := Myself.XX;
                           my := Myself.YY;
                           adir := NextDir (ndir);
                           GetNextPosXY (adir, mx, my);
                           if Map.CanMove(mx,my) then
                              bowalk := TRUE;
                        end else
                           bowalk := TRUE;
                     end;
                     if bowalk then begin
                        Myself.UpdateMsg (CM_WALK, mx, my, adir, 0, 0, '', 0);
                        LastMoveTime := GetTickCount;
                     end else begin
                        mdir := GetNextDirection (Myself.XX, Myself.YY, dx, dy);
                        if mdir <> Myself.Dir then
                           Myself.SendMsg (CM_TURN, Myself.XX, Myself.YY, mdir, 0, 0, '', 0);
                        TargetX := -1;
                     end;
                  end else begin
                     Myself.UpdateMsg (CM_WALK, mx, my, ndir, 0, 0, '', 0);  //Ç×»ó ¸¶Áö¸· ¸í·É¸¸ ±â¾ï
                     LastMoveTime := GetTickCount;
                  end;
               end else begin
                  TargetX := -1;
               end;
            end;
            caRun: begin
               if RunReadyCount >= 1 then begin
                  crun := Myself.CanRun;
                  if (GetDistance (mx, my, dx, dy) >= 2) and (crun > 0) then begin
                     if IsUnLockAction (CM_RUN, ndir) then begin
                        GetNextRunXY (ndir, mx, my);
                        if PlayScene.CanRun (Myself.XX, Myself.YY, mx, my) then begin
                           Myself.UpdateMsg (CM_RUN, mx, my, ndir, 0, 0, '', 0);
                           LastMoveTime := GetTickCount;
                        end;
                     end else
                        TargetX := -1;
                  end else begin
                     //if crun = -1 then begin
                        //DScreen.AddSysMsg ('Áö±ÝÀº ¶Û ¼ö ¾ø½À´Ï´Ù.');
                        //TargetX := -1;
                     //end;
                     goto LB_WALK;     //Ã¼·ÂÀÌ ¾ø´Â°æ¿ì.
                     {if crun = -2 then begin
                        DScreen.AddSysMsg ('Àá½ÃÈÄ¿¡ ¶Û ¼ö ÀÖ½À´Ï´Ù.');
                        TargetX := -1;
                     end; }
                  end;
               end else begin
                  Inc (RunReadyCount);
                  goto LB_WALK;
               end;
            end;
         end;
      end;
   end;
   TargetX := -1; //ÇÑ¹ø¿¡ ÇÑÄ­¾¿..
   if Myself.RealActionMsg.Ident > 0 then begin
      FailAction := Myself.RealActionMsg.Ident; //½ÇÆÐÇÒ¶§ ´ëºñ
      FailDir := Myself.RealActionMsg.Dir;
      if Myself.RealActionMsg.Ident = CM_SPELL then begin
         SendSpellMsg (Myself.RealActionMsg.Ident,
                       Myself.RealActionMsg.X,
                       Myself.RealActionMsg.Y,
                       Myself.RealActionMsg.Dir,
                       Myself.RealActionMsg.State);
      end else
         SendActMsg (Myself.RealActionMsg.Ident,
                  Myself.RealActionMsg.X,
                  Myself.RealActionMsg.Y,
                  Myself.RealActionMsg.Dir);
      Myself.RealActionMsg.Ident := 0;

      //¸Þ´º¸¦ ¹ÞÀºÈÄ 10¹ßÀÚ±¹ ÀÌ»ó °ÉÀ¸¸é ÀÚµ¿À¸·Î »ç¶óÁü
      if MDlgX <> -1 then
         if (abs(MDlgX-Myself.XX) >= 8) or (abs(MDlgY-Myself.YY) >= 8) then begin
            FrmDlg.CloseMDlg;
            MDlgX := -1;
         end;
   end;
end;

procedure TFrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   msg, wc, dir, mx, my: integer;
   ini: TIniFile;
begin
   case Key of
      VK_PAUSE:   // ÇÁ¸°Æ® ½ºÅ©¸° Å°
         begin
            Key := 0;
            PrintScreenNow;
         end;
   end;

   if DWinMan.KeyDown (Key, Shift) then exit;

   if (Myself = nil) or (DScreen.CurrentScene <> PlayScene) then exit;
   mx := Myself.XX;
   my := Myself.YY;
   case Key of
      VK_F1, VK_F2, VK_F3, VK_F4,
      VK_F5, VK_F6, VK_F7, VK_F8:
         begin
            if (GetTickCount - LatestSpellTime > (500{+200} + MagicDelayTime)) then begin
               ActionKey := Key;
            end;
            Key := 0;
         end;
      VK_F9:
         begin
            FrmDlg.OpenItemBag;
         end;
      VK_F10:
         begin
            FrmDlg.StatePage := 0;
            FrmDlg.OpenMyStatus;
         end;
      VK_F11:
         begin
            FrmDlg.StatePage := 3;
            FrmDlg.OpenMyStatus;
         end;

      word('H'):  //´ëÀÎ°ø°Ý ¹æ¹ý
         begin
            if ssCtrl in Shift then begin
               SendSay ('@°ø°Ý¹æ½Ä');
            end;
         end;
      word('A'):
         begin
            if ssCtrl in Shift then begin
               SendSay ('@ÈÞ½Ä');
            end;
         end;
      word('F'):
         begin
            if ssCtrl in Shift then begin
               if CurFont < MAXFONT-1 then Inc(CurFont)
               else CurFont := 0;
               CurFontName := FontArr[CurFont];
               FrmMain.Font.Name := CurFontName;
               FrmMain.Canvas.Font.Name := CurFontName;
               DxDraw1.Surface.Canvas.Font.Name := CurFontName;
               PlayScene.EdChat.Font.Name := CurFontName;

               ini := TIniFile.Create ('.\mir.ini');
               if ini <> nil then begin
                  ini.WriteString ('Setup', 'FontName', CurFontName);
                  ini.Free;
               end;

            end;
         end;
      word('X'):
         begin
            if Myself = nil then exit;
            if ssAlt in Shift then begin
               if (GetTickCount - LatestStruckTime > 10000) and
                  (GetTickCount - LatestMagicTime > 10000) and
                  (GetTickCount - LatestHitTime > 10000) or
                  (Myself.Death) then
               begin
                  AppLogOut;
               end else
                  DScreen.AddChatBoardString ('ÕýÔÚÕ½¶·£¬²»ÄÜ×¢Ïú.', clYellow, clRed);
            end;
         end;
      word('Q'):
         begin
            if Myself = nil then exit;
            if ssAlt in Shift then begin
               if (GetTickCount - LatestStruckTime > 10000) and
                  (GetTickCount - LatestMagicTime > 10000) and
                  (GetTickCount - LatestHitTime > 10000) or
                  (Myself.Death) then
               begin
                  AppExit;
               end else
                  DScreen.AddChatBoardString ('ÕýÔÚÕ½¶·£¬²»ÄÜÍË³öÓÎÏ·.', clYellow, clRed);
            end;
         end;
   end;
   //Ã¤ÆÃÃ¢ Á¶Á¤
   case Key of
      VK_UP:
         with DScreen do begin
            if ChatBoardTop > 0 then Dec (ChatBoardTop);
         end;
      VK_DOWN:
         with DScreen do begin
            if ChatBoardTop < ChatStrs.Count-1 then
               Inc (ChatBoardTop);
         end;
      VK_PRIOR:
         with DScreen do begin
            if ChatBoardTop > VIEWCHATLINE then
               ChatBoardTop := ChatBoardTop - VIEWCHATLINE
            else ChatBoardTop := 0;
         end;
      VK_NEXT:
         with DScreen do begin
            if ChatBoardTop + VIEWCHATLINE < ChatStrs.Count-1 then
               ChatBoardTop := ChatBoardTop + VIEWCHATLINE
            else ChatBoardTop := ChatStrs.Count-1;
            if ChatBoardTop < 0 then ChatBoardTop := 0;
         end;
   end;
end;

procedure TFrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if DWinMan.KeyPress (Key) then exit;
   if DScreen.CurrentScene = PlayScene then begin
      if PlayScene.EdChat.Visible then begin
         //°øÅëÀ¸·Î Ã³¸®ÇØ¾ß ÇÏ´Â °æ¿ì¸¸ ¾Æ·¡·Î ³Ñ¾î°¨
         exit;
      end;
      case byte(key) of
         byte('1')..byte('6'):
            begin
               EatItem (byte(key) - byte('1')); //º§Æ® ¾ÆÀÌÅÛÀ» »ç¿ëÇÑ´Ù.
            end;
         27: //ESC
            begin
            end;
         byte(' '), 13: //Ã¤ÆÃ ¹Ú½º
            begin
               PlayScene.EdChat.Visible := TRUE;
               PlayScene.EdChat.SetFocus;
               SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
               if FrmDlg.BoGuildChat then begin
                  PlayScene.EdChat.Text := '!~';
                  PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
                  PlayScene.EdChat.SelLength := 0;
               end else begin
                  PlayScene.EdChat.Text := '';
               end;
            end;
         byte('@'),
         byte('!'),
         byte('/'):
            begin
               PlayScene.EdChat.Visible := TRUE;
               PlayScene.EdChat.SetFocus;
               SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
               if key = '/' then begin
                  if WhisperName = '' then PlayScene.EdChat.Text := key
                  else if Length(WhisperName) > 2 then PlayScene.EdChat.Text := '/' + WhisperName + ' '
                  else PlayScene.EdChat.Text := key;
                  PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
                  PlayScene.EdChat.SelLength := 0;
               end else begin
                  PlayScene.EdChat.Text := key;
                  PlayScene.EdChat.SelStart := 1;
                  PlayScene.EdChat.SelLength := 0;
               end;
            end;
      end;
      key := #0;
   end;
end;

function  TFrmMain.GetMagicByKey (Key: char): PTClientMagic;
var
   i: integer;
   pm: PTClientMagic;
begin
   Result := nil;
   for i:=0 to MagicList.Count-1 do begin
      pm := PTClientMagic (MagicList[i]);
      if pm.Key = Key then begin
         Result := pm;
         break;
      end;
   end;
end;

procedure TFrmMain.UseMagic (tx, ty: integer; pcm: PTClientMagic); //tx, ty: ½ºÅ©¸° ÁÂÇ¥ÀÓ.
var
   tdir, targx, targy, targid: integer;
   pmag: PTUseMagicInfo;
begin
   if pcm = nil then exit;

   //ÊÇ·ñ¿ÉÒÔÊ¹ÓÃÄ§·¨£ºÐèÒªµÄµãÊý<µ±Ç°µãÊý£¬»òÕßÊÇÄ§·¨EffectType = 0
   if (pcm.Def.Spell + pcm.Def.DefSpell <= Myself.Abil.MP) or (pcm.Def.EffectType = 0) then begin
      if pcm.Def.EffectType = 0 then begin //°Ë¹ý,È¿°ú¾øÀ½
         //°Ë¹ý Å°´Â Çàµ¿À» µû·Î ÇÏÁö ¾Ê´Â´Ù.
         //¼­¹ö¿¡ Á÷Á¢ Àü´ÞÇÑ´Ù.
         //if CanNextAction and ServerAcceptNextAction then begin

         //¿°È­°áÀº ÇÑ¹ø »ç¿ëÈÄ 9ÃÊ±îÁö´Â ´Ù½Ã ´­·ÁÁöÁö ¾Ê°Ô ÇÑ´Ù.
         if pcm.Def.MagicId = 26 then begin //¿°È­°á
            if GetTickCount - LatestFireHitTime < 10 * 1000 then begin  //10ÃëÓÃÒ»´Î
               exit;
            end;
         end;
         //¹«ÅÂº¸´Â ÇÑ¹ø »ç¿ëÈÄ 3ÃÊ±îÁö´Â ´Ù½Ã ´­·ÁÁöÁö ¾Ê´Â´Ù.
         if pcm.Def.MagicId = 27 then begin //¹«ÅÂº¸
            if GetTickCount - LatestRushRushTime < 3 * 1000 then begin  //3ÃëÓÃÒ»´Î
               exit;
            end;
         end;

         //°Ë¹ýÀº µô·¹ÀÌ(500ms) ¾øÀÌ ´­·ÁÁø´Ù.
         if GetTickCount - LatestSpellTime > 500 then begin
            LatestSpellTime := GetTickCount;
            MagicDelayTime := 0; //pcm.Def.DelayTime;
            SendSpellMsg (CM_SPELL, Myself.Dir{x}, 0, pcm.Def.MagicId, 0);
         end;
      end else begin
         tdir := GetFlyDirection (390, 175, tx, ty);
         MagicTarget := FocusCret;
         if not PlayScene.IsValidActor (MagicTarget) then
            MagicTarget := nil;
         if MagicTarget = nil then begin
            PlayScene.CXYfromMouseXY (tx, ty, targx, targy);
            targid := 0;
         end else begin
            targx := MagicTarget.XX;
            targy := MagicTarget.YY;
            targid := MagicTarget.RecogId;
         end;
         if CanNextAction and ServerAcceptNextAction then begin
            LatestSpellTime := GetTickCount;  //¸¶¹ý »ç¿ë
            new (pmag);
            FillChar (pmag^, sizeof(TUseMagicInfo), #0);
            pmag.EffectNumber := pcm.Def.Effect;
            pmag.MagicSerial := pcm.Def.MagicId;
            pmag.ServerMagicCode := 0;
            MagicDelayTime := 200 + pcm.Def.DelayTime; //´ÙÀ½ ¸¶¹ýÀ» »ç¿ëÇÒ¶§±îÁö ½¬´Â ½Ã°£

            case pmag.MagicSerial of
               //0, 2, 11, 12, 15, 16, 17, 13, 23, 24, 26, 27, 28, 29: ;
               2, 14, 15, 16, 17, 18, 19, 21,  //ºñ°ø°Ý ¸¶¹ý Á¦¿Ü
               12, 25, 26, 28, 29, 30, 31: ;
               else LatestMagicTime := GetTickCount;
            end;

            //»ç¶÷À» °ø°ÝÇÏ´Â °æ¿ìÀÇ µô·¹ÀÌ
            MagicPKDelayTime := 0;
            if MagicTarget <> nil then
               if MagicTarget.Race = 0 then
                  MagicPKDelayTime := 300 + Random(1100); //(600+200 + MagicDelayTime div 5);

            Myself.SendMsg (CM_SPELL, targx, targy, tdir, Integer(pmag), targid, '', 0);
         end;// else
            //Dscreen.AddSysMsg ('Àá½ÃÈÄ¿¡ »ç¿ëÇÒ ¼ö ÀÖ½À´Ï´Ù.');
         //Inc (SpellCount);
      end;
   end else
      Dscreen.AddSysMsg ('µãÊý²»¹»£¬ÎÞ·¨Ê¹ÓÃ.');
//   Dscreen.AddSysMsg ('¸¶¹ý»ç¿ë');
end;

procedure TFrmMain.UseMagicSpell (who, effnum, targetx, targety, magic_id: integer);
var
   actor: TActor;
   adir: integer;
   pmag: PTUseMagicInfo;
begin
   actor := PlayScene.FindActor (who);
   if actor <> nil then begin
      adir := GetFlyDirection (actor.XX, actor.YY, targetx, targety);
      new (pmag);
      FillChar (pmag^, sizeof(TUseMagicInfo), #0);
      pmag.EffectNumber := effnum; //magnum;
      pmag.ServerMagicCode := 0; //ÀÓ½Ã
      pmag.MagicSerial := magic_id;
      actor.SendMsg (SM_SPELL, 0, 0, adir, Integer(pmag), 0, '', 0);
      Inc (SpellCount);
   end else
      Inc (SpellFailCount);
end;

procedure TFrmMain.UseMagicFire (who, efftype, effnum, targetx, targety, target: integer);
var
   actor: TActor;
   adir, sound: integer;
   pmag: PTUseMagicInfo;
begin
   actor := PlayScene.FindActor (who);
   if actor <> nil then begin
      actor.SendMsg (SM_MAGICFIRE, target{111magid}, efftype, effnum, targetx, targety, '', sound);
      //if actor = Myself then Dec (SpellCount);
      if FireCount < SpellCount then
         Inc (FireCount);
   end;
   MagicTarget := nil;
end;

procedure TFrmMain.UseMagicFireFail (who: integer);
var
   actor: TActor;
begin
   actor := PlayScene.FindActor (who);
   if actor <> nil then begin
      actor.SendMsg (SM_MAGICFIRE_FAIL, 0, 0, 0, 0, 0, '', 0);
   end;
   MagicTarget := nil;
end;

//³ÔÒ©
procedure TFrmMain.EatItem (idx: integer);
begin
   if idx in [0..MAXBAGITEMCL-1] then begin
      if (EatingItem.S.Name <> '') and (GetTickCount - EatTime > 5 * 1000) then begin //5ÃëÖ®ÄÚÖ»ÄÜ³ÔÒ»´ÎÒ©
         EatingItem.S.Name := '';
      end;                                                                                  /////!///////
      if (EatingItem.S.Name = '') and (ItemArr[idx].S.Name <> '') and (ItemArr[idx].S.StdMode <= 4) then begin
         EatingItem := ItemArr[idx];
         ItemArr[idx].S.Name := '';
         //Ã¥À» ÀÐ´Â °Í... ÀÍÈú °ÍÀÎ Áö ¹°¾îº»´Ù.
         if (ItemArr[idx].S.StdMode = 4) and (ItemArr[idx].S.Shape < 100) then begin
            //shape > 100ÀÌ¸é ¹­À½ ¾ÆÀÌÅÛ ÀÓ..
            if ItemArr[idx].S.Shape < 50 then begin
               if mrYes <> FrmDlg.DMessageDlg (ItemArr[idx].S.Name + 'ÊÇ·ñÊ¹ÓÃ¸ÃÎïÆ·?', [mbYes, mbNo]) then begin
                  ItemArr[idx] := EatingItem;
                  exit;
               end;
            end else begin
                //shape > 50ÀÌ¸é ÁÖ¹® ¼­ Á¾·ù...
               if mrYes <> FrmDlg.DMessageDlg (ItemArr[idx].S.Name + 'ÊÇ·ñÊ¹ÓÃ¸ÃÎïÆ·?', [mbYes, mbNo]) then begin
                  ItemArr[idx] := EatingItem;
                  exit;
               end;
            end;
         end;
         EatTime := GetTickCount;
         SendEat(ItemArr[idx].MakeIndex, ItemArr[idx].S.Name );
         ItemUseSound (ItemArr[idx].S.StdMode);
      end;
   end else begin
      if (idx = -1) and ItemMoving then begin
         ItemMoving := FALSE;
         EatingItem := MovingItem.Item;
         MovingItem.Item.S.Name := '';
         //Ã¥À» ÀÐ´Â °Í... ÀÍÈú °ÍÀÎ Áö ¹°¾îº»´Ù.
         if (EatingItem.S.StdMode = 4) and (EatingItem.S.Shape < 100) then begin
            //shape > 100ÀÌ¸é ¹­À½ ¾ÆÀÌÅÛ ÀÓ..
            if EatingItem.S.Shape < 50 then begin
               if mrYes <> FrmDlg.DMessageDlg ('"' + EatingItem.S.Name + '"ÎïÆ·ÊÇ·ñÊ¹ÓÃ?', [mbYes, mbNo]) then begin
                  AddItemBag (EatingItem);
                  exit;
               end;
            end else begin
                //shape > 50ÀÌ¸é ÁÖ¹® ¼­ Á¾·ù...
               if mrYes <> FrmDlg.DMessageDlg ('"' + EatingItem.S.Name + '"ÎïÆ·ÊÇ·ñÊ¹ÓÃ?', [mbYes, mbNo]) then begin
                  AddItemBag (EatingItem);
                  exit;
               end;
            end;
         end;
         EatTime := GetTickCount;
         SendEat (EatingItem.MakeIndex, EatingItem.S.Name );
         ItemUseSound (EatingItem.S.StdMode);
      end;
   end;
end;

function  TFrmMain.TargetInSwordLongAttackRange (ndir: integer): Boolean;
var
   nx, ny: integer;
   actor: TActor;
begin
   Result := FALSE;
   GetFrontPosition (Myself.XX, Myself.YY, ndir, nx, ny);
   GetFrontPosition (nx, ny, ndir, nx, ny);
   if (abs(Myself.XX-nx) = 2) or (abs(Myself.YY-ny) = 2) then begin
      actor := PlayScene.FindActorXY (nx, ny);
      if actor <> nil then
         if not actor.Death then
            Result := TRUE;
   end;
end;

function  TFrmMain.TargetInSwordWideAttackRange (ndir: integer): Boolean;
var
   nx, ny, rx, ry, mdir: integer;
   actor, ractor: TActor;
begin
   Result := FALSE;
   GetFrontPosition (Myself.XX, Myself.YY, ndir, nx, ny);
   actor := PlayScene.FindActorXY (nx, ny);

   mdir := (ndir + 1) mod 8;
   GetFrontPosition (Myself.XX, Myself.YY, mdir, rx, ry);
   ractor := PlayScene.FindActorXY (rx, ry);
   if ractor = nil then begin
      mdir := (ndir + 2) mod 8;
      GetFrontPosition (Myself.XX, Myself.YY, mdir, rx, ry);
      ractor := PlayScene.FindActorXY (rx, ry);
   end;
   if ractor = nil then begin
      mdir := (ndir + 7) mod 8;
      GetFrontPosition (Myself.XX, Myself.YY, mdir, rx, ry);
      ractor := PlayScene.FindActorXY (rx, ry);
   end;

   if (actor <> nil) and (ractor <> nil) then
      if not actor.Death and not ractor.Death then
         Result := TRUE;
end;


{--------------------- Mouse Interface ----------------------}

procedure TFrmMain.DXDraw1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
   i, mx, my, msx, msy, sel: integer;
   target: TActor;
   itemnames: string;
begin
   if DWinMan.MouseMove (Shift, X, Y) then exit;
   if (Myself = nil) or (DScreen.CurrentScene <> PlayScene) then exit;
   BoSelectMyself := PlayScene.IsSelectMyself (X, Y);

   target := PlayScene.GetAttackFocusCharacter (X, Y, DupSelection, sel, FALSE);
   if DupSelection <> sel then DupSelection := 0;
   if target <> nil then begin
      if (target.UserName = '') and (GetTickCount - target.SendQueryUserNameTime > 10*1000) then begin
         target.SendQueryUserNameTime := GetTickCount;
         SendQueryUserName (target.RecogId, target.XX, target.YY);
      end;
      FocusCret := target;
   end else
      FocusCret := nil;

   FocusItem := PlayScene.GetDropItems (X, Y, itemnames);
   if FocusItem <> nil then begin
      PlayScene.ScreenXYfromMCXY (FocusItem.X, FocusItem.Y, mx, my);
      DScreen.ShowHint (mx-20,
                        my-10,
                        itemnames, //PTDropItem(ilist[i]).Name,
                        clWhite,
                        TRUE);
   end else
      DScreen.ClearHint;

   PlayScene.CXYfromMouseXY (X, Y, MCX, MCY);
   MouseX := X;
   MouseY := Y;
   MouseItem.S.Name := '';
   MouseStateItem.S.Name := '';
   MouseUserStateItem.S.Name := '';
   if ((ssLeft in Shift) or (ssRight in Shift)) and (GetTickCount - mousedowntime > 300) then
      _DXDrawMouseDown(self, mbLeft, Shift, X, Y);

end;

procedure TFrmMain.DXDraw1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   mousedowntime := GetTickCount;
   RunReadyCount := 0;     //µµ¿ò´Ý±â Ãë¼Ò(¶Ù±â ÀÎ°æ¿ì)
   _DXDrawMouseDown (Sender, Button, Shift, X, Y);
end;

procedure TFrmMain.AttackTarget (target: TActor);
var
   tdir, dx, dy, hitmsg: integer;
begin
   hitmsg := CM_HIT;
   if UseItems[U_WEAPON].S.StdMode = 6 then hitmsg := CM_HEAVYHIT;

   tdir := GetNextDirection (Myself.XX, Myself.YY, target.XX, target.YY);
   if (abs(Myself.XX-target.XX) <= 1) and (abs(Myself.YY-target.YY) <= 1) and (not target.Death) then begin
      if CanNextAction and ServerAcceptNextAction and CanNextHit then begin

         if BoNextTimeFireHit and (Myself.Abil.MP >= 7) then begin
            BoNextTimeFireHit := FALSE;
            hitmsg := CM_FIREHIT;
         end else
         if BoNextTimePowerHit then begin  //ÆÄ¿ö ¾ÆÅØÀÎ °æ¿ì, ¿¹µµ°Ë¹ý
            BoNextTimePowerHit := FALSE;
            hitmsg := CM_POWERHIT;
         end else
         if BoCanWideHit and (Myself.Abil.MP >= 3) then begin //and (TargetInSwordWideAttackRange (tdir)) then begin  //·Õ ¾ÆÅØÀÎ °æ¿ì, ¹Ý¿ù°Ë¹ý
            hitmsg := CM_WIDEHIT;
         end else
         if BoCanLongHit and (TargetInSwordLongAttackRange (tdir)) then begin  //·Õ ¾ÆÅØÀÎ °æ¿ì, ¾î°Ë¼ú
            hitmsg := CM_LONGHIT;
         end;

         //if ((target.Race <> 0) and (target.Race <> RCC_GUARD)) or (ssShift in Shift) then //»ç¶÷À» ½Ç¼ö·Î °ø°ÝÇÏ´Â °ÍÀ» ¸·À½
         Myself.SendMsg (hitmsg, Myself.XX, Myself.YY, tdir, 0, 0, '', 0);
         LatestHitTime := GetTickCount;
      end;
      LastAttackTime := GetTickCount;
   end else begin
      //ºñµµ¸¦ µé°í ÀÖÀ¸¸é
      //if (UseItems[U_WEAPON].S.Shape = 6) and (target <> nil) then begin
      //   Myself.SendMsg (CM_THROW, Myself.XX, Myself.YY, tdir, integer(target), 0, '', 0);
      //   TargetCret := nil;  //ÇÑ¹ø¸¸ °ø°Ý
      //end else begin
         ChrAction := caWalk;
         GetBackPosition (target.XX, target.YY, tdir, dx, dy);
         TargetX := dx;
         TargetY := dy;
      //end;
   end;
end;

procedure TFrmMain._DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   tdir, nx, ny, hitmsg, sel: integer;
   target: TActor;
begin
   ActionKey := 0;
   MouseX := X;
   MouseY := Y;
   BoAutoDig := FALSE;

   if (Button = mbRight) and ItemMoving then begin
      FrmDlg.CancelItemMoving;
      exit;
   end;
   if DWinMan.MouseDown (Button, Shift, X, Y) then exit;
   if (Myself = nil) or (DScreen.CurrentScene <> PlayScene) then exit;

   if ssRight in Shift then begin
      if Shift = [ssRight] then Inc (DupSelection);  //°ãÃÆÀ» °æ¿ì ¼±ÅÃ
      target := PlayScene.GetAttackFocusCharacter (X, Y, DupSelection, sel, FALSE); //¸ðµÎ..
      if DupSelection <> sel then DupSelection := 0;
      if target <> nil then begin
         if ssCtrl in Shift then begin //ÄÁÆ®·Ñ+¿À¸¥ÂÊÅ¬¸¯ = »ó´ë Á¤º¸ º¸±â
            //¶Ù´Ù°¡ »ó´ë¹æ Á¤º¸°¡ ¾È³ª¿À°Ô ÇÏ·Á°í
            if GetTickCount - LastMoveTime > 1000 then begin
               if (target.Race = 0) and (not target.Death) then begin
                  //»ó´ë¹æ Á¤º¸ º¸±â
                  SendClientMessage (CM_QUERYUSERSTATE, target.RecogId, target.XX, target.YY, 0);
                  exit;
               end;
            end;
         end;
      end else
         DupSelection := 0;

      PlayScene.CXYfromMouseXY (X, Y, MCX, MCY);
      if (abs(Myself.XX-MCX) <= 2) and (abs(Myself.YY-MCY) <= 2) then begin //¹æÇâÅÏ
         tdir := GetNextDirection (Myself.XX, Myself.YY, MCX, MCY);
         if CanNextAction and ServerAcceptNextAction then begin
            Myself.SendMsg (CM_TURN, Myself.XX, Myself.YY, tdir, 0, 0, '', 0);
         end;
      end else begin //¶Ù±â
         ChrAction := caRun;
         TargetX := MCX;
         TargetY := MCY;
         exit;
      end;
   end;

   if ssLeft in Shift {Button = mbLeft} then begin
      //°ø°Ý... ³ÐÀº ¹üÀ§·Î ¼±ÅÃµÊ
      target := PlayScene.GetAttackFocusCharacter (X, Y, DupSelection, sel, TRUE); //»ì¾ÆÀÖ´Â ³ð¸¸..
      PlayScene.CXYfromMouseXY (X, Y, MCX, MCY);
      TargetCret := nil;

      if (UseItems[U_WEAPON].S.Name <> '') and (target = nil) then begin
         //°î±ªÀÌÀÎÁö °Ë»ç
         if UseItems[U_WEAPON].S.Shape = 19 then begin //°î±ªÀÌ
            tdir := GetNextDirection (Myself.XX, Myself.YY, MCX, MCY);
            GetFrontPosition (Myself.XX, Myself.YY, tdir, nx, ny);
            if not Map.CanMove(nx, ny) or (ssShift in Shift) then begin  //¸ø °¡´Â °÷Àº °î±ªÀÌÁú ÇÑ´Ù.
               if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
                  Myself.SendMsg (CM_HIT+1, Myself.XX, Myself.YY, tdir, 0, 0, '', 0);
               end;
               BoAutoDig := TRUE;
               exit;
            end;
         end;
      end;

      if ssAlt in Shift then begin
         //°í±â ÀÚ¸£±â
         tdir := GetNextDirection (Myself.XX, Myself.YY, MCX, MCY);
         if CanNextAction and ServerAcceptNextAction then begin
            //¾Õ¿¡ ¹¹°¡ ÀÖ´À³Ä¿¡ µû¶ó¼­ µ¿ÀÛÀÌ ´Þ¶óÁü

            //¾Õ¿¡ µ¿¹° ½ÃÃ¼°¡ ÀÖ´Â °æ¿ì
            target := PlayScene.ButchAnimal (MCX, MCY);
            if target <> nil then begin
               SendButchAnimal (MCX, MCY, tdir, target.RecogId);
               Myself.SendMsg (CM_SITDOWN, Myself.XX, Myself.YY, tdir, 0, 0, '', 0); //ÀÚ¼¼´Â °°À½
               exit;
            end;
            Myself.SendMsg (CM_SITDOWN, Myself.XX, Myself.YY, tdir, 0, 0, '', 0);
         end;
         TargetX := -1;
      end else begin
         if (target <> nil) or (ssShift in Shift) then begin
            //¿ÞÂÊ¸¶¿ì½º Å¬¸¯ ¶Ç´Â Å¸°ÙÀÌ ÀÖÀ½.
            TargetX := -1;
            if target <> nil then begin
               //Å¸°ÙÀÌ ÀÖÀ½.

               //°È´Ù°¡ »óÀÎ ¸Þ´º°¡ ³ª¿À´Â °ÍÀ» ¹æÁö.
               if GetTickCount - LastMoveTime > 1500 then begin
                  //»óÀÎÀÎ °æ¿ì,
                  if target.Race = RCC_MERCHANT then begin
                     SendClientMessage (CM_CLICKNPC, target.RecogId, 0, 0, 0);
                     exit;
                  end;
               end;

               if (not target.Death) then begin //
                  TargetCret := target;
                  if ((target.Race <> 0) and
                      (target.Race <> RCC_GUARD) and
                      (target.Race <> RCC_MERCHANT) and
                      (pos('(', target.UserName) = 0) //ÁÖÀÎ¾ø´Â ¸÷(ÀÖ´Â ¸÷Àº °­Á¦°ø°Ý ÇØ¾ßÇÔ)
                     )
                     or (ssShift in Shift) //»ç¶÷À» ½Ç¼ö·Î °ø°ÝÇÏ´Â °ÍÀ» ¸·À½
                     or (target.NameColor = ENEMYCOLOR)   //ÀûÀº ÀÚµ¿ °ø°ÝÀÌ µÊ
                  then begin
                     AttackTarget (target);
                     LatestHitTime := GetTickCount;
                  end;
               end;
            end else begin
               tdir := GetNextDirection (Myself.XX, Myself.YY, MCX, MCY);
               if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
                  hitmsg := CM_HIT+Random(3);
                  if BoCanLongHit and (TargetInSwordLongAttackRange (tdir)) then begin  //·Õ ¾ÆÅØÀÎ °æ¿ì
                     hitmsg := CM_LONGHIT;
                  end;
                  if BoCanWideHit and (Myself.Abil.MP >= 3) and (TargetInSwordWideAttackRange (tdir)) then begin  //·Õ ¾ÆÅØÀÎ °æ¿ì
                     hitmsg := CM_WIDEHIT;
                  end;
                  Myself.SendMsg (hitmsg, Myself.XX, Myself.YY, tdir, 0, 0, '', 0);
               end;
               LastAttackTime := GetTickCount;
            end;
         end else begin
            if (MCX = Myself.XX) and (MCY = Myself.YY) then begin
               tdir := GetNextDirection (Myself.XX, Myself.YY, MCX, MCY);
               if CanNextAction and ServerAcceptNextAction then begin
                  SendPickup; //ÁÝ±â
               end;
            end else
               if GetTickCount - LastAttackTime > 1000 then begin //°ø°ÝÇÏ´Â Å¬¸¯ ½Ç¼öÀÌµ¿À» ¹æÁö
                  if ssCtrl in Shift then begin
                     ChrAction := caRun;
                  end else begin
                     ChrAction := caWalk;
                  end;
                  TargetX := MCX;
                  TargetY := MCY;
               end;
         end;
      end;
   end;
end;

procedure TFrmMain.DXDraw1DblClick(Sender: TObject);
var
   pt: TPoint;
begin
   GetCursorPos (pt);
   if DWinMan.DblClick (pt.X, pt.Y) then exit;
end;

function  TFrmmain.CheckDoorAction (dx, dy: integer): Boolean;
var
   nx, ny, ndir, door: integer;
begin
   Result := FALSE;
   door := Map.GetDoor (dx, dy);
   if door > 0 then begin
     if not Map.IsDoorOpen (dx, dy) then begin
       SendClientMessage (CM_OPENDOOR, door, dx, dy, 0);
       Result := TRUE;
     end;
   end;
end;

procedure TFrmMain.DXDraw1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if DWinMan.MouseUp (Button, Shift, X, Y) then exit;
   TargetX := -1;
end;

procedure TFrmMain.DXDraw1Click(Sender: TObject);
var
   pt: TPoint;
begin
   GetCursorPos (pt);
   if DWinMan.Click (pt.X, pt.Y) then exit;
end;

//Êó±êÊÂ¼þ:µ±Ñ¡ÔñÁËÄ§·¨µÈ¹¥»÷Ç°£¬ÏÔÊ¾Ò»¸öÑ¡Ôñ±»¹¥»÷¶ÔÏóµÄÊó±ê
procedure TFrmMain.MouseTimerTimer(Sender: TObject);
var
   pt: TPoint;
   keyvalue: TKeyBoardState;
   shift: TShiftState;
begin
   GetCursorPos (pt);
   SetCursorPos (pt.X, pt.Y);

   if TargetCret <> nil then begin
      if ActionKey > 0 then begin
         ProcessKeyMessages;
      end else begin
         if not TargetCret.Death and PlayScene.IsValidActor(TargetCret) then begin
            FillChar(keyvalue, sizeof(TKeyboardState), #0);
            if GetKeyboardState (keyvalue) then begin
               shift := [];
               if ((keyvalue[VK_SHIFT] and $80) <> 0) then shift := shift + [ssShift];
               if ((TargetCret.Race <> 0) and
                   (TargetCret.Race <> RCC_GUARD) and
                   (TargetCret.Race <> RCC_MERCHANT) and
                   (pos('(', TargetCret.UserName) = 0) //ÁÖÀÎÀÖ´Â ¸÷(°­Á¦°ø°Ý ÇØ¾ßÇÔ)
                  )
                  or (TargetCret.NameColor = ENEMYCOLOR)   //ÀûÀº ÀÚµ¿ °ø°ÝÀÌ µÊ
                  or ((ssShift in Shift) and (not PlayScene.EdChat.Visible)) then begin //»ç¶÷À» ½Ç¼ö·Î °ø°ÝÇÏ´Â °ÍÀ» ¸·À½
                  AttackTarget (TargetCret);
               end; //else begin
                  //TargetCret := nil;
               //end
            end;
         end else
            TargetCret := nil;
      end;
   end;
   if BoAutoDig then begin
      if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
         Myself.SendMsg (CM_HIT+1, Myself.XX, Myself.YY, Myself.Dir, 0, 0, '', 0);
      end;
   end;
end;

procedure TFrmMain.WaitMsgTimerTimer(Sender: TObject);
begin
   if Myself = nil then exit;
   if Myself.ActionFinished then begin
      WaitMsgTimer.Enabled := FALSE;
      case WaitingMsg.Ident of
         SM_CHANGEMAP:
            begin
               MapMovingWait := FALSE;
               MapMoving := FALSE;
               //¸ÊÀÌ ¹Ù²î¸é »óÁ¡ ¸Þ´º¸¦ ´Ý´Â´Ù.
               if MDlgX <> -1 then begin
                  FrmDlg.CloseMDlg;
                  MDlgX := -1;
               end;
               ClearDropItems;
               PlayScene.CleanObjects;
               MapTitle := '';
               PlayScene.SendMsg (SM_CHANGEMAP, 0,
                                    WaitingMsg.Param{x},
                                    WaitingMsg.tag{y},
                                    WaitingMsg.Series{darkness},
                                    0, 0,
                                    WaitingStr{mapname});
               Myself.CleanCharMapSetting (WaitingMsg.Param, WaitingMsg.Tag);
//////////////////////////////////////////////////////////////////////////
               DScreen.AddSysMsg (IntToStr(WaitingMsg.Param) + ' ' +
                                  IntToStr(WaitingMsg.Tag) + ' : My ' +
                                  IntToStr(Myself.XX) + ' ' +
                                  IntToStr(Myself.YY) + ' ' +
                                  IntToStr(Myself.RX) + ' ' +
                                  IntToStr(Myself.RY) + ' '
                                 );
//////////////////////////////////////////////////////////////////////////
               TargetX := -1;
               TargetCret := nil;
               FocusCret := nil;

            end;
      end;
   end;
end;



{----------------------- Socket -----------------------}
//ÔÚÑ¡Ôñ·þÎñÆ÷ºó¿ªÆô£¬µÈ´ýÒ»¶ÎÊ±¼äºó½øÈëÑ¡Ôñ½ÇÉ«×´Ì¬£¨µÈ´ý¡°¿ªÃÅ¡±µÄ¶¯»­Íê³É£©
procedure TFrmMain.SelChrWaitTimerTimer(Sender: TObject);
begin
   SelChrWaitTimer.Enabled := FALSE;
   SendQueryChr;
end;

procedure TFrmMain.ActiveCmdTimer (cmd: TTimerCommand);
begin
   CmdTimer.Enabled := TRUE;
   TimerCmd := cmd;
end;

//´¦Àí¸úÍøÂçÁ¬½ÓÓÐ¹ØµÄ¼¸¸öÊÂ¼þ
procedure TFrmMain.CmdTimerTimer(Sender: TObject);
begin
   CmdTimer.Enabled := FALSE;
   CmdTimer.Interval := 1000;
   case TimerCmd of
      tcSoftClose:       //¶Ï¿ªÁ¬½Ó
         begin
            CmdTimer.Enabled := FALSE;
            CSocket.Socket.Close;
         end;
      tcReSelConnect:
         begin
            //Çå³ýËùÓÐ¶ÔÏó
            ResetGameVariables;
            //·µ»Øµ½Ñ¡Ôñ½ÇÉ«×´Ì¬
            DScreen.ChangeScene (stSelectChr);
            //ÖØÐÂÁ¬½Ó·þÎñÆ÷
            ConnectionStep := cnsReSelChr;
            if not BoOneClick then begin
               with CSocket do begin
                  Active := FALSE;
                  Address := SelChrAddr;
                  Port := SelChrPort;
                  Active := TRUE;
               end;
            end else begin
               if CSocket.Socket.Connected then
                  CSocket.Socket.SendText ('$S' + SelChrAddr + '/' + IntToStr(SelChrPort) + '%');
               CmdTimer.Interval := 1;
               ActiveCmdTimer (tcFastQueryChr);
            end;
         end;
      tcFastQueryChr:     //²éÑ¯½ÇÉ«
         begin
            SendQueryChr;
         end;
   end;
end;

procedure TFrmMain.CloseAllWindows;
begin
   with FrmDlg do begin
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
   end;
   if MDlgX <> -1 then begin
      FrmDlg.CloseMDlg;
      MDlgX := -1;
   end;
   ItemMoving := FALSE;  //
end;

procedure TFrmMain.ClearDropItems;
var
   i: integer;
begin
   for i:=0 to DropedItemList.Count-1 do
      Dispose (PTDropItem(DropedItemList[i]));
   DropedItemList.Clear;
end;

procedure TFrmMain.ResetGameVariables;
var
   i: integer;
begin
   CloseAllWindows;
   ClearDropItems;
   for i:=0 to MagicList.Count-1 do
      Dispose (PTClientMagic (MagicList[i]));
   MagicList.Clear;
   ItemMoving := FALSE;
   WaitingUseItem.Item.S.Name := '';
   EatingItem.S.name := '';
   TargetX := -1;
   TargetCret := nil;
   FocusCret := nil;
   MagicTarget := nil;
   ActionLock := FALSE;
   GroupMembers.Clear;
   GuildRankName := '';
   GuildName := '';

   MapMoving := FALSE;
   WaitMsgTimer.Enabled := FALSE;
   MapMovingWait := FALSE;
   DScreen.ChatBoardTop := 0;
   BoNextTimePowerHit := FALSE;
   BoCanLongHit := FALSE;
   BoCanWideHit := FALSE;
   BoNextTimeFireHit := FALSE;

   FillChar (UseItems, sizeof(TClientItem)*9, #0);
   FillChar (ItemArr, sizeof(TClientItem)*MAXBAGITEMCL, #0);

   with SelectChrScene do begin
      FillChar (ChrArr, sizeof(TSelChar)*2, #0);
      ChrArr[0].FreezeState := TRUE; //±âº»ÀÌ ¾ó¾î ÀÖ´Â »óÅÂ
      ChrArr[1].FreezeState := TRUE;
   end;
   PlayScene.ClearActors;
   ClearDropItems;
   EventMan.ClearEvents;
   PlayScene.CleanObjects;
   //DXDraw1RestoreSurface (self);
   Myself := nil;
end;

procedure TFrmMain.ChangeServerClearGameVariables;
var
   i: integer;
begin
   CloseAllWindows;
   ClearDropItems;
   for i:=0 to MagicList.Count-1 do
      Dispose (PTClientMagic (MagicList[i]));
   MagicList.Clear;
   ItemMoving := FALSE;
   WaitingUseItem.Item.S.Name := '';
   EatingItem.S.name := '';
   TargetX := -1;
   TargetCret := nil;
   FocusCret := nil;
   MagicTarget := nil;
   ActionLock := FALSE;
   GroupMembers.Clear;
   GuildRankName := '';
   GuildName := '';

   MapMoving := FALSE;
   WaitMsgTimer.Enabled := FALSE;
   MapMovingWait := FALSE;
   BoNextTimePowerHit := FALSE;
   BoCanLongHit := FALSE;
   BoCanWideHit := FALSE;

   ClearDropItems;
   EventMan.ClearEvents;
   PlayScene.CleanObjects;
end;

procedure TFrmMain.CSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
   packet: array[0..255] of char;
   strbuf: array[0..255] of char;
   str: string;
begin
   ServerConnected := TRUE;
   if ConnectionStep = cnsLogin then begin
      //if OneClickMode = toKornetWorld then begin  //ÄÚ³Ý¿ùµå¸¦ °æÀ¯ÇØ¼­ °ÔÀÓ¿¡ Á¢¼Ó
      if OneClickMode <> toKornetWorld then begin
         FillChar (packet, 256, #0);
         str := 'KwGwMGS';
         StrPCopy (strbuf, str);
         Move (strbuf, (@packet[0])^, Length(str));
         str := 'CONNECT';
         StrPCopy (strbuf, str);
         Move (strbuf, (@packet[8])^, Length(str));
         str := KornetWorld.CPIPcode;
         StrPCopy (strbuf, str);
         Move (strbuf, (@packet[16])^, Length(str));
         str := KornetWorld.SVCcode;
         StrPCopy (strbuf, str);
         Move (strbuf, (@packet[32])^, Length(str));
         str := KornetWorld.LoginID;
         StrPCopy (strbuf, str);
         Move (strbuf, (@packet[48])^, Length(str));
         str := KornetWorld.CheckSum;
         StrPCopy (strbuf, str);
         Move (strbuf, (@packet[64])^, Length(str));
         Socket.SendBuf (packet, 256);
      end;
      DScreen.ChangeScene (stLogin);
   end;
   if ConnectionStep = cnsSelChr then begin
      LoginScene.OpenLoginDoor;
      SelChrWaitTimer.Enabled := TRUE;
   end;
   if ConnectionStep = cnsReSelChr then begin
      CmdTimer.Interval := 1;
      ActiveCmdTimer (tcFastQueryChr);
   end;
   if ConnectionStep = cnsPlay then begin
      if not BoServerChanging then begin
         ClearBag;  //°¡¹æ ÃÊ±âÈ­
         DScreen.ClearChatBoard; //Ã¤ÆÃÃ¢ ÃÊ±âÈ­
         DScreen.ChangeScene (stLoginNotice);
      end else begin
         ChangeServerClearGameVariables;
      end;
      SendRunLogin;
   end;
   SocStr := '';
   BufferStr := '';
end;

procedure TFrmMain.CSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
   ServerConnected := FALSE;
   if SoftClosed then begin
      SoftClosed := FALSE;
      ActiveCmdTimer (tcReSelConnect);
   end;
   
end;

procedure TFrmMain.CSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
   ErrorCode := 0;
   Socket.Close;
end;

procedure TFrmMain.CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
   n: integer;
   data, data2: string;
begin
   data := Socket.ReceiveText;
   
   //DebugOutStr (data);
   //if pos('GOOD', data) > 0 then DScreen.AddSysMsg (data);

   n := pos('*', data);
   if n > 0 then begin
      data2 := Copy (data, 1, n-1);
      data := data2 + Copy (data, n+1, Length(data));
      //SendSocket ('*');
      CSocket.Socket.SendText ('*');
   end;
   SocStr := SocStr + data;
end;

{-------------------------------------------------------------}

procedure TFrmMain.SendSocket (sendstr: string);
const
   code: byte = 1;
var
   s:string;
begin
   if CSocket.Socket.Connected then begin
      s:='#' + IntToStr(code) + sendstr + '!';
      CSocket.Socket.SendText (s);
      Inc (code);
      if code >= 10 then code := 1;
      //FrmDlg.DMessageDlg ('Send:'+S,[mbOk]);
   end;
end;

procedure TFrmMain.SendClientMessage (msg, Recog, param, tag, series: integer);
var
   dmsg: TDefaultMessage;
begin
   dmsg := MakeDefaultMsg (msg, Recog, param, tag, series);
   SendSocket (EncodeMessage (dmsg));
end;

procedure TFrmMain.SendLogin (uid, passwd: string);
var
   msg: TDefaultMessage;
begin
   LoginId := uid;
   LoginPasswd := passwd;
   msg := MakeDefaultMsg (CM_IDPASSWORD, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg)+ EncodeString(uid + '/' + passwd));
end;

procedure TFrmMain.SendNewAccount (ue: TUserEntryInfo; ua: TUserEntryAddInfo);
var
   msg: TDefaultMessage;
begin
   MakeNewId := ue.LoginId;
   msg := MakeDefaultMsg (CM_ADDNEWUSER, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeBuffer(@ue, sizeof(TUserEntryInfo)) + EncodeBuffer(@ua, sizeof(TUserEntryAddInfo)));
end;

procedure TFrmMain.SendUpdateAccount (ue: TUserEntryInfo; ua: TUserEntryAddInfo);
var
   msg: TDefaultMessage;
begin
   MakeNewId := ue.LoginId;
   msg := MakeDefaultMsg (CM_UPDATEUSER, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeBuffer(@ue, sizeof(TUserEntryInfo)) + EncodeBuffer(@ua, sizeof(TUserEntryAddInfo)));
end;

procedure TFrmMain.SendSelectServer (svname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_SELECTSERVER, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString(svname));
end;

procedure TFrmMain.SendChgPw (id, passwd, newpasswd: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_CHANGEPASSWORD, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString (id + #9 + passwd + #9 + newpasswd));
end;

procedure TFrmMain.SendNewChr (uid, uname, shair, sjob, ssex: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_NEWCHR, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString (uid + '/' + uname + '/' + shair + '/' + sjob + '/' + ssex));
end;

procedure TFrmMain.SendQueryChr;
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_QUERYCHR, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString(LoginId + '/' + IntToStr(Certification)));
end;

procedure TFrmMain.SendDelChr (chrname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_DELCHR, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString(chrname));
end;

procedure TFrmMain.SendSelChr(chrname: string);
var
   msg: TDefaultMessage;
begin
   CharName := chrname;
   msg := MakeDefaultMsg (CM_SELCHR, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString(LoginId + '/' + chrname));
end;

procedure TFrmMain.SendRunLogin;
var
   msg: TDefaultMessage;
   str: string;
begin
   str := '**' +
          LoginId + '/' +
          CharName + '/' +
          IntToStr(Certification) + '/' +
          IntToStr(VERSION_NUMBER_0522) + '/';
   str := str + '0';
   SendSocket (EncodeString (str));
end;

procedure TFrmMain.SendSay (str: string);
var
   msg: TDefaultMessage;
begin
   if str <> '' then begin
      if str = '/debug screen' then begin
         CheckBadMapMode := not CheckBadMapMode;
         if CheckBadMapMode then DScreen.AddSysMsg ('On')
         else DScreen.AddSysMsg ('Off');
         exit;
      end;
      if str = '/check speedhack' then begin
         BoCheckSpeedHackDisplay := not BoCheckSpeedHackDisplay;
         exit;
      end;
      if str = '@password' then begin
         if PlayScene.EdChat.PasswordChar = #0 then
            PlayScene.EdChat.PasswordChar := '*'
         else PlayScene.EdChat.PasswordChar := #0;
         exit;   
      end;
      msg := MakeDefaultMsg (CM_SAY, 0, 0, 0, 0);
      SendSocket (EncodeMessage (msg) + EncodeString(str));
      if str[1] = '/' then begin
         DScreen.AddChatBoardString (str, GetRGB(180), clWhite);
         GetValidStr3 (Copy(str,2,Length(str)-1), WhisperName, [' ']);
      end;
   end;
end;

procedure TFrmMain.SendActMsg (ident, x, y, dir: integer);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (ident, MakeLong(x,y), 0, dir, 0);
   SendSocket (EncodeMessage (msg));
   ActionLock := TRUE; //¼­¹ö¿¡¼­ #+FAIL! ÀÌ³ª #+GOOD!ÀÌ ¿Ã¶§±îÁö ±â´Ù¸²
   ActionLockTime := GetTickCount;
   Inc (SendCount);
end;

procedure TFrmMain.SendSpellMsg (ident, x, y, dir, target: integer);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (ident, MakeLong(x,y), Loword(target), dir, Hiword(target));
   SendSocket (EncodeMessage (msg));
   ActionLock := TRUE; //¼­¹ö¿¡¼­ #+FAIL! ÀÌ³ª #+GOOD!ÀÌ ¿Ã¶§±îÁö ±â´Ù¸²
   ActionLockTime := GetTickCount;
   Inc (SendCount);
end;

procedure TFrmMain.SendQueryUserName (targetid, x, y: integer);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_QUERYUSERNAME, targetid, x, y, 0);
   SendSocket (EncodeMessage (msg));
end;

procedure TFrmMain.SendDropItem (name: string; itemserverindex: integer);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_DROPITEM, itemserverindex, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString (name));
end;

procedure TFrmMain.SendPickup;
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_PICKUP, 0, Myself.XX, Myself.YY, 0);
   SendSocket (EncodeMessage (msg));
end;

procedure TFrmMain.SendTakeOnItem (where: byte; itmindex: integer; itmname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_TAKEONITEM, itmindex, where, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;

procedure TFrmMain.SendTakeOffItem (where: byte; itmindex: integer; itmname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_TAKEOFFITEM, itmindex, where, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;
//³Ô¶«Î÷
procedure TFrmMain.SendEat (itmindex: integer; itmname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_EAT, itmindex, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString (itmname));
end;
//Ô×É±¶¯Îï
procedure TFrmMain.SendButchAnimal (x, y, dir, actorid: integer);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_BUTCH, actorid, x, y, dir);
   SendSocket (EncodeMessage (msg));
end;

procedure TFrmMain.SendMagicKeyChange (magid: integer; keych: char);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_MAGICKEYCHANGE, magid, byte(keych), 0, 0);
   SendSocket (EncodeMessage (msg));
end;

procedure TFrmMain.SendMerchantDlgSelect (merchant: integer; rstr: string);
var
   msg: TDefaultMessage;
   param: string;
begin
   if Length(rstr) >= 2 then begin  //ÆÄ¶ó¸ÞÅ¸°¡ ÇÊ¿äÇÑ °æ¿ì°¡ ÀÖÀ½.
      if (rstr[1] = '@') and (rstr[2] = '@') then begin
         if rstr = '@@buildguildnow' then
            FrmDlg.DMessageDlg ('´´½¨ÐÐ»á£¬ÇëÊäÈëÐÐ»áÃû³Æ.', [mbOk, mbAbort])
         else FrmDlg.DMessageDlg ('ÐÐ»áÃû³Æ.', [mbOk, mbAbort]);
         param := Trim (FrmDlg.DlgEditText);
         rstr := rstr + #13 + param;
      end;
   end;
   msg := MakeDefaultMsg (CM_MERCHANTDLGSELECT, merchant, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString (rstr));
end;
//ÎÊÃÇÎïÆ·¼Û¸ñ
procedure TFrmMain.SendQueryPrice (merchant, itemindex: integer; itemname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_MERCHANTQUERYSELLPRICE, merchant, Loword(itemindex), Hiword(itemindex), 0);
   SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;
//Ñ¯ÎÊÐÞÀí¼Û¸ñ
procedure TFrmMain.SendQueryRepairCost (merchant, itemindex: integer; itemname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_MERCHANTQUERYREPAIRCOST, merchant, Loword(itemindex), Hiword(itemindex), 0);
   SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;
//·¢ËÍÒª³öÊÛµÄÎïÆ·
procedure TFrmMain.SendSellItem (merchant, itemindex: integer; itemname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_USERSELLITEM, merchant, Loword(itemindex), Hiword(itemindex), 0);
   SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;
//·¢ËÍÒªÐÞÀíµÄÎïÆ·
procedure TFrmMain.SendRepairItem (merchant, itemindex: integer; itemname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_USERREPAIRITEM, merchant, Loword(itemindex), Hiword(itemindex), 0);
   SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;
//·¢ËÍÒª´æ·ÅµÄÎïÆ·
procedure TFrmMain.SendStorageItem (merchant, itemindex: integer; itemname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_USERSTORAGEITEM, merchant, Loword(itemindex), Hiword(itemindex), 0);
   SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;

procedure TFrmMain.SendGetDetailItem (merchant, menuindex: integer; itemname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_USERGETDETAILITEM, merchant, menuindex, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;

procedure TFrmMain.SendBuyItem (merchant, itemserverindex: integer; itemname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_USERBUYITEM, merchant, Loword(itemserverindex), Hiword(itemserverindex), 0);
   SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;

procedure TFrmMain.SendTakeBackStorageItem (merchant, itemserverindex: integer; itemname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_USERTAKEBACKSTORAGEITEM, merchant, Loword(itemserverindex), Hiword(itemserverindex), 0);
   SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;

procedure TFrmMain.SendMakeDrugItem (merchant: integer; itemname: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_USERMAKEDRUGITEM, merchant, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString (itemname));
end;

procedure TFrmMain.SendDropGold (dropgold: integer);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_DROPGOLD, dropgold, 0, 0, 0);
   SendSocket (EncodeMessage (msg));
end;

procedure TFrmMain.SendGroupMode (onoff: Boolean);
var
   msg: TDefaultMessage;
begin
   if onoff then
      msg := MakeDefaultMsg (CM_GROUPMODE, 0, 1, 0, 0)   //on
   else msg := MakeDefaultMsg (CM_GROUPMODE, 0, 0, 0, 0);  //off
   SendSocket (EncodeMessage (msg));
end;

procedure TFrmMain.SendCreateGroup (withwho: string);
var
   msg: TDefaultMessage;
begin
   if withwho <> '' then begin
      msg := MakeDefaultMsg (CM_CREATEGROUP, 0, 0, 0, 0);
      SendSocket (EncodeMessage (msg) + EncodeString (withwho));
   end;
end;

procedure TFrmMain.SendWantMiniMap;
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_WANTMINIMAP, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg));
end;

procedure TFrmMain.SendDealTry;
var
   msg: TDefaultMessage;
   i, fx, fy: integer;
   actor: TActor;
   who: string;
   proper: Boolean;
begin
   (*proper := FALSE;
   GetFrontPosition (Myself.XX, Myself.YY, Myself.Dir, fx, fy);
   with PlayScene do
      for i:=0 to ActorList.Count-1 do begin
         actor := TActor (ActorList[i]);
         if {(actor.Race = 0) and} (actor.XX = fx) and (actor.YY = fy) then begin
            proper := TRUE;
            who := actor.UserName;
            break;
         end;
      end;
   if proper then begin*)
      msg := MakeDefaultMsg (CM_DEALTRY, 0, 0, 0, 0);
      SendSocket (EncodeMessage (msg) + EncodeString (who));
   //end;
end;

procedure TFrmMain.SendGuildDlg;
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_OPENGUILDDLG, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg));
end;

procedure TFrmMain.SendCancelDeal;
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_DEALCANCEL, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg));
end;

procedure TFrmMain.SendAddDealItem (ci: TClientItem);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_DEALADDITEM, ci.MakeIndex, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString (ci.S.Name));
end;

procedure TFrmMain.SendDelDealItem (ci: TClientItem);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_DEALDELITEM, ci.MakeIndex, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString (ci.S.Name));
end;

procedure TFrmMain.SendChangeDealGold (gold: integer);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_DEALCHGGOLD, gold, 0, 0, 0);
   SendSocket (EncodeMessage (msg));
end;

procedure TFrmMain.SendDealEnd;
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_DEALEND, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg));
end;

procedure TFrmMain.SendAddGroupMember (withwho: string);
var
   msg: TDefaultMessage;
begin
   if withwho <> '' then begin
      msg := MakeDefaultMsg (CM_ADDGROUPMEMBER, 0, 0, 0, 0);
      SendSocket (EncodeMessage (msg) + EncodeString (withwho));
   end;
end;

procedure TFrmMain.SendDelGroupMember (withwho: string);
var
   msg: TDefaultMessage;
begin
   if withwho <> '' then begin
      msg := MakeDefaultMsg (CM_DELGROUPMEMBER, 0, 0, 0, 0);
      SendSocket (EncodeMessage (msg) + EncodeString (withwho));
   end;
end;

procedure TFrmMain.SendGuildHome;
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_GUILDHOME, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg));
end;

procedure TFrmMain.SendGuildMemberList;
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_GUILDMEMBERLIST, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg));
end;

procedure TFrmMain.SendGuildAddMem (who: string);
var
   msg: TDefaultMessage;
begin
   if Trim(who) <> '' then begin
      msg := MakeDefaultMsg (CM_GUILDADDMEMBER, 0, 0, 0, 0);
      SendSocket (EncodeMessage (msg) + EncodeString (who));
   end;
end;

procedure TFrmMain.SendGuildDelMem (who: string);
var
   msg: TDefaultMessage;
begin
   if Trim(who) <> '' then begin
      msg := MakeDefaultMsg (CM_GUILDDELMEMBER, 0, 0, 0, 0);
      SendSocket (EncodeMessage (msg) + EncodeString (who));
   end;
end;

//¹®ÀÚ¿­ÀÇ ±æÀÌ°¡ ³Ê¹«±æÁö ¾Êµµ·Ï Â©·Á¼­ ¿Â´Ù.
procedure TFrmMain.SendGuildUpdateNotice (notices: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_GUILDUPDATENOTICE, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString (notices));
end;

procedure TFrmMain.SendGuildUpdateGrade (rankinfo: string);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_GUILDUPDATERANKINFO, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeString (rankinfo));
end;

procedure TFrmMain.SendSpeedHackUser;
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_SPEEDHACKUSER, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg));
end;

procedure TFrmMain.SendAdjustBonus (remain: integer; babil: TNakedAbility);
var
   msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_ADJUST_BONUS, remain, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeBuffer (@babil, sizeof(TNakedAbility)));
end;


{---------------------------------------------------------------}


function  TFrmMain.ServerAcceptNextAction: Boolean;
begin
   Result := TRUE;
   //Èô·þÎñÆ÷Î´ÏìÓ¦¶¯×÷ÃüÁî£¬Ôò10Ãëºó×Ô¶¯½âËø
   if ActionLock then begin
      if GetTickCount - ActionLockTime > 1 * 100 then begin
         ActionLock := FALSE;
         exit;
      end;
      Result := FALSE;
   end;
end;

function  TFrmMain.CanNextAction: Boolean;
begin
   if (Myself.IsIdle) and
      (Myself.State and $04000000 = 0) and
      (GetTickCount - DizzyDelayStart > DizzyDelayTime)
   then begin
      Result := TRUE;
   end else
      Result := FALSE;
end;

function  TFrmMain.CanNextHit: Boolean;  //²À »ç¿ëÇÏ±â Á÷Àü¿¡ È£ÃâÇØ¾ß ÇÔ.
var
   nexthit, levelfast: integer;
begin
   levelfast := _MIN (370, (Myself.Abil.Level * 14));
   levelfast := _MIN (800, levelfast + Myself.HitSpeed * 60);
   if BoAttackSlow then
      nexthit := 1400 - levelfast + 1500 //³Ê¹« ¸¹ÀÌ µé¾ú°Å³ª, ¿ÊÀÌ ³Ê¹« ¹«°Å¿ò.
   else nexthit := 1400 - levelfast;
   if nexthit < 0 then nexthit := 0;
   if GetTickCount - LastHitTime > longword(nexthit) then begin
      LastHitTime := GetTickCount;
      Result := TRUE;
   end else Result := FALSE;
end;

procedure TFrmMain.ActionFailed;
begin
   TargetX := -1;
   TargetY := -1;
   ActionFailLock := TRUE; //°°Àº ¹æÇâÀ¸·Î ¿¬¼ÓÀÌµ¿½ÇÆÐ¸¦ ¸·±âÀ§ÇØ¼­, FailDir°ú ÇÔ²² »ç¿ë
   Myself.MoveFail;
end;

function  TFrmMain.IsUnLockAction (action, adir: integer): Boolean;
begin
   if (ActionFailLock and (action = FailAction) and (adir = FailDir))
      or (MapMoving)
      or (BoServerChanging) then begin
      Result := FALSE;
   end else begin
      ActionFailLock := FALSE;
      Result := TRUE;
   end;
end;

function TFrmMain.IsGroupMember (uname: string): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=0 to GroupMembers.Count-1 do
      if GroupMembers[i] = uname then begin
         Result := TRUE;
         break;
      end;
end;

{-------------------------------------------------------------}

procedure TFrmMain.Timer1Timer(Sender: TObject);
var
   str, data: string;
   len, i, n, mcnt : integer;
const
   busy: Boolean = FALSE;
begin
   if busy then exit;
   busy := TRUE;
   try
      BufferStr := BufferStr + SocStr;
      SocStr := '';
      if BufferStr <> '' then begin
         mcnt := 0;
         while Length(BufferStr) >= 2 do begin
            if MapMovingWait then break; // ´ë±â..
            if Pos('!', BufferStr) <= 0 then break;
            BufferStr := ArrestStringEx (BufferStr, '#', '!', data);

            if data <> '' then begin
               DecodeMessagePacket (data);
            end else
               if Pos('!', BufferStr) = 0 then
                  break;
         end;
      end;
   finally
      busy := FALSE;
   end;

   if WarningLevel > 30 then
      FrmMain.Close;

   if BoQueryPrice then begin
      if GetTickCount - QueryPriceTime > 500 then begin
         BoQueryPrice := FALSE;
         case FrmDlg.SpotDlgMode of
            dmSell: SendQueryPrice (CurMerchant, SellDlgItem.MakeIndex, SellDlgItem.S.Name);
            dmRepair: SendQueryRepairCost (CurMerchant, SellDlgItem.MakeIndex, SellDlgItem.S.Name);
         end;
      end;
   end;

   if BonusPoint > 0 then begin
      FrmDlg.DBotPlusAbil.Visible := TRUE;
   end else begin
      FrmDlg.DBotPlusAbil.Visible := FALSE;
   end;

end;

//ËÙ¶È×÷±×¼ì²âÊ±ÖÓÊÂ¼þ(Ã¿Ãë4´Î£©
//Ö÷ÒªÊÇ¼ì²éÏµÍ³Ê±ÖÓºÍCPUÖ®¼äÖ®¼äµÄ²î±ð
//ÈôÔÚÒ»ÃëÄÚÁ¬ÐøËÄ´ÎÐÞ¸ÄÏµÍ³ÖÐ¼ä£¬½«¿ÉÄÜ³öÏÖËÙ¶È×÷±×ÏÓÒÉ
procedure TFrmMain.SpeedHackTimerTimer(Sender: TObject);
var
   gcount, timer: longword;
   ahour, amin, asec, amsec: word;
begin
   DecodeTime (Time, ahour, amin, asec, amsec);
   timer := ahour * 1000 * 60 * 60 + amin * 1000 * 60 + asec * 1000 + amsec;
   gcount := GetTickCount;
   if SHGetTime > 0 then begin
      if abs((gcount - SHGetTime) - (timer - SHTimerTime)) > 70 then begin
         Inc (SHFakeCount);
      end else
         SHFakeCount := 0;
      if SHFakeCount > 4 then begin
         FrmDlg.DMessageDlg ('ÄãÓÐ×÷±×ÏÓÒÉ. CODE=10001\' +
                             'ÇëÓë¹ÜÀíÔ±ÁªÏµ. [eMediaWorkshop@Hotmail.com]',
                             [mbOk]);
         FrmMain.Close;
      end;
      if BoCheckSpeedHackDisplay then begin
         DScreen.AddSysMsg ('->' + IntToStr(gcount - SHGetTime) + ' - ' +
                                   IntToStr(timer - SHTimerTime) + ' = ' +
                                   IntToStr(abs((gcount - SHGetTime) - (timer - SHTimerTime))) + ' (' +
                                   IntToStr(SHFakeCount) + ')');
      end;
   end;
   SHGetTime := gcount;
   SHTimerTime := timer;
end;

procedure TFrmMain.CheckSpeedHack (rtime: Longword);
var
   cltime, svtime: integer;
   str: string;
begin
   if FirstServerTime > 0 then begin
      if (GetTickCount - FirstClientTime) > 1 * 60 * 60 * 1000 then begin  //1½Ã°£ ¸¶´Ù ÃÊ±âÈ­
         FirstServerTime := rtime; //ÃÊ±âÈ­
         FirstClientTime := GetTickCount;
         //ServerTimeGap := rtime - int64(GetTickCount);
      end;
      cltime := GetTickCount - FirstClientTime;
      svtime := rtime - FirstServerTime + 3000;

      if cltime > svtime then begin
         Inc (TimeFakeDetectCount);
         if TimeFakeDetectCount > 6 then begin
            //½Ã°£Á¶ÀÛ...
            str := 'Bad';
            //SendSpeedHackUser;
            FrmDlg.DMessageDlg ('´æÔÚ×÷±×ÏÓÒÉ. CODE=10000\' +
                                '½«¹Ø±ÕÓÎÏ·.\' +
                                'ÈôÓÐÕùÒéÇëÓë¹ÜÀíÔ±ÁªÏµ. [eMediaWorkshop@Hotmail.com]',
                                [mbOk]);
            FrmMain.Close;
         end;
      end else begin
         str := 'Good';
         TimeFakeDetectCount := 0;
      end;
      if BoCheckSpeedHackDisplay then begin
         DScreen.AddSysMsg (IntToStr(svtime) + ' - ' +
                            IntToStr(cltime) + ' = ' +
                            IntToStr(svtime-cltime) +
                            ' ' + str);
      end;
   end else begin
      FirstServerTime := rtime;
      FirstClientTime := GetTickCount;
      //ServerTimeGap := int64(GetTickCount) - longword(msg.Recog);
   end;
end;

procedure TFrmMain.DecodeMessagePacket (datablock: string);
var
   head, body, body2, tagstr, data, rdstr, str: String;
   msg : TDefaultMessage;
   smsg: TShortMessage;
   mbw: TMessageBodyW;
   desc: TCharDesc;
   wl: TMessageBodyWL;
   featureEx: word;
   L, i, j, n, BLKSize, param, sound, cltime, svtime: integer;
   tempb: boolean;
   actor: TActor;
   event: TClEvent;
begin
   if datablock[1] = '+' then begin  //checkcode
      data := Copy (datablock, 2, Length(datablock)-1);
      data := GetValidStr3 (data, tagstr, ['/']);
      if tagstr = 'PWR' then BoNextTimePowerHit := TRUE;  //´ÙÀ½¹ø¿¡ powerhitÀ» ¶§¸± ¼ö ÀÖÀ½...
      if tagstr = 'LNG' then BoCanLongHit := TRUE;
      if tagstr = 'ULNG' then BoCanLongHit := FALSE;
      if tagstr = 'WID' then BoCanWideHit := TRUE;
      if tagstr = 'UWID' then BoCanWideHit := FALSE;
      if tagstr = 'FIR' then begin
         BoNextTimeFireHit := TRUE;  //¿°È­°áÀÌ ¼¼ÆÃµÈ »óÅÂ
         LatestFireHitTime := GetTickCount;
         //Myself.SendMsg (SM_READYFIREHIT, Myself.XX, Myself.YY, Myself.Dir, 0, 0, '', 0);
      end;
      if tagstr = 'UFIR' then BoNextTimeFireHit := FALSE;
      if tagstr = 'GOOD' then begin
         ActionLock := FALSE;
         Inc (ReceiveCount);
      end;
      if tagstr = 'FAIL' then begin
         ActionFailed;
         ActionLock := FALSE;
         Inc (ReceiveCount);
      end;
      //DScreen.AddSysmsg (data);
      if data <> '' then begin
         CheckSpeedHack (Str_ToInt(data, 0));
      end;
      exit;
   end;
   if Length(datablock) < DEFBLOCKSIZE then begin
      if datablock[1] = '=' then begin
         data := Copy (datablock, 2, Length(datablock)-1);
         if data = 'DIG' then begin
            Myself.BoDigFragment := TRUE;
         end;
      end;
      exit;
   end;

   head := Copy (datablock, 1, DEFBLOCKSIZE);
   body := Copy (datablock, DEFBLOCKSIZE+1, Length(datablock)-DEFBLOCKSIZE);
   msg  := DecodeMessage (head);

   DScreen.AddSysMsg (IntToStr(msg.Ident));

   if Myself = nil then begin
      case msg.Ident of
         SM_NEWID_SUCCESS:
            begin
               FrmDlg.DMessageDlg ('ÐÂÕÊºÅ½¨Á¢³É¹¦\' +
                                   'ÈôÄãÓÐµãÊý¿¨£¬Çë³äÖµ.\' +
                                   'ÈôÃ»ÓÐ£¬Çë·ÃÎÊ¹Ù·½ÍøÕ¾¹ºÂò', [mbOk]);
            end;
         SM_NEWID_FAIL:
            begin
               case msg.Recog of
                  0: begin
                        FrmDlg.DMessageDlg ('"' + MakeNewId + '"ÕÊºÅÒÑ¾­´æÔÚ.\' +
                                            'ÇëÄãÖØÐÂÊäÈëÒ»¸ö²»Í¬µÄÕÊºÅ.',
                                            [mbOk]);
                        LoginScene.NewIdRetry (FALSE);  //´Ù½Ã ½Ãµµ
                     end;
                  -2: FrmDlg.DMessageDlg ('½¨Á¢ÕÊºÅÊ§°Ü£¬ÏµÍ³ÕýÃ¦.\ÓÐ¹ØÐÅÏ¢Çë·ÃÎÊ: http://www.eMediaWorkshop.com', [mbOk]);
                  else FrmDlg.DMessageDlg ('ÎÞ·¨½¨Á¢ÕÊºÅ,¿ÉÄÜÏµÍ³ÕýÃ¦£¬\»ò´ïµ½×î´óÁ¬½ÓÊý¡£ÇëÉÔºóÔÙÊÔ¡£', [mbOk]);
               end;
            end;
         SM_PASSWD_FAIL:
            begin
               case msg.Recog of
                  -1: FrmDlg.DMessageDlg ('ÕÊºÅ²»´æÔÚ.', [mbOk]);
                  -2: FrmDlg.DMessageDlg ('ÕÊºÅºÍÃÜÂë²»Æ¥Åä.', [mbOk]);
                  -3: FrmDlg.DMessageDlg ('ÕÊÉÏÓà¶î²»×ã£¬Çë¼°Ê±³äÖµ.', [mbOk]);
                  -4: FrmDlg.DMessageDlg ('ÕÊºÅ±»·ê£¬ÏêÇéÇë²éÑ¯ http://www.eMediaWorkshop.com', [mbOk]);
                  -5: FrmDlg.DMessageDlg ('ÕÊºÅ±»·ê£¬ÏêÇéÇë²éÑ¯ http://www.eMediaWorkshop.com', [mbOk]);
                  else  FrmDlg.DMessageDlg ('µÇÂ¼´íÎó£¬ÇëÉÔºóÔÙÊÔ.', [mbOk]);
               end;
               LoginScene.PassWdFail;
            end;
         SM_NEEDUPDATE_ACCOUNT: //°èÁ¤ Á¤º¸¸¦ ´Ù½Ã ÀÔ·ÂÇÏ¶ó.
            begin
               ClientGetNeedUpdateAccount (body);
            end;
         SM_UPDATEID_SUCCESS:
            begin
               FrmDlg.DMessageDlg ('¸üÐÂÕÊºÅ³É¹¦\Çë¼°Ê±³äÖµ.\' , [mbOk]);
               ClientGetSelectServer;
            end;
         SM_UPDATEID_FAIL:
            begin
               FrmDlg.DMessageDlg ('¸üÐÂÕÊºÅÊ§°Ü.', [mbOk]);
               ClientGetSelectServer;
            end;
         SM_PASSOK_SELECTSERVER:
            begin
               FrmDlg.DMessageDlg ('µÇÂ¼³É¹¦£¬ÏÖÔÚÇëÑ¡Ôñ·þÎñÆ÷¡£', [mbOk]);
               AvailIDDay := Loword(msg.Recog);
               AvailIDHour := Hiword(msg.Recog);
               AvailIPDay := msg.Param;
               AvailIPHour := msg.Tag;

               if AvailIDDay > 0 then begin
                  if AvailIDDay = 1 then
                     FrmDlg.DMessageDlg ('ÄúµÄÕÊºÅÖ»ÓÐÒ»ÌìºÃÓÃÁË£¡Çë¼°Ê±³äÖµ.', [mbOk])
                  else if AvailIDDay <= 3 then
                     FrmDlg.DMessageDlg ('ÄãµÄÕÊºÅ»¹ÓÐ' + IntToStr(AvailIDDay) + ' Ìì¾ÍÒª¹ýÆÚÁË¡£Çë¼°Ê±³äÖµ.', [mbOk]);
               end else if AvailIPDay > 0 then begin
                  if AvailIPDay = 1 then
                     FrmDlg.DMessageDlg ('ÄúÔÚÕâ¸ö·þÎñÆ÷ÉÏÖ»ÓÐ½ñÌìºÃÓÃ', [mbOk])
                  else if AvailIPDay <= 3 then
                     FrmDlg.DMessageDlg ('ÄúÔÚÕâ¸ö·þÎñÆ÷ÉÏ»¹ÓÐ ' + IntToStr(AvailIPDay) + ' ÌìºÃÓÃ.', [mbOk]);
               end else if AvailIPHour > 0 then begin
                  if AvailIPHour <= 100 then
                     FrmDlg.DMessageDlg ('ÄúÔÚÕâ¸ö·þÎñÆ÷ÉÏ»¹ÓÐ  ' + IntToStr(AvailIPHour) + ' ¸öÐ¡Ê±ºÃÓÃ.', [mbOk]);
               end else if AvailIDHour > 0 then begin
                  FrmDlg.DMessageDlg ('ÄãµÄÕÊºÅ»¹ÓÐ ' + IntToStr(AvailIDHour) + ' ¸öÐ¡Ê±ºÃÓÃ.', [mbOk]);;
               end;

               if not LoginScene.BoUpdateAccountMode then
                  ClientGetSelectServer;
            end;
         SM_SELECTSERVER_OK:
            begin
               ClientGetPasswdSuccess (body);
            end;

         SM_QUERYCHR:
            begin
               ClientGetReceiveChrs (body);
            end;
         SM_QUERYCHR_FAIL:
            begin
               DoFastFadeOut := FALSE;
               DoFadeIn := FALSE;
               DoFadeOut := FALSE;
               FrmDlg.DMessageDlg ('»ñÈ¡½ÇÉ«ÐÅÏ¢Ê§°Ü£¬ÓÎÏ·½«½áÊø.', [mbOk]);
               Close;
            end;
         SM_NEWCHR_SUCCESS:
            begin
               SendQueryChr;
            end;
         SM_NEWCHR_FAIL:
            begin
               case msg.Recog of
                  2: FrmDlg.DMessageDlg ('[´íÎó] ´´½¨½ÇÉ«Ê§°Ü.', [mbOk]);
                  3: FrmDlg.DMessageDlg ('[´íÎó] ´´½¨½ÇÉ«Ê§°Ü£¬ÈôÓÐÎÊÌâÇëÓë¹ÜÀíÔ±ÁªÏµ. EMail: eMediaWorkshop@Hotail.com', [mbOk]);
                  4: FrmDlg.DMessageDlg ('[´íÎó] ´´½¨½ÇÉ«Ê§°Ü. Error=4', [mbOk]);
                  else FrmDlg.DMessageDlg ('[´íÎó] ´´½¨½ÇÉ«Ê§°Ü£¬ÈôÓÐÎÊÌâÇëÓë¹ÜÀíÔ±ÁªÏµ. EMail: eMediaWorkshop@Hotail.com', [mbOk]);
               end;
            end;
         SM_CHGPASSWD_SUCCESS:
            begin
               FrmDlg.DMessageDlg ('ÃÜÂëÐÞ¸Ä³É¹¦.', [mbOk]);
            end;
         SM_CHGPASSWD_FAIL:
            begin
               case msg.Recog of
                  -1: FrmDlg.DMessageDlg ('ÃÜÂëÐÞ¸ÄÊ§°Ü£¬Ô­ÃÜÂë´íÎó.', [mbOk]);
                  -2: FrmDlg.DMessageDlg ('ÃÜÂëÐÞ¸ÄÊ§°Ü£¬ÐÂÃÜÂë²»Ò»ÖÂ.', [mbOk]);
                  else FrmDlg.DMessageDlg ('ÃÜÂëÐÞ¸Ä´íÎó£¬ÇëÉÔºóÔÙÊÔ.', [mbOk]);
               end;
            end;
         SM_DELCHR_SUCCESS:
            begin
               SendQueryChr;
            end;
         SM_DELCHR_FAIL:
            begin
               FrmDlg.DMessageDlg ('[´íÎó] É¾³ý½ÇÉ«Ê§°Ü£¬ÇëÁªÏµ¹ÜÀíÔ±. EMail :  eMediaWorkshop@Hotail.com', [mbOk]);
            end;
         SM_STARTPLAY:
            begin
               ClientGetStartPlay (body);
               exit;
            end;
         SM_STARTFAIL:
            begin
               FrmDlg.DMessageDlg ('½øÈëÓÎÏ·Ê§°Ü£¬³ÌÐò½«ÍË³ö.', [mbOk]);
               FrmMain.Close;
               exit;
            end;
         SM_VERSION_FAIL:
            begin
               FrmDlg.DMessageDlg ('ÓÎÏ·°æ±¾ºÍ·þÎñÆ÷°æ±¾²»Ò»ÖÂ£¬Çë¼°Ê±¸üÐÂ£¬\ÏêÇéÇë·ÃÎÊ¹Ù·½ÍøÕ¾. (www.eMediaWorkshop.com', [mbOk]);
               FrmMain.Close;
               exit;
            end;
         SM_OUTOFCONNECTION,
         SM_NEWMAP,
         SM_LOGON,
         SM_RECONNECT,
         SM_SENDNOTICE: ;  //¾Æ·¡¿¡¼­ Ã³¸®
         else
            exit;
      end;
   end;
   if MapMoving then begin
      if msg.Ident = SM_CHANGEMAP then begin
         WaitingMsg := msg;
         WaitingStr := DecodeString (body);
         MapMovingWait := TRUE;
         WaitMsgTimer.Enabled := TRUE;
      end;
      exit;
   end;
   case msg.Ident of
      SM_NEWMAP:  // »õ·Î¿î ¸Ê¿¡ µé¾î°¨
         begin
            MapTitle := '';
            str := DecodeString (body); //mapname
            PlayScene.SendMsg (SM_NEWMAP, 0,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{darkness},
                                 0, 0,
                                 str{mapname});
         end;
       SM_LOGON:
         begin
            FirstServerTime := 0;
            FirstClientTime := 0;
            with msg do
            begin
               DecodeBuffer (body, @wl, sizeof(TMessageBodyWL));
               PlayScene.SendMsg (SM_LOGON, msg.Recog,
                                    msg.Param{x},
                                    msg.tag{y},
                                    msg.Series{dir},
                                    wl.lParam1, //desc.Feature,
                                    wl.lParam2, //desc.Status,
                                    '');
               DScreen.ChangeScene (stPlayGame);
               SendClientMessage (CM_QUERYBAGITEMS, 0, 0, 0, 0);
               if Lobyte(Loword(wl.lTag1)) = 1 then AllowGroup := TRUE
               else AllowGroup := FALSE;
               BoServerChanging := FALSE;
            end;
            if AvailIDDay > 0 then begin
               DScreen.AddChatBoardString ('AvailIDDay>0.Çë¼ÌÐøÊ¹ÓÃ', clGreen, clWhite)
            end else if AvailIPDay > 0 then begin
               DScreen.AddChatBoardString ('AvailIPDay>0.¹§Ï²£¡', clGreen, clWhite)
            end else if AvailIPHour > 0 then begin
               DScreen.AddChatBoardString ('IP ÓÐÐ§£¬Çë¼ÌÐøÊ¹ÓÃ.', clGreen, clWhite)
            end else if AvailIDHour > 0 then begin
               DScreen.AddChatBoardString ('AvailIDHour>0£¬Çë¼ÌÐøÊ¹ÓÃ.', clGreen, clWhite)
            end;
         end;

      SM_RECONNECT:
         begin
            ClientGetReconnect (body);
         end;

      SM_TIMECHECK_MSG:
         begin
            CheckSpeedHack (msg.Recog);
         end;

      SM_AREASTATE:
         begin
            AreaStateValue := msg.Recog;
         end;

      SM_MAPDESCRIPTION:
         begin
            ClientGetMapDescription (body);
         end;

      SM_ADJUST_BONUS:
         begin
            ClientGetAdjustBonus (msg.Recog, body);
         end;

      SM_MYSTATUS:
         begin
            MyHungryState := msg.Param;  //¹è°íÇ° »óÅÂ
         end;

      SM_TURN:
         begin
            if Length(body) > UpInt(sizeof(TCharDesc)*4/3) then begin
               Body2 := Copy (Body, UpInt(sizeof(TCharDesc)*4/3)+1, Length(body));
               data := DecodeString (body2); //Ä³¸¯ ÀÌ¸§
               str := GetValidStr3 (data, data, ['/']);
               //data = ÀÌ¸§
               //str = »ö°¥
            end else data := '';
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            PlayScene.SendMsg (SM_TURN, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir + light},
                                 desc.Feature,
                                 desc.Status,
                                 ''); //ÀÌ¸§
            if data <> '' then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then begin
                  actor.DescUserName := GetValidStr3(data, actor.UserName, ['\']);
                  //actor.UserName := data;
                  actor.NameColor := GetRGB(Str_ToInt(str, 0));
               end;
            end;
         end;

      SM_BACKSTEP:
         begin
            if Length(body) > UpInt(sizeof(TCharDesc)*4/3) then begin
               Body2 := Copy (Body, UpInt(sizeof(TCharDesc)*4/3)+1, Length(body));
               data := DecodeString (body2); //Ä³¸¯ ÀÌ¸§
               str := GetValidStr3 (data, data, ['/']);
               //data = ÀÌ¸§
               //str = »ö°¥
            end else data := '';
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            PlayScene.SendMsg (SM_BACKSTEP, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir + light},
                                 desc.Feature,
                                 desc.Status,
                                 ''); //ÀÌ¸§
            if data <> '' then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then begin
                  actor.DescUserName := GetValidStr3(data, actor.UserName, ['\']);
                  //actor.UserName := data;
                  actor.NameColor := GetRGB(Str_ToInt(str, 0));
               end;
            end;
         end;

      SM_SPACEMOVE_HIDE,
      SM_SPACEMOVE_HIDE2:
         begin
            if msg.Recog <> Myself.RecogId then begin
               PlayScene.SendMsg (msg.Ident, msg.Recog, msg.Param{x}, msg.tag{y}, 0, 0, 0, '')
            end;
         end;

      SM_SPACEMOVE_SHOW,
      SM_SPACEMOVE_SHOW2:
         begin
            if Length(body) > UpInt(sizeof(TCharDesc)*4/3) then begin
               Body2 := Copy (Body, UpInt(sizeof(TCharDesc)*4/3)+1, Length(body));
               data := DecodeString (body2); //Ä³¸¯ ÀÌ¸§
               str := GetValidStr3 (data, data, ['/']);
               //data = ÀÌ¸§
               //str = »ö°¥
            end else data := '';
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            if msg.Recog <> Myself.RecogId then begin //´Ù¸¥ Ä³¸¯ÅÍÀÎ °æ¿ì
               PlayScene.NewActor (msg.Recog, msg.Param, msg.tag, msg.Series, desc.feature, desc.Status);
            end;
            PlayScene.SendMsg (msg.Ident, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir + light},
                                 desc.Feature,
                                 desc.Status,
                                 ''); //ÀÌ¸§
            if data <> '' then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then begin
                  actor.DescUserName := GetValidStr3(data, actor.UserName, ['\']);
                  //actor.UserName := data;
                  actor.NameColor := GetRGB(Str_ToInt(str, 0));
               end;
            end;
         end;

      SM_WALK, SM_RUSH, SM_RUSHKUNG:
         begin
            //DScreen.AddSysMsg ('WALK ' + IntToStr(msg.Param) + ':' + IntToStr(msg.Tag));
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            if (msg.Recog <> Myself.RecogId) or (msg.Ident = SM_RUSH) or (msg.Ident = SM_RUSHKUNG) then
               PlayScene.SendMsg (msg.Ident, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir+light},
                                 desc.Feature,
                                 desc.Status, '');
            if msg.Ident = SM_RUSH then
               LatestRushRushTime := GetTickCount;                      
         end;

      SM_RUN:
         begin
            //DScreen.AddSysMsg ('RUN ' + IntToStr(msg.Param) + ':' + IntToStr(msg.Tag));
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            if msg.Recog <> Myself.RecogId then
               PlayScene.SendMsg (SM_RUN, msg.Recog,
                                    msg.Param{x},
                                    msg.tag{y},
                                    msg.Series{dir+light},
                                    desc.Feature,
                                    desc.Status, '');
         end;

      SM_CHANGELIGHT:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.ChrLight := msg.Param;
            end;
         end;

      SM_LAMPCHANGEDURA:
         begin
            if UseItems[U_RIGHTHAND].S.Name <> '' then begin
               UseItems[U_RIGHTHAND].Dura := msg.Recog;
            end;
         end;

      SM_MOVEFAIL:      //»ç¿ë ¾ÈÇÔ...
         begin
            ActionFailed;
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            PlayScene.SendMsg (SM_TURN, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir},
                                 desc.Feature,
                                 desc.Status, '');
         end;

      SM_BUTCH:
         begin
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            if msg.Recog <> Myself.RecogId then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then
                  actor.SendMsg (SM_SITDOWN,
                                    msg.Param{x},
                                    msg.tag{y},
                                    msg.Series{dir},
                                    0, 0, '', 0);
            end;
         end;
      SM_SITDOWN:
         begin
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            if msg.Recog <> Myself.RecogId then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then
                  actor.SendMsg (SM_SITDOWN,
                                    msg.Param{x},
                                    msg.tag{y},
                                    msg.Series{dir},
                                    0, 0, '', 0);
            end;
         end;

      SM_HIT,
      SM_HEAVYHIT,
      SM_POWERHIT,
      SM_LONGHIT,
      SM_WIDEHIT,
      SM_BIGHIT,
      SM_FIREHIT:
         begin
            if msg.Recog <> Myself.RecogId then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then begin
                  actor.SendMsg (msg.Ident,
                                    msg.Param{x},
                                    msg.tag{y},
                                    msg.Series{dir},
                                    0, 0, '',
                                    0);
                  if msg.ident = SM_HEAVYHIT then begin
                     if body <> '' then
                        actor.BoDigFragment := TRUE;
                  end;
               end;
            end;
         end;
      SM_FLYAXE:
         begin
            DecodeBuffer (body, @mbw, sizeof(TMessageBodyW));
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.SendMsg (msg.Ident,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir},
                                 0, 0, '',
                                 0);
               actor.TargetX := mbw.Param1;  //x ´øÁö´Â ¸ñÇ¥
               actor.TargetY := mbw.Param2;    //y
               actor.TargetRecog := MakeLong(mbw.Tag1, mbw.Tag2);
            end;
         end;

      SM_LIGHTING:
         begin
            DecodeBuffer (body, @wl, sizeof(TMessageBodyWL));
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.SendMsg (msg.Ident,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir},
                                 0, 0, '',
                                 0);
               actor.TargetX := wl.lParam1;  //x ´øÁö´Â ¸ñÇ¥
               actor.TargetY := wl.lParam2;    //y
               actor.TargetRecog := wl.lTag1;
               actor.MagicNum := wl.lTag2;   //¸¶¹ý ¹øÈ£
            end;
         end;

      SM_SPELL: //´Ù¸¥ ÀÌ°¡ ÁÖ¹®À» ¿Ü¿ò
         begin
            UseMagicSpell (msg.Recog{who}, msg.Series{effectnum}, msg.Param{tx}, msg.Tag{y}, Str_ToInt(body,0));
         end;
      SM_MAGICFIRE:
         begin
            DecodeBuffer (body, @param, sizeof(integer));
            UseMagicFire (msg.Recog{who}, Lobyte(msg.Series){efftype}, Hibyte(msg.Series){effnum}, msg.Param{tx}, msg.Tag{y}, param);
         end;
      SM_MAGICFIRE_FAIL:
         begin
            UseMagicFireFail (msg.Recog{who});
         end;


      SM_OUTOFCONNECTION:
         begin
            DoFastFadeOut := FALSE;
            DoFadeIn := FALSE;
            DoFadeOut := FALSE;
            FrmDlg.DMessageDlg ('³¬³ö·þÎñÆ÷Á¬½Ó×î´óÏÞÖÆ.\Äã²»µÃ²»ÍË³öÓÎÏ·£¬±§Ç¸.', [mbOk]);
            Close;
         end;

      SM_DEATH,
      SM_NOWDEATH:
         begin
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.SendMsg (msg.Ident,
                              msg.param{x}, msg.Tag{y}, msg.Series{damage},
                              desc.Feature, desc.Status, '',
                              0);
               actor.Abil.HP := 0;
            end else begin
               PlayScene.SendMsg (SM_DEATH, msg.Recog, msg.param{x}, msg.Tag{y}, msg.Series{damage}, desc.Feature, desc.Status, '');
            end;
         end;
      SM_SKELETON:
         begin
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            PlayScene.SendMsg (SM_SKELETON, msg.Recog, msg.param{HP}, msg.Tag{maxHP}, msg.Series{damage}, desc.Feature, desc.Status, '');
         end;
      SM_ALIVE:
         begin
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            PlayScene.SendMsg (SM_ALIVE, msg.Recog, msg.param{HP}, msg.Tag{maxHP}, msg.Series{damage}, desc.Feature, desc.Status, '');
         end;

      SM_ABILITY:
         begin
            Myself.Gold := msg.Recog;
            Myself.Job := msg.Param;
            DecodeBuffer (body, @Myself.Abil, sizeof(TAbility));
         end;

      SM_SUBABILITY:
         begin
            MyHitPoint   := Lobyte (msg.Param);
            MySpeedPoint := Hibyte (msg.Param);
            MyAntiPoison := Lobyte (msg.Tag);
            MyPoisonRecover := Hibyte (msg.Tag);
            MyHealthRecover := Lobyte (msg.Series);
            MySpellRecover := Hibyte (msg.Series);
            MyAntiMagic := lobyte (loword(msg.Recog));
         end;

      SM_DAYCHANGING:
         begin
            DayBright := msg.Param;
            DarkLevel := msg.Tag;
            if DarkLevel = 0 then ViewFog := FALSE
            else ViewFog := TRUE;
         end;

      SM_WINEXP:
         begin
            Myself.Abil.Exp := msg.Recog; //¿À¸¥ °æÇèÄ¡
            DScreen.AddChatBoardString ('Äã»ñµÃ ' + IntToStr(msg.Param) + ' µã¾­Ñé.',
                                 clWhite, clRed);
         end;

      SM_LEVELUP:
         begin
            DScreen.AddSysMsg ('¹§Ï²£¡ÄãÉý¼¶ÁË£¡');
         end;

      SM_HEALTHSPELLCHANGED:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.Abil.HP := msg.Param;
               actor.Abil.MP := msg.Tag;
               actor.Abil.MaxHP := msg.Series;
            end;
         end;

      SM_STRUCK:
         begin
            //wl: TMessageBodyWL;
            DecodeBuffer (body, @wl, sizeof(TMessageBodyWL));
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               if actor = Myself then begin
                  if Myself.NameColor = 249 then //»¡°»ÀÌ´Â ¸ÂÀ¸¸é Á¢¼ÓÀ» ¸ø ²÷´Â´Ù.
                     LatestStruckTime := GetTickCount;
               end else begin
                  if actor.CanCancelAction then
                     actor.CancelAction;
               end;
               actor.UpdateMsg (SM_STRUCK, wl.lTag2, 0,
                           msg.Series{damage}, wl.lParam1, wl.lParam2,
                           '', wl.lTag1{¶§¸°³ð¾ÆÀÌµð});
               actor.Abil.HP := msg.param;
               actor.Abil.MaxHP := msg.Tag;
            end;
         end;

      SM_CHANGEFACE:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               DecodeBuffer (body, @desc, sizeof(TCharDesc));
               actor.WaitForRecogId := MakeLong(msg.Param, msg.Tag);
               actor.WaitForFeature := desc.Feature;
               actor.WaitForStatus := desc.Status;
               AddChangeFace (actor.WaitForRecogId);
            end;
         end;

      SM_OPENHEALTH:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               if actor <> Myself then begin
                  actor.Abil.HP := msg.Param;
                  actor.Abil.MaxHP := msg.Tag;
               end;
               actor.BoOpenHealth := TRUE;
               //actor.OpenHealthTime := 999999999;
               //actor.OpenHealthStart := GetTickCount;
            end;
         end;
      SM_CLOSEHEALTH:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.BoOpenHealth := FALSE;
            end;
         end;
      SM_INSTANCEHEALGUAGE:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.Abil.HP := msg.param;
               actor.Abil.MaxHP := msg.Tag;
               actor.BoInstanceOpenHealth := TRUE;
               actor.OpenHealthTime := 2 * 1000;
               actor.OpenHealthStart := GetTickCount;
            end;
         end;

      SM_BREAKWEAPON:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               if actor is THumActor then
                  THumActor(actor).DoWeaponBreakEffect;
            end;
         end;

      SM_CRY,
      SM_GROUPMESSAGE,//   ±×·ì ¸Þ¼¼Áö
      SM_GUILDMESSAGE,
      SM_WHISPER,
      SM_SYSMESSAGE:
         begin
            str := DecodeString (body);
            DScreen.AddChatBoardString (str, GetRGB(Lobyte(msg.Param)), GetRGB(Hibyte(msg.Param)));
            if msg.Ident = SM_GUILDMESSAGE then
               FrmDlg.AddGuildChat (str);
         end;

      SM_HEAR:
         begin
            str := DecodeString (body);
            DScreen.AddChatBoardString (str, GetRGB(Lobyte(msg.Param)), GetRGB(Hibyte(msg.Param)));
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then
               actor.Say (str);
         end;

      SM_USERNAME:
         begin
            str := DecodeString (body);
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.DescUserName := GetValidStr3(str, actor.UserName, ['\']);
               //actor.UserName := str;
               actor.NameColor := GetRGB (msg.Param);
            end;
         end;
      SM_CHANGENAMECOLOR:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.NameColor := GetRGB (msg.Param);
            end;
         end;

      SM_HIDE,
      SM_GHOST,  //ÀÜ»ó..
      SM_DISAPPEAR:
         begin
            if Myself.RecogId <> msg.Recog then
               PlayScene.SendMsg (SM_HIDE, msg.Recog, msg.Param{x}, msg.tag{y}, 0, 0, 0, '');
         end;

      SM_DIGUP:
         begin
            DecodeBuffer (body, @wl, sizeof(TMessageBodyWL));
            actor := PlayScene.FindActor (msg.Recog);
            if actor = nil then
               actor := PlayScene.NewActor (msg.Recog, msg.Param, msg.tag, msg.Series, wl.lParam1, wl.lParam2);
            actor.CurrentEvent := wl.lTag1;
            actor.SendMsg (SM_DIGUP,
                           msg.Param{x},
                           msg.tag{y},
                           msg.Series{dir + light},
                           wl.lParam1,
                           wl.lParam2, '', 0);
         end;
      SM_DIGDOWN:
         begin
            PlayScene.SendMsg (SM_DIGDOWN, msg.Recog, msg.Param{x}, msg.tag{y}, 0, 0, 0, '');
         end;
      SM_SHOWEVENT:
         begin
            DecodeBuffer (body, @smsg, sizeof(TShortMessage));
            event := TClEvent.Create (msg.Recog, Loword(msg.Tag){x}, msg.Series{y}, msg.Param{e-type});
            event.Dir := 0;
            event.EventParam := smsg.Ident;
            EventMan.AddEvent (event);  //clvent°¡ FreeµÉ ¼ö ÀÖÀ½
         end;
      SM_HIDEEVENT:
         begin
            EventMan.DelEventById (msg.Recog);
         end;

      //Item ??
      SM_ADDITEM:
         begin
            ClientGetAddItem (body);
         end;
      SM_BAGITEMS:
         begin
            ClientGetBagItmes (body);
         end;
      SM_UPDATEITEM:
         begin
            ClientGetUpdateItem (body);
         end;
      SM_DELITEM:
         begin
            ClientGetDelItem (body);
         end;
      SM_DELITEMS:
         begin
            ClientGetDelItems (body);
         end;

      SM_DROPITEM_SUCCESS:
         begin
            DelDropItem (DecodeString(body), msg.Recog);
         end;
      SM_DROPITEM_FAIL:
         begin
            ClientGetDropItemFail (DecodeString(body), msg.Recog);
         end;

      SM_ITEMSHOW:
         begin
            ClientGetShowItem (msg.Recog, msg.param{x}, msg.Tag{y}, msg.Series{looks}, DecodeString(body));
         end;
      SM_ITEMHIDE:
         begin
            ClientGetHideItem (msg.Recog, msg.param, msg.Tag);
         end;

      SM_OPENDOOR_OK: //´©±º°¡¿¡ ÀÇÇØ ¹®ÀÌ ¿­¸²
         begin
            Map.OpenDoor (msg.param, msg.tag);
            //¹®¿©´Â ¼Ò¸®...
         end;

      SM_OPENDOOR_LOCK: //³»°¡ ¿­·Á°í ÇÑ ¹®ÀÌ Àá°ÜÀÖÀ½
         begin
            DScreen.AddSysMsg ('ÃÅÒÑ¾­ÉÏÁËËø.');
         end;
      SM_CLOSEDOOR:
         begin
            Map.CloseDoor (msg.param, msg.tag);
         end;

      SM_TAKEON_OK:
         begin
            Myself.Feature := msg.Recog;
            Myself.FeatureChanged;
            if WaitingUseItem.Index in [0..8] then
               UseItems[WaitingUseItem.Index] := WaitingUseItem.Item;
            WaitingUseItem.Item.S.Name := '';
         end;
      SM_TAKEON_FAIL:
         begin
            AddItemBag (WaitingUseItem.Item);
            WaitingUseItem.Item.S.Name := '';
         end;
      SM_TAKEOFF_OK:
         begin
            Myself.Feature := msg.Recog;
            Myself.FeatureChanged;
            WaitingUseItem.Item.S.Name := '';
         end;
      SM_TAKEOFF_FAIL:
         begin
            if WaitingUseItem.Index < 0 then begin
               n := -(WaitingUseItem.Index+1);
               UseItems[n] := WaitingUseItem.Item;
            end;
            WaitingUseItem.Item.S.Name := '';
         end;
      SM_EXCHGTAKEON_OK:       ;
      SM_EXCHGTAKEON_FAIL:     ;

      SM_SENDUSEITEMS:
         begin
            ClientGetSenduseItems (body);
         end;
      SM_WEIGHTCHANGED:
         begin
            Myself.Abil.Weight := msg.Recog;
            Myself.Abil.WearWeight := msg.Param;
            Myself.Abil.HandWeight := msg.Tag;
         end;
      SM_GOLDCHANGED:
         begin
            SoundUtil.PlaySound (s_money);
            if msg.Recog > Myself.Gold then begin
               DScreen.AddSysMsg ('»ñµÃ '+IntToStr(msg.Recog-Myself.Gold) + '½ð±Ò.');
            end;
            Myself.Gold := msg.Recog;
         end;
      SM_FEATURECHANGED:
         begin
            PlayScene.SendMsg (msg.Ident, msg.Recog, 0, 0, 0, MakeLong(msg.Param, msg.Tag), 0, '');
         end;
      SM_CHARSTATUSCHANGED:
         begin
            PlayScene.SendMsg (msg.Ident, msg.Recog, 0, 0, 0, MakeLong(msg.Param, msg.Tag), msg.Series, '');
         end;
      SM_CLEAROBJECTS:
         begin
            //PlayScene.CleanObjects;
            MapMoving := TRUE; //¸Ê ÀÌµ¿Áß
         end;

      SM_EAT_OK:
         begin
            EatingItem.S.Name := '';
            ArrangeItembag;
         end;
      SM_EAT_FAIL:
         begin
            AddItemBag (EatingItem);
            EatingItem.S.Name := '';
         end;

      SM_ADDMAGIC:
         begin
            if body <> '' then
               ClientGetAddMagic (body);
         end;
      SM_SENDMYMAGIC:
         begin
            if body <> '' then
               ClientGetMyMagics (body);
         end;
      SM_DELMAGIC:
         begin
            ClientGetDelMagic (msg.Recog);
         end;
      SM_MAGIC_LVEXP:
         begin
            ClientGetMagicLvExp (msg.Recog{magid}, msg.Param{lv}, MakeLong(msg.Tag, msg.Series));
         end;
      SM_DURACHANGE:
         begin
            ClientGetDuraChange (msg.Param{useitem index}, msg.Recog, MakeLong(msg.Tag, msg.Series));
         end;

      SM_MERCHANTSAY:
         begin
            ClientGetMerchantSay (msg.Recog, msg.Param, DecodeString (body));
         end;
      SM_MERCHANTDLGCLOSE:
         begin
            FrmDlg.CloseMDlg;
         end;
      SM_SENDGOODSLIST:
         begin
            ClientGetSendGoodsList (msg.Recog, msg.Param, body);
         end;
      SM_SENDUSERMAKEDRUGITEMLIST:
         begin
            ClientGetSendMakeDrugList (msg.Recog, body);
         end;
      SM_SENDUSERSELL:
         begin
            ClientGetSendUserSell (msg.Recog);
         end;
      SM_SENDUSERREPAIR:
         begin
            ClientGetSendUserRepair (msg.Recog);
         end;
      SM_SENDBUYPRICE:
         begin
            if SellDlgItem.S.Name <> '' then begin
               if msg.Recog > 0 then
                  SellPriceStr := IntToStr(msg.Recog) + ' Á½'
               else SellPriceStr := '????Á½';
            end;
         end;
      SM_USERSELLITEM_OK:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            Myself.Gold := msg.Recog;
            SellDlgItemSellWait.S.Name := '';
         end;

      SM_USERSELLITEM_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            AddItemBag (SellDlgItemSellWait);
            SellDlgItemSellWait.S.Name := '';
            FrmDlg.DMessageDlg ('³öÊÛÎïÆ·Ê§°Ü.', [mbOk]);
         end;

      SM_SENDREPAIRCOST:
         begin
            if SellDlgItem.S.Name <> '' then begin
               if msg.Recog >= 0 then
                  SellPriceStr := IntToStr(msg.Recog) + 'Á½'
               else SellPriceStr := '????Á½';
            end;
         end;
      SM_USERREPAIRITEM_OK:
         begin
            if SellDlgItemSellWait.S.Name <> '' then begin
               FrmDlg.LastestClickTime := GetTickCount;
               Myself.Gold := msg.Recog;
               SellDlgItemSellWait.Dura := msg.Param;
               SellDlgItemSellWait.DuraMax := msg.Tag;
               AddItemBag (SellDlgItemSellWait);
               SellDlgItemSellWait.S.Name := '';
            end;
         end;
      SM_USERREPAIRITEM_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            AddItemBag (SellDlgItemSellWait);
            SellDlgItemSellWait.S.Name := '';
            FrmDlg.DMessageDlg ('µÀ¾ßÐÞÀíÊ§°Ü.', [mbOk]);
         end;
      SM_STORAGE_OK,
      SM_STORAGE_FULL,
      SM_STORAGE_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            if msg.Ident <> SM_STORAGE_OK then begin
               if msg.Ident = SM_STORAGE_FULL then
                  FrmDlg.DMessageDlg ('ÎïÆ·´æ·ÅÊ§°Ü£¬°ü¹üÒÑ¾­ÂúÁË.', [mbOk])
               else
                  FrmDlg.DMessageDlg ('ÎïÆ·´æ·ÅÊ§°Ü.', [mbOk]);
               AddItemBag (SellDlgItemSellWait);
            end;
            SellDlgItemSellWait.S.Name := '';
         end;
      SM_SAVEITEMLIST:
         begin
            ClientGetSaveItemList (msg.Recog, body);
         end;
      SM_TAKEBACKSTORAGEITEM_OK,
      SM_TAKEBACKSTORAGEITEM_FAIL,
      SM_TAKEBACKSTORAGEITEM_FULLBAG:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            if msg.Ident <> SM_TAKEBACKSTORAGEITEM_OK then begin
               if msg.Ident = SM_TAKEBACKSTORAGEITEM_FULLBAG then
                  FrmDlg.DMessageDlg ('°ü¹üÒÑ¾­ÂúÁË.', [mbOk])
               else
                  FrmDlg.DMessageDlg ('È¡ÎïÆ·Ê§°Ü.', [mbOk]);
            end else
               FrmDlg.DelStorageItem (msg.Recog); //itemserverindex
         end;

      SM_BUYITEM_SUCCESS:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            Myself.Gold := msg.Recog;
            FrmDlg.SoldOutGoods (MakeLong(msg.Param, msg.Tag)); //ÆÈ¸° ¾ÆÀÌÅÛ ¸Þ´º¿¡¼­ »­
         end;
      SM_BUYITEM_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            case msg.Recog of
               1: FrmDlg.DMessageDlg ('½ðÇ®²»×ã£¬¹ºÂòÊ§°Ü.', [mbOk]);
               2: FrmDlg.DMessageDlg ('¶Ô·½²»Âô¸øÄã.', [mbOk]);
               3: FrmDlg.DMessageDlg ('ÄãµÄ³ö¼ÛÌ«µÍÁË.', [mbOk]);
            end;
         end;
      SM_MAKEDRUG_SUCCESS:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            Myself.Gold := msg.Recog;
            FrmDlg.DMessageDlg ('Ò©Æ·ÑÐÖÆ³É¹¦.', [mbOk]);
         end;
      SM_MAKEDRUG_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            case msg.Recog of
               1: FrmDlg.DMessageDlg ('Make drug fail.', [mbOk]);
               2: FrmDlg.DMessageDlg ('Make drug fail.', [mbOk]);
               3: FrmDlg.DMessageDlg ('Make drug fail.', [mbOk]);
               4: FrmDlg.DMessageDlg ('Make drug fail.', [mbOk]);
            end;
         end;

      SM_SENDDETAILGOODSLIST:
         begin
            ClientGetSendDetailGoodsList (msg.Recog, msg.Param, msg.Tag, body);
         end;

      SM_TEST:
         begin
            Inc (TestReceiveCount);
         end;

      SM_SENDNOTICE:
         begin
            ClientGetSendNotice (body);
         end;

      SM_GROUPMODECHANGED: //¼­¹ö¿¡¼­ ³ªÀÇ ±×·ì ¼³Á¤ÀÌ º¯°æµÇ¾úÀ½.
         begin
            if msg.Param > 0 then AllowGroup := TRUE
            else AllowGroup := FALSE;
            changegroupmodetime := GetTickCount;
         end;
      SM_CREATEGROUP_OK:
         begin
            changegroupmodetime := GetTickCount;
            AllowGroup := TRUE;
            {GroupMembers.Add (Myself.UserName);
            GroupMembers.Add (DecodeString(body));}
         end;
      SM_CREATEGROUP_FAIL:
         begin
            changegroupmodetime := GetTickCount;
            case msg.Recog of
               -1: FrmDlg.DMessageDlg ('´´½¨¶ÓÎéÊ§°Ü£¬ÈËÊýÒÔµ½×î´ó.', [mbOk]);
               -2: FrmDlg.DMessageDlg ('ÍþÐÅ²»¹»£¬ÎÞ·¨´´½¨¶ÓÎé.', [mbOk]);
               -3: FrmDlg.DMessageDlg ('¶ÓÎéÃû³ÆÖØ¸´.', [mbOk]);
               -4: FrmDlg.DMessageDlg ('¼¶±ð²»¹»£¬ÎÞ·¨´´½¨¶ÓÎé.', [mbOk]);
            end;
         end;
      SM_GROUPADDMEM_OK:
         begin
            changegroupmodetime := GetTickCount;
            //GroupMembers.Add (DecodeString(body));
         end;
      SM_GROUPADDMEM_FAIL:
         begin
            changegroupmodetime := GetTickCount;
            case msg.Recog of
               -1: FrmDlg.DMessageDlg ('¼ÓÈë¶ÓÎéÊ§°Ü£¬ÈËÊýÒÔµ½×î´ó.', [mbOk]);
               -2: FrmDlg.DMessageDlg ('Ìí¼Ó¶ÓÎé³ÉÔ±Ê§°Ü£¬¶Ô·½²»Í¬Òâ¼ÓÈë.', [mbOk]);
               -3: FrmDlg.DMessageDlg ('Ìí¼Ó¶ÓÎé³ÉÔ±Ê§°Ü£¬ÍþÐÅ²»¹».', [mbOk]);
               -4: FrmDlg.DMessageDlg ('Ìí¼Ó¶ÓÎé³ÉÔ±Ê§°Ü£¬¼¶±ð²»¹».', [mbOk]);
               -5: FrmDlg.DMessageDlg ('Ìí¼Ó¶ÓÎé³ÉÔ±Ê§°Ü£¬²»ÒªÎÊÎªÊ²Ã´Ê§°Ü.', [mbOk]);
            end;
         end;
      SM_GROUPDELMEM_OK:
         begin
            changegroupmodetime := GetTickCount;
            {data := DecodeString (body);
            for i:=0 to GroupMembers.Count-1 do begin
               if GroupMembers[i] = data then begin
                  GroupMembers.Delete (i);
                  break;
               end;
            end; }
         end;
      SM_GROUPDELMEM_FAIL:
         begin
            changegroupmodetime := GetTickCount;
            case msg.Recog of
               -1: FrmDlg.DMessageDlg ('±×·ìÀÌ ¾ÆÁ÷ °á¼ºµÇÁö ¾Ê¾Ò°Å³ª, ±ÇÇÑÀÌ ¾ø½À´Ï´Ù.', [mbOk]);
               -2: FrmDlg.DMessageDlg ('±×·ì¿¡ Âü¿©ÇÒ ÀÌ¸§ÀÌ ¹Ù¸£Áö ¾Ê½À´Ï´Ù.', [mbOk]);
               -3: FrmDlg.DMessageDlg ('¿ì¸® ±×·ì¿¡ Âü¿©ÇÏ°í ÀÖÁö ¾Ê½À´Ï´Ù.', [mbOk]);
            end;
         end;
      SM_GROUPCANCEL:
         begin
            GroupMembers.Clear;
         end;
      SM_GROUPMEMBERS:
         begin
            ClientGetGroupMembers (DecodeString(Body));
         end;

      SM_OPENGUILDDLG:
         begin
            querymsgtime := GetTickCount;
            ClientGetOpenGuildDlg (body);
         end;

      SM_SENDGUILDMEMBERLIST:
         begin
            querymsgtime := GetTickCount;
            ClientGetSendGuildMemberList (body);
         end;

      SM_OPENGUILDDLG_FAIL:
         begin
            querymsgtime := GetTickCount;
            FrmDlg.DMessageDlg ('¶ÁÈ¡ÐÐ»áÊ§°Ü.', [mbOk]);
         end;

      SM_DEALTRY_FAIL:
         begin
            querymsgtime := GetTickCount;
            FrmDlg.DMessageDlg ('°Å·¡°¡ Ãë¼ÒµÇ¾ú½À´Ï´Ù.\°Å·¡´Â »ç¿ëÀÚÀÎ »ó´ë¹æ°ú ¸¶ÁÖº¸°í ÇØ¾ß ÇÕ´Ï´Ù.', [mbOk]);
         end;
      SM_DEALMENU:
         begin
            querymsgtime := GetTickCount;
            DealWho := DecodeString (body);
            FrmDlg.OpenDealDlg;
         end;
      SM_DEALCANCEL:
         begin
            MoveDealItemToBag;
            if DealDlgItem.S.Name <> '' then begin
               AddItemBag (DealDlgItem);  //°¡¹æ¿¡ Ãß°¡
               DealDlgItem.S.Name := '';
            end;
            if DealGold > 0 then begin
               Myself.Gold := Myself.GOld + DealGold;
               DealGold := 0;
            end;
            FrmDlg.CloseDealDlg;
         end;

      SM_DEALADDITEM_OK:
         begin
            dealactiontime := GetTickCount;
            if DealDlgItem.S.Name <> '' then begin
               AddDealItem (DealDlgItem);  //Deal Dlg¿¡ Ãß°¡
               DealDlgItem.S.Name := '';
            end;
         end;
      SM_DEALADDITEM_FAIL:
         begin
            dealactiontime := GetTickCount;
            if DealDlgItem.S.Name <> '' then begin
               AddItemBag (DealDlgItem);  //°¡¹æ¿¡ Ãß°¡
               DealDlgItem.S.Name := '';
            end;
         end;
      SM_DEALDELITEM_OK:
         begin
            dealactiontime := GetTickCount;
            if DealDlgItem.S.Name <> '' then begin
               //AddItemBag (DealDlgItem);  //°¡¹æ¿¡ Ãß°¡
               DealDlgItem.S.Name := '';
            end;
         end;
      SM_DEALDELITEM_FAIL:
         begin
            dealactiontime := GetTickCount;
            if DealDlgItem.S.Name <> '' then begin
               DelItemBag (DealDlgItem.S.Name, DealDlgItem.MakeIndex);
               AddDealItem (DealDlgItem);
               DealDlgItem.S.Name := '';
            end;
         end;
      SM_DEALREMOTEADDITEM: ClientGetDealRemoteAddItem (body);
      SM_DEALREMOTEDELITEM: ClientGetDealRemoteDelItem (body);

      SM_DEALCHGGOLD_OK:
         begin
            DealGold := msg.Recog;
            Myself.Gold := MakeLong(msg.param, msg.tag);
            dealactiontime := GetTickCount;
         end;
      SM_DEALCHGGOLD_FAIL:
         begin
            DealGold := msg.Recog;
            Myself.Gold := MakeLong(msg.param, msg.tag);
            dealactiontime := GetTickCount;
         end;
      SM_DEALREMOTECHGGOLD:
         begin
            DealRemoteGold := msg.Recog;
            SoundUtil.PlaySound (s_money);  //»ó´ë¹æÀÌ µ·À» º¯°æÇÑ °æ¿ì ¼Ò¸®°¡ ³­´Ù.
         end;
      SM_DEALSUCCESS:
         begin
            FrmDlg.CloseDealDlg;
         end;

      SM_SENDUSERSTORAGEITEM:  //º¸°üÇÏ´Â Ã¢À» ¶ç¿ò.
         begin
            ClientGetSendUserStorage (msg.Recog);
         end;

      SM_READMINIMAP_OK:
         begin
            querymsgtime := GetTickCount;
            ClientGetReadMiniMap (msg.Param);
         end;

      SM_READMINIMAP_FAIL:
         begin
            querymsgtime := GetTickCount;
            DScreen.AddChatBoardString ('Ç¥½ÃÇÒ Áöµµ°¡ ¾ø½À´Ï´Ù.', clWhite, clRed);
         end;

      SM_CHANGEGUILDNAME:
         begin
            ClientGetChangeGuildName (DecodeString (body));
         end;

      SM_SENDUSERSTATE:
         begin
            ClientGetSendUserState (body);
         end;

      SM_GUILDADDMEMBER_OK:
         begin
            SendGuildMemberList;
         end;
      SM_GUILDADDMEMBER_FAIL:
         begin
            case msg.Recog of
               1: FrmDlg.DMessageDlg ('¸í·ÉÀÇ »ç¿ë±ÇÇÑÀÌ ¾ø½À´Ï´Ù.', [mbOk]);
               2: FrmDlg.DMessageDlg ('°¡ÀÔÇÏ·Á´Â »ç¶÷ÀÌ ¹®ÁÖ¿Í ¸¶ÁÖº¸°í ÀÖ¾î¾ß ÇÕ´Ï´Ù.', [mbOk]);
               3: FrmDlg.DMessageDlg ('ÀÌ¹Ì ¿ì¸® ¹®ÆÄ¿¡ °¡ÀÔµÇ¾î ÀÖ½À´Ï´Ù.', [mbOk]);
               4: FrmDlg.DMessageDlg ('ÀÌ¹Ì ´Ù¸¥ ¹®ÆÄ¿¡ °¡ÀÔµÇ¾î ÀÖ½À´Ï´Ù.', [mbOk]);
               5: FrmDlg.DMessageDlg ('»ó´ë¹æÀÌ ¹®ÆÄ°¡ÀÔÀ» Çã¿ëÇÏÁö ¾Ê¾Ò½À´Ï´Ù.', [mbOk]);
            end;
         end;
      SM_GUILDDELMEMBER_OK:
         begin
            SendGuildMemberList;
         end;
      SM_GUILDDELMEMBER_FAIL:
         begin
            case msg.Recog of
               1: FrmDlg.DMessageDlg ('¸í·ÉÀÇ »ç¿ë±ÇÇÑÀÌ ¾ø½À´Ï´Ù.', [mbOk]);
               2: FrmDlg.DMessageDlg ('¿ì¸® ¹®ÆÄÀÇ ¹®¿øÀÌ ¾Æ´Õ´Ï´Ù.', [mbOk]);
               3: FrmDlg.DMessageDlg ('¹®ÁÖ º»ÀÎÀÌ º»ÀÎÀ» Å»Åð ½ÃÅ³ ¼ö ¾ø½À´Ï´Ù.', [mbOk]);
               4: FrmDlg.DMessageDlg ('¸í·ÉÀ» »ç¿ëÇÒ ¼ö ¾ø½À´Ï´Ù.', [mbOk]);
            end;
         end;

      SM_GUILDRANKUPDATE_FAIL:
         begin
            case msg.Recog of
               -2: FrmDlg.DMessageDlg ('[º¯°æ¿À·ù] ¹®ÁÖ°¡ ºñ¾î ÀÖ½À´Ï´Ù.', [mbOk]);
               -3: FrmDlg.DMessageDlg ('[º¯°æ¿À·ù] ¹®ÁÖÀÇ ¸íÄ¢ÀÌ ºñ¾îÀÖ½À´Ï´Ù.', [mbOk]);
               -4: FrmDlg.DMessageDlg ('[º¯°æ¿À·ù] ¹®ÁÖ´Â 2¸íÀ» ÃÊ°úÇÒ ¼ö ¾ø½À´Ï´Ù.', [mbOk]);
               -5: FrmDlg.DMessageDlg ('[º¯°æ¿À·ù] º¯°æµÈ ¹®ÁÖ Áß¿¡¼­ Àû¾îµµ ÇÑ¸íÀÌ»óÀÌ Á¢¼ÓÇÏ°í\ ÀÖ¾î¾ß ÇÕ´Ï´Ù.', [mbOk]);
               -6: FrmDlg.DMessageDlg ('[º¯°æ¿À·ù] ¹®¿øÀÇ Ãß°¡/»èÁ¦¸¦ ÇÒ ¼ö ¾ø½À´Ï´Ù.', [mbOk]);
               -7: FrmDlg.DMessageDlg ('[º¯°æ¿À·ù] Á÷Ã¥ÀÌ Áßº¹µÇ¾îÀÖ°Å³ª Àß¸øµÇ¾ú½À´Ï´Ù.', [mbOk]);
            end;
         end;

      SM_GUILDMAKEALLY_OK,
      SM_GUILDMAKEALLY_FAIL:
         begin
            case msg.Recog of
               -1: FrmDlg.DMessageDlg ('´ç½ÅÀº ±ÇÇÑÀÌ ¾ø½À´Ï´Ù.', [mbOk]);
               -2: FrmDlg.DMessageDlg ('µ¿¸Í¿¡ ½ÇÆÐÇß½À´Ï´Ù.', [mbOk]);
               -3: FrmDlg.DMessageDlg ('µ¿¸ÍÇÏ°í ½ÍÀº ¹®ÁÖ¿Í ¸¶ÁÖºÁ¾ß ÇÕ´Ï´Ù.', [mbOk]);
               -4: FrmDlg.DMessageDlg ('»ó´ë¹®ÁÖ°¡ µ¿¸ÍÀ» Çã¿ëÇÏÁö ¾Ê°í ÀÖ½À´Ï´Ù.', [mbOk]);
            end;
         end;
      SM_GUILDBREAKALLY_OK,
      SM_GUILDBREAKALLY_FAIL:
         begin
            case msg.Recog of
               -1: FrmDlg.DMessageDlg ('´ç½ÅÀº ±ÇÇÑÀÌ ¾ø½À´Ï´Ù.', [mbOk]);
               -2: FrmDlg.DMessageDlg ('±× ¹®ÆÄ¿Í µ¿¸ÍÁßÀÌ ¾Æ´Õ´Ï´Ù.', [mbOk]);
               -3: FrmDlg.DMessageDlg ('Á¸ÀçÇÏÁö ¾Ê´Â ¹®ÆÄÀÔ´Ï´Ù.', [mbOk]);
            end;
         end;


      SM_BUILDGUILD_OK:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            FrmDlg.DMessageDlg ('¹®ÆÄ°¡ ¸¸µé¾î Á³½À´Ï´Ù.', [mbOk]);
         end;

      SM_BUILDGUILD_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            case msg.Recog of
               -1: FrmDlg.DMessageDlg ('ÀÌ¹Ì ¹®ÆÄ¿¡ °¡ÀÔÇØ ÀÖ½À´Ï´Ù.', [mbOk]);
               -2: FrmDlg.DMessageDlg ('µî·Ïºñ¿ëÀÌ ºÎÁ·ÇÕ´Ï´Ù.', [mbOk]);
               -3: FrmDlg.DMessageDlg ('ÇÊ¿ä¾ÆÀÌÅÛÀ» ¸ðµÎ °¡Áö°í ÀÖÁö ¾Ê½À´Ï´Ù.', [mbOk]);
            end;
         end;
      SM_MENU_OK:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            if body <> '' then
               FrmDlg.DMessageDlg (DecodeString(body), [mbOk]);
         end;
      SM_DLGMSG:
         begin
            if body <> '' then
               FrmDlg.DMessageDlg (DecodeString(body), [mbOk]);
         end;


      SM_DONATE_OK:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
         end;

      SM_DONATE_FAIL: 
         begin
            FrmDlg.LastestClickTime := GetTickCount;
         end;

      else begin
            DScreen.AddSysMsg (IntToStr(msg.Ident) + ' : ' + body);
         end;

   end;

   if Pos('#', datablock) > 0 then
      DScreen.AddSysMsg (datablock);
end;

procedure TFrmMain.ClientGetPasswdSuccess (body: string);
var
   str, runaddr, runport, uid, certifystr: string;
begin
   str := DecodeString (body);
   str := GetValidStr3 (str, runaddr, ['/']);
   str := GetValidStr3 (str, runport, ['/']);
   str := GetValidStr3 (str, certifystr, ['/']);
   Certification := Str_ToInt(certifystr, 0);

   if not BoOneClick then begin
      CSocket.Active := FALSE;  //·Î±×ÀÎ¿¡ ¿¬°áµÈ ¼ÒÄÏ ´ÝÀ½
      FrmDlg.DSelServerDlg.Visible := FALSE;
      WaitAndPass (500); //0.5ÃÊµ¿¾È ±â´Ù¸²
      ConnectionStep := cnsSelChr;
      with CSocket do begin
         SelChrAddr := runaddr;
         SelChrPort := Str_ToInt (runport, 0);
         Address := SelChrAddr;
         Port := SelChrPort;
         Active := TRUE;
      end;
   end else begin
      FrmDlg.DSelServerDlg.Visible := FALSE;
      SelChrAddr := runaddr;
      SelChrPort := Str_ToInt (runport, 0);
      if CSocket.Socket.Connected then
         CSocket.Socket.SendText ('$S' + runaddr + '/' + runport + '%');
      WaitAndPass (500); //0.5ÃÊµ¿¾È ±â´Ù¸²
      ConnectionStep := cnsSelChr;
      LoginScene.OpenLoginDoor;
      SelChrWaitTimer.Enabled := TRUE;
   end;
end;

procedure TFrmMain.ClientGetSelectServer;
var
   sname: string;
begin
   LoginScene.HideLoginBox;

   FrmDlg.ShowSelectServerDlg;
end;

procedure TFrmMain.ClientGetNeedUpdateAccount (body: string);
var
   ue: TUserEntryInfo;
begin
   DecodeBuffer (body, @ue, sizeof(TUserEntryInfo));
   LoginScene.UpdateAccountInfos (ue);
end;

procedure TFrmMain.ClientGetReceiveChrs (body: string);
var
   i, select: integer;
   str, uname, sjob, shair, slevel, ssex: string;
begin
   SelectChrScene.ClearChrs;
   str := DecodeString (body);
   for i:=0 to 1 do begin
      str := GetValidStr3 (str, uname, ['/']);
      str := GetValidStr3 (str, sjob, ['/']);
      str := GetValidStr3 (str, shair, ['/']);
      str := GetValidStr3 (str, slevel, ['/']);
      str := GetValidStr3 (str, ssex, ['/']);
      select := 0;
      if (uname <> '') and (slevel <> '') and (ssex <> '') then begin
         if uname[1] = '*' then begin
            select := i;
            uname := Copy (uname, 2, Length(uname)-1);
         end;
         SelectChrScene.AddChr (uname, Str_ToInt(sjob, 0), Str_ToInt(shair, 0), Str_ToInt(slevel, 0), Str_ToInt(ssex, 0));
      end;
      with SelectChrScene do begin
         if select = 0 then begin
            ChrArr[0].FreezeState := FALSE;
            ChrArr[0].Selected := TRUE;
            ChrArr[1].FreezeState := TRUE;
            ChrArr[1].Selected := FALSE;
         end else begin
            ChrArr[0].FreezeState := TRUE;
            ChrArr[0].Selected := FALSE;
            ChrArr[1].FreezeState := FALSE;
            ChrArr[1].Selected := TRUE;
         end;
      end;
   end;
end;

procedure TFrmMain.ClientGetStartPlay (body: string);
var
   str, addr, sport: string;
begin
   str := DecodeString (body);
   sport := GetValidStr3 (str, addr, ['/']);

   if not BoOneClick then begin
      CSocket.Active := FALSE;  //·Î±×ÀÎ¿¡ ¿¬°áµÈ ¼ÒÄÏ ´ÝÀ½
      WaitAndPass (500); //0.5ÃÊµ¿¾È ±â´Ù¸²

      ConnectionStep := cnsPlay;
      with CSocket do begin
         Address := addr;
         Port := Str_ToInt (sport, 0);
         Active := TRUE;
      end;
   end else begin
      SocStr := '';
      BufferStr := '';
      if CSocket.Socket.Connected then
         CSocket.Socket.SendText ('$R' + addr + '/' + sport + '%');

      ConnectionStep := cnsPlay;
      ClearBag;  //°¡¹æ ÃÊ±âÈ­
      DScreen.ClearChatBoard; //Ã¤ÆÃÃ¢ ÃÊ±âÈ­
      DScreen.ChangeScene (stLoginNotice);

      WaitAndPass (500); //0.5ÃÊµ¿¾È ±â´Ù¸²
      SendRunLogin;
   end;
end;

procedure TFrmMain.ClientGetReconnect (body: string);
var
   str, addr, sport: string;
begin
   str := DecodeString (body);
   sport := GetValidStr3 (str, addr, ['/']);

   if not BoOneClick then begin
      if BoBagLoaded then
         Savebags ('.\Data\' + ServerName + '.' + CharName + '.itm', @ItemArr);
      BoBagLoaded := FALSE;

      BoServerChanging := TRUE;
      CSocket.Active := FALSE;  //·Î±×ÀÎ¿¡ ¿¬°áµÈ ¼ÒÄÏ ´ÝÀ½

      WaitAndPass (500); //0.5ÃÊµ¿¾È ±â´Ù¸²

      ConnectionStep := cnsPlay;
      with CSocket do begin
         Address := addr;
         Port := Str_ToInt (sport, 0);
         Active := TRUE;
      end;

   end else begin
      if BoBagLoaded then
         Savebags ('.\Data\' + ServerName + '.' + CharName + '.itm', @ItemArr);
      BoBagLoaded := FALSE;

      SocStr := '';
      BufferStr := '';
      BoServerChanging := TRUE;

      if CSocket.Socket.Connected then   //Á¢¼Ó Á¾·á ½ÅÈ£ º¸³½´Ù.
         CSocket.Socket.SendText ('$C' + addr + '/' + sport + '%');

      WaitAndPass (500); //0.5ÃÊµ¿¾È ±â´Ù¸²
      if CSocket.Socket.Connected then   //ÀçÁ¢..
         CSocket.Socket.SendText ('$R' + addr + '/' + sport + '%');

      ConnectionStep := cnsPlay;
      ClearBag;  //°¡¹æ ÃÊ±âÈ­
      DScreen.ClearChatBoard; //Ã¤ÆÃÃ¢ ÃÊ±âÈ­
      DScreen.ChangeScene (stLoginNotice);

      WaitAndPass (300); //0.5ÃÊµ¿¾È ±â´Ù¸²
      ChangeServerClearGameVariables;

      SendRunLogin;
   end;
end;

procedure TFrmMain.ClientGetMapDescription (body: string);
var
   data: string;
begin
   body := DecodeString (body);
   body := GetValidStr3 (body, data, [#13]);
   MapTitle := data; //¸Ê ÀÌ¸§....
end;

procedure TFrmMain.ClientGetAdjustBonus (bonus: integer; body: string);
var
   str1, str2, str3: string;
begin
   BonusPoint := bonus;
   body := GetValidStr3 (body, str1, ['/']);
   str3 := GetValidStr3 (body, str2, ['/']);
   DecodeBuffer (str1, @BonusTick, sizeof(TNakedAbility));
   DecodeBuffer (str2, @BonusAbil, sizeof(TNakedAbility));
   DecodeBuffer (str3, @NakedAbil, sizeof(TNakedAbility));
   FillChar (BonusAbilChg, sizeof(TNakedAbility), #0);
end;

procedure TFrmMain.ClientGetAddItem (body: string);
var
   cu: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @cu, sizeof(TClientItem));
      AddItemBag (cu);
      DScreen.AddSysMsg (cu.S.Name + 'Ìí¼Óµ½°ü¹ü.');
   end;
end;

procedure TFrmMain.ClientGetUpdateItem (body: string);
var
   i: integer;
   cu: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @cu, sizeof(TClientItem));
      UpdateItemBag (cu);
      for i:=0 to 8 do begin
         if (UseItems[i].S.Name = cu.S.Name) and (UseItems[i].MakeIndex = cu.MakeIndex) then begin
            UseItems[i] := cu;
         end;
      end;
   end;
end;

procedure TFrmMain.ClientGetDelItem (body: string);
var
   i: integer;
   cu: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @cu, sizeof(TClientItem));
      DelItemBag (cu.S.Name, cu.MakeIndex);
      for i:=0 to 8 do begin
         if (UseItems[i].S.Name = cu.S.Name) and (UseItems[i].MakeIndex = cu.MakeIndex) then begin
            UseItems[i].S.Name := '';
         end;
      end;
   end;
end;

procedure TFrmMain.ClientGetDelItems (body: string);
var
   i, iindex: integer;
   str, iname: string;
   cu: TClientItem;
begin
   body := DecodeString (body);
   while body <> '' do begin
      body := GetValidStr3 (body, iname, ['/']);
      body := GetValidStr3 (body, str, ['/']);
      if (iname <> '') and (str <> '') then begin
         iindex := Str_ToInt(str, 0);
         DelItemBag (iname, iindex);
         for i:=0 to 8 do begin
            if (UseItems[i].S.Name = iname) and (UseItems[i].MakeIndex = iindex) then begin
               UseItems[i].S.Name := '';
            end;
         end;
      end else
         break;
   end;
end;

procedure TFrmMain.ClientGetBagItmes (body: string);
var
   str: string;
   cu: TClientItem;
   ItemSaveArr: array[0..MAXBAGITEMCL-1] of TClientItem;

   function CompareItemArr: Boolean;
   var
      i, j: integer;
      flag: Boolean;
   begin
      flag := TRUE;
      for i:=0 to MAXBAGITEMCL-1 do begin
         if ItemSaveArr[i].S.Name <> '' then begin
            flag := FALSE;
            for j:=0 to MAXBAGITEMCL-1 do begin
               if (ItemArr[j].S.Name = ItemSaveArr[i].S.Name) and
                  (ItemArr[j].MakeIndex = ItemSaveArr[i].MakeIndex) then begin
                  if (ItemArr[j].Dura = ItemSaveArr[i].Dura) and
                     (ItemArr[j].DuraMax = ItemSaveArr[i].DuraMax) then begin
                     flag := TRUE;
                  end;
                  break;
               end;
            end;
            if not flag then break;
         end;
      end;
      if flag then begin
         for i:=0 to MAXBAGITEMCL-1 do begin
            if ItemArr[i].S.Name <> '' then begin
               flag := FALSE;
               for j:=0 to MAXBAGITEMCL-1 do begin
                  if (ItemArr[i].S.Name = ItemSaveArr[j].S.Name) and
                     (ItemArr[i].MakeIndex = ItemSaveArr[j].MakeIndex) then begin
                     if (ItemArr[i].Dura = ItemSaveArr[j].Dura) and
                        (ItemArr[i].DuraMax = ItemSaveArr[j].DuraMax) then begin
                        flag := TRUE;
                     end;
                     break;
                  end;
               end;
               if not flag then break;
            end;
         end;
      end;
      Result := flag;
   end;
begin
   //ClearBag;
   FillChar (ItemArr, sizeof(TClientItem)*MAXBAGITEMCL, #0);
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @cu, sizeof(TClientItem));
      AddItemBag (cu);
   end;
   FillChar (ItemSaveArr, sizeof(TClientItem)*MAXBAGITEMCL, #0);
   Loadbags ('.\Data\' + ServerName + '.' + CharName + '.itm', @ItemSaveArr);
   if CompareItemArr then begin
      Move (ItemSaveArr, ItemArr, sizeof(TClientItem) * MAXBAGITEMCL);
   end;
   ArrangeItembag;
   BoBagLoaded := TRUE;
end;

procedure TFrmMain.ClientGetDropItemFail (iname: string; sindex: integer);
var
   pc: PTClientItem;
begin
   pc := GetDropItem (iname, sindex);
   if pc <> nil then begin
      AddItemBag (pc^);
      DelDropItem (iname, sindex);
   end;
end;

procedure TFrmMain.ClientGetShowItem (itemid, x, y, looks: integer; itmname: string);
var
   i: integer;
   pd: PTDropItem;
begin
   for i:=0 to DropedItemList.Count-1 do begin
      if PTDropItem(DropedItemList[i]).Id = itemid then
         exit;
   end;
   new (pd);
   pd.Id := itemid;
   pd.X := x;
   pd.Y := y;
   pd.Looks := looks;
   pd.Name := itmname;
   pd.FlashTime := GetTickCount - Random(3000);
   pd.BoFlash := FALSE;
   DropedItemList.Add (pd);
end;

procedure TFrmMain.ClientGetHideItem (itemid, x, y: integer);
var
   i: integer;
   pd: PTDropItem;
begin
   for i:=0 to DropedItemList.Count-1 do begin
      if PTDropItem(DropedItemList[i]).Id = itemid then begin
         Dispose (PTDropItem(DropedItemList[i]));
         DropedItemlist.Delete (i);
         break;
      end;
   end;
end;

procedure TFrmMain.ClientGetSenduseItems (body: string);
var
   index: integer;
   str, data: string;
   cu: TClientItem;
begin
   FillChar (UseItems, sizeof(TClientItem)*9, #0);
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      body := GetValidStr3 (body, data, ['/']);
      index := Str_ToInt (str, -1);
      if index in [0..8] then begin
         DecodeBuffer (data, @cu, sizeof(TClientItem));
         UseItems[index] := cu;
      end;
   end;
end;

procedure TFrmMain.ClientGetAddMagic (body: string);
var
   pcm: PTClientMagic;
begin
   new (pcm);
   DecodeBuffer (body, @(pcm^), sizeof(TClientMagic));
   MagicList.Add (pcm);
end;

procedure TFrmMain.ClientGetDelMagic (magid: integer);
var
   i: integer;
begin
   for i:=MagicList.Count-1 downto 0 do begin
      if PTClientMagic(MagicList[i]).Def.MagicId = magid then begin
         Dispose (PTClientMagic(MagicList[i]));
         MagicList.Delete (i);
         break;
      end;
   end;
end;

procedure TFrmMain.ClientGetMyMagics (body: string);
var
   i: integer;
   data: string;
   pcm: PTClientMagic;
begin
   for i:=0 to MagicList.Count-1 do
      Dispose (PTClientMagic (MagicList[i]));
   MagicList.Clear;
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, data, ['/']);
      if data <> '' then begin
         new (pcm);
         DecodeBuffer (data, @(pcm^), sizeof(TClientMagic));
         MagicList.Add (pcm);
      end else
         break;
   end;
end;

procedure TFrmMain.ClientGetMagicLvExp (magid, maglv, magtrain: integer);
var
   i: integer;
begin
   for i:=MagicList.Count-1 downto 0 do begin
      if PTClientMagic(MagicList[i]).Def.MagicId = magid then begin
         PTClientMagic(MagicList[i]).Level := maglv;
         PTClientMagic(MagicList[i]).CurTrain := magtrain;
         break;
      end;
   end;
end;

procedure TFrmMain.ClientGetDuraChange (uidx, newdura, newduramax: integer);
begin
   if uidx in [0..8] then begin
      if UseItems[uidx].S.Name <> '' then begin
         UseItems[uidx].Dura := newdura;
         UseItems[uidx].DuraMax := newduramax;
      end;
   end;
end;

procedure TFrmMain.ClientGetMerchantSay (merchant, face: integer; saying: string);
var
   npcname: string;
begin
   MDlgX := Myself.XX;
   MDlgY := Myself.YY;
   if CurMerchant <> merchant then begin
      CurMerchant := merchant;
      FrmDlg.ResetMenuDlg;
      FrmDlg.CloseMDlg;
   end;

   saying := GetValidStr3 (saying, npcname, ['/']);
   FrmDlg.ShowMDlg (face, npcname, saying);
end;

procedure TFrmMain.ClientGetSendGoodsList (merchant, count: integer; body: string);
var
   i: integer;
   data, gname, gsub, gprice, gstock: string;
   pcg: PTClientGoods;
begin
   FrmDlg.ResetMenuDlg;
   
   CurMerchant := merchant;
   with FrmDlg do begin
      //deocde body received from server
      body := DecodeString (body);
      while body <> '' do begin
         body := GetValidStr3 (body, gname, ['/']);
         body := GetValidStr3 (body, gsub, ['/']);
         body := GetValidStr3 (body, gprice, ['/']);
         body := GetValidStr3 (body, gstock, ['/']);
         if (gname <> '') and (gprice <> '') and (gstock <> '') then begin
            new (pcg);
            pcg.Name := gname;
            pcg.SubMenu := Str_ToInt (gsub, 0);
            pcg.Price := Str_ToInt (gprice, 0);
            pcg.Stock := Str_ToInt (gstock, 0);
            pcg.Grade := -1;
            MenuList.Add (pcg);
         end else
            break;
      end;
      FrmDlg.ShowShopMenuDlg;
      FrmDlg.CurDetailItem := '';
   end;
end;

procedure TFrmMain.ClientGetSendMakeDrugList (merchant: integer; body: string);
var
   i: integer;
   data, gname, gsub, gprice, gstock: string;
   pcg: PTClientGoods;
begin
   FrmDlg.ResetMenuDlg;

   CurMerchant := merchant;
   with FrmDlg do begin
      //clear shop menu list
      //deocde body received from server
      body := DecodeString (body);
      while body <> '' do begin
         body := GetValidStr3 (body, gname, ['/']);
         body := GetValidStr3 (body, gsub, ['/']);
         body := GetValidStr3 (body, gprice, ['/']);
         body := GetValidStr3 (body, gstock, ['/']);
         if (gname <> '') and (gprice <> '') and (gstock <> '') then begin
            new (pcg);
            pcg.Name := gname;
            pcg.SubMenu := Str_ToInt (gsub, 0);
            pcg.Price := Str_ToInt (gprice, 0);
            pcg.Stock := Str_ToInt (gstock, 0);
            pcg.Grade := -1;
            MenuList.Add (pcg);
         end else
            break;
      end;
      FrmDlg.ShowShopMenuDlg;
      FrmDlg.CurDetailItem := '';
      FrmDlg.BoMakeDrugMenu := TRUE;
   end;
end;


procedure TFrmMain.ClientGetSendUserSell (merchant: integer);
begin
   FrmDlg.CloseDSellDlg;
   CurMerchant := merchant;
   FrmDlg.SpotDlgMode := dmSell;
   FrmDlg.ShowShopSellDlg;
end;

procedure TFrmMain.ClientGetSendUserRepair (merchant: integer);
begin
   FrmDlg.CloseDSellDlg;
   CurMerchant := merchant;
   FrmDlg.SpotDlgMode := dmRepair;
   FrmDlg.ShowShopSellDlg;
end;

procedure TFrmMain.ClientGetSendUserStorage (merchant: integer);
begin
   FrmDlg.CloseDSellDlg;
   CurMerchant := merchant;
   FrmDlg.SpotDlgMode := dmStorage;
   FrmDlg.ShowShopSellDlg;
end;

procedure TFrmMain.ClientGetSaveItemList (merchant: integer; bodystr: string);
var
   i: integer;
   data: string;
   pc: PTClientItem;
   pcg: PTClientGoods;
begin
   FrmDlg.ResetMenuDlg;

   for i:=0 to SaveItemList.Count-1 do
      Dispose(PTClientItem(SaveItemList[i]));
   SaveItemList.Clear;

   while TRUE do begin
      if bodystr = '' then break;
      bodystr := GetValidStr3 (bodystr, data, ['/']);
      if data <> '' then begin
         new (pc);
         DecodeBuffer (data, @(pc^), sizeof(TClientItem));
         SaveItemList.Add (pc);
      end else
         break;
   end;

   CurMerchant := merchant;
   with FrmDlg do begin
      //deocde body received from server
      for i:=0 to SaveItemList.Count-1 do begin
         new (pcg);
         pcg.Name := PTClientItem(SaveItemList[i]).S.Name;
         pcg.SubMenu := 0;
         pcg.Price := PTClientItem(SaveItemList[i]).MakeIndex;
         pcg.Stock := Round(PTClientItem(SaveItemList[i]).Dura / 1000);
         pcg.Grade := Round(PTClientItem(SaveItemList[i]).DuraMax / 1000);
         MenuList.Add (pcg);
      end;
      FrmDlg.ShowShopMenuDlg;
      FrmDlg.BoStorageMenu := TRUE;
   end;
end;

procedure TFrmMain.ClientGetSendDetailGoodsList (merchant, count, topline: integer; bodystr: string);
var
   i: integer;
   body, data, gname, gprice, gstock, ggrade: string;
   pcg: PTClientGoods;
   pc: PTClientItem;
begin
   FrmDlg.ResetMenuDlg;

   CurMerchant := merchant;

   bodystr := DecodeString(bodystr);
   while TRUE do begin
      if bodystr = '' then break;
      bodystr := GetValidStr3 (bodystr, data, ['/']);
      if data <> '' then begin
         new (pc);
         DecodeBuffer (data, @(pc^), sizeof(TClientItem));
         MenuItemList.Add (pc);
      end else
         break;
   end;

   with FrmDlg do begin
      //clear shop menu list
      for i:=0 to MenuItemList.Count-1 do begin
         new (pcg);
         pcg.Name := PTClientItem(MenuItemList[i]).S.Name;
         pcg.SubMenu := 0;
         pcg.Price := PTClientItem(MenuItemList[i]).DuraMax;
         pcg.Stock := PTClientItem(MenuItemList[i]).MakeIndex;
         pcg.Grade := Round(PTClientItem(MenuItemList[i]).Dura/1000);
         MenuList.Add (pcg);
      end;
      FrmDlg.ShowShopMenuDlg;
      FrmDlg.BoDetailMenu := TRUE;
      FrmDlg.MenuTopLine := topline;
   end;
end;

procedure TFrmMain.ClientGetSendNotice (body: string);
var
   data, msgstr: string;
begin
   DoFastFadeOut := FALSE;
   msgstr := '';
   body := DecodeString (body);
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, data, [#27]);
      msgstr := msgstr + data + '\';
   end;
   FrmDlg.DialogSize := 2;
   if FrmDlg.DMessageDlg (msgstr, [mbOk]) = mrOk then begin
      SendClientMessage (CM_LOGINNOTICEOK, 0, 0, 0, 0);
   end;
end;

procedure TFrmMain.ClientGetGroupMembers (bodystr: string);
var
   memb: string;
begin
   GroupMembers.Clear;
   while TRUE do begin
      if bodystr = '' then break;
      bodystr := GetValidStr3(bodystr, memb, ['/']);
      if memb <> '' then
         GroupMembers.Add (memb)
      else
         break;
   end;
end;

procedure TFrmMain.ClientGetOpenGuildDlg (bodystr: string);
var
   str, data, linestr, s1: string;
   pstep: integer;
begin
   str := DecodeString (bodystr);
   str := GetValidStr3 (str, FrmDlg.Guild, [#13]);
   str := GetValidStr3 (str, FrmDlg.GuildFlag, [#13]);
   str := GetValidStr3 (str, data, [#13]);
   if data = '1' then FrmDlg.GuildCommanderMode := TRUE
   else FrmDlg.GuildCommanderMode := FALSE;

   FrmDlg.GuildStrs.Clear;
   FrmDlg.GuildNotice.Clear;
   pstep := 0;
   while TRUE do begin
      if str = '' then break;
      str := GetValidStr3 (str, data, [#13]);
      if data = '<Notice>' then begin
         FrmDlg.GuildStrs.AddObject (char(7) + '°øÁö»çÇ×', TObject(clWhite));
         FrmDlg.GuildStrs.Add (' ');
         pstep := 1;
         continue;
      end;
      if data = '<KillGuilds>' then begin
         FrmDlg.GuildStrs.Add (' ');
         FrmDlg.GuildStrs.AddObject (char(7) + 'Àû´ë¹®ÆÄ', TObject(clWhite));
         FrmDlg.GuildStrs.Add (' ');
         pstep := 2;
         linestr := '';
         continue;
      end;
      if data = '<AllyGuilds>' then begin
         if linestr <> '' then FrmDlg.GuildStrs.Add (linestr);
         linestr := '';
         FrmDlg.GuildStrs.Add (' ');
         FrmDlg.GuildStrs.AddObject (char(7) + 'µ¿¸Í¹®ÆÄ', TObject(clWhite));
         FrmDlg.GuildStrs.Add (' ');
         pstep := 3;
         continue;
      end;

      if pstep = 1 then
         FrmDlg.GuildNotice.Add (data);

      if data <> '' then begin
         if data[1] = '<' then begin
            ArrestStringEx (data, '<', '>', s1);
            if s1 <> '' then begin
               FrmDlg.GuildStrs.Add (' ');
               FrmDlg.GuildStrs.AddObject (char(7) + s1, TObject(clWhite));
               FrmDlg.GuildStrs.Add (' ');
               continue;
            end;
         end;
      end;
      if (pstep = 2) or (pstep = 3) then begin
         if Length(linestr) > 80 then begin
            FrmDlg.GuildStrs.Add (linestr);
            linestr := '';
         end else
            linestr := linestr + fmstr (data, 18);
         continue;
      end;

      FrmDlg.GuildStrs.Add (data);
   end;

   if linestr <> '' then FrmDlg.GuildStrs.Add (linestr);

   FrmDlg.ShowGuildDlg;
end;

procedure TFrmMain.ClientGetSendGuildMemberList (body: string);
var
   str, data, rankname, members: string;
   rank: integer;
begin
   str := DecodeString (body);
   FrmDlg.GuildStrs.Clear;
   FrmDlg.GuildMembers.Clear;
   rank := 0;
   while TRUE do begin
      if str = '' then break;
      str := GetValidStr3 (str, data, ['/']);
      if data <> '' then begin
         if data[1] = '#' then begin
            rank := Str_ToInt (Copy(data, 2, Length(data)-1), 0);
            continue;
         end;
         if data[1] = '*' then begin
            if members <> '' then FrmDlg.GuildStrs.Add (members);
            rankname := Copy(data, 2, Length(data)-1);
            members := '';
            FrmDlg.GuildStrs.Add (' ');
            if FrmDlg.GuildCommanderMode then
               FrmDlg.GuildStrs.AddObject (fmStr('(' + IntToStr(rank) + ')', 3) + '<' + rankname + '>', TObject(clWhite))
            else
               FrmDlg.GuildStrs.AddObject ('<' + rankname + '>', TObject(clWhite));
            FrmDlg.GuildMembers.Add ('#' + IntToStr(rank) + ' <' + rankname + '>');
            continue;
         end;
         if Length (members) > 80 then begin
            FrmDlg.GuildStrs.Add (members);
            members := '';
         end;
         members := members + FmStr(data, 18);
         FrmDlg.GuildMembers.Add (data);
      end;
   end;
   if members <> '' then
      FrmDlg.GuildStrs.Add (members);
end;

procedure TFrmMain.MinTimerTimer(Sender: TObject);
var
   i: integer;
   timertime: longword;
begin
   //¼ì²éËùÓÐÍæ¼Ò¿´ÊÇ·ñºÍ±¾Íæ¼ÒÊÇÒ»×é
   with PlayScene do
      for i:=0 to ActorList.Count-1 do begin
         if IsGroupMember (TActor (ActorList[i]).UserName) then begin
            TActor (ActorList[i]).Grouped := TRUE;
         end else
            TActor (ActorList[i]).Grouped := FALSE;
      end;
   //ÔÚËÀÍö1·ÖÖÓºóµÄ½ÇÉ«½«Çå³ý
   for i:=FreeActorList.Count-1 downto 0 do begin
      if GetTickCount - TActor(FreeActorList[i]).DeleteTime > 60000 then begin
         TActor(FreeActorList[i]).Free;
         FreeActorList.Delete (i);
      end;
   end;
end;

procedure TFrmMain.CheckHackTimerTimer(Sender: TObject);
const
   busy: boolean = FALSE;
var
   ahour, amin, asec, amsec: word;
   tcount, timertime: longword;
begin
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
         //½Ã°£ Á¶ÀÛ...
         SendSpeedHackUser;
         FrmDlg.DMessageDlg ('ÇØÅ· ÇÁ·Î±×·¥ »ç¿ëÀÚ·Î ±â·Ï µÇ¾ú½À´Ï´Ù.\' +
                             'ÀÌ·¯ÇÑ Á¾·ùÀÇ ÇÁ·Î±×·¥À» »ç¿ëÇÏ´Â °ÍÀº ºÒ¹ýÀÌ¸ç,\' +
                             '°èÁ¤ ¾Ð·ùµîÀÇ Á¦Àç Á¶Ä¡°¡ °¡ÇØÁú ¼ö ÀÖÀ½À» ¾Ë·Áµå¸³´Ï´Ù.\' +
                             '[¹®ÀÇ] mir2master@wemade.com\' +
                             'ÇÁ·Î±×·¥À» Á¾·áÇÕ´Ï´Ù.', [mbOk]);
         FrmMain.Close;
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
            //½Ã°£ Á¶ÀÛ...
            SendSpeedHackUser;
            FrmDlg.DMessageDlg ('ÇØÅ· ÇÁ·Î±×·¥ »ç¿ëÀÚ·Î ±â·Ï µÇ¾ú½À´Ï´Ù.\' +
                                'ÀÌ·¯ÇÑ Á¾·ùÀÇ ÇÁ·Î±×·¥À» »ç¿ëÇÏ´Â °ÍÀº ºÒ¹ýÀÌ¸ç,\' +
                                '°èÁ¤ ¾Ð·ùµîÀÇ Á¦Àç Á¶Ä¡°¡ °¡ÇØÁú ¼ö ÀÖÀ½À» ¾Ë·Áµå¸³´Ï´Ù.\' +
                                '[¹®ÀÇ] mir2master@wemade.com\' +
                                'ÇÁ·Î±×·¥À» Á¾·áÇÕ´Ï´Ù.', [mbOk]);
            FrmMain.Close;
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
end;

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
            //½Ã°£ Á¶ÀÛ...
            SendSpeedHackUser;
            FrmDlg.DMessageDlg ('ÇØÅ· ÇÁ·Î±×·¥ »ç¿ëÀÚ·Î ±â·Ï µÇ¾ú½À´Ï´Ù.\' +
                                'ÀÌ·¯ÇÑ Á¾·ùÀÇ ÇÁ·Î±×·¥À» »ç¿ëÇÏ´Â °ÍÀº ºÒ¹ýÀÌ¸ç,\' +
                                '°èÁ¤ ¾Ð·ùµîÀÇ Á¦Àç Á¶Ä¡°¡ °¡ÇØÁú ¼ö ÀÖÀ½À» ¾Ë·Áµå¸³´Ï´Ù.\' +
                                '[¹®ÀÇ] mir2master@wemade.com\' +
                                'ÇÁ·Î±×·¥À» Á¾·áÇÕ´Ï´Ù.', [mbOk]);
            FrmMain.Close;
         end;
      end else
         TimeFakeDetectSum := 0;
      LatestClientTimerTime := timertime;
      LatestClientGetTime := tcount;
   end;
   busy := FALSE;
end;
//**)

procedure TFrmMain.ClientGetDealRemoteAddItem (body: string);
var
   ci: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @ci, sizeof(TClientItem));
      AddDealRemoteItem (ci);
   end;
end;

procedure TFrmMain.ClientGetDealRemoteDelItem (body: string);
var
   ci: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @ci, sizeof(TClientItem));
      DelDealRemoteItem (ci);
   end;
end;

procedure TFrmMain.ClientGetReadMiniMap (mapindex: integer);
begin
   if mapindex >= 1 then begin
      BoViewMiniMap := TRUE;
      MiniMapIndex := mapindex - 1;
   end;
end;

procedure TFrmMain.ClientGetChangeGuildName (body: string);
var
   str: string;
begin
   str := GetValidStr3 (body, GuildName, ['/']);
   GuildRankName := Trim (str);
end;

procedure TFrmMain.ClientGetSendUserState (body: string);
var
   ustate: TUserStateInfo;
begin
   DecodeBuffer (body, @ustate, sizeof(TUserStateInfo));
   ustate.NameColor := GetRGB(ustate.NameColor);
   FrmDlg.OpenUserState (ustate);
end;

procedure TFrmMain.SendTimeTimerTimer(Sender: TObject);
var
   tcount: longword;
begin
//   tcount := GetTickCount;
//   SendClientMessage (CM_CLIENT_CHECKTIME, tcount, Loword(LatestClientGetTime), Hiword(LatestClientGetTime), 0);
//   LastestClientGetTime := tcount;
end;



end.
