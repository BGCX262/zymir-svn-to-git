unit CenterShare;

interface
uses
Classes,Messages,windows,SysUtils,StrUtils;

const
  RM_DBServer         = 0;
  RM_LogSrv           = 1;
  RM_LogServer        = 2;
  RM_M2Server         = 3;
  RM_LoginGate        = 4;
  RM_SelGate          = 6;
  RM_RunGate          = 8;
  RM_MAX              = 9;

  
  SM_HANDLE   = 1000;
  SM_START    = 1001;
  SM_STARTOK  = 1002;
  SM_MSG      = 1010;

  GS_QUIT     = 131072000;
var
  g_dwGameCenterHandle  : Integer = 0;

procedure SendQuitMsg(nHandle:Integer);
procedure SendGameCenterMsg(nRunSoft:Integer;nSend:Integer;sSendMsg:String);

implementation

procedure SendGameCenterMsg(nRunSoft:Integer;nSend:Integer;sSendMsg:String);
var
  SendData:TCopyDataStruct;
  wIdent  :Integer;
begin
  wIdent  :=(nSend shl 16) + nRunSoft;
  SendData.cbData:=Length (sSendMsg) + 1;
  GetMem(SendData.lpData,SendData.cbData);
  StrCopy (SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle,WM_COPYDATA,wIdent,Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

procedure SendQuitMsg(nHandle:Integer);
var
  SendData:TCopyDataStruct;
begin
  GetMem(SendData.lpData,SendData.cbData);
  SendMessage(nHandle,WM_COPYDATA,GS_QUIT,Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

end.
