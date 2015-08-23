//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit cliUtil;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXDraws, DXClass, WIL, Grobal2, StdCtrls, DirectX, DIB, HUtil32,
  wmutil; //, bmputil;


const
   MAXGRADE = 64;
   DIVUNIT = 4;


type
  TColorEffect = (ceNone, ceGrayScale, ceBright, ceBlack, ceWhite, ceRed, ceGreen, ceBlue, ceYellow, ceFuchsia);

  TNearestIndexHeader = record
    Title: string[30];
    IndexCount: integer;
    desc: array[0..10] of byte;
  end;

procedure BuildColorLevels (ctable: TRGBQuads);
procedure BuildNearestIndex (ctable: TRGBQuads);
procedure SaveNearestIndex (flname: string);
function  LoadNearestIndex (flname: string): Boolean;
procedure DrawFog (ssuf: TDirectDrawSurface; fogmask: PByte; fogwidth: integer);
procedure FogCopy (PSource: Pbyte; ssx, ssy, swidth, sheight: integer;
                   PDest: Pbyte; ddx, ddy, dwidth, dheight, maxfog: integer);
procedure DrawBlend (dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; blendmode: integer);
procedure DrawBlendEx (dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; ssufleft, ssuftop, ssufwidth, ssufheight, blendmode: integer);
procedure DrawEffect (x, y, width, height: integer; ssuf: TDirectDrawSurface; eff: TColorEffect);

var
   DarkLevel : integer;


implementation

uses Share,CLMain;

var
  //RgbIndexTable: array[0..MAXGRADE-1, 0..MAXGRADE-1, 0..MAXGRADE-1] of byte;
  Color256Mix: array[0..255, 0..255] of byte;
  Color256Anti: array[0..255, 0..255] of byte;
  HeavyDarkColorLevel: array[0..255, 0..255] of byte;
  LightDarkColorLevel: array[0..255, 0..255] of byte;
  DengunColorLevel: array[0..255, 0..255] of byte;
  BrightColorLevel: array[0..255] of byte;
  GrayScaleLevel: array[0..255] of byte;
  RedishColorLevel: array[0..255] of byte;
  BlackColorLevel: array[0..255] of byte;
  WhiteColorLevel: array[0..255] of byte;
  GreenColorLevel: array[0..255] of byte;
  YellowColorLevel: array[0..255] of byte;
  BlueColorLevel: array[0..255] of byte;
  FuchsiaColorLevel: array[0..255] of byte;


procedure BuildNearestIndex (ctable: TRGBQuads);
var
   r, g, b, rr, gg, bb, color, MinDif, ColDif: Integer;
   MatchColor: Byte;
   pal0, pal1, pal2: TRGBQuad;

   procedure BuildMix;
   var
      i, j, n: integer;
   begin
      for i:=0 to 255 do begin
         pal0 := ctable[i];
         for j:=0 to 255 do begin
            pal1 := ctable[j];
            pal1.rgbRed := pal0.rgbRed div 2 + pal1.rgbRed div 2;
            pal1.rgbGreen := pal0.rgbGreen div 2 + pal1.rgbGreen div 2;
            pal1.rgbBlue := pal0.rgbBlue div 2 + pal1.rgbBlue div 2;
            MinDif := 768;
            MatchColor := 0;
            for n:=0 to 255 do begin
               pal2 := ctable[n];
               ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                         Abs(pal2.rgbGreen - pal1.rgbGreen) +
                         Abs(pal2.rgbBlue - pal1.rgbBlue);
               if ColDif < MinDif then begin
                  MinDif := ColDif;
                  MatchColor := n;
               end;
            end;
            Color256Mix[i, j] := MatchColor;
         end;
      end;
   end;
   procedure BuildAnti;
   var
      i, j, n, ever: integer;
   begin
      for i:=0 to 255 do begin
         pal0 := ctable[i];
         for j:=0 to 255 do begin
            pal1 := ctable[j];
            ever := _MAX(pal0.rgbRed, pal0.rgbGreen);
            ever := _MAX(ever, pal0.rgbBlue);
