unit FState;
//±¾µ¥ÔªÌá¹©ÏµÍ³ÖÐµÄËùÓÐ¶Ô»°¿òÏÔÊ¾
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DWinCtl, StdCtrls, DXDraws, Grids, Grobal2, clFunc, hUtil32, cliUtil,
  MapUnit, SoundUtil;

const
   BOTTOMBOARD = 1;
   VIEWCHATLINE = 9;
   MAXSTATEPAGE = 4;
   LISTLINEHEIGHT = 13;
   MAXMENU = 10;

   AdjustAbilHints : array[0..8] of string = (
      'ÆÄ±«·Â',
      '¸¶¹ýÀÇ Èû(ÁÖ¼ú»ç ÇØ´ç)',
      'µµ¼úÀÇ Èû(µµ»ç ÇØ´ç)',
      '¹æ¾î·Â',
      '¸¶¹ý ¹æ¾î·Â',
      'Ã¼·Â',
      '¸¶·Â',
      'Á¤È®¼º',
      'È¸ÇÇ·Â'
   );

type
  TSpotDlgMode = (dmSell, dmRepair, dmStorage);

  TClickPoint = record
     rc: TRect;
     RStr: string;
  end;
  PTClickPoint = ^TClickPoint;

  TFrmDlg = class(TForm)
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
    DRepairItem: TDButton;
    DCloseBag: TDButton;
    DCloseState: TDButton;
    DLogIn: TDWindow;
    DLoginNew: TDButton;
    DLoginOk: TDButton;
    DNewAccount: TDWindow;
    DNewAccountOk: TDButton;
    DLoginClose: TDButton;
    DNewAccountClose: TDButton;
    DSelectChr: TDWindow;
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
    DBelt1: TDButton;
    DBelt2: TDButton;
    DBelt3: TDButton;
    DBelt4: TDButton;
    DBelt5: TDButton;
    DBelt6: TDButton;
    DChgPw: TDWindow;
    DChgpwOk: TDButton;
    DChgpwCancel: TDButton;
    DMerchantDlg: TDWindow;
    DMerchantDlgClose: TDButton;
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
    procedure DBottomInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DBottomDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMyStateDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DOptionClick(Sender: TObject);
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
    procedure DLoginNewClickSound(Sender: TObject;
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
    procedure DGrpAllowGroupClick(Sender: TObject; X, Y: Integer);
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
  private
    DlgTemp: TList;
    magcur, magtop: integer;
    EdDlgEdit: TEdit;
    Memo: TMemo;

    ViewDlgEdit: Boolean;
    msglx, msgly: integer;
    MenuTop: integer;

    MagKeyIcon, MagKeyCurKey: integer;
    MagKeyMagName: string;
    MagicPage: integer;

    BlinkTime: longword;
    BlinkCount: integer;  //0..9»çÀÌ¸¦ ¹Ýº¹

    procedure HideAllControls;
    procedure RestoreHideControls;
    procedure PageChanged;
    procedure DealItemReturnBag (mitem: TClientItem);
    procedure DealZeroGold;
  public
    StatePage: integer;
    MsgText: string;
    DialogSize: integer;

    MerchantName: string;
    MerchantFace: integer;
    MDlgStr: string;
    MDlgPoints: TList;
    RequireAddPoints: Boolean;
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
    UserState1: TUserStateInfo;

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

    procedure Initialize;
    procedure OpenMyStatus;
    procedure OpenUserState (ustate: TUserStateInfo);
    procedure OpenItemBag;
    procedure ViewBottomBox (visible: Boolean);
    procedure CancelItemMoving;
    procedure DropMovingItem;
    procedure OpenAdjustAbility;

    procedure ShowSelectServerDlg;
    function  DMessageDlg (msgstr: string; DlgButtons: TMsgDlgButtons): TModalResult;
    procedure ShowMDlg (face: integer; mname, msgstr: string);
    procedure ShowGuildDlg;
    procedure ShowGuildEditNotice;
    procedure ShowGuildEditGrade;

    procedure ResetMenuDlg;
    procedure ShowShopMenuDlg;
    procedure ShowShopSellDlg;
    procedure CloseDSellDlg;
    procedure CloseMDlg;

    procedure ToggleShowGroupDlg;
    procedure OpenDealDlg;
    procedure CloseDealDlg;

    procedure SoldOutGoods (itemserverindex: integer);
    procedure DelStorageItem (itemserverindex: integer);
    procedure GetMouseItemInfo (var iname, line1, line2, line3: string; var useable: boolean);
    procedure SetMagicKeyDlg (icon: integer; magname: string; var curkey: word);
    procedure AddGuildChat (str: string);
  end;

var
  FrmDlg: TFrmDlg;

implementation

uses
   ClMain;

{$R *.DFM}

{
   ##  MovingItem.Index
      1~n : °¡¹æÃ¢ÀÇ ¾ÆÀÌÅÛ ¼ø¼­
      -1~-8 : ÀåÂøÃ¢¿¡¼­ÀÇ ¾ÆÀÌÅÛ ¼ø¼­
      -97 : ±³È¯Ã¢ÀÇ µ·
      -98 : µ·
      -99 : ÆÈ±â Ã¢¿¡¼­ÀÇ ¾ÆÀÌÅÛ ¼ø¼­
      -20~29: ±³È¯Ã¢¿¡¼­ÀÇ ¾ÆÀÌÅÛ ¼ø¼­
}

procedure TFrmDlg.FormCreate(Sender: TObject);
begin
   StatePage := 0;
   DlgTemp := TList.Create;
   DialogSize := 1; //±âº» Å©±â
   magcur := 0;
   magtop := 0;
   MDlgPoints := TList.Create;
   SelectMenuStr := '';
   MenuList := TList.Create;
   MenuIndex := -1;
   MenuTopLine := 0;
   BoDetailMenu := FALSE;
   BoStorageMenu := FALSE;
   BoNoDisplayMaxDura := FALSE;
   BoMakeDrugMenu := FALSE;
   MagicPage := 0;
   NAHelps := TStringList.Create;
   BlinkTime := GetTickCount;
   BlinkCount := 0;

   SellDlgItem.S.Name := '';
   Guild := '';
   GuildFlag := '';
   GuildCommanderMode := FALSE;
   GuildStrs := TStringList.Create;
   GuildStrs2 := TStringList.Create; //¹é¾÷¿ë
   GuildNotice := TStringList.Create;
   GuildMembers := TStringList.Create;
   GuildChats := TStringList.Create;

   EdDlgEdit := TEdit.Create (FrmMain.Owner);
   with EdDlgEdit do begin
      Parent := FrmMain;  Color := clBlack; Font.Color := clWhite; Font.Size := 10; MaxLength := 30;
      Height := 16; Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}  Visible := FALSE;
   end;

   Memo := TMemo.Create (FrmMain.Owner);
   with Memo do begin
      Parent := FrmMain;  Color := clBlack; Font.Color := clWhite; Font.Size := 10;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}  Visible := FALSE;
   end;
end;

procedure TFrmDlg.FormDestroy(Sender: TObject);
begin
   DlgTemp.Free;
   MDlgPoints.Free;  //°£´ÜÈ÷..
   MenuList.Free;
   NAHelps.Free;
   GuildStrs.Free;
   GuildStrs2.Free;
   GuildNotice.Free;
   GuildMembers.Free;
   GuildChats.Free; 
end;

procedure TFrmDlg.HideAllControls;
var
   i: integer;
   c: TControl;
begin
   DlgTemp.Clear;
   with FrmMain do
      for i:=0 to ControlCount-1 do begin
         c := Controls[i];
         if c is TEdit then
            if (c.Visible) and (c <> EdDlgEdit) then begin
               DlgTemp.Add (c);
               c.Visible := FALSE;
            end;
      end;
end;

procedure TFrmDlg.RestoreHideControls;
var
   i: integer;
   c: TControl;
begin
   for i:=0 to DlgTemp.Count-1 do begin
      TControl(DlgTemp[i]).Visible := TRUE;
   end;
end;

procedure TFrmDlg.Initialize;  //³õÊ¼»¯ËùÓÐ¶Ô»°¿ò
var
   i: integer;
   d: TDirectDrawSurface;
