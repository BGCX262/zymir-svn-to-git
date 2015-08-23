unit ClFunc;
//����������
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXDraws, DirectX, DXClass, Grobal2, ScktComp, ExtCtrls, HUtil32, EdCode;


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
   TDynamicObject = record
      X: integer;           //λ��
      Y: integer;
      px: integer;          //shift x ,y
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
function  AddItemBag (cu: TClientItem): Boolean;
function  UpdateItemBag (cu: TClientItem): Boolean;
function  DelItemBag (iname: string; iindex: integer): Boolean;
procedure ArrangeItemBag;
procedure AddDropItem (ci: TClientItem);
function  GetDropItem (iname: string; MakeIndex: integer): PTClientItem;
procedure DelDropItem (iname: string; MakeIndex: integer);
procedure AddDealItem (ci: TClientItem);
procedure DelDealItem (ci: TClientItem);
procedure MoveDealItemToBag;
procedure AddDealRemoteItem (ci: TClientItem);
procedure DelDealRemoteItem (ci: TClientItem);
function  GetDistance (sx, sy, dx, dy: integer): integer;
procedure GetNextPosXY (dir: byte; var x, y:Integer);
procedure GetNextRunXY (dir: byte; var x, y:Integer);
function  GetNextDirection (sx, sy, dx, dy: Integer): byte;
function  GetBack (dir: integer): integer;
procedure GetBackPosition (sx, sy, dir: integer; var newx, newy: integer);
procedure GetFrontPosition (sx, sy, dir: integer; var newx, newy: integer);
function  GetFlyDirection (sx, sy, ttx, tty: integer): Integer;
function  GetFlyDirection16 (sx, sy, ttx, tty: integer): Integer;
function  PrivDir (ndir: integer): integer;
function  NextDir (ndir: integer): integer;
procedure BoldTextOut (surface: TDirectDrawSurface; x, y, fcolor, bcolor: integer; str: string);
function  GetTakeOnPosition (smode: integer): integer;
function  IsKeyPressed (key: byte): Boolean;

procedure AddChangeFace (recogid: integer);
procedure DelChangeFace (recogid: integer);
function  IsChangingFace (recogid: integer): Boolean;

implementation

uses
   clMain;

//��ʽ���ַ���Ϊָ�����ȣ�������ո�
function fmStr (str: string; len: integer): string;
var i: integer;
begin
try
   Result := str + ' ';
   for i:=1 to len - Length(str)-1 do
      Result := Result + ' ';
except
   Result := str + ' ';
end;
end;

//����ת��Ϊǧλ�����ŵ��ַ���������1234567ת��Ϊ��1,234,567��
//����������ʾ��Ǯ����
function  GetGoldStr (gold: integer): string;
var
   i, n: integer;
   str: string;
begin
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
end;

//����װ����Ʒ���ļ�
procedure SaveBags (flname: string; pbuf: Pbyte);
var
   fhandle: integer;
begin
   if FileExists (flname) then
      fhandle := FileOpen (flname, fmOpenWrite or fmShareDenyNone)
   else fhandle := FileCreate (flname);
   if fhandle > 0 then begin
      FileWrite (fhandle, pbuf^, sizeof(TClientItem) * MAXBAGITEMCL);
      FileClose (fhandle);
   end;
end;

//װ��װ����Ʒ
procedure Loadbags (flname: string; pbuf: Pbyte);
var
   fhandle: integer;
begin
   if FileExists (flname) then begin
      fhandle := FileOpen (flname, fmOpenRead or fmShareDenyNone);
      if fhandle > 0 then begin
         FileRead (fhandle, pbuf^, sizeof(TClientItem) * MAXBAGITEMCL);
         FileClose (fhandle);
      end;
   end;
end;

//�����Ʒ
procedure ClearBag;
var
   i: integer;
begin
   for i:=0 to MAXBAGITEMCL-1 do
      ItemArr[i].S.Name := '';
