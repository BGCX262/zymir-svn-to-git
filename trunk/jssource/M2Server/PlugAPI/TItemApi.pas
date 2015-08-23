//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit TItemApi;

interface
uses Windows, M2Share, SysUtils, EngineType, ObjBase, ObjNpc, grobal2, ItmUnit;

function TItemUnit_GetItem(nIndex: Integer): TItem; stdcall;
function TItemUnit_sItemName(Item: TItem): _LPTSHORTSTRING; stdcall;
function TItemUnit_nStdMode(Item: TItem): PByte; stdcall;
function TItemUnit_nSellOff(Item: TItem): PByte; stdcall;
function TItemUnit_nLevelItem(Item: TItem): PByte; stdcall;
function TItemUnit_nNeedIdentify(Item: TItem): PByte; stdcall;
function TItemUnit_nItemType(Item: TItem): PByte; stdcall;
procedure TItemUnit_GetStandardItem(Item: TItem; var StdItem: TSTDITEM);
  stdcall;
procedure TItemUnit_GetItemAddValue(UserItem: PTUSERITEM; var StdItem:
  TSTDITEM); stdcall;

implementation

procedure TItemUnit_GetStandardItem(Item: TItem; var StdItem: TSTDITEM);
  stdcall;
begin
  try
    Item.GetStandardItem(StdItem);
  except
    MainOutMessage('[Exception] UnTItemApi.TItemUnit_GetItemAddValue');
  end;
end;

function TItemUnit_nItemType(Item: TItem): PByte; stdcall;
begin
  try
    Result := @Item.ItemType;
  except
    MainOutMessage('[Exception] UnTItemApi.TItemUnit_nItemType');
  end;
end;

function TItemUnit_sItemName(Item: TItem): _LPTSHORTSTRING; stdcall;
begin
  try
    Result := @Item.Name;
  except
    MainOutMessage('[Exception] UnTItemApi.TItemUnit_sItemName');
  end;
end;

function TItemUnit_nLevelItem(Item: TItem): PByte; stdcall;
begin
  try
    Result := @Item.LevelItem;
  except
    MainOutMessage('[Exception] UnTItemApi.TItemUnit_nLevelItem');
  end;
end;

procedure TItemUnit_GetItemAddValue(UserItem: PTUSERITEM; var StdItem: TSTDITEM);
  stdcall;
var
  Item: TItem;
begin
  try
    Item := UserEngine.GetStdItem(UserItem.wIndex);
    Item.GetItemAddValue(UserItem, StdItem);
  except
    MainOutMessage('[Exception] UnTItemApi.TItemUnit_GetItemAddValue');
  end;
end;

function TItemUnit_GetItem(nIndex: Integer): TItem; stdcall;
begin
  try
    Result := UserEngine.GetStdItem(nIndex);
  except
    MainOutMessage('[Exception] UnTItemApi.TItemUnit_GetItem');
  end;
end;

function TItemUnit_nSellOff(Item: TItem): PByte; stdcall;
begin
  try
    Result := @Item.SellOff;
  except
    MainOutMessage('[Exception] UnTItemApi.TItemUnit_nSellOff');
  end;
end;

function TItemUnit_nNeedIdentify(Item: TItem): PByte; stdcall;
begin
  try
    Result := @Item.NeedIdentify;
  except
    MainOutMessage('[Exception] UnTItemApi.TItemUnit_nNeedIdentify');
  end;
end;

function TItemUnit_nStdMode(Item: TItem): PByte; stdcall;
begin
  try
    Result := @Item.StdMode;
  except
    MainOutMessage('[Exception] UnTItemApi.TItemUnit_nStdMode');
  end;
end;

end.

