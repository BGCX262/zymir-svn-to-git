//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit FSrvValue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Spin, M2Share;

type
  TFrmServerValue = class(TForm)
    BitBtn1: TBitBtn;
    CbViewHack: TCheckBox;
    CkViewAdmfail: TCheckBox;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    EGateLoad: TSpinEdit;
    EAvailableBlock: TSpinEdit;
    ECheckBlock: TSpinEdit;
    ESendBlock: TSpinEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EHum: TSpinEdit;
    EMon: TSpinEdit;
    EZen: TSpinEdit;
    ESoc: TSpinEdit;
    ENpc: TSpinEdit;
    EDec: TSpinEdit;
    GroupBox3: TGroupBox;
    Label15: TLabel;
    EditZenMonRate: TSpinEdit;
    Label16: TLabel;
    EditProcessTime: TSpinEdit;
    EditZenMonTime: TSpinEdit;
    Label17: TLabel;
    Label18: TLabel;
    ButtonDefault: TButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditZenMonRateChange(Sender: TObject);
    procedure EditZenMonTimeChange(Sender: TObject);
    procedure EditProcessTimeChange(Sender: TObject);
    procedure ESendBlockChange(Sender: TObject);
    procedure ECheckBlockChange(Sender: TObject);
    procedure EGateLoadChange(Sender: TObject);
    procedure EHumChange(Sender: TObject);
    procedure EMonChange(Sender: TObject);
    procedure EZenChange(Sender: TObject);
    procedure ESocChange(Sender: TObject);
    procedure ENpcChange(Sender: TObject);
    procedure EAvailableBlockChange(Sender: TObject);
    procedure CbViewHackClick(Sender: TObject);
    procedure CkViewAdmfailClick(Sender: TObject);
    procedure ButtonDefaultClick(Sender: TObject);
  private
    boOpened: Boolean;
    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure RefShow();
    { Private declarations }
  public
    function AdjuestServerConfig(): Boolean;
    { Public declarations }
  end;

var
  FrmServerValue: TFrmServerValue;

implementation

uses HUtil32;

{$R *.dfm}

{ TFrmServerValue }

procedure TFrmServerValue.ModValue;
begin
  try
    boModValued := True;
    BitBtn1.Enabled := True;
  except
    MainOutMessage('[Exception] TFrmServerValue.ModValue');
  end;
end;

procedure TFrmServerValue.uModValue;
begin
  try
    boModValued := False;
    BitBtn1.Enabled := False;
  except
    MainOutMessage('[Exception] TFrmServerValue.uModValue');
  end;
end;

function TFrmServerValue.AdjuestServerConfig: Boolean;
begin
  try
    boOpened := False;
    uModValue();
    RefShow();
    boOpened := True;
    ShowModal;
    Result := True;
  except
    MainOutMessage('[Exception] TFrmServerValue.AdjuestServerConfig:');
  end;
end;

procedure TFrmServerValue.BitBtn1Click(Sender: TObject);
var
  tBool: string;
begin
  try
    Config.WriteInteger('Server', 'HumLimit', g_dwHumLimit);
    Config.WriteInteger('Server', 'MonLimit', g_dwMonLimit);
    Config.WriteInteger('Server', 'ZenLimit', g_dwZenLimit);
    Config.WriteInteger('Server', 'SocLimit', g_dwSocLimit);
    Config.WriteInteger('Server', 'DecLimit', nDecLimit);
    Config.WriteInteger('Server', 'NpcLimit', g_dwNpcLimit2);
    Config.WriteInteger('Server', 'SendBlock', g_Config.nSendBlock);
    Config.WriteInteger('Server', 'CheckBlock', g_Config.nCheckBlock);
    Config.WriteInteger('Server', 'GateLoad', g_Config.nGateLoad);
    if g_Config.boViewHackMessage then
      tBool := 'TRUE'
    else
      tBool := 'FLASE';
    Config.WriteString('Server', 'ViewHackMessage', tBool);
    if g_Config.boViewAdmissionFailure then
      tBool := 'TRUE'
    else
      tBool := 'FLASE';
    Config.WriteString('Server', 'ViewAdmissionFailure', tBool);

    Config.WriteInteger('Setup', 'GenMonRate', g_Config.nMonGenRate);
    Config.WriteInteger('Server', 'ProcessMonstersTime',
      g_Config.dwProcessMonstersTime);
    Config.WriteInteger('Server', 'RegenMonstersTime',
      g_Config.dwRegenMonstersTime);
    uModValue();
  except
    MainOutMessage('[Exception] TFrmServerValue.BitBtn1Click');
  end;
end;

procedure TFrmServerValue.FormCreate(Sender: TObject);
begin
  try
    ESendBlock.Hint := '与网关之间一次传输数据块大小(字节)。';
    ECheckBlock.Hint :=
      '与网关之间传输指定大小数据后，进行一次自检。';
    EGateLoad.Hint := '设置与网关传输负载测试数据量大小。';

    EHum.Hint := '处理人物数据分配时间。';
    EMon.Hint := '处理怪物数据分配时间。';
    EZen.Hint := '刷新怪物数据分配时间。';
    ESoc.Hint := '处理网关数据分配时间。';
    ENpc.Hint := '处理NPC数据分配时间。';

    EditZenMonRate.Hint :=
      '刷怪倍率，倍率除以10为实际倍率(设置为10则为1:1)，此倍率以刷怪文件设置为准，数字越大，刷怪数量越小。';
    EditZenMonTime.Hint :=
      '刷怪间隔控制，数字越大，刷怪速度越慢。';
    EditProcessTime.Hint :=
      '处理怪物间隔时间，此设置数字越大，怪物行动越慢。';
  except
    MainOutMessage('[Exception] TFrmServerValue.FormCreate');
  end;
end;

procedure TFrmServerValue.EditZenMonRateChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nMonGenRate := EditZenMonRate.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TFrmServerValue.EditZenMonRateChange');
  end;
end;

procedure TFrmServerValue.EditZenMonTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.dwRegenMonstersTime := EditZenMonTime.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TFrmServerValue.EditZenMonTimeChange');
  end;
end;

procedure TFrmServerValue.EditProcessTimeChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.dwProcessMonstersTime := EditProcessTime.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TFrmServerValue.EditProcessTimeChange');
  end;
end;

procedure TFrmServerValue.ESendBlockChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nSendBlock := _MAX(10, ESendBlock.Value);
    ModValue();
  except
    MainOutMessage('[Exception] TFrmServerValue.ESendBlockChange');
  end;
end;

procedure TFrmServerValue.ECheckBlockChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nCheckBlock := _MAX(10, ECheckBlock.Value);
    ModValue();
  except
    MainOutMessage('[Exception] TFrmServerValue.ECheckBlockChange');
  end;
end;

procedure TFrmServerValue.EGateLoadChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nGateLoad := EGateLoad.Value;
    ModValue();
  except
    MainOutMessage('[Exception] TFrmServerValue.EGateLoadChange');
  end;
end;

procedure TFrmServerValue.EHumChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_dwHumLimit := _MIN(150, EHum.Value);
    ModValue();
  except
    MainOutMessage('[Exception] TFrmServerValue.EHumChange');
  end;
end;

procedure TFrmServerValue.EMonChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_dwMonLimit := _MIN(150, EMon.Value);
    ModValue();
  except
    MainOutMessage('[Exception] TFrmServerValue.EMonChange');
  end;
end;

procedure TFrmServerValue.EZenChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_dwZenLimit := _MIN(150, EZen.Value);
    ModValue();
  except
    MainOutMessage('[Exception] TFrmServerValue.EZenChange');
  end;
end;

procedure TFrmServerValue.ESocChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_dwSocLimit := _MIN(150, ESoc.Value);
    ModValue();
  except
    MainOutMessage('[Exception] TFrmServerValue.ESocChange');
  end;
end;

procedure TFrmServerValue.ENpcChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_dwNpcLimit2 := _MIN(150, ENpc.Value);
    ModValue();
  except
    MainOutMessage('[Exception] TFrmServerValue.ENpcChange');
  end;
end;

procedure TFrmServerValue.EAvailableBlockChange(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.nAvailableBlock := _MAX(10, EAvailableBlock.Value);
    ModValue();
  except
    MainOutMessage('[Exception] TFrmServerValue.EAvailableBlockChange');
  end;
end;

procedure TFrmServerValue.CbViewHackClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boViewHackMessage := CbViewHack.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TFrmServerValue.CbViewHackClick');
  end;
end;

procedure TFrmServerValue.CkViewAdmfailClick(Sender: TObject);
begin
  try
    if not boOpened then
      exit;
    g_Config.boViewAdmissionFailure := CkViewAdmfail.Checked;
    ModValue();
  except
    MainOutMessage('[Exception] TFrmServerValue.CkViewAdmfailClick');
  end;
end;

procedure TFrmServerValue.RefShow;
begin
  try
    EHum.Value := g_dwHumLimit;
    EMon.Value := g_dwMonLimit;
    EZen.Value := g_dwZenLimit;
    ESoc.Value := g_dwSocLimit;
    EDec.Value := nDecLimit;
    ENpc.Value := g_dwNpcLimit2;
    ESendBlock.Value := g_Config.nSendBlock;
    ECheckBlock.Value := g_Config.nCheckBlock;
    EAvailableBlock.Value := g_Config.nAvailableBlock;
    EGateLoad.Value := g_Config.nGateLoad;
    CbViewHack.Checked := g_Config.boViewHackMessage;
    CkViewAdmfail.Checked := g_Config.boViewAdmissionFailure;

    EditZenMonRate.Value := g_Config.nMonGenRate;
    EditZenMonTime.Value := g_Config.dwRegenMonstersTime;
    EditProcessTime.Value := g_Config.dwProcessMonstersTime;
  except
    MainOutMessage('[Exception] TFrmServerValue.RefShow');
  end;
end;

procedure TFrmServerValue.ButtonDefaultClick(Sender: TObject);
begin
  try
    if Application.MessageBox('是否确认恢复默认设置？',
      '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then
    begin
      exit;
    end;
    g_dwHumLimit := 30;
    g_dwMonLimit := 10;
    g_dwZenLimit := 5;
    g_dwSocLimit := 10;
    nDecLimit := 20;
    g_dwNpcLimit2 := 5;
    g_Config.nSendBlock := 1024;
    g_Config.nCheckBlock := 8000;
    g_Config.nAvailableBlock := 8000;
    g_Config.nGateLoad := 0;
    ;
    g_Config.boViewHackMessage := False;
    g_Config.boViewAdmissionFailure := False;

    g_Config.nMonGenRate := 10;
    g_Config.dwRegenMonstersTime := 200;
    g_Config.dwProcessMonstersTime := 30;
    RefShow();
  except
    MainOutMessage('[Exception] TFrmServerValue.ButtonDefaultClick');
  end;
end;

end.

