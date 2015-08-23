//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit InterServerMsg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JSocket, ObjBase;

type
  TServerMsgInfo = record
    Socket: TCustomWinSocket;
    s2E0: string;
  end;
  pTServerMsgInfo = ^TServerMsgInfo;
  TFrmSrvMsg = class(TForm)
    MsgServer: TServerSocket;
    procedure MsgServerClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure MsgServerClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure MsgServerClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure MsgServerClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormCreate(Sender: TObject);
  private
    SrvArray: array[0..9] of TServerMsgInfo;
    //    procedure DecodeSocStr;
    //    procedure MsgGetUserServerChange;
    procedure SendSocket(Socket: TCustomWinSocket; sMsg: string);
    { Private declarations }
  public
    //    constructor Create();
    //    destructor Destroy; override;
    procedure SendSocketMsg(sMsg: string);
    procedure StartMsgServer();
    procedure Run();
    { Public declarations }
  end;

var
  FrmSrvMsg: TFrmSrvMsg;

implementation

uses M2Share, Grobal2;

{$R *.dfm}

{ TFrmSrvMsg }

procedure TFrmSrvMsg.Run; //004975C8
begin
  try
    try
{$IF (DEBUG = 0) and (SoftVersion <> VERDEMO)}
      if IsDebuggerPresent then
        Application.Terminate;
{$IFEND}
    except
      MainOutMessage('[Exception] TFrmSrvMsg.Run');
    end;
  except
    MainOutMessage('[Exception] TFrmSrvMsg.Run');
  end;
end;

procedure TFrmSrvMsg.StartMsgServer; //004966B0
resourcestring
  sExceptionMsg = '[Exception] TFrmSrvMsg::StartMsgServer';
begin
  try
    try
      MsgServer.Active := False;
      MsgServer.Address := g_Config.sMsgSrvAddr;
      MsgServer.Port := g_Config.nMsgSrvPort;
      MsgServer.Active := True;
    except
      on e: Exception do
      begin
        MainOutMessage(sExceptionMsg);
        MainOutMessage(E.Message);
      end;
    end;
  except
    MainOutMessage('[Exception] TFrmSrvMsg.StartMsgServer');
  end;
end;
{procedure TFrmSrvMsg.DecodeSocStr;//00496A0C
begin
Try

Except
  MainOutMessage('[Exception] TFrmSrvMsg.DecodeSocStr');
End;
end;
{procedure TFrmSrvMsg.MsgGetUserServerChange;//00496D10
begin
Try

Except
  MainOutMessage('[Exception] TFrmSrvMsg.MsgGetUserServerChange');
End;
end; }

procedure TFrmSrvMsg.SendSocket(Socket: TCustomWinSocket; sMsg: string);
//0049685C
begin
  try
    if Socket.Connected then
      Socket.SendText('(' + sMsg + ')');
  except
    MainOutMessage('[Exception] TFrmSrvMsg.SendSocket');
  end;
end;

procedure TFrmSrvMsg.SendSocketMsg(sMsg: string);
var
  I: Integer;
  ServerMsgInfo: pTServerMsgInfo;
begin
  try
    for I := Low(SrvArray) to High(SrvArray) do
    begin
      ServerMsgInfo := @SrvArray[I];
      if ServerMsgInfo.Socket <> nil then
        SendSocket(ServerMsgInfo.Socket, sMsg);
    end;
  except
    MainOutMessage('[Exception] TFrmSrvMsg.SendSocketMsg');
  end;
end;

procedure TFrmSrvMsg.MsgServerClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I: Integer;
  ServerMsgInfo: pTServerMsgInfo;
begin
  try
    try
      for I := Low(SrvArray) to High(SrvArray) do
      begin
        ServerMsgInfo := @SrvArray[I];
        if ServerMsgInfo.Socket = nil then
        begin
          ServerMsgInfo.Socket := Socket;
          ServerMsgInfo.s2E0 := '';
          Socket.nIndex := I;
        end;
      end;
    except
      MainOutMessage('[Exception] TFrmSrvMsg.MsgServerClientConnec');
    end;
  except
    MainOutMessage('[Exception] TFrmSrvMsg.MsgServerClientConnect');
  end;
end;

procedure TFrmSrvMsg.MsgServerClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I: Integer;
  ServerMsgInfo: pTServerMsgInfo;
begin
  try
    try
      for I := Low(SrvArray) to High(SrvArray) do
      begin
        ServerMsgInfo := @SrvArray[I];
        if ServerMsgInfo.Socket = Socket then
        begin
          ServerMsgInfo.Socket := nil;
          ServerMsgInfo.s2E0 := '';
        end;
      end;
    except
      MainOutMessage('[Exception] TFrmSrvMsg.MsgServerClientDisconnect');
    end;
  except
    MainOutMessage('[Exception] TFrmSrvMsg.MsgServerClientDisconnect');
  end;
end;

procedure TFrmSrvMsg.MsgServerClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  try
    Socket.Close;
    ErrorCode := 0;
  except
    MainOutMessage('[Exception] TFrmSrvMsg.MsgServerClientError');
  end;
end;

procedure TFrmSrvMsg.MsgServerClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  nC: Integer;
begin
  try
    try
      nC := Socket.nIndex;
      if (nC >= 0) and (nC <= High(SrvArray)) and (SrvArray[nC].Socket = Socket)
        then
      begin
        SrvArray[nC].s2E0 := SrvArray[nC].s2E0 + Socket.ReceiveText;
      end;
    except
      MainOutMessage('[Exception] TFrmSrvMsg.MsgServerClientRead');
    end;
  except
    MainOutMessage('[Exception] TFrmSrvMsg.MsgServerClientRead');
  end;
end;

procedure TFrmSrvMsg.FormCreate(Sender: TObject);
begin
  try
    FillChar(SrvArray, SizeOf(SrvArray), 0);
  except
    MainOutMessage('[Exception] TFrmSrvMsg.Create');
  end;
end;

end.

