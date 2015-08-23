object FormAttack: TFormAttack
  Left = 199
  Top = 131
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'FormAttack'
  ClientHeight = 295
  ClientWidth = 336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 200
    Width = 321
    Height = 89
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 54
      Height = 12
      Caption = #34892#20250#21517#31216':'
    end
    object Label2: TLabel
      Left = 8
      Top = 54
      Width = 54
      Height = 12
      Caption = #25915#22478#26102#38388':'
    end
    object EditName: TEdit
      Left = 64
      Top = 21
      Width = 161
      Height = 20
      TabOrder = 0
    end
    object DateTimePicker: TDateTimePicker
      Left = 64
      Top = 51
      Width = 161
      Height = 20
      Date = 39226.633125000000000000
      Time = 39226.633125000000000000
      TabOrder = 1
    end
    object CheckBox: TCheckBox
      Left = 232
      Top = 24
      Width = 67
      Height = 17
      Caption = #25152#26377#34892#20250
      TabOrder = 2
      OnClick = CheckBoxClick
    end
    object Button1: TButton
      Left = 232
      Top = 48
      Width = 75
      Height = 25
      Caption = #30830#23450'(&O)'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 321
    Height = 185
    Caption = #34892#20250#21015#34920
    TabOrder = 1
    object ListBoxGuild: TListBox
      Left = 8
      Top = 16
      Width = 305
      Height = 161
      ItemHeight = 12
      TabOrder = 0
      OnClick = ListBoxGuildClick
    end
  end
end
