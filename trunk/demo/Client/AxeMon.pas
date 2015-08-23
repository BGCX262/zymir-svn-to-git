unit AxeMon;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grobal2, DxDraws, CliUtil, ClFunc, magiceff, Actor, ClEvent;


const
   DEATHEFFECTBASE = 340;
   DEATHFIREEFFECTBASE = 2860;
   AXEMONATTACKFRAME = 6;
   KUDEGIGASBASE = 1445;
   COWMONFIREBASE = 1800;
   COWMONLIGHTBASE = 1900;
   ZOMBILIGHTINGBASE = 350;
   ZOMBIDIEBASE = 340;
   ZOMBILIGHTINGEXPBASE = 520;
   SCULPTUREFIREBASE = 1680;
   MOTHPOISONGASBASE = 3590;
   DUNGPOISONGASBASE = 3590;
   WARRIORELFFIREBASE = 820;

type
   TSkeletonOma = class (TActor)
   private
   protected
      EffectSurface: TDirectDrawSurface;
      ax, ay: integer;
   public
      constructor Create; override;
      //destructor Destroy; override;
      procedure CalcActorFrame; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
      procedure LoadSurface; override;
      procedure Run; override;
      procedure DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean); override;
   end;

   TDualAxeOma = class (TSkeletonOma)  //도끼던지는 몹
   private
   public
      procedure Run; override;
   end;

   TCatMon = class (TSkeletonOma)
   private
   public
      procedure DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean); override;
   end;

   TArcherMon = class (TCatMon)
   public
      procedure Run; override;
   end;

   TScorpionMon = class (TCatMon)
   public
   end;

   THuSuABi = class (TSkeletonOma)
   public
      procedure LoadSurface; override;
   end;

   TZombiDigOut = class (TSkeletonOma)
   public
      procedure RunFrameAction (frame: integer); override;
   end;

   TZombiZilkin = class (TSkeletonOma)
   public
   end;

   TWhiteSkeleton = class (TSkeletonOma)
   public
   end;


   TGasKuDeGi = class (TActor)
   protected
      AttackEffectSurface: TDirectDrawSurface;
      DieEffectSurface: TDirectDrawSurface;
      BoUseDieEffect: Boolean;
      firedir, fire16dir, ax, ay, bx, by: integer;
   public
      constructor Create; override;
      procedure CalcActorFrame; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
      procedure LoadSurface; override;
      procedure Run; override;
      procedure DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean); override;
      procedure DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
   end;

   TFireCowFaceMon = class (TGasKuDeGi)
   public
      function   Light: integer; override;
   end;

   TCowFaceKing = class (TGasKuDeGi)
   public
      function   Light: integer; override;
   end;

   TZombiLighting = class (TGasKuDeGi)
   protected
   public
   end;

   TSculptureMon = class (TSkeletonOma)
   private
      AttackEffectSurface: TDirectDrawSurface;
      ax, ay, firedir: integer;
   public
      procedure CalcActorFrame; override;
      procedure LoadSurface; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
      procedure DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
      procedure Run; override;
   end;

   TSculptureKingMon = class (TSculptureMon)
   public
   end;

   TSmallElfMonster = class (TSkeletonOma)
   public
   end;

   TWarriorElfMonster = class (TSkeletonOma)
   private
      oldframe: integer;
   public
      procedure  RunFrameAction (frame: integer); override;  //프래임마다 독특하게 해야할일
   end;



implementation

uses
   ClMain;


{============================== TSkeletonOma =============================}

//      해골 오마(해골, 큰도끼해골, 해골전사)

{--------------------------}


constructor TSkeletonOma.Create;
begin
   inherited Create;
   EffectSurface := nil;
   BoUseEffect := FALSE;
end;

procedure TSkeletonOma.CalcActorFrame;
var
   pm: PTMonsterAction;
   haircount: integer;
