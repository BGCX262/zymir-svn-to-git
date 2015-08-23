unit HUtil32;

//提供大量的辅助函数

interface

uses
   Classes, SysUtils, WinTypes, WinProcs, Graphics, Messages, Dialogs;

type
   Str4096 = array [0..4096] of char;
   Str256 = array [0..256] of char;
   //名称、值对照表
   TyNameTable = record
     Name: string;
     varl: Longint;
   end;

   TLRect = record
      Left, Top, Right, Bottom: Longint;
   end;

const
   MAXDEFCOLOR = 16;
   //颜色名称、值对照
   ColorNames: array [1..MAXDEFCOLOR] of TyNameTable = (
      (Name: 'BLACK'; 		varl: clBlack),
      (Name: 'BROWN';		varl: clMaroon),
      (Name: 'MARGENTA';	varl: clFuchsia),
      (Name: 'GREEN';		varl: clGreen),
      (Name: 'LTGREEN';		varl: clOlive),
      (Name: 'BLUE';		varl: clNavy),
      (Name: 'LTBLUE';		varl: clBlue),
      (Name: 'PURPLE';		varl: clPurple),
      (Name: 'CYAN';		varl: clTeal),
      (Name: 'LTCYAN';		varl: clAqua),
      (Name: 'GRAY';		varl: clGray),
      (Name: 'LTGRAY';		varl: clsilver),
      (Name: 'YELLOW';		varl: clYellow),
      (Name: 'LIME';		varl: clLime),
      (Name: 'WHITE';		varl: clWhite),
      (Name: 'RED';		varl: clRed)
   );

   //标记、值对照
   MAXLISTMARKER    = 3;
   LiMarkerNames: array [1..MAXLISTMARKER] of TyNameTable = (
      (Name: 'DISC';		varl: 0),
      (Name: 'CIRCLE';		varl: 1),
      (Name: 'SQUARE';		varl: 2)
   );

   //
   MAXPREDEFINE    = 3;
   PreDefineNames: array [1..MAXPREDEFINE] of TyNameTable = (
      (Name: 'LEFT';		varl: 0),
      (Name: 'RIGHT';		varl: 1),
      (Name: 'CENTER';		varl: 2)
   );


function  ArrestStringEx (Source, SearchAfter, ArrestBefore: string; var ArrestStr: string): string;
function  ExtractFileNameOnly (const fname: string): string;
function  FloatToStrFixFmt (fVal: Double; prec, digit: Integer): string;
function  FileSize (const FName: string): Longint;
function  FileCopy(source,dest: String): Boolean;
function  GetValidStr3 (Str: string; var Dest: string; const Divider: array of Char): string;
function  GetValidStrVal (Str: string; var Dest: string; const Divider: array of Char): string;
function  Str_ToInt (Str: string; def: Longint): Longint;
procedure SpliteBitmap (DC: HDC; X, Y: integer; bitmap: TBitmap; transcolor: TColor);
function _MIN (n1, n2: integer): integer;
function _MAX (n1, n2: integer): integer;

implementation

//返回文件名（不包括路径和扩展名）
function  ExtractFileNameOnly (const fname: string): string;
var
   extpos: integer;
   ext, fn: string;
begin
   ext := ExtractFileExt (fname);
   fn := ExtractFileName (fname);
   if ext <> '' then begin
      extpos := pos (ext, fn);
      Result := Copy (fn, 1, extpos-1);
   end else
      Result := fn;
end;

function ArrestStringEx (Source, SearchAfter, ArrestBefore: string; var ArrestStr: string): string;
var
   BufCount, SrcCount, SrcLen: integer;
   GoodData, Fin: Boolean;
   i, n: integer;
