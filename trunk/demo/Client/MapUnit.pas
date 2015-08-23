unit MapUnit;
//��ͼ��Ԫ
{ MAP�ļ��ṹ
    �ļ�ͷ��52�ֽ�
    ��һ�е�һ�ж���
    �ڶ��е�һ�ж���
    �����е�һ�ж���
    ��
    ��
    ��
    ��Width�е�һ�ж���
    ��һ�еڶ��ж���
    ��
    ��
    ��
}
interface

uses
   Windows, Classes, SysUtils, Grobal2, HUtil32, DXDraws, CliUtil;

const
   MAPDIR = 'Map\';
   MAXX = 40;
   MAXY = 40;

type
// -------------------------------------------------------------------------------
// Map
// -------------------------------------------------------------------------------
{
  TMapPrjInfo = record
     Ident: string[16];
     ColCount: integer;
     RowCount: integer;
  end;
}
  //.MAP�ļ�ͷ  52bytes
  TMapHeader = packed record
     Width  : word;                      //���      2
     Height : word;                      //�߶�      2
     Title: array [1..16] of char;                  //����      16
     UpdateDate: TDateTime;              //��������  8
     Reserved  : array[0..23] of char;   //����      20
  end;

  //��ͼ�ļ�һ��Ԫ�صĶ���
  TMapInfo = record
      BkImg: word;
      MidImg: word;
      FrImg: word;
      DoorIndex: byte;  //$80 (��¦), ���� �ĺ� �ε���
      DoorOffset: byte;  //���� ���� �׸��� ��� ��ġ, $80 (����/����(�⺻))
      AniFrame: byte;      //$80(Draw Alpha) +  ������ ��
      AniTick: byte;
      Area: byte;        //���� ����
      light: byte;       //0..1..4 
  end;
  PTMapInfo = ^TMapInfo;

  //TMapInfoArr = array[0..MaxListSize] of TMapInfo;
  //PTMapInfoArr = ^TMapInfoArr;

  TMap = class
  private
     function  loadmapinfo (mapfile: string; var width, height: integer): Boolean;
     procedure updatemapseg (cx, cy: integer); //, maxsegx, maxsegy: integer);
     procedure updatemap (cx, cy: integer);
  public
     MapBase: string;
     MArr: array[0..MAXX*3, 0..MAXY*3] of TMapInfo;
     ClientRect: TRect;
     OldClientRect: TRect;
     BlockLeft, BlockTop: integer; //Ÿ�� ��ǥ�� ����, ����� ��ǥ
     oldleft, oldtop: integer;
     oldmap: string;
     CurUnitX, CurUnitY: integer;
     CurrentMap: string;
     Segmented: Boolean;
     SegXCount, SegYCount: integer;
     constructor Create;
     destructor Destroy;
     procedure UpdateMapSquare (cx, cy: integer);
     procedure UpdateMapPos (mx, my: integer);
     procedure ReadyReload;
     procedure LoadMap (mapname: string; mx, my: integer);
     procedure MarkCanWalk (mx, my: integer; bowalk: Boolean);
     function  CanMove (mx, my: integer): Boolean;
     function  CanFly  (mx, my: integer): Boolean;
     function  GetDoor (mx, my: integer): Integer;
     function  IsDoorOpen (mx, my: integer): Boolean;
     function  OpenDoor (mx, my: integer): Boolean;
     function  CloseDoor (mx, my: integer): Boolean;
  end;

  procedure DrawMiniMap;

implementation

uses
   ClMain;


constructor TMap.Create;
begin
   inherited Create;
   //GetMem (MInfoArr, sizeof(TMapInfo) * LOGICALMAPUNIT * 3 * LOGICALMAPUNIT * 3);
   ClientRect := Rect (0,0,0,0);
   MapBase := '.\Map\';    //��ͼ�ļ�����Ŀ¼
   CurrentMap := '';       //��ǰ��ͼ�ļ���������.MAP��
   Segmented := FALSE;
   SegXCount := 0;
   SegYCount := 0;
   CurUnitX := -1;        //��ǰ��Ԫλ��X��Y
   CurUnitY := -1;
   BlockLeft := -1;       //��ǰ��X,Y���Ͻ�
   BlockTop := -1;
   oldmap := '';          //ǰһ����ͼ�ļ������ڻ���ͼ��ʱ���ã�
