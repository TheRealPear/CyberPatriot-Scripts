@ECHO OFF
title CyberPatriot
:admincheck
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    ECHO.
    ECHO Administrator privileges detected!
    GOTO loading
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

:loading
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
ECHO This script will cause irreversible changes to the image
ECHO that may destroy evidence to help you answer the forensic questions.
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
ECHO  [A] Automate Everything
ECHO  [B] Find Prohibited Media Files
ECHO  [C] Fix Firewall
ECHO  [D] Windows Update
ECHO  [E] Windows Defender
ECHO  [F] Disable Admin and Guest Account
ECHO  [G] Password Security Policy
ECHO  [H] Disable Weak Services/Features
ECHO.
SET /P M=Type any [#] and then press [ENTER]:
 IF %M%==A GOTO automation
 IF %M%==B GOTO mediafiles
 IF %M%==C GOTO firewall