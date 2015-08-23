//CHECK
//��Ҫɾ����һ��ע�ͣ���ע��Ϊ�����ļ��Ƿ��ѱ��Զ������쳣����
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

   TKillingHerb = class (TActor)//Size 0x250
   private
   public
      constructor Create; override;
      destructor Destroy; override;
      procedure CalcActorFrame; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
   end;

   TMineMon = class (TKillingHerb)
   private
   public
      constructor Create; override;
      procedure CalcActorFrame; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
   end;

   TBeeQueen = class (TActor)
   private
   public
      procedure CalcActorFrame; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
   end;

   TCentipedeKingMon = class (TKillingHerb)//Size 0x260
   private
      AttackEffectSurface :TDirectDrawSurface; //0x250
      BoUseDieEffect      :Boolean;            //0x254
      ax                  :integer;            //0x258
      ay                  :integer;            //0x25C
      procedure LoadEffect();
   public
      procedure CalcActorFrame; override;
      procedure LoadSurface; override;
      procedure DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer);override;
      procedure Run;override;
   end;
   TBigHeartMon = class (TKillingHerb)//Size 0x260
   private
   public
     procedure CalcActorFrame; override;
   end;
   TSpiderHouseMon = class (TKillingHerb)
   private
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
      procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
   end;

   TWallStructure = class (TActor)//0x62
   private
      EffectSurface: TDirectDrawSurface;
      BrokenSurface: TDirectDrawSurface;
      ax, ay, bx, by: integer;
      deathframe: integer;
      bomarkpos: Boolean;  //������ ���� �ִ���
   public
      constructor Create; override;
      procedure CalcActorFrame; override;
      procedure  LoadSurface; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
      procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
      procedure  Run; override;
   end;

   TSoccerBall = class (TActor)//0x9
   private
   public
   end;
   TDragonBody = class (TKillingHerb)//0x5a
   private
   public
     procedure DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
     procedure CalcActorFrame(); override;
     procedure LoadSurface(); override;
   end;
implementation

uses
   ClMain, MShare;


{============================== TKillingHerb =============================}

//        ������

{--------------------------}


constructor TKillingHerb.Create;
begin
Try //�����Զ�����
   inherited Create;
Except //�����Զ�����
  DebugOutStr('[Exception] TKillingHerb.Create'); //�����Զ�����
End; //�����Զ�����
end;

destructor TKillingHerb.Destroy;
begin
Try //�����Զ�����
   inherited Destroy;
Except //�����Զ�����
  DebugOutStr('[Exception] TKillingHerb.Destroy'); //�����Զ�����
End; //�����Զ�����
end;

procedure TKillingHerb.CalcActorFrame;
var
   pm: PTMonsterAction;
   haircount: integer;
begin
Try //�����Զ�����
   m_boUseMagic := FALSE;
   m_nCurrentFrame := -1;

   m_nBodyOffset := GetOffset (m_wAppearance);
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;

   case m_nCurrentAction of
      SM_TURN: //
         begin
            m_nStartFrame := pm.ActStand.start; // + Dir * (pm.ActStand.frame + pm.ActStand.skip);
            m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
            m_dwFrameTime := pm.ActStand.ftime;
            m_dwStartTime := GetTickCount;
            m_nDefFrameCount := pm.ActStand.frame;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_DIGUP: //, SM_DIGUP, .
         begin
            m_nStartFrame := pm.ActWalk.start; // + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
            m_nEndFrame := m_nStartFrame + pm.ActWalk.frame - 1;
            m_dwFrameTime := pm.ActWalk.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := pm.ActWalk.UseTick;
            m_nCurTick := 0;
            //WarMode := FALSE;
            m_nMoveStep := 1;
            Shift (m_btDir, 0, 0, 1); //m_nMoveStep, 0, m_nEndFrame-startframe+1);
         end;
      SM_HIT:
         begin
            m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
            m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
            m_dwFrameTime := pm.ActAttack.ftime;
            m_dwStartTime := GetTickCount;
            //WarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_STRUCK:
         begin
            m_nStartFrame := pm.ActStruck.start + m_btDir * (pm.ActStruck.frame + pm.ActStruck.skip);
            m_nEndFrame := m_nStartFrame + pm.ActStruck.frame - 1;
            m_dwFrameTime := m_dwStruckFrameTime; //pm.ActStruck.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_DEATH:
         begin
            m_nStartFrame := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip);
            m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
            m_nStartFrame := m_nEndFrame; //
            m_dwFrameTime := pm.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_NOWDEATH:
         begin
            m_nStartFrame := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip);
            m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
            m_dwFrameTime := pm.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_DIGDOWN:
         begin
            m_nStartFrame := pm.ActDeath.start;
            m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
            m_dwFrameTime := pm.ActDeath.ftime;
            m_dwStartTime := GetTickCount;
            m_boDelActionAfterFinished := TRUE;  //�̵����� ������ ���� ����
         end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TKillingHerb.CalcActorFrame'); //�����Զ�����
End; //�����Զ�����
end;


function  TKillingHerb.GetDefaultFrame (wmode: Boolean): integer;
var
   cf, dr: integer;
   pm: PTMonsterAction;
begin
Try //�����Զ�����
   Result:=0;//jacky
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;

   if m_boDeath then begin
      if m_boSkeleton then
         Result := pm.ActDeath.start
      else Result := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip) + (pm.ActDie.frame - 1);
   end else begin
      m_nDefFrameCount := pm.ActStand.frame;
      if m_nCurrentDefFrame < 0 then cf := 0
      else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
      else cf := m_nCurrentDefFrame;
      Result := pm.ActStand.start + cf; //������ ����..
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TKillingHerb.GetDefaultFrame'); //�����Զ�����
End; //�����Զ�����
end;


{----------------------------------------------------------------------}
//�񸷿���


procedure TBeeQueen.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
Try //�����Զ�����
   m_boUseMagic := FALSE;
   m_nCurrentFrame := -1;

   m_nBodyOffset := GetOffset (m_wAppearance);
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;

   case m_nCurrentAction of
      SM_TURN: //������ ����...
         begin
            m_nStartFrame := pm.ActStand.start; // + Dir * (pm.ActStand.frame + pm.ActStand.skip);
            m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
            m_dwFrameTime := pm.ActStand.ftime;
            m_dwStartTime := GetTickCount;
            m_nDefFrameCount := pm.ActStand.frame;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_HIT:
         begin
            m_nStartFrame := pm.ActAttack.start; // + Dir * (pm.ActAttack.frame + pm.ActAttack.skip);
            m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
            m_dwFrameTime := pm.ActAttack.ftime;
            m_dwStartTime := GetTickCount;
            //WarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_STRUCK:
         begin
            m_nStartFrame := pm.ActStruck.start; // + Dir * (pm.ActStruck.frame + pm.ActStruck.skip);
            m_nEndFrame := m_nStartFrame + pm.ActStruck.frame - 1;
            m_dwFrameTime := m_dwStruckFrameTime; //pm.ActStruck.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_DEATH:
         begin
            m_nStartFrame := pm.ActDie.start; // + Dir * (pm.ActDie.frame + pm.ActDie.skip);
            m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
            m_nStartFrame := m_nEndFrame; //
            m_dwFrameTime := pm.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_NOWDEATH:
         begin
            m_nStartFrame := pm.ActDie.start; // + Dir * (pm.ActDie.frame + pm.ActDie.skip);
            m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
            m_dwFrameTime := pm.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TBeeQueen.CalcActorFrame'); //�����Զ�����
End; //�����Զ�����
end;

function  TBeeQueen.GetDefaultFrame (wmode: Boolean): integer;
var
   pm: PTMonsterAction;
   cf: integer;
begin
Try //�����Զ�����
   Result:=0;//jacky
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;

   if m_boDeath then begin
      Result := pm.ActDie.start + (pm.ActDie.frame - 1);
   end else begin
      m_nDefFrameCount := pm.ActStand.frame;
      if m_nCurrentDefFrame < 0 then cf := 0
      else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
      else cf := m_nCurrentDefFrame;
      Result := pm.ActStand.start + cf; //������ ����..
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TBeeQueen.GetDefaultFrame'); //�����Զ�����
End; //�����Զ�����
end;


{----------------------------------------------------------------------}
//���׿�


procedure TCentipedeKingMon.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
Try //�����Զ�����
   m_boUseMagic := FALSE;
   m_nCurrentFrame := -1;
   m_nBodyOffset := GetOffset(m_wAppearance);
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;

   case m_nCurrentAction of
      SM_TURN: //
         begin
            m_btDir := 0;
            inherited CalcActorFrame;
         end;
      SM_HIT:
         begin
            m_btDir:=0;
            m_nStartFrame:=pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
            m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
            m_dwFrameTime:=pm.ActCritical.ftime;
            m_dwStartTime := GetTickCount;
            BoUseDieEffect:=True;
            m_nEffectFrame:=0;
            m_nEffectStart:=0;
            m_nEffectEnd:=m_nEffectStart + 9;
            m_dwEffectFrameTime:= 62;
//            BoUseEffect:=True;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_DIGDOWN:
         begin
           inherited CalcActorFrame;
         end;
      else begin
         m_btDir := 0;
         inherited CalcActorFrame;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TCentipedeKingMon.CalcActorFrame'); //�����Զ�����
End; //�����Զ�����
end;


{----------------------------------------------------------------------}
//����, ����

constructor TCastleDoor.Create;
begin
Try //�����Զ�����
   inherited Create;
   m_btDir := 0;
   EffectSurface := nil;
   m_nDownDrawLevel := 1;  //1�� ���� �׸�. (��� �Ӹ��� ���� ������ ���� ���� ����)
Except //�����Զ�����
  DebugOutStr('[Exception] TCastleDoor.Create'); //�����Զ�����
End; //�����Զ�����
end;

procedure TCastleDoor.ApplyDoorState (dstate: TDoorState);
var
   bowalk: Boolean;
begin
Try //�����Զ�����
   Map.MarkCanWalk (m_nCurrX, m_nCurrY-2, TRUE);
   Map.MarkCanWalk (m_nCurrX+1, m_nCurrY-1, TRUE);
   Map.MarkCanWalk (m_nCurrX+1, m_nCurrY-2, TRUE);
   if dstate = dsClose then bowalk := FALSE
   else bowalk := TRUE;

   Map.MarkCanWalk (m_nCurrX, m_nCurrY, bowalk);
   Map.MarkCanWalk (m_nCurrX, m_nCurrY-1, bowalk);
   Map.MarkCanWalk (m_nCurrX, m_nCurrY-2, bowalk);
   Map.MarkCanWalk (m_nCurrX+1, m_nCurrY-1, bowalk);
   Map.MarkCanWalk (m_nCurrX+1, m_nCurrY-2, bowalk);
   Map.MarkCanWalk (m_nCurrX-1, m_nCurrY-1, bowalk);
   Map.MarkCanWalk (m_nCurrX-1, m_nCurrY, bowalk);
   Map.MarkCanWalk (m_nCurrX-1, m_nCurrY+1, bowalk);
   Map.MarkCanWalk (m_nCurrX-2, m_nCurrY, bowalk);

   if dstate = dsOpen then begin
      Map.MarkCanWalk (m_nCurrX, m_nCurrY-2, FALSE);
      Map.MarkCanWalk (m_nCurrX+1, m_nCurrY-1, FALSE);
      Map.MarkCanWalk (m_nCurrX+1, m_nCurrY-2, FALSE);
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TCastleDoor.ApplyDoorState'); //�����Զ�����
End; //�����Զ�����
end;

procedure  TCastleDoor.LoadSurface;
var
   mimg: TWMImages;
begin
Try //�����Զ�����
   inherited LoadSurface;
   mimg := GetMonImg (m_wAppearance);
   if m_boUseEffect then
      EffectSurface := mimg.GetCachedImage (DOORDEATHEFFECTBASE + (m_nCurrentFrame - m_nStartFrame), ax, ay);
Except //�����Զ�����
  DebugOutStr('[Exception] TCastleDoor.LoadSurface'); //�����Զ�����
End; //�����Զ�����
end;

procedure TCastleDoor.CalcActorFrame;
var
   pm: PTMonsterAction;
   haircount: integer;