end;
//�����Ʒ
function  AddItemBag (cu: TClientItem): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   //���Ҫ��ӵ���Ʒ�Ƿ��Ѿ�����
   for i:=0 to MAXBAGITEMCL-1 do begin
      if (ItemArr[i].MakeIndex = cu.MakeIndex) and (ItemArr[i].S.Name = cu.S.Name) then begin
         exit;
      end;
   end;

   if cu.S.Name = '' then exit;
   if cu.S.StdMode <= 3 then begin               //����ʹ�õ���Ʒ,���ȷ��ڿ����Ʒ��
      for i:=0 to 5 do                           //ǰ��6����ʾ�ڿ����Ʒ����
         if ItemArr[i].S.Name = '' then begin    //��һ���յ�����
            ItemArr[i] := cu;
            Result := TRUE;
            exit;
         end;
   end;
   for i:=6 to MAXBAGITEMCL-1 do begin
      if ItemArr[i].S.Name = '' then begin
         ItemArr[i] := cu;
         Result := TRUE;
         break;
      end;
   end;
   ArrangeItembag;
end;

//�õ�ǰ����Ʒ��������Ѿ����ڵĸ���Ʒ����
function  UpdateItemBag (cu: TClientItem): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=MAXBAGITEMCL-1 downto 0 do begin
      if (ItemArr[i].S.Name = cu.S.Name) and (ItemArr[i].MakeIndex = cu.MakeIndex) then begin
         ItemArr[i] := cu;
         Result := TRUE;
         break;
      end;
   end;
end;

