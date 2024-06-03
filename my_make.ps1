cd $PSScriptRoot
    . .\src\my_common.ps1
cd $PSScriptRoot

$ErrorActionPreference  = "Stop"
$WarningPreference      = "Stop"

$MY_AUTHOR = "MyTest321"
$MY_MODULE_ROOT = "$PSScriptRoot\build"

function my_add_psm1 {
    param (
        [ValidateNotNullOrEmpty()]
        [string]
        $Path,

        [ValidateNotNullOrEmpty()]
        [string]
        $RootModule
    )

    MY_COMMENT "MyNew-ModuleManifest -Path $Path -RootModule $RootModule -Author $MY_AUTHOR"
    
    New-ModuleManifest -Path $Path -RootModule $RootModule -Author $MY_AUTHOR
    Test-ModuleManifest $Path
}

function my_add_module {
    param (
        [ValidateNotNullOrEmpty()]
        [string]
        $target_name,

        [ValidateNotNullOrEmpty()]
        [string]
        $src_path
    )

    foreach ($arg0 in Get-ChildItem "${src_path}/src/" -Recurse) {
        if (my_is_dir($arg0)) {
            continue
        }

        $ext = $arg0.Extension
        if ($ext -ne ".psm1") {
            continue
        }

        $module_input_psm1 = $arg0.FullName

        $module_psm1        = $arg0.Name
        $module_name        = my_get_basename $module_psm1
        $module_psd1        = "${module_name}.psd1"
        $module_root_dir    = my_path_combine($MY_MODULE_ROOT, $target_name)

        $module_output_psm1 = $module_root_dir + $module_input_psm1.Substring($src_path.Length)
        $output_psm1_fi     = my_as_file_info $module_output_psm1
        $module_output_dir  = $output_psm1_fi.DirectoryName
        $module_output_psd1 = my_path_combine($module_output_dir, $module_psd1)

        my_copy_file $module_input_psm1 $module_output_dir
        my_add_psm1 -Path $module_output_psd1 -RootModule $module_psm1
    }
}

function my_make {
    param (
        [string]
        $arg0
    )

    $make_file = "${PSScriptRoot}\${arg0}\my_make.ps1"
    $ok = my_file_exists($make_file)
    if (!$ok) {
        MY_LOG_ERROR "[my_error] file not found: $make_file"
        return
    }
    & $make_file # same as iex $make_file
}

# ------------------------
my_make ".\src\core"