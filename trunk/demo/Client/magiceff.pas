unit magiceff;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grobal2, DxDraws, CliUtil, ClFunc, HUtil32, WIl;


const
   MG_READY       = 10;
   MG_FLY         = 6;
   MG_EXPLOSION   = 10;
   READYTIME  = 120;
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

   MAXEFFECT = 31;
   EffectBase: array[0..MAXEFFECT-1] of integer = (
      0,             //0  ȭ����
      200,           //1  ȸ����
      400,           //2  �ݰ�ȭ����
      600,           //3  �Ͽ���
      0,           //4  �˱�
      900,           //5  ȭ��ǳ
      920,           //6  ȭ�����
      940,           //7  ������ //����ȿ������
      20,            //8  ����,  Magic2
      940,           //9  ����� //����ȿ������
      940,           //10 ������ȣ //����ȿ������
      940,           //11 ������ȣ�� //����ȿ������
      0,          //12 ��˼�
      1380,          //13 ���
      1500,          //14 ������ڼ�ȯ, ��ȯ��
      1520,          //15 ���ż�
      940,           //16 ������
      1560,          //17 �������
      1590,          //18 �����̵�
      1620,          //19 ������
      1650,          //20 ȭ������
      1680,          //21 ������(��������)
      0,           //22 �ݿ��˹�
      0,           //23 ��ȭ��
      0,           //24 ���º�
      3960,          //25 Ž���Ŀ�
      1790,          //26 ��ȸ����
      0,            //27 �ż���ȯ  Magic2
      3880,          //28 �ּ��Ǹ�
      3920,          //29 ������ȸ
      3840          //30 ����ǳ
   );
   MAXHITEFFECT = 5;
   HitEffectBase: array[0..MAXHITEFFECT-1] of integer = (
      800,           //0, ��˼�
      1410,          //1 ��˼�
      1700,          //2 �ݿ��˹�
      3480,          //3 ��ȭ��, ����
      3390          //4 ��ȭ�� ��¦��
   );


   MAXMAGICTYPE = 12;