begin
   FrmMain.DWinMan.ClearAll;

   DBackground.Left := 0;
   DBackground.Top := 0;
   DBackground.Width := SCREENWIDTH;
   DBackground.Height := SCREENHEIGHT;
   DBackground.Background := TRUE;
   FrmMain.DWinMan.AddDControl (DBackground, TRUE);

   {-----------------------------------------------------------}

   //Í¨ÓÃ¶Ô»°¿ò
   d := FrmMain.WProgUse.Images[360];
   if d <> nil then begin
      DMsgDlg.SetImgIndex (FrmMain.WProgUse, 360);
      DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
      DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
   end;
   DMsgDlgOk.SetImgIndex (FrmMain.WProgUse, 361);
   DMsgDlgYes.SetImgIndex (FrmMain.WProgUse, 363);
   DMsgDlgCancel.SetImgIndex (FrmMain.WProgUse, 365);
   DMsgDlgNo.SetImgIndex (FrmMain.WProgUse, 367);
   DMsgDlgOk.Top := 126;
   DMsgDlgYes.Top := 126;
   DMsgDlgCancel.Top := 126;
   DMsgDlgNo.Top := 126;

   {-----------------------------------------------------------}

   //µÇÂ¼¶Ô»°¿ò
   d := FrmMain.WProgUse.Images[60];
   if d <> nil then begin
      DLogIn.SetImgIndex (FrmMain.WProgUse, 60);
      DLogIn.Left := (SCREENWIDTH - d.Width) div 2;
      DLogIn.Top := (SCREENHEIGHT - d.Height) div 2;
   end;
   DLoginNew.SetImgIndex (FrmMain.WProgUse, 61);
   DLoginNew.Left := 24;
   DLoginNew.Top  := 207;
   DLoginOk.SetImgIndex (FrmMain.WProgUse, 62);
   DLoginOk.Left := 171;
   DLoginOk.Top := 165;
   DLoginChgPw.SetImgIndex (FrmMain.WProgUse, 53);
   DLoginChgPw.Left := 111;
   DLoginChgPw.Top  := 207;
   DLoginClose.SetImgIndex (FrmMain.WProgUse, 64);
   DLoginClose.Left := 252;
   DLoginClose.Top := 28;

   {-----------------------------------------------------------}
   if not EnglishVersion then begin
      //º«ÎÄ¶Ô»°¿ò
      //Ñ¡Ôñ·þÎñÆ÷
      d := FrmMain.WProgUse.Images[160]; //81];
      if d <> nil then begin
         DSelServerDlg.SetImgIndex (FrmMain.WProgUse, 160);
         DSelServerDlg.Left := (SCREENWIDTH - d.Width) div 2;
         DSelServerDlg.Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      DSSrvClose.SetImgIndex (FrmMain.WProgUse, 64);
      DSSrvClose.Left := 448;
      DSSrvClose.Top := 33;

      DSServer1.SetImgIndex (FrmMain.WProgUse, 161); //82);
      DSServer1.Left := 134;
      DSServer1.Top  := 102;
      DSServer2.SetImgIndex (FrmMain.WProgUse, 162); //83);
      DSServer2.Left := 236;
      DSServer2.Top  := 101;
      DSServer3.SetImgIndex (FrmMain.WProgUse, 163);
      DSServer3.Left := 87;
      DSServer3.Top  := 190;
      DSServer4.SetImgIndex (FrmMain.WProgUse, 164);
      DSServer4.Left := 280;
      DSServer4.Top  := 190;
      DSServer5.SetImgIndex (FrmMain.WProgUse, 165);
      DSServer5.Left := 134;
      DSServer5.Top  := 280;
      DSServer6.SetImgIndex (FrmMain.WProgUse, 166);
      DSServer6.Left := 236;
      DSServer6.Top  := 280;

      DEngServer1.Visible := FALSE;
   end else begin
      //ÖÐÎÄ¶Ô»°¿ò£ºÑ¡Ôñ·þÎñÆ÷
      d := FrmMain.WProgUse.Images[256]; //81];
      if d <> nil then begin
         DSelServerDlg.SetImgIndex (FrmMain.WProgUse, 256);
         DSelServerDlg.Left := (SCREENWIDTH - d.Width) div 2;
         DSelServerDlg.Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      DSSrvClose.SetImgIndex (FrmMain.WProgUse, 64);
      DSSrvClose.Left := 245;
      DSSrvClose.Top := 31;

      DEngServer1.SetImgIndex (FrmMain.WProgUse, 257);
      DEngServer1.Left := 65;
      DEngServer1.Top  := 204;

      DSServer1.Visible := FALSE;
      DSServer2.Visible := FALSE;
      DSServer3.Visible := FALSE;
      DSServer4.Visible := FALSE;
      DSServer5.Visible := FALSE;
      DSServer6.Visible := FALSE;

   end;

   {-----------------------------------------------------------}

   //ÐÂÓÃ»§¶Ô»°¿ò
   d := FrmMain.WProgUse.Images[63];
   if d <> nil then begin
      DNewAccount.SetImgIndex (FrmMain.WProgUse, 63);
      DNewAccount.Left := (SCREENWIDTH - d.Width) div 2;
      DNewAccount.Top := (SCREENHEIGHT - d.Height) div 2;
   end;
   DNewAccountOk.SetImgIndex (FrmMain.WProgUse, 62);
   DNewAccountOk.Left := 160;
   DNewAccountOk.Top := 417;
   DNewAccountCancel.SetImgIndex (FrmMain.WProgUse, 52);
   DNewAccountCancel.Left := 448;
   DNewAccountCancel.Top := 419;
   DNewAccountClose.SetImgIndex (FrmMain.WProgUse, 64);
   DNewAccountClose.Left := 587;
   DNewAccountClose.Top := 33;

   {-----------------------------------------------------------}

   //ÐÞ¸ÄÃÜÂë¶Ô»°¿ò
   d := FrmMain.WProgUse.Images[50];
   if d <> nil then begin
      DChgPw.SetImgIndex (FrmMain.WProgUse, 50);
      DChgPw.Left := (SCREENWIDTH - d.Width) div 2;
      DChgPw.Top  := (SCREENHEIGHT - d.Height) div 2;
   end;
   DChgpwOk.SetImgIndex (FrmMain.WProgUse, 62);
   DChgPwOk.Left := 182;
   DChgPwOk.Top := 252;
   DChgpwCancel.SetImgIndex (FrmMain.WProgUse, 52);
   DChgPwCancel.Left := 277;
   DChgPwCancel.Top := 251;

   {-----------------------------------------------------------}

   //Ñ¡Ôñ½ÇÉ«¶Ô»°¿ò
   DSelectChr.Left := 0;
   DSelectChr.Top := 0;
   DSelectChr.Width := SCREENWIDTH;
   DSelectChr.Height := SCREENHEIGHT;
   DscSelect1.SetImgIndex (FrmMain.WProgUse, 66);
   DscSelect2.SetImgIndex (FrmMain.WProgUse, 67);
   DscStart.SetImgIndex (FrmMain.WProgUse, 68);
   DscNewChr.SetImgIndex (FrmMain.WProgUse, 69);
   DscEraseChr.SetImgIndex (FrmMain.WProgUse, 70);
   DscCredits.SetImgIndex (FrmMain.WProgUse, 71);
   DscExit.SetImgIndex (FrmMain.WProgUse, 72);
      DscSelect1.Left := 134;
      DscSelect1.Top := 454;
      DscSelect2.Left := 685;
      DscSelect2.Top := 454;
      DscStart.Left := 367;
      DscStart.Top := 457;
      DscNewChr.Left := 321;
      DscNewChr.Top := 488;
      DscEraseChr.Left := 311;
      DscEraseChr.Top := 509;
      DscCredits.Left := 362;
      DscCredits.Top := 529;
      DscExit.Left := 379;
      DscExit.Top := 559;

   {-----------------------------------------------------------}

   //´´½¨½ÇÉ«¶Ô»°¿ò
   d := FrmMain.WProgUse.Images[73];
   if d <> nil then begin
      DCreateChr.SetImgIndex (FrmMain.WProgUse, 73);
      DCreateChr.Left := (SCREENWIDTH - d.Width) div 2;
      DCreateChr.Top := (SCREENHEIGHT - d.Height) div 2;
   end;
   DccWarrior.SetImgIndex (FrmMain.WProgUse, 74);  //Õ½Ê¿
   DccWizzard.SetImgIndex (FrmMain.WProgUse, 75);  //·¨Ê¦
   DccMonk.SetImgIndex (FrmMain.WProgUse, 76);     //µÀÊ¿
   DccMale.SetImgIndex (FrmMain.WProgUse, 77);     //ÄÐ
   DccFemale.SetImgIndex (FrmMain.WProgUse, 78);   //Å®
   DccLeftHair.SetImgIndex (FrmMain.WProgUse, 79);
   DccRightHair.SetImgIndex (FrmMain.WProgUse, 80);
   DccOk.SetImgIndex (FrmMain.WProgUse, 62);
   DccClose.SetImgIndex (FrmMain.WProgUse, 64);
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


   {-----------------------------------------------------------}

   //ÈËÎï×´Ì¬´°¿Ú
   d := FrmMain.WProgUse.Images[370];
   if d <> nil then begin
      DStateWin.SetImgIndex (FrmMain.WProgUse, 370);
      DStateWin.Left := SCREENWIDTH - d.Width;
      DStateWin.Top := 0;
   end;
      DSWNecklace.Left := 38 + 130;
      DSWNecklace.Top  := 52 + 35;
      DSWNecklace.Width := 34;
      DSWNecklace.Height := 31;
      DSWHelmet.Left := 38 + 77;
      DSWHelmet.Top  := 52 + 41;
      DSWHelmet.Width := 18;
      DSWHelmet.Height := 18;
      DSWLight.Left := 38 + 130;
      DSWLight.Top  := 52 + 73;
      DSWLight.Width := 34;
      DSWLight.Height := 31;
      DSWArmRingR.Left := 38 + 4;
      DSWArmRingR.Top  := 52 + 124;
      DSWArmRingR.Width := 34;
      DSWArmRingR.Height := 31;
      DSWArmRingL.Left := 38 + 130;
      DSWArmRingL.Top  := 52 + 124;
      DSWArmRingL.Width := 34;
      DSWArmRingL.Height := 31;
      DSWRingR.Left := 38 + 4;
      DSWRingR.Top  := 52 + 163;
      DSWRingR.Width := 34;
      DSWRingR.Height := 31;
      DSWRingL.Left := 38 + 130;
      DSWRingL.Top  := 52 + 163;
      DSWRingL.Width := 34;
      DSWRingL.Height := 31;
      DSWWeapon.Left := 38 + 9;
      DSWWeapon.Top  := 52 + 28;
      DSWWeapon.Width := 47;
      DSWWeapon.Height := 87;
      DSWDress.Left := 38 + 58;
      DSWDress.Top  := 52 + 70;
      DSWDress.Width := 53;
      DSWDress.Height := 112;

      DStMag1.Left := 38 + 8;
      DStMag1.Top := 52 + 7;    DStMag1.Width := 31;  DStMag1.Height := 33;
      DStMag2.Left := 38 + 8;
      DStMag2.Top := 52 + 44;   DStMag2.Width := 31;  DStMag2.Height := 33;
      DStMag3.Left := 38 + 8;
      DStMag3.Top := 52 + 82;   DStMag3.Width := 31;  DStMag3.Height := 33;
      DStMag4.Left := 38 + 8;
      DStMag4.Top := 52 + 119;  DStMag4.Width := 31;  DStMag4.Height := 33;
      DStMag5.Left := 38 + 8;
      DStMag5.Top := 52 + 156;  DStMag5.Width := 31;  DStMag5.Height := 33;

      DStPageUp.SetImgIndex (FrmMain.WProgUse, 398);
      DStPageDown.SetImgIndex (FrmMain.WProgUse, 396);
      DStPageUp.Left := 213;
      DStPageUp.Top  := 113;
      DStPageDown.Left := 213;
      DStPageDown.Top  := 143;

   DCloseState.SetImgIndex (FrmMain.WProgUse, 371);
   DCloseState.Left := 8;
   DCloseState.Top := 39;
   DPrevState.SetImgIndex (FrmMain.WProgUse, 373);
   DNextState.SetImgIndex (FrmMain.WProgUse, 372);
   DPrevState.Left := 7;
   DPrevState.Top := 128;
   DNextState.Left := 7;
   DNextState.Top := 187;

   {-----------------------------------------------------------}

   //ÈËÎï×´Ì¬
   d := FrmMain.WProgUse.Images[370];  //»óÅÂ
   if d <> nil then begin
      DUserState1.SetImgIndex (FrmMain.WProgUse, 370);
      DUserState1.Left := SCREENWIDTH - d.Width - d.Width;
      DUserState1.Top := 0;
   end;
      DNecklaceUS1.Left := 38 + 130;
      DNecklaceUS1.Top  := 52 + 35;
      DNecklaceUS1.Width := 34;
      DNecklaceUS1.Height := 31;
      DHelmetUS1.Left := 38 + 77;
      DHelmetUS1.Top  := 52 + 41;
      DHelmetUS1.Width := 18;
      DHelmetUS1.Height := 18;
      DLightUS1.Left := 38 + 130;
      DLightUS1.Top  := 52 + 73;
      DLightUS1.Width := 34;
      DLightUS1.Height := 31;
      DArmRingRUS1.Left := 38 + 4;
      DArmRingRUS1.Top  := 52 + 124;
      DArmRingRUS1.Width := 34;
      DArmRingRUS1.Height := 31;
      DArmRingLUS1.Left := 38 + 130;
      DArmRingLUS1.Top  := 52 + 124;
      DArmRingLUS1.Width := 34;
      DArmRingLUS1.Height := 31;
      DRingRUS1.Left := 38 + 4;
      DRingRUS1.Top  := 52 + 163;
      DRingRUS1.Width := 34;
      DRingRUS1.Height := 31;
      DRingLUS1.Left := 38 + 130;
      DRingLUS1.Top  := 52 + 163;
      DRingLUS1.Width := 34;
      DRingLUS1.Height := 31;
      DWeaponUS1.Left := 38 + 9;
      DWeaponUS1.Top  := 52 + 28;
      DWeaponUS1.Width := 47;
      DWeaponUS1.Height := 87;
      DDressUS1.Left := 38 + 58;
      DDressUS1.Top  := 52 + 70;
      DDressUS1.Width := 53;
      DDressUS1.Height := 112;
   DCloseUS1.SetImgIndex (FrmMain.WProgUse, 371);
   DCloseUS1.Left := 8;
   DCloseUS1.Top := 39;

  {-------------------------------------------------------------}

   //ÎïÆ·°ü¹üÀ¸
   DItemBag.SetImgIndex (FrmMain.WProgUse, 3);
   DItemBag.Left := 0;
   DItemBag.Top := 0;
   DItemGrid.Left := 20;
   DItemGrid.Top  := 13;
   DItemGrid.Width := 286;
   DItemGrid.Height := 162;

   {-----------------------------------------------------------}

   //µ×²¿¶Ô»°¿ò
   d := FrmMain.WProgUse.Images[BOTTOMBOARD];
   if d <> nil then begin
      DBottom.Left := 0;
      DBottom.Top  := SCREENHEIGHT - d.Height;
      DBottom.Width := d.Width;
      DBottom.Height := d.Height;
   end;

   {-----------------------------------------------------------}

   //µ×²¿×´Ì¬À¸µÄ4¸ö¿ì½Ý°´Å¥
   DMyState.SetImgIndex (FrmMain.WProgUse, 8);
   DMyState.Left := 643;
   DMyState.Top := 61;
   DMyBag.SetImgIndex (FrmMain.WProgUse, 9);
   DMyBag.Left := 682;
   DMyBag.Top := 41;
   DMyMagic.SetImgIndex (FrmMain.WProgUse, 10);
   DMyMagic.Left := 722;
   DMyMagic.Top := 21;
   DOption.SetImgIndex (FrmMain.WProgUse, 11);
   DOption.Left := 764;
   DOption.Top := 11;

   {-----------------------------------------------------------}

   //µ×²¿×´Ì¬À¸µÄÐ¡µØÍ¼¡¢½»Ò×¡¢ÐÐ»á¡¢×é°´Å¥
   DBotMiniMap.SetImgIndex (FrmMain.WProgUse, 130);
   DBotMiniMap.Left := 219;
   DBotMiniMap.Top := 104;
   DBotTrade.SetImgIndex (FrmMain.WProgUse, 132);
   DBotTrade.Left := 219 + 30; //560 - 30;
   DBotTrade.Top := 104;
   DBotGuild.SetImgIndex (FrmMain.WProgUse, 134);
   DBotGuild.Left := 219 + 30*2;
   DBotGuild.Top := 104;
   DBotGroup.SetImgIndex (FrmMain.WProgUse, 128);
   DBotGroup.Left := 219 + 30*3;
   DBotGroup.Top := 104;
   DBotPlusAbil.SetImgIndex (FrmMain.WProgUse, 140);
   DBotPlusAbil.Left := 219 + 30*4;
   DBotPlusAbil.Top := 104;

   DBotExit.SetImgIndex (FrmMain.WProgUse, 138);
   DBotExit.Left := 560;
   DBotExit.Top := 104;
   DBotLogout.SetImgIndex (FrmMain.WProgUse, 136);
   DBotLogout.Left := 560 - 30;
   DBotLogout.Top := 104;


   {-----------------------------------------------------------}

   //Belt
   DBelt1.Left := 285;  DBelt1.Width := 32;
   DBelt1.Top := 59;    DBelt1.Height := 29;
   DBelt2.Left := 328;  DBelt2.Width := 32;
   DBelt2.Top := 59;    DBelt2.Height := 29;
   DBelt3.Left := 371;  DBelt3.Width := 32;
   DBelt3.Top := 59;    DBelt3.Height := 29;
   DBelt4.Left := 415;  DBelt4.Width := 32;
   DBelt4.Top := 59;    DBelt4.Height := 29;
   DBelt5.Left := 459;  DBelt5.Width := 32;
   DBelt5.Top := 59;    DBelt5.Height := 29;
   DBelt6.Left := 503;  DBelt6.Width := 32;
   DBelt6.Top := 59;    DBelt6.Height := 29;


   {-----------------------------------------------------------}

   //»Æ½ð¡¢ÐÞÀíÎïÆ·¡¢¹Ø±Õ°ü¹ü°´Å¥
   DGold.SetImgIndex (FrmMain.WProgUse, 29);
   DGold.Left := 10;
   DGold.Top  := 190;
   DRepairItem.SetImgIndex (FrmMain.WProgUse, 26);
   DRepairItem.Left := 254;
   DRepairItem.Top := 183;
   DRepairItem.Width := 48;
   DRepairItem.Height := 22;
   DClosebag.SetImgIndex (FrmMain.WProgUse, 371);
   DCloseBag.Left := 309;
   DCloseBag.Top := 203;
   DCloseBag.Width := 14;
   DCloseBag.Height := 20;

   {-----------------------------------------------------------}

   //ÉÌÈË¶Ô»°¿ò
   d := FrmMain.WProgUse.Images[384];
   if d <> nil then begin
      DMerchantDlg.Left := 0;
      DMerchantDlg.Top := 0;
      DMerchantDlg.SetImgIndex (FrmMain.WProgUse, 384);
   end;
   DMerchantDlgClose.Left := 399;
   DMerchantDlgClose.Top := 1;
   DMerchantDlgClose.SetImgIndex (FrmMain.WProgUse, 64);

   {-----------------------------------------------------------}

   //²Ëµ¥¶Ô»°¿ò
   d := FrmMain.WProgUse.Images[385];
   if d <> nil then begin
      DMenuDlg.Left := 138;
      DMenuDlg.Top  := 163;
      DMenuDlg.SetImgIndex (FrmMain.WProgUse, 385);
   end;
   DMenuPrev.Left := 43;
   DMenuPrev.Top := 175;
   DMenuPrev.SetImgIndex (FrmMain.WProgUse, 388);
   DMenuNext.Left := 90;
   DMenuNext.Top := 175;
   DMenuNext.SetImgIndex (FrmMain.WProgUse, 387);
   DMenuBuy.Left := 215;
   DMenuBuy.Top := 171;
   DMenuBuy.SetImgIndex (FrmMain.WProgUse, 386);
   DMenuClose.Left := 291;
   DMenuClose.Top := 0;
   DMenuClose.SetImgIndex (FrmMain.WProgUse, 64);

   {-----------------------------------------------------------}

   //³öÊÛ
   d := FrmMain.WProgUse.Images[392];
   if d <> nil then begin
      DSellDlg.Left := 328;
      DSellDlg.Top  := 163;
      DSellDlg.SetImgIndex (FrmMain.WProgUse, 392);
   end;
   DSellDlgOk.Left := 85;
   DSellDlgOk.Top := 150;
   DSellDlgOk.SetImgIndex (FrmMain.WProgUse, 393);
   DSellDlgClose.Left := 115;
   DSellDlgClose.Top := 0;
   DSellDlgClose.SetImgIndex (FrmMain.WProgUse, 64);
   DSellDlgSpot.Left := 27;
   DSellDlgSpot.Top  := 67;
   DSellDlgSpot.Width := 61;
   DSellDlgSpot.Height := 52;

   {-----------------------------------------------------------}

   //¹¦ÄÜ¼üÉèÖÃ¶Ô»°¿ò
   d := FrmMain.WProgUse.Images[229];
   if d <> nil then begin
      DKeySelDlg.Left := (SCREENWIDTH - d.Width) div 2;
      DKeySelDlg.Top  := (SCREENHEIGHT - d.Height) div 2;
      DKeySelDlg.SetImgIndex (FrmMain.WProgUse, 229);
   end;
   DKsIcon.Left := 52;   //DMagIcon...
   DKsIcon.Top := 29;
   DKsF1.SetImgIndex (FrmMain.WProgUse, 232);
   DKsF1.Left := 34;
   DKsF1.Top  := 83;
   DKsF2.SetImgIndex (FrmMain.WProgUse, 234);
   DKsF2.Left := 66;
   DKsF2.Top  := 83;
   DKsF3.SetImgIndex (FrmMain.WProgUse, 236);
   DKsF3.Left := 98;
   DKsF3.Top  := 83;
   DKsF4.SetImgIndex (FrmMain.WProgUse, 238);
   DKsF4.Left := 130;
   DKsF4.Top  := 83;
   DKsF5.SetImgIndex (FrmMain.WProgUse, 240);
   DKsF5.Left := 171;
   DKsF5.Top  := 83;
   DKsF6.SetImgIndex (FrmMain.WProgUse, 242);
   DKsF6.Left := 203;
   DKsF6.Top  := 83;
   DKsF7.SetImgIndex (FrmMain.WProgUse, 244);
   DKsF7.Left := 235;
   DKsF7.Top  := 83;
   DKsF8.SetImgIndex (FrmMain.WProgUse, 246);
   DKsF8.Left := 267;
   DKsF8.Top  := 83;
   DKsNone.SetImgIndex (FrmMain.WProgUse, 230);
   DKsNone.Left := 299;
   DKsNone.Top  := 83;
   DKsOk.SetImgIndex (FrmMain.WProgUse, 62);
   DKsOk.Left := 222;
   DKsOk.Top  := 131;

   {-----------------------------------------------------------}
   //×é¶Ô»°¿ò
   d := FrmMain.WProgUse.Images[120];
   if d <> nil then begin
      DGroupDlg.Left := (SCREENWIDTH - d.Width) div 2;
      DGroupDlg.Top  := (SCREENHEIGHT - d.Height) div 2;
      DGroupDlg.SetImgIndex (FrmMain.WProgUse, 120);
   end;
   DGrpDlgClose.SetImgIndex (FrmMain.WProgUse, 64);
   DGrpDlgClose.Left := 260;
   DGrpDlgClose.Top := 0;
   DGrpAllowGroup.SetImgIndex (FrmMain.WProgUse, 122);
   DGrpAllowGroup.Left := 20;
   DGrpAllowGroup.Top := 18;
   DGrpCreate.SetImgIndex (FrmMain.WProgUse, 123);
   DGrpCreate.Left := 21+1;
   DGrpCreate.Top := 202+1;
   DGrpAddMem.SetImgIndex (FrmMain.WProgUse, 124);
   DGrpAddMem.Left := 96+1;
   DGrpAddMem.Top := 202+1;
   DGrpDelMem.SetImgIndex (FrmMain.WProgUse, 125);
   DGrpDelMem.Left := 171+1;
   DGrpDelMem.Top := 202+1;

   {-----------------------------------------------------------}
   //½»Ò×¶Ô»°¿ò
   d := FrmMain.WProgUse.Images[389];  //Âô³ö·½
   if d <> nil then begin
      DDealDlg.Left := SCREENWIDTH - d.Width;
      DDealDlg.Top  := 0;
      DDealDlg.SetImgIndex (FrmMain.WProgUse, 389);
   end;
   DDGrid.Left := 21;
   DDGrid.Top  := 56;
   DDGrid.Width := 36 * 5;
   DDGrid.Height := 33 * 2;
   DDealOk.SetImgIndex (FrmMain.WProgUse, 391);
   DDealOk.Left := 155;
   DDealOk.Top := 193-65;
   DDealClose.SetImgIndex (FrmMain.WProgUse, 64);
   DDealClose.Left := 220;
   DDealClose.Top := 42;
   DDGold.SetImgIndex (FrmMain.WProgUse, 28);
   DDGold.Left := 11;
   DDGold.Top  := 202-65;

   d := FrmMain.WProgUse.Images[390];  //Âò½ø·½
   if d <> nil then begin
      DDealRemoteDlg.Left := DDealDlg.Left - d.Width;
      DDealRemoteDlg.Top  := 0;
      DDealRemoteDlg.SetImgIndex (FrmMain.WProgUse, 390);
   end;
   DDRGrid.Left := 21;
   DDRGrid.Top  := 56;
   DDRGrid.Width := 36 * 5;
   DDRGrid.Height := 33 * 2;
   DDRGold.SetImgIndex (FrmMain.WProgUse, 28);
   DDRGold.Left := 11;
   DDRGold.Top  := 202-65;

   {-----------------------------------------------------------}
   //ÐÐ»á
   d := FrmMain.WProgUse.Images[180];
   if d <> nil then begin
      DGuildDlg.Left := 0;
      DGuildDlg.Top := 0;
      DGuildDlg.SetImgIndex (FrmMain.WProgUse, 180);
   end;
   DGDClose.Left := 584;
   DGDClose.Top  := 6;
   DGDClose.SetImgIndex (FrmMain.WProgUse, 64);
   DGDHome.Left := 13;
   DGDHome.Top  := 411;
   DGDHome.SetImgIndex (FrmMain.WProgUse, 198);
   DGDList.Left := 13;
   DGDList.Top  := 429;
   DGDList.SetImgIndex (FrmMain.WProgUse, 200);
   DGDChat.Left := 94;
   DGDChat.Top  := 429;
   DGDChat.SetImgIndex (FrmMain.WProgUse, 190);
   DGDAddMem.Left := 243;
   DGDAddMem.Top  := 411;
   DGDAddMem.SetImgIndex (FrmMain.WProgUse, 182);
   DGDDelMem.Left := 243;
   DGDDelMem.Top  := 429;
   DGDDelMem.SetImgIndex (FrmMain.WProgUse, 192);
   DGDEditNotice.Left := 325;
   DGDEditNotice.Top  := 411;
   DGDEditNotice.SetImgIndex (FrmMain.WProgUse, 196);
   DGDEditGrade.Left := 325;
   DGDEditGrade.Top  := 429;
   DGDEditGrade.SetImgIndex (FrmMain.WProgUse, 194);
   DGDAlly.Left := 407;
   DGDAlly.Top  := 411;
   DGDAlly.SetImgIndex (FrmMain.WProgUse, 184);
   DGDBreakAlly.Left := 407;
   DGDBreakAlly.Top  := 429;
   DGDBreakAlly.SetImgIndex (FrmMain.WProgUse, 186);
   DGDWar.Left := 529;
   DGDWar.Top  := 411;
   DGDWar.SetImgIndex (FrmMain.WProgUse, 202);
   DGDCancelWar.Left := 529;
   DGDCancelWar.Top  := 429;
   DGDCancelWar.SetImgIndex (FrmMain.WProgUse, 188);

   DGDUp.Left := 595;
   DGDUp.Top  := 239;
   DGDUp.SetImgIndex (FrmMain.WProgUse, 373);
   DGDDown.Left := 595;
   DGDDown.Top  := 291;
   DGDDown.SetImgIndex (FrmMain.WProgUse, 372);

   //ÐÐ»áÍ¨¸æ±à¼­¿ò
   DGuildEditNotice.SetImgIndex (FrmMain.WProgUse, 204);
   DGEOk.SetImgIndex (FrmMain.WProgUse, 361);
   DGEOk.Left := 514;
   DGEOk.Top := 287;
   DGEClose.SetImgIndex (FrmMain.WProgUse, 64);
   DGEClose.Left := 584;
   DGEClose.Top := 6;


   {-----------------------------------------------------------}
   //ÊôÐÔµ÷Õû¶Ô»°¿ò
   DAdjustAbility.SetImgIndex (FrmMain.WProgUse, 226);
   DAdjustAbilClose.SetImgIndex (FrmMain.WProgUse, 64);
   DAdjustAbilClose.Left := 316;
   DAdjustAbilClose.Top := 1;
   DAdjustAbilOk.SetImgIndex (FrmMain.WProgUse, 62);
   DAdjustAbilOk.Left := 220;
   DAdjustAbilOk.Top := 298;

   DPlusDC.SetImgIndex (FrmMain.WProgUse, 227);     DPlusDC.Left := 217; DPlusDC.Top := 101;
   DPlusMC.SetImgIndex (FrmMain.WProgUse, 227);     DPlusMC.Left := 217; DPlusMC.Top := 121;
   DPlusSC.SetImgIndex (FrmMain.WProgUse, 227);     DPlusSC.Left := 217; DPlusSC.Top := 140;
   DPlusAC.SetImgIndex (FrmMain.WProgUse, 227);     DPlusAC.Left := 217; DPlusAC.Top := 160;
   DPlusMAC.SetImgIndex (FrmMain.WProgUse, 227);    DPlusMAC.Left := 217; DPlusMAC.Top := 181;
   DPlusHP.SetImgIndex (FrmMain.WProgUse, 227);     DPlusHP.Left := 217; DPlusHP.Top := 201;
   DPlusMP.SetImgIndex (FrmMain.WProgUse, 227);     DPlusMP.Left := 217; DPlusMP.Top := 220;
   DPlusHit.SetImgIndex (FrmMain.WProgUse, 227);    DPlusHit.Left := 217; DPlusHit.Top := 240;
   DPlusSpeed.SetImgIndex (FrmMain.WProgUse, 227);  DPlusSpeed.Left := 217; DPlusSpeed.Top := 261;

   DMinusDC.SetImgIndex (FrmMain.WProgUse, 228);    DMinusDC.Left := 227; DMinusDC.Top := 101;
   DMinusMC.SetImgIndex (FrmMain.WProgUse, 228);    DMinusMC.Left := 227; DMinusMC.Top := 121;
   DMinusSC.SetImgIndex (FrmMain.WProgUse, 228);    DMinusSC.Left := 227; DMinusSC.Top := 140;
   DMinusAC.SetImgIndex (FrmMain.WProgUse, 228);    DMinusAC.Left := 227; DMinusAC.Top := 160;
   DMinusMAC.SetImgIndex (FrmMain.WProgUse, 228);   DMinusMAC.Left := 227; DMinusMAC.Top := 181;
   DMinusHP.SetImgIndex (FrmMain.WProgUse, 228);    DMinusHP.Left := 227; DMinusHP.Top := 201;
   DMinusMP.SetImgIndex (FrmMain.WProgUse, 228);    DMinusMP.Left := 227; DMinusMP.Top := 220;
   DMinusHit.SetImgIndex (FrmMain.WProgUse, 228);   DMinusHit.Left := 227; DMinusHit.Top := 240;
   DMinusSpeed.SetImgIndex (FrmMain.WProgUse, 228); DMinusSpeed.Left := 227; DMinusSpeed.Top := 261;

end;




{------------------------------------------------------------------------}



//´ò¿ª/¹Ø±ÕÎÒµÄÊôÐÔ¶Ô»°¿ò
procedure TFrmDlg.OpenMyStatus;
begin
   DStateWin.Visible := not DStateWin.Visible;
   PageChanged;
end;
//ÏÔÊ¾Íæ¼ÓÐÅÏ¢¶Ô»°¿ò
procedure TFrmDlg.OpenUserState (ustate: TUserStateInfo);
begin
   UserState1 := ustate;
   DUserState1.Visible := TRUE;
end;

//ÏÔÊ¾/¹Ø±ÕÎïÆ·¶Ô»°¿ò
procedure TFrmDlg.OpenItemBag;
begin
   DItemBag.Visible := not DItemBag.Visible;
   if DItemBag.Visible then
      ArrangeItemBag;
end;

//µ×²¿×´Ì¬¿ò
procedure TFrmDlg.ViewBottomBox (visible: Boolean);
begin
   DBottom.Visible := visible;
end;


// È¡ÏûÎïÆ·ÒÆ¶¯
procedure TFrmDlg.CancelItemMoving;
var
   idx, n: integer;
begin
   if ItemMoving then begin
      ItemMoving := FALSE;
      idx := MovingItem.Index;
      if idx < 0 then begin
         if (idx <= -20) and (idx > -30) then begin
            AddDealItem (MovingItem.Item);
         end else begin
            n := -(idx+1);
            if n in [0..8] then begin
               UseItems[n] := MovingItem.Item;
            end;
         end;
      end else
         if idx in [0..MAXBAGITEM-1] then begin
            if ItemArr[idx].S.Name = '' then begin
               ItemArr[idx] := MovingItem.Item;
            end else begin
               AddItemBag (MovingItem.Item);
            end;
         end;
      MovingItem.Item.S.Name := '';
   end;
   ArrangeItemBag;
end;

//°ÑÒÆ¶¯µÄÎïÆ··ÅÏÂ
procedure TFrmDlg.DropMovingItem;
var
   idx: integer;
begin
   if ItemMoving then begin
      ItemMoving := FALSE;
      if MovingItem.Item.S.Name <> '' then begin
         FrmMain.SendDropItem (MovingItem.Item.S.Name, MovingItem.Item.MakeIndex);
         AddDropItem (MovingItem.Item);
         MovingItem.Item.S.Name := '';
      end;
   end;
