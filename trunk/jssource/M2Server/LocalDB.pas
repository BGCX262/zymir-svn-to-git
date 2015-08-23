//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit LocalDB;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,ActiveX,
  Dialogs, M2Share, ADODB, DB,DBTables, HUtil32, Grobal2, SDK, ObjNpc, ItmUnit,Shopping,PlugShare,
  MudUtil,RSA;


type
  TDefineInfo = record
    sName:String;
    sText:String;
  end;
  pTDefineInfo = ^TDefineInfo;
  TQDDinfo = record
    n00     :Integer;
    s04     :String;
    sList   :TStringList;
  end;
  pTQDDinfo = ^TQDDinfo;
  TGoodFileHeader = record
    nItemCount    :Integer;
    Resv          :array[0..251] of Integer;
  end;
  TFrmDB = class{(TForm)}
  private
    procedure QMangeNPC;
    procedure QFunctionNPC;
    procedure QMapEnent;
    procedure RobotNPC();
    procedure DeCodeStringList(StringList:TStringList);
    { Private declarations }
  public
    m_Query: TQuery;
    m_RSA:TRSA;
    //Query: TADOQuery;

    constructor Create();
    destructor Destroy; override;
    function LoadMonitems(MonName:String;var ItemList:TList):Integer;
    function LoadItemsDB():Integer;
    function LoadMapRoute(sMsg:String):Integer;
    function LoadMiniMap():Integer;
    function LoadMapInfo():Integer;
    function LoadMonsterDB():Integer;
    function LoadMagicDB():Integer;
    function LoadMonGen():Integer;
    function LoadUnbindList():Integer;
    function LoadOpenItemList():Integer;
    function LoadMapQuest():Integer;
    function LoadMapEvent():Integer;
    function LoadQuestDiary():Integer;
    function LoadAdminList():Boolean;
    function LoadMerchant():Integer;
    function LoadGuardList():Integer;
    function LoadNpcs():Integer;
    function LoadMakeItem():Integer;
    procedure DeCodeList(StringList:TStringList);
    function LoadStartPoint():Integer;
    function LoadNpcScript(NPC:TNormNpc;sPatch,sScritpName:String):Integer;
    function LoadScriptFile(NPC:TNormNpc;sPatch,sScritpName:String;boFlag:Boolean):Integer;
    function LoadGoodRecord(NPC:TMerchant;sFile:String):Integer;
    function LoadGoodPriceRecord(NPC:TMerchant;sFile:String):Integer;
//    function LoadUserCmdList():Integer;
    function LoadTaxisList():Boolean;

    function SaveGoodRecord(NPC:TMerchant;sFile:String):Integer;
    function SaveGoodPriceRecord(NPC:TMerchant;sFile:String):Integer;

    function  LoadUpgradeWeaponRecord(sNPCName:String;DataList:TList):Integer;
    function  SaveUpgradeWeaponRecord(sNPCName:String;DataList:TList):Integer;
    procedure ReLoadMerchants();
    procedure ReLoadNpc();

    function SaveAdminList():Boolean;
    function GetStditemName(iShape: Integer):String;
    { Public declarations }
  end;
  
var
  FrmDB: TFrmDB;
  nDeCryptString:Integer= -1;
implementation

uses ObjBase, Envir,svMain,Event,MD5Unit,EDcode,DES,AES;


//{$R *.dfm}

{ TFrmDB }
//00487630

function TFrmDB.LoadAdminList():Boolean;
var
  i:Integer;
  AdminInfo :pTAdminInfo;
  sFile     : TStringList;
  sTop,sTemp    : String;
{ResourceString
  sSQLString = 'SELECT * FROM TBL_ADMIN';}
begin
Try 
  Result:=False;
  EnterCriticalSection(ProcessHumanCriticalSection);
  sFile:=TStringList.Create;
  try
    sFile.LoadFromFile(g_Config.sEnvirDir+'AdminList.txt');
    UserEngine.m_AdminList.Lock;
    Try
      UserEngine.m_AdminList.Clear;
      for I:=0 to sFile.Count-1 do begin
        sTop:=sFile.Strings[I];
        if sTop='' then Continue;
        if sTop[1]=';' then Continue;
        New(AdminInfo);
        Try
        sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
        if sTemp='*' then AdminInfo.nLv:=10
        else AdminInfo.nLv:=Str_ToInt(sTemp,0);

        sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
        AdminInfo.sChrName:=sTemp;
        {$IF GMCHECKIP = CHECKGMIP}
          sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
          if sTemp='' then sTemp:='0.0.0.0';
          AdminInfo.sIPaddr:=sTemp;
        {$ELSE}
          AdminInfo.sIPaddr:='0.0.0.0';
        {$IFEND}
        if (AdminInfo.sChrName<>'') and (AdminInfo.sIPaddr<>'') then
          UserEngine.m_AdminList.Add(AdminInfo)
        else Dispose(AdminInfo);
        Except
          Dispose(AdminInfo);
        end;
      end;
    finally
      UserEngine.m_AdminList.UnLock;
    end;
  finally
    sFile.Free;
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
  Result:=True;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadAdminList'); 
End; 
end;

function TFrmDB.SaveAdminList():Boolean;
var
  i:Integer;
  AdminInfo :pTAdminInfo;
  sFile     : TStringList;
ResourceString
{$IF GMCHECKIP = CHECKGMIP}
  sSaveText = '%d'#9'%s'#9'%s';
{$ELSE}
  sSaveText = '%d'#9'%s';
{$IFEND}
begin
Try 
  Result:=False;
  EnterCriticalSection(ProcessHumanCriticalSection);
  sFile:=TStringList.Create;
  try
    sFile.Clear;
    UserEngine.m_AdminList.Lock;
    try
      for I := 0 to UserEngine.m_AdminList.Count - 1 do begin
        AdminInfo:=pTAdminInfo(UserEngine.m_AdminList.Items[I]);
        {$IF GMCHECKIP = CHECKGMIP}
          sFile.Add(Format(sSaveText,[AdminInfo.nLv,AdminInfo.sChrName,AdminInfo.sIPaddr]));
        {$ELSE}
          sFile.Add(Format(sSaveText,[AdminInfo.nLv,AdminInfo.sChrName]));
        {$IFEND}
      end;
      sFile.SaveToFile(g_Config.sEnvirDir+'AdminList.txt');
    finally
      UserEngine.m_AdminList.UnLock;
    end;
  finally
    sFile.Free;
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
  Result:=True;
Except 
  MainOutMessage('[Exception] TFrmDB.SaveAdminList'); 
End; 
end;

//00488A68
function TFrmDB.LoadGuardList(): Integer;
var
  i,nX,nY,nDir:Integer;
  sGuardName,sMap,sTop,sTemp:String;
  tGuard:TBaseObject;
  sFile : TStringList;
{ResourceString
  sSQLString = 'SELECT * FROM TBL_GUARD';}
begin
Try 
  EnterCriticalSection(ProcessHumanCriticalSection);
  sFile:=TStringList.Create;
  Result := -1;
  try
    sFile.LoadFromFile(g_Config.sEnvirDir + 'GuardList.txt');
    for I:=0 to sFile.Count-1 do begin
      sTop:=sFile.Strings[I];
      if sTop='' then Continue;
      if sTop[1]=';' then Continue;
      sTop:=GetValidStr3(sTop,sGuardName,[' ', ',', #9]);
      sTop:=GetValidStr3(sTop,sMap,[' ', ',', #9]);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      nX:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      nY:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ':', #9]);
      nDir:=Str_ToInt(sTemp,0);
      if (sGuardName <> '') and (sMap <> '') then begin
        tGuard:=UserEngine.RegenMonsterByName(sMap,nX,nY,sGuardName);
        if tGuard <> nil then tGuard.m_btDirection:=nDir;
      end;
      Result := 1;
    end;
  finally
    sFile.Free;
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadGuardList'); 
End; 
end;
//004855E0
function TFrmDB.LoadItemsDB: Integer;
var
  i,Idx:Integer;
  Item:TItem;
  //StdItem:pTStdItem;
ResourceString
  sSQLString = 'SELECT * FROM StdItems.DB ORDER BY Idx';
begin
Try
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
  try
    for I := 0 to UserEngine.StdItemList.Count - 1 do begin
      TItem(UserEngine.StdItemList.Items[I]).Free;
    end;
    UserEngine.StdItemList.Clear;
    
    {For I:=0 to UserEngine.StdItemListEx.Count-1 do begin
      Dispose(pTStdItem(UserEngine.StdItemListEx.Items[i]));
    end;
    UserEngine.StdItemListEx.Clear;}

    Result := -1;
    m_Query.SQL.Clear;
    m_Query.DatabaseName:=g_Config.DBName;
    m_Query.SQL.Add(sSQLString);
    try
      m_Query.Open;
    Except
      on E:Exception do begin
        Memo.Lines.Add(E.Message);
        Exit;
      end;
    end;
    for i:=0 to m_Query.RecordCount -1 do begin
      Item := TItem.Create;
      Idx            := m_Query.FieldByName('Idx').AsInteger;
      Item.Name      := m_Query.FieldByName('Name').AsString;
      Item.StdMode   := m_Query.FieldByName('StdMode').AsInteger;
      Item.Shape     := m_Query.FieldByName('Shape').AsInteger;
      Item.Weight    := m_Query.FieldByName('Weight').AsInteger;
      Item.AniCount  := m_Query.FieldByName('AniCount').AsInteger;
      Item.Source    := m_Query.FieldByName('Source').AsInteger;
      Item.Reserved  := m_Query.FieldByName('Reserved').AsInteger;
      Item.Looks     := m_Query.FieldByName('Looks').AsInteger;
      Item.DuraMax   := Word(m_Query.FieldByName('DuraMax').AsInteger);
      Item.AC        := ROUND(m_Query.FieldByName('AC').AsInteger * (g_Config.nItemsACPowerRate / 10));
      Item.AC2       := ROUND(m_Query.FieldByName('AC2').AsInteger * (g_Config.nItemsACPowerRate / 10));
      Item.MAC       := ROUND(m_Query.FieldByName('MAC').AsInteger * (g_Config.nItemsACPowerRate / 10));
      Item.MAC2      := ROUND(m_Query.FieldByName('MAC2').AsInteger * (g_Config.nItemsACPowerRate / 10));
      Item.DC        := ROUND(m_Query.FieldByName('DC').AsInteger * (g_Config.nItemsPowerRate / 10));
      Item.DC2       := ROUND(m_Query.FieldByName('DC2').AsInteger * (g_Config.nItemsPowerRate / 10));
      Item.MC        := ROUND(m_Query.FieldByName('MC').AsInteger * (g_Config.nItemsPowerRate / 10));
      Item.MC2       := ROUND(m_Query.FieldByName('MC2').AsInteger * (g_Config.nItemsPowerRate / 10));
      Item.SC        := ROUND(m_Query.FieldByName('SC').AsInteger * (g_Config.nItemsPowerRate / 10));
      Item.SC2       := ROUND(m_Query.FieldByName('SC2').AsInteger * (g_Config.nItemsPowerRate / 10));
      Item.Need      := m_Query.FieldByName('Need').AsInteger;
      Item.NeedLevel := m_Query.FieldByName('NeedLevel').AsInteger;
      Item.Price     := m_Query.FieldByName('Price').AsInteger;
      Try
        Item.sDesc     := m_Query.FieldByName('Desc').AsString;
        Item.nHero     := m_Query.FieldByName('Hero').AsInteger;
      Except
        Item.sDesc:='';
        Item.nHero:=0;
      end;
      //Item.Unique    := False;
      Item.Light     := False;
      //ShowMessage(Item.Name);

      Item.NeedIdentify:=GetGameLogItemNameList(Item.Name);
      Item.HeroPick:=GetHeroPickItemNameList(Item.Name);
      Item.LevelItem:=GetLevelItemNameList(Item.Name);
      Item.SellOff:=GetSellItemNameList(Item.Name);
      Item.DieDisap:=GetDieDisapItemNameList(Item.Name);
      Item.GhostDisap:=GetGhostDisapItemNameList(Item.Name);
      Item.SuitIdx[0]:=0;
      GetSuitItemList(Item);
      GetRuleItemList(Item);
      case Item.StdMode of
        0,55,58:Item.ItemType:= ITEM_LEECHDOM;
        5,6: Item.ItemType := ITEM_WEAPON;
        10,11,27,62,63,64,26,30,15,22,29,16: Item.ItemType := ITEM_ARMOR;
        19,20,21,23,24,51,52,53,54,28: Item.ItemType := ITEM_ACCESSORY;
        60:Item.ItemType:=ITEM_Wine;
        else Item.ItemType := ITEM_ETC;
      end;

      if UserEngine.StdItemList.Count = Idx then begin
        UserEngine.StdItemList.Add(Item);
        //New(StdItem);
        //Item.GetStandardItem(StdItem^);
        //UserEngine.StdItemListEx.Add(StdItem);
        Result := 1;
      end else begin
        Memo.Lines.Add(format('加载物品(Idx:%d Name:%s)数据失败！！！',[Idx,Item.Name]));
        Result := -100;
        exit;
      end;
      m_Query.Next;
    end;
    g_boGameLogGold:=GetGameLogItemNameList(sSTRING_GOLDNAME) = 1;
    g_boGameLogHumanDie:=GetGameLogItemNameList(g_sHumanDieEvent) = 1;
    g_boGameLogGameGold:=GetGameLogItemNameList(g_Config.sGameGoldName) = 1;
    g_boGameLogGamePoint:=GetGameLogItemNameList(g_Config.sGamePointName) = 1;
    g_boHeroPickGold:=GetHeroPickItemNameList(sSTRING_GOLDNAME) = 1;
  finally
    m_Query.Close;
  end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadItemsDB:'); 
End; 
end;
//00486330
function TFrmDB.LoadMagicDB():Integer;
var
  i:Integer;
  Magic:pTMagic;
ResourceString
  //sSQLString = 'SELECT * FROM TBL_MAGIC ORDER BY FLD_ID';
  sSQLString = 'SELECT * FROM Magic.DB ORDER BY MagID';
begin
Try 
  Result:= -1;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
  try
    UserEngine.SwitchMagicList();

    {for I := 0 to UserEngine.MagicList.Count - 1 do begin
      Dispose(pTMagic(UserEngine.MagicList.Items[I]));
    end;
    UserEngine.MagicList.Clear;}


    m_Query.SQL.Clear;
    m_Query.DatabaseName:=g_Config.DBName;
    m_Query.SQL.Add(sSQLString);
    try
      m_Query.Open;
    Except
      on E:Exception do begin
        Memo.Lines.Add(E.Message);
        Exit;
      end;
    end;
    for i:=0 to m_Query.RecordCount -1 do begin
      New(Magic);
      Magic.wMagicId      := m_Query.FieldByName('MagId').AsInteger;
      Magic.sMagicName    := Trim(m_Query.FieldByName('MagName').AsString);
      Magic.btEffectType  := m_Query.FieldByName('EffectType').AsInteger;
      Magic.btEffect      := m_Query.FieldByName('Effect').AsInteger;
      Magic.wSpell        := m_Query.FieldByName('Spell').AsInteger;
      Magic.wPower        := m_Query.FieldByName('Power').AsInteger;
      Magic.wMaxPower     := m_Query.FieldByName('MaxPower').AsInteger;
      Magic.btDefSpell    := m_Query.FieldByName('DefSpell').AsInteger;
      Magic.btDefPower    := m_Query.FieldByName('DefPower').AsInteger;
      Magic.btDefMaxPower := m_Query.FieldByName('DefMaxPower').AsInteger;
      Magic.btJob         := m_Query.FieldByName('Job').AsInteger;
      Magic.TrainLevel[0] := m_Query.FieldByName('NeedL1').AsInteger;
      Magic.MaxTrain[0]   := m_Query.FieldByName('L1TRAIN').AsInteger;
      Magic.TrainLevel[1] := m_Query.FieldByName('NEEDL2').AsInteger;
      Magic.MaxTrain[1]   := m_Query.FieldByName('L2TRAIN').AsInteger;
      Magic.TrainLevel[2] := m_Query.FieldByName('NEEDL3').AsInteger;
      Magic.MaxTrain[2]   := m_Query.FieldByName('L3TRAIN').AsInteger;
      Magic.dwDelayTime   := m_Query.FieldByName('DELAY').AsInteger;
      Magic.sDescr        := Trim(m_Query.FieldByName('DESCR').AsString);
      Magic.TrainLevel[3] := Magic.TrainLevel[2]; //Query.FieldByName('FLD_NEEDL3').AsInteger;
      Magic.MaxTrain[3]   := Magic.MaxTrain[2];
      Magic.btTrainLv     := MaxSkillLevel;

      if Magic.wMagicId > 0 then begin
        UserEngine.m_MagicList2.Add(Magic);
        if Magic.sDescr='英雄' then begin
          case Magic.wMagicID of
            SKILL_FIRECHARM:begin  //灵魂火符
              New(g_HeroFourMagicCharm);
              g_HeroFourMagicCharm^:=Magic^;
              g_HeroFourMagicCharm.btEffect:=70;
            end;
            SKILL_FIRESWORD: begin //烈火剑法
              New(g_HeroFourMagicFirs);
              g_HeroFourMagicFirs^:=Magic^;
              g_HeroFourMagicFirs.btEffect:=71;
            end;
            SKILL_45:begin  //灭天火
              New(g_HeroFourMagic45);
              g_HeroFourMagic45^:=Magic^;
              g_HeroFourMagic45.btEffect:=72;
            end;
          end;
        end;
      end else begin
        Dispose(Magic);
      end;
      Result := 1;
      m_Query.Next;
    end;
  finally
    m_Query.Close;
  end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadMagicDB'); 
End; 
end;

procedure TFrmDB.DeCodeList(StringList:TStringList);
var
  I: Integer;
  sLine:String;
//  sKey:String;
  KeyClass:Byte;
  nKey:Integer;
begin
Try
  KeyClass:=0;
  nKey:=0;
  for I := 0 to StringList.Count - 1 do begin
    sLine:=StringList.Strings[I];
    if I=0 then begin
      if CompareStr(sLine,sENCRYPTSCRIPTDEMO)=0 then begin
        KeyClass:=4;
      end else break;
    end else
    if I=1 then begin
      Try
        case KeyClass of
          4: nKey:=StrToIntDef(m_RSA.DecryptStr16(sLine),0);
          else break;
        end;
      Except
        break;
      end;
    end else begin
      if KeyClass=4 then begin
        sLine:=DecryptString(sLine,IntToStr(nKey));
        StringList.Strings[I]:=sLine;
      end;
      ContInue;
    end;
    StringList.Strings[I]:='';
    //application.ProcessMessages;
  end;
Except
  MainOutMessage('[Exception] TFrmDB.DeCodeStringList');
End;
end;

function TFrmDB.LoadMakeItem(): Integer; //00488CDC
var
  I,n14:Integer;
  s18,s20,s24:String;
  LoadList:TStringList;
  sFileName:String;
  List28:TStringList;
begin
Try
  Result:= -1;
  sFileName:=g_Config.sEnvirDir + 'MakeItem.txt';
  if FileExists(sFileName) then begin
    LoadList:=TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    List28:=nil;
    s24:='';
    for I := 0 to LoadList.Count - 1 do begin
      s18:=Trim(LoadList.Strings[I]);
      if (s18 <> '') and (s18[1] <> ';') then begin
        if s18[1] = '[' then begin
          if List28 <> nil then
            g_MakeItemList.AddObject(s24,List28);
          List28:=TStringList.Create;
          ArrestStringEx(s18,'[',']',s24);
        end else begin
          if List28 <> nil then begin
            s18:=GetValidStr3(s18,s20,[' ',#9]);
            n14:=Str_ToInt(Trim(s18),1);
            List28.AddObject(s20,TObject(n14));
          end;
        end;
      end;
    end;    // for
    if List28 <> nil then
      g_MakeItemList.AddObject(s24,List28);
    LoadList.Free;
    Result:=1;
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadMakeItem'); 
End; 
end;

function TFrmDB.LoadMiniMap():Integer;
var
  MapFile : TStringList;
  I,nIdx       : Integer;
  sTop,sMapName,sIdx    : String;
begin
Try 
  Result:=1;
  MapFile:=TStringList.Create;
  Try
    MiniMapList.Clear;
    MapFile.LoadFromFile(g_Config.sEnvirDir+'MiniMap.txt');
    for i:=0 to MapFile.Count -1 do begin
      sTop:=MapFile.Strings[I];
      if length(sTop)=0 then Continue;
      if sTop[1]=';' then Continue;
      sTop:=GetValidStr3(sTop,sMapName,[' ', ',', #9]);
      if sMapName='' then Continue;
      sTop:=GetValidStr3(sTop,sIdx,[' ', ',', #9]);
      if sIdx='' then Continue;
      nIdx:=Str_ToInt(sIdx,-1);
      if nIdx>0 then
        MiniMapList.AddObject(sMapName,TObject(nIdx));
    end;
  finally
    MapFile.Free;
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadMiniMap'); 
End; 
end;

function TFrmDB.LoadMapInfo: Integer;
  function LoadMapQuest(sName:String):TMerchant;
  var
    QuestNPC:TMerchant;
  begin
    QuestNPC:=TMerchant.Create;
    QuestNPC.m_sMapName:='0';
    QuestNPC.m_nCurrX:=0;
    QuestNPC.m_nCurrY:=0;
    QuestNPC.m_sCharName:=sName;
    QuestNPC.m_nFlag:=0;
    QuestNPC.m_wAppr:=0;
    QuestNPC.m_sFilePath:='MapQuest_def\';
    QuestNPC.m_boIsHide:=True;
    QuestNPC.m_boIsQuest:=False;
    UserEngine.QuestNPCList.Add(QuestNPC);

    Result:=QuestNPC;
  end;

var
  i:Integer;

  sFlag,s34,s38,sMapName,sMapDesc,sReConnectMap,sTop:String;
//  nIdx:Integer;
  //nIdx,nServerIndex:Integer;

  MapFlag:TMapFlag;
  QuestNPC:TMerchant;
  MapFile : TStringList;
  sCaption:String;
{ResourceString
  sSQLString = 'SELECT * FROM TBL_MAPINFO'; }
begin
Try
  Result:= -1;
  sCaption:=FrmMain.Caption;
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    MapFile:=TStringList.Create;
  try
    MapFile.LoadFromFile(g_Config.sEnvirDir+'MapInfo.txt');
    //Query.SQL.Clear;
    //Query.SQL.Add(sSQLString);
    {try
      Query.Open;
    finally
      Result:= -2;
    end;}
    {//记得加载小地图
    MiniMapList.Clear;
    nIdx          := Query.FieldByName('FLD_MINIMAP').AsInteger;
      if nIdx > 0 then
        MiniMapList.AddObject(sMapName,TObject(nIdx));}

    for i:=0 to MapFile.Count -1 do begin
      sTop:=MapFile.Strings[I];
      if sTop=''  then Continue;
      if sTop[1]=';' then Continue;
      sTop:=GetValidStr3(sTop,sMapName,[' ', ',', #9]);
      if sMapName='' then Continue;
      if sMapName[1]<>'[' then begin
        Continue;
      end;
      sMapName:=RightStr(sMapName,Length(sMapName)-1);
      sFlag:=GetValidStr3(sTop,sMapDesc,[' ', ',', #9,']']);
      if sMapDesc='' then Continue;

      //FillChar(MapFlag,SizeOf(TMapFlag),#0);
      QuestNPC:=nil;
      {MapFlag.boSAFE:=False;
      MapFlag.nNEEDSETONFlag:= -1;
      MapFlag.nNeedONOFF:= -1;
      MapFlag.sMusic:='';
      MapFlag.sNoReConnectMap:='';
      MapFlag.NotMagicList:=Nil;
      MapFlag.NotEatItems:=Nil;}

      MapFlag.boSAFE:=False;
      MapFlag.nNEEDSETONFlag:=-1;
      MapFlag.nNeedONOFF:=-1;
      MapFlag.sMusic:='';
      MapFlag.boDarkness:=False;
      MapFlag.boDayLight:=False;
      MapFlag.boFightZone:=False;
      MapFlag.boFight3Zone:=False;
      MapFlag.boFight2Zone:=False;
      MapFlag.boQUIZ:=False;
      MapFlag.boNORECONNECT:=False;
      MapFlag.boNOTALLOWUSEMAGIC:=False;
      MapFlag.boNOTALLOWUSEITEMS:=False;
      MapFlag.NotMagicList:=Nil;
      MapFlag.NotEatItems:=Nil;
      MapFlag.sNoReConnectMap:='';
      MapFlag.boMUSIC:=False;
      MapFlag.boEXPRATE:=False;
      MapFlag.nEXPRATE:=0;
      MapFlag.boPKWINLEVEL:=False;
      MapFlag.nPKWINLEVEL:=0;
      MapFlag.boPKWINEXP:=False;
      MapFlag.nPKWINEXP:=0;
      MapFlag.boPKLOSTLEVEL:=False;
      MapFlag.nPKLOSTLEVEL:=0;
      MapFlag.boPKLOSTEXP:=False;
      MapFlag.nPKLOSTEXP:=0;
      MapFlag.boDECHP:=False;
      MapFlag.nDECHPPOINT:=0;
      MapFlag.nDECHPTIME:=0;
      MapFlag.boINCHP:=False;
      MapFlag.nINCHPPOINT:=0;
      MapFlag.nINCHPTIME:=0;
      MapFlag.boDECGAMEGOLD:=False;
      MapFlag.nDECGAMEGOLD:=0;
      MapFlag.nDECGAMEGOLDTIME:=0;
      MapFlag.boDECGAMEPOINT:=False;
      MapFlag.nDECGAMEPOINT:=0;
      MapFlag.nDECGAMEPOINTTIME:=0;
      MapFlag.boINCGAMEGOLD:=False;
      MapFlag.nINCGAMEGOLD:=0;
      MapFlag.nINCGAMEGOLDTIME:=0;
      MapFlag.boINCGAMEPOINT:=False;
      MapFlag.nINCGAMEPOINT:=0;
      MapFlag.nINCGAMEPOINTTIME:=0;
      MapFlag.boRUNHUMAN:=False;
      MapFlag.boRUNMON:=False;
      MapFlag.boNEEDHOLE:=False;
      MapFlag.boNORECALL:=False;
      MapFlag.boNOGUILDRECALL:=False;
      MapFlag.boNODEARRECALL:=False;
      MapFlag.boNOMASTERRECALL:=False;
      MapFlag.boNORANDOMMOVE:=False;
      MapFlag.boNODRUG:=False;
      MapFlag.boMINE:=False;
      MapFlag.boMINE2:=False;
      MapFlag.boNOPOSITIONMOVE:=False;
      MapFlag.boNODROPITEM:=False;
      MapFlag.boNOTHROWITEM:=False;
      MapFlag.boNOHORSE:=False;
      MapFlag.boNOCHAT:=False;
      MapFlag.boSHOP:=False;
      MapFlag.boMission:=False;
      MapFlag.boNight:=False;
      MapFlag.boNOCALLHERO:=False;
      MapFlag.NOHEROPROTECT:=False;
      MapFlag.boMapEvent:=False;
      MapFlag.boNoManNoMon:=False;
      MapFlag.sKillMon:='';
      MapFlag.nTHUNDER:=0;
      MapFlag.nLAVA:=0;
      MapFlag.boFIGHT4:=False;

      while (True) do begin
        if sFlag = '' then break;
        sFlag:=GetValidStr3(sFlag,s34,[' ', ',', #9]);
        if s34 = '' then break;
        if CompareLStr(s34,'THUNDER',length('THUNDER')) then begin
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nTHUNDER:=StrToIntDef(s38,0);
          Continue;
        end;
        if CompareLStr(s34,'LAVA',length('LAVA')) then begin
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nLAVA:=StrToIntDef(s38,0);
          Continue;
        end;
        if CompareText(s34,'SAFE') = 0 then begin
          MapFlag.boSAFE:=True;
          Continue;
        end;
        if CompareText(s34,'FIGHT4') = 0 then begin
          MapFlag.boFIGHT4:=True;
          Continue;
        end;
        if CompareText(s34,'DARK') = 0 then begin
          MapFlag.boDarkness:=True;
          Continue;
        end;
        if CompareText(s34,'FIGHT') = 0 then begin
          MapFlag.boFightZone:=True;
          Continue;
        end;
        if CompareText(s34,'FIGHT2') = 0 then begin
          MapFlag.boFight2Zone:=True;
          Continue;
        end;
        if CompareText(s34,'FIGHT3') = 0 then begin
          MapFlag.boFight3Zone:=True;
          Continue;
        end;
        if CompareText(s34,'DAY') = 0 then begin
          MapFlag.boDayLight:=True;
          Continue;
        end;
        if CompareText(s34,'QUIZ') = 0 then begin
          MapFlag.boQUIZ:=True;
          Continue;
        end;
        if CompareLStr(s34,'NORECONNECT',length('NORECONNECT')) then begin
          MapFlag.boNORECONNECT:=True;
          ArrestStringEx(s34,'(',')',sReConnectMap);
          MapFlag.sNoReConnectMap:=sReConnectMap;
          if MapFlag.sNoReConnectMap = '' then Result:= -11;
          Continue;
        end;
        if CompareLStr(s34,'KILLFUNC',length('KILLFUNC')) then begin
          //MapFlag.boNOTALLOWUSEMAGIC:=True;
          ArrestStringEx(s34,'(',')',sReConnectMap);
          if sReConnectMap<>'' then begin
            MapFlag.sKillMon:=sReConnectMap;
            //ExtractStrings(['|'],[],PChar(sReConnectMap),MapFlag.NotMagicList);
          end;
          Continue;
        end;
        if CompareLStr(s34,'NOTALLOWUSEMAGIC',length('NOTALLOWUSEMAGIC')) then begin
          MapFlag.boNOTALLOWUSEMAGIC:=True;
          ArrestStringEx(s34,'(',')',sReConnectMap);
          if sReConnectMap<>'' then begin
            MapFlag.NotMagicList:=TStringList.Create;
            ExtractStrings(['|'],[],PChar(sReConnectMap),MapFlag.NotMagicList);
          end;
          Continue;
        end;

        if CompareLStr(s34,'NOTALLOWUSEITEMS',length('NOTALLOWUSEITEMS')) then begin
          MapFlag.boNOTALLOWUSEITEMS:=True;
          ArrestStringEx(s34,'(',')',sReConnectMap);
          if sReConnectMap<>'' then begin
            MapFlag.NotEatItems:=TStringList.Create;
            ExtractStrings(['|'],[],PChar(sReConnectMap),MapFlag.NotEatItems);
          end;
          Continue;
        end;
        if CompareLStr(s34,'CHECKQUEST',length('CHECKQUEST')) then begin
          ArrestStringEx(s34,'(',')',s38);
          QuestNPC:=LoadMapQuest(s38);
          Continue;
        end;
        if CompareLStr(s34,'NEEDSET_ON',length('NEEDSET_ON')) then begin
          MapFlag.nNeedONOFF:=1;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nNEEDSETONFlag:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'NEEDSET_OFF',length('NEEDSET_OFF')) then begin
          MapFlag.nNeedONOFF:=0;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nNEEDSETONFlag:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'MUSIC',length('MUSIC')) then begin
          MapFlag.boMUSIC:=True;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.sMusic:=s38;
          Continue;
        end;
        if CompareLStr(s34,'EXPRATE',length('EXPRATE')) then begin
          MapFlag.boEXPRATE:=True;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nEXPRATE:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'PKWINLEVEL',length('PKWINLEVEL')) then begin
          MapFlag.boPKWINLEVEL:=True;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nPKWINLEVEL:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'PKWINEXP',length('PKWINEXP')) then begin
          MapFlag.boPKWINEXP:=True;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nPKWINEXP:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'PKLOSTLEVEL',length('PKLOSTLEVEL')) then begin
          MapFlag.boPKLOSTLEVEL:=True;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nPKLOSTLEVEL:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'PKLOSTEXP',length('PKLOSTEXP')) then begin
          MapFlag.boPKLOSTEXP:=True;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nPKLOSTEXP:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'DECHP',length('DECHP')) then begin
          MapFlag.boDECHP:=True;
          ArrestStringEx(s34,'(',')',s38);

          MapFlag.nDECHPPOINT:=Str_ToInt(GetValidStr3(s38,s38,['/']),-1);
          MapFlag.nDECHPTIME:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'INCHP',length('INCHP')) then begin
          MapFlag.boINCHP:=True;
          ArrestStringEx(s34,'(',')',s38);

          MapFlag.nINCHPPOINT:=Str_ToInt(GetValidStr3(s38,s38,['/']),-1);
          MapFlag.nINCHPTIME:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'DECGAMEGOLD',length('DECGAMEGOLD')) then begin
          MapFlag.boDECGAMEGOLD:=True;
          ArrestStringEx(s34,'(',')',s38);

          MapFlag.nDECGAMEGOLD:=Str_ToInt(GetValidStr3(s38,s38,['/']),-1);
          MapFlag.nDECGAMEGOLDTIME:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'DECGAMEPOINT',length('DECGAMEPOINT')) then begin
          MapFlag.boDECGAMEPOINT:=True;
          ArrestStringEx(s34,'(',')',s38);

          MapFlag.nDECGAMEPOINT:=Str_ToInt(GetValidStr3(s38,s38,['/']),-1);
          MapFlag.nDECGAMEPOINTTIME:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'INCGAMEGOLD',length('INCGAMEGOLD')) then begin
          MapFlag.boINCGAMEGOLD:=True;
          ArrestStringEx(s34,'(',')',s38);

          MapFlag.nINCGAMEGOLD:=Str_ToInt(GetValidStr3(s38,s38,['/']),-1);
          MapFlag.nINCGAMEGOLDTIME:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'INCGAMEPOINT',length('INCGAMEPOINT')) then begin
          MapFlag.boINCGAMEPOINT:=True;
          ArrestStringEx(s34,'(',')',s38);

          MapFlag.nINCGAMEPOINT:=Str_ToInt(GetValidStr3(s38,s38,['/']),-1);
          MapFlag.nINCGAMEPOINTTIME:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareText(s34,'RUNHUMAN') = 0 then begin
          MapFlag.boRUNHUMAN:= True;
          Continue;
        end;
        if CompareText(s34,'RUNMON') = 0 then begin
          MapFlag.boRUNMON:= True;
          Continue;
        end;
        if CompareText(s34,'NEEDHOLE') = 0 then begin
          MapFlag.boNEEDHOLE := True;
          Continue;
        end;
        if CompareText(s34,'NORECALL') = 0 then begin
          MapFlag.boNORECALL := True;
          Continue;
        end;
        if CompareText(s34,'NOGUILDRECALL') = 0 then begin
          MapFlag.boNOGUILDRECALL := True;
          Continue;
        end;
        if CompareText(s34,'NODEARRECALL') = 0 then begin
          MapFlag.boNODEARRECALL := True;
          Continue;
        end;
        if CompareText(s34,'NOMASTERRECALL') = 0 then begin
          MapFlag.boNOMASTERRECALL := True;
          Continue;
        end;
        if CompareText(s34,'NORANDOMMOVE') = 0 then begin
          MapFlag.boNORANDOMMOVE := True;
          Continue;
        end;
        if CompareText(s34,'NODRUG') = 0 then begin
          MapFlag.boNODRUG := True;
          Continue;
        end;
        if CompareText(s34,'MINE') = 0 then begin
          MapFlag.boMINE := True;
          Continue;
        end;
        if CompareText(s34,'MINE2') = 0 then begin
          MapFlag.boMINE2 := True;
          Continue;
        end;
        if CompareText(s34,'NOTHROWITEM') = 0 then begin
          MapFlag.boNOTHROWITEM := True;
          Continue;
        end;
        if CompareText(s34,'NODROPITEM') = 0 then begin
          MapFlag.boNODROPITEM := True;
          Continue;
        end;
        if CompareText(s34,'NOPOSITIONMOVE') = 0 then begin
          MapFlag.boNOPOSITIONMOVE := True;
          Continue;
        end;
        if CompareText(s34,'NOHORSE') = 0 then begin
          MapFlag.boNOHORSE := True;
          Continue;
        end;
        if CompareText(s34,'NOCHAT') = 0 then begin
          MapFlag.boNOCHAT := True;
          Continue;
        end;
        if CompareText(s34,'SHOP') = 0 then begin
          MapFlag.boSHOP := True;
          Continue;
        end;
        if CompareText(s34,'MISSION') = 0 then begin
          MapFlag.boMission := True;
          Continue;
        end;
        if CompareText(s34,'NIGHT') = 0 then begin
          MapFlag.boNight := True;
          Continue;
        end;
        if CompareText(s34,'NOCALLHERO') = 0 then begin
          MapFlag.boNOCALLHERO := True;
          Continue;
        end;
        if CompareText(s34,'NOHEROPROTECT') = 0 then begin
          MapFlag.NOHEROPROTECT := True;
          Continue;
        end;
        if CompareText(s34,'NOMANNOMON') = 0 then begin
          MapFlag.boNoManNoMon := True;
          Continue;
        end;
      end;
      if g_MapManager.AddMapInfo(sMapName,sMapDesc,nServerIndex,@MapFlag,QuestNPC) = nil then Result:= -10;
      
      Result := 1;
      FrmMain.Caption:=sCaption + '[正在初始化地图信息(' + IntToStr(MapFile.Count -1) + '/' + IntToStr(I) + ')]';
      application.ProcessMessages;
      //Query.Next;
    end;
    for i:=0 to MapFile.Count -1 do begin
      sTop:=MapFile.Strings[I];
      if sTop=''  then Continue;
      if sTop[1]=';' then Continue;
      sTop:=GetValidStr3(sTop,sMapName,[' ', ',', #9]);
      if sMapName='' then Continue;
      if sMapName[1]<>'[' then
        LoadMapRoute(MapFile.Strings[I]);  //加载地图坐标处理
    end;
  finally
    //Query.Close;
    FrmMain.Caption:=sCaption;
    MapFile.Free;
  end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;

Except 
  MainOutMessage('[Exception] TFrmDB.LoadMapInfo:'); 
End; 
end;


function TFrmDB.LoadMapRoute(sMsg:String):Integer;
var
  nSMapX,nSMapY,nDMapX,nDMapY:Integer;
  sSMapNO,sDMapNO,sTop,sTemp:String;
begin
Try 

  Result:= -1;
  if sMsg='' then exit;
  sTop:=sMsg;

  sTop:=GetValidStr3(sTop,sSMapNO,[' ', ',', #9]);

  if sSmapNo='' then exit;

  sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
  nSMapX:=Str_ToInt(sTemp,-1);

  sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
  nSMapY:=Str_ToInt(sTemp,-1);

  sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);

  sTop:=GetValidStr3(sTop,sDMapNO,[' ', ',', #9]);

  sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
  nDMapX:=Str_ToInt(sTemp,-1);

  sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
  nDMapY:=Str_ToInt(sTemp,-1);

  if (sSMapNO<>'') and (nSMapX>-1) and (nSMapY>-1) and
     (sDMapNO<>'') and (nDMapX>-1) and (nDMapY>-1) then begin
    g_MapManager.AddMapRoute(sSMapNO,nSMapX,nSMapY,sDMapNO,nDMapX,nDMapY);
    Result := 1;
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadMapRoute'); 
End; 
end;

procedure TFrmDB.QMapEnent;
var
  sScriptFile :String;
  sScritpDir  :String;
  SaveList    :TStringList;
  sShowFile   :String;
begin
try
  sScriptFile:=g_Config.sEnvirDir + sMarket_Def + 'QMapEnent-0.txt';
  sShowFile:=ReplaceChar(sScriptFile,'\','/');
  sScritpDir:=g_Config.sEnvirDir + sMarket_Def;
  if not DirectoryExists(sScritpDir) then
    mkdir(Pchar(sScritpDir));

  if not FileExists(sScriptFile) then begin
    SaveList:=TStringList.Create;
    SaveList.Add(';此脚为地图触发功能脚本，用于实现各种与脚本有关的功能');
    SaveList.SaveToFile(sScriptFile);
    SaveList.Free;
  end;
  if FileExists(sScriptFile) then begin
    g_QMapEnent:=TMerchant.Create;
    g_QMapEnent.m_sMapName  := '0';
    g_QMapEnent.m_nCurrX    := 0;
    g_QMapEnent.m_nCurrY    := 0;
    g_QMapEnent.m_sCharName := 'QMapEnent';
    g_QMapEnent.m_nFlag     := 0;
    g_QMapEnent.m_wAppr     := 0;
    g_QMapEnent.m_sFilePath := sMarket_Def;
    g_QMapEnent.m_sScript   := 'QMapEnent';
    g_QMapEnent.m_boIsHide  := True;
    g_QMapEnent.m_boIsQuest := False;
    UserEngine.AddMerchant(g_QMapEnent);
  end else begin
    g_QMapEnent:=nil;
  end;
except
  g_QMapEnent:=nil;
end;
end;


procedure TFrmDB.QFunctionNPC;
var
  sScriptFile :String;
  sScritpDir  :String;
  SaveList    :TStringList;
  sShowFile   :String;
begin
Try
try
  sScriptFile:=g_Config.sEnvirDir + sMarket_Def + 'QFunction-0.txt';
  sShowFile:=ReplaceChar(sScriptFile,'\','/');
  sScritpDir:=g_Config.sEnvirDir + sMarket_Def;
  if not DirectoryExists(sScritpDir) then
    mkdir(Pchar(sScritpDir));

  if not FileExists(sScriptFile) then begin
    SaveList:=TStringList.Create;
    SaveList.Add(';此脚为功能脚本，用于实现各种与脚本有关的功能');
    SaveList.SaveToFile(sScriptFile);
    SaveList.Free;
  end;
  if FileExists(sScriptFile) then begin
    g_FunctionNPC:=TMerchant.Create;
    g_FunctionNPC.m_sMapName  := '0';
    g_FunctionNPC.m_nCurrX    := 0;
    g_FunctionNPC.m_nCurrY    := 0;
    g_FunctionNPC.m_sCharName := 'QFunction';
    g_FunctionNPC.m_nFlag     := 0;
    g_FunctionNPC.m_wAppr     := 0;
    g_FunctionNPC.m_sFilePath := sMarket_Def;
    g_FunctionNPC.m_sScript   := 'QFunction';
    g_FunctionNPC.m_boIsHide  := True;
    g_FunctionNPC.m_boIsQuest := False;
    UserEngine.AddMerchant(g_FunctionNPC);
  end else begin
    g_FunctionNPC:=nil;
  end;
except
  g_FunctionNPC:=nil;
end;
Except 
  MainOutMessage('[Exception] TFrmDB.QFunctionNPC'); 
End; 
end;

procedure TFrmDB.QMangeNPC();
var
  sScriptFile :String;
  sScritpDir  :String;
  SaveList    :TStringList;
  sShowFile   :String;
begin
Try 
try
  sScriptFile:=g_Config.sEnvirDir + 'MapQuest_def\' + 'QManage.txt';
  sShowFile:=ReplaceChar(sScriptFile,'\','/');
  sScritpDir:=g_Config.sEnvirDir + 'MapQuest_def\';
  if not DirectoryExists(sScritpDir) then
    mkdir(Pchar(sScritpDir));

  if not FileExists(sScriptFile) then begin
    SaveList:=TStringList.Create;
    SaveList.Add(';此脚为登录脚本，人物每次登录时都会执行此脚本，所有人物初始设置都可以放在此脚本中。');
    SaveList.Add(';修改脚本内容，可用@ReloadManage命令重新加载该脚本，不须重启程序。');
    SaveList.Add('[@Login]');
    SaveList.Add('#if');
    SaveList.Add('#act');
//    tSaveList.Add(';设置10倍杀怪经验');    
//    tSaveList.Add(';CANGETEXP 1 10');
    SaveList.Add('#say');
    SaveList.Add('夜猫游戏登录脚本运行成功，欢迎进入本游戏！！！\ \');
    SaveList.Add('<关闭/@exit> \ \');
    SaveList.Add('登录脚本文件位于: \');
    SaveList.Add(sShowFile + '\');
    SaveList.Add('脚本内容请自行按自己的要求修改。');
    SaveList.SaveToFile(sScriptFile);
    SaveList.Free;
  end;
  if FileExists(sScriptFile) then begin
    g_ManageNPC:=TMerchant.Create;
    g_ManageNPC.m_sMapName:='0';
    g_ManageNPC.m_nCurrX:=0;
    g_ManageNPC.m_nCurrY:=0;
    g_ManageNPC.m_sCharName:='QManage';
    g_ManageNPC.m_nFlag:=0;
    g_ManageNPC.m_wAppr:=0;
    g_ManageNPC.m_sFilePath:='MapQuest_def\';
    g_ManageNPC.m_boIsHide:=True;
    g_ManageNPC.m_boIsQuest:=False;
    UserEngine.QuestNPCList.Add(g_ManageNPC);
  end else begin
    g_ManageNPC:=nil;
  end;
except
  g_ManageNPC:=nil;
end;
Except 
  MainOutMessage('[Exception] TFrmDB.QMangeNPC'); 
End; 
end;
procedure TFrmDB.RobotNPC();
var
  sScriptFile:String;
  sScritpDir :String;
  tSaveList:TStringList;
begin
Try 
try
  sScriptFile:=g_Config.sEnvirDir + 'Robot_def\' + 'RobotManage.txt';
  sScritpDir:=g_Config.sEnvirDir + 'Robot_def\';
  if not DirectoryExists(sScritpDir) then
    mkdir(Pchar(sScritpDir));

  if not FileExists(sScriptFile) then begin
    tSaveList:=TStringList.Create;
    tSaveList.Add(';此脚为机器人专用脚本，用于机器人处理功能用的脚本。');
    tSaveList.SaveToFile(sScriptFile);
    tSaveList.Free;
  end;
  if FileExists(sScriptFile) then begin
    g_RobotNPC:=TMerchant.Create;
    g_RobotNPC.m_sMapName:='0';
    g_RobotNPC.m_nCurrX:=0;
    g_RobotNPC.m_nCurrY:=0;
    g_RobotNPC.m_sCharName:='RobotManage';
    g_RobotNPC.m_nFlag:=0;
    g_RobotNPC.m_wAppr:=0;
    g_RobotNPC.m_sFilePath:='Robot_def\';
    g_RobotNPC.m_boIsHide:=True;
    g_RobotNPC.m_boIsQuest:=False;
    UserEngine.QuestNPCList.Add(g_RobotNPC);
  end else begin
    g_RobotNPC:=nil;
  end;
except
  g_RobotNPC:=nil;
end;
Except 
  MainOutMessage('[Exception] TFrmDB.RobotNPC'); 
End; 
end;


{function TFrmDB.LoadUserCmdList():Integer;
var
  sCmdFile      :String;
  StringList    :TStringList;
  I             :Integer;
  tStr          :String;
  sCmdName,sCmd :String;
  uCmd          :pTUserCmd;
begin
  Result:=0;
  sCmdFile:='.\UserCmd.txt';
  if not FileExists(sCmdFile) then begin
    StringList:=TStringList.Create;
    StringList.Add(';用户自定义命令配置文本');
    StringList.Add(';命令名称	对应编号');
    StringList.SaveToFile(sCmdFile);
    StringList.Free;
  end;
  if FileExists(sCmdFile) then begin
    StringList:=TStringList.Create;
    StringList.LoadFromFile(sCmdFile);
    Try
      g_UserCmdList.Lock;
      Try
        for i:=0 to g_UserCmdList.Count -1 do begin
          DisPose(pTUserCmd(g_UserCmdList.Items[I]));
        end;
        g_UserCmdList.Clear;
        for i:=0 to StringList.Count -1 do begin
          tStr:=StringList.Strings[I];
          if (tStr <> '') and (tStr[1] <> ';') then begin
            tStr:=GetValidStr3(tStr,sCmdName, [' ', #9]);
            tStr:=GetValidStr3(tStr,sCmd, [' ', #9]);
            if (sCmdName<>'') and (sCmd<>'') then begin
              New(uCmd);
              uCmd.sCmdName:=sCmdName;
              uCmd.sCmd:=sCmd;
              g_UserCmdList.Add(uCmd);
            end;
          end;
        end;
      finally
        g_UserCmdList.UnLock;
      end;
    finally
      StringList.Free;
    end;
  end;
end;   }

function TFrmDB.LoadMapEvent():Integer;
var
  sFileName,tStr,sMap,sX,sY,sRate,sFlag,sValue,sItem,sRate2,sEvent,sObject,sGroup,sboEvent:String;
  MapEventList:TStringList;
  I,nX,nY,nRate,nFlag,btValue,nRate2,nObject,nSX,nSY,nEX,nEY,IIX,IIY:integer;
  MapEvent:pTMapEvent;
  Envir:TEnvirnoment;
begin
Try
  Result:=1;
  sFileName:=g_Config.sEnvirDir + 'MapEvent.txt';
  MapEventList:=TStringList.Create;
  Try
    if FileExists(sFileName) then begin
      MapEventList.LoadFromFile(sFileName);
      for i:=0 to MapEventList.Count -1 do begin
        tStr:=MapEventList.Strings[i];
        if (tStr <> '') and (tStr[1] <> ';') then begin
          tStr:=GetValidStr3(tStr, sMap, [' ', #9]);
          tStr:=GetValidStr3(tStr, sX, [' ', #9]);
          tStr:=GetValidStr3(tStr, sY, [' ', #9]);
          tStr:=GetValidStr3(tStr, sRate, [' ', #9]);
          tStr:=GetValidStr3(tStr, sValue, [' ', #9]);
          sValue:=GetValidStr3(sValue, sFlag, [':', #9]);
          tStr:=GetValidStr3(tStr, sItem, [' ', #9]);
          sItem:=GetValidStr3(sItem, sObject, [':',#9]);
          sGroup:=GetValidStr3(sItem, sItem, [':', #9]);
          tStr:=GetValidStr3(tStr, sRate2, [' ', #9]);
          tStr:=GetValidStr3(tStr, sEvent, [' ', #9]);
          sEvent:=GetValidStr3(sEvent,sboEvent, [':', #9]);

          nX:=StrToIntDef(sX,-1);
          nY:=StrToIntDef(sY,-1);
          nRate:=StrToIntDef(sRate,-1);
          nRate2:=StrToIntDef(sRate2,-1);
          nObject:=StrToIntDef(sObject,-1);
          nFlag:=StrToIntDef(sFlag,-1);
          btValue:=StrToIntDef(sValue,0);
          Envir:=g_MapManager.FindMap(sMap);
          nSX:=nX-nRate;
          nEX:=nX+nRate;
          nSY:=nY-nRate;
          nEY:=nY+nRate;
          if (Envir<>Nil) and (nX > 0) and (nY > 0) and (nRate >=0) and (nRate2 >=0) and (nObject in [1..6])  then begin
            New(MapEvent);
            MapEvent.nFlag:=nFlag;
            MapEvent.btValue:=btValue;
            MapEvent.btEventObject:=nObject;
            MapEvent.sItemName:=sItem;
            MapEvent.boGroup:=(sGroup='1');
            MapEvent.nRate:=nRate2;
            MapEvent.boEvent:=(sboEvent='1');
            MapEvent.sEvent:=sEvent;
            For IIX:=nSX to nEX do begin
              For IIY:=nSY to nEY do begin
                if Envir.AddToMap(IIX,IIY,nObject+10,TObject(MapEvent)) = MapEvent then
                  Envir.Flag.boMapEvent:=True;
              end;
            end;
          end else begin
            Result:=-I;
            break;
          end;
          //ShowMessage(Format('%s-%s-%s-%s-%s-%s-%s-%s-%s-%s-%s-%s',[sMap,sX,sY,sRate,sFlag,sValue,sObject,sItem,sGroup,sRate2,sboEvent,sEvent]))
        end;
      end;
    end else begin
      MapEventList.Add(';地图事件触发配置');
      MapEventList.SaveToFile(sFileName);
    end;
  Finally
    MapEventList.Free;
  end;
Except
  MainOutMessage('[Exception] TFrmDB.LoadMapEvent');
end;
end;



function TFrmDB.LoadMapQuest(): Integer;
var
  sFileName,tStr:String;
  tMapQuestList:TStringList;
  i:Integer;
  sMap,s1C,s20,sMonName,sItem,sQuest,s30,s34:String;
  n38,n3C:Integer;
  boGrouped:Boolean;
  Map:TEnvirnoment;
begin
Try
    Result:=1;
    sFileName:=g_Config.sEnvirDir + 'MapQuest.txt';
    if FileExists(sFileName) then begin
      tMapQuestList:=TStringList.Create;
      tMapQuestList.LoadFromFile(sFileName);
      for i:=0 to tMapQuestList.Count -1 do begin
        tStr:=tMapQuestList.Strings[i];
        if (tStr <> '') and (tStr[1] <> ';') then begin
          tStr:=GetValidStr3(tStr, sMap, [' ', #9]);
          tStr:=GetValidStr3(tStr, s1C, [' ', #9]);
          tStr:=GetValidStr3(tStr, s20, [' ', #9]);
          tStr:=GetValidStr3(tStr, sMonName, [' ', #9]);
          if (sMonName <> '') and (sMonName[1] = '"') then
            ArrestStringEx(sMonName,'"','"',sMonName);
          tStr:=GetValidStr3(tStr, sItem, [' ', #9]);
          if (sItem <> '') and (sItem[1] = '"') then
            ArrestStringEx(sItem,'"','"',sItem);
          tStr:=GetValidStr3(tStr, sQuest, [' ', #9]);
          tStr:=GetValidStr3(tStr, s30, [' ', #9]);
          if (sMap <> '') and (sMonName <> '') and (sQuest <> '') then begin
            Map:=g_MapManager.FindMap(sMap);
            if Map <> nil then begin
              ArrestStringEx(s1C,'[',']',s34);
              n38:=Str_ToInt(s34,0);
              n3C:=Str_ToInt(s20,0);
              if CompareLStr(s30,'GROUP',length('GROUP')) then boGrouped:=True
              else boGrouped:=False;
              if not Map.CreateQuest(n38,n3C,sMonName,sItem,sQuest,boGrouped) then Result:= -i;
              //nFlag,boFlag,Monster,Item,Quest,boGrouped
            end else Result:= -i;
          end else Result:= -i;
        end;
      end;
      tMapQuestList.Free;
    end;
    QMangeNPC();
    QFunctionNPC();
    QMapEnent();
    RobotNPC();
Except 
  MainOutMessage('[Exception] TFrmDB.LoadMapQuest'); 
End; 
end;


function TFrmDB.LoadMerchant(): Integer;
var
  i,II:Integer;
//  boUse:Boolean;
  tMerchantNPC:TMerchant;
  sFile : TStringList;
  sTop,sTemp,CorpsIdx: String;
begin
Try
  Result:= -1;
  EnterCriticalSection(ProcessHumanCriticalSection);
  sFile:=TStringList.Create;
  try
    sFile.Clear;
    sFile.LoadFromFile(g_Config.sEnvirDir + 'Merchant.txt');
    for I:=0 to sFile.Count-1 do begin
      sTop:=sFile.Strings[I];
      if sTop='' then Continue;
      if sTop[1]=';' then Continue;
      tMerchantNPC:=TMerchant.Create;

      sTop:=GetValidStr3(sTop,tMerchantNPC.m_sScript,[' ', ',', #9]);
      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      tMerchantNPC.m_sMapName:=sTemp;

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      tMerchantNPC.m_nCurrX:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      tMerchantNPC.m_nCurrY:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      tMerchantNPC.m_sCharName:=sTemp;
      CorpsIdx:=GetValidStr3(sTemp,sTemp,['|']);
      tMerchantNPC.m_sCharName:=sTemp;
      if CorpsIdx <> '' then begin
        for II:=Low(tMerchantNPC.m_nIconIdx) to High(tMerchantNPC.m_nIconIdx) do begin
          CorpsIdx:=GetValidStr3(CorpsIdx,sTemp, ['\']);  //特殊图标
          tMerchantNPC.m_nIconIdx[II]:=Str_ToInt(sTemp,0);
        end;
      end;

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      tMerchantNPC.m_nFlag:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      CorpsIdx:=GetValidStr3(sTemp,sTemp, ['.']);
      tMerchantNPC.m_wAppr:=Str_ToInt(sTemp,0);
      tMerchantNPC.m_btDirection:=_MIN(2,Str_ToInt(CorpsIdx,0));

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      if (sTemp='1') then
        tMerchantNPC.m_boCastle:=True
      else
        tMerchantNPC.m_boCastle:=False;

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      if (sTemp='1') then
        tMerchantNPC.m_boCanMove:=True
      else
        tMerchantNPC.m_boCanMove:=False;

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      tMerchantNPC.m_dwMoveTime:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);    //自动变色
      tMerchantNPC.m_boCanAutoColor:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);    //自动变色
      tMerchantNPC.m_nAutoChangeIdx:=Str_ToInt(sTemp,0);

      tMerchantNPC.m_dwAutoColorTime:=tMerchantNPC.m_nAutoChangeIdx*500;

      if (tMerchantNPC.m_sScript <> '') and (tMerchantNPC.m_sMapName <> '') then
        UserEngine.AddMerchant(tMerchantNPC)
      else
        tMerchantNPC.Free;
    end;
    Result:= 1;
  finally
    sFile.Free;
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadMerchant'); 
End; 
end;

//004867F4
function TFrmDB.LoadMonGen(): Integer;
var
  i,II:Integer;
//  boLoads:Boolean;
  MonGenInfo:pTMonGenInfo;
  sFile   : TStringList;
  sTop,sTemp,CorpsIdx    : String;
begin
Try 
  Result:=0;
  EnterCriticalSection(ProcessHumanCriticalSection);
  sFile:=TStringList.Create;
  try
    sFile.LoadFromFile(g_Config.sEnvirDir+'MonGen.txt');
    for i:=0 to sFile.Count -1 do begin
      sTop:=sFile.Strings[I];
      if sTop='' then Continue;
      if sTop[1]=';' then Continue;
      New(MonGenInfo);
      FillChar(MonGenInfo^,SizeOf(TMonGenInfo),#0);
      sTop:=GetValidStr3(sTop,MonGenInfo.sMapName,[' ', ',', #9]);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      MonGenInfo.nX:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      MonGenInfo.nY:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,MonGenInfo.sMonName,[' ', ',', #9]);
      CorpsIdx:=GetValidStr3(MonGenInfo.sMonName,MonGenInfo.sMonName, ['|']);
      if CorpsIdx <> '' then begin
        for II:=Low(MonGenInfo.nIconIdx) to High(MonGenInfo.nIconIdx) do begin
          CorpsIdx:=GetValidStr3(CorpsIdx,sTemp, ['\']);  //特殊图标
          MonGenInfo.nIconIdx[II]:=Str_ToInt(sTemp,0);
        end;
      end;

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      MonGenInfo.nRange:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      MonGenInfo.nCount:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      MonGenInfo.dwZenTime:=Str_ToInt(sTemp,0) * 60 * 1000;

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      MonGenInfo.nMissionGenRate:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      MonGenInfo.nColor:=Str_ToInt(sTemp,255);

      MonGenInfo.boNoManNoMon:=True;
      //MonGenInfo.boMonGhost:=False;
      //MonGenInfo.dwNoHumTime:=GetTickCount;
      //MonGenInfo.boNoManNoMon:=False;

      if (MonGenInfo.sMapName <> '') and
         (MonGenInfo.sMonName <> '') and
         (MonGenInfo.dwZenTime <> 0) and
         (g_MapManager.GetMapInfo(nServerIndex,MonGenInfo.sMapName) <> nil) then begin
        MonGenInfo.CertList:=TList.Create;
        MonGenInfo.Envir:=g_MapManager.FindMap(MonGenInfo.sMapName);
        if MonGenInfo.Envir <> nil then begin
          //MonGenInfo.boNoManNoMon:=TEnvirnoment(MonGenInfo.Envir).Flag.boNoManNoMon;
          UserEngine.m_MonGenList.Add(MonGenInfo);
        end else begin
          Dispose(MonGenInfo);
        end;
      end else Dispose(MonGenInfo);
    end;
    Result:=1;
    New(MonGenInfo);
    FillChar(MonGenInfo^,SizeOf(TMonGenInfo),#0);
    MonGenInfo.boNoManNoMon:=False;
    MonGenInfo.CertList:=TList.Create;
    UserEngine.m_MonGenList.Add(MonGenInfo);
  finally
    sFile.Free;
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadMonGen'); 
End; 
end;
//00485E04
function TFrmDB.LoadMonsterDB():Integer;
var
  i:Integer;
  Monster:pTMonInfo;
ResourceString
  sSQLString = 'SELECT * FROM Monster.DB';
begin
Try 
  Result:=0;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    for I := 0 to UserEngine.MonsterList.Count - 1 do begin
      Dispose(pTMonInfo(UserEngine.MonsterList.Items[I]));
    end;
    UserEngine.MonsterList.Clear;

    m_Query.SQL.Clear;
    m_Query.DatabaseName:=g_Config.DBName;
    m_Query.SQL.Add(sSQLString);
    try
      m_Query.Open;
    Except
      on E:Exception do begin
        Memo.Lines.Add(E.Message);
        Exit;
      end;
    end;
    for i:=0 to m_Query.RecordCount -1 do begin
      New(Monster);
      Monster.ItemList     := TList.Create;
      Monster.sName        := Trim(m_Query.FieldByName('NAME').AsString);
      Monster.btRace       := m_Query.FieldByName('RACE').AsInteger;
      Monster.btRaceImg    := m_Query.FieldByName('RACEIMG').AsInteger;
      Monster.wAppr        := m_Query.FieldByName('Appr').AsInteger;
      Monster.wLevel       := m_Query.FieldByName('LVl').AsInteger;
      Monster.btLifeAttrib := m_Query.FieldByName('UNDEAD').AsInteger;
      Monster.wCoolEye     := m_Query.FieldByName('COOLEYE').AsInteger;
      Monster.dwExp        := m_Query.FieldByName('EXP').AsInteger;

      //城门或城墙的状态跟HP值有关，如果HP异常，将导致城墙显示不了
      if Monster.btRace in [110,111] then begin //如果为城墙或城门由HP不加倍
        Monster.wHP          := m_Query.FieldByName('HP').AsInteger;
      end else begin
        Monster.wHP          := ROUND(m_Query.FieldByName('HP').AsInteger * (g_Config.nMonsterPowerRate / 10));
      end;

      Monster.wMP          := ROUND(m_Query.FieldByName('MP').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wAC          := ROUND(m_Query.FieldByName('AC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wMAC         := ROUND(m_Query.FieldByName('MAC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wDC          := ROUND(m_Query.FieldByName('DC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wMaxDC       := ROUND(m_Query.FieldByName('DCMAX').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wMC          := ROUND(m_Query.FieldByName('MC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wSC          := ROUND(m_Query.FieldByName('SC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wSpeed       := m_Query.FieldByName('Speed').AsInteger;
      Monster.wHitPoint    := m_Query.FieldByName('Hit').AsInteger;
      Monster.wWalkSpeed   := _MAX(200,m_Query.FieldByName('WALK_SPD').AsInteger);
      Monster.wWalkStep    := _MAX(1,m_Query.FieldByName('WALKSTEP').AsInteger);
      Monster.wWalkWait    := m_Query.FieldByName('WALKWAIT').AsInteger;
      Monster.wAttackSpeed := _MAX(200,m_Query.FieldByName('ATTACK_SPD').AsInteger);
      Monster.wAntiPush    := Monster.wWalkWait;
      //Monster.boAggro      := m_Query.FieldByName('FLD_AGGRO').AsBoolean;
      //Monster.boTame       := m_Query.FieldByName('FLD_TAME').AsBoolean;
      Monster.boAggro      := False;
      Monster.boTame       := False;

      if Monster.wWalkSpeed < 200 then Monster.wWalkSpeed:= 200;
      if Monster.wAttackSpeed < 200 then Monster.wAttackSpeed:= 200;
      Monster.ItemList:=nil;
      LoadMonitems(Monster.sName,Monster.ItemList);

      UserEngine.MonsterList.Add(Monster);
      Result := 1;
      m_Query.Next;
    end;
    m_Query.Close;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadMonsterDB'); 
End; 
end;

function TFrmDB.LoadMonitems(MonName:String;var ItemList:TList):Integer;//00485ABC
var
  I: Integer;
  s24:String;
  LoadList:TStringList;
  MonItem:pTMonItem;
  s28,s2C,s30:String;
  n18,n1C,n20:Integer;
begin
Try 
  Result:=0;
  s24:=g_Config.sEnvirDir + 'MonItems\' + MonName + '.txt';
  if FileExists(s24) then begin
    if ItemList <> nil then begin
      for I := 0 to Itemlist.Count - 1 do begin
        DisPose(pTMonItem(ItemList.Items[I]));
      end;
      ItemList.Clear;
    end; //00485B81
    LoadList:=TStringList.Create;
    LoadList.LoadFromFile(s24);
    for I := 0 to LoadList.Count - 1 do begin
      s28:=LoadList.Strings[I];
      if (s28 <> '') and (s28[1] <> ';') then begin
        s28:=GetValidStr3(s28,s30,[' ','/',#9]);
        n18:=Str_ToInt(s30,-1);
        s28:=GetValidStr3(s28,s30,[' ','/',#9]);
        n1C:=Str_ToInt(s30,-1);
        s28:=GetValidStr3(s28,s30,[' ',#9]);
        if s30 <> '' then begin
          if s30[1] = '"' then
            ArrestStringEx(s30,'"','"',s30);
        end;
        s2C:=s30;
        s28:=GetValidStr3(s28,s30,[' ',#9]);
        n20:=Str_ToInt(s30,1);
        if (n18 > 0) and (n1C > 0) and (s2C <> '') then begin
          if ItemList = nil then ItemList:=TList.Create;
          New(MonItem);
          MonItem.SelPoint:=n18 -1;
          MonItem.MaxPoint:=n1C;
          MonItem.ItemName:=s2C;
          MonItem.Count:=n20;
          ItemList.Add(MonItem);
          Inc(Result);
        end;
      end;
    end;
    LoadList.Free;
  end;
    
Except 
  MainOutMessage('[Exception] TFrmDB.LoadMonitems'); 
End; 
end;
//00488178
function TFrmDB.LoadNpcs(): Integer;
var
  i,II,nType:Integer;
//  boUse:Boolean;
  NPC:TNormNpc;
  sFile : TStringList;
  sTop,sTemp,sName,CorpsIdx : String;
begin
Try
  Result:= -1;
  EnterCriticalSection(ProcessHumanCriticalSection);
  sFile:=TStringList.Create;
  try
    sFile.LoadFromFile(g_Config.sEnvirDir + 'Npcs.txt');
    for I:=0 to sFile.Count-1 do begin
      sTop:=sFile.Strings[I];
      if sTop='' then Continue;
      if sTop[1]=';' then Continue;
      NPC:=nil;
      sTop:=GetValidStr3(sTop,sName,[' ', ',', #9]);
      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      nType:=Str_ToInt(sTemp,0);
      case nType of
        0: NPC:=TMerchant.Create;
        1: NPC:=TGuildOfficial.Create;
        2: NPC:=TCastleOfficial.Create;
      end;
      if NPC <> nil then begin
        NPC.m_sCharName:=sName;
        CorpsIdx:=GetValidStr3(sName,sTemp,['|']);
        NPC.m_sCharName:=sTemp;
        if CorpsIdx <> '' then begin
          for II:=Low(NPC.m_nIconIdx) to High(NPC.m_nIconIdx) do begin
            CorpsIdx:=GetValidStr3(CorpsIdx,sTemp, ['\']);  //特殊图标
            NPC.m_nIconIdx[II]:=Str_ToInt(sTemp,0);
          end;
        end;

        sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
        NPC.m_sMapName:=sTemp;
        
        sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
        NPC.m_nCurrX:=Str_ToInt(sTemp,0);

        sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
        NPC.m_nCurrY:=Str_ToInt(sTemp,0);

        sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
        NPC.m_nFlag:=Str_ToInt(sTemp,0);

        sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
        NPC.m_wAppr:=Str_ToInt(sTemp,0);

        UserEngine.QuestNPCList.Add(NPC);
      end;
      Result := 1;
    end;
  finally
    sFile.Free;
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadNpcs'); 
End; 
end;
//00489840
function TFrmDB.LoadQuestDiary(): Integer;
  function sub_48978C(nIndex:Integer):String;
  begin
    if nIndex >= 1000 then begin
      Result:=IntToStr(nIndex);
      exit;
    end;
    if nIndex >= 100 then begin
      Result:=IntToStr(nIndex) + '0';
      exit;
    end;
    Result:=IntToStr(nIndex) + '00';
  end;
var
  i,ii:Integer;
  QDDinfoList:TList;
  QDDinfo:pTQDDinfo;
  s14,s18,s1C,s20:String;
  bo2D:Boolean;
  nC:Integer;
  LoadList:TStringList;
begin
Try 
    Result:=1;
    for i:=0 to QuestDiaryList.Count -1 do begin
       QDDinfoList:=QuestDiaryList.Items[i];
       for ii:=0 to QDDinfoList.Count -1 do begin
         QDDinfo:=QDDinfoList.Items[ii];
         QDDinfo.sList.Free;
         Dispose(QDDinfo);
       end;
       QDDinfoList.Free;
    end;
    QuestDiaryList.Clear;
    bo2D:=False;
    nC:=1;
    while (True) do begin
      QDDinfoList:=nil;
      s14:='QuestDiary\' + sub_48978C(nC) + '.txt';
      if FileExists(s14) then begin
        s18:='';
        QDDinfo:=nil;
        LoadList:=TStringList.Create;
        LoadList.LoadFromFile(s14);
        for i:=0 to LoadList.Count -1 do begin
          s1C:=LoadList.Strings[i];
          if (s1C <> '') and (s1C[1] <> ';') then begin
            if (s1C[1] = '[') and (length(s1C) > 2) then begin
              if s18 = '' then begin
                ArrestStringEx(s1C,'[',']',s18);
                QDDinfoList:=TList.Create;
                New(QDDinfo);
                QDDinfo.n00:=nC;
                QDDinfo.s04:=s18;
                QDDinfo.sList:=TStringList.Create;
                QDDinfoList.Add(QDDinfo);
                bo2D:=True;
              end else begin
                if s1C[1] <> '@' then begin
                  s1C:=GetValidStr3(s1C,s20,[' ',#9]);
                  ArrestStringEx(s20,'[',']',s20);
                  New(QDDinfo);
                  QDDinfo.n00:=Str_ToInt(s20,0);
                  QDDinfo.s04:=s1C;
                  QDDinfo.sList:=TStringList.Create;
                  QDDinfoList.Add(QDDinfo);
                  bo2D:=True;
                end else bo2D:=False;
              end;
            end else begin //00489AFD
              if bo2D then QDDinfo.sList.Add(s1C);
            end;
          end;//00489B11
        end;
        LoadList.Free;
      end;//00489B25
      if QDDinfoList <> nil then QuestDiaryList.Add(QDDinfoList)
      else QuestDiaryList.Add(nil);
      Inc(nC);
      if nC >= 105 then break;
    end;

Except 
  MainOutMessage('[Exception] TFrmDB.LoadQuestDiary'); 
End; 
end;
//00488EF0
function TFrmDB.LoadStartPoint(): Integer;
var
  i:Integer;
  sMap:String;
  StartPoint:pTStartPoint;
  sFile     : TStringList;
  sTop,sTemp  : String;
  Envir:TEnvirnoment;
  procedure ShowSafeZoneAureole(Envir:TEnvirnoment;nX,nY,nSize,nType:Integer);
  var
    //HolyCurtainEvent :THolyCurtainEvent;
    I:Integer;
    nStartX:Integer;
    nEndX:Integer;
    nStartY:Integer;
    nEndY:Integer;
  begin
    if nSize > 0 then begin
      nStartX :=nX - nSize;
      nEndX   :=nX + nSize;
      nStartY :=nY - nSize;
      nEndY   :=nY + nSize;
      for I:=nStartX to nEndX do begin
        THolyCurtainEvent.Create(Envir,I,nStartY,nType,0);
        THolyCurtainEvent.Create(Envir,I,nEndY,nType,0);
      end;
      for I:=nStartY to nEndY do begin
        THolyCurtainEvent.Create(Envir,nStartX,I,nType,0);
        THolyCurtainEvent.Create(Envir,nEndX,I,nType,0);
      end;
    end;
  end;
begin
Try 
  Result:= -1;
  EnterCriticalSection(ProcessHumanCriticalSection);
  sFile:=TStringList.Create;
  try
    g_StartPoint.Lock;
    Try
      for I := 0 to g_StartPoint.Count - 1 do begin
        Dispose(pTStartPoint(g_StartPoint.Items[I]));
      end;
      g_StartPoint.Clear;
      sFile.LoadFromFile(g_Config.sEnvirDir + 'StartPoint.txt');
      for I:=0 to sFile.Count-1 do begin
        sTop:=sFile.Strings[I];
        if sTop='' then Continue;
        if sTop[1]=';' then Continue;
        sTop:=GetValidStr3(sTop,sMap,[' ', ',', #9]);
        Envir:= g_MapManager.FindMap(sMap);
        if Envir<>NIl then begin
          New(StartPoint);
          StartPoint.sMapName:=sMap;
          sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
          StartPoint.nX:=Str_ToInt(sTemp,0);

          sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
          StartPoint.nY:=Str_ToInt(sTemp,0);

          sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
          if sTemp='1' then StartPoint.boCloseSay:=True
          Else  StartPoint.boCloseSay:=False;

          sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
          StartPoint.nSize:=Str_ToInt(sTemp,0);

          sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
          StartPoint.nClass:=Str_ToInt(sTemp,0);

          sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
          if sTemp='1' then StartPoint.boPKZone:=True
          Else  StartPoint.boPKZone:=False;

          sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
          if sTemp='1' then StartPoint.boPKFire:=True
          Else  StartPoint.boPKFire:=False;

          StartPoint.Envir            := Envir;
          StartPoint.btJob            := 99;
          StartPoint.dwWhisperTick    := GetTickCount();
          g_StartPoint.Add(StartPoint);
          ShowSafeZoneAureole(StartPoint.Envir,StartPoint.nX,StartPoint.nY,StartPoint.nSize,StartPoint.nClass);
          //MainOutMessage(StartPoint.sMapName);
          Result:= 1;
        end;
      end;
    finally
      g_StartPoint.UnLock;
    end;
  finally
    sFile.Free;
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadStartPoint'); 
End; 
end;
//00489240
function TFrmDB.LoadUnbindList(): Integer;
var
  sFileName,tStr,sData,s20:String;
//  tUnbind:pTUnbindInfo;
  LoadList:TStringList;
  i:Integer;
  n10:Integer;
begin
Try
    Result:=0;
    sFileName:=g_Config.sEnvirDir + 'UnbindList.txt';
    if FileExists(sFileName) then begin
      LoadList:=TStringList.Create;
      LoadList.LoadFromFile(sFileName);
      for i:=0 to LoadList.Count -1 do begin
        tStr:=LoadList.Strings[i];
        if (tStr <> '') and (tStr[1] <> ';') then begin
          //New(tUnbind);
          tStr:=GetValidStr3(tStr, sData, [' ', #9]);
          tStr:=GetValidStrCap(tStr, s20, [' ', #9]);
          if (s20 <> '') and (s20[1] = '"') then
            ArrestStringEx(s20,'"','"',s20);

          n10:=Str_ToInt(sData,0);
          if n10 > 0 then g_UnbindList.AddObject(s20,TObject(n10))
          else begin
            Result:=-i;  //需要取负数
            break;
          end;
        end;
      end;
      LoadList.Free;
      LoadOpenItemList;
    end;
Except
  MainOutMessage('[Exception] TFrmDB.LoadUnbindList');
End;
end;

//自动解包列表
function TFrmDB.LoadOpenItemList: Integer;
var
  I: Integer;
  stdname:string;
begin
Try
  Result:=-1;
  if g_UnbindList.Count<1 then Exit;
  SetLength(UserEngine.g_OpenItemArray,g_UnbindList.Count);
  FillChar(UserEngine.g_OpenItemArray[0],Length(UserEngine.g_OpenItemArray),#0);
  for I := 0 to g_UnbindList.Count - 1 do
   begin
    stdname:=GetStditemName(Integer(g_UnbindList.Objects[I]));
    if stdname<>'' then
    begin
      UserEngine.g_OpenItemArray[i].sItemName:=g_UnbindList.Strings[i];
      UserEngine.g_OpenItemArray[i].sBItemName:=stdname;
      Result:=i;
    end;
   end;
Except
  MainOutMessage('[Exception] TFrmDB.LoadUnbindList');
End;
end;

function TFrmDB.GetStditemName(iShape: Integer): String;
var
  I: Integer;
  StdItem: TItem;
begin
  try
    Result :='';
    for I := 0 to UserEngine.StdItemList.Count - 1 do
    begin
      StdItem := UserEngine.StdItemList.Items[i];
      if (StdItem.StdMode=31) and (StdItem.Shape=iShape) then
      begin
        Result := StdItem.Name;
        break;
      end;
    end;
  except
    MainOutMessage('[Exception] TFrmDB.GetStditemName');
  end;
end;
function TFrmDB.LoadNpcScript(NPC: TNormNpc; sPatch,
  sScritpName: String): Integer; //0048C4D8
begin
Try
  if sPatch = '' then sPatch:=sNpc_def;
  Result:=LoadScriptFile(NPC,sPatch,sScritpName,False);
Except
  MainOutMessage('[Exception] TFrmDB.LoadNpcScript'); 
End; 
end;

function TFrmDB.LoadScriptFile(NPC: TNormNpc; sPatch, sScritpName: String;
  boFlag: Boolean): Integer; //0048B684
var
  nQuestIdx,I,n1C,n20,n24,nItemType,nPriceRate: Integer;
  n6C,n70:Integer;
  sScritpFileName,s30,s34,s38,s3C,s40,s44,s48,s4C,s50:String;
  LoadList:TStringList;
  DefineList:TList;
  s54,s58,s5C,s74:String;
  DefineInfo:pTDefineInfo;
  bo8D:Boolean;
  Script:pTScript;
  SayingRecord:pTSayingRecord;
  SayingProcedure:pTSayingProcedure;
  QuestConditionInfo:pTQuestConditionInfo;
  QuestActionInfo:pTQuestActionInfo;
  Goods:pTGoods;
  function LoadCallScript(sFileName,sLabel:String;List:TStringList):Boolean; //00489BD4
  var
    I: Integer;
    LoadStrList:TStringList;
    bo1D:Boolean;
    s18:String;
  begin
    Result:=False;
    SayingProcedure:=Nil;
    if FileExists(sFileName) then begin
      LoadStrList:=TStringList.Create;
      LoadStrList.LoadFromFile(sFileName);
      DeCodeList(LoadStrList);
      DeCodeStringList(LoadStrList);
      sLabel:='[' + sLabel + ']';
      bo1D:=False;
      for I := 0 to LoadStrList.Count - 1 do begin
        s18:=Trim(LoadStrList.Strings[i]);
        if s18 <> '' then begin
          if not bo1D then begin
            if (s18[1] = '[') and (CompareText(s18,sLabel) = 0) then begin
              bo1D:=True;
              List.Add(s18);
            end;              
          end else begin //00489CBF
            if s18[1] <> '{'  then begin
              if s18[1] = '}'  then begin
//                bo1D:=False;
                Result:=True;
                break;
              end else begin  //00489CD9
                List.Add(s18);
              end;
            end;
          end;
        end; //00489CE4 if s18 <> '' then begin
      end; // for I := 0 to LoadStrList.Count - 1 do begin
      LoadStrList.Free;
    end;
      
  end;
  procedure LoadScriptcall(LoadList:TStringList); //0048B138
  var
    I: Integer;
    s14,s18,s1C,s20,s34{,sUrl,sTemp}:String;
    TempList:TStringList;
    Ing:Integer;
  begin
    I:=0;
    Ing:=0;
    while (I < LoadList.Count) do begin //Jason 071209修改
    //for I := 0 to LoadList.Count - 1 do begin
      if Ing > 5000 then break;
      s14:=Trim(LoadList.Strings[i]);
      if (s14 <> '') and (s14[1] = '#') then begin
        if CompareLStr(s14,'#CALL',length('#CALL')) then begin
          Inc(Ing);
          s14:=ArrestStringEx(s14,'[',']',s1C);
          s20:=Trim(s1C);
          s18:=Trim(s14);
          s34:=g_Config.sEnvirDir + 'QuestDiary\' + s20;
          if LoadCallScript(s34,s18,LoadList) then begin
            LoadList.Strings[i]:='#ACT';
            LoadList.Insert(i + 1,'goto ' + s18);
          end else begin
            MainOutMessage('脚本错误, load fail: ' + s20 + s18);
          end;
        end else     //远程读取脚本功能
        if CompareLStr(s14,'#URLCALL',length('#URLCALL')) then begin
          Inc(Ing);
          s14:=ArrestStringEx(s14,'[',']',s1C);
          s20:=Trim(s1C);
          s18:=Trim(s14);
          //sUrl:=ArrestStringEx(s20,'/','/',sTemp);
          //sTemp:=AnsiReplaceText(sUrl,'/','.');
          //MainOutMessage(sTemp);
          s34:=g_Config.sEnvirDir+TEMPSCRIPTFILE;
          M2Share.GetInetFile(s20,s34);
          TempList:=TStringList.Create;
          Try
            Try
              TempList.LoadFromFile(s34);
              if (TempList.Count > 0) and
                 (TempList.Strings[0]=';JS') and
                 (TempList.Strings[TempList.Count-1]=';JS') then begin
                if LoadCallScript(s34,s18,LoadList) then begin
                  LoadList.Strings[i]:='#ACT';
                  LoadList.Insert(i + 1,'goto ' + s18);
                end else begin
                  MainOutMessage('加载脚本失败: ' + s20 + s18);
                end;
              end else
                MainOutMessage('读取远程脚本失败: ' + s20 + s18);
            Except
              MainOutMessage('读取远程脚本失败: ' + s20 + s18);
            end;
          Finally
            TempList.Free;
          end;

        end;
      end;
      Inc(I);
    end;
  end;

  function LoadDefineInfo(LoadList:TStringList;List:TList):String; //0048B35C
  var
    I: Integer;
    s14,s28,s1C,s20,s24:String;
    DefineInfo:pTDefineInfo;
    LoadStrList:TStringList;
  begin
    for I := 0 to LoadList.Count - 1 do begin
      s14:=Trim(LoadList.Strings[i]);
      if (s14 <> '') and (s14[1] = '#') then begin
        if CompareLStr(s14,'#SETHOME',length('#SETHOME')) then begin
          Result:=Trim(GetValidStr3(s14,s1C,[' ',#9]));
          LoadList.Strings[i]:='';
        end;
        if CompareLStr(s14,'#DEFINE',length('#DEFINE')) then begin
          s14:=(GetValidStr3(s14,s1C,[' ',#9]));
          s14:=(GetValidStr3(s14,s20,[' ',#9]));
          s14:=(GetValidStr3(s14,s24,[' ',#9]));
          New(DefineInfo);
          DefineInfo.sName:=UpperCase(s20);
          DefineInfo.sText:=s24;
          List.Add(DefineInfo);
          LoadList.Strings[i]:='';
        end; //0048B505
        if CompareLStr(s14,'#INCLUDE',length('#INCLUDE')) then begin
          s28:=Trim(GetValidStr3(s14,s1C,[' ',#9]));
          s28:=g_Config.sEnvirDir + 'Defines\' + s28;
          if FileExists(s28) then begin
            LoadStrList:=TStringList.Create;
            LoadStrList.LoadFromFile(s28);
            Result:=LoadDefineInfo(LoadStrList,List);
            LoadStrList.Free;
          end else begin
            MainOutMessage('脚本错误, load fail: ' + s28);
          end;
          LoadList.Strings[i]:='';
        end;
      end;
    end;
  end;
  function MakeNewScript():pTScript; //00489D74
  var
    ScriptInfo:pTScript;
  begin
    New(ScriptInfo);
    ScriptInfo.boQuest:=False;
    FillChar(ScriptInfo.QuestInfo,SizeOf(TQuestInfo),#0);
    nQuestIdx:=0;
    ScriptInfo.RecordList:=TList.Create;
    NPC.m_ScriptList.Add(ScriptInfo);
    Result:=ScriptInfo;
  end;
  function QuestCondition(sText:String;QuestConditionInfo:pTQuestConditionInfo):Boolean; //00489DDC
  var
    sCmd,sTemp,sParam1,sParam2,sParam3,sParam4,sParam5,sParam6,sParam7:String;
    nCMDCode:Integer;
  Label L001;
  begin
    Result:=False;
    sText:=GetValidStrCap(sText,sCmd,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam1,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam2,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam3,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam4,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam5,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam6,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam7,[' ',#9]);
    sTemp:=GetValidStrCap(sCmd,sCmd,['.']);
    while (sTemp<>'') do begin
      if QuestConditionInfo.TCmdList=Nil then QuestConditionInfo.TCmdList:=TStringList.Create;
      QuestConditionInfo.TCmdList.Add(sCmd);
      sTemp:=GetValidStrCap(sTemp,sCmd,['.']);
    end;

    sCmd:=UpperCase(sCmd);
    nCMDCode:=0;
    if sCmd = sCHECK then begin
      nCMDCode:=nCHECK;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
      Goto L001;
    end;
    {if sCmd = sCHECKOPEN then begin
      nCMDCode:=nCHECKOPEN;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
      Goto L001;
    end;}

    {if sCmd = sCHECKUNIT then begin
      nCMDCode:=nCHECKUNIT;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
      Goto L001;
    end;}
    if sCmd = sCHECKPKPOINT then begin
      nCMDCode:=nCHECKPKPOINT;
      Goto L001;
    end;
    if sCmd = sCHECKGOLD then begin
      nCMDCode:=nCHECKGOLD;
      Goto L001;
    end;
    if sCmd = sCHECKLEVEL then begin
      nCMDCode:=nCHECKLEVEL;
      Goto L001;
    end;
    if sCmd = sCHECKJOB then begin
      nCMDCode:=nCHECKJOB;
      Goto L001;
    end;
    if sCmd = sRANDOM then begin //00489FB2
      nCMDCode:=nRANDOM;
      Goto L001;
    end;
    if sCmd = sCHECKITEM then begin
      nCMDCode:=nCHECKITEM;
      Goto L001;
    end;
    if sCmd = sGENDER then begin
      nCMDCode:=nGENDER;
      Goto L001;
    end;
    if sCmd = sCHECKBAGGAGE then begin
      nCMDCode:=nCHECKBAGGAGE;
      Goto L001;
    end;

    if sCmd = sCHECKNAMELIST then begin
      nCMDCode:=nCHECKNAMELIST;
      Goto L001;
    end;
    if sCmd = sSC_HASGUILD then begin
      nCMDCode:=nSC_HASGUILD;
      Goto L001;
    end;

    if sCmd = sSC_ISGUILDMASTER then begin
      nCMDCode:=nSC_ISGUILDMASTER;
      Goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEMASTER then begin
      nCMDCode:=nSC_CHECKCASTLEMASTER;
      Goto L001;
    end;
    if sCmd = sSC_ISNEWHUMAN then begin
      nCMDCode:=nSC_ISNEWHUMAN;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMEMBERTYPE then begin
      nCMDCode:=nSC_CHECKMEMBERTYPE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMEMBERLEVEL then begin
      nCMDCode:=nSC_CHECKMEMBERLEVEL;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGAMEGOLD then begin
      nCMDCode:=nSC_CHECKGAMEGOLD;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGAMEPOINT then begin
      nCMDCode:=nSC_CHECKGAMEPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKNAMELISTPOSITION then begin
      nCMDCode:=nSC_CHECKNAMELISTPOSITION;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGUILDLIST then begin
      nCMDCode:=nSC_CHECKGUILDLIST;
      Goto L001;
    end;
    if sCmd = sSC_CHECKRENEWLEVEL then begin
      nCMDCode:=nSC_CHECKRENEWLEVEL;
      Goto L001;
    end;
    if sCmd = sSC_CHECKSLAVELEVEL then begin
      nCMDCode:=nSC_CHECKSLAVELEVEL;
      Goto L001;
    end;
    if sCmd = sSC_CHECKSLAVENAME then begin
      nCMDCode:=nSC_CHECKSLAVENAME;
      Goto L001;
    end;
    if sCmd = sSC_CHECKCREDITPOINT then begin
      nCMDCode:=nSC_CHECKCREDITPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKOFGUILD then begin
      nCMDCode:=nSC_CHECKOFGUILD;
      Goto L001;
    end;
    if sCmd = sSC_CHECKPAYMENT then begin
      nCMDCode:=nSC_CHECKPAYMENT;
      Goto L001;
    end;

    if sCmd = sSC_CHECKUSEITEM then begin
      nCMDCode:=nSC_CHECKUSEITEM;
      Goto L001;
    end;
    if sCmd = sSC_CHECKBAGSIZE then begin
      nCMDCode:=nSC_CHECKBAGSIZE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKLISTCOUNT then begin
      nCMDCode:=nSC_CHECKLISTCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKDC then begin
      nCMDCode:=nSC_CHECKDC;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMC then begin
      nCMDCode:=nSC_CHECKMC;
      Goto L001;
    end;
    if sCmd = sSC_CHECKSC then begin
      nCMDCode:=nSC_CHECKSC;
      Goto L001;
    end;
    if sCmd = sSC_CHECKHP then begin
      nCMDCode:=nSC_CHECKHP;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMP then begin
      nCMDCode:=nSC_CHECKMP;
      Goto L001;
    end;
    if sCmd = sSC_CHECKITEMTYPE then begin
      nCMDCode:=nSC_CHECKITEMTYPE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKEXP then begin
      nCMDCode:=nSC_CHECKEXP;
      Goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEGOLD then begin
      nCMDCode:=nSC_CHECKCASTLEGOLD;
      Goto L001;
    end;
    if sCmd = sSC_PASSWORDERRORCOUNT then begin
      nCMDCode:=nSC_PASSWORDERRORCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_ISLOCKPASSWORD then begin
      nCMDCode:=nSC_ISLOCKPASSWORD;
      Goto L001;
    end;
    if sCmd = sSC_ISLOCKSTORAGE then begin
      nCMDCode:=nSC_ISLOCKSTORAGE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKBUILDPOINT then begin
      nCMDCode:=nSC_CHECKBUILDPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKAURAEPOINT then begin
      nCMDCode:=nSC_CHECKAURAEPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKSTABILITYPOINT then begin
      nCMDCode:=nSC_CHECKSTABILITYPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKFLOURISHPOINT then begin
      nCMDCode:=nSC_CHECKFLOURISHPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKCONTRIBUTION then begin
      nCMDCode:=nSC_CHECKCONTRIBUTION;
      Goto L001;
    end;
    if sCmd = sSC_CHECKRANGEMONCOUNT then begin
      nCMDCode:=nSC_CHECKRANGEMONCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKITEMADDVALUE then begin
      nCMDCode:=nSC_CHECKITEMADDVALUE;
      Goto L001;
    end;
//{$IF SoftVersion = VERENT}
    if sCmd = sSC_CHECKINMAPRANGE then begin
      nCMDCode:=nSC_CHECKINMAPRANGE;
      Goto L001;
    end;
//{$IFEND}
    if sCmd = sSC_CASTLECHANGEDAY then begin
      nCMDCode:=nSC_CASTLECHANGEDAY;
      Goto L001;
    end;
    if sCmd = sSC_CASTLEWARDAY then begin
      nCMDCode:=nSC_CASTLEWARDAY;
      Goto L001;
    end;
    if sCmd = sSC_ONLINELONGMIN then begin
      nCMDCode:=nSC_ONLINELONGMIN;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGUILDCHIEFITEMCOUNT then begin
      nCMDCode:=nSC_CHECKGUILDCHIEFITEMCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKNAMEDATELIST then begin
      nCMDCode:=nSC_CHECKNAMEDATELIST;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMAPHUMANCOUNT then begin
      nCMDCode:=nSC_CHECKMAPHUMANCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMAPMONCOUNT then begin
      nCMDCode:=nSC_CHECKMAPMONCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKVAR then begin
      nCMDCode:=nSC_CHECKVAR;
      Goto L001;
    end;
    if sCmd = sSC_CHECKSERVERNAME then begin
      nCMDCode:=nSC_CHECKSERVERNAME;
      Goto L001;
    end;

    if sCmd = sSC_ISATTACKGUILD then begin
      nCMDCode:=nSC_ISATTACKGUILD;
      Goto L001;
    end;
    if sCmd = sSC_ISDEFENSEGUILD then begin
      nCMDCode:=nSC_ISDEFENSEGUILD;
      Goto L001;
    end;

    {if sCmd = sSC_ISATTACKALLYGUILD then begin
      nCMDCode:=nSC_ISATTACKALLYGUILD;
      Goto L001;
    end;
    if sCmd = sSC_ISDEFENSEALLYGUILD then begin
      nCMDCode:=nSC_ISDEFENSEALLYGUILD;
      Goto L001;
    end;}

    if sCmd = sSC_ISCASTLEGUILD then begin
      nCMDCode:=nSC_ISCASTLEGUILD;
      Goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEDOOR then begin
      nCMDCode:=nSC_CHECKCASTLEDOOR;
      Goto L001;
    end;

    {if sCmd = sSC_ISSYSOP then begin
      nCMDCode:=nSC_ISSYSOP;
      Goto L001;
    end;}
    if sCmd = sSC_ISADMIN then begin
      nCMDCode:=nSC_ISADMIN;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGROUPCOUNT then begin
      nCMDCode:=nSC_CHECKGROUPCOUNT;
      Goto L001;
    end;

    if sCmd = sCHECKACCOUNTLIST then begin
      nCMDCode:=nCHECKACCOUNTLIST;
      Goto L001;
    end;
    if sCmd = sCHECKIPLIST then begin
      nCMDCode:=nCHECKIPLIST;
      Goto L001;
    end;
    {if sCmd = sCHECKBBCOUNT then begin
      nCMDCode:=nCHECKBBCOUNT;
      Goto L001;
    end;}
    {if sCmd = sCHECKCREDITPOINT then begin
      nCMDCode:=nCHECKCREDITPOINT;
      Goto L001;
    end;}

    if sCmd = sSC_DAYTIME then begin
      nCMDCode:=nSC_DAYTIME;
      Goto L001;
    end;
    if sCmd = sCHECKITEMW then begin
      nCMDCode:=nCHECKITEMW;
      Goto L001;
    end;
    {if sCmd = sISTAKEITEM then begin
      nCMDCode:=nISTAKEITEM;
      Goto L001;
    end;}
    if sCmd = sSC_CHECKDURA then begin
      nCMDCode:=nSC_CHECKDURA;
      Goto L001;
    end;
    {if sCmd = sCHECKDURAEVA then begin
      nCMDCode:=nCHECKDURAEVA;
      Goto L001;
    end;}
    if sCmd = sDAYOFWEEK then begin
      nCMDCode:=nDAYOFWEEK;
      Goto L001;
    end;
    if sCmd = sHOUR then begin
      nCMDCode:=nHOUR;
      Goto L001;
    end;
    if sCmd = sMIN then begin
      nCMDCode:=nMIN;
      Goto L001;
    end;
    {if sCmd = sCHECKLUCKYPOINT then begin
      nCMDCode:=nCHECKLUCKYPOINT;
      Goto L001;
    end;}
    if sCmd = sCHECKMONMAP then begin
      nCMDCode:=nCHECKMONMAP;
      Goto L001;
    end;
    {if sCmd = sCHECKMONAREA then begin
      nCMDCode:=nCHECKMONAREA;
      Goto L001;
    end;}
    if sCmd = sCHECKHUM then begin
      nCMDCode:=nCHECKHUM;
      Goto L001;
    end;
    if sCmd = sEQUAL then begin
      nCMDCode:=nEQUAL;
      Goto L001;
    end;

    if sCmd = sLARGE then begin
      nCMDCode:=nLARGE;
      Goto L001;
    end;

    if sCmd = sSMALL then begin
      nCMDCode:=nSMALL;
      Goto L001;
    end;

    if sCmd = sSC_CHECKPOSEDIR then begin
      nCMDCode:=nSC_CHECKPOSEDIR;
      Goto L001;
    end;

    if sCmd = sSC_CHECKPOSELEVEL then begin
      nCMDCode:=nSC_CHECKPOSELEVEL;
      Goto L001;
    end;

    if sCmd = sSC_CHECKPOSEGENDER then begin
      nCMDCode:=nSC_CHECKPOSEGENDER;
      Goto L001;
    end;

    if sCmd = sSC_CHECKLEVELEX then begin
      nCMDCode:=nSC_CHECKLEVELEX;
      Goto L001;
    end;

    if sCmd = sSC_CHECKBONUSPOINT then begin
      nCMDCode:=nSC_CHECKBONUSPOINT;
      Goto L001;
    end;

    if sCmd = sSC_CHECKMARRY then begin
      nCMDCode:=nSC_CHECKMARRY;
      Goto L001;
    end;
    if sCmd = sSC_CHECKPOSEMARRY then begin
      nCMDCode:=nSC_CHECKPOSEMARRY;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMARRYCOUNT then begin
      nCMDCode:=nSC_CHECKMARRYCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMASTER then begin
      nCMDCode:=nSC_CHECKMASTER;
      Goto L001;
    end;
    if sCmd = sSC_HAVEMASTER then begin
      nCMDCode:=nSC_HAVEMASTER;
      Goto L001;
    end;
    if sCmd = sSC_CHECKPOSEMASTER then begin
      nCMDCode:=nSC_CHECKPOSEMASTER;
      Goto L001;
    end;
    if sCmd = sSC_POSEHAVEMASTER then begin
      nCMDCode:=nSC_POSEHAVEMASTER;
      Goto L001;
    end;
    if sCmd = sSC_CHECKISMASTER then begin
      nCMDCode:=nSC_CHECKISMASTER;
      Goto L001;
    end;
    if sCmd = sSC_CHECKPOSEISMASTER then begin
      nCMDCode:=nSC_CHECKPOSEISMASTER;
      Goto L001;
    end;
    if sCmd = sSC_CHECKNAMEIPLIST then begin
      nCMDCode:=nSC_CHECKNAMEIPLIST;
      Goto L001;
    end;
    if sCmd = sSC_CHECKACCOUNTIPLIST then begin
      nCMDCode:=nSC_CHECKACCOUNTIPLIST;
      Goto L001;
    end;
    if sCmd = sSC_CHECKSLAVECOUNT then begin
      nCMDCode:=nSC_CHECKSLAVECOUNT;
      Goto L001;
    end;

    {if sCmd = sSC_CHECKPOS then begin
      nCMDCode:=nSC_CHECKPOS;
      Goto L001;
    end; }
    if sCmd = sSC_CHECKMAP then begin
      nCMDCode:=nSC_CHECKMAP;
      Goto L001;
    end;
    {if sCmd = sSC_REVIVESLAVE then begin
      nCMDCode:=nSC_REVIVESLAVE;
      Goto L001;
    end; }
    if sCmd = sSC_CHECKMAGICLVL then begin
      nCMDCode:=nSC_CHECKMAGICLVL;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGROUPCLASS then begin
      nCMDCode:=nSC_CHECKGROUPCLASS;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGAMEDIAMOND then begin
      nCMDCode:=nSC_CHECKGAMEDIAMOND;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGAMEGIRD then begin
      nCMDCode:=nSC_CHECKGAMEGIRD;
      Goto L001;
    end;
    if sCmd = sSC_ISGROUPMASTER then begin
      nCMDCode:=nSC_ISGROUPMASTER;
      Goto L001;
    end;
    if sCmd = sSC_ISONMAP then begin
      nCMDCode:=nSC_ISONMAP;
      Goto L001;
    end;
    if sCmd = sSC_HAVEHERO then begin
      nCMDCode:=nSC_HAVEHERO;
      Goto L001;
    end;
    if sCmd = sSC_INSAFEZONE then begin
      nCMDCode:=nSC_INSAFEZONE;
      Goto L001;
    end;
    if sCmd = sSC_ISDUPMODE then begin
      nCMDCode:=nSC_ISDUPMODE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKITEMSTATE then begin
      nCMDCode:=nSC_CHECKITEMSTATE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKDURAEVA then begin
      nCMDCode:=nSC_CHECKDURAEVA;
      Goto L001;
    end;
    if sCmd = sSC_CHECKONLINE then begin
      nCMDCode:=nSC_CHECKONLINE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKCONTAINSTEXT then begin
      nCMDCode:=nSC_CHECKCONTAINSTEXT;
      Goto L001;
    end;
    if sCmd = sSC_COMPARETEXT then begin
      nCMDCode:=nSC_COMPARETEXT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEWAR then begin
      nCMDCode:=nSC_CHECKCASTLEWAR;
      Goto L001;
    end;
    if sCmd = sSC_MAPHUMISSAMEGUILD then begin
      nCMDCode:=nSC_MAPHUMISSAMEGUILD;
      Goto L001;
    end;
    if sCmd = sSC_CHECKHEROONLINE then begin
      nCMDCode:=nSC_CHECKHEROONLINE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKHEROLEVEL then begin
      nCMDCode:=nSC_CHECKHEROLEVEL;
      Goto L001;
    end;
    if sCmd = sSC_CHECKHEROJOB then begin
      nCMDCode:=nSC_CHECKHEROJOB;
      Goto L001;
    end;
    if sCmd = sSC_CHECKHEROPKPOINT then begin
      nCMDCode:=nSC_CHECKHEROPKPOINT;
      Goto L001;
    end;
    if sCmd = sSC_OFFLINEPLAYERCOUNT then begin
      nCMDCode:=nSC_OFFLINEPLAYERCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKUSERDATE then begin
      nCMDCode:=nSC_CHECKUSERDATE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKRANDOMNO then begin
      nCMDCode:=nSC_CHECKRANDOMNO;
      Goto L001;
    end;
    if sCmd = sSC_CHECKCODELIST then begin
      nCMDCode:=nSC_CHECKCODELIST;
      Goto L001;
    end;
    if sCmd = sSC_ISHIGH then begin
      nCMDCode:=nSC_ISHIGH;
      Goto L001;
    end;
    if sCmd = sSC_CHECKONLINEPLAYCOUNT then begin
      nCMDCode:=nSC_CHECKONLINEPLAYCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMAPNAME then begin
      nCMDCode:=nSC_CHECKMAPNAME;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMAPMOBCOUNT then begin
      nCMDCode:=nSC_CHECKMAPMOBCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_FINDMAPPATH then begin
      nCMDCode:=nSC_FINDMAPPATH;
      Goto L001;
    end;
    if sCmd = sSC_CHECKSKILL then begin
      nCMDCode:=nSC_CHECKSKILL;
      Goto L001;
    end;
    if sCmd = sSC_CHECKDIPLOID then begin
      nCMDCode:=nSC_CHECKDIPLOID;
      Goto L001;
    end;
    if sCmd = sSC_CHECKITEMLEVEL then begin
      nCMDCode:=nSC_CHECKITEMLEVEL;
      Goto L001;
    end;
    if sCmd = sSC_CHECKSIDESLAVENAME then begin
      nCMDCode:=nSC_CHECKSIDESLAVENAME;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGLORYPOINT then begin
      nCMDCode:=nSC_CHECKGLORYPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKLISTTEXT then begin
      nCMDCode:=nSC_CHECKLISTTEXT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKSIGNMAP then begin
      nCMDCode:=nSC_CHECKSIGNMAP;
      Goto L001;
    end;
    if sCmd = sSC_CHECKBAGGAGE then begin
      nCMDCode:=nSC_CHECKBAGGAGE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKHEROLOYAL then begin
      nCMDCode:=nSC_CHECKHEROLOYAL;
      Goto L001;
    end;
    if sCmd = sSC_CHECKISSAVEHERO then begin
      nCMDCode:=nSC_CHECKISSAVEHERO;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGUILDFOUNTAIN then begin
      nCMDCode:=nSC_CHECKGUILDFOUNTAIN;
      Goto L001;
    end;
    if sCmd = sSC_ISONMAKEWINE then begin
      nCMDCode:=nSC_ISONMAKEWINE;
      Goto L001;
    end;
    if sCmd = sSC_KILLBYHUM then begin
      nCMDCode:=nSC_KILLBYHUM;
      Goto L001;
    end;
    if sCmd = sSC_KILLBYMON then begin
      nCMDCode:=nSC_KILLBYMON;
      Goto L001;
    end;
    if sCmd = sSC_CHECKDRUNKRATE then begin
      nCMDCode:=nSC_CHECKDRUNKRATE;
      Goto L001;
    end;
    //--------加载检测命令----------------------


    L001:
    if nCMDCode > 0 then begin
      QuestConditionInfo.nCmdCode:=nCMDCode;
      if (sParam1 <> '') and (sParam1[1] = '"') then begin
        ArrestStringEx(sParam1,'"','"',sParam1);
      end;
      if (sParam2 <> '') and (sParam2[1] = '"') then begin
        ArrestStringEx(sParam2,'"','"',sParam2);
      end;
      if (sParam3 <> '') and (sParam3[1] = '"') then begin
        ArrestStringEx(sParam3,'"','"',sParam3);
      end;
      if (sParam4 <> '') and (sParam4[1] = '"') then begin
        ArrestStringEx(sParam4,'"','"',sParam4);
      end;
      if (sParam5 <> '') and (sParam5[1] = '"') then begin
        ArrestStringEx(sParam5,'"','"',sParam5);
      end;
      if (sParam6 <> '') and (sParam6[1] = '"') then begin
        ArrestStringEx(sParam6,'"','"',sParam6);
      end;
      if (sParam7 <> '') and (sParam7[1] = '"') then begin
        ArrestStringEx(sParam7,'"','"',sParam7);
      end;
      QuestConditionInfo.sParam1:=sParam1;
      QuestConditionInfo.sParam2:=sParam2;
      QuestConditionInfo.sParam3:=sParam3;
      QuestConditionInfo.sParam4:=sParam4;
      QuestConditionInfo.sParam5:=sParam5;
      QuestConditionInfo.sParam6:=sParam6;
      QuestConditionInfo.sParam7:=sParam7;
      if IsStringNumber(sParam1) then
        QuestConditionInfo.nParam1:=Str_ToInt(sParam1,0);
      if IsStringNumber(sParam2) then
        QuestConditionInfo.nParam2:=Str_ToInt(sParam2,0);
      if IsStringNumber(sParam3) then
        QuestConditionInfo.nParam3:=Str_ToInt(sParam3,0);
      if IsStringNumber(sParam4) then
        QuestConditionInfo.nParam4:=Str_ToInt(sParam4,0);
      if IsStringNumber(sParam5) then
        QuestConditionInfo.nParam5:=Str_ToInt(sParam5,0);
      if IsStringNumber(sParam6) then
        QuestConditionInfo.nParam6:=Str_ToInt(sParam6,0);
      if IsStringNumber(sParam7) then
        QuestConditionInfo.nParam7:=Str_ToInt(sParam7,0);
      Result:=True;
    end;
      
  end;
  function QuestAction(sText:String;QuestActionInfo:pTQuestActionInfo):Boolean; //0048A640
  var
    sCmd,sTemp,sParam1,sParam2,sParam3,sParam4,sParam5,sParam6,sParam7:String;
    nCMDCode:Integer;
  Label L001;
  begin
    Result:=False;
    sText:=GetValidStrCap(sText,sCmd,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam1,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam2,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam3,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam4,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam5,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam6,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam7,[' ',#9]);
    sTemp:=GetValidStrCap(sCmd,sCmd,['.']);
    while (sTemp<>'') do begin
      if QuestActionInfo.TCmdList=Nil then QuestActionInfo.TCmdList:=TStringList.Create;
      QuestActionInfo.TCmdList.Add(sCmd);
      sTemp:=GetValidStrCap(sTemp,sCmd,['.']);
    end;

    sCmd:=UpperCase(sCmd);
    nCmdCode:=0;
    //StrList.AddString(sCmd,Nil,False);
    if sCmd = sSET then begin
      nCMDCode:=nSET;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
    end;

    if sCmd = sRESET then begin
      nCMDCode:=nRESET;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
    end;
    {if sCmd = sSETOPEN then begin
      nCMDCode:=nSETOPEN;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
    end;}
    {if sCmd = sSETUNIT then begin
      nCMDCode:=nSETUNIT;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
    end;
    if sCmd = sRESETUNIT then begin
      nCMDCode:=nRESETUNIT;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
    end;}
    if sCmd = sTAKE then begin
      nCMDCode:=nTAKE;
      Goto L001;
    end;
    if sCmd = sSC_GIVE then begin
      nCMDCode:=nSC_GIVE;
      Goto L001;
    end;
    if sCmd = sCLOSE then begin
      nCMDCode:=nCLOSE;
      Goto L001;
    end;
    if sCmd = sBREAK then begin
      nCMDCode:=nBREAK;
      Goto L001;
    end;
    if sCmd = sGOTO then begin
      nCMDCode:=nGOTO;
      Goto L001;
    end;
    if sCmd = sADDNAMELIST then begin
      nCMDCode:=nADDNAMELIST;
      Goto L001;
    end;
    if sCmd = sDELNAMELIST then begin
      nCMDCode:=nDELNAMELIST;
      Goto L001;
    end;
    if sCmd = sADDGUILDLIST then begin
      nCMDCode:=nADDGUILDLIST;
      Goto L001;
    end;         
    if sCmd = sDELGUILDLIST then begin
      nCMDCode:=nDELGUILDLIST;
      Goto L001;
    end;
    {if sCmd = sSC_MAPTING then begin
      nCMDCode:=nSC_MAPTING;
      Goto L001;
    end;}
    {if sCmd = sSC_LINEMSG then begin
      nCMDCode:=nSC_LINEMSG;
      Goto L001;
    end;}

    if sCmd = sADDACCOUNTLIST then begin
      nCMDCode:=nADDACCOUNTLIST;
      Goto L001;
    end;
    if sCmd = sDELACCOUNTLIST then begin
      nCMDCode:=nDELACCOUNTLIST;
      Goto L001;
    end;
    if sCmd = sADDIPLIST then begin
      nCMDCode:=nADDIPLIST;
      Goto L001;
    end;
    if sCmd = sDELIPLIST then begin
      nCMDCode:=nDELIPLIST;
      Goto L001;
    end;
    if sCmd = sSENDMSG then begin
      nCMDCode:=nSENDMSG;
      Goto L001;
    end;
    if sCmd = sCHANGEMODE then begin
      nCMDCode:=nCHANGEMODE;
      Goto L001;
    end;
    if sCmd = sPKPOINT then begin
      nCMDCode:=nPKPOINT;
      Goto L001;
    end;
    if sCmd = sCHANGEXP then begin
      nCMDCode:=nCHANGEXP;
      Goto L001;
    end;
    if sCmd = sSC_RECALLMOB then begin
      nCMDCode:=nSC_RECALLMOB;
      Goto L001;
    end;
    if sCmd = sKICK then begin
      nCMDCode:=nKICK;
      Goto L001;
    end;
    if sCmd = sTAKEW then begin
      nCMDCode:=nTAKEW;
      Goto L001;
    end;
    if sCmd = sTIMERECALL then begin
      nCMDCode:=nTIMERECALL;
      Goto L001;
    end;
    if sCmd = sSC_PARAM1 then begin
      nCMDCode:=nSC_PARAM1;
      Goto L001;
    end;
    if sCmd = sSC_PARAM2 then begin
      nCMDCode:=nSC_PARAM2;
      Goto L001;
    end;
    if sCmd = sSC_PARAM3 then begin
      nCMDCode:=nSC_PARAM3;
      Goto L001;
    end;
    if sCmd = sSC_PARAM4 then begin
      nCMDCode:=nSC_PARAM4;
      Goto L001;
    end;
    if sCmd = sSC_EXEACTION then begin
      nCMDCode:=nSC_EXEACTION;
      Goto L001;
    end;

    if sCmd = sMAPMOVE then begin
      nCMDCode:=nMAPMOVE;
      Goto L001;
    end;
    if sCmd = sMAP then begin
      nCMDCode:=nMAP;
      Goto L001;
    end;
    if sCmd = sTAKECHECKITEM then begin
      nCMDCode:=nTAKECHECKITEM;
      Goto L001;
    end;
    if sCmd = sMONGEN then begin
      nCMDCode:=nMONGEN;
      Goto L001;
    end;
    if sCmd = sMONCLEAR then begin
      nCMDCode:=nMONCLEAR;
      Goto L001;
    end;
    if sCmd = sMOV then begin
      nCMDCode:=nMOV;
      Goto L001;
    end;
    if sCmd = sINC then begin
      nCMDCode:=nINC;
      Goto L001;
    end;
    if sCmd = sDEC then begin
      nCMDCode:=nDEC;
      Goto L001;
    end;
    if sCmd = sSUM then begin
      nCMDCode:=nSUM;
      Goto L001;
    end;
    if sCmd = sBREAKTIMERECALL then begin
      nCMDCode:=nBREAKTIMERECALL;
      Goto L001;
    end;

    if sCmd = sMOVR then begin
      nCMDCode:=nMOVR;
      Goto L001;
    end;
    if sCmd = sEXCHANGEMAP then begin
      nCMDCode:=nEXCHANGEMAP;
      Goto L001;
    end;
    if sCmd = sRECALLMAP then begin
      nCMDCode:=nRECALLMAP;
      Goto L001;
    end;
    if sCmd = sADDBATCH then begin
      nCMDCode:=nADDBATCH;
      Goto L001;
    end;
    if sCmd = sBATCHDELAY then begin
      nCMDCode:=nBATCHDELAY;
      Goto L001;
    end;
    if sCmd = sBATCHMOVE then begin
      nCMDCode:=nBATCHMOVE;
      Goto L001;
    end;
    if sCmd = sPLAYDICE then begin
      nCMDCode:=nPLAYDICE;
      Goto L001;
    end;
    if sCmd = sGOQUEST then begin
      nCMDCode:=nGOQUEST;
      Goto L001;
    end;
    if sCmd = sENDQUEST then begin
      nCMDCode:=nENDQUEST;
      Goto L001;
    end;
    {if sCmd = sSC_HAIRCOLOR then begin
      nCMDCode:=nSC_HAIRCOLOR;
      Goto L001;
    end;
    if sCmd = sSC_WEARCOLOR then begin
      nCMDCode:=nSC_WEARCOLOR;
      Goto L001;
    end;}
    if sCmd = sSC_HAIRSTYLE then begin
      nCMDCode:=nSC_HAIRSTYLE;
      Goto L001;
    end;
    {if sCmd = sSC_MONRECALL then begin
      nCMDCode:=nSC_MONRECALL;
      Goto L001;
    end;
    if sCmd = sSC_HORSECALL then begin
      nCMDCode:=nSC_HORSECALL;
      Goto L001;
    end;
    if sCmd = sSC_HAIRRNDCOL then begin
      nCMDCode:=nSC_HAIRRNDCOL;
      Goto L001;
    end;
    if sCmd = sSC_KILLHORSE then begin
      nCMDCode:=nSC_KILLHORSE;
      Goto L001;
    end;
    if sCmd = sSC_RANDSETDAILYQUEST then begin
      nCMDCode:=nSC_RANDSETDAILYQUEST;
      Goto L001;
    end;}


    if sCmd = sSC_CHANGELEVEL then begin
      nCMDCode:=nSC_CHANGELEVEL;
      Goto L001;
    end;
    if sCmd = sSC_MARRY then begin
      nCMDCode:=nSC_MARRY;
      Goto L001;
    end;
    if sCmd = sSC_UNMARRY then begin
      nCMDCode:=nSC_UNMARRY;
      Goto L001;
    end;
    if sCmd = sSC_GETMARRY then begin
      nCMDCode:=nSC_GETMARRY;
      Goto L001;
    end;
    if sCmd = sSC_GETMASTER then begin
      nCMDCode:=nSC_GETMASTER;
      Goto L001;
    end;
    if sCmd = sSC_CLEARSKILL then begin
      nCMDCode:=nSC_CLEARSKILL;
      Goto L001;
    end;
    if sCmd = sSC_DELNOJOBSKILL then begin
      nCMDCode:=nSC_DELNOJOBSKILL;
      Goto L001;
    end;
    if sCmd = sSC_DELSKILL then begin
      nCMDCode:=nSC_DELSKILL;
      Goto L001;
    end;
    if sCmd = sSC_ADDSKILL then begin
      nCMDCode:=nSC_ADDSKILL;
      Goto L001;
    end;
    if sCmd = sSC_SKILLLEVEL then begin
      nCMDCode:=nSC_SKILLLEVEL;
      Goto L001;
    end;
    if sCmd = sSc_CHANGETRANPOINT then begin
      nCMDCode:=nSC_CHANGETRANPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEPKPOINT then begin
      nCMDCode:=nSC_CHANGEPKPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEEXP then begin
      nCMDCode:=nSC_CHANGEEXP;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEJOB then begin
      nCMDCode:=nSC_CHANGEJOB;
      Goto L001;
    end;
    if sCmd = sSC_MISSION then begin
      nCMDCode:=nSC_MISSION;
      Goto L001;
    end;
    if sCmd = sSC_MOBPLACE then begin
      nCMDCode:=nSC_MOBPLACE;
      Goto L001;
    end;
    if sCmd = sSC_SETMEMBERTYPE then begin
      nCMDCode:=nSC_SETMEMBERTYPE;
      Goto L001;
    end;
    if sCmd = sSC_SETMEMBERLEVEL then begin
      nCMDCode:=nSC_SETMEMBERLEVEL;
      Goto L001;
    end;
    if sCmd = sSC_GAMEGOLD then begin
      nCMDCode:=nSC_GAMEGOLD;
      Goto L001;
    end;
    if sCmd = sSC_GAMEPOINT then begin
      nCMDCode:=nSC_GAMEPOINT;
      Goto L001;
    end;
    if sCmd = sSC_PKZONE then begin
      nCMDCode:=nSC_PKZONE;
      Goto L001;
    end;
    if sCmd = sSC_RESTBONUSPOINT then begin
      nCMDCode:=nSC_RESTBONUSPOINT;
      Goto L001;
    end;
    if sCmd = sSC_TAKECASTLEGOLD then begin
      nCMDCode:=nSC_TAKECASTLEGOLD;
      Goto L001;
    end;
    if sCmd = sSC_HUMANHP then begin
      nCMDCode:=nSC_HUMANHP;
      Goto L001;
    end;
    if sCmd = sSC_HUMANMP then begin
      nCMDCode:=nSC_HUMANMP;
      Goto L001;
    end;
    if sCmd = sSC_BUILDPOINT then begin
      nCMDCode:=nSC_BUILDPOINT;
      Goto L001;
    end;
    if sCmd = sSC_AURAEPOINT then begin
      nCMDCode:=nSC_AURAEPOINT;
      Goto L001;
    end;
    if sCmd = sSC_STABILITYPOINT then begin
      nCMDCode:=nSC_STABILITYPOINT;
      Goto L001;
    end;
    if sCmd = sSC_FLOURISHPOINT then begin
      nCMDCode:=nSC_FLOURISHPOINT;
      Goto L001;
    end;
    if sCmd = sSC_OPENMAGICBOX then begin
      nCMDCode:=nSC_OPENMAGICBOX;
      Goto L001;
    end;
    if sCmd = sSC_SETRANKLEVELNAME then begin
      nCMDCode:=nSC_SETRANKLEVELNAME;
      Goto L001;
    end;
    if sCmd = sSC_GMEXECUTE then begin
      nCMDCode:=nSC_GMEXECUTE;
      Goto L001;
    end;
    if sCmd = sSC_GUILDCHIEFITEMCOUNT then begin
      nCMDCode:=nSC_GUILDCHIEFITEMCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_ADDNAMEDATELIST then begin
      nCMDCode:=nSC_ADDNAMEDATELIST;
      Goto L001;
    end;
    if sCmd = sSC_DELNAMEDATELIST then begin
      nCMDCode:=nSC_DELNAMEDATELIST;
      Goto L001;
    end;
    if sCmd = sSC_MOBFIREBURN then begin
      nCMDCode:=nSC_MOBFIREBURN;
      Goto L001;
    end;
    if sCmd = sSC_MESSAGEBOX then begin
      nCMDCode:=nSC_MESSAGEBOX;
      Goto L001;
    end;
    if sCmd = sSC_SETSCRIPTFLAG then begin
      nCMDCode:=nSC_SETSCRIPTFLAG;
      Goto L001;
    end;
    if sCmd = sSC_SETAUTOGETEXP then begin
      nCMDCode:=nSC_SETAUTOGETEXP;
      Goto L001;
    end;
    if sCmd = sSC_VAR then begin
      nCMDCode:=nSC_VAR;
      Goto L001;
    end;
    if sCmd = sSC_LOADVAR then begin
      nCMDCode:=nSC_LOADVAR;
      Goto L001;
    end;
    if sCmd = sSC_SAVEVAR then begin
      nCMDCode:=nSC_SAVEVAR;
      Goto L001;
    end;
    if sCmd = sSC_CALCVAR then begin
      nCMDCode:=nSC_CALCVAR;
      Goto L001;
    end;
    if sCmd = sSC_AUTOADDGAMEGOLD then begin
      nCMDCode:=nSC_AUTOADDGAMEGOLD;
      Goto L001;
    end;
    if sCmd = sSC_AUTOSUBGAMEGOLD then begin
      nCMDCode:=nSC_AUTOSUBGAMEGOLD;
      Goto L001;
    end;

    {if sCmd = sSC_RECALLGROUPMEMBERS then begin
      nCMDCode:=nSC_RECALLGROUPMEMBERS;
      Goto L001;
    end;}
    if sCmd = sSC_CLEARNAMELIST then begin
      nCMDCode:=nSC_CLEARNAMELIST;
      Goto L001;
    end;
    if sCmd = sSC_CHANGENAMECOLOR then begin
      nCMDCode:=nSC_CHANGENAMECOLOR;
      Goto L001;
    end;
    if sCmd = sSC_CLEARPASSWORD then begin
      nCMDCode:=nSC_CLEARPASSWORD;
      Goto L001;
    end;
    if sCmd = sSC_RENEWLEVEL then begin
      nCMDCode:=nSC_RENEWLEVEL;
      Goto L001;
    end;
    if sCmd = sSC_KILLMONEXPRATE then begin
      nCMDCode:=nSC_KILLMONEXPRATE;
      Goto L001;
    end;
    if sCmd = sSC_POWERRATE then begin
      nCMDCode:=nSC_POWERRATE;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEMODE then begin
      nCMDCode:=nSC_CHANGEMODE;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEPERMISSION then begin
      nCMDCode:=nSC_CHANGEPERMISSION;
      Goto L001;
    end;
    if sCmd = sSC_KILL then begin
      nCMDCode:=nSC_KILL;
      Goto L001;
    end;
    if sCmd = sSC_KICK then begin
      nCMDCode:=nSC_KICK;
      Goto L001;
    end;
    if sCmd = sSC_BONUSPOINT then begin
      nCMDCode:=nSC_BONUSPOINT;
      Goto L001;
    end;
    if sCmd = sSC_RESTRENEWLEVEL then begin
      nCMDCode:=nSC_RESTRENEWLEVEL;
      Goto L001;
    end;
    if sCmd = sSC_DELMARRY then begin
      nCMDCode:=nSC_DELMARRY;
      Goto L001;
    end;
    if sCmd = sSC_DELMASTER then begin
      nCMDCode:=nSC_DELMASTER;
      Goto L001;
    end;
    if sCmd = sSC_MASTER then begin
      nCMDCode:=nSC_MASTER;
      Goto L001;
    end;
    if sCmd = sSC_UNMASTER then begin
      nCMDCode:=nSC_UNMASTER;
      Goto L001;
    end;
    if sCmd = sSC_CREDITPOINT then begin
      nCMDCode:=nSC_CREDITPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CLEARNEEDITEMS then begin
      nCMDCode:=nSC_CLEARNEEDITEMS;
      Goto L001;
    end;
    if sCmd = sSC_CLEARMAKEITEMS then begin
      nCMDCode:=nSC_CLEARMAEKITEMS;
      Goto L001;
    end;

    if sCmd = sSC_SETSENDMSGFLAG then begin
      nCMDCode:=nSC_SETSENDMSGFLAG;
      Goto L001;
    end;
    if sCmd = sSC_UPGRADEITEMS then begin
      nCMDCode:=nSC_UPGRADEITEMS;
      Goto L001;
    end;
    if sCmd = sSC_UPGRADEITEMSEX then begin
      nCMDCode:=nSC_UPGRADEITEMSEX;
      Goto L001;
    end;
    if sCmd = sSC_MONGENEX then begin
      nCMDCode:=nSC_MONGENEX;
      Goto L001;
    end;
    if sCmd = sSC_CLEARMAPMON then begin
      nCMDCode:=nSC_CLEARMAPMON;
      Goto L001;
    end;

    if sCmd = sSC_SETMAPMODE then begin
      nCMDCode:=nSC_SETMAPMODE;
      Goto L001;
    end;

    if sCmd = sSC_KILLSLAVE then begin
      nCMDCode:=nSC_KILLSLAVE;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEGENDER then begin
      nCMDCode:=nSC_CHANGEGENDER;
      Goto L001;
    end;

    {if sCmd = sSC_MAPTING then begin
      nCMDCode:=nSC_MAPTING;
      Goto L001;
    end;}

    if sCmd = sSC_GUILDRECALL then begin
      nCMDCode:=nSC_GUILDRECALL;
      Goto L001;
    end;
    if sCmd = sSC_GROUPMOVE then begin
      nCMDCode:=nSC_GROUPMOVE;
      Goto L001;
    end;
    if sCmd = sSC_GROUPADDLIST then begin
      nCMDCode:=nSC_GROUPADDLIST;
      Goto L001;
    end;
    if sCmd = sSC_CLEARLIST then begin
      nCMDCode:=nSC_CLEARLIST;
      Goto L001;
    end;
    if sCmd = sSC_GROUPMAPMOVE then begin
      nCMDCode:=nSC_GROUPMAPMOVE;
      Goto L001;
    end;
    if sCmd = sSC_SAVESLAVES then begin
      nCMDCode:=nSC_SAVESLAVES;
      Goto L001;
    end;
    if sCmd = sSC_CREATEHERO then begin
      nCMDCode:=nSC_CREATEHERO;
      Goto L001;
    end;
    if sCmd = sSC_DELAYCALL then begin
      nCMDCode:=nSC_DELAYCALL;
      Goto L001;
    end;
    if sCmd = sSC_DELAYGOTO then begin
      nCMDCode:=nSC_DELAYCALL;
      Goto L001;
    end;
    if sCmd = sSC_CLEARDELAYGOTO then begin
      nCMDCode:=nSC_CLEARDELAYGOTO;
      Goto L001;
    end;
    if sCmd = sSC_GAMEDIAMOND then begin
      nCMDCode:=nSC_GAMEDIAMOND;
      Goto L001;
    end;
    if sCmd = sSC_GAMEGIRD then begin
      nCMDCode:=nSC_GAMEGIRD;
      Goto L001;
    end;
    if sCmd = sSC_GUILDMAPMOVE then begin
      nCMDCode:=nSC_GUILDMAPMOVE;
      Goto L001;
    end;
    if sCmd = sSC_GUILDMOVE then begin
      nCMDCode:=nSC_GUILDMOVE;
      Goto L001;
    end;
    if sCmd = sSC_DELETEHERO then begin
      nCMDCode:=nSC_DELETEHERO;
      Goto L001;
    end;
    if sCmd = sSC_OPENUSERMARKET then begin
      nCMDCode:=nSC_OPENUSERMARKET;
      Goto L001;
    end;
    if sCmd = sSC_OFFLINEPLAY then begin
      nCMDCode:=nSC_OFFLINEPLAY;
      Goto L001;
    end;
    if sCmd = sSC_GOHOME then begin
      nCMDCode:=nSC_GOHOME;
      Goto L001;
    end;
    if sCmd = sSC_SETITEMSTATE then begin
      nCMDCode:=nSC_SETITEMSTATE;
      Goto L001;
    end;
    if sCmd = sSC_GIVESTATEITEM then begin
      nCMDCode:=nSC_GIVESTATEITEM;
      Goto L001;
    end;
    if sCmd = sSC_MUL then begin
      nCMDCode:=nSC_MUL;
      Goto L001;
    end;
    if sCmd = sSC_PERCENT then begin
      nCMDCode:=nSC_PERCENT;
      Goto L001;
    end;
    if sCmd = sSC_DVI then begin
      nCMDCode:=nSC_DVI;
      Goto L001;
    end;
    if sCmd = sSC_DIV then begin
      nCMDCode:=nSC_DVI;
      Goto L001;
    end;
    if sCmd = sSC_TAKEONITEM then begin
      nCMDCode:=nSC_TAKEONITEM;
      Goto L001;
    end;
    if sCmd = sSC_TAKEOFFITEM then begin
      nCMDCode:=nSC_TAKEOFFITEM;
      Goto L001;
    end;
    if sCmd = sSC_HCALL then begin
      nCMDCode:=nSC_HCALL;
      Goto L001;
    end;
    if sCmd = sSC_ADDTEXTLIST then begin
      nCMDCode:=nSC_ADDTEXTLIST;
      Goto L001;
    end;
    if sCmd = sSC_DELTEXTLIST then begin
      nCMDCode:=nSC_DELTEXTLIST;
      Goto L001;
    end;
    if sCmd = sSC_USEBONUSPOINT then begin
      nCMDCode:=nSC_USEBONUSPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEHUMABILITY then begin
      nCMDCode:=nSC_CHANGEHUMABILITY;
      Goto L001;
    end;
    if sCmd = sSC_THROWITEM then begin
      nCMDCode:=nSC_THROWITEM;
      Goto L001;
    end;
    if sCmd = sSC_DROPITEMMAP then begin
      nCMDCode:=nSC_THROWITEM;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEHEROLEVEL then begin
      nCMDCode:=nSC_CHANGEHEROLEVEL;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEHEROJOB then begin
      nCMDCode:=nSC_CHANGEHEROJOB;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEHEROPKPOINT then begin
      nCMDCode:=nSC_CHANGEHEROPKPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEHEROEXP then begin
      nCMDCode:=nSC_CHANGEHEROEXP;
      Goto L001;
    end;
    if sCmd = sSC_CLEARHEROSKILL then begin
      nCMDCode:=nSC_CLEARHEROSKILL;
      Goto L001;
    end;
    if sCmd = sSC_SETONTIMER then begin
      nCMDCode:=nSC_SETONTIMER;
      Goto L001;
    end;
     if sCmd = sSC_OFFLINE then begin
      nCMDCode:=nSC_OFFLINEPLAY;
      Goto L001;
    end;
    if sCmd = sSC_ADDUSERDATE then begin
      nCMDCode:=nSC_ADDUSERDATE;
      Goto L001;
    end;
    if sCmd = sSC_DELUSERDATE then begin
      nCMDCode:=nSC_DELUSERDATE;
      Goto L001;
    end;
    if sCmd = sSC_SETRANDOMNO then begin
      nCMDCode:=nSC_SETRANDOMNO;
      Goto L001;
    end;
    if sCmd = sSC_SETOFFTIMER then begin
      nCMDCode:=nSC_SETOFFTIMER;
      Goto L001;
    end;
    if sCmd = sSC_CLEARCODELIST then begin
      nCMDCode:=nSC_CLEARCODELIST;
      Goto L001;
    end;
    if sCmd = sSC_GETRANDOMNAME then begin
      nCMDCode:=nSC_GETRANDOMNAME;
      Goto L001;
    end;
    if sCmd = sSC_SETOFFLINEPLAY then begin
      nCMDCode:=nSC_SETOFFLINEPLAY;
      Goto L001;
    end;
    if sCmd = sSC_THROUGHHUM then begin
      nCMDCode:=nSC_THROUGHHUM;
      Goto L001;
    end;
    if sCmd = sSC_KICKOFFLINE then begin
      nCMDCode:=nSC_KICKOFFLINE;
      Goto L001;
    end;
    if sCmd = sSC_GUILDNOTICEMSG then begin
      nCMDCode:=nSC_GUILDNOTICEMSG;
      Goto L001;
    end;
    if sCmd = sSC_REPAIRALL then begin
      nCMDCode:=nSC_REPAIRALL;
      Goto L001;
    end;
    if sCmd = sSC_STARTTAKEGOLD then begin
      nCMDCode:=nSC_STARTTAKEGOLD;
      Goto L001;
    end;
    if sCmd = sSC_RECALLMOBEX then begin
      nCMDCode:=nSC_RECALLMOBEX;
      Goto L001;
    end;
    if sCmd = sSC_MOVEMOBTO then begin
      nCMDCode:=nSC_MOVEMOBTO;
      Goto L001;
    end;
    if sCmd = sSC_CLEARITEMMAP then begin
      nCMDCode:=nSC_CLEARITEMMAP;
      Goto L001;
    end;
    if sCmd = sSC_SETICON then begin
      nCMDCode:=nSC_SETICON;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEDIPLOID then begin
      nCMDCode:=nSC_CHANGEDIPLOID;
      Goto L001;
    end;
    if sCmd = sSC_SETATTRIBUTE then begin
      nCMDCode:=nSC_SETATTRIBUTE;
      Goto L001;
    end;
    if sCmd = sSC_QUERYBAGITEMS then begin
      nCMDCode:=nSC_QUERYBAGITEMS;
      Goto L001;
    end;
    if sCmd = sSC_TAGMAPMOVE then begin
      nCMDCode:=nSC_TAGMAPMOVE;
      Goto L001;
    end;
    if sCmd = sSC_OPENYBDEAL then begin
      nCMDCode:=nSC_OPENYBDEAL;
      Goto L001;
    end;
    if sCmd = sSC_OPENBOOKS then begin
      nCMDCode:=nSC_OPENBOOKS;
      Goto L001;
    end;
    if sCmd = sSC_OPENBOXS then begin
      nCMDCode:=nSC_OPENBOXS;
      Goto L001;
    end;
    if sCmd = sSC_KICKALLPLAY then begin
      nCMDCode:=nSC_KICKALLPLAY;
      Goto L001;
    end;
    if sCmd = sSC_ADDGUILDMEMBER then begin
      nCMDCode:=nSC_ADDGUILDMEMBER;
      Goto L001;
    end;
    if sCmd = sSC_DELGUILDMEMBER then begin
      nCMDCode:=nSC_DELGUILDMEMBER;
      Goto L001;
    end;
    if sCmd = sSC_GLORYCHANGE then begin
      nCMDCode:=nSC_GLORYCHANGE;
      Goto L001;
    end;
    if sCmd = sSC_ADDATTACKSABUKALL then begin
      nCMDCode:=nSC_ADDATTACKSABUKALL;
      Goto L001;
    end;
    if sCmd = sSC_QUERYYBSELL then begin
      nCMDCode:=nSC_QUERYYBSELL;
      Goto L001;
    end;
    if sCmd = sSC_QUERYYBDEAL then begin
      nCMDCode:=nSC_QUERYYBDEAL;
      Goto L001;
    end;
    if sCmd = sSC_TAGMAPINFO then begin
      nCMDCode:=nSC_TAGMAPINFO;
      Goto L001;
    end;
    if sCmd = sSC_RECALLPLAYER then begin
      nCMDCode:=nSC_RECALLPLAYER;
      Goto L001;
    end;
    if sCmd = sSC_SENDTOPMSG then begin
      nCMDCode:=nSC_SENDTOPMSG;
      Goto L001;
    end;
    if sCmd = sSC_SENDCENTERMSG then begin
      nCMDCode:=nSC_SENDCENTERMSG;
      Goto L001;
    end;
    if sCmd = sSC_SENDEDITTOPMSG then begin
      nCMDCode:=nSC_SENDEDITTOPMSG;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEHEROLOYAL then begin
      nCMDCode:=nSC_CHANGEHEROLOYAL;
      Goto L001;
    end;
    if sCmd = sSC_ADDRANDOMMAPGATE then begin
      nCMDCode:=nSC_ADDRANDOMMAPGATE;
      Goto L001;
    end;
    if sCmd = sSC_DELRANDOMMAPGATE then begin
      nCMDCode:=nSC_DELRANDOMMAPGATE;
      Goto L001;
    end;
    if sCmd = sSC_GETRANDOMMAPGATE then begin
      nCMDCode:=nSC_GETRANDOMMAPGATE;
      Goto L001;
    end;
    if sCmd = sSC_SETITEMSLIGHT then begin
      nCMDCode:=nSC_SETITEMSLIGHT;
      Goto L001;
    end;
    if sCmd = sSC_SETOFFLINEFUNC then begin
      nCMDCode:=nSC_SETOFFLINEFUNC;
      Goto L001;
    end;
    if sCmd = sSC_OPENPLAYDRINK then begin
      nCMDCode:=nSC_OPENPLAYDRINK;
      Goto L001;
    end;
    if sCmd = sSC_PLAYDRINKMSG then begin
      nCMDCode:=nSC_PLAYDRINKMSG;
      Goto L001;
    end;
    if sCmd = sSC_CLOSEDRINK then begin
      nCMDCode:=nSC_CLOSEDRINK;
      Goto L001;
    end;
    if sCmd = sSC_SAVEHERO then begin
      nCMDCode:=nSC_SAVEHERO;
      Goto L001;
    end;
    if sCmd = sSC_GETHERO then begin
      nCMDCode:=nSC_GETHERO;
      Goto L001;
    end;
    if sCmd = sSC_Gotonow then begin
      nCMDCode:=nSC_Gotonow;
      Goto L001;
    end;
    if sCmd = sSC_ChangeSKILL then begin
      nCMDCode:=nSC_ChangeSKILL;
      Goto L001;
    end;
    if sCmd = sSC_GETGOODMAKEWINE then begin
      nCMDCode:=nSC_GETGOODMAKEWINE;
      Goto L001;
    end;
    if sCmd = sSC_MAKEWINENPCMOVE then begin
      nCMDCode:=nSC_MAKEWINENPCMOVE;
      Goto L001;
    end;
    if sCmd = sSC_FOUNTAIN then begin
      nCMDCode:=nSC_FOUNTAIN;
      Goto L001;
    end;
    if sCmd = sSC_SETGUILDFOUNTAIN then begin
      nCMDCode:=nSC_SETGUILDFOUNTAIN;
      Goto L001;
    end;
    if sCmd = sSC_GIVEGUILDFOUNTAIN then begin
      nCMDCode:=nSC_GIVEGUILDFOUNTAIN;
      Goto L001;
    end;
    if sCmd = sSC_DECMAKEWINETIME then begin
      nCMDCode:=nSC_DECMAKEWINETIME;
      Goto L001;
    end;
     if sCmd = sSC_OPENMAKEWINE then begin
      nCMDCode:=nSC_OPENMAKEWINE;
      Goto L001;
    end;
     if sCmd = sSC_WebBrowser then begin
      nCMDCode:=nSC_WebBrowser;
      Goto L001;
    end;
    if sCmd = sSC_GIVECASTLEFOUNTAIN then begin
      nCMDCode:=nSC_GIVECASTLEFOUNTAIN;
      Goto L001;
    end;
    if sCmd = sSC_QUERYREFINEITEM then begin
      nCMDCode:=nSC_QUERYREFINEITEM;
      Goto L001;
    end;
    if sCmd = sSc_CHALLENGMAPMOVE then begin
      nCMDCode:=nSC_CHALLENGMAPMOVE;
      Goto L001;
    end;
    if sCmd = sSc_GETCHALLENGEBAKITEM then begin
      nCMDCode:=nSC_GETCHALLENGEBAKITEM;
      Goto L001;
    end;
///////////加载命令////////////
    L001:
    if nCMDCode > 0 then begin
      QuestActionInfo.nCmdCode:=nCMDCode;
      if (sParam1 <> '') and (sParam1[1] = '"') then begin
        ArrestStringEx(sParam1,'"','"',sParam1);
      end;
      if (sParam2 <> '') and (sParam2[1] = '"') then begin
        ArrestStringEx(sParam2,'"','"',sParam2);
      end;
      if (sParam3 <> '') and (sParam3[1] = '"') then begin
        ArrestStringEx(sParam3,'"','"',sParam3);
      end;
      if (sParam4 <> '') and (sParam4[1] = '"') then begin
        ArrestStringEx(sParam4,'"','"',sParam4);
      end;
      if (sParam5 <> '') and (sParam5[1] = '"') then begin
        ArrestStringEx(sParam5,'"','"',sParam5);
      end;
      if (sParam6 <> '') and (sParam6[1] = '"') then begin
        ArrestStringEx(sParam6,'"','"',sParam6);
      end;
      QuestActionInfo.sParam1:=sParam1;
      QuestActionInfo.sParam2:=sParam2;
      QuestActionInfo.sParam3:=sParam3;
      QuestActionInfo.sParam4:=sParam4;
      QuestActionInfo.sParam5:=sParam5;
      QuestActionInfo.sParam6:=sParam6;
      QuestActionInfo.sParam7:=sParam7;
      if IsStringNumber(sParam1) then
        QuestActionInfo.nParam1:=Str_ToInt(sParam1,0);
      if IsStringNumber(sParam2) then
        QuestActionInfo.nParam2:=Str_ToInt(sParam2,1);
      if IsStringNumber(sParam3) then
        QuestActionInfo.nParam3:=Str_ToInt(sParam3,1);
      if IsStringNumber(sParam4) then
        QuestActionInfo.nParam4:=Str_ToInt(sParam4,0);
      if IsStringNumber(sParam5) then
        QuestActionInfo.nParam5:=Str_ToInt(sParam5,0);
      if IsStringNumber(sParam6) then
        QuestActionInfo.nParam6:=Str_ToInt(sParam6,0);
      if IsStringNumber(sParam7) then
        QuestActionInfo.nParam7:=Str_ToInt(sParam7,0);
      Result:=True;
    end;
  end;
begin   //0048B684
  Result:= -1;
  n6C:=0;
  n70:=0;
  sScritpFileName:=g_Config.sEnvirDir + sPatch + sScritpName + '.txt';
  if FileExists(sScritpFileName) then begin
    LoadList:=TStringList.Create;
    try
      LoadList.LoadFromFile(sScritpFileName);
      DeCodeList(LoadList);
      DeCodeStringList(LoadList);
    except
      LoadList.Free;
      exit;
    end;

    LoadScriptcall(LoadList);
    //i:=0;
    //while (True) do  begin
      //i:=LoadScriptcall(LoadList,I);
      //if I < 0 then break;
    //end;    // while

    DefineList:=TList.Create;
    //LoadList.SaveToFile('.\check.txt');
    s54:=LoadDefineInfo(LoadList,DefineList);
    New(DefineInfo);
    DefineInfo.sName:='@HOME';
    if s54 = '' then s54:='@main';
    DefineInfo.sText:=s54;
    DefineList.Add(DefineInfo);
    // 常量处理
    bo8D:=False;
    for I := 0 to LoadList.Count - 1 do begin
      s34:=Trim(LoadList.Strings[i]);
      if (s34 <> '') then begin
        if (s34[1] = '[') then begin
          bo8D:=False;
        end else begin //0048B83F
          if (s34[1] = '#') and
             (CompareLStr(s34,'#IF',Length('#IF')) or
              CompareLStr(s34,'#ACT',Length('#ACT')) or
              CompareLStr(s34,'#ELSEACT',Length('#ELSEACT'))) then begin
            bo8D:=True;
          end else begin //0048B895
            if bo8D then begin
              // 将Define 好的常量换成指定值
              for n20 := 0 to DefineList.Count - 1 do begin
                DefineInfo:=DefineList.Items[n20];
                n1C:=0;
                while (True) do  begin
                  n24:=Pos(DefineInfo.sName,UpperCase(s34));
                  if n24 <= 0 then break;
                  s58:=Copy(s34,1,n24 - 1);
                  s5C:=Copy(s34,length(DefineInfo.sName) + n24,256);
                  s34:=s58 + DefineInfo.sText + s5C;
                  LoadList.Strings[i]:=s34;
                  Inc(n1C);
                  if n1C >= 10 then break;
                end;
              end; // 将Define 好的常量换成指定值

            end; //0048B97D
          end;
        end; //0048B97D
      end; //0048B97D if (s34 <> '') then begin
    end; //for I := 0 to LoadList.Count - 1 do begin
    // 常量处理
    //释放常量定义内容
    //0048B98C
    for I := 0 to DefineList.Count - 1 do begin
      Dispose(pTDefineInfo(DefineList.Items[i]));
    end;    // for I := 0 to List64.Count - 1 do begin
    DefineList.Free;
    //释放常量定义内容
    //LoadList.SaveToFile('.\check.txt');

    Script:=nil;
    SayingRecord:=nil;
    nQuestIdx:=0;
    for I := 0 to LoadList.Count - 1 do begin //0048B9FC
      s34:=Trim(LoadList.Strings[i]);
      if (s34 = '') or (s34[1] = ';') or (s34[1] = '/') then Continue;
      if (n6C = 0) and (boFlag) then begin
        //物品价格倍率
        if s34[1] = '%' then begin  //0048BA57
          s34:=Copy(s34,2,Length(s34) - 1);
          nPriceRate:=Str_ToInt(s34,-1);
          if nPriceRate >= 55 then begin
            TMerchant(NPC).m_nPriceRate:=nPriceRate;
          end;
          Continue;
        end;
        //物品交易类型
        if s34[1] = '+' then begin
          s34:=Copy(s34,2,Length(s34) - 1);
          nItemType:=Str_ToInt(s34,-1);
          if nItemType >= 0 then begin
            TMerchant(NPC).m_ItemTypeList.Add(Pointer(nItemType));
          end;
          Continue;
        end;
        //增加处理NPC可执行命令设置
        if s34[1] = '(' then begin
          ArrestStringEx(s34,'(',')',s34);
          if s34 <> '' then begin
            while (s34 <> '') do  begin
              s34:=GetValidStr3(s34,s30,[' ',',',#9]);
              if CompareText(s30,sBUY) = 0 then begin
                TMerchant(NPC).m_boBuy:=True;
                Continue;
              end else if CompareText(s30,sSELL) = 0 then begin
                TMerchant(NPC).m_boSell:=True;
                Continue;
              end else if CompareText(s30,sSELLOFF) = 0 then begin
                TMerchant(NPC).m_boSellOff:=True;
                Continue;
              end else if CompareText(s30,sMAKEDURG) = 0 then begin
                TMerchant(NPC).m_boMakeDrug:=True;
                Continue;
              end else if CompareText(s30,sPRICES) = 0 then begin
                TMerchant(NPC).m_boPrices:=True;
                Continue;
              end else if CompareText(s30,sSTORAGE) = 0 then begin
                TMerchant(NPC).m_boStorage:=True;
                Continue;
              end else if CompareText(s30,sPLAYDRINK) = 0 then begin
                TMerchant(NPC).m_boPlayDrink:=True;
                Continue;
              end else if CompareText(s30,sGETBACK) = 0 then begin
                TMerchant(NPC).m_boGetback:=True;
                Continue;
              end else if CompareText(s30,sUPGRADENOW) = 0 then begin
                TMerchant(NPC).m_boUpgradenow:=True;
                Continue;
              end else if CompareText(s30,sGETBACKUPGNOW) = 0 then begin
                TMerchant(NPC).m_boGetBackupgnow:=True;
                Continue;
              end else if CompareText(s30,sREPAIR) = 0 then begin
                TMerchant(NPC).m_boRepair:=True;
                Continue;
              end else if CompareText(s30,sSUPERREPAIR) = 0 then begin
                TMerchant(NPC).m_boS_repair:=True;
                Continue;
              end else if CompareText(s30,sSL_SENDMSG) = 0 then begin
                TMerchant(NPC).m_boSendmsg:=True;
                Continue;
              end else if CompareText(s30,sUSEITEMNAME) = 0 then begin
                TMerchant(NPC).m_boUseItemName:=True;
                Continue;
              end else if CompareText(s30,sSL_BUHERO) = 0 then begin
                TMerchant(NPC).m_boHero:=True;
                Continue;
              {end else if CompareText(s30,sSL_DIERUN) = 0 then begin
                TMerchant(NPC).m_boDieRun:=True;
                Continue; }
              end else if CompareText(s30,sSL_DEALGOLD) = 0 then begin
                TMerchant(NPC).m_boDealGold:=True;
                Continue;
              end else if CompareText(s30,sSL_BATCHBUY) = 0 then begin
                TMerchant(NPC).m_boBatchBuy:=True;
                Continue;
              end else if CompareText(s30,sSL_INPUTSTRING) = 0 then begin
                TMerchant(NPC).m_boInPutString:=True;
                Continue;
              end else if CompareText(s30,sSL_INPUTINTEGER) = 0 then begin
                TMerchant(NPC).m_boInPutInteger:=True;
                Continue;
              end;

            end;    // while
          end;
          Continue;
        end;
        //增加处理NPC可执行命令设置
      end; //0048BAF0

      if s34[1] = '{' then begin
        if CompareLStr(s34,'{Quest',length('{Quest')) then begin
          s38:=GetValidStr3(s34,s3C,[' ','}',#9]);
          GetValidStr3(s38,s3C,[' ','}',#9]);
          n70:=Str_ToInt(s3C,0);
          Script:=MakeNewScript();
          Script.nQuest:=n70;
          Inc(n70);
        end; //0048BBA4  
        if CompareLStr(s34,'{~Quest',length('{~Quest')) then Continue;
      end; //0048BBBE
      
      if (n6C = 1)and (Script <> nil) and (s34[1] = '#') then begin
        s38:=GetValidStr3(s34,s3C,['=',' ',#9]);
        Script.boQuest:=True;
        if CompareLStr(s34,'#IF',length('#IF')) then begin
          ArrestStringEx(s34,'[',']',s40);
          Script.QuestInfo[nQuestIdx].wFlag:=Str_ToInt(s40,0);
          GetValidStr3(s38,s44,['=',' ',#9]);
          n24:=Str_ToInt(s44,0);
          if n24 <> 0 then n24:=1;
          Script.QuestInfo[nQuestIdx].btValue:=n24;
        end; //0048BCBD

        
        if CompareLStr(s34,'#RAND',length('#RAND')) then begin
          Script.QuestInfo[nQuestIdx].nRandRage:=Str_ToInt(s44,0);
        end;
        Continue;
      end; //0048BCF0

      if s34[1] = '[' then begin
        n6C:=10;
        if Script = nil then  begin
          Script := MakeNewScript();
          Script.nQuest:=n70;
        end;
        if CompareText(s34,'[goods]') = 0 then begin
          n6C:=20;
          Continue;
        end;

        s34:=ArrestStringEx(s34,'[',']',s74);
        New(SayingRecord);
        SayingRecord.ProcedureList:=TList.Create;
        SayingRecord.sLabel:=s74;
        s34:=GetValidStrCap(s34,s74,[' ',#9]);
        if CompareText(s74,'TRUE') = 0 then begin
          SayingRecord.boExtJmp:=True;
        end else begin
          SayingRecord.boExtJmp:=False;
        end;
          
        New(SayingProcedure);
        SayingRecord.ProcedureList.Add(SayingProcedure);
        SayingProcedure.ConditionList:=TList.Create;
        SayingProcedure.ActionList:=TList.Create;
        SayingProcedure.sSayMsg:='';
        SayingProcedure.ElseActionList:=TList.Create;
        SayingProcedure.sElseSayMsg:='';
        Script.RecordList.Add(SayingRecord);
        Continue;
      end; //0048BE05
      if (Script <> nil) and (SayingRecord <> nil) then begin
        if (n6C >= 10) and (n6C < 20) and (s34[1] = '#')then begin
          if CompareText(s34,'#IF') = 0 then begin
            if (SayingProcedure.ConditionList.Count > 0) or (SayingProcedure.sSayMsg <> '') then begin  //0048BE53
              New(SayingProcedure);
              SayingRecord.ProcedureList.Add(SayingProcedure);
              SayingProcedure.ConditionList:=TList.Create;
              SayingProcedure.ActionList:=TList.Create;
              SayingProcedure.sSayMsg:='';
              SayingProcedure.ElseActionList:=TList.Create;
              SayingProcedure.sElseSayMsg:='';
            end; //0048BECE
            n6C:=11;
          end; //0048BED5
          if CompareText(s34,'#ACT') = 0 then n6C:=12;
          if CompareText(s34,'#SAY') = 0 then n6C:=10;
          if CompareText(s34,'#ELSEACT') = 0 then n6C:=13;
          if CompareText(s34,'#ELSESAY') = 0 then n6C:=14;
          Continue;
        end; //0048BF3E

        if (n6C = 10) and (SayingProcedure <> nil) then
          SayingProcedure.sSayMsg:=SayingProcedure.sSayMsg + s34;

        if (n6C = 11) then begin
          New(QuestConditionInfo);
          QuestConditionInfo.TCmdList:=Nil;
          QuestConditionInfo.nCmdCode:=0;
          QuestConditionInfo.sParam1:='';
          QuestConditionInfo.nParam1:=0;
          QuestConditionInfo.sParam2:='';
          QuestConditionInfo.nParam2:=0;
          QuestConditionInfo.sParam3:='';
          QuestConditionInfo.nParam3:=0;
          QuestConditionInfo.sParam4:='';
          QuestConditionInfo.nParam4:=0;
          QuestConditionInfo.sParam5:='';
          QuestConditionInfo.nParam5:=0;
          QuestConditionInfo.sParam6:='';
          QuestConditionInfo.nParam6:=0;
          QuestConditionInfo.sParam7:='';
          QuestConditionInfo.nParam7:=0;
          //FillChar(QuestConditionInfo^,SizeOf(TQuestConditionInfo),#0);

          if QuestCondition(Trim(s34),QuestConditionInfo) then begin
            SayingProcedure.ConditionList.Add(QuestConditionInfo);
          end else begin
            if QuestConditionInfo.TCmdList<>Nil then QuestConditionInfo.TCmdList.Free;
            Dispose(QuestConditionInfo);
            MainOutMessage('脚本错误: ' + s34 + ' 第:' + IntToStr(i) + ' 行: ' + sScritpFileName);
          end;
        end; //0048C004

        if (n6C = 12) then begin
          New(QuestActionInfo);
          //FillChar(QuestActionInfo^,SizeOf(TQuestActionInfo),#0);
          QuestActionInfo.TCmdList:=Nil;
          QuestActionInfo.nCmdCode:=0;
          QuestActionInfo.sParam1:='';
          QuestActionInfo.nParam1:=0;
          QuestActionInfo.sParam2:='';
          QuestActionInfo.nParam2:=0;
          QuestActionInfo.sParam3:='';
          QuestActionInfo.nParam3:=0;
          QuestActionInfo.sParam4:='';
          QuestActionInfo.nParam4:=0;
          QuestActionInfo.sParam5:='';
          QuestActionInfo.nParam5:=0;
          QuestActionInfo.sParam6:='';
          QuestActionInfo.nParam6:=0;
          QuestActionInfo.sParam7:='';
          QuestActionInfo.nParam7:=0;
          if QuestAction(Trim(s34),QuestActionInfo) then begin
            SayingProcedure.ActionList.Add(QuestActionInfo);
          end else begin
            if QuestActionInfo.TCmdList<>Nil then QuestActionInfo.TCmdList.Free;
            Dispose(QuestActionInfo);
            MainOutMessage('脚本错误: ' + s34 + ' 第:' + IntToStr(i) + ' 行: ' + sScritpFileName);
          end;
        end; //0048C0B1

        if (n6C = 13) then begin
          New(QuestActionInfo);
          //FillChar(QuestActionInfo^,SizeOf(TQuestActionInfo),#0);
          QuestActionInfo.TCmdList:=Nil;
          QuestActionInfo.nCmdCode:=0;
          QuestActionInfo.sParam1:='';
          QuestActionInfo.nParam1:=0;
          QuestActionInfo.sParam2:='';
          QuestActionInfo.nParam2:=0;
          QuestActionInfo.sParam3:='';
          QuestActionInfo.nParam3:=0;
          QuestActionInfo.sParam4:='';
          QuestActionInfo.nParam4:=0;
          QuestActionInfo.sParam5:='';
          QuestActionInfo.nParam5:=0;
          QuestActionInfo.sParam6:='';
          QuestActionInfo.nParam6:=0;
          QuestActionInfo.sParam7:='';
          QuestActionInfo.nParam7:=0;
          if QuestAction(Trim(s34),QuestActionInfo) then begin
            SayingProcedure.ElseActionList.Add(QuestActionInfo);
          end else begin
            if QuestActionInfo.TCmdList<>Nil then QuestActionInfo.TCmdList.Free;
            Dispose(QuestActionInfo);
            MainOutMessage('脚本错误: ' + s34 + ' 第:' + IntToStr(i) + ' 行: ' + sScritpFileName);
          end;
        end;
        if (n6C = 14) then
          SayingProcedure.sElseSayMsg:=SayingProcedure.sElseSayMsg + s34;
      end;
      if (n6C = 20) and boFlag then begin
        s34:=GetValidStrCap(s34,s48,[' ',#9]);
        s34:=GetValidStrCap(s34,s4C,[' ',#9]);
        s34:=GetValidStrCap(s34,s50,[' ',#9]);
        if (s48 <> '') and (s50 <> '') then begin
          if (s48[1] = '"') then begin
            ArrestStringEx(s48,'"','"',s48);
          end;

          if CanSellItem(s48) then begin
            New(Goods);

            Goods.sItemName:=s48;
            Goods.nCount:=_MIN(Str_ToInt(s4C,0),1000);
            Goods.dwRefillTime:=Str_ToInt(s50,0)*60*1000;
            Goods.dwRefillTick:=0;
            TMerchant(NPC).m_RefillGoodsList.Add(Goods);
          end;
        end; //0048C2D2
      end; //0048C2D2      
    end;    // for
    LoadList.Free;
  end else begin //0048C2EB
    MainOutMessage('脚本文件不存在: ' + sScritpFileName);
  end;
  Result:=1;
end;

function TFrmDB.SaveGoodRecord(NPC: TMerchant; sFile: String):Integer;//0048C748
var
  I,II: Integer;
  sFileName:String;
  FileHandle:Integer;
  UserItem:pTUserItem;
  List:TList;
  Header420:TGoodFileHeader;
begin
Try 
  Result:= -1;
  sFileName:=g_Config.sEnvirDir+'Market_Saved\' + sFile + '.sav';
  if FileExists(sFileName) then begin
    FileHandle:= FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
  end else begin
    FileHandle:=FileCreate(sFileName);
  end;
  if FileHandle > 0 then begin
    FillChar(Header420,SizeOf(TGoodFileHeader),#0);
    for I := 0 to NPC.m_GoodsList.Count - 1 do begin
      List:=TList(NPC.m_GoodsList.Items[i]);
      Inc(Header420.nItemCount,List.Count);
    end;
    FileWrite(FileHandle,Header420,SizeOf(TGoodFileHeader));
    for I := 0 to NPC.m_GoodsList.Count - 1 do begin
      List:=TList(NPC.m_GoodsList.Items[i]);
      for II := 0 to List.Count - 1 do begin
        UserItem:=List.Items[II];
        FileWrite(FileHandle,UserItem^,SizeOf(TUserItem));
      end;
    end;
    FileClose(FileHandle);
    Result:=1;    
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadScriptFile'); 
End; 
end;

function TFrmDB.SaveGoodPriceRecord(NPC: TMerchant; sFile: String):Integer;//0048CA64
var
  I: Integer;
  sFileName:String;
  FileHandle:Integer;
  ItemPrice:pTItemPrice;
  Header420:TGoodFileHeader;
begin
Try 
  Result:= -1;
  sFileName:=g_Config.sEnvirDir+'Market_Prices\' + sFile + '.prc';
  if FileExists(sFileName) then begin
    FileHandle:= FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
  end else begin
    FileHandle:=FileCreate(sFileName);
  end;
  if FileHandle > 0 then begin
    FillChar(Header420,SizeOf(TGoodFileHeader),#0);
    Header420.nItemCount:=NPC.m_ItemPriceList.Count;
    FileWrite(FileHandle,Header420,SizeOf(TGoodFileHeader));
    for I := 0 to NPC.m_ItemPriceList.Count - 1 do begin
      ItemPrice:=NPC.m_ItemPriceList.Items[I];
      FileWrite(FileHandle,ItemPrice^,SizeOf(TItemPrice));
    end;
    FileClose(FileHandle);
    Result:=1;    
  end;

Except 
  MainOutMessage('[Exception] TFrmDB.SaveGoodPriceRecord'); 
End; 
end;
procedure TFrmDB.ReLoadNpc; //
begin
Try 

Except 
  MainOutMessage('[Exception] TFrmDB.ReLoadNpc'); 
End; 
end;

procedure TFrmDB.ReLoadMerchants; //00487BD8
var
  i,ii,III,nX,nY:Integer;
  sMapName,CorpsIdx:String;
  boNewNpc:Boolean;
  tMerchantNPC:TMerchant;
  sTop,sTemp,sScript,sCharName: String;
  sFile : TStringList;
  nFlag,wAppr,dwMoveTime:Integer;
  boCastle,boCanMove:Boolean;
  m_nIconIdx:Array[0..4] of Word;
  m_btDirection:Byte;
  boCanAutoColor:Byte;
  nAutoChangeIdx,dwAutoColorTime:LongWord;
begin
Try
  EnterCriticalSection(ProcessHumanCriticalSection);
  sFile:=TStringList.Create;
  try
    sFile.LoadFromFile(g_Config.sEnvirDir + 'Merchant.txt');
    for i := 0 to UserEngine.m_MerchantList.Count - 1 do begin
      tMerchantNPC:=TMerchant(UserEngine.m_MerchantList.Items[i]);
      tMerchantNPC.m_nFlag:= -1;
      //if (tMerchantNPC.m_sScript <> 'QFunction') then tMerchantNPC.m_nFlag:= -1;
    end;
    for I:=0 to sFile.Count-1 do begin
      sTop:=sFile.Strings[I];
      if sTop='' then Continue;
      if sTop[1]=';' then Continue;
      sTop:=GetValidStr3(sTop,sScript,[' ', ',', #9]);
      
      sTop:=GetValidStr3(sTop,sMapName,[' ', ',', #9]);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      nX:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      nY:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      sCharName:=sTemp;
      CorpsIdx:=GetValidStr3(sTemp,sTemp,['|']);
      sCharName:=sTemp;
      if CorpsIdx <> '' then begin
        for II:=Low(m_nIconIdx) to High(m_nIconIdx) do begin
          CorpsIdx:=GetValidStr3(CorpsIdx,sTemp, ['\']);  //特殊图标
          m_nIconIdx[II]:=Str_ToInt(sTemp,0);
        end;
      end;

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      nFlag:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      CorpsIdx:=GetValidStr3(sTemp,sTemp, ['.']);
      wAppr:=Str_ToInt(sTemp,0);
      m_btDirection:=_MIN(2,Str_ToInt(CorpsIdx,0));


      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      if (sTemp='1') then boCastle:=True else boCastle:=False;
      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      if (sTemp='1') then boCanMove:=True else boCanMove:=False;
      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);
      dwMoveTime:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);    //自动变色
      boCanAutoColor:=Str_ToInt(sTemp,0);

      sTop:=GetValidStr3(sTop,sTemp,[' ', ',', #9]);    //自动变色
      nAutoChangeIdx:=Str_ToInt(sTemp,0);

      dwAutoColorTime:=nAutoChangeIdx*500;

      boNewNpc:=True;
      for II := 0 to UserEngine.m_MerchantList.Count - 1 do begin
        tMerchantNPC:=TMerchant(UserEngine.m_MerchantList.Items[II]);
        if (tMerchantNPC.m_sMapName = sMapName) and
           (tMerchantNPC.m_nCurrX = nX) and
           (tMerchantNPC.m_nCurrY = nY) then begin
          boNewNpc:=False;
          tMerchantNPC.m_sScript      := sScript;
          tMerchantNPC.m_sCharName    := sCharName;
          tMerchantNPC.m_nFlag        := nFlag;
          tMerchantNPC.m_wAppr        := wAppr;
          tMerchantNPC.m_boCastle     := boCastle;
          tMerchantNPC.m_boCanMove    := boCanMove;
          tMerchantNPC.m_dwMoveTime   := dwMoveTime;
          tMerchantNPC.m_btDirection  :=m_btDirection;
          tMerchantNPC.m_boCanAutoColor:=boCanAutoColor;
          tMerchantNPC.m_nAutoChangeIdx:=nAutoChangeIdx;
          tMerchantNPC.m_dwAutoColorTime:=dwAutoColorTime;
          for III:=Low(m_nIconIdx) to High(m_nIconIdx) do tMerchantNPC.m_nIconIdx[III]:=m_nIconIdx[III];
          break;
        end;
      end;
      if boNewNpc then begin
        tMerchantNPC:=TMerchant.Create;
        tMerchantNPC.m_sMapName:=sMapName;
        tMerchantNPC.m_PEnvir:=g_MapManager.FindMap(tMerchantNPC.m_sMapName);
        if tMerchantNPC.m_PEnvir <> nil then begin
          tMerchantNPC.m_sScript      := sScript;
          tMerchantNPC.m_nCurrX       := nX;
          tMerchantNPC.m_nCurrY       := nY;
          tMerchantNPC.m_sCharName    := sCharName;
          tMerchantNPC.m_nFlag        := nFlag;
          tMerchantNPC.m_wAppr        := wAppr;
          tMerchantNPC.m_boCastle     := boCastle;
          tMerchantNPC.m_boCanMove    := boCanMove;
          tMerchantNPC.m_dwMoveTime   := dwMoveTime;
          tMerchantNPC.m_btDirection  :=m_btDirection;
          tMerchantNPC.m_boCanAutoColor:=boCanAutoColor;
          tMerchantNPC.m_nAutoChangeIdx:=nAutoChangeIdx;
          tMerchantNPC.m_dwAutoColorTime:=dwAutoColorTime;
          for III:=Low(m_nIconIdx) to High(m_nIconIdx) do tMerchantNPC.m_nIconIdx[III]:=m_nIconIdx[III];
          if (tMerchantNPC.m_sScript <> '') and (tMerchantNPC.m_sMapName <> '') then begin
            UserEngine.m_MerchantList.Add(tMerchantNPC);
            tMerchantNPC.Initialize;
          end;
        end else tMerchantNPC.Free;
      end;
    end;
    if g_FunctionNPC <> nil then g_FunctionNPC.m_nFlag:=0;

    for i := UserEngine.m_MerchantList.Count - 1 downto 0 do begin
      tMerchantNPC:=TMerchant(UserEngine.m_MerchantList.Items[i]);
      if tMerchantNPC.m_nFlag = -1 then begin
        tMerchantNPC.m_boGhost:=True;
        tMerchantNPC.m_dwGhostTick:=GetTickCount();
//        UserEngine.MerchantList.Delete(I);
      end;
    end;
  finally
    sFile.Free;
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.ReLoadMerchants'); 
End; 
end;

function TFrmDB.LoadUpgradeWeaponRecord(sNPCName: String;
  DataList: TList): Integer;//0048CBD0
var
  I: Integer;
  FileHandle:Integer;
  sFileName:String;
  UpgradeInfo:pTUpgradeInfo;
  UpgradeRecord:TUpgradeInfo;
  nRecordCount:Integer;
begin
Try 
  Result:= -1;
  sFileName:=g_Config.sEnvirDir+'Market_Upg\' + sNPCName + '.upg';
  if FileExists(sFileName) then begin
    FileHandle:= FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if FileHandle > 0 then begin
      FileRead(FileHandle,nRecordCount,SizeOf(Integer));
      for I := 0 to nRecordCount - 1 do begin
        if FileRead(FileHandle,UpgradeRecord,SizeOf(TUpgradeInfo)) = SizeOf(TUpgradeInfo) then begin
          New(UpgradeInfo);
          UpgradeInfo^:=UpgradeRecord;
          UpgradeInfo.dwGetBackTick:=0;
          DataList.Add(UpgradeInfo);
        end;
      end;
      FileClose(FileHandle);
      Result:=1;
    end;
    MainOutMessage(Format('[%s] 读取%d条升级武器数据记录',[sNPCName,DataList.Count]));
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadUpgradeWeaponRecord'); 
End; 
end;

function TFrmDB.SaveUpgradeWeaponRecord(sNPCName: String; DataList: TList):Integer;
var
  I: Integer;
  FileHandle:Integer;
  sFileName:String;
  UpgradeInfo:pTUpgradeInfo;
begin
Try 
  Result:= -1;
  sFileName:=g_Config.sEnvirDir+'Market_Upg\' + sNPCName + '.upg';
  if FileExists(sFileName) then begin
    FileHandle:= FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
  end else begin
    FileHandle:=FileCreate(sFileName);
  end;
  if FileHandle > 0 then begin
    FileWrite(FileHandle,DataList.Count,SizeOf(Integer));
    for I := 0 to DataList.Count - 1 do begin
      UpgradeInfo:=DataList.Items[I];
      FileWrite(FileHandle,UpgradeInfo^,SizeOf(TUpgradeInfo));
    end;
    FileClose(FileHandle);
    Result:=1;
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.SaveUpgradeWeaponRecord'); 
End; 
end;

function TFrmDB.LoadGoodRecord(NPC: TMerchant; sFile: String): Integer;//0048C574
var
  I: Integer;
  sFileName:String;
  FileHandle:Integer;
  UserItem:pTUserItem;
  List:TList;
  Header420:TGoodFileHeader;
begin
Try 
  Result:= -1;
  sFileName:=g_Config.sEnvirDir+'Market_Saved\' + sFile + '.sav';
  if FileExists(sFileName) then begin
    FileHandle:= FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    List:=nil;
    if FileHandle > 0 then begin
      if FileRead(FileHandle,Header420,SizeOf(TGoodFileHeader)) = SizeOf(TGoodFileHeader) then begin
        for I := 0 to Header420.nItemCount - 1 do begin
          New(UserItem);
          if FileRead(FileHandle,UserItem^,SizeOf(TUserItem)) = SizeOf(TUserItem) then begin
            if List = nil then begin
              List:=TList.Create;
              List.Add(UserItem)
            end else begin
              if pTUserItem(List.Items[0]).wIndex = UserItem.wIndex then begin
                List.Add(UserItem);
              end else begin
                NPC.m_GoodsList.Add(List);
                List:=TList.Create;
                List.Add(UserItem);
              end;
            end;
          end;
        end;
        if List <> nil then
          NPC.m_GoodsList.Add(List);
        FileClose(FileHandle);
        Result:=1;
      end;
    end;
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadGoodRecord'); 
End; 
end;

function TFrmDB.LoadTaxisList():Boolean;
  procedure LoadHumToFile(sFile:String;var Taxis:THumSort);
  var
    nFileHandle:integer;
  begin
    FillChar(Taxis,SizeOf(THumSort),#0);
    if FileExists(sFile) then begin
      nFileHandle:=FileOpen(sFile,fmOpenRead or fmShareDenyNone);
      if nFileHandle > 0 then begin
        Try
          FileSeek(nFileHandle,0,0);
          FileRead(nFileHandle,Taxis,SizeOf(THumSort));
        Finally
          FileClose(nFileHandle);
        end;
      end;
    end;
  end;

  procedure LoadHeroToFile(sFile:String;var Taxis:THeroSort);
  var
    nFileHandle:integer;
  begin
    FillChar(Taxis,SizeOf(THeroSort),#0);
    if FileExists(sFile) then begin
      nFileHandle:=FileOpen(sFile,fmOpenRead or fmShareDenyNone);
      if nFileHandle > 0 then begin
        Try
          FileSeek(nFileHandle,0,0);
          FileRead(nFileHandle,Taxis,SizeOf(THeroSort));
        Finally
          FileClose(nFileHandle);
        end;
      end;
    end;
  end;
begin
Try 
  Try
    LoadHumToFile(g_Config.sSort + AllHum,g_TaxisAllList);
    LoadHumToFile(g_Config.sSort + WarrHum,g_TaxisWarrList);
    LoadHumToFile(g_Config.sSort + WizardHum,g_TaxisWaidList);
    LoadHumToFile(g_Config.sSort + TaosHum,g_TaxisTaosList);
    LoadHeroToFile(g_Config.sSort + AllHero,g_HeroAllList);
    LoadHeroToFile(g_Config.sSort + WarrHero,g_HeroWarrList);
    LoadHeroToFile(g_Config.sSort + WizardHero,g_HeroWaidList);
    LoadHeroToFile(g_Config.sSort + TaosHero,g_HeroTaosList);
    LoadHumToFile(g_Config.sSort + MASTERALL,g_MasterList);
    {if (GetMD5Text(g_sProductName) <> DecodeString('HrQ]TrHuJRPrHbQbHbHpTRPuIbHmIbDtURM`HO`sUOD')) or
       (GetMD5Text(g_sProgram) <> DecodeString('HBM`HRDqHBDlUBI_I?@lU?abT_HqTOLoTbTnHoDrH_X')) or
       (GetMD5Text(g_sWebSite) <> DecodeString('To`lU?Q^HBI^UOE^JRHrHoLoToLqI_\pT_PsI_aaI_L')) or
       (GetMD5Text(g_sBbsSite) <> DecodeString('IOa`H?<mT_XnJO<tU_A]Io@lUOPmUbHlI?TtJBLrUBP')) then begin
      g_Config.boJsCheckFail2:=True;
    end; }
  Except
    MainOutMessage('[Exception] TFrmDB.LoadTaxisList');
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadTaxisList'); 
End; 
end;

function TFrmDB.LoadGoodPriceRecord(NPC: TMerchant; sFile: String): Integer;//0048C918
var
  I: Integer;
  sFileName:String;
  FileHandle:Integer;
  ItemPrice:pTItemPrice;
  Header420:TGoodFileHeader;
begin
Try 
  Result:= -1;
  sFileName:=g_Config.sEnvirDir+'Market_Prices\' + sFile + '.prc';
  if FileExists(sFileName) then begin
    FileHandle:= FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if FileHandle > 0 then begin
      if FileRead(FileHandle,Header420,SizeOf(TGoodFileHeader)) = SizeOf(TGoodFileHeader) then begin
        for I := 0 to Header420.nItemCount - 1 do begin
          New(ItemPrice);
          if FileRead(FileHandle,ItemPrice^,SizeOf(TItemPrice)) = SizeOf(TItemPrice) then begin
            NPC.m_ItemPriceList.Add(ItemPrice);
          end else begin
            Dispose(ItemPrice);
            break;
          end;
        end;
      end;
      FileClose(FileHandle);
      Result:=1;
    end;
  end;
Except 
  MainOutMessage('[Exception] TFrmDB.LoadGoodPriceRecord'); 
End; 
end;
{
procedure DeCryptString(Src,Dest:PChar;nSrc:Integer;var nDest:Integer);stdcall;
begin
Try 

Except 
  MainOutMessage('[Exception] UnLocalDB.DeCryptString'); 
End; 
end;
}
function ScriptCodeString(sSrc:String):String;
var
  Dest:array[0..1024] of Char;
begin
Try
  Result:='';
  if Assigned(PlugScript) then begin
    FillChar(Dest,SizeOf(Dest),0);
    TGetScriptText(PlugScript)(@sSrc[1],@Dest,length(sSrc));
    Result:=strpas(PChar(@Dest));
  end;
Except
  MainOutMessage('[Exception] UnLocalDB.ScriptCodeString');
End;
end;

function ScriptDeCodeString(sSrc,sKey:String):String;
//var
//  Dest:array[0..1024] of Char;
//  nDest:Integer;
begin
Try
  Result:='';
  if sSrc = '' then exit;
  Try
    Result:=DecryStrHex(sSrc,sKey);
  Except
    Result:=sSrc;
  end;
  {if (nDeCryptString >= 0) and Assigned(PlugProcArray[nDeCryptString].nProcAddr) then begin
    FillChar(Dest,SizeOf(Dest),0);
    TDeCryptString(PlugProcArray[nDeCryptString].nProcAddr)(@sSrc[1],@Dest,length(sSrc),nDest);
    Result:=strpas(PChar(@Dest));
    exit;
  end;  }
  //Result:=sSrc;
//  DeCryptString(@sSrc[1],@Dest,length(sSrc),nDest);

Except
  MainOutMessage('[Exception] UnLocalDB.DeCodeString');
End;
end;

function ScriptDeCodeStringEx(sSrc:String):String;
var
  Dest:array [0..4096] of Byte;
  I,nLen,II: Integer;
begin
Try
  Result:='';
  nLen := length(Dest);
  FillChar(Dest,nLen ,#0);
  if Assigned(PlugScript) then begin
    II := TGetScriptText(PlugScript)(@sSrc[1],@Dest,nLen);
   for I := 0 to II do
      Dest[I] := Dest[I] - II;
    //ShowMessage(strpas(PChar(@Dest)));
    Result:=strpas(PChar(@Dest));
  end;
Except
  MainOutMessage('[Exception] UnLocalDB.ScriptDeCodeStringEx');
End;
end;

procedure TFrmDB.DeCodeStringList(StringList: TStringList);
var
  I: Integer;
  sLine:String;
  sKey:String;
  KeyClass:Byte;
  //nKey:Integer;
begin
Try
  KeyClass:=0;
//  nKey:=0;
  for I := 0 to StringList.Count - 1 do begin
    sLine:=StringList.Strings[I];
    if I=0 then begin
      if CompareStr(sLine,sENCYPTSCRIPTFLAG)=0 then begin
        KeyClass:=1;
      end else
      if (CompareStr(sLine,'YUEENCYPTSCRIPTFLAG')=0) and (g_Config.nDemoVerIdx=2) then begin
        KeyClass:=2;
      end else
      if CompareStr(sLine,'PLUGENCYPTSCRIPTFLAG')=0 then begin
        KeyClass:=3;
      end else
      if CompareStr(sLine,sENCRYPTSCRIPTDEMO)=0 then begin
        KeyClass:=4;
      end else
      if CompareStr(sLine,sSCRIPTOFPLUG)=0 then begin
        KeyClass:=5;
      end else break;
    end else
    if I=1 then begin
      Try
        case KeyClass of
          1: sKey:=EncryStrHex(LowerCase(sLine),sENCYPTSCRIPTFLAG);
          2: sKey:=EncryStrHex(LowerCase(sLine),'YUEENCYPTSCRIPTFLAG');
          3: ;
          4: sKey:=EncryStrHex(sLine,sENCRYPTSCRIPTDEMO);
          5: begin
            sLine:=ScriptDeCodeStringEx(sLine);
            StringList.Strings[I]:=sLine;
            ContInue;
          end
          else break;
        end;
      Except
        break;
      end;
    end else begin
      if KeyClass=3 then begin
        sLine:=ScriptCodeString(sLine);
        StringList.Strings[I]:=sLine;
      end else
      if KeyClass=4 then begin
        sLine:=ScriptDeCodeString(sLine,sKey);
        StringList.Strings[I]:=sLine;
      end else
      if KeyClass=5 then begin
        sLine:=ScriptDeCodeStringEx(sLine);
        StringList.Strings[I]:=sLine;
      end else begin
        sLine:=ScriptDeCodeString(sLine,sKey);
        StringList.Strings[I]:=sLine;
      end;
      ContInue;
    end;
    StringList.Strings[I]:='';
  end;
Except
  MainOutMessage('[Exception] TFrmDB.DeCodeStringList');
End;
end;


constructor TFrmDB.Create();
begin
Try
  inherited;
  CoInitialize(nil);
  m_RSA:=TRSA.Create(nil);
  m_RSA.Server:=True;
  m_Query:=TQuery.Create(nil);
  //Query:=TADOQuery.Create(nil);
Except 
  MainOutMessage('[Exception] TFrmDB.Create');
End; 
end;

destructor TFrmDB.Destroy;
begin
Try 
  m_Query.Free;
  //Query.Free;
  m_RSA.Free;
  CoUnInitialize;
  inherited;
Except 
  MainOutMessage('[Exception] TFrmDB.Destroy'); 
End; 
end;

initialization
begin

end;
finalization
begin

end;

end.