begin
Try //�����Զ�����
   m_boUseEffect := FALSE;
   m_nCurrentFrame := -1;

   m_nBodyOffset := GetOffset (m_wAppearance);
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;
   m_sUserName := ' ';

   case m_nCurrentAction of
      SM_NOWDEATH:
         begin
            m_nStartFrame := pm.ActDie.start;
            m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
            m_dwFrameTime := pm.ActDie.ftime;
            m_dwStartTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
            m_boUseEffect := TRUE;
            ApplyDoorState (dsBroken);  //������ �� �ְ�
         end;
      SM_STRUCK:
         begin
            m_nStartFrame := pm.ActStruck.start + m_btDir * (pm.ActStruck.frame + pm.ActStruck.skip);
            m_nEndFrame := m_nStartFrame + pm.ActStruck.frame - 1;
            m_dwFrameTime := pm.ActStand.ftime;
            m_dwStartTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_DIGUP:  //�� ����
         begin
            m_nStartFrame := pm.ActAttack.start;
            m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
            m_dwFrameTime := pm.ActAttack.ftime;
            m_dwStartTime := GetTickCount;
            ApplyDoorState (dsOpen);  //������ �� �ְ�
         end;
      SM_DIGDOWN:  //�� ����
         begin
            m_nStartFrame := pm.ActCritical.start;
            m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
            m_dwFrameTime := pm.ActCritical.ftime;
            m_dwStartTime := GetTickCount;
            BoDoorOpen := FALSE;
            m_boHoldPlace := TRUE;
            ApplyDoorState (dsClose);  //��������
         end;
      SM_DEATH:
         begin
            m_nStartFrame := pm.ActDie.start + pm.ActDie.frame - 1;
            m_nEndFrame := m_nStartFrame;
            m_nDefFrameCount := 0;
            ApplyDoorState (dsBroken);  //������ �� �ְ�
         end;
      else  //������ ����...
         begin
            if m_btDir < 3 then begin
               m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
               m_nEndFrame := m_nStartFrame; // + pm.ActStand.frame - 1;
               m_dwFrameTime := pm.ActStand.ftime;
               m_dwStartTime := GetTickCount;
               m_nDefFrameCount := 0; //pm.ActStand.frame;
               Shift (m_btDir, 0, 0, 1);
               BoDoorOpen := FALSE;
               m_boHoldPlace := TRUE;
               ApplyDoorState (dsClose);  //�������̰�
            end else begin
               m_nStartFrame := pm.ActCritical.start;  //�����ִ� ����
               m_nEndFrame := m_nStartFrame;
               m_nDefFrameCount := 0;

               BoDoorOpen := TRUE;
               m_boHoldPlace := FALSE;
               ApplyDoorState (dsOpen);  //���� �� ����
            end;
         end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TCastleDoor.CalcActorFrame'); //�����Զ�����
End; //�����Զ�����
end;

function  TCastleDoor.GetDefaultFrame (wmode: Boolean): integer;
var
   pm: PTMonsterAction;
begin
Try //�����Զ�����
   Result:=0;//jacky
   m_nBodyOffset := GetOffset (m_wAppearance);
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;
   if m_boDeath then begin
      Result := pm.ActDie.start + pm.ActDie.frame - 1;
      m_nDownDrawLevel := 2;
   end else begin
      if BoDoorOpen then begin
         m_nDownDrawLevel := 2;
         Result := pm.ActCritical.start; // + Dir * (pm.ActStand.frame + pm.ActStand.skip);
      end else begin
         m_nDownDrawLevel := 1;
         Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TCastleDoor.GetDefaultFrame'); //�����Զ�����
End; //�����Զ�����
end;

procedure  TCastleDoor.ActionEnded;
begin
Try //�����Զ�����
   if m_nCurrentAction = SM_DIGUP then begin  //������
      BoDoorOpen := TRUE;
      m_boHoldPlace := FALSE;
   end;
//   if CurrentAction = SM_DIGDOWN then
//      DefaultMotion;
Except //�����Զ�����
  DebugOutStr('[Exception] TCastleDoor.ActionEnded'); //�����Զ�����
End; //�����Զ�����
end;

