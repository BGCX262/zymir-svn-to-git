//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit TStringListApi;

interface
uses Classes;

function TStringList_Create(): TStringList; stdcall;
procedure TStringList_Free(List: TStringList); stdcall;
function TStringList_Count(List: TStringList): Integer; stdcall;
function TStringList_Add(List: TStringList; S: PChar): Integer; stdcall;
function TStringList_AddObject(List: TStringList; S: PChar; AObject: TObject):
  Integer; stdcall;
procedure TStringList_Insert(List: TStringList; nIndex: Integer; S: PChar);
  stdcall;
function TStringList_Get(List: TStringList; nIndex: Integer): PChar; stdcall;
function TStringList_GetObject(List: TStringList; nIndex: Integer): TObject;
  stdcall;
procedure TStringList_Put(List: TStringList; nIndex: Integer; S: PChar);
  stdcall;
procedure TStringList_PutObject(List: TStringList; nIndex: Integer; AObject:
  TObject); stdcall;
procedure TStringList_Delete(List: TStringList; nIndex: Integer); stdcall;
procedure TStringList_Clear(List: TStringList); stdcall;
procedure TStringList_Exchange(List: TStringList; nIndex1, nIndex2: Integer);
  stdcall;
procedure TStringList_LoadFormFile(List: TStringList; pszFileName: PChar);
  stdcall;
procedure TStringList_SaveToFile(List: TStringList; pszFileName: PChar);
  stdcall;

implementation
uses
  M2Share;

function TStringList_Create(): TStringList; stdcall;
begin
  try
    Result := TStringList.Create;
  except
    MainOutMessage('[Exception] UnTStringListApi.TStringList_Create');
  end;
end;

procedure TStringList_Free(List: TStringList); stdcall;
begin
  try
    List.Free;
  except
    MainOutMessage('[Exception] UnTStringListApi.TStringList_Free');
  end;
end;

function TStringList_Count(List: TStringList): Integer; stdcall;
begin
  try
    Result := List.Count;
  except
    MainOutMessage('[Exception] UnTStringListApi.TStringList_Count');
  end;
end;

function TStringList_Add(List: TStringList; S: PChar): Integer; stdcall;
begin
  try
    Result := List.Add(S);
  except
    MainOutMessage('[Exception] UnTStringListApi.TStringList_Add');
  end;
end;

function TStringList_AddObject(List: TStringList; S: PChar; AObject: TObject):
  Integer; stdcall;
begin
  try
    Result := List.AddObject(S, AObject);
  except
    MainOutMessage('[Exception] UnTStringListApi.TStringList_AddObject');
  end;
end;

procedure TStringList_Insert(List: TStringList; nIndex: Integer; S: PChar);
  stdcall;
begin
  try
    List.Insert(nIndex, S);
  except
    MainOutMessage('[Exception] UnTStringListApi.TStringList_Insert');
  end;
end;

function TStringList_Get(List: TStringList; nIndex: Integer): PChar; stdcall;
begin
  try
    Result := PChar(List.Strings[nIndex]);
  except
    MainOutMessage('[Exception] UnTStringListApi.TStringList_Get');
  end;
end;

function TStringList_GetObject(List: TStringList; nIndex: Integer): TObject;
  stdcall;
begin
  try
    Result := List.Objects[nIndex];
  except
    MainOutMessage('[Exception] UnTStringListApi.TStringList_GetObject');
  end;
end;

procedure TStringList_Put(List: TStringList; nIndex: Integer; S: PChar);
  stdcall;
begin
  try
  except
    MainOutMessage('[Exception] UnTStringListApi.TStringList_Put');
  end;
end;

procedure TStringList_PutObject(List: TStringList; nIndex: Integer; AObject:
  TObject); stdcall;
begin
  try
  except
    MainOutMessage('[Exception] UnTStringListApi.TStringList_PutObject');
  end;
end;

procedure TStringList_Delete(List: TStringList; nIndex: Integer); stdcall;
begin
  try
    List.Delete(nIndex);
  except
    MainOutMessage('[Exception] UnTStringListApi.TStringList_Delete');
  end;
end;

procedure TStringList_Clear(List: TStringList); stdcall;
begin
  try
    List.Clear;
  except
    MainOutMessage('[Exception] UnTStringListApi.TStringList_Clear');
  end;
end;

procedure TStringList_Exchange(List: TStringList; nIndex1, nIndex2: Integer);
  stdcall;
begin
  try
    List.Exchange(nIndex1, nIndex2);
  except
    MainOutMessage('[Exception] UnTStringListApi.TStringList_Exchange');
  end;
end;

procedure TStringList_LoadFormFile(List: TStringList; pszFileName: PChar);
  stdcall;
begin
  try
    List.LoadFromFile(pszFileName);
  except
    MainOutMessage('[Exception] UnTStringListApi.TStringList_LoadFormFile');
  end;
end;

procedure TStringList_SaveToFile(List: TStringList; pszFileName: PChar);
  stdcall;
begin
  try
    List.SaveToFile(pszFileName);
  except
    MainOutMessage('[Exception] UnTStringListApi.TStringList_SaveToFile');
  end;
end;

end.

