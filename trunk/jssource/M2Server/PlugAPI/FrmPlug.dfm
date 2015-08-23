object FormPlug: TFormPlug
  Left = 195
  Top = 133
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #21151#33021#25554#20214
  ClientHeight = 211
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object ListBoxPlug: TListBox
    Left = 8
    Top = 8
    Width = 345
    Height = 193
    ItemHeight = 12
    TabOrder = 0
    OnClick = ListBoxPlugClick
    OnDblClick = ListBoxPlugDblClick
  end
  object ButtonConfig: TButton
    Left = 360
    Top = 16
    Width = 75
    Height = 25
    Caption = #37197#32622'(&C)'
    Enabled = False
    TabOrder = 1
    OnClick = ButtonConfigClick
  end
end
