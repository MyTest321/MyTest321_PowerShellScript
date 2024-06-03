$ErrorActionPreference  = "Continue" # "Stop"
$WarningPreference      = "Continue" # "Stop"

# single line comment
Write-Verbose "this line is also a single line comment"

<#
    multi
    line
    comment
#>

Write-Debug "my debug msg"
Write-Warning "my warning msg"
Write-Error "my error msg" # program will not stop, because $ErrorActionPreference = "Continue"

# Write-Output == write == echo
    echo "powershell log with echo"

    $hello = "Hello World"
    echo $hello
    write ${hello}
    write "write ${hello}"
    Write-Output "Write-Output $hello"

Write-Host "Write-Host: $hello" # "Write-Host" only writes on the host and does not return any value to the PowerShell engine

#   print dollar sign: https://stackoverflow.com/questions/17452401/escaping-dollar-signs-in-powershell-path-is-not-working
    echo '$hello (single quote)'
    echo "`$hello (double quote)"
    echo "`${hello}=$hello"

#   print \n \t
echo "hel`tlo`nwo`trld"
echo "" # empty line
echo "hello"    "world`t123" # multi string literal split \n

echo ( "-- " + $hello + " (concat string in single line)" )