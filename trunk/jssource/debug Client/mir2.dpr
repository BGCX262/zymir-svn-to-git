program mir2;

uses
  Forms,
  Dialogs,
  IniFiles,
  Windows,
  SysUtils,
  CLMain in 'CLMain.pas' {frmMain},
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
  Grobal2 in '..\Common\Grobal2.pas',
  MShare in 'MShare.pas',
  DlgConfig in 'DlgConfig.pas' {frmDlgConfig},
  SDK in '..\SDK\SDK.pas',
  MD5Unit in '..\SDK\MD5Unit.pas',
  wmUtil in 'wmUtil.pas',
  EDcode in '..\Common\EDcode.pas',
  FrmWg in 'FrmWg.pas' {FormWgMain},
  WShare in 'WShare.pas',
  Share in 'Share.pas',
  AxeMon2 in 'AxeMon2.pas',
  Uib in 'Uib.pas',
  Itmap in 'Itmap.pas',
  ReadInteger in 'ReadInteger.pas',
  DES in '..\SDK\DES.pas',
  FindMapPath in 'FindMapPath.pas',
  FrmWeb in 'FrmWeb.pas' {FormWEB};

{$R *.RES}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'legend of mir2';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TFrmDlg, FrmDlg);
  Application.CreateForm(TfrmDlgConfig, frmDlgConfig);
  Application.CreateForm(TFormWEB, FormWEB);
  {$IF TOOLVER     = DEFVER}
  InitObj();
 {$IFEND}
  g_nThisCRC := CalcFileCRC(Application.ExeName);
  Application.Run;
end.