begin
   currentframe := -1;
   ReverseFrame := FALSE;
   BoUseEffect := FALSE;

   BodyOffset := GetOffset (Appearance);
   pm := RaceByPM (Race);
   if pm = nil then exit;

   case CurrentAction of
      SM_TURN:
         begin
            startframe := pm.ActStand.start + Dir * (pm.ActStand.frame + pm.ActStand.skip);
            endframe := startframe + pm.ActStand.frame - 1;
            frametime := pm.ActStand.ftime;
            starttime := GetTickCount;
            defframecount := pm.ActStand.frame;
            Shift (Dir, 0, 0, 1);
         end;
      SM_WALK, SM_BACKSTEP:
         begin
            startframe := pm.ActWalk.start + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
            endframe := startframe + pm.ActWalk.frame - 1;
            frametime := pm.ActWalk.ftime;
            starttime := GetTickCount;
            maxtick := pm.ActWalk.UseTick;
            curtick := 0;
            //WarMode := FALSE;
            movestep := 1;
            if CurrentAction = SM_WALK then
               Shift (Dir, movestep, 0, endframe-startframe+1)
            else  //sm_backstep
               Shift (GetBack(Dir), movestep, 0, endframe-startframe+1);
         end;
      SM_DIGUP: //걷기 없음, SM_DIGUP, 방향 없음.
         begin
            if (Race = 23) then begin //or (Race = 54) or (Race = 55) then begin
               //백골
               startframe := pm.ActDeath.start;
            end else begin
               startframe := pm.ActDeath.start + Dir * (pm.ActDeath.frame + pm.ActDeath.skip);
            end;
            endframe := startframe + pm.ActDeath.frame - 1;
            frametime := pm.ActDeath.ftime;
            starttime := GetTickCount;
            //WarMode := FALSE;
            Shift (Dir, 0, 0, 1);
         end;
      SM_DIGDOWN:
         begin
            if Race = 55 then begin
               //신수1 인 경우 역변신
               startframe := pm.ActCritical.start + Dir * (pm.ActCritical.frame + pm.ActCritical.skip);
               endframe := startframe + pm.ActCritical.frame - 1;
               frametime := pm.ActCritical.ftime;
               starttime := GetTickCount;
               ReverseFrame := TRUE;
               //WarMode := FALSE;
               Shift (Dir, 0, 0, 1);
            end;
         end;
      SM_HIT,
      SM_FLYAXE,
      SM_LIGHTING:
         begin
            startframe := pm.ActAttack.start + Dir * (pm.ActAttack.frame + pm.ActAttack.skip);
            endframe := startframe + pm.ActAttack.frame - 1;
            frametime := pm.ActAttack.ftime;
            starttime := GetTickCount;
            //WarMode := TRUE;
            WarModeTime := GetTickCount;
            if (Race = 16) or (Race = 54) then
               BoUseEffect := TRUE;
            Shift (Dir, 0, 0, 1);
         end;
      SM_STRUCK:
         begin
            startframe := pm.ActStruck.start + Dir * (pm.ActStruck.frame + pm.ActStruck.skip);
            endframe := startframe + pm.ActStruck.frame - 1;
            frametime := struckframetime; //pm.ActStruck.ftime;
            starttime := GetTickCount;
         end;
      SM_DEATH:
         begin
            startframe := pm.ActDie.start + Dir * (pm.ActDie.frame + pm.ActDie.skip);
            endframe := startframe + pm.ActDie.frame - 1;
            startframe := endframe; //
            frametime := pm.ActDie.ftime;
            starttime := GetTickCount;
         end;
      SM_NOWDEATH:
         begin
            startframe := pm.ActDie.start + Dir * (pm.ActDie.frame + pm.ActDie.skip);
            endframe := startframe + pm.ActDie.frame - 1;
            frametime := pm.ActDie.ftime;
            starttime := GetTickCount;
            if Race <> 22 then
               BoUseEffect := TRUE;
         end;
      SM_SKELETON:
         begin
            startframe := pm.ActDeath.start;
            endframe := startframe + pm.ActDeath.frame - 1;
            frametime := pm.ActDeath.ftime;
            starttime := GetTickCount;
         end;
      SM_ALIVE:
         begin
            startframe := pm.ActDeath.start + Dir * (pm.ActDeath.frame + pm.ActDeath.skip);
            endframe := startframe + pm.ActDeath.frame - 1;
            frametime := pm.ActDeath.ftime;
            starttime := GetTickCount;
         end;
   end;
end;

function  TSkeletonOma.GetDefaultFrame (wmode: Boolean): integer;
var
   cf, dr: integer;
   pm: PTMonsterAction;
begin
   pm := RaceByPM (Race);
   if pm = nil then exit;

   if Death then begin
      //우면귀일 경우
      if Appearance in [30..34, 151] then //우면귀인 경우 시체가 사람을 덮는 것을 막기 위해
         DownDrawLevel := 1;

      if Skeleton then
         Result := pm.ActDeath.start
      else Result := pm.ActDie.start + Dir * (pm.ActDie.frame + pm.ActDie.skip) + (pm.ActDie.frame - 1);
   end else begin
      defframecount := pm.ActStand.frame;
      if currentdefframe < 0 then cf := 0
      else if currentdefframe >= pm.ActStand.frame then cf := 0
      else cf := currentdefframe;
      Result := pm.ActStand.start + Dir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
   end;
