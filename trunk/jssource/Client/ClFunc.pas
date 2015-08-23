//CHECK
//��Ҫɾ����һ��ע�ͣ���ע��Ϊ�����ļ��Ƿ��ѱ��Զ������쳣����
unit ClFunc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXDraws, DirectX, DXClass, Grobal2, ExtCtrls, HUtil32, EdCode;


const
   DR_0      = 0;
   DR_1      = 1;
   DR_2      = 2;
   DR_3      = 3;
   DR_4      = 4;
   DR_5      = 5;
   DR_6      = 6;
   DR_7      = 7;
   DR_8      = 8;
   DR_9      = 9;
   DR_10      = 10;
   DR_11      = 11;
   DR_12      = 12;
   DR_13      = 13;
   DR_14      = 14;
   DR_15      = 15;

type
   TDynamicObject = record  //�ٴڿ� ����
      X: integer;  //ĳ�� ��ǥ��
      Y: integer;
      px: integer;  //shiftx ,y
      py: integer;
      DSurface: TDirectDrawSurface;
   end;
   PTDynamicObject = ^TDynamicObject;


var
   DropItems: TList;  //lsit of TClientItem

function  fmStr (str: string; len: integer): string;
function  GetGoldStr (gold: integer): string;
procedure SaveBags (flname: string; pbuf: Pbyte);
procedure Loadbags (flname: string; pbuf: Pbyte);
procedure ClearBag;
procedure DelShopItem(nItemidx:Integer;sItemName:String);
procedure DelShopItemEx(nItemidx:Integer);
function  CheckHeroEatItem(cu: TClientItem):Boolean;
function  AddItemBag (cu: TClientItem): Boolean;
function  AddItemHeroBag (cu: TClientItem): Boolean;
function  UpdateItemBag (cu: TClientItem): Boolean;
function  DelItemBag (iname: string; iindex: integer): Boolean;
function  DelHeroItemBag (iname: string; iindex: integer): Boolean;
procedure ArrangeItemBag;
procedure ArrangeItemHeroBag;
procedure AddDropItem (ci: TClientItem);
function  GetDropItem (iname: string; MakeIndex: integer): PTClientItem;
procedure DelDropItem (iname: string; MakeIndex: integer);
procedure AddDealItem (ci: TClientItem);
procedure DelDealItem (ci: TClientItem);
procedure MoveDealItemToBag;
procedure MoveChallengeToBag;
procedure AddDealRemoteItem (ci: TClientItem);
procedure DelDealRemoteItem (ci: TClientItem);
function  GetDistance (sx, sy, dx, dy: integer): integer;
function  CheckBeeline(nX,nY,sX,sY:Integer):Boolean;
procedure GetNextPosXY (dir: byte; var x, y:Integer);
procedure GetNextRunXY (dir: byte; var x, y:Integer);
procedure GetNextHorseRunXY (dir: byte; var x, y:Integer);
function  GetNextDirection (sx, sy, dx, dy: Integer): byte;
function  GetNextPosition(sx, sy, ndir,nFlag:Integer;var snx:Integer;var sny:Integer):Boolean;
function  GetBack (dir: integer): integer;
procedure GetBackPosition (sx, sy, dir: integer; var newx, newy: integer);
procedure GetFrontPosition (sx, sy, dir: integer; var newx, newy: integer);
function  GetFlyDirection (sx, sy, ttx, tty: integer): Integer;
function  GetFlyDirection16 (sx, sy, ttx, tty: integer): Integer;
function  PrivDir (ndir: integer): integer;
function  NextDir (ndir: integer): integer;
procedure BoldTextOut (surface: TDirectDrawSurface; x, y, fcolor, bcolor: integer; str: string);
procedure BoldTextOutEx (surface: TDirectDrawSurface; x, y,Size, fcolor, bcolor: integer; str: string;Name:TFontName);
function  GetTakeOnPosition (smode: integer): integer;
function  GetLevelPosition (smode: integer): Boolean;
function  IsKeyPressed (key: byte): Boolean;

procedure AddChangeFace (recogid: integer);
procedure DelChangeFace (recogid: integer);
function  IsChangingFace (recogid: integer): Boolean;

implementation

uses
   clMain, MShare, Share;


function fmStr (str: string; len: integer): string;
var i: integer;
begin
Try //�����Զ�����
try
   Result := str + ' ';
   for i:=1 to len - Length(str)-1 do
      Result := Result + ' ';
