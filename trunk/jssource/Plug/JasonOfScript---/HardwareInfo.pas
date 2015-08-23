//---------------------------------------------------------------------------
// HardwareInfo.pas                                    Modified: 15-Jun-2006
// 获取网卡、硬盘、CPU硬件信息
// Copyright (c) 2006 - 2007  Huosoft.com
//---------------------------------------------------------------------------
// 本程序由火人(hth@21cn.com)整理制作，你可自由使用，但请保留此文件头信息
// http://www.huosoft.com
//---------------------------------------------------------------------------
unit HardwareInfo;

interface
uses Windows,SysUtils,Dialogs,Nb30;

type
  THardwareInfo = class
  type
     TNBLanaResources = (lrAlloc, lrFree);

  type
     PMACAddress = ^TMACAddress;
     TMACAddress = array[0..5] of Byte;

//以下读硬盘号用
TSrbIoControl = packed record
    HeaderLength : ULONG;
    Signature    : Array[0..7] of Char;
    Timeout      : ULONG;
    ControlCode  : ULONG;
    ReturnCode   : ULONG;
    Length       : ULONG;
  end;
  SRB_IO_CONTROL = TSrbIoControl;
  PSrbIoControl = ^TSrbIoControl; 

  TIDERegs = packed record 
    bFeaturesReg     : Byte; // Used for specifying SMART "commands". 
    bSectorCountReg  : Byte; // IDE sector count register
    bSectorNumberReg : Byte; // IDE sector number register 
    bCylLowReg       : Byte; // IDE low order cylinder value
    bCylHighReg      : Byte; // IDE high order cylinder value 
    bDriveHeadReg    : Byte; // IDE drive/head register 
    bCommandReg      : Byte; // Actual IDE command. 
    bReserved        : Byte; // reserved.  Must be zero. 
  end;
  IDEREGS   = TIDERegs;
  PIDERegs  = ^TIDERegs; 

  TSendCmdInParams = packed record 
    cBufferSize  : DWORD; 
    irDriveRegs  : TIDERegs; 
    bDriveNumber : Byte; 
    bReserved    : Array[0..2] of Byte; 
    dwReserved   : Array[0..3] of DWORD;
    bBuffer      : Array[0..0] of Byte;
  end;
  SENDCMDINPARAMS   = TSendCmdInParams;
  PSendCmdInParams  = ^TSendCmdInParams; 

  TIdSector = packed record 
    wGenConfig                 : Word; 
    wNumCyls                   : Word;
    wReserved                  : Word; 
    wNumHeads                  : Word; 
    wBytesPerTrack             : Word; 
    wBytesPerSector            : Word; 
    wSectorsPerTrack           : Word; 
    wVendorUnique              : Array[0..2] of Word;
    sSerialNumber              : Array[0..19] of Char; 
    wBufferType                : Word; 
    wBufferSize                : Word; 
    wECCSize                   : Word;
    sFirmwareRev               : Array[0..7] of Char; 
    sModelNumber               : Array[0..39] of Char;
    wMoreVendorUnique          : Word; 
    wDoubleWordIO              : Word; 
    wCapabilities              : Word; 
    wReserved1                 : Word; 
    wPIOTiming                 : Word; 
    wDMATiming                 : Word;
    wBS                        : Word; 
    wNumCurrentCyls            : Word; 
    wNumCurrentHeads           : Word; 
    wNumCurrentSectorsPerTrack : Word; 
    ulCurrentSectorCapacity    : ULONG; 
    wMultSectorStuff           : Word;
    ulTotalAddressableSectors  : ULONG; 
    wSingleWordDMA             : Word;
    wMultiWordDMA              : Word; 
    bReserved                  : Array[0..127] of Byte; 
  end;
  PIdSector = ^TIdSector; 

const
  IDE_ID_FUNCTION = $EC; 
  IDENTIFY_BUFFER_SIZE       = 512;
  DFP_RECEIVE_DRIVE_DATA        = $0007c088;
  IOCTL_SCSI_MINIPORT           = $0004d008;
  IOCTL_SCSI_MINIPORT_IDENTIFY  = $001b0501;
  DataSize = sizeof(TSendCmdInParams)-1+IDENTIFY_BUFFER_SIZE;
  BufferSize = SizeOf(SRB_IO_CONTROL)+DataSize;
  W9xBufferSize = IDENTIFY_BUFFER_SIZE+16;
