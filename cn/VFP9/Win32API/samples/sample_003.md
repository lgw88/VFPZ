[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 通过使用 CreateProcess 从VFP应用程序启动可执行文件
_翻译：xinjie 2020.12.31_

## 开始之前：
您可能感兴趣的其他代码样本  
* [在 VFP 中使用 WinExec 启动外部应用程序](sample_002.md)  
* [使用 ShellExecute 对文件进行操作](sample_093.md)  
* [从 VFP 启动外部程序并等待其终止](sample_377.md)  
* [如何以其他用户的身份启动进程(NT/XP/2K)](sample_426.md)  
* [以子进程的形式运行 MSDOS Shell，并重定向输入和输出](sample_477.md)  

  
***  


## 代码：
```foxpro  
_run("c:\windows\notepad.exe", "c:\newfile.txt")
*_run("C:\WINDOWS\System32\mspaint.exe", "")
*_run("C:\Program Files\Microsoft Office\Office10\WINWORD.EXE", "")

* 主程序结束

PROCEDURE _run
LPARAMETERS cApp, cCmdLine
#DEFINE START_INFO_SIZE  68
	DECLARE INTEGER GetLastError IN kernel32

	DECLARE INTEGER CreateProcess IN kernel32;
		STRING lpApplicationName, STRING lpCommandLine,;
		INTEGER lpProcessAttr, INTEGER lpThreadAttr,;
		INTEGER bInheritHandles, INTEGER dwCreationFlags,;
		INTEGER lpEnvironment, STRING lpCurrentDirectory,;
		STRING @lpStartupInfo, STRING @lpProcessInformation

	LOCAL cProcInfo, cStartInfo, nFlags, nResult, hProcess, hThread
	cProcInfo = Repli(Chr(0), 16)
	cStartInfo = PADR(Chr(START_INFO_SIZE), START_INFO_SIZE, Chr(0))
	nFlags = 0
	cApp = ALLTRIM(cApp)
	cCmdLine = " " + ALLTRIM(cCmdLine)

	nResult = CreateProcess(cApp, cCmdLine, 0,0,0,;
		nFlags, 0, SYS(5)+SYS(2003), @cStartInfo, @cProcInfo)

	IF nResult = 0
	*  2 = ERROR_FILE_NOT_FOUND
	*  3 = ERROR_PATH_NOT_FOUND
	*  5 = ERROR_ACCESS_DENIED
	* 87 = ERROR_INVALID_PARAMETER
		? "错误代码：", GetLastError()
		RETURN
	ENDIF
	
	* 在 ProcInfo 结构中返回的进程和线程句柄
	hProcess = buf2dword(SUBSTR(cProcInfo, 1,4))
	hThread = buf2dword(SUBSTR(cProcInfo, 5,4))

	IF MessageB("点击<是>，终止刚刚创建的进程。   ", 32+4, "终止进程API") = 6

		DECLARE INTEGER TerminateProcess IN kernel32;
			INTEGER hProcess, INTEGER uExitCode
		= TerminateProcess(hProcess, 0)
	ENDIF

FUNCTION buf2dword(cBuffer)
RETURN Asc(SUBSTR(cBuffer, 1,1)) + ;
	Asc(SUBSTR(cBuffer, 2,1)) * 256 +;
	Asc(SUBSTR(cBuffer, 3,1)) * 65536 +;
	Asc(SUBSTR(cBuffer, 4,1)) * 16777216  
```  
***  


## 函数列表：
[CreateProcess](../libraries/kernel32/CreateProcess.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[TerminateProcess](../libraries/kernel32/TerminateProcess.md)  

## 备注：
根据微软的规定，所有的 WinExec 调用都会直接翻译成相应的 CreateProcess 调用。  
  
微软知识库文章 - 175986  （译者注：链接已失效）
[Understanding CreateProcess_and Command-line Arguments](https://support.microsoft.com/en-us/help/175986/info-understanding-createprocess-and-command-line-arguments).
  
* * *  
请注意，C＃代码中的Run方法已重载。  
  
***  

