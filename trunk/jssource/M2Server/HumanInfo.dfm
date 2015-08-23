object frmHumanInfo: TfrmHumanInfo
  Left = 538
  Top = 152
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20154#29289#23646#24615
  ClientHeight = 353
  ClientWidth = 656
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 10
    Top = 10
    Width = 639
    Height = 258
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #20154#29289#20449#24687
      object GroupBox1: TGroupBox
        Left = 10
        Top = 10
        Width = 207
        Height = 215
        Caption = #26597#30475#20449#24687
        TabOrder = 0
        object Label1: TLabel
          Left = 9
          Top = 18
          Width = 54
          Height = 12
          Caption = #20154#29289#26631#35782':'
        end
        object Label2: TLabel
          Left = 9
          Top = 65
          Width = 54
          Height = 12
          Caption = #25152#22312#22320#22270':'
        end
        object Label3: TLabel
          Left = 9
          Top = 88
          Width = 54
          Height = 12
          Caption = #25152#22312#24231#26631':'
        end
        object Label4: TLabel
          Left = 9
          Top = 112
          Width = 54
          Height = 12
          Caption = #30331#24405#36134#21495':'
        end
        object Label5: TLabel
          Left = 9
          Top = 137
          Width = 42
          Height = 12
          Caption = #30331#24405'IP:'
        end
        object Label6: TLabel
          Left = 9
          Top = 160
          Width = 54
          Height = 12
          Caption = #30331#24405#26102#38388':'
        end
        object Label7: TLabel
          Left = 9
          Top = 186
          Width = 54
          Height = 12
          Caption = #22312#32447#26102#38271':'
        end
        object Label20: TLabel
          Left = 9
          Top = 42
          Width = 54
          Height = 12
          Caption = #20154#29289#21517#31216':'
        end
        object EditName: TEdit
          Left = 66
          Top = 37
          Width = 133
          Height = 20
          ReadOnly = True
          TabOrder = 0
          Text = 'EditName'
        end
        object EditMap: TEdit
          Left = 66
          Top = 61
          Width = 133
          Height = 20
          ReadOnly = True
          TabOrder = 1
          Text = 'Edit1'
        end
        object EditXY: TEdit
          Left = 66
          Top = 84
          Width = 133
          Height = 20
          ReadOnly = True
          TabOrder = 2
          Text = 'Edit1'
        end
        object EditAccount: TEdit
          Left = 66
          Top = 108
          Width = 133
          Height = 20
          ReadOnly = True
          TabOrder = 3
          Text = 'Edit1'
        end
        object EditIPaddr: TEdit
          Left = 66
          Top = 132
          Width = 133
          Height = 20
          ReadOnly = True
          TabOrder = 4
          Text = 'Edit1'
        end
        object EditLogonTime: TEdit
          Left = 66
          Top = 156
          Width = 133
          Height = 20
          ReadOnly = True
          TabOrder = 5
          Text = 'Edit1'
        end
        object EditLogonLong: TEdit
          Left = 66
          Top = 182
          Width = 133
          Height = 20
          ReadOnly = True
          TabOrder = 6
          Text = 'Edit1'
        end
        object EditIdx: TEdit
          Left = 66
          Top = 13
          Width = 133
          Height = 20
          ReadOnly = True
          TabOrder = 7
          Text = 'EditIdx'
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #26222#36890#25968#25454
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox2: TGroupBox
        Left = 10
        Top = 10
        Width = 154
        Height = 119
        Caption = #21487#35843#23646#24615
        TabOrder = 0
        object Label12: TLabel
          Left = 9
          Top = 18
          Width = 30
          Height = 12
          Caption = #31561#32423':'
        end
        object Label8: TLabel
          Left = 9
          Top = 42
          Width = 42
          Height = 12
          Caption = #37329#24065#25968':'
        end
        object Label9: TLabel
          Left = 9
          Top = 65
          Width = 42
          Height = 12
          Caption = 'PK'#28857#25968':'
        end
        object Label10: TLabel
          Left = 9
          Top = 88
          Width = 54
          Height = 12
          Caption = #32463#39564#28857#25968':'
        end
        object EditLevel: TSpinEdit
          Left = 66
          Top = 13
          Width = 69
          Height = 21
          MaxValue = 20000
          MinValue = 0
          TabOrder = 0
          Value = 10
        end
        object EditGold: TSpinEdit
          Left = 66
          Top = 37
          Width = 69
          Height = 21
          Increment = 1000
          MaxValue = 200000000
          MinValue = 0
          TabOrder = 1
          Value = 10
        end
        object EditPKPoint: TSpinEdit
          Left = 66
          Top = 61
          Width = 69
          Height = 21
          Increment = 50
          MaxValue = 20000
          MinValue = 0
          TabOrder = 2
          Value = 10
        end
        object EditExp: TSpinEdit
          Left = 66
          Top = 84
          Width = 69
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 10
        end
      end
      object GroupBox6: TGroupBox
        Left = 10
        Top = 138
        Width = 154
        Height = 76
        Caption = #20154#29289#29366#24577
        TabOrder = 1
        object CheckBoxGameMaster: TCheckBox
          Left = 9
          Top = 15
          Width = 127
          Height = 21
          Caption = 'GM'#27169#24335
          TabOrder = 0
        end
        object CheckBoxSuperMan: TCheckBox
          Left = 9
          Top = 32
          Width = 127
          Height = 21
          Caption = #26080#25932#27169#24335
          TabOrder = 1
        end
        object CheckBoxObserver: TCheckBox
          Left = 9
          Top = 48
          Width = 127
          Height = 21
          Caption = #38544#36523#27169#24335
          TabOrder = 2
        end
      end
      object GroupBox9: TGroupBox
        Left = 170
        Top = 10
        Width = 151
        Height = 204
        Caption = #21487#35843#23646#24615
        TabOrder = 2
        object Label26: TLabel
          Left = 9
          Top = 18
          Width = 42
          Height = 12
          Caption = #28216#25103#24065':'
        end
        object Label27: TLabel
          Left = 10
          Top = 42
          Width = 42
          Height = 12
          Caption = #28216#25103#28857':'
        end
        object Label28: TLabel
          Left = 10
          Top = 65
          Width = 42
          Height = 12
          Caption = #22768#26395#28857':'
        end
        object Label29: TLabel
          Left = 10
          Top = 136
          Width = 54
          Height = 12
          Caption = #23646#24615#28857#19968':'
        end
        object Label19: TLabel
          Left = 10
          Top = 159
          Width = 54
          Height = 12
          Hint = '????????'
          Caption = #23646#24615#28857#20108':'
        end
        object Label21: TLabel
          Left = 10
          Top = 89
          Width = 42
          Height = 12
          Caption = #37329#21018#30707':'
        end
        object Label22: TLabel
          Left = 10
          Top = 112
          Width = 30
          Height = 12
          Hint = '????????'
          Caption = #28789#31526':'
        end
        object EditGameGold: TSpinEdit
          Left = 66
          Top = 13
          Width = 69
          Height = 21
          MaxValue = 20000000
          MinValue = 0
          TabOrder = 0
          Value = 10
        end
        object EditGamePoint: TSpinEdit
          Left = 66
          Top = 37
          Width = 69
          Height = 21
          MaxValue = 200000000
          MinValue = 0
          TabOrder = 1
          Value = 10
        end
        object EditCreditPoint: TSpinEdit
          Left = 66
          Top = 61
          Width = 69
          Height = 21
          MaxValue = 200000000
          MinValue = 0
          TabOrder = 2
          Value = 10
        end
        object EditBonusPoint: TSpinEdit
          Left = 66
          Top = 132
          Width = 69
          Height = 21
          MaxValue = 2000000
          MinValue = 0
          TabOrder = 3
          Value = 10
        end
        object EditEditBonusPointUsed: TSpinEdit
          Left = 66
          Top = 155
          Width = 69
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 4
          Value = 10
        end
        object SpinEditGameDird: TSpinEdit
          Left = 66
          Top = 108
          Width = 69
          Height = 21
          EditorEnabled = False
          MaxValue = 200000000
          MinValue = 0
          TabOrder = 5
          Value = 10
        end
        object SpinEditGameDiam: TSpinEdit
          Left = 66
          Top = 85
          Width = 69
          Height = 21
          MaxValue = 200000000
          MinValue = 0
          TabOrder = 6
          Value = 10
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #23646#24615#28857
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox3: TGroupBox
        Left = 10
        Top = 10
        Width = 167
        Height = 192
        Caption = #20154#29289#23646#24615
        TabOrder = 0
        object Label11: TLabel
          Left = 9
          Top = 18
          Width = 30
          Height = 12
          Caption = #38450#24481':'
        end
        object Label13: TLabel
          Left = 9
          Top = 42
          Width = 30
          Height = 12
          Caption = #39764#38450':'
        end
        object Label14: TLabel
          Left = 9
          Top = 65
          Width = 42
          Height = 12
          Caption = #25915#20987#21147':'
        end
        object Label15: TLabel
          Left = 9
          Top = 88
          Width = 30
          Height = 12
          Caption = #39764#27861':'
        end
        object Label16: TLabel
          Left = 9
          Top = 112
          Width = 30
          Height = 12
          Caption = #36947#26415':'
        end
        object Label17: TLabel
          Left = 9
          Top = 137
          Width = 42
          Height = 12
          Caption = #29983#21629#20540':'
        end
        object Label18: TLabel
          Left = 9
          Top = 160
          Width = 42
          Height = 12
          Caption = #39764#27861#20540':'
        end
        object EditAC: TEdit
          Left = 66
          Top = 13
          Width = 87
          Height = 20
          ReadOnly = True
          TabOrder = 0
          Text = 'EditName'
        end
        object EditMAC: TEdit
          Left = 66
          Top = 37
          Width = 87
          Height = 20
          ReadOnly = True
          TabOrder = 1
          Text = 'EditName'
        end
        object EditDC: TEdit
          Left = 66
          Top = 61
          Width = 87
          Height = 20
          ReadOnly = True
          TabOrder = 2
          Text = 'EditName'
        end
        object EditMC: TEdit
          Left = 66
          Top = 84
          Width = 87
          Height = 20
          ReadOnly = True
          TabOrder = 3
          Text = 'EditName'
        end
        object EditSC: TEdit
          Left = 66
          Top = 108
          Width = 87
          Height = 20
          ReadOnly = True
          TabOrder = 4
          Text = 'EditName'
        end
        object EditHP: TEdit
          Left = 66
          Top = 132
          Width = 87
          Height = 20
          ReadOnly = True
          TabOrder = 5
          Text = 'EditName'
        end
        object EditMP: TEdit
          Left = 66
          Top = 156
          Width = 87
          Height = 20
          ReadOnly = True
          TabOrder = 6
          Text = 'EditName'
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #36523#19978#35013#22791
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox7: TGroupBox
        Left = 10
        Top = 10
        Width = 615
        Height = 202
        Caption = #35013#22791#21015#34920
        TabOrder = 0
        object GridUserItem: TStringGrid
          Left = 10
          Top = 17
          Width = 596
          Height = 175
          ColCount = 10
          DefaultColWidth = 55
          DefaultRowHeight = 18
          RowCount = 14
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
          TabOrder = 0
          ColWidths = (
            55
            67
            63
            68
            45
            45
            44
            43
            46
            87)
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #32972#21253#29289#21697
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox8: TGroupBox
        Left = 10
        Top = 10
        Width = 615
        Height = 202
        Caption = #35013#22791#21015#34920
        TabOrder = 0
        object GridBagItem: TStringGrid
          Left = 10
          Top = 17
          Width = 596
          Height = 175
          ColCount = 10
          DefaultColWidth = 55
          DefaultRowHeight = 18
          RowCount = 14
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
          TabOrder = 0
          ColWidths = (
            55
            67
            63
            68
            45
            45
            44
            43
            46
            88)
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = #20179#24211#29289#21697
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox10: TGroupBox
        Left = 10
        Top = 10
        Width = 615
        Height = 202
        Caption = #35013#22791#21015#34920
        TabOrder = 0
        object GridStorageItem: TStringGrid
          Left = 10
          Top = 17
          Width = 596
          Height = 175
          ColCount = 10
          DefaultColWidth = 55
          DefaultRowHeight = 18
          FixedCols = 0
          RowCount = 14
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
          TabOrder = 0
          ColWidths = (
            55
            67
            63
            67
            45
            45
            44
            43
            46
            89)
        end
      end
    end
  end
  object GroupBox4: TGroupBox
    Left = 10
    Top = 274
    Width = 151
    Height = 73
    Caption = #25511#21046
    TabOrder = 1
    object CheckBoxMonitor: TCheckBox
      Left = 10
      Top = 16
      Width = 111
      Height = 21
      Caption = #23454#26102#30417#25511
      TabOrder = 0
      OnClick = CheckBoxMonitorClick
    end
    object ButtonKick: TButton
      Left = 10
      Top = 38
      Width = 65
      Height = 26
      Caption = #36386#19979#32447
      TabOrder = 1
      OnClick = ButtonKickClick
    end
  end
  object GroupBox5: TGroupBox
    Left = 168
    Top = 274
    Width = 118
    Height = 73
    Caption = #24403#21069#29366#24577
    TabOrder = 2
    object EditHumanStatus: TEdit
      Left = 10
      Top = 28
      Width = 95
      Height = 20
      ReadOnly = True
      TabOrder = 0
    end
  end
  object ButtonSave: TButton
    Left = 340
    Top = 298
    Width = 65
    Height = 26
    Caption = #20462#25913#25968#25454
    TabOrder = 3
    OnClick = ButtonSaveClick
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 144
    Top = 208
  end
end