//            pal1.rgbRed := _MIN(255, Round (pal0.rgbRed  + (255-ever)/255 * pal1.rgbRed));
//            pal1.rgbGreen := _MIN(255, Round (pal0.rgbGreen  + (255-ever)/255 * pal1.rgbGreen));
//         pal1.rgbBlue := _MIN(255, Round (pal0.rgbBlue  + (255-ever)/255 * pal1.rgbBlue));
            pal1.rgbRed := _MIN(255, Round (pal0.rgbRed  + (255-pal0.rgbRed)/255 * pal1.rgbRed));
            pal1.rgbGreen := _MIN(255, Round (pal0.rgbGreen  + (255-pal0.rgbGreen)/255 * pal1.rgbGreen));
            pal1.rgbBlue := _MIN(255, Round (pal0.rgbBlue  + (255-pal0.rgbBlue)/255 * pal1.rgbBlue));
            MinDif := 768;
            MatchColor := 0;
            for n:=0 to 255 do begin
               pal2 := ctable[n];
               ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                         Abs(pal2.rgbGreen - pal1.rgbGreen) +
                         Abs(pal2.rgbBlue - pal1.rgbBlue);
               if ColDif < MinDif then begin
                  MinDif := ColDif;
                  MatchColor := n;
               end;
            end;
            Color256Anti[i, j] := MatchColor;
         end;
      end;
   end;
   procedure BuildColorLevels;
   var
      n, i, j, rr, gg, bb: integer;
   begin
      for n:=0 to 30 do begin
         for i:=0 to 255 do begin
            pal1 := ctable[i];
            rr := _MIN(Round(pal1.rgbRed * (n+1) / 31) - 5, 255);      //(n + (n-1)*3) / 121);
            gg := _MIN(Round(pal1.rgbGreen * (n+1) / 31) - 5, 255);  //(n + (n-1)*3) / 121);
            bb := _MIN(Round(pal1.rgbBlue * (n+1) / 31) - 5, 255);    //(n + (n-1)*3) / 121);
            pal1.rgbRed := _MAX(0, rr);
            pal1.rgbGreen := _MAX(0, gg);
            pal1.rgbBlue := _MAX(0, bb);
            MinDif := 768;
            MatchColor := 0;
            for j:=0 to 255 do begin
               pal2 := ctable[j];
               ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                         Abs(pal2.rgbGreen - pal1.rgbGreen) +
                         Abs(pal2.rgbBlue - pal1.rgbBlue);
               if ColDif < MinDif then begin
                  MinDif := ColDif;
                  MatchColor := j;
               end;
            end;
            HeavyDarkColorLevel[n, i] := MatchColor;
         end;
      end;
      for n:=0 to 30 do begin
         for i:=0 to 255 do begin
            pal1 := ctable[i];
            pal1.rgbRed := _MIN(Round(pal1.rgbRed * (n*3+47) / 140), 255);
            pal1.rgbGreen := _MIN(Round(pal1.rgbGreen * (n*3+47) / 140), 255);
            pal1.rgbBlue := _MIN(Round(pal1.rgbBlue * (n*3+47) / 140), 255);
            MinDif := 768;
            MatchColor := 0;
            for j:=0 to 255 do begin
               pal2 := ctable[j];
               ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                         Abs(pal2.rgbGreen - pal1.rgbGreen) +
                         Abs(pal2.rgbBlue - pal1.rgbBlue);
               if ColDif < MinDif then begin
                  MinDif := ColDif;
                  MatchColor := j;
               end;
            end;
            LightDarkColorLevel[n, i] := MatchColor;
         end;
      end;
      for n:=0 to 30 do begin
         for i:=0 to 255 do begin
            pal1 := ctable[i];
            pal1.rgbRed := _MIN(Round(pal1.rgbRed * (n*3+120) / 214), 255);
            pal1.rgbGreen := _MIN(Round(pal1.rgbGreen * (n*3+120) / 214), 255);
            pal1.rgbBlue := _MIN(Round(pal1.rgbBlue * (n*3+120) / 214), 255);
            MinDif := 768;
            MatchColor := 0;
            for j:=0 to 255 do begin
               pal2 := ctable[j];
               ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                         Abs(pal2.rgbGreen - pal1.rgbGreen) +
                         Abs(pal2.rgbBlue - pal1.rgbBlue);
               if ColDif < MinDif then begin
                  MinDif := ColDif;
                  MatchColor := j;
               end;
            end;
            DengunColorLevel[n, i] := MatchColor;
         end;
      end;

      {for i:=0 to 255 do begin
         HeavyDarkColorLevel[0, i] := HeavyDarkColorLevel[1, i];
         LightDarkColorLevel[0, i] := LightDarkColorLevel[1, i];
         DengunColorLevel[0, i] := DengunColorLevel[1, i];
      end;}
      for n:=31 to 255 do
         for i:=0 to 255 do begin
            HeavyDarkColorLevel[n, i] := HeavyDarkColorLevel[30, i];
            LightDarkColorLevel[n, i] := LightDarkColorLevel[30, i];
            DengunColorLevel[n, i] := DengunColorLevel[30, i];
         end;

   end;
