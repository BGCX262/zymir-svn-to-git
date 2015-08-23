//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit magiceff;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grobal2, DxDraws, CliUtil, ClFunc, HUtil32, WIl;

const
  MG_READY = 10;
  MG_FLY = 6;
  MG_EXPLOSION = 10;
  READYTIME = 120;
  EXPLOSIONTIME = 100;
  FLYBASE = 10;
  EXPLOSIONBASE = 170;
  //EFFECTFRAME = 260;
  MAXMAGIC = 10;
  FLYOMAAXEBASE = 447;
  THORNBASE = 2967;
  ARCHERBASE = 2607;
  ARCHERBASE2 = 272; //2609;

  FLYFORSEC = 500;
  FIREGUNFRAME = 6;

  MAXEFFECT = 72 {31};
  {
  EffectBase: array[0..MAXEFFECT-1] of integer = (
     0,             //0  拳堪厘
     200,           //1  雀汗贱
     400,           //2  陛碍拳堪厘
     600,           //3  鞠楷贱
     0,             //4  八堡
     900,           //5  拳堪浅
     920,           //6  拳堪规荤
     940,           //7  汾牢厘 //矫傈瓤苞绝澜
     20,            //8  碍拜,  Magic2
     940,           //9  气混拌 //矫傈瓤苞绝澜
     940,           //10 措瘤盔龋 //矫傈瓤苞绝澜
     940,           //11 措瘤盔龋付 //矫傈瓤苞绝澜
     0,             //12 绢八贱
     1380,          //13 搬拌
     1500,          //14 归榜捧磊家券, 家券贱
     1520,          //15 篮脚贱
     940,           //16 措篮脚
     1560,          //17 傈扁面拜
     1590,          //18 鉴埃捞悼
     1620,          //19 瘤凯厘
     1650,          //20 拳堪气惯
     1680,          //21 措篮窍(傈扁欺咙)
     0,           //22 馆岿八过
     0,           //23 堪拳搬
     0,           //24 公怕焊
     3960,          //25 沤扁颇楷
     1790,          //26 措雀汗贱
     0,            //27 脚荐家券  Magic2
     3880,          //28 林贱狼阜
     3920,          //29 荤磊辣雀
     3840,          //30 葫汲浅
     1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18
  );
  }
  EffectBase: array[0..MAXEFFECT - 1] of integer = (
    0, {1}
    200, {2}
    400, {3}
    600, {4}
    0, {5}
    900, {6}
    920, {7}
    940, {8}
    20, {9}
    940, {10}
    940, {11}
    940, {12}
    0, {13}
    1380, {14}
    1500, {15}
    1520, {16}
    940, {17}
    1560, {18}
    1590, {19}
    1620, {20}
    1650, {21}
    1680, {22}
    0, {23}
    0, {24}
    0, {25}
    3960, {26}
    1790, {27}
    0, {28}
    3880, {29}
    3920, {30}
    3840, {31}
    0, {32}
    40, {33}
    130, {34}
    160, {35}
    190, {36}
    0, {37}
    210, {38}
    400, {39}
    600, {40}
    1260, {1500,41}
    0, {650,42}
    710, {43}
    740, {44}
    910, {45}
    940, {46}
    990, {47}
    1040, {48}
    1110, {49}
    20, {50}
    0, {51}
    40, {52}
    60, {53}
    80, {54}
    100, {55}
    120, {56}
    140, {57}
    160, {58}
    180, {59}
    10, {60}
    440, {61}
    390, {62}
    610, {63}
    0, {64}
    540, {65}
    0, {66}
    0, {67}
    0, {68}
    0, {69}
    120, {70}
    0, {71}
    80 {72}
    );
  MAXHITEFFECT = 15 {5};
  {
  HitEffectBase: array[0..MAXHITEFFECT-1] of integer = (
     800,           //0, 绢八贱
     1410,          //1 绢八贱
     1700,          //2 馆岿八过
     3480,          //3 堪拳搬, 矫累
     3390,          //4 堪拳搬 馆娄烙
     1,2,3
  );
  }
  HitEffectBase: array[0..MAXHITEFFECT - 1] of integer = (
    800,
    1410,
    1700,
    3480,
    3390,
    40,
    220 {220},
    740,
    10,
    310,
    460,
    470,
    630,
    0,
    510
    );
  MAXMAGICTYPE = 16;

type
  TMagicType = (mtReady, mtFly, mtExplosion,
    mtFlyAxe, mtFireWind, mtFireGun,
    mtLightingThunder, mtThunder, mtExploBujauk,
    mtBujaukGroundEffect, mtKyulKai, mtFlyArrow,
    mt12, mt13, mt14,
    mt15, mt16
    );

  TUseMagicInfo = record
    ServerMagicCode: integer;
    MagicSerial: integer;
    Target: integer; //recogcode
    EffectType: TMagicType;
    EffectNumber: integer;
    TargX: integer;
    TargY: integer;
    Recusion2: Boolean;
    AniTime: integer;
    ClientType: TMagicType;
  end;
  PTUseMagicInfo = ^TUseMagicInfo;

  TMagicEff = class //Size 0xC8
    m_boActive: Boolean; //0x04
    ServerMagicId: integer; //0x08
    MagOwner: TObject; //0x0C
    TargetActor: TObject; //0x10
    ImgLib: TWMImages; //0x14
    EffectBase: integer; //0x18
    MagExplosionBase: integer; //0x1C
    px, py: integer; //0x20 0x24
    RX, RY: integer; //0x28 0x2C
    Dir16, OldDir16: byte; //0x30  0x31
    TargetX, TargetY: integer; //0x34 0x38
    TargetRx, TargetRy: integer; //0x3C 0x40
    FlyX, FlyY, OldFlyX, OldFlyY: integer; //0x44 0x48 0x4C 0x50
    FlyXf, FlyYf: Real; //0x54 0x5C
    Repetition: Boolean; //0x64
    FixedEffect: Boolean; //0x65
    MagicType: integer; //0x68
    NextEffect: TMagicEff; //0x6C
    ExplosionFrame: integer; //0x70
    NextFrameTime: integer; //0x74
    Light: integer; //0x78
    n7C: Integer;
    bt80: Byte;
    bt81: Byte;
    start: integer; //0x84
    curframe: integer; //0x88
    frame: integer; //0x8C
  private

    m_dwFrameTime: longword; //0x90
    m_dwStartTime: longword; //0x94
    repeattime: longword; //0x98 馆汗 局聪皋捞记 矫埃 (-1: 拌加)
    steptime: longword; //0x9C
    fireX, fireY: integer; //0xA0 0xA4
    firedisX, firedisY: integer; //0xA8 0xAC
    newfiredisX, newfiredisY: integer; //0xB0 0xB4
    FireMyselfX, FireMyselfY: integer; //0xB8 0xBC
    prevdisx, prevdisy: integer; //0xC0 0xC4
  protected
    procedure GetFlyXY(ms: integer; var fx, fy: integer);
  public
    constructor Create(id, effnum, sx, sy, tx, ty: integer; mtype: TMagicType;
      Recusion: Boolean; anitime: integer);
    destructor Destroy; override;
    function Run: Boolean; dynamic; //false:场车澜.
    function Shift: Boolean; dynamic;
    procedure DrawEff(surface: TDirectDrawSurface); dynamic;
  end;

  TFlyingAxe = class(TMagicEff)
    FlyImageBase: integer;
    ReadyFrame: integer;
  public
    constructor Create(id, effnum, sx, sy, tx, ty: integer; mtype: TMagicType;
      Recusion: Boolean; anitime: integer);
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TFlyingBug = class(TMagicEff) //Size 0xD0
    FlyImageBase: integer; //0xC8
    ReadyFrame: integer; //0xCC
  public
    constructor Create(id, effnum, sx, sy, tx, ty: integer; mtype: TMagicType;
      Recusion: Boolean; anitime: integer);
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TFlyingArrow = class(TFlyingAxe)
  public
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;
  TFlyingFireBall = class(TFlyingAxe) //0xD0
  public
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;
  TCharEffect = class(TMagicEff)
  public
    constructor Create(effbase, effframe: integer; target: TObject);
    function Run: Boolean; override; //false:场车澜.
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TMapEffect = class(TMagicEff)
  public
    RepeatCount: integer;
    constructor Create(effbase, effframe: integer; x, y: integer);
    function Run: Boolean; override; //false:场车澜.
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TScrollHideEffect = class(TMapEffect)
  public
    constructor Create(effbase, effframe: integer; x, y: integer; target:
      TObject);
    function Run: Boolean; override;
  end;

  TLightingEffect = class(TMagicEff)
  public
    constructor Create(effbase, effframe: integer; x, y: integer);
    function Run: Boolean; override;
  end;

  TFireNode = record
    x: integer;
    y: integer;
    firenumber: integer;
  end;

  TFireGunEffect = class(TMagicEff)
  public
    OutofOil: Boolean;
    firetime: longword;
    FireNodes: array[0..FIREGUNFRAME - 1] of TFireNode;
    constructor Create(effbase, sx, sy, tx, ty: integer);
    function Run: Boolean; override;
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TThuderEffect = class(TMagicEff)
  public
    constructor Create(effbase, tx, ty: integer; target: TObject);
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TLightingThunder = class(TMagicEff)
  public
    constructor Create(effbase, sx, sy, tx, ty: integer; target: TObject);
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TExploBujaukEffect = class(TMagicEff)
    m_boWb: Boolean;
    m_nWbCount: Integer;
  public
    constructor Create(effbase, sx, sy, tx, ty: integer; target: TObject);
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TBujaukGroundEffect = class(TMagicEff) //Size  0xD0
  public
    MagicNumber: integer; //0xC8
    BoGroundEffect: Boolean; //0xCC
    constructor Create(effbase, magicnumb, sx, sy, tx, ty: integer);
    function Run: Boolean; override;
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;
  TNormalDrawEffect = class(TMagicEff) //Size 0xCC
    boC8: Boolean;
  public
    constructor Create(XX, YY: Integer; WmImage: TWMImages; effbase, nX:
      Integer; frmTime: LongWord; boFlag: Boolean);
    function Run: Boolean; override;
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TFlyDrawEffect = class(TMagicEff) //Size 0xCC
    boC8: Boolean;
    nExplosionBase: Integer;
  public
    constructor Create(XX, YY: Integer; WmImage: TWMImages; effbase,
      ExplosionBase, nX: Integer; frmTime: LongWord; boFlag: Boolean);
    function Run: Boolean; override;
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TCorpsDrawEffect = class(TMagicEff) //Size 0xCC
    boC8: Boolean;
    m_Actor: TObject;
  public
    constructor Create(Actor: TObject; WmImage: TWMImages; effbase, nX: Integer;
      frmTime: LongWord; boFlag: Boolean);
    function Run: Boolean; override;
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

