unit Share;

interface

uses
  CoralWry,StrUtils,SysUtils;



procedure InitPlug();
procedure UnInitPlug();
function  GetIPLocal(Msg:PChar;LoMsg:PChar;LoMsgLen:Integer):integer;stdcall;



implementation

var
  QQwry:TCoralWry;

procedure InitPlug();
begin
  QQwry:=TCoralWry.Create('.\CoralWry.dat');
end;

procedure UnInitPlug();
begin
  QQwry.Free;
end;

function  GetIPLocal(Msg:PChar;LoMsg:PChar;LoMsgLen:Integer):integer;stdcall;
var
  sMsg:String;
begin
  sMsg:=QQwry.GetIp(Msg);
  Move(sMsg[1],LoMsg^,Length(sMsg)+1);
  Result:=0;
end;

end.