begin
Try //程序自动增加
   BuildMix;
   BuildAnti;
   BuildColorLevels;
Except //程序自动增加
  DebugOutStr('[Exception] UncliUtil.BuildNearestIndex'); //程序自动增加
End; //程序自动增加
end;

procedure BuildColorLevels (ctable: TRGBQuads);
var
   n, i, j, MinDif, ColDif: integer;
   pal1, pal2: TRGBQuad;
   MatchColor: byte;
begin
Try //程序自动增加
   BrightColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      pal1.rgbRed := _MIN(Round(pal1.rgbRed * 1.3), 255);
      pal1.rgbGreen := _MIN(Round(pal1.rgbGreen * 1.3), 255);
      pal1.rgbBlue := _MIN(Round(pal1.rgbBlue * 1.3), 255);
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      BrightColorLevel[i] := MatchColor;
   end;
   GrayScaleLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      n := (pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) div 3;
      pal1.rgbRed := n; //Round(pal1.rgbRed * (n*3+25) / 118);
      pal1.rgbGreen := n; //Round(pal1.rgbGreen * (n*3+25) / 118);
      pal1.rgbBlue := n; //Round(pal1.rgbBlue * (n*3+25) / 118);
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      GrayScaleLevel[i] := MatchColor;
   end;
   BlackColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      n := Round ((pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) / 3 * 0.6);
      pal1.rgbRed := n; //_MAX(8, Round(pal1.rgbRed * 0.7));
      pal1.rgbGreen := n; //_MAX(8, Round(pal1.rgbGreen * 0.7));
      pal1.rgbBlue := n; //_MAX(8, Round(pal1.rgbBlue * 0.7));
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      BlackColorLevel[i] := MatchColor;
   end;
   WhiteColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      n := _MIN (Round ((pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) / 3 * 1.6), 255);
      pal1.rgbRed := n; //_MAX(8, Round(pal1.rgbRed * 0.7));
      pal1.rgbGreen := n; //_MAX(8, Round(pal1.rgbGreen * 0.7));
      pal1.rgbBlue := n; //_MAX(8, Round(pal1.rgbBlue * 0.7));
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      WhiteColorLevel[i] := MatchColor;
   end;
   RedishColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      n := (pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) div 3;
      pal1.rgbRed := n;
      pal1.rgbGreen := 0;
      pal1.rgbBlue := 0;
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      RedishColorLevel[i] := MatchColor;
   end;
   GreenColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      //n := (pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) div 5;
      //pal1.rgbRed := 0;//_MIN(Round(n / 2), 255);
      //pal1.rgbGreen := _MIN(Round(n), 255);
      //pal1.rgbBlue := 0;//_MIN(Round(n / 2), 255);
      n := (pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) div 3;
      pal1.rgbRed := 0;
      pal1.rgbGreen := n;
      pal1.rgbBlue := 0;
      //pal1.rgbRed := _MIN(Round (pal1.rgbRed / 3), 255);
      //pal1.rgbGreen := _MIN(Round (pal1.rgbGreen * 1.5), 255);
      //pal1.rgbBlue := _MIN(Round (pal1.rgbBlue / 3), 255);
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      GreenColorLevel[i] := MatchColor;
   end;
   YellowColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      n := (pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) div 3;
      pal1.rgbRed := n;
      pal1.rgbGreen := n;
      pal1.rgbBlue := 0;
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      YellowColorLevel[i] := MatchColor;
   end;
   BlueColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      //n := (pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) div 5;
      n := (pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) div 3;
      pal1.rgbRed := 0; //_MIN(Round(n*1.3), 255);
      pal1.rgbGreen := 0; //_MIN(Round(n), 255);
      pal1.rgbBlue := n; //_MIN(Round(n*1.3), 255);
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      BlueColorLevel[i] := MatchColor;
   end;
   FuchsiaColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      n := (pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) div 3;
      pal1.rgbRed := n;
      pal1.rgbGreen := 0;
      pal1.rgbBlue := n;
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      FuchsiaColorLevel[i] := MatchColor;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] UncliUtil.BuildColorLevels'); //程序自动增加
End; //程序自动增加
end;