begin
   ArrestStr := ''; {result string}
   if Source = '' then begin
      Result := '';
      exit;
   end;

   try
      SrcLen := Length (Source);
      GoodData := FALSE;
      if SrcLen >= 2 then
         if Source[1] = SearchAfter then begin
            Source := Copy (Source, 2, SrcLen-1);
            SrcLen := Length (Source);
            GoodData := TRUE;
         end else begin
            n := Pos (SearchAfter, Source);
            if n > 0 then begin
               Source := Copy (Source, n+1, SrcLen-(n));
               SrcLen := Length(Source);
               GoodData := TRUE;
            end;
         end;
      Fin := FALSE;
      if GoodData then begin
         n := Pos (ArrestBefore, Source);
         if n > 0 then begin
            ArrestStr := Copy (Source, 1, n-1);
            Result := Copy (Source, n+1, SrcLen-n);
         end else begin
            Result := SearchAfter + Source;
         end;
      end else begin
         for i:=1 to SrcLen do begin
            if Source[i] = SearchAfter then begin
               Result := Copy (Source, i, SrcLen-i+1);
               break;
            end;
         end;
      end;
   except
      ArrestStr := '';
      Result := '';
   end;
end;

//
function FloatToStrFixFmt (fVal: Double; prec, digit: Integer): string;
var
   cnt, dest, Len, I, j: Integer;
   fstr: string;
   Buf: array[0..255] of char;
label end_conv;
begin
   cnt := 0;  dest := 0;
   fstr := FloatToStrF ( fVal, ffGeneral, 15, 3 );
   Len  := Length (fstr);
   for i:=1 to Len do begin
      if fstr[i]='.' then begin
         Buf[dest] := '.'; Inc(dest);
         cnt := 0;
         for j:=i+1 to Len do begin
            if cnt < digit then begin
               Buf[dest] := fstr[j]; Inc(dest);
            end
            else begin
               goto end_conv;
            end;
            Inc(cnt);
         end;
         goto end_conv;
      end;
      if cnt < prec then begin
         Buf[dest] := fstr[i]; Inc(dest);
      end;
      Inc(cnt);
   end;
   end_conv:
   Buf[dest] := char(0);
   Result := strPas(Buf);
end;

//文件大小
function  FileSize (const FName: string): Longint;
var
  SearchRec: TSearchRec;
begin
  if FindFirst(ExpandFileName(FName), faAnyFile, SearchRec) = 0 then
    Result := SearchRec.Size
  else Result := -1;
end;

//文件拷贝
function FileCopy(source,dest: String): Boolean;
var
  fSrc,fDst,len: Integer;
  size: Longint;
  buffer: packed array [0..2047] of Byte;
begin
  Result := False; { Assume that it WONT work }
  if source <> dest then begin
    fSrc := FileOpen(source,fmOpenRead);
    if fSrc >= 0 then begin
      size := FileSeek(fSrc,0,2);
      FileSeek(fSrc,0,0);
      fDst := FileCreate(dest);
      if fDst >= 0 then begin
        while size > 0 do begin
          len := FileRead(fSrc,buffer,sizeof(buffer));
          FileWrite(fDst,buffer,len);
          size := size - len;
        end;
        FileSetDate(fDst,FileGetDate(fSrc));
        FileClose(fDst);
        FileSetAttr(dest,FileGetAttr(source));
        Result := True;
      end;
      FileClose(fSrc);
    end;
  end;
end;

//获取指定字符串中以指定分割符结尾的子串
function GetValidStr3 (Str: string; var Dest: string; const Divider: array of Char): string;
const
   BUF_SIZE = 20480; //$7FFF;
var
   Buf: array[0..BUF_SIZE] of char;
   BufCount, Count, SrcLen, I, ArrCount: Longint;
   Ch: char;
label
	CATCH_DIV;
begin
   try
      SrcLen := Length(Str);
      BufCount := 0;
      Count := 1;

      if SrcLen >= BUF_SIZE-1 then begin
         Result := '';
         Dest := '';
         exit;
      end;

      if Str = '' then begin
         Dest := '';
         Result := Str;
         exit;
      end;
      ArrCount := sizeof(Divider) div sizeof(char);

      while TRUE do begin
         if Count <= SrcLen then begin
            Ch := Str[Count];
            for I:=0 to ArrCount- 1 do
               if Ch = Divider[I] then
                  goto CATCH_DIV;
         end;
         if (Count > SrcLen) then begin
            CATCH_DIV:
            if (BufCount > 0) then begin
               if BufCount < BUF_SIZE-1 then begin
                  Buf[BufCount] := #0;
                  Dest := string (Buf);
                  Result := Copy (Str, Count+1, SrcLen-Count);
               end;
               break;
            end else begin
               if (Count > SrcLen) then begin
                  Dest := '';
                  Result := Copy (Str, Count+2, SrcLen-1);
                  break;
               end;
            end;
         end else begin
            if BufCount < BUF_SIZE-1 then begin
               Buf[BufCount] := Ch;
               Inc (BufCount);
            end;// else
               //ShowMessage ('BUF_SIZE overflow !');
         end;
         Inc (Count);
      end;
   except
      Dest := '';
      Result := '';
   end;
