cd $PSScriptRoot
    . .\..\my_common.ps1
cd $PSScriptRoot

$ErrorActionPreference  = "Stop" # "Continue"
$WarningPreference      = "Continue" # "Stop"

class SrcLoc {
    [string]    $file
    [int]       $line
    [string]    $func

    SrcLoc() {
        # empty constructor
    }

    SrcLoc([hashtable]$properties) {
        $this.Init($properties)
    }

    [void] Init([hashtable]$properties) {
        foreach ($name in $properties.Keys) {
            $this.$name = $properties.$name
        }
    }

    [string] ToString() {
        return "$($this.file): $($this.func), line: $($this.line)"
    }
}

function MY_LOC {
    return {
        param(
            [string]
            $file = $(& $global:__FILE__),

            [int]
            $line = $(& $global:__LINE__),

            [string]
            $func = $(& $global:__FUNC__)
        )
        $MyInvocation
        $res = [SrcLoc]::new(@{
            file = $file
            line = $line
            func = $func
        })
        return $res
    }
}

#---------------------------------------------------
<#
    $my_block = (MY_LOC)  # run and get script block
    $result = & $my_block # get scriptblock and & get srcloc
    MY_LOG $result
#>

<#
    $result = & $(MY_LOC) -file (& __FILE__) -line (& __LINE__) -func (& __FUNC__)
    MY_LOG $result
#>

$result = & $(MY_LOC) -file (& __FILE__) -line (& __LINE__) -func ($MyInvocation.MyCommand.Name)
MY_LOG $result

<#
    $t = "& `$(MY_LOC) -file (& __FILE__) -line (& __LINE__) -func (`$MyInvocation.MyCommand.Name)"
    Invoke-Expression $t
#>
