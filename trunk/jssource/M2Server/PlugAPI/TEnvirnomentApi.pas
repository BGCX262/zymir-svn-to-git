//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit TEnvirnomentApi;

interface
uses Classes, Windows, M2Share, EngineType, SysUtils, ObjBase, Envir, grobal2;

function TMapManager_FindMap(pszMapName: PChar): TEnvirnoment; stdcall;
function TEnvirnoment_GetRangeBaseObject(Envir: TEnvirnoment; nX, nY, nRage:
  Integer; boFlag: Boolean; BaseObjectList: Classes.TList): Integer; stdcall;
function TEnvirnoment_boCANRIDE(Envir: TEnvirnoment): PBoolean; stdcall;
function TEnvirnoment_boCANBAT(Envir: TEnvirnoment): PBoolean; stdcall;

implementation

function TEnvirnoment_boCANBAT(Envir: TEnvirnoment): PBoolean; stdcall;
begin
  try
    Result := @Envir.Flag.boNOHORSE;
  except
    MainOutMessage('[Exception] UnTEnvirnomentApi.TEnvirnoment_boCANBAT');
  end;
end;

function TEnvirnoment_boCANRIDE(Envir: TEnvirnoment): PBoolean; stdcall;
begin
  try
    Result := @Envir.Flag.boNOHORSE;
  except
    MainOutMessage('[Exception] UnTEnvirnomentApi.TEnvirnoment_boCANRIDE');
  end;
end;

function TEnvirnoment_GetRangeBaseObject(Envir: TEnvirnoment; nX, nY, nRage:
  Integer; boFlag: Boolean; BaseObjectList: Classes.TList): Integer; stdcall;
begin
  try
    Result := Envir.GetRangeBaseObject(nX, nY, nRage, boFlag, BaseObjectList);
  except
    MainOutMessage('[Exception] UnTEnvirnomentApi.TEnvirnoment_GetRangeBaseObject');
  end;
end;

function TMapManager_FindMap(pszMapName: PChar): TEnvirnoment; stdcall;
begin
  try
    Result := g_MapManager.FindMap(pszMapName);
  except
    MainOutMessage('[Exception] UnTEnvirnomentApi.TMapManager_FindMap');
  end;
end;

end.

