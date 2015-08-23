object frmCastleManage: TfrmCastleManage
  Left = 672
  Top = 127
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #22478#22561#31649#29702
  ClientHeight = 279
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 193
    Height = 257
    Caption = #22478#22561#21015#34920
    TabOrder = 0
    object ListViewCastle: TListView
      Left = 8
      Top = 16
      Width = 177
      Height = 233
      Columns = <
        item
          Caption = #24207#21495
          Width = 36
        end
        item
          Caption = #32534#21495
          Width = 36
        end
        item
          Caption = #21517#31216
          Width = 100
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnChange = ListViewCastleChange
      OnClick = ListViewCastleClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 208
    Top = 8
    Width = 353
    Height = 257
    Caption = #22478#22561#20449#24687
    TabOrder = 1
    object PageControlCastle: TPageControl
      Left = 8
      Top = 16
      Width = 337
      Height = 233
      ActivePage = TabSheet5
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = #22522#26412#29366#24577
        object GroupBox3: TGroupBox
          Left = 5
          Top = 5
          Width = 321
          Height = 92
          TabOrder = 0
          object Label2: TLabel
            Left = 8
            Top = 20
            Width = 54
            Height = 12
            Caption = #25152#23646#34892#20250':'
          end
          object Label1: TLabel
            Left = 8
            Top = 44
            Width = 54
            Height = 12
            Caption = #36164#37329#24635#25968':'
          end
          object Label3: TLabel
            Left = 8
            Top = 68
            Width = 54
            Height = 12
            Caption = #24403#22825#25910#20837':'
          end
          object Label7: TLabel
            Left = 152
            Top = 44
            Width = 30
            Height = 12
            Caption = #31561#32423':'
          end
          object Label8: TLabel
            Left = 152
            Top = 68
            Width = 30
            Height = 12
            Caption = #33021#28304':'
          end
          object EditOwenGuildName: TEdit
            Left = 64
            Top = 16
            Width = 81
            Height = 20
            TabOrder = 0
          end
          object EditTotalGold: TSpinEdit
            Left = 64
            Top = 40
            Width = 81
            Height = 21
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 1
            Value = 0
          end
          object EditTodayIncome: TSpinEdit
            Left = 64
            Top = 64
            Width = 81
            Height = 21
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 3
            Value = 0
          end
          object EditTechLevel: TSpinEdit
            Left = 184
            Top = 40
            Width = 49
            Height = 21
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 2
            Value = 0
          end
          object EditPower: TSpinEdit
            Left = 184
            Top = 64
            Width = 49
            Height = 21
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 4
            Value = 0
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = #23432#21355#29366#24577
        ImageIndex = 2
        object GroupBox5: TGroupBox
          Left = 5
          Top = 0
          Width = 318
          Height = 201
          TabOrder = 0
          object ListViewGuard: TListView
            Left = 8
            Top = 16
            Width = 300
            Height = 145
            Columns = <
              item
                Caption = #24207#21495
                Width = 36
              end
              item
                Caption = #21517#31216
                Width = 80
              end
              item
                Caption = #24231#26631
                Width = 60
              end
              item
                Caption = #34880#37327
                Width = 80
              end
              item
                Caption = #22478#38376#29366#24577
                Width = 60
              end>
            GridLines = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
          object ButtonRefresh: TButton
            Left = 240
            Top = 168
            Width = 65
            Height = 25
            Caption = #21047#26032'(&R)'
            TabOrder = 1
            OnClick = ButtonRefreshClick
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = #35774#32622
        ImageIndex = 1
        object GroupBox4: TGroupBox
          Left = 5
          Top = 5
          Width = 321
          Height = 89
          TabOrder = 0
          object Label4: TLabel
            Left = 8
            Top = 20
            Width = 54
            Height = 12
            Caption = #22478#22561#21517#31216':'
          end
          object Label5: TLabel
            Left = 8
            Top = 44
            Width = 54
            Height = 12
            Caption = #25152#23646#34892#20250':'
          end
          object Label6: TLabel
            Left = 152
            Top = 20
            Width = 54
            Height = 12
            Caption = #22238#22478#22320#22270':'
          end
          object Label9: TLabel
            Left = 152
            Top = 44
            Width = 54
            Height = 12
            Caption = #22238#22478#24231#26631':'
          end
          object Label10: TLabel
            Left = 8
            Top = 68
            Width = 54
            Height = 12
            Caption = #30343#23467#22320#22270':'
          end
          object Label11: TLabel
            Left = 152
            Top = 68
            Width = 54
            Height = 12
            Caption = #23494#36947#22320#22270':'
          end
          object EditOwenName: TEdit
            Left = 64
            Top = 16
            Width = 81
            Height = 20
            TabOrder = 0
          end
          object EditOwenGuild: TEdit
            Left = 64
            Top = 40
            Width = 81
            Height = 20
            TabOrder = 2
          end
          object EditHomeMap: TEdit
            Left = 208
            Top = 16
            Width = 104
            Height = 20
            TabOrder = 1
          end
          object Edit0150: TEdit
            Left = 64
            Top = 64
            Width = 81
            Height = 20
            TabOrder = 5
          end
          object EditD701: TEdit
            Left = 208
            Top = 64
            Width = 104
            Height = 20
            TabOrder = 6
          end
          object SpinEditHomeX: TSpinEdit
            Left = 208
            Top = 40
            Width = 50
            Height = 21
            MaxValue = 0
            MinValue = 0
            TabOrder = 3
            Value = 0
          end
          object SpinEditHomeY: TSpinEdit
            Left = 262
            Top = 40
            Width = 50
            Height = 21
            MaxValue = 0
            MinValue = 0
            TabOrder = 4
            Value = 0
          end
        end
      end
      object TabSheet4: TTabSheet
        Caption = #25915#22478#30003#35831
        ImageIndex = 3
        object GroupBox6: TGroupBox
          Left = 8
          Top = 4
          Width = 313
          Height = 197
          TabOrder = 0
          object ListViewSiege: TListView
            Left = 13
            Top = 17
            Width = 297
            Height = 137
            Columns = <
              item
                Caption = #24207#21495
                Width = 40
              end
              item
                Caption = #34892#20250#21517#31216
                Width = 120
              end
              item
                Caption = #25915#22478#26102#38388
                Width = 120
              end>
            GridLines = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
          object ButtonADD: TButton
            Left = 8
            Top = 160
            Width = 60
            Height = 25
            Caption = #22686#21152'(&A)'
            TabOrder = 1
            OnClick = ButtonADDClick
          end
          object ButtonEdit: TButton
            Left = 80
            Top = 160
            Width = 60
            Height = 25
            Caption = #32534#36753'(&E)'
            TabOrder = 2
            OnClick = ButtonEditClick
          end
          object ButtonDel: TButton
            Left = 152
            Top = 160
            Width = 60
            Height = 25
            Caption = #21024#38500'(&D)'
            TabOrder = 3
            OnClick = ButtonDelClick
          end
          object ButtonRefurbish: TButton
            Left = 245
            Top = 160
            Width = 60
            Height = 25
            Caption = #21047#26032'(&R)'
            TabOrder = 4
            OnClick = ButtonRefurbishClick
          end
        end
      end
      object TabSheet5: TTabSheet
        Caption = #25915#22478#35774#32622
        ImageIndex = 4
        object GroupBox7: TGroupBox
          Left = 6
          Top = 5
          Width = 316
          Height = 113
          Caption = #33258#21160#25915#22478#35774#32622'('#20462#25913#31435#26082#29983#25928')'
          TabOrder = 0
          object Label13: TLabel
            Left = 8
            Top = 39
            Width = 78
            Height = 12
            Caption = #33258#21160#25915#22478#26085#26399':'
          end
          object Label12: TLabel
            Left = 168
            Top = 90
            Width = 54
            Height = 12
            Caption = #31532#20108#22478#20027':'
          end
          object Label14: TLabel
            Left = 168
            Top = 63
            Width = 54
            Height = 12
            Caption = #31532#19968#22478#20027':'
          end
          object Label18: TLabel
            Left = 8
            Top = 63
            Width = 78
            Height = 12
            Caption = #33258#21160#21344#39046#34892#20250':'
          end
          object chkAutoAttackWar: TCheckBox
            Left = 8
            Top = 17
            Width = 97
            Height = 17
            Hint = #26159#21542#24320#21551#33258#21160#25915#22478#35774#32622#65292#24320#21551#35813#35774#32622#21518#65292#21040#20102#25351#23450#30340#33258#21160#25915#22478#26102#38388#23558#25226#25152#26377#34892#20250#21152#20837#25915#22478#21015#34920#32479#19968#25915#22478#12290
            Caption = #33258#21160#24320#21551#25915#22478
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = chkAutoAttackWarClick
          end
          object dtpAttackWarTime: TDateTimePicker
            Left = 92
            Top = 35
            Width = 213
            Height = 20
            Hint = #35774#32622#33258#21160#25915#22478#26085#26399
            Date = 39582.619631793980000000
            Time = 39582.619631793980000000
            Enabled = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnChange = dtpAttackWarTimeChange
          end
          object cbbAutoOwenPlay1: TComboBox
            Left = 224
            Top = 59
            Width = 80
            Height = 20
            Hint = 
              #24403#21069#27801#24052#20811#21344#39046#34892#20250#25484#38376#20154#21464#37327#65292#35813#21464#37327#20250#22312#27599#27425#25915#22478#32467#26463#26102#33258#21160#23558#24403#21069#21344#39046#27801#34892#20250#25484#38376#20154#20445#23384#21040#35813#21464#37327#24403#20013#12290#13#10'('#21482#26377#20026#33258#21160#24320#21551#25915#22478#26102#25165#29983 +
              #25928')'
            Style = csDropDownList
            ItemHeight = 12
            ItemIndex = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            Text = #26080
            OnChange = cbbAutoOwenPlay1Change
            Items.Strings = (
              #26080)
          end
          object cbbAutoOwenPlay2: TComboBox
            Left = 224
            Top = 85
            Width = 80
            Height = 20
            Hint = #24403#21069#27801#24052#20811#21344#39046#34892#20250#25484#38376#20154#21464#37327#65292#35813#21464#37327#20250#22312#27599#27425#25915#22478#32467#26463#26102#33258#21160#23558#24403#21069#21344#39046#27801#34892#20250#25484#38376#20154#20445#23384#21040#35813#21464#37327#24403#20013#12290
            Style = csDropDownList
            ItemHeight = 12
            ItemIndex = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            Text = #26080
            OnChange = cbbAutoOwenPlay2Change
            Items.Strings = (
              #26080)
          end
          object cbbAutoOwenGuildName: TComboBox
            Left = 92
            Top = 59
            Width = 70
            Height = 20
            Hint = 
              '|'#24403#21069#27801#24052#20811#21344#39046#34892#20250#21517#31216#21464#37327#65292#35813#21464#37327#20250#22312#27599#27425#25915#22478#32467#26463#26102#33258#21160#23558#24403#21069#21344#39046#27801#34892#20250#21517#31216#20445#23384#21040#35813#21464#37327#24403#20013#12290#13#10'('#21482#26377#20026#33258#21160#24320#21551#25915#22478#26102#25165#29983#25928 +
              ')'
            Style = csDropDownList
            ItemHeight = 12
            ItemIndex = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Text = #26080
            OnChange = cbbAutoOwenGuildNameChange
            Items.Strings = (
              #26080)
          end
        end
        object GroupBox8: TGroupBox
          Left = 6
          Top = 124
          Width = 154
          Height = 76
          Caption = #34892#20250#21464#37327'('#20462#25913#31435#26082#29983#25928')'
          TabOrder = 1
          object Label15: TLabel
            Left = 8
            Top = 27
            Width = 54
            Height = 12
            Caption = #21344#39046#34892#20250':'
          end
          object cbbOwenGuildName: TComboBox
            Left = 64
            Top = 23
            Width = 80
            Height = 20
            Hint = #24403#21069#27801#24052#20811#21344#39046#34892#20250#21517#31216#21464#37327#65292#35813#21464#37327#20250#22312#27599#27425#25915#22478#32467#26463#26102#33258#21160#23558#24403#21069#21344#39046#27801#34892#20250#21517#31216#20445#23384#21040#35813#21464#37327#24403#20013#12290
            Style = csDropDownList
            ItemHeight = 12
            ItemIndex = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Text = #26080
            OnChange = cbbOwenGuildNameChange
            Items.Strings = (
              #26080)
          end
        end
        object GroupBox9: TGroupBox
          Left = 166
          Top = 124
          Width = 155
          Height = 76
          Caption = #22478#20027#21464#37327'('#20462#25913#31435#26082#29983#25928')'
          TabOrder = 2
          object Label16: TLabel
            Left = 8
            Top = 54
            Width = 54
            Height = 12
            Caption = #31532#20108#22478#20027':'
          end
          object Label17: TLabel
            Left = 8
            Top = 27
            Width = 54
            Height = 12
            Caption = #31532#19968#22478#20027':'
          end
          object cbbOwenPlay1: TComboBox
            Left = 64
            Top = 23
            Width = 80
            Height = 20
            Hint = #24403#21069#27801#24052#20811#21344#39046#34892#20250#25484#38376#20154#21464#37327#65292#35813#21464#37327#20250#22312#27599#27425#25915#22478#32467#26463#26102#33258#21160#23558#24403#21069#21344#39046#27801#34892#20250#25484#38376#20154#20445#23384#21040#35813#21464#37327#24403#20013#12290
            Style = csDropDownList
            ItemHeight = 12
            ItemIndex = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Text = #26080
            OnChange = cbbOwenPlay1Change
            Items.Strings = (
              #26080)
          end
          object cbbOwenPlay2: TComboBox
            Left = 64
            Top = 49
            Width = 80
            Height = 20
            Hint = #24403#21069#27801#24052#20811#21344#39046#34892#20250#25484#38376#20154#21464#37327#65292#35813#21464#37327#20250#22312#27599#27425#25915#22478#32467#26463#26102#33258#21160#23558#24403#21069#21344#39046#27801#34892#20250#25484#38376#20154#20445#23384#21040#35813#21464#37327#24403#20013#12290
            Style = csDropDownList
            ItemHeight = 12
            ItemIndex = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Text = #26080
            OnChange = cbbOwenPlay2Change
            Items.Strings = (
              #26080)
          end
        end
      end
    end
  end
end
