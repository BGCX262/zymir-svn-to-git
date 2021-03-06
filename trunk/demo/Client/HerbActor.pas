unit HerbActor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grobal2, DxDraws, CliUtil, magiceff, Actor, WIl;


const
   BEEQUEENBASE = 600;
   DOORDEATHEFFECTBASE = 120;
   WALLLEFTBROKENEFFECTBASE = 224;
   WALLRIGHTBROKENEFFECTBASE = 240;

type
   TDoorState = (dsOpen, dsClose, dsBroken);

   TKillingHerb = class (TActor)
   private
   public
      constructor Create; override;
      destructor Destroy; override;
      procedure CalcActorFrame; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
   end;

   TBeeQueen = class (TActor)
   private
   public
      procedure CalcActorFrame; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
   end;

   TCentipedeKingMon = class (TKillingHerb)
   public
      procedure CalcActorFrame; override;
   end;

   TCastleDoor = class (TActor)
   private
      EffectSurface: TDirectDrawSurface;
      ax, ay: integer;
      oldunitx, oldunity: integer;
      procedure ApplyDoorState (dstate: TDoorState);
   public
      BoDoorOpen: Boolean;
      constructor Create; override;
      procedure CalcActorFrame; override;
      procedure  LoadSurface; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
      procedure  ActionEnded; override;
      procedure  Run; override;
      procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean); override;
   end;

   TWallStructure = class (TActor)
   private
      EffectSurface: TDirectDrawSurface;
      BrokenSurface: TDirectDrawSurface;
      ax, ay, bx, by: integer;
      deathframe: integer;
      bomarkpos: Boolean;  //못가게 막고 있는지
   public
      constructor Create; override;
      procedure CalcActorFrame; override;
      procedure  LoadSurface; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
      procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean); override;
      procedure  Run; override;
   end;


implementation

uses
   ClMain;


{============================== TKillingHerb =============================}

//        식인초

{--------------------------}


constructor TKillingHerb.Create;
begin
   inherited Create;
end;

destructor TKillingHerb.Destroy;
begin
   inherited Destroy;
end;

procedure TKillingHerb.CalcActorFrame;
var
   pm: PTMonsterAction;
   haircount: integer;
begin
   BoUseMagic := FALSE;
   currentframe := -1;

   BodyOffset := GetOffset (Appearance);
   pm := RaceByPM (Race);
   if pm = nil then exit;

   case CurrentAction of
      SM_TURN: //방향이 없음...
         begin
            startframe := pm.ActStand.start; // + Dir * (pm.ActStand.frame + pm.ActStand.skip);
            endframe := startframe + pm.ActStand.frame - 1;
            frametime := pm.ActStand.ftime;
            starttime := GetTickCount;
            defframecount := pm.ActStand.frame;
            Shift (Dir, 0, 0, 1);
         end;
      SM_DIGUP: //걷기 없음, SM_DIGUP, 방향 없음.
         begin
            startframe := pm.ActWalk.start; // + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
            endframe := startframe + pm.ActWalk.frame - 1;
            frametime := pm.ActWalk.ftime;
            starttime := GetTickCount;
            maxtick := pm.ActWalk.UseTick;
            curtick := 0;
            //WarMode := FALSE;
            movestep := 1;
            Shift (Dir, 0, 0, 1); //movestep, 0, endframe-startframe+1);
         end;
      SM_HIT:
         begin
            startframe := pm.ActAttack.start + Dir * (pm.ActAttack.frame + pm.ActAttack.skip);
            endframe := startframe + pm.ActAttack.frame - 1;
            frametime := pm.ActAttack.ftime;
            starttime := GetTickCount;
            //WarMode := TRUE;
            WarModeTime := GetTickCount;
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
      SM_DIGDOWN:
         begin
            startframe := pm.ActDeath.start;
            endframe := startframe + pm.ActDeath.frame - 1;
            frametime := pm.ActDeath.ftime;
            starttime := GetTickCount;
            BoDelActionAfterFinished := TRUE;  //이동작이 끝나면 액터 지음
         end;
   end;
end;


function  TKillingHerb.GetDefaultFrame (wmode: Boolean): integer;
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
      Result := pm.ActStand.start + cf; //방향이 없음..
   end;
end;


{----------------------------------------------------------------------}
//비막원충


