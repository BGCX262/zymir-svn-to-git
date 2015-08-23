unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    btn1: TButton;
    edt1: TEdit;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

  function GetRegInfo(UserName,HardwareID:PChar;LoMsg:Pointer;LoMsgLen:Integer):Integer;stdcall;

implementation

function GetRegInfo; external 'PlugRegDll.dll' name 'GetRegInfo';

{$R *.dfm}

procedure TForm3.btn1Click(Sender: TObject);
var
  Buff :array[0..255] of Char;
begin
  GetRegInfo('zmfu','06E8-19E8-BBE9-2301-C18A-5397',@Buff,SizeOf(Buff));
  edt1.Text := StrPas(PChar(@Buff));
end;

end.
