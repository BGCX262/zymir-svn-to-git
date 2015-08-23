//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit GlobaSession;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls;

type
  TfrmGlobaSession = class(TForm)
    StringGrid: TStringGrid;
    RefTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure RefTimerTimer(Sender: TObject);
  private
    procedure RefShow();
    { Private declarations }
  public
    procedure ShowDlg();
    { Public declarations }
  end;

var
  frmGlobaSession: TfrmGlobaSession;

implementation

uses IDSocCli, Grobal2;

{$R *.dfm}

procedure TfrmGlobaSession.FormCreate(Sender: TObject);
begin
Try 
  StringGrid.Cells[0,0]:='登录帐号';
  StringGrid.Cells[1,0]:='IP地址';
  StringGrid.Cells[2,0]:='会话ID';
  StringGrid.Cells[3,0]:='登录时间';
Except 
  MainOutMessage('[Exception] TfrmGlobaSession.FormCreate'); 
End; 
end;

procedure TfrmGlobaSession.ShowDlg;
begin
Try 
  RefTimer.Enabled:=True;
  RefShow();
  ShowModal;
  RefTimer.Enabled:=False;
Except 
  MainOutMessage('[Exception] TfrmGlobaSession.ShowDlg'); 
End; 
end;

procedure TfrmGlobaSession.RefTimerTimer(Sender: TObject);
begin
Try 
  RefShow();
Except 
  MainOutMessage('[Exception] TfrmGlobaSession.RefTimerTimer'); 
End; 
end;

procedure TfrmGlobaSession.RefShow;
var
  i:integer;
  GlobaSessionInfo:pTGlobaSessionInfo;
begin
Try 
  StringGrid.RowCount:=FrmIDSoc.GlobaSessionList.Count + 1;
  if StringGrid.RowCount > 1 then StringGrid.FixedRows:=1;
  for i:=0 to FrmIDSoc.GlobaSessionList.Count -1 do begin
    GlobaSessionInfo:=FrmIDSoc.GlobaSessionList.Items[i];
    if GlobaSessionInfo <> nil then begin
      StringGrid.Cells[0,i+1]:=GlobaSessionInfo.sAccount;
      StringGrid.Cells[1,i+1]:=GlobaSessionInfo.sIPaddr;
      StringGrid.Cells[2,i+1]:=IntToStr(GlobaSessionInfo.nSessionID);
      StringGrid.Cells[3,i+1]:=DateTimeToStr(GlobaSessionInfo.dAddDate);
    end;
  end;
Except 
  MainOutMessage('[Exception] TfrmGlobaSession.RefShow'); 
End; 
end;

end.