end;

procedure  TSkeletonOma.LoadSurface;
begin
   inherited LoadSurface;
   case Race of
      //몬스터
      14, 15, 17, 22, 53:
         begin
            if BoUseEffect then
               EffectSurface := FrmMain.WMon3Img.GetCachedImage (DEATHEFFECTBASE + currentframe-startframe, ax, ay);
         end;
      23:
         begin
            if CurrentAction = SM_DIGUP then begin
               BodySurface := nil;
               EffectSurface := FrmMain.WMon4Img.GetCachedImage (BodyOffset + currentframe, ax, ay);
               BoUseEffect := TRUE;
            end else
               BoUseEffect := FALSE;
         end;
   end;
end;

procedure  TSkeletonOma.Run;
var
   prv: integer;
   frametimetime: longword;
begin
   if (CurrentAction = SM_WALK) or (CurrentAction = SM_BACKSTEP) or (CurrentAction = SM_RUN) then exit;

   msgmuch := FALSE;
   if MsgList.Count >= 2 then msgmuch := TRUE;

   //사운드 효과
   RunActSound (currentframe - startframe);
   RunFrameAction (currentframe - startframe);

   prv := currentframe;
   if CurrentAction <> 0 then begin
      if (currentframe < startframe) or (currentframe > endframe) then
         currentframe := startframe;

      if msgmuch then frametimetime := Round(frametime * 2 / 3)
      else frametimetime := frametime;

      if GetTickCount - starttime > frametimetime then begin
         if currentframe < endframe then begin
            Inc (currentframe);
            starttime := GetTickCount;
         end else begin
            //동작이 끝남.
            CurrentAction := 0; //동작 완료
            BoUseEffect := FALSE;
         end;
      end;
      currentdefframe := 0;
      defframetime := GetTickCount;
   end else begin
      if GetTickCount - smoothmovetime > 200 then begin
         if GetTickCount - defframetime > 500 then begin
            defframetime := GetTickCount;
            Inc (currentdefframe);
            if currentdefframe >= defframecount then
               currentdefframe := 0;
         end;
         DefaultMotion;
      end;
   end;

   if prv <> currentframe then begin
      loadsurfacetime := GetTickCount;
      LoadSurface;
   end;

end;


procedure TSkeletonOma.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean);
var
   idx: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
begin
   if not (Dir in [0..7]) then exit;
   if GetTickCount - loadsurfacetime > 60 * 1000 then begin
      loadsurfacetime := GetTickCount;
      LoadSurface; //bodysurface등이 loadsurface를 다시 부르지 않아 메모리가 프리되는 것을 막음
   end;

   ceff := GetDrawEffectValue;

   if BodySurface <> nil then begin
      DrawEffSurface (dsurface, BodySurface, dx + px + ShiftX, dy + py + ShiftY, blend, ceff);
   end;

   if BoUseEffect then
      if EffectSurface <> nil then begin
         DrawBlend (dsurface,
                    dx + ax + ShiftX,
                    dy + ay + ShiftY,
                    EffectSurface, 1);
      end;
end;




{============================== TSkeletonOma =============================}

//      해골 오마(해골, 큰도끼해골, 해골전사)

{--------------------------}


procedure  TDualAxeOma.Run;
var
   prv: integer;
   frametimetime: longword;
   meff: TFlyingAxe;
begin
   if (CurrentAction = SM_WALK) or (CurrentAction = SM_BACKSTEP) or (CurrentAction = SM_RUN) then exit;

   msgmuch := FALSE;
   if MsgList.Count >= 2 then msgmuch := TRUE;

   //사운드 효과
   RunActSound (currentframe - startframe);
   //프래임마다 해야 할일
   RunFrameAction (currentframe - startframe);

   prv := currentframe;
   if CurrentAction <> 0 then begin
      if (currentframe < startframe) or (currentframe > endframe) then
         currentframe := startframe;

      if msgmuch then frametimetime := Round(frametime * 2 / 3)
      else frametimetime := frametime;

      if GetTickCount - starttime > frametimetime then begin
         if currentframe < endframe then begin
            Inc (currentframe);
            starttime := GetTickCount;
         end else begin
            //동작이 끝남.
            CurrentAction := 0; //동작 완료
            BoUseEffect := FALSE;
         end;
         if (CurrentAction = SM_FLYAXE) and (currentframe-startframe = AXEMONATTACKFRAME-4) then begin //도끼를 던질 시점
            //마법 발사
            meff := TFlyingAxe (PlayScene.NewFlyObject (self,
                             XX,
                             YY,
                             TargetX,
                             TargetY,
                             TargetRecog,
                             mtFlyAxe));
            if meff <> nil then begin
               meff.ImgLib := FrmMain.WMon3Img;
               case Race of
                  15: meff.FlyImageBase := FLYOMAAXEBASE;
                  22: meff.FlyImageBase := THORNBASE;
               end;
            end;      
         end;
      end;
      currentdefframe := 0;
      defframetime := GetTickCount;
   end else begin
      if GetTickCount - smoothmovetime > 200 then begin
         if GetTickCount - defframetime > 500 then begin
            defframetime := GetTickCount;
            Inc (currentdefframe);
            if currentdefframe >= defframecount then
               currentdefframe := 0;
         end;
         DefaultMotion;
      end;
   end;

   if prv <> currentframe then begin
      loadsurfacetime := GetTickCount;
      LoadSurface;
   end;

