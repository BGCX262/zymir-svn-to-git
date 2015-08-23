//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit PlugShare;

interface
uses
  EngineType, svMain, EDcode, Grobal2, Windows, M2Share, Classes, SysUtils;

type
  TPlug = record
    nHandle: Integer;
    sName: string;
    UnInit: Pointer;
  end;
  pTPlug = ^TPlug;

  TStartProc = procedure(); stdcall;
  TMsgProc = procedure(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;
  TFindProc = function(sProcName: PChar; nNameLen: Integer): Pointer; stdcall;
  TFindObj = function(sObjName: PChar; nNameLen: Integer): TObject; stdcall;
  TSetProc = function(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer):
    Boolean; stdcall;
  TGetIPLocal = function(Msg, LoMsg: PChar; LoMsgLen: Integer): PChar; stdcall;
  TGetScriptText = function(Msg: PChar; LoMsg: PChar; LoMsgLen: Integer):
    integer; stdcall;
  TInit = function(AppHandle: HWnd; MsgProc: TMsgProc; FindProc: TFindProc;
    SetProc: TSetProc; FindObj: TFindObj): PChar; stdcall;
  TUnInit = procedure(); stdcall;
  //TSPoing           = function(sMsg:PChar;rMsg:PChar;MsgLeng:Integer):PChar;stdcall;

procedure LoadPlug();
procedure FreePlug();

procedure MsgProc(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;
function FindProc(sProcName: PChar; nNameLen: Integer): Pointer; stdcall;
function FindObj(sObjName: PChar; nNameLen: Integer): TObject; stdcall;
function SetProc(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer):
  Boolean; stdcall;

var
  IpLocal: Pointer = nil;
  PlugScript: Pointer = nil;
  PlugList: TList;

  {Const

    EDcodeScript    = 'DeCryptString';
    GetIPLocal      = 'GetIPLocal';   }

implementation

var
  boShow: Boolean;

procedure MsgProc(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;
begin
  try
    if boShow then
      FrmMain.MemoLog.Lines.Add(Msg);
  except
    MainOutMessage('[Exception] UnPlugShare.MsgProc');
  end;
end;

function FindProc(sProcName: PChar; nNameLen: Integer): Pointer; stdcall;
begin
  try
    //FrmMain.MemoLog.Lines.Add('FindProc');
  except
    MainOutMessage('[Exception] UnPlugShare.FindProc');
  end;
end;

function FindObj(sObjName: PChar; nNameLen: Integer): TObject; stdcall;
begin
  try
    //FrmMain.MemoLog.Lines.Add('FindObj');
  except
    MainOutMessage('[Exception] UnPlugShare.FindObj');
  end;
end;

function SetProc(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer): Boolean;
  stdcall;
begin
  try
    Result := True;
    if ProcName = 'GetIPLocal' then
    begin
      IpLocal := ProcAddr;
    end
    else if ProcName = 'PlugOfScript' then
    begin
      PlugScript := ProcAddr;
    end;
  except
    MainOutMessage('[Exception] UnPlugShare.SetProc');
  end;
end;

procedure LoadPlug();
var
  sFile: TStringList;
  I: Integer;
  FileName, Str: string;
  Plug: pTPlug;
  nHandle: Integer;
  InitHnd, UnInitHnd: Pointer;
  //  Init      : TInit;
  RuStr: PChar;
begin
  try
    boShow := True;
    sFile := TStringList.Create;
    try
      sFile.Clear;
      sFile.LoadFromFile('.\PlugList.txt');
      for I := 0 to sFile.Count - 1 do
      begin
        FileName := sFile.Strings[I];
        if (FileName <> '') and (FileName[1] <> ';') then
        begin
          Str := FileName;
          FileName := '.\' + FileName;
          if FileExists(FileName) then
          begin
            nHandle := LoadLibrary(PChar(FileName));
            try
              InitHnd := GetProcAddress(nHandle, 'Init');
              UnInitHnd := GetProcAddress(nHandle, 'UnInit');
              if (InitHnd <> nil) and (UnInitHnd <> nil) then
              begin
                //              Init:=TInit(InitHnd);
                RuStr := TInit(InitHnd)(FrmMain.Handle, MsgProc, FindProc,
                  SetProc, FindObj);
                if RuStr <> '' then
                begin
                  New(Plug);
                  Plug.nHandle := nHandle;
                  Plug.sName := RuStr;
                  Plug.UnInit := UnInitHnd;
                  PlugList.Add(Plug);
                end
                else
                  MainOutMessage('加载插件 ' + Str +
                    ' 失败，格式不匹配！！！');
              end
              else
                FreeLibrary(nHandle);
            except
              MainOutMessage('加载插件 ' + Str +
                ' 失败，格式不匹配！！！');
              FreeLibrary(nHandle);
            end;
          end
          else
            MainOutMessage('加载插件 ' + Str +
              ' 失败，文件不存在！！');
        end;
      end;
    finally
      sFile.Free;
    end;
  except
    MainOutMessage('[Exception] UnPlugShare.LoadPlug');
  end;
end;

procedure FreePlug();
var
  Plug: pTPlug;
  I: Integer;
begin
  try
    boShow := False;
    try
      for I := 0 to PlugList.Count - 1 do
      begin
        Plug := PlugList.Items[I];
        try
          TUnInit(Plug.UnInit);
        finally
          FreeLibrary(Plug.nHandle);
          Dispose(Plug);
        end;
      end;
      PlugList.Clear;
    except
    end;
  except
    MainOutMessage('[Exception] UnPlugShare.FreePlug');
  end;
end;

initialization
  begin
    PlugList := TList.Create;
    //EDcode_DecodeMessage:=DecodeMessage;
  end;

finalization
  begin
    PlugList.Free;
  end;

end.

