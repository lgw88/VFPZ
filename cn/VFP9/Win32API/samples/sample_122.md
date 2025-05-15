[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 如何关闭 Windows

_翻译：xinjie  2020.01.29_

## 开始之前：
参看：

* [关闭 Windows](sample_036.md)  
* [重启 Windows](sample_361.md)  
* [如何暂停或休眠您的系统](sample_395.md)  
* [为应用程序启用 SE_SHUTDOWN_NAME 权限](sample_552.md)  

  
***  


## 代码：
```foxpro  
DO declare

LOCAL cMachineName, nResult
cMachineName=""

nResult=InitiateSystemShutdown(cMachineName,;
	"System Shutdown initiated...", 10, 0, 1)

IF nResult = 0
* 失败的常见原因包括无效或不可访问的计算机名称或权限不足。
	*   5 = ERROR_ACCESS_DENIED
	*  53 = ERROR_BAD_NETPATH
	* 120 = ERROR_CALL_NOT_IMPLEMENTED -- not supported in Win9*
	? "Error code:", GetLastError()
ENDIF

PROCEDURE declare
	DECLARE INTEGER GetLastError IN kernel32

	DECLARE INTEGER InitiateSystemShutdownA IN advapi32;
	AS InitiateSystemShutdown ;
		STRING lpMachineName, STRING lpMessage,;
		INTEGER dwTimeout, SHORT bForceAppsClosed,;
		SHORT bRebootAfterShutdown  
```  
***  


## 函数列表：
[GetLastError](../libraries/kernel32/GetLastError.md)  
[InitiateSystemShutdown](../libraries/advapi32/InitiateSystemShutdown.md)  

## 备注：
要关闭本地计算机，调用线程必须具有 SE_SHUTDOWN_NAME 权限。
  
InitiateSystemShutdownEx 启动指定计算机的关闭和可选重新启动，并可选择记录关闭的原因。 
  
***  

