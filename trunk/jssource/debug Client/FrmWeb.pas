unit FrmWeb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, ExtCtrls, RzButton, RzLabel, RzDBLbl;

type
  TFormWEB = class(TForm)
    pnl1: TPanel;
    WebBrowser1: TWebBrowser;
    RzButton1: TRzButton;
    RzButton2: TRzButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure RzButton2Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormWEB: TFormWEB;

implementation

{$R *.dfm}

procedure TFormWEB.Button1Click(Sender: TObject);
begin
Close;
end;

procedure TFormWEB.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
   RzButton2Click(Sender);
   // perform(WM_NEXTDLGCTL, 0, 0);
    key := #0;
  end;
end;

procedure TFormWEB.RzButton2Click(Sender: TObject);
begin
 WebBrowser1.Navigate(Edit1.Text);
end;

end.
