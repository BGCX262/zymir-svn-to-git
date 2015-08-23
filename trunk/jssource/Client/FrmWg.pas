//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit FrmWg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Spin, WShare, ExtCtrls, grobal2;

type
  TFormWgMain = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LabelMoveTime: TLabel;
    LabelHitTime: TLabel;
    LabelSpellTime: TLabel;
    MoveTime: TTrackBar;
    HitTime: TTrackBar;
    SpellTime: TTrackBar;
    AutoMagic: TCheckBox;
    MagicLock: TCheckBox;
    DuraAlert: TCheckBox;
    AutoDownDrup: TCheckBox;
    ShowHPNumber: TCheckBox;
    ShowRedHPLable: TCheckBox;
    CheckBoxBGSound: TCheckBox;
    ShowName: TCheckBox;
    ShowAllName: TCheckBox;
    ShowDura: TCheckBox;
    MagicFixupLockF: TRadioButton;
    AutoMagicIdx: TComboBox;
    AutoMagicTime: TSpinEdit;
    MagicFixupLockT: TRadioButton;
    CanRunNpc: TCheckBox;
    CanRunMon: TCheckBox;
    CanRunHuman: TCheckBox;
    ShowAllItemFil: TCheckBox;
    ShowAllItem: TCheckBox;
    ShowTopInfo: TCheckBox;
    AutoPuckUpItem: TCheckBox;
    ShowBlueMpLable: TCheckBox;
    MoveRedShow: TCheckBox;
    GroupBox1: TGroupBox;
    ParalyCan: TCheckBox;
    AutoPuckItemFil: TCheckBox;
    ShowGroupMember: TCheckBox;
    MoveSlow: TCheckBox;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    PageControl2: TPageControl;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    AutoHp: TCheckBox;
    AutoHpCount: TEdit;
    AutoHpName: TComboBox;
    AutoCropsHpName: TComboBox;
    AutoCropsHpCount: TEdit;
    AutoCropsHp: TCheckBox;
    AutoMpName: TComboBox;
    AutoMpCount: TEdit;
    AutoMp: TCheckBox;
    AutoCropsMp: TCheckBox;
    AutoCropsMpCount: TEdit;
    AutoCropsMpName: TComboBox;
    AutoHpProtect: TCheckBox;
    AutoHpProtectCount: TEdit;
    AutoHpProtectName: TComboBox;
    AttackEffect: TCheckBox;
    AttackEffectClsF: TRadioButton;
    AttackEffectClsT: TRadioButton;
    ClearMapDieActor: TCheckBox;
    Label9: TLabel;
    TabSheet11: TTabSheet;
    GroupBox2: TGroupBox;
    CropsMonList: TListBox;
    EditCrops: TEdit;
    AddCropsMon: TButton;
    DelCropsMon: TButton;
    CropsMonHit: TCheckBox;
    CropsChangeColor: TCheckBox;
    CropsAutoLock: TCheckBox;
    FriendHit: TCheckBox;
    BlacklistHit: TCheckBox;
    BlackListSys: TCheckBox;
    PageControl3: TPageControl;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    CanLongHit: TCheckBox;
    CanWideHit: TCheckBox;
    CanAutoFireHit: TCheckBox;
    CanFireSide: TCheckBox;
    TabSheet15: TTabSheet;
    CanShield: TCheckBox;
    CanFirewind: TCheckBox;
    CanAutoAddHp: TCheckBox;
    CanAutoAmyounsul: TCheckBox;
    CanAmyounsulCls: TComboBox;
    CanCrossingOver: TCheckBox;
    CanAutoAddHpCount: TEdit;
    Label10: TLabel;
    CanCloak: TCheckBox;
    CanHolyShield: TCheckBox;
    CanHolyShieldTick: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    CanDejiwonhoTick: TEdit;
    CanDejiwonho: TCheckBox;
    EntironmentList: TListView;
    ShowEntironment: TCheckBox;
    EntironmentClass: TComboBox;
    EntironmentTimer: TTimer;
    PageControl4: TPageControl;
    TabSheet16: TTabSheet;
    TabSheet17: TTabSheet;
    ItemName: TEdit;
    AddItem: TButton;
    DelItem: TButton;
    ShowCropsColor: TLabel;
    EditRedMsgFColor: TSpinEdit;
    CropsItemShow: TCheckBox;
    CropsItemHit: TCheckBox;
    ItemList: TListView;
    OpenItemList: TListView;
    Timer1: TTimer;
    AutoOpenItem: TCheckBox;
    CropsColorEff: TComboBox;
    CloseShift: TCheckBox;
    CanShieldClsF: TRadioButton;
    CanShieldClsT: TRadioButton;
    Label6: TLabel;
    CanAttackTick: TEdit;
    CanAttack: TCheckBox;
    CanCloakClsF: TRadioButton;
    CanCloakClsT: TRadioButton;
    ClearMapDieActorTime: TSpinEdit;
    CanAutoAddHpTick: TSpinEdit;
    AutoHpTick: TSpinEdit;
    AutoCropsHpTick: TSpinEdit;
    AutoMpTick: TSpinEdit;
    AutoCropsMpTick: TSpinEdit;
    AutoHpOrotectTick: TSpinEdit;
    Memo1: TMemo;
    Label7: TLabel;
    GroupBox3: TGroupBox;
    CheckBoxOpenMsg: TCheckBox;
    Label8: TLabel;
    EditSysMsg: TEdit;
    Label11: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    CheckBoxAutoDownHorse: TCheckBox;
    CheckBoxWizardShield: TCheckBox;
    CanCrsHit: TCheckBox;
    CanLongSword: TCheckBox;
    CanLongHit2: TCheckBox;
    CheckBoxDisableStruck: TCheckBox;
    CheckBoxHeroCallBoneFamm: TCheckBox;
    CheckBoxHeroCallDogz: TCheckBox;
    CheckBoxHeroCallFairy: TCheckBox;
    CanAutoLongFire: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ShowRedHPLableClick(Sender: TObject);
    procedure EntironmentTimerTimer(Sender: TObject);
    procedure ShowEntironmentClick(Sender: TObject);
    procedure ItemListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditRedMsgFColorChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure HitTimeChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBoxOpenMsgClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RadioSkeletonClick(Sender: TObject);
    procedure CheckBoxBGSoundClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure RefWgWindow();
    procedure RefWgBut();
    procedure RefHeroState(boFlag: Boolean; nJob: Integer);
    procedure ChangeJobButton(nJob: Byte);
  end;

var
  FormWgMain: TFormWgMain;
  g_WgItemArr: array[0..5] of TClientItem;
  g_dwFireHitTick: LongWord;
  g_dwLongSwordTick: LongWord;
  g_dwLongFireTick: LongWord;
  g_dwHPUpUseTime:LongWord;
  g_HumList: TList;

implementation

uses FState, ClMain, HUtil32, MShare, PlayScn, Actor, CLFunc, Share, SoundUtil;

{$R *.dfm}

procedure TFormWgMain.RefHeroState(boFlag: Boolean; nJob: Integer);
begin
  try //程序自动增加
    if (boFlag and (nJob <> 0)) or (not boFlag) then
    begin
      CheckBoxWizardShield.Enabled := boFlag;
      //CheckBoxTaosHeroMob.Enabled:=boFlag;
      CheckBoxHeroCallBoneFamm.Enabled := boFlag;
      CheckBoxHeroCallDogz.Enabled := boFlag;
      CheckBoxHeroCallFairy.Enabled := boFlag;
      if boFlag then
      begin
        CheckBoxWizardShield.Enabled := nJob = 1;
        //CheckBoxTaosHeroMob.Enabled:=nJob=2;
        CheckBoxHeroCallBoneFamm.Enabled := nJob = 2;
        CheckBoxHeroCallDogz.Enabled := nJob = 2;
        CheckBoxHeroCallFairy.Enabled := nJob = 2;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.RefHeroState'); //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.ChangeJobButton(nJob: Byte);
{var
  boBool  :Boolean;}
