//CHECK
//��Ҫɾ����һ��ע�ͣ���ע��Ϊ�����ļ��Ƿ��ѱ��Զ������쳣����
unit IntroScn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, StdCtrls, Controls, Forms, Dialogs,
  extctrls, DXDraws, DXClass, FState, Grobal2, cliUtil, clFunc, SoundUtil,
  DXSounds, HUtil32;


const
   SELECTEDFRAME = 16;
   FREEZEFRAME = 13;
   EFFECTFRAME = 14;

type
   TLoginState = (lsLogin, lsNewid, lsNewidRetry, lsChgpw, lsCloseAll);
   TSceneType = (stIntro, stLogin, stSelectCountry, stSelectChr, stNewChr, stLoading,
                   stLoginNotice, stPlayGame);
   TSelChar = record
      Valid: Boolean;
      UserChr: TUserCharacterInfo;
      Selected: Boolean;
      FreezeState: Boolean; //TRUE:�������� FALSE:��������
      Unfreezing: Boolean; //��� �ִ� �����ΰ�?
      Freezing: Boolean;  //��� �ִ� ����?
      AniIndex: integer;  //���(���) �ִϸ��̼�
      DarkLevel: integer;
      EffIndex: integer;  //ȿ�� �ִϸ��̼�
      StartTime: longword;
      moretime: longword;
      startefftime: longword;
   end;

   TScene = class
   private
   public
      SceneType: TSceneType;
      constructor Create (scenetype: TSceneType);
      procedure Initialize; dynamic;
      procedure Finalize; dynamic;
      procedure OpenScene; dynamic;
      procedure CloseScene; dynamic;
      procedure OpeningScene; dynamic;
      procedure KeyPress (var Key: Char); dynamic;
      procedure KeyDown (var Key: Word; Shift: TShiftState); dynamic;
      procedure MouseMove (Shift: TShiftState; X, Y: Integer); dynamic;
      procedure MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); dynamic;
      procedure PlayScene (MSurface: TDirectDrawSurface); dynamic;
   end;

   TIntroScene = class (TScene)
   private
   public
      constructor Create;
      destructor Destroy; override;
      procedure OpenScene; override;
      procedure CloseScene; override;
      procedure PlayScene (MSurface: TDirectDrawSurface); override;
   end;

   TLoginScene = class (TScene)
     m_EdId           :TEdit;
   private
     m_EdPasswd       :TEdit;
     m_EdNewId        :TEdit;
     m_EdNewPasswd    :TEdit;
     m_EdConfirm      :TEdit;
     m_EdYourName     :TEdit;
     m_EdSSNo         :TEdit;
     m_EdBirthDay     :TEdit;
     m_EdQuiz1        :TEdit;
     m_EdAnswer1      :TEdit;
     m_EdQuiz2        :TEdit;
     m_EdAnswer2      :TEdit;
     m_EdPhone        :TEdit;
     m_EdMobPhone     :TEdit;
     m_EdEMail        :TEdit;
     m_EdChgId        :TEdit;
     m_EdChgCurrentpw :TEdit;
     m_EdChgNewPw     :TEdit;
     m_EdChgRepeat    :TEdit;
     m_nCurFrame      :Integer;
     m_nMaxFrame      :Integer;
     m_dwStartTime    :LongWord;  //�� �����Ӵ� �ð�
     m_boNowOpening   :Boolean;
     m_boOpenFirst    :Boolean;
     m_NewIdRetryUE   :TUserEntry;
     m_NewIdRetryAdd  :TUserEntryAdd;
     procedure EdLoginIdKeyPress (Sender: TObject; var Key: Char);
     procedure EdLoginPasswdKeyPress (Sender: TObject; var Key: Char);
     procedure EdNewIdKeyPress (Sender: TObject; var Key: Char);
     procedure EdNewOnEnter (Sender: TObject);
     function  CheckUserEntrys: Boolean;
     function  NewIdCheckNewId: Boolean;
     function  NewIdCheckSSno: Boolean;
     function  NewIdCheckBirthDay: Boolean;
   public
     m_sLoginId            :String;
     m_sLoginPasswd        :String;
     m_boUpdateAccountMode :Boolean;
     constructor Create;
      destructor Destroy; override;
      procedure OpenScene; override;
      procedure CloseScene; override;
      procedure PlayScene (MSurface: TDirectDrawSurface); override;
      procedure ChangeLoginState (state: TLoginState);
      procedure NewClick;
      procedure NewIdRetry (boupdate: Boolean);
      procedure UpdateAccountInfos (ue: TUserEntry);
      procedure OkClick;
      procedure ChgPwClick;
      procedure NewAccountOk;
      procedure NewAccountClose;
      procedure ChgpwOk;
      procedure ChgpwCancel;
      procedure HideLoginBox;
      procedure OpenLoginDoor;
      procedure PassWdFail;
   end;

   TSelectChrScene = class (TScene)
   private
      SoundTimer: TTimer;
      CreateChrMode: Boolean;
      EdChrName: TEdit;
      procedure SoundOnTimer (Sender: TObject);
      procedure MakeNewChar (index: integer);
      procedure EdChrnameKeyPress (Sender: TObject; var Key: Char);
   public
      NewIndex: integer;
      ChrArr: array[0..1] of TSelChar;
      RenewChr: array[0..13] of TUserCharacterInfo;
      constructor Create;
      destructor Destroy; override;
      procedure OpenScene; override;
      procedure CloseScene; override;
      procedure PlayScene (MSurface: TDirectDrawSurface); override;
      procedure SelChrSelect1Click;
      procedure SelChrSelect2Click;
      procedure SelChrStartClick;
      procedure SelChrNewChrClick;
      procedure SelChrEraseChrClick;
      procedure SelChrCreditsClick;
      procedure SelChrExitClick;
      procedure SelChrNewClose;
      procedure SelChrNewJob (job: integer);
      procedure SelChrNewm_btSex (sex: integer);
      procedure SelChrNewPrevHair;
      procedure SelChrNewNextHair;
      procedure SelChrNewOk;
      procedure SelRenewChr;
      procedure ClearChrs;
      procedure AddChr (uname: string; job, hair, level, sex: integer);
      procedure SelectChr (index: integer);
   end;

   TLoginNotice = class (TScene)
   private
   public
      constructor Create;
      destructor Destroy; override;
   end;


implementation

uses
   ClMain, MShare, Share;


constructor TScene.Create (scenetype: TSceneType);
begin
Try //�����Զ�����
   SceneType := scenetype;
Except //�����Զ�����
  DebugOutStr('[Exception] TScene.Create'); //�����Զ�����
End; //�����Զ�����
end;

procedure TScene.Initialize;
begin
Try //�����Զ�����
Except //�����Զ�����
  DebugOutStr('[Exception] TScene.Initialize'); //�����Զ�����
End; //�����Զ�����
end;

procedure TScene.Finalize;
begin
Try //�����Զ�����
Except //�����Զ�����
  DebugOutStr('[Exception] TScene.Finalize'); //�����Զ�����
End; //�����Զ�����
end;

procedure TScene.OpenScene;
begin
Try //�����Զ�����
   ;
Except //�����Զ�����
  DebugOutStr('[Exception] TScene.OpenScene'); //�����Զ�����
End; //�����Զ�����
end;

procedure TScene.CloseScene;
begin
Try //�����Զ�����
   ;
Except //�����Զ�����
  DebugOutStr('[Exception] TScene.CloseScene'); //�����Զ�����
End; //�����Զ�����
end;

procedure TScene.OpeningScene;
begin
Try //�����Զ�����
Except //�����Զ�����
  DebugOutStr('[Exception] TScene.OpeningScene'); //�����Զ�����
End; //�����Զ�����
end;

procedure TScene.KeyPress (var Key: Char);
begin
Try //�����Զ�����
Except //�����Զ�����
  DebugOutStr('[Exception] TScene.KeyPress'); //�����Զ�����
End; //�����Զ�����
end;

procedure TScene.KeyDown (var Key: Word; Shift: TShiftState);
begin
Try //�����Զ�����
Except //�����Զ�����
  DebugOutStr('[Exception] TScene.KeyDown'); //�����Զ�����
End; //�����Զ�����
end;

procedure TScene.MouseMove (Shift: TShiftState; X, Y: Integer);
begin
Try //�����Զ�����
Except //�����Զ�����
  DebugOutStr('[Exception] TScene.MouseMove'); //�����Զ�����
End; //�����Զ�����
end;

procedure TScene.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
Try //�����Զ�����
Except //�����Զ�����
  DebugOutStr('[Exception] TScene.MouseDown'); //�����Զ�����
End; //�����Զ�����
end;

procedure TScene.PlayScene (MSurface: TDirectDrawSurface);
begin
Try //�����Զ�����
   ;
Except //�����Զ�����
  DebugOutStr('[Exception] TScene.PlayScene'); //�����Զ�����
End; //�����Զ�����
end;


{------------------- TIntroScene ----------------------}


constructor TIntroScene.Create;
begin
Try //�����Զ�����
   inherited Create (stIntro);
Except //�����Զ�����
  DebugOutStr('[Exception] TIntroScene.Create'); //�����Զ�����
End; //�����Զ�����
end;

destructor TIntroScene.Destroy;
begin
Try //�����Զ�����
   inherited Destroy;
Except //�����Զ�����
  DebugOutStr('[Exception] TIntroScene.Destroy'); //�����Զ�����
End; //�����Զ�����
end;

procedure TIntroScene.OpenScene;
begin
Try //�����Զ�����
Except //�����Զ�����
  DebugOutStr('[Exception] TIntroScene.OpenScene'); //�����Զ�����
End; //�����Զ�����
end;

procedure TIntroScene.CloseScene;
begin
Try //�����Զ�����
Except //�����Զ�����
  DebugOutStr('[Exception] TIntroScene.CloseScene'); //�����Զ�����
End; //�����Զ�����
end;

procedure TIntroScene.PlayScene (MSurface: TDirectDrawSurface);
begin
Try //�����Զ�����
Except //�����Զ�����
  DebugOutStr('[Exception] TIntroScene.PlayScene'); //�����Զ�����
End; //�����Զ�����
end;


{--------------------- Login ----------------------}


constructor TLoginScene.Create;
var
   nx, ny: integer;
begin
Try //�����Զ�����
   inherited Create (stLogin);


   m_EdId := TEdit.Create (FrmMain.Owner);
   with m_EdId do begin
      Parent := FrmMain;
      Color  := clBlack;
      Font.Color := clWhite;
      Font.Size := 9;
      MaxLength := 10;
      BorderStyle := bsNone;
      OnKeyPress := EdLoginIdKeyPress;
      Visible := FALSE;
      Tag := 10;
   end;

   m_EdPasswd := TEdit.Create (FrmMain.Owner);
   with m_EdPasswd do begin
      Parent := FrmMain; Color  := clBlack; Font.Size := 9; MaxLength := 10; Font.Color := clWhite;
      BorderStyle := bsNone; PasswordChar := '*';
      OnKeyPress := EdLoginPasswdKeyPress; Visible := FALSE;
      Tag := 10;
   end;

   nx := SCREENWIDTH div 2 - 320 {192}{79};
   ny := SCREENHEIGHT div 2 - 238{146}{64};
   
   m_EdNewId := TEdit.Create (FrmMain.Owner);
   with m_EdNewId do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 116;
      BorderStyle := bsNone; Color := clBlack; Font.Color := clWhite; MaxLength := 10;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;


   m_EdNewPasswd := TEdit.Create (FrmMain.Owner);
   with m_EdNewPasswd do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 137;
      BorderStyle := bsNone; Color := clBlack; Font.Color := clWhite; MaxLength := 10;
      PasswordChar := '*'; Visible := FALSE;  OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdConfirm := TEdit.Create (FrmMain.Owner);
   with m_EdConfirm do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 158;
      BorderStyle := bsNone; Color := clBlack; Font.Color := clWhite; MaxLength := 10;
      PasswordChar := '*';  Visible := FALSE;  OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdYourName := TEdit.Create (FrmMain.Owner);
   with m_EdYourName do begin
      Parent := FrmMain; Height := 16; Width  := 116; Left := nx + 161; Top  := ny + 187;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 20;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdSSNo := TEdit.Create (FrmMain.Owner);
   with m_EdSSNo do begin
      Parent := FrmMain; Height := 16; Width  := 116; Left := nx + 161; Top  := ny + 207;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 14;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdBirthDay := TEdit.Create (FrmMain.Owner);
   with m_EdBirthDay do begin
      Parent := FrmMain; Height := 16; Width  := 116; Left := nx + 161; Top  := ny + 227;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 10;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdQuiz1 := TEdit.Create (FrmMain.Owner);
   with m_EdQuiz1 do begin
      Parent := FrmMain;  Height := 16; Width  := 163; Left := nx + 161; Top  := ny + 256;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 20;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdAnswer1 := TEdit.Create (FrmMain.Owner);
   with m_EdAnswer1 do begin
      Parent := FrmMain;  Height := 16; Width  := 163; Left := nx + 161; Top  := ny + 276;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 12;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdQuiz2 := TEdit.Create (FrmMain.Owner);
   with m_EdQuiz2 do begin
      Parent := FrmMain;  Height := 16; Width  := 163; Left := nx + 161; Top  := ny + 297;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 20;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdAnswer2 := TEdit.Create (FrmMain.Owner);
   with m_EdAnswer2 do begin
      Parent := FrmMain;  Height := 16; Width  := 163; Left := nx + 161; Top  := ny + 317;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 12;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdPhone := TEdit.Create (FrmMain.Owner);
   with m_EdPhone do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 347;
      BorderStyle := bsNone;
      Color  := clBlack;
      Font.Color := clWhite;
      MaxLength := 14;
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdMobPhone := TEdit.Create (FrmMain.Owner);
   with m_EdMobPhone do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 368;
      BorderStyle := bsNone;
      Color  := clBlack;
      Font.Color := clWhite;
      MaxLength := 13;
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdEMail := TEdit.Create (FrmMain.Owner);
   with m_EdEMail do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 388;
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      MaxLength := 40;
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 11;
   end;

   nx := SCREENWIDTH div 2 - 210 {192}{192};
   ny := SCREENHEIGHT div 2 - 150{146}{150};
   m_EdChgId := TEdit.Create (FrmMain.Owner);
   with m_EdChgId do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 137;
      Left := nx+239;
      Top  := ny+117;
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      MaxLength := 10;
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 12;
   end;
   m_EdChgCurrentpw := TEdit.Create (FrmMain.Owner);
   with m_EdChgCurrentpw do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 137;
      Left := nx+239;
      Top  := ny+149;
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      MaxLength := 10;
      PasswordChar := '*';
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 12;
   end;
   m_EdChgNewPw := TEdit.Create (FrmMain.Owner);
   with m_EdChgNewPw do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 137;
      Left := nx+239;
      Top  := ny+176;
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      MaxLength := 10;
      PasswordChar := '*';
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 12;
   end;
   m_EdChgRepeat := TEdit.Create (FrmMain.Owner);
   with m_EdChgRepeat do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 137;
      Left := nx+239;
      Top  := ny+208;
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      MaxLength := 10;
      PasswordChar := '*';
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 12;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.Create'); //�����Զ�����
End; //�����Զ�����
end;

destructor TLoginScene.Destroy;
begin
Try //�����Զ�����
   inherited Destroy;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.Destroy'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.OpenScene;
var
   i: integer;
   d: TDirectDrawSurface;
begin
Try //�����Զ�����
   
   m_nCurFrame := 0;
   m_nMaxFrame := 10;
   m_sLoginId := '';
   m_sLoginPasswd := '';

   with m_EdId do begin
      Left   := SCREENWIDTH div 2 - 68 + 44{18}{350};
      Top    := SCREENHEIGHT div 2  - 8 - 76{34} {259};
      Height := 16;
      Width  := 137;
      Visible := FALSE;
   end;
   with m_EdPasswd do begin
      Left   := SCREENWIDTH div 2 - 68 + 44{18}{350};
      Top    := SCREENHEIGHT div 2  - 8 - 44{2} {291};
      Height := 16;
      Width  := 137;
      Visible := FALSE;
   end;
   m_boOpenFirst := TRUE;

   FrmDlg.DLogin.Visible := TRUE;
   FrmDlg.DNewAccount.Visible := FALSE;
   m_boNowOpening := FALSE;
   PlayBGM (bmg_intro);

Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.OpenScene'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.CloseScene;
begin
Try //�����Զ�����
   m_EdId.Visible := FALSE;
   m_EdPasswd.Visible := FALSE;
   FrmDlg.DLogin.Visible := FALSE;
   SilenceSound;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.CloseScene'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.EdLoginIdKeyPress (Sender: TObject; var Key: Char);
begin
Try //�����Զ�����
   if Key = #13 then begin
      Key := #0;
      m_sLoginId := LowerCase(m_EdId.Text);
      if m_sLoginId <> '' then begin
         m_EdPasswd.SetFocus;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.EdLoginIdKeyPress'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.EdLoginPasswdKeyPress (Sender: TObject; var Key: Char);
begin
Try //�����Զ�����
   if (Key = '~') or (Key = '''') then Key := '_';
   if Key = #13 then begin
      Key := #0;
      m_sLoginId := LowerCase(m_EdId.Text);
      m_sLoginPasswd := m_EdPasswd.Text;
      if (m_sLoginId <> '') and (m_sLoginPasswd <> '') then begin
         //�������� �α��� �Ѵ�.
         FrmMain.SendLogin (m_sLoginId, m_sLoginPasswd);
         m_EdId.Text := '';
         m_EdPasswd.Text := '';
         m_EdId.Visible := FALSE;
         m_EdPasswd.Visible := FALSE;
      end else
         if (m_EdId.Visible) and (m_EdId.Text = '') then m_EdId.SetFocus;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.EdLoginPasswdKeyPress'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.PassWdFail;
begin
Try //�����Զ�����

   m_EdId.Visible := TRUE;
   m_EdPasswd.Visible := TRUE;
   m_EdId.SetFocus;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.PassWdFail'); //�����Զ�����
End; //�����Զ�����
end;


function  TLoginScene.NewIdCheckNewId: Boolean;
begin
Try //�����Զ�����
   Result := TRUE;
   m_EdNewId.Text := Trim(m_EdNewId.Text);
   if Length(m_EdNewId.Text) < 3 then begin
      FrmDlg.DMessageDlg ('��¼�ʺŵĳ��ȱ������3λ.', [mbOk]);
      Beep;
      m_EdNewId.SetFocus;
      Result := FALSE;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.NewIdCheckNewId:'); //�����Զ�����
End; //�����Զ�����
end;

function  TLoginScene.NewIdCheckSSno: Boolean;
var
   str, t1, t2, t3, syear, smon, sday: string;
   ayear, amon, aday, sex: integer;
   flag: Boolean;
begin
Try //�����Զ�����
   Result := TRUE;
   str := m_EdSSNo.Text;
   str := GetValidStr3 (str, t1, ['-']);
   GetValidStr3 (str, t2, ['-']);
   flag := TRUE;
   if (Length(t1) = 6) and (Length(t2) = 7) then begin
      smon := Copy(t1, 3, 2);
      sday := Copy(t1, 5, 2);
      amon := Str_ToInt (smon, 0);
      aday := Str_ToInt (sday, 0);
      if (amon <= 0) or (amon > 12) then flag := FALSE;
      if (aday <= 0) or (aday > 31) then flag := FALSE;
      sex := Str_ToInt (Copy(t2, 1, 1), 0);
      if (sex <= 0) or (sex > 2) then flag := FALSE;
   end else flag := FALSE;
   if not flag then begin
      Beep;
      m_EdSSNo.SetFocus;
      Result := FALSE;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.NewIdCheckSSno:'); //�����Զ�����
End; //�����Զ�����
end;

function  TLoginScene.NewIdCheckBirthDay: Boolean;
var
   str, t1, t2, t3, syear, smon, sday: string;
   ayear, amon, aday, sex: integer;
   flag: Boolean;
begin
Try //�����Զ�����
   Result := TRUE;
   flag := TRUE;
   str := m_EdBirthDay.Text;
   str := GetValidStr3 (str, syear, ['/']);
   str := GetValidStr3 (str, smon, ['/']);
   str := GetValidStr3 (str, sday, ['/']);
   ayear := Str_ToInt(syear, 0);
   amon := Str_ToInt(smon, 0);
   aday := Str_ToInt(sday, 0);
   if (ayear <= 1890) or (ayear > 2101) then flag := FALSE;
   if (amon <= 0) or (amon > 12) then flag := FALSE;
   if (aday <= 0) or (aday > 31) then flag := FALSE;
   if not flag then begin
      Beep;
      m_EdBirthDay.SetFocus;
      Result := FALSE;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.NewIdCheckBirthDay:'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.EdNewIdKeyPress (Sender: TObject; var Key: Char);
var
   str, t1, t2, t3, syear, smon, sday: string;
   ayear, amon, aday, sex: integer;
   flag: Boolean;
begin
Try //�����Զ�����
   if (Sender = m_EdNewPasswd) or (Sender = m_EdChgNewPw) or (Sender = m_EdChgRepeat) then
      if (Key = '~') or (Key = '''') or (Key = ' ') then Key := #0;
   if Key = #13 then begin
      Key := #0;
      if Sender = m_EdNewId then begin
         if not NewIdCheckNewId then
            exit;
      end;
      if Sender = m_EdNewPasswd then begin
         if Length(m_EdNewPasswd.Text) < 4 then begin
            FrmDlg.DMessageDlg ('���볤�ȱ������ 4λ.', [mbOk]);
            Beep;
            m_EdNewPasswd.SetFocus;
            exit;
         end;
      end;
      if Sender = m_EdConfirm then begin
         if m_EdNewPasswd.Text <> m_EdConfirm.Text then begin
            FrmDlg.DMessageDlg ('������������벻һ��������', [mbOk]);
            Beep;
            m_EdConfirm.SetFocus;
            exit;
         end;
      end;
      if (Sender = m_EdYourName) or (Sender = m_EdQuiz1) or (Sender = m_EdAnswer1) or
         (Sender = m_EdQuiz2) or (Sender = m_EdAnswer2) or (Sender = m_EdPhone) or
         (Sender = m_EdMobPhone) or (Sender = m_EdEMail)
      then begin
         TEdit(Sender).Text := Trim(TEdit(Sender).Text);
         if TEdit(Sender).Text = '' then begin
            Beep;
            TEdit(Sender).SetFocus;
            exit;
         end;
      end;
      if (Sender = m_EdSSNo) and (not EnglishVersion) then begin  //�ѱ��� ���.. �ֹε�Ϲ�ȣ ���� äũ
         if not NewIdCheckSSno then
            exit;
      end;
      if Sender = m_EdBirthDay then begin
         if not NewIdCheckBirthDay then
            exit;
      end;
      if TEdit(Sender).Text <> '' then begin
         if Sender = m_EdNewId then m_EdNewPasswd.SetFocus;
         if Sender = m_EdNewPasswd then m_EdConfirm.SetFocus;
         if Sender = m_EdConfirm then m_EdYourName.SetFocus;
         if Sender = m_EdYourName then m_EdSSNo.SetFocus;
         if Sender = m_EdSSNo then m_EdBirthDay.SetFocus;
         if Sender = m_EdBirthDay then m_EdQuiz1.SetFocus;
         if Sender = m_EdQuiz1 then m_EdAnswer1.SetFocus;
         if Sender = m_EdAnswer1 then m_EdQuiz2.SetFocus;
         if Sender = m_EdQuiz2 then m_EdAnswer2.SetFocus;
         if Sender = m_EdAnswer2 then m_EdPhone.SetFocus;
         if Sender = m_EdPhone then m_EdMobPhone.SetFocus;
         if Sender = m_EdMobPhone then m_EdEMail.SetFocus;
         if Sender = m_EdEMail then begin
            if m_EdNewId.Enabled then m_EdNewId.SetFocus
            else if m_EdNewPasswd.Enabled then m_EdNewPasswd.SetFocus;
         end;

         if Sender = m_EdChgId then m_EdChgCurrentpw.SetFocus;
         if Sender = m_EdChgCurrentpw then m_EdChgNewPw.SetFocus;
         if Sender = m_EdChgNewPw then m_EdChgRepeat.SetFocus;
         if Sender = m_EdChgRepeat then m_EdChgId.SetFocus;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.EdNewIdKeyPress'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.EdNewOnEnter (Sender: TObject);
var
   hx, hy: integer;
begin
Try //�����Զ�����
   //��Ʈ
   FrmDlg.NAHelps.Clear;
   hx := TEdit(Sender).Left + TEdit(Sender).Width + 10;
   hy := TEdit(Sender).Top + TEdit(Sender).Height - 18;
   if Sender = m_EdNewId then begin
      FrmDlg.NAHelps.Add ('[�û�]Ҳ�ƣ��˻����˺š�ID��');
      FrmDlg.NAHelps.Add ('�������ַ������ֵ���ϡ�');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('ID����������4λ��');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('�������ID�������ڵ�½��Ϸ������');
      FrmDlg.NAHelps.Add ('����ϸѡ�����ID');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('���ID�������ڱ������еķ�������');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('���ǽ��飺');
      FrmDlg.NAHelps.Add ('�����������ID��������󼴽���');
      FrmDlg.NAHelps.Add ('��Ϸ�н�����[��ɫ��]���ֿ�����');
   end;
   if Sender = m_EdNewPasswd then begin
      FrmDlg.NAHelps.Add ('�������������ַ������ֵ���ϡ�');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('��������ٳ�����4λ��');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('��ס�����Ǽ�����Ϸ�Ļ���Ҫ�ء�');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('Ϊ������һЩ����ȫ���أ�');
      FrmDlg.NAHelps.Add ('���ǽ��飺');
      FrmDlg.NAHelps.Add ('1����Ҫ���������������ˡ�');
      FrmDlg.NAHelps.Add ('2����Ҫʹ��̫���򵥵����롣');
   end;
   if Sender = m_EdConfirm then begin
      FrmDlg.NAHelps.Add ('�ٴ��������룬��ȷ�ϡ�');
   end;
   if Sender = m_EdYourName then begin
      FrmDlg.NAHelps.Add ('�������ȫ��������ȷ���롣');
      FrmDlg.NAHelps.Add ('�������һ����������֮һ��');
   end;
   if Sender = m_EdBirthDay then begin
      FrmDlg.NAHelps.Add ('��������ĳ������ں��·ݣ�');
      FrmDlg.NAHelps.Add ('��/��/�գ�1977/09/15');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('�������һ����������֮һ��');
   end;
   if (Sender = m_EdQuiz1) or (Sender = m_EdQuiz2) then begin
      FrmDlg.NAHelps.Add ('������һ���һ��������ʾ����');
      FrmDlg.NAHelps.Add ('����ȷ��ֻ���㱾�˲�֪��������⡣');
   end;
   if (Sender = m_EdAnswer1) or (Sender = m_EdAnswer2) then begin
      FrmDlg.NAHelps.Add ('��������������Ĵ�');

   end;
   if (Sender=m_EdYourName) or (Sender=m_EdSSNo) or (Sender=m_EdQuiz1) or (Sender=m_EdQuiz2) or (Sender=m_EdAnswer1) or (Sender=m_EdAnswer2) then begin
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('�����������ȷ����Ϣ��');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('���ʹ���˴������Ϣ��');
      FrmDlg.NAHelps.Add ('�㽫�޷��������ǵ����з���');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('������ṩ����Ϣ����');
      FrmDlg.NAHelps.Add ('����˻����ᱻȡ����');
   end;

   if Sender = m_EdPhone then begin
      FrmDlg.NAHelps.Add ('��������ĵ绰���롣');
      FrmDlg.NAHelps.Add ('');
   end;
   if Sender = m_EdMobPhone then begin
      FrmDlg.NAHelps.Add ('����������ֻ����롣');
      FrmDlg.NAHelps.Add ('');
   end;
   if Sender = m_EdEMail then begin
      FrmDlg.NAHelps.Add ('����������ʼ���E-Mail����ַ��');
      FrmDlg.NAHelps.Add ('���E-Mail�������ڷ������ǵ�');
      FrmDlg.NAHelps.Add ('һЩ��������');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('������յ�������µ�һЩ��Ϣ��');
      FrmDlg.NAHelps.Add ('�������ȷ��д��');
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.EdNewOnEnter'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.HideLoginBox;
begin
Try //�����Զ�����
   //EdId.Visible := FALSE;
   //EdPasswd.Visible := FALSE;
   //FrmDlg.DLogin.Visible := FALSE;
   ChangeLoginState (lsCloseAll);
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.HideLoginBox'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.OpenLoginDoor;
begin
Try //�����Զ�����
   m_boNowOpening := TRUE;
   m_dwStartTime := GetTickCount;
   HideLoginBox;
   PlaySound (s_rock_door_open);
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.OpenLoginDoor'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.PlayScene (MSurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
Try //�����Զ�����
   if m_boOpenFirst then begin
      m_boOpenFirst := FALSE;
      m_EdId.Visible := TRUE;
      m_EdPasswd.Visible := TRUE;
      m_EdId.SetFocus;
   end;
{$IF CUSTOMLIBFILE = 1}
   d := g_WMainImages.Images[83{102-80}];
{$ELSE}
   d := g_WChrSelImages.Images[102-80];
{$IFEND}
   if d <> nil then begin
      MSurface.Draw ((SCREENWIDTH - 800) div 2, (SCREENHEIGHT - 600) div 2, d.ClientRect, d, False);
   end;
   if m_boNowOpening then begin
//      if GetTickCount - StartTime > 230 then begin
//�����ٶ�
      if GetTickCount - m_dwStartTime > 30 then begin
         m_dwStartTime := GetTickCount;
         Inc (m_nCurFrame);
      end;
      if m_nCurFrame >= m_nMaxFrame-1 then begin
         m_nCurFrame := m_nMaxFrame-1;
         if not g_boDoFadeOut and not g_boDoFadeIn then begin
            g_boDoFadeOut := TRUE;
            g_boDoFadeIn := TRUE;
            g_nFadeIndex := 29;
         end;
      end;
{$IF CUSTOMLIBFILE = 1}
      d := g_WMainImages.Images[m_nCurFrame+84{103 + CurFrame-80}];
{$ELSE}
      d := g_WChrSelImages.Images[103 + m_nCurFrame-80];
{$IFEND}

      if d <> nil then
         MSurface.Draw ((SCREENWIDTH - 800) div 2 + 152{152}, (SCREENHEIGHT - 600) div 2 + 96{96}, d.ClientRect, d, TRUE);

      if g_boDoFadeOut then begin
         if g_nFadeIndex <= 1 then begin
            g_WMainImages.ClearCache;
            g_WChrSelImages.ClearCache;
            DScreen.ChangeScene (stSelectChr); //
         end;
      end;
   end; 
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.PlayScene'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.ChangeLoginState (state: TLoginState);
var
   i, focus: integer;
   c: TControl;
begin
Try //�����Զ�����
   focus := -1;
   case state of
      lsLogin: focus := 10;
      lsNewIdRetry, lsNewId: focus := 11;
      lsChgpw: focus := 12;
      lsCloseAll: focus := -1;
   end;
   with FrmMain do begin  //login
      for i:=0 to ControlCount-1 do begin
         c := Controls[i];
         if c is TEdit then begin
            if c.Tag in [10..12] then begin
               if c.Tag = focus then begin
                  c.Visible := TRUE;
                  TEdit(c).Text := '';
               end else begin
                  c.Visible := FALSE;
                  TEdit(c).Text := '';
               end;
            end;
         end;
      end;
      if EnglishVersion then  //���������� �ֹε�Ϲ�ȣ �Է��� ���Ѵ�.
         m_EdSSNo.Visible := FALSE;

      case state of
         lsLogin:
            begin
               FrmDlg.DNewAccount.Visible := FALSE;
               FrmDlg.DChgPw.Visible := FALSE;
               FrmDlg.DLogin.Visible := TRUE;              
               if m_EdId.Visible then m_EdId.SetFocus;
            end;
         lsNewIdRetry,
         lsNewId:
            begin
               if m_boUpdateAccountMode then
                  m_EdNewId.Enabled := FALSE
               else
                  m_EdNewId.Enabled := TRUE;
               FrmDlg.DNewAccount.Visible := TRUE;
               FrmDlg.DChgPw.Visible := FALSE;
               FrmDlg.DLogin.Visible := FALSE;
               if m_EdNewId.Visible and m_EdNewId.Enabled then begin
                  m_EdNewId.SetFocus;
               end else begin
                  if m_EdConfirm.Visible and m_EdConfirm.Enabled then
                     m_EdConfirm.SetFocus;
               end;
            end;
         lsChgpw:
            begin
               FrmDlg.DNewAccount.Visible := FALSE;
               FrmDlg.DChgPw.Visible := TRUE;
               FrmDlg.DLogin.Visible := FALSE;
               if m_EdChgId.Visible then m_EdChgId.SetFocus;
            end;
         lsCloseAll:
            begin
               FrmDlg.DNewAccount.Visible := FALSE;
               FrmDlg.DChgPw.Visible := FALSE;
               FrmDlg.DLogin.Visible := FALSE;
            end;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.ChangeLoginState'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.NewClick;
begin
Try //�����Զ�����
   m_boUpdateAccountMode := FALSE;
   FrmDlg.NewAccountTitle := '';
   ChangeLoginState (lsNewId);
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.NewClick'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.NewIdRetry (boupdate: Boolean);
begin
Try //�����Զ�����
   m_boUpdateAccountMode := boupdate;
   ChangeLoginState (lsNewidRetry);
   m_EdNewId.Text     := m_NewIdRetryUE.sAccount;
   m_EdNewPasswd.Text := m_NewIdRetryUE.sPassword;
   m_EdYourName.Text  := m_NewIdRetryUE.sUserName;
   m_EdSSNo.Text      := m_NewIdRetryUE.sSSNo;
   m_EdQuiz1.Text     := m_NewIdRetryUE.sQuiz;
   m_EdAnswer1.Text   := m_NewIdRetryUE.sAnswer;
   m_EdPhone.Text     := m_NewIdRetryUE.sPhone;
   m_EdEMail.Text     := m_NewIdRetryUE.sEMail;
   m_EdQuiz2.Text     := m_NewIdRetryAdd.sQuiz2;
   m_EdAnswer2.Text   := m_NewIdRetryAdd.sAnswer2;
   m_EdMobPhone.Text  := m_NewIdRetryAdd.sMobilePhone;
   m_EdBirthDay.Text  := m_NewIdRetryAdd.sBirthDay;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.NewIdRetry'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.UpdateAccountInfos (ue: TUserEntry);
begin
Try //�����Զ�����
   m_NewIdRetryUE := ue;
   FillChar (m_NewIdRetryAdd, sizeof(TUserEntryAdd), #0);
   m_boUpdateAccountMode := TRUE; //������ �ִ� ������ ���Է��ϴ� ���
   NewIdRetry (TRUE);
   FrmDlg.NewAccountTitle := '(Please complete all the required fields of the account information)';
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.UpdateAccountInfos'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.OkClick;
var
   key: char;
begin
Try //�����Զ�����
   key := #13;
   EdLoginPasswdKeyPress (self, key);
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.OkClick'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.ChgPwClick;
begin
Try //�����Զ�����
   ChangeLoginState (lsChgPw);
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.ChgPwClick'); //�����Զ�����
End; //�����Զ�����
end;

function  TLoginScene.CheckUserEntrys: Boolean;
begin
Try //�����Զ�����
   Result := FALSE;
   m_EdNewId.Text := Trim(m_EdNewId.Text);
   m_EdQuiz1.Text := Trim(m_EdQuiz1.Text);
   m_EdYourName.Text := Trim(m_EdYourName.Text);
   if not NewIdCheckNewId then exit;

   if not EnglishVersion then begin //���� ���������� üũ����
      if not NewIdCheckSSNo then
         exit;
   end;

   if not NewIdCheckBirthday then exit;
   if Length(m_EdNewId.Text) < 3 then begin
      m_EdNewId.SetFocus;
      exit;
   end;
   if Length(m_EdNewPasswd.Text) < 3 then begin
      m_EdNewPasswd.SetFocus;
      exit;
   end;
   if m_EdNewPasswd.Text <> m_EdConfirm.Text then begin
      m_EdConfirm.SetFocus;
      exit;
   end;
   if Length(m_EdQuiz1.Text) < 1 then begin
      m_EdQuiz1.SetFocus;
      exit;
   end;
   if Length(m_EdAnswer1.Text) < 1 then begin
      m_EdAnswer1.SetFocus;
      exit;
   end;
   if Length(m_EdQuiz2.Text) < 1 then begin
      m_EdQuiz2.SetFocus;
      exit;
   end;
   if Length(m_EdAnswer2.Text) < 1 then begin
      m_EdAnswer2.SetFocus;
      exit;
   end;
   if Length(m_EdYourName.Text) < 1 then begin
      m_EdYourName.SetFocus;
      exit;
   end;
   if not EnglishVersion then begin //���� ���������� üũ����
      if Length(m_EdSSNo.Text) < 1 then begin
         m_EdSSNo.SetFocus;
         exit;
      end;
   end;
   Result := TRUE;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.CheckUserEntrys:'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.NewAccountOk;
var
   ue: TUserEntry;
   ua: TUserEntryAdd;
begin
Try //�����Զ�����
   if CheckUserEntrys then begin
      FillChar (ue, sizeof(TUserEntry), #0);
      FillChar (ua, sizeof(TUserEntryAdd), #0);
      ue.sAccount := LowerCase(m_EdNewId.Text);
      ue.sPassword := m_EdNewPasswd.Text;
      ue.sUserName := m_EdYourName.Text;
      //
      if not EnglishVersion then
         ue.sSSNo := m_EdSSNo.Text
      else
          ue.sSSNo := '650101-1455111';

      ue.sQuiz := m_EdQuiz1.Text;
      ue.sAnswer := Trim(m_EdAnswer1.Text);
      ue.sPhone := m_EdPhone.Text;
      ue.sEMail := Trim(m_EdEMail.Text);

      ua.sQuiz2 := m_EdQuiz2.Text;
      ua.sAnswer2 := Trim(m_EdAnswer2.Text);
      ua.sBirthday := m_EdBirthDay.Text;
      ua.sMobilePhone := m_EdMobPhone.Text;

      m_NewIdRetryUE := ue;    //��õ��� ���
      m_NewIdRetryUE.sAccount := '';
      m_NewIdRetryUE.sPassword := '';
      m_NewIdRetryAdd := ua;

      if not m_boUpdateAccountMode then
         FrmMain.SendNewAccount (ue, ua)
      else
         FrmMain.SendUpdateAccount (ue, ua);
      m_boUpdateAccountMode := FALSE;
      NewAccountClose;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.NewAccountOk'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.NewAccountClose;
begin
Try //�����Զ�����
   if not m_boUpdateAccountMode then
      ChangeLoginState (lsLogin);
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.NewAccountClose'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.ChgpwOk;
var
   uid, passwd, newpasswd: string;
begin
Try //�����Զ�����
   if m_EdChgNewPw.Text = m_EdChgRepeat.Text then begin
      uid := m_EdChgId.Text;
      passwd := m_EdChgCurrentpw.Text;
      newpasswd := m_EdChgNewPw.Text;
      FrmMain.SendChgPw (uid, passwd, newpasswd);
      ChgpwCancel;
   end else begin
      FrmDlg.DMessageDlg ('Password confirmation is not correct.', [mbOk]);
      m_EdChgNewPw.SetFocus;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.ChgpwOk'); //�����Զ�����
End; //�����Զ�����
end;

procedure TLoginScene.ChgpwCancel;
begin
Try //�����Զ�����
   ChangeLoginState (lsLogin);
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginScene.ChgpwCancel'); //�����Զ�����
End; //�����Զ�����
end;


{-------------------- TSelectChrScene ------------------------}

constructor TSelectChrScene.Create;
begin
Try //�����Զ�����
   CreateChrMode := FALSE;
   FillChar (ChrArr, sizeof(TSelChar)*2, #0);
   ChrArr[0].FreezeState := TRUE; //�⺻�� ��� �ִ� ����
   ChrArr[1].FreezeState := TRUE;
   NewIndex := 0;
   EdChrName := TEdit.Create (FrmMain.Owner);
   with EdChrName do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 137;
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      ImeMode := LocalLanguage;
      MaxLength := 14;
      Visible := FALSE;
      OnKeyPress := EdChrnameKeyPress;
   end;
   SoundTimer := TTimer.Create (FrmMain.Owner);
   with SoundTimer do begin
      OnTimer := SoundOnTimer;
      Interval := 1;
      Enabled := FALSE;
   end;
   inherited Create (stSelectChr);
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.Create'); //�����Զ�����
End; //�����Զ�����
end;

destructor TSelectChrScene.Destroy;
begin
Try //�����Զ�����
   inherited Destroy;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.Destroy'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.OpenScene;
begin
Try //�����Զ�����
   FrmDlg.DSelectChr.Visible := TRUE;
   SoundTimer.Enabled := TRUE;
   SoundTimer.Interval := 1;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.OpenScene'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.CloseScene;
begin
Try //�����Զ�����
   SilenceSound;
   FrmDlg.DSelectChr.Visible := FALSE;
   SoundTimer.Enabled := FALSE;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.CloseScene'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.SoundOnTimer (Sender: TObject);
begin
Try //�����Զ�����
   PlayBGM (bmg_select);
   SoundTimer.Enabled := FALSE;
   //SoundTimer.Interval := 38 * 1000;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SoundOnTimer'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.SelChrSelect1Click;
begin
Try //�����Զ�����
   if (not ChrArr[0].Selected) and (ChrArr[0].Valid) then begin
      FrmMain.SelectChr(ChrArr[0].UserChr.Name);//2004/05/17
      ChrArr[0].Selected := TRUE;
      ChrArr[1].Selected := FALSE;
      ChrArr[0].Unfreezing := TRUE;
      ChrArr[0].AniIndex := 0;
      ChrArr[0].DarkLevel := 0;
      ChrArr[0].EffIndex := 0;
      ChrArr[0].StartTime := GetTickCount;
      ChrArr[0].MoreTime := GetTickCount;
      ChrArr[0].StartEffTime := GetTickCount;
      PlaySound (s_meltstone);
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SelChrSelect1Click'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.SelChrSelect2Click;
begin
Try //�����Զ�����
   if (not ChrArr[1].Selected) and (ChrArr[1].Valid) then begin
      FrmMain.SelectChr(ChrArr[1].UserChr.Name);//2004/05/17
      ChrArr[1].Selected := TRUE;
      ChrArr[0].Selected := FALSE;
      ChrArr[1].Unfreezing := TRUE;
      ChrArr[1].AniIndex := 0;
      ChrArr[1].DarkLevel := 0;
      ChrArr[1].EffIndex := 0;
      ChrArr[1].StartTime := GetTickCount;
      ChrArr[1].MoreTime := GetTickCount;
      ChrArr[1].StartEffTime := GetTickCount;
      PlaySound (s_meltstone);
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SelChrSelect2Click'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.SelChrStartClick;
var
   chrname: string;
begin
Try //�����Զ�����
   DScreen.ClearHint;
   chrname := '';
   if ChrArr[0].Valid and ChrArr[0].Selected then chrname := ChrArr[0].UserChr.Name;
   if ChrArr[1].Valid and ChrArr[1].Selected then chrname := ChrArr[1].UserChr.Name;
   if chrname <> '' then begin
      if not g_boDoFadeOut and not g_boDoFadeIn then begin
         g_boDoFastFadeOut := TRUE;
         g_nFadeIndex := 29;
      end;
      FrmMain.SendSelChr (chrname);
   end else
      FrmDlg.DMessageDlg ('һ��ʼ��Ӧ�ô���һ���½�ɫ��\ѡ��<������ɫ>����ܽ���һ���½�ɫ��', [mbOk]);
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SelChrStartClick'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.SelChrNewChrClick;
begin
Try //�����Զ�����
   if not ChrArr[0].Valid or not ChrArr[1].Valid then begin
      if not ChrArr[0].Valid then MakeNewChar (0)
      else MakeNewChar (1);
   end else
      FrmDlg.DMessageDlg ('�����Ϊÿ���������ʺŴ��� 2 ����ɫ��', [mbOk]);
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SelChrNewChrClick'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.SelChrEraseChrClick;
var
   n: integer;
begin
Try //�����Զ�����
   n := 0;
   if ChrArr[0].Valid and ChrArr[0].Selected then n := 0;
   if ChrArr[1].Valid and ChrArr[1].Selected then n := 1;
   if (ChrArr[n].Valid) and (not ChrArr[n].FreezeState) and (ChrArr[n].UserChr.Name <> '') then begin
      //��� �޼����� ������.
      if mrYes = FrmDlg.DMessageDlg ('[' + ChrArr[n].UserChr.Name + '] ��ɾ���Ľ�ɫ�ǲ��ܱ��ָ���\' +
                                                                    'һ��ʱ�����㽫����ʹ����ͬ�Ľ�ɫ����\' +
                                                                    '�����Ҫɾ����', [mbYes, mbNo, mbCancel]) then
         FrmMain.SendDelChr (ChrArr[n].UserChr.Name);
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SelChrEraseChrClick'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.SelChrCreditsClick;
begin
Try //�����Զ�����
 { FrmDlg.DRenewChr.Left:=30;
  FrmDlg.DRenewChr.Top:=0;
  FrmDlg.DRenewChr.Visible:=Not FrmDlg.DRenewChr.Visible; }
  if not ChrArr[0].Valid or not ChrArr[1].Valid then begin
      FrmMain.SendViewDelHum;;
   end else
      FrmDlg.DMessageDlg ('���Ѿ��������������', [mbOk]);

Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SelChrCreditsClick'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.SelChrExitClick;
begin
Try //�����Զ�����
   FrmMain.Close;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SelChrExitClick'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.ClearChrs;
begin
Try //�����Զ�����
   FillChar (ChrArr, sizeof(TSelChar)*2, #0);
   ChrArr[0].FreezeState := FALSE;
   ChrArr[1].FreezeState := TRUE; //�⺻�� ��� �ִ� ����
   ChrArr[0].Selected := TRUE;
   ChrArr[1].Selected := FALSE;
   ChrArr[0].UserChr.Name := '';
   ChrArr[1].UserChr.Name := '';
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.ClearChrs'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.AddChr (uname: string; job, hair, level, sex: integer);
var
   n: integer;
begin
Try //�����Զ�����
   if not ChrArr[0].Valid then n := 0
   else if not ChrArr[1].Valid then n := 1
   else exit;
   ChrArr[n].UserChr.Name := uname;
   ChrArr[n].UserChr.Job := job;
   ChrArr[n].UserChr.Hair := hair;
   ChrArr[n].UserChr.Level := level;
   ChrArr[n].UserChr.Sex := sex;
   ChrArr[n].Valid := TRUE;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.AddChr'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.MakeNewChar (index: integer);
begin
Try //�����Զ�����
   CreateChrMode := TRUE;
   NewIndex := index;
   if index = 0 then begin
      FrmDlg.DCreateChr.Left := 415;
      FrmDlg.DCreateChr.Top := 15;
   end else begin
      FrmDlg.DCreateChr.Left := 75;
      FrmDlg.DCreateChr.Top := 15;
   end;
   FrmDlg.DCreateChr.Visible := TRUE;
   ChrArr[NewIndex].Valid := TRUE;
   ChrArr[NewIndex].FreezeState := FALSE;
   EdChrName.Left := FrmDlg.DCreateChr.Left + 71;
   EdChrName.Top  := FrmDlg.DCreateChr.Top + 107;
   EdChrName.Visible := TRUE;
   EdChrName.SetFocus;
   SelectChr (NewIndex);
   FillChar (ChrArr[NewIndex].UserChr, sizeof(TUserCharacterInfo), #0);
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.MakeNewChar'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.EdChrnameKeyPress (Sender: TObject; var Key: Char);
begin
Try //�����Զ�����

Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.EdChrnameKeyPress'); //�����Զ�����
End; //�����Զ�����
end;


procedure TSelectChrScene.SelectChr (index: integer);
begin
Try //�����Զ�����
   ChrArr[index].Selected := TRUE;
   ChrArr[index].DarkLevel := 30;
   ChrArr[index].StartTime := GetTickCount;
   ChrArr[index].Moretime := GetTickCount;
   if index = 0 then ChrArr[1].Selected := FALSE
   else ChrArr[0].Selected := FALSE;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SelectChr'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.SelChrNewClose;
begin
Try //�����Զ�����
   ChrArr[NewIndex].Valid := FALSE;
   CreateChrMode := FALSE;
   FrmDlg.DCreateChr.Visible := FALSE;
   EdChrName.Visible := FALSE;
   if NewIndex = 1 then begin
      ChrArr[0].Selected := TRUE;
      ChrArr[0].FreezeState := FALSE;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SelChrNewClose'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.SelRenewChr;
begin
Try //�����Զ�����
  if FrmDlg.RenewChrIdx in [1..high(RenewChr)] then begin
    FrmMain.SendRenewHum(RenewChr[FrmDlg.RenewChrIdx-1].Name);
    FrmDlg.DRenewChr.Visible:=False;
//    FrmMain.SendQueryChr;
  end;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SelRenewChr'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.SelChrNewOk;
var
   chrname, shair, sjob, ssex: string;
begin
Try //�����Զ�����
   chrname := Trim(EdChrName.Text);
   if chrname <> '' then begin
      ChrArr[NewIndex].Valid := FALSE;
      CreateChrMode := FALSE;
      FrmDlg.DCreateChr.Visible := FALSE;
      EdChrName.Visible := FALSE;
      if NewIndex = 1 then begin
         ChrArr[0].Selected := TRUE;
         ChrArr[0].FreezeState := FALSE;
      end;
      shair := IntToStr(1 + Random(5)); //////****IntToStr(ChrArr[NewIndex].UserChr.Hair);
      sjob  := IntToStr(ChrArr[NewIndex].UserChr.Job);
      ssex  := IntToStr(ChrArr[NewIndex].UserChr.Sex);
      FrmMain.SendNewChr (FrmMain.LoginId, chrname, shair, sjob, ssex); //�� ĳ���͸� �����.
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SelChrNewOk'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.SelChrNewJob (job: integer);
begin
Try //�����Զ�����
   if (job in [0..2]) and (ChrArr[NewIndex].UserChr.Job <> job) then begin
      ChrArr[NewIndex].UserChr.Job := job;
      SelectChr (NewIndex);
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SelChrNewJob'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.SelChrNewm_btSex (sex: integer);
begin
Try //�����Զ�����
   if sex <> ChrArr[NewIndex].UserChr.Sex then begin
      ChrArr[NewIndex].UserChr.Sex := sex;
      SelectChr (NewIndex);
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SelChrNewm_btSex'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.SelChrNewPrevHair;
begin
Try //�����Զ�����
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SelChrNewPrevHair'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.SelChrNewNextHair;
begin
Try //�����Զ�����
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.SelChrNewNextHair'); //�����Զ�����
End; //�����Զ�����
end;

procedure TSelectChrScene.PlayScene (MSurface: TDirectDrawSurface);
var
   n, bx, by, fx, fy, img: integer;
   ex, ey:Integer; //ѡ������ʱ��ʾ��Ч����λ��
   d, e, dd: TDirectDrawSurface;
   svname: string;
begin
Try //�����Զ�����
   bx:=0;
   by:=0;
   fx:=0;
   fy:=0;//Jacky
{$IF SWH = SWH800}
   d := g_WMain3Images.Images[400];
{$ELSEIF SWH = SWH1024}
//   d := g_WMainImages.Images[82];
   d := g_WMain3Images.Images[400];
{$IFEND}
   //��ʾѡ�����ﱳ������
   if d <> nil then begin
//      MSurface.Draw (0, 0, d.ClientRect, d, FALSE);
      MSurface.Draw ((SCREENWIDTH - d.Width) div 2,(SCREENHEIGHT - d.Height) div 2, d.ClientRect, d, FALSE);

   end;
   for n:=0 to 1 do begin
      if ChrArr[n].Valid then begin
         ex := (SCREENWIDTH - 800) div 2 + 90{90};
         ey := (SCREENHEIGHT - 600) div 2 + 60-2{60-2};
         case ChrArr[n].UserChr.Job of
            0: begin
               if ChrArr[n].UserChr.Sex = 0 then begin
                  bx := (SCREENWIDTH - 800) div 2 + 71{71};
                  by := (SCREENHEIGHT - 600) div 2 + 75-23{75-23}; //����
                  fx := bx;
                  fy := by;
               end else begin
                  bx := (SCREENWIDTH - 800) div 2 + 65{65};
                  by := (SCREENHEIGHT - 600) div 2 + 75-2-18{75-2-18};  //����  ������
                  fx := bx-28+28;
                  fy := by-16+16;    //�����̴� ����
               end;
            end;
            1: begin
               if ChrArr[n].UserChr.Sex = 0 then begin
                  bx := (SCREENWIDTH - 800) div 2 + 77{77};
                  by := (SCREENHEIGHT - 600) div 2 + 75-29{75-29};
                  fx := bx;
                  fy := by;
               end else begin
                  bx := (SCREENWIDTH - 800) div 2 + 141+30{141+30};
                  by := (SCREENHEIGHT - 600) div 2 + 85+14-2{85+14-2};
                  fx := bx-30;
                  fy := by-14;
               end;
            end;
            2: begin
               if ChrArr[n].UserChr.Sex = 0 then begin
                  bx := (SCREENWIDTH - 800) div 2 + 85{85};
                  by := (SCREENHEIGHT - 600) div 2 + 75-12{75-12};
                  fx := bx;
                  fy := by;
               end else begin
                  bx := (SCREENWIDTH - 800) div 2 + 141+23{141+23};
                  by := (SCREENHEIGHT - 600) div 2 + 85+20-2{85+20-2};
                  fx := bx-23;
                  fy := by-20;
               end;
            end;
         end;
         if n = 1 then begin
            ex := (SCREENWIDTH - 800) div 2 + 430{430};
            ey := (SCREENHEIGHT - 600) div 2 + 60{60};
            bx := bx + 340;
            by := by + 2;
            fx := fx + 340;
            fy := fy + 2;
         end;
         if ChrArr[n].Unfreezing then begin //��� �ִ� ��
            img := 140 - 80 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].UserChr.Sex * 120;
            d := g_WChrSelImages.Images[img + ChrArr[n].aniIndex];
            e := g_WChrSelImages.Images[4 + ChrArr[n].effIndex];
            if d <> nil then MSurface.Draw (bx, by, d.ClientRect, d, TRUE);
            if e <> nil then DrawBlend (MSurface, ex, ey, e, 1);
            if GetTickCount - ChrArr[n].StartTime > 120{120} then begin
               ChrArr[n].StartTime := GetTickCount;
               ChrArr[n].aniIndex := ChrArr[n].aniIndex + 1;
            end;
            if GetTickCount - ChrArr[n].startefftime >110{ 110} then begin
               ChrArr[n].startefftime := GetTickCount;
               ChrArr[n].effIndex := ChrArr[n].effIndex + 1;
               //if ChrArr[n].effIndex > EFFECTFRAME-1 then
               //   ChrArr[n].effIndex := EFFECTFRAME-1;
            end;
            if ChrArr[n].aniIndex > FREEZEFRAME-1 then begin
               ChrArr[n].Unfreezing := FALSE; //�� �����
               ChrArr[n].FreezeState := FALSE; //
               ChrArr[n].aniIndex := 0;
            end;
         end else
            if not ChrArr[n].Selected and (not ChrArr[n].FreezeState and not ChrArr[n].Freezing) then begin //���õ��� �ʾҴµ� ���������
               ChrArr[n].Freezing := TRUE;
               ChrArr[n].aniIndex := 0;
               ChrArr[n].StartTime := GetTickCount;
            end;
         if ChrArr[n].Freezing then begin //��� �ִ� ��
            img := 140 - 80 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].UserChr.Sex * 120;
            d := g_WChrSelImages.Images[img + FREEZEFRAME - ChrArr[n].aniIndex - 1];
            if d <> nil then MSurface.Draw (bx, by, d.ClientRect, d, TRUE);
            if GetTickCount - ChrArr[n].StartTime > 50 then begin
               ChrArr[n].StartTime := GetTickCount;
               ChrArr[n].aniIndex := ChrArr[n].aniIndex + 1;
            end;
            if ChrArr[n].aniIndex > FREEZEFRAME-1 then begin
               ChrArr[n].Freezing := FALSE; //�� �����
               ChrArr[n].FreezeState := TRUE; //
               ChrArr[n].aniIndex := 0;
            end;
         end;
         if not ChrArr[n].Unfreezing and not ChrArr[n].Freezing then begin
            if not ChrArr[n].FreezeState then begin  //����ִ»���
               img := 120 - 80 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].aniIndex + ChrArr[n].UserChr.Sex * 120;
               d := g_WChrSelImages.Images[img];
               if d <> nil then begin
                  if ChrArr[n].DarkLevel > 0 then begin
                     dd := TDirectDrawSurface.Create (frmMain.DXDraw.DDraw);
                     dd.SystemMemory := TRUE;
                     dd.SetSize (d.Width, d.Height);
                     dd.Draw (0, 0, d.ClientRect, d, FALSE);
                     //MakeDark (dd, 30-ChrArr[n].DarkLevel);
                     MSurface.Draw (fx, fy, dd.ClientRect, dd, TRUE);
                     dd.Free;
                  end else
                     MSurface.Draw (fx, fy, d.ClientRect, d, TRUE);

               end;
            end else begin      //����ִ»���
               img := 140 - 80 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].UserChr.Sex * 120;
               d := g_WChrSelImages.Images[img];
               if d <> nil then
                  MSurface.Draw (bx, by, d.ClientRect, d, TRUE);
            end;
            if ChrArr[n].Selected then begin
               if GetTickCount - ChrArr[n].StartTime > 300 then begin
                  ChrArr[n].StartTime := GetTickCount;
                  ChrArr[n].aniIndex := ChrArr[n].aniIndex + 1;
                  if ChrArr[n].aniIndex > SELECTEDFRAME-1 then
                     ChrArr[n].aniIndex := 0;
               end;
               if GetTickCount - ChrArr[n].moretime > 25 then begin
                  ChrArr[n].moretime := GetTickCount;
                  if ChrArr[n].DarkLevel > 0 then
                     ChrArr[n].DarkLevel := ChrArr[n].DarkLevel - 1;
               end;
            end;
         end;
         //��ʾѡ���ɫʱ�������Ƶȼ�
         if n = 0 then begin
            if ChrArr[n].UserChr.Name <> '' then begin
               with MSurface do begin
                  SetBkMode (Canvas.Handle, TRANSPARENT);
                  BoldTextOut (MSurface, (SCREENWIDTH - 800) div 2 + 117{117}, (SCREENHEIGHT - 600) div 2 + 492+2 {492+2}, clWhite, clBlack, ChrArr[n].UserChr.Name);
                  BoldTextOut (MSurface, (SCREENWIDTH - 800) div 2 + 117{117}, (SCREENHEIGHT - 600) div 2 + 523{523}, clWhite, clBlack, IntToStr(ChrArr[n].UserChr.Level));
                  BoldTextOut (MSurface, (SCREENWIDTH - 800) div 2 + 117{117}, (SCREENHEIGHT - 600) div 2 + 553{553}, clWhite, clBlack, GetJobName(ChrArr[n].UserChr.Job));
                  Canvas.Release;
               end;
            end;
         end else begin
            if ChrArr[n].UserChr.Name <> '' then begin
               with MSurface do begin
                  SetBkMode (Canvas.Handle, TRANSPARENT);
                  BoldTextOut (MSurface, (SCREENWIDTH - 800) div 2 + 671{671}, (SCREENHEIGHT - 600) div 2 + 492+4 {492+4}, clWhite, clBlack, ChrArr[n].UserChr.Name);
                  BoldTextOut (MSurface, (SCREENWIDTH - 800) div 2 + 671{671}, (SCREENHEIGHT - 600) div 2 + 523+2 {525}, clWhite, clBlack, IntToStr(ChrArr[n].UserChr.Level));
                  BoldTextOut (MSurface, (SCREENWIDTH - 800) div 2 + 671{671}, (SCREENHEIGHT - 600) div 2 + 553+2 {555}, clWhite, clBlack, GetJobName(ChrArr[n].UserChr.Job));
                  Canvas.Release;
               end;
            end;
         end;
         with MSurface do begin
            SetBkMode (Canvas.Handle, TRANSPARENT);
            if BO_FOR_TEST then svname := '���Է�����'
            else svname := g_sServerName;
            BoldTextOut (MSurface, SCREENWIDTH div 2{405} - Canvas.TextWidth(svname) div 2, (SCREENHEIGHT - 600) div 2 + 8{8}, clWhite, clBlack, svname);
            Canvas.Release;
         end;
      end;
   end;
Except //�����Զ�����
  DebugOutStr('[Exception] TSelectChrScene.PlayScene'); //�����Զ�����
End; //�����Զ�����
end;


{--------------------------- TLoginNotice ----------------------------}

constructor TLoginNotice.Create;
begin
Try //�����Զ�����
   inherited Create (stLoginNotice);
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginNotice.Create'); //�����Զ�����
End; //�����Զ�����
end;

destructor TLoginNotice.Destroy;
begin
Try //�����Զ�����
   inherited Destroy;
Except //�����Զ�����
  DebugOutStr('[Exception] TLoginNotice.Destroy'); //�����Զ�����
End; //�����Զ�����
end;


end.
