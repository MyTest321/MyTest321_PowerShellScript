cd $PSScriptRoot
    . .\..\my_common.ps1
cd $PSScriptRoot

$ErrorActionPreference  = "Stop" # "Continue"
$WarningPreference      = "Continue" # "Stop"

function for_loop {
    for ($i = 0; $i -lt 5; ++$i) {
        MY_LOG "$($MyInvocation.MyCommand.Name) $(__LINE__)`: $i"
    }
}

function while_loop {
    $i = 0
    $N = 5
    while ($i -le $N) {
        MY_LOG "$($MyInvocation.MyCommand.Name) $(__LINE__)`: $i"
        $i ++
    }
}

function do_while_loop {
    $i = 0
    $N = 5
    do { # will do 1, then check condition
        MY_LOG "$($MyInvocation.MyCommand.Name) $(__LINE__)`: $i"
        $i ++
    } while($i -lt $N) # when $i < $N is true then loop continue
}

for_loop
while_loop
do_while_loop