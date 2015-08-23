object FormGuild: TFormGuild
  Left = 502
  Top = 239
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #34892#20250#31649#29702'('#26410#23436#25104')'
  ClientHeight = 272
  ClientWidth = 524
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 201
    Height = 257
    Caption = #34892#20250#21015#34920
    TabOrder = 0
    object ListViewGuild: TListView
      Left = 8
      Top = 16
      Width = 185
      Height = 233
      Columns = <
        item
          Caption = #24207#21495
          Width = 40
        end
        item
          Caption = #34892#20250#21517#31216
          Width = 125
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object GroupBox2: TGroupBox
    Left = 216
    Top = 8
    Width = 297
    Height = 105
    Caption = #34892#20250#35774#32622
    TabOrder = 1
    object Label1: TLabel
      Left = 9
      Top = 19
      Width = 102
      Height = 12
      Caption = #34892#20250#26368#22823#25104#21592#19978#38480':'
    end
    object EditGuildMemberCount: TSpinEdit
      Left = 113
      Top = 15
      Width = 55
      Height = 21
      Hint = #27599#20010#34892#20250#26368#22823#25104#21592#25968#37327#65292#24314#35758#22312'200 - 300 '#20043#38388#12290
      EditorEnabled = False
      Increment = 10
      MaxValue = 800
      MinValue = 50
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 50
      OnChange = EditGuildMemberCountChange
    end
    object ButtonSave: TButton
      Left = 211
      Top = 72
      Width = 75
      Height = 25
      Caption = #20445#23384'(&S)'
      Enabled = False
      TabOrder = 1
      OnClick = ButtonSaveClick
    end
  end
end