procedure GetEffectBase(mag, mtype: integer; var wimg: TWMImages; var idx:
  integer);

implementation

uses
  ClMain, SoundUtil, Actor, MShare;

//取得魔法效果所在图库

procedure GetEffectBase(mag, mtype: integer; var wimg: TWMImages; var idx:
  integer);
begin
  try //程序自动增加
    wimg := nil;
    idx := 0;

    case mtype of
      0:
        begin
          case mag of
            8, 27, 33..35, 37..39, 42..48:
              begin

                wimg := g_WMagic2Images;
                if mag in [0..MAXEFFECT - 1] then
                  idx := EffectBase[mag];
              end;
            69, 71:
              begin
                wimg := g_WMagic6Images;
                if mag in [0..MAXEFFECT - 1] then
                  idx := EffectBase[mag];
              end;
            40:
              begin
                wimg := GetMonEx(18 - 1);
                if mag in [0..MAXEFFECT - 1] then
                  idx := EffectBase[mag];
              end;
            41:
              begin
                wimg := g_WMagic5Images;
                if mag in [0..MAXEFFECT - 1] then
                  idx := EffectBase[mag];
              end;
            50:
              begin
                wimg := g_WMagic6Images;
                idx := 630;
              end;
            51:
              begin
                wimg := g_WMagic6Images;
                idx := 710;
              end; //四级魔法盾
            65:
              begin
                wimg := g_WMain2Images;
                idx := 690;
              end; //酒气护体 
            49, 52..58:
              begin
                wimg := g_WMagic3Images;
                if mag in [0..MAXEFFECT - 1] then
                  idx := EffectBase[mag];
              end;
            59..64:
              begin
                wimg := g_WMagic4Images;
                if mag in [0..MAXEFFECT - 1] then
                  idx := EffectBase[mag];
              end;
            31:
              begin
                wimg := GetMonEx(21 - 1);
                if mag in [0..MAXEFFECT - 1] then
                  idx := EffectBase[mag];
              end;
            36:
              begin
                wimg := GetMonEx(22 - 1);
                if mag in [0..MAXEFFECT - 1] then
                  idx := EffectBase[mag];
              end;
            80..82:
              begin
                wimg := g_WDragonImages;
                if mag = 80 then
                begin
                  if g_Myself.m_nCurrX >= 84 then
                  begin
                    idx := 130;
                  end
                  else
                  begin
                    idx := 140;
                  end;
                end;
                if mag = 81 then
                begin
                  if (g_Myself.m_nCurrX >= 78) and (g_Myself.m_nCurrY >= 48)
                    then
                  begin
                    idx := 150;
                  end
                  else
                  begin
                    idx := 160;
                  end;
                end;
                if mag = 82 then
                begin
                  idx := 180;
                end;
              end;
            89:
              begin
                wimg := g_WDragonImages;
                idx := 350;
              end;
            90:
              begin
                wimg := g_WMagic5Images;
                idx := 790;
              end;
            99:
              begin
                wimg := g_WMagic5Images;
                idx := 100;
              end;
            100:
              begin
                wimg := g_WMagic5Images;
                idx := 280;
              end;
          else
            begin
              wimg := g_WMagicImages;
              if mag in [0..MAXEFFECT - 1] then
                idx := EffectBase[mag];
            end;
          end;
        end;
      1:
        begin
          wimg := g_WMagicImages;
          if mag in [0..MAXHITEFFECT - 1] then
          begin
            idx := HitEffectBase[mag];
          end;
          if mag >= 5 then
            wimg := g_WMagic2Images;
          if mag >= 8 then
            wimg := g_WMagic4Images;
          if mag in [11, 12] then
            wimg := g_WMagic5Images;
          if mag in [13, 14] then
            wimg := g_WMagic6Images;
        end;
    end;
    //Dscreen.AddSysMsg (Format('%d/%d/%d',[mag, mtype,idx]));
  except //程序自动增加
    DebugOutStr('[Exception] Unmagiceff.GetEffectBase'); //程序自动增加
  end; //程序自动增加
end;

constructor TMagicEff.Create(id, effnum, sx, sy, tx, ty: integer; mtype:
  TMagicType; Recusion: Boolean; anitime: integer);
var
  tax, tay: integer;
