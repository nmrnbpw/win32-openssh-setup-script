@ECHO OFF

SETLOCAL ENABLEDELAYEDEXPANSION
PUSHD "%~dp0"


:OPENSSH
SET OPENSSH_VER=8.1.0.0p1-Beta
SET OPENSSH_URL=https://github.com/PowerShell/Win32-OpenSSH/releases/download/v%OPENSSH_VER%/OpenSSH-Win64.zip

rmdir /S /Q OpenSSH
mkdir OpenSSH
:: download
powershell Invoke-WebRequest -Uri %OPENSSH_URL% -OutFile OpenSSH-Win64.zip
:: extract
powershell Expand-Archive -Path OpenSSH-Win64.zip -DestinationPath OpenSSH -Force


:SSH_CONFIG
mkdir .ssh
SET BASE_DIR=%~dp0\.ssh\
SET DIR="%BASE_DIR:~0,-1%"

:: Remove Inheritance
icacls %DIR% /c /t /Inheritance:d
:: Set Ownership to Owner
icacls %DIR% /c /t /Grant "%UserName%":F
:: Remove All usres, except for Owner
icacls %DIR% /c /t /Remove Administrator "Authenticated Users" BUILTIN\Administrators BUILTIN Everyone System Users

:: Create directory junction
mklink /D /J "%USERPROFILE%"\.ssh %BASE_DIR%

explorer "%~dp0"

echo ********************************************************************************
echo Place an SSH configuration file (e.g. ssh_config) in the following path:
echo %USERPROFILE%\.ssh
echo ********************************************************************************


ENDLOCAL
EXIT /B

