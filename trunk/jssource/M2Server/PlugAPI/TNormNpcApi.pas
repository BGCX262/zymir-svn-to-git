//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit TNormNpcApi;

interface
uses Windows, M2Share, EngineType, SysUtils, ObjBase, ObjNpc, grobal2;

function TNormNpc_sFilePath(NormNpc: TNormNpc): _LPTPATHNAME; stdcall;
function TNormNpc_sPath(NormNpc: TNormNpc): _LPTPATHNAME; stdcall;
procedure TNormNpc_GetLineVariableText(NormNpc: TNormNpc; PlayObject:
  TPlayObject; pszMsg: PChar; pszOutMsg: PChar; nOutMsgLen: Integer); stdcall;

procedure TNormNpc_SetScriptActionCmd(ActionCmd: _TSCRIPTCMD); stdcall;
function TNormNpc_GetScriptActionCmd(): _TSCRIPTCMD; stdcall;

procedure TNormNpc_SetScriptConditionCmd(ConditionCmd: _TSCRIPTCMD); stdcall;
function TNormNpc_GetScriptConditionCmd(): _TSCRIPTCMD; stdcall;

function TNormNpc_GetManageNpc(): TNormNpc; stdcall;
function TNormNpc_GetFunctionNpc(): TNormNpc; stdcall;
procedure TNormNpc_GotoLable(NormNpc: TNormNpc; PlayObject: TPlayObject;
  pszLabel: PChar); stdcall;

procedure TNormNpc_SetScriptAction(ScriptAction: _TSCRIPTACTION); stdcall;
function TNormNpc_GetScriptAction(): _TSCRIPTACTION; stdcall;

procedure TNormNpc_SetScriptCondition(ScriptAction: _TSCRIPTCONDITION); stdcall;
function TNormNpc_GetScriptCondition(): _TSCRIPTCONDITION; stdcall;

function TMerchant_GoodsList(Merchant: TMerchant): TList; stdcall;
function TMerchant_GetItemPrice(Merchant: TMerchant; nIndex: Integer): Integer;
  stdcall;
function TMerchant_GetUserPrice(Merchant: TMerchant; PlayObject: TPlayObject;
  nPrice: Integer): Integer; stdcall;
function TMerchant_GetUserItemPrice(Merchant: TMerchant; UserItem: pTUserItem):
  Integer; stdcall;
function TMerchant_boSellOff(Merchant: TMerchant): PBoolean; stdcall;

procedure TMerchant_SetHookClientGetDetailGoodsList(GetDetailGoods:
  _TOBJECTACTIONDETAILGOODS); stdcall;

implementation

function TMerchant_boSellOff(Merchant: TMerchant): PBoolean; stdcall;
begin
  try
    Result := @Merchant.m_boSellOff;
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TMerchant_boSellOff');
  end;
end;

procedure TMerchant_SetHookClientGetDetailGoodsList(GetDetailGoods:
  _TOBJECTACTIONDETAILGOODS); stdcall;
begin
  try
    m_HookClientGetDetailGoodsList := @GetDetailGoods;
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TMerchant_SetHookClientGetDetailGoodsList');
  end;
end;

function TMerchant_GetUserItemPrice(Merchant: TMerchant; UserItem: pTUserItem):
  Integer; stdcall;
begin
  try
    Result := Merchant.GetUserItemPrice(UserItem);
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TMerchant_GetUserItemPrice');
  end;
end;

function TMerchant_GetUserPrice(Merchant: TMerchant; PlayObject: TPlayObject;
  nPrice: Integer): Integer; stdcall;
begin
  try
    Result := Merchant.GetUserPrice(PlayObject, nPrice);
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TMerchant_GetUserPrice');
  end;
end;

function TMerchant_GetItemPrice(Merchant: TMerchant; nIndex: Integer): Integer;
  stdcall;
begin
  try
    Result := Merchant.GetItemPrice(nIndex);
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TMerchant_GetItemPrice');
  end;
end;

function TMerchant_GoodsList(Merchant: TMerchant): TList; stdcall;
begin
  try
    Result := MerChant.m_GoodsList;
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TMerchant_GoodsList');
  end;
end;

procedure TNormNpc_SetScriptActionCmd(ActionCmd: _TSCRIPTCMD); stdcall;
begin
  try
    //
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TNormNpc_SetScriptActionCmd');
  end;
end;

function TNormNpc_GetScriptActionCmd(): _TSCRIPTCMD; stdcall;
begin
  try
    //
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TNormNpc_GetScriptActionCmd');
  end;
end;

procedure TNormNpc_SetScriptConditionCmd(ConditionCmd: _TSCRIPTCMD); stdcall;
begin
  try
    //
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TNormNpc_SetScriptConditionCmd');
  end;
end;

function TNormNpc_GetScriptConditionCmd(): _TSCRIPTCMD; stdcall;
begin
  try
    //
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TNormNpc_GetScriptConditionCmd');
  end;
end;

function TNormNpc_GetManageNpc(): TNormNpc; stdcall;
begin
  try
    Result := g_ManageNPC;
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TNormNpc_GetManageNpc');
  end;
end;

function TNormNpc_GetFunctionNpc(): TNormNpc; stdcall;
begin
  try
    Result := g_FunctionNPC;
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TNormNpc_GetFunctionNpc');
  end;
end;

procedure TNormNpc_GotoLable(NormNpc: TNormNpc; PlayObject: TPlayObject;
  pszLabel: PChar); stdcall;
begin
  try
    NormNpc.GotoLable(PlayObject, pszLabel, False);
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TNormNpc_GotoLable');
  end;
end;

procedure TNormNpc_SetScriptAction(ScriptAction: _TSCRIPTACTION); stdcall;
begin
  try
    //
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TNormNpc_SetScriptAction');
  end;
end;

function TNormNpc_GetScriptAction(): _TSCRIPTACTION; stdcall;
begin
  try
    //
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TNormNpc_GetScriptAction');
  end;
end;

procedure TNormNpc_SetScriptCondition(ScriptAction: _TSCRIPTCONDITION); stdcall;
begin
  try
    //
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TNormNpc_SetScriptCondition');
  end;
end;

function TNormNpc_GetScriptCondition(): _TSCRIPTCONDITION; stdcall;
begin
  try
    //
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TNormNpc_GetScriptCondition');
  end;
end;

procedure TNormNpc_GetLineVariableText(NormNpc: TNormNpc; PlayObject:
  TPlayObject; pszMsg: PChar; pszOutMsg: PChar; nOutMsgLen: Integer); stdcall;
var
  sData: string;
begin
  try
    sData := NormNpc.GetLineVariableText(PlayObject, pszMsg);
    Move(sData[1], pszOutMsg^, nOutMsgLen);
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TNormNpc_GetLineVariableText');
  end;
end;

function TNormNpc_sPath(NormNpc: TNormNpc): _LPTPATHNAME; stdcall;
begin
  try
    Result := @NormNpc.m_sPath;
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TNormNpc_sPath');
  end;
end;

function TNormNpc_sFilePath(NormNpc: TNormNpc): _LPTPATHNAME; stdcall;
begin
  try
    Result := @NormNpc.m_sFilePath;
  except
    MainOutMessage('[Exception] UnTNormNpcApi.TNormNpc_sFilePath');
  end;
end;

end.