procedure  TCastleDoor.Run;
begin
Try //�����Զ�����
   if (Map.m_nCurUnitX <> oldunitx) or (Map.m_nCurUnitY <> oldunity) then begin
      if m_boDeath then ApplyDoorState (dsBroken)
      else if BoDoorOpen then ApplyDoorState (dsOpen)
      else ApplyDoorState (dsClose);
   end;
   oldunitx := Map.m_nCurUnitX;
   oldunity := Map.m_nCurUnitY;
   inherited Run;
Except //�����Զ�����
  DebugOutStr('[Exception] TCastleDoor.Run'); //�����Զ�����
End; //�����Զ�����
end;

procedure  TCastleDoor.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean);
begin
Try //�����Զ�����
   inherited DrawChr (dsurface, dx, dy, blend,False);
   if m_boUseEffect and not blend then
      if EffectSurface <> nil then begin
         DrawBlend (dsurface,
                    dx + ax + m_nShiftX,
                    dy + ay + m_nShiftY,
                    EffectSurface, 1);
      end;
Except //�����Զ�����
  DebugOutStr('[Exception] TCastleDoor.DrawChr'); //�����Զ�����
End; //�����Զ�����
end;



{----------------------------------------------------------------------}
//����


constructor TWallStructure.Create;
begin
Try //�����Զ�����
   inherited Create;
   m_btDir := 0;
   EffectSurface := nil;
   BrokenSurface := nil;
   bomarkpos := FALSE;
   //DownDrawLevel := 1;
Except //�����Զ�����
  DebugOutStr('[Exception] TWallStructure.Create'); //�����Զ�����
End; //�����Զ�����
end;

procedure TWallStructure.CalcActorFrame;
var
   pm: PTMonsterAction;
   haircount: integer;
begin
Try //�����Զ�����
   m_boUseEffect := FALSE;
   m_nCurrentFrame := -1;

   m_nBodyOffset := GetOffset (m_wAppearance);
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;
   m_sUserName := ' ';
   deathframe := 0;
   m_boUseEffect := FALSE;

   case m_nCurrentAction of
      SM_NOWDEATH:
         begin
            m_nStartFrame := pm.ActDie.start;
            m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
            m_dwFrameTime := pm.ActDie.ftime;
            m_dwStartTime := GetTickCount;
            deathframe := pm.ActStand.start + m_btDir;
            Shift (m_btDir, 0, 0, 1);
            m_boUseEffect := TRUE;
         end;
      SM_DEATH:
         begin
            m_nStartFrame := pm.ActDie.start + pm.ActDie.frame - 1;
            m_nEndFrame := m_nStartFrame;
            m_nDefFrameCount := 0;
         end;
      SM_DIGUP:  //����� ����ɶ� ����
         begin
            m_nStartFrame := pm.ActDie.start;
            m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
            m_dwFrameTime := pm.ActDie.ftime;
            m_dwStartTime := GetTickCount;
            deathframe := pm.ActStand.start + m_btDir;
            m_boUseEffect := TRUE;
         end;
      else  //������ ����...
         begin
            m_nStartFrame := pm.ActStand.start + m_btDir; // * (pm.ActStand.frame + pm.ActStand.skip);
            m_nEndFrame := m_nStartFrame; // + pm.ActStand.frame - 1;
            m_dwFrameTime := pm.ActStand.ftime;
            m_dwStartTime := GetTickCount;
            m_nDefFrameCount := 0; //pm.ActStand.frame;
            Shift (m_btDir, 0, 0, 1);
            m_boHoldPlace := TRUE;
         end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TWallStructure.CalcActorFrame'); //�����Զ�����
End; //�����Զ�����
end;

procedure  TWallStructure.LoadSurface;
var
   mimg: TWMImages;
begin
Try //�����Զ�����
   mimg := GetMonImg (m_wAppearance);
   if deathframe > 0 then begin //(CurrentAction = SM_NOWDEATH) or (CurrentAction = SM_DEATH) then begin
      m_BodySurface := mimg.GetCachedImage (GetOffset (m_wAppearance) + deathframe, m_nPx, m_nPy);
   end else begin
      inherited LoadSurface;
   end;
   BrokenSurface := mimg.GetCachedImage (GetOffset (m_wAppearance) + 8 + m_btDir, bx, by);

   if m_boUseEffect then begin
      if m_wAppearance = 901 then
         EffectSurface := mimg.GetCachedImage (WALLLEFTBROKENEFFECTBASE + (m_nCurrentFrame - m_nStartFrame), ax, ay)
      else
         EffectSurface := mimg.GetCachedImage (WALLRIGHTBROKENEFFECTBASE + (m_nCurrentFrame - m_nStartFrame), ax, ay);
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TWallStructure.LoadSurface'); //�����Զ�����
End; //�����Զ�����
end;

