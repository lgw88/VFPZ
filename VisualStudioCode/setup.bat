@Echo off
if not exist "%USERPROFILE%\AppData\Local\Programs\Microsoft VS Code\resources\app\extensions\prg" MD "%USERPROFILE%\AppData\Local\Programs\Microsoft VS Code\resources\app\extensions\prg"
xcopy /Q /E /Y "%~dp0prg" "%USERPROFILE%\AppData\Local\Programs\Microsoft VS Code\resources\app\extensions\prg"
pause
