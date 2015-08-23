unit PlayScn;
//ÓÎÏ·Ö÷³¡¾°
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXDraws, DXClass, DirectX, IntroScn, Grobal2, CliUtil, HUtil32,
  Actor, HerbActor, AxeMon, SoundUtil, ClEvent, Wil,
  StdCtrls, clFunc, magiceff, extctrls;


const
   MAPSURFACEWIDTH = 800;
   MAPSURFACEHEIGHT = 445;
   LONGHEIGHT_IMAGE = 35;
   FLASHBASE = 410;
   AAX = 16;
   SOFFX = 0;
   SOFFY = 0;
   LMX = 30;
   LMY = 26;

   SCREENWIDTH = 800;
   SCREENHEIGHT = 600;

   MAXLIGHT = 5;
   LightFiles : array[0..MAXLIGHT] of string = (
      'Data\lig0a.dat',
      'Data\lig0b.dat',
      'Data\lig0c.dat',
      'Data\lig0d.dat',
      'Data\lig0e.dat',
      'Data\lig0f.dat'
   );

   LightMask0 : array[0..2, 0..2] of shortint = (
      (0,1,0),
      (1,3,1),
      (0,1,0)
   );
   LightMask1 : array[0..4, 0..4] of shortint = (
      (0,1,1,1,0),
      (1,1,3,1,1),
      (1,3,4,3,1),
      (1,1,3,1,1),
      (0,1,2,1,0)
   );
   LightMask2 : array[0..8, 0..8] of shortint = (
      (0,0,0,1,1,1,0,0,0),
      (0,0,1,2,3,2,1,0,0),
      (0,1,2,3,4,3,2,1,0),
      (1,2,3,4,4,4,3,2,1),
      (1,3,4,4,4,4,4,3,1),
      (1,2,3,4,4,4,3,2,1),
      (0,1,2,3,4,3,2,1,0),
      (0,0,1,2,3,2,1,0,0),
      (0,0,0,1,1,1,0,0,0)
   );
   LightMask3 : array[0..10, 0..10] of shortint = (
      (0,0,0,0,1,1,1,0,0,0,0),
      (0,0,0,1,2,2,2,1,0,0,0),
      (0,0,1,2,3,3,3,2,1,0,0),
      (0,1,2,3,4,4,4,3,2,1,0),
      (1,2,3,4,4,4,4,4,3,2,1),
      (2,3,4,4,4,4,4,4,4,3,2),
      (1,2,3,4,4,4,4,4,3,2,1),
      (0,1,2,3,4,4,4,3,2,1,0),
      (0,0,1,2,3,3,3,2,1,0,0),
      (0,0,0,1,2,2,2,1,0,0,0),
      (0,0,0,0,1,1,1,0,0,0,0)
   );

   LightMask4 : array[0..14, 0..14] of shortint = (
      (0,0,0,0,0,0,1,1,1,0,0,0,0,0,0),
      (0,0,0,0,0,1,1,1,1,1,0,0,0,0,0),
      (0,0,0,0,1,1,2,2,2,1,1,0,0,0,0),
      (0,0,0,1,1,2,3,3,3,2,1,1,0,0,0),
      (0,0,1,1,2,3,4,4,4,3,2,1,1,0,0),
      (0,1,1,2,3,4,4,4,4,4,3,2,1,1,0),
      (1,1,2,3,4,4,4,4,4,4,4,3,2,1,1),
      (1,2,3,4,4,4,4,4,4,4,4,4,3,2,1),
      (1,1,2,3,4,4,4,4,4,4,4,3,2,1,1),
      (0,1,1,2,3,4,4,4,4,4,3,2,1,1,0),
      (0,0,1,1,2,3,4,4,4,3,2,1,1,0,0),
      (0,0,0,1,1,2,3,3,3,2,1,1,0,0,0),
      (0,0,0,0,1,1,2,2,2,1,1,0,0,0,0),
      (0,0,0,0,0,1,1,1,1,1,0,0,0,0,0),
      (0,0,0,0,0,0,1,1,1,0,0,0,0,0,0)
   );

   LightMask5 : array[0..16, 0..16] of shortint = (
      (0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0),
      (0,0,0,0,0,0,1,2,2,2,1,0,0,0,0,0,0),
      (0,0,0,0,0,1,2,4,4,4,2,1,0,0,0,0,0),
      (0,0,0,0,1,2,4,4,4,4,4,2,1,0,0,0,0),
      (0,0,0,1,2,4,4,4,4,4,4,4,2,1,0,0,0),
      (0,0,1,2,4,4,4,4,4,4,4,4,4,2,1,0,0),
      (0,1,2,4,4,4,4,4,4,4,4,4,4,4,2,1,0),
      (1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1),
      (1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1),
      (1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1),
      (0,1,2,4,4,4,4,4,4,4,4,4,4,4,2,1,0),
      (0,0,1,2,4,4,4,4,4,4,4,4,4,2,1,0,0),
      (0,0,0,1,2,4,4,4,4,4,4,4,2,1,0,0,0),
      (0,0,0,0,1,2,4,4,4,4,4,2,1,0,0,0,0),
      (0,0,0,0,0,1,2,4,4,4,2,1,0,0,0,0,0),
      (0,0,0,0,0,0,1,2,2,2,1,0,0,0,0,0,0),
      (0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0));

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
      light:  integer;
      bright: integer;
   end;

   TPlayScene = class (TScene)
   private
      MapSurface: TDirectDrawSurface;
      ObjSurface: TDirectDrawSurface;
      FogScreen: array[0..MAPSURFACEHEIGHT, 0..MAPSURFACEWIDTH] of byte;
      PFogScreen: PByte;
      FogWidth, FogHeight: integer;
      Lights: array[0..MAXLIGHT] of TLightEffect;
      MoveTime: longword;
      MoveStepCount: integer;
      AniTime: longword;
      AniCount: integer;
      DefXX, DefYY: integer;
      MainSoundTimer: TTimer;

      MsgList: TList;
      LightMap: array[0..LMX, 0..LMY] of TLightMapInfo;
      procedure DrawTileMap;
      procedure LoadFog;
      procedure ClearLightMap;
      procedure AddLight (x, y, shiftx, shifty, light: integer; nocheck: Boolean);
      procedure UpdateBright (x, y, light: integer);
      function  CheckOverLight (x, y, light: integer): Boolean;
      procedure ApplyLightMap;
      procedure DrawLightEffect (lx, ly, bright: integer);
      procedure EdChatKeyPress (Sender: TObject; var Key: Char);
      procedure SoundOnTimer (Sender: TObject);
   public
      EdChat: TEdit;
      ActorList,  TempList: TList;
      GroundEffectList: TList;  //¹Ù´Ú¿¡ ±ò¸®´Â ¸¶¹ý ¸®½ºÆ®
      EffectList: TList; //¸¶¹ýÈ¿°ú ¸®½ºÆ®
      FlyList: TList;  //³¯¾Æ´Ù´Ï´Â °Í (´øÁøµµ³¢, Ã¢, È­»ì)
      BlinkTime: Longword;
      ViewBlink: Boolean;
      constructor Create;
      destructor Destroy; override;
      procedure Initialize; override;
      procedure Finalize; override;
      procedure OpenScene; override;
      procedure CloseScene; override;
      procedure OpeningScene; override;
      procedure DrawMiniMap (surface: TDirectDrawSurface);
      procedure PlayScene (MSurface: TDirectDrawSurface); override;
      function  ButchAnimal (x, y: integer): TActor;

      function  FindActor (id: integer): TActor;
      function  FindActorXY (x, y: integer): TActor;
      function  IsValidActor (actor: TActor): Boolean;
      function  NewActor (chrid: integer; cx, cy, cdir: word; cfeature, cstate: integer): TActor;
      procedure ActorDied (actor: TObject); //Á×Àº actor´Â ¸Ç À§·Î
      procedure SetActorDrawLevel (actor: TObject; level: integer);
      procedure ClearActors;
      function  DeleteActor (id: integer): TActor;
      procedure DelActor (actor: TObject);
      procedure SendMsg (ident, chrid, x, y, cdir, feature, state: integer; str: string);

      procedure NewMagic (aowner: TActor;
                          magid, magnumb, cx, cy, tx, ty, targetcode: integer;
                          mtype: TMagicType;
                          Recusion: Boolean;
                          anitime: integer;
                          var bofly: Boolean);
      procedure DelMagic (magid: integer);
      function  NewFlyObject (aowner: TActor; cx, cy, tx, ty, targetcode: integer;  mtype: TMagicType): TMagicEff;
      //function  NewStaticMagic (aowner: TActor; tx, ty, targetcode, effnum: integer);

      procedure ScreenXYfromMCXY (cx, cy: integer; var sx, sy: integer);
      procedure CXYfromMouseXY (mx, my: integer; var ccx, ccy: integer);
      function  GetCharacter (x, y, wantsel: integer; var nowsel: integer; liveonly: Boolean): TActor;
      function  GetAttackFocusCharacter (x, y, wantsel: integer; var nowsel: integer; liveonly: Boolean): TActor;
      function  IsSelectMyself (x, y: integer): Boolean;
      function  GetDropItems (x, y: integer; var inames: string): PTDropItem;
      function  CanRun (sx, sy, ex, ey: integer): Boolean;
      function  CanWalk (mx, my: integer): Boolean;
      function  CrashMan (mx, my: integer): Boolean; //»ç¶÷³¢¸® °ãÄ¡´Â°¡?
      function  CanFly (mx, my: integer): Boolean;
      procedure RefreshScene;
      procedure CleanObjects;
   end;


implementation

uses
   ClMain, FState;


