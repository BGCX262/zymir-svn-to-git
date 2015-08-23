//CHECK
//��Ҫɾ����һ��ע�ͣ���ע��Ϊ�����ļ��Ƿ��ѱ��Զ������쳣����
unit ViewOnlineHuman;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, mudutil, Spin;

type
  TfrmViewOnlineHuman = class(TForm)
    PanelStatus: TPanel;
    GridHuman: TStringGrid;
    ButtonRefGrid: TButton;
    ComboBoxSort: TComboBox;
    Label1: TLabel;
    Timer: TTimer;
    EditSearchName: TEdit;
    ButtonSearch: TButton;
    ButtonView: TButton;
    CheckBoxShowHero: TCheckBox;
    GroupBox1: TGroupBox;
    ButtonKickLevel: TButton;
    Label2: TLabel;
    EditLowLevel: TSpinEdit;
    EditHighLevel: TSpinEdit;
    Label3: TLabel;
    ButtonKickName: TButton;
    EditName: TEdit;
    CheckBoxIn: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ButtonRefGridClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBoxSortClick(Sender: TObject);
    procedure GridHumanDblClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure ButtonSearchClick(Sender: TObject);
    procedure ButtonViewClick(Sender: TObject);
    procedure ButtonKickNameClick(Sender: TObject);
    procedure ButtonKickLevelClick(Sender: TObject);
  private
    ViewList: TStringList;
    dwTimeOutTick: LongWord;
    procedure RefGridSession();
    procedure GetOnlineList();
    procedure SortOnlineList(nSort: Integer);
    procedure ShowHumanInfo();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmViewOnlineHuman: TfrmViewOnlineHuman;

implementation

uses UsrEngn, M2Share, ObjBase, HUtil32, HumanInfo;

{$R *.dfm}

{ TfrmViewOnlineHuman }

procedure TfrmViewOnlineHuman.Open;
begin
  try
    frmHumanInfo := TfrmHumanInfo.Create(Owner);
    dwTimeOutTick := GetTickCount();
    GetOnlineList();
    RefGridSession();
    Timer.Enabled := True;
    ShowModal;
    Timer.Enabled := False;
    frmHumanInfo.Free;
  except
    MainOutMessage('[Exception] TfrmViewOnlineHuman.Open');
  end;
end;

procedure TfrmViewOnlineHuman.GetOnlineList;
var
  I: Integer;
  sTestOffLine: string;
  PlayObject: TPlayObject;
begin
  try
    ViewList.Clear;
    try
      EnterCriticalSection(ProcessHumanCriticalSection);
      if CheckBoxShowHero.Checked then
      begin
        for I := 0 to UserEngine.m_HeroObjectList.Count - 1 do
        begin
          ViewList.AddObject('������½',
            UserEngine.m_HeroObjectList.Objects[I]);
        end;
      end
      else
      begin
        for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do
        begin
          PlayObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[I]);
          if PlayObject.m_boSafeOffLine then
            sTestOffLine := '�ѻ�����'
          else
            sTestOffLine := '������½';
          ViewList.AddObject(sTestOffLine, PlayObject);
        end;
      end;
    finally
      LeaveCriticalSection(ProcessHumanCriticalSection);
    end;
  except
    MainOutMessage('[Exception] TfrmViewOnlineHuman.GetOnlineList');
  end;
end;

procedure TfrmViewOnlineHuman.RefGridSession;
  function GetJobName(nJob: Byte): string;
  begin
    case nJob of
      0: Result := '��ʿ';
      1: Result := 'ħ��ʦ';
      2: Result := '��ʿ';
    else
      Result := 'δ֪';
    end;
  end;
  function GetManName(nMan: Byte): string;
  begin
    case nMan of
      0: Result := '��';
    else
      Result := 'Ů';
    end;
  end;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    PanelStatus.Caption := 'Refreshing Grid...';
    GridHuman.Visible := False;
    GridHuman.Cells[0, 1] := '';
    GridHuman.Cells[1, 1] := '';
    GridHuman.Cells[2, 1] := '';
    GridHuman.Cells[3, 1] := '';
    GridHuman.Cells[4, 1] := '';
    GridHuman.Cells[5, 1] := '';
    GridHuman.Cells[6, 1] := '';
    GridHuman.Cells[7, 1] := '';
    GridHuman.Cells[8, 1] := '';
    GridHuman.Cells[9, 1] := '';
    GridHuman.Cells[10, 1] := '';
    GridHuman.Cells[11, 1] := '';
    GridHuman.Cells[12, 1] := '';
    GridHuman.Cells[13, 1] := '';
    GridHuman.Cells[14, 1] := '';

    if ViewList.Count <= 0 then
    begin
      GridHuman.RowCount := 2;
      GridHuman.FixedRows := 1;
    end
    else
    begin
      GridHuman.RowCount := ViewList.Count + 1;
    end;
    for I := 0 to ViewList.Count - 1 do
    begin
      PlayObject := TPlayObject(ViewList.Objects[I]);
      GridHuman.Cells[0, I + 1] := IntToStr(I);
      GridHuman.Cells[1, I + 1] := PlayObject.m_sCharName;
      GridHuman.Cells[2, I + 1] := GetManName(PlayObject.m_btGender);
      GridHuman.Cells[3, I + 1] := GetJobName(PlayObject.m_btJob);
      GridHuman.Cells[4, I + 1] := IntToStr(PlayObject.m_Abil.Level);
      GridHuman.Cells[5, I + 1] := PlayObject.m_sMapName;
      GridHuman.Cells[6, I + 1] := IntToStr(PlayObject.m_nCurrX) + ':' +
        IntToStr(PlayObject.m_nCurrY);
      GridHuman.Cells[7, I + 1] := PlayObject.m_sUserID;
      GridHuman.Cells[8, I + 1] := PlayObject.m_sIPaddr;
      GridHuman.Cells[9, I + 1] := IntToStr(PlayObject.m_btPermission);
      GridHuman.Cells[10, I + 1] := PlayObject.m_sIPLocal;
        // GetIPLocal(PlayObject.m_sIPaddr);
      GridHuman.Cells[11, I + 1] := IntToStr(PlayObject.m_nGameGold);
      GridHuman.Cells[12, I + 1] := IntToStr(PlayObject.m_nGamePoint);
      GridHuman.Cells[13, I + 1] := IntToStr(PlayObject.m_nPayMentPoint);
      GridHuman.Cells[14, I + 1] := ViewList.Strings[i];
    end;
    GridHuman.Visible := True;
  except
    MainOutMessage('[Exception] TfrmViewOnlineHuman.RefGridSession');
  end;
end;

procedure TfrmViewOnlineHuman.FormCreate(Sender: TObject);
begin
  try
    ViewList := TStringList.Create;
    GridHuman.Cells[0, 0] := '���';
    GridHuman.Cells[1, 0] := '��������';
    GridHuman.Cells[2, 0] := '�Ա�';
    GridHuman.Cells[3, 0] := 'ְҵ';
    GridHuman.Cells[4, 0] := '�ȼ�';
    GridHuman.Cells[5, 0] := '��ͼ';
    GridHuman.Cells[6, 0] := '����';
    GridHuman.Cells[7, 0] := '��¼�˺�';
    GridHuman.Cells[8, 0] := '��¼IP';
    GridHuman.Cells[9, 0] := 'Ȩ��';
    GridHuman.Cells[10, 0] := '���ڵ���';
    GridHuman.Cells[11, 0] := g_Config.sGameGoldName;
    GridHuman.Cells[12, 0] := g_Config.sGamePointName;
    GridHuman.Cells[13, 0] := g_Config.sPayMentPointName;
    GridHuman.Cells[14, 0] := '����״̬';
  except
    MainOutMessage('[Exception] TfrmViewOnlineHuman.FormCreate');
  end;
end;

procedure TfrmViewOnlineHuman.ButtonRefGridClick(Sender: TObject);
begin
  try
    dwTimeOutTick := GetTickCount();
    GetOnlineList();
    RefGridSession();
  except
    MainOutMessage('[Exception] TfrmViewOnlineHuman.ButtonRefGridClick');
  end;
end;

procedure TfrmViewOnlineHuman.FormDestroy(Sender: TObject);
begin
  try
    ViewList.Free;
  except
    MainOutMessage('[Exception] TfrmViewOnlineHuman.FormDestroy');
  end;
end;

procedure TfrmViewOnlineHuman.ComboBoxSortClick(Sender: TObject);
begin
  try
    if ComboBoxSort.ItemIndex < 0 then
      exit;
    dwTimeOutTick := GetTickCount();
    GetOnlineList();
    SortOnLineList(ComboBoxSort.ItemIndex);
    RefGridSession();
  except
    MainOutMessage('[Exception] TfrmViewOnlineHuman.ComboBoxSortClick');
  end;
end;

procedure TfrmViewOnlineHuman.SortOnlineList(nSort: Integer);
var
  I: Integer;
  SortList: TStringList;
begin
  try
    SortList := TStringList.Create;
    case nSort of
      0:
        begin
          ViewList.Sort;
          exit;
        end;
      1:
        begin
          for I := 0 to ViewList.Count - 1 do
          begin
            SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_btGender), ViewList.Objects[I]);
          end;
        end;
      2:
        begin
          for I := 0 to ViewList.Count - 1 do
          begin
            SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_btJob), ViewList.Objects[I]);
          end;
        end;
      3:
        begin
          for I := 0 to ViewList.Count - 1 do
          begin
            SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_Abil.Level), ViewList.Objects[I]);
          end;
        end;
      4:
        begin
          for I := 0 to ViewList.Count - 1 do
          begin
            SortList.AddObject(TPlayObject(ViewList.Objects[I]).m_sMapName,
              ViewList.Objects[I]);
          end;
        end;
      5:
        begin
          for I := 0 to ViewList.Count - 1 do
          begin
            SortList.AddObject(TPlayObject(ViewList.Objects[I]).m_sIPaddr,
              ViewList.Objects[I]);
          end;
        end;
      6:
        begin
          for I := 0 to ViewList.Count - 1 do
          begin
            SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_btPermission), ViewList.Objects[I]);
          end;
        end;
      7:
        begin
          for I := 0 to ViewList.Count - 1 do
          begin
            SortList.AddObject(TPlayObject(ViewList.Objects[I]).m_sIPLocal,
              ViewList.Objects[I]);
          end;
        end;
    end;
    ViewList.Free;
    ViewList := SortList;
    ViewList.Sort;
  except
    MainOutMessage('[Exception] TfrmViewOnlineHuman.SortOnlineList');
  end;
end;

procedure TfrmViewOnlineHuman.GridHumanDblClick(Sender: TObject);
begin
  try
    ShowHumanInfo();
  except
    MainOutMessage('[Exception] TfrmViewOnlineHuman.GridHumanDblClick');
  end;
end;

procedure TfrmViewOnlineHuman.TimerTimer(Sender: TObject);
begin
  try
    if (GetTickCount - dwTimeOutTick > 30000) and (ViewList.Count > 0) then
    begin
      ViewList.Clear;
      RefGridSession();
    end;
  except
    MainOutMessage('[Exception] TfrmViewOnlineHuman.TimerTimer');
  end;
end;

procedure TfrmViewOnlineHuman.ButtonSearchClick(Sender: TObject);
var
  I: Integer;
  sHumanName: string;
  PlayObject: TPlayObject;
begin
  try
    sHumanName := Trim(EditSearchName.Text);
    if sHumanName = '' then
    begin
      Application.MessageBox('������һ����������!', '������Ϣ',
        MB_OK + MB_ICONEXCLAMATION);
      exit;
    end;
    for I := 0 to ViewList.Count - 1 do
    begin
      PlayObject := TPlayObject(ViewList.Objects[I]);
      if CompareText(PlayObject.m_sCharName, sHumanName) = 0 then
      begin
        GridHuman.Row := I + 1;
        exit;
      end;
    end;
    Application.MessageBox('����û������..', '��ʾ��Ϣ', MB_OK +
      MB_ICONINFORMATION);
  except
    MainOutMessage('[Exception] TfrmViewOnlineHuman.ButtonSearchClick');
  end;
end;

procedure TfrmViewOnlineHuman.ButtonViewClick(Sender: TObject);
begin
  try
    ShowHumanInfo();
  except
    MainOutMessage('[Exception] TfrmViewOnlineHuman.ButtonViewClick');
  end;
end;

procedure TfrmViewOnlineHuman.ShowHumanInfo;
var
  nSelIndex: Integer;
  sPlayObjectName: string;
  PlayObject: TPlayObject;
begin
  try
    nSelIndex := GridHuman.Row;
    Dec(nSelIndex);
    if (nSelIndex < 0) or (ViewList.Count <= nSelIndex) then
    begin
      Application.MessageBox('����ѡ��һ��Ҫ�鿴���������',
        '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
      exit;
    end;
    sPlayObjectName := GridHuman.Cells[1, nSelIndex + 1];
    PlayObject := UserEngine.GetPlayObject(sPlayObjectName,
      CheckBoxShowHero.Checked);
    if PlayObject = nil then
    begin
      Application.MessageBox('�������Ѿ������ߣ�����',
        '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
      exit;
    end;

    frmHumanInfo.PlayObject := TPlayObject(ViewList.Objects[nSelIndex]);
    frmHumanInfo.Top := Self.Top + 20;
    frmHumanInfo.Left := Self.Left;
    frmHumanInfo.Open();
  except
    MainOutMessage('[Exception] TfrmViewOnlineHuman.ShowHumanInfo');
  end;
end;

procedure TfrmViewOnlineHuman.ButtonKickNameClick(Sender: TObject);
var
  Count: Integer;
begin
  if Trim(EditName.Text) <> '' then
  begin
    Count := UserEngine.KickOnlineName(Trim(EditName.Text), CheckBoxIn.Checked);
    Application.MessageBox(PChar(Format('���߳� %d �������������',
      [Count])), '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
  end
  else
    Application.MessageBox('�������Ʋ�������Ϊ�գ�����',
      '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmViewOnlineHuman.ButtonKickLevelClick(Sender: TObject);
var
  Count: Integer;
begin
  if EditHighLevel.Value >= EditLowLevel.Value then
  begin
    Count := UserEngine.KickOnlineLevel(EditLowLevel.Value, EditHighLevel.Value,
      True);
    Application.MessageBox(PChar(Format('���߳� %d �������������',
      [Count])), '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
    ButtonRefGridClick(nil);
  end
  else
    Application.MessageBox('�߳�����ȼ����ô��󣡣���',
      '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
end;

end.

