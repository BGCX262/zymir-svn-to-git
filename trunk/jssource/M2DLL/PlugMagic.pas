unit PlugMagic;

interface
uses
SysUtils,EngineApi,PlugShare,EngineType;

procedure MagicInitPlug();
procedure MagicUnInitPlug();

function MagicDoSpell(AObject:TObject;PlayObject:TPlayObject;UserMagic:_LPTUSERMAGIC;nTargetX,nTargetY:Integer;TargeTBaseObject:TBaseObject;var nHookStatus:Integer):Boolean;stdcall;

implementation

procedure MagicInitPlug();
begin
  TMagicManager_SetHookDoSpell(@MagicDoSpell);
end;

procedure MagicUnInitPlug();
begin
end;

function MagicDoSpell(AObject:TObject;PlayObject:TPlayObject;UserMagic:_LPTUSERMAGIC;nTargetX,nTargetY:Integer;TargeTBaseObject:TBaseObject;var nHookStatus:Integer):Boolean;stdcall;
ResourceString
  sException  = '[Exception][M2Server.dll] MagicDoSpell';
  sMagSelfFun = '@MagSelfFunc%d';
  sMagTagFunc = '@MagTagFunc%d';
var
  NormNpc:TNormNpc;
begin
  Result:=True;
  Try
    NormNpc:=TNormNpc_GETFUNCTIONNPC();
    if NormNpc<>Nil then begin
      if (TargeTBaseObject<>Nil) and (PlayObject<>TargeTBaseObject) then begin
        if (TBaseObject_btRaceServer(TargeTBaseObject)^=0) and (not TBaseObject_boHero(TargeTBaseObject)) then
          TNormNpc_GotoLable(NormNpc,TargeTBaseObject,PChar(Format(sMagTagFunc,[UserMagic.wMagIdx])));
      end else TNormNpc_GotoLable(NormNpc,PlayObject,PChar(Format(sMagSelfFun,[UserMagic.wMagIdx])));
    end;
  Except
    MainOutMessage(PChar(sException));
  end;
end;

end.
