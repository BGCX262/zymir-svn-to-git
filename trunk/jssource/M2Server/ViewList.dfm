object frmViewList: TfrmViewList
  Left = 183
  Top = 171
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #26597#30475#21015#34920#20449#24687
  ClientHeight = 272
  ClientWidth = 557
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
  object PageControlViewList: TPageControl
    Left = 7
    Top = 6
    Width = 543
    Height = 255
    ActivePage = TabSheet1
    MultiLine = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #31105#27490#21046#36896#29289#21697
      object GroupBox3: TGroupBox
        Left = 9
        Top = 3
        Width = 179
        Height = 178
        Caption = #31105#27490#21046#36896#21015#34920
        TabOrder = 0
        object ListBoxDisableMakeList: TListBox
          Left = 8
          Top = 16
          Width = 162
          Height = 153
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxDisableMakeListClick
        end
      end
      object GroupBox4: TGroupBox
        Left = 293
        Top = 3
        Width = 179
        Height = 178
        Caption = #29289#21697#21015#34920
        TabOrder = 1
        object ListBoxitemList1: TListBox
          Left = 8
          Top = 16
          Width = 162
          Height = 153
          ItemHeight = 12
          MultiSelect = True
          TabOrder = 0
          OnClick = ListBoxitemList1Click
        end
      end
      object ButtonDisableMakeAdd: TButton
        Left = 202
        Top = 22
        Width = 75
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonDisableMakeAddClick
      end
      object ButtonDisableMakeDelete: TButton
        Left = 202
        Top = 54
        Width = 75
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonDisableMakeDeleteClick
      end
      object ButtonDisableMakeSave: TButton
        Left = 202
        Top = 150
        Width = 75
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonDisableMakeSaveClick
      end
      object ButtonDisableMakeAddAll: TButton
        Left = 202
        Top = 86
        Width = 75
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 5
        OnClick = ButtonDisableMakeAddAllClick
      end
      object ButtonDisableMakeDeleteAll: TButton
        Left = 202
        Top = 118
        Width = 75
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 6
        OnClick = ButtonDisableMakeDeleteAllClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #20801#35768#21046#36896#29289#21697
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox2: TGroupBox
        Left = 293
        Top = 3
        Width = 179
        Height = 178
        Caption = #29289#21697#21015#34920
        TabOrder = 0
        object ListBoxItemList: TListBox
          Left = 8
          Top = 16
          Width = 162
          Height = 153
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxItemListClick
        end
      end
      object GroupBox1: TGroupBox
        Left = 9
        Top = 3
        Width = 179
        Height = 178
        Caption = #20801#35768#21046#36896#21015#34920
        TabOrder = 1
        object ListBoxEnableMakeList: TListBox
          Left = 8
          Top = 16
          Width = 162
          Height = 153
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxEnableMakeListClick
        end
      end
      object ButtonEnableMakeAdd: TButton
        Left = 202
        Top = 22
        Width = 75
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonEnableMakeAddClick
      end
      object ButtonEnableMakeDelete: TButton
        Left = 202
        Top = 54
        Width = 75
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonEnableMakeDeleteClick
      end
      object ButtonEnableMakeSave: TButton
        Left = 202
        Top = 150
        Width = 75
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonEnableMakeSaveClick
      end
      object ButtonEnableMakeAddAll: TButton
        Left = 202
        Top = 86
        Width = 75
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 5
        OnClick = ButtonEnableMakeAddAllClick
      end
      object ButtonEnableMakeDeleteAll: TButton
        Left = 202
        Top = 118
        Width = 75
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 6
        OnClick = ButtonEnableMakeDeleteAllClick
      end
    end
    object TabSheet8: TTabSheet
      Caption = #28216#25103#26085#24535#36807#28388
      ImageIndex = 8
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox8: TGroupBox
        Left = 9
        Top = 3
        Width = 179
        Height = 178
        Caption = #35760#24405#29289#21697'/'#20107#20214#21015#34920
        TabOrder = 0
        object ListBoxGameLogList: TListBox
          Left = 8
          Top = 16
          Width = 162
          Height = 153
          Hint = #28216#25103#26085#24535#36807#28388#65292#21487#20197#25351#23450#35760#24405#37027#20123#29289#21697#20135#29983#30340#26085#24535#65292#20174#39029#20943#23569#26085#24535#30340#22823#23567#12290
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxGameLogListClick
        end
      end
      object ButtonGameLogAdd: TButton
        Left = 202
        Top = 22
        Width = 75
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 1
        OnClick = ButtonGameLogAddClick
      end
      object ButtonGameLogDel: TButton
        Left = 202
        Top = 54
        Width = 75
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 2
        OnClick = ButtonGameLogDelClick
      end
      object ButtonGameLogAddAll: TButton
        Left = 202
        Top = 86
        Width = 75
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 3
        OnClick = ButtonGameLogAddAllClick
      end
      object ButtonGameLogDelAll: TButton
        Left = 202
        Top = 118
        Width = 75
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonGameLogDelAllClick
      end
      object ButtonGameLogSave: TButton
        Left = 202
        Top = 150
        Width = 75
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonGameLogSaveClick
      end
      object GroupBox9: TGroupBox
        Left = 293
        Top = 3
        Width = 179
        Height = 178
        Caption = #20107#20214'/'#29289#21697#21015#34920
        TabOrder = 6
        object ListBoxitemList2: TListBox
          Left = 8
          Top = 16
          Width = 162
          Height = 153
          Hint = #28216#25103#26085#24535#36807#28388#65292#21487#20197#25351#23450#35760#24405#37027#20123#29289#21697#20135#29983#30340#26085#24535#65292#20174#39029#20943#23569#26085#24535#30340#22823#23567#12290
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxitemList2Click
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #31105#27490#20256#36865#22320#22270
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox5: TGroupBox
        Left = 9
        Top = 3
        Width = 179
        Height = 178
        Caption = #31105#27490#22320#22270#21015#34920
        TabOrder = 0
        object ListBoxDisableMoveMap: TListBox
          Left = 8
          Top = 16
          Width = 162
          Height = 153
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxDisableMoveMapClick
        end
      end
      object ButtonDisableMoveMapAdd: TButton
        Left = 202
        Top = 22
        Width = 75
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 1
        OnClick = ButtonDisableMoveMapAddClick
      end
      object ButtonDisableMoveMapDelete: TButton
        Left = 202
        Top = 54
        Width = 75
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 2
        OnClick = ButtonDisableMoveMapDeleteClick
      end
      object ButtonDisableMoveMapAddAll: TButton
        Left = 202
        Top = 86
        Width = 75
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 3
        OnClick = ButtonDisableMoveMapAddAllClick
      end
      object ButtonDisableMoveMapDeleteAll: TButton
        Left = 202
        Top = 118
        Width = 75
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonDisableMoveMapDeleteAllClick
      end
      object ButtonDisableMoveMapSave: TButton
        Left = 202
        Top = 150
        Width = 75
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonDisableMoveMapSaveClick
      end
      object GroupBox6: TGroupBox
        Left = 293
        Top = 3
        Width = 179
        Height = 178
        Caption = #22320#22270#21015#34920
        TabOrder = 6
        object ListBoxMapList: TListBox
          Left = 8
          Top = 16
          Width = 162
          Height = 153
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxMapListClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #31105#27490#21457#35328#21015#34920
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TabSheet5: TTabSheet
      Caption = #29289#21697#36134#21495#32465#23450
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GridItemBindAccount: TStringGrid
        Left = 10
        Top = 10
        Width = 336
        Height = 178
        Hint = #21152#20837#27492#21015#34920#20013#30340#29289#21697#23558#19982#25351#23450#30340#30331#24405#36134#21495#32465#23450#65292#21482#26377#32463#32465#23450#30340#30331#24405#36134#21495#30331#24405#30340#20154#29289#25165#21487#20197#25140#19978#27492#29289#21697
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = GridItemBindAccountClick
        ColWidths = (
          91
          63
          68
          88)
      end
      object GroupBox16: TGroupBox
        Left = 355
        Top = 10
        Width = 174
        Height = 179
        Caption = #35268#21017#35774#32622
        TabOrder = 1
        object Label6: TLabel
          Left = 10
          Top = 41
          Width = 48
          Height = 12
          Caption = #29289#21697'IDX:'
        end
        object Label7: TLabel
          Left = 10
          Top = 65
          Width = 54
          Height = 12
          Caption = #29289#21697#24207#21495':'
        end
        object Label8: TLabel
          Left = 10
          Top = 89
          Width = 54
          Height = 12
          Caption = #32465#23450#36134#21495':'
        end
        object Label9: TLabel
          Left = 9
          Top = 17
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object ButtonItemBindAcountMod: TButton
          Left = 101
          Top = 112
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonItemBindAcountModClick
        end
        object EditItemBindAccountItemIdx: TSpinEdit
          Left = 68
          Top = 36
          Width = 98
          Height = 21
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemBindAccountItemIdxChange
        end
        object EditItemBindAccountItemMakeIdx: TSpinEdit
          Left = 68
          Top = 60
          Width = 98
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemBindAccountItemMakeIdxChange
        end
        object EditItemBindAccountItemName: TEdit
          Left = 68
          Top = 13
          Width = 98
          Height = 20
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemBindAcountAdd: TButton
          Left = 10
          Top = 112
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 4
          OnClick = ButtonItemBindAcountAddClick
        end
        object ButtonItemBindAcountRef: TButton
          Left = 101
          Top = 144
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 5
          OnClick = ButtonItemBindAcountRefClick
        end
        object ButtonItemBindAcountDel: TButton
          Left = 10
          Top = 144
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 6
          OnClick = ButtonItemBindAcountDelClick
        end
        object EditItemBindAccountName: TEdit
          Left = 68
          Top = 85
          Width = 98
          Height = 20
          TabOrder = 7
          OnChange = EditItemBindAccountNameChange
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = #29289#21697#20154#29289#32465#23450
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GridItemBindCharName: TStringGrid
        Left = 10
        Top = 10
        Width = 336
        Height = 178
        Hint = #21152#20837#27492#21015#34920#20013#30340#29289#21697#23558#19982#25351#23450#30340#20154#29289#32465#23450#65292#21482#26377#32463#32465#23450#30340#20154#29289#25165#21487#20197#25140#19978#27492#29289#21697
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = GridItemBindCharNameClick
        ColWidths = (
          91
          63
          68
          88)
      end
      object GroupBox17: TGroupBox
        Left = 355
        Top = 10
        Width = 174
        Height = 179
        Caption = #35268#21017#35774#32622
        TabOrder = 1
        object Label10: TLabel
          Left = 10
          Top = 41
          Width = 48
          Height = 12
          Caption = #29289#21697'IDX:'
        end
        object Label11: TLabel
          Left = 10
          Top = 65
          Width = 54
          Height = 12
          Caption = #29289#21697#24207#21495':'
        end
        object Label12: TLabel
          Left = 10
          Top = 89
          Width = 54
          Height = 12
          Caption = #32465#23450#20154#29289':'
        end
        object Label13: TLabel
          Left = 9
          Top = 17
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object ButtonItemBindCharNameMod: TButton
          Left = 101
          Top = 112
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonItemBindCharNameModClick
        end
        object EditItemBindCharNameItemIdx: TSpinEdit
          Left = 68
          Top = 36
          Width = 98
          Height = 21
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemBindCharNameItemIdxChange
        end
        object EditItemBindCharNameItemMakeIdx: TSpinEdit
          Left = 68
          Top = 60
          Width = 98
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemBindCharNameItemMakeIdxChange
        end
        object EditItemBindCharNameItemName: TEdit
          Left = 68
          Top = 13
          Width = 98
          Height = 20
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemBindCharNameAdd: TButton
          Left = 10
          Top = 112
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 4
          OnClick = ButtonItemBindCharNameAddClick
        end
        object ButtonItemBindCharNameRef: TButton
          Left = 101
          Top = 144
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 5
          OnClick = ButtonItemBindCharNameRefClick
        end
        object ButtonItemBindCharNameDel: TButton
          Left = 10
          Top = 144
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 6
          OnClick = ButtonItemBindCharNameDelClick
        end
        object EditItemBindCharNameName: TEdit
          Left = 68
          Top = 85
          Width = 98
          Height = 20
          TabOrder = 7
          OnChange = EditItemBindCharNameNameChange
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = #29289#21697'IP'#32465#23450
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GridItemBindIPaddr: TStringGrid
        Left = 10
        Top = 10
        Width = 336
        Height = 178
        Hint = #21152#20837#27492#21015#34920#20013#30340#29289#21697#23558#19982#25351#23450#30340'IP'#32465#23450#65292#21482#26377#32463#32465#23450#30340'IP'#30331#24405#30340#20154#29289#25165#21487#20197#25140#19978#27492#29289#21697
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = GridItemBindIPaddrClick
        ColWidths = (
          91
          63
          68
          88)
      end
      object GroupBox18: TGroupBox
        Left = 355
        Top = 10
        Width = 174
        Height = 179
        Caption = #35268#21017#35774#32622
        TabOrder = 1
        object Label14: TLabel
          Left = 10
          Top = 41
          Width = 48
          Height = 12
          Caption = #29289#21697'IDX:'
        end
        object Label15: TLabel
          Left = 10
          Top = 65
          Width = 54
          Height = 12
          Caption = #29289#21697#24207#21495':'
        end
        object Label16: TLabel
          Left = 10
          Top = 89
          Width = 42
          Height = 12
          Caption = #32465#23450'IP:'
        end
        object Label17: TLabel
          Left = 9
          Top = 17
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object ButtonItemBindIPaddrMod: TButton
          Left = 101
          Top = 112
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonItemBindIPaddrModClick
        end
        object EditItemBindIPaddrItemIdx: TSpinEdit
          Left = 68
          Top = 36
          Width = 98
          Height = 21
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemBindIPaddrItemIdxChange
        end
        object EditItemBindIPaddrItemMakeIdx: TSpinEdit
          Left = 68
          Top = 60
          Width = 98
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemBindIPaddrItemMakeIdxChange
        end
        object EditItemBindIPaddrItemName: TEdit
          Left = 68
          Top = 13
          Width = 98
          Height = 20
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemBindIPaddrAdd: TButton
          Left = 10
          Top = 112
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 4
          OnClick = ButtonItemBindIPaddrAddClick
        end
        object ButtonItemBindIPaddrRef: TButton
          Left = 101
          Top = 144
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 5
          OnClick = ButtonItemBindIPaddrRefClick
        end
        object ButtonItemBindIPaddrDel: TButton
          Left = 10
          Top = 144
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 6
          OnClick = ButtonItemBindIPaddrDelClick
        end
        object EditItemBindIPaddrName: TEdit
          Left = 68
          Top = 85
          Width = 98
          Height = 20
          TabOrder = 7
          OnChange = EditItemBindIPaddrNameChange
        end
      end
    end
    object TabSheet12: TTabSheet
      Caption = #29289#21697#21517#31216#33258#23450#20041
      ImageIndex = 12
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GridItemNameList: TStringGrid
        Left = 10
        Top = 10
        Width = 336
        Height = 178
        ColCount = 3
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = GridItemNameListClick
        ColWidths = (
          97
          69
          145)
      end
      object GroupBox19: TGroupBox
        Left = 355
        Top = 10
        Width = 174
        Height = 179
        Caption = #29289#21697#33258#23450#20041#21517#31216
        TabOrder = 1
        object Label18: TLabel
          Left = 9
          Top = 41
          Width = 48
          Height = 12
          Caption = #29289#21697'IDX:'
        end
        object Label19: TLabel
          Left = 9
          Top = 65
          Width = 54
          Height = 12
          Caption = #29289#21697#24207#21495':'
        end
        object Label20: TLabel
          Left = 9
          Top = 89
          Width = 54
          Height = 12
          Caption = #33258#23450#20041#21517':'
        end
        object Label21: TLabel
          Left = 9
          Top = 17
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object ButtonItemNameMod: TButton
          Left = 101
          Top = 112
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonItemNameModClick
        end
        object EditItemNameIdx: TSpinEdit
          Left = 68
          Top = 36
          Width = 98
          Height = 21
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemNameIdxChange
        end
        object EditItemNameMakeIndex: TSpinEdit
          Left = 68
          Top = 60
          Width = 98
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemNameMakeIndexChange
        end
        object EditItemNameOldName: TEdit
          Left = 68
          Top = 13
          Width = 98
          Height = 20
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemNameAdd: TButton
          Left = 10
          Top = 112
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 4
          OnClick = ButtonItemNameAddClick
        end
        object ButtonItemNameRef: TButton
          Left = 101
          Top = 144
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 5
          OnClick = ButtonItemNameRefClick
        end
        object ButtonItemNameDel: TButton
          Left = 10
          Top = 144
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 6
          OnClick = ButtonItemNameDelClick
        end
        object EditItemNameNewName: TEdit
          Left = 68
          Top = 85
          Width = 98
          Height = 20
          TabOrder = 7
          OnChange = EditItemNameNewNameChange
        end
      end
    end
    object TabSheetMonDrop: TTabSheet
      Caption = #24618#29289#29190#29289#21697
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object StringGridMonDropLimit: TStringGrid
        Left = 10
        Top = 10
        Width = 281
        Height = 178
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = StringGridMonDropLimitClick
        ColWidths = (
          81
          64
          57
          52)
      end
      object GroupBox7: TGroupBox
        Left = 299
        Top = 10
        Width = 226
        Height = 179
        Caption = #35268#21017#35774#32622
        TabOrder = 1
        object Label29: TLabel
          Left = 9
          Top = 44
          Width = 54
          Height = 12
          Caption = #24050#29190#25968#37327':'
        end
        object Label1: TLabel
          Left = 9
          Top = 68
          Width = 54
          Height = 12
          Caption = #38480#21046#25968#37327':'
        end
        object Label2: TLabel
          Left = 9
          Top = 94
          Width = 54
          Height = 12
          Caption = #26410#29190#25968#37327':'
        end
        object Label3: TLabel
          Left = 9
          Top = 17
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object ButtonMonDropLimitSave: TButton
          Left = 101
          Top = 116
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonMonDropLimitSaveClick
        end
        object EditDropCount: TSpinEdit
          Left = 68
          Top = 38
          Width = 62
          Height = 21
          MaxValue = 100000
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditDropCountChange
        end
        object EditCountLimit: TSpinEdit
          Left = 68
          Top = 63
          Width = 62
          Height = 21
          MaxValue = 100000
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditCountLimitChange
        end
        object EditNoDropCount: TSpinEdit
          Left = 68
          Top = 89
          Width = 62
          Height = 21
          MaxValue = 100000
          MinValue = 0
          TabOrder = 3
          Value = 10
          OnChange = EditNoDropCountChange
        end
        object EditItemName: TEdit
          Left = 68
          Top = 13
          Width = 98
          Height = 20
          TabOrder = 4
        end
        object ButtonMonDropLimitAdd: TButton
          Left = 9
          Top = 116
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 5
          OnClick = ButtonMonDropLimitAddClick
        end
        object ButtonMonDropLimitRef: TButton
          Left = 101
          Top = 148
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 6
          OnClick = ButtonMonDropLimitRefClick
        end
        object ButtonMonDropLimitDel: TButton
          Left = 9
          Top = 148
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 7
          OnClick = ButtonMonDropLimitDelClick
        end
      end
    end
    object TabSheet9: TTabSheet
      Caption = #31105#27490#21462#19979#29289#21697
      ImageIndex = 9
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox10: TGroupBox
        Left = 9
        Top = 3
        Width = 179
        Height = 178
        Caption = #31105#27490#21462#19979#29289#21697#21015#34920
        TabOrder = 0
        object ListBoxDisableTakeOffList: TListBox
          Left = 8
          Top = 16
          Width = 162
          Height = 153
          Hint = #31105#27490#21462#19979#29289#21697#35774#32622#65292#21152#20837#27492#21015#34920#30340#29289#21697#25140#22312#36523#19978#21518#23558#19981#21487#20197#21462#19979#26469#65292#27515#20129#20063#19981#20250#25481#33853#12290
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxDisableTakeOffListClick
        end
      end
      object ButtonDisableTakeOffAdd: TButton
        Left = 202
        Top = 22
        Width = 75
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 1
        OnClick = ButtonDisableTakeOffAddClick
      end
      object ButtonDisableTakeOffDel: TButton
        Left = 202
        Top = 54
        Width = 75
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 2
        OnClick = ButtonDisableTakeOffDelClick
      end
      object ButtonDisableTakeOffAddAll: TButton
        Left = 202
        Top = 86
        Width = 75
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 3
        OnClick = ButtonDisableTakeOffAddAllClick
      end
      object ButtonDisableTakeOffDelAll: TButton
        Left = 202
        Top = 118
        Width = 75
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonDisableTakeOffDelAllClick
      end
      object ButtonDisableTakeOffSave: TButton
        Left = 202
        Top = 150
        Width = 75
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonDisableTakeOffSaveClick
      end
      object GroupBox11: TGroupBox
        Left = 293
        Top = 3
        Width = 179
        Height = 178
        Caption = #29289#21697#21015#34920
        TabOrder = 6
        object ListBoxitemList3: TListBox
          Left = 8
          Top = 16
          Width = 162
          Height = 153
          Hint = #31105#27490#21462#19979#29289#21697#35774#32622#65292#21152#20837#27492#21015#34920#30340#29289#21697#25140#22312#36523#19978#21518#23558#19981#21487#20197#21462#19979#26469#65292#27515#20129#20063#19981#20250#25481#33853#12290
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxitemList3Click
        end
      end
    end
    object TabSheet11: TTabSheet
      Caption = #31105#27490#28165#29702#24618#29289#21015#34920
      ImageIndex = 11
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox13: TGroupBox
        Left = 9
        Top = 3
        Width = 179
        Height = 178
        Caption = #31105#27490#28165#29702#24618#29289#21015#34920
        TabOrder = 0
        object ListBoxNoClearMonList: TListBox
          Left = 8
          Top = 16
          Width = 162
          Height = 153
          Hint = #31105#27490#28165#38500#24618#29289#35774#32622#65292#29992#20110#33050#26412#21629#20196'CLEARMAPMON'#65292#21152#20837#27492#21015#34920#30340#24618#29289#65292#22312#20351#29992#27492#33050#26412#21629#20196#26102#19981#20250#34987#28165#38500#12290
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxNoClearMonListClick
        end
      end
      object ButtonNoClearMonAdd: TButton
        Left = 202
        Top = 22
        Width = 75
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 1
        OnClick = ButtonNoClearMonAddClick
      end
      object ButtonNoClearMonDel: TButton
        Left = 202
        Top = 54
        Width = 75
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 2
        OnClick = ButtonNoClearMonDelClick
      end
      object ButtonNoClearMonAddAll: TButton
        Left = 202
        Top = 86
        Width = 75
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 3
        OnClick = ButtonNoClearMonAddAllClick
      end
      object ButtonNoClearMonDelAll: TButton
        Left = 202
        Top = 118
        Width = 75
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonNoClearMonDelAllClick
      end
      object ButtonNoClearMonSave: TButton
        Left = 202
        Top = 150
        Width = 75
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonNoClearMonSaveClick
      end
      object GroupBox14: TGroupBox
        Left = 293
        Top = 3
        Width = 179
        Height = 178
        Caption = #24618#29289#21015#34920
        TabOrder = 6
        object ListBoxMonList: TListBox
          Left = 8
          Top = 16
          Width = 162
          Height = 153
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxMonListClick
        end
      end
    end
    object TabSheet10: TTabSheet
      Caption = #31649#29702#21592#21015#34920
      ImageIndex = 10
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox12: TGroupBox
        Left = 10
        Top = 5
        Width = 274
        Height = 178
        Caption = #31649#29702#21592#21015#34920
        TabOrder = 0
        object ListBoxAdminList: TListBox
          Left = 8
          Top = 16
          Width = 257
          Height = 153
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxAdminListClick
        end
      end
      object GroupBox15: TGroupBox
        Left = 294
        Top = 5
        Width = 233
        Height = 140
        Caption = #31649#29702#21592#20449#24687
        TabOrder = 1
        object Label4: TLabel
          Left = 11
          Top = 22
          Width = 54
          Height = 12
          Caption = #35282#33394#21517#31216':'
        end
        object Label5: TLabel
          Left = 11
          Top = 47
          Width = 54
          Height = 12
          Caption = #26435#38480#31561#32423':'
        end
        object LabelAdminIPaddr: TLabel
          Left = 11
          Top = 74
          Width = 42
          Height = 12
          Caption = #30331#24405'IP:'
        end
        object EditAdminName: TEdit
          Left = 72
          Top = 17
          Width = 114
          Height = 20
          TabOrder = 0
        end
        object EditAdminPremission: TSpinEdit
          Left = 72
          Top = 41
          Width = 76
          Height = 21
          MaxValue = 10
          MinValue = 1
          TabOrder = 1
          Value = 10
        end
        object ButtonAdminListAdd: TButton
          Left = 12
          Top = 106
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 2
          OnClick = ButtonAdminListAddClick
        end
        object ButtonAdminListChange: TButton
          Left = 84
          Top = 106
          Width = 65
          Height = 25
          Caption = #20462#25913'(&M)'
          TabOrder = 3
          OnClick = ButtonAdminListChangeClick
        end
        object ButtonAdminListDel: TButton
          Left = 156
          Top = 106
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 4
          OnClick = ButtonAdminListDelClick
        end
        object EditAdminIPaddr: TEdit
          Left = 72
          Top = 69
          Width = 121
          Height = 20
          TabOrder = 5
        end
      end
      object ButtonAdminLitsSave: TButton
        Left = 462
        Top = 158
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonAdminLitsSaveClick
      end
    end
  end
end
