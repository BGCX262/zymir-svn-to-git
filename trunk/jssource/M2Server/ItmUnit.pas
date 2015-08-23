//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit ItmUnit;

interface
uses
  Windows, Classes, SysUtils, Grobal2, Mudutil, SDK;
type
  TItemUnit = class
  public
    m_ItemNameList: TGList;
    constructor Create();
    destructor Destroy; override;

    function LoadCustomItemName(): Boolean;
    function SaveCustomItemName(): Boolean;
    function AddCustomItemName(nMakeIndex, nItemIndex: Integer; sItemName:
      string): Boolean;
    function DelCustomItemName(nMakeIndex, nItemIndex: Integer): Boolean;
    function GetCustomItemName(nMakeIndex, nItemIndex: Integer): string;
    procedure Lock();
    procedure UnLock();
  end;

  TItem = class
  public
    ItemType: Word;
    Name: string[20];
    StdMode: Word;
    Shape: Word;
    Weight: Word;
    AniCount: Word;
    Source: Shortint;
    Reserved: Byte;
    NeedIdentify: Word;
    Looks: Word;
    DuraMax: DWord;
    AC, AC2: Word;
    MAC, MAC2: Word;
    DC, DC2: Word;
    MC, MC2: Word;
    SC, SC2: Word;
    Need: DWord;
    NeedLevel: DWord;
    Price: UINT;
    HeroPick: Byte;
    LevelItem: Byte;
    SellOff: Byte;
    DieDisap: Byte;
    GhostDisap: Byte;
    SuitIdx: array[0..100] of Byte;
    nRule: array[0..17] of Boolean;
    sDesc: string[40];
    nHero: Byte;

    //New Fields
    //Undead:Shortint;
    Light: Boolean;
    //Unique:Boolean;

  private
    function GetRandomRange(nCount, nRate: Integer): Integer;

  public
    constructor Create();
    destructor Destroy; override;

    procedure GetStandardItem(var StdItem: TStdItem);
    procedure GetItemAddValue(UserItem: pTUserItem; var StdItem: TStdItem);
    //function  GetCustomName(UserItem:pTUserItem):String;
    procedure ApplyItemParameters(var AddAbility: TAddAbility; UserItem:
      pTUserItem);
    procedure RandomUpgradeItem(UserItem: pTUserItem);
    procedure RandomUpgradeUnknownItem(UserItem: pTUserItem);
  end;

function GetItemName(UserItem: pTUserItem): string;
procedure GetMapItemInfo(UserItem: pTUserItem; var StdItem: TStdItem);

implementation

uses HUtil32, M2Share, Envir;

{ TItem }

constructor TItem.Create;
begin
  try
    inherited;
  except
    MainOutMessage('[Exception] TItem.Create');
  end;
end;

destructor TItem.Destroy;
begin
  try
    inherited;
  except
    MainOutMessage('[Exception] TItem.Destroy');
  end;
end;

function TItem.GetRandomRange(nCount, nRate: Integer): Integer;
var
  I: Integer;
begin
  try
    Result := 0;
    for I := 0 to nCount - 1 do
      if Random(nRate) = 0 then
        Inc(Result);
  except
    MainOutMessage('[Exception] TItem.GetRandomRange');
  end;
end;

procedure TItem.GetStandardItem(var StdItem: TStdItem);
begin
  try
    StdItem.Name := Name {FilterShowName(Name)};

    StdItem.StdMode := StdMode;
    StdItem.Shape := Shape;
    StdItem.Weight := Weight;
    StdItem.AniCount := AniCount;
    StdItem.Reserved := Reserved;
    StdItem.Source := Source;
    StdItem.NeedIdentify := NeedIdentify;
    StdItem.Looks := Looks;
    StdItem.DuraMax := DuraMax;
    StdItem.Need := Need;
    StdItem.NeedLevel := NeedLevel;
    StdItem.Price := Price;

    StdItem.AC := MakeLong(AC, AC2);
    StdItem.MAC := MakeLong(MAC, MAC2);
    StdItem.DC := MakeLong(DC, DC2);
    StdItem.MC := MakeLong(MC, MC2);
    StdItem.SC := MakeLong(SC, SC2);
  except
    MainOutMessage('[Exception] TItem.GetStandardItem');
  end;
end;

