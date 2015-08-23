object FormWEB: TFormWEB
  Left = 183
  Top = 100
  BorderStyle = bsNone
  Caption = 'FormWEB'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 571
    Width = 800
    Height = 29
    Align = alBottom
    Color = clBlack
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 9
      Width = 30
      Height = 12
      Caption = #22320#22336':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzButton1: TRzButton
      Left = 742
      Top = 3
      Width = 55
      Height = 24
      FrameColor = 7617536
      Caption = #36820#22238'(&X)'
      Color = 15791348
      HotTrack = True
      TabOrder = 2
      OnClick = Button1Click
    end
    object RzButton2: TRzButton
      Left = 677
      Top = 3
      Width = 59
      Height = 24
      FrameColor = 7617536
      Caption = #36716#21040'(&G)'
      Color = 15791348
      HotTrack = True
      TabOrder = 1
      OnClick = RzButton2Click
    end
    object Edit1: TEdit
      Left = 58
      Top = 4
      Width = 610
      Height = 21
      TabOrder = 0
      Text = 'Edit1'
      OnKeyPress = Edit1KeyPress
    end
  end
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 0
    Width = 800
    Height = 571
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 434
    ExplicitHeight = 211
    ControlData = {
      4C000000AF520000043B00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