end;

function GetValidStrVal (Str: string; var Dest: string; const Divider: array of Char): string;
//箭磊甫 盒府秦晨 ex) 12.30mV
const
	BUF_SIZE = 15600;
var
	Buf: array[0..BUF_SIZE] of char;
   BufCount, Count, SrcLen, I, ArrCount: Longint;
   Ch: char;
   currentNumeric: Boolean;
   hexmode: Boolean;
label
	CATCH_DIV;
begin
	try
   	//EnterCriticalSection (CSUtilLock);
      hexmode := FALSE;
      SrcLen := Length(Str);
      BufCount := 0;
      Count := 1;
      currentNumeric := FALSE;

      if Str = '' then begin
         Dest := '';
         Result := Str;
         exit;
      end;
      ArrCount := sizeof(Divider) div sizeof(char);

      while TRUE do begin
         if Count <= SrcLen then begin
            Ch := Str[Count];
            for I:=0 to ArrCount- 1 do
               if Ch = Divider[I] then
                  goto CATCH_DIV;
         end;
         if not currentNumeric then begin
            if (Count+1) < SrcLen then begin
               if (Str[Count] = '0') and (UpCase(Str[Count+1]) = 'X') then begin
                  Buf[BufCount] := Str[Count];
                  Buf[BufCount+1] := Str[Count+1];
                  Inc (BufCount, 2);
                  Inc (Count, 2);
                  hexmode := TRUE;
                  currentNumeric := TRUE;
                  continue;
               end;
               if (Ch = '-') and (Str[Count+1] >= '0') and (Str[Count+1] <= '9') then begin
                  currentNumeric := TRUE;
               end;
            end;
            if (Ch >= '0') and (Ch <= '9') then begin
               currentNumeric := TRUE;
            end;
         end else begin
            if hexmode then begin
               if not (((Ch >= '0') and (Ch <= '9')) or
                       ((Ch >= 'A') and (Ch <= 'F')) or
                       ((Ch >= 'a') and (Ch <= 'f'))) then begin
                     Dec (Count);
                     goto CATCH_DIV;
               end;
            end else
               if ((Ch < '0') or (Ch > '9')) and (Ch <> '.') then begin
                  Dec (Count);
                  goto CATCH_DIV;
               end;
         end;
         if (Count > SrcLen) then begin
            CATCH_DIV:
            if (BufCount > 0) then begin
               Buf[BufCount] := #0;
               Dest := string (Buf);
               Result := Copy (Str, Count+1, SrcLen-Count);
               break;
            end else begin
               if (Count > SrcLen) then begin
                  Dest := '';
                  Result := Copy (Str, Count+2, SrcLen-1);
                  break;
               end;
            end;
         end else begin
            if BufCount < BUF_SIZE-1 then begin
               Buf[BufCount] := Ch;
               Inc (BufCount);
            end else
               ShowMessage ('BUF_SIZE overflow !');
         end;
         Inc (Count);
      end;
	finally
   	//LeaveCriticalSection (CSUtilLock);
	end;
end;

//等价于StrtoIntDef()
function Str_ToInt (Str: string; def: Longint): Longint;
begin
   Result := def;
   if Str <> '' then begin
      if ((word(Str[1]) >= word('0')) and (word(str[1]) <= word('9'))) or
         (str[1] = '+') or (str[1] = '-') then
         try
            Result := StrToInt64 (Str);
         except
         end;
   end;
end;

function DuplicateBitmap (bitmap: TBitmap): HBitmap;
var
	hbmpOldSrc, hbmpOldDest, hbmpNew : HBitmap;
   hdcSrc, hdcDest						: HDC;

