unit FindMapPath;

interface

uses
  Windows, Classes, SysUtils, Graphics,Envir;

type
  TPath = array of TPoint; //·������
  pTPaht = ^TPath;

  TPathMapCell = record //·��ͼԪ
    Distance: Integer; //�����ľ���
    Direction: Integer;
  end;
  TPathMapArray = array of array of TPathMapCell; // ·��ͼ�洢����

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
//      MapHeader: TMapHeader;
      FEnvir:TEnvirnoment;
    public
    property Path: TPath read FPath write FPath;

    function LoadMap(Envir:TEnvirnoment): Boolean;
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
  TerrainParams:array[Boolean] of Integer = (-1,4);


implementation
uses
HUtil32,M2Share;

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


function TLegendMap.LoadMap(Envir:TEnvirnoment): Boolean;
begin
  FEnvir:=Envir;
  MapWidth :=FEnvir.Header.wWidth;
  MapHeight :=FEnvir.Header.wHeight;
  Result:=True;
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
begin
  Direction := (Direction and 7);
  if (X < 0) or (X >= MapWidth) or (Y < 0) or (Y >= MapHeight) then
    Result := -1
  else
  begin

    Result := TerrainParams[FEnvir.MapCellArray[X*MapHeight+Y].chFlag=0];
    if (X < MapWidth - PathWidth) and (X > PathWidth) and
      (Y < MapHeight - PathWidth) and (Y > PathWidth) then
    begin
      cost := TerrainParams[FEnvir.MapCellArray[(X - PathWidth)*MapHeight+Y].chFlag=0]
        + TerrainParams[FEnvir.MapCellArray[(X + PathWidth)*MapHeight+Y].chFlag=0]
        + TerrainParams[FEnvir.MapCellArray[X*MapHeight+(Y - PathWidth)].chFlag=0]
        + TerrainParams[FEnvir.MapCellArray[X*MapHeight+(Y + PathWidth)].chFlag=0];
      if cost < 4 * TerrainParams[True] then
        Result := -1;
    end;

    if ((Direction and 1) = 1) and (Result > 0) then // �����б����,��COST����
      Result := Result + (Result shr 1); //ӦΪResult*sqt(2),�˴�����Ϊ1.5
  end;

end;

end.

