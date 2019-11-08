@ECHO OFF
title CyberPatriot
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
IF "%version%" == "10.0" echo Windows 10 detected! && goto admincheck
IF "%version%" == "6.3" echo Windows 8.1 detected! && goto admincheck
IF "%version%" == "6.2" echo Windows 8 detected! && goto admincheck
IF "%version%" == "6.1" echo Windows 7 detected! && goto admincheck
IF "%version%" == "6.0" echo Windows Vista detected! && goto unsupportedversion
IF "%version%" == "5.1" echo Windows XP or older detected! && goto unsupportedversion
endlocal

:unsupportedversion
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO You are running on an unsupported Windows version.
ECHO This script will only work on Windows 7 and higher.
ECHO.
PAUSE
EXIT

:admincheck
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    ECHO.
    ECHO Administrator privileges detected!
    GOTO warning
) ELSE (
    ECHO.
    ECHO -----------------
    ECHO   CyberPatriot
    ECHO -----------------
    ECHO.
    ECHO Administrator privileges not found!
    ECHO The script will not function correctly without administrator privileges.
    ECHO.
    ECHO Please re-open this script with administrator privileges.
    ECHO You can do this by right-clicking on the script and click on "Run as administrator"
    ECHO.
    PAUSE
    EXIT
)

:warning
ECHO.
ECHO ---------------------------
ECHO   Welcome to CyberPatriot
ECHO ---------------------------
ECHO.
ECHO Before using this script, be sure you have done the following:
ECHO.
ECHO  [*] Follow the CyberPatriot rules.
ECHO  [*] Use the correct image (Windows 8.1, 10, or Server 2016)
ECHO  [*] The CCS service is running.
ECHO  [*] Enter your team's unique number.
ECHO  [*] Answer the forensic questions.
ECHO.
ECHO This script will cause irreversible changes to the image that
ECHO may destroy evidence to help you answer the forensic questions.
ECHO.
PAUSE
GOTO menu

:menu
CLS
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO Please select an option below.
ECHO.
ECHO  [A] Semi-Automate Everything
ECHO  [B] Find Prohibited Media Files
ECHO  [C] Fix Firewall
ECHO  [D] Windows Update
ECHO  [E] Windows Defender
ECHO  [F] Disable Admin and Guest Account
ECHO  [G] Set Password Security Policy
ECHO  [H] Disable Weak Services/Features
ECHO.
SET /P M=Type any [#] and then press [ENTER]: 
 IF %M%==A GOTO presemiautomation
 IF %M%==B GOTO mediafiles
 IF %M%==C GOTO firewall
 IF %M%==D GOTO windowsupdate
 IF %M%==E GOTO windowsdefender
 IF %M%==F GOTO adminguestaccounts
 IF %M%==G GOTO passwordpolicy
 IF %M%==H GOTO weakservices

:mediafiles
CLS
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO Deleting prohibited media files...
ECHO.
del /s /q /f C:\*.mp3
ECHO.
ECHO All prohibited media files has been deleted.

:firewall
CLS
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO Attempting to repair Windows Firewall...
ECHO.

:presemiautomation
CLS
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO [A] Semi-Automate Everything was selected.
ECHO.
ECHO This option will do the following tasks (with the exception for destructive ones).
ECHO  [*] Fix Firewall
ECHO  [*] Enable Windows Update
ECHO  [*] Enable Windows Defender
ECHO  [*] Disable Admin and Guest Account
ECHO  [*] Set Password Security Policy
ECHO  [*] Disable Weak Services/Features
ECHO.
SET /P M=Are you sure you want to proceed? [Y/N]: 
 IF %M%==Y GOTO semiautomation
 IF %M%==N GOTO menu

:semiautomation
CLS
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO Starting semi-automation...

