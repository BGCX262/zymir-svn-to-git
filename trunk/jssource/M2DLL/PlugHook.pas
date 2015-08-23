unit PlugHook;

interface
uses Windows,SysUtils,PlacingItem,EngineApi,PlugShare,EngineType;

var
  OldPlayObjectOperateMessage:_TOBJECTOPERATEMESSAGE;

  function ObjectOperateMessage (BaseObject:TObject;
                                 wIdent:Word;
                                 wParam:Word;
                                 nParam1:Integer;
                                 nParam2:Integer;
                                 nParam3:Integer;
                                 MsgObject:TObject;
                                 dwDeliveryTime:LongWord;
                                 pszMsg:PChar;
                                 var boReturn:Boolean):Boolean;stdcall;

  procedure ClientLevelItem(PlayObject:TPlayObject;nItemIdx,BijobIdx,BijobIdx2:integer);

implementation
uses
grobal2,HUtil32;

function ObjectOperateMessage (BaseObject:TObject;
                               wIdent:Word;
                               wParam:Word;
                               nParam1:Integer;
                               nParam2:Integer;
                               nParam3:Integer;
                               MsgObject:TObject;
                               dwDeliveryTime:LongWord;
                               pszMsg:PChar;
                               var boReturn:Boolean):Boolean;stdcall;
var
  sData:String;
begin
  Result:=True;
  boReturn:=True;
  sData:=StrPas(pszMsg);
  case wIdent of
    CM_SELLOFFITEMLIST:
        begin
          if sData='' then g_PlacingItem.ClientGetItemList(MsgObject,nParam2,nParam3,wParam,'')
          else  g_PlacingItem.ClientGetItemList(MsgObject,nParam2,nParam3,wParam,DecodeString(sData));
        end;
    CM_SELLOFFITEM: g_PlacingItem.ClientAddItemToList(MsgObject,nParam1,MakeLong(nParam2,nParam3),wParam,DecodeString(sData));
    CM_SELLOFFBUY:  g_PlacingItem.ClientBuyItem(MsgObject,nParam1);
    CM_LEVELITEM :  ClientLevelItem(MsgObject,nParam1,MakeLong(nParam2,nParam3),Str_ToInt(pszMsg,0));
    else Result:=False;
  end;
  if Not Result then begin
    if Assigned(OldPlayObjectOperateMessage) then
       Result:=OldPlayObjectOperateMessage(BaseObject,
                                           wIdent,
                                           wParam,
                                           nParam1,
                                           nParam2,
                                           nParam3,
                                           MsgObject,
                                           dwDeliveryTime,
                                           pszMsg,
                                           boReturn);
  end;
end;


procedure ClientLevelItem(PlayObject:TPlayObject;nItemIdx,BijobIdx,BijobIdx2:integer);
var
  sName,GoldName,sMsg:string;
  ItemList:EngineType.TList;
  I,nTack,nCheck:integer;
  UserItem,LevelItem,BijobItem,BijboItem2:_LPTUSERITEM;
  nCode,ItemType:Byte;
  boLevel,boVanish:Boolean;
  Level:TItem;
  pLevel,pBijob,pBijbo2:_LPTSTDITEM;
  TempByte:Integer;
  ClientItem:_TCLIENTITEM;
  m_DefMsg:_TDEFAULTMESSAGE;
  GameGold,Gold,nTGameGold,nTGold:pInteger;
  boChange:Boolean;
  NormNpc:TNormNpc;
begin
Try
  LevelItem:=Nil;
  BijobItem:=Nil;
  BijboItem2:=Nil;
  pBijbo2:=Nil;
  Level:=Nil;
  boLevel:=False;
  nCode:=0; //δ�ҵ�����������Ʒ
  nTack:=0;
  boVanish:=False;
  sName:=GetShortStrings(TBaseObject_sCharName(PlayObject));
  ItemList:=TBaseObject_ItemList(PlayObject);
  For I:=0 to TList_Count(ItemList) -1 do begin
    UserItem:=TList_Get(ItemList,I);
    if UserItem<>Nil then begin
      if UserItem.nMakeIndex=nItemIdx then begin
        LevelItem:=UserItem;
      end else
      if UserItem.nMakeIndex=BijobIdx then begin
        BijobItem:=UserItem;
      end else
      if UserItem.nMakeIndex=BijobIdx2 then begin
        BijboItem2:=UserItem;
      end;
    end;
  end;
  if (LevelItem<>nil) and (BijobItem<>nil) then begin
    pLevel:=TUserEngine_GetStdItemByIndex(LevelItem.wIndex);
    pBijob:=TUserEngine_GetStdItemByIndex(BijobItem.wIndex);
    if (pLevel<>Nil) and (pBijob<>Nil) then begin
      nCode:=1; //��װ������������
      Level:=TItemUnit_GetItem(LevelItem.wIndex);
      if TItemUnit_nLevelItem(Level)^ = 1 then begin
        nCode:=2;  //����װ���뱦ʯ������
        //Bijob:=TItemUnit_GetItem(BijobItem.wIndex);
        if BijboItem2<>nil then begin
          //Bijbo2:=TItemUnit_GetItem(BijboItem2.wIndex);
          pBijbo2:=TUserEngine_GetStdItemByIndex(BijboItem2.wIndex);
          if pBijbo2<>Nil then
            nTack:=_Max(0,pBijbo2.DuraMax div 10);
        end;
        ItemType:=TItemUnit_nItemType(Level)^;
        if ((pBijbo2=Nil) or (pBijbo2<>Nil) and (pBijbo2.StdMode=57)) and
           (LevelItem.btValue[14]>=HiWord(pBijob.Need)) and
           ((LevelItem.btValue[14]<LoWord(pBijob.Need)) or ((HiWord(pBijob.Need)>0) and (LevelItem.btValue[14]=LoWord(pBijob.Need)))) then begin
          if ((pBijob.StdMode=58) and (pLevel.StdMode=pBijob.Shape)) or
             ((pBijob.StdMode=55) and (pBijob.Source=0) and (pLevel.StdMode=pBijob.Shape)) or
             ((pBijob.StdMode = 55) and (pBijob.Source=1) and (ItemType =ITEM_ARMOR) and ((pBijob.Shape=0) or (pLevel.StdMode=pBijob.Shape))) or
             ((pBijob.StdMode = 55) and (pBijob.Source=2) and ((pBijob.Shape=0) or (pLevel.StdMode=pBijob.Shape))) or
             ((pBijob.StdMode = 56) and ((pBijob.Shape=0) or (pLevel.StdMode=pBijob.Shape))) then begin
            GameGold:=TPlayObject_nGameGold(PlayObject);
            Gold:=TBaseObject_nGold(PlayObject);
            nTGameGold:=GetLevelItemGameGoldCount();
            nTGold:=GetLevelItemGoldCount();
            boChange:=False;
            GoldName:=GetShortStrings(GetGameGoldName());
            if (nTGameGold^ > 0) then begin
              if GameGold^<nTGameGold^ then begin
                sMsg:='[����ʧ��]�������ϵ�['+GoldName+']������������������������Ҫ['+IntToStr(nTGameGold^)+']��';
                NormNpc:=TNormNpc_GetManageNpc();
                TBaseObject_SendMsg(PlayObject,NormNpc,RM_MENU_OK,0,Integer(PlayObject),0,0,PChar(sMsg));
                exit;
              end else begin
                Dec(GameGold^,nTGameGold^);
                boChange:=True;
              end;
            end;
            if (nTGold^ > 0) then begin
              if Gold^<nTGold^ then begin
                sMsg:='[����ʧ��]�������ϵ�[��Ϸ��]������������������������Ҫ['+IntToStr(nTGold^)+']��';
                NormNpc:=TNormNpc_GetManageNpc();
                TBaseObject_SendMsg(PlayObject,NormNpc,RM_MENU_OK,0,Integer(PlayObject),0,0,PChar(sMsg));
                exit;
              end else begin
                Dec(Gold^,nTGold^);
                boChange:=True;
              end;
            end;
            if boChange then TBaseObject_GoldChanged(PlayObject);
            nCheck:=nTack+_Max(0,pBijob.DuraMax div 10);

            if (Random(11)-nCheck) < 0 then begin //�����ɹ�
              if LevelItem.btValue[14] < High(Byte) then Inc(LevelItem.btValue[14]); //����������¼
              boLevel:=True;
              if (pBijob.StdMode in [55,58]) and (pBijob.Source=0) then begin  //�̶�������
                case ItemType of
                  ITEM_WEAPON:begin
                    Inc(LevelItem.btValue[3],_MIN(High(Byte)-LevelItem.btValue[3],LoWord(pBijob.AC)));
                    Inc(LevelItem.btValue[5],_MIN(High(Byte)-LevelItem.btValue[5],HiWord(pBijob.AC)));
                    Inc(LevelItem.btValue[4],_MIN(High(Byte)-LevelItem.btValue[4],LoWord(pBijob.MAC)));
                    Inc(LevelItem.btValue[6],_MIN(High(Byte)-LevelItem.btValue[6],HiWord(pBijob.MAC)));
                    Inc(LevelItem.btValue[0],_MIN(High(Byte)-LevelItem.btValue[0],HiWord(pBijob.DC)));
                    Inc(LevelItem.btValue[1],_MIN(High(Byte)-LevelItem.btValue[1],HiWord(pBijob.MC)));
                    Inc(LevelItem.btValue[2],_MIN(High(Byte)-LevelItem.btValue[2],HiWord(pBijob.SC)));
                  end;
                  else begin
                    Inc(LevelItem.btValue[0],_MIN(High(Byte)-LevelItem.btValue[0],HiWord(pBijob.AC)));
                    Inc(LevelItem.btValue[1],_MIN(High(Byte)-LevelItem.btValue[1],HiWord(pBijob.MAC)));
                    Inc(LevelItem.btValue[2],_MIN(High(Byte)-LevelItem.btValue[2],HiWord(pBijob.DC)));
                    Inc(LevelItem.btValue[3],_MIN(High(Byte)-LevelItem.btValue[3],HiWord(pBijob.MC)));
                    Inc(LevelItem.btValue[4],_MIN(High(Byte)-LevelItem.btValue[4],HiWord(pBijob.SC)));
                  end;
                end;
              end else //if pBijob.StdMode in [55,58]
              if (pBijob.StdMode = 55) and (pBijob.Source=1) then begin
                case ItemType of
                  ITEM_ARMOR:begin
                    Inc(LevelItem.btValue[0],_MIN(High(Byte)-LevelItem.btValue[0],HiWord(pBijob.AC)));
                    Inc(LevelItem.btValue[1],_MIN(High(Byte)-LevelItem.btValue[1],HiWord(pBijob.MAC)));
                  end;
                end;
              end else
              if (pBijob.StdMode = 55) and (pBijob.Source=2) then begin
                case ItemType of
                  ITEM_WEAPON:begin
                    Inc(LevelItem.btValue[0],_MIN(High(Byte)-LevelItem.btValue[0],HiWord(pBijob.DC)));
                    Inc(LevelItem.btValue[1],_MIN(High(Byte)-LevelItem.btValue[1],HiWord(pBijob.MC)));
                    Inc(LevelItem.btValue[2],_MIN(High(Byte)-LevelItem.btValue[2],HiWord(pBijob.SC)));
                  end;
                  else begin
                    Inc(LevelItem.btValue[2],_MIN(High(Byte)-LevelItem.btValue[2],HiWord(pBijob.DC)));
                    Inc(LevelItem.btValue[3],_MIN(High(Byte)-LevelItem.btValue[3],HiWord(pBijob.MC)));
                    Inc(LevelItem.btValue[4],_MIN(High(Byte)-LevelItem.btValue[4],HiWord(pBijob.SC)));
                  end;
                end;
              end else
              if pBijob.StdMode = 56 then begin
                case ItemType of
                  ITEM_WEAPON:begin
                    if Random(GetLevelItemRate()^) = 0 then TempByte:=Random(4)+3
                    else TempByte:=Random(3);
                  end;
                  ITEM_ACCESSORY:begin
                    if Random(GetLevelItemRate()^) = 0 then TempByte:=Random(2)
                    else TempByte:=Random(3)+2;
                  end;
                  else TempByte:=Random(5);
                end;
                Inc(LevelItem.btValue[TempByte],_MIN(High(Byte)-LevelItem.btValue[TempByte],pBijob.AniCount));
              end; //if pBijob.StdMode in [55,58]
            end else begin    //����ʧ��
              nCode:=3; //����ʧ�ܣ�װ���ޱ仯
              if pBijob.NeedLevel > 100 then begin
                boVanish:=True;
                nCheck:=nTack+_Max(0,(pBijob.NeedLevel-100) div 10);
              end else nCheck:=nTack+_Max(0,pBijob.NeedLevel div 10);
              if (pBijob.NeedLevel > 0) and ((Random(11)-nCheck) < 0) then begin //����ʧ�ܣ������Դ���
                if pBijob.StdMode = 58 then begin
                  nCode:=4; //װ�����Խ�����
                  boLevel:=True;
                  if LevelItem.btValue[14] > 0 then Dec(LevelItem.btValue[14]); //����������¼
                  case ItemType of
                    ITEM_WEAPON:begin
                      Dec(LevelItem.btValue[3],_MIN(LevelItem.btValue[3],LoWord(pBijob.AC)));
                      Dec(LevelItem.btValue[5],_MIN(LevelItem.btValue[5],HiWord(pBijob.AC)));
                      Dec(LevelItem.btValue[4],_MIN(LevelItem.btValue[4],LoWord(pBijob.MAC)));
                      Dec(LevelItem.btValue[6],_MIN(LevelItem.btValue[6],HiWord(pBijob.MAC)));
                      Dec(LevelItem.btValue[0],_MIN(LevelItem.btValue[0],HiWord(pBijob.DC)));
                      Dec(LevelItem.btValue[1],_MIN(LevelItem.btValue[1],HiWord(pBijob.MC)));
                      Dec(LevelItem.btValue[2],_MIN(LevelItem.btValue[2],HiWord(pBijob.SC)));
                    end;
                    else begin
                      Dec(LevelItem.btValue[0],_MIN(LevelItem.btValue[0],HiWord(pBijob.AC)));
                      Dec(LevelItem.btValue[1],_MIN(LevelItem.btValue[1],HiWord(pBijob.MAC)));
                      Dec(LevelItem.btValue[2],_MIN(LevelItem.btValue[2],HiWord(pBijob.DC)));
                      Dec(LevelItem.btValue[3],_MIN(LevelItem.btValue[3],HiWord(pBijob.MC)));
                      Dec(LevelItem.btValue[4],_MIN(LevelItem.btValue[4],HiWord(pBijob.SC)));
                    end;
                  end;
                end else begin
                  if boVanish then begin
                    nCode:=5; //װ����ʧ
                    TBaseObject_DeleteBagItem(PlayObject,LevelItem);
                  end else begin
                    nCode:=6;  //װ���������
                    boLevel:=True;
                    LevelItem.btValue[14]:=0;
                    case ItemType of
                      ITEM_WEAPON: For I:=0 to 6 do LevelItem.btValue[I]:=0;
                      else         For I:=0 to 4 do LevelItem.btValue[I]:=0;
                    end;
                  end;
                end;
              end;
            end;  // if Check����
            TBaseObject_DeleteBagItem(PlayObject,BijobItem);    //��ȡ������ʯ
            if BijboItem2<>nil then TBaseObject_DeleteBagItem(PlayObject,BijboItem2); //��ȡ�������ӱ�ʯ
          end;
        end;
      end; //if TItemUnit_nLevelItem(Level)^ = 1
    end; // if (pLevel<>Nil) and (pBijob<>Nil)
  end;
  if boLevel then begin
    FillChar(ClientItem,SizeOf(_TCLIENTITEM),#0);
    TItemUnit_GetStandardItem(Level,ClientItem.S);
    TItemUnit_GetItemAddValue(LevelItem, ClientItem.S);
    ClientItem.MakeIndex:=LevelItem.nMakeIndex;
    ClientItem.Dura:=LevelItem.wDura;
    ClientItem.DuraMax:=LevelItem.wDuraMax;
    m_DefMsg:=EngineApi.MakeDefaultMsg(SM_LEVELITEM_OK,nCode,0,0,0);
    TPlayObject_SendSocket(PlayObject,@m_DefMsg,PChar(EncodeBuffer(@ClientItem,SizeOf(_TCLIENTITEM))));
  end else
  if nCode in [3,5] then TPlayObject_SendDefMessage(PlayObject,SM_LEVELITEM_OK,nCode,0,0,0,'')
  else TPlayObject_SendDefMessage(PlayObject,SM_LEVELITEM_FAIL,nCode,0,0,0,'');
Except
    on E: Exception do begin
      MainOutMessage('[Exception][M2Server.dll] ClientLevelItem');
      MainOutMessage(PChar(E.Message));
  end;
end;
end;

end.
