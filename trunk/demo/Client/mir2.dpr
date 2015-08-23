program mir2;

uses
  Forms,
  Dialogs,
  IniFiles,
  Windows,
  SysUtils,
  ClMain in 'ClMain.pas' {FrmMain},
  DrawScrn in 'DrawScrn.pas',
  IntroScn in 'IntroScn.pas',
  PlayScn in 'PlayScn.pas',
  MapUnit in 'MapUnit.pas',
  FState in 'FState.pas' {FrmDlg},
  ClFunc in 'ClFunc.pas',
  cliUtil in 'cliUtil.pas',
  DWinCtl in 'DWinCtl.pas',
  WIL in 'WIL.pas',
  magiceff in 'magiceff.pas',
  SoundUtil in 'SoundUtil.pas',
  Actor in 'Actor.pas',
  HerbActor in 'HerbActor.pas',
  AxeMon in 'AxeMon.pas',
  clEvent in 'clEvent.pas',
  HUtil32 in 'HUtil32.pas',
  EDcode in 'EDCode.pas',
  Grobal2 in 'Grobal2.pas';

{$R *.RES}

const
   PatchTempFile = 'Patch#n.dat';
   PatchTempTestFile = 'Patch#n1.dat';
   PatchTestProgram = 'AutoTestPatch.exe';
   PatchProgram = 'Patch.exe';

var
   mini: TIniFile;
   boneedpatch: Boolean;
   patchprogramname: string;
   patchtemp: string;
   str: string;
   pstr: array[0..255] of char;
begin
  //if CheckMirProgram then begin
  //   Application.Terminate;
  //   exit;
  //end;

  boneedpatch := TRUE;
  mini := TIniFile.Create ('.\mir.ini');
  if mini <> nil then begin
      if mini.ReadInteger ('setup', 'Patched', 0) = 1 then
         boneedpatch := FALSE;
      mini.WriteInteger ('setup', 'patched', 0);
      if ParamStr(1) <> '' then begin
         MainParam1 := ParamStr(1);
         MainParam2 := ParamStr(2);
         MainParam3 := ParamStr(3);
         MainParam4 := ParamStr(4);
         MainParam5 := ParamStr(5);
         mini.WriteString ('Setup', 'Param1', MainParam1);
         mini.WriteString ('Setup', 'Param2', MainParam2);
         mini.WriteString ('Setup', 'Param3', MainParam3);
         mini.WriteString ('Setup', 'Param4', MainParam4);
         mini.WriteString ('Setup', 'Param5', MainParam5);
      end else begin
         str := mini.ReadString ('Setup', 'Param1', '');
         if str <> '' then begin
            MainParam1 := str;
            MainParam2 := mini.ReadString ('Setup', 'Param2', '');
            MainParam3 := mini.ReadString ('Setup', 'Param3', '');
            MainParam4 := mini.ReadString ('Setup', 'Param4', '');
            MainParam5 := mini.ReadString ('Setup', 'Param5', '');
         end;
         mini.WriteString ('Setup', 'Param1', '');
         mini.WriteString ('Setup', 'Param2', '');
         mini.WriteString ('Setup', 'Param3', '');
         mini.WriteString ('Setup', 'Param4', '');
         mini.WriteString ('Setup', 'Param5', '');
      end;
      mini.Free;
  end;
  if BO_FOR_TEST then begin
     patchprogramname := PatchTestProgram;
     patchtemp := PatchTempTestFile;
  end else begin
     patchprogramname := PatchProgram;
     patchtemp := PatchTempFile;
  end;
  if FileExists(patchtemp) then begin  //패치 프로그램이 변경되야 하는 경우..
     if FileSize(patchtemp) > 300 * 1024 then begin //일정한 크기 이상..
        FileCopy (patchtemp, patchprogramname)
     end;
  end;
  //if boneedpatch then begin
  //   if FileExists(patchprogramname) then begin
  //     StrPCopy (pstr, patchprogramname);
  //     WinExec (pstr, 0);
  //     Application.Terminate;
  //     exit;
  //   end else
  //     MessageDlg (patchprogramname + '를 실행시킬 수 없습니다. 이 파일이 없으면 자동 패치가 안됩니다.', mtWarning, [mbOk], 0);
  //end;
  if HasMMX then begin
     Application.Initialize;
     Application.Title := 'legend of mir2';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmDlg, FrmDlg);
  Application.Run;
  end else begin
     MessageDlg ('CPU에 MMX기능을 사용할 수 없습니다.', mtError, [mbOk], 0);
     Application.Terminate;
     exit;
  end;

  if CheckMirProgram then begin
     Application.Terminate;
     exit;
  end;
end.