//ɾ��ָ������Ʒ
function  DelItemBag (iname: string; iindex: integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=MAXBAGITEMCL-1 downto 0 do begin
      if (ItemArr[i].S.Name = iname) and (ItemArr[i].MakeIndex = iindex) then begin
         FillChar (ItemArr[i], sizeof(TClientItem), #0);
         Result := TRUE;
         break;
      end;
   end;
   ArrangeItembag;
end;
//������Ʒ��
procedure ArrangeItemBag;
var
   i, k: integer;
begin
   //�ߺ��� �������� ������ ���ش�.
   for i:=0 to MAXBAGITEMCL-1 do begin
      if ItemArr[i].S.Name <> '' then begin
         for k:=i+1 to MAXBAGITEMCL-1 do begin  //�����ͬ����Ʒ
            if (ItemArr[i].S.Name = ItemArr[k].S.Name) and (ItemArr[i].MakeIndex = ItemArr[k].MakeIndex) then begin
               FillChar (ItemArr[k], sizeof(TClientItem), #0);
            end;
         end;
         //�����ƶ�����Ʒ
         if (ItemArr[i].S.Name = MovingItem.Item.S.Name) and (ItemArr[i].MakeIndex = MovingItem.Item.MakeIndex) then begin
            MovingItem.Index := 0;
            MovingItem.Item.S.Name := '';
         end;
      end;
   end;

   //6��������Ʒ��
   //������ �Ⱥ��̴� �κп� ������ ���� �ø���.
   for i:=46 to MAXBAGITEMCL-1 do begin
      if ItemArr[i].S.Name <> '' then begin
         for k:=6 to 45 do begin
            if ItemArr[k].S.Name = '' then begin
               ItemArr[k] := ItemArr[i];
               ItemArr[i].S.Name := '';
               break;
            end;
         end;
      end;
   end;
end;

{----------------------------------------------------------}
//��ӵ�����Ʒ
procedure AddDropItem (ci: TClientItem);
var
   pc: PTClientItem;
begin
   new (pc);
   pc^ := ci;
   DropItems.Add (pc);
end;
//��ȡ������Ʒ
function  GetDropItem (iname: string; MakeIndex: integer): PTClientItem;
var
   i: integer;
begin
   Result := nil;
   for i:=0 to DropItems.Count-1 do begin
      if (PTClientItem(DropItems[i]).S.Name = iname) and (PTClientItem(DropItems[i]).MakeIndex = MakeIndex) then begin
         Result := PTClientItem(DropItems[i]);
         break;
      end;
   end;
end;
//ɾ��������Ʒ
procedure DelDropItem (iname: string; MakeIndex: integer);
var
   i: integer;
begin
   for i:=0 to DropItems.Count-1 do begin
      if (PTClientItem(DropItems[i]).S.Name = iname) and (PTClientItem(DropItems[i]).MakeIndex = MakeIndex) then begin
         Dispose (PTClientItem(DropItems[i]));
         DropItems.Delete (i);
         break;
      end;
   end;
end;

{----------------------------------------------------------}

procedure AddDealItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 10-1 do begin
      if DealItems[i].S.Name = '' then begin
         DealItems[i] := ci;
         break;
      end;
   end;
end;

procedure DelDealItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 10-1 do begin
      if (DealItems[i].S.Name = ci.S.Name) and (DealItems[i].MakeIndex = ci.MakeIndex) then begin
         FillChar (DealItems[i], sizeof(TClientItem), #0);
         break;
      end;
   end;
end;

procedure MoveDealItemToBag;
var
   i: integer;
begin
   for i:=0 to 10-1 do begin
      if DealItems[i].S.Name <> '' then
         AddItemBag (DealItems[i]);
   end;
   FillChar (DealItems, sizeof(TClientItem)*10, #0);
end;

procedure AddDealRemoteItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 20-1 do begin
      if DealRemoteItems[i].S.Name = '' then begin
         DealRemoteItems[i] := ci;
         break;
      end;
   end;
end;

procedure DelDealRemoteItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 20-1 do begin
      if (DealRemoteItems[i].S.Name = ci.S.Name) and (DealRemoteItems[i].MakeIndex = ci.MakeIndex) then begin
         FillChar (DealRemoteItems[i], sizeof(TClientItem), #0);
         break;
      end;
   end;
end;

{----------------------------------------------------------}
//���������ľ��루X��Y����
function  GetDistance (sx, sy, dx, dy: integer): integer;
begin
   Result := _MAX(abs(sx-dx), abs(sy-dy));
end;
//���ݷ���͵�ǰλ��ȷ����һ��λ������(λ����=1��
procedure GetNextPosXY (dir: byte; var x, y:Integer);
begin
   case dir of
      DR_UP:        begin x := x;   y := y-1; end;
      DR_UPRIGHT:   begin x := x+1; y := y-1; end;
      DR_RIGHT:     begin x := x+1; y := y;   end;
      DR_DOWNRIGHT: begin x := x+1; y := y+1; end;
      DR_DOWN:      begin x := x;   y := y+1; end;
      DR_DOWNLEFT:  begin x := x-1; y := y+1; end;
      DR_LEFT:      begin x := x-1; y := y;   end;
      DR_UPLEFT:    begin x := x-1; y := y-1; end;
   end;
end;
//���ݷ���͵�ǰλ��ȷ����һ��λ������(λ����=2��
procedure GetNextRunXY (dir: byte; var x, y:Integer);
begin
   case dir of
      DR_UP:        begin x := x;   y := y-2; end;
      DR_UPRIGHT:   begin x := x+2; y := y-2; end;
      DR_RIGHT:     begin x := x+2; y := y;   end;
      DR_DOWNRIGHT: begin x := x+2; y := y+2; end;
      DR_DOWN:      begin x := x;   y := y+2; end;
      DR_DOWNLEFT:  begin x := x-2; y := y+2; end;
      DR_LEFT:      begin x := x-2; y := y;   end;
      DR_UPLEFT:    begin x := x-2; y := y-2; end;
   end;
end;
//������������ƶ��ķ���
function GetNextDirection (sx, sy, dx, dy: Integer): byte;
var
   flagx, flagy: integer;
begin
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
end;
//���ݵ�ǰ������ת���ķ���
function  GetBack (dir: integer): integer;
begin
   Result := DR_UP;
   case dir of
      DR_UP:         Result := DR_DOWN;
      DR_DOWN:       Result := DR_UP;
      DR_LEFT:       Result := DR_RIGHT;
      DR_RIGHT:      Result := DR_LEFT;
      DR_UPLEFT:     Result := DR_DOWNRIGHT;
      DR_UPRIGHT:    Result := DR_DOWNLEFT;
      DR_DOWNLEFT:   Result := DR_UPRIGHT;
      DR_DOWNRIGHT:  Result := DR_UPLEFT;
   end;
end;
//���ݵ�ǰ����ͷ����ú��˵�����
procedure GetBackPosition (sx, sy, dir: integer; var newx, newy: integer);
begin
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
end;
//���ݵ�ǰλ�úͷ�����ǰ��һ��������
procedure GetFrontPosition (sx, sy, dir: integer; var newx, newy: integer);
begin
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
end;
//��������λ�û�÷��з���8������
function  GetFlyDirection (sx, sy, ttx, tty: integer): Integer;
var
   fx, fy: Real;
begin
   fx := ttx - sx;
   fy := tty - sy;
   sx := 0;
   sy := 0;
   Result := DR_DOWN;
   if fx=0 then begin         //�����X�������
      if fy < 0 then Result := DR_UP
      else Result := DR_DOWN;
      exit;
   end;
   if fy=0 then begin         //�����Y�������
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
end;
//��������λ�û�÷��з���(16������)
function  GetFlyDirection16 (sx, sy, ttx, tty: integer): Integer;
var
   fx, fy: Real;
begin
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
end;
//����ʱ��ת��һ�������ķ���
function  PrivDir (ndir: integer): integer;
begin
   if ndir - 1 < 0 then Result := 7
   else Result := ndir-1;
end;
//��˳ʱ��ת��һ�������ķ���
function  NextDir (ndir: integer): integer;
begin
   if ndir + 1 > 7 then Result := 0
   else Result := ndir+1;
end;
//������ʾ���֣���bcolorɫ�����ֱ߿�,Ч�����ο�
procedure BoldTextOut (surface: TDirectDrawSurface; x, y, fcolor, bcolor: integer; str: string);
begin
   with surface do begin
      Canvas.Font.Name:='����';
      Canvas.Font.Charset:=GB2312_CHARSET;
      Canvas.Font.Color := bcolor;
      Canvas.TextOut (x-1, y, str);
      Canvas.TextOut (x+1, y, str);
      Canvas.TextOut (x, y-1, str);
      Canvas.TextOut (x, y+1, str);
      Canvas.Font.Color := fcolor;
      Canvas.TextOut (x, y, str);
   end;
end;

function  GetTakeOnPosition (smode: integer): integer;
begin
   Result := -1;
   case smode of //StdMode
      5, 6:
         Result := U_WEAPON;     //����
      10, 11:
         Result := U_DRESS;      //�·�
      15,16:
         Result := U_HELMET;     //ͷ��
      19,20,21:
         Result := U_NECKLACE;   //����
      22,23:
         Result := U_RINGL;      //���ָ
      24,26:
         Result := U_ARMRINGR;   //���ֽ�ָ
      25:
         Result := U_ARMRINGL;   //���ֽ�ָ
      30:
         Result := U_RIGHTHAND;  //���� 
   end;
end;
//�ж�ĳ�����Ƿ���
function  IsKeyPressed (key: byte): Boolean;
var
   keyvalue: TKeyBoardState;
begin
   Result := FALSE;
   FillChar(keyvalue, sizeof(TKeyboardState), #0);
   if GetKeyboardState (keyvalue) then
      if (keyvalue[key] and $80) <> 0 then
         Result := TRUE;
end;

procedure AddChangeFace (recogid: integer);
begin
   ChangeFaceReadyList.Add (pointer(recogid));
end;

procedure DelChangeFace (recogid: integer);
var
   i: integer;
begin
   for i:=0 to ChangeFaceReadyList.Count-1 do begin
      if integer(ChangeFaceReadyList[i]) = recogid then begin
         ChangeFaceReadyList.Delete (i);
         break;
      end;
   end;
end;

function  IsChangingFace (recogid: integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=0 to ChangeFaceReadyList.Count-1 do begin
      if integer(ChangeFaceReadyList[i]) = recogid then begin
         Result := TRUE;
         break;
      end;
   end;
end;


Initialization
  DropItems := TList.Create;
Finalization
  DropItems.Free;
end.
