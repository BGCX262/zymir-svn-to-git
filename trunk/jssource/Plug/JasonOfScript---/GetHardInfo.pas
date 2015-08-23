unit GetHardInfo;

interface
uses
  Windows, SysUtils, Classes;

const
  MAX_HOSTNAME_LEN = 128; { from IPTYPES.H }
  MAX_DOMAIN_NAME_LEN = 128;
  MAX_SCOPE_ID_LEN = 256;
  MAX_ADAPTER_NAME_LENGTH = 256;
  MAX_ADAPTER_DESCRIPTION_LENGTH = 128;
  MAX_ADAPTER_ADDRESS_LENGTH = 8;

type
  TIPAddressString = array[0..4 * 4 - 1] of Char;

  PIPAddrString = ^TIPAddrString;
  TIPAddrString = record
    Next: PIPAddrString;
    IPAddress: TIPAddressString;
    IPMask: TIPAddressString;
    Context: Integer;
  end;

  PIPAdapterInfo = ^TIPAdapterInfo;
  TIPAdapterInfo = record { IP_ADAPTER_INFO }
    Next: PIPAdapterInfo;
    ComboIndex: Integer;
    AdapterName: array[0..MAX_ADAPTER_NAME_LENGTH + 3] of Char;
    Description: array[0..MAX_ADAPTER_DESCRIPTION_LENGTH + 3] of Char;
    AddressLength: Integer;
    Address: array[1..MAX_ADAPTER_ADDRESS_LENGTH] of Byte;
    Index: Integer;
    _Type: Integer;
    DHCPEnabled: Integer;
    CurrentIPAddress: PIPAddrString;
    IPAddressList: TIPAddrString;
    GatewayList: TIPAddrString;
    DHCPServer: TIPAddrString;
    HaveWINS: Bool;
    PrimaryWINSServer: TIPAddrString;
    SecondaryWINSServer: TIPAddrString;
    LeaseObtained: Integer;
    LeaseExpires: Integer;
  end;
function GetAdaptersInfo(AI: PIPAdapterInfo; var BufLen: Integer): Integer; StdCall; External 'iphlpapi.dll' Name 'GetAdaptersInfo';
function DecodeString_3des(Source, Key: string): string;
function EncodeString_3des(Source, Key: string): string;
function EncodeBuf_3des(const Source;size:Integer; Key: string): string;
function CalcFileMd5(sFileName: string): string;
function GetMachineID: string;
function SaveReg(sRegInfo, sFileName: string): Boolean;
function ReadReg(var sRegInfo:string;sFileName: string): Boolean;
function CRCode(sName: string): string;
function GetCPUAndMacInfo(Num: Byte=0):string;
implementation
  uses DCPcrypt, U_DES, Md5,Base64;

//-----------------------------------------------------------------------
//获取CPU硬件信息
//-----------------------------------------------------------------------
//参数：
// InfoID:=1 获取CPU序列号
// InfoID:=2 获取CPU 频率
// InfoID:=3 获取CPU厂商
//-----------------------------------------------------------------------
function GetCPUInfo(InfoID: Byte): String;
var
  _eax, _ebx, _ecx, _edx: Longword;
  i: Integer;
  b: Byte;
//  b1: Word;
  s, s1, s2, s3, s_all: string;
