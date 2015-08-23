//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit TListApi;

interface
uses Classes;

function TList_Create(): TList; stdcall;
procedure TList_Free(List: TList); stdcall;
function TList_Count(List: TList): Integer; stdcall;
function TList_Add(List: TList; Item: Pointer): Integer; stdcall;
procedure TList_Insert(List: TList; nIndex: Integer; Item: Pointer); stdcall;
function TList_Get(List: TList; nIndex: Integer): Pointer; stdcall;
procedure TList_Put(List: TList; nIndex: Integer; Item: Pointer); stdcall;
procedure TList_Delete(List: TList; nIndex: Integer); stdcall;
procedure TList_Clear(List: TList); stdcall;
procedure TList_Exchange(List: TList; nIndex1, nIndex2: Integer); stdcall;

implementation
uses
  M2Share;

function TList_Create(): TList; stdcall;
begin
  try
    Result := TList.Create;
  except
    MainOutMessage('[Exception] UnTListApi.TList_Create');
  end;
end;

procedure TList_Free(List: TList); stdcall;
begin
  try
    List.Free;
  except
    MainOutMessage('[Exception] UnTListApi.TList_Free');
  end;
end;

function TList_Count(List: TList): Integer; stdcall;
begin
  try
    Result := List.Count;
  except
    MainOutMessage('[Exception] UnTListApi.TList_Count');
  end;
end;

function TList_Add(List: TList; Item: Pointer): Integer; stdcall;
begin
  try
    Result := List.Add(Item);
  except
    MainOutMessage('[Exception] UnTListApi.TList_Add');
  end;
end;

procedure TList_Insert(List: TList; nIndex: Integer; Item: Pointer); stdcall;
begin
  try
    List.Insert(nIndex, Item);
  except
    MainOutMessage('[Exception] UnTListApi.TList_Insert');
  end;
end;

function TList_Get(List: TList; nIndex: Integer): Pointer; stdcall;
begin
  try
    Result := List.Items[nIndex];
  except
    MainOutMessage('[Exception] UnTListApi.TList_Get');
  end;
end;

procedure TList_Put(List: TList; nIndex: Integer; Item: Pointer); stdcall;
begin
  try
    //
  except
    MainOutMessage('[Exception] UnTListApi.TList_Put');
  end;
end;

procedure TList_Delete(List: TList; nIndex: Integer); stdcall;
begin
  try
    List.Delete(nIndex);
  except
    MainOutMessage('[Exception] UnTListApi.TList_Delete');
  end;
end;

procedure TList_Clear(List: TList); stdcall;
begin
  try
    List.Clear;
  except
    MainOutMessage('[Exception] UnTListApi.TList_Clear');
  end;
end;

procedure TList_Exchange(List: TList; nIndex1, nIndex2: Integer); stdcall;
begin
  try
    List.Exchange(nIndex1, nIndex2);
  except
    MainOutMessage('[Exception] UnTListApi.TList_Exchange');
  end;
end;

end.

