object frmGameCmd: TfrmGameCmd
  Left = 192
  Top = 109
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #28216#25103#21629#20196#35774#32622
  ClientHeight = 309
  ClientWidth = 581
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl: TPageControl
    Left = 7
    Top = 6
    Width = 571
    Height = 299
    ActivePage = TabSheet2
    HotTrack = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #26222#36890#21629#20196
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object StringGridGameCmd: TStringGrid
        Left = 3
        Top = 10
        Width = 549
        Height = 160
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goRowSelect]
        TabOrder = 0
        OnClick = StringGridGameCmdClick
        ColWidths = (
          88
          62
          127
          248)
      end
      object GroupBox1: TGroupBox
        Left = 3
        Top = 176
        Width = 549
        Height = 91
        Caption = #21629#20196#35774#32622
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 21
          Width = 54
          Height = 12
          Caption = #21629#20196#21517#31216':'
        end
        object Label6: TLabel
          Left = 184
          Top = 20
          Width = 54
          Height = 12
          Caption = #25152#38656#26435#38480':'
        end
        object LabelUserCmdFunc: TLabel
          Left = 67
          Top = 69
          Width = 396
          Height = 15
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object LabelUserCmdParam: TLabel
          Left = 67
          Top = 45
          Width = 396
          Height = 15
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 8
          Top = 45
          Width = 54
          Height = 12
          Caption = #21629#20196#21151#33021':'
        end
        object Label3: TLabel
          Left = 8
          Top = 69
          Width = 54
          Height = 12
          Caption = #21629#20196#26684#24335':'
        end
        object EditUserCmdName: TEdit
          Left = 67
          Top = 17
          Width = 106
          Height = 20
          TabOrder = 0
          OnChange = EditUserCmdNameChange
        end
        object EditUserCmdPerMission: TSpinEdit
          Left = 243
          Top = 16
          Width = 41
          Height = 21
          MaxValue = 10
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditUserCmdPerMissionChange
        end
        object EditUserCmdOK: TButton
          Left = 470
          Top = 22
          Width = 65
          Height = 25
          Caption = #30830#23450'(&O)'
          TabOrder = 2
          OnClick = EditUserCmdOKClick
        end
        object EditUserCmdSave: TButton
          Left = 470
          Top = 56
          Width = 65
          Height = 25
          Caption = #20445#23384'(&S)'
          TabOrder = 3
          OnClick = EditUserCmdSaveClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #31649#29702#21629#20196
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 3
        Top = 176
        Width = 549
        Height = 91
        Caption = #21629#20196#35774#32622
        TabOrder = 0
        object Label4: TLabel
          Left = 8
          Top = 21
          Width = 54
          Height = 12
          Caption = #21629#20196#21517#31216':'
        end
        object Label5: TLabel
          Left = 184
          Top = 20
          Width = 54
          Height = 12
          Caption = #25152#38656#26435#38480':'
        end
        object LabelGameMasterCmdFunc: TLabel
          Left = 67
          Top = 69
          Width = 396
          Height = 15
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object LabelGameMasterCmdParam: TLabel
          Left = 67
          Top = 45
          Width = 396
          Height = 15
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 8
          Top = 45
          Width = 54
          Height = 12
          Caption = #21629#20196#21151#33021':'
        end
        object Label8: TLabel
          Left = 8
          Top = 69
          Width = 54
          Height = 12
          Caption = #21629#20196#26684#24335':'
        end
        object EditGameMasterCmdName: TEdit
          Left = 67
          Top = 17
          Width = 106
          Height = 20
          TabOrder = 0
          OnChange = EditGameMasterCmdNameChange
        end
        object EditGameMasterCmdPerMission: TSpinEdit
          Left = 243
          Top = 16
          Width = 41
          Height = 21
          MaxValue = 10
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditGameMasterCmdPerMissionChange
        end
        object EditGameMasterCmdOK: TButton
          Left = 470
          Top = 22
          Width = 65
          Height = 25
          Caption = #30830#23450'(&O)'
          TabOrder = 2
          OnClick = EditGameMasterCmdOKClick
        end
        object EditGameMasterCmdSave: TButton
          Left = 470
          Top = 56
          Width = 65
          Height = 25
          Caption = #20445#23384'(&S)'
          TabOrder = 3
          OnClick = EditGameMasterCmdSaveClick
        end
      end
      object StringGridGameMasterCmd: TStringGrid
        Left = 3
        Top = 10
        Width = 549
        Height = 160
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goRowSelect]
        TabOrder = 1
        OnClick = StringGridGameMasterCmdClick
        ColWidths = (
          88
          62
          127
          248)
      end
    end
    object TabSheet3: TTabSheet
      Caption = #35843#35797#21629#20196
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox3: TGroupBox
        Left = 3
        Top = 176
        Width = 549
        Height = 91
        Caption = #21629#20196#35774#32622
        TabOrder = 0
        object Label9: TLabel
          Left = 8
          Top = 21
          Width = 54
          Height = 12
          Caption = #21629#20196#21517#31216':'
        end
        object Label10: TLabel
          Left = 184
          Top = 20
          Width = 54
          Height = 12
          Caption = #25152#38656#26435#38480':'
        end
        object LabelGameDebugCmdFunc: TLabel
          Left = 67
          Top = 69
          Width = 396
          Height = 15
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object LabelGameDebugCmdParam: TLabel
          Left = 67
          Top = 45
          Width = 396
          Height = 15
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 8
          Top = 45
          Width = 54
          Height = 12
          Caption = #21629#20196#21151#33021':'
        end
        object Label12: TLabel
          Left = 8
          Top = 69
          Width = 54
          Height = 12
          Caption = #21629#20196#26684#24335':'
        end
        object EditGameDebugCmdName: TEdit
          Left = 67
          Top = 17
          Width = 106
          Height = 20
          TabOrder = 0
          OnChange = EditGameDebugCmdNameChange
        end
        object EditGameDebugCmdPerMission: TSpinEdit
          Left = 243
          Top = 16
          Width = 41
          Height = 21
          MaxValue = 10
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditGameDebugCmdPerMissionChange
        end
        object EditGameDebugCmdOK: TButton
          Left = 470
          Top = 22
          Width = 65
          Height = 25
          Caption = #30830#23450'(&O)'
          TabOrder = 2
          OnClick = EditGameDebugCmdOKClick
        end
        object EditGameDebugCmdSave: TButton
          Left = 470
          Top = 56
          Width = 65
          Height = 25
          Caption = #20445#23384'(&S)'
          TabOrder = 3
          OnClick = EditGameDebugCmdSaveClick
        end
      end
      object StringGridGameDebugCmd: TStringGrid
        Left = 3
        Top = 10
        Width = 549
        Height = 160
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goRowSelect]
        TabOrder = 1
        OnClick = StringGridGameDebugCmdClick
        ColWidths = (
          88
          62
          127
          248)
      end
    end
  end
end
