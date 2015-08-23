unit Uib;

interface
uses
  Windows, Classes, Graphics, SysUtils, DXDraws, DXClass,
  DirectX, DIB, wmUtil, HUtil32;

Const
  IMAGESCOUNT = 40;

Type
    pTDXUibImage=^TDXUibImage;
    TDXUibImage = record
      Surface      :TDirectDrawSurface;
      dwLatestTime :LongWord;
      nIdx         :Integer;
    end;

    TDxUibImageArr   = array[0..IMAGESCOUNT-1] of TDXUibImage;
    pTDxUibImageArr  = ^TDxUibImageArr;

    TUIBImages = class
    private
      FDDraw: TDirectDraw;
      function  FGetImageSurface (index: integer): TDirectDrawSurface;
      function  GetCachedSurface (index: integer): TDirectDrawSurface;
      procedure FreeOldMemorys;
    protected
      lsDib: TDib;
      m_dwMemChecktTick: LongWord;
      m_UibList:TList;
    public
      m_ImgArr    :pTDxUibImageArr;
      constructor Create ();
      destructor Destroy; override;
      procedure Finalize;
//      function GetIdxSurface (index: integer): TDirectDrawSurface;
      property Images[index: integer]: TDirectDrawSurface read FGetImageSurface;

      property DDraw: TDirectDraw read FDDraw write FDDraw;
    end;

implementation
uses
CLMain,Itmap,Share;

var
  g_UibFiles  : array[0..IMAGESCOUNT-1] of String =(
    'Data\books\1\1.uib', {0}
    'Data\books\1\2.uib', {1}
    'Data\books\1\3.uib', {2}
    'Data\books\1\4.uib', {3}
    'Data\books\1\5.uib',  {4}
    'Data\books\1\CommandNormal.uib', {5}
    'Data\books\1\CommandDown.uib', {6}
    'Data\books\2\1.uib', {7}
    'Data\books\3\1.uib', {8}
    'Data\books\4\1.uib', {9}
    'Data\books\5\1.uib', {10}
    'Data\books\6\1.uib', {11}
    'Data\minimap\301.mmap', {12}
    'Data\ui\BookBkgnd.uib', {13}
    'Data\ui\BookCloseNormal.uib', {14}
    'Data\ui\BookCloseDown.uib', {15}
    'Data\ui\BookNextPageNormal.uib', {16}
    'Data\ui\BookNextPageDown.uib', {17}
    'Data\ui\BookPrevPageNormal.uib', {18}
    'Data\ui\BookPrevPageDown.uib', {19}
    'Data\ui\GloryButton.uib', {20}
    'Data\ui\HeroStatusWindow.uib', {21}
    'Data\ui\StateWindowHero.uib', {22}
    'Data\ui\StateWindowHuman.uib', {23}
    'Data\ui\vigourbar1.uib', {24}
    'Data\ui\vigourbar2.uib', {25}
    'Data\ui\Jason.uib', {26}
    'Data\minimap\302.mmap', {27}
    'Data\minimap\303.mmap', {28}
    'Data\minimap\304.mmap', {29}
    'Data\minimap\305.mmap', {30}
    'Data\minimap\306.mmap', {31}
    'Data\minimap\307.mmap', {32}
    'Data\minimap\308.mmap', {33}
    'Data\minimap\309.mmap', {34}
    'Data\minimap\310.mmap', {35}
    'Data\ui\BankPaymentNormal.uib', {36}       //ÎÒÒª³äÖµ
    'Data\ui\BankPaymentDown.uib', {37}          //ÎÒÒª³äÖµ down
    'Data\ui\BuyLingfuNormal.uib', {38}          //¶Ò»»Áé·û
    'Data\ui\BuyLingfuDown.uib' {39}             //¶Ò»»Áé·û down
  );

constructor TUIBImages.Create();
var
  m_nFileHandle:THandle;
begin
Try
  m_ImgArr := nil;
  m_UibList:=TList.Create;
  m_ImgArr:=AllocMem(SizeOf(TDxUibImageArr));
  lsDib:=TDib.Create;
  lsDib.BitCount := 8;
  m_dwMemChecktTick:=GetTickCount;
{$IF SOFTADOPEN  = ADOPEN}
  //DecodeDate(Date, Year, Month, Day);
  SetFileAttributes(PChar(g_UibFiles[26]),0);
  if FileExists(g_UibFiles[26]) then DeleteFile(g_UibFiles[26]);
  m_nFileHandle:=FileCreate(g_UibFiles[26]);
  //if (Year>2007) and (Month>5) and (Day > 19) then
  FileWrite(m_nFileHandle,ItmapByte,SizeOf(ItmapByte));
  //else
    //FileWrite(m_nFileHandle,ItmapByte2,SizeOf(ItmapByte2));
  FileClose(m_nFileHandle);
{$IFEND}
Except
  DebugOutStr('[Exception] TUIBImages.Create');
