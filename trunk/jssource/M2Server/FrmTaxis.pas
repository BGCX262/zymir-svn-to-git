//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit FrmTaxis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls;

type
  TFormTaxis = class(TForm)
    PageTaxis: TPageControl;
    TabSheet1: TTabSheet;
    PageTaxisSelf: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    SelfListView: TListView;
    TabSheet2: TTabSheet;
    PageTaxisHero: TPageControl;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    HeroListView: TListView;
    TabSheet3: TTabSheet;
    MasterListView: TListView;
    procedure PageTaxisChange(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open;
  end;

var
  FormTaxis: TFormTaxis;

implementation
uses
  grobal2, M2Share;

{$R *.dfm}

procedure TFormTaxis.Open;
begin
  try
    PageTaxis.TabIndex := 0;
    PageTaxisSelf.TabIndex := 0;
    PageTaxisChange(nil);
    ShowModal;
  except
    MainOutMessage('[Exception] TFormTaxis.Open');
  end;
end;

procedure TFormTaxis.PageTaxisChange(Sender: TObject);
  procedure ShowList(List: TListView; Taxis: THumSort);
  var
    i: integer;
    Temp: TListItem;
  begin
    for I := 0 to Taxis.nMaxIdx - 1 do
    begin
      Temp := List.Items.Add;
      Temp.Caption := IntToStr(Taxis.List[I].nTop);
      Temp.SubItems.Add(Taxis.List[I].sName);
      Temp.SubItems.Add(IntToStr(Taxis.List[I].nLevel));
    end;
  end;

  procedure ShowHeroList(List: TListView; Taxis: THeroSort);
  var
    i: integer;
    Temp: TListItem;
  begin
    for I := 0 to Taxis.nMaxIdx - 1 do
    begin
      Temp := List.Items.Add;
      Temp.Caption := IntToStr(Taxis.List[I].nTop);
      Temp.SubItems.Add(Taxis.List[I].sName);
      Temp.SubItems.Add(Taxis.List[I].sHeroName);
      Temp.SubItems.Add(IntToStr(Taxis.List[I].nLevel));
    end;
  end;
begin
  try
    SelfListView.Visible := False;
    HeroListView.Visible := False;
    MasterListView.Visible := False;
    SelfListView.Items.Clear;
    HeroListView.Items.Clear;
    MasterListView.Items.Clear;
    case PageTaxis.TabIndex of
      0:
        begin
          case PageTaxisSelf.TabIndex of
            0: ShowList(SelfListView, g_TaxisAllList);
            1: ShowList(SelfListView, g_TaxisWarrList);
            2: ShowList(SelfListView, g_TaxisWaidList);
            3: ShowList(SelfListView, g_TaxisTaosList);
          end;
        end;
      1:
        begin
          case PageTaxisHero.TabIndex of
            0: ShowHeroList(HeroListView, g_HeroAllList);
            1: ShowHeroList(HeroListView, g_HeroWarrList);
            2: ShowHeroList(HeroListView, g_HeroWaidList);
            3: ShowHeroList(HeroListView, g_HeroTaosList);
          end;
        end;
      2:
        begin
          ShowList(MasterListView, g_MasterList);
        end;
    end;
    SelfListView.Visible := True;
    HeroListView.Visible := True;
    MasterListView.Visible := True;
  except
    MainOutMessage('[Exception] TFormTaxis.PageTaxisChange');
  end;
end;

end.

