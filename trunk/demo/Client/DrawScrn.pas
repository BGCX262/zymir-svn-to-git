unit DrawScrn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXDraws, DXClass, DirectX, IntroScn, Actor, cliUtil, clFunc,
  HUtil32;


const
   MAXSYSLINE = 8;

   BOTTOMBOARD = 1;
   VIEWCHATLINE = 9;
   AREASTATEICONBASE = 150;
   HEALTHBAR_BLACK = 0;
   HEALTHBAR_RED = 1;


type
   TDrawScreen = class
   private
      frametime, framecount, drawframecount: longword;
      SysMsg: TStringList;
   public
      CurrentScene: TScene;
      ChatStrs: TStringList;
      ChatBks: TList;
      ChatBoardTop: integer;

      HintList: TStringList;
      HintX, HintY, HintWidth, HintHeight: integer;
      HintUp: Boolean;
      HintColor: TColor;

      constructor Create;
      destructor Destroy; override;
      procedure KeyPress (var Key: Char);
      procedure KeyDown (var Key: Word; Shift: TShiftState);
      procedure MouseMove (Shift: TShiftState; X, Y: Integer);
      procedure MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      procedure Initialize;
      procedure Finalize;
      procedure ChangeScene (scenetype: TSceneType);
      procedure DrawScreen (MSurface: TDirectDrawSurface);
      procedure DrawScreenTop (MSurface: TDirectDrawSurface);
      procedure AddSysMsg (msg: string);
      procedure AddChatBoardString (str: string; fcolor, bcolor: integer);
      procedure ClearChatBoard;

      procedure ShowHint (x, y: integer; str: string; color: TColor; drawup: Boolean);
      procedure ClearHint;
      procedure DrawHint (MSurface: TDirectDrawSurface);
   end;


implementation

uses
   ClMain;
   

constructor TDrawScreen.Create;
var
   i: integer;
begin
   CurrentScene := nil;
   frametime := GetTickCount;
   framecount := 0;
   SysMsg := TStringList.Create;
   ChatStrs := TStringList.Create;
   ChatBks := TList.Create;
   ChatBoardTop := 0;

   HintList := TStringList.Create;

end;

destructor TDrawScreen.Destroy;
begin
   SysMsg.Free;
   ChatStrs.Free;
   ChatBks.Free;
   HintList.Free;
   inherited Destroy;
end;

procedure TDrawScreen.Initialize;
begin
end;

procedure TDrawScreen.Finalize;
begin
end;

procedure TDrawScreen.KeyPress (var Key: Char);
begin
   if CurrentScene <> nil then
      CurrentScene.KeyPress (Key);
end;

procedure TDrawScreen.KeyDown (var Key: Word; Shift: TShiftState);
begin
   if CurrentScene <> nil then
      CurrentScene.KeyDown (Key, Shift);
end;

procedure TDrawScreen.MouseMove (Shift: TShiftState; X, Y: Integer);
begin
   if CurrentScene <> nil then
      CurrentScene.MouseMove (Shift, X, Y);
end;

procedure TDrawScreen.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if CurrentScene <> nil then
      CurrentScene.MouseDown (Button, Shift, X, Y);
end;

procedure TDrawScreen.ChangeScene (scenetype: TSceneType);
begin
   if CurrentScene <> nil then
      CurrentScene.CloseScene;
   case scenetype of
      stIntro:  CurrentScene := IntroScene;
      stLogin:  CurrentScene := LoginScene;
      stSelectCountry:  ;
      stSelectChr: CurrentScene := SelectChrScene;
      stNewChr:     ;
      stLoading:    ;
      stLoginNotice: CurrentScene := LoginNoticeScene;
      stPlayGame: CurrentScene := PlayScene;
   end;
   if CurrentScene <> nil then
      CurrentScene.OpenScene;
end;
//添加系统信息
procedure TDrawScreen.AddSysMsg (msg: string);
begin
   if SysMsg.Count >= 10 then SysMsg.Delete (0);
   SysMsg.AddObject (msg, TObject(GetTickCount));
end;

