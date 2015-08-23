(******************************************************************************
  ����TLegendMap(λ��PathFind.pas)���÷�
  1��FLegendMap:=TLegendMap.Create;
     FLegendMap.LoadMap('mapfile')
        --�ɹ����غ����ɵ�ͼ����FLegendMap.MapData[i, j]:TMapData
     FLegendMap.SetStartPos(StartX, StartY,PathSpace)
     Path:=FLegendMap.FindPath(StopX, StopY)
  2��FLegendMap:=TLegendMap.Create;
     FLegendMap.LoadMap('mapfile')
     Path:=FLegendMap.FindPath(StartX,StartY,StopX, StopY,PathSpace)

     ����
     PathΪTPath = array of TPoint Ϊnilʱ��ʾ���ܵ���
     ��һ��ֵΪ��㣬���һ��ֵΪ�յ�
     High(Path)��·����Ҫ�Ĳ���

     PathSpaceΪ�뿪�ϰ�����ٸ�����
******************************************************************************)

(*****************************************************************************
  ����TPathMap���ص�
  1������Ҫ���ݵ�ͼ���ݣ���ʡ�ڴ��Ƶ������
  2�����Զ�����ۺ����������Լ���Ҫ������ͬ·��

  ����TPathMap���÷�
  1��������ۺ���MovingCost(X, Y, Direction: Integer)
     ֻ������Զ���ĵ�ͼ��ʽ��д)
  2��FPathMap:=TPathMap.Create;
     FPathMap.MakePathMap(MapHeader.width, MapHeader.height, StartX, StartY,MovingCost);
     Path:=FPathMap.FindPathOnMap( EndX, EndY)
     ����PathΪTPath = array of TPoint;

  �����ϲ����TPathMap�ⲿ������ۺ������ɼ̳�TPathMap��
  ����ͼ���ݵĶ�ȡ�͹��ۺ�����װ��һ����ʹ�á�
*******************************************************************************)
unit FindMapPath;

interface

uses
  Windows, Classes, SysUtils, Graphics;

type
   //��ͼԪ�ط���
  TTerrainTypes = (ttNormal, ttSand, ttForest, ttRoad, ttObstacle, ttPath);
  {TTerrainParam = record
    CellColor: TColor;
    CellLabel: string[16];
    MoveCost: Integer;
  end;  }

  TPath = array of TPoint; //·������

  TPathMapCell = record //·��ͼԪ
    Distance: Integer; //�����ľ���
    Direction: Integer;
  end;
  TPathMapArray = array of array of TPathMapCell; // ·��ͼ�洢����

    TMapHeader =packed record // �����ͼ����ͷ�ṹ 52
      Width: word; //2
      Height: word; //2
      Title: array[1..16] of char; //����      16
      UpdateDate: TDateTime; //8
      Reserved: array[0..23] of char; //����
    end;

    TMapBlock = record // �����ͼ������ṹ
      BkImg: word;
      MidImg: word;
      FrImg: word;
      flag: Byte;
      offset: Byte;
      framecount: Byte;
      delaytime: Byte;
      objgroup: Byte;
      unused: Byte;
    end;
    TMapBuf = array of array of TMapBlock; //�����ͼ�洢����

    TCellParams = record
    TerrainType: Boolean;
    OnPath: Boolean;
  end;
  TMapData = array of array of TCellParams; //��ͼ�洢����(�㷨��ʶ���ʽ)

  TGetCostFunc = function(X, Y, Direction: Integer; PathWidth: Integer = 0): Integer;

  TPathMap = class //Ѱ·��
  public
    PathMapArray: TPathMapArray;
    MapHeight: Integer;
    MapWidth: Integer;
    GetCostFunc: TGetCostFunc;
    PathWidth: Integer;

    constructor Create;
    function FindPath(MapWidthin, MapHeightin: Integer; StartX, StartY, StopX, StopY: Integer;
      pGetCostFunc: TGetCostFunc): TPath;
    function FindPathOnMap(X, Y: Integer): TPath;
    procedure MakePathMap(MapWidthin, MapHeightin: Integer; StartX, StartY: Integer;
      pGetCostFunc: TGetCostFunc);

  private
    function DirToDX(Direction: Integer): Integer;
    function DirToDY(Direction: Integer): Integer;

  protected
    function GetCost(X, Y, Direction: Integer): Integer; virtual;
    function FillPathMap(X1, Y1, X2, Y2: Integer): TPathMapArray;
  end;

  TLegendMap = class(TPathMap) //�����ͼ��ȡ��Ѱ·��
    private
    FPath: TPath;
    MapBuf: TMapBuf;
    MapHeader: TMapHeader;

    public
    MapData: TMapData;
    Title: string;
    property Path: TPath read FPath write FPath;

    function LoadMap(MapFile: string): Boolean;
    function FindPath(StartX, StartY, StopX, StopY, PathSpace: Integer): TPath; overload;
    function FindPath(StopX, StopY: Integer): TPath; overload;
    procedure SetStartPos(StartX, StartY, PathSpace: Integer);

    protected
      function GetCost(X, Y, Direction: Integer): Integer; override;
    end;

  TWaveCell = record //·�ߵ�
    X, Y: Integer; //
    Cost: Integer; //
    Direction: Integer;
  end;

  TWave = class //·����
  private
    FData: array of TWaveCell;
    FPos: Integer; //
    FCount: Integer; //
    FMinCost: Integer;
    function GetItem: TWaveCell;
  public
    property Item: TWaveCell read GetItem; //
    property MinCost: Integer read FMinCost; // Cost

    constructor Create;
    destructor Destroy; override;
    procedure Add(NewX, NewY, NewCost, NewDirection: Integer); //
    procedure Clear; //FCount
    function Start: Boolean; //
    function Next: Boolean; //
  end;

