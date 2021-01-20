{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{                                                       }
{                    RdeEM Long                         }
{                     大数单元                          }
{                     ver 1.20                          }
{                                                       }
{    Copyright(c) 2018-2019 Reniasty de El Magnifico    }
{                   天道玄虚 出品                       }
{                 All rights reserved                   }
{                   保留所有权利                        }
{                                                       }
{*******************************************************}

unit RdeEM.Long;

interface

uses
  System.SysUtils, System.Math;

type
  EZeroError = class(Exception);
  EPowerError = class(Exception);

  TLongInteger = class;
  TLongReal = class;

  TComplex = record
  private
    FM: Double; // 模數
    FA: Double; // 輻角
  public
    class function Create(const Modulus, Argument: Double): TComplex; static;
    class operator Multiply(const C1, C2: TComplex): TComplex; overload;
    class operator Multiply(const C1: TComplex; const C2: Double): TComplex; overload;
    class operator Divide(const C1, C2: TComplex): TComplex; overload;
    class operator Divide(const C1: TComplex; const C2: Double): TComplex; overload;
    class operator Add(const C1, C2: TComplex): TComplex;
    class operator Subtract(const C1, C2: TComplex): TComplex;
    function Modulus: Double;
    function Argument: Double;
    function Real: Double;
    function Imaginary: Double;
    function Conjugate: TComplex;
  end;

  THexInt = record
  private
    FHex: string;
    function GetHexValue: string;
    function GetBinValue: string;
    function GetDecValue: string;
    procedure SetHexValue(const Value: string);
    procedure SetBinValue(const Value: string);
    procedure SetDecValue(const Value: string);
  public
    class function Create(const Str: string): THexInt; static;
    // 正負運算
    class operator Positive(const Hex1: THexInt): THexInt;
    class operator Negative(const Hex1: THexInt): THexInt;
    // 比較運算
    class operator Equal(const Hex1, Hex2: THexInt): Boolean;
    class operator LessThan(const Hex1, Hex2: THexInt): Boolean;
    class operator GreaterThan(const Hex1, Hex2: THexInt): Boolean;
    class operator NotEqual(const Hex1, Hex2: THexInt): Boolean;
    class operator LessThanOrEqual(const Hex1, Hex2: THexInt): Boolean;
    class operator GreaterThanOrEqual(const Hex1, Hex2: THexInt): Boolean;
    // 四則運算
    class operator Add(const Hex1, Hex2: THexInt): THexInt;
    class operator Subtract(const Hex1, Hex2: THexInt): THexInt;
    class operator Multiply(const Hex1, Hex2: THexInt): THexInt;
    class operator Divide(const Hex1, Hex2: THexInt): THexInt;
    class operator IntDivide(const Hex1, Hex2: THexInt): THexInt;
    class operator Modulus(const Hex1, Hex2: THexInt): THexInt;
    // 其他功能
    function Power(const Hex1: THexInt): THexInt;
    function PowAndMod(const Hex1, Hex2: THexInt): THexInt;
    // 屬性
    property BinValue: string          read GetBinValue         write SetBinValue;
    property DecValue: string          read GetDecValue         write SetDecValue;
    property HexValue: string          read GetHexValue         write SetHexValue;
  end;

  TLongInteger = class
  private
    FSymb: Boolean; // 符号位，True代表正数。
    FNumL: TArray<Boolean>;
    function AbsAdd(const Par: TLongInteger): TLongInteger;
    function AbsSub(const Par: TLongInteger): TLongInteger;
    function Mut10PowN(N: TLongInteger): TLongInteger;
    function Div10PowN(N: TLongInteger): TLongInteger;
    function Normalize: TLongInteger;
  public
    constructor Create; overload;
    constructor Create(LI: TLongInteger); overload;
    constructor Create(N: Int64); overload;
    constructor Create(N: Integer); overload;
    constructor Create(N: Cardinal); overload;
    constructor Create(N: Word); overload;
    constructor Create(N: Byte); overload;
    destructor Destroy; override;
    // 複製
    function CopyVal(const Par: TLongInteger): TLongInteger;
    // 判斷
    function Equal(const Par: TLongInteger): Boolean;
    function LessThan(const Par: TLongInteger): Boolean;
    function GreaterThan(const Par: TLongInteger): Boolean;
    function IsZero: Boolean;
    function IsEven: Boolean;
    function IsOdd: Boolean;
    // 位數
    function Digit: Integer;
    // 轉換
    function ToString2: string;
    function ToString10: string;
    function ToString16: string;
    function ToBytes: TBytes;
    function ToBytes16: TBytes;
    function FromString2(Str: string): Boolean;
    function FromString10(Str: string): Boolean;
    function FromString16(Str: string): Boolean;
    function FromInteger(N: Byte): TLongInteger; overload;
    function FromInteger(N: Word): TLongInteger; overload;
    function FromInteger(N: Cardinal): TLongInteger; overload;
    function FromInteger(N: Integer): TLongInteger; overload;
    function FromInteger(N: Int64): TLongInteger; overload;
    function FromBytes(B: TBytes): TLongInteger;
    function FromBytes16(B: TBytes): TLongInteger;
    function FromRandom(Digits: Integer): TLongInteger;
    function FromRandomOdd(Digits: Integer): TLongInteger;
    function FromRandomEven(Digits: Integer): TLongInteger;
    // 歸零、絕對值、正負
    function Zero: TLongInteger;
    function AbsoluteVal: TLongInteger;
    function Positive: TLongInteger;
    function Negative: TLongInteger;
    // 運算
    function Add(const Par: TLongInteger): TLongInteger;
    function Subtract(const Par: TLongInteger): TLongInteger;
    function Multiply(const Par: TLongInteger): TLongInteger;
    function Divide(const Par: TLongInteger): TLongInteger;
    function Modulus(const Par: TLongInteger): TLongInteger;
    function Power(const Par: TLongInteger): TLongInteger;
    function PowAndMod(PowPar, ModPar: TLongInteger): TLongInteger;
    function DivAndMod(const Par, ModVal: TLongInteger): TLongInteger;
    function LogicalXor(const Par: TLongInteger): TLongInteger;
    function LogicalOr(const Par: TLongInteger): TLongInteger;
    function LogicalAnd(const Par: TLongInteger): TLongInteger;
    function LogicalNot: TLongInteger;
    function ShiftR(Shift: Integer): TLongInteger;
    function ShiftL(Shift: Integer): TLongInteger;
      // 值
    function GetValue(Index: Integer): Boolean;
  end;

  TLongReal = class // 用科學記數法記錄實數，Val = FCoe * Power(10, FExp)
  private
    FCoe: TLongInteger; // 係數
    FExp: TLongInteger; // 指數
    function Normalize: TLongReal;
  public
    constructor Create; overload;
    constructor Create(LR: TLongReal); overload;
    constructor Create(Coe: TLongInteger); overload;
    constructor Create(Coe, Exp: TLongInteger); overload;
    destructor Destroy; override;
    // 複製
    function CopyVal(const Par: TLongReal): TLongReal;
    // 判斷
    function Equal(const Par: TLongReal; Digit: Integer = -5): Boolean;
    function LessThan(const Par: TLongReal; Digit: Integer = -5): Boolean;
    function GreaterThan(const Par: TLongReal; Digit: Integer = -5): Boolean;
      // Digit代表判定精度，如果兩數之差在該量級範圍內，則判定爲相等。
      // 如Digit取-5時，則相差絕對值在Power(10, -5)內都視爲相等。
    // 歸零、絕對值、正負
    function Zero: TLongReal;
    function AbsoluteVal: TLongReal;
    function Positive: TLongReal;
    function Negative: TLongReal;
    function Trunc(LI: TLongInteger): TLongInteger;
    function Round(LI: TLongInteger): TLongInteger;
    // 四則運算
    function Add(const Par: TLongReal): TLongReal;
    function Subtract(const Par: TLongReal): TLongReal;
    function Multiply(const Par: TLongReal): TLongReal;
    function Divide(const Par: TLongReal; Digit: Cardinal = 5): TLongReal;
      // Digit代表額外的位數。取0則相當於對兩數的係數部份做整數除法，取x則相當於保留x位小數
    // 轉換（僅支持無小數點之科學記數法的轉換）
    function ToStringOri: string;
    function FromStringOri(Str: string): Boolean;
    function FromInteger(Coe, Exp: Integer): TLongReal; overload;
    function FromInteger(Coe, Exp: Int64): TLongReal; overload;
  end;

  function GetHexChr(N: Byte): Char;
  function GetHexVal(C: Char): Byte;
  function GetDecChr(N: Byte): Char;
  function GetDecVal(C: Char): Byte;


  function GetReverseList(var Reverse: TArray<Integer>; Bit: Integer): Boolean;

  function FFT(var Complex: TArray<TComplex>; var Reverse: TArray<Integer>; Count: Integer): Boolean;
  function IFFT(var Complex: TArray<TComplex>; var Reverse: TArray<Integer>; Count: Integer): Boolean;
  function FFTBytes(const B: TBytes; var Com: TArray<TComplex>; var Rev: TArray<Integer>; Count: Integer): Boolean;
  function IFFTBytes(var B: TBytes; var Com: TArray<TComplex>; var Rev: TArray<Integer>; Count: Integer): Boolean;

implementation

function GetHexChr(N: Byte): Char;
begin
  case N of
    0: Exit('0');
    1: Exit('1');
    2: Exit('2');
    3: Exit('3');
    4: Exit('4');
    5: Exit('5');
    6: Exit('6');
    7: Exit('7');
    8: Exit('8');
    9: Exit('9');
    10: Exit('A');
    11: Exit('B');
    12: Exit('C');
    13: Exit('D');
    14: Exit('E');
    15: Exit('F');
  else
    Exit(#0);
  end;
end;

function GetHexVal(C: Char): Byte;
begin
  case C of
    '0': Exit(0);
    '1': Exit(1);
    '2': Exit(2);
    '3': Exit(3);
    '4': Exit(4);
    '5': Exit(5);
    '6': Exit(6);
    '7': Exit(7);
    '8': Exit(8);
    '9': Exit(9);
    'A': Exit(10);
    'B': Exit(11);
    'C': Exit(12);
    'D': Exit(13);
    'E': Exit(14);
    'F': Exit(15);
  else
    Exit(255);
  end;
end;

function GetDecChr(N: Byte): Char;
begin
  case N of
    0: Exit('0');
    1: Exit('1');
    2: Exit('2');
    3: Exit('3');
    4: Exit('4');
    5: Exit('5');
    6: Exit('6');
    7: Exit('7');
    8: Exit('8');
    9: Exit('9');
  else
    Exit(#0);
  end;
end;

function GetDecVal(C: Char): Byte;
begin
  case C of
    '0': Exit(0);
    '1': Exit(1);
    '2': Exit(2);
    '3': Exit(3);
    '4': Exit(4);
    '5': Exit(5);
    '6': Exit(6);
    '7': Exit(7);
    '8': Exit(8);
    '9': Exit(9);
  else
    Exit(255);
  end;
end;

function GetReverseList(var Reverse: TArray<Integer>; Bit: Integer): Boolean;
var
  i: Integer;
begin
  if Bit > 31 then
  begin
    Exit(False);
  end;
  SetLength(Reverse, 1 shl Bit);
  for i := 0 to (1 shl Bit) - 1 do
  begin
    Reverse[i] := (Reverse[i shr 1] shr 1) or ((i and 1) shl (bit - 1));
  end;
  Exit(True);
end;

function FFT(var Complex: TArray<TComplex>; var Reverse: TArray<Integer>; Count: Integer): Boolean;
var
  i, j, k, step: Integer;
  v, x, y, wnk: TComplex;
begin
  if (Complex = nil) or (Reverse = nil) or (Count < 1) then
  begin
    Exit(False);
  end;
  for i := 0 to Count - 1 do if i < Reverse[i] then
  begin
    v := Complex[i];
    Complex[i] := Complex[Reverse[i]];
    Complex[Reverse[i]] := v;
  end;
  step := 1;
  while step < Count do
  begin
    j := 0;
    while j < Count do
    begin
      for k := j to j + step - 1 do
      begin
        wnk := TComplex.Create(1, (k - j) * PI / step);
        x := Complex[k];
        y := wnk * Complex[k + step];
        Complex[k] := x + y;
        Complex[k + step] := x - y;
      end;
      j := j + step shl 1;
    end;
    step := step shl 1;
  end;
  Exit(True);
end;

function IFFT(var Complex: TArray<TComplex>; var Reverse: TArray<Integer>; Count: Integer): Boolean;
var
  i, j, k, step: Integer;
  v, x, y, wnk: TComplex;
begin
  if (Complex = nil) or (Reverse = nil) or (Length(Complex) <> Count) then
  begin
    Exit(False);
  end;
  for i := 0 to Count - 1 do if i < Reverse[i] then
  begin
    v := Complex[i];
    Complex[i] := Complex[Reverse[i]];
    Complex[Reverse[i]] := v;
  end;
  step := 1;
  while step < Count do
  begin
    j := 0;
    while j < Count do
    begin
      for k := j to j + step - 1 do
      begin
        wnk := TComplex.Create(1, (j - k) * PI / step);
        // wnk := VarComplexCreate(Cos((j - k) * PI / step), Sin((j - k) * PI / step));
        x := Complex[k];
        y := wnk * Complex[k + step];
        Complex[k] := x + y;
        Complex[k + step] := x - y;
      end;
      j := j + step shl 1;
    end;
    step := step shl 1;
  end;
  for i := 0 to Count - 1 do
  begin
    Complex[i] := Complex[i] / Count;
  end;
  Exit(True);
end;

function FFTBytes(const B: TBytes; var Com: TArray<TComplex>; var Rev: TArray<Integer>; Count: Integer): Boolean;
var
  i: Integer;
begin
  if (Com = nil) or (Rev = nil) or (Count < 1) then
  begin
    Exit(False);
  end;
  SetLength(Com, Count);
  for i := 0 to Length(B) - 1 do
  begin
    Com[i] := TComplex.Create(B[i], 0);
  end;
  for i := Length(B) to Count - 1 do
  begin
    Com[i] := TComplex.Create(0, 0);
  end;
  FFT(Com, Rev, Count);
  Exit(True);
end;

function IFFTBytes(var B: TBytes; var Com: TArray<TComplex>; var Rev: TArray<Integer>; Count: Integer): Boolean;
var
  i, j, k: Integer;
begin
  IFFT(Com, Rev, Count);
  k := 0;
  SetLength(B, Count);
  for i := 0 to Count - 1 do
  begin
    j := Round(Com[i].Real) + k;
    B[i] := j and 255;
    k := j shr 8;
  end;
  i := Count;
  while k > 0 do
  begin
    SetLength(B, i + 1);
    B[i] := k and 255;
    i := i + 1;
    k := k shr 8;
  end;
  Exit(True);
end;

{ TLongInteger }

function TLongInteger.AbsAdd(const Par: TLongInteger): TLongInteger;
var
  C, X, Y: Boolean;
  i, l: Integer;
begin
  Normalize;
  Par.Normalize;
  C := False;
  l := Max(Length(FNumL), Length(Par.FNumL));
  SetLength(FNumL, l + 1);
  for i := 0 to l - 1 do
  begin
    if i >= Length(FNumL) then
    begin
      FNumL[i] := False;
    end;
    X := FNumL[i];
    if i >= Length(Par.FNumL) then
    begin
      Y := False;
    end
    else
    begin
      Y := Par.FNumL[i];
    end;
    FNumL[i] := X xor Y xor C;
    C := (X and Y) or (C and (X or Y));
  end;
  FNumL[l] := C;
  Normalize;
  Exit(Self);
end;

function TLongInteger.AbsSub(const Par: TLongInteger): TLongInteger;
var
  C, X, Y, G: Boolean;
  i, l: Integer;
begin
  Normalize;
  Par.Normalize;
  if Equal(Par) then
  begin
    Zero;
    Exit(Self);
  end;
  C := False;
  if GreaterThan(Par) then
  begin
    G := True;
  end
  else
  begin
    G := False;
    FSymb := not FSymb;
  end;
  l := Max(Length(FNumL), Length(Par.FNumL));
  SetLength(FNumL, l);
  for i := 0 to l - 1 do
  begin
    if not G then
    begin
      if i >= Length(FNumL) then
      begin
        FNumL[i] := False;
      end;
      Y := FNumL[i];
      if i >= Length(Par.FNumL) then
      begin
        X := False;
      end
      else
      begin
        X := Par.FNumL[i];
      end;
    end
    else
    begin
      if i >= Length(FNumL) then
      begin
        FNumL[i] := False;
      end;
      X := FNumL[i];
      if i >= Length(Par.FNumL) then
      begin
        Y := False;
      end
      else
      begin
        Y := Par.FNumL[i];
      end;
    end;
    FNumL[i] := X xor Y xor C;
    C := (Y and C) or ((not X) and (Y or C))
  end;
  Normalize;
  Exit(Self);
end;

function TLongInteger.AbsoluteVal: TLongInteger;
begin
  FSymb := True;
  Exit(Self);
end;

function TLongInteger.Add(const Par: TLongInteger): TLongInteger;
begin
  if IsZero then
  begin
    CopyVal(Par);
  end
  else if Par.IsZero then
  begin
    Exit(Self);
  end
  else if FSymb = Par.FSymb then
  begin
    AbsAdd(Par);
  end
  else
  begin
    AbsSub(Par);
  end;
  Exit(Self);
end;

function TLongInteger.CopyVal(const Par: TLongInteger): TLongInteger;
var
  i: Integer;
begin
  FSymb := Par.FSymb;
  SetLength(FNumL, Length(Par.FNumL));
  for i := 0 to Length(Par.FNumL) - 1 do
  begin
    FNumL[i] := Par.FNumL[i];
  end;
  Exit(Self);
end;

constructor TLongInteger.Create;
begin
  SetLength(FNumL, 1);
  FNumL[0] := False;
  FSymb := True;
end;

constructor TLongInteger.Create(LI: TLongInteger);
var
  i: Integer;
begin
  FSymb := LI.FSymb;
  SetLength(FNumL, Length(LI.FNumL));
  for i := 0 to Length(LI.FNumL) - 1 do
  begin
    FNumL[i] := LI.FNumL[i];
  end;
end;

constructor TLongInteger.Create(N: Int64);
var
  i: Integer;
begin
  FSymb := (N >= 0);
  SetLength(FNumL, 64);
  i := 0;
  N := Abs(N);
  repeat
    FNumL[i] := (N and 1  = 1);
    N := N shr 1;
    Inc(i);
  until N = 0;
  SetLength(FNumL, i);
end;

constructor TLongInteger.Create(N: Integer);
var
  i: Integer;
begin
  FSymb := (N >= 0);
  SetLength(FNumL, 32);
  i := 0;
  N := Abs(N);
  repeat
    FNumL[i] := (N and 1  = 1);
    N := N shr 1;
    Inc(i);
  until N = 0;
  SetLength(FNumL, i);
end;

constructor TLongInteger.Create(N: Cardinal);
var
  i: Integer;
begin
  FSymb := True;
  SetLength(FNumL, 32);
  i := 0;
  repeat
    FNumL[i] := (N and 1  = 1);
    N := N shr 1;
    Inc(i);
  until N = 0;
  SetLength(FNumL, i);
end;

constructor TLongInteger.Create(N: Word);
var
  i: Integer;
begin
  FSymb := True;
  SetLength(FNumL, 16);
  i := 0;
  repeat
    FNumL[i] := (N and 1  = 1);
    N := N shr 1;
    Inc(i);
  until N = 0;
  SetLength(FNumL, i);
end;

constructor TLongInteger.Create(N: Byte);
var
  i: Integer;
begin
  FSymb := True;
  SetLength(FNumL, 8);
  i := 0;
  repeat
    FNumL[i] := (N and 1  = 1);
    N := N shr 1;
    Inc(i);
  until N = 0;
  SetLength(FNumL, i);
end;

destructor TLongInteger.Destroy;
begin
  SetLength(FNumL, 0);
  inherited;
end;

function TLongInteger.Digit: Integer;
begin
  Exit(Length(FNumL));
end;

function TLongInteger.Div10PowN(N: TLongInteger): TLongInteger;
var
  M: TLongInteger;
begin
  M := TLongInteger.Create(10);
  try
    M.Power(N);
    Divide(M);
  finally
    FreeAndNil(M);
  end;
  Exit(Self);
end;

function TLongInteger.DivAndMod(const Par, ModVal: TLongInteger): TLongInteger;
var
  ALI, BLI: TLongInteger;
  n, i: Integer;
  S: Boolean;
begin
  Normalize;
  if IsZero then
  begin
    Zero;
    Exit(Self);
  end;
  ALI := TLongInteger.Create;
  BLI := TLongInteger.Create;
  try
    S := not (FSymb xor Par.FSymb);
    ALI.CopyVal(Par);
    ALI.FSymb := True;
    FSymb := True;
    if LessThan(ALI) then
    begin
      ModVal.CopyVal(Self);
      Zero;
      Exit(Self);
    end;
    n := Length(FNumL) - Length(Par.FNumL);
    SetLength(BLI.FNumL, n + 1);
    ALI.ShiftL(n);
    for i := n downto 0 do
    begin
      if not LessThan(ALI) then
      begin
        AbsSub(ALI);
        BLI.FNumL[i] := True;
      end
      else
      begin
        BLI.FNumL[i] := False;
      end;
      ALI.ShiftR(1);
    end;
    ModVal.CopyVal(Self);
    BLI.Normalize;
    CopyVal(BLI);
    FSymb := S;
  finally
    FreeAndNil(ALI);
    FreeAndNil(BLI);
  end;
  Exit(Self);
end;

function TLongInteger.Divide(const Par: TLongInteger): TLongInteger;
var
  ALI, BLI: TLongInteger;
  n, i: Integer;
  S: Boolean;
begin
  Normalize;
  Par.Normalize;
  if IsZero then
  begin
    Zero;
    Exit(Self);
  end;
  if Par.IsZero then
  begin
    raise EZeroError.Create('Error Message: Cannot divide ZERO!!');
  end;
  ALI := TLongInteger.Create;
  BLI := TLongInteger.Create;
  try
    S := not (FSymb xor Par.FSymb);
    ALI.CopyVal(Par);
    ALI.FSymb := True;
    FSymb := True;
    if LessThan(ALI) then
    begin
      Zero;
      Exit(Self);
    end;
    n := Length(FNumL) - Length(Par.FNumL);
    SetLength(BLI.FNumL, n + 1);
    ALI.ShiftL(n);
    for i := n downto 0 do
    begin
      if not LessThan(ALI) then
      begin
        AbsSub(ALI);
        BLI.FNumL[i] := True;
      end
      else
      begin
        BLI.FNumL[i] := False;
      end;
      ALI.ShiftR(1);
    end;
    BLI.Normalize;
    CopyVal(BLI);
    FSymb := S;
  finally
    FreeAndNil(ALI);
    FreeAndNil(BLI);
  end;
  Exit(Self);
end;

function TLongInteger.Equal(const Par: TLongInteger): Boolean;
var
  i: Integer;
begin
  Normalize;
  Par.Normalize;
  if FSymb <> Par.FSymb then
  begin
    Exit(False);
  end;
  if Length(FNumL) <> Length(Par.FNumL) then
  begin
    Exit(False);
  end;
  for i := 0 to Length(FNumL) - 1 do
  begin
    if FNumL[i] <> Par.FNumL[i] then
    begin
      Exit(False);
    end;
  end;
  Exit(True);
end;

function TLongInteger.FromBytes(B: TBytes): TLongInteger;
var
  n: Byte;
  i, l: Integer;
begin
  FSymb := True;
  l := Length(B);
  SetLength(FNumL, 8 * l);
  for i := 0 to l - 1 do
  begin
    n := B[i];
    FNumL[8 * i] := (n and 1 = 1);
    n := n shr 1;
    FNumL[8 * i + 1] := (n and 1 = 1);
    n := n shr 1;
    FNumL[8 * i + 2] := (n and 1 = 1);
    n := n shr 1;
    FNumL[8 * i + 3] := (n and 1 = 1);
    n := n shr 1;
    FNumL[8 * i + 4] := (n and 1 = 1);
    n := n shr 1;
    FNumL[8 * i + 5] := (n and 1 = 1);
    n := n shr 1;
    FNumL[8 * i + 6] := (n and 1 = 1);
    n := n shr 1;
    FNumL[8 * i + 7] := (n and 1 = 1);
  end;
  Normalize;
  Exit(Self);
end;

function TLongInteger.FromBytes16(B: TBytes): TLongInteger;
var
  n: Byte;
  i, l: Integer;
begin
  FSymb := True;
  l := Length(B);
  SetLength(FNumL, 4 * l);
  for i := 0 to l - 1 do
  begin
    n := B[i];
    FNumL[4 * i] := (n and 1 = 1);
    n := n shr 1;
    FNumL[4 * i + 1] := (n and 1 = 1);
    n := n shr 1;
    FNumL[4 * i + 2] := (n and 1 = 1);
    n := n shr 1;
    FNumL[4 * i + 3] := (n and 1 = 1);
  end;
  Normalize;
  Exit(Self);
end;

function TLongInteger.FromInteger(N: Byte): TLongInteger;
var
  i: Integer;
begin
  FSymb := True;
  SetLength(FNumL, 8);
  i := 0;
  repeat
    FNumL[i] := (N and 1  = 1);
    N := N shr 1;
    Inc(i);
  until N = 0;
  SetLength(FNumL, i);
  Exit(Self);
end;

function TLongInteger.FromInteger(N: Cardinal): TLongInteger;
var
  i: Integer;
begin
  FSymb := True;
  SetLength(FNumL, 32);
  i := 0;
  repeat
    FNumL[i] := (N and 1  = 1);
    N := N shr 1;
    Inc(i);
  until N = 0;
  SetLength(FNumL, i);
  Exit(Self);
end;

function TLongInteger.FromInteger(N: Integer): TLongInteger;
var
  i: Integer;
begin
  FSymb := (N >= 0);
  SetLength(FNumL, 32);
  i := 0;
  N := Abs(N);
  repeat
    FNumL[i] := (N and 1  = 1);
    N := N shr 1;
    Inc(i);
  until N = 0;
  SetLength(FNumL, i);
  Exit(Self);
end;

function TLongInteger.FromInteger(N: Int64): TLongInteger;
var
  i: Integer;
begin
  FSymb := (N >= 0);
  SetLength(FNumL, 64);
  i := 0;
  N := Abs(N);
  repeat
    FNumL[i] := (N and 1  = 1);
    N := N shr 1;
    Inc(i);
  until N = 0;
  SetLength(FNumL, i);
  Exit(Self);
end;

function TLongInteger.FromInteger(N: Word): TLongInteger;
var
  i: Integer;
begin
  FSymb := True;
  SetLength(FNumL, 16);
  i := 0;
  repeat
    FNumL[i] := (N and 1  = 1);
    N := N shr 1;
    Inc(i);
  until N = 0;
  SetLength(FNumL, i);
  Exit(Self);
end;

function TLongInteger.FromRandom(Digits: Integer): TLongInteger;
var
  i: Integer;
begin
  if Digits <= 0 then
  begin
    Zero;
    Exit(Self);
  end;
  FSymb := True;
  SetLength(FNumL, Digits);
  for i := 0 to Digits - 2 do
  begin
    Randomize;
    FNumL[i] := (Random < 0.5);
  end;
  FNumL[Digits - 1] := True;;
  Exit(Self);
end;

function TLongInteger.FromRandomEven(Digits: Integer): TLongInteger;
var
  i: Integer;
begin
  if Digits <= 0 then
  begin
    Zero;
    Exit(Self);
  end;
  FSymb := True;
  SetLength(FNumL, Digits);
  FNumL[0] := False;
  for i := 1 to Digits - 2 do
  begin
    Randomize;
    FNumL[i] := (Random < 0.5);
  end;
  FNumL[Digits - 1] := True;;
  Exit(Self);
end;

function TLongInteger.FromRandomOdd(Digits: Integer): TLongInteger;
var
  i: Integer;
begin
  if Digits <= 0 then
  begin
    Zero;
    Exit(Self);
  end;
  FSymb := True;
  SetLength(FNumL, Digits);
  FNumL[0] := True;
  for i := 1 to Digits - 2 do
  begin
    Randomize;
    FNumL[i] := (Random < 0.5);
  end;
  FNumL[Digits - 1] := True;;
  Exit(Self);
end;

function TLongInteger.FromString10(Str: string): Boolean;
var
  i, l: Integer;
  v: Byte;
  LI, Par: TLongInteger;
  S: Boolean;
begin
  if Str = '' then
  begin
    Exit(False);
  end;
  if Str.Chars[0] = '-' then
  begin
    S := False;
    Str := Str.Substring(1);
  end
  else
  begin
    S := True;
  end;
  l := Str.Length;
  if l <= 0 then
  begin
    Exit(False);
  end;
  for i := 0 to l - 1 do if GetDecVal(Str.Chars[i]) = 255 then
  begin
    Exit(False);
  end;
  Zero;
  LI := TLongInteger.Create;
  Par := TLongInteger.Create;
  try
    SetLength(Par.FNumL, 4);
    Par.FNumL[0] := False;
    Par.FNumL[1] := True;
    Par.FNumL[2] := False;
    Par.FNumL[3] := True;
    for i := 0 to l - 1 do
    begin
      v := GetDecVal(Str.Chars[i]);
      LI.FromInteger(v);
      Multiply(Par).Add(LI);
    end;
  finally
    FreeAndNil(LI);
    FreeAndNil(Par);
  end;
  FSymb := S;
  Normalize;
  Exit(True);
end;

function TLongInteger.FromString16(Str: string): Boolean;
var
  i, l: Integer;
  v: Byte;
begin
  if Str = '' then
  begin
    Exit(False);
  end;
  Str := UpperCase(Str);
  l := Str.Length;
  if Str.Chars[0] = '-' then
  begin
    if l <= 1 then
    begin
      Exit(False);
    end;
    for i := 1 to l - 1 do if GetHexVal(Str.Chars[i]) = 255 then
    begin
      Exit(False);
    end;
    FSymb := False;
    SetLength(FNumL, 4 * l - 4);
    for i := 0 to l - 2 do
    begin
      v := GetHexVal(Str.Chars[l - 1 - i]);
      FNumL[4 * i] := (v and 1 = 1);
      v := v shr 1;
      FNumL[4 * i + 1] := (v and 1 = 1);
      v := v shr 1;
      FNumL[4 * i + 2] := (v and 1 = 1);
      v := v shr 1;
      FNumL[4 * i + 3] := (v and 1 = 1);
    end;
  end
  else
  begin
    if l <= 0 then
    begin
      Exit(False);
    end;
    for i := 0 to l - 1 do
    begin
      if GetHexVal(Str.Chars[i]) = 255 then
      begin
        Exit(False);
      end;
    end;
    FSymb := True;
    SetLength(FNumL, 4 * l);
    for i := 0 to l - 1 do
    begin
      v := GetHexVal(Str.Chars[l - 1 - i]);
      FNumL[4 * i] := (v and 1 = 1);
      v := v shr 1;
      FNumL[4 * i + 1] := (v and 1 = 1);
      v := v shr 1;
      FNumL[4 * i + 2] := (v and 1 = 1);
      v := v shr 1;
      FNumL[4 * i + 3] := (v and 1 = 1);
    end;
  end;
  Normalize;
  Exit(True);
end;

function TLongInteger.FromString2(Str: string): Boolean;
var
  i, l: Integer;
begin
  if Str = '' then
  begin
    Exit(False);
  end;
  Str := UpperCase(Str);
  l := Str.Length;
  if Str.Chars[0] = '-' then
  begin
    if l <= 1 then
    begin
      Exit(False);
    end;
    for i := 1 to l - 1 do if GetHexVal(Str.Chars[i]) > 1 then
    begin
      Exit(False);
    end;
    FSymb := False;
    SetLength(FNumL, l - 1);
    for i := 0 to l - 2 do
    begin
      FNumL[i] := (Str.Chars[l - 1 - i] = '1');
    end;
  end
  else
  begin
    if l <= 0 then
    begin
      Exit(False);
    end;
    for i := 0 to l - 1 do if GetHexVal(Str.Chars[i]) > 1 then
    begin
      Exit(False);
    end;
    FSymb := True;
    SetLength(FNumL, l);
    for i := 0 to l - 1 do
    begin
      FNumL[i] := (Str.Chars[l - 1 - i] = '1');
    end;
  end;
  Normalize;
  Exit(True);
end;

function TLongInteger.GetValue(Index: Integer): Boolean;
begin
  Exit(FNumL[Index]);
end;

function TLongInteger.GreaterThan(const Par: TLongInteger): Boolean;
var
  i: Integer;
begin
  Normalize;
  Par.Normalize;
  if FSymb and not Par.FSymb then
  begin
    Exit(True);
  end;
  if not FSymb and Par.FSymb then
  begin
    Exit(False);
  end;
  if Length(FNumL) > Length(Par.FNumL) then
  begin
    Exit(True);
  end;
  if Length(FNumL) < Length(Par.FNumL) then
  begin
    Exit(False);
  end;
  for i := Length(FNumL) - 1 downto 0 do
  begin
    if FNumL[i] and not Par.FNumL[i] then
    begin
      Exit(True);
    end;
    if not FNumL[i] and Par.FNumL[i] then
    begin
      Exit(False);
    end;
  end;
  Exit(False);
end;

function TLongInteger.IsEven: Boolean;
begin
  Exit((Length(FNumL) > 0) and (FNumL[0] = False));
end;

function TLongInteger.IsOdd: Boolean;
begin
  Exit((Length(FNumL) > 0) and (FNumL[0] = True));
end;

function TLongInteger.IsZero: Boolean;
begin
  Normalize;
  if (FSymb = True) and (Length(FNumL) = 1) and (FNumL[0] = False) then
  begin
    Exit(True);
  end
  else
  begin
    Exit(False);
  end;
end;

function TLongInteger.LessThan(const Par: TLongInteger): Boolean;
var
  i: Integer;
begin
  Normalize;
  Par.Normalize;
  if FSymb and not Par.FSymb then
  begin
    Exit(False);
  end;
  if not FSymb and Par.FSymb then
  begin
    Exit(True);
  end;
  if Length(FNumL) > Length(Par.FNumL) then
  begin
    Exit(False);
  end;
  if Length(FNumL) < Length(Par.FNumL) then
  begin
    Exit(True);
  end;
  for i := Length(FNumL) - 1 downto 0 do
  begin
    if FNumL[i] and not Par.FNumL[i] then
    begin
      Exit(False);
    end;
    if not FNumL[i] and Par.FNumL[i] then
    begin
      Exit(True);
    end;
  end;
  Exit(False);
end;

function TLongInteger.LogicalAnd(const Par: TLongInteger): TLongInteger;
var
  i, n: Integer;
begin
  Normalize;
  Par.Normalize;
  if Length(FNumL) < Length(Par.FNumL) then
  begin
    n := Length(FNumL);
  end
  else
  begin
    n := Length(Par.FNumL);
  end;
  for i := 0 to n - 1 do
  begin
    FNumL[i] := FNumL[i] and Par.FNumL[i];
  end;
  Normalize;
  Exit(Self);
end;

function TLongInteger.LogicalNot: TLongInteger;
var
  i: Integer;
begin
  for i := 0 to Length(FNumL) - 1 do
  begin
    FNumL[i] := not FNumL[i];
  end;
  Normalize;
  Exit(Self);
end;

function TLongInteger.LogicalOr(const Par: TLongInteger): TLongInteger;
var
  i, n: Integer;
begin
  Normalize;
  Par.Normalize;
  if Length(FNumL) > Length(Par.FNumL) then
  begin
    n := Length(FNumL);
  end
  else
  begin
    n := Length(Par.FNumL);
    SetLength(FNumL, n);
  end;
  for i := 0 to n - 1 do if i < Length(Par.FNumL) then
  begin
    if i < Length(FNumL) then
    begin
      FNumL[i] := FNumL[i] or Par.FNumL[i];
    end
    else
    begin
      FNumL[i] := Par.FNumL[i];
    end;
  end;
  Normalize;
  Exit(Self);
end;

function TLongInteger.LogicalXor(const Par: TLongInteger): TLongInteger;
var
  i, n: Integer;
begin
  Normalize;
  Par.Normalize;
  if Length(FNumL) > Length(Par.FNumL) then
  begin
    n := Length(FNumL);
  end
  else
  begin
    n := Length(Par.FNumL);
    SetLength(FNumL, n);
  end;
  for i := 0 to n - 1 do if i < Length(Par.FNumL) then
  begin
    if i < Length(FNumL) then
    begin
      FNumL[i] := FNumL[i] xor Par.FNumL[i];
    end
    else
    begin
      FNumL[i] := Par.FNumL[i];
    end;
  end;
  Normalize;
  Exit(Self);
end;

function TLongInteger.Modulus(const Par: TLongInteger): TLongInteger;
var
  ALI: TLongInteger;
  n, i: Integer;
  S: Boolean;
begin
  Normalize;
  Par.Normalize;
  if IsZero then
  begin
    Zero;
    Exit(Self);
  end;
  if Par.IsZero then
  begin
    raise EZeroError.Create('Error Message: Cannot divide ZERO!!');
    Exit(nil);
  end;
  ALI := TLongInteger.Create;
  try
    S := FSymb;
    ALI.CopyVal(Par).FSymb := True;
    FSymb := True;
    if LessThan(ALI) then
    begin
      FSymb := S;
      Exit(Self);
    end;
    n := Length(FNumL) - Length(Par.FNumL);
    ALI.ShiftL(n);
    for i := n downto 0 do
    begin
      if not LessThan(ALI) then
      begin
        AbsSub(ALI);
      end;
      ALI.ShiftR(1);
    end;
  finally
    FreeAndNil(ALI);
  end;
  Normalize;
  FSymb := S;
  Exit(Self);
end;

function TLongInteger.Multiply(const Par: TLongInteger): TLongInteger;
var
  Bit, NumLength, i: Integer;
  RevList: TArray<Integer>;
  ComplexA, ComplexB: TArray<TComplex>;
  S: Boolean;
  B1, B2: TBytes;
begin
  Normalize;
  Par.Normalize;
  if IsZero or Par.IsZero then
  begin
    Zero;
    Exit(Self);
  end;
  S := not (FSymb xor Par.FSymb);
  B1 := ToBytes;
  B2 := Par.ToBytes;
  Bit := 1;
  NumLength := 2;
  while (1 shl bit) < Length(B1) + Length(B2) - 1 do
  begin
    NumLength := NumLength shl 1;
    Bit := Bit + 1;
  end;
  SetLength(ComplexA, NumLength);
  SetLength(ComplexB, NumLength);
  GetReverseList(RevList, Bit);
  FFTBytes(B1, ComplexA, RevList, NumLength);
  FFTBytes(B2, ComplexB, RevList, NumLength);
  for i := 0 to NumLength - 1 do
  begin
    ComplexA[i] := ComplexA[i] * ComplexB[i];
  end;
  IFFTBytes(B1, ComplexA, RevList, NumLength);
  FromBytes(B1);
  FSymb := S;
  Normalize;
  Exit(Self);
end;

function TLongInteger.Mut10PowN(N: TLongInteger): TLongInteger;
var
  M: TLongInteger;
begin
  M := TLongInteger.Create(10);
  try
    M.Power(N);
    Multiply(M);
  finally
    FreeAndNil(M);
  end;
  Exit(Self);
end;

function TLongInteger.Negative: TLongInteger;
begin
  FSymb := not FSymb;
  Normalize;
  Exit(Self);
end;

function TLongInteger.Normalize: TLongInteger;
var
  i, l: Integer;
begin
  l := Length(FNumL);
  for i := l downto 0 do
  begin
    if (i > 0) and FNumL[i - 1] then
    begin
      SetLength(FNumL, i);
      Break;
    end
    else if i = 0 then
    begin
      Zero;
    end;
  end;
  Exit(Self);
end;

function TLongInteger.Positive: TLongInteger;
begin
  Exit(Self);
end;

function TLongInteger.Power(const Par: TLongInteger): TLongInteger;
var
  LIB, LIP: TLongInteger;
  S: Boolean;
begin
  if Par.IsZero or not Par.FSymb then
  begin
    raise EPowerError.Create('Error Message: Power index must be greater than ZERO!');
  end;
  if IsZero then
  begin
    Exit(Self);
  end;
  if not Par.FNumL[0] then
  begin
    S := True;
  end
  else
  begin
    S := FSymb;
  end;
  FSymb := True;
  LIB := TLongInteger.Create(Self);
  LIP := TLongInteger.Create(Par);
  SetLength(FNumL, 1);
  FNumL[0] := True;
  try
    while LIP.FSymb and not LIP.IsZero do
    begin
      if LIP.FNumL[0] then
      begin
        Multiply(LIB);
      end;
      LIP.ShiftR(1);
      LIB.Multiply(LIB);
    end;
  finally
    LIB.DisposeOf;
    LIP.DisposeOf;
  end;
  FSymb := S;
  Exit(Self);
end;

function TLongInteger.PowAndMod(PowPar, ModPar: TLongInteger): TLongInteger;
var
  LIB, LIP: TLongInteger;
  S: Boolean;
begin
  if PowPar.IsZero or not PowPar.FSymb then
  begin
    raise EPowerError.Create('Error Message: Power index must be greater than ZERO!');
  end;
  if ModPar.IsZero then
  begin
    raise EZeroError.Create('Error Message: Cannot divide ZERO!');
  end;
  if IsZero then
  begin
    Exit(Self);
  end;
  if not PowPar.FNumL[0] then
  begin
    S := True;
  end
  else
  begin
    S := FSymb;
  end;
  FSymb := True;
  LIB := TLongInteger.Create(Self);
  LIP := TLongInteger.Create(PowPar);
  SetLength(FNumL, 1);
  FNumL[0] := True;
  try
    while LIP.FSymb and not LIP.IsZero do
    begin
      if LIP.FNumL[0] then
      begin
        Multiply(LIB).Modulus(ModPar);
      end;
      LIP.ShiftR(1);
      LIB.Multiply(LIB).Modulus(ModPar);
    end;
  finally
    LIB.DisposeOf;
    LIP.DisposeOf;
  end;
  FSymb := S;
  Exit(Self);
end;

function TLongInteger.ShiftL(Shift: Integer): TLongInteger;
var
  AList: TArray<Boolean>;
  i: Integer;
begin
  if Shift <= 0 then
  begin
    Exit(Self);
  end;
  SetLength(AList, Shift);
  for i := 0 to Shift - 1 do
  begin
    AList[i] := False;
  end;
  Insert(AList, FNumL, 0);
  Normalize;
  Exit(Self);
end;

function TLongInteger.ShiftR(Shift: Integer): TLongInteger;
begin
  if Shift <= 0 then
  begin
    Exit(Self);
  end;
  if Length(FNumL) <= Shift then
  begin
    Zero;
  end
  else
  begin
    Delete(FNumL, 0, Shift);
  end;
  Normalize;
  Exit(Self);
end;

function TLongInteger.Subtract(const Par: TLongInteger): TLongInteger;
begin
  if IsZero then
  begin
    CopyVal(Par);
    FSymb := not FSymb;
  end
  else if Par.IsZero then
  begin
    Exit(Self);
  end
  else if FSymb = Par.FSymb then
  begin
    AbsSub(Par);
  end
  else
  begin
    AbsAdd(Par);
  end;
  Exit(Self);
end;

function TLongInteger.ToBytes: TBytes;
var
  bs: TBytes;
  i, l: Integer;
  n: Byte;
begin
  l := (Length(FNumL) - 1) div 8 + 1;
  SetLength(bs, l);
  for i := 0 to l - 1 do
  begin
    n := 0;
    if (8 * i < Length(FNumL)) and FNumL[8 * i] then
    begin
      n := n + 1;
    end;
    if (8 * i + 1 < Length(FNumL)) and FNumL[8 * i + 1] then
    begin
      n := n + 2;
    end;
    if (8 * i + 2 < Length(FNumL)) and FNumL[8 * i + 2] then
    begin
      n := n + 4;
    end;
    if (8 * i + 3 < Length(FNumL)) and FNumL[8 * i + 3] then
    begin
      n := n + 8;
    end;
    if (8 * i + 4 < Length(FNumL)) and FNumL[8 * i + 4] then
    begin
      n := n + 16;
    end;
    if (8 * i + 5 < Length(FNumL)) and FNumL[8 * i + 5] then
    begin
      n := n + 32;
    end;
    if (8 * i + 6 < Length(FNumL)) and FNumL[8 * i + 6] then
    begin
      n := n + 64;
    end;
    if (8 * i + 7 < Length(FNumL)) and FNumL[8 * i + 7] then
    begin
      n := n + 128;
    end;
    bs[i] := n;
  end;
  Exit(bs);
end;

function TLongInteger.ToBytes16: TBytes;
var
  bs: TBytes;
  i, l: Integer;
  n: Byte;
begin
  l := (Length(FNumL) - 1) div 4 + 1;
  SetLength(bs, l);
  for i := 0 to l - 1 do
  begin
    n := 0;
    if (4 * i < Length(FNumL)) and FNumL[4 * i] then
    begin
      n := n + 1;
    end;
    if (4 * i + 1 < Length(FNumL)) and FNumL[4 * i + 1] then
    begin
      n := n + 2;
    end;
    if (4 * i + 2 < Length(FNumL)) and FNumL[4 * i + 2] then
    begin
      n := n + 4;
    end;
    if (4 * i + 3 < Length(FNumL)) and FNumL[4 * i + 3] then
    begin
      n := n + 8;
    end;
    bs[i] := n;
  end;
  Exit(bs);
end;

function TLongInteger.ToString10: string;
var
  F: Boolean;
  s: string;
  Par, ModVal, LITen: TLongInteger;
begin
  if Length(FNumL) = 0 then
  begin
    Exit('0');
  end;
  s := '';
  F := FSymb;
  FSymb := True;
  ModVal := TLongInteger.Create;
  Par := TLongInteger.Create;
  LITen := TLongInteger.Create(10);
  try
    Par.CopyVal(Self);
    repeat
      Par.DivAndMod(LITen, ModVal);
      s := ModVal.ToString16 + s;
    until Par.IsZero;
  finally
    FreeAndNil(ModVal);
    FreeAndNil(Par);
  end;
  FSymb := F;
  if not FSymb then
  begin
    s := '-' + s;
  end;
  Exit(s);
end;

function TLongInteger.ToString16: string;
var
  s: string;
  i: Integer;
  n: Byte;
begin
  if Length(FNumL) = 0 then
  begin
    Exit('0');
  end;
  s := '';
  for i := 0 to (Length(FNumL) - 1) div 4 do
  begin
    n := 0;
    if (4 * i + 3 < Length(FNumL)) and (FNumL[4 * i + 3]) then
    begin
      Inc(n, 8);
    end;
    if (4 * i + 2 < Length(FNumL)) and (FNumL[4 * i + 2]) then
    begin
      Inc(n, 4);
    end;
    if (4 * i + 1 < Length(FNumL)) and (FNumL[4 * i + 1]) then
    begin
      Inc(n, 2);
    end;
    if (4 * i < Length(FNumL)) and (FNumL[4 * i]) then
    begin
      Inc(n, 1);
    end;
    s := GetHexChr(n) + s;
  end;
  if not FSymb then
  begin
    s := '-' + s;
  end;
  Exit(s);
end;

function TLongInteger.ToString2: string;
var
  s: string;
  i: Integer;
begin
  if Length(FNumL) = 0 then
  begin
    Exit('0');
  end;
  if not FSymb then
  begin
    s := '-';
  end;
  for i := Length(FNumL) - 1 downto 0 do
  begin
    if FNumL[i] then
    begin
      s := s + '1';
    end
    else
    begin
      s := s + '0';
    end;
  end;
  Exit(s);
end;

function TLongInteger.Zero: TLongInteger;
begin
  SetLength(FNumL, 1);
  FNumL[0] := False;
  FSymb := True;
  Exit(Self);
end;

{ THexInt }

class operator THexInt.Add(const Hex1, Hex2: THexInt): THexInt;
var
  LI1, LI2: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  LI2 := TLongInteger.Create;
  try
    LI1.FromString16(Hex1.FHex);
    LI2.FromString16(Hex2.FHex);
    Result.FHex := LI1.Add(LI2).ToString16;
  finally
    FreeAndNil(LI1);
    FreeAndNil(LI2);
  end;
end;

class function THexInt.Create(const Str: string): THexInt;
var
  LI1: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  try
    if LI1.FromString16(Str) then
    begin
      Result.FHex := LI1.ToString16;
    end
    else
    begin
      Result.FHex := '0';
    end;
  finally
    FreeAndNil(LI1);
  end;
end;

class operator THexInt.Divide(const Hex1, Hex2: THexInt): THexInt;
var
  LI1, LI2: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  LI2 := TLongInteger.Create;
  try
    LI1.FromString16(Hex1.FHex);
    LI2.FromString16(Hex2.FHex);
    Result.FHex := LI1.Divide(LI2).ToString16;
  finally
    FreeAndNil(LI1);
    FreeAndNil(LI2);
  end;
end;

class operator THexInt.Equal(const Hex1, Hex2: THexInt): Boolean;
var
  LI1, LI2: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  LI2 := TLongInteger.Create;
  try
    LI1.FromString16(Hex1.FHex);      
    LI2.FromString16(Hex2.FHex);
    Exit(LI1.Equal(LI2));
  finally
    FreeAndNil(LI1);
    FreeAndNil(LI2);
  end;
end;

function THexInt.GetBinValue: string;
var
  LI1: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  try
    if LI1.FromString16(FHex) then
    begin
      Result := LI1.ToString2;
    end;
  finally
    FreeAndNil(LI1);
  end;
end;

function THexInt.GetDecValue: string;
var
  LI1: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  try
    if LI1.FromString16(FHex) then
    begin
      Result := LI1.ToString10;
    end;
  finally
    FreeAndNil(LI1);
  end;
end;

function THexInt.GetHexValue: string;
begin
  Result := FHex;
end;

class operator THexInt.GreaterThan(const Hex1, Hex2: THexInt): Boolean;
var
  LI1, LI2: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  LI2 := TLongInteger.Create;
  try
    LI1.FromString16(Hex1.FHex);      
    LI2.FromString16(Hex2.FHex);
    Exit(LI1.GreaterThan(LI2));
  finally
    FreeAndNil(LI1);
    FreeAndNil(LI2);
  end;
end;

class operator THexInt.GreaterThanOrEqual(const Hex1, Hex2: THexInt): Boolean;
var
  LI1, LI2: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  LI2 := TLongInteger.Create;
  try
    LI1.FromString16(Hex1.FHex);      
    LI2.FromString16(Hex2.FHex);
    Exit(not LI1.LessThan(LI2));
  finally
    FreeAndNil(LI1);
    FreeAndNil(LI2);
  end;
end;

class operator THexInt.IntDivide(const Hex1, Hex2: THexInt): THexInt;
var
  LI1, LI2: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  LI2 := TLongInteger.Create;
  try
    LI1.FromString16(Hex1.FHex);
    LI2.FromString16(Hex2.FHex);
    Result.FHex := LI1.Divide(LI2).ToString16;
  finally
    FreeAndNil(LI1);
    FreeAndNil(LI2);
  end;
end;

class operator THexInt.LessThan(const Hex1, Hex2: THexInt): Boolean;
var
  LI1, LI2: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  LI2 := TLongInteger.Create;
  try
    LI1.FromString16(Hex1.FHex);      
    LI2.FromString16(Hex2.FHex);
    Exit(LI1.LessThan(LI2));
  finally
    FreeAndNil(LI1);
    FreeAndNil(LI2);
  end;
end;

class operator THexInt.LessThanOrEqual(const Hex1, Hex2: THexInt): Boolean;
var
  LI1, LI2: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  LI2 := TLongInteger.Create;
  try
    LI1.FromString16(Hex1.FHex);      
    LI2.FromString16(Hex2.FHex);
    Exit(not LI1.GreaterThan(LI2));
  finally
    FreeAndNil(LI1);
    FreeAndNil(LI2);
  end;
end;

class operator THexInt.Modulus(const Hex1, Hex2: THexInt): THexInt;
var
  LI1, LI2: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  LI2 := TLongInteger.Create;
  try
    LI1.FromString16(Hex1.FHex);
    LI2.FromString16(Hex2.FHex);
    Result.FHex := LI1.Modulus(LI2).ToString16;
  finally
    FreeAndNil(LI1);
    FreeAndNil(LI2);
  end;
end;

class operator THexInt.Multiply(const Hex1, Hex2: THexInt): THexInt;
var
  LI1, LI2: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  LI2 := TLongInteger.Create;
  try
    LI1.FromString16(Hex1.FHex);
    LI2.FromString16(Hex2.FHex);
    Result.FHex := LI1.Multiply(LI2).ToString16;
  finally
    FreeAndNil(LI1);
    FreeAndNil(LI2);
  end;
end;

class operator THexInt.Negative(const Hex1: THexInt): THexInt;
var
  LI1: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  try
    LI1.FromString16(Hex1.FHex);
    LI1.Negative;
    Result.FHex := LI1.ToString16;
  finally
    FreeAndNil(LI1);
  end;
end;

class operator THexInt.NotEqual(const Hex1, Hex2: THexInt): Boolean;
var
  LI1, LI2: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  LI2 := TLongInteger.Create;
  try
    LI1.FromString16(Hex1.FHex);      
    LI2.FromString16(Hex2.FHex);
    Exit(not LI1.Equal(LI2));
  finally
    FreeAndNil(LI1);
    FreeAndNil(LI2);
  end;
end;

class operator THexInt.Positive(const Hex1: THexInt): THexInt;
begin
  Result.FHex := Hex1.FHex;
end;

function THexInt.Power(const Hex1: THexInt): THexInt;
var
  LI1, LI2: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  LI2 := TLongInteger.Create;
  try
    LI1.FromString16(FHex);
    LI2.FromString16(Hex1.FHex);
    Result.FHex := LI1.Power(LI2).ToString16;
  finally
    FreeAndNil(LI1);
    FreeAndNil(LI2);
  end;
end;

function THexInt.PowAndMod(const Hex1, Hex2: THexInt): THexInt;
var
  LI1, LI2, LI3: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  LI2 := TLongInteger.Create;
  LI3 := TLongInteger.Create;
  try
    LI1.FromString16(FHex);
    LI2.FromString16(Hex1.FHex);
    LI3.FromString16(Hex2.FHex);
    Result.FHex := LI1.PowAndMod(LI2, LI3).ToString16;
  finally
    FreeAndNil(LI1);
    FreeAndNil(LI2);
  end;
end;

procedure THexInt.SetBinValue(const Value: string);
var
  LI1: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  try
    if LI1.FromString2(Value) then
    begin
      FHex := LI1.ToString16;
    end;
  finally
    FreeAndNil(LI1);
  end;
end;

procedure THexInt.SetDecValue(const Value: string);
var
  LI1: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  try
    if LI1.FromString10(Value) then
    begin
      FHex := LI1.ToString16;
    end;
  finally
    FreeAndNil(LI1);
  end;
end;

procedure THexInt.SetHexValue(const Value: string);
var
  LI1: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  try
    if LI1.FromString16(Value) then
    begin
      FHex := LI1.ToString16;
    end;
  finally
    FreeAndNil(LI1);
  end;
end;

class operator THexInt.Subtract(const Hex1, Hex2: THexInt): THexInt;
var
  LI1, LI2: TLongInteger;
begin
  LI1 := TLongInteger.Create;
  LI2 := TLongInteger.Create;
  try
    LI1.FromString16(Hex1.FHex);
    LI2.FromString16(Hex2.FHex);
    Result.FHex := LI1.Subtract(LI2).ToString16;
  finally
    FreeAndNil(LI1);
    FreeAndNil(LI2);
  end;
end;

{ TLongReal }

function TLongReal.AbsoluteVal: TLongReal;
begin
  FCoe.AbsoluteVal;
  Exit(Self);
end;

function TLongReal.Add(const Par: TLongReal): TLongReal;
var
  N: TLongInteger;
  R: TLongReal;
begin
  R := TLongReal.Create;
  N := TLongInteger.Create;
  try
    N.CopyVal(Par.FExp).Subtract(FExp).AbsoluteVal;
    if R.FExp.GreaterThan(FExp) then
    begin
      R.CopyVal(Par);
      FCoe.Add(R.FCoe.Mut10PowN(N));
    end
    else
    begin
      FExp.CopyVal(Par.FExp);
      FCoe.Mut10PowN(N).Add(Par.FCoe);
    end;
    Normalize;
  finally
    FreeAndNil(R);
    FreeAndNil(N);
  end;
  Exit(Self);
end;

function TLongReal.CopyVal(const Par: TLongReal): TLongReal;
begin
  FCoe.CopyVal(Par.FCoe);
  FExp.CopyVal(Par.FExp);
  Exit(Self);
end;

constructor TLongReal.Create;
begin
  inherited;
  FCoe := TLongInteger.Create;
  FExp := TLongInteger.Create;
end;

constructor TLongReal.Create(LR: TLongReal);
begin
  inherited Create;
  FCoe := TLongInteger.Create;
  FExp := TLongInteger.Create;
  FCoe.CopyVal(LR.FCoe);
  FExp.CopyVal(LR.FExp);
end;

constructor TLongReal.Create(Coe: TLongInteger);
begin
  inherited Create;
  FCoe := TLongInteger.Create;
  FExp := TLongInteger.Create;
  FCoe.CopyVal(Coe);
end;

constructor TLongReal.Create(Coe, Exp: TLongInteger);
begin
  inherited Create;
  FCoe := TLongInteger.Create;
  FExp := TLongInteger.Create;
  FCoe.CopyVal(Coe);
  FExp.CopyVal(Exp);
end;

destructor TLongReal.Destroy;
begin
  FreeAndNil(FCoe);
  FreeAndNil(FExp);
  inherited;
end;

function TLongReal.Divide(const Par: TLongReal; Digit: Cardinal): TLongReal;
var
  N: TLongInteger;
begin
  N := TLongInteger.Create(Digit);
  try
    FCoe.Mut10PowN(N).Divide(Par.FCoe);
    FExp.Subtract(N).Subtract(Par.FExp);
  finally
    FreeAndNil(N);
  end;
  Normalize;
  Exit(Self);
end;

function TLongReal.Equal(const Par: TLongReal; Digit: Integer): Boolean;
var
  R: TLongReal;
  N: TLongInteger;
begin
  R := TLongReal.Create(Self);
  N := TLongInteger.Create(Digit);
  try
    R.Subtract(Par).AbsoluteVal;
    if R.FCoe.IsZero then
    begin
      Exit(True);
    end;
    R.FExp.Subtract(N).Normalize;
    if R.FExp.FSymb and not R.FExp.IsZero then
    begin
      Exit(False);
    end;
    R.FCoe.Div10PowN(R.FExp.AbsoluteVal);
    if R.FCoe.IsZero then
    begin
      Exit(True);
    end
    else
    begin
      Exit(False);
    end;
  finally
    FreeAndNil(R);
    FreeAndNil(N);
  end;
  Exit(False);
end;

function TLongReal.FromInteger(Coe, Exp: Integer): TLongReal;
begin
  FCoe.FromInteger(Coe);
  FExp.FromInteger(Exp);
  Exit(Self);
end;

function TLongReal.FromInteger(Coe, Exp: Int64): TLongReal;
begin
  FCoe.FromInteger(Coe);
  FExp.FromInteger(Exp);
  Exit(Self);
end;

function TLongReal.FromStringOri(Str: string): Boolean;
var
  SS: TArray<string>;
begin
  SS := Str.Split(['e', 'E']);
  if FCoe.FromString10(SS[0]) and FExp.FromString10(SS[1]) then
  begin
    Exit(True);
  end
  else
  begin
    Zero;
    Exit(False);
  end;
end;

function TLongReal.GreaterThan(const Par: TLongReal; Digit: Integer): Boolean;
var
  R: TLongReal;
  N: TLongInteger;
begin
  R := TLongReal.Create(Self);
  N := TLongInteger.Create(Digit);
  try
    R.Subtract(Par);
    if not R.FCoe.FSymb then
    begin
      Exit(False);
    end;
    if R.FCoe.IsZero then
    begin
      Exit(False);
    end;
    R.FExp.Subtract(N).Normalize;
    if R.FExp.FSymb and not R.FExp.IsZero then
    begin
      Exit(True);
    end;
    R.FCoe.Div10PowN(R.FExp.AbsoluteVal);
    if R.FCoe.IsZero then
    begin
      Exit(False);
    end
    else
    begin
      Exit(True);
    end;
  finally
    FreeAndNil(R);
    FreeAndNil(N);
  end;
  Exit(False);
end;

function TLongReal.LessThan(const Par: TLongReal; Digit: Integer): Boolean;
var
  R: TLongReal;
  N: TLongInteger;
begin
  R := TLongReal.Create(Self);
  N := TLongInteger.Create(Digit);
  try
    R.Subtract(Par);
    if R.FCoe.FSymb then
    begin
      Exit(False);
    end;
    if R.FCoe.IsZero then
    begin
      Exit(False);
    end;
    R.FExp.Subtract(N).Normalize;
    R.FCoe.AbsoluteVal;
    if R.FExp.FSymb and not R.FExp.IsZero then
    begin
      Exit(True);
    end;
    R.FCoe.Div10PowN(R.FExp.AbsoluteVal);
    if R.FCoe.IsZero then
    begin
      Exit(False);
    end
    else
    begin
      Exit(True);
    end;
  finally
    FreeAndNil(R);
    FreeAndNil(N);
  end;
  Exit(False);
end;

function TLongReal.Multiply(const Par: TLongReal): TLongReal;
begin
  FCoe.Multiply(Par.FCoe);
  FExp.Add(Par.FExp);
  Normalize;
  Exit(Self);
end;

function TLongReal.Negative: TLongReal;
begin
  FCoe.Negative;
  Exit(Self);
end;

function TLongReal.Normalize: TLongReal;
var
  S: string;
  i, n: Integer;
  T: TLongInteger;
begin
  FCoe.Normalize;
  FExp.Normalize;
  if FCoe.IsZero then
  begin
    FExp.Zero;
    Exit(Self);
  end;
  S := FCoe.ToString10;
  n := 0;
  for i := S.Length - 1 to 0 do if S.Chars[i] <> '0' then
  begin
    n := S.Length - 1 - i;
    Break;
  end;
  T := TLongInteger.Create(n);
  try
    FCoe.Div10PowN(T);
    FExp.Add(T);
  finally
    FreeAndNil(T);
  end;
  Exit(Self);
end;

function TLongReal.Positive: TLongReal;
begin
  Exit(Self);
end;

function TLongReal.Round(LI: TLongInteger): TLongInteger;
var
  LRA, LRB: TLongReal;
  LIOne: TLongInteger;
begin
  LRA := TLongReal.Create;
  LRB := TLongReal.Create;
  LIOne := TLongInteger.Create(1);
  try
    LRA.FCoe.CopyVal(Trunc(LI));
    LRA.FExp.FromInteger(0);
    LRA.Subtract(Self).Positive;
    LI.Positive;
    LRB.FromInteger(5, -1);
    if (LRA.Equal(LRB) and LI.IsOdd) or LRA.GreaterThan(LRB) then
    begin
      LI.Add(LIOne);
    end;
    LI.FSymb := FCoe.FSymb;
  finally
    FreeAndNil(LRA);
    FreeAndNil(LRB);
    FreeAndNil(LIOne);
  end;
  Exit(LI);
end;

function TLongReal.Subtract(const Par: TLongReal): TLongReal;
var
  N: TLongInteger;
  R: TLongReal;
begin
  R := TLongReal.Create;
  N := TLongInteger.Create;
  try
    N.CopyVal(Par.FExp).Subtract(FExp).AbsoluteVal;
    if R.FExp.GreaterThan(FExp) then
    begin
      R.CopyVal(Par);
      FCoe.Subtract(R.FCoe.Mut10PowN(N));
    end
    else
    begin
      FExp.CopyVal(Par.FExp);
      FCoe.Mut10PowN(N).Subtract(Par.FCoe);
    end;
    Normalize;
  finally
    FreeAndNil(R);
    FreeAndNil(N);
  end;
  Exit(Self);
end;

function TLongReal.ToStringOri: string;
begin
  Exit(Format('%se%s', [FCoe.ToString10, FExp.ToString10]));
end;

function TLongReal.Trunc(LI: TLongInteger): TLongInteger;
var
  LIA: TLongInteger;
begin
  LIA := TLongInteger.Create;
  try
    LI.CopyVal(FCoe);
    LIA.CopyVal(FExp).Positive;
    if not FExp.FSymb then
    begin
      LI.Div10PowN(LIA);
    end
    else
    begin
      LI.Mut10PowN(LIA);
    end;
  finally
    FreeAndNil(LIA);
  end;
  Exit(LI);
end;

function TLongReal.Zero: TLongReal;
begin
  FCoe.Zero;
  FExp.Zero;
  Exit(Self);
end;

{ TComplex }

class operator TComplex.Add(const C1, C2: TComplex): TComplex;
var
  A, B: Double;
begin
  A := C1.FM * Cos(C1.FA) + C2.FM * Cos(C2.FA);
  B := C1.FM * Sin(C1.FA) + C2.FM * Sin(C2.FA);
  Result.FM := Sqrt(A * A + B * B);
  Result.FA := ArcTan2(B, A);
end;

function TComplex.Argument: Double;
begin
  Exit(FA);
end;

function TComplex.Conjugate: TComplex;
begin
  Result.FM := FM;
  Result.FA := -FA;
end;

class function TComplex.Create(const Modulus, Argument: Double): TComplex;
begin
  Result.FM := Modulus;
  Result.FA := Argument;
end;

class operator TComplex.Divide(const C1: TComplex; const C2: Double): TComplex;
begin
  Result.FM := C1.FM / C2;
  Result.FA := C1.FA;
end;

class operator TComplex.Divide(const C1, C2: TComplex): TComplex;
begin
  Result.FM := C1.FM / C2.FM;
  Result.FA := C1.FA - C2.FA;
end;

function TComplex.Imaginary: Double;
begin
  Exit(FM * Sin(FA));
end;

function TComplex.Modulus: Double;
begin
  Exit(FM);
end;

class operator TComplex.Multiply(const C1: TComplex; const C2: Double): TComplex;
begin
  Result.FM := C1.FM * C2;
  Result.FA := C1.FA;
end;

class operator TComplex.Multiply(const C1, C2: TComplex): TComplex;
begin
  Result.FM := C1.FM * C2.FM;
  Result.FA := C1.FA + C2.FA;
end;

function TComplex.Real: Double;
begin
  Exit(FM * Cos(FA));
end;

class operator TComplex.Subtract(const C1, C2: TComplex): TComplex;
var
  A, B: Double;
begin
  A := C1.FM * Cos(C1.FA) - C2.FM * Cos(C2.FA);
  B := C1.FM * Sin(C1.FA) - C2.FM * Sin(C2.FA);
  Result.FM := Sqrt(A * A + B * B);
  Result.FA := ArcTan2(B, A);
end;

end.