//添加信息聊天板
procedure TDrawScreen.AddChatBoardString (str: string; fcolor, bcolor: integer);
var
   i, len, aline: integer;
   dline, temp: string;
const
   BOXWIDTH = 374; //41;
begin
   len := Length (str);
   temp := '';
   i := 1;
   while TRUE do begin
      if i > len then break;
      if byte (str[i]) >= 128 then begin
         temp := temp + str[i];
         Inc (i);
         if i <= len then temp := temp + str[i]
         else break;
      end else
         temp := temp + str[i];

      aline := FrmMain.Canvas.TextWidth (temp);
      if aline > BOXWIDTH then begin
         ChatStrs.AddObject (temp, TObject(fcolor));
         ChatBks.Add (Pointer(bcolor));
         str := Copy (str, i+1, Len-i);
         temp := '';
         break;
      end;
      Inc (i);
   end;
   if temp <> '' then begin
      ChatStrs.AddObject (temp, TObject(fcolor));
      ChatBks.Add (Pointer(bcolor));
      str := '';
   end;
   if ChatStrs.Count > 200 then begin
      ChatStrs.Delete (0);
      ChatBks.Delete (0);
      if ChatStrs.Count - ChatBoardTop < VIEWCHATLINE then Dec(ChatBoardTop);
   end else if (ChatStrs.Count-ChatBoardTop) > VIEWCHATLINE then begin
      Inc (ChatBoardTop);
   end;

   if str <> '' then
      AddChatBoardString (' ' + str, fcolor, bcolor);
end;

//这里只计算提示信息的宽度和高度，并不显示
procedure TDrawScreen.ShowHint (x, y: integer; str: string; color: TColor; drawup: Boolean);
var
   data: string;
   w, h: integer;