const
    TerrainParams: array[Boolean] of Integer = (-1,4);
  {TerrainParams: array[TTerrainTypes] of TTerrainParam = (
    (CellColor: clWhite; CellLabel: 'ƽ��'; MoveCost: 4),
    (CellColor: clOlive; CellLabel: 'ɳ��'; MoveCost: 6),
    (CellColor: clGreen; CellLabel: '����'; MoveCost: 10),
    (CellColor: clSilver; CellLabel: '��·'; MoveCost: 2),
    (CellColor: clBlack; CellLabel: '�ϰ���'; MoveCost: - 1),
    (CellColor: clRed; CellLabel: '·��'; MoveCost: 0)); }


implementation
uses
MShare,ClMain;

constructor TWave.Create;
begin
  Clear; //
end;

destructor TWave.Destroy;
begin
  FData := nil; //
  inherited Destroy;
end;

function TWave.GetItem: TWaveCell;
begin
  Result := FData[FPos]; //
end;

procedure TWave.Add(NewX, NewY, NewCost, NewDirection: Integer);
begin
  if FCount >= Length(FData) then //
    SetLength(FData, Length(FData) + 30); //
  with FData[FCount] do
  begin
    X := NewX;
    Y := NewY;
    Cost := NewCost;
    Direction := NewDirection;
  end;
  if NewCost < FMinCost then //NewCost
    FMinCost := NewCost;
  Inc(FCount); //
end;

procedure TWave.Clear;
begin
  FPos := 0;
  FCount := 0;
  FMinCost := High(Integer);
end;

function TWave.Start: Boolean;
begin
  FPos := 0; //
  Result := (FCount > 0); //
end;

function TWave.Next: Boolean;
begin
  Inc(FPos); //
  Result := (FPos < FCount); // false,
end;

constructor TPathMap.Create;
begin
  inherited Create;
end;

function TPathMap.FindPath(MapWidthin, MapHeightin: Integer; StartX, StartY, StopX, StopY: Integer;
  pGetCostFunc: TGetCostFunc): TPath;
begin
  MapWidth := MapWidthin; //
  MapHeight := MapHeightin; //
  GetCostFunc := pGetCostFunc;
  PathMapArray := FillPathMap(StartX, StartY, StopX, StopY);
  Result := FindPathOnMap(StopX, StopY);