type
   TMagicType = (mtReady,           mtFly,            mtExplosion,
                 mtFlyAxe,          mtFireWind,       mtFireGun,
                 mtLightingThunder, mtThunder,        mtExploBujauk,
                 mtBujaukGroundEffect, mtKyulKai,     mtFlyArrow);

   TUseMagicInfo = record
      ServerMagicCode: integer;
      MagicSerial: integer;
      Target: integer; //recogcode
      EffectType: TMagicType;
      EffectNumber: integer;
      TargX: integer;
      TargY: integer;
      Recusion: Boolean;
      AniTime: integer;
   end;
   PTUseMagicInfo = ^TUseMagicInfo;

   TMagicEff = class
      Active: Boolean;
      ServerMagicId: integer;
      MagOwner: TObject;
      TargetActor: TObject;
      ImgLib: TWMImages;
      EffectBase: integer;
      MagExplosionBase: integer;
      px, py: integer;
      RX, RY: integer;  // ���� ��ǥ�� ȯ���� ��ǥ
      Dir16, OldDir16: byte;
      TargetX, TargetY: integer;   //Ÿ���� ��ũ�� ��ǥ
      TargetRx, TargetRy: integer; //Ÿ���� �� ��ǥ
      FlyX, FlyY, OldFlyX, OldFlyY: integer; //���� ��ǥ
      FlyXf, FlyYf: Real;
      Repetition: Boolean; //�ִϸ��̼� �ݺ�
      FixedEffect: Boolean;  //���� �ִϸ޽ü�
      MagicType: integer;
      NextEffect: TMagicEff;
      ExplosionFrame: integer;
      NextFrameTime: integer;
      Light: integer;
   private
      start, curframe, frame: integer;
      frametime: longword;
      starttime:  longword;
      repeattime: longword; //�ݺ� �ִϸ��̼� �ð� (-1: ���)
      steptime: longword;
      fireX, fireY: integer;
      firedisX, firedisY, newfiredisX, newfiredisY: integer;
      FireMyselfX, FireMyselfY: integer;
      prevdisx, prevdisy: integer; //���ư��� ȿ���� ��ǥ���� �Ÿ�
   protected
      procedure GetFlyXY (ms: integer; var fx, fy: integer);
   public
      constructor Create (id, effnum, sx, sy, tx, ty: integer; mtype: TMagicType; Recusion: Boolean; anitime: integer);
      destructor Destroy; override;
      function  Run: Boolean; dynamic; //false:������.
      function  Shift: Boolean; dynamic;
      procedure DrawEff (surface: TDirectDrawSurface); dynamic;
   end;

   TFlyingAxe = class (TMagicEff)
      FlyImageBase: integer;
      ReadyFrame: integer;
   public
      constructor Create (id, effnum, sx, sy, tx, ty: integer; mtype: TMagicType; Recusion: Boolean; anitime: integer);
      procedure DrawEff (surface: TDirectDrawSurface); override;
   end;

   TFlyingArrow = class (TFlyingAxe)
   public
      procedure DrawEff (surface: TDirectDrawSurface); override;
   end;

   TCharEffect = class (TMagicEff)
   public
      constructor Create (effbase, effframe: integer; target: TObject);
      function  Run: Boolean; override; //false:������.
      procedure DrawEff (surface: TDirectDrawSurface); override;
   end;

   TMapEffect = class (TMagicEff)
   public
      RepeatCount: integer;
      constructor Create (effbase, effframe: integer; x, y: integer);
      function  Run: Boolean; override; //false:������.
      procedure DrawEff (surface: TDirectDrawSurface); override;
   end;

   TScrollHideEffect = class (TMapEffect)
   public
      constructor Create (effbase, effframe: integer; x, y: integer; target: TObject);
      function  Run: Boolean; override;
   end;

   TLightingEffect = class (TMagicEff)
   public
      constructor Create (effbase, effframe: integer; x, y: integer);
      function  Run: Boolean; override;
   end;

   TFireNode = record
      x: integer;
      y: integer;
      firenumber: integer;
   end;

   TFireGunEffect = class (TMagicEff)
   public
      OutofOil: Boolean;
      firetime: longword;
      FireNodes: array[0..FIREGUNFRAME-1] of TFireNode;
      constructor Create (effbase, sx, sy, tx, ty: integer);
      function  Run: Boolean; override;
      procedure DrawEff (surface: TDirectDrawSurface); override;
   end;

   TThuderEffect = class (TMagicEff)
   public
      constructor Create (effbase, tx, ty: integer; target: TObject);
      procedure DrawEff (surface: TDirectDrawSurface); override;
   end;

   TLightingThunder = class (TMagicEff)
   public
      constructor Create (effbase, sx, sy, tx, ty: integer; target: TObject);
      procedure DrawEff (surface: TDirectDrawSurface); override;
   end;

   TExploBujaukEffect = class (TMagicEff)
   public
      constructor Create (effbase, sx, sy, tx, ty: integer; target: TObject);
      procedure DrawEff (surface: TDirectDrawSurface); override;
   end;

   TBujaukGroundEffect = class (TMagicEff)
   public
      MagicNumber: integer;
      BoGroundEffect: Boolean;
      constructor Create (effbase, magicnumb, sx, sy, tx, ty: integer);
      function  Run: Boolean; override;
      procedure DrawEff (surface: TDirectDrawSurface); override;
   end;

   procedure GetEffectBase (mag, mtype: integer; var wimg: TWMImages; var idx: integer);


implementation

uses
   ClMain, Actor, SoundUtil;


procedure GetEffectBase (mag, mtype: integer; var wimg: TWMImages; var idx: integer);
//function  GetEffectBase (mag, mtype: integer): integer;
begin
   wimg := nil;
   idx := 0;
   case mtype of
      0:  //�Ϲ����� ���� ���� ������
         begin
            case mag of
               8,  //����
               27: //�ż���ȯ
                  begin
                     wimg := FrmMain.WMagic2;
                     if mag in [0..MAXEFFECT-1] then
                        idx := EffectBase[mag];
                  end;
               else
                  begin
                     wimg := FrmMain.WMagic;
                     if mag in [0..MAXEFFECT-1] then
                        idx := EffectBase[mag];
                  end;
            end;
         end;
      1: //�˹� ȿ��
         begin
            wimg := FrmMain.WMagic;
            if mag in [0..MAXHITEFFECT-1] then begin
               idx := HitEffectBase[mag];
            end;
         end;
   end;
end;

constructor TMagicEff.Create (id, effnum, sx, sy, tx, ty: integer; mtype: TMagicType; Recusion: Boolean; anitime: integer);
var
   tax, tay: integer;