begin
  try //程序自动增加
    {CanLongHit.Enabled:=False;
    CanWideHit.Enabled:=False;
    CanAutoFireHit.Enabled:=False;
    CanFireSide.Enabled:=False;
    case nJob of
      Job_Warr:
        begin
          CanLongHit.Enabled:=True;
          CanWideHit.Enabled:=True;
          CanAutoFireHit.Enabled:=True;
          CanFireSide.Enabled:=True;
        end;
      JOB_WIZARD:
        begin

        end;
      JOB_TAOS:
        begin
        end;
    end;  }
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.ChangeJobButton'); //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.FormCreate(Sender: TObject);
begin
  try //程序自动增加
    PageControl1.TabIndex := 0;
    PageControl2.TabIndex := 0;
    PageControl3.TabIndex := 0;
    PageControl4.TabIndex := 0;
    g_dwFireHitTick := 1;
    g_dwLongSwordTick := 1;
    g_dwLongFireTick:=1;
    g_dwHPUpUseTime:=1;
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.FormCreate'); //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.RefWgWindow();
begin
  try //程序自动增加
    Left := 0;
    Top := 0;
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.RefWgWindow'); //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.RefWgBut();
var
  I: Integer;
  ItemFiltrate: pTItemFiltrate;
  OpenItem: pTOpenItem;
  Item: TListItem;
