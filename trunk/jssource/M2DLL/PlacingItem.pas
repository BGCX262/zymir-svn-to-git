unit PlacingItem;

interface
uses
  Windows, Classes,SysUtils,StrUtils,EngineApi,EngineType,Imagehlp,grobal2,ExtCtrls;

Const
  LISTCOUNT     = 11;
  SAVEITEMNAME  = 'Items.db';


Type
  TPlacingHead=packed record
    dwDateTime:TDateTime;
    nCount:integer;    //20
    n1:integer;        //24
    n2:integer;        //28
    n3:integer;        //32
    n4:integer;        //36
    n5:integer;        //40
  end;

  TPlacingItem=class
      m_SaveDir     :String;
      m_AllList     :Classes.TList;
      m_BuyList     :Classes.TList;
      //m_TempList    :Classes.TList;
      //m_ItemList    :Array[0..LISTCOUNT-1] of Classes.TList;
    private
      CriticalSection:TRTLCriticalSection;
      //SaveTimer:TTimer;
      procedure  Lock();
      procedure  UnLock();
      procedure  LoadAllList();
      procedure  SaveAllList();
      procedure  ClearAllList();
      {


      procedure  AddItemToList(UserPlacing:pTUserPlacing;nStdMode:Integer;boFlag:Boolean);}
    public
      constructor Create(FilePath:String);
      destructor Destroy;override;
      procedure  ClientAddItemToList(PlayObject:TPlayObject;nParam1,nMakeIndex,nClass:Integer;sMsg:String);
      procedure  ClientBuyItem(PlayObject:TPlayObject;nItemIndex:Integer);
      procedure  ClientGetItemList(PlayObject:TPlayObject;nIdx,nPage,nFind:integer;sData:String);
      {//procedure  SaveTimerTimer(Sender: TObject);

      procedure  ClientGetItemList(PlayObject:TPlayObject;nIdx,nPage,nFind:integer;sData:String);
      procedure  ClientBuyItem(PlayObject:TPlayObject;nItemIndex:Integer);}
  end;

  procedure PLItem_Init();
  procedure PLItem_UnInit();

implementation
uses
PlugShare,HUtil32;


procedure PLItem_Init();
var
  Path:_TDIRNAME;
begin
  Path:=TConfig_sUserDataDir^;
  g_PlacingItem:=TPlacingItem.Create(Path);
end;

procedure PLItem_UnInit();
begin
  g_PlacingItem.Free;
end;

constructor TPlacingItem.Create(FilePath:String);
begin
  InitializeCriticalSection(CriticalSection);
  m_AllList:=Classes.TList.Create;
  m_BuyList:=Classes.TList.Create;
  m_SaveDir:=FilePath;
  m_SaveDir:=m_SaveDir+CONSIGNATIONDIR;
  MakeSureDirectoryPathExists(PChar(m_SaveDir));
  LoadAllList;
  {
  m_AllList:=Classes.TList.Create;
  m_BuyList:=Classes.TList.Create;
  m_TempList:=Classes.TList.Create;
  For i:=Low(m_ItemList) to High(m_ItemList) do
    m_ItemList[I]:=Classes.TList.Create;

  SaveTimer:=TTimer.Create(Nil);
  SaveTimer.OnTimer:= SaveTimerTimer;
  SaveTimer.Interval:=5*60*1000;
  SaveTimer.Enabled:=True; }
end;

destructor TPlacingItem.Destroy;
begin
  SaveAllList;
  ClearAllList;
  m_AllList.Free;
  m_BuyList.Free;
  DeleteCriticalSection(CriticalSection);
end;

procedure TPlacingItem.ClearAllList();
var
  i:Integer;
begin
  For I:=0 to m_AllList.Count-1 do
    Dispose(_LPTUSERPLACING(m_AllList.Items[I]));
  m_AllList.Clear;
  For I:=0 to m_BuyList.Count-1 do
    Dispose(_LPTUSERPLACING(m_BuyList.Items[I]));
  m_BuyList.Clear;
end;

procedure TPlacingItem.LoadAllList();
ResourceString
  sExceptItem = '[物品不存在] 寄售人：%d 物品代码：%d 物品ID：%d';
var
  sFile:String;
  nFileHandle:THandle;
  Head:TPlacingHead;
  I:integer;
  UserPlacing:_TUSERPLACING;
  UserPlacing32:_LPTUSERPLACING;
  StdItem:_LPTSTDITEM;
begin
  sFile:=m_SaveDir+SAVEITEMNAME;
  if FileExists(sFile) then begin
    nFileHandle:=FileOpen(sFile,fmOpenRead or fmShareDenyNone);
    Try
      if nFileHandle > 0 then begin
        FileSeek(nFileHandle,0,0);
        if FileRead(nFileHandle,Head,SizeOf(TPlacingHead))= SizeOf(TPlacingHead) then begin
          For I:=0 to Head.nCount-1 do begin
            if FileRead(nFileHandle,UserPlacing,SizeOf(_TUSERPLACING))= SizeOf(_TUSERPLACING) then begin
              StdItem:=TUserEngine_GetStdItemByIndex(UserPlacing.Item.wIndex);
              if StdItem<>Nil then begin
                New(UserPlacing32);
                UserPlacing32^:=UserPlacing;
                UserPlacing32.sItemName:=StdItem.Name;
                if UserPlacing32.boSell then m_BuyList.Add(UserPlacing32)
                else m_AllList.Add(UserPlacing32);
              end else
                MainOutMessage(PChar(Format(sExceptItem,
                                     [UserPlacing.sName,
                                      UserPlacing.Item.wIndex,
                                      UserPlacing.Item.nMakeIndex])));
            end else break;
          end;
        end;
      end;
    Finally
      FileClose(nFileHandle);
    end;
  end;
end;

procedure TPlacingItem.SaveAllList();
ResourceString
  sException = '[Exception][M2Server.dll] TPlacingItem.SaveAllList';
var
  sFile:String;
  nFileHandle:integer;
  Head:TPlacingHead;
  UserPlacing:_LPTUSERPLACING;
  i:integer;
  m_SaveList:Classes.TList;
begin
  m_SaveList:=Classes.TList.Create;
  Try
    Try
      For I:=0 to m_AllList.Count -1 do m_SaveList.Add(m_AllList.Items[I]);
      For I:=0 to m_BuyList.Count -1 do m_SaveList.Add(m_BuyList.Items[I]);

      sFile:=m_SaveDir+SAVEITEMNAME;
      if m_SaveList.Count > 0 then begin
        if FileExists(sFile) then nFileHandle:=FileOpen(sFile,fmOpenWrite or fmShareDenyNone)
        else nFileHandle:=FileCreate(sFile);
        Try
          if nFileHandle > 0 then begin
            FillChar(Head,Sizeof(TPlacingHead),#0);
            FileSeek(nFileHandle,0,0);
            Head.dwDateTime:=Now;
            Head.nCount:=m_SaveList.Count;
            FileWrite(nFileHandle,Head,SizeOf(TPlacingHead));
            For i:=0 to m_SaveList.Count-1 do begin
              UserPlacing:=m_SaveList.Items[I];
              if UserPlacing<>nil then
                FileWrite(nFileHandle,UserPlacing^,SizeOf(_TUSERPLACING));
            end;
          end;
        Finally
          FileClose(nFileHandle);
        end;
      end;
    Except
      MainOutMessage(PChar(sException));
    end;
  Finally
    m_SaveList.Free;
  end;
end;

procedure TPlacingItem.ClientAddItemToList(PlayObject:TPlayObject;nParam1,nMakeIndex,nClass:Integer;sMsg:String);
var
  sName:String;
  NormNpc:TNormNpc;
  nPicCount:Integer;
  ItemList:EngineType.TList;
  I:integer;
  UserItem:_LPTUSERITEM;
  Item:TItem;
  UserPlacing:_LPTUSERPLACING;
  nCode:Integer;
  boOk:Boolean;
begin
Try
  boOk:=False;
  nCode:=-1;
  Lock;
  Try
    nPicCount:=Str_ToInt(sMsg,0);
    NormNpc:=TPlayObject_CheckPlaySideNpc(PlayObject,TObject(nParam1));
    if (NormNpc<>Nil) and
       (TMerchant_boSellOff(NormNpc)^) and
       (nPicCount > 0) and
       (nPicCount<High(integer)) and
       (nClass in [0,1]) then begin
      sName:=GetShortStrings(TBaseObject_sCharName(PlayObject));
      ItemList:=TBaseObject_ItemList(PlayObject);
      nCode:=0;
      For I:=0 to TList_Count(ItemList) -1 do begin
        UserItem:=TList_Get(ItemList,I);
        if (UserItem<>Nil) and (UserItem.nMakeIndex = nMakeIndex) then begin
          Item:=TItemUnit_GetItem(UserItem.wIndex);
          nCode:=1;
          if (Item<>Nil) and (UserItem.btValue[15]=0) and (TItemUnit_nSellOff(Item)^ = 1) then begin
            boOk:=True;
            New(UserPlacing);
            UserPlacing.Item:=UserItem^;
            //Move(UserItem^,UserPlacing^.Item,SizeOf(_TUserItem));
            UserPlacing.nPrice:=nPicCount;
            UserPlacing.nPicCls:=nClass = 1;
            UserPlacing.nTime:=Now;
            UserPlacing.sName:=sName;
            UserPlacing.boSell:=False;
            UserPlacing.sItemName:=GetShortStrings(TItemUnit_sItemName(Item));
            UserPlacing.nIdx:=GetTakeOnPosition(TItemUnit_nStdMode(Item)^);
            TBaseObject_DeleteBagItem(PlayObject,UserItem);
            if TItemUnit_nNeedIdentify(Item)^ = 1 then
                AddGameDataLog(PChar(IntToStr(LOG_SELLOFFITEM) +  #9 +
                                     GetShortStrings(TBaseObject_sMapName(PlayObject)) + #9 +
                                     IntToStr(TBaseObject_nCurrX(PlayObject)^) + #9 +
                                     IntToStr(TBaseObject_nCurrY(PlayObject)^) + #9 +
                                     sName + #9 +
                                     GetShortStrings(TItemUnit_sItemName(Item)) + #9 +
                                     IntToStr(nMakeIndex) + #9 +
                                     IntToStr(nClass) + #9 +
                                     GetShortStrings(TBaseObject_sCharName(NormNpc))));
            SaveAllList();
          end;
          break;
        end;
      end;
    end;
    if boOk then TPlayObject_SendDefMessage(PlayObject,SM_SELLOFFITEM_OK,0,0,0,0,Nil)
    else TPlayObject_SendDefMessage(PlayObject,SM_SELLOFFITEM_FAIL,nCode,0,0,0,Nil);
  Finally
    UnLock;
  end;
Except
  on E: Exception do begin
      MainOutMessage('[Exception][M2Server.dll] TPlacingItem.ClientAddItemToList');
      MainOutMessage(PChar(E.Message));
  end;
end;
end;

procedure TPlacingItem.ClientBuyItem(PlayObject:TPlayObject;nItemIndex:Integer);
var
  I:Integer;
  UserPlacing:_LPTUSERPLACING;
  nCode:Integer;
  boOk:Boolean;
  UserCount:PInteger;
  boSelf:Boolean;
  sName:String;
  Item:TItem;
begin
  Lock;
  Try
    nCode:=0;
    boOK:=False;
    boSelf:=False;
    For I:=0 to m_AllList.Count-1 do begin
      UserPlacing:=m_AllList.Items[I];
      if (UserPlacing<>Nil) and (UserPlacing.Item.nMakeIndex=nItemIndex) then begin
        nCode:=1;
        if UserPlacing.nPicCls then UserCount:=TPlayObject_nGameGold(PlayObject)
        else UserCount:=TBaseObject_nGold(PlayObject);
        sName:=GetShortStrings(TBaseObject_sCharName(PlayObject));
        if CompareText(sName,UserPlacing.sName)=0 then boSelf:=True;
        if (UserCount^ >= UserPlacing.nPrice) or boSelf then begin
          nCode:=2;
          if TBaseObject_AddItemToBag(PlayObject,@UserPlacing.Item) then begin
            boOk:=True;
            TPlayObject_SendAddItem(PlayObject,@UserPlacing.Item);
            m_AllList.Delete(I);
            Item:=TItemUnit_GetItem(UserPlacing.Item.wIndex);
            if TItemUnit_nNeedIdentify(Item)^ = 1 then
                AddGameDataLog(PChar(IntToStr(LOG_SELLOFFITEMBUY) +  #9 +
                                     GetShortStrings(TBaseObject_sMapName(PlayObject)) + #9 +
                                     IntToStr(TBaseObject_nCurrX(PlayObject)^) + #9 +
                                     IntToStr(TBaseObject_nCurrY(PlayObject)^) + #9 +
                                     sName + #9 +
                                     GetShortStrings(TItemUnit_sItemName(Item)) + #9 +
                                     IntToStr(UserPlacing.Item.nMakeIndex) + #9 +
                                     IntToStr(Integer(UserPlacing.nPicCls)) + #9 +
                                     UserPlacing.sName));
            if Not boSelf then begin
              Dec(UserCount^,UserPlacing.nPrice);
              TBaseObject_GoldChanged(PlayObject);
              UserPlacing.boSell:=True;
              m_BuyList.Add(UserPlacing);
            end else Dispose(UserPlacing);
            SaveAllList();
          end;
        end;
        break;
      end;
    end;
    if Not boOk then TPlayObject_SendDefMessage(PlayObject,SM_SELLOFFITEMBUY_FAIL,nCode,0,0,0,Nil);
  Finally
    UnLock;
  end;        
end;

procedure TPlacingItem.ClientGetItemList(PlayObject:TPlayObject;nIdx,nPage,nFind:integer;sData:String);
  procedure GetShowItemList(nIndex:Integer;List:Classes.TList);
  var
    i:integer;
    UserPlacing:_LPTUSERPLACING;
  begin
    List.Clear;
    For I:=0 to m_AllList.Count-1 do begin
      UserPlacing:=m_AllList.Items[I];
      if (UserPlacing<>Nil) and ((UserPlacing.nIdx=nIndex) or (nIndex=-1)) then begin
        List.Add(UserPlacing);
      end;
    end;
  end;

  procedure GetSellItemList(List:Classes.TList);
  var
    sName:String;
    i:integer;
    UserPlacing:_LPTUSERPLACING;
  begin
    List.Clear;
    sName:=GetShortStrings(TBaseObject_sCharName(PlayObject));
    For I:=0 to m_AllList.Count-1 do begin
      UserPlacing:=m_AllList.Items[I];
      if (UserPlacing<>Nil) and (CompareText(sName,UserPlacing.sName)=0) then List.Add(UserPlacing);
    end;
    For I:=0 to m_BuyList.Count-1 do begin
      UserPlacing:=m_BuyList.Items[I];
      if (UserPlacing<>Nil) and (CompareText(sName,UserPlacing.sName)=0) then List.Add(UserPlacing);
    end;
  end;

  procedure GetMyItemPicCount();
  ResourceString
    sGold     = '金币：%d  税收：%d 实收：%d';
    nGameGold = '%s：%d  税收：%d 实收：%d';
  var
    sName:String;
    i:integer;
    UserPlacing:_LPTUSERPLACING;
    nGameGoldCount,nGoldCount,nTGameGoldCount,nTGoldCount:Integer;
    GameGold,Gold,nTGameGold,nTGold:pInteger;
    boSend:Boolean;
    GoldName:String;
  begin
    sName:=GetShortStrings(TBaseObject_sCharName(PlayObject));
    GameGold:=TPlayObject_nGameGold(PlayObject);
    Gold:=TBaseObject_nGold(PlayObject);
    boSend:=False;
    nGameGoldCount:=0;
    nGoldCount:=0;
    nTGameGoldCount:=0;
    nTGoldCount:=0;
    GoldName:=GetShortStrings(GetGameGoldName());
    For I:=m_BuyList.Count-1 Downto 0 do begin
      UserPlacing:=m_BuyList.Items[I];
      if CompareText(sName,UserPlacing.sName)=0 then begin
        if UserPlacing.nPicCls then begin
          if (GameGold^+UserPlacing.nPrice) < High(Integer) then begin
            boSend:=True;
            Inc(GameGold^,UserPlacing.nPrice);
            Inc(nGameGoldCount,UserPlacing.nPrice);
            Dispose(UserPlacing);
            m_BuyList.Delete(I);
          end;
        end else begin
          if (Gold^+UserPlacing.nPrice) < High(Integer) then begin
            boSend:=True;
            Inc(Gold^,UserPlacing.nPrice);
            Inc(nGoldCount,UserPlacing.nPrice);
            Dispose(UserPlacing);
            m_BuyList.Delete(I);
          end;
        end;
      end;
    end;
    TBaseObject_SysMsg(PlayObject,'提取完成。',mc_Red,mt_Hint);
    if boSend then begin
      nTGameGold:=GetSellOffGameGoldTaxRate();
      nTGold:=GetSellOffGoldTaxRate();
      if nGameGoldCount > 0 then begin
        nTGameGoldCount:=Trunc(nTGameGold^/100*nGameGoldCount);
        if nTGameGoldCount > 0 then Dec(GameGold^,nTGameGoldCount);
      end;
      if nGoldCount > 0 then begin
        nTGoldCount:=Trunc(nTGold^/100*nGoldCount);
        if nTGoldCount > 0 then Dec(Gold^,nTGoldCount);
      end;
      TBaseObject_SysMsg(PlayObject,PChar(Format(sGold,[nGoldCount,nTGoldCount,nGoldCount-nTGoldCount])),mc_Red,mt_Hint);
      TBaseObject_SysMsg(PlayObject,PChar(Format(nGameGold,[GoldName,nGameGoldCount,nTGameGoldCount,nGameGoldCount-nTGameGoldCount])),mc_Red,mt_Hint);
    end;
    if (nGameGoldCount > 0) and (GetGameLogGameGold()^) then
      AddGameDataLog(PChar(IntToStr(28) +  #9 +
                           GetShortStrings(TBaseObject_sMapName(PlayObject)) + #9 +
                           IntToStr(TBaseObject_nCurrX(PlayObject)^) + #9 +
                           IntToStr(TBaseObject_nCurrY(PlayObject)^) + #9 +
                           sName + #9 +
                           GoldName + #9 +
                           IntToStr(nGameGoldCount) + #9 +
                           '+' + #9 +
                           '寄售'));
    if (nGoldCount > 0) and (GetGameLogGold()^) then
      AddGameDataLog(PChar(IntToStr(14) +  #9 +
                           GetShortStrings(TBaseObject_sMapName(PlayObject)) + #9 +
                           IntToStr(TBaseObject_nCurrX(PlayObject)^) + #9 +
                           IntToStr(TBaseObject_nCurrY(PlayObject)^) + #9 +
                           sName + #9 +
                           '金币' + #9 +
                           IntToStr(nGoldCount) + #9 +
                           '+' + #9 +
                           '寄售'));

    if boSend then begin
      TBaseObject_GoldChanged(PlayObject);
      SaveAllList();
    end;
  end;

  procedure GetFindSellItemList(List:Classes.TList);
  var
    i:integer;
    UserPlacing:_LPTUSERPLACING;
  begin
    For I:=List.Count-1 downto 0 do begin
      UserPlacing:=List.Items[I];
      if not AnsiContainsText(UserPlacing.sItemName,sData) then List.Delete(I);
    end;
  end;

var
  nIndex,I:Integer;
  m_List:Classes.TList;
  nNowPage,nMaxPage:Word;
  magtop,magline:Integer;
  ClientPlacing:TClientPlacing;
  UserPlacing:_LPTUSERPLACING;
  ClientItem:_TCLIENTITEM;
  DefMsg:_TDEFAULTMESSAGE;
  sMsg:String;
begin
Try
  Lock;
  Try
    if nIdx in [0..13] then begin
      nIndex:=nIdx-1;
      m_List:=Classes.TList.Create;
      Try
        case nIndex of
          0..10   : GetShowItemList(nIndex,m_List);
          11      : GetSellItemList(m_List);
          12      : begin
            GetMyItemPicCount;
            exit;
          end;
          else      GetShowItemList(nIndex,m_List);
        end;
        if (nFind=1) and (sData<>'') then GetFindSellItemList(m_List)
        else nFind:=0;
        nMaxPage:=_MAX((m_List.Count+9) div 10 - 1,0);
        if nPage > nMaxPage then nNowPage:=nMaxPage
        else nNowPage:=_MAX(nPage,0);
        magtop := nNowPage * 10;
        magline := _MIN(nNowPage*10+10,m_List.Count);
        sMsg:='';
        for I:=magtop to magline-1 do begin
          UserPlacing:=m_List.Items[I];
          FillChar(ClientPlacing,SizeOf(TClientPlacing),#0);
          if TUserEngine_GetClientItem(@UserPlacing.Item,ClientItem) then begin
            Move(ClientItem,ClientPlacing.Item,SizeOf(_TCLIENTITEM));
            ClientPlacing.nPrice:=UserPlacing.nPrice;
            ClientPlacing.nPicCls:=UserPlacing.nPicCls;
            ClientPlacing.nTime:=UserPlacing.nTime;
            ClientPlacing.sName:=UserPlacing.sName;
            ClientPlacing.nSell:=UserPlacing.boSell;
            sMsg:=sMsg + EncodeBuffer(@ClientPlacing,SizeOf(TClientPlacing)) + '/';
          end;
        end;
        DefMsg:=EngineAPI.MakeDefaultMsg(SM_SELLOFFLIST,nIdx,nNowPage,nMaxPage,nFind);
        if sMsg='' then TPlayObject_SendSocket(PlayObject,@DefMsg,Nil)
        else TPlayObject_SendSocket(PlayObject,@DefMsg,PChar(sMsg));
      Finally
        m_List.Free;
      end;
    end;
  Finally
    UnLock;
  end;
Except
  on E: Exception do begin
    MainOutMessage('[Exception][M2Server.dll] TPlacingItem.ClientGetItemList');
    MainOutMessage(PChar(E.Message));
  end;
end;
end;

procedure TPlacingItem.Lock();
begin
  EnterCriticalSection(CriticalSection);
end;

procedure TPlacingItem.UnLock();
begin
  LeaveCriticalSection(CriticalSection);
end;

initialization
begin

end;

finalization
begin

end;

end.
