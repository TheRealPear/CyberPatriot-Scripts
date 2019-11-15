@ECHO OFF
title CyberPatriot (Simplified)
ECHO CyberPatriot Simplified Script...
ECHO.
REM Set password policy.
NET accounts /minpwlen:10 /maxpwage:30 /minpwage:5 /lockoutthreshold:5 /UNIQUEPW:5 >NUl && ECHO Updated Password Policy.
REM Firewall rules.
NETSH advfirewall firewall set rule name="Remote Assistance (DCOM-In)" new enable=no >NUL && ECHO Updated rule: Remote Assistance (DCOM-In)
NETSH advfirewall firewall set rule name="Remote Assistance (PNRP-In)" new enable=no >NUL && ECHO Updated rule: Remote Assistance (PNRP-In)
NETSH advfirewall firewall set rule name="Remote Assistance (RA Server TCP-In)" new enable=no >NUL && ECHO Updated rule: Remote Assistance (RA Server TCP-In)
NETSH advfirewall firewall set rule name="Remote Assistance (SSDP TCP-In)" new enable=no >NUL && ECHO Updated rule: Remote Assistance (SSDP TCP-In)
NETSH advfirewall firewall set rule name="Remote Assistance (SSDP UDP-In)" new enable=no >NUL  && ECHO Updated rule: Remote Assistance (RA Server TCP-In)
NETSH advfirewall firewall set rule name="Remote Assistance (TCP-In)" new enable=no >NUL && ECHO Updated rule: Remote Assistance (TCP-In)
REM Enable automatic Windows Update.
REG add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 3 /f >NUL 
REM Disable Remote Desktop.
REG add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f >NUL && ECHO Updated registry key: fDenyTSConnections.
REG add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f >NUL && ECHO Updated registry key: UserAuthentication.
REM Enable Windows SmartScreen.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 1 /f >NUL && ECHO Updated registry key: EnabledSmartScreen. (Enable SmartScreen)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "ShellSmartScreenLevel" /t REG_SZ /d "Warn" /f >NUL && ECHO Updated registry key: ShellSmartScreenLevel.
REM Delete prohibited media files.
del /s /q /f C:\*.mp3 && ECHO Searched and deleted all .mp3 files.
ECHO.
ECHO Operation completed.
PAUSE