begin
   hdcSrc := CreateCompatibleDC (0);
   hdcDest := CreateCompatibleDC (hdcSrc);

   hbmpOldSrc := SelectObject(hdcSrc, bitmap.Handle);

   hbmpNew := CreateCompatibleBitmap(hdcSrc, bitmap.Width, bitmap.Height);

   hbmpOldDest := SelectObject(hdcDest, hbmpNew);

   BitBlt(hdcDest, 0, 0, bitmap.Width, bitmap.Height, hdcSrc, 0, 0,
     SRCCOPY);

   SelectObject(hdcDest, hbmpOldDest);
   SelectObject(hdcSrc, hbmpOldSrc);

   DeleteDC(hdcDest);
   DeleteDC(hdcSrc);

   Result := hbmpNew;
end;

procedure SpliteBitmap (DC: HDC; X, Y: integer; bitmap: TBitmap; transcolor: TColor);
var
   hdcMixBuffer, hdcBackMask, hdcForeMask, hdcCopy 	 : HDC;
   hOld, hbmCopy, hbmMixBuffer, hbmBackMask, hbmForeMask : HBitmap;
   oldColor: TColor;
begin
   hbmCopy := DuplicateBitmap (bitmap);
   hdcCopy := CreateCompatibleDC (DC);
   hOld := SelectObject (hdcCopy, hbmCopy);

   hdcBackMask := CreateCompatibleDC (DC);
   hdcForeMask := CreateCompatibleDC (DC);
   hdcMixBuffer:= CreateCompatibleDC (DC);
   hbmBackMask := CreateBitmap (bitmap.Width, bitmap.Height, 1, 1, nil);
   hbmForeMask := CreateBitmap (bitmap.Width, bitmap.Height, 1, 1, nil);
   hbmMixBuffer:= CreateCompatibleBitmap (DC, bitmap.Width, bitmap.Height);

   SelectObject (hdcBackMask, hbmBackMask);
   SelectObject (hdcForeMask, hbmForeMask);
   SelectObject (hdcMixBuffer, hbmMixBuffer);
   oldColor := SetBkColor (hdcCopy, transcolor); //clWhite);

   BitBlt (hdcForeMask, 0, 0, bitmap.Width, bitmap.Height, hdcCopy, 0, 0, SRCCOPY);
   SetBkColor (hdcCopy, oldColor);
   BitBlt( hdcBackMask, 0, 0, bitmap.Width, bitmap.Height, hdcForeMask, 0, 0, NOTSRCCOPY );

   BitBlt( hdcMixBuffer, 0, 0, bitmap.Width, bitmap.Height, DC, X, Y, SRCCOPY );
   BitBlt( hdcMixBuffer, 0, 0, bitmap.Width, bitmap.Height, hdcForeMask, 0, 0, SRCAND );
   BitBlt( hdcCopy, 0, 0, bitmap.Width, bitmap.Height, hdcBackMask, 0, 0, SRCAND );
   BitBlt( hdcMixBuffer, 0, 0, bitmap.Width, bitmap.Height, hdcCopy, 0, 0, SRCPAINT );
   BitBlt( DC, X, Y, bitmap.Width, bitmap.Height, hdcMixBuffer, 0, 0, SRCCOPY );

   {DeleteObject (hbmCopy);}
   DeleteObject( SelectObject( hdcCopy, hOld ) );
   DeleteObject( SelectObject( hdcForeMask, hOld ) );
   DeleteObject( SelectObject( hdcBackMask, hOld ) );
   DeleteObject( SelectObject( hdcMixBuffer, hOld ) );
   DeleteDC( hdcCopy );
   DeleteDC( hdcForeMask );
   DeleteDC( hdcBackMask );
   DeleteDC( hdcMixBuffer );
end;

//取两个整数中的最小值
function _MIN (n1, n2: integer): integer;
begin
	if n1 < n2 then Result := n1
   else Result := n2;
end;
//取两个整数中的最大值
function _MAX (n1, n2: integer): integer;
begin
   if n1 > n2 then Result := n1
   else Result := n2;
end;


end.