end;

//*************************************************************
//    ��TPathMap���ҳ� TPath
//*************************************************************
function TPathMap.FindPathOnMap(X, Y: Integer): TPath;
var
  Direction: Integer;
begin
  Result := nil;
  if (X >= MapWidth) or (Y >= MapHeight) then
    Exit;
  if PathMapArray[Y, X].Distance < 0 then
    Exit;
  SetLength(Result, PathMapArray[Y, X].Distance + 1); //
  while PathMapArray[Y, X].Distance > 0 do
  begin
    Result[PathMapArray[Y, X].Distance] := Point(X, Y);
    Direction := PathMapArray[Y, X].Direction;
    X := X - DirToDX(Direction);
    Y := Y - DirToDY(Direction);
  end;
  Result[0] := Point(X, Y);
end;

procedure TPathMap.MakePathMap(MapWidthin, MapHeightin: Integer; StartX, StartY: Integer;
  pGetCostFunc: TGetCostFunc);
begin
  MapWidth := MapWidthin;
  MapHeight := MapHeightin; //
  GetCostFunc := pGetCostFunc;
  PathMapArray := FillPathMap(StartX, StartY, -1, -1);
end;

//*************************************************************
//    ������תΪX�������
//     7  0  1
//     6  X  2
//     5  4  3
//*************************************************************
function TPathMap.DirToDX(Direction: Integer): Integer;
begin
  case Direction of
    0, 4: Result := 0;
    1..3: Result := 1;
  else
    Result := -1;
  end;
end;

function TPathMap.DirToDY(Direction: Integer): Integer;
begin
  case Direction of
    2, 6: Result := 0;
    3..5: Result := 1;
  else
    Result := -1;
  end;
end;

//*************************************************************
//    Ѱ·�㷨
//    X1,Y1Ϊ·��������㣬X2��Y2Ϊ·�������յ�
//*************************************************************
function TPathMap.FillPathMap(X1, Y1, X2, Y2: Integer): TPathMapArray;
var
  OldWave, NewWave: TWave;
  Finished: Boolean;
  I: TWaveCell;

  procedure PreparePathMap; //��ʼ��PathMapArray
  var
    X, Y: Integer; //
  begin
    SetLength(Result, MapHeight, MapWidth);
    for Y := 0 to (MapHeight - 1) do
      for X := 0 to (MapWidth - 1) do
        Result[Y, X].Distance := -1;
  end;

//��������8���ڵ��Ȩcost�����Ϸ������NewWave(),��������Сcost
//�Ϸ�����ָ���ϰ�����Result[X��Y]��δ���ʵĵ�
  procedure TestNeighbours;
  var
    X, Y, C, D: Integer;
  begin
    for D := 0 to 7 do
    begin
      X := OldWave.Item.X + DirToDX(D);
      Y := OldWave.Item.Y + DirToDY(D);
      C := GetCost(X, Y, D);
      if (C >= 0) and (Result[Y, X].Distance < 0) then
        NewWave.Add(X, Y, C, D); //
    end;
  end;

  procedure ExchangeWaves; //
  var
    W: TWave;
  begin
    W := OldWave;
    OldWave := NewWave;
    NewWave := W;
    NewWave.Clear;
  end;

begin
  PreparePathMap; // ��ʼ��PathMapArray ,Distance:=-1
  OldWave := TWave.Create;
  NewWave := TWave.Create;
  Result[Y1, X1].Distance := 0; // ���Distance:=0
  OldWave.Add(X1, Y1, 0, 0); //��������OldWave
  TestNeighbours; //

  Finished := ((X1 = X2) and (Y1 = Y2)); //�����Ƿ񵽴��յ�
  while not Finished do
  begin
    ExchangeWaves; //
    if not OldWave.Start then
      Break;
    repeat
      I := OldWave.Item;
      I.Cost := I.Cost - OldWave.MinCost; // �������MinCost
      if I.Cost > 0 then // ����NewWave
        NewWave.Add(I.X, I.Y, I.Cost, I.Direction) //����Cost= cost-MinCost
      else
      begin //  ������СCOST�ĵ�
        if Result[I.Y, I.X].Distance >= 0 then
          Continue;

        Result[I.Y, I.X].Distance := Result[I.Y - DirToDY(I.Direction), I.X -
          DirToDX(I.Direction)].Distance + 1; // �˵� Distance:=��һ����Distance+1

        Result[I.Y, I.X].Direction := I.Direction;
          //
        Finished := ((I.X = X2) and (I.Y = Y2)); //�����Ƿ񵽴��յ�
        if Finished then
          Break;
        TestNeighbours;
    end;
    until not OldWave.Next; //
  end; // OldWave;
  NewWave.Free;
  OldWave.Free;
end;

function TPathMap.GetCost(X, Y, Direction: Integer): Integer;
begin
  Direction := (Direction and 7);
  if (X < 0) or (X >= MapWidth) or (Y < 0) or (Y >= MapHeight) then
    Result := -1
  else
    Result := GetCostFunc(X, Y, Direction, PathWidth);
end;


function TLegendMap.LoadMap(MapFile: string): Boolean;
var
  aMapFile: TFileStream;
  i, j: Integer;
//  hh:widestring;
begin
  aMapFile := TFileStream.Create(MapFile, fmOpenRead);
  try
    aMapFile.Read(MapHeader, sizeof(TMapHeader)); //
    SetLength(MapBuf, MapHeader.width, MapHeader.height);
    MapWidth :=MapHeader.Width;
    MapHeight := MapHeader.Height;
    SetLength(MapData, MapWidth, MapHeight);
    for i := 0 to MapHeader.width - 1 do
      for j := 0 to MapHeader.height - 1 do
      begin
        aMapFile.Read(MapBuf[i, j], sizeof(MapBuf[i, j]));
        if ((MapBuf[i, j].BkImg and $8000) = 0)then
          MapData[i, j].TerrainType := True //��ʶΪƽ��
        else
          MapData[i, j].TerrainType := False; //��ʶΪ�ϰ���
      end;
  except
    aMapFile.Free;
//    Result := false;
  end;
  aMapFile.Free;
  Result := true;
end;

function TLegendMap.FindPath(StopX, StopY: Integer): TPath;
begin
  Result := FindPathOnMap(StopX, StopY);
end;

function TLegendMap.FindPath(StartX, StartY, StopX, StopY, PathSpace: Integer): TPath;
begin
  PathWidth := PathSpace;
  PathMapArray := FillPathMap(StartX, StartY, StopX, StopY);
  Result := FindPathOnMap(StopX, StopY);
end;

procedure TLegendMap.SetStartPos(StartX, StartY, PathSpace: Integer);
begin
  PathWidth := PathSpace;
  PathMapArray := FillPathMap(StartX, StartY, -1, -1);
end;

function TLegendMap.GetCost(X, Y, Direction: Integer): Integer;
var
  cost: Integer;
//  sel : Integer;
begin
  Direction := (Direction and 7);
  if (X < 0) or (X >= MapWidth) or (Y < 0) or (Y >= MapHeight) then
    Result := -1
  else
  begin
    Result := TerrainParams[MapData[X, Y].TerrainType];
    if (X < MapWidth - PathWidth) and (X > PathWidth) and
      (Y < MapHeight - PathWidth) and (Y > PathWidth) then
    begin
      cost := TerrainParams[MapData[X - PathWidth, Y].TerrainType]
        + TerrainParams[MapData[X + PathWidth, Y].TerrainType]
        + TerrainParams[MapData[X, Y - PathWidth].TerrainType]
        + TerrainParams[MapData[X, Y + PathWidth].TerrainType];
      if cost < 4 * TerrainParams[True] then
        Result := -1;
    end;

    if ((Direction and 1) = 1) and (Result > 0) then // �����б����,��COST����
      Result := Result + (Result shr 1); //ӦΪResult*sqt(2),�˴�����Ϊ1.5
  end;

end;

end.

