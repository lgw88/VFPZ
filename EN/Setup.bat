@Echo on
Echo Setup VFP9 English ...
Copy "%~dp0*.app" ..
Copy "%~dp0*.dll" ..
Copy "%~dp0*.prg" ..
Del ..\VFP9CHS.DLL
Del ..\VFP9FRA.DLL
Del ..\VFP9RUS.DLL
pause
