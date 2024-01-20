@echo off
:: BatchGotAdmin
:: Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

:: If the user has administrative privileges, run CMD as administrator
if %errorlevel% == 0 (
    goto :gotAdmin
) else (
    :: If not, relaunch as administrator
    echo Requesting administrative privileges...
    %0:gotAdminUAC%
    exit /b
)

:gotAdmin
:: Run CMD as administrator
echo Running CMD as administrator...
cd /d %~dp0
start cmd.exe /k

exit /b

:gotAdminUAC
:: Relaunch as administrator using UAC prompt
powershell.exe -Command "Start-Process '%~0' -Verb RunAs"

exit /b
