//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit ActionSpeedConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TfrmActionSpeed = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    Label15: TLabel;
    EditRunLongHitIntervalTime: TSpinEdit;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    EditActionIntervalTime: TSpinEdit;
    CheckBoxControlActionInterval: TCheckBox;
    CheckBoxControlRunLongHit: TCheckBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    EditRunHitIntervalTime: TSpinEdit;
    CheckBoxControlRunHit: TCheckBox;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    EditWalkHitIntervalTime: TSpinEdit;
    CheckBoxControlWalkHit: TCheckBox;
    ButtonSave: TButton;
    ButtonDefault: TButton;
    ButtonClose: TButton;
    CheckBoxIncremeng: TCheckBox;
    GroupBox6: TGroupBox;
    Label4: TLabel;
    EditRunMagicIntervalTime: TSpinEdit;
    CheckBoxControlRunMagic: TCheckBox;
    Label5: TLabel;
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonDefaultClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure CheckBoxControlActionIntervalClick(Sender: TObject);
    procedure EditActionIntervalTimeChange(Sender: TObject);
    procedure CheckBoxControlRunLongHitClick(Sender: TObject);
    procedure EditRunLongHitIntervalTimeChange(Sender: TObject);
    procedure CheckBoxControlRunHitClick(Sender: TObject);
    procedure EditRunHitIntervalTimeChange(Sender: TObject);
    procedure CheckBoxControlWalkHitClick(Sender: TObject);
    procedure EditWalkHitIntervalTimeChange(Sender: TObject);
    procedure CheckBoxIncremengClick(Sender: TObject);
    procedure CheckBoxControlRunMagicClick(Sender: TObject);
    procedure EditRunMagicIntervalTimeChange(Sender: TObject);
  private
    { Private declarations }
    boOpened:Boolean;
    boModValued:Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure SaveConfig();
    procedure RefSpeedConfig();
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmActionSpeed: TfrmActionSpeed;

implementation

uses SDK, M2Share;

{$R *.dfm}

{ TfrmActionSpeed }

procedure TfrmActionSpeed.ModValue;
begin
Try 
  boModValued:=True;
  ButtonSave.Enabled:=True;

Except 
  MainOutMessage('[Exception] TfrmActionSpeed.ModValue'); 
End; 
end;

procedure TfrmActionSpeed.uModValue;
begin
Try 
  boModValued:=False;
  ButtonSave.Enabled:=False;
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.uModValue'); 
End; 
end;

procedure TfrmActionSpeed.Open;
begin
Try 
Try
  boOpened:=False;
  uModValue();
  RefSpeedConfig();


  boOpened:=True;
  ShowModal;
  Except
    MainOutMessage('[Exception] ActionSpeedConfig nIdx 1');
  end;
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.Open'); 
End; 
end;

procedure TfrmActionSpeed.ButtonCloseClick(Sender: TObject);
ResourceString
  sExitMsg      = '设置已被修改是否不保存设置退出？';
  sExitMsgTitle = '确认信息';
begin
Try 
Try
  if not boModValued then begin
    Close;
    exit;
  end;
  if (MessageBox(Handle,PChar(sExitMsg),PChar(sExitMsgTitle) , MB_YESNO + MB_ICONQUESTION) = IDYES) then begin
    Close;
  end;
  Except
    MainOutMessage('[Exception] ActionSpeedConfig nIdx 2');
  end;
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.ButtonCloseClick'); 
End; 
end;

procedure TfrmActionSpeed.RefSpeedConfig;
begin
Try 
  EditActionIntervalTime.Value          := g_Config.dwActionIntervalTime;
  EditRunLongHitIntervalTime.Value      := g_Config.dwRunLongHitIntervalTime;
  EditRunHitIntervalTime.Value          := g_Config.dwRunHitIntervalTime;
  EditWalkHitIntervalTime.Value         := g_Config.dwWalkHitIntervalTime;
  EditRunMagicIntervalTime.Value        := g_Config.dwRunMagicIntervalTime;
  CheckBoxControlActionInterval.Checked := g_Config.boControlActionInterval;
  CheckBoxControlRunLongHit.Checked     := g_Config.boControlRunLongHit;
  CheckBoxControlRunHit.Checked         := g_Config.boControlRunHit;
  CheckBoxControlWalkHit.Checked        := g_Config.boControlWalkHit;
  CheckBoxControlRunMagic.Checked       := g_Config.boControlRunMagic;
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.RefSpeedConfig'); 
End; 
end;

procedure TfrmActionSpeed.ButtonDefaultClick(Sender: TObject);
ResourceString
  sExitMsg      = '是否确认恢复默认设置？';
  sExitMsgTitle = '确认信息';
begin
Try 
  if Application.MessageBox(PChar(sExitMsg),PChar(sExitMsgTitle) , MB_YESNO + MB_ICONQUESTION) <> IDYES then begin
    exit;
  end;
  boOpened:=False;
  ModValue();
  g_Config.dwActionIntervalTime     := 400;
  g_Config.dwRunLongHitIntervalTime := 800;
  g_Config.dwRunHitIntervalTime     := 800;
  g_Config.dwWalkHitIntervalTime    := 800;
  g_Config.dwRunMagicIntervalTime   := 900;
  g_Config.boControlActionInterval  := True;
  g_Config.boControlRunLongHit      := True;
  g_Config.boControlRunHit          := True;
  g_Config.boControlWalkHit         := True;
  g_Config.boControlRunMagic        := True;

  RefSpeedConfig();
  boOpened:=True;
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.ButtonDefaultClick'); 
End; 
end;

procedure TfrmActionSpeed.SaveConfig;
begin
Try 
  Config.WriteBool('Setup','ControlActionInterval',g_Config.boControlActionInterval);
  Config.WriteBool('Setup','ControlWalkHit',g_Config.boControlWalkHit);
  Config.WriteBool('Setup','ControlRunLongHit',g_Config.boControlRunLongHit);
  Config.WriteBool('Setup','ControlRunHit',g_Config.boControlRunHit);
  Config.WriteBool('Setup','ControlRunMagic',g_Config.boControlRunMagic);
  
  Config.WriteInteger('Setup','ActionIntervalTime',g_Config.dwActionIntervalTime);
  Config.WriteInteger('Setup','RunLongHitIntervalTime',g_Config.dwRunLongHitIntervalTime);
  Config.WriteInteger('Setup','RunHitIntervalTime',g_Config.dwRunHitIntervalTime);
  Config.WriteInteger('Setup','WalkHitIntervalTime',g_Config.dwWalkHitIntervalTime);
  Config.WriteInteger('Setup','RunMagicIntervalTime',g_Config.dwRunMagicIntervalTime);
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.SaveConfig'); 
End; 
end;

procedure TfrmActionSpeed.ButtonSaveClick(Sender: TObject);
begin
Try 
  SaveConfig();
  uModValue();
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.ButtonSaveClick'); 
End; 
end;

procedure TfrmActionSpeed.CheckBoxIncremengClick(Sender: TObject);
var
  nIncrement:Integer;
begin
Try 
  if CheckBoxIncremeng.Checked then nIncrement:=1
  else nIncrement:=10;

  EditActionIntervalTime.Increment     := nIncrement;
  EditRunLongHitIntervalTime.Increment := nIncrement;
  EditRunHitIntervalTime.Increment     := nIncrement;
  EditWalkHitIntervalTime.Increment    := nIncrement;
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.CheckBoxIncremengClick'); 
End; 
end;
procedure TfrmActionSpeed.CheckBoxControlActionIntervalClick(
  Sender: TObject);
var
  boStatus:Boolean;
begin
Try 
  boStatus                          := CheckBoxControlActionInterval.Checked;
  EditActionIntervalTime.Enabled    := boStatus;
  CheckBoxControlRunLongHit.Enabled := boStatus;
  CheckBoxControlRunHit.Enabled     := boStatus;
  CheckBoxControlWalkHit.Enabled    := boStatus;
  CheckBoxControlRunMagic.Enabled   := boStatus;

  CheckBoxControlRunLongHitClick(Sender);
  CheckBoxControlRunHitClick(Sender);
  CheckBoxControlWalkHitClick(Sender);
  CheckBoxControlRunMagicClick(Sender);
  
  if not boOpened then exit;
  g_Config.boControlActionInterval  := boStatus;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.CheckBoxControlActionIntervalClick'); 
End; 
end;

procedure TfrmActionSpeed.EditActionIntervalTimeChange(Sender: TObject);
begin
Try 
  if not boOpened then exit;
  g_Config.dwActionIntervalTime:=EditActionIntervalTime.Value;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.EditActionIntervalTimeChange'); 
End; 
end;

procedure TfrmActionSpeed.CheckBoxControlRunLongHitClick(Sender: TObject);
var
  boStatus:Boolean;
begin
Try 
  boStatus:=CheckBoxControlRunLongHit.Checked and CheckBoxControlRunLongHit.Enabled;

  EditRunLongHitIntervalTime.Enabled:=boStatus;

  if not boOpened then exit;
  g_Config.boControlRunLongHit:=boStatus;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.CheckBoxControlRunLongHitClick'); 
End; 
end;

procedure TfrmActionSpeed.EditRunLongHitIntervalTimeChange(
  Sender: TObject);
begin
Try 
  if not boOpened then exit;
  g_Config.dwRunLongHitIntervalTime:=EditRunLongHitIntervalTime.Value;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.EditRunLongHitIntervalTimeChange'); 
End; 
end;

procedure TfrmActionSpeed.CheckBoxControlRunHitClick(Sender: TObject);
var
  boStatus:Boolean;
begin
Try 
  boStatus:=CheckBoxControlRunHit.Checked and CheckBoxControlRunHit.Enabled;
  EditRunHitIntervalTime.Enabled:=boStatus;

  if not boOpened then exit;
  g_Config.boControlRunHit:=boStatus;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.CheckBoxControlRunHitClick'); 
End; 
end;

procedure TfrmActionSpeed.EditRunHitIntervalTimeChange(Sender: TObject);
begin
Try 
  if not boOpened then exit;
  g_Config.dwRunHitIntervalTime:=EditRunHitIntervalTime.Value;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.EditRunHitIntervalTimeChange'); 
End; 
end;

procedure TfrmActionSpeed.CheckBoxControlWalkHitClick(Sender: TObject);
var
  boStatus:Boolean;
begin
Try 
  boStatus:=CheckBoxControlWalkHit.Checked and CheckBoxControlWalkHit.Enabled;
  EditWalkHitIntervalTime.Enabled:=boStatus;

  if not boOpened then exit;
  g_Config.boControlWalkHit:=boStatus;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.CheckBoxControlWalkHitClick'); 
End; 
end;

procedure TfrmActionSpeed.EditWalkHitIntervalTimeChange(Sender: TObject);
begin
Try 
  if not boOpened then exit;
  g_Config.dwWalkHitIntervalTime:=EditWalkHitIntervalTime.Value;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.EditWalkHitIntervalTimeChange'); 
End; 
end;



procedure TfrmActionSpeed.CheckBoxControlRunMagicClick(Sender: TObject);
var
  boStatus:Boolean;
begin
Try 
  boStatus:=CheckBoxControlRunMagic.Checked and CheckBoxControlRunMagic.Enabled;
  EditRunMagicIntervalTime.Enabled:=boStatus;

  if not boOpened then exit;
  g_Config.boControlRunMagic:=boStatus;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.CheckBoxControlRunMagicClick'); 
End; 
end;

procedure TfrmActionSpeed.EditRunMagicIntervalTimeChange(Sender: TObject);
begin
Try 
  if not boOpened then exit;
  g_Config.dwRunMagicIntervalTime:=EditRunMagicIntervalTime.Value;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmActionSpeed.EditRunMagicIntervalTimeChange'); 
End; 
end;

end.
