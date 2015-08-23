unit Main;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,inifiles,winsock,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls,EDcode,Grobal2,
  JSocket;

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

  TMainForm = class(TForm)
    StatusLine: TStatusBar;
    SSocket: TServerSocket;
    Memo1: TMemo;
    Panel1: TPanel;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Button1: TButton;
    Button3: TButton;
    Edit7: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit8: TEdit;
    Label3: TLabel;
    Edit9: TEdit;
    Label4: TLabel;
    Edit10: TEdit;
    Label5: TLabel;
    Edit11: TEdit;
    Label6: TLabel;
    Edit12: TEdit;
    Label7: TLabel;
    Edit13: TEdit;
    Label8: TLabel;
    Edit14: TEdit;
    Label9: TLabel;
    Edit15: TEdit;
    Label10: TLabel;
    Edit16: TEdit;
    Label11: TLabel;
    Edit17: TEdit;
    Label12: TLabel;
    Edit18: TEdit;
    Label13: TLabel;
    Edit19: TEdit;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure SSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormDestroy(Sender: TObject);
  public
    procedure ProcMsg(Socket: TCustomWinSocket;msg:TDefaultMessage;data:String);
    procedure SendSocket (Socket: TCustomWinSocket;sendstr: string);
    procedure AddMsg(S:String);
    procedure ProcLogin(Socket:TCustomWinSocket;Data:String);
    procedure BroadcaseSay(ActorID:Integer;data:String);
    procedure QueryBag(Socket:TCustomWinSocket;Who:String);
    function CheckPassword(Userid,password:string):Integer;
    function QueryChar(LoginID:String):String;
    procedure GetCharAbility(var Playerinfo:TPlayerinfo);
  end;

var
  MainForm: TMainForm;
  UserInfo:TInifile;
  PlayerInfo:TPlayerInfo;
  light:integer=0;
implementation

