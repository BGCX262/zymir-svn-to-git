unit FrmReg;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, RzEdit, Buttons, RzButton, RSA, INIFiles;

type
  TFormReg = class(TForm)
    pnl1: TPanel;
    img1: TImage;
    img2: TImage;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    edtHardwareID: TRzEdit;
    edtUser: TRzEdit;
    lbl6: TLabel;
    edtRegInfo: TRzEdit;
    lbl7: TLabel;
    lbl8: TLabel;
    btnOK: TRzButton;
    btnClose: TRzButton;
    Plug: TRSA;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function InitScript(): Boolean;
function CheckRegInfo(): Boolean;
procedure UnInitScript();
function GetScriptText(Msg:PChar;LoMsg:Pointer;LoMsgLen:Integer):integer;stdcall;

var
  FormReg: TFormReg;
  UserName: string = '';
  RegInfo: string = '';
  Script: TRSA = nil;
  boRegOK: Boolean = False;

implementation
uses
  GetHardInfo, Share,HUtil32;

{$R *.dfm}

function GetScriptText(Msg:PChar;LoMsg:Pointer;LoMsgLen:Integer):integer;stdcall;
var
  Tempstr: String;
  I: Integer;
begin
  //Script.Server := True;
  //Script.CommonalityMode := '244170310634041142757128338277';
  //Script.PrivateKey := '107473657707380360332037523497';
  Result := 0;
  if Script <> nil then
  begin
    try
      Tempstr := Script.DecryptStr(Msg);
    Except
      Exit;
    end;
    Result := Length(Tempstr);
   // Move(Tempstr[1],LoMsg^,Result);
    CopyMemory(Pointer(Integer(LoMsg)),Pointer(Integer(@Tempstr[1])),Result);
    for I := 0 to Result do
      PByte(Integer(LoMsg) + I)^ := PByte(Integer(LoMsg) + I)^ + Result; 
  end;
end;

procedure UnInitScript();
begin
  if Script <> nil then Script.Free;
end;

function InitScript(): Boolean;
var
  INI: TIniFile;
begin
  Result := False;
  Script := TRSA.Create(nil);
  Script.Server := False;
  INI := TIniFile.Create('.\!Setup.txt');
  try
    UserName := Trim(INI.ReadString('Script', 'UserName', ''));
    RegInfo := Trim(INI.ReadString('Script', 'RegInfo', ''));
  finally
    INI.Free;
  end;
  if (UserName <> '') and (RegInfo <> '') then
    Result := CheckRegInfo();
  if not Result then
  begin
    FormReg := TFormReg.Create(nil);
    FormReg.ShowModal;
    FormReg.Free;
    Result := boRegOK;
  end;
end;

function CheckRegInfo(): Boolean;
var
  CommonalityKey, CommonalityMode, PrivateKey,TempStr: string;
begin
  Result := False;
  boRegOK := False;
  try
    GetMode(IntToStr(FormatHardwareID(GetCPUAndMacInfo)),IntToStr(FormatUserName(UserName)),CommonalityKey, CommonalityMode, PrivateKey);
    Script.Server := False;

    Script.CommonalityKey := CommonalityKey;
    Script.CommonalityMode := CommonalityMode;
    TempStr := Script.DecryptStr(Reginfo);
  Except
    Exit;
  end;
  TempStr := GetValidStr3(TempStr,CommonalityMode,['|']);
  TempStr := GetValidStr3(TempStr,PrivateKey,['|']);
  if TempStr = 'OK' then
  begin
    try
      Script.Server := True;
      Script.CommonalityMode := CommonalityMode;
      Script.PrivateKey := PrivateKey;
    Except
      Exit;
    end;
    boRegOK := True;
    Result := True;
  end;
end;

procedure TFormReg.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormReg.btnOKClick(Sender: TObject);
var
  INI: TINIFIle;
begin
  if (Trim(edtUser.Text) <> '') and (Trim(edtRegInfo.Text) <>'')  then
  begin
    UserName := Trim(edtUser.Text);
    RegInfo := Trim(edtRegInfo.Text);
    if CheckRegInfo() then
    begin
      INI := TIniFile.Create('.\!Setup.txt');
      try
        INI.WriteString('Script', 'UserName', UserName);
        INI.WriteString('Script', 'RegInfo', RegInfo);
      finally
        INI.Free;
      end;
    end;
    Close;
  end else
    Application.MessageBox('请输入完整的注册信息!', '提示信息', MB_OK + 
      MB_ICONINFORMATION);
end;

procedure TFormReg.FormCreate(Sender: TObject);
begin
  Caption := Plug.DecryptStr('a=hHHPZJiDrEX0cs+Fqm7if7w2wRQO4d=eMI3cXzybb68q'); //晋升网络脚本注册插件
  lbl1.Caption := Plug.DecryptStr('AnOGZd1OTL+vmTor6svxpVF2M3+2HId2OfJ4w6CygwPC=i'); //购买晋升网络商业版本请联系
  lbl2.Caption := Plug.DecryptStr('AFZ+IzReAEr=2xZ4=p1GtBoPTuiP1Bd2jX07wGAqzLdGELlhUM1xaum7nojk'); //注册地址：http://reg.51m2.net
  lbl4.Caption := Plug.DecryptStr('BrnlUCvB1Y+poTs4yRAT0qVaoFSgzhF0uCpkyD5Tbjzmx5FsXVvjscQ4oDVhqtxwS3HxIbg4Ghw'); //联系QQ：516952222,516962222,516972222,516982222
  lbl8.Caption := Plug.DecryptStr('AMCzROt8cU07UsKUWsV9h7BimgSYRjK1RvlONqfdh2TcSa'); //51m2.com
  edtHardwareID.Text := GetCPUAndMacInfo();
end;

end.