end;


{============================== TGasKuDeGi =============================}

//         TCatMon : 괭이,  프래임은 해골이랑 같고, 터지는 애니가 없음.


procedure  TWarriorElfMonster.RunFrameAction (frame: integer); //프래임마다 독특하게 해야할일
var
   meff: TMapEffect;
   event: TClEvent;
begin
   if CurrentAction = SM_HIT then begin
      if (frame = 5) and (oldframe <> frame) then begin
         meff := TMapEffect.Create (WARRIORELFFIREBASE + 10 * Dir + 1, 5, XX, YY);
         meff.ImgLib := FrmMain.WMon18Img;
         meff.NextFrameTime := 100;
         PlayScene.EffectList.Add (meff);
      end;
      oldframe := frame;
   end;
end;

{============================== TGasKuDeGi =============================}

//         TCatMon : 괭이,  프래임은 해골이랑 같고, 터지는 애니가 없음.

{--------------------------}


procedure TCatMon.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean);
var
   idx: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
begin
   if not (Dir in [0..7]) then exit;
   if GetTickCount - loadsurfacetime > 60 * 1000 then begin
      loadsurfacetime := GetTickCount;
      LoadSurface; //bodysurface등이 loadsurface를 다시 부르지 않아 메모리가 프리되는 것을 막음
   end;

   ceff := GetDrawEffectValue;

   if BodySurface <> nil then
      DrawEffSurface (dsurface, BodySurface, dx + px + ShiftX, dy + py + ShiftY, blend, ceff);

end;


{============================= TArcherMon =============================}


procedure TArcherMon.Run;
var
   prv: integer;
   frametimetime: longword;
   meff: TFlyingAxe;
begin
   if (CurrentAction = SM_WALK) or (CurrentAction = SM_BACKSTEP) or (CurrentAction = SM_RUN) then exit;

   msgmuch := FALSE;
   if MsgList.Count >= 2 then msgmuch := TRUE;

   //사운드 효과
   RunActSound (currentframe - startframe);
   //프래임마다 해야 할일
   RunFrameAction (currentframe - startframe);

   prv := currentframe;
   if CurrentAction <> 0 then begin
      if (currentframe < startframe) or (currentframe > endframe) then
         currentframe := startframe;

      if msgmuch then frametimetime := Round(frametime * 2 / 3)
      else frametimetime := frametime;

      if GetTickCount - starttime > frametimetime then begin
         if currentframe < endframe then begin
            Inc (currentframe);
            starttime := GetTickCount;
         end else begin
            //동작이 끝남.
            CurrentAction := 0; //동작 완료
            BoUseEffect := FALSE;
         end;
         if (CurrentAction = SM_FLYAXE) and (currentframe-startframe = 4) then begin
            //화살 나감
//(** 6월패치

            meff := TFlyingArrow (PlayScene.NewFlyObject (self,
                             XX,
                             YY,
                             TargetX,
                             TargetY,
                             TargetRecog,
                             mtFlyArrow));
            if meff <> nil then begin
               meff.ImgLib := FrmMain.WEffectImg; //WMon5Img;
               meff.NextFrameTime := 30;
               meff.FlyImageBase := ARCHERBASE2;
            end;