procedure SaveNearestIndex (flname: string);
var
   nih: TNearestIndexHeader;
   fhandle: integer;
begin
Try //程序自动增加
   nih.Title := 'WEMADE Entertainment Inc.';
   nih.IndexCount := Sizeof(Color256Mix);
   if FileExists (flname) then begin
      fhandle := FileOpen (flname, fmOpenWrite or fmShareDenyNone);
   end else
      fhandle := FileCreate (flname);
   if fhandle > 0 then begin
      FileWrite (fhandle, nih, sizeof(TNearestIndexHeader));
      FileWrite (fhandle, Color256Mix, sizeof(Color256Mix));
      FileWrite (fhandle, Color256Anti, sizeof(Color256Anti));
      FileWrite (fhandle, HeavyDarkColorLevel, sizeof(HeavyDarkColorLevel));
      FileWrite (fhandle, LightDarkColorLevel, sizeof(LightDarkColorLevel)); 
      FileWrite (fhandle, DengunColorLevel, sizeof(DengunColorLevel));
      FileClose (fhandle);
   end;
Except //程序自动增加
  DebugOutStr('[Exception] UncliUtil.SaveNearestIndex'); //程序自动增加
End; //程序自动增加
end;

function LoadNearestIndex (flname: string): Boolean;
var
   nih: TNearestIndexHeader;
   fhandle, rsize: integer;
begin
Try //程序自动增加
   Result := FALSE;
   if FileExists (flname) then begin
      fhandle := FileOpen (flname, fmOpenRead or fmShareDenyNone);
      if fhandle > 0 then begin
         FileRead (fhandle, nih, sizeof(TNearestIndexHeader));
         if nih.IndexCount = Sizeof(Color256Mix) then begin
            Result := TRUE;
            rsize := 256*256;
            if rsize <> FileRead (fhandle, Color256Mix, sizeof(Color256Mix)) then Result := FALSE;
            if rsize <> FileRead (fhandle, Color256Anti, sizeof(Color256Anti)) then Result := FALSE;
            if rsize <> FileRead (fhandle, HeavyDarkColorLevel, sizeof(HeavyDarkColorLevel)) then Result := FALSE;
            if rsize <> FileRead (fhandle, LightDarkColorLevel, sizeof(LightDarkColorLevel)) then Result := FALSE;
            if rsize <> FileRead (fhandle, DengunColorLevel, sizeof(DengunColorLevel)) then Result := FALSE;
         end;
         FileClose (fhandle);
      end;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] UncliUtil.LoadNearestIndex'); //程序自动增加
End; //程序自动增加
end;

procedure FogCopy (PSource: Pbyte; ssx, ssy, swidth, sheight: integer;
                   PDest: Pbyte; ddx, ddy, dwidth, dheight, maxfog: integer);
var
   i, j, n, k, row, srclen, scount, si, di, srcheight, spitch, dpitch: integer;
   sptr, dptr: PByte;