begin
  try //程序自动增加
    ImgLib := g_WMagicImages; //扁夯

    case mtype of
      mtFly, mtBujaukGroundEffect, mtExploBujauk:
        begin
          start := 0;
          frame := 6;
          curframe := start;
          FixedEffect := False;
          Repetition := Recusion;
          ExplosionFrame := 10;
          if id = 38 then
            frame := 10;
          if id = 39 then
          begin
            frame := 4;
            ExplosionFrame := 8;
          end;
          if (id - 81 - 3) < 0 then
          begin
            bt80 := 1;
            Repetition := True;
            if id = 81 then
            begin
              if g_MySelf.m_nCurrX >= 84 then
              begin
                EffectBase := 130;
              end
              else
              begin
                EffectBase := 140;
              end;
              bt81 := 1;
            end;
            if id = 82 then
            begin
              if (g_MySelf.m_nCurrX >= 78) and (g_MySelf.m_nCurrY >= 48) then
              begin
                EffectBase := 150;
              end
              else
              begin
                EffectBase := 160;
              end;
              bt81 := 2;
            end;
            if id = 83 then
            begin
              EffectBase := 180;
              bt81 := 3;
            end;
            start := 0;
            frame := 10;
            MagExplosionBase := 190;
            ExplosionFrame := 10;
          end;
        end;
      mt12:
        begin
          start := 0;
          frame := 6;
          curframe := start;
          FixedEffect := False;
          Repetition := Recusion;
          ExplosionFrame := 1;
        end;
      mt13:
        begin
          start := 0;
          frame := 20;
          curframe := start;
          FixedEffect := True;
          Repetition := False;
          ExplosionFrame := 20;
          ImgLib := GetMonEx(21 - 1);
        end;
      mtExplosion, mtThunder, mtLightingThunder:
        begin
          start := 0;
          frame := -1;
          ExplosionFrame := 10;
          curframe := start;
          FixedEffect := TRUE;
          Repetition := FALSE;
          if id = 80 then
          begin
            bt80 := 2;
            case Random(6) of
              0:
                begin
                  EffectBase := 230;
                end;
              1:
                begin
                  EffectBase := 240;
                end;
              2:
                begin
                  EffectBase := 250;
                end;
              3:
                begin
                  EffectBase := 230;
                end;
              4:
                begin
                  EffectBase := 240;
                end;
              5:
                begin
                  EffectBase := 250;
                end;
            end;
            Light := 4;
            ExplosionFrame := 5;
          end;
          if id = 70 then
          begin
            bt80 := 3;
            case Random(3) of
              0:
                begin
                  EffectBase := 400;
                end;
              1:
                begin
                  EffectBase := 410;
                end;
              2:
                begin
                  EffectBase := 420;
                end;
            end;
            Light := 4;
            ExplosionFrame := 5;
          end;
          if id = 71 then
          begin
            bt80 := 3;
            ExplosionFrame := 20;
          end;
          if id = 72 then
          begin
            bt80 := 3;
            Light := 3;
            ExplosionFrame := 10;
          end;
          if id = 73 then
          begin
            bt80 := 3;
            Light := 5;
            ExplosionFrame := 20;
          end;
          if id = 74 then
          begin
            bt80 := 3;
            Light := 4;
            ExplosionFrame := 35;
          end;
          if id = 90 then
          begin
            EffectBase := 350;
            MagExplosionBase := 350;
            ExplosionFrame := 30;
          end;
        end;
      mt14:
        begin
          start := 0;
          frame := -1;
          curframe := start;
          FixedEffect := True;
          Repetition := False;
          ImgLib := g_WMagic2Images;
        end;
      mtFlyAxe:
        begin
          start := 0;
          frame := 3;
          curframe := start;
          FixedEffect := FALSE;
          Repetition := Recusion;
          ExplosionFrame := 3;
        end;
      mtFlyArrow:
        begin
          start := 0;
          frame := 1;
          curframe := start;
          FixedEffect := FALSE;
          Repetition := Recusion;
          ExplosionFrame := 1;
        end;
      mt15:
        begin
          start := 0;
          frame := 6;
          curframe := start;
          FixedEffect := FALSE;
          Repetition := Recusion;
          ExplosionFrame := 2;
        end;
      mt16:
        begin
          start := 0;
          frame := 1;
          curframe := start;
          FixedEffect := FALSE;
          Repetition := Recusion;
          ExplosionFrame := 1;
        end;
    end;
    n7C := 0;
    {
    case mtype of
       mtReady:
          begin
          end;
       mtFly,             ;
       mtBujaukGroundEffect,
       mtExploBujauk:
          begin
             start := 0;
             frame := 6;
             curframe := start;
             FixedEffect := FALSE;
             Repetition := Recusion;
             ExplosionFrame := 10;
          end;
       mtExplosion,
       mtThunder,
       mtLightingThunder:
          begin
             start := 0;
             frame := -1;
             ExplosionFrame := 10;
             curframe := start;
             FixedEffect := TRUE;
             Repetition := FALSE;
          end;
       mtFlyAxe:
          begin
             start := 0;
             frame := 3;
             curframe := start;
             FixedEffect := FALSE;
             Repetition := Recusion;
             ExplosionFrame := 3;
          end;
       mtFlyArrow:
          begin
             start := 0;
             frame := 1;
             curframe := start;
             FixedEffect := FALSE;
             Repetition := Recusion;
             ExplosionFrame := 1;
          end;
    end;
    }
    ServerMagicId := id; //辑滚狼 ID
    EffectBase := effnum; //MagicDB - Effect
    TargetX := tx; // "   target x
    TargetY := ty; // "   target y

    if bt80 = 1 then
    begin
      if id = 81 then
      begin
        dec(sx, 14);
        inc(sy, 20);
      end;
      if id = 81 then
      begin
        dec(sx, 70);
        dec(sy, 10);
      end;
      if id = 83 then
      begin
        dec(sx, 60);
        dec(sy, 70);
      end;
      PlaySound(8208);
    end;
    fireX := sx; //
    fireY := sy; //
    FlyX := sx; //
    FlyY := sy;
    OldFlyX := sx;
    OldFlyY := sy;
    FlyXf := sx;
    FlyYf := sy;
    FireMyselfX := g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX;
    FireMyselfY := g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY;
    if bt80 = 0 then
    begin
      MagExplosionBase := EffectBase + EXPLOSIONBASE;
    end;

    light := 1;

    if fireX <> TargetX then
      tax := abs(TargetX - fireX)
    else
      tax := 1;
    if fireY <> TargetY then
      tay := abs(TargetY - fireY)
    else
      tay := 1;
    if abs(fireX - TargetX) > abs(fireY - TargetY) then
    begin
      firedisX := Round((TargetX - fireX) * (500 / tax));
      firedisY := Round((TargetY - fireY) * (500 / tax));
    end
    else
    begin
      firedisX := Round((TargetX - fireX) * (500 / tay));
      firedisY := Round((TargetY - fireY) * (500 / tay));
    end;

    NextFrameTime := 50;
    m_dwFrameTime := GetTickCount;
    m_dwStartTime := GetTickCount;
    steptime := GetTickCount;
    RepeatTime := anitime;
    Dir16 := GetFlyDirection16(sx, sy, tx, ty);
    OldDir16 := Dir16;
    NextEffect := nil;
    m_boActive := TRUE;
    prevdisx := 99999;
    prevdisy := 99999;
  except //程序自动增加
    DebugOutStr('[Exception] TMagicEff.Create'); //程序自动增加
  end; //程序自动增加
end;

destructor TMagicEff.Destroy;
begin
  try //程序自动增加
    inherited Destroy;
  except //程序自动增加
    DebugOutStr('[Exception] TMagicEff.Destroy'); //程序自动增加
  end; //程序自动增加
end;

function TMagicEff.Shift: Boolean;
  function OverThrough(olddir, newdir: integer): Boolean;
  begin
    Result := FALSE;
    if abs(olddir - newdir) >= 2 then
    begin
      Result := TRUE;
      if ((olddir = 0) and (newdir = 15)) or ((olddir = 15) and (newdir = 0))
        then
        Result := FALSE;
    end;
  end;
var
  i, rrx, rry, ms, stepx, stepy, newstepx, newstepy, nn: integer;
  tax, tay, shx, shy, passdir16: integer;
  crash: Boolean;
  stepxf, stepyf: Real;
begin
  try //程序自动增加
    Result := TRUE;
    if Repetition then
    begin
      if GetTickCount - steptime > longword(NextFrameTime) then
      begin
        steptime := GetTickCount;
        Inc(curframe);
        if curframe > start + frame - 1 then
          curframe := start;
      end;
    end
    else
    begin
      if (frame > 0) and (GetTickCount - steptime > longword(NextFrameTime))
        then
      begin
        steptime := GetTickCount;
        Inc(curframe);
        if curframe > start + frame - 1 then
        begin
          curframe := start + frame - 1;
          Result := FALSE;
        end;
      end;
    end;
    if (not FixedEffect) then
    begin

      crash := FALSE;
      if TargetActor <> nil then
      begin
        ms := GetTickCount - m_dwFrameTime;
          //捞傈 瓤苞甫 弊赴饶 倔付唱 矫埃捞 汝范绰瘤?
        m_dwFrameTime := GetTickCount;
        //TargetX, TargetY 犁汲沥
        PlayScene.ScreenXYfromMCXY(TActor(TargetActor).m_nRx,
          TActor(TargetActor).m_nRy,
          TargetX,
          TargetY);
        shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
        shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;
        TargetX := TargetX + shx;
        TargetY := TargetY + shy;

        //货肺款 鸥百阑 谅钎甫 货肺 汲沥茄促.
        if FlyX <> TargetX then
          tax := abs(TargetX - FlyX)
        else
          tax := 1;
        if FlyY <> TargetY then
          tay := abs(TargetY - FlyY)
        else
          tay := 1;
        if abs(FlyX - TargetX) > abs(FlyY - TargetY) then
        begin
          newfiredisX := Round((TargetX - FlyX) * (500 / tax));
          newfiredisY := Round((TargetY - FlyY) * (500 / tax));
        end
        else
        begin
          newfiredisX := Round((TargetX - FlyX) * (500 / tay));
          newfiredisY := Round((TargetY - FlyY) * (500 / tay));
        end;

        if firedisX < newfiredisX then
          firedisX := firedisX + _MAX(1, (newfiredisX - firedisX) div 10);
        if firedisX > newfiredisX then
          firedisX := firedisX - _MAX(1, (firedisX - newfiredisX) div 10);
        if firedisY < newfiredisY then
          firedisY := firedisY + _MAX(1, (newfiredisY - firedisY) div 10);
        if firedisY > newfiredisY then
          firedisY := firedisY - _MAX(1, (firedisY - newfiredisY) div 10);

        stepxf := (firedisX / 700) * ms;
        stepyf := (firedisY / 700) * ms;
        FlyXf := FlyXf + stepxf;
        FlyYf := FlyYf + stepyf;
        FlyX := Round(FlyXf);
        FlyY := Round(FlyYf);

        //规氢 犁汲沥
      //  Dir16 := GetFlyDirection16 (OldFlyX, OldFlyY, FlyX, FlyY);
        OldFlyX := FlyX;
        OldFlyY := FlyY;
        //烹苞咯何甫 犬牢窍扁 困窍咯
        passdir16 := GetFlyDirection16(FlyX, FlyY, TargetX, TargetY);

        {DebugOutStr (IntToStr(prevdisx) + ' ' + IntToStr(prevdisy) + ' / ' + IntToStr(abs(TargetX-FlyX)) + ' ' + IntToStr(abs(TargetY-FlyY)) + '   ' +
                     IntToStr(firedisX) + '.' + IntToStr(firedisY) + ' ' +
                     IntToStr(FlyX) + '.' + IntToStr(FlyY) + ' ' +
                     IntToStr(TargetX) + '.' + IntToStr(TargetY)); }
        if ((abs(TargetX - FlyX) <= 15) and (abs(TargetY - FlyY) <= 15)) or
          ((abs(TargetX - FlyX) >= prevdisx) and (abs(TargetY - FlyY) >=
            prevdisy)) or
          OverThrough(OldDir16, passdir16) then
        begin
          crash := TRUE;
        end
        else
        begin
          prevdisx := abs(TargetX - FlyX);
          prevdisy := abs(TargetY - FlyY);
          //if (prevdisx <= 5) and (prevdisy <= 5) then crash := TRUE;
        end;
        OldDir16 := passdir16;

      end
      else
      begin
        ms := GetTickCount - m_dwFrameTime;
          //瓤苞狼 矫累饶 倔付唱 矫埃捞 汝范绰瘤?

        rrx := TargetX - fireX;
        rry := TargetY - fireY;

        stepx := Round((firedisX / 900) * ms);
        stepy := Round((firedisY / 900) * ms);
        FlyX := fireX + stepx;
        FlyY := fireY + stepy;
      end;

      PlayScene.CXYfromMouseXY(FlyX, FlyY, Rx, Ry);

      if crash and (TargetActor <> nil) then
      begin
        FixedEffect := TRUE; //气惯
        start := 0;
        frame := ExplosionFrame;
        curframe := start;
        Repetition := FALSE;

        //磐瘤绰 荤款靛
        PlaySound(TActor(MagOwner).m_nMagicExplosionSound);

      end;
      //if not Map.CanFly (Rx, Ry) then
      //   Result := FALSE;
    end;
    if FixedEffect then
    begin
      if frame = -1 then
        frame := ExplosionFrame;
      if TargetActor = nil then
      begin
        FlyX := TargetX - ((g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) -
          FireMyselfX);
        FlyY := TargetY - ((g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) -
          FireMyselfY);
        PlayScene.CXYfromMouseXY(FlyX, FlyY, Rx, Ry);
      end
      else
      begin
        Rx := TActor(TargetActor).m_nRx;
        Ry := TActor(TargetActor).m_nRy;
        PlayScene.ScreenXYfromMCXY(Rx, Ry, FlyX, FlyY);
        FlyX := FlyX + TActor(TargetActor).m_nShiftX;
        FlyY := FlyY + TActor(TargetActor).m_nShiftY;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TMagicEff.Shift:'); //程序自动增加
  end; //程序自动增加
end;

procedure TMagicEff.GetFlyXY(ms: integer; var fx, fy: integer);
var
  rrx, rry, stepx, stepy: integer;
begin
  try //程序自动增加
    rrx := TargetX - fireX;
    rry := TargetY - fireY;

    stepx := Round((firedisX / 900) * ms);
    stepy := Round((firedisY / 900) * ms);
    fx := fireX + stepx;
    fy := fireY + stepy;
  except //程序自动增加
    DebugOutStr('[Exception] TMagicEff.GetFlyXY'); //程序自动增加
  end; //程序自动增加
end;

function TMagicEff.Run: Boolean;
begin
  try //程序自动增加
    Result := Shift;
    if Result then
      if GetTickCount - m_dwStartTime > 10000 then //2000 then
        Result := FALSE
      else
        Result := TRUE;
  except //程序自动增加
    DebugOutStr('[Exception] TMagicEff.Run:'); //程序自动增加
  end; //程序自动增加
end;

procedure TMagicEff.DrawEff(surface: TDirectDrawSurface);
var
  img: integer;
  d: TDirectDrawSurface;
  shx, shy: integer;
begin
  try //程序自动增加
    if m_boActive and ((Abs(FlyX - fireX) > 15) or (Abs(FlyY - fireY) > 15) or
      FixedEffect) then
    begin

      shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
      shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;

      if not FixedEffect then
      begin
        //朝酒啊绰芭
        img := EffectBase + FLYBASE + Dir16 * 10;
        d := ImgLib.GetCachedImage(img + curframe, px, py);
        if d <> nil then
        begin
          DrawBlend(surface,
            FlyX + px - UNITX div 2 - shx,
            FlyY + py - UNITY div 2 - shy,
            d, 1);
        end;
      end
      else
      begin
        //磐瘤绰芭
        img := MagExplosionBase + curframe; //EXPLOSIONBASE;
        d := ImgLib.GetCachedImage(img, px, py);
        if d <> nil then
        begin
          DrawBlend(surface,
            FlyX + px - UNITX div 2,
            FlyY + py - UNITY div 2,
            d, 1);
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TMagicEff.DrawEff'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------}

//      TFlyingAxe : 朝酒啊绰 档尝

{------------------------------------------------------------}

constructor TFlyingAxe.Create(id, effnum, sx, sy, tx, ty: integer; mtype:
  TMagicType; Recusion: Boolean; anitime: integer);
begin
  try //程序自动增加
    inherited Create(id, effnum, sx, sy, tx, ty, mtype, Recusion, anitime);
    FlyImageBase := FLYOMAAXEBASE;
    ReadyFrame := 65;
  except //程序自动增加
    DebugOutStr('[Exception] TFlyingAxe.Create'); //程序自动增加
  end; //程序自动增加
end;

procedure TFlyingAxe.DrawEff(surface: TDirectDrawSurface);
var
  img: integer;
  d: TDirectDrawSurface;
  shx, shy: integer;
begin
  try //程序自动增加
    if m_boActive and ((Abs(FlyX - fireX) > ReadyFrame) or (Abs(FlyY - fireY) >
      ReadyFrame)) then
    begin

      shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
      shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;

      if not FixedEffect then
      begin
        //
        img := FlyImageBase + Dir16 * 10;
        d := ImgLib.GetCachedImage(img + curframe, px, py);
        if d <> nil then
        begin
          //舅颇喉珐爹窍瘤 臼澜
          surface.Draw(FlyX + px - UNITX div 2 - shx,
            FlyY + py - UNITY div 2 - shy,
            d.ClientRect, d, TRUE);
        end;
      end
      else
      begin
        {//沥瘤, 档尝俊 嘛腮 葛嚼.
        img := FlyImageBase + Dir16 * 10;
        d := ImgLib.GetCachedImage (img, px, py);
        if d <> nil then begin
           //舅颇喉珐爹窍瘤 臼澜
           surface.Draw (FlyX + px - UNITX div 2,
                         FlyY + py - UNITY div 2,
                         d.ClientRect, d, TRUE);
        end;  }
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFlyingAxe.DrawEff'); //程序自动增加
  end; //程序自动增加
end;

{------------------------------------------------------------}

//      TFlyingArrow : 朝酒啊绰 拳混

{------------------------------------------------------------}

procedure TFlyingArrow.DrawEff(surface: TDirectDrawSurface);
var
  img: integer;
  d: TDirectDrawSurface;
  shx, shy: integer;
begin
  try //程序自动增加
    //(**6岿菩摹
    if m_boActive and ((Abs(FlyX - fireX) > 40) or (Abs(FlyY - fireY) > 40))
      then
    begin
      //*)
      (**捞傈
         if Active then begin //and ((Abs(FlyX-fireX) > 65) or (Abs(FlyY-fireY) > 65)) then begin
      //*)
      shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
      shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;

      if not FixedEffect then
      begin
        //朝酒啊绰芭
        img := FlyImageBase + Dir16; // * 10;
        d := ImgLib.GetCachedImage(img + curframe, px, py);
        //(**6岿菩摹
        if d <> nil then
        begin
          //舅颇喉珐爹窍瘤 臼澜
          surface.Draw(FlyX + px - UNITX div 2 - shx,
            FlyY + py - UNITY div 2 - shy - 46,
            d.ClientRect, d, TRUE);
        end;
        //**)
        (***捞傈
                 if d <> nil then begin
                    //舅颇喉珐爹窍瘤 臼澜
                    surface.Draw (FlyX + px - UNITX div 2 - shx,
                                  FlyY + py - UNITY div 2 - shy,
                                  d.ClientRect, d, TRUE);
                 end;
        //**)
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFlyingArrow.DrawEff'); //程序自动增加
  end; //程序自动增加
end;

{--------------------------------------------------------}

constructor TCharEffect.Create(effbase, effframe: integer; target: TObject);
begin
  try //程序自动增加
    inherited Create(111, effbase,
      TActor(target).m_nCurrX, TActor(target).m_nCurrY,
      TActor(target).m_nCurrX, TActor(target).m_nCurrY,
      mtExplosion,
      FALSE,
      0);
    TargetActor := target;
    frame := effframe;
    NextFrameTime := 30;

  except //程序自动增加
    DebugOutStr('[Exception] TCharEffect.Create'); //程序自动增加
  end; //程序自动增加
end;

function TCharEffect.Run: Boolean;
begin
  try //程序自动增加
    Result := TRUE;
    if GetTickCount - steptime > longword(NextFrameTime) then
    begin
      steptime := GetTickCount;
      Inc(curframe);
      if curframe > start + frame - 1 then
      begin
        curframe := start + frame - 1;
        Result := FALSE;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TCharEffect.Run:'); //程序自动增加
  end; //程序自动增加
end;

procedure TCharEffect.DrawEff(surface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    if TargetActor <> nil then
    begin
      Rx := TActor(TargetActor).m_nRx;
      Ry := TActor(TargetActor).m_nRy;
      PlayScene.ScreenXYfromMCXY(Rx, Ry, FlyX, FlyY);
      FlyX := FlyX + TActor(TargetActor).m_nShiftX;
      FlyY := FlyY + TActor(TargetActor).m_nShiftY;
      d := ImgLib.GetCachedImage(EffectBase + curframe, px, py);
      if d <> nil then
      begin
        DrawBlend(surface,
          FlyX + px - UNITX div 2,
          FlyY + py - UNITY div 2,
          d, 1);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TCharEffect.DrawEff'); //程序自动增加
  end; //程序自动增加
end;

{--------------------------------------------------------}

constructor TMapEffect.Create(effbase, effframe: integer; x, y: integer);
begin
  try //程序自动增加
    inherited Create(111, effbase,
      x, y,
      x, y,
      mtExplosion,
      FALSE,
      0);
    TargetActor := nil;
    frame := effframe;
    NextFrameTime := 30;
    RepeatCount := 0;
  except //程序自动增加
    DebugOutStr('[Exception] TMapEffect.Create'); //程序自动增加
  end; //程序自动增加
end;

function TMapEffect.Run: Boolean;
begin
  try //程序自动增加
    Result := TRUE;
    if GetTickCount - steptime > longword(NextFrameTime) then
    begin
      steptime := GetTickCount;
      Inc(curframe);
      if curframe > start + frame - 1 then
      begin
        curframe := start + frame - 1;
        if RepeatCount > 0 then
        begin
          Dec(RepeatCount);
          curframe := start;
        end
        else
          Result := FALSE;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TMapEffect.Run:'); //程序自动增加
  end; //程序自动增加
end;

procedure TMapEffect.DrawEff(surface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    Rx := TargetX;
    Ry := TargetY;
    PlayScene.ScreenXYfromMCXY(Rx, Ry, FlyX, FlyY);
    d := ImgLib.GetCachedImage(EffectBase + curframe, px, py);
    if d <> nil then
    begin
      DrawBlend(surface,
        FlyX + px - UNITX div 2,
        FlyY + py - UNITY div 2,
        d, 1);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TMapEffect.DrawEff'); //程序自动增加
  end; //程序自动增加
end;

{--------------------------------------------------------}

constructor TScrollHideEffect.Create(effbase, effframe: integer; x, y: integer;
  target: TObject);
begin
  try //程序自动增加
    inherited Create(effbase, effframe, x, y);
    //TargetCret := TActor(target);//在出现有人用随机之类时，将设置目标
  except //程序自动增加
    DebugOutStr('[Exception] TScrollHideEffect.Create'); //程序自动增加
  end; //程序自动增加
end;

function TScrollHideEffect.Run: Boolean;
begin
  try //程序自动增加
    Result := inherited Run;
    if frame = 7 then
      if g_TargetCret <> nil then
        PlayScene.DeleteActor(g_TargetCret.m_nRecogId);
  except //程序自动增加
    DebugOutStr('[Exception] TScrollHideEffect.Run:'); //程序自动增加
  end; //程序自动增加
end;

{--------------------------------------------------------}

constructor TLightingEffect.Create(effbase, effframe: integer; x, y: integer);
begin
  try //程序自动增加

  except //程序自动增加
    DebugOutStr('[Exception] TLightingEffect.Create'); //程序自动增加
  end; //程序自动增加
end;

function TLightingEffect.Run: Boolean;
begin
  try //程序自动增加
    Result := False; //Jacky
  except //程序自动增加
    DebugOutStr('[Exception] TLightingEffect.Run:'); //程序自动增加
  end; //程序自动增加
end;

{--------------------------------------------------------}

constructor TFireGunEffect.Create(effbase, sx, sy, tx, ty: integer);
begin
  try //程序自动增加
    inherited Create(111, effbase,
      sx, sy,
      tx, ty, //TActor(target).XX, TActor(target).m_nCurrY,
      mtFireGun,
      TRUE,
      0);
    NextFrameTime := 50;
    FillChar(FireNodes, sizeof(TFireNode) * FIREGUNFRAME, #0);
    OutofOil := FALSE;
    firetime := GetTickCount;
  except //程序自动增加
    DebugOutStr('[Exception] TFireGunEffect.Create'); //程序自动增加
  end; //程序自动增加
end;

function TFireGunEffect.Run: Boolean;
var
  i, fx, fy: integer;
  allgone: Boolean;
begin
  try //程序自动增加
    Result := TRUE;
    if GetTickCount - steptime > longword(NextFrameTime) then
    begin
      Shift;
      steptime := GetTickCount;
      //if not FixedEffect then begin  //格钎俊 嘎瘤 臼疽栏搁
      if not OutofOil then
      begin
        if (abs(RX - TActor(MagOwner).m_nRx) >= 5) or (abs(RY -
          TActor(MagOwner).m_nRy) >= 5) or (GetTickCount - firetime > 800) then
          OutofOil := TRUE;
        for i := FIREGUNFRAME - 2 downto 0 do
        begin
          FireNodes[i].FireNumber := FireNodes[i].FireNumber + 1;
          FireNodes[i + 1] := FireNodes[i];
        end;
        FireNodes[0].FireNumber := 1;
        FireNodes[0].x := FlyX;
        FireNodes[0].y := FlyY;
      end
      else
      begin
        allgone := TRUE;
        for i := FIREGUNFRAME - 2 downto 0 do
        begin
          if FireNodes[i].FireNumber <= FIREGUNFRAME then
          begin
            FireNodes[i].FireNumber := FireNodes[i].FireNumber + 1;
            FireNodes[i + 1] := FireNodes[i];
            allgone := FALSE;
          end;
        end;
        if allgone then
          Result := FALSE;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFireGunEffect.Run:'); //程序自动增加
  end; //程序自动增加
end;

procedure TFireGunEffect.DrawEff(surface: TDirectDrawSurface);
var
  i, num, shx, shy, firex, firey, prx, pry, img: integer;
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    prx := -1;
    pry := -1;
    for i := 0 to FIREGUNFRAME - 1 do
    begin
      if (FireNodes[i].FireNumber <= FIREGUNFRAME) and (FireNodes[i].FireNumber
        > 0) then
      begin
        shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
        shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;

        img := EffectBase + (FireNodes[i].FireNumber - 1);
        d := ImgLib.GetCachedImage(img, px, py);
        if d <> nil then
        begin
          firex := FireNodes[i].x + px - UNITX div 2 - shx;
          firey := FireNodes[i].y + py - UNITY div 2 - shy;
          if (firex <> prx) or (firey <> pry) then
          begin
            prx := firex;
            pry := firey;
            DrawBlend(surface, firex, firey, d, 1);
          end;
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFireGunEffect.DrawEff'); //程序自动增加
  end; //程序自动增加
end;

{--------------------------------------------------------}

constructor TThuderEffect.Create(effbase, tx, ty: integer; target: TObject);
begin
  try //程序自动增加
    inherited Create(111, effbase,
      tx, ty,
      tx, ty, //TActor(target).XX, TActor(target).m_nCurrY,
      mtThunder,
      FALSE,
      0);
    TargetActor := target;

  except //程序自动增加
    DebugOutStr('[Exception] TThuderEffect.Create'); //程序自动增加
  end; //程序自动增加
end;

procedure TThuderEffect.DrawEff(surface: TDirectDrawSurface);
var
  img, px, py: integer;
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    img := EffectBase;
    d := ImgLib.GetCachedImage(img + curframe, px, py);
    if d <> nil then
    begin
      DrawBlend(surface,
        FlyX + px - UNITX div 2,
        FlyY + py - UNITY div 2,
        d, 1);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TThuderEffect.DrawEff'); //程序自动增加
  end; //程序自动增加
end;

{--------------------------------------------------------}

constructor TLightingThunder.Create(effbase, sx, sy, tx, ty: integer; target:
  TObject);
begin
  try //程序自动增加
    inherited Create(111, effbase,
      sx, sy,
      tx, ty, //TActor(target).XX, TActor(target).m_nCurrY,
      mtLightingThunder,
      FALSE,
      0);
    TargetActor := target;
  except //程序自动增加
    DebugOutStr('[Exception] TLightingThunder.Create'); //程序自动增加
  end; //程序自动增加
end;

procedure TLightingThunder.DrawEff(surface: TDirectDrawSurface);
var
  img, sx, sy, px, py, shx, shy: integer;
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    img := EffectBase + Dir16 * 10;
    if curframe < 6 then
    begin

      shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
      shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;

      d := ImgLib.GetCachedImage(img + curframe, px, py);
      if d <> nil then
      begin
        PlayScene.ScreenXYfromMCXY(TActor(MagOwner).m_nRx,
          TActor(MagOwner).m_nRy,
          sx,
          sy);
        DrawBlend(surface,
          sx + px - UNITX div 2,
          sy + py - UNITY div 2,
          d, 1);
      end;
    end;
    {if (curframe < 10) and (TargetActor <> nil) then begin
       d := ImgLib.GetCachedImage (EffectBase + 17*10 + curframe, px, py);
       if d <> nil then begin
          PlayScene.ScreenXYfromMCXY (TActor(TargetActor).RX,
                                      TActor(TargetActor).RY,
                                      sx,
                                      sy);
          DrawBlend (surface,
                     sx + px - UNITX div 2,
                     sy + py - UNITY div 2,
                     d, 1);
       end;
    end;}
  except //程序自动增加
    DebugOutStr('[Exception] TLightingThunder.DrawEff'); //程序自动增加
  end; //程序自动增加
end;

{--------------------------------------------------------}

constructor TExploBujaukEffect.Create(effbase, sx, sy, tx, ty: integer; target:
  TObject);
begin
  try //程序自动增加
    inherited Create(111, effbase,
      sx, sy,
      tx, ty,
      mtExploBujauk,
      TRUE,
      0);
    frame := 3;
    TargetActor := target;
    NextFrameTime := 50;
    m_boWb := False;
    m_nWbCount := 170;
  except //程序自动增加
    DebugOutStr('[Exception] TExploBujaukEffect.Create'); //程序自动增加
  end; //程序自动增加
end;

procedure TExploBujaukEffect.DrawEff(surface: TDirectDrawSurface);
var
  img: integer;
  d: TDirectDrawSurface;
  shx, shy: integer;
  meff: TMapEffect;
begin
  try //程序自动增加
    if m_boActive and ((Abs(FlyX - fireX) > 30) or (Abs(FlyY - fireY) > 30) or
      FixedEffect) then
    begin

      shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
      shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;

      if not FixedEffect then
      begin
        //朝酒啊绰芭
        img := EffectBase + Dir16 * 10;
        d := ImgLib.GetCachedImage(img + curframe, px, py);
        if d <> nil then
        begin
          //舅颇喉珐爹窍瘤 臼澜
          surface.Draw(FlyX + px - UNITX div 2 - shx,
            FlyY + py - UNITY div 2 - shy,
            d.ClientRect, d, TRUE);
        end;
        if m_boWb then
        begin
          d := ImgLib.GetCachedImage(img + curframe + m_nWbCount, px, py);
          if d <> nil then
          begin
            //舅颇喉珐爹窍瘤 臼澜
            DrawBlend(surface,
              FlyX + px - UNITX div 2 - shx,
              FlyY + py - UNITY div 2 - shy,
              d, 1);
          end;
        end;
      end
      else
      begin
        //气惯
        img := MagExplosionBase + curframe;
        d := ImgLib.GetCachedImage(img, px, py);
        if d <> nil then
        begin
          DrawBlend(surface,
            FLyX + px - UNITX div 2,
            FlyY + py - UNITY div 2,
            d, 1);
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TExploBujaukEffect.DrawEff'); //程序自动增加
  end; //程序自动增加
end;

{--------------------------------------------------------}

constructor TBujaukGroundEffect.Create(effbase, magicnumb, sx, sy, tx, ty:
  integer);
begin
  try //程序自动增加
    inherited Create(111, effbase,
      sx, sy,
      tx, ty,
      mtBujaukGroundEffect,
      TRUE,
      0);
    frame := 3;
    MagicNumber := magicnumb;
    BoGroundEffect := FALSE;
    NextFrameTime := 50;
  except //程序自动增加
    DebugOutStr('[Exception] TBujaukGroundEffect.Create'); //程序自动增加
  end; //程序自动增加
end;

function TBujaukGroundEffect.Run: Boolean;
begin
  try //程序自动增加
    Result := inherited Run;
    if not FixedEffect then
    begin
      if ((abs(TargetX - FlyX) <= 15) and (abs(TargetY - FlyY) <= 15)) or
        ((abs(TargetX - FlyX) >= prevdisx) and (abs(TargetY - FlyY) >= prevdisy))
          then
      begin
        FixedEffect := TRUE; //气惯
        start := 0;
        frame := ExplosionFrame;
        curframe := start;
        Repetition := FALSE;
        //磐瘤绰 荤款靛
        PlaySound(TActor(MagOwner).m_nMagicExplosionSound);

        Result := TRUE;
      end
      else
      begin
        prevdisx := abs(TargetX - FlyX);
        prevdisy := abs(TargetY - FlyY);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TBujaukGroundEffect.Run:'); //程序自动增加
  end; //程序自动增加
end;

procedure TBujaukGroundEffect.DrawEff(surface: TDirectDrawSurface);
var
  img: integer;
  d: TDirectDrawSurface;
  shx, shy: integer;
  meff: TMapEffect;
begin
  try //程序自动增加
    if m_boActive and ((Abs(FlyX - fireX) > 30) or (Abs(FlyY - fireY) > 30) or
      FixedEffect) then
    begin

      shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
      shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;

      if not FixedEffect then
      begin
        //朝酒啊绰芭
        img := EffectBase + Dir16 * 10;
        d := ImgLib.GetCachedImage(img + curframe, px, py);
        if d <> nil then
        begin
          //舅颇喉珐爹窍瘤 臼澜
          surface.Draw(FlyX + px - UNITX div 2 - shx,
            FlyY + py - UNITY div 2 - shy,
            d.ClientRect, d, TRUE);
        end;
      end
      else
      begin
        //气惯
        if MagicNumber = 11 then //付
          img := EffectBase + 16 * 10 + curframe
        else //规
          img := EffectBase + 18 * 10 + curframe;

        if MagicNumber = 46 then
        begin
          GetEffectBase(MagicNumber - 1, 0, ImgLib, img);
          img := img + 10 + curframe;
        end;

        d := ImgLib.GetCachedImage(img, px, py);

        if d <> nil then
        begin
          DrawBlend(surface,
            FLyX + px - UNITX div 2, // - shx,
            FlyY + py - UNITY div 2, // - shy,
            d, 1);
        end;

        {if not BoGroundEffect and (curframe = 8) then begin
           BoGroundEffect := TRUE;
           meff := TMapEffect.Create (img+2, 6, TargetRx, TargetRy);
           meff.NextFrameTime := 100;
           //meff.RepeatCount := 1;
           PlayScene.GroundEffectList.Add (meff);
        end; }
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TBujaukGroundEffect.DrawEff'); //程序自动增加
  end; //程序自动增加
end;

{TCorpsDrawEffect}

constructor TCorpsDrawEffect.Create(Actor: TObject; WmImage: TWMImages; effbase,
  nX: Integer; frmTime: LongWord; boFlag: Boolean);
var
  XX, YY: integer;
begin
  try //程序自动增加
    XX := TActor(Actor).m_nCurrX;
    YY := TActor(Actor).m_nCurrY;
    inherited Create(111, effbase, XX, YY, XX, YY, mtReady, TRUE, 0);
    ImgLib := WmImage;
    EffectBase := effbase;
    start := 0;
    curframe := 0;
    frame := nX;
    NextFrameTime := frmTime;
    boC8 := boFlag;
    m_Actor := Actor;
  except //程序自动增加
    DebugOutStr('[Exception] TCorpsDrawEffect.Create'); //程序自动增加
  end; //程序自动增加
end;

procedure TCorpsDrawEffect.DrawEff(surface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  nRx, nRy, nPx, nPy, nShiftX, nShiftY, defx, defy: integer;
begin
  try //程序自动增加
    if (ImgLib <> nil) and (m_Actor <> nil) then
    begin
      nShiftX := TActor(m_Actor).m_nShiftX;
      nShiftY := TActor(m_Actor).m_nShiftY;
      defx := -UNITX * 2 - g_MySelf.m_nShiftX + 30;
      defy := -UNITY * 2 - g_MySelf.m_nShiftY;
      nRx := (TActor(m_Actor).m_nRx - Map.m_ClientRect.Left) * UNITX + defx;
      nRy := (TActor(m_Actor).m_nRy - Map.m_ClientRect.Top - 1) * UNITY + defy;
      d := ImgLib.GetCachedImage(EffectBase + curframe, nPx, nPy);
      if d <> nil then
      begin
        //surface.Draw (nRx+nPx + nShiftX,nRy+nPy + nShiftY,d.ClientRect, d, TRUE);
        DrawBlend(surface,
          nRx + nPx + nShiftX,
          nRy + nPy + nShiftY,
          d, 1);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TCorpsDrawEffect.DrawEff'); //程序自动增加
  end; //程序自动增加
end;

function TCorpsDrawEffect.Run: Boolean;
begin
  try //程序自动增加
    Result := TRUE;
    if m_boActive and (GetTickCount - steptime > longword(NextFrameTime)) then
    begin
      steptime := GetTickCount;
      Inc(curframe);
      if curframe > start + frame - 1 then
      begin
        curframe := start;
        Result := FALSE;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TCorpsDrawEffect.Run:'); //程序自动增加
  end; //程序自动增加
end;

{TFlyDrawEffect}

constructor TFlyDrawEffect.Create(XX, YY: Integer; WmImage: TWMImages; effbase,
  ExplosionBase, nX: Integer; frmTime: LongWord; boFlag: Boolean);
begin
  try //程序自动增加
    inherited Create(111, effbase, XX, YY, XX, YY, mtReady, TRUE, 0);
    ImgLib := WmImage;
    EffectBase := effbase;
    start := 0;
    curframe := 0;
    frame := nX;
    NextFrameTime := frmTime;
    boC8 := boFlag;
    nExplosionBase := ExplosionBase;
  except //程序自动增加
    DebugOutStr('[Exception] TFlyDrawEffect.Create'); //程序自动增加
  end; //程序自动增加
end;

procedure TFlyDrawEffect.DrawEff(surface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  nRx, nRy, nPx, nPy: integer;
begin
  try //程序自动增加
    d := ImgLib.GetCachedImage(EffectBase + curframe, nPx, nPy);
    if d <> nil then
    begin
      PlayScene.ScreenXYfromMCXY(FlyX, FlyY, nRx, nRy);
      if boC8 then
      begin
        DrawBlend(surface, nRx + nPx - UNITX div 2, nRy + nPy - UNITY div 2, d,
          1);
      end
      else
      begin
        surface.Draw(nRx + nPx - UNITX div 2, nRy + nPy - UNITY div 2,
          d.ClientRect, d, TRUE);
      end;
    end;

    d := ImgLib.GetCachedImage(nExplosionBase + curframe, nPx, nPy);
    if d <> nil then
    begin
      PlayScene.ScreenXYfromMCXY(FlyX, FlyY, nRx, nRy);
      if boC8 then
      begin
        DrawBlend(surface, nRx + nPx - UNITX div 2, nRy + nPy - UNITY div 2, d,
          1);
      end
      else
      begin
        surface.Draw(nRx + nPx - UNITX div 2, nRy + nPy - UNITY div 2,
          d.ClientRect, d, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFlyDrawEffect.DrawEff'); //程序自动增加
  end; //程序自动增加
end;

function TFlyDrawEffect.Run: Boolean;
begin
  try //程序自动增加
    Result := TRUE;
    if m_boActive and (GetTickCount - steptime > longword(NextFrameTime)) then
    begin
      steptime := GetTickCount;
      Inc(curframe);
      if curframe > start + frame - 1 then
      begin
        curframe := start;
        Result := FALSE;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFlyDrawEffect.Run:'); //程序自动增加
  end; //程序自动增加
end;

{ TNormalDrawEffect }

constructor TNormalDrawEffect.Create(XX, YY: Integer; WmImage: TWMImages;
  effbase, nX: Integer; frmTime: LongWord; boFlag: Boolean);
begin
  try //程序自动增加
    inherited Create(111, effbase, XX, YY, XX, YY, mtReady, TRUE, 0);
    ImgLib := WmImage;
    EffectBase := effbase;
    start := 0;
    curframe := 0;
    frame := nX;
    NextFrameTime := frmTime;
    boC8 := boFlag;
  except //程序自动增加
    DebugOutStr('[Exception] TNormalDrawEffect.Create'); //程序自动增加
  end; //程序自动增加
end;

procedure TNormalDrawEffect.DrawEff(surface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  nRx, nRy, nPx, nPy: integer;
begin
  try //程序自动增加
    d := ImgLib.GetCachedImage(EffectBase + curframe, nPx, nPy);
    if d <> nil then
    begin
      PlayScene.ScreenXYfromMCXY(FlyX, FlyY, nRx, nRy);
      if boC8 then
      begin
        DrawBlend(surface, nRx + nPx - UNITX div 2, nRy + nPy - UNITY div 2, d,
          1);
      end
      else
      begin
        surface.Draw(nRx + nPx - UNITX div 2, nRy + nPy - UNITY div 2,
          d.ClientRect, d, TRUE);
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TNormalDrawEffect.DrawEff'); //程序自动增加
  end; //程序自动增加
end;

function TNormalDrawEffect.Run: Boolean;
begin
  try //程序自动增加
    Result := TRUE;
    if m_boActive and (GetTickCount - steptime > longword(NextFrameTime)) then
    begin
      steptime := GetTickCount;
      Inc(curframe);
      if curframe > start + frame - 1 then
      begin
        curframe := start;
        Result := FALSE;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TNormalDrawEffect.Run:'); //程序自动增加
  end; //程序自动增加
end;

{ TFlyingBug }

constructor TFlyingBug.Create(id, effnum, sx, sy, tx, ty: integer;
  mtype: TMagicType; Recusion: Boolean; anitime: integer);
begin
  try //程序自动增加
    inherited Create(id, effnum, sx, sy, tx, ty, mtype, Recusion, anitime);
    FlyImageBase := FLYOMAAXEBASE;
    ReadyFrame := 65;
  except //程序自动增加
    DebugOutStr('[Exception] TFlyingBug.Create'); //程序自动增加
  end; //程序自动增加
end;

procedure TFlyingBug.DrawEff(surface: TDirectDrawSurface);
var
  img: integer;
  d: TDirectDrawSurface;
  shx, shy: integer;
begin
  try //程序自动增加
    if m_boActive and ((Abs(FlyX - fireX) > ReadyFrame) or (Abs(FlyY - fireY) >
      ReadyFrame)) then
    begin
      shx := (g_MySelf.m_nRx * UNITX + g_MySelf.m_nShiftX) - FireMyselfX;
      shy := (g_MySelf.m_nRy * UNITY + g_MySelf.m_nShiftY) - FireMyselfY;

      if not FixedEffect then
      begin
        img := FlyImageBase + (Dir16 div 2) * 10;
        d := ImgLib.GetCachedImage(img + curframe, px, py);
        if d <> nil then
        begin
          surface.Draw(FlyX + px - UNITX div 2 - shx,
            FlyY + py - UNITY div 2 - shy,
            d.ClientRect, d, TRUE);
        end;
      end
      else
      begin
        img := curframe + MagExplosionBase;
        d := ImgLib.GetCachedImage(img, px, py);
        if d <> nil then
        begin
          surface.Draw(FlyX + px - UNITX div 2,
            FlyY + py - UNITY div 2,
            d.ClientRect, d, TRUE);
        end;
      end;
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFlyingBug.DrawEff'); //程序自动增加
  end; //程序自动增加
end;

{ TFlyingFireBall }

procedure TFlyingFireBall.DrawEff(surface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  try //程序自动增加
    if m_boActive and ((Abs(FlyX - fireX) > ReadyFrame) or (Abs(FlyY - fireY) >
      ReadyFrame)) then
    begin
      d := ImgLib.GetCachedImage(FlyImageBase + (GetFlyDirection(FlyX, FlyY,
        TargetX, TargetY) * 10) + curframe, px, py);
      if d <> nil then
        DrawBlend(surface,
          FLyX + px - UNITX div 2,
          FlyY + py - UNITY div 2,
          d, 1);
    end;
  except //程序自动增加
    DebugOutStr('[Exception] TFlyingFireBall.DrawEff'); //程序自动增加
  end; //程序自动增加
end;

end.

