object frmViewOnlineHuman: TfrmViewOnlineHuman
  Left = 251
  Top = 192
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22312#32447#20154#29289
  ClientHeight = 408
  ClientWidth = 944
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 215
    Top = 237
    Width = 30
    Height = 12
    Caption = #25490#24207':'
  end
  object PanelStatus: TPanel
    Left = 8
    Top = 96
    Width = 923
    Height = 305
    BevelOuter = bvNone
    TabOrder = 0
    object GridHuman: TStringGrid
      Left = 0
      Top = 0
      Width = 923
      Height = 305
      Align = alClient
      ColCount = 15
      DefaultRowHeight = 18
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 0
      OnDblClick = GridHumanDblClick
      ColWidths = (
        33
        78
        31
        44
        39
        37
        47
        74
        89
        32
        138
        59
        55
        57
        64)
    end
  end
  object ButtonRefGrid: TButton
    Left = 3
    Top = 13
    Width = 70
    Height = 25
    Caption = #21047#26032'(&R)'
    TabOrder = 1
    OnClick = ButtonRefGridClick
  end
  object ComboBoxSort: TComboBox
    Left = 178
    Top = 17
    Width = 114
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 2
    OnClick = ComboBoxSortClick
    Items.Strings = (
      #21517#31216
      #24615#21035
      #32844#19994
      #31561#32423
      #22320#22270
      #65321#65328
      #26435#38480
      #25152#22312#22320#21306)
  end
  object EditSearchName: TEdit
    Left = 299
    Top = 17
    Width = 128
    Height = 20
    TabOrder = 3
  end
  object ButtonSearch: TButton
    Left = 438
    Top = 14
    Width = 70
    Height = 25
    Caption = #25628#32034'(&S)'
    TabOrder = 4
    OnClick = ButtonSearchClick
  end
  object ButtonView: TButton
    Left = 516
    Top = 14
    Width = 80
    Height = 25
    Caption = #20154#29289#20449#24687'(&H)'
    TabOrder = 5
    OnClick = ButtonViewClick
  end
  object CheckBoxShowHero: TCheckBox
    Left = 100
    Top = 20
    Width = 73
    Height = 12
    Caption = #26174#31034#33521#38596
    TabOrder = 6
  end
  object GroupBox1: TGroupBox
    Left = 628
    Top = 8
    Width = 303
    Height = 81
    Caption = #36386#20154#36873#39033
    TabOrder = 7
    object Label2: TLabel
      Left = 127
      Top = 24
      Width = 36
      Height = 12
      Caption = #31561#32423'>='
    end
    object Label3: TLabel
      Left = 225
      Top = 24
      Width = 12
      Height = 12
      Caption = '<='
    end
    object ButtonKickLevel: TButton
      Left = 6
      Top = 16
      Width = 99
      Height = 25
      Caption = #36386#38500#33073#26426#20154#29289
      TabOrder = 0
      OnClick = ButtonKickLevelClick
    end
    object EditLowLevel: TSpinEdit
      Left = 170
      Top = 19
      Width = 53
      Height = 21
      MaxValue = 65535
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
    object EditHighLevel: TSpinEdit
      Left = 241
      Top = 19
      Width = 53
      Height = 21
      MaxValue = 65535
      MinValue = 0
      TabOrder = 2
      Value = 10
    end
    object ButtonKickName: TButton
      Left = 6
      Top = 48
      Width = 99
      Height = 25
      Caption = #36386#38500#25351#23450#21517#31216
      TabOrder = 3
      OnClick = ButtonKickNameClick
    end
    object EditName: TEdit
      Left = 172
      Top = 50
      Width = 123
      Height = 20
      TabOrder = 4
      Text = #31186#26432
    end
    object CheckBoxIn: TCheckBox
      Left = 127
      Top = 52
      Width = 41
      Height = 17
      Hint = #22914#26524#35813#39033#34987#36873#20013#65292#21017#21482#35201#20154#29289#21517#31216#20013#24102#26377#25351#23450#30340#25991#23383#37117#23558#34987#36386#19979#32447#12290#21542#21017#65292#21482#36386#38500#25351#23450#25991#23383#30340#20154#29289#21517#31216#12290
      Caption = #21253#21547
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 5
    end
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 136
    Top = 96
  end
end
