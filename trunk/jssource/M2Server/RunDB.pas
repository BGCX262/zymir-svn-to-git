//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit RunDB;

interface
uses
  Windows, SysUtils, Grobal2, SDK, mudutil, WinSock;
procedure DBSocketThread(ThreadInfo: pTThreadInfo); stdcall;
function DBSocketConnected(): Boolean;

function GetDBSockMsg(nQueryID: Integer; var nIdent: integer; var nRecog:
  integer; var sStr: string; dwTimeOut: LongWord; boLoadRcd: Boolean): Boolean;
function MakeHumRcdFromLocal(var HumanRcd: THumDataInfo): Boolean;
function LoadHumRcdFromDB(sAccount, sCharName, sStr: string; var HumanRcd:
  THumDataInfo; nCertCode: Integer; boHero: Boolean; nJob, nMan: Byte): Boolean;
function SaveHumRcdToDB(sAccount, sCharName: string; nSessionID: Integer; var
  HumanRcd: THumDataInfo): Boolean;
function SaveRcd(sAccount, sCharName: string; nSessionID: Integer; var HumanRcd:
  THumDataInfo): Boolean; //004B42C8
function LoadRcd(sAccount, sCharName, sStr: string; nCertCode: Integer; var
  HumanRcd: THumDataInfo; boHero: Boolean; nJob, nMan: Byte): Boolean;
procedure SendDBSockMsg(nQueryID: Integer; sMsg: string);
function GetQueryID(Config: pTM2Config): Integer;
function CreateNewHeroHum(sAccount, sCharName: string; nJob, nMan: Byte; var
  nMsg: Integer; sMaster: string): Boolean; //004B42C8
procedure SendDefCorps(SendCorpsRcdInfo: TSendCorpsRcdInfo);
implementation

uses M2Share, svMain, HUtil32, EDcode;

procedure DBSocketRead(Config: pTM2Config);
var
  dwReceiveTimeTick: LongWord;
  nReceiveTime: Integer;
  sRecvText: string;
  nRecvLen: Integer;
  nRet: Integer;
begin
  try
    try
      if Config.DBSocket = INVALID_SOCKET then
        exit;

      dwReceiveTimeTick := GetTickCount();
      nRet := ioctlsocket(Config.DBSocket, FIONREAD, nRecvLen);
      if (nRet = SOCKET_ERROR) or (nRecvLen = 0) then
      begin
        {nRet:=}WSAGetLastError;
        Config.DBSocket := INVALID_SOCKET;
        Sleep(100);
        Config.boDBSocketConnected := False;
        exit;
      end;
      SetLength(sRecvText, nRecvLen);
      nRecvLen := recv(Config.DBSocket, Pointer(sRecvText)^, nRecvLen, 0);
      SetLength(sRecvText, nRecvLen);

      Inc(Config.nDBSocketRecvIncLen, nRecvLen);
      if (nRecvLen <> SOCKET_ERROR) and (nRecvLen > 0) then
      begin
        if nRecvLen > Config.nDBSocketRecvMaxLen then
          Config.nDBSocketRecvMaxLen := nRecvLen;
        EnterCriticalSection(UserDBSection);
        try
          //MainOutMessage(sRecvText);
          Config.sDBSocketRecvText := Config.sDBSocketRecvText + sRecvText;
          if not Config.boDBSocketWorking then
          begin
            Config.sDBSocketRecvText := '';
          end;
        finally
          LeaveCriticalSection(UserDBSection);
        end;
      end;

      Inc(Config.nDBSocketRecvCount);
      nReceiveTime := GetTickCount - dwReceiveTimeTick;
      if Config.nDBReceiveMaxTime < nReceiveTime then
        Config.nDBReceiveMaxTime := nReceiveTime;
    except
      MainOutMessage('[Exception] RunDB->DBSocketRead');
    end;
  except
    MainOutMessage('[Exception] UnRunDB.DBSocketRead');
  end;
end;

procedure DBSocketProcess(Config: pTM2Config; ThreadInfo: pTThreadInfo);
var
  s: TSocket;
  name: sockaddr_in;
  HostEnt: PHostEnt;
  argp: LongInt;
  readfds: TFDSet;
  timeout: TTimeVal;
  nRet: Integer;
  boRecvData: BOOL;
  nRunTime: Integer;
  dwRunTick: LongWord;
  boShow: Boolean;
resourcestring
  sIDServerConnected = '数据库服务器(%s:%d)连接成功...';
  sIDServerDisconnect = '数据库服务器(%s:%d)断开连接...';
begin
  try
    try
      s := INVALID_SOCKET;
      if Config.DBSocket <> INVALID_SOCKET then
        s := Config.DBSocket;
      dwRunTick := GetTickCount();
      ThreadInfo.dwRunTick := dwRunTick;
      boRecvData := False;
      boShow := False;
      while True do
      begin
        if ThreadInfo.boTerminaled then
          break;
        if not boRecvData then
          Sleep(1)
        else
          Sleep(0);
        boRecvData := False;
        nRunTime := GetTickCount - ThreadInfo.dwRunTick;
        if ThreadInfo.nRunTime < nRunTime then
          ThreadInfo.nRunTime := nRunTime;
        if ThreadInfo.nMaxRunTime < nRunTime then
          ThreadInfo.nMaxRunTime := nRunTime;
        if GetTickCount - dwRunTick >= 1000 then
        begin
          dwRunTick := GetTickCount();
          if ThreadInfo.nRunTime > 0 then
            Dec(ThreadInfo.nRunTime);
        end;

        ThreadInfo.dwRunTick := GetTickCount();
        ThreadInfo.boActived := True;
        ThreadInfo.nRunFlag := 125;
        if (Config.DBSocket = INVALID_SOCKET) or (s = INVALID_SOCKET) then
        begin
          if Config.DBSocket <> INVALID_SOCKET then
          begin
            Config.DBSocket := INVALID_SOCKET;
            Sleep(100);
            ThreadInfo.nRunFlag := 126;
            Config.boDBSocketConnected := False;
          end;
          if s <> INVALID_SOCKET then
          begin

            closesocket(s);
            s := INVALID_SOCKET;
          end;
          if Config.sDBAddr = '' then
            Continue;

          s := socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
          if s = INVALID_SOCKET then
            Continue;

          ThreadInfo.nRunFlag := 127;

          HostEnt := gethostbyname(PChar(@Config.sDBAddr[1]));
          if HostEnt = nil then
            Continue;

          PInteger(@name.sin_addr.S_addr)^ := PInteger(HostEnt.h_addr^)^;
          name.sin_family := HostEnt.h_addrtype;
          name.sin_port := htons(Config.nDBPort);
          name.sin_family := PF_INET;

          ThreadInfo.nRunFlag := 128;
          if connect(s, name, SizeOf(name)) = SOCKET_ERROR then
          begin
            {nRet:=}WSAGetLastError;
            if boShow then
            begin
              boShow := False;
              MainOutMessage(format(sIDServerDisconnect, [Config.sDBAddr,
                Config.nDBPort]));
            end;
            closesocket(s);
            s := INVALID_SOCKET;
            Continue;
          end;
          argp := 1;
          if ioctlsocket(s, FIONBIO, argp) = SOCKET_ERROR then
          begin
            closesocket(s);
            s := INVALID_SOCKET;
            Continue;
          end;
          ThreadInfo.nRunFlag := 129;
          Config.DBSocket := s;
          Config.boDBSocketConnected := True;
          if not boShow then
          begin
            boShow := True;
            MainOutMessage(format(sIDServerConnected, [Config.sDBAddr,
              Config.nDBPort]));
          end;
        end;
        readfds.fd_count := 1;
        readfds.fd_array[0] := s;
        timeout.tv_sec := 0;
        timeout.tv_usec := 20;
        ThreadInfo.nRunFlag := 130;
        nRet := select(0, @readfds, nil, nil, @timeout);
        if nRet = SOCKET_ERROR then
        begin
          //
          ThreadInfo.nRunFlag := 131;
          nRet := WSAGetLastError;
          if nRet = WSAEWOULDBLOCK then
          begin
            Sleep(10);
            Continue;
          end;
          ThreadInfo.nRunFlag := 132;
          nRet := WSAGetLastError;
          Config.nDBSocketWSAErrCode := nRet - WSABASEERR;
          Inc(Config.nDBSocketErrorCount);
          Config.DBSocket := INVALID_SOCKET;
          Sleep(100);
          Config.boDBSocketConnected := False;
          closesocket(s);
          s := INVALID_SOCKET;
          Continue;
        end;
        boRecvData := True;
        ThreadInfo.nRunFlag := 133;
        while (nRet > 0) do
        begin
          //if nRet <= 0 then break;
          DBSocketRead(Config);
          Dec(nRet);
        end;
      end;
      if Config.DBSocket <> INVALID_SOCKET then
      begin
        Config.DBSocket := INVALID_SOCKET;
        Config.boDBSocketConnected := False;
      end;
      if s <> INVALID_SOCKET then
      begin
        closesocket(s);
      end;
    except
      MainOutMessage('[Exception] RunDB->DBSocketProcess');
    end;
  except
    MainOutMessage('[Exception] UnRunDB.DBSocketProcess');
  end;
end;

procedure DBSocketThread(ThreadInfo: pTThreadInfo); stdcall;
var
  nErrorCount: Integer;
resourcestring
  sExceptionMsg = '[Exception] DBSocketThread ErrorCount = %d';
begin
  try
    nErrorCount := 0;
    while True do
    begin
      try
        DBSocketProcess(ThreadInfo.Config, ThreadInfo);
        break;
      except
        Inc(nErrorCount);
        if nErrorCount > 10 then
          break;
        MainOutMessage(format(sExceptionMsg, [nErrorCount]));
      end;
    end;
    ExitThread(0);
  except
    MainOutMessage('[Exception] UnRunDB.DBSocketThread');
  end;
end;

function DBSocketConnected(): Boolean;
begin
  try
{$IF DBSOCKETMODE = TIMERENGINE}
    Result := FrmMain.DBSocket.Socket.Connected;
{$ELSE}
    Result := g_Config.boDBSocketConnected;
{$IFEND}
  except
    MainOutMessage('[Exception] UnRunDB.DBSocketConnected');
  end;
end;

function GetDBSockMsg(nQueryID: Integer; var nIdent: integer; var nRecog:
  integer; var sStr: string; dwTimeOut: LongWord; boLoadRcd: Boolean): Boolean;
var
  boLoadDBOK: Boolean;
  dwTimeOutTick: LongWord;
  s24, s28, s2C, sCheckFlag, sDefMsg, s38: string;
  nLen: Integer;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
resourcestring
  sLoadDBTimeOut = '[RunDB] 读取用户数据超时...';
  sSaveDBTimeOut = '[RunDB] 保存用户数据超时...';
begin
  try
    boLoadDBOK := False;
    Result := False;
    dwTimeOutTick := GetTickCount();
    while (True) do
    begin
      if (GetTickCount - dwTimeOutTick) > dwTimeOut then
      begin
        n4EBB6C := n4EBB68;
        break;
      end;
      s24 := '';
      EnterCriticalSection(UserDBSection);
      try
        if Pos('!', g_Config.sDBSocketRecvText) > 0 then
        begin
          s24 := g_Config.sDBSocketRecvText;
          g_Config.sDBSocketRecvText := '';
        end;
      finally
        LeaveCriticalSection(UserDBSection);
      end;
      if s24 <> '' then
      begin
        s28 := '';
        s24 := ArrestStringEx(s24, '#', '!', s28);
        if s28 <> '' then
        begin
          s28 := GetValidStr3(s28, s2C, ['/']);
          nLen := Length(s28);
          if (nLen >= SizeOf(TDefaultMessage)) and (Str_ToInt(s2C, 0) =
            LongWord(nQueryID)) then
          begin
            nCheckCode := MakeLong(Str_ToInt(s2C, 0) xor 170, nLen);
            sCheckFlag := EncodeBuffer(@nCheckCode, SizeOf(Integer));
            if CompareBackLStr(s28, sCheckFlag, Length(sCheckFlag)) then
            begin
              if nLen = DEFBLOCKSIZE then
              begin
                sDefMsg := s28;
                s38 := ''; // -> 004B3F56
              end
              else
              begin //004B3F1F
                sDefMsg := Copy(s28, 1, DEFBLOCKSIZE);
                s38 := Copy(s28, DEFBLOCKSIZE + 1, Length(s28) - DEFBLOCKSIZE -
                  6);
              end; //004B3F56
              DefMsg := DecodeMessage(sDefMsg);
              nIdent := DefMsg.Ident;
              nRecog := DefMsg.Recog;
              sStr := s38;
              boLoadDBOK := True;
              Result := True;
              break;
            end
            else
            begin //004B3F87
              Inc(g_Config.nLoadDBErrorCount); // -> 004B3FA5
              break;
            end;
          end
          else
          begin //004B3F90
            Inc(g_Config.nLoadDBErrorCount); // -> 004B3FA5
            break;
          end;
        end; //004B3FA5
      end
      else
      begin //004B3F99
        Sleep(1);
      end;
    end;
    //end;//004B3FA5
    if not boLoadDBOK then
    begin
      if boLoadRcd then
      begin
        MainOutMessage(sLoadDBTimeOut);
      end
      else
      begin
        MainOutMessage(sSaveDBTimeOut);
      end;
    end; //004B3FD7
    if (GetTickCount - dwTimeOutTick) > dwRunDBTimeMax then
    begin
      dwRunDBTimeMax := GetTickCount - dwTimeOutTick;
    end;
    g_Config.boDBSocketWorking := False;
  except
    MainOutMessage('[Exception] UnRunDB.GetDBSockMsg');
  end;
end;

function MakeHumRcdFromLocal(var HumanRcd: THumDataInfo): Boolean;
begin
  try
    FillChar(HumanRcd, SizeOf(THumDataInfo), #0);
    HumanRcd.Data.Abil.Level := 30;
    Result := True;
  except
    MainOutMessage('[Exception] UnRunDB.MakeHumRcdFromLocal');
  end;
end;

function LoadHumRcdFromDB(sAccount, sCharName, sStr: string; var HumanRcd:
  THumDataInfo; nCertCode: Integer; boHero: Boolean; nJob, nMan: Byte): Boolean;
  //004B3A68
begin
  try
    Result := False;
    FillChar(HumanRcd, SizeOf(THumDataInfo), #0);
    if LoadRcd(sAccount, sCharName, sStr, nCertCode, HumanRcd, boHero, nJob,
      nMan) then
    begin
      if (HumanRcd.Data.sChrName = sCharName) and ((HumanRcd.Data.sAccount = '')
        or (HumanRcd.Data.sAccount = sAccount)) then
        Result := True;
    end;
    Inc(g_Config.nLoadDBCount);
  except
    MainOutMessage('[Exception] UnRunDB.LoadHumRcdFromDB');
  end;
end;

function SaveHumRcdToDB(sAccount, sCharName: string; nSessionID: Integer; var
  HumanRcd: THumDataInfo): Boolean; //004B3B5C
begin
  try
    Result := SaveRcd(sAccount, sCharName, nSessionID, HumanRcd);
    Inc(g_Config.nSaveDBCount);
  except
    MainOutMessage('[Exception] UnRunDB.SaveHumRcdToDB');
  end;
end;

function SaveRcd(sAccount, sCharName: string; nSessionID: Integer; var HumanRcd:
  THumDataInfo): Boolean; //004B42C8
var
  nQueryID: Integer;
  nIdent: Integer;
  nRecog: Integer;
  sStr: string;
begin
  try
    nQueryID := GetQueryID(@g_Config);
    Result := False;
    n4EBB68 := DB_SAVEHUMANRCD;
    SendDBSockMsg(nQueryID, EncodeMessage(MakeDefaultMsg(DB_SAVEHUMANRCD,
      nSessionID, 0, 0, 0)) + EncodeString(sAccount) + '/' +
      EncodeString(sCharName) + '/' + EncodeBuffer(@HumanRcd,
      SizeOf(THumDataInfo)));
    if GetDBSockMsg(nQueryID, nIdent, nRecog, sStr, 5000, False) then
    begin
      if (nIdent = DBR_SAVEHUMANRCD) and (nRecog = 1) then
        Result := True;
    end;
  except
    MainOutMessage('[Exception] UnRunDB.SaveRcd');
  end;
end;

procedure SendDefCorps(SendCorpsRcdInfo: TSendCorpsRcdInfo);
var
  Defmsg: TDefaultMessage;
  nQueryID: Integer;
  sDBMsg: string;
begin
  try
    nQueryID := GetQueryID(@g_Config);
    DefMsg := MakeDefaultMsg(DB_CORPSRCD, 0, 0, 0, 0);
    sDBMsg := EncodeMessage(DefMsg) + EncodeBuffer(@SendCorpsRcdInfo,
      SizeOf(TSendCorpsRcdInfo));
    n4EBB68 := DB_CORPSRCD;
    SendDBSockMsg(nQueryID, sDBMsg);
  except
    MainOutMessage('[Exception] UnRunDB.SendDefCorps');
  end;
end;

function CreateNewHeroHum(sAccount, sCharName: string; nJob, nMan: Byte; var
  nMsg: Integer; sMaster: string): Boolean;
var
  Defmsg: TDefaultMessage;
  LoadHuman: TLoadHuman;
  nQueryID: Integer;
  nIdent, nRecog: Integer;
  sDBMsg, sHumanRcdStr: string;
begin
  try
    Result := False;
    nMsg := -1;
    try
      nQueryID := GetQueryID(@g_Config);
      DefMsg := MakeDefaultMsg(DB_NEWHEROHUM, 0, 0, 0, 0);
      LoadHuman.sAccount := sAccount;
      LoadHuman.sChrName := sCharName;
      LoadHuman.boHero := True;
      LoadHuman.nHeroJob := nJob;
      LoadHuman.nHeroMan := nMan;
      LoadHuman.sHeroMaster := sMaster;

      sDBMsg := EncodeMessage(DefMsg) + EncodeBuffer(@LoadHuman,
        SizeOf(TLoadHuman));
      n4EBB68 := DB_NEWHEROHUM;

      SendDBSockMsg(nQueryID, sDBMsg); //发送数据到DBServer
      if GetDBSockMsg(nQueryID, nIdent, nRecog, sHumanRcdStr, 5000, True) then
      begin
        if nIdent = DB_NEWHEROHUM then
        begin
          nMsg := nRecog;
        end;
      end;
    except
      MainOutMessage('[Exception] CreateNewHeroHum ' + IntToStr(nMsg));
    end;
  except
    MainOutMessage('[Exception] UnRunDB.CreateNewHeroHum');
  end;
end;

function LoadRcd(sAccount, sCharName, sStr: string; nCertCode: Integer; var
  HumanRcd: THumDataInfo; boHero: Boolean; nJob, nMan: Byte): Boolean;
var
  Defmsg: TDefaultMessage;
  LoadHuman: TLoadHuman;
  nQueryID: Integer;
  nIdent, nRecog: Integer;
  sHumanRcdStr: string;
  sDBMsg, sDBCharName: string;
begin
  try
    Result := False;
    nQueryID := GetQueryID(@g_Config);
    DefMsg := MakeDefaultMsg(DB_LOADHUMANRCD, 0, 0, 0, 0);
    LoadHuman.sAccount := sAccount;
    LoadHuman.sChrName := sCharName;
    LoadHuman.sUserAddr := sStr;
    LoadHuman.nSessionID2 := nCertCode;
    LoadHuman.boHero := boHero;
    LoadHuman.nHeroJob := nJob;
    LoadHuman.nHeroMan := nMan;

    sDBMsg := EncodeMessage(DefMsg) + EncodeBuffer(@LoadHuman,
      SizeOf(TLoadHuman));
    n4EBB68 := DB_LOADHUMANRCD;

    {MainOutMessage('Send DB Socket Load HumRcd Msg ... ' +
                   LoadHuman.sAccount + '/' +
                   LoadHuman.sChrName + '/' +
                   LoadHuman.sUserAddr + '/' +
                   IntToStr(LoadHuman.nSessionID));}

    //Mainoutmessage('2');
    SendDBSockMsg(nQueryID, sDBMsg); //发送数据到DBServer
    //Mainoutmessage('3');
    if GetDBSockMsg(nQueryID, nIdent, nRecog, sHumanRcdStr, 5000, True) then
    begin
      //Mainoutmessage('4');
      if nIdent = DBR_LOADHUMANRCD then
      begin
        if nRecog = 1 then
        begin
          sHumanRcdStr := GetValidStr3(sHumanRcdStr, sDBMsg, ['/']);
          //        MainOutMessage(s24);
          sDBCharName := DecodeString(sDBMsg);

          if sDBCharName = sCharName then
          begin
            if GetCodeMsgSize(SizeOf(THumDataInfo) * 4 / 3) =
              length(sHumanRcdStr) then
            begin
              DecodeBuffer(sHumanRcdStr, @HumanRcd, SizeOf(THumDataInfo));
              Result := True;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] UnRunDB.LoadRcd');
  end;
end;
//004B3BEC

procedure SendDBSockMsg(nQueryID: Integer; sMsg: string);
var
  sSendMsg: string;
  nCheckCode: Integer;
  sCheckStr: string;
  boSendData: Boolean;
  Config: pTM2Config;
  ThreadInfo: pTThreadInfo;
  timeout: TTimeVal;
  writefds: TFDSet;
  nRet: Integer;
  s: TSocket;
begin
  try
    Config := @g_Config;
    ThreadInfo := @g_Config.DBSocketThread;
    if not DBSocketConnected then
      exit;
    EnterCriticalSection(UserDBSection);
    try
      Config.sDBSocketRecvText := '';
    finally
      LeaveCriticalSection(UserDBSection);
    end;
    nCheckCode := MakeLong(nQueryID xor 170, length(sMsg) + 6);
    sCheckStr := EncodeBuffer(@nCheckCode, SizeOf(Integer));
    sSendMsg := '#' + IntToStr(nQueryID) + '/' + sMsg + sCheckStr + '!';
    Config.boDBSocketWorking := True;
{$IF DBSOCKETMODE = TIMERENGINE}
    FrmMain.DBSocket.Socket.SendText(sSendMsg);
{$ELSE}

    s := Config.DBSocket;
    boSendData := False;
    while True do
    begin
      if not boSendData then
        Sleep(10)
      else
        Sleep(0);
      boSendData := False;
      ThreadInfo.dwRunTick := GetTickCount();
      ThreadInfo.boActived := True;
      ThreadInfo.nRunFlag := 128;

      ThreadInfo.nRunFlag := 129;
      timeout.tv_sec := 0;
      timeout.tv_usec := 20;

      writefds.fd_count := 1;
      writefds.fd_array[0] := s;

      nRet := select(0, nil, @writefds, nil, @timeout);
      if nRet = SOCKET_ERROR then
      begin
        nRet := WSAGetLastError();
        Config.nDBSocketWSAErrCode := nRet - WSABASEERR;
        Inc(Config.nDBSocketErrorCount);
        if nRet = WSAEWOULDBLOCK then
        begin
          Continue;
        end;
        if Config.DBSocket = INVALID_SOCKET then
          break;
        Config.DBSocket := INVALID_SOCKET;
        Sleep(100);
        Config.boDBSocketConnected := False;
        break;
      end;
      if nRet <= 0 then
      begin
        Continue;
      end;
      //boSendData:=True;
      nRet := send(s, sSendMsg[1], length(sSendMsg), 0);
      if nRet = SOCKET_ERROR then
      begin
        Inc(Config.nDBSocketErrorCount);
        Config.nDBSocketWSAErrCode := WSAGetLastError - WSABASEERR;
        Continue;
      end;
      Inc(Config.nDBSocketSendLen, nRet);
      break;
    end;
{$IFEND}

  except
    MainOutMessage('[Exception] UnRunDB.SendDBSockMsg');
  end;
end;

//004E3E04

function GetQueryID(Config: pTM2Config): Integer;
begin
  try
    Inc(Config.nDBQueryID);
    if Config.nDBQueryID > high(SmallInt) - 1 then
      Config.nDBQueryID := 1;
    Result := Config.nDBQueryID;
  except
    MainOutMessage('[Exception] UnRunDB.GetQueryID');
  end;
end;

end.