procedure TItem.GetItemAddValue(UserItem: pTUserItem; var StdItem: TStdItem);
begin
  try
    case ItemType of
      ITEM_WEAPON:
        begin
          StdItem.DC := MakeLong(DC, DC2 + UserItem.btValue[0]);
          StdItem.MC := MakeLong(MC, MC2 + UserItem.btValue[1]);
          StdItem.SC := MakeLong(SC, SC2 + UserItem.btValue[2]);
          StdItem.AC := MakeLong(AC + UserItem.btValue[3], AC2 +
            UserItem.btValue[5]);
          StdItem.MAC := MakeLong(MAC + UserItem.btValue[4], MAC2 +
            UserItem.btValue[6]);
          StdItem.AniCount := UserItem.btValue[14];
          if Byte(UserItem.btValue[7] - 1) < 10 then
          begin //Holy
            StdItem.Source := UserItem.btValue[7];
          end;
          if UserItem.btValue[10] <> 0 then
            StdItem.Reserved := StdItem.Reserved or 1;
        end;
      ITEM_ARMOR:
        begin
          StdItem.AC := MakeLong(AC, AC2 + UserItem.btValue[0]);
          StdItem.MAC := MakeLong(MAC, MAC2 + UserItem.btValue[1]);
          StdItem.DC := MakeLong(DC, DC2 + UserItem.btValue[2]);
          StdItem.MC := MakeLong(MC, MC2 + UserItem.btValue[3]);
          StdItem.SC := MakeLong(SC, SC2 + UserItem.btValue[4]);
          if (StdItem.Shape = 126) or
          (StdItem.Shape = 127) or
          (StdItem.Shape = 128) or
          (StdItem.Shape = 129) then
             StdItem.Reserved := UserItem.btValue[14]
            else
             StdItem.Reserved :=StdItem.Reserved+UserItem.btValue[14]
        end;
      ITEM_ACCESSORY:
        begin
          StdItem.AC := MakeLong(AC, AC2 + UserItem.btValue[0]);
          StdItem.MAC := MakeLong(MAC, MAC2 + UserItem.btValue[1]);
          StdItem.DC := MakeLong(DC, DC2 + UserItem.btValue[2]);
          StdItem.MC := MakeLong(MC, MC2 + UserItem.btValue[3]);
          StdItem.SC := MakeLong(SC, SC2 + UserItem.btValue[4]);
          //StdItem.Reserved :=UserItem.btValue[14];
          StdItem.Reserved :=StdItem.Reserved+UserItem.btValue[14];
          if UserItem.btValue[5] > 0 then
          begin
            StdItem.Need := UserItem.btValue[5];
          end;
          if UserItem.btValue[6] > 0 then
          begin
            StdItem.NeedLevel := UserItem.btValue[6];
          end;
        end;
      ITEM_LEECHDOM:
        begin
          StdItem.AC := MakeLong(AC, AC2);
          StdItem.MAC := MakeLong(MAC, MAC2);
          StdItem.DC := MakeLong(DC, DC2);
          StdItem.MC := MakeLong(MC, MC2);
          StdItem.SC := MakeLong(SC, SC2);
        end;
     ITEM_Wine:
        begin
          StdItem.AC := MakeLong(AC, AC2 + UserItem.btValue[0]);
          StdItem.MAC := MakeLong(MAC, MAC2 + UserItem.btValue[1]);
          StdItem.DC := MakeLong(DC, DC2 + UserItem.btValue[2]);
          StdItem.MC := MakeLong(MC, MC2 + UserItem.btValue[3]);
          StdItem.SC := MakeLong(SC, SC2 + UserItem.btValue[4]);
       //   StdItem.Need :=Need+ UserItem.btValue[5];//药力
        //  StdItem.NeedLevel := UserItem.btValue[6];
          StdItem.Source := Source+UserItem.btValue[7];//品质
          StdItem.Reserved:=Reserved+UserItem.btValue[10]; //酒精度
        end
    else
      begin
      {  StdItem.AC := 0;
        StdItem.MAC := 0;
        StdItem.DC := 0;
        StdItem.MC := 0;
        StdItem.SC := 0;
        StdItem.Source := 0;
        StdItem.Reserved := 0;}
      end;
    end;
  except
    MainOutMessage('[Exception] TItem.GetItemAddValue');
  end;
end;

{function TItem.GetCustomName(UserItem:pTUserItem):String;
begin
  if (UserItem<>nil) then begin
    if (UserItem.sCustomName<>'') then Result:=UserItem.sCustomName;
  end else
    Result := Name;
end;}

procedure TItem.RandomUpgradeItem(UserItem: pTUserItem);
var
  nUpgrade, nIncp, nVal: Integer;
