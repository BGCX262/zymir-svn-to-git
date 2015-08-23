//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit DrawScrn;

interface

uses
  Windows, Messages, SysUtils,StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXDraws, DXClass, DirectX, IntroScn, Actor, cliUtil, clFunc,HUtil32,WShare;


const
   MAXSYSLINE = 8;

   BOTTOMBOARD = 1;
   VIEWCHATLINE = 9;
   AREASTATEICONBASE = 150;
   HEALTHBAR_BLACK = 0;
   HEALTHBAR_RED = 1;


type

  TShowHint = record
    sStr: string;
    FColor: TColor;
    BColor: TColor;
    nX: Word;
    boEnd: Boolean;
  end;
  pTShowHint = ^TShowHint;

   TDrawScreen = class
   private
      m_dwFrameTime       :LongWord;
      m_dwFrameCount      :LongWord;
      m_dwDrawFrameCount  :LongWord;
      m_dwTopMsgTime      :LongWord;
      m_nTopMsgFrame      :Integer;
      m_nTOPTextWidth     :Integer;
      m_SysMsgList        :TStringList;
      m_HitMsgList        :TStringList;
      m_TopMsgList        :TStringList;
   public
      CurrentScene: TScene;
      ChatStrs: TStringList;
      ChatBks: TList;
      ChatADStrs: TStringList;
      ChatAdBks: TStringList;
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
      procedure AddHitMsg (msg: string);
      procedure AddTopMsg (msg: string;boColor:Integer);
      procedure AddChatBoardString (str: string; fcolor, bcolor: integer);
      procedure AddChatADString (str: string; fcolor, bcolor,Time: integer);
      procedure ClearChatBoard;

      procedure ShowHint (x, y: integer; str: string; color: TColor; drawup: Boolean);
  //    procedure ShowHintEX(X, Y: Integer; str: string; Color: TColor; drawup: Boolean;boItemHint:Boolean=False);
      procedure ClearHint;
      procedure DrawHint (MSurface: TDirectDrawSurface);
   end;


implementation

uses
   ClMain, MShare, Share,FState,WIL,magiceff,DIB,grobal2;

const
    UseItem    : Array[0..13] of String =(
      '衣　服',
      '武　器',
      '配　带',
      '项　链',
      '头　盔',
      '左手镯',
      '右手镯',
      '左戒指',
      '右戒指',
      '消耗品',
      '腰　带',
      '靴　子',
      '宝　石',
      '斗　笠'
   );
   

constructor TDrawScreen.Create;
//var
//   i: integer;
begin
Try //程序自动增加
   CurrentScene := nil;
   m_dwFrameTime := GetTickCount;
   m_dwFrameCount := 0;
   m_SysMsgList := TStringList.Create;
   m_HitMsgList := TStringList.Create;
   m_TopMsgList := TStringList.Create;
   ChatStrs := TStringList.Create;
   ChatADStrs:=TStringList.Create;
   ChatADBKs:=TStringList.Create;
   ChatBks := TList.Create;
   ChatBoardTop := 0;

   HintList := TStringList.Create;

Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.Create'); //程序自动增加
End; //程序自动增加
end;

destructor TDrawScreen.Destroy;
begin
Try //程序自动增加
   m_SysMsgList.Free;
   m_HitMsgList.Free;
   m_TopMsgList.Free;
   ChatStrs.Free;
   ChatBks.Free;
   ChatADStrs.Free;
   ChatADBks.Free;
   HintList.Free;
   inherited Destroy;
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.Destroy'); //程序自动增加
End; //程序自动增加
end;

procedure TDrawScreen.Initialize;
begin
Try //程序自动增加
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.Initialize'); //程序自动增加
End; //程序自动增加
end;

procedure TDrawScreen.Finalize;
begin
Try //程序自动增加
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.Finalize'); //程序自动增加
End; //程序自动增加
end;

procedure TDrawScreen.KeyPress (var Key: Char);
begin
Try //程序自动增加
   if CurrentScene <> nil then
      CurrentScene.KeyPress (Key);
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.KeyPress'); //程序自动增加
End; //程序自动增加
end;

procedure TDrawScreen.KeyDown (var Key: Word; Shift: TShiftState);
begin
Try //程序自动增加
   if CurrentScene <> nil then
      CurrentScene.KeyDown (Key, Shift);
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.KeyDown'); //程序自动增加
End; //程序自动增加
end;

procedure TDrawScreen.MouseMove (Shift: TShiftState; X, Y: Integer);
begin
Try //程序自动增加
   if CurrentScene <> nil then
      CurrentScene.MouseMove (Shift, X, Y);
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.MouseMove'); //程序自动增加
End; //程序自动增加
end;

procedure TDrawScreen.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
Try //程序自动增加
   if CurrentScene <> nil then
      CurrentScene.MouseDown (Button, Shift, X, Y);
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.MouseDown'); //程序自动增加
End; //程序自动增加
end;

procedure TDrawScreen.ChangeScene (scenetype: TSceneType);
begin
Try //程序自动增加
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
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.ChangeScene'); //程序自动增加
End; //程序自动增加
end;

procedure TDrawScreen.AddTopMsg (msg: string;boColor:Integer);
begin
Try //程序自动增加
  m_TopMsgList.AddObject (msg, TObject(boColor));
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.AddTopMsg'); //程序自动增加
End; //程序自动增加
end;

procedure TDrawScreen.AddHitMsg (msg: string);
begin
Try //程序自动增加
   if m_HitMsgList.Count >= 10 then m_HitMsgList.Delete (0);
   m_HitMsgList.AddObject (msg, TObject(GetTickCount));
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.AddHitMsg'); //程序自动增加
End; //程序自动增加
end;