end;

destructor TMap.Destroy;
begin
   inherited Destroy;
end;

//��MAP�ļ��Ŀ�Ⱥ͸߶�
function  TMap.loadmapinfo (mapfile: string; var width, height: integer): Boolean;
var
   flname: string;
   fhandle: integer;
   header: TMapHeader;
begin
   Result := FALSE;
   flname := MapBase + mapfile;
   if FileExists (flname) then begin
      fhandle := FileOpen (flname, fmOpenRead or fmShareDenyNone);
      if fhandle > 0 then begin
         FileRead (fhandle, header, sizeof(TMapHeader));
         width := header.Width;
         height := header.Height;
         result:=true;
      end;
      FileClose (fhandle);
   end;
end;

//segmented map
procedure TMap.updatemapseg (cx, cy: integer); //, maxsegx, maxsegy: integer);
begin

end;

//single map
procedure TMap.updateMap (cx, cy: integer);
var
   fhandle, i, k, aline, lx, rx, ty, by: integer;
   header: TMapHeader;
   flname: string;
begin
   FillChar (MArr, sizeof(MArr), 0);
   flname := MapBase + CurrentMap + '.map';
   if FileExists (flname) then begin
      fhandle := FileOpen (flname, fmOpenRead or fmShareDenyNone);
      if fhandle > 0 then begin
         FileRead (fhandle, header, sizeof(TMapHeader));
         lx := (cx - 1) * LOGICALMAPUNIT;
         rx := (cx + 2) * LOGICALMAPUNIT;
         ty := (cy - 1) * LOGICALMAPUNIT;
         by := (cy + 2) * LOGICALMAPUNIT;
         if lx < 0 then lx := 0;
         if ty < 0 then ty := 0;
         if by >= header.Height then by := header.Height;
         aline := sizeof(TMapInfo) * header.Height;  //һ���еĴ�С���ֽ�����
         for i:=lx to rx-1 do begin   //i����� 3*LOGICALMAPUNIT ֵ,�����Ҫ���µĵ�ͼ������
            if (i >= 0) and (i < header.Width) then begin
               //��ǰ����ΪX,Y����Ӧ��X*ÿ���ֽ���+Y*ÿ���ֽ�����ʼ����һ������
               FileSeek (fhandle, sizeof(TMapHeader) + (aline * i) + (sizeof(TMapInfo) * ty), 0);
               FileRead (fhandle, MArr[i-lx, 0], sizeof(TMapInfo) * (by-ty));
            end;
         end;
         FileClose (fhandle);
      end;
   end;
end;

procedure TMap.ReadyReload;
begin
   CurUnitX := -1;
   CurUnitY := -1;
end;

//cx, cy: λ��, ��LOGICALMAPUNITΪ��λ
procedure TMap.UpdateMapSquare (cx, cy: integer);
begin
   if (cx <> CurUnitX) or (cy <> CurUnitY) then begin
      if Segmented then
         updatemapseg (cx, cy)
      else
         updatemap (cx, cy);
      CurUnitX := cx;
      CurUnitY := cy;
   end;
end;

//��ĳ���� �̵��� ����� ȣ��..
procedure TMap.UpdateMapPos (mx, my: integer);    //mx,my��������
var
   cx, cy: integer;      //��ͼ���߼�����
   procedure Unmark (xx, yy: integer);   //xx,yy�����ص�����
   var
      ax, ay: integer;
   begin
      if (cx = xx div LOGICALMAPUNIT) and (cy = yy div LOGICALMAPUNIT) then begin
         ax := xx - BlockLeft;
         ay := yy - BlockTop;
         MArr[ax,ay].FrImg := MArr[ax,ay].FrImg and $7FFF;
         MArr[ax,ay].BkImg := MArr[ax,ay].BkImg and $7FFF;
      end;
   end;
