@ECHO OFF
title CyberPatriot
REM Check Windows version before running the script as it uses specific stuff not found in older version.
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
REM Inform the user that they are on an unsupported version.
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
REM Check for administrator privileges. Some commands will not work properly without this.
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
ECHO  [*] You are able to connect to CyberPatriot and Google.
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
REM Main interactive menu.
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
REM Search the C: drive for all .mp2 files.
DEL /s /q /f C:\*.mp2
REM Search the C: drive for all .mp3 files.
del /s /q /f C:\*.mp3
ECHO.
ECHO All prohibited media files has been deleted.
PAUSE
GOTO MENU

:firewall
CLS
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO Adding rules to the firewall...
REM Disable all Remote Assistance ports and inform the user when the rule has been updated.
netsh advfirewall firewall set rule name="Remote Assistance (DCOM-In)" new enable=no >NUL && ECHO [1/x] Updated rule: Remote Assistance (DCOM-In)
netsh advfirewall firewall set rule name="Remote Assistance (PNRP-In)" new enable=no >NUL && ECHO [2/x] Updated rule: Remote Assistance (PNRP-In)
netsh advfirewall firewall set rule name="Remote Assistance (RA Server TCP-In)" new enable=no >NUL && ECHO [3/x] Updated rule: Remote Assistance (RA Server TCP-In)
netsh advfirewall firewall set rule name="Remote Assistance (SSDP TCP-In)" new enable=no >NUL && ECHO [4/x] Updated rule: Remote Assistance (SSDP TCP-In)
netsh advfirewall firewall set rule name="Remote Assistance (SSDP UDP-In)" new enable=no >NUL  && ECHO [5/x] Updated rule: Remote Assistance (RA Server TCP-In)
netsh advfirewall firewall set rule name="Remote Assistance (TCP-In)" new enable=no >NUL && ECHO [6/x] Updated rule: Remote Assistance (TCP-In)
ECHO.
PAUSE
GOTO MENU

:passwordpolicy
CLS
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO Setting password policy...
ECHO.
REM Set minimum password length to ten characters.
NET accounts /minpwlen:10 && ECHO [1/x] Updated minimum password length rule.
REM Force password to be changed every thirty days.
NET accounts /maxpwage:30 && ECHO [2/x] Updated maximum password age rule.
REM Make it so that five days has to pass in order to change the password.
NET accounts /minpwage:5 && ECHO [3/x] Updated minimum days required to change password rule.

:weakservices
CLS
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO Disabling weak services...
REM Disable IIS web server services.
dism /online /disable-feature /featurename:IIS-WebServerRole >NUL
dism /online /disable-feature /featurename:IIS-WebServer >NUL
dism /online /disable-feature /featurename:IIS-CommonHttpFeatures >NUL
dism /online /disable-feature /featurename:IIS-HttpErrors >NUL
dism /online /disable-feature /featurename:IIS-HttpRedirect >NUL
dism /online /disable-feature /featurename:IIS-ApplicationDevelopment >NUL
dism /online /disable-feature /featurename:IIS-NetFxExtensibility >NUL
dism /online /disable-feature /featurename:IIS-NetFxExtensibility45 >NUL
dism /online /disable-feature /featurename:IIS-HealthAndDiagnostics >NUL
dism /online /disable-feature /featurename:IIS-HttpLogging >NUL
dism /online /disable-feature /featurename:IIS-LoggingLibraries >NUL
dism /online /disable-feature /featurename:IIS-RequestMonitor >NUL
dism /online /disable-feature /featurename:IIS-HttpTracing >NUL
dism /online /disable-feature /featurename:IIS-Security >NUL
dism /online /disable-feature /featurename:IIS-URLAuthorization >NUL
dism /online /disable-feature /featurename:IIS-RequestFiltering >NUL
dism /online /disable-feature /featurename:IIS-IPSecurity >NUL
dism /online /disable-feature /featurename:IIS-Performance >NUL
dism /online /disable-feature /featurename:IIS-HttpCompressionDynamic >NUL
dism /online /disable-feature /featurename:IIS-WebServerManagementTools >NUL
dism /online /disable-feature /featurename:IIS-ManagementScriptingTools >NUL
dism /online /disable-feature /featurename:IIS-IIS6ManagementCompatibility >NUL
dism /online /disable-feature /featurename:IIS-Metabase >NUL
dism /online /disable-feature /featurename:IIS-HostableWebCore >NUL
dism /online /disable-feature /featurename:IIS-StaticContent >NUL
dism /online /disable-feature /featurename:IIS-DefaultDocument >NUL
dism /online /disable-feature /featurename:IIS-DirectoryBrowsing >NUL
dism /online /disable-feature /featurename:IIS-WebDAV >NUL
dism /online /disable-feature /featurename:IIS-WebSockets >NUL
dism /online /disable-feature /featurename:IIS-ApplicationInit >NUL
dism /online /disable-feature /featurename:IIS-ASPNET >NUL
dism /online /disable-feature /featurename:IIS-ASPNET45 >NUL
dism /online /disable-feature /featurename:IIS-ASP >NUL
dism /online /disable-feature /featurename:IIS-CGI >NUL
dism /online /disable-feature /featurename:IIS-ISAPIExtensions >NUL
dism /online /disable-feature /featurename:IIS-ISAPIFilter >NUL
dism /online /disable-feature /featurename:IIS-ServerSideIncludes >NUL
dism /online /disable-feature /featurename:IIS-CustomLogging >NUL
dism /online /disable-feature /featurename:IIS-BasicAuthentication >NUL
dism /online /disable-feature /featurename:IIS-HttpCompressionStatic >NUL
dism /online /disable-feature /featurename:IIS-ManagementConsole >NUL
dism /online /disable-feature /featurename:IIS-ManagementService >NUL
dism /online /disable-feature /featurename:IIS-WMICompatibility >NUL
dism /online /disable-feature /featurename:IIS-LegacyScripts >NUL
dism /online /disable-feature /featurename:IIS-LegacySnapIn >NUL
REM Disable FTP server services.
dism /online /disable-feature /featurename:IIS-FTPServer >NUL
dism /online /disable-feature /featurename:IIS-FTPSvc >NUL
dism /online /disable-feature /featurename:IIS-FTPExtensibility >NUL
dism /online /disable-feature /featurename:TFTP >NUL
dism /online /disable-feature /featurename:TelnetClient >NUL
dism /online /disable-feature /featurename:TelnetServer >NUL
PAUSE
GOTO menu

:presemiautomation
REM Confirm that the user wants to go with semi-automation.
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
REM Open simplified.bat in a new window and display this screen until the simplified window finish.
CLS
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO Starting semi-automation...
PAUSE