function  TWallStructure.GetDefaultFrame (wmode: Boolean): integer;
var
   pm: PTMonsterAction;
begin
Try //�����Զ�����
   Result:=0;//jacky
   m_nBodyOffset := GetOffset (m_wAppearance);
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;
    Result := pm.ActStand.start + m_btDir; // * (pm.ActStand.frame + pm.ActStand.skip);
Except //�����Զ�����
  DebugOutStr('[Exception] TWallStructure.GetDefaultFrame'); //�����Զ�����
End; //�����Զ�����
end;

procedure TWallStructure.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean);
begin
Try //�����Զ�����
   inherited DrawChr (dsurface, dx, dy, blend,boFlag);
   if (BrokenSurface <> nil) and (not blend) then begin
      dsurface.Draw (dx + bx + m_nShiftX,
                     dy + by + m_nShiftY,
                     BrokenSurface.ClientRect,
                     BrokenSurface, TRUE);
   end;
   if m_boUseEffect and (not blend) then begin
      if EffectSurface <> nil then begin
         DrawBlend (dsurface,
                    dx + ax + m_nShiftX,
                    dy + ay + m_nShiftY,
                    EffectSurface, 1);
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TWallStructure.DrawChr'); //�����Զ�����
End; //�����Զ�����
end;

procedure  TWallStructure.Run;
begin
Try //�����Զ�����
   if m_boDeath then begin
      if bomarkpos then begin
         Map.MarkCanWalk (m_nCurrX, m_nCurrY, TRUE);
         bomarkpos := FALSE;
      end;
   end else begin
      if not bomarkpos then begin
         Map.MarkCanWalk (m_nCurrX, m_nCurrY, FALSE);
         bomarkpos := TRUE;
      end;
   end;
   PlayScene.SetActorDrawLevel (self, 0);
   inherited Run;
Except //�����Զ�����
  DebugOutStr('[Exception] TWallStructure.Run'); //�����Զ�����
End; //�����Զ�����
end;


{ TMineMon }

procedure TMineMon.CalcActorFrame;
begin
Try //�����Զ�����
  inherited;

Except //�����Զ�����
  DebugOutStr('[Exception] TMineMon.CalcActorFrame'); //�����Զ�����
End; //�����Զ�����
end;

constructor TMineMon.Create;
begin
Try //�����Զ�����
  inherited;

Except //�����Զ�����
  DebugOutStr('[Exception] TMineMon.Create'); //�����Զ�����
End; //�����Զ�����
end;




procedure TCentipedeKingMon.DrawEff(dsurface: TDirectDrawSurface; dx,
  dy: integer);
var
   idx: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
begin
Try //�����Զ�����
 if m_boUseEffect then
  if AttackEffectSurface <> nil then
    DrawBlend (dsurface,dx + ax + m_nShiftX,dy + ay + m_nShiftY,AttackEffectSurface, 1);

Except //�����Զ�����
  DebugOutStr('[Exception] TCentipedeKingMon.DrawEff'); //�����Զ�����
End; //�����Զ�����
end;

procedure TCentipedeKingMon.LoadEffect;
begin
Try //�����Զ�����
  if m_boUseEffect then
    AttackEffectSurface := GetMonEx(15-1).GetCachedImage (
                        100 + m_nEffectFrame-m_nEffectStart, //������ ó�� �������� �ʰ� ������.
                        ax, ay);
Except //�����Զ�����
  DebugOutStr('[Exception] TCentipedeKingMon.LoadEffect'); //�����Զ�����
End; //�����Զ�����
end;

procedure TCentipedeKingMon.LoadSurface;
begin
Try //�����Զ�����
   inherited LoadSurface;
   LoadEffect();
Except //�����Զ�����
  DebugOutStr('[Exception] TCentipedeKingMon.LoadSurface'); //�����Զ�����
End; //�����Զ�����
end;

function TMineMon.GetDefaultFrame(wmode: Boolean): integer;
begin
Try //�����Զ�����

Except //�����Զ�����
  DebugOutStr('[Exception] TMineMon.GetDefaultFrame'); //�����Զ�����
End; //�����Զ�����
end;

{ TBigHeartMon }

procedure TBigHeartMon.CalcActorFrame;
begin
Try //�����Զ�����
  m_btDir:=0;
  inherited CalcActorFrame;
Except //�����Զ�����
  DebugOutStr('[Exception] TBigHeartMon.CalcActorFrame'); //�����Զ�����
End; //�����Զ�����
end;

{ TSpiderHouseMon }

procedure TSpiderHouseMon.CalcActorFrame;
begin
Try //�����Զ�����
  m_btDir:=0;
  inherited CalcActorFrame;
Except //�����Զ�����
  DebugOutStr('[Exception] TSpiderHouseMon.CalcActorFrame'); //�����Զ�����
End; //�����Զ�����
end;

procedure TCentipedeKingMon.Run;
begin
Try //�����Զ�����
   if (m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_BACKSTEP) or
      (m_nCurrentAction = SM_HORSERUN) or
      (m_nCurrentAction = SM_RUN)
   then exit;
   if BoUseDieEffect then begin
     if (m_nCurrentFrame - m_nStartFrame) >= 5 then begin
       BoUseDieEffect:=False;
       m_boUseEffect:=True;
       m_dwEffectStartTime:=GetTickCount();
       m_nEffectFrame:=0;
       LoadEffect();
     end;
   end;
   if m_boUseEffect then begin
     if (GetTickCount - m_dwEffectStartTime) > m_dwEffectFrameTime then begin
       m_dwEffectStartTime:=GetTickCount();
       if m_nEffectFrame < m_nEffectEnd then begin
         Inc(m_nEffectFrame);
         LoadEffect();
       end else m_boUseEffect:=False;
     end;
   end;
  inherited;
Except //�����Զ�����
  DebugOutStr('[Exception] TCentipedeKingMon.Run'); //�����Զ�����
End; //�����Զ�����
end;

{ TDragonBody }

procedure TDragonBody.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
Try //�����Զ�����
  m_btDir:=0;
  m_boUseMagic:=False;
  m_nCurrentFrame:= -1;
  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;
  if m_nCurrentAction = SM_DIGUP then begin
    m_nMaxTick:=pm.ActWalk.ftime;
    m_nCurTick:=0;
    m_nMoveStep:=1;
    Shift (m_btDir, 0, 0, 1);
  end;
  m_nStartFrame:=0;
  m_nEndFrame:=1;
  m_dwFrameTime:=400;
  m_dwStartTime:=GetTickCount();
Except //�����Զ�����
  DebugOutStr('[Exception] TDragonBody.CalcActorFrame'); //�����Զ�����
End; //�����Զ�����
end;

procedure TDragonBody.DrawEff(dsurface: TDirectDrawSurface; dx,
  dy: integer);
//0x0046C3C0
begin
Try //�����Զ�����
   if not (m_btDir in [0..7]) then exit;
   if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface; //bodysurface���� loadsurface�� �ٽ� �θ��� �ʾ� �޸𸮰� �����Ǵ� ���� ����
   end;
    if m_BodySurface <> nil then
      DrawBlend (dsurface,dx + m_nPx + m_nShiftX,dy + m_nPy + m_nShiftY,m_BodySurface, 1);

Except //�����Զ�����
  DebugOutStr('[Exception] TDragonBody.DrawEff'); //�����Զ�����
End; //�����Զ�����
end;

procedure TDragonBody.LoadSurface;
begin
Try //�����Զ�����
  m_BodySurface := g_WDragonImages.GetCachedImage(GetOffset(m_wAppearance),m_nPx,m_nHpy);
Except //�����Զ�����
  DebugOutStr('[Exception] TDragonBody.LoadSurface'); //�����Զ�����
End; //�����Զ�����
end;

end.