except
	Result := str + ' ';
end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.fmStr'); //�����Զ�����
End; //�����Զ�����
end;

function  GetGoldStr (gold: integer): string;
var
   i, n: integer;
   str: string;
begin
Try //�����Զ�����
   str := IntToStr (gold);
   n := 0;
   Result := '';
   for i:=Length(str) downto 1 do begin
      if n = 3 then begin
         Result := str[i] + ',' + Result;
         n := 1;
      end else begin
         Result := str[i] + Result;
         Inc(n);
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.GetGoldStr'); //�����Զ�����
End; //�����Զ�����
end;

procedure SaveBags (flname: string; pbuf: Pbyte);
var
   fhandle: integer;
begin
Try //�����Զ�����
   if FileExists (flname) then
      fhandle := FileOpen (flname, fmOpenWrite or fmShareDenyNone)
   else fhandle := FileCreate (flname);
   if fhandle > 0 then begin
      FileWrite (fhandle, pbuf^, sizeof(TClientItem) * MAXBAGITEMCL);
      FileClose (fhandle);
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.SaveBags'); //�����Զ�����
End; //�����Զ�����
end;

procedure Loadbags (flname: string; pbuf: Pbyte);
var
   fhandle: integer;
begin
Try //�����Զ�����
   if FileExists (flname) then begin
      fhandle := FileOpen (flname, fmOpenRead or fmShareDenyNone);
      if fhandle > 0 then begin
         FileRead (fhandle, pbuf^, sizeof(TClientItem) * MAXBAGITEMCL);
         FileClose (fhandle);
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.Loadbags'); //�����Զ�����
End; //�����Զ�����
end;

procedure ClearBag;
var
   i: integer;
begin
Try //�����Զ�����
   for i:=0 to MAXBAGITEMCL-1 do
      g_ItemArr[i].S.Name := '';
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.ClearBag'); //�����Զ�����
End; //�����Զ�����
end;

function  CheckHeroEatItem(cu: TClientItem):Boolean;
begin
Try //�����Զ�����
  Result:=False;
  if cu.S.StdMode = 4 then Result:=True;
  if (cu.S.StdMode = 31) and (cu.S.Shape>0) then Result:=True;
  if cu.S.StdMode = 0 then Result:=True;
  if (cu.S.StdMode = 2) and (cu.S.Shape=9) then Result:=True;
  if cu.S.StdMode = 60 then Result:=True;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.CheckHeroEatItem'); //�����Զ�����
End; //�����Զ�����
end;

function  AddItemHeroBag (cu: TClientItem): Boolean;
var
   i: integer;
begin
Try //�����Զ�����
   Result := FALSE;
   for i:=0 to MAXBAGITEMCL-1 do begin
      if (g_HeroItemArr[i].MakeIndex = cu.MakeIndex) and (g_HeroItemArr[i].S.Name = cu.S.Name) then begin
         exit;
      end;
   end;

   if cu.S.Name = '' then exit;
   {if cu.S.StdMode <= 3 then begin
      for i:=0 to 5 do
         if g_HeroItemArr[i].S.Name = '' then begin
            g_HeroItemArr[i] := cu;
            Result := TRUE;
            exit;
         end;
   end;  }
   for i:=6 to MAXBAGITEMCL-1 do begin
      if g_HeroItemArr[i].S.Name = '' then begin
         g_HeroItemArr[i] := cu;
         Result := TRUE;
         break;
      end;
   end;
   ArrangeItemHerobag;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.AddItemHeroBag'); //�����Զ�����
End; //�����Զ�����
end;

procedure DelShopItemEx(nItemidx:Integer);
var
  i:integer;
begin
Try //�����Զ�����
  for i:=Low(g_ShopItems) to High(g_ShopItems) do begin
    if (g_ShopItems[I].Item.MakeIndex=nItemidx) then begin
      g_ShopItems[I].Item.S.Name:='';
      break;
    end;
  end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.DelShopItemEx'); //�����Զ�����
End; //�����Զ�����
end;

procedure DelShopItem(nItemidx:Integer;sItemName:String);
var
  i:integer;
begin
Try //�����Զ�����
  for i:=Low(g_ShopItems2) to High(g_ShopItems2) do begin
    if (g_ShopItems2[I].Item.MakeIndex=nItemidx) then begin
      g_ShopItems2[I].Item.S.Name:='';
      break;
    end;
  end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.DelShopItem'); //�����Զ�����
End; //�����Զ�����
end;

function  AddItemBag (cu: TClientItem): Boolean;
var
   i: integer;
begin
Try //�����Զ�����
   Result := FALSE;
   //���� ���̵��� �������� ��� ����. (�ܻ����)
   for i:=0 to MAXBAGITEMCL-1 do begin
      if (g_ItemArr[i].MakeIndex = cu.MakeIndex) and (g_ItemArr[i].S.Name = cu.S.Name) then begin
         exit;  //�ܻ�..
      end;
   end;

   if cu.S.Name = '' then exit;
   if (cu.S.StdMode < 4) and (cu.S.Reserved<>56) then begin //����, ����, ��ũ��
      for i:=0 to 5 do
         if g_ItemArr[i].S.Name = '' then begin
            g_ItemArr[i] := cu;
            Result := TRUE;
            exit;
         end;
   end;
   for i:=6 to MAXBAGITEMCL-1 do begin
      if g_ItemArr[i].S.Name = '' then begin
         g_ItemArr[i] := cu;
         Result := TRUE;
         break;
      end;
   end;
   ArrangeItembag;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.AddItemBag'); //�����Զ�����
End; //�����Զ�����
end;

function  UpdateItemBag (cu: TClientItem): Boolean;
var
   i: integer;
begin
Try //�����Զ�����
   Result := FALSE;
   for i:=MAXBAGITEMCL-1 downto 0 do begin
      if (g_ItemArr[i].S.Name = cu.S.Name) and (g_ItemArr[i].MakeIndex = cu.MakeIndex) then begin
         g_ItemArr[i] := cu;  //������Ʈ
         Result := TRUE;
         break;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.UpdateItemBag'); //�����Զ�����
End; //�����Զ�����
end;

function  DelHeroItemBag (iname: string; iindex: integer): Boolean;
var
   i: integer;
