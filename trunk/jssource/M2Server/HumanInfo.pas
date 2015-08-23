//CHECK
//��Ҫɾ����һ��ע�ͣ���ע��Ϊ�����ļ��Ƿ��ѱ��Զ������쳣����
unit HumanInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ObjBase, StdCtrls, Spin, ComCtrls, ExtCtrls, Grids;

type
  TfrmHumanInfo = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EditName: TEdit;
    EditMap: TEdit;
    EditXY: TEdit;
    EditAccount: TEdit;
    EditIPaddr: TEdit;
    EditLogonTime: TEdit;
    EditLogonLong: TEdit;
    GroupBox2: TGroupBox;
    Label12: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    EditLevel: TSpinEdit;
    EditGold: TSpinEdit;
    EditPKPoint: TSpinEdit;
    EditExp: TSpinEdit;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    EditAC: TEdit;
    Label13: TLabel;
    EditMAC: TEdit;
    Label14: TLabel;
    EditDC: TEdit;
    EditMC: TEdit;
    Label15: TLabel;
    EditSC: TEdit;
    Label16: TLabel;
    EditHP: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    EditMP: TEdit;
    Timer: TTimer;
    GroupBox4: TGroupBox;
    CheckBoxMonitor: TCheckBox;
    GroupBox5: TGroupBox;
    EditHumanStatus: TEdit;
    GroupBox6: TGroupBox;
    CheckBoxGameMaster: TCheckBox;
    CheckBoxSuperMan: TCheckBox;
    CheckBoxObserver: TCheckBox;
    ButtonKick: TButton;
    GroupBox7: TGroupBox;
    GroupBox9: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    EditGameGold: TSpinEdit;
    EditGamePoint: TSpinEdit;
    EditCreditPoint: TSpinEdit;
    EditBonusPoint: TSpinEdit;
    Label19: TLabel;
    EditEditBonusPointUsed: TSpinEdit;
    ButtonSave: TButton;
    GridUserItem: TStringGrid;
    GroupBox8: TGroupBox;
    GridBagItem: TStringGrid;
    GroupBox10: TGroupBox;
    GridStorageItem: TStringGrid;
    Label20: TLabel;
    EditIdx: TEdit;
    SpinEditGameDird: TSpinEdit;
    SpinEditGameDiam: TSpinEdit;
    Label21: TLabel;
    Label22: TLabel;
    procedure TimerTimer(Sender: TObject);
    procedure CheckBoxMonitorClick(Sender: TObject);
    procedure ButtonKickClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure RefHumanInfo();
    { Private declarations }
  public
    PlayObject: TPlayObject;
    procedure Open();
    { Public declarations }
  end;

var
  frmHumanInfo: TfrmHumanInfo;

implementation

uses UsrEngn, ItmUnit, M2Share, Grobal2;

{$R *.dfm}
var
  boRefHuman: Boolean = False;
  { TfrmHumanInfo }

procedure TfrmHumanInfo.FormCreate(Sender: TObject);
begin
  try
    GridUserItem.Cells[0, 0] := 'װ��λ��';
    GridUserItem.Cells[1, 0] := 'װ������';
    GridUserItem.Cells[2, 0] := 'ϵ�к�';
    GridUserItem.Cells[3, 0] := '�־�';
    GridUserItem.Cells[4, 0] := '��';
    GridUserItem.Cells[5, 0] := 'ħ';
    GridUserItem.Cells[6, 0] := '��';
    GridUserItem.Cells[7, 0] := '��';
    GridUserItem.Cells[8, 0] := 'ħ��';
    GridUserItem.Cells[9, 0] := '��������';

    GridUserItem.Cells[0, 1] := '�·�';
    GridUserItem.Cells[0, 2] := '����';
    GridUserItem.Cells[0, 3] := '������';
    GridUserItem.Cells[0, 4] := '����';
    GridUserItem.Cells[0, 5] := 'ͷ��';
    GridUserItem.Cells[0, 6] := '������';
    GridUserItem.Cells[0, 7] := '������';
    GridUserItem.Cells[0, 8] := '���ָ';
    GridUserItem.Cells[0, 9] := '�ҽ�ָ';
    GridUserItem.Cells[0, 10] := '��Ʒ';
    GridUserItem.Cells[0, 11] := '����';
    GridUserItem.Cells[0, 12] := 'Ь��';
    GridUserItem.Cells[0, 13] := '��ʯ';

    GridBagItem.Cells[0, 0] := '���';
    GridBagItem.Cells[1, 0] := 'װ������';
    GridBagItem.Cells[2, 0] := 'ϵ�к�';
    GridBagItem.Cells[3, 0] := '�־�';
    GridBagItem.Cells[4, 0] := '��';
    GridBagItem.Cells[5, 0] := 'ħ';
    GridBagItem.Cells[6, 0] := '��';
    GridBagItem.Cells[7, 0] := '��';
    GridBagItem.Cells[8, 0] := 'ħ��';
    GridBagItem.Cells[9, 0] := '��������';

    GridStorageItem.Cells[0, 0] := '���';
    GridStorageItem.Cells[1, 0] := 'װ������';
    GridStorageItem.Cells[2, 0] := 'ϵ�к�';
    GridStorageItem.Cells[3, 0] := '�־�';
    GridStorageItem.Cells[4, 0] := '��';
    GridStorageItem.Cells[5, 0] := 'ħ';
    GridStorageItem.Cells[6, 0] := '��';
    GridStorageItem.Cells[7, 0] := '��';
    GridStorageItem.Cells[8, 0] := 'ħ��';
    GridStorageItem.Cells[9, 0] := '��������';

  except
    MainOutMessage('[Exception] TfrmHumanInfo.FormCreate');
  end;
end;

procedure TfrmHumanInfo.Open;
begin
  try
    PageControl1.TabIndex := 0;
    RefHumanInfo();
    ButtonKick.Enabled := True;
    Timer.Enabled := True;
    ShowModal;
    CheckBoxMonitor.Checked := False;
    Timer.Enabled := False;
  except
    MainOutMessage('[Exception] TfrmHumanInfo.Open');
  end;
end;

procedure TfrmHumanInfo.RefHumanInfo;
var
  I: Integer;
  nTotleUsePoint: Integer;
  StdItem: TItem;
  Item: TStdItem;
  UserItem: pTUserItem;
begin
  try
    if (PlayObject = nil) then
    begin
      exit;
    end;
    EditIdx.Text := IntToHex(Integer(PlayObject), 2);
    EditName.Text := PlayObject.m_sCharName;
    EditMap.Text := PlayObject.m_sMapName + '(' + PlayObject.m_PEnvir.sMapDesc +
      ')';
    EditXY.Text := IntToStr(PlayObject.m_nCurrX) + ':' +
      IntToStr(PlayObject.m_nCurrY);
    EditAccount.Text := PlayObject.m_sUserID;
    EditIPaddr.Text := PlayObject.m_sIPaddr;
    EditLogonTime.Text := DateTimeToStr(PlayObject.m_dLogonTime);
    EditLogonLong.Text := IntToStr((GetTickCount - PlayObject.m_dwLogonTick) div
      (60 * 1000)) + ' ����';
    EditLevel.Value := PlayObject.m_Abil.Level;
    EditGold.Value := PlayObject.m_nGold;
    EditPKPoint.Value := PlayObject.m_nPkPoint;
    EditExp.Value := PlayObject.m_Abil.Exp;
    SpinEditGameDiam.Value := PlayObject.m_nGameDiamond;
    SpinEditGameDird.Value := PlayObject.m_nGameGird;

    EditAC.Text := IntToStr(LoWord(PlayObject.m_WAbil.AC)) + '/' +
      IntToStr(HiWord(PlayObject.m_WAbil.AC));
    EditMAC.Text := IntToStr(LoWord(PlayObject.m_WAbil.MAC)) + '/' +
      IntToStr(HiWord(PlayObject.m_WAbil.MAC));
    EditDC.Text := IntToStr(LoWord(PlayObject.m_WAbil.DC)) + '/' +
      IntToStr(HiWord(PlayObject.m_WAbil.DC));
    EditMC.Text := IntToStr(LoWord(PlayObject.m_WAbil.MC)) + '/' +
      IntToStr(HiWord(PlayObject.m_WAbil.MC));
    EditSC.Text := IntToStr(LoWord(PlayObject.m_WAbil.SC)) + '/' +
      IntToStr(HiWord(PlayObject.m_WAbil.SC));
    EditHP.Text := IntToStr(PlayObject.m_WAbil.HP) + '/' +
      IntToStr(PlayObject.m_WAbil.MaxHP);
    EditMP.Text := IntToStr(PlayObject.m_WAbil.MP) + '/' +
      IntToStr(PlayObject.m_WAbil.MaxMP);

    EditGameGold.Value := PlayObject.m_nGameGold;
    EditGamePoint.Value := PlayObject.m_nGamePoint;
    EditCreditPoint.Value := PlayObject.m_btCreditPoint;
    EditBonusPoint.Value := PlayObject.m_nBonusPoint;

    nTotleUsePoint := PlayObject.m_BonusAbil.DC +
      PlayObject.m_BonusAbil.MC +
      PlayObject.m_BonusAbil.SC +
      PlayObject.m_BonusAbil.AC +
      PlayObject.m_BonusAbil.MAC +
      PlayObject.m_BonusAbil.HP +
      PlayObject.m_BonusAbil.MP +
      PlayObject.m_BonusAbil.Hit +
      PlayObject.m_BonusAbil.Speed +
      PlayObject.m_BonusAbil.X2;

    EditEditBonusPointUsed.Value := nTotleUsePoint;

    CheckBoxGameMaster.Checked := PlayObject.m_boAdminMode;
    CheckBoxSuperMan.Checked := PlayObject.m_boSuperMan;
    CheckBoxObserver.Checked := PlayObject.m_boObMode;

    if PlayObject.m_boDeath then
    begin
      EditHumanStatus.Text := '����';
    end
    else if PlayObject.m_boGhost then
    begin
      EditHumanStatus.Text := '����';
      PlayObject := nil;
    end
    else
      EditHumanStatus.Text := '����';

    for I := Low(PlayObject.m_UseItems) to High(PlayObject.m_UseItems) do
    begin
      UserItem := @PlayObject.m_UseItems[I];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem = nil then
      begin
        GridUserItem.Cells[1, I + 1] := '';
        GridUserItem.Cells[2, I + 1] := '';
        GridUserItem.Cells[3, I + 1] := '';
        GridUserItem.Cells[4, I + 1] := '';
        GridUserItem.Cells[5, I + 1] := '';
        GridUserItem.Cells[6, I + 1] := '';
        GridUserItem.Cells[7, I + 1] := '';
        GridUserItem.Cells[8, I + 1] := '';
        GridUserItem.Cells[9, I + 1] := '';
        Continue;
      end;

      StdItem.GetStandardItem(Item);
      StdItem.GetItemAddValue(UserItem, Item);
      Item.Name := GetItemName(UserItem);

      GridUserItem.Cells[1, I + 1] := Item.Name;
      GridUserItem.Cells[2, I + 1] := IntToStr(UserItem.MakeIndex);
      GridUserItem.Cells[3, I + 1] := format('%d/%d', [UserItem.Dura,
        UserItem.DuraMax]);
      GridUserItem.Cells[4, I + 1] := format('%d/%d', [LoWord(Item.DC),
        HiWord(Item.DC)]);
      GridUserItem.Cells[5, I + 1] := format('%d/%d', [LoWord(Item.MC),
        HiWord(Item.MC)]);
      GridUserItem.Cells[6, I + 1] := format('%d/%d', [LoWord(Item.SC),
        HiWord(Item.SC)]);
      GridUserItem.Cells[7, I + 1] := format('%d/%d', [LoWord(Item.AC),
        HiWord(Item.AC)]);
      GridUserItem.Cells[8, I + 1] := format('%d/%d', [LoWord(Item.MAC),
        HiWord(Item.MAC)]);
      GridUserItem.Cells[9, I + 1] := format('%d/%d/%d/%d/%d/%d/%d',
        [UserItem.btValue[0],
        UserItem.btValue[1],
          UserItem.btValue[2],
          UserItem.btValue[3],
          UserItem.btValue[4],
          UserItem.btValue[5],
          UserItem.btValue[6]]);
    end;

    if PlayObject.m_ItemList.Count <= 0 then
      GridBagItem.RowCount := 2
    else
      GridBagItem.RowCount := PlayObject.m_ItemList.Count + 1;

    for I := 0 to PlayObject.m_ItemList.Count - 1 do
    begin
      UserItem := PlayObject.m_ItemList.Items[I];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem = nil then
      begin
        GridBagItem.Cells[1, I + 1] := '';
        GridBagItem.Cells[2, I + 1] := '';
        GridBagItem.Cells[3, I + 1] := '';
        GridBagItem.Cells[4, I + 1] := '';
        GridBagItem.Cells[5, I + 1] := '';
        GridBagItem.Cells[6, I + 1] := '';
        GridBagItem.Cells[7, I + 1] := '';
        GridBagItem.Cells[8, I + 1] := '';
        GridBagItem.Cells[9, I + 1] := '';
        Continue;
      end;
      StdItem.GetStandardItem(Item);
      StdItem.GetItemAddValue(UserItem, Item);
      Item.Name := GetItemName(UserItem);

      GridBagItem.Cells[0, I + 1] := IntToStr(I);
      GridBagItem.Cells[1, I + 1] := Item.Name;
      GridBagItem.Cells[2, I + 1] := IntToStr(UserItem.MakeIndex);
      GridBagItem.Cells[3, I + 1] := format('%d/%d', [UserItem.Dura,
        UserItem.DuraMax]);
      GridBagItem.Cells[4, I + 1] := format('%d/%d', [LoWord(Item.DC),
        HiWord(Item.DC)]);
      GridBagItem.Cells[5, I + 1] := format('%d/%d', [LoWord(Item.MC),
        HiWord(Item.MC)]);
      GridBagItem.Cells[6, I + 1] := format('%d/%d', [LoWord(Item.SC),
        HiWord(Item.SC)]);
      GridBagItem.Cells[7, I + 1] := format('%d/%d', [LoWord(Item.AC),
        HiWord(Item.AC)]);
      GridBagItem.Cells[8, I + 1] := format('%d/%d', [LoWord(Item.MAC),
        HiWord(Item.MAC)]);
      GridBagItem.Cells[9, I + 1] := format('%d/%d/%d/%d/%d/%d/%d',
        [UserItem.btValue[0],
        UserItem.btValue[1],
          UserItem.btValue[2],
          UserItem.btValue[3],
          UserItem.btValue[4],
          UserItem.btValue[5],
          UserItem.btValue[6]]);
    end;

    if PlayObject.m_StorageItemList.Count <= 0 then
      GridStorageItem.RowCount := 2
    else
      GridStorageItem.RowCount := PlayObject.m_StorageItemList.Count + 1;

    for I := 0 to PlayObject.m_StorageItemList.Count - 1 do
    begin
      UserItem := PlayObject.m_StorageItemList.Items[I];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem = nil then
      begin
        GridStorageItem.Cells[1, I + 1] := '';
        GridStorageItem.Cells[2, I + 1] := '';
        GridStorageItem.Cells[3, I + 1] := '';
        GridStorageItem.Cells[4, I + 1] := '';
        GridStorageItem.Cells[5, I + 1] := '';
        GridStorageItem.Cells[6, I + 1] := '';
        GridStorageItem.Cells[7, I + 1] := '';
        GridStorageItem.Cells[8, I + 1] := '';
        GridStorageItem.Cells[9, I + 1] := '';
        Continue;
      end;
      StdItem.GetStandardItem(Item);
      StdItem.GetItemAddValue(UserItem, Item);
      Item.Name := GetItemName(UserItem);

      GridStorageItem.Cells[0, I + 1] := IntToStr(I);
      GridStorageItem.Cells[1, I + 1] := Item.Name;
      GridStorageItem.Cells[2, I + 1] := IntToStr(UserItem.MakeIndex);
      GridStorageItem.Cells[3, I + 1] := format('%d/%d', [UserItem.Dura,
        UserItem.DuraMax]);
      GridStorageItem.Cells[4, I + 1] := format('%d/%d', [LoWord(Item.DC),
        HiWord(Item.DC)]);
      GridStorageItem.Cells[5, I + 1] := format('%d/%d', [LoWord(Item.MC),
        HiWord(Item.MC)]);
      GridStorageItem.Cells[6, I + 1] := format('%d/%d', [LoWord(Item.SC),
        HiWord(Item.SC)]);
      GridStorageItem.Cells[7, I + 1] := format('%d/%d', [LoWord(Item.AC),
        HiWord(Item.AC)]);
      GridStorageItem.Cells[8, I + 1] := format('%d/%d', [LoWord(Item.MAC),
        HiWord(Item.MAC)]);
      GridStorageItem.Cells[9, I + 1] := format('%d/%d/%d/%d/%d/%d/%d',
        [UserItem.btValue[0],
        UserItem.btValue[1],
          UserItem.btValue[2],
          UserItem.btValue[3],
          UserItem.btValue[4],
          UserItem.btValue[5],
          UserItem.btValue[6]]);
    end;
  except
    MainOutMessage('[Exception] TfrmHumanInfo.RefHumanInfo');
  end;
end;

procedure TfrmHumanInfo.TimerTimer(Sender: TObject);
begin
  try
    if PlayObject = nil then
      exit;
    if PlayObject.m_boGhost then
    begin
      EditHumanStatus.Text := '����';
      PlayObject := nil;
      exit;
    end;
    if boRefHuman then
      RefHumanInfo();
  except
    MainOutMessage('[Exception] TfrmHumanInfo.TimerTimer');
  end;
end;

procedure TfrmHumanInfo.CheckBoxMonitorClick(Sender: TObject);
begin
  try
    boRefHuman := CheckBoxMonitor.Checked;
    ButtonSave.Enabled := not boRefHuman;
  except
    MainOutMessage('[Exception] TfrmHumanInfo.CheckBoxMonitorClick');
  end;
end;

procedure TfrmHumanInfo.ButtonKickClick(Sender: TObject);
begin
  try
    if PlayObject = nil then
      exit;
    PlayObject.m_boEmergencyClose := True;
    ButtonKick.Enabled := False;
  except
    MainOutMessage('[Exception] TfrmHumanInfo.ButtonKickClick');
  end;
end;

procedure TfrmHumanInfo.ButtonSaveClick(Sender: TObject);
var
  nLevel: Integer;
  nGold: Integer;
  nPKPoint: Integer;
  nGameGold: Integer;
  nGamePoint: Integer;
  nCreditPoint: Integer;
  nBonusPoint: Integer;
  boGameMaster: Boolean;
  boObServer: Boolean;
  boSuperman: Boolean;
begin
  try
    if PlayObject = nil then
      exit;
    nLevel := EditLevel.Value;
    nGold := EditGold.Value;
    nPKPoint := EditPKPoint.Value;
    nGameGold := EditGameGold.Value;
    nGamePoint := EditGamePoint.Value;
    nCreditPoint := EditCreditPoint.Value;
    nBonusPoint := EditBonusPoint.Value;
    boGameMaster := CheckBoxGameMaster.Checked;
    boObServer := CheckBoxObserver.Checked;
    boSuperman := CheckBoxSuperMan.Checked;
    if (nLevel < 0) or (nLevel > High(Word)) or (nGold < 0) or (nPKPoint < 0) or
      (nCreditPoint < 0) or (nBonusPoint < 0) or (nBonusPoint > 20000000) then
    begin
      MessageBox(Handle, '�������ݲ���ȷ������', '������Ϣ',
        MB_OK);
      exit;
    end;
    PlayObject.m_Abil.Level := nLevel;
    PlayObject.m_nGold := nGold;
    PlayObject.m_nPkPoint := nPKPoint;
    PlayObject.m_nGameGold := nGameGold;
    PlayObject.m_nGamePoint := nGamePoint;
    PlayObject.m_btCreditPoint := nCreditPoint;
    PlayObject.m_nBonusPoint := nBonusPoint;
    PlayObject.m_boAdminMode := boGameMaster;
    PlayObject.m_nGameDiamond := SpinEditGameDiam.Value;
    PlayObject.m_nGameGird := SpinEditGameDird.Value;
    PlayObject.m_boObMode := boObServer;
    PlayObject.m_boSuperMan := boSuperman;
    PlayObject.HasLevelUp(1);
    PlayObject.GoldChanged;
    PlayObject.RefDiamondGird;
    MessageBox(Handle, '���������ѱ��档', '��ʾ��Ϣ', MB_OK);
  except
    MainOutMessage('[Exception] TfrmHumanInfo.ButtonSaveClick');
  end;
end;

end.