begin
case InfoID of  //获取CPU序列号
 1:
 begin
   asm
    mov eax,1
    db $0F,$A2
    mov _eax,eax
    mov _ebx,ebx
    mov _ecx,ecx
    mov _edx,edx
  end;
  s := IntToHex(_eax, 8);
  s1 := IntToHex(_edx, 8);
  s2 := IntToHex(_ecx, 8);
  Insert('-', s, 5);
  Insert('-', s1, 5);
  Insert('-', s2, 5);
  result:=s + '-' + s1 + '-' + s2;
 end;
 2: //获取 CPU 频率
 begin
  asm     //execute the extended CPUID inst. 
    mov eax,$80000000   //sub. func call 
    db $0F,$A2 
    mov _eax,eax 
  end; 
  if _eax > $80000000 then  //any other sub. funct avail. ? 
  begin
    asm     //get brand ID
      mov eax,$80000002
      db $0F
      db $A2
      mov _eax,eax
      mov _ebx,ebx
      mov _ecx,ecx
      mov _edx,edx
    end; 
    s  := ''; 
    s1 := ''; 
    s2 := ''; 
    s3 := ''; 
    for i := 0 to 3 do 
    begin 
      b := lo(_eax); 
      s3:= s3 + chr(b); 
      b := lo(_ebx); 
      s := s + chr(b); 
      b := lo(_ecx); 
      s1 := s1 + chr(b); 
      b := lo(_edx); 
      s2 := s2 + chr(b); 
      _eax := _eax shr 8; 
      _ebx := _ebx shr 8; 
      _ecx := _ecx shr 8; 
      _edx := _edx shr 8; 
    end;
    s_all := trim(s3 + s + s1 + s2);
    asm 
      mov eax,$80000003 
      db $0F 
      db $A2 
      mov _eax,eax 
      mov _ebx,ebx 
      mov _ecx,ecx 
    mov _edx,edx 
    end; 
    s  := ''; 
    s1 := ''; 
    s2 := ''; 
    s3 := ''; 
    for i := 0 to 3 do 
    begin 
      b := lo(_eax); 
      s3 := s3 + chr(b); 
      b := lo(_ebx); 
      s := s + chr(b); 
      b := lo(_ecx); 
      s1 := s1 + chr(b); 
      b := lo(_edx); 
      s2 := s2 + chr(b); 
      _eax := _eax shr 8; 
      _ebx := _ebx shr 8; 
      _ecx := _ecx shr 8; 
      _edx := _edx shr 8; 
    end; 
    s_all := s_all + s3 + s + s1 + s2; 
    asm
      mov eax,$80000004
      db $0F
      db $A2
      mov _eax,eax
      mov _ebx,ebx
      mov _ecx,ecx
      mov _edx,edx
    end;
    s  := '';
    s1 := '';
    s2 := '';
    s3 := '';
    for i := 0 to 3 do
    begin
      b  := lo(_eax);
      s3 := s3 + chr(b);
      b := lo(_ebx);
      s := s + chr(b);
      b := lo(_ecx);
      s1 := s1 + chr(b);
      b  := lo(_edx);
      s2 := s2 + chr(b);
      _eax := _eax shr 8;
      _ebx := _ebx shr 8;
      _ecx := _ecx shr 8;
      _edx := _edx shr 8;
    end;
    if s2[Length(s2)] = #0 then setlength(s2, Length(s2) - 1);
    result:= s_all + s3 + s + s1 + s2;
  end
  else
    result:= '';

 end;
 3: //获取 CPU厂商
 begin
  asm                //asm call to the CPUID inst.
    mov eax,0         //sub. func call
    db $0F,$A2         //db $0F,$A2 = CPUID instruction
    mov _ebx,ebx
    mov _ecx,ecx
    mov _edx,edx
  end;
  for i := 0 to 3 do   //extract vendor id 
  begin
    b := lo(_ebx);
    s := s + chr(b);
    b := lo(_ecx);
    s1:= s1 + chr(b);
    b := lo(_edx);
    s2:= s2 + chr(b);
    _ebx := _ebx shr 8;
    _ecx := _ecx shr 8;
    _edx := _edx shr 8;
  end;
  result:=s + s2 + s1;
 end;
 else
  result:='错误的信息标识!';
end;

end;

function GetMac: string;
var
  AI, Work: PIPAdapterInfo;
  Size: Integer;
  Res: Integer;
  function MACToStr(ByteArr: PByte; Len: Integer): string;
  begin
    Result := '';
    while (Len > 0) do begin
      Result := Result + IntToHex(ByteArr^, 2); //+'-';加密取-
      ByteArr := Pointer(Integer(ByteArr) + SizeOf(Byte));
      Dec(Len);
    end;
    SetLength(Result, Length(Result) - 1); { remove last dash }
  end;

begin
  Size := 5120;
  GetMem(AI, Size);
  Res := GetAdaptersInfo(AI, Size);
  Result := '';
  if (Res <> ERROR_SUCCESS) then begin
    SetLastError(Res);
    RaiseLastWin32Error;
  end;
  Work := AI;
  Result := MACToStr(@Work^.Address, Work^.AddressLength);
  FreeMem(AI);
end;

function GetIdeSerialNumber: string;
const IDENTIFY_BUFFER_SIZE = 512;
type
  TIDERegs = packed record
    bFeaturesReg: BYTE; // Used for specifying SMART "commands".
    bSectorCountReg: BYTE; // IDE sector count register
    bSectorNumberReg: BYTE; // IDE sector number register
    bCylLowReg: BYTE; // IDE low order cylinder value
    bCylHighReg: BYTE; // IDE high order cylinder value
    bDriveHeadReg: BYTE; // IDE drive/head register
    bCommandReg: BYTE; // Actual IDE command.
    bReserved: BYTE; // reserved for future use. Must be zero.
  end;
  TSendCmdInParams = packed record
    // Buffer size in bytes
    cBufferSize:Windows.DWORD;
    // Structure with drive register values.
    irDriveRegs: TIDERegs;
    // Physical drive number to send command to (0,1,2,3).
    bDriveNumber: BYTE;
    bReserved: array[0..2] of Byte;
    dwReserved: array[0..3] of DWORD;
    bBuffer: array[0..0] of Byte; // Input buffer.
  end;

  TIdSector = packed record
    wGenConfig: Word;
    wNumCyls: Word;
    wReserved: Word;
    wNumHeads: Word;
    wBytesPerTrack: Word;
    wBytesPerSector: Word;
    wSectorsPerTrack: Word;
    wVendorUnique: array[0..2] of Word;
    sSerialNumber: array[0..19] of CHAR;
    wBufferType: Word;
    wBufferSize: Word;
    wECCSize: Word;
    sFirmwareRev: array[0..7] of Char;
    sModelNumber: array[0..39] of Char;
    wMoreVendorUnique: Word;
    wDoubleWordIO: Word;
    wCapabilities: Word;
    wReserved1: Word;
    wPIOTiming: Word;
    wDMATiming: Word;
    wBS: Word;
    wNumCurrentCyls: Word;
    wNumCurrentHeads: Word;
    wNumCurrentSectorsPerTrack: Word;
    ulCurrentSectorCapacity:Windows.DWORD;
    wMultSectorStuff: Word;
    ulTotalAddressableSectors: Windows.DWORD;
    wSingleWordDMA: Word;
    wMultiWordDMA: Word;
    bReserved: array[0..127] of BYTE;
  end;
  PIdSector = ^TIdSector;

  TDriverStatus = packed record
    // Error code from driver, or 0 if no error.
    bDriverError: Byte;
    // Contents of IDE Error register. Only valid when bDriverError is SMART_IDE_ERROR.
    bIDEStatus: Byte;
    bReserved: array[0..1] of Byte;
    dwReserved: array[0..1] of Windows.DWORD;
  end;

  TSendCmdOutParams = packed record
    // Size of bBuffer in bytes
    cBufferSize:Windows.DWORD;
    // Driver status structure.
    DriverStatus: TDriverStatus;
    // Buffer of arbitrary length in which to store the data read from the drive.
    bBuffer: array[0..0] of BYTE;
  end;

var
  hDevice: THandle;
  cbBytesReturned:Windows.DWORD;
  ptr: PChar;
  SCIP: TSendCmdInParams;
  aIdOutCmd: array
  [0..(SizeOf(TSendCmdOutParams) + IDENTIFY_BUFFER_SIZE - 1) - 1] of Byte;
  IdOutCmd: TSendCmdOutParams absolute aIdOutCmd;

  procedure ChangeByteOrder(var Data; Size: Integer);
  var
    ptr: PChar;
    i: Integer;
    c: Char;
  begin
    ptr := @Data;
    for i := 0 to (Size shr 1) - 1 do begin
      c := ptr^;
      ptr^ := (ptr + 1)^;
      (ptr + 1)^ := c;
      Inc(ptr, 2);
    end;
  end;
