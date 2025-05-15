[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 在 VFP 中使用 WinExec 启动外部应用程序
_翻译：xinjie  2020.12.31_

## 开始之前：
该代码在最大化记事本窗口中显示一个 ASCII 文件。如果文件 C:\newfile.txt 不存在，则创建该文件。  

您可能感兴趣的其他代码样本  
* [使用 ShellExecute 对文件进行操作](sample_093.md)  
* [通过使用 CreateProcess 从 VFP 应用程序启动可执行文件](sample_003.md)  
* [从 VFP 启动外部程序并等待其终止](sample_377.md)  
* [如何以其他用户的身份启动进程(NT/XP/2K)](sample_426.md)  
* [以子进程的形式运行 MSDOS Shell，并重定向输入和输出](sample_477.md)  

  
***  


## 代码：
```foxpro  
#DEFINE SW_HIDE 0
#DEFINE SW_SHOWNORMAL 1
#DEFINE SW_SHOWMINIMIZED 2
#DEFINE SW_SHOWMAXIMIZED 3
#DEFINE SW_SHOWNOACTIVATE 4
#DEFINE SW_SHOW 5
#DEFINE SW_MINIMIZE 6
#DEFINE SW_SHOWMINNOACTIVE 7
#DEFINE SW_SHOWNA 8
#DEFINE SW_RESTORE 9
#DEFINE SW_SHOWDEFAULT 10

DECLARE INTEGER WinExec IN kernel32;
	STRING lpCmdLine, INTEGER nCmdShow

LOCAL cCmdLine, nResult

cCmdLine = ["notepad" "c:\newfile.txt"]
*!*	cCmdLine = "C:\Program Files\Microsoft Office\Office10\WINWORD.EXE"

nResult = WinExec(cCmdLine, SW_SHOWDEFAULT)

IF nResult <= 31
	= MESSAGEBOX("WinExec出错失败： " +;
		LTRIM(STR(nResult)) + "     ", 48)
ENDIF  
```  
***  


## 函数列表：
[WinExec](../libraries/kernel32/WinExec.md)  

## 备注：
通过 WinExec 调用运行外部应用程序，你可以绕过 FOXRUN.PIF，这使得整个事情变得更加高效。据微软介绍：所有的 WinExec 调用都会直接翻译成相应的 CreateProcess 调用。 
  
***  

