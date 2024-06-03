$ErrorActionPreference  = "Stop"
$WarningPreference      = "Stop"

# console code page use utf8
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$FormatEnumerationLimit = -1

function my_typedef {
    param (
        [ValidateNotNullOrEmpty()]
        $alias_key,
        $alias_value
    )
    Set-Alias -Scope global -Name $alias_key -Value $alias_value
}

#-------------------------------------
# show current OS encoding
# [System.Text.Encoding]::Default
#-------------------------------------

function __FILE__ {
    $MyInvocation.ScriptName
}

function __LINE__ {
    $MyInvocation.ScriptLineNumber
}

function __FUNC__ {
    $MyInvocation.MyCommand.Name # $MyInvocation.InvocationName
}

function typeof {
    param ($arg0)
    if ($null -eq $arg0) {
        return $null
    }
    return $arg0.GetType()
}

function my_is_null {
    param ($arg0)
    return $null -eq ($arg0)
}

function my_load_dll {
<#
.EXAMPLE
    my_load_dll "C:\path-to\my\assembly.dll"
#>
    param (
        [string]
        $dllFilePath
    )
    [System.Reflection.Assembly]::LoadFrom($dllFilePath)
}

function MY_LOG {
    Param (
        [string[]]
        $arg1,

        [string[]]
        $arg2,

        [string[]]
        $arg3,

        [string[]]
        $arg4
    )
    $sb = [System.Text.StringBuilder]::new()

    if ($null -ne $arg1) {
        [void]$sb.Append( $($arg1 -join ", ") )
    }
    if ($null -ne $arg2) {
        if ($sb.Length -gt 0) { [void]$sb.Append(" ") }
        [void]$sb.Append( $($arg2 -join ", ") )
    }
    if ($null -ne $arg3) {
        if ($sb.Length -gt 0) { [void]$sb.Append(" ") }
        [void]$sb.Append( $($arg3 -join ", ") )
    }
    if ($null -ne $arg4) {
        if ($sb.Length -gt 0) { [void]$sb.Append(" ") }
        [void]$sb.Append( $($arg4 -join ", ") )
    }
    echo $sb.ToString()

    #Invoke-Command @parameters
    # icm -ScriptBlock @parameters
}

my_typedef MY_LOG_WARN    Write-Warning
my_typedef MY_LOG_ERROR   Write-Error
my_typedef MY_COMMENT     Write-Verbose

function my_dump_obj {
    param (
        $arg0
    )
    MY_LOG "======================== [my_dump_obj] ====================== Start"
    if ($null -eq $arg0) {
        # do nothing
	} else {
        MY_LOG $arg0 | Format-List *
    }
    MY_LOG "======================== [my_dump_obj] ====================== End"
}

function my_dump_type {
<#
.EXAMPLE
        my_dump_type [System.IO.FileAttributes]
#>
    param (
        [ValidateNotNullOrEmpty()]
        $arg0
    )
    if ($null -eq $arg0) {
        Write-Warning "[my_dump_obj] obj is null"
		return $false
	}
    $name = $arg0.GetType().fullname
    MY_LOG "======================== $name ====================== Member Start"
    MY_LOG $arg0 | Get-Member | Format-Table -AutoSize # method, Property, ParameterizedProperty
    MY_LOG "======================== $name ====================== Member End"
    MY_LOG "======================== $name ====================== Static Start"
    my_dump_type_static $arg0
    MY_LOG "======================== $name ====================== Member End"
}

function my_dump_type_prop {
    param (
        $arg0
    )
    if ($null -eq $arg0) {
        Write-Warning "[my_dump_prop] `$arg0 is null"
		return $false
	}
    MY_LOG $arg0 | Get-Member -MemberType Properties | Format-Table -AutoSize
}

function my_dump_type_method {
    param (
        $arg0
    )
    if ($null -eq $arg0) {
        Write-Warning "[my_dump_method] `$arg0 is null"
		return $false
	}
    MY_LOG $arg0 | Get-Member -MemberType Methods | Format-Table -AutoSize
}

function my_dump_type_static {
    param (
        $arg0
    )
    if ($null -eq $arg0) {
        Write-Warning "[my_dump_csharp_static] `$arg0 is null"
		return $false
	}
    MY_LOG $arg0 | Get-Member -Static | Format-Table -AutoSize
}

function my_as_file_info {
    param (
        [string]
        $abs_file_path
    )
    return $abs_file_path -as [System.IO.FileInfo]
}

function my_as_dir_info {
    param (
        [string]
        $arg0
    )
    # https://stackoverflow.com/questions/69639191/how-can-i-determine-if-a-string-is-a-correctly-formatted-path-regardless-of-whet
    return $arg0 -as [System.IO.DirectoryInfo]
}

function my_path_combine {
    param (
        [string[]]
        $paths
    )

    if ($null -eq $paths) {
        return ""
    }

    $len = $paths.Length
    if ($len -le 0) {
        return ""
    }

    $res = $paths[0]
    for ($i = 1; $i -lt $len; $i++) {
        $path = $paths[$i]
        return [System.IO.Path]::Combine($res, $path)
    }
    return $res
}

function my_get_basename {
    param (
        [string]
        $arg0
    )
    if ([string]::IsNullOrEmpty($arg0)) {
        return ""
    }
    return [System.IO.Path]::GetFileNameWithoutExtension($arg0)
}

function my_is_dir {
    param (
        [System.IO.FileSystemInfo]
        $arg0
    )
    if ($null -eq $arg0) {
		return $false
	}
    $attr_dir = [System.IO.FileAttributes]::Directory
    return ($arg0.Attributes -band $attr_dir) -eq $attr_dir
}

function my_is_file { # same as my_is_file_exists
    param (
        [string]
        $arg0
    )
    if ([string]::IsNullOrEmpty($arg0)) {
        return $false
    }
    $info = my_as_file_info $arg0
    return $info.Exists
}

function my_file_exists {
    param (
        [string]
        $arg0
    )
    return my_is_file $arg0
}

function my_dir_exists {
    param (
        [string]
        $arg0
    )
    if ([string]::IsNullOrEmpty($arg0)) {
        return $false
    }
    $info = my_as_dir_info($arg0)
    return $info.Exists
}

function my_copy_file {
    param (
        [ValidateNotNullOrEmpty()]
        [string]
        $src_file_path,

        [ValidateNotNullOrEmpty()]
        [string]
        $dst_dir_path
    )

    if ([string]::IsNullOrEmpty($src_file_path)) {
        MY_LOG_WARN "[my_copy_file_to_dir], line $(__LINE__)`: `$src_file_path is empty string"
        return
    }
    if (-not (my_file_exists $src_file_path)) {
        MY_LOG_WARN "[my_copy_file_to_dir], line $(__LINE__)`: source file not found: $src_file_path $(__LINE__)"
        return
    }
    my_create_dirs $dst_dir_path
    Copy-Item $src_file_path -Destination $dst_dir_path
}

function my_dir_name {
    param (
        [ValidateNotNullOrEmpty()]
        [string]
        $path
    )
    return [System.IO.Path]::GetDirectoryName($path)
}

function my_copy_dir {
    param (
        [ValidateNotNullOrEmpty()]
        [string]
        $src_dir_path,

        [ValidateNotNullOrEmpty()]
        [string]
        $dst_dir_path
    )

    if ([string]::IsNullOrEmpty($src_dir_path)) {
        MY_LOG_WARN "[my_copy_dir], line $(__LINE__)`: `$src_dir_path is empty string"
        return
    }

    if (-not (my_dir_exists $src_dir_path)) {
        MY_LOG_WARN "[my_copy_dir], line $(__LINE__)`: source dir not found: $src_dir_path"
        return
    }
    Copy-Item -Path $src_dir_path -Destination $dst_dir_path
}

function my_dump_hex_string {
    param (
        [string]
        $arg0,
        $encoding = "ASCII" # default is ASCII
    )

    MY_COMMENT "`$encoding = 'UTF8', 'ASCII', UTF32"

    $res = Format-Hex -InputObject $arg0 -Raw -Encoding $encoding
    my_dump_obj $res
}

function my_delete_dirs {
    param (
        [string]
        $dir_path,
        $recrusive = $true
    )
    return [System.IO.Directory]::Delete($dir_path, $recrusive)
}

function my_create_dirs_by_file_path {
    param (
        [string]
        $file_path,
        $isDeleteOld = $false
    )
    $dir_path = my_dir_name $file_path
    $is_exists = my_dir_exists $dir_path

    if ($isDeleteOld -and $is_exists) {
        my_delete_dirs $dir_path
    }
    if (-not ($is_exists)) {
        [System.IO.Directory]::CreateDirectory($dir_path)
    }
}

function my_create_dirs {
    param (
        [string]
        $dir_path,
        $isDeleteOld = $false
    )
    $is_exists = my_dir_exists $dir_path

    if ($isDeleteOld -and $is_exists) {
        my_delete_dirs $dir_path
    }
    if (-not ($is_exists)) {
        [System.IO.Directory]::CreateDirectory($dir_path)
    }
}

# public static void CreateDirectorys(string filePath, bool isDeleteOld = false)
# {
#     var dir = GetDirectoryName(filePath);
#     bool isExist = Directory.Exists(dir);
#     if (isDeleteOld)
#     if (isDeleteOld && isExist) {
#         Directory.Delete(dir, true);
#     }
#     if (!isExist) Directory.CreateDirectory(dir);
# }