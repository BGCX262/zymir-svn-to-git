object frmConfigMerchant: TfrmConfigMerchant
  Left = 447
  Top = 139
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20132#26131'NPC'#37197#32622
  ClientHeight = 372
  ClientWidth = 825
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
  object Label1: TLabel
    Left = 10
    Top = 7
    Width = 48
    Height = 12
    Caption = 'NPC'#21015#34920':'
  end
  object ListBoxMerChant: TListBox
    Left = 10
    Top = 23
    Width = 398
    Height = 171
    ItemHeight = 12
    TabOrder = 0
    OnClick = ListBoxMerChantClick
  end
  object GroupBoxNPC: TGroupBox
    Left = 10
    Top = 198
    Width = 398
    Height = 139
    Caption = #30456#20851#35774#32622
    Enabled = False
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 19
      Width = 54
      Height = 12
      Caption = #33050#26412#21517#31216':'
    end
    object Label3: TLabel
      Left = 196
      Top = 19
      Width = 54
      Height = 12
      Caption = #22320#22270#21517#31216':'
    end
    object Label4: TLabel
      Left = 8
      Top = 44
      Width = 36
      Height = 12
      Caption = #24231#26631'X:'
    end
    object Label5: TLabel
      Left = 120
      Top = 45
      Width = 12
      Height = 12
      Caption = 'Y:'
    end
    object Label6: TLabel
      Left = 8
      Top = 68
      Width = 54
      Height = 12
      Caption = #26174#31034#21517#31216':'
    end
    object Label7: TLabel
      Left = 196
      Top = 68
      Width = 30
      Height = 12
      Caption = #26041#21521':'
    end
    object Label8: TLabel
      Left = 292
      Top = 68
      Width = 30
      Height = 12
      Caption = #22806#22411':'
    end
    object Label10: TLabel
      Left = 196
      Top = 43
      Width = 54
      Height = 12
      Caption = #22320#22270#25551#36848':'
    end
    object Label11: TLabel
      Left = 274
      Top = 93
      Width = 54
      Height = 12
      Caption = #31227#21160#38388#38548':'
    end
    object EditScriptName: TEdit
      Left = 65
      Top = 15
      Width = 118
      Height = 20
      Hint = #33050#26412#25991#20214#21517#31216#65292#33050#26412#21517#21152#22320#22270#21517#32452#21512#20026#23454#38469#33050#26412#21517#31216
      TabOrder = 0
      OnChange = EditScriptNameChange
    end
    object EditMapName: TEdit
      Left = 258
      Top = 15
      Width = 118
      Height = 20
      Hint = #22320#22270#21517#31216
      TabOrder = 1
      OnChange = EditMapNameChange
    end
    object EditShowName: TEdit
      Left = 65
      Top = 64
      Width = 118
      Height = 20
      TabOrder = 2
      OnChange = EditShowNameChange
    end
    object CheckBoxOfCastle: TCheckBox
      Left = 65
      Top = 89
      Width = 72
      Height = 21
      Hint = #25351#23450'NPC'#23646#20110#22478#22561#31649#29702#65292#25915#22478#26102#20572#27490#33829#19994
      Caption = #23646#20110#22478#22561
      TabOrder = 3
      OnClick = CheckBoxOfCastleClick
    end
    object ComboBoxDir: TComboBox
      Left = 227
      Top = 64
      Width = 52
      Height = 20
      Hint = #40664#35748#31449#31435#26041#21521
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 4
      OnChange = ComboBoxDirChange
    end
    object EditImageIdx: TSpinEdit
      Left = 324
      Top = 64
      Width = 52
      Height = 21
      Hint = #22806#35266#22270#29255
      EditorEnabled = False
      MaxValue = 65535
      MinValue = 0
      TabOrder = 5
      Value = 0
      OnChange = EditImageIdxChange
    end
    object EditX: TSpinEdit
      Left = 65
      Top = 39
      Width = 48
      Height = 21
      Hint = #24403#21069#24231#26631'X'
      EditorEnabled = False
      MaxValue = 1000
      MinValue = 1
      TabOrder = 6
      Value = 1
      OnChange = EditXChange
    end
    object EditY: TSpinEdit
      Left = 134
      Top = 39
      Width = 49
      Height = 21
      Hint = #24403#21069#24231#26631'Y'
      EditorEnabled = False
      MaxValue = 1000
      MinValue = 1
      TabOrder = 7
      Value = 1
      OnChange = EditYChange
    end
    object EditMapDesc: TEdit
      Left = 258
      Top = 39
      Width = 118
      Height = 20
      Enabled = False
      ReadOnly = True
      TabOrder = 8
    end
    object CheckBoxAutoMove: TCheckBox
      Left = 196
      Top = 89
      Width = 69
      Height = 21
      Hint = 'NPC'#20250#22312#22320#22270#20869#38543#26426#31227#21160
      Caption = #33258#21160#31227#21160
      TabOrder = 9
      OnClick = CheckBoxAutoMoveClick
    end
    object EditMoveTime: TSpinEdit
      Left = 332
      Top = 89
      Width = 44
      Height = 21
      Hint = #38543#26426#31227#21160#38388#38548'('#31186')'
      EditorEnabled = False
      MaxValue = 65535
      MinValue = 0
      TabOrder = 10
      Value = 0
      OnChange = EditMoveTimeChange
    end
  end
  object GroupBoxScript: TGroupBox
    Left = 416
    Top = 7
    Width = 401
    Height = 360
    Caption = #33050#26412#32534#36753
    Enabled = False
    TabOrder = 2
    object MemoScript: TMemo
      Left = 10
      Top = 133
      Width = 381
      Height = 217
      ScrollBars = ssBoth
      TabOrder = 0
      OnChange = MemoScriptChange
    end
    object ButtonScriptSave: TButton
      Left = 335
      Top = 30
      Width = 54
      Height = 25
      Hint = #20445#23384#33050#26412#25991#20214
      Caption = #20445#23384'(&S)'
      TabOrder = 1
      OnClick = ButtonScriptSaveClick
    end
    object GroupBox3: TGroupBox
      Left = 10
      Top = 17
      Width = 319
      Height = 109
      Caption = #33050#26412#21442#25968
      TabOrder = 2
      object Label9: TLabel
        Left = 9
        Top = 84
        Width = 54
        Height = 12
        Caption = #20132#26131#25240#25187':'
      end
      object CheckBoxBuy: TCheckBox
        Left = 9
        Top = 17
        Width = 41
        Height = 16
        Caption = #20080
        TabOrder = 0
        OnClick = CheckBoxBuyClick
      end
      object CheckBoxSell: TCheckBox
        Left = 9
        Top = 33
        Width = 41
        Height = 16
        Caption = #21334
        TabOrder = 1
        OnClick = CheckBoxSellClick
      end
      object CheckBoxStorage: TCheckBox
        Left = 71
        Top = 33
        Width = 81
        Height = 16
        Caption = #21462#20179#24211
        TabOrder = 2
        OnClick = CheckBoxStorageClick
      end
      object CheckBoxGetback: TCheckBox
        Left = 71
        Top = 17
        Width = 66
        Height = 16
        Caption = #23384#20179#24211
        TabOrder = 3
        OnClick = CheckBoxGetbackClick
      end
      object CheckBoxMakedrug: TCheckBox
        Left = 238
        Top = 49
        Width = 76
        Height = 16
        Caption = #21512#25104#29289#21697
        TabOrder = 4
        OnClick = CheckBoxMakedrugClick
      end
      object CheckBoxUpgradenow: TCheckBox
        Left = 150
        Top = 17
        Width = 75
        Height = 16
        Caption = #21319#32423#27494#22120
        TabOrder = 5
        OnClick = CheckBoxUpgradenowClick
      end
      object CheckBoxGetbackupgnow: TCheckBox
        Left = 150
        Top = 33
        Width = 91
        Height = 16
        Caption = #21462#22238#21319#32423
        TabOrder = 6
        OnClick = CheckBoxGetbackupgnowClick
      end
      object CheckBoxRepair: TCheckBox
        Left = 238
        Top = 17
        Width = 75
        Height = 16
        Caption = #20462#29702#29289#21697
        TabOrder = 7
        OnClick = CheckBoxRepairClick
      end
      object CheckBoxS_repair: TCheckBox
        Left = 238
        Top = 33
        Width = 76
        Height = 16
        Caption = #29305#27530#20462#29702
        TabOrder = 8
        OnClick = CheckBoxS_repairClick
      end
      object EditPriceRate: TSpinEdit
        Left = 65
        Top = 80
        Width = 53
        Height = 21
        Hint = 'NPC'#20132#26131#25240#25187',80'#20026'80%'
        EditorEnabled = False
        MaxValue = 500
        MinValue = 60
        TabOrder = 9
        Value = 60
        OnChange = EditPriceRateChange
      end
      object CheckBoxSendMsg: TCheckBox
        Left = 71
        Top = 49
        Width = 66
        Height = 16
        Caption = #31069#31119#35821
        TabOrder = 10
        OnClick = CheckBoxSendMsgClick
      end
      object CheckBoxCallHero: TCheckBox
        Left = 150
        Top = 49
        Width = 66
        Height = 16
        Caption = #21019#24314#33521#38596
        TabOrder = 11
        OnClick = CheckBoxCallHeroClick
      end
      object CheckBoxSellOff: TCheckBox
        Left = 9
        Top = 49
        Width = 41
        Height = 16
        Caption = #23492#21806
        TabOrder = 12
        OnClick = CheckBoxSellOffClick
      end
    end
    object ButtonReLoadNpc: TButton
      Left = 335
      Top = 62
      Width = 54
      Height = 25
      Hint = #37325#26032#21152#36733'NPC'#33050#26412
      Caption = #21152#36733'(&L)'
      Enabled = False
      TabOrder = 3
      OnClick = ButtonReLoadNpcClick
    end
  end
  object ButtonSave: TButton
    Left = 10
    Top = 342
    Width = 65
    Height = 25
    Hint = #20445#23384#20132#26131'NPC'#25968#25454
    Caption = #20445#23384'(&S)'
    TabOrder = 3
    OnClick = ButtonSaveClick
  end
  object CheckBoxDenyRefStatus: TCheckBox
    Left = 314
    Top = 344
    Width = 79
    Height = 21
    Hint = #20351#29992#27492#26041#27861#65292#21487#20197#21047#26032'NPC'#22312#28216#25103#20013#30340#25968#25454#12290#25171#24320#27492#36873#39033#20960#31186#21518#20877#20851#38381#65292'NPC'#26356#25913#30340#21442#25968#23601#20250#22312#28216#25103#20013#21047#26032#12290
    Caption = #21047#26032#29366#24577
    TabOrder = 4
    OnClick = CheckBoxDenyRefStatusClick
  end
  object ButtonClearTempData: TButton
    Left = 170
    Top = 342
    Width = 85
    Height = 25
    Hint = #28165#38500#25152#26377'NPC'#30340#20020#26102#25991#20214#65292#21253#25324#20020#26102#20215#26684#34920#21450#20132#26131#29289#21697#24211#23384#65292#22312'NPC'#20080#21334#29289#21697#26377#38382#39064#26102#21487#20351#29992#27492#21151#33021#28165#29702#12290
    Caption = #28165#38500#25968#25454'(&C)'
    TabOrder = 5
    OnClick = ButtonClearTempDataClick
  end
  object ButtonViewData: TButton
    Left = 82
    Top = 342
    Width = 85
    Height = 25
    Caption = 'ViewData(&V)'
    TabOrder = 6
    Visible = False
    OnClick = ButtonClearTempDataClick
  end
end