procedure TDrawScreen.AddSysMsg (msg: string);
begin
Try //程序自动增加
   if m_SysMsgList.Count >= 10 then m_SysMsgList.Delete (0);
   m_SysMsgList.AddObject (msg, TObject(GetTickCount));
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.AddSysMsg'); //程序自动增加
End; //程序自动增加
end;

procedure TDrawScreen.AddChatADString (str: string; fcolor, bcolor,Time: integer);
var
   i, len, aline: integer;
   {dline,} temp: string;
const
   BOXWIDTH = (SCREENWIDTH div 2 - 214) * 2{374}; //41 聊天框文字宽度
begin
Try //程序自动增加
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
         ChatADStrs.AddObject (temp, TObject(fcolor));
         ChatADBks.AddObject (IntToStr(bcolor),TObject(Time));
         str := Copy (str, i+1, Len-i);
         temp := '';
         break;
      end;
      Inc (i);
   end;
   if temp <> '' then begin
      ChatADStrs.AddObject (temp, TObject(fcolor));
      ChatADBks.AddObject (IntToStr(bcolor),TObject(Time));
      str := '';
   end;
   if ChatADStrs.Count > 200 then begin
      ChatADStrs.Delete (0);
      ChatADBks.Delete (0);
      {if ChatStrs.Count - ChatBoardTop < VIEWCHATLINE then Dec(ChatBoardTop);
   end else if (ChatStrs.Count-ChatBoardTop) > VIEWCHATLINE then begin
      Inc (ChatBoardTop);}
   end;

   if str <> '' then
      AddChatADString (' ' + str, fcolor, bcolor,Time);
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.AddChatADString'); //程序自动增加
End; //程序自动增加
end;

procedure TDrawScreen.AddChatBoardString (str: string; fcolor, bcolor: integer);
var
   i, len, aline: integer;
   {dline,} temp: string;
const
   BOXWIDTH = (SCREENWIDTH div 2 - 214) * 2{374}; //41 聊天框文字宽度
begin
Try //程序自动增加
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

Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.AddChatBoardString'); //程序自动增加
End; //程序自动增加
end;

procedure TDrawScreen.ShowHint (x, y: integer; str: string; color: TColor; drawup: Boolean);
var
   data: string;
   w{, h}: integer;