//**)
(** 이전
            meff := TFlyingArrow (PlayScene.NewFlyObject (self,
                             XX,
                             YY,
                             TargetX,
                             TargetY,
                             TargetRecog,
                             mtFlyAxe));
            if meff <> nil then begin
               meff.ImgLib := FrmMain.WMon5Img;
               meff.NextFrameTime := 30;
               meff.FlyImageBase := ARCHERBASE;
            end;
//**)
         end;
      end;
      currentdefframe := 0;
      defframetime := GetTickCount;
   end else begin
      if GetTickCount - smoothmovetime > 200 then begin
         if GetTickCount - defframetime > 500 then begin
            defframetime := GetTickCount;
            Inc (currentdefframe);
            if currentdefframe >= defframecount then
               currentdefframe := 0;
         end;
         DefaultMotion;
      end;
   end;

   if prv <> currentframe then begin
      loadsurfacetime := GetTickCount;
      LoadSurface;
   end;

end;


{============================= TZombiDigOut =============================}


procedure TZombiDigOut.RunFrameAction (frame: integer);
var
   clevent: TClEvent;
begin
   if CurrentAction = SM_DIGUP then begin
      if frame = 6 then begin
         clevent := TClEvent.Create (CurrentEvent, XX, YY, ET_DIGOUTZOMBI);
         clevent.Dir := Dir;
         EventMan.AddEvent (clevent);
         //pdo.DSurface := FrmMain.WMon6Img.GetCachedImage (ZOMBIDIGUPDUSTBASE+Dir, pdo.px, pdo.py);
      end;
   end;
end;


{============================== THuSuABi =============================}

//      허수아비

{--------------------------}


procedure  THuSuABi.LoadSurface;
begin
   inherited LoadSurface;
   if BoUseEffect then
      EffectSurface := FrmMain.WMon3Img.GetCachedImage (DEATHFIREEFFECTBASE + currentframe-startframe, ax, ay);
end;


{============================== TGasKuDeGi =============================}

//      대형구데기 (가스쏘는 구데기)

{--------------------------}


constructor TGasKuDeGi.Create;
begin
   inherited Create;
   AttackEffectSurface := nil;
   DieEffectSurface := nil;
   BoUseEffect := FALSE;
   BoUseDieEffect := FALSE;
end;

procedure TGasKuDeGi.CalcActorFrame;
var
   pm: PTMonsterAction;
   actor: TActor;
   haircount, scx, scy, stx, sty: integer;
   meff: TCharEffect;
begin
   currentframe := -1;

   BodyOffset := GetOffset (Appearance);
   pm := RaceByPM (Race);
   if pm = nil then exit;

   case CurrentAction of
      SM_TURN:
         begin
            startframe := pm.ActStand.start + Dir * (pm.ActStand.frame + pm.ActStand.skip);
            endframe := startframe + pm.ActStand.frame - 1;
            frametime := pm.ActStand.ftime;
            starttime := GetTickCount;
            defframecount := pm.ActStand.frame;
            Shift (Dir, 0, 0, 1);
         end;
      SM_WALK:
         begin
            startframe := pm.ActWalk.start + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
            endframe := startframe + pm.ActWalk.frame - 1;
            frametime := pm.ActWalk.ftime;
            starttime := GetTickCount;
            maxtick := pm.ActWalk.UseTick;
            curtick := 0;
            //WarMode := FALSE;
            movestep := 1;
            if CurrentAction = SM_WALK then
               Shift (Dir, movestep, 0, endframe-startframe+1)
            else  //sm_backstep
               Shift (GetBack(Dir), movestep, 0, endframe-startframe+1);
         end;
      SM_HIT,
      SM_LIGHTING:
         begin
            startframe := pm.ActAttack.start + Dir * (pm.ActAttack.frame + pm.ActAttack.skip);
            endframe := startframe + pm.ActAttack.frame - 1;
            frametime := pm.ActAttack.ftime;
            starttime := GetTickCount;
            //WarMode := TRUE;
            WarModeTime := GetTickCount;
            Shift (Dir, 0, 0, 1);
            BoUseEffect := TRUE;
            firedir := Dir;
            effectframe := startframe;
            effectstart := startframe;
            if Race = 20 then effectend := endframe + 1
            else effectend := endframe;
            effectstarttime := GetTickCount;
            effectframetime := frametime;

            //16방향인 마법 설정
            actor := PlayScene.FindActor (TargetRecog);
            if actor <> nil then begin
               PlayScene.ScreenXYfromMCXY (XX, YY, scx, scy);
               PlayScene.ScreenXYfromMCXY (actor.XX, actor.YY, stx, sty);
               fire16dir := GetFlyDirection16 (scx, scy, stx, sty);
               //meff := TCharEffect.Create (ZOMBILIGHTINGEXPBASE, 12, actor);  //맞는 사람 효과
               //meff.ImgLib := FrmMain.WMon5Img;
               //meff.NextFrameTime := 50;
               //PlayScene.EffectList.Add (meff);
            end else
               fire16dir := firedir * 2;
         end;
      SM_STRUCK:
         begin
            startframe := pm.ActStruck.start + Dir * (pm.ActStruck.frame + pm.ActStruck.skip);
            endframe := startframe + pm.ActStruck.frame - 1;
            frametime := struckframetime; //pm.ActStruck.ftime;
            starttime := GetTickCount;
         end;
      SM_DEATH:
         begin
            startframe := pm.ActDie.start + Dir * (pm.ActDie.frame + pm.ActDie.skip);
            endframe := startframe + pm.ActDie.frame - 1;
            startframe := endframe; //
            frametime := pm.ActDie.ftime;
            starttime := GetTickCount;
         end;
      SM_NOWDEATH:
         begin
            startframe := pm.ActDie.start + Dir * (pm.ActDie.frame + pm.ActDie.skip);
            endframe := startframe + pm.ActDie.frame - 1;
            frametime := pm.ActDie.ftime;
            starttime := GetTickCount;

            if Race = 40 then  //마법 좀비
               BoUseDieEffect := TRUE;
         end;
      SM_SKELETON:
         begin
            startframe := pm.ActDeath.start;
            endframe := startframe + pm.ActDeath.frame - 1;
            frametime := pm.ActDeath.ftime;
            starttime := GetTickCount;
         end;
   end;
end;

function  TGasKuDeGi.GetDefaultFrame (wmode: Boolean): integer;
var
   cf, dr: integer;
   pm: PTMonsterAction;
begin
   pm := RaceByPM (Race);
   if pm = nil then exit;

   if Death then begin
      if Skeleton then
         Result := pm.ActDeath.start
      else Result := pm.ActDie.start + Dir * (pm.ActDie.frame + pm.ActDie.skip) + (pm.ActDie.frame - 1);
   end else begin
      defframecount := pm.ActStand.frame;
      if currentdefframe < 0 then cf := 0
      else if currentdefframe >= pm.ActStand.frame then cf := 0
      else cf := currentdefframe;
      Result := pm.ActStand.start + Dir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
   end;
end;

procedure  TGasKuDeGi.LoadSurface;
begin
   inherited LoadSurface;
   case Race of
      //몬스터
      16:
         begin
            if BoUseEffect then
               AttackEffectSurface := FrmMain.WMon3Img.GetCachedImage (
                        KUDEGIGASBASE-1 + (firedir * 10) + effectframe-effectstart, //가스는 처음 한프레음 늦게 시작함.
                        ax, ay);
         end;
      20:
         begin
            if BoUseEffect then
               AttackEffectSurface := FrmMain.WMon4Img.GetCachedImage (
                        COWMONFIREBASE + (firedir * 10) + effectframe-effectstart, //
                        ax, ay);
         end;
      21:
         begin
            if BoUseEffect then
               AttackEffectSurface := FrmMain.WMon4Img.GetCachedImage (
                        COWMONLIGHTBASE + (firedir * 10) + effectframe-effectstart, //
                        ax, ay);
         end;
      40:
         begin
            if BoUseEffect then begin
               AttackEffectSurface := FrmMain.WMon5Img.GetCachedImage (
                        ZOMBILIGHTINGBASE + (fire16dir * 10) + effectframe-effectstart, //
                        ax, ay);
            end;
            if BoUseDieEffect then begin
               DieEffectSurface := FrmMain.WMon5Img.GetCachedImage (
                        ZOMBIDIEBASE + currentframe-startframe, //
                        bx, by);
            end;
         end;
      52:
         begin
            if BoUseEffect then
               AttackEffectSurface := FrmMain.WMon4Img.GetCachedImage (
                        MOTHPOISONGASBASE + (firedir * 10) + effectframe-effectstart, //
                        ax, ay);
         end;
      53:
         begin
            if BoUseEffect then
               AttackEffectSurface := FrmMain.WMon3Img.GetCachedImage (
                        DUNGPOISONGASBASE + (firedir * 10) + effectframe-effectstart, //
                        ax, ay);
         end;
   end;
end;

procedure  TGasKuDeGi.Run;
var
   prv: integer;
   effectframetimetime, frametimetime: longword;
begin
   if (CurrentAction = SM_WALK) or (CurrentAction = SM_BACKSTEP) or (CurrentAction = SM_RUN) then exit;

   msgmuch := FALSE;
   if MsgList.Count >= 2 then msgmuch := TRUE;

   //사운드 효과
   RunActSound (currentframe - startframe);
   RunFrameAction (currentframe - startframe);

   if BoUseEffect then begin
      if msgmuch then effectframetimetime := Round(effectframetime * 2 / 3)
      else effectframetimetime := effectframetime;
      if GetTickCount - effectstarttime > effectframetimetime then begin
         effectstarttime := GetTickCount;
         if effectframe < effectend then begin
            Inc (effectframe);
         end else begin
            BoUseEffect := FALSE;
         end;
      end;
   end;

   prv := currentframe;
   if CurrentAction <> 0 then begin
      if (currentframe < startframe) or (currentframe > endframe) then
         currentframe := startframe;

      if msgmuch then frametimetime := Round(frametime * 2 / 3)
      else frametimetime := frametime;

      if GetTickCount - starttime > frametimetime then begin
         if currentframe < endframe then begin
            Inc (currentframe);
            starttime := GetTickCount;
         end else begin
            //동작이 끝남.
            CurrentAction := 0; //동작 완료
            BoUseDieEffect := FALSE;
         end;

      end;
      currentdefframe := 0;
      defframetime := GetTickCount;
   end else begin
      if GetTickCount - smoothmovetime > 200 then begin
         if GetTickCount - defframetime > 500 then begin
            defframetime := GetTickCount;
            Inc (currentdefframe);
            if currentdefframe >= defframecount then
               currentdefframe := 0;
         end;
         DefaultMotion;
      end;
   end;

   if prv <> currentframe then begin
      loadsurfacetime := GetTickCount;
      LoadSurface;
   end;

end;


procedure TGasKuDeGi.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean);
var
   idx: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
