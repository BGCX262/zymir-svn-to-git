unit FrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, ExtCtrls, RzPanel, RzRadGrp, RzButton,INIFILES;

type
  TFormMain = class(TForm)
    RzRadioGroup1: TRzRadioGroup;
    EditHard: TRzEdit;
    Label1: TLabel;
    EditInfo1: TRzEdit;
    Label2: TLabel;
    Label3: TLabel;
    MemoInfo2: TRzMemo;
    BitBtnReg: TRzBitBtn;
    BitBtnClose: TRzBitBtn;
    Label4: TLabel;
    procedure BitBtnRegClick(Sender: TObject);
    procedure EditInfo1Change(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FormMain: TFormMain;
  RegInfo1:String;
  RegInfo2:String;
  MainHandle:THandle;

Const
  InfoList = '.\!SetUp.txt';

implementation
uses
Hutil32,DES;

{$R *.dfm}

procedure TFormMain.Open();
begin
  EditHard.Text:=GetCPUIDText(True);
  EditInfo1.Text:=RegInfo1;
  MemoInfo2.Lines.SetText(PChar(RegInfo2));
  BitBtnReg.Enabled:=False;
  Label4.Caption:='���Ӳ����Ϣ���ƺ��͸����ǣ�'#13#10'ע����������ʹ�ã�'#13#10;
  Label4.Caption:=Label4.Caption+DecryStrHex('BBE8521A24A4A882140966105755E56FB6B444BA8CCBA1B2','DES')+#13#10;
  Label4.Caption:=Label4.Caption+DecryStrHex('36E5AC7A6905716E6008F89FCC7247E1A2D8BDDEB138F593C573EF8887D02514','DES')+#13#10;
  Label4.Caption:=Label4.Caption+'�������ڣ�2007-12-10';
  ShowModal;
end;

procedure TFormMain.BitBtnRegClick(Sender: TObject);
var
  INI:TINIFILE;
begin
  INI:=TINIFILE.Create(InfoList);
  Try
    RegInfo1:=EditInfo1.Text;
    RegInfo2:=MemoInfo2.Lines.GetText;
    INI.WriteString('LoginReg','RegInfo1',RegInfo1);
    INI.WriteString('LoginReg','RegInfo2',RegInfo2);
  Finally
    INI.Free;
  end;
  MessageBox(Handle,
             'ע�����ѱ����ģ�������������������'#13#10'ֻ�����������Ż���Ч��'#13#10'ע���Ƿ�ɹ������κ���ʾ��������ʹ����ҵ���¼����¼��Ϸ���ԣ�����',
             '��ʾ��Ϣ',
             MB_OK or MB_ICONASTERISK);
end;

procedure TFormMain.EditInfo1Change(Sender: TObject);
begin
  BitBtnReg.Enabled:=True;
end;

end.
