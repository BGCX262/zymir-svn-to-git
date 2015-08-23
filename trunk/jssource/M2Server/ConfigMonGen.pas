//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit ConfigMonGen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmConfigMonGen = class(TForm)
    ListBoxMonGen: TListBox;
  private
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmConfigMonGen: TfrmConfigMonGen;

implementation

uses UsrEngn, M2Share, Grobal2;

{$R *.dfm}

{ TfrmConfigMonGen }

procedure TfrmConfigMonGen.Open;
var
  I: Integer;
  MonGen:pTMonGenInfo;
begin
Try
  for I := 0 to UserEngine.m_MonGenList.Count - 1 do begin
    MonGen:=UserEngine.m_MonGenList.Items[I];
    ListBoxMonGen.Items.AddObject(MonGen.sMapName + '(' + IntToStr(MonGen.nX) + ':' + IntToStr(MonGen.nY) + ')' + ' - ' + MonGen.sMonName + '(' + IntToStr(UserEngine.GetGenMonCount(MonGen)) + ')',TObject(MonGen));
  end;
  Self.ShowModal;
Except 
  MainOutMessage('[Exception] TfrmConfigMonGen.Open');
End; 
end;

end.
