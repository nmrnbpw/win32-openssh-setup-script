@ECHO OFF

SETLOCAL ENABLEDELAYEDEXPANSION
PUSHD "%~dp0"


SET BASE_DIR=%~dp0\.ssh\
SET DIR="%BASE_DIR:~0,-1%"

:: Remove Inheritance
icacls %DIR% /c /t /Inheritance:d
:: Set Ownership to Owner
icacls %DIR% /c /t /Grant "%UserName%":F
:: Remove All usres, except for Owner
icacls %DIR% /c /t /Remove Administrator "Authenticated Users" BUILTIN\Administrators BUILTIN Everyone System Users


ENDLOCAL
EXIT /B

