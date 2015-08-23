//CHECK
//��Ҫɾ����һ��ע�ͣ���ע��Ϊ�����ļ��Ƿ��ѱ��Զ������쳣����
unit ConfigMerchant;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,ObjNpc;

type
  TfrmConfigMerchant = class(TForm)
    ListBoxMerChant: TListBox;
    Label1: TLabel;
    GroupBoxNPC: TGroupBox;
    Label2: TLabel;
    EditScriptName: TEdit;
    Label3: TLabel;
    EditMapName: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EditShowName: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    CheckBoxOfCastle: TCheckBox;
    ComboBoxDir: TComboBox;
    EditImageIdx: TSpinEdit;
    EditX: TSpinEdit;
    EditY: TSpinEdit;
    GroupBoxScript: TGroupBox;
    MemoScript: TMemo;
    ButtonScriptSave: TButton;
    GroupBox3: TGroupBox;
    CheckBoxBuy: TCheckBox;
    CheckBoxSell: TCheckBox;
    CheckBoxStorage: TCheckBox;
    CheckBoxGetback: TCheckBox;
    CheckBoxMakedrug: TCheckBox;
    CheckBoxUpgradenow: TCheckBox;
    CheckBoxGetbackupgnow: TCheckBox;
    CheckBoxRepair: TCheckBox;
    CheckBoxS_repair: TCheckBox;
    ButtonReLoadNpc: TButton;
    ButtonSave: TButton;
    CheckBoxDenyRefStatus: TCheckBox;
    Label9: TLabel;
    EditPriceRate: TSpinEdit;
    Label10: TLabel;
    EditMapDesc: TEdit;
    CheckBoxSendMsg: TCheckBox;
    CheckBoxAutoMove: TCheckBox;
    Label11: TLabel;
    EditMoveTime: TSpinEdit;
    ButtonClearTempData: TButton;
    ButtonViewData: TButton;
    CheckBoxCallHero: TCheckBox;
    CheckBoxSellOff: TCheckBox;
    procedure ListBoxMerChantClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure CheckBoxDenyRefStatusClick(Sender: TObject);
    procedure EditXChange(Sender: TObject);
    procedure EditYChange(Sender: TObject);
    procedure EditShowNameChange(Sender: TObject);
    procedure EditImageIdxChange(Sender: TObject);
    procedure CheckBoxOfCastleClick(Sender: TObject);
    procedure CheckBoxBuyClick(Sender: TObject);
    procedure CheckBoxSellClick(Sender: TObject);
    procedure CheckBoxGetbackClick(Sender: TObject);
    procedure CheckBoxStorageClick(Sender: TObject);
    procedure CheckBoxUpgradenowClick(Sender: TObject);
    procedure CheckBoxGetbackupgnowClick(Sender: TObject);
    procedure CheckBoxRepairClick(Sender: TObject);
    procedure CheckBoxS_repairClick(Sender: TObject);
    procedure CheckBoxMakedrugClick(Sender: TObject);
    procedure EditPriceRateChange(Sender: TObject);
    procedure ButtonScriptSaveClick(Sender: TObject);
    procedure ButtonReLoadNpcClick(Sender: TObject);
    procedure EditScriptNameChange(Sender: TObject);
    procedure EditMapNameChange(Sender: TObject);
    procedure ComboBoxDirChange(Sender: TObject);
    procedure MemoScriptChange(Sender: TObject);
    procedure CheckBoxSendMsgClick(Sender: TObject);
    procedure CheckBoxAutoMoveClick(Sender: TObject);
    procedure EditMoveTimeChange(Sender: TObject);
    procedure ButtonClearTempDataClick(Sender: TObject);
    procedure CheckBoxCallHeroClick(Sender: TObject);
    procedure CheckBoxSellOffClick(Sender: TObject);
  private
    SelMerchant:TMerchant;
    boOpened:Boolean;
//    boModValued:Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure RefListBoxMerChant();
    procedure ClearMerchantData();
    procedure LoadScriptFile();
    procedure ChangeScriptAllowAction();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmConfigMerchant: TfrmConfigMerchant;

implementation

uses UsrEngn, M2Share;

{$R *.dfm}

{ TfrmConfigMerchant }
procedure TfrmConfigMerchant.ModValue;
begin
Try 
  ButtonSave.Enabled:=True;
  ButtonScriptSave.Enabled:=True;
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.ModValue'); 
End; 
end;

procedure TfrmConfigMerchant.uModValue;
begin
Try 
  ButtonSave.Enabled:=False;
  ButtonScriptSave.Enabled:=False;
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.uModValue'); 
End; 
end;

procedure TfrmConfigMerchant.Open;
begin
Try 
  boOpened:=False;
  uModValue();
  CheckBoxDenyRefStatus.Checked:=False;
  SelMerchant:=nil;
  RefListBoxMerChant;

  boOpened:=True;
  ShowModal;
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.Open'); 
End; 
end;

procedure TfrmConfigMerchant.ButtonClearTempDataClick(Sender: TObject);
begin
Try 
  if Application.MessageBox(PChar('�Ƿ�ȷ�����NPC��ʱ���ݣ�'),'ȷ����Ϣ',MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    ClearMerchantData();
  end;
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.ButtonClearTempDataClick'); 
End; 
end;

procedure TfrmConfigMerchant.ButtonSaveClick(Sender: TObject);
var
  I:Integer;
  SaveList:TStringList;
  Merchant:TMerchant;
  sMerchantFile:String;
  sIsCastle:String;
  sCanMove:String;
begin
Try 
  sMerchantFile:=g_Config.sEnvirDir + 'Merchant.txt';
  SaveList:=TStringList.Create;
  UserEngine.m_MerchantList.Lock;
  try
    for I := 0 to UserEngine.m_MerchantList.Count - 1 do begin
      Merchant:=TMerchant(UserEngine.m_MerchantList.Items[I]);
      if Merchant.m_sMapName = '0' then Continue;
        
      if Merchant.m_boCastle then sIsCastle:='1'
      else sIsCastle:='0';
      if Merchant.m_boCanMove then sCanMove:='1'
      else sCanMove:='0';
        
      SaveList.Add(Merchant.m_sScript + #9 +
                   Merchant.m_sMapName + #9 +
                   IntToStr(Merchant.m_nCurrX) + #9 +
                   IntToStr(Merchant.m_nCurrY) + #9 +
                   Merchant.m_sCharName + #9 +
                   IntToStr(Merchant.m_nFlag) + #9 +
                   IntToStr(Merchant.m_wAppr) + #9 +
                   sIsCastle + #9 +
                   sCanMove + #9 +
                   IntToStr(Merchant.m_dwMoveTime)
                   )
    end;
    SaveList.SaveToFile(sMerchantFile);
  finally
    UserEngine.m_MerchantList.UnLock;
  end;
  SaveList.Free;
  uModValue();  
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.ButtonSaveClick'); 
End; 
end;

procedure TfrmConfigMerchant.ClearMerchantData;
var
  I: Integer;
  Merchant:TMerchant;
begin
Try 
  UserEngine.m_MerchantList.Lock;
  try
    for I := 0 to UserEngine.m_MerchantList.Count - 1 do begin
      Merchant:=TMerchant(UserEngine.m_MerchantList.Items[I]);
      Merchant.ClearData();
    end;
  finally
    UserEngine.m_MerchantList.UnLock;
  end;
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.ClearMerchantData'); 
End; 
end;

procedure TfrmConfigMerchant.RefListBoxMerChant;
var
  I: Integer;
  Merchant:TMerchant;
begin
Try 
  UserEngine.m_MerchantList.Lock;
  try
    for I := 0 to UserEngine.m_MerchantList.Count - 1 do begin
      Merchant:=TMerchant(UserEngine.m_MerchantList.Items[I]);
      if (Merchant.m_sMapName = '0') and (Merchant.m_nCurrX = 0) and (Merchant.m_nCurrY = 0) then Continue;
      ListBoxMerChant.Items.AddObject(Merchant.m_sCharName + ' - ' + Merchant.m_sMapName + ' (' + IntToStr(Merchant.m_nCurrX) + ':' + IntToStr(Merchant.m_nCurrY) + ')',Merchant );
    end;
  finally
    UserEngine.m_MerchantList.UnLock;
  end;

Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.RefListBoxMerChant'); 
End; 
end;

procedure TfrmConfigMerchant.ListBoxMerChantClick(Sender: TObject);
var
  nSelIndex:Integer;
begin
Try 
  CheckBoxDenyRefStatus.Checked:=False;
  uModValue();
  boOpened:=False;
  nSelIndex:=ListBoxMerChant.ItemIndex;
  if nSelIndex < 0 then exit;
  SelMerchant:=TMerchant(ListBoxMerChant.Items.Objects[nSelIndex]);
  EditScriptName.Text:=SelMerchant.m_sScript;
  EditMapName.Text:=SelMerchant.m_sMapName;
  EditMapDesc.Text:=SelMerchant.m_PEnvir.sMapDesc;
  EditX.Value:=SelMerchant.m_nCurrX;
  EditY.Value:=SelMerchant.m_nCurrY;
  EditShowName.Text:=SelMerchant.m_sCharName;
  ComboBoxDir.ItemIndex:=SelMerchant.m_nFlag;
  EditImageIdx.Value:=SelMerchant.m_wAppr;
  CheckBoxOfCastle.Checked:=SelMerchant.m_boCastle;
  CheckBoxAutoMove.Checked:=SelMerchant.m_boCanMove;
  EditMoveTime.Value:=SelMerchant.m_dwMoveTime;
  
  CheckBoxBuy.Checked:=SelMerchant.m_boBuy;
  CheckBoxSell.Checked:=SelMerchant.m_boSell;
  CheckBoxSellOff.Checked:=SelMerchant.m_boSellOff;
  CheckBoxGetback.Checked:=SelMerchant.m_boGetback;
  CheckBoxStorage.Checked:=SelMerchant.m_boStorage;
  CheckBoxUpgradenow.Checked:=SelMerchant.m_boUpgradenow;
  CheckBoxGetbackupgnow.Checked:=SelMerchant.m_boGetBackupgnow;
  CheckBoxRepair.Checked:=SelMerchant.m_boRepair;
  CheckBoxS_repair.Checked:=SelMerchant.m_boS_repair;
  CheckBoxMakedrug.Checked:=SelMerchant.m_boMakeDrug;
  CheckBoxSendMsg.Checked:=SelMerchant.m_boSendmsg;
  CheckBoxCallHero.Checked:=SelMerchant.m_boHero;

  EditPriceRate.Value:=SelMerchant.m_nPriceRate;
  MemoScript.Clear;
  ButtonReLoadNpc.Enabled:=False;
  LoadScriptFile();

  GroupBoxNPC.Enabled:=True;
  GroupBoxScript.Enabled:=True;

  boOpened:=True;
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.ListBoxMerChantClick'); 
End; 
end;

procedure TfrmConfigMerchant.FormCreate(Sender: TObject);
begin
Try 
  ComboBoxDir.Items.Add('0');
  ComboBoxDir.Items.Add('1');
  ComboBoxDir.Items.Add('2');
  ComboBoxDir.Items.Add('3');
  ComboBoxDir.Items.Add('4');
  ComboBoxDir.Items.Add('5');
  ComboBoxDir.Items.Add('6');
  ComboBoxDir.Items.Add('7');
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.FormCreate'); 
End; 
end;


procedure TfrmConfigMerchant.CheckBoxDenyRefStatusClick(Sender: TObject);
begin
Try 
  if SelMerchant <> nil then begin
    SelMerchant.m_boDenyRefStatus:=CheckBoxDenyRefStatus.Checked;
  end;
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.CheckBoxDenyRefStatusClick'); 
End; 
end;

procedure TfrmConfigMerchant.EditXChange(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_nCurrX:=EditX.Value;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.EditXChange'); 
End; 
end;

procedure TfrmConfigMerchant.EditYChange(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_nCurrY:=EditY.Value;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.EditYChange'); 
End; 
end;

procedure TfrmConfigMerchant.EditShowNameChange(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_sCharName:=Trim(EditShowName.Text);
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.EditShowNameChange'); 
End; 
end;

procedure TfrmConfigMerchant.EditImageIdxChange(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_wAppr:=EditImageIdx.Value;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.EditImageIdxChange'); 
End; 
end;

procedure TfrmConfigMerchant.EditScriptNameChange(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_sScript:=Trim(EditScriptName.Text);
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.EditScriptNameChange'); 
End; 
end;

procedure TfrmConfigMerchant.EditMapNameChange(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_sMapName:=Trim(EditMapName.Text);
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.EditMapNameChange'); 
End; 
end;

procedure TfrmConfigMerchant.ComboBoxDirChange(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_nFlag:=ComboBoxDir.ItemIndex;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.ComboBoxDirChange'); 
End; 
end;

procedure TfrmConfigMerchant.CheckBoxOfCastleClick(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_boCastle:=CheckBoxOfCastle.Checked;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.CheckBoxOfCastleClick'); 
End; 
end;


procedure TfrmConfigMerchant.CheckBoxAutoMoveClick(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_boCanMove:=CheckBoxAutoMove.Checked;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.CheckBoxAutoMoveClick'); 
End; 
end;


procedure TfrmConfigMerchant.EditMoveTimeChange(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_dwMoveTime:=EditMoveTime.Value;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.EditMoveTimeChange'); 
End; 
end;

procedure TfrmConfigMerchant.LoadScriptFile;
var
  I: Integer;
  sScriptFile:String;
  LoadList:TStringList;
  LineText:String;
  boNoHeader:Boolean;
begin
Try 
  if SelMerchant = nil then exit;
  sScriptFile:=g_Config.sEnvirDir + 'Market_Def\' + SelMerchant.m_sScript + '-' + SelMerchant.m_sMapName + '.txt';
  MemoScript.Visible:=False;
  LineText:='(';
  if SelMerchant.m_boBuy then LineText:=LineText + sBUY + ' ';
  if SelMerchant.m_boSell then LineText:=LineText + sSELL + ' ';
  if SelMerchant.m_boMakeDrug then LineText:=LineText + sMAKEDURG + ' ';
  if SelMerchant.m_boStorage then LineText:=LineText + sSTORAGE + ' ';
  if SelMerchant.m_boGetback then LineText:=LineText + sGETBACK + ' ';
  if SelMerchant.m_boUpgradenow then LineText:=LineText + sUPGRADENOW + ' ';
  if SelMerchant.m_boGetBackupgnow then LineText:=LineText + sGETBACKUPGNOW + ' ';
  if SelMerchant.m_boRepair then LineText:=LineText + sREPAIR + ' ';
  if SelMerchant.m_boS_repair then LineText:=LineText + sSUPERREPAIR + ' ';
  if SelMerchant.m_boSendmsg then LineText:=LineText + sSL_SENDMSG + ' ';
  if SelMerchant.m_boHero then LineText:=LineText + sSL_BUHERO + ' ';
  if SelMerchant.m_boSellOff then LineText:=LineText + sSELLOFF + ' ';
  LineText:=LineText + ')';
  MemoScript.Lines.Add(LineText);
  LineText:='%' + IntToStr(SelMerchant.m_nPriceRate);
  MemoScript.Lines.Add(LineText);
  for I := 0 to SelMerchant.m_ItemTypeList.Count - 1 do begin
    LineText:='+' + IntToStr(Integer(SelMerchant.m_ItemTypeList.Items[I]));
    MemoScript.Lines.Add(LineText);
  end;
  if FileExists(sScriptFile) then begin
    LoadList:=TStringList.Create;
    LoadList.LoadFromFile(sScriptFile);
    boNoHeader:=False;
    for I := 0 to LoadList.Count - 1 do begin
      LineText:=LoadList.Strings[I];
      if (LineText = '') or (LineText[1] = ';') then Continue;

      if (LineText[1] = '[') or (LineText[1] = '#') then boNoHeader:=True;
      if boNoHeader then begin
        MemoScript.Lines.Add(LineText);
      end;

    end;
    LoadList.Free;
  end;
  MemoScript.Visible:=True;
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.LoadScriptFile'); 
End; 
end;

procedure TfrmConfigMerchant.ChangeScriptAllowAction;
var
  LineText:String;
begin
Try 
  if (SelMerchant = nil) or (MemoScript.Lines.Count <=0 ) then exit;
  LineText:='(';
  if SelMerchant.m_boBuy then LineText:=LineText + sBUY + ' ';
  if SelMerchant.m_boSell then LineText:=LineText + sSELL + ' ';
  if SelMerchant.m_boMakeDrug then LineText:=LineText + sMAKEDURG + ' ';
  if SelMerchant.m_boStorage then LineText:=LineText + sSTORAGE + ' ';
  if SelMerchant.m_boGetback then LineText:=LineText + sGETBACK + ' ';
  if SelMerchant.m_boUpgradenow then LineText:=LineText + sUPGRADENOW + ' ';
  if SelMerchant.m_boGetBackupgnow then LineText:=LineText + sGETBACKUPGNOW + ' ';
  if SelMerchant.m_boRepair then LineText:=LineText + sREPAIR + ' ';
  if SelMerchant.m_boS_repair then LineText:=LineText + sSUPERREPAIR + ' ';
  if SelMerchant.m_boSendmsg then LineText:=LineText + sSL_SENDMSG + ' ';
  if SelMerchant.m_boHero then LineText:=LineText + sSL_BUHERO + ' ';
  if SelMerchant.m_boSellOff then LineText:=LineText + sSELLOFF + ' ';
  LineText:=LineText + ')';
  MemoScript.Lines[0]:=LineText;
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.ChangeScriptAllowAction'); 
End; 
end;

procedure TfrmConfigMerchant.CheckBoxBuyClick(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_boBuy:=CheckBoxBuy.Checked;
  ModValue();
  ChangeScriptAllowAction();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.CheckBoxBuyClick'); 
End; 
end;

procedure TfrmConfigMerchant.CheckBoxSellClick(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_boSell:=CheckBoxSell.Checked;
  ModValue();
  ChangeScriptAllowAction();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.CheckBoxSellClick'); 
End; 
end;

procedure TfrmConfigMerchant.CheckBoxGetbackClick(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_boGetback:=CheckBoxGetback.Checked;
  ModValue();
  ChangeScriptAllowAction();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.CheckBoxGetbackClick'); 
End; 
end;

procedure TfrmConfigMerchant.CheckBoxStorageClick(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_boStorage:=CheckBoxStorage.Checked;
  ModValue();
  ChangeScriptAllowAction();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.CheckBoxStorageClick'); 
End; 
end;

procedure TfrmConfigMerchant.CheckBoxUpgradenowClick(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_boUpgradenow:=CheckBoxUpgradenow.Checked;
  ModValue();
  ChangeScriptAllowAction();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.CheckBoxUpgradenowClick'); 
End; 
end;

procedure TfrmConfigMerchant.CheckBoxGetbackupgnowClick(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_boGetBackupgnow:=CheckBoxGetbackupgnow.Checked;
  ModValue();
  ChangeScriptAllowAction();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.CheckBoxGetbackupgnowClick'); 
End; 
end;

procedure TfrmConfigMerchant.CheckBoxRepairClick(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_boRepair:=CheckBoxRepair.Checked;
  ModValue();
  ChangeScriptAllowAction();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.CheckBoxRepairClick'); 
End; 
end;

procedure TfrmConfigMerchant.CheckBoxS_repairClick(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_boS_repair:=CheckBoxS_repair.Checked;
  ModValue();
  ChangeScriptAllowAction();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.CheckBoxS_repairClick'); 
End; 
end;

procedure TfrmConfigMerchant.CheckBoxMakedrugClick(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_boMakeDrug:=CheckBoxMakedrug.Checked;
  ModValue();
  ChangeScriptAllowAction();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.CheckBoxMakedrugClick'); 
End; 
end;

procedure TfrmConfigMerchant.CheckBoxSendMsgClick(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_boSendmsg:=CheckBoxSendMsg.Checked;
  ModValue();
  ChangeScriptAllowAction();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.CheckBoxSendMsgClick'); 
End; 
end;

procedure TfrmConfigMerchant.EditPriceRateChange(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
    
  SelMerchant.m_nPriceRate:=EditPriceRate.Value;
  MemoScript.Lines[1]:='%' + IntToStr(SelMerchant.m_nPriceRate);
  ModValue();

Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.EditPriceRateChange'); 
End; 
end;

procedure TfrmConfigMerchant.ButtonScriptSaveClick(Sender: TObject);
var
  sScriptFile:String;
begin
Try 
  sScriptFile:=g_Config.sEnvirDir + 'Market_Def\' + SelMerchant.m_sScript + '-' + SelMerchant.m_sMapName + '.txt';
  MemoScript.Lines.SaveToFile(sScriptFile);
  uModValue();
  ButtonReLoadNpc.Enabled:=True;
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.ButtonScriptSaveClick'); 
End; 
end;

procedure TfrmConfigMerchant.ButtonReLoadNpcClick(Sender: TObject);
begin
Try 
  if (SelMerchant =nil) then exit;
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    SelMerchant.ClearScript;
    SelMerchant.LoadNPCScript;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
  ButtonReLoadNpc.Enabled:=False;
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.ButtonReLoadNpcClick'); 
End; 
end;



procedure TfrmConfigMerchant.MemoScriptChange(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  ModValue();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.MemoScriptChange'); 
End; 
end;





procedure TfrmConfigMerchant.CheckBoxCallHeroClick(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_boHero:=CheckBoxCallHero.Checked;
  ModValue();
  ChangeScriptAllowAction();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.CheckBoxCallHeroClick'); 
End; 
end;

procedure TfrmConfigMerchant.CheckBoxSellOffClick(Sender: TObject);
begin
Try 
  if not boOpened or (SelMerchant =nil) then exit;
  SelMerchant.m_boSellOff:=CheckBoxSellOff.Checked;
  ModValue();
  ChangeScriptAllowAction();
Except 
  MainOutMessage('[Exception] TfrmConfigMerchant.CheckBoxSellOffClick'); 
End; 
end;

end.