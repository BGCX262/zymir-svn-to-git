object frmGameConfig: TfrmGameConfig
  Left = 708
  Top = 393
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #28216#25103#21442#25968
  ClientHeight = 295
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label77: TLabel
    Left = 10
    Top = 276
    Width = 432
    Height = 12
    Caption = #35843#25972#30340#21442#25968#31435#21363#29983#25928#65292#22312#32447#26102#35831#30830#35748#27492#21442#25968#30340#20316#29992#20877#35843#25972#65292#20081#35843#25972#23558#23548#33268#28216#25103#28151#20081
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object GameConfigControl: TPageControl
    Left = 10
    Top = 2
    Width = 543
    Height = 268
    ActivePage = TabSheet11
    MultiLine = True
    TabOrder = 0
    OnChanging = GameConfigControlChanging
    object GeneralSheet: TTabSheet
      Caption = #29615#22659#35774#32622
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBoxInfo: TGroupBox
        Left = 170
        Top = 55
        Width = 146
        Height = 46
        Caption = #23458#25143#31471#29256#26412#21495
        TabOrder = 3
        object Label16: TLabel
          Left = 8
          Top = 21
          Width = 54
          Height = 12
          Caption = #29256#26412#26085#26399':'
        end
        object EditSoftVersionDate2: TEdit
          Left = 65
          Top = 16
          Width = 72
          Height = 20
          Hint = #23458#25143#31471#29256#26412#26085#26399#35774#32622#65292#27492#21442#25968#40664#35748#20026' 20020522'#65292#27492#29256#26412#26085#26399#24517#39035#19982#23458#25143#31471#30456#21305#37197#65292#21542#21017#22312#36827#20837#28216#25103#26102#23558#25552#31034#29256#26412#19981#27491#30830#39
          Enabled = False
          TabOrder = 0
          Text = '20020522'
          OnChange = EditSoftVersionDate2Change
        end
      end
      object GroupBox5: TGroupBox
        Left = 170
        Top = 6
        Width = 146
        Height = 46
        Caption = #25511#21046#21488#26174#31034#20154#25968#26102#38388'('#31186')'
        TabOrder = 1
        object Label17: TLabel
          Left = 8
          Top = 21
          Width = 54
          Height = 12
          Caption = #26174#31034#38388#38548':'
        end
        object EditConsoleShowUserCountTime: TSpinEdit
          Left = 65
          Top = 15
          Width = 62
          Height = 21
          Hint = #31243#24207#25511#21046#21488#19978#26174#31034#24403#21069#22312#32447#20154#25968#38388#38548#26102#38388#65292#27492#21442#25968#40664#35748#20026' 10'#20998#38047#12290
          EditorEnabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 0
          Value = 10
          OnChange = EditConsoleShowUserCountTimeChange
        end
      end
      object GroupBox6: TGroupBox
        Left = 10
        Top = 106
        Width = 154
        Height = 106
        Caption = #28216#25103#20844#21578#26174#31034#38388#38548'('#31186')'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        object Label18: TLabel
          Left = 9
          Top = 22
          Width = 54
          Height = 12
          Caption = #26174#31034#38388#38548':'
        end
        object Label19: TLabel
          Left = 10
          Top = 47
          Width = 54
          Height = 12
          Caption = #25991#23383#39068#33394':'
        end
        object Label21: TLabel
          Left = 10
          Top = 71
          Width = 54
          Height = 12
          Caption = #21069#32512#25991#23383':'
        end
        object EditShowLineNoticeTime: TSpinEdit
          Left = 69
          Top = 19
          Width = 53
          Height = 21
          Hint = #28216#25103#20013#26174#31034#20844#21578#20449#24687#30340#38388#38548#26102#38388#65292#27492#21442#25968#40664#35748#20026' 300'#31186#12290
          EditorEnabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 0
          Value = 10
          OnChange = EditShowLineNoticeTimeChange
        end
        object ComboBoxLineNoticeColor: TComboBox
          Left = 69
          Top = 43
          Width = 53
          Height = 20
          Hint = #28216#25103#20013#26174#31034#20844#21578#20449#24687#30340#25991#23383#39068#33394#65292#27492#21442#25968#40664#35748#20026' '#34013#33394#12290
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
          OnChange = ComboBoxLineNoticeColorChange
        end
        object EditLineNoticePreFix: TEdit
          Left = 69
          Top = 67
          Width = 72
          Height = 20
          Hint = #28216#25103#20013#26174#31034#20844#21578#20449#24687#30340#25991#23383#34892#21069#32512#25991#23383#12290
          MaxLength = 20
          TabOrder = 2
          Text = #20844#21578#65306
          OnChange = EditLineNoticePreFixChange
        end
      end
      object ButtonGeneralSave: TButton
        Left = 468
        Top = 187
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 7
        OnClick = ButtonGeneralSaveClick
      end
      object GroupBox35: TGroupBox
        Left = 323
        Top = 6
        Width = 142
        Height = 95
        Caption = #25511#21046#21488#26174#31034#20449#24687
        TabOrder = 2
        object CheckBoxShowMakeItemMsg: TCheckBox
          Left = 8
          Top = 12
          Width = 121
          Height = 21
          Caption = 'GM'#25805#20316#20449#24687
          TabOrder = 0
          OnClick = CheckBoxShowMakeItemMsgClick
        end
        object CbViewHack: TCheckBox
          Left = 8
          Top = 30
          Width = 117
          Height = 21
          Caption = #36895#24230#24322#24120#20449#24687
          TabOrder = 1
          OnClick = CbViewHackClick
        end
        object CkViewAdmfail: TCheckBox
          Left = 8
          Top = 48
          Width = 121
          Height = 21
          Caption = #38750#27861#30331#24405#20449#24687
          TabOrder = 2
          OnClick = CkViewAdmfailClick
        end
        object CheckBoxShowExceptionMsg: TCheckBox
          Left = 8
          Top = 66
          Width = 111
          Height = 21
          Caption = #24322#24120#38169#35823#20449#24687
          TabOrder = 3
          OnClick = CheckBoxShowExceptionMsgClick
        end
      end
      object GroupBox51: TGroupBox
        Left = 10
        Top = 6
        Width = 154
        Height = 96
        Caption = #24191#25773#22312#32447#20154#25968
        TabOrder = 0
        object Label98: TLabel
          Left = 10
          Top = 39
          Width = 30
          Height = 12
          Caption = #20493#29575':'
        end
        object Label99: TLabel
          Left = 10
          Top = 64
          Width = 54
          Height = 12
          Caption = #38388#38548#26102#38388':'
        end
        object Label100: TLabel
          Left = 136
          Top = 64
          Width = 12
          Height = 12
          Caption = #31186
        end
        object EditSendOnlineCountRate: TSpinEdit
          Left = 44
          Top = 35
          Width = 53
          Height = 21
          Hint = #24191#25773#22312#32447#20154#25968#34394#20551#20154#25968#20493#25968#65292#30495#23454#25968#25454#20026#38500#20197'10'#65292#40664#35748#20026'10'#23601#26159'1'#20493#65292'11'#23601#26159'1.1'#20493
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 10
          TabOrder = 1
          Value = 10
          OnChange = EditSendOnlineCountRateChange
        end
        object EditSendOnlineTime: TSpinEdit
          Left = 69
          Top = 59
          Width = 60
          Height = 21
          Hint = #24191#25773#22312#32447#20154#25968#26102#38388#38388#38548
          EditorEnabled = False
          Increment = 10
          MaxValue = 200000
          MinValue = 5
          TabOrder = 2
          Value = 10
          OnChange = EditSendOnlineTimeChange
        end
        object CheckBoxSendOnlineCount: TCheckBox
          Left = 9
          Top = 14
          Width = 111
          Height = 21
          Hint = #26159#21542#21551#29992#24191#25773#22312#32447#20154#25968#21151#33021#65292#24320#21551#21518#23558#20197#32418#23383#26041#27861#26174#31034#26381#21153#22120#22312#32447#20154#25968
          Caption = #24191#25773#22312#32447#20154#25968
          TabOrder = 0
          OnClick = CheckBoxSendOnlineCountClick
        end
      end
      object GroupBox52: TGroupBox
        Left = 170
        Top = 106
        Width = 146
        Height = 106
        Caption = #29289#21697#24618#29289#25968#25454#24211#20493#29575
        TabOrder = 5
        object Label101: TLabel
          Left = 10
          Top = 20
          Width = 30
          Height = 12
          Caption = #24618#29289':'
        end
        object Label102: TLabel
          Left = 10
          Top = 47
          Width = 42
          Height = 12
          Caption = #29289#21697#19968':'
        end
        object Label103: TLabel
          Left = 10
          Top = 75
          Width = 42
          Height = 12
          Caption = #29289#21697#20108':'
        end
        object EditMonsterPowerRate: TSpinEdit
          Left = 60
          Top = 15
          Width = 77
          Height = 21
          Hint = #24618#29289#23646#24615#20493#29575'(HP'#65292'MP'#65292'DC'#65292'MC'#65292'SC)'#65292#23454#38469#25968#20540#20026#24403#21069#25968#20540#38500#20197'10'
          EditorEnabled = False
          MaxValue = 20000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditMonsterPowerRateChange
        end
        object EditEditItemsPowerRate: TSpinEdit
          Left = 61
          Top = 42
          Width = 77
          Height = 21
          Hint = #29289#21697#23646#24615#20493#29575'(DC'#65292'MC'#65292'SC)'#65292#23454#38469#25968#23383#20026#24403#21069#25968#25454#38500#20197'10'
          EditorEnabled = False
          MaxValue = 20000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditEditItemsPowerRateChange
        end
        object EditItemsACPowerRate: TSpinEdit
          Left = 61
          Top = 70
          Width = 77
          Height = 21
          Hint = #29289#21697#23646#24615#20493#29575'(AC'#65292'MAC'#20108#20010')'#65292#23454#38469#25968#23383#20026#24403#21069#25968#25454#38500#20197'10'
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditItemsACPowerRateChange
        end
      end
      object GroupBox73: TGroupBox
        Left = 323
        Top = 106
        Width = 142
        Height = 106
        Caption = #23458#25143#31471#25511#21046
        TabOrder = 6
        object Label152: TLabel
          Left = 7
          Top = 77
          Width = 54
          Height = 12
          Caption = #29256#26412#26085#26399':'
        end
        object CheckBoxCanOldClientLogon: TCheckBox
          Left = 8
          Top = 32
          Width = 127
          Height = 21
          Hint = #26159#21542#20801#35768#26087#23458#25143#31471#30331#24405#65292#38035#19978#20026#25171#24320#65292#22914#26524#20851#38381#35813#39033#65292#21017#32769#23458#25143#31471#23558#26080#27861#30331#24405#28216#25103
          Caption = #20801#35768#26222#36890#23458#25143#31471#30331#24405
          TabOrder = 1
          OnClick = CheckBoxCanOldClientLogonClick
        end
        object CheckBoxCanJSClientLogon: TCheckBox
          Left = 8
          Top = 49
          Width = 127
          Height = 21
          Hint = #24320#21551#35813#39033#21518#65292#22914#26524#26187#21319#23458#25143#31471#29256#26412#21495#20302#20110#19979#38754#35774#32622#65292#23558#31105#27490#30331#24405#28216#25103#12290
          Caption = #38480#21046#26187#21319#23458#25143#31471#29256#26412
          TabOrder = 2
          OnClick = CheckBoxCanJSClientLogonClick
        end
        object EditSoftVersionDate: TEdit
          Left = 64
          Top = 73
          Width = 72
          Height = 20
          Hint = #23458#25143#31471#29256#26412#26085#26399#35774#32622#65292#24403#24320#21551#38480#21046#26187#21319#23458#25143#31471#29256#26412#26102#65292#23458#25143#31471#29256#26412#20302#20110#35813#26085#26399#65292#23558#25552#31034#29256#26412#36807#26399#12290
          TabOrder = 3
          Text = '20020522'
          OnChange = EditSoftVersionDate2Change
        end
        object CheckBoxCanVipClientLogon: TCheckBox
          Left = 8
          Top = 14
          Width = 127
          Height = 21
          Hint = #24320#21551#35813#39033#21518#65292#38500#20102#21830#19994#29256#30331#24405#22120#65292#20854#23427#19968#20999#30331#24405#22120#37117#23558#31105#27490#30331#24405#28216#25103#12290
          Caption = #21482#20801#35768#21830#19994#29256#30331#24405
          TabOrder = 0
          OnClick = CheckBoxCanVipClientLogonClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #28216#25103#36873#39033'(1)'
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox28: TGroupBox
        Left = 10
        Top = 12
        Width = 127
        Height = 197
        Caption = #28216#25103#27169#24335
        TabOrder = 1
        object CheckBoxTestServer: TCheckBox
          Left = 8
          Top = 14
          Width = 91
          Height = 16
          Hint = #27979#35797#27169#24335#65292#25171#24320#27492#21151#33021#65292#21487#23545#26381#21153#22120#21442#25968#21644#21151#33021#36827#34892#27979#35797
          Caption = #27979#35797#27169#24335
          TabOrder = 0
          OnClick = CheckBoxTestServerClick
        end
        object CheckBoxServiceMode: TCheckBox
          Left = 8
          Top = 30
          Width = 91
          Height = 16
          Hint = #20813#36153#27169#24335#65292#25171#24320#27492#39033#23558#19981#23545#29992#25143#36827#34892#25910#36153
          Caption = #20813#36153#27169#24335
          TabOrder = 1
          OnClick = CheckBoxServiceModeClick
        end
        object CheckBoxVentureMode: TCheckBox
          Left = 8
          Top = 46
          Width = 101
          Height = 16
          Caption = #19981#21047#24618#27169#24335
          TabOrder = 2
          OnClick = CheckBoxVentureModeClick
        end
        object CheckBoxNonPKMode: TCheckBox
          Left = 8
          Top = 62
          Width = 101
          Height = 16
          Caption = #31105#27490'PK'#27169#24335
          TabOrder = 3
          OnClick = CheckBoxNonPKModeClick
        end
        object CheckBoxSafeOffLine: TCheckBox
          Left = 8
          Top = 78
          Width = 101
          Height = 16
          Caption = #23433#20840#21306#33073#26426
          TabOrder = 4
          OnClick = CheckBoxSafeOffLineClick
        end
        object CheckBoxKickOffLicPlay: TCheckBox
          Left = 8
          Top = 144
          Width = 101
          Height = 16
          Caption = #36386#38500#33073#26426#20154#29289
          TabOrder = 8
          OnClick = CheckBoxKickOffLicPlayClick
        end
        object CheckBoxOffLineShop: TCheckBox
          Left = 8
          Top = 95
          Width = 94
          Height = 16
          Hint = #36873#20013#35813#39033#21518#65292#20154#29289#25346#26426#26102#22914#26524#22788#20110#25670#25674#29366#24577#65292#23558#33258#21160#25910#25674#12290
          Caption = #31105#27490#25346#26426#25670#25674
          TabOrder = 5
          OnClick = CheckBoxOffLineShopClick
        end
        object CheckBoxOffLineHero: TCheckBox
          Left = 8
          Top = 111
          Width = 94
          Height = 16
          Hint = #36873#20013#35813#39033#21518#65292#20154#29289#25346#26426#26102#22914#26524#33521#38596#22312#32447#65292#23558#33258#21160#25910#22238#33521#38596#12290
          Caption = #31105#27490#33521#38596#25346#26426
          TabOrder = 6
          OnClick = CheckBoxOffLineHeroClick
        end
        object CheckBoxOffLineSlave: TCheckBox
          Left = 8
          Top = 127
          Width = 94
          Height = 16
          Hint = #36873#20013#35813#39033#21518#65292#20154#29289#25346#26426#26102#22914#26524#23453#23453#22312#32447#65292#23558#33258#21160#25910#22238#23453#23453#12290
          Caption = #31105#27490#23453#23453#25346#26426
          TabOrder = 7
          OnClick = CheckBoxOffLineSlaveClick
        end
        object chkExpShowConfig: TCheckBox
          Left = 8
          Top = 160
          Width = 113
          Height = 17
          Hint = #32463#39564#25552#31034#26174#31034#22312#32842#22825#31383#21475#37324#36824#26159#23631#24149#19978
          Caption = #32842#22825#31383#21475#26174#31034#32463#39564
          TabOrder = 9
          OnClick = chkExpShowConfigClick
        end
        object ChkBagShowItemDec: TCheckBox
          Left = 8
          Top = 178
          Width = 113
          Height = 17
          Hint = #40736#26631#22312#21253#35065#37324#36873#20013#29289#21697#21518#26159#19981#26159#26174#31034#29289#21697#30340#22791#27880#35828#26126
          Caption = #21253#35065#26174#31034#29289#21697#35828#26126
          TabOrder = 10
          OnClick = ChkBagShowItemDecClick
        end
      end
      object GroupBox29: TGroupBox
        Left = 142
        Top = 12
        Width = 151
        Height = 116
        Caption = #27979#35797#27169#24335
        TabOrder = 2
        object Label61: TLabel
          Left = 9
          Top = 19
          Width = 54
          Height = 12
          Caption = #24320#22987#31561#32423':'
        end
        object Label62: TLabel
          Left = 10
          Top = 43
          Width = 54
          Height = 12
          Caption = #24320#22987#37329#24065':'
        end
        object Label63: TLabel
          Left = 10
          Top = 69
          Width = 54
          Height = 12
          Caption = #20154#29289#38480#21046':'
        end
        object lbl1: TLabel
          Left = 11
          Top = 92
          Width = 54
          Height = 12
          Caption = #33521#38596#31561#32423':'
        end
        object EditTestLevel: TSpinEdit
          Left = 69
          Top = 12
          Width = 72
          Height = 21
          Hint = #20154#29289#36215#22987#31561#32423
          MaxValue = 20000
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = EditTestLevelChange
          OnKeyDown = EditTestLevelKeyDown
        end
        object EditTestGold: TSpinEdit
          Left = 69
          Top = 38
          Width = 72
          Height = 21
          Hint = #27979#35797#27169#24335#20154#29289#36215#22987#37329#24065
          Increment = 1000
          MaxValue = 99999999
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditTestGoldChange
        end
        object EditTestUserLimit: TSpinEdit
          Left = 69
          Top = 64
          Width = 72
          Height = 21
          Hint = #27979#35797#27169#24335#26368#39640#19978#32447#20154#25968
          Increment = 10
          MaxValue = 2000
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditTestUserLimitChange
        end
        object EditTestHeroLevel: TSpinEdit
          Left = 68
          Top = 89
          Width = 72
          Height = 21
          Hint = #33521#38596#36215#22987#31561#32423
          Increment = 10
          MaxValue = 2000
          MinValue = 0
          TabOrder = 3
          Value = 10
          OnChange = EditTestHeroLevelChange
        end
      end
      object GroupBox30: TGroupBox
        Left = 303
        Top = 14
        Width = 161
        Height = 49
        Caption = #20154#29289#36215#22987#35774#32622
        TabOrder = 0
        object Label60: TLabel
          Left = 10
          Top = 21
          Width = 54
          Height = 12
          Caption = #36215#22987#26435#38480':'
        end
        object EditStartPermission: TSpinEdit
          Left = 69
          Top = 16
          Width = 66
          Height = 21
          Hint = #20154#29289#28216#25103#36215#22987#26435#38480#65292#40664#35748#20026'0'
          EditorEnabled = False
          MaxValue = 10
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = EditStartPermissionChange
        end
      end
      object ButtonOptionSave0: TButton
        Left = 472
        Top = 194
        Width = 61
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 7
        OnClick = ButtonOptionSave0Click
      end
      object GroupBox31: TGroupBox
        Left = 142
        Top = 170
        Width = 151
        Height = 39
        Caption = #19978#32447#20154#25968#38480#21046
        TabOrder = 6
        object Label64: TLabel
          Left = 10
          Top = 17
          Width = 54
          Height = 12
          Caption = #20154#25968#19978#38480':'
        end
        object EditUserFull: TSpinEdit
          Left = 75
          Top = 12
          Width = 68
          Height = 21
          Hint = #26368#26032#21487#19978#32447#20154#25968#38480#21046#65292#36229#36807#35813#20540#23558#29992#32418#23383#25552#31034
          MaxValue = 10000
          MinValue = 0
          TabOrder = 0
          Value = 1000
          OnChange = EditUserFullChange
        end
      end
      object GroupBox33: TGroupBox
        Left = 303
        Top = 66
        Width = 161
        Height = 77
        Caption = #20154#29289#36523#19978#37329#24065#25968#38480#21046
        TabOrder = 3
        object Label68: TLabel
          Left = 9
          Top = 26
          Width = 54
          Height = 12
          Caption = #27491#24335#27169#24335':'
        end
        object Label69: TLabel
          Left = 9
          Top = 51
          Width = 54
          Height = 12
          Caption = #35797#29609#27169#24335':'
        end
        object EditHumanMaxGold: TSpinEdit
          Left = 68
          Top = 20
          Width = 85
          Height = 21
          Increment = 10000
          MaxValue = 99999999
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditHumanMaxGoldChange
        end
        object EditHumanTryModeMaxGold: TSpinEdit
          Left = 68
          Top = 46
          Width = 85
          Height = 21
          Increment = 10000
          MaxValue = 99999999
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditHumanTryModeMaxGoldChange
        end
      end
      object GroupBox34: TGroupBox
        Left = 303
        Top = 147
        Width = 161
        Height = 61
        Caption = #35797#29609#31561#32423
        TabOrder = 5
        object Label70: TLabel
          Left = 14
          Top = 22
          Width = 30
          Height = 12
          Caption = #31561#32423':'
        end
        object EditTryModeLevel: TSpinEdit
          Left = 65
          Top = 17
          Width = 66
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditTryModeLevelChange
        end
        object CheckBoxTryModeUseStorage: TCheckBox
          Left = 14
          Top = 37
          Width = 119
          Height = 19
          Hint = #35797#29609#27169#24335#26159#21542#20801#35768#20351#29992#20179#24211
          Caption = #35797#29609#27169#24335#20351#29992#20179#24211
          TabOrder = 1
          OnClick = CheckBoxTryModeUseStorageClick
        end
      end
      object GroupBox19: TGroupBox
        Left = 141
        Top = 131
        Width = 151
        Height = 37
        Caption = #32452#38431#25104#21592#25968#37327
        TabOrder = 4
        object Label41: TLabel
          Left = 10
          Top = 17
          Width = 54
          Height = 12
          Caption = #26368#22823#25968#37327':'
        end
        object EditGroupMembersMax: TSpinEdit
          Left = 75
          Top = 13
          Width = 69
          Height = 21
          Hint = #32452#38431#25104#21592#25968#37327
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditGroupMembersMaxChange
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = #24231#26631#33539#22260
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ButtonOptionSave: TButton
        Left = 356
        Top = 186
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonOptionSaveClick
      end
      object GroupBox16: TGroupBox
        Left = 10
        Top = 10
        Width = 102
        Height = 51
        Caption = #23433#20840#21306#33539#22260
        TabOrder = 0
        object Label39: TLabel
          Left = 9
          Top = 22
          Width = 30
          Height = 12
          Caption = #22823#23567':'
        end
        object EditSafeZoneSize: TSpinEdit
          Left = 43
          Top = 18
          Width = 40
          Height = 21
          Hint = #23433#20840#21306#33539#22260#22823#23567
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditSafeZoneSizeChange
        end
      end
      object GroupBox18: TGroupBox
        Left = 10
        Top = 68
        Width = 102
        Height = 51
        Caption = #26032#20154#20986#29983#28857#33539#22260
        TabOrder = 3
        object Label40: TLabel
          Left = 9
          Top = 22
          Width = 30
          Height = 12
          Caption = #33539#22260':'
        end
        object EditStartPointSize: TSpinEdit
          Left = 43
          Top = 20
          Width = 40
          Height = 21
          Hint = #26032#20154#20986#29983#28857#25511#21046#65292#40664#35748#20026#21069#19977#20010#23433#20840#21306#35774#32622
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditStartPointSizeChange
        end
      end
      object GroupBox20: TGroupBox
        Left = 120
        Top = 10
        Width = 144
        Height = 95
        Caption = #32418#21517#26449
        TabOrder = 1
        object Label42: TLabel
          Left = 10
          Top = 43
          Width = 36
          Height = 12
          Caption = #24231#26631'X:'
        end
        object Label43: TLabel
          Left = 10
          Top = 68
          Width = 36
          Height = 12
          Caption = #24231#26631'Y:'
        end
        object Label44: TLabel
          Left = 9
          Top = 19
          Width = 30
          Height = 12
          Caption = #22320#22270':'
        end
        object EditRedHomeX: TSpinEdit
          Left = 49
          Top = 38
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditRedHomeXChange
        end
        object EditRedHomeY: TSpinEdit
          Left = 49
          Top = 64
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditRedHomeYChange
        end
        object EditRedHomeMap: TEdit
          Left = 49
          Top = 14
          Width = 73
          Height = 20
          Hint = #32418#21517#26449#38598#20013#28857#22320#22270#21517#31216
          TabOrder = 0
          Text = '3'
          OnChange = EditRedHomeMapChange
        end
      end
      object GroupBox21: TGroupBox
        Left = 120
        Top = 110
        Width = 144
        Height = 95
        Caption = #32418#21517#27515#20129#22238#22478#28857
        TabOrder = 4
        object Label45: TLabel
          Left = 10
          Top = 43
          Width = 36
          Height = 12
          Caption = #24231#26631'X:'
        end
        object Label46: TLabel
          Left = 10
          Top = 68
          Width = 36
          Height = 12
          Caption = #24231#26631'Y:'
        end
        object Label47: TLabel
          Left = 9
          Top = 19
          Width = 30
          Height = 12
          Caption = #22320#22270':'
        end
        object EditRedDieHomeX: TSpinEdit
          Left = 49
          Top = 38
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditRedDieHomeXChange
        end
        object EditRedDieHomeY: TSpinEdit
          Left = 49
          Top = 64
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditRedDieHomeYChange
        end
        object EditRedDieHomeMap: TEdit
          Left = 49
          Top = 14
          Width = 73
          Height = 20
          TabOrder = 0
          Text = '3'
          OnChange = EditRedDieHomeMapChange
        end
      end
      object GroupBox22: TGroupBox
        Left = 274
        Top = 10
        Width = 144
        Height = 95
        Caption = #24212#24613#22238#22478#28857
        TabOrder = 2
        object Label48: TLabel
          Left = 10
          Top = 43
          Width = 36
          Height = 12
          Caption = #24231#26631'X:'
        end
        object Label49: TLabel
          Left = 10
          Top = 68
          Width = 36
          Height = 12
          Caption = #24231#26631'Y:'
        end
        object Label50: TLabel
          Left = 9
          Top = 19
          Width = 30
          Height = 12
          Caption = #22320#22270':'
        end
        object EditHomeX: TSpinEdit
          Left = 49
          Top = 38
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditHomeXChange
        end
        object EditHomeY: TSpinEdit
          Left = 49
          Top = 64
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditHomeYChange
        end
        object EditHomeMap: TEdit
          Left = 49
          Top = 14
          Width = 73
          Height = 20
          TabOrder = 0
          Text = '3'
          OnChange = EditHomeMapChange
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'PK'#25511#21046
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ButtonOptionSave2: TButton
        Left = 368
        Top = 180
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonOptionSave2Click
      end
      object GroupBox23: TGroupBox
        Left = 10
        Top = 10
        Width = 150
        Height = 76
        Caption = #33258#21160#20943'PK'#28857#25511#21046
        TabOrder = 0
        object Label51: TLabel
          Left = 10
          Top = 20
          Width = 54
          Height = 12
          Caption = #38388#38548#26102#38388':'
        end
        object Label52: TLabel
          Left = 10
          Top = 46
          Width = 54
          Height = 12
          Caption = #19968#27425#28857#25968':'
        end
        object Label53: TLabel
          Left = 125
          Top = 20
          Width = 12
          Height = 12
          Caption = #31186
        end
        object EditDecPkPointTime: TSpinEdit
          Left = 69
          Top = 16
          Width = 50
          Height = 21
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditDecPkPointTimeChange
        end
        object EditDecPkPointCount: TSpinEdit
          Left = 69
          Top = 42
          Width = 50
          Height = 21
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditDecPkPointCountChange
        end
      end
      object GroupBox24: TGroupBox
        Left = 10
        Top = 92
        Width = 108
        Height = 47
        Caption = 'PK'#29366#24577#21464#33394'('#31186')'
        TabOrder = 2
        object Label54: TLabel
          Left = 9
          Top = 20
          Width = 30
          Height = 12
          Caption = #26102#38388':'
        end
        object EditPKFlagTime: TSpinEdit
          Left = 44
          Top = 16
          Width = 53
          Height = 21
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditPKFlagTimeChange
        end
      end
      object GroupBox25: TGroupBox
        Left = 10
        Top = 146
        Width = 108
        Height = 47
        Caption = #26432#20154#22686#21152'PK'#28857#25968
        TabOrder = 3
        object Label55: TLabel
          Left = 9
          Top = 20
          Width = 30
          Height = 12
          Caption = #28857#25968':'
        end
        object EditKillHumanAddPKPoint: TSpinEdit
          Left = 44
          Top = 16
          Width = 53
          Height = 21
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditKillHumanAddPKPointChange
        end
      end
      object GroupBox32: TGroupBox
        Left = 170
        Top = 10
        Width = 263
        Height = 167
        Caption = 'PK'#35268#21017
        TabOrder = 1
        object Label58: TLabel
          Left = 112
          Top = 15
          Width = 66
          Height = 12
          Caption = #22686#21152#31561#32423#25968':'
        end
        object Label65: TLabel
          Left = 112
          Top = 43
          Width = 66
          Height = 12
          Caption = #20943#23569#31561#32423#25968':'
        end
        object Label66: TLabel
          Left = 112
          Top = 69
          Width = 66
          Height = 12
          Caption = #22686#21152#32463#39564#25968':'
        end
        object Label56: TLabel
          Left = 112
          Top = 93
          Width = 66
          Height = 12
          Caption = #20943#23569#32463#39564#25968':'
        end
        object Label67: TLabel
          Left = 8
          Top = 94
          Width = 42
          Height = 12
          Caption = 'PK'#31561#32423':'
        end
        object Label114: TLabel
          Left = 112
          Top = 119
          Width = 66
          Height = 12
          Caption = 'PK'#20445#25252#31561#32423':'
        end
        object Label115: TLabel
          Left = 88
          Top = 143
          Width = 90
          Height = 12
          Caption = #32463#21517'PK'#20445#25252#31561#32423':'
        end
        object CheckBoxKillHumanWinLevel: TCheckBox
          Left = 8
          Top = 15
          Width = 94
          Height = 16
          Caption = #26432#20154#22686#21152#31561#32423
          TabOrder = 1
          OnClick = CheckBoxKillHumanWinLevelClick
        end
        object CheckBoxKilledLostLevel: TCheckBox
          Left = 8
          Top = 33
          Width = 87
          Height = 16
          Caption = #34987#26432#20943#31561#32423
          TabOrder = 2
          OnClick = CheckBoxKilledLostLevelClick
        end
        object CheckBoxKilledLostExp: TCheckBox
          Left = 8
          Top = 71
          Width = 89
          Height = 16
          Caption = #34987#26432#20943#32463#39564
          TabOrder = 6
          OnClick = CheckBoxKilledLostExpClick
        end
        object CheckBoxKillHumanWinExp: TCheckBox
          Left = 8
          Top = 52
          Width = 96
          Height = 16
          Caption = #26432#20154#22686#21152#32463#39564
          TabOrder = 4
          OnClick = CheckBoxKillHumanWinExpClick
        end
        object EditKillHumanWinLevel: TSpinEdit
          Left = 183
          Top = 11
          Width = 71
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditKillHumanWinLevelChange
        end
        object EditKilledLostLevel: TSpinEdit
          Left = 183
          Top = 39
          Width = 71
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditKilledLostLevelChange
        end
        object EditKillHumanWinExp: TSpinEdit
          Left = 183
          Top = 64
          Width = 71
          Height = 21
          Increment = 1000
          MaxValue = 200000000
          MinValue = 1
          TabOrder = 5
          Value = 10
          OnChange = EditKillHumanWinExpChange
        end
        object EditKillHumanLostExp: TSpinEdit
          Left = 183
          Top = 89
          Width = 71
          Height = 21
          Increment = 1000
          MaxValue = 200000000
          MinValue = 1
          TabOrder = 8
          Value = 10
          OnChange = EditKillHumanLostExpChange
        end
        object EditHumanLevelDiffer: TSpinEdit
          Left = 54
          Top = 89
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 7
          Value = 10
          OnChange = EditHumanLevelDifferChange
        end
        object CheckBoxPKLevelProtect: TCheckBox
          Left = 8
          Top = 118
          Width = 95
          Height = 16
          Hint = 
            #21551#29992'PK'#20445#25252#21151#33021#65292#25171#24320#27492#21151#33021#21518#65292#28216#25103#20013#39640#20110#20445#25252#31561#32423#30340#20154#29289#23558#19981#21487#20197#26432#20302#20110#20445#25252#31561#32423#30340#20154#29289'('#20302#31561#32423#20154#29289#20808#25915#20987#21464#33394#38500#22806')'#65292#20302#20110#20445#25252#31561#32423#30340 +
            #20154#29289#20063#19981#21487#20197#26432#39640#20110#20445#25252#31561#32423#30340#20154#29289#65288#39640#31561#32423#20154#29289#20808#25915#20987#38500#22806#65289
          Caption = #26222#36890'PK'#20445#25252
          TabOrder = 10
          OnClick = CheckBoxPKLevelProtectClick
        end
        object EditPKProtectLevel: TSpinEdit
          Left = 183
          Top = 114
          Width = 71
          Height = 21
          Hint = #20445#25252#31561#32423#65292#27492#31561#32423#20197#19979#20154#29289#34987#20445#25252#65292#20808#25915#20987#20154#29289#38500#22806
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 1
          TabOrder = 9
          Value = 10
          OnChange = EditPKProtectLevelChange
        end
        object EditRedPKProtectLevel: TSpinEdit
          Left = 183
          Top = 138
          Width = 71
          Height = 21
          Hint = #32418#21517#20154#29289'PK'#20445#25252#65292#39640#20110#20445#25252#31561#32423#30340#32418#21517#20154#29289#19981#21487#20197#26432#20302#20110#20445#25252#31561#32423#26410#32418#21517#20154#29289#12290#20302#20110#20445#25252#31561#32423#26410#32418#21517#30340#20154#29289#20063#19981#21487#20197#26432#39640#20110#20445#25252#31561#32423#20154#29289
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 1
          TabOrder = 11
          Value = 10
          OnChange = EditRedPKProtectLevelChange
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #28216#25103#36873#39033'(2)'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox17: TGroupBox
        Left = 376
        Top = 11
        Width = 153
        Height = 182
        Caption = #31359#20154#31359#24618#25511#21046
        TabOrder = 2
        object CheckBoxDisHumRun: TCheckBox
          Left = 10
          Top = 17
          Width = 124
          Height = 17
          Hint = #25171#24320#27492#21151#33021#21518#65292#20154#29289#23558#19981#20801#35768#31359#36807#24618#29289#21644#20854#23427#20154#29289
          Caption = #31105#27490#36305#27493#31359
          TabOrder = 0
          OnClick = CheckBoxDisHumRunClick
        end
        object CheckBoxRunHum: TCheckBox
          Left = 28
          Top = 35
          Width = 95
          Height = 16
          Hint = #25171#24320#27492#21151#33021#21518#65292#20801#35768#31359#36807#20154#29289
          Caption = #20801#35768#31359#36807#20154#29289
          TabOrder = 1
          OnClick = CheckBoxRunHumClick
        end
        object CheckBoxRunMon: TCheckBox
          Left = 28
          Top = 55
          Width = 97
          Height = 16
          Hint = #25171#24320#27492#21151#33021#21518#65292#20801#35768#31359#36807#24618#29289
          Caption = #20801#35768#31359#36807#24618#29289
          TabOrder = 2
          OnClick = CheckBoxRunMonClick
        end
        object CheckBoxWarDisHumRun: TCheckBox
          Left = 28
          Top = 103
          Width = 118
          Height = 17
          Hint = #25171#24320#27492#21151#33021#65292#25915#22478#21306#22495#31105#27490#31359#20154#31359#24618
          Caption = #25915#22478#21306#22495#20840#37096#31105#27490
          TabOrder = 5
          OnClick = CheckBoxWarDisHumRunClick
        end
        object CheckBoxRunNpc: TCheckBox
          Left = 28
          Top = 71
          Width = 97
          Height = 16
          Hint = #25171#24320#20123#21151#33021#21518#65292#20801#35768#31359#36807'NPC'
          Caption = #20801#35768#31359#36807'NPC'
          TabOrder = 3
          OnClick = CheckBoxRunNpcClick
        end
        object CheckBoxGMRunAll: TCheckBox
          Left = 28
          Top = 121
          Width = 118
          Height = 16
          Hint = #25171#24320#27492#21151#33021#65292#36229#32423#31649#29702#21592#19981#21463#20197#19978#35268#21017#38480#21046
          Caption = #31649#29702#21592#19981#21463#25511#21046
          TabOrder = 6
          OnClick = CheckBoxGMRunAllClick
        end
        object CheckBoxRunGuard: TCheckBox
          Left = 28
          Top = 87
          Width = 97
          Height = 16
          Hint = #25171#24320#27492#21151#33021#21518#65292#20801#35768#31359#36807#23432#21355
          Caption = #20801#35768#31359#36807#23432#21355
          TabOrder = 4
          OnClick = CheckBoxRunGuardClick
        end
        object CheckBoxSafeZoneRunAll: TCheckBox
          Left = 28
          Top = 137
          Width = 109
          Height = 16
          Hint = #25171#24320#27492#21151#33021#65292#22312#23433#20840#21306#20869#19981#21463#20197#19978#35268#21017#38480#21046
          Caption = #23433#20840#21306#19981#21463#25511#21046
          TabOrder = 7
          OnClick = CheckBoxSafeZoneRunAllClick
        end
      end
      object ButtonOptionSave3: TButton
        Left = 11
        Top = 186
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonOptionSave3Click
      end
      object GroupBox53: TGroupBox
        Left = 10
        Top = 11
        Width = 127
        Height = 106
        Caption = #20132#26131#25511#21046
        TabOrder = 0
        object Label20: TLabel
          Left = 8
          Top = 19
          Width = 54
          Height = 12
          Caption = #20132#26131#38388#38548':'
        end
        object Label104: TLabel
          Left = 8
          Top = 43
          Width = 54
          Height = 12
          Caption = #30830#35748#20132#26131':'
        end
        object Label105: TLabel
          Left = 105
          Top = 19
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label106: TLabel
          Left = 105
          Top = 42
          Width = 12
          Height = 12
          Caption = #31186
        end
        object EditTryDealTime: TSpinEdit
          Left = 65
          Top = 14
          Width = 36
          Height = 21
          Hint = #20851#38381#20132#26131#21518#65292#35201#37325#26032#20132#26131#24517#39035#31561#24453#27492#38388#38548#26102#38388
          EditorEnabled = False
          MaxValue = 10
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditTryDealTimeChange
        end
        object EditDealOKTime: TSpinEdit
          Left = 65
          Top = 38
          Width = 36
          Height = 21
          Hint = #25918#19978#20132#26131#29289#21697#21518#65292#24517#38656#31561#24453#27492#38388#38548#26102#38388#25165#33021#25353#20132#26131#25353#25197
          EditorEnabled = False
          MaxValue = 10
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditDealOKTimeChange
        end
        object CheckBoxCanNotGetBackDeal: TCheckBox
          Left = 11
          Top = 61
          Width = 103
          Height = 16
          Hint = #25171#24320#27492#21151#33021#21518#65292#25918#19978#21435#30340#20132#26131#29289#21697#19981#21487#20197#20877#21462#22238#65292#21482#33021#21462#28040#20132#26131#37325#26032#36827#34892
          Caption = #31105#27490#21462#22238#29289#21697
          TabOrder = 2
          OnClick = CheckBoxCanNotGetBackDealClick
        end
        object CheckBoxDisableDeal: TCheckBox
          Left = 11
          Top = 79
          Width = 83
          Height = 16
          Hint = #25171#24320#27492#21151#33021#65292#28216#25103#20013#23558#19981#20801#35768#20132#26131
          Caption = #31105#27490#20132#26131
          TabOrder = 3
          OnClick = CheckBoxDisableDealClick
        end
      end
      object GroupBox26: TGroupBox
        Left = 10
        Top = 132
        Width = 127
        Height = 50
        Caption = #32511#27602#20943'HP'#26102#38388'('#27627#31186')'
        TabOrder = 3
        object Label57: TLabel
          Left = 10
          Top = 22
          Width = 54
          Height = 12
          Caption = #38388#38548#26102#38388':'
        end
        object EditPosionDecHealthTime: TSpinEdit
          Left = 68
          Top = 17
          Width = 50
          Height = 21
          Hint = #20154#29289#20013#32511#27602#21518#65292#20943#23569#29983#21629#26102#38388#38388#38548
          Increment = 100
          MaxValue = 20000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditPosionDecHealthTimeChange
        end
      end
      object GroupBox27: TGroupBox
        Left = 143
        Top = 132
        Width = 132
        Height = 50
        Caption = #32418#27602#20943#38450#24481#21450#25345#20037#29575
        TabOrder = 4
        object Label59: TLabel
          Left = 10
          Top = 22
          Width = 30
          Height = 12
          Caption = #27604#29575':'
        end
        object EditPosionDamagarmor: TSpinEdit
          Left = 44
          Top = 17
          Width = 50
          Height = 21
          Hint = #20154#29289#20013#32418#27602#20943#25345#20037#21644#38450#24481#27604#29575#65292#27492#25968#25454#38500#20197'10'#20026#30495#23454#25968#25454
          EditorEnabled = False
          MaxValue = 20000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditPosionDamagarmorChange
        end
      end
      object GroupBox64: TGroupBox
        Left = 144
        Top = 11
        Width = 132
        Height = 111
        Caption = #25172#29289#21697#25511#21046
        TabOrder = 1
        object Label118: TLabel
          Left = 10
          Top = 43
          Width = 54
          Height = 12
          Caption = #29289#21697#20215#26684':'
        end
        object Label119: TLabel
          Left = 11
          Top = 68
          Width = 30
          Height = 12
          Caption = #37329#24065':'
        end
        object EditCanDropPrice: TSpinEdit
          Left = 69
          Top = 38
          Width = 55
          Height = 21
          Hint = #20302#20110#27492#20174#26684#29289#21697#65292#25172#20986#21435#39532#19978#28040#22833
          Increment = 100
          MaxValue = 20000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditCanDropPriceChange
        end
        object CheckBoxControlDropItem: TCheckBox
          Left = 13
          Top = 18
          Width = 104
          Height = 16
          Hint = #25171#24320#27492#21151#33021#21518#65292#23558#23545#20154#29289#25172#20986#29289#21697#36827#34892#26816#27979
          Caption = #21551#29992#25172#29289#21697#25511#21046
          TabOrder = 0
          OnClick = CheckBoxControlDropItemClick
        end
        object EditCanDropGold: TSpinEdit
          Left = 69
          Top = 64
          Width = 55
          Height = 21
          Hint = #23567#20110#25351#23450#25968#25454#30340#37329#24065#65292#23558#31105#27490#25172#20986
          Increment = 100
          MaxValue = 20000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditCanDropGoldChange
        end
        object CheckBoxIsSafeDisableDrop: TCheckBox
          Left = 15
          Top = 89
          Width = 105
          Height = 16
          Hint = #25171#24320#27492#21151#33021#21518#65292#23433#20840#21306#23558#31105#27490#25172#29289#21697
          Caption = #23433#20840#21306#31105#27490#25172
          TabOrder = 3
          OnClick = CheckBoxIsSafeDisableDropClick
        end
      end
    end
    object GameSpeedSheet: TTabSheet
      Caption = #28216#25103#36895#24230
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 10
        Top = 10
        Width = 98
        Height = 201
        Caption = #38388#38548#25511#21046'('#27627#31186')'
        TabOrder = 0
        object Label1: TLabel
          Left = 13
          Top = 22
          Width = 30
          Height = 12
          Caption = #25915#20987':'
        end
        object Label2: TLabel
          Left = 13
          Top = 47
          Width = 30
          Height = 12
          Caption = #39764#27861':'
        end
        object Label3: TLabel
          Left = 13
          Top = 71
          Width = 30
          Height = 12
          Caption = #36305#27493':'
        end
        object Label4: TLabel
          Left = 13
          Top = 95
          Width = 30
          Height = 12
          Caption = #36208#36335':'
        end
        object Label5: TLabel
          Left = 13
          Top = 144
          Width = 30
          Height = 12
          Caption = #25366#32905':'
          Enabled = False
        end
        object Label6: TLabel
          Left = 13
          Top = 119
          Width = 30
          Height = 12
          Caption = #36716#21521':'
        end
        object EditHitIntervalTime: TSpinEdit
          Left = 47
          Top = 18
          Width = 41
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 0
          Value = 900
          OnChange = EditHitIntervalTimeChange
        end
        object EditMagicHitIntervalTime: TSpinEdit
          Left = 47
          Top = 42
          Width = 41
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 1
          Value = 800
          OnChange = EditMagicHitIntervalTimeChange
        end
        object EditRunIntervalTime: TSpinEdit
          Left = 47
          Top = 66
          Width = 41
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 2
          Value = 600
          OnChange = EditRunIntervalTimeChange
        end
        object EditWalkIntervalTime: TSpinEdit
          Left = 47
          Top = 90
          Width = 41
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 3
          Value = 600
          OnChange = EditWalkIntervalTimeChange
        end
        object EditTurnIntervalTime: TSpinEdit
          Left = 47
          Top = 115
          Width = 41
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 4
          Value = 600
          OnChange = EditTurnIntervalTimeChange
        end
        object EditDigUpIntervalTime: TSpinEdit
          Left = 47
          Top = 140
          Width = 41
          Height = 21
          EditorEnabled = False
          Enabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 5
          Value = 10
          OnChange = EditWalkIntervalTimeChange
        end
      end
      object GroupBox2: TGroupBox
        Left = 116
        Top = 10
        Width = 85
        Height = 201
        Caption = #25968#25454#37327#25511#21046
        TabOrder = 1
        object Label7: TLabel
          Left = 13
          Top = 22
          Width = 30
          Height = 12
          Caption = #25915#20987':'
        end
        object Label8: TLabel
          Left = 13
          Top = 47
          Width = 30
          Height = 12
          Caption = #39764#27861':'
        end
        object Label9: TLabel
          Left = 13
          Top = 71
          Width = 30
          Height = 12
          Caption = #36305#27493':'
        end
        object Label10: TLabel
          Left = 13
          Top = 95
          Width = 30
          Height = 12
          Caption = #36208#36335':'
        end
        object Label11: TLabel
          Left = 13
          Top = 144
          Width = 30
          Height = 12
          Caption = #25366#32905':'
        end
        object Label12: TLabel
          Left = 13
          Top = 119
          Width = 30
          Height = 12
          Caption = #36716#21521':'
        end
        object EditMaxHitMsgCount: TSpinEdit
          Left = 47
          Top = 18
          Width = 29
          Height = 21
          Hint = #20801#35768#21516#26102#25805#20316#25968#37327#65292#27492#21442#25968#40664#35748'1'#65288#21152#22823#27492#25968#20540#65292#23558#20986#29616#21452#20493#25110#22810#20493#25915#20987#65289
          EditorEnabled = False
          MaxValue = 50
          MinValue = 10
          TabOrder = 0
          Value = 10
          OnChange = EditMaxHitMsgCountChange
        end
        object EditMaxSpellMsgCount: TSpinEdit
          Left = 47
          Top = 42
          Width = 29
          Height = 21
          Hint = #20801#35768#21516#26102#25805#20316#25968#37327#65292#27492#21442#25968#40664#35748'1'#65288#21152#22823#27492#25968#20540#65292#23558#20986#29616#21452#20493#25110#22810#20493#25915#20987#65289
          EditorEnabled = False
          MaxValue = 50
          MinValue = 1
          TabOrder = 1
          Value = 2
          OnChange = EditMaxSpellMsgCountChange
        end
        object EditMaxRunMsgCount: TSpinEdit
          Left = 47
          Top = 66
          Width = 29
          Height = 21
          Hint = #20801#35768#21516#26102#25805#20316#25968#37327#65292#27492#21442#25968#40664#35748'1'#65288#21152#22823#27492#25968#20540#65292#23558#20986#29616#21452#20493#25110#22810#20493#25915#20987#65289
          EditorEnabled = False
          MaxValue = 50
          MinValue = 1
          TabOrder = 2
          Value = 2
          OnChange = EditMaxRunMsgCountChange
        end
        object EditMaxWalkMsgCount: TSpinEdit
          Left = 47
          Top = 90
          Width = 29
          Height = 21
          Hint = #20801#35768#21516#26102#25805#20316#25968#37327#65292#27492#21442#25968#40664#35748'1'#65288#21152#22823#27492#25968#20540#65292#23558#20986#29616#21452#20493#25110#22810#20493#25915#20987#65289
          EditorEnabled = False
          MaxValue = 50
          MinValue = 1
          TabOrder = 3
          Value = 2
          OnChange = EditMaxWalkMsgCountChange
        end
        object EditMaxTurnMsgCount: TSpinEdit
          Left = 47
          Top = 115
          Width = 29
          Height = 21
          Hint = #20801#35768#21516#26102#25805#20316#25968#37327#65292#27492#21442#25968#40664#35748'1'#65288#21152#22823#27492#25968#20540#65292#23558#20986#29616#21452#20493#25110#22810#20493#25915#20987#65289
          EditorEnabled = False
          MaxValue = 50
          MinValue = 1
          TabOrder = 4
          Value = 2
          OnChange = EditMaxTurnMsgCountChange
        end
        object EditMaxDigUpMsgCount: TSpinEdit
          Left = 47
          Top = 140
          Width = 29
          Height = 21
          Hint = #20801#35768#21516#26102#25805#20316#25968#37327#65292#27492#21442#25968#40664#35748'1'#65288#21152#22823#27492#25968#20540#65292#23558#20986#29616#21452#20493#25110#22810#20493#25915#20987#65289
          EditorEnabled = False
          MaxValue = 50
          MinValue = 1
          TabOrder = 5
          Value = 2
          OnChange = EditMaxDigUpMsgCountChange
        end
      end
      object GroupBox3: TGroupBox
        Left = 372
        Top = 68
        Width = 111
        Height = 51
        Caption = #35013#22791#36895#24230
        TabOrder = 4
        object Label13: TLabel
          Left = 12
          Top = 23
          Width = 30
          Height = 12
          Caption = #36895#24230':'
        end
        object EditItemSpeedTime: TSpinEdit
          Left = 50
          Top = 18
          Width = 46
          Height = 21
          Hint = #23558#22791#21152#36895#23646#24615#36895#24230#25511#21046#65292#25968#23383#36234#23567#25511#21046#36234#20005#65292#27492#21442#25968#40664#35748#20026' 50'#27627#31186#12290
          EditorEnabled = False
          MaxValue = 50
          MinValue = 1
          TabOrder = 0
          Value = 50
          OnChange = EditItemSpeedTimeChange
        end
      end
      object ButtonGameSpeedSave: TButton
        Left = 417
        Top = 182
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 8
        OnClick = ButtonGameSpeedSaveClick
      end
      object GroupBox4: TGroupBox
        Left = 372
        Top = 10
        Width = 111
        Height = 55
        Caption = #36895#24230#25511#21046#27169#24335
        TabOrder = 3
        object RadioButtonDelyMode: TRadioButton
          Left = 8
          Top = 17
          Width = 99
          Height = 16
          Hint = #23558#36229#36807#36895#24230#30340#25805#20316#36827#34892#24310#26102#22788#29702#65292#20197#20445#25345#27491#24120#36895#24230#65292#20351#29992#27492#31181#27169#24335#23458#25143#31471#20351#29992#21152#36895#23558#36896#25104#21345#30340#29616#35937#12290
          Caption = #20572#39039#25805#20316#22788#29702
          TabOrder = 0
          OnClick = RadioButtonDelyModeClick
        end
        object RadioButtonFilterMode: TRadioButton
          Left = 8
          Top = 34
          Width = 99
          Height = 16
          Hint = #23558#36229#36807#36895#24230#30340#25805#20316#30452#25509#36807#28388#22788#29702#65292#20002#24323#36229#36895#24230#25805#20316#65292#20351#29992#27492#31181#27169#24335#23458#25143#31471#20351#29992#21152#36895#23558#36896#25104#21345#20992#65292#21453#24377#30340#29616#35937#12290
          Caption = #21453#24377#21345#20992#22788#29702
          TabOrder = 1
          OnClick = RadioButtonFilterModeClick
        end
      end
      object GroupBox7: TGroupBox
        Left = 210
        Top = 126
        Width = 128
        Height = 85
        Caption = #20154#29289#24367#33136#25511#21046
        TabOrder = 5
        object Label22: TLabel
          Left = 12
          Top = 23
          Width = 54
          Height = 12
          Caption = #20572#30041#26102#38388':'
        end
        object EditStruckTime: TSpinEdit
          Left = 68
          Top = 18
          Width = 45
          Height = 21
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 10
          TabOrder = 0
          Value = 100
          OnChange = EditStruckTimeChange
        end
        object CheckBoxDisableStruck: TCheckBox
          Left = 14
          Top = 43
          Width = 110
          Height = 16
          Caption = #20154#29289#26080#24367#33136#21160#20316
          TabOrder = 1
          OnClick = CheckBoxDisableStruckClick
        end
        object CheckBoxDisableSelfStruck: TCheckBox
          Left = 14
          Top = 58
          Width = 110
          Height = 16
          Caption = #20154#29289#33258#24049#19981#24367#33136
          TabOrder = 2
          OnClick = CheckBoxDisableSelfStruckClick
        end
      end
      object GroupBox15: TGroupBox
        Left = 209
        Top = 10
        Width = 156
        Height = 109
        Caption = #25805#20316#25968#25454#25511#21046
        TabOrder = 2
        object Label38: TLabel
          Left = 11
          Top = 84
          Width = 30
          Height = 12
          Caption = #27425#25968':'
        end
        object Label142: TLabel
          Left = 79
          Top = 84
          Width = 30
          Height = 12
          Caption = #36807#28388':'
        end
        object EditOverSpeedKickCount: TSpinEdit
          Left = 45
          Top = 79
          Width = 30
          Height = 21
          Hint = #36229#36807#27425#25968#65292#21017#20154#29289#34987#36386#19979#32447
          EditorEnabled = False
          MaxValue = 50
          MinValue = 1
          TabOrder = 3
          Value = 4
          OnChange = EditOverSpeedKickCountChange
        end
        object CheckBoxboKickOverSpeed: TCheckBox
          Left = 10
          Top = 62
          Width = 140
          Height = 16
          Hint = #23558#36229#36895#25805#20316#20154#29289#36386#19979#32447
          Caption = #25481#32447#22788#29702#36229#36895#25805#20316
          TabOrder = 2
          OnClick = CheckBoxboKickOverSpeedClick
        end
        object EditDropOverSpeed: TSpinEdit
          Left = 110
          Top = 79
          Width = 37
          Height = 21
          Hint = #36807#28388#36229#36895#25805#20316#25968#25454#65292#25968#23383#36229#23567#36229#20005#65292#36807#28388#21518#23458#25143#31471#23558#20986#29616#21453#24377#25110#21345#20992#29616#35937#12290'('#27627#31186')'
          EditorEnabled = False
          Increment = 10
          MaxValue = 1000
          MinValue = 1
          TabOrder = 4
          Value = 50
          OnChange = EditDropOverSpeedChange
        end
        object CheckBoxSpellSendUpdateMsg: TCheckBox
          Left = 9
          Top = 30
          Width = 135
          Height = 16
          Hint = #25511#21046#20154#29289#21516#26102#24819#21516#25805#20316#25968#25454','#21516#26102#21482#33021#26377#19968#20010#39764#27861#25915#20987#25805#20316
          Caption = #39764#27861#25805#20316#25968#25454#37327#25511#21046
          TabOrder = 0
          OnClick = CheckBoxSpellSendUpdateMsgClick
        end
        object CheckBoxActionSendActionMsg: TCheckBox
          Left = 10
          Top = 46
          Width = 135
          Height = 16
          Hint = #25511#21046#20154#29289#21516#26102#24819#21516#25805#20316#25968#25454','#21516#26102#21482#33021#26377#19968#20010#39764#27861#25915#20987#25805#20316
          Caption = #25915#20987#25805#20316#25968#25454#37327#25511#21046
          TabOrder = 1
          OnClick = CheckBoxActionSendActionMsgClick
        end
      end
      object ButtonGameSpeedDefault: TButton
        Left = 346
        Top = 182
        Width = 65
        Height = 25
        Caption = #40664#35748'(&D)'
        TabOrder = 7
        OnClick = ButtonGameSpeedDefaultClick
      end
      object ButtonActionSpeedConfig: TButton
        Left = 370
        Top = 145
        Width = 112
        Height = 25
        Caption = #32452#21512#36895#24230#35774#32622'(&A)'
        TabOrder = 6
        OnClick = ButtonActionSpeedConfigClick
      end
    end
    object TabSheet10: TTabSheet
      Caption = #29366#24577#25511#21046
      ImageIndex = 13
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ButtonCharStatusSave: TButton
        Left = 372
        Top = 187
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonCharStatusSaveClick
      end
      object GroupBox72: TGroupBox
        Left = 10
        Top = 10
        Width = 127
        Height = 97
        Caption = #40635#30201#25511#21046
        TabOrder = 0
        object CheckBoxParalyCanRun: TCheckBox
          Left = 7
          Top = 17
          Width = 82
          Height = 16
          Hint = #20154#29289#34987#40635#30201#21518#26159#21542#20801#35768#36305#21160#65292#38057#19978#20026#20801#35768#36305#21160
          Caption = #20801#35768#36305#21160
          TabOrder = 0
          OnClick = CheckBoxParalyCanRunClick
        end
        object CheckBoxParalyCanWalk: TCheckBox
          Left = 7
          Top = 34
          Width = 82
          Height = 16
          Hint = #20154#29289#34987#40635#30201#21518#26159#21542#20801#35768#36305#21160#65292#38035#19978#20026#20801#35768#36208#21160
          Caption = #20801#35768#36208#21160
          TabOrder = 1
          OnClick = CheckBoxParalyCanWalkClick
        end
        object CheckBoxParalyCanHit: TCheckBox
          Left = 7
          Top = 51
          Width = 82
          Height = 16
          Hint = #20154#29289#34987#40635#30201#21518#26159#21542#20801#35768#36305#21160#65292#38035#19978#20026#20801#35768#25915#20987
          Caption = #20801#35768#25915#20987
          TabOrder = 2
          OnClick = CheckBoxParalyCanHitClick
        end
        object CheckBoxParalyCanSpell: TCheckBox
          Left = 7
          Top = 68
          Width = 82
          Height = 16
          Hint = #20154#29289#34987#40635#30201#21518#26159#21542#20801#35768#36305#21160#65292#38035#19978#20026#20801#35768#39764#27861
          Caption = #20801#35768#39764#27861
          TabOrder = 3
          OnClick = CheckBoxParalyCanSpellClick
        end
      end
    end
    object ExpSheet: TTabSheet
      Caption = #21319#32423#32463#39564
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox8: TGroupBox
        Left = 358
        Top = 10
        Width = 163
        Height = 116
        Caption = #26432#24618#32463#39564
        TabOrder = 2
        object Label23: TLabel
          Left = 13
          Top = 22
          Width = 30
          Height = 12
          Caption = #20493#29575':'
        end
        object EditKillMonExpMultiple: TSpinEdit
          Left = 48
          Top = 17
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 2000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditKillMonExpMultipleChange
        end
        object CheckBoxHighLevelKillMonFixExp: TCheckBox
          Left = 14
          Top = 40
          Width = 131
          Height = 22
          Caption = #39640#31561#32423#26432#24618#32463#39564#19981#21464
          TabOrder = 1
          OnClick = CheckBoxHighLevelKillMonFixExpClick
        end
        object CheckBoxHighLevelGroupFixExp: TCheckBox
          Left = 14
          Top = 56
          Width = 139
          Height = 22
          Caption = #39640#20302#31561#32423#32452#38431#32463#39564#19981#21464
          TabOrder = 2
          OnClick = CheckBoxHighLevelGroupFixExpClick
        end
        object CheckBoxGroupSameScreen: TCheckBox
          Left = 14
          Top = 72
          Width = 139
          Height = 22
          Hint = #24320#21551#21518#65292#32452#38431#20154#29289#19981#22312#21516#19968#23631#24149#20869#65292#20173#28982#21487#20197#20998#21040#32463#39564#12290
          Caption = #32452#38431#19981#38656#35201#21516#19968#23631#34109#20869
          TabOrder = 3
          OnClick = CheckBoxGroupSameScreenClick
        end
        object CheckBoxGroupSameMap: TCheckBox
          Left = 34
          Top = 90
          Width = 119
          Height = 22
          Hint = #24320#21551#38750#21516#23631#24149#20998#32463#39564#21518#65292#26159#21542#38656#35201#22312#21516#19968#22320#22270#65292#24320#21551#21518#65292#20219#20309#22320#28857#32452#38431#37117#21487#20197#20998#32463#39564#12290
          Caption = #19981#38656#35201#22312#21516#19968#22320#22270
          TabOrder = 4
          OnClick = CheckBoxGroupSameMapClick
        end
      end
      object ButtonExpSave: TButton
        Left = 372
        Top = 166
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonExpSaveClick
      end
      object GroupBoxLevelExp: TGroupBox
        Left = 10
        Top = 10
        Width = 176
        Height = 191
        Caption = #21319#32423#32463#39564'('#26368#39640#26377#25928#31561#32423'65535)'
        TabOrder = 0
        object Label37: TLabel
          Left = 14
          Top = 166
          Width = 30
          Height = 12
          Caption = #35745#21010':'
        end
        object ComboBoxLevelExp: TComboBox
          Left = 50
          Top = 161
          Width = 115
          Height = 20
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
          OnClick = ComboBoxLevelExpClick
        end
        object GridLevelExp: TStringGrid
          Left = 10
          Top = 20
          Width = 155
          Height = 138
          ColCount = 2
          DefaultRowHeight = 18
          RowCount = 501
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
          TabOrder = 0
          OnSetEditText = GridLevelExpSetEditText
          ColWidths = (
            64
            67)
          RowHeights = (
            18
            18
            19
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18)
        end
      end
      object GroupBox75: TGroupBox
        Left = 192
        Top = 10
        Width = 161
        Height = 65
        Caption = #26368#39640#31561#32423#38480#21046
        TabOrder = 1
        object Label146: TLabel
          Left = 9
          Top = 20
          Width = 30
          Height = 12
          Caption = #20154#29289':'
        end
        object Label147: TLabel
          Left = 9
          Top = 44
          Width = 30
          Height = 12
          Caption = #33521#38596':'
        end
        object EditPlayMaxLevel: TSpinEdit
          Left = 44
          Top = 16
          Width = 57
          Height = 21
          Hint = #24403#20154#29289#31561#32423#22823#20110#25110#31561#20110#35813#20540#26102#65292#20154#29289#23558#19981#20877#21319#32423#12290
          MaxValue = 65535
          MinValue = 1
          TabOrder = 0
          Value = 65535
          OnChange = EditPlayMaxLevelChange
        end
        object EditHeroMaxLevel: TSpinEdit
          Left = 44
          Top = 40
          Width = 57
          Height = 21
          Hint = #24403#33521#38596#31561#32423#22823#20110#25110#31561#20110#35813#20540#26102#65292#33521#38596#23558#19981#20877#21319#32423#12290
          MaxValue = 65535
          MinValue = 1
          TabOrder = 1
          Value = 65535
          OnChange = EditHeroMaxLevelChange
        end
      end
      object GroupBox76: TGroupBox
        Left = 192
        Top = 130
        Width = 161
        Height = 70
        Caption = #22266#23450#32463#39564#35774#32622
        TabOrder = 4
        object Label148: TLabel
          Left = 9
          Top = 21
          Width = 30
          Height = 12
          Caption = #20154#29289':'
        end
        object Label151: TLabel
          Left = 9
          Top = 43
          Width = 30
          Height = 12
          Caption = #33521#38596':'
        end
        object EditPlayFixupExp: TEdit
          Left = 42
          Top = 17
          Width = 111
          Height = 20
          Hint = #24403#20154#29289#31561#32423#22823#20110'500'#32423#20197#21518#65292#22266#23450#21319#32423#32463#39564#20540#12290#26368#22823#19981#33021#36229#36807'40'#20159#12290
          TabOrder = 0
          Text = '0'
          OnChange = EditPlayFixupExpChange
        end
        object EditHeroFixupExp: TEdit
          Left = 42
          Top = 39
          Width = 111
          Height = 20
          Hint = #24403#33521#38596#31561#32423#22823#20110'500'#32423#20197#21518#65292#22266#23450#21319#32423#32463#39564#20540#12290#26368#22823#19981#33021#36229#36807'40'#20159#12290
          TabOrder = 1
          Text = '0'
          OnChange = EditPlayFixupExpChange
        end
      end
      object GroupBox78: TGroupBox
        Left = 192
        Top = 80
        Width = 161
        Height = 46
        Caption = #33521#38596#21319#32423#32463#39564
        TabOrder = 3
        object Label149: TLabel
          Left = 9
          Top = 21
          Width = 54
          Height = 12
          Caption = #32463#39564#27604#20363':'
        end
        object Label150: TLabel
          Left = 127
          Top = 21
          Width = 24
          Height = 12
          Caption = '/100'
        end
        object EditHeroExpRate: TSpinEdit
          Left = 68
          Top = 17
          Width = 53
          Height = 21
          Hint = #33521#38596#21319#32423#25152#38656#32463#39564#27604#20363#65292#35813#27604#20363#26159#21442#29031#20154#29289#21319#32423#32463#39564#26469#30340#65292#22914#26524#35813#20540#20026'10'#65292#21017#34920#31034#20026'0.1'#20493#12290
          EditorEnabled = False
          MaxValue = 100000
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditHeroExpRateChange
        end
      end
    end
    object CastleSheet: TTabSheet
      Caption = #22478#22561#21442#25968
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox9: TGroupBox
        Left = 10
        Top = 10
        Width = 157
        Height = 115
        Caption = #36153#29992#25910#20837
        TabOrder = 0
        object Label24: TLabel
          Left = 10
          Top = 17
          Width = 54
          Height = 12
          Caption = #32500#20462#22478#38376':'
        end
        object Label25: TLabel
          Left = 10
          Top = 41
          Width = 54
          Height = 12
          Caption = #32500#20462#22478#22681':'
        end
        object Label26: TLabel
          Left = 10
          Top = 65
          Width = 54
          Height = 12
          Caption = #38599#29992#24339#31661':'
        end
        object Label27: TLabel
          Left = 10
          Top = 91
          Width = 54
          Height = 12
          Caption = #38599#29992#21355#22763':'
        end
        object EditRepairDoorPrice: TSpinEdit
          Left = 69
          Top = 13
          Width = 78
          Height = 21
          Increment = 10000
          MaxValue = 100000000
          MinValue = 10000
          TabOrder = 0
          Value = 2000000
          OnChange = EditRepairDoorPriceChange
        end
        object EditRepairWallPrice: TSpinEdit
          Left = 69
          Top = 37
          Width = 78
          Height = 21
          Increment = 10000
          MaxValue = 100000000
          MinValue = 10000
          TabOrder = 1
          Value = 500000
          OnChange = EditRepairWallPriceChange
        end
        object EditHireArcherPrice: TSpinEdit
          Left = 69
          Top = 61
          Width = 78
          Height = 21
          Increment = 10000
          MaxValue = 100000000
          MinValue = 10000
          TabOrder = 2
          Value = 300000
          OnChange = EditHireArcherPriceChange
        end
        object EditHireGuardPrice: TSpinEdit
          Left = 69
          Top = 86
          Width = 78
          Height = 21
          Increment = 10000
          MaxValue = 100000000
          MinValue = 10000
          TabOrder = 3
          Value = 300000
          OnChange = EditHireGuardPriceChange
        end
      end
      object GroupBox10: TGroupBox
        Left = 10
        Top = 129
        Width = 157
        Height = 67
        Caption = #37329#24065#19978#38480
        TabOrder = 5
        object Label31: TLabel
          Left = 10
          Top = 17
          Width = 54
          Height = 12
          Caption = #22478#20869#36164#37329':'
        end
        object Label32: TLabel
          Left = 10
          Top = 41
          Width = 54
          Height = 12
          Caption = #19968#22825#25910#20837':'
        end
        object EditCastleGoldMax: TSpinEdit
          Left = 69
          Top = 13
          Width = 78
          Height = 21
          Increment = 10000
          MaxValue = 100000000
          MinValue = 10000
          TabOrder = 0
          Value = 10000000
          OnChange = EditCastleGoldMaxChange
        end
        object EditCastleOneDayGold: TSpinEdit
          Left = 69
          Top = 37
          Width = 78
          Height = 21
          Increment = 10000
          MaxValue = 100000000
          MinValue = 10000
          TabOrder = 1
          Value = 2000000
          OnChange = EditCastleOneDayGoldChange
        end
      end
      object GroupBox11: TGroupBox
        Left = 298
        Top = 57
        Width = 121
        Height = 93
        Caption = #22238#22478#28857
        TabOrder = 3
        object Label28: TLabel
          Left = 10
          Top = 17
          Width = 42
          Height = 12
          Caption = #22320#22270#21495':'
        end
        object Label29: TLabel
          Left = 10
          Top = 41
          Width = 42
          Height = 12
          Caption = #24231#26631' X:'
        end
        object Label30: TLabel
          Left = 10
          Top = 64
          Width = 42
          Height = 12
          Caption = #24231#26631' Y:'
        end
        object EditCastleHomeX: TSpinEdit
          Left = 56
          Top = 37
          Width = 58
          Height = 21
          MaxValue = 1000
          MinValue = 1
          TabOrder = 1
          Value = 644
          OnChange = EditCastleHomeXChange
        end
        object EditCastleHomeY: TSpinEdit
          Left = 56
          Top = 63
          Width = 58
          Height = 21
          MaxValue = 1000
          MinValue = 1
          TabOrder = 2
          Value = 290
          OnChange = EditCastleHomeYChange
        end
        object EditCastleHomeMap: TEdit
          Left = 56
          Top = 13
          Width = 58
          Height = 20
          MaxLength = 20
          TabOrder = 0
          Text = '3'
          OnChange = EditCastleHomeMapChange
        end
      end
      object GroupBox12: TGroupBox
        Left = 175
        Top = 10
        Width = 116
        Height = 65
        Caption = #25915#22478#21306#22495#33539#22260
        TabOrder = 1
        object Label34: TLabel
          Left = 10
          Top = 17
          Width = 42
          Height = 12
          Caption = #24231#26631' X:'
        end
        object Label35: TLabel
          Left = 10
          Top = 41
          Width = 42
          Height = 12
          Caption = #24231#26631' Y:'
        end
        object EditWarRangeX: TSpinEdit
          Left = 56
          Top = 13
          Width = 50
          Height = 21
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditWarRangeXChange
        end
        object EditWarRangeY: TSpinEdit
          Left = 56
          Top = 37
          Width = 50
          Height = 21
          MaxValue = 1000
          MinValue = 1
          TabOrder = 1
          Value = 100
          OnChange = EditWarRangeYChange
        end
      end
      object ButtonCastleSave: TButton
        Left = 354
        Top = 171
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 7
        OnClick = ButtonCastleSaveClick
      end
      object GroupBox13: TGroupBox
        Left = 175
        Top = 77
        Width = 116
        Height = 68
        Caption = #31246#25910
        TabOrder = 4
        object Label36: TLabel
          Left = 10
          Top = 41
          Width = 42
          Height = 12
          Caption = #31246#25910#29575':'
        end
        object EditTaxRate: TSpinEdit
          Left = 56
          Top = 37
          Width = 50
          Height = 21
          MaxValue = 1000
          MinValue = 1
          TabOrder = 1
          Value = 5
          OnChange = EditTaxRateChange
        end
        object CheckBoxGetAllNpcTax: TCheckBox
          Left = 10
          Top = 14
          Width = 93
          Height = 22
          Caption = #25152#26377#21830#20154#20132#31246
          TabOrder = 0
          OnClick = CheckBoxGetAllNpcTaxClick
        end
      end
      object GroupBox14: TGroupBox
        Left = 298
        Top = 10
        Width = 121
        Height = 43
        Caption = #22478#22561#21517#31216
        TabOrder = 2
        object Label33: TLabel
          Left = 8
          Top = 19
          Width = 30
          Height = 12
          Caption = #21517#31216':'
        end
        object EditCastleName: TEdit
          Left = 40
          Top = 15
          Width = 73
          Height = 20
          TabOrder = 0
          Text = #27801#24052#20811
          OnChange = EditCastleNameChange
        end
      end
      object GroupBox54: TGroupBox
        Left = 175
        Top = 151
        Width = 116
        Height = 45
        Caption = #25104#21592#25240#25187
        TabOrder = 6
        object Label107: TLabel
          Left = 10
          Top = 19
          Width = 42
          Height = 12
          Caption = #25240#25187#29575':'
        end
        object EditCastleMemberPriceRate: TSpinEdit
          Left = 56
          Top = 15
          Width = 50
          Height = 21
          Hint = #22478#22561#34892#20250#25104#21592#36141#20080#29289#21697#25240#25187#29575#65292#25968#23383#20026#30334#20998#20043#20960
          MaxValue = 200
          MinValue = 10
          TabOrder = 0
          Value = 10
          OnChange = EditCastleMemberPriceRateChange
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #20449#24687#25511#21046
      ImageIndex = 8
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox36: TGroupBox
        Left = 10
        Top = 10
        Width = 133
        Height = 74
        Caption = #21457#36865#20449#24687#38271#24230
        TabOrder = 0
        object Label71: TLabel
          Left = 12
          Top = 22
          Width = 54
          Height = 12
          Caption = #32842#22825#20449#24687':'
        end
        object Label72: TLabel
          Left = 12
          Top = 47
          Width = 54
          Height = 12
          Caption = #24191#25773#20449#24687':'
        end
        object EditSayMsgMaxLen: TSpinEdit
          Left = 69
          Top = 18
          Width = 53
          Height = 21
          Hint = #21457#36865#25991#23383#26368#22823#38271#24230
          MaxValue = 255
          MinValue = 1
          TabOrder = 0
          Value = 50
          OnChange = EditSayMsgMaxLenChange
        end
        object EditSayRedMsgMaxLen: TSpinEdit
          Left = 69
          Top = 43
          Width = 53
          Height = 21
          Hint = 'GM'#32418#33394#24191#25773#25991#23383#26368#22823#38271#24230
          MaxValue = 255
          MinValue = 1
          TabOrder = 1
          Value = 50
          OnChange = EditSayRedMsgMaxLenChange
        end
      end
      object GroupBox37: TGroupBox
        Left = 10
        Top = 91
        Width = 133
        Height = 47
        Caption = #20801#35768#21898#35805#31561#32423
        TabOrder = 3
        object Label73: TLabel
          Left = 12
          Top = 22
          Width = 54
          Height = 12
          Caption = #20154#29289#31561#32423':'
        end
        object EditCanShoutMsgLevel: TSpinEdit
          Left = 69
          Top = 18
          Width = 53
          Height = 21
          Hint = #20801#35768#21898#35805#31561#32423#65292#20154#29289#36798#21040#35813#31561#32423#21518#25165#20801#35768#21898#35805
          MaxValue = 65535
          MinValue = 1
          TabOrder = 0
          Value = 50
          OnChange = EditCanShoutMsgLevelChange
        end
      end
      object GroupBox38: TGroupBox
        Left = 151
        Top = 10
        Width = 146
        Height = 63
        Caption = #21457#36865#31649#29702#24191#25773#20449#24687
        TabOrder = 1
        object Label75: TLabel
          Left = 10
          Top = 40
          Width = 54
          Height = 12
          Caption = #21457#36865#21629#20196':'
        end
        object CheckBoxShutRedMsgShowGMName: TCheckBox
          Left = 9
          Top = 15
          Width = 104
          Height = 21
          Hint = 'GM'#21457#36865#25991#23383#26159#21542#26174#31034#20154#29289#21517#31216
          Caption = #26174#31034#20154#29289#21517#31216
          TabOrder = 0
          OnClick = CheckBoxShutRedMsgShowGMNameClick
        end
        object EditGMRedMsgCmd: TEdit
          Left = 71
          Top = 35
          Width = 51
          Height = 20
          Hint = #21457#36865#32418#23383#24191#25773#21629#20196#31526#65292#40664#35748#20026' !'
          MaxLength = 20
          TabOrder = 1
          OnChange = EditGMRedMsgCmdChange
        end
      end
      object ButtonMsgSave: TButton
        Left = 364
        Top = 158
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonMsgSaveClick
      end
      object GroupBox68: TGroupBox
        Left = 151
        Top = 81
        Width = 146
        Height = 96
        Caption = #21457#36865#20449#24687#36895#24230#25511#21046
        TabOrder = 2
        object Label135: TLabel
          Left = 12
          Top = 22
          Width = 48
          Height = 12
          Caption = #21457#36865#38388#38548
        end
        object Label138: TLabel
          Left = 12
          Top = 47
          Width = 54
          Height = 12
          Caption = #21457#36865#25968#37327':'
        end
        object Label139: TLabel
          Left = 12
          Top = 72
          Width = 54
          Height = 12
          Caption = #31105#35328#26102#38388':'
        end
        object Label140: TLabel
          Left = 126
          Top = 22
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label141: TLabel
          Left = 126
          Top = 74
          Width = 12
          Height = 12
          Caption = #31186
        end
        object EditSayMsgTime: TSpinEdit
          Left = 69
          Top = 18
          Width = 53
          Height = 21
          MaxValue = 1000000
          MinValue = 1
          TabOrder = 0
          Value = 50
          OnChange = EditSayMsgTimeChange
        end
        object EditSayMsgCount: TSpinEdit
          Left = 69
          Top = 43
          Width = 53
          Height = 21
          MaxValue = 255
          MinValue = 1
          TabOrder = 1
          Value = 50
          OnChange = EditSayMsgCountChange
        end
        object EditDisableSayMsgTime: TSpinEdit
          Left = 69
          Top = 68
          Width = 53
          Height = 21
          MaxValue = 100000
          MinValue = 1
          TabOrder = 2
          Value = 50
          OnChange = EditDisableSayMsgTimeChange
        end
      end
      object GroupBox71: TGroupBox
        Left = 10
        Top = 145
        Width = 133
        Height = 51
        Caption = #26174#31034#21069#32512#20449#24687
        TabOrder = 4
        object CheckBoxShowPreFixMsg: TCheckBox
          Left = 9
          Top = 17
          Width = 112
          Height = 21
          Hint = #28216#25103#20013#32842#22825#26694#20013#26174#31034#30340#20449#24687#65292#26159#21542#26174#31034#20449#24687#21069#32512
          Caption = #26174#31034#20449#24687#30340#21069#32512
          TabOrder = 0
          OnClick = CheckBoxShowPreFixMsgClick
        end
      end
    end
    object TabSheet8: TTabSheet
      Caption = #25991#23383#39068#33394
      ImageIndex = 11
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ButtonMsgColorSave: TButton
        Left = 401
        Top = 185
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 11
        OnClick = ButtonMsgColorSaveClick
      end
      object GroupBox55: TGroupBox
        Left = 10
        Top = 10
        Width = 109
        Height = 66
        Caption = #32842#22825#25991#23383
        TabOrder = 0
        object Label108: TLabel
          Left = 12
          Top = 18
          Width = 30
          Height = 12
          Caption = #25991#23383':'
        end
        object Label109: TLabel
          Left = 12
          Top = 42
          Width = 30
          Height = 12
          Caption = #32972#26223':'
        end
        object LabeltHearMsgFColor: TLabel
          Left = 91
          Top = 16
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelHearMsgBColor: TLabel
          Left = 91
          Top = 40
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditHearMsgFColor: TSpinEdit
          Left = 46
          Top = 14
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditHearMsgFColorChange
        end
        object EdittHearMsgBColor: TSpinEdit
          Left = 46
          Top = 38
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EdittHearMsgBColorChange
        end
      end
      object GroupBox56: TGroupBox
        Left = 10
        Top = 77
        Width = 109
        Height = 66
        Caption = #31169#32842#25991#23383
        TabOrder = 4
        object Label110: TLabel
          Left = 12
          Top = 18
          Width = 30
          Height = 12
          Caption = #25991#23383':'
        end
        object Label111: TLabel
          Left = 12
          Top = 42
          Width = 30
          Height = 12
          Caption = #32972#26223':'
        end
        object LabelWhisperMsgFColor: TLabel
          Left = 91
          Top = 16
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelWhisperMsgBColor: TLabel
          Left = 91
          Top = 40
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditWhisperMsgFColor: TSpinEdit
          Left = 46
          Top = 14
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditWhisperMsgFColorChange
        end
        object EditWhisperMsgBColor: TSpinEdit
          Left = 46
          Top = 38
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditWhisperMsgBColorChange
        end
      end
      object GroupBox57: TGroupBox
        Left = 10
        Top = 144
        Width = 109
        Height = 66
        Caption = 'GM'#31169#32842#25991#23383
        TabOrder = 8
        object Label112: TLabel
          Left = 12
          Top = 18
          Width = 30
          Height = 12
          Caption = #25991#23383':'
        end
        object Label113: TLabel
          Left = 12
          Top = 42
          Width = 30
          Height = 12
          Caption = #32972#26223':'
        end
        object LabelGMWhisperMsgFColor: TLabel
          Left = 91
          Top = 16
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelGMWhisperMsgBColor: TLabel
          Left = 91
          Top = 40
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditGMWhisperMsgFColor: TSpinEdit
          Left = 46
          Top = 14
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditGMWhisperMsgFColorChange
        end
        object EditGMWhisperMsgBColor: TSpinEdit
          Left = 46
          Top = 38
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditGMWhisperMsgBColorChange
        end
      end
      object GroupBox58: TGroupBox
        Left = 125
        Top = 10
        Width = 109
        Height = 66
        Caption = #32418#33394#25552#31034#25991#23383
        TabOrder = 1
        object Label116: TLabel
          Left = 12
          Top = 18
          Width = 30
          Height = 12
          Caption = #25991#23383':'
        end
        object Label117: TLabel
          Left = 12
          Top = 42
          Width = 30
          Height = 12
          Caption = #32972#26223':'
        end
        object LabelRedMsgFColor: TLabel
          Left = 91
          Top = 16
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelRedMsgBColor: TLabel
          Left = 91
          Top = 40
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditRedMsgFColor: TSpinEdit
          Left = 46
          Top = 14
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditRedMsgFColorChange
        end
        object EditRedMsgBColor: TSpinEdit
          Left = 46
          Top = 38
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditRedMsgBColorChange
        end
      end
      object GroupBox59: TGroupBox
        Left = 125
        Top = 77
        Width = 109
        Height = 66
        Caption = #32511#33394#25552#31034#25991#23383
        TabOrder = 5
        object Label120: TLabel
          Left = 12
          Top = 18
          Width = 30
          Height = 12
          Caption = #25991#23383':'
        end
        object Label121: TLabel
          Left = 12
          Top = 42
          Width = 30
          Height = 12
          Caption = #32972#26223':'
        end
        object LabelGreenMsgFColor: TLabel
          Left = 91
          Top = 16
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelGreenMsgBColor: TLabel
          Left = 91
          Top = 40
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditGreenMsgFColor: TSpinEdit
          Left = 46
          Top = 14
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditGreenMsgFColorChange
        end
        object EditGreenMsgBColor: TSpinEdit
          Left = 46
          Top = 38
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditGreenMsgBColorChange
        end
      end
      object GroupBox60: TGroupBox
        Left = 125
        Top = 144
        Width = 109
        Height = 66
        Caption = #34013#33394#25552#31034#25991#23383
        TabOrder = 9
        object Label124: TLabel
          Left = 12
          Top = 18
          Width = 30
          Height = 12
          Caption = #25991#23383':'
        end
        object Label125: TLabel
          Left = 12
          Top = 42
          Width = 30
          Height = 12
          Caption = #32972#26223':'
        end
        object LabelBlueMsgFColor: TLabel
          Left = 91
          Top = 16
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelBlueMsgBColor: TLabel
          Left = 91
          Top = 40
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditBlueMsgFColor: TSpinEdit
          Left = 46
          Top = 14
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditBlueMsgFColorChange
        end
        object EditBlueMsgBColor: TSpinEdit
          Left = 46
          Top = 38
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditBlueMsgBColorChange
        end
      end
      object GroupBox61: TGroupBox
        Left = 241
        Top = 10
        Width = 109
        Height = 66
        Caption = #21898#35805#25991#23383
        TabOrder = 2
        object Label128: TLabel
          Left = 12
          Top = 18
          Width = 30
          Height = 12
          Caption = #25991#23383':'
        end
        object Label129: TLabel
          Left = 12
          Top = 42
          Width = 30
          Height = 12
          Caption = #32972#26223':'
        end
        object LabelCryMsgFColor: TLabel
          Left = 91
          Top = 16
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelCryMsgBColor: TLabel
          Left = 91
          Top = 40
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditCryMsgFColor: TSpinEdit
          Left = 46
          Top = 14
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditCryMsgFColorChange
        end
        object EditCryMsgBColor: TSpinEdit
          Left = 46
          Top = 38
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditCryMsgBColorChange
        end
      end
      object GroupBox62: TGroupBox
        Left = 241
        Top = 77
        Width = 109
        Height = 66
        Caption = #34892#20250#32842#22825#25991#23383
        TabOrder = 6
        object Label132: TLabel
          Left = 12
          Top = 18
          Width = 30
          Height = 12
          Caption = #25991#23383':'
        end
        object Label133: TLabel
          Left = 12
          Top = 42
          Width = 30
          Height = 12
          Caption = #32972#26223':'
        end
        object LabelGuildMsgFColor: TLabel
          Left = 91
          Top = 16
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelGuildMsgBColor: TLabel
          Left = 91
          Top = 40
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditGuildMsgFColor: TSpinEdit
          Left = 46
          Top = 14
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditGuildMsgFColorChange
        end
        object EditGuildMsgBColor: TSpinEdit
          Left = 46
          Top = 38
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditGuildMsgBColorChange
        end
      end
      object GroupBox63: TGroupBox
        Left = 241
        Top = 144
        Width = 109
        Height = 66
        Caption = #32534#32452#32842#22825#25991#23383
        TabOrder = 10
        object Label136: TLabel
          Left = 12
          Top = 18
          Width = 30
          Height = 12
          Caption = #25991#23383':'
        end
        object Label137: TLabel
          Left = 12
          Top = 42
          Width = 30
          Height = 12
          Caption = #32972#26223':'
        end
        object LabelGroupMsgFColor: TLabel
          Left = 91
          Top = 16
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelGroupMsgBColor: TLabel
          Left = 91
          Top = 40
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditGroupMsgFColor: TSpinEdit
          Left = 46
          Top = 14
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditGroupMsgFColorChange
        end
        object EditGroupMsgBColor: TSpinEdit
          Left = 46
          Top = 38
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditGroupMsgBColorChange
        end
      end
      object GroupBox65: TGroupBox
        Left = 357
        Top = 10
        Width = 109
        Height = 66
        Caption = #31069#31119#35821#25991#23383
        TabOrder = 3
        object Label122: TLabel
          Left = 12
          Top = 18
          Width = 30
          Height = 12
          Caption = #25991#23383':'
        end
        object Label123: TLabel
          Left = 12
          Top = 42
          Width = 30
          Height = 12
          Caption = #32972#26223':'
        end
        object LabelCustMsgFColor: TLabel
          Left = 91
          Top = 16
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelCustMsgBColor: TLabel
          Left = 91
          Top = 40
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditCustMsgFColor: TSpinEdit
          Left = 46
          Top = 14
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditCustMsgFColorChange
        end
        object EditCustMsgBColor: TSpinEdit
          Left = 46
          Top = 38
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditCustMsgBColorChange
        end
      end
      object GroupBox74: TGroupBox
        Left = 357
        Top = 77
        Width = 109
        Height = 66
        Caption = #21315#37324#20256#38899
        TabOrder = 7
        object Label78: TLabel
          Left = 12
          Top = 18
          Width = 30
          Height = 12
          Caption = #25991#23383':'
        end
        object Label145: TLabel
          Left = 12
          Top = 42
          Width = 30
          Height = 12
          Caption = #32972#26223':'
        end
        object LabelCudtMsgFColor: TLabel
          Left = 91
          Top = 16
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object LabelCudtMsgBColor: TLabel
          Left = 91
          Top = 40
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditCudtMsgFColor: TSpinEdit
          Left = 46
          Top = 14
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditCudtMsgFColorChange
        end
        object EditCudtMsgBColor: TSpinEdit
          Left = 46
          Top = 38
          Width = 40
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditCudtMsgBColorChange
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = #26102#38388#25511#21046
      ImageIndex = 9
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox39: TGroupBox
        Left = 10
        Top = 10
        Width = 110
        Height = 51
        Caption = #30003#35831#25915#22478#22825#25968
        TabOrder = 0
        object Label74: TLabel
          Left = 12
          Top = 24
          Width = 30
          Height = 12
          Caption = #22825#25968':'
        end
        object Label15: TLabel
          Left = 90
          Top = 23
          Width = 12
          Height = 12
          Caption = #22825
        end
        object EditStartCastleWarDays: TSpinEdit
          Left = 46
          Top = 19
          Width = 41
          Height = 21
          Hint = #30003#35831#25915#22478#25152#38656#22825#25968#65292#21253#25324#24403#22825
          MaxValue = 10
          MinValue = 2
          TabOrder = 0
          Value = 4
          OnChange = EditStartCastleWarDaysChange
        end
      end
      object GroupBox40: TGroupBox
        Left = 10
        Top = 65
        Width = 110
        Height = 51
        Caption = #25915#22478#24320#22987#26102#38388
        TabOrder = 4
        object Label76: TLabel
          Left = 12
          Top = 24
          Width = 30
          Height = 12
          Caption = #26102#38388':'
        end
        object Label14: TLabel
          Left = 90
          Top = 23
          Width = 12
          Height = 12
          Caption = #28857
        end
        object EditStartCastlewarTime: TSpinEdit
          Left = 46
          Top = 19
          Width = 41
          Height = 21
          Hint = #25915#22478#24320#22987#26102#38388#65292'20'#28857#34920#31034'20:00'
          MaxValue = 24
          MinValue = 1
          TabOrder = 0
          Value = 4
          OnChange = EditStartCastlewarTimeChange
        end
      end
      object GroupBox41: TGroupBox
        Left = 10
        Top = 122
        Width = 110
        Height = 51
        Caption = #25915#22478#32467#26463#25552#31034
        TabOrder = 7
        object Label79: TLabel
          Left = 12
          Top = 24
          Width = 30
          Height = 12
          Caption = #26102#38388':'
        end
        object Label80: TLabel
          Left = 90
          Top = 23
          Width = 12
          Height = 12
          Caption = #20998
        end
        object EditShowCastleWarEndMsgTime: TSpinEdit
          Left = 46
          Top = 19
          Width = 41
          Height = 21
          Hint = #25915#22478#25112#32467#26463#21069#25351#23450#26102#38388#25552#31034
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 4
          OnChange = EditShowCastleWarEndMsgTimeChange
        end
      end
      object GroupBox42: TGroupBox
        Left = 126
        Top = 10
        Width = 110
        Height = 51
        Caption = #25915#22478#26102#38271
        TabOrder = 1
        object Label81: TLabel
          Left = 12
          Top = 24
          Width = 30
          Height = 12
          Caption = #26102#38271':'
        end
        object Label82: TLabel
          Left = 90
          Top = 23
          Width = 12
          Height = 12
          Caption = #20998
        end
        object EditCastleWarTime: TSpinEdit
          Left = 46
          Top = 19
          Width = 41
          Height = 21
          Hint = #25915#22478#25112#26102#38388#38271#24230#65292#40664#35748#20026'3'#23567#26102
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 4
          OnChange = EditCastleWarTimeChange
        end
      end
      object GroupBox43: TGroupBox
        Left = 126
        Top = 65
        Width = 110
        Height = 51
        Caption = #31105#27490#21344#39046#26102#38388
        TabOrder = 5
        object Label83: TLabel
          Left = 12
          Top = 24
          Width = 30
          Height = 12
          Caption = #26102#38271':'
        end
        object Label84: TLabel
          Left = 90
          Top = 23
          Width = 12
          Height = 12
          Caption = #20998
        end
        object EditGetCastleTime: TSpinEdit
          Left = 46
          Top = 19
          Width = 41
          Height = 21
          Hint = #25915#22478#25112#24320#22987#26102#65292#25351#23450#26102#38388#20869#19981#20801#35768#21344#39046
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 4
          OnChange = EditGetCastleTimeChange
        end
      end
      object GroupBox44: TGroupBox
        Left = 243
        Top = 10
        Width = 110
        Height = 51
        Caption = #20154#29289#25968#25454#20445#23384#38388#38548
        TabOrder = 2
        object Label85: TLabel
          Left = 12
          Top = 24
          Width = 30
          Height = 12
          Caption = #26102#38271':'
        end
        object Label86: TLabel
          Left = 90
          Top = 23
          Width = 12
          Height = 12
          Caption = #20998
        end
        object EditSaveHumanRcdTime: TSpinEdit
          Left = 46
          Top = 19
          Width = 41
          Height = 21
          Hint = #20154#29289#25968#25454#20445#23384#26102#38388#38388#38548
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 4
          OnChange = EditSaveHumanRcdTimeChange
        end
      end
      object GroupBox45: TGroupBox
        Left = 242
        Top = 122
        Width = 110
        Height = 51
        Caption = #20154#29289#36864#20986#37322#25918
        TabOrder = 3
        object Label87: TLabel
          Left = 12
          Top = 24
          Width = 30
          Height = 12
          Caption = #26102#38271':'
        end
        object Label88: TLabel
          Left = 90
          Top = 23
          Width = 12
          Height = 12
          Caption = #20998
        end
        object EditHumanFreeDelayTime: TSpinEdit
          Left = 46
          Top = 19
          Width = 41
          Height = 21
          Hint = #20154#29289#36864#20986#21518#25351#23450#26102#38388#37322#25918#65292#35813#26102#38388#19981#33021#22826#30701#65292#21542#21017#21487#33021#20135#29983#38169#35823
          Enabled = False
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 4
          OnChange = EditHumanFreeDelayTimeChange
        end
      end
      object GroupBox46: TGroupBox
        Left = 360
        Top = 9
        Width = 139
        Height = 107
        Caption = #28165#29702#26102#38388
        TabOrder = 9
        object Label89: TLabel
          Left = 15
          Top = 26
          Width = 30
          Height = 12
          Caption = #27515#23608':'
        end
        object Label90: TLabel
          Left = 103
          Top = 25
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label91: TLabel
          Left = 15
          Top = 81
          Width = 30
          Height = 12
          Caption = #29289#21697':'
        end
        object Label92: TLabel
          Left = 103
          Top = 79
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label157: TLabel
          Left = 14
          Top = 52
          Width = 30
          Height = 12
          Caption = #20154#24418':'
        end
        object Label158: TLabel
          Left = 103
          Top = 52
          Width = 12
          Height = 12
          Caption = #31186
        end
        object EditMakeGhostTime: TSpinEdit
          Left = 47
          Top = 49
          Width = 51
          Height = 21
          Hint = #28165#38500#22320#19978#20154#12289#20154#24418#24618#12289#21487#25366#31867#23608#20307#22914':'#40481','#40575#31561#38388#38548
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 180
          OnChange = EditMakeGhostTimeChange
        end
        object EditClearDropOnFloorItemTime: TSpinEdit
          Left = 47
          Top = 77
          Width = 51
          Height = 21
          Hint = #28165#38500#22320#19978#29289#21697#38388#38548
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 1
          Value = 3600
          OnChange = EditClearDropOnFloorItemTimeChange
        end
        object EditMakeMonGhostTime: TSpinEdit
          Left = 47
          Top = 22
          Width = 51
          Height = 21
          Hint = #28165#38500#22320#19978#24618#29289#23608#20307#38388#38548
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 2
          Value = 180
          OnChange = EditMakeMonGhostTimeChange
        end
      end
      object GroupBox47: TGroupBox
        Left = 243
        Top = 65
        Width = 110
        Height = 51
        Caption = #29190#29289#21697#21487#25441#26102#38388
        TabOrder = 6
        object Label93: TLabel
          Left = 12
          Top = 24
          Width = 30
          Height = 12
          Caption = #26102#38271':'
        end
        object Label94: TLabel
          Left = 90
          Top = 23
          Width = 12
          Height = 12
          Caption = #31186
        end
        object EditFloorItemCanPickUpTime: TSpinEdit
          Left = 46
          Top = 19
          Width = 41
          Height = 21
          Hint = #20182#20154#29190#29289#21697#25110#25481#22320#19978#29289#21697#20801#35768#20182#20154#21487#25441#26102#38388
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 4
          OnChange = EditFloorItemCanPickUpTimeChange
        end
      end
      object ButtonTimeSave: TButton
        Left = 10
        Top = 180
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 10
        OnClick = ButtonTimeSaveClick
      end
      object GroupBox70: TGroupBox
        Left = 126
        Top = 122
        Width = 110
        Height = 51
        Caption = #34892#20250#25112#26102#38271
        TabOrder = 8
        object Label143: TLabel
          Left = 12
          Top = 24
          Width = 30
          Height = 12
          Caption = #26102#38271':'
        end
        object Label144: TLabel
          Left = 90
          Top = 23
          Width = 12
          Height = 12
          Caption = #20998
        end
        object EditGuildWarTime: TSpinEdit
          Left = 46
          Top = 19
          Width = 41
          Height = 21
          Hint = #34892#20250#25112#26102#38388#38271#24230
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 4
          OnChange = EditGuildWarTimeChange
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = #20215#26684#36153#29992
      ImageIndex = 10
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox48: TGroupBox
        Left = 10
        Top = 10
        Width = 135
        Height = 50
        Caption = #30003#35831#34892#20250#36153#29992
        TabOrder = 0
        object Label95: TLabel
          Left = 14
          Top = 23
          Width = 30
          Height = 12
          Caption = #36153#29992':'
        end
        object EditBuildGuildPrice: TSpinEdit
          Left = 49
          Top = 19
          Width = 72
          Height = 21
          Hint = #30003#35831#21019#24314#34892#20250#25152#38656#36153#29992
          MaxValue = 100000000
          MinValue = 1000
          TabOrder = 0
          Value = 1000000
          OnChange = EditBuildGuildPriceChange
        end
      end
      object GroupBox49: TGroupBox
        Left = 10
        Top = 64
        Width = 135
        Height = 50
        Caption = #30003#35831#34892#20250#25112#36153#29992
        TabOrder = 2
        object Label96: TLabel
          Left = 14
          Top = 23
          Width = 30
          Height = 12
          Caption = #36153#29992':'
        end
        object EditGuildWarPrice: TSpinEdit
          Left = 49
          Top = 19
          Width = 72
          Height = 21
          Hint = #30003#35831#34892#20250#25112#25152#38656#36153#29992
          MaxValue = 100000000
          MinValue = 1000
          TabOrder = 0
          Value = 30000
          OnChange = EditGuildWarPriceChange
        end
      end
      object GroupBox50: TGroupBox
        Left = 10
        Top = 118
        Width = 135
        Height = 50
        Caption = #28860#33647#20215#26684
        TabOrder = 3
        object Label97: TLabel
          Left = 14
          Top = 23
          Width = 30
          Height = 12
          Caption = #20215#26684':'
        end
        object EditMakeDurgPrice: TSpinEdit
          Left = 49
          Top = 19
          Width = 72
          Height = 21
          Hint = #28860#21046#33647#21697#25152#38656#36153#29992
          MaxValue = 100000000
          MinValue = 10
          TabOrder = 0
          Value = 10
          OnChange = EditMakeDurgPriceChange
        end
      end
      object ButtonPriceSave: TButton
        Left = 10
        Top = 176
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonPriceSaveClick
      end
      object GroupBox66: TGroupBox
        Left = 154
        Top = 10
        Width = 151
        Height = 77
        Caption = #20462#29702#29289#21697
        TabOrder = 1
        object Label126: TLabel
          Left = 14
          Top = 23
          Width = 78
          Height = 12
          Caption = #29289#20462#20215#26684#20493#25968':'
        end
        object Label127: TLabel
          Left = 14
          Top = 49
          Width = 66
          Height = 12
          Caption = #26222#20462#25481#25345#20037':'
        end
        object EditSuperRepairPriceRate: TSpinEdit
          Left = 96
          Top = 19
          Width = 46
          Height = 21
          Hint = #29305#20462#29289#21697#20215#26684#20493#25968#65292#40664#35748#20026'3'#20493
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 0
          Value = 3
          OnChange = EditSuperRepairPriceRateChange
        end
        object EditRepairItemDecDura: TSpinEdit
          Left = 96
          Top = 44
          Width = 46
          Height = 21
          Hint = #26222#36890#20462#29702#25481#25345#20037#28857#25968
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 1
          Value = 3
          OnChange = EditRepairItemDecDuraChange
        end
      end
    end
    object TabSheet9: TTabSheet
      Caption = #20154#29289#27515#20129
      ImageIndex = 12
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ButtonHumanDieSave: TButton
        Left = 376
        Top = 176
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonHumanDieSaveClick
      end
      object GroupBox67: TGroupBox
        Left = 10
        Top = 10
        Width = 165
        Height = 109
        Caption = #27515#20129#25481#29289#21697#35268#21017
        TabOrder = 0
        object CheckBoxKillByMonstDropUseItem: TCheckBox
          Left = 9
          Top = 16
          Width = 140
          Height = 16
          Hint = #24403#20154#29289#34987#24618#29289#26432#27515#21518#25353#25481#33853#26426#29575#25481#33853#36523#19978#35013#22791
          Caption = #34987#24618#29289#26432#27515#25481#35013#22791
          TabOrder = 0
          OnClick = CheckBoxKillByMonstDropUseItemClick
        end
        object CheckBoxKillByHumanDropUseItem: TCheckBox
          Left = 9
          Top = 32
          Width = 140
          Height = 16
          Hint = #24403#20154#29289#34987#20154#29289#26432#27515#21518#25353#25481#33853#26426#29575#25481#33853#36523#19978#35013#22791
          Caption = #34987#20154#29289#26432#27515#25481#35013#22791
          TabOrder = 1
          OnClick = CheckBoxKillByHumanDropUseItemClick
        end
        object CheckBoxDieScatterBag: TCheckBox
          Left = 9
          Top = 49
          Width = 140
          Height = 16
          Hint = #24403#20154#29289#27515#20129#25353#25481#33853#26426#29575#25481#33853#32972#21253#29289#21697
          Caption = #27515#20129#25481#32972#21253#29289#21697
          TabOrder = 2
          OnClick = CheckBoxDieScatterBagClick
        end
        object CheckBoxDieDropGold: TCheckBox
          Left = 9
          Top = 66
          Width = 140
          Height = 16
          Hint = #20154#29289#27515#20129#25481#33853#36523#19978#37329#24065
          Caption = #27515#20129#25481#37329#24065
          TabOrder = 3
          OnClick = CheckBoxDieDropGoldClick
        end
        object CheckBoxDieRedScatterBagAll: TCheckBox
          Left = 9
          Top = 82
          Width = 140
          Height = 16
          Hint = #32418#21517#20154#29289#27515#20129#21518#25481#33853#32972#21253#25152#26377#29289#21697
          Caption = #32418#21517#25481#20840#37096#32972#21253#29289#21697
          TabOrder = 4
          OnClick = CheckBoxDieRedScatterBagAllClick
        end
      end
      object GroupBox69: TGroupBox
        Left = 182
        Top = 10
        Width = 300
        Height = 95
        Caption = #25481#29289#21697#26426#29575
        TabOrder = 1
        object Label130: TLabel
          Left = 10
          Top = 18
          Width = 54
          Height = 12
          Caption = #25481#33853#35013#22791':'
        end
        object Label131: TLabel
          Left = 10
          Top = 42
          Width = 54
          Height = 12
          Caption = #32418#21517#35013#22791':'
        end
        object Label134: TLabel
          Left = 10
          Top = 68
          Width = 54
          Height = 12
          Caption = #32972#21253#29289#21697':'
        end
        object ScrollBarDieDropUseItemRate: TScrollBar
          Left = 68
          Top = 15
          Width = 181
          Height = 18
          Hint = #20154#29289#25481#33853#36523#19978#35013#22791#26426#29575#65292#25968#23383#36234#23567#65292#26426#29575#36234#22823
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarDieDropUseItemRateChange
        end
        object EditDieDropUseItemRate: TEdit
          Left = 254
          Top = 15
          Width = 38
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarDieRedDropUseItemRate: TScrollBar
          Left = 68
          Top = 40
          Width = 181
          Height = 18
          Hint = #32418#21517#27515#20129#25481#33853#36523#19978#35013#22791#65292#25968#23383#36234#23567#65292#26426#29575#36234#22823
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarDieRedDropUseItemRateChange
        end
        object EditDieRedDropUseItemRate: TEdit
          Left = 254
          Top = 40
          Width = 38
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarDieScatterBagRate: TScrollBar
          Left = 68
          Top = 65
          Width = 181
          Height = 18
          Hint = #20154#29289#27515#20129#25481#33853#32972#21253#29289#21697#26426#29575#65292#25968#23383#36234#23567#65292#26426#29575#36234#22823
          Max = 500
          PageSize = 0
          TabOrder = 5
          OnChange = ScrollBarDieScatterBagRateChange
        end
        object EditDieScatterBagRate: TEdit
          Left = 254
          Top = 64
          Width = 38
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 4
        end
      end
    end
    object TabSheet11: TTabSheet
      Caption = #20869#25346#25511#21046
      ImageIndex = 14
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label182: TLabel
        Left = 10
        Top = 199
        Width = 420
        Height = 12
        Caption = #27809#26377#36873#20013#30340#12290#23458#25143#31471#30340#20869#25346#37117#19981#20801#35768#20351#29992#35813#21151#33021#12290#37096#20998#35774#32622#21442#29031#20854#23427#30340#65292#22914#31359#20154
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object PageControl3: TPageControl
        Left = 8
        Top = 3
        Width = 521
        Height = 182
        ActivePage = TabSheet41
        TabOrder = 0
        object TabSheet41: TTabSheet
          Caption = #22522#26412
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object ShowRedHPLable: TCheckBox
            Left = 7
            Top = 2
            Width = 72
            Height = 20
            Caption = #26174#31034#34880#26465
            TabOrder = 0
            OnClick = ShowRedHPLableClick
          end
          object ShowBlueMpLable: TCheckBox
            Left = 7
            Top = 20
            Width = 71
            Height = 20
            Caption = #26174#31034#34013#26465
            TabOrder = 5
            OnClick = ShowBlueMpLableClick
          end
          object ShowHPNumber: TCheckBox
            Left = 7
            Top = 39
            Width = 72
            Height = 20
            Caption = #25968#23383#26174#34880
            TabOrder = 8
            OnClick = ShowHPNumberClick
          end
          object MoveSlow: TCheckBox
            Left = 85
            Top = 58
            Width = 71
            Height = 20
            Caption = #20813#36127#37325
            TabOrder = 12
            OnClick = MoveSlowClick
          end
          object ParalyCan: TCheckBox
            Left = 7
            Top = 58
            Width = 57
            Height = 20
            Caption = #38450#30707#21270
            TabOrder = 11
            OnClick = ParalyCanClick
          end
          object MagicLock: TCheckBox
            Left = 168
            Top = 77
            Width = 69
            Height = 20
            Caption = #39764#27861#38145#23450
            TabOrder = 16
            OnClick = MagicLockClick
          end
          object AutoMagic: TCheckBox
            Left = 7
            Top = 77
            Width = 72
            Height = 20
            Caption = #33258#21160#32451#21151
            TabOrder = 14
            OnClick = AutoMagicClick
          end
          object MoveRedShow: TCheckBox
            Left = 85
            Top = 77
            Width = 71
            Height = 20
            Caption = #21435#34880#26174#31034
            TabOrder = 15
            OnClick = MoveRedShowClick
          end
          object ShowAllName: TCheckBox
            Left = 85
            Top = 39
            Width = 71
            Height = 20
            Caption = #26174#31034#20840#21517
            TabOrder = 9
            OnClick = ShowAllNameClick
          end
          object ShowName: TCheckBox
            Left = 85
            Top = 20
            Width = 71
            Height = 20
            Caption = #20154#21517#26174#31034
            TabOrder = 6
            OnClick = ShowNameClick
          end
          object ShowGroupMember: TCheckBox
            Left = 85
            Top = 2
            Width = 71
            Height = 20
            Caption = #26174#31034#38431#21592
            TabOrder = 1
            OnClick = ShowGroupMemberClick
          end
          object ShowAllItem: TCheckBox
            Left = 168
            Top = 2
            Width = 69
            Height = 20
            Caption = #26174#31034#29289#21697
            TabOrder = 2
            OnClick = ShowAllItemClick
          end
          object AutoPuckUpItem: TCheckBox
            Left = 168
            Top = 20
            Width = 69
            Height = 20
            Caption = #33258#21160#25441#29289
            TabOrder = 7
            OnClick = AutoPuckUpItemClick
          end
          object ForceNotViewFog: TCheckBox
            Left = 168
            Top = 39
            Width = 69
            Height = 20
            Caption = #20813#34593#28891
            TabOrder = 10
            OnClick = ForceNotViewFogClick
          end
          object GroupBox77: TGroupBox
            Left = 245
            Top = 2
            Width = 140
            Height = 105
            Caption = #21152#36895#25511#21046
            TabOrder = 3
            object Label183: TLabel
              Left = 9
              Top = 21
              Width = 54
              Height = 12
              Caption = #31227#21160#21152#36895':'
            end
            object Label184: TLabel
              Left = 9
              Top = 46
              Width = 54
              Height = 12
              Caption = #25915#20987#21152#36895':'
            end
            object Label185: TLabel
              Left = 9
              Top = 69
              Width = 54
              Height = 12
              Caption = #39764#27861#21152#36895':'
            end
            object Label186: TLabel
              Left = 112
              Top = 20
              Width = 12
              Height = 12
              Caption = #26684
            end
            object Label187: TLabel
              Left = 112
              Top = 44
              Width = 12
              Height = 12
              Caption = #26684
            end
            object Label188: TLabel
              Left = 112
              Top = 68
              Width = 12
              Height = 12
              Caption = #26684
            end
            object EditMoveTime: TSpinEdit
              Left = 70
              Top = 17
              Width = 37
              Height = 21
              EditorEnabled = False
              MaxValue = 10
              MinValue = 0
              TabOrder = 0
              Value = 0
              OnChange = EditMoveTimeChange
            end
            object EditHitTime: TSpinEdit
              Left = 70
              Top = 41
              Width = 37
              Height = 21
              EditorEnabled = False
              MaxValue = 10
              MinValue = 0
              TabOrder = 1
              Value = 0
              OnChange = EditHitTimeChange
            end
            object EditSpellTime: TSpinEdit
              Left = 70
              Top = 65
              Width = 37
              Height = 21
              EditorEnabled = False
              MaxValue = 10
              MinValue = 0
              TabOrder = 2
              Value = 0
              OnChange = EditSpellTimeChange
            end
          end
          object CanStartRun: TCheckBox
            Left = 168
            Top = 58
            Width = 69
            Height = 20
            Caption = #20813#21161#36305
            TabOrder = 13
            OnClick = CanStartRunClick
          end
          object GroupBox79: TGroupBox
            Left = 392
            Top = 2
            Width = 114
            Height = 105
            Caption = #20869#25346#36873#39033
            TabOrder = 4
            object RadioJasonWg: TRadioButton
              Left = 12
              Top = 21
              Width = 98
              Height = 17
              Caption = #26187#21319#20869#25346
              TabOrder = 0
              OnClick = RadioJasonWgClick
            end
            object RadioSdoWg: TRadioButton
              Left = 12
              Top = 47
              Width = 93
              Height = 17
              Caption = #30427#22823#20869#25346
              TabOrder = 1
              OnClick = RadioSdoWgClick
            end
            object RadioNotWg: TRadioButton
              Left = 13
              Top = 74
              Width = 98
              Height = 17
              Caption = #26080#20869#25346
              TabOrder = 2
              OnClick = RadioNotWgClick
            end
          end
        end
        object TabSheet12: TTabSheet
          Caption = #35774#32622#20108
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object GroupBox80: TGroupBox
            Left = 8
            Top = 10
            Width = 225
            Height = 71
            Caption = #26102#38388#25511#21046
            TabOrder = 0
            object Label153: TLabel
              Left = 8
              Top = 20
              Width = 102
              Height = 12
              Caption = #33521#38596#21917#33647#26102#38388#38388#38548':'
            end
            object Label154: TLabel
              Left = 188
              Top = 20
              Width = 24
              Height = 12
              Caption = #27627#31186
            end
            object Label155: TLabel
              Left = 188
              Top = 44
              Width = 24
              Height = 12
              Caption = #27627#31186
            end
            object Label156: TLabel
              Left = 8
              Top = 44
              Width = 102
              Height = 12
              Caption = #33258#21160#25441#29289#26102#38388#38388#38548':'
            end
            object EditHeroEatingTime: TSpinEdit
              Left = 112
              Top = 17
              Width = 73
              Height = 21
              Hint = #33521#38596#33258#21160#21917#33647#26102#38388#38388#38548#65292#24314#35758#20540#65306' >500 '
              EditorEnabled = False
              Increment = 100
              MaxValue = 10000
              MinValue = 0
              TabOrder = 0
              Value = 0
              OnChange = EditHeroEatingTimeChange
            end
            object EditAutoPuckUpItemTime: TSpinEdit
              Left = 112
              Top = 41
              Width = 73
              Height = 21
              Hint = #33258#21160#25441#29289#26102#38388#38388#38548#65292#24314#35758#20540#65306' >500 '
              EditorEnabled = False
              Increment = 100
              MaxValue = 10000
              MinValue = 0
              TabOrder = 1
              Value = 0
              OnChange = EditAutoPuckUpItemTimeChange
            end
          end
          object GroupBox81: TGroupBox
            Left = 8
            Top = 90
            Width = 225
            Height = 55
            Caption = #21830#19994#29256#30331#24405#22120#23553#21464#36895#36873#39033
            TabOrder = 1
            object Label160: TLabel
              Left = 8
              Top = 24
              Width = 96
              Height = 12
              Caption = #26368#22823#20801#35768#21152#36895#35774#32622
            end
            object EditAspeederTime: TSpinEdit
              Left = 112
              Top = 21
              Width = 73
              Height = 21
              Hint = #20801#35768#21464#36895#22120#26368#24555#21152#36895#35774#32622#65292#25968#20540#36234#23567#65292#20801#35768#30340#36895#24230#36234#24555#12290#24314#35758#20540#65306'950('#23553#21464#36895#35774#32622')'
              EditorEnabled = False
              Increment = 10
              MaxValue = 1000
              MinValue = 0
              TabOrder = 0
              Value = 0
              OnChange = EditAspeederTimeChange
            end
          end
        end
      end
      object ButtonWgSave: TButton
        Left = 462
        Top = 192
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonWgSaveClick
      end
    end
  end
end
