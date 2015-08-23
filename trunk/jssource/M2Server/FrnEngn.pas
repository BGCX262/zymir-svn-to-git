//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit FrnEngn;

interface

uses
  Windows, Classes, SysUtils, Grobal2;

type

  TFrontEngine = class(TThread)
    m_UserCriticalSection: TRTLCriticalSection;
    m_LoadRcdList: TList; //0x30
    m_SaveRcdList: TList; //0x34
    m_CorpsRcdList: TList;
    m_ChangeGoldList: TList; //0x38
  private
    m_LoadRcdTempList: TList;
    m_SaveRcdTempList: TList;
    m_CorpsRcdTempList: TList;
    procedure GetGameTime();
    procedure ProcessGameDate();
    function LoadHumFromDB(LoadUser: pTLoadDBInfo; var boReTry: Boolean):
      Boolean;
    function ChangeUserGoldInDB(GoldChangeInfo: pTGoldChangeInfo): Boolean;
    procedure Run();
    { Private declarations }
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    function SaveListCount(): Integer;
    function IsIdle(): Boolean;
    function IsFull(): Boolean;
    procedure DeleteHuman(nGateIndex, nSocket: Integer);
    function InSaveRcdList(sChrName: string): Boolean;
    procedure AddChangeGoldList(sGameMasterName, sGetGoldUserName: string;
      nGold: Integer);
    procedure AddToLoadRcdList(sAccount, sChrName, sIPaddr: string; boFlag:
      Boolean; nSessionID: integer; nPayMent, nPayMode, nSoftVersionDate, nSocket,
      nGSocketIdx, nGateIdx: Integer; boHero: Boolean; nJob, nMan: Byte;
      boNewHero: Boolean; PlayObject: TObject);
    procedure AddToSaveRcdList(SaveRcd: pTSaveRcd);
    procedure CreateHeroHum(sAccount, sChrName: string; PlayObject: TObject;
      nJob, nMan: Byte; sMaster: string; btHero: Integer);

    procedure AddCorpsRcdList(sAccount, sChrName, sReserve: string; nCode: Byte;
      PlayObject: TObject);
    procedure CorpsRcdLoad(CorpsRcdInfo: pTCorpsRcdInfo);
  end;

implementation
uses
  M2Share, RunDB, ObjBase;
{ TFrontEngine }

constructor TFrontEngine.Create(CreateSuspended: Boolean);
begin
  try
    inherited;
    InitializeCriticalSection(m_UserCriticalSection);
    m_LoadRcdList := TList.Create;
    m_SaveRcdList := TList.Create;
    m_CorpsRcdList := TList.Create;
    m_ChangeGoldList := TList.Create;
    m_LoadRcdTempList := TList.Create;
    m_SaveRcdTempList := TList.Create;
    m_CorpsRcdTempList := TList.Create;
    //  FreeOnTerminate:=True;
  except
    MainOutMessage('[Exception] TFrontEngine.Create');
  end;
end;

destructor TFrontEngine.Destroy;
begin
  try
    m_LoadRcdList.Free;
    m_SaveRcdList.Free;
    m_CorpsRcdList.Free;
    m_ChangeGoldList.Free;
    m_LoadRcdTempList.Free;
    m_SaveRcdTempList.Free;
    m_CorpsRcdTempList.Free;
    DeleteCriticalSection(m_UserCriticalSection);
    inherited;
  except
    MainOutMessage('[Exception] TFrontEngine.Destroy');
  end;
end;
//004B5148

procedure TFrontEngine.Execute;
resourcestring
  sExceptionMsg = '[Exception] TFrontEngine::Execute';
begin
  try
    while not Terminated do
    begin
      try
        Run();
      except
        MainOutMessage(sExceptionMsg);
      end;
      Sleep(1);
    end;
  except
    MainOutMessage('[Exception] TFrontEngine.Execute');
  end;
end;

procedure TFrontEngine.GetGameTime; //004B50AC
var
  Hour, Min, Sec, MSec: Word;
begin
  try
    DecodeTime(Time, Hour, Min, Sec, MSec);
    case Hour of
      5, 6, 7, 8, 9, 10, 16, 17, 18, 19, 20, 21, 22: g_nGameTime := 1;
      11, 23: g_nGameTime := 2;
      4, 15: g_nGameTime := 0;
      0, 1, 2, 3, 12, 13, 14: g_nGameTime := 3;
    end;
  except
    MainOutMessage('[Exception] TFrontEngine.GetGameTime');
  end;
end;

function TFrontEngine.IsIdle: Boolean;
begin
  try
    Result := False;
    EnterCriticalSection(m_UserCriticalSection);
    try
      if m_SaveRcdList.Count = 0 then
        Result := True;
    finally
      LeaveCriticalSection(m_UserCriticalSection);
    end;

  except
    MainOutMessage('[Exception] TFrontEngine.IsIdle:');
  end;
end;

function TFrontEngine.SaveListCount: Integer;
begin
  try
    Result := 0;
    EnterCriticalSection(m_UserCriticalSection);
    try
      Result := m_SaveRcdList.Count;
    finally
      LeaveCriticalSection(m_UserCriticalSection);
    end;
  except
    MainOutMessage('[Exception] TFrontEngine.SaveListCount:');
  end;
end;

procedure TFrontEngine.ProcessGameDate;
var
  I: Integer;
  II: Integer;
  TempList: TList;
  ChangeGoldList: TList;
  LoadDBInfo: pTLoadDBInfo;
  SaveRcd: pTSaveRcd;
  GoldChangeInfo: pTGoldChangeInfo;
  boReTryLoadDB: Boolean;
  CorpsRcdInfo: pTCorpsRcdInfo;
begin
  try
    try
      ChangeGoldList := nil;
      EnterCriticalSection(m_UserCriticalSection);
      try
        m_SaveRcdTempList.Clear;
        for I := 0 to m_SaveRcdList.Count - 1 do
        begin
          m_SaveRcdTempList.Add(m_SaveRcdList.Items[I]);
        end;
        m_CorpsRcdTempList.Clear;
        for I := 0 to m_CorpsRcdList.Count - 1 do
        begin
          m_CorpsRcdTempList.Add(m_CorpsRcdList.Items[I]);
        end;
        m_CorpsRcdList.Clear;

        TempList := m_LoadRcdTempList;
        m_LoadRcdTempList := m_LoadRcdList;
        m_LoadRcdList := TempList;

        if m_ChangeGoldList.Count > 0 then
        begin
          ChangeGoldList := TList.Create;
          for I := 0 to m_ChangeGoldList.Count - 1 do
          begin
            ChangeGoldList.Add(m_ChangeGoldList.Items[I]);
          end;
        end;
        m_ChangeGoldList.Clear;
      finally
        LeaveCriticalSection(m_UserCriticalSection);
      end;
      for I := 0 to m_SaveRcdTempList.Count - 1 do
      begin
        SaveRcd := m_SaveRcdTempList.Items[I];
        if SaveHumRcdToDB(SaveRcd.sAccount, SaveRcd.sChrName,
          SaveRcd.nSessionID, SaveRcd.HumanRcd) or (SaveRcd.nReTryCount > 50) then
        begin
          if SaveRcd.PlayObject <> nil then
          begin
            TPlayObject(SaveRcd.PlayObject).m_boRcdSaved := True;
          end;
          EnterCriticalSection(m_UserCriticalSection);
          try
            for II := 0 to m_SaveRcdList.Count - 1 do
            begin
              if m_SaveRcdList.Items[II] = SaveRcd then
              begin
                m_SaveRcdList.Delete(II);
                Dispose(SaveRcd);
                break;
              end;
            end;
          finally
            LeaveCriticalSection(m_UserCriticalSection);
          end;
        end
        else
        begin
          Inc(SaveRcd.nReTryCount);
        end;
      end; //004B4FDA
      m_SaveRcdTempList.Clear;

      for I := 0 to m_LoadRcdTempList.Count - 1 do
      begin
        LoadDBInfo := m_LoadRcdTempList.Items[I];
        if LoadDBInfo.boNewHero then
        begin //070527增加创建英雄
          CreateHeroHum(LoadDBInfo.sAccount, LoadDBInfo.sCharName,
            LoadDBInfo.PlayObject, LoadDBInfo.nHeroJob, LoadDBInfo.nHeroMan,
            LoadDBInfo.sMasterName, LoadDBInfo.nPayMent);
          Dispose(LoadDBInfo);
        end
        else
        begin
          if not LoadHumFromDB(LoadDBInfo, boReTryLoadDB) then
            if not LoadDBInfo.boLoadHero then
              //070527如果不是英雄则不发送断开信息
              RunSocket.CloseUser(LoadDBInfo.nGateIdx, LoadDBInfo.nSocket);
          if not boReTryLoadDB then
          begin
            Dispose(LoadDBInfo);
          end
          else
          begin //如果读取人物数据失败(数据还没有保存),则重新加入队列
            EnterCriticalSection(m_UserCriticalSection);
            try
              m_LoadRcdList.Add(LoadDBInfo);
            finally
              LeaveCriticalSection(m_UserCriticalSection);
            end;
          end;
        end;

      end; //004B504D
      //
      m_LoadRcdTempList.Clear;

      if ChangeGoldList <> nil then
      begin
        for I := 0 to ChangeGoldList.Count - 1 do
        begin
          GoldChangeInfo := ChangeGoldList.Items[I];
          ChangeUserGoldInDB(GoldChangeInfo);
          Dispose(GoldChangeInfo);
        end; //004B509F
        ChangeGoldList.Free;
      end; //004B50A7

      for I := 0 to m_CorpsRcdTempList.Count - 1 do
      begin
        CorpsRcdInfo := m_CorpsRcdTempList.Items[I];
        CorpsRcdLoad(CorpsRcdInfo);
        Dispose(CorpsRcdInfo);
      end;

      m_CorpsRcdTempList.Clear;
    except
      MainOutMessage('[Exception] TFrontEngine.ProcessGameDate');
    end;
  except
    MainOutMessage('[Exception] TFrontEngine.ProcessGameDate');
  end;
end;

function TFrontEngine.IsFull: Boolean; //004B4988
begin
  try
    Result := False;
    EnterCriticalSection(m_UserCriticalSection);
    try
      if m_SaveRcdList.Count >= 1000 then
      begin
        Result := True;
      end;
    finally
      LeaveCriticalSection(m_UserCriticalSection);
    end;
  except
    MainOutMessage('[Exception] TFrontEngine.IsFull:');
  end;
end;

procedure TFrontEngine.AddCorpsRcdList(sAccount, sChrName, sReserve: string;
  nCode: Byte; PlayObject: TObject);
var
  CorpsRcdInfo: pTCorpsRcdInfo;
begin
  try
    New(CorpsRcdInfo);
    CorpsRcdInfo.sAccount := sAccount;
    CorpsRcdInfo.sCharName := sChrName;
    CorpsRcdInfo.sReserve := sReserve;
    CorpsRcdInfo.nCode := nCode;
    CorpsRcdInfo.PlayObject := PlayObject;

    EnterCriticalSection(m_UserCriticalSection);
    try
      m_CorpsRcdList.Add(CorpsRcdInfo);
    finally
      LeaveCriticalSection(m_UserCriticalSection);
    end;
  except
    MainOutMessage('[Exception] TFrontEngine.AddCorpsRcdList');
  end;
end;

procedure TFrontEngine.CorpsRcdLoad(CorpsRcdInfo: pTCorpsRcdInfo);
var
  SendCorpsRcdInfo: TSendCorpsRcdInfo;
begin
  try
    FillChar(SendCorpsRcdInfo, SizeOf(TSendCorpsRcdInfo), #0);
    SendCorpsRcdInfo.sAccount := CorpsRcdInfo.sAccount;
    SendCorpsRcdInfo.sCharName := CorpsRcdInfo.sCharName;
    SendCorpsRcdInfo.sReserve := CorpsRcdInfo.sReserve;
    SendCorpsRcdInfo.nCode := CorpsRcdInfo.nCode;
    case CorpsRcdInfo.nCode of
      CORPS_DELETEHERO: SendDefCorps(SendCorpsRcdInfo);
    else
      SendDefCorps(SendCorpsRcdInfo);
    end;
  except
    MainOutMessage('[Exception] TFrontEngine.CorpsRcdLoad');
  end;
end;

procedure TFrontEngine.AddToLoadRcdList(sAccount, sChrName, sIPaddr: string;
  boFlag: Boolean; nSessionID, nPayMent, nPayMode, nSoftVersionDate, nSocket,
    nGSocketIdx, nGateIdx: Integer; boHero: Boolean; nJob, nMan: Byte; boNewHero:
    Boolean; PlayObject: TObject);
//004B46A0
var
  LoadRcdInfo: pTLoadDBInfo;
begin
  try
    New(LoadRcdInfo);
    LoadRcdInfo.sAccount := sAccount;
    LoadRcdInfo.sCharName := sChrName;
    LoadRcdInfo.sIPaddr := sIPaddr;
    LoadRcdInfo.nSessionID := nSessionID;
    LoadRcdInfo.nSoftVersionDate := nSoftVersionDate;
    LoadRcdInfo.nPayMent := nPayMent;
    LoadRcdInfo.nPayMode := nPayMode;
    LoadRcdInfo.nSocket := nSocket;
    LoadRcdInfo.nGSocketIdx := nGSocketIdx;
    LoadRcdInfo.nGateIdx := nGateIdx;
    LoadRcdInfo.dwNewUserTick := GetTickCount();
    LoadRcdInfo.PlayObject := PlayObject;
    LoadRcdInfo.nReLoadCount := 0;
    LoadRcdInfo.boLoadHero := boHero;
    LoadRcdInfo.nHeroJob := nJob;
    LoadRcdInfo.nHeroMan := nMan;
    LoadRcdInfo.boNewHero := boNewHero;
    if (boHero) and (PlayObject = nil) then
      exit;
    if PlayObject <> nil then
      LoadRcdInfo.sMasterName := TPlayObject(PlayObject).m_sCharName;
    EnterCriticalSection(m_UserCriticalSection);
    try
      m_LoadRcdList.Add(LoadRcdInfo);
      //MainOutMessage(LoadRcdInfo.sAccount);
    finally
      LeaveCriticalSection(m_UserCriticalSection);
    end;
  except
    MainOutMessage('[Exception] TFrontEngine.AddToLoadRcdList');
  end;
end;

function TFrontEngine.LoadHumFromDB(LoadUser: pTLoadDBInfo; var boReTry:
  Boolean): Boolean; //004B4B10
var
  HumanRcd: THumDataInfo;
  UserOpenInfo: pTUserOpenInfo;
begin
  try
    Result := False;
    boReTry := False;
    if InSaveRcdList(LoadUser.sCharName) then
    begin
      boReTry := True; //反回TRUE,则重新加入队列
      exit;
    end;
    if (UserEngine.GetPlayObjectEx(LoadUser.sCharName) <> nil) then
    begin
      UserEngine.KickPlayObjectEx(LoadUser.sCharName);
      boReTry := True; //反回TRUE,则重新加入队列
      exit;
    end;
    if not LoadHumRcdFromDB(LoadUser.sAccount, LoadUser.sCharName,
      LoadUser.sIPaddr, HumanRcd, LoadUser.nSessionID, LoadUser.boLoadHero,
      LoadUser.nHeroJob, LoadUser.nHeroMan) then
    begin
      if not LoadUser.boLoadHero then
        //070527增加如果不是英雄则发送断开数据
        RunSocket.SendOutConnectMsg(LoadUser.nGateIdx, LoadUser.nSocket,
          LoadUser.nGSocketIdx);
    end
    else
    begin
      New(UserOpenInfo);
      UserOpenInfo.sChrName := LoadUser.sCharName;
      UserOpenInfo.LoadUser := LoadUser^;
      UserOpenInfo.HumanRcd := HumanRcd;
      UserEngine.AddUserOpenInfo(UserOpenInfo);
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TFrontEngine.LoadHumFromDB');
  end;
end;

//创建英雄

procedure TFrontEngine.CreateHeroHum(sAccount, sChrName: string; PlayObject:
  TObject; nJob, nMan: Byte; sMaster: string; btHero: Integer);
var
  nMsg: Integer;
  sMsg: string;
begin
  try
    CreateNewHeroHum(sAccount, sChrName, nJob, nMan, nMsg, sMaster);
    sMsg := sSE_CreateHeroFailEx;
    case nMsg of
      -1: sMsg := sSE_CreateHeroFailEx; //创建失败
      0: sMsg := sSE_HeroNameFilter; //人物名称不合法
      1:
        begin
          sMsg := sSE_CREATEHEROOK; //创建成功
          TBaseObject(PlayObject).m_HeroName := sChrName;
          TBaseObject(PlayObject).m_CreateHeroName := '';
          TPlayObject(PlayObject).m_HeroClass := (btHero = 1);
        end;
      2: sMsg := sSE_HERONAMEEXISTS; //人物已存在
      3: sMsg := sSE_HEROOVERCHRCOUNT; //人物数量过多
      4: sMsg := sSE_CREATEHEROFAIL; //创建失败
    end;
    TBaseObject(PlayObject).NpcGotoLable(g_FunctionNPC, sMsg, False);
    //if g_FunctionNPC<>nil then
    //g_FunctionNPC.GotoLable(TPlayObject(PlayObject),sMsg,False)
  except
    MainOutMessage('[Exception] TFrontEngine.CreateHeroHum');
  end;
end;

function TFrontEngine.InSaveRcdList(sChrName: string): Boolean; //004B4A48
var
  I: Integer;
begin
  try
    Result := False;
    EnterCriticalSection(m_UserCriticalSection);
    try
      for I := 0 to m_SaveRcdList.Count - 1 do
      begin
        if pTSaveRcd(m_SaveRcdList.Items[i]).sChrName = sChrName then
        begin
          Result := True;
          break;
        end;
      end;
    finally
      LeaveCriticalSection(m_UserCriticalSection);
    end;
  except
    MainOutMessage('[Exception] TFrontEngine.InSaveRcdList');
  end;
end;

procedure TFrontEngine.AddChangeGoldList(sGameMasterName, sGetGoldUserName:
  string;
  nGold: Integer); //004B4828
var
  GoldInfo: pTGoldChangeInfo;
begin
  try
    New(GoldInfo);
    GoldInfo.sGameMasterName := sGameMasterName;
    GoldInfo.sGetGoldUser := sGetGoldUserName;
    GoldInfo.nGold := nGold;
    m_ChangeGoldList.Add(GoldInfo);
  except
    MainOutMessage('[Exception] TFrontEngine.AddChangeGoldList');
  end;
end;

procedure TFrontEngine.AddToSaveRcdList(SaveRcd: pTSaveRcd); //004B49EC
begin
  try
    EnterCriticalSection(m_UserCriticalSection);
    try
      m_SaveRcdList.Add(SaveRcd);
    finally
      LeaveCriticalSection(m_UserCriticalSection);
    end;
  except
    MainOutMessage('[Exception] TFrontEngine.AddToSaveRcdList');
  end;
end;

procedure TFrontEngine.DeleteHuman(nGateIndex, nSocket: Integer); //004B45EC
var
  I: Integer;
  LoadRcdInfo: pTLoadDBInfo;
begin
  try
    EnterCriticalSection(m_UserCriticalSection);
    try
      for I := 0 to m_LoadRcdList.Count - 1 do
      begin
        LoadRcdInfo := m_LoadRcdList.Items[I];
        if (LoadRcdInfo.nGateIdx = nGateIndex) and (LoadRcdInfo.nSocket =
          nSocket) then
        begin
          Dispose(LoadRcdInfo);
          m_LoadRcdList.Delete(I);
          break;
        end;
      end;
    finally
      LeaveCriticalSection(m_UserCriticalSection);
    end;
  except
    MainOutMessage('[Exception] TFrontEngine.DeleteHuman');
  end;
end;

function TFrontEngine.ChangeUserGoldInDB(GoldChangeInfo: pTGoldChangeInfo):
  Boolean;
var
  HumanRcd: THumDataInfo;
begin
  try
    Result := False;
    if LoadHumRcdFromDB('1', GoldChangeInfo.sGetGoldUser, '1', HumanRcd, 1,
      False, 0, 0) then
    begin
      if ((HumanRcd.Data.nGold + GoldChangeInfo.nGold) > 0) and
        ((HumanRcd.Data.nGold + GoldChangeInfo.nGold) < 2000000000) then
      begin
        Inc(HumanRcd.Data.nGold, GoldChangeInfo.nGold);
        if SaveHumRcdToDB('1', GoldChangeInfo.sGetGoldUser, 1, HumanRcd) then
        begin
          UserEngine.sub_4AE514(GoldChangeInfo);
          Result := True;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TFrontEngine.ChangeUserGoldInDB');
  end;
end;

procedure TFrontEngine.Run;
begin
  try
    ProcessGameDate();
    GetGameTime();
  except
    MainOutMessage('[Exception] TFrontEngine.Run');
  end;
end;
end.