end;
//´ò¿ªÊôÐÔµ÷Õû¶Ô»°¿ò
procedure TFrmDlg.OpenAdjustAbility;
begin
   DAdjustAbility.Left := 0;
   DAdjustAbility.Top := 0;
   SaveBonusPoint := BonusPoint;
   FillChar (BonusAbilChg, sizeof(TNakedAbility), #0);
   DAdjustAbility.Visible := TRUE;
end;

procedure TFrmDlg.DBackgroundBackgroundClick(Sender: TObject);
var
   dropgold: integer;
   valstr: string;
begin
   if ItemMoving then begin
      DBackground.WantReturn := TRUE;
      if MovingItem.Item.S.Name = '½ð×Ó' then begin
         ItemMoving := FALSE;
         MovingItem.Item.S.Name := '';
         //¾ó¸¶¸¦ ¹ö¸± °ÇÁö ¹°¾îº»´Ù.
         DialogSize := 1;
         DMessageDlg ('ÄãÏë·ÅÏÂ¶àÉÙ½ð×Ó?', [mbOk, mbAbort]);
         GetValidStrVal (DlgEditText, valstr, [' ']);
         dropgold := Str_ToInt (valstr, 0);
         //
         FrmMain.SendDropGold (dropgold);
      end;
      if MovingItem.Index >= 0 then //¾ÆÀÌÅÛ °¡¹æ¿¡¼­ ¹ö¸°°Í¸¸..
         DropMovingItem;
   end;
end;

procedure TFrmDlg.DBackgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if ItemMoving then begin
      DBackground.WantReturn := TRUE;
   end;
end;

procedure TFrmDlg.DBottomMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
   function ExtractUserName (line: string): string;
   var
      uname: string;
   begin
      GetValidStr3 (line, line, ['(', '!', '*', '/', ')']);
      GetValidStr3 (line, uname, [' ', '=', ':']);
      if uname <> '' then
         if (uname[1] = '/') or (uname[1] = '(') or (uname[1] = ' ') or (uname[1] = '[') then
            uname := '';
      Result := uname;
   end;
var
   n: integer;
   str: string;
begin
   //µ±Êó±êµãÔÚµ×²¿×´Ì¬À¸µÄÏûÏ¢ÉÏÊ±£¬
   if (X >= 208) and (X <= 208+374) and (Y >= SCREENHEIGHT-130) and (Y <= SCREENHEIGHT-130 + 12*9) then begin
      n := DScreen.ChatBoardTop + (Y - (SCREENHEIGHT-130)) div 12;
      if (n < DScreen.ChatStrs.Count) then begin
         if not PlayScene.EdChat.Visible then begin
            PlayScene.EdChat.Visible := TRUE;
            PlayScene.EdChat.SetFocus;
         end;
         PlayScene.EdChat.Text := '/' + ExtractUserName (DScreen.ChatStrs[n]) + ' ';
         PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
         PlayScene.EdChat.SelLength := 0;
      end else
         PlayScene.EdChat.Text := '';
   end;
end;

{------------------------------------------------------------------------}

////ÏÔÊ¾Í¨ÓÃ¶Ô»°¿ò
function  TFrmDlg.DMessageDlg (msgstr: string; DlgButtons: TMsgDlgButtons): TModalResult;
const
   XBase = 324;
var
   lx, ly: integer;
   d: TDirectDrawSurface;
begin
   lx := XBase;
   ly := 126;
   case DialogSize of
      0:  //Ð¡¶Ô»°¿ò
         begin
            d := FrmMain.WProgUse.Images[381];
            if d <> nil then begin
               DMsgDlg.SetImgIndex (FrmMain.WProgUse, 381);
               DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
               DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
               msglx := 39;
               msgly := 38;
               lx := XBase;
               ly := 126;
            end;
         end;
      1:  //´ó¶Ô»°¿ò£¨ºá£©
         begin
            d := FrmMain.WProgUse.Images[360];
            if d <> nil then begin
               DMsgDlg.SetImgIndex (FrmMain.WProgUse, 360);
               DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
               DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
               msglx := 39;
               msgly := 38;
               lx := XBase;
               ly := 126;
            end;
         end;
      2:  //´ó¶Ô»°¿ò£¨Êú£©
         begin
            d := FrmMain.WProgUse.Images[380];
            if d <> nil then begin
               DMsgDlg.SetImgIndex (FrmMain.WProgUse, 380);
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
   ViewDlgEdit := FALSE;       //±à¼­¿ò²»¿É¼û
   DMsgDlg.Floating := TRUE;   //ÔÊÐíÊó±êÒÆ¶¯
   DMsgDlgOk.Visible := FALSE;
   DMsgDlgYes.Visible := FALSE;
   DMsgDlgCancel.Visible := FALSE;
   DMsgDlgNo.Visible := FALSE;
   DMsgDlg.Left := (SCREENWIDTH - DMsgDlg.Width) div 2;
   DMsgDlg.Top := (SCREENHEIGHT - DMsgDlg.Height) div 2;
   //µ÷Õû°´Å¥
   if mbCancel in DlgButtons then begin
      DMsgDlgCancel.Left := lx;
      DMsgDlgCancel.Top := ly;
      DMsgDlgCancel.Visible := TRUE;
      lx := lx - 110;
   end;
   if mbNo in DlgButtons then begin
      DMsgDlgNo.Left := lx;
      DMsgDlgNo.Top := ly;
      DMsgDlgNo.Visible := TRUE;
      lx := lx - 110;
   end;
   if mbYes in DlgButtons then begin
      DMsgDlgYes.Left := lx;
      DMsgDlgYes.Top := ly;
      DMsgDlgYes.Visible := TRUE;
      lx := lx - 110;
   end;
   if (mbOk in DlgButtons) or (lx = XBase) then begin
      DMsgDlgOk.Left := lx;
      DMsgDlgOk.Top := ly;
      DMsgDlgOk.Visible := TRUE;
      lx := lx - 110;
   end;
   HideAllControls;
   DMsgDlg.ShowModal;

   if mbAbort in DlgButtons then begin
      ViewDlgEdit := TRUE; //ÏÔÊ¾±à¼­¿ò.
      DMsgDlg.Floating := FALSE;
      with EdDlgEdit do begin
         Text := '';
         Width := DMsgDlg.Width - 70;
         Left := (SCREENWIDTH - EdDlgEdit.Width) div 2;
         Top  := (SCREENHEIGHT - EdDlgEdit.Height) div 2 - 10;
      end;
   end;
   Result := mrOk;
   while TRUE do begin
      if not DMsgDlg.Visible then break;
      FrmMain.ProcOnIdle;
      Application.ProcessMessages;
      if Application.Terminated then exit;
   end;
   EdDlgEdit.Visible := FALSE;
   RestoreHideControls;
   DlgEditText := EdDlgEdit.Text;
   if PlayScene.EdChat.Visible then PlayScene.EdChat.SetFocus;
   ViewDlgEdit := FALSE;
   Result := DMsgDlg.DialogResult;
   DialogSize := 1; 
end;

procedure TFrmDlg.DMsgDlgOkClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DMsgDlgOk then DMsgDlg.DialogResult := mrOk;
   if Sender = DMsgDlgYes then DMsgDlg.DialogResult := mrYes;
   if Sender = DMsgDlgCancel then DMsgDlg.DialogResult := mrCancel;
   if Sender = DMsgDlgNo then DMsgDlg.DialogResult := mrNo;
   DMsgDlg.Visible := FALSE;
end;

procedure TFrmDlg.DMsgDlgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = 13 then begin
      if DMsgDlgOk.Visible and not (DMsgDlgYes.Visible or DMsgDlgCancel.Visible or DMsgDlgNo.Visible) then begin
         DMsgDlg.DialogResult := mrOk;
         DMsgDlg.Visible := FALSE;
      end;
      if DMsgDlgYes.Visible and not (DMsgDlgOk.Visible or DMsgDlgCancel.Visible or DMsgDlgNo.Visible) then begin
         DMsgDlg.DialogResult := mrYes;
         DMsgDlg.Visible := FALSE;
      end;
   end;
   if Key = 27 then begin
      if DMsgDlgCancel.Visible then begin
         DMsgDlg.DialogResult := mrCancel;
         DMsgDlg.Visible := FALSE;
      end;
   end;
end;

procedure TFrmDlg.DMsgDlgOkDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if not Downed then
         d := WLib.Images[FaceIndex]
      else d := WLib.Images[FaceIndex+1];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
   end;
end;

procedure TFrmDlg.DMsgDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  ly: integer;
  str, data: string;
begin
   with Sender as TDWindow do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      ly := msgly;
      str := MsgText;
      while TRUE do begin
         if str = '' then break;
         str := GetValidStr3 (str, data, ['\']);
         if data <> '' then
            BoldTextOut (dsurface, SurfaceX(Left+msglx), SurfaceY(Top+ly), clWhite, clBlack, data);
         ly := ly + 14;
      end;
      dsurface.Canvas.Release;
   end;
   if ViewDlgEdit then begin
      if not EdDlgEdit.Visible then begin
         EdDlgEdit.Visible := TRUE;
         EdDlgEdit.SetFocus;
      end;
   end;
end;




{------------------------------------------------------------------------}

procedure TFrmDlg.DLoginNewDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if TDButton(Sender).Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DLoginNewClick(Sender: TObject; X, Y: Integer);
begin
   LoginScene.NewClick;
end;

procedure TFrmDlg.DLoginOkClick(Sender: TObject; X, Y: Integer);
begin
   LoginScene.OkClick;
end;

procedure TFrmDlg.DLoginCloseClick(Sender: TObject; X, Y: Integer);
begin
   FrmMain.Close;
end;

procedure TFrmDlg.DLoginChgPwClick(Sender: TObject; X, Y: Integer);
begin
   LoginScene.ChgPwClick;
end;

procedure TFrmDlg.DLoginNewClickSound(Sender: TObject;
  Clicksound: TClickSound);
begin
   case Clicksound of
      csNorm:  PlaySound (s_norm_button_click);
      csStone: PlaySound (s_rock_button_click);
      csGlass: PlaySound (s_glass_button_click);
   end;
end;



{------------------------------------------------------------------------}
//ÏÔÊ¾Ñ¡Ôñ·þÎñÆ÷¶Ô»°¿ò
procedure TFrmDlg.ShowSelectServerDlg;
begin
   DSelServerDlg.Visible := TRUE;
end;

procedure TFrmDlg.DSServer1Click(Sender: TObject; X, Y: Integer);
var
   svname: string;
begin
   svname := '';
   if Sender = DSServer1 then begin //¼­¹ö 3¹ø..
      svname := '×ÝºáÌìÏÂ';
      ServerMiniName := 'ÌìÏÂ';
   end;
   if Sender = DSServer2 then begin //¼­¹ö 4¹ø..
      svname := 'Ð¦°Á½­ºþ';
      ServerMiniName := '½­ºþ';
   end;
   if Sender = DSServer3 then begin //¼­¹ö 1¹ø..
      svname := '¹ö¹öºì³¾';
      ServerMiniName := 'ºì³¾';
   end;
   if Sender = DSServer4 then begin //¼­¹ö 2¹ø..
      svname := '·ÉÁúÔÚÌì';
      ServerMiniName := '·ÉÁú';
   end;
   if Sender = DSServer5 then begin //¼­¹ö 3¹ø..
      svname := 'Ç±ÁúÔÚÔ¨';
      ServerMiniName := 'Ç±Áú';
   end;
   if Sender = DSServer6 then begin //¼­¹ö 4¹ø..
      svname := '»¢ÂäÆ½Ñô';
      ServerMiniName := 'Æ½Ñô';
   end;
   if svname <> '' then begin
      if BO_FOR_TEST then begin
         svname := '';
         ServerMiniName := '';
      end;
      FrmMain.SendSelectServer (svname);
      DSelServerDlg.Visible := FALSE;
      ServerName := svname;
   end;
end;

procedure TFrmDlg.DEngServer1Click(Sender: TObject; X, Y: Integer);
var
   svname: string;
begin
   svname := '´ºÇïÕ½¹ú';
   ServerMiniName := 'Õ½¹ú';

   if svname <> '' then begin
      if BO_FOR_TEST then begin
         svname := '´ºÇïÕ½¹ú';
         ServerMiniName := 'Õ½¹ú';
      end;
      FrmMain.SendSelectServer (svname);
      DSelServerDlg.Visible := FALSE;
      ServerName := svname;
   end;
end;


procedure TFrmDlg.DSSrvCloseClick(Sender: TObject; X, Y: Integer);
begin
   DSelServerDlg.Visible := FALSE;
   FrmMain.Close;
end;


{------------------------------------------------------------------------}
//ÐÂÕÊºÅ
procedure TFrmDlg.DNewAccountOkClick(Sender: TObject; X, Y: Integer);
begin
   LoginScene.NewAccountOk;
end;

procedure TFrmDlg.DNewAccountCloseClick(Sender: TObject; X, Y: Integer);
begin
   LoginScene.NewAccountClose;
end;

procedure TFrmDlg.DNewAccountDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   i: integer;
begin
   with dsurface.Canvas do begin
      with DNewAccount do begin
         d := DMenuDlg.WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
      SetBkMode (Handle, TRANSPARENT);
      Font.Color := clSilver;
      for i:=0 to NAHelps.Count-1 do begin
         TextOut (79 + 386 + 10, 64 + 119 + 5 + i*14, NAHelps[i]);
      end;
      BoldTextOut (dsurface, 79+283, 64 + 57, clWhite, clBlack, NewAccountTitle);
      Release;
   end;
end;



{------------------------------------------------------------------------}
////Chg pw
procedure TFrmDlg.DChgpwOkClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DChgpwOk then LoginScene.ChgpwOk;
   if Sender = DChgpwCancel then LoginScene.ChgpwCancel;
end;

{------------------------------------------------------------------------}
//
procedure TFrmDlg.DscSelect1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (Left, Top, d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DscSelect1Click(Sender: TObject; X, Y: Integer);
begin
   if Sender = DscSelect1 then SelectChrScene.SelChrSelect1Click;
   if Sender = DscSelect2 then SelectChrScene.SelChrSelect2Click;
   if Sender = DscStart then SelectChrScene.SelChrStartClick;
   if Sender = DscNewChr then SelectChrScene.SelChrNewChrClick;
   if Sender = DscEraseChr then SelectChrScene.SelChrEraseChrClick;
   if Sender = DscCredits then SelectChrScene.SelChrCreditsClick;
   if Sender = DscExit then SelectChrScene.SelChrExitClick;
end;

{------------------------------------------------------------------------}
//»õ Ä³¸¯ÅÍ ¸¸µé±â Ã¢

procedure TFrmDlg.DccCloseDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
   end else begin
         d := nil;
         if Sender = DccWarrior then begin
            with SelectChrScene do
               if ChrArr[NewIndex].UserChr.Job = 0 then d := WLib.Images[55];
         end;
         if Sender = DccWizzard then begin
            with SelectChrScene do
               if ChrArr[NewIndex].UserChr.Job = 1 then d := WLib.Images[56];
         end;
         if Sender = DccMonk then begin
            with SelectChrScene do
               if ChrArr[NewIndex].UserChr.Job = 2 then d := WLib.Images[57];
         end;
         if Sender = DccMale then begin
            with SelectChrScene do
               if ChrArr[NewIndex].UserChr.Sex = 0 then d := WLib.Images[58];
         end;
         if Sender = DccFemale then begin
            with SelectChrScene do
               if ChrArr[NewIndex].UserChr.Sex = 1 then d := WLib.Images[59];
         end;
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DccCloseClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DccClose then SelectChrScene.SelChrNewClose;
   if Sender = DccWarrior then SelectChrScene.SelChrNewJob (0);
   if Sender = DccWizzard then SelectChrScene.SelChrNewJob (1);
   if Sender = DccMonk then SelectChrScene.SelChrNewJob (2);
   if Sender = DccReserved then SelectChrScene.SelChrNewJob (3);
   if Sender = DccMale then SelectChrScene.SelChrNewSex (0);
   if Sender = DccFemale then SelectChrScene.SelChrNewSex (1);
   if Sender = DccLeftHair then SelectChrScene.SelChrNewPrevHair;
   if Sender = DccRightHair then SelectChrScene.SelChrNewNextHair;
   if Sender = DccOk then SelectChrScene.SelChrNewOk;
end;





{------------------------------------------------------------------------}

//»óÅÂÃ¢...

{------------------------------------------------------------------------}


procedure TFrmDlg.DStateWinDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   i, l, m, pgidx, magline, bbx, bby, mmx, idx, ax, ay, trainlv: integer;
   pm: PTClientMagic;
   d: TDirectDrawSurface;
   hcolor, old, keyimg: integer;
   iname, d1, d2, d3: string;
   useable: Boolean;
begin
   if Myself = nil then exit;
   with DStateWin do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      case StatePage of
         0: begin //×°±¸
            pgidx := 376;
            if Myself <> nil then
               if Myself.Sex = 1 then pgidx := 377;
            bbx := Left + 38;
            bby := Top + 52;
            d := FrmMain.WProgUse.Images[pgidx];
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);
            bbx := bbx - 7;
            bby := bby + 44;
            //·¢ÐÍ
            idx := 440 + Myself.Hair div 2;
            if Myself.Sex = 1 then idx := 480 + Myself.Hair div 2;
            if idx > 0 then begin
               d := FrmMain.WProgUse.GetCachedImage (idx, ax, ay);
               if d <> nil then
                  dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
            end;
            //·þ×°
            if UseItems[U_DRESS].S.Name <> '' then begin
               idx := UseItems[U_DRESS].S.Looks; //¿Ê if Myself.Sex = 1 then idx := 80; //¿©ÀÚ¿Ê
               if idx >= 0 then begin
                  d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                  if d <> nil then
                     dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
               end;
            end;
            //ÎäÆ÷
            if UseItems[U_WEAPON].S.Name <> '' then begin
               idx := UseItems[U_WEAPON].S.Looks;
               if idx >= 0 then begin
                  d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                  if d <> nil then
                     dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
               end;
            end;
            //Í·¿ø
            if UseItems[U_HELMET].S.Name <> '' then begin
               idx := UseItems[U_HELMET].S.Looks;
               if idx >= 0 then begin
                  d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                  if d <> nil then
                     dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
               end;
            end;
         end;
         1: begin //×´Ì¬Öµ
            l := Left + 112; //66;
            m := Top + 99;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(l+0), SurfaceY(m+0), IntToStr(Lobyte(Myself.Abil.AC)) + '-' + IntToStr(Hibyte(Myself.Abil.AC)));
               TextOut (SurfaceX(l+0), SurfaceY(m+20), IntToStr(Lobyte(Myself.Abil.MAC)) + '-' + IntToStr(Hibyte(Myself.Abil.MAC)));
               TextOut (SurfaceX(l+0), SurfaceY(m+40), IntToStr(Lobyte(Myself.Abil.DC)) + '-' + IntToStr(Hibyte(Myself.Abil.DC)));
               TextOut (SurfaceX(l+0), SurfaceY(m+60), IntToStr(Lobyte(Myself.Abil.MC)) + '-' + IntToStr(Hibyte(Myself.Abil.MC)));
               TextOut (SurfaceX(l+0), SurfaceY(m+80), IntToStr(Lobyte(Myself.Abil.SC)) + '-' + IntToStr(Hibyte(Myself.Abil.SC)));
               TextOut (SurfaceX(l+0), SurfaceY(m+100), IntToStr(Myself.Abil.HP) + '/' + IntToStr(Myself.Abil.MaxHP));
               TextOut (SurfaceX(l+0), SurfaceY(m+120), IntToStr(Myself.Abil.MP) + '/' + IntToStr(Myself.Abil.MaxMP));
               Release;
            end;
         end;
         2: begin //¼¼ÄÜ×´Ì¬
            bbx := Left + 38;
            bby := Top + 52;
            d := FrmMain.WProgUse.Images[382];
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);

            bbx := bbx + 20;
            bby := bby + 10;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               mmx := bbx + 85;
               Font.Color := clSilver;
               TextOut (bbx, bby, '¾­Ñé');
               TextOut (mmx, bby, FloatToStrFixFmt (100 * Myself.Abil.Exp / Myself.Abil.MaxExp, 3, 2) + '%');

               TextOut (bbx, bby+14*1, '¸ºÖØ');
               if Myself.Abil.Weight > Myself.Abil.MaxWeight then
                  Font.Color := clRed;
               TextOut (mmx, bby+14*1, IntToStr(Myself.Abil.Weight) + '/' + IntToStr(Myself.Abil.MaxWeight));

               Font.Color := clSilver;
               TextOut (bbx, bby+14*2, '×°±¸¸ºÖØ');
               if Myself.Abil.WearWeight > Myself.Abil.MaxWearWeight then
                  Font.Color := clRed;
               TextOut (mmx, bby+14*2, IntToStr(Myself.Abil.WearWeight) + '/' + IntToStr(Myself.Abil.MaxWearWeight));

               Font.Color := clSilver;
               TextOut (bbx, bby+14*3, 'ÊÖÖ´¸ºÖØ');
               if Myself.Abil.HandWeight > Myself.Abil.MaxHandWeight then
                  Font.Color := clRed;
               TextOut (mmx, bby+14*3, IntToStr(Myself.Abil.HandWeight) + '/' + IntToStr(Myself.Abil.MaxHandWeight));

               Font.Color := clSilver;
               TextOut (bbx, bby+14*4, '¹¥»÷');
               TextOut (mmx, bby+14*4, IntToStr(MyHitPoint));

               TextOut (bbx, bby+14*5, 'ËÙ¶È');
               TextOut (mmx, bby+14*5, IntToStr(MySpeedPoint));

               TextOut (bbx, bby+14*6, '·ÀÄ§·¨');
               TextOut (mmx, bby+14*6, '+' + IntToStr(MyAntiMagic * 10) + '%');

               TextOut (bbx, bby+14*7, '·À¶¾');
               TextOut (mmx, bby+14*7, '+' + IntToStr(MyAntiPoison * 10) + '%');

               TextOut (bbx, bby+14*8, 'ÖÐ¶¾»Ö¸´');
               TextOut (mmx, bby+14*8, '+' + IntToStr(MyPoisonRecover * 10) + '%');

               TextOut (bbx, bby+14*9, 'ÌåÁ¦»Ö¸´');
               TextOut (mmx, bby+14*9, '+' + IntToStr(MyHealthRecover * 10) + '%');

               TextOut (bbx, bby+14*10, '»èÃÔ»Ö¸´');
               TextOut (mmx, bby+14*10, '+' + IntToStr(MySpellRecover * 10) + '%');

               Release;
            end;
         end;
         3: begin //¸¶¹ý Ã¢
            bbx := Left + 38;
            bby := Top + 52;
            d := FrmMain.WProgUse.Images[383];
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);

            //¹¦ÄÜ¼ü, lv, exp
            magtop := MagicPage * 5;
            magline := _MIN(MagicPage*5+5, MagicList.Count);
            for i:=magtop to magline-1 do begin
               pm := PTClientMagic (MagicList[i]);
               m := i - magtop;
               keyimg := 0;
               case byte(pm.Key) of
                  byte('1'): keyimg := 248;
                  byte('2'): keyimg := 249;
                  byte('3'): keyimg := 250;
                  byte('4'): keyimg := 251;
                  byte('5'): keyimg := 252;
                  byte('6'): keyimg := 253;
                  byte('7'): keyimg := 254;
                  byte('8'): keyimg := 255;
               end;
               if keyimg > 0 then begin
                  d := FrmMain.WProgUse.Images[keyimg];
                  if d <> nil then
                     dsurface.Draw (bbx + 145, bby+8+m*37, d.ClientRect, d, TRUE);
               end;
               d := FrmMain.WProgUse.Images[112]; //lv
               if d <> nil then
                  dsurface.Draw (bbx + 48, bby+8+15+m*37, d.ClientRect, d, TRUE);
               d := FrmMain.WProgUse.Images[111]; //exp
               if d <> nil then
                  dsurface.Draw (bbx + 48 + 26, bby+8+15+m*37, d.ClientRect, d, TRUE);
            end;

            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clSilver;
               for i:=magtop to magline-1 do begin
                  pm := PTClientMagic (MagicList[i]);
                  m := i - magtop;
                  if not (pm.Level in [0..3]) then pm.Level := 0;  //Ä§·¨×î¶à3¼¶
                  TextOut (bbx + 48, bby + 8 + m*37,
                              pm.Def.MagicName);
                  if pm.Level in [0..3] then trainlv := pm.Level
                  else trainlv := 0;
                  TextOut (bbx + 48 + 16, bby + 8 + 15 + m*37, IntToStr(pm.Level));
                  if pm.Def.MaxTrain[trainlv] > 0 then begin
                     if trainlv < 3 then
                        TextOut (bbx + 48 + 46, bby + 8 + 15 + m*37, IntToStr(pm.CurTrain) + '/' + IntToStr(pm.Def.MaxTrain[trainlv]))
                     else TextOut (bbx + 48 + 46, bby + 8 + 15 + m*37, '-');
                  end;
               end;
               Release;
            end;
         end;
      end;
      if MouseStateItem.S.Name <> '' then begin
         MouseItem := MouseStateItem;
         GetMouseItemInfo (iname, d1, d2, d3, useable);
         if iname <> '' then begin
            if MouseItem.Dura = 0 then hcolor := clRed
            else hcolor := clWhite;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               old := Font.Size;
               Font.Size := 8;
               Font.Color := clYellow;
               TextOut (SurfaceX(Left+37), SurfaceY(Top+272), iname);
               Font.Color := hcolor;
               TextOut (SurfaceX(Left+37+TextWidth(iname)), SurfaceY(Top+272), d1);
               TextOut (SurfaceX(Left+37), SurfaceY(Top+272+TextHeight('A')+2), d2);
               TextOut (SurfaceX(Left+37), SurfaceY(Top+272+(TextHeight('A')+2)*2), d3);
               Font.Size := old; 
               Release;
            end;
         end;
         MouseItem.S.Name := '';
      end;

      //Íæ¼ÒÃû³Æ¡¢ÐÐ»á
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := Myself.NameColor;
         TextOut (SurfaceX(Left + 122 - TextWidth(FrmMain.CharName) div 2),
                  SurfaceY(Top + 23), Myself.UserName);
         if StatePage = 0 then begin
            Font.Color := clSilver;
            TextOut (SurfaceX(Left + 45), SurfaceY(Top + 55),
                     GuildName + ' ' + GuildRankName);
         end;
         Release;
      end;
   end;
