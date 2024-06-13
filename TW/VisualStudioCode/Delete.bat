@Echo off
if exist "%USERPROFILE%\AppData\Local\Programs\Microsoft VS Code\resources\app\extensions\prg" (
	del /F /S /Q "%USERPROFILE%\AppData\Local\Programs\Microsoft VS Code\resources\app\extensions\prg\*.*"
	rd     /S /Q "%USERPROFILE%\AppData\Local\Programs\Microsoft VS Code\resources\app\extensions\prg"
)
pause
