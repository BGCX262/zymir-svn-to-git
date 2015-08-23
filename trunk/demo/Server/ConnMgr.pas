unit ConnMgr;

interface
uses windows,classes,inifiles,Grobal2,winsock,SysUtils;

type
  //玩家信息：服务器端使用
  PPlayerInfo=^TPlayerInfo;
  TPlayerInfo=Record
     ip:pchar;
     port:integer;
     UserID:pchar;
     CharName:pchar;
     Job:Integer;
     ab:TAbility;                                 //属性
     Gold:Integer;
     X,Y:integer;
     dir:integer;
     Map:pchar;
     server:pchar;
  end;

  TPlayerManager=class
  private
    FPlayerList:TList;

    function GetPlayerInfo(ip:string; port: integer): PPlayerInfo;
  public
    UserInfo:TInifile;
    constructor create;
    destructor destroy;override;
    procedure Add(Player:TPlayerInfo);
    procedure delete(ip:string;port:integer);
    property Player[ip:string;port:integer]:PPlayerInfo read GetPlayerInfo;

  end;
var
  PlayerMan:TPlayerManager;

implementation

{ TPlayerManager }

procedure TPlayerManager.Add(Player: TPlayerInfo);
var
  p:PPlayerInfo;
begin
  GetMem(p,sizeof(TPlayerInfo));
  p^:=player;
  FPlayerList.Add(P);
end;

constructor TPlayerManager.create;
begin
  inherited;
  UserInfo:=TInifile.Create('.\data\UserInfo.ini');
  FPlayerList:=TList.create;
end;

procedure TPlayerManager.delete(ip: string; port: integer);
var
  i:integer;
  p:PPlayerInfo;
begin
  for i:=0 to FPlayerList.count -1 do
  begin
     p:=FPlayerList[i];
     if (StrPas(p^.ip)=ip) and (p^.port=port) then
     begin
        freeMem(p,sizeof(TPlayerInfo));
        FPlayerList.delete(i);
        exit;
     end;
  end;
end;

destructor TPlayerManager.destroy;
var
  p:PPlayerinfo;
begin
  while FPlayerList.count>0 do
  begin
    P:=PPlayerinfo(FPlayerList[0]);
    FreeMem(P,Sizeof(TPlayerinfo));
    FPlayerList.Delete(0);
  end;
  FPlayerList.Free;
  UserInfo.Free;
  inherited;
end;

function TPlayerManager.GetPlayerInfo(ip:string; port: integer): PPlayerInfo;
var
  i:integer;
  p:PPlayerInfo;
begin
  for i:=0 to FPlayerList.count -1 do
  begin
     p:=FPlayerList[i];
     if (StrPas(p^.ip)=ip) and (p^.port=port) then
     begin
        result:=p;
        exit;
     end;
  end;
  GetMem(p,sizeof(TPlayerInfo));
  p^.ip:=pchar(ip);
  p^.port:=port;
  FPlayerList.Add(p);
  result:=p;
end;

end.