begin
Try //程序自动增加
   if (PSource = nil) or (pDest = nil) then exit; 
   spitch := swidth;
   dpitch := dwidth;
   if ddx < 0 then begin
      ssx := ssx - ddx;
      swidth := swidth + ddx;
      //dwidth := dwidth + ddx;
      ddx := 0;
   end;
   if ddy < 0 then begin
      ssy := ssy - ddy;
      sheight := sheight + ddy;
      //dheight := dheight + ddy;
      ddy := 0;
   end;
   //if ssx+swidth > dwidth then swidth := dwidth - ssx;
   //if ssy+sheight > dheight then sheight := dheight - ssy;
   srclen := _MIN(swidth, dwidth-ddx);
   srcheight := _MIN(sheight, dheight-ddy);
   if (srclen <= 0) or (srcheight <= 0) then exit;

   asm
         mov   row, 0
      @@NextRow:
         mov   eax, row
         cmp   eax, srcheight
         jae   @@Finish

         mov   esi, psource
         mov   eax, ssy
         add   eax, row
         mov   ebx, spitch
         imul  eax, ebx
         add   eax, ssx
         add   esi, eax          //sptr

         mov   edi, pdest
         mov   eax, ddy
         add   eax, row
         mov   ebx, dpitch
         imul  eax, ebx
         add   eax, ddx
         add   edi, eax          //dptr

         mov   ebx, srclen
      @@FogNext:
         cmp   ebx, 0
         jbe   @@FinOne
         cmp   ebx, 8
         jb    @@FinOne   //@@EageNext

         db $0F,$6F,$06           /// movq  mm0, [esi]
         db $0F,$6F,$0F           /// movq  mm1, [edi]
         db $0F,$FE,$C8           /// paddd mm1, mm0
         db $0F,$7F,$0F           /// movq [edi], mm1

         sub   ebx, 8
         add   esi, 8
         add   edi, 8
         jmp   @@FogNext
      {@@EageNext:
         movzx eax, [esi].byte
         movzx ecx, [edi].byte
         add   eax, ecx
         mov   [edi].byte, al

         dec   ebx
         inc   esi
         inc   edi
         jmp   @@FogNext }
      @@FinOne:
         inc   row
         jmp   @@NextRow

      @@Finish:
         db $0F,$77               /// emms
   end;
Except //程序自动增加
  DebugOutStr('[Exception] UncliUtil.FogCopy'); //程序自动增加
End; //程序自动增加
end;

procedure DrawFog (ssuf: TDirectDrawSurface; fogmask: PByte; fogwidth: integer);
var
   i, ii,j, idx, row, n, count: integer;
   ddsd: TDDSurfaceDesc;
   sptr2, mptr, pmix: PByte;
    sptr:PDWORD;
   //source: array[0..910] of byte;
   bitindex, scount, dcount, srclen, destlen, srcheight: integer;
   lpitch: integer;
   src, msk: array[0..7] of byte;
   pSrc, psource, pColorLevel: Pbyte;
   dest2:DWORD;
   ccc:Byte;
begin
Try //程序自动增加
   if ssuf.Width > SCREENWIDTH + 100 then exit;
