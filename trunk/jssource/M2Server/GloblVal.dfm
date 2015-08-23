object FormGloblVal: TFormGloblVal
  Left = 401
  Top = 99
  BorderIcons = [biSystemMenu]
  Caption = #20840#23616#21464#37327#25805#20316
  ClientHeight = 389
  ClientWidth = 454
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 441
    Height = 377
    ActivePage = TabSheet1
    Style = tsButtons
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = #20840#23616#25968#20540#21464#37327
      object Label1: TLabel
        Left = -1
        Top = 11
        Width = 192
        Height = 12
        Caption = #21452#20987#36873#39033#30452#25509#20462#25913#65292#20462#25913#31435#26082#29983#25928#12290
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = #20840#23616#23383#31526#20018#21464#37327
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label2: TLabel
        Left = -1
        Top = 11
        Width = 192
        Height = 12
        Caption = #21452#20987#36873#39033#30452#25509#20462#25913#65292#20462#25913#31435#26082#29983#25928#12290
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object ListView1: TListView
    Left = 8
    Top = 72
    Width = 433
    Height = 313
    Columns = <
      item
        Caption = #21464#37327'ID'
      end
      item
        Caption = #21464#37327#20540
        Width = 350
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnDblClick = ListView1DblClick
  end
  object Button1: TButton
    Left = 360
    Top = 38
    Width = 82
    Height = 25
    Caption = #20840#37096#28165#31354'(&A)'
    TabOrder = 2
    OnClick = Button1Click
  end
end
