//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit CastleManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Spin,AttackWar;

type
  TfrmCastleManage = class(TForm)
    GroupBox1: TGroupBox;
    ListViewCastle: TListView;
    GroupBox2: TGroupBox;
    PageControlCastle: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    EditOwenGuildName: TEdit;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EditOwenName: TEdit;
    EditOwenGuild: TEdit;
    EditHomeMap: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    EditTotalGold: TSpinEdit;
    EditTodayIncome: TSpinEdit;
    Label7: TLabel;
    EditTechLevel: TSpinEdit;
    Label8: TLabel;
    EditPower: TSpinEdit;
    TabSheet3: TTabSheet;
    GroupBox5: TGroupBox;
    ListViewGuard: TListView;
    ButtonRefresh: TButton;
    Label9: TLabel;
    Edit0150: TEdit;
    Label10: TLabel;
    EditD701: TEdit;
    Label11: TLabel;
    SpinEditHomeX: TSpinEdit;
    SpinEditHomeY: TSpinEdit;
    TabSheet4: TTabSheet;
    GroupBox6: TGroupBox;
    ListViewSiege: TListView;
    ButtonADD: TButton;
    ButtonEdit: TButton;
    ButtonDel: TButton;
    ButtonRefurbish: TButton;
    TabSheet5: TTabSheet;
    GroupBox7: TGroupBox;
    Label13: TLabel;
    chkAutoAttackWar: TCheckBox;
    dtpAttackWarTime: TDateTimePicker;
    GroupBox8: TGroupBox;
    Label15: TLabel;
    GroupBox9: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    cbbOwenGuildName: TComboBox;
    cbbOwenPlay1: TComboBox;
    cbbOwenPlay2: TComboBox;
    cbbAutoOwenPlay1: TComboBox;
    cbbAutoOwenPlay2: TComboBox;
    Label12: TLabel;
    Label14: TLabel;
    cbbAutoOwenGuildName: TComboBox;
    Label18: TLabel;
    procedure ListViewCastleClick(Sender: TObject);
    procedure ButtonRefreshClick(Sender: TObject);
    procedure ButtonDelClick(Sender: TObject);
    procedure ButtonADDClick(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
    procedure ButtonRefurbishClick(Sender: TObject);
    procedure ListViewCastleChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure chkAutoAttackWarClick(Sender: TObject);
    procedure dtpAttackWarTimeChange(Sender: TObject);
    procedure cbbOwenGuildNameChange(Sender: TObject);
    procedure cbbOwenPlay1Change(Sender: TObject);
    procedure cbbOwenPlay2Change(Sender: TObject);
    procedure cbbAutoOwenGuildNameChange(Sender: TObject);
    procedure cbbAutoOwenPlay1Change(Sender: TObject);
    procedure cbbAutoOwenPlay2Change(Sender: TObject);
  private
    procedure RefCastleList;
    procedure RefCastleInfo;
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmCastleManage: TfrmCastleManage;

implementation

uses Castle, M2Share;

{$R *.dfm}
var
  CurCastle:TUserCastle;
  boRefing:Boolean;
{ TfrmCastleManage }

procedure TfrmCastleManage.Open;
var
  i:Integer;
begin
Try
  For I:=Low(g_Config.GlobalStrVal) to (High(g_Config.GlobalStrVal)-2) do begin
    CbbOwenGuildName.Items.Add('A'+IntToStr(I));
    CbbOwenPlay1.Items.Add('A'+IntToStr(I));
    CbbOwenPlay2.Items.Add('A'+IntToStr(I));
    CbbAutoOwenGuildName.Items.Add('A'+IntToStr(I));
    CbbAutoOwenPlay1.Items.Add('A'+IntToStr(I));
    CbbAutoOwenPlay2.Items.Add('A'+IntToStr(I));
  end;
  RefCastleList();
  PageControlCastle.TabIndex:=0;
  ShowModal;
Except 
  MainOutMessage('[Exception] TfrmCastleManage.Open');
End; 
end;

procedure TfrmCastleManage.RefCastleInfo;
var
  I,II: Integer;
  ListItem:TListItem;
  ObjUnit:pTObjUnit;
  AttackerInfo:pTAttackerInfo;
begin
Try
  if CurCastle = nil then exit;
  boRefing:=True;
  if CurCastle.m_MasterGuild = nil then EditOwenGuildName.Text:=''
  else EditOwenGuildName.Text:=CurCastle.m_MasterGuild.sGuildName;
  EditTotalGold.Value    :=CurCastle.m_nTotalGold;
  EditTodayIncome.Value  :=CurCastle.m_nTodayIncome;
  EditTechLevel.Value    :=CurCastle.m_nTechLevel;
  EditPower.Value        :=CurCastle.m_nPower;
  ListViewGuard.Clear;
  ListItem:=ListViewGuard.Items.Add;
  ListItem.Caption:='0';
  if CurCastle.m_MainDoor.BaseObject <> nil then begin
    ListItem.SubItems.Add(CurCastle.m_MainDoor.BaseObject.m_sCharName);
    ListItem.SubItems.Add(format('%d:%d',[CurCastle.m_MainDoor.BaseObject.m_nCurrX,CurCastle.m_MainDoor.BaseObject.m_nCurrY]));
    ListItem.SubItems.Add(format('%d/%d',[CurCastle.m_MainDoor.BaseObject.m_WAbil.HP,CurCastle.m_MainDoor.BaseObject.m_WAbil.MaxHP]));
    if CurCastle.m_MainDoor.BaseObject.m_boDeath then begin
      ListItem.SubItems.Add('损坏');
    end else
    if (CurCastle.m_DoorStatus <> nil) and CurCastle.m_DoorStatus.boOpened then begin
      ListItem.SubItems.Add('开启');
    end else begin
      ListItem.SubItems.Add('关闭');
    end;
  end else begin
    ListItem.SubItems.Add(CurCastle.m_MainDoor.sName);
    ListItem.SubItems.Add(format('%d:%d',[CurCastle.m_MainDoor.nX,CurCastle.m_MainDoor.nY]));
    ListItem.SubItems.Add(format('%d/%d',[0,0]));
  end;

  ListItem:=ListViewGuard.Items.Add;
  ListItem.Caption:='1';
  if CurCastle.m_LeftWall.BaseObject <> nil then begin
    ListItem.SubItems.Add(CurCastle.m_LeftWall.BaseObject.m_sCharName);
    ListItem.SubItems.Add(format('%d:%d',[CurCastle.m_LeftWall.BaseObject.m_nCurrX,CurCastle.m_LeftWall.BaseObject.m_nCurrY]));
    ListItem.SubItems.Add(format('%d/%d',[CurCastle.m_LeftWall.BaseObject.m_WAbil.HP,CurCastle.m_LeftWall.BaseObject.m_WAbil.MaxHP]));
  end else begin
    ListItem.SubItems.Add(CurCastle.m_LeftWall.sName);
    ListItem.SubItems.Add(format('%d:%d',[CurCastle.m_LeftWall.nX,CurCastle.m_LeftWall.nY]));
    ListItem.SubItems.Add(format('%d/%d',[0,0]));
  end;

  ListItem:=ListViewGuard.Items.Add;
  ListItem.Caption:='2';
  if CurCastle.m_CenterWall.BaseObject <> nil then begin
    ListItem.SubItems.Add(CurCastle.m_CenterWall.BaseObject.m_sCharName);
    ListItem.SubItems.Add(format('%d:%d',[CurCastle.m_CenterWall.BaseObject.m_nCurrX,CurCastle.m_CenterWall.BaseObject.m_nCurrY]));
    ListItem.SubItems.Add(format('%d/%d',[CurCastle.m_CenterWall.BaseObject.m_WAbil.HP,CurCastle.m_CenterWall.BaseObject.m_WAbil.MaxHP]));
  end else begin
    ListItem.SubItems.Add(CurCastle.m_CenterWall.sName);
    ListItem.SubItems.Add(format('%d:%d',[CurCastle.m_CenterWall.nX,CurCastle.m_CenterWall.nY]));
    ListItem.SubItems.Add(format('%d/%d',[0,0]));
  end;

  ListItem:=ListViewGuard.Items.Add;
  ListItem.Caption:='3';
  if CurCastle.m_RightWall.BaseObject <> nil then begin
    ListItem.SubItems.Add(CurCastle.m_RightWall.BaseObject.m_sCharName);
    ListItem.SubItems.Add(format('%d:%d',[CurCastle.m_RightWall.BaseObject.m_nCurrX,CurCastle.m_RightWall.BaseObject.m_nCurrY]));
    ListItem.SubItems.Add(format('%d/%d',[CurCastle.m_RightWall.BaseObject.m_WAbil.HP,CurCastle.m_RightWall.BaseObject.m_WAbil.MaxHP]));
  end else begin
    ListItem.SubItems.Add(CurCastle.m_RightWall.sName);
    ListItem.SubItems.Add(format('%d:%d',[CurCastle.m_RightWall.nX,CurCastle.m_RightWall.nY]));
    ListItem.SubItems.Add(format('%d/%d',[0,0]));
  end;
  for I := Low(CurCastle.m_Archer) to High(CurCastle.m_Archer) do begin
    ObjUnit:=@CurCastle.m_Archer[I];
    ListItem:=ListViewGuard.Items.Add;
    ListItem.Caption:=IntToStr(I + 4);
    if ObjUnit.BaseObject <> nil then begin
      ListItem.SubItems.Add(ObjUnit.BaseObject.m_sCharName);
      ListItem.SubItems.Add(format('%d:%d',[ObjUnit.BaseObject.m_nCurrX,ObjUnit.BaseObject.m_nCurrY]));
      ListItem.SubItems.Add(format('%d/%d',[ObjUnit.BaseObject.m_WAbil.HP,ObjUnit.BaseObject.m_WAbil.MaxHP]));
    end else begin
      ListItem.SubItems.Add(ObjUnit.sName);
      ListItem.SubItems.Add(format('%d:%d',[ObjUnit.nX,ObjUnit.nY]));
      ListItem.SubItems.Add(format('%d/%d',[0,0]));
    end;
  end;
  for II := Low(CurCastle.m_Guard) to High(CurCastle.m_Guard) do begin
    ObjUnit:=@CurCastle.m_Guard[II];
    ListItem:=ListViewGuard.Items.Add;
    ListItem.Caption:=IntToStr(II + 4);
    if ObjUnit.BaseObject <> nil then begin
      ListItem.SubItems.Add(ObjUnit.BaseObject.m_sCharName);
      ListItem.SubItems.Add(format('%d:%d',[ObjUnit.BaseObject.m_nCurrX,ObjUnit.BaseObject.m_nCurrY]));
      ListItem.SubItems.Add(format('%d/%d',[ObjUnit.BaseObject.m_WAbil.HP,ObjUnit.BaseObject.m_WAbil.MaxHP]));
    end else begin
      ListItem.SubItems.Add(ObjUnit.sName);
      ListItem.SubItems.Add(format('%d:%d',[ObjUnit.nX,ObjUnit.nY]));
      ListItem.SubItems.Add(format('%d/%d',[0,0]));
    end;
  end;
  boRefing:=False;

  EditOwenName.Text:=CurCastle.m_sName;
  //EditOwenGuild.Text:=CurCastle.m_sOwnGuild;
  if CurCastle.m_MasterGuild = nil then EditOwenGuild.Text:=''
  else EditOwenGuild.Text:=CurCastle.m_MasterGuild.sGuildName;
  EditHomeMap.Text:=CurCastle.m_sHomeMap;
  SpinEditHomeX.Value:=CurCastle.m_nHomeX;
  SpinEditHomeY.Value:=CurCastle.m_nHomeY;
  Edit0150.Text:=CurCastle.m_MapPalace.sMapName;
  EditD701.Text:=CurCastle.m_MapSecret.sMapName;
  ListViewSiege.Items.Clear;
  for I:=0 to CurCastle.m_AttackWarList.Count-1 do begin
    AttackerInfo:=CurCastle.m_AttackWarList.Items[I];
    ListItem:=ListViewSiege.Items.Add;
    ListItem.Caption:=IntToStr(I);
    ListItem.SubItems.Add(AttackerInfo.sGuildName);
    ListItem.SubItems.Add(ForMatDateTime('yyyy-mm-dd',AttackerInfo.AttackDate));
  end;

  CbbOwenGuildName.ItemIndex:=CurCastle.m_nOwenGuildName;
  CbbOwenPlay1.ItemIndex:=CurCastle.m_nOwenPlay1;
  CbbOwenPlay2.ItemIndex:=CurCastle.m_nOwenPlay2;
  CbbAutoOwenGuildName.ItemIndex:=CurCastle.m_nAutoOwenGuildName;
  CbbAutoOwenPlay1.ItemIndex:=CurCastle.m_nAutoOwenPlay1;
  CbbAutoOwenPlay2.ItemIndex:=CurCastle.m_nAutoOwenPlay2;
  chkAutoAttackWar.Checked:=CurCastle.m_boAutoAttackWar;
  dtpAttackWarTime.DateTime:=CurCastle.m_AttackWarTime;
  CbbAutoOwenGuildName.Enabled:=chkAutoAttackWar.Checked;
  CbbAutoOwenPlay1.Enabled:=chkAutoAttackWar.Checked;
  CbbAutoOwenPlay2.Enabled:=chkAutoAttackWar.Checked;
  //edtAutoAttactWalQuest.Text:=CurCastle.m_sAutoAttactWalQuest;
  //edtAllAttactWalQuest.Text:=CurCastle.m_sAllAttactWalQuest;
  dtpAttackWarTime.Enabled:=chkAutoAttackWar.Checked;
  //edtAutoAttactWalQuest.Enabled:=chkAutoAttackWar.Checked;
  //edtAllAttactWalQuest.Enabled:=chkAutoAttackWar.Checked;
  //CurCastle.m_AttackGuildList
Except 
  MainOutMessage('[Exception] TfrmCastleManage.RefCastleInfo'); 
End; 
end;

procedure TfrmCastleManage.RefCastleList;
var
  I: Integer;
  UserCastle:TUserCastle;
  ListItem:TListItem;
begin
Try
  g_CastleManager.Lock;
  try
    for I := 0 to g_CastleManager.m_CastleList.Count - 1 do begin
      UserCastle:=TUserCastle(g_CastleManager.m_CastleList.Items[I]);
      ListItem:=ListViewCastle.Items.Add;
      ListItem.Caption:=IntToStr(I);
      ListItem.SubItems.AddObject(UserCastle.m_sConfigDir,UserCastle);
      ListItem.SubItems.Add(UserCastle.m_sName)
    end;
    if ListViewCastle.Items.Count > 0 then ListViewCastle.ItemIndex:=0;
  finally
    g_CastleManager.UnLock;
  end;
Except 
  MainOutMessage('[Exception] TfrmCastleManage.RefCastleList'); 
End; 
end;

procedure TfrmCastleManage.ListViewCastleClick(Sender: TObject);
var
  ListItem:TListItem;
begin
Try
  exit;
  ListItem:=ListViewCastle.Selected;
  if ListItem = nil then exit;
  CurCastle:=TUserCastle(ListItem.SubItems.Objects[0]);
  RefCastleInfo();
Except
  MainOutMessage('[Exception] TfrmCastleManage.ListViewCastleClick');
End;
end;

procedure TfrmCastleManage.ButtonRefreshClick(Sender: TObject);
begin
Try 
  RefCastleInfo();
Except 
  MainOutMessage('[Exception] TfrmCastleManage.ButtonRefreshClick');
End; 
end;

procedure TfrmCastleManage.ButtonDelClick(Sender: TObject);
ResourceSTring
  sText = '是否确定删除此攻城申请？'#13#10#13#10'申请行会:%s'#13#10'攻城日期:%s';
begin
Try 
  if  ListViewSiege.ItemIndex>-1 then begin
    if MessageBox(Handle,PChar(Format(sText,[
                  ListViewSiege.Items[ListViewSiege.ItemIndex].SubItems[0],
                  ListViewSiege.Items[ListViewSiege.ItemIndex].SubItems[1]])),
                  '确认信息',MB_YESNO or MB_ICONQUESTION)=IDYES then begin
    ListViewSiege.Items.Delete(ListViewSiege.ItemIndex);
    end;
  end;
Except 
  MainOutMessage('[Exception] TfrmCastleManage.ButtonDelClick'); 
End; 
end;

procedure TfrmCastleManage.ButtonADDClick(Sender: TObject);
begin
Try 
  FormAttack:=TFormAttack.Create(Owner);
  if Sender=ButtonADD then
    FormAttack.m_ShowClass:=True
  else
    FormAttack.m_ShowClass:=False;
  FormAttack.m_Item:=ListViewSiege.Items[ListViewSiege.ItemIndex];
  FormAttack.Top:=Top + 20;
  FormAttack.Left:=Left;
  FormAttack.Open();
  FormAttack.Free;
  ButtonRefurbishClick(Nil);
Except 
  MainOutMessage('[Exception] TfrmCastleManage.ButtonADDClick'); 
End; 
end;

procedure TfrmCastleManage.ButtonEditClick(Sender: TObject);
begin
Try 
  Try
    FormAttack:=TFormAttack.Create(Owner);
    if Sender=ButtonADD then begin
      FormAttack.m_ShowClass:=True;
    end else begin
      FormAttack.m_ShowClass:=False;
      FormAttack.m_Item:=ListViewSiege.Items[ListViewSiege.ItemIndex];
    end;
    FormAttack.Top:=Top + 20;
    FormAttack.Left:=Left;
    FormAttack.Open();
    FormAttack.Free;
  Except
  end;
Except 
  MainOutMessage('[Exception] TfrmCastleManage.ButtonEditClick'); 
End; 
end;

procedure TfrmCastleManage.ButtonRefurbishClick(Sender: TObject);
var
  I :Integer;
  sFileName,sConfigFile:String;
  LoadLis:TStringList;
//  AttackerInfo:pTAttackerInfo;
  Item  :TListItem;
begin
Try 
  //CurCastle.m_AttackWarList.Cl
  {for I := 0 to CurCastle.m_AttackWarList.Count - 1 do begin
      Dispose(pTAttackerInfo(CurCastle.m_AttackWarList.Items[I]));
  end;
  for I:=0 to ListViewSiege.Items.Count-1 do begin
      New(AttackerInfo);
      //AttackerInfo.
  end;}
  if CurCastle = nil then exit;
  if not DirectoryExists(g_Config.sCastleDir + CurCastle.m_sConfigDir) then begin
    CreateDir(g_Config.sCastleDir + CurCastle.m_sConfigDir);
  end;
  sConfigFile:='AttackSabukWall.txt';
  sFileName:=g_Config.sCastleDir + CurCastle.m_sConfigDir + '\'  + sConfigFile;
  LoadLis:=TStringList.Create;
  for I:=0 to ListViewSiege.Items.Count-1 do begin
      Item:=ListViewSiege.Items[I];
      LoadLis.Add(Item.SubItems.Strings[0] + '       "' + Item.SubItems.Strings[1] + '"');
  end;
  try
    LoadLis.SaveToFile(sFileName);
    
  except
    MainOutMessage('保存攻城信息失败: ' + sFileName);
  end;
  LoadLis.Free;
  CurCastle.LoadAttackSabukWall;
Except
  MainOutMessage('[Exception] TfrmCastleManage.ButtonRefurbishClick');
End; 
end;

procedure TfrmCastleManage.cbbAutoOwenGuildNameChange(Sender: TObject);
begin
  if CurCastle = nil then exit;
  CurCastle.m_nAutoOwenGuildName:=cbbAutoOwenGuildName.ItemIndex;
end;

procedure TfrmCastleManage.cbbAutoOwenPlay1Change(Sender: TObject);
begin
  if CurCastle = nil then exit;
  CurCastle.m_nAutoOwenPlay1:=cbbAutoOwenPlay1.ItemIndex;
end;

procedure TfrmCastleManage.cbbAutoOwenPlay2Change(Sender: TObject);
begin
if CurCastle = nil then exit;
  CurCastle.m_nAutoOwenPlay2:=cbbAutoOwenPlay2.ItemIndex;
end;

procedure TfrmCastleManage.cbbOwenGuildNameChange(Sender: TObject);
begin
  if CurCastle = nil then exit;
  CurCastle.m_nOwenGuildName:=cbbOwenGuildName.ItemIndex;
end;

procedure TfrmCastleManage.cbbOwenPlay1Change(Sender: TObject);
begin
  if CurCastle = nil then exit;
  CurCastle.m_nOwenPlay1:=cbbOwenPlay1.ItemIndex;
end;

procedure TfrmCastleManage.cbbOwenPlay2Change(Sender: TObject);
begin
  if CurCastle = nil then exit;
  CurCastle.m_nOwenPlay2:=cbbOwenPlay2.ItemIndex;
end;

procedure TfrmCastleManage.chkAutoAttackWarClick(Sender: TObject);
begin
  dtpAttackWarTime.Enabled:=chkAutoAttackWar.Checked;
  CbbAutoOwenGuildName.Enabled:=chkAutoAttackWar.Checked;
  CbbAutoOwenPlay1.Enabled:=chkAutoAttackWar.Checked;
  CbbAutoOwenPlay2.Enabled:=chkAutoAttackWar.Checked;
  if CurCastle = nil then exit;
  CurCastle.m_boAutoAttackWar:=chkAutoAttackWar.Checked;
end;

procedure TfrmCastleManage.dtpAttackWarTimeChange(Sender: TObject);
begin
  if CurCastle = nil then exit;
  CurCastle.m_AttackWarTime:=dtpAttackWarTime.DateTime;
end;

procedure TfrmCastleManage.ListViewCastleChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
  ListItem:TListItem;
begin
Try
  ListItem:=ListViewCastle.Selected;
  if ListItem = nil then exit;
  CurCastle:=TUserCastle(ListItem.SubItems.Objects[0]);
  RefCastleInfo();
Except
  MainOutMessage('[Exception] TfrmCastleManage.ListViewCastleClick');
End;
end;

end.
