//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit InterMsgClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JSocket;

type
  TFrmMsgClient = class(TForm)
    MsgClient: TClientSocket;
    procedure MsgClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure MsgClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure MsgClientRead(Sender: TObject; Socket: TCustomWinSocket);
  private
    dw2D4Tick: LongWord;
    sRecvMsg: string; //0x2D8
    procedure DecodeSocStr;
    { Private declarations }
  public
    procedure SendSocket(sMsg: string);
    procedure ConnectMsgServer();
    procedure Run();
    { Public declarations }
  end;

var
  FrmMsgClient: TFrmMsgClient;

implementation

uses M2Share, HUtil32, EDcode, Grobal2;

{$R *.dfm}

{ TFrmMsgClient }

procedure TFrmMsgClient.ConnectMsgServer; //00495E68
begin
  try
    try
      MsgClient.Active := False;
      MsgClient.Address := g_Config.sMsgSrvAddr;
      MsgClient.Port := g_Config.nMsgSrvPort;
      dw2D4Tick := GetTickCount();
    except
      MainOutMessage('[Exception] TFrmMsgClient.ConnectMsgServer');
    end;
  except
    MainOutMessage('[Exception] TFrmMsgClient.ConnectMsgServer');
  end;
end;

procedure TFrmMsgClient.Run; //00496360
begin
  try
    try
      if MsgClient.Socket.Connected then
      begin
        DecodeSocStr();
      end
      else
      begin
        if GetTickCount - dw2D4Tick > 20 * 1000 then
        begin
          dw2D4Tick := GetTickCount();
          MsgClient.Active := True;
        end;
      end;
{$IF (DEBUG = 0) and (SoftVersion <> VERDEMO)}
      if IsDebuggerPresent then
        Application.Terminate;
{$IFEND}
    except
      MainOutMessage('[Exception] TFrmMsgClient.Run');
    end;
  except
    MainOutMessage('[Exception] TFrmMsgClient.Run');
  end;
end;

procedure TFrmMsgClient.DecodeSocStr; //00496020
var
  sData, sC, s10, s14, s18: string;
  n1C {,n20}: Integer;
resourcestring
  sExceptionMsg = '[Exception] FrmIdSoc::DecodeSocStr';
begin
  try
    try
      if Pos(')', sRecvMsg) <= 0 then
        exit;
      sData := sRecvMsg;
      sRecvMsg := '';
      while (True) do
      begin
        sData := ArrestStringEx(sData, '(', ')', sC);
        if sC = '' then
          break;
        s14 := GetValidStr3(sC, s10, ['/']);
        s14 := GetValidStr3(s14, s18, ['/']);
        n1C := Str_ToInt(s10, 0);
        //    n20:=Str_ToInt(DecodeString(s18),-1);
        case n1C of //
          SS_200: ;
          SS_201: ;
          SS_202: ;
          SS_WHISPER: ;
          SS_204: ;
          SS_205: ;
          SS_206: ;
          SS_207: ;
          SS_208: ;
          SS_209: ;
          SS_210: ;
          SS_211: ;
          SS_212: ;
          SS_213: ;
          SS_214: ;
        end;
        if Pos(')', sData) <= 0 then
          break;
      end;
    except
      MainOutMessage(sExceptionMsg);
    end;
  except
    MainOutMessage('[Exception] TFrmMsgClient.DecodeSocStr');
  end;
end;

procedure TFrmMsgClient.SendSocket(sMsg: string); //00495F74
begin
  try
    if MsgClient.Socket.Connected then
      MsgClient.Socket.SendText('(' + sMsg + ')');
  except
    MainOutMessage('[Exception] TFrmMsgClient.SendSocket');
  end;
end;

procedure TFrmMsgClient.MsgClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  try
    sRecvMsg := '';
  except
    MainOutMessage('[Exception] TFrmMsgClient.MsgClientConnect');
  end;
end;

procedure TFrmMsgClient.MsgClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  try
    Socket.Close;
    ErrorCode := 0;
  except
    MainOutMessage('[Exception] TFrmMsgClient.MsgClientError');
  end;
end;

procedure TFrmMsgClient.MsgClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  try
    sRecvMsg := sRecvMsg + Socket.ReceiveText;
  except
    MainOutMessage('[Exception] TFrmMsgClient.MsgClientRead');
  end;
end;

end.

