//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit InfinityStorage;

interface
uses Windows, Classes, SysUtils, grobal2, M2Share;

type
  TStorageHead = packed record
    dwDateTime: TDateTime;
    sName: string[20]; //0
    nCount: integer; //20
    n1: integer; //24
    n2: integer; //28
    n3: integer; //32
    n4: integer; //36
    n5: integer; //40
  end;

procedure SaveStorageItems(List: TList; sName: string);
procedure LoadStorageItems(List: TList; sName: string);

implementation

var
  LoadCriticalSection: TRTLCriticalSection;
  SaveCriticalSection: TRTLCriticalSection;

procedure SaveStorageItems(List: TList; sName: string);
var
  UserItem: pTUserItem;
  i: integer;
  sFile: string;
  Head: TStorageHead;
  nFileHandle: integer;
begin
  try
    nFileHandle := -1;
    EnterCriticalSection(SaveCriticalSection);
    try
      sFile := g_Config.sStorageDir + sName + '.db';
      if FileExists(sFile) then
      begin
        if List.Count > 0 then
        begin
          nFileHandle := FileOpen(sFile, fmOpenWrite or fmShareDenyNone);
          if nFileHandle > 0 then
          begin
            FileSeek(nFileHandle, 0, 0);
            FillChar(Head, Sizeof(TStorageHead), #0);
            FileSeek(nFileHandle, 0, 0);
            Head.dwDateTime := Now;
            Head.sName := sName;
            Head.nCount := 0;
            FileWrite(nFileHandle, Head, SizeOf(TStorageHead));
          end;
        end
        else
          DeleteFile(sFile);
      end
      else
      begin
        if List.Count > 0 then
          nFileHandle := FileCreate(sFile);
      end;
      if nFileHandle > 0 then
      begin
        try
          if List.Count <= 0 then
            exit;
          FillChar(Head, Sizeof(TStorageHead), #0);
          FileSeek(nFileHandle, 0, 0);
          Head.dwDateTime := Now;
          Head.sName := sName;
          Head.nCount := List.Count;
          FileWrite(nFileHandle, Head, SizeOf(TStorageHead));
          for i := 0 to List.Count - 1 do
          begin
            UserItem := List.Items[I];
            if UserItem <> nil then
              FileWrite(nFileHandle, UserItem^, SizeOf(TUserItem));
          end;
        finally
          FileClose(nFileHandle);
        end;
      end;
    finally
      LeaveCriticalSection(SaveCriticalSection);
    end;
  except
    MainOutMessage('[Exception] UnInfinityStorage.SaveStorageItems');
  end;
end;

procedure LoadStorageItems(List: TList; sName: string);
var
  UserItem: pTUserItem;
  i: integer;
  sFile: string;
  Head: TStorageHead;
  nFileHandle: integer;
  UserItem23: TUserItem;
begin
  try
    EnterCriticalSection(LoadCriticalSection);
    try
      sFile := g_Config.sStorageDir + sName + '.db';
      if FileExists(sFile) then
      begin
        nFileHandle := FileOpen(sFile, fmOpenRead or fmShareDenyNone);
        if nFileHandle > 0 then
        begin
          try
            FillChar(Head, Sizeof(TStorageHead), #0);
            FileSeek(nFileHandle, 0, 0);
            if FileRead(nFileHandle, Head, SizeOf(TStorageHead)) =
              SizeOf(TStorageHead) then
            begin
              for I := 0 to Head.nCount - 1 do
              begin
                if FileRead(nFileHandle, UserItem23, SizeOf(TUserItem)) =
                  SizeOf(TUserItem) then
                begin
                  if UserItem23.wIndex > 0 then
                  begin
                    New(UserItem);
                    UserItem^ := UserItem23;
                    List.Add(UserItem);
                  end;
                end
                else
                  break;
              end;
            end;
          finally
            FileClose(nFileHandle);
          end;
        end;
      end;
    finally
      LeaveCriticalSection(LoadCriticalSection);
    end;
  except
    MainOutMessage('[Exception] UnInfinityStorage.LoadStorageItems');
  end;
end;

initialization
  begin
    InitializeCriticalSection(LoadCriticalSection);
    InitializeCriticalSection(SaveCriticalSection);
  end;

finalization
  begin
    DeleteCriticalSection(LoadCriticalSection);
    DeleteCriticalSection(SaveCriticalSection);
  end;

end.

