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
      10,11    :Result := 0; //�·�
      5, 6     :Result := 1; //����
      15,16    :Result := 2; //ͷ��
      19,20,21 :Result := 3; //����
      30       :Result := 4; //ѫ��
      24,26    :Result := 5; //����
      22,23    :Result := 6; //��ָ
      54,64,27 :Result := 7;  //����
      52,62,28 :Result := 8; //Ь
      53,63,29 :Result := 9; //��ʯ
   end;
end;

end.
