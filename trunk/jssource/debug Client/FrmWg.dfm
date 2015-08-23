object FormWgMain: TFormWgMain
  Left = 189
  Top = 108
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #20256#22855#20869#25346
  ClientHeight = 307
  ClientWidth = 248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 249
    Height = 305
    ActivePage = TabSheet3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    MultiLine = True
    ParentFont = False
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #22522#26412
      object Label1: TLabel
        Left = 158
        Top = 151
        Width = 12
        Height = 12
        Caption = #38190
      end
      object Label2: TLabel
        Left = 216
        Top = 152
        Width = 12
        Height = 12
        Caption = #31186
      end
      object GroupBox1: TGroupBox
        Left = 4
        Top = 189
        Width = 232
        Height = 68
        TabOrder = 0
        object Label3: TLabel
          Left = 14
          Top = 12
          Width = 48
          Height = 12
          Caption = #31227#21160#21152#36895
        end
        object Label4: TLabel
          Left = 90
          Top = 12
          Width = 48
          Height = 12
          Caption = #25915#20987#21152#36895
        end
        object Label5: TLabel
          Left = 166
          Top = 12
          Width = 48
          Height = 12
          Caption = #39764#27861#21152#36895
        end
        object LabelMoveTime: TLabel
          Left = 11
          Top = 26
          Width = 54
          Height = 13
          Alignment = taCenter
          AutoSize = False
          BiDiMode = bdLeftToRight
          Caption = '0'
          ParentBiDiMode = False
        end
        object LabelHitTime: TLabel
          Left = 85
          Top = 26
          Width = 54
          Height = 13
          Alignment = taCenter
          AutoSize = False
          BiDiMode = bdLeftToRight
          Caption = '0'
          ParentBiDiMode = False
        end
        object LabelSpellTime: TLabel
          Left = 161
          Top = 26
          Width = 54
          Height = 13
          Alignment = taCenter
          AutoSize = False
          BiDiMode = bdLeftToRight
          Caption = '0'
          ParentBiDiMode = False
        end
        object MoveTime: TTrackBar
          Left = 6
          Top = 38
          Width = 65
          Height = 25
          Max = 9
          TabOrder = 0
          ThumbLength = 10
          TickMarks = tmTopLeft
          OnChange = HitTimeChange
        end
        object HitTime: TTrackBar
          Left = 81
          Top = 38
          Width = 65
          Height = 25
          Max = 9
          TabOrder = 1
          ThumbLength = 10
          TickMarks = tmTopLeft
          OnChange = HitTimeChange
        end
        object SpellTime: TTrackBar
          Left = 157
          Top = 38
          Width = 65
          Height = 25
          Max = 9
          TabOrder = 2
          ThumbLength = 10
          TickMarks = tmTopLeft
          OnChange = HitTimeChange
        end
      end
      object AutoMagic: TCheckBox
        Left = 7
        Top = 148
        Width = 72
        Height = 20
        Caption = #33258#21160#32451#21151
        TabOrder = 1
        OnClick = ShowRedHPLableClick
      end
      object MagicLock: TCheckBox
        Left = 5
        Top = 128
        Width = 69
        Height = 20
        Caption = #39764#27861#38145#23450
        TabOrder = 2
        OnClick = ShowRedHPLableClick
      end
      object DuraAlert: TCheckBox
        Left = 85
        Top = 58
        Width = 71
        Height = 20
        Caption = #25345#20037#35686#21578
        TabOrder = 3
        OnClick = ShowRedHPLableClick
      end
      object AutoDownDrup: TCheckBox
        Left = 7
        Top = 58
        Width = 72
        Height = 20
        Caption = #33258#21160#25918#33647
        TabOrder = 4
        OnClick = ShowRedHPLableClick
      end
      object ShowHPNumber: TCheckBox
        Left = 7
        Top = 39
        Width = 72
        Height = 20
        Caption = #25968#23383#26174#34880
        TabOrder = 5
        OnClick = ShowRedHPLableClick
      end
      object ShowRedHPLable: TCheckBox
        Left = 7
        Top = 2
        Width = 72
        Height = 20
        Caption = #26174#31034#34880#26465
        TabOrder = 6
        OnClick = ShowRedHPLableClick
      end
      object CheckBoxBGSound: TCheckBox
        Left = 7
        Top = 76
        Width = 71
        Height = 20
        Caption = #32972#26223#38899#20048
        TabOrder = 7
        OnClick = CheckBoxBGSoundClick
      end
      object ShowName: TCheckBox
        Left = 85
        Top = 20
        Width = 71
        Height = 20
        Caption = #20154#21517#26174#31034
        TabOrder = 8
        OnClick = ShowRedHPLableClick
      end
      object ShowAllName: TCheckBox
        Left = 85
        Top = 39
        Width = 71
        Height = 20
        Caption = #26174#31034#20840#21517
        TabOrder = 9
        OnClick = ShowRedHPLableClick
      end
      object ShowDura: TCheckBox
        Left = 85
        Top = 76
        Width = 71
        Height = 20
        Caption = #26174#31034#25345#20037
        TabOrder = 10
        OnClick = ShowRedHPLableClick
      end
      object MagicFixupLockF: TRadioButton
        Left = 85
        Top = 128
        Width = 71
        Height = 20
        Caption = #30456#23545#38145#23450
        TabOrder = 11
        OnClick = ShowRedHPLableClick
      end
      object AutoMagicIdx: TComboBox
        Left = 85
        Top = 148
        Width = 72
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        ItemIndex = 0
        TabOrder = 12
        Text = 'F1'
        Items.Strings = (
          'F1'
          'F2'
          'F3'
          'F4'
          'F5'
          'F6'
          'F7'
          'F8'
          'Ctrl+F1'
          'Ctrl+F2'
          'Ctrl+F3'
          'Ctrl+F4'
          'Ctrl+F5'
          'Ctrl+F6'
          'Ctrl+F7'
          'Ctrl+F8')
      end
      object AutoMagicTime: TSpinEdit
        Left = 175
        Top = 148
        Width = 38
        Height = 21
        MaxLength = 10
        MaxValue = 100
        MinValue = 5
        TabOrder = 13
        Value = 5
      end
      object MagicFixupLockT: TRadioButton
        Left = 166
        Top = 128
        Width = 69
        Height = 20
        Caption = #32477#23545#38145#23450
        TabOrder = 14
        OnClick = ShowRedHPLableClick
      end
      object CanRunNpc: TCheckBox
        Left = 168
        Top = 76
        Width = 69
        Height = 20
        Caption = #31359#36807'NPC'
        TabOrder = 15
        OnClick = ShowRedHPLableClick
      end
      object CanRunMon: TCheckBox
        Left = 168
        Top = 58
        Width = 69
        Height = 20
        Caption = #31359#36807#24618#29289
        TabOrder = 16
        OnClick = ShowRedHPLableClick
      end
      object CanRunHuman: TCheckBox
        Left = 168
        Top = 39
        Width = 69
        Height = 20
        Caption = #31359#36807#20154#29289
        TabOrder = 17
        OnClick = ShowRedHPLableClick
      end
      object ShowAllItemFil: TCheckBox
        Left = 168
        Top = 20
        Width = 69
        Height = 20
        Caption = #26174#31034#36807#28388
        TabOrder = 18
        OnClick = ShowRedHPLableClick
      end
      object ShowAllItem: TCheckBox
        Left = 168
        Top = 2
        Width = 69
        Height = 20
        Caption = #26174#31034#29289#21697
        TabOrder = 19
        OnClick = ShowRedHPLableClick
      end
      object ShowTopInfo: TCheckBox
        Left = 85
        Top = 110
        Width = 71
        Height = 20
        Caption = #39030#37096#26174#31034
        TabOrder = 20
        OnClick = ShowRedHPLableClick
      end
      object AutoPuckUpItem: TCheckBox
        Left = 168
        Top = 93
        Width = 69
        Height = 20
        Caption = #33258#21160#25441#29289
        TabOrder = 21
        OnClick = ShowRedHPLableClick
      end
      object ShowBlueMpLable: TCheckBox
        Left = 7
        Top = 20
        Width = 71
        Height = 20
        Caption = #26174#31034#34013#26465
        TabOrder = 22
        OnClick = ShowRedHPLableClick
      end
      object MoveRedShow: TCheckBox
        Left = 85
        Top = 93
        Width = 71
        Height = 20
        Caption = #21435#34880#26174#31034
        TabOrder = 23
        OnClick = ShowRedHPLableClick
      end
      object ParalyCan: TCheckBox
        Left = 7
        Top = 110
        Width = 57
        Height = 20
        Caption = #38450#30707#21270
        TabOrder = 24
        OnClick = ShowRedHPLableClick
      end
      object AutoPuckItemFil: TCheckBox
        Left = 168
        Top = 110
        Width = 69
        Height = 20
        Caption = #25441#21462#36807#28388
        TabOrder = 25
        OnClick = ShowRedHPLableClick
      end
      object ShowGroupMember: TCheckBox
        Left = 85
        Top = 2
        Width = 71
        Height = 20
        Caption = #26174#31034#38431#21592
        TabOrder = 26
        OnClick = ShowRedHPLableClick
      end
      object MoveSlow: TCheckBox
        Left = 7
        Top = 93
        Width = 71
        Height = 20
        Caption = #20813#36127#37325
        TabOrder = 27
        OnClick = ShowRedHPLableClick
      end
      object CheckBoxAutoDownHorse: TCheckBox
        Left = 87
        Top = 169
        Width = 122
        Height = 20
        Caption = #20351#29992#25216#33021#33258#21160#19979#39532
        TabOrder = 28
        OnClick = ShowRedHPLableClick
      end
      object CheckBoxDisableStruck: TCheckBox
        Left = 7
        Top = 169
        Width = 72
        Height = 20
        Caption = #31283#22914#27888#23665
        TabOrder = 29
        OnClick = ShowRedHPLableClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #29289#21697
      ImageIndex = 1
      object PageControl4: TPageControl
        Left = 0
        Top = 0
        Width = 244
        Height = 264
        ActivePage = TabSheet17
        Style = tsButtons
        TabOrder = 0
        object TabSheet16: TTabSheet
          Caption = #36807#28388#35774#32622
          object ShowCropsColor: TLabel
            Left = 147
            Top = 198
            Width = 11
            Height = 16
            AutoSize = False
            Color = clBackground
            ParentColor = False
          end
          object ItemName: TEdit
            Left = 0
            Top = 171
            Width = 116
            Height = 20
            MaxLength = 20
            TabOrder = 0
          end
          object AddItem: TButton
            Left = 122
            Top = 171
            Width = 49
            Height = 21
            Caption = #28155#21152
            TabOrder = 1
            OnClick = ShowRedHPLableClick
          end
          object DelItem: TButton
            Left = 181
            Top = 171
            Width = 49
            Height = 21
            Caption = #21024#38500
            TabOrder = 2
            OnClick = ShowRedHPLableClick
          end
          object EditRedMsgFColor: TSpinEdit
            Left = 102
            Top = 196
            Width = 40
            Height = 21
            EditorEnabled = False
            MaxValue = 255
            MinValue = 0
            TabOrder = 3
            Value = 100
            OnChange = EditRedMsgFColorChange
          end
          object CropsItemShow: TCheckBox
            Left = 0
            Top = 197
            Width = 97
            Height = 17
            Caption = #29305#27530#21464#33394#26174#31034
            TabOrder = 4
            OnClick = ShowRedHPLableClick
          end
          object CropsItemHit: TCheckBox
            Left = 0
            Top = 215
            Width = 97
            Height = 17
            Caption = #29305#27530#29289#21697#25552#31034
            TabOrder = 5
            OnClick = ShowRedHPLableClick
          end
          object ItemList: TListView
            Left = 0
            Top = 1
            Width = 233
            Height = 168
            Columns = <
              item
                Caption = #29289#21697#21517#31216
                Width = 90
              end
              item
                Alignment = taCenter
                Caption = #26174
                Width = 30
              end
              item
                Alignment = taCenter
                Caption = #25441
                Width = 30
              end
              item
                Alignment = taCenter
                Caption = #29305
                Width = 30
              end
              item
                Alignment = taCenter
                Caption = #25552
                Width = 30
              end>
            ColumnClick = False
            GridLines = True
            HotTrack = True
            HotTrackStyles = [htHandPoint, htUnderlineHot]
            ReadOnly = True
            RowSelect = True
            TabOrder = 6
            ViewStyle = vsReport
            OnMouseDown = ItemListMouseDown
          end
        end
        object TabSheet17: TTabSheet
          Caption = #35299#21253#35774#32622
          ImageIndex = 1
          object OpenItemList: TListView
            Left = 0
            Top = 1
            Width = 233
            Height = 155
            Columns = <
              item
                Caption = #29289#21697#21517#31216
                Width = 100
              end
              item
                Caption = #29289#21697#21253#21517#31216
                Width = 100
              end>
            ColumnClick = False
            GridLines = True
            HotTrack = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
          object AutoOpenItem: TCheckBox
            Left = 58
            Top = 178
            Width = 97
            Height = 17
            Caption = #29289#21697#33258#21160#35299#21253
            TabOrder = 1
            OnClick = ShowRedHPLableClick
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #25112#26007
      ImageIndex = 2
      object PageControl2: TPageControl
        Left = -1
        Top = 4
        Width = 242
        Height = 256
        ActivePage = TabSheet11
        Style = tsButtons
        TabOrder = 0
        object TabSheet9: TTabSheet
          Caption = #20445#25252
          object AutoHp: TCheckBox
            Left = 0
            Top = 8
            Width = 33
            Height = 17
            Caption = 'HP'
            TabOrder = 0
            OnClick = ShowRedHPLableClick
          end
          object AutoHpCount: TEdit
            Left = 36
            Top = 7
            Width = 37
            Height = 20
            TabOrder = 1
          end
          object AutoHpName: TComboBox
            Left = 77
            Top = 7
            Width = 99
            Height = 20
            ItemHeight = 12
            TabOrder = 2
            Text = #37329#21019#33647'('#23567#37327')'
            Items.Strings = (
              #37329#21019#33647'('#23567#37327')'
              #37329#21019#33647'('#20013#37327')'
              #24378#25928#37329#21019#33647)
          end
          object AutoCropsHpName: TComboBox
            Left = 77
            Top = 31
            Width = 99
            Height = 20
            ItemHeight = 12
            TabOrder = 3
            Text = #22826#38451#27700
            Items.Strings = (
              #22826#38451#27700
              #24378#25928#22826#38451#27700
              #30103#20260#33647
              #19975#24180#38634#38684)
          end
          object AutoCropsHpCount: TEdit
            Left = 36
            Top = 31
            Width = 37
            Height = 20
            TabOrder = 4
          end
          object AutoCropsHp: TCheckBox
            Left = 0
            Top = 32
            Width = 33
            Height = 17
            Caption = 'HP'
            TabOrder = 5
            OnClick = ShowRedHPLableClick
          end
          object AutoMpName: TComboBox
            Left = 77
            Top = 54
            Width = 99
            Height = 20
            ItemHeight = 12
            TabOrder = 6
            Text = #39764#27861#33647'('#23567#37327')'
            Items.Strings = (
              #39764#27861#33647'('#23567#37327')'
              #39764#27861#33647'('#20013#37327')'
              #24378#25928#39764#27861#33647)
          end
          object AutoMpCount: TEdit
            Left = 36
            Top = 54
            Width = 37
            Height = 20
            TabOrder = 7
          end
          object AutoMp: TCheckBox
            Left = 0
            Top = 55
            Width = 33
            Height = 17
            Caption = 'MP'
            TabOrder = 8
            OnClick = ShowRedHPLableClick
          end
          object AutoCropsMp: TCheckBox
            Left = 0
            Top = 79
            Width = 33
            Height = 17
            Caption = 'MP'
            TabOrder = 9
            OnClick = ShowRedHPLableClick
          end
          object AutoCropsMpCount: TEdit
            Left = 36
            Top = 78
            Width = 37
            Height = 20
            TabOrder = 10
          end
          object AutoCropsMpName: TComboBox
            Left = 77
            Top = 78
            Width = 99
            Height = 20
            ItemHeight = 12
            TabOrder = 11
            Text = #22826#38451#27700
            Items.Strings = (
              #22826#38451#27700
              #24378#25928#22826#38451#27700
              #30103#20260#33647
              #19975#24180#38634#38684)
          end
          object AutoHpProtect: TCheckBox
            Left = 0
            Top = 102
            Width = 33
            Height = 17
            Caption = #20445
            TabOrder = 12
            OnClick = ShowRedHPLableClick
          end
          object AutoHpProtectCount: TEdit
            Left = 36
            Top = 101
            Width = 37
            Height = 20
            TabOrder = 13
          end
          object AutoHpProtectName: TComboBox
            Left = 77
            Top = 101
            Width = 99
            Height = 20
            ItemHeight = 12
            TabOrder = 14
            Text = #38543#26426#20256#36865#21367
            Items.Strings = (
              #38543#26426#20256#36865#21367
              #22320#29282#36867#33073#21367
              #22238#22478#21367
              #34892#20250#22238#22478#21367
              #38543#26426#20256#36865#30707
              #30431#37325#20256#36865#30707
              #27604#22855#20256#36865#30707)
          end
          object AutoHpTick: TSpinEdit
            Left = 179
            Top = 7
            Width = 46
            Height = 21
            MaxValue = 100
            MinValue = 1
            TabOrder = 15
            Value = 1
          end
          object AutoCropsHpTick: TSpinEdit
            Left = 179
            Top = 31
            Width = 46
            Height = 21
            MaxValue = 100
            MinValue = 1
            TabOrder = 16
            Value = 1
          end
          object AutoMpTick: TSpinEdit
            Left = 179
            Top = 55
            Width = 46
            Height = 21
            MaxValue = 100
            MinValue = 1
            TabOrder = 17
            Value = 1
          end
          object AutoCropsMpTick: TSpinEdit
            Left = 179
            Top = 79
            Width = 46
            Height = 21
            MaxValue = 100
            MinValue = 1
            TabOrder = 18
            Value = 1
          end
          object AutoHpOrotectTick: TSpinEdit
            Left = 179
            Top = 101
            Width = 46
            Height = 21
            MaxValue = 100
            MinValue = 1
            TabOrder = 19
            Value = 1
          end
        end
        object TabSheet10: TTabSheet
          Caption = #21151#33021
          ImageIndex = 1
          object Label9: TLabel
            Left = 128
            Top = 32
            Width = 12
            Height = 12
            Caption = #31186
          end
          object AttackEffect: TCheckBox
            Left = 2
            Top = 8
            Width = 73
            Height = 17
            Caption = #25915#20987#25928#26524
            TabOrder = 0
            OnClick = ShowRedHPLableClick
          end
          object AttackEffectClsF: TRadioButton
            Left = 76
            Top = 8
            Width = 65
            Height = 17
            Caption = #21322#26376#25915#20987
            Checked = True
            TabOrder = 1
            TabStop = True
            OnClick = ShowRedHPLableClick
          end
          object AttackEffectClsT: TRadioButton
            Left = 148
            Top = 8
            Width = 65
            Height = 17
            Caption = #28872#28779#25915#20987
            TabOrder = 2
            OnClick = ShowRedHPLableClick
          end
          object ClearMapDieActor: TCheckBox
            Left = 2
            Top = 29
            Width = 71
            Height = 17
            Caption = #28165#29702#25112#22330
            TabOrder = 3
            OnClick = ShowRedHPLableClick
          end
          object FriendHit: TCheckBox
            Left = 114
            Top = 51
            Width = 95
            Height = 17
            Caption = #22909#21451#36817#36523#25552#31034
            TabOrder = 4
            OnClick = ShowRedHPLableClick
          end
          object BlacklistHit: TCheckBox
            Left = 2
            Top = 51
            Width = 108
            Height = 17
            Caption = #40657#21517#21333#36817#36523#25552#31034
            TabOrder = 5
            OnClick = ShowRedHPLableClick
          end
          object BlackListSys: TCheckBox
            Left = 2
            Top = 69
            Width = 108
            Height = 17
            Caption = #36807#28388#40657#21517#21333#21457#35328
            TabOrder = 6
            OnClick = ShowRedHPLableClick
          end
          object CloseShift: TCheckBox
            Left = 148
            Top = 29
            Width = 68
            Height = 17
            Caption = #20813'Shift'
            TabOrder = 7
            OnClick = ShowRedHPLableClick
          end
          object ClearMapDieActorTime: TSpinEdit
            Left = 76
            Top = 27
            Width = 47
            Height = 21
            MaxValue = 100
            MinValue = 1
            TabOrder = 8
            Value = 10
          end
        end
        object TabSheet11: TTabSheet
          Caption = #29305#27530
          ImageIndex = 2
          object GroupBox2: TGroupBox
            Left = 0
            Top = 8
            Width = 234
            Height = 217
            Caption = #29305#27530#24618#29289
            TabOrder = 0
            object CropsMonList: TListBox
              Left = 8
              Top = 16
              Width = 129
              Height = 193
              ItemHeight = 12
              TabOrder = 0
            end
            object EditCrops: TEdit
              Left = 144
              Top = 16
              Width = 81
              Height = 20
              MaxLength = 20
              TabOrder = 1
            end
            object AddCropsMon: TButton
              Left = 144
              Top = 40
              Width = 37
              Height = 23
              Caption = #28155#21152
              TabOrder = 2
              OnClick = ShowRedHPLableClick
            end
            object DelCropsMon: TButton
              Left = 188
              Top = 40
              Width = 37
              Height = 23
              Caption = #21024#38500
              TabOrder = 3
              OnClick = ShowRedHPLableClick
            end
            object CropsMonHit: TCheckBox
              Left = 145
              Top = 72
              Width = 79
              Height = 17
              Caption = #25509#36817#25552#31034
              TabOrder = 4
              OnClick = ShowRedHPLableClick
            end
            object CropsChangeColor: TCheckBox
              Left = 145
              Top = 108
              Width = 79
              Height = 17
              Caption = #21464#33394#26174#31034
              TabOrder = 5
              OnClick = ShowRedHPLableClick
            end
            object CropsAutoLock: TCheckBox
              Left = 145
              Top = 90
              Width = 79
              Height = 17
              Caption = #33258#21160#38145#23450
              TabOrder = 6
              OnClick = ShowRedHPLableClick
            end
            object CropsColorEff: TComboBox
              Left = 144
              Top = 128
              Width = 81
              Height = 20
              Style = csDropDownList
              ItemHeight = 12
              ItemIndex = 8
              TabOrder = 7
              Text = #32043#32418#33394
              OnChange = ShowRedHPLableClick
              Items.Strings = (
                #28784#33394
                #26126#20142
                #40657#33394
                #30333#33394
                #32418#33394
                #32511#33394
                #34013#33394
                #40644#33394
                #32043#32418#33394)
            end
          end
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #32842#22825
      ImageIndex = 3
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 225
        Height = 97
        Caption = #33258#21160#21898#35805
        TabOrder = 0
        object Label8: TLabel
          Left = 9
          Top = 40
          Width = 54
          Height = 12
          Caption = #21898#35805#20869#23481':'
        end
        object Label11: TLabel
          Left = 9
          Top = 65
          Width = 54
          Height = 12
          Caption = #21457#36865#21629#20196':'
        end
        object CheckBoxOpenMsg: TCheckBox
          Left = 9
          Top = 17
          Width = 97
          Height = 17
          Caption = #25171#24320#33258#21160#21898#35805
          TabOrder = 0
          OnClick = CheckBoxOpenMsgClick
        end
        object EditSysMsg: TEdit
          Left = 64
          Top = 37
          Width = 153
          Height = 20
          TabOrder = 1
        end
        object ComboBox1: TComboBox
          Left = 64
          Top = 62
          Width = 105
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          ItemIndex = 0
          TabOrder = 2
          Text = #25298#32477#31169#32842
          Items.Strings = (
            #25298#32477#31169#32842
            #25298#32477#21898#35805
            #25298#32477#20132#26131
            #21152#20837#38376#27966
            #36864#20986#38376#27966
            #25298#32477#34892#20250#32842#22825
            #20801#35768#32852#30431
            #20801#35768#22825#22320#21512#19968
            #20801#35768#34892#20250#21512#19968
            #20801#35768#20256#21796#20276#20387
            #20801#35768#20256#21796#24466#24351)
        end
        object Button1: TButton
          Left = 174
          Top = 62
          Width = 43
          Height = 19
          Caption = #21457#36865
          TabOrder = 3
          OnClick = Button1Click
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #29615#22659
      ImageIndex = 4
      object EntironmentList: TListView
        Left = 1
        Top = 4
        Width = 220
        Height = 232
        Columns = <
          item
            Caption = #21517#31216
            Width = 95
          end
          item
            Alignment = taCenter
            Caption = #26041#20301
            Width = 40
          end
          item
            Alignment = taCenter
            Caption = #22352#26631
            Width = 55
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
      object ShowEntironment: TCheckBox
        Left = 119
        Top = 241
        Width = 97
        Height = 17
        Caption = #21047#26032#21608#22260#20449#24687
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = ShowEntironmentClick
      end
      object EntironmentClass: TComboBox
        Left = 1
        Top = 240
        Width = 110
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        ItemIndex = 0
        TabOrder = 2
        Text = #20840#37096#20449#24687
        Items.Strings = (
          #20840#37096#20449#24687
          #20154#29289#20449#24687
          'NPC'#20449#24687
          #24618#29289#20449#24687)
      end
    end
    object TabSheet6: TTabSheet
      Caption = #32844#19994
      ImageIndex = 5
      object PageControl3: TPageControl
        Left = -2
        Top = 4
        Width = 243
        Height = 256
        ActivePage = TabSheet12
        Style = tsButtons
        TabOrder = 0
        object TabSheet12: TTabSheet
          Caption = #25112#22763
          object CanLongHit: TCheckBox
            Left = 0
            Top = 5
            Width = 68
            Height = 17
            Caption = #20992#20992#21050#26432
            TabOrder = 0
            OnClick = ShowRedHPLableClick
          end
          object CanWideHit: TCheckBox
            Left = 73
            Top = 5
            Width = 68
            Height = 17
            Caption = #26234#33021#21322#26376
            TabOrder = 1
            OnClick = ShowRedHPLableClick
          end
          object CanAutoFireHit: TCheckBox
            Left = 147
            Top = 5
            Width = 68
            Height = 17
            Caption = #33258#21160#28872#28779
            TabOrder = 2
            OnClick = ShowRedHPLableClick
          end
          object CanFireSide: TCheckBox
            Left = 0
            Top = 24
            Width = 68
            Height = 17
            Caption = #28872#28779#36817#36523
            TabOrder = 3
            OnClick = ShowRedHPLableClick
          end
          object CanCrsHit: TCheckBox
            Left = 73
            Top = 24
            Width = 68
            Height = 17
            Caption = #26234#33021#25265#26376
            TabOrder = 4
            OnClick = ShowRedHPLableClick
          end
          object CanLongSword: TCheckBox
            Left = 147
            Top = 24
            Width = 86
            Height = 17
            Caption = #33258#21160#24320#22825#26025
            TabOrder = 5
            OnClick = ShowRedHPLableClick
          end
          object CanLongHit2: TCheckBox
            Left = -1
            Top = 46
            Width = 68
            Height = 17
            Caption = #38548#20301#21050#26432
            TabOrder = 6
            OnClick = ShowRedHPLableClick
          end
          object CanAutoLongFire: TCheckBox
            Left = 73
            Top = 46
            Width = 101
            Height = 17
            Caption = #33258#21160#36880#26085#21073#27861
            TabOrder = 7
            OnClick = ShowRedHPLableClick
          end
        end
        object TabSheet13: TTabSheet
          Caption = #39764#27861#24072
          ImageIndex = 1
          object CanShield: TCheckBox
            Left = 0
            Top = 5
            Width = 68
            Height = 17
            Caption = #33258#21160#24320#30462
            TabOrder = 0
            OnClick = ShowRedHPLableClick
          end
          object CanFirewind: TCheckBox
            Left = 0
            Top = 24
            Width = 68
            Height = 17
            Caption = #25509#36817#25239#25298
            TabOrder = 1
            OnClick = ShowRedHPLableClick
          end
          object CanShieldClsF: TRadioButton
            Left = 80
            Top = 5
            Width = 68
            Height = 17
            Caption = #25345#32493#24320#30462
            Checked = True
            TabOrder = 2
            TabStop = True
            OnClick = ShowRedHPLableClick
          end
          object CanShieldClsT: TRadioButton
            Left = 160
            Top = 5
            Width = 68
            Height = 17
            Caption = #25509#36817#24320#30462
            TabOrder = 3
            OnClick = ShowRedHPLableClick
          end
        end
        object TabSheet14: TTabSheet
          Caption = #36947#22763
          ImageIndex = 2
          object Label10: TLabel
            Left = 205
            Top = 7
            Width = 12
            Height = 12
            Caption = #31186
          end
          object Label12: TLabel
            Left = 132
            Top = 75
            Width = 12
            Height = 12
            Caption = #31186
          end
          object Label13: TLabel
            Left = 132
            Top = 97
            Width = 12
            Height = 12
            Caption = #31186
          end
          object Label6: TLabel
            Left = 132
            Top = 119
            Width = 12
            Height = 12
            Caption = #31186
          end
          object CanAutoAddHp: TCheckBox
            Left = 0
            Top = 5
            Width = 68
            Height = 17
            Caption = #33258#21160#34917#34880
            TabOrder = 0
            OnClick = ShowRedHPLableClick
          end
          object CanAutoAmyounsul: TCheckBox
            Left = 0
            Top = 28
            Width = 68
            Height = 17
            Caption = #33258#21160#27602#31526
            TabOrder = 1
            OnClick = ShowRedHPLableClick
          end
          object CanAmyounsulCls: TComboBox
            Left = 72
            Top = 26
            Width = 57
            Height = 20
            Style = csDropDownList
            ItemHeight = 12
            ItemIndex = 0
            TabOrder = 2
            Text = #32511#27602
            Items.Strings = (
              #32511#27602
              #32418#27602)
          end
          object CanCrossingOver: TCheckBox
            Left = 143
            Top = 27
            Width = 81
            Height = 17
            Caption = #32418#32511#27602#20114#25442
            TabOrder = 3
            OnClick = ShowRedHPLableClick
          end
          object CanAutoAddHpCount: TEdit
            Left = 72
            Top = 4
            Width = 57
            Height = 20
            TabOrder = 4
          end
          object CanCloak: TCheckBox
            Left = 0
            Top = 52
            Width = 68
            Height = 17
            Caption = #33258#21160#38544#36523
            TabOrder = 5
            OnClick = ShowRedHPLableClick
          end
          object CanHolyShield: TCheckBox
            Left = 0
            Top = 73
            Width = 68
            Height = 17
            Caption = #25345#32493#21152#38450
            TabOrder = 6
            OnClick = ShowRedHPLableClick
          end
          object CanHolyShieldTick: TEdit
            Left = 72
            Top = 72
            Width = 57
            Height = 20
            TabOrder = 7
            Text = '200'
          end
          object CanDejiwonhoTick: TEdit
            Left = 72
            Top = 94
            Width = 57
            Height = 20
            TabOrder = 8
            Text = '200'
          end
          object CanDejiwonho: TCheckBox
            Left = 0
            Top = 95
            Width = 68
            Height = 17
            Caption = #25345#32493#21152#39764
            TabOrder = 9
            OnClick = ShowRedHPLableClick
          end
          object CanAttackTick: TEdit
            Left = 72
            Top = 116
            Width = 57
            Height = 20
            TabOrder = 10
            Text = '200'
          end
          object CanAttack: TCheckBox
            Left = 0
            Top = 117
            Width = 68
            Height = 17
            Caption = #25345#32493#21152#25915
            TabOrder = 11
            OnClick = ShowRedHPLableClick
          end
          object CanCloakClsF: TRadioButton
            Left = 72
            Top = 52
            Width = 73
            Height = 17
            Caption = #25345#32493#38544#36523
            TabOrder = 12
            OnClick = ShowRedHPLableClick
          end
          object CanCloakClsT: TRadioButton
            Left = 143
            Top = 52
            Width = 73
            Height = 17
            Caption = #25509#36817#38544#36523
            TabOrder = 13
            OnClick = ShowRedHPLableClick
          end
          object CanAutoAddHpTick: TSpinEdit
            Left = 143
            Top = 4
            Width = 57
            Height = 21
            MaxValue = 100
            MinValue = 4
            TabOrder = 14
            Value = 4
          end
        end
        object TabSheet15: TTabSheet
          Caption = #33521#38596
          ImageIndex = 3
          object CheckBoxWizardShield: TCheckBox
            Left = 8
            Top = 12
            Width = 129
            Height = 17
            Caption = #27861#24072#33521#38596#25345#32493#24320#30462
            Enabled = False
            TabOrder = 0
            OnClick = ShowRedHPLableClick
          end
          object CheckBoxHeroCallBoneFamm: TCheckBox
            Left = 8
            Top = 32
            Width = 66
            Height = 17
            Caption = #21484#21796#39607#39621
            Enabled = False
            TabOrder = 1
            OnClick = RadioSkeletonClick
          end
          object CheckBoxHeroCallDogz: TCheckBox
            Left = 85
            Top = 32
            Width = 66
            Height = 17
            Caption = #21484#21796#31070#20861
            Enabled = False
            TabOrder = 2
            OnClick = RadioSkeletonClick
          end
          object CheckBoxHeroCallFairy: TCheckBox
            Left = 160
            Top = 32
            Width = 66
            Height = 17
            Caption = #21484#21796#26376#28789
            Enabled = False
            TabOrder = 3
            OnClick = RadioSkeletonClick
          end
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = #25346#26426
      ImageIndex = 6
      object Label7: TLabel
        Left = 8
        Top = 16
        Width = 66
        Height = 12
        Caption = #24320#21457#20013'.....'
      end
    end
    object TabSheet8: TTabSheet
      Caption = #24110#21161
      ImageIndex = 7
      object Memo1: TMemo
        Left = 0
        Top = 8
        Width = 239
        Height = 241
        Lines.Strings = (
          '['#24555#25463#20581']'
          ''
          '[~]      '#38190#65306#24555#36895#25441#36215#33050#19979#29289#21697#12290
          ''
          '[Alt+W]  '#38190#65306#23558#25351#23450#20154#29289#21152#20837#32452#38431
          ''
          '[Alt+E]  '#38190#65306#23558#25351#23450#20154#29289#36386#20986#32452#38431
          ''
          '[Alt+S]  '#38190#65306#23558#25351#23450#20154#29289#21152#20837#40657#21517#21333
          '             '#20877#27425#20351#29992#23558#31227#20986#40657#21517#21333
          ''
          '[Alt+F]  '#38190#65306#23558#25351#23450#20154#29289#21152#20837#22909#21451#21517#21333
          '             '#20877#27425#20351#29992#23558#31227#20986#22909#21451#21517#21333
          ''
          '[Alt+R]  '#38190#65306#21047#26032#20154#29289#32972#21253#29289#21697
          ''
          '[Ctrl+M] '#38190#65306#24555#36895#20999#25442#39569#39532#29366#24577)
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object EntironmentTimer: TTimer
    OnTimer = EntironmentTimerTimer
    Left = 148
    Top = 240
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 180
    Top = 240
  end
end
