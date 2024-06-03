cd $PSScriptRoot
    . .\..\my_common.ps1
cd $PSScriptRoot

$ErrorActionPreference  = "Stop" # "Continue"
$WarningPreference      = "Continue" # "Stop"

Remove-Variable -Name a

$a = 10
MY_LOG "$(__LINE__)`: $a($(typeof $a))"
MY_LOG "$(__LINE__)`: typeof($a) -eq [int]`: $((typeof $a) -eq [int])"

$a = "my_str"
MY_LOG "$(__LINE__)`: $a($(typeof $a))"
MY_LOG "$(__LINE__)`: typeof($a) -eq [string]`: $((typeof $a) -eq [string])"

$a = 'e'
MY_LOG "$(__LINE__)`: $a($($a.GetType().FullName))"
MY_LOG "$(__LINE__)`: typeof($a) -eq [string]`: $((typeof $a) -eq [string])"

$a = 1.23456789
MY_LOG "$(__LINE__)`: $a($(typeof $a))"
MY_LOG "$(__LINE__)`: typeof($a) -eq [double]`: $((typeof $a) -eq [double])"

$a = $null
#MY_LOG "$(__LINE__)`: $a($(typeof $a))" # error
MY_LOG "$(__LINE__)`: typeof(`$null) -eq `$null`: $($null -eq (typeof $a))"

$a = $false
MY_LOG "$(__LINE__)`: $a($(typeof $a))"
MY_LOG "$(__LINE__)`: typeof($a) -eq [bool]`: $((typeof $a) -eq [bool])"

$a = @()
MY_LOG "$(__LINE__)`: a($(typeof $a)) Length=$($a.Length)"
MY_LOG "$(__LINE__)`: typeof($a) -eq [object[]]`: $((typeof($a)) -eq [object[]])"

$a = "123", "456"
MY_LOG "$(__LINE__)`: $a($(typeof $a)) Length=$($a.Length)"
MY_LOG "$(__LINE__)`: typeof($a) -eq [object[]]`: $((typeof($a)) -eq [object[]])"

$a = ("123", $null, $true, 12.2)
MY_LOG "$(__LINE__)`: $a($(typeof $a)) Length=$($a.Length)"
MY_LOG "$(__LINE__)`: typeof($a) -eq [object[]]`: $((typeof($a)) -eq [object[]])"

$a = @{}
MY_LOG "$(__LINE__)`: a($(typeof $a)) Length=$($a.Length)"
MY_LOG "$(__LINE__)`: typeof($a) -eq [hashtable]`: $((typeof($a)) -eq [hashtable])"

$a = {}
MY_LOG "$(__LINE__)`: `$a is ($(typeof $a))"
MY_LOG "$(__LINE__)`: typeof($a) -eq [scriptblock]`: $((typeof $a) -eq [scriptblock])"

#------------------------------------------ static data type
MY_LOG "$(__LINE__)`: [System.Boolean]  -eq [bool]`:    $([System.Boolean]  -eq [bool])"
MY_LOG "$(__LINE__)`: [System.Enum]     -eq [enum]`:    $([System.Enum]     -eq [enum])"

MY_LOG "$(__LINE__)`: [System.Int16]    -eq [int16]`:   $([System.Int16]    -eq [int16])"
MY_LOG "$(__LINE__)`: [System.Int32]    -eq [int]`:     $([System.Int32]    -eq [int])"
MY_LOG "$(__LINE__)`: [System.Int32]    -eq [int32]`:   $([System.Int32]    -eq [int32])"
MY_LOG "$(__LINE__)`: [System.Int64]    -eq [int64]`:   $([System.Int64]    -eq [int64])"

MY_LOG "$(__LINE__)`: [System.UInt16]   -eq [uint16]`:  $([System.UInt16]   -eq [uint16])"
MY_LOG "$(__LINE__)`: [System.UInt32]   -eq [uint32]`:  $([System.UInt32]   -eq [uint32])"
MY_LOG "$(__LINE__)`: [System.UInt64]   -eq [uint64]`:  $([System.UInt64]   -eq [uint64])"

