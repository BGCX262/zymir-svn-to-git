//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit PlugApi;

interface
uses M2Share, EngineType, SysUtils, Guild, grobal2;

type
  Type_GetMem = function(Size: Integer): Pointer; stdcall;
  Type_GetMemFreeMem = function(P: Pointer): Integer; stdcall;
  Type_GetMemReallocMem = function(P: Pointer; Size: Integer): Pointer; stdcall;

procedure TMemoryManager_Get(MemManager: _LPTMEMORYMANAGE); stdcall;
function TMemoryManager_AllocMemCount(): Integer; stdcall;
function TMemoryManager_AllocMemSize(): Integer; stdcall;

procedure MainOutMessageAPI(sMsg: PChar); stdcall;
procedure AddGameDataLogAPI(sMsg: PChar); stdcall;

function TConfig_sEnvirDir(): _LPTDIRNAME; stdcall;
function Config_sUserDataDir(): _LPTDIRNAME; stdcall;

function API_GetMem(Size: Integer): Pointer; stdcall;
function API_GetMemFreeMem(P: Pointer): Integer; stdcall;
function API_GetMemReallocMem(P: Pointer; Size: Integer): Pointer; stdcall;

function GetGameGoldName(): _LPTSHORTSTRING; stdcall;

function GetGameLogGold(): PBoolean; stdcall;
function GetGameLogGameGold(): PBoolean; stdcall;
function GetGameLogGamePoint(): PBoolean; stdcall;
function GetSellOffGoldTaxRate(): PInteger; stdcall;
function GetSellOffGameGoldTaxRate(): PInteger; stdcall;
function GetLevelItemRate(): PInteger; stdcall;
function GetLevelItemGoldCount(): PInteger; stdcall;
function GetLevelItemGameGoldCount(): PInteger; stdcall;
function GetLevelItemGameCount(): _LPTDIRNAME; stdcall;
procedure SetDemoNotice(Ver: Integer); stdcall;

procedure EDcode_Decode6BitBuf(pszSource: PChar; pszDest: PChar; nSrcLen,
  nDestLen: Integer); stdcall;
procedure EDcode_Encode6BitBuf(pszSource: PChar; pszDest: PChar; nSrcLen,
  nDestLen: Integer); stdcall;
procedure EDcode_SetDecode(Decode: _TEDCODE); stdcall;
procedure EDcode_SetEncode(Encode: _TEDCODE); stdcall;
procedure EDcode_SetScript1(Mode: PChar); stdcall;
procedure EDcode_SetScript2(Key: PChar); stdcall;

procedure SetLoginRegInfo1(RegInfo: PChar); stdcall;
procedure SetLoginRegInfo2(RegInfo: PChar); stdcall;

function TGuild_RankList(Guild: TGuild): TList; stdcall;
var
  TDIRNAME: _TDIRNAME;

implementation
uses
  EDcode;

procedure SetLoginRegInfo1(RegInfo: PChar); stdcall;
begin
end;

procedure SetLoginRegInfo2(RegInfo: PChar); stdcall;
begin
end;

function GetLevelItemGoldCount(): PInteger; stdcall;
begin
  try
    Result := @g_Config.nLevelItemGoldCount;
  except
    MainOutMessage('[Exception] UnPlugApi.GetLevelItemGoldCount');
  end;
end;

function GetLevelItemGameGoldCount(): PInteger; stdcall;
begin
  try
    Result := @g_Config.nLevelItemGameGoldCount;
  except
    MainOutMessage('[Exception] UnPlugApi.GetLevelItemGameGoldCount');
  end;
end;

function GetLevelItemRate(): PInteger; stdcall;
begin
  try
    Result := @g_Config.nLevelItemRate;
  except
    MainOutMessage('[Exception] UnPlugApi.GetSellOffGoldTaxRate');
  end;
end;

function GetSellOffGoldTaxRate(): PInteger; stdcall;
begin
  try
    Result := @g_Config.nSellOffGoldTaxRate;
  except
    MainOutMessage('[Exception] UnPlugApi.GetSellOffGoldTaxRate');
  end;
end;

function GetSellOffGameGoldTaxRate(): PInteger; stdcall;
begin
  try
    Result := @g_Config.nSellOffGameGoldTaxRate;
  except
    MainOutMessage('[Exception] UnPlugApi.GetSellOffGameGoldTaxRate');
  end;
end;

function GetGameLogGold(): PBoolean; stdcall;
begin
  try
    Result := @g_boGameLogGold;
  except
    MainOutMessage('[Exception] UnPlugApi.GetGameLogGold');
  end;
end;

function GetGameLogGameGold(): PBoolean; stdcall;
begin
  try
    Result := @g_boGameLogGameGold;
  except
    MainOutMessage('[Exception] UnPlugApi.GetGameLogGameGold');
  end;
end;

function GetGameLogGamePoint(): PBoolean; stdcall;
begin
  try
    Result := @g_boGameLogGamePoint;
  except
    MainOutMessage('[Exception] UnPlugApi.GetGameLogGamePoint');
  end;
