unit ReadInteger;

interface

uses
  SysUtils,StrUtils,Classes,Windows,WinInet;

type
  TReadInteger = class(TThread)
    m_UrlFile:String;
  private
    function GetInetFile(fileURL:String):String;
  protected
    procedure Execute; override;
  public
    constructor Create(UrlText:String);
  end;

implementation
uses
MShare;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TReadInteger.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TReadInteger }

constructor TReadInteger.Create(UrlText:String);
begin
  m_UrlFile:=UrlText;
  inherited Create(False);

end;

procedure TReadInteger.Execute;
begin
  g_InetStr:=GetInetFile(m_UrlFile);
  g_boInetStr:=True;
end;

function TReadInteger.GetInetFile(fileURL:String):String;
var
  hSession,hURL:HInternet;
  Buffer:array[0..2048] of Byte;
  BufferLen:DWORD;
begin
  Result:='';
  hSession:=InternetOpen(PChar(fileURL),INTERNET_OPEN_TYPE_PRECONFIG,nil,nil,0);
  try
    hURL:=InternetOpenURL(hSession,PChar(fileURL),nil,0,0,0);
    try
      repeat
        FillChar(Buffer,SizeOf(Buffer),#0);
        InternetReadFile(hURL,@Buffer,SizeOf(Buffer)-1,BufferLen);
        if BufferLen > 0 then Result:=Result+StrPas(PChar(@Buffer));
      until BufferLen <= 0;
    finally
      InternetCloseHandle(hURL)
    end;
  finally
    InternetCloseHandle(hSession)
  end;
end;

end.
