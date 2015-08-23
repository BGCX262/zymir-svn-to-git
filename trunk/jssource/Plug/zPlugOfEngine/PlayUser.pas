unit PlayUser;

interface
uses
  Windows,Classes,SysUtils,EngineAPI,EngineType;
const
  MAXBAGITEM    = 46;

  RM_MENU_OK    = 10309;
type
  TCheckItem = record
    szItemName  :String[14];
    boCanDrop   :Boolean;
    boCanDeal   :Boolean;
    boCanStorage:Boolean;
    boCanRepair :Boolean;
  end;
  pTCheckItem = ^TCheckItem;
  
procedure InitPlayUser();
procedure UnInitPlayUser();
procedure LoadCheckItemList();
procedure UnLoadCheckItemList();
function CheckCanDropItem(PlayObject:TPlayObject;pszItemName:PChar):Boolean;stdcall;
function CheckCanDealItem(PlayObject:TPlayObject;pszItemName:PChar):Boolean;stdcall;
function CheckCanStorageItem(PlayObject:TPlayObject;pszItemName:PChar):Boolean;stdcall;
function CheckCanRepairItem(PlayObject:TPlayObject;pszItemName:PChar):Boolean;stdcall;
var
  g_CheckItemList:Classes.TList;
implementation

uses HUtil32;
procedure InitPlayUser();
begin

  LoadCheckItemList();
  TPlayObject_SetCheckClientDropItem(CheckCanDropItem);
  TPlayObject_SetCheckClientDealItem(CheckCanDealItem);
  TPlayObject_SetCheckClientStorageItem(CheckCanStorageItem);
  TPlayObject_SetCheckClientRepairItem(CheckCanRepairItem);
end;
procedure UnInitPlayUser();
begin
  TPlayObject_SetCheckClientDropItem(nil);
  TPlayObject_SetCheckClientDealItem(nil);
  TPlayObject_SetCheckClientStorageItem(nil);
  TPlayObject_SetCheckClientRepairItem(nil);
  UnLoadCheckItemList();
end;
procedure LoadCheckItemList();
var
  I             :Integer;
  sFileName     :String;
  LoadList      :Classes.TStringList;
  sLineText     :String;
  sItemName     :String;
  sCanDrop      :String;
  sCanDeal      :String;
  sCanStorage   :String;
  sCanRepair    :String;
  CheckItem     :pTCheckItem;
