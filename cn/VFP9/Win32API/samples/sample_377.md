[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 从 VFP 启动外部程序并等待其终止
_翻译：xinjie  2020.12.31_

## 开始之前：
您可能感兴趣的其他代码样本：  
* [在 VFP 中使用 WinExec 启动外部应用程序](sample_002.md)  
* [使用 ShellExecute 对文件进行操作](sample_093.md)  
* [通过使用 CreateProcess 从 VFP 应用程序启动可执行文件](sample_003.md)  
* [如何以其他用户的身份启动进程(NT/XP/2K)](sample_426.md)  
* [以子进程的形式运行 MSDOS Shell，并重定向输入和输出](sample_477.md)  

  
***  


## 代码：
```foxpro  
DO decl

*= RunAndWait("c:\windows\notepad.exe", "")
= RunAndWait("C:\program files\Microsoft Office\Office10\excel.exe", "")
* 主程序结束

PROCEDURE RunAndWait(lcApp, lcCmdLine)
#DEFINE START_INFO_SIZE 68
#DEFINE INFINITE  0xFFFFFFFF
#DEFINE NORMAL_PRIORITY_CLASS 0x20

	LOCAL cStartupInfo, cProcInfo, hProcess, hThread
	cStartupInfo = PADR(Chr(START_INFO_SIZE), START_INFO_SIZE, Chr(0))
	cProcInfo = Repli(Chr(0), 16)

	IF CreateProcess(lcApp+CHR(0), lcCmdLine+CHR(0),;
		0,0,1, NORMAL_PRIORITY_CLASS, 0,;
		SYS(5)+SYS(2003), @cStartupInfo, @cProcInfo) <> 0

		* 在ProcInfo结构中返回的过程和线程句柄
		hProcess = buf2dword(SUBSTR(cProcInfo, 1,4))
		hThread = buf2dword(SUBSTR(cProcInfo, 5,4))

		* 守株待兔
		= WaitForSingleObject(hProcess, INFINITE)
	    = CloseHandle(hThread)
	    = CloseHandle(hProcess)
	ELSE
		? "错误代码：", GetLastError()
	ENDIF

FUNCTION buf2dword(lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
	Asc(SUBSTR(lcBuffer, 2,1)) * 256 +;
	Asc(SUBSTR(lcBuffer, 3,1)) * 65536 +;
	Asc(SUBSTR(lcBuffer, 4,1)) * 16777216

PROCEDURE decl
	DECLARE INTEGER GetLastError IN kernel32
	DECLARE INTEGER CloseHandle IN kernel32 INTEGER hObject

	DECLARE INTEGER CreateProcess IN kernel32;
		STRING lpAppName, STRING lpCmdLine, INTEGER lpProcAttr,;
		INTEGER lpThrAttr, INTEGER bInhHandles, INTEGER dwCrFlags,;
		INTEGER lpEnvir, STRING lpCurDir, ;
		STRING @lpStInfo, STRING @lpProcInfo

	DECLARE INTEGER WaitForSingleObject IN kernel32;
		INTEGER hHandle, INTEGER dwMilliseconds  
```  
***  


## 函数列表：
[CloseHandle](../libraries/kernel32/CloseHandle.md)  
[CreateProcess](../libraries/kernel32/CreateProcess.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[WaitForSingleObject](../libraries/kernel32/WaitForSingleObject.md)  

## 备注：
  
另一种选择是在不同的桌面上启动外部程序。在没有调用WaitForSingleObject的情况下，主机的VFP程序保持活动状态。尽管它变得不可见，并且被切断了键盘和鼠标的输入。 
  
参考：  
* [如何防止用户访问 Windows 桌面和切换到其他应用程序](sample_492.md)

* * *  
C#:  这是异步通知，依赖于Exited事件（进程实例的EnableRaisingEvents必须设置为true）。同步通知依赖于调用WaitForExit方法。  
  
***  