begin
Try //�����Զ�����
   Result := FALSE;
   for i:=MAXBAGITEMCL-1 downto 0 do begin
      if (g_HeroItemArr[i].S.Name = iname) and (g_HeroItemArr[i].MakeIndex = iindex) then begin
         FillChar (g_HeroItemArr[i], sizeof(TClientItem), #0);
         Result := TRUE;
         break;
      end;
   end;
   ArrangeItemHerobag;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.DelHeroItemBag'); //�����Զ�����
End; //�����Զ�����
end;

function  DelItemBag (iname: string; iindex: integer): Boolean;
var
   i: integer;
begin
Try //�����Զ�����
   Result := FALSE;
   for i:=MAXBAGITEMCL-1 downto 0 do begin
      //DScreen.AddChatBoardString (g_ItemArr[i].S.Name +'|'+ iname, GetRGB(255), GetRGB(0));
      if (g_ItemArr[i].S.Name = iname) and (g_ItemArr[i].MakeIndex = iindex) then begin
         FillChar (g_ItemArr[i], sizeof(TClientItem), #0);
         Result := TRUE;
         break;
      end;
   end;
   ArrangeItembag;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.DelItemBag'); //�����Զ�����
End; //�����Զ�����
end;

procedure ArrangeItemHeroBag;
var
   i, k: integer;
begin
Try //�����Զ�����
   for i:=0 to MAXBAGITEMCL-1 do begin
      if g_HeroItemArr[i].S.Name <> '' then begin
         for k:=i+1 to MAXBAGITEMCL-1 do begin
            if (g_HeroItemArr[i].S.Name = g_HeroItemArr[k].S.Name) and (g_HeroItemArr[i].MakeIndex = g_HeroItemArr[k].MakeIndex) then begin
               FillChar (g_HeroItemArr[k], sizeof(TClientItem), #0);
            end;
         end;
         if (g_HeroItemArr[i].S.Name = g_MovingItem.Item.S.Name) and (g_HeroItemArr[i].MakeIndex = g_MovingItem.Item.MakeIndex) then begin
            g_MovingItem.Index := 0;
            g_MovingItem.Item.S.Name := '';
         end;
      end;
   end;
   for i:=46 to MAXBAGITEMCL-1 do begin
      if g_HeroItemArr[i].S.Name <> '' then begin
         for k:=6 to 45 do begin
            if g_HeroItemArr[k].S.Name = '' then begin
               g_HeroItemArr[k] := g_HeroItemArr[i];
               g_HeroItemArr[i].S.Name := '';
               break;
            end;
         end;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.ArrangeItemHeroBag'); //�����Զ�����
End; //�����Զ�����
end;

procedure ArrangeItemBag;
var
   i, k: integer;
begin
Try //�����Զ�����
   //�ߺ��� �������� ������ ���ش�.
   for i:=0 to MAXBAGITEMCL-1 do begin
      if g_ItemArr[i].S.Name <> '' then begin
         for k:=i+1 to MAXBAGITEMCL-1 do begin
            if (g_ItemArr[i].S.Name = g_ItemArr[k].S.Name) and (g_ItemArr[i].MakeIndex = g_ItemArr[k].MakeIndex) then begin
               FillChar (g_ItemArr[k], sizeof(TClientItem), #0);
            end;
         end;
         {for k:=0 to 9 do begin
            if (ItemArr[i].S.Name = DealItems[k].S.Name) and (ItemArr[i].MakeIndex = DealItems[k].MakeIndex) then begin
               FillChar (ItemArr[i], sizeof(TClientItem), #0);
               //FillChar (DealItems[k], sizeof(TClientItem), #0);
            end;
         end; }
         if (g_ItemArr[i].S.Name = g_MovingItem.Item.S.Name) and (g_ItemArr[i].MakeIndex = g_MovingItem.Item.MakeIndex) then begin
            g_MovingItem.Index := 0;
            g_MovingItem.Item.S.Name := '';
         end;
      end;
   end;

   //������ �Ⱥ��̴� �κп� ������ ���� �ø���.
   for i:=46 to MAXBAGITEMCL-1 do begin
      if g_ItemArr[i].S.Name <> '' then begin
         for k:=6 to 45 do begin
            if g_ItemArr[k].S.Name = '' then begin
               g_ItemArr[k] := g_ItemArr[i];
               g_ItemArr[i].S.Name := '';
               break;
            end;
         end;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.ArrangeItemBag'); //�����Զ�����
End; //�����Զ�����
end;

{----------------------------------------------------------}

procedure AddDropItem (ci: TClientItem);
var
   pc: PTClientItem;
begin
Try //�����Զ�����
   new (pc);
   pc^ := ci;
   DropItems.Add (pc);
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.AddDropItem'); //�����Զ�����
End; //�����Զ�����
end;

function  GetDropItem (iname: string; MakeIndex: integer): PTClientItem;
var
   i: integer;
begin
Try //�����Զ�����
   Result := nil;
   for i:=0 to DropItems.Count-1 do begin
      if (PTClientItem(DropItems[i]).S.Name = iname) and (PTClientItem(DropItems[i]).MakeIndex = MakeIndex) then begin
         Result := PTClientItem(DropItems[i]);
         break;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.GetDropItem'); //�����Զ�����
End; //�����Զ�����
end;

procedure DelDropItem (iname: string; MakeIndex: integer);
var
   i: integer;
begin
Try //�����Զ�����
   for i:=0 to DropItems.Count-1 do begin
      if (PTClientItem(DropItems[i]).S.Name = iname) and (PTClientItem(DropItems[i]).MakeIndex = MakeIndex) then begin
         Dispose (PTClientItem(DropItems[i]));
         DropItems.Delete (i);
         break;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.DelDropItem'); //�����Զ�����
End; //�����Զ�����
end;

{----------------------------------------------------------}

procedure AddDealItem (ci: TClientItem);
var
   i: integer;
begin
Try //�����Զ�����
   for i:=0 to 10-1 do begin
      if g_DealItems[i].S.Name = '' then begin
         g_DealItems[i] := ci;
         break;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.AddDealItem'); //�����Զ�����
End; //�����Զ�����
end;

procedure DelDealItem (ci: TClientItem);
var
   i: integer;
begin
Try //�����Զ�����
   for i:=0 to 10-1 do begin
      if (g_DealItems[i].S.Name = ci.S.Name) and (g_DealItems[i].MakeIndex = ci.MakeIndex) then begin
         FillChar (g_DealItems[i], sizeof(TClientItem), #0);
         break;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.DelDealItem'); //�����Զ�����
End; //�����Զ�����
end;

procedure MoveDealItemToBag;
var
   i: integer;
begin
Try //�����Զ�����
   for i:=0 to 10-1 do begin
      if g_DealItems[i].S.Name <> '' then
         AddItemBag (g_DealItems[i]);
   end;
   FillChar (g_DealItems, sizeof(TClientItem)*10, #0);
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.MoveDealItemToBag'); //�����Զ�����
End; //�����Զ�����
end;

procedure MoveChallengeToBag;
var
i:integer;
begin
try
    for I := Low(g_ChallengeItems1) to High(g_ChallengeItems1) do
     if g_ChallengeItems1[i].S.Name <> '' then
      AddItemBag(g_ChallengeItems1[i]);
Except
  DebugOutStr('[Exception] UnClFunc.MoveChallengeToBag');
End;
end;

procedure AddDealRemoteItem (ci: TClientItem);
var
   i: integer;
begin
Try //�����Զ�����
   for i:=0 to 20-1 do begin
      if g_DealRemoteItems[i].S.Name = '' then begin
         g_DealRemoteItems[i] := ci;
         break;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.AddDealRemoteItem'); //�����Զ�����
End; //�����Զ�����
end;

procedure DelDealRemoteItem (ci: TClientItem);
var
   i: integer;
begin
Try //�����Զ�����
   for i:=0 to 20-1 do begin
      if (g_DealRemoteItems[i].S.Name = ci.S.Name) and (g_DealRemoteItems[i].MakeIndex = ci.MakeIndex) then begin
         FillChar (g_DealRemoteItems[i], sizeof(TClientItem), #0);
         break;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.DelDealRemoteItem'); //�����Զ�����
End; //�����Զ�����
end;

{----------------------------------------------------------}

function  GetDistance (sx, sy, dx, dy: integer): integer;
begin
Try //�����Զ�����
   Result := _MAX(abs(sx-dx), abs(sy-dy));
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.GetDistance'); //�����Զ�����
End; //�����Զ�����
end;

//����Ƿ���ͬһֱ����
function CheckBeeline(nX,nY,sX,sY:Integer):Boolean;
begin
  Result:=False;
  if nX=sX then Result:=True;
  if nY=sY then Result:=True;
  if abs(nX-sX)=abs(nY-sY) then Result:=True;
end;

procedure GetNextPosXY (dir: byte; var x, y:Integer);
begin
Try //�����Զ�����
   case dir of
      DR_UP:     begin x := x;   y := y-1; end;
      DR_UPRIGHT:   begin x := x+1; y := y-1; end;
      DR_RIGHT:  begin x := x+1; y := y; end;
      DR_DOWNRIGHT:  begin x := x+1; y := y+1; end;
      DR_DOWN:   begin x := x;   y := y+1; end;
      DR_DOWNLEFT:   begin x := x-1; y := y+1; end;
      DR_LEFT:   begin x := x-1; y := y; end;
      DR_UPLEFT:  begin x := x-1; y := y-1; end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.GetNextPosXY'); //�����Զ�����
End; //�����Զ�����
end;

procedure GetNextRunXY (dir: byte; var x, y:Integer);
begin
Try //�����Զ�����
   case dir of
      DR_UP:     begin x := x;   y := y-2; end;
      DR_UPRIGHT:   begin x := x+2; y := y-2; end;
      DR_RIGHT:  begin x := x+2; y := y; end;
      DR_DOWNRIGHT:  begin x := x+2; y := y+2; end;
      DR_DOWN:   begin x := x;   y := y+2; end;
      DR_DOWNLEFT:   begin x := x-2; y := y+2; end;
      DR_LEFT:   begin x := x-2; y := y; end;
      DR_UPLEFT:  begin x := x-2; y := y-2; end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.GetNextRunXY'); //�����Զ�����
End; //�����Զ�����
end;
procedure GetNextHorseRunXY (dir: byte; var x, y:Integer);
begin
Try //�����Զ�����
   case dir of
      DR_UP:     begin x := x;   y := y-3; end;
      DR_UPRIGHT:   begin x := x+3; y := y-3; end;
      DR_RIGHT:  begin x := x+3; y := y; end;
      DR_DOWNRIGHT:  begin x := x+3; y := y+3; end;
      DR_DOWN:   begin x := x;   y := y+3; end;
      DR_DOWNLEFT:   begin x := x-3; y := y+3; end;
      DR_LEFT:   begin x := x-3; y := y; end;
      DR_UPLEFT:  begin x := x-3; y := y-3; end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.GetNextHorseRunXY'); //�����Զ�����
End; //�����Զ�����
end;
function GetNextDirection (sx, sy, dx, dy: Integer): byte;
var
   flagx, flagy: integer;
begin
Try //�����Զ�����
   Result := DR_DOWN;
   if sx < dx then flagx := 1
   else if sx = dx then flagx := 0
   else flagx := -1;
   if abs(sy-dy) > 2
    then if (sx >= dx-1) and (sx <= dx+1) then flagx := 0;

   if sy < dy then flagy := 1
   else if sy = dy then flagy := 0
   else flagy := -1;
   if abs(sx-dx) > 2 then if (sy > dy-1) and (sy <= dy+1) then flagy := 0;

   if (flagx = 0)  and (flagy = -1) then Result := DR_UP;
   if (flagx = 1)  and (flagy = -1) then Result := DR_UPRIGHT;
   if (flagx = 1)  and (flagy = 0)  then Result := DR_RIGHT;
   if (flagx = 1)  and (flagy = 1)  then Result := DR_DOWNRIGHT;
   if (flagx = 0)  and (flagy = 1)  then Result := DR_DOWN;
   if (flagx = -1) and (flagy = 1)  then Result := DR_DOWNLEFT;
   if (flagx = -1) and (flagy = 0)  then Result := DR_LEFT;
   if (flagx = -1) and (flagy = -1) then Result := DR_UPLEFT;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.GetNextDirection'); //�����Զ�����
End; //�����Զ�����
end;

function  GetBack (dir: integer): integer;
begin
Try //�����Զ�����
   Result := DR_UP;
   case dir of
      DR_UP:     Result := DR_DOWN;
      DR_DOWN:   Result := DR_UP;
      DR_LEFT:   Result := DR_RIGHT;
      DR_RIGHT:  Result := DR_LEFT;
      DR_UPLEFT:     Result := DR_DOWNRIGHT;
      DR_UPRIGHT:    Result := DR_DOWNLEFT;
      DR_DOWNLEFT:   Result := DR_UPRIGHT;
      DR_DOWNRIGHT:  Result := DR_UPLEFT;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.GetBack'); //�����Զ�����
End; //�����Զ�����
end;

procedure GetBackPosition (sx, sy, dir: integer; var newx, newy: integer);
begin
Try //�����Զ�����
   newx := sx;
   newy := sy;
   case dir of
      DR_UP:      newy := newy+1;
      DR_DOWN:    newy := newy-1;
      DR_LEFT:    newx := newx+1;
      DR_RIGHT:   newx := newx-1;
      DR_UPLEFT:
         begin
            newx := newx + 1;
            newy := newy + 1;
         end;
      DR_UPRIGHT:
         begin
            newx := newx - 1;
            newy := newy + 1;
         end;
      DR_DOWNLEFT:
         begin
            newx := newx + 1;
            newy := newy - 1;
         end;
      DR_DOWNRIGHT:
         begin
            newx := newx - 1;
            newy := newy - 1;
         end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.GetBackPosition'); //�����Զ�����
End; //�����Զ�����
end;

procedure GetFrontPosition (sx, sy, dir: integer; var newx, newy: integer);
begin
Try //�����Զ�����
   newx := sx;
   newy := sy;
   case dir of
      DR_UP:      newy := newy-1;
      DR_DOWN:    newy := newy+1;
      DR_LEFT:    newx := newx-1;
      DR_RIGHT:   newx := newx+1;
      DR_UPLEFT:
         begin
            newx := newx - 1;
            newy := newy - 1;
         end;
      DR_UPRIGHT:
         begin
            newx := newx + 1;
            newy := newy - 1;
         end;
      DR_DOWNLEFT:
         begin
            newx := newx - 1;
            newy := newy + 1;
         end;
      DR_DOWNRIGHT:
         begin
            newx := newx + 1;
            newy := newy + 1;
         end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.GetFrontPosition'); //�����Զ�����
End; //�����Զ�����
end;

function  GetFlyDirection (sx, sy, ttx, tty: integer): Integer;
var
   fx, fy: Real;
begin
Try //�����Զ�����
   fx := ttx - sx;
   fy := tty - sy;
   sx := 0;
   sy := 0;
   Result := DR_DOWN;
   if fx=0 then begin
      if fy < 0 then Result := DR_UP
      else Result := DR_DOWN;
      exit;
   end;
   if fy=0 then begin
      if fx < 0 then Result := DR_LEFT
      else Result := DR_RIGHT;
      exit;
   end;
   if (fx > 0) and (fy < 0) then begin
      if -fy > fx*2.5 then Result := DR_UP
      else if -fy < fx/3 then Result := DR_RIGHT
      else Result := DR_UPRIGHT;
   end;
   if (fx > 0) and (fy > 0) then begin
      if fy < fx/3 then Result := DR_RIGHT
      else if fy > fx*2.5 then Result := DR_DOWN
      else Result := DR_DOWNRIGHT;
   end;
   if (fx < 0) and (fy > 0) then begin
      if fy  < -fx/3 then Result := DR_LEFT
      else if fy > -fx*2.5 then Result := DR_DOWN
      else Result := DR_DOWNLEFT;
   end;
   if (fx < 0) and (fy < 0) then begin
      if -fy > -fx*2.5 then Result := DR_UP
      else if -fy < -fx/3 then Result := DR_LEFT
      else Result := DR_UPLEFT;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.GetFlyDirection'); //�����Զ�����
End; //�����Զ�����
end;

function  GetFlyDirection16 (sx, sy, ttx, tty: integer): Integer;
var
   fx, fy: Real;
begin
Try //�����Զ�����
   fx := ttx - sx;
   fy := tty - sy;
   sx := 0;
   sy := 0;
   Result := 0;
   if fx=0 then begin
      if fy < 0 then Result := 0
      else Result := 8;
      exit;
   end;
   if fy=0 then begin
      if fx < 0 then Result := 12
      else Result := 4;
      exit;
   end;
   if (fx > 0) and (fy < 0) then begin
      Result := 4;
      if -fy > fx/4 then Result := 3;
      if -fy > fx/1.9 then Result := 2;
      if -fy > fx*1.4 then Result := 1;
      if -fy > fx*4 then Result := 0;
   end;
   if (fx > 0) and (fy > 0) then begin
      Result := 4;
      if fy > fx/4 then Result := 5;
      if fy > fx/1.9 then Result := 6;
      if fy > fx*1.4 then Result := 7;
      if fy > fx*4 then Result := 8;
   end;
   if (fx < 0) and (fy > 0) then begin
      Result := 12;
      if fy > -fx/4 then Result := 11;
      if fy > -fx/1.9 then Result := 10;
      if fy > -fx*1.4 then Result := 9;
      if fy > -fx*4 then Result := 8;
   end;
   if (fx < 0) and (fy < 0) then begin
      Result := 12;
      if -fy > -fx/4 then Result := 13;
      if -fy > -fx/1.9 then Result := 14;
      if -fy > -fx*1.4 then Result := 15;
      if -fy > -fx*4 then Result := 0;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.GetFlyDirection16'); //�����Զ�����
End; //�����Զ�����
end;

function  PrivDir (ndir: integer): integer;
begin
Try //�����Զ�����
   if ndir - 1 < 0 then Result := 7
   else Result := ndir-1;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.PrivDir'); //�����Զ�����
End; //�����Զ�����
end;

function  NextDir (ndir: integer): integer;
begin
Try //�����Զ�����
   if ndir + 1 > 7 then Result := 0
   else Result := ndir+1;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.NextDir'); //�����Զ�����
End; //�����Զ�����
end;

procedure BoldTextOutEx (surface: TDirectDrawSurface; x, y,Size, fcolor, bcolor: integer; str: string;Name:TFontName);

begin
Try //�����Զ�����
   with surface do begin

      Canvas.Font.Color := bcolor;
      Canvas.TextOut (x-1, y, str);
      Canvas.TextOut (x+1, y, str);
      Canvas.TextOut (x, y-1, str);
      Canvas.TextOut (x, y+1, str);
      Canvas.Font.Color := fcolor;
      Canvas.TextOut (x, y, str);
      
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.BoldTextOutEx'); //�����Զ�����
End; //�����Զ�����
end;

procedure BoldTextOut (surface: TDirectDrawSurface; x, y, fcolor, bcolor: integer; str: string);
begin
Try //�����Զ�����
   with surface do begin
      Canvas.Font.Color := bcolor;
      Canvas.TextOut (x-1, y, str);
      Canvas.TextOut (x+1, y, str);
      Canvas.TextOut (x, y-1, str);
      Canvas.TextOut (x, y+1, str);
      Canvas.Font.Color := fcolor;
      Canvas.TextOut (x, y, str);
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.BoldTextOut'); //�����Զ�����
End; //�����Զ�����
end;

function  GetTakeOnPosition (smode: integer): integer;
begin
Try //�����Զ�����
   Result := -1;
   case smode of //StdMode
      5, 6     :Result := U_WEAPON;//����
      10, 11   :Result := U_DRESS;
      15       :Result := U_HELMET;
      19,20,21 :Result := U_NECKLACE;
      22,23    :Result := U_RINGL;
      24,26    :Result := U_ARMRINGL;
      30       :Result := U_RIGHTHAND;
      25,2,42  :Result := U_BUJUK; //��
      52,62,28 :Result := U_BOOTS; //Ь
      53,63,7,29  :Result := U_CHARM; //��ʯ
      54,64,27 :Result := U_BELT;  //����
      16       :Result := U_STRAW;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.GetTakeOnPosition'); //�����Զ�����
End; //�����Զ�����
end;

function  GetLevelPosition (smode: integer): Boolean;
begin
Try //�����Զ�����
   Result := False;
   case smode of
      5,6,10,11,15,19,20,21,22,23,24,26,30,62,28,63,64,27,16
      : Result:=True;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.GetLevelPosition'); //�����Զ�����
End; //�����Զ�����
end;

function  IsKeyPressed (key: byte): Boolean;
var
   keyvalue: TKeyBoardState;
begin
Try //�����Զ�����
   Result := FALSE;
   FillChar(keyvalue, sizeof(TKeyboardState), #0);
   if GetKeyboardState (keyvalue) then
      if (keyvalue[key] and $80) <> 0 then
         Result := TRUE;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.IsKeyPressed'); //�����Զ�����
End; //�����Զ�����
end;

procedure AddChangeFace (recogid: integer);
begin
Try //�����Զ�����
   g_ChangeFaceReadyList.Add (pointer(recogid));
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.AddChangeFace'); //�����Զ�����
End; //�����Զ�����
end;

procedure DelChangeFace (recogid: integer);
var
   i: integer;
begin
Try //�����Զ�����
   for i:=0 to g_ChangeFaceReadyList.Count-1 do begin
      if integer(g_ChangeFaceReadyList[i]) = recogid then begin
         g_ChangeFaceReadyList.Delete (i);
         break;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.DelChangeFace'); //�����Զ�����
End; //�����Զ�����
end;

function  IsChangingFace (recogid: integer): Boolean;
var
   i: integer;
begin
Try //�����Զ�����
   Result := FALSE;
   for i:=0 to g_ChangeFaceReadyList.Count-1 do begin
      if integer(g_ChangeFaceReadyList[i]) = recogid then begin
         Result := TRUE;
         break;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.IsChangingFace'); //�����Զ�����
End; //�����Զ�����
end;

function GetNextPosition(sx, sy, ndir,nFlag:Integer;var snx:Integer;var sny:Integer):Boolean;
begin
Try //�����Զ�����
   snx := sx;
   sny := sy;
   case nDir of
     DR_UP: if sny > nFlag - 1 then Dec(sny,nFlag);
     DR_DOWN: if sny < (nWidth - nFlag) then Inc(sny,nFlag);
     DR_LEFT: if snx > nFlag - 1 then Dec(snx,nFlag);
     DR_RIGHT: if snx < (nWidth - nFlag) then Inc(snx,nFlag);
     DR_UPLEFT: begin
       if (snx > nFlag - 1) and (sny > nFlag - 1) then begin
         Dec(snx,nFlag);
         Dec(sny,nFlag);
       end;
     end;
     DR_UPRIGHT: begin //004B2B77
       if (snx > nFlag - 1) and (sny < (nHeight - nFlag)) then begin
         Inc(snx,nFlag);
         Dec(sny,nFlag);
       end;
     end;
     DR_DOWNLEFT: begin //004B2BAC
       if (snx < (nWidth - nFlag)) and (sny > nFlag - 1) then begin
         Dec(snx,nFlag);
         Inc(sny,nFlag);
       end;
     end;
     DR_DOWNRIGHT: begin
       if (snx < (nWidth - nFlag)) and (sny < (nHeight - nFlag)) then begin
         Inc(snx,nFlag);
         Inc(sny,nFlag);
       end;
     end;
   end;
   if (snx = sx) and (sny = sy) then Result:=False
   else Result:=True;
Except //�����Զ�����
  DebugOutStr('[Exception] UnClFunc.GetNextPosition'); //�����Զ�����
End; //�����Զ�����
end;


Initialization
DropItems := TList.Create;

Finalization
DropItems.Free;


end.