begin
  try //程序自动增加
    if g_MySelf = nil then
      exit;

    if g_HeronRecogId <> 0 then
      RefHeroState(True, g_HerobtJob);
    FormWgMain.MoveTime.Max := g_ClientWgInfo.nMoveTime;
    FormWgMain.HitTime.Max := g_ClientWgInfo.nHitTime;
    FormWgMain.SpellTime.Max := g_ClientWgInfo.nSpellTime;
    FormWgMain.MoveTime.Position := _MIN(FormWgMain.MoveTime.Max,
      FormWgMain.MoveTime.Position);
    FormWgMain.HitTime.Position := _MIN(FormWgMain.HitTime.Max,
      FormWgMain.HitTime.Position);
    FormWgMain.SpellTime.Position := _MIN(FormWgMain.SpellTime.Max,
      FormWgMain.SpellTime.Position);

    PageControl1.TabIndex := 0;
    PageControl2.TabIndex := 0;
    PageControl3.TabIndex := 0;
    PageControl4.TabIndex := 0;
    g_dwFireHitTick := 1;

    ShowRedHPLable.Enabled := g_ClientWgInfo.boShowRedHPLable;
    ShowGroupMember.Enabled := g_ClientWgInfo.boShowGroupMember;
    ShowAllItem.Enabled := g_ClientWgInfo.boShowAllItem;
    AutoMagic.Enabled := g_ClientWgInfo.boAutoMagic;
    ShowBlueMpLable.Enabled := g_ClientWgInfo.boShowBlueMpLable;
    ShowName.Enabled := g_ClientWgInfo.boShowName;
    AutoPuckUpItem.Enabled := g_ClientWgInfo.boAutoPuckUpItem;
    MoveRedShow.Enabled := g_ClientWgInfo.boMoveRedShow;
    ShowHPNumber.Enabled := g_ClientWgInfo.boShowHPNumber;
    ShowAllName.Enabled := g_ClientWgInfo.boShowAllName;
    MagicLock.Enabled := g_ClientWgInfo.boMagicLock;
    ParalyCan.Enabled := g_ClientWgInfo.boParalyCan;
    MoveSlow.Enabled := g_ClientWgInfo.boMoveSlow;

    ShowRedHPLable.Checked := g_WgInfo.boShowRedHPLable;
    ShowHPNumber.Checked := g_WgInfo.boShowHPNumber;
    ShowBlueMpLable.Checked := g_WgInfo.boShowBlueMpLable;
    MagicLock.Checked := g_WgInfo.boMagicLock;
    AutoPuckUpItem.Checked := g_WgInfo.boAutoPuckUpItem;
    MoveRedShow.Checked := g_WgInfo.boMoveRedShow;
    ParalyCan.Checked := g_wgInfo.boParalyCan;
    CheckBoxDisableStruck.Checked := g_WgInfo.boDisableStruck;

    CheckBoxAutoDownHorse.Checked := g_WgINfo.boAutoDownHorse;

    CanLongHit2.Checked := g_WgInfo.boCanLongHit2;
    ShowAllItem.Checked := g_WgInfo.boShowAllItem;
    CanRunHuman.Checked := g_WgInfo.boCanRunHuman;
    CanRunMon.Checked := g_WgInfo.boCanRunMon;
    CanRunNpc.Checked := g_WgInfo.boCanRunNpc;
    ShowTopInfo.Checked := g_WgInfo.boShowTopInfo;
    ShowDura.Checked := g_WgInfo.boShowDura;
    DuraAlert.Checked := g_WgInfo.boDuraAlert;
    ShowName.Checked := g_WgInfo.boShowName;
    ShowAllName.Checked := g_WgInfo.boShowAllName;
    AutoMagic.Checked := g_WgInfo.boAutoMagic;
    AutoMagicIdx.ItemIndex := _MAX(0, g_wgInfo.nAutoMagicIdx);
    AutoMagicTime.Value := _MAX(5, g_wgInfo.nAutoMagicTime div 1000);
    ShowGroupMember.Checked := g_WgInfo.boShowGroupMember;
    AutoPuckItemFil.Checked := g_WgInfo.boAutoPuckItemFil;
    ShowAllItemFil.Checked := g_WgInfo.boShowAllItemFil;
    ShowCropsColor.Color := GetRGB(g_WgInfo.coShowCropsColor);
    EditRedMsgFColor.Value := g_WgInfo.coShowCropsColor;
    CropsItemShow.Checked := g_WgInfo.boCropsItemShow;
    CropsItemHit.Checked := g_WgInfo.boCropsItemHit;
    AutoDownDrup.Checked := g_WgInfo.boAutoDownDrup;
    AutoOpenItem.Checked := g_WgInfo.boAutoOpenItem;
    MoveSlow.Checked := g_WgInfo.boMoveSlow;
    HitTime.Position := g_WgInfo.nHitTime;
    SpellTime.Position := g_WgInfo.nSpellTime;
    MoveTime.Position := g_WgInfo.nMoveTime;
    AttackEffect.Checked := g_WgInfo.boAttackEffect;
    ClearMapDieActor.Checked := g_WgInfo.boClearMapDieActor;
    ClearMapDieActorTime.Value := g_WgInfo.nClearMapDieActorTime div 1000;
    FriendHit.Checked := g_WgInfo.boFriendHit;
    BlacklistHit.Checked := g_WgInfo.boBlacklistHit;
    BlackListSys.Checked := g_WgInfo.boBlackListSys;
    CropsMonHit.Checked := g_WgInfo.boCropsMonHit;
    CropsAutoLock.Checked := g_WgInfo.boCropsAutoLock;
    CropsChangeColor.Checked := g_WgInfo.boCropsChangeColor;
    CropsColorEff.ItemIndex := g_WgInfo.nCropsColorEff - 1;
    CloseShift.Checked := g_WgInfo.boCloseShift;
    CanLongHit.Checked := g_WgInfo.boCanLongHit;
    CanWideHit.Checked := g_WgInfo.boCanWideHit;
    CanAutoFireHit.Checked := g_WgInfo.boCanAutoFireHit;
    CanAutoLongFire.Checked:=g_WgInfo.boCanAutoLongFire;
    CanFireSide.Checked := g_WgInfo.boCanFireSide;
    CanFirewind.Checked := g_WgInfo.boCanFirewind;
    CanShield.Checked := g_WgInfo.boCanShield;
    CanAutoAddHp.Checked := g_WgInfo.boCanAutoAddHp;
    CanAutoAddHpCount.Enabled := not g_WgInfo.boCanAutoAddHp;
    CanAutoAddHpTick.Enabled := not g_WgInfo.boCanAutoAddHp;
    CanAutoAddHpCount.Text := IntToStr(g_wgInfo.nCanAutoAddHpCount);
    CanAutoAddHpTick.Value := g_wgInfo.dwCanAutoAddHpTick div 1000;
    CanAutoAmyounsul.Checked := g_WgInfo.boCanAutoAmyounsul;
    CanAmyounsulCls.ItemIndex := g_WgInfo.btCanAmyounsulCls;
    CanAmyounsulCls.Enabled := not g_WgInfo.boCanAutoAmyounsul;
    CanCrossingOver.Checked := g_WgInfo.boCanCrossingOver;
    CanCloak.Checked := g_WgInfo.boCanCloak;
    CanCloakClsF.Enabled := not g_WgInfo.boCanCloak;
    CanCloakClsT.Enabled := not g_WgInfo.boCanCloak;
    CanAttack.Checked := g_WgInfo.boCanAttack;
    CanDejiwonho.Checked := g_WgInfo.boCanDejiwonho;
    CanHolyShield.Checked := g_WgInfo.boCanHolyShield;
    CanAttackTick.Text := IntToStr(g_WgInfo.dwCanAttackTick div 1000);
    CanDejiwonhoTick.Text := IntToStr(g_WgInfo.dwCanDejiwonhoTick div 1000);
    CanHolyShieldTick.Text := IntToStr(g_WgInfo.dwCanHolyShieldTick div 1000);
    CanAttackTick.Enabled := not g_WgInfo.boCanAttack;
    CanDejiwonhoTick.Enabled := not g_WgInfo.boCanDejiwonho;
    CanHolyShieldTick.Enabled := not g_WgInfo.boCanHolyShield;

    AutoHpProtectCount.Enabled := not g_WgInfo.boAutoHpProtect;
    AutoHpProtectName.Enabled := not g_WgInfo.boAutoHpProtect;
    AutoHpOrotectTick.Enabled := not g_WgInfo.boAutoHpProtect;
    AutoHpProtectCount.Text := IntToStr(g_WgInfo.boAutoHpProtectCount);
    if Length(g_WgInfo.boAutoHpProtectName) > 2 then
      AutoHpProtectName.Text := g_WgInfo.boAutoHpProtectName;
    AutoHpOrotectTick.Value := g_WgInfo.boAutoHpOrotectTick div 1000;

    AutoCropsMpCount.Enabled := not g_WgInfo.boAutoCropsMp;
    AutoCropsMpName.Enabled := not g_WgInfo.boAutoCropsMp;
    AutoCropsMpTick.Enabled := not g_WgInfo.boAutoCropsMp;
    AutoCropsMpCount.Text := IntToStr(g_WgInfo.boAutoCropsMpCount);
    if Length(g_WgInfo.boAutoCropsMpName) > 2 then
      AutoCropsMpName.Text := g_WgInfo.boAutoCropsMpName;
    AutoCropsMpTick.Value := g_WgInfo.boAutoCropsMpTick div 1000;

    AutoMpCount.Enabled := not g_WgInfo.boAutoMp;
    AutoMpName.Enabled := not g_WgInfo.boAutoMp;
    AutoMpTick.Enabled := not g_WgInfo.boAutoMp;
    AutoMpCount.Text := IntToStr(g_WgInfo.boAutoMpCount);
    if Length(g_WgInfo.boAutoMpName) > 2 then
      AutoMpName.Text := g_WgInfo.boAutoMpName;
    //AutoMpName.ItemIndex:=g_WgInfo.boAutoMpName;
    AutoMpTick.Value := g_WgInfo.boAutoMpTick div 1000;

    AutoCropsHpCount.Enabled := not g_WgInfo.boAutoCropsHp;
    AutoCropsHpName.Enabled := not g_WgInfo.boAutoCropsHp;
    AutoCropsHpTick.Enabled := not g_WgInfo.boAutoCropsHp;
    AutoCropsHpCount.Text := IntToStr(g_WgInfo.boAutoCropsHpCount);
    if Length(g_WgInfo.boAutoCropsHpName) > 2 then
      AutoCropsHpName.Text := g_WgInfo.boAutoCropsHpName;
    AutoCropsHpTick.Value := g_WgInfo.boAutoCropsHpTick div 1000;

    AutoHpCount.Enabled := not g_WgInfo.boAutoHp;
    AutoHpName.Enabled := not g_WgInfo.boAutoHp;
    AutoHpTick.Enabled := not g_WgInfo.boAutoHp;
    AutoHpCount.Text := IntToStr(g_WgInfo.boAutoHpCount);
    if Length(g_WgInfo.boAutoHpName) > 2 then
      AutoHpName.Text := g_WgInfo.boAutoHpName;
    //AutoHpName.ItemIndex:=g_WgInfo.boAutoHpName;
    AutoHpTick.Value := g_WgInfo.boAutoHpTick div 1000;

    CheckBoxWizardShield.Checked := g_WgInfo.boHeroAutoMagic;
    //CheckBoxTaosHeroMob.Checked:=g_WgInfo.boHeroAutoMagic;
    CanCrsHit.Checked := g_WgInfo.boCanCrsHit;
    CanLongSword.Checked := g_WgInfo.boCanLongSword;
    CheckBoxBGSound.Checked := g_boBGSound;

    AutoHp.Checked := g_WgInfo.boAutoHp;
    AutoCropsHp.Checked := g_WgInfo.boAutoCropsHp;
    AutoMp.Checked := g_WgInfo.boAutoMp;
    AutoCropsMp.Checked := g_WgInfo.boAutoCropsMp;
    AutoHpProtect.Checked := g_WgInfo.boAutoHpProtect;
    CheckBoxHeroCallBoneFamm.Checked := g_WgInfo.boHeroCallBoneFamm;
    CheckBoxHeroCallDogz.Checked := g_WgInfo.boHeroCallDogz;
    CheckBoxHeroCallFairy.Checked := g_WgInfo.boHeroCallFairy;
    {case g_WgInfo.btHeroCallMobClass of
      0:   RadioSkeleton.Checked:=True;
      1:   RadioDragon.Checked:=True;
      else RadioFairy.Checked:=True;
    end;  }
    if g_WgInfo.boCanCloakCls then
    begin
      CanCloakClsT.Checked := True;
      CanCloakClsF.Checked := False;
    end
    else
    begin
      CanCloakClsT.Checked := False;
      CanCloakClsF.Checked := True;
    end;
    if g_WgInfo.boCanShieldCls then
    begin
      CanShieldClsT.Checked := True;
      CanShieldClsF.Checked := False;
    end
    else
    begin
      CanShieldClsT.Checked := False;
      CanShieldClsF.Checked := True;
    end;
    CanShieldClsT.Enabled := not g_WgInfo.boCanShield;
    CanShieldClsF.Enabled := not g_WgInfo.boCanShield;
    if g_WgInfo.boAttackEffect then
    begin
      AttackEffectClsF.Enabled := False;
      AttackEffectClsT.Enabled := False;
    end
    else
    begin
      AttackEffectClsF.Enabled := True;
      AttackEffectClsT.Enabled := True;
    end;
    if g_WgInfo.boAttackEffectCls then
    begin
      AttackEffectClsF.Checked := False;
      AttackEffectClsT.Checked := True;
    end
    else
    begin
      AttackEffectClsF.Checked := True;
      AttackEffectClsT.Checked := False;
    end;

    if g_wgInfo.boMagicFixupLock then
    begin
      MagicFixupLockF.Checked := False;
      MagicFixupLockT.Checked := True;
    end
    else
    begin
      MagicFixupLockF.Checked := True;
      MagicFixupLockT.Checked := False;
    end;
    if g_WgInfo.boMagicLock then
    begin
      MagicFixupLockF.Enabled := False;
      MagicFixupLockT.Enabled := False;
    end
    else
    begin
      MagicFixupLockF.Enabled := True;
      MagicFixupLockT.Enabled := True;
    end;
    if g_WgInfo.boAutoMagic then
    begin
      AutoMagicIdx.Enabled := False;
      AutoMagicTime.Enabled := False;
    end
    else
    begin
      AutoMagicIdx.Enabled := True;
      AutoMagicTime.Enabled := True;
    end;

    ItemList.Items.Clear;
    for I := 0 to g_ItemFiltrateList.Count - 1 do
    begin
      ItemFiltrate := g_ItemFiltrateList.Items[I];
      Item := ItemList.Items.Add;
      Item.Caption := ItemFiltrate.sItemName;
      if ItemFiltrate.boItemShow then
        Item.SubItems.Add('√')
      else
        Item.SubItems.Add(' ');
      if ItemFiltrate.boItemPick then
        Item.SubItems.Add('√')
      else
        Item.SubItems.Add(' ');
      if ItemFiltrate.boItemCorps then
        Item.SubItems.Add('√')
      else
        Item.SubItems.Add(' ');
      if ItemFiltrate.boItemHit then
        Item.SubItems.Add('√')
      else
        Item.SubItems.Add(' ');
      //ChangeShowItem(ItemFiltrate.sItemName);
    end;
    OpenItemList.Items.Clear;
 {
    for I := 0 to g_OpenItemList.Count - 1 do
    begin
      OpenItem := g_OpenItemList.Items[I];
      Item := OpenItemList.Items.Add;
      Item.Caption := OpenItem.sItemName;
      Item.SubItems.Add(OpenItem.sBItemName);
    end;
    }
    CropsMonList.Items.Clear;
    for I := 0 to g_CorpsMonList.Count - 1 do
    begin
      CropsMonList.Items.Add(g_CorpsMonList.Strings[I]);
      ChangeMonShow(g_CorpsMonList.Strings[I], True);
    end;
    ChangeJobButton(g_MySelf.m_btJob);
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.RefWgBut'); //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.ShowRedHPLableClick(Sender: TObject);
var
  Item: TListItem;
  I: integer;
  ItemFiltrate: pTItemFiltrate;
  OpenItem: pTOpenItem;