begin
Try //程序自动增加
   ClearHint;
   if str='' then exit; //Jason增加
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
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.ShowHint'); //程序自动增加
End; //程序自动增加
end;
(*
procedure TDrawScreen.ShowHintEX(X, Y: Integer; str: string; Color: TColor; drawup: Boolean;boItemHint:Boolean=False);
var
  data,fdata,cmdstr,cmdparam,sFColor,sBColor,sTemp: string;
  w,nHeight: Integer;
  pHint: pTShowHint;
begin
  ClearHint;
  HintX := X;
  HintY := Y;
  HintWidth := 0;
  HintHeight := 0;
  nHeight := 0;
  HintUp := drawup;
  HintColor := Color;
  while True do begin
    if str = '' then break;
    str := GetValidStr3(str, data, ['\']);
    //if boItemHint then w := 0
    //else
    w := 4;
    if data <> '' then
    begin
      while (pos('<', data) > 0) and (pos('>', data) > 0) and (data <> '') do
      begin
        fdata := '';
        if data[1] <> '<' then begin
          data := '<' + GetValidStr3(data, fdata, ['<']);
        end;
        data := ArrestStringEx(data, '<', '>', cmdstr);
        if cmdstr <> '' then begin
          cmdparam := GetValidStr3(cmdstr, cmdstr, ['/']);
        end;
        if fdata <> '' then begin
          New(pHint);
          pHint.sStr := fdata;
          pHint.FColor := Color;
          pHint.BColor := clBlack;
          pHint.nX := w;
          pHint.boEnd := False;
          Inc(w,frmMain.Canvas.TextWidth(fdata));
          HintList.Add(pHint);
        end;
        if cmdstr <> '' then begin
          sFColor := '';
          sBColor := '';
          New(pHint);
          pHint.sStr := cmdstr;
          pHint.FColor := Color;
          pHint.BColor := clBlack;
          pHint.nX := w;
          pHint.boEnd := False;
          if pos(',', cmdparam) > 0 then
          begin
            sBColor := GetValidStr3(cmdparam, sFColor, [',']);
          end else sFColor := cmdparam;

          if CompareLStr(sFColor, 'FCOLOR', length('FCOLOR')) then begin
            sFColor := GetValidStr3(sFColor, sTemp, ['=']);
            pHint.FColor := StrToIntDef(sFColor,Color);
          end;
          if CompareLStr(sBColor, 'BCOLOR', length('BCOLOR')) then begin
            sBColor := GetValidStr3(sBColor, sTemp, ['=']);
            pHint.BColor := StrToIntDef(sBColor,Color);
          end;
          Inc(w,frmMain.Canvas.TextWidth(cmdstr));
          HintList.Add(pHint);
        end;
      end;
      New(pHint);
      pHint.sStr := '';
      pHint.FColor := Color;
      pHint.BColor := clBlack;
      pHint.nX := w;
      pHint.boEnd := True;  //加入换行确认
      if data <> '' then
      begin
        pHint.sStr := data;
        pHint.FColor := Color;
        pHint.BColor := clBlack;
        pHint.boEnd := True;
        Inc(w,frmMain.Canvas.TextWidth(data));
      end;
      HintList.Add(pHint);
      if (w + 12) > HintWidth then HintWidth := w + 12;
      Inc(nHeight);
    end;
  end;
  if boItemHint then HintWidth := _MAX(100,HintWidth);
  HintHeight := (frmMain.Canvas.TextHeight('A') + 1) * nHeight + 3 {咯归} * 2;
  if HintUp then
    HintY := HintY - HintHeight;
end;
 *)
procedure TDrawScreen.ClearHint;
begin
Try //程序自动增加
   HintList.Clear;
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.ClearHint'); //程序自动增加
End; //程序自动增加
end;

procedure TDrawScreen.ClearChatBoard;
begin
Try //程序自动增加
   m_SysMsgList.Clear;
   m_HitMsgList.Clear;
   ChatStrs.Clear;
   ChatBks.Clear;
   ChatBoardTop := 0;
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.ClearChatBoard'); //程序自动增加
End; //程序自动增加
end;


procedure TDrawScreen.DrawScreen (MSurface: TDirectDrawSurface);
procedure NameTextOut (surface: TDirectDrawSurface; x, y, fcolor, bcolor: integer; namestr: string);
   var
     row: integer;
     nstr: string;
   begin
      row := 0;
      while True do begin
        if namestr = '' then break;
         namestr := GetValidStr3 (namestr, nstr, ['\']);
         if nstr<>'' then begin

           BoldTextOut (surface,
                        x -TextWidthAndHeight(surface.Canvas.Handle,nstr).cx{surface.Canvas.TextWidth(nstr)} div 2,
                        y + row * 12,
                        fcolor, bcolor, nstr);
           Inc (row);
         end;
      end;
   end;

var
   i, k, {line, sx, sy,}nX,nY, fcolor{,dx,dy, bcolor,idx}: integer;
   actor: TActor;
   {str,} uname: string;
//   dsurface: TDirectDrawSurface;
   d: TDirectDrawSurface;
   rc: TRect;
   infoMsg :String;
   ax,ay:integer;
   II:integer;
   boInc:Boolean;
   MoveShow:pTMoveHMShow;
   HpIdx:integer;
   WMainImages:TWMImages;
   nCorpIdx:Integer;
   sz: SIZE;
begin
Try //程序自动增加
   MSurface.Fill(0);
   if CurrentScene <> nil then
      CurrentScene.PlayScene (MSurface);

   if GetTickCount - m_dwFrameTime > 1000 then begin
      m_dwFrameTime := GetTickCount;
      m_dwDrawFrameCount := m_dwFrameCount;
      m_dwFrameCount := 0;
   end;
   Inc (m_dwFrameCount);

   if g_MySelf = nil then exit;
   //exit;
   if CurrentScene = PlayScene then begin
      with MSurface do begin
         //赣府困俊 眉仿 钎矫 秦具 窍绰 巴甸
         with PlayScene do begin
            for k:=0 to m_ActorList.Count-1 do begin
               actor := m_ActorList[k];
               if g_MySelf<>Nil then begin
                if (abs(g_MySelf.m_nCurrX-actor.m_nCurrX)>8) or
                   (abs(g_MySelf.m_nCurrY-actor.m_nCurrY)>7) then Continue;
               end;
               //清理战场
               if actor.m_nRecogId=g_HeronRecogId then actor.m_Abil:=g_HeroAbil;
               if (actor.m_boDeath) and (g_WgInfo.boClearMapDieActor) then begin
                  if actor.m_dwDelTick=0 then begin
                    actor.m_dwDelTick:=GetTickCount;
                  end else
                  if (GetTickCount - actor.m_dwDelTick) > g_WgInfo.nClearMapDieActorTime then
                    Actor.m_boDelActor:=True;
               end;

              //显示移动HP
              II:=0;
               with actor do begin
                 while TRUE do begin
                   if II >=m_nMoveHpList.Count then break;
                   MoveShow:=m_nMoveHpList.Items[II];
                   if MoveShow.boMoveHpShow then begin
                      for I:=0 to MoveShow.nMoveHpCount do begin
                        d := g_WMain99Images.GetCachedImage (MoveShow.nMoveHpList[I], ax, ay);
                        if d <> nil then
                          MSurface.Draw (ax+m_nSayX + MoveShow.nMoveHpEnd+I*8,
                                         ay+m_nSayY - MoveShow.nMoveHpEnd-30,
                                         d.ClientRect,
                                         d,
                                         TRUE);
                      end;
                      if (GetTickCount-MoveShow.dwMoveHpTick) > 30 then begin
                        MoveShow.dwMoveHpTick:=GetTickCount;
                        Inc(MoveShow.nMoveHpEnd);
                      end;
                      if MoveShow.nMoveHpEnd > 20 then begin
                        MoveShow.boMoveHpShow:=False;
                        m_nMoveHpList.Delete(II);
                        Dispose(MoveShow);
                      end else Inc(II);
                   end;
                 end;
               end;

               if actor.m_btHorse=0 then actor.m_nShowY:=6
               else actor.m_nShowY:=26;
               if g_wgInfo.boShowBlueMpLable and g_ClientWgInfo.boShowBlueMpLable and (not actor.m_boDeath) then begin   //显示蓝条
                  if actor.m_Abil.MaxMP > 0 then begin
                      Inc(actor.m_nShowY,2);
                      d := g_WMain3Images.Images[HEALTHBAR_BLACK];
                      if d <> nil then begin
                        MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - actor.m_nShowY, d.ClientRect, d, TRUE);
                        d := g_WMain99Images.Images[0];
                        if d <> nil then begin
                          rc := d.ClientRect;
                          rc.Right := Round((rc.Right-rc.Left) / actor.m_Abil.MaxMP * actor.m_Abil.MP);
                          MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - actor.m_nShowY, rc, d, TRUE);
                        end;
                      end;
                  end;
               end;

               if g_WgInfo.boShowRedHPLable and g_ClientWgInfo.boShowRedHPLable and (not actor.m_boDeath) and (not ((actor.m_wAppearance=71) and (actor.m_nCurrentAction=SM_WALK))) then begin; //显示血条
                    HpIdx:=HEALTHBAR_RED;
                    case actor.m_btRace of
                      50: begin
                            if not (actor.m_wAppearance in [33..50,52..69,72..75]) then begin
                              HpIdx:=0;
                              WMainImages:=g_WMain99Images; //npc
                            end else WMainImages:=Nil;
                          end;
                      12: begin
                            HpIdx:=0;
                            WMainImages:=g_WMain99Images; //大刀
                          end;
                      0:  begin
                            HpIdx:=HEALTHBAR_RED;
                            WMainImages:=g_WMain3Images;
                          end;
                      else begin
                            HpIdx:=HEALTHBAR_RED;
                            WMainImages:=g_WMain3Images;
                           end;
                    end;
                    if WMainImages<>Nil then begin
                      Inc(actor.m_nShowY,4);
                      if actor.m_noInstanceOpenHealth then
                         if GetTickCount - actor.m_dwOpenHealthStart > actor.m_dwOpenHealthTime then
                            actor.m_noInstanceOpenHealth := FALSE;
                      d := g_WMain3Images.Images[HEALTHBAR_BLACK];
                      if d <> nil then
                        MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - actor.m_nShowY, d.ClientRect, d, TRUE);

                      d := WMainImages.Images[HpIdx];
                      if d=Nil then d := g_WMain3Images.Images[HEALTHBAR_RED];
                      if d <> nil then begin
                         rc := d.ClientRect;
                         if actor.m_Abil.MaxHP > 0 then
                            rc.Right := Round((rc.Right-rc.Left) / actor.m_Abil.MaxHP * actor.m_Abil.HP);
                        { if WMainImages = g_WMain99Images then
                         begin
                           rc.Left := actor.m_nSayX - d.Width div 2 + 1;
                           rc.Top :=  actor.m_nSayY - actor.m_nShowY + 1;
                           rc.Bottom := rc.Top + d.Height - 2;
                           rc.Right := rc.Left + rc.Right - 2;
                           MSurface.FillRect(rc,pfRGBEx(171));
                         end else }
                          MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - actor.m_nShowY, rc, d, TRUE);
                      end;
                    end;
                 end;


               SetBkMode (Canvas.Handle, TRANSPARENT);

               //显示数字血量
                 if g_wgInfo.boShowHPNumber and g_ClientWgInfo.boShowHPNumber and (actor.m_Abil.MaxHP > 1) and (not actor.m_boDeath) and (actor.m_btRace<>50) then begin
                   Inc(actor.m_nShowY,12);
                   //SetBkMode (Canvas.Handle, TRANSPARENT);
                   infoMsg:=IntToStr(actor.m_Abil.HP) + '/' + IntToStr(actor.m_Abil.MaxHP);
                   BoldTextOut (MSurface,actor.m_nSayX -TextWidthAndHeight(Canvas.Handle,infoMsg).cx div 2 ,actor.m_nSayY - actor.m_nShowY, clWhite, clBlack,infoMsg );

                   //infoMsg:='【城  主】';
                   //BoldTextOut (MSurface,actor.m_nSayX - Canvas.TextWidth(infoMsg) div 2 ,actor.m_nSayY - 12-23, clyellow, clBlack,infoMsg );
                   //actor.m_nSayX - d.Width div 2, actor.m_nSayY - 12-25
                 end;

               //显示人物名称
               if (g_wginfo.boShowName) and g_ClientWgInfo.boShowName and (actor.m_btRace in [0,50]) and (g_FocusCret<>actor) and (not ((actor.m_wAppearance=71) and (actor.m_nCurrentAction=SM_WALK))) then begin
                  if actor=g_MySelf then begin
                    if not g_boSelectMyself then begin
                      if g_wginfo.boShowAllName and g_ClientWgInfo.boShowAllName then uname:=actor.m_sDescUserName+ '\' +actor.m_sUserName
                      else uname := actor.m_sUserName;
                      NameTextOut (MSurface,
                                   actor.m_nSayX,
                                   actor.m_nSayY + 30,
                                   actor.m_nNameColor, clBlack,
                                   uname);
                    end;
                  end else begin
                    if g_wginfo.boShowAllName and g_ClientWgInfo.boShowAllName then uname:=actor.m_sDescUserName+ '\' +actor.m_sUserName
                    else uname := actor.m_sUserName;
                    NameTextOut (MSurface,
                                 actor.m_nSayX,
                                 actor.m_nSayY + 30,
                                 actor.m_nNameColor, clBlack,
                                 uname);
                  end;
               end;
               Canvas.Release;

               if actor.m_boIsShop then begin
                 //摆摊
                 Inc(actor.m_nShowY,15);
                 d := g_WMain99Images.Images[56];
                 if d <> nil then begin
                    MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - actor.m_nShowY, d.ClientRect, d, TRUE);
                  end;
                  Inc(actor.m_nShowY,14);
                 if actor.m_sShopMsg<>'' then begin
                   SetBkMode (Canvas.Handle, TRANSPARENT);
                   BoldTextOut (MSurface,actor.m_nSayX -TextWidthAndHeight(Canvas.Handle,actor.m_sShopMsg).cx{Canvas.TextWidth(actor.m_sShopMsg)} div 2 ,actor.m_nSayY - actor.m_nShowY, clWhite, clBlack,actor.m_sShopMsg);
                 end;
                 Canvas.Release;

               end else begin
                 //显示特殊图标

                 if actor.m_nUserCorpsIdx > 0 then begin
                   WMainImages:=g_WMain3Images;
                   case actor.m_nUserCorpsIdx of
                      1 : begin
                        WMainImages:=g_WMain3Images;
                        nCorpIdx:=296;
                      end;
                      2 : begin
                        WMainImages:=g_WMain3Images;
                        nCorpIdx:=295;
                      end;
                      else nCorpIdx:=0;
                   end;
                   if nCorpIdx > 0 then begin
                     Inc(actor.m_nShowY,15);

                     d := WMainImages.Images[nCorpIdx];//WMainImages.GetImage(nCorpIdx,nX,nY);
                     if d<>nil then
                        MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - actor.m_nShowY, d.ClientRect, d, TRUE);
                   end;
                 end;
               end;
               boInc:=False;
               fcolor:=0;
               for i:=Low(actor.m_nIconIdx) to High(actor.m_nIconIdx) do begin
                  if actor.m_nIconIdx[i] > 0 then begin
                    if not boInc then begin
                      if actor.m_btRace<>0 then begin
                        Inc(actor.m_nShowY,24);
                        fcolor:=10;
                      end else begin
                        Inc(actor.m_nShowY,17);
                        fcolor:=8;
                      end;
                      boInc:=True;
                    end;
                    d := g_WIconImages.GetCachedImage(actor.m_nIconIdx[i],nX,nY);//g_WIconImages.Images[actor.m_nIconIdx[i]];
                    if d <> nil then begin
                      //DScreen.AddChatBoardString (IntTOStr(I), GetRGB(0), GetRGB(255));
                      MSurface.Draw ((actor.m_nSayX-fcolor)+((I-2)*17) + nX, actor.m_nSayY - actor.m_nShowY + nY, d.ClientRect, d, TRUE);
                    end;
                  end;
               end;

               if (actor.m_sGroupMsg<>'') then begin
                  SetBkMode (Canvas.Handle, TRANSPARENT);
                  Inc(actor.m_nShowY,14);
                  BoldTextOut (MSurface,actor.m_nSayX -TextWidthAndHeight(Canvas.Handle,actor.m_sGroupMsg).cx{Canvas.TextWidth(actor.m_sGroupMsg)} div 2 ,actor.m_nSayY - actor.m_nShowY, clWhite, clBlack,actor.m_sGroupMsg);
                  Canvas.Release;
               end;
               //Inc(actor.m_nShowY,14);
               if actor.m_SayingArr[0] <> '' then begin
                  if GetTickCount - actor.m_dwSayTime < 4 * 1000 then begin
                     SetBkMode (Canvas.Handle, TRANSPARENT);
                     for i:=0 to actor.m_nSayLineCount - 1 do
                        if actor.m_boDeath then
                           BoldTextOut (MSurface,
                                     actor.m_nSayX - (actor.m_SayWidthsArr[i] div 2),
                                     actor.m_nSayY - (actor.m_nSayLineCount*16) + i*14 ,
                                     clGray, clBlack,
                                     actor.m_SayingArr[i])
                        else
                           BoldTextOut (MSurface,
                                     actor.m_nSayX - (actor.m_SayWidthsArr[i] div 2),
                                     actor.m_nSayY - (actor.m_nSayLineCount*16) + i*14 - actor.m_nShowY,
                                     clWhite, clBlack,
                                     actor.m_SayingArr[i]);
                     Canvas.Release;
                  end else
                     actor.m_SayingArr[0] := '';
               end;

            end;   //end for
         end;
                           //显示角色说话文字
        { with PlayScene do begin
            Inc(actor.m_nShowY,14);
            for k:=0 to m_ActorList.Count-1 do begin
               actor := m_ActorList[k];
               if actor.m_SayingArr[0] <> '' then begin
                  if GetTickCount - actor.m_dwSayTime < 4 * 1000 then begin
                     for i:=0 to actor.m_nSayLineCount - 1 do
                        if actor.m_boDeath then
                           BoldTextOut (MSurface,
                                     actor.m_nSayX - (actor.m_SayWidthsArr[i] div 2),
                                     actor.m_nSayY - (actor.m_nSayLineCount*16) + i*14 ,
                                     clGray, clBlack,
                                     actor.m_SayingArr[i])
                        else
                           BoldTextOut (MSurface,
                                     actor.m_nSayX - (actor.m_SayWidthsArr[i] div 2),
                                     actor.m_nSayY - (actor.m_nSayLineCount*16) + i*14 - actor.m_nShowY,
                                     clWhite, clBlack,
                                     actor.m_SayingArr[i]);
                  end else
                     actor.m_SayingArr[0] := '';
               end;
            end;
         end;}

         //付快胶肺 措绊 乐绰 某腐磐 捞抚 唱坷扁
         SetBkMode (Canvas.Handle, TRANSPARENT);
         if (g_FocusCret <> nil) and PlayScene.IsValidActor (g_FocusCret) then begin
            //if FocusCret.Grouped then uname := char(7) + FocusCret.UserName
            //else
            uname := g_FocusCret.m_sDescUserName + '\' + g_FocusCret.m_sUserName;
            NameTextOut (MSurface,
                      g_FocusCret.m_nSayX, // - Canvas.TextWidth(uname) div 2,
                      g_FocusCret.m_nSayY + 30,
                      g_FocusCret.m_nNameColor, clBlack,
                      uname);
         end;
         if g_boSelectMyself then begin
            uname := g_MySelf.m_sDescUserName + '\' + g_MySelf.m_sUserName;
            NameTextOut (MSurface,
                      g_MySelf.m_nSayX, // - Canvas.TextWidth(uname) div 2,
                      g_MySelf.m_nSayY + 30,
                      g_MySelf.m_nNameColor, clBlack,
                      uname);
         end;

         Canvas.Font.Color := clWhite;

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
         //                  IntToStr(Myself.XX) + ',' + IntToStr(Myself.m_nCurrY) + '  ' +
         //                  IntToStr(Myself.ShiftX) + ',' + IntToStr(Myself.ShiftY));

         //System Message
         //甘狼 惑怕 钎矫 (烙矫 钎矫)
         if (g_nAreaStateValue and $04) <> 0 then begin
            BoldTextOut (MSurface, 0, 0, clWhite, clBlack, '攻城区域');
         end;
         Canvas.Release;


         //甘狼 惑怕 钎矫
         k := 0;
         for i:=0 to 15 do begin
            if g_nAreaStateValue and ($01 shr i) <> 0 then begin
               d := g_WMainImages.Images[AREASTATEICONBASE + i];
               if d <> nil then begin
                  k := k + d.Width;
                  MSurface.Draw (SCREENWIDTH-k, 0, d.ClientRect, d, TRUE);
               end;
            end;
         end;

      end;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.DrawScreen'); //程序自动增加
