object frmMonsterConfig: TfrmMonsterConfig
  Left = 280
  Top = 113
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #24618#29289#35774#32622
  ClientHeight = 320
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 601
    Height = 297
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #22522#26412#21442#25968
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 577
        Height = 257
        TabOrder = 0
        object GroupBox8: TGroupBox
          Left = 8
          Top = 16
          Width = 153
          Height = 73
          Caption = #29190#29289#21697#35774#32622
          TabOrder = 0
          object Label23: TLabel
            Left = 8
            Top = 24
            Width = 42
            Height = 12
            Caption = #37329#24065#22534':'
          end
          object EditMonOneDropGoldCount: TSpinEdit
            Left = 57
            Top = 20
            Width = 77
            Height = 21
            MaxValue = 99999999
            MinValue = 1
            TabOrder = 0
            Value = 10
            OnChange = EditMonOneDropGoldCountChange
          end
          object CheckBoxGoldToBag: TCheckBox
            Left = 8
            Top = 46
            Width = 129
            Height = 17
            Caption = #37329#24065#30452#25509#20837#32972#21253
            TabOrder = 1
            OnClick = CheckBoxGoldToBagClick
          end
        end
        object ButtonGeneralSave: TButton
          Left = 504
          Top = 221
          Width = 65
          Height = 25
          Caption = #20445#23384'(&S)'
          TabOrder = 3
          OnClick = ButtonGeneralSaveClick
        end
        object GroupBox3: TGroupBox
          Left = 168
          Top = 16
          Width = 161
          Height = 73
          Caption = #26102#38388#35774#32622
          TabOrder = 1
          object Label1: TLabel
            Left = 8
            Top = 20
            Width = 54
            Height = 12
            Caption = #24310#38271#26102#38388':'
          end
          object Label2: TLabel
            Left = 145
            Top = 20
            Width = 12
            Height = 12
            Caption = #31186
          end
          object EditMonButchMaxTime: TSpinEdit
            Left = 66
            Top = 16
            Width = 75
            Height = 21
            Hint = #24618#29289#19968#20294#34987#25366#65292#21017#33258#21160#21551#29992#24310#26102#21151#33021#65292#20197#20813#30001#20110#35774#32622#28165#29702#24618#29289#26102#38388#22826#30701#32780#36896#25104#26080#27861#25366#21462#24618#29289#36523#19978#29289#21697#12290#40664#35748' 60'#31186
            MaxValue = 99999999
            MinValue = 1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Value = 10
            OnChange = EditMonButchMaxTimeChange
          end
        end
        object GroupBox4: TGroupBox
          Left = 8
          Top = 95
          Width = 153
          Height = 82
          Caption = #26234#33021#21047#24618#35774#32622
          TabOrder = 2
          object Label3: TLabel
            Left = 8
            Top = 50
            Width = 48
            Height = 12
            Caption = #28165#29702#38388#38548
            ParentShowHint = False
            ShowHint = False
          end
          object Label4: TLabel
            Left = 132
            Top = 50
            Width = 12
            Height = 12
            Caption = #20998
          end
          object EditNoManClearMonTime: TSpinEdit
            Left = 57
            Top = 46
            Width = 69
            Height = 21
            Hint = #24403#22320#22270#27809#26377#20219#20309#20154#29289#23384#22312#65292#26102#38388#36798#21040#35813#35774#32622#23450#65292#31995#32479#23558#28165#38500#35813#22320#22270#25152#26377#24618#29289#65294#21482#23545#26234#33021#21047#24618#22320#22270#26377#25928#65294
            MaxValue = 99999999
            MinValue = 1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Value = 10
            OnChange = EditNoManClearMonTimeChange
          end
          object CheckBoxNoManClearMon: TCheckBox
            Left = 8
            Top = 23
            Width = 139
            Height = 17
            Hint = #24403#22320#22270#27809#26377#20219#20309#20154#29289#23384#22312#65292#26102#38388#36798#21040#35813#35774#32622#23450#65292#31995#32479#23558#28165#38500#35813#22320#22270#25152#26377#24618#29289#65294#21482#23545#26234#33021#21047#24618#22320#22270#26377#25928#65294
            Caption = #33258#21160#28165#38500#26080#20154#22320#22270#24618#29289
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = CheckBoxNoManClearMonClick
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #20154#22411#24618#35774#32622
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox2: TGroupBox
        Left = 8
        Top = 8
        Width = 185
        Height = 49
        Caption = #36873#39033
        TabOrder = 0
        object CheckBoxCloneNotCheckAmulet: TCheckBox
          Left = 8
          Top = 19
          Width = 121
          Height = 17
          Hint = #24320#21551#35813#39033#21518#65292#20154#22411#24618#21487#20197#19981#29992#37197#24102#31526'('#27602')'#65292#26082#21487#26080#38480#21046#20351#29992#31526'('#27602')'#12290#24618#29289#37325#26032#21047#20986#21518#29983#25928#12290
          Caption = #20154#22411#24618#31526#27602#29992#19981#23436
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = CheckBoxCloneNotCheckAmuletClick
        end
      end
      object CloneButtonSave: TButton
        Left = 504
        Top = 221
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonGeneralSaveClick
      end
    end
  end
end
