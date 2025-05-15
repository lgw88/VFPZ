[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 Semaphore 对象
_翻译：xinjie  2021.01.01_

## 开始之前：
参考：

* [使用 Semaphore 对象只允许一个VFP应用实例运行](sample_147.md)  
  
***  


## 代码：
```foxpro  
#DEFINE WAIT_OBJECT_0 0
#DEFINE STATUS_TIMEOUT 0x0102

DO declare

LOCAL hSmp, lnInc

lnInc = 3
hSmp = CreateSemaphore(0, lnInc, lnInc, "TestSmp")

IF hSmp = 0
* 87 = ERROR_INVALID_PARAMETER
	? "错误：", GetLastError()
	RETURN
ENDIF

? "Semaphore 句柄：", hSmp
? "初始计数:", lnInc
?
? "递减数量..."
FOR ii=1 TO 10
	dwWaitResult = WaitForSingleObject(hSmp, 0)
	? "dwWaitResult:", _status(dwWaitResult)
ENDFOR

?
lnInc = 2
? "I通过以下方式增加计数: " + LTRIM(STR(lnInc))
= ReleaseSemaphore(hSmp, lnInc, 0)

?
? "递减计数..."
FOR ii=1 TO 5
	dwWaitResult = WaitForSingleObject(hSmp, 0)
	? "dwWaitResult:", _status(dwWaitResult)
ENDFOR

= CloseHandle(hSmp)
* 主程序结束

FUNCTION _status(lnWaitResult)
	DO CASE
	CASE lnWaitResult = WAIT_OBJECT_0
		RETURN "WAIT_OBJECT_0"
	CASE lnWaitResult = STATUS_TIMEOUT
		RETURN "STATUS_TIMEOUT"
	OTHER
		RETURN "未知类型: " + LTRIM(STR(lnWaitResult))
	ENDCASE

PROCEDURE declare
	DECLARE INTEGER GetLastError IN kernel32
	DECLARE INTEGER CloseHandle IN kernel32 INTEGER hObject

	DECLARE INTEGER CreateSemaphore IN kernel32;
		INTEGER lcSmAttr, INTEGER lInitialCount,;
		INTEGER lMaximumCount, STRING lpName

	DECLARE INTEGER OpenSemaphore IN kernel32;
		INTEGER dwDesiredAccess, INTEGER bInheritHandle,;
		STRING lpName

	DECLARE INTEGER ReleaseSemaphore IN kernel32;
		INTEGER hSemaphore, INTEGER lReleaseCount,;
		INTEGER @ lpPreviousCount

	DECLARE INTEGER WaitForSingleObject IN kernel32;
		INTEGER hHandle, INTEGER dwMilliseconds  
```  
***  


## 函数列表：
[CloseHandle](../libraries/kernel32/CloseHandle.md)  
[CreateSemaphore](../libraries/kernel32/CreateSemaphore.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[OpenSemaphore](../libraries/kernel32/OpenSemaphore.md)  
[ReleaseSemaphore](../libraries/kernel32/ReleaseSemaphore.md)  
[WaitForSingleObject](../libraries/kernel32/WaitForSingleObject.md)  

## 备注：
semaphore 对象是一个同步对象，它在零和指定的最大值之间保持一个计数。  
  
每次线程完成对 semaphore 对象的等待时，计数都会递减，每次线程释放 semaphore 对象时，计数都会递增。 
  
当计数达到零时，没有更多的线程可以成功等待 semaphore 对象状态发出信号。 
  
当 semaphore 的计数大于零时，semaphore 的状态被设置为 signaled，当计数为零时，semaphore 的状态为 nonsignaled。  
  
***  