constructor TPlayScene.Create;
begin
   MapSurface := nil;
   ObjSurface := nil;
   MsgList := TList.Create;            //ÏûÏ¢ÁÐ±í
   ActorList := TList.Create;          //½ÇÉ«ÁÐ±í
   TempList := TList.Create;
   GroundEffectList := TList.Create;
   EffectList := TList.Create;
   FlyList := TList.Create;
   BlinkTime := GetTickCount;
   ViewBlink := FALSE;
   //ÁÄÌìÐÅÏ¢ÊäÈë¿ò
   EdChat := TEdit.Create (FrmMain.Owner);
   with EdChat do begin
      Parent := FrmMain;
      BorderStyle := bsNone;
      OnKeyPress := EdChatKeyPress;
      Visible := FALSE;
      MaxLength := 70;
      Ctl3D := FALSE;
      Left   := 208;
      Top    := SCREENHEIGHT - 19;
      Height := 12;
      Width  := 387;
      Color := clSilver;
   end;
   MoveTime := GetTickCount;
   AniTime := GetTickCount;
   AniCount := 0;
   MoveStepCount := 0;
   MainSoundTimer := TTimer.Create (FrmMain.Owner);
   with MainSoundTimer do begin
      OnTimer := SoundOnTimer;
      Interval := 1;
      Enabled := FALSE;
   end;
end;

destructor TPlayScene.Destroy;
begin
   MsgList.Free;
   ActorList.Free;  
   TempList.Free;
   GroundEffectList.Free;
   EffectList.Free;
   FlyList.Free;
   inherited Destroy;
end;

//ÓÎÏ·Ö÷³¡¾°µÄ±³¾°ÒôÀÖ£¨³¤¶È£º43Ãë£©
procedure TPlayScene.SoundOnTimer (Sender: TObject);
begin
   PlaySound (s_main_theme);
   MainSoundTimer.Interval := 46 * 1000;
end;
//ÁÄÌìÐÅÏ¢ÊäÈë
procedure TPlayScene.EdChatKeyPress (Sender: TObject; var Key: Char);
begin
   if Key = #13 then begin
      FrmMain.SendSay (EdChat.Text);
      EdChat.Text := '';
      EdChat.Visible := FALSE;
      Key := #0;
   end;
   if Key = #27 then begin
      EdChat.Text := '';
      EdChat.Visible := FALSE;
      Key := #0;
   end;
end;
//³õÊ¼»¯³¡¾°
procedure TPlayScene.Initialize;
var
   i: integer;
begin
   //µØÍ¼
   MapSurface := TDirectDrawSurface.Create (FrmMain.DXDraw1.DDraw);
   MapSurface.SystemMemory := TRUE;
   MapSurface.SetSize (MAPSURFACEWIDTH+UNITX*4+30, MAPSURFACEHEIGHT+UNITY*4);
   //ÎïÆ·
   ObjSurface := TDirectDrawSurface.Create (FrmMain.DXDraw1.DDraw);
   ObjSurface.SystemMemory := TRUE;
   ObjSurface.SetSize (MAPSURFACEWIDTH-SOFFX*2, MAPSURFACEHEIGHT);
   //Îí
   FogWidth := MAPSURFACEWIDTH - SOFFX * 2;
   FogHeight := MAPSURFACEHEIGHT;
   PFogScreen := @FogScreen;
   ZeroMemory (PFogScreen, MAPSURFACEHEIGHT * MAPSURFACEWIDTH);

   ViewFog := FALSE;
   for i:=0 to MAXLIGHT do
      Lights[i].PFog := nil;
   LoadFog;
end;

procedure TPlayScene.Finalize;
begin
   if MapSurface <> nil then
      MapSurface.Free;
   if ObjSurface <> nil then
      ObjSurface.Free;
   MapSurface := nil;
   ObjSurface := nil;
end;
//³¡¾°¿ªÊ¼
procedure TPlayScene.OpenScene;
begin
   FrmMain.WProgUse.ClearCache;  //·Î±×ÀÎ ÀÌ¹ÌÁö Ä³½Ã¸¦ Áö¿î´Ù.
   FrmDlg.ViewBottomBox (TRUE);

   SetImeMode (FrmMain.Handle, LocalLanguage);
   MainSoundTimer.Interval := 1000;
   MainSoundTimer.Enabled := TRUE;
end;
//¹Ø±Õ³¡¾°
procedure TPlayScene.CloseScene;
begin
   MainSoundTimer.Enabled := FALSE;
   SilenceSound;

   EdChat.Visible := FALSE;
   FrmDlg.ViewBottomBox (FALSE);
end;

procedure TPlayScene.OpeningScene;
begin
end;
//Ë¢ÐÂ³¡¾°(ÓÎÏ·½ÇÉ«£©
procedure TPlayScene.RefreshScene;
var
   i: integer;
begin
   Map.OldClientRect.Left := -1;
   for i:=0 to ActorList.Count-1 do
      TActor (ActorList[i]).LoadSurface;
end;

procedure TPlayScene.CleanObjects; //¸ÊÀ» ¿Å±è, ÀÚ½Å »©°í ÃÊ±âÈ­
var
   i: integer;
begin
   //É¾³ýËùÓÐ·Çµ±Ç°Íæ¼Ò½ÇÉ«
   for i := ActorList.Count-1 downto 0 do begin
      if TActor(ActorList[i]) <> Myself then begin
         TActor(ActorList[i]).Free;
         ActorList.Delete (i);
      end;
   end;
   MsgList.Clear;
   TargetCret := nil;
   FocusCret := nil;
   MagicTarget := nil;
   //Çå³ýÄ§·¨Ð§¹û
   for i:=0 to GroundEffectList.Count-1 do
      TMagicEff (GroundEffectList[i]).Free;
   GroundEffectList.Clear;
   for i:=0 to EffectList.Count-1 do
      TMagicEff (EffectList[i]).Free;
   EffectList.Clear;
end;

{---------------------- Draw Map -----------------------}
//»­µØÍ¼
procedure TPlayScene.DrawTileMap;
var
   i,j, m,n, imgnum:integer;
   DSurface: TDirectDrawSurface;
begin
   with Map do
      if (ClientRect.Left = OldClientRect.Left)
         and (ClientRect.Top = OldClientRect.Top) then
           exit;
   Map.OldClientRect := Map.ClientRect;
   MapSurface.Fill(0);
   //»­µØÃæ
   with Map.ClientRect do begin
      m := -UNITY*2;
      for j:=(Top - Map.BlockTop-1) to (Bottom - Map.BlockTop+1) do begin
         n := AAX + 14 -UNITX;
         for i:=(Left - Map.BlockLeft-2) to (Right - Map.BlockLeft+1) do begin
            if (i >= 0) and (i < LOGICALMAPUNIT*3) and (j >= 0) and (j < LOGICALMAPUNIT*3) then begin
               imgnum := (Map.MArr[i, j].BkImg and $7FFF);
               if imgnum > 0 then begin
                  if (i mod 2 = 0) and (j mod 2 = 0) then
                  begin
                     imgnum := imgnum - 1;
                     DSurface := FrmMain.WTiles.Images[imgnum];
                     if Dsurface <> nil then
                        MapSurface.Draw (n, m, DSurface.ClientRect, DSurface, FALSE);
                  end;
               end;
            end;
            Inc (n, UNITX);
         end;
         Inc (m, UNITY);
      end;
   end;
   //»­µØÃæÉÏµÄÎïÌå
   with Map.ClientRect do begin
      m := -UNITY;
      for j:=(Top - Map.BlockTop-1) to (Bottom - Map.BlockTop+1) do begin
         n := AAX + 14 -UNITX;
         for i:=(Left - Map.BlockLeft-2) to (Right - Map.BlockLeft+1) do begin
            if (i >= 0) and (i < LOGICALMAPUNIT*3) and (j >= 0) and (j < LOGICALMAPUNIT*3) then begin
               imgnum := Map.MArr[i, j].MidImg;
               if imgnum > 0 then begin
                  imgnum := imgnum - 1;
                  DSurface := FrmMain.WSmTiles.Images[imgnum];
                  if Dsurface <> nil then
                     MapSurface.Draw (n, m, DSurface.ClientRect, DSurface, TRUE);
               end;
            end;
            Inc (n, UNITX);
         end;
         Inc (m, UNITY);
      end;
   end;

end;

{----------------------- Æ÷±×, ¶óÀÌÆ® Ã³¸® -----------------------}
//´ÓÎÄ¼þÖÐ×°ÔØÎí
procedure TPlayScene.LoadFog;  //¶óÀÌÆ® µ¥ÀÌÅ¸ ÀÐ±â
var
   i, fhandle, w, h, prevsize: integer;
   cheat: Boolean;