end;

procedure TFrmDlg.DSWLightDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   if StatePage = 0 then begin
      if Sender = DSWNecklace then begin
         if UseItems[U_NECKLACE].S.Name <> '' then begin
            idx := UseItems[U_NECKLACE].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.WStateItem.Images[idx];
               if d <> nil then
                  dsurface.Draw (DSWNecklace.SurfaceX(DSWNecklace.Left + (DSWNecklace.Width - d.Width) div 2),
                                 DSWNecklace.SurfaceY(DSWNecklace.Top + (DSWNecklace.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;
      if Sender = DSWLight then begin
         if UseItems[U_RIGHTHAND].S.Name <> '' then begin
            idx := UseItems[U_RIGHTHAND].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.WStateItem.Images[idx];
               if d <> nil then
                  dsurface.Draw (DSWLight.SurfaceX(DSWLight.Left + (DSWLight.Width - d.Width) div 2),
                                 DSWLight.SurfaceY(DSWLight.Top + (DSWLight.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;
      if Sender = DSWArmRingR then begin
         if UseItems[U_ARMRINGR].S.Name <> '' then begin
            idx := UseItems[U_ARMRINGR].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.WStateItem.Images[idx];
               if d <> nil then
                  dsurface.Draw (DSWArmRingR.SurfaceX(DSWArmRingR.Left + (DSWArmRingR.Width - d.Width) div 2),
                                 DSWArmRingR.SurfaceY(DSWArmRingR.Top + (DSWArmRingR.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;
      if Sender = DSWArmRingL then begin
         if UseItems[U_ARMRINGL].S.Name <> '' then begin
            idx := UseItems[U_ARMRINGL].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.WStateItem.Images[idx];
               if d <> nil then
                  dsurface.Draw (DSWArmRingL.SurfaceX(DSWArmRingL.Left + (DSWArmRingL.Width - d.Width) div 2),
                                 DSWArmRingL.SurfaceY(DSWArmRingL.Top + (DSWArmRingL.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;
      if Sender = DSWRingR then begin
         if UseItems[U_RINGR].S.Name <> '' then begin
            idx := UseItems[U_RINGR].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.WStateItem.Images[idx];
               if d <> nil then
                  dsurface.Draw (DSWRingR.SurfaceX(DSWRingR.Left + (DSWRingR.Width - d.Width) div 2),
                                 DSWRingR.SurfaceY(DSWRingR.Top + (DSWRingR.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;
      if Sender = DSWRingL then begin
         if UseItems[U_RINGL].S.Name <> '' then begin
            idx := UseItems[U_RINGL].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.WStateItem.Images[idx];
               if d <> nil then
                  dsurface.Draw (DSWRingL.SurfaceX(DSWRingL.Left + (DSWRingL.Width - d.Width) div 2),
                                 DSWRingL.SurfaceY(DSWRingL.Top + (DSWRingL.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;

   end;
end;

procedure TFrmDlg.DStateWinClick(Sender: TObject; X, Y: Integer);
begin
   if StatePage = 3 then begin
      X := DStateWin.LocalX (X) - DStateWin.Left;
      Y := DStateWin.LocalY (Y) - DStateWin.Top;
      if (X >= 33) and (X <= 33+166) and (Y >= 55) and (Y <= 55+37*5) then begin
         magcur := (Y-55) div 37;
         if (magcur+magtop) >= MagicList.Count then
            magcur := (MagicList.Count-1) - magtop;
      end;
   end;
end;

procedure TFrmDlg.DCloseStateClick(Sender: TObject; X, Y: Integer);
begin
   DStateWin.Visible := FALSE;
end;

procedure TFrmDlg.DPrevStateDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if TDButton(Sender).Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.PageChanged;
begin
   case StatePage of
      3: begin //¸¶¹ý »óÅÂÃ¢
         DStMag1.Visible := TRUE;
         DStMag2.Visible := TRUE;
         DStMag3.Visible := TRUE;
         DStMag4.Visible := TRUE;
         DStMag5.Visible := TRUE;
         DStPageUp.Visible := TRUE;
         DStPageDown.Visible := TRUE;
         MagicPage := 0;
      end;
      else begin
         DStMag1.Visible := FALSE;
         DStMag2.Visible := FALSE;
         DStMag3.Visible := FALSE;
         DStMag4.Visible := FALSE;
         DStMag5.Visible := FALSE;
         DStPageUp.Visible := FALSE;
         DStPageDown.Visible := FALSE;
      end;
   end;
end;

procedure TFrmDlg.DPrevStateClick(Sender: TObject; X, Y: Integer);
begin
   Dec (StatePage);
   if StatePage < 0 then
      StatePage := MAXSTATEPAGE-1;
   PageChanged;
end;

procedure TFrmDlg.DNextStateClick(Sender: TObject; X, Y: Integer);
begin
   Inc (StatePage);
   if StatePage > MAXSTATEPAGE-1 then
      StatePage := 0;
   PageChanged;
end;
//µã»÷ÎäÆ÷¡¢ÒÂ·þµÈ×°±¸
procedure TFrmDlg.DSWWeaponClick(Sender: TObject; X, Y: Integer);
var
   where, n, sel: integer;
   flag, movcancel: Boolean;
begin
   if Myself = nil then exit;
   if StatePage <> 0 then exit;
   if ItemMoving then begin
      flag := FALSE;
      movcancel := FALSE;
      if (MovingItem.Index = -97) or (MovingItem.Index = -98) then exit;
      if (MovingItem.Item.S.Name = '') or (WaitingUseItem.Item.S.Name <> '') then exit;
      where := GetTakeOnPosition (MovingItem.Item.S.StdMode);
      if MovingItem.Index >= 0 then begin
         case where of
            U_DRESS: begin
               if Sender = DSWDress then begin
                  if Myself.Sex = 0 then //ÄÐµÄ
                     if MovingItem.Item.S.StdMode <> 10 then //³²ÀÚ¿Ê
                        exit;
                  if Myself.Sex = 1 then //Å®µÄ
                     if MovingItem.Item.S.StdMode <> 11 then //¿©ÀÚ¿Ê
                        exit;
                  flag := TRUE;
               end;
            end;
            U_WEAPON: begin
               if Sender = DSWWEAPON then begin
                  flag := TRUE;
               end;
            end;
            U_NECKLACE: begin
               if Sender = DSWNecklace then
                  flag := TRUE;
            end;
            U_RIGHTHAND: begin
               if Sender = DSWLight then
                  flag := TRUE;
            end;
            U_HELMET: begin
               if Sender = DSWHelmet then
                  flag := TRUE;
            end;
            U_RINGR, U_RINGL: begin
               if Sender = DSWRingL then begin
                  where := U_RINGL;
                  flag := TRUE;
               end;
               if Sender = DSWRingR then begin
                  where := U_RINGR;
                  flag := TRUE;
               end;
            end;
            U_ARMRINGR: begin  //ÆÈÂî
               if Sender = DSWArmRingL then begin
                  where := U_ARMRINGL;
                  flag := TRUE;
               end;
               if Sender = DSWArmRingR then begin
                  where := U_ARMRINGR;
                  flag := TRUE;
               end;
            end;
            U_ARMRINGL: begin  //25,  µ¶°¡·ç,ÆÈÂî
               if Sender = DSWArmRingL then begin
                  where := U_ARMRINGL;
                  flag := TRUE;
               end;
            end;
         end;
      end else begin
         n := -(MovingItem.Index+1);
         if n in [0..8] then begin
            ItemClickSound (MovingItem.Item.S);
            UseItems[n] := MovingItem.Item;
            MovingItem.Item.S.Name := '';
            ItemMoving := FALSE;
         end;
      end;
      if flag then begin
         ItemClickSound (MovingItem.Item.S);
         WaitingUseItem := MovingItem;
         WaitingUseItem.Index := where;

         FrmMain.SendTakeOnItem (where, MovingItem.Item.MakeIndex, MovingItem.Item.S.Name);
         MovingItem.Item.S.Name := '';
         ItemMoving := FALSE;
      end;
   end else begin
      flag := FALSE;
      if (MovingItem.Item.S.Name <> '') or (WaitingUseItem.Item.S.Name <> '') then exit;
      sel := -1;
      if Sender = DSWDress then sel := U_DRESS;
      if Sender = DSWWeapon then sel := U_WEAPON;
      if Sender = DSWHelmet then sel := U_HELMET;
      if Sender = DSWNecklace then sel := U_NECKLACE;
      if Sender = DSWLight then sel := U_RIGHTHAND;
      if Sender = DSWRingL then sel := U_RINGL;
      if Sender = DSWRingR then sel := U_RINGR;
      if Sender = DSWArmRingL then sel := U_ARMRINGL;
      if Sender = DSWArmRingR then sel := U_ARMRINGR;

      if sel >= 0 then begin
         if UseItems[sel].S.Name <> '' then begin
            ItemClickSound (UseItems[sel].S);
            MovingItem.Index := -(sel+1);
            MovingItem.Item := UseItems[sel];
            UseItems[sel].S.Name := '';
            ItemMoving := TRUE;
         end;
      end;
   end;
end;

procedure TFrmDlg.DSWWeaponMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
   sel: integer;
   iname, d1, d2, d3: string;
   useable: Boolean;
   hcolor: TColor;
begin
   if StatePage <> 0 then exit;
   //DScreen.ClearHint;
   sel := -1;
   if Sender = DSWDress then sel := U_DRESS;
   if Sender = DSWWeapon then sel := U_WEAPON;
   if Sender = DSWHelmet then sel := U_HELMET;
   if Sender = DSWNecklace then sel := U_NECKLACE;
   if Sender = DSWLight then sel := U_RIGHTHAND;
   if Sender = DSWRingL then sel := U_RINGL;
   if Sender = DSWRingR then sel := U_RINGR;
   if Sender = DSWArmRingL then sel := U_ARMRINGL;
   if Sender = DSWArmRingR then sel := U_ARMRINGR;
   if sel >= 0 then begin
      MouseStateItem := UseItems[sel];
   end;
end;

procedure TFrmDlg.DStateWinMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   MouseStateItem.S.Name := '';
end;


//»óÅÂÃ¢ : ¸¶¹ý ÆäÀÌÁö

procedure TFrmDlg.DStMag1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   idx, icon: integer;
   d: TDirectDrawSurface;
   pm: PTClientMagic;
begin
   with Sender as TDButton do begin
      idx := _Max(Tag + MagicPage * 5, 0);
      if idx < MagicList.Count then begin
         pm := PTClientMagic (MagicList[idx]);
         icon := pm.Def.Effect * 2;
         if icon >= 0 then begin //¾ÆÀÌÄÜÀÌ ¾ø´Â°Å..
            if not Downed then begin
               d := FrmMain.WMagIcon.Images[icon];
               if d <> nil then
                  dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
            end else begin
               d := FrmMain.WMagIcon.Images[icon+1];
               if d <> nil then
                  dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
            end;
         end;
      end;
   end;
end;

procedure TFrmDlg.DStMag1Click(Sender: TObject; X, Y: Integer);
var
   i, idx: integer;
   selkey: word;
   keych: char;
   pm: PTClientMagic;
begin
   if StatePage = 3 then begin
      idx := TDButton(Sender).Tag + magtop;
      if (idx >= 0) and (idx < MagicList.Count) then begin

         pm := PTClientMagic (MagicList[idx]);
         selkey := word(pm.Key);
         SetMagicKeyDlg (pm.Def.Effect * 2, pm.Def.MagicName, selkey);
         keych := char(selkey);

         for i:=0 to MagicList.Count-1 do begin
            pm := PTClientMagic (MagicList[i]);
            if pm.Key = keych then begin
               pm.Key := #0;
               FrmMain.SendMagicKeyChange (pm.Def.MagicId, #0);
            end;
         end;
         pm := PTClientMagic (MagicList[idx]);
         //if pm.Def.EffectType <> 0 then begin //°Ë¹ýÀº Å°¼³Á¤À» ¸øÇÔ.
         pm.Key := keych;
         FrmMain.SendMagicKeyChange (pm.Def.MagicId, keych);
         //end;
      end;
   end;
end;

procedure TFrmDlg.DStPageUpClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DStPageUp then begin
      if MagicPage > 0 then
         Dec (MagicPage);
   end else begin
      if MagicPage < (MagicList.Count+4) div 5 - 1 then
         Inc (MagicPage);
   end;
end;

{------------------------------------------------------------------------}

//µ×²¿×´Ì¬

{------------------------------------------------------------------------}


procedure TFrmDlg.DBottomDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   rc: TRect;
   btop, sx, sy, i, fcolor, bcolor: integer;
   r: Real;
   str: string;
begin
   d := FrmMain.WProgUse.Images[BOTTOMBOARD];
   if d <> nil then
      dsurface.Draw (DBottom.Left, DBottom.Top, d.ClientRect, d, TRUE);
   btop := 0;
   if d <> nil then begin
      with d.ClientRect do
         rc := Rect (Left, Top, Right, Top+120);
      btop := SCREENHEIGHT - d.height;
      //ÉÏ°ë²¿Í¸Ã÷
      dsurface.Draw (0,
                     btop,
                     rc,
                     d, TRUE);
      //ÏÂ°ë²¿²»Í¸Ã÷
      with d.ClientRect do
         rc := Rect (Left, Top+120, Right, Bottom);
      dsurface.Draw (0,
                     btop + 120,
                     rc,
                     d, FALSE);
   end;
   //Ê±¼äÖÜÆÚÏÔÊ¾
   d := nil;
   case DayBright of
      0: d := FrmMain.WProgUse.Images[15];  //°ëÒ¹
      1: d := FrmMain.WProgUse.Images[12];  //°×Ìì
      2: d := FrmMain.WProgUse.Images[13];  //ÖÐÎç
      3: d := FrmMain.WProgUse.Images[14];  //ÉîÒ¹
   end;
   if d <> nil then
      dsurface.Draw (748, 79+DBottom.Top, d.ClientRect, d, FALSE);

   if Myself <> nil then begin
      //Íæ¼Ò×´Ì¬ÐÅÏ¢
      if (Myself.Abil.MaxHP > 0) and (Myself.Abil.MaxMP > 0) then begin
         if (Myself.Job = 0) and (Myself.Abil.Level < 28) then begin //Õ½Ê¿
            d := FrmMain.WProgUse.Images[5];
            if d <> nil then begin
               rc := d.ClientRect;
               rc.Right := d.ClientRect.Right - 2;
               dsurface.Draw (38, btop+90, rc, d, FALSE);
            end;
            d := FrmMain.WProgUse.Images[6];
            if d <> nil then begin
               rc := d.ClientRect;
               rc.Right := d.ClientRect.Right - 2;
               rc.Top := Round(rc.Bottom / Myself.Abil.MaxHP * (Myself.Abil.MaxHP - Myself.Abil.HP));
               dsurface.Draw (38, btop+90+rc.Top, rc, d, FALSE);
            end;
         end else begin
            d := FrmMain.WProgUse.Images[4];
            if d <> nil then begin
               //Ã¼·Â Ç¥½Ã -¼úµµ»ç
               rc := d.ClientRect;
               rc.Right := d.ClientRect.Right div 2 - 1;
               rc.Top := Round(rc.Bottom / Myself.Abil.MaxHP * (Myself.Abil.MaxHP - Myself.Abil.HP));
               dsurface.Draw (40, btop+91+rc.Top, rc, d, FALSE);
               //¸¶·Â Ç¥½Ã -¼úµµ»ç
               rc := d.ClientRect;
               rc.Left := d.ClientRect.Right div 2 + 1;
               rc.Right := d.ClientRect.Right - 1;
               rc.Top := Round(rc.Bottom / Myself.Abil.MaxMP * (Myself.Abil.MaxMP - Myself.Abil.MP));
               dsurface.Draw (40 + rc.Left, btop+91+rc.Top, rc, d, FALSE);
            end;
         end;
      end;

      //¼¶±ð
      with dsurface.Canvas do begin
         PomiTextOut (dsurface, 660, 496, IntToStr(Myself.Abil.Level));
      end;
      //
      if (Myself.Abil.MaxExp > 0) and (Myself.Abil.MaxWeight > 0) then begin
         d := FrmMain.WProgUse.Images[7];
         if d <> nil then begin
            //°æÇèÄ¡
            rc := d.ClientRect;
            if Myself.Abil.Exp > 0 then r := Myself.Abil.MaxExp / Myself.Abil.Exp
            else r := 0;
            if r > 0 then rc.Right := Round (rc.Right / r)
            else rc.Right := 0;
            dsurface.Draw (666, 527, rc, d, FALSE);
            //PomiTextOut (dsurface, 660, 528, IntToStr(Myself.Abil.Exp));
            //¹«°Ô
            rc := d.ClientRect;
            if Myself.Abil.Weight > 0 then r := Myself.Abil.MaxWeight / Myself.Abil.Weight
            else r := 0;
            if r > 0 then rc.Right := Round (rc.Right / r)
            else rc.Right := 0;
            dsurface.Draw (666, 560, rc, d, FALSE);
            //PomiTextOut (dsurface, 660, 561, IntToStr(Myself.Abil.Weight));
         end;
      end;
      //¹è°íÇ° Ç¥½Ã
      if MyHungryState in [1..4] then begin
         d := FrmMain.WProgUse.Images[16 + MyHungryState-1];
         if d <> nil then begin
            dsurface.Draw (754, 553, d.ClientRect, d, TRUE);
         end;
      end;

   end;
   //¶Ô»°
   sx := 208;
   sy := SCREENHEIGHT - 130;
   with DScreen do begin
      SetBkMode (dsurface.Canvas.Handle, OPAQUE);
      for i := ChatBoardTop to ChatBoardTop + VIEWCHATLINE-1 do begin
         if i > ChatStrs.Count-1 then break;
         fcolor := integer(ChatStrs.Objects[i]);
         bcolor := integer(ChatBks[i]);
         dsurface.Canvas.Font.Color := fcolor;
         dsurface.Canvas.Brush.Color := bcolor;
         dsurface.Canvas.TextOut (sx, sy+(i-ChatBoardTop)*12, ChatStrs.Strings[i]);
      end;
   end;
   dsurface.Canvas.Release;
end;

{--------------------------------------------------------------}
//ÅÐ¶Ïµ×²¿Ãæ°åÉÏµÄÒ»µãÊÇ·ñÍ¸Ã÷
procedure TFrmDlg.DBottomInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
var
   d: TDirectDrawSurface;
begin
   d := FrmMain.WProgUse.Images[BOTTOMBOARD];
   if d <> nil then begin
      if d.Pixels[X, Y] > 0 then IsRealArea := TRUE
      else IsRealArea := FALSE;
   end;
end;

procedure TFrmDlg.DMyStateDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDButton;
   dd: TDirectDrawSurface;
begin
   if Sender is TDButton then begin
      d := TDButton(Sender);
      if d.Downed then begin
         dd := d.WLib.Images[d.FaceIndex];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end;
   end;
end;

//±×·ì, ±³È¯, ¸Ê ¹öÆ°
procedure TFrmDlg.DBotGroupDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDButton;
   dd: TDirectDrawSurface;
begin
   if Sender is TDButton then begin
      d := TDButton(Sender);
      if not d.Downed then begin
         dd := d.WLib.Images[d.FaceIndex];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end else begin
         dd := d.WLib.Images[d.FaceIndex+1];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DBotPlusAbilDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDButton;
   dd: TDirectDrawSurface;
begin
   if Sender is TDButton then begin
      d := TDButton(Sender);
      if not d.Downed then begin
         if (BlinkCount mod 2 = 0) and (not DAdjustAbility.Visible) then dd := d.WLib.Images[d.FaceIndex]
         else dd := d.WLib.Images[d.FaceIndex + 2];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end else begin
         dd := d.WLib.Images[d.FaceIndex+1];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end;

      if GetTickCount - BlinkTime >= 500 then begin
         BlinkTime := GetTickCount;
         Inc (BlinkCount);
         if BlinkCount >= 10 then BlinkCount := 0;
      end;
   end;
end;



procedure TFrmDlg.DMyStateClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DMyState then begin
      StatePage := 0;
      OpenMyStatus;
   end;
   if Sender = DMyBag then OpenItemBag;
   if Sender = DMyMagic then begin
      StatePage := 3;
      OpenMyStatus;
   end;
   if Sender = DOption then ;
end;

procedure TFrmDlg.DOptionClick(Sender: TObject);
begin
end;





{------------------------------------------------------------------------}

// º§Æ®

{------------------------------------------------------------------------}


procedure TFrmDlg.DBelt1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      idx := Tag;
      if idx in [0..5] then begin
         if ItemArr[idx].S.Name <> '' then begin
            d := FrmMain.WBagItem.Images[ItemArr[idx].S.Looks];
            if d <> nil then
               dsurface.Draw (SurfaceX(Left+(Width-d.Width) div 2), SurfaceY(Top+(Height-d.Height) div 2), d.ClientRect, d, TRUE);
         end;
      end;
      PomiTextOut (dsurface, SurfaceX(Left+13), SurfaceY(Top+19), IntToStr(idx+1));
   end;
end;

procedure TFrmDlg.DBelt1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
   idx: integer;  
begin
   idx := TDButton(Sender).Tag;
   if idx in [0..5] then begin
      if ItemArr[idx].S.Name <> '' then begin
         MouseItem := ItemArr[idx];
      end;
   end;
end;

procedure TFrmDlg.DBelt1Click(Sender: TObject; X, Y: Integer);
var
   idx: integer;
   temp: TClientItem;
begin
   idx := TDButton(Sender).Tag;
   if idx in [0..5] then begin
      if not ItemMoving then begin
         if ItemArr[idx].S.Name <> '' then begin
            ItemClickSound (ItemArr[idx].S);
            ItemMoving := TRUE;
            MovingItem.Index := idx;
            MovingItem.Item := ItemArr[idx];
            ItemArr[idx].S.Name := '';
         end;
      end else begin
         if (MovingItem.Index = -97) or (MovingItem.Index = -98) then exit;
         if MovingItem.Item.S.StdMode <= 3 then begin //Æ÷¼Ç,À½½Ä,½ºÅ©·Ñ
            if ItemArr[idx].S.Name <> '' then begin
               temp := ItemArr[idx];
               ItemArr[idx] := MovingItem.Item;
               MovingItem.Index := idx;
               MovingItem.Item := temp
            end else begin
               ItemArr[idx] := MovingItem.Item;
               MovingItem.Item.S.name := '';
               ItemMoving := FALSE;
            end;
         end;
      end;
   end;
end;

procedure TFrmDlg.DBelt1DblClick(Sender: TObject);
var
   idx: integer;
begin
   idx := TDButton(Sender).Tag;
   if idx in [0..5] then begin
      if ItemArr[idx].S.Name <> '' then begin
         if (ItemArr[idx].S.StdMode <= 4) or (ItemArr[idx].S.StdMode = 31) then begin //»ç¿ëÇÒ ¼ö ÀÖ´Â ¾ÆÀÌÅÛ
            FrmMain.EatItem (idx);
         end;
      end else begin
         if ItemMoving and (MovingItem.Index = idx) and
           (MovingItem.Item.S.StdMode <= 4) or (MovingItem.Item.S.StdMode = 31)
         then begin
            FrmMain.EatItem (-1);
         end;
      end;
   end;
end;

{----------------------------------------------------------}

//¾ÆÀÌÅÛ °¡¹æ

{----------------------------------------------------------}

procedure TFrmDlg.GetMouseItemInfo (var iname, line1, line2, line3: string; var useable: boolean);
   function GetDuraStr (dura, maxdura: integer): string;
   begin
      if not BoNoDisplayMaxDura then
         Result := IntToStr(Round(dura/1000)) + '/' + IntToStr(Round(maxdura/1000))
      else
         Result := IntToStr(Round(dura/1000));
   end;
   function GetDura100Str (dura, maxdura: integer): string;
   begin
      if not BoNoDisplayMaxDura then
         Result := IntToStr(Round(dura/100)) + '/' + IntToStr(Round(maxdura/100))
      else
         Result := IntToStr(Round(dura/100));
   end;
begin
   if Myself = nil then exit;
   iname := ''; line1 := ''; line2 := ''; line3 := '';
   useable := TRUE;

   if MouseItem.S.Name <> '' then begin
      iname := MouseItem.S.Name + ' ';
      case MouseItem.S.StdMode of
         0: begin //Ò©Æ·
               if MouseItem.S.AC > 0 then
                  line1 := '+' + IntToStr(MouseItem.S.AC) + 'HP ';
               if MouseItem.S.MAC > 0 then
                  line1 := line1 + '+' + IntToStr(MouseItem.S.MAC) + 'MP';
               line1 := line1 + ' ÖØÁ¿' + IntToStr(MouseItem.S.Weight);
            end;
         1..3:
            begin
               line1 := line1 + 'ÖØÁ¿ ' +  IntToStr(MouseItem.S.Weight);
            end;
         4:
            begin
               line1 := line1 + 'ÖØÁ¿ ' +  IntToStr(MouseItem.S.Weight);
               useable := FALSE;
               case MouseItem.S.Shape of
                  0: begin
                        line2 := 'Àü»ç¹«°øºñ±Þ';
                        line3 := 'ÇÊ¿ä·¹º§ ' + IntToStr(MouseItem.S.DuraMax);
                        if (Myself.Job = 0) and (Myself.Abil.Level >= MouseItem.S.DuraMax) then
                           useable := TRUE;
                     end;
                  1: begin
                        line2 := 'ÁÖ¼ú»ç¸¶¹ýÃ¥';
                        line3 := 'ÇÊ¿ä·¹º§ ' + IntToStr(MouseItem.S.DuraMax);
                        if (Myself.Job = 1) and (Myself.Abil.Level >= MouseItem.S.DuraMax) then
                           useable := TRUE;
                     end;
                  2: begin
                        line2 := 'µµ»ç¹«°øºñ±Þ';
                        line3 := 'ÇÊ¿ä·¹º§ ' + IntToStr(MouseItem.S.DuraMax);
                        if (Myself.Job = 2) and (Myself.Abil.Level >= MouseItem.S.DuraMax) then
                           useable := TRUE;
                     end;
               end;
            end;
         5..6: //¹«±â
            begin
               useable := FALSE;
               if MouseItem.S.NeedIdentify and $01 <> 0 then  //ÐèÒª¼ø±ð
                  iname := '(*)' + iname;

               line1 := line1 + 'ÖØÁ¿' + IntToStr(MouseItem.S.Weight) +
                        ' ÀÎ¹Ì¶È'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
               if MouseItem.S.DC > 0 then
                  line2 := 'ÆÄ±«' + IntToStr(Lobyte(MouseItem.S.DC)) + '-' + IntToStr(Hibyte(MouseItem.S.DC)) + ' ';
               if MouseItem.S.MC > 0 then
                  line2 := line2 + '¸¶¹ý' + IntToStr(Lobyte(MouseItem.S.MC)) + '-' + IntToStr(Hibyte(MouseItem.S.MC)) + ' ';
               if MouseItem.S.SC > 0 then
                  line2 := line2 + 'µµ·Â' + IntToStr(Lobyte(MouseItem.S.SC)) + '-' + IntToStr(Hibyte(MouseItem.S.SC)) + ' ';
               if MouseItem.S.Source > 0 then  //¹«±âÀÇ °­µµ
                  line2 := line2 + '°­µµ+' + IntToStr(MouseItem.S.Source) + ' ';
               if Hibyte(MouseItem.S.AC) > 0 then
                  line3 := line3 + 'Á¤È®+' + IntToStr(Hibyte(MouseItem.S.AC)) + ' ';
               if Hibyte(MouseItem.S.MAC) > 0 then begin
                  if Hibyte(MouseItem.S.MAC) > 10 then
                     line3 := line3 + '°ø°Ý¼Óµµ+' + IntToStr(Hibyte(MouseItem.S.MAC)-10) + ' '
                  else
                     line3 := line3 + '°ø°Ý¼Óµµ-' + IntToStr(Hibyte(MouseItem.S.MAC)) + ' ';
               end;
               if Lobyte(MouseItem.S.AC) > 0 then
                  line3 := line3 + 'Çà¿î+' + IntToStr(Lobyte(MouseItem.S.AC)) + ' ';
               if Lobyte(MouseItem.S.MAC) > 0 then
                  line3 := line3 + 'ÀúÁÖ+' + IntToStr(Lobyte(MouseItem.S.MAC)) + ' ';
               case MouseItem.S.Need of
                  0: begin
                        if Myself.Abil.Level >= MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'ÐèÒªµÈ¼¶' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  1: begin
                        if hibyte (Myself.Abil.DC) >= MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'ÇÊ¿äÆÄ±«·Â' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  2: begin
                        if hibyte (Myself.Abil.MC) >= MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'ÇÊ¿ä¸¶¹ý·Â' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  3: begin
                        if hibyte (Myself.Abil.SC) >= MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'ÇÊ¿äµµ·Â' + IntToStr(MouseItem.S.NeedLevel);
                     end;
               end;
            end;
         10, 11:  //³²ÀÚ¿Ê, ¿©ÀÚ¿Ê
            begin
               useable := FALSE;
               line1 := line1 + '¹«°Ô' + IntToStr(MouseItem.S.Weight) +
                        ' ³»±¸'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
               //line1 := line1 + '¹«°Ô' + IntToStr(MouseItem.S.Weight) +
               //      ' ³»±¸'+ IntToStr(Round(MouseItem.Dura/1000)) + '/' + IntToStr(Round(MouseItem.DuraMax/1000));
               if MouseItem.S.AC > 0 then
                  line2 := '¹æ¾î' + IntToStr(Lobyte(MouseItem.S.AC)) + '-' + IntToStr(Hibyte(MouseItem.S.AC)) + ' ';
               if MouseItem.S.MAC > 0 then
                  line2 := line2 + '¸¶Ç×' + IntToStr(Lobyte(MouseItem.S.MAC)) + '-' + IntToStr(Hibyte(MouseItem.S.MAC)) + ' ';
               if MouseItem.S.DC > 0 then
                  line2 := line2 + 'ÆÄ±«' + IntToStr(Lobyte(MouseItem.S.DC)) + '-' + IntToStr(Hibyte(MouseItem.S.DC)) + ' ';
               if MouseItem.S.MC > 0 then
                  line2 := line2 + '¸¶¹ý' + IntToStr(Lobyte(MouseItem.S.MC)) + '-' + IntToStr(Hibyte(MouseItem.S.MC)) + ' ';
               if MouseItem.S.SC > 0 then
                  line2 := line2 + 'µµ·Â' + IntToStr(Lobyte(MouseItem.S.SC)) + '-' + IntToStr(Hibyte(MouseItem.S.SC));
               case MouseItem.S.Need of
                  0: begin
                        if Myself.Abil.Level >= MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := 'ÇÊ¿ä·¹º§' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  1: begin
                        if hibyte (Myself.Abil.DC) >= MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := 'ÇÊ¿äÆÄ±«·Â' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  2: begin
                        if hibyte (Myself.Abil.MC) >= MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := 'ÇÊ¿ä¸¶¹ý·Â' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  3: begin
                        if hibyte (Myself.Abil.SC) >= MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := 'ÇÊ¿äµµ·Â' + IntToStr(MouseItem.S.NeedLevel);
                     end;
               end;
            end;
         15,     //¸ðÀÚ,Åõ±¸
         19,20,21,  //¸ñ°ÉÀÌ
         22,23,  //¹ÝÁö
         24,26:  //ÆÈÂî
            begin
               useable := FALSE;
               line1 := line1 + '¹«°Ô' + IntToStr(MouseItem.S.Weight) +
                        ' ³»±¸'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);

               case MouseItem.S.StdMode of
                  19: //¸ñ°ÉÀÌ
                     begin
                        if MouseItem.S.AC > 0 then
                           line2 := line2 + '¸¶¹ýÈ¸ÇÇ+' + IntToStr(Hibyte(MouseItem.S.AC)) + '0% ';
                        if Lobyte(MouseItem.S.MAC) > 0 then line2 := line2 + 'ÀúÁÖ+' + IntToStr(Lobyte(MouseItem.S.MAC)) + ' ';
                        if Hibyte(MouseItem.S.MAC) > 0 then line2 := line2 + 'Çà¿î+' + IntToStr(Hibyte(MouseItem.S.MAC)) + ' ';
                           //¼ýÀÚ Ç¥½Ã¾ÈµÊ + IntToStr(Hibyte(MouseItem.S.MAC)) + ' ';
                     end;
                  20, 24: //¸ñ°ÉÀÌ ÆÈÂî: MaxAC -> Hit,  MaxMac -> Speed
                     begin
                        if MouseItem.S.AC > 0 then
                           line2 := line2 + 'Á¤È®+' + IntToStr(Hibyte(MouseItem.S.AC)) + ' ';
                        if MouseItem.S.MAC > 0 then
                           line2 := line2 + '¹ÎÃ¸+' + IntToStr(Hibyte(MouseItem.S.MAC)) + ' ';
                     end;
                  21:  //¸ñ°ÉÀÌ
                     begin
                        if Hibyte(MouseItem.S.AC) > 0 then
                           line2 := line2 + 'Ã¼·ÂÈ¸º¹+' + IntToStr(Hibyte(MouseItem.S.AC)) + '0% ';
                        if Hibyte(MouseItem.S.MAC) > 0 then
                           line2 := line2 + '¸¶·ÂÈ¸º¹+' + IntToStr(Hibyte(MouseItem.S.MAC)) + '0% ';
                        if Lobyte(MouseItem.S.AC) > 0 then
                           line2 := line2 + '°ø°Ý¼Óµµ+' + IntToStr(Lobyte(MouseItem.S.AC)) + ' ';
                        if Lobyte(MouseItem.S.MAC) > 0 then
                           line2 := line2 + '°ø°Ý¼Óµµ-' + IntToStr(Lobyte(MouseItem.S.MAC)) + ' ';
                     end;
                  23:  //¹ÝÁö
                     begin
                        if Hibyte(MouseItem.S.AC) > 0 then
                           line2 := line2 + 'Áßµ¶È¸ÇÇ+' + IntToStr(Hibyte(MouseItem.S.AC)) + '0% ';
                        if Hibyte(MouseItem.S.MAC) > 0 then
                           line2 := line2 + 'Áßµ¶È¸º¹+' + IntToStr(Hibyte(MouseItem.S.MAC)) + '0% ';
                        if Lobyte(MouseItem.S.AC) > 0 then
                           line2 := line2 + '°ø°Ý¼Óµµ+' + IntToStr(Lobyte(MouseItem.S.AC)) + ' ';
                        if Lobyte(MouseItem.S.MAC) > 0 then
                           line2 := line2 + '°ø°Ý¼Óµµ-' + IntToStr(Lobyte(MouseItem.S.MAC)) + ' ';
                     end;
                  else
                     begin
                        if MouseItem.S.AC > 0 then
                           line2 := line2 + '¹æ¾î' + IntToStr(Lobyte(MouseItem.S.AC)) + '-' + IntToStr(Hibyte(MouseItem.S.AC)) + ' ';
                        if MouseItem.S.MAC > 0 then
                           line2 := line2 + '¸¶Ç×' + IntToStr(Lobyte(MouseItem.S.MAC)) + '-' + IntToStr(Hibyte(MouseItem.S.MAC)) + ' ';
                     end;
               end;
               if MouseItem.S.DC > 0 then
                  line2 := line2 + 'ÆÄ±«' + IntToStr(Lobyte(MouseItem.S.DC)) + '-' + IntToStr(Hibyte(MouseItem.S.DC)) + ' ';
               if MouseItem.S.MC > 0 then
                  line2 := line2 + '¸¶¹ý' + IntToStr(Lobyte(MouseItem.S.MC)) + '-' + IntToStr(Hibyte(MouseItem.S.MC)) + ' ';
               if MouseItem.S.SC > 0 then
                  line2 := line2 + 'µµ·Â' + IntToStr(Lobyte(MouseItem.S.SC)) + '-' + IntToStr(Hibyte(MouseItem.S.SC));
               case MouseItem.S.Need of
                  0: begin
                        if Myself.Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                        line3 := line3 + 'ÇÊ¿ä·¹º§' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  1: begin
                        if hibyte (Myself.Abil.DC) >= MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'ÇÊ¿äÆÄ±«·Â' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  2: begin
                        if hibyte (Myself.Abil.MC) >= MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'ÇÊ¿ä¸¶¹ý·Â' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  3: begin
                        if hibyte (Myself.Abil.SC) >= MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'ÇÊ¿äµµ·Â' + IntToStr(MouseItem.S.NeedLevel);
                     end;
               end;
            end;
         25: //»Ñ¸®´Â µ¶°¡·ç
            begin
               line1 := line1 + '¹«°Ô' +  IntToStr(MouseItem.S.Weight);
               line2 := '»ç¿ë'+ GetDura100Str(MouseItem.Dura, MouseItem.DuraMax);
            end;
         30: //ÃÊ,È½ºÒ
            begin
               line1 := line1 + '¹«°Ô' +  IntToStr(MouseItem.S.Weight) + ' ³»±¸'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
            end;
         40: //°í±âµ¢¾î¸®
            begin
               line1 := line1 + '¹«°Ô' +  IntToStr(MouseItem.S.Weight) + ' Ç°Áú'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
            end;
         42: //¾à Àç·á
            begin
               line1 := line1 + '¹«°Ô' +  IntToStr(MouseItem.S.Weight) + ' ¾àÀç';
            end;
         43: //±¤¼®
            begin
               line1 := line1 + '¹«°Ô' +  IntToStr(MouseItem.S.Weight) + ' ¼øµµ'+ IntToStr(Round(MouseItem.Dura/1000));
            end;
         else begin
               line1 := line1 + '¹«°Ô' +  IntToStr(MouseItem.S.Weight);
            end;
      end;
   end;
end;


procedure TFrmDlg.DItemBagDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d0, d1, d2, d3: string;
   n: integer;
   useable: Boolean;
   d: TDirectDrawSurface;
begin
   if Myself = nil then exit;
   with DItemBag do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      GetMouseItemInfo (d0, d1, d2, d3, useable);
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         TextOut (SurfaceX(Left+64), SurfaceY(Top+185), GetGoldStr(Myself.Gold));
         if d0 <> '' then begin
            n := TextWidth (d0);
            Font.Color := clYellow;
            TextOut (SurfaceX(Left+70), SurfaceY(Top+215), d0);
            Font.Color := clWhite;
            TextOut (SurfaceX(Left+70) + n, SurfaceY(Top+215), d1);
            TextOut (SurfaceX(Left+70), SurfaceY(Top+215+14), d2);
            if not useable then
               Font.Color := clRed;
            TextOut (SurfaceX(Left+70), SurfaceY(Top+215+14*2), d3);
         end;
         Release;
      end;
   end;
end;

procedure TFrmDlg.DRepairItemInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
begin
   if (X >= 0) and (Y >= 0) and (X <= DRepairItem.Width) and
      (Y <= DRepairItem.Height) then
         IsRealArea := TRUE
   else IsRealArea := FALSE;
end;

procedure TFrmDlg.DRepairItemDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with DRepairItem do begin
      d := WLib.Images[FaceIndex];
      if DRepairItem.Downed and (d <> nil) then
         dsurface.Draw (SurfaceX(254), SurfaceY(183), d.ClientRect, d, TRUE);
   end;
end;

procedure TFrmDlg.DCloseBagDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with DCloseBag do begin
      if DCloseBag.Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DCloseBagClick(Sender: TObject; X, Y: Integer);
begin
   DItemBag.Visible := FALSE;
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
   if ssRight in Shift then begin
      if ItemMoving then
         DItemGridGridSelect (self, ACol, ARow, Shift);
   end else begin
      idx := ACol + ARow * DItemGrid.ColCount + 6{º§Æ®°ø°£};
      if idx in [6..MAXBAGITEM-1] then begin
         MouseItem := ItemArr[idx];
      end;
   end;
end;

procedure TFrmDlg.DItemGridGridSelect(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
   idx, mi: integer;
   temp: TClientItem;
begin
   idx := ACol + ARow * DItemGrid.ColCount + 6{º§Æ®°ø°£};
   if idx in [6..MAXBAGITEM-1] then begin
      if not ItemMoving then begin
         if ItemArr[idx].S.Name <> '' then begin
            ItemMoving := TRUE;
            MovingItem.Index := idx;
            MovingItem.Item := ItemArr[idx];
            ItemArr[idx].S.Name := '';
            ItemClickSound (ItemArr[idx].S);
         end;
      end else begin
         //ItemClickSound (MovingItem.Item.S.StdMode);
         mi := MovingItem.Index;
         if (mi = -97) or (mi = -98) then exit; //µ·...
         if (mi < 0) and (mi >= -9) then begin  //-99: SellÃ¢¿¡¼­ °¡¹æÀ¸·Î
            //»óÅÂÃ¢¿¡¼­ °¡¹æÀ¸·Î
            WaitingUseItem := MovingItem;
            FrmMain.SendTakeOffItem (-(MovingItem.Index+1), MovingItem.Item.MakeIndex, MovingItem.Item.S.Name);
            MovingItem.Item.S.name := '';
            ItemMoving := FALSE;
         end else begin
            if (mi <= -20) and (mi > -30) then
               DealItemReturnBag (MovingItem.Item);
            if ItemArr[idx].S.Name <> '' then begin
               temp := ItemArr[idx];
               ItemArr[idx] := MovingItem.Item;
               MovingItem.Index := idx;
               MovingItem.Item := temp
            end else begin
               ItemArr[idx] := MovingItem.Item;
               MovingItem.Item.S.name := '';
               ItemMoving := FALSE;
            end;
         end;
      end;
   end;
   ArrangeItemBag;
end;

procedure TFrmDlg.DItemGridDblClick(Sender: TObject);
var
   idx, i: integer;
   keyvalue: TKeyBoardState;
   cu: TClientItem;
begin
   idx := DItemGrid.Col + DItemGrid.Row * DItemGrid.ColCount + 6;
   if idx in [6..MAXBAGITEM-1] then begin
      if ItemArr[idx].S.Name <> '' then begin
         FillChar(keyvalue, sizeof(TKeyboardState), #0);
         GetKeyboardState (keyvalue);
         if keyvalue[VK_CONTROL] = $80 then begin
            //º§Æ®Ã¢À¸·Î ¿Å±è
            cu := ItemArr[idx];
            ItemArr[idx].S.Name := '';
            AddItemBag (cu);
         end else
            if (ItemArr[idx].S.StdMode <= 4) or (ItemArr[idx].S.StdMode = 31) then begin //»ç¿ëÇÒ ¼ö ÀÖ´Â ¾ÆÀÌÅÛ
               FrmMain.EatItem (idx);
            end;
      end else begin
         if ItemMoving and (MovingItem.Item.S.Name <> '') then begin
            FillChar(keyvalue, sizeof(TKeyboardState), #0);
            GetKeyboardState (keyvalue);
            if keyvalue[VK_CONTROL] = $80 then begin
               //º§Æ®Ã¢À¸·Î ¿Å±è
               cu := MovingItem.Item;
               MovingItem.Item.S.Name := '';
               ItemMoving := FALSE;
               AddItemBag (cu);
            end else
               if (MovingItem.Index = idx) and
                  (MovingItem.Item.S.StdMode <= 4) or (ItemArr[idx].S.StdMode = 31)
               then begin
                  FrmMain.EatItem (-1);
               end;
         end;
      end;
   end;
end;

procedure TFrmDlg.DItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   idx := ACol + ARow * DItemGrid.ColCount + 6;
   if idx in [6..MAXBAGITEM-1] then begin
      if ItemArr[idx].S.Name <> '' then begin
         d := FrmMain.WBagItem.Images[ItemArr[idx].S.Looks];
         if d <> nil then
            with DItemGrid do
               dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DGoldClick(Sender: TObject; X, Y: Integer);
begin
   if Myself = nil then exit;
   if not ItemMoving then begin
      if Myself.Gold > 0 then begin
         PlaySound (s_money);
         ItemMoving := TRUE;
         MovingItem.Index := -98; //µ·
         MovingItem.Item.S.Name := '±ÝÀü';
      end;
   end else begin
      if (MovingItem.Index = -97) or (MovingItem.Index = -98) then begin //µ·¸¸..
         ItemMoving := FALSE;
         MovingItem.Item.S.Name := '';
         if MovingItem.Index = -97 then begin //±³È¯Ã¢¿¡¼­ ¿Å
            DealZeroGold;
         end;
      end;
   end;
   ;
end;


{------------------------------------------------------------------------}

//»óÀÎ ´ëÈ­ Ã¢

{------------------------------------------------------------------------}


procedure TFrmDlg.ShowMDlg (face: integer; mname, msgstr: string);
var
   i: integer;
begin
   DMerchantDlg.Left := 0;  //
   DMerchantDlg.Top := 0;
   MerchantFace := face;
   MerchantName := mname;
   MDlgStr := msgstr;
   DMerchantDlg.Visible := TRUE;
   DItemBag.Left := 475;  //°¡¹æÀ§Ä¡ º¯°æ
   DItemBag.Top := 0;
   for i:=0 to MDlgPoints.Count-1 do
      Dispose (PTClickPoint (MDlgPoints[i]));
   MDlgPoints.Clear;
   RequireAddPoints := TRUE;
   LastestClickTime := GetTickCount;
end;


procedure TFrmDlg.ResetMenuDlg;
var
   i: integer;
begin
   CloseDSellDlg;
   for i:=0 to MenuItemList.Count-1 do  //¼¼ºÎ ¸Þ´ºµµ Å¬¸®¾î ÇÔ.
      Dispose(PTClientItem(MenuItemList[i]));
   MenuItemList.Clear;

   for i:=0 to MenuList.Count-1 do
      Dispose (PTClientGoods(MenuList[i]));
   MenuList.Clear;

   //CurDetailItem := '';
   MenuIndex := -1;
   MenuTopLine := 0;
   BoDetailMenu := FALSE;
   BoStorageMenu := FALSE;
   BoMakeDrugMenu := FALSE;

   DSellDlg.Visible := FALSE;
   DMenuDlg.Visible := FALSE;
end;

procedure TFrmDlg.ShowShopMenuDlg;
begin
   MenuIndex := -1;

   DMerchantDlg.Left := 0;  //±âº» À§Ä¡
   DMerchantDlg.Top := 0;
   DMerchantDlg.Visible := TRUE;

   DSellDlg.Visible := FALSE;

   DMenuDlg.Left := 0;
   DMenuDlg.Top  := 176;
   DMenuDlg.Visible := TRUE;
   MenuTop := 0;

   DItemBag.Left := 475;
   DItemBag.Top := 0;
   DItemBag.Visible := TRUE;

   LastestClickTime := GetTickCount;
end;

procedure TFrmDlg.ShowShopSellDlg;
begin
   DSellDlg.Left := 260;
   DSellDlg.Top := 176;
   DSellDlg.Visible := TRUE;

   DMenuDlg.Visible := FALSE;

   DItemBag.Left := 475;
   DItemBag.Top := 0;
   DItemBag.Visible := TRUE;

   LastestClickTime := GetTickCount;
   SellPriceStr := '';
end;

procedure TFrmDlg.CloseMDlg;
var
   i: integer;
begin
   MDlgStr := '';
   DMerchantDlg.Visible := FALSE;
   for i:=0 to MDlgPoints.Count-1 do
      Dispose (PTClickPoint (MDlgPoints[i]));
   MDlgPoints.Clear;
   //¸Þ´ºÃ¢µµ ´ÝÀ½
   DItemBag.Left := 0;
   DItemBag.Top := 0;
   DMenuDlg.Visible := FALSE;
   CloseDSellDlg;
end;

procedure TFrmDlg.CloseDSellDlg;
begin
   DSellDlg.Visible := FALSE;
   if SellDlgItem.S.Name <> '' then
      AddItemBag (SellDlgItem);
   SellDlgItem.S.Name := '';
end;


//»óÀÎ ´ëÈ­Ã¢

procedure TFrmDlg.DMerchantDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   str, data, fdata, cmdstr, cmdmsg, cmdparam: string;
   lx, ly, sx: integer;
   drawcenter: Boolean;
   pcp: PTClickPoint;
begin
   with Sender as TDWindow do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      lx := 30;
      ly := 20;
      str := MDlgStr;
      drawcenter := FALSE;
      while TRUE do begin
         if str = '' then break;
         str := GetValidStr3 (str, data, ['\']);
         if data <> '' then begin
            sx := 0;
            fdata := '';
            while (pos('<', data) > 0) and (pos('>', data) > 0) and (data <> '') do begin
               if data[1] <> '<' then begin
                  data := '<' + GetValidStr3 (data, fdata, ['<']);
               end;
               data := ArrestStringEx (data, '<', '>', cmdstr);

               //fdata + cmdstr + data
               if cmdstr <> '' then begin
                  if Uppercase(cmdstr) = 'C' then begin
                     drawcenter := TRUE;
                     continue;
                  end;
                  if UpperCase(cmdstr) = '/C' then begin
                     drawcenter := FALSE;
                     continue;
                  end;
                  cmdparam := GetValidStr3 (cmdstr, cmdstr, ['/']); //cmdparam : Å¬¸¯ µÇ¾úÀ» ¶§ ¾²ÀÓ
               end else begin
                  DMenuDlg.Visible := FALSE;
                  DSellDlg.Visible := FALSE;
               end;

               if fdata <> '' then begin
                  BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, fdata);
                  sx := sx + dsurface.Canvas.TextWidth(fdata);
               end;
               if cmdstr <> '' then begin
                  if RequireAddPoints then begin //ÇÑ¹ø¸¸...
                     new (pcp);
                     pcp.rc := Rect (lx+sx, ly, lx+sx + dsurface.Canvas.TextWidth(cmdstr), ly + 14);
                     pcp.RStr := cmdparam;
                     MDlgPoints.Add (pcp);
                  end;
                  dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style + [fsUnderline];
                  if SelectMenuStr = cmdparam then
                     BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clRed, clBlack, cmdstr)
                  else BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clYellow, clBlack, cmdstr);
                  sx := sx + dsurface.Canvas.TextWidth(cmdstr);
                  dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style - [fsUnderline];
               end;
            end;
            if data <> '' then
               BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, data);
         end;
         ly := ly + 16;
      end;
      dsurface.Canvas.Release;
      RequireAddPoints := FALSE;
   end;

end;

procedure TFrmDlg.DMerchantDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
   CloseMDlg;
end;

procedure TFrmDlg.DMenuDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  function SX(x: integer): integer;
  begin
      Result := DMenuDlg.SurfaceX (DMenuDlg.Left + x);
  end;
  function SY(y: integer): integer;
  begin
      Result := DMenuDlg.SurfaceY (DMenuDlg.Top + y);
  end;
var
   i, lh, k, m, menuline: integer;
   d: TDirectDrawSurface;
   pg: PTClientGoods;
   str: string;
begin
   with dsurface.Canvas do begin
      with DMenuDlg do begin
         d := DMenuDlg.WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      SetBkMode (Handle, TRANSPARENT);
      //title
      Font.Color := clWhite;
      if not BoStorageMenu then begin
         TextOut (SX(19),  SY(11), '»óÇ° ¸ñ·Ï');
         TextOut (SX(156), SY(11), '°¡°Ý');
         TextOut (SX(245), SY(11), '³»±¸');
         lh := LISTLINEHEIGHT;
         menuline := _MIN(MAXMENU, MenuList.Count-MenuTop);
         //»óÇ° ¸®½ºÆ®
         for i:=MenuTop to MenuTop+menuline-1 do begin
            m := i-MenuTop;
            if i = MenuIndex then begin
               Font.Color := clRed;
               TextOut (SX(12),  SY(32 + m*lh), char(7));
            end else Font.Color := clWhite;
            pg := PTClientGoods (MenuList[i]);
            TextOut (SX(19),  SY(32 + m*lh), pg.Name);
            if pg.SubMenu >= 1 then
               TextOut (SX(137), SY(32 + m*lh), #31);
            TextOut (SX(156), SY(32 + m*lh), IntToStr(pg.Price) + 'Àü');
            str := '';
            if pg.Grade = -1 then str := '-'
            else TextOut (SX(245), SY(32 + m*lh), IntToStr(pg.Grade));
            {else for k:=0 to pg.Grade-1 do
               str := str + '*';
            if Length(str) >= 4 then begin
               Font.Color := clYellow;
               TextOut (SX(245), SY(32 + m*lh), str);
            end else
               TextOut (SX(245), SY(32 + m*lh), str);}
         end;
      end else begin
         TextOut (SX(19),  SY(11), 'º¸°ü ¸ñ·Ï');
         TextOut (SX(156), SY(11), '³»±¸');
         TextOut (SX(245), SY(11), '');
         lh := LISTLINEHEIGHT;
         menuline := _MIN(MAXMENU, MenuList.Count-MenuTop);
         //»óÇ° ¸®½ºÆ®
         for i:=MenuTop to MenuTop+menuline-1 do begin
            m := i-MenuTop;
            if i = MenuIndex then begin
               Font.Color := clRed;
               TextOut (SX(12),  SY(32 + m*lh), char(7));
            end else Font.Color := clWhite;
            pg := PTClientGoods (MenuList[i]);
            TextOut (SX(19),  SY(32 + m*lh), pg.Name);
            if pg.SubMenu >= 1 then
               TextOut (SX(137), SY(32 + m*lh), #31);
            TextOut (SX(156), SY(32 + m*lh), IntToStr(pg.Stock) + '/' + IntToStr(pg.Grade));
         end;
      end;
      //TextOut (0, 0, IntToStr(MenuTopLine));

      Release;
   end;
end;

procedure TFrmDlg.DMenuDlgClick(Sender: TObject; X, Y: Integer);
var
   lx, ly, idx: integer;
   iname, d1, d2, d3: string;
   useable: Boolean;
begin
   DScreen.ClearHint;
   lx := DMenuDlg.LocalX (X) - DMenuDlg.Left;
   ly := DMenuDlg.LocalY (Y) - DMenuDlg.Top;
   if (lx >= 14) and (lx <= 279) and (ly >= 32) then begin
      idx := (ly-32) div LISTLINEHEIGHT + MenuTop;
      if idx < MenuList.Count then begin
         PlaySound (s_glass_button_click);
         MenuIndex := idx;
      end;
   end;

   if BoStorageMenu then begin
      if (MenuIndex >= 0) and (MenuIndex < SaveItemList.Count) then begin
         MouseItem := PTClientItem(SaveItemList[MenuIndex])^;
         GetMouseItemInfo (iname, d1, d2, d3, useable);
         if iname <> '' then begin
            lx := 240;
            ly := 32+(MenuIndex-MenuTop) * LISTLINEHEIGHT;
            with Sender as TDButton do
               DScreen.ShowHint (DMenuDlg.SurfaceX(Left + lx),
                                 DMenuDlg.SurfaceY(Top + ly),
                                 iname + d1 + '\' + d2 + '\' + d3, clYellow, FALSE);
         end;
         MouseItem.S.Name := '';
      end;
   end else begin
      if (MenuIndex >= 0) and (MenuIndex < MenuItemList.Count) and (PTClientGoods (MenuList[MenuIndex]).SubMenu = 0) then begin
         MouseItem := PTClientItem(MenuItemList[MenuIndex])^;
         BoNoDisplayMaxDura := TRUE;
         GetMouseItemInfo (iname, d1, d2, d3, useable);
         BoNoDisplayMaxDura := FALSE;
         if iname <> '' then begin
            lx := 240;
            ly := 32+(MenuIndex-MenuTop) * LISTLINEHEIGHT;
            with Sender as TDButton do
               DScreen.ShowHint (DMenuDlg.SurfaceX(Left + lx),
                                 DMenuDlg.SurfaceY(Top + ly),
                                 iname + d1 + '\' + d2 + '\' + d3, clYellow, FALSE);
         end;
         MouseItem.S.Name := '';
      end;
   end;
end;

procedure TFrmDlg.DMenuDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   with DMenuDlg do
      if (X < SurfaceX(Left+10)) or (X > SurfaceX(Left+Width-20)) or (Y < SurfaceY(Top+30)) or (Y > SurfaceY(Top+Height-50)) then begin
         DScreen.ClearHint;
      end;
end;

procedure TFrmDlg.DMenuBuyClick(Sender: TObject; X, Y: Integer);
var
   pg: PTClientGoods;
begin
   if GetTickCount < LastestClickTime then exit; //Å¬¸¯À» ÀÚÁÖ ¸øÇÏ°Ô Á¦ÇÑ
   if (MenuIndex >= 0) and (MenuIndex < MenuList.Count) then begin
      pg := PTClientGoods (MenuList[MenuIndex]);
      LastestClickTime := GetTickCount + 5000;
      if pg.SubMenu > 0 then begin
         FrmMain.SendGetDetailItem (CurMerchant, 0, pg.Name);
         MenuTopLine := 0;
         CurDetailItem := pg.Name;
      end else begin
         if BoStorageMenu then begin
            FrmMain.SendTakeBackStorageItem (CurMerchant, pg.Price{MakeIndex}, pg.Name);
            exit;
         end;
         if BoMakeDrugMenu then begin
            FrmMain.SendMakeDrugItem (CurMerchant, pg.Name);
            exit;
         end;
         FrmMain.SendBuyItem (CurMerchant, pg.Stock, pg.Name)
      end;
   end;
end;

procedure TFrmDlg.DMenuPrevClick(Sender: TObject; X, Y: Integer);
begin
   if not BoDetailMenu then begin
      if MenuTop > 0 then Dec (MenuTop, MAXMENU-1);
      if MenuTop < 0 then MenuTop := 0;
   end else begin
      if MenuTopLine > 0 then begin
         MenuTopLine := _MAX(0, MenuTopLine-10);
         FrmMain.SendGetDetailItem (CurMerchant, MenuTopLine, CurDetailItem);
      end;
   end;
end;

procedure TFrmDlg.DMenuNextClick(Sender: TObject; X, Y: Integer);
begin
   if not BoDetailMenu then begin
      if MenuTop + MAXMENU < MenuList.Count then Inc (MenuTop, MAXMENU-1);
   end else begin
      MenuTopLine := MenuTopLine + 10;
      FrmMain.SendGetDetailItem (CurMerchant, MenuTopLine, CurDetailItem);
   end;      
end;

procedure TFrmDlg.SoldOutGoods (itemserverindex: integer);
var
   i: integer;
   pg: PTClientGoods;
begin
   for i:=0 to MenuList.Count-1 do begin
      pg := PTClientGoods (MenuList[i]);
      if (pg.Grade >= 0) and (pg.Stock = itemserverindex) then begin
         Dispose (pg);
         MenuList.Delete (i);
         if i < MenuItemList.Count then MenuItemList.Delete (i);
         if MenuIndex > MenuList.Count-1 then MenuIndex := MenuList.Count-1;
         break;
      end;
   end;
end;

procedure TFrmDlg.DelStorageItem (itemserverindex: integer);
var
   i: integer;
   pg: PTClientGoods;
begin
   for i:=0 to MenuList.Count-1 do begin
      pg := PTClientGoods (MenuList[i]);
      if (pg.Price = itemserverindex) then begin //º¸°ü¸ñ·ÏÀÎ°æ¿î Price = ItemServerIndexÀÓ.
         Dispose (pg);
         MenuList.Delete (i);
         if i < SaveItemList.Count then SaveItemList.Delete (i);
         if MenuIndex > MenuList.Count-1 then MenuIndex := MenuList.Count-1;
         break;
      end;
   end;
end;

procedure TFrmDlg.DMenuCloseClick(Sender: TObject; X, Y: Integer);
begin
   DMenuDlg.Visible := FALSE;
end;

procedure TFrmDlg.DMerchantDlgClick(Sender: TObject; X, Y: Integer);
var
   i, L, T: integer;
   p: PTClickPoint;
begin
   if GetTickCount < LastestClickTime then exit; //Å¬¸¯À» ÀÚÁÖ ¸øÇÏ°Ô Á¦ÇÑ
   L := DMerchantDlg.Left;
   T := DMerchantDlg.Top;
   with DMerchantDlg do
      for i:=0 to MDlgPoints.Count-1 do begin
         p := PTClickPoint (MDlgPoints[i]);
         if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
            (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
            PlaySound (s_glass_button_click);
            FrmMain.SendMerchantDlgSelect (CurMerchant, p.RStr);
            LastestClickTime := GetTickCount + 5000; //5ÃÊÈÄ¿¡ »ç¿ë °¡´É
            break;
         end;
      end;
end;

procedure TFrmDlg.DMerchantDlgMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   i, L, T: integer;
   p: PTClickPoint;
begin
   if GetTickCount < LastestClickTime then exit; //Å¬¸¯À» ÀÚÁÖ ¸øÇÏ°Ô Á¦ÇÑ
   SelectMenuStr := '';
   L := DMerchantDlg.Left;
   T := DMerchantDlg.Top;
   with DMerchantDlg do
      for i:=0 to MDlgPoints.Count-1 do begin
         p := PTClickPoint (MDlgPoints[i]);
         if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
            (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
            SelectMenuStr := p.RStr;
            break;
         end;
      end;
end;

procedure TFrmDlg.DMerchantDlgMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   SelectMenuStr := '';
end;

procedure TFrmDlg.DSellDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   actionname: string;
begin
   with DSellDlg do begin
      d := DMenuDlg.WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         actionname := '';
         case SpotDlgMode of
            dmSell:   actionname := '³öÊÛ: ';
            dmRepair: actionname := 'ÐÞÀí: ';
            dmStorage: actionname := '   ´æ´¢';
         end;
         TextOut (SurfaceX(Left+8), SurfaceY(Top+6), actionname + SellPriceStr);
         Release;
      end;
   end;
end;

procedure TFrmDlg.DSellDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
   CloseDSellDlg;
end;

procedure TFrmDlg.DSellDlgSpotClick(Sender: TObject; X, Y: Integer);
var
   temp: TClientItem;
begin
   SellPriceStr := '';
   if not ItemMoving then begin
      if SellDlgItem.S.Name <> '' then begin
         ItemClickSound (SellDlgItem.S);
         ItemMoving := TRUE;
         MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
         MovingItem.Item := SellDlgItem;
         SellDlgItem.S.Name := '';
      end;
   end else begin
      if (MovingItem.Index = -97) or (MovingItem.Index = -98) then exit;
      if (MovingItem.Index >= 0) or (MovingItem.Index = -99) then begin //°¡¹æ,º§Æ®¿¡¼­ ¿Â°Í¸¸
         ItemClickSound (MovingItem.Item.S);
         if SellDlgItem.S.Name <> '' then begin //ÀÚ¸®¿¡ ÀÖÀ¸¸é
            temp := SellDlgItem;
            SellDlgItem := MovingItem.Item;
            MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
            MovingItem.Item := temp
         end else begin
            SellDlgItem := MovingItem.Item;
            MovingItem.Item.S.name := '';
            ItemMoving := FALSE;
         end;
         BoQueryPrice := TRUE;
         QueryPriceTime := GetTickCount;
      end;
   end;

end;

procedure TFrmDlg.DSellDlgSpotDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   if SellDlgItem.S.Name <> '' then begin
      d := FrmMain.WBagItem.Images[SellDlgItem.S.Looks];
      if d <> nil then
         with DSellDlgSpot do
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2),
                           SurfaceY(Top + (Height - d.Height) div 2),
                           d.ClientRect,
                           d, TRUE);
   end;
end;

procedure TFrmDlg.DSellDlgSpotMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   MouseItem := SellDlgItem;
end;

procedure TFrmDlg.DSellDlgOkClick(Sender: TObject; X, Y: Integer);
begin
   if (SellDlgItem.S.Name = '') and (SellDlgItemSellWait.S.Name = '') then exit;
   if GetTickCount < LastestClickTime then exit; //Å¬¸¯À» ÀÚÁÖ ¸øÇÏ°Ô Á¦ÇÑ
   case SpotDlgMode of
      dmSell: FrmMain.SendSellItem (CurMerchant, SellDlgItem.MakeIndex, SellDlgItem.S.Name);
      dmRepair: FrmMain.SendRepairItem (CurMerchant, SellDlgItem.MakeIndex, SellDlgItem.S.Name);
      dmStorage: FrmMain.SendStorageItem (CurMerchant, SellDlgItem.MakeIndex, SellDlgItem.S.Name);
   end;
   SellDlgItemSellWait := SellDlgItem;
   SellDlgItem.S.Name := '';
   LastestClickTime := GetTickCount + 5000;
   SellPriceStr := '';
end;





{------------------------------------------------------------------------}

//¸¶¹ý Å° ¼³Á¤ Ã¢ (´ÙÀÌ¾ó ·Î±×)

{------------------------------------------------------------------------}


procedure TFrmDlg.SetMagicKeyDlg (icon: integer; magname: string; var curkey: word);
begin
   MagKeyIcon := icon;
   MagKeyMagName := magname;
   MagKeyCurKey := curkey;


   DKeySelDlg.Left := (SCREENWIDTH - DKeySelDlg.Width) div 2;
   DKeySelDlg.Top  := (SCREENHEIGHT - DKeySelDlg.Height) div 2;
   HideAllControls;
   DKeySelDlg.ShowModal;

   while TRUE do begin
      if not DKeySelDlg.Visible then break;
      //FrmMain.DXTimerTimer (self, 0);
      FrmMain.ProcOnIdle;
      Application.ProcessMessages;
      if Application.Terminated then exit;
   end;

   RestoreHideControls;
   curkey := MagKeyCurKey;
end;

procedure TFrmDlg.DKeySelDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with DKeySelDlg do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      //¸¶¹ý ÀÌ¸§
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clSilver;
         TextOut (SurfaceX(Left + 95), SurfaceY(Top + 38), MagKeyMagName + 'ÀÇ Å°¼³Á¤');
         Release;
      end;
   end;
end;

procedure TFrmDlg.DKsIconDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with DksIcon do begin
      d := FrmMain.WMagIcon.Images[MagKeyIcon];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
   end;
end;

procedure TFrmDlg.DKsF1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   b: TDButton;
   d: TDirectDrawSurface;
begin
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
      else b := DKsNone;
   end;
   if b = Sender then begin
      with b do begin
         d := WLib.Images[FaceIndex+1];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
   with Sender as TDButton do begin
      if Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DKsOkClick(Sender: TObject; X, Y: Integer);
begin
   DKeySelDlg.Visible := FALSE;
end;

procedure TFrmDlg.DKsF1Click(Sender: TObject; X, Y: Integer);
begin
   if Sender = DKsF1 then MagKeyCurKey := integer('1');
   if Sender = DKsF2 then MagKeyCurKey := integer('2');
   if Sender = DKsF3 then MagKeyCurKey := integer('3');
   if Sender = DKsF4 then MagKeyCurKey := integer('4');
   if Sender = DKsF5 then MagKeyCurKey := integer('5');
   if Sender = DKsF6 then MagKeyCurKey := integer('6');
   if Sender = DKsF7 then MagKeyCurKey := integer('7');
   if Sender = DKsF8 then MagKeyCurKey := integer('8');
   if Sender = DKsNone then MagKeyCurKey := 0;
end;



{------------------------------------------------------------------------}

//±âº»Ã¢ÀÇ ¹Ì´Ï ¹öÆ°

{------------------------------------------------------------------------}


procedure TFrmDlg.DBotMiniMapClick(Sender: TObject; X, Y: Integer);
begin
   if not BoViewMiniMap then begin
      if GetTickCount > querymsgtime then begin
         querymsgtime := GetTickCount + 3000;
         FrmMain.SendWantMiniMap;
      end;
   end else
      BoViewMiniMap := FALSE;      
end;

procedure TFrmDlg.DBotTradeClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > querymsgtime then begin
      querymsgtime := GetTickCount + 3000;
      FrmMain.SendDealTry;
   end;
end;

procedure TFrmDlg.DBotGuildClick(Sender: TObject; X, Y: Integer);
begin
   if DGuildDlg.Visible then begin
      DGuildDlg.Visible := FALSE;
   end else
      if GetTickCount > querymsgtime then begin
         querymsgtime := GetTickCount + 3000;
         FrmMain.SendGuildDlg;
      end;
end;

procedure TFrmDlg.DBotGroupClick(Sender: TObject; X, Y: Integer);
begin
   ToggleShowGroupDlg;
end;


{------------------------------------------------------------------------}

//±×·ì ´ÙÀÌ¾ó·Î±×

{------------------------------------------------------------------------}

procedure TFrmDlg.ToggleShowGroupDlg;
begin
   DGroupDlg.Visible := not DGroupDlg.Visible;
end;

procedure TFrmDlg.DGroupDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   lx, ly, n: integer;
begin
   with DGroupDlg do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      if GroupMembers.Count > 0 then begin
         with dsurface.Canvas do begin
            SetBkMode (Handle, TRANSPARENT);
            Font.Color := clSilver;
            lx := SurfaceX(28) + Left;
            ly := SurfaceY(80) + Top;
            TextOut (lx, ly, GroupMembers[0]);
            for n:=1 to GroupMembers.Count-1 do begin
               lx := SurfaceX(28) + Left + ((n-1) mod 2) * 100;
               ly := SurfaceY(80 + 16) + Top + ((n-1) div 2) * 16;
               TextOut (lx, ly, GroupMembers[n]);
            end;
            Release;
         end;
      end;
   end;
end;

procedure TFrmDlg.DGrpDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
   DGroupDlg.Visible := FALSE;
end;

procedure TFrmDlg.DGrpAllowGroupDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;  
begin
   with Sender as TDButton do begin
      if Downed then begin
         d := WLib.Images[FaceIndex-1];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end else begin
         if AllowGroup then begin
            d := WLib.Images[FaceIndex];
            if d <> nil then
               dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
         end;
      end;
   end;
end;

procedure TFrmDlg.DGrpAllowGroupClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > changegroupmodetime then begin
      AllowGroup := not AllowGroup;
      changegroupmodetime := GetTickCount + 5000; //timeout 5ÃÊ
      FrmMain.SendGroupMode (AllowGroup);
   end;
end;

procedure TFrmDlg.DGrpCreateClick(Sender: TObject; X, Y: Integer);
var
   who: string;
begin
   if (GetTickCount > changegroupmodetime) and (GroupMembers.Count = 0) then begin
      DialogSize := 1;
      DMessageDlg ('ÇëÊäÈëÒª´´½¨µÄ¶ÓÎéÃû³Æ.', [mbOk, mbAbort]);
      who := Trim (DlgEditText);
      if who <> '' then begin
         changegroupmodetime := GetTickCount + 5000; //timeout 5ÃÊ
         FrmMain.SendCreateGroup (Trim (DlgEditText));
      end;
   end;
end;

procedure TFrmDlg.DGrpAddMemClick(Sender: TObject; X, Y: Integer);
var
   who: string;
begin
   if (GetTickCount > changegroupmodetime) and (GroupMembers.Count > 0) then begin
      DialogSize := 1;
      DMessageDlg ('ÇëÊäÈëÒªÌí¼Óµ½¶ÓÎéÖÐµÄ³ÉÔ±Ãû×Ö.', [mbOk, mbAbort]);
      who := Trim (DlgEditText);
      if who <> '' then begin
         changegroupmodetime := GetTickCount + 5000; //timeout 5ÃÊ
         FrmMain.SendAddGroupMember (Trim (DlgEditText));
      end;
   end;
end;

procedure TFrmDlg.DGrpDelMemClick(Sender: TObject; X, Y: Integer);
var
   who: string;
begin
   if (GetTickCount > changegroupmodetime) and (GroupMembers.Count > 0) then begin
      DialogSize := 1;
      DMessageDlg ('ÇëÊäÈëÒªÉ¾³ýµÄ¶ÓÓÑÃû×Ö.', [mbOk, mbAbort]);
      who := Trim (DlgEditText);
      if who <> '' then begin
         changegroupmodetime := GetTickCount + 5000; //timeout 5ÃÊ
         FrmMain.SendDelGroupMember (Trim (DlgEditText));
      end;
   end;
end;

procedure TFrmDlg.DBotLogoutClick(Sender: TObject; X, Y: Integer);
begin
   if (GetTickCount - LatestStruckTime > 10000) and
      (GetTickCount - LatestMagicTime > 10000) and
      (GetTickCount - LatestHitTime > 10000) or
      (Myself.Death) then begin
      FrmMain.AppLogOut;
   end else
      DScreen.AddChatBoardString ('ÕýÔÚÕù¶·ÖÐ£¬²»ÄÜÍË³öÓÎÏ·.', clYellow, clRed);
end;

procedure TFrmDlg.DBotExitClick(Sender: TObject; X, Y: Integer);
begin
   if (GetTickCount - LatestStruckTime > 10000) and
      (GetTickCount - LatestMagicTime > 10000) and
      (GetTickCount - LatestHitTime > 10000) or
      (Myself.Death) then begin
      FrmMain.AppExit;
   end else
      DScreen.AddChatBoardString ('ÕýÔÚÕù¶·ÖÐ£¬²»ÄÜÍË³öÓÎÏ·.', clYellow, clRed);
end;

procedure TFrmDlg.DBotPlusAbilClick(Sender: TObject; X, Y: Integer);
begin
   FrmDlg.OpenAdjustAbility;
end;


{------------------------------------------------------------------------}

//±³È¯ ´ÙÀÌ¾ó·Î±×

{------------------------------------------------------------------------}


procedure TFrmDlg.OpenDealDlg;
var
   d: TDirectDrawSurface;
begin
   DDealRemoteDlg.Left := SCREENWIDTH-236-100;
   DDealRemoteDlg.Top := 0;
   DDealDlg.Left := SCREENWIDTH-236-100;
   DDealDlg.Top  := DDealRemoteDlg.Height-15;
   DItemBag.Left := 0; //475;
   DItemBag.Top := 0;
   DItemBag.Visible := TRUE;
   DDealDlg.Visible := TRUE;
   DDealRemoteDlg.Visible := TRUE;

   FillCHar (DealItems, sizeof(TClientItem)*10, #0);
   FillCHar (DealRemoteItems, sizeof(TClientItem)*20, #0);
   DealGold := 0;
   DealRemoteGold := 0;
   BoDealEnd := FALSE;

   //¾ÆÀÌÅÛ °¡¹æ¿¡ ÀÜ»óÀÌ ÀÖ´ÂÁö °Ë»ç
   ArrangeItembag;
end;

procedure TFrmDlg.CloseDealDlg;
begin
   DDealDlg.Visible := FALSE;
   DDealRemoteDlg.Visible := FALSE;

   //¾ÆÀÌÅÛ °¡¹æ¿¡ ÀÜ»óÀÌ ÀÖ´ÂÁö °Ë»ç
   ArrangeItembag;
end;

procedure TFrmDlg.DDealOkClick(Sender: TObject; X, Y: Integer);
var
   mi: integer;
begin
   if GetTickCount > dealactiontime then begin
      //CloseDealDlg;
      FrmMain.SendDealEnd;
      dealactiontime := GetTickCount + 4000;
      BoDealEnd := TRUE;
      //µô Ã¢¿¡¼­ ¸¶¿ì½º·Î ²ø°í ÀÖ´Â °ÍÀ» µôÃ¢À¸·Î ³Ö´Â´Ù. ¸¶¿ì½º¿¡ ³²´Â ÀÜ»ó(º¹»ç)À» ¾ø¾Ø´Ù.
      if ItemMoving then begin
         mi := MovingItem.Index;
         if (mi <= -20) and (mi > -30) then begin //µô Ã¢¿¡¼­ ¿Â°Í¸¸
            AddDealItem (MovingItem.Item);
            ItemMoving := FALSE;
            MovingItem.Item.S.name := '';
         end;
      end;
   end;
end;

procedure TFrmDlg.DDealCloseClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > dealactiontime then begin
      CloseDealDlg;
      FrmMain.SendCancelDeal;
   end;
end;

procedure TFrmDlg.DDealRemoteDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
   with DDealRemoteDlg do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         TextOut (SurfaceX(Left+64), SurfaceY(Top+196-65), GetGoldStr(DealRemoteGold));
         TextOut (SurfaceX(Left+59 + (106-TextWidth(DealWho)) div 2), SurfaceY(Top+3)+3, DealWho);
         Release;
      end;
   end;
end;

procedure TFrmDlg.DDealDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
   with DDealDlg do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         TextOut (SurfaceX(Left+64), SurfaceY(Top+196-65), GetGoldStr(DealGold));
         TextOut (SurfaceX(Left+59 + (106-TextWidth(FrmMain.CharName)) div 2), SurfaceY(Top+3)+3, FrmMain.CharName);
         Release;
      end;
   end;
end;

procedure TFrmDlg.DealItemReturnBag (mitem: TClientItem);
begin
   if not BoDealEnd then begin
      DealDlgItem := mitem;
      FrmMain.SendDelDealItem (DealDlgItem);
      dealactiontime := GetTickCount + 4000;
   end;
end;

procedure TFrmDlg.DDGridGridSelect(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
   temp: TClientItem;
   mi, idx: integer;
begin
   if not BoDealEnd and (GetTickCount > dealactiontime) then begin
      if not ItemMoving then begin
         idx := ACol + ARow * DDGrid.ColCount;
         if idx in [0..9] then
            if DealItems[idx].S.Name <> '' then begin
               ItemMoving := TRUE;
               MovingItem.Index := -idx - 20;
               MovingItem.Item := DealItems[idx];
               DealItems[idx].S.Name := '';
               ItemClickSound (MovingItem.Item.S);
            end;
      end else begin
         mi := MovingItem.Index;
         if (mi >= 0) or (mi <= -20) and (mi > -30) then begin //°¡¹æ,¿¡¼­ ¿Â°Í¸¸
            ItemClickSound (MovingItem.Item.S);
            ItemMoving := FALSE;
            if mi >= 0 then begin
               DealDlgItem := MovingItem.Item; //¼­¹ö¿¡ °á°ú¸¦ ±â´Ù¸®´Âµ¿¾È º¸°ü
               FrmMain.SendAddDealItem (DealDlgItem);
               dealactiontime := GetTickCount + 4000;
            end else
               AddDealItem (MovingItem.Item);
            MovingItem.Item.S.name := '';
         end;
         if mi = -98 then DDGoldClick (self, 0, 0);
      end;
      ArrangeItemBag;
   end;
end;

procedure TFrmDlg.DDGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   idx := ACol + ARow * DDGrid.ColCount;
   if idx in [0..9] then begin
      if DealItems[idx].S.Name <> '' then begin
         d := FrmMain.WBagItem.Images[DealItems[idx].S.Looks];
         if d <> nil then
            with DDGrid do
               dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DDGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
   idx: integer;
begin
   idx := ACol + ARow * DDGrid.ColCount;
   if idx in [0..9] then begin
      MouseItem := DealItems[idx];
   end;
end;

procedure TFrmDlg.DDRGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   idx := ACol + ARow * DDRGrid.ColCount;
   if idx in [0..19] then begin
      if DealRemoteItems[idx].S.Name <> '' then begin
         d := FrmMain.WBagItem.Images[DealRemoteItems[idx].S.Looks];
         if d <> nil then
            with DDRGrid do
               dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DDRGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   idx: integer;
begin
   idx := ACol + ARow * DDRGrid.ColCount;
   if idx in [0..19] then begin
      MouseItem := DealRemoteItems[idx];
   end;
end;

procedure TFrmDlg.DealZeroGold;
begin
   if not BoDealEnd and (DealGold > 0) then begin
      dealactiontime := GetTickCount + 4000;
      FrmMain.SendChangeDealGold (0);
   end;
end;

procedure TFrmDlg.DDGoldClick(Sender: TObject; X, Y: Integer);
var
   dgold: integer;
   valstr: string;
begin
   if Myself = nil then exit;
   if not BoDealEnd and (GetTickCount > dealactiontime) then begin
      if not ItemMoving then begin
         if DealGold > 0 then begin
            PlaySound (s_money);
            ItemMoving := TRUE;
            MovingItem.Index := -97; //±³È¯ Ã¢¿¡¼­ÀÇ µ·
            MovingItem.Item.S.Name := '½ð×Ó';
         end;
      end else begin
         if (MovingItem.Index = -97) or (MovingItem.Index = -98) then begin //µ·¸¸..
            if (MovingItem.Index = -98) then begin //°¡¹æÃ¢¿¡¼­ ¿Â µ·
               if MovingItem.Item.S.Name = '½ð×Ó' then begin
                  //¾ó¸¶¸¦ ¹ö¸± °ÇÁö ¹°¾îº»´Ù.
                  DialogSize := 1;
                  ItemMoving := FALSE;
                  MovingItem.Item.S.Name := '';
                  DMessageDlg ('ÄãÏë³ö¶àÉÙ½ð×Ó£¿', [mbOk, mbAbort]);
                  GetValidStrVal (DlgEditText, valstr, [' ']);
                  dgold := Str_ToInt (valstr, 0);
                  if (dgold <= (DealGold+Myself.Gold)) and (dgold > 0) then begin
                     FrmMain.SendChangeDealGold (dgold);
                     dealactiontime := GetTickCount + 4000;
                  end else
                     dgold := 0;
               end;
            end;
            ItemMoving := FALSE;
            MovingItem.Item.S.Name := '';
         end;
      end;
   end;
end;



{--------------------------------------------------------------}


procedure TFrmDlg.DUserState1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   i, l, m, pgidx, bbx, bby, idx, ax, ay, sex, hair: integer;
   d: TDirectDrawSurface;
   hcolor, keyimg: integer;
   iname, d1, d2, d3: string;
   useable: Boolean;
begin
   with DUserState1 do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      //Âø¿ë»óÅÂ
      sex := DRESSfeature (UserState1.Feature) mod 2;
      hair := HAIRfeature (UserState1.Feature);
      if sex = 1 then pgidx := 377   //¿©ÀÚ
      else pgidx := 376;     //³²ÀÚ
      bbx := Left + 38;
      bby := Top + 52;
      d := FrmMain.WProgUse.Images[pgidx];
      if d <> nil then
         dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);
      bbx := bbx - 7;
      bby := bby + 44;
      //¿Ê, ¹«±â, ¸Ó¸® ½ºÅ¸ÀÏ
      idx := 440 + hair div 2; //¸Ó¸® ½ºÅ¸ÀÏ
      if sex = 1 then idx := 480 + hair div 2;
      if idx > 0 then begin
         d := FrmMain.WProgUse.GetCachedImage (idx, ax, ay);
         if d <> nil then
            dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
      end;
      if UserState1.UseItems[U_DRESS].S.Name <> '' then begin
         idx := UserState1.UseItems[U_DRESS].S.Looks; //¿Ê if Sex = 1 then idx := 80; //¿©ÀÚ¿Ê
         if idx >= 0 then begin
            d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
         end;
      end;
      if UserState1.UseItems[U_WEAPON].S.Name <> '' then begin
         idx := UserState1.UseItems[U_WEAPON].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
         end;
      end;
      if UserState1.UseItems[U_HELMET].S.Name <> '' then begin
         idx := UserState1.UseItems[U_HELMET].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
         end;
      end;


      if MouseUserStateItem.S.Name <> '' then begin
         MouseItem := MouseUserStateItem;
         GetMouseItemInfo (iname, d1, d2, d3, useable);
         if iname <> '' then begin
            if MouseItem.Dura = 0 then hcolor := clRed
            else hcolor := clWhite;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clYellow;
               TextOut (SurfaceX(Left+37), SurfaceY(Top+272), iname);
               Font.Color := hcolor;
               TextOut (SurfaceX(Left+37+TextWidth(iname)), SurfaceY(Top+272), d1);
               TextOut (SurfaceX(Left+37), SurfaceY(Top+272+TextHeight('A')+2), d2);
               TextOut (SurfaceX(Left+37), SurfaceY(Top+272+(TextHeight('A')+2)*2), d3);
               Release;
            end;
         end;
         MouseItem.S.Name := '';
      end;

      //ÀÌ¸§
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := UserState1.NameColor;
         TextOut (SurfaceX(Left + 122 - TextWidth(UserState1.UserName) div 2),
                  SurfaceY(Top + 23), UserState1.UserName);
         Font.Color := clSilver;
         TextOut (SurfaceX(Left + 45), SurfaceY(Top + 58),
                  UserState1.GuildName + ' ' + UserState1.GuildRankName);
         Release;
      end;

   end;
end;

procedure TFrmDlg.DUserState1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   X := DUserState1.LocalX (X) - DUserState1.Left;
   Y := DUserState1.LocalY (Y) - DUserState1.Top;
   if (X > 42) and (X < 201) and (Y > 54) and (Y < 71) then begin
      //DScreen.AddSysMsg (IntToStr(X) + ' ' + IntToStr(Y) + ' ' + UserState1.GuildName);
      if UserState1.GuildName <> '' then begin
         PlayScene.EdChat.Visible := TRUE;
         PlayScene.EdChat.SetFocus;
         SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
         PlayScene.EdChat.Text := UserState1.GuildName;
         PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
         PlayScene.EdChat.SelLength := 0;
      end;
   end;
end;

procedure TFrmDlg.DUserState1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   MouseUserStateItem.S.Name := '';
end;

procedure TFrmDlg.DWeaponUS1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
   sel: integer;
begin
   sel := -1;
   if Sender = DDressUS1 then sel := U_DRESS;
   if Sender = DWeaponUS1 then sel := U_WEAPON;
   if Sender = DHelmetUS1 then sel := U_HELMET;
   if Sender = DNecklaceUS1 then sel := U_NECKLACE;
   if Sender = DLightUS1 then sel := U_RIGHTHAND;
   if Sender = DRingLUS1 then sel := U_RINGL;
   if Sender = DRingRUS1 then sel := U_RINGR;
   if Sender = DArmRingLUS1 then sel := U_ARMRINGL;
   if Sender = DArmRingRUS1 then sel := U_ARMRINGR;
   if sel >= 0 then begin
      MouseUserStateItem := UserState1.UseItems[sel];
   end;

end;

procedure TFrmDlg.DCloseUS1Click(Sender: TObject; X, Y: Integer);
begin
   DUserState1.Visible := FALSE;
end;

procedure TFrmDlg.DNecklaceUS1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   if Sender = DNecklaceUS1 then begin
      if UserState1.UseItems[U_NECKLACE].S.Name <> '' then begin
         idx := UserState1.UseItems[U_NECKLACE].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.WStateItem.Images[idx];
            if d <> nil then
               dsurface.Draw (DNecklaceUS1.SurfaceX(DNecklaceUS1.Left + (DNecklaceUS1.Width - d.Width) div 2),
                              DNecklaceUS1.SurfaceY(DNecklaceUS1.Top + (DNecklaceUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;
   if Sender = DLightUS1 then begin
      if UserState1.UseItems[U_RIGHTHAND].S.Name <> '' then begin
         idx := UserState1.UseItems[U_RIGHTHAND].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.WStateItem.Images[idx];
            if d <> nil then
               dsurface.Draw (DLightUS1.SurfaceX(DLightUS1.Left + (DLightUS1.Width - d.Width) div 2),
                              DLightUS1.SurfaceY(DLightUS1.Top + (DLightUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;
   if Sender = DArmRingRUS1 then begin
      if UserState1.UseItems[U_ARMRINGR].S.Name <> '' then begin
         idx := UserState1.UseItems[U_ARMRINGR].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.WStateItem.Images[idx];
            if d <> nil then
               dsurface.Draw (DArmRingRUS1.SurfaceX(DArmRingRUS1.Left + (DArmRingRUS1.Width - d.Width) div 2),
                              DArmRingRUS1.SurfaceY(DArmRingRUS1.Top + (DArmRingRUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;
   if Sender = DArmRingLUS1 then begin
      if UserState1.UseItems[U_ARMRINGL].S.Name <> '' then begin
         idx := UserState1.UseItems[U_ARMRINGL].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.WStateItem.Images[idx];
            if d <> nil then
               dsurface.Draw (DArmRingLUS1.SurfaceX(DArmRingLUS1.Left + (DArmRingLUS1.Width - d.Width) div 2),
                              DArmRingLUS1.SurfaceY(DArmRingLUS1.Top + (DArmRingLUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;
   if Sender = DRingRUS1 then begin
      if UserState1.UseItems[U_RINGR].S.Name <> '' then begin
         idx := UserState1.UseItems[U_RINGR].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.WStateItem.Images[idx];
            if d <> nil then
               dsurface.Draw (DRingRUS1.SurfaceX(DRingRUS1.Left + (DRingRUS1.Width - d.Width) div 2),
                              DRingRUS1.SurfaceY(DRingRUS1.Top + (DRingRUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;
   if Sender = DRingLUS1 then begin
      if UserState1.UseItems[U_RINGL].S.Name <> '' then begin
         idx := UserState1.UseItems[U_RINGL].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.WStateItem.Images[idx];
            if d <> nil then
               dsurface.Draw (DRingLUS1.SurfaceX(DRingLUS1.Left + (DRingLUS1.Width - d.Width) div 2),
                              DRingLUS1.SurfaceY(DRingLUS1.Top + (DRingLUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;
end;


procedure TFrmDlg.ShowGuildDlg;
begin
   DGuildDlg.Visible := TRUE;  //not DGuildDlg.Visible;
   DGuildDlg.Top := -3;
   DGuildDlg.Left := 0;
   if DGuildDlg.Visible then begin
      if GuildCommanderMode then begin
         DGDAddMem.Visible := TRUE;
         DGDDelMem.Visible := TRUE;
         DGDEditNotice.Visible := TRUE;
         DGDEditGrade.Visible := TRUE;
         DGDAlly.Visible := TRUE;
         DGDBreakAlly.Visible := TRUE;
         DGDWar.Visible := TRUE;
         DGDCancelWar.Visible := TRUE;
      end else begin
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
end;

procedure TFrmDlg.ShowGuildEditNotice;
var
   d: TDirectDrawSurface;
   i: integer;
   data: string;
begin
   with DGuildEditNotice do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then begin
         Left := (SCREENWIDTH - d.Width) div 2;
         Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      HideAllControls;
      DGuildEditNotice.ShowModal;

      Memo.Left := SurfaceX(Left+16);
      Memo.Top  := SurfaceY(Top+36);
      Memo.Width := 571;
      Memo.Height := 246;
      Memo.Lines.Assign (GuildNotice);
      Memo.Visible := TRUE;

      while TRUE do begin
         if not DGuildEditNotice.Visible then break;
         FrmMain.ProcOnIdle;
         Application.ProcessMessages;
         if Application.Terminated then exit;
      end;

      DGuildEditNotice.Visible := FALSE;
      RestoreHideControls;

      if DMsgDlg.DialogResult = mrOk then begin
         //°á°ú... ¹®ÆÄ°øÁö»çÇ×À» ¾÷µ¥ÀÌÆ® ÇÑ´Ù.
         data := '';
         for i:=0 to Memo.Lines.Count-1 do begin
            if Memo.Lines[i] = '' then
               data := data + Memo.Lines[i] + ' '#13
            else data := data + Memo.Lines[i] + #13;
         end;
         if Length(data) > 4000 then begin
            data := Copy (data, 1, 4000);
            DMessageDlg ('¹«¸æÎÄ×Ö×î¶àÖ»ÄÜÊäÈë4000¸ö×Ö·û£¬¶àÓà²¿·Ö½«±»½Ø¶Ï¡£', [mbOk]);
         end;
         FrmMain.SendGuildUpdateNotice (data);
      end;
   end;
end;

procedure TFrmDlg.ShowGuildEditGrade;
var
   d: TDirectDrawSurface;
   data: string;
   i: integer;
begin
   if GuildMembers.Count <= 0 then begin
      DMessageDlg ('¹«¸æÄÚÈÝÎª¿Õ¡£', [mbOk]);
      exit;
   end;

   with DGuildEditNotice do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then begin
         Left := (SCREENWIDTH - d.Width) div 2;
         Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      HideAllControls;
      DGuildEditNotice.ShowModal;

      Memo.Left := SurfaceX(Left+16);
      Memo.Top  := SurfaceY(Top+36);
      Memo.Width := 571;
      Memo.Height := 246;
      Memo.Lines.Assign (GuildMembers);
      Memo.Visible := TRUE;

      while TRUE do begin
         if not DGuildEditNotice.Visible then break;
         FrmMain.ProcOnIdle;
         Application.ProcessMessages;
         if Application.Terminated then exit;
      end;

      DGuildEditNotice.Visible := FALSE;
      RestoreHideControls;

      if DMsgDlg.DialogResult = mrOk then begin
         //GuildMembers.Assign (Memo.Lines);
         //°á°ú... ¹®ÆÄµî±ÞÀ» ¾÷µ¥ÀÌÆ® ÇÑ´Ù.
         data := '';
         for i:=0 to Memo.Lines.Count-1 do begin
            data := data + Memo.Lines[i] + #13;  //¼­¹ö¿¡¼­ ÆÄ½ÌÇÔ.
         end;
         if Length(data) > 5000 then begin
            data := Copy (data, 1, 5000);
            DMessageDlg ('¹®ÀÚ¿­ÀÌ ³Ê¹« ±æ¾î¼­ µÚ¿¡ ºÎºÐÀÌ Â©·È½À´Ï´Ù.', [mbOk]);
         end;
         FrmMain.SendGuildUpdateGrade (data);
      end;
   end;
end;

procedure TFrmDlg.DGuildDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  i, n, bx, by: integer;
begin
   with DGuildDlg do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         TextOut (Left+320, Top+13, Guild);

         bx := Left + 24;
         by := Top + 41;
         for i:=GuildTopLine to GuildStrs.Count-1 do begin
            n := i-GuildTopLine;
            if n*14 > 356 then break;
            if Integer(GuildStrs.Objects[i]) <> 0 then Font.Color := TColor(GuildStrs.Objects[i])
            else begin
               if BoGuildChat then Font.Color := GetRGB (2)
               else Font.Color := clSilver;
            end;
            TextOut (bx, by + n*14, GuildStrs[i]);
         end;

         Release;
      end;

   end;
end;

procedure TFrmDlg.DGDUpClick(Sender: TObject; X, Y: Integer);
begin
   if GuildTopLine > 0 then Dec (GuildTopLine, 3);
   if GuildTopLine < 0 then GuildTopLine := 0;
end;

procedure TFrmDlg.DGDDownClick(Sender: TObject; X, Y: Integer);
begin
   if GuildTopLine+12 < GuildStrs.Count then Inc (GuildTopLine, 3);
end;

procedure TFrmDlg.DGDCloseClick(Sender: TObject; X, Y: Integer);
begin
   DGuildDlg.Visible := FALSE;
   BoGuildChat := FALSE;
end;

procedure TFrmDlg.DGDHomeClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > querymsgtime then begin
      querymsgtime := GetTickCount + 3000;
      FrmMain.SendGuildHome;
      BoGuildChat := FALSE;
   end;
end;

procedure TFrmDlg.DGDListClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > querymsgtime then begin
      querymsgtime := GetTickCount + 3000;
      FrmMain.SendGuildMemberList;
      BoGuildChat := FALSE;
   end;
end;

procedure TFrmDlg.DGDAddMemClick(Sender: TObject; X, Y: Integer);
begin
   DMessageDlg (Guild + ' ÐÐ»á³ÉÔ±Ìí¼Ó£¬ÇëÊäÈëÒªÌí¼ÓµÄÈËÃû£º', [mbOk, mbAbort]);
   if DlgEditText <> '' then
      FrmMain.SendGuildAddMem (DlgEditText);
end;

procedure TFrmDlg.DGDDelMemClick(Sender: TObject; X, Y: Integer);
begin
   DMessageDlg (Guild + ' ÐÐ»á³ÉÔ±É¾³ý£¬ÇëÊäÈëÒªÉ¾³ýµÄÈËÃû£º', [mbOk, mbAbort]);
   if DlgEditText <> '' then
      FrmMain.SendGuildDelMem (DlgEditText);
end;

procedure TFrmDlg.DGDEditNoticeClick(Sender: TObject; X, Y: Integer);
begin
   GuildEditHint := '[±à¼­ÐÐ»á¹«¸æ.]';
   ShowGuildEditNotice;
end;

procedure TFrmDlg.DGDEditGradeClick(Sender: TObject; X, Y: Integer);
begin
   GuildEditHint := '[¹®¿øÀÇ ¼­¿­°ú Á÷Ã¥ ÀÌ¸§À» ¼öÁ¤ÇÕ´Ï´Ù. #ÁÖÀÇ: ¹®¿ø Ãß°¡/»èÁ¦ ¾ÈµÊ]';
   ShowGuildEditGrade;
end;

procedure TFrmDlg.DGDAllyClick(Sender: TObject; X, Y: Integer);
begin
   if mrOk = DMessageDlg ('µ¿¸ÍÀ» ÇÏ±â À§ÇØ¼­´Â »ó´ë¹æ ¹®ÆÄ°¡ [µ¿¸Í°¡´É] »óÅÂ ÀÌ¾î¾ß ÇÏ¸ç\' +
                  '»ó´ë ¹®ÁÖ¿Í ¸¶ÁÖº¸°í ÀÖ¾î¾ß ÇÕ´Ï´Ù.\' +
                  'µ¿¸ÍÀ» ÇÏ½Ã°Ú½À´Ï±î?', [mbOk, mbCancel])
   then
      FrmMain.SendSay ('@µ¿¸Í');
end;

procedure TFrmDlg.DGDBreakAllyClick(Sender: TObject; X, Y: Integer);
begin
   DMessageDlg ('µ¿¸ÍÀ» ÆÄ±âÇÒ ¹®ÆÄÀÇ ÀÌ¸§À» ÀÔ·ÂÇÏ½Ê½Ã¿À.', [mbOk, mbAbort]);
   if DlgEditText <> '' then
      FrmMain.SendSay ('@µ¿¸ÍÆÄ±â ' + DlgEditText);
end;



procedure TFrmDlg.DGuildEditNoticeDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with DGuildEditNotice do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clSilver;

         TextOut (Left+18, Top+291, GuildEditHint);
         Release;
      end;
   end;
end;

procedure TFrmDlg.DGECloseClick(Sender: TObject; X, Y: Integer);
begin
   DGuildEditNotice.Visible := FALSE;
   Memo.Visible := FALSE;
   DMsgDlg.DialogResult := mrCancel;
end;

procedure TFrmDlg.DGEOkClick(Sender: TObject; X, Y: Integer);
begin
   DGECloseClick (self, 0, 0);
   DMsgDlg.DialogResult := mrOk;
end;

procedure TFrmDlg.AddGuildChat (str: string);
var
   i: integer;
begin
   GuildChats.Add (str);
   if GuildChats.Count > 500 then begin
      for i:=0 to 100 do GuildChats.Delete(0);
   end;
   if BoGuildChat then
      GuildStrs.Assign (GuildChats);
end;

procedure TFrmDlg.DGDChatClick(Sender: TObject; X, Y: Integer);
begin
   BoGuildChat := not BoGuildChat;
   if BoGuildChat then begin
      GuildStrs2.Assign (GuildStrs);
      GuildStrs.Assign (GuildChats);
   end else
      GuildStrs.Assign (GuildStrs2);
end;

procedure TFrmDlg.DGoldDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
   if Myself = nil then exit;
   with DGold do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
   end;
end;


{--------------------------------------------------------------}
//´É·ÂÄ¡ Á¶Á¤ Ã¢

procedure TFrmDlg.DAdjustAbilCloseClick(Sender: TObject; X, Y: Integer);
begin
   DAdjustAbility.Visible := FALSE;
   BonusPoint := SaveBonusPoint;
end;

procedure TFrmDlg.DAdjustAbilityDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
   procedure AdjustAb (abil: byte; val: word; var lov, hiv: byte);
   var
      lo, hi: byte;
      i: integer;
   begin
      lo := Lobyte(abil);
      hi := Hibyte(abil);
      lov := 0; hiv := 0;
      for i:=1 to val do begin
         if lo+1 < hi then begin Inc(lo); Inc(lov);
         end else begin Inc(hi); Inc(hiv); end;
      end;
   end;
var
   d: TDirectDrawSurface;
   l, m, adc, amc, asc, aac, amac: integer;
   ldc, lmc, lsc, lac, lmac, hdc, hmc, hsc, hac, hmac: byte;
begin
   if Myself = nil then exit;
   with dsurface.Canvas do begin
      with DAdjustAbility do begin
         d := DMenuDlg.WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      SetBkMode (Handle, TRANSPARENT);
      Font.Color := clSilver;

      l := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 36;
      m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 22;

      TextOut (l, m,      'ÃàÇÏÇÕ´Ï´Ù. ´ç½ÅÀÇ ·¹º§ÀÌ ¿Ã¶ú±º¿ä.');
      TextOut (l, m+14,   '¾Æ·¡ÀÇ ´É·Â Áß¿¡¼­ ¿øÇÏ´Â ´É·ÂÀ» ¿Ã¸®½Ã±â');
      TextOut (l, m+14*2, '¹Ù¶ø´Ï´Ù. ¼±ÅÃÀº ¿ÀÁ÷ ÇÑ¹ø »ÓÀÌ¹Ç·Î ½ÅÁß');
      TextOut (l, m+14*3, 'ÇÏ°Ô ¼±ÅÃÇÏ½Ã±â ¹Ù¶ø´Ï´Ù.');

      Font.Color := clWhite;
      //ÇöÀçÀÇ ´É·ÂÄ¡
      l := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 100; //66;
      m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 101;

      adc := (BonusAbil.DC + BonusAbilChg.DC) div BonusTick.DC;
      amc := (BonusAbil.MC + BonusAbilChg.MC) div BonusTick.MC;
      asc := (BonusAbil.SC + BonusAbilChg.SC) div BonusTick.SC;
      aac := (BonusAbil.AC + BonusAbilChg.AC) div BonusTick.AC;
      amac := (BonusAbil.MAC + BonusAbilChg.MAC) div BonusTick.MAC;

      AdjustAb (NakedAbil.DC, adc, ldc, hdc);
      AdjustAb (NakedAbil.MC, amc, lmc, hmc);
      AdjustAb (NakedAbil.SC, asc, lsc, hsc);
      //AdjustAb (NakedAbil.AC, aac, lac, hac);
      //AdjustAb (NakedAbil.MAC, amac, lmac, hmac);
      lac  := 0;  hac := aac;
      lmac := 0;  hmac := amac;

      TextOut (l+0, m+0, IntToStr(Lobyte(Myself.Abil.DC)+ldc) + '-' + IntToStr(Hibyte(Myself.Abil.DC) + hdc));
      TextOut (l+0, m+20, IntToStr(Lobyte(Myself.Abil.MC)+lmc) + '-' + IntToStr(Hibyte(Myself.Abil.MC) + hmc));
      TextOut (l+0, m+40, IntToStr(Lobyte(Myself.Abil.SC)+lsc) + '-' + IntToStr(Hibyte(Myself.Abil.SC) + hsc));
      TextOut (l+0, m+60, IntToStr(Lobyte(Myself.Abil.AC)+lac) + '-' + IntToStr(Hibyte(Myself.Abil.AC) + hac));
      TextOut (l+0, m+80, IntToStr(Lobyte(Myself.Abil.MAC)+lmac) + '-' + IntToStr(Hibyte(Myself.Abil.MAC) + hmac));
      TextOut (l+0, m+100, IntToStr(Myself.Abil.MaxHP + (BonusAbil.HP + BonusAbilChg.HP) div BonusTick.HP));
      TextOut (l+0, m+120, IntToStr(Myself.Abil.MaxMP + (BonusAbil.MP + BonusAbilChg.MP) div BonusTick.MP));
      TextOut (l+0, m+140, IntToStr(MyHitPoint + (BonusAbil.Hit + BonusAbilChg.Hit) div BonusTick.Hit));
      TextOut (l+0, m+160, IntToStr(MySpeedPoint + (BonusAbil.Speed + BonusAbilChg.Speed) div BonusTick.Speed));

      Font.Color := clYellow;
      TextOut (l+0, m+180, IntToStr(BonusPoint));

      Font.Color := clWhite;
      l := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 155; //66;
      m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 101;

      if BonusAbilChg.DC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+0, IntToStr(BonusAbilChg.DC + BonusAbil.DC) + '/' + IntToStr(BonusTick.DC));

      if BonusAbilChg.MC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+20, IntToStr(BonusAbilChg.MC + BonusAbil.MC) + '/' + IntToStr(BonusTick.MC));

      if BonusAbilChg.SC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+40, IntToStr(BonusAbilChg.SC + BonusAbil.SC) + '/' + IntToStr(BonusTick.SC));

      if BonusAbilChg.AC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+60, IntToStr(BonusAbilChg.AC + BonusAbil.AC) + '/' + IntToStr(BonusTick.AC));

      if BonusAbilChg.MAC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+80, IntToStr(BonusAbilChg.MAC + BonusAbil.MAC) + '/' + IntToStr(BonusTick.MAC));

      if BonusAbilChg.HP > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+100, IntToStr(BonusAbilChg.HP + BonusAbil.HP) + '/' + IntToStr(BonusTick.HP));

      if BonusAbilChg.MP > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+120, IntToStr(BonusAbilChg.MP + BonusAbil.MP) + '/' + IntToStr(BonusTick.MP));

      if BonusAbilChg.Hit > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+140, IntToStr(BonusAbilChg.Hit + BonusAbil.Hit) + '/' + IntToStr(BonusTick.Hit));

      if BonusAbilChg.Speed > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+160, IntToStr(BonusAbilChg.Speed + BonusAbil.Speed) + '/' + IntToStr(BonusTick.Speed));

      Release;
   end;

end;

procedure TFrmDlg.DPlusDCClick(Sender: TObject; X, Y: Integer);
var
   incp: integer;
begin
   if BonusPoint > 0 then begin
      if IsKeyPressed (VK_CONTROL) and (BonusPoint > 10) then incp := 10
      else incp := 1;
      Dec(BonusPoint, incp);
      if Sender = DPlusDC then Inc (BonusAbilChg.DC, incp);
      if Sender = DPlusMC then Inc (BonusAbilChg.MC, incp);
      if Sender = DPlusSC then Inc (BonusAbilChg.SC, incp);
      if Sender = DPlusAC then Inc (BonusAbilChg.AC, incp);
      if Sender = DPlusMAC then Inc (BonusAbilChg.MAC, incp);
      if Sender = DPlusHP then Inc (BonusAbilChg.HP, incp);
      if Sender = DPlusMP then Inc (BonusAbilChg.MP, incp);
      if Sender = DPlusHit then Inc (BonusAbilChg.Hit, incp);
      if Sender = DPlusSpeed then Inc (BonusAbilChg.Speed, incp);
   end;
end;

procedure TFrmDlg.DMinusDCClick(Sender: TObject; X, Y: Integer);
var
   decp: integer;
begin
   if IsKeyPressed (VK_CONTROL) and (BonusPoint-10 > 0) then decp := 10
   else decp := 1;
   if Sender = DMinusDC then
      if BonusAbilChg.DC >= decp then begin
         Dec(BonusAbilChg.DC, decp);
         Inc (BonusPoint, decp);
      end;
   if Sender = DMinusMC then
      if BonusAbilChg.MC >= decp then begin
         Dec(BonusAbilChg.MC, decp);
         Inc (BonusPoint, decp);
      end;
   if Sender = DMinusSC then
      if BonusAbilChg.SC >= decp then begin
         Dec(BonusAbilChg.SC, decp);
         Inc (BonusPoint, decp);
      end;
   if Sender = DMinusAC then
      if BonusAbilChg.AC >= decp then begin
         Dec(BonusAbilChg.AC, decp);
         Inc (BonusPoint, decp);
      end;
   if Sender = DMinusMAC then
      if BonusAbilChg.MAC >= decp then begin
         Dec(BonusAbilChg.MAC, decp);
         Inc (BonusPoint, decp);
      end;
   if Sender = DMinusHP then
      if BonusAbilChg.HP >= decp then begin
         Dec(BonusAbilChg.HP, decp);
         Inc (BonusPoint, decp);
      end;
   if Sender = DMinusMP then
      if BonusAbilChg.MP >= decp then begin
         Dec(BonusAbilChg.MP, decp);
         Inc (BonusPoint, decp);
      end;
   if Sender = DMinusHit then
      if BonusAbilChg.Hit >= decp then begin
         Dec(BonusAbilChg.Hit, decp);
         Inc (BonusPoint, decp);
      end;
   if Sender = DMinusSpeed then
      if BonusAbilChg.Speed >= decp then begin
         Dec(BonusAbilChg.Speed, decp);
         Inc (BonusPoint, decp);
      end;
end;

procedure TFrmDlg.DAdjustAbilOkClick(Sender: TObject; X, Y: Integer);
begin
   FrmMain.SendAdjustBonus (BonusPoint, BonusAbilChg);
   DAdjustAbility.Visible := FALSE;
end;

procedure TFrmDlg.DAdjustAbilityMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
   i, lx, ly: integer;
   flag: Boolean;
begin
   with DAdjustAbility do begin
      lx := LocalX (X - Left);
      ly := LocalY (Y - Top);
      flag := FALSE;
      if (lx >= 50) and (lx < 150) then
         for i:=0 to 8 do begin  //DC,MC,SC..ÀÇ ÈùÆ®°¡ ³ª¿À°Ô ÇÑ´Ù.
            if (ly >= 98 + i*20) and (ly < 98 + (i+1)*20) then begin
               DScreen.ShowHint (SurfaceX(Left) + lx + 10,
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
end;

end.
