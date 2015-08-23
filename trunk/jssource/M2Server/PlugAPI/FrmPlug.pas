//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit FrmPlug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormPlug = class(TForm)
    ListBoxPlug: TListBox;
    ButtonConfig: TButton;
    procedure ListBoxPlugClick(Sender: TObject);
    procedure ButtonConfigClick(Sender: TObject);
    procedure ListBoxPlugDblClick(Sender: TObject);
  private
    procedure RefPlugList;
  public
    procedure Open;
  end;

var
  FormPlug: TFormPlug;

implementation
uses
  PlugShare, M2Share;

var
  StartProc: TStartProc;

{$R *.dfm}

procedure TFormPlug.Open;
begin
  try
    RefPlugList();
    ShowModal;
  except
    MainOutMessage('[Exception] TFormPlug.Open');
  end;
end;

procedure TFormPlug.RefPlugList;
var
  Plug: pTPlug;
  I: Integer;
begin
  try
    ListBoxPlug.Items.Clear;
    for I := 0 to PlugList.Count - 1 do
    begin
      Plug := PlugList.Items[I];
      ListBoxPlug.Items.AddObject(Plug.sName, TObject(Plug));
    end;
  except
    MainOutMessage('[Exception] TFormPlug.RefPlugList');
  end;
end;

procedure TFormPlug.ListBoxPlugClick(Sender: TObject);
var
  Module: THandle;
begin
  try
    StartProc := nil;
    Module := pTPlug(ListBoxPlug.Items.Objects[ListBoxPlug.ItemIndex]).nHandle;
    StartProc := GetProcAddress(Module, 'Config');
    ButtonConfig.Enabled := Assigned(StartProc);
  except
    ButtonConfig.Enabled := False;
    StartProc := nil;
  end;
end;

procedure TFormPlug.ButtonConfigClick(Sender: TObject);
begin
  if Assigned(StartProc) then
    TStartProc(StartProc);
end;

procedure TFormPlug.ListBoxPlugDblClick(Sender: TObject);
begin
  if Assigned(StartProc) then
    TStartProc(StartProc);
end;

end.

