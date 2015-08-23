//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit Shopping;

interface
uses
  grobal2, ObjBase, M2Share, Classes, ComCtrls, EDcode, HUtil32, SysUtils,
    UsrEngn, ItmUnit;

type
  TShopping = class
    m_ShopMsg: array[0..5] of string;
    m_ONewShopMsg: array[0..5] of string;
    m_NewShopMsg2: array[0..5] of string;
    m_Item: TList;
  private
  public
    constructor Create(); virtual;
    destructor Destroy; override;
    procedure ClearList;
    function GetMsg(PlayObject: TPlayObject; Idx: Integer): string;
    function LoadItems(): Boolean;
    function SaveItemToFile(): Boolean;
    procedure EDcodeMsg();
    function ShopItems(PlayObject: TPlayObject; ItemName: string): Integer;
    function ShopSendItems(PlayObject: TPlayObject; Msg: string): Integer;
    function CheckItemName(ItemName: string; var vFileItem: pTFileItem):
      Boolean;
  end;
var
  Shop: TShopping;

implementation

constructor TShopping.Create();
var
  I: Integer;
begin
  try
    m_Item := TList.Create;
    m_Item.Clear;
    for I := Low(m_ShopMsg) to High(m_ShopMsg) do
    begin
      m_ShopMsg[I] := '';
      m_ONewShopMsg[I] := '';
      m_NewShopMsg2[I] := '';
    end;
    LoadItems;
    EDcodeMsg;
  except
    MainOutMessage('[Exception] TShopping.Create');
  end;
end;

destructor TShopping.Destroy;
begin
  try
    ClearList;
    m_Item.Free;
  except
    MainOutMessage('[Exception] TShopping.Destroy');
  end;
end;

procedure TShopping.ClearList;
var
  I: Integer;
  FileItem: pTFileItem;
begin
  try
    for I := 0 to m_Item.Count - 1 do
    begin
      FileItem := m_Item.Items[I];
      Dispose(FileItem);
    end;
    m_Item.Clear;
    for I := Low(m_ShopMsg) to High(m_ShopMsg) do
    begin
      m_ShopMsg[I] := '';
      m_ONewShopMsg[I] := '';
      m_NewShopMsg2[I] := '';
    end;
  except
    MainOutMessage('[Exception] TShopping.ClearList');
  end;
end;

function TShopping.GetMsg(PlayObject: TPlayObject; Idx: Integer): string;
begin
  try
    if idx in [0..5] then
    begin
      if PlayObject.m_dwClientTickEx > 20080108 then
      begin
        Result := m_NewShopMsg2[idx];
      end
      else if PlayObject.m_dwClientTickEx > 20070927 then
      begin
        Result := m_ONewShopMsg[idx];
      end
      else
        Result := m_ShopMsg[idx];
    end;
  except
    MainOutMessage('[Exception] TShopping.GetMsg');
  end;
end;

function TShopping.LoadItems(): Boolean;
var
  sFile: TStringList;
  I: Integer;
  sStr, sData: string;
  sIdx: string;
  nIdx: Integer;
  FileItem: pTFileItem;