begin
  try //程序自动增加
    {CheckBoxTaosHeroMob.Checked:=g_WgInfo.boHeroAutoMagic;
    case g_WgInfo.btHeroCallMobClass of
      0:   RadioSkeleton.Checked:=True;
      1:   RadioDragon.Checked:=True;
      else RadioFairy.Checked:=True;
    end;}
    if Sender = CheckBoxDisableStruck then
    begin
      g_WgInfo.boDisableStruck := CheckBoxDisableStruck.Checked;
    end
    else if Sender = CanLongHit2 then
    begin
      g_WgInfo.boCanLongHit2 := CanLongHit2.Checked;
    end
    else if Sender = CheckBoxWizardShield then
    begin
      if (g_HeronRecogId <> 0) and (g_HerobtJob = 1) then
      begin
        g_WgInfo.boHeroAutoMagic := CheckBoxWizardShield.Checked;
        Frmmain.SendHeroFun(Integer(g_WgInfo.boHeroAutoMagic), 0);
      end;
    end
    else
      {if Sender=CheckBoxTaosHeroMob then begin
        if (g_HeronRecogId<>0) and (g_HerobtJob=2) then begin
          g_WgInfo.boHeroAutoMagic:=CheckBoxTaosHeroMob.Checked;
          Frmmain.SendHeroFun(Integer(g_WgInfo.boHeroAutoMagic),0);
        end;
      end else} if Sender = CheckBoxAutoDownHorse then
      begin
        g_WgInfo.boAutoDownHorse := CheckBoxAutoDownHorse.Checked;
      end
      else if Sender = AutoHp then
      begin
        g_WgInfo.boAutoHp := AutoHp.Checked;
        AutoHpCount.Enabled := not g_WgInfo.boAutoHp;
        AutoHpName.Enabled := not g_WgInfo.boAutoHp;
        AutoHpTick.Enabled := not g_WgInfo.boAutoHp;
        g_WgInfo.boAutoHpCount := Str_ToInt(AutoHpCount.Text, 100);
        g_WgInfo.boAutoHpName := AutoHpName.Text;
        g_WgInfo.boAutoHpTick := AutoHpTick.Value * 1000;
      end
      else if Sender = AutoCropsHp then
      begin
        g_WgInfo.boAutoCropsHp := AutoCropsHp.Checked;
        AutoCropsHpCount.Enabled := not g_WgInfo.boAutoCropsHp;
        AutoCropsHpName.Enabled := not g_WgInfo.boAutoCropsHp;
        AutoCropsHpTick.Enabled := not g_WgInfo.boAutoCropsHp;
        g_WgInfo.boAutoCropsHpCount := Str_ToInt(AutoCropsHpCount.Text, 100);
        g_WgInfo.boAutoCropsHpName := AutoCropsHpName.Text;
        g_WgInfo.boAutoCropsHpTick := AutoCropsHpTick.Value * 1000;
      end
      else if Sender = AutoMp then
      begin
        g_WgInfo.boAutoMp := AutoMp.Checked;
        AutoMpCount.Enabled := not g_WgInfo.boAutoMp;
        AutoMpName.Enabled := not g_WgInfo.boAutoMp;
        AutoMpTick.Enabled := not g_WgInfo.boAutoMp;
        g_WgInfo.boAutoMpCount := Str_ToInt(AutoMpCount.Text, 100);
        g_WgInfo.boAutoMpName := AutoMpName.Text;
        g_WgInfo.boAutoMpTick := AutoMpTick.Value * 1000;
      end
      else if Sender = AutoCropsMp then
      begin
        g_WgInfo.boAutoCropsMp := AutoCropsMp.Checked;
        AutoCropsMpCount.Enabled := not g_WgInfo.boAutoCropsMp;
        AutoCropsMpName.Enabled := not g_WgInfo.boAutoCropsMp;
        AutoCropsMpTick.Enabled := not g_WgInfo.boAutoCropsMp;
        g_WgInfo.boAutoCropsMpCount := Str_ToInt(AutoCropsMpCount.Text, 100);
        g_WgInfo.boAutoCropsMpName := AutoCropsMpName.Text;
        g_WgInfo.boAutoCropsMpTick := AutoCropsMpTick.Value * 1000;
      end
      else if Sender = AutoHpProtect then
      begin
        g_WgInfo.boAutoHpProtect := AutoHpProtect.Checked;
        AutoHpProtectCount.Enabled := not g_WgInfo.boAutoHpProtect;
        AutoHpProtectName.Enabled := not g_WgInfo.boAutoHpProtect;
        AutoHpOrotectTick.Enabled := not g_WgInfo.boAutoHpProtect;
        g_WgInfo.boAutoHpProtectCount := Str_ToInt(AutoHpProtectCount.Text,
          100);
        g_WgInfo.boAutoHpProtectName := AutoHpProtectName.Text;
        g_WgInfo.boAutoHpOrotectTick := AutoHpOrotectTick.Value * 1000;
      end
      else if Sender = CanAttack then
      begin
        g_WgInfo.boCanAttack := CanAttack.Checked;
        CanAttackTick.Enabled := not g_WgInfo.boCanAttack;
        g_WgInfo.dwCanAttackTick := Str_ToInt(CanAttackTick.Text, 200) * 1000;
      end
      else if Sender = CanDejiwonho then
      begin
        g_WgInfo.boCanDejiwonho := CanDejiwonho.Checked;
        CanDejiwonhoTick.Enabled := not g_WgInfo.boCanDejiwonho;
        g_WgInfo.dwCanDejiwonhoTick := Str_ToInt(CanDejiwonhoTick.Text, 200) *
          1000;
      end
      else if Sender = CanHolyShield then
      begin
        g_WgInfo.boCanHolyShield := CanHolyShield.Checked;
        CanHolyShieldTick.Enabled := not g_WgInfo.boCanHolyShield;
        g_WgInfo.dwCanHolyShieldTick := Str_ToInt(CanHolyShieldTick.Text, 200) *
          1000;
      end
      else if Sender = CanCloakClsT then
      begin
        g_WgInfo.boCanCloakCls := True;
      end
      else if Sender = CanCloakClsF then
      begin
        g_WgInfo.boCanCloakCls := False;
      end
      else if Sender = CanCloak then
      begin
        g_WgInfo.boCanCloak := CanCloak.Checked;
        CanCloakClsF.Enabled := not g_WgInfo.boCanCloak;
        CanCloakClsT.Enabled := not g_WgInfo.boCanCloak;
      end
      else if Sender = CanCrossingOver then
      begin
        g_WgInfo.boCanCrossingOver := CanCrossingOver.Checked;
      end
      else if Sender = CanAutoAmyounsul then
      begin
        g_WgInfo.boCanAutoAmyounsul := CanAutoAmyounsul.Checked;
        g_WgInfo.btCanAmyounsulCls := CanAmyounsulCls.ItemIndex;
        CanAmyounsulCls.Enabled := not g_WgInfo.boCanAutoAmyounsul;
      end
      else if Sender = CanAutoAddHp then
      begin
        g_WgInfo.boCanAutoAddHp := CanAutoAddHp.Checked;
        CanAutoAddHpCount.Enabled := not g_WgInfo.boCanAutoAddHp;
        CanAutoAddHpTick.Enabled := not g_WgInfo.boCanAutoAddHp;
        g_wgInfo.nCanAutoAddHpCount := Str_ToInt(CanAutoAddHpCount.Text, 200);
        g_wgInfo.dwCanAutoAddHpTick := CanAutoAddHpTick.Value * 1000;
      end
      else if Sender = CanShieldClsT then
      begin
        g_WgInfo.boCanShieldCls := True;
      end
      else if Sender = CanShieldClsF then
      begin
        g_WgInfo.boCanShieldCls := False;
      end
      else if Sender = CanShield then
      begin
        g_WgInfo.boCanShield := CanShield.Checked;
        CanShieldClsT.Enabled := not g_WgInfo.boCanShield;
        CanShieldClsF.Enabled := not g_WgInfo.boCanShield;
      end
      else if Sender = CanFirewind then
      begin
        g_WgInfo.boCanFirewind := CanFirewind.Checked;
      end
      else if Sender = CanLongHit then
      begin
        g_WgInfo.boCanLongHit := CanLongHit.Checked;
        //if g_WgInfo.boCanLongHit and (not g_boCanLongHit) and (g_MyMagic[12]<>nil) then
      end
      else if Sender = CanWideHit then
      begin
        g_WgInfo.boCanWideHit := CanWideHit.Checked;
        //if g_WgInfo.boCanWideHit and (not g_boCanWideHit) and (g_MyMagic[25]<>nil) then
      end
      else if Sender = CanCrsHit then
      begin
        g_WgInfo.boCanCrsHit := CanCrsHit.Checked;
      end
      else if Sender = CanLongSword then
      begin
        g_WgInfo.boCanLongSword := CanLongSword.Checked;
      end
      else if Sender = CanAutoFireHit then
      begin
        g_WgInfo.boCanAutoFireHit := CanAutoFireHit.Checked;
      end
      else if Sender = CanAutoLongFire then
      begin
        g_WgInfo.boCanAutoLongFire := CanAutoLongFire.Checked;
      end
      else if Sender = CanFireSide then
      begin
        g_WgInfo.boCanFireSide := CanFireSide.Checked;
      end
      else
        {if Sender=CanLeoShout then begin
          g_WgInfo.boCanLeoShout:=CanLeoShout.Checked;
        end else} if Sender = CloseShift then
        begin
          g_WgInfo.boCloseShift := CloseShift.Checked;
          if not g_WgInfo.boCloseShift then
            g_boShift := False;
        end
        else if Sender = FriendHit then
        begin
          g_WgInfo.boFriendHit := FriendHit.Checked;
        end
        else if Sender = BlacklistHit then
        begin
          g_WgInfo.boBlacklistHit := BlacklistHit.Checked;
        end
        else if Sender = BlackListSys then
        begin
          g_WgInfo.boBlackListSys := BlackListSys.Checked;
        end
        else if Sender = ClearMapDieActor then
        begin
          g_WgInfo.boClearMapDieActor := ClearMapDieActor.Checked;
          ClearMapDieActorTime.Enabled := not g_WgInfo.boClearMapDieActor;
          g_WgInfo.nClearMapDieActorTime := ClearMapDieActorTime.Value * 1000;
        end
        else if Sender = ShowRedHPLable then
        begin
          g_WgInfo.boShowRedHPLable := ShowRedHPLable.Checked;
        end
        else if Sender = ShowHPNumber then
        begin
          g_WgInfo.boShowHPNumber := ShowHPNumber.Checked;
        end
        else if Sender = ShowBlueMpLable then
        begin
          g_WgInfo.boShowBlueMpLable := ShowBlueMpLable.Checked;
        end
        else if Sender = MagicLock then
        begin
          g_WgInfo.boMagicLock := MagicLock.Checked;
          if g_WgInfo.boMagicLock then
          begin
            MagicFixupLockF.Enabled := False;
            MagicFixupLockT.Enabled := False;
          end
          else
          begin
            MagicFixupLockF.Enabled := True;
            MagicFixupLockT.Enabled := True;
          end;
        end
        else if Sender = AutoPuckUpItem then
        begin
          g_WgInfo.boAutoPuckUpItem := AutoPuckUpItem.Checked;
        end
        else if Sender = MoveRedShow then
        begin
          g_WgInfo.boMoveRedShow := MoveRedShow.Checked;
        end
        else if Sender = ShowAllItem then
        begin
          g_WgInfo.boShowAllItem := ShowAllItem.Checked;
        end
        else if Sender = CanRunHuman then
        begin
          g_WgInfo.boCanRunHuman := CanRunHuman.Checked;
        end
        else if Sender = CanRunMon then
        begin
          g_WgInfo.boCanRunMon := CanRunMon.Checked;
        end
        else if Sender = CanRunNpc then
        begin
          g_WgInfo.boCanRunNpc := CanRunNpc.Checked;
        end
        else if Sender = ShowTopInfo then
        begin
          g_WgInfo.boShowTopInfo := ShowTopInfo.Checked;
        end
        else if Sender = MagicFixupLockF then
        begin
          g_WgInfo.boMagicFixupLock := False;
        end
        else if Sender = MagicFixupLockT then
        begin
          g_WgInfo.boMagicFixupLock := True;
        end
        else if Sender = ShowDura then
        begin
          g_WgInfo.boShowDura := ShowDura.Checked;
        end
        else if Sender = DuraAlert then
        begin
          g_WgInfo.boDuraAlert := DuraAlert.Checked;
        end
        else if Sender = ShowName then
        begin
          g_WgInfo.boShowName := ShowName.Checked;
        end
        else if Sender = ShowAllName then
        begin
          g_WgInfo.boShowAllName := ShowAllName.Checked;
        end
        else if Sender = AutoMagic then
        begin
          g_WgInfo.boAutoMagic := AutoMagic.Checked;
          g_wgInfo.nAutoMagicIdx := AutoMagicIdx.ItemIndex;
          g_wgInfo.nAutoMagicTime := AutoMagicTime.Value * 1000;
          g_dwAutoMagicTick := GetTickCount;
          if g_WgInfo.boAutoMagic then
          begin
            AutoMagicIdx.Enabled := False;
            AutoMagicTime.Enabled := False;
          end
          else
          begin
            AutoMagicIdx.Enabled := True;
            AutoMagicTime.Enabled := True;
          end;
        end
        else if Sender = DelItem then
        begin
          if (ItemList.ItemIndex >= 0) and (ItemList.ItemIndex <
            g_ItemFiltrateList.Count) then
          begin
            ItemFiltrate := g_ItemFiltrateList.Items[ItemList.ItemIndex];
            ItemFiltrate.boItemShow := False;
            ItemFiltrate.boItemPick := False;
            ItemFiltrate.boItemCorps := False;
            ItemFiltrate.boItemHit := False;
            ChangeShowItem(ItemFiltrate.sItemName);
            Dispose(ItemFiltrate);
            g_ItemFiltrateList.Delete(ItemList.ItemIndex);
            ItemList.Items.Delete(ItemList.ItemIndex);
          end;
        end
        else if Sender = AddItem then
        begin
          if ItemName.Text <> '' then
          begin
            for I := 0 to ItemList.Items.Count - 1 do
            begin
              Item := ItemList.Items[I];
              if CompareText(Trim(ItemName.Text), Item.Caption) = 0 then
              begin
                ItemList.ItemIndex := I;
                exit;
              end;
            end;
            New(ItemFiltrate);
            FillChar(ItemFiltrate^, SizeOf(TItemFiltrate), #0);
            g_ItemFiltrateList.Add(ItemFiltrate);
            ItemFiltrate.sItemName := Trim(ItemName.Text);
            Item := ItemList.Items.Add;
            Item.Caption := ItemFiltrate.sItemName;
            for I := 0 to 3 do
              Item.SubItems.Add(' ');
          end;
        end
        else if Sender = AttackEffect then
        begin
          g_WgInfo.boAttackEffect := AttackEffect.Checked;
          if g_WgInfo.boAttackEffect then
          begin
            AttackEffectClsF.Enabled := False;
            AttackEffectClsT.Enabled := False;
          end
          else
          begin
            AttackEffectClsF.Enabled := True;
            AttackEffectClsT.Enabled := True;
          end;
        end
        else if Sender = AttackEffectClsF then
        begin
          g_WgInfo.boAttackEffectCls := False;
        end
        else if Sender = AttackEffectClsT then
        begin
          g_WgInfo.boAttackEffectCls := True;
        end
        else if Sender = AutoPuckItemFil then
        begin
          g_WgInfo.boAutoPuckItemFil := AutoPuckItemFil.Checked;
        end
        else if Sender = ShowAllItemFil then
        begin
          g_WgInfo.boShowAllItemFil := ShowAllItemFil.Checked;
        end
        else if Sender = CropsItemShow then
        begin
          g_WgInfo.boCropsItemShow := CropsItemShow.Checked;
        end
        else if Sender = CropsItemHit then
        begin
          g_WgInfo.boCropsItemHit := CropsItemHit.Checked;
        end
     {
        else if Sender = DelOpenItem then
        begin
          if (OpenItemList.ItemIndex >= 0) and (OpenItemList.ItemIndex <
            g_OpenItemList.Count) then
          begin
            OpenItem := g_OpenItemList.Items[OpenItemList.ItemIndex];
            Dispose(OpenItem);
            g_OpenItemList.Delete(OpenItemList.ItemIndex);
            OpenItemList.Items.Delete(OpenItemList.ItemIndex);
          end;
        end
        else if Sender = AddOpenItem then
        begin
          if (OpenItemName.Text <> '') and (OpenBItemName.Text <> '') then
          begin
            for I := 0 to OpenItemList.Items.Count - 1 do
            begin
              Item := OpenItemList.Items[I];
              if CompareText(Trim(OpenItemName.Text), Item.Caption) = 0 then
              begin
                OpenItemList.ItemIndex := I;
                exit;
              end;
            end;
            New(OpenItem);
            OpenItem.sItemName := Trim(OpenItemName.Text);
            OpenItem.sBItemName := Trim(OpenBItemName.Text);
            OpenItem.sHitTime := 0;
            g_OpenItemList.Add(OpenItem);
            Item := OpenItemList.Items.Add;
            Item.Caption := OpenItem.sItemName;
            Item.SubItems.Add(OpenItem.sBItemName);
          end;
        end
        }
        else if Sender = AutoDownDrup then
        begin
          g_WgInfo.boAutoDownDrup := AutoDownDrup.Checked;
        end
        else if Sender = AutoOpenItem then
        begin
          g_WgInfo.boAutoOpenItem := AutoOpenItem.Checked;
        end
        else if Sender = MoveSlow then
        begin
          g_WgInfo.boMoveSlow := MoveSlow.Checked;
        end
        else if Sender = ShowGroupMember then
        begin
          g_WgInfo.boShowGroupMember := ShowGroupMember.Checked;
        end
        else if Sender = ParalyCan then
        begin
          g_WgInfo.boParalyCan := ParalyCan.Checked;
        end
        else if Sender = CropsMonHit then
        begin
          g_WgInfo.boCropsMonHit := CropsMonHit.Checked;
        end
        else if Sender = CropsAutoLock then
        begin
          g_WgInfo.boCropsAutoLock := CropsAutoLock.Checked;
        end
        else if Sender = CropsChangeColor then
        begin
          g_WgInfo.boCropsChangeColor := CropsChangeColor.Checked;
          CropsColorEff.Enabled := not g_WgInfo.boCropsChangeColor;
        end
        else if Sender = AddCropsMon then
        begin
          if Trim(EditCrops.Text) <> '' then
          begin
            i := CropsMonList.Items.IndexOf(Trim(EditCrops.Text));
            if I = -1 then
            begin
              CropsMonList.Items.Add(Trim(EditCrops.Text));
              g_CorpsMonList.Add(Trim(EditCrops.Text));
              ChangeMonShow(Trim(EditCrops.Text), True);
            end
            else
              CropsMonList.ItemIndex := I;
          end;
        end
        else if Sender = DelCropsMon then
        begin
          if CropsMonList.ItemIndex >= 0 then
          begin
            ChangeMonShow(g_CorpsMonList.Strings[CropsMonList.ItemIndex],
              False);
            CropsMonList.Items.Delete(CropsMonList.ItemIndex);
            g_CorpsMonList.Delete(CropsMonList.ItemIndex);
          end;
        end
        else if Sender = CropsColorEff then
        begin
          g_WgInfo.nCropsColorEff := CropsColorEff.ItemIndex + 1;
        end
        else
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.ShowRedHPLableClick');
      //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.EntironmentTimerTimer(Sender: TObject);
var
  I: integer;
  actor: TActor;
  Item: TListItem;
begin
  try //程序自动增加
    if PageControl1.TabIndex <> 4 then
      exit;
    if not FormWgMain.Visible then
      exit;
    EntironmentList.Items.Clear;
    for I := 0 to PlayScene.m_ActorList.Count - 1 do
    begin
      actor := TActor(PlayScene.m_ActorList.Items[I]);
      if (actor <> nil) and
        (actor <> g_MySelf) and
        (not actor.m_boDeath) then
      begin
        if EntironmentClass.ItemIndex <> 0 then
        begin
          if (Actor.m_btRace = RCC_USERHUMAN) and (EntironmentClass.ItemIndex <>
            1) then
            Continue;
          if (Actor.m_btRace = RCC_MERCHANT) and (EntironmentClass.ItemIndex <>
            2) then
            Continue;
          if ((Actor.m_btRace > RCC_USERHUMAN) and (Actor.m_btRace <>
            RCC_MERCHANT)) and (EntironmentClass.ItemIndex <> 3) then
            Continue;
        end;
        Item := EntironmentList.Items.Add;
        Item.Caption := actor.m_sUserName;
        Item.SubItems.Add(WayTag[GetNextDirection(g_MySelf.m_nCurrX,
          g_MySelf.m_nCurrY, actor.m_nCurrX, actor.m_nCurrY)]);
        Item.SubItems.Add(Format('%d:%d', [actor.m_nCurrX, actor.m_nCurrY]));
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.EntironmentTimerTimer');
      //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.ShowEntironmentClick(Sender: TObject);
begin
  try //程序自动增加
    EntironmentTimer.Enabled := ShowEntironment.Checked;
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.ShowEntironmentClick');
      //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.ItemListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Item: TListItem;
  ItemFiltrate: pTItemFiltrate;
begin
  try //程序自动增加
    if (ItemList.ItemIndex >= 0) and (ItemList.ItemIndex <=
      g_ItemFiltrateList.Count) then
    begin
      ItemFiltrate := g_ItemFiltrateList.Items[ItemList.ItemIndex];
      Item := ItemList.Items[ItemList.ItemIndex];
      if (X > 91) and (X < 117) then
        ItemFiltrate.boItemShow := not ItemFiltrate.boItemShow;
      if (X > 122) and (X < 148) then
        ItemFiltrate.boItemPick := not ItemFiltrate.boItemPick;
      if (X > 152) and (X < 180) then
        ItemFiltrate.boItemCorps := not ItemFiltrate.boItemCorps;
      if (X > 182) and (X < 208) then
        ItemFiltrate.boItemHit := not ItemFiltrate.boItemHit;
      if ItemFiltrate.boItemShow then
        Item.SubItems.Strings[0] := '√'
      else
        Item.SubItems.Strings[0] := ' ';
      if ItemFiltrate.boItemPick then
        Item.SubItems.Strings[1] := '√'
      else
        Item.SubItems.Strings[1] := ' ';
      if ItemFiltrate.boItemCorps then
        Item.SubItems.Strings[2] := '√'
      else
        Item.SubItems.Strings[2] := ' ';
      if ItemFiltrate.boItemHit then
        Item.SubItems.Strings[3] := '√'
      else
        Item.SubItems.Strings[3] := ' ';
      ChangeShowItem(ItemFiltrate.sItemName);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.ItemListMouseDown');
      //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.EditRedMsgFColorChange(Sender: TObject);
begin
  try //程序自动增加
    if Sender = EditRedMsgFColor then
    begin
      ShowCropsColor.Color := GetRGB(EditRedMsgFColor.Value);
      g_wgInfo.coShowCropsColor := EditRedMsgFColor.Value;
    end
    else
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.EditRedMsgFColorChange');
      //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.Timer1Timer(Sender: TObject);
resourcestring
  sTest = '你的[%s]已经用完。';
var
  //  I:Integer;            fd
  II: integer;
  nShift: TShiftState;
  nKey: Word;
begin
  try //程序自动增加
    if g_MySelf = nil then
      exit;

    //自动保护
    if (g_WgInfo.boAutoHpProtect) and
      (g_MySelf.m_Abil.HP < g_WgInfo.boAutoHpProtectCount) and
      ((GetTickCount - g_dwAutoHpOrotectTick) > g_wgInfo.boAutoHpOrotectTick)
        then
    begin
      g_dwAutoHpOrotectTick := GetTickCount;
      II := GetItembyName(g_wgInfo.boAutoHpProtectName);
      if II > -1 then
        FrmMain.EatItem(II)
      else
      begin
        pAutoOpenItem(g_wgInfo.boAutoHpProtectName);
        II := GetItembyName(g_wgInfo.boAutoHpProtectName);
        if II > -1 then
          FrmMain.EatItem(II)
        else
          DScreen.AddHitMsg(Format(sTest, [g_wgInfo.boAutoHpProtectName]));
      end;
    end;
    //自动补红
    if (g_WgInfo.boAutoHp) and
      (g_MySelf.m_Abil.HP < g_WgInfo.boAutoHpCount) and
      ((GetTickCount - g_dwAutoHpTick) > g_wgInfo.boAutoHpTick) then
    begin
      g_dwAutoHpTick := GetTickCount;
      II := GetItembyName(g_wgInfo.boAutoHpName);
      if II > -1 then
        FrmMain.EatItem(II)
      else
      begin
        pAutoOpenItem(g_wgInfo.boAutoHpName);
        II := GetItembyName(g_wgInfo.boAutoHpName);
        if II > -1 then
          FrmMain.EatItem(II)
        else
          DScreen.AddHitMsg(Format(sTest, [g_wgInfo.boAutoHpName]));
      end;
    end;
    //自动补红2
    if (g_WgInfo.boAutoCropsHp) and
      (g_MySelf.m_Abil.HP < g_WgInfo.boAutoCropsHpCount) and
      ((GetTickCount - g_dwAutoCropsHpTick) > g_wgInfo.boAutoCropsHpTick) then
    begin
      g_dwAutoCropsHpTick := GetTickCount;
      II := GetItembyName(g_wgInfo.boAutoCropsHpName);
      if II > -1 then
        FrmMain.EatItem(II)
      else
      begin
        pAutoOpenItem(g_wgInfo.boAutoCropsHpName);
        II := GetItembyName(g_wgInfo.boAutoCropsHpName);
        if II > -1 then
          FrmMain.EatItem(II)
        else
          DScreen.AddHitMsg(Format(sTest, [g_wgInfo.boAutoCropsHpName]));
      end;
    end;
    //自动补蓝
    if (g_WgInfo.boAutoMp) and
      (g_MySelf.m_Abil.MP < g_WgInfo.boAutoMpCount) and
      ((GetTickCount - g_dwAutoMpTick) > g_wgInfo.boAutoMpTick) then
    begin
      g_dwAutoMpTick := GetTickCount;
      II := GetItembyName(g_wgInfo.boAutoMpName);
      if II > -1 then
        FrmMain.EatItem(II)
      else
      begin
        pAutoOpenItem(g_wgInfo.boAutoMpName);
        II := GetItembyName(g_wgInfo.boAutoMpName);
        if II > -1 then
          FrmMain.EatItem(II)
        else
          DScreen.AddHitMsg(Format(sTest, [g_wgInfo.boAutoMpName]));
      end;
    end;
    //自动补蓝2
    if (g_WgInfo.boAutoCropsMp) and
      (g_MySelf.m_Abil.MP < g_WgInfo.boAutoCropsMpCount) and
      ((GetTickCount - g_dwAutoCropsMpTick) > g_wgInfo.boAutoCropsMpTick) then
    begin
      g_dwAutoCropsMpTick := GetTickCount;
      II := GetItembyName(g_wgInfo.boAutoCropsMpName);
      if II > -1 then
        FrmMain.EatItem(II)
      else
      begin
        pAutoOpenItem(g_wgInfo.boAutoCropsMpName);
        II := GetItembyName(g_wgInfo.boAutoCropsMpName);
        if II > -1 then
          FrmMain.EatItem(II)
        else
          DScreen.AddHitMsg(Format(sTest, [g_wgInfo.boAutoCropsMpName]));
      end;
    end;

    //自动开天斩
    if (g_WgInfo.boCanLongSword) and
      (not g_MySelf.m_boIsShop) and
      (g_MySelf.m_btHorse = 0) and
      ((not g_boCanLswHit) and (not g_boCanLawHit)) and
      (g_MyMagic[43] <> nil) then
    begin
      if g_dwLongSwordTick = 0 then
        g_dwLongSwordTick := GetTickCount;
      if (GetTickCount - g_dwLongSwordTick) > 20000 then
      begin
        FrmMain.SendSpellMsg(CM_SPELL, g_MySelf.m_btDir, 0, 43, 0);
        g_dwLongSwordTick := 0;
      end;
    end;

     //自动逐日剑法
    if (g_WgInfo.boCanAutoLongFire) and
      (not g_MySelf.m_boIsShop) and
      (g_MySelf.m_btHorse = 0) and
      (not g_boNextTimeFireHit) and
      (g_MyMagic[73] <> nil) then
    begin
      if g_dwLongFireTick = 0 then
        g_dwLongFireTick := GetTickCount;
      if (GetTickCount - g_dwLongFireTick) > 10000 then
      begin
        FrmMain.SendSpellMsg(CM_SPELL, g_MySelf.m_btDir, 0, 73, 0);
        g_dwLongFireTick := 0;
      end;
    end;

    //道士自动补血
    if (g_wgInfo.boCanAutoAddHp) and
      (not g_MySelf.m_boIsShop) and
      (g_MySelf.m_btHorse = 0) and
      (g_MySelf.m_Abil.HP <= g_wgInfo.nCanAutoAddHpCount) and
      (g_MySelf.m_Abil.MP > 10) and
      (g_MyMagic[2] <> nil) and
      ((GetTickCount - g_dwCanAutoAddHpTime) > g_wgInfo.dwCanAutoAddHpTick) and
      ((GetTickCount - g_dwLatestSpellTick) > g_dwSpellTime) then
    begin
      g_dwCanAutoAddHpTime := GetTickCount;
      g_dwLatestSpellTick := GetTickCount;
      g_dwMagicDelayTime := 0;
      FrmMain.UseMagic(g_nMouseX, g_nMouseY, g_MyMagic[2], True);
    end;

    //持续加防
    if (g_WgInfo.boCanHolyShield) and
      (not g_MySelf.m_boIsShop) and
      (g_MySelf.m_btHorse = 0) and
      (g_MySelf.m_Abil.MP > 10) and
      (g_MyMagic[15] <> nil) and
      (GetTickCount - g_dwCanHolyShieldTime > g_wgInfo.dwCanHolyShieldTick) and
      (GetTickCount - g_dwLatestSpellTick > g_dwSpellTime) then
    begin
      g_dwCanHolyShieldTime := GetTickCount;
      g_dwLatestSpellTick := GetTickCount;
      g_dwMagicDelayTime := 0;
      FrmMain.UseMagic(g_nMouseX, g_nMouseY, g_MyMagic[15], True);
    end;
    //持续加魔
    if (g_WgInfo.boCanDejiwonho) and
      (not g_MySelf.m_boIsShop) and
      (g_MySelf.m_btHorse = 0) and
      (g_MySelf.m_Abil.MP > 10) and
      (g_MyMagic[14] <> nil) and
      (GetTickCount - g_dwCanDejiwonhoTime > g_wgInfo.dwCanDejiwonhoTick) and
      (GetTickCount - g_dwLatestSpellTick > g_dwSpellTime) then
    begin
      g_dwCanDejiwonhoTime := GetTickCount;
      g_dwLatestSpellTick := GetTickCount;
      g_dwMagicDelayTime := 0;
      FrmMain.UseMagic(g_nMouseX, g_nMouseY, g_MyMagic[14], True);
    end;
    //持续加攻
    if (g_WgInfo.boCanAttack) and
      (not g_MySelf.m_boIsShop) and
      (g_MySelf.m_btHorse = 0) and
      (g_MySelf.m_Abil.MP > 10) and
      (g_MyMagic[52] <> nil) and
      (GetTickCount - g_dwCanAttackTime > g_wgInfo.dwCanAttackTick) and
      (GetTickCount - g_dwLatestSpellTick > g_dwSpellTime) then
    begin
      g_dwCanAttackTime := GetTickCount;
      g_dwLatestSpellTick := GetTickCount;
      g_dwMagicDelayTime := 0;
      FrmMain.UseMagic(g_nMouseX, g_nMouseY, g_MyMagic[52], True);
    end;
    //自动练功
    try
      if (g_wginfo.boAutoMagic) and
        (g_ClientWgInfo.boAutoMagic) and
        (g_MySelf <> nil) and
        (g_WgInfo.nAutoMagicIdx in [0..15]) and
        (g_MySelf.m_Abil.MP > 10) and
        ((GetTickCount - g_dwAutoMagicTick) > g_wgInfo.nAutoMagicTime) then
      begin
        g_dwAutoMagicTick := GetTickCount;
        if g_WgInfo.nAutoMagicIdx > 7 then
          nShift := [ssCtrl]
        else
          nShift := [];
        case g_WgInfo.nAutoMagicIdx of
          0, 8: nKey := VK_F1;
          1, 9: nKey := VK_F2;
          2, 10: nKey := VK_F3;
          3, 11: nKey := VK_F4;
          4, 12: nKey := VK_F5;
          5, 13: nKey := VK_F6;
          6, 14: nKey := VK_F7;
          7, 15: nKey := VK_F8;
        end;
        FormKeyDown(nil, nKey, nShift);
      end;
    except
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.Timer1Timer'); //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.HitTimeChange(Sender: TObject);
begin
  try //程序自动增加
    if Sender = HitTime then
    begin
      LabelHitTime.Caption := IntToStr(HitTime.Position);
      g_WgInfo.nHitTime := HitTime.Position;
      g_nHitTime := _MAX(0, 1400 - g_WgInfo.nHitTime * 140);
    end
    else if Sender = SpellTime then
    begin
      LabelSpellTime.Caption := IntToStr(SpellTime.Position);
      g_WgInfo.nSpellTime := SpellTime.Position;
      g_dwSpellTime := _MAX(0, 800 - g_WgInfo.nSpellTime * 100);
    end
    else if Sender = MoveTime then
    begin
      LabelMoveTime.Caption := IntToStr(MoveTime.Position);
      g_WgInfo.nMoveTime := MoveTime.Position;
      g_dwMoveTime := _MAX(0, 100 - g_WgInfo.nMoveTime * 10);
    end
    else
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.HitTimeChange'); //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.Button1Click(Sender: TObject);
begin
  try //程序自动增加
    if ComboBox1.ItemIndex >= 0 then
      FrmMain.SendSay('@' + ComboBox1.Items[ComboBox1.ItemIndex]);
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.Button1Click'); //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.CheckBoxOpenMsgClick(Sender: TObject);
begin
  try //程序自动增加
    if Trim(EditSysMsg.Text) <> '' then
    begin
      g_AutoSysMsg := CheckBoxOpenMsg.Checked;
      g_AutoMsgTick := GetTickCount;
      g_AutoMsg := EditSysMsg.Text;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.CheckBoxOpenMsgClick');
      //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  try //程序自动增加
    case Word(Key) of
      VK_F12, VK_HOME:
        begin
          Visible := not Visible;
        end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.FormKeyDown'); //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.RadioSkeletonClick(Sender: TObject);
begin
  try //程序自动增加
    g_WgInfo.boHeroCallBoneFamm := CheckBoxHeroCallBoneFamm.Checked;
    g_WgInfo.boHeroCallDogz := CheckBoxHeroCallDogz.Checked;
    g_WgInfo.boHeroCallFairy := CheckBoxHeroCallFairy.Checked;
    {if RadioSkeleton.Checked then g_wgInfo.btHeroCallMobClass:=0;
    if RadioDragon.Checked then g_wgInfo.btHeroCallMobClass:=1;
    if RadioFairy.Checked then g_wgInfo.btHeroCallMobClass:=2;}
    Frmmain.SendHeroMob();
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.RadioSkeletonClick');
      //程序自动增加
  end; //程序自动增加
end;

procedure TFormWgMain.CheckBoxBGSoundClick(Sender: TObject);
begin
  try //程序自动增加
    g_boBGSound := CheckBoxBGSound.Checked;
    PlayBgMusic(g_sBgMusic, g_boBGSound, True);
  except //程序自动增加
    DebugOutStr('[Exception] TFormWgMain.CheckBoxBGSoundClick');
      //程序自动增加
  end; //程序自动增加
end;

initialization
  begin
    FillChar(g_WgItemArr, SizeOf(TClientItem) * 6, #0);
    g_HumList := TList.Create;
  end;

finalization
  begin
    g_HumList.Free;
  end;

end.