procedure TBeeQueen.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
   BoUseMagic := FALSE;
   currentframe := -1;

   BodyOffset := GetOffset (Appearance);
   pm := RaceByPM (Race);
   if pm = nil then exit;

   case CurrentAction of
      SM_TURN: //방향이 없음...
         begin
            startframe := pm.ActStand.start; // + Dir * (pm.ActStand.frame + pm.ActStand.skip);
            endframe := startframe + pm.ActStand.frame - 1;
            frametime := pm.ActStand.ftime;
            starttime := GetTickCount;
            defframecount := pm.ActStand.frame;
            Shift (Dir, 0, 0, 1);
         end;
      SM_HIT:
         begin
            startframe := pm.ActAttack.start; // + Dir * (pm.ActAttack.frame + pm.ActAttack.skip);
            endframe := startframe + pm.ActAttack.frame - 1;
            frametime := pm.ActAttack.ftime;
            starttime := GetTickCount;
            //WarMode := TRUE;
            WarModeTime := GetTickCount;
            Shift (Dir, 0, 0, 1);
         end;
      SM_STRUCK:
         begin
            startframe := pm.ActStruck.start; // + Dir * (pm.ActStruck.frame + pm.ActStruck.skip);
            endframe := startframe + pm.ActStruck.frame - 1;
            frametime := struckframetime; //pm.ActStruck.ftime;
            starttime := GetTickCount;
         end;
      SM_DEATH:
         begin
            startframe := pm.ActDie.start; // + Dir * (pm.ActDie.frame + pm.ActDie.skip);
            endframe := startframe + pm.ActDie.frame - 1;
            startframe := endframe; //
            frametime := pm.ActDie.ftime;
            starttime := GetTickCount;
         end;
      SM_NOWDEATH:
         begin
            startframe := pm.ActDie.start; // + Dir * (pm.ActDie.frame + pm.ActDie.skip);
            endframe := startframe + pm.ActDie.frame - 1;
            frametime := pm.ActDie.ftime;
            starttime := GetTickCount;
         end;
   end;
end;

function  TBeeQueen.GetDefaultFrame (wmode: Boolean): integer;
var
   pm: PTMonsterAction;
   cf: integer;
begin
   pm := RaceByPM (Race);
   if pm = nil then exit;

   if Death then begin
      Result := pm.ActDie.start + (pm.ActDie.frame - 1);
   end else begin
      defframecount := pm.ActStand.frame;
      if currentdefframe < 0 then cf := 0
      else if currentdefframe >= pm.ActStand.frame then cf := 0
      else cf := currentdefframe;
      Result := pm.ActStand.start + cf; //방향이 없음..
   end;
end;


{----------------------------------------------------------------------}
//지네왕


procedure TCentipedeKingMon.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
   BoUseMagic := FALSE;
   currentframe := -1;

   BodyOffset := GetOffset (Appearance);
   pm := RaceByPM (Race);
   if pm = nil then exit;

   case CurrentAction of
      SM_TURN: //방향이 없음...
         begin
            Dir := 0;
            inherited CalcActorFrame;
         end;
      SM_HIT:
         begin
            case Dir of
               7, 6: Dir := 0;
               0, 1, 2, 5: Dir := 1;
               else Dir := 2;
            end;    
            inherited CalcActorFrame;
         end;
      //SM_SPITPOISON:
      //   begin
      //   end;
      else begin
         Dir := 0;
         inherited CalcActorFrame;
      end;
   end;
end;


{----------------------------------------------------------------------}
//성벽, 성문

constructor TCastleDoor.Create;
begin
   inherited Create;
   Dir := 0;
   EffectSurface := nil;
   DownDrawLevel := 1;  //1셀 먼저 그림. (사람 머리가 성문 밑으로 들어가는 것을 막음)
end;

procedure TCastleDoor.ApplyDoorState (dstate: TDoorState);
var
   bowalk: Boolean;
begin
   Map.MarkCanWalk (XX, YY-2, TRUE);
   Map.MarkCanWalk (XX+1, YY-1, TRUE);
   Map.MarkCanWalk (XX+1, YY-2, TRUE);
   if dstate = dsClose then bowalk := FALSE
   else bowalk := TRUE;

   Map.MarkCanWalk (XX, YY, bowalk);
   Map.MarkCanWalk (XX, YY-1, bowalk);
   Map.MarkCanWalk (XX, YY-2, bowalk);
   Map.MarkCanWalk (XX+1, YY-1, bowalk);
   Map.MarkCanWalk (XX+1, YY-2, bowalk);
   Map.MarkCanWalk (XX-1, YY-1, bowalk);
   Map.MarkCanWalk (XX-1, YY, bowalk);
   Map.MarkCanWalk (XX-1, YY+1, bowalk);
   Map.MarkCanWalk (XX-2, YY, bowalk);

   if dstate = dsOpen then begin
      Map.MarkCanWalk (XX, YY-2, FALSE);
      Map.MarkCanWalk (XX+1, YY-1, FALSE);
      Map.MarkCanWalk (XX+1, YY-2, FALSE);
   end;
end;

procedure  TCastleDoor.LoadSurface;
var
   mimg: TWMImages;
begin
   inherited LoadSurface;
   mimg := GetMonImg (Appearance);
   if BoUseEffect then
      EffectSurface := mimg.GetCachedImage (DOORDEATHEFFECTBASE + (currentframe - startframe), ax, ay);
end;

procedure TCastleDoor.CalcActorFrame;
var
   pm: PTMonsterAction;
   haircount: integer;
begin
   BoUseEffect := FALSE;
   currentframe := -1;

   BodyOffset := GetOffset (Appearance);
   pm := RaceByPM (Race);
   if pm = nil then exit;
   UserName := ' ';

   case CurrentAction of
      SM_NOWDEATH:
         begin
            startframe := pm.ActDie.start;
            endframe := startframe + pm.ActDie.frame - 1;
            frametime := pm.ActDie.ftime;
            starttime := GetTickCount;
            Shift (Dir, 0, 0, 1);
            BoUseEffect := TRUE;
            ApplyDoorState (dsBroken);  //움직일 수 있게
         end;
      SM_STRUCK:
         begin
            startframe := pm.ActStruck.start + Dir * (pm.ActStruck.frame + pm.ActStruck.skip);
            endframe := startframe + pm.ActStruck.frame - 1;
            frametime := pm.ActStand.ftime;
            starttime := GetTickCount;
            Shift (Dir, 0, 0, 1);
         end;
      SM_DIGUP:  //문 열림
         begin
            startframe := pm.ActAttack.start;
            endframe := startframe + pm.ActAttack.frame - 1;
            frametime := pm.ActAttack.ftime;
            starttime := GetTickCount;
            ApplyDoorState (dsOpen);  //움직일 수 있게
         end;
      SM_DIGDOWN:  //문 닫힘
         begin
            startframe := pm.ActCritical.start;
            endframe := startframe + pm.ActCritical.frame - 1;
            frametime := pm.ActCritical.ftime;
            starttime := GetTickCount;
            BoDoorOpen := FALSE;
            BoHoldPlace := TRUE;
            ApplyDoorState (dsClose);  //못움직임
         end;
      SM_DEATH:
         begin
            startframe := pm.ActDie.start + pm.ActDie.frame - 1;
            endframe := startframe;
            defframecount := 0;
            ApplyDoorState (dsBroken);  //움직일 수 있게
         end;
      else  //방향이 없음...
         begin
            if Dir < 3 then begin
               startframe := pm.ActStand.start + Dir * (pm.ActStand.frame + pm.ActStand.skip);
               endframe := startframe; // + pm.ActStand.frame - 1;
               frametime := pm.ActStand.ftime;
               starttime := GetTickCount;
               defframecount := 0; //pm.ActStand.frame;
               Shift (Dir, 0, 0, 1);
               BoDoorOpen := FALSE;
               BoHoldPlace := TRUE;
               ApplyDoorState (dsClose);  //못움직이게
            end else begin
               startframe := pm.ActCritical.start;  //열려있는 상태
               endframe := startframe;
               defframecount := 0;

               BoDoorOpen := TRUE;
               BoHoldPlace := FALSE;
               ApplyDoorState (dsOpen);  //걸을 수 있음
            end;
         end;
   end;
end;

function  TCastleDoor.GetDefaultFrame (wmode: Boolean): integer;
var
   pm: PTMonsterAction;
begin
   BodyOffset := GetOffset (Appearance);
   pm := RaceByPM (Race);
   if pm = nil then exit;
   if Death then begin
      Result := pm.ActDie.start + pm.ActDie.frame - 1;
      DownDrawLevel := 2;
   end else begin
      if BoDoorOpen then begin
         DownDrawLevel := 2;
         Result := pm.ActCritical.start; // + Dir * (pm.ActStand.frame + pm.ActStand.skip);
      end else begin
         DownDrawLevel := 1;
         Result := pm.ActStand.start + Dir * (pm.ActStand.frame + pm.ActStand.skip);
      end;
   end;
end;

procedure  TCastleDoor.ActionEnded;
begin
   if CurrentAction = SM_DIGUP then begin  //문열림
      BoDoorOpen := TRUE;
      BoHoldPlace := FALSE;
   end;
//   if CurrentAction = SM_DIGDOWN then
//      DefaultMotion;
end;

procedure  TCastleDoor.Run;
begin
   if (Map.CurUnitX <> oldunitx) or (Map.CurUnitY <> oldunity) then begin
      if Death then ApplyDoorState (dsBroken)
      else if BoDoorOpen then ApplyDoorState (dsOpen)
      else ApplyDoorState (dsClose);
   end;
   oldunitx := Map.CurUnitX;
   oldunity := Map.CurUnitY;
   inherited Run;
end;