//   if ssuf.Width > 900 then exit;
   case DarkLevel of
      1: pColorLevel := @HeavyDarkColorLevel;
      2: pColorLevel := @LightDarkColorLevel;
      3: pColorLevel := @DengunColorLevel;
      else exit;
   end;

   try
      ddsd.dwSize := SizeOf(ddsd);
      ssuf.Lock (TRect(nil^), ddsd);
      srclen := _MIN(ssuf.Width, fogwidth);
      pSrc := @src;
      srcheight := ssuf.Height;
      lpitch := ddsd.lPitch;
      psource := ddsd.lpSurface;
      if g_boUseDIBSurface then begin
        for i:=0 to srcheight-1 do begin
          sptr := PDWORD(integer(psource) + (lpitch * i));
          sptr2:= PBYTE(Integer(fogmask) + (fogwidth * I));
          for II:=0 to srclen -1 do begin
            dest2:=sptr^;
            asm
              mov   edi, sptr2      //edi = fogmask

              mov   edx, pColorLevel
              movzx eax, [edi].byte   //fogmask

              imul  eax, 256
              movzx ebx, [dest2+3].byte   //家胶 ddsd.lpSurface;
              add   eax, ebx
              mov   al, [edx+eax].byte //pColorLevel
              mov   CCC, al
            end;
            sptr^:=pfRGBEx(CCC);
            Inc(sptr2);
            Inc(sptr);
          end;
        end;
      end else begin
        asm
              mov   row, 0
           @@NextRow:
              mov   ebx, row
              mov   eax, srcheight
              cmp   ebx, eax
              jae   @@DrawFogFin

              mov   esi, psource      //esi = ddsd.lpSurface;
              mov   eax, lpitch
              mov   ebx, row
              imul  eax, ebx
              add   esi, eax

              mov   edi, fogmask      //edi = fogmask
              mov   eax, fogwidth
              mov   ebx, row
              imul  eax, ebx
              add   edi, eax

              mov   ecx, srclen
              mov   edx, pColorLevel

           @@NextByte:
              cmp   ecx, 0
              jbe   @@Finish

              movzx eax, [edi].byte   //fogmask
              ///cmp   eax, 30
              ///ja    @@SkipByte
              imul  eax, 256
              movzx ebx, [esi].byte   //家胶 ddsd.lpSurface;
              add   eax, ebx
              mov   al, [edx+eax].byte //pColorLevel
              mov   [esi].byte, al
           ///@@SkipByte:
              dec   ecx
              inc   esi
              inc   edi
              jmp   @@NextByte

           @@Finish:
              inc   row
              jmp   @@NextRow

           @@DrawFogFin:
              db $0F,$77               /// emms
        end;
      end;
   finally
      ssuf.UnLock();
   end;
Except //程序自动增加
  DebugOutStr('[Exception] UncliUtil.DrawFog'); //程序自动增加
End; //程序自动增加
end;

//ssurface + dsurface => dsurface
procedure DrawBlend (dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; blendmode: integer);
begin
Try //程序自动增加
   DrawBlendEx (dsuf, x, y, ssuf, 0, 0, ssuf.Width, ssuf.Height, blendmode);
Except //程序自动增加
  DebugOutStr('[Exception] UncliUtil.DrawBlend'); //程序自动增加
End; //程序自动增加
end;

//ssurface + dsurface => dsurface
procedure DrawBlendEx (dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; ssufleft, ssuftop, ssufwidth, ssufheight, blendmode: integer);
var
   i, ii,j, srcleft, srctop, srcwidth, srcbottom, sidx, didx: integer;
   sddsd, dddsd: TDDSurfaceDesc;
   sptr, dptr, pmix: PByte;
   sptr2,dptr2:PDWORD;
   source2, dest2:DWORD;
   source, dest: array[0..910] of byte;
   ccc:Byte;
   bitindex, scount, dcount, srclen, destlen, wcount, awidth, bwidth: integer;
begin
Try //程序自动增加
   if (dsuf.canvas = nil) or (ssuf.canvas = nil) then exit;
   if x >= dsuf.Width then exit;
   if y >= dsuf.Height then exit;
   if x < 0 then begin
      srcleft := -x;
      srcwidth := ssufwidth + x;
      x := 0;
   end else begin
      srcleft := ssufleft;
      srcwidth := ssufwidth;
   end;
   if y < 0 then begin
      srctop := -y;
      srcbottom := ssufheight;
      y := 0;
   end else begin
      srctop := ssuftop;
      srcbottom := srctop + ssufheight;
   end;
   if srcleft + srcwidth > ssuf.Width then srcwidth := ssuf.Width-srcleft;
   if srcbottom > ssuf.Height then
      srcbottom := ssuf.Height;//-srcheight;
   if x + srcwidth > dsuf.Width then srcwidth := (dsuf.Width-x) div 4 * 4;
   if y + srcbottom - srctop > dsuf.Height then
      srcbottom := dsuf.Height-y+srctop;
   if (x+srcwidth) * (y+srcbottom-srctop) > dsuf.Width * dsuf.Height then //烙矫..
      srcbottom := srctop + (srcbottom-srctop) div 2;

   if (srcwidth <= 0) or (srcbottom <= 0) or (srcleft >= ssuf.Width) or (srctop >= ssuf.Height) then exit;