begin
   cx := mx div LOGICALMAPUNIT;      //������߼�����
   cy := my div LOGICALMAPUNIT;
   BlockLeft := _MAX (0, (cx - 1) * LOGICALMAPUNIT);   //��������
   BlockTop  := _MAX (0, (cy - 1) * LOGICALMAPUNIT);

   UpdateMapSquare (cx, cy);

   if (oldleft <> BlockLeft) or (oldtop <> BlockTop) or (oldmap <> CurrentMap) then begin
      //3���� �����ڸ� ���� ���� (2001-7-3)
      if CurrentMap = '3' then begin
         Unmark (624, 278);
         Unmark (627, 278);
         Unmark (634, 271);

         Unmark (564, 287);
         Unmark (564, 286);
         Unmark (661, 277);
         Unmark (578, 296);
      end;
   end;
   oldleft := BlockLeft;
   oldtop := BlockTop;
end;

//�ʺ���� ó�� �ѹ� ȣ��..
procedure TMap.LoadMap (mapname: string; mx, my: integer);
begin
   CurUnitX := -1;
   CurUnitY := -1;
   CurrentMap := mapname;
   Segmented := FALSE; //Segmented �Ǿ� �ִ��� �˻��Ѵ�.
   UpdateMapPos (mx, my);
   oldmap := CurrentMap;
end;

//��ǰ���Ƿ��������
procedure TMap.MarkCanWalk (mx, my: integer; bowalk: Boolean);
var
   cx, cy: integer;
begin
   cx := mx - BlockLeft;
   cy := my - BlockTop;
   if (cx < 0) or (cy < 0) then exit;
   if bowalk then //������������ߣ���MArr[cx,cy]��ֵ���λΪ0
      Map.MArr[cx, cy].FrImg := Map.MArr[cx, cy].FrImg and $7FFF
   else //���������ߵģ����λΪ1
      Map.MArr[cx, cy].FrImg := Map.MArr[cx, cy].FrImg or $8000;
end;

//��ǰ���ͱ����������ߣ��򷵻���
function  TMap.CanMove (mx, my: integer): Boolean;
var
   cx, cy: integer;
begin
   cx := mx - BlockLeft;
   cy := my - BlockTop;
   result:=false;
   if (cx < 0) or (cy < 0) then exit;
   //ǰ���ͱ����������ߣ����λΪ0��
   Result := ((Map.MArr[cx, cy].BkImg and $8000) + (Map.MArr[cx, cy].FrImg and $8000)) = 0;
   if Result then begin
      if Map.MArr[cx, cy].DoorIndex and $80 > 0 then begin  //��¦�� ����
         if (Map.MArr[cx, cy].DoorOffset and  $80) = 0 then
            Result := FALSE; //���� �� ������.
      end;
   end;
end;

//��ǰ�������ߣ��򷵻��档
function  TMap.CanFly  (mx, my: integer): Boolean;
var
   cx, cy: integer;
begin
   cx := mx - BlockLeft;
   cy := my - BlockTop;
   if (cx < 0) or (cy < 0) then exit;
   Result := (Map.MArr[cx, cy].FrImg and $8000) = 0;
   if Result then begin 
      if Map.MArr[cx, cy].DoorIndex and $80 > 0 then begin
         if (Map.MArr[cx, cy].DoorOffset and  $80) = 0 then
            Result := FALSE;
      end;
   end;
end;

//���ָ��������ŵ�������
function  TMap.GetDoor (mx, my: integer): Integer;
var
   cx, cy: integer;
begin
   Result := 0;
   cx := mx - BlockLeft;
   cy := my - BlockTop;
   if Map.MArr[cx, cy].DoorIndex and $80 > 0 then begin     //����
      Result := Map.MArr[cx, cy].DoorIndex and $7F;         //�ŵ������ڵ�7λ
   end;
end;

//�ж����Ƿ��
function  TMap.IsDoorOpen (mx, my: integer): Boolean;
var
   cx, cy: integer;
begin
   Result := FALSE;
   cx := mx - BlockLeft;
   cy := my - BlockTop;
   if Map.MArr[cx, cy].DoorIndex and $80 > 0 then begin    //����
      Result := (Map.MArr[cx, cy].DoorOffset and $80 <> 0);
   end;
end;

//����
function  TMap.OpenDoor (mx, my: integer): Boolean;
var
   i, j, cx, cy, idx: integer;
