unit Share;

interface
uses
  Windows, Messages, SysUtils, StrUtils, Classes;

  function FormatHardwareID(HardwareID: string): LongWord;
  function FormatUserName(UserName: String): LongWord;
  procedure GetMode(Random1, Random2: String; var CommonalityKey, CommonalityMode, PrivateKey: String);

implementation
uses
 FGInt, FGIntPrimeGeneration,HUtil32;


function FormatUserName(UserName: String): LongWord;
var
  i: Integer;
begin
  Result :=0;
  if Length(Username) > 0 then
    for I := 0 to Length(UserName)-1 do
    begin
      Result := Result + Byte(UserName[i + 1]) * 100;
    end;
end;

function FormatHardwareID(HardwareID: string): LongWord;
var
  TempList: TStringList;
begin
  Result := 0;
  TempList := TStringList.Create;
  try
    if ExtractStrings(['-'], [], PChar(HardwareID), TempList) = 6 then
    begin
      Result := StrToIntDef('$' + TempList[0], 0) +
        StrToIntDef('$' + TempList[1], 0) +
        StrToIntDef('$' + TempList[2], 0) +
        StrToIntDef('$' + TempList[3], 0) +
        StrToIntDef('$' + TempList[4], 0) +
        StrToIntDef('$' + TempList[5], 0);
    end;
  finally
    TempList.Free;
  end;
end;

procedure GetMode(Random1, Random2: String;var CommonalityKey, CommonalityMode, PrivateKey: String);
var
  n, e, d, dp, dq, p, q, phi, one, two, gcd, temp, nilgint, te1, te2, te3: TFGInt;
  p1, q1, dp1, dq1, e1, d1, n1, nil1, gcdStr: string;
begin
  Base10StringToFGInt(Random1, p);
  PrimeSearch(p);
  Base256StringToFGInt(Random2, q);
  PrimeSearch(q);
  FGIntMul(p, q, n);
  p.Number[1] := p.Number[1] - 1;
  q.Number[1] := q.Number[1] - 1;
  FGIntMul(p, q, phi);
  Base10StringToFGInt('65537', e);
  Base10StringToFGInt('1', one);
  Base10StringToFGInt('2', two);
  FGIntGCD(phi, e, gcd);
  while FGIntCompareAbs(gcd, one) <> Eq do
  begin
    FGIntadd(e, two, temp);
    FGIntCopy(temp, e);
    FGIntGCD(phi, e, gcd);
  end;
  FGIntToBase10String(e, gcdstr);
  FGIntDestroy(two);
  FGIntDestroy(one);
  FGIntDestroy(gcd);
  FGIntModInv(e, phi, d);
  FGIntModInv(e, p, dp);
  FGIntModInv(e, q, dq);
  p.Number[1] := p.Number[1] + 1;
  q.Number[1] := q.Number[1] + 1;
  Base10StringToFGInt('100', te1);
  Base10StringToFGInt('25', te2);
  FGIntMul(te1, te2, te3);
  FGIntToBase10String(p, p1);
  FGIntToBase10String(q, q1);
  FGIntToBase10String(dp, dp1);
  FGIntToBase10String(dq, dq1);
  FGIntToBase10String(e, e1);
  CommonalityKey := e1;
  FGIntToBase10String(d, d1);
  PrivateKey := d1;
  FGIntToBase10String(n, n1);
  CommonalityMode := n1;
  FGIntToBase10String(phi, nil1);
  FGIntDestroy(phi);
  FGIntDestroy(nilgint);
  FGIntDestroy(p);
  FGIntDestroy(q);
  FGIntDestroy(dp);
  FGIntDestroy(dq);
  FGIntDestroy(e);
  FGIntDestroy(d);
  FGIntDestroy(n);
end;

end.