//   if srcWidth > 900 then exit;
   if srcWidth > SCREENWIDTH + 100 then exit;
   try
      sddsd.dwSize := SizeOf(sddsd);
      dddsd.dwSize := SizeOf(dddsd);
      ssuf.Lock (TRect(nil^), sddsd);
      dsuf.Lock (TRect(nil^), dddsd);
      awidth := srcwidth div 4; //ssuf.Width div 4;
      bwidth := srcwidth; //ssuf.Width;
      srclen := srcwidth; //ssuf.Width;
      destlen := srcwidth; //ssuf.Width;
      case blendmode of
         0: pmix := @Color256Mix[0,0];
         else pmix := @Color256Anti[0,0];
      end;
      if g_boUseDIBSurface then begin
        for i:=srctop to srcbottom-1 do begin
          sptr2 := PDWORD(integer(sddsd.lpSurface) + sddsd.lPitch * i + (srcleft*4));
          dptr2 := PDWORD(integer(dddsd.lpSurface) + (y+i-srctop) * dddsd.lPitch + (x*4));
          for II:=srcleft to srcwidth -1 do begin
            if (sptr2^<>0) then begin
              source2:=sptr2^;
              dest2:=dptr2^;
              asm
                movzx eax, [source2+3].byte
                shl   eax, 8                  //sidx * 256
                mov   sidx, eax

                movzx eax, [dest2+3].byte
                add   sidx, eax                 //sidx * 256
                mov   edx, pmix
                mov   ecx, sidx
                movzx eax, [edx+ecx].Byte
                mov   ccc , al
              end;
              if ccc<>0 then dptr2^:=pfRGBEx(ccc);
            end;
            Inc(sptr2);
            Inc(dptr2);
          end;
        end;
      end else begin
        for i:=srctop to srcbottom-1 do begin
           sptr := PBYTE(integer(sddsd.lpSurface) + sddsd.lPitch * i + srcleft);
           dptr := PBYTE(integer(dddsd.lpSurface) + (y+i-srctop) * dddsd.lPitch + x);
           asm
                 mov   scount, 0
                 mov   esi, sptr
                 lea   edi, source
                 mov   ebx, scount        //ebx = scount
              @@CopySource:
                 cmp   ebx, srclen
                 jae    @@EndSourceCopy
                 db $0F,$6F,$04,$1E       /// movq  mm0, [esi+ebx]
                 db $0F,$7F,$04,$1F       /// movq  [edi+ebx], mm0
                 add   ebx, 8
                 jmp   @@CopySource
              @@EndSourceCopy:

                 mov   dcount, 0
                 mov   esi, dptr
                 lea   edi, dest
                 mov   ebx, dcount
              @@CopyDest:
                 cmp   ebx, destlen
                 jae    @@EndDestCopy
                 db $0F,$6F,$04,$1E       /// movq  mm0, [esi+ebx]
                 db $0F,$7F,$04,$1F       /// movq  [edi+ebx], mm0
                 add   ebx, 8
                 jmp   @@CopyDest
              @@EndDestCopy:

                 lea   esi, source
                 lea   edi, dest
                 mov   wcount, 0

              @@BlendNext:
                 mov   ebx, wcount
                 cmp   [esi+ebx].byte, 0     //if _src[bitindex] > 0
                 jz    @@EndBlend

                 movzx eax, [esi+ebx].byte     //sidx := _src[bitindex]
                 shl   eax, 8                  //sidx * 256
                 mov   sidx, eax

                 movzx eax, [edi+ebx].byte     //didx := _dest[bitindex]
                 add   sidx, eax

                 mov   edx, pmix
                 mov   ecx, sidx
                 movzx eax, [edx+ecx].byte     //
                 mov   [edi+ebx], al

              @@EndBlend:
                 inc   wcount
                 mov   eax, bwidth
                 cmp   wcount, eax
                 jb    @@BlendNext

                 lea   esi, dest               //Move (_src, dptr^, 4)
                 mov   edi, dptr
                 mov   ecx, awidth
                 cld
                 rep movsd

           end;
        end;
        asm
           db $0F,$77               /// emms
        end;
      end;

   finally
      ssuf.UnLock();
      dsuf.UnLock();
   end;