end;

function TGuild_RankList(Guild: TGuild): TList; stdcall;
begin
  try
    Result := Guild.m_RankList;
  except
    MainOutMessage('[Exception] UnPlugApi.TGuild_RankList');
  end;
end;

procedure EDcode_SetDecode(Decode: _TEDCODE); stdcall;
begin
  try
    //m_Decode:=Decode;
  except
    MainOutMessage('[Exception] UnPlugApi.EDcode_SetDecode');
  end;
end;

procedure EDcode_SetEncode(Encode: _TEDCODE); stdcall;
begin
  try
    // Encode6BitBuf:=Encode;
  except
    MainOutMessage('[Exception] UnPlugApi.EDcode_SetEncode');
  end;
end;

procedure EDcode_SetScript1(Mode: PChar); stdcall;
begin
  sCommonalityMode := StrPas(Mode);
end;

procedure EDcode_SetScript2(Key: PChar); stdcall;
begin
  sPrivateKey := StrPas(Key);
end;

procedure EDcode_Decode6BitBuf(pszSource: PChar; pszDest: PChar; nSrcLen,
  nDestLen: Integer); stdcall;
begin
  try
    Decode6BitBuf(pszSource, pszDest, nSrcLen, nDestLen);
  except
    MainOutMessage('[Exception] UnPlugApi.EDcode_Decode6BitBuf');
  end;
end;

procedure EDcode_Encode6BitBuf(pszSource: PChar; pszDest: PChar; nSrcLen,
  nDestLen: Integer); stdcall;
begin
  try
    Encode6BitBuf(pszSource, pszDest, nSrcLen, nDestLen);
  except
    MainOutMessage('[Exception] UnPlugApi.EDcode_Encode6BitBuf');
  end;
end;

function GetGameGoldName(): _LPTSHORTSTRING; stdcall;
begin
  try
    Result := @g_Config.sGameGoldName;
  except
    MainOutMessage('[Exception] UnPlugApi.GetGameGoldName');
  end;
end;

procedure MainOutMessageAPI(sMsg: PChar); stdcall;
begin
  try
    MainOutMessage(sMsg);
  except
    MainOutMessage('[Exception] UnPlugApi.MainOutMessageAPI');
  end;
end;

procedure AddGameDataLogAPI(sMsg: PChar); stdcall;
begin
  try
    AddGameDataLog(sMsg);
  except
    MainOutMessage('[Exception] UnPlugApi.AddGameDataLogAPI');
  end;
end;

function TConfig_sEnvirDir(): _LPTDIRNAME; stdcall;
begin
  try
    Result := @g_Config.sEnvirDir[1];
  except
    MainOutMessage('[Exception] UnPlugApi.TConfig_sEnvirDir');
  end;
end;

procedure SetDemoNotice(Ver: Integer); stdcall;
begin
  g_Config.nDemoVerIdx := Ver;
end;

function GetLevelItemGameCount(): _LPTDIRNAME; stdcall;
begin
  try
    Result := @g_sFilePath[1];
  except
    MainOutMessage('[Exception] GetLevelItemGameCount');
  end;
end;

function Config_sUserDataDir(): _LPTDIRNAME; stdcall;
begin
  try
    Result := @g_Config.sUserDataDir[1];
  except
    MainOutMessage('[Exception] UnPlugApi.Config_sUserDataDir');
  end;
end;

procedure TMemoryManager_Get(MemManager: _LPTMEMORYMANAGE); stdcall;
begin
  try
    MemManager.GetMem := @API_GetMem;
    MemManager.FreeMem := @API_GetMemFreeMem;
    MemManager.ReallocMem := @API_GetMemReallocMem;
  except
    MainOutMessage('[Exception] UnPlugApi.TMemoryManager_Get');
  end;
end;

function API_GetMem(Size: Integer): Pointer;
begin
  try
    GetMem(Result, Size);
  except
    MainOutMessage('[Exception] UnPlugApi.API_GetMem');
  end;
end;

function API_GetMemFreeMem(P: Pointer): Integer;
begin
  try
    FreeMem(P);
    Result := 0;
  except
    MainOutMessage('[Exception] UnPlugApi.API_GetMemFreeMem');
  end;
end;

function API_GetMemReallocMem(P: Pointer; Size: Integer): Pointer;
begin
  try
    ReallocMem(P, Size);
    Result := nil;
  except
    MainOutMessage('[Exception] UnPlugApi.API_GetMemReallocMem');
  end;
end;

function TMemoryManager_AllocMemCount(): Integer; stdcall;
begin
  try
    Result := AllocMemCount;
  except
    MainOutMessage('[Exception] UnPlugApi.TMemoryManager_AllocMemCount');
  end;
end;

function TMemoryManager_AllocMemSize(): Integer; stdcall;
begin
  try
    Result := AllocMemSize;
  except
    MainOutMessage('[Exception] UnPlugApi.TMemoryManager_AllocMemSize');
  end;
end;

end.