begin
  try
    case ItemType of
      ITEM_WEAPON:
        begin
          nUpgrade := GetRandomRange(g_Config.nWeaponDCAddValueMaxLimit {12},
            g_Config.nWeaponDCAddValueRate {15});
          if Random(15) = 0 then
            UserItem.btValue[0] := nUpgrade + 1;

          nUpgrade := GetRandomRange(12, 15);
          if Random(20) = 0 then
          begin
            nIncp := (nUpgrade + 1) div 3;
            if nIncp > 0 then
            begin
              if Random(3) <> 0 then
              begin
                UserItem.btValue[6] := nIncp;
              end
              else
              begin
                UserItem.btValue[6] := nIncp + 10;
              end;
            end;
          end;

          nUpgrade := GetRandomRange(12, 15);
          if Random(15) = 0 then
            UserItem.btValue[1] := nUpgrade + 1;
          nUpgrade := GetRandomRange(12, 15);
          if Random(15) = 0 then
            UserItem.btValue[2] := nUpgrade + 1;
          nUpgrade := GetRandomRange(12, 15);
          if Random(24) = 0 then
          begin
            UserItem.btValue[5] := nUpgrade div 2 + 1;
          end;
          nUpgrade := GetRandomRange(12, 12);
          if Random(3) < 2 then
          begin
            nVal := (nUpgrade + 1) * 2000;
            UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nVal);
            UserItem.Dura := _MIN(65000, UserItem.Dura + nVal);
          end;
          nUpgrade := GetRandomRange(12, 15);
          if Random(10) = 0 then
          begin
            UserItem.btValue[7] := nUpgrade div 2 + 1;
          end;
        end;
      ITEM_ARMOR:
        begin
          nUpgrade := GetRandomRange(6, 15);
          if Random(30) = 0 then
            UserItem.btValue[0] := nUpgrade + 1;
          nUpgrade := GetRandomRange(6, 15);
          if Random(30) = 0 then
            UserItem.btValue[1] := nUpgrade + 1;

          nUpgrade := GetRandomRange(g_Config.nDressDCAddValueMaxLimit {6},
            g_Config.nDressDCAddValueRate {20});
          if Random(g_Config.nDressDCAddRate {40}) = 0 then
            UserItem.btValue[2] := nUpgrade + 1;
          nUpgrade := GetRandomRange(g_Config.nDressMCAddValueMaxLimit {6},
            g_Config.nDressMCAddValueRate {20});
          if Random(g_Config.nDressMCAddRate {40}) = 0 then
            UserItem.btValue[3] := nUpgrade + 1;
          nUpgrade := GetRandomRange(g_Config.nDressSCAddValueMaxLimit {6},
            g_Config.nDressSCAddValueRate {20});
          if Random(g_Config.nDressSCAddRate {40}) = 0 then
            UserItem.btValue[4] := nUpgrade + 1;

          nUpgrade := GetRandomRange(6, 10);
          if Random(8) < 6 then
          begin
            nVal := (nUpgrade + 1) * 2000;
            UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nVal);
            UserItem.Dura := _MIN(65000, UserItem.Dura + nVal);
          end;
        end;
      ITEM_ACCESSORY:
        begin
          case StdMode of
            20, 21, 24:
              begin
                nUpgrade := GetRandomRange(6, 30);
                if Random(60) = 0 then
                  UserItem.btValue[0] := nUpgrade + 1;
                nUpgrade := GetRandomRange(6, 30);
                if Random(60) = 0 then
                  UserItem.btValue[1] := nUpgrade + 1;
                nUpgrade :=
                  GetRandomRange(g_Config.nNeckLace202124DCAddValueMaxLimit {6},
                  g_Config.nNeckLace202124DCAddValueRate {20});
                if Random(g_Config.nNeckLace202124DCAddRate {30}) = 0 then
                  UserItem.btValue[2] := nUpgrade + 1;
                nUpgrade :=
                  GetRandomRange(g_Config.nNeckLace202124MCAddValueMaxLimit {6},
                  g_Config.nNeckLace202124MCAddValueRate {20});
                if Random(g_Config.nNeckLace202124MCAddRate {30}) = 0 then
                  UserItem.btValue[3] := nUpgrade + 1;
                nUpgrade :=
                  GetRandomRange(g_Config.nNeckLace202124SCAddValueMaxLimit {6},
                  g_Config.nNeckLace202124SCAddValueRate {20});
                if Random(g_Config.nNeckLace202124SCAddRate {30}) = 0 then
                  UserItem.btValue[4] := nUpgrade + 1;
                nUpgrade := GetRandomRange(6, 12);
                if Random(20) < 15 then
                begin
                  nVal := (nUpgrade + 1) * 1000;
                  UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nVal);
                  UserItem.Dura := _MIN(65000, UserItem.Dura + nVal);
                end;
              end;
            26:
              begin
                nUpgrade := GetRandomRange(6, 20);
                if Random(20) = 0 then
                  UserItem.btValue[0] := nUpgrade + 1;
                nUpgrade := GetRandomRange(6, 20);
                if Random(20) = 0 then
                  UserItem.btValue[1] := nUpgrade + 1;
                nUpgrade := GetRandomRange(g_Config.nArmRing26DCAddValueMaxLimit
                  {6}, g_Config.nArmRing26DCAddValueRate {20});
                if Random(g_Config.nArmRing26DCAddRate {30}) = 0 then
                  UserItem.btValue[2] := nUpgrade + 1;
                nUpgrade := GetRandomRange(g_Config.nArmRing26MCAddValueMaxLimit
                  {6}, g_Config.nArmRing26MCAddValueRate {20});
                if Random(g_Config.nArmRing26MCAddRate {30}) = 0 then
                  UserItem.btValue[3] := nUpgrade + 1;
                nUpgrade := GetRandomRange(g_Config.nArmRing26SCAddValueMaxLimit
                  {6}, g_Config.nArmRing26SCAddValueRate {20});
                if Random(g_Config.nArmRing26SCAddRate {30}) = 0 then
                  UserItem.btValue[4] := nUpgrade + 1;
                nUpgrade := GetRandomRange(6, 12);
                if Random(20) < 15 then
                begin
                  nVal := (nUpgrade + 1) * 1000;
                  UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nVal);
                  UserItem.Dura := _MIN(65000, UserItem.Dura + nVal);
                end;
              end;
            19:
              begin
                nUpgrade := GetRandomRange(6, 20);
                if Random(40) = 0 then
                  UserItem.btValue[0] := nUpgrade + 1;
                nUpgrade := GetRandomRange(6, 20);
                if Random(40) = 0 then
                  UserItem.btValue[1] := nUpgrade + 1;

                nUpgrade := GetRandomRange(g_Config.nNeckLace19DCAddValueMaxLimit
                  {6}, g_Config.nNeckLace19DCAddValueRate {20});
                if Random(g_Config.nNeckLace19DCAddRate {30}) = 0 then
                  UserItem.btValue[2] := nUpgrade + 1;
                nUpgrade := GetRandomRange(g_Config.nNeckLace19MCAddValueMaxLimit
                  {6}, g_Config.nNeckLace19MCAddValueRate {20});
                if Random(g_Config.nNeckLace19MCAddRate {30}) = 0 then
                  UserItem.btValue[3] := nUpgrade + 1;
                nUpgrade := GetRandomRange(g_Config.nNeckLace19SCAddValueMaxLimit
                  {6}, g_Config.nNeckLace19SCAddValueRate {20});
                if Random(g_Config.nNeckLace19SCAddRate {30}) = 0 then
                  UserItem.btValue[4] := nUpgrade + 1;
                nUpgrade := GetRandomRange(6, 10);
                if Random(4) < 3 then
                begin
                  nVal := (nUpgrade + 1) * 1000;
                  UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nVal);
                  UserItem.Dura := _MIN(65000, UserItem.Dura + nVal);
                end;
              end;
            22:
              begin
                nUpgrade := GetRandomRange(g_Config.nRing22DCAddValueMaxLimit
                  {6}, g_Config.nRing22DCAddValueRate {20});
                if Random(g_Config.nRing22DCAddRate {30}) = 0 then
                  UserItem.btValue[2] := nUpgrade + 1;
                nUpgrade := GetRandomRange(g_Config.nRing22MCAddValueMaxLimit
                  {6}, g_Config.nRing22MCAddValueRate {20});
                if Random(g_Config.nRing22MCAddRate {30}) = 0 then
                  UserItem.btValue[3] := nUpgrade + 1;
                nUpgrade := GetRandomRange(g_Config.nRing22SCAddValueMaxLimit
                  {6}, g_Config.nRing22SCAddValueRate {20});
                if Random(g_Config.nRing22SCAddRate {30}) = 0 then
                  UserItem.btValue[4] := nUpgrade + 1;
                nUpgrade := GetRandomRange(6, 12);
                if Random(4) < 3 then
                begin
                  nVal := (nUpgrade + 1) * 1000;
                  UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nVal);
                  UserItem.Dura := _MIN(65000, UserItem.Dura + nVal);
                end;
              end;
            23:
              begin
                nUpgrade := GetRandomRange(6, 20);
                if Random(40) = 0 then
                  UserItem.btValue[0] := nUpgrade + 1;
                nUpgrade := GetRandomRange(6, 20);
                if Random(40) = 0 then
                  UserItem.btValue[1] := nUpgrade + 1;
                nUpgrade := GetRandomRange(g_Config.nRing23DCAddValueMaxLimit
                  {6}, g_Config.nRing23DCAddValueRate {20});
                if Random(g_Config.nRing23DCAddRate {30}) = 0 then
                  UserItem.btValue[2] := nUpgrade + 1;
                nUpgrade := GetRandomRange(g_Config.nRing23MCAddValueMaxLimit
                  {6}, g_Config.nRing23MCAddValueRate {20});
                if Random(g_Config.nRing23MCAddRate {30}) = 0 then
                  UserItem.btValue[3] := nUpgrade + 1;
                nUpgrade := GetRandomRange(g_Config.nRing23SCAddValueMaxLimit
                  {6}, g_Config.nRing23SCAddValueRate {20});
                if Random(g_Config.nRing23SCAddRate {30}) = 0 then
                  UserItem.btValue[4] := nUpgrade + 1;
                nUpgrade := GetRandomRange(6, 12);
                if Random(4) < 3 then
                begin
                  nVal := (nUpgrade + 1) * 1000;
                  UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nVal);
                  UserItem.Dura := _MIN(65000, UserItem.Dura + nVal);
                end;
              end;
            15:
              begin
                nUpgrade := GetRandomRange(6, 20);
                if Random(40) = 0 then
                  UserItem.btValue[0] := nUpgrade + 1;
                nUpgrade := GetRandomRange(6, 20);
                if Random(30) = 0 then
                  UserItem.btValue[1] := nUpgrade + 1;
                nUpgrade := GetRandomRange(g_Config.nHelMetDCAddValueMaxLimit
                  {6}, g_Config.nHelMetDCAddValueRate {20});
                if Random(g_Config.nHelMetDCAddRate {30}) = 0 then
                  UserItem.btValue[2] := nUpgrade + 1;
                nUpgrade := GetRandomRange(g_Config.nHelMetMCAddValueMaxLimit
                  {6}, g_Config.nHelMetMCAddValueRate {20});
                if Random(g_Config.nHelMetMCAddRate {30}) = 0 then
                  UserItem.btValue[3] := nUpgrade + 1;
                nUpgrade := GetRandomRange(g_Config.nHelMetSCAddValueMaxLimit
                  {6}, g_Config.nHelMetSCAddValueRate {20});
                if Random(g_Config.nHelMetSCAddRate {30}) = 0 then
                  UserItem.btValue[4] := nUpgrade + 1;
                nUpgrade := GetRandomRange(6, 12);
                if Random(4) < 3 then
                begin
                  nVal := (nUpgrade + 1) * 1000;
                  UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nVal);
                  UserItem.Dura := _MIN(65000, UserItem.Dura + nVal);
                end;
              end;
          end;
        end;
    end;
  except
    MainOutMessage('[Exception] TItem.RandomUpgradeItem');
  end;
