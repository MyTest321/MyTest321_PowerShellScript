@REM #change current directory to this file
@%~d0
@cd %~dp0

@REM calling PowerShell as a administrator
powershell.exe -ExecutionPolicy Bypass -Command "& './my_make.ps1'"

@pause