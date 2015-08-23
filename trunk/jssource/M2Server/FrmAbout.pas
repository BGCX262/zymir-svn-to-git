//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit FrmAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TABoutForm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Button1: TButton;
    GroupBox2: TGroupBox;
    LabelSoftName: TLabel;
    LabelSoftVersion: TLabel;
    LabelSoftDateTime: TLabel;
    LabelSoftAuthor: TLabel;
    LabelSoftWWW: TLabel;
    LabelSoftBBS: TLabel;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure RefShow();
  end;

var
  ABoutForm: TABoutForm;

implementation
uses
  M2Share;

{$R *.dfm}

procedure TABoutForm.Button1Click(Sender: TObject);
begin
  try
    Close;
  except
    MainOutMessage('[Exception] TABoutForm.Button1Click');
  end;
end;

procedure TABoutForm.RefShow();
begin
  try
    LabelSoftName.Caption := g_sProductName;
    LabelSoftVersion.Caption := g_sVersion;
    LabelSoftDateTime.Caption := g_sUpDateTime;
    LabelSoftAuthor.Caption := g_sProgram;
    LabelSoftWWW.Caption := g_sWebSite;
    LabelSoftBBS.Caption := g_sBbsSite;
  except
    MainOutMessage('[Exception] TABoutForm.RefShow');
  end;
end;

end.

