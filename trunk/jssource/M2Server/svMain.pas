//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit svMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JSocket, ExtCtrls, Buttons, StdCtrls, IniFiles, M2Share,
  Grobal2, SDK, HUtil32, RunSock, Envir, ItmUnit, Magic, NoticeM, Guild, Event,
  Castle, FrnEngn, UsrEngn, MudUtil, SyncObjs, Menus, ComCtrls, Grids, MD5Unit,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, Shopping, RSA,
  VCLUnZip, VCLZip;

type
  TFrmMain = class(TForm)
    MemoLog: TMemo;
    Timer1: TTimer;
    RunTimer: TTimer;
    DBSocket: TClientSocket;
    ConnectTimer: TTimer;
    StartTimer: TTimer;
    SaveVariableTimer: TTimer;
    CloseTimer: TTimer;
    MainMenu: TMainMenu;
    MENU_CONTROL: TMenuItem;
    MENU_CONTROL_START: TMenuItem;
    MENU_CONTROL_STOP: TMenuItem;
    MENU_CONTROL_EXIT: TMenuItem;
    MENU_CONTROL_RELOAD_CONF: TMenuItem;
    MENU_CONTROL_CLEARLOGMSG: TMenuItem;
    MENU_HELP: TMenuItem;
    MENU_HELP_ABOUT: TMenuItem;
    MENU_MANAGE: TMenuItem;
    MENU_CONTROL_RELOAD: TMenuItem;
    MENU_CONTROL_RELOAD_ITEMDB: TMenuItem;
    MENU_CONTROL_RELOAD_MAGICDB: TMenuItem;
    MENU_CONTROL_RELOAD_MONSTERDB: TMenuItem;
    MENU_OPTION: TMenuItem;
    MENU_OPTION_GENERAL: TMenuItem;
    MENU_OPTION_SERVERCONFIG: TMenuItem;
    MENU_OPTION_GAME: TMenuItem;
    MENU_OPTION_FUNCTION: TMenuItem;
    MENU_CONTROL_RELOAD_MONSTERSAY: TMenuItem;
    MENU_CONTROL_RELOAD_DISABLEMAKE: TMenuItem;
    MENU_CONTROL_GATE: TMenuItem;
    MENU_CONTROL_GATE_OPEN: TMenuItem;
    MENU_CONTROL_GATE_CLOSE: TMenuItem;
    MENU_VIEW: TMenuItem;
    MENU_VIEW_GATE: TMenuItem;
    MENU_VIEW_SESSION: TMenuItem;
    MENU_VIEW_ONLINEHUMAN: TMenuItem;
    MENU_VIEW_LEVEL: TMenuItem;
    MENU_VIEW_LIST: TMenuItem;
    MENU_MANAGE_ONLINEMSG: TMenuItem;
    MENU_VIEW_KERNELINFO: TMenuItem;
    MENU_TOOLS: TMenuItem;
    MENU_TOOLS_MERCHANT: TMenuItem;
    MENU_TOOLS_NPC: TMenuItem;
    MENU_OPTION_ITEMFUNC: TMenuItem;
    MENU_TOOLS_MONGEN: TMenuItem;
    MENU_CONTROL_RELOAD_STARTPOINT: TMenuItem;
    G1: TMenuItem;
    MENU_OPTION_MONSTER: TMenuItem;
    MENU_TOOLS_IPSEARCH: TMenuItem;
    MENU_MANAGE_CASTLE: TMenuItem;
    GridGate: TStringGrid;
    Panel1: TPanel;
    LbUserCount: TLabel;
    LbRunTime: TLabel;
    Label20: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    UDPClient: TIdUDPClient;
    MENU_MANAGE_GUILD: TMenuItem;
    MENU_MANAGE_PLUG: TMenuItem;
    S1: TMenuItem;
    MENU_VIEW_LIST2: TMenuItem;
    PCTimeCount: TLabel;
    LabelMon: TLabel;
    LabelVersion: TLabel;
    N1: TMenuItem;
    N2: TMenuItem;
    MENU_CONTROL_RELOAD_MANAGE: TMenuItem;
    MENU_CONTROL_RELOAD_FUN: TMenuItem;
    MENU_CONTROL_CLEARSERVERVAR: TMenuItem;
    MENU_CONTROL_RELOAD_BOXS: TMenuItem;
    LabelTxt: TRSA;
    ipper: TVCLZip;
    Label3: TLabel;
    MENU_CONTROL_RELOAD_CASTLE: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure MemoLogChange(Sender: TObject);
    procedure MemoLogDblClick(Sender: TObject);
    procedure MENU_CONTROL_EXITClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_CONFClick(Sender: TObject);
    procedure MENU_CONTROL_CLEARLOGMSGClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_ITEMDBClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_MAGICDBClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_MONSTERDBClick(Sender: TObject);
    procedure MENU_CONTROL_STARTClick(Sender: TObject);
    procedure MENU_CONTROL_STOPClick(Sender: TObject);
    procedure MENU_HELP_ABOUTClick(Sender: TObject);
    procedure MENU_OPTION_SERVERCONFIGClick(Sender: TObject);
    procedure MENU_OPTION_GENERALClick(Sender: TObject);
    procedure MENU_OPTION_GAMEClick(Sender: TObject);
    procedure MENU_OPTION_FUNCTIONClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_MONSTERSAYClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_DISABLEMAKEClick(Sender: TObject);
    procedure MENU_CONTROL_GATE_OPENClick(Sender: TObject);
    procedure MENU_CONTROL_GATE_CLOSEClick(Sender: TObject);
    procedure MENU_CONTROLClick(Sender: TObject);
    procedure MENU_VIEW_GATEClick(Sender: TObject);
    procedure MENU_VIEW_SESSIONClick(Sender: TObject);
    procedure MENU_VIEW_ONLINEHUMANClick(Sender: TObject);
    procedure MENU_VIEW_LEVELClick(Sender: TObject);
    procedure MENU_VIEW_LISTClick(Sender: TObject);
    procedure MENU_MANAGE_ONLINEMSGClick(Sender: TObject);
    procedure MENU_VIEW_KERNELINFOClick(Sender: TObject);
    procedure MENU_TOOLS_MERCHANTClick(Sender: TObject);
    procedure MENU_OPTION_ITEMFUNCClick(Sender: TObject);
    procedure MENU_TOOLS_MONGENClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_STARTPOINTClick(Sender: TObject);
    procedure G1Click(Sender: TObject);
    procedure MENU_OPTION_MONSTERClick(Sender: TObject);
    procedure MENU_TOOLS_IPSEARCHClick(Sender: TObject);
    procedure MENU_MANAGE_CASTLEClick(Sender: TObject);
    procedure MENU_MANAGE_PLUGClick(Sender: TObject);
    procedure MENU_VIEW_LIST2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure MENU_MANAGE_GUILDClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_MANAGEClick(Sender: TObject);
    procedure MENU_CONTROL_CLEARSERVERVAR_INTEGERClick(Sender: TObject);
    procedure MENU_CONTROL_CLEARSERVERVAR_STRINGClick(Sender: TObject);
    procedure MENU_CONTROL_CLEARSERVERVARClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_BOXSClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_CASTLEClick(Sender: TObject);
  private
    boServiceStarted: Boolean;
    SoftRunTime: LongWord;
    procedure GateSocketClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure GateSocketClientDisconnect(Sender: TObject; Socket:
      TCustomWinSocket);
    procedure GateSocketClientConnect(Sender: TObject; Socket:
      TCustomWinSocket);
    procedure GateSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure DBSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure DBSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure DBSocketRead(Sender: TObject; Socket: TCustomWinSocket);

    procedure Timer1Timer(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure SaveVariableTimerTimer(Sender: TObject);
    procedure RunTimerTimer(Sender: TObject);
    procedure ConnectTimerTimer(Sender: TObject);

    procedure StartService();
    procedure StopService();
    procedure SaveItemNumber(boStop: Boolean);
    function LoadClientFile(): Boolean;
    procedure StartEngine;
    //    procedure MakeStoneMines;
    procedure ReloadConfig(Sender: TObject);
    procedure ClearMemoLog();

    procedure MyClose();
  public

    GateSocket: TServerSocket;
    procedure CloseGateSocket();
    procedure AppOnIdle(Sender: TObject; var Done: Boolean);
    procedure OnProgramException(Sender: TObject; E: Exception);
    procedure SetMenu(); virtual;
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;
    { Public declarations }
  end;

function LoadAbuseInformation(FileName: string): Boolean;
procedure LoadServerTable();
procedure WriteConLog(MsgList: TStringList);
procedure ChangeCaptionText(Msg: PChar; nLen: Integer); stdcall;
procedure UserEngineThread(ThreadInfo: pTThreadInfo); stdcall;
procedure ProcessGameRun();

var
  FrmMain: TFrmMain;
  g_GateSocket: TServerSocket;
  m_nSaveIdx: Word;
implementation
uses
  LocalDB, InterServerMsg, InterMsgClient, IdSrvClient, FSrvValue,
  GeneralConfig, GameConfig, FunctionConfig, ObjRobot, ViewSession,
  ViewOnlineHuman, ViewLevel, ViewList, OnlineMsg, ViewKernelInfo,
  ConfigMerchant, ItemSet, ConfigMonGen, EDcode, EncryptUnit,
  GameCommand, MonsterConfig, RunDB, CastleManage, PlugShare, FrmPlug,
  ViewList2, CenterShare, FrmAbout, FrmTaxis, ImageHlp, FrmGuild, M2Plug,
    FindMapPath,GloblVal, ObjBase, PlacingItem, DES, ObjMon2;
var
  sCaption: string;
  sCaptionExtText: string;
  l_dwRunTimeTick: LongWord;
  boRemoteOpenGateSocket: Boolean = False;
  boRemoteOpenGateSocketed: Boolean = False;
  dwSortArrayTick: LongWord;
  dwPlacingItemTick: LongWord;
  //sChar:String = 'Char';
  //sRun:String = 'Run';
{$R *.dfm}

procedure ChangeCaptionText(Msg: PChar; nLen: Integer); stdcall;
var
  sMsg: string;
begin
  try
    try
      if (nLen > 0) and (nLen < 30) then
      begin
        setlength(sMsg, nLen);
        Move(Msg^, sMsg[1], nLen);
        sCaptionExtText := sMsg;
      end;
    except
      MainOutMessage('[Exception] svMain nIdx 1');
    end;
  except
    MainOutMessage('[Exception] UnsvMain.ChangeCaptionText');
  end;
end;

function LoadAbuseInformation(FileName: string): Boolean;
var
  i: integer;
  sText: string;
begin
  try
    try
      Result := False;
      if FileExists(FileName) then
      begin
        AbuseTextList.Clear;
        AbuseTextList.LoadFromFile(FileName);
        i := 0;
        while (True) do
        begin
          if AbuseTextList.Count <= i then
            break;
          sText := Trim(AbuseTextList.Strings[i]);
          if sText = '' then
          begin
            AbuseTextList.Delete(i);
            Continue;
          end;
          Inc(i);
        end;
        Result := True;
      end;
    except
      MainOutMessage('[Exception] svMain nIdx 2');
    end;
  except
    MainOutMessage('[Exception] UnsvMain.LoadAbuseInformation');
  end;
end;

procedure LoadServerTable(); //004E3E64
var
  i, ii: Integer;
  LoadList: TStringList;
  GateList: TStringList;
  //SrvNetInfo:pTSrvNetInfo;
  sLineText, sGateMsg: string;
  sIPaddr, sPort: string;
begin
  try
    try
      for I := 0 to ServerTableList.Count - 1 do
      begin
        TList(ServerTableList.Items[I]).Free;
      end;
      ServerTableList.Clear;
      if FileExists('.\!servertable.txt') then
      begin
        LoadList := TStringList.Create;
        LoadList.LoadFromFile('.\!servertable.txt');
        for I := 0 to LoadList.Count - 1 do
        begin
          sLineText := Trim(LoadList.Strings[i]);
          if (sLineText <> '') and (sLineText[1] <> ';') then
          begin
            sGateMsg := Trim(GetValidStr3(sLineText, sGateMsg, [' ', #9]));
            if sGateMsg <> '' then
            begin
              GateList := TStringList.Create;
              for II := 0 to 30 do
              begin
                if sGateMsg = '' then
                  break;
                sGateMsg := Trim(GetValidStr3(sGateMsg, sIPaddr, [' ', #9]));
                sGateMsg := Trim(GetValidStr3(sGateMsg, sPort, [' ', #9]));
                if (sIPaddr <> '') and (sPort <> '') then
                begin
                  GateList.AddObject(sIPaddr, TObject(Str_ToInt(sPort, 0)));
                end;
              end;
              ServerTableList.Add(GateList);
            end;
          end;
        end;
        LoadList.Free;
      end
      else
      begin
        ShowMessage('!servertable.txt 文件不存在...');
      end;
    except
      MainOutMessage('[Exception] svMain nIdx 3');
    end;
  except
    MainOutMessage('[Exception] UnsvMain.LoadServerTable');
  end;
end;

procedure WriteConLog(MsgList: TStringList);
var
  I: Integer;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  sLogDir, sLogFileName: string;
  LogFile: TextFile;
begin
  try
    try
      if MsgList.Count <= 0 then
        exit;
      DecodeDate(Date, Year, Month, Day);
      DecodeTime(Time, Hour, Min, Sec, MSec);
      if not DirectoryExists(g_Config.sConLogDir) then
      begin
        //CreateDirectory(PChar(g_Config.sConLogDir),nil);
        CreateDir(g_Config.sConLogDir);
      end;
      sLogDir := g_Config.sConLogDir + IntToStr(Year) + '-' + IntToStr2(Month) +
        '-' + IntToStr2(Day);
      if not DirectoryExists(sLogDir) then
      begin
        CreateDirectory(PChar(sLogDir), nil);
      end;
      sLogFileName := sLogDir + '\C-' + IntToStr(nServerIndex) + '-' +
        IntToStr2(Hour) + 'H' + IntToStr2((Min div 10 * 2) * 5) + 'M.txt';
      AssignFile(LogFile, sLogFileName);
      if not FileExists(sLogFileName) then
      begin
        Rewrite(LogFile);
      end
      else
      begin
        Append(LogFile);
      end;
      for I := 0 to MsgList.Count - 1 do
      begin
        WriteLn(LogFile, '1' + #9 + MsgList.Strings[I]);
      end; // for
      CloseFile(LogFile);
    except
      MainOutMessage('[Exception] svMain nIdx 4');
    end;
  except
    MainOutMessage('[Exception] UnsvMain.WriteConLog');
  end;
end;

procedure TFrmMain.SaveItemNumber(boStop: Boolean);
var
  I: Integer;
begin
  try
    try
      Config.WriteInteger('Setup', 'ItemNumber', g_Config.nItemNumber);
      Config.WriteInteger('Setup', 'ItemNumberEx', g_Config.nItemNumberEx);
      if boStop then
      begin
        for I := Low(g_Config.GlobalVal) to High(g_Config.GlobalVal) do
        begin
          Config.WriteInteger('Setup', 'GlobalVal' + IntToStr(I),
            g_Config.GlobalVal[I])
        end;
        for I := Low(g_Config.GlobalStrVal) to High(g_Config.GlobalStrVal) do
        begin
          Config.WriteString('Setup', 'GlobalStrVal' + IntToStr(I),
            g_Config.GlobalStrVal[I])
        end;
      end
      else
      begin
        for I := 0 to 30 do
        begin
          if m_nSaveIdx > High(g_Config.GlobalVal) then
            m_nSaveIdx := Low(g_Config.GlobalVal);
          Config.WriteInteger('Setup', 'GlobalVal' + IntToStr(m_nSaveIdx),
            g_Config.GlobalVal[m_nSaveIdx]);
          Config.WriteString('Setup', 'GlobalStrVal' + IntToStr(m_nSaveIdx),
            g_Config.GlobalStrVal[m_nSaveIdx]);
          Inc(m_nSaveIdx);
        end;
      end;
      Config.WriteInteger('Setup', 'WinLotteryCount',
        g_Config.nWinLotteryCount);
      Config.WriteInteger('Setup', 'NoWinLotteryCount',
        g_Config.nNoWinLotteryCount);
      Config.WriteInteger('Setup', 'WinLotteryLevel1',
        g_Config.nWinLotteryLevel1);
      Config.WriteInteger('Setup', 'WinLotteryLevel2',
        g_Config.nWinLotteryLevel2);
      Config.WriteInteger('Setup', 'WinLotteryLevel3',
        g_Config.nWinLotteryLevel3);
      Config.WriteInteger('Setup', 'WinLotteryLevel4',
        g_Config.nWinLotteryLevel4);
      Config.WriteInteger('Setup', 'WinLotteryLevel5',
        g_Config.nWinLotteryLevel5);
      Config.WriteInteger('Setup', 'WinLotteryLevel6',
        g_Config.nWinLotteryLevel6);

    except

    end;
  except
    MainOutMessage('[Exception] TFrmMain.SaveItemNumber');
  end;
end;

procedure TFrmMain.AppOnIdle(Sender: TObject; var Done: Boolean);
begin
  try
    //   MainOutMessage ('空闲');
  except
    MainOutMessage('[Exception] TFrmMain.AppOnIdle');
  end;
end;

procedure TFrmMain.OnProgramException(Sender: TObject; E: Exception);
resourcestring
  sException = '[Exception] TFrmMain.OnProgramException';
begin
  try
    //  MainOutMessage(sException);
    MainOutMessage(E.Message);
  except
    MainOutMessage('[Exception] TFrmMain.OnProgramException');
  end;
end;

procedure TFrmMain.DBSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  try
    ErrorCode := 0;
    Socket.Close;
  except
    MainOutMessage('[Exception] TFrmMain.DBSocketError');
  end;
end;

procedure TFrmMain.DBSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
  tStr: string;
begin
  try
    try
      EnterCriticalSection(UserDBSection);
      try
        tStr := Socket.ReceiveText;
        g_Config.sDBSocketRecvText := g_Config.sDBSocketRecvText + tStr;

        if not g_Config.boDBSocketWorking then
        begin
          g_Config.sDBSocketRecvText := '';
        end;
      finally
        LeaveCriticalSection(UserDBSection);
      end;
    except
      MainOutMessage('[Exception] svMain nIdx 5');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.DBSocketRead');
  end;
end;

procedure TFrmMain.Timer1Timer(Sender: TObject); //004E5418
var
  boWriteLog: Boolean;
  i: Integer;
  nRow: Integer;
  wHour: Word;
  wMinute: Word;
  wSecond: Word;
  tSecond: Integer;
  sSrvType: string;
  tTimeCount: Currency;
  GateInfo: pTGateInfo;
  nCheckIdx: Byte;
  //  sGate,tGate      :String;
  LogFile: TextFile;
  //MemoryStream:TMemoryStream;
  s28: string;
begin
  try
    //  Caption:=sCaption + ' [' + sCaptionExtText + ']';
      //Caption:= format('%s - %s',[g_sTitleName,sCaption]);
    nCheckIdx := 0;
    try
      Caption := sCaption;
      nCheckIdx := 1;
      EnterCriticalSection(LogMsgCriticalSection);
      try
        nCheckIdx := 2;
        if MemoLog.Lines.Count > 500 then
          MemoLog.Clear;
        nCheckIdx := 3;
        boWriteLog := True;
        nCheckIdx := 4;
        if MainLogMsgList.Count > 0 then
        begin
          try
            nCheckIdx := 5;
            if not FileExists(sLogFileName) then
            begin
              nCheckIdx := 6;
              AssignFile(LogFile, sLogFileName);
              Rewrite(LogFile);
            end
            else
            begin
              nCheckIdx := 7;
              AssignFile(LogFile, sLogFileName);
              Append(LogFile);
            end;
            boWriteLog := False;
          except
            MemoLog.Lines.Add('保存日志文件失败...');
          end;
        end;
        nCheckIdx := 8;
        for i := 0 to MainLogMsgList.Count - 1 do
        begin
          nCheckIdx := 9;
          MemoLog.Lines.Add(MainLogMsgList.Strings[i]);
          nCheckIdx := 10;
          if not boWriteLog then
          begin
            Writeln(LogFile, MainLogMsgList.Strings[i]);
          end;
          nCheckIdx := 11;
        end;
        nCheckIdx := 12;
        MainLogMsgList.Clear;
        nCheckIdx := 13;
        if not boWriteLog then
          CloseFile(LogFile);
        nCheckIdx := 14;
        for I := 0 to LogStringList.Count - 1 do
        begin
          nCheckIdx := 15;
          s28 := LogStringList.Strings[I] + #9 + '1' + #9 +
            IntToStr(g_Config.nServerNumber) + #9 + IntToStr(nServerIndex);
          nCheckIdx := 16;
          try
            UdpClient.Send(s28);
          except
            on E: Exception do
              MainOutMessage(E.Message);
          end;
          {MemoryStream:=TMemoryStream.Create;
          try
            s28:='1' + #9 + IntToStr(g_Config.nServerNumber) + #9 + IntToStr(nServerIndex) + #9 + LogStringList.Strings[I];
            //MainOutMessage(s28);
            MemoryStream.Write(s28[1],length(s28));
            //UdpClient.sen
            //LogUDP.SendStream(MemoryStream);          LMEDIT
           // UDPClient.sen
          finally
            MemoryStream.Free;
          end;}
        end;
        nCheckIdx := 17;
        LogStringList.Clear;
        nCheckIdx := 18;
        if LogonCostLogList.Count > 0 then
        begin
          WriteConLog(LogonCostLogList);
        end;
        nCheckIdx := 19;
        LogonCostLogList.Clear;
      finally
        LeaveCriticalSection(LogMsgCriticalSection);
      end;

      nCheckIdx := 20;
      if nServerIndex = 0 then
      begin
        sSrvType := '[M]';
      end
      else
      begin
        nCheckIdx := 21;
        if FrmMsgClient.MsgClient.Socket.Connected then
        begin
          sSrvType := '[S]';
        end
        else
        begin
          sSrvType := '[ ]';
        end;
      end;
      //LabelMemCount.Font.Color:=clMaroon;
      //LabelMemCount.Caption:=Format('内存 %f M',[AllocMemSize/1024/1024]);
      //检查线程 运行时间
      //g_dwEngineRunTime:=GetTickCount - g_dwEngineTick;
      nCheckIdx := 22;
      tSecond := (GetTickCount() - g_dwStartTick) div 1000;
      wHour := tSecond div 3600;
      wMinute := (tSecond div 60) mod 60;
      wSecond := tSecond mod 60;
      g_dwHorseTick := wHour;
      nCheckIdx := 23;
      LbRunTime.Caption := IntToStr(wHour) + ':' +
        IntToStr(wMinute) + ':' +
        IntToStr(wSecond) + ' ' + sSrvType; { +
      IntToStr(g_dwEngineRunTime) + g_sProcessName + '-' + g_sOldProcessName;}
      nCheckIdx := 24;
      LbUserCount.Caption := Format('(%d)   [%d/%d][%d/%d][%d/%d]',
        [UserEngine.MonsterCount,
        UserEngine.PlayObjectCount,
          UserEngine.MaxHumCount,
          UserEngine.HeroObjectCount,
          UserEngine.MaxHerCount,
          UserEngine.LoadPlayCount,
          UserEngine.m_PlayObjectFreeList.Count]);
      {LbUserCount.Caption:= '(' + IntToStr(UserEngine.MonsterCount) + ')   ' +
                            IntToStr(UserEngine.HeroObjectCount) + '/' +
                            IntToStr(UserEngine.OnlinePlayObject) + '/' +
                            IntToStr(UserEngine.PlayObjectCount) + '[' +
                            IntToStr(UserEngine.LoadPlayCount) + '/' +
                            IntToStr(UserEngine.m_PlayObjectFreeList.Count) + ']'; }
      {
      Label1.Caption:= 'Run' + IntToStr(nRunTimeMin) + '/' + IntToStr(nRunTimeMax) + ' ' +
                       'Soc' + IntToStr(g_nSockCountMin) + '/' + IntToStr(g_nSockCountMax) + ' ' +
                       'Usr' + IntToStr(g_nUsrTimeMin) + '/' + IntToStr(g_nUsrTimeMax);
      }
      nCheckIdx := 25;
      LabelVersion.Font.Color := clBlue;
      LabelVersion.Caption := g_sVersion;
      nCheckIdx := 26;
      Label1.Caption := format('Run:%d/%d Soc:%d/%d Usr:%d/%d Mem:%d/%d',
        [nRunTimeMin, nRunTimeMax, g_nSockCountMin, g_nSockCountMax,
        g_nUsrTimeMin2, g_nUsrTimeMax2, g_MemErrorCount, g_MsgErrorCount]);
      {
      Label2.Caption:= 'Hum' + IntToStr(g_nHumCountMin) + '/' + IntToStr(g_nHumCountMax) + ' ' +
                       'Mon' + IntToStr(g_nMonTimeMin) + '/' + IntToStr(g_nMonTimeMax) + ' ' +
                       'UsrRot' + IntToStr(dwUsrRotCountMin) + '/' + IntToStr(dwUsrRotCountMax) + ' ' +
                       'Merch' + IntToStr(UserEngine.dwProcessMerchantTimeMin) + '/' + IntToStr(UserEngine.dwProcessMerchantTimeMax) + ' ' +
                       'Npc' + IntToStr(UserEngine.dwProcessNpcTimeMin) + '/' + IntToStr(UserEngine.dwProcessNpcTimeMax) + ' ' +
                       '(' + IntToStr(g_nProcessHumanLoopTime) + ')';
      }
      nCheckIdx := 27;
      Label2.Caption :=
        format('Hum:%d/%d UsrRot:%d/%d Merch:%d/%d Npc:%d/%d (%d)',
        [g_nHumCountMin2,
        g_nHumCountMax2,
          dwUsrRotCountMin,
          dwUsrRotCountMax2,
          UserEngine.dwProcessMerchantTimeMin,
          UserEngine.dwProcessMerchantTimeMax,
          UserEngine.dwProcessNpcTimeMin,
          UserEngine.dwProcessNpcTimeMax,
          Integer(g_Config.boJsCheckFail)]);

      Label3.Caption := format('%s,%d/%d/-%s,%d/%d/', [dwMerchantGoodsName,
        dwMerchantGoodsTimeMin,
          dwMerchantGoodsTimeMax,
          dwMerchantDataName,
          dwMerchantDataTimeMin,
          dwMerchantDataTimeMax]);
      {
      Label20.Caption:='MonG' + IntToStr(g_nMonGenTime) + '/' + IntToStr(g_nMonGenTimeMin) + '/' + IntToStr(g_nMonGenTimeMax) + ' ' +
                       'MonP' + IntToStr(g_nMonProcTime) + '/' + IntToStr(g_nMonProcTimeMin) + '/' + IntToStr(g_nMonProcTimeMax) + ' ' +
                       'ObjRun' + IntToStr(g_nBaseObjTimeMin) + '/' + IntToStr(g_nBaseObjTimeMax);
      }
      nCheckIdx := 28;
      Label20.Caption :=
        format('MonG:%d/%d/%d MonP:%d/%d/%d ObjRun:%d/%d Hero:%d/%d',
        [g_nMonGenTime,
        g_nMonGenTimeMin,
          g_nMonGenTimeMax,
          g_nMonProcTime,
          g_nMonProcTimeMin,
          g_nMonProcTimeMax,
          g_nBaseObjTimeMin,
          g_nBaseObjTimeMax,
          g_nHeroCountMin,
          g_nHeroCountMax]);
      nCheckIdx := 29;
      tTimeCount := GetTickCount() / (24 * 60 * 60 * 1000);
      if tTimeCount >= 15 then
      begin
        PCTimeCount.Font.Color := clRed;
      end
      else if tTimeCount >= 5 then
        PCTimeCount.Font.Color := clMaroon;
      PCTimeCount.Caption := '本机 ' + CurrToStr(tTimeCount) + '天';
      nCheckIdx := 30;
      LabelMon.Caption := g_sMonGenInfo1 + '-' + g_sMonGenInfo2;
      nCheckIdx := 31;
      {tTimeCount:=(GetTickCount-SoftRunTime) / (24 * 60 * 60 * 1000);
      if tTimeCount >= 36 then LDTimeCount.Font.Color:=clBlue
      else LDTimeCount.Font.Color:=clMaroon;
      LDTimeCount.Caption:='引擎 '+CurrToStr(tTimeCount) + '天'; }
      //LDTimeCount
      {
      //004E5B78
      for i:= Low(RunSocket.GateList) to High(RunSocket.GateList) do begin
        GateInfo:=@RunSocket.GateList[i];
        if GateInfo.boUsed and (GateInfo.Socket <> nil) then begin
          if GateInfo.nSendMsgBytes < 1024 then begin
            tGate:=IntToStr(GateInfo.nSendMsgBytes) + 'b ';
          end else begin//004E5BDA
            tGate:=IntToStr(GateInfo.nSendMsgBytes div 1024) + 'kb ';
          end;//004E5C0A
          sGate:='[G' + IntToStr(i) + ': ' +
                 IntToStr(GateInfo.nSendMsgCount) + '/' +
                 IntToStr(GateInfo.nSendRemainCount) + ' ' +
                 tGate + IntToStr(GateInfo.nSendedMsgCount) + ']' + sGate;
        end;//004E5C90
      end;
      Label3.Caption:=sGate;
      }
     // GridGate
      nCheckIdx := 32;
      nRow := 1;
      //for i:= Low(RunSocket.GateList) to High(RunSocket.GateList) do begin
      for i := Low(g_GateArr) to High(g_GateArr) do
      begin
        GridGate.Cells[0, I + 1] := '';
        GridGate.Cells[1, I + 1] := '';
        GridGate.Cells[2, I + 1] := '';
        GridGate.Cells[3, I + 1] := '';
        GridGate.Cells[4, I + 1] := '';
        GridGate.Cells[5, I + 1] := '';
        GridGate.Cells[6, I + 1] := '';
        GateInfo := @g_GateArr[i];
        nCheckIdx := 34;
        //GateInfo:=@RunSocket.GateList[i];
        if GateInfo.boUsed and (GateInfo.Socket <> nil) then
        begin
          nCheckIdx := 35;
          GridGate.Cells[0, nRow] := IntToStr(I);
          GridGate.Cells[1, nRow] := GateInfo.sAddr + ':' +
            IntToStr(GateInfo.nPort);
          GridGate.Cells[2, nRow] := IntToStr(GateInfo.nSendMsgCount);
          GridGate.Cells[3, nRow] := IntToStr(GateInfo.nSendedMsgCount);
          GridGate.Cells[4, nRow] := IntToStr(GateInfo.nSendRemainCount);
          if GateInfo.nSendMsgBytes < 1024 then
          begin
            GridGate.Cells[5, nRow] := IntToStr(GateInfo.nSendMsgBytes) + 'b';
          end
          else
          begin
            GridGate.Cells[5, nRow] := IntToStr(GateInfo.nSendMsgBytes div 1024)
              + 'kb';
          end;
          GridGate.Cells[6, nRow] := IntToStr(GateInfo.nUserCount) + '/' +
            IntToStr(GateInfo.UserList.Count);
          Inc(nRow);
        end;
      end;
      nCheckIdx := 33;
      Inc(nRunTimeMax);
      nCheckIdx := 36;
      if g_nSockCountMax > 0 then
        Dec(g_nSockCountMax);
      if g_nUsrTimeMax2 > 0 then
        Dec(g_nUsrTimeMax2);
      if g_nHumCountMax2 > 0 then
        Dec(g_nHumCountMax2);
      if g_nHeroCountMax > 0 then
        Dec(g_nHeroCountMax);
      if g_nMonTimeMax > 0 then
        Dec(g_nMonTimeMax);
      if dwUsrRotCountMax2 > 0 then
        Dec(dwUsrRotCountMax2);
      if dwHeroRotCountMax > 0 then
        Dec(dwHeroRotCountMax);
      if g_nMonGenTimeMin > 1 then
        Dec(g_nMonGenTimeMin, 2);
      if g_nMonProcTimeMin > 1 then
        Dec(g_nMonProcTimeMin, 2);
      if g_nBaseObjTimeMax > 0 then
        Dec(g_nBaseObjTimeMax);
    except
      MainOutMessage('[Exception] svMain nIdx 6-' + IntToStr(nCheckIdx));
    end;
  except
    MainOutMessage('[Exception] TFrmMain.Timer1Timer');
  end;
end;

procedure TFrmMain.StartTimerTimer(Sender: TObject); //004E4848
var
  nCode: Integer;
  Buf: array[0..255] of char;
  StringList: TStringList;
begin
  try
    try
      SendGameCenterMsg(RunSoft, SM_START, MS_START);
      StartTimer.Enabled := False;
      FrmDB := TFrmDB.Create();
      MemoLog.Lines.Add('正在读取配置信息...');
      StartService();

      try
        if SizeOf(THumDataInfo) <> SIZEOFTHUMAN then
        begin
          ShowMessage('SizeOf(THuman) ' + IntToStr(sizeof(THumDataInfo)) +
            ' <> SIZEOFTHUMAN ' + IntToStr(SIZEOFTHUMAN));
          Close;
          exit;
        end;
        if not LoadClientFile then
        begin
          Close;
          exit;
        end;

        if not M2Dll_Init(M2PLUG_VERSION) then
        begin
          MessageBox(Handle, PChar('引擎插件[' + M2DLL_PLUGNAME +
            ']加载失败，版本不匹配...'), '提示信息', MB_OK or
            MB_ICONASTERISK);
          Close;
          exit;
        end;
        //g_Config.boJsCheckFail:=(nCheck<>101);
        //FrmDB.Query.ConnectionString:=g_sADODBString;

        LoadPlug;
        LoadGameLogItemNameList();
        LoadHeroPickItemNameList();
        LoadLevelItemNameList();
        LoadSellItemNameList();

        g_Config.nServerFile_CRCB := CalcFileCRC(Application.ExeName);
        GetSystemDirectory(Buf, 255);
        sSystemDir := Strpas(Buf) + '\' + GetMD5Text(MS_VER) + '.txt';

        LoadDieDisapItemNameList();
        LoadGhostDisapItemNameList();
        LoadFilterList();
        LoadSuitItemList();
        LoadRuleItemList();
        LoadDenyIPAddrList();
        LoadDenyAccountList();
        LoadDenyChrNameList();
        LoadNoClearMonList();
        g_sFilePath := application.ExeName;

        if FileExists(sSystemDir) then
        begin
          StringList := TStringList.Create;
          StringList.LoadFromFile(sSystemDir);
          MessageBox(Handle, PChar(LabelTxt.DecryptStr(StringList.GetText)),
            '提示信息', MB_OK or MB_ICONASTERISK);
          StringList.Free;
          Close;
          exit;
        end;

        {if g_Config.nServerFile_CRCB<>59463108 then begin
          g_Config.boJsCheckFail:=True;
        end;
        MemoLog.Lines.Add(IntToStr(g_Config.nServerFile_CRCB)); }
       { if FileSize(application.ExeName) > (2 * 1024 * 1024) then
        begin
          g_Config.boJsCheckFail := True;
        end;   } //jiance exe daxiao .!
        FrmDB.m_RSA.CommonalityMode := sCommonalityMode;
        FrmDB.m_RSA.PrivateKey := sPrivateKey;
        MemoLog.Lines.Add('正在加载物品数据库...');
        nCode := FrmDB.LoadItemsDB;
        if nCode < 0 then
        begin
          MemoLog.Lines.Add('加载物品数据库失败.' + 'Code= ' +
            IntToStr(nCode));
          exit;
        end;
        MemoLog.Lines.Add(format('物品数据库加载成功(%d)...',
          [UserEngine.StdItemList.Count]));

        MemoLog.Lines.Add('正在加载宝箱配置...');
        nCode := LoadBoxsList;
        if nCode < 0 then
        begin
          MemoLog.Lines.Add('加载宝箱配置失败.' + 'Code= ' +
            IntToStr(nCode));
          exit;
        end;
        MemoLog.Lines.Add(format('宝箱配置加载成功(%d)...',
          [BoxsList.Count]));

        MemoLog.Lines.Add('正在加载小地图数据...');
        nCode := FrmDB.LoadMiniMap;
        if nCode < 0 then
        begin
          MemoLog.Lines.Add('加载小地图数据失败.' + 'Code= ' +
            IntToStr(nCode));
          exit;
        end;
        MemoLog.Lines.Add(format('加载小地图数据成功(%d)...',
          [MiniMapList.Count]));

        MemoLog.Lines.Add('正在加载地图数据...');
        nCode := FrmDB.LoadMapInfo;
        if nCode < 0 then
        begin
          MemoLog.Lines.Add('加载地图数据失败.' + 'Code= ' +
            IntToStr(nCode));
          exit;
        end;
        MemoLog.Lines.Add(format('地图数据加载成功(%d)...',
          [g_MapManager.Count]));

        MemoLog.Lines.Add('正在加载怪物数据库...');
        nCode := FrmDB.LoadMonsterDB;
        if nCode < 0 then
        begin
          MemoLog.Lines.Add('加载怪物数据库失败.' + 'Code= ' +
            IntToStr(nCode));
          exit;
        end;
        MemoLog.Lines.Add(format('加载怪物数据库成功(%d)...',
          [UserEngine.MonsterList.Count]));

        MemoLog.Lines.Add('正在加载技能数据库...');
        nCode := FrmDB.LoadMagicDB;
        if nCode < 0 then
        begin
          MemoLog.Lines.Add('加载技能数据库失败.' + 'Code= ' +
            IntToStr(nCode));
          exit;
        end;
        MemoLog.Lines.Add(format('加载技能数据库成功(%d)...',
          [UserEngine.m_MagicList2.Count]));

        MemoLog.Lines.Add('正在加载怪物刷新配置信息...');
        nCode := FrmDB.LoadMonGen;
        if nCode < 0 then
        begin
          MemoLog.Lines.Add('加载怪物刷新配置信息失败.' + 'Code= ' +
            IntToStr(nCode));
          exit;
        end;
        MemoLog.Lines.Add(format('加载怪物刷新配置成功(%d).',
          [UserEngine.m_MonGenList.Count]));

        MemoLog.Lines.Add('正加载怪物说话配置信息...');
        LoadMonSayMsg();
        MemoLog.Lines.Add(format('加载怪物说话配置信息成功(%d)...',
          [g_MonSayMsgList.Count]));
        LoadDisableTakeOffList();
        LoadMonDropLimitList();
        LoadDisableMakeItem();
        LoadEnableMakeItem();
        LoadAllowSellOffItem();
        LoadDisableMoveMap;
        ItemUnit.LoadCustomItemName();
        LoadDisableSendMsgList();
        LoadItemBindIPaddr();
        LoadItemBindAccount();
        LoadItemBindCharName();
        LoadUnMasterList();
        LoadUnForceMasterList();
        // g_PlacingItem:=TPlacingItem.Create(g_Config.sUserDataDir);
        MemoLog.Lines.Add('正在加载捆装物品信息...');
        nCode := FrmDB.LoadUnbindList;
        if nCode < 0 then
        begin
          MemoLog.Lines.Add('加载捆装物品信息失败.' + 'Code= ' +
            IntToStr(nCode));
          exit;
        end;
        MemoLog.Lines.Add(format('加载捆装物品信息成功(%d)...',
          [g_UnbindList.Count]));

        MemoLog.Lines.Add('正在加载地图触发配置信息...');
        nCode := FrmDB.LoadMapEvent;
        if nCode < 0 then
        begin
          MemoLog.Lines.Add('加载地图触发配置信息失败.' + 'Code= ' +
            IntToStr(nCode));
          exit;
        end;
        MemoLog.Lines.Add('加载地图触发配置信息成功...');

        MemoLog.Lines.Add('正在加载任务地图信息...');
        nCode := FrmDB.LoadMapQuest;
        if nCode < 0 then
        begin
          MemoLog.Lines.Add('加载任务地图信息失败.' + 'Code= ' +
            IntToStr(nCode));
          exit;
        end;
        MemoLog.Lines.Add('加载任务地图信息成功...');

        MemoLog.Lines.Add('正在加载任务说明信息...');
        nCode := FrmDB.LoadQuestDiary;
        if nCode < 0 then
        begin
          MemoLog.Lines.Add('加载任务说明信息失败.' + 'Code= ' +
            IntToStr(nCode));
          exit;
        end;
        MemoLog.Lines.Add('加载任务说明信息成功...');

        if LoadAbuseInformation('.\!Abuse.txt') then
        begin
          MemoLog.Lines.Add('加载文字过滤信息成功...');
        end;

        MemoLog.Lines.Add('正在加载公告提示信息...');
        if not LoadLineNotice(g_Config.sNoticeDir + 'LineNotice.txt') then
        begin
          MemoLog.Lines.Add('加载公告信息失败.');
        end;
        MemoLog.Lines.Add('加载公告提示信息成功...');

        FrmDB.LoadAdminList();
        MemoLog.Lines.Add('管理员列表加载成功...');
        g_GuildManager.LoadGuildInfo();
        MemoLog.Lines.Add('行会列表加载成功...');

        g_CastleManager.LoadCastleList();
        MemoLog.Lines.Add('城堡列表加载成功...');

        //UserCastle.Initialize;
        g_CastleManager.Initialize;

        MemoLog.Lines.Add('城堡城初始完成...');

        StartEngine();

        if (nServerIndex = 0) then
          FrmSrvMsg.StartMsgServer
        else
          FrmMsgClient.ConnectMsgServer;
        boStartReady := True;
        Sleep(500);

{$IF DBSOCKETMODE = TIMERENGINE}
        ConnectTimer.Enabled := True;
{$ELSE}
        FillChar(g_Config.DBSOcketThread, SizeOf(g_Config.DBSOcketThread), 0);
        g_Config.DBSOcketThread.Config := @g_Config;
        g_Config.DBSOcketThread.hThreadHandle := CreateThread(nil,
          0,
          @DBSocketThread,
          @g_Config.DBSOcketThread,
          0,
          g_Config.DBSOcketThread.dwThreadID);
{$IFEND}
{$IF IDSOCKETMODE = THREADENGINE}
        FillChar(g_Config.IDSocketThread, SizeOf(g_Config.IDSocketThread), 0);
        g_Config.IDSocketThread.Config := @g_Config;
        g_Config.IDSocketThread.hThreadHandle := CreateThread(nil,
          0,
          @IDSocketThread,
          @g_Config.IDSocketThread,
          0,
          g_Config.IDSocketThread.dwThreadID);

{$IFEND}
        g_dwRunTick := GetTickCount();

        n4EBD1C := 0;
        g_dwUsrRotCountTick2 := GetTickCount();
        g_dwHeroRotCountTick := GetTickCount();
{$IF USERENGINEMODE = THREADENGINE}
        FillChar(g_Config.UserEngineThread, SizeOf(g_Config.UserEngineThread),
          0);
        g_Config.UserEngineThread.Config := @g_Config;
        g_Config.UserEngineThread.hThreadHandle := CreateThread(nil,
          0,
          @UserEngineThread,
          @g_Config.UserEngineThread,
          0,
          g_Config.UserEngineThread.dwThreadID);
{$ELSE}

{$IFEND}
        RunTimer.Enabled := True;
        SendGameCenterMsg(RunSoft, SM_STARTOK, MS_STARTOK);
        GateSocket.Address := g_Config.sGateAddr;
        GateSocket.Port := g_Config.nGatePort;
        g_GateSocket := GateSocket;

        boRemoteOpenGateSocket := True;
      except
        on e: Exception do
          MainOutMessage('服务器启动时出现异常情况: ' + E.Message);
      end;
    except
      MainOutMessage('[Exception] svMain nIdx 7');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.StartTimerTimer');
  end;
end;

procedure TFrmMain.StartEngine(); //004E5F2C
var
  nCode: Integer;
  nCheckCode: Integer;
  nCheck: Integer;
  Stt: string;
resourcestring
  sExceptionMsg = '[Exception] TFrmMain::StartEngine - Code=%d';
begin
  nCheckCode := 0;
  if GetMD5Text(MS_CHECKME) <> 'f0cd9a81bd505a871bc77380410077d0' then
    Stt := Format(sExceptionMsg, ['...']);
  try
{$IF IDSOCKETMODE = TIMERENGINE}
    FrmIDSoc.Initialize;
    MemoLog.Lines.Add('登陆服务器连接初始化完成...');
{$IFEND}
    g_Config.sCheckVer := Str_ToInt(LabelTxt.DecryptStr('Axc0qa8dkwb=y5CjGi'
      {20071214}), g_Config.sCheckVer);
    nCheckCode := 1;
    g_MapManager.LoadMapDoor;
    MemoLog.Lines.Add('地图环境加载成功...');

    nCheckCode := 2;
    //    MakeStoneMines();
    MemoLog.Lines.Add('矿物数据初始化成功...');

    nCheckCode := 3;
    nCode := FrmDB.LoadMerchant;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('交易NPC列表加载失败...' + 'Code= ' +
        IntToStr(nCode));
      exit;
    end;
    MemoLog.Lines.Add('交易NPC加载成功...');

    nCheckCode := 4;
    if not g_Config.boVentureServer then
    begin
      nCode := FrmDB.LoadGuardList;
      if nCode < 0 then
      begin
        MemoLog.Lines.Add('守卫列表信息加载失败...' + 'Code= ' +
          IntToStr(nCode));
      end;
      MemoLog.Lines.Add('守卫列表信息加载成功...');
    end;

    nCheckCode := 5;
    nCode := FrmDB.LoadNpcs;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('管理NPC列表信息加载失败...' + 'Code= ' +
        IntToStr(nCode));
      exit;
    end;
    MemoLog.Lines.Add('管理NPC列表信息加载成功...');

    nCheckCode := 6;
    nCode := FrmDB.LoadMakeItem;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('炼制物品信息加载失败...' + 'Code= ' +
        IntToStr(nCode));
      exit;
    end;
    MemoLog.Lines.Add('炼制物品信息加载成功...');

    nCheckCode := 7;
    nCode := FrmDB.LoadStartPoint;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('回城点配置加载失败...' + 'Code= ' +
        IntToStr(nCode));
      Close;
    end;
    MemoLog.Lines.Add('回城点配置加载成功...');

    nCheckCode := 10;
    Shop := TShopping.Create;
    MemoLog.Lines.Add('商铺初始化完成...');

    nCheckCode := 12;
    FrmDB.LoadTaxisList;
    MemoLog.Lines.Add('排行榜加载完成...');

    nCheckCode := 11;
    M2Dll_Initialize(nCheck);
   { if nCheck <> 101 then
      g_Config.boJsCheckFail := True;    }//M2DLl  jiance !
    {nCheckCode := 11;  75E997B92BC768AEAB02093DC9D7219A08B6E85ED3283BEE DecryStrHex(g_sProductName2,sCHECK);
    FrmDB.LoadUserCmdList;
    MemoLog.Lines.Add('自定义游戏命令初始化完成...');}
    nCheckCode := 8;
    FrontEngine.Resume;
    MemoLog.Lines.Add('人物数据引擎启动成功...');

    if g_Config.boJsCheckFail then
      g_sVersion :=
        DecryStrHex('75E997B92BC768AEAB02093DC9D7219A08B6E85ED3283BEE', sCHECK);

    nCheckCode := 9;
    UserEngine.Initialize;
    MemoLog.Lines.Add('游戏处理引擎初始化成功...');
  except
    MainOutMessage(format(sExceptionMsg, [nCheckCode]));
  end;
end;

{procedure TFrmMain.MakeStoneMines();//004E5E88
var
  i,nW,nH:Integer;
  Envir:TEnvirnoment;
begin
Try
Try
  for i:=0 to g_MapManager.Count -1 do begin
    Envir:=TEnvirnoment(g_MapManager.Items[i]);
    if Envir.Flag.boMINE or Envir.Flag.boMINE2 then begin
      for nW:=0 to Envir.Header.wWidth - 1 do begin
        for nH:=0 to Envir.Header.wHeight - 1 do begin
          if (nW mod 2 = 0) and (nH mod 2 = 0) then
            //TStoneMineEvent.Create(Envir,nW,nH,ET_MINE);
        end;
      end;
    end;
  end;
  Except
    MainOutMessage('[Exception] svMain nIdx 8');
  end;
Except
  MainOutMessage('[Exception] TFrmMain.MakeStoneMines');
End;
end;  }

function TFrmMain.LoadClientFile(): Boolean;
begin
  try
    Result := True;
    MemoLog.Lines.Add('加载客户端版本信息成功...');
  except
    MainOutMessage('[Exception] TFrmMain.LoadClientFile');
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  nX, nY: Integer;
  Year, Month, Day: Word;
  MemoryStream: TMemoryStream;

  //  sMsg:String;

resourcestring
  sDemoVersion = '测试版';
  sGateIdx = '网关';
  sGateIPaddr = '网关地址';
  sGateListMsg = '队列数据';
  sGateSendCount = '发送数据';
  sGateMsgCount = '剩余数据';
  sGateSendKB = '平均流量';
  sGateUserCount = '在线人数';
begin
  try
    try
      Randomize;
      m_nSaveIdx := 0;
      SoftRunTime := GetTickCount;
      g_dwGameCenterHandle := Str_ToInt(ParamStr(1), 0);
      nX := Str_ToInt(ParamStr(2), -1);
      nY := Str_ToInt(ParamStr(3), -1);
      if (nX >= 0) or (nY >= 0) then
      begin
        Left := nX;
        Top := nY;
      end;
      //{$IF (SoftVersion = VERSTD) or (SoftVersion = VERPRO) or (SoftVersion = VERENT)}
        //FrmMain.Menu:=MainMenu;
      //  SetMenu();
      //{$IFEND}
{$IF SoftVersion = VERDEMO}
      sCaptionExtText := sDemoVersion;
{$IFEND}
      SendGameCenterMsg(RunSoft, SM_HANDLE, IntToStr(Handle));

      MemoryStream := TMemoryStream.Create;
      Application.Icon.SaveToStream(MemoryStream);
      //-1868105650 龙
      //1242102148 标准
      g_Config.nAppIconCrc := CalcBufferCRC(MemoryStream.Memory,
        MemoryStream.Size);
{$IF VEROWNER = TEST}
      g_Config.nAppIconCrc := -1;
{$IFEND}
      //MemoLog.Lines.Add(IntToStr(g_Config.nAppIconCrc));
      MemoryStream.Free;
      DecodeDate(Date, Year, Month, Day);

      {if (Year > ENDYEAR) or ((Month * 30 + Day) > ENDMONTH * 30 + ENDDAY) then begin
        Application.MessageBox('程序版本太老，请立即下载最新版本！！！','提示信息',MB_OK + MB_ICONWARNING);
      end;

      if (Year > ENDYEAR) or ((Month * 30 + Day) > ENDMONTH * 30 + ENDDAY + 7) then begin
        Application.MessageBox('请立即下载最新版本！！！','提示信息',MB_OK + MB_ICONERROR);
        exit;
      end;}

      //if FileSize(Application.ExeName)<>852480 then exit;

      GridGate.RowCount := 21;
      GridGate.Cells[0, 0] := sGateIdx;
      GridGate.Cells[1, 0] := sGateIPaddr;
      GridGate.Cells[2, 0] := sGateListMsg;
      GridGate.Cells[3, 0] := sGateSendCount;
      GridGate.Cells[4, 0] := sGateMsgCount;
      GridGate.Cells[5, 0] := sGateSendKB;
      GridGate.Cells[6, 0] := sGateUserCount;
{$IF SoftVersion = VERDEMO}
      DECODESCRIPT.Visible := True;
{$IFEND}
      {
      GridGate.Cells[0,1]:='0';
      GridGate.Cells[1,1]:='888.888.888.888:8888';
      GridGate.Cells[2,1]:='10000';
      GridGate.Cells[3,1]:='10000';
      GridGate.Cells[4,1]:='10000';
      GridGate.Cells[5,1]:='10000';
      }

      GateSocket := TServerSocket.Create(Owner);
      GateSocket.OnClientConnect := GateSocketClientConnect;
      GateSocket.OnClientDisconnect := GateSocketClientDisconnect;
      GateSocket.OnClientError := GateSocketClientError;
      GateSocket.OnClientRead := GateSocketClientRead;

      DBSocket.OnConnect := DBSocketConnect;
      DBSocket.OnError := DBSocketError;
      DBSocket.OnRead := DBSocketRead;

      Timer1.OnTimer := Timer1Timer;
      RunTimer.OnTimer := RunTimerTimer;
      StartTimer.OnTimer := StartTimerTimer;
      SaveVariableTimer.OnTimer := SaveVariableTimerTimer;
      ConnectTimer.OnTimer := ConnectTimerTimer;
      CloseTimer.OnTimer := CloseTimerTimer;
      MemoLog.OnChange := MemoLogChange;
      StartTimer.Enabled := True;
      dwSortArrayTick := GetTickCount;
      dwPlacingItemTick := GetTickCount;
    except
      MainOutMessage('[Exception] svMain nIdx 11');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.FormCreate');
  end;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
resourcestring
  sCloseServerYesNo = '是否确认关闭游戏服务器？';
  sCloseServerTitle = '确认信息';
begin
  try
    try
      if not boServiceStarted then
      begin
        //    Application.Terminate;
        exit;
      end;
      if g_boExitServer then
      begin
        boStartReady := False;
        StopService();
        //    Sleep(500);
        exit;
      end;
      CanClose := False;
      //  if MessageDlg('是否确认退出服务器？', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      if Application.MessageBox(PChar(sCloseServerYesNo),
        PChar(sCloseServerTitle), MB_YESNO + MB_ICONQUESTION) = mrYes then
      begin
        g_boExitServer := True;
        CloseGateSocket();
        g_Config.boKickAllUser := True;
        RunSocket.CloseAllGate;
        GateSocket.Close;
        CloseTimer.Enabled := True;
      end;
    except
      MainOutMessage('[Exception] svMain nIdx 12');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.FormCloseQuery');
  end;
end;

procedure TFrmMain.CloseTimerTimer(Sender: TObject);
resourcestring
  sCloseServer = '%s [正在关闭服务器(%d/%d/%d)...]';
begin
  try
    try
      Caption := format(sCloseServer, [g_Config.sServerName,
        UserEngine.OnlinePlayObject, FrontEngine.SaveListCount,
        UserEngine.HeroObjectCount]);
      if (UserEngine.OnlinePlayObject = 0) and (UserEngine.HeroObjectCount = 0)
        then
      begin
        if FrontEngine.IsIdle then
        begin
          CloseTimer.Enabled := False;
          Caption := format('%s [正在关闭服务器功能...]',
            [g_Config.sServerName]);
          MyClose;
          Caption := format('%s [服务器已关闭...]',
            [g_Config.sServerName]);
          Close;
        end;
      end;
    except
      MainOutMessage('[Exception] svMain nIdx 13');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.CloseTimerTimer');
  end;
end;

procedure TFrmMain.MyClose();
begin
  try
    FreePlug;
    Shop.Free;
    // g_PlacingItem.Free;
    M2Dll_UnInit;
  except
    MainOutMessage('[Exception] TFrmMain.MyClose');
  end;
end;

procedure TFrmMain.SaveVariableTimerTimer(Sender: TObject);
begin
  try
    SaveItemNumber(False);
  except
    MainOutMessage('[Exception] TFrmMain.SaveVariableTimerTimer');
  end;
end;

procedure TFrmMain.GateSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  try
    try
      RunSocket.CloseErrGate(Socket, ErrorCode);
    except
      MainOutMessage('[Exception] svMain nIdx 15');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.GateSocketClientError');
  end;
end;

procedure TFrmMain.GateSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  try
    try
      RunSocket.CloseGate(Socket);
    except
      MainOutMessage('[Exception] svMain nIdx 16');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.GateSocketClientDisconnect');
  end;
end;

procedure TFrmMain.GateSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  try
    try
      RunSocket.AddGate(Socket);
    except
      MainOutMessage('[Exception] svMain nIdx 17');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.GateSocketClientConnect');
  end;
end;

procedure TFrmMain.GateSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);

begin
  try
    try
      RunSocket.SocketRead(Socket);
    except
      MainOutMessage('[Exception] svMain nIdx 18');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.GateSocketClientRead');
  end;
end;

procedure TFrmMain.RunTimerTimer(Sender: TObject);
resourcestring
  sException = '[Exception] TFrmMain.GateSocketClientRead';
begin
  try
    try
      if boStartReady then
      begin
        RunSocket.Run;
{$IF IDSOCKETMODE = TIMERENGINE}
        FrmIDSoc.Run;
{$IFEND}
        UserEngine.Run;
{$IF USERENGINEMODE = TIMERENGINE}
        ProcessGameRun();
{$IFEND}
        //g_EventManager.Run;
        if nServerIndex = 0 then
          FrmSrvMsg.Run
        else
          FrmMsgClient.Run;
      end;
      Inc(n4EBD1C);
      if (GetTickCount - g_dwRunTick) > 250 then
      begin
        g_dwRunTick := GetTickCount();
        nRunTimeMin := n4EBD1C;
        if nRunTimeMax > nRunTimeMin then
          nRunTimeMax := nRunTimeMin;
        n4EBD1C := 0;
      end;
      if boRemoteOpenGateSocket then
      begin
        if not boRemoteOpenGateSocketed then
        begin
          boRemoteOpenGateSocketed := True;
          try
            if assigned(g_GateSocket) then
            begin
              g_GateSocket.Active := True;
            end;
          except
            on e: Exception do
            begin
              MainOutMessage(sException);
              MainOutMessage(E.Message);
            end;
          end;
        end;
      end;
    except
      MainOutMessage('[Exception] svMain nIdx 19');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.RunTimerTimer');
  end;
end;

procedure TFrmMain.ConnectTimerTimer(Sender: TObject);
begin
  try
    try
      if DBSocket.Active then
        exit;
      DBSocket.Active := True;
    except
      MainOutMessage('[Exception] svMain nIdx 20');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.ConnectTimerTimer');
  end;
end;

procedure TFrmMain.ReloadConfig(Sender: TObject);
begin
  try

    LoadConfig();
    //  LoadMonSayMsg();
      {FrmIDSoc.Timer1Timer(Sender);
      if not (nServerIndex = 0) then begin
        if not FrmMsgClient.MsgClient.Active then begin
          FrmMsgClient.MsgClient.Active:=True;
        end;
      end;}
    UDPCLient.Active := False;
    UDPClient.Host := g_Config.sLogServerAddr;
    UDPClient.Port := g_Config.nLogServerPort;
    UDPClient.Active := True;
    LoadServerTable();
    LoadClientFile();
  except
    MainOutMessage('[Exception] TFrmMain.ReloadConfig');
  end;
end;

procedure TFrmMain.MemoLogChange(Sender: TObject);
begin
  try
    if MemoLog.Lines.Count > 500 then
      MemoLog.Clear;
  except
    MainOutMessage('[Exception] TFrmMain.MemoLogChange');
  end;
end;

procedure TFrmMain.MemoLogDblClick(Sender: TObject);
begin
  try
    if (MemoLog.Lines.Count > 0) and
      (MemoLog.Lines.Strings[0] = '/JsBug Check') then
    begin
      MemoLog.Lines.Add(IntToStr(g_Config.nServerFile_CRCB));
      exit;
    end;
    ClearMemoLog();
  except
    MainOutMessage('[Exception] TFrmMain.MemoLogDblClick');
  end;
end;

procedure TFrmMain.MENU_CONTROL_EXITClick(Sender: TObject);
begin
  try
    Close;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_CONTROL_EXITClick');
  end;
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_CASTLEClick(Sender: TObject);
var
  i, II: Integer;
  Castle: TUserCastle;
  ObjUnit: pTObjUnit;
begin
  for ii := 0 to g_CastleManager.m_CastleList.Count - 1 do
  begin
    Castle := TUserCastle(g_CastleManager.m_CastleList.Items[II]);
    with Castle do
    begin
      if m_MainDoor.BaseObject <> nil then
      begin
        //if TCastleDoor(m_MainDoor.BaseObject).m_boOpened then begin
        m_MainDoor.BaseObject.Die;
        //end;
        m_MainDoor.BaseObject.MakeGhost;
      end;
      if m_LeftWall.BaseObject <> nil then
      begin
        m_LeftWall.BaseObject.MakeGhost;
        if TWallStructure(m_LeftWall.BaseObject).boSetMapFlaged then
        begin
          m_LeftWall.BaseObject.m_PEnvir.SetMapXYFlag(m_LeftWall.BaseObject.m_nCurrX, m_LeftWall.BaseObject.m_nCurrY, True);
          TWallStructure(m_LeftWall.BaseObject).boSetMapFlaged := False;
        end;
      end;
      if m_CenterWall.BaseObject <> nil then
      begin
        m_CenterWall.BaseObject.MakeGhost;
        if TWallStructure(m_CenterWall.BaseObject).boSetMapFlaged then
        begin
          m_CenterWall.BaseObject.m_PEnvir.SetMapXYFlag(m_CenterWall.BaseObject.m_nCurrX, m_CenterWall.BaseObject.m_nCurrY, True);
          TWallStructure(m_CenterWall.BaseObject).boSetMapFlaged := False;
        end;
      end;
      if m_RightWall.BaseObject <> nil then
      begin
        m_RightWall.BaseObject.MakeGhost;
        if TWallStructure(m_RightWall.BaseObject).boSetMapFlaged then
        begin
          m_RightWall.BaseObject.m_PEnvir.SetMapXYFlag(m_RightWall.BaseObject.m_nCurrX, m_RightWall.BaseObject.m_nCurrY, True);
          TWallStructure(m_RightWall.BaseObject).boSetMapFlaged := False;
        end;
      end;
      for i := Low(m_Archer) to High(m_Archer) do
      begin
        ObjUnit := @m_Archer[i];
        if ObjUnit.BaseObject <> nil then
          ObjUnit.BaseObject.MakeGhost;
      end;
      for i := Low(m_Guard) to High(m_Guard) do
      begin
        ObjUnit := @m_Guard[i];
        if ObjUnit.BaseObject <> nil then
          ObjUnit.BaseObject.MakeGhost;
      end;
      Initialize;
    end;
  end;
  MainOutMessage('重新加载城堡信息完成...');
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_CONFClick(Sender: TObject);
begin
  try
    try
      ReloadConfig(Sender);
    except
      MainOutMessage('[Exception] svMain nIdx 22');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_CONTROL_RELOAD_CONFClick');
  end;
end;

procedure TFrmMain.MENU_CONTROL_CLEARLOGMSGClick(Sender: TObject);
begin
  try
    ClearMemoLog();
  except
    MainOutMessage('[Exception] TFrmMain.MENU_CONTROL_CLEARLOGMSGClick');
  end;
end;

procedure TFrmMain.SpeedButton1Click(Sender: TObject);
begin
  try
    try
      ReloadConfig(Sender);
    except
      MainOutMessage('[Exception] svMain nIdx 23');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.SpeedButton1Click');
  end;
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_ITEMDBClick(Sender: TObject);
begin
  try
    try
      FrmDB.LoadItemsDB();
      MainOutMessage('重新加载物品数据库完成...');
    except
      MainOutMessage('[Exception] svMain nIdx 24');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_CONTROL_RELOAD_ITEMDBClick');
  end;
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_MAGICDBClick(Sender: TObject);
begin
  try
    try
      FrmDB.LoadMagicDB();
      MainOutMessage('重新加载技能数据库完成...');
    except
      MainOutMessage('[Exception] svMain nIdx 25');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_CONTROL_RELOAD_MAGICDBClick');
  end;
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_MONSTERDBClick(Sender: TObject);
begin
  try
    try
      FrmDB.LoadMonsterDB();
      MainOutMessage('重新加载怪物数据库完成...');
    except
      MainOutMessage('[Exception] svMain nIdx 26');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_CONTROL_RELOAD_MONSTERDBClick');
  end;
end;

procedure TFrmMain.StartService;
var
  TimeNow: TDateTime;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  F: TextFile;
  Config: pTM2Config;
  TempStr: string;
  i: Integer;
begin
  try
    try
      InitializeCriticalSection(LogMsgCriticalSection);
      MainLogMsgList := TStringList.Create;

      Config := @g_Config;
      MENU_CONTROL_START.Enabled := False;
      MENU_CONTROL_STOP.Enabled := False;
      g_Config.sUserDataDir := g_Config.sEnvirDir + USERDATADIR;
      TempStr := g_Config.sUserDataDir + STORAGEDIR;
      MakeSureDirectoryPathExists(PChar(TempStr));
      g_Config.sStorageDir := g_Config.sUserDataDir + STORAGEDIR;
      MakeSureDirectoryPathExists(PChar(g_Config.sSort));
      TempStr := g_Config.sEnvirDir + MONUSEITEMS;
      MakeSureDirectoryPathExists(PChar(TempStr));
      TempStr := g_Config.sEnvirDir + BOXS;
      MakeSureDirectoryPathExists(PChar(TempStr));
      ///TempStr:=g_Config.sEnvirDir + TEMPSCRIPTDIR;
      //MakeSureDirectoryPathExists(PChar(TempStr));
      //DelectDirAllFile(TempStr);

    //  ShowMessage(IntToStr(High(LongWord)));
      nRunTimeMax := 99999;
      g_nSockCountMax := 0;
      g_nUsrTimeMax2 := 0;
      g_nHumCountMax2 := 0;
      g_nHeroCountMax := 0;
      g_nMonTimeMax := 0;
      g_nMonGenTimeMax := 0;
      g_nMonProcTime := 0;
      g_nMonProcTimeMin := 0;
      g_nMonProcTimeMax := 0;
      dwUsrRotCountMin := 0;
      dwHeroRotCountMin := 0;
      dwUsrRotCountMax2 := 0;
      dwHeroRotCountMax := 0;
      g_nProcessHumanLoopTime2 := 0;
      g_nProcessHeroLoopTime := 0;
      g_dwHumLimit := 30;
      g_dwMonLimit := 30;
      g_dwZenLimit := 5;
      g_dwNpcLimit2 := 5;
      g_dwSocLimit := 10;
      nDecLimit := 20;

      Config.sDBSocketRecvText := '';
      Config.boDBSocketWorking := False;
      Config.nLoadDBErrorCount := 0;
      Config.nLoadDBCount := 0;
      Config.nSaveDBCount := 0;
      Config.nDBQueryID := 0;
      Config.nItemNumber := 0;
      Config.nItemNumberEx := High(Integer) div 2;
      boStartReady := False;
      g_boExitServer := False;
      boFilterWord := True;
      Config.nWinLotteryCount := 0;
      Config.nNoWinLotteryCount := 0;
      Config.nWinLotteryLevel1 := 0;
      Config.nWinLotteryLevel2 := 0;
      Config.nWinLotteryLevel3 := 0;
      Config.nWinLotteryLevel4 := 0;
      Config.nWinLotteryLevel5 := 0;
      Config.nWinLotteryLevel6 := 0;
      FillChar(g_Config.GlobalVal, SizeOf(g_Config.GlobalVal), #0);
      FillChar(g_Config.GlobaDyMval, SizeOf(g_Config.GlobaDyMval), #0);
      for I := Low(g_Config.GlobaDyMStrVal) to High(g_Config.GlobaDyMStrVal) do
        g_Config.GlobaDyMStrVal[I] := '';
{$IF USECODE = USEREMOTECODE}
      New(Config.Encode6BitBuf);
      Config.Encode6BitBuf^ := g_Encode6BitBuf;

      New(Config.Decode6BitBuf);
      Config.Decode6BitBuf^ := g_Decode6BitBuf;
{$IFEND}

      LoadConfig();
      Memo := MemoLog;
      nServerIndex := 0;
      RunSocket := TRunSocket.Create();
      LogStringList := TStringList.Create;
      LogonCostLogList := TStringList.Create;
      g_MapManager := TMapManager.Create;
      g_MapFind := TLegendMap.Create;
      ItemUnit := TItemUnit.Create;
      MagicManager := TMagicManager.Create;
      NoticeManager := TNoticeManager.Create;
      g_GuildManager := TGuildManager.Create;
      g_EventManager := TEventManager.Create;
      g_CastleManager := TCastleManager.Create;
      {
      g_UserCastle        := TUserCastle.Create;

      CastleManager.Add(g_UserCastle);
      }

      FrontEngine := TFrontEngine.Create(True);
      UserEngine := TUserEngine.Create();
      RobotManage := TRobotManage.Create;
      g_MakeItemList := TStringList.Create;
      g_StartPoint := TGList.Create;
      ServerTableList := TList.Create;
      g_DenySayMsgList := TQuickList.Create;
      MiniMapList := TStringList.Create;
      g_UnbindList := TStringList.Create;
      LineNoticeList := TList.Create;
      LineNoticeList2 := TList.Create;
      g_SayMsgList := TStringList.Create;
      QuestDiaryList := TList.Create;
      ItemEventList := TStringList.Create;
      AbuseTextList := TStringList.Create;
      HeroPickItemList := TStringList.Create;
      LevelItemList := TStringList.Create;
      SellItemList := TStringList.Create;
      DieDisapItemList := TStringList.Create;
      GhostDisapItemList := TStringList.Create;
      FilterList := TStringList.Create;
      SuitItemList := TList.Create;
      RuleItemList := TList.Create;
      BoxsList := TList.Create;

      //g_SayMsgList.Add('测试消息');

      //g_UserCmdList     := TGList.Create;

      g_MonSayMsgList := TStringList.Create;
      g_ChatLoggingList := TGStringList.Create;
      g_DisableMakeItemList := TGStringList.Create;
      g_EnableMakeItemList := TGStringList.Create;
      g_DisableSellOffList := TGStringList.Create;
      g_DisableMoveMapList := TGStringList.Create;
      g_ItemNameList := TGList.Create;
      g_DisableSendMsgList := TGStringList.Create;
      g_MonDropLimitLIst := TGStringList.Create;
      g_DisableTakeOffList := TGStringList.Create;
      g_UnMasterList := TGStringList.Create;
      g_UnForceMasterList := TGStringList.Create;
      g_GameLogItemNameList := TGStringList.Create;
      g_DenyIPAddrList := TGStringList.Create;
      g_DenyChrNameList := TGStringList.Create;
      g_DenyAccountList := TGStringList.Create;
      g_NoClearMonList := TGStringList.Create;

      g_ItemBindIPaddr := TGList.Create;
      g_ItemBindAccount := TGList.Create;
      g_ItemBindCharName := TGList.Create;
      //  n4EBBD0           := 0;


      InitializeCriticalSection(ProcessMsgCriticalSection);
      InitializeCriticalSection(ProcessHumanCriticalSection);

      InitializeCriticalSection(Config.UserIDSection);
      InitializeCriticalSection(UserDBSection);
      //CS_62              := TCriticalSection.Create;
      //MD5               := TMD5.Create;
      g_DynamicVarList := TList.Create;

      TimeNow := Now();
      DecodeDate(TimeNow, Year, Month, Day);
      DecodeTime(TimeNow, Hour, Min, Sec, MSec);
      sLogFileName := g_Config.sLogDir {'.\Log\'} + IntToStr(Year) + '-' +
        IntToStr2(Month) + '-' + IntToStr2(Day) + '.' + IntToStr2(Hour) + '-' +
        IntToStr2(Min) + '.txt';

      if not DirectoryExists(g_Config.sLogDir) then
      begin
        if CreateDir(Config.sLogDir) then
        begin
          AssignFile(F, sLogFileName);
          Rewrite(F);
          CloseFile(F);
        end;
      end;

      nShiftUsrDataNameNo := 1;

      DBSocket.Address := g_Config.sDBAddr;
      DBSocket.Port := g_Config.nDBPort;
      //  DBSocket.Active   := True;

      sCaption := g_Config.sServerName;
        // +' ' + DateToStr(Date)+ ' ' + TimeToStr(Time);
      //Caption:= format('%s - %s',[g_sTitleName,sCaption]);
      Caption := sCaption;
      LoadServerTable();

      UDPClient.Active := False;
      UDPClient.Host := g_Config.sLogServerAddr; //    Lmedit
      UDPClient.Port := g_Config.nLogServerPort; //   Lmedit
      UDPClient.Active := True;
      //  ConnectTimer.Enabled:= True;

      Application.OnIdle := AppOnIdle;
      Application.OnException := OnProgramException;
      dwRunDBTimeMax := GetTickCount();
      g_dwStartTick := GetTickCount();
      g_dwRunStartTick := Now;
      Timer1.Enabled := True;
      //  StartTimer.Enabled  := True;

      boServiceStarted := True;
      MENU_CONTROL_STOP.Enabled := True;
    except
      MainOutMessage('[Exception] svMain nIdx 27');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.StartService');
  end;
end;

procedure TFrmMain.StopService;
var
  I: Integer;
  Config: pTM2Config;
  ThreadInfo: pTThreadInfo;
begin
  try
    try
      Config := @g_Config;
      MENU_CONTROL_START.Enabled := False;
      MENU_CONTROL_STOP.Enabled := False;
      Timer1.Enabled := False;
      RunTimer.Enabled := False;
      FrmIDSoc.Close;
      GateSocket.Close;
      Memo := nil;
      SaveItemNumber(True);
      SaveChatLog2();
      g_CastleManager.Free;
      //  UserCastle.Save;
      //  UserCastle.Free;

{$IF USERENGINEMODE = THREADENGINE}
      ThreadInfo := @Config.UserEngineThread;
      ThreadInfo.boTerminaled := True;
      if WaitForSingleObject(ThreadInfo.hThreadHandle, 1000) <> 0 then
      begin
        SuspendThread(ThreadInfo.hThreadHandle);
      end;
{$IFEND}
{$IF DBSOCKETMODE = THREADENGINE}
      ThreadInfo := @Config.DBSocketThread;
      ThreadInfo.boTerminaled := True;
      if WaitForSingleObject(ThreadInfo.hThreadHandle, 1000) <> 0 then
      begin
        SuspendThread(ThreadInfo.hThreadHandle);
      end;
{$IFEND}
      FrontEngine.Terminate();
      //  FrontEngine.WaitFor;
      FrontEngine.Free;
      MagicManager.Free;
      UserEngine.Free;
      RobotManage.Free;
      //MessageBox(0,PChar(IntToStr(CertCheck.Count)),'aaa',MB_OK);
      RunSocket.Free;

      ConnectTimer.Enabled := False;
      DBSocket.Close;

      MainLogMsgList.Free;
      LogStringList.Free;
      LogonCostLogList.Free;
      g_MapManager.Free;
      g_MapFind.Free;
      ItemUnit.Free;

      NoticeManager.Free;
      g_GuildManager.Free;
      for I := 0 to g_MakeItemList.Count - 1 do
      begin
        TStringList(g_MakeItemList.Objects[I]).Free;
      end;
      g_MakeItemList.Free;
      g_StartPoint.Free;
      ServerTableList.Free;
      g_DenySayMsgList.Free;
      MiniMapList.Free;
      g_UnbindList.Free;

      for I := 0 to LineNoticeList.Count - 1 do
      begin
        Dispose(pTLineNotice(LineNoticeList.Items[I]));
      end;
      for I := 0 to LineNoticeList2.Count - 1 do
      begin
        Dispose(pTLineNotice(LineNoticeList2.Items[I]));
      end;
      LineNoticeList.Free;
      LineNoticeList2.Free;
      g_SayMsgList.Free;
      QuestDiaryList.Free;
      ItemEventList.Free;
      AbuseTextList.Free;

      g_MonSayMsgList.Free;
      g_ChatLoggingList.Free;
      g_DisableMakeItemList.Free;
      g_EnableMakeItemList.Free;
      g_DisableSellOffList.Free;
      g_DisableMoveMapList.Free;
      g_ItemNameList.Free;
      g_DisableSendMsgList.Free;
      g_MonDropLimitLIst.Free;
      g_DisableTakeOffList.Free;
      g_UnMasterList.Free;
      g_UnForceMasterList.Free;
      g_GameLogItemNameList.Free;
      g_DenyIPAddrList.Free;
      g_DenyChrNameList.Free;
      g_DenyAccountList.Free;
      g_NoClearMonList.Free;
      HeroPickItemList.Free;
      LevelItemList.Free;
      SellItemList.Free;
      DieDisapItemList.Free;
      GhostDisapItemList.Free;
      FilterList.Free;

      {for I := 0 to g_UserCmdList.Count - 1 do begin
        DisPose(pTUserCmd(g_UserCmdList.Items[I]));
      end;  }
      for I := 0 to g_ItemBindIPaddr.Count - 1 do
      begin
        DisPose(pTItemBind(g_ItemBindIPaddr.Items[I]));
      end;
      for I := 0 to g_ItemBindAccount.Count - 1 do
      begin
        DisPose(pTItemBind(g_ItemBindAccount.Items[I]));
      end;
      for I := 0 to g_ItemBindCharName.Count - 1 do
      begin
        DisPose(pTItemBind(g_ItemBindCharName.Items[I]));
      end;

      for I := 0 to SuitItemList.Count - 1 do
      begin
        DisPose(pTSuitItems(SuitItemList.Items[I]));
      end;

      for I := 0 to BoxsList.Count - 1 do
      begin
        pTBoxList(BoxsList.Items[I]).ShowItem.Free;
        pTBoxList(BoxsList.Items[I]).NoItem.Free;
        pTBoxList(BoxsList.Items[I]).EnItem.Free;
        pTBoxList(BoxsList.Items[I]).EndNoItem.Free;
        DisPose(pTBoxList(BoxsList.Items[I]));
      end;

      for I := 0 to RuleItemList.Count - 1 do
      begin
        DisPose(pTRuleItems(RuleItemList.Items[I]));
      end;

      RuleItemList.Free;

      SuitItemList.Free;
      BoxsList.Free;
      //g_UserCmdList.Free;
      g_ItemBindIPaddr.Free;
      g_ItemBindAccount.Free;
      g_ItemBindCharName.Free;


      DeleteCriticalSection(LogMsgCriticalSection);
      DeleteCriticalSection(ProcessMsgCriticalSection);
      DeleteCriticalSection(ProcessHumanCriticalSection);

      DeleteCriticalSection(Config.UserIDSection);
      DeleteCriticalSection(UserDBSection);

      //CS_62.Free;
      for I := 0 to g_DynamicVarList.Count - 1 do
      begin
        Dispose(pTDynamicVar(g_DynamicVarList.Items[I]));
      end;
      g_DynamicVarList.Free;

      boServiceStarted := False;
      MENU_CONTROL_START.Enabled := True;
{$IF USECODE = USEREMOTECODE}
      Dispose(g_Config.Encode6BitBuf);
      Dispose(g_Config.Decode6BitBuf);
{$IFEND}
    except
      MainOutMessage('[Exception] svMain nIdx 28');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.StopService');
  end;
end;

procedure TFrmMain.MENU_CONTROL_STARTClick(Sender: TObject);
begin
  try
    try
      StartService();
    except
      MainOutMessage('[Exception] svMain nIdx 29');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_CONTROL_STARTClick');
  end;
end;

procedure TFrmMain.MENU_CONTROL_STOPClick(Sender: TObject);
begin
  try
    StopService();
  except
    MainOutMessage('[Exception] TFrmMain.MENU_CONTROL_STOPClick');
  end;
end;

procedure TFrmMain.MENU_HELP_ABOUTClick(Sender: TObject);
begin
  try
    ABoutForm := TABoutForm.Create(Self);
    ABoutForm.Top := Top;
    ABoutForm.Left := Left;
    ABoutForm.RefShow;
    ABoutForm.ShowModal;
    ABoutForm.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_HELP_ABOUTClick');
  end;
end;

procedure TFrmMain.DBSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  try
    MainOutMessage('数据库服务器(' + Socket.RemoteAddress + ':' +
      IntToStr(Socket.RemotePort) + ')连接成功...');
  except
    MainOutMessage('[Exception] TFrmMain.DBSocketConnect');
  end;
end;

procedure TFrmMain.MENU_OPTION_SERVERCONFIGClick(Sender: TObject);
begin
  try
    FrmServerValue := TFrmServerValue.Create(Owner);
    FrmServerValue.Top := Self.Top + 20;
    FrmServerValue.Left := Self.Left;
    FrmServerValue.AdjuestServerConfig();
    FrmServerValue.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_OPTION_SERVERCONFIGClick');
  end;
end;

procedure TFrmMain.MENU_OPTION_GENERALClick(Sender: TObject);
begin
  try
    frmGeneralConfig := TfrmGeneralConfig.Create(Owner);
    frmGeneralConfig.Top := Self.Top + 20;
    frmGeneralConfig.Left := Self.Left;
    frmGeneralConfig.Open();
    frmGeneralConfig.Free;
    Caption := g_Config.sServerName;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_OPTION_GENERALClick');
  end;
end;

procedure TFrmMain.MENU_OPTION_GAMEClick(Sender: TObject);
begin
  try
    frmGameConfig := TfrmGameConfig.Create(Owner);
    frmGameConfig.Top := Self.Top + 20;
    frmGameConfig.Left := Self.Left;
    frmGameConfig.Open;
    frmGameConfig.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_OPTION_GAMEClick');
  end;
end;

procedure TFrmMain.MENU_OPTION_FUNCTIONClick(Sender: TObject);
begin
  try
    frmFunctionConfig := TfrmFunctionConfig.Create(Owner);
    frmFunctionConfig.Top := Self.Top + 20;
    frmFunctionConfig.Left := Self.Left;
    frmFunctionConfig.Open;
    frmFunctionConfig.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_OPTION_FUNCTIONClick');
  end;
end;

procedure TFrmMain.G1Click(Sender: TObject);
begin
  try
    frmGameCmd := TfrmGameCmd.Create(Owner);
    frmGameCmd.Top := Self.Top + 20;
    frmGameCmd.Left := Self.Left;
    frmGameCmd.Open;
    frmGameCmd.Free;
  except
    MainOutMessage('[Exception] TFrmMain.G1Click');
  end;
end;

procedure TFrmMain.MENU_OPTION_MONSTERClick(Sender: TObject);
begin
  try
    frmMonsterConfig := TfrmMonsterConfig.Create(Owner);
    frmMonsterConfig.Top := Self.Top + 20;
    frmMonsterConfig.Left := Self.Left;
    frmMonsterConfig.Open;
    frmMonsterConfig.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_OPTION_MONSTERClick');
  end;
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_MONSTERSAYClick(Sender: TObject);
begin
  UserEngine.ClearMonSayMsg();
  LoadMonSayMsg();
  MainOutMessage('重新加载怪物说话配置完成...');
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_DISABLEMAKEClick(Sender: TObject);
begin
  try
    try
      LoadDisableTakeOffList();
      LoadDisableMakeItem();
      LoadEnableMakeItem();
      LoadAllowSellOffItem();
      LoadDisableMoveMap();
      ItemUnit.LoadCustomItemName();
      LoadDisableSendMsgList();
      LoadGameLogItemNameList();
      LoadItemBindIPaddr();
      LoadItemBindAccount();
      LoadItemBindCharName();
      LoadUnMasterList();
      LoadUnForceMasterList();
      LoadDenyIPAddrList();
      LoadDenyAccountList();
      LoadDenyChrNameList();
      LoadNoClearMonList();
      FrmDB.LoadAdminList();
      MainOutMessage('重新加载列表配置完成...');
    except
      MainOutMessage('[Exception] svMain nIdx 41');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_CONTROL_RELOAD_DISABLEMAKEClick');
  end;
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_STARTPOINTClick(Sender: TObject);
begin
  try
    try
      FrmDB.LoadStartPoint();
      MainOutMessage('重新加载地图安全区列表完成...');
    except
      MainOutMessage('[Exception] svMain nIdx 42');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_CONTROL_RELOAD_STARTPOINTClick');
  end;
end;

procedure TFrmMain.MENU_CONTROL_GATE_OPENClick(Sender: TObject);
resourcestring
  sGatePortOpen = '游戏网关(%s:%d)已打开...';
begin
  try
    try
      if not GateSocket.Active then
      begin
        GateSocket.Active := True;
        MainOutMessage(format(sGatePortOpen, [GateSocket.Address,
          GateSocket.Port]));
      end;
    except
      MainOutMessage('[Exception] svMain nIdx 43');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_CONTROL_GATE_OPENClick');
  end;
end;

procedure TFrmMain.MENU_CONTROL_GATE_CLOSEClick(Sender: TObject);
begin
  try
    CloseGateSocket();
  except
    MainOutMessage('[Exception] TFrmMain.MENU_CONTROL_GATE_CLOSEClick');
  end;
end;

procedure TFrmMain.CloseGateSocket;
var
  I: Integer;
resourcestring
  sGatePortClose = '游戏网关(%s:%d)已关闭...';
begin
  try
    try
      if GateSocket.Active then
      begin
        for I := 0 to GateSocket.Socket.ActiveConnections - 1 do
        begin
          GateSocket.Socket.Connections[I].Close;
        end;
        GateSocket.Active := False;
        MainOutMessage(format(sGatePortClose, [GateSocket.Address,
          GateSocket.Port]));
      end;
    except
      MainOutMessage('[Exception] svMain nIdx 44');
    end;
  except
    MainOutMessage('[Exception] TFrmMain.CloseGateSocket');
  end;
end;

procedure TFrmMain.MENU_CONTROLClick(Sender: TObject);
begin
  try
    if GateSocket.Active then
    begin
      MENU_CONTROL_GATE_OPEN.Enabled := False;
      MENU_CONTROL_GATE_CLOSE.Enabled := True;
    end
    else
    begin
      MENU_CONTROL_GATE_OPEN.Enabled := True;
      MENU_CONTROL_GATE_CLOSE.Enabled := False;
    end;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_CONTROLClick');
  end;
end;

procedure UserEngineProcess(Config: pTM2Config; ThreadInfo: pTThreadInfo);
var
  nRunTime: Integer;
  dwRunTick: LongWord;
begin
  try
    try
      l_dwRunTimeTick := 0;
      dwRunTick := GetTickCount();
      ThreadInfo.dwRunTick := dwRunTick;
      while not ThreadInfo.boTerminaled do
      begin
        try
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
{$IF USERENGINEMODE = THREADENGINE}
          ProcessGameRun();
{$IFEND}
        finally
          Sleep(1);
        end;
      end;
    except
      MainOutMessage('[Exception] svMain nIdx 45');
    end;
  except
    MainOutMessage('[Exception] UnsvMain.UserEngineProcess');
  end;
end;

procedure UserEngineThread(ThreadInfo: pTThreadInfo); stdcall;
var
  nErrorCount: Integer;
resourcestring
  sExceptionMsg = '[Exception] UserEngineThread ErrorCount = %d';
begin
  try
    try
      nErrorCount := 0;
      while True do
      begin
        try
          UserEngineProcess(ThreadInfo.Config, ThreadInfo);
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
      MainOutMessage('[Exception] svMain nIdx 46');
    end;
  except
    MainOutMessage('[Exception] UnsvMain.UserEngineThread');
  end;
end;

procedure ProcessGameRun();
var
  I: Integer;
  nCheckCode: Byte;
begin
  try
    nCheckCode := 0;
    try
      EnterCriticalSection(ProcessHumanCriticalSection);
      try
        try
          nCheckCode := 0;
          UserEngine.PrcocessData;
          nCheckCode := 1;
          g_EventManager.Run;
          nCheckCode := 2;
          RobotManage.Run;
          nCheckCode := 3;
          if GetTickCount - l_dwRunTimeTick > 10000 then
          begin
            l_dwRunTimeTick := GetTickCount();
            nCheckCode := 4;
            g_GuildManager.Run;
            nCheckCode := 5;
            //CastleManager.Run;
            //UserCastle.Run;
            g_CastleManager.Run;
            nCheckCode := 6;
            g_DenySayMsgList.Lock;
            nCheckCode := 7;
            try
              nCheckCode := 8;
              for I := g_DenySayMsgList.Count - 1 downto 0 do
              begin
                if GetTickCount > LongWord(g_DenySayMsgList.Objects[I]) then
                begin
                  g_DenySayMsgList.Delete(I);
                end;
              end;
              nCheckCode := 9;
            finally
              g_DenySayMsgList.UnLock;
            end;
          end;
          nCheckCode := 10;
          //间隔刷新排行榜
          if GetTickCount > dwSortArrayTick then
          begin
            dwSortArrayTick := GetTickCount + 3 * 60 * 1000;
            FrmDB.LoadTaxisList;
          end;
          {if GetTickCount > dwPlacingItemTick then begin
            dwPlacingItemTick:=GetTickCount+10* 60 * 1000;
            g_PlacingItem.SaveAllList;
          end; }
          nCheckCode := 11;
        except
          MainOutMessage('[Exception] ProcessGameRun nCode=' +
            IntToStr(nCheckCode));
        end;
      finally
        LeaveCriticalSection(ProcessHumanCriticalSection);
      end;
    except
      MainOutMessage('[Exception] svMain nIdx 47');
    end;
  except
    MainOutMessage('[Exception] UnsvMain.ProcessGameRun');
  end;
end;

procedure TFrmMain.MENU_VIEW_GATEClick(Sender: TObject);
begin
  try
    MENU_VIEW_GATE.Checked := not MENU_VIEW_GATE.Checked;
    GridGate.Visible := MENU_VIEW_GATE.Checked;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_VIEW_GATEClick');
  end;
end;

procedure TFrmMain.MENU_VIEW_SESSIONClick(Sender: TObject);
begin
  try
    frmViewSession := TfrmViewSession.Create(Owner);
    frmViewSession.Top := Top + 20;
    frmViewSession.Left := Left;
    frmViewSession.Open();
    frmViewSession.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_VIEW_SESSIONClick');
  end;
end;

procedure TFrmMain.MENU_VIEW_ONLINEHUMANClick(Sender: TObject);
begin
  try
    frmViewOnlineHuman := TfrmViewOnlineHuman.Create(Owner);
    frmViewOnlineHuman.Top := Top + 20;
    frmViewOnlineHuman.Left := Left;
    frmViewOnlineHuman.Open();
    frmViewOnlineHuman.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_VIEW_ONLINEHUMANClick');
  end;
end;

procedure TFrmMain.MENU_VIEW_LEVELClick(Sender: TObject);
begin
  try
    frmViewLevel := TfrmViewLevel.Create(Owner);
    frmViewLevel.Top := Top + 20;
    frmViewLevel.Left := Left;
    frmViewLevel.Open();
    frmViewLevel.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_VIEW_LEVELClick');
  end;
end;

procedure TFrmMain.MENU_VIEW_LISTClick(Sender: TObject);
begin
  try
    frmViewList := TfrmViewList.Create(Owner);
    frmViewList.Top := Top + 20;
    frmViewList.Left := Left;
    frmViewList.Open();
    frmViewList.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_VIEW_LISTClick');
  end;
end;

procedure TFrmMain.MENU_MANAGE_ONLINEMSGClick(Sender: TObject);
begin
  try
    frmOnlineMsg := TfrmOnlineMsg.Create(Owner);
    frmOnlineMsg.Top := Top + 20;
    frmOnlineMsg.Left := Left;
    frmOnlineMsg.Open();
    frmOnlineMsg.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_MANAGE_ONLINEMSGClick');
  end;
end;

procedure TFrmMain.SetMenu;
begin
  try
    FrmMain.Menu := MainMenu;
  except
    MainOutMessage('[Exception] TFrmMain.SetMenu');
  end;
end;

procedure TFrmMain.MENU_VIEW_KERNELINFOClick(Sender: TObject);
begin
  try
    frmViewKernelInfo := TfrmViewKernelInfo.Create(Owner);
    frmViewKernelInfo.Top := Top + 20;
    frmViewKernelInfo.Left := Left;
    frmViewKernelInfo.Open();
    frmViewKernelInfo.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_VIEW_KERNELINFOClick');
  end;
end;

procedure TFrmMain.MENU_TOOLS_MERCHANTClick(Sender: TObject);
begin
  try
    frmConfigMerchant := TfrmConfigMerchant.Create(Owner);
    frmConfigMerchant.Top := Top + 20;
    frmConfigMerchant.Left := Left;
    frmConfigMerchant.Open();
    frmConfigMerchant.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_TOOLS_MERCHANTClick');
  end;
end;

procedure TFrmMain.MENU_OPTION_ITEMFUNCClick(Sender: TObject);
begin
  try
    frmItemSet := TfrmItemSet.Create(Owner);
    frmItemSet.Top := Top + 20;
    frmItemSet.Left := Left;
    frmItemSet.Open();
    frmItemSet.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_OPTION_ITEMFUNCClick');
  end;
end;

procedure TFrmMain.ClearMemoLog;
begin
  try
    if Application.MessageBox('是否确定清除日志信息?', '提示信息',
      MB_YESNO + MB_ICONQUESTION) = mrYes then
    begin
      MemoLog.Clear;
    end;
  except
    MainOutMessage('[Exception] TFrmMain.ClearMemoLog');
  end;
end;

procedure TFrmMain.MENU_TOOLS_MONGENClick(Sender: TObject);
begin
  try
    frmConfigMonGen := TfrmConfigMonGen.Create(Owner);
    frmConfigMonGen.Top := Top + 20;
    frmConfigMonGen.Left := Left;
    frmConfigMonGen.Open();
    frmConfigMonGen.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_TOOLS_MONGENClick');
  end;
end;

procedure TFrmMain.MyMessage(var MsgData: TWmCopyData);
var
  wIdent: Integer;
begin
  try
    wIdent := MsgData.From;
    case wIdent of //
      GS_QUIT:
        begin
          FreePlug;
          g_boExitServer := True;
          CloseGateSocket();
          g_Config.boKickAllUser := True;
          CloseTimer.Enabled := True;
        end;
      1: ;
      2: ;
      3: ;
      SM_MSG: {ShowMessage('完成')};
    end; // case
  except
    MainOutMessage('[Exception] TFrmMain.MyMessage');
  end;
end;

procedure TFrmMain.MENU_TOOLS_IPSEARCHClick(Sender: TObject);
var
  sIPaddr: string;
begin
  try
    sIPaddr := InputBox('IP所在地区查询', '输入IP地址:',
      '192.168.0.1');
    if not IsIPaddr(sIPaddr) then
    begin
      Application.MessageBox('输入的IP地址格式不正确！！！',
        '错误信息', MB_OK + MB_ICONERROR);
      exit;
    end;
    if not IsIPaddr(sIPaddr) then
    begin
      Application.MessageBox('输入的IP地址格式不正确！！！',
        '错误信息', MB_OK + MB_ICONERROR);
      exit;
    end;
    MemoLog.Lines.Add(format('%s:%s', [sIPaddr, GetIPLocal(sIPaddr)]));
  except
    MainOutMessage('[Exception] TFrmMain.MENU_TOOLS_IPSEARCHClick');
  end;
end;

procedure TFrmMain.MENU_MANAGE_CASTLEClick(Sender: TObject);
begin
  try
    frmCastleManage := TfrmCastleManage.Create(Owner);
    frmCastleManage.Top := Top + 20;
    frmCastleManage.Left := Left;
    frmCastleManage.Open();
    frmCastleManage.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_MANAGE_CASTLEClick');
  end;
end;

procedure TFrmMain.MENU_MANAGE_PLUGClick(Sender: TObject);
begin
  try
    FormPlug := TFormPlug.Create(Owner);
    FormPlug.Top := Top + 20;
    FormPlug.Left := Left;
    FormPlug.Open();
    FormPlug.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_MANAGE_PLUGClick');
  end;
end;

procedure TFrmMain.MENU_VIEW_LIST2Click(Sender: TObject);
begin
  try
    FormList2 := TFormList2.Create(Owner);
    FormList2.Top := Top + 20;
    FormList2.Left := Left;
    FormList2.Open();
    FormList2.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_VIEW_LIST2Click');
  end;
end;

procedure TFrmMain.N1Click(Sender: TObject);
{var
  Envir:TEnvirnoment;
  FPath: TPath;
  I:integer;}
//var
  //PlayObject:TPlayObject;
//  sIPAddr:String;
begin
  try
    //g_Config.nCheckCount:=10;
    //PlayObject:=TPlayObject(UserEngine.m_PlayObjectList.Objects[0]);
    //PlayObject.SendDefMessage(SM_SELFONE,0,0,0,0,'私服，美女，电影，想看吗？ 来 92sf.com(就要舒服)');
    //PlayObject.SendDefMessage(SM_SELFTWO,0,0,0,0,'http://www.js991.com');
    //PlayObject.SendDefMessage(SM_SELFWEB,0,0,0,0,'最新私服大全|http://www.js991.com');
    //PlayObject.SendDefMessage(SM_SELFTOP,0,MakeWord(252,0),0,0,'找私服，请到Http://www.92sf.com，有你想要的！');
    //PlayObject.SendDefMessage(SM_SELFCENET,15000,MakeWord(252,0),0,0,'http://www.js991.com');
    //sIPaddr:=InputBox('消息','参数编码:','0');  SM_SELFSYS
    //PlayObject.SendDefMessage(SM_LOADURL,0,0,0,0,Format(FrmMain.RSA1.DecryptStr(MS_CHECKME),[GetMD5Text(MS_VER),GetCPUIDText(GetCPUID,True)]));
    //PlayObject.SendServerConfig22;
    //PlayObject.SendDefMessage(SM_LOADURL,0,0,0,0,'http://www.js991.com/cc.txt');
    {Envir:=g_MapManager.FindMap('K004');
    g_MapFind.LoadMap(Envir);
    g_MapFind.SetStartPos(29,23,0);
    FPath:=g_MapFind.FindPath(58,43);
    for i := 0 to High(FPath) do //
    begin
      MainOutMessage(Format('%d/%d',[FPath[i].X, FPath[i].Y]));
    end; }
    {sIPaddr:=InputBox('消息','参数编码:','0');
    n1:=Str_ToInt(sIPaddr,0);
    sIPaddr:=InputBox('消息','消息ID:','0');
    n2:=Str_ToInt(sIPaddr,0);
    sIPaddr:=InputBox('消息','参数一:','0');
    n3:=Str_ToInt(sIPaddr,0);
    sIPaddr:=InputBox('消息','参数二:','0');
    n4:=Str_ToInt(sIPaddr,0);
    sIPaddr:=InputBox('消息','参数三:','0');
    n5:=Str_ToInt(sIPaddr,0);
    sIPaddr:=InputBox('消息','消息内容','');
    UserEngine.SendDefMessage(n2,n1,n3,n4,n5,sIPaddr);}
  except
    MainOutMessage('[Exception] TFrmMain.N1Click');
  end;
end;

procedure TFrmMain.S1Click(Sender: TObject);
begin
  try
    FormTaxis := TFormTaxis.Create(Owner);
    FormTaxis.Top := Top + 20;
    FormTaxis.Left := Left;
    FormTaxis.Open();
    FormTaxis.Free;
  except
    MainOutMessage('[Exception] TFrmMain.S1Click');
  end;
end;

procedure TFrmMain.MENU_MANAGE_GUILDClick(Sender: TObject);
begin
  try
    FormGuild := TFormGuild.Create(Owner);
    FormGuild.Top := Self.Top + 20;
    FormGuild.Left := Self.Left;
    FormGuild.Open;
    FormGuild.Free;
  except
    MainOutMessage('[Exception] TFrmMain.MENU_MANAGE_GUILDClick');
  end;
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_MANAGEClick(Sender: TObject);
begin
  if Sender = MENU_CONTROL_RELOAD_MANAGE then
  begin
    if g_ManageNPC <> nil then
    begin
      g_ManageNPC.ClearScript();
      g_ManageNPC.LoadNPCScript();
      MainOutMessage('重新加载登录脚本完成...');
    end
    else
    begin
      MainOutMessage('重新加载登录脚本失败...');
    end;
  end
  else
  begin
    if g_FunctionNPC <> nil then
    begin
      g_FunctionNPC.ClearScript();
      g_FunctionNPC.LoadNPCScript();
      MainOutMessage('重新加载功能脚本完成...');
    end
    else
    begin
      MainOutMessage('重新加载功能脚本失败...');
    end;
  end;
end;

procedure TFrmMain.MENU_CONTROL_CLEARSERVERVAR_INTEGERClick(
  Sender: TObject);
var
  I: Integer;
begin
  if Application.MessageBox('是否确定清除数字全局变量?',
    '提示信息', MB_YESNO + MB_ICONQUESTION) = mrYes then
  begin
    for I := Low(g_Config.GlobalVal) to High(g_Config.GlobalVal) do
    begin
      g_Config.GlobalVal[I] := 0;
      Config.WriteInteger('Setup', 'GlobalVal' + IntToStr(I),
        g_Config.GlobalVal[I])
    end;
    MainOutMessage('全局数字G变量清除完成...');
  end;
end;

procedure TFrmMain.MENU_CONTROL_CLEARSERVERVAR_STRINGClick(
  Sender: TObject);
var
  I: Integer;
begin
  if Application.MessageBox('是否确定清除字符串全局变量?',
    '提示信息', MB_YESNO + MB_ICONQUESTION) = mrYes then
  begin
    for I := Low(g_Config.GlobalStrVal) to High(g_Config.GlobalStrVal) do
    begin
      g_Config.GlobalStrVal[I] := '';
      Config.WriteString('Setup', 'GlobalStrVal' + IntToStr(I),
        g_Config.GlobalStrVal[I]);
    end;
    MainOutMessage('全局字符串A变量清除完成...');
  end;
end;

procedure TFrmMain.MENU_CONTROL_CLEARSERVERVARClick(Sender: TObject);
begin
  try
    FormGloblVal := TFormGloblVal.Create(Owner);
    FormGloblVal.Top := Top + 20;
    FormGloblVal.Left := Left;
    FormGloblVal.Open();
    FormGloblVal.Free;
  except
    MainOutMessage('[Exception] TFrmMain.S1Click');
  end;
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_BOXSClick(Sender: TObject);
var
  i, nCode: Integer;
begin
  try
    for I := 0 to BoxsList.Count - 1 do
    begin
      pTBoxList(BoxsList.Items[I]).ShowItem.Free;
      pTBoxList(BoxsList.Items[I]).NoItem.Free;
      pTBoxList(BoxsList.Items[I]).EnItem.Free;
      DisPose(pTBoxList(BoxsList.Items[I]));
    end;
    BoxsList.Clear;
    nCode := LoadBoxsList;
    if nCode < 0 then
    begin
      MainOutMessage('加载宝箱配置失败.' + 'Code= ' + IntToStr(nCode));
      exit;
    end;
    MainOutMessage(format('宝箱配置加载成功(%d)...', [BoxsList.Count]));
  except
  end;
end;

procedure TFrmMain.FormActivate(Sender: TObject);
begin
  if AntiMonitor or
    AntiLoader or
    AntiSoftICE then
  begin
    Close;
    exit;
  end;
end;

initialization
  begin

  end;
finalization
  begin

  end;

end.

