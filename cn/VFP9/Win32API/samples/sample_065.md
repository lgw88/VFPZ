[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 设置文件创建的日期和时间
_翻译：xinjie  2021.01.11_

## 代码：
```foxpro  
#DEFINE OF_READ 0
#DEFINE OF_WRITE 1
DO declare

* 为结构创建缓冲区
lcFileTime = REPLICATE(CHR(0), 8)  && FILETIME
lcSystemTime = REPLICATE(CHR(0), 16)  && SYSTEMTIME

* 检索系统时间并将其转换为文件时间格式
*= GetSystemTime (@lcSystemTime)
*= SystemTimeToFileTime (@lcSystemTime, @lcFileTime)

* 异曲同工
= GetSystemTimeAsFileTime(@lcFileTime)

* 打开文件后再修改时间和日期
lcFile = "c:\temp\temp.txt"    && 使用有效的文件名
lcBuff = REPLICATE(CHR(0), 250)  && OFSTRUCT结构的缓冲区
hFile = OpenFile(lcFile, @lcBuff, OF_WRITE)

IF hFile > 0
	* 用法: SetFileTime(hFile, <creation>, <lastaccess>, <lastwrite>)
	* 用零代替那些你想保持不变的日期时间参数，所以下面的调用将只改变创建日期时间。

	IF SetFileTime(hFile, @lcFileTime, 0, 0) = 0
		? "SetFileTime 失败:", GetLastError()
	ELSE
		? "Ok!"
	ENDIF

	= CloseHandle(hFile)
ELSE
	* 2=ERROR_FILE_NOT_FOUND
	* 3=ERROR_PATH_NOT_FOUND
	* 5=ERROR_ACCESS_DENIED
	? "OpenFile 失败:", GetLastError()
ENDIF
* 主程序结束

PROCEDURE declare
	DECLARE INTEGER GetLastError IN kernel32
	DECLARE INTEGER CloseHandle IN kernel32 INTEGER hObject
	DECLARE GetSystemTime IN kernel32 STRING @lpSystemTime

	DECLARE GetSystemTimeAsFileTime IN kernel32;
		STRING @lpSystemTimeAsFileTime

	DECLARE INTEGER SystemTimeToFileTime IN kernel32;
		STRING @ lpSystemTime, STRING @ lpFileTime

	DECLARE INTEGER SetFileTime IN kernel32;
		INTEGER hFile, STRING @lpCreationTime,;
		STRING @lpLastAccessTime, STRING @lpLastWriteTime

	DECLARE INTEGER OpenFile IN kernel32;
		STRING lpFileName, STRING @lpReOpenBuff, INTEGER wStyle  
```  
***  


## 函数列表：
[CloseHandle](../libraries/kernel32/CloseHandle.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[GetSystemTime](../libraries/kernel32/GetSystemTime.md)  
[GetSystemTimeAsFileTime](../libraries/kernel32/GetSystemTimeAsFileTime.md)  
[OpenFile](../libraries/kernel32/OpenFile.md)  
[SetFileTime](../libraries/kernel32/SetFileTime.md)  
[SystemTimeToFileTime](../libraries/kernel32/SystemTimeToFileTime.md)  

## 备注：
文件句柄必须是在对文件进行 GENERIC_WRITE 访问时创建的。  
  
我试着用原生FOPEN()函数来创建句柄（使用不同的 attributes）。但没有成功。 
  
你可以改变三个文件时间值中的任何一个或它们的组合。但是并不是所有的文件系统都能记录创建时间和最后一次访问时间，也不是所有的文件系统都以同样的方式记录它们。这样你就可以将创建时间设置为晚于其访问和修改时间。 
  
* * *  
在C#版本中，我使用托管的FileInfo对象，而不是通过System.Runtime.InteropServices命名空间来访问文件时间。 
  
***  

