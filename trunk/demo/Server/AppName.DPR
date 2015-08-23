program AppName;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  EDcode in '..\Client\EDCode.pas',
  ConnMgr in 'ConnMgr.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
