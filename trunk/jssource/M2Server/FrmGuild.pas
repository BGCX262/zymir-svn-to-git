//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit FrmGuild;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Spin;

type
  TFormGuild = class(TForm)
    GroupBox1: TGroupBox;
    ListViewGuild: TListView;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    EditGuildMemberCount: TSpinEdit;
    ButtonSave: TButton;
    procedure EditGuildMemberCountChange(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open;
  end;

var
  FormGuild: TFormGuild;

implementation
uses
  M2Share, Guild;

procedure TFormGuild.Open;
var
  i: integer;
  Item: TListItem;
begin
  try
    EditGuildMemberCount.Value := g_Config.nGuildMemberCount;
    for I := 0 to g_GuildManager.GuildList.Count - 1 do
    begin
      Item := ListViewGuild.Items.Add;
      Item.Caption := IntToStr(I);
      Item.SubItems.Add(TGuild(g_GuildManager.GuildList.Items[i]).sGuildName);
    end;
    ShowModal;
  except
    MainOutMessage('[Exception] TFormGuild.Open');
  end;
end;

{$R *.dfm}

procedure TFormGuild.EditGuildMemberCountChange(Sender: TObject);
begin
  try
    g_Config.nGuildMemberCount := EditGuildMemberCount.Value;
    ButtonSave.Enabled := True;
  except
    MainOutMessage('[Exception] TFormGuild.EditGuildMemberCountChange');
  end;
end;

procedure TFormGuild.ButtonSaveClick(Sender: TObject);
begin
  try
    Config.WriteInteger('Setup', 'GuildMemberCount',
      g_Config.nGuildMemberCount);
    ButtonSave.Enabled := False;
  except
    MainOutMessage('[Exception] TFormGuild.ButtonSaveClick');
  end;
end;

end.

