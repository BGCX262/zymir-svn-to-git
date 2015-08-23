unit CoralWry;

interface
uses
Classes,Types,SysUtils,Math;

Type

  TCoralWry=Class
  private
    function  ToInt(doint:integer):integer;
    function  GetStartIp(RecNo:dWord):Dword;
    function  GetEndIp():DWORD;
    procedure GetCountry();
    function  GetFlagStr(offset:integer):string;
    function  GetStr():string;
    function  IpToInt(ip:string):DWORD; 
  public
    m_StartIP:DWORD;
    m_EndIP:DWORD;
    m_Country:string;
    m_Local:string;
    m_FirstStartIp:DWORD;
    m_LastStartIp:DWORD;
    m_EndIpOff:integer;
    m_fHandle:integer;
    m_datafile:string;
    m_RecintCount:integer;
    m_CountryFlag:integer; // ��ʶ Countryλ��
                           // 0x01,���3�ֽ�ΪCountryƫ��,û��Local
                           // 0x02,���3�ֽ�ΪCountryƫ�ƣ�������Local
                           // ����,Country,Local,Local�����Ƶ�ѹ�������ܶ������á�
    constructor Create(dbfile:string);virtual;
    destructor Destroy;override;
    Function   GetIp(sIp:string):String;
  end;

implementation

constructor TCoralWry.Create(dbfile:string);
var
  buf:array[0..7]of char;
begin
  m_StartIP:=0;
  m_EndIP:=0;
  m_CountryFlag:=0;
  m_FirstStartIp:=0;
  m_LastStartIp:=0;
  m_EndIpOff:=0;
  m_fHandle:=0;
  m_Local:='';
  m_Country:='';
  m_datafile:=dbfile;
  m_fHandle:=FileOpen(m_datafile,fmOpenRead or fmShareDenyNone);
  if m_fHandle<>0 then begin
    FileSeek(m_fhandle,0,0);
    FileRead(m_fhandle,buf,8);
    m_FirstStartIp:=Toint(ord(buf[0])) + ((toint(ord(buf[1])))*256) + (toint(ord(buf[2]))*256*256) + (toint(ord(buf[3]))*256*256*256);
    m_LastStartIp:=Toint(ord(buf[4])) + (toint(ord(buf[5]))*256) + (toint(ord(buf[6]))*256*256) + (toint(ord(buf[7]))*256*256*256);
    m_RecintCount:=Floor(( m_LastStartIp-m_FirstStartIp ) / 7);
  end;
end;

destructor TCoralWry.Destroy;
begin
  if m_fhandle<>0 then FileClose(m_fhandle);
end;

Function TCoralWry.GetIp(sIp:string):String;
var
  RecNo,RangB,RangE:integer;
  ip:LongWord;
begin
  Result:='δ֪';
  Try
    if m_fhandle=0 then exit;
    RangB:= 0;
    RangE:= m_RecintCount;
    ip:=IpToInt(sIp);
    while (RangB < RangE-1) do 
    begin
      RecNo:= floor((RangB + RangE) / 2);
      GetStartIp(RecNo);
      if ip=m_StartIp then
      begin
        RangB:=Recno;
        break;
      end;
      if ip>m_StartIp then
        RangB:=RecNo
      else
        RangE:=RecNo;
    end;//end of while
    GetStartIp (RangB);
    GetEndIp();
    if((m_startip<=ip)and(m_endip>=ip)) then
    begin
      GetCountry();
      if m_Local='' then Result:=m_Country
      else Result:=Format('%s(%s)',[m_Country,m_Local]);
    end else begin
      m_Country:='δ֪';
      m_Local:='';
    end;
  Except
  end;
end;

function TCoralWry.toInt(doint:integer):integer;
begin 
  Result:=doint;
  if doint<0 then result:=result+256;
end;

function TCoralWry.GetStartIp(RecNo:dWord):Dword;
var
  offset: dWord;
  buf:array[0..7]of char;
begin
  offset := m_FirstStartIp + RecNo * 7 ;
  fileseek ( m_fhandle , offset, 0 ) ;
  fileread ( m_fhandle,buf,7) ;

  m_EndIpOff := toint(ord(buf[4]))
          + (toint(ord(buf[5]))*256 ) 
          + (toint(ord(buf[6]))* 256*256); 
  m_StartIP := toint(ord(buf[0]))
          + (toint(ord(buf[1]))*256) 
          + (toint(ord(buf[2]))*256*256) 
          + (toint(ord(buf[3]))*256*256*256); 
  result:=m_StartIP ; 
end;

function TCoralWry.GetEndIp():DWORD;
var
  buf:array[0..4]of char;
begin 
  FileSeek(m_fhandle,m_endipoff,0);
  FileRead(m_fhandle,buf,5);
  m_EndIP := toint(ord(buf[0])) + (toint(ord(buf[1]))*256) + (toint(ord(buf[2]))*256*256) + (toint(ord(buf[3]))*256*256*256);
  m_CountryFlag := ord ( buf[4] ) ;
  Result:=m_EndIP ;
end;

procedure TCoralWry.GetCountry();
begin
  m_Country:='δ֪';
  m_Local:='';
  case m_CountryFlag of
  1..2:begin
    m_Country := GetFlagStr (m_EndIpOff+4) ;
    if(1 = m_CountryFlag) then
      m_Local := ''
    else
      m_Local := getFlagStr (m_EndIpOff+8);
      end;
  else
    begin
      m_Country := getFlagStr (m_EndIpOff+4) ;
      m_Local :=   getFlagStr ( fileseek(m_fhandle,0,1)) ;
    end;
  end;
end;

function TCoralWry.getFlagStr(offset:integer):string;
var
flag:integer;
buf:Byte;
buffer:array[0..2]of byte;
begin
  while true do
  begin
    FileSeek(m_fhandle,offset,0);
    FileRead(m_fhandle,buf,1);
    flag:=toint(buf);
    if((flag=1)or(flag=2))then
    begin
      FileRead(m_fhandle,buffer,3);
      if flag=2 then
      begin
      m_CountryFlag := 2 ;
      m_EndIpOff := offset - 4 ;
      end;
      offset := toint(ord(buffer[0])) + (toint(ord(buffer[1]))*256) + (toint(ord(buffer[2]))* 256*256);
    end else break;
  end;
  if offset<12 then
  begin
    Result:='';
    exit;
  end;
  FileSeek(m_fhandle,offset,0);
  Result:=getstr();
end;

function TCoralWry.GetStr():string;
var
  buf:byte;
begin
  result:='';
  while true do
  begin
    FileRead(m_fhandle,buf,1);
    if toint(buf)=0 then break;
    result:=result+chr(buf);
  end;
end;

function TCoralWry.IpToInt(ip:string):DWORD;
var 
  str:TStringList;
begin 
  str:=TStringList.Create;
  str.CommaText:=stringreplace(ip,'.',' ',[rfReplaceAll]);
  Result:=(StrToInt(str.Strings[0]) * 256*256*256)
          + (StrToInt(str.Strings[1])*256*256)
          + (StrToInt(str.Strings[2])*256)
          + StrToInt(str.Strings[3]);
  str.Free;
end;

end.