begin
   ClearHint;
   HintX := x;
   HintY := y;
   HintWidth := 0;
   HintHeight := 0;
   HintUp := drawup;
   HintColor := color;
   while TRUE do begin
      if str = '' then break;
      str := GetValidStr3 (str, data, ['\']);
      w := FrmMain.Canvas.TextWidth (data) + 4{咯归} * 2;
      if w > HintWidth then HintWidth := w;
      if data <> '' then
         HintList.Add (data)
   end;
   HintHeight := (FrmMain.Canvas.TextHeight('A') + 1) * HintList.Count + 3{咯归} * 2;
   if HintUp then
      HintY := HintY - HintHeight;
end;

procedure TDrawScreen.ClearHint;
begin
   HintList.Clear;
end;

procedure TDrawScreen.ClearChatBoard;
begin
   SysMsg.Clear;
   ChatStrs.Clear;
   ChatBks.Clear;
   ChatBoardTop := 0;
end;


procedure TDrawScreen.DrawScreen (MSurface: TDirectDrawSurface);
   procedure NameTextOut (surface: TDirectDrawSurface; x, y, fcolor, bcolor: integer; namestr: string);
   var
      i, row: integer;
      nstr: string;
   begin
      row := 0;
      for i:=0 to 10 do begin
         if namestr = '' then break;
         namestr := GetValidStr3 (namestr, nstr, ['\']);
         BoldTextOut (surface,
                      x - surface.Canvas.TextWidth(nstr) div 2,
                      y + row * 12,
                      fcolor, bcolor, nstr);
         Inc (row);
      end;
   end;
var
   i, k, line, sx, sy, fcolor, bcolor: integer;
   actor: TActor;
   str, uname: string;
   dsurface: TDirectDrawSurface;
   d: TDirectDrawSurface;
   rc: TRect;
begin
   MSurface.Fill(0);
   if CurrentScene <> nil then
      CurrentScene.PlayScene (MSurface);

   if GetTickCount - frametime > 1000 then begin
      frametime := GetTickCount;
      drawframecount := framecount;    //FPS
      framecount := 0;
   end;
   Inc (framecount);

   if Myself = nil then exit;

   if CurrentScene = PlayScene then begin
      with MSurface do begin
         with PlayScene do begin
            for k:=0 to ActorList.Count-1 do begin   //画出每一个人物的状态
               actor := ActorList[k];
               if (actor.BoOpenHealth or actor.BoInstanceOpenHealth) and not actor.Death then begin
                  //画人物的“血”（头上的一个横杠）
                  if actor.BoInstanceOpenHealth then
                     if GetTickCount - actor.OpenHealthStart > actor.OpenHealthTime then
                        actor.BoInstanceOpenHealth := FALSE;
                  d := FrmMain.WProgUse2.Images[HEALTHBAR_BLACK];
                  if d <> nil then
                     MSurface.Draw (actor.SayX - d.Width div 2, actor.SayY - 10, d.ClientRect, d, TRUE);
                  d := FrmMain.WProgUse2.Images[HEALTHBAR_RED];
                  if d <> nil then begin
                     rc := d.ClientRect;
                     if actor.Abil.MaxHP > 0 then
                        rc.Right := Round((rc.Right-rc.Left) / actor.Abil.MaxHP * actor.Abil.HP);
                     MSurface.Draw (actor.SayX - d.Width div 2, actor.SayY - 10, rc, d, TRUE);
                  end;
               end;
            end;
         end;

         //画当前选择的物品/人物的名字
         SetBkMode (Canvas.Handle, TRANSPARENT);
         if (FocusCret <> nil) and PlayScene.IsValidActor (FocusCret) then begin
            uname := FocusCret.DescUserName + '\' + FocusCret.UserName;
            NameTextOut (MSurface,
                      FocusCret.SayX, // - Canvas.TextWidth(uname) div 2,
                      FocusCret.SayY + 30,
                      FocusCret.NameColor, clBlack,
                      uname);
         end;
         //玩家名称
         if BoSelectMyself then begin
            uname := Myself.DescUserName + '\' + Myself.UserName;
            NameTextOut (MSurface,
                      Myself.SayX, // - Canvas.TextWidth(uname) div 2,
                      Myself.SayY + 30,
                      Myself.NameColor, clBlack,
                      uname);
         end;

         Canvas.Font.Color := clWhite;

         //char saying
         with PlayScene do begin
            for k:=0 to ActorList.Count-1 do begin
               actor := ActorList[k];
               if actor.Saying[0] <> '' then begin
                  if GetTickCount - actor.SayTime < 4 * 1000 then begin
                     for i:=0 to actor.SayLineCount-1 do  //显示每个玩家说的话
                        if actor.Death then         //死了的话就灰/黑色显示
                           BoldTextOut (MSurface,
                                     actor.SayX - (actor.SayWidths[i] div 2),
                                     actor.SayY - (actor.SayLineCount*16) + i*14,
                                     clGray, clBlack,
                                     actor.Saying[i])
                        else                        //正常的玩家用黑/白色显示
                           BoldTextOut (MSurface,
                                     actor.SayX - (actor.SayWidths[i] div 2),
                                     actor.SayY - (actor.SayLineCount*16) + i*14,
                                     clWhite, clBlack,
                                     actor.Saying[i]);
                  end else
                     actor.Saying[0] := '';  //说的话显示4秒
               end;
            end;
         end;

         //BoldTextOut (MSurface, 0, 0, clWhite, clBlack, IntToStr(SendCount) + ' : ' + IntToStr(ReceiveCount));
         //BoldTextOut (MSurface, 0, 0, clWhite, clBlack, 'HITSPEED=' + IntToStr(Myself.HitSpeed));
         //BoldTextOut (MSurface, 0, 0, clWhite, clBlack, 'DupSel=' + IntToStr(DupSelection));
         //BoldTextOut (MSurface, 0, 0, clWhite, clBlack, IntToStr(LastHookKey));
         //BoldTextOut (MSurface, 0, 0, clWhite, clBlack,
         //             IntToStr(
         //                int64(GetTickCount - LatestSpellTime) - int64(700 + MagicDelayTime)
         //                ));
         //BoldTextOut (MSurface, 0, 0, clWhite, clBlack, IntToStr(PlayScene.EffectList.Count));
         //BoldTextOut (MSurface, 0, 0, clWhite, clBlack,
         //                  IntToStr(Myself.XX) + ',' + IntToStr(Myself.YY) + '  ' +
         //                  IntToStr(Myself.ShiftX) + ',' + IntToStr(Myself.ShiftY));

         //System Message
         //甘狼 惑怕 钎矫 (烙矫 钎矫)
         
         if (AreaStateValue and $04) <> 0 then begin
            BoldTextOut (MSurface, 0, 0, clWhite, clBlack, '傍己傈瘤开');
         end;

         Canvas.Release;


         //显示地图状态，16种：0000000000000000 从右到左，为1表示：战斗、安全、上面的那种状态 (当前只有这几种状态)
         k := 0;
         for i:=0 to 15 do begin
            if AreaStateValue and ($01 shr i) <> 0 then begin
               d := FrmMain.WProgUse.Images[AREASTATEICONBASE + i];
               if d <> nil then begin
                  k := k + d.Width;
                  MSurface.Draw (SCREENWIDTH-k, 0, d.ClientRect, d, TRUE);
               end;
            end;
         end;

      end;
   end;
end;

procedure TDrawScreen.DrawScreenTop (MSurface: TDirectDrawSurface);
var
   i, sx, sy: integer;
begin
   if Myself = nil then exit;
   //游戏状态：显示所有系统消息(左上角显示的)
   if CurrentScene = PlayScene then begin
      with MSurface do begin
         SetBkMode (Canvas.Handle, TRANSPARENT);
         if SysMsg.Count > 0 then begin
            sx := 30;
            sy := 40;
            for i:=0 to SysMsg.Count-1 do begin
               BoldTextOut (MSurface, sx, sy, clGreen, clBlack, SysMsg[i]);
               inc (sy, 16);
            end;
            //3秒减少一个系统消息
            if GetTickCount - longword(SysMsg.Objects[0]) >= 3000 then
               SysMsg.Delete (0);
         end;
         Canvas.Release;
      end;
   end;
end;

//显示提示信息
procedure TDrawScreen.DrawHint (MSurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   i, hx, hy, old: integer;
   str: string;
begin
   //显示提示框
   if HintList.Count > 0 then begin
      d := FrmMain.WProgUse.Images[394];
      if d <> nil then begin
         if HintWidth > d.Width then HintWidth := d.Width;
         if HintHeight > d.Height then HintHeight := d.Height;
         if HintX + HintWidth > SCREENWIDTH then hx := SCREENWIDTH - HintWidth
         else hx := HintX;
         if HintY < 0 then hy := 0
         else hy := HintY;
         if hx < 0 then hx := 0;

         DrawBlendEx (MSurface, hx, hy, d, 0, 0, HintWidth, HintHeight, 0);
      end;
   end;
   //在提示框中显示提示信息
   with MSurface do begin
      SetBkMode (Canvas.Handle, TRANSPARENT);
      if HintList.Count > 0 then begin
         Canvas.Font.Color := HintColor;
         for i:=0 to HintList.Count-1 do begin
            Canvas.TextOut (hx+4, hy+3+(Canvas.TextHeight('A')+1)*i, HintList[i]);
         end;
      end;

      if Myself <> nil then begin
         if CheckBadMapMode then begin
              str := IntToStr(drawframecount) +  ' '
              + '  Mouse ' + IntToStr(MouseX) + ':' + IntToStr(MouseY) + '(' + IntToStr(MCX) + ':' + IntToStr(MCY) + ')'
              + '  HP' + IntToStr(Myself.Abil.HP) + '/' + IntToStr(Myself.Abil.MaxHP)
              + '  D0 ' + IntToStr(DebugCount)
              + ' D1 ' + IntToStr(DebugCount1) + ' D2 '
              + IntToStr(DebugCount2);
         end;
         BoldTextOut (MSurface, 10, 0, clWhite, clBlack, str);
         BoldTextOut (MSurface, 8, SCREENHEIGHT-20, clWhite, clBlack, MapTitle + ' ' + IntToStr(Myself.XX) + ':' + IntToStr(Myself.YY));
      end;
      Canvas.Release;
   end;
end;


end.