begin
  sFileName:='.\CheckItemList.txt';

  if g_CheckItemList <> nil then begin
    UnLoadCheckItemList();
  end;
  g_CheckItemList:=Classes.TList.Create;
  if not FileExists(sFileName) then begin
    LoadList:=Classes.TStringList.Create();
    LoadList.Add(';��������ֹ��Ʒ�����ļ�');
    LoadList.Add(';��Ʒ����'#9'��'#9'����'#9'��'#9'��');
    LoadList.SaveToFile(sFileName);
    LoadList.Free;
    exit;
  end;
  LoadList:=Classes.TStringList.Create();
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do
  begin
    sLineText:=LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then
    begin
      sLineText:=GetValidStr3(sLineText,sItemName,[' ',#9]);
      sLineText:=GetValidStr3(sLineText,sCanDrop,[' ',#9]);
      sLineText:=GetValidStr3(sLineText,sCanDeal,[' ',#9]);
      sLineText:=GetValidStr3(sLineText,sCanStorage,[' ',#9]);
      sLineText:=GetValidStr3(sLineText,sCanRepair,[' ',#9]);
      if (sItemName <> '') then
      begin
        New(CheckItem);
        CheckItem.szItemName    := sItemName;
        CheckItem.boCanDrop     := sCanDrop = '1';
        CheckItem.boCanDeal     := sCanDeal = '1';
        CheckItem.boCanStorage  := sCanStorage = '1';
        CheckItem.boCanRepair   := sCanRepair = '1';
        g_CheckItemList.Add(CheckItem);
      end;
    end;
  end;
  LoadList.Free;
end;
procedure UnLoadCheckItemList();
var
  I             :Integer;
  CheckItem     :pTCheckItem;
begin
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem:=g_CheckItemList.Items[I];
    Dispose(CheckItem);
  end;
  g_CheckItemList.Free;
  g_CheckItemList:=nil;
end;
function CheckCanDropItem(PlayObject:TPlayObject;pszItemName:PChar):Boolean;stdcall;
ResourceString
  sMsg  = '����Ʒ��ֹ���ڵ��ϣ�����';
var
  I             :Integer;
  CheckItem     :pTCheckItem;
  NormNpc       :TNormNpc;
begin
  Result:=True;
  for I := 0 to g_CheckItemList.Count - 1 do
  begin
    CheckItem:=g_CheckItemList.Items[I];
    if (CheckItem.boCanDrop) and (CompareText(CheckItem.szItemName,pszItemName) = 0) then
    begin
      NormNpc:=TNormNpc_GetManageNpc();
      TBaseObject_SendMsg(PlayObject,NormNpc,RM_MENU_OK,0,Integer(PlayObject),0,0,PChar(sMsg));
      Result:=False;
      break;
    end;
  end;
end;
function CheckCanDealItem(PlayObject:TPlayObject;pszItemName:PChar):Boolean;stdcall;
ResourceString
  sMsg  = '����Ʒ��ֹ���ף�����';
var
  I             :Integer;
  CheckItem     :pTCheckItem;
  NormNpc       :TNormNpc;
begin
  Result:=True;
  for I := 0 to g_CheckItemList.Count - 1 do
  begin
    CheckItem:=g_CheckItemList.Items[I];
    if (CheckItem.boCanDeal) and (CompareText(CheckItem.szItemName,pszItemName) = 0) then
    begin
      NormNpc:=TNormNpc_GetManageNpc();
      TBaseObject_SendMsg(PlayObject,NormNpc,RM_MENU_OK,0,Integer(PlayObject),0,0,PChar(sMsg));
      Result:=False;
      break;
    end;
  end;
end;
function CheckCanStorageItem(PlayObject:TPlayObject;pszItemName:PChar):Boolean;stdcall;
ResourceString
  sMsg  = '����Ʒ��ֹ��ֿ⣡����';
var
  I             :Integer;
  CheckItem     :pTCheckItem;
  NormNpc       :TNormNpc;
begin
  Result:=True;
  for I := 0 to g_CheckItemList.Count - 1 do
  begin
    CheckItem:=g_CheckItemList.Items[I];
    if (CheckItem.boCanStorage) and (CompareText(CheckItem.szItemName,pszItemName) = 0) then
    begin
      NormNpc:=TNormNpc_GetManageNpc();
      TBaseObject_SendMsg(PlayObject,NormNpc,RM_MENU_OK,0,Integer(PlayObject),0,0,PChar(sMsg));
      Result:=False;
      break;
    end;
  end;
end;
function CheckCanRepairItem(PlayObject:TPlayObject;pszItemName:PChar):Boolean;stdcall;
ResourceString
  sMsg  = '����Ʒ��ֹ��������';
var
  I             :Integer;
  CheckItem     :pTCheckItem;
  NormNpc       :TNormNpc;
begin
  Result:=True;
  for I := 0 to g_CheckItemList.Count - 1 do
  begin
    CheckItem:=g_CheckItemList.Items[I];
    if (CheckItem.boCanRepair) and (CompareText(CheckItem.szItemName,pszItemName) = 0) then
    begin
      NormNpc:=TNormNpc_GetManageNpc();
      TBaseObject_SendMsg(PlayObject,NormNpc,RM_MENU_OK,0,Integer(PlayObject),0,0,PChar(sMsg));
      Result:=False;
      break;
    end;
  end;
end;

end.
