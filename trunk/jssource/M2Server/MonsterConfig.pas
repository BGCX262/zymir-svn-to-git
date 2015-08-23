//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit MonsterConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Spin;

type
  TfrmMonsterConfig = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox8: TGroupBox;
    Label23: TLabel;
    EditMonOneDropGoldCount: TSpinEdit;
    ButtonGeneralSave: TButton;
    CheckBoxGoldToBag: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBoxCloneNotCheckAmulet: TCheckBox;
    CloneButtonSave: TButton;
    GroupBox3: TGroupBox;
    EditMonButchMaxTime: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    EditNoManClearMonTime: TSpinEdit;
    CheckBoxNoManClearMon: TCheckBox;
    Label4: TLabel;
    procedure ButtonGeneralSaveClick(Sender: TObject);
    procedure EditMonOneDropGoldCountChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxGoldToBagClick(Sender: TObject);
    procedure CheckBoxCloneNotCheckAmuletClick(Sender: TObject);
    procedure EditMonButchMaxTimeChange(Sender: TObject);
    procedure CheckBoxNoManClearMonClick(Sender: TObject);
    procedure EditNoManClearMonTimeChange(Sender: TObject);
  private
    boOpened: Boolean;
    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure RefGeneralInfo();
    { Private declarations }
  public
    procedure Open;
    { Public declarations }
  end;

var
  frmMonsterConfig: TfrmMonsterConfig;

implementation

uses M2Share, SDK;

{$R *.dfm}

{ TfrmMonsterConfig }

procedure TfrmMonsterConfig.ModValue;
begin
  try
    boModValued := True;
    ButtonGeneralSave.Enabled := True;
    CloneButtonSave.Enabled := True;
  except
    MainOutMessage('[Exception] TfrmMonsterConfig.ModValue');
  end;
end;

procedure TfrmMonsterConfig.uModValue;
begin
  try
    boModValued := False;
    ButtonGeneralSave.Enabled := False;
    CloneButtonSave.Enabled := False;
  except
    MainOutMessage('[Exception] TfrmMonsterConfig.uModValue');
  end;
end;

procedure TfrmMonsterConfig.FormCreate(Sender: TObject);
begin
  try
{$IF SoftVersion = VERDEMO}
    Caption := '游戏参数[演示版本，所有设置调整有效，但不能保存]'
{$IFEND}
  except
    MainOutMessage('[Exception] TfrmMonsterConfig.FormCreate');
  end;
end;

procedure TfrmMonsterConfig.Open;
begin
  try
    boOpened := False;
    uModValue();
    RefGeneralInfo();
    boOpened := True;
    PageControl1.ActivePageIndex := 0;
    ShowModal;
  except
    MainOutMessage('[Exception] TfrmMonsterConfig.Open');
  end;
end;

procedure TfrmMonsterConfig.RefGeneralInfo;
begin
  try
    EditMonOneDropGoldCount.Value := g_Config.nMonOneDropGoldCount;
    EditMonButchMaxTime.Value := g_Config.nMonButchMaxTime div 1000;
    CheckBoxGoldToBag.Checked := g_Config.boDropGoldToPlayBag;
    CheckBoxCloneNotCheckAmulet.Checked := g_Config.boCloneNotCheckAmulet2;
    CheckBoxNoManClearMon.Checked := g_Config.boNoManClearMon;
    EditNoManClearMonTime.Value := g_Config.dwNoManClearMonTime div (60 * 1000);
    EditNoManClearMonTime.Enabled := g_Config.boNoManClearMon;
  except
    MainOutMessage('[Exception] TfrmMonsterConfig.RefGeneralInfo');
  end;
end;

procedure TfrmMonsterConfig.ButtonGeneralSaveClick(Sender: TObject);
begin
  try
{$IF SoftVersion <> VERDEMO}
    Config.WriteInteger('Setup', 'MonOneDropGoldCount',
      g_Config.nMonOneDropGoldCount);
    Config.WriteBool('Setup', 'DropGoldToPlayBag',
      g_Config.boDropGoldToPlayBag);
    Config.WriteBool('Setup', 'CloneNotCheckAmulet',
      g_Config.boCloneNotCheckAmulet2);
    Config.WriteInteger('Setup', 'MonButchMaxTime', g_Config.nMonButchMaxTime);
    Config.ReadBool('Setup', 'NoManClearMon', g_Config.boNoManClearMon);
    Config.WriteInteger('Setup', 'NoManClearMonTime',
      g_Config.dwNoManClearMonTime);
{$IFEND}
    uModValue();
  except
    MainOutMessage('[Exception] TfrmMonsterConfig.ButtonGeneralSaveClick');
  end;
end;

procedure TfrmMonsterConfig.EditMonOneDropGoldCountChange(Sender: TObject);
begin
  try
    if EditMonOneDropGoldCount.Text = '' then
    begin
      EditMonOneDropGoldCount.Text := '0';
      exit;
    end;
    if not boOpened then
      exit;
    g_Config.nMonOneDropGoldCount := EditMonOneDropGoldCount.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmMonsterConfig.EditMonOneDropGoldCountChange');
  end;
end;

procedure TfrmMonsterConfig.EditNoManClearMonTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.dwNoManClearMonTime := EditNoManClearMonTime.Value * 60 * 1000;
  ModValue();
end;

procedure TfrmMonsterConfig.CheckBoxGoldToBagClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boDropGoldToPlayBag := CheckBoxGoldToBag.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TfrmMonsterConfig.CheckBoxGoldToBagClick');
  end;
end;

procedure TfrmMonsterConfig.CheckBoxNoManClearMonClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boNoManClearMon := CheckBoxNoManClearMon.Checked;
  EditNoManClearMonTime.Enabled := g_Config.boNoManClearMon;
  ModValue();
end;

procedure TfrmMonsterConfig.CheckBoxCloneNotCheckAmuletClick(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boCloneNotCheckAmulet2 := CheckBoxCloneNotCheckAmulet.Checked;
  ModValue();
end;

procedure TfrmMonsterConfig.EditMonButchMaxTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMonButchMaxTime := EditMonButchMaxTime.Value * 1000;
  ModValue();
end;

end.