begin
   ImgLib := FrmMain.WMagic;  //�⺻
   case mtype of
      mtReady:
         begin
         end;
      mtFly,
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
   ServerMagicId := id; //������ ID
   EffectBase := effnum;
   TargetX := tx;   // "   target x
   TargetY := ty;   // "   target y
   fireX := sx;     //�� ��ġ
   fireY := sy;     //
   FlyX := sx;      //���ư��� �ִ� ��ġ
   FlyY := sy;
   OldFlyX := sx;
   OldFlyY := sy;
   FlyXf := sx;
   FlyYf := sy;
   FireMyselfX := Myself.RX*UNITX + Myself.ShiftX;
   FireMyselfY := Myself.RY*UNITY + Myself.ShiftY;
   MagExplosionBase := EffectBase + EXPLOSIONBASE;
   light := 1;

   if fireX <> TargetX then tax := abs(TargetX-fireX)
   else tax := 1;
   if fireY <> TargetY then tay := abs(TargetY-fireY)
   else tay := 1;
   if abs(fireX-TargetX) > abs(fireY-TargetY) then begin
      firedisX := Round((TargetX-fireX) * (500 / tax));
      firedisY := Round((TargetY-fireY) * (500 / tax));
   end else begin
      firedisX := Round((TargetX-fireX) * (500 / tay));
      firedisY := Round((TargetY-fireY) * (500 / tay));
   end;

   NextFrameTime := 50;
   frametime := GetTickCount;
   starttime := GetTickCount;
   steptime := GetTickCount;
   RepeatTime := anitime;
   Dir16 := GetFlyDirection16 (sx, sy, tx, ty);
   OldDir16 := Dir16;
   NextEffect := nil;
   Active := TRUE;
   prevdisx := 99999;
   prevdisy := 99999;
end;

destructor TMagicEff.Destroy;
begin
   inherited Destroy;
end;

function  TMagicEff.Shift: Boolean;
   function OverThrough (olddir, newdir: integer): Boolean;
   begin
      Result := FALSE;
      if abs(olddir-newdir) >= 2 then begin
         Result := TRUE;
         if ((olddir=0) and (newdir=15)) or ((olddir=15) and (newdir=0)) then
            Result := FALSE;
      end;
   end;
var
   i, rrx, rry, ms, stepx, stepy, newstepx, newstepy, nn: integer;
   tax, tay, shx, shy, passdir16: integer;
   crash: Boolean;
   stepxf, stepyf: Real;
