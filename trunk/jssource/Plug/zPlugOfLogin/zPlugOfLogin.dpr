library zPlugOfLogin;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Windows,
  INIFILES,
  HUtil32 in '..\..\Common\HUtil32.pas',
  DES in '..\..\SDK\DES.pas',
  EngineAPI in '..\PlugInCommon\EngineAPI.pas',
  EngineType in '..\PlugInCommon\EngineType.pas',
  Classes,
  FrmMain in 'FrmMain.pas' {FormMain};

{$R *.res}

Const
  PlugName = '½úÉýÍøÂçÉÌÒµµÇÂ¼Æ÷×¢²á²å¼þV1.0';
  LoadPlus = 'ÕýÔÚ¼ÓÔØ½úÉýÍøÂçÉÌÒµµÇÂ¼Æ÷×¢²á²å¼þ....';

type
  TMsgProc          = procedure(Msg:PChar;nMsgLen:Integer;nMode:Integer);stdcall;
  TFindProc         = function(sProcName:PChar;nNameLen:Integer):Pointer;stdcall;
  TFindObj          = function(sObjName:PChar;nNameLen:Integer):TObject;stdcall;
  TSetProc          = function(ProcAddr:Pointer;ProcName:PChar;nNameLen:Integer):Boolean;stdcall;

function Init(AppHandle:HWnd;MsgProc:TMsgProc;FindProc:TFindProc;SetProc:TSetProc;FindObj:TFindObj):PChar;stdcall;
var
  INI:TINIFILE;
begin
  MainHandle:=AppHandle;
  MsgProc(LoadPlus,length(LoadPlus),0);
  INI:=TINIFILE.Create(InfoList);
  Try
    RegInfo1:=INI.ReadString('LoginReg','RegInfo1','');
    RegInfo2:=INI.ReadString('LoginReg','RegInfo2','');
    if (RegInfo1<>'') and (RegInfo2<>'') then begin
      SetLoginRegInfo1(PChar(RegInfo1));
      SetLoginRegInfo2(PChar(RegInfo2));
    end;
  Finally
    INI.Free;
  end;
  Result:=PlugName;
end;

procedure UnInit();stdcall;
begin
end;

procedure Config();stdcall;
begin
  FormMain:=TFormMain.Create(nil);
  FormMain.Open;
  FormMain.Free;
end;

exports
  Init,UnInit,Config;

begin
end.
