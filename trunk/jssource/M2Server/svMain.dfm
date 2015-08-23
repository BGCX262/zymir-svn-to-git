object FrmMain: TFrmMain
  Left = 194
  Top = 102
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 296
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object MemoLog: TMemo
    Left = 0
    Top = 0
    Width = 433
    Height = 129
    Align = alTop
    BevelInner = bvNone
    Ctl3D = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnChange = MemoLogChange
    OnDblClick = MemoLogDblClick
  end
  object GridGate: TStringGrid
    Left = 0
    Top = 202
    Width = 433
    Height = 94
    Align = alBottom
    ColCount = 7
    Ctl3D = True
    DefaultRowHeight = 15
    FixedCols = 0
    RowCount = 8
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentCtl3D = False
    TabOrder = 2
    ColWidths = (
      28
      110
      56
      54
      52
      50
      56)
  end
  object Panel1: TPanel
    Left = 0
    Top = 129
    Width = 433
    Height = 73
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object LbUserCount: TLabel
      Left = 363
      Top = 5
      Width = 66
      Height = 12
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'LbUserCount'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      Transparent = False
    end
    object LbRunTime: TLabel
      Left = 375
      Top = 21
      Width = 54
      Height = 12
      Alignment = taRightJustify
      Caption = 'LbRunTime'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 2
      Top = 29
      Width = 42
      Height = 12
      Caption = 'Label20'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 2
      Top = 16
      Width = 36
      Height = 12
      Caption = 'Label2'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 2
      Top = 2
      Width = 36
      Height = 12
      Caption = 'Label1'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object PCTimeCount: TLabel
      Left = 363
      Top = 37
      Width = 66
      Height = 12
      Alignment = taRightJustify
      Caption = 'PCTimeCount'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object LabelMon: TLabel
      Left = 2
      Top = 57
      Width = 48
      Height = 12
      Caption = 'LabelMon'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object LabelVersion: TLabel
      Left = 357
      Top = 53
      Width = 72
      Height = 12
      Alignment = taRightJustify
      Caption = 'LabelVersion'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label3: TLabel
      Left = 2
      Top = 43
      Width = 36
      Height = 12
      Caption = 'Label3'
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    Left = 56
    Top = 16
  end
  object RunTimer: TTimer
    Enabled = False
    Interval = 1
    Left = 88
    Top = 16
  end
  object DBSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 6000
    Left = 56
    Top = 80
  end
  object ConnectTimer: TTimer
    Enabled = False
    Interval = 3000
    Left = 56
    Top = 48
  end
  object StartTimer: TTimer
    Enabled = False
    Interval = 100
    Left = 120
    Top = 16
  end
  object SaveVariableTimer: TTimer
    Interval = 10000
    Left = 152
    Top = 16
  end
  object CloseTimer: TTimer
    Enabled = False
    Interval = 100
    Left = 88
    Top = 48
  end
  object MainMenu: TMainMenu
    Left = 120
    Top = 80
    object MENU_CONTROL: TMenuItem
      Caption = #25511#21046'(&C)'
      OnClick = MENU_CONTROLClick
      object MENU_CONTROL_START: TMenuItem
        Caption = #21551#21160#26381#21153'(&S)'
        Visible = False
        OnClick = MENU_CONTROL_STARTClick
      end
      object MENU_CONTROL_STOP: TMenuItem
        Caption = #20572#27490#26381#21153'(&T)'
        Visible = False
        OnClick = MENU_CONTROL_STOPClick
      end
      object MENU_CONTROL_CLEARLOGMSG: TMenuItem
        Caption = #28165#38500#26085#24535'(&C)'
        OnClick = MENU_CONTROL_CLEARLOGMSGClick
      end
      object MENU_CONTROL_CLEARSERVERVAR: TMenuItem
        Caption = #20840#23616#21464#37327'(&A)'
        OnClick = MENU_CONTROL_CLEARSERVERVARClick
      end
      object MENU_CONTROL_RELOAD: TMenuItem
        Caption = #37325#26032#21152#36733'(&R)'
        object MENU_CONTROL_RELOAD_ITEMDB: TMenuItem
          Caption = #29289#21697#25968#25454#24211'(&I)'
          OnClick = MENU_CONTROL_RELOAD_ITEMDBClick
        end
        object MENU_CONTROL_RELOAD_MAGICDB: TMenuItem
          Caption = #25216#33021#25968#25454#24211'(&S)'
          OnClick = MENU_CONTROL_RELOAD_MAGICDBClick
        end
        object MENU_CONTROL_RELOAD_MONSTERDB: TMenuItem
          Caption = #24618#29289#25968#25454#24211'(&M)'
          OnClick = MENU_CONTROL_RELOAD_MONSTERDBClick
        end
        object MENU_CONTROL_RELOAD_MONSTERSAY: TMenuItem
          Caption = #24618#29289#35828#35805#35774#32622'(&Y)'
          OnClick = MENU_CONTROL_RELOAD_MONSTERSAYClick
        end
        object MENU_CONTROL_RELOAD_DISABLEMAKE: TMenuItem
          Caption = #25968#25454#21015#34920'(&D)'
          OnClick = MENU_CONTROL_RELOAD_DISABLEMAKEClick
        end
        object MENU_CONTROL_RELOAD_STARTPOINT: TMenuItem
          Caption = #22320#22270#23433#20840#21306'(&Z)'
          OnClick = MENU_CONTROL_RELOAD_STARTPOINTClick
        end
        object MENU_CONTROL_RELOAD_CASTLE: TMenuItem
          Caption = #27801#22478#37197#32622'(&C)'
          OnClick = MENU_CONTROL_RELOAD_CASTLEClick
        end
        object MENU_CONTROL_RELOAD_CONF: TMenuItem
          Caption = #21442#25968#35774#32622'(&V)'
          OnClick = MENU_CONTROL_RELOAD_CONFClick
        end
        object N2: TMenuItem
          Caption = '-'
        end
        object MENU_CONTROL_RELOAD_MANAGE: TMenuItem
          Caption = #30331#24405#33050#26412'(&Q)'
          OnClick = MENU_CONTROL_RELOAD_MANAGEClick
        end
        object MENU_CONTROL_RELOAD_FUN: TMenuItem
          Caption = #21151#33021#33050#26412'(&F)'
          OnClick = MENU_CONTROL_RELOAD_MANAGEClick
        end
        object MENU_CONTROL_RELOAD_BOXS: TMenuItem
          Caption = #23453#31665#37197#32622'(&B)'
          OnClick = MENU_CONTROL_RELOAD_BOXSClick
        end
      end
      object MENU_CONTROL_GATE: TMenuItem
        Caption = #28216#25103#32593#20851'(&G)'
        Visible = False
        object MENU_CONTROL_GATE_OPEN: TMenuItem
          Caption = #25171#24320'(&O)'
          OnClick = MENU_CONTROL_GATE_OPENClick
        end
        object MENU_CONTROL_GATE_CLOSE: TMenuItem
          Caption = #20851#38381'(&C)'
          OnClick = MENU_CONTROL_GATE_CLOSEClick
        end
      end
      object MENU_CONTROL_EXIT: TMenuItem
        Caption = #36864#20986'(&X)'
        OnClick = MENU_CONTROL_EXITClick
      end
    end
    object MENU_VIEW: TMenuItem
      Caption = #26597#30475'(&V)'
      object MENU_VIEW_ONLINEHUMAN: TMenuItem
        Caption = #22312#32447#20154#29289'(&O)'
        OnClick = MENU_VIEW_ONLINEHUMANClick
      end
      object S1: TMenuItem
        Caption = #25490#34892#21015#34920'(&H)'
        OnClick = S1Click
      end
      object MENU_VIEW_SESSION: TMenuItem
        Caption = #20840#23616#20250#35805'(&S)'
        OnClick = MENU_VIEW_SESSIONClick
      end
      object MENU_VIEW_LEVEL: TMenuItem
        Caption = #31561#32423#23646#24615'(&L)'
        OnClick = MENU_VIEW_LEVELClick
      end
      object MENU_VIEW_LIST: TMenuItem
        Caption = #21015#34920#20449#24687'(&Z)'
        OnClick = MENU_VIEW_LISTClick
      end
      object MENU_VIEW_LIST2: TMenuItem
        Caption = #21015#34920#20449#24687#20108'(&T)'
        OnClick = MENU_VIEW_LIST2Click
      end
      object MENU_VIEW_KERNELINFO: TMenuItem
        Caption = #20869#26680#25968#25454'(&K)'
        OnClick = MENU_VIEW_KERNELINFOClick
      end
      object MENU_VIEW_GATE: TMenuItem
        Caption = #32593#20851#29366#24577'(&G)'
        Checked = True
        OnClick = MENU_VIEW_GATEClick
      end
    end
    object MENU_OPTION: TMenuItem
      Caption = #36873#39033'(&P)'
      object MENU_OPTION_GENERAL: TMenuItem
        Caption = #22522#26412#35774#32622'(&G)'
        OnClick = MENU_OPTION_GENERALClick
      end
      object MENU_OPTION_GAME: TMenuItem
        Caption = #21442#25968#35774#32622'(&O)'
        OnClick = MENU_OPTION_GAMEClick
      end
      object MENU_OPTION_ITEMFUNC: TMenuItem
        Caption = #29305#21697#35013#22791'(&I)'
        OnClick = MENU_OPTION_ITEMFUNCClick
      end
      object MENU_OPTION_FUNCTION: TMenuItem
        Caption = #21151#33021#35774#32622'(&F)'
        OnClick = MENU_OPTION_FUNCTIONClick
      end
      object G1: TMenuItem
        Caption = #28216#25103#21629#20196'(&C)'
        OnClick = G1Click
      end
      object MENU_OPTION_MONSTER: TMenuItem
        Caption = #24618#29289#35774#32622'(&M)'
        OnClick = MENU_OPTION_MONSTERClick
      end
      object MENU_OPTION_SERVERCONFIG: TMenuItem
        Caption = #24615#33021#21442#25968'(&P)'
        OnClick = MENU_OPTION_SERVERCONFIGClick
      end
    end
    object MENU_MANAGE: TMenuItem
      Caption = #31649#29702'(&M)'
      object MENU_MANAGE_ONLINEMSG: TMenuItem
        Caption = #22312#32447#28040#24687'(&S)'
        OnClick = MENU_MANAGE_ONLINEMSGClick
      end
      object MENU_MANAGE_PLUG: TMenuItem
        Caption = #21151#33021#25554#20214'(&P)'
        OnClick = MENU_MANAGE_PLUGClick
      end
      object MENU_MANAGE_CASTLE: TMenuItem
        Caption = #22478#22561#31649#29702'(&C)'
        OnClick = MENU_MANAGE_CASTLEClick
      end
      object MENU_MANAGE_GUILD: TMenuItem
        Caption = #34892#20250#31649#29702'(&G)'
        OnClick = MENU_MANAGE_GUILDClick
      end
    end
    object MENU_TOOLS: TMenuItem
      Caption = #24037#20855'(&T)'
      object MENU_TOOLS_MERCHANT: TMenuItem
        Caption = #20132#26131'NPC'#37197#32622'(&M)'
        OnClick = MENU_TOOLS_MERCHANTClick
      end
      object MENU_TOOLS_NPC: TMenuItem
        Caption = #31649#29702'NPC'#37197#32622'(&N)'
      end
      object MENU_TOOLS_MONGEN: TMenuItem
        Caption = #21047#24618#37197#32622'(&G)'
        OnClick = MENU_TOOLS_MONGENClick
      end
      object MENU_TOOLS_IPSEARCH: TMenuItem
        Caption = #22320#21306#26597#35810'(&S)'
        OnClick = MENU_TOOLS_IPSEARCHClick
      end
      object N1: TMenuItem
        Caption = #27979#35797
        Visible = False
        OnClick = N1Click
      end
    end
    object MENU_HELP: TMenuItem
      Caption = #24110#21161'(&H)'
      object MENU_HELP_ABOUT: TMenuItem
        Caption = #20851#20110'(&A)'
        ShortCut = 16449
        OnClick = MENU_HELP_ABOUTClick
      end
    end
  end
  object UDPClient: TIdUDPClient
    Host = '127.0.0.1'
    Port = 10000
    Left = 88
    Top = 80
  end
  object LabelTxt: TRSA
    CommonalityKey = '407999'
    CommonalityMode = '905668327801465049473396966751'
    Left = 120
    Top = 48
  end
  object ipper: TVCLZip
    ReplaceReadOnly = True
    Recurse = True
    StorePaths = True
    MultiZipInfo.BlockSize = 1457600
    AddDirEntriesOnRecurse = True
    Left = 152
    Top = 48
  end
end
