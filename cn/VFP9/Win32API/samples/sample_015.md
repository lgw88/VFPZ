[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 创建一个文件，然后将其移动到另一个位置
_翻译：xinjie  2021.01.02_

## 开始之前：
参考：

* [复制文件时显示标准进度对话框](sample_508.md)  

  
***  


## 代码：
```foxpro  
#DEFINE CREATE_ALWAYS 2
#DEFINE FILE_ATTRIBUTE_NORMAL 128

DO declare

lpFileName = "C:\Temp\mytest.txt"
lpNewFileName = "C:\Temp\mytest1.txt"

hFile = CreateFile(lpFileName, 0, 0, 0,;
	CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0)

? "返回的文件句柄:", hFile
= CloseHandle (hFile)
= MoveFile(lpFileName, lpNewFileName)

PROCEDURE declare
	DECLARE INTEGER MoveFile IN kernel32;
		STRING lpExistingFileName, STRING lpNewFileName

	DECLARE INTEGER CreateFile IN kernel32;
		STRING lpFileName, INTEGER dwDesiredAccess,;
		INTEGER dwShareMode, INTEGER lpSecurityAttributes,;
		INTEGER dwCreationDisposition,;
		INTEGER dwFlagsAndAttributes, INTEGER hTemplateFile

	DECLARE INTEGER CloseHandle IN kernel32 INTEGER hObject  
```  
***  


## 函数列表：
[CloseHandle](../libraries/kernel32/CloseHandle.md)  
[CreateFile](../libraries/kernel32/CreateFile.md)  
[MoveFile](../libraries/kernel32/MoveFile.md)  