begin
  Result := ''; // return empty string on error
  if SysUtils.Win32Platform = VER_PLATFORM_WIN32_NT then // Windows NT,Windows 2000
  begin
    // warning! change name for other drives: ex.: second drive '\\.\PhysicalDrive1\'
    hDevice := CreateFile('\\.\PhysicalDrive0', GENERIC_READ or
      GENERIC_WRITE,
      FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
  end else // Version Windows 95 OSR2, Windows 98
    hDevice := CreateFile('\\.\SMARTVSD', 0, 0, nil, CREATE_NEW, 0, 0);
  if hDevice = INVALID_HANDLE_VALUE then Exit;

  try
    FillChar(SCIP, SizeOf(TSendCmdInParams) - 1, #0);
    FillChar(aIdOutCmd, SizeOf(aIdOutCmd), #0);
    cbBytesReturned := 0;
    // Set up data structures for IDENTIFY command.
    with SCIP do begin
      cBufferSize := IDENTIFY_BUFFER_SIZE;
      // bDriveNumber := 0;
      with irDriveRegs do begin
        bSectorCountReg := 1;
        bSectorNumberReg := 1;
        // if Win32Platform=VER_PLATFORM_WIN32_NT then bDriveHeadReg := $A0
        // else bDriveHeadReg := $A0 or ((bDriveNum and 1) shl 4);
        bDriveHeadReg := $A0;
        bCommandReg := $EC;
      end;
    end;
    if not DeviceIoControl(hDevice, $0007C088, @SCIP,
      SizeOf(TSendCmdInParams) - 1,
      @aIdOutCmd, SizeOf(aIdOutCmd), cbBytesReturned, nil) then Exit;
  finally
    CloseHandle(hDevice);
  end;

  with PIdSector(@IdOutCmd.bBuffer)^ do begin
    ChangeByteOrder(sSerialNumber, SizeOf(sSerialNumber));
    (PChar(@sSerialNumber) + SizeOf(sSerialNumber))^ := #0;
    Result := PChar(@sSerialNumber);
  end;
end;

function ScsiHddSerialNumber: string;
{$ALIGN ON}
type
  TScsiPassThrough = record
    Length: Word;
    ScsiStatus: Byte;
    PathId: Byte;
    TargetId: Byte;
    Lun: Byte;
    CdbLength: Byte;
    SenseInfoLength: Byte;
    DataIn: Byte;
    DataTransferLength: ULONG;
    TimeOutValue: ULONG;
    DataBufferOffset: Windows.DWORD;
    SenseInfoOffset: ULONG;
    Cdb: array[0..15] of Byte;
  end;
  TScsiPassThroughWithBuffers = record
    spt: TScsiPassThrough;
    bSenseBuf: array[0..31] of Byte;
    bDataBuf: array[0..191] of Byte;
  end;
{ALIGN OFF}
var
  dwReturned: Windows.DWORD;
  len: DWORD;
  Buffer: array[0..255] of Byte;
  sptwb: TScsiPassThroughWithBuffers absolute Buffer;
  DeviceHandle: THandle;
begin
  Result := '';
  if SysUtils.Win32Platform = VER_PLATFORM_WIN32_NT then begin // Windows NT, Windows 2000
        // 提示! 改变名称可适用于其它驱动器，如第二个驱动器： '\\.\PhysicalDrive1\'
    DeviceHandle := CreateFile('\\.\PhysicalDrive0', GENERIC_READ or GENERIC_WRITE,
      FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
  end else // Version Windows 95 OSR2, Windows 98
    DeviceHandle := CreateFile('\\.\SMARTVSD', 0, 0, nil, CREATE_NEW, 0, 0);
  if DeviceHandle = INVALID_HANDLE_VALUE then Exit;
  try
    FillChar(Buffer, SizeOf(Buffer), #0);
    with sptwb.spt do
    begin
      Length := SizeOf(TScsiPassThrough);
      CdbLength := 6; // CDB6GENERIC_LENGTH
      SenseInfoLength := 24;
      DataIn := 1; // SCSI_IOCTL_DATA_IN
      DataTransferLength := 192;
      TimeOutValue := 2;
      DataBufferOffset := PChar(@sptwb.bDataBuf) - PChar(@sptwb);
      SenseInfoOffset := PChar(@sptwb.bSenseBuf) - PChar(@sptwb);
      Cdb[0] := $12; // OperationCode := SCSIOP_INQUIRY;
      Cdb[1] := $01; // Flags := CDB_INQUIRY_EVPD;  Vital product data
      Cdb[2] := $80; // PageCode            Unit serial number
      Cdb[4] := 192; // AllocationLength
    end;
    len := sptwb.spt.DataBufferOffset + sptwb.spt.DataTransferLength;
    if DeviceIoControl(DeviceHandle, $0004D004, @sptwb, SizeOf
      (TScsiPassThrough), @sptwb, len, dwReturned, nil)
      and ((PChar(@sptwb.bDataBuf) + 1)^ = #$80)
      then
      SetString(Result, PChar(@sptwb.bDataBuf) + 4,
        Ord((PChar(@sptwb.bDataBuf) + 3)^));
  finally
    CloseHandle(DeviceHandle);
  end;
end;

function GetHdId: string;
var
  sSerNum: string;
begin
  sSerNum := Trim(GetIdeSerialNumber);
  if sSerNum = '' then
  begin
    sSerNum := Trim(ScsiHddSerialNumber);
  end;
  Result := sSerNum;
end;

function DecodeString_3des(Source, Key: string): string;
var
  DesDecode: TDCP_3des;
  Str: string;
begin
  try
    Result := '';
    DesDecode := TDCP_3des.Create(nil);
    DesDecode.InitStr(Key);
    DesDecode.Reset;
    Str := DesDecode.DecryptString(Source);
    DesDecode.Reset;
    Result := Str;
    DesDecode.Free;
  except
    Result := '';
  end;
end;

function EncodeString_3des(Source, Key: string): string;
var
  DesEncode: TDCP_3des;
  Str: string;
begin
  try
    Result := '';
    DesEncode := TDCP_3des.Create(nil);
    DesEncode.InitStr(Key);
    DesEncode.Reset;
    Str := DesEncode.EncryptString(Source);
    DesEncode.Reset;
    Result := Str;
    DesEncode.Free;
  except
    Result := '';
  end;
end;

function EncodeBuf_3des(const Source;size:Integer; Key: string): string;
var
  DesEncode: TDCP_3des;
begin
  try
    Result := '';
    DesEncode := TDCP_3des.Create(nil);
    DesEncode.InitStr(Key);
    DesEncode.Reset;
    SetLength(Result,size);
    DesEncode.EncryptCFB8bit(Source,Result[1],size);
    Result:= Base64EncodeStr(Result);
    DesEncode.Reset;
    DesEncode.Free;
  except
    Result := '';
  end;
end;
//文件md5码 长度32

function CalcFileMd5(sFileName: string): string;
var
  Hash: TDCP_md5;
  Source: TFileStream;
  Digest: array[0..31] of byte;
  j: integer;
begin
  Hash := TDCP_md5.Create(nil);
  Hash.Init;
  Source := TFileStream.Create(sFileName, fmShareDenyNone);
  try
    Hash.UpdateStream(Source, Source.Size);
    FillChar(Digest, 32, #0);
    Hash.Final(Digest);
    Result := '';
    for j := 0 to ((Hash.HashSize shr 3) - 1) do
      Result := Result + IntToHex(Digest[j], 2);
  finally
    Hash.Free;
    Source.Free;
  end;
end;

function CRCode(sName: string): string;
var
  Hash: TDCP_md5;
  Digest: array[0..31] of byte;
  j: integer;
begin
  Hash := TDCP_md5.Create(nil);
  Hash.Init;
  try
    Hash.UpdateStr(sName);
    FillChar(Digest, 32, #0);
    Hash.Final(Digest);
    Result := '';
    for j := 0 to ((Hash.HashSize shr 3) - 1) do
      Result := Result + IntToHex(Digest[j], 2);
  finally
    Hash.Free;
  end;
end;

//机器码长 度32字节

function GetMachineID: string;
var
  dcp_sh: TDCP_md5;
  i: integer;
  Digest: array[0..31] of byte;
begin
  try
    dcp_sh := TDCP_md5.Create(nil);
    FillChar(Digest, 32, #0);
    dcp_sh.Init;
    dcp_sh.UpdateStr(GetHdId + GetMac);
    dcp_sh.Final(Digest);
    Result := '';
    for i := 0 to ((dcp_sh.HashSize shr 3) - 1) do
      Result := Result + IntToHex(Digest[i], 2);
  finally
    dcp_sh.Free;
  end;
end;

function SaveReg(sRegInfo, sFileName: string): Boolean;
var
  Source: TFileStream;
begin
  Result := False;
  if FileExists(sFileName) then
    if not DeleteFile(sFileName) then Exit;
  Source := TFileStream.Create(sFileName, fmCreate);
  try
    Source.Seek(0, 0);
    if Source.Write(sRegInfo[1], Length(sRegInfo)) > 0 then
      Result := True;
  finally
    Source.Free;
  end;
end;

function ReadReg(var sRegInfo:string;sFileName: string): Boolean;
var
  Source: TFileStream;
begin
  Result := False;
  if FileExists(sFileName) then
    Source := TFileStream.Create(sFileName, fmShareDenyNone)
  else
    Exit;
  try
    Source.Seek(0, 0);
    SetLength(sRegInfo, Source.Size);
    if Source.Read(sRegInfo[1], Source.Size) > 0 then
      Result := True;
  finally
    Source.Free;
  end;
end;

function GetCPUAndMacInfo(Num: Byte):string;
var
  dcp_sh: TDCP_md5;
  i: integer;
  Digest: array[0..31] of byte;
begin
  try
    dcp_sh := TDCP_md5.Create(nil);
    FillChar(Digest, 32, #0);
    dcp_sh.Init;
    dcp_sh.UpdateStr(GetHdId +GetMac+GetCPUInfo(1));
    dcp_sh.Final(Digest);
    Result := '';
    for i := 0 to ((dcp_sh.HashSize shr 3) - 1) do
      Result := Result + IntToHex(Digest[i], 2);
  finally
    dcp_sh.Free;
  end;
end;

end.

