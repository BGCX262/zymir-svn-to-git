//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit AttackWar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,M2Share,Guild;

type
  TFormAttack = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditName: TEdit;
    Label2: TLabel;
    DateTimePicker: TDateTimePicker;
    CheckBox: TCheckBox;
    Button1: TButton;
    GroupBox2: TGroupBox;
    ListBoxGuild: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure ListBoxGuildClick(Sender: TObject);
  private
    { Private declarations }
  public
    m_ShowClass   : Boolean;
    m_Item        : TListItem;
    procedure Open();
  end;

var
  FormAttack: TFormAttack;

implementation
uses
CastleManage;

{$R *.dfm}

procedure TFormAttack.Open;
var
  i:integer;
begin
Try 
  //RefCastleList();
  Try
  if m_ShowClass then begin
    Caption:='增加攻城行会';
    DateTimePicker.Date:=Now;
    CheckBox.Enabled:=True;
    EditName.Enabled:=True;
  end else begin
    Caption:='编辑攻城行会';
    CheckBox.Enabled:=False;
    EditName.Enabled:=False;
    EditName.Text:=m_Item.SubItems.Strings[0];
    DateTimePicker.Date:=StrToDateTime(m_Item.SubItems.Strings[1]);
  end;
  ListBoxGuild.Items.Clear;
  for I:=0 to g_GuildManager.GuildList.Count-1 do
    ListBoxGuild.Items.Add(TGuild(g_GuildManager.GuildList.Items[i]).sGuildName);
  ShowModal;
  Except
    //MainOutMessage('[Exception] AttackWar nIdx 1');
  end;
Except 
  //MainOutMessage('[Exception] TFormAttack.Open');
End; 
end;

procedure TFormAttack.Button1Click(Sender: TObject);
var
  Item:TListItem;
  I   :Integer;
begin
Try 
Try
  if m_ShowClass then begin
    if  CheckBox.Checked then begin
      frmCastleManage.ListViewSiege.Items.Clear;
      for i:=0 to g_GuildManager.GuildList.Count -1 do begin
          Item:=frmCastleManage.ListViewSiege.Items.Add;
          Item.Caption:=IntToStr(I);
          Item.SubItems.Add(TGuild(g_GuildManager.GuildList.Items[i]).sGuildName);
          Item.SubItems.Add(FormatDateTime('yyyy-mm-dd',DateTimePicker.Date));
      end;
    end else begin
      if  g_GuildManager.FindGuild(EditName.Text)=Nil then begin
        MessageBox(Handle,'你所添加的行会不存在...','提示信息',MB_OK or MB_ICONASTERISK);
        exit;
      end;
      for I:=0 to frmCastleManage.ListViewSiege.Items.Count-1 do begin
          Item:=frmCastleManage.ListViewSiege.Items[I];
          if CompareText(Item.SubItems.Strings[0],EditName.Text) = 0  then begin
            MessageBox(Handle,'你所添加的行会已经存在列表当中...','提示信息',MB_OK or MB_ICONASTERISK);
            exit;
          end;
      end;
      m_Item:=frmCastleManage.ListViewSiege.Items.Add;
      m_Item.Caption:=IntToStr(frmCastleManage.ListViewSiege.Items.Count-1);
      m_Item.SubItems.Add(EditName.Text);
      m_Item.SubItems.Add(FormatDateTime('yyyy-mm-dd',DateTimePicker.Date));
    end;
  end else begin
    if  g_GuildManager.FindGuild(EditName.Text)=Nil then begin
      MessageBox(Handle,'你所添加的行会不存在...','提示信息',MB_OK or MB_ICONASTERISK);
      exit;
    end;
    m_Item.SubItems.Strings[0]:=EditName.Text;
    m_Item.SubItems.Strings[1]:=FormatDateTime('yyyy-mm-dd',DateTimePicker.Date);
  end;
  Close;
  Except
    //MainOutMessage('[Exception] AttackWar nIdx 2');
  end;
Except 
  //MainOutMessage('[Exception] TFormAttack.Button1Click');
End; 
end;

procedure TFormAttack.CheckBoxClick(Sender: TObject);
begin
Try 
  if CheckBox.Checked then EditName.Text:='*'
  else EditName.Text:='';
  EditName.Enabled:=not CheckBox.Checked;
Except 
  //MainOutMessage('[Exception] TFormAttack.CheckBoxClick');
End; 
end;

procedure TFormAttack.ListBoxGuildClick(Sender: TObject);
begin
Try 
Try
  if (ListBoxGuild.ItemIndex>-1) and (EditName.Enabled) then
    EditName.Text:=ListBoxGuild.Items.Strings[ListBoxGuild.ItemIndex];
    Except
    MainOutMessage('[Exception] AttackWar nIdx 3');
  end;
Except 
  //MainOutMessage('[Exception] TFormAttack.ListBoxGuildClick');
End; 
end;

end.
