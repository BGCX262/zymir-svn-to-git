program keygen;

uses
  Forms,
  frmkeygen in 'frmkeygen.pas' {FromKeygen},
  HUtil32 in '..\PlugInCommon\HUtil32.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFromKeygen, FromKeygen);
  Application.Run;
end.
