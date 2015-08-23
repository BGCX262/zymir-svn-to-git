object frmGeneralConfig: TfrmGeneralConfig
  Left = 440
  Top = 183
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22522#26412#35774#32622
  ClientHeight = 281
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 12
  object Label26: TLabel
    Left = 11
    Top = 262
    Width = 312
    Height = 12
    Caption = #35843#25972#30340#21442#25968#22312#20445#23384#21518#29983#25928#65292#37096#20221#21442#25968#24517#39035#37325#21551#31243#24207#25165#20250#29983#25928
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object PageControl: TPageControl
    Left = 8
    Top = 5
    Width = 401
    Height = 251
    ActivePage = ServerInfoSheet
    TabOrder = 0
    OnChanging = PageControlChanging
    object NetWorkSheet: TTabSheet
      Caption = #32593#32476#35774#32622
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBoxNet: TGroupBox
        Left = 10
        Top = 6
        Width = 183
        Height = 69
        Caption = #32593#20851#25509#21475
        TabOrder = 0
        object LabelGateIPaddr: TLabel
          Left = 10
          Top = 20
          Width = 54
          Height = 12
          Caption = #32465#23450#22320#22336':'
        end
        object LabelGatePort: TLabel
          Left = 10
          Top = 42
          Width = 54
          Height = 12
          Caption = #32593#20851#31471#21475':'
        end
        object EditGateAddr: TEdit
          Left = 79
          Top = 16
          Width = 98
          Height = 20
          Hint = #28216#25103#32593#20851#36830#25509#31471#21475#32465#23450'IP'#65292#27492#37197#32622#19968#33324#29992#20110#22810'IP'#29615#22659#65292#26222#36890#29615#22659#21482#38656#35774#32622#20026'0.0.0.0'#12290
          TabOrder = 0
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
        object EditGatePort: TEdit
          Left = 79
          Top = 39
          Width = 53
          Height = 20
          Hint = #28216#25103#32593#20851#36830#25509#31471#21475#65292#27492#31471#21475#40664#35748#20026'5000'
          TabOrder = 1
          Text = '5000'
          OnChange = EditValueChange
        end
      end
      object ButtonNetWorkSave: TButton
        Left = 316
        Top = 190
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonNetWorkSaveClick
      end
      object GroupBox1: TGroupBox
        Left = 10
        Top = 78
        Width = 183
        Height = 69
        Caption = #25968#25454#24211#26381#21153#22120
        TabOrder = 2
        object Label4: TLabel
          Left = 10
          Top = 42
          Width = 66
          Height = 12
          Caption = #26381#21153#22120#31471#21475':'
        end
        object Label5: TLabel
          Left = 10
          Top = 20
          Width = 66
          Height = 12
          Caption = #26381#21153#22120#22320#22336':'
        end
        object EditDBPort: TEdit
          Left = 79
          Top = 39
          Width = 53
          Height = 20
          Hint = #20154#29289#25968#25454#24211#26381#21153#22120#36830#25509#31471#21475
          TabOrder = 0
          Text = '6000'
          OnChange = EditValueChange
        end
        object EditDBAddr: TEdit
          Left = 79
          Top = 16
          Width = 98
          Height = 20
          Hint = #20154#29289#25968#25454#24211'IP'#22320#22336
          TabOrder = 1
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
      end
      object GroupBox2: TGroupBox
        Left = 202
        Top = 6
        Width = 183
        Height = 69
        Caption = #30331#24405#26381#21153#22120
        TabOrder = 3
        object Label2: TLabel
          Left = 10
          Top = 42
          Width = 66
          Height = 12
          Caption = #26381#21153#22120#31471#21475':'
        end
        object Label3: TLabel
          Left = 10
          Top = 20
          Width = 66
          Height = 12
          Caption = #26381#21153#22120#22320#22336':'
        end
        object EditIDSPort: TEdit
          Left = 79
          Top = 39
          Width = 53
          Height = 20
          Hint = #31649#29702#26381#21153#22120#31471#21475
          TabOrder = 0
          Text = '5600'
          OnChange = EditValueChange
        end
        object EditIDSAddr: TEdit
          Left = 79
          Top = 16
          Width = 98
          Height = 20
          Hint = #31649#29702#26381#21153#22120'IP'#22320#22336
          TabOrder = 1
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
      end
      object GroupBox3: TGroupBox
        Left = 202
        Top = 78
        Width = 183
        Height = 69
        Caption = #26085#24535#26381#21153#22120
        TabOrder = 4
        object Label6: TLabel
          Left = 10
          Top = 42
          Width = 66
          Height = 12
          Caption = #26381#21153#22120#31471#21475':'
        end
        object Label7: TLabel
          Left = 10
          Top = 20
          Width = 66
          Height = 12
          Caption = #26381#21153#22120#22320#22336':'
        end
        object EditLogServerPort: TEdit
          Left = 79
          Top = 39
          Width = 53
          Height = 20
          Hint = #26085#24535#26381#21153#22120#31471#21475
          TabOrder = 0
          Text = '10000'
          OnChange = EditValueChange
        end
        object EditLogServerAddr: TEdit
          Left = 79
          Top = 16
          Width = 98
          Height = 20
          Hint = #28216#25103#26085#24535#26381#21153#22120'IP'#22320#22336
          TabOrder = 1
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
      end
      object GroupBox4: TGroupBox
        Left = 10
        Top = 151
        Width = 183
        Height = 69
        Caption = #28216#25103#20027#26381#21153#22120
        TabOrder = 5
        object Label8: TLabel
          Left = 10
          Top = 42
          Width = 66
          Height = 12
          Caption = #26381#21153#22120#31471#21475':'
        end
        object Label9: TLabel
          Left = 10
          Top = 20
          Width = 66
          Height = 12
          Caption = #26381#21153#22120#22320#22336':'
        end
        object EditMsgSrvPort: TEdit
          Left = 79
          Top = 39
          Width = 53
          Height = 20
          Hint = #20027#28216#25103#26381#21153#22120#31471#21475#65292#27492#35774#32622#29992#20110#22810#26381#21153#22120#36127#36733#29615#22659#20351#29992#12290#26222#36890#29615#22659#19981#38656#35201#26356#25913#27492#35774#32622#12290
          TabOrder = 0
          Text = '4900'
          OnChange = EditValueChange
        end
        object EditMsgSrvAddr: TEdit
          Left = 79
          Top = 16
          Width = 98
          Height = 20
          Hint = #20027#28216#25103#26381#21153#22120#22320#22336#65292#27492#29992#20110#22810#26381#21153#22120#29615#22659#20351#29992#65292#26222#36890#29615#22659#19981#38656#35201#26356#25913#27492#35774#32622
          TabOrder = 1
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
      end
    end
    object ServerInfoSheet: TTabSheet
      Caption = #28216#25103#35774#32622
      object GroupBoxInfo: TGroupBox
        Left = 10
        Top = 6
        Width = 215
        Height = 98
        Caption = #22522#26412#21442#25968
        TabOrder = 0
        object Label1: TLabel
          Left = 10
          Top = 19
          Width = 54
          Height = 12
          Caption = #28216#25103#21517#31216':'
        end
        object Label10: TLabel
          Left = 10
          Top = 42
          Width = 54
          Height = 12
          Caption = #26381#21153#22120#21495':'
        end
        object Label11: TLabel
          Left = 98
          Top = 43
          Width = 54
          Height = 12
          Caption = #26381#21153#22120#25968':'
        end
        object Label16: TLabel
          Left = 10
          Top = 67
          Width = 54
          Height = 12
          Caption = #36873#25321#32534#21495':'
        end
        object EditGameName: TEdit
          Left = 67
          Top = 14
          Width = 110
          Height = 20
          Hint = #28216#25103#26381#21153#22120#21517#31216
          TabOrder = 0
          OnChange = EditValueChange
        end
        object EditServerIndex: TEdit
          Left = 67
          Top = 38
          Width = 24
          Height = 20
          Hint = #26381#21153#22120#24207#21495#65292#27492#35774#32622#29992#20110#22810#26381#21153#22120#36127#36733#29615#22659#65292#26222#36890#35774#32622#20026'0'
          TabOrder = 1
          Text = '0'
          OnChange = EditValueChange
        end
        object EditServerNumber: TEdit
          Left = 153
          Top = 38
          Width = 24
          Height = 20
          Hint = #22810#26381#21153#22120#36127#36733#65292#26381#21153#22120#25968#37327
          TabOrder = 2
          Text = '0'
          OnChange = EditValueChange
        end
        object CheckBoxServiceMode: TCheckBox
          Left = 114
          Top = 63
          Width = 91
          Height = 21
          Caption = #32534#21495#21305#37197
          ParentShowHint = False
          ShowHint = False
          TabOrder = 3
          OnClick = EditValueChange
        end
        object SpinEdit1: TSpinEdit
          Left = 67
          Top = 63
          Width = 40
          Height = 21
          MaxValue = 0
          MinValue = 0
          ParentShowHint = False
          ShowHint = False
          TabOrder = 4
          Value = 0
        end
      end
      object ButtonServerInfoSave: TButton
        Left = 316
        Top = 190
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonServerInfoSaveClick
      end
      object GroupBox7: TGroupBox
        Left = 10
        Top = 167
        Width = 191
        Height = 49
        Caption = #28216#25103#25968#25454#28304#21517#31216
        TabOrder = 2
        object Label27: TLabel
          Left = 10
          Top = 21
          Width = 54
          Height = 12
          Caption = #25968#25454#24211#21517':'
        end
        object Edit1: TEdit
          Left = 69
          Top = 16
          Width = 73
          Height = 20
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
          Text = 'HeroDB'
          OnChange = EditValueChange
        end
      end
    end
    object ShareSheet: TTabSheet
      Caption = #30446#24405#35774#32622
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label17: TLabel
        Left = 10
        Top = 15
        Width = 54
        Height = 12
        Caption = #34892#20250#30446#24405':'
      end
      object Label18: TLabel
        Left = 10
        Top = 37
        Width = 54
        Height = 12
        Caption = #34892#20250#25991#20214':'
      end
      object Label24: TLabel
        Left = 10
        Top = 177
        Width = 54
        Height = 12
        BiDiMode = bdRightToLeft
        Caption = #21151#33021#25554#20214':'
        ParentBiDiMode = False
      end
      object Label23: TLabel
        Left = 10
        Top = 153
        Width = 54
        Height = 12
        Caption = #20844#21578#30446#24405':'
      end
      object Label22: TLabel
        Left = 10
        Top = 129
        Width = 54
        Height = 12
        Caption = #22320#22270#30446#24405':'
      end
      object Label21: TLabel
        Left = 10
        Top = 106
        Width = 54
        Height = 12
        Caption = #37197#32622#30446#24405':'
      end
      object Label20: TLabel
        Left = 10
        Top = 83
        Width = 54
        Height = 12
        Caption = #22478#22561#30446#24405':'
      end
      object Label19: TLabel
        Left = 10
        Top = 60
        Width = 54
        Height = 12
        Caption = #30331#24405#26085#24535':'
      end
      object Label25: TLabel
        Left = 10
        Top = 199
        Width = 48
        Height = 12
        BiDiMode = bdRightToLeft
        Caption = 'Venture:'
        ParentBiDiMode = False
      end
      object EditGuildDir: TEdit
        Left = 67
        Top = 10
        Width = 238
        Height = 20
        Hint = #34892#20250#25968#25454#20445#23384#30446#24405
        TabOrder = 0
        OnChange = EditValueChange
      end
      object EditGuildFile: TEdit
        Left = 67
        Top = 33
        Width = 238
        Height = 20
        Hint = #34892#20250#25968#25454#20445#23384#25991#20214#21517
        TabOrder = 1
        OnChange = EditValueChange
      end
      object EditConLogDir: TEdit
        Left = 67
        Top = 56
        Width = 238
        Height = 20
        Hint = #20154#29289#30331#24405#26085#24535#20449#24687#20445#23384#30446#24405
        TabOrder = 2
        OnChange = EditValueChange
      end
      object EditCastleDir: TEdit
        Left = 67
        Top = 79
        Width = 238
        Height = 20
        ParentShowHint = False
        ShowHint = False
        TabOrder = 3
        OnChange = EditValueChange
      end
      object EditEnvirDir: TEdit
        Left = 67
        Top = 102
        Width = 238
        Height = 20
        TabOrder = 4
        OnChange = EditValueChange
      end
      object EditMapDir: TEdit
        Left = 67
        Top = 125
        Width = 238
        Height = 20
        ParentShowHint = False
        ShowHint = False
        TabOrder = 5
        OnChange = EditValueChange
      end
      object EditNoticeDir: TEdit
        Left = 67
        Top = 148
        Width = 238
        Height = 20
        ParentShowHint = False
        ShowHint = False
        TabOrder = 6
        OnChange = EditValueChange
      end
      object EditPlugDir: TEdit
        Left = 67
        Top = 172
        Width = 238
        Height = 20
        ParentShowHint = False
        ShowHint = False
        TabOrder = 7
        OnChange = EditValueChange
      end
      object EditVentureDir: TEdit
        Left = 67
        Top = 195
        Width = 238
        Height = 20
        ParentShowHint = False
        ShowHint = False
        TabOrder = 8
        OnChange = EditValueChange
      end
      object ButtonShareDirSave: TButton
        Left = 316
        Top = 190
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 9
        OnClick = ButtonShareDirSaveClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = #25805#20316#30028#38754
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox8: TGroupBox
        Left = 10
        Top = 10
        Width = 191
        Height = 50
        Caption = #24377#20986#35828#26126#39068#33394
        TabOrder = 0
        object ColorBoxHint: TColorBox
          Left = 8
          Top = 16
          Width = 111
          Height = 22
          Hint = #24377#20986#35828#26126#25991#26412#26694#39068#33394
          ItemHeight = 16
          TabOrder = 0
          OnChange = ColorBoxHintChange
        end
      end
      object GroupBox9: TGroupBox
        Left = 10
        Top = 66
        Width = 191
        Height = 63
        Caption = #26085#24535#35814#32454#24230
        TabOrder = 1
        object TrackBar1: TTrackBar
          Left = 8
          Top = 16
          Width = 177
          Height = 45
          TabOrder = 0
        end
      end
    end
  end
end
