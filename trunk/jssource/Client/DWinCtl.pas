unit DWinCtl;

interface

uses
  Windows, SysUtils, StrUtils, Classes, Graphics, Controls, DXDraws,
  Grids, Wil, Messages;

const
  AllowedChars = [#32..#255];
  AllowedIntegerChars = [#48..#57];
type
  TClickSound = (csNone, csStone, csGlass, csNorm);
  TDEditClass = (deNone,deInteger,deMonoCase);
  TMouseEntry = (msIn, msOut);
  TDControl = class;
  TOnDirectPaint = procedure(Sender: TObject; dsurface: TDirectDrawSurface) of object;
  TOnKeyPress = procedure(Sender: TObject; var Key: Char) of object;
  TOnKeyDown = procedure(Sender: TObject; var Key: word; Shift: TShiftState) of object;
  TOnKeyUp = procedure(Sender: TObject; var Key: word; Shift: TShiftState) of object;
  TOnMouseMove = procedure(Sender: TObject; Shift: TShiftState; X, Y: integer) of object;
  TOnMouseDown = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer) of object;
  TOnMouseUp = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer) of object;
  TOnClick = procedure(Sender: TObject) of object;
  TOnClickEx = procedure(Sender: TObject; X, Y: integer) of object;
  TOnInRealArea = procedure(Sender: TObject; X, Y: integer; var IsRealArea: Boolean) of object;
  TOnGridSelect = procedure(Sender: TObject; ACol, ARow: integer; Shift: TShiftState) of object;
  TOnGridPaint = procedure(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface) of object;
  TOnClickSound = procedure(Sender: TObject; Clicksound: TClickSound) of object;
  TOnVisible = procedure(Sender: TObject; var boVisible: Boolean) of object;

  TDControl = class(TCustomControl)
  private
    FCaption: string; //0x1F0
    FDParent: TDControl; //0x1F4
    FEnableFocus: Boolean; //0x1F8
    FOnDirectPaint: TOnDirectPaint; //0x1FC
    FOnKeyPress: TOnKeyPress; //0x200
    FOnKeyDown: TOnKeyDown; //0x204
    FOnKeyUp: TOnKeyUp;
    FOnMouseMove: TOnMouseMove; //0x208
    FOnMouseDown: TOnMouseDown; //0x20C
    FOnMouseUp: TOnMouseUp; //0x210
    FOnDblClick: TNotifyEvent; //0x214
    FOnClick: TOnClickEx; //0x218
    FOnInRealArea: TOnInRealArea; //0x21C
    FOnVisible: TOnVisible;
    FOnBackgroundClick: TOnClick; //0x220
    FOnMouseEntry: TOnClick;
    FEnabled: Boolean;
    FCaptionWidth:Integer;
    FCaptionHeight:Integer;
    procedure SetCaption(str: string);
    procedure SetVisible(boVisible: Boolean);
  protected
    FVisible: Boolean;
  public
    Background: Boolean; //0x24D
    MouseEntry: TMouseEntry;
    DControls: TList; //0x250
      //FaceSurface: TDirectDrawSurface;
    WLib: TWMImages; //0x254
    FaceIndex: integer; //0x258
    WantReturn: Boolean; //BackgroundÀÏ¶§, ClickÀÇ »ç¿ë ¿©ºÎ..

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Loaded; override;
    function SurfaceX(x: integer): integer;
    function SurfaceY(y: integer): integer;
    function LocalX(x: integer): integer;
    function LocalY(y: integer): integer;
    procedure AddChild(dcon: TDControl);
    procedure ChangeChildOrder(dcon: TDControl);
    function InRange(x, y: integer): Boolean; dynamic;
    function KeyPress(var Key: Char): Boolean; dynamic;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean; dynamic;
    function KeyUp(var Key: Word; Shift: TShiftState): Boolean; dynamic;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; dynamic;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; dynamic;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; dynamic;
    function DblClick(X, Y: integer): Boolean; dynamic;
    function Click(X, Y: integer): Boolean; dynamic;

    function CanFocusMsg: Boolean;

    procedure SetImgIndex(Lib: TWMImages; index: integer);
    procedure DirectPaint(dsurface: TDirectDrawSurface); dynamic;

  published
    property OnDirectPaint: TOnDirectPaint read FOnDirectPaint write FOnDirectPaint;
    property OnKeyPress: TOnKeyPress read FOnKeyPress write FOnKeyPress;
    property OnKeyDown: TOnKeyDown read FOnKeyDown write FOnKeyDown;
    property OnKeyUp: TOnKeyUp read FOnKeyUp write FOnKeyUp;
    property OnMouseMove: TOnMouseMove read FOnMouseMove write FOnMouseMove;
    property OnMouseDown: TOnMouseDown read FOnMouseDown write FOnMouseDown;
    property OnMouseUp: TOnMouseUp read FOnMouseUp write FOnMouseUp;
    property OnMouseEntry: TOnClick read FOnMouseEntry write FOnMouseEntry;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
    property OnInRealArea: TOnInRealArea read FOnInRealArea write FOnInRealArea;
    property OnBackgroundClick: TOnClick read FOnBackgroundClick write FOnBackgroundClick;
    property OnVisible: TOnVisible read FOnVisible write FOnVisible;
    property Caption: string read FCaption write SetCaption;
    property DParent: TDControl read FDParent write FDParent;
    property Visible: Boolean read FVisible write SetVisible;
    property Enabled: Boolean read FEnabled write FEnabled default True;
    property EnableFocus: Boolean read FEnableFocus write FEnableFocus;
    property CaptionWidth:Integer read FCaptionWidth;
    property CaptionHeight:Integer read FCaptionHeight;
    property Color;
    property Font;
    property Hint;
    property ShowHint;
    property Align;
  end;



   //°´Å¥¿Ø¼þ
  TDButton = class(TDControl)
  private
    FClickSound: TClickSound;
    FOnClick: TOnClickEx;
    FOnClickSound: TOnClickSound;
  public
    Downed: Boolean;
    constructor Create(AOwner: TComponent); override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
  published
    property ClickCount: TClickSound read FClickSound write FClickSound;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
    property OnClickSound: TOnClickSound read FOnClickSound write FOnClickSound;
  end;

  TDUpDown = class(TDButton)
  private
    FUpButton: TDButton;
    FDownButton: TDButton;
    FMoveButton: TDButton;
    FPosition: Integer;
    FMaxPosition: Integer;
    FOnPositionChange: TOnClick;
    FTop: Integer;
    FMaxLength: Integer;
    StopY: Integer;
    procedure SetUpButton(Button: TDButton);
    procedure SetDownButton(Button: TDButton);
    procedure SetMoveButton(Button: TDButton);
  public
    constructor Create(AOwner: TComponent); override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
    procedure ButtonClick(Sender: TObject; X, Y: integer);
    procedure ButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure ButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  published
    property UpButton: TDButton read FUpButton write SetUpButton;
    property DownButton: TDButton read FDownButton write SetDownButton;
    property MoveButton: TDButton read FMoveButton write SetMoveButton;
    property Position: Integer read FPosition write FPosition;
    property MaxPosition: Integer read FMaxPosition write FMaxPosition;
    property OnPositionChange: TOnClick read FOnPositionChange write FOnPositionChange;
  end;

  TDCheckBox = class(TDButton)
  private
    FChecked: Boolean;
    FFontSpace: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
    function InRange(x, y: integer): Boolean; override;
  published
    property Checked: Boolean read FChecked write FChecked;
    property FontSpace: Integer read FFontSpace write FFontSpace;
  end;

  TCursor = (deLeft, deRight);

   //±à¼­¿ò¿Ø¼þ
  TDEdit = class(TDControl)
  private
    FEditString: WideString;
    FCaretShowTime: LongWord;
    FCaretShow: Boolean;
    //FDsurface: TDirectDrawSurface;
    FInputStr: string;
    bDoubleByte: Boolean;
    KeyByteCount: Integer;
    FCaretPos: Integer; //µ±Ç°¹â±êËùÖ¸×Ö·ûÎ»ÖÃ
    FCaretIdx: Integer; //µ±Ç°¹â±êËùÖ¸×Ö·ûÎ»ÖÃ
    FCaretRight: Integer;
    FCursor: TCursor;
    FStartX: Integer;
    FStopX: Integer;
    FFrameColor: TColor;
    FReadOnly: Boolean;
    FPasswordChar: Char;
    FEditClass: TDEditClass;
    FMaxLength: Integer;
    procedure SetCursorPos(cCursor: TCursor);
    procedure MoveCaret(X, Y: Integer);
    function ClearKey(): Boolean;
  public
    Downed: Boolean;
    KeyDowned: Boolean;
    constructor Create(AOwner: TComponent); override;
    function KeyPress(var Key: Char): Boolean; override;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean; override;
    function KeyUp(var Key: Word; Shift: TShiftState): Boolean; override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
  published
    property Text: WideString read FEditString write FEditString;
    property FrameColor: TColor read FFrameColor write FFrameColor;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property PasswordChar: Char read FPasswordChar write FPasswordChar default #0;
    property EditClass: TDEditClass read FEditClass write FEditClass default deNone;
    property MaxLength: Integer read FMaxLength write FMaxLength default 0;
    //property Dsurface: TDirectDrawSurface read FDsurface write FDsurface;
  end;

  TDHooKKey = class(TDEdit)
  private
    FShiftState: TShiftState;
    FKey: Word;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean; override;
    procedure SetKey(Key: Word; Shift: TShiftState);
    procedure RefHookKeyStr();
  end;

  TDComboBox = class(TDEdit)
  private
    FUpDown: TDUpDown;
    FItem: TStrings;
    FShowCount: Integer;
    FListHeight: Integer;
    FShowHeight: Integer;
    FListIndex: Integer;
    FX: Integer;
    FY: Integer;
    procedure SetUpDownButton(Button: TDUpDown);
    procedure SetShowCount(Value: Integer);
    procedure SetShowHeight(Value: Integer);
    procedure SetItem(const Value: TStrings);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function InRange(x, y: integer): Boolean; override;
  published
    property UpDown: TDUpDown read FUpDown write SetUpDownButton;
    property ShowCount: Integer read FShowCount write SetShowCount;
    property ShowHeight: Integer read FShowHeight write SetShowHeight;

    property Item: TStrings read FItem write SetItem;
  end;

   //±í¸ñ¿Ø¼þ
  TDGrid = class(TDControl)
  private
    FColCount, FRowCount: integer;
    FColWidth, FRowHeight: integer;
    FViewTopLine: integer;
    SelectCell: TPoint;
    DownPos: TPoint;
    FOnGridSelect: TOnGridSelect;
    FOnGridMouseMove: TOnGridSelect;
    FOnGridPaint: TOnGridPaint;
    function GetColRow(x, y: integer; var acol, arow: integer): Boolean;
  public
    CX, CY: integer;
    Col, Row: integer;
    constructor Create(AOwner: TComponent); override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function Click(X, Y: integer): Boolean; override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
  published
    property ColCount: integer read FColCount write FColCount;
    property RowCount: integer read FRowCount write FRowCount;
    property ColWidth: integer read FColWidth write FColWidth;
    property RowHeight: integer read FRowHeight write FRowHeight;
    property ViewTopLine: integer read FViewTopLine write FViewTopLine;
    property OnGridSelect: TOnGridSelect read FOnGridSelect write FOnGridSelect;
    property OnGridMouseMove: TOnGridSelect read FOnGridMouseMove write FOnGridMouseMove;
    property OnGridPaint: TOnGridPaint read FOnGridPaint write FOnGridPaint;
  end;


   //´°¿Ú¿Ø¼þ
  TDWindow = class(TDButton)
  private
    FFloating: Boolean;
    FFMovie: Boolean;
    SpotX, SpotY: integer;
  protected
    procedure SetVisible(flag: Boolean);
  public
    DialogResult: TModalResult;
    constructor Create(AOwner: TComponent); override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    procedure Show;
    function ShowModal: integer;
  published
    property Visible: Boolean read FVisible write SetVisible;
    property Floating: Boolean read FFloating write FFloating;
    property FMovie: Boolean read FFMovie write FFMovie default True;
  end;

   //¿Ø¼þ¹ÜÀíÆ÷
  TDWinManager = class(TComponent)
  private
  public
    DWinList: TList; //list of TDControl;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddDControl(dcon: TDControl; visible: Boolean);
    procedure DelDControl(dcon: TDControl);
    procedure ClearAll;

    function KeyPress(var Key: Char): Boolean;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean;
    function KeyUp(var Key: Word; Shift: TShiftState): Boolean;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
    function DblClick(X, Y: integer): Boolean;
    function Click(X, Y: integer): Boolean;
    procedure DirectPaint(dsurface: TDirectDrawSurface);
  end;

procedure Register;
procedure SetDFocus(dcon: TDControl);
procedure ReleaseDFocus;
procedure SetDCapture(dcon: TDControl);
procedure ReleaseDCapture;
function MIN(n1, n2: integer): integer;
function MAX(n1, n2: integer): integer;
procedure BoldTextOut(surface: TDirectDrawSurface; x, y, fcolor, bcolor: integer; str: string);

var
  MouseCaptureControl: TDControl = nil; //mouse message
  FocusedControl: TDControl = nil; //Key message
  MouseEntryControl: TDControl = nil; //Key message
  MainWinHandle: integer = 0;
  ModalDWindow: TDControl = nil;
  DefDsurface: TDirectDrawSurface = nil;


implementation

uses
  Share;


procedure Register;
begin
  RegisterComponents('MirGame', [TDWinManager, TDControl, TDButton, TDGrid,
    TDWindow, TDEdit, TDCheckBox, TDUpDown, TDComboBox, TDHooKKey]);
end;

//ÉèÖÃµ±Ç°»ñµÃÊäÈë½¹µãµÄ¿Õ¼ä

procedure SetDFocus(dcon: TDControl);
begin
  FocusedControl := dcon;
  if FocusedControl is TDEdit then
  begin

  end;
end;

procedure ReleaseDFocus;
begin
  FocusedControl := nil;
end;

procedure SetDCapture(dcon: TDControl);
begin
  SetCapture(MainWinHandle);
  MouseCaptureControl := dcon;
end;

procedure ReleaseDCapture;
begin
  ReleaseCapture;
  MouseCaptureControl := nil;
end;

{----------------------------- TDControl -------------------------------}

constructor TDControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DParent := nil;
  inherited Visible := FALSE;
  FEnableFocus := FALSE;
  Background := FALSE;
  MouseEntry := msOut;
  FOnDirectPaint := nil;
  FOnKeyPress := nil;
  FOnKeyDown := nil;
  FOnKeyUp := nil;
  FOnMouseMove := nil;
  FOnMouseDown := nil;
  FOnMouseUp := nil;
  FOnInRealArea := nil;
  FOnVisible := nil;
  DControls := TList.Create;
  FDParent := nil;

  FCaptionWidth:=0;
  FCaptionHeight:=0;
  Width := 80;
  Height := 24;
  FCaption := '';
  FVisible := TRUE;
  Enabled := True;
   //FaceSurface := nil;
  WLib := nil;
  FaceIndex := 0;
end;

destructor TDControl.Destroy;
begin
  DControls.Free;
  inherited Destroy;
end;

procedure TDControl.SetVisible(boVisible: Boolean);
begin
  FVisible := boVisible;
end;

procedure TDControl.SetCaption(str: string);
begin
  FCaption := str;
  if FCaption<>'' then
  begin
   FCaptionWidth:= Canvas.TextWidth(FCaption)+ Width;
   FCaptionHeight:= MAX(Height,Canvas.TextHeight(FCaption));
  end;
  if csDesigning in ComponentState then begin
    Refresh;
  end;
end;

procedure TDControl.Paint;
begin
  if csDesigning in ComponentState then begin
    if self is TDWindow then begin
      with Canvas do begin
        Pen.Color := clBlack;
        MoveTo(0, 0);
        LineTo(Width - 1, 0);
        LineTo(Width - 1, Height - 1);
        LineTo(0, Height - 1);
        LineTo(0, 0);
        LineTo(Width - 1, Height - 1);
        MoveTo(Width - 1, 0);
        LineTo(0, Height - 1);
        TextOut((Width - TextWidth(Caption)) div 2, (Height - TextHeight(Caption)) div 2, Caption);
      end;
    end else begin
      with Canvas do begin
        Pen.Color := clBlack;
        MoveTo(0, 0);
        LineTo(Width - 1, 0);
        LineTo(Width - 1, Height - 1);
        LineTo(0, Height - 1);
        LineTo(0, 0);
        SetBkMode(Handle, TRANSPARENT);
        Font.Color := self.Font.Color;
        TextOut((Width - TextWidth(Caption)) div 2, (Height - TextHeight(Caption)) div 2, Caption);
      end;
    end;
  end;
end;

procedure TDControl.Loaded;
var
  i: integer;
  dcon: TDControl;
begin
  if not (csDesigning in ComponentState) then begin
    if Parent <> nil then
      for i := 0 to TControl(Parent).ComponentCount - 1 do begin
        if TControl(Parent).Components[i] is TDControl then begin
          dcon := TDControl(TControl(Parent).Components[i]);
          if dcon.DParent = self then begin
            AddChild(dcon);
          end;
        end;
      end;
  end;
end;

//Áö¿ª ÁÂÇ¥¸¦ ÀüÃ¼ ÁÂÇ¥·Î ¹Ù²Þ

function TDControl.SurfaceX(x: integer): integer;
var
  d: TDControl;
begin
  d := self;
  while TRUE do begin
    if d.DParent = nil then break;
    x := x + d.DParent.Left;
    d := d.DParent;
  end;
  Result := x;
end;

function TDControl.SurfaceY(y: integer): integer;
var
  d: TDControl;
begin
  d := self;
  while TRUE do begin
    if d.DParent = nil then break;
    y := y + d.DParent.Top;
    d := d.DParent;
  end;
  Result := y;
end;

//ÀüÃ¼ÁÂÇ¥¸¦ °´Ã¼ÀÇ ÁÂÇ¥·Î ¹Ù²Þ

function TDControl.LocalX(x: integer): integer;
var
  d: TDControl;
begin
  d := self;
  while TRUE do begin
    if d.DParent = nil then break;
    x := x - d.DParent.Left;
    d := d.DParent;
  end;
  Result := x;
end;

function TDControl.LocalY(y: integer): integer;
var
  d: TDControl;
begin
  d := self;
  while TRUE do begin
    if d.DParent = nil then break;
    y := y - d.DParent.Top;
    d := d.DParent;
  end;
  Result := y;
end;

procedure TDControl.AddChild(dcon: TDControl);
begin
  DControls.Add(Pointer(dcon));
end;

procedure TDControl.ChangeChildOrder(dcon: TDControl);
var
  i: integer;
begin
  if not (dcon is TDWindow) then exit;
  if TDWindow(dcon).Floating then begin
    for i := 0 to DControls.Count - 1 do begin
      if dcon = DControls[i] then begin
        DControls.Delete(i);
        break;
      end;
    end;
    DControls.Add(dcon);
  end;
end;

function TDControl.InRange(x, y: integer): Boolean;
var
  inrange: Boolean;
  d: TDirectDrawSurface;
begin
  if Enabled and (x >= Left) and (x < Left + Width) and (y >= Top) and (y < Top + Height) then begin
    inrange := TRUE;
    if Assigned(FOnInRealArea) then
      FOnInRealArea(self, x - Left, y - Top, inrange)
    else
      if WLib <> nil then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          if d.Pixels[x - Left, y - Top] <= 0 then
            inrange := FALSE;
      end;
    Result := inrange;
  end else
    Result := FALSE;
end;

function TDControl.KeyPress(var Key: Char): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  if Background then exit;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).KeyPress(Key) then begin
        Result := TRUE;
        exit;
      end;
  if (FocusedControl = self) then begin
    if Assigned(FOnKeyPress) then FOnKeyPress(self, Key);
    Result := TRUE;
  end;
end;

function TDControl.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  if Background then exit;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).KeyDown(Key, Shift) then begin
        Result := TRUE;
        exit;
      end;
  if (FocusedControl = self) then begin
    if Assigned(FOnKeyDown) then FOnKeyDown(self, Key, Shift);
    Result := TRUE;
  end;
end;

function TDControl.KeyUp(var Key: Word; Shift: TShiftState): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  if Background then exit;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).KeyUp(Key, Shift) then begin
        Result := TRUE;
        exit;
      end;
  if (FocusedControl = self) then begin
    if Assigned(FOnKeyUp) then FOnKeyUp(self, Key, Shift);
    Result := TRUE;
  end;
end;

function TDControl.CanFocusMsg: Boolean;
begin
  if (MouseCaptureControl = nil) or ((MouseCaptureControl <> nil) and ((MouseCaptureControl = self) or (MouseCaptureControl = DParent))) then
    Result := TRUE
  else
    Result := FALSE;
end;

function TDControl.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).MouseMove(Shift, X - Left, Y - Top) then begin
        Result := TRUE;
        exit;
      end;

  if (MouseCaptureControl <> nil) then begin //MouseCapture ÀÌ¸é ÀÚ½ÅÀÌ ¿ì¼±
    if (MouseCaptureControl = self) then begin
      if Assigned(FOnMouseMove) then
        FOnMouseMove(self, Shift, X, Y);
      Result := TRUE;
    end;
    exit;
  end;
  if Background then begin
    if (MouseEntryControl <> nil) and (MouseEntryControl <> self) then begin
      MouseEntryControl.MouseEntry := msOut;
      if Assigned(MouseEntryControl.FOnMouseEntry) then
        MouseEntryControl.FOnMouseEntry(MouseEntryControl);
      MouseEntryControl := nil;
    end;
    exit;
  end;
  if InRange(X, Y) then begin
    if (MouseEntryControl <> nil) and (MouseEntryControl <> self) then begin
      MouseEntryControl.MouseEntry := msOut;
      if Assigned(MouseEntryControl.FOnMouseEntry) then
        MouseEntryControl.FOnMouseEntry(MouseEntryControl);
      MouseEntryControl := nil;
    end;
    if (MouseEntryControl = nil) then begin
      MouseEntryControl := Self;
      MouseEntryControl.MouseEntry := msIn;
      if Assigned(MouseEntryControl.FOnMouseEntry) then
        MouseEntryControl.FOnMouseEntry(MouseEntryControl);
    end;
    if Assigned(FOnMouseMove) then
      FOnMouseMove(self, Shift, X, Y);
    Result := TRUE;
  end;
end;

function TDControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).MouseDown(Button, Shift, X - Left, Y - Top) then begin
        Result := TRUE;
        exit;
      end;
  if Background then begin
    if Assigned(FOnBackgroundClick) then begin
      WantReturn := FALSE;
      FOnBackgroundClick(self);
      if WantReturn then Result := TRUE;
    end;
    ReleaseDFocus;
    exit;
  end;
  if CanFocusMsg then begin
    if InRange(X, Y) or (MouseCaptureControl = self) then begin
      if Assigned(FOnMouseDown) then
        FOnMouseDown(self, Button, Shift, X, Y);
      if EnableFocus then SetDFocus(self);
         //else ReleaseDFocus;
      Result := TRUE;
    end;
  end;
end;

function TDControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).MouseUp(Button, Shift, X - Left, Y - Top) then begin
        Result := TRUE;
        exit;
      end;

  if (MouseCaptureControl <> nil) then begin //MouseCapture ÀÌ¸é ÀÚ½ÅÀÌ ¿ì¼±
    if (MouseCaptureControl = self) then begin
      if Assigned(FOnMouseUp) then
        FOnMouseUp(self, Button, Shift, X, Y);
      Result := TRUE;
    end;
    exit;
  end;

  if Background then exit;
  if InRange(X, Y) then begin
    if Assigned(FOnMouseUp) then
      FOnMouseUp(self, Button, Shift, X, Y);
    Result := TRUE;
  end;
end;

function TDControl.DblClick(X, Y: integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  if (MouseCaptureControl <> nil) then begin //MouseCapture ÀÌ¸é ÀÚ½ÅÀÌ ¿ì¼±
    if (MouseCaptureControl = self) then begin
      if Assigned(FOnDblClick) then
        FOnDblClick(self);
      Result := TRUE;
    end;
    exit;
  end;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).DblClick(X - Left, Y - Top) then begin
        Result := TRUE;
        exit;
      end;
  if Background then exit;
  if InRange(X, Y) then begin
    if Assigned(FOnDblClick) then
      FOnDblClick(self);
    Result := TRUE;
  end;
end;

function TDControl.Click(X, Y: integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  if (MouseCaptureControl <> nil) then begin //MouseCapture ÀÌ¸é ÀÚ½ÅÀÌ ¿ì¼±
    if (MouseCaptureControl = self) then begin
      if Assigned(FOnClick) then
        FOnClick(self, X, Y);
      Result := TRUE;
    end;
    exit;
  end;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).Click(X - Left, Y - Top) then begin
        Result := TRUE;
        exit;
      end;
  if Background then exit;
  if InRange(X, Y) then begin
    if Assigned(FOnClick) then
      FOnClick(self, X, Y);
    Result := TRUE;
  end;
end;

procedure TDControl.SetImgIndex(Lib: TWMImages; index: integer);
var
  d: TDirectDrawSurface;
begin
   //FaceSurface := dsurface;
  if Lib <> nil then begin
    d := Lib.Images[index];
    WLib := Lib;
    FaceIndex := index;
    if d <> nil then begin
      Width := d.Width;
      Height := d.Height;
    end;
  end;
end;

procedure TDControl.DirectPaint(dsurface: TDirectDrawSurface);
var
  i: integer;
  d: TDirectDrawSurface;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(self, dsurface)
  else
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;
  for i := 0 to DControls.Count - 1 do
    if TDControl(DControls[i]).Visible then
      TDControl(DControls[i]).DirectPaint(dsurface);
end;


{--------------------- TDButton --------------------------}


constructor TDButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Downed := FALSE;
  FOnClick := nil;
  FEnableFocus := TRUE;
  FClickSound := csNone;
end;

function TDButton.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if (not Background) and (not Result) then begin
    Result := inherited MouseMove(Shift, X, Y);
    if MouseCaptureControl = self then
      if InRange(X, Y) then Downed := TRUE
      else Downed := FALSE;
  end;
end;

function TDButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl = nil) then begin
      Downed := TRUE;
      SetDCapture(self);
    end;
    Result := TRUE;
  end;
end;

function TDButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if not Background then begin
      if InRange(X, Y) then begin
        if Assigned(FOnClickSound) then FOnClickSound(self, FClickSound);
        if Assigned(FOnClick) then FOnClick(self, X, Y);
      end;
    end;
    Downed := FALSE;
    Result := TRUE;
    exit;
  end else begin
    ReleaseDCapture;
    Downed := FALSE;
  end;
end;



{------------------------- TDEdit --------------------------}

constructor TDEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEnableFocus := TRUE;
  //FDsurface := nil;
  left := 30;
  top := 30;
  Width := 120;
  Height := 20;
  FCaretShowTime := GetTickCount;
  FCaretShow := False;
  FEditString := '';
  KeyByteCount := 0;
  FInputStr := '';
  bDoubleByte := False;
  FrameColor := clSilver;
  FCaretPos := 0;
  FCursor := deLeft;
  FCaretIdx := 0;
  FCaretRight := 0;
  FStartX := -1;
  FStopX := -1;
  KeyDowned := False;
  Downed := False;
  Font.Name := 'ËÎÌå';
  Font.Color := clWhite;
  Font.Size := 9;
  Canvas.Font.Name := Font.Name;
  Canvas.Font.Color := Font.Color;
  Canvas.Font.Size := Font.Size;
end;

procedure TDEdit.SetCursorPos(cCursor: TCursor);
var
  tempstr: WideString;
begin
  if cCursor = deRight then
  begin
    Inc(FCaretPos);
    if FCaretPos > Length(FEditString) then FCaretPos := Length(FEditString);

    while True do
    begin
      tempstr := Copy(FEditString, FCaretIdx, FCaretPos - FCaretIdx);
      if (FCaretIdx < FCaretPos) and (Canvas.TextWidth(tempstr) > (Width - 5 - Canvas.TextWidth('A'))) then
      begin
        FCursor := deRight;
        Inc(FCaretIdx);
        FCaretRight := FCaretPos;
      end else Break;
    end;
  end
  else
  begin
    if FCaretPos > 0 then Dec(FCaretPos);
    if (FCaretPos < FCaretIdx) and (FCaretIdx > 0) then
    begin
      FCursor := deleft;
      Dec(FCaretIdx);
      FCaretRight := FCaretPos;
    end;
  end;
end;

function TDEdit.KeyPress(var Key: Char): Boolean;
begin
  Result := False;
  if (FocusedControl = Self) then
  begin
    Result := TRUE;
    if (not Downed) and (not FReadOnly) then
    begin
      if Assigned(FOnKeyPress) then FOnKeyPress(self, Key);
      if Key = #0 then Exit;
      case Key of
        Char(VK_BACK):
          begin
            if (FEditString <> '') and (not ClearKey()) then
            begin
              FCursor := deleft;
              Delete(FEditString, FCaretPos, 1);
              SetCursorPos(deLeft);
            end;
          end;
      else
        begin
          
          if (FEditClass = deInteger) and (not (key in AllowedIntegerChars)) then begin
            Key := #0;
            exit;
          end;

          ClearKey();

          if IsDBCSLeadByte(Ord(Key)) or bDoubleByte then
          begin
            bDoubleByte := true;
            Inc(KeyByteCount);
            FInputStr := FInputStr + key;
          end;
          if (key in AllowedChars) then
          begin
            if not bDoubleByte then
            begin
              if (MaxLength > 0) and (Length(string(FEditString)) >= MaxLength) then
              begin
                Key := #0;
                exit;
              end;
              if FCaretPos <> Length(FEditString) then Insert(Key, FEditString, FCaretPos + 1)
              else FEditString := FEditString + Key;
              SetCursorPos(deRight);
            end
            else if KeyByteCount >= 2 then
            begin
              if FEditClass = deMonoCase then begin
                bDoubleByte := false;
                KeyByteCount := 0;
                FInputStr := '';
              end else begin
                if (MaxLength > 0) and (Length(string(FEditString)) >= (MaxLength - 1)) then
                begin
                  bDoubleByte := false;
                  KeyByteCount := 0;
                  FInputStr := '';
                  Key := #0;
                  exit;
                end;
                if FCaretPos <> Length(FEditString) then Insert(FInputStr, FEditString, FCaretPos + 1)
                else FEditString := FEditString + FInputStr;
                bDoubleByte := false;
                KeyByteCount := 0;
                FInputStr := '';
                SetCursorPos(deRight);
              end;
            end;

          end;
        end;
      end;
    end;
    Key := #0;
  end;
end;

function TDEdit.KeyUp(var Key: Word; Shift: TShiftState): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  if Background then exit;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).KeyUp(Key, Shift) then begin
        Result := TRUE;
        exit;
      end;    
  if (FocusedControl = self) then begin
    if (ssShift in Shift) then
    begin
      KeyDowned := False;
    end;
    if Assigned(FOnKeyUp) then FOnKeyUp(self, Key, Shift);
    Key := 0;
    Result := TRUE;
  end;
end;

function TDEdit.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  if Background then exit;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).KeyDown(Key, Shift) then begin
        Result := TRUE;
        exit;
      end;
  if (FocusedControl = self) then begin
    if (ssShift in Shift) and (not Downed) then
    begin
      KeyDowned := True;
      FCursor := deLeft;
      if FStartX < 0 then FStartX := FCaretPos;
    end else KeyDowned := False;
    case Key of
      VK_RIGHT:
        begin
          if not Downed then SetCursorPos(deRight);
          if (ssShift in Shift) then FStopX := FCaretPos
          else begin
            FStartX := -1;
            FStopX := -1;
            KeyDowned := False;
          end;
        end;
      VK_LEFT:
        begin
          if not Downed then SetCursorPos(deLeft);
          if (ssShift in Shift) then FStopX := FCaretPos
          else begin
            FStartX := -1;
            FStopX := -1;
            KeyDowned := False;
          end;
        end;
      VK_DELETE:
        begin
          if (not FReadOnly) and (not Downed) and (not KeyDowned) and (not ClearKey()) then
          begin
            Delete(FEditString, FCaretPos + 1, 1);
            FCaretPos := Min(FCaretPos, Length(FEditString));
          end;
        end;
    end;
    if Assigned(FOnKeyDown) then FOnKeyDown(self, Key, Shift);
    Result := TRUE;
    Key := 0;
  end;
end;

function TDEdit.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if Result and (MouseCaptureControl = self) then begin
    if Downed and (not KeyDowned) then MoveCaret(X - left, Y - top);
  end;
end;

function TDEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := FALSE;
  Downed := False;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if not Background then begin
      if InRange(X, Y) then begin
        if Assigned(FOnClick) then FOnClick(self, X, Y);
      end;
    end;
    Result := TRUE;
    exit;
  end else begin
    ReleaseDCapture;
  end;
end;

function TDEdit.ClearKey(): Boolean;
begin
  Result := False;
  if (FStartX > -1) and (FStopX > -1) and (FStartX <> FStopX) then
  begin
    if FStartX > FStopX then
    begin
      Delete(FEditString, FStopX + 1, FStartX - FStopX);
      FCaretPos := FStopX;
    end
    else
    begin
      Delete(FEditString, FStartX + 1, FStopX - FStartX);
      FCaretPos := FStartX;
    end;
    if FCaretPos < FCaretIdx then FCaretIdx := FCaretPos;
    FStartX := -1;
    FStopX := -1;
    FCursor := deLeft;
    Result := True;
  end;
end;

procedure TDEdit.MoveCaret(X, Y: Integer);
var
  i: Integer;
  temstr: WideString;
begin
  FCursor := deLeft;
  if Length(FEditString) > 0 then
  begin
    if (X <= Canvas.TextWidth('A')) and (FCaretIdx > 0) then Dec(FCaretIdx);
    for i := FCaretIdx to Length(FEditString) do
    begin
      temstr := Copy(FEditString, FCaretIdx, I - FCaretIdx + 1 + Integer(FCaretIdx <> 0));

      if Canvas.TextWidth(temstr) > X then
      begin
        while I <> FCaretPos do
        begin
          if I > FCaretPos then
          begin
            SetCursorPos(deRight)
          end else
          begin
            SetCursorPos(deLeft);
          end;
        end;
        if Downed or KeyDowned then FStopX := FCaretPos
        else FStartX := FCaretPos;
        exit;
      end;
    end;
    while Length(FEditString) <> FCaretPos do
    begin
      if Length(FEditString) > FCaretPos then
      begin
        SetCursorPos(deRight)
      end else
      begin
        SetCursorPos(deLeft);
      end;
    end;
    if Downed or KeyDowned then FStopX := FCaretPos
    else FStartX := FCaretPos;
  end;
end;

function TDEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl = nil) then begin
      FStartX := -1;
      FStopX := -1;
      KeyDowned := False;
      if (FocusedControl = self) then
      begin
        MoveCaret(X - left, Y - top);
      end;
      Downed := True;
      SetDCapture(self);
    end;
    Result := TRUE;
  end;
end;

procedure TDEdit.DirectPaint(dsurface: TDirectDrawSurface);
var
  dc, rc: TRect;
  nLeft: integer;
  d: TDirectDrawSurface;
  ShowStr: string;
  StopX, StartX, CaretIdx: Integer;
  OldColor,OldSize:Integer;
  OldName: String;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(self, dsurface)
  else begin
    d := nil;
    dc.Left := SurfaceX(Left);
    dc.Top := SurfaceY(Top);
    dc.Right := SurfaceX(left + Width);
    dc.Bottom := SurfaceY(top + Height);
    if WLib <> nil then d := WLib.Images[FaceIndex];
    if d <> nil then begin
      rc.Left := 0;
      rc.Top := 0;
      rc.Right := d.ClientRect.Right;
      rc.Bottom := d.ClientRect.Bottom;
      dsurface.StretchDraw(dc, rc, d, FALSE);
    end else begin
      dsurface.Canvas.Brush.Color := Color;
      dsurface.Canvas.Pen.Color := FrameColor;
      dsurface.Canvas.Pen.Style := psAlternate;
      dsurface.Canvas.RoundRect(dc.Left, dc.Top, dc.Right, dc.Bottom, 0, 0);
    end;
    if (GetTickCount - FCaretShowTime) > 500 then
    begin
      FCaretShowTime := GetTickCount;
      FCaretShow := not FCaretShow;
    end;
    nLeft := 0;
    with dsurface.Canvas do
    begin
      if FEditString <> '' then begin

        if (FStartX <> FStopX) and (FStopX >= 0) and (FStartX >= 0) then
        begin
          StopX := FStopX;
          StartX := FStartX;
          CaretIdx := FCaretIdx;
          SetBkMode(Handle, TRANSPARENT);
          Brush.Color := clBlue;
          dc.Top := SurfaceY(Top + 2);
          dc.Bottom := SurfaceY(top + Height - 2);
          if StartX > StopX then
          begin
            StartX := FStopX;
            StopX := FStartX;
          end;
          if StartX < CaretIdx then
          begin
            dc.Left := SurfaceX(Left + 3);
            ShowStr := Copy(FEditString, CaretIdx, StopX - CaretIdx + 1);
            dc.Right := dc.Left + Canvas.TextWidth(ShowStr);
          end
          else
          begin
            if FCaretIdx > 0 then
            begin
              ShowStr := Copy(FEditString, CaretIdx, StartX - CaretIdx + 1);
              dc.Left := SurfaceX(Left + 3) + Canvas.TextWidth(ShowStr);
            end
            else
            begin
              ShowStr := Copy(FEditString, CaretIdx, StartX - CaretIdx);
              dc.Left := SurfaceX(Left + 3) + Canvas.TextWidth(ShowStr);
            end;
            ShowStr := Copy(FEditString, StartX + 1, StopX - StartX);
            dc.Right := dc.Left + Canvas.TextWidth(ShowStr);
          end;
          dc.Right := MIN(dc.Right, SurfaceX(Left + Width - 5));
          FillRect(dc);
        end;
        SetBkMode(Handle, TRANSPARENT);
        OldColor := Font.Color;
        OldName := Font.Name;
        OldSize := Font.Size;
        Try

          Font.Color := self.Font.Color;
          Font.Name := self.Font.Name;
          Font.Size := self.Font.Size;
          dc.Left := SurfaceX(Left + 3);
          dc.Top := SurfaceY(Top);
          dc.Right := SurfaceX(left + Width - 5);
          dc.Bottom := SurfaceY(top + Height);
          if FCursor = deLeft then begin
            ShowStr := Copy(FEditString, FCaretIdx, Length(FEditString));
            TextRect(dc, ShowStr, [tfSingleLine, tfLeft, tfVerticalCenter]);
            if (FCaretIdx > 0) then nLeft := MIN(Canvas.TextWidth(Copy(FEditString, FCaretIdx, FCaretPos - FCaretIdx + 1)), Width - 7)
            else nLeft := MIN(Canvas.TextWidth(Copy(FEditString, FCaretIdx, FCaretPos - FCaretIdx)), Width - 7);
          end
          else
          begin
            ShowStr := copy(FEditString, 0, FCaretRight);
            TextRect(dc, ShowStr, [tfSingleLine, tfRight, tfVerticalCenter]);
            ShowStr := Copy(FEditString, FCaretPos + 1, FCaretRight - FCaretPos);
            nLeft := MIN(Width - 7 - Canvas.TextWidth(Copy(FEditString, FCaretPos + 1, FCaretRight - FCaretPos)), Width - 7);
          end;
        Finally
          Font.Color := OldColor;
          Font.Name := OldName;
          Font.Size := OldSize;
        End;
      end;
      if FCaretShow and (FocusedControl = Self) then
      begin
        //Brush.Color := clWhite;
        OldColor := Pen.Color;
        Pen.Color := clWhite;
        RoundRect(SurfaceX(nLeft + 3 + left), SurfaceY(Top + 2), SurfaceX(left + 5 + nLeft), SurfaceY(top + Height - 2), 0, 0);
        Pen.Color := OldColor;
      end;
      Release;
    end;
  end;
end;
{------------------------- TDGrid --------------------------}

constructor TDGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FColCount := 8;
  FRowCount := 5;
  FColWidth := 36;
  FRowHeight := 32;
  FOnGridSelect := nil;
  FOnGridMouseMove := nil;
  FOnGridPaint := nil;
end;

function TDGrid.GetColRow(x, y: integer; var acol, arow: integer): Boolean;
begin
  Result := FALSE;
  if InRange(x, y) then begin
    acol := (x - Left) div FColWidth;
    arow := (y - Top) div FRowHeight;
    Result := TRUE;
  end;
end;

function TDGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  acol, arow: integer;
begin
  Result := FALSE;
  if mbLeft = Button then begin
    if GetColRow(X, Y, acol, arow) then begin
      SelectCell.X := acol;
      SelectCell.Y := arow;
      DownPos.X := X;
      DownPos.Y := Y;
      SetDCapture(self);
      Result := TRUE;
    end;
  end;
end;

function TDGrid.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  acol, arow: integer;
begin
  Result := FALSE;
  if InRange(X, Y) then begin
    if GetColRow(X, Y, acol, arow) then begin
      if Assigned(FOnGridMouseMove) then
        FOnGridMouseMove(self, acol, arow, Shift);
    end;
    Result := TRUE;
  end;
end;

function TDGrid.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  acol, arow: integer;
begin
  Result := FALSE;
  if mbLeft = Button then begin
    if GetColRow(X, Y, acol, arow) then begin
      if (SelectCell.X = acol) and (SelectCell.Y = arow) then begin
        Col := acol;
        Row := arow;
        if Assigned(FOnGridSelect) then
          FOnGridSelect(self, acol, arow, Shift);
      end;
      Result := TRUE;
    end;
    ReleaseDCapture;
  end;
end;

function TDGrid.Click(X, Y: integer): Boolean;
//var
   //acol, arow: integer;
begin
  Result := FALSE;
  { if GetColRow (X, Y, acol, arow) then begin
      if Assigned (FOnGridSelect) then
         FOnGridSelect (self, acol, arow, []);
      Result := TRUE;
   end; }
end;

procedure TDGrid.DirectPaint(dsurface: TDirectDrawSurface);
var
  i, j: integer;
  rc: TRect;
begin
  if Assigned(FOnGridPaint) then
    for i := 0 to FRowCount - 1 do
      for j := 0 to FColCount - 1 do begin
        rc := Rect(Left + j * FColWidth, Top + i * FRowHeight, Left + j * (FColWidth + 1) - 1, Top + i * (FRowHeight + 1) - 1);
        if (SelectCell.Y = i) and (SelectCell.X = j) then
          FOnGridPaint(self, j, i, rc, [gdSelected], dsurface)
        else FOnGridPaint(self, j, i, rc, [], dsurface);
      end;
end;


{--------------------- TDWindown --------------------------}


constructor TDWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFloating := FALSE;
  FEnableFocus := TRUE;
  FFMovie := True;
  Width := 120;
  Height := 120;
end;

procedure TDWindow.SetVisible(flag: Boolean);
begin
  FVisible := flag;
  if Floating then begin
    if DParent <> nil then
      DParent.ChangeChildOrder(self);
  end;
end;

function TDWindow.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  al, at: integer;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if Result and FFloating and FFMovie and (MouseCaptureControl = self) then begin
    if (SpotX <> X) or (SpotY <> Y) then begin
      al := Left + (X - SpotX);
      at := Top + (Y - SpotY);
      if al + Width < WINLEFT then al := WINLEFT - Width;
      if al > WINRIGHT then al := WINRIGHT;
      if at + Height < WINTOP then at := WINTOP - Height;
      if at + Height > BOTTOMEDGE then at := BOTTOMEDGE - Height;
      Left := al;
      Top := at;
      SpotX := X;
      SpotY := Y;
    end;
  end;
end;

function TDWindow.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseDown(Button, Shift, X, Y);
  if Result then begin
    if Floating then begin
      if DParent <> nil then
        DParent.ChangeChildOrder(self);
    end;
    SpotX := X;
    SpotY := Y;
  end;
end;

function TDWindow.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseUp(Button, Shift, X, Y);
end;

procedure TDWindow.Show;
begin
  Visible := TRUE;
  if Floating then begin
    if DParent <> nil then
      DParent.ChangeChildOrder(self);
  end;
  if EnableFocus then SetDFocus(self);
end;

function TDWindow.ShowModal: integer;
begin
  Result := 0; //Jacky
  Visible := TRUE;
  ModalDWindow := self;
  if EnableFocus then SetDFocus(self);
end;


{--------------------- TDWinManager --------------------------}


constructor TDWinManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DWinList := TList.Create;
  MouseCaptureControl := nil;
  FocusedControl := nil;
end;

destructor TDWinManager.Destroy;
begin
  inherited Destroy;
end;

procedure TDWinManager.ClearAll;
begin
  DWinList.Clear;
end;

procedure TDWinManager.AddDControl(dcon: TDControl; visible: Boolean);
begin
  dcon.Visible := visible;
  DWinList.Add(dcon);
end;

procedure TDWinManager.DelDControl(dcon: TDControl);
var
  i: integer;
begin
  for i := 0 to DWinList.Count - 1 do
    if DWinList[i] = dcon then begin
      DWinList.Delete(i);
      break;
    end;
end;

function TDWinManager.KeyPress(var Key: Char): Boolean;
//var
//   i: integer;
begin
  Result := FALSE;
  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := KeyPress(Key);
      exit;
    end else
      ModalDWindow := nil;
    Key := #0; //ModalDWindow°¡ KeyDownÀ» °ÅÄ¡¸é¼­ Visible=false·Î º¯ÇÏ¸é¼­
             //KeyPress¸¦ ´Ù½Ã°ÅÃÄ¼­ ModalDwindow=nilÀÌ µÈ´Ù.
  end;

  if FocusedControl <> nil then begin
    if FocusedControl.Visible then begin
      Result := FocusedControl.KeyPress(Key);
    end else
      ReleaseDFocus;
  end;
   {for i:=0 to DWinList.Count-1 do begin
      if TDControl(DWinList[i]).Visible then begin
         if TDControl(DWinList[i]).KeyPress (Key) then begin
            Result := TRUE;
            break;
         end;
      end;
   end; }
end;

function TDWinManager.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
//var
//   i: integer;
begin
  Result := FALSE;
  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := KeyDown(Key, Shift);
      exit;
    end else MOdalDWindow := nil;
  end;
  if FocusedControl <> nil then begin
    if (FocusedControl.Visible) and (Key<>VK_F12) then //·ÀÖ¹Íâ¹Òºô²»³ö
      Result := FocusedControl.KeyDown(Key, Shift)
    else
      ReleaseDFocus;
  end;
   {for i:=0 to DWinList.Count-1 do begin
      if TDControl(DWinList[i]).Visible then begin
         if TDControl(DWinList[i]).KeyDown (Key, Shift) then begin
            Result := TRUE;
            break;
         end;
      end;
   end; }
end;

function TDWinManager.KeyUp(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := FALSE;
  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := KeyUp(Key, Shift);
      exit;
    end else MOdalDWindow := nil;
  end;
  if FocusedControl <> nil then begin
    if FocusedControl.Visible then
      Result := FocusedControl.KeyUp(Key, Shift)
    else
      ReleaseDFocus;
  end;
end;

function TDWinManager.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        MouseMove(Shift, LocalX(X), LocalY(Y));
      Result := TRUE;
      exit;
    end else MOdalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := MouseMove(Shift, LocalX(X), LocalY(Y));
  end else
    for i := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[i]).Visible then begin
        if TDControl(DWinList[i]).MouseMove(Shift, X, Y) then begin
          Result := TRUE;
          break;
        end;
      end;
    end;
end;

function TDWinManager.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        MouseDown(Button, Shift, LocalX(X), LocalY(Y));
      Result := TRUE;
      exit;
    end else ModalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := MouseDown(Button, Shift, LocalX(X), LocalY(Y));
  end else
    for i := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[i]).Visible then begin
        if TDControl(DWinList[i]).MouseDown(Button, Shift, X, Y) then begin
          Result := TRUE;
          break;
        end;
      end;
    end;
end;

function TDWinManager.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  i: integer;
begin
  Result := TRUE;
  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := MouseUp(Button, Shift, LocalX(X), LocalY(Y));
      exit;
    end else ModalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := MouseUp(Button, Shift, LocalX(X), LocalY(Y));
  end else
    for i := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[i]).Visible then begin
        if TDControl(DWinList[i]).MouseUp(Button, Shift, X, Y) then begin
          Result := TRUE;
          break;
        end;
      end;
    end;
end;

function TDWinManager.DblClick(X, Y: integer): Boolean;
var
  i: integer;
begin
  Result := TRUE;
  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := DblClick(LocalX(X), LocalY(Y));
      exit;
    end else ModalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := DblClick(LocalX(X), LocalY(Y));
  end else
    for i := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[i]).Visible then begin
        if TDControl(DWinList[i]).DblClick(X, Y) then begin
          Result := TRUE;
          break;
        end;
      end;
    end;
end;

function TDWinManager.Click(X, Y: integer): Boolean;
var
  i: integer;
begin
  Result := TRUE;
  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := Click(LocalX(X), LocalY(Y));
      exit;
    end else ModalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := Click(LocalX(X), LocalY(Y));
  end else
    for i := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[i]).Visible then begin
        if TDControl(DWinList[i]).Click(X, Y) then begin
          Result := TRUE;
          break;
        end;
      end;
    end;
end;

procedure TDWinManager.DirectPaint(dsurface: TDirectDrawSurface);
var
  i: integer;
begin
  for i := 0 to DWinList.Count - 1 do begin
    if TDControl(DWinList[i]).Visible then begin
      TDControl(DWinList[i]).DirectPaint(dsurface);
    end;
  end;
  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then
      with ModalDWindow do
        DirectPaint(dsurface);
  end;
end;

function MIN(n1, n2: integer): integer;
begin
  if n1 < n2 then Result := n1
  else Result := n2;
end;

function MAX(n1, n2: integer): integer;
begin
  if n1 > n2 then Result := n1
  else Result := n2;
end;

{ TDCheckBox }

constructor TDCheckBox.Create(AOwner: TComponent);
begin
  inherited;
  FChecked := False;
  FFontSpace := 3;
end;

procedure TDCheckBox.DirectPaint(dsurface: TDirectDrawSurface);
var
//  i: integer;
  d: TDirectDrawSurface;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(self, dsurface)
  else
    if WLib <> nil then begin
      if Checked then begin
        d := WLib.Images[FaceIndex + 1];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end else begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
      if d <> nil then begin
        with dsurface.Canvas do begin
          SetBkMode(Handle, TRANSPARENT);
          if MouseEntry = msIn then
            BoldTextOut(dsurface,
              SurfaceX(Left) + d.Width + FFontSpace,
              SurfaceY(Top) + d.Height div 2 - TextHeight(Caption) div 2,
              clWhite,
              clBlack,
              Caption)
          else
            BoldTextOut(dsurface,
              SurfaceX(Left) + d.Width + FFontSpace,
              SurfaceY(Top) + d.Height div 2 - TextHeight(Caption) div 2,
              clSilver,
              clBlack,
              Caption);
          Release;
        end;
      end;
    end;
end;

function TDCheckBox.InRange(x, y: integer): Boolean;
var
  boinrange: Boolean;
//  d: TDirectDrawSurface;
  nWidth, nHeight: Integer;
begin
  nWidth := CaptionWidth+FFontSpace;
  nHeight := CaptionHeight;
  if Enabled and (x >= Left) and (x < Left + nWidth) and (y >= Top) and (y < Top + nHeight) then begin
    boinrange := TRUE;
    if Assigned(FOnInRealArea) then
      FOnInRealArea(self, x - Left, y - Top, boinrange);
    Result := boinrange;
  end else
    Result := FALSE;
end;

function TDCheckBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if not Background then begin
      if InRange(X, Y) then begin
        FChecked := not FChecked;
        if Assigned(FOnClick) then FOnClick(self, X, Y);
      end;
    end;
    Downed := FALSE;
    Result := TRUE;
    exit;
  end else begin
    ReleaseDCapture;
    Downed := FALSE;
  end;
end;

procedure BoldTextOut(surface: TDirectDrawSurface; x, y, fcolor, bcolor: integer; str: string);
begin
  with surface do begin
    Canvas.Font.Color := bcolor;
    Canvas.TextOut(x - 1, y, str);
    Canvas.TextOut(x + 1, y, str);
    Canvas.TextOut(x, y - 1, str);
    Canvas.TextOut(x, y + 1, str);
    Canvas.Font.Color := fcolor;
    Canvas.TextOut(x, y, str);
  end;
end;

{ TDUpDown }

procedure TDUpDown.ButtonClick(Sender: TObject; X, Y: integer);
begin
  if Sender = FUpButton then begin
    if FPosition > 0 then Dec(FPosition);
  end else
  if Sender = FDownButton then begin
    if FPosition < FMaxPosition then Inc(FPosition);
  end;
  if Assigned(FOnPositionChange) then FOnPositionChange(Self);
end;

procedure TDUpDown.ButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if Sender = FUpButton then begin
    if FPosition > 0 then Dec(FPosition);
    if Assigned(FOnPositionChange) then FOnPositionChange(Self);
  end else
  if Sender = FDownButton then begin
    if FPosition < FMaxPosition then Inc(FPosition);
    if Assigned(FOnPositionChange) then FOnPositionChange(Self);
  end else
  if Sender = FMoveButton then begin
    StopY := FMoveButton.Top + FTop;
  end;
end;

procedure TDUpDown.ButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nIdx: Integer;
  OldPosition: Integer;
begin
  if StopY < 0 then Exit;
  
  OldPosition := Position;
  nIdx := Round((Y - FTop) / (FMaxLength / FMaxPosition));
  if nIdx <=0 then Position := 0
  else if nIdx >= FMaxPosition then Position := FMaxPosition
  else Position := nIdx;
  if OldPosition <> Position then
    if Assigned(FOnPositionChange) then FOnPositionChange(Self);
end;

procedure TDUpDown.ButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  StopY := -1;
end;

constructor TDUpDown.Create(AOwner: TComponent);
begin
  inherited;
  FUpButton := nil;
  FDownButton := nil;
  FMoveButton := nil;
  Position := 0;
  FMaxPosition := 0;
  FMaxLength := 0;
  FTop := 0;
  StopY := -1;
end;

procedure TDUpDown.DirectPaint(dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  dc, rc: TRect;
begin
  if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      dc.Left := SurfaceX(Left);
      dc.Top := SurfaceY(Top);
      dc.Right := SurfaceX(left + Width);
      dc.Bottom := SurfaceY(top + Height);
      rc.Left := 0;
      rc.Top := 0;
      rc.Right := d.ClientRect.Right;
      rc.Bottom := d.ClientRect.Bottom;
      dsurface.StretchDraw(dc, rc, d, FALSE);
    end;
    if FUpButton <> nil then begin
      with FUpButton do begin
        Left := 1;
        Top := 1;
        if not Downed then begin
          d := WLib.Images[FaceIndex];
          if d <> nil then begin
            FTop := d.Height + Top;
            dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
          end;
        end else begin
          d := WLib.Images[FaceIndex + 1];
          if d <> nil then begin
            FTop := d.Height + Top;
            dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
          end;
        end;
      end;
    end;
    if FDownButton <> nil then begin
      with FDownButton do begin
        Left := 1;
        Top := Self.Height - d.Height - 1;
        if not Downed then begin
          d := WLib.Images[FaceIndex];
          if d <> nil then begin
            FMaxLength := Top - FTop;
            dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
          end;
        end else begin
          d := WLib.Images[FaceIndex + 1];
          if d <> nil then begin
            FMaxLength := Top - FTop;
            dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
          end;
        end;
      end;
    end;
    if FMoveButton <> nil then begin
      with FMoveButton do begin
        Left := 1;
        d := WLib.Images[FaceIndex];
        if d <> nil then begin
          Dec(FMaxLength,d.Height);
          Top := FTop + Round(FMaxLength / FMaxPosition * Position);
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        end;
      end;
    end;
  end;
end;

procedure TDUpDown.SetDownButton(Button: TDButton);
begin
  if Button <> nil then begin
    FDownButton := Button;
    FDownButton.DParent := Self;
    FDownButton.OnMouseDown := ButtonMouseDown;
  end;
end;

procedure TDUpDown.SetMoveButton(Button: TDButton);
begin
  if Button <> nil then begin
    FMoveButton := Button;
    FMoveButton.DParent := Self;
    FMoveButton.OnMouseMove := ButtonMouseMove;
    FMoveButton.OnMouseDown := ButtonMouseDown;
    FMoveButton.OnMouseUp := ButtonMouseUp;
  end;
end;

procedure TDUpDown.SetUpButton(Button: TDButton);
begin
  if Button <> nil then begin
    FUpButton := Button;
    FUpButton.DParent := Self;
    FUpButton.OnMouseDown := ButtonMouseDown;
  end;
end;

{ TDComboBox }

constructor TDComboBox.Create(AOwner: TComponent);
begin
  inherited;

  FItem := TStringList.Create;
  ReadOnly := True;
  FShowCount := 5;
  FShowHeight := 18;
  FListIndex := 0;
end;

destructor TDComboBox.Destroy;
begin
  FItem.Free;
  inherited;
end;

procedure TDComboBox.DirectPaint(dsurface: TDirectDrawSurface);
var
  dc, rc: TRect;
//  nLeft: integer;
  d: TDirectDrawSurface;
  ShowStr: string;
//  StopX, StartX, CaretIdx: Integer;
  OldColor,OldSize,nLen,nHeight,nWidth,I:Integer;
//  nCount,nListCount: Integer;
  OldName: String;
  pts: array[0..2] of TPoint;
  //d: TDirectDrawSurfaceCanvas;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(self, dsurface)
  else begin
    d := nil;
    dc.Left := SurfaceX(Left);
    dc.Top := SurfaceY(Top);
    dc.Right := SurfaceX(left + Width);
    dc.Bottom := SurfaceY(top + Height);
    if WLib <> nil then d := WLib.Images[FaceIndex];
    if d <> nil then begin
      rc.Left := 0;
      rc.Top := 0;
      rc.Right := d.ClientRect.Right;
      rc.Bottom := d.ClientRect.Bottom;
      dsurface.StretchDraw(dc, rc, d, FALSE);
    end else begin
      dsurface.Canvas.Brush.Color := Color;
      dsurface.Canvas.Pen.Color := FrameColor;
      dsurface.Canvas.Pen.Style := psAlternate;
      dsurface.Canvas.RoundRect(dc.Left, dc.Top, dc.Right, dc.Bottom, 0, 0);
    end;
    if (GetTickCount - FCaretShowTime) > 500 then
    begin
      FCaretShowTime := GetTickCount;
      FCaretShow := not FCaretShow;
    end;
//    nLeft := 0;
    with dsurface.Canvas do
    begin
      if FEditString <> '' then begin
        SetBkMode(Handle, TRANSPARENT);
        OldColor := Font.Color;
        OldName := Font.Name;
        OldSize := Font.Size;
        Try
          Font.Color := self.Font.Color;
          Font.Name := self.Font.Name;
          Font.Size := self.Font.Size;
          dc.Left := SurfaceX(Left + 3);
          dc.Top := SurfaceY(Top);
          dc.Right := SurfaceX(left + Width - 5);
          dc.Bottom := SurfaceY(top + Height);
          ShowStr := FEditString;
          TextRect(dc, ShowStr, [tfSingleLine, tfLeft, tfVerticalCenter]);
        Finally
          Font.Color := OldColor;
          Font.Name := OldName;
          Font.Size := OldSize;
        End;
      end;
      dc.Left := SurfaceX(Left);
      dc.Top := SurfaceY(Top);
      dc.Right := SurfaceX(left + Width);
      dc.Bottom := SurfaceY(top + Height);
      dsurface.Canvas.Brush.Color := FrameColor;
      dsurface.Canvas.Pen.Color := FrameColor;
      dsurface.Canvas.Pen.Style := psAlternate;
      nLen := Height div 4;
      if Downed then begin
        nWidth := 5;
        nHeight := 0;
      end else begin
        nWidth := 6;
        nHeight := -1;
      end;
      pts[0].X := dc.Right - nWidth;
      pts[0].Y := dc.Top + Height div 2 - nLen div 2 + nHeight;
      pts[1].X := dc.Right - nLen - nWidth;
      pts[1].y := pts[0].Y;
      pts[2].X := dc.Right - nWidth - nLen div 2;
      pts[2].Y := pts[0].Y + nlen;
      Polygon(pts);
      if (FocusedControl = self) then begin
        Brush.Color := $000000;
        Pen.Color := $FFFFFF;
        Pen.Style := psAlternate;
        //nCount := MIN(FShowCount,MAX(FItem.Count,1));
        FListHeight := FItem.Count * FShowHeight;
        RoundRect(SurfaceX(Left),
          SurfaceY(top + Height),
          SurfaceX(left + Width),
          SurfaceY(top + Height + FListHeight), 0, 0);
        //nWidth := SurfaceX(Left) + 2;
        //nHeight := SurfaceY(top + Height) + FShowHeight div 2 - TextHeight('ÖÐ') div 2;
        OldColor := Font.Color;
        OldName := Font.Name;
        OldSize := Font.Size;
        dc.Left := SurfaceX(Left) + 2;
        dc.Right := dc.Left + Width - 4;
        dc.Top := SurfaceY(top + Height) + 1;
        dc.Bottom := dc.Top + FShowHeight - 2;
        Try
          Font.Color := self.Font.Color;
          Font.Name := self.Font.Name;
          Font.Size := self.Font.Size;
          SetBkMode(Handle, TRANSPARENT);
          {nListCount := MIN(FListIndex + nCount,FItem.Count - 1);
          if ((nListCount - FListIndex) < nCount) then
            FListIndex := MAX(nListCount - FListIndex,0);
          FUpDown.Visible := True;
          FUpDown.Left:= 0;
          FUpDown.Top := 0;  }

          for I := 0 to FItem.Count - 1 do begin
            ShowStr := FItem[i];
            if (SurfaceX(FX) >= dc.Left) and (SurfaceX(FX) < dc.Right) and (SurfaceY(FY) >= dc.Top) and (SurfaceY(FY) < dc.Bottom) then
            begin
              Brush.Color := clBlue;
              FillRect(dc);
              SetBkMode(Handle, TRANSPARENT);
            end;
            TextRect(dc, ShowStr, [tfSingleLine, tfLeft, tfVerticalCenter]);
            dc.Top := SurfaceY(top + Height) + 1 + FShowHeight  * (I + 1);
            dc.Bottom := dc.Top + FShowHeight - 2;
          end;
        Finally
          Font.Color := OldColor;
          Font.Name := OldName;
          Font.Size := OldSize;
        End;
      end;
      Release;
    end;
  end;
end;

function TDComboBox.InRange(x, y: integer): Boolean;
var
  inrange: Boolean;
  d: TDirectDrawSurface;
begin
  if Enabled and ((x >= Left) and (x < Left + Width) and (y >= Top) and (y < Top + Height) or
  (FocusedControl = self) and (x >= Left) and (x < Left + Width) and (y >= Top) and (y < Top + Height + FListHeight)) then begin
    inrange := TRUE;
    if Assigned(FOnInRealArea) then
      FOnInRealArea(self, x - Left, y - Top, inrange)
    else
      if WLib <> nil then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          if d.Pixels[x - Left, y - Top] <= 0 then
            inrange := FALSE;
      end;
    Result := inrange;
  end else
    Result := FALSE;
end;

function TDComboBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  i: Integer;
begin
  Result := inherited MouseDown(Button, Shift, X, Y);
  if Result and (FocusedControl = self) and (Y > Top + height) then begin
    i := (Y - Top - Height) div FShowHeight;
    if (I < FItem.Count) and (I >=0) then Text := FItem[I];
    FocusedControl := nil;
  end;
end;

function TDComboBox.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if Result and (FocusedControl = self) then begin
    FX := X;
    FY := Y;
  end;
end;

procedure TDComboBox.SetItem(const Value: TStrings);
begin
  if Assigned(FItem) then
    FItem.Assign(Value)
  else
    FItem := Value;
end;

procedure TDComboBox.SetShowCount(Value: Integer);
begin
  FShowCount := Value;
  FListHeight := FShowCount * FShowHeight;
end;

procedure TDComboBox.SetShowHeight(Value: Integer);
begin
  FShowHeight := Value;
  FListHeight := FShowCount * FShowHeight;
end;

procedure TDComboBox.SetUpDownButton(Button: TDUpDown);
begin
  FUpDown := Button;
  FUpDown.Visible := False;
  FUpDown.DParent := Self;
end;

{ TDHooKKey }

constructor TDHooKKey.Create(AOwner: TComponent);
begin
  inherited;
  FShiftState := [];
  FKey := 0;
  ReadOnly := True;
end;

procedure TDHooKKey.DirectPaint(dsurface: TDirectDrawSurface);
var
  dc, rc: TRect;
//  nLeft: integer;
  d: TDirectDrawSurface;
  ShowStr: string;
//  StopX, StartX, CaretIdx: Integer;
  OldColor,OldSize:Integer;
  //,nLen,nHeight,nWidth,I:Integer;
//  nCount,nListCount: Integer;
  OldName: String;
//  pts: array[0..2] of TPoint;
  //d: TDirectDrawSurfaceCanvas;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(self, dsurface)
  else begin
    d := nil;
    dc.Left := SurfaceX(Left);
    dc.Top := SurfaceY(Top);
    dc.Right := SurfaceX(left + Width);
    dc.Bottom := SurfaceY(top + Height);
    if WLib <> nil then d := WLib.Images[FaceIndex];
    if d <> nil then begin
      rc.Left := 0;
      rc.Top := 0;
      rc.Right := d.ClientRect.Right;
      rc.Bottom := d.ClientRect.Bottom;
      dsurface.StretchDraw(dc, rc, d, FALSE);
    end else begin
      dsurface.Canvas.Brush.Color := Color;
      dsurface.Canvas.Pen.Color := FrameColor;
      dsurface.Canvas.Pen.Style := psAlternate;
      dsurface.Canvas.RoundRect(dc.Left, dc.Top, dc.Right, dc.Bottom, 0, 0);
      if (FocusedControl = self) then begin
        dc.Left := SurfaceX(Left + 1);
        dc.Top := SurfaceY(Top + 1);
        dc.Right := SurfaceX(left + Width - 1);
        dc.Bottom := SurfaceY(top + Height - 1);
        dsurface.Canvas.RoundRect(dc.Left, dc.Top, dc.Right, dc.Bottom, 0, 0);
      end;
    end;
    with dsurface.Canvas do
    begin
      if FEditString <> '' then begin
        SetBkMode(Handle, TRANSPARENT);
        OldColor := Font.Color;
        OldName := Font.Name;
        OldSize := Font.Size;
        Try
          if (FocusedControl = self) then
            Font.Color :=clAqua
          else
           begin
            if Self.MouseEntry=msIn then
             Font.Color :=clYellow
            else
             if Self.Enabled then
                Font.Color := self.Font.Color
              else
                Font.Color := clSilver;
           end;
          Font.Name := self.Font.Name;
          Font.Size := self.Font.Size;
          dc.Left := SurfaceX(Left + 3);
          dc.Top := SurfaceY(Top);
          dc.Right := SurfaceX(left + Width - 5);
          dc.Bottom := SurfaceY(top + Height);
          ShowStr := FEditString;
          TextRect(dc, ShowStr, [tfSingleLine, tfCenter, tfVerticalCenter]);
        Finally
          Font.Color := OldColor;
          Font.Name := OldName;
          Font.Size := OldSize;
        End;
      end;
      Release;
    end;
  end;
end;

function TDHooKKey.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  if Background then exit;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).KeyDown(Key, Shift) then begin
        Result := TRUE;
        exit;
      end;
 if (FocusedControl = self) then begin
    FShiftState := Shift;
    FKey := Key;
    Key := 0;
    RefHookKeyStr();
    if Assigned(FOnKeyDown) then FOnKeyDown(self, FKey, FShiftState);
  end;
end;


procedure TDHooKKey.RefHookKeyStr;
var
  ShowStr: string;
begin
  ShowStr := '';
  if ssCtrl in FShiftState then
    ShowStr := 'Ctrl';

  if ssAlt in FShiftState then
    if ShowStr <>'' then ShowStr := ShowStr + '+Alt'
    else ShowStr := 'Alt';

  if ssShift in FShiftState then
    if ShowStr <>'' then ShowStr := ShowStr + '+Shift'
    else ShowStr := 'Shift';

    Case FKey Of
      VK_F1:
       begin
           if ShowStr <>'' then
              ShowStr := ShowStr + '+F1'
           else
               ShowStr := 'F1';
       end;
      VK_F2:
       begin
           if ShowStr <>'' then
              ShowStr := ShowStr + '+F2'
           else
               ShowStr := 'F2';
       end;
      VK_F3:
       begin
           if ShowStr <>'' then
              ShowStr := ShowStr + '+F3'
           else
               ShowStr := 'F3';
       end;
      VK_F4:
       begin
           if ShowStr <>'' then
              ShowStr := ShowStr + '+F4'
           else
               ShowStr := 'F4';
       end;
      VK_F5:
       begin
           if ShowStr <>'' then
              ShowStr := ShowStr + '+F5'
           else
               ShowStr := 'F5';
       end;
      VK_F6:
       begin
           if ShowStr <>'' then
              ShowStr := ShowStr + '+F6'
           else
               ShowStr :='F6';
       end;
      VK_F7:
       begin
           if ShowStr <>'' then
              ShowStr := ShowStr + '+F7'
           else
               ShowStr := 'F7';
       end;
      VK_F8:
       begin
           if ShowStr <>'' then
              ShowStr := ShowStr + '+F8'
           else
               ShowStr :='F8';
       end;
      VK_F9:
       begin
           if ShowStr <>'' then
              ShowStr := ShowStr + '+F9'
           else
               ShowStr := 'F9';
       end;
      VK_F10:
       begin
           if ShowStr <>'' then
              ShowStr := ShowStr + '+F10'
           else
               ShowStr := 'F10';
       end;
      VK_F11:
      begin
           if ShowStr <>'' then
              ShowStr := ShowStr + '+F11'
           else
               ShowStr := 'F11';
       end;
     else
     begin
         if not (FKey in [16,17,18]) then
          if ShowStr <>'' then
           ShowStr := ShowStr + '+' + Char(FKey)
          else
           ShowStr := Char(FKey);
     end;  
    End;
  Text := ShowStr;
end;

procedure TDHooKKey.SetKey(Key: Word; Shift: TShiftState);
begin
  FShiftState:= Shift;
  FKey:=Key;
  RefHookKeyStr
end;

end.