begin
  try
    Result := False;
    sFile := TStringList.Create;
    try
      try
        ClearList;
        try
          sFile.LoadFromFile(g_Config.sEnvirDir + 'ShopItemList.txt');
        except
          exit;
        end;
        for I := 0 to sFile.Count - 1 do
        begin
          sStr := sFile.Strings[I];
          if (sStr <> '') and (sStr[1] <> ';') then
          begin
            sStr := GetValidStr3(sStr, sIdx, [' ', #9]);
            nIdx := Str_ToInt(sIdx, -1);
            if nIdx in [0..5] then
            begin
              New(FileItem);
              //FillChar(FileItem,SizeOf(TFileItem),#0);
              FileItem.Idx := nIdx;
              sStr := GetValidStr3(sStr, sData, [' ', #9]);
              FileItem.sName := sData;
              sStr := GetValidStr3(sStr, sData, [' ', #9]);
              FileItem.sItem := Str_ToInt(sData, 0);
              sStr := GetValidStr3(sStr, sData, [' ', #9]);
              FileItem.sPrict := Str_ToInt(sData, 1);
              sStr := GetValidStr3(sStr, sData, [' ', #9]);
              FileItem.sEffect := Str_ToInt(sData, 0);
              sStr := GetValidStr3(sStr, sData, [' ', #9]);
              FileItem.sEffectCount := Str_ToInt(sData, 1);
              sStr := GetValidStr3(sStr, sData, [' ', #9]);
              FileItem.sText := sData;
              if UserEngine.GetStdItemIdx(FileItem.sName) >= 0 then
                m_Item.Add(FileItem)
              else
                Dispose(FileItem);
            end;
          end;
        end;
      finally
        sFile.Free;
      end;
    except
      MainOutMessage('[Exception] TShopping.LoadItems');
    end;
  except
    MainOutMessage('[Exception] TShopping.LoadItems');
  end;
end;

function TShopping.SaveItemToFile(): Boolean;
resourcestring
  sText = '%d'#9'%s'#9'%d'#9'%d'#9'%d'#9'%d'#9'%s';
var
  sFile: TStringList;
  FileItem: pTFileItem;
  I: Integer;
  sStr: string;
begin
  try
    Result := False;
    sFile := TStringList.Create;
    try
      try
        for I := 0 to m_Item.Count - 1 do
        begin
          FileItem := m_Item.Items[I];
          sStr := Format(sText, [FileItem.Idx,
            FileItem.sName,
              FileItem.sItem,
              FileItem.sPrict,
              FileItem.sEffect,
              FileItem.sEffectCount,
              FileItem.sText]);
          sFile.Add(sStr);
        end;
        sFile.SaveToFile(g_Config.sEnvirDir + 'ShopItemList.txt');
      finally
        sFile.Free;
      end;
    except
      MainOutMessage('[Exception] TShopping.SaveItemToFile');
    end;
  except
    MainOutMessage('[Exception] TShopping.SaveItemToFile');
  end;
end;

procedure TShopping.EDcodeMsg();
var
  pFileItem: pTFileItem;
  I, n: Integer;
  sStr: array[0..5] of string;
  sNewStr: array[0..5] of string;
  sNewStr2: array[0..5] of string;
  FileItem: TFileItem;
  ONewFileItem: TONewFileItem;
  NewFileItem: TNewFileItem;
  Item: TItem;
begin
  try
    try
      for I := Low(sStr) to High(sStr) do
      begin
        sStr[I] := '';
        sNewStr[I] := '';
        sNewStr2[I] := '';
      end;
      n := 0;
      for I := 0 to m_Item.Count - 1 do
      begin
        pFileItem := m_Item.Items[I];
        FileItem := pFileItem^;
        FillChar(ONewFileItem, SizeOf(TONewFileItem), #0);
        FillChar(NewFileItem, SizeOf(TNewFileItem), #0);
        if FileItem.Idx in [0..5] then
        begin
          if FileItem.Idx = 5 then
          begin
            if n < 5 then
              Inc(n)
            else
              Continue;
          end;
          sStr[FileItem.Idx] := sStr[FileItem.Idx] + EncodeBuffer(@FileItem,
            SizeOf(TFileItem)) + '/';
          Move(FileItem, ONewFileItem, SizeOf(TFileItem));
          Move(FileItem, NewFileItem, SizeOf(TFileItem));
          Item := UserEngine.GetStdItem(ONewFileItem.sName);
          if Item <> nil then
          begin
            Item.GetStandardItem(ONewFileItem.Item.S);
            ONewFileItem.Item.MakeIndex := 0;
            ONewFileItem.Item.Dura := ONewFileItem.Item.S.DuraMax;
            ONewFileItem.Item.DuraMax := ONewFileItem.Item.S.DuraMax;
            sNewStr[ONewFileItem.Idx] := sNewStr[ONewFileItem.Idx] +
              EncodeBuffer(@ONewFileItem, SizeOf(TONewFileItem)) + '/';

            Item.GetStandardItem(NewFileItem.Item.S);
            NewFileItem.Item.Desc := Item.sDesc;
            NewFileItem.Item.Shine := 0;
            NewFileItem.Item.MakeIndex := 0;
            NewFileItem.Item.Dura := NewFileItem.Item.S.DuraMax;
            NewFileItem.Item.DuraMax := NewFileItem.Item.S.DuraMax;
            sNewStr2[NewFileItem.Idx] := sNewStr2[NewFileItem.Idx] +
              EncodeBuffer(@NewFileItem, SizeOf(TNewFileItem)) + '/';
            //MainOutMessage(IntToStr(NewFileItem.Item.Dura));
          end;
        end;
      end;
      for I := Low(m_ShopMsg) to High(m_ShopMsg) do
      begin
        m_ShopMsg[I] := sStr[I];
        m_ONewShopMsg[I] := sNewStr[I];
        m_NewShopMsg2[I] := sNewStr2[I];
      end;
    except
      MainOutMessage('[Exception] Shopping->EDcodeMsg');
    end;
  except
    MainOutMessage('[Exception] TShopping.EDcodeMsg');
  end;
end;

function TShopping.ShopSendItems(PlayObject: TPlayObject; Msg: string): Integer;
var
  ItemName, UserName: string;
  UserObject: TPlayObject;
  FileItem: pTFileItem;
  UserItem: pTUserItem;
  StdItem: TItem;
begin
  Result := -20;
  try
    UserName := GetValidStr3(Msg, ItemName, [#13]);
    UserObject := UserEngine.GetPlayObject(UserName);
    if UserObject <> nil then
    begin
      Result := -1;
      if CheckItemName(ItemName, FileItem) then
      begin
        if (FileItem <> nil) and (FileItem.sPrict > 0) then
        begin
          Result := -3;
          if PlayObject.m_nGameGold >= FileItem.sPrict then
          begin
            New(UserItem);
            UserEngine.CopyToUserItemFromName(ItemName, UserItem);
            if UserObject.AddItemToBag(UserItem) then
            begin
              Dec(PlayObject.m_nGameGold, FileItem.sPrict);
              UserObject.SendAddItem(UserItem);
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              if g_boGameLogGameGold then
                AddGameDataLog(format(g_sGameLogMsg1, [LOG_GAMEGOLD,
                  PlayObject.m_sMapName,
                    PlayObject.m_nCurrX,
                    PlayObject.m_nCurrY,
                    PlayObject.m_sCharName,
                    g_Config.sGameGoldName,
                    FileItem.sPrict,
                    '-',
                    '商铺']));
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog(IntToStr(LOG_SHOPBUY) + #9 +
                  PlayObject.m_sMapName + #9 +
                  IntToStr(PlayObject.m_nCurrX) + #9 +
                  IntToStr(PlayObject.m_nCurrY) + #9 +
                  PlayObject.m_sCharName + #9 +
                  //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                  StdItem.Name + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '1' + #9 +
                  UserObject.m_sCharName);
              PlayObject.SysMsg(Format('[成功]:向玩家[%s]赠送的物品[%s]，已成功发送！', [UserName, StdItem.Name]), c_Red, t_hint);
              UserObject.SysMsg(Format('[接收]:玩家[%s]向你赠送了[%s]！', [PlayObject.m_sCharName, StdItem.Name]), c_Red, t_hint);
              Result := 1;
              exit;
            end
            else
            begin
              DisPose(UserItem);
              Result := -24; //背包空间不够
              Exit;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TShopping.ShopSendItems');
  end;
end;

function TShopping.ShopItems(PlayObject: TPlayObject; ItemName: string):
  Integer;
var
  FileItem: pTFileItem;
  UserItem: pTUserItem;
  StdItem: TItem;
begin
  try
    Result := -10;
    if CheckItemName(ItemName, FileItem) then
    begin
      if (FileItem <> nil) and (FileItem.sPrict > 0) then
      begin
        if PlayObject.m_nGameGold >= FileItem.sPrict then
        begin
          New(UserItem);
          UserEngine.CopyToUserItemFromName(ItemName, UserItem);
          if PlayObject.AddItemToBag(UserItem) then
          begin
            Dec(PlayObject.m_nGameGold, FileItem.sPrict);
            PlayObject.SendAddItem(UserItem);
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if g_boGameLogGameGold then
              AddGameDataLog(format(g_sGameLogMsg1, [LOG_GAMEGOLD,
                PlayObject.m_sMapName,
                  PlayObject.m_nCurrX,
                  PlayObject.m_nCurrY,
                  PlayObject.m_sCharName,
                  g_Config.sGameGoldName,
                  FileItem.sPrict,
                  '-',
                  '商铺']));
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog(IntToStr(LOG_SHOPBUY) + #9 +
                PlayObject.m_sMapName + #9 +
                IntToStr(PlayObject.m_nCurrX) + #9 +
                IntToStr(PlayObject.m_nCurrY) + #9 +
                PlayObject.m_sCharName + #9 +
                //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                StdItem.Name + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                '商铺');
            Result := 1;
            exit;
          end
          else
          begin
            DisPose(UserItem);
            Result := -4; //背包空间不够
            Exit;
          end;
        end
        else
          Result := -3; //身上元宝不够支付
      end
      else
        exit; //取物品属性失败,或物品价格小于1;
    end
    else
      Result := -1; //购买的物品不在商品列表当中
  except
    MainOutMessage('[Exception] TShopping.ShopItems');
  end;
end;

function TShopping.CheckItemName(ItemName: string; var vFileItem: pTFileItem):
  Boolean;
var
  FileItem: pTFileItem;
  I: Integer;
begin
  try
    Result := False;
    for I := 0 to m_Item.Count - 1 do
    begin
      FileItem := m_Item.Items[I];
      if CompareText(ItemName, FileItem.sName) = 0 then
      begin
        vFileItem := FileItem;
        Result := True;
        Exit;
      end;
    end;
  except
    MainOutMessage('[Exception] TShopping.CheckItemName');
  end;
end;

end.