begin
   prevsize := 0; //Á¶ÀÛ Ã¼Å©
   cheat := FALSE;
   for i:=0 to MAXLIGHT do begin
      if FileExists (LightFiles[i]) then begin
         fhandle := FileOpen (LightFiles[i], fmOpenRead or fmShareDenyNone);
         FileRead (fhandle, w, sizeof(integer));
         FileRead (fhandle, h, sizeof(integer));
         Lights[i].Width := w;
         Lights[i].Height := h;
         Lights[i].PFog := AllocMem  (w * h + 8);
         if prevsize < w * h then begin
            FileRead (fhandle, Lights[i].PFog^, w*h);
         end else
            cheat := TRUE;
         prevsize := w * h;
         FileClose (fhandle);
      end;
   end;
   if cheat then
      for i:=0 to MAXLIGHT do begin
         if Lights[i].PFog <> nil then
            FillChar (Lights[i].PFog^, Lights[i].Width*Lights[i].Height+8, #0);
      end;
end;
//
procedure TPlayScene.ClearLightMap;
var
   i, j: integer;
begin
   FillChar (LightMap, (LMX+1)*(LMY+1)*sizeof(TLightMapInfo), 0);
   for i:=0 to LMX do
      for j:=0 to LMY do
         LightMap[i, j].Light := -1;
end;

procedure TPlayScene.UpdateBright (x, y, light: integer);
var
   i, j, r, lx, ly: integer;
   pmask: ^ShortInt;
begin
   r := -1;
   case light of
      0: begin r := 2; pmask := @LightMask0; end;
      1: begin r := 4; pmask := @LightMask1; end;
      2: begin r := 8; pmask := @LightMask2; end;
      3: begin r := 10; pmask := @LightMask3; end;
      4: begin r := 14; pmask := @LightMask4; end;
      5: begin r := 16; pmask := @LightMask5; end;
   end;
   for i:=0 to r do
      for j:=0 to r do begin
         lx := x-(r div 2)+i;
         ly := y-(r div 2)+j;
         if (lx in [0..LMX]) and (ly in [0..LMY]) then
            LightMap[lx, ly].bright := LightMap[lx, ly].bright + PShoftInt(integer(pmask) + (i*(r+1) + j) * sizeof(shortint))^;
      end;
end;

function  TPlayScene.CheckOverLight (x, y, light: integer): Boolean;
var
   i, j, r, mlight, lx, ly, count, check: integer;
   pmask: ^ShortInt;
begin
   r := -1;
   case light of
      0: begin r := 2; pmask := @LightMask0; check := 0; end;
      1: begin r := 4; pmask := @LightMask1; check := 4; end;
      2: begin r := 8; pmask := @LightMask2; check := 8; end;
      3: begin r := 10; pmask := @LightMask3; check := 18; end;
      4: begin r := 14; pmask := @LightMask4; check := 30; end;
      5: begin r := 16; pmask := @LightMask5; check := 40; end;
   end;
   count := 0;
   for i:=0 to r do
      for j:=0 to r do begin
         lx := x-(r div 2)+i;
         ly := y-(r div 2)+j;
         if (lx in [0..LMX]) and (ly in [0..LMY]) then begin
            mlight := PShoftInt(integer(pmask) + (i*(r+1) + j) * sizeof(shortint))^;
            if LightMap[lx, ly].bright < mlight then begin
               inc (count, mlight - LightMap[lx, ly].bright);
               if count >= check then begin
                  Result := FALSE;
                  exit;
               end;
            end;
         end;
      end;
   Result := TRUE;
end;

procedure TPlayScene.AddLight (x, y, shiftx, shifty, light: integer; nocheck: Boolean);
var
   lx, ly: integer;
begin
   lx := x - Myself.Rx + LMX div 2;
   ly := y - Myself.Ry + LMY div 2;
   if (lx >= 1) and (lx < LMX) and (ly >= 1) and (ly < LMY) then begin
      if LightMap[lx, ly].light < light then begin
         if not CheckOverLight(lx, ly, light) or nocheck then begin // > LightMap[lx, ly].light then begin
            UpdateBright (lx, ly, light);
            LightMap[lx, ly].light := light;
            LightMap[lx, ly].Shiftx := shiftx;
            LightMap[lx, ly].Shifty := shifty;
         end;
      end;
   end;
end;

procedure TPlayScene.ApplyLightMap;
var
   i, j, light, defx, defy, lx, ly, lxx, lyy, lcount: integer;
begin
   defx := -UNITX*2 + AAX + 14 - Myself.ShiftX;
   defy := -UNITY*3 - Myself.ShiftY;
   lcount := 0;
   for i:=1 to LMX-1 do
      for j:=1 to LMY-1 do begin
         light := LightMap[i, j].light;
         if light >= 0 then begin
            lx := (i + Myself.Rx - LMX div 2);
            ly := (j + Myself.Ry - LMY div 2);
            lxx := (lx-Map.ClientRect.Left)*UNITX + defx + LightMap[i, j].ShiftX;
            lyy := (ly-Map.ClientRect.Top)*UNITY + defy + LightMap[i, j].ShiftY;

            FogCopy (Lights[light].PFog,
                     0,
                     0,
                     Lights[light].Width,
                     Lights[light].Height,
                     PFogScreen,
                     lxx - (Lights[light].Width-UNITX) div 2,
                     lyy - (Lights[light].Height-UNITY) div 2 - 5,
                     FogWidth,
                     FogHeight,
                     20);
            inc (lcount);
         end;
      end;
end;

procedure TPlayScene.DrawLightEffect (lx, ly, bright: integer);
begin
   if (bright > 0) and (bright <= MAXLIGHT) then
      FogCopy (Lights[bright].PFog,
               0,
               0,
               Lights[bright].Width,
               Lights[bright].Height,
               PFogScreen,
               lx - (Lights[bright].Width-UNITX) div 2,
               ly - (Lights[bright].Height-UNITY) div 2,
               FogWidth,
               FogHeight,
               15);
end;

{-----------------------------------------------------------------------}

procedure TPlayScene.DrawMiniMap (surface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   v: Boolean;
   mx, my: integer;
   rc: TRect;
begin
   if GetTickCount > BlinkTime + 300 then begin   //µ±Ç°Íæ¼ÒÔÚÐ¡µØÍ¼ÉÏµÄÎ»ÖÃ£¬Ã¿300ºÁÃëÉÁÒ»´Î
      BlinkTime := GetTickCount;
      ViewBlink := not ViewBlink;
   end;
   d := FrmMain.WMMap.Images[MiniMapIndex];
   if d <> nil then begin
      mx := (Myself.XX*48) div 32;
      my := (Myself.YY*32) div 32;
      rc.Left := _MAX(0, mx-60);
      rc.Top := _MAX(0, my-60);
      rc.Right := _MIN(d.ClientRect.Right, rc.Left + 120);
      rc.Bottom := _MIN(d.ClientRect.Bottom, rc.Top + 120);
      DrawBlendEx (surface, (SCREENWIDTH-120), 0, d, rc.Left, rc.Top, 120, 120, 0);
      //ÏÔÊ¾µ±Ç°½ÇÉ«ËùÔÚµÄÎ»ÖÃ
      if ViewBlink then begin
         mx := (SCREENWIDTH-120) + (Myself.XX*48) div 32 - rc.Left;
         my := (Myself.YY*32) div 32 - rc.Top;
         surface.Pixels[mx, my] := 255;
      end;
   end;
end;


{-----------------------------------------------------------------------}

//»­ÓÎÏ·ÕýÊ½³¡¾°
procedure TPlayScene.PlayScene (MSurface: TDirectDrawSurface);
   //¼ì²émyrcÇøÓòÊÇ·ñÍêÈ«ÔÚobrcÇøÓòÄÚ
   function  CheckOverlappedObject (myrc, obrc: TRect): Boolean;
   begin
      if (obrc.Right > myrc.Left) and (obrc.Left < myrc.Right) and
         (obrc.Bottom > myrc.Top) and (obrc.Top < myrc.Bottom) then
         Result := TRUE
      else Result := FALSE;
   end;

var
   i, j, k, n, m, mmm, ix, iy, line, defx, defy, wunit, fridx, ani, anitick, ax, ay, idx, drawingbottomline: integer;
   DSurface, d: TDirectDrawSurface;
   blend, movetick: Boolean;
   //myrc, obrc: TRect;
   pd: PTDropItem;
   evn: TClEvent;
   actor: TActor;
   meff: TMagicEff;
   msgstr: string;
begin
   //µ±µãÁËLogOutºó£¬×¢Ïú½ÇÉ«£¬·µ»ØÑ¡Ôñ½ÇÉ«»­Ãæ
   if (Myself = nil) then begin
      msgstr := 'ÕýÔÚ×¢Ïú£¬ÇëÉÒºó......';
      with MSurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         BoldTextOut (MSurface, (SCREENWIDTH-TextWidth(msgstr)) div 2, 200,
                      clWhite, clBlack, msgstr);
         Release;
      end;
      exit;
   end;
   //¹Ø±Õ¿ìËÙµ­³öÄ£Ê½
   DoFastFadeOut := FALSE;

   //200ºÁÃëMoveStepCount¹éÁã
   movetick := FALSE;
   if GetTickCount - MoveTime >= 100 then begin
      MoveTime := GetTickCount;   //ÀÌµ¿ÀÇ µ¿±âÈ­
      movetick := TRUE;          //ÀÌµ¿ Æ½
      Inc (MoveStepCount);
      if MoveStepCount > 1 then MoveStepCount := 0;
   end;
   //50X100000ºÁÃëAniCount¹éÁã
   if GetTickCount - AniTime >= 50 then begin
      AniTime := GetTickCount;
      Inc (AniCount);
      if AniCount > 100000 then AniCount := 0;
   end;
   //ÔË¶¯ÎïÌåµÄÒÆ¶¯¼ÆËã
   try
   i := 0;                          //½ÇÉ«±àºÅ
   while TRUE do begin              //Frame 
      if i >= ActorList.Count then break;
      actor := ActorList[i];
      if movetick then actor.LockEndFrame := FALSE;
      if not actor.LockEndFrame then begin
         actor.ProcMsg;   //´¦Àí½ÇÉ«µÄÏûÏ¢.
         if movetick then
            if actor.Move(MoveStepCount) then begin  //µ¿±âÈ­ÇØ¼­ ¿òÁ÷ÀÓ
               Inc (i);
               continue;
            end;
         actor.Run;    //Ä³¸¯ÅÍµéÀ» ¿òÁ÷ÀÌ°Ô ÇÔ.
         if actor <> Myself then actor.ProcHurryMsg;
      end;
      if actor = Myself then actor.ProcHurryMsg;
      //º¯½ÅÀÎ °æ¿ì
      if actor.WaitForRecogId <> 0 then begin
         if actor.IsIdle then begin
            DelChangeFace (actor.WaitForRecogId);
            NewActor (actor.WaitForRecogId, actor.XX, actor.YY, actor.Dir, actor.WaitForFeature, actor.WaitForStatus);
            actor.WaitForRecogId := 0;
            actor.BoDelActor := TRUE;
         end;
      end;
      if actor.BoDelActor then begin
         //actor.Free;
         FreeActorList.Add (actor);
         ActorList.Delete (i);
         if TargetCret = actor then TargetCret := nil;
         if FocusCret = actor then FocusCret := nil;
         if MagicTarget = actor then MagicTarget := nil;
      end else
         Inc (i);
   end;
   except
      DebugOutStr ('101');
   end;
   //µØÃæÎïÌåÔË¶¯µÄ¼ÆËã
   try
   i := 0;
   while TRUE do begin
      if i >= GroundEffectList.Count then break;
      meff := GroundEffectList[i];
      if meff.Active then begin
         if not meff.Run then begin //¸¶¹ýÈ¿°ú
            meff.Free;
            GroundEffectList.Delete (i);
            continue;
         end;
      end;
      Inc (i);
   end;
   //ÌØÐ§ÎïÌåÔË¶¯ÊôÐÔµÄ¼ÆËã
   i := 0;
   while TRUE do begin
      if i >= EffectList.Count then break;
      meff := EffectList[i];
      if meff.Active then begin
         if not meff.Run then begin //¸¶¹ýÈ¿°ú
            meff.Free;
            EffectList.Delete (i);
            continue;
         end;
      end;
      Inc (i);
   end;
   //·ÉÐÐÎïÌåÔË¶¯µÄ¼ÆËã
   i := 0;
   while TRUE do begin
      if i >= FlyList.Count then break;
      meff := FlyList[i];
      if meff.Active then begin
         if not meff.Run then begin //µµ³¢,È­»ìµî ³¯¾Æ°¡´Â°Í
            meff.Free;
            FlyList.Delete (i);
            continue;
         end;
      end;
      Inc (i);
   end;
   
   EventMan.Execute;
   except
      DebugOutStr ('102');
   end;

   try
   //µøÂäÎïÆ·ÏûÒþ
   for k:=0 to DropedItemList.Count-1 do begin
      pd := PTDropItem (DropedItemList[k]);
      if pd <> nil then begin
         if (Abs(pd.x-Myself.XX) > 30) and (Abs(pd.y-Myself.YY) > 30) then begin
            Dispose (PTDropItem (DropedItemList[k]));
            DropedItemList.Delete (k);
            break;  //ÇÑ¹ø¿¡ ÇÑ°³¾¿..
         end;
      end;
   end;
   //»ç¶óÁø ´ÙÀÌ³ª¹Í¿ÀºêÁ§Æ® °Ë»ç
   for k:=0 to EventMan.EventList.Count-1 do begin
      evn := TClEvent (EventMan.EventList[k]);
      if (Abs(evn.X-Myself.XX) > 30) and (Abs(evn.Y-Myself.YY) > 30) then begin
         evn.Free;
         EventMan.EventList.Delete (k);
         break;  //ÇÑ¹ø¿¡ ÇÑ°³¾¿
      end;
   end;
   except
      DebugOutStr ('103');
   end;
   //¸üÐÂµØÍ¼¿É¼û·¶Î§
   try
   with Map.ClientRect do begin  //µØÍ¼µÄ·¶Î§ÊÇÍæ¼ÒÎªÖÐÐÄ£¬×óÓÒ¸÷9
      Left   := MySelf.Rx - 9;
      Top    := MySelf.Ry - 9;
      Right  := MySelf.Rx + 9;
      Bottom := MySelf.Ry + 8;
   end;
   //×°ÔØµØÍ¼¶¨Òå
   Map.UpdateMapPos (Myself.Rx, Myself.Ry);

   ///////////////////////
   //ViewFog := FALSE;
   ///////////////////////

   if NoDarkness or (Myself.Death) then begin
      ViewFog := FALSE;
   end;

   if ViewFog then begin //Æ÷±×
      ZeroMemory (PFogScreen, MAPSURFACEHEIGHT * MAPSURFACEWIDTH);
      ClearLightMap;
   end;

   drawingbottomline := 450;
   ObjSurface.Fill(0);
   //»­µØÍ¼
   DrawTileMap;

   ObjSurface.Draw (0, 0,
                    Rect(UNITX*3 + Myself.ShiftX,
                         UNITY*2 + Myself.ShiftY,
                         UNITX*3 + Myself.ShiftX + MAPSURFACEWIDTH,
                         UNITY*2 + Myself.ShiftY + MAPSURFACEHEIGHT),
                    MapSurface,
                    FALSE);

   except
      DebugOutStr ('104');
   end;

   defx := -UNITX*2 - Myself.ShiftX + AAX + 14;
   defy := -UNITY*2 - Myself.ShiftY;
   DefXX := defx;
   DefYY := defy;
   //»­µØÃæÉÏµÄÎïÌå£¬Èç·¿ÎÝµÈ
   try
   m := defy - UNITY;
   for j:=(Map.ClientRect.Top - Map.BlockTop) to (Map.ClientRect.Bottom - Map.BlockTop + LONGHEIGHT_IMAGE) do begin
      if j < 0 then begin Inc (m, UNITY); continue; end;
      n := defx-UNITX*2;
      //*** 48*32 ÊÇÒ»¸öÎïÌåÐ¡Í¼Æ¬µÄ´óÐ¡
      for i:=(Map.ClientRect.Left - Map.BlockLeft-2) to (Map.ClientRect.Right - Map.BlockLeft+2) do begin
         if (i >= 0) and (i < LOGICALMAPUNIT*3) and (j >= 0) and (j < LOGICALMAPUNIT*3) then begin
            fridx := (Map.MArr[i, j].FrImg) and $7FFF;
            if fridx > 0 then begin
               ani := Map.MArr[i, j].AniFrame;
               wunit := Map.MArr[i, j].Area;
               if (ani and $80) > 0 then begin
                  blend := TRUE;
                  ani := ani and $7F;
               end;
               if ani > 0 then begin
                  anitick := Map.MArr[i, j].AniTick;
                  fridx := fridx + (AniCount mod (ani + (ani*anitick))) div (1+anitick);
               end;
               if (Map.MArr[i, j].DoorOffset and $80) > 0 then begin //¿­¸²
                  if (Map.MArr[i, j].DoorIndex and $7F) > 0 then  //¹®À¸·Î Ç¥½ÃµÈ °Í¸¸
                     fridx := fridx + (Map.MArr[i, j].DoorOffset and $7F); //¿­¸° ¹®
               end;
               fridx := fridx - 1;
               // È¡Í¼Æ¬
               DSurface := FrmMain.GetObjs (wunit, fridx);
               if DSurface <> nil then begin
                  if (DSurface.Width=48) and (DSurface.Height=32) then begin
                     mmm := m + UNITY - DSurface.Height;
                     if (n+DSurface.Width > 0) and (n <= SCREENWIDTH) and (mmm + DSurface.Height > 0) and (mmm < drawingbottomline) then begin
                        ObjSurface.Draw (n, mmm, DSurface.ClientRect, Dsurface, TRUE)
                     end else begin
                        if mmm < drawingbottomline then begin //ºÒÇÊ¿äÇÏ°Ô ±×¸®´Â °ÍÀ» ÇÇÇÔ
                           ObjSurface.Draw (n, mmm, DSurface.ClientRect, DSurface, TRUE)
                        end;
                     end;
                  end;
               end;
            end;
         end;
         Inc (n, UNITX);
      end;
      Inc (m, UNITY);
   end;

   //»­µØÃæÎïÌåÐ§¹û
   for k:=0 to GroundEffectList.Count-1 do begin
      meff := TMagicEff(GroundEffectList[k]);
      //if j = (meff.Ry - Map.BlockTop) then begin
      meff.DrawEff (ObjSurface);
      if ViewFog then begin
         AddLight (meff.Rx, meff.Ry, 0, 0, meff.light, FALSE);
      end;
   end;

   except
      DebugOutStr ('105');
   end;  

   try
   m := defy - UNITY;
   for j:=(Map.ClientRect.Top - Map.BlockTop) to (Map.ClientRect.Bottom - Map.BlockTop + LONGHEIGHT_IMAGE) do begin
      if j < 0 then begin Inc (m, UNITY); continue; end;
      n := defx-UNITX*2;
      //*** ¹è°æ¿ÀºêÁ§Æ® ±×¸®±â
      for i:=(Map.ClientRect.Left - Map.BlockLeft-2) to (Map.ClientRect.Right - Map.BlockLeft+2) do begin
         if (i >= 0) and (i < LOGICALMAPUNIT*3) and (j >= 0) and (j < LOGICALMAPUNIT*3) then begin
            fridx := (Map.MArr[i, j].FrImg) and $7FFF;
            if fridx > 0 then begin
               blend := FALSE;
               wunit := Map.MArr[i, j].Area;
               //¿¡´Ï¸ÞÀÌ¼Ç
               ani := Map.MArr[i, j].AniFrame;
               if (ani and $80) > 0 then begin
                  blend := TRUE;
                  ani := ani and $7F;
               end;
               if ani > 0 then begin
                  anitick := Map.MArr[i, j].AniTick;
                  fridx := fridx + (AniCount mod (ani + (ani*anitick))) div (1+anitick);
               end;
               if (Map.MArr[i, j].DoorOffset and $80) > 0 then begin //¿­¸²
                  if (Map.MArr[i, j].DoorIndex and $7F) > 0 then  //¹®À¸·Î Ç¥½ÃµÈ °Í¸¸
                     fridx := fridx + (Map.MArr[i, j].DoorOffset and $7F); //¿­¸° ¹®
               end;
               fridx := fridx - 1;
               // ¹°Ã¼ ±×¸²
               if not blend then begin
                  DSurface := FrmMain.GetObjs (wunit, fridx);
                  if DSurface <> nil then begin
                     if (DSurface.Width<>48) or (DSurface.Height<>32) then begin
                        mmm := m + UNITY - DSurface.Height;
                        if (n+DSurface.Width > 0) and (n <= SCREENWIDTH) and (mmm + DSurface.Height > 0) and (mmm < drawingbottomline) then begin
                           ObjSurface.Draw (n, mmm, DSurface.ClientRect, Dsurface, TRUE)
                        end else begin
                           if mmm < drawingbottomline then begin //ºÒÇÊ¿äÇÏ°Ô ±×¸®´Â °ÍÀ» ÇÇÇÔ
                              ObjSurface.Draw (n, mmm, DSurface.ClientRect, DSurface, TRUE)
                           end;
                        end;
                     end;
                  end;
               end else begin
                  DSurface := FrmMain.GetObjsEx (wunit, fridx, ax, ay);
                  if DSurface <> nil then begin
                     mmm := m + ay - 68; //UNITY - DSurface.Height;
                     if (n > 0) and (mmm + DSurface.Height > 0) and (n + Dsurface.Width < SCREENWIDTH) and (mmm < drawingbottomline) then begin
                        DrawBlend (ObjSurface, n+ax-2, mmm, DSurface, 1);
                     end else begin
                        if mmm < drawingbottomline then begin //ºÒÇÊ¿äÇÏ°Ô ±×¸®´Â °ÍÀ» ÇÇÇÔ
                           DrawBlend (ObjSurface, n+ax-2, mmm, DSurface, 1);
                        end;
                     end;
                  end;
               end;
            end;

         end;
         Inc (n, UNITX);
      end;

      if (j <= (Map.ClientRect.Bottom - Map.BlockTop)) and (not BoServerChanging) then begin

         //*** ¹Ù´Ú¿¡ º¯°æµÈ ÈëÀÇ ÈçÀû
         for k:=0 to EventMan.EventList.Count-1 do begin
            evn := TClEvent (EventMan.EventList[k]);
            if j = (evn.Y - Map.BlockTop) then begin
               evn.DrawEvent (ObjSurface,
                              (evn.X-Map.ClientRect.Left)*UNITX + defx,
                              m);
            end;
         end;

         //*** ¹Ù´Ú¿¡ ¶³¾îÁø ¾ÆÀÌÅÛ ±×¸®±â
         for k:=0 to DropedItemList.Count-1 do begin
            pd := PTDropItem (DropedItemList[k]);
            if pd <> nil then begin
               if j = (pd.y - Map.BlockTop) then begin
                  d := FrmMain.WDnItem.Images[pd.Looks];
                  if d <> nil then begin
                     ix := (pd.x-Map.ClientRect.Left)*UNITX+defx + SOFFX; // + actor.ShiftX;
                     iy := m; // + actor.ShiftY;
                     if pd = FocusItem then begin
                        ImgMixSurface.Draw (0, 0, d.ClientRect, d, FALSE);
                        DrawEffect (0, 0, d.Width, d.Height, ImgMixSurface, ceBright);
                        ObjSurface.Draw (ix + HALFX-(d.Width div 2),
                                      iy + HALFY-(d.Height div 2),
                                      d.ClientRect,
                                      ImgMixSurface, TRUE);
                     end else
                        ObjSurface.Draw (ix + HALFX-(d.Width div 2),
                                      iy + HALFY-(d.Height div 2),
                                      d.ClientRect,
                                      d, TRUE);
                  end;
               end;
            end;
         end;
         //*** Ä³¸¯ÅÍ ±×¸®±â
         for k:=0 to ActorList.Count-1 do begin
            actor := ActorList[k];
            if (j = actor.Ry-Map.BlockTop-actor.DownDrawLevel) then begin
               actor.SayX := (actor.Rx-Map.ClientRect.Left)*UNITX + defx + actor.ShiftX + 24;
               if actor.Death then
                  actor.SayY := m + UNITY + actor.ShiftY + 16 - 60  + (actor.DownDrawLevel * UNITY)
               else actor.SayY := m + UNITY + actor.ShiftY + 16 - 95  + (actor.DownDrawLevel * UNITY);
               actor.DrawChr (ObjSurface, (actor.Rx-Map.ClientRect.Left)*UNITX + defx,
                                           m + (actor.DownDrawLevel * UNITY),
                                           FALSE);
            end;
         end;
         for k:=0 to FlyList.Count-1 do begin
            meff := TMagicEff(FlyList[k]);
            if j = (meff.Ry - Map.BlockTop) then
               meff.DrawEff (ObjSurface);
         end;

      end;
      Inc (m, UNITY);
   end;
   except
      DebugOutStr ('106');
   end;

   //»­ÎíµÄÐ§¹û£¨ÊÓÏß£©
   try
   if ViewFog then begin
      m := defy - UNITY*4;
      for j:=(Map.ClientRect.Top - Map.BlockTop - 4) to (Map.ClientRect.Bottom - Map.BlockTop + LONGHEIGHT_IMAGE) do begin
         if j < 0 then begin Inc (m, UNITY); continue; end;
         n := defx-UNITX*5;
         //¹è°æ Æ÷±× ±×¸®±â
         for i:=(Map.ClientRect.Left - Map.BlockLeft-5) to (Map.ClientRect.Right - Map.BlockLeft+5) do begin
            if (i >= 0) and (i < LOGICALMAPUNIT*3) and (j >= 0) and (j < LOGICALMAPUNIT*3) then begin
               idx := Map.MArr[i, j].Light;
               if idx > 0 then begin
                  AddLight (i+Map.BlockLeft, j+Map.BlockTop, 0, 0, idx, FALSE);
               end;
            end;
            Inc (n, UNITX);
         end;
         Inc (m, UNITY);
      end;

      //Ä³¸¯ÅÍ Æ÷±× ±×¸®±â
      if ActorList.Count > 0 then begin
         for k:=0 to ActorList.Count-1 do begin
            actor := ActorList[k];
            if (actor = Myself) or (actor.Light > 0) then
               AddLight (actor.Rx, actor.Ry, actor.ShiftX, actor.ShiftY, actor.Light, actor=Myself);
         end;
      end else begin
         if Myself <> nil then
            AddLight (Myself.Rx, Myself.Ry, Myself.ShiftX, Myself.ShiftY, Myself.Light, TRUE);
      end;
   end;
   except
      DebugOutStr ('107');
   end;

   if not BoServerChanging then begin
      try
      //**** ÁÖÀÎ°ø Ä³¸¯ÅÍ ±×¸®±â
      if not CheckBadMapMode then
         if Myself.State and $00800000 = 0 then //Åõ¸íÀÌ ¾Æ´Ï¸é
            Myself.DrawChr (ObjSurface, (Myself.Rx-Map.ClientRect.Left)*UNITX+defx, (Myself.Ry-Map.ClientRect.Top-1)*UNITY+defy, TRUE);

      //**** ¸¶¿ì½º¸¦ °®´Ù´ë°í ÀÖ´Â Ä³¸¯ÅÍ
      if (FocusCret <> nil) then begin
         if IsValidActor (FocusCret) and (FocusCret <> Myself) then
            if FocusCret.State and $00800000 = 0 then //Åõ¸íÀÌ ¾Æ´Ï¸é
               FocusCret.DrawChr (ObjSurface,
                           (FocusCret.Rx-Map.ClientRect.Left)*UNITX+defx,
                           (FocusCret.Ry-Map.ClientRect.Top-1)*UNITY+defy, TRUE);
      end;
      if (MagicTarget <> nil) then begin
         if IsValidActor (MagicTarget) and (MagicTarget <> Myself) then
            if MagicTarget.State and $00800000 = 0 then //Åõ¸íÀÌ ¾Æ´Ï¸é
               MagicTarget.DrawChr (ObjSurface,
                           (MagicTarget.Rx-Map.ClientRect.Left)*UNITX+defx,
                           (MagicTarget.Ry-Map.ClientRect.Top-1)*UNITY+defy, TRUE);
      end;
      except
         DebugOutStr ('108');
      end;
   end;
   
   try
   //**** »­½ÇÉ«Ð§¹û
   for k:=0 to ActorList.Count-1 do begin
      actor := ActorList[k];
      actor.DrawEff (ObjSurface,
                     (actor.Rx-Map.ClientRect.Left)*UNITX + defx,
                     (actor.Ry-Map.ClientRect.Top-1)*UNITY + defy);
   end;
   //»­Ä§·¨Ð§¹û
   for k:=0 to EffectList.Count-1 do begin
      meff := TMagicEff(EffectList[k]);
      //if j = (meff.Ry - Map.BlockTop) then begin
      meff.DrawEff (ObjSurface);
      if ViewFog then begin
         AddLight (meff.Rx, meff.Ry, 0, 0, meff.Light, FALSE);
      end;
   end;
   if ViewFog then begin
      for k:=0 to EventMan.EventList.Count-1 do begin
         evn := TClEvent (EventMan.EventList[k]);
         if evn.light > 0 then
            AddLight (evn.X, evn.Y, 0, 0, evn.light, FALSE);
      end;
   end;
   except
      DebugOutStr ('109');
   end;

   //¶¥¿¡ ¶³¾îÁø ¾ÆÀÌÅÛ ºþÂ¦°Å¸®´Â °Å
   try
      for k:=0 to DropedItemList.Count-1 do begin
         pd := PTDropItem (DropedItemList[k]);
         if pd <> nil then begin
            if GetTickCount - pd.FlashTime > 5 * 1000 then begin
               pd.FlashTime := GetTickCount;
               pd.BoFlash := TRUE;
               pd.FlashStepTime := GetTickCount;
               pd.FlashStep := 0;
            end;
            if pd.BoFlash then begin
               if GetTickCount - pd.FlashStepTime >= 20 then begin
                  pd.FlashStepTime := GetTickCount;
                  Inc (pd.FlashStep);
               end;
               ix := (pd.x-Map.ClientRect.Left)*UNITX+defx + SOFFX;
               iy := (pd.y-Map.ClientRect.Top-1)*UNITY+defy + SOFFY;
               if (pd.FlashStep >= 0) and (pd.FlashStep < 10) then begin
                  DSurface := FrmMain.WProgUse.GetCachedImage (FLASHBASE+pd.FlashStep, ax, ay);
                  DrawBlend (ObjSurface, ix+ax, iy+ay, DSurface, 1);
               end else
                  pd.BoFlash := FALSE;
            end;
         end;
      end;
   except
      DebugOutStr ('110');
   end;

   try
   if ViewFog then begin
      ApplyLightMap;
      DrawFog (ObjSurface, PFogScreen, FogWidth);
      MSurface.Draw (SOFFX, SOFFY, ObjSurface.ClientRect, ObjSurface, FALSE);
   end else begin
      if Myself.Death then
         DrawEffect (0, 0, ObjSurface.Width, ObjSurface.Height, ObjSurface, ceGrayScale);
      //¿ÀºêÁ§Æ® ·¹ÀÌ¾î¿Í  ¹è°æ°ú ÇÕ¼º
      MSurface.Draw (SOFFX, SOFFY, ObjSurface.ClientRect, ObjSurface, FALSE);
   end;
   except
      DebugOutStr ('111');
   end;

   if BoViewMiniMap then begin
      DrawMiniMap (MSurface);
   end;


end;

{-------------------------------------------------------}

//cx, cy, tx, ty : ¸ÊÀÇ ÁÂÇ¥
procedure TPlayScene.NewMagic (aowner: TActor;
                               magid, magnumb, cx, cy, tx, ty, targetcode: integer;
                               mtype: TMagicType;
                               Recusion: Boolean;
                               anitime: integer;
                               var bofly: Boolean);
var
   i, scx, scy, sctx, scty, effnum: integer;
   meff: TMagicEff;
   target: TActor;
   wimg: TWMImages;
begin
   bofly := FALSE;
   if magid <> 111 then //¹ß»ç ¸¶¹ýÀº Áßº¹µÊ.
      for i:=0 to EffectList.Count-1 do
         if TMagicEff(EffectList[i]).ServerMagicId = magid then
            exit; //ÀÌ¹Ì ÀÖÀ½..
   ScreenXYfromMCXY (cx, cy, scx, scy);
   ScreenXYfromMCXY (tx, ty, sctx, scty);
   if magnumb > 0 then GetEffectBase (magnumb-1, 0, wimg, effnum)
   else effnum := -magnumb;
   target := FindActor (targetcode);

   meff := nil;
   case mtype of
      mtReady, mtFly, mtFlyAxe:
         begin
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.TargetActor := target;
            bofly := TRUE;
         end;
      mtExplosion:
         case magnumb of
            18: begin //·ÚÈ¥°Ý
               meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
               meff.MagExplosionBase := 1570;
               meff.TargetActor := target;
               meff.NextFrameTime := 80;
            end;
            21: begin //Æø¿­ÆÄ
               meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
               meff.MagExplosionBase := 1660;
               meff.TargetActor := nil; //target;
               meff.NextFrameTime := 80;
               meff.ExplosionFrame := 20;
               meff.Light := 3;
            end;
            26: begin //Å½±âÆÄ¿¬
               meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
               meff.MagExplosionBase := 3990;
               meff.TargetActor := target;
               meff.NextFrameTime := 80;
               meff.ExplosionFrame := 10;
               meff.Light := 2;
            end;
            27: begin //´ëÈ¸º¹¼ú
               meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
               meff.MagExplosionBase := 1800;
               meff.TargetActor := nil; //target;
               meff.NextFrameTime := 80;
               meff.ExplosionFrame := 10;
               meff.Light := 3;
            end;
            30: begin //»çÀÚÀ±È¸
               meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
               meff.MagExplosionBase := 3930;
               meff.TargetActor := target;
               meff.NextFrameTime := 80;
               meff.ExplosionFrame := 16;
               meff.Light := 3;
            end;
            31: begin //ºù¼³Ç³
               meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
               meff.MagExplosionBase := 3850;
               meff.TargetActor := nil; //target;
               meff.NextFrameTime := 80;
               meff.ExplosionFrame := 20;
               meff.Light := 3;
            end;
            else begin  //È¸º¹µî..
               meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
               meff.TargetActor := target;
               meff.NextFrameTime := 80;
            end;
         end;
      mtFireWind:
         meff := nil;  //È¿°ú ¾øÀ½
      mtFireGun: //È­¿°¹æ»ç
         meff := TFireGunEffect.Create (930, scx, scy, sctx, scty);
      mtThunder:
         begin
            //meff := TThuderEffect.Create (950, sctx, scty, nil); //target);
            meff := TThuderEffect.Create (10, sctx, scty, nil); //target);
            meff.ExplosionFrame := 6;
            meff.ImgLib := FrmMain.WMagic2;
         end;
      mtLightingThunder:
         meff := TLightingThunder.Create (970, scx, scy, sctx, scty, target);
      mtExploBujauk:
         begin
            case magnumb of
               10: begin  //Æø»ì°è
                  meff := TExploBujaukEffect.Create (1160, scx, scy, sctx, scty, target);
                  meff.MagExplosionBase := 1360;
               end;
               17: begin  //´ëÀº½Å
                  meff := TExploBujaukEffect.Create (1160, scx, scy, sctx, scty, target);
                  meff.MagExplosionBase := 1540;
               end;
            end;
            bofly := TRUE;
         end;
      mtBujaukGroundEffect:
         begin
            meff := TBujaukGroundEffect.Create (1160, magnumb, scx, scy, sctx, scty);
            case magnumb of
               11: meff.ExplosionFrame := 16; //Ç×¸¶Áø¹ý
               12: meff.ExplosionFrame := 16; //´ëÁö¿øÈ£
            end;
            bofly := TRUE;
         end;
      mtKyulKai:
         begin
            meff := nil; //TKyulKai.Create (1380, scx, scy, sctx, scty);
         end;
   end;
   if meff = nil then exit;

   meff.TargetRx := tx;
   meff.TargetRy := ty;
   if meff.TargetActor <> nil then begin
      meff.TargetRx := TActor(meff.TargetActor).XX;
      meff.TargetRy := TActor(meff.TargetActor).YY;
   end;
   meff.MagOwner := aowner;
   EffectList.Add (meff);
end;

procedure TPlayScene.DelMagic (magid: integer);
var
   i: integer;
begin
   for i:=0 to EffectList.Count-1 do begin
      if TMagicEff(EffectList[i]).ServerMagicId = magid then begin
         TMagicEff(EffectList[i]).Free;
         EffectList.Delete (i);
         break;
      end;
   end;
end;

//cx, cy, tx, ty : ¸ÊÀÇ ÁÂÇ¥
function  TPlayScene.NewFlyObject (aowner: TActor; cx, cy, tx, ty, targetcode: integer;  mtype: TMagicType): TMagicEff;
var
   i, scx, scy, sctx, scty: integer;
   meff: TMagicEff;
begin
   ScreenXYfromMCXY (cx, cy, scx, scy);
   ScreenXYfromMCXY (tx, ty, sctx, scty);
   case mtype of
      mtFlyArrow: meff := TFlyingArrow.Create (1, 1, scx, scy, sctx, scty, mtype, TRUE, 0);
      else meff := TFlyingAxe.Create (1, 1, scx, scy, sctx, scty, mtype, TRUE, 0);
   end;
   meff.TargetRx := tx;
   meff.TargetRy := ty;
   meff.TargetActor := FindActor (targetcode);
   meff.MagOwner := aowner;
   FlyList.Add (meff);
   Result := meff;
end;

//Àü±â½î´Â Á»ºñÀÇ ¸¶¹ýÃ³·³ ±æ°Ô ³ª°¡´Â ¸¶¹ý
//effnum: °¢ ¹øÈ£¸¶´Ù Base°¡ ´Ù ´Ù¸£´Ù.
{function  NewStaticMagic (aowner: TActor; tx, ty, targetcode, effnum: integer);
var
   i, scx, scy, sctx, scty, effbase: integer;
   meff: TMagicEff;
begin
   ScreenXYfromMCXY (cx, cy, scx, scy);
   ScreenXYfromMCXY (tx, ty, sctx, scty);
   case effnum of
      1: effbase := 340;   //Á»ºñÀÇ ¶óÀÌÆ®´×ÀÇ ½ÃÀÛ À§Ä¡
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

//¸Ê ÁÂÇ¥°è·Î ¼¿ Áß¾ÓÀÇ ½ºÅ©¸° ÁÂÇ¥¸¦ ¾ò¾î³¿
{procedure TPlayScene.ScreenXYfromMCXY (cx, cy: integer; var sx, sy: integer);
begin
   if Myself = nil then exit;
   sx := -UNITX*2 - Myself.ShiftX + AAX + 14 + (cx - Map.ClientRect.Left) * UNITX + UNITX div 2;
   sy := -UNITY*3 - Myself.ShiftY + (cy - Map.ClientRect.Top) * UNITY + UNITY div 2;
end; }

procedure TPlayScene.ScreenXYfromMCXY (cx, cy: integer; var sx, sy: integer);
begin
   if Myself = nil then exit;
   sx := (cx-Myself.Rx)*UNITX + 364 + UNITX div 2 - Myself.ShiftX;
   sy := (cy-Myself.Ry)*UNITY + 192 + UNITY div 2 - Myself.ShiftY;
end;

//½ºÅ©¸°ÀÇ mx, my·Î ¸ÊÀÇ ccx, ccyÁÂÇ¥¸¦ ¾ò¾î³¿
procedure TPlayScene.CXYfromMouseXY (mx, my: integer; var ccx, ccy: integer);
begin
   if Myself = nil then exit;
   ccx := UpInt((mx - 364 + Myself.ShiftX - UNITX) / UNITX) + Myself.Rx;
   ccy := UpInt((my - 192 + Myself.ShiftY - UNITY) / UNITY) + Myself.Ry;
end;

//È­¸éÁÂÇ¥·Î Ä³¸¯ÅÍ, ÇÈ¼¿ ´ÜÀ§·Î ¼±ÅÃ..
function  TPlayScene.GetCharacter (x, y, wantsel: integer; var nowsel: integer; liveonly: Boolean): TActor;
var
   k, i, ccx, ccy, dx, dy: integer;
   a: TActor;
begin
   Result := nil;
   nowsel := -1;
   CXYfromMouseXY (x, y, ccx, ccy);
   for k:=ccy+8 downto ccy-1 do begin
      for i:=ActorList.Count-1 downto 0 do
         if TActor(ActorList[i]) <> Myself then begin
            a := TActor(ActorList[i]);
            if (not liveonly or not a.Death) and (a.BoHoldPlace) and (a.Visible) then begin
               if a.YY = k then begin
                  //´õ ³ÐÀº ¹üÀ§·Î ¼±ÅÃµÇ°Ô
                  dx := (a.Rx-Map.ClientRect.Left)*UNITX+DefXX + a.px + a.ShiftX;
                  dy := (a.Ry-Map.ClientRect.Top-1)*UNITY+DefYY + a.py + a.ShiftY;
                  if a.CheckSelect (x-dx, y-dy) then begin
                     Result := a;
                     Inc (nowsel);
                     if nowsel >= wantsel then
                        exit;
                  end;
               end;
            end;
         end;
   end;
end;

//¸¶¿ì½º°¡ Ä³¸¯ÅÍÀÇ ±ÙÃ³¿¡¸¸ ÀÖ¾îµµ ¼±ÅÃµÇµµ·Ï....
function  TPlayScene.GetAttackFocusCharacter (x, y, wantsel: integer; var nowsel: integer; liveonly: Boolean): TActor;
var
   k, i, ccx, ccy, dx, dy, centx, centy: integer;
   a: TActor;
begin
   Result := GetCharacter (x, y, wantsel, nowsel, liveonly);
   if Result = nil then begin
      nowsel := -1;
      CXYfromMouseXY (x, y, ccx, ccy);
      for k:=ccy+8 downto ccy-1 do begin
         for i:=ActorList.Count-1 downto 0 do
            if TActor(ActorList[i]) <> Myself then begin
               a := TActor(ActorList[i]);
               if (not liveonly or not a.Death) and (a.BoHoldPlace) and (a.Visible) then begin
                  if a.YY = k then begin
                     //
                     dx := (a.Rx-Map.ClientRect.Left)*UNITX+DefXX + a.px + a.ShiftX;
                     dy := (a.Ry-Map.ClientRect.Top-1)*UNITY+DefYY + a.py + a.ShiftY;
                     if a.CharWidth > 40 then centx := (a.CharWidth - 40) div 2
                     else centx := 0;
                     if a.CharHeight > 70 then centy := (a.CharHeight - 70) div 2
                     else centy := 0;
                     if (x-dx >= centx) and (x-dx <= a.CharWidth-centx) and (y-dy >= centy) and (y-dy <= a.CharHeight-centy) then begin
                        Result := a;
                        Inc (nowsel);
                        if nowsel >= wantsel then
                           exit;
                     end;
                  end;
               end;
            end;
      end;
   end;
end;

function  TPlayScene.IsSelectMyself (x, y: integer): Boolean;
var
   k, i, ccx, ccy, dx, dy: integer;
begin
   Result := FALSE;
   CXYfromMouseXY (x, y, ccx, ccy);
   for k:=ccy+2 downto ccy-1 do begin
      if Myself.YY = k then begin
         //´õ ³ÐÀº ¹üÀ§·Î ¼±ÅÃµÇ°Ô
         dx := (Myself.Rx-Map.ClientRect.Left)*UNITX+DefXX + Myself.px + Myself.ShiftX;
         dy := (Myself.Ry-Map.ClientRect.Top-1)*UNITY+DefYY + Myself.py + Myself.ShiftY;
         if Myself.CheckSelect (x-dx, y-dy) then begin
            Result := TRUE;
            exit;
         end;
      end;
   end;
end;

function  TPlayScene.GetDropItems (x, y: integer; var inames: string): PTDropItem; //È­¸éÁÂÇ¥·Î ¾ÆÀÌÅÛ
var
   k, i, ccx, ccy, ssx, ssy, dx, dy: integer;
   d: PTDropItem;
   s: TDirectDrawSurface;
   c: byte;
begin
   Result := nil;
   CXYfromMouseXY (x, y, ccx, ccy);
   ScreenXYfromMCXY (ccx, ccy, ssx, ssy);
   dx := x - ssx;
   dy := y - ssy;
   inames := '';
   for i:=0 to DropedItemList.Count-1 do begin
      d := PTDropItem(DropedItemList[i]);
      if (d.X = ccx) and (d.Y = ccy) then begin
         s := FrmMain.WDnItem.Images[d.Looks];
         if s = nil then continue;
         dx := (x - ssx) + (s.Width div 2) - 3;
         dy := (y - ssy) + (s.Height div 2);
         c := s.Pixels[dx, dy];
         if c <> 0 then begin
            if Result = nil then Result := d;
            inames := inames + d.Name + '\';   
            //break;
         end;
      end;
   end;
end;

function  TPlayScene.CanRun (sx, sy, ex, ey: integer): Boolean;
var
   ndir, rx, ry: integer;
begin
   ndir := GetNextDirection (sx, sy, ex, ey);
   rx := sx;
   ry := sy;
   GetNextPosXY (ndir, rx, ry);
   if CanWalk (rx, ry) and CanWalk (ex, ey) then
      Result := TRUE
   else Result := FALSE;
end;

function  TPlayScene.CanWalk (mx, my: integer): Boolean;
begin
   Result := FALSE;
   if Map.CanMove(mx,my) then
      Result := not CrashMan (mx, my);
end;

function  TPlayScene.CrashMan (mx, my: integer): Boolean;
var
   i: integer;
   a: TActor;
begin
   Result := FALSE;
   for i:=0 to ActorList.Count-1 do begin
      a := TActor(ActorList[i]);
      if (a.Visible) and (a.BoHoldPlace) and (not a.Death) and (a.XX = mx) and (a.YY = my) then begin
         Result := TRUE;
         break;
      end;
   end;
end;

function  TPlayScene.CanFly (mx, my: integer): Boolean;
begin
   Result := Map.CanFly (mx, my);
end;


{------------------------ Actor ------------------------}

function  TPlayScene.FindActor (id: integer): TActor;
var
   i: integer;
begin
   Result := nil;
   for i:=0 to ActorList.Count-1 do begin
      if TActor(ActorList[i]).RecogId = id then begin
         Result := TActor(ActorList[i]);
         break;
      end;
   end;
end;

function  TPlayScene.FindActorXY (x, y: integer): TActor;  //¸Ê ÁÂÇ¥·Î actor ¾òÀ½
var
   i: integer;
begin
   Result := nil;
   for i:=0 to ActorList.Count-1 do begin
      if (TActor(ActorList[i]).XX = x) and (TActor(ActorList[i]).YY = y) then begin
         Result := TActor(ActorList[i]);
         if not Result.Death and Result.Visible and Result.BoHoldPlace then
            break;
      end;
   end;
end;

function  TPlayScene.IsValidActor (actor: TActor): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=0 to ActorList.Count-1 do begin
      if TActor(ActorList[i]) = actor then begin
         Result := TRUE;
         break;
      end;
   end;
end;

function  TPlayScene.NewActor (chrid:     integer;
                               cx:        word; //x
                               cy:        word; //y
                               cdir:      word;
                               cfeature:  integer; //race, hair, dress, weapon
                               cstate:    integer): TActor;
var
   i: integer;
   actor: TActor;
begin
   for i:=0 to ActorList.Count-1 do
      if TActor(ActorList[i]).RecogId = chrid then begin
         Result := TActor(ActorList[i]);
         exit; //ÀÌ¹Ì ÀÖÀ½
      end;
   if IsChangingFace (chrid) then exit;  //º¯½ÅÁß...      

   case RACEfeature (cfeature) of
      0:  actor := THumActor.Create;
      13: actor := TKillingHerb.Create;
      14: actor := TSkeletonOma.Create;
      15: actor := TDualAxeOma.Create;

      16: actor := TGasKuDeGi.Create;  //°¡½º½î´Â ±¸µ¥±â

      17: actor := TCatMon.Create;   //±ªÀÌ, ¿ì¸é±Í(¿ì¸é±Í,Ã¢µç¿ì¸é±Í,Ã¶Åð¿ì¸é±Í)
      18: actor := THuSuABi.Create;
      19: actor := TCatMon.Create;   //¿ì¸é±Í(¿ì¸é±Í,Ã¢µç¿ì¸é±Í,Ã¶Åðµç¿ì¸é±Í)

      20: actor := TFireCowFaceMon.Create;
      21: actor := TCowFaceKing.Create;
      22: actor := TDualAxeOma.Create;  //Ä§½î´Â ´ÙÅ©
      23: actor := TWhiteSkeleton.Create;  //¼ÒÈ¯¹é°ñ

      30: actor := TCatMon.Create; //³¯°³Áþ
      31: actor := TCatMon.Create; //³¯°³Áþ
      32: actor := TScorpionMon.Create; //°ø°ÝÀÌ 2µ¿ÀÛ

      33: actor := TCentipedeKingMon.Create;  //Áö³×¿Õ

      40: actor := TZombiLighting.Create;  //Á»ºñ 1 (Àü±â ¸¶¹ý Á»ºñ)
      41: actor := TZombiDigOut.Create;  //¶¥ÆÄ°í ³ª¿À´Â Á»ºñ
      42: actor := TZombiZilkin.Create;

      43: actor := TBeeQueen.Create;

      45: actor := TArcherMon.Create;
      47: actor := TSculptureMon.Create;  //¿°¼ÒÀå±º, ¿°¼Ò´ëÀå
      48: actor := TSculptureMon.Create;  //
      49: actor := TSculptureKingMon.Create;  //ÁÖ¸¶¿Õ

      50: actor := TNpcActor.Create;

      52, 53: actor := TGasKuDeGi.Create;  //°¡½º½î´Â ½û±â³ª¹æ, µÕ
      54: actor := TSmallElfMonster.Create;
      55: actor := TWarriorElfMonster.Create;

      98: actor := TWallStructure.Create;
      99: actor := TCastleDoor.Create;  //¼º¹®...


      else actor := TActor.Create;
   end;

   with actor do begin
      RecogId := chrid;
      XX     := cx;
      YY     := cy;
      Rx := XX;
      Ry := YY;
      Dir    := cdir;
      Feature := cfeature;
      Race   := RACEfeature (cfeature);         //changefeature°¡ ÀÖÀ»¶§¸¸
      hair   := HAIRfeature (cfeature);         //º¯°æµÈ´Ù.
      dress  := DRESSfeature (cfeature);
      weapon := WEAPONfeature (cfeature);
      Appearance := APPRfeature (cfeature);
      if Race = 0 then begin
         Sex := dress mod 2;   //0:³²ÀÚ 1:¿©ÀÚ
      end else
         Sex := 0;
      state  := cstate;
      Saying[0] := '';
   end;
   ActorList.Add (actor);
   Result := actor;
end;

procedure TPlayScene.ActorDied (actor: TObject);
var
   i: integer;
   flag: Boolean;
begin
   for i:=0 to ActorList.Count-1 do
      if ActorList[i] = actor then begin
         ActorList.Delete (i);
         break;
      end;
   flag := FALSE;
   for i:=0 to ActorList.Count-1 do
      if not TActor(ActorList[i]).Death then begin
         ActorList.Insert (i, actor);
         flag := TRUE;
         break;
      end;
   if not flag then ActorList.Add (actor);
end;

procedure TPlayScene.SetActorDrawLevel (actor: TObject; level: integer);
var
   i: integer;
begin
   if level = 0 then begin  //¸Ç Ã³À½¿¡ ±×¸®µµ·Ï ÇÔ
      for i:=0 to ActorList.Count-1 do
         if ActorList[i] = actor then begin
            ActorList.Delete (i);
            ActorList.Insert (0, actor);
            break;
         end;
   end;
end;

procedure TPlayScene.ClearActors;  //·Î±×¾Æ¿ô¸¸ »ç¿ë
var
   i: integer;
begin
   for i:=0 to ActorList.Count-1 do
      TActor(ActorList[i]).Free;
   ActorList.Clear;
   Myself := nil;
   TargetCret := nil;
   FocusCret := nil;
   MagicTarget := nil;

   //¸¶¹ýµµ ÃÊ±âÈ­ ÇØ¾ßÇÔ.
   for i:=0 to EffectList.Count-1 do
      TMagicEff (EffectList[i]).Free;
   EffectList.Clear;
end;

function  TPlayScene.DeleteActor (id: integer): TActor;
var
   i: integer;
begin
   Result := nil;
   i := 0;
   while TRUE do begin
      if i >= ActorList.Count then break;
      if TActor(ActorList[i]).RecogId = id then begin
         if TargetCret = TActor(ActorList[i]) then TargetCret := nil;
         if FocusCret = TActor(ActorList[i]) then FocusCret := nil;
         if MagicTarget = TActor(ActorList[i]) then MagicTarget := nil;
         TActor(ActorList[i]).DeleteTime := GetTickCount;
         FreeActorList.Add (ActorList[i]);
         //TActor(ActorList[i]).Free;
         ActorList.Delete (i);
      end else
         Inc (i);
   end;
end;

procedure TPlayScene.DelActor (actor: TObject);
var
   i: integer;
begin
   for i:=0 to ActorList.Count-1 do
      if ActorList[i] = actor then begin
         TActor(ActorList[i]).DeleteTime := GetTickCount;
         FreeActorList.Add (ActorList[i]);
         ActorList.Delete (i);
         break;
      end;
end;

function  TPlayScene.ButchAnimal (x, y: integer): TActor;
var
   i: integer;
   a: TActor;
begin
   Result := nil;
   for i:=0 to ActorList.Count-1 do begin
      a := TActor(ActorList[i]);
      if a.Death and (a.Race <> 0) then begin //µ¿¹° ½ÃÃ¼
         if (abs(a.XX - x) <= 1) and (abs(a.YY - y) <= 1) then begin
            Result := a;
            break;
         end;
      end;
   end;
end;


{------------------------- Msg -------------------------}


//¸Þ¼¼Áö¸¦ ¹öÆÛ¸µÇÏ´Â ÀÌÀ¯´Â ?
//Ä³¸¯ÅÍÀÇ ¸Þ¼¼Áö ¹öÆÛ¿¡ ¸Þ¼¼Áö°¡ ³²¾Æ ÀÖ´Â »óÅÂ¿¡¼­
//´ÙÀ½ ¸Þ¼¼Áö°¡ Ã³¸®µÇ¸é ¾ÈµÇ±â ¶§¹®ÀÓ.
procedure TPlayScene.SendMsg (ident, chrid, x, y, cdir, feature, state: integer; str: string);
var
   actor: TActor;
begin
   case ident of
      SM_TEST:
         begin
            actor := NewActor (111, 254{x}, 214{y}, 0, 0, 0);
            Myself := THumActor (actor);
            Map.LoadMap ('0', Myself.XX, Myself.YY);
         end;
      SM_CHANGEMAP,
      SM_NEWMAP:
         begin
            Map.LoadMap (str, x, y);
            DarkLevel := cdir;
            if DarkLevel = 0 then ViewFog := FALSE
            else ViewFog := TRUE;
            BoViewMiniMap := FALSE;
            if (ident = SM_NEWMAP) and (Myself <> nil) then begin  //¼­¹öÀÌµ¿ ÇÒ¶§ ºÎµå·´°Ô ¸ÊÀÌµ¿À» ÇÏ°Ô ¸¸µé·Á°í
               Myself.XX := x;
               Myself.YY := y;
               Myself.RX := x;
               Myself.RY := y;
               DelActor (Myself);
            end;
         end;
      SM_LOGON:
         begin
            actor := FindActor (chrid);
            if actor = nil then begin
               actor := NewActor (chrid, x, y, Lobyte(cdir), feature, state);
               actor.ChrLight := Hibyte(cdir);
               cdir := Lobyte(cdir);
               actor.SendMsg (SM_TURN, x, y, cdir, feature, state, '', 0);
            end;
            if Myself <> nil then begin
               Myself := nil;
            end;
            Myself := THumActor (actor);
         end;
      SM_HIDE:
         begin
            actor := FindActor (chrid);
            if actor <> nil then begin
               if actor.BoDelActionAfterFinished then begin //¶¥À¸·Î »ç¶óÁö´Â ¾Ö´Ï¸ÞÀÌ¼ÇÀÌ ³¡³ª¸é ÀÚµ¿À¸·Î »ç¶óÁü.
                  exit;
               end;
               if actor.WaitForRecogId <> 0 then begin  //º¯½ÅÁß.. º¯½ÅÀÌ ³¡³ª¸é ÀÚµ¿À¸·Î »ç¶óÁü
                  exit;
               end;
            end;
            DeleteActor (chrid);
         end;
      else
         begin
            actor := FindActor (chrid);
            if (ident=SM_TURN) or (ident=SM_RUN) or (ident=SM_WALK) or
               (ident=SM_BACKSTEP) or
               (ident = SM_DEATH) or (ident = SM_SKELETON) or
               (ident = SM_DIGUP) or (ident = SM_ALIVE) then
            begin
               if actor = nil then
                  actor := NewActor (chrid, x, y, Lobyte(cdir), feature, state);
               if actor <> nil then begin
                  actor.ChrLight := Hibyte(cdir);
                  cdir := Lobyte(cdir);
                  if ident = SM_SKELETON then begin
                     actor.Death := TRUE;
                     actor.Skeleton := TRUE;
                  end;
               end;
            end;
            if actor = nil then exit;
            case ident of
               SM_FEATURECHANGED:
                  begin
                     actor.Feature := feature;
                     actor.FeatureChanged;
                  end;
               SM_CHARSTATUSCHANGED:
                  begin
                     actor.State := Feature;
                     actor.HitSpeed := state;
                  end;
               else begin
                  if ident = SM_TURN then begin
                     if str <> '' then
                        actor.UserName := str;
                  end;
                  actor.SendMsg (ident, x, y, cdir, feature, state, '', 0);
               end;
            end;
         end;
   end;
end;


end.