begin
   Result := TRUE;
   if Repetition then begin
      if GetTickCount - steptime > longword(NextFrameTime) then begin
         steptime := GetTickCount;
         Inc (curframe);
         if curframe > start+frame-1 then
            curframe := start;
      end;
   end else begin
      if (frame > 0) and (GetTickCount - steptime > longword(NextFrameTime)) then begin
         steptime := GetTickCount;
         Inc (curframe);
         if curframe > start+frame-1 then begin
            curframe := start+frame-1;
            Result := FALSE;
         end;
      end;
   end;
   if (not FixedEffect) then begin

      crash := FALSE;
      if TargetActor <> nil then begin
         ms := GetTickCount - frametime;  //���� ȿ���� �׸��� �󸶳� �ð��� �귶����?
         frametime := GetTickCount;
         //TargetX, TargetY �缳��
         PlayScene.ScreenXYfromMCXY (TActor(TargetActor).RX,
                                     TActor(TargetActor).RY,
                                     TargetX,
                                     TargetY);
         shx := (Myself.RX*UNITX + Myself.ShiftX) - FireMyselfX;
         shy := (Myself.RY*UNITY + Myself.ShiftY) - FireMyselfY;
         TargetX := TargetX + shx;
         TargetY := TargetY + shy;

         //���ο� Ÿ���� ��ǥ�� ���� �����Ѵ�.
         if FlyX <> TargetX then tax := abs(TargetX-FlyX)
         else tax := 1;
         if FlyY <> TargetY then tay := abs(TargetY-FlyY)
         else tay := 1;
         if abs(FlyX-TargetX) > abs(FlyY-TargetY) then begin
            newfiredisX := Round((TargetX-FlyX) * (500 / tax));
            newfiredisY := Round((TargetY-FlyY) * (500 / tax));
         end else begin
            newfiredisX := Round((TargetX-FlyX) * (500 / tay));
            newfiredisY := Round((TargetY-FlyY) * (500 / tay));
         end;

         if firedisX < newfiredisX then firedisX := firedisX + _MAX(1, (newfiredisX - firedisX) div 10);
         if firedisX > newfiredisX then firedisX := firedisX - _MAX(1, (firedisX - newfiredisX) div 10);
         if firedisY < newfiredisY then firedisY := firedisY + _MAX(1, (newfiredisY - firedisY) div 10);
         if firedisY > newfiredisY then firedisY := firedisY - _MAX(1, (firedisY - newfiredisY) div 10);

         stepxf := (firedisX/700) * ms;
         stepyf := (firedisY/700) * ms;
         FlyXf := FlyXf + stepxf;
         FlyYf := FlyYf + stepyf;
         FlyX := Round (FlyXf);
         FlyY := Round (FlyYf);

         //���� �缳��
       //  Dir16 := GetFlyDirection16 (OldFlyX, OldFlyY, FlyX, FlyY);
         OldFlyX := FlyX;
         OldFlyY := FlyY;
         //������θ� Ȯ���ϱ� ���Ͽ�
         passdir16 := GetFlyDirection16 (FlyX, FlyY, TargetX, TargetY);

         //DebugOutStr (IntToStr(prevdisx) + ' ' + IntToStr(prevdisy) + ' / ' + IntToStr(abs(TargetX-FlyX)) + ' ' + IntToStr(abs(TargetY-FlyY)) + '   ' +
         //             IntToStr(firedisX) + '.' + IntToStr(firedisY) + ' ' +
         //             IntToStr(FlyX) + '.' + IntToStr(FlyY) + ' ' +
         //             IntToStr(TargetX) + '.' + IntToStr(TargetY));
         if ((abs(TargetX-FlyX) <= 15) and (abs(TargetY-FlyY) <= 15)) or
            ((abs(TargetX-FlyX) >= prevdisx) and (abs(TargetY-FlyY) >= prevdisy)) or
            OverThrough(OldDir16, passdir16) then begin
            crash := TRUE;
         end else begin
            prevdisx := abs(TargetX-FlyX);
            prevdisy := abs(TargetY-FlyY);
            //if (prevdisx <= 5) and (prevdisy <= 5) then crash := TRUE;
         end;
         OldDir16 := passdir16;

      end else begin
         ms := GetTickCount - frametime;  //ȿ���� ������ �󸶳� �ð��� �귶����?

         rrx := TargetX - fireX;
         rry := TargetY - fireY;

         stepx := Round ((firedisX/900) * ms);
         stepy := Round ((firedisY/900) * ms);
         FlyX := fireX + stepx;
         FlyY := fireY + stepy;
      end;

      PlayScene.CXYfromMouseXY (FlyX, FlyY, Rx, Ry);

      if crash and (TargetActor <> nil) then begin
         FixedEffect := TRUE;  //����
         start := 0;
         frame := ExplosionFrame;
         curframe := start;
         Repetition := FALSE;

         //������ ����
         PlaySound (TActor(MagOwner).magicexplosionsound);

      end;
      //if not Map.CanFly (Rx, Ry) then
      //   Result := FALSE;
   end;
   if FixedEffect then begin
      if frame = -1 then frame := ExplosionFrame;
      if TargetActor = nil then begin
         FlyX := TargetX - ((Myself.RX*UNITX + Myself.ShiftX) - FireMyselfX);
         FlyY := TargetY - ((Myself.RY*UNITY + Myself.ShiftY) - FireMyselfY);
         PlayScene.CXYfromMouseXY (FlyX, FlyY, Rx, Ry);
      end else begin
         Rx := TActor(TargetActor).Rx;
         Ry := TActor(TargetActor).Ry;
         PlayScene.ScreenXYfromMCXY (Rx, Ry, FlyX, FlyY);
         FlyX := FlyX + TActor(TargetActor).ShiftX;
         FlyY := FlyY + TActor(TargetActor).ShiftY;
      end;
   end;
end;

procedure TMagicEff.GetFlyXY (ms: integer; var fx, fy: integer);
var
   rrx, rry, stepx, stepy: integer;
begin
   rrx := TargetX - fireX;
   rry := TargetY - fireY;

   stepx := Round ((firedisX/900) * ms);
   stepy := Round ((firedisY/900) * ms);
   fx := fireX + stepx;
   fy := fireY + stepy;
end;

function  TMagicEff.Run: Boolean;
begin
   Result := Shift;
   if Result then
      if GetTickCount - starttime > 10000 then //2000 then
         Result := FALSE
      else Result := TRUE;
end;

procedure TMagicEff.DrawEff (surface: TDirectDrawSurface);
var
   img: integer;
   d: TDirectDrawSurface;
   shx, shy: integer;
begin
   if Active and ((Abs(FlyX-fireX) > 15) or (Abs(FlyY-fireY) > 15) or FixedEffect) then begin

      shx := (Myself.RX*UNITX + Myself.ShiftX) - FireMyselfX;
      shy := (Myself.RY*UNITY + Myself.ShiftY) - FireMyselfY;

      if not FixedEffect then begin
         //���ư��°�
         img := EffectBase + FLYBASE + Dir16 * 10;
         d := ImgLib.GetCachedImage (img + curframe, px, py);
         if d <> nil then begin
            DrawBlend (surface,
                       FlyX + px - UNITX div 2 - shx,
                       FlyY + py - UNITY div 2 - shy,
                       d, 1);
         end;
      end else begin
         //�����°�
         img := MagExplosionBase + curframe; //EXPLOSIONBASE;
         d := ImgLib.GetCachedImage (img, px, py);
         if d <> nil then begin
            DrawBlend (surface,
                       FlyX + px - UNITX div 2,
                       FlyY + py - UNITY div 2,
                       d, 1);
         end;
      end;
   end;
end;


{------------------------------------------------------------}

//      TFlyingAxe : ���ư��� ����

{------------------------------------------------------------}


constructor TFlyingAxe.Create (id, effnum, sx, sy, tx, ty: integer; mtype: TMagicType; Recusion: Boolean; anitime: integer);
begin
   inherited Create (id, effnum, sx, sy, tx, ty, mtype, Recusion, anitime);
   FlyImageBase := FLYOMAAXEBASE;
   ReadyFrame := 65;
end;

procedure TFlyingAxe.DrawEff (surface: TDirectDrawSurface);
var
   img: integer;
   d: TDirectDrawSurface;
   shx, shy: integer;
begin
   if Active and ((Abs(FlyX-fireX) > ReadyFrame) or (Abs(FlyY-fireY) > ReadyFrame)) then begin

      shx := (Myself.RX*UNITX + Myself.ShiftX) - FireMyselfX;
      shy := (Myself.RY*UNITY + Myself.ShiftY) - FireMyselfY;

      if not FixedEffect then begin
         //���ư��°�
         img := FlyImageBase + Dir16 * 10;
         d := ImgLib.GetCachedImage (img + curframe, px, py);
         if d <> nil then begin
            //���ĺ������� ����
            surface.Draw (FlyX + px - UNITX div 2 - shx,
                          FlyY + py - UNITY div 2 - shy,
                          d.ClientRect, d, TRUE);
         end;
      end else begin
         {//����, ������ ���� ���.
         img := FlyImageBase + Dir16 * 10;
         d := ImgLib.GetCachedImage (img, px, py);
         if d <> nil then begin
            //���ĺ������� ����
            surface.Draw (FlyX + px - UNITX div 2,
                          FlyY + py - UNITY div 2,
                          d.ClientRect, d, TRUE);
         end;  }
      end;
   end;
end;


{------------------------------------------------------------}

//      TFlyingArrow : ���ư��� ȭ��

{------------------------------------------------------------}


procedure TFlyingArrow.DrawEff (surface: TDirectDrawSurface);
var
   img: integer;
   d: TDirectDrawSurface;
   shx, shy: integer;
begin
//(**6����ġ
   if Active and ((Abs(FlyX-fireX) > 40) or (Abs(FlyY-fireY) > 40)) then begin
//*)
(**����
   if Active then begin //and ((Abs(FlyX-fireX) > 65) or (Abs(FlyY-fireY) > 65)) then begin
//*)
      shx := (Myself.RX*UNITX + Myself.ShiftX) - FireMyselfX;
      shy := (Myself.RY*UNITY + Myself.ShiftY) - FireMyselfY;

      if not FixedEffect then begin
         //���ư��°�
         img := FlyImageBase + Dir16; // * 10;
         d := ImgLib.GetCachedImage (img + curframe, px, py);
//(**6����ġ
         if d <> nil then begin
            //���ĺ������� ����
            surface.Draw (FlyX + px - UNITX div 2 - shx,
                          FlyY + py - UNITY div 2 - shy - 46,
                          d.ClientRect, d, TRUE);
         end;
//**)
(***����
         if d <> nil then begin
            //���ĺ������� ����
            surface.Draw (FlyX + px - UNITX div 2 - shx,
                          FlyY + py - UNITY div 2 - shy,
                          d.ClientRect, d, TRUE);
         end;
//**)
      end;
   end;
end;


{--------------------------------------------------------}

constructor TCharEffect.Create (effbase, effframe: integer; target: TObject);
begin
   inherited Create (111, effbase,
                     TActor(target).XX, TActor(target).YY,
                     TActor(target).XX, TActor(target).YY,
                     mtExplosion,
                     FALSE,
                     0);
   TargetActor := target;
   frame := effframe;
   NextFrameTime := 30;
end;

function  TCharEffect.Run: Boolean;
begin
   Result := TRUE;
   if GetTickCount - steptime > longword(NextFrameTime) then begin
      steptime := GetTickCount;
      Inc (curframe);
      if curframe > start+frame-1 then begin
         curframe := start+frame-1;
         Result := FALSE;
      end;
   end;
end;

procedure TCharEffect.DrawEff (surface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   if TargetActor <> nil then begin
      Rx := TActor(TargetActor).Rx;
      Ry := TActor(TargetActor).Ry;
      PlayScene.ScreenXYfromMCXY (Rx, Ry, FlyX, FlyY);
      FlyX := FlyX + TActor(TargetActor).ShiftX;
      FlyY := FlyY + TActor(TargetActor).ShiftY;
      d := ImgLib.GetCachedImage (EffectBase + curframe, px, py);
      if d <> nil then begin
         DrawBlend (surface,
                    FlyX + px - UNITX div 2,
                    FlyY + py - UNITY div 2,
                    d, 1);
      end;
   end;
end;


{--------------------------------------------------------}

constructor TMapEffect.Create (effbase, effframe: integer; x, y: integer);
begin
   inherited Create (111, effbase,
                     x, y,
                     x, y,
                     mtExplosion,
                     FALSE,
                     0);
   TargetActor := nil;
   frame := effframe;
   NextFrameTime := 30;
   RepeatCount := 0;
end;

function  TMapEffect.Run: Boolean;
begin
   Result := TRUE;
   if GetTickCount - steptime > longword(NextFrameTime) then begin
      steptime := GetTickCount;
      Inc (curframe);
      if curframe > start+frame-1 then begin
         curframe := start+frame-1;
         if RepeatCount > 0 then begin
            Dec (RepeatCount);
            curframe := start;
         end else
            Result := FALSE;
      end;
   end;
end;

procedure TMapEffect.DrawEff (surface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   Rx := TargetX;
   Ry := TargetY;
   PlayScene.ScreenXYfromMCXY (Rx, Ry, FlyX, FlyY);
   d := ImgLib.GetCachedImage (EffectBase + curframe, px, py);
   if d <> nil then begin
      DrawBlend (surface,
                 FlyX + px - UNITX div 2,
                 FlyY + py - UNITY div 2,
                 d, 1);
   end;
end;


{--------------------------------------------------------}

constructor TScrollHideEffect.Create (effbase, effframe: integer; x, y: integer; target: TObject);
begin
   inherited Create (effbase, effframe, x, y);
   TargetCret := TActor(target);
end;

function  TScrollHideEffect.Run: Boolean;
begin
   Result := inherited Run;
   if frame = 7 then
      if TargetCret <> nil then
         PlayScene.DeleteActor (TargetCret.RecogId);
end;


{--------------------------------------------------------}


constructor TLightingEffect.Create (effbase, effframe: integer; x, y: integer);
begin

end;

function  TLightingEffect.Run: Boolean;
begin
end;


{--------------------------------------------------------}


constructor TFireGunEffect.Create (effbase, sx, sy, tx, ty: integer);
begin
   inherited Create (111, effbase,
                     sx, sy,
                     tx, ty, //TActor(target).XX, TActor(target).YY,
                     mtFireGun,
                     TRUE,
                     0);
   NextFrameTime := 50;
   FillChar (FireNodes, sizeof(TFireNode)*FIREGUNFRAME, #0);
   OutofOil := FALSE;
   firetime := GetTickCount;
end;

function  TFireGunEffect.Run: Boolean;
var
   i, fx, fy: integer;
   allgone: Boolean;
begin
   Result := TRUE;
   if GetTickCount - steptime > longword(NextFrameTime) then begin
      Shift;
      steptime := GetTickCount;
      //if not FixedEffect then begin  //��ǥ�� ���� �ʾ�����
      if not OutofOil then begin
         if (abs(RX-TActor(MagOwner).RX) >= 5) or (abs(RY-TActor(MagOwner).RY) >= 5) or (GetTickCount - firetime > 800) then
            OutofOil := TRUE;
         for i:=FIREGUNFRAME-2 downto 0 do begin
            FireNodes[i].FireNumber := FireNodes[i].FireNumber + 1;
            FireNodes[i+1] := FireNodes[i];
         end;
         FireNodes[0].FireNumber := 1;
         FireNodes[0].x := FlyX;
         FireNodes[0].y := FlyY;
      end else begin
         allgone := TRUE;
         for i:=FIREGUNFRAME-2 downto 0 do begin
            if FireNodes[i].FireNumber <= FIREGUNFRAME then begin
               FireNodes[i].FireNumber := FireNodes[i].FireNumber + 1;
               FireNodes[i+1] := FireNodes[i];
               allgone := FALSE;
            end;
         end;
         if allgone then Result := FALSE;
      end;
   end;
end;

procedure TFireGunEffect.DrawEff (surface: TDirectDrawSurface);
var
   i, num, shx, shy, firex, firey, prx, pry, img: integer;
   d: TDirectDrawSurface;
begin
   prx := -1;
   pry := -1;
   for i:=0 to FIREGUNFRAME-1 do begin
      if (FireNodes[i].FireNumber <= FIREGUNFRAME) and (FireNodes[i].FireNumber > 0) then begin
         shx := (Myself.RX*UNITX + Myself.ShiftX) - FireMyselfX;
         shy := (Myself.RY*UNITY + Myself.ShiftY) - FireMyselfY;

         img := EffectBase + (FireNodes[i].FireNumber - 1);
         d := ImgLib.GetCachedImage (img, px, py);
         if d <> nil then begin
            firex := FireNodes[i].x + px - UNITX div 2 - shx;
            firey := FireNodes[i].y + py - UNITY div 2 - shy;
            if (firex <> prx) or (firey <> pry) then begin
               prx := firex;
               pry := firey;
               DrawBlend (surface, firex, firey, d, 1);
            end;
         end;
      end;
   end;
end;

{--------------------------------------------------------}

constructor TThuderEffect.Create (effbase, tx, ty: integer; target: TObject);
begin
   inherited Create (111, effbase,
                     tx, ty,
                     tx, ty, //TActor(target).XX, TActor(target).YY,
                     mtThunder,
                     FALSE,
                     0);
   TargetActor := target;

end;

procedure TThuderEffect.DrawEff (surface: TDirectDrawSurface);
var
   img, px, py: integer;
   d: TDirectDrawSurface;
begin
   img := EffectBase;
   d := ImgLib.GetCachedImage (img + curframe, px, py);
   if d <> nil then begin
      DrawBlend (surface,
                 FlyX + px - UNITX div 2,
                 FlyY + py - UNITY div 2,
                 d, 1);
   end;
end;


{--------------------------------------------------------}

constructor TLightingThunder.Create (effbase, sx, sy, tx, ty: integer; target: TObject);
begin
   inherited Create (111, effbase,
                     sx, sy,
                     tx, ty, //TActor(target).XX, TActor(target).YY,
                     mtLightingThunder,
                     FALSE,
                     0);
   TargetActor := target;
end;

procedure TLightingThunder.DrawEff (surface: TDirectDrawSurface);
var
   img, sx, sy, px, py, shx, shy: integer;
   d: TDirectDrawSurface;
begin
   img := EffectBase + Dir16 * 10;
   if curframe < 6 then begin

      shx := (Myself.RX*UNITX + Myself.ShiftX) - FireMyselfX;
      shy := (Myself.RY*UNITY + Myself.ShiftY) - FireMyselfY;

      d := ImgLib.GetCachedImage (img + curframe, px, py);
      if d <> nil then begin
         PlayScene.ScreenXYfromMCXY (TActor(MagOwner).RX,
                                     TActor(MagOwner).RY,
                                     sx,
                                     sy);
         DrawBlend (surface,
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
end;


{--------------------------------------------------------}

constructor TExploBujaukEffect.Create (effbase, sx, sy, tx, ty: integer; target: TObject);
begin
   inherited Create (111, effbase,
                     sx, sy,
                     tx, ty,
                     mtExploBujauk,
                     TRUE,
                     0);
   frame := 3;
   TargetActor := target;
   NextFrameTime := 50;
end;

procedure TExploBujaukEffect.DrawEff (surface: TDirectDrawSurface);
var
   img: integer;
   d: TDirectDrawSurface;
   shx, shy: integer;
   meff: TMapEffect;
begin
   if Active and ((Abs(FlyX-fireX) > 30) or (Abs(FlyY-fireY) > 30) or FixedEffect) then begin

      shx := (Myself.RX*UNITX + Myself.ShiftX) - FireMyselfX;
      shy := (Myself.RY*UNITY + Myself.ShiftY) - FireMyselfY;

      if not FixedEffect then begin
         //���ư��°�
         img := EffectBase + Dir16 * 10;
         d := ImgLib.GetCachedImage (img + curframe, px, py);
         if d <> nil then begin
            //���ĺ������� ����
            surface.Draw (FlyX + px - UNITX div 2 - shx,
                          FlyY + py - UNITY div 2 - shy,
                          d.ClientRect, d, TRUE);
         end;
      end else begin
         //����
         img := MagExplosionBase + curframe;
         d := ImgLib.GetCachedImage (img, px, py);
         if d <> nil then begin
            DrawBlend (surface,
                       FLyX + px - UNITX div 2,
                       FlyY + py - UNITY div 2,
                       d, 1);
         end;
      end;
   end;
end;

{--------------------------------------------------------}

constructor TBujaukGroundEffect.Create (effbase, magicnumb, sx, sy, tx, ty: integer);
begin
   inherited Create (111, effbase,
                     sx, sy,
                     tx, ty,
                     mtBujaukGroundEffect,
                     TRUE,
                     0);
   frame := 3;
   MagicNumber := magicnumb;
   BoGroundEffect := FALSE;
   NextFrameTime := 50;
end;

function  TBujaukGroundEffect.Run: Boolean;
begin
   Result := inherited Run;
   if not FixedEffect then begin
      if ((abs(TargetX-FlyX) <= 15) and (abs(TargetY-FlyY) <= 15)) or
         ((abs(TargetX-FlyX) >= prevdisx) and (abs(TargetY-FlyY) >= prevdisy)) then begin
         FixedEffect := TRUE;  //����
         start := 0;
         frame := ExplosionFrame;
         curframe := start;
         Repetition := FALSE;
         //������ ����
         PlaySound (TActor(MagOwner).magicexplosionsound);

         Result := TRUE;
      end else begin
         prevdisx := abs(TargetX-FlyX);
         prevdisy := abs(TargetY-FlyY);
      end;
   end;
end;

procedure TBujaukGroundEffect.DrawEff (surface: TDirectDrawSurface);
var
   img: integer;
   d: TDirectDrawSurface;
   shx, shy: integer;
   meff: TMapEffect;
begin
   if Active and ((Abs(FlyX-fireX) > 30) or (Abs(FlyY-fireY) > 30) or FixedEffect) then begin

      shx := (Myself.RX*UNITX + Myself.ShiftX) - FireMyselfX;
      shy := (Myself.RY*UNITY + Myself.ShiftY) - FireMyselfY;

      if not FixedEffect then begin
         //���ư��°�
         img := EffectBase + Dir16 * 10;
         d := ImgLib.GetCachedImage (img + curframe, px, py);
         if d <> nil then begin
            //���ĺ������� ����
            surface.Draw (FlyX + px - UNITX div 2 - shx,
                          FlyY + py - UNITY div 2 - shy,
                          d.ClientRect, d, TRUE);
         end;
      end else begin
         //����
         if MagicNumber = 11 then  //��
            img := EffectBase + 16 * 10 + curframe
         else                      //��
            img := EffectBase + 18 * 10 + curframe;
         d := ImgLib.GetCachedImage (img, px, py);
         if d <> nil then begin
            DrawBlend (surface,
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
end;


end.
