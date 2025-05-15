[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 DeleteFile
_翻译：xinjie  2021.01.01_

## Before you begin:
参考：

* [删除文件到回收站](sample_321.md)  
* [复制文件时显示标准进度对话框](sample_508.md)  

  
***  


## 代码：
```foxpro  
#DEFINE CREATE_ALWAYS                  2
#DEFINE FILE_ATTRIBUTE_NORMAL        128

DECLARE INTEGER DeleteFile IN kernel32;
	STRING lpFileName

DECLARE INTEGER CreateFile IN kernel32;
	STRING  lpFileName,;
	INTEGER dwDesiredAccess,;
	INTEGER dwShareMode,;
	INTEGER lpSecurityAttributes,;
	INTEGER dwCreationDisposition,;
	INTEGER dwFlagsAndAttributes,;
	INTEGER hTemplateFile

DECLARE INTEGER CloseHandle IN kernel32 INTEGER hObject

LOCAL lpFileName
lpFileName = "C:\Temp\mytest.txt"

hResult = CreateFile (lpFileName, 0, 0, 0,;
	CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0)

? "返回的文件句柄：", hResult
= CloseHandle (hResult)
= DeleteFile (lpFileName)  
```  
***  


## 函数列表：
[CloseHandle](../libraries/kernel32/CloseHandle.md)  
[CreateFile](../libraries/kernel32/CreateFile.md)  
[DeleteFile](../libraries/kernel32/DeleteFile.md)  

## 备注：
Windows 95/98 / Me：DeleteFile函数将删除一个文件，即使该文件为常规I / O打开或作为内存映射文件打开。 为防止数据丢失，请在尝试删除文件之前关闭文件。 
  
***  

