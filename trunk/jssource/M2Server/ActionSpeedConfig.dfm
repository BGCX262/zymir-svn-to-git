object frmActionSpeed: TfrmActionSpeed
  Left = 520
  Top = 137
  ActiveControl = ButtonClose
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #32452#20840#25805#20316#36895#24230#35774#32622
  ClientHeight = 256
  ClientWidth = 318
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 12
  object Label5: TLabel
    Left = 11
    Top = 240
    Width = 288
    Height = 12
    Caption = #21442#25968#35843#25972#21518#65292#22312#28216#25103#20013#20154#29289#23567#36864#21518#22833#25928#65292#38750#31435#21363#29983#25928#12290
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 10
    Top = 10
    Width = 296
    Height = 193
    TabOrder = 0
    object GroupBox3: TGroupBox
      Left = 150
      Top = 17
      Width = 134
      Height = 48
      TabOrder = 0
      object Label15: TLabel
        Left = 10
        Top = 22
        Width = 54
        Height = 12
        Caption = #36305#20301#38388#38548':'
      end
      object EditRunLongHitIntervalTime: TSpinEdit
        Left = 66
        Top = 17
        Width = 48
        Height = 21
        Hint = #36305#20301#21050#26432#25915#20987#38388#38548#65292#21333#20301'('#27627#31186')'
        EditorEnabled = False
        Increment = 10
        MaxValue = 2000
        MinValue = 10
        TabOrder = 0
        Value = 350
        OnChange = EditRunLongHitIntervalTimeChange
      end
      object CheckBoxControlRunLongHit: TCheckBox
        Left = 10
        Top = 0
        Width = 117
        Height = 16
        Hint = #26159#21542#23545#36305#20301#21050#26432#36827#34892#25511#21046
        Caption = #21551#29992#36305#20301#21050#26432#25511#21046
        TabOrder = 1
        OnClick = CheckBoxControlRunLongHitClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 10
      Top = 17
      Width = 134
      Height = 48
      Caption = #32452#21512#25805#20316#38388#38548
      TabOrder = 1
      object Label2: TLabel
        Left = 10
        Top = 22
        Width = 54
        Height = 12
        Caption = #38388#38548#26102#38388':'
      end
      object EditActionIntervalTime: TSpinEdit
        Left = 66
        Top = 17
        Width = 48
        Height = 21
        Hint = #25511#21046#32452#21512#26222#36890#25805#20316#38388#38548#26102#38388#65292#21333#20301'('#27627#31186')'
        EditorEnabled = False
        Increment = 10
        MaxValue = 2000
        MinValue = 10
        TabOrder = 0
        Value = 350
        OnChange = EditActionIntervalTimeChange
      end
    end
    object CheckBoxControlActionInterval: TCheckBox
      Left = 10
      Top = 0
      Width = 116
      Height = 16
      Hint = #26159#21542#23545#32452#21512#25805#20316#36827#34892#25511#21046
      Caption = #21551#29992#32452#21512#25805#20316#25511#21046
      TabOrder = 2
      OnClick = CheckBoxControlActionIntervalClick
    end
    object GroupBox4: TGroupBox
      Left = 10
      Top = 70
      Width = 134
      Height = 48
      TabOrder = 3
      object Label1: TLabel
        Left = 10
        Top = 22
        Width = 54
        Height = 12
        Caption = #36305#20301#38388#38548':'
      end
      object EditRunHitIntervalTime: TSpinEdit
        Left = 66
        Top = 17
        Width = 48
        Height = 21
        Hint = #25511#21046#36305#27493#25915#20987#38388#38548#26102#38388#65292#21333#20301'('#27627#31186')'
        EditorEnabled = False
        Increment = 10
        MaxValue = 2000
        MinValue = 10
        TabOrder = 0
        Value = 350
        OnChange = EditRunHitIntervalTimeChange
      end
      object CheckBoxControlRunHit: TCheckBox
        Left = 10
        Top = 0
        Width = 117
        Height = 16
        Hint = #26159#21542#23545#36305#27493#36827#34892#25511#21046
        Caption = #21551#29992#36305#20301#25915#20987#25511#21046
        TabOrder = 1
        OnClick = CheckBoxControlRunHitClick
      end
    end
    object GroupBox5: TGroupBox
      Left = 150
      Top = 70
      Width = 134
      Height = 48
      TabOrder = 4
      object Label3: TLabel
        Left = 10
        Top = 22
        Width = 54
        Height = 12
        Caption = #36208#20301#38388#38548':'
      end
      object EditWalkHitIntervalTime: TSpinEdit
        Left = 66
        Top = 17
        Width = 48
        Height = 21
        Hint = #36208#20301#25915#20987#26102#38388#38388#38548#65292#21333#20301'('#27627#31186')'
        EditorEnabled = False
        Increment = 10
        MaxValue = 2000
        MinValue = 10
        TabOrder = 0
        Value = 350
        OnChange = EditWalkHitIntervalTimeChange
      end
      object CheckBoxControlWalkHit: TCheckBox
        Left = 10
        Top = 0
        Width = 117
        Height = 16
        Hint = #26159#21542#23545#36208#20301#25915#20987#36827#34892#25511#21046
        Caption = #21551#29992#36208#20301#25915#20987#25511#21046
        TabOrder = 1
        OnClick = CheckBoxControlWalkHitClick
      end
    end
    object GroupBox6: TGroupBox
      Left = 10
      Top = 126
      Width = 134
      Height = 48
      TabOrder = 5
      object Label4: TLabel
        Left = 10
        Top = 22
        Width = 54
        Height = 12
        Caption = #36305#20301#38388#38548':'
      end
      object EditRunMagicIntervalTime: TSpinEdit
        Left = 66
        Top = 17
        Width = 48
        Height = 21
        Hint = #36305#20301#39764#27861#38388#38548#26102#38388#65292#21333#20301'('#27627#31186')'
        EditorEnabled = False
        Increment = 10
        MaxValue = 2000
        MinValue = 10
        TabOrder = 0
        Value = 350
        OnChange = EditRunMagicIntervalTimeChange
      end
      object CheckBoxControlRunMagic: TCheckBox
        Left = 10
        Top = 0
        Width = 117
        Height = 16
        Hint = #26159#21542#23545#36305#20301#39764#27861#36827#34892#25511#21046
        Caption = #21551#29992#36305#20301#39764#27861#25511#21046
        TabOrder = 1
        OnClick = CheckBoxControlRunMagicClick
      end
    end
  end
  object ButtonSave: TButton
    Left = 84
    Top = 208
    Width = 65
    Height = 25
    Caption = #20445#23384'(&S)'
    TabOrder = 1
    OnClick = ButtonSaveClick
  end
  object ButtonDefault: TButton
    Left = 10
    Top = 208
    Width = 65
    Height = 25
    Caption = #40664#35748'(&D)'
    TabOrder = 2
    OnClick = ButtonDefaultClick
  end
  object ButtonClose: TButton
    Left = 241
    Top = 207
    Width = 65
    Height = 25
    Caption = #20851#38381'(&C)'
    Default = True
    TabOrder = 3
    OnClick = ButtonCloseClick
  end
  object CheckBoxIncremeng: TCheckBox
    Left = 160
    Top = 209
    Width = 75
    Height = 21
    Caption = #24494#35843#21442#25968
    TabOrder = 4
    OnClick = CheckBoxIncremengClick
  end
end