End; //程序自动增加
end;
//显示左上角信息文字
procedure TDrawScreen.DrawScreenTop (MSurface: TDirectDrawSurface);
var
   i, sx, sy: integer;
   Leng:Integer;
   sMsg,sData:String;
//   Rect:TRect;
  FontName:TFontName;
  nSize:Integer;
begin
Try //程序自动增加
   if g_MySelf = nil then exit;

   if CurrentScene = PlayScene then begin
      with MSurface do begin
         SetBkMode (Canvas.Handle, TRANSPARENT);
         if (g_sCenterMsg<>'') and (GetTickCount < g_dwCenterMsgTick) then begin
           nSize:=Canvas.Font.Size;
           FontName:=Canvas.Font.Name;
           Canvas.Font.Size:=18;
           Canvas.Font.Style:=[fsBold];
           Canvas.Font.Name:='新宋体';
           Leng:=TagCount(g_sCenterMsg,'\');
           sy:=Leng*15;
           sData:=g_sCenterMsg;
           while (sData<>'') do begin
              sData:=GetValidStr3(sData,sMsg,['\']);
              BoldTextOut(MSurface,
                          (SCREENWIDTH div 2) - (TextWidthAndHeight(Canvas.Handle,sMsg).cx{Canvas.TextWidth(sMsg)} div 2),
                          ((SCREENHEIGHT-250) div 2) - (Leng * 30) + sy,
                          g_dwCenterMsgfcolor,
                          g_dwCenterMsgbcolor,
                          sMsg);
              Dec(Leng);
              if Leng < 0 then break;
           end;


           {sMsg:='测试文字新宋体新宋体新宋体';
           BoldTextOut(MSurface,
                      (SCREENWIDTH div 2) - (Canvas.TextWidth(sMsg) div 2),
                      ((SCREENHEIGHT-250) div 2) - (Canvas.TextHeight(sMsg) div 2),clLime,clBlack,sMsg);}
           Canvas.Font.Size:=nSize;
           Canvas.Font.Name:=FontName;
           Canvas.Font.Style:=[];
         end;
         if m_SysMsgList.Count > 0 then begin
            sx := 30;
            sy := 40;
            for i:=0 to m_SysMsgList.Count-1 do begin
               BoldTextOut (MSurface, sx, sy, clLime{clGreen}, clBlack, m_SysMsgList[i]);
               inc (sy, 16);
            end;
            if GetTickCount - longword(m_SysMsgList.Objects[0]) >= 3000 then
               m_SysMsgList.Delete (0);
         end;
         if m_HitMsgList.Count > 0 then begin
            sx := 30;
            sy := 360;
            for i:=0 to m_HitMsgList.Count-1 do begin
               BoldTextOut (MSurface, sx, sy, clLime, clBlack, m_HitMsgList[i]);
               inc (sy, 16);
            end;
            if GetTickCount - longword(m_HitMsgList.Objects[0]) >= 3000 then
               m_HitMsgList.Delete (0);
         end;
         if m_TopMsgList.Count > 0 then
         begin
            sMsg:=m_TopMsgList.Strings[0];
            Leng:=Integer(m_TopMsgList.Objects[0]);
            if m_nTopMsgFrame=0 then
               m_nTOPTextWidth:=TextWidthAndHeight(Canvas.Handle,sMsg).cx;
            if (GetTickCount - m_dwTopMsgTime) > 30 then
            begin
               m_dwTopMsgTime:=GetTickCount;
               Inc(m_nTopMsgFrame);
            end;
            BoldTextOut (MSurface,SCREENWIDTH-m_nTopMsgFrame, 30, GetRGB(Lobyte(Leng)),GetRGB(Hibyte(Leng)),sMsg);
            if m_nTopMsgFrame > (SCREENWIDTH+m_nTOPTextWidth{Canvas.TextWidth(sMsg)}) then
            begin
              m_nTopMsgFrame:=0;
              m_TopMsgList.Delete(0);
            end;
         end;
         Canvas.Release;
      end;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.DrawScreenTop'); //程序自动增加
End; //程序自动增加
end;

procedure TDrawScreen.DrawHint (MSurface: TDirectDrawSurface);
ResourceString
  sTest1  = '负重：%d/%d 金币：%d 鼠标：%d:%d(%d:%d) 目标: %s(%d/%d) 锁定目标：%s(%d/%d)';
  sTest2  = '%s (%d/%d)%d';
var
   d: TDirectDrawSurface;
   i, hx, hy{, old}: integer;
//   str: string;
//   II:Integer;
   infoMsg:String;
   sName,sName2:String;
   nHp,nMp,nHp2,nMp2:Integer;
begin
Try //程序自动增加
   hx:=0;
   hy:=0;//Jacky
   if HintList.Count > 0 then begin
      d := g_WMainImages.Images[394];
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
{$REGION '没用的'}
{$IF WGDEBUG = DEBUGOPEN}
  if g_GroupMembers.Count = 0 then begin
    g_GroupMembers.Add('测试账号一人在');
    g_GroupMembers.Add('dsfadfa');
    g_GroupMembers.Add('测试账号一');
    g_GroupMembers.Add('测试人在');
    g_GroupMembers.Add('测试账在d');
  end;
{$IFEND}
{$ENDREGION}
   with MSurface do begin
      SetBkMode (Canvas.Handle, TRANSPARENT);
      if HintList.Count > 0 then begin
         Canvas.Font.Color := HintColor;
         for i:=0 to HintList.Count-1 do begin
            Canvas.TextOut (hx+4, hy+3+(Canvas.TextHeight('A')+1)*i, HintList[i]);
         end;
      end;

      if g_MySelf <> nil then begin
          //显示持久
         if g_wginfo.boShowDura then begin
            SetBkMode (Canvas.Handle, TRANSPARENT);
            for I:=Low(g_UseItems) to High(g_UseItems) do begin
              infoMsg:=UseItem[I]+'：';
              if g_UseItems[I].S.Name<>'' then begin
                infoMsg:=infoMsg+Format(sTest2,[g_UseItems[I].S.Name,
                                        g_UseItems[I].Dura,
                                        g_UseItems[I].DuraMax,
                                        g_UseItems[I].MakeIndex]);
              end;
              BoldTextOut (MSurface,5,100+I*18, clWhite, clBlack,infoMsg );
            end;
            //Canvas.Release;
         end;

         if g_WgInfo.boShowGroupMember and g_ClientWgInfo.boShowGroupMember then begin
            for I:=0 to g_GroupMembers.Count-1 do begin
              if I=0 then begin
                BoldTextOut (MSurface,SCREENWIDTH-130,180,clRed, clBlack,'√');
                BoldTextOut (MSurface,SCREENWIDTH-115,180,clLime, clBlack,g_GroupMembers[I]);
              end else
                BoldTextOut (MSurface,SCREENWIDTH-115,180+I*18,clWhite, clBlack,g_GroupMembers[I]);
            end;
         end;
            {if g_GroupMembers.Count > 0 then begin
            d := g_WMainImages.Images[394];
            if d <> nil then begin
              for I:=0 to g_GroupMembers.Count-1 do
                DrawBlendEx (MSurface, 660, 180+I*20, d, 0, 0,100, 20, 0);
                //BoldTextOut  (MSurface,700,180+I*20,clWhite,clBlack,g_GroupMembers[I]);
            end;
         end; }

         //显示项部信息
         if g_wginfo.boShowTopInfo then begin
            //SetBkMode (Canvas.Handle, TRANSPARENT);
            if g_FocusCret<>nil then begin
              sName:=g_FocusCret.m_sUserName;
              nHp:=g_FocusCret.m_Abil.HP;
              nMp:=g_FocusCret.m_Abil.MaxHP;
            end else begin
              sName:='-/-';
              nHp:=0;
              nMp:=0;
            end;
            if g_MagicLockActor<>Nil then begin
              sName2:=g_MagicLockActor.m_sUserName;
              nHp2:=g_MagicLockActor.m_Abil.HP;
              nMp2:=g_MagicLockActor.m_Abil.MaxHP;
            end else begin
              sName2:='-/-';
              nHp2:=0;
              nMp2:=0;
            end;
            infoMsg:=Format(sTest1,[g_MySelf.m_Abil.Weight,
                                    g_MySelf.m_Abil.MaxWeight,
                                    g_MySelf.m_nGold,
                                    g_nMouseCurrX,
                                    g_nMouseCurrY,
                                    g_nMouseX,
                                    g_nMouseY,
                                    sName,nHp,nMp,sName2,nHp2,nMp2]);
            BoldTextOut (MSurface,5,0,clLime,clBlack,infoMsg );
            //Canvas.Release;
         end;
{$REGION '没用的'}
         //显示人物血量
         //BoldTextOut (MSurface, 15, SCREENHEIGHT - 120, clWhite, clBlack, IntToStr(g_MySelf.m_Abil.HP) + '/' + IntToStr(g_MySelf.m_Abil.MaxHP));
         //人物MP值
         //BoldTextOut (MSurface, 115, SCREENHEIGHT - 120, clWhite, clBlack, IntToStr(g_MySelf.m_Abil.MP) + '/' + IntToStr(g_MySelf.m_Abil.MaxMP));
         //人物经验值
         //BoldTextOut (MSurface, 655, SCREENHEIGHT - 55, clWhite, clBlack, IntToStr(g_MySelf.Abil.Exp) + '/' + IntToStr(g_MySelf.Abil.MaxExp));
         //人物背包重量
         //BoldTextOut (MSurface, 655, SCREENHEIGHT - 25, clWhite, clBlack, IntToStr(g_MySelf.Abil.Weight) + '/' + IntToStr(g_MySelf.Abil.MaxWeight));


        { if g_boShowGreenHint then begin
          str:= 'Time: ' + TimeToStr(Time) +
                ' Exp: ' + IntToStr(g_MySelf.m_Abil.Exp) + '/' + IntToStr(g_MySelf.m_Abil.MaxExp) +
                ' Weight: ' + IntToStr(g_MySelf.m_Abil.Weight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWeight) +
                ' ' + g_sGoldName + ': ' + IntToStr(g_MySelf.m_nGold) +
                ' Cursor: ' + IntToStr(g_nMouseCurrX) + ':' + IntToStr(g_nMouseCurrY) + '(' + IntToStr(g_nMouseX) + ':' + IntToStr(g_nMouseY) + ')';
          if g_FocusCret <> nil then begin
            str:= str + ' Target: ' + g_FocusCret.m_sUserName + '(' + IntToStr(g_FocusCret.m_Abil.HP) + '/' + IntToStr(g_FocusCret.m_Abil.MaxHP) + ')';
          end else begin
            str:= str + ' Target: -/-';
          end;

          BoldTextOut (MSurface, 10, 0, clLime , clBlack, str);

          str:='';
         end;  }

        { if g_boCheckBadMapMode then begin
              str := IntToStr(m_dwDrawFrameCount) +  ' '
              + '  Mouse ' + IntToStr(g_nMouseX) + ':' + IntToStr(g_nMouseY) + '(' + IntToStr(g_nMouseCurrX) + ':' + IntToStr(g_nMouseCurrY) + ')'
              + '  HP' + IntToStr(g_MySelf.m_Abil.HP) + '/' + IntToStr(g_MySelf.m_Abil.MaxHP)
              + '  D0 ' + IntToStr(g_nDebugCount)
              + ' D1 ' + IntToStr(g_nDebugCount1) + ' D2 '
              + IntToStr(g_nDebugCount2);
              BoldTextOut (MSurface, 10, 0, clWhite, clBlack, str);
         end;   }

         //old := Canvas.Font.Size;
         //Canvas.Font.Size := 8;
         //BoldTextOut (MSurface, 8, SCREENHEIGHT-42, clWhite, clBlack, ServerName);

        { if g_boShowWhiteHint then begin
           if g_MySelf.m_nGameGold > 10 then begin
             BoldTextOut (MSurface, 8, SCREENHEIGHT-42, clWhite, clBlack, g_sGameGoldName + ' ' + IntToStr(g_MySelf.m_nGameGold));
           end else begin
             BoldTextOut (MSurface, 8, SCREENHEIGHT-42, clRed, clBlack, g_sGameGoldName + ' ' + IntToStr(g_MySelf.m_nGameGold));
           end;
           if g_MySelf.m_nGamePoint > 10 then begin
             BoldTextOut (MSurface, 8, SCREENHEIGHT-58, clWhite, clBlack, g_sGamePointName + ' ' + IntToStr(g_MySelf.m_nGamePoint));
           end else begin
             BoldTextOut (MSurface, 8, SCREENHEIGHT-58, clRed, clBlack, g_sGamePointName + ' ' + IntToStr(g_MySelf.m_nGamePoint));
           end; }

         //鼠标所指坐标
         //BoldTextOut (MSurface, 115, SCREENHEIGHT - 40, clWhite, clBlack, IntToStr(g_nMouseCurrX) + ':' + IntToStr(g_nMouseCurrY));
         //显示时间
         //BoldTextOut (MSurface, 8, SCREENHEIGHT - 20, clWhite, clBlack, FormatDateTime('hh:mm:ss', Now));
         //end;

//         BoldTextOut (MSurface, 8, SCREENHEIGHT- 74, clWhite, clBlack, format('AllocMemCount:%d',[AllocMemCount]));
//         BoldTextOut (MSurface, 8, SCREENHEIGHT- 90, clWhite, clBlack, format('AllocMemSize:%d',[AllocMemSize div 1024]));
{$ENDREGION}
        if not g_nMiniMaxShow then
         begin
            BoldTextOut (MSurface, 28, SCREENHEIGHT - 37, clWhite, clBlack, IntToStr(g_MySelf.m_Abil.HP) + '/' + IntToStr(g_MySelf.m_Abil.MaxHP));
            BoldTextOut (MSurface, 89, SCREENHEIGHT - 37, clWhite, clBlack, IntToStr(g_MySelf.m_Abil.MP) + '/' + IntToStr(g_MySelf.m_Abil.MaxMP));
            BoldTextOut (MSurface, 672, SCREENHEIGHT - 21, clWhite, clBlack, FormatDateTime('hh:mm:ss', Now));
         end;
         BoldTextOut (MSurface, 8, SCREENHEIGHT-16, clWhite, clBlack, g_sMapTitle + ' ' + IntToStr(g_MySelf.m_nCurrX) + ':' + IntToStr(g_MySelf.m_nCurrY));
         //Canvas.Font.Size := old;
      end;
      //BoldTextOut (MSurface, 10, 20, clWhite, clBlack, IntToStr(DebugCount) + ' / ' + IntToStr(DebugCount1));
      Canvas.Release;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TDrawScreen.DrawHint'); //程序自动增加
End; //程序自动增加
end;


end.
