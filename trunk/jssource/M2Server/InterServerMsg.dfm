object FrmSrvMsg: TFrmSrvMsg
  Left = 696
  Top = 55
  Caption = 'FrmSrvMsg'
  ClientHeight = 86
  ClientWidth = 185
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MsgServer: TServerSocket
    Active = False
    Address = '0.0.0.0'
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = MsgServerClientConnect
    OnClientDisconnect = MsgServerClientDisconnect
    OnClientRead = MsgServerClientRead
    OnClientError = MsgServerClientError
    Left = 27
    Top = 16
  end
end