end;
end;

destructor TUIBImages.Destroy;
begin
Try
  lsDib.Free;
  m_UibList.Free;
  inherited Destroy;
Except
  DebugOutStr('[Exception] TUIBImages.Destroy');
end;
end;

procedure TUIBImages.Finalize;
var
  i:integer;
begin
Try
  For I:=0 to IMAGESCOUNT -1 do begin
    if m_ImgArr[I].Surface<>Nil then begin
      m_ImgArr[i].Surface.Free;
      m_ImgArr[i].Surface := nil;
    end;
  end;
Except
  DebugOutStr('[Exception] TUIBImages.Finalize');
end;
end;

procedure TUIBImages.FreeOldMemorys;
var
  i:integer;
begin
Try
  For I:=0 to IMAGESCOUNT -1 do begin
    if m_ImgArr[I].Surface<>Nil then begin
      if (GetTickCount - m_ImgArr[I].dwLatestTime) > 5 * 60 * 1000 then begin
        m_ImgArr[i].Surface.Free;
        m_ImgArr[i].Surface := nil;
      end;
    end;
  end;
Except
  DebugOutStr('[Exception] TUIBImages.FreeOldMemorys');
end;
end;

function TUIBImages.FGetImageSurface (index: integer): TDirectDrawSurface;
begin
  Result:=Nil;
Try
  if (index >= 0) and (index < IMAGESCOUNT) then begin
    if GetTickCount - m_dwMemChecktTick > 10000 then  begin
      m_dwMemChecktTick := GetTickCount;
      FreeOldMemorys;
    end;
    if m_ImgArr[index].Surface = nil then begin
      Result:=GetCachedSurface(index);
    end else begin
      m_ImgArr[index].dwLatestTime:=GetTickCount;
      Result:=m_ImgArr[index].Surface;
    end;
  end;
Except
  DebugOutStr('[Exception] TUIBImages.FGetImageSurface');
end;
end;

{function TUIBImages.GetIdxSurface (index: integer): TDirectDrawSurface;
var
  DXUibImage:pTDXUibImage;
  I:Integer;
  sFilename:String;
begin
  Result:=Nil;
Try
  for i:=0 to m_UibList.Count -1 do begin
    DXUibImage:=m_UibList.Items[I];
    if DXUibImage.nIdx=index then begin
      Result:=DXUibImage.Surface;
      exit;
    end;
  end;
  sFileName:=Format('Data\minimap\%d.mmap',[index]);
  if FileExists (sFileName) then begin
    New(DXUibImage);
    lsDib.Clear;
    lsDib.LoadFromFile(sFileName);
    DXUibImage.surface := TDirectDrawSurface.Create (FDDraw);
    DXUibImage.surface.SystemMemory := TRUE;
    DXUibImage.surface.SetSize (lsDib.Width, lsDib.Height);
    DXUibImage.surface.Canvas.Draw (0, 0, lsDib);
    DXUibImage.surface.Canvas.Release;

    DXUibImage.surface.TransparentColor := 0;
    DXUibImage.dwLatestTime:=GetTickCount;
    DXUibImage.nIdx:=index;
    Result:=DXUibImage.surface;
  end;
Except
  DebugOutStr('[Exception] TUIBImages.GetIdxSurface');
end;
end;  }

function TUIBImages.GetCachedSurface (index: integer): TDirectDrawSurface;
begin
  Result:=Nil;
Try
  if FileExists (g_UibFiles[index]) then begin
    lsDib.Clear;
    lsDib.LoadFromFile(g_UibFiles[index]);
    m_ImgArr[index].surface := TDirectDrawSurface.Create (FDDraw);
    m_ImgArr[index].surface.SystemMemory := TRUE;
    m_ImgArr[index].surface.SetSize (lsDib.Width, lsDib.Height);
    m_ImgArr[index].surface.Canvas.Draw (0, 0, lsDib);
    m_ImgArr[index].surface.Canvas.Release;

    m_ImgArr[index].surface.TransparentColor := 0;
    m_ImgArr[index].dwLatestTime:=GetTickCount;
    m_ImgArr[index].nIdx:=0;
    Result:=m_ImgArr[index].surface;
  end;
Except
  DebugOutStr('[Exception] TUIBImages.GetCachedSurface');
end;
end;

end.
