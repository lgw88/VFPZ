[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 将复制文件作为一项事务性操作（Vista）
_翻译：xinjie  2021.01.01_

## 开始之前：
Windows Vista为各种文件操作提供事务保护：创建、删除、复制、移动等。  

参考：

* [复制文件时显示标准进度对话框](sample_508.md)  
* [删除文件到回收站](sample_321.md)  
  
***  


## 代码：
```foxpro  
#DEFINE INVALID_HANDLE_VALUE -1
#DEFINE COPY_FILE_FAIL_IF_EXISTS 0x00000001
#DEFINE COPY_FILE_OPEN_SOURCE_FOR_WRITE 0x00000004

DO declare

LOCAL hTrans
hTrans = CreateTransaction(0, 0, 0, 0, 0, 1000, NULL)
IF hTrans = INVALID_HANDLE_VALUE
	? "CreateTransaction 调用失败：", GetLastError()
	RETURN
ENDIF

LOCAL cSrc, cDst, nResult
cSrc = "c:\temp\test.txt"
cDst = "c:\temp\test1.txt"

nResult = CopyFileTransacted(cSrc, cDst, 0, 0, 0,;
	BITOR(COPY_FILE_FAIL_IF_EXISTS,;
	COPY_FILE_OPEN_SOURCE_FOR_WRITE),;
	hTrans)
	
IF nResult = 0
	? "CopyFileTransacted 调用失败", GetLastError()
	= RollbackTransaction(m.hTrans)
ELSE
	= CommitTransaction(m.hTrans)
ENDIF

= CloseHandle(hTrans)
* 主程序结束

PROCEDURE declare
	DECLARE INTEGER CopyFileTransacted IN kernel32;
		STRING lpExistingFileName, STRING lpNewFileName,;
		INTEGER lpProgressRoutine, INTEGER lpData,;
		INTEGER pbCancel, INTEGER dwCopyFlags,;
		INTEGER hTransaction

	DECLARE INTEGER CloseHandle IN kernel32;
		INTEGER hObject

	DECLARE INTEGER CommitTransaction IN KtmW32;
		INTEGER TransactionHandle

	DECLARE INTEGER RollbackTransaction IN KtmW32;
		INTEGER TransactionHandle

	DECLARE INTEGER GetLastError IN kernel32

	DECLARE INTEGER CreateTransaction IN KtmW32;
		INTEGER lpTransactionAttributes, INTEGER UOW,;
		INTEGER CreateOptions, INTEGER IsolationLevel,;
		INTEGER IsolationFlags, INTEGER Timeout,;
		STRING @Description  
```  
***  


## 函数列表：
[CloseHandle](../libraries/kernel32/CloseHandle.md)  
[CommitTransaction](../libraries/ktmw32/CommitTransaction.md)  
[CopyFileTransacted](../libraries/kernel32/CopyFileTransacted.md)  
[CreateTransaction](../libraries/ktmw32/CreateTransaction.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[RollbackTransaction](../libraries/ktmw32/RollbackTransaction.md)  
