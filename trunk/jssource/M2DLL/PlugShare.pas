unit PlugShare;

interface
uses
EngineType,PlacingItem,EngineApi;

var
  g_MemMgr:_TMEMORYMANAGE;
  g_PlacingItem:TPlacingItem;


  function  GetTakeOnPosition (smode: integer): integer;
  function  GetShortStrings (ShortString:_LPTSHORTSTRING):String;

implementation

function  GetShortStrings (ShortString:_LPTSHORTSTRING):String;
begin
  Result:=Copy(ShortString.Strings,1,ShortString.btLen);
end;

function  GetTakeOnPosition (smode: integer): integer;
begin
   Result := 10;
   case smode of //StdMode
      10,11    :Result := 0; //衣服
      5, 6     :Result := 1; //武器
      15,16    :Result := 2; //头盔
      19,20,21 :Result := 3; //项链
      30       :Result := 4; //勋章
      24,26    :Result := 5; //手镯
      22,23    :Result := 6; //戒指
      54,64,27 :Result := 7;  //腰带
      52,62,28 :Result := 8; //鞋
      53,63,29 :Result := 9; //宝石
   end;
end;

end.