procedure  TCastleDoor.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean);
begin
   inherited DrawChr (dsurface, dx, dy, blend);
   if BoUseEffect and not blend then
      if EffectSurface <> nil then begin
         DrawBlend (dsurface,
                    dx + ax + ShiftX,
                    dy + ay + ShiftY,
                    EffectSurface, 1);
      end;
end;



{----------------------------------------------------------------------}
//성벽


constructor TWallStructure.Create;
begin
   inherited Create;
   Dir := 0;
   EffectSurface := nil;
   BrokenSurface := nil;
   bomarkpos := FALSE;
   //DownDrawLevel := 1;
end;

procedure TWallStructure.CalcActorFrame;
var
   pm: PTMonsterAction;
   haircount: integer;
begin
   BoUseEffect := FALSE;
   currentframe := -1;

   BodyOffset := GetOffset (Appearance);
   pm := RaceByPM (Race);
   if pm = nil then exit;
   UserName := ' ';
   deathframe := 0;
   BoUseEffect := FALSE;

   case CurrentAction of
      SM_NOWDEATH:
         begin
            startframe := pm.ActDie.start;
            endframe := startframe + pm.ActDie.frame - 1;
            frametime := pm.ActDie.ftime;
            starttime := GetTickCount;
            deathframe := pm.ActStand.start + Dir;
            Shift (Dir, 0, 0, 1);
            BoUseEffect := TRUE;
         end;
      SM_DEATH:
         begin
            startframe := pm.ActDie.start + pm.ActDie.frame - 1;
            endframe := startframe;
            defframecount := 0;
         end;
      SM_DIGUP:  //모습이 변경될때 마다
         begin
            startframe := pm.ActDie.start;
            endframe := startframe + pm.ActDie.frame - 1;
            frametime := pm.ActDie.ftime;
            starttime := GetTickCount;
            deathframe := pm.ActStand.start + Dir;
            BoUseEffect := TRUE;
         end;
      else  //방향이 없음...
         begin
            startframe := pm.ActStand.start + Dir; // * (pm.ActStand.frame + pm.ActStand.skip);
            endframe := startframe; // + pm.ActStand.frame - 1;
            frametime := pm.ActStand.ftime;
            starttime := GetTickCount;
            defframecount := 0; //pm.ActStand.frame;
            Shift (Dir, 0, 0, 1);
            BoHoldPlace := TRUE;
         end;
   end;
end;

procedure  TWallStructure.LoadSurface;
var
   mimg: TWMImages;
begin
   mimg := GetMonImg (Appearance);
   if deathframe > 0 then begin //(CurrentAction = SM_NOWDEATH) or (CurrentAction = SM_DEATH) then begin
      BodySurface := mimg.GetCachedImage (GetOffset (Appearance) + deathframe, px, py);
   end else begin
      inherited LoadSurface;
   end;
   BrokenSurface := mimg.GetCachedImage (GetOffset (Appearance) + 8 + Dir, bx, by);

   if BoUseEffect then begin
      if Appearance = 901 then
         EffectSurface := mimg.GetCachedImage (WALLLEFTBROKENEFFECTBASE + (currentframe - startframe), ax, ay)
      else
         EffectSurface := mimg.GetCachedImage (WALLRIGHTBROKENEFFECTBASE + (currentframe - startframe), ax, ay);
   end;
end;

function  TWallStructure.GetDefaultFrame (wmode: Boolean): integer;
var
   pm: PTMonsterAction;
begin
   BodyOffset := GetOffset (Appearance);
   pm := RaceByPM (Race);
   if pm = nil then exit;
    Result := pm.ActStand.start + Dir; // * (pm.ActStand.frame + pm.ActStand.skip);
end;

procedure TWallStructure.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean);
begin
   inherited DrawChr (dsurface, dx, dy, blend);
   if (BrokenSurface <> nil) and (not blend) then begin
      dsurface.Draw (dx + bx + ShiftX,
                     dy + by + ShiftY,
                     BrokenSurface.ClientRect,
                     BrokenSurface, TRUE);
   end;
   if BoUseEffect and (not blend) then begin
      if EffectSurface <> nil then begin
         DrawBlend (dsurface,
                    dx + ax + ShiftX,
                    dy + ay + ShiftY,
                    EffectSurface, 1);
      end;
   end;
end;

procedure  TWallStructure.Run;
begin
   if Death then begin
      if bomarkpos then begin
         Map.MarkCanWalk (XX, YY, TRUE);
         bomarkpos := FALSE;
      end;
   end else begin
      if not bomarkpos then begin
         Map.MarkCanWalk (XX, YY, FALSE);
         bomarkpos := TRUE;
      end;
   end;
   PlayScene.SetActorDrawLevel (self, 0);
   inherited Run;
end;


end.