//以上读硬盘号用

  public
    function GetMACAddress(Num: Byte=0): String;overload;
    function GetIDEDiskSerialNumber : String;
    function GetIDEDiskDriveInfo(Drive:Char;InfoID:Byte=1) : String;
    function GetCPUInfo(InfoID:Byte=0) : String;
    function GetCPUAndMacInfo() : String;

  private
    function GetMACAddress(LanaNum: Byte; MACAddress: PMACAddress): Byte;overload; //LanaNum 网卡标识
    procedure ChangeByteOrder(var Data; Size: Integer);
    function GetLanaEnum(LanaEnum: PLanaEnum): Byte;
    function ResetLana(LanaNum, ReqSessions, ReqNames: Byte; LanaRes: TNBLanaResources): Byte;

  end;

  var
    HardInfo : THardwareInfo;

implementation

//-----------------------------------------------------------------------
//获取网卡地址
//-----------------------------------------------------------------------
//参数： Num 第几块网卡
//-----------------------------------------------------------------------
function THardwareInfo.GetMACAddress(Num: Byte): String;
var
  MACAddress: PMACAddress;
  RetCode,LanaNum: Byte;
  LanaEnum: PLanaEnum;
begin
//1、获取网卡枚举列表
  LanaNum := 0;
  New(LanaEnum);
  ZeroMemory(LanaEnum, SizeOf(TLanaEnum));
  try
   if GetLanaEnum(LanaEnum) = NRC_GOODRET then
   begin
//2、取所要第几块网卡的标识
      if Num>Byte(LanaEnum.length)-1 then Num:=Byte(LanaEnum.length)-1;
      LanaNum:=Byte(LanaEnum.lana[Num]);
    end;
  finally
    Dispose(LanaEnum);
  end;

//3、复位
  RetCode := ResetLana(LanaNum, 0, 0, lrAlloc);
  if RetCode <> NRC_GOODRET then
  begin
    Beep;
    Result := ''; Exit;
    ShowMessage('Reset Error! RetCode = $' + IntToHex(RetCode, 2));
  end;

  Result := 'Error';
//4、取所选网卡的地址
  New(MACAddress);
  try
    RetCode := GetMACAddress(LanaNum, MACAddress);
    if RetCode = NRC_GOODRET then
    begin
//    Result := Format('%2.2x-%2.2x-%2.2x-%2.2x-%2.2x-%2.2x', [MACAddress[0], MACAddress[1],
//         MACAddress[2], MACAddress[3], MACAddress[4], MACAddress[5]]);
      Result := Format('%2.2x%2.2x%2.2x%2.2x%2.2x%2.2x', [MACAddress[0], MACAddress[1],
          MACAddress[2],  MACAddress[3], MACAddress[4], MACAddress[5]]);
    end else
    begin
      Result := ''; Exit;
      ShowMessage('GetMACAddress Error! RetCode = $' + IntToHex(RetCode, 2));
    end;
  finally
    Dispose(MACAddress);
  end;

end;

function THardwareInfo.GetCPUAndMacInfo() : String;
var
  _eax, _ebx, _ecx, _edx: Longint;
  MACAddress: PMACAddress;
  RetCode,LanaNum,Num: Byte;
  LanaEnum: PLanaEnum;
  s, s1, s2: string;
begin
  Result := '';
  LanaNum := 0;
  Num := 0;
  asm
    mov eax,1
    db $0F,$A2
    mov _eax,eax
    mov _ebx,ebx
    mov _ecx,ecx
    mov _edx,edx
  end;

  New(LanaEnum);
  ZeroMemory(LanaEnum, SizeOf(TLanaEnum));
  try
   if GetLanaEnum(LanaEnum) = NRC_GOODRET then
   begin
//2、取所要第几块网卡的标识
      if Num>Byte(LanaEnum.length)-1 then Num:=Byte(LanaEnum.length)-1;
      LanaNum:=Byte(LanaEnum.lana[Num]);
    end;
  finally
    Dispose(LanaEnum);
  end;

//3、复位
  RetCode := ResetLana(LanaNum, 0, 0, lrAlloc);
  if RetCode <> NRC_GOODRET then
  begin
    Beep;
    Result := ''; Exit;
    ShowMessage('Reset Error! RetCode = $' + IntToHex(RetCode, 2));
  end;

  New(MACAddress);
  try
    RetCode := GetMACAddress(LanaNum, MACAddress);
    if RetCode = NRC_GOODRET then
    begin
      _eax := _eax + MakeLong(MakeWord(MACAddress[0], MACAddress[1]),_eax);
      _edx := _edx + MakeLong(MakeWord(MACAddress[2], MACAddress[3]),_edx);
      _ecx := _ecx + MakeLong(MakeWord(MACAddress[4], MACAddress[5]),_ecx);
    end;
  finally
    Dispose(MACAddress);
  end;
  s := IntToHex(_eax, 8);
  s1 := IntToHex(_edx, 8);
  s2 := IntToHex(_ecx, 8);
  Insert('-', s, 5);
  Insert('-', s1, 5);
  Insert('-', s2, 5);
  Result:=s + '-' + s1 + '-' + s2;
