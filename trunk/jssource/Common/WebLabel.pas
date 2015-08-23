unit WebLabel;

interface

uses
  SysUtils,Messages,Windows, Classes, Controls, StdCtrls,Graphics;

type
  TWebLabel = class(TCustomLabel)
    procedure MouseEnter(Sender: TObject);
    procedure MouseLeave(Sender: TObject);
  private
    //FHotColor: TColor;
    //procedure SetHotColor(Value: TColor);
    //procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    //procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Caption;
    property Color nodefault;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Transparent;
    property Layout;
    property Visible;
    property WordWrap;
    //property HotColor: TColor read FHotColor write SetHotColor;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure Register;

implementation

constructor TWebLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Cursor:=crHandPoint;
  OnMouseEnter:=MouseEnter;
  OnMouseLeave:=MouseLeave;
  //Font.Color:=clBlack;
  //FHotColor:=clRed;
end;

procedure TWebLabel.MouseEnter(Sender: TObject);
begin
  Font.Color:=clRed;
end;

procedure TWebLabel.MouseLeave(Sender: TObject);
begin
  Font.Color:=clBlack;
end;

{procedure TWebLabel.SetHotColor(Value: TColor);
begin
  if FHotColor <> Value then FHotColor := Value;
end;  }

{procedure TWebLabel.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  Font.Color:=clRed;     //crHandPoint
  self.onmou
end;

procedure TWebLabel.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  Font.Color:=clBlack;
end;  }

procedure Register;
begin
  RegisterComponents('Standard', [TWebLabel]);
end;

end.