{$r *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  //playerMan:=TPlayerManager.create;
  Application.OnHint := ShowHint;
  SSocket.Active:=true;
  UserInfo:=TInifile.Create('data\UserInfo.ini');
end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
  StatusLine.SimpleText := Application.Hint;
end;

procedure TMainForm.SSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
   data, data2: string;
   dmsg: TDefaultMessage;
   tmpstr:String;
begin
   data := Socket.ReceiveText;
   delete(data,1,2);
   data:=copy(data,1,length(data)-1);
   Memo1.lines.add('Recv:'+data);
   tmpstr:=decodestring(data);
   if copy(tmpstr,1,2)='**' then
   begin
     ProcLogin(Socket,Tmpstr);
     exit;
   end;
   data2:=copy(data,1,DEFBLOCKSIZE);
   delete(data,1,DEFBLOCKSIZE);
   dmsg:=DecodeMessage(Data2);
   addMsg('Tran:Ident='+inttostr(dmsg.Ident)+',Recog='+inttostr(dmsg.Recog)+
     ',Para='+Inttostr(Dmsg.Param)+',Tag='+Inttostr(dmsg.tag)+
     ',Series='+Inttostr(Dmsg.Series)+',Data='+Data+' is'+DecodeString(Data));
   ProcMsg(Socket,dmsg,data);
end;

procedure TMainForm.Button2Click(Sender: TObject);
type
  TMapHeader =record
     Width  : word;                      //宽度      2
     Height : word;                      //高度      2
     Title: string[16];                  //标题      20
     UpdateDate: double;              //更新日期  8
     Reserved  : array[1..20] of char;   //保留      20
  end;

var
  dmsg: TDefaultMessage;
  s:TMapHeader;
  d:TDateTime;
begin
  //s.Title:='我们这里不管这些';
  Memo1.lines.add(inttostr(sizeof(s)));
end;     

Var
   code: byte = 1;
procedure TMainForm.SendSocket (Socket: TCustomWinSocket;sendstr: string);
var
 s:string;
begin
   if Socket.Connected then begin
      s:='#' + sendstr + '!';
      Socket.SendText (s);
      Inc (code);
      if code >= 10 then code := 1;
      Memo1.lines.Add('Send:'+s);
   end;
end;
procedure TMainForm.ProcMsg(Socket: TCustomWinSocket;msg: TDefaultMessage; data: String);
var
   dmsg :TDefaultMessage;
   s:string;
   LoginId,Certification:String;
   desc:TCharDesc;
   i:integer;
begin
  case Msg.Ident of
    CM_IDPASSWORD: begin
        data:=decodestring(data);
        LoginId:=copy(data,1,pos('/',data)-1);
        PlayerInfo.UserID:=pchar(LoginID);
        delete(data,1,pos('/',data));
        I:=CheckPassword(LoginID,data);
        if i=0 then
           dmsg := MakeDefaultMsg (SM_PASSOK_SELECTSERVER, 0, 0, 0, 0)
        else
           dmsg := MakeDefaultMsg (SM_PASSWD_FAIL, i, 0, 0, 0);
        SendSocket(Socket,EncodeMessage(dmsg));
      end;
    CM_SELECTSERVER:begin
       dmsg := MakeDefaultMsg (SM_SELECTSERVER_OK, 0, 0, 0, 0);
       s:='127.0.0.1/7000/0/';
       AddMsg('Select Server');
       SendSocket(Socket,EncodeMessage(dmsg)+EncodeString(S));
    end;
    CM_NEWCHR:begin
       dmsg := MakeDefaultMsg (SM_NEWCHR_SUCCESS, 0, 0, 0, 0);
       AddMsg('New Chr');
       SendSocket(Socket,EncodeMessage(dmsg));
    end;
    CM_QUERYCHR:Begin
       Data:=DecodeString(Data);
       LoginID:=copy(data,1,pos('/',data)-1);
       delete(data,1,pos('/',data));
       Memo1.Lines.add('QueryChar:'+LoginID+',Certif:'+data);
       s:=QueryChar(LoginID);
       dmsg := MakeDefaultMsg (SM_QUERYCHR, 0, 0, 0, 0);
       SendSocket(Socket,EncodeMessage(dmsg)+EncodeString(s));
    end;
    CM_DELCHR:Begin
      dmsg := MakeDefaultMsg (SM_DELCHR_SUCCESS, 0, 0, 0, 0);
      SendSocket(Socket,EncodeMessage(dmsg));
    end;
    CM_SELCHR:begin  //选择了一个角色(用户ID/角色名)
       //服务器
       Data:=DecodeString(Data);
       LoginID:=copy(data,1,pos('/',data)-1);   //ID
       Playerinfo.UserID:=pchar(LoginID);
       delete(data,1,pos('/',data));            //ChrName
       Playerinfo.CharName:=pchar(data);
       Playerinfo.Job:=UserInfo.ReadInteger(Playerinfo.CharName,'Job',0);
       dmsg := MakeDefaultMsg (SM_STARTPLAY, 0, 0, 0, 0);
       Playerinfo.server:=pchar(UserInfo.ReadString(Playerinfo.CharName,'server','127.0.0.1/7000'));
       SendSocket(Socket,EncodeMessage(dmsg)+EncodeString(Playerinfo.server));
       //地图
       Playerinfo.X:=UserInfo.ReadInteger(Playerinfo.CharName,'x',300);
       Playerinfo.Y:=UserInfo.ReadInteger(Playerinfo.CharName,'y',300);
       Playerinfo.dir:=UserInfo.ReadInteger(Playerinfo.CharName,'dir',0);
       Playerinfo.map:=pchar(UserInfo.ReadString(Playerinfo.CharName,'map','0'));
       dmsg := MakeDefaultMsg (SM_NEWMAP, 0, Playerinfo.X, Playerinfo.X, Playerinfo.dir);
       SendSocket(Socket,EncodeMessage(dmsg)+EncodeString(Playerinfo.map));
    end;
    CM_QUERYBAGITEMS:begin  //After Log on
       QueryBag(Socket,'');
       Playerinfo.Gold:=200000;
       dmsg := MakeDefaultMsg (SM_ABILITY, Playerinfo.Gold, Playerinfo.job, 0, 0); //SM_ABILITY，金子数，职业
       GetCharAbility(PlayerInfo);
       SendSocket(Socket,EncodeMessage(dmsg)+EncodeBuffer(@Playerinfo.ab,sizeof(TAbility)));

       dmsg := MakeDefaultMsg (SM_FEATURECHANGED,0,48,$FF,0);
       SendSocket(Socket,EncodeMessage(dmsg));
    end;
    CM_PICKUP:Begin

    end;
    CM_WANTMINIMAP:Begin
       dmsg := MakeDefaultMsg (SM_READMINIMAP_OK, 0, 1, 0, 0);
       s:='';
       SendSocket(Socket,EncodeMessage(dmsg)+EncodeString(s));
    END;
    CM_SAY:Begin
       BroadcaseSay(0,decodestring(data));
    end;
    CM_DEALTRY:Begin
       dmsg := MakeDefaultMsg (SM_DEALMENU, 0, 0, 0, 0);
       s:='谢依凡';
       SendSocket(Socket,EncodeMessage(dmsg)+EncodeString(s));
    end;
    CM_EAT:begin
       dmsg := MakeDefaultMsg (SM_EAT_OK, 0, 0, 0, 0);
       s:='';
       SendSocket(Socket,EncodeMessage(dmsg)+EncodeString(s));
    end;
    CM_QUERYUSERNAME:begin
       dmsg := MakeDefaultMsg (SM_USERNAME, 0, 0, 0, 0);
       s:='谢依凡\';
       SendSocket(Socket,EncodeMessage(dmsg)+EncodeString(s));
    end;
    CM_WALK:Begin
       PlayerInfo.X:=low(msg.recog);
       PlayerInfo.Y:=high(msg.recog);
       PlayerInfo.dir:=msg.Tag;
       dmsg := MakeDefaultMsg (SM_WALK,0,PlayerInfo.x, PlayerInfo.y, PlayerInfo.dir+light*256);
       desc.Feature:=MakeFeature(0,4,2,5,20);
       desc.Status:=0;
       SendSocket(Socket,EncodeMessage(dmsg)+EncodeBuffer(@desc,sizeof(TCharDesc)));

       if (PlayerInfo.X=11) and (playerinfo.Y=14) then
       begin
          Playerinfo.map:='4';
          dmsg := MakeDefaultMsg (SM_NEWMAP, 0, 200, 200, Playerinfo.dir);
          SendSocket(Socket,EncodeMessage(dmsg)+EncodeString(Playerinfo.map));
       end;
    end;
    CM_DEALADDITEM:Begin
       dmsg := MakeDefaultMsg (SM_DEALADDITEM_OK, 0, 0, 0, 0);
       SendSocket(Socket,EncodeMessage(dmsg));
    end;
    CM_TAKEONITEM:Begin
       dmsg := MakeDefaultMsg (SM_TAKEON_OK, 1, 0, 0, 0);
       SendSocket(Socket,EncodeMessage(dmsg));
    end;
    CM_TAKEOFFITEM:Begin
       dmsg := MakeDefaultMsg (SM_TAKEOFF_OK, 1, 0, 0, 0);
       SendSocket(Socket,EncodeMessage(dmsg));
    end;
    CM_TURN:begin
       PlayerInfo.X:=low(msg.Recog);
       PlayerInfo.Y:=high(msg.Recog);
       PlayerInfo.dir:=msg.Tag;
       dmsg := MakeDefaultMsg (SM_TURN, 0, PlayerInfo.x, PlayerInfo.y, makeword(light,PlayerInfo.dir)); //消息，角色编号，X,Y,dir + light
       desc.Feature:=1;
       desc.Status:=0;
       SendSocket(Socket,EncodeMessage(dmsg)+Encodebuffer(@desc,sizeof(TCharDesc)));
    end;
    CM_CREATEGROUP:begin
       dmsg := MakeDefaultMsg (SM_CREATEGROUP_OK, 0, 0, 0, 0);
       SendSocket(Socket,EncodeMessage(dmsg));
    end;
    CM_RUN:Begin
       PlayerInfo.X:=low(msg.Recog);
       PlayerInfo.Y:=high(msg.Recog);
       PlayerInfo.dir:=msg.Tag;
       dmsg := MakeDefaultMsg (SM_RUN, 0, PlayerInfo.x, PlayerInfo.y, makeword(light,PlayerInfo.dir)); //消息，角色编号，X,Y,dir + light
       desc.Feature:=0;
       desc.Status:=0;
       SendSocket(Socket,EncodeMessage(dmsg)+Encodebuffer(@desc,sizeof(TCharDesc)));
    end;
    CM_OPENDOOR:Begin
       dmsg := MakeDefaultMsg (SM_OPENDOOR_OK, 0, msg.param, msg.tag, 0);
       SendSocket(Socket,EncodeMessage(dmsg));
    end;
  end;
end;

procedure TMainForm.AddMsg(S: String);
begin
  Memo1.Lines.add(S);
end;

procedure TMainForm.ProcLogin(Socket: TCustomWinSocket; Data: String);
var
  LoginID,CharName,Certi,VerNum,Str:String;
  dmsg :TDefaultMessage;
  wl:TMessageBodyWL;
  s:string;
begin
  str :=Copy(Data,3,Length(Data)-2);
  LoginID:=Copy(Str,1,Pos('/',Str)-1);
  delete(Str,1,Pos('/',Str));
  CharName:=Copy(Str,1,Pos('/',Str)-1);
  delete(Str,1,Pos('/',Str));
  Certi:=Copy(Str,1,Pos('/',Str)-1);
  delete(Str,1,Pos('/',Str));
  VerNum:=Copy(Str,1,Pos('/',Str)-1);
  dmsg := MakeDefaultMsg (SM_LOGON, 0, PlayerInfo.x, PlayerInfo.Y, MakeWord(light,PlayerInfo.dir));  //参数：消息,角色号(0/1)，位置x,位置y，方向
  with wl do
  begin
    lParam1:=1;    //desc.Feature,
    lParam2:=0;    //desc.Status
    lTag1:=0;      //Loword(ltag1)=1则可以组队
    lTag2:=0;
  end;
  AddMsg('Log On!');
  s:='';//EncodeBuffer (@wl,sizeof(TMessageBodyWL));
  SendSocket(Socket,EncodeMessage(dmsg)+s);
end;

procedure TMainForm.BroadcaseSay(ActorID:Integer;data:String);
var
  i:integer;
  dmsg :TDefaultMessage;
  s:String;
begin
  dmsg:=MakeDefaultMsg(SM_HEAR,ActorID,smallint($FF00 or $0000),0,0);
  s:=EncodeMessage(dmsg)+EnCodeString(Data);
  for i:= 0 to ssocket.Socket.ActiveConnections - 1 do
  begin
     SendSocket(ssocket.Socket.Connections[i],s);
  end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
var
  i:integer;
  dmsg :TDefaultMessage;
  s:String;
  desc:TCharDesc;
begin

  dmsg := MakeDefaultMsg (SM_SHOWEVENT, 0, 20, 20, 0);
  s:=edit6.text;
  SendSocket(ssocket.Socket.Connections[0],EncodeMessage(dmsg)+EncodeString(s));
  exit;

  dmsg := MakeDefaultMsg (SM_NEWMAP, 0, 20, 20, 0);
  s:=edit6.text;
  SendSocket(ssocket.Socket.Connections[0],EncodeMessage(dmsg)+EncodeString(s));
  exit;

  dmsg := MakeDefaultMsg (SM_WALK, 0, PlayerINfo.x, Playerinfo.Y, 0);
  desc.Feature:=2;
  desc.Status:=0;
  SendSocket(ssocket.Socket.Connections[0],EncodeMessage(dmsg)+EncodeBuffer(@desc,sizeof(TCharDesc)));


  dmsg:=MakeDefaultMsg(strtointdef(edit1.text,0),strtointdef(edit2.text,0),
    strtointdef(edit3.text,0),strtointdef(edit4.text,0),strtointdef(edit5.text,0));
  s:=edit6.text;
  s:=EncodeMessage(dmsg)+EncodeString(s);
  for i:= 0 to ssocket.Socket.ActiveConnections - 1 do
  begin
     SendSocket(ssocket.Socket.Connections[i],s);
  end;
end;

procedure TMainForm.QueryBag(Socket: TCustomWinSocket; Who: String);
var
  dmsg:TDefaultMessage;
  s:String;
  ci:TClientItem;
begin
   dmsg := MakeDefaultMsg (SM_BAGITEMS, 0, 0, 0, 0);
   s:='';
   ci.s.Name:='超级武器';
   ci.s.Looks:=100;
   ci.s.StdMode:=5;
   ci.s.Shape:=45;
   ci.s.AC:=10;
   ci.MakeIndex:=1;
   ci.Dura:=10;
   ci.DuraMax:=20;
   s:=encodebuffer(@ci,sizeof(TClientItem))+'/';
   SendSocket(Socket,EncodeMessage(dmsg)+s);
end;

procedure TMainForm.Button3Click(Sender: TObject);
var
  dmsg:TDefaultMessage;
  s:String;
  ci:TClientItem;
begin
   dmsg := MakeDefaultMsg (SM_ADDITEM, 0, 0, 0, 0);
   s:='';
   ci.s.Name:=edit7.text;
   ci.s.Looks:=strtointdef(edit8.text,0);
   ci.s.StdMode:=strtointdef(edit9.text,0);;
   ci.s.Shape:=strtointdef(edit10.text,0);;
   ci.s.AC:=strtointdef(edit11.text,0);
   ci.s.MAC:=strtointdef(edit12.text,0);
   ci.s.DC:=strtointdef(edit16.text,0);
   ci.s.mc:=strtointdef(edit17.text,0);
   ci.s.SC:=strtointdef(edit18.text,0);
   ci.s.DuraMax:=strtointdef(edit14.text,0);
   ci.s.NeedIdentify:=strtointdef(edit16.text,0);
   ci.MakeIndex:=strtointdef(edit19.text,0);
   ci.Dura:=10;
   ci.DuraMax:=20;
   s:=encodebuffer(@ci,sizeof(TClientItem));
   SendSocket(SSocket.Socket.Connections[0],EncodeMessage(dmsg)+s);
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  i:integer;
  s:String;
begin
  s:='#+GOOD/'+inttostr(gettickcount)+'!';
  for i:= 0 to ssocket.Socket.ActiveConnections - 1 do
  begin
     try
     if ssocket.Socket.Connections[i].Connected then
       ssocket.Socket.Connections[i].SendText(s);
     except
       
     end;
  end;
end;

procedure TMainForm.SSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  timer1.Enabled:=false;
end;

function TMainForm.CheckPassword(Userid, password: string): Integer;
var
  s:string;
begin
  s:=Userinfo.ReadString(UserID,'password','');
  if s='' then begin result:=-1;exit;end;
  if password=s then
     result:=0
  else result:=-2;
end;

function TMainForm.QueryChar(LoginID: String): String;
var
  i:integer;
  s:string;
  charname:string;
begin
  result:='';
  for i:=1 to 2 do
  begin
    charname:=userinfo.readstring(LoginID,'Char'+inttostr(i),'');
    if length(charname)=0 then continue;
    result:=result+charname+'/';
    result:=result+userinfo.ReadString(charname,'job','0')+'/';
    result:=result+userinfo.ReadString(charname,'hair','0')+'/';
    result:=result+userinfo.ReadString(charname,'level','1')+'/';
    result:=result+userinfo.ReadString(charname,'sex','0')+'/';
  end;
end;

procedure TMainForm.GetCharAbility(var Playerinfo: TPlayerinfo);
begin
  with Playerinfo.ab do
  begin
     MP:=UserInfo.ReadInteger(PlayerInfo.CharName,'MP',600);
     MaxMP:=UserInfo.ReadInteger(PlayerInfo.CharName,'MaxMP',900);
     HP:=UserInfo.ReadInteger(PlayerInfo.CharName,'HP',500);
     MaxHP:=UserInfo.ReadInteger(PlayerInfo.CharName,'MaxHP',600);;
     Exp:=UserInfo.ReadInteger(PlayerInfo.CharName,'EXP',1000);;
     MaxExp:=UserInfo.ReadInteger(PlayerInfo.CharName,'MaxExP',1200);;
     Level:=UserInfo.ReadInteger(PlayerInfo.CharName,'Level',1);;
     Weight:=UserInfo.ReadInteger(PlayerInfo.CharName,'Weight',0);;
     MaxWeight:=UserInfo.ReadInteger(PlayerInfo.CharName,'MaxWeight',100);;
     WearWeight:=UserInfo.ReadInteger(PlayerInfo.CharName,'WearWeight',0);;
     MaxWearWeight:=UserInfo.ReadInteger(PlayerInfo.CharName,'MaxWearWeight',100);;
     HandWeight:=UserInfo.ReadInteger(PlayerInfo.CharName,'HandWeight',0);;
     MaxHandWeight:=UserInfo.ReadInteger(PlayerInfo.CharName,'MaxHandWeight',100);
     AC:=UserInfo.ReadInteger(PlayerInfo.CharName,'AC',20);;
     MAC:=UserInfo.ReadInteger(PlayerInfo.CharName,'MAC',30);;
     DC:=UserInfo.ReadInteger(PlayerInfo.CharName,'DC',30);;
     SC:=UserInfo.ReadInteger(PlayerInfo.CharName,'SC',25);;
     MC:=UserInfo.ReadInteger(PlayerInfo.CharName,'MC',15);;
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  UserInfo.Free;
end;

end.
