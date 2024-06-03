$ErrorActionPreference  = "Stop"
$WarningPreference      = "Stop"

$target_name = "my_core"
echo "=========== ${target_name} =========="

cd $PSScriptRoot

my_add_module -target_name $target_name -src_path $PSScriptRoot