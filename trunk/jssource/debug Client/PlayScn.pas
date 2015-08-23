//CHECK
//��Ҫɾ����һ��ע�ͣ���ע��Ϊ�����ļ��Ƿ��ѱ��Զ������쳣����
unit PlayScn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXDraws, DXClass, DirectX, IntroScn, Grobal2, CliUtil, HUtil32, Actor,
  HerbActor, AxeMon, SoundUtil, ClEvent, Wil, StdCtrls, clFunc, magiceff,
  extctrls, MShare, Share, WShare, AxeMon2;

const
  //   MAPSURFACEWIDTH = 800;
  //   MAPSURFACEHEIGHT = 445;

  LONGHEIGHT_IMAGE = 35;
  FLASHBASE = 410;
  AAX = 16;
  SOFFX = 0;
  SOFFY = 0;
  LMX = 30;
  LMY = 26;

  MAXLIGHT = 5;
  LightFiles: array[0..MAXLIGHT] of string = (
    'Data\lig0a.dat',
    'Data\lig0b.dat',
    'Data\lig0c.dat',
    'Data\lig0d.dat',
    'Data\lig0e.dat',
    'Data\lig0f.dat'
    );

  LightMask0: array[0..2, 0..2] of shortint = (
    (0, 1, 0),
    (1, 3, 1),
    (0, 1, 0)
    );
  LightMask1: array[0..4, 0..4] of shortint = (
    (0, 1, 1, 1, 0),
    (1, 1, 3, 1, 1),
    (1, 3, 4, 3, 1),
    (1, 1, 3, 1, 1),
    (0, 1, 2, 1, 0)
    );
  LightMask2: array[0..8, 0..8] of shortint = (
    (0, 0, 0, 1, 1, 1, 0, 0, 0),
    (0, 0, 1, 2, 3, 2, 1, 0, 0),
    (0, 1, 2, 3, 4, 3, 2, 1, 0),
    (1, 2, 3, 4, 4, 4, 3, 2, 1),
    (1, 3, 4, 4, 4, 4, 4, 3, 1),
    (1, 2, 3, 4, 4, 4, 3, 2, 1),
    (0, 1, 2, 3, 4, 3, 2, 1, 0),
    (0, 0, 1, 2, 3, 2, 1, 0, 0),
    (0, 0, 0, 1, 1, 1, 0, 0, 0)
    );
  LightMask3: array[0..10, 0..10] of shortint = (
    (0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0),
    (0, 0, 0, 1, 2, 2, 2, 1, 0, 0, 0),
    (0, 0, 1, 2, 3, 3, 3, 2, 1, 0, 0),
    (0, 1, 2, 3, 4, 4, 4, 3, 2, 1, 0),
    (1, 2, 3, 4, 4, 4, 4, 4, 3, 2, 1),
    (2, 3, 4, 4, 4, 4, 4, 4, 4, 3, 2),
    (1, 2, 3, 4, 4, 4, 4, 4, 3, 2, 1),
    (0, 1, 2, 3, 4, 4, 4, 3, 2, 1, 0),
    (0, 0, 1, 2, 3, 3, 3, 2, 1, 0, 0),
    (0, 0, 0, 1, 2, 2, 2, 1, 0, 0, 0),
    (0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0)
    );

  LightMask4: array[0..14, 0..14] of shortint = (
    (0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 1, 1, 2, 2, 2, 1, 1, 0, 0, 0, 0),
    (0, 0, 0, 1, 1, 2, 3, 3, 3, 2, 1, 1, 0, 0, 0),
    (0, 0, 1, 1, 2, 3, 4, 4, 4, 3, 2, 1, 1, 0, 0),
    (0, 1, 1, 2, 3, 4, 4, 4, 4, 4, 3, 2, 1, 1, 0),
    (1, 1, 2, 3, 4, 4, 4, 4, 4, 4, 4, 3, 2, 1, 1),
    (1, 2, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 2, 1),
    (1, 1, 2, 3, 4, 4, 4, 4, 4, 4, 4, 3, 2, 1, 1),
    (0, 1, 1, 2, 3, 4, 4, 4, 4, 4, 3, 2, 1, 1, 0),
    (0, 0, 1, 1, 2, 3, 4, 4, 4, 3, 2, 1, 1, 0, 0),
    (0, 0, 0, 1, 1, 2, 3, 3, 3, 2, 1, 1, 0, 0, 0),
    (0, 0, 0, 0, 1, 1, 2, 2, 2, 1, 1, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0)
    );

  LightMask5: array[0..16, 0..16] of shortint = (
    (0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 1, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 1, 2, 4, 4, 4, 2, 1, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 1, 2, 4, 4, 4, 4, 4, 2, 1, 0, 0, 0, 0),
    (0, 0, 0, 1, 2, 4, 4, 4, 4, 4, 4, 4, 2, 1, 0, 0, 0),
    (0, 0, 1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 1, 0, 0),
    (0, 1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 1, 0),
    (1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 1),
    (1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 1),
    (1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 1),
    (0, 1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 1, 0),
    (0, 0, 1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 1, 0, 0),
    (0, 0, 0, 1, 2, 4, 4, 4, 4, 4, 4, 4, 2, 1, 0, 0, 0),
    (0, 0, 0, 0, 1, 2, 4, 4, 4, 4, 4, 2, 1, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 1, 2, 4, 4, 4, 2, 1, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 1, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0)
    { (0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0),
     (0,0,0,0,0,0,0,1,2,2,2,1,0,0,0,0,0,0,0),
     (0,0,0,0,0,0,1,2,4,4,4,2,1,0,0,0,0,0,0),
     (0,0,0,0,0,1,2,4,4,4,4,4,2,1,0,0,0,0,0),
     (0,0,0,0,1,2,4,4,4,4,4,4,4,2,1,0,0,0,0),
     (0,0,0,1,2,4,4,4,4,4,4,4,4,4,2,1,0,0,0),
     (0,0,1,2,4,4,4,4,4,4,4,4,4,4,4,2,1,0,0),
     (0,1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1,0),
     (1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1),
     (1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1),
     (1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1),
     (0,1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1,0),
     (0,0,1,2,4,4,4,4,4,4,4,4,4,4,4,2,1,0,0),
     (0,0,0,1,2,4,4,4,4,4,4,4,4,4,2,1,0,0,0),
     (0,0,0,0,1,2,4,4,4,4,4,4,4,2,1,0,0,0,0),
     (0,0,0,0,0,1,2,4,4,4,4,4,2,1,0,0,0,0,0),
     (0,0,0,0,0,0,1,2,4,4,4,2,1,0,0,0,0,0,0),
     (0,0,0,0,0,0,0,1,2,2,2,1,0,0,0,0,0,0,0),
     (0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0) }
    );

type
  PShoftInt = ^ShortInt;
  TLightEffect = record
    Width: integer;
    Height: integer;
    PFog: Pbyte;
  end;
  TLightMapInfo = record
    ShiftX: integer;
    ShiftY: integer;
    light: integer;
    bright: integer;
  end;

  TPlayScene = class(TScene)
  private
    m_MapSurface: TDirectDrawSurface;
    //     m_ItemSurface   :TDirectDrawSurface;
    m_ObjSurface: TDirectDrawSurface; //0x0C

    m_FogScreen: array[0..MAPSURFACEHEIGHT, 0..MAPSURFACEWIDTH] of byte;
    m_PFogScreen: PByte;
    m_nFogWidth: Integer;
    m_nFogHeight: Integer;
    m_Lights: array[0..MAXLIGHT] of TLightEffect;
    m_dwMoveTime: LongWord;
    m_nMoveStepCount: Integer;
    m_dwAniTime: LongWord;
    m_nAniCount: Integer;
    m_nDefXX: Integer;
    m_nDefYY: Integer;
    m_MainSoundTimer: TTimer;
    m_MsgList: TList;
    m_LightMap: array[0..LMX, 0..LMY] of TLightMapInfo;
    procedure DrawTileMap;
    procedure LoadFog;
    procedure ClearLightMap;
    procedure AddLight(x, y, shiftx, shifty, light: integer; nocheck: Boolean);
    procedure UpdateBright(x, y, light: integer);
    function CheckOverLight(x, y, light: integer): Boolean;
    procedure ApplyLightMap;
    procedure DrawLightEffect(lx, ly, bright: integer);
    procedure EdChatKeyPress(Sender: TObject; var Key: Char);
    procedure SoundOnTimer(Sender: TObject);
    function CrashManEx(mx, my: integer): Boolean;
    function CrashManEx2(mx, my: Integer): Boolean;
    procedure ClearDropItem();
  public
    EdChat: TEdit;
    MemoLog: TMemo;
    EdAccountt: TEdit; //2004/05/17
    EdChrNamet: TEdit; //2004/05/17
    {
    EdChgChrName: TEdit;
    EdChgCurPwd: TEdit;
    EdChgNewPwd: TEdit;
    EdChgRePwd: TEdit;
    }

    m_ActorList: TList;
    //     m_TempList         :TList;
    m_GroundEffectList: TList; //�ٴڿ� �򸮴� ���� ����Ʈ
    m_EffectList: TList; //����ȿ�� ����Ʈ
    m_FlyList: TList; //���ƴٴϴ� �� (��������, â, ȭ��)
    m_dwBlinkTime: LongWord;
    m_boViewBlink: Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure Initialize; override;
    procedure Finalize; override;
    procedure OpenScene; override;
    procedure CloseScene; override;
    procedure OpeningScene; override;
   // procedure DrawMiniMap(surface: TDirectDrawSurface);
    procedure PlayScene(MSurface: TDirectDrawSurface); override;
    function ButchAnimal(x, y: integer): TActor;

    function FindActor(id: integer): TActor; overload;
    function FindActor(sName: string): TActor; overload;
    function FindActorXY(x, y: integer): TActor;
    function FindActorXYCount(x, y, nFalg: integer; var HumList: TList):
      Boolean;
    function IsValidActor(actor: TActor): Boolean;
    function NewActor(chrid: integer; cx, cy, cdir: word; cfeature, cstate:
      integer): TActor;
    procedure ActorDied(actor: TObject); //���� actor�� �� ����
    procedure SetActorDrawLevel(actor: TObject; level: integer);
    procedure ClearActors;
    function DeleteActor(id: integer): TActor;
    procedure DelActor(actor: TObject);
    procedure SetEditChar(sMsg: string);
    procedure SendMsg(ident, chrid, x, y, cdir, feature, state: integer; str:
      string);

    procedure NewMagic(aowner: TActor;
      magid, magnumb, cx, cy, tx, ty, targetcode: integer;
      mtype: TMagicType;
      Recusion: Boolean;
      anitime: integer;
      var bofly: Boolean);
    procedure DelMagic(magid: integer);
    function NewFlyObject(aowner: TActor; cx, cy, tx, ty, targetcode: integer;
      mtype: TMagicType): TMagicEff;
    //function  NewStaticMagic (aowner: TActor; tx, ty, targetcode, effnum: integer);

    procedure ScreenXYfromMCXY(cx, cy: integer; var sx, sy: integer);
    procedure CXYfromMouseXY(mx, my: integer; var ccx, ccy: integer);
    function GetCharacter(x, y, wantsel: integer; var nowsel: integer; liveonly:
      Boolean): TActor;
    function GetAttackFocusCharacter(x, y, wantsel: integer; var nowsel:
      integer; liveonly: Boolean): TActor;
    function IsSelectMyself(x, y: integer): Boolean;
    function GetDropItems(x, y: integer; var inames: string): PTDropItem;
    function GetXYDropItems(nX, nY: Integer): pTDropItem;
    procedure GetXYDropItemsList(nX, nY: Integer; var ItemList: TList);
    function CanRun(sx, sy, ex, ey: integer): Boolean;
    function CanRunEx(sx, sy, ex, ey: Integer): Boolean; 
    function CanWalk(mx, my: integer): Boolean;
    function CanWalkEx(mx, my: integer): Boolean;
    function CanWalkEx2(mx, my: Integer): Boolean;
    function CrashMan(mx, my: integer): Boolean; //������� ��ġ�°�?
    function CanFly(mx, my: integer): Boolean;
    procedure RefreshScene;
    procedure CleanObjects;
  end;

implementation

uses
  ClMain, FState;

constructor TPlayScene.Create;
//var
//  nx,ny:Integer;
begin
  try //�����Զ�����
    m_MapSurface := nil;
    m_ObjSurface := nil;
    //m_ItemSurface:=Nil;
    m_MsgList := TList.Create;
    m_ActorList := TList.Create;
    //   m_TempList := TList.Create;
    m_GroundEffectList := TList.Create;
    m_EffectList := TList.Create;
    m_FlyList := TList.Create;
    m_dwBlinkTime := GetTickCount;
    m_boViewBlink := FALSE;

    EdChat := TEdit.Create(FrmMain.Owner);
    with EdChat do
    begin
      Parent := FrmMain;
      BorderStyle := bsNone;
      OnKeyPress := EdChatKeyPress;
      Visible := FALSE;
      MaxLength := 70;
      Ctl3D := FALSE;
      Left := 208;
      Top := SCREENHEIGHT - 19;
      Height := 12;
      Width := (SCREENWIDTH div 2 - 207) * 2 {387};
      Color := clSilver;
    end;
    MemoLog := TMemo.Create(FrmMain.Owner);
    with MemoLog do
    begin
      Parent := FrmMain;
      BorderStyle := bsNone;
      Visible := False;
      // Visible := True;
      Ctl3D := True;
      Left := 0;
      Top := 250;
      Width := 300;
      Height := 150;
    end;
    //2004/05/17
    EdAccountt := TEdit.Create(FrmMain.Owner);
    with EdAccountt do
    begin
      Parent := FrmMain;
      BorderStyle := bsSingle;
      Visible := False;
      MaxLength := 70;
      Ctl3D := True;
      Left := (SCREENWIDTH - 194) div 2;
      Top := SCREENHEIGHT - 200;
      Height := 12;
      Width := 194;
    end;
    //2004/05/17
    //2004/05/17
    EdChrNamet := TEdit.Create(FrmMain.Owner);
    with EdChrNamet do
    begin
      Parent := FrmMain;
      BorderStyle := bsSingle;
      Visible := False;
      MaxLength := 70;
      Ctl3D := True;
      Left := (SCREENWIDTH - 194) div 2;
      Top := SCREENHEIGHT - 176;
      Height := 12;
      Width := 194;
    end;
    //2004/05/17

    m_dwMoveTime := GetTickCount;
    m_dwAniTime := GetTickCount;
    m_nAniCount := 0;
    m_nMoveStepCount := 0;
    m_MainSoundTimer := TTimer.Create(FrmMain.Owner);
    with m_MainSoundTimer do
    begin
      OnTimer := SoundOnTimer;
      Interval := 1;
      Enabled := FALSE;
    end;
    {
    nx:=192;
    ny:=150;
    }
  //  nx := SCREENWIDTH div 2 - 210 {192}{192};
 //   ny := SCREENHEIGHT div 2 - 150{146}{150};
    {
    EdChgChrName := TEdit.Create (FrmMain.Owner);
    with EdChgChrName do begin
       Parent:=FrmMain;
       Height:=16;
       Width:=137;
       Left:=nx + 239;
       Top:=ny + 117;
       BorderStyle:=bsNone;
       Color:=clBlack;
       Font.Color:=clWhite;
       MaxLength:=10;
       Visible:=FALSE;
       //OnKeyPress:=EdNewIdKeyPress;
       //OnEnter:=EdNewOnEnter;
       Tag:=12;
    end;

    EdChgCurPwd := TEdit.Create (FrmMain.Owner);
    with EdChgCurPwd do begin
       Parent:=FrmMain;
       Height:=16;
       Width:=137;
       Left:=nx+239;
       Top:=ny+149;
       BorderStyle:=bsNone;
       Color:=clBlack;
       Font.Color:=clWhite;
       MaxLength:=10;
       PasswordChar:='*';
       Visible:=FALSE;
       //OnKeyPress:=EdNewIdKeyPress;
       //OnEnter:=EdNewOnEnter;
       Tag := 12;
    end;
    EdChgNewPwd := TEdit.Create (FrmMain.Owner);
    with EdChgNewPwd do begin
       Parent:=FrmMain;
       Height:=16;
       Width:=137;
       Left:=nx+239;
       Top:=ny+176;
       BorderStyle:=bsNone;
       Color:=clBlack;
       Font.Color:=clWhite;
       MaxLength:=10;
       PasswordChar:='*';
       Visible:=FALSE;
       //OnKeyPress:=EdNewIdKeyPress;
       //OnEnter:=EdNewOnEnter;
       Tag:=12;
    end;
    EdChgRePwd := TEdit.Create (FrmMain.Owner);
    with EdChgRePwd do begin
       Parent := FrmMain;
       Height := 16;
       Width  := 137;
       Left := nx+239;
       Top  := ny+208;
       BorderStyle := bsNone;
       Color := clBlack;
       Font.Color := clWhite;
       MaxLength := 10;
       PasswordChar := '*';
       Visible := FALSE;
       //OnKeyPress := EdNewIdKeyPress;
       //OnEnter := EdNewOnEnter;
       Tag := 12;
    end;
    }
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.Create'); //�����Զ�����
  end; //�����Զ�����
end;

destructor TPlayScene.Destroy;
begin
  try //�����Զ�����
    m_MsgList.Free;
    m_ActorList.Free;
    //   m_TempList.Free;
    m_GroundEffectList.Free;
    m_EffectList.Free;
    m_FlyList.Free;
    inherited Destroy;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.Destroy'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.SoundOnTimer(Sender: TObject);
begin
  try //�����Զ�����
    PlaySound(s_main_theme);
    m_MainSoundTimer.Interval := 46 * 1000;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.SoundOnTimer'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.EdChatKeyPress(Sender: TObject; var Key: Char);
begin
  try //�����Զ�����
    if Key = #13 then
    begin
      FrmMain.SendSay(EdChat.Text);
      EdChat.Text := '';
      EdChat.Visible := FALSE;
      Key := #0;
    end;
    if Key = #27 then
    begin
      EdChat.Text := '';
      EdChat.Visible := FALSE;
      Key := #0;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.EdChatKeyPress'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.Initialize;
var
  i: integer;
begin
  try //�����Զ�����
    m_MapSurface := TDirectDrawSurface.Create(frmMain.DxDraw.DDraw);
    m_MapSurface.SystemMemory := TRUE;
    m_MapSurface.SetSize(MAPSURFACEWIDTH + UNITX * 8 + 30, MAPSURFACEHEIGHT +
      UNITY * 8);
    m_ObjSurface := TDirectDrawSurface.Create(frmMain.DxDraw.DDraw);
    m_ObjSurface.SystemMemory := TRUE;
    m_ObjSurface.SetSize(MAPSURFACEWIDTH - SOFFX * 2, MAPSURFACEHEIGHT);
    {m_ItemSurface := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
    m_ItemSurface.SystemMemory := TRUE;
    m_ItemSurface.SetSize (MAPSURFACEWIDTH-SOFFX*2, MAPSURFACEHEIGHT);  }

    m_nFogWidth := MAPSURFACEWIDTH - SOFFX * 2;
    m_nFogHeight := MAPSURFACEHEIGHT;
    m_PFogScreen := @m_FogScreen;
    //PFogScreen := AllocMem (FogWidth * FogHeight);
    ZeroMemory(m_PFogScreen, MAPSURFACEHEIGHT * MAPSURFACEWIDTH);

    g_boViewFog := FALSE;
    for i := 0 to MAXLIGHT do
      m_Lights[i].PFog := nil;
    LoadFog;

  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.Initialize'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.Finalize;
begin
  try //�����Զ�����
    if m_MapSurface <> nil then
      m_MapSurface.Free;
    if m_ObjSurface <> nil then
      m_ObjSurface.Free;
    // if m_ItemSurface <> Nil then
    //    m_ItemSurface.Free;
    m_MapSurface := nil;
    m_ObjSurface := nil;
    // m_ItemSurface:= nil;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.Finalize'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.OpenScene;
begin
  try //�����Զ�����
    g_WMainImages.ClearCache; //�α��� �̹��� ĳ�ø� �����.
    FrmDlg.ViewBottomBox(TRUE);
    //EdChat.Visible := TRUE;
    //EdChat.SetFocus;
    SetImeMode(FrmMain.Handle, LocalLanguage);
    //MainSoundTimer.Interval := 1000;
    //MainSoundTimer.Enabled := TRUE;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.OpenScene'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.CloseScene;
begin
  try //�����Զ�����
    //MainSoundTimer.Enabled := FALSE;
    SilenceSound;

    EdChat.Visible := FALSE;
    FrmDlg.ViewBottomBox(FALSE);
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.CloseScene'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.OpeningScene;
begin
  try //�����Զ�����
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.OpeningScene'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.RefreshScene;
var
  i: integer;
begin
  try //�����Զ�����
    Map.m_OldClientRect.Left := -1;
    for i := 0 to m_ActorList.Count - 1 do
      TActor(m_ActorList[i]).LoadSurface;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.RefreshScene'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.CleanObjects;
var
  i: integer;
begin
  try //�����Զ�����
    for i := m_ActorList.Count - 1 downto 0 do
    begin
      if (TActor(m_ActorList[i]) <> g_MySelf) then
      begin
        TActor(m_ActorList[i]).Free;
        m_ActorList.Delete(i);
      end;
    end;
    m_MsgList.Clear;
    g_TargetCret := nil;
    g_FocusCret := nil;
    g_MagicTarget := nil;
    g_MagicLockActor := nil;
    //
    for i := 0 to m_GroundEffectList.Count - 1 do
      TMagicEff(m_GroundEffectList[i]).Free;
    m_GroundEffectList.Clear;
    for i := 0 to m_EffectList.Count - 1 do
      TMagicEff(m_EffectList[i]).Free;
    m_EffectList.Clear;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.CleanObjects'); //�����Զ�����
  end; //�����Զ�����
end;

{---------------------- Draw Map -----------------------}

procedure TPlayScene.DrawTileMap;
var
  i, j, nY, nX, nImgNumber: integer;
  DSurface: TDirectDrawSurface;
begin
  try //�����Զ�����
    with Map do
      if (m_ClientRect.Left = m_OldClientRect.Left) and (m_ClientRect.Top =
        m_OldClientRect.Top) then
        exit;

    Map.m_OldClientRect := Map.m_ClientRect;
    m_MapSurface.Fill(0);

    //��ͼ����

    if not g_boDrawTileMap then
      exit;
    with Map.m_ClientRect do
    begin
      nY := -UNITY * 4;
      for j := (Top - Map.m_nBlockTop - 5) to (Bottom - Map.m_nBlockTop + 3) do
      begin
        nX := AAX + 14 - (UNITX * 3);
        for i := (Left - Map.m_nBlockLeft - 6) to (Right - Map.m_nBlockLeft + 3)
          do
        begin
          if (i >= 0) and (i < LOGICALMAPUNIT * 3) and (j >= 0) and (j <
            LOGICALMAPUNIT * 3) then
          begin
            nImgNumber := (Map.m_MArr[i, j].wBkImg and $7FFF);
            if nImgNumber > 0 then
            begin
              if (i mod 2 = 0) and (j mod 2 = 0) then
              begin
                nImgNumber := nImgNumber - 1;
                DSurface := g_WTilesImages.Images[nImgNumber];
                if Dsurface <> nil then
                begin
                  //Jacky ��ʾ��ͼ����
  //                DrawLine(DSurface);
                  m_MapSurface.Draw(nX, nY, DSurface.ClientRect, DSurface,
                    FALSE);
                end;
              end;
            end;
          end;
          Inc(nX, UNITX);
        end;
        Inc(nY, UNITY);
      end;
    end;
    // exit;

   //��ͼ�м��
    with Map.m_ClientRect do
    begin
      nY := -UNITY;
      for j := (Top - Map.m_nBlockTop - 1) to (Bottom - Map.m_nBlockTop + 1) do
      begin
        nX := AAX + 14 - UNITX;
        for i := (Left - Map.m_nBlockLeft - 2) to (Right - Map.m_nBlockLeft + 1)
          do
        begin
          if (i >= 0) and (i < LOGICALMAPUNIT * 3) and (j >= 0) and (j <
            LOGICALMAPUNIT * 3) then
          begin
            nImgNumber := Map.m_MArr[i, j].wMidImg;
            if nImgNumber > 0 then
            begin
              nImgNumber := nImgNumber - 1;
              DSurface := g_WSmTilesImages.Images[nImgNumber];
              if Dsurface <> nil then
                m_MapSurface.Draw(nX, nY, DSurface.ClientRect, DSurface, TRUE);
            end;
          end;
          Inc(nX, UNITX);
        end;
        Inc(nY, UNITY);
      end;
    end;

  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.DrawTileMap'); //�����Զ�����
  end; //�����Զ�����
end;

{----------------------- ����, ����Ʈ ó�� -----------------------}

procedure TPlayScene.LoadFog; //����Ʈ ����Ÿ �б�
var
  i, fhandle, w, h, prevsize: integer;
  cheat: Boolean;
begin
  try //�����Զ�����
    prevsize := 0; //���� üũ
    cheat := FALSE;
    for i := 0 to MAXLIGHT do
    begin
      if FileExists(LightFiles[i]) then
      begin
        fhandle := FileOpen(LightFiles[i], fmOpenRead or fmShareDenyNone);
        FileRead(fhandle, w, sizeof(integer));
        FileRead(fhandle, h, sizeof(integer));
        m_Lights[i].Width := w;
        m_Lights[i].Height := h;
        m_Lights[i].PFog := AllocMem(w * h + 8);
        if prevsize < w * h then
        begin
          FileRead(fhandle, m_Lights[i].PFog^, w * h);
        end
        else
          cheat := TRUE;
        prevsize := w * h;
        FileClose(fhandle);
      end;
    end;
    if cheat then
      for i := 0 to MAXLIGHT do
      begin
        if m_Lights[i].PFog <> nil then
          FillChar(m_Lights[i].PFog^, m_Lights[i].Width * m_Lights[i].Height +
            8, #0);
      end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.LoadFog'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.ClearDropItem;
var
  I: Integer;
  DropItem: pTDropItem;
begin
  try //�����Զ�����
    for I := g_DropedItemList.Count - 1 downto 0 do
    begin
      DropItem := g_DropedItemList.Items[I];
      if DropItem = nil then
      begin
        g_DropedItemList.Delete(I);
        Continue;
      end;
      if (abs(DropItem.x - g_MySelf.m_nCurrX) > 16) and (abs(DropItem.y -
        g_MySelf.m_nCurrY) > 16) then
      begin
{$IF DEBUG = 1}
        DScreen.AddChatBoardString(format('DropItem:%s X:%d Y:%d',
          [DropItem.Name, DropItem.X, DropItem.Y]), clWhite, clRed);
{$IFEND}
        Dispose(DropItem);
        g_DropedItemList.Delete(I);
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.ClearDropItem'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.ClearLightMap;
var
  i, j: integer;
begin
  try //�����Զ�����
    FillChar(m_LightMap, (LMX + 1) * (LMY + 1) * SizeOf(TLightMapInfo), 0);
    for i := 0 to LMX do
      for j := 0 to LMY do
        m_LightMap[i, j].Light := -1;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.ClearLightMap'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.UpdateBright(x, y, light: integer);
var
  i, j, r, lx, ly: integer;
  pmask: ^ShortInt;
begin
  try //�����Զ�����
    pmask := nil; //jacky
    r := -1;
    case light of
      0:
        begin
          r := 2;
          pmask := @LightMask0;
        end;
      1:
        begin
          r := 4;
          pmask := @LightMask1;
        end;
      2:
        begin
          r := 8;
          pmask := @LightMask2;
        end;
      3:
        begin
          r := 10;
          pmask := @LightMask3;
        end;
      4:
        begin
          r := 14;
          pmask := @LightMask4;
        end;
      5:
        begin
          r := 16;
          pmask := @LightMask5;
        end;
    end;
    for i := 0 to r do
      for j := 0 to r do
      begin
        lx := x - (r div 2) + i;
        ly := y - (r div 2) + j;
        if (lx in [0..LMX]) and (ly in [0..LMY]) then
          m_LightMap[lx, ly].bright := m_LightMap[lx, ly].bright +
            PShoftInt(integer(pmask) + (i * (r + 1) + j) * sizeof(shortint))^;
      end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.UpdateBright'); //�����Զ�����
  end; //�����Զ�����
end;

function TPlayScene.CheckOverLight(x, y, light: integer): Boolean;
var
  i, j, r, mlight, lx, ly, count, check: integer;
  pmask: ^ShortInt;
begin
  pmask := nil; //jacky
  check := 0; //jacky
  r := -1;
  case light of
    0:
      begin
        r := 2;
        pmask := @LightMask0;
        check := 0;
      end;
    1:
      begin
        r := 4;
        pmask := @LightMask1;
        check := 4;
      end;
    2:
      begin
        r := 8;
        pmask := @LightMask2;
        check := 8;
      end;
    3:
      begin
        r := 10;
        pmask := @LightMask3;
        check := 18;
      end;
    4:
      begin
        r := 14;
        pmask := @LightMask4;
        check := 30;
      end;
    5:
      begin
        r := 16;
        pmask := @LightMask5;
        check := 40;
      end;
  end;
  count := 0;
  for i := 0 to r do
    for j := 0 to r do
    begin
      lx := x - (r div 2) + i;
      ly := y - (r div 2) + j;
      if (lx in [0..LMX]) and (ly in [0..LMY]) then
      begin
        mlight := PShoftInt(integer(pmask) + (i * (r + 1) + j) *
          sizeof(shortint))^;
        if m_LightMap[lx, ly].bright < mlight then
        begin
          inc(count, mlight - m_LightMap[lx, ly].bright);
          if count >= check then
          begin
            Result := FALSE;
            exit;
          end;
        end;
      end;
    end;
  Result := TRUE;
end;

procedure TPlayScene.AddLight(x, y, shiftx, shifty, light: integer; nocheck:
  Boolean);
var
  lx, ly: integer;
begin
  try //�����Զ�����
    lx := x - g_MySelf.m_nRx + LMX div 2;
    ly := y - g_MySelf.m_nRy + LMY div 2;
    if (lx >= 1) and (lx < LMX) and (ly >= 1) and (ly < LMY) then
    begin
      if m_LightMap[lx, ly].light < light then
      begin
        if not CheckOverLight(lx, ly, light) or nocheck then
        begin // > LightMap[lx, ly].light then begin
          UpdateBright(lx, ly, light);
          m_LightMap[lx, ly].light := light;
          m_LightMap[lx, ly].Shiftx := shiftx;
          m_LightMap[lx, ly].Shifty := shifty;
        end;
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.AddLight'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.ApplyLightMap;
var
  i, j, light, defx, defy, lx, ly, lxx, lyy {, lcount}: integer;
begin
  try //�����Զ�����
    defx := -UNITX * 2 + AAX + 14 - g_MySelf.m_nShiftX;
    defy := -UNITY * 3 - g_MySelf.m_nShiftY;
    //   lcount := 0;
    for i := 1 to LMX - 1 do
      for j := 1 to LMY - 1 do
      begin
        light := m_LightMap[i, j].light;
        if light >= 0 then
        begin
          lx := (i + g_MySelf.m_nRx - LMX div 2);
          ly := (j + g_MySelf.m_nRy - LMY div 2);
          lxx := (lx - Map.m_ClientRect.Left) * UNITX + defx + m_LightMap[i,
            j].ShiftX;
          lyy := (ly - Map.m_ClientRect.Top) * UNITY + defy + m_LightMap[i,
            j].ShiftY;

          FogCopy(m_Lights[light].PFog,
            0,
            0,
            m_Lights[light].Width,
            m_Lights[light].Height,
            m_PFogScreen,
            lxx - (m_Lights[light].Width - UNITX) div 2,
            lyy - (m_Lights[light].Height - UNITY) div 2 - 5,
            m_nFogWidth,
            m_nFogHeight,
            20);
          //            inc (lcount);
        end;
      end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.ApplyLightMap'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.DrawLightEffect(lx, ly, bright: integer);
begin
  try //�����Զ�����
    if (bright > 0) and (bright <= MAXLIGHT) then
      FogCopy(m_Lights[bright].PFog,
        0,
        0,
        m_Lights[bright].Width,
        m_Lights[bright].Height,
        m_PFogScreen,
        lx - (m_Lights[bright].Width - UNITX) div 2,
        ly - (m_Lights[bright].Height - UNITY) div 2,
        m_nFogWidth,
        m_nFogHeight,
        15);
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.DrawLightEffect'); //�����Զ�����
  end; //�����Զ�����
end;
{$REGION 'û��ʹ�õ�С��ͼ'}
{-----------------------------------------------------------------------}
(*
procedure TPlayScene.DrawMiniMap(surface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  //  v: Boolean;
  mx, my {,nx,ny,}, i: integer;
  dc, rc: TRect;
  actor: TActor;
  x, y: integer;
  btColor: Byte;
begin
  try //�����Զ�����
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
      //d:=g_UIBImages.GetIdxSurface(g_nMiniMapIndex-100000);
      I := g_nMiniMapIndex - 100000;
      case I of
        301: d := g_UIBImages.Images[12];
        302..310: d := g_UIBImages.Images[I - 275];
      end;
    end
    else
      d := FrmMain.GetWMMapImg(g_nMiniMapIndex);
    //d := g_WMMapImages.Images[g_nMiniMapIndex];
    if d = nil then
      exit;
    {if g_nViewMinMapLv = 1 then
      DrawBlendEx (surface, (SCREENWIDTH-120), 0, d, rc.Left, rc.Top, 120, 120, 0)
    else surface.Draw ((SCREENWIDTH-120), 0, rc, d, FALSE); }
    //Jason
    if g_nViewMinMapLv = 1 then
    begin
      mx := (g_MySelf.m_nCurrX * 48) div 32;
      my := (g_MySelf.m_nCurrY * 32) div 32;
      rc.Left := _MAX(0, mx - 60);
      rc.Top := _MAX(0, my - 60);
      rc.Right := _MIN(d.ClientRect.Right, rc.Left + 120);
      rc.Bottom := _MIN(d.ClientRect.Bottom, rc.Top + 120);
      surface.Draw((SCREENWIDTH - 120), 0, rc, d, FALSE);

      //�״�
     //if not m_boViewBlink then exit;
     //for nx:=g_MySelf.m_nCurrX - 12  to g_MySelf.m_nCurrX + 12 do begin
      // for ny:=g_MySelf.m_nCurrY - 12 to g_MySelf.m_nCurrY + 12 do begin
      for I := 0 to m_ActorList.Count - 1 do
      begin
        //actor := PlayScene.FindActorXY(nx,ny);
        actor := TActor(m_ActorList.Items[I]);
        if (actor <> nil) and
          (actor <> g_MySelf) and
          (not actor.m_boDeath) and
          (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) < 12) and
          (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) < 12) then
        begin
          mx := (SCREENWIDTH - 120) + (actor.m_nCurrX * 48) div 32 - rc.Left;
          my := (actor.m_nCurrY * 32) div 32 - rc.Top;

          case actor.m_btRace of //
            //50,45,12: btColor:=215;
            50, 12: btColor := 215;
            0: btColor := 151;
          else
            btColor := 249;
          end; // case
          for x := -1 to 1 do
            for y := -1 to 1 do
              surface.Pixels[mx + x, my + y] := btColor
        end;
      end;
      //end;
      if not m_boViewBlink then
        exit;
      mx := (SCREENWIDTH - 120) + (g_MySelf.m_nCurrX * 48) div 32 - rc.Left;
      my := (g_MySelf.m_nCurrY * 32) div 32 - rc.Top;
      for x := -1 to 1 do
        for y := -1 to 1 do
          surface.Pixels[mx + x, my + y] := 255;
    end
    else
    begin

      dc.Left := SCREENWIDTH - 150;
      dc.Top := 0;
      dc.Right := SCREENWIDTH;
      dc.Bottom := 150;
      rc.Left := 0;
      rc.Top := 0;
      rc.Right := d.ClientRect.Right;
      rc.Bottom := d.ClientRect.Bottom;
      surface.StretchDraw(dc, rc, d, FALSE);

      for I := 0 to m_ActorList.Count - 1 do
      begin
        //actor := PlayScene.FindActorXY(nx,ny);
        actor := TActor(m_ActorList.Items[I]);
        if (actor <> nil) and
          (actor <> g_MySelf) and
          (not actor.m_boDeath) and
          (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) < 12) and
          (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) < 12) then
        begin

          mx := dc.Left + Trunc((actor.m_nCurrX * 48) * (150 /
            d.ClientRect.Right)) div 32;
          my := Trunc(actor.m_nCurrY * (150 / d.ClientRect.Bottom));
          case actor.m_btRace of //
            //50,45,12: btColor:=215;
            50, 12: btColor := 215;
            0: btColor := 151;
          else
            btColor := 249;
          end; // case
          for x := -1 to 1 do
            for y := -1 to 1 do
              surface.Pixels[mx + x, my + y] := btColor
        end;
      end;

      if not m_boViewBlink then
        exit;
      mx := dc.Left + Trunc((g_MySelf.m_nCurrX * 48) * (150 /
        d.ClientRect.Right)) div 32;
      my := Trunc(g_MySelf.m_nCurrY * (150 / d.ClientRect.Bottom));
      for x := -1 to 1 do
        for y := -1 to 1 do
          surface.Pixels[mx + x, my + y] := 255;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.DrawMiniMap'); //�����Զ�����
  end; //�����Զ�����
end;
    *)
{-----------------------------------------------------------------------}
{$ENDREGION}
procedure TPlayScene.PlayScene(MSurface: TDirectDrawSurface);
  function CheckOverlappedObject(myrc, obrc: TRect): Boolean;
  begin
    if (obrc.Right > myrc.Left) and (obrc.Left < myrc.Right) and
      (obrc.Bottom > myrc.Top) and (obrc.Top < myrc.Bottom) then
      Result := TRUE
    else
      Result := FALSE;
  end;

var
  i, j, k, n, m, mmm, ix, iy, line, defx, defy, wunit, fridx, ani, anitick, ax,
    ay, idx, drawingbottomline: integer;
  DSurface, d: TDirectDrawSurface;
  blend, movetick: Boolean;
  //myrc, obrc: TRect;
  DropItem: PTDropItem;
  evn: TClEvent;
  actor: TActor;
  meff: TMagicEff;
  msgstr: string;
  //TempStr:String;
  ShowItem: pTShowItem;
  nFColor, nBColor: Integer;
  sz:SIZE;
begin
  try //�����Զ�����
    drawingbottomline := 0; //jacky
    if (g_MySelf = nil) then
    begin
      msgstr := '���Ժ�...';
      //TempStr:='˽������Ӱ����Ů���뵽 http://www.Js991.com';
      g_CloseAllSys := False; //�ܾ����й�����Ϣ
      g_CloseCrcSys := False; //�ܾ����к�����Ϣ
      g_CloseMySys := False; //�ܾ�����˽����Ϣ
      g_CloseGuildSys := False; //�ܾ������л���Ϣ
      g_AutoSysMsg := False; //�Զ�����
      g_AutoMsg := ''; //�Զ���������
      with MSurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        BoldTextOut(MSurface, (SCREENWIDTH - TextWidth(msgstr)) div 2,
          (SCREENHEIGHT - 600) + 200,
          clWhite, clBlack, msgstr);
        if g_CloseStr <> '' then
          BoldTextOut(MSurface, (SCREENWIDTH - TextWidth(g_CloseStr)) div 2,
            (SCREENHEIGHT - 600) + 240,
            clWhite, clBlack, g_CloseStr);
        Release;
      end;
      exit;
    end;

    g_boDoFastFadeOut := FALSE;

    //ĳ���Ϳ��鿡�� �޼����� ����
    movetick := FALSE;
    if GetTickCount - m_dwMoveTime >= g_dwMoveTime {100} then
    begin
      m_dwMoveTime := GetTickCount; //�̵��� ����ȭ
      movetick := TRUE; //�̵� ƽ
      Inc(m_nMoveStepCount);
      if m_nMoveStepCount > 1 then
        m_nMoveStepCount := 0;
    end;
    if GetTickCount - m_dwAniTime >= 50 then
    begin
      m_dwAniTime := GetTickCount;
      Inc(m_nAniCount);
      if m_nAniCount > 100000 then
        m_nAniCount := 0;
    end;

    try
      i := 0; //����� �޼����� ó����
      while TRUE do
      begin //Frame ó���� ���⼭ ����.
        if i >= m_ActorList.Count then
          break;
        actor := m_ActorList[i];

        if movetick then
          actor.m_boLockEndFrame := FALSE;
        if not actor.m_boLockEndFrame then
        begin
          actor.ProcMsg;
          //�޼��� ó���ϸ鼭 actor�� ������ �� ����.
          if movetick then
            if actor.Move(m_nMoveStepCount) then
            begin //����ȭ�ؼ� ������
              Inc(i);
              continue;
            end;
          actor.Run; //
          if actor <> g_MySelf then
            actor.ProcHurryMsg;
        end;
        if actor = g_MySelf then
          actor.ProcHurryMsg;
        //
        if actor.m_nWaitForRecogId <> 0 then
        begin
          if actor.IsIdle then
          begin
            DelChangeFace(actor.m_nWaitForRecogId);
            NewActor(actor.m_nWaitForRecogId, actor.m_nCurrX, actor.m_nCurrY,
              actor.m_btDir, actor.m_nWaitForFeature, actor.m_nWaitForStatus);
            actor.m_nWaitForRecogId := 0;
            actor.m_boDelActor := TRUE;
          end;
        end;
        if actor.m_boDelActor or
          (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) > 16) or
          (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) > 16) then
        begin
          //actor.Free;
          g_FreeActorList.Add(actor);
          m_ActorList.Delete(i);
          if g_TargetCret = actor then
            g_TargetCret := nil;
          if g_FocusCret = actor then
            g_FocusCret := nil;
          if g_MagicLockActor = actor then
            g_MagicLockActor := nil;
          if g_MagicTarget = actor then
            g_MagicTarget := nil;
        end
        else
          Inc(i);
      end;
    except
      DebugOutStr('101');
    end;

    try
      i := 0;
      while TRUE do
      begin
        if i >= m_GroundEffectList.Count then
          break;
        meff := m_GroundEffectList[i];
        if meff.m_boActive then
        begin
          if not meff.Run then
          begin //����ȿ��
            meff.Free;
            m_GroundEffectList.Delete(i);
            continue;
          end;
        end;
        Inc(i);
      end;
      i := 0;
      while TRUE do
      begin
        if i >= m_EffectList.Count then
          break;
        meff := m_EffectList[i];
        if meff.m_boActive then
        begin
          if not meff.Run then
          begin //����ȿ��
            meff.Free;
            m_EffectList.Delete(i);
            continue;
          end;
        end;
        Inc(i);
      end;
      i := 0;
      while TRUE do
      begin
        if i >= m_FlyList.Count then
          break;
        meff := m_FlyList[i];
        if meff.m_boActive then
        begin
          if not meff.Run then
          begin //����,ȭ��� ���ư��°�
            meff.Free;
            m_FlyList.Delete(i);
            continue;
          end;
        end;
        Inc(i);
      end;

      EventMan.Execute;
    except
      DebugOutStr('102');
    end;

    try
      ClearDropItem(); //���������ʾ��Χ����Ʒ

      for k := 0 to EventMan.EventList.Count - 1 do
      begin
        evn := TClEvent(EventMan.EventList[k]);
        if (Abs(evn.m_nX - g_MySelf.m_nCurrX) > 16) and (Abs(evn.m_nY -
          g_MySelf.m_nCurrY) > 16) then
        begin
          evn.Free;
          EventMan.EventList.Delete(k);
          break; //�ѹ��� �Ѱ���
        end;
      end;
    except
      DebugOutStr('103');
    end;

    try
      with Map.m_ClientRect do
      begin
{$IF SWH = SWH800}
        Left := g_MySelf.m_nRx - 9;
        Top := g_MySelf.m_nRy - 9;
        Right := g_MySelf.m_nRx + 9; // ������ ¥���� �׸�
        Bottom := g_MySelf.m_nRy + 8;
{$ELSEIF SWH = SWH1024}
        Left := g_MySelf.m_nRx - 12;
        Top := g_MySelf.m_nRy - 12;
        Right := g_MySelf.m_nRx + 12; //
        Bottom := g_MySelf.m_nRy + 15;
{$IFEND}
      end;
      Map.UpdateMapPos(g_MySelf.m_nRx, g_MySelf.m_nRy);

      ///////////////////////
      //ViewFog := FALSE;
      ///////////////////////

      if g_boNoDarkness or (g_MySelf.m_boDeath) then
      begin
        g_boViewFog := FALSE;
      end;

      if g_boViewFog and (not g_boForceNotViewFog) then
      begin //����
        ZeroMemory(m_PFogScreen, MAPSURFACEHEIGHT * MAPSURFACEWIDTH);
        ClearLightMap;
      end;

      //   drawingbottomline := 450;
      drawingbottomline := SCREENHEIGHT;
      m_ObjSurface.Fill(0);

      DrawTileMap;

      m_ObjSurface.Draw(0, 0,
        Rect(UNITX * 5 + g_MySelf.m_nShiftX,
        UNITY * 4 + g_MySelf.m_nShiftY,
        UNITX * 5 + g_MySelf.m_nShiftX + MAPSURFACEWIDTH,
        UNITY * 4 + g_MySelf.m_nShiftY + MAPSURFACEHEIGHT),
        m_MapSurface,
        FALSE);

    except
      DebugOutStr('104');
    end;

    defx := -UNITX * 2 - g_MySelf.m_nShiftX + AAX + 14;
    defy := -UNITY * 2 - g_MySelf.m_nShiftY;
    m_nDefXX := defx;
    m_nDefYY := defy;

    try
      m := defy - UNITY;
      for j := (Map.m_ClientRect.Top - Map.m_nBlockTop) to
        (Map.m_ClientRect.Bottom - Map.m_nBlockTop + LONGHEIGHT_IMAGE) do
      begin
        if j < 0 then
        begin
          Inc(m, UNITY);
          continue;
        end;
        n := defx - UNITX * 2;
        //*** 48*32 Ÿ���� ������Ʈ �׸���
        for i := (Map.m_ClientRect.Left - Map.m_nBlockLeft - 2) to
          (Map.m_ClientRect.Right - Map.m_nBlockLeft + 2) do
        begin
          if (i >= 0) and (i < LOGICALMAPUNIT * 3) and (j >= 0) and (j <
            LOGICALMAPUNIT * 3) then
          begin
            fridx := (Map.m_MArr[i, j].wFrImg) and $7FFF;
            if fridx > 0 then
            begin
              ani := Map.m_MArr[i, j].btAniFrame;
              wunit := Map.m_MArr[i, j].btArea;
              blend := FALSE;
              if (ani and $80) > 0 then
              begin
                blend := TRUE;
                ani := ani and $7F;
              end;
              if ani > 0 then
              begin
                anitick := Map.m_MArr[i, j].btAniTick;
                fridx := fridx + (m_nAniCount mod (ani + (ani * anitick))) div (1
                  + anitick);
              end;
              if (Map.m_MArr[i, j].btDoorOffset and $80) > 0 then
              begin //����
                if (Map.m_MArr[i, j].btDoorIndex and $7F) > 0 then
                  //������ ǥ�õ� �͸�
                  fridx := fridx + (Map.m_MArr[i, j].btDoorOffset and $7F);
                //���� ��
              end;
              fridx := fridx - 1;
              // ��ü �׸�
              DSurface := GetObjs(wunit, fridx);
              if DSurface <> nil then
              begin
                if (DSurface.Width = 48) and (DSurface.Height = 32) then
                begin
                  mmm := m + UNITY - DSurface.Height;
                  if (n + DSurface.Width > 0) and (n <= SCREENWIDTH) and (mmm +
                    DSurface.Height > 0) and (mmm < drawingbottomline) then
                  begin
                    m_ObjSurface.Draw(n, mmm, DSurface.ClientRect, Dsurface,
                      TRUE)
                  end
                  else
                  begin
                    if mmm < drawingbottomline then
                    begin //���ʿ��ϰ� �׸��� ���� ����
                      m_ObjSurface.Draw(n, mmm, DSurface.ClientRect, DSurface,
                        TRUE)
                    end;
                  end;
                end;
              end;

              //
             { blend := FALSE;
              //wunit := Map.m_MArr[i, j].btArea;
              //���ϸ��̼�
              //ani := Map.m_MArr[i, j].btAniFrame;
              if (ani and $80) > 0 then begin
                 blend := TRUE;
                 ani := ani and $7F;
              end;
              if ani > 0 then begin
                 anitick := Map.m_MArr[i, j].btAniTick;
                 fridx := fridx + (m_nAniCount mod (ani + (ani*anitick))) div (1+anitick);
              end;
              if (Map.m_MArr[i, j].btDoorOffset and $80) > 0 then begin //����
                 if (Map.m_MArr[i, j].btDoorIndex and $7F) > 0 then  //������ ǥ�õ� �͸�
                    fridx := fridx + (Map.m_MArr[i, j].btDoorOffset and $7F); //���� ��
              end;
              fridx := fridx - 1; }
              // ��ü �׸�
              if not blend then
              begin
                DSurface := GetObjs(wunit, fridx);
                if DSurface <> nil then
                begin
                  if (DSurface.Width <> 48) or (DSurface.Height <> 32) then
                  begin
                    mmm := m + UNITY - DSurface.Height;
                    if (n + DSurface.Width > 0) and (n <= SCREENWIDTH) and (mmm
                      + DSurface.Height > 0) and (mmm < drawingbottomline) then
                    begin
                      m_ObjSurface.Draw(n, mmm, DSurface.ClientRect, Dsurface,
                        TRUE)
                    end
                    else
                    begin
                      if mmm < drawingbottomline then
                      begin //���ʿ��ϰ� �׸��� ���� ����
                        m_ObjSurface.Draw(n, mmm, DSurface.ClientRect, DSurface,
                          TRUE)
                      end;
                    end;
                  end;
                end;
              end
              else
              begin
                DSurface := GetObjsEx(wunit, fridx, ax, ay);
                if DSurface <> nil then
                begin
                  mmm := m + ay - 68; //UNITY - DSurface.Height;
                  if (n > 0) and (mmm + DSurface.Height > 0) and (n +
                    Dsurface.Width < SCREENWIDTH) and (mmm < drawingbottomline)
                      then
                  begin
                    DrawBlend(m_ObjSurface, n + ax - 2, mmm, DSurface, 1);
                  end
                  else
                  begin
                    if mmm < drawingbottomline then
                    begin //���ʿ��ϰ� �׸��� ���� ����
                      DrawBlend(m_ObjSurface, n + ax - 2, mmm, DSurface, 1);
                    end;
                  end;
                end;
              end;
              //
            end;
          end;
          Inc(n, UNITX);
        end;
        //
        if (j <= (Map.m_ClientRect.Bottom - Map.m_nBlockTop)) and (not
          g_boServerChanging) then
        begin

          //*** �ٴڿ� ����� ���� ����
          for k := 0 to EventMan.EventList.Count - 1 do
          begin
            evn := TClEvent(EventMan.EventList[k]);
            if j = (evn.m_nY - Map.m_nBlockTop) then
            begin
              evn.DrawEvent(m_ObjSurface,
                (evn.m_nX - Map.m_ClientRect.Left) * UNITX + defx,
                m);
            end;
          end;

          if g_boDrawDropItem then
          begin

            //��ʾ������Ʒ����
            for k := 0 to g_DropedItemList.Count - 1 do
            begin
              DropItem := PTDropItem(g_DropedItemList[k]);
              if DropItem <> nil then
              begin
                if (abs(g_MySelf.m_nCurrX - DropItem.X) > MAXLEFT2) or
                  (abs(g_MySelf.m_nCurrY - DropItem.Y) > MAXTOP2) then
                  Continue;
                if j = (DropItem.y - Map.m_nBlockTop) then
                begin
                  //d := g_WDnItemImages.Images[DropItem.Looks];
                  d := FrmMain.GetWDnItemImg(DropItem.Looks);
                  if d <> nil then
                  begin
                    ix := (DropItem.x - Map.m_ClientRect.Left) * UNITX + defx +
                      SOFFX; // + actor.ShiftX;
                    iy := m; // + actor.ShiftY;
                    if DropItem = g_FocusItem then
                    begin
                      g_ImgMixSurface.Draw(0, 0, d.ClientRect, d, FALSE);
                      DrawEffect(0, 0, d.Width, d.Height, g_ImgMixSurface,
                        ceBright);
                      m_ObjSurface.Draw(ix + HALFX - (d.Width div 2),
                        iy + HALFY - (d.Height div 2),
                        d.ClientRect,
                        g_ImgMixSurface, TRUE);
                    end
                    else
                    begin
                      m_ObjSurface.Draw(ix + HALFX - (d.Width div 2),
                        iy + HALFY - (d.Height div 2),
                        d.ClientRect,
                        d, TRUE);
                    end;

                  end;
                end;
              end;
            end;
          end;

          //*** ��ʾ����˵����Ϣ
          for k := 0 to m_ActorList.Count - 1 do
          begin
            actor := m_ActorList[k];
            if (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) > MAXLEFT2) or
              (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) > MAXTOP2) then
              Continue;
            if (j = actor.m_nRy - Map.m_nBlockTop - actor.m_nDownDrawLevel) then
            begin
              actor.m_nSayX := (actor.m_nRx - Map.m_ClientRect.Left) * UNITX +
                defx + actor.m_nShiftX + 24;
              if actor.m_boDeath then
                actor.m_nSayY := m + UNITY + actor.m_nShiftY + 16 - 60 +
                  (actor.m_nDownDrawLevel * UNITY)
              else
                actor.m_nSayY := m + UNITY + actor.m_nShiftY + 16 - 95 +
                  (actor.m_nDownDrawLevel * UNITY);
              actor.DrawChr(m_ObjSurface, (actor.m_nRx - Map.m_ClientRect.Left)
                * UNITX + defx,
                m + (actor.m_nDownDrawLevel * UNITY),
                FALSE, True);
            end;
          end;
          for k := 0 to m_FlyList.Count - 1 do
          begin
            meff := TMagicEff(m_FlyList[k]);
            if j = (meff.Ry - Map.m_nBlockTop) then
              meff.DrawEff(m_ObjSurface);
          end;

        end;
        //
        Inc(m, UNITY);
      end;

      //���ٴڿ� �׷����� ����
      for k := 0 to m_GroundEffectList.Count - 1 do
      begin
        meff := TMagicEff(m_GroundEffectList[k]);
        //if j = (meff.Ry - Map.BlockTop) then begin
        meff.DrawEff(m_ObjSurface);
        if g_boViewFog and (not g_boForceNotViewFog) then
        begin
          AddLight(meff.Rx, meff.Ry, 0, 0, meff.light, FALSE);
        end;
      end;

    except
      DebugOutStr('105');
    end;
    //MSurface.Draw (SOFFX, SOFFY, m_ObjSurface.ClientRect, m_ObjSurface, FALSE);
   // exit;
  (*  try
    m := defy - UNITY;
    for j:=(Map.m_ClientRect.Top - Map.m_nBlockTop) to (Map.m_ClientRect.Bottom - Map.m_nBlockTop + LONGHEIGHT_IMAGE) do begin
       if j < 0 then begin Inc (m, UNITY); continue; end;
       {n := defx-UNITX*2;
       //*** ��������Ʈ �׸���
       for i:=(Map.m_ClientRect.Left - Map.m_nBlockLeft-2) to (Map.m_ClientRect.Right - Map.m_nBlockLeft+2) do begin
          if (i >= 0) and (i < LOGICALMAPUNIT*3) and (j >= 0) and (j < LOGICALMAPUNIT*3) then begin
             fridx := (Map.m_MArr[i, j].wFrImg) and $7FFF;
             if fridx > 0 then begin

             end;

          end;
          Inc (n, UNITX);
       end;          }

       Inc (m, UNITY);
    end;
    except
       DebugOutStr ('106');
    end;     *)

    try
      if g_boViewFog and (not g_boForceNotViewFog) then
      begin
        m := defy - UNITY * 4;
        for j := (Map.m_ClientRect.Top - Map.m_nBlockTop - 4) to
          (Map.m_ClientRect.Bottom - Map.m_nBlockTop + LONGHEIGHT_IMAGE) do
        begin
          if j < 0 then
          begin
            Inc(m, UNITY);
            continue;
          end;
          n := defx - UNITX * 5;
          //��� ���� �׸���
          for i := (Map.m_ClientRect.Left - Map.m_nBlockLeft - 5) to
            (Map.m_ClientRect.Right - Map.m_nBlockLeft + 5) do
          begin
            if (i >= 0) and (i < LOGICALMAPUNIT * 3) and (j >= 0) and (j <
              LOGICALMAPUNIT * 3) then
            begin
              idx := Map.m_MArr[i, j].btLight;
              if idx > 0 then
              begin
                AddLight(i + Map.m_nBlockLeft, j + Map.m_nBlockTop, 0, 0, idx,
                  FALSE);
              end;
            end;
            Inc(n, UNITX);
          end;
          Inc(m, UNITY);
        end;

        //ĳ���� ���� �׸���
        if m_ActorList.Count > 0 then
        begin
          for k := 0 to m_ActorList.Count - 1 do
          begin
            actor := m_ActorList[k];
            if (actor = g_MySelf) or (actor.Light > 0) then
              AddLight(actor.m_nRx, actor.m_nRy, actor.m_nShiftX,
                actor.m_nShiftY, actor.Light, actor = g_MySelf);
          end;
        end
        else
        begin
          if g_MySelf <> nil then
            AddLight(g_MySelf.m_nRx, g_MySelf.m_nRy, g_MySelf.m_nShiftX,
              g_MySelf.m_nShiftY, g_MySelf.Light, TRUE);
        end;
      end;
    except
      DebugOutStr('107');
    end;

    if not g_boServerChanging then
    begin
      try
        //**** ���ΰ� ĳ���� �׸���
        if not g_boCheckBadMapMode then
          if g_MySelf.m_nState and $00800000 = 0 then
            g_MySelf.DrawChr(m_ObjSurface, (g_MySelf.m_nRx -
              Map.m_ClientRect.Left) * UNITX + defx, (g_MySelf.m_nRy -
              Map.m_ClientRect.Top - 1) * UNITY + defy, TRUE, FALSE);

        //****
        if (g_FocusCret <> nil) then
        begin
          if IsValidActor(g_FocusCret) and (g_FocusCret <> g_MySelf) then
            //            if (actor.m_btRace <> 81) or (FocusCret.State and $00800000 = 0) then //Jacky
            if (g_FocusCret.m_nState and $00800000 = 0) then //Jacky
              g_FocusCret.DrawChr(m_ObjSurface,
                (g_FocusCret.m_nRx - Map.m_ClientRect.Left) * UNITX + defx,
                (g_FocusCret.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + defy,
                TRUE, FALSE);
        end;
        if (g_MagicTarget <> nil) then
        begin
          if IsValidActor(g_MagicTarget) and (g_MagicTarget <> g_MySelf) then
            if g_MagicTarget.m_nState and $00800000 = 0 then
              //������ �ƴϸ�
              g_MagicTarget.DrawChr(m_ObjSurface,
                (g_MagicTarget.m_nRx - Map.m_ClientRect.Left) * UNITX + defx,
                (g_MagicTarget.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + defy,
                TRUE, FALSE);
        end;
      except
        DebugOutStr('108');
      end;
    end;

    try
      //**** ���� ȿ��

      for k := 0 to m_ActorList.Count - 1 do
      begin
        actor := m_ActorList[k];
        if (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) > MAXLEFT2) or
          (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) > MAXTOP2) then
          Continue;
        actor.DrawEff(m_ObjSurface,
          (actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx,
          (actor.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + defy);
      end;

      for k := 0 to m_EffectList.Count - 1 do
      begin
        meff := TMagicEff(m_EffectList[k]);
        //if j = (meff.Ry - Map.BlockTop) then begin
        meff.DrawEff(m_ObjSurface);
        if g_boViewFog and (not g_boForceNotViewFog) then
        begin
          AddLight(meff.Rx, meff.Ry, 0, 0, meff.Light, FALSE);
        end;
      end;
      if g_boViewFog and (not g_boForceNotViewFog) then
      begin
        for k := 0 to EventMan.EventList.Count - 1 do
        begin
          evn := TClEvent(EventMan.EventList[k]);
          if evn.m_nLight > 0 then
            AddLight(evn.m_nX, evn.m_nY, 0, 0, evn.m_nLight, FALSE);
        end;
      end;
    except
      DebugOutStr('109');
    end;

    //������Ʒ����
    try
      //m_ItemSurface.Fill(0);
     // SetBkMode (m_ItemSurface.Canvas.Handle, TRANSPARENT);
      for k := 0 to g_DropedItemList.Count - 1 do
      begin
        DropItem := PTDropItem(g_DropedItemList[k]);
        if DropItem <> nil then
        begin
          if (abs(g_MySelf.m_nCurrX - DropItem.X) > MAXLEFT2) or
            (abs(g_MySelf.m_nCurrY - DropItem.Y) > MAXTOP2) then
            Continue;
          if GetTickCount - DropItem.FlashTime > g_dwDropItemFlashTime {5 * 1000}
            then
          begin
            DropItem.FlashTime := GetTickCount;
            DropItem.BoFlash := TRUE;
            DropItem.FlashStepTime := GetTickCount;
            DropItem.FlashStep := 0;
          end;
          ix := (DropItem.x - Map.m_ClientRect.Left) * UNITX + defx + SOFFX;
          iy := (DropItem.y - Map.m_ClientRect.Top - 1) * UNITY + defy + SOFFY;
          if DropItem.BoFlash then
          begin
            if GetTickCount - DropItem.FlashStepTime >= 20 then
            begin
              DropItem.FlashStepTime := GetTickCount;
              Inc(DropItem.FlashStep);
            end;
            if (DropItem.FlashStep >= 0) and (DropItem.FlashStep < 10) then
            begin
              DSurface := g_WMainImages.GetCachedImage(FLASHBASE +
                DropItem.FlashStep, ax, ay);
              DrawBlend(m_ObjSurface, ix + ax, iy + ay, DSurface, 1);
            end
            else
              DropItem.BoFlash := FALSE;
          end;
          { if (g_wginfo.boShowAllItem) and g_ClientWgInfo.boShowAllItem and (DropItem.boItemShow or (not g_wgInfo.boShowAllItemFil)) then begin
                //��ʾ������Ʒ����
               if (DropItem.boItemCorps) and (g_WgInfo.boCropsItemShow) then
                 nFColor:=GetRGB(g_WgInfo.coShowCropsColor)
               else nFColor:=GetRGB(147);
               nBColor:=clBlack;
             with m_ItemSurface.Canvas do begin
               //SetBkMode (Handle, TRANSPARENT);
               BoldTextOut(m_ItemSurface,
                            ix + HALFX - TextWidth(DropItem.Name) div 2,
                            iy + HALFY - TextHeight(DropItem.Name) * 2,// div 2,
                            nFColor,
                            nBColor,
                            DropItem.Name);
               //Release;
             end;
           end;}
        end;
      end;
      // m_ItemSurface.Canvas.Release;
    except
      DebugOutStr('110');
    end;

    try
      //   g_boViewFog:=False;      //Jacky ����
      if g_boViewFog and not g_boForceNotViewFog then
      begin
        ApplyLightMap;
        DrawFog(m_ObjSurface, m_PFogScreen, m_nFogWidth);
        MSurface.Draw(SOFFX, SOFFY, m_ObjSurface.ClientRect, m_ObjSurface,
          FALSE);
      end
      else
      begin
        if g_MySelf.m_boDeath then //������������ʾ�ڰ׻���
          DrawEffect(0, 0, m_ObjSurface.Width, m_ObjSurface.Height,
            m_ObjSurface, g_DeathColorEffect {ceGrayScale});

        MSurface.Draw(SOFFX, SOFFY, m_ObjSurface.ClientRect, m_ObjSurface,
          FALSE);
      end;
      //MSurface.Draw (SOFFX, SOFFY, m_ItemSurface.ClientRect, m_ItemSurface, FALSE);
    except
      DebugOutStr('111');
    end;

    //������Ʒ����
    try
      with MSurface.Canvas do
      begin
        SetBkMode(Handle, TRANSPARENT);
        for k := 0 to g_DropedItemList.Count - 1 do
        begin
          DropItem := PTDropItem(g_DropedItemList[k]);
          if DropItem <> nil then
          begin
            if (abs(g_MySelf.m_nCurrX - DropItem.X) > MAXLEFT2) or
              (abs(g_MySelf.m_nCurrY - DropItem.Y) > MAXTOP2) then
              Continue;
            ix := (DropItem.x - Map.m_ClientRect.Left) * UNITX + defx + SOFFX;
            iy := (DropItem.y - Map.m_ClientRect.Top - 1) * UNITY + defy +
              SOFFY;
            if (g_wginfo.boShowAllItem) and g_ClientWgInfo.boShowAllItem and
              (DropItem.boItemShow or (not g_wgInfo.boShowAllItemFil)) then
            begin
              //��ʾ������Ʒ����
              if (DropItem.boItemCorps) and (g_WgInfo.boCropsItemShow) then
                nFColor := GetRGB(g_WgInfo.coShowCropsColor)
              else
                nFColor := GetRGB(147);
              nBColor := clBlack;
              sz:=TextWidthAndHeight(Handle,DropItem.Name);
              BoldTextOut(MSurface,
                ix + HALFX - sz.cx{TextWidth(DropItem.Name)} div 2,
                iy + HALFY - sz.cy{TextHeight(DropItem.Name)} * 2, // div 2,
                nFColor,
                nBColor,
                DropItem.Name);
            end;
          end;
        end;
        Release;
      end;
    except
      DebugOutStr('1101');
    end;

    //MSurface.Draw (SOFFX, SOFFY, m_ObjSurface.ClientRect, m_ObjSurface, FALSE);

   { if g_boViewMiniMap then
    begin
      DrawMiniMap(MSurface); //��ʾС��ͼ��Ϣ
    end; }
    if (g_AutoSysMsg) and ((GetTickCount - g_AutoMsgTick) > g_AutoMsgTime) then
    begin
      g_AutoMsgTick := GetTickCount;
      FrmMain.SendSay(g_AutoMsg);
    end;

  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.PlayScene'); //�����Զ�����
  end; //�����Զ�����
end;

{-------------------------------------------------------}

//cx, cy, tx, ty : ���� ��ǥ

procedure TPlayScene.NewMagic(aowner: TActor;
  magid, magnumb {Effect}, cx, cy, tx, ty, targetcode: integer;
  mtype: TMagicType; //EffectType
  Recusion: Boolean;
  anitime: integer;
  var bofly: Boolean);
var
  i, scx, scy, sctx, scty, effnum: integer;
  meff: TMagicEff;
  target: TActor;
  wimg: TWMImages;
begin
  try //�����Զ�����
    bofly := FALSE;
    if magid <> 111 then //
      for i := 0 to m_EffectList.Count - 1 do
        if TMagicEff(m_EffectList[i]).ServerMagicId = magid then
          exit; //
    ScreenXYfromMCXY(cx, cy, scx, scy);
    ScreenXYfromMCXY(tx, ty, sctx, scty);
    if magnumb > 0 then
      GetEffectBase(magnumb - 1, 0, wimg, effnum) //magnumb{Effect}
      //Dscreen.AddSysMsg (format('%d',[effnum]));
    else
      effnum := -magnumb;
    target := FindActor(targetcode);

    meff := nil;
    //Dscreen.AddSysMsg (IntToStr(Integer(mtype))+'  '+IntToStr(magnumb));
    case mtype of //EffectType
      mtReady, mtFly, mtFlyAxe:
        begin
          case magnumb of
            63:
              begin
                meff := TMagicEff.Create(magnumb, 620, scx, scy, sctx, scty,
                  mtype, Recusion, anitime);
                meff.MagExplosionBase := 780;
                meff.ExplosionFrame := 36;
                meff.TargetActor := target;
                if wimg <> nil then
                  meff.ImgLib := wimg;
              end;

            42:
              begin //������
                if aowner <> nil then
                  GetNextPosition(aowner.m_nCurrX, aowner.m_nCurrY,
                    aowner.m_btDir, 4, sctx, scty);
                meff := TFlyDrawEffect.Create(sctx, scty, wimg, aowner.m_btDir *
                  10 + 10, 90, 10, 85, True);
                meff.MagExplosionBase := 90;
                meff.ExplosionFrame := 10;
                PlaySoundEx(bmg_splitshadow);
              end;
            39:
              begin //������
                meff := TMagicEff.Create(magnumb, 410, scx, scy, sctx, scty,
                  mtype, Recusion, anitime);
                meff.MagExplosionBase := 570;
                meff.ExplosionFrame := 10;
                meff.TargetActor := target;
                if wimg <> nil then
                  meff.ImgLib := wimg;
              end;
            100:
              begin
                meff := TMagicEff.Create(magnumb, 110, scx, scy, sctx, scty,
                  mtype, Recusion, anitime);
                meff.MagExplosionBase := 270;
                meff.ExplosionFrame := 6;
                meff.TargetActor := target;
                if wimg <> nil then
                  meff.ImgLib := wimg;
              end;
            101:
              begin
                meff := TMagicEff.Create(magnumb, 290, scx, scy, sctx, scty,
                  mtype, Recusion, anitime);
                meff.MagExplosionBase := 450;
                meff.ExplosionFrame := 10;
                meff.TargetActor := target;
                if wimg <> nil then
                  meff.ImgLib := wimg;
              end;
          else
            begin
              meff := TMagicEff.Create(magid
                {��Ϊmagnumb�����к��Ч���ı���}, effnum, scx, scy,
                sctx, scty, mtype, Recusion, anitime);
              meff.TargetActor := target;
              if magnumb = 39 then
              begin
                meff.frame := 4;
                if wimg <> nil then
                  meff.ImgLib := wimg;
              end;
            end;
          end;
          bofly := TRUE;
        end;
      mtExplosion:
        case magnumb of
          18:
            begin //�ջ�֮��
              meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty,
                mtype, Recusion, anitime);
              meff.MagExplosionBase := 1570;
              meff.TargetActor := target;
              meff.NextFrameTime := 80;
            end;
          51:
            begin
              meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty,
                mtype, Recusion, anitime);
              meff.MagExplosionBase := 640;
              meff.TargetActor := nil; //target;
              meff.NextFrameTime := 50;
              meff.ExplosionFrame := 40;
              meff.Light := 3;
              if wimg <> nil then
                meff.ImgLib := wimg;
              PlaySoundEx(bmg_SKILL_74_3);
            end;
          21:
            begin //���ѻ���
              meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty,
                mtype, Recusion, anitime);
              meff.MagExplosionBase := 1660;
              meff.TargetActor := nil; //target;
              meff.NextFrameTime := 80;
              meff.ExplosionFrame := 20;
              meff.Light := 3;
            end;
          26:
            begin //������ʾ
              meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty,
                mtype, Recusion, anitime);
              meff.MagExplosionBase := 3990;
              meff.TargetActor := target;
              meff.NextFrameTime := 80;
              meff.ExplosionFrame := 10;
              meff.Light := 2;
            end;
          27:
            begin //Ⱥ��������
              meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty,
                mtype, Recusion, anitime);
              meff.MagExplosionBase := 1800;
              meff.TargetActor := nil; //target;
              meff.NextFrameTime := 80;
              meff.ExplosionFrame := 10;
              meff.Light := 3;
            end;
          30:
            begin //ʥ����
              meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty,
                mtype, Recusion, anitime);
              meff.MagExplosionBase := 3930;
              meff.TargetActor := target;
              meff.NextFrameTime := 80;
              meff.ExplosionFrame := 16;
              meff.Light := 3;
            end;
          31:
            begin //������
              meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty,
                mtype, Recusion, anitime);
              meff.MagExplosionBase := 3850;
              meff.TargetActor := nil; //target;
              meff.NextFrameTime := 80;
              meff.ExplosionFrame := 20;
              meff.Light := 3;
            end;
          34:
            begin //�����
              meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty,
                mtype, Recusion, anitime);
              meff.MagExplosionBase := 140;
              meff.TargetActor := target; //target;
              meff.NextFrameTime := 80;
              meff.ExplosionFrame := 20;
              meff.Light := 3;
              if wimg <> nil then
                meff.ImgLib := wimg;
            end;

          {39: begin //������
            meff := TMagicEff.Create (magnumb,410, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase:=570;
            meff.ExplosionFrame := 10;
            meff.TargetActor := target;
            if wimg <> nil then
              meff.ImgLib:=wimg;
          end;}
          40:
            begin // ������
              meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty,
                mtype, Recusion, anitime);
              meff.MagExplosionBase := 620;
              meff.TargetActor := nil; //target;
              meff.NextFrameTime := 100;
              meff.ExplosionFrame := 20;
              meff.Light := 3;
              if wimg <> nil then
                meff.ImgLib := wimg;
            end;
          45:
            begin //��������
              meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty,
                mtype, Recusion, anitime);
              meff.MagExplosionBase := 920;
              meff.TargetActor := nil; //target;
              meff.NextFrameTime := 100;
              meff.ExplosionFrame := 20;
              meff.Light := 3;
              if wimg <> nil then
                meff.ImgLib := wimg;
            end;
          47:
            begin //쫷���
              meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty,
                mtype, Recusion, anitime);
              meff.MagExplosionBase := 1010;
              meff.TargetActor := nil; //target;
              meff.NextFrameTime := 100;
              meff.ExplosionFrame := 20;
              meff.Light := 3;
              if wimg <> nil then
                meff.ImgLib := wimg;
            end;
          48:
            begin //Ѫ��
              meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty,
                mtype, Recusion, anitime);
              meff.MagExplosionBase := 1060;
              meff.TargetActor := target;
              meff.NextFrameTime := 50;
              meff.ExplosionFrame := 20;
              meff.Light := 3;
              if wimg <> nil then
                meff.ImgLib := wimg;
              //PlaySoundEx(bmg_SKILL_48_0);
            end;
          49:
            begin //������
              meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty,
                mtype, Recusion, anitime);
              meff.MagExplosionBase := 1110;
              meff.TargetActor := nil; //target;
              meff.NextFrameTime := 100;
              meff.ExplosionFrame := 10;
              meff.Light := 3;
              if wimg <> nil then
                meff.ImgLib := wimg;
            end;
        else
          begin //Ĭ��
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype,
              Recusion, anitime);
            meff.TargetActor := target;
            meff.NextFrameTime := 80;
          end;
        end;
      mtFireWind:
        begin
           case magnumb of
          66:
            begin //��������
               meff := TThuderEffect.Create(700, scx, scy, nil); //target);
                meff.ExplosionFrame := 10;
                meff.NextFrameTime := 80;
                if wimg <> nil then
                  meff.ImgLib := wimg;
            end;
           end;
      //    meff := nil;
          {case magnumb of
             40: begin   //�ٻ�����
               meff := TThuderEffect.Create (1260, sctx, scty, nil); //target);
               meff.ExplosionFrame := 10;
               meff.NextFrameTime := 80;
               meff.ImgLib := FrmMain.WMon18Img;
             end;
          end;}
          //Dscreen.AddSysMsg (IntToStr(Integer(mtype))+'  '+IntToStr(magnumb));
        end;
      mtFireGun:
        meff := TFireGunEffect.Create(930, scx, scy, sctx, scty);
      mtThunder:
        begin
          //Dscreen.AddSysMsg (format('%d-%d',[magid,magnumb]));
          case magnumb of
            9:
              begin //�׵���
                meff := TThuderEffect.Create(10, sctx, scty, nil); //target);
                meff.ExplosionFrame := 10;
                meff.NextFrameTime := 80;
                meff.ImgLib := g_WMagic2Images;
              end;
            70:
              begin //Ⱥ���׵���
                meff := TThuderEffect.Create(950, sctx, scty, nil); //target);
                meff.ExplosionFrame := 10;
                meff.NextFrameTime := 80;
                meff.ImgLib := g_WMagicImages;
              end;
            61:
              begin //����ն
                meff := TThuderEffect.Create(495, sctx, scty, nil); //target);
                // meff.MagExplosionBase := 395;
                meff.ExplosionFrame := 23;
                meff.NextFrameTime := 80;
                if wimg <> nil then
                  meff.ImgLib := wimg;
              end;
            62:
              begin //����һ��
                  //TThuderEffect�ĸ���ΪTmagic �Ӵ���̳�������
                meff := TThuderEffect.Create(effnum, sctx, scty, nil); //������
                //meff.MagExplosionBase := 395;
                meff.ExplosionFrame := 24; //ײ�����Ժ�ִ��24������
                meff.NextFrameTime := 80; //ִ�м��ʱ��Ϊ80����
                if wimg <> nil then
                  meff.ImgLib := wimg; //ImgLibΪĳ��WIL
              end;
            64:
              begin //ĩ������
                meff := TThuderEffect.Create(230, sctx, scty, nil); //target); //
                //meff.MagExplosionBase := 395;
                meff.ExplosionFrame := 26;
                meff.NextFrameTime := 80;
                if wimg <> nil then
                  meff.ImgLib := wimg;
              end;
            65:
              begin //��������
                meff := TThuderEffect.Create(561, sctx, scty, nil); //target);
                //meff.MagExplosionBase := 395;
                meff.ExplosionFrame := 36;
                meff.NextFrameTime := 80;
                if wimg <> nil then
                  meff.ImgLib := wimg;
              end;
          else
            begin
              meff := TThuderEffect.Create(effnum, sctx, scty, nil); //target);
              meff.ExplosionFrame := 10;
              meff.NextFrameTime := 80;
              meff.ImgLib := wimg;
            end;
          end;

        end;
      mtLightingThunder:
        meff := TLightingThunder.Create(970, scx, scy, sctx, scty, target);
      mtExploBujauk:
        begin
          case magnumb of
            10:
              begin //
                meff := TExploBujaukEffect.Create(1160, scx, scy, sctx, scty,
                  target);
                meff.MagExplosionBase := 1360;
              end;
            17:
              begin //
                meff := TExploBujaukEffect.Create(1160, scx, scy, sctx, scty,
                  target);
                meff.MagExplosionBase := 1540;
              end;
            70:
              begin //
                meff := TExploBujaukEffect.Create(140, scx, scy, sctx, scty,
                  target);
                meff.MagExplosionBase := 300;
                meff.ImgLib := g_WMagic6Images;
                TExploBujaukEffect(meff).m_boWb := True;
              end;
          end;
          bofly := TRUE;
        end;
      mtBujaukGroundEffect:
        begin
          meff := TBujaukGroundEffect.Create(1160, magnumb, scx, scy, sctx,
            scty);
          case magnumb of
            11: meff.ExplosionFrame := 16; //
            12: meff.ExplosionFrame := 16; //
            46: meff.ExplosionFrame := 24;
          end;
          bofly := TRUE;
        end;
      mtKyulKai:
        begin
          meff := nil; //TKyulKai.Create (1380, scx, scy, sctx, scty);
        end;
      mt12:
        begin

        end;
      mt13:
        begin
          meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype,
            Recusion, anitime);
          if meff <> nil then
          begin
            case magnumb of
              32:
                begin
                  meff.ImgLib := GetMonEx(21 - 1);
                  meff.MagExplosionBase := 3580;
                  meff.TargetActor := target;
                  meff.Light := 3;
                  meff.NextFrameTime := 20;
                end;
              37:
                begin
                  meff.ImgLib := GetMonEx(22 - 1);
                  meff.MagExplosionBase := 3520;
                  meff.TargetActor := target;
                  meff.Light := 5;
                  meff.NextFrameTime := 20;
                end;
            end;
          end;
        end;
      mt14:
        begin
          if magnumb = 72 then
          begin
            meff := TThuderEffect.Create(100, sctx, scty, nil); //target);
            meff.ExplosionFrame := 15;
            meff.ImgLib := g_WMagic6Images;
          end
          else
          begin
            meff := TThuderEffect.Create(140, sctx, scty, nil); //target);
            meff.ExplosionFrame := 10;
            meff.ImgLib := g_WMagic2Images;
          end;
        end;
      mt15:
        begin
          meff := TFlyingBug.Create(magid, effnum, scx, scy, sctx, scty, mtype,
            Recusion, anitime);
          meff.TargetActor := target;
          bofly := True;
        end;
      mt16:
        begin

        end;
    end;
    if (meff = nil) then
      exit;

    meff.TargetRx := tx;
    meff.TargetRy := ty;
    if meff.TargetActor <> nil then
    begin
      meff.TargetRx := TActor(meff.TargetActor).m_nCurrX;
      meff.TargetRy := TActor(meff.TargetActor).m_nCurrY;
    end;
    meff.MagOwner := aowner;
    m_EffectList.Add(meff);
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.NewMagic'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.DelMagic(magid: integer);
var
  i: integer;
begin
  try //�����Զ�����
    for i := 0 to m_EffectList.Count - 1 do
    begin
      if TMagicEff(m_EffectList[i]).ServerMagicId = magid then
      begin
        TMagicEff(m_EffectList[i]).Free;
        m_EffectList.Delete(i);
        break;
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.DelMagic'); //�����Զ�����
  end; //�����Զ�����
end;

//cx, cy, tx, ty : ���� ��ǥ

function TPlayScene.NewFlyObject(aowner: TActor; cx, cy, tx, ty, targetcode:
  integer; mtype: TMagicType): TMagicEff;
var
  i, scx, scy, sctx, scty: integer;
  meff: TMagicEff;
begin
  try //�����Զ�����
    ScreenXYfromMCXY(cx, cy, scx, scy);
    ScreenXYfromMCXY(tx, ty, sctx, scty);
    case mtype of
      mtFlyArrow: meff := TFlyingArrow.Create(1, 1, scx, scy, sctx, scty, mtype,
          TRUE, 0);
      mt12: meff := TFlyingFireBall.Create(1, 1, scx, scy, sctx, scty, mtype,
          TRUE, 0);
      mt15: meff := TFlyingBug.Create(1, 1, scx, scy, sctx, scty, mtype, TRUE,
          0);
    else
      meff := TFlyingAxe.Create(1, 1, scx, scy, sctx, scty, mtype, TRUE, 0);
    end;
    meff.TargetRx := tx;
    meff.TargetRy := ty;
    meff.TargetActor := FindActor(targetcode);
    meff.MagOwner := aowner;
    m_FlyList.Add(meff);
    Result := meff;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.NewFlyObject'); //�����Զ�����
  end; //�����Զ�����
end;

//������ ������ ����ó�� ��� ������ ����
//effnum: �� ��ȣ���� Base�� �� �ٸ���.
{function  NewStaticMagic (aowner: TActor; tx, ty, targetcode, effnum: integer);
var
   i, scx, scy, sctx, scty, effbase: integer;
   meff: TMagicEff;
begin
   ScreenXYfromMCXY (cx, cy, scx, scy);
   ScreenXYfromMCXY (tx, ty, sctx, scty);
   case effnum of
      1: effbase := 340;   //������ ����Ʈ���� ���� ��ġ
      else exit;
   end;

   meff := TLightingEffect.Create (effbase, 1, 1, scx, scy, sctx, scty, mtype, TRUE, 0);
   meff.TargetRx := tx;
   meff.TargetRy := ty;
   meff.TargetActor := FindActor (targetcode);
   meff.MagOwner := aowner;
   FlyList.Add (meff);
   Result := meff;
end;  }

{-------------------------------------------------------}

//�� ��ǥ��� �� �߾��� ��ũ�� ��ǥ�� ��
{procedure TPlayScene.ScreenXYfromMCXY (cx, cy: integer; var sx, sy: integer);
begin
   if Myself = nil then exit;
   sx := -UNITX*2 - Myself.ShiftX + AAX + 14 + (cx - Map.ClientRect.Left) * UNITX + UNITX div 2;
   sy := -UNITY*3 - Myself.ShiftY + (cy - Map.ClientRect.Top) * UNITY + UNITY div 2;
end; }

procedure TPlayScene.ScreenXYfromMCXY(cx, cy: integer; var sx, sy: integer);
begin
  try //�����Զ�����
    if g_MySelf = nil then
      exit;
{$IF SWH = SWH800}
    sx := (cx - g_MySelf.m_nRx) * UNITX + 364 + UNITX div 2 -
      g_MySelf.m_nShiftX;
    sy := (cy - g_MySelf.m_nRy) * UNITY + 192 + UNITY div 2 -
      g_MySelf.m_nShiftY;
{$ELSEIF SWH = SWH1024}
    sx := (cx - g_MySelf.m_nRx) * UNITX + 485 {364,485} + UNITX div 2 -
    g_MySelf.m_nShiftX;
    sy := (cy - g_MySelf.m_nRy) * UNITY + 270 {192,270} + UNITY div 2 -
    g_MySelf.m_nShiftY;
{$IFEND}
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.ScreenXYfromMCXY'); //�����Զ�����
  end; //�����Զ�����
end;

//��Ļ���� mx, myת����ccx, ccy��ͼ����

procedure TPlayScene.CXYfromMouseXY(mx, my: integer; var ccx, ccy: integer);
begin
  try //�����Զ�����
    if g_MySelf = nil then
      exit;
{$IF SWH = SWH800}
    ccx := Round((mx - 364 + g_MySelf.m_nShiftX - UNITX div 2) / UNITX) +
      g_MySelf.m_nRx;
    ccy := Round((my - 192 + g_MySelf.m_nShiftY - UNITY div 2) / UNITY) +
      g_MySelf.m_nRy;
{$ELSEIF SWH = SWH1024}
    ccx := Round((mx - 485 {364,485} + g_MySelf.m_nShiftX - UNITX) / UNITX) +
      g_MySelf.m_nRx;
    ccy := Round((my - 270 {192,270} + g_MySelf.m_nShiftY - UNITY) / UNITY) +
      g_MySelf.m_nRy;
{$IFEND}
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.CXYfromMouseXY'); //�����Զ�����
  end; //�����Զ�����
end;

//ȭ����ǥ�� ĳ����, �ȼ� ������ ����..

function TPlayScene.GetCharacter(x, y, wantsel: integer; var nowsel: integer;
  liveonly: Boolean): TActor;
var
  k, i, ccx, ccy, dx, dy: integer;
  a: TActor;
begin
  try //�����Զ�����
    Result := nil;
    nowsel := -1;
    CXYfromMouseXY(x, y, ccx, ccy);
    for k := ccy + 8 downto ccy - 1 do
    begin
      for i := m_ActorList.Count - 1 downto 0 do
        if TActor(m_ActorList[i]) <> g_MySelf then
        begin
          a := TActor(m_ActorList[i]);
          if (not liveonly or not a.m_boDeath) and (a.m_boHoldPlace) and
            (a.m_boVisible) then
          begin
            if a.m_nCurrY = k then
            begin
              //�� ���� ������ ���õǰ�
              dx := (a.m_nRx - Map.m_ClientRect.Left) * UNITX + m_nDefXX +
                a.m_nPx + a.m_nShiftX;
              dy := (a.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + m_nDefYY +
                a.m_nPy + a.m_nShiftY;
              if a.CheckSelect(x - dx, y - dy) then
              begin
                Result := a;
                Inc(nowsel);
                if nowsel >= wantsel then
                  exit;
              end;
            end;
          end;
        end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.GetCharacter'); //�����Զ�����
  end; //�����Զ�����
end;

//ȡ�������ָ����Ľ�ɫ

function TPlayScene.GetAttackFocusCharacter(x, y, wantsel: integer; var nowsel:
  integer; liveonly: Boolean): TActor;
var
  k, i, ccx, ccy, dx, dy, centx, centy: integer;
  a: TActor;
begin
  try //�����Զ�����
    Result := GetCharacter(x, y, wantsel, nowsel, liveonly);
    if Result = nil then
    begin
      nowsel := -1;
      CXYfromMouseXY(x, y, ccx, ccy);
      for k := ccy + 8 downto ccy - 1 do
      begin
        for i := m_ActorList.Count - 1 downto 0 do
          if TActor(m_ActorList[i]) <> g_MySelf then
          begin
            a := TActor(m_ActorList[i]);
            if (not liveonly or not a.m_boDeath) and (a.m_boHoldPlace) and
              (a.m_boVisible) then
            begin
              if a.m_nCurrY = k then
              begin
                //
                dx := (a.m_nRx - Map.m_ClientRect.Left) * UNITX + m_nDefXX +
                  a.m_nPx + a.m_nShiftX;
                dy := (a.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + m_nDefYY +
                  a.m_nPy + a.m_nShiftY;
                if a.CharWidth > 40 then
                  centx := (a.CharWidth - 40) div 2
                else
                  centx := 0;
                if a.CharHeight > 70 then
                  centy := (a.CharHeight - 70) div 2
                else
                  centy := 0;
                if (x - dx >= centx) and (x - dx <= a.CharWidth - centx) and (y
                  - dy >= centy) and (y - dy <= a.CharHeight - centy) then
                begin
                  Result := a;
                  Inc(nowsel);
                  if nowsel >= wantsel then
                    exit;
                end;
              end;
            end;
          end;
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.GetAttackFocusCharacter');
    //�����Զ�����
  end; //�����Զ�����
end;

function TPlayScene.IsSelectMyself(x, y: integer): Boolean;
var
  k, i, ccx, ccy, dx, dy: integer;
begin
  try //�����Զ�����
    Result := FALSE;
    CXYfromMouseXY(x, y, ccx, ccy);
    for k := ccy + 2 downto ccy - 1 do
    begin
      if g_MySelf.m_nCurrY = k then
      begin
        //�� ���� ������ ���õǰ�
        dx := (g_MySelf.m_nRx - Map.m_ClientRect.Left) * UNITX + m_nDefXX +
          g_MySelf.m_nPx + g_MySelf.m_nShiftX;
        dy := (g_MySelf.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + m_nDefYY +
          g_MySelf.m_nPy + g_MySelf.m_nShiftY;
        if g_MySelf.CheckSelect(x - dx, y - dy) then
        begin
          Result := TRUE;
          exit;
        end;
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.IsSelectMyself'); //�����Զ�����
  end; //�����Զ�����
end;
//ȡ��ָ�����������Ʒ
// x,y Ϊ��Ļ����

function TPlayScene.GetDropItems(x, y: integer; var inames: string): PTDropItem;
//ȭ����ǥ�� ������
var
  k, i, ccx, ccy, ssx, ssy, dx, dy: integer;
  DropItem: PTDropItem;
  s: TDirectDrawSurface;
  c: byte;
begin
  try //�����Զ�����
    Result := nil;
    CXYfromMouseXY(x, y, ccx, ccy);
    ScreenXYfromMCXY(ccx, ccy, ssx, ssy);
    //dx := x - ccx;
    //dy := y - ccy;
    inames := '';
    for i := 0 to g_DropedItemList.Count - 1 do
    begin
      DropItem := PTDropItem(g_DropedItemList[i]);
      if (DropItem.X = ccx) and (DropItem.Y = ccy) then
      begin

        //s := g_WDnItemImages.Images[DropItem.Looks];
        s := FrmMain.GetWDnItemImg(DropItem.Looks);
        if s = nil then
          continue;
        dx := (x - ssx) + (s.Width div 2) - 3;
        dy := (y - ssy) + (s.Height div 2);
        //dx := s.Width;
        //dy := s.Height;
        //c := s.Pixels[dx, dy];
        //if c <> 0 then begin

        if Result = nil then
          Result := DropItem;
        inames := inames + DropItem.Name + '\';
        //break;
      //end;
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.GetDropItems'); //�����Զ�����
  end; //�����Զ�����
end;

function TPlayScene.FindActorXYCount(x, y, nFalg: integer; var HumList: TList):
  Boolean;
var
  StartX, StartY, EndX, EndY: Integer;
  i: Integer;
  Actor: TActor;
begin
  try //�����Զ�����
    Result := False;
    try
      HumList.Clear;

      StartX := x - nFalg;
      StartY := Y - nFalg;
      EndX := x + nFalg;
      EndY := Y + nFalg;

      for i := 0 to m_ActorList.Count - 1 do
      begin
        Actor := TActor(m_ActorList[i]);
        if (Actor <> nil) and
          (not Actor.m_boDeath) and
          (Actor.m_nCurrX in [StartX..EndX]) and
          (Actor.m_nCurrY in [StartY..EndY]) then
        begin
          Result := True;
          HumList.Add(Actor);
        end;
      end;
    except
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.FindActorXYCount'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.GetXYDropItemsList(nX, nY: Integer; var ItemList: TList);
var
  I: Integer;
  DropItem: pTDropItem;
begin
  try //�����Զ�����
    for I := 0 to g_DropedItemList.Count - 1 do
    begin
      DropItem := g_DropedItemList[i];
      if (DropItem.X = nX) and (DropItem.Y = nY) then
      begin
        ItemList.Add(DropItem);
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.GetXYDropItemsList');
    //�����Զ�����
  end; //�����Զ�����
end;

function TPlayScene.GetXYDropItems(nX, nY: Integer): pTDropItem;
var
  I: Integer;
  DropItem: pTDropItem;
begin
  try //�����Զ�����
    Result := nil;
    for I := 0 to g_DropedItemList.Count - 1 do
    begin
      DropItem := g_DropedItemList[i];
      if (DropItem.X = nX) and (DropItem.Y = nY) then
      begin
        Result := DropItem;
        break;
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.GetXYDropItems'); //�����Զ�����
  end; //�����Զ�����
end;

function TPlayScene.CanRun(sx, sy, ex, ey: integer): Boolean;
var
  ndir, rx, ry: integer;
begin
  try //�����Զ�����
    ndir := GetNextDirection(sx, sy, ex, ey);
    rx := sx;
    ry := sy;
    GetNextPosXY(ndir, rx, ry);

    if Map.CanMove(rx, ry) and Map.CanMove(ex, ey) then
      Result := True
    else
      Result := False;

    if CanWalkEx(rx, ry) and CanWalkEx(ex, ey) then
      Result := TRUE
    else
      Result := FALSE;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.CanRun'); //�����Զ�����
  end; //�����Զ�����
end;

function TPlayScene.CanRunEx(sx, sy, ex, ey: Integer): Boolean;
var
  ndir, rx, ry: Integer;
begin
  ndir := GetNextDirection(sx, sy, ex, ey);
  rx := sx;
  ry := sy;
  GetNextPosXY(ndir, rx, ry);

  if CanWalkEx2(rx, ry) and CanWalkEx2(ex, ey) then
    Result := True
  else Result := FALSE;
end;

function TPlayScene.CanWalkEx(mx, my: integer): Boolean;
begin
  try //�����Զ�����
    Result := FALSE;
    if Map.CanMove(mx, my) then
      Result := not CrashManEx(mx, my);
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.CanWalkEx'); //�����Զ�����
  end; //�����Զ�����
end;

function TPlayScene.CanWalkEx2(mx, my: Integer): Boolean;
begin
  Result := FALSE;
  if Map.CanMove(mx, my) then
    Result := not CrashManEx2(mx, my);
end;

//����

function TPlayScene.CrashManEx(mx, my: integer): Boolean;
var
  I: Integer;
  Actor: TActor;
begin
  Result := False;
  for i := 0 to m_ActorList.Count - 1 do
  begin
    Actor := TActor(m_ActorList[i]);
    if (Actor.m_boVisible) and (Actor.m_boHoldPlace) and (not Actor.m_boDeath)
      and (Actor.m_nCurrX = mx) and (Actor.m_nCurrY = my) then
    begin
      //      DScreen.AddChatBoardString ('Actor.m_btRace ' + IntToStr(Actor.m_btRace),clWhite, clRed);
      if (Actor.m_btRace = RCC_USERHUMAN) and g_wginfo.boCanRunHuman then
        Continue;
      if (Actor.m_btRace = RCC_MERCHANT) and g_wginfo.boCanRunNpc then
        Continue;
      if ((Actor.m_btRace > RCC_USERHUMAN) and (Actor.m_btRace <> RCC_MERCHANT))
        and g_wginfo.boCanRunMon then
        Continue;
      //m_btRace ���� 0 �������� 50 ��Ϊ����
      Result := True;
      break;
    end;
  end;
end;

function TPlayScene.CrashManEx2(mx, my: Integer): Boolean;
var
  i: Integer;
  Actor: TActor;
begin
  Result := FALSE;
  for i := 0 to m_ActorList.count - 1 do begin
    Actor := TActor(m_ActorList[i]);
    if (Actor.m_boVisible) and (Actor.m_boHoldPlace) and (not Actor.m_boDeath) and (Actor.m_nCurrX = mx) and (Actor.m_nCurrY = my) then begin
      Result := True;
      break;
    end;
  end;
end;

function TPlayScene.CanWalk(mx, my: integer): Boolean;
begin
  try //�����Զ�����
    Result := FALSE;
    if Map.CanMove(mx, my) then
      Result := not CrashMan(mx, my);
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.CrashManEx'); //�����Զ�����
  end; //�����Զ�����
end;

function TPlayScene.CrashMan(mx, my: integer): Boolean;
var
  i: integer;
  a: TActor;
begin
  try //�����Զ�����
    Result := FALSE;
    for i := 0 to m_ActorList.Count - 1 do
    begin
      a := TActor(m_ActorList[i]);
      if (a.m_boVisible) and (a.m_boHoldPlace) and (not a.m_boDeath) and
        (a.m_nCurrX = mx) and (a.m_nCurrY = my) then
      begin
        Result := TRUE;
        break;
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.CrashMan'); //�����Զ�����
  end; //�����Զ�����
end;

function TPlayScene.CanFly(mx, my: integer): Boolean;
begin
  try //�����Զ�����
    Result := Map.CanFly(mx, my);
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.CanFly'); //�����Զ�����
  end; //�����Զ�����
end;

{------------------------ Actor ------------------------}

function TPlayScene.FindActor(id: integer): TActor;
var
  i: integer;
begin
  try //�����Զ�����
    Result := nil;
    for i := 0 to m_ActorList.Count - 1 do
    begin
      if TActor(m_ActorList[i]).m_nRecogId = id then
      begin
        Result := TActor(m_ActorList[i]);
        break;
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.FindActor'); //�����Զ�����
  end; //�����Զ�����
end;

function TPlayScene.FindActor(sName: string): TActor;
var
  I: Integer;
  Actor: TActor;
begin
  try //�����Զ�����
    Result := nil;
    for I := 0 to m_ActorList.Count - 1 do
    begin
      Actor := TActor(m_ActorList[i]);
      if CompareText(Actor.m_sUserName, sName) = 0 then
      begin
        Result := Actor;
        break;
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.FindActor'); //�����Զ�����
  end; //�����Զ�����
end;

function TPlayScene.FindActorXY(x, y: integer): TActor;
//�� ��ǥ�� actor ����
var
  i: integer;
begin
  try //�����Զ�����
    Result := nil;
    for i := 0 to m_ActorList.Count - 1 do
    begin
      if (TActor(m_ActorList[i]).m_nCurrX = x) and
        (TActor(m_ActorList[i]).m_nCurrY = y) then
      begin
        Result := TActor(m_ActorList[i]);
        if not Result.m_boDeath and Result.m_boVisible and Result.m_boHoldPlace
          then
          break;
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.FindActorXY'); //�����Զ�����
  end; //�����Զ�����
end;

function TPlayScene.IsValidActor(actor: TActor): Boolean;
var
  i: integer;
begin
  try //�����Զ�����
    Result := FALSE;
    for i := 0 to m_ActorList.Count - 1 do
    begin
      if TActor(m_ActorList[i]) = actor then
      begin
        Result := TRUE;
        break;
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.IsValidActor'); //�����Զ�����
  end; //�����Զ�����
end;

function TPlayScene.NewActor(chrid: integer;
  cx: word; //x
  cy: word; //y
  cdir: word;
  cfeature: integer; //race, hair, dress, weapon
  cstate: integer): TActor;
var
  i: integer;
  actor: TActor;
begin
  try //�����Զ�����
    Result := nil; //jacky
    for i := 0 to m_ActorList.Count - 1 do
      if TActor(m_ActorList[i]).m_nRecogId = chrid then
      begin
        Result := TActor(m_ActorList[i]);
        exit; //�̹� ����
      end;
    if IsChangingFace(chrid) then
      exit; //������...

    //DScreen.AddHitMsg(IntToStr(RACEfeature (cfeature)));
    case RACEfeature(cfeature) of //m_btRaceImg
      0: actor := THumActor.Create; //����
      9: actor := TSoccerBall.Create; //����
      13: actor := TKillingHerb.Create; //ʳ�˻�
      14: actor := TSkeletonOma.Create; //����
      15: actor := TDualAxeOma.Create; //��������

      16: actor := TGasKuDeGi.Create; //����

      17: actor := TCatMon.Create; //��צè
      18: actor := THuSuABi.Create; //������
      19: actor := TCatMon.Create; //����սʿ
      //19: actor := TPsycheActor.Create;

      20: actor := TFireCowFaceMon.Create; //��������
      21: actor := TCowFaceKing.Create; //�������
      22: actor := TDualAxeOma.Create; //�ڰ�սʿ
      23: actor := TWhiteSkeleton.Create; //��������
      24: actor := TSuperiorGuard.Create; //������ʿ
      30: actor := TCatMon.Create; //������
      31: actor := TCatMon.Create; //��Ӭ
      32: actor := TScorpionMon.Create; //Ы��

      33: actor := TCentipedeKingMon.Create; //������
      34: actor := TBigHeartMon.Create; //���¶�ħ
      35: actor := TSpiderHouseMon.Create; //��Ӱ֩��
      36: actor := TExplosionSpider.Create; //��ħ֩��
      37: actor := TFlyingSpider.Create; //

      40: actor := TZombiLighting.Create; //��ʬ1
      41: actor := TZombiDigOut.Create; //��ʬ2
      42: actor := TZombiZilkin.Create; //��ʬ3

      43: actor := TBeeQueen.Create; //��Ӭ��

      45: actor := TArcherMon.Create; //������
      47: actor := TSculptureMon.Create; //�������
      48: actor := TSculptureMon.Create; //
      49: actor := TSculptureKingMon.Create; //�������

      50: actor := TNpcActor.Create;   //NPC���� RaceImgΪ50��NPC  �������û���������  M2Ĭ�Ϸ���

      52: actor := TGasKuDeGi.Create; //Ш��
      53: actor := TGasKuDeGi.Create; //���
      54: actor := TSmallElfMonster.Create; //����
      55: actor := TWarriorElfMonster.Create; //����1

      60: actor := TElectronicScolpionMon.Create;
      61: actor := TBossPigMon.Create;
      62: actor := TKingOfSculpureKingMon.Create;
      63: actor := TSkeletonKingMon.Create;
      64: actor := TGasKuDeGi.Create;
      65: actor := TSamuraiMon.Create;
      66: actor := TSkeletonSoldierMon.Create;
      67: actor := TSkeletonSoldierMon.Create;
      68: actor := TSkeletonSoldierMon.Create;
      69: actor := TSkeletonArcherMon.Create;
      70: actor := TBanyaGuardMon.Create;
      71: actor := TBanyaGuardMon.Create;
      72: actor := TBanyaGuardMon.Create;
      73: actor := TPBOMA1Mon.Create;
      74: actor := TCatMon.Create;
      75: actor := TStoneMonster.Create;
      76: actor := TSuperiorGuard.Create;
      77: actor := TStoneMonster.Create;
      78: actor := TBanyaGuardMon.Create;
      79: actor := TPBOMA6Mon.Create;
      80: actor := TMineMon.Create;
      81: actor := TAngel.Create;
      83: actor := TFireDragon.Create;
      84: actor := TDragonStatue.Create;

      90: actor := TDragonBody.Create; //��
      98: actor := TWallStructure.Create; //LeftWall
      99: actor := TCastleDoor.Create; //MainDoor
      100: actor := TPsycheActor.Create;
      //100:actor := TGasKuDeGi.Create;
    else
      actor := TActor.Create;
    end;

    with actor do
    begin
      m_nRecogId := chrid;
      m_nCurrX := cx;
      m_nCurrY := cy;
      m_nRx := m_nCurrX;
      m_nRy := m_nCurrY;
      m_btDir := cdir;
      m_nFeature := cfeature;
      m_btRace := RACEfeature(cfeature); //changefeature�� ��������
      m_btHair := HAIRfeature(cfeature); //����ȴ�.
      m_btDress := DRESSfeature(cfeature);
      m_btWeapon := WEAPONfeature(cfeature);
      m_wAppearance := APPRfeature(cfeature);
      //      Horse:=Horsefeature(cfeature);
      //      Effect:=Effectfeature(cfeature);
            //m_Action     := GetMonAction(m_wAppearance);
      if m_btRace = 0 then
      begin
        m_btSex := m_btDress mod 2; //0:���� 1:����
      end
      else
      begin
        m_btSex := 0;
      end;
      m_nState := cstate;
      m_SayingArr[0] := '';
    end;
    m_ActorList.Add(actor);
    Result := actor;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.NewActor'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.ActorDied(actor: TObject);
var
  i: integer;
  flag: Boolean;
begin
  try //�����Զ�����
    for i := 0 to m_ActorList.Count - 1 do
      if m_ActorList[i] = actor then
      begin
        m_ActorList.Delete(i);
        break;
      end;
    flag := FALSE;
    for i := 0 to m_ActorList.Count - 1 do
      if not TActor(m_ActorList[i]).m_boDeath then
      begin
        m_ActorList.Insert(i, actor);
        flag := TRUE;
        break;
      end;
    if not flag then
      m_ActorList.Add(actor);
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.ActorDied'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.SetActorDrawLevel(actor: TObject; level: integer);
var
  i: integer;
begin
  try //�����Զ�����
    if level = 0 then
    begin //�� ó���� �׸����� ��
      for i := 0 to m_ActorList.Count - 1 do
        if m_ActorList[i] = actor then
        begin
          m_ActorList.Delete(i);
          m_ActorList.Insert(0, actor);
          break;
        end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.SetActorDrawLevel'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.ClearActors; //�α׾ƿ��� ���
var
  i: integer;
begin
  try //�����Զ�����
    for i := 0 to m_ActorList.Count - 1 do
      TActor(m_ActorList[i]).Free;
    m_ActorList.Clear;
    g_MySelf := nil;
    g_HeronRecogId := 0;
    g_HerobtJob := 0;
    g_boSendHeroCall := False;
    g_TargetCret := nil;
    g_FocusCret := nil;
    g_MagicTarget := nil;
    g_MagicLockActor := nil;

    //������ �ʱ�ȭ �ؾ���.
    for i := 0 to m_EffectList.Count - 1 do
      TMagicEff(m_EffectList[i]).Free;
    m_EffectList.Clear;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.ClearActors'); //�����Զ�����
  end; //�����Զ�����
end;

function TPlayScene.DeleteActor(id: integer): TActor;
var
  i: integer;
begin
  try //�����Զ�����
    Result := nil;
    i := 0;
    while TRUE do
    begin
      if i >= m_ActorList.Count then
        break;
      if (TActor(m_ActorList[i]).m_nRecogId = id) then
      begin
        if g_TargetCret = TActor(m_ActorList[i]) then
          g_TargetCret := nil;
        if g_FocusCret = TActor(m_ActorList[i]) then
          g_FocusCret := nil;
        if g_MagicLockActor = TActor(m_ActorList[i]) then
          g_MagicLockActor := nil;
        if g_MagicTarget = TActor(m_ActorList[i]) then
          g_MagicTarget := nil;
        TActor(m_ActorList[i]).m_dwDeleteTime := GetTickCount;
        g_FreeActorList.Add(m_ActorList[i]);
        //TActor(ActorList[i]).Free;
        m_ActorList.Delete(i);
      end
      else
      begin
        Inc(i);
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.DeleteActor'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.DelActor(actor: TObject);
var
  i: integer;
begin
  try //�����Զ�����
    for i := 0 to m_ActorList.Count - 1 do
      if (m_ActorList[i] = actor) then
      begin
        TActor(m_ActorList[i]).m_dwDeleteTime := GetTickCount;
        g_FreeActorList.Add(m_ActorList[i]);
        m_ActorList.Delete(i);
        break;
      end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.DelActor'); //�����Զ�����
  end; //�����Զ�����
end;

function TPlayScene.ButchAnimal(x, y: integer): TActor;
var
  i: integer;
  a: TActor;
begin
  try //�����Զ�����
    Result := nil;
    for i := 0 to m_ActorList.Count - 1 do
    begin
      a := TActor(m_ActorList[i]);
      if a.m_boDeath {and (a.m_btRace <> 0)} then
      begin //���� ��ü
        if (abs(a.m_nCurrX - x) <= 1) and (abs(a.m_nCurrY - y) <= 1) then
        begin
          Result := a;
          break;
        end;
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.ButchAnimal'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.SetEditChar(sMsg: string);
begin
  try //�����Զ�����
    if g_MySelf = nil then
      exit;
    if sMsg <> '' then
    begin
      EdChat.Visible := TRUE;
      EdChat.SetFocus;
      SetImeMode(EdChat.Handle, LocalLanguage);
      EdChat.Text := '/' + sMsg + ' ';
      EdChat.SelStart := Length(EdChat.Text);
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.SetEditChar'); //�����Զ�����
  end; //�����Զ�����
end;

procedure TPlayScene.SendMsg(ident, chrid, x, y, cdir, feature, state: integer;
  str: string);
var
  actor: TActor;
begin
  try //�����Զ�����
    case ident of
      SM_TEST:
        begin
          actor := NewActor(111, 254 {x}, 214 {y}, 0, 0, 0);
          g_MySelf := THumActor(actor);
          Map.LoadMap('0', g_MySelf.m_nCurrX, g_MySelf.m_nCurrY);
        end;
      SM_CHANGEMAP,
        SM_NEWMAP:
        begin
          Map.LoadMap(str, x, y);
          Map.LoadMapInfoEx;
          DarkLevel := cdir;
          if DarkLevel = 0 then
            g_boViewFog := FALSE
          else
            g_boViewFog := TRUE;
          //
          if g_boViewMiniMap then
          begin
            //              BoViewMiniMap := FALSE;
            g_nMiniMapIndex := -1;
            frmMain.SendWantMiniMap;
            FrmDlg.DMiniMapDlg.Visible := False;
          end;
          //
          if (ident = SM_NEWMAP) and (g_MySelf <> nil) then
          begin
            g_MySelf.m_nCurrX := x;
            g_MySelf.m_nCurrY := y;
            g_MySelf.m_nRx := x;
            g_MySelf.m_nRy := y;
            DelActor(g_MySelf);
          end;

        end;
      SM_LOGON:
        begin
          actor := FindActor(chrid);
          if actor = nil then
          begin
            actor := NewActor(chrid, x, y, Lobyte(cdir), feature, state);
            actor.m_nChrLight := Hibyte(cdir);
            cdir := Lobyte(cdir);
            actor.SendMsg(SM_TURN, x, y, cdir, feature, state, '', 0);
          end;
          if g_MySelf <> nil then
          begin
            g_MySelf := nil;
          end;
          g_MySelf := THumActor(actor);
        end;
      SM_899:
        begin
          actor := FindActor(chrid);
          if actor = nil then
          begin
            actor := NewActor(chrid, x, y, Lobyte(cdir), feature, state);
            actor.m_nChrLight := Hibyte(cdir);
            cdir := Lobyte(cdir);
            actor.SendMsg(SM_TURN, x, y, cdir, feature, state, '', 0);
          end;
          { if g_HeronRecogId<>0 then begin
              g_HeronRecogId:=0;
           end;  }
          g_HeronRecogId := actor.m_nRecogId;
        end;
      SM_HIDE:
        begin
          actor := FindActor(chrid);
          if actor <> nil then
          begin
            if actor.m_boDelActionAfterFinished then
            begin //������ ������� �ִϸ��̼��� ������ �ڵ����� �����.
              exit;
            end;
            if actor.m_nWaitForRecogId <> 0 then
            begin //������.. ������ ������ �ڵ����� �����
              exit;
            end;
          end;
          DeleteActor(chrid);
        end;
    else
      begin
        actor := FindActor(chrid);
        if (ident = SM_TURN) or (ident = SM_RUN) or (ident = SM_HORSERUN) or
          (ident = SM_WALK) or
          (ident = SM_BACKSTEP) or
          (ident = SM_DEATH) or (ident = SM_SKELETON) or
          (ident = SM_DIGUP) or (ident = SM_ALIVE) then
        begin
          if actor = nil then
            actor := NewActor(chrid, x, y, Lobyte(cdir), feature, state);
          if actor <> nil then
          begin
            actor.m_nChrLight := Hibyte(cdir);
            cdir := Lobyte(cdir);
            if ident = SM_SKELETON then
            begin
              actor.m_boDeath := TRUE;
              actor.m_boSkeleton := TRUE;
            end;
            //if (ident = SM_ALIVE) and (actor=g_MySelf) then SilenceSound;
            if ((ident = SM_RUN) or (ident = SM_WALK) or (ident = SM_TURN)) then
              AutoAttckMagic(ident, x, y);
          end;
        end;
        if actor = nil then
          exit;
        case ident of
          SM_FEATURECHANGED:
            begin
              actor.m_nFeature := feature;
              actor.m_nFeatureEx := state;
              actor.FeatureChanged;
            end;
          SM_CHARSTATUSCHANGED:
            begin
              actor.m_nState := Feature;
              actor.m_nHitSpeed2 := state;
            end;
        else
          begin
            if ident = SM_TURN then
            begin
              if str <> '' then
                actor.m_sUserName := str;
            end;
            actor.SendMsg(ident, x, y, cdir, feature, state, '', 0);
          end;
        end;
      end;
    end;
  except //�����Զ�����
    DebugOutStr('[Exception] TPlayScene.SendMsg'); //�����Զ�����
  end; //�����Զ�����
end;

end.

