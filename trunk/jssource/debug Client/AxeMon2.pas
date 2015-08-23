//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit AxeMon2;

interface
uses
  Windows, Messages, SysUtils, Classes, ExtCtrls, Graphics, Controls, Forms, Dialogs,
  Grobal2, DxDraws, CliUtil, ClFunc, magiceff, Actor, ClEvent;

type
  TPsycheActor = class (TActor)//Size 0x274
   protected
      Cx                  :integer;    //0x264
      Cy                  :integer;    //0x268
      CorpsEffect         :TDirectDrawSurface;    //0x258
   public
      constructor Create; override;
      procedure DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
      procedure LoadSurface; override;
   end;
implementation
uses
   ClMain, SoundUtil, WIL, MShare;

constructor TPsycheActor.Create;
begin
Try //程序自动增加
  inherited Create;
  CorpsEffect:=Nil;
Except //程序自动增加
  DebugOutStr('[Exception] TPsycheActor.Create'); //程序自动增加
End; //程序自动增加
end;

procedure TPsycheActor.LoadSurface;
var
  mimg: TWMImages;
begin
Try //程序自动增加
  inherited LoadSurface;
  mimg := GetMonImg (m_wAppearance);
  if mimg <> nil then begin
    if (not m_boReverseFrame) then
      CorpsEffect:=mimg.GetCachedImage(GetOffset(m_wAppearance)+m_nCurrentFrame-360,
                                       Cx,
                                       Cy)
    else
      CorpsEffect:=mimg.GetCachedImage(GetOffset (m_wAppearance) + m_nEndFrame - (m_nCurrentFrame-m_nStartFrame)-360,
                                       Cx,
                                       Cy);
  end;
Except //程序自动增加
  DebugOutStr('[Exception] TPsycheActor.LoadSurface'); //程序自动增加
End; //程序自动增加
end;

procedure TPsycheActor.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean);
var
   idx: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
   wimg: TWMImages;
   ax, ay: integer;
begin
Try //程序自动增加
   if not (m_btDir in [0..7]) then exit;
   if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
   end;

   if CorpsEffect<>nil then
      DrawBlend (dsurface,
                 dx + Cx + m_nShiftX,
                 dy + Cy + m_nShiftY,
                 CorpsEffect,
                 1);

   ceff := GetDrawEffectValue;

   if m_BodySurface <> nil then
      DrawEffSurface (dsurface,
                      m_BodySurface,
                      dx + m_nPx + m_nShiftX,
                      dy + m_nPy + m_nShiftY,
                      blend,
                      ceff);
      
   if m_boUseMagic and (m_CurMagic.EffectNumber > 0) then
      if m_nCurEffFrame in [0..m_nSpellFrame-1] then begin
         GetEffectBase (m_CurMagic.EffectNumber-1, 0, wimg, idx);
         idx := idx + m_nCurEffFrame;
         if wimg <> nil then
            d := wimg.GetCachedImage (idx, ax, ay);
         if d <> nil then
            DrawBlend (dsurface,
                             dx + ax + m_nShiftX,
                             dy + ay + m_nShiftY,
                             d, 1);
      end;
Except //程序自动增加
  DebugOutStr('[Exception] TPsycheActor.DrawChr'); //程序自动增加
End; //程序自动增加
end;

end.
