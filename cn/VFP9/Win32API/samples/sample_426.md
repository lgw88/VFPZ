[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 如何以其他用户的身份启动进程(NT/XP/2K)
_翻译：xinjie  2020.12.31_

## 开始之前：
下面的代码提供了解决方法，它类似于**微软知识库文章 - 285879:** [HOWTO：从Visual Basic中以另一个用户的身份启动一个进程](https://support.microsoft.com/zh-CN/topic/how-to-start-a-process-as-another-user-from-visual-basic-b4cc65ff-79fc-e2e3-6e3c-8b174e377ccc?ui=en-us&rs=en-us&ad=us).  

您可能感兴趣的其他代码样本：  
* [在 VFP 中使用 WinExec 启动外部应用程序](sample_002.md)  
* [使用 ShellExecute 对文件进行操作](sample_093.md)  
* [通过使用 CreateProcess 从 VFP 应用程序启动可执行文件](sample_003.md)  
* [从 VFP 启动外部程序并等待其终止](sample_377.md)  
* [以子进程的形式运行 MSDOS Shell，并重定向输入和输出](sample_477.md)  

  
***  


## 代码：
```foxpro  
LOCAL cDomain, cUsr, cPwd, cApp, cCmd, cDir
cDomain = ""
cUsr = "Anyuser"
cPwd = "anypwd"
cApp = "c:\windows\notepad.exe"
cCmd = "aaa.txt"
cDir = SYS(5) + SYS(2003)

DO RunAsUser WITH cDomain, cUsr, cPwd, cApp, cCmd, cDir
* 主程序结束

FUNCTION RunAsUser(cDomain, cUsr, cPwd, cApp, cCmd, cDir)
#DEFINE VER_PLATFORM_WIN32s         0
#DEFINE VER_PLATFORM_WIN32_NT       2
#DEFINE VER_PLATFORM_WIN32_WINDOWS  1

	LOCAL nMajor, nPlatform
	= GetVersion(@nMajor, @nPlatform)

	DO CASE
	CASE nPlatform <> VER_PLATFORM_WIN32_NT
		= MESSAGEBOX("此版本的Windows不支持请求的功能。   ", 64, "RunAsUser")
		RETURN
	CASE nMajor >= 5
		RunAsUserW2K(cDomain, cUsr, cPwd, cApp, cCmd, cDir)
	OTHERWISE
		RunAsUserNT(cDomain, cUsr, cPwd, cApp, cCmd, cDir)
	ENDCASE
	
PROCEDURE RunAsUserW2K(cDomain, cUsr, cPwd, cApp, cCmd, cDir)
#DEFINE LOGON_WITH_PROFILE         1
#DEFINE CREATE_DEFAULT_ERROR_MODE  0x04000000
#DEFINE START_INFO_SIZE 68
#DEFINE PROC_INFO_SIZE  16
	DECLARE INTEGER GetLastError IN kernel32
	DECLARE INTEGER CloseHandle IN kernel32 INTEGER hObject

	DECLARE INTEGER CreateProcessWithLogonW IN Advapi32;
		STRING lpUsername, STRING lpDomain, STRING lpPassword,;
		INTEGER dwLogonFlags, STRING lpAppName, STRING lpCmdLine,;
		INTEGER dwCreationFlags, INTEGER lpEnvir, STRING lpCurDir,;
		STRING @lpStartupInfo, STRING @lpProcessInfo

	LOCAL cProcInfo, cStartInfo, nResult, hProcess, hThread
	cProcInfo = REPLICATE(CHR(0), PROC_INFO_SIZE)
	cStartInfo = PADR(CHR(START_INFO_SIZE), START_INFO_SIZE, CHR(0))
	cDomain = ConvStr(cDomain)
	cUsr = ConvStr(cUsr)
	cPwd = ConvStr(cPwd)
	cApp = ConvStr(cApp)
	cCmd = ConvStr(" " + ALLTRIM(cCmd))  && 前导空格
	cDir = ConvStr(cDir)

	nResult = CreateProcessWithLogonW(cUsr, cDomain, cPwd,;
		LOGON_WITH_PROFILE, cApp, cCmd, CREATE_DEFAULT_ERROR_MODE,;
		0, cDir, @cStartInfo, @cProcInfo)

	IF nResult = 0
	*    3 = ERROR_PATH_NOT_FOUND
	*  267 = ERROR_DIRECTORY
	* 1326 = ERROR_LOGON_FAILURE
		? "错误代码：", GetLastError()
		RETURN .F.
	ELSE
		hProcess = buf2dword(SUBSTR(cProcInfo, 1,4))
		hThread = buf2dword(SUBSTR(cProcInfo, 5,4))
		= CloseHandle(hThread)
		= CloseHandle(hProcess)
	ENDIF

PROCEDURE RunAsUserNT(cDomain, cUsr, cPwd, cApp, cCmd, cDir)
#DEFINE LOGON32_LOGON_INTERACTIVE  2
#DEFINE LOGON32_PROVIDER_DEFAULT   0
#DEFINE CREATE_DEFAULT_ERROR_MODE  0x04000000
#DEFINE CREATE_NEW_CONSOLE         0x10
#DEFINE CREATE_NEW_PROCESS_GROUP   0x0200
#DEFINE NORMAL_PRIORITY_CLASS      0x20
#DEFINE STARTF_USESHOWWINDOW       1
#DEFINE SW_SHOWNORMAL    1
#DEFINE SW_SHOWMAXIMIZED 3

	DECLARE INTEGER GetLastError IN kernel32
	DECLARE INTEGER CloseHandle IN kernel32 INTEGER hObject

	DECLARE INTEGER LogonUser IN advapi32;
		STRING lpszUsername, STRING lpszDomain, STRING lpszPassword,;
		INTEGER dwLogonType, INTEGER dwLogonProvider, INTEGER @phToken

	DECLARE INTEGER CreateProcessAsUser IN advapi32;
		INTEGER hToken, STRING lpApplicationName, STRING lpCommandLine,;
		INTEGER lpProcessAttributes, INTEGER lpThreadAttributes,;
		INTEGER bInheritHandles, INTEGER dwCreationFlags,;
		INTEGER lpEnvironment, STRING lpCurrentDirectory,;
		STRING @lpStartupInfo, STRING @lpProcessInformation

	LOCAL nToken, cProcInfo, cStartInfo, nCreationFlags
	nToken = 0
	= LogonUser(cUsr, cDomain, cPwd,;
		LOGON32_LOGON_INTERACTIVE, LOGON32_PROVIDER_DEFAULT, @nToken)

	IF nToken = 0
	* 1326 = ERROR_LOGON_FAILURE
	* 1327 = ERROR_NO_SUCH_MEMBER
	* 1385 = ERROR_LOGON_TYPE_NOT_GRANTED
		? "错误：", GetLastError()
		RETURN .F.
	ENDIF

	cProcInfo = REPLICATE(CHR(0), 16)
	cStartInfo = num2dword(68) +;
		num2dword(0) +;
		num2dword(0) +;
		num2dword(0) +;
		num2dword(0) +;
		num2dword(0) +;
		num2dword(0) +;
		num2dword(0) +;
		num2dword(0) +;
		num2dword(0) +;
		num2dword(0) +;
		num2dword(STARTF_USESHOWWINDOW) +;
		num2dword(SW_SHOWNORMAL) +;
		num2dword(0) +;
		num2dword(0) +;
		num2dword(0) +;
		num2dword(0)

	nCreationFlags = NORMAL_PRIORITY_CLASS + CREATE_DEFAULT_ERROR_MODE +;
		CREATE_NEW_CONSOLE+CREATE_NEW_PROCESS_GROUP

	IF CreateProcessAsUser(nToken, cApp, " " + ALLTRIM(cCmd),;
		0,0,0, nCreationFlags,0, cDir, @cStartInfo, @cProcInfo) = 0
		* 1314 = ERROR_PRIVILEGE_NOT_HELD
		? "错误：", GetLastError()
		= CloseHandle(nToken)
		RETURN .F.
	ENDIF

	hProcess = buf2dword(SUBSTR(cProcInfo, 1,4))
	hThread = buf2dword(SUBSTR(cProcInfo, 5,4))
	= CloseHandle(hThread)
	= CloseHandle(hProcess)
	= CloseHandle(nToken)

FUNCTION ConvStr(cStr)
#DEFINE STRCONV_UNICODE  5
RETURN STRCONV(cStr+CHR(0), STRCONV_UNICODE)

FUNCTION GetVersion(nMajor, nPlatform)
	DECLARE INTEGER GetVersionEx IN kernel32 STRING @lpVersionInfo
	LOCAL cBuffer
	cBuffer = PADR(Chr(156), 512, CHR(0))
	= GetVersionEx(@cBuffer)
	nMajor = buf2dword(SUBSTR(cBuffer, 5,4))
	nPlatform = buf2dword(SUBSTR(cBuffer, 17,4))

FUNCTION buf2dword(lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
	BitLShift(Asc(SUBSTR(lcBuffer, 2,1)),  8) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 3,1)), 16) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 4,1)), 24)

FUNCTION num2dword(lnValue)
#DEFINE m0  256
#DEFINE m1  65536
#DEFINE m2  16777216
	IF lnValue < 0
		lnValue = 0x100000000 + lnValue
	ENDIF
	LOCAL b0, b1, b2, b3
	b3 = Int(lnValue/m2)
	b2 = Int((lnValue - b3*m2)/m1)
	b1 = Int((lnValue - b3*m2 - b2*m1)/m0)
	b0 = Mod(lnValue, m0)
RETURN Chr(b0)+Chr(b1)+Chr(b2)+Chr(b3)  
```  
***  


## 函数列表：
[CloseHandle](../libraries/kernel32/CloseHandle.md)  
[CreateProcessAsUser](../libraries/advapi32/CreateProcessAsUser.md)  
[CreateProcessWithLogonW](../libraries/advapi32/CreateProcessWithLogonW.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[GetVersionEx](../libraries/kernel32/GetVersionEx.md)  
[LogonUser](../libraries/advapi32/LogonUser.md)  

## 备注：
要以另一个用户的身份启动进程，可以在运行Microsoft Windows NT 4.0时使用LogonUser和CreateProcessAsUser Win32 API，或者在运行Microsoft Windows 2000/XP或更高版本时使用CreateProcessWithLogonW Win32 API。  
  
***  

