object FormList2: TFormList2
  Left = 189
  Top = 109
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #21015#34920#20449#24687#20108
  ClientHeight = 393
  ClientWidth = 672
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 657
    Height = 377
    ActivePage = TabSheet10
    TabOrder = 0
    OnChanging = PageControl2Changing
    object TabSheet1: TTabSheet
      Caption = #28216#25103#21151#33021#21015#34920
      object PageControl2: TPageControl
        Left = 0
        Top = 8
        Width = 647
        Height = 340
        ActivePage = TabSheet2
        TabOrder = 0
        OnChanging = PageControl2Changing
        object TabSheet2: TTabSheet
          Caption = #21830#38138#29289#21697#21015#34920
          object Label1: TLabel
            Left = 160
            Top = 219
            Width = 54
            Height = 12
            Caption = #29289#21697#31867#21035':'
          end
          object Label2: TLabel
            Left = 160
            Top = 243
            Width = 54
            Height = 12
            Caption = #29289#21697#21517#31216':'
          end
          object Label3: TLabel
            Left = 160
            Top = 267
            Width = 54
            Height = 12
            Caption = #29289#21697#20215#26684':'
          end
          object Label4: TLabel
            Left = 160
            Top = 291
            Width = 54
            Height = 12
            Caption = #29289#21697#25551#36848':'
          end
          object Label5: TLabel
            Left = 321
            Top = 219
            Width = 60
            Height = 12
            Caption = 'Items'#24207#21495':'
          end
          object Label6: TLabel
            Left = 321
            Top = 243
            Width = 66
            Height = 12
            Caption = 'Effect'#24207#21495':'
          end
          object Label7: TLabel
            Left = 321
            Top = 267
            Width = 66
            Height = 12
            Caption = 'Effect'#25968#37327':'
          end
          object Label8: TLabel
            Left = 477
            Top = 243
            Width = 60
            Height = 12
            Caption = '->'#28436#31034#24207#21495
          end
          object Label9: TLabel
            Left = 477
            Top = 219
            Width = 60
            Height = 12
            Caption = '->'#29289#21697#22270#26631
          end
          object Label10: TLabel
            Left = 477
            Top = 267
            Width = 60
            Height = 12
            Caption = '->'#22270#29255#24352#25968
          end
          object GroupBox4: TGroupBox
            Left = 8
            Top = 8
            Width = 146
            Height = 302
            Caption = #29289#21697#21015#34920'(Ctrl+F'#26597#25214')'
            TabOrder = 0
            object ListBoxitemList: TListBox
              Left = 8
              Top = 16
              Width = 129
              Height = 277
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBoxitemListClck
              OnKeyDown = ListBoxitemListKeyDown
            end
          end
          object ListViewShopList: TListView
            Left = 160
            Top = 13
            Width = 473
            Height = 196
            Columns = <
              item
                Caption = #31867#21035
                Width = 40
              end
              item
                Caption = #29289#21697#21517#31216
                Width = 100
              end
              item
                Caption = 'Item'#24207#21495
                Width = 60
              end
              item
                Caption = #29289#21697#20215#26684
                Width = 60
              end
              item
                Caption = 'Effect'#24207#21495
                Width = 75
              end
              item
                Caption = #22270#29255#25968#37327
                Width = 60
              end
              item
                Caption = #29289#21697#25551#36848
                Width = 200
              end>
            GridLines = True
            RowSelect = True
            TabOrder = 1
            ViewStyle = vsReport
            OnChange = ListViewShopListChange
          end
          object EditName: TEdit
            Left = 216
            Top = 240
            Width = 99
            Height = 20
            TabOrder = 2
          end
          object EditText: TEdit
            Left = 216
            Top = 288
            Width = 255
            Height = 20
            MaxLength = 127
            TabOrder = 3
            Text = #29289#21697#21151#33021'|'#29289#21697#35814#32454#35828#26126#19968'|'#29289#21697#35814#32454#35828#26126#20108
          end
          object ButtonAdd: TButton
            Left = 558
            Top = 216
            Width = 75
            Height = 20
            Caption = #22686#21152'(&A)'
            Enabled = False
            TabOrder = 4
            OnClick = ButtonAddClick
          end
          object ButtonDel: TButton
            Left = 558
            Top = 240
            Width = 75
            Height = 20
            Caption = #21024#38500'(&D)'
            Enabled = False
            TabOrder = 5
            OnClick = ButtonDelClick
          end
          object ButtonSave: TButton
            Left = 558
            Top = 290
            Width = 75
            Height = 20
            Caption = #20445#23384'(&S)'
            TabOrder = 6
            OnClick = ButtonSaveClick
          end
          object ButtonRefur: TButton
            Left = 477
            Top = 290
            Width = 75
            Height = 20
            Caption = #37325#21152#36733'(&R)'
            TabOrder = 7
            OnClick = ButtonRefurClick
          end
          object SpinEditPrice: TSpinEdit
            Left = 216
            Top = 264
            Width = 99
            Height = 21
            MaxValue = 0
            MinValue = 0
            TabOrder = 8
            Value = 1
          end
          object SpinEditItems: TSpinEdit
            Left = 392
            Top = 216
            Width = 79
            Height = 21
            MaxValue = 0
            MinValue = 0
            TabOrder = 9
            Value = 100
          end
          object SpinEditEffectID: TSpinEdit
            Left = 392
            Top = 240
            Width = 79
            Height = 21
            MaxValue = 0
            MinValue = 0
            TabOrder = 10
            Value = 380
          end
          object SpinEditEffectCount: TSpinEdit
            Left = 392
            Top = 264
            Width = 79
            Height = 21
            MaxValue = 0
            MinValue = 0
            TabOrder = 11
            Value = 1
          end
          object ComboBoxClass: TComboBox
            Left = 216
            Top = 216
            Width = 99
            Height = 20
            Style = csDropDownList
            ItemHeight = 12
            ItemIndex = 0
            TabOrder = 12
            Text = #35013#39280
            Items.Strings = (
              #35013#39280
              #34917#32473
              #24378#21270
              #22909#21451
              #38480#37327
              #22855#29645)
          end
          object ButtonEdit: TButton
            Left = 558
            Top = 264
            Width = 75
            Height = 20
            Caption = #20462#25913'(&E)'
            Enabled = False
            TabOrder = 13
            OnClick = ButtonEditClick
          end
        end
        object TabSheet3: TTabSheet
          Caption = #33521#38596#25441#21462#29289#21697#21015#34920
          ImageIndex = 1
          object GroupBox1: TGroupBox
            Left = 8
            Top = 8
            Width = 161
            Height = 302
            Caption = #29289#21697#21015#34920
            TabOrder = 0
            object ListBoxHeroItems: TListBox
              Left = 8
              Top = 16
              Width = 145
              Height = 277
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBoxHeroItemsClick
            end
          end
          object ButtonHeroPickAdd: TButton
            Left = 178
            Top = 14
            Width = 75
            Height = 25
            Caption = #22686#21152'(&A)'
            Enabled = False
            TabOrder = 1
            OnClick = ButtonHeroPickAddClick
          end
          object ButtonHeroPickDelete: TButton
            Left = 178
            Top = 46
            Width = 75
            Height = 25
            Caption = #21024#38500'(&D)'
            Enabled = False
            TabOrder = 2
            OnClick = ButtonHeroPickDeleteClick
          end
          object ButtonHeroPickAddAll: TButton
            Left = 178
            Top = 78
            Width = 75
            Height = 25
            Caption = #20840#37096#22686#21152'(&A)'
            TabOrder = 3
            OnClick = ButtonHeroPickAddAllClick
          end
          object ButtonHeroPickDeleteAll: TButton
            Left = 178
            Top = 110
            Width = 75
            Height = 25
            Caption = #20840#37096#21024#38500'(&D)'
            TabOrder = 4
            OnClick = ButtonHeroPickDeleteAllClick
          end
          object ButtonHeroPickSave: TButton
            Left = 178
            Top = 142
            Width = 75
            Height = 25
            Caption = #20445#23384'(&S)'
            TabOrder = 5
            OnClick = ButtonHeroPickSaveClick
          end
          object GroupBox2: TGroupBox
            Left = 264
            Top = 8
            Width = 161
            Height = 302
            Caption = #21487#20197#25441#21462#29289#21697#21015#34920
            TabOrder = 6
            object ListBoxHeroPickList: TListBox
              Left = 8
              Top = 16
              Width = 145
              Height = 277
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBoxHeroPickListClick
            end
          end
        end
        object TabSheet4: TTabSheet
          Caption = #20801#35768#21319#32423#35013#22791#21015#34920
          ImageIndex = 2
          object GroupBox3: TGroupBox
            Left = 264
            Top = 8
            Width = 161
            Height = 302
            Caption = #21487#20197#21319#32423#35013#22791#21015#34920
            TabOrder = 0
            object stLevelItems: TListBox
              Left = 8
              Top = 16
              Width = 145
              Height = 277
              ItemHeight = 12
              TabOrder = 0
              OnClick = stLevelItemsClick
            end
          end
          object LevelItemAdd: TButton
            Left = 178
            Top = 14
            Width = 75
            Height = 25
            Caption = #22686#21152'(&A)'
            Enabled = False
            TabOrder = 1
            OnClick = LevelItemAddClick
          end
          object LevelItemDel: TButton
            Left = 178
            Top = 46
            Width = 75
            Height = 25
            Caption = #21024#38500'(&D)'
            Enabled = False
            TabOrder = 2
            OnClick = LevelItemDelClick
          end
          object LevelItemAllAdd: TButton
            Left = 178
            Top = 78
            Width = 75
            Height = 25
            Caption = #20840#37096#22686#21152'(&A)'
            TabOrder = 3
            OnClick = LevelItemAllAddClick
          end
          object LevelItemAllDel: TButton
            Left = 178
            Top = 110
            Width = 75
            Height = 25
            Caption = #20840#37096#21024#38500'(&D)'
            TabOrder = 4
            OnClick = LevelItemAllDelClick
          end
          object LevelItemSave: TButton
            Left = 178
            Top = 142
            Width = 75
            Height = 25
            Caption = #20445#23384'(&S)'
            TabOrder = 5
            OnClick = LevelItemSaveClick
          end
          object GroupBox5: TGroupBox
            Left = 8
            Top = 8
            Width = 161
            Height = 302
            Caption = #29289#21697#21015#34920
            TabOrder = 6
            object ListBoxHeroItems2: TListBox
              Left = 8
              Top = 16
              Width = 145
              Height = 277
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBoxHeroItems2Click
            end
          end
        end
        object TabSheet5: TTabSheet
          Caption = #20801#35768#23492#21806#29289#21697#21015#34920
          ImageIndex = 3
          object GroupBox6: TGroupBox
            Left = 8
            Top = 8
            Width = 161
            Height = 302
            Caption = #29289#21697#21015#34920
            TabOrder = 0
            object ListBoxItemList3: TListBox
              Left = 8
              Top = 16
              Width = 145
              Height = 277
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBoxItemList3Click
            end
          end
          object GroupBox7: TGroupBox
            Left = 264
            Top = 8
            Width = 161
            Height = 302
            Caption = #21487#20197#23492#21806#29289#21697#21015#34920
            TabOrder = 1
            object ListBoxSellItemList: TListBox
              Left = 8
              Top = 16
              Width = 145
              Height = 277
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBoxSellItemListClick
            end
          end
          object SellAdd: TButton
            Left = 178
            Top = 14
            Width = 75
            Height = 25
            Caption = #22686#21152'(&A)'
            Enabled = False
            TabOrder = 2
            OnClick = SellAddClick
          end
          object SellDel: TButton
            Left = 178
            Top = 46
            Width = 75
            Height = 25
            Caption = #21024#38500'(&D)'
            Enabled = False
            TabOrder = 3
            OnClick = SellDelClick
          end
          object SellAllAdd: TButton
            Left = 178
            Top = 78
            Width = 75
            Height = 25
            Caption = #20840#37096#22686#21152'(&A)'
            TabOrder = 4
            OnClick = SellAllAddClick
          end
          object SellAllDel: TButton
            Left = 178
            Top = 110
            Width = 75
            Height = 25
            Caption = #20840#37096#21024#38500'(&D)'
            TabOrder = 5
            OnClick = SellAllDelClick
          end
          object SellSave: TButton
            Left = 178
            Top = 142
            Width = 75
            Height = 25
            Caption = #20445#23384'(&S)'
            TabOrder = 6
            OnClick = SellSaveClick
          end
        end
        object TabSheet7: TTabSheet
          Caption = #36807#28388#23383#31526
          ImageIndex = 4
          object GroupBox10: TGroupBox
            Left = 8
            Top = 8
            Width = 161
            Height = 302
            Caption = #23383#31526#21015#34920
            TabOrder = 0
            object ListBoxFilterList: TListBox
              Left = 8
              Top = 16
              Width = 145
              Height = 277
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBoxFilterListClick
            end
          end
          object ButtonFilterAdd: TButton
            Left = 178
            Top = 14
            Width = 75
            Height = 25
            Caption = #22686#21152'(&A)'
            TabOrder = 1
            OnClick = ButtonFilterAddClick
          end
          object ButtonFilterDel: TButton
            Left = 178
            Top = 46
            Width = 75
            Height = 25
            Caption = #21024#38500'(&D)'
            Enabled = False
            TabOrder = 2
            OnClick = ButtonFilterDelClick
          end
          object ButtonFilterSave: TButton
            Left = 178
            Top = 78
            Width = 75
            Height = 25
            Caption = #20445#23384'(&S)'
            TabOrder = 3
            OnClick = ButtonFilterSaveClick
          end
        end
        object TabSheet8: TTabSheet
          Caption = #27515#20129#28040#22833#29289#21697
          ImageIndex = 5
          object GroupBox11: TGroupBox
            Left = 8
            Top = 8
            Width = 161
            Height = 302
            Caption = #29289#21697#21015#34920
            TabOrder = 0
            object ListBox1: TListBox
              Left = 8
              Top = 16
              Width = 145
              Height = 277
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBox1Click
            end
          end
          object DieDisapAdd: TButton
            Left = 178
            Top = 14
            Width = 75
            Height = 25
            Caption = #22686#21152'(&A)'
            Enabled = False
            TabOrder = 1
            OnClick = DieDisapAddClick
          end
          object DieDisapDel: TButton
            Left = 178
            Top = 46
            Width = 75
            Height = 25
            Caption = #21024#38500'(&D)'
            Enabled = False
            TabOrder = 2
            OnClick = DieDisapDelClick
          end
          object DieDisapAddAll: TButton
            Left = 178
            Top = 78
            Width = 75
            Height = 25
            Caption = #20840#37096#22686#21152'(&A)'
            TabOrder = 3
            OnClick = DieDisapAddAllClick
          end
          object DieDisapDelAll: TButton
            Left = 178
            Top = 110
            Width = 75
            Height = 25
            Caption = #20840#37096#21024#38500'(&D)'
            TabOrder = 4
            OnClick = DieDisapDelAllClick
          end
          object DieDisapSave: TButton
            Left = 178
            Top = 142
            Width = 75
            Height = 25
            Caption = #20445#23384'(&S)'
            TabOrder = 5
            OnClick = DieDisapSaveClick
          end
          object GroupBox12: TGroupBox
            Left = 264
            Top = 8
            Width = 161
            Height = 302
            Caption = #27515#20129#28040#22833#29289#21697#21015#34920
            TabOrder = 6
            object ListBoxDieDisapItems: TListBox
              Left = 8
              Top = 16
              Width = 145
              Height = 277
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBoxDieDisapItemsClick
            end
          end
        end
        object TabSheet9: TTabSheet
          Caption = #19979#32447#28040#22833#29289#21697
          ImageIndex = 6
          object GroupBox13: TGroupBox
            Left = 8
            Top = 8
            Width = 161
            Height = 302
            Caption = #29289#21697#21015#34920
            TabOrder = 0
            object ListBox3: TListBox
              Left = 8
              Top = 16
              Width = 145
              Height = 277
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBox3Click
            end
          end
          object GhostDisapAdd: TButton
            Left = 178
            Top = 14
            Width = 75
            Height = 25
            Caption = #22686#21152'(&A)'
            Enabled = False
            TabOrder = 1
            OnClick = GhostDisapAddClick
          end
          object GhostDisapDel: TButton
            Left = 178
            Top = 46
            Width = 75
            Height = 25
            Caption = #21024#38500'(&D)'
            Enabled = False
            TabOrder = 2
            OnClick = GhostDisapDelClick
          end
          object GhostDisapAddAll: TButton
            Left = 178
            Top = 78
            Width = 75
            Height = 25
            Caption = #20840#37096#22686#21152'(&A)'
            TabOrder = 3
            OnClick = GhostDisapAddAllClick
          end
          object GhostDisapDelAll: TButton
            Left = 178
            Top = 110
            Width = 75
            Height = 25
            Caption = #20840#37096#21024#38500'(&D)'
            TabOrder = 4
            OnClick = GhostDisapDelAllClick
          end
          object GhostDisapSave: TButton
            Left = 178
            Top = 142
            Width = 75
            Height = 25
            Caption = #20445#23384'(&S)'
            TabOrder = 5
            OnClick = GhostDisapSaveClick
          end
          object GroupBox14: TGroupBox
            Left = 264
            Top = 8
            Width = 161
            Height = 302
            Caption = #19979#32447#28040#22833#29289#21697#21015#34920
            TabOrder = 6
            object ListBoxGhostDisapItems: TListBox
              Left = 8
              Top = 16
              Width = 145
              Height = 277
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBoxGhostDisapItemsClick
            end
          end
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = #22871#35013#29289#21697
      ImageIndex = 1
      object Label44: TLabel
        Left = 8
        Top = 296
        Width = 281
        Height = 49
        AutoSize = False
        Caption = 
          #37325#35201#35828#26126#65306#22871#35013#29289#21697#19981#19968#23450#35201#36319#22871#35013#25968#37327#30456#31561#65292#20363#22914#65306#22871#35013#25968#37327#35774#32622#20026'2'#65292#22871#35013#29289#21697#35774#32622#20026#25163#38255#65292#21482#35201#24102#21452#25163#38255#26082#35302#21457#12290#21482#25345#21333#20214#35013#22791#26080#38480#21046#20351#29992 +
          #12290#20363#22914#65306#22307#25112#25163#38255#21152#22836#30420#19968#22871#65292#22307#25112#25163#38255#21152#39033#38142#21448#26159#19968#22871
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object GroupBox8: TGroupBox
        Left = 288
        Top = 8
        Width = 353
        Height = 308
        Caption = #38468#21152#23646#24615#35774#32622
        TabOrder = 0
        object Label11: TLabel
          Left = 8
          Top = 21
          Width = 42
          Height = 12
          Caption = 'HP'#19978#38480':'
        end
        object Label12: TLabel
          Left = 8
          Top = 45
          Width = 54
          Height = 12
          Caption = #25915#20987#19978#38480':'
        end
        object Label13: TLabel
          Left = 120
          Top = 21
          Width = 42
          Height = 12
          Caption = 'MP'#19978#38480':'
        end
        object Label14: TLabel
          Left = 120
          Top = 45
          Width = 54
          Height = 12
          Caption = #25915#20987#19979#38480':'
        end
        object Label15: TLabel
          Left = 120
          Top = 69
          Width = 54
          Height = 12
          Caption = #39764#27861#19979#38480':'
        end
        object Label16: TLabel
          Left = 8
          Top = 69
          Width = 54
          Height = 12
          Caption = #39764#27861#19978#38480':'
        end
        object Label17: TLabel
          Left = 8
          Top = 93
          Width = 54
          Height = 12
          Caption = #36947#26415#19978#38480':'
        end
        object Label18: TLabel
          Left = 120
          Top = 93
          Width = 54
          Height = 12
          Caption = #36947#26415#19979#38480':'
        end
        object Label19: TLabel
          Left = 8
          Top = 117
          Width = 54
          Height = 12
          Caption = #38450#24481#19978#38480':'
        end
        object Label20: TLabel
          Left = 120
          Top = 117
          Width = 54
          Height = 12
          Caption = #38450#24481#19979#38480':'
        end
        object Label21: TLabel
          Left = 120
          Top = 141
          Width = 54
          Height = 12
          Caption = #39764#24481#19979#38480':'
        end
        object Label22: TLabel
          Left = 8
          Top = 141
          Width = 54
          Height = 12
          Caption = #39764#24481#19978#38480':'
        end
        object Label23: TLabel
          Left = 232
          Top = 45
          Width = 54
          Height = 12
          Caption = #25915#20987#20493#25968':'
        end
        object Label24: TLabel
          Left = 232
          Top = 69
          Width = 54
          Height = 12
          Caption = #39764#27861#20493#25968':'
        end
        object Label25: TLabel
          Left = 232
          Top = 93
          Width = 54
          Height = 12
          Caption = #36947#26415#20493#25968':'
        end
        object Label26: TLabel
          Left = 232
          Top = 117
          Width = 54
          Height = 12
          Caption = #38450#24481#20493#25968':'
        end
        object Label27: TLabel
          Left = 232
          Top = 141
          Width = 54
          Height = 12
          Caption = #39764#24481#20493#25968':'
        end
        object Label28: TLabel
          Left = 8
          Top = 237
          Width = 54
          Height = 12
          Caption = #25252#36523#23646#24615':'
        end
        object Label29: TLabel
          Left = 120
          Top = 237
          Width = 54
          Height = 12
          Caption = #22797#27963#23646#24615':'
        end
        object Label30: TLabel
          Left = 232
          Top = 237
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
        end
        object Label31: TLabel
          Left = 120
          Top = 165
          Width = 30
          Height = 12
          Caption = #25935#25463':'
        end
        object Label32: TLabel
          Left = 8
          Top = 165
          Width = 30
          Height = 12
          Caption = #20934#30830':'
        end
        object Label33: TLabel
          Left = 232
          Top = 165
          Width = 54
          Height = 12
          Caption = #39764#27861#36530#36991':'
        end
        object Label34: TLabel
          Left = 232
          Top = 21
          Width = 54
          Height = 12
          Caption = #32463#39564#20493#25968':'
        end
        object Label35: TLabel
          Left = 232
          Top = 189
          Width = 54
          Height = 12
          Caption = #27602#29289#36530#36991':'
        end
        object Label36: TLabel
          Left = 8
          Top = 189
          Width = 54
          Height = 12
          Caption = #20307#21147#24674#22797':'
        end
        object Label37: TLabel
          Left = 120
          Top = 189
          Width = 54
          Height = 12
          Caption = #39764#27861#24674#22797':'
        end
        object Label38: TLabel
          Left = 232
          Top = 213
          Width = 54
          Height = 12
          Caption = #20013#27602#24674#22797':'
        end
        object Label39: TLabel
          Left = 8
          Top = 213
          Width = 54
          Height = 12
          Caption = #40635#30201#23646#24615':'
        end
        object Label40: TLabel
          Left = 120
          Top = 213
          Width = 54
          Height = 12
          Caption = #29190#29575#26426#29575':'
        end
        object Label41: TLabel
          Left = 8
          Top = 261
          Width = 54
          Height = 12
          Caption = #22871#35013#25968#37327':'
        end
        object Label42: TLabel
          Left = 8
          Top = 285
          Width = 54
          Height = 12
          Caption = #22871#35013#29289#21697':'
        end
        object Label43: TLabel
          Left = 120
          Top = 261
          Width = 54
          Height = 12
          Caption = #22871#35013#35828#26126':'
        end
        object EditHP: TSpinEdit
          Left = 66
          Top = 17
          Width = 52
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditDC: TSpinEdit
          Left = 66
          Top = 41
          Width = 52
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditMP: TSpinEdit
          Left = 178
          Top = 17
          Width = 52
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditDC2: TSpinEdit
          Left = 178
          Top = 41
          Width = 52
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditMC2: TSpinEdit
          Left = 178
          Top = 65
          Width = 52
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 4
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditMC: TSpinEdit
          Left = 66
          Top = 65
          Width = 52
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 5
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditSC: TSpinEdit
          Left = 66
          Top = 89
          Width = 52
          Height = 21
          Color = clWhite
          MaxValue = 65535
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditSC2: TSpinEdit
          Left = 178
          Top = 89
          Width = 52
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 7
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditAC: TSpinEdit
          Left = 66
          Top = 113
          Width = 52
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 8
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditAC2: TSpinEdit
          Left = 178
          Top = 113
          Width = 52
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 9
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditMAC2: TSpinEdit
          Left = 178
          Top = 137
          Width = 52
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 10
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditMAC: TSpinEdit
          Left = 66
          Top = 137
          Width = 52
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 11
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditDCExp: TSpinEdit
          Left = 290
          Top = 41
          Width = 52
          Height = 21
          Hint = #35813#20540#38500#20197'10'#20026#23454#38469#20493#25968#12290#20540#20026'10'#21017#34920#31034'1'#20493#65292#19978#38480#21644#19979#38480#21516#26102#32763#20493#12290
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 12
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditMCExp: TSpinEdit
          Left = 290
          Top = 65
          Width = 52
          Height = 21
          Hint = #35813#20540#38500#20197'10'#20026#23454#38469#20493#25968#12290#20540#20026'10'#21017#34920#31034'1'#20493#65292#19978#38480#21644#19979#38480#21516#26102#32763#20493#12290
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 13
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditSCExp: TSpinEdit
          Left = 290
          Top = 89
          Width = 52
          Height = 21
          Hint = #35813#20540#38500#20197'10'#20026#23454#38469#20493#25968#12290#20540#20026'10'#21017#34920#31034'1'#20493#65292#19978#38480#21644#19979#38480#21516#26102#32763#20493#12290
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 14
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditACExp: TSpinEdit
          Left = 290
          Top = 113
          Width = 52
          Height = 21
          Hint = #35813#20540#38500#20197'10'#20026#23454#38469#20493#25968#12290#20540#20026'10'#21017#34920#31034'1'#20493#65292#19978#38480#21644#19979#38480#21516#26102#32763#20493#12290
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 15
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditMACExp: TSpinEdit
          Left = 290
          Top = 137
          Width = 52
          Height = 21
          Hint = #35813#20540#38500#20197'10'#20026#23454#38469#20493#25968#12290#20540#20026'10'#21017#34920#31034'1'#20493#65292#19978#38480#21644#19979#38480#21516#26102#32763#20493#12290
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 16
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object seEditSpinMagicShield: TSpinEdit
          Left = 66
          Top = 233
          Width = 52
          Height = 21
          MaxValue = 1
          MinValue = 0
          TabOrder = 17
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object seEditSpinRevival: TSpinEdit
          Left = 178
          Top = 233
          Width = 52
          Height = 21
          MaxValue = 1
          MinValue = 0
          TabOrder = 18
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object SpinEdit29: TSpinEdit
          Left = 290
          Top = 233
          Width = 52
          Height = 21
          Enabled = False
          MaxValue = 65535
          MinValue = 0
          TabOrder = 19
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditSpeedPoint: TSpinEdit
          Left = 178
          Top = 161
          Width = 52
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 20
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditHitPoint: TSpinEdit
          Left = 66
          Top = 161
          Width = 52
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 21
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditAntiMagic: TSpinEdit
          Left = 290
          Top = 161
          Width = 52
          Height = 21
          Hint = #35774#32622'1'#28857#20195#34920#22686#21152'%10'
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 22
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditExp: TSpinEdit
          Left = 290
          Top = 17
          Width = 52
          Height = 21
          Hint = #35813#20540#38500#20197'10'#20026#23454#38469#20493#25968#12290#20540#20026'10'#21017#34920#31034'1'#20493
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 23
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditAntiPoison: TSpinEdit
          Left = 290
          Top = 185
          Width = 52
          Height = 21
          Hint = #35774#32622'1'#28857#20195#34920#22686#21152'%10'
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 24
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditHealthRecover: TSpinEdit
          Left = 66
          Top = 185
          Width = 52
          Height = 21
          Hint = #35774#32622'1'#28857#20195#34920#22686#21152'%10'
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 25
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditSpellRecover: TSpinEdit
          Left = 178
          Top = 185
          Width = 52
          Height = 21
          Hint = #35774#32622'1'#28857#20195#34920#22686#21152'%10'
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 26
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditPoisonRecover: TSpinEdit
          Left = 290
          Top = 209
          Width = 52
          Height = 21
          Hint = #35774#32622'1'#28857#20195#34920#22686#21152'%10'
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 27
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object seEditSpinParalysis: TSpinEdit
          Left = 66
          Top = 209
          Width = 52
          Height = 21
          MaxValue = 1
          MinValue = 0
          TabOrder = 28
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object SpinEdit25: TSpinEdit
          Left = 179
          Top = 207
          Width = 52
          Height = 21
          Hint = #29190#26426#26426#29575#65292#35813#26426#29575#21487#20197#32047#21152#65292#20540#20026'0.200'#65292#25968#20540#36234#22823#26426#29575#36234#22823#12290
          MaxValue = 200
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 29
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditSuitCount: TSpinEdit
          Left = 66
          Top = 257
          Width = 52
          Height = 21
          Hint = #35302#21457#35813#22871#35013#23646#24615#25152#38656#22871#35013#29289#21697#25968#37327#12290
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 30
          Value = 0
          OnChange = EditSuitItemsChange
        end
        object EditSuitItems: TEdit
          Left = 66
          Top = 281
          Width = 279
          Height = 20
          Hint = #31526#21512#35813#22871#35013#30340#29289#21697#21517#31216#65292#20351#29992' | '#20026#20998#38548#31526#65292#22914#65306' '#35013#22791#19968'|'#35013#22791#20108
          ParentShowHint = False
          ShowHint = True
          TabOrder = 31
          Text = #35013#22791#19968'|'#35013#22791#20108
          OnChange = EditSuitItemsChange
        end
        object EditSuitHint: TEdit
          Left = 178
          Top = 257
          Width = 167
          Height = 20
          Hint = #38468#21152#35828#26126#65292#26041#20415#21306#20998#22871#35013#29992#36884#12290
          ParentShowHint = False
          ShowHint = True
          TabOrder = 32
          OnChange = EditSuitItemsChange
        end
      end
      object ButtonSuitSave: TButton
        Left = 565
        Top = 320
        Width = 75
        Height = 25
        Caption = #20445#23384'(&S)'
        Enabled = False
        TabOrder = 1
        OnClick = ButtonSuitSaveClick
      end
      object GroupBox9: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 281
        Caption = #22871#35013#21015#34920
        TabOrder = 2
        object ListViewSuit: TListView
          Left = 8
          Top = 16
          Width = 257
          Height = 257
          Columns = <
            item
              Caption = #24207#21495
              Width = 40
            end
            item
              Caption = #22871#35013#35828#26126
              Width = 120
            end
            item
              Caption = #25968#37327
              Width = 40
            end
            item
              Caption = #22871#35013#29289#21697
              Width = 200
            end
            item
              Caption = #23646#24615
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnChange = ListViewSuitChange
        end
      end
      object ButtonSuitEdit: TButton
        Left = 485
        Top = 320
        Width = 75
        Height = 25
        Caption = #20462#25913'(&E)'
        Enabled = False
        TabOrder = 3
        OnClick = ButtonSuitEditClick
      end
      object ButtonSuitDel: TButton
        Left = 405
        Top = 320
        Width = 75
        Height = 25
        Caption = #21024#38500'(&D)'
        Enabled = False
        TabOrder = 4
        OnClick = ButtonSuitDelClick
      end
      object ButtonSuitAdd: TButton
        Left = 325
        Top = 320
        Width = 75
        Height = 25
        Caption = #22686#21152'(&A)'
        Enabled = False
        TabOrder = 5
        OnClick = ButtonSuitAddClick
      end
    end
    object TabSheet10: TTabSheet
      Caption = #29289#21697#35268#21017
      ImageIndex = 2
      object GroupBox15: TGroupBox
        Left = 8
        Top = 8
        Width = 177
        Height = 337
        Caption = #29289#21697#21015#34920
        TabOrder = 0
        object ListBoxItem: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 313
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxItemClick
        end
      end
      object GroupBox16: TGroupBox
        Left = 376
        Top = 7
        Width = 177
        Height = 337
        Caption = #35268#21017#29289#21697#21015#34920
        TabOrder = 1
        object ListBoxRuleItems: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 313
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxRuleItemsClick
        end
      end
      object GroupBox17: TGroupBox
        Left = 192
        Top = 8
        Width = 177
        Height = 337
        Caption = #35268#21017#35774#32622
        TabOrder = 2
        object Label45: TLabel
          Left = 9
          Top = 23
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object EditRuleName: TEdit
          Left = 65
          Top = 19
          Width = 101
          Height = 20
          TabOrder = 0
        end
        object GroupBox18: TGroupBox
          Left = 8
          Top = 48
          Width = 161
          Height = 201
          Caption = #29289#21697#35268#21017#23646#24615
          TabOrder = 1
          object CheckBoxMake: TCheckBox
            Left = 8
            Top = 17
            Width = 66
            Height = 17
            Hint = #36873#20013#35813#39033#65292#29289#21697#25172#12289#25441#21017#36827#34892#33050#26412#35302#21457
            Caption = #35302#21457#25552#31034
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
          object CheckBoxDeal: TCheckBox
            Left = 88
            Top = 17
            Width = 66
            Height = 17
            Caption = #31105#27490#20132#26131
            TabOrder = 1
          end
          object CheckBoxDropDown: TCheckBox
            Left = 88
            Top = 34
            Width = 66
            Height = 17
            Caption = #31105#27490#25172#25481
            TabOrder = 2
          end
          object CheckBoxSave: TCheckBox
            Left = 88
            Top = 51
            Width = 66
            Height = 17
            Caption = #31105#27490#23384#20179
            TabOrder = 3
          end
          object CheckBoxTakeOff: TCheckBox
            Left = 8
            Top = 34
            Width = 66
            Height = 17
            Caption = #31105#27490#21462#19979
            TabOrder = 4
          end
          object CheckBoxSell: TCheckBox
            Left = 8
            Top = 51
            Width = 66
            Height = 17
            Caption = #31105#27490#20986#21806
            TabOrder = 5
          end
          object CheckBoxDeath: TCheckBox
            Left = 8
            Top = 101
            Width = 66
            Height = 17
            Caption = #27515#20129#25481#33853
            TabOrder = 6
          end
          object CheckBoxBoxs: TCheckBox
            Left = 88
            Top = 68
            Width = 66
            Height = 17
            Hint = #36873#20013#35813#39033#65292#29289#21697#25171#24320#23453#31665#33719#24471#26102#21521#20840#26381#21457#36865#25552#31034#12290#25552#31034#25991#20214#22312'Strings.ini'#20013#20462#25913#12290
            Caption = #23453#31665#25552#31034
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
          end
          object CheckBoxGhost: TCheckBox
            Left = 8
            Top = 84
            Width = 66
            Height = 17
            Caption = #19979#32447#25481#33853
            TabOrder = 8
          end
          object CheckBoxPlaySell: TCheckBox
            Left = 88
            Top = 85
            Width = 66
            Height = 17
            Caption = #31105#27490#25670#25674
            TabOrder = 9
          end
          object CheckBoxResell: TCheckBox
            Left = 8
            Top = 68
            Width = 66
            Height = 17
            Caption = #31105#27490#20462#29702
            TabOrder = 10
          end
          object CheckBoxNoDrop: TCheckBox
            Left = 88
            Top = 101
            Width = 66
            Height = 17
            Hint = #36873#20013#35813#39033#65292#35813#29289#21697#27515#20129#19981#25481#33853#12290
            Caption = #27704#19981#25481#33853
            ParentShowHint = False
            ShowHint = True
            TabOrder = 11
          end
          object CheckBoxDropHint: TCheckBox
            Left = 8
            Top = 117
            Width = 66
            Height = 17
            Hint = #36873#20013#35813#39033#65292#29289#21697#25481#33853#21040#22320#19978#26102#21521#20840#26381#21457#21521#22352#26631#25552#31034#12290#25552#31034#25991#20214#22312'Strings.ini'#20013#20462#25913#12290
            Caption = #25481#33853#25552#31034
            ParentShowHint = False
            ShowHint = True
            TabOrder = 12
          end
          object CheckBoxNoLevel: TCheckBox
            Left = 88
            Top = 117
            Width = 66
            Height = 17
            Hint = #35813#36873#39033#20165#29992#20110#27801#24052#20811#27494#22120#21319#32423#65292#31105#27490#21319#32423#30340#27494#22120#35774#32622#12290
            Caption = #31105#27490#21319#32423
            ParentShowHint = False
            ShowHint = True
            TabOrder = 13
          end
          object CheckBoxButchItem: TCheckBox
            Left = 8
            Top = 133
            Width = 66
            Height = 17
            Hint = #36873#20013#35813#39033#65292#20174#24618#29289#25110#20154#22411#24618#36523#19978#25366#21040#25351#23450#29289#21697#26102#36827#34892#20840#26381#25552#31034#12290#25552#31034#25991#20214#22312'Strings.ini'#20013#20462#25913#12290
            Caption = #25366#21462#25552#31034
            ParentShowHint = False
            ShowHint = True
            TabOrder = 14
          end
          object CheckBoxHeroBag: TCheckBox
            Left = 88
            Top = 133
            Width = 66
            Height = 17
            Hint = #29289#21697#31105#27490#25918#21040#33521#38596#21253#35065
            Caption = #33521#38596#21253#35065
            ParentShowHint = False
            ShowHint = True
            TabOrder = 15
          end
          object CheckBox17: TCheckBox
            Left = 88
            Top = 149
            Width = 66
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 16
          end
          object CheckBox18: TCheckBox
            Left = 8
            Top = 149
            Width = 66
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 17
          end
          object ButtonAllAdd: TButton
            Left = 6
            Top = 169
            Width = 70
            Height = 23
            Caption = #20840#37096#36873#20013
            TabOrder = 18
            OnClick = ButtonAllAddClick
          end
          object ButtonAllClose: TButton
            Left = 85
            Top = 169
            Width = 70
            Height = 23
            Caption = #20840#37096#21462#28040
            TabOrder = 19
            OnClick = ButtonAllCloseClick
          end
        end
        object ButtonRuleAdd: TButton
          Left = 14
          Top = 254
          Width = 70
          Height = 23
          Caption = #22686#21152'(&A)'
          Enabled = False
          TabOrder = 2
          OnClick = ButtonRuleAddClick
        end
        object ButtonRuleDel: TButton
          Left = 93
          Top = 254
          Width = 70
          Height = 23
          Caption = #21024#38500'(&D)'
          Enabled = False
          TabOrder = 3
          OnClick = ButtonRuleDelClick
        end
        object ButtonRuleAllAdd: TButton
          Left = 14
          Top = 281
          Width = 70
          Height = 23
          Caption = #20840#22686#21152'(&A)'
          TabOrder = 4
          OnClick = ButtonRuleAllAddClick
        end
        object ButtonRuleEdit: TButton
          Left = 93
          Top = 281
          Width = 70
          Height = 23
          Caption = #20462#25913'(&E)'
          Enabled = False
          TabOrder = 5
          OnClick = ButtonRuleEditClick
        end
        object ButtonRuleSave: TButton
          Left = 94
          Top = 308
          Width = 70
          Height = 23
          Caption = #20445#23384'(&S)'
          Enabled = False
          TabOrder = 6
          OnClick = ButtonRuleSaveClick
        end
        object ButtonRuleAllDel: TButton
          Left = 14
          Top = 308
          Width = 70
          Height = 23
          Caption = #20840#21024#38500'(&D)'
          TabOrder = 7
          OnClick = ButtonRuleAllDelClick
        end
      end
    end
  end
end