Except //程序自动增加
  DebugOutStr('[Exception] UncliUtil.DrawBlendEx'); //程序自动增加
End; //程序自动增加
end;

procedure DrawEffect (x, y, width, height: integer; ssuf: TDirectDrawSurface; eff: TColorEffect);
var
   i, j, n, scount, srclen: integer;
   sddsd: TDDSurfaceDesc;
   sptr, peff: PByte;
   //source: array[0..810] of byte;
   source: array[0..SCREENWIDTH + 10] of byte;
   nheight:Integer;
   sptr2:PDWORD;
   source2:DWORD;
   ccc:Byte;
begin
Try //程序自动增加
   if Width > SCREENWIDTH then exit;
//   if Width > 800 then exit;
   if eff = ceNone then exit;
   peff := nil;
   case eff of
      ceGrayScale: peff := @GrayScaleLevel;
      ceBright: peff := @BrightColorLevel;
      ceBlack: peff := @BlackColorLevel;
      ceWhite: peff := @WhiteColorLevel;
      ceRed: peff := @RedishColorLevel;
      ceGreen: peff := @GreenColorLevel;
      ceBlue:  peff := @BlueColorLevel;
      ceYellow:  peff := @YellowColorLevel;
      ceFuchsia: peff := @FuchsiaColorLevel;
      //else exit;
   end;
   if peff = nil then exit;
   try
      sddsd.dwSize := SizeOf(sddsd);
      ssuf.Lock (TRect(nil^), sddsd);
      srclen := _Min(width,ssuf.Width);
      nheight:= _Min(height,ssuf.height);
      if g_boUseDIBSurface then begin
        for i:=0 to nheight-1 do begin
          sptr2 := PDWORD(integer(sddsd.lpSurface) + (y+i) * sddsd.lPitch + (x*4));
          for j:=0 to srclen -1 do begin
            source2:=sptr2^;
            asm
              movzx eax, [source2+3].byte
              mov   edx, peff
              movzx eax, [edx+eax].byte
              mov   ccc , al
            end;
            sptr2^:=pfRGBEx(ccc);
            Inc(sptr2);
          end;
        end;
      end else begin
        for i:=0 to nheight-1 do begin
           sptr := PBYTE(integer(sddsd.lpSurface) + (y+i) * sddsd.lPitch + x);
           asm
                 mov   scount, 0            //scount=0
                 mov   esi, sptr            //esi=sptr
                 lea   edi, source          //取source地址到edi
              @@CopySource:
                 mov   ebx, scount        //ebx = scount
                 cmp   ebx, srclen        //比较ebx srclen
                 jae   @@EndSourceCopy    //大于或等于转移到 @@EndSourceCopy
                 db $0F,$6F,$04,$1E       /// movq  mm0, [esi+ebx]
                 db $0F,$7F,$07           /// movq  [edi], mm0

                 mov   ebx, 0             //设置 ebx = 0
              @@Loop8:
                 cmp   ebx, 8              //比较ebx 8
                 jz    @@EndLoop8         //等于转移
                 movzx eax, [edi+ebx].byte
                 mov   edx, peff            //edx = peff
                 movzx eax, [edx+eax].byte     //
                 mov   [edi+ebx], al
                 inc   ebx
                 jmp   @@Loop8
              @@EndLoop8:

                 mov   ebx, scount        //ebx =scount
                 db $0F,$6F,$07           /// movq  mm0, [edi]
                 db $0F,$7F,$04,$1E       /// movq  [esi+ebx], mm0

                 add   edi, 8
                 add   scount, 8
                 jmp   @@CopySource
              @@EndSourceCopy:
                 db $0F,$77               /// emms

           end;
        end;
      end;
   finally
      ssuf.UnLock();
   end;
Except //程序自动增加
  DebugOutStr('[Exception] UncliUtil.DrawEffect'); //程序自动增加
End; //程序自动增加
end;

end.
