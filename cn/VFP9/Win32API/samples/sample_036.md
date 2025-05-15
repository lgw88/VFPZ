[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 关闭操作系统
_翻译：xinjie  2021.01.04_

## 开始之前：
类似示例：   
* [如何启动系统关机(WinNT only)](sample_122.md)  
* [使用 RestartDialog 功能--重启Windows](sample_361.md)  
* [如何为应用程序启用 SE_SHUTDOWN_NAME 权限](sample_552.md)  
  
***  


## 代码：
```foxpro  
#DEFINE EWX_LOGOFF 0
#DEFINE EWX_SHUTDOWN 1
#DEFINE EWX_REBOOT 2
#DEFINE EWX_FORCE 4
#DEFINE EWX_POWEROFF 8
#DEFINE EWX_FORCEIFHUNG 16

DECLARE INTEGER GetLastError IN kernel32

DECLARE INTEGER ExitWindows IN user32;
	INTEGER dwReserved, INTEGER uReturnCode

DECLARE INTEGER ExitWindowsEx IN user32;
	INTEGER uFlags, INTEGER dwReserved

* 注销 -- -- 更改用户
* = ExitWindowsEx(EWX_LOGOFF, 0)

* 重启
nResult = ExitWindowsEx(EWX_REBOOT, 0)

IF nResult=0
* 1314=ERROR_PRIVILEGE_NOT_HELD
	? "ExitWindowsEx 调用失败:", GetLastError()
ENDIF  
```  
***  


## 函数列表：
[ExitWindows](../libraries/user32/ExitWindows.md)  
[ExitWindowsEx](../libraries/user32/ExitWindowsEx.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  

## Comment:
要关闭本地计算机，调用的线程必须拥有 SE_SHUTDOWN_NAME 权限。  
  
***  

