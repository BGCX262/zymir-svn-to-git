unit PlacingItem;

interface
uses
  Windows, Classes, SysUtils, StrUtils, Imagehlp, ExtCtrls, Grobal2, ObjBase,
  ItmUnit, ObjNpc;

const
  LISTCOUNT = 11;
  SAVEITEMNAME = 'Items.db';

type
  TPlacingHead = packed record
    dwDateTime: TDateTime;
    nCount: integer; //20
    n1: integer; //24
    n2: integer; //28
    n3: integer; //32
    n4: integer; //36
    n5: integer; //40
  end;

  TPlacingItem = class
    m_SaveDir: string;
    m_AllList: Classes.TList;
    m_BuyList: Classes.TList;
    m_TempList: Classes.TList;
    m_ItemList: array[0..LISTCOUNT - 1] of Classes.TList;
  private
    //CriticalSection:TRTLCriticalSection;
    procedure Lock();
    procedure UnLock();
    procedure ClearAllList();
    procedure LoadAllList();

    procedure AddItemToList(UserPlacing: pTUserPlacing; nStdMode: Integer;
      boFlag: Boolean);
    function GetTakeOnPosition(smode: integer): integer;
    function CheckPlaySideNpc(PlayObject: TPlayObject; NormNpc: TObject):
      TMerchant;
  public
    constructor Create(FilePath: string);
    destructor Destroy; override;
    procedure SaveAllList();
    procedure ClientAddItemToList(PlayObject: TPlayObject; nParam1, nMakeIndex,
      nClass: Integer; sMsg: string);
    procedure ClientGetItemList(PlayObject: TPlayObject; nIdx, nPage, nFind:
      integer; sData: string);
    procedure ClientBuyItem(PlayObject: TPlayObject; nItemIndex: Integer);
  end;

implementation
uses
  M2Share, HUtil32, EDcode;

function TPlacingItem.GetTakeOnPosition(smode: integer): integer;
begin
  Result := 10;
  case smode of //StdMode
    10, 11: Result := 0; //衣服
    5, 6: Result := 1; //武器
    15, 16: Result := 2; //头盔
    19, 20, 21: Result := 3; //项链
    30: Result := 4; //勋章
    24, 26: Result := 5; //手镯
    22, 23: Result := 6; //戒指
    54, 64, 27: Result := 7; //腰带
    52, 62, 28: Result := 8; //鞋
    53, 63, 29: Result := 9; //宝石
  end;
end;

function TPlacingItem.CheckPlaySideNpc(PlayObject: TPlayObject; NormNpc:
  TObject): TMerchant;
var
  Merchant: TMerchant;
begin
  try
    Result := nil;
    Merchant := UserEngine.FindMerchant(NormNpc);
    if (Merchant <> nil) and
      ((Merchant.m_PEnvir = PlayObject.m_PEnvir) and
      (abs(Merchant.m_nCurrX - PlayObject.m_nCurrX) < 15) and
      (abs(Merchant.m_nCurrY - PlayObject.m_nCurrY) < 15)) then
      Result := Merchant;
  except
    MainOutMessage('[Exception] TPlacingItem.CheckPlaySideNpc');
  end;
end;

constructor TPlacingItem.Create(FilePath: string);
var
  I: integer;
begin
  //InitializeCriticalSection(CriticalSection);
  m_SaveDir := FilePath;
  m_SaveDir := m_SaveDir + CONSIGNATIONDIR;
  MakeSureDirectoryPathExists(PChar(m_SaveDir));
  m_AllList := Classes.TList.Create;
  m_BuyList := Classes.TList.Create;
  m_TempList := Classes.TList.Create;
  for i := Low(m_ItemList) to High(m_ItemList) do
    m_ItemList[I] := Classes.TList.Create;
  LoadAllList;
end;

destructor TPlacingItem.Destroy;
var
  I: integer;
begin
  SaveAllList;
  ClearAllList;
  //DeleteCriticalSection(CriticalSection);
  m_AllList.Free;
  m_BuyList.Free;
  m_TempList.Free;
  for i := Low(m_ItemList) to High(m_ItemList) do
    m_ItemList[I].Free;
end;

procedure TPlacingItem.ClearAllList();
var
  i: integer;
begin
  try
    Lock;
    try
      for I := 0 to m_AllList.Count - 1 do
        Dispose(pTUserPlacing(m_AllList.Items[I]));
      m_AllList.Clear;
      for I := 0 to m_BuyList.Count - 1 do
        Dispose(pTUserPlacing(m_BuyList.Items[I]));
      m_BuyList.Clear;
      for i := Low(m_ItemList) to High(m_ItemList) do
        m_ItemList[I].Clear;
    finally
      UnLock;
    end;
  except
    MainOutMessage('[Exception][M2Server.dll] TPlacingItem.ClearAllList');
  end;
end;

procedure TPlacingItem.AddItemToList(UserPlacing: pTUserPlacing; nStdMode:
  Integer; boFlag: Boolean);
begin
  if UserPlacing.boSell then
  begin
    m_BuyList.Add(UserPlacing);
  end
  else
  begin
    UserPlacing.nIdx := GetTakeOnPosition(nStdMode);
    if boFlag then
    begin
      m_AllList.Insert(0, UserPlacing);
      m_ItemList[UserPlacing.nIdx].Insert(0, UserPlacing);
    end
    else
    begin
      m_AllList.Add(UserPlacing);
      m_ItemList[UserPlacing.nIdx].Add(UserPlacing);
    end;
  end;
end;

procedure TPlacingItem.ClientGetItemList(PlayObject: TPlayObject; nIdx, nPage,
  nFind: integer; sData: string);

  function GetSellItemList(): Classes.TList;
  var
    i: integer;
    UserPlacing: pTUserPlacing;
  begin
    m_TempList.Clear;
    try
      for I := 0 to m_BuyList.Count - 1 do
      begin
        UserPlacing := m_BuyList.Items[I];
        if CompareText(PlayObject.m_sCharName, UserPlacing.sName) = 0 then
          m_TempList.Add(UserPlacing);
      end;
      for I := 0 to m_AllList.Count - 1 do
      begin
        UserPlacing := m_AllList.Items[I];
        if CompareText(PlayObject.m_sCharName, UserPlacing.sName) = 0 then
          m_TempList.Add(UserPlacing);
      end;
    finally
      Result := m_TempList;
    end;
  end;

  function GetFindSellItemList(List: Classes.TList): Classes.TList;
  var
    i: integer;
    UserPlacing: pTUserPlacing;
  begin
    m_TempList.Clear;
    try
      for I := 0 to List.Count - 1 do
      begin
        UserPlacing := List.Items[I];
        if AnsiContainsText(UserPlacing.sItemName, sData) then
          m_TempList.Add(UserPlacing);
      end;
    finally
      Result := m_TempList;
    end;
  end;

  procedure GetMyItemPicCount();
  resourcestring
    sGold = '金币：%d  税收：%d 实收：%d';
    nGameGold = '%s：%d  税收：%d 实收：%d';
  var
    i: integer;
    UserPlacing: pTUserPlacing;
    nGameGoldCount, nGoldCount, nTGameGoldCount, nTGoldCount: Integer;
    //GameGold,Gold,nTGameGold,nTGold:pInteger;
    boSend: Boolean;
  begin
    //sName:=TBaseObject_sCharName(PlayObject).Strings;
    //GameGold:=TPlayObject_nGameGold(PlayObject);
    //Gold:=TBaseObject_nGold(PlayObject);
    boSend := False;
    nGameGoldCount := 0;
    nGoldCount := 0;
    nTGameGoldCount := 0;
    nTGoldCount := 0;
    for I := m_BuyList.Count - 1 downto 0 do
    begin
      UserPlacing := m_BuyList.Items[I];
      if CompareText(PlayObject.m_sCharName, UserPlacing.sName) = 0 then
      begin
        if UserPlacing.nPicCls then
        begin
          if (PlayObject.m_nGameGold + UserPlacing.nPrice) < High(Integer) then
          begin
            boSend := True;
            Inc(PlayObject.m_nGameGold, UserPlacing.nPrice);
            Inc(nGameGoldCount, UserPlacing.nPrice);
            Dispose(UserPlacing);
            m_BuyList.Delete(I);
          end;
        end
        else
        begin
          if (PlayObject.m_nGold + UserPlacing.nPrice) < High(Integer) then
          begin
            boSend := True;
            Inc(PlayObject.m_nGold, UserPlacing.nPrice);
            Inc(nGoldCount, UserPlacing.nPrice);
            Dispose(UserPlacing);
            m_BuyList.Delete(I);
          end;
        end;
      end;
    end;
    PlayObject.SysMsg('提取完成。', c_Red, t_Hint);
    if boSend then
    begin
      if nGameGoldCount > 0 then
      begin
        nTGameGoldCount := Trunc(g_Config.nSellOffGameGoldTaxRate / 100 *
          nGameGoldCount);
        if nTGameGoldCount > 0 then
          Dec(g_Config.nSellOffGameGoldTaxRate, nTGameGoldCount);
      end;
      if nGoldCount > 0 then
      begin
        nTGoldCount := Trunc(g_Config.nSellOffGoldTaxRate / 100 * nGoldCount);
        if nTGoldCount > 0 then
          Dec(g_Config.nSellOffGoldTaxRate, nTGoldCount);
      end;
      PlayObject.SysMsg(Format(sGold, [nGoldCount, nTGoldCount, nGoldCount -
        nTGoldCount]), c_Red, t_Hint);
      PlayObject.SysMsg(Format(nGameGold, [g_Config.sGameGoldName,
        nGameGoldCount, nTGameGoldCount, nGameGoldCount - nTGameGoldCount]),
          c_Red, t_Hint);
    end;
    if (nGameGoldCount > 0) and (g_boGameLogGameGold) then
      AddGameDataLog(PChar(IntToStr(28) + #9 +
        PlayObject.m_sMapName + #9 +
        IntToStr(PlayObject.m_nCurrX) + #9 +
        IntToStr(PlayObject.m_nCurrY) + #9 +
        PlayObject.m_sCharName + #9 +
        g_Config.sGameGoldName + #9 +
        IntToStr(nGameGoldCount) + #9 +
        '+' + #9 +
        '寄售'));
    if (nGoldCount > 0) and (g_boGameLogGold) then
      AddGameDataLog(PChar(IntToStr(14) + #9 +
        PlayObject.m_sMapName + #9 +
        IntToStr(PlayObject.m_nCurrX) + #9 +
        IntToStr(PlayObject.m_nCurrY) + #9 +
        PlayObject.m_sCharName + #9 +
        '金币' + #9 +
        IntToStr(nGoldCount) + #9 +
        '+' + #9 +
        '寄售'));

    if boSend then
      PlayObject.GoldChanged;
  end;
var
  nIndex, I: Integer;
  nNowPage, nMaxPage: Word;
  magtop, magline: Integer;
  m_List: Classes.TList;
  OClientPlacing: TOClientPlacing;
  ClientPlacing: TClientPlacing;
  UserPlacing: pTUserPlacing;
  //  ClientItem:TClientItem;
  DefMsg: TDefaultMessage;
  sMsg: string;
  Item: TItem;
begin
  try
    Lock;
    try
      if nIdx in [0..13] then
      begin
        nIndex := nIdx - 1;
        case nIndex of
          0..10: m_List := m_ItemList[nIndex];
          11: m_List := GetSellItemList();
          12:
            begin
              GetMyItemPicCount;
              exit;
            end;
        else
          m_List := m_AllList;
        end;
        if (nFind = 1) and (sData <> '') then
          m_List := GetFindSellItemList(m_List)
        else
          nFind := 0;
        nMaxPage := _MAX((m_List.Count + 9) div 10 - 1, 0);
        if nPage > nMaxPage then
          nNowPage := nMaxPage
        else
          nNowPage := _MAX(nPage, 0);
        magtop := nNowPage * 10;
        magline := _MIN(nNowPage * 10 + 10, m_List.Count);
        sMsg := '';
        for I := magtop to magline - 1 do
        begin
          UserPlacing := m_List.Items[I];
          FillChar(OClientPlacing, SizeOf(TOClientPlacing), #0);
          FillChar(ClientPlacing, SizeOf(TClientPlacing), #0);
          Item := UserEngine.GetStdItem(UserPlacing.Item.wIndex);
          if Item <> nil then
          begin
            if PlayObject.m_dwClientTickEx > 20080108 then
            begin
              Item.GetStandardItem(ClientPlacing.Item.S);
              Item.GetItemAddValue(@UserPlacing.Item, ClientPlacing.Item.S);
              ClientPlacing.Item.S.Name := GetItemName(@UserPlacing.Item);
              ClientPlacing.Item.Desc := Item.sDesc;
              ClientPlacing.Item.Shine := 0;
              ClientPlacing.Item.Dura := UserPlacing.Item.Dura;
              ClientPlacing.Item.DuraMax := UserPlacing.Item.DuraMax;
              ClientPlacing.Item.MakeIndex := UserPlacing.Item.MakeIndex;
              GetMapItemInfo(@UserPlacing.Item, ClientPlacing.Item.S);

              ClientPlacing.nPrice := UserPlacing.nPrice;
              ClientPlacing.nPicCls := UserPlacing.nPicCls;
              ClientPlacing.nTime := UserPlacing.nTime;
              ClientPlacing.sName := UserPlacing.sName;
              ClientPlacing.nSell := UserPlacing.boSell;
              sMsg := sMsg + EncodeBuffer(@ClientPlacing, SizeOf(TClientPlacing))
                + '/';
            end
            else
            begin
              Item.GetStandardItem(OClientPlacing.Item.S);
              Item.GetItemAddValue(@UserPlacing.Item, OClientPlacing.Item.S);
              OClientPlacing.Item.S.Name := GetItemName(@UserPlacing.Item);

              OClientPlacing.Item.Dura := UserPlacing.Item.Dura;
              OClientPlacing.Item.DuraMax := UserPlacing.Item.DuraMax;
              OClientPlacing.Item.MakeIndex := UserPlacing.Item.MakeIndex;
              GetMapItemInfo(@UserPlacing.Item, OClientPlacing.Item.S);

              OClientPlacing.nPrice := UserPlacing.nPrice;
              OClientPlacing.nPicCls := UserPlacing.nPicCls;
              OClientPlacing.nTime := UserPlacing.nTime;
              OClientPlacing.sName := UserPlacing.sName;
              OClientPlacing.nSell := UserPlacing.boSell;
              sMsg := sMsg + EncodeBuffer(@OClientPlacing,
                SizeOf(TOClientPlacing)) + '/';
            end;
          end;
        end;
        DefMsg := MakeDefaultMsg(SM_SELLOFFLIST, nIdx, nNowPage, nMaxPage,
          nFind);
        if sMsg = '' then
          PlayObject.SendSocket(@DefMsg, '')
        else
          PlayObject.SendSocket(@DefMsg, PChar(sMsg));
      end;
    finally
      UnLock;
    end;
  except
    on E: Exception do
    begin
      MainOutMessage('[Exception] TPlacingItem.ClientGetItemList');
      MainOutMessage(PChar(E.Message));
    end;
  end;
end;

procedure TPlacingItem.ClientBuyItem(PlayObject: TPlayObject; nItemIndex:
  Integer);
var
  AllIdx, Idx: Integer;
  UserPlacing: pTUserPlacing;
  nCode: Integer;
  boOk: Boolean;
  UserCount: PInteger;
  boSelf: Boolean;
  Item: TItem;
  UserItem: pTUserItem;

  function FindIdx(): Boolean;
  var
    I: integer;
    UserPlacing32: pTUserPlacing;
  begin
    AllIdx := -1;
    Idx := -1;
    UserPlacing := nil;
    Result := False;
    for I := 0 to m_AllList.Count - 1 do
    begin
      UserPlacing := m_AllList.Items[I];
      if UserPlacing.Item.MakeIndex = nItemIndex then
      begin
        Allidx := I;
        break;
      end;
    end;
    if UserPlacing <> nil then
    begin
      for I := 0 to m_ItemList[UserPlacing.nIdx].Count - 1 do
      begin
        UserPlacing32 := m_ItemList[UserPlacing.nIdx].Items[I];
        if UserPlacing = UserPlacing32 then
        begin
          Idx := I;
          Break;
        end;
      end;
    end;
    if (AllIdx >= 0) and (Idx >= 0) then
      Result := True;
  end;

begin
  try
    Lock;
    try
      nCode := 0;
      boOK := False;
      boSelf := False;
      if FindIdx then
      begin
        nCode := 1;
        if UserPlacing.nPicCls then
          UserCount := @PlayObject.m_nGameGold
        else
          UserCount := @PlayObject.m_nGold;
        if CompareText(PlayObject.m_sCharName, UserPlacing.sName) = 0 then
          boSelf := True;
        if (UserCount^ >= UserPlacing.nPrice) or boSelf then
        begin
          nCode := 2;
          New(UserItem);
          UserItem^ := UserPlacing.Item;
          if PlayObject.AddItemToBag(UserItem) then
          begin
            boOk := True;
            PlayObject.SendAddItem(UserItem);
            m_AllList.Delete(AllIdx);
            m_ItemList[UserPlacing.nIdx].Delete(Idx);
            Item := UserEngine.GetStdItem(UserItem.wIndex);
            if Item.NeedIdentify = 1 then
              AddGameDataLog(IntToStr(LOG_SELLOFFITEMBUY) + #9 +
                PlayObject.m_sMapName + #9 +
                IntToStr(PlayObject.m_nCurrX) + #9 +
                IntToStr(PlayObject.m_nCurrY) + #9 +
                PlayObject.m_sCharName + #9 +
                Item.Name + #9 +
                IntToStr(UserPlacing.Item.MakeIndex) + #9 +
                IntToStr(Integer(UserPlacing.nPicCls)) + #9 +
                UserPlacing.sName);
            if not boSelf then
            begin
              Dec(UserCount^, UserPlacing.nPrice);
              PlayObject.GoldChanged();
              UserPlacing.boSell := True;
              AddItemToList(UserPlacing, 0, True);
            end
            else
              Dispose(UserPlacing);
            //SaveAllList();
          end
          else
            Dispose(UserItem);
        end;
      end;
      if not boOk then
        PlayObject.SendDefMessage(SM_SELLOFFITEMBUY_FAIL, nCode, 0, 0, 0, '');
    finally
      UnLock;
    end;
  except
    on E: Exception do
    begin
      MainOutMessage('[Exception][M2Server.dll] TPlacingItem.ClientBuyItem');
      MainOutMessage(PChar(E.Message));
    end;
  end;
end;

procedure TPlacingItem.ClientAddItemToList(PlayObject: TPlayObject; nParam1,
  nMakeIndex, nClass: Integer; sMsg: string);
var
  NormNpc: TMerchant;
  nPicCount: Integer;
  I: integer;
  UserItem: pTUserItem;
  Item: TItem;
  UserPlacing: pTUserPlacing;
  nCode: Integer;
  boOk: Boolean;
  function GetSellOffItemCount(): Integer;
  var
    i: integer;
    UserPlacing: pTUserPlacing;
  begin
    Result := 0;
    for I := 0 to m_BuyList.Count - 1 do
    begin
      UserPlacing := m_BuyList.Items[I];
      if CompareText(PlayObject.m_sCharName, UserPlacing.sName) = 0 then
        Inc(Result);
    end;
    for I := 0 to m_AllList.Count - 1 do
    begin
      UserPlacing := m_AllList.Items[I];
      if CompareText(PlayObject.m_sCharName, UserPlacing.sName) = 0 then
        Inc(Result);
    end;
  end;
begin
  try
    boOk := False;
    nCode := -1;
    Lock;
    try
      nPicCount := Str_ToInt(sMsg, 0);
      NormNpc := CheckPlaySideNpc(PlayObject, TObject(nParam1));
      if (NormNpc <> nil) and
        (NormNpc.m_boSellOff) and
        (nPicCount > 0) and
        (nPicCount < High(integer)) and
        (nClass in [0, 1]) then
      begin
        nCode := 0;
        for I := 0 to PlayObject.m_ItemList.Count - 1 do
        begin
          UserItem := PlayObject.m_ItemList.Items[I];
          if (UserItem <> nil) and (UserItem.MakeIndex = nMakeIndex) then
          begin
            Item := UserEngine.GetStdItem(UserItem.wIndex);
            nCode := 1;
            if (Item <> nil) and (UserItem.btValue[15] = 0) and (Item.SellOff =
              1) then
            begin
              if GetSellOffItemCount() < g_Config.nSellOffItemCount then
              begin
                boOk := True;
                New(UserPlacing);
                UserPlacing.Item := UserItem^;
                UserPlacing.nPrice := nPicCount;
                UserPlacing.nPicCls := nClass = 1;
                UserPlacing.nTime := Now;
                UserPlacing.sName := PlayObject.m_sCharName;
                UserPlacing.boSell := False;
                UserPlacing.sItemName := Item.Name;
                AddItemToList(UserPlacing, Item.StdMode, True);
                PlayObject.DelBagItem(UserItem.MakeIndex, '');
                if Item.NeedIdentify = 1 then
                  AddGameDataLog(PChar(IntToStr(LOG_SELLOFFITEM) + #9 +
                    PlayObject.m_sMapName + #9 +
                    IntToStr(PlayObject.m_nCurrX) + #9 +
                    IntToStr(PlayObject.m_nCurrY) + #9 +
                    PlayObject.m_sCharName + #9 +
                    Item.Name + #9 +
                    IntToStr(nMakeIndex) + #9 +
                    IntToStr(nClass) + #9 +
                    NormNpc.m_sCharName));
              end
              else
              begin
                PlayObject.SendMsg(PlayObject, RM_MENU_OK, 0,
                  Integer(PlayObject), 0, 0,
                  '[失败]: 每个人物最多只允许寄售[' +
                  IntToStr(g_Config.nSellOffItemCount) + ']个物品');
              end;
              //SaveAllList();
            end;
            break;
          end;
        end;
      end;
      if boOk then
        PlayObject.SendDefMessage(SM_SELLOFFITEM_OK, 0, 0, 0, 0, '')
      else
        PlayObject.SendDefMessage(SM_SELLOFFITEM_FAIL, nCode, 0, 0, 0, '');
    finally
      UnLock;
    end;
  except
    on E: Exception do
    begin
      MainOutMessage('[Exception] TPlacingItem.ClientAddItemToList');
      MainOutMessage(PChar(E.Message));
    end;
  end;
end;

procedure TPlacingItem.LoadAllList();
resourcestring
  sExceptItem =
    '[物品不存在] 寄售人：%s 物品代码：%d 物品ID：%d';
var
  sFile: string;
  nFileHandle: THandle;
  Head: TPlacingHead;
  I: integer;
  UserPlacing: TUserPlacing;
  UserPlacing32: pTUserPlacing;
  StdItem: TItem;
begin
  Lock;
  try
    sFile := m_SaveDir + SAVEITEMNAME;
    if FileExists(sFile) then
    begin
      nFileHandle := FileOpen(sFile, fmOpenRead or fmShareDenyNone);
      try
        if nFileHandle > 0 then
        begin
          FileSeek(nFileHandle, 0, 0);
          if FileRead(nFileHandle, Head, SizeOf(TPlacingHead)) =
            SizeOf(TPlacingHead) then
          begin
            for I := 0 to Head.nCount - 1 do
            begin
              if FileRead(nFileHandle, UserPlacing, SizeOf(TUserPlacing)) =
                SizeOf(TUserPlacing) then
              begin
                StdItem := UserEngine.GetStdItem(UserPlacing.Item.wIndex);
                if StdItem <> nil then
                begin
                  New(UserPlacing32);
                  UserPlacing32^ := UserPlacing;
                  UserPlacing32.sItemName := StdItem.Name;
                  AddItemToList(UserPlacing32, StdItem.StdMode, False);
                end
                else
                  MainOutMessage(PChar(Format(sExceptItem,
                    [UserPlacing.sName,
                    UserPlacing.Item.wIndex,
                      UserPlacing.Item.MakeIndex])));
              end
              else
                break;
            end;
          end;
        end;
      finally
        FileClose(nFileHandle);
      end;
    end;
  finally
    UnLock;
  end;
end;

procedure TPlacingItem.SaveAllList();
resourcestring
  sException = '[Exception] TPlacingItem.SaveAllList';
var
  sFile: string;
  nFileHandle: integer;
  Head: TPlacingHead;
  UserPlacing: pTUserPlacing;
  i: integer;
  m_SaveList: Classes.TList;
begin
  Lock;
  m_SaveList := Classes.TList.Create;
  try
    try
      for I := 0 to m_AllList.Count - 1 do
        m_SaveList.Add(m_AllList.Items[I]);
      for I := 0 to m_BuyList.Count - 1 do
        m_SaveList.Add(m_BuyList.Items[I]);

      sFile := m_SaveDir + SAVEITEMNAME;
      if m_SaveList.Count > 0 then
      begin
        if FileExists(sFile) then
          nFileHandle := FileOpen(sFile, fmOpenWrite or fmShareDenyNone)
        else
          nFileHandle := FileCreate(sFile);
        try
          if nFileHandle > 0 then
          begin
            FillChar(Head, Sizeof(TPlacingHead), #0);
            FileSeek(nFileHandle, 0, 0);
            Head.dwDateTime := Now;
            Head.nCount := m_SaveList.Count;
            FileWrite(nFileHandle, Head, SizeOf(TPlacingHead));
            for i := 0 to m_SaveList.Count - 1 do
            begin
              UserPlacing := m_SaveList.Items[I];
              if UserPlacing <> nil then
                FileWrite(nFileHandle, UserPlacing^, SizeOf(TUserPlacing));
            end;
          end;
        finally
          FileClose(nFileHandle);
        end;
      end;
    except
      MainOutMessage(PChar(sException));
    end;
  finally
    m_SaveList.Free;
    UnLock;
  end;
end;

procedure TPlacingItem.Lock();
begin
  //EnterCriticalSection(CriticalSection);
end;

procedure TPlacingItem.UnLock();
begin
  //LeaveCriticalSection(CriticalSection);
end;

initialization
  begin

  end;

finalization
  begin

  end;

end.

