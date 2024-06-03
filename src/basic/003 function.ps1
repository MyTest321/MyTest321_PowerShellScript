cd $PSScriptRoot
    . .\..\my_common.ps1
cd $PSScriptRoot

$ErrorActionPreference  = "Stop"

#region empty params func
    function my_hello_world_func {
        MY_LOG "hello_world"
    }

    my_hello_world_func
    (my_hello_world_func)
    $(my_hello_world_func)
#endregion empty params func
MY_LOG ""
MY_LOG ""
MY_LOG ""
#region empty params func and return 1 value
    function my_return_value_func {
        return 100
    }
    $res = my_return_value_func
    MY_LOG "my_return_value_func:" $res
#endregion empty params func and return 1 value
MY_LOG ""
MY_LOG ""
MY_LOG ""
#region 1 params func
    function my_1param_func {
        Param($my_arg)
        MY_LOG "`$[my_1param_func]`$my_arg=$my_arg"
    }
    my_1param_func "hello1"
    my_1param_func -my_arg "hello1"
#endregion 1 params func
MY_LOG ""
MY_LOG ""
MY_LOG ""
#region 2 params func
    function my_2param_func {
        Param($a, $b)
        MY_LOG "`$[my_2param_func]`$a=$a, `$b=$b`: $a+$b=$($a+$b)"
        return $a + $b
    }
    MY_LOG "$(my_2param_func 10 20)"
    MY_LOG "$(my_2param_func -b 30 -a 40)"
#endregion 2 params func
MY_LOG ""
MY_LOG ""
MY_LOG ""
#region params without paramname func
    function my_params_without_name_func {
        $my_arg1 = $args[0]
        $my_arg2 = $args[1]
        MY_LOG "`$[my_params_without_name_func]`$my_arg1=$my_arg1, `$my_arg2=$my_arg2"
    }
    my_params_without_name_func 10 "20"
    my_params_without_name_func $null $false
#endregion params without paramname func
MY_LOG ""
MY_LOG ""
MY_LOG ""
#region anonymous function or i want to call it function variable (not recommend practise)
    $count = 0
    $my_func_var = {
        $global:count++
        return "called my_func_var $global:count"
    }
    MY_LOG $(& $my_func_var)
    MY_LOG $my_func_var.Invoke()
#endregion anonymous function
MY_LOG ""
MY_LOG ""
MY_LOG ""
#region static type function
    function my_static_type_function {
        [OutputType([string])]
        Param(
            [string]
            $a, # default assigned ""

            [int]
            $b # default assigned 0
        )
        MY_COMMENT "when -a not assign or -a `$null: `$a == """

        MY_LOG "`$[my_parameter_validation]`$a=$a($($a.GetType())), `$b=$b($($b.GetType()))"
        return 0
    }
    my_static_type_function
    my_static_type_function -a 100
    my_static_type_function -a 12.34
    my_static_type_function -a $null # auto convert as ""
    # my_static_type_function -b "hhh" # error
    my_static_type_function -a $null -b $null
    $result = my_static_type_function
    MY_LOG "result= $result $($result.GetType())"
#endregion static type function
MY_LOG ""
MY_LOG ""
MY_LOG ""
#region parameter validation
    function my_parameter_validation {
        Param(
            [ValidateNotNullOrEmpty()]
            [string]
            $a
        )
        MY_LOG "`$[my_parameter_validation]`$a=$a($($a.GetType()))"
    }
    my_parameter_validation # but this is ok, and $a == "", i dont know why
    my_parameter_validation 12.34
    my_parameter_validation -a 100e-4
    #my_parameter_validation $null              # error
    #my_parameter_validation ""                 # error
    #my_parameter_validation $([string]::Empty) # error
#endregion parameter validation
MY_LOG ""
MY_LOG ""
MY_LOG ""
#region default value params
    function my_default_value_func {
        Param(
            [string]
            $s = "123",
            [bool]
            $b = $true,
            [int]
            $i = 100,
            [float]
            $f = 100.123,
            [double]
            $d = 100.1232342374,
            [string[]]
            $strArr = ("aaaa", 100),
            [int[]]
            $intArr = (1, 2, 3)
        )
        MY_LOG "`$[my_default_value_func]
            `$a=$s($($s.GetType()))
            `$b=$b($($b.GetType()))
            `$i=$i($($i.GetType()))
            `$f=$f($($f.GetType()))
            `$d=$d($($d.GetType()))
            `$strArr=$strArr($($strArr.GetType()))
            `$intArr=$intArr($($intArr.GetType()))
        "
    }
    my_default_value_func -i 999999 12.34
#endregion default value params
MY_LOG ""
MY_LOG ""
MY_LOG ""
#region my syntax no keyword params func
function my_no_keyword_params_func([int]$a, [int] $b) {
    return $a + $b
}
MY_LOG $(my_no_keyword_params_func 1 2)
MY_LOG $(my_no_keyword_params_func -100)
MY_LOG $(my_no_keyword_params_func -b 100)
#endregion my syntax no keyword params func
MY_LOG ""
MY_LOG ""
MY_LOG ""
#region my explicit return type func
function my_retuan_type_explicit_func {
    [OutputType([string])] # just hint the result data type, but you can return anything you like
    param(
        [string] $s1,
        [string] $s2
    )
    $s1 += $s2
    return 1
    return $s1
}
MY_LOG $(my_retuan_type_explicit_func "hel`tlo" "`nworld")
MY_LOG $(my_retuan_type_explicit_func "`the`nllo,")
MY_LOG $(my_retuan_type_explicit_func)
#endregion my explicit return type func