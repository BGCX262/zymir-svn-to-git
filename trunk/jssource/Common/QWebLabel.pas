unit QWebLabel;

interface

uses
  SysUtils, Classes, QControls, QStdCtrls;

type
  TWebLabel = class(TCustomLabel)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property Bitmap;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property Masked;
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
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseUp;
    property OnStartDrag;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Standard', [TWebLabel]);
end;

end.
