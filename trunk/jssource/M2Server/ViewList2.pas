//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit ViewList2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, M2Share, ItmUnit, Spin, StrUtils, Shopping,
    ObjNpc,
  grobal2;

type
  TFormList2 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    PageControl2: TPageControl;
    TabSheet2: TTabSheet;
    GroupBox4: TGroupBox;
    ListBoxitemList: TListBox;
    ListViewShopList: TListView;
    Label1: TLabel;
    EditName: TEdit;
    EditText: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ButtonAdd: TButton;
    ButtonDel: TButton;
    ButtonSave: TButton;
    ButtonRefur: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    SpinEditPrice: TSpinEdit;
    SpinEditItems: TSpinEdit;
    SpinEditEffectID: TSpinEdit;
    SpinEditEffectCount: TSpinEdit;
    ComboBoxClass: TComboBox;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    ListBoxHeroItems: TListBox;
    ButtonHeroPickAdd: TButton;
    ButtonHeroPickDelete: TButton;
    ButtonHeroPickAddAll: TButton;
    ButtonHeroPickDeleteAll: TButton;
    ButtonHeroPickSave: TButton;
    GroupBox2: TGroupBox;
    ListBoxHeroPickList: TListBox;
    TabSheet4: TTabSheet;
    GroupBox3: TGroupBox;
    stLevelItems: TListBox;
    LevelItemAdd: TButton;
    LevelItemDel: TButton;
    LevelItemAllAdd: TButton;
    LevelItemAllDel: TButton;
    LevelItemSave: TButton;
    GroupBox5: TGroupBox;
    ListBoxHeroItems2: TListBox;
    TabSheet5: TTabSheet;
    GroupBox6: TGroupBox;
    ListBoxItemList3: TListBox;
    GroupBox7: TGroupBox;
    ListBoxSellItemList: TListBox;
    SellAdd: TButton;
    SellDel: TButton;
    SellAllAdd: TButton;
    SellAllDel: TButton;
    SellSave: TButton;
    TabSheet6: TTabSheet;
    GroupBox8: TGroupBox;
    Label11: TLabel;
    EditHP: TSpinEdit;
    Label12: TLabel;
    EditDC: TSpinEdit;
    EditMP: TSpinEdit;
    Label13: TLabel;
    EditDC2: TSpinEdit;
    Label14: TLabel;
    EditMC2: TSpinEdit;
    Label15: TLabel;
    EditMC: TSpinEdit;
    Label16: TLabel;
    Label17: TLabel;
    EditSC: TSpinEdit;
    Label18: TLabel;
    EditSC2: TSpinEdit;
    Label19: TLabel;
    EditAC: TSpinEdit;
    Label20: TLabel;
    EditAC2: TSpinEdit;
    EditMAC2: TSpinEdit;
    Label21: TLabel;
    EditMAC: TSpinEdit;
    Label22: TLabel;
    EditDCExp: TSpinEdit;
    Label23: TLabel;
    EditMCExp: TSpinEdit;
    Label24: TLabel;
    EditSCExp: TSpinEdit;
    Label25: TLabel;
    EditACExp: TSpinEdit;
    Label26: TLabel;
    EditMACExp: TSpinEdit;
    Label27: TLabel;
    Label28: TLabel;
    seEditSpinMagicShield: TSpinEdit;
    Label29: TLabel;
    seEditSpinRevival: TSpinEdit;
    Label30: TLabel;
    SpinEdit29: TSpinEdit;
    EditSpeedPoint: TSpinEdit;
    Label31: TLabel;
    EditHitPoint: TSpinEdit;
    Label32: TLabel;
    EditAntiMagic: TSpinEdit;
    Label33: TLabel;
    EditExp: TSpinEdit;
    Label34: TLabel;
    EditAntiPoison: TSpinEdit;
    Label35: TLabel;
    EditHealthRecover: TSpinEdit;
    Label36: TLabel;
    EditSpellRecover: TSpinEdit;
    Label37: TLabel;
    EditPoisonRecover: TSpinEdit;
    Label38: TLabel;
    seEditSpinParalysis: TSpinEdit;
    Label39: TLabel;
    SpinEdit25: TSpinEdit;
    Label40: TLabel;
    EditSuitCount: TSpinEdit;
    Label41: TLabel;
    Label42: TLabel;
    EditSuitItems: TEdit;
    EditSuitHint: TEdit;
    Label43: TLabel;
    ButtonSuitSave: TButton;
    GroupBox9: TGroupBox;
    ButtonSuitEdit: TButton;
    ButtonSuitDel: TButton;
    ButtonSuitAdd: TButton;
    ListViewSuit: TListView;
    Label44: TLabel;
    TabSheet7: TTabSheet;
    GroupBox10: TGroupBox;
    ListBoxFilterList: TListBox;
    ButtonFilterAdd: TButton;
    ButtonFilterDel: TButton;
    ButtonFilterSave: TButton;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    GroupBox11: TGroupBox;
    ListBox1: TListBox;
    DieDisapAdd: TButton;
    DieDisapDel: TButton;
    DieDisapAddAll: TButton;
    DieDisapDelAll: TButton;
    DieDisapSave: TButton;
    GroupBox12: TGroupBox;
    ListBoxDieDisapItems: TListBox;
    GroupBox13: TGroupBox;
    ListBox3: TListBox;
    GhostDisapAdd: TButton;
    GhostDisapDel: TButton;
    GhostDisapAddAll: TButton;
    GhostDisapDelAll: TButton;
    GhostDisapSave: TButton;
    GroupBox14: TGroupBox;
    ListBoxGhostDisapItems: TListBox;
    TabSheet10: TTabSheet;
    GroupBox15: TGroupBox;
    ListBoxItem: TListBox;
    GroupBox16: TGroupBox;
    ListBoxRuleItems: TListBox;
    GroupBox17: TGroupBox;
    Label45: TLabel;
    EditRuleName: TEdit;
    GroupBox18: TGroupBox;
    CheckBoxMake: TCheckBox;
    CheckBoxDeal: TCheckBox;
    CheckBoxDropDown: TCheckBox;
    CheckBoxSave: TCheckBox;
    CheckBoxTakeOff: TCheckBox;
    CheckBoxSell: TCheckBox;
    CheckBoxDeath: TCheckBox;
    CheckBoxBoxs: TCheckBox;
    CheckBoxGhost: TCheckBox;
    CheckBoxPlaySell: TCheckBox;
    CheckBoxResell: TCheckBox;
    CheckBoxNoDrop: TCheckBox;
    CheckBoxDropHint: TCheckBox;
    CheckBoxNoLevel: TCheckBox;
    CheckBoxButchItem: TCheckBox;
    CheckBoxHeroBag: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    ButtonAllAdd: TButton;
    ButtonAllClose: TButton;
    ButtonRuleAdd: TButton;
    ButtonRuleDel: TButton;
    ButtonRuleAllAdd: TButton;
    ButtonRuleEdit: TButton;
    ButtonRuleSave: TButton;
    ButtonRuleAllDel: TButton;
    ButtonEdit: TButton;
    procedure ListBoxitemListClck(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ListViewShopListClick(Sender: TObject);
    procedure ButtonDelClick(Sender: TObject);
    procedure ButtonRefurClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ListViewShopListChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure PageControl2Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure ButtonHeroPickAddClick(Sender: TObject);
    procedure ListBoxHeroItemsClick(Sender: TObject);
    procedure ListBoxHeroPickListClick(Sender: TObject);
    procedure ButtonHeroPickAddAllClick(Sender: TObject);
    procedure ButtonHeroPickDeleteAllClick(Sender: TObject);
    procedure ButtonHeroPickDeleteClick(Sender: TObject);
    procedure ButtonHeroPickSaveClick(Sender: TObject);
    procedure LevelItemAllAddClick(Sender: TObject);
    procedure LevelItemAllDelClick(Sender: TObject);
    procedure LevelItemAddClick(Sender: TObject);
    procedure LevelItemDelClick(Sender: TObject);
    procedure stLevelItemsClick(Sender: TObject);
    procedure ListBoxHeroItems2Click(Sender: TObject);
    procedure LevelItemSaveClick(Sender: TObject);
    procedure SellAddClick(Sender: TObject);
    procedure SellDelClick(Sender: TObject);
    procedure ListBoxItemList3Click(Sender: TObject);
    procedure ListBoxSellItemListClick(Sender: TObject);
    procedure SellAllAddClick(Sender: TObject);
    procedure SellAllDelClick(Sender: TObject);
    procedure SellSaveClick(Sender: TObject);
    procedure EditSuitItemsChange(Sender: TObject);
    procedure ListViewSuitChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ButtonSuitEditClick(Sender: TObject);
    procedure ButtonSuitDelClick(Sender: TObject);
    procedure ButtonSuitAddClick(Sender: TObject);
    procedure ButtonSuitSaveClick(Sender: TObject);
    procedure ButtonFilterAddClick(Sender: TObject);
    procedure ListBoxFilterListClick(Sender: TObject);
    procedure ButtonFilterDelClick(Sender: TObject);
    procedure ButtonFilterSaveClick(Sender: TObject);
    procedure DieDisapAddClick(Sender: TObject);
    procedure DieDisapDelClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBoxDieDisapItemsClick(Sender: TObject);
    procedure DieDisapAddAllClick(Sender: TObject);
    procedure DieDisapDelAllClick(Sender: TObject);
    procedure DieDisapSaveClick(Sender: TObject);
    procedure GhostDisapAddClick(Sender: TObject);
    procedure GhostDisapDelClick(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure ListBoxGhostDisapItemsClick(Sender: TObject);
    procedure GhostDisapAddAllClick(Sender: TObject);
    procedure GhostDisapDelAllClick(Sender: TObject);
    procedure GhostDisapSaveClick(Sender: TObject);
    procedure ButtonAllCloseClick(Sender: TObject);
    procedure ButtonAllAddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBoxItemClick(Sender: TObject);
    procedure ListBoxRuleItemsClick(Sender: TObject);
    procedure ButtonRuleAddClick(Sender: TObject);
    procedure ButtonRuleDelClick(Sender: TObject);
    procedure ButtonRuleEditClick(Sender: TObject);
    procedure ButtonRuleAllDelClick(Sender: TObject);
    procedure ButtonRuleAllAddClick(Sender: TObject);
    procedure ButtonRuleSaveClick(Sender: TObject);
    procedure ListBoxitemListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonEditClick(Sender: TObject);
  private
    boModValued: Boolean;
    procedure RefViewList();
    procedure RefSuitItems();
    procedure LoadShopItemList();
    procedure ModValue;
    procedure uModValue;
    procedure ClearRuleBut(boAdd: Boolean);
    procedure SetRuleBut(boAdd: Boolean; RuleItems: pTRuleItems);
  public
    procedure Open();
  end;

var
  FormList2: TFormList2;

implementation
uses
  LocalDB, HUtil32;

{$R *.dfm}

procedure TFormList2.ModValue;
begin
  try
    boModValued := True;
    ButtonHeroPickSave.Enabled := True;
    ButtonSave.Enabled := True;
    ButtonRefur.Enabled := True;
    LevelItemSave.Enabled := True;
    ButtonSuitSave.Enabled := True;
    SellSave.Enabled := True;
    ButtonFilterSave.Enabled := True;
    DieDisapSave.Enabled := True;
    GhostDisapSave.Enabled := True;
    ButtonRuleSave.Enabled := True;
  except
    MainOutMessage('[Exception] TFormList2.ModValue');
  end;
end;

procedure TFormList2.uModValue;
begin
  try
    boModValued := False;
    ButtonHeroPickSave.Enabled := False;
    ButtonSave.Enabled := False;
    ButtonRefur.Enabled := False;
    LevelItemSave.Enabled := False;
    SellSave.Enabled := False;
    ButtonSuitSave.Enabled := False;
    ButtonFilterSave.Enabled := False;
    DieDisapSave.Enabled := False;
    GhostDisapSave.Enabled := False;
    ButtonRuleSave.Enabled := False;
  except
    MainOutMessage('[Exception] TFormList2.uModValue');
  end;
end;

procedure TFormList2.Open();
begin
  try
    PageControl1.TabIndex := 0;
    PageControl2.TabIndex := 0;
    RefViewList();
    RefSuitItems();
    uModValue;
    ShowModal;
  except
    MainOutMessage('[Exception] TFormList2.Open');
  end;
end;

procedure TFormList2.RefViewList();
var
  I {,II}: Integer;
  StdItem: TItem;
  RuleItems, RuleItemsEx: pTRuleItems;
  //  Script:pTScript;
  //  SayingRecord:pTSayingRecord;
begin
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    try
      ListBoxHeroItems.Items.AddObject(sSTRING_GOLDNAME, TObject(nil));
      for I := 0 to UserEngine.StdItemList.Count - 1 do
      begin
        StdItem := UserEngine.StdItemList.Items[I];
        ListBoxitemList.Items.AddObject(StdItem.Name, TObject(StdItem));
        ListBoxItemList3.Items.AddObject(StdItem.Name, TObject(StdItem));
        ListBoxHeroItems.Items.AddObject(StdItem.Name, TObject(StdItem));
        ListBox1.Items.AddObject(StdItem.Name, TObject(StdItem));
        ListBox3.Items.AddObject(StdItem.Name, TObject(StdItem));
        ListBoxItem.Items.AddObject(StdItem.Name, TObject(StdItem));
        if StdItem.ItemType in [ITEM_WEAPON, ITEM_ARMOR, ITEM_ACCESSORY] then
          ListBoxHeroItems2.Items.AddObject(StdItem.Name, TObject(StdItem));
      end;
    finally
      LeaveCriticalSection(ProcessHumanCriticalSection);
    end;
    for I := 0 to FilterList.Count - 1 do
    begin
      ListBoxFilterList.Items.Add(FilterList.Strings[I]);
    end;
    for I := 0 to RuleItemList.Count - 1 do
    begin
      RuleItems := RuleItemList.Items[I];
      New(RuleItemsEx);
      RuleItemsEx^ := RuleItems^;
      ListBoxRuleItems.Items.AddObject(RuleItems.sItemName,
        TObject(RuleItemsEx));
    end;
    LoadShopItemList();
    ListBoxHeroPickList.Items := HeroPickItemList;
    stLevelItems.Items := LevelItemList;
    ListBoxSellItemList.Items := SellItemList;
    ListBoxDieDisapItems.Items := DieDisapItemList;
    ListBoxGhostDisapItems.Items := GhostDisapItemList;
  except
    MainOutMessage('[Exception] TFormList2.RefViewList');
  end;
end;

procedure TFormList2.LoadShopItemList();
var
  FileItem: pTFileItem;
  Item: TListItem;
  I: Integer;
begin
  try
    ListViewShopList.Clear;
    for I := 0 to Shop.m_Item.Count - 1 do
    begin
      FileItem := Shop.m_Item.Items[I];
      Item := ListViewShopList.Items.Add;
      Item.Caption := IntToStr(FileItem.Idx);
      Item.SubItems.Add(FileItem.sName);
      Item.SubItems.Add(IntToStr(FileItem.sItem));
      Item.SubItems.Add(IntToStr(FileItem.sPrict));
      Item.SubItems.Add(IntToStr(FileItem.sEffect));
      Item.SubItems.Add(IntToStr(FileItem.sEffectCount));
      Item.SubItems.Add(FileItem.sText);
    end;
  except
    MainOutMessage('[Exception] TFormList2.LoadShopItemList');
  end;
end;

procedure TFormList2.ListBoxitemListClck(Sender: TObject);
var
  StdItem: TItem;
begin
  try
    if ListBoxItemList.ItemIndex > -1 then
    begin
      StdItem :=
        TItem(ListBoxItemList.Items.Objects[ListBoxItemList.ItemIndex]);
      EditName.Text := StdItem.Name;
      SpinEditItems.Value := StdItem.Looks;
      ButtonAdd.Enabled := True;
    end;
  except
    MainOutMessage('[Exception] TFormList2.ListBoxitemListClck');
  end;
end;

procedure TFormList2.ListBoxitemListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sIPaddr: string;
  I, nIdx: Integer;
begin
  if (ssCtrl in Shift) and (Key = word('F')) then
  begin
    sIPaddr := InputBox('查找信息',
      '请输入要查找的内容(支持模糊查找)', '');
    nIdx := ListBoxitemList.ItemIndex + 1;
    if nIdx >= ListBoxitemList.Count then
      nIdx := 0;
    for I := nIdx to ListBoxitemList.Count - 1 do
    begin
      if CompareLStr(ListBoxItemList.Items.Strings[I], sIPaddr, Length(sIPAddr))
        then
      begin
        ListBoxitemList.Selected[I] := True;
        break;
      end;
    end;
  end;

end;

procedure TFormList2.ButtonEditClick(Sender: TObject);
var
  Item: TListItem;
begin
  if ListViewShopList.ItemIndex > -1 then
  begin
    Item := ListViewShopList.Items.Item[ListViewShopList.ItemIndex];
    Item.SubItems[0] := EditName.Text;
    Item.SubItems[1] := SpinEditItems.Text;
    Item.SubItems[2] := SpinEditPrice.Text;
    Item.SubItems[3] := SpinEditEffectID.Text;
    Item.SubItems[4] := SpinEditEffectCount.Text;
    Item.SubItems[5] := EditText.Text;
    ModValue;
  end;
end;

procedure TFormList2.ButtonAddClick(Sender: TObject);
var
  I: Integer;
  Item: TListItem;
begin
  try
    try
      for I := 0 to ListViewShopList.Items.Count - 1 do
      begin
        Item := ListViewShopList.Items.Item[I];
        if (CompareText(Item.SubItems.Strings[0], EditName.Text) = 0) and
          (CompareText(Item.Caption, IntToStr(ComboBoxClass.ItemIndex)) = 0) then
        begin
          MessageBox(Handle, '添加的物品已经存在于列表当中...',
            '提示信息', MB_OK or MB_ICONASTERISK);
          exit;
        end;
      end;
      Item := ListViewShopList.Items.Add;
      Item.Caption := IntToStr(ComboBoxClass.ItemIndex);
      Item.SubItems.Add(EditName.Text);
      Item.SubItems.Add(SpinEditItems.Text);
      Item.SubItems.Add(SpinEditPrice.Text);
      Item.SubItems.Add(SpinEditEffectID.Text);
      Item.SubItems.Add(SpinEditEffectCount.Text);
      Item.SubItems.Add(EditText.Text);
      ButtonAdd.Enabled := False;
      ModValue;
    except
      MainOutMessage('[Exception] ButtonAddClick');
    end;
  except
    MainOutMessage('[Exception] TFormList2.ButtonAddClick');
  end;
end;

procedure TFormList2.ListViewShopListClick(Sender: TObject);
var
  Item: TListItem;
begin
  try
    if ListViewShopList.ItemIndex > -1 then
    begin
      Item := ListViewShopList.Items.Item[ListViewShopList.ItemIndex];
      ComboBoxClass.ItemIndex := StrToInt(Item.Caption);
      EditName.Text := Item.SubItems.Strings[0];
      SpinEditItems.Text := Item.SubItems.Strings[1];
      SpinEditPrice.Text := Item.SubItems.Strings[2];
      SpinEditEffectID.Text := Item.SubItems.Strings[3];
      SpinEditEffectCount.Text := Item.SubItems.Strings[4];
      EditText.Text := Item.SubItems.Strings[5];
    end;
  except
    MainOutMessage('[Exception] TFormList2.ListViewShopListClick');
  end;
end;

procedure TFormList2.ButtonDelClick(Sender: TObject);
var
  Item: TListItem;
begin
  try
    try
      if ListViewShopList.ItemIndex > -1 then
      begin
        Item := ListViewShopList.Items.Item[ListViewShopList.ItemIndex];
        if MessageBox(Handle,
          PChar('确定删除物品 ' + Item.SubItems.Strings[0] + '?...'),
          '提示信息',
          MB_YESNO or MB_ICONQUESTION) = IDYES then
        begin
          ListViewShopList.Items.Delete(ListViewShopList.ItemIndex);
          ButtonDel.Enabled := False;
          ButtonEdit.Enabled := False;
          ModValue;
        end;
      end;
    except
      MainOutMessage('[Exception] ButtonDelClick');
    end;
  except
    MainOutMessage('[Exception] TFormList2.ButtonDelClick');
  end;
end;

procedure TFormList2.ButtonRefurClick(Sender: TObject);
begin
  try
    try
      if MessageBox(Handle,
        PChar('是否确定重新加载物品列表?...'),
        '提示信息',
        MB_YESNO or MB_ICONQUESTION) = IDYES then
      begin
        LoadShopItemList;
        uModValue;
      end;
    except
      MainOutMessage('[Exception] ButtonRefurClick');
    end;
  except
    MainOutMessage('[Exception] TFormList2.ButtonRefurClick');
  end;
end;

procedure TFormList2.ButtonSaveClick(Sender: TObject);
var
  Item: TListItem;
  I: Integer;
  FileItem: pTFileItem;
begin
  try
    try
      Shop.ClearList;
      for I := 0 to ListViewShopList.Items.Count - 1 do
      begin
        Item := ListViewShopList.Items[I];
        New(FileItem);
        FileItem.Idx := StrToInt(Item.Caption);
        FileItem.sName := Item.SubItems.Strings[0];
        FileItem.sItem := StrToInt(Item.SubItems.Strings[1]);
        FileItem.sPrict := StrToInt(Item.SubItems.Strings[2]);
        FileItem.sEffect := StrToInt(Item.SubItems.Strings[3]);
        FileItem.sEffectCount := StrToInt(Item.SubItems.Strings[4]);
        FileItem.sText := Item.SubItems.Strings[5];
        Shop.m_Item.Add(FileItem);
      end;
      Shop.SaveItemToFile;
      if MessageBox(Handle,
        PChar('保存列表完成,是否刷新服务器列表?...'),
        '提示信息',
        MB_YESNO or MB_ICONQUESTION) = IDYES then
      begin
        Shop.EDcodeMsg;
      end;
      ButtonAdd.Enabled := False;
      ButtonDel.Enabled := False;
      ButtonEdit.Enabled := False;
      uModValue;
    except
      MainOutMessage('[Exception] ButtonSaveClick');
    end;
  except
    MainOutMessage('[Exception] TFormList2.ButtonSaveClick');
  end;
end;

procedure TFormList2.ListViewShopListChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  try
    if ListViewShopList.ItemIndex > -1 then
    begin
      try
        ComboBoxClass.ItemIndex := StrToInt(Item.Caption);
      except
      end;
      if Item.SubItems <> nil then
      begin
        EditName.Text := Item.SubItems.Strings[0];
        SpinEditItems.Text := Item.SubItems.Strings[1];
        SpinEditPrice.Text := Item.SubItems.Strings[2];
        SpinEditEffectID.Text := Item.SubItems.Strings[3];
        SpinEditEffectCount.Text := Item.SubItems.Strings[4];
        EditText.Text := Item.SubItems.Strings[5];
        ButtonDel.Enabled := True;
        ButtonEdit.Enabled := True;
      end;
    end;
  except
    //MainOutMessage('[Exception] TFormList2.ListViewShopListChange');
  end;
end;

procedure TFormList2.PageControl2Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  try
    if boModValued then
    begin
      if
        Application.MessageBox('参数设置已经被修改，是否确认不保存修改的设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) = IDYES then
      begin
        uModValue
      end
      else
        AllowChange := False;
    end;
  except
    MainOutMessage('[Exception] TFormList2.PageControl2Changing');
  end;
end;

procedure TFormList2.ButtonHeroPickAddClick(Sender: TObject);
var
  //  StdItem:TItem;
  I: Integer;
  ItemName: string;
begin
  try
    if ListBoxHeroItems.ItemIndex > -1 then
    begin
      ItemName := ListBoxHeroItems.Items.Strings[ListBoxHeroItems.ItemIndex];
      I := ListBoxHeroPickList.Items.IndexOf(ItemName);
      if I = -1 then
      begin
        ListBoxHeroPickList.Items.Add(ItemName);
      end
      else
        Application.MessageBox('您所增加的项目已经存在列表当中？', '确认信息', MB_OK + MB_ICONASTERISK);
      ButtonHeroPickAdd.Enabled := False;
      ModValue;
    end;

  except
    MainOutMessage('[Exception] TFormList2.ButtonHeroPickAddClick');
  end;
end;

procedure TFormList2.ListBoxHeroItemsClick(Sender: TObject);
begin
  try
    if ListBoxHeroItems.ItemIndex > -1 then
    begin
      ButtonHeroPickAdd.Enabled := True;
    end;
  except
    MainOutMessage('[Exception] TFormList2.ListBoxHeroItemsClick');
  end;
end;

procedure TFormList2.ListBoxHeroPickListClick(Sender: TObject);
begin
  try
    if ListBoxHeroPickList.ItemIndex > -1 then
    begin
      ButtonHeroPickDelete.Enabled := True;
    end;
  except
    MainOutMessage('[Exception] TFormList2.ListBoxHeroPickListClick');
  end;
end;

procedure TFormList2.ButtonHeroPickAddAllClick(Sender: TObject);
begin
  try
    ListBoxHeroPickList.Items := ListBoxHeroItems.Items;
    ButtonHeroPickAdd.Enabled := False;
    ButtonHeroPickDelete.Enabled := False;
    ModValue;
  except
    MainOutMessage('[Exception] TFormList2.ButtonHeroPickAddAllClick');
  end;
end;

procedure TFormList2.ButtonHeroPickDeleteAllClick(Sender: TObject);
begin
  try
    ListBoxHeroPickList.Items.Clear;
    ButtonHeroPickAdd.Enabled := False;
    ButtonHeroPickDelete.Enabled := False;
    ModValue;
  except
    MainOutMessage('[Exception] TFormList2.ButtonHeroPickDeleteAllClick');
  end;
end;

procedure TFormList2.ButtonHeroPickDeleteClick(Sender: TObject);
begin
  try
    if ListBoxHeroPickList.ItemIndex > -1 then
    begin
      ListBoxHeroPickList.Items.Delete(ListBoxHeroPickList.ItemIndex);
      ButtonHeroPickDelete.Enabled := False;
      ModValue;
    end;
  except
    MainOutMessage('[Exception] TFormList2.ButtonHeroPickDeleteClick');
  end;
end;

procedure TFormList2.ButtonHeroPickSaveClick(Sender: TObject);
var
  I: Integer;
begin
  try
    HeroPickItemList.Clear;
    for I := 0 to ListBoxHeroPickList.Items.Count - 1 do
    begin
      HeroPickItemList.Add(ListBoxHeroPickList.Items.Strings[I]);
    end;
    SaveHeroPickItemNameList;
    if
      Application.MessageBox('此设置必须重新加载物品数据库才能生效，是否重新加载？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then
    begin
      FrmDB.LoadItemsDB();
    end;
    uModValue;
  except
    MainOutMessage('[Exception] TFormList2.ButtonHeroPickSaveClick');
  end;
end;

procedure TFormList2.LevelItemAllAddClick(Sender: TObject);
begin
  try
    stLevelItems.Items := ListBoxHeroItems2.Items;
    LevelItemAdd.Enabled := False;
    LevelItemDel.Enabled := False;
    ModValue;
  except
    MainOutMessage('[Exception] TFormList2.LevelItemAllAddClick');
  end;
end;

procedure TFormList2.LevelItemAllDelClick(Sender: TObject);
begin
  try
    stLevelItems.Items.Clear;
    LevelItemAdd.Enabled := False;
    LevelItemDel.Enabled := False;
    ModValue;
  except
    MainOutMessage('[Exception] TFormList2.LevelItemAllDelClick');
  end;
end;

procedure TFormList2.LevelItemAddClick(Sender: TObject);
var
  //  StdItem:TItem;
  I: Integer;
  ItemName: string;
begin
  try
    if ListBoxHeroItems2.ItemIndex > -1 then
    begin
      ItemName := ListBoxHeroItems2.Items.Strings[ListBoxHeroItems2.ItemIndex];
      I := stLevelItems.Items.IndexOf(ItemName);
      if I = -1 then
      begin
        stLevelItems.Items.Add(ItemName);
      end
      else
        Application.MessageBox('您所增加的项目已经存在列表当中？', '确认信息', MB_OK + MB_ICONASTERISK);
      LevelItemAdd.Enabled := False;
      ModValue;
    end;
  except
    MainOutMessage('[Exception] TFormList2.LevelItemAddClick');
  end;
end;

procedure TFormList2.LevelItemDelClick(Sender: TObject);
begin
  try
    if stLevelItems.ItemIndex > -1 then
    begin
      stLevelItems.Items.Delete(stLevelItems.ItemIndex);
      LevelItemDel.Enabled := False;
      ModValue;
    end;
  except
    MainOutMessage('[Exception] TFormList2.LevelItemDelClick');
  end;
end;

procedure TFormList2.stLevelItemsClick(Sender: TObject);
begin
  try
    if stLevelItems.ItemIndex > -1 then
    begin
      LevelItemDel.Enabled := True;
    end;
  except
    MainOutMessage('[Exception] TFormList2.stLevelItemsClick');
  end;
end;

procedure TFormList2.ListBoxHeroItems2Click(Sender: TObject);
begin
  try
    if ListBoxHeroItems2.ItemIndex > -1 then
    begin
      LevelItemAdd.Enabled := True;
    end;
  except
    MainOutMessage('[Exception] TFormList2.ListBoxHeroItems2Click');
  end;
end;

procedure TFormList2.LevelItemSaveClick(Sender: TObject);
var
  I: Integer;
begin
  try
    LevelItemList.Clear;
    for I := 0 to stLevelItems.Items.Count - 1 do
    begin
      LevelItemList.Add(stLevelItems.Items.Strings[I]);
    end;
    SaveLevelItemNameList;
    if
      Application.MessageBox('此设置必须重新加载物品数据库才能生效，是否重新加载？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then
    begin
      FrmDB.LoadItemsDB();
    end;
    uModValue;
  except
    MainOutMessage('[Exception] TFormList2.LevelItemSaveClick');
  end;
end;

procedure TFormList2.SellAddClick(Sender: TObject);
var
  //  StdItem:TItem;
  I: Integer;
  ItemName: string;
begin
  try
    if ListBoxItemList3.ItemIndex > -1 then
    begin
      ItemName := ListBoxItemList3.Items.Strings[ListBoxHeroItems2.ItemIndex];
      I := ListBoxSellItemList.Items.IndexOf(ItemName);
      if I = -1 then
      begin
        ListBoxSellItemList.Items.Add(ItemName);
      end
      else
        Application.MessageBox('您所增加的项目已经存在列表当中？', '确认信息', MB_OK + MB_ICONASTERISK);
      SellAdd.Enabled := False;
      ModValue;
    end;
  except
    MainOutMessage('[Exception] TFormList2.SellAddClick');
  end;
end;

procedure TFormList2.SellDelClick(Sender: TObject);
begin
  try
    if ListBoxSellItemList.ItemIndex > -1 then
    begin
      ListBoxSellItemList.Items.Delete(stLevelItems.ItemIndex);
      SellDel.Enabled := False;
      ModValue;
    end;
  except
    MainOutMessage('[Exception] TFormList2.LevelItemDelClick');
  end;
end;

procedure TFormList2.ListBoxItemList3Click(Sender: TObject);
begin
  if ListBoxItemList3.ItemIndex > -1 then
  begin
    SellAdd.Enabled := True;
  end;
end;

procedure TFormList2.ListBoxSellItemListClick(Sender: TObject);
begin
  if ListBoxSellItemList.ItemIndex > -1 then
  begin
    SellDel.Enabled := True;
  end;
end;

procedure TFormList2.SellAllAddClick(Sender: TObject);
begin
  ListBoxSellItemList.Items := ListBoxItemList3.Items;
  SellAdd.Enabled := False;
  SellDel.Enabled := False;
  ModValue;
end;

procedure TFormList2.SellAllDelClick(Sender: TObject);
begin
  ListBoxSellItemList.Items.Clear;
  SellAdd.Enabled := False;
  SellDel.Enabled := False;
  ModValue;
end;

procedure TFormList2.SellSaveClick(Sender: TObject);
var
  I: Integer;
begin
  try
    SellItemList.Clear;
    for I := 0 to ListBoxSellItemList.Items.Count - 1 do
    begin
      SellItemList.Add(ListBoxSellItemList.Items.Strings[I]);
    end;
    SaveSellItemNameList;
    if
      Application.MessageBox('此设置必须重新加载物品数据库才能生效，是否重新加载？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then
    begin
      FrmDB.LoadItemsDB();
    end;
    uModValue;
  except
    MainOutMessage('[Exception] TFormList2.SellSaveClick');
  end;
end;

procedure TFormList2.RefSuitItems();
var
  Item: TListItem;
  SuitItems: pTSuitItems;
  I, X: Integer;
  sItem: string;
begin
  ListViewSuit.Items.Clear;
  for I := 0 to SuitItemList.Count - 1 do
  begin
    SuitItems := SuitItemList.Items[I];
    Item := ListViewSuit.Items.Add;
    Item.Caption := IntToStr(I);
    Item.SubItems.Add(SuitItems.sHint);
    Item.SubItems.Add(IntToStr(SuitItems.nCount));
    sItem := '';
    for X := 0 to High(SuitItems.sItems) do
      if SuitItems.sItems[X] <> '' then
        sItem := sItem + SuitItems.sItems[X] + '|';
    Item.SubItems.Add(sItem);
    sItem := '';
    for X := 0 to High(SuitItems.nPoint) do
      sItem := sItem + IntToStr(SuitItems.nPoint[X]) + '|';
    Item.SubItems.Add(sItem);
  end;
end;

procedure TFormList2.EditSuitItemsChange(Sender: TObject);
begin
  if Sender is TSpinEdit then
  begin
    if TSpinEdit(Sender).Value = 0 then
      TSpinEdit(Sender).Color := clWhite
    else
      TSpinEdit(Sender).Color := clLime;
  end;
  ButtonSuitAdd.Enabled := True;
  if ListViewSuit.ItemIndex > -1 then
    ButtonSuitEdit.Enabled := True;
end;

procedure TFormList2.ListViewSuitChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  SuitItems: TSuitItems;
  X: Integer;
  sTemp, sInt: string;
begin
  try
    if (ListViewSuit.ItemIndex > -1) and (Item <> nil) and (Item.SubItems <> nil)
      then
    begin
      ButtonSuitDel.Enabled := True;
      EditSuitCount.Value := StrToInt(Item.SubItems.Strings[1]);
      EditSuitHint.Text := Item.SubItems.Strings[0];
      EditSuitItems.Text := Item.SubItems.Strings[2];
      sTemp := Item.SubItems.Strings[3];
      X := 0;
      FillChar(SuitItems, SizeOf(TSuitItems), #0);
      while sTemp <> '' do
      begin
        if X > High(SuitItems.nPoint) then
          break;
        sTemp := GetValidStr3(sTemp, sInt, ['|']);
        SuitItems.nPoint[X] := Str_ToInt(sInt, 0);
        Inc(X);
      end;
      EditHP.Value := SuitItems.nPoint[0];
      EditMP.Value := SuitItems.nPoint[1];
      EditExp.Value := SuitItems.nPoint[2];
      EditDC.Value := SuitItems.nPoint[3];
      EditDC2.Value := SuitItems.nPoint[4];
      EditDCExp.Value := SuitItems.nPoint[5];
      EditMC.Value := SuitItems.nPoint[6];
      EditMC2.Value := SuitItems.nPoint[7];
      EditMCExp.Value := SuitItems.nPoint[8];
      EditSC.Value := SuitItems.nPoint[9];
      EditSC2.Value := SuitItems.nPoint[10];
      EditSCExp.Value := SuitItems.nPoint[11];
      EditAC.Value := SuitItems.nPoint[12];
      EditAC2.Value := SuitItems.nPoint[13];
      EditACExp.Value := SuitItems.nPoint[14];
      EditMAC.Value := SuitItems.nPoint[15];
      EditMAC2.Value := SuitItems.nPoint[16];
      EditMACExp.Value := SuitItems.nPoint[17];
      EditHitPoint.Value := SuitItems.nPoint[18];
      EditSpeedPoint.Value := SuitItems.nPoint[19];
      EditAntiMagic.Value := SuitItems.nPoint[20];
      EditHealthRecover.Value := SuitItems.nPoint[21];
      EditSpellRecover.Value := SuitItems.nPoint[22];
      EditAntiPoison.Value := SuitItems.nPoint[23];
      EditPoisonRecover.Value := SuitItems.nPoint[24];
      SpinEdit25.Value := SuitItems.nPoint[25];
      seEditSpinParalysis.Value := SuitItems.nPoint[26];
      seEditSpinMagicShield.Value := SuitItems.nPoint[27];
      seEditSpinRevival.Value := SuitItems.nPoint[28];
      SpinEdit29.Value := SuitItems.nPoint[29];
    end;
  except
  end;
end;

procedure TFormList2.ButtonSuitEditClick(Sender: TObject);
var
  Item: TListItem;
  X: Integer;
  sItem {,sTemp}: string;
  SuitItems: TSuitItems;
begin
  try
    if (ListViewSuit.ItemIndex > -1) then
    begin
      Item := ListViewSuit.Items[ListViewSuit.ItemIndex];
      if Trim(EditSuitHint.Text) = '' then
      begin
        Application.MessageBox('套装说明不能为空？', '确认信息',
          MB_OK + MB_ICONASTERISK);
        exit;
      end;
      if Trim(EditSuitItems.Text) = '' then
      begin
        Application.MessageBox('套装物品不能为空？', '确认信息',
          MB_OK + MB_ICONASTERISK);
        exit;
      end;
      FillChar(SuitItems, SizeOf(TSuitItems), #0);
      SuitItems.nPoint[0] := EditHP.Value;
      SuitItems.nPoint[1] := EditMP.Value;
      SuitItems.nPoint[2] := EditExp.Value;
      SuitItems.nPoint[3] := EditDC.Value;
      SuitItems.nPoint[4] := EditDC2.Value;
      SuitItems.nPoint[5] := EditDCExp.Value;
      SuitItems.nPoint[6] := EditMC.Value;
      SuitItems.nPoint[7] := EditMC2.Value;
      SuitItems.nPoint[8] := EditMCExp.Value;
      SuitItems.nPoint[9] := EditSC.Value;
      SuitItems.nPoint[10] := EditSC2.Value;
      SuitItems.nPoint[11] := EditSCExp.Value;
      SuitItems.nPoint[12] := EditAC.Value;
      SuitItems.nPoint[13] := EditAC2.Value;
      SuitItems.nPoint[14] := EditACExp.Value;
      SuitItems.nPoint[15] := EditMAC.Value;
      SuitItems.nPoint[16] := EditMAC2.Value;
      SuitItems.nPoint[17] := EditMACExp.Value;
      SuitItems.nPoint[18] := EditHitPoint.Value;
      SuitItems.nPoint[19] := EditSpeedPoint.Value;
      SuitItems.nPoint[20] := EditAntiMagic.Value;
      SuitItems.nPoint[21] := EditHealthRecover.Value;
      SuitItems.nPoint[22] := EditSpellRecover.Value;
      SuitItems.nPoint[23] := EditAntiPoison.Value;
      SuitItems.nPoint[24] := EditPoisonRecover.Value;
      SuitItems.nPoint[25] := SpinEdit25.Value;
      SuitItems.nPoint[26] := seEditSpinParalysis.Value;
      SuitItems.nPoint[27] := seEditSpinMagicShield.Value;
      SuitItems.nPoint[28] := seEditSpinRevival.Value;
      SuitItems.nPoint[29] := SpinEdit29.Value;
      sItem := '';
      for X := 0 to High(SuitItems.nPoint) do
        sItem := sItem + IntToStr(SuitItems.nPoint[X]) + '|';
      Item.SubItems.Strings[3] := sItem;
      Item.SubItems.Strings[0] := Trim(EditSuitHint.Text);
      Item.SubItems.Strings[1] := IntToStr(EditSuitCount.Value);
      Item.SubItems.Strings[2] := Trim(EditSuitItems.Text);
      ButtonSuitEdit.Enabled := False;
      ButtonSuitDel.Enabled := False;
      ButtonSuitAdd.Enabled := False;
      ModValue;
    end;
  except
  end;
end;

procedure TFormList2.ButtonSuitDelClick(Sender: TObject);
begin
  if (ListViewSuit.ItemIndex > -1) then
  begin
    ListViewSuit.Items.Delete(ListViewSuit.ItemIndex);
    ButtonSuitEdit.Enabled := False;
    ButtonSuitDel.Enabled := False;
    ButtonSuitAdd.Enabled := False;
    ModValue;
  end;
end;

procedure TFormList2.ButtonSuitAddClick(Sender: TObject);
var
  Item: TListItem;
  X: Integer;
  sItem {,sTemp}: string;
  SuitItems: TSuitItems;
begin
  try
    if Trim(EditSuitHint.Text) = '' then
    begin
      Application.MessageBox('套装说明不能为空？', '确认信息', MB_OK
        + MB_ICONASTERISK);
      exit;
    end;
    if Trim(EditSuitItems.Text) = '' then
    begin
      Application.MessageBox('套装物品不能为空？', '确认信息', MB_OK
        + MB_ICONASTERISK);
      exit;
    end;
    Item := ListViewSuit.Items.Add;
    FillChar(SuitItems, SizeOf(TSuitItems), #0);
    SuitItems.nPoint[0] := EditHP.Value;
    SuitItems.nPoint[1] := EditMP.Value;
    SuitItems.nPoint[2] := EditExp.Value;
    SuitItems.nPoint[3] := EditDC.Value;
    SuitItems.nPoint[4] := EditDC2.Value;
    SuitItems.nPoint[5] := EditDCExp.Value;
    SuitItems.nPoint[6] := EditMC.Value;
    SuitItems.nPoint[7] := EditMC2.Value;
    SuitItems.nPoint[8] := EditMCExp.Value;
    SuitItems.nPoint[9] := EditSC.Value;
    SuitItems.nPoint[10] := EditSC2.Value;
    SuitItems.nPoint[11] := EditSCExp.Value;
    SuitItems.nPoint[12] := EditAC.Value;
    SuitItems.nPoint[13] := EditAC2.Value;
    SuitItems.nPoint[14] := EditACExp.Value;
    SuitItems.nPoint[15] := EditMAC.Value;
    SuitItems.nPoint[16] := EditMAC2.Value;
    SuitItems.nPoint[17] := EditMACExp.Value;
    SuitItems.nPoint[18] := EditHitPoint.Value;
    SuitItems.nPoint[19] := EditSpeedPoint.Value;
    SuitItems.nPoint[20] := EditAntiMagic.Value;
    SuitItems.nPoint[21] := EditHealthRecover.Value;
    SuitItems.nPoint[22] := EditSpellRecover.Value;
    SuitItems.nPoint[23] := EditAntiPoison.Value;
    SuitItems.nPoint[24] := EditPoisonRecover.Value;
    SuitItems.nPoint[25] := SpinEdit25.Value;
    SuitItems.nPoint[26] := seEditSpinParalysis.Value;
    SuitItems.nPoint[27] := seEditSpinMagicShield.Value;
    SuitItems.nPoint[28] := seEditSpinRevival.Value;
    SuitItems.nPoint[29] := SpinEdit29.Value;
    sItem := '';
    for X := 0 to High(SuitItems.nPoint) do
      sItem := sItem + IntToStr(SuitItems.nPoint[X]) + '|';
    Item.Caption := IntToStr(ListViewSuit.Items.Count - 1);
    Item.SubItems.Add(Trim(EditSuitHint.Text));
    Item.SubItems.Add(IntToStr(EditSuitCount.Value));
    Item.SubItems.Add(Trim(EditSuitItems.Text));
    Item.SubItems.Add(sItem);
    ButtonSuitEdit.Enabled := False;
    ButtonSuitDel.Enabled := False;
    ButtonSuitAdd.Enabled := False;
    ModValue;
  except
  end;
end;

procedure TFormList2.ButtonSuitSaveClick(Sender: TObject);
var
  I, X: Integer;
  SuitItems: pTSuitItems;
  Item: TListItem;
  sItem, sTemp: string;
begin
  try
    for I := 0 to SuitItemList.Count - 1 do
      Dispose(pTSuitItems(SuitItemList.Items[I]));
    SuitItemList.Clear;
    for I := 0 to ListViewSuit.Items.Count - 1 do
    begin
      Item := ListViewSuit.Items[I];
      New(SuitItems);
      FillChar(SuitItems^, SizeOf(TSuitItems), #0);
      SuitItems.nCount := StrToInt(Item.SubItems.Strings[1]);
      SuitItems.sHint := Item.SubItems.Strings[0];
      X := 0;
      sItem := Item.SubItems.Strings[2];
      while sItem <> '' do
      begin
        if X > High(SuitItems.sItems) then
          break;
        sItem := GetValidStr3(sItem, sTemp, ['|']);
        if sTemp <> '' then
          SuitItems.sItems[X] := sTemp;
        Inc(X);
      end;
      sItem := Item.SubItems.Strings[3];
      for X := 0 to High(SuitItems.nPoint) do
      begin
        sItem := GetValidStr3(sItem, sTemp, ['|']);
        SuitItems.nPoint[X] := Str_ToInt(sTemp, 0);
      end;
      SuitItemList.Add(SuitItems);
    end;
    SaveSuitItemList();
    FrmDB.LoadItemsDB();
    ButtonSuitEdit.Enabled := False;
    ButtonSuitDel.Enabled := False;
    ButtonSuitAdd.Enabled := False;
    uModValue;
  except
    MainOutMessage('[Exception] TFormList2.ButtonSuitSaveClick');
  end;
end;

procedure TFormList2.ButtonFilterAddClick(Sender: TObject);
var
  sInputText: string;
begin
  if not InputQuery('增加', '请输入您要过滤的内容:', sInputText)
    then
    exit;
  if sInputText = '' then
  begin
    Application.MessageBox('过滤内容不能为空!', '提示信息', MB_OK +
      MB_ICONERROR);
    exit;
  end;
  ListBoxFilterList.Items.Add(sInputText);
  ButtonFilterDel.Enabled := False;
  ModValue;
end;

procedure TFormList2.ListBoxFilterListClick(Sender: TObject);
begin
  if ListBoxFilterList.ItemIndex > -1 then
  begin
    ButtonFilterDel.Enabled := True;
  end;
end;

procedure TFormList2.ButtonFilterDelClick(Sender: TObject);
begin
  if ListBoxFilterList.ItemIndex > -1 then
  begin
    ListBoxFilterList.Items.Delete(ListBoxFilterList.ItemIndex);
    ButtonFilterDel.Enabled := False;
    ModValue;
  end;
end;

procedure TFormList2.ButtonFilterSaveClick(Sender: TObject);
var
  I: Integer;
begin
  FilterList.Clear;
  for I := 0 to ListBoxFilterList.Items.Count - 1 do
  begin
    FilterList.Add(ListBoxFilterList.Items.Strings[I]);
  end;
  SaveFilterList;
  uModValue;
end;

procedure TFormList2.DieDisapAddClick(Sender: TObject);
var
  I: Integer;
  ItemName: string;
begin
  try
    if ListBox1.ItemIndex > -1 then
    begin
      ItemName := ListBox1.Items.Strings[ListBox1.ItemIndex];
      I := ListBoxDieDisapItems.Items.IndexOf(ItemName);
      if I = -1 then
      begin
        ListBoxDieDisapItems.Items.Add(ItemName);
      end
      else
        Application.MessageBox('您所增加的项目已经存在列表当中？', '确认信息', MB_OK + MB_ICONASTERISK);
      DieDisapAdd.Enabled := False;
      ModValue;
    end;
  except
    MainOutMessage('[Exception] TFormList2.DieDisapAddClick');
  end;
end;

procedure TFormList2.DieDisapDelClick(Sender: TObject);
begin
  try
    if ListBoxDieDisapItems.ItemIndex > -1 then
    begin
      ListBoxDieDisapItems.Items.Delete(ListBoxDieDisapItems.ItemIndex);
      DieDisapDel.Enabled := False;
      ModValue;
    end;
  except
    MainOutMessage('[Exception] TFormList2.LevelItemDelClick');
  end;
end;

procedure TFormList2.ListBox1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex > -1 then
  begin
    DieDisapAdd.Enabled := True;
  end;
end;

procedure TFormList2.ListBoxDieDisapItemsClick(Sender: TObject);
begin
  if ListBoxDieDisapItems.ItemIndex > -1 then
  begin
    DieDisapDel.Enabled := True;
  end;
end;

procedure TFormList2.DieDisapAddAllClick(Sender: TObject);
begin
  ListBoxDieDisapItems.Items := ListBox1.Items;
  DieDisapAdd.Enabled := False;
  DieDisapDel.Enabled := False;
  ModValue;
end;

procedure TFormList2.DieDisapDelAllClick(Sender: TObject);
begin
  ListBoxDieDisapItems.Items.Clear;
  DieDisapAdd.Enabled := False;
  DieDisapDel.Enabled := False;
  ModValue;
end;

procedure TFormList2.DieDisapSaveClick(Sender: TObject);
var
  I: Integer;
begin
  try
    DieDisapItemList.Clear;
    for I := 0 to ListBoxDieDisapItems.Items.Count - 1 do
    begin
      DieDisapItemList.Add(ListBoxDieDisapItems.Items.Strings[I]);
    end;
    SaveDieDisapItemNameList;
    if
      Application.MessageBox('此设置必须重新加载物品数据库才能生效，是否重新加载？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then
    begin
      FrmDB.LoadItemsDB();
    end;
    uModValue;
  except
    MainOutMessage('[Exception] TFormList2.DieDisapSaveClick');
  end;
end;

procedure TFormList2.GhostDisapAddClick(Sender: TObject);
var
  I: Integer;
  ItemName: string;
begin
  try
    if ListBox3.ItemIndex > -1 then
    begin
      ItemName := ListBox3.Items.Strings[ListBox3.ItemIndex];
      I := ListBoxGhostDisapItems.Items.IndexOf(ItemName);
      if I = -1 then
      begin
        ListBoxGhostDisapItems.Items.Add(ItemName);
      end
      else
        Application.MessageBox('您所增加的项目已经存在列表当中？', '确认信息', MB_OK + MB_ICONASTERISK);
      GhostDisapAdd.Enabled := False;
      ModValue;
    end;
  except
    MainOutMessage('[Exception] TFormList2.DieDisapAddClick');
  end;
end;

procedure TFormList2.GhostDisapDelClick(Sender: TObject);
begin
  try
    if ListBoxGhostDisapItems.ItemIndex > -1 then
    begin
      ListBoxGhostDisapItems.Items.Delete(ListBoxGhostDisapItems.ItemIndex);
      GhostDisapDel.Enabled := False;
      ModValue;
    end;
  except
    MainOutMessage('[Exception] TFormList2.LevelItemDelClick');
  end;
end;

procedure TFormList2.ListBox3Click(Sender: TObject);
begin
  if ListBox3.ItemIndex > -1 then
  begin
    GhostDisapAdd.Enabled := True;
  end;
end;

procedure TFormList2.ListBoxGhostDisapItemsClick(Sender: TObject);
begin
  if ListBoxGhostDisapItems.ItemIndex > -1 then
  begin
    GhostDisapDel.Enabled := True;
  end;
end;

procedure TFormList2.GhostDisapAddAllClick(Sender: TObject);
begin
  ListBoxGhostDisapItems.Items := ListBox3.Items;
  GhostDisapAdd.Enabled := False;
  GhostDisapDel.Enabled := False;
  ModValue;
end;

procedure TFormList2.GhostDisapDelAllClick(Sender: TObject);
begin
  ListBoxGhostDisapItems.Items.Clear;
  GhostDisapAdd.Enabled := False;
  GhostDisapDel.Enabled := False;
  ModValue;
end;

procedure TFormList2.GhostDisapSaveClick(Sender: TObject);
var
  I: Integer;
begin
  try
    GhostDisapItemList.Clear;
    for I := 0 to ListBoxGhostDisapItems.Items.Count - 1 do
    begin
      GhostDisapItemList.Add(ListBoxGhostDisapItems.Items.Strings[I]);
    end;
    SaveGhostDisapItemNameList;
    if
      Application.MessageBox('此设置必须重新加载物品数据库才能生效，是否重新加载？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then
    begin
      FrmDB.LoadItemsDB();
    end;
    uModValue;
  except
    MainOutMessage('[Exception] TFormList2.GhostDisapSaveClick');
  end;
end;

procedure TFormList2.ClearRuleBut(boAdd: Boolean);
begin
  CheckBoxMake.Checked := boAdd;
  CheckBoxDeal.Checked := boAdd;
  CheckBoxDropDown.Checked := boAdd;
  CheckBoxSave.Checked := boAdd;
  CheckBoxTakeOff.Checked := boAdd;
  CheckBoxSell.Checked := boAdd;
  CheckBoxDeath.Checked := boAdd;
  CheckBoxBoxs.Checked := boAdd;
  CheckBoxGhost.Checked := boAdd;
  CheckBoxPlaySell.Checked := boAdd;
  CheckBoxResell.Checked := boAdd;
  CheckBoxNoDrop.Checked := boAdd;
  CheckBoxDropHint.Checked := boAdd;
  CheckBoxNoLevel.Checked := boAdd;
  CheckBoxButchItem.Checked := boAdd;
   CheckBoxHeroBag.Checked := boAdd;
end;

procedure TFormList2.SetRuleBut(boAdd: Boolean; RuleItems: pTRuleItems);
begin
  if boAdd then
  begin
    ClearRuleBut(False);
    CheckBoxMake.Checked := RuleItems.nRule[RULE_Make];
    CheckBoxDeal.Checked := RuleItems.nRule[RULE_Deal];
    CheckBoxDropDown.Checked := RuleItems.nRule[RULE_DropDown];
    CheckBoxSave.Checked := RuleItems.nRule[RULE_Save];
    CheckBoxTakeOff.Checked := RuleItems.nRule[RULE_TakeOff];
    CheckBoxSell.Checked := RuleItems.nRule[RULE_Sell];
    CheckBoxDeath.Checked := RuleItems.nRule[RULE_Death];
    CheckBoxBoxs.Checked := RuleItems.nRule[RULE_BOXS];
    CheckBoxGhost.Checked := RuleItems.nRule[RULE_Ghost];
    CheckBoxPlaySell.Checked := RuleItems.nRule[RULE_PlaySell];
    CheckBoxResell.Checked := RuleItems.nRule[RULE_Resell];
    CheckBoxNoDrop.Checked := RuleItems.nRule[RULE_NoDrop];
    CheckBoxDropHint.Checked := RuleItems.nRule[RULE_DropHint];
    CheckBoxNoLevel.Checked := RuleItems.nRule[RULE_NoLevel];
    CheckBoxButchItem.Checked := RuleItems.nRule[RULE_BUTCHITEM];
    CheckBoxHeroBag.Checked := RuleItems.nRule[RULE_HeroBag];
  end
  else
  begin
    RuleItems.nRule[RULE_Make] := CheckBoxMake.Checked;
    RuleItems.nRule[RULE_Deal] := CheckBoxDeal.Checked;
    RuleItems.nRule[RULE_DropDown] := CheckBoxDropDown.Checked;
    RuleItems.nRule[RULE_Save] := CheckBoxSave.Checked;
    RuleItems.nRule[RULE_TakeOff] := CheckBoxTakeOff.Checked;
    RuleItems.nRule[RULE_Sell] := CheckBoxSell.Checked;
    RuleItems.nRule[RULE_Death] := CheckBoxDeath.Checked;
    RuleItems.nRule[RULE_BOXS] := CheckBoxBoxs.Checked;
    RuleItems.nRule[RULE_Ghost] := CheckBoxGhost.Checked;
    RuleItems.nRule[RULE_PlaySell] := CheckBoxPlaySell.Checked;
    RuleItems.nRule[RULE_Resell] := CheckBoxResell.Checked;
    RuleItems.nRule[RULE_NoDrop] := CheckBoxNoDrop.Checked;
    RuleItems.nRule[RULE_DropHint] := CheckBoxDropHint.Checked;
    RuleItems.nRule[RULE_NoLevel] := CheckBoxNoLevel.Checked;
    RuleItems.nRule[RULE_BUTCHITEM] := CheckBoxButchItem.Checked;
    RuleItems.nRule[RULE_HeroBag] := CheckBoxHeroBag.Checked;
  end;
end;

procedure TFormList2.ButtonAllCloseClick(Sender: TObject);
begin
  ClearRuleBut(False);
end;

procedure TFormList2.ButtonAllAddClick(Sender: TObject);
begin
  ClearRuleBut(True);
end;

procedure TFormList2.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  for I := 0 to ListBoxRuleItems.Items.Count - 1 do
  begin
    Dispose(PTRuleItems(ListBoxRuleItems.Items.Objects[I]));
  end;
  ListBoxRuleItems.Items.Clear;
end;

procedure TFormList2.ListBoxItemClick(Sender: TObject);
begin
  if ListBoxItem.ItemIndex > -1 then
  begin
    ButtonRuleAdd.Enabled := True;
    EditRuleName.Text := ListBoxItem.Items.Strings[ListBoxItem.ItemIndex];
  end;
end;

procedure TFormList2.ListBoxRuleItemsClick(Sender: TObject);
begin
  if ListBoxRuleItems.ItemIndex > -1 then
  begin
    ButtonRuleDel.Enabled := True;
    ButtonRuleEdit.Enabled := True;
    EditRuleName.Text :=
      ListBoxRuleItems.Items.Strings[ListBoxRuleItems.ItemIndex];
    SetRuleBut(True,
      PTRuleItems(ListBoxRuleItems.Items.Objects[ListBoxRuleItems.ItemIndex]));
  end;
end;

procedure TFormList2.ButtonRuleAddClick(Sender: TObject);
var
  RuleItems: PTRuleItems;
begin
  if ListBoxItem.Items.IndexOf(Trim(EditRuleName.Text)) = -1 then
  begin
    Application.MessageBox(PChar('您所增加物品[' + Trim(EditRuleName.Text)
      + ']不存在！'), '确认信息', MB_OK + MB_ICONASTERISK);
    exit;
  end;
  if ListBoxRuleItems.Items.IndexOf(Trim(EditRuleName.Text)) <> -1 then
  begin
    Application.MessageBox(PChar('您所增加物品[' + Trim(EditRuleName.Text)
      + ']已经存在！'), '确认信息', MB_OK + MB_ICONASTERISK);
    exit;
  end;
  New(RuleItems);
  FillChar(RuleItems^, SizeOf(TRuleItems), #0);
  RuleItems.sItemName := Trim(EditRuleName.Text);
  SetRuleBut(False, RuleItems);
  ListBoxRuleItems.Items.AddObject(Trim(EditRuleName.Text), TObject(RuleItems));
  ButtonRuleAdd.Enabled := False;
  ModValue;
end;

procedure TFormList2.ButtonRuleDelClick(Sender: TObject);
begin
  if ListBoxRuleItems.ItemIndex > -1 then
  begin
    Dispose(PTRuleItems(ListBoxRuleItems.Items.Objects[ListBoxRuleItems.ItemIndex]));
    ListBoxRuleItems.Items.Delete(ListBoxRuleItems.ItemIndex);
    ButtonRuleDel.Enabled := False;
    ButtonRuleEdit.Enabled := False;
    ModValue;
  end;
end;

procedure TFormList2.ButtonRuleEditClick(Sender: TObject);
begin
  if ListBoxRuleItems.ItemIndex > -1 then
  begin
    SetRuleBut(False,
      pTRuleItems(ListBoxRuleItems.Items.Objects[ListBoxRuleItems.ItemIndex]));
    ButtonRuleDel.Enabled := False;
    ButtonRuleEdit.Enabled := False;
    ModValue;
  end;
end;

procedure TFormList2.ButtonRuleAllDelClick(Sender: TObject);
var
  Action: TCloseAction;
begin
  FormClose(nil, Action);
  ListBoxRuleItems.Items.Clear;
  ButtonRuleDel.Enabled := False;
  ButtonRuleEdit.Enabled := False;
  ModValue;
end;

procedure TFormList2.ButtonRuleAllAddClick(Sender: TObject);
var
  Action: TCloseAction;
  I: integer;
  RuleItems: PTRuleItems;
begin
  FormClose(nil, Action);
  ListBoxRuleItems.Items.Clear;
  for I := 0 to ListBoxItem.Items.Count - 1 do
  begin
    New(RuleItems);
    FillChar(RuleItems^, SizeOf(TRuleItems), #0);
    RuleItems.sItemName := ListBoxItem.Items.Strings[I];
    SetRuleBut(False, RuleItems);
    ListBoxRuleItems.Items.AddObject(RuleItems.sItemName, TObject(RuleItems));
    ModValue;
  end;
  ButtonRuleAdd.Enabled := False;
end;

procedure TFormList2.ButtonRuleSaveClick(Sender: TObject);
var
  I: integer;
  RuleItems, RuleItemsEx: PTRuleItems;
begin
  for I := 0 to RuleItemList.Count - 1 do
    Dispose(PTRuleItems(RuleItemList.Items[I]));
  RuleItemList.Clear;
  for I := 0 to ListBoxRuleItems.Items.Count - 1 do
  begin
    RuleItems := pTRuleItems(ListBoxRuleItems.Items.Objects[I]);
    New(RuleItemsEx);
    RuleItemsEx^ := RuleItems^;
    RuleItemList.Add(RuleItemsEx);
  end;
  SaveRuleItemList();
  if
    Application.MessageBox('此设置必须重新加载物品数据库才能生效，是否重新加载？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then
  begin
    FrmDB.LoadItemsDB();
  end;
  uModValue;
end;

end.

