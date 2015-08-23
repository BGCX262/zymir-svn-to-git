object FrmMsgClient: TFrmMsgClient
  Left = 488
  Top = 94
  Caption = 'FrmMsgClient'
  ClientHeight = 62
  ClientWidth = 162
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MsgClient: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = MsgClientConnect
    OnRead = MsgClientRead
    OnError = MsgClientError
    Left = 21
    Top = 17
  end
end
