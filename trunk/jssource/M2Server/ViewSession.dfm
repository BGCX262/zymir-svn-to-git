object frmViewSession: TfrmViewSession
  Left = 256
  Top = 166
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #26597#30475#20840#23616#20250#35805
  ClientHeight = 168
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object ButtonRefGrid: TButton
    Left = 10
    Top = 142
    Width = 70
    Height = 25
    Caption = #21047#26032'(&R)'
    TabOrder = 0
    OnClick = ButtonRefGridClick
  end
  object PanelStatus: TPanel
    Left = 8
    Top = 8
    Width = 393
    Height = 127
    BevelOuter = bvNone
    TabOrder = 1
    object GridSession: TStringGrid
      Left = 0
      Top = 0
      Width = 393
      Height = 127
      Align = alClient
      ColCount = 6
      DefaultRowHeight = 18
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 0
      ColWidths = (
        34
        82
        86
        55
        43
        63)
    end
  end
end