begin
   Result := FALSE;
   cx := mx - BlockLeft;
   cy := my - BlockTop;
   if (cx < 0) or (cy < 0) then exit;
   if Map.MArr[cx, cy].DoorIndex and $80 > 0 then begin     //
      idx := Map.MArr[cx, cy].DoorIndex and $7F;
      for i:=cx-10 to cx+10 do
         for j:=cy-10 to cy+10 do begin
            if (i > 0) and (j > 0) then
               if (Map.MArr[i, j].DoorIndex and $7F) = idx then
                  Map.MArr[i, j].DoorOffset := Map.MArr[i, j].DoorOffset or $80;
         end;
   end;
end;

function  TMap.CloseDoor (mx, my: integer): Boolean;
var
   i, j, cx, cy, idx: integer;
begin
   Result := FALSE;
   cx := mx - BlockLeft;
   cy := my - BlockTop;
   if (cx < 0) or (cy < 0) then exit;
   if Map.MArr[cx, cy].DoorIndex and $80 > 0 then begin
      idx := Map.MArr[cx, cy].DoorIndex and $7F;
      for i:=cx-8 to cx+10 do
         for j:=cy-8 to cy+10 do begin
            if (Map.MArr[i, j].DoorIndex and $7F) = idx then
               Map.MArr[i, j].DoorOffset := Map.MArr[i, j].DoorOffset and $7F;
         end;
   end;
end;


const
   SCALE = 4;

//��С��ͼ
procedure DrawMiniMap;
var
   sx, sy, ex, ey, i, j, imgnum, wunit, ani, ny, oheight, MX, MY: integer;
   d: TDirectDrawSurface;
begin
   MiniMapSurface.Fill(0);
   MX := UNITX div SCALE;
   MY := UNITY div SCALE;
   sx := _MAX(0,      (Myself.XX - Map.BlockLeft) div 2 * 2 - 22);
   ex := _MIN(MAXX*3, (Myself.XX - Map.BlockLeft) div 2 * 2 + 22);
   sy := _MAX(0,      (Myself.YY - Map.BlockTop) div 2 * 2 - 22);
   ey := _MIN(MAXY*3, (Myself.YY - Map.BlockTop) div 2 * 2 + 22);

   for i:=0 to ex-sx do begin
      for j:=0 to ey-sy do begin
         if (i >= 0) and (j < MAXY*3) and ((i+sx) mod 2 = 0) and ((j+sy) mod 2 = 0) then begin
            imgnum := (Map.MArr[sx+i, sy+j].BkImg and $7FFF);
            if imgnum > 0 then begin
               imgnum := imgnum - 1;
               d := FrmMain.WTiles.Images[imgnum];
               if d <> nil then
                  MiniMapSurface.StretchDraw (
                                 Rect (i*MX, j*MY, i*MX + d.Width div SCALE, j*MY + d.Height div SCALE),
                                 d.ClientRect, d, FALSE);
            end;
         end;
      end;
   end;
   for i:=0 to ex-sx-1 do begin
      for j:=0 to ey-sy-1 do begin
         imgnum := Map.MArr[sx+i, sy+j].MidImg;
         if imgnum > 0 then begin
            imgnum := imgnum - 1;
            d := FrmMain.WSmTiles.Images[imgnum];
            if d <> nil then
               MiniMapSurface.StretchDraw (
                              Rect (i*MX, j*MY, i*MX + d.Width div SCALE, j*MY + d.Height div SCALE),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;
   for j:=0 to ey-sy-1+25 do begin
      for i:=0 to ex-sx do begin
         if (i >= 0) and (i < MAXX*3) and (j < MAXY*3) then begin
            imgnum := (Map.MArr[sx+i, sy+j].FrImg and $7FFF);
            if imgnum > 0 then begin
               wunit := Map.MArr[sx+i, sy+j].Area;
               ani := Map.MArr[sx+i, sy+j].AniFrame;
               if (ani and $80) > 0 then begin
                  continue;
               end;
               imgnum := imgnum - 1;
               d := FrmMain.GetObjs(wunit, imgnum);
               if d <> nil then begin
                  ny := j*MY - d.Height div SCALE + MY;
                  if ny < 360 then
                     MiniMapSurface.StretchDraw (
                                 Rect (i*MX, ny, i*MX + d.Width div SCALE, ny + d.Height div SCALE),
                                 d.ClientRect,d, TRUE);
               end;
            end;
         end;
      end;
   end;
   //DrawEffect (0, 0, MiniMapSurface.Width, MiniMapSurface.Height, MiniMapSurface, ceGrayScale);
end;


end.