end;

procedure TItem.RandomUpgradeUnknownItem(UserItem: pTUserItem);
var
  nUpgrade, nRandPoint, nVal: Integer;
begin
  try
    case ItemType of
      ITEM_WEAPON:
        begin

        end;
      ITEM_ARMOR:
        begin

        end;
      ITEM_ACCESSORY:
        begin
          case StdMode of
            15:
              begin
                nRandPoint := {GetRandomRange(4,3) + GetRandomRange(4,8) + }
                  GetRandomRange(g_Config.nUnknowHelMetACAddValueMaxLimit {4},
                  g_Config.nUnknowHelMetACAddRate {20});
                if nRandPoint > 0 then
                  UserItem.btValue[0] := nRandPoint;
                nUpgrade := nRandPoint;
                nRandPoint := {GetRandomRange(4,3) + GetRandomRange(4,8) + }
                  GetRandomRange(g_Config.nUnknowHelMetMACAddValueMaxLimit {4},
                  g_Config.nUnknowHelMetMACAddRate {20});
                if nRandPoint > 0 then
                  UserItem.btValue[1] := nRandPoint;
                Inc(nUpgrade, nRandPoint);
                nRandPoint := {GetRandomRange(3,15) + }
                  GetRandomRange(g_Config.nUnknowHelMetDCAddValueMaxLimit {3},
                  g_Config.nUnknowHelMetDCAddRate {30});
                if nRandPoint > 0 then
                  UserItem.btValue[2] := nRandPoint;
                Inc(nUpgrade, nRandPoint);
                nRandPoint := {GetRandomRange(3,15) + }
                  GetRandomRange(g_Config.nUnknowHelMetMCAddValueMaxLimit {3},
                  g_Config.nUnknowHelMetMCAddRate {30});
                if nRandPoint > 0 then
                  UserItem.btValue[3] := nRandPoint;
                Inc(nUpgrade, nRandPoint);
                nRandPoint := {GetRandomRange(3,15) + }
                  GetRandomRange(g_Config.nUnknowHelMetSCAddValueMaxLimit {3},
                  g_Config.nUnknowHelMetSCAddRate {30});
                if nRandPoint > 0 then
                  UserItem.btValue[4] := nRandPoint;
                Inc(nUpgrade, nRandPoint);
                nRandPoint := GetRandomRange(6, 30);
                if nRandPoint > 0 then
                begin
                  nVal := (nRandPoint + 1) * 1000;
                  UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nVal);
                  UserItem.Dura := _MIN(65000, UserItem.Dura + nVal);
                end;
                if Random(30) = 0 then
                  UserItem.btValue[7] := 1;
                UserItem.btValue[8] := 1;
                if nUpgrade >= 3 then
                begin
                  if UserItem.btValue[0] >= 5 then
                  begin
                    UserItem.btValue[5] := 1;
                    UserItem.btValue[6] := UserItem.btValue[0] * 3 + 25;
                    exit;
                  end;
                  if UserItem.btValue[2] >= 2 then
                  begin
                    UserItem.btValue[5] := 1;
                    UserItem.btValue[6] := UserItem.btValue[2] * 4 + 35;
                    exit;
                  end;
                  if UserItem.btValue[3] >= 2 then
                  begin
                    UserItem.btValue[5] := 2;
                    UserItem.btValue[6] := UserItem.btValue[3] * 2 + 18;
                    exit;
                  end;
                  if UserItem.btValue[4] >= 2 then
                  begin
                    UserItem.btValue[5] := 3;
                    UserItem.btValue[6] := UserItem.btValue[4] * 2 + 18;
                    exit;
                  end;
                  UserItem.btValue[6] := nUpgrade * 2 + 18;
                end;
              end;
            22, 23:
              begin
                nRandPoint := {GetRandomRange(4,3) + GetRandomRange(4,8) + }
                  GetRandomRange(g_Config.nUnknowRingACAddValueMaxLimit {6},
                  g_Config.nUnknowRingACAddRate {20});
                if nRandPoint > 0 then
                  UserItem.btValue[0] := nRandPoint;
                nUpgrade := nRandPoint;
                nRandPoint := {GetRandomRange(4,3) + GetRandomRange(4,8) + }
                  GetRandomRange(g_Config.nUnknowRingMACAddValueMaxLimit {6},
                  g_Config.nUnknowRingMACAddRate {20});
                if nRandPoint > 0 then
                  UserItem.btValue[1] := nRandPoint;
                Inc(nUpgrade, nRandPoint);
                // 以上二项为增加项，增加防，及魔防

                nRandPoint := {GetRandomRange(4,3) + GetRandomRange(4,8) + }
                  GetRandomRange(g_Config.nUnknowRingDCAddValueMaxLimit {6},
                  g_Config.nUnknowRingDCAddRate {20});
                if nRandPoint > 0 then
                  UserItem.btValue[2] := nRandPoint;
                Inc(nUpgrade, nRandPoint);
                nRandPoint := {GetRandomRange(4,3) + GetRandomRange(4,8) + }
                  GetRandomRange(g_Config.nUnknowRingMCAddValueMaxLimit {6},
                  g_Config.nUnknowRingMCAddRate {20});
                if nRandPoint > 0 then
                  UserItem.btValue[3] := nRandPoint;
                Inc(nUpgrade, nRandPoint);
                nRandPoint := {GetRandomRange(4,3) + GetRandomRange(4,8) + }
                  GetRandomRange(g_Config.nUnknowRingSCAddValueMaxLimit {6},
                  g_Config.nUnknowRingSCAddRate {20});
                if nRandPoint > 0 then
                  UserItem.btValue[4] := nRandPoint;
                Inc(nUpgrade, nRandPoint);
                nRandPoint := GetRandomRange(6, 30);
                if nRandPoint > 0 then
                begin
                  nVal := (nRandPoint + 1) * 1000;
                  UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nVal);
                  UserItem.Dura := _MIN(65000, UserItem.Dura + nVal);
                end;
                if Random(30) = 0 then
                  UserItem.btValue[7] := 1;
                UserItem.btValue[8] := 1;
                if nUpgrade >= 3 then
                begin
                  if UserItem.btValue[2] >= 3 then
                  begin
                    UserItem.btValue[5] := 1;
                    UserItem.btValue[6] := UserItem.btValue[2] * 3 + 25;
                    exit;
                  end;
                  if UserItem.btValue[3] >= 3 then
                  begin
                    UserItem.btValue[5] := 2;
                    UserItem.btValue[6] := UserItem.btValue[3] * 2 + 18;
                    exit;
                  end;
                  if UserItem.btValue[4] >= 3 then
                  begin
                    UserItem.btValue[5] := 3;
                    UserItem.btValue[6] := UserItem.btValue[4] * 2 + 18;
                    exit;
                  end;
                  UserItem.btValue[6] := nUpgrade * 2 + 18;
                end;
              end;
            24, 26:
              begin
                nRandPoint := {GetRandomRange(3,5) + }
                  GetRandomRange(g_Config.nUnknowNecklaceACAddValueMaxLimit {5},
                  g_Config.nUnknowNecklaceACAddRate {20});
                if nRandPoint > 0 then
                  UserItem.btValue[0] := nRandPoint;
                nUpgrade := nRandPoint;
                nRandPoint := {GetRandomRange(3,5) + }
                  GetRandomRange(g_Config.nUnknowNecklaceMACAddValueMaxLimit {5},
                  g_Config.nUnknowNecklaceMACAddRate {20});
                if nRandPoint > 0 then
                  UserItem.btValue[1] := nRandPoint;
                Inc(nUpgrade, nRandPoint);
                nRandPoint := {GetRandomRange(3,15) + }
                  GetRandomRange(g_Config.nUnknowNecklaceDCAddValueMaxLimit {5},
                  g_Config.nUnknowNecklaceDCAddRate {30});
                if nRandPoint > 0 then
                  UserItem.btValue[2] := nRandPoint;
                Inc(nUpgrade, nRandPoint);
                nRandPoint := {GetRandomRange(3,15) + }
                  GetRandomRange(g_Config.nUnknowNecklaceMCAddValueMaxLimit {5},
                  g_Config.nUnknowNecklaceMCAddRate {30});
                if nRandPoint > 0 then
                  UserItem.btValue[3] := nRandPoint;
                Inc(nUpgrade, nRandPoint);
                nRandPoint := {GetRandomRange(3,15) + }
                  GetRandomRange(g_Config.nUnknowNecklaceSCAddValueMaxLimit {5},
                  g_Config.nUnknowNecklaceSCAddRate {30});
                if nRandPoint > 0 then
                  UserItem.btValue[4] := nRandPoint;
                Inc(nUpgrade, nRandPoint);
                nRandPoint := GetRandomRange(6, 30);
                if nRandPoint > 0 then
                begin
                  nVal := (nRandPoint + 1) * 1000;
                  UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nVal);
                  UserItem.Dura := _MIN(65000, UserItem.Dura + nVal);
                end;
                if Random(30) = 0 then
                  UserItem.btValue[7] := 1;
                UserItem.btValue[8] := 1;
                if nUpgrade >= 2 then
                begin
                  if UserItem.btValue[0] >= 3 then
                  begin
                    UserItem.btValue[5] := 1;
                    UserItem.btValue[6] := UserItem.btValue[0] * 3 + 25;
                    exit;
                  end;
                  if UserItem.btValue[2] >= 2 then
                  begin
                    UserItem.btValue[5] := 1;
                    UserItem.btValue[6] := UserItem.btValue[2] * 3 + 30;
                    exit;
                  end;
                  if UserItem.btValue[3] >= 2 then
                  begin
                    UserItem.btValue[5] := 2;
                    UserItem.btValue[6] := UserItem.btValue[3] * 2 + 20;
                    exit;
                  end;
                  if UserItem.btValue[4] >= 2 then
                  begin
                    UserItem.btValue[5] := 3;
                    UserItem.btValue[6] := UserItem.btValue[4] * 2 + 20;
                    exit;
                  end;
                  UserItem.btValue[6] := nUpgrade * 2 + 18;
                end;
              end;
          end;
        end;
    end;
  except
    MainOutMessage('[Exception] TItem.RandomUpgradeUnknownItem');
  end;