begin
   if not (Dir in [0..7]) then exit;
   if GetTickCount - loadsurfacetime > 60 * 1000 then begin
      loadsurfacetime := GetTickCount;
      LoadSurface; //bodysurface등이 loadsurface를 다시 부르지 않아 메모리가 프리되는 것을 막음
   end;

   ceff := GetDrawEffectValue;

   if BodySurface <> nil then
      DrawEffSurface (dsurface, BodySurface, dx + px + ShiftX, dy + py + ShiftY, blend, ceff);

end;

procedure TGasKuDeGi.DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer);
var
   idx: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
begin
   if BoUseEffect then
      if AttackEffectSurface <> nil then begin
         DrawBlend (dsurface,
                    dx + ax + ShiftX,
                    dy + ay + ShiftY,
                    AttackEffectSurface, 1);
      end;
   if BoUseDieEffect then
      if DieEffectSurface <> nil then begin
         DrawBlend (dsurface,
                    dx + bx + ShiftX,
                    dy + by + ShiftY,
                    DieEffectSurface, 1);
      end;
end;



{-----------------------------------------------------------}

function  TFireCowFaceMon.Light: integer;
var
   l: integer;
begin
   l := ChrLight;
   if l < 2 then begin
      if BoUseEffect then
         l := 2;
   end;
   Result := l;
end;

function  TCowFaceKing.Light: integer;
var
   l: integer;
begin
   l := ChrLight;
   if l < 2 then begin
      if BoUseEffect then
         l := 2;
   end;
   Result := l;
end;


{-----------------------------------------------------------}

//procedure TZombiLighting.Run;


{-----------------------------------------------------------}


procedure TSculptureMon.CalcActorFrame;
var
   pm: PTMonsterAction;
   haircount: integer;
begin
   currentframe := -1;

   BodyOffset := GetOffset (Appearance);
   pm := RaceByPM (Race);
   if pm = nil then exit;
   BoUseEffect := FALSE;

   case CurrentAction of
      SM_TURN:
         begin
            if (State and STATE_STONE_MODE) <> 0 then begin
               if (Race = 48) or (Race = 49) then
                  startframe := pm.ActDeath.start // + Dir * (pm.ActDeath.frame + pm.ActDeath.skip)
               else
                  startframe := pm.ActDeath.start + Dir * (pm.ActDeath.frame + pm.ActDeath.skip);
               endframe := startframe;
               frametime := pm.ActDeath.ftime;
               starttime := GetTickCount;
               defframecount := pm.ActDeath.frame;
            end else begin
               startframe := pm.ActStand.start + Dir * (pm.ActStand.frame + pm.ActStand.skip);
               endframe := startframe + pm.ActStand.frame - 1;
               frametime := pm.ActStand.ftime;
               starttime := GetTickCount;
               defframecount := pm.ActStand.frame;
            end;
            Shift (Dir, 0, 0, 1);
         end;
      SM_WALK, SM_BACKSTEP:
         begin
            startframe := pm.ActWalk.start + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
            endframe := startframe + pm.ActWalk.frame - 1;
            frametime := pm.ActWalk.ftime;
            starttime := GetTickCount;
            maxtick := pm.ActWalk.UseTick;
            curtick := 0;
            //WarMode := FALSE;
            movestep := 1;
            if CurrentAction = SM_WALK then
               Shift (Dir, movestep, 0, endframe-startframe+1)
            else  //sm_backstep
               Shift (GetBack(Dir), movestep, 0, endframe-startframe+1);
         end;
      SM_DIGUP: //걷기 없음, SM_DIGUP, 방향 없음.
         begin
            if (Race = 48) or (Race = 49) then begin
               startframe := pm.ActDeath.start;
            end else begin
               startframe := pm.ActDeath.start + Dir * (pm.ActDeath.frame + pm.ActDeath.skip);
            end;
            endframe := startframe + pm.ActDeath.frame - 1;
            frametime := pm.ActDeath.ftime;
            starttime := GetTickCount;
            //WarMode := FALSE;
            Shift (Dir, 0, 0, 1);
         end;
      SM_HIT:
         begin
            startframe := pm.ActAttack.start + Dir * (pm.ActAttack.frame + pm.ActAttack.skip);
            endframe := startframe + pm.ActAttack.frame - 1;
            frametime := pm.ActAttack.ftime;
            starttime := GetTickCount;
            if Race = 49 then begin
               BoUseEffect := TRUE;
               firedir := Dir;
               effectframe := 0; //startframe;
               effectstart := 0; //startframe;
               effectend := effectstart + 8;
               effectstarttime := GetTickCount;
               effectframetime := frametime;
            end;
            Shift (Dir, 0, 0, 1);
         end;
      SM_STRUCK:
         begin
            startframe := pm.ActStruck.start + Dir * (pm.ActStruck.frame + pm.ActStruck.skip);
            endframe := startframe + pm.ActStruck.frame - 1;
            frametime := struckframetime; //pm.ActStruck.ftime;
            starttime := GetTickCount;
         end;
      SM_DEATH:
         begin
            startframe := pm.ActDie.start + Dir * (pm.ActDie.frame + pm.ActDie.skip);
            endframe := startframe + pm.ActDie.frame - 1;
            startframe := endframe; //
            frametime := pm.ActDie.ftime;
            starttime := GetTickCount;
         end;
      SM_NOWDEATH:
         begin
            startframe := pm.ActDie.start + Dir * (pm.ActDie.frame + pm.ActDie.skip);
            endframe := startframe + pm.ActDie.frame - 1;
            frametime := pm.ActDie.ftime;
            starttime := GetTickCount;
         end;
   end;
end;

procedure  TSculptureMon.LoadSurface;
begin
   inherited LoadSurface;
   case Race of
      48, 49:
         begin
            if BoUseEffect then
               AttackEffectSurface := FrmMain.WMon7Img.GetCachedImage (
                        SCULPTUREFIREBASE + (firedir * 10) + effectframe-effectstart, //
                        ax, ay);
         end;
   end;
end;

function  TSculptureMon.GetDefaultFrame (wmode: Boolean): integer;
var
   cf, dr: integer;
   pm: PTMonsterAction;
begin
   pm := RaceByPM (Race);
   if pm = nil then exit;

   if Death then begin
      Result := pm.ActDie.start + Dir * (pm.ActDie.frame + pm.ActDie.skip) + (pm.ActDie.frame - 1);
   end else begin
      if (State and STATE_STONE_MODE) <> 0 then begin
         case Race of
            47: Result := pm.ActDeath.start + Dir * (pm.ActDeath.frame + pm.ActDeath.skip);
            48, 49: Result := pm.ActDeath.start;
         end;
      end else begin
         defframecount := pm.ActStand.frame;
         if currentdefframe < 0 then cf := 0
         else if currentdefframe >= pm.ActStand.frame then cf := 0
         else cf := currentdefframe;
         Result := pm.ActStand.start + Dir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
      end;
   end;
end;

procedure TSculptureMon.DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer);
var
   idx: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
begin
   if BoUseEffect then
      if AttackEffectSurface <> nil then begin
         DrawBlend (dsurface,
                    dx + ax + ShiftX,
                    dy + ay + ShiftY,
                    AttackEffectSurface, 1);
      end;
end;

procedure TSculptureMon.Run;
var
   effectframetimetime, frametimetime: longword;
begin
   if (CurrentAction = SM_WALK) or (CurrentAction = SM_BACKSTEP) or (CurrentAction = SM_RUN) then exit;
   if BoUseEffect then begin
      effectframetimetime := effectframetime;
      if GetTickCount - effectstarttime > effectframetimetime then begin
         effectstarttime := GetTickCount;
         if effectframe < effectend then begin
            Inc (effectframe);
         end else begin
            BoUseEffect := FALSE;
         end;
      end;
   end;
   inherited Run;
end;


end.