end;


//-----------------------------------------------------------------------
//获取CPU硬件信息
//-----------------------------------------------------------------------
//参数：
// InfoID:=1 获取CPU序列号
// InfoID:=2 获取CPU 频率
// InfoID:=3 获取CPU厂商
//-----------------------------------------------------------------------
function THardwareInfo.GetCPUInfo(InfoID: Byte): String;
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

//-----------------------------------------------------------------------
//获取硬盘驱动器信息
//-----------------------------------------------------------------------
//参数：
// Drive 驱动器盘符 如C、D、E，不要带 :\
// InfoID =1 获取驱动器序列号  InfoID =2 获取卷标
//-----------------------------------------------------------------------
function THardwareInfo.GetIDEDiskDriveInfo(Drive: Char; InfoID: Byte): String;
var
  NotUsed:     DWORD;
  VolumeFlags: DWORD;
  VolumeInfo:  array[0..MAX_PATH] of Char;
  VolumeSerialNumber: DWORD;
begin
try
  GetVolumeInformation(PChar(Drive + ':\'),
    VolumeInfo, SizeOf(VolumeInfo), @VolumeSerialNumber, NotUsed,
    VolumeFlags, nil, 0);
  case InfoID of
  1: Result:= Format('%8.8X', [VolumeSerialNumber]);
  2: Result:= VolumeInfo;
 else
  result:='错误的信息标识!';
  end;
except on E: Exception do
result:='执行错误!';
end;
end;

//-----------------------------------------------------------------------
//获取硬盘物理序列号
//-----------------------------------------------------------------------
function THardwareInfo.GetIDEDiskSerialNumber: String;
var
  hDevice : THandle; 
  cbBytesReturned : DWORD; 
  pInData : PSendCmdInParams; 
  pOutData : Pointer; // PSendCmdOutParams 
  Buffer : Array[0..BufferSize-1] of Byte;
  srbControl : TSrbIoControl absolute Buffer;
begin
  Result := '';
  FillChar(Buffer,BufferSize,#0);
  if Win32Platform=VER_PLATFORM_WIN32_NT then
    begin // Windows NT, Windows 2000
      // Get SCSI port handle
      hDevice := CreateFile( '\\.\Scsi0:',GENERIC_READ or GENERIC_WRITE,
        FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0 );
      if hDevice=INVALID_HANDLE_VALUE then Exit;
      try
        srbControl.HeaderLength := SizeOf(SRB_IO_CONTROL);
        System.Move('SCSIDISK',srbControl.Signature,8);
        srbControl.Timeout      := 2;
        srbControl.Length       := DataSize;
        srbControl.ControlCode  := IOCTL_SCSI_MINIPORT_IDENTIFY;
        pInData := PSendCmdInParams(PChar(@Buffer)
                   +SizeOf(SRB_IO_CONTROL));
        pOutData := pInData;
        with pInData^ do
        begin
          cBufferSize  := IDENTIFY_BUFFER_SIZE;
          bDriveNumber := 0;
          with irDriveRegs do
          begin
            bFeaturesReg     := 0;
            bSectorCountReg  := 1;
            bSectorNumberReg := 1;
            bCylLowReg       := 0;
            bCylHighReg      := 0;
            bDriveHeadReg    := $A0;
            bCommandReg      := IDE_ID_FUNCTION;
          end;
        end;
        if not DeviceIoControl( hDevice, IOCTL_SCSI_MINIPORT,
          @Buffer, BufferSize, @Buffer, BufferSize,
          cbBytesReturned, nil ) then Exit;
      finally
        CloseHandle(hDevice);
      end;
    end
  else
    begin // Windows 95 OSR2, Windows 98
      hDevice := CreateFile( '\\.\SMARTVSD', 0, 0, nil,
        CREATE_NEW, 0, 0 );
      if hDevice=INVALID_HANDLE_VALUE then Exit;
      try
        pInData := PSendCmdInParams(@Buffer);
        pOutData := @pInData^.bBuffer;
        with pInData^ do
        begin
          cBufferSize  := IDENTIFY_BUFFER_SIZE;
          bDriveNumber := 0;
          with irDriveRegs do
          begin
            bFeaturesReg     := 0;
            bSectorCountReg  := 1;
            bSectorNumberReg := 1;
            bCylLowReg       := 0;
            bCylHighReg      := 0;
            bDriveHeadReg    := $A0;
            bCommandReg      := IDE_ID_FUNCTION;
          end;
        end;
        if not DeviceIoControl( hDevice, DFP_RECEIVE_DRIVE_DATA,
          pInData, SizeOf(TSendCmdInParams)-1, pOutData,
          W9xBufferSize, cbBytesReturned, nil ) then Exit;
      finally
        CloseHandle(hDevice);
      end;
    end;
    with PIdSector(PChar(pOutData)+16)^ do
    begin
      ChangeByteOrder(sSerialNumber,SizeOf(sSerialNumber));
      SetString(Result,sSerialNumber,SizeOf(sSerialNumber));
      Result:=TRIM(Result);
    end;
end;


function THardwareInfo.GetMACAddress(LanaNum: Byte; MACAddress: PMACAddress): Byte;
var
  AdapterStatus: PAdapterStatus;
  StatNCB: PNCB;
begin
  New(StatNCB);
  ZeroMemory(StatNCB, SizeOf(TNCB));
  StatNCB.ncb_length := SizeOf(TAdapterStatus) +  255 * SizeOf(TNameBuffer);
  GetMem(AdapterStatus, StatNCB.ncb_length);
  try
    with StatNCB^ do
    begin
      ZeroMemory(MACAddress, SizeOf(TMACAddress));
      ncb_buffer := PChar(AdapterStatus);
      ncb_callname := '*              ' + #0;
      ncb_lana_num := Char(LanaNum);
      ncb_command  := Char(NCBASTAT);
      NetBios(StatNCB);
      Result := Byte(ncb_cmd_cplt);
      if Result = NRC_GOODRET then
        MoveMemory(MACAddress, AdapterStatus, SizeOf(TMACAddress));
    end;
  finally
    FreeMem(AdapterStatus);
    Dispose(StatNCB);
  end;
end;

//枚举当前安装的网络适配器
function THardwareInfo.GetLanaEnum(LanaEnum: PLanaEnum): Byte;
var
  LanaEnumNCB: PNCB;
begin
  New(LanaEnumNCB);
  ZeroMemory(LanaEnumNCB, SizeOf(TNCB));
  try
    with LanaEnumNCB^ do
    begin
      ncb_buffer := PChar(LanaEnum);
      ncb_length := SizeOf(TLanaEnum);
      ncb_command  := Char(NCBENUM);
      NetBios(LanaEnumNCB);
      Result := Byte(ncb_cmd_cplt);
    end;
  finally
    Dispose(LanaEnumNCB);
  end;
end;

function THardwareInfo.ResetLana(LanaNum, ReqSessions, ReqNames: Byte;
  LanaRes: TNBLanaResources): Byte;
var
  ResetNCB: PNCB;
begin
  New(ResetNCB);
  ZeroMemory(ResetNCB, SizeOf(TNCB));
  try
    with ResetNCB^ do
    begin
      ncb_lana_num := Char(LanaNum);        // Set Lana_Num
      ncb_lsn := Char(LanaRes);             // Allocation of new resources
      ncb_callname[0] := Char(ReqSessions); // Query of max sessions
      ncb_callname[1] := #0;                // Query of max NCBs (default)
      ncb_callname[2] := Char(ReqNames);    // Query of max names
      ncb_callname[3] := #0;                // Query of use NAME_NUMBER_1
      ncb_command  := Char(NCBRESET);
      NetBios(ResetNCB);
      Result := Byte(ncb_cmd_cplt);
    end;
  finally
    Dispose(ResetNCB);
  end;
end;
procedure THardwareInfo.ChangeByteOrder( var Data; Size : Integer );
var ptr : PChar;
    i : Integer;
    c : Char;
begin
  ptr := @Data;
  for i := 0 to (Size shr 1)-1 do
  begin
    c := ptr^;
    ptr^ := (ptr+1)^;
    (ptr+1)^ := c;
    Inc(ptr,2);
  end;
end;

initialization
begin
  HardInfo := THardwareInfo.Create;
end;

finalization
begin
  HardInfo.Free;
end;


end.

