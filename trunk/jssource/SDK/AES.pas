(**************************************************)
(*                                                *)
(*     Advanced Encryption Standard (AES)         *)
(*     Interface Unit v1.0                        *)
(*                                                *)
(*                                                *)
(*     Copyright (c) 2002 Jorlen Young            *)
(*                                                *)
(*                                                *)
(*                                                *)
(*˵����                                          *)
(*                                                *)
(*   ���� ElASE.pas ��Ԫ��װ                      *)
(*                                                *)
(*   ����һ�� AES �����㷨�ı�׼�ӿڡ�            *)
(*   ͨ���������� EncryptString �� DecryptString  *)
(*   �������ɵö��ַ������м��ܡ�                 *)
(*                                                *)
(*   ���ߣ�������      2004.12.03                 *)
(*                                                *)
(**************************************************)

unit AES;

interface

uses
  SysUtils, Classes, Math, ElAES;

function StrToHex(Value: String): String;
function HexToStr(Value: String): String;
function EncryptString(Value: String; Key: String): String;
function DecryptString(Value: String; Key: String): String;

implementation

function StrToHex(Value: String): String;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Value) do
    Result := Result + IntToHex(Ord(Value[I]), 2);
end;

function HexToStr(Value: String): String;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Value) do
  begin
    if ((I mod 2) = 1) then
      Result := Result + Chr(StrToInt('0x'+ Copy(Value, I, 2)));
  end;
end;

function EncryptString(Value: String; Key: String): String;
var
  SS, DS: TStringStream;
  Size: Integer;
  AESKey: TAESKey128;
begin
  Result := '';
  SS := TStringStream.Create(Value);
  DS   := TStringStream.Create('');
  try
    Size := SS.Size;
    DS.WriteBuffer(Size, SizeOf(Size));
    FillChar(AESKey, SizeOf(AESKey), 0 );
    Move(PChar(Key)^, AESKey, Min( SizeOf(AESKey), Length(Key)));
    EncryptAESStreamECB(SS, 0, AESKey, DS);
    Result := StrToHex(DS.DataString);
  finally
    SS.Free;
    DS.Free;
  end;
end;

function DecryptString(Value: String; Key: String): String;
var
  SS: TStringStream;
  DS: TStringStream;
  Size: Integer;
  AESKey: TAESKey128;
begin
  Result := '';
  SS := TStringStream.Create(HexToStr(Value));
  DS := TStringStream.Create('');
  try
    Size := SS.Size;
    SS.ReadBuffer(Size, SizeOf(Size));
    FillChar(AESKey, SizeOf(AESKey), 0);
    Move(PChar(Key)^, AESKey, Min(SizeOf(AESKey), Length(Key)));
    DecryptAESStreamECB(SS, SS.Size - SS.Position, AESKey, DS);
    Result := DS.DataString;
  finally
    SS.Free;
    DS.Free;
  end;
end;

end.
