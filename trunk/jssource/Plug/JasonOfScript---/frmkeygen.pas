unit frmkeygen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFromKeygen = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    edtName: TEdit;
    edtHardwareID: TEdit;
    mregkey: TMemo;
    Label1: TLabel;
    btn1: TButton;
    btn2: TButton;
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FromKeygen: TFromKeygen;

implementation
    uses Share,RSA;
{$R *.dfm}

function GetRegInfo(UserName,HardwareID:PChar;LoMsg:Pointer;LoMsgLen:Integer):Integer;stdcall;
var
  CommonalityKey, CommonalityMode, PrivateKey: string;
  Script: TRSA;
  Tempstrn: String;
begin
  GetMode(IntToStr(FormatHardwareID(HardwareID)),IntToStr(FormatUserName(UserName)),CommonalityKey, CommonalityMode, PrivateKey);
  Script := TRSA.Create(nil);
  try
    Script.Server := True;
    Script.CommonalityMode := CommonalityMode;
    Script.PrivateKey := PrivateKey;
    Tempstrn := Script.EncryptStr('302682675416074797175010037341|242125495024981486632021295333|OK');
    Move(Tempstrn[1],LoMsg^,Length(Tempstrn) + 1);
    Result := Length(Tempstrn) + 1;
  finally
    Script.Free;
  end;
end;

procedure TFromKeygen.btn1Click(Sender: TObject);
var
  Buff :array[0..1024] of Char;
begin
if (edtName.Text='') or (edtHardwareID.Text='') then
begin
  Application.MessageBox('用户名或机器码不能为空!',PChar(Application.Title), MB_OK
    + MB_ICONWARNING);
 exit;
end;
  mregkey.Lines.Clear;
  FillChar(buff,SizeOf(Buff),#0);
  GetRegInfo(PChar(edtName.Text),PChar(edtHardwareID.Text),@Buff,SizeOf(Buff));
  mregkey.Lines.Add(StrPas(PChar(@Buff)));
end;

procedure TFromKeygen.btn2Click(Sender: TObject);
begin
Close;
end;

procedure TFromKeygen.FormActivate(Sender: TObject);
begin
     ///////和壳通信不top窗体不显示//////////////
    SetWindowPos(FromKeygen.Handle, Hwnd_Topmost, 0, 0, 0, 0, (SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW));
    SetWindowPos(FromKeygen.Handle, Hwnd_Notopmost, 0, 0, 0, 0, (SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW));
//////////////////

end;

end.