MY_LOG "$(__LINE__)`: [System.Char]     -eq [char]`:    $([System.Char]     -eq [char])"
MY_LOG "$(__LINE__)`: [System.Byte]     -eq [byte]`:    $([System.Byte]     -eq [byte])"
MY_LOG "$(__LINE__)`: [System.SByte]    -eq [sbyte]`:   $([System.SByte]    -eq [sbyte])"

MY_LOG "$(__LINE__)`: [System.Single]   -eq [float]`:   $([System.Single]   -eq [float])"
MY_LOG "$(__LINE__)`: [System.Single]   -eq [single]`:  $([System.Single]   -eq [single])"
MY_LOG "$(__LINE__)`: [System.Double]   -eq [double]`:  $([System.Double]   -eq [double])"

MY_LOG "$(__LINE__)`: [System.String]   -eq [string]`:  $([System.String]   -eq [string])"
MY_LOG "$(__LINE__)`: [System.Object]   -eq [object]`:  $([System.Object]   -eq [object])"

MY_LOG "$(__LINE__)`: [System.Object[]] -eq [object[]]`:$([System.Object[]] -eq [object[]])"
MY_LOG "$(__LINE__)`: [System.String[]] -eq [string[]]`:$([System.String[]] -eq [string[]])"
MY_LOG "$(__LINE__)`: [System.Int32[]]  -eq [int[]]`:   $([System.Int32[]]  -eq [int[]])"

MY_LOG "$(__LINE__)`: [System.Collections.HashTable] -eq [hashtable]`: $([System.Collections.HashTable]  -eq [hashtable])"

[int]$num = 10
MY_LOG "$(__LINE__)` $num($(typeof $num))"
#$num = 10.123 error
#$num = $null error

[string]$str = "sssssssss"
MY_LOG "$(__LINE__)`: $str($(typeof $str))"

$str = 10
MY_LOG "$(__LINE__)`: $str($(typeof $str))"

$str = 10.123
MY_LOG "$(__LINE__)`: $str($(typeof $str))"

$str = $null
MY_LOG "$(__LINE__)`: $str($(typeof $str))"

$str = $false
MY_LOG "$(__LINE__)`: $str($(typeof $str))"

$str = "111","`t222",10,$true
MY_LOG "$(__LINE__)`: $str($(typeof $str))"

$str = {}
MY_LOG "$(__LINE__)`: $str($(typeof $str))"

$str = @()
MY_LOG "$(__LINE__)`: $str($(typeof $str))"

[datetime] $a = "09/12/2023"
#MY_LOG $a
MY_LOG "$(__LINE__)`: $(typeof $a)"
MY_LOG "$(__LINE__)`: $a"
MY_LOG "$(__LINE__)`: $($a.DateTime)"

$a = "09/12/2023 21:30:00"
MY_LOG "$(__LINE__)`: $($a.DateTime)"

$a = "09/22"
MY_LOG "$(__LINE__)`: $($a.DateTime)"

enum MyMediaType {
    unknown
    music   = 10
    mp3
    aac
    ogg     = 15
    oga     = 15
    mogg    = 15
    picture = 20
    jpg
    jpeg    = 21
    png
    video   = 40
    mpg
    mpeg    = 41
    avi
    m4v
}
#[MyMediaType].GetEnumNames()
#[MyMediaType].GetEnumValues()
#[MyMediaType].GetEnumName(15)
MY_LOG "$(__LINE__)`: $([MyMediaType]::png) $([MyMediaType]::png -eq 22)"

[MyMediaType].GetEnumNames() | ForEach-Object {
    [pscustomobject] @{
        Name  = $_
        Value = [int]([MyMediaType]::$_)
    }
}