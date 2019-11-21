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
IF %ERRORLEVEL% == 0 (
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
ECHO  [E] Extra Windows Settings
ECHO  [F] Windows Defender
ECHO  [G] Disable Admin and Guest Account
ECHO  [H] Set Password Security Policy
ECHO  [I] Disable Weak Services/Features
ECHO  [J] Disable Remote Desktop
ECHO.
SET /P M=Type any [#] and then press [ENTER]: 
 IF /I %M%==A GOTO presemiautomation
 IF /I %M%==B GOTO mediafiles
 IF /I %M%==C GOTO firewall
 IF /I %M%==D GOTO windowsupdate
 IF /I %M%==E GOTO extrawindowssetting
 IF /I %M%==F GOTO windowsdefender
 IF /I %M%==G GOTO adminguestaccounts
 IF /I %M%==H GOTO passwordpolicy
 IF /I %M%==I GOTO weakservices
 IF /I %M%==J GOTO disableremotedesktop

:mediafiles
CLS
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO Deleting prohibited media files. This may take a while...
ECHO.
REM Search the C: drive for all .mp2 files.
DEL /s /q /f C:\*.mp2 && ECHO [1/x] Searched and deleted all .mp2 files.
REM Search the C: drive for all .mp3 files.
del /s /q /f C:\*.mp3 && ECHO [2/x] Searched and deleted all .mp3 files.
ECHO.
ECHO All prohibited media files has been deleted.
PAUSE
GOTO menu

:firewall
CLS
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO Adding rules to the firewall...
ECHO.
REM Disable all Remote Assistance ports and inform the user when the rule has been updated.
REM Untick the Remote Assistance option, even though this is not a firewall rule.
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f >NUL && ECHO [1/x]
NETSH advfirewall firewall set rule group="Remote Assistance" new enable=no >NUL && ECHO [2/x] Updated rule: Remote Assistance.
NETSH advfirewall firewall set rule name="Remote Assistance (DCOM-In)" new enable=no >NUL && ECHO [3/x] Updated rule: Remote Assistance (DCOM-In).
NETSH advfirewall firewall set rule name="Remote Assistance (PNRP-In)" new enable=no >NUL && ECHO [4/x] Updated rule: Remote Assistance (PNRP-In).
NETSH advfirewall firewall set rule name="Remote Assistance (RA Server TCP-In)" new enable=no >NUL && ECHO [5/x] Updated rule: Remote Assistance (RA Server TCP-In).
NETSH advfirewall firewall set rule name="Remote Assistance (SSDP TCP-In)" new enable=no >NUL && ECHO [6/x] Updated rule: Remote Assistance (SSDP TCP-In).
NETSH advfirewall firewall set rule name="Remote Assistance (SSDP UDP-In)" new enable=no >NUL  && ECHO [7/x] Updated rule: Remote Assistance (RA Server TCP-In).
NETSH advfirewall firewall set rule name="Remote Assistance (TCP-In)" new enable=no >NUL && ECHO [8/x] Updated rule: Remote Assistance (TCP-In).
ECHO.
PAUSE
GOTO menu

:windowsupdate
CLS
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO Configuring Windows Update...
ECHO.
REM Enable automatic Windows Update.
REG add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 3 /f >NUL && ECHO [1/x] Updated registry key: AUOptions (Enabled automatic Windows update).
ECHO.
REM Check if Windows Update service is running.
FOR /F "tokens=3 delims=: " %%H in ('sc query "wuauserv" ^| findstr "        STATE"') do (
  if /I "%%H" NEQ "RUNNING" (
   REM Attempt to start Windows Update here.
   ECHO [*] Windows Update service not running; starting it now...
   NET start "wuauserv" >NUL && ECHO [2/x] Successfully started Windows Update service (wuauserv).
  )
)
PAUSE
GOTO menu

:extrawindowssetting
CLS
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO Setting extra Windows settings...
ECHO.
REM Setup Windows audit policy.
AUDITPOL /set /category:* /success:enable >NUL && ECHO [2/x] Updated audit policy, now logging successful incidents.
AUDITPOL /set /category:* /failure:enable >NUL && ECHO [3/x] Updated audit policy, now logging failed incidents.
REM Enable Windows Firewall.
NETSH advfirewall set allprofiles state on >NUL && ECHO [4/x] Windows Firewall is now enabled.
REM Enable Windows SmartScreen.
REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 1 /f >NUL && ECHO [5/x] Updated registry key: EnabledSmartScreen (Enabled SmartScreen).
REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "ShellSmartScreenLevel" /t REG_SZ /d "Warn" /f >NUL && ECHO [6/x] Updated registry key: ShellSmartScreenLevel.
REM Enable Windows Defender.
REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 0 /f >NUL && ECHO [7/x] Updated registry key: DisableAntiSpyware (Enabled AntiSpyware).
REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d 1 /f >NUL && ECHO [8/x] Updated registry key: ServiceKeepAlive.
REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 0 /f >NUL && ECHO [9/x] Updated registry key: DisableIOAVProtection (Enabled IOAVProtection).
REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 0 /f >NUL && ECHO [10/x] Updated registry key: DisableRealtimeMonitoring (Enabled RealtimeMonitoring).
REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "CheckForSignaturesBeforeRunningScan" /t REG_DWORD /d 1 /f >NUL && ECHO [11/x] Updated registry key: CheckForSignaturesBeforeRunningScan.
REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableHeuristics" /t REG_DWORD /d 0 /f >NUL && ECHO [12/x] Updated registry key: DisableHeuristics (Enabled Heuristics).
REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "ScanWithAntiVirus" /t REG_DWORD /d 3 /f >NUL && ECHO [13/x] Updated registry key: ScanWithAntiVirus.
REM Show file extensions.
REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\HideFileExt" /v "CheckedValue" /t REG_DWORD /d 0 /f >NUL && ECHO [14/x] Updated registry key: CheckedValue.
REG add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >NUL && ECHO [15/x] Updated registry key: HideFileExt (Show file extensions).
REM Harden Internet Explorer security. Also enables HTTP/2.0.
REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /v "DEPOff" /t REG_DWORD /d 0 /f >NUL && ECHO [16/x] Updated registry key: DEPOff (Securing Internet Explorer).
REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /v "Isolation64Bit" /t REG_DWORD /d 1 /f >NUL && ECHO [17/x] Updated registry key: Isolation64Bit.
REG add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d 1 /f >NUL && ECHO [18/x] Updated registry key: EnabledV9.
REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d 1 /f >NUL && ECHO [19/x] Updated registry key: EnabledV9 (part 2).
REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /v "EnableHTTP2" /t REG_DWORD /d 1 /f >NUL && ECHO [20/x] Updated registry key: EnableHTTP2.
PAUSE
GOTO menu

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
NET accounts /minpwlen:10 >NUL && ECHO [1/5] Updated minimum password length rule.
REM Force password to be changed every thirty days.
NET accounts /maxpwage:30 >NUL && ECHO [2/5] Updated maximum password age rule.
REM Make it so that five days has to pass in order to change the password.
NET accounts /minpwage:5 >NUL && ECHO [3/5] Updated minimum password age rule.
REM Set maximum amount of failed sign-in attempts before locking the account.
NET accounts /lockoutthreshold:5 >NUL && ECHO [4/5] Updated lockout threshold rule.
REM Set the amount of previous passwored remembered so that users can't reuse the same passwords.
NET accounts /UNIQUEPW:5 >NUL && ECHO [5/5] Updated unique password history rule.
ECHO.
ECHO Be sure to open Local Security Policy and set the following rules to:
ECHO  [*] Password must met complexity requirements = Enabled
ECHO  [*] Store passwords using reversible encryption = Disabled
ECHO (Due to technical limitations, it has to be done manually.)
ECHO.
PAUSE
GOTO menu

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

:disableremotedesktop
CLS
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO Disabling Remote Desktop...
REM Disable Remote Desktop.
REG add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f >NUL && ECHO [1/x] Updated registry key: fDenyTSConnections (Disabled Remote Desktop).
REG add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f >NUL && ECHO [2/x] Updated registry key: UserAuthentication.
SC stop "TermService" & SC config "TermService" start= disabled
SC stop "SessionEnv" & SC config "SessionEnv" start= disabled
ECHO.
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
 IF /I %M%==Y GOTO semiautomation
 IF /I %M%==N GOTO menu

:semiautomation
REM Open simplified.bat in a new window and display this screen until the simplified window finish.
CLS
ECHO.
ECHO -----------------
ECHO   CyberPatriot
ECHO -----------------
ECHO.
ECHO For now, open simplified.bat from the File Explorer.
PAUSE
GOTO menu
