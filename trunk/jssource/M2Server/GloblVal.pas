unit GloblVal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TFormGloblVal = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ListView1: TListView;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure PageControl1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
    procedure RefStr();
  end;

var
  FormGloblVal: TFormGloblVal;

implementation
uses
  M2Share, HUtil32;

{$R *.dfm}

procedure TFormGloblVal.Open();
begin
  PageControl1.TabIndex := 0;
  RefStr();
  ShowModal;
end;

procedure TFormGloblVal.RefStr();
var
  i: integer;
  Item: TListItem;
begin
  try
    ListView1.Visible := False;
    ListView1.Clear;
    if PageControl1.TabIndex = 0 then
    begin
      for I := Low(g_Config.GlobalVal) to High(g_Config.GlobalVal) do
      begin
        Item := ListView1.Items.Add;
        Item.Caption := IntToStr(I);
        Item.SubItems.Add(IntToStr(g_Config.GlobalVal[I]));
      end;
    end
    else
    begin
      for I := Low(g_Config.GlobalStrVal) to High(g_Config.GlobalStrVal) do
      begin
        Item := ListView1.Items.Add;
        Item.Caption := IntToStr(I);
        Item.SubItems.Add(g_Config.GlobalStrVal[I]);
      end;
    end;
    ListView1.Visible := True;
  except
  end;
end;

procedure TFormGloblVal.PageControl1Change(Sender: TObject);
begin
  RefStr();
end;

procedure TFormGloblVal.Button1Click(Sender: TObject);
var
  I: Integer;
begin
  if PageControl1.TabIndex = 0 then
  begin
    if Application.MessageBox('是否确定清除数字全局变量?',
      '提示信息', MB_YESNO + MB_ICONQUESTION) = mrYes then
    begin
      for I := Low(g_Config.GlobalVal) to High(g_Config.GlobalVal) do
      begin
        g_Config.GlobalVal[I] := 0;
        Config.WriteInteger('Setup', 'GlobalVal' + IntToStr(I),
          g_Config.GlobalVal[I])
      end;
      RefStr();
    end;
  end
  else
  begin
    if Application.MessageBox('是否确定清除字符串全局变量?',
      '提示信息', MB_YESNO + MB_ICONQUESTION) = mrYes then
    begin
      for I := Low(g_Config.GlobalStrVal) to High(g_Config.GlobalStrVal) do
      begin
        g_Config.GlobalStrVal[I] := '';
        Config.WriteString('Setup', 'GlobalStrVal' + IntToStr(I),
          g_Config.GlobalStrVal[I]);
      end;
      RefStr();
    end;
  end;
end;

procedure TFormGloblVal.ListView1DblClick(Sender: TObject);
var
  Idx: Integer;
  sMsg: string;
begin
  Idx := ListView1.ItemIndex;
  if Idx > -1 then
  begin
    if PageControl1.TabIndex = 0 then
    begin
      sMsg := InputBox('设置变量', '数值变量(' + IntToStr(Idx) + ')',
        IntToStr(g_Config.GlobalVal[Idx]));
      g_Config.GlobalVal[Idx] := Str_ToInt(sMsg, g_Config.GlobalVal[Idx]);
    end
    else
    begin
      sMsg := InputBox('设置变量', '字符串变量(' + IntToStr(Idx) + ')',
        g_Config.GlobalStrVal[Idx]);
      g_Config.GlobalStrVal[Idx] := sMsg;
    end;
    RefStr();
  end;
end;

end.

