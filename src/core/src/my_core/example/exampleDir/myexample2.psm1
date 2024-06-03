
echo "hhhhhhhhhhhhh" # when out-side Import-Module this module, this line code do not run ?

function MyTestFunc {
    Write-Verbose "The module autoloading feature was introduced in PowerShell version 3. To take advantage of module autoloading, a script module needs to be saved in a folder with the same base name as the .PSM1 file and in a location specified in"
    echo "mytest1.psm1: called MyTestFunc psm1"
}

function MyTestFunc2 {
    echo "mytest1.psm1: called MyTestFunc2"
}

<#
# default all function is publc to user
    
# If you're not following the best practices (no .psd1 file) and only have a .PSM1 file, then your only option is to use the Export-ModuleMember cmdlet.
# explict the public function to user, MyTestFunc2 will be private. or you can use New-ModuleManifest as config
Export-ModuleMember -Function MyTestFunc
#>
