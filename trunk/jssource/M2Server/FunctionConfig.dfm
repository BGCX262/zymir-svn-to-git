object frmFunctionConfig: TfrmFunctionConfig
  Left = 294
  Top = 118
  ActiveControl = MagicPageControl
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #21151#33021#35774#32622
  ClientHeight = 400
  ClientWidth = 468
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
  object Label14: TLabel
    Left = 19
    Top = 379
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
  object FunctionConfigControl: TPageControl
    Left = 7
    Top = 5
    Width = 459
    Height = 368
    ActivePage = TabSheet1
    MultiLine = True
    TabOrder = 0
    OnChanging = FunctionConfigControlChanging
    object TabSheetGeneral: TTabSheet
      Caption = #22522#26412#21151#33021
      ImageIndex = 3
      object GroupBox7: TGroupBox
        Left = 10
        Top = 177
        Width = 145
        Height = 119
        Caption = #33021#37327#25511#21046
        TabOrder = 2
        object CheckBoxHungerSystem: TCheckBox
          Left = 8
          Top = 13
          Width = 130
          Height = 21
          Hint = #21551#29992#27492#21151#33021#21518#65292#20154#29289#24517#38656#23450#26102#21507#39135#29289#20197#20445#25345#33021#37327#65292#22914#26524#38271#26102#38388#26410#21507#39135#29289#65292#20154#29289#23558#34987#39295#27515#12290
          Caption = #21551#29992#33021#37327#25511#21046#31995#32479
          TabOrder = 0
          OnClick = CheckBoxHungerSystemClick
        end
        object GroupBoxHunger: TGroupBox
          Left = 8
          Top = 40
          Width = 129
          Height = 71
          Caption = #33021#37327#19981#22815#26102
          TabOrder = 1
          object CheckBoxHungerDecPower: TCheckBox
            Left = 10
            Top = 40
            Width = 105
            Height = 21
            Hint = #20154#29289#30340#25915#20987#21147#65292#19982#20154#29289#30340#33021#37327#30456#20851#65292#33021#37327#19981#22815#26102#20154#29289#30340#25915#20987#21147#23558#38543#20043#19979#38477#12290
            Caption = #33258#21160#20943#25915#20987#21150
            TabOrder = 1
            OnClick = CheckBoxHungerDecPowerClick
          end
          object CheckBoxHungerDecHP: TCheckBox
            Left = 10
            Top = 20
            Width = 111
            Height = 21
            Hint = #24403#20154#29289#38271#26102#38388#27809#21507#39135#29289#21518#33021#37327#38477#21040'0'#21518#65292#23558#24320#22987#33258#21160#20943#23569'HP'#20540#65292#38477#21040'0'#21518#65292#20154#29289#27515#20129#12290
            Caption = #33258#21160#20943'HP'
            TabOrder = 0
            OnClick = CheckBoxHungerDecHPClick
          end
        end
      end
      object ButtonGeneralSave: TButton
        Left = 381
        Top = 259
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonGeneralSaveClick
      end
      object GroupBox34: TGroupBox
        Left = 10
        Top = 7
        Width = 145
        Height = 162
        Caption = #21517#23383#26174#31034#39068#33394
        TabOrder = 0
        object Label85: TLabel
          Left = 9
          Top = 16
          Width = 54
          Height = 12
          Caption = #25915#20987#29366#24577':'
        end
        object LabelPKFlagNameColor: TLabel
          Left = 114
          Top = 14
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label87: TLabel
          Left = 9
          Top = 41
          Width = 54
          Height = 12
          Caption = #40644#21517#29366#24577':'
        end
        object LabelPKLevel1NameColor: TLabel
          Left = 114
          Top = 39
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label89: TLabel
          Left = 9
          Top = 66
          Width = 54
          Height = 12
          Caption = #32418#21517#29366#24577':'
        end
        object LabelPKLevel2NameColor: TLabel
          Left = 114
          Top = 63
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label91: TLabel
          Left = 9
          Top = 90
          Width = 54
          Height = 12
          Caption = #32852#30431#25112#20105':'
        end
        object LabelAllyAndGuildNameColor: TLabel
          Left = 114
          Top = 87
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label93: TLabel
          Left = 9
          Top = 114
          Width = 54
          Height = 12
          Caption = #25932#23545#25112#20105':'
        end
        object LabelWarGuildNameColor: TLabel
          Left = 114
          Top = 111
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label95: TLabel
          Left = 9
          Top = 138
          Width = 54
          Height = 12
          Caption = #25112#20105#21306#22495':'
        end
        object LabelInFreePKAreaNameColor: TLabel
          Left = 114
          Top = 135
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditPKFlagNameColor: TSpinEdit
          Left = 65
          Top = 13
          Width = 43
          Height = 21
          Hint = #24403#20154#29289#25915#20987#20854#23427#20154#29289#26159#21517#23383#39068#33394#65292#40664#35748#20026'47'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditPKFlagNameColorChange
        end
        object EditPKLevel1NameColor: TSpinEdit
          Left = 65
          Top = 37
          Width = 43
          Height = 21
          Hint = #24403#20154#29289'PK'#20540#36229#36807'100'#26102#21517#31216#39068#33394#65292#40664#35748#20026'251'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditPKLevel1NameColorChange
        end
        object EditPKLevel2NameColor: TSpinEdit
          Left = 65
          Top = 61
          Width = 43
          Height = 21
          Hint = #24403#20154#29289'PK'#20540#36229#36807'200'#26102#21517#31216#39068#33394#65292#40664#35748#20026'249'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditPKLevel2NameColorChange
        end
        object EditAllyAndGuildNameColor: TSpinEdit
          Left = 65
          Top = 85
          Width = 43
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#26102#65292#26412#34892#20250#25110#30431#21451#21517#31216#39068#33394#65292#40664#35748#20026'180'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditAllyAndGuildNameColorChange
        end
        object EditWarGuildNameColor: TSpinEdit
          Left = 65
          Top = 109
          Width = 43
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#26102#65292#25932#23545#20154#29289#21517#31216#39068#33394#65292#40664#35748#20026'69'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditWarGuildNameColorChange
        end
        object EditInFreePKAreaNameColor: TSpinEdit
          Left = 65
          Top = 133
          Width = 43
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#20013#20154#29289#21517#31216#39068#33394#65292#40664#35748#20026'221'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditInFreePKAreaNameColorChange
        end
      end
      object GroupBox63: TGroupBox
        Left = 160
        Top = 7
        Width = 285
        Height = 162
        Caption = #27668#34880#30707'/'#39764#34880#30707#35774#32622
        TabOrder = 1
        object Label147: TLabel
          Left = 9
          Top = 22
          Width = 30
          Height = 12
          Caption = #24403'HP<'
        end
        object Label148: TLabel
          Left = 89
          Top = 22
          Width = 108
          Height = 12
          Caption = '% '#24320#21551#27668#34880#30707','#38388#38548':'
        end
        object Label149: TLabel
          Left = 239
          Top = 22
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label150: TLabel
          Left = 9
          Top = 46
          Width = 132
          Height = 12
          Caption = #22686#21152'HP'#20026#27668#34880#30707#24635#25345#20037#30340
        end
        object Label151: TLabel
          Left = 203
          Top = 46
          Width = 6
          Height = 12
          Caption = '%'
        end
        object Label152: TLabel
          Left = 9
          Top = 94
          Width = 30
          Height = 12
          Caption = #24403'MP<'
        end
        object Label153: TLabel
          Left = 89
          Top = 94
          Width = 108
          Height = 12
          Caption = '% '#24320#21551#39764#34880#30707','#38388#38548':'
        end
        object Label154: TLabel
          Left = 239
          Top = 94
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label155: TLabel
          Left = 207
          Top = 118
          Width = 6
          Height = 12
          Caption = '%'
        end
        object Label156: TLabel
          Left = 9
          Top = 118
          Width = 132
          Height = 12
          Caption = #22686#21152'MP'#20026#39764#34880#30707#24635#25345#20037#30340
        end
        object Label157: TLabel
          Left = 207
          Top = 70
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label158: TLabel
          Left = 9
          Top = 70
          Width = 132
          Height = 12
          Caption = #27599#27425#27668#34880#30707#20943#23569#30340#25345#20037#20540
        end
        object Label159: TLabel
          Left = 9
          Top = 142
          Width = 132
          Height = 12
          Caption = #27599#27425#39764#34880#30707#20943#23569#30340#25345#20037#20540
        end
        object Label160: TLabel
          Left = 207
          Top = 142
          Width = 12
          Height = 12
          Caption = #28857
        end
        object SpinEditHPStoneStartRate: TSpinEdit
          Left = 43
          Top = 18
          Width = 43
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = SpinEditHPStoneStartRateChange
        end
        object SpinEditHPStoneIntervalTime: TSpinEdit
          Left = 197
          Top = 18
          Width = 39
          Height = 21
          EditorEnabled = False
          MaxValue = 100000
          MinValue = 0
          TabOrder = 1
          Value = 1
          OnChange = SpinEditHPStoneIntervalTimeChange
        end
        object SpinEditHPStoneAddRate: TSpinEdit
          Left = 146
          Top = 42
          Width = 55
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = SpinEditHPStoneAddRateChange
        end
        object SpinEditMPStoneStartRate: TSpinEdit
          Left = 43
          Top = 90
          Width = 43
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = SpinEditMPStoneStartRateChange
        end
        object SpinEditMPStoneIntervalTime: TSpinEdit
          Left = 197
          Top = 90
          Width = 39
          Height = 21
          EditorEnabled = False
          MaxValue = 100000
          MinValue = 0
          TabOrder = 5
          Value = 1
          OnChange = SpinEditMPStoneIntervalTimeChange
        end
        object SpinEditMPStoneAddRate: TSpinEdit
          Left = 146
          Top = 114
          Width = 55
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = SpinEditMPStoneAddRateChange
        end
        object SpinEditHPStoneDecDura: TSpinEdit
          Left = 146
          Top = 66
          Width = 55
          Height = 21
          EditorEnabled = False
          MaxValue = 100000
          MinValue = 0
          TabOrder = 3
          Value = 1000
          OnChange = SpinEditHPStoneDecDuraChange
        end
        object SpinEditMPStoneDecDura: TSpinEdit
          Left = 146
          Top = 138
          Width = 55
          Height = 21
          EditorEnabled = False
          MaxValue = 100000
          MinValue = 0
          TabOrder = 7
          Value = 1000
          OnChange = SpinEditMPStoneDecDuraChange
        end
      end
      object GroupBox64: TGroupBox
        Left = 160
        Top = 177
        Width = 214
        Height = 119
        Caption = #21151#33021#35774#32622
        TabOrder = 3
        object CheckBoxCloseShowHp: TCheckBox
          Left = 8
          Top = 13
          Width = 130
          Height = 21
          Hint = #22914#26524#35813#39033#34987#36873#20013#65292#23458#25143#31471#38500#20102#33258#24049#21644#33258#24049#30340#23453#23453#22806#65292#20854#23427#37117#21482#25353#27604#20363#26174#31034#34880#37327#12290
          Caption = #20851#38381#23454#38469#34880#37327#26174#31034
          Enabled = False
          TabOrder = 0
          OnClick = CheckBoxCloseShowHpClick
        end
        object CheckBoxInfinityStorage: TCheckBox
          Left = 8
          Top = 32
          Width = 150
          Height = 21
          Caption = #20801#35768#20351#29992#26080#38480#20179#24211#65292#23481#37327
          TabOrder = 1
          OnClick = CheckBoxInfinityStorageClick
        end
        object EditInfinityStorage: TSpinEdit
          Left = 161
          Top = 32
          Width = 43
          Height = 21
          Hint = #26080#38480#20179#24211#23481#37327#65292#20154#29289#23454#38469#20179#24211#23481#37327'='#26222#36890#20179#24211#23481#37327'+'#26080#38480#20179#24211#23481#37327#12290
          EditorEnabled = False
          MaxValue = 999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditInfinityStorageChange
        end
        object CheckBoxOfflineSaveExp: TCheckBox
          Left = 8
          Top = 51
          Width = 177
          Height = 21
          Hint = #20154#29289#22312#28216#25103#20013#24471#21040#30340#21452#20493#32463#39564#65292#19979#32447#21518#33258#21160#20445#23384#12290#20877#27425#19978#32447#20381#28982#26377#25928#12290
          Caption = #20154#29289#19979#32447#33258#21160#20445#23384#21452#20493#32463#39564
          TabOrder = 3
          OnClick = CheckBoxOfflineSaveExpClick
        end
      end
    end
    object PasswordSheet: TTabSheet
      Caption = #23494#30721#20445#25252
      ImageIndex = 2
      object GroupBox1: TGroupBox
        Left = 10
        Top = 7
        Width = 436
        Height = 193
        TabOrder = 0
        object CheckBoxEnablePasswordLock: TCheckBox
          Left = 10
          Top = 0
          Width = 118
          Height = 16
          Caption = #21551#29992#23494#30721#20445#25252#31995#32479
          TabOrder = 0
          OnClick = CheckBoxEnablePasswordLockClick
        end
        object GroupBox2: TGroupBox
          Left = 10
          Top = 18
          Width = 264
          Height = 167
          Caption = #38145#23450#25511#21046
          TabOrder = 1
          object CheckBoxLockGetBackItem: TCheckBox
            Left = 8
            Top = 14
            Width = 151
            Height = 21
            Caption = #31105#27490#21462#20179#24211#29289#21697
            TabOrder = 0
            OnClick = CheckBoxLockGetBackItemClick
          end
          object GroupBox4: TGroupBox
            Left = 8
            Top = 39
            Width = 249
            Height = 104
            Caption = #30331#24405#38145#23450
            TabOrder = 1
            object CheckBoxLockWalk: TCheckBox
              Left = 8
              Top = 33
              Width = 105
              Height = 16
              Caption = #31105#27490#36208#36335
              TabOrder = 2
              OnClick = CheckBoxLockWalkClick
            end
            object CheckBoxLockRun: TCheckBox
              Left = 8
              Top = 49
              Width = 105
              Height = 16
              Caption = #31105#27490#36305#27493
              TabOrder = 4
              OnClick = CheckBoxLockRunClick
            end
            object CheckBoxLockHit: TCheckBox
              Left = 8
              Top = 65
              Width = 105
              Height = 16
              Caption = #31105#27490#25915#20987
              TabOrder = 6
              OnClick = CheckBoxLockHitClick
            end
            object CheckBoxLockSpell: TCheckBox
              Left = 8
              Top = 81
              Width = 105
              Height = 16
              Caption = #31105#27490#39764#27861
              TabOrder = 8
              OnClick = CheckBoxLockSpellClick
            end
            object CheckBoxLockSendMsg: TCheckBox
              Left = 126
              Top = 33
              Width = 117
              Height = 16
              Caption = #31105#27490#32842#22825
              TabOrder = 3
              OnClick = CheckBoxLockSendMsgClick
            end
            object CheckBoxLockInObMode: TCheckBox
              Left = 126
              Top = 17
              Width = 117
              Height = 16
              Hint = '????????,??????????,????????,?????????????'
              Caption = #38145#23450#26102#20026#38544#36523#27169#24335
              TabOrder = 1
              OnClick = CheckBoxLockInObModeClick
            end
            object CheckBoxLockLogin: TCheckBox
              Left = 8
              Top = 17
              Width = 105
              Height = 16
              Caption = #38145#23450#20154#29289#30331#24405
              TabOrder = 0
              OnClick = CheckBoxLockLoginClick
            end
            object CheckBoxLockUseItem: TCheckBox
              Left = 126
              Top = 81
              Width = 117
              Height = 16
              Caption = #31105#27490#20351#29992#29289#21697
              TabOrder = 9
              OnClick = CheckBoxLockUseItemClick
            end
            object CheckBoxLockDropItem: TCheckBox
              Left = 126
              Top = 65
              Width = 117
              Height = 16
              Caption = #31105#27490#25172#29289#21697
              TabOrder = 7
              OnClick = CheckBoxLockDropItemClick
            end
            object CheckBoxLockDealItem: TCheckBox
              Left = 126
              Top = 49
              Width = 117
              Height = 16
              Caption = #31105#27490#20132#26131#29289#21697
              TabOrder = 5
              OnClick = CheckBoxLockDealItemClick
            end
          end
        end
        object GroupBox3: TGroupBox
          Left = 281
          Top = 18
          Width = 144
          Height = 71
          Caption = #23494#30721#36755#20837#38169#35823#25511#21046
          TabOrder = 2
          object Label1: TLabel
            Left = 8
            Top = 19
            Width = 54
            Height = 12
            Caption = #38169#35823#27425#25968':'
          end
          object EditErrorPasswordCount: TSpinEdit
            Left = 67
            Top = 14
            Width = 53
            Height = 21
            Hint = #22312#24320#38145#26102#36755#20837#23494#30721#65292#22914#26524#36755#20837#38169#35823#36229#36807#25351#23450#27425#25968#65292#21017#38145#23450#23494#30721#65292#24517#38656#37325#26032#30331#24405#19968#27425#25165#21487#20197#20877#27425#36755#20837#23494#30721#12290
            EditorEnabled = False
            MaxValue = 10
            MinValue = 1
            TabOrder = 0
            Value = 10
            OnChange = EditErrorPasswordCountChange
          end
          object CheckBoxErrorCountKick: TCheckBox
            Left = 8
            Top = 42
            Width = 129
            Height = 21
            Caption = #36229#36807#25351#23450#27425#25968#36386#19979#32447
            Enabled = False
            TabOrder = 1
            OnClick = CheckBoxErrorCountKickClick
          end
        end
        object ButtonPasswordLockSave: TButton
          Left = 360
          Top = 160
          Width = 65
          Height = 25
          Caption = #20445#23384'(&S)'
          TabOrder = 3
          OnClick = ButtonPasswordLockSaveClick
        end
      end
    end
    object TabSheet32: TTabSheet
      Caption = #20132#26131#31995#32479
      ImageIndex = 4
      object GroupBox75: TGroupBox
        Left = 10
        Top = 10
        Width = 175
        Height = 95
        Caption = #25670#25674#36873#39033
        TabOrder = 0
        object CheckBoxOpenSelfShop: TCheckBox
          Left = 9
          Top = 17
          Width = 104
          Height = 21
          Hint = #26159#21542#24320#21551#26381#21153#22120#25670#25674#21151#33021#12290
          Caption = #24320#21551#25670#25674#21151#33021
          TabOrder = 0
          OnClick = CheckBoxOpenSelfShopClick
        end
        object CheckBoxSafeZoneShop: TCheckBox
          Left = 9
          Top = 37
          Width = 144
          Height = 21
          Hint = #36873#20013#35813#39033#65292#21482#26377#22312#23433#20840#21306#25165#20801#35768#25670#25674#12290
          Caption = #21482#20801#35768#22312#23433#20840#21306#20869#25670#25674
          TabOrder = 1
          OnClick = CheckBoxSafeZoneShopClick
        end
        object CheckBoxMapShop: TCheckBox
          Left = 9
          Top = 58
          Width = 160
          Height = 21
          Hint = #36873#20013#35813#39033#65292#21482#26377#24403#22320#22270#26631#24535' SHOP '#25171#24320#26102#25165#20801#35768#22312#35813#22320#22270#25670#25674#12290
          Caption = #21482#20801#35768#22312#25351#23450#22320#22270#20869#25670#25674
          TabOrder = 2
          OnClick = CheckBoxMapShopClick
        end
      end
      object GroupBox76: TGroupBox
        Left = 8
        Top = 120
        Width = 177
        Height = 129
        Caption = #23492#21806#31995#32479
        TabOrder = 1
        object Label178: TLabel
          Left = 9
          Top = 23
          Width = 54
          Height = 12
          Caption = #37329#24065#31246#25910':'
        end
        object Label179: TLabel
          Left = 131
          Top = 23
          Width = 24
          Height = 12
          Caption = '/100'
        end
        object Label180: TLabel
          Left = 9
          Top = 47
          Width = 54
          Height = 12
          Caption = #20803#23453#31246#25910':'
        end
        object Label181: TLabel
          Left = 131
          Top = 47
          Width = 24
          Height = 12
          Caption = '/100'
        end
        object EditSellOffGoldTaxRate: TSpinEdit
          Left = 72
          Top = 19
          Width = 57
          Height = 21
          Hint = #24403#29609#23478#36890#36807#37329#24065#20132#26131#25104#21151#21518#65292#25910#21462#30340#31246#25910#12290
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = EditSellOffGoldTaxRateChange
        end
        object EditSellOffGameGoldTaxRate: TSpinEdit
          Left = 72
          Top = 43
          Width = 57
          Height = 21
          Hint = #24403#29609#23478#36890#36807#20803#23453#20132#26131#25104#21151#21518#65292#25910#21462#30340#31246#25910#12290
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = EditSellOffGameGoldTaxRateChange
        end
        object GroupBox81: TGroupBox
          Left = 8
          Top = 71
          Width = 161
          Height = 50
          Caption = #20801#35768#23492#21806#25968#37327
          TabOrder = 2
          object Label188: TLabel
            Left = 9
            Top = 22
            Width = 30
            Height = 12
            Caption = #25968#37327':'
          end
          object EditSellOffItemCount: TSpinEdit
            Left = 48
            Top = 18
            Width = 57
            Height = 21
            Hint = #29609#23478#20801#35768#26368#22823#23492#21806#29289#21697#25968#37327#12290
            EditorEnabled = False
            MaxValue = 100
            MinValue = 0
            TabOrder = 0
            Value = 0
            OnChange = EditSellOffItemCountChange
          end
        end
      end
      object ButtonSaveSellOff: TButton
        Left = 368
        Top = 256
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonSaveSellOffClick
      end
    end
    object TabSheet33: TTabSheet
      Caption = #24072#24466#31995#32479
      ImageIndex = 5
      object GroupBox21: TGroupBox
        Left = 10
        Top = 7
        Width = 163
        Height = 155
        Caption = #24466#24351#20986#24072
        TabOrder = 0
        object GroupBox22: TGroupBox
          Left = 9
          Top = 17
          Width = 144
          Height = 49
          Caption = #20986#24072#31561#32423':'
          TabOrder = 0
          object Label29: TLabel
            Left = 10
            Top = 23
            Width = 54
            Height = 12
            Caption = #20986#24072#31561#32423':'
          end
          object EditMasterOKLevel: TSpinEdit
            Left = 72
            Top = 19
            Width = 48
            Height = 21
            Hint = #20986#24072#31561#32423#35774#32622#65292#20154#29289#22312#25308#24072#21518#65292#21040#25351#23450#31561#32423#21518#23558#33258#21160#20986#24072#12290
            MaxValue = 65535
            MinValue = 1
            TabOrder = 0
            Value = 10
            OnChange = EditMasterOKLevelChange
          end
        end
        object GroupBox23: TGroupBox
          Left = 9
          Top = 74
          Width = 144
          Height = 73
          Caption = #24072#29238#25152#24471
          TabOrder = 1
          object Label30: TLabel
            Left = 10
            Top = 23
            Width = 54
            Height = 12
            Caption = #22768#26395#28857#25968':'
          end
          object Label31: TLabel
            Left = 10
            Top = 49
            Width = 54
            Height = 12
            Caption = #20998#37197#28857#25968':'
          end
          object EditMasterOKCreditPoint: TSpinEdit
            Left = 72
            Top = 19
            Width = 48
            Height = 21
            Hint = #24466#24351#20986#24072#21518#65292#24072#29238#24471#21040#30340#22768#26395#28857#25968#12290
            MaxValue = 100
            MinValue = 0
            TabOrder = 0
            Value = 10
            OnChange = EditMasterOKCreditPointChange
          end
          object EditMasterOKBonusPoint: TSpinEdit
            Left = 72
            Top = 45
            Width = 48
            Height = 21
            Hint = #24466#24351#20986#24072#21518#65292#24072#29238#24471#21040#30340#20998#37197#28857#25968#12290
            MaxValue = 1000
            MinValue = 0
            TabOrder = 1
            Value = 10
            OnChange = EditMasterOKBonusPointChange
          end
        end
      end
      object ButtonMasterSave: TButton
        Left = 194
        Top = 137
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonMasterSaveClick
      end
    end
    object TabSheet38: TTabSheet
      Caption = #36716#29983#31995#32479
      ImageIndex = 9
      object GroupBox29: TGroupBox
        Left = 10
        Top = 10
        Width = 115
        Height = 261
        Caption = #33258#21160#21464#33394
        TabOrder = 0
        object Label56: TLabel
          Left = 13
          Top = 19
          Width = 18
          Height = 12
          Caption = #19968':'
        end
        object LabelReNewNameColor1: TLabel
          Left = 88
          Top = 16
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label58: TLabel
          Left = 13
          Top = 44
          Width = 18
          Height = 12
          Caption = #20108':'
        end
        object LabelReNewNameColor2: TLabel
          Left = 88
          Top = 41
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label60: TLabel
          Left = 13
          Top = 68
          Width = 18
          Height = 12
          Caption = #19977':'
        end
        object LabelReNewNameColor3: TLabel
          Left = 88
          Top = 65
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label62: TLabel
          Left = 13
          Top = 91
          Width = 18
          Height = 12
          Caption = #22235':'
        end
        object LabelReNewNameColor4: TLabel
          Left = 88
          Top = 88
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label64: TLabel
          Left = 13
          Top = 115
          Width = 18
          Height = 12
          Caption = #20116':'
        end
        object LabelReNewNameColor5: TLabel
          Left = 88
          Top = 113
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label66: TLabel
          Left = 13
          Top = 140
          Width = 18
          Height = 12
          Caption = #20845':'
        end
        object LabelReNewNameColor6: TLabel
          Left = 88
          Top = 136
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label68: TLabel
          Left = 13
          Top = 163
          Width = 18
          Height = 12
          Caption = #19971':'
        end
        object LabelReNewNameColor7: TLabel
          Left = 88
          Top = 159
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label70: TLabel
          Left = 13
          Top = 187
          Width = 18
          Height = 12
          Caption = #20843':'
        end
        object LabelReNewNameColor8: TLabel
          Left = 88
          Top = 183
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label72: TLabel
          Left = 13
          Top = 212
          Width = 18
          Height = 12
          Caption = #20061':'
        end
        object LabelReNewNameColor9: TLabel
          Left = 88
          Top = 208
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label74: TLabel
          Left = 13
          Top = 238
          Width = 18
          Height = 12
          Caption = #21313':'
        end
        object LabelReNewNameColor10: TLabel
          Left = 88
          Top = 232
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditReNewNameColor1: TSpinEdit
          Left = 41
          Top = 15
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditReNewNameColor1Change
        end
        object EditReNewNameColor2: TSpinEdit
          Left = 41
          Top = 39
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditReNewNameColor2Change
        end
        object EditReNewNameColor3: TSpinEdit
          Left = 41
          Top = 63
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditReNewNameColor3Change
        end
        object EditReNewNameColor4: TSpinEdit
          Left = 41
          Top = 86
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditReNewNameColor4Change
        end
        object EditReNewNameColor5: TSpinEdit
          Left = 41
          Top = 110
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditReNewNameColor5Change
        end
        object EditReNewNameColor6: TSpinEdit
          Left = 41
          Top = 134
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditReNewNameColor6Change
        end
        object EditReNewNameColor7: TSpinEdit
          Left = 41
          Top = 158
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditReNewNameColor7Change
        end
        object EditReNewNameColor8: TSpinEdit
          Left = 41
          Top = 182
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditReNewNameColor8Change
        end
        object EditReNewNameColor9: TSpinEdit
          Left = 41
          Top = 207
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditReNewNameColor9Change
        end
        object EditReNewNameColor10: TSpinEdit
          Left = 41
          Top = 232
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 9
          Value = 100
          OnChange = EditReNewNameColor10Change
        end
      end
      object ButtonReNewLevelSave: TButton
        Left = 184
        Top = 246
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 3
        OnClick = ButtonReNewLevelSaveClick
      end
      object GroupBox30: TGroupBox
        Left = 133
        Top = 10
        Width = 116
        Height = 67
        Caption = #21517#23383#21464#33394
        TabOrder = 1
        object Label57: TLabel
          Left = 10
          Top = 41
          Width = 30
          Height = 12
          Caption = #38388#38548':'
        end
        object Label59: TLabel
          Left = 93
          Top = 43
          Width = 12
          Height = 12
          Caption = #31186
        end
        object EditReNewNameColorTime: TSpinEdit
          Left = 44
          Top = 37
          Width = 46
          Height = 21
          Hint = #33258#21160#21464#33394#26102#38388#38388#38548
          EditorEnabled = False
          MaxValue = 10
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditReNewNameColorTimeChange
        end
        object CheckBoxReNewChangeColor: TCheckBox
          Left = 9
          Top = 16
          Width = 94
          Height = 16
          Hint = #25171#24320#35813#21151#33021#21518#65292#36716#29983#30340#20154#29289#21517#31216#39068#33394#20250#33258#21160#21464#25442
          Caption = #33258#21160#21464#33394
          TabOrder = 0
          OnClick = CheckBoxReNewChangeColorClick
        end
      end
      object GroupBox33: TGroupBox
        Left = 133
        Top = 84
        Width = 116
        Height = 44
        Caption = #36716#29983#25511#21046
        TabOrder = 2
        object CheckBoxReNewLevelClearExp: TCheckBox
          Left = 9
          Top = 16
          Width = 96
          Height = 21
          Hint = #36716#29983#26159#21542#28165#38500#24050#26377#30340#32463#39564#20540
          Caption = #28165#38500#24050#26377#32463#39564
          TabOrder = 0
          OnClick = CheckBoxReNewLevelClearExpClick
        end
      end
    end
    object TabSheet39: TTabSheet
      Caption = #23453#23453#21319#32423
      ImageIndex = 10
      object ButtonMonUpgradeSave: TButton
        Left = 309
        Top = 223
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonMonUpgradeSaveClick
      end
      object GroupBox32: TGroupBox
        Left = 10
        Top = 10
        Width = 114
        Height = 238
        Caption = #31561#32423#39068#33394
        TabOrder = 0
        object Label65: TLabel
          Left = 13
          Top = 19
          Width = 18
          Height = 12
          Caption = #19968':'
        end
        object LabelMonUpgradeColor1: TLabel
          Left = 88
          Top = 16
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label67: TLabel
          Left = 13
          Top = 44
          Width = 18
          Height = 12
          Caption = #20108':'
        end
        object LabelMonUpgradeColor2: TLabel
          Left = 88
          Top = 40
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label69: TLabel
          Left = 13
          Top = 69
          Width = 18
          Height = 12
          Caption = #19977':'
        end
        object LabelMonUpgradeColor3: TLabel
          Left = 88
          Top = 65
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label71: TLabel
          Left = 13
          Top = 92
          Width = 18
          Height = 12
          Caption = #22235':'
        end
        object LabelMonUpgradeColor4: TLabel
          Left = 88
          Top = 89
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label73: TLabel
          Left = 13
          Top = 115
          Width = 18
          Height = 12
          Caption = #20116':'
        end
        object LabelMonUpgradeColor5: TLabel
          Left = 88
          Top = 113
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label75: TLabel
          Left = 13
          Top = 140
          Width = 18
          Height = 12
          Caption = #20845':'
        end
        object LabelMonUpgradeColor6: TLabel
          Left = 88
          Top = 136
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label76: TLabel
          Left = 13
          Top = 164
          Width = 18
          Height = 12
          Caption = #19971':'
        end
        object LabelMonUpgradeColor7: TLabel
          Left = 88
          Top = 160
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label77: TLabel
          Left = 13
          Top = 188
          Width = 18
          Height = 12
          Caption = #20843':'
        end
        object LabelMonUpgradeColor8: TLabel
          Left = 88
          Top = 185
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label86: TLabel
          Left = 13
          Top = 212
          Width = 18
          Height = 12
          Caption = #20061':'
        end
        object LabelMonUpgradeColor9: TLabel
          Left = 88
          Top = 209
          Width = 10
          Height = 18
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditMonUpgradeColor1: TSpinEdit
          Left = 41
          Top = 15
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMonUpgradeColor1Change
        end
        object EditMonUpgradeColor2: TSpinEdit
          Left = 41
          Top = 39
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMonUpgradeColor2Change
        end
        object EditMonUpgradeColor3: TSpinEdit
          Left = 41
          Top = 63
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMonUpgradeColor3Change
        end
        object EditMonUpgradeColor4: TSpinEdit
          Left = 41
          Top = 86
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMonUpgradeColor4Change
        end
        object EditMonUpgradeColor5: TSpinEdit
          Left = 41
          Top = 110
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditMonUpgradeColor5Change
        end
        object EditMonUpgradeColor6: TSpinEdit
          Left = 41
          Top = 134
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditMonUpgradeColor6Change
        end
        object EditMonUpgradeColor7: TSpinEdit
          Left = 41
          Top = 158
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditMonUpgradeColor7Change
        end
        object EditMonUpgradeColor8: TSpinEdit
          Left = 41
          Top = 182
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditMonUpgradeColor8Change
        end
        object EditMonUpgradeColor9: TSpinEdit
          Left = 41
          Top = 207
          Width = 42
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditMonUpgradeColor9Change
        end
      end
      object GroupBox31: TGroupBox
        Left = 132
        Top = 10
        Width = 99
        Height = 238
        Caption = #21319#32423#26432#24618
        TabOrder = 1
        object Label61: TLabel
          Left = 13
          Top = 19
          Width = 18
          Height = 12
          Caption = #19968':'
        end
        object Label63: TLabel
          Left = 13
          Top = 44
          Width = 18
          Height = 12
          Caption = #20108':'
        end
        object Label78: TLabel
          Left = 13
          Top = 70
          Width = 18
          Height = 12
          Caption = #19977':'
        end
        object Label79: TLabel
          Left = 13
          Top = 93
          Width = 18
          Height = 12
          Caption = #22235':'
        end
        object Label80: TLabel
          Left = 13
          Top = 116
          Width = 18
          Height = 12
          Caption = #20116':'
        end
        object Label81: TLabel
          Left = 13
          Top = 140
          Width = 18
          Height = 12
          Caption = #20845':'
        end
        object Label82: TLabel
          Left = 13
          Top = 165
          Width = 18
          Height = 12
          Caption = #19971':'
        end
        object Label83: TLabel
          Left = 13
          Top = 189
          Width = 18
          Height = 12
          Caption = #20843':'
        end
        object Label84: TLabel
          Left = 13
          Top = 212
          Width = 18
          Height = 12
          Caption = #20061':'
        end
        object EditMonUpgradeKillCount1: TSpinEdit
          Left = 41
          Top = 15
          Width = 48
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMonUpgradeKillCount1Change
        end
        object EditMonUpgradeKillCount2: TSpinEdit
          Left = 41
          Top = 39
          Width = 48
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMonUpgradeKillCount2Change
        end
        object EditMonUpgradeKillCount3: TSpinEdit
          Left = 41
          Top = 63
          Width = 48
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMonUpgradeKillCount3Change
        end
        object EditMonUpgradeKillCount4: TSpinEdit
          Left = 41
          Top = 86
          Width = 48
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMonUpgradeKillCount4Change
        end
        object EditMonUpgradeKillCount5: TSpinEdit
          Left = 41
          Top = 110
          Width = 48
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditMonUpgradeKillCount5Change
        end
        object EditMonUpgradeKillCount6: TSpinEdit
          Left = 41
          Top = 134
          Width = 48
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditMonUpgradeKillCount6Change
        end
        object EditMonUpgradeKillCount7: TSpinEdit
          Left = 41
          Top = 158
          Width = 48
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditMonUpgradeKillCount7Change
        end
        object EditMonUpLvNeedKillBase: TSpinEdit
          Left = 41
          Top = 182
          Width = 48
          Height = 21
          Hint = '????=?? * ?? + ?? + ?? + ????'
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditMonUpLvNeedKillBaseChange
        end
        object EditMonUpLvRate: TSpinEdit
          Left = 41
          Top = 207
          Width = 48
          Height = 21
          Hint = '????=???? * ?? + ?? + ?? + ????'
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditMonUpLvRateChange
        end
      end
      object GroupBox35: TGroupBox
        Left = 239
        Top = 10
        Width = 135
        Height = 118
        Caption = #20027#20154#27515#20129#25511#21046
        TabOrder = 2
        object Label88: TLabel
          Left = 8
          Top = 41
          Width = 54
          Height = 12
          Caption = #21464#24322#26426#29575':'
        end
        object Label90: TLabel
          Left = 8
          Top = 67
          Width = 54
          Height = 12
          Caption = #22686#21152#25915#20987':'
        end
        object Label92: TLabel
          Left = 8
          Top = 92
          Width = 54
          Height = 12
          Caption = #22686#21152#36895#24230':'
        end
        object CheckBoxMasterDieMutiny: TCheckBox
          Left = 8
          Top = 15
          Width = 119
          Height = 21
          Caption = #20027#20154#27515#20129#21518#21464#24322
          TabOrder = 0
          OnClick = CheckBoxMasterDieMutinyClick
        end
        object EditMasterDieMutinyRate: TSpinEdit
          Left = 67
          Top = 36
          Width = 51
          Height = 21
          Hint = #25968#23383#36234#23567#65292#26426#29575#36234#22823
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMasterDieMutinyRateChange
        end
        object EditMasterDieMutinyPower: TSpinEdit
          Left = 67
          Top = 62
          Width = 51
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMasterDieMutinyPowerChange
        end
        object EditMasterDieMutinySpeed: TSpinEdit
          Left = 67
          Top = 87
          Width = 51
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMasterDieMutinySpeedChange
        end
      end
      object GroupBox47: TGroupBox
        Left = 239
        Top = 136
        Width = 135
        Height = 65
        Caption = #19971#24425#23453#23453
        TabOrder = 3
        object Label112: TLabel
          Left = 8
          Top = 41
          Width = 54
          Height = 12
          Caption = #26102#38388#38388#38548':'
        end
        object CheckBoxBBMonAutoChangeColor: TCheckBox
          Left = 8
          Top = 15
          Width = 117
          Height = 21
          Caption = #23453#23453#33258#21160#21464#33394
          TabOrder = 0
          OnClick = CheckBoxBBMonAutoChangeColorClick
        end
        object EditBBMonAutoChangeColorTime: TSpinEdit
          Left = 67
          Top = 36
          Width = 51
          Height = 21
          Hint = #25968#23383#36234#23567#65292#21464#25442#36895#24230#36234#24555#65292#21333#20301'('#31186')'
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 1
          TabOrder = 1
          Value = 100
          OnChange = EditBBMonAutoChangeColorTimeChange
        end
      end
    end
    object MonSaySheet: TTabSheet
      Caption = #24618#29289#35774#32622
      object GroupBox40: TGroupBox
        Left = 10
        Top = 10
        Width = 159
        Height = 47
        Caption = #24618#29289#35828#35805
        TabOrder = 0
        object CheckBoxMonSayMsg: TCheckBox
          Left = 9
          Top = 17
          Width = 104
          Height = 21
          Caption = #24320#21551#24618#29289#35828#35805
          TabOrder = 0
          OnClick = CheckBoxMonSayMsgClick
        end
      end
      object ButtonMonSayMsgSave: TButton
        Left = 381
        Top = 259
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonMonSayMsgSaveClick
      end
      object GroupBox65: TGroupBox
        Left = 10
        Top = 66
        Width = 159
        Height = 79
        Caption = #31561#32423#26174#31034
        TabOrder = 1
        object Label134: TLabel
          Left = 8
          Top = 47
          Width = 30
          Height = 12
          Caption = #20869#23481':'
        end
        object CheckBoxMonShowLevel: TCheckBox
          Left = 9
          Top = 17
          Width = 120
          Height = 21
          Hint = #26159#21542#26174#31034#24618#29289#31561#32423#12290
          Caption = #24320#21551#24618#29289#31561#32423#26174#31034
          TabOrder = 0
          OnClick = CheckBoxMonShowLevelClick
        end
        object EditMonLevelMsg: TEdit
          Left = 41
          Top = 44
          Width = 82
          Height = 20
          Hint = #26174#31034#24618#29289#31561#32423#20869#23481#12290
          TabOrder = 1
          Text = '(Lv:%d)'
          OnChange = EditMonLevelMsgChange
          OnKeyDown = EditHeroNameKeyDown
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = #25216#33021#39764#27861
      ImageIndex = 1
      object MagicPageControl: TPageControl
        Left = -1
        Top = 4
        Width = 449
        Height = 265
        ActivePage = TabSheet11
        MultiLine = True
        TabOrder = 0
        object TabSheet36: TTabSheet
          Caption = #25216#33021#21442#25968
          ImageIndex = 31
          object GroupBox17: TGroupBox
            Left = 10
            Top = 10
            Width = 151
            Height = 48
            Caption = #39764#27861#25915#20987#33539#22260#38480#21046
            TabOrder = 0
            object Label12: TLabel
              Left = 8
              Top = 21
              Width = 54
              Height = 12
              Caption = #33539#22260#22823#23567':'
            end
            object EditMagicAttackRage: TSpinEdit
              Left = 67
              Top = 17
              Width = 66
              Height = 21
              Hint = #39764#27861#25915#20987#26377#25928#36317#31163#65292#36229#36807#35813#36317#31163#25915#20987#26080#25928
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMagicAttackRageChange
            end
          end
        end
        object TabSheet11: TTabSheet
          Caption = #26222#36890#25216#33021
          ImageIndex = 10
          object PageControl2: TPageControl
            Left = 0
            Top = 0
            Width = 439
            Height = 233
            ActivePage = TabSheet29
            MultiLine = True
            TabOrder = 0
            object TabSheet17: TTabSheet
              Caption = #21050#26432#21073#27861
              object GroupBox10: TGroupBox
                Left = 10
                Top = 62
                Width = 141
                Height = 43
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 1
                object Label4: TLabel
                  Left = 9
                  Top = 19
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label10: TLabel
                  Left = 96
                  Top = 19
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditSwordLongPowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 47
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSwordLongPowerRateChange
                end
              end
              object GroupBox9: TGroupBox
                Left = 10
                Top = 10
                Width = 141
                Height = 43
                Caption = #26080#38480#21050#26432
                TabOrder = 0
                object CheckBoxLimitSwordLong: TCheckBox
                  Left = 9
                  Top = 16
                  Width = 95
                  Height = 21
                  Hint = #25171#24320#27492#21151#33021#21518#65292#23558#26816#26597#38548#20301#26159#21542#26377#35282#33394#23384#22312#65292#20197#31105#27490#20992#20992#21050#26432#12290
                  Caption = #31105#27490#26080#38480#21050#26432
                  TabOrder = 0
                  OnClick = CheckBoxLimitSwordLongClick
                end
              end
            end
            object TabSheet19: TTabSheet
              Caption = #35825#24785#20043#20809
              ImageIndex = 1
              object GroupBox45: TGroupBox
                Left = 136
                Top = 10
                Width = 117
                Height = 44
                Caption = #35825#24785#25968#37327
                TabOrder = 1
                object Label111: TLabel
                  Left = 10
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #25968#37327':'
                end
                object EditTammingCount: TSpinEdit
                  Left = 44
                  Top = 16
                  Width = 64
                  Height = 21
                  Hint = #21487#35825#24785#24618#29289#25968#37327
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditTammingCountChange
                end
              end
              object GroupBox38: TGroupBox
                Left = 10
                Top = 10
                Width = 117
                Height = 44
                Caption = #24618#29289#31561#32423#38480#21046
                TabOrder = 0
                object Label98: TLabel
                  Left = 10
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #31561#32423':'
                end
                object EditMagTammingLevel: TSpinEdit
                  Left = 44
                  Top = 16
                  Width = 64
                  Height = 21
                  Hint = #25351#23450#31561#32423#20197#19979#30340#24618#29289#25165#20250#34987#35825#24785#65292#25351#23450#31561#32423#20197#19978#30340#24618#29289#26080#25928#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTammingLevelChange
                end
              end
              object GroupBox39: TGroupBox
                Left = 10
                Top = 62
                Width = 117
                Height = 73
                Caption = #35825#24785#26426#29575
                TabOrder = 2
                object Label99: TLabel
                  Left = 10
                  Top = 21
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#31561#32423':'
                end
                object Label100: TLabel
                  Left = 10
                  Top = 45
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#34880#37327':'
                end
                object EditMagTammingTargetLevel: TSpinEdit
                  Left = 66
                  Top = 16
                  Width = 42
                  Height = 21
                  Hint = #24618#29289#31561#32423#27604#29575#65292#27492#25968#23383#36234#23567#26426#29575#36234#22823
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTammingTargetLevelChange
                end
                object EditMagTammingHPRate: TSpinEdit
                  Left = 66
                  Top = 41
                  Width = 42
                  Height = 21
                  Hint = #24618#29289#34880#37327#27604#29575#65292#27492#25968#23383#36234#22823#65292#26426#29575#36234#22823#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 1
                  OnChange = EditMagTammingHPRateChange
                end
              end
            end
            object TabSheet18: TTabSheet
              Caption = #28779#22681
              ImageIndex = 2
              object GroupBox46: TGroupBox
                Left = 10
                Top = 10
                Width = 134
                Height = 95
                Caption = #31105#27490#28779#22681
                TabOrder = 0
                object CheckBoxFireCrossInSafeZone: TCheckBox
                  Left = 9
                  Top = 17
                  Width = 121
                  Height = 21
                  Hint = #25171#24320#27492#21151#33021#21518#65292#23433#20840#21306#19981#20801#35768#20351#29992#28779#22681
                  Caption = #23433#20840#21306#31105#27490#28779#22681
                  TabOrder = 0
                  OnClick = CheckBoxFireCrossInSafeZoneClick
                end
                object CheckBoxChangeMapCloseFire: TCheckBox
                  Left = 9
                  Top = 33
                  Width = 121
                  Height = 21
                  Hint = #25171#24320#27492#21151#33021#21518#65292#20154#29289#20999#25442#22320#22270#65292#28779#22681#33258#21160#28040#22833#12290
                  Caption = #20999#25442#22320#22270#31435#26082#28040#22833
                  TabOrder = 1
                  OnClick = CheckBoxChangeMapCloseFireClick
                end
                object CheckBoxPlayDethCloseFire: TCheckBox
                  Left = 9
                  Top = 49
                  Width = 121
                  Height = 21
                  Hint = #25171#24320#27492#21151#33021#21518#65292#20154#29289#27515#20129#28779#22681#33258#21160#28040#22833#12290
                  Caption = #20154#29289#27515#20129#31435#26082#28040#22833
                  TabOrder = 2
                  OnClick = CheckBoxPlayDethCloseFireClick
                end
                object CheckBoxPlayGhostCloseFire: TCheckBox
                  Left = 9
                  Top = 65
                  Width = 121
                  Height = 21
                  Hint = #25171#24320#27492#21151#33021#21518#65292#20154#29289#19979#32447#28779#22681#33258#21160#28040#22833#12290
                  Caption = #20154#29289#19979#32447#31435#26082#28040#22833
                  TabOrder = 3
                  OnClick = CheckBoxPlayGhostCloseFireClick
                end
              end
              object GroupBox82: TGroupBox
                Left = 154
                Top = 10
                Width = 175
                Height = 47
                Caption = #26102#38388#25511#21046
                TabOrder = 1
                object Label191: TLabel
                  Left = 10
                  Top = 21
                  Width = 78
                  Height = 12
                  Caption = #26368#38271#26377#25928#26102#38388':'
                end
                object Label192: TLabel
                  Left = 158
                  Top = 21
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object EditFireCrossMaxTime: TSpinEdit
                  Left = 90
                  Top = 17
                  Width = 63
                  Height = 21
                  Hint = #28779#22681#26368#38271#26377#25928#26102#38388#65292'0'#20026#19981#38480#21046#12290
                  EditorEnabled = False
                  Increment = 10
                  MaxValue = 50000000
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = EditFireCrossMaxTimeChange
                end
              end
            end
            object TabSheet20: TTabSheet
              Caption = #22307#35328#26415
              ImageIndex = 3
              object GroupBox37: TGroupBox
                Left = 10
                Top = 10
                Width = 119
                Height = 46
                Caption = #24618#29289#31561#32423#38480#21046
                TabOrder = 0
                object Label97: TLabel
                  Left = 10
                  Top = 22
                  Width = 30
                  Height = 12
                  Caption = #31561#32423':'
                end
                object EditMagTurnUndeadLevel: TSpinEdit
                  Left = 47
                  Top = 17
                  Width = 63
                  Height = 21
                  Hint = #25351#23450#31561#32423#20197#19979#30340#24618#29289#25165#20250#34987#22307#35328#65292#25351#23450#31561#32423#20197#19978#30340#24618#29289#22307#35328#26080#25928#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTurnUndeadLevelChange
                end
              end
            end
            object TabSheet23: TTabSheet
              Caption = #22320#29425#38647#20809
              ImageIndex = 4
              object GroupBox15: TGroupBox
                Left = 10
                Top = 10
                Width = 119
                Height = 46
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label9: TLabel
                  Left = 10
                  Top = 22
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditElecBlizzardRange: TSpinEdit
                  Left = 47
                  Top = 17
                  Width = 63
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditElecBlizzardRangeChange
                end
              end
            end
            object TabSheet22: TTabSheet
              Caption = #29190#35010#28779#28976
              ImageIndex = 5
              object GroupBox13: TGroupBox
                Left = 10
                Top = 10
                Width = 119
                Height = 46
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label7: TLabel
                  Left = 10
                  Top = 22
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditFireBoomRage: TSpinEdit
                  Left = 47
                  Top = 17
                  Width = 63
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditFireBoomRageChange
                end
              end
            end
            object TabSheet21: TTabSheet
              Caption = #20912#21638#21742
              ImageIndex = 6
              object GroupBox14: TGroupBox
                Left = 10
                Top = 10
                Width = 119
                Height = 46
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label8: TLabel
                  Left = 10
                  Top = 22
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditSnowWindRange: TSpinEdit
                  Left = 47
                  Top = 17
                  Width = 63
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditSnowWindRangeChange
                end
              end
            end
            object TabSheet24: TTabSheet
              Caption = #26045#27602#26415
              ImageIndex = 7
              object GroupBox16: TGroupBox
                Left = 10
                Top = 10
                Width = 119
                Height = 46
                Caption = #27602#33647#38477#28857
                TabOrder = 0
                object Label11: TLabel
                  Left = 10
                  Top = 22
                  Width = 30
                  Height = 12
                  Caption = #28857#25968':'
                end
                object EditAmyOunsulPoint: TSpinEdit
                  Left = 47
                  Top = 17
                  Width = 63
                  Height = 21
                  Hint = #20013#27602#21518#25351#23450#26102#38388#20869#38477#28857#25968#65292#23454#38469#28857#25968#36319#25216#33021#31561#32423#21450#26412#36523#36947#26415#39640#20302#26377#20851#65292#27492#21442#25968#21482#26159#35843#20854#20013#31639#27861#21442#25968#65292#27492#25968#23383#36234#23567#65292#28857#25968#36234#22823#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditAmyOunsulPointChange
                end
              end
            end
            object TabSheet6: TTabSheet
              Caption = #21484#21796#39635#39621
              ImageIndex = 8
              object GroupBox6: TGroupBox
                Left = 142
                Top = 3
                Width = 289
                Height = 168
                Caption = #39640#32423#35774#32622
                TabOrder = 1
                object GridBoneFamm: TStringGrid
                  Left = 10
                  Top = 20
                  Width = 265
                  Height = 141
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
              object GroupBox5: TGroupBox
                Left = 6
                Top = 3
                Width = 131
                Height = 168
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label2: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label3: TLabel
                  Left = 8
                  Top = 60
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object EditBoneFammName: TEdit
                  Left = 8
                  Top = 34
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216
                  TabOrder = 0
                  OnChange = EditBoneFammNameChange
                end
                object EditBoneFammCount: TSpinEdit
                  Left = 61
                  Top = 57
                  Width = 52
                  Height = 21
                  Hint = #35774#32622#26368#22823#21487#21484#21796#25968#37327
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditBoneFammCountChange
                end
              end
            end
            object TabSheet3: TTabSheet
              Caption = #21484#21796#31070#20861
              ImageIndex = 9
              object GroupBox12: TGroupBox
                Left = 142
                Top = 3
                Width = 289
                Height = 168
                Caption = #39640#32423#35774#32622
                TabOrder = 1
                object GridDogz: TStringGrid
                  Left = 10
                  Top = 20
                  Width = 265
                  Height = 141
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
              object GroupBox11: TGroupBox
                Left = 6
                Top = 3
                Width = 131
                Height = 168
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label5: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label6: TLabel
                  Left = 8
                  Top = 60
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object EditDogzName: TEdit
                  Left = 8
                  Top = 34
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216
                  TabOrder = 0
                  OnChange = EditDogzNameChange
                end
                object EditDogzCount: TSpinEdit
                  Left = 61
                  Top = 57
                  Width = 52
                  Height = 21
                  Hint = #35774#32622#26368#22823#21487#21484#21796#25968#37327
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditDogzCountChange
                end
              end
            end
            object TabSheet27: TTabSheet
              Caption = #28872#28779#21073#27861
              ImageIndex = 15
              object GroupBox70: TGroupBox
                Left = 6
                Top = 10
                Width = 155
                Height = 46
                Caption = #26102#38388#25511#21046
                TabOrder = 0
                object Label169: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #20351#29992#38388#38548':'
                end
                object Label170: TLabel
                  Left = 118
                  Top = 20
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object EditFireHitSkillTime: TSpinEdit
                  Left = 66
                  Top = 16
                  Width = 46
                  Height = 21
                  Hint = #27599#27425#20351#29992#28872#28779#21073#26415#26102#38388#38388#38548#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditFireHitSkillTimeChange
                end
              end
            end
            object TabSheet4: TTabSheet
              Caption = #28779#28976#20912
              ImageIndex = 10
              object GroupBox41: TGroupBox
                Left = 10
                Top = 10
                Width = 143
                Height = 91
                Caption = #35282#33394#31561#32423#26426#29575#35774#32622
                TabOrder = 0
                object Label101: TLabel
                  Left = 9
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #30456#24046#26426#29575':'
                end
                object Label102: TLabel
                  Left = 10
                  Top = 45
                  Width = 54
                  Height = 12
                  Caption = #30456#24046#38480#21046':'
                end
                object EditMabMabeHitRandRate: TSpinEdit
                  Left = 67
                  Top = 16
                  Width = 62
                  Height = 21
                  Hint = #25915#20987#34987#25915#20987#21452#26041#30456#24046#31561#32423#21629#20013#26426#29575#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitRandRateChange
                end
                object EditMabMabeHitMinLvLimit: TSpinEdit
                  Left = 67
                  Top = 41
                  Width = 62
                  Height = 21
                  Hint = #25915#20987#34987#25915#20987#21452#26041#30456#24046#31561#32423#21629#20013#26426#29575#65292#26368#23567#38480#21046#65292#25968#23383#36234#23567#26426#29575#36234#20302#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditMabMabeHitMinLvLimitChange
                end
              end
              object GroupBox43: TGroupBox
                Left = 160
                Top = 10
                Width = 143
                Height = 51
                Caption = #40635#30201#26102#38388#21442#25968#20493#29575
                TabOrder = 1
                object Label104: TLabel
                  Left = 9
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #21629#20013#26426#29575':'
                end
                object EditMabMabeHitMabeTimeRate: TSpinEdit
                  Left = 67
                  Top = 16
                  Width = 62
                  Height = 21
                  Hint = #40635#30201#26102#38388#38271#24230#20493#29575#65292#22522#25968#19982#35282#33394#30340#39764#27861#26377#20851#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitMabeTimeRateChange
                end
              end
              object GroupBox42: TGroupBox
                Left = 10
                Top = 110
                Width = 143
                Height = 51
                Caption = #40635#30201#21629#20013#26426#29575
                TabOrder = 2
                object Label103: TLabel
                  Left = 9
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #21629#20013#26426#29575':'
                end
                object EditMabMabeHitSucessRate: TSpinEdit
                  Left = 67
                  Top = 16
                  Width = 62
                  Height = 21
                  Hint = #25915#20987#40635#30201#26426#29575#65292#26368#23567#38480#21046#65292#25968#23383#36234#23567#26426#29575#36234#20302#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitSucessRateChange
                end
              end
            end
            object TabSheet25: TTabSheet
              Caption = #29422#23376#21564
              ImageIndex = 11
              object GroupBox48: TGroupBox
                Left = 10
                Top = 10
                Width = 119
                Height = 79
                Caption = #25915#20987#35774#32622
                TabOrder = 0
                object CheckBoxGroupMbAttackPlayObject: TCheckBox
                  Left = 9
                  Top = 16
                  Width = 100
                  Height = 21
                  Hint = #25171#24320#27492#21151#33021#21518#65292#23601#21487#20197#40635#30201#20154#29289#12290
                  Caption = #20801#35768#40635#30201#20154#29289
                  Checked = True
                  State = cbChecked
                  TabOrder = 0
                  OnClick = CheckBoxGroupMbAttackPlayObjectClick
                end
                object CheckBoxGroupMbAttackMonObject: TCheckBox
                  Left = 9
                  Top = 35
                  Width = 100
                  Height = 21
                  Hint = #25171#24320#27492#21151#33021#21518#65292#23601#21487#20197#40635#30201#20154#29289#23453#23453#12290
                  Caption = #20801#35768#40635#30201#23453#23453
                  TabOrder = 1
                  OnClick = CheckBoxGroupMbAttackMonObjectClick
                end
                object CheckBoxGroupMbAttackHeroObject: TCheckBox
                  Left = 9
                  Top = 54
                  Width = 100
                  Height = 21
                  Hint = #25171#24320#27492#21151#33021#21518#65292#23601#21487#20197#40635#30201#20154#29289#33521#38596#12290
                  Caption = #20801#35768#40635#30201#33521#38596
                  TabOrder = 2
                  OnClick = CheckBoxGroupMbAttackHeroObjectClick
                end
              end
            end
            object TabSheet26: TTabSheet
              Caption = #24443#22320#38025
              ImageIndex = 14
              object GroupBox69: TGroupBox
                Left = 8
                Top = 10
                Width = 143
                Height = 55
                Caption = #26102#38388#25511#21046
                TabOrder = 0
                object Label167: TLabel
                  Left = 8
                  Top = 22
                  Width = 54
                  Height = 12
                  Caption = #20351#29992#38388#38548':'
                end
                object Label168: TLabel
                  Left = 118
                  Top = 22
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object EditMagicDeDingTime: TSpinEdit
                  Left = 66
                  Top = 18
                  Width = 46
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMagicDeDingTimeChange
                end
              end
            end
            object TabSheet15: TTabSheet
              Caption = #25810#40857#25163
              ImageIndex = 12
              object GroupBox66: TGroupBox
                Left = 10
                Top = 10
                Width = 119
                Height = 79
                Caption = #25915#20987#35774#32622
                TabOrder = 0
                object CheckBoxFastenAttackPlayObject: TCheckBox
                  Left = 9
                  Top = 16
                  Width = 100
                  Height = 21
                  Caption = #20801#35768#25235#33719#20154#29289
                  TabOrder = 0
                  OnClick = CheckBoxFastenAttackPlayObjectClick
                end
                object CheckBoxFastenAttackSlaveObject: TCheckBox
                  Left = 9
                  Top = 35
                  Width = 100
                  Height = 21
                  Caption = #20801#35768#25235#33719#23453#23453
                  TabOrder = 1
                  OnClick = CheckBoxFastenAttackSlaveObjectClick
                end
                object CheckBoxFastenAttackHeroObject: TCheckBox
                  Left = 9
                  Top = 54
                  Width = 100
                  Height = 21
                  Caption = #20801#35768#25235#33719#33521#38596
                  TabOrder = 2
                  OnClick = CheckBoxFastenAttackHeroObjectClick
                end
              end
            end
            object TabSheet16: TTabSheet
              Caption = #21484#21796#26376#28789
              ImageIndex = 13
              object GroupBox67: TGroupBox
                Left = 142
                Top = 3
                Width = 289
                Height = 168
                Caption = #39640#32423#35774#32622
                TabOrder = 1
                object GridFairy: TStringGrid
                  Left = 10
                  Top = 20
                  Width = 265
                  Height = 141
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
              object GroupBox68: TGroupBox
                Left = 6
                Top = 3
                Width = 131
                Height = 168
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label161: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label162: TLabel
                  Left = 8
                  Top = 60
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object Label163: TLabel
                  Left = 8
                  Top = 115
                  Width = 54
                  Height = 12
                  Caption = #37325#20987#20960#29575':'
                end
                object Label164: TLabel
                  Left = 116
                  Top = 115
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object Label165: TLabel
                  Left = 116
                  Top = 138
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object Label166: TLabel
                  Left = 8
                  Top = 138
                  Width = 54
                  Height = 12
                  Caption = #25915#20987#20493#25968':'
                end
                object EditFairyName: TEdit
                  Left = 8
                  Top = 34
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216
                  TabOrder = 0
                  OnChange = EditDogzNameChange
                end
                object EditFairyCount: TSpinEdit
                  Left = 61
                  Top = 57
                  Width = 52
                  Height = 21
                  Hint = #35774#32622#26368#22823#21487#21484#21796#25968#37327
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditFairyCountChange
                end
                object EditFairyDuntRate: TSpinEdit
                  Left = 61
                  Top = 112
                  Width = 52
                  Height = 21
                  Hint = #20986#29616#37325#20987#20960#29575#12290
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 2
                  Value = 10
                  OnChange = EditFairyDuntRateChange
                end
                object EditFairyAttackRate: TSpinEdit
                  Left = 61
                  Top = 135
                  Width = 52
                  Height = 21
                  Hint = #37325#20987#25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 3
                  Value = 10
                  OnChange = EditFairyAttackRateChange
                end
              end
            end
            object TabSheet28: TTabSheet
              Caption = #40857#24433#21073#27861
              ImageIndex = 16
              object GroupBox72: TGroupBox
                Left = 6
                Top = 90
                Width = 155
                Height = 46
                Caption = #33539#22260
                TabOrder = 1
                object Label173: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #25915#20987#33539#22260':'
                end
                object EditTwinHitSkillRange: TSpinEdit
                  Left = 66
                  Top = 16
                  Width = 46
                  Height = 21
                  Hint = #25915#20987#26377#25928#33539#22260#35774#23450#65292#40664#35748#20026'3'
                  EditorEnabled = False
                  MaxValue = 10
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditTwinHitSkillRangeChange
                end
              end
              object GroupBox83: TGroupBox
                Left = 6
                Top = 10
                Width = 155
                Height = 71
                Caption = #24594#27668#25511#21046
                TabOrder = 0
                object Label193: TLabel
                  Left = 8
                  Top = 20
                  Width = 66
                  Height = 12
                  Caption = #26368#22823#24594#27668#20540':'
                end
                object Label194: TLabel
                  Left = 8
                  Top = 44
                  Width = 66
                  Height = 12
                  Caption = #27599#31186#22686#21152#20540':'
                end
                object EditTwinHitMaxCount: TSpinEdit
                  Left = 74
                  Top = 16
                  Width = 71
                  Height = 21
                  Increment = 10
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditTwinHitMaxCountChange
                end
                object EditTwinHitCount: TSpinEdit
                  Left = 74
                  Top = 40
                  Width = 71
                  Height = 21
                  Increment = 10
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditTwinHitCountChange
                end
              end
            end
            object TabSheet29: TTabSheet
              Caption = #20998#36523#26415
              ImageIndex = 17
              object GroupBox77: TGroupBox
                Left = 8
                Top = 8
                Width = 177
                Height = 69
                Caption = #21517#31216#35774#32622
                TabOrder = 0
                object Label182: TLabel
                  Left = 8
                  Top = 21
                  Width = 54
                  Height = 12
                  Caption = #20998#36523#21069#32512':'
                end
                object EditPlayCloneName: TEdit
                  Left = 64
                  Top = 18
                  Width = 105
                  Height = 20
                  TabOrder = 0
                  OnChange = EditDogzNameChange
                end
                object CheckBoxCloneShowMaster: TCheckBox
                  Left = 8
                  Top = 43
                  Width = 129
                  Height = 17
                  Hint = #24320#21551#21518#65292#20998#36523#30340#20154#29289#21517#31216#36319#20027#20154#30340#19968#33268#12290
                  Caption = #26174#31034#20027#20154#19968#26679#21517#31216
                  TabOrder = 1
                  OnClick = CheckBoxCloneShowMasterClick
                end
              end
              object GroupBox80: TGroupBox
                Left = 10
                Top = 82
                Width = 175
                Height = 71
                Caption = #26102#38388#25511#21046
                TabOrder = 2
                object Label184: TLabel
                  Left = 10
                  Top = 21
                  Width = 54
                  Height = 12
                  Caption = #26377#25928#26102#38388':'
                end
                object Label187: TLabel
                  Left = 134
                  Top = 21
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label189: TLabel
                  Left = 134
                  Top = 45
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label190: TLabel
                  Left = 10
                  Top = 45
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#38388#38548':'
                end
                object EditPlayCloneTime: TSpinEdit
                  Left = 66
                  Top = 17
                  Width = 63
                  Height = 21
                  Hint = #20998#36523#26377#25928#26102#38388#25511#21046#65292#35774#32622#20026'0'#21017#30452#21040#20154#29289#19979#32447#25165#28040#22833#12290
                  EditorEnabled = False
                  Increment = 10
                  MaxValue = 50000000
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = EditPlayCloneTimeChange
                end
                object EditCallCloneTime: TSpinEdit
                  Left = 66
                  Top = 41
                  Width = 63
                  Height = 21
                  Hint = #21484#21796#20998#36523#26102#38388#38388#38548#65292#24314#35758#20540'60'#31186#12290#35831#27880#24847#65306#38388#38548#26102#38388#26159#20174#20998#36523#28040#22833#21518#24320#22987#35745#26102#12290
                  EditorEnabled = False
                  Increment = 10
                  MaxValue = 50000000
                  MinValue = 0
                  TabOrder = 1
                  Value = 0
                  OnChange = EditCallCloneTimeChange
                end
              end
              object GroupBox89: TGroupBox
                Left = 192
                Top = 8
                Width = 185
                Height = 69
                Caption = #21484#21796#35774#32622
                TabOrder = 1
                object CheckBoxCloneMakeSlave: TCheckBox
                  Left = 10
                  Top = 17
                  Width = 129
                  Height = 17
                  Hint = #24320#21551#21518#65292#20801#35768#36947#22763#20998#36523#20351#29992#21484#21796#25216#33021#65292#22914#65306#21484#21796#31070#20861
                  Caption = #20801#35768#20998#36523#21484#21796#23646#19979
                  TabOrder = 0
                  OnClick = CheckBoxCloneMakeSlaveClick
                end
              end
            end
            object TabSheet30: TTabSheet
              Caption = #24320#22825#26025
              ImageIndex = 18
              object GroupBox73: TGroupBox
                Left = 6
                Top = 10
                Width = 155
                Height = 46
                Caption = #26102#38388#25511#21046
                TabOrder = 0
                object Label174: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #20351#29992#38388#38548':'
                end
                object Label175: TLabel
                  Left = 118
                  Top = 20
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object EditLongSwordTime: TSpinEdit
                  Left = 66
                  Top = 16
                  Width = 46
                  Height = 21
                  Hint = #27599#27425#20351#29992#29378#39118#26025#26102#38388#38388#38548#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditLongSwordTimeChange
                end
              end
              object GroupBox74: TGroupBox
                Left = 6
                Top = 66
                Width = 155
                Height = 46
                Caption = #26426#29575
                TabOrder = 1
                object Label176: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #37325#20987#26426#29575':'
                end
                object Label177: TLabel
                  Left = 118
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditLongSwordRate: TSpinEdit
                  Left = 66
                  Top = 16
                  Width = 46
                  Height = 21
                  Hint = #20986#29616#22235#26684#25915#20987#26426#29575
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditLongSwordRateChange
                end
              end
            end
            object TabSheet31: TTabSheet
              Caption = #26080#26497#30495#27668
              ImageIndex = 19
              object GroupBox78: TGroupBox
                Left = 6
                Top = 10
                Width = 155
                Height = 46
                Caption = #26102#38388#25511#21046
                TabOrder = 0
                object Label183: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #26102#38388':'
                end
                object EditUenhancerTime: TSpinEdit
                  Left = 66
                  Top = 16
                  Width = 46
                  Height = 21
                  Hint = #26080#26497#30495#27668#26377#25928#26102#38388#25511#21046#65292#35813#20540#20026#20013#35843#21442#25968#65292#25968#20540#36234#22823#65292#26102#38388#36234#20037#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditUenhancerTimeChange
                end
              end
              object GroupBox79: TGroupBox
                Left = 6
                Top = 66
                Width = 155
                Height = 46
                Caption = #28857#25968#20493#25968
                TabOrder = 1
                object Label185: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label186: TLabel
                  Left = 118
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditUenhancerRate: TSpinEdit
                  Left = 66
                  Top = 16
                  Width = 46
                  Height = 21
                  Hint = #35774#32622#28857#25968#20493#25968#65292#35813#20540#38500#20197'100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  Increment = 10
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditUenhancerRateChange
                end
              end
            end
            object TabSheet41: TTabSheet
              Caption = #25252#20307#31070#30462
              ImageIndex = 20
              object GroupBox71: TGroupBox
                Left = 8
                Top = 8
                Width = 143
                Height = 85
                Caption = #26102#38388#25511#21046
                TabOrder = 0
                object Label171: TLabel
                  Left = 8
                  Top = 21
                  Width = 54
                  Height = 12
                  Caption = #26368#38271#26102#38388':'
                end
                object Label172: TLabel
                  Left = 118
                  Top = 21
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label199: TLabel
                  Left = 8
                  Top = 45
                  Width = 54
                  Height = 12
                  Caption = #20351#29992#38388#38548':'
                end
                object Label200: TLabel
                  Left = 118
                  Top = 45
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object EditShieldTime: TSpinEdit
                  Left = 66
                  Top = 17
                  Width = 46
                  Height = 21
                  Hint = #25252#30462#24320#21551#21518#65292#22312#27809#26377#34987#20987#30772#30340#24773#20917#19979#65292#26368#38271#20445#25345#22810#38271#26102#38388#65292'0'#20026#19981#38480#21046#12290
                  EditorEnabled = False
                  MaxValue = 9999999
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = EditShieldTimeChange
                end
                object EditShieldTick: TSpinEdit
                  Left = 66
                  Top = 41
                  Width = 46
                  Height = 21
                  Hint = #27599#27425#20351#29992#25252#30462#38388#38548#65292#38388#38548#35745#26102#26159#20174#25252#30462#28040#22833#21518#24320#22987#12290'0'#20026#19981#38480#21046#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 0
                  TabOrder = 1
                  Value = 10
                  OnChange = EditShieldTickChange
                end
              end
              object GroupBox84: TGroupBox
                Left = 160
                Top = 8
                Width = 143
                Height = 85
                Caption = #20445#25252#26102#25928#26524
                TabOrder = 1
                object RadioShieldDrok: TRadioButton
                  Left = 7
                  Top = 37
                  Width = 75
                  Height = 17
                  Caption = #30462#29260#25928#26524
                  TabOrder = 0
                  OnClick = RadioShieldDrokClick
                end
                object RadioShieldEgg: TRadioButton
                  Left = 7
                  Top = 58
                  Width = 75
                  Height = 21
                  Caption = #24425#34507#25928#26524
                  TabOrder = 1
                  OnClick = RadioShieldEggClick
                end
                object RadioShieldNil: TRadioButton
                  Left = 7
                  Top = 15
                  Width = 75
                  Height = 17
                  Caption = #26080#25928#26524
                  TabOrder = 2
                  OnClick = RadioShieldNilClick
                end
              end
              object GroupBox85: TGroupBox
                Left = 8
                Top = 101
                Width = 143
                Height = 63
                Caption = #25252#20307#20943#25915#20987#30334#20998#27604
                TabOrder = 3
                object Label195: TLabel
                  Left = 8
                  Top = 22
                  Width = 30
                  Height = 12
                  Caption = #27604#20363':'
                end
                object Label196: TLabel
                  Left = 94
                  Top = 22
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditShieldAttackRate: TSpinEdit
                  Left = 42
                  Top = 18
                  Width = 46
                  Height = 21
                  Hint = #20154#29289#21463#25915#20987#26102#65292#30452#25509#20943#23569#25351#23450#27604#29575#30340#25915#20987#65292#22914#26524#35813#20540#20026'10'#65292#21017#20943#23569#30334#20998#20043#21313#30340#25915#20987'('#26377#19968#23450#26426#29575#20250#36798#21040#26368#39640#30334#20998#20043#20108#21313')'#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = EditShieldAttackRateChange
                end
              end
              object GroupBox86: TGroupBox
                Left = 160
                Top = 101
                Width = 143
                Height = 63
                Caption = #30462#34987#20987#30772#26426#29575
                TabOrder = 4
                object Label197: TLabel
                  Left = 8
                  Top = 22
                  Width = 30
                  Height = 12
                  Caption = #26426#29575':'
                end
                object EditShieldSmashRate: TSpinEdit
                  Left = 42
                  Top = 18
                  Width = 46
                  Height = 21
                  Hint = #24403#20154#29289#21463#25915#20987#26102#65292#30462#34987#20987#30772#26426#29575#65292#25968#20540#36234#22823#26426#29575#36234#23567#12290#35813#25968#20540'+'#25216#33021#31561#32423#20026#24635#26426#29575#12290#24314#35758#20540' 3'
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = EditShieldSmashRateChange
                end
              end
              object GroupBox87: TGroupBox
                Left = 312
                Top = 8
                Width = 113
                Height = 85
                Caption = #25915#20987#24517#30772#36873#39033
                TabOrder = 2
                object CheckBoxShieldErgum: TCheckBox
                  Left = 8
                  Top = 30
                  Width = 97
                  Height = 17
                  Hint = #36873#20013#35813#39033#65292#24403#20154#29289#20351#29992#35813#39033#25216#33021#25915#20987#26377#25252#30462#20154#29289#26102#65292#34987#25915#20987#20154#29289#25252#30462#30334#20998#30334#20987#30772#12290#21482#26377#38548#20301#21050#26432#25165#26377#25928#12290
                  Caption = #21050#26432#24517#30772
                  TabOrder = 1
                  OnClick = CheckBoxShieldErgumClick
                end
                object CheckBoxShieldYEDO: TCheckBox
                  Left = 8
                  Top = 13
                  Width = 97
                  Height = 17
                  Hint = #36873#20013#35813#39033#65292#24403#20154#29289#20351#29992#35813#39033#25216#33021#25915#20987#26377#25252#30462#20154#29289#26102#65292#34987#25915#20987#20154#29289#25252#30462#30334#20998#30334#20987#30772#12290
                  Caption = #25915#26432#24517#30772
                  TabOrder = 0
                  OnClick = CheckBoxShieldYEDOClick
                end
                object CheckBoxShieldFire: TCheckBox
                  Left = 8
                  Top = 46
                  Width = 97
                  Height = 17
                  Hint = #36873#20013#35813#39033#65292#24403#20154#29289#20351#29992#35813#39033#25216#33021#25915#20987#26377#25252#30462#20154#29289#26102#65292#34987#25915#20987#20154#29289#25252#30462#30334#20998#30334#20987#30772#12290
                  Caption = #28872#28779#24517#30772
                  TabOrder = 2
                  OnClick = CheckBoxShieldFireClick
                end
                object CheckBoxCheckBoxShieldLong: TCheckBox
                  Left = 8
                  Top = 62
                  Width = 97
                  Height = 17
                  Hint = #36873#20013#35813#39033#65292#24403#20154#29289#20351#29992#35813#39033#25216#33021#25915#20987#26377#25252#30462#20154#29289#26102#65292#34987#25915#20987#20154#29289#25252#30462#30334#20998#30334#20987#30772#12290
                  Caption = #24320#22825#24517#30772
                  TabOrder = 3
                  OnClick = CheckBoxCheckBoxShieldLongClick
                end
              end
              object GroupBox95: TGroupBox
                Left = 312
                Top = 101
                Width = 113
                Height = 63
                Caption = #33258#21160#24320#25252#30462
                TabOrder = 5
                object CheckBoxAutoOpenShield: TCheckBox
                  Left = 5
                  Top = 17
                  Width = 97
                  Height = 17
                  Hint = #36873#20013#35813#39033#65292#23558#33258#21160#24320#21551#25252#20307#31070#30462
                  Caption = #33258#21160#24320#21551#31070#30462
                  TabOrder = 0
                  OnClick = CheckBoxAutoOpenShieldClick
                end
                object CheckBoxShieldShowEffect: TCheckBox
                  Left = 5
                  Top = 36
                  Width = 97
                  Height = 17
                  Hint = #26159#21542#26174#31034#25252#30462#24320#21551#21644#20851#38381#25928#26524'?'#24314#35758#20851#38381','#22823#22411'PK'#26102#23558#24433#21709#36895#24230'..'
                  Caption = #26159#21542#26174#31034#25928#26524
                  TabOrder = 1
                  OnClick = CheckBoxShieldShowEffectClick
                end
              end
            end
            object TabSheet45: TTabSheet
              Caption = #28781#22825#28779
              ImageIndex = 21
              object GroupBox96: TGroupBox
                Left = 8
                Top = 8
                Width = 121
                Height = 49
                Caption = #20943'MP'#20540
                TabOrder = 0
                object CheckBoxPlayObjectReduceMP: TCheckBox
                  Left = 16
                  Top = 16
                  Width = 97
                  Height = 17
                  Caption = #20987#20013#20943'MP'#20540
                  TabOrder = 0
                  OnClick = CheckBoxPlayObjectReduceMPClick
                end
              end
            end
          end
        end
        object TabSheet46: TTabSheet
          Caption = #26368#26032#25216#33021
          ImageIndex = 3
          object PageControl3: TPageControl
            Left = 1
            Top = 3
            Width = 436
            Height = 231
            ActivePage = TabSheet51
            TabOrder = 0
            object TabSheet44: TTabSheet
              Caption = #36880#26085#21073#27861
              object GroupBox90: TGroupBox
                Left = 6
                Top = 10
                Width = 155
                Height = 46
                Caption = #26102#38388#25511#21046
                TabOrder = 0
                object Label207: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #20351#29992#38388#38548':'
                end
                object Label208: TLabel
                  Left = 118
                  Top = 20
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object seLongFireHitSkillTime: TSpinEdit
                  Left = 66
                  Top = 16
                  Width = 46
                  Height = 21
                  Hint = #27599#27425#20351#29992#36880#26085#21073#27861#26102#38388#38388#38548#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = seLongFireHitSkillTimeChange
                end
              end
              object GroupBox91: TGroupBox
                Left = 6
                Top = 64
                Width = 155
                Height = 46
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 1
                object Label209: TLabel
                  Left = 8
                  Top = 21
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label210: TLabel
                  Left = 107
                  Top = 21
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object seEditLongFireHitPower: TSpinEdit
                  Left = 44
                  Top = 17
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#20540#22823#23567#38500#20197'100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = seEditLongFireHitPowerChange
                end
              end
            end
            object TabSheet47: TTabSheet
              Caption = #27969#26143#28779#38632
              ImageIndex = 1
              object GroupBox93: TGroupBox
                Left = 4
                Top = 7
                Width = 155
                Height = 46
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label213: TLabel
                  Left = 8
                  Top = 21
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label214: TLabel
                  Left = 107
                  Top = 21
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object seEditMeteorRainPower: TSpinEdit
                  Left = 44
                  Top = 16
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#20540#22823#23567#38500#20197'100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = seEditMeteorRainPowerChange
                end
              end
              object GroupBox97: TGroupBox
                Left = 4
                Top = 65
                Width = 155
                Height = 46
                Caption = #20351#29992#38388#38548
                TabOrder = 1
                object Label216: TLabel
                  Left = 8
                  Top = 21
                  Width = 30
                  Height = 12
                  Caption = #26102#38388':'
                end
                object Label217: TLabel
                  Left = 109
                  Top = 21
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object seMeteorRainTime: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 52
                  Height = 21
                  Hint = #27969#26143#28779#30005#21378#38632#20351#29992#38388#38548
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 5
                  OnChange = seMeteorRainTimeChange
                end
              end
            end
            object TabSheet43: TTabSheet
              Caption = #22124#34880#26415
              ImageIndex = 2
              object GroupBox92: TGroupBox
                Left = 8
                Top = 68
                Width = 155
                Height = 46
                Caption = #21560#34880#25511#21046
                TabOrder = 0
                object Label211: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #21560#34880#27604#29575':'
                end
                object Label212: TLabel
                  Left = 118
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object seEditVampirePower: TSpinEdit
                  Left = 66
                  Top = 16
                  Width = 46
                  Height = 21
                  Hint = #35813#25968#20540#38500#20197'100'#20026#23454#38469#27604#29575','#20363#22914':'#32473#23545#26041#36896#25104'100'#28857#20260#23475','#21017#21560#21462' 100 * '#23454#38469#21560#34880#27604#29575
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = seEditVampirePowerChange
                end
              end
              object GroupBox94: TGroupBox
                Left = 8
                Top = 10
                Width = 155
                Height = 46
                Caption = #21560#34880#20960#29575
                TabOrder = 1
                object Label215: TLabel
                  Left = 8
                  Top = 21
                  Width = 30
                  Height = 12
                  Cursor = crDrag
                  Caption = #20960#29575':'
                end
                object seEditVampireHpRate: TSpinEdit
                  Left = 44
                  Top = 17
                  Width = 53
                  Height = 21
                  Hint = #22312#25915#20987#26102#21560#21462#23545#26041'HP'#30340#20960#29575','#25968#20540#36234#23567#20960#29575#36234#22823'.'
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = seEditVampireHpRateChange
                end
              end
              object grp1: TGroupBox
                Left = 3
                Top = 126
                Width = 158
                Height = 61
                Caption = #25915#20987#25511#21046
                TabOrder = 2
                object Label218: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #25915#20987#27604#29575':'
                end
                object Label219: TLabel
                  Left = 118
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object seEditAttackPower: TSpinEdit
                  Left = 66
                  Top = 16
                  Width = 46
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = seEditAttackPowerChange
                end
              end
            end
            object TabSheet48: TTabSheet
              Caption = #20094#22372#22823#25386#31227
              ImageIndex = 3
              object GroupBox98: TGroupBox
                Left = 6
                Top = 10
                Width = 155
                Height = 46
                Caption = #26102#38388#25511#21046
                TabOrder = 0
                object Label220: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #20351#29992#38388#38548':'
                end
                object Label221: TLabel
                  Left = 118
                  Top = 20
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object sEditSkill82Time: TSpinEdit
                  Left = 65
                  Top = 16
                  Width = 46
                  Height = 21
                  Hint = #27599#27425#20351#29992#20094#22372#22823#25386#31227#26102#38388#38388#38548#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = sEditSkill82TimeChange
                end
              end
              object GroupBox99: TGroupBox
                Left = 5
                Top = 62
                Width = 155
                Height = 46
                Caption = #25104#21151#25511#21046
                TabOrder = 1
                object Label222: TLabel
                  Left = 14
                  Top = 20
                  Width = 42
                  Height = 12
                  Caption = #25104#21151#29575':'
                end
                object sEditskill82Rate: TSpinEdit
                  Left = 66
                  Top = 15
                  Width = 46
                  Height = 21
                  Hint = #25968#20540#36234#23567#20960#29575#36234#22823'.'
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = sEditskill82RateChange
                end
              end
            end
            object TabSheet51: TTabSheet
              Caption = #22235#32423#30462
              ImageIndex = 4
              object GroupBox112: TGroupBox
                Left = 3
                Top = 6
                Width = 137
                Height = 55
                Caption = #25269#28040#20260#23475
                TabOrder = 0
                object Label269: TLabel
                  Left = 8
                  Top = 21
                  Width = 30
                  Height = 12
                  Caption = #20260#23475':'
                end
                object Label270: TLabel
                  Left = 107
                  Top = 21
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object SeSkill57DecDamage: TSpinEdit
                  Left = 44
                  Top = 17
                  Width = 53
                  Height = 21
                  Hint = #24320#21551#22235#32423#30462#21518#25269#28040#20260#23475#30340#30334#20998#27604#20540#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SeSkill57DecDamageChange
                end
              end
            end
          end
        end
        object TabSheet5: TTabSheet
          Caption = #21512#20987#25216#33021
          ImageIndex = 13
          object PageControl1: TPageControl
            Left = 0
            Top = 0
            Width = 439
            Height = 234
            ActivePage = TabSheet14
            TabOrder = 0
            object TabSheet7: TTabSheet
              Caption = #22522#26412#35774#32622
              object GroupBox55: TGroupBox
                Left = 6
                Top = 3
                Width = 155
                Height = 46
                Caption = #24320#25918#33521#38596#21512#20987
                TabOrder = 0
                object CheckBoxAllowJointAttack: TCheckBox
                  Left = 8
                  Top = 18
                  Width = 141
                  Height = 17
                  Hint = #25171#24320#20123#21151#33021#65292#23558#20801#35768#33521#38596#20351#29992#21512#20987#25216#33021
                  Caption = #20801#35768#20351#29992#33521#38596#21512#20987
                  TabOrder = 0
                  OnClick = CheckBoxAllowJointAttackClick
                end
              end
              object GroupBox56: TGroupBox
                Left = 6
                Top = 59
                Width = 155
                Height = 51
                Caption = #34917#20805#24594#27668#20540#20493#25968
                TabOrder = 1
                object Label132: TLabel
                  Left = 8
                  Top = 23
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label133: TLabel
                  Left = 90
                  Top = 23
                  Width = 18
                  Height = 12
                  Caption = '/10'
                end
                object SpinEditEnergyStepUpRate: TSpinEdit
                  Left = 44
                  Top = 19
                  Width = 40
                  Height = 21
                  Hint = #34917#20805#24594#27668#20540#65292#25968#20540#38500#20197'10'#20026#23454#38469#20493#25968
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditEnergyStepUpRateChange
                end
              end
            end
            object TabSheet8: TTabSheet
              Caption = #30772#39746#26025
              ImageIndex = 1
              object GroupBox57: TGroupBox
                Left = 6
                Top = 3
                Width = 155
                Height = 46
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label135: TLabel
                  Left = 8
                  Top = 21
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label136: TLabel
                  Left = 107
                  Top = 21
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object SpinEditSkillWWPowerRate: TSpinEdit
                  Left = 44
                  Top = 17
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#20540#22823#23567#38500#20197'100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditSkillWWPowerRateChange
                end
              end
            end
            object TabSheet9: TTabSheet
              Caption = #21128#26143#26025
              ImageIndex = 2
              object GroupBox58: TGroupBox
                Left = 6
                Top = 3
                Width = 155
                Height = 46
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label137: TLabel
                  Left = 8
                  Top = 21
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label138: TLabel
                  Left = 107
                  Top = 21
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object SpinEditSkillTWPowerRate: TSpinEdit
                  Left = 44
                  Top = 17
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#20540#22823#23567#38500#20197'100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditSkillTWPowerRateChange
                end
              end
            end
            object TabSheet10: TTabSheet
              Caption = #38647#38662#19968#20987
              ImageIndex = 3
              object GroupBox59: TGroupBox
                Left = 6
                Top = 3
                Width = 155
                Height = 46
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label139: TLabel
                  Left = 8
                  Top = 21
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label140: TLabel
                  Left = 107
                  Top = 21
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object SpinEditSkillZWPowerRate: TSpinEdit
                  Left = 44
                  Top = 17
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#20540#22823#23567#38500#20197'100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditSkillZWPowerRateChange
                end
              end
            end
            object TabSheet12: TTabSheet
              Caption = #22124#39746#27836#27901
              ImageIndex = 4
              object GroupBox60: TGroupBox
                Left = 6
                Top = 3
                Width = 155
                Height = 46
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label141: TLabel
                  Left = 8
                  Top = 21
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label142: TLabel
                  Left = 107
                  Top = 21
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object SpinEditSkillTTPowerRate: TSpinEdit
                  Left = 44
                  Top = 17
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#20540#22823#23567#38500#20197'100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditSkillTTPowerRateChange
                end
              end
            end
            object TabSheet13: TTabSheet
              Caption = #26411#26085#23457#21028
              ImageIndex = 5
              object GroupBox61: TGroupBox
                Left = 6
                Top = 3
                Width = 155
                Height = 46
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label143: TLabel
                  Left = 8
                  Top = 21
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label144: TLabel
                  Left = 107
                  Top = 21
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object SpinEditSkillZTPowerRate: TSpinEdit
                  Left = 44
                  Top = 17
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#20540#22823#23567#38500#20197'100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditSkillZTPowerRateChange
                end
              end
            end
            object TabSheet14: TTabSheet
              Caption = #28779#40857#27668#28976
              ImageIndex = 6
              object GroupBox62: TGroupBox
                Left = 6
                Top = 3
                Width = 155
                Height = 46
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label145: TLabel
                  Left = 8
                  Top = 21
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label146: TLabel
                  Left = 107
                  Top = 21
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object SpinEditSkillZZPowerRate: TSpinEdit
                  Left = 44
                  Top = 17
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#20540#22823#23567#38500#20197'100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditSkillZZPowerRateChange
                end
              end
            end
          end
        end
      end
      object ButtonSkillSave: TButton
        Left = 384
        Top = 274
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonSkillSaveClick
      end
    end
    object TabSheet34: TTabSheet
      Caption = #21319#32423#27494#22120
      ImageIndex = 6
      object GroupBox8: TGroupBox
        Left = 10
        Top = 10
        Width = 162
        Height = 119
        Caption = #22522#26412#35774#32622
        TabOrder = 0
        object Label13: TLabel
          Left = 10
          Top = 17
          Width = 54
          Height = 12
          Caption = #26368#39640#28857#25968':'
        end
        object Label15: TLabel
          Left = 10
          Top = 40
          Width = 54
          Height = 12
          Caption = #25152#38656#36153#29992':'
        end
        object Label16: TLabel
          Left = 10
          Top = 65
          Width = 54
          Height = 12
          Caption = #25152#23646#26102#38388':'
        end
        object Label17: TLabel
          Left = 10
          Top = 89
          Width = 54
          Height = 12
          Caption = #36807#26399#26102#38388':'
        end
        object Label18: TLabel
          Left = 131
          Top = 65
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label19: TLabel
          Left = 131
          Top = 88
          Width = 12
          Height = 12
          Caption = #22825
        end
        object EditUpgradeWeaponMaxPoint: TSpinEdit
          Left = 68
          Top = 12
          Width = 57
          Height = 21
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditUpgradeWeaponMaxPointChange
        end
        object EditUpgradeWeaponPrice: TSpinEdit
          Left = 69
          Top = 36
          Width = 57
          Height = 21
          EditorEnabled = False
          MaxValue = 1000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditUpgradeWeaponPriceChange
        end
        object EditUPgradeWeaponGetBackTime: TSpinEdit
          Left = 69
          Top = 60
          Width = 57
          Height = 21
          EditorEnabled = False
          MaxValue = 36000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditUPgradeWeaponGetBackTimeChange
        end
        object EditClearExpireUpgradeWeaponDays: TSpinEdit
          Left = 69
          Top = 84
          Width = 57
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditClearExpireUpgradeWeaponDaysChange
        end
      end
      object GroupBox18: TGroupBox
        Left = 180
        Top = 10
        Width = 265
        Height = 90
        Caption = #25915#20987#21147#21319#32423
        TabOrder = 1
        object Label20: TLabel
          Left = 9
          Top = 19
          Width = 54
          Height = 12
          Caption = #25104#21151#26426#29575':'
        end
        object Label21: TLabel
          Left = 9
          Top = 42
          Width = 54
          Height = 12
          Caption = #20108#28857#26426#29575':'
        end
        object Label22: TLabel
          Left = 9
          Top = 66
          Width = 54
          Height = 12
          Caption = #19977#28857#26426#29575':'
        end
        object ScrollBarUpgradeWeaponDCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 18
          Hint = #21319#32423#28857#25968#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponDCRateChange
        end
        object EditUpgradeWeaponDCRate: TEdit
          Left = 217
          Top = 16
          Width = 39
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponDCTwoPointRate: TScrollBar
          Left = 64
          Top = 39
          Width = 145
          Height = 18
          Hint = #24471#21040#20108#28857#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponDCTwoPointRateChange
        end
        object EditUpgradeWeaponDCTwoPointRate: TEdit
          Left = 217
          Top = 40
          Width = 39
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponDCThreePointRate: TScrollBar
          Left = 64
          Top = 63
          Width = 145
          Height = 18
          Hint = #24471#21040#19977#28857#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponDCThreePointRateChange
        end
        object EditUpgradeWeaponDCThreePointRate: TEdit
          Left = 217
          Top = 63
          Width = 39
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object GroupBox19: TGroupBox
        Left = 180
        Top = 106
        Width = 265
        Height = 90
        Caption = #36947#26415#21319#32423
        TabOrder = 2
        object Label23: TLabel
          Left = 9
          Top = 19
          Width = 54
          Height = 12
          Caption = #25104#21151#26426#29575':'
        end
        object Label24: TLabel
          Left = 9
          Top = 42
          Width = 54
          Height = 12
          Caption = #20108#28857#26426#29575':'
        end
        object Label25: TLabel
          Left = 9
          Top = 66
          Width = 54
          Height = 12
          Caption = #19977#28857#26426#29575':'
        end
        object ScrollBarUpgradeWeaponSCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 18
          Hint = #21319#32423#28857#25968#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponSCRateChange
        end
        object EditUpgradeWeaponSCRate: TEdit
          Left = 217
          Top = 16
          Width = 39
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponSCTwoPointRate: TScrollBar
          Left = 64
          Top = 39
          Width = 145
          Height = 18
          Hint = #24471#21040#20108#28857#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponSCTwoPointRateChange
        end
        object EditUpgradeWeaponSCTwoPointRate: TEdit
          Left = 217
          Top = 40
          Width = 39
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponSCThreePointRate: TScrollBar
          Left = 64
          Top = 63
          Width = 145
          Height = 18
          Hint = #24471#21040#19977#28857#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponSCThreePointRateChange
        end
        object EditUpgradeWeaponSCThreePointRate: TEdit
          Left = 217
          Top = 63
          Width = 39
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object GroupBox20: TGroupBox
        Left = 180
        Top = 204
        Width = 265
        Height = 90
        Caption = #39764#27861#21319#32423
        TabOrder = 3
        object Label26: TLabel
          Left = 9
          Top = 19
          Width = 54
          Height = 12
          Caption = #25104#21151#26426#29575':'
        end
        object Label27: TLabel
          Left = 9
          Top = 42
          Width = 54
          Height = 12
          Caption = #20108#28857#26426#29575':'
        end
        object Label28: TLabel
          Left = 9
          Top = 66
          Width = 54
          Height = 12
          Caption = #19977#28857#26426#29575':'
        end
        object ScrollBarUpgradeWeaponMCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 18
          Hint = #21319#32423#28857#25968#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponMCRateChange
        end
        object EditUpgradeWeaponMCRate: TEdit
          Left = 217
          Top = 16
          Width = 39
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponMCTwoPointRate: TScrollBar
          Left = 64
          Top = 39
          Width = 145
          Height = 18
          Hint = #24471#21040#20108#28857#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponMCTwoPointRateChange
        end
        object EditUpgradeWeaponMCTwoPointRate: TEdit
          Left = 217
          Top = 40
          Width = 39
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponMCThreePointRate: TScrollBar
          Left = 64
          Top = 63
          Width = 145
          Height = 18
          Hint = #24471#21040#19977#28857#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponMCThreePointRateChange
        end
        object EditUpgradeWeaponMCThreePointRate: TEdit
          Left = 217
          Top = 63
          Width = 39
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object ButtonUpgradeWeaponSave: TButton
        Left = 10
        Top = 269
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonUpgradeWeaponSaveClick
      end
      object ButtonUpgradeWeaponDefaulf: TButton
        Left = 92
        Top = 269
        Width = 65
        Height = 25
        Caption = #40664#35748'(&D)'
        TabOrder = 5
        OnClick = ButtonUpgradeWeaponDefaulfClick
      end
    end
    object TabSheet35: TTabSheet
      Caption = #25366#30719#25511#21046
      ImageIndex = 7
      object GroupBox24: TGroupBox
        Left = 10
        Top = 10
        Width = 279
        Height = 62
        Caption = #24471#21040#30719#30707#26426#29575
        TabOrder = 0
        object Label32: TLabel
          Left = 10
          Top = 19
          Width = 54
          Height = 12
          Caption = #21629#20013#26426#29575':'
        end
        object Label33: TLabel
          Left = 10
          Top = 39
          Width = 54
          Height = 12
          Caption = #25366#30719#26426#29575':'
        end
        object ScrollBarMakeMineHitRate: TScrollBar
          Left = 72
          Top = 17
          Width = 130
          Height = 16
          Hint = #35774#32622#30340#25968#23383#36234#23567#65292#26426#29575#36234#22823
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarMakeMineHitRateChange
        end
        object EditMakeMineHitRate: TEdit
          Left = 212
          Top = 17
          Width = 53
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarMakeMineRate: TScrollBar
          Left = 72
          Top = 38
          Width = 130
          Height = 16
          Hint = #35774#32622#30340#25968#23383#36234#23567#65292#26426#29575#36234#22823
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarMakeMineRateChange
        end
        object EditMakeMineRate: TEdit
          Left = 212
          Top = 38
          Width = 53
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
      end
      object GroupBox25: TGroupBox
        Left = 10
        Top = 78
        Width = 279
        Height = 216
        Caption = #30719#30707#31867#22411#26426#29575
        TabOrder = 2
        object Label34: TLabel
          Left = 10
          Top = 19
          Width = 54
          Height = 12
          Caption = #30719#30707#22240#23376':'
        end
        object Label35: TLabel
          Left = 10
          Top = 40
          Width = 42
          Height = 12
          Caption = #37329#30719#29575':'
        end
        object Label36: TLabel
          Left = 10
          Top = 60
          Width = 42
          Height = 12
          Caption = #38134#30719#29575':'
        end
        object Label37: TLabel
          Left = 10
          Top = 81
          Width = 42
          Height = 12
          Caption = #38081#30719#29575':'
        end
        object Label38: TLabel
          Left = 10
          Top = 102
          Width = 54
          Height = 12
          Caption = #40657#38081#30719#29575':'
        end
        object ScrollBarStoneTypeRate: TScrollBar
          Left = 72
          Top = 17
          Width = 130
          Height = 16
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarStoneTypeRateChange
        end
        object EditStoneTypeRate: TEdit
          Left = 212
          Top = 17
          Width = 53
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarGoldStoneMax: TScrollBar
          Left = 72
          Top = 37
          Width = 130
          Height = 16
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarGoldStoneMaxChange
        end
        object EditGoldStoneMax: TEdit
          Left = 212
          Top = 37
          Width = 53
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarSilverStoneMax: TScrollBar
          Left = 72
          Top = 58
          Width = 130
          Height = 16
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarSilverStoneMaxChange
        end
        object EditSilverStoneMax: TEdit
          Left = 212
          Top = 58
          Width = 53
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarSteelStoneMax: TScrollBar
          Left = 72
          Top = 79
          Width = 130
          Height = 16
          Max = 500
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarSteelStoneMaxChange
        end
        object EditSteelStoneMax: TEdit
          Left = 212
          Top = 79
          Width = 53
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditBlackStoneMax: TEdit
          Left = 212
          Top = 100
          Width = 53
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 9
        end
        object ScrollBarBlackStoneMax: TScrollBar
          Left = 72
          Top = 100
          Width = 130
          Height = 16
          Max = 500
          PageSize = 0
          TabOrder = 8
          OnChange = ScrollBarBlackStoneMaxChange
        end
      end
      object ButtonMakeMineSave: TButton
        Left = 377
        Top = 266
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonMakeMineSaveClick
      end
      object GroupBox26: TGroupBox
        Left = 296
        Top = 10
        Width = 146
        Height = 119
        Caption = #30719#30707#21697#36136
        TabOrder = 1
        object Label39: TLabel
          Left = 8
          Top = 17
          Width = 78
          Height = 12
          Caption = #30719#30707#26368#23567#21697#36136':'
        end
        object Label40: TLabel
          Left = 8
          Top = 42
          Width = 78
          Height = 12
          Caption = #26222#36890#21697#36136#33539#22260':'
        end
        object Label41: TLabel
          Left = 8
          Top = 67
          Width = 66
          Height = 12
          Caption = #39640#21697#36136#26426#29575':'
        end
        object Label42: TLabel
          Left = 8
          Top = 94
          Width = 66
          Height = 12
          Caption = #39640#21697#36136#33539#22260':'
        end
        object EditStoneMinDura: TSpinEdit
          Left = 90
          Top = 12
          Width = 44
          Height = 21
          Hint = #30719#30707#20986#29616#26368#20302#21697#36136#28857#25968
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditStoneMinDuraChange
        end
        object EditStoneGeneralDuraRate: TSpinEdit
          Left = 90
          Top = 37
          Width = 44
          Height = 21
          Hint = #30719#30707#38543#26426#20986#29616#28857#25968#33539#22260
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditStoneGeneralDuraRateChange
        end
        object EditStoneAddDuraRate: TSpinEdit
          Left = 90
          Top = 63
          Width = 44
          Height = 21
          Hint = #30719#30707#20986#29616#39640#21697#36136#28857#25968#26426#29575#65292#39640#21697#36136#37327#25351#21487#36798#21040'20'#25110#20197#19978#30340#28857#25968#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditStoneAddDuraRateChange
        end
        object EditStoneAddDuraMax: TSpinEdit
          Left = 90
          Top = 89
          Width = 44
          Height = 21
          Hint = #39640#21697#36136#30719#30707#38543#26426#20986#29616#21697#36136#28857#25968#33539#22260#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditStoneAddDuraMaxChange
        end
      end
      object ButtonMakeMineDefault: TButton
        Left = 301
        Top = 266
        Width = 65
        Height = 25
        Caption = #40664#35748'(&D)'
        TabOrder = 3
        OnClick = ButtonMakeMineDefaultClick
      end
    end
    object TabSheet42: TTabSheet
      Caption = #31069#31119#27833#25511#21046
      ImageIndex = 12
      object GroupBox44: TGroupBox
        Left = 10
        Top = 10
        Width = 295
        Height = 220
        Caption = #26426#29575#35774#32622
        TabOrder = 0
        object Label105: TLabel
          Left = 10
          Top = 23
          Width = 54
          Height = 12
          Caption = #35781#21650#26426#29575':'
        end
        object Label106: TLabel
          Left = 10
          Top = 48
          Width = 54
          Height = 12
          Caption = #19968#32423#28857#25968':'
        end
        object Label107: TLabel
          Left = 10
          Top = 70
          Width = 54
          Height = 12
          Caption = #20108#32423#28857#25968':'
        end
        object Label108: TLabel
          Left = 10
          Top = 95
          Width = 54
          Height = 12
          Caption = #20108#32423#26426#29575':'
        end
        object Label109: TLabel
          Left = 10
          Top = 120
          Width = 54
          Height = 12
          Caption = #19977#32423#28857#25968':'
        end
        object Label110: TLabel
          Left = 10
          Top = 145
          Width = 54
          Height = 12
          Caption = #19977#32423#26426#29575':'
        end
        object ScrollBarWeaponMakeUnLuckRate: TScrollBar
          Left = 66
          Top = 20
          Width = 161
          Height = 16
          Hint = #20351#29992#31069#31119#27833#35781#21650#26426#29575#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarWeaponMakeUnLuckRateChange
        end
        object EditWeaponMakeUnLuckRate: TEdit
          Left = 236
          Top = 20
          Width = 45
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarWeaponMakeLuckPoint1: TScrollBar
          Left = 66
          Top = 45
          Width = 161
          Height = 16
          Hint = #24403#27494#22120#30340#24184#36816#28857#23567#20110#27492#28857#25968#26102#20351#29992#31119#31119#27833#21017'100%'#25104#21151#12290
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarWeaponMakeLuckPoint1Change
        end
        object EditWeaponMakeLuckPoint1: TEdit
          Left = 236
          Top = 45
          Width = 45
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarWeaponMakeLuckPoint2: TScrollBar
          Left = 66
          Top = 70
          Width = 161
          Height = 16
          Hint = #24403#27494#22120#30340#24184#36816#28857#23567#20110#27492#28857#25968#26102#20351#29992#31069#31119#27833#21017#25353#25351#23450#26426#29575#20915#23450#26159#21542#21152#24184#36816#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarWeaponMakeLuckPoint2Change
        end
        object EditWeaponMakeLuckPoint2: TEdit
          Left = 236
          Top = 70
          Width = 45
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarWeaponMakeLuckPoint2Rate: TScrollBar
          Left = 66
          Top = 95
          Width = 161
          Height = 16
          Hint = #26426#29575#28857#25968#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarWeaponMakeLuckPoint2RateChange
        end
        object EditWeaponMakeLuckPoint2Rate: TEdit
          Left = 236
          Top = 95
          Width = 45
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditWeaponMakeLuckPoint3: TEdit
          Left = 236
          Top = 120
          Width = 45
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 9
        end
        object ScrollBarWeaponMakeLuckPoint3: TScrollBar
          Left = 66
          Top = 120
          Width = 161
          Height = 16
          Hint = #24403#27494#22120#30340#24184#36816#28857#23567#20110#27492#28857#25968#26102#20351#29992#31069#31119#27833#21017#25353#25351#23450#26426#29575#20915#23450#26159#21542#21152#24184#36816#12290
          Max = 500
          PageSize = 0
          TabOrder = 8
          OnChange = ScrollBarWeaponMakeLuckPoint3Change
        end
        object ScrollBarWeaponMakeLuckPoint3Rate: TScrollBar
          Left = 66
          Top = 145
          Width = 161
          Height = 16
          Hint = #26426#29575#28857#25968#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 10
          OnChange = ScrollBarWeaponMakeLuckPoint3RateChange
        end
        object EditWeaponMakeLuckPoint3Rate: TEdit
          Left = 236
          Top = 145
          Width = 45
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 11
        end
      end
      object ButtonWeaponMakeLuckDefault: TButton
        Left = 165
        Top = 242
        Width = 65
        Height = 25
        Caption = #40664#35748'(&D)'
        TabOrder = 1
        OnClick = ButtonWeaponMakeLuckDefaultClick
      end
      object ButtonWeaponMakeLuckSave: TButton
        Left = 240
        Top = 242
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonWeaponMakeLuckSaveClick
      end
    end
    object TabSheet37: TTabSheet
      Caption = #24425#31080#25511#21046
      ImageIndex = 8
      object GroupBox27: TGroupBox
        Left = 10
        Top = 10
        Width = 270
        Height = 211
        Caption = #20013#22870#26426#29575
        TabOrder = 0
        object Label43: TLabel
          Left = 10
          Top = 53
          Width = 42
          Height = 12
          Caption = #19968#31561#22870':'
        end
        object Label44: TLabel
          Left = 10
          Top = 78
          Width = 42
          Height = 12
          Caption = #20108#31561#22870':'
        end
        object Label45: TLabel
          Left = 10
          Top = 100
          Width = 42
          Height = 12
          Caption = #19977#31561#22870':'
        end
        object Label46: TLabel
          Left = 10
          Top = 125
          Width = 42
          Height = 12
          Caption = #22235#31561#22870':'
        end
        object Label47: TLabel
          Left = 10
          Top = 150
          Width = 42
          Height = 12
          Caption = #20116#31561#22870':'
        end
        object Label48: TLabel
          Left = 10
          Top = 175
          Width = 42
          Height = 12
          Caption = #20845#31561#22870':'
        end
        object Label49: TLabel
          Left = 10
          Top = 23
          Width = 30
          Height = 12
          Caption = #22240#23376':'
        end
        object ScrollBarWinLottery1Max: TScrollBar
          Left = 54
          Top = 50
          Width = 127
          Height = 19
          Max = 1000000
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarWinLottery1MaxChange
        end
        object EditWinLottery1Max: TEdit
          Left = 192
          Top = 50
          Width = 67
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarWinLottery2Max: TScrollBar
          Left = 54
          Top = 75
          Width = 127
          Height = 19
          Max = 1000000
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarWinLottery2MaxChange
        end
        object EditWinLottery2Max: TEdit
          Left = 192
          Top = 75
          Width = 67
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarWinLottery3Max: TScrollBar
          Left = 54
          Top = 100
          Width = 127
          Height = 19
          Max = 1000000
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarWinLottery3MaxChange
        end
        object EditWinLottery3Max: TEdit
          Left = 192
          Top = 100
          Width = 67
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object ScrollBarWinLottery4Max: TScrollBar
          Left = 54
          Top = 125
          Width = 127
          Height = 19
          Max = 1000000
          PageSize = 0
          TabOrder = 8
          OnChange = ScrollBarWinLottery4MaxChange
        end
        object EditWinLottery4Max: TEdit
          Left = 192
          Top = 125
          Width = 67
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 9
        end
        object EditWinLottery5Max: TEdit
          Left = 192
          Top = 150
          Width = 67
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 11
        end
        object ScrollBarWinLottery5Max: TScrollBar
          Left = 54
          Top = 150
          Width = 127
          Height = 19
          Max = 1000000
          PageSize = 0
          TabOrder = 10
          OnChange = ScrollBarWinLottery5MaxChange
        end
        object ScrollBarWinLottery6Max: TScrollBar
          Left = 54
          Top = 175
          Width = 127
          Height = 19
          Max = 1000000
          PageSize = 0
          TabOrder = 12
          OnChange = ScrollBarWinLottery6MaxChange
        end
        object EditWinLottery6Max: TEdit
          Left = 192
          Top = 175
          Width = 67
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 13
        end
        object EditWinLotteryRate: TEdit
          Left = 192
          Top = 20
          Width = 67
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarWinLotteryRate: TScrollBar
          Left = 54
          Top = 20
          Width = 127
          Height = 19
          Max = 100000
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarWinLotteryRateChange
        end
      end
      object GroupBox28: TGroupBox
        Left = 288
        Top = 10
        Width = 152
        Height = 211
        Caption = #22870#37329
        TabOrder = 1
        object Label50: TLabel
          Left = 10
          Top = 23
          Width = 42
          Height = 12
          Caption = #19968#31561#22870':'
        end
        object Label51: TLabel
          Left = 10
          Top = 53
          Width = 42
          Height = 12
          Caption = #20108#31561#22870':'
        end
        object Label52: TLabel
          Left = 10
          Top = 83
          Width = 42
          Height = 12
          Caption = #19977#31561#22870':'
        end
        object Label53: TLabel
          Left = 10
          Top = 113
          Width = 42
          Height = 12
          Caption = #22235#31561#22870':'
        end
        object Label54: TLabel
          Left = 10
          Top = 143
          Width = 42
          Height = 12
          Caption = #20116#31561#22870':'
        end
        object Label55: TLabel
          Left = 10
          Top = 173
          Width = 42
          Height = 12
          Caption = #20845#31561#22870':'
        end
        object EditWinLottery1Gold: TSpinEdit
          Left = 58
          Top = 19
          Width = 82
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 0
          Value = 100000000
          OnChange = EditWinLottery1GoldChange
        end
        object EditWinLottery2Gold: TSpinEdit
          Left = 58
          Top = 49
          Width = 82
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditWinLottery2GoldChange
        end
        object EditWinLottery3Gold: TSpinEdit
          Left = 58
          Top = 79
          Width = 82
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditWinLottery3GoldChange
        end
        object EditWinLottery4Gold: TSpinEdit
          Left = 58
          Top = 109
          Width = 82
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditWinLottery4GoldChange
        end
        object EditWinLottery5Gold: TSpinEdit
          Left = 58
          Top = 139
          Width = 82
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 4
          Value = 10
          OnChange = EditWinLottery5GoldChange
        end
        object EditWinLottery6Gold: TSpinEdit
          Left = 58
          Top = 169
          Width = 82
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 5
          Value = 10
          OnChange = EditWinLottery6GoldChange
        end
      end
      object ButtonWinLotterySave: TButton
        Left = 375
        Top = 234
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        ModalResult = 1
        TabOrder = 3
        OnClick = ButtonWinLotterySaveClick
      end
      object ButtonWinLotteryDefault: TButton
        Left = 298
        Top = 234
        Width = 65
        Height = 25
        Caption = #40664#35748'(&D)'
        TabOrder = 2
        OnClick = ButtonWinLotteryDefaultClick
      end
    end
    object TabSheet40: TTabSheet
      Caption = #31048#31095#29983#25928
      ImageIndex = 11
      object GroupBox36: TGroupBox
        Left = 10
        Top = 10
        Width = 140
        Height = 95
        Caption = #31048#31095#29983#25928
        TabOrder = 0
        object Label94: TLabel
          Left = 14
          Top = 42
          Width = 54
          Height = 12
          Caption = #29983#25928#26102#38271':'
        end
        object Label96: TLabel
          Left = 14
          Top = 66
          Width = 54
          Height = 12
          Caption = #33021#37327#20493#25968':'
          Enabled = False
        end
        object CheckBoxSpiritMutiny: TCheckBox
          Left = 9
          Top = 16
          Width = 122
          Height = 21
          Caption = #21551#29992#31048#31095#29305#27530#21151#33021
          TabOrder = 0
          OnClick = CheckBoxSpiritMutinyClick
        end
        object EditSpiritMutinyTime: TSpinEdit
          Left = 73
          Top = 37
          Width = 51
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditSpiritMutinyTimeChange
        end
        object EditSpiritPowerRate: TSpinEdit
          Left = 73
          Top = 62
          Width = 51
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditSpiritPowerRateChange
        end
      end
      object ButtonSpiritMutinySave: TButton
        Left = 356
        Top = 254
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonSpiritMutinySaveClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #33521#38596#35774#32622
      ImageIndex = 13
      object GroupBox49: TGroupBox
        Left = 10
        Top = 10
        Width = 140
        Height = 183
        Caption = #22522#26412#35774#32622
        TabOrder = 0
        object Label113: TLabel
          Left = 8
          Top = 140
          Width = 90
          Height = 12
          Caption = #21484#33521#38596#38388#38548#26102#38388':'
        end
        object Label114: TLabel
          Left = 8
          Top = 119
          Width = 90
          Height = 12
          Caption = #33521#38596#33719#21462#32463#39564':1/'
        end
        object Label264: TLabel
          Left = 16
          Top = 162
          Width = 78
          Height = 12
          Caption = #33521#38596#23608#20307#38388#38548':'
        end
        object CheckBoxHeroPickUp: TCheckBox
          Left = 8
          Top = 13
          Width = 121
          Height = 17
          Hint = #26159#21542#20801#35768#33521#38596#33258#21160#25441#22320#19978#29289#21697#65292#21482#25441#21462#20801#35768#33521#38596#25441#21462#29289#21697#21015#34920#20013#29289#21697
          Caption = #20801#35768#33521#38596#25441#21462#29289#21697
          TabOrder = 0
          OnClick = CheckBoxHeroPickUpClick
        end
        object CheckBoxHeroAutoToxin: TCheckBox
          Left = 8
          Top = 29
          Width = 121
          Height = 17
          Hint = #26159#21542#20801#35768#33521#38596#33258#21160#25442#27602#65292#22914#26524#19981#20801#35768#65292#33521#38596#26045#27602#23601#24517#38656#20808#25226#27602#24102#22312#35013#22791#26639#19978
          Caption = #26041#22763#33521#38596#33258#21160#25442#27602
          TabOrder = 1
          OnClick = CheckBoxHeroAutoToxinClick
        end
        object CheckBoxAddWeaponPace: TCheckBox
          Left = 8
          Top = 45
          Width = 121
          Height = 17
          Hint = #33521#38596#25915#20987#36895#24230#65292#26159#21542#38500#20102#22266#23450#20540#22806#65292#20877#35745#31639#27494#22120#19978#30340#25915#20987#36895#24230
          Caption = #33521#38596#35745#31639#27494#22120#36895#24230
          TabOrder = 2
          OnClick = CheckBoxAddWeaponPaceClick
        end
        object CheckBoxHeroKillAddPK: TCheckBox
          Left = 8
          Top = 61
          Width = 121
          Height = 17
          Hint = #33521#38596#26432#20154#26159#21542#22686#21152'PK'#20540
          Caption = #33521#38596#26432#20154#22686#21152'PK'#20540
          TabOrder = 3
          OnClick = CheckBoxHeroKillAddPKClick
        end
        object CheckBox5: TCheckBox
          Left = 8
          Top = 77
          Width = 121
          Height = 17
          Caption = '[CTRL+W]'#38145#23450#30446#26631
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 4
        end
        object SpinEditHeroCallTime: TSpinEdit
          Left = 100
          Top = 136
          Width = 38
          Height = 21
          Hint = #27599#27425#21484#21796#33521#38596#38388#38548#65292#40664#35748#20026'60'#31186#65292#26368#20302#19981#20302#20110'30'#31186
          MaxValue = 0
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnChange = SpinEditHeroCallTimeChange
        end
        object SpinEditHeroExp: TSpinEdit
          Left = 100
          Top = 115
          Width = 38
          Height = 21
          Hint = #26080#35770#33521#38596#25110#20027#20154#25171#27515#24618#29289#65292#33521#38596#33719#24471#30340#32463#39564#27604#20363#65292#40664#35748#20026'3'
          MaxValue = 0
          MinValue = 0
          TabOrder = 5
          Value = 0
          OnChange = SpinEditHeroExpChange
        end
        object CheckBox1: TCheckBox
          Left = 8
          Top = 96
          Width = 129
          Height = 17
          Caption = #33521#38596#32463#39564':'#20998#20139'/'#20849#20139
          TabOrder = 7
          OnClick = CheckBox1Click
        end
        object seClearHeroGhostTick: TSpinEdit
          Left = 99
          Top = 158
          Width = 38
          Height = 21
          Hint = #28165#29702#33521#38596#23608#20307#26102#38388#38388#38548
          MaxValue = 2147483647
          MinValue = 0
          TabOrder = 8
          Value = 0
          OnChange = seClearHeroGhostTickChange
        end
      end
      object GroupBox50: TGroupBox
        Left = 157
        Top = 10
        Width = 140
        Height = 185
        Caption = #33521#38596#25216#33021
        TabOrder = 1
        object Label127: TLabel
          Left = 10
          Top = 43
          Width = 54
          Height = 12
          Caption = #21015#28779#38388#38548':'
        end
        object Label128: TLabel
          Left = 116
          Top = 43
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label205: TLabel
          Left = 10
          Top = 20
          Width = 54
          Height = 12
          Caption = #22235#32423#35302#21457':'
        end
        object Label206: TLabel
          Left = 116
          Top = 19
          Width = 12
          Height = 12
          Caption = #28857
        end
        object SpinEditBlazeTickTime: TSpinEdit
          Left = 65
          Top = 39
          Width = 48
          Height = 21
          Hint = #33521#38596#20351#29992#28872#28779#25216#33021#38388#21355#38548#26102#38388
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = SpinEditBlazeTickTimeChange
        end
        object CheckBoxBump: TCheckBox
          Left = 10
          Top = 62
          Width = 97
          Height = 17
          Hint = #26159#21542#20801#35768#33521#38596#20351#29992#37326#34542#20914#25758
          Caption = #20351#29992#37326#34542#20914#25758
          TabOrder = 2
          OnClick = CheckBoxBumpClick
        end
        object GroupBox53: TGroupBox
          Left = 9
          Top = 100
          Width = 125
          Height = 75
          Caption = #25112#22763#33521#38596#22522#26412#25216#33021
          TabOrder = 3
          object RadioButtonAttack: TRadioButton
            Left = 8
            Top = 18
            Width = 73
            Height = 17
            Hint = #25112#22763#33521#38596#22312#19981#20351#29992#20854#23427#25216#33021#30340#24773#20917#19979#65292#40664#35748#20351#29992#30340#25915#20987#25216#33021
            Caption = #26222#36890#25915#20987
            TabOrder = 0
            OnClick = RadioButtonAttackClick
          end
          object RadioButton2: TRadioButton
            Left = 8
            Top = 35
            Width = 73
            Height = 17
            Caption = #20992#20992#21050#26432
            TabOrder = 1
            OnClick = RadioButton2Click
          end
          object RadioButton3: TRadioButton
            Left = 8
            Top = 52
            Width = 73
            Height = 17
            Caption = #21322#26376#24367#20992
            TabOrder = 2
            OnClick = RadioButton3Click
          end
        end
        object EditHeroFourMagic: TSpinEdit
          Left = 65
          Top = 15
          Width = 48
          Height = 21
          Hint = #35302#21457#22235#32423#25216#33021#25152#38656#24544#35802#24230#12290'100'#28857#20026'%1'#12290#40664#35748#20026' 3000'
          MaxValue = 10000
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = EditHeroFourMagicChange
        end
      end
      object GroupBox51: TGroupBox
        Left = 304
        Top = 10
        Width = 140
        Height = 91
        Caption = #25915#20987#26102#38388#38388#38548
        TabOrder = 2
        object Label115: TLabel
          Left = 10
          Top = 19
          Width = 30
          Height = 12
          Caption = #25112#22763':'
        end
        object Label116: TLabel
          Left = 98
          Top = 19
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object Label117: TLabel
          Left = 10
          Top = 43
          Width = 30
          Height = 12
          Caption = #27861#24072':'
        end
        object Label118: TLabel
          Left = 98
          Top = 43
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object Label119: TLabel
          Left = 98
          Top = 67
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object Label120: TLabel
          Left = 10
          Top = 67
          Width = 30
          Height = 12
          Caption = #26041#22763':'
        end
        object SpinEditWarrAkTime: TSpinEdit
          Left = 44
          Top = 15
          Width = 53
          Height = 21
          Hint = #25112#22763#33521#38596#27599#27425#25915#20987#26102#38388#38388#38548#65292#40664#35748'600'#65292#37325#26032#21484#21796#33521#38596#21518#29983#25928#12290
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = SpinEditWarrAkTimeChange
        end
        object SpinEditWizardAkTime: TSpinEdit
          Left = 44
          Top = 39
          Width = 53
          Height = 21
          Hint = #27861#24072#33521#38596#27599#27425#25915#20987#26102#38388#38388#38548#65292#40664#35748'900'#65292#37325#26032#21484#21796#33521#38596#21518#29983#25928#12290
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = SpinEditWizardAkTimeChange
        end
        object SpinEditTaosAkTime: TSpinEdit
          Left = 44
          Top = 63
          Width = 53
          Height = 21
          Hint = #26041#22763#33521#38596#27599#27425#25915#20987#26102#38388#38388#38548#65292#40664#35748'900'#65292#37325#26032#21484#21796#33521#38596#21518#29983#25928#12290
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnChange = SpinEditTaosAkTimeChange
        end
      end
      object GroupBox52: TGroupBox
        Left = 303
        Top = 104
        Width = 140
        Height = 92
        Caption = #34892#36208#26102#38388#38388#38548
        TabOrder = 3
        object Label121: TLabel
          Left = 10
          Top = 19
          Width = 30
          Height = 12
          Caption = #25112#22763':'
        end
        object Label122: TLabel
          Left = 98
          Top = 19
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object Label123: TLabel
          Left = 10
          Top = 43
          Width = 30
          Height = 12
          Caption = #27861#24072':'
        end
        object Label124: TLabel
          Left = 98
          Top = 43
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object Label125: TLabel
          Left = 98
          Top = 67
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object Label126: TLabel
          Left = 10
          Top = 67
          Width = 30
          Height = 12
          Caption = #26041#22763':'
        end
        object SpinEditWarrWalkTime: TSpinEdit
          Left = 44
          Top = 16
          Width = 53
          Height = 21
          Hint = #25112#22763#33521#38596#27599#27425#36208#21160#26102#38388#38388#38548#65292#40664#35748'600'#65292#37325#26032#21484#21796#33521#38596#21518#29983#25928#12290
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = SpinEditWarrWalkTimeChange
        end
        object SpinEditWizardWalkTime: TSpinEdit
          Left = 44
          Top = 39
          Width = 53
          Height = 21
          Hint = #27861#24072#33521#38596#27599#27425#36208#21160#26102#38388#38388#38548#65292#40664#35748'600'#65292#37325#26032#21484#21796#33521#38596#21518#29983#25928#12290
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = SpinEditWizardWalkTimeChange
        end
        object SpinEditTaosWalkTime: TSpinEdit
          Left = 44
          Top = 63
          Width = 53
          Height = 21
          Hint = #26041#22763#33521#38596#27599#27425#36208#21160#26102#38388#38388#38548#65292#40664#35748'600'#65292#37325#26032#21484#21796#33521#38596#21518#29983#25928#12290
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnChange = SpinEditTaosWalkTimeChange
        end
      end
      object GroupBox54: TGroupBox
        Left = 13
        Top = 195
        Width = 140
        Height = 92
        Caption = #33521#38596#21517#23383#35774#32622
        TabOrder = 4
        object Label129: TLabel
          Left = 8
          Top = 52
          Width = 30
          Height = 12
          Caption = #21517#31216':'
        end
        object Label130: TLabel
          Left = 8
          Top = 71
          Width = 30
          Height = 12
          Caption = #21518#32512':'
        end
        object Label131: TLabel
          Left = 8
          Top = 32
          Width = 30
          Height = 12
          Caption = #39068#33394':'
        end
        object LabeltHeroNameColor: TLabel
          Left = 82
          Top = 38
          Width = 11
          Height = 16
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object CheckBoxHeroShowName: TCheckBox
          Left = 8
          Top = 12
          Width = 97
          Height = 17
          Hint = #26159#21542#26174#31034#33521#38596#20027#20154#30340#21517#31216
          Caption = #26174#31034#20027#20154#21517#23383
          TabOrder = 0
          OnClick = CheckBoxHeroShowNameClick
        end
        object EditHeroName: TEdit
          Left = 40
          Top = 49
          Width = 73
          Height = 20
          TabOrder = 2
          Text = #33521#38596
          OnKeyDown = EditHeroNameKeyDown
        end
        object EditHeroName2: TEdit
          Left = 40
          Top = 67
          Width = 73
          Height = 20
          TabOrder = 3
          Text = #30340#33521#38596
          OnChange = EditHeroName2Change
        end
        object EditHeroNameColor: TSpinEdit
          Left = 40
          Top = 28
          Width = 40
          Height = 21
          Hint = #33521#38596#21517#31216#39068#33394
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditHeroNameColorChange
        end
      end
      object ButtonHeroSave: TButton
        Left = 383
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 6
        OnClick = ButtonHeroSaveClick
      end
      object GroupBox88: TGroupBox
        Left = 158
        Top = 195
        Width = 220
        Height = 91
        Caption = #24544#35802#24230#35774#32622
        TabOrder = 5
        object Label198: TLabel
          Left = 8
          Top = 19
          Width = 48
          Height = 12
          Caption = #21484#21796#22686#21152
        end
        object Label201: TLabel
          Left = 8
          Top = 42
          Width = 48
          Height = 12
          Caption = #33719#24471#32463#39564
        end
        object Label202: TLabel
          Left = 116
          Top = 42
          Width = 42
          Height = 12
          Caption = #28857'/'#22686#21152
        end
        object Label203: TLabel
          Left = 114
          Top = 67
          Width = 48
          Height = 12
          Caption = #21484#22238#20943#23569
        end
        object Label204: TLabel
          Left = 8
          Top = 67
          Width = 48
          Height = 12
          Caption = #27515#20129#20943#23569
        end
        object EditHeroFealtyCallAdd: TSpinEdit
          Left = 58
          Top = 14
          Width = 57
          Height = 21
          Hint = #33521#38596#27599#27425#25163#21160#21484#21796#20986#26469#22686#21152#24544#35802#24230#28857#25968#65292'100'#28857#20026'%1'#12290#40664#35748#20540' 1'
          MaxValue = 10000
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = EditHeroFealtyCallAddChange
        end
        object EditHeroFealtyExp: TSpinEdit
          Left = 58
          Top = 38
          Width = 57
          Height = 21
          Hint = #24403#33521#38596#33719#24471#35813#39033#25351#23450#32463#39564#20540#26102#65292#33258#21160#22686#21152#33521#38596#24544#35802#24230#12290'100'#28857#20026'%1'#12290
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = EditHeroFealtyExpChange
        end
        object EditHeroFealtyExpAdd: TSpinEdit
          Left = 164
          Top = 38
          Width = 51
          Height = 21
          Hint = #24403#33521#38596#33719#24471#35813#39033#25351#23450#32463#39564#20540#26102#65292#33258#21160#22686#21152#33521#38596#24544#35802#24230#12290'100'#28857#20026'%1'#12290
          MaxValue = 10000
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnChange = EditHeroFealtyExpAddChange
        end
        object EditHeroFealtyCallDel: TSpinEdit
          Left = 164
          Top = 62
          Width = 51
          Height = 21
          Hint = #24403#33521#38596#34987#25163#21160#21484#22238#26102'('#36864#20986#28216#25103#31561#19981#31639')'#65292#33258#21160#20943#23569#33521#38596#24544#35802#24230#12290'100'#28857#20026'%1'#12290
          MaxValue = 10000
          MinValue = 0
          TabOrder = 4
          Value = 0
          OnChange = EditHeroFealtyCallDelChange
        end
        object EditHeroFealtyDeathDel: TSpinEdit
          Left = 58
          Top = 62
          Width = 57
          Height = 21
          Hint = #24403#33521#38596#27515#20129#26102#65292#33258#21160#20943#23569#33521#38596#24544#35802#24230#12290'100'#28857#20026'%1'#12290
          MaxValue = 10000
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnChange = EditHeroFealtyDeathDelChange
        end
      end
    end
    object ts1: TTabSheet
      Caption = #37202#39302#35774#32622
      ImageIndex = 14
      object PageControl4: TPageControl
        Left = 1
        Top = -1
        Width = 448
        Height = 275
        ActivePage = ts2
        TabOrder = 0
        OnChanging = FunctionConfigControlChanging
        object ts2: TTabSheet
          Caption = #22522#26412#35774#32622
          object PageControl5: TPageControl
            Left = 0
            Top = -2
            Width = 438
            Height = 252
            ActivePage = ts3
            TabOrder = 0
            object ts3: TTabSheet
              Caption = #22522#26412#35774#32622
              object grp2: TGroupBox
                Left = 17
                Top = 6
                Width = 229
                Height = 65
                Caption = #37247#37202#31561#24453#26102#38388
                TabOrder = 0
                object lbl1: TLabel
                  Left = 20
                  Top = 19
                  Width = 48
                  Height = 12
                  Caption = #26222#36890#37202#65306
                end
                object Label223: TLabel
                  Left = 19
                  Top = 41
                  Width = 42
                  Height = 12
                  Caption = #33647' '#37202#65306
                end
                object Label226: TLabel
                  Left = 162
                  Top = 17
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label227: TLabel
                  Left = 162
                  Top = 42
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object seMakeWineTime: TSpinEdit
                  Left = 74
                  Top = 14
                  Width = 71
                  Height = 21
                  Hint = #37247#26222#36890#37202#38656#35201#31561#24453#30340#26102#38388
                  MaxValue = 100000000
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = seMakeWineTimeChange
                end
                object seMakeWineTime1: TSpinEdit
                  Left = 77
                  Top = 38
                  Width = 71
                  Height = 21
                  Hint = #37247#33647#37202#38656#35201#31561#24453#30340#26102#38388
                  MaxValue = 100000000
                  MinValue = 0
                  TabOrder = 1
                  Value = 0
                  OnChange = seMakeWineTime1Change
                end
              end
              object GroupBox100: TGroupBox
                Left = 252
                Top = 5
                Width = 169
                Height = 65
                Caption = #33719#24471#37202#26354#26426#29575
                TabOrder = 1
                object Label224: TLabel
                  Left = 16
                  Top = 30
                  Width = 54
                  Height = 12
                  Caption = #37202#26354#26426#29575':'
                end
                object Label228: TLabel
                  Left = 152
                  Top = 28
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object SEdtMakeWineRate: TSpinEdit
                  Left = 76
                  Top = 25
                  Width = 67
                  Height = 21
                  Hint = #25968#23383#36234#23567#65292#37247#36896#26222#36890#37202#33719#24471#37202#26354#26426#29575#36234#22823#12290
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = SEdtMakeWineRateChange
                end
              end
              object GroupBox101: TGroupBox
                Left = 16
                Top = 73
                Width = 230
                Height = 75
                Caption = #33647#21147#20540#30456#20851
                TabOrder = 2
                object lbl2: TLabel
                  Left = 16
                  Top = 12
                  Width = 78
                  Height = 12
                  Caption = #33647#21147#20943#23569#38388#38548':'
                end
                object Label225: TLabel
                  Left = 40
                  Top = 32
                  Width = 54
                  Height = 12
                  Caption = #20943#33647#21147#20540':'
                end
                object Label229: TLabel
                  Left = 178
                  Top = 11
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label268: TLabel
                  Left = 6
                  Top = 53
                  Width = 90
                  Height = 12
                  Caption = #33647#21147#20540#27599#32423#23646#24615':'
                end
                object seDesMedicineValue: TSpinEdit
                  Left = 96
                  Top = 8
                  Width = 71
                  Height = 21
                  Hint = #22312#32447#25351#23450#26102#38388#20869#27809#26377#39278#29992#33647#37202','#21017#20943#33647#21147#20540
                  MaxValue = 100000000
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = seDesMedicineValueChange
                end
                object seDesMedicineTick: TSpinEdit
                  Left = 96
                  Top = 28
                  Width = 71
                  Height = 21
                  Hint = #38271#26399#27809#26377#39278#37202','#38388#38548#22810#38271#26102#38388#20943#33647#21147#20540
                  MaxValue = 100000000
                  MinValue = 0
                  TabOrder = 1
                  Value = 0
                  OnChange = seDesMedicineTickChange
                end
                object SeMedicineIncAbil: TSpinEdit
                  Left = 95
                  Top = 51
                  Width = 71
                  Height = 21
                  Hint = #33647#21147#20540#27599#19968#32423#22686#21152#30340#23646#24615#20540','#25968#20540#20026#32047#21152
                  MaxValue = 100000000
                  MinValue = 1
                  TabOrder = 2
                  Value = 1
                  OnChange = SeMedicineIncAbilChange
                end
              end
              object GroupBox103: TGroupBox
                Left = 17
                Top = 147
                Width = 229
                Height = 76
                Caption = #27849#27700
                TabOrder = 3
                object Label236: TLabel
                  Left = 91
                  Top = 47
                  Width = 54
                  Height = 12
                  Caption = #37319#38598#26102#38388':'
                end
                object Label237: TLabel
                  Left = 207
                  Top = 47
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label238: TLabel
                  Left = 7
                  Top = 20
                  Width = 138
                  Height = 12
                  Caption = #34892#20250#25104#21592#39046#21462#27849#27700#20943#33988#37327':'
                end
                object seInFountainTime: TSpinEdit
                  Left = 153
                  Top = 43
                  Width = 47
                  Height = 21
                  Hint = #37319#38598#27849#27700#38656#31449#22312#27849#30524#19978#30340#26102#38388
                  MaxValue = 65535
                  MinValue = 2
                  TabOrder = 0
                  Value = 2
                  OnChange = seInFountainTimeChange
                end
                object seDecGuildFountain: TSpinEdit
                  Left = 152
                  Top = 16
                  Width = 49
                  Height = 21
                  Hint = #34892#20250#25104#21592#39046#21462#27849#27700#26102','#34892#20250#33988#37327#20943#23569#25351#23450#30340#20540
                  MaxValue = 65535
                  MinValue = 0
                  TabOrder = 1
                  Value = 0
                  OnChange = seDecGuildFountainChange
                end
              end
              object GroupBox102: TGroupBox
                Left = 252
                Top = 76
                Width = 169
                Height = 70
                Caption = #37247#36896#33647#37202#26222#36890#37202#25152#39035#26368#20302#21697#36136
                TabOrder = 4
                object Label266: TLabel
                  Left = 30
                  Top = 32
                  Width = 30
                  Height = 12
                  Caption = #21697#36136':'
                end
                object SeMakeMedicineWineMinQuality: TSpinEdit
                  Left = 75
                  Top = 28
                  Width = 65
                  Height = 21
                  Hint = #37247#36896#33647#37202#26102#26222#36890#37202#30340#26368#20302#21697#36136','#19981#36798#21040#36825#20010#21697#36136#30340#26222#36890#37202#19981#33021#29992#26469#13#10#37247#36896#33647#37202','#23601#26159#37247#36896#20102#39278#29992#20102#20063#27809#38468#21152#23646#24615#30340
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = SeMakeMedicineWineMinQualityChange
                end
              end
            end
            object ts4: TTabSheet
              Caption = #39278#37202#30456#20851
              ImageIndex = 1
              object GroupBox111: TGroupBox
                Left = 4
                Top = 139
                Width = 417
                Height = 87
                Caption = #37202#37257#30456#20851
                TabOrder = 0
                object Label249: TLabel
                  Left = 161
                  Top = 65
                  Width = 156
                  Height = 12
                  Caption = #34920#31034#37202#37257','#37202#37257#29366#24577#26174#31034#38388#38548':'
                end
                object Label251: TLabel
                  Left = 383
                  Top = 65
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label254: TLabel
                  Left = 34
                  Top = 17
                  Width = 60
                  Height = 12
                  Caption = #37257#37202#24230#39640#20110
                end
                object Label255: TLabel
                  Left = 167
                  Top = 18
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object Label256: TLabel
                  Left = 215
                  Top = 18
                  Width = 102
                  Height = 12
                  Caption = #37202#37327#25552#21319#36827#24230#21152#24555':'
                end
                object Label258: TLabel
                  Left = 34
                  Top = 41
                  Width = 60
                  Height = 12
                  Caption = #37257#37202#24230#20302#20110
                end
                object Label259: TLabel
                  Left = 167
                  Top = 41
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object Label260: TLabel
                  Left = 214
                  Top = 41
                  Width = 102
                  Height = 12
                  Caption = #37202#37327#25552#21319#36827#24230#20943#24930':'
                end
                object Label262: TLabel
                  Left = 34
                  Top = 65
                  Width = 60
                  Height = 12
                  Caption = #37257#37202#24230#39640#20110
                end
                object Label263: TLabel
                  Left = 383
                  Top = 41
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label257: TLabel
                  Left = 383
                  Top = 19
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SEDRUNKTick: TSpinEdit
                  Left = 322
                  Top = 62
                  Width = 47
                  Height = 21
                  Hint = #26174#31034#37257#37202#29366#24577#38388#38548
                  MaxValue = 100000000
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SEDRUNKTickChange
                end
                object seHighDRUNKTick: TSpinEdit
                  Left = 112
                  Top = 15
                  Width = 44
                  Height = 21
                  Hint = #37257#37202#24230#39640#20110#25351#23450#20540
                  MaxValue = 100
                  MinValue = 5
                  TabOrder = 1
                  Value = 10
                  OnChange = seHighDRUNKTickChange
                end
                object seHighAlcoholTick: TSpinEdit
                  Left = 323
                  Top = 15
                  Width = 44
                  Height = 21
                  Hint = #21152#36895#37202#37327#25552#21319#36827#24230#31186#25968
                  MaxValue = 100000000
                  MinValue = 0
                  TabOrder = 2
                  Value = 0
                  OnChange = seHighAlcoholTickChange
                end
                object selowDRUNKTick: TSpinEdit
                  Left = 110
                  Top = 38
                  Width = 45
                  Height = 21
                  Hint = #37257#37202#24230#20302#20110#25351#23450#20540
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 3
                  Value = 10
                  OnChange = selowDRUNKTickChange
                end
                object selowAlcoholTick: TSpinEdit
                  Left = 323
                  Top = 38
                  Width = 44
                  Height = 21
                  Hint = #38477#20302#37202#37327#25552#21319#36827#24230#31186#25968
                  MaxValue = 100000000
                  MinValue = 0
                  TabOrder = 4
                  Value = 0
                  OnChange = selowAlcoholTickChange
                end
                object seRUNKValue: TSpinEdit
                  Left = 110
                  Top = 62
                  Width = 45
                  Height = 21
                  Hint = #37257#37202#24230#39640#20110#25351#23450#20540#34920#31034#37202#37257','#20250#38477#20302#39764#27861#36530#36991#21644#29983#21629#24674#22797
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 5
                  Value = 90
                  OnChange = seRUNKValueChange
                end
              end
              object GroupBox110: TGroupBox
                Left = 3
                Top = 2
                Width = 208
                Height = 135
                Caption = #36827#24230#38388#38548
                TabOrder = 1
                object Label247: TLabel
                  Left = 27
                  Top = 93
                  Width = 78
                  Height = 12
                  Caption = #37202#37327#20943#23569#38388#38548':'
                end
                object Label248: TLabel
                  Left = 186
                  Top = 94
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label235: TLabel
                  Left = 15
                  Top = 73
                  Width = 90
                  Height = 12
                  Caption = #37202#37327#19978#38480#22686#21152#20540':'
                end
                object Label234: TLabel
                  Left = 17
                  Top = 54
                  Width = 90
                  Height = 12
                  Caption = #37202#37327#19978#38480#21021#22987#20540':'
                end
                object Label232: TLabel
                  Left = 17
                  Top = 33
                  Width = 90
                  Height = 12
                  Caption = #37257#37202#24230#20943#23569#38388#38548':'
                end
                object Label233: TLabel
                  Left = 188
                  Top = 33
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label231: TLabel
                  Left = 188
                  Top = 13
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label230: TLabel
                  Left = 8
                  Top = 13
                  Width = 102
                  Height = 12
                  Caption = #37202#37327#36827#24230#22686#21152#38388#38548':'
                end
                object Label265: TLabel
                  Left = 38
                  Top = 113
                  Width = 66
                  Height = 12
                  Caption = #37202#37327#20943#23569#20540':'
                end
                object seDecAlcoholValue: TSpinEdit
                  Left = 114
                  Top = 110
                  Width = 66
                  Height = 21
                  Hint = #22312#25351#23450#26102#38388#20869#27809#26377#39278#37202','#20943#23569#30340#37202#37327#20540
                  MaxValue = 65535
                  MinValue = 0
                  TabOrder = 5
                  Value = 0
                  OnChange = seDecAlcoholValueChange
                end
                object seDecMaxAlcoholTime: TSpinEdit
                  Left = 114
                  Top = 90
                  Width = 66
                  Height = 21
                  Hint = #22312#25351#23450#26102#38388#20869#27809#26377#39278#37202','#21017#20943#23569#37202#37327
                  MaxValue = 100000000
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = seDecMaxAlcoholTimeChange
                end
                object seIncAlcoholValue: TSpinEdit
                  Left = 114
                  Top = 70
                  Width = 66
                  Height = 21
                  Hint = #24403#21069#37202#37327#20540#36798#21040#19978#38480#21518','#37202#37327#19978#38480#22686#21152#25351#23450#30340#20540
                  MaxValue = 65535
                  MinValue = 0
                  TabOrder = 1
                  Value = 0
                  OnChange = seIncAlcoholValueChange
                end
                object seMaxAlcoholValue: TSpinEdit
                  Left = 114
                  Top = 50
                  Width = 67
                  Height = 21
                  Hint = #37202#37327#21021#22987#19978#38480#20540
                  MaxValue = 65535
                  MinValue = 0
                  TabOrder = 2
                  Value = 0
                  OnChange = seMaxAlcoholValueChange
                end
                object seDesDrinkTick: TSpinEdit
                  Left = 114
                  Top = 30
                  Width = 68
                  Height = 21
                  Hint = #37257#37202#24230#20943#23569#38388#38548#26102#38388
                  MaxValue = 100000000
                  MinValue = 0
                  TabOrder = 3
                  Value = 0
                  OnChange = seDesDrinkTickChange
                end
                object seIncAlcoholTick: TSpinEdit
                  Left = 114
                  Top = 10
                  Width = 68
                  Height = 21
                  Hint = #37202#37327#36827#24230#22686#21152#26102#38388#38388#38548
                  MaxValue = 100000000
                  MinValue = 0
                  TabOrder = 4
                  Value = 0
                  OnChange = seIncAlcoholTickChange
                end
              end
              object GroupBox108: TGroupBox
                Left = 217
                Top = 2
                Width = 204
                Height = 130
                Caption = #21697#36136#30456#20851
                TabOrder = 2
                object Label241: TLabel
                  Left = 37
                  Top = 22
                  Width = 78
                  Height = 12
                  Caption = #37202#30340#21697#36136#39640#20110':'
                end
                object Label242: TLabel
                  Left = 29
                  Top = 50
                  Width = 90
                  Height = 12
                  Caption = #38468#21152#20020#26102#23646#24615#20540':'
                end
                object Label250: TLabel
                  Left = 16
                  Top = 77
                  Width = 102
                  Height = 12
                  Caption = #37202#37327#25552#21319#36895#24230#21152#24555':'
                end
                object Label253: TLabel
                  Left = 184
                  Top = 77
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label252: TLabel
                  Left = 189
                  Top = 104
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object lbl3: TLabel
                  Left = 16
                  Top = 104
                  Width = 102
                  Height = 12
                  Caption = #38468#21152#23646#24615#22686#21152#26426#29575':'
                end
                object sewinequality: TSpinEdit
                  Left = 127
                  Top = 19
                  Width = 52
                  Height = 21
                  Hint = #22312#39278#29992#21697#36136#39640#20110#25351#23450#30340#37202','#22914#26524#33647#37202#30340#21697#36136#20302#20110#27492#20540#20250#19981#22686#21152#33647#21147#20540
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = sewinequalityChange
                end
                object seTempAbil: TSpinEdit
                  Left = 127
                  Top = 46
                  Width = 52
                  Height = 21
                  Hint = #22312#39278#29992#21697#36136#39640#20110#25351#23450#30340#33647#37202','#33719#24471#38468#21152#30340#20020#30028#26102#23646#24615','#22312#21407#26469#22522#30784#19978#22686#21152#20960#28857
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 1
                  Value = 0
                  OnChange = seTempAbilChange
                end
                object SeSpeedupAlcoholTick: TSpinEdit
                  Left = 127
                  Top = 74
                  Width = 51
                  Height = 21
                  Hint = #22312#39278#29992#21697#36136#39640#20110#25351#23450#30340#21697#36136#30340#37202','#21017#37202#37327#25552#21319#36895#24230#27604#40664#35748#24555#20960#31186','#19981#33021#22823#20110#37202#37327#36827#24230#22686#21152#38388#38548
                  MaxValue = 100000000
                  MinValue = 0
                  TabOrder = 2
                  Value = 0
                  OnChange = SeSpeedupAlcoholTickChange
                end
                object seGettempAbilRate: TSpinEdit
                  Left = 125
                  Top = 101
                  Width = 53
                  Height = 21
                  Hint = #39278#37202#26102#33719#24471#30340#38468#21152#20020#26102#23646#24615#30340#26426#29575','#36234#23569#36234#39640'.'
                  MaxValue = 100000000
                  MinValue = 0
                  TabOrder = 3
                  Value = 0
                  OnChange = seGettempAbilRateChange
                end
              end
            end
          end
        end
        object TabSheet49: TTabSheet
          Caption = #32463#39564#35774#32622
          ImageIndex = 1
          object GroupBox104: TGroupBox
            Left = 14
            Top = 7
            Width = 201
            Height = 222
            Caption = #33647#21147#21319#32423#32463#39564
            TabOrder = 0
            object GridMedicineExp: TStringGrid
              Left = 13
              Top = 15
              Width = 164
              Height = 192
              ColCount = 2
              DefaultRowHeight = 18
              RowCount = 501
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
              TabOrder = 0
              OnSetEditText = GridMedicineExpSetEditText
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
          object GroupBox105: TGroupBox
            Left = 221
            Top = 6
            Width = 202
            Height = 222
            Caption = #37202#27668#25252#20307#21319#32423#32463#39564
            TabOrder = 1
            object GridSkill84Exp: TStringGrid
              Left = 16
              Top = 16
              Width = 154
              Height = 193
              ColCount = 2
              DefaultRowHeight = 18
              RowCount = 501
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
              TabOrder = 0
              OnSetEditText = GridSkill84ExpSetEditText
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
        end
        object TabSheet50: TTabSheet
          Caption = #25216#33021#35774#32622
          ImageIndex = 2
          object GroupBox106: TGroupBox
            Left = 3
            Top = 3
            Width = 208
            Height = 226
            Caption = #20808#22825#20803#21147
            TabOrder = 0
            object Label239: TLabel
              Left = 24
              Top = 22
              Width = 66
              Height = 12
              Caption = #37257#37202#24230#20302#20110':'
            end
            object Label240: TLabel
              Left = 158
              Top = 22
              Width = 30
              Height = 12
              Caption = '%'#22833#25928
            end
            object seMinDrinkValue83: TSpinEdit
              Left = 99
              Top = 18
              Width = 53
              Height = 21
              Hint = #24403#37257#37202#24230#20302#20110' '#24635#37202#37327'* '#35774#32622#20540'/100 '#26102','#25216#33021#26080#27861#20351#29992
              MaxValue = 100
              MinValue = 0
              TabOrder = 0
              Value = 0
              OnChange = seMinDrinkValue83Change
            end
            object GridSkill83Abil: TStringGrid
              Left = 7
              Top = 50
              Width = 188
              Height = 162
              ColCount = 3
              DefaultRowHeight = 18
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
              TabOrder = 1
              OnSetEditText = GridSkill83AbilSetEditText
              ColWidths = (
                64
                67
                64)
              RowHeights = (
                18
                18
                19
                18
                18)
            end
          end
          object GroupBox107: TGroupBox
            Left = 215
            Top = 3
            Width = 203
            Height = 226
            Caption = #37202#27668#25252#20307
            TabOrder = 1
            object Label245: TLabel
              Left = 32
              Top = 74
              Width = 60
              Height = 12
              Caption = #37257#37202#24230#20302#20110
            end
            object Label246: TLabel
              Left = 156
              Top = 74
              Width = 30
              Height = 12
              Caption = '%'#22833#25928
            end
            object Label261: TLabel
              Left = 41
              Top = 100
              Width = 48
              Height = 12
              Caption = #31561#32423#38480#21046
            end
            object Label267: TLabel
              Left = 40
              Top = 129
              Width = 48
              Height = 12
              Caption = #21152'HP'#20493#25968
            end
            object GroupBox109: TGroupBox
              Left = 9
              Top = 14
              Width = 183
              Height = 45
              Caption = #25345#32493#26102#38388
              TabOrder = 0
              object Label243: TLabel
                Left = 38
                Top = 18
                Width = 30
                Height = 12
                Caption = #26102#38388':'
              end
              object Label244: TLabel
                Left = 143
                Top = 17
                Width = 12
                Height = 12
                Caption = #31186
              end
              object seHPUpUseTime: TSpinEdit
                Left = 75
                Top = 14
                Width = 53
                Height = 21
                Hint = #22686#21152'HP'#30340#25345#32493#26102#38388
                MaxValue = 65535
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = seHPUpUseTimeChange
              end
            end
            object seMinDrinkValue84: TSpinEdit
              Left = 108
              Top = 70
              Width = 43
              Height = 21
              Hint = #24403#37257#37202#24230#20302#20110' '#24635#37202#37327'* '#35774#32622#20540'/100 '#26102','#25216#33021#26080#27861#20351#29992
              MaxValue = 100
              MinValue = 0
              TabOrder = 1
              Value = 0
              OnChange = seMinDrinkValue84Change
            end
            object seskill84MaxLevel: TSpinEdit
              Left = 109
              Top = 96
              Width = 42
              Height = 21
              Hint = #37202#27668#25252#20307#26368#39640#31561#32423','#36798#21040#27492#31561#32423#21518#19981#20250#20877#22686#21152#31561#32423
              MaxValue = 500
              MinValue = 99
              TabOrder = 2
              Value = 99
              OnChange = seskill84MaxLevelChange
            end
            object Seskill84HPUpTick: TSpinEdit
              Left = 109
              Top = 126
              Width = 42
              Height = 21
              Hint = #37202#27668#25252#20307#27599#32423#25152#21152'HP'#20493#25968' '#25152#21152#30340#25968#20540'='#31561#32423'x'#20493#25968
              MaxValue = 1000
              MinValue = 1
              TabOrder = 3
              Value = 99
              OnChange = Seskill84HPUpTickChange
            end
          end
        end
      end
      object btnSaveMakeWine: TButton
        Left = 384
        Top = 278
        Width = 62
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = btnSaveMakeWineClick
      end
    end
    object ts5: TTabSheet
      Caption = #25361#25112
      ImageIndex = 15
      object Label271: TLabel
        Left = 20
        Top = 19
        Width = 72
        Height = 12
        Caption = #25361#25112#30340#26102#38388#65306
      end
      object Label272: TLabel
        Left = 162
        Top = 21
        Width = 12
        Height = 12
        Caption = #20998
      end
      object SeChallengeTime: TSpinEdit
        Left = 97
        Top = 16
        Width = 57
        Height = 21
        Hint = #29609#23478#27599#27425#25361#25112#30340#26102#38388','#40664#35748#20026#20116#20998#38047
        MaxValue = 100000000
        MinValue = 1
        TabOrder = 0
        Value = 1
        OnChange = SeChallengeTimeChange
      end
      object RadioGroup1: TRadioGroup
        Left = 22
        Top = 49
        Width = 152
        Height = 105
        Caption = #25361#25112#38468#21152#24065
        ItemIndex = 0
        Items.Strings = (
          #37329#21018#30707
          #20803#23453
          #28789#31526)
        TabOrder = 1
        OnClick = RadioGroup1Click
      end
      object btnChallengeSave: TButton
        Left = 380
        Top = 271
        Width = 62
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = btnChallengeSaveClick
      end
    end
  end
end
