object FormTaxis: TFormTaxis
  Left = 305
  Top = 120
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #25490#34892#27036#26597#35810
  ClientHeight = 459
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object PageTaxis: TPageControl
    Left = 8
    Top = 7
    Width = 393
    Height = 442
    ActivePage = TabSheet1
    TabOrder = 0
    OnChange = PageTaxisChange
    object TabSheet1: TTabSheet
      Caption = #20010#20154#27036
      object PageTaxisSelf: TPageControl
        Left = 2
        Top = 2
        Width = 379
        Height = 407
        ActivePage = TabSheet4
        TabOrder = 0
        OnChange = PageTaxisChange
        object TabSheet4: TTabSheet
          Caption = #32676#33521#27036
        end
        object TabSheet5: TTabSheet
          Caption = #25112#31070#27036
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object TabSheet6: TTabSheet
          Caption = #27861#22307#27036
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object TabSheet7: TTabSheet
          Caption = #36947#23562#27036
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
      end
      object SelfListView: TListView
        Left = 15
        Top = 31
        Width = 352
        Height = 370
        Columns = <
          item
            Caption = #24207#20301
            Width = 60
          end
          item
            Caption = #35282#33394#21517
            Width = 150
          end
          item
            Caption = #31561#32423
            Width = 60
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
      end
    end
    object TabSheet2: TTabSheet
      Caption = #33521#38596#27036
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object PageTaxisHero: TPageControl
        Left = 2
        Top = 2
        Width = 379
        Height = 407
        ActivePage = TabSheet8
        TabOrder = 0
        OnChange = PageTaxisChange
        object TabSheet8: TTabSheet
          Caption = #24635#25490#34892
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object TabSheet9: TTabSheet
          Caption = #25112#22763#33521#38596#27036
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object TabSheet10: TTabSheet
          Caption = #27861#24072#33521#38596#27036
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object TabSheet11: TTabSheet
          Caption = #36947#22763#33521#38596#27036
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
      end
      object HeroListView: TListView
        Left = 15
        Top = 31
        Width = 352
        Height = 370
        Columns = <
          item
            Caption = #24207#20301
          end
          item
            Caption = #33521#38596#21517
            Width = 110
          end
          item
            Caption = #35282#33394#21517
            Width = 110
          end
          item
            Caption = #31561#32423
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
      end
    end
    object TabSheet3: TTabSheet
      Caption = #21517#24072#27036
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object MasterListView: TListView
        Left = 7
        Top = 7
        Width = 370
        Height = 402
        Columns = <
          item
            Caption = #24207#20301
            Width = 60
          end
          item
            Caption = #35282#33394#21517
            Width = 150
          end
          item
            Caption = #20986#24072#24466#24351#25968
            Width = 100
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
  end
end
