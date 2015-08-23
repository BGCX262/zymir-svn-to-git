unit wmutil;
{
   本单元主要对WIL,WIX文件进行操作。其中WIX是索引文件，WIL是图象（角色）定义文件

}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, DIB,
  DXDraws, DXClass;

type
   TWMImageHeader = record
      Title: string[40];        //'WEMADE Entertainment inc.'
      ImageCount: integer;      //包中的文件数
      ColorCount: integer;      //颜色数
      PaletteSize: integer;     //调色板大小
   end;
   PTWMImageHeader = ^TWMImageHeader;

   TWMImageInfo = record
      Width: smallint;          //图片宽度
      Height: smallint;         //高度
      px: smallint;             //位置偏移量：X,Y
      py: smallint;
      bits: PByte;              //图象数据
   end;
   PTWMImageInfo = ^TWMImageInfo;

   TWMIndexHeader = record
      Title: string[40];        //'WEMADE Entertainment inc.'
      IndexCount: integer;      //索引文件中索引项数目
   end;
   PTWMIndexHeader = ^TWMIndexHeader;

   TWMIndexInfo = record
      Position: integer;        //索引项位置（偏移量）
      Size: integer;            //图片数据大小
   end;
   PTWMIndexInfo = ^TWMIndexInfo;

   TDXImage = record            //图象偏移量
      px: smallint;
      py: smallint;
      surface: TDirectDrawSurface; //画图表面
      LatestTime: integer;         //最后一次使用本图片的时间
   end;
   PTDxImage = ^TDXImage;


function WidthBytes(w: Integer): Integer;
function PaletteFromBmpInfo(BmpInfo: PBitmapInfo): HPalette;
function  MakeBmp (w, h: integer; bits: Pointer; pal: TRGBQuads): TBitmap;
procedure DrawBits(Canvas: TCanvas; XDest, YDest: integer; PSource: PByte; Width, Height: integer);

implementation

//图片的一行数据所需要的字节数（256色），必须是4的倍数
function WidthBytes(w: Integer): Integer;
begin
     Result := (((w * 8) + 31) div 32) * 4;
end;

//从BMP文件中获取调色板信息，并返回调色板句柄
function PaletteFromBmpInfo(BmpInfo: PBitmapInfo): HPalette;
var
   PalSize, n: Integer;
   Palette: PLogPalette;
begin
     //Allocate Memory for Palette
     PalSize := SizeOf(TLogPalette) + (256 * SizeOf(TPaletteEntry));
     Palette := AllocMem(PalSize);

     //Fill in structure
     with Palette^ do
     begin
          palVersion := $300;
          palNumEntries := 256;
          for n := 0 to 255 do
          begin
               palPalEntry[n].peRed := BmpInfo^.bmiColors[n].rgbRed;
               palPalEntry[n].peGreen := BmpInfo^.bmiColors[n].rgbGreen;
               palPalEntry[n].peBlue := BmpInfo^.bmiColors[n].rgbBlue;
               palPalEntry[n].peFlags := 0;
          end;
     end;
     Result := CreatePalette(Palette^);
     FreeMem(Palette, PalSize);
end;

//根据BMP文件创建256色的位图
procedure CreateDIB256(var Bmp: TBitmap; BmpInfo: PBitmapInfo; Bits: PByte);
var
   dc, MemDc: HDC;
   OldPal: HPalette;
begin
   //First Release Handle and Palette from BMP
   DeleteObject(Bmp.ReleaseHandle);
   DeleteObject(Bmp.ReleasePalette);
   try
      //Windows屏幕绘图句柄
      dc := GetDC(0);
      try
         //创建与屏幕兼容的绘图句柄
         MemDC := CreateCompatibleDC(DC);  
         DeleteObject(SelectObject(MemDC, CreateCompatibleBitmap(dc, 1, 1)));

         OldPal := 0;
         Bmp.Palette := PaletteFromBmpInfo(BmpInfo);
         OldPal := SelectPalette(MemDc, Bmp.Palette, False);
         RealizePalette(MemDc);
         try
            Bmp.Handle := CreateDIBitmap(MemDc, BmpInfo^.bmiHeader, CBM_INIT,
                     Pointer(Bits), BmpInfo^, DIB_RGB_COLORS);
         finally
            if OldPal <> 0 then
               SelectPalette(MemDc, OldPal, True);
         end;
      finally
         if MemDC <> 0 then
            DeleteDC(MemDC);
      end;
   finally
      if dc <> 0 then
         ReleaseDC(0, DC);
   end;
   if Bmp.Handle = 0 then
      Exception.Create('CreateDIBitmap failed');
end;

//根据位图的宽、高和位图数据、跳色板创建一个BMP对象
function  MakeBmp (w, h: integer; bits: Pointer; pal: TRGBQuads): TBitmap;
var
   i, k: integer;
   BmpInfo: PBitmapInfo;
   HeaderSize: Integer;
   bmp: TBitmap;
begin
   HeaderSize := SizeOf(TBitmapInfo) + (256 * SizeOf(TRGBQuad));
   GetMem (BmpInfo, HeaderSize);
   for i:=0 to 255 do begin
      BmpInfo.bmiColors[i] := pal[i];
   end;
   with BmpInfo^.bmiHeader do begin
      biSize := SizeOf(TBitmapInfoHeader);
      biWidth := w;
      biHeight := h;
      biPlanes := 1;
      biBitCount := 8; //8bit
      biCompression := BI_RGB;
      biClrUsed := 0;
      biClrImportant := 0;
   end;
   Bmp := TBitmap.Create;
   CreateDIB256 (Bmp, BmpInfo, bits);
   FreeMem (BmpInfo);
   Result := Bmp;
end;

//在画布上画出位图
//  canvas:绘图画布
//  XDest,TDest:左上角坐标
//  PSource：位图数据
//  Width,Height:位图宽高
procedure DrawBits(Canvas: TCanvas; XDest, YDest: integer; PSource: PByte; Width, Height: integer);
var
  HeaderSize : integer;
  bmpInfo : PBitmapInfo;
begin
  if PSource = nil then exit;

  HeaderSize := Sizeof(TBitmapInfo) + (256 * Sizeof(TRGBQuad));
  BmpInfo := AllocMem(HeaderSize);
  if BmpInfo = nil then raise Exception.Create('TNoryImg: Failed to allocate a DIB');
  with BmpInfo^.bmiHeader do begin
    biSize        := SizeOf(TBitmapInfoHeader);
    biWidth       := Width;
    biHeight      := -Height;
    biPlanes      := 1;
    biBitCount    := 8;
    biCompression := BI_RGB;
    biClrUsed     := 0;
    biClrImportant:= 0;
  end;
  SetDIBitsToDevice(Canvas.Handle, XDest, YDest, Width, Height, 0, 0, 0, Height,
                    PSource, BmpInfo^, DIB_RGB_COLORS);
  FreeMem(BmpInfo, HeaderSize);
end;

end.