end;

procedure TItem.ApplyItemParameters(var AddAbility: TAddAbility; UserItem:
  pTUserItem);
var
  Temp: integer;
begin
  try
    case ItemType of
      ITEM_WEAPON:
        begin
          Inc(AddAbility.wHitPoint, AC2 + UserItem.btValue[5]);
          Temp := MAC2 + UserItem.btValue[6];
          if Temp > 10 then
          begin
            Inc(AddAbility.nHitSpeed, Temp - 10);
          end
          else
          begin
            Dec(AddAbility.nHitSpeed, Temp);
          end;
          Inc(AddAbility.btLuck, AC + UserItem.btValue[3]);
          Inc(AddAbility.btUnLuck, MAC + UserItem.btValue[4]);

          AddAbility.wDC := MakeLong(LoWord(AddAbility.wDC) + DC,
            HiWord(AddAbility.wDC) + DC2 + UserItem.btValue[0]);
          AddAbility.wMC := MakeLong(LoWord(AddAbility.wMC) + MC,
            HiWord(AddAbility.wMC) + MC2 + UserItem.btValue[1]);
          AddAbility.wSC := MakeLong(LoWord(AddAbility.wSC) + SC,
            HiWord(AddAbility.wSC) + SC2 + UserItem.btValue[2]);
          exit;
        end;
      ITEM_ARMOR:
        begin
          AddAbility.wAC := MakeLong(LoWord(AddAbility.wAC) + AC,
            HiWord(AddAbility.wAC) + AC2 + UserItem.btValue[0]);
          AddAbility.wMAC := MakeLong(LoWord(AddAbility.wMAC) + MAC,
            HiWord(AddAbility.wMAC) + MAC2 + UserItem.btValue[1]);

          Inc(AddAbility.btLuck, LoByte(Source));
          Inc(AddAbility.btUnLuck, HiByte(Source));
        end;
      ITEM_ACCESSORY:
        begin
          case StdMode of
            28:
              begin
                AddAbility.wAC := MakeLong(LoWord(AddAbility.wAC) + AC,
                  HiWord(AddAbility.wAC) + AC2 + UserItem.btValue[0]);
                AddAbility.wMAC := MakeLong(LoWord(AddAbility.wMAC) + MAC,
                  HiWord(AddAbility.wMAC) + MAC2 + UserItem.btValue[1]);

                Inc(AddAbility.btLuck, LoByte(Source));
                Inc(AddAbility.btUnLuck, HiByte(Source));
                Inc(AddAbility.WearWeight, AniCount);
              end;
            19:
              begin
                Inc(AddAbility.wAntiMagic, AC2 + UserItem.btValue[0]);
                Inc(AddAbility.btUnLuck, MAC);
                Inc(AddAbility.btLuck, MAC2 + UserItem.btValue[1]);
              end;
            20, 24:
              begin //004C0FF0
                Inc(AddAbility.wHitPoint, AC2 + UserItem.btValue[0]);
                Inc(AddAbility.wSpeedPoint, MAC2 + UserItem.btValue[1]);
              end;
            21:
              begin
                Inc(AddAbility.wHealthRecover, AC2 + UserItem.btValue[0]);
                Inc(AddAbility.wSpellRecover, MAC2 + UserItem.btValue[1]);
                Inc(AddAbility.nHitSpeed, AC);
                Dec(AddAbility.nHitSpeed, MAC);
              end;
            23:
              begin
                Inc(AddAbility.wAntiPoison, AC2 + UserItem.btValue[0]);
                Inc(AddAbility.wPoisonRecover, MAC2 + UserItem.btValue[1]);
                Inc(AddAbility.nHitSpeed, AC);
                Dec(AddAbility.nHitSpeed, MAC);
              end;
          end;
        end;
    end;
    AddAbility.wDC := MakeLong(LoWord(AddAbility.wDC) + DC,
      HiWord(AddAbility.wDC) + DC2 + UserItem.btValue[2]);
    AddAbility.wMC := MakeLong(LoWord(AddAbility.wMC) + MC,
      HiWord(AddAbility.wMC) + MC2 + UserItem.btValue[3]);
    AddAbility.wSC := MakeLong(LoWord(AddAbility.wSC) + SC,
      HiWord(AddAbility.wSC) + SC2 + UserItem.btValue[4]);
  except
    MainOutMessage('[Exception] TItem.ApplyItemParameters');
  end;
end;

{ TItemUnit }

constructor TItemUnit.Create;
begin
  try
    m_ItemNameList := TGList.Create;
  except
    MainOutMessage('[Exception] TItemUnit.Create');
  end;
end;

destructor TItemUnit.Destroy;
var
  I: Integer;
begin
  try
    for I := 0 to m_ItemNameList.Count - 1 do
    begin
      Dispose(pTItemName(m_ItemNameList.Items[I]));
    end;
    m_ItemNameList.Free;
    inherited;
  except
    MainOutMessage('[Exception] TItemUnit.Destroy');
  end;
end;

function GetItemName(UserItem: pTUserItem): string;
begin
  try
    //取自定义物品名称
    Result := '';
    if UserItem.btValue[13] = 1 then
      Result := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
    if Result = '' then
      Result := UserEngine.GetStdItemName(UserItem.wIndex);
  except
    MainOutMessage('[Exception] UnItmUnit.GetItemName');
  end;
end;

function TItemUnit.GetCustomItemName(nMakeIndex,
  nItemIndex: Integer): string;
var
  I: Integer;
  ItemName: pTItemName;
begin
  try
    Result := '';
    m_ItemNameList.Lock;
    try
      for I := 0 to m_ItemNameList.Count - 1 do
      begin
        ItemName := m_ItemNameList.Items[I];
        if (ItemName.nMakeIndex = nMakeIndex) and (ItemName.nItemIndex =
          nItemIndex) then
        begin
          Result := ItemName.sItemName;
          break;
        end;
      end;
    finally
      m_ItemNameList.UnLock;
    end;
  except
    MainOutMessage('[Exception] TItemUnit.GetCustomItemName');
  end;
end;

function TItemUnit.AddCustomItemName(nMakeIndex, nItemIndex: Integer;
  sItemName: string): Boolean;
var
  I: Integer;
  ItemName: pTItemName;
begin
  try
    Result := False;
    m_ItemNameList.Lock;
    try
      for I := 0 to m_ItemNameList.Count - 1 do
      begin
        ItemName := m_ItemNameList.Items[I];
        if (ItemName.nMakeIndex = nMakeIndex) and (ItemName.nItemIndex =
          nItemIndex) then
        begin
          exit;
        end;
      end;
      New(ItemName);
      ItemName.nMakeIndex := nMakeIndex;
      ItemName.nItemIndex := nItemIndex;
      ItemName.sItemName := sItemName;
      m_ItemNameList.Add(ItemName);
      Result := True;
    finally
      m_ItemNameList.UnLock;
    end;
  except
    MainOutMessage('[Exception] TItemUnit.AddCustomItemName');
  end;
end;

function TItemUnit.DelCustomItemName(nMakeIndex, nItemIndex: Integer): Boolean;
var
  I: Integer;
  ItemName: pTItemName;
begin
  try
    Result := False;
    m_ItemNameList.Lock;
    try
      for I := 0 to m_ItemNameList.Count - 1 do
      begin
        ItemName := m_ItemNameList.Items[I];
        if (ItemName.nMakeIndex = nMakeIndex) and (ItemName.nItemIndex =
          nItemIndex) then
        begin
          Dispose(ItemName);
          m_ItemNameList.Delete(I);
          Result := True;
          exit;
        end;
      end;
    finally
      m_ItemNameList.UnLock;
    end;
  except
    MainOutMessage('[Exception] TItemUnit.DelCustomItemName');
  end;
end;

function TItemUnit.LoadCustomItemName: Boolean;
var
  I: integer;
  LoadList: TStringList;
  sFileName: string;
  sLineText: string;
  sMakeIndex: string;
  sItemIndex: string;
  nMakeIndex: Integer;
  nItemIndex: Integer;
  sItemName: string;
  ItemName: pTItemName;
begin
  try
    Result := False;
    sFileName := g_Config.sEnvirDir + 'ItemNameList.txt';
    LoadList := TStringList.Create;
    if FileExists(sFileName) then
    begin
      m_ItemNameList.Lock;
      try
        m_ItemNameList.Clear;
        LoadList.LoadFromFile(sFileName);
        for I := 0 to LoadList.Count - 1 do
        begin
          sLineText := Trim(LoadList.Strings[I]);
          sLineText := GetValidStr3(sLineText, sMakeIndex, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sItemIndex, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sItemName, [' ', #9]);
          nMakeIndex := Str_ToInt(sMakeIndex, -1);
          nItemIndex := Str_ToInt(sItemIndex, -1);
          if (nMakeIndex >= 0) and (nItemIndex >= 0) then
          begin
            New(ItemName);
            ItemName.nMakeIndex := nMakeIndex;
            ItemName.nItemIndex := nItemIndex;
            ItemName.sItemName := sItemName;
            m_ItemNameList.Add(ItemName);
          end;
        end;
        Result := True;
      finally
        m_ItemNameList.UnLock;
      end;
    end
    else
    begin
      LoadList.SaveToFile(sFileName);
    end;
    LoadList.Free;
  except
    MainOutMessage('[Exception] TItemUnit.LoadCustomItemName:');
  end;
end;

function TItemUnit.SaveCustomItemName: Boolean;
var
  I: integer;
  SaveList: TStringList;
  sFileName: string;
  ItemName: pTItemName;
begin
  try
    sFileName := g_Config.sEnvirDir + 'ItemNameList.txt';
    SaveList := TStringList.Create;
    m_ItemNameList.Lock;
    try
      for I := 0 to m_ItemNameList.Count - 1 do
      begin
        ItemName := m_ItemNameList.Items[I];
        SaveList.Add(IntToStr(ItemName.nMakeIndex) + #9 +
          IntToStr(ItemName.nItemIndex) + #9 + ItemName.sItemName);
      end;
    finally
      m_ItemNameList.UnLock;
    end;
    SaveList.SaveToFile(sFileName);
    SaveList.Free;
    Result := True;
  except
    MainOutMessage('[Exception] TItemUnit.SaveCustomItemName:');
  end;
end;

procedure GetMapItemInfo(UserItem: pTUserItem; var StdItem: TStdItem);
var
  NewUserItem: TNewUserItem;
  Envir: TEnvirnoment;
  NewStdItem: TNewStdItem;
begin
  try
    try
      if (StdItem.StdMode = 2) and (StdItem.Shape = 99) then
      begin
        Move(UserItem^, NewUserItem, SizeOf(TNewUserItem));
        if NewUserItem.sMapName <> '' then
        begin
          Envir := g_MapManager.FindMap(NewUserItem.sMapName);
          if Envir <> nil then
          begin
            Move(StdItem, NewStdItem, SizeOf(TNewStdItem));
            NewStdItem.sMapName := Envir.sMapDesc;
            Move(NewStdItem, StdItem, SizeOf(TNewStdItem));
          end;
        end;
      end;
    except
      MainOutMessage('[Exception] GetMapItemInfo')
    end;
  except
    MainOutMessage('[Exception] UnItmUnit.GetMapItemInfo');
  end;
end;

procedure TItemUnit.Lock;
begin
  try
    m_ItemNameList.Lock;
  except
    MainOutMessage('[Exception] TItemUnit.Lock');
  end;
end;

procedure TItemUnit.UnLock;
begin
  try
    m_ItemNameList.UnLock;
  except
    MainOutMessage('[Exception] TItemUnit.UnLock');
  end;
end;

end.

