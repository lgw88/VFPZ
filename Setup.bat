@Echo on
Echo Setup VFP9...
if not exist "%~dp0vfp9.exe" %~dp07z x %~dp0VFPInstallers\VFP90SP2-KB968409-ENU.EXE -y vfp9.exe
if exist %windir%\SysWOW64 (
set Sysdir=%windir%\SysWOW64\
) else (
set Sysdir=%windir%\System32\
)
Echo %sysdir%
if not exist "%Sysdir%msvcr70.dll" copy "%~dp0DLL\msvcr70.dll" "%Sysdir%"
if not exist "%Sysdir%msvcr71.dll" copy "%~dp0DLL\msvcr71.dll" "%Sysdir%"

"%~dp0vfp9.exe" -regserver
Echo Path=%~dp0Progs>%~dp0Config.fpw
pause
start /d "%~dp0" vfp9.exe
