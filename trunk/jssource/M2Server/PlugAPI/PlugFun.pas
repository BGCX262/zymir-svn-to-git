//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit PlugFun;

interface
uses WinDows, ObjBase, Grobal2;

type
  _TOBJECTACTION = procedure(PlayObject: TObject); stdcall;
  _TOBJECTACTIONEX = function(PlayObject: TObject): BOOL; stdcall;
  _TOBJECTACTIONXY = procedure(AObject, BObject: TObject; nX, nY: Integer);
    stdcall;
  _TOBJECTACTIONXYD = procedure(AObject, BObject: TObject; nX, nY: Integer;
    btDir: Byte); stdcall;
  _TOBJECTACTIONXYDM = procedure(AObject, BObject: TObject; nX, nY: Integer;
    btDir: Byte; nMode: Integer); stdcall;
  _TOBJECTACTIONXYDWS = procedure(AObject, BObject: TObject; wIdent: Word; nX,
    nY: Integer; btDir: Byte; pszMsg: PChar); stdcall;
  _TOBJECTACTIONOBJECT = procedure(AObject, BObject, CObject: TObject; nInt:
    Integer); stdcall;
  _TOBJECTACTIONDETAILGOODS = procedure(Merchant: TObject; PlayObject: TObject;
    pszItemName: PChar; nInt: Integer); stdcall;
  _TOBJECTUSERCMD = function(AObject: TObject; pszCmd, pszParam1, pszParam2,
    pszParam3, pszParam4, pszParam5, pszParam6, pszParam7: PChar): Boolean;
    stdcall;
  _TPLAYSENDSOCKET = function(AObject: TObject; DefMsg: PTDEFAULTMESSAGE;
    pszMsg: PChar): Boolean; stdcall;
  _TOBJECTACTIONITEM = function(AObject: TObject; pszItemName: PChar): Boolean;
    stdcall;
  _TOBJECTCLIENTMSG = function(PlayObject: TObject; DefMsg: PTDEFAULTMESSAGE;
    Buff: PChar; NewBuff: PChar): Integer; stdcall;
  _TOBJECTACTIONFEATURE = function(AObject, BObject: TObject): Integer; stdcall;
  _TOBJECTACTIONSENDGOODS = procedure(AObject: TObject; nNpcRecog, nCount,
    nPostion: Integer; pszData: PChar); stdcall;
  _TOBJECTACTIONCHECKUSEITEM = function(nIdx: Integer; StdItem: PTSTDITEM):
    Boolean; stdcall;

  _TOBJECTACTIONENTERMAP = function(AObject: TObject; Envir: TObject; nX, nY:
    Integer): Boolean; stdcall;
  _TOBJECTFILTERMSG = procedure(PlayObject: TObject; pszSrcMsg: PChar;
    pszDestMsg: PChar; nDestLen: Integer); stdcall;

  _TEDCODE = procedure(pszSource: PChar; pszDest: PChar; nSrcLen, nDestLen:
    Integer); stdcall;
  _TDOSPELL = function(AObject: TObject; PlayObject: TPlayObject; UserMagic:
    PTUSERMAGIC; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject; var
    nHookStatus: Integer): Boolean; stdcall;

  _TSCRIPTCMD = function(pszCmd: PChar): Integer; stdcall;

  _TSCRIPTACTION = procedure(Npc: TObject;
    PlayObject: TObject;
    nCmdCode: Integer;
    pszParam1: PChar;
    nParam1: Integer;
    pszParam2: PChar;
    nParam2: Integer;
    pszParam3: PChar;
    nParam3: Integer;
    pszParam4: PChar;
    nParam4: Integer;
    pszParam5: PChar;
    nParam5: Integer;
    pszParam6: PChar;
    nParam6: Integer); stdcall;
  _TSCRIPTCONDITION = function(Npc: TObject;
    PlayObject: TObject;
    nCmdCode: Integer;
    pszParam1: PChar;
    nParam1: Integer;
    pszParam2: PChar;
    nParam2: Integer;
    pszParam3: PChar;
    nParam3: Integer;
    pszParam4: PChar;
    nParam4: Integer;
    pszParam5: PChar;
    nParam5: Integer;
    pszParam6: PChar;
    nParam6: Integer): Boolean; stdcall;

  _TOBJECTOPERATEMESSAGE = function(BaseObject: TObject;
    wIdent: Word;
    wParam: Word;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    MsgObject: TObject;
    dwDeliveryTime: LongWord;
    pszMsg: PChar;
    var boReturn: Boolean): Boolean; stdcall;

  _TOBJECTUSERDATAMESSAGE = procedure(BaseObject: TObject;
    wIdent: Word;
    wParam: Word;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    pszMsg: PChar); stdcall;

implementation

end.

