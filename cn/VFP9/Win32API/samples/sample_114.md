[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 使用 GetFileSize

_翻译：xinjie  2020.01.24_

## 开始之前：
参考：

* [如何检索远程文件的大小(FTP)](sample_069.md)  
* [基本卷信息](sample_098.md)  
* [使用 GetCompressedFileSize](sample_192.md)  
  
***  


## 代码：
```foxpro  
DO declare
? GetFileSizeAPI(_vfp.ServerName)

FUNCTION GetFileSizeAPI(lcFilename)
#DEFINE OF_SHARE_DENY_NONE 64
#DEFINE HFILE_ERROR -1
#DEFINE MAX_DWORD 0xffffffff

	LOCAL lpReOpenBuff, hFile, lnSizeLo, lnSizeHi

	lpReOpenBuff = REPLICATE(Chr(0), 250)
	hFile = OpenFile(lcFilename, @lpReOpenBuff, OF_SHARE_DENY_NONE)

	IF hFile <> HFILE_ERROR
		lnSizeHi = 0
		lnSizeLo = GetFileSize(hFile, @lnSizeHi)
		= CloseHandle(hFile)
		RETURN lnSizeHi * (MAX_DWORD + 1) + lnSizeLo
	ELSE
		RETURN 0
	ENDIF

PROCEDURE declare
	DECLARE INTEGER GetFileSize IN kernel32;
		INTEGER hFile, INTEGER @lpFileSizeHigh

	DECLARE INTEGER OpenFile IN kernel32;
		STRING lpFileName,;
		STRING @lpReOpenBuff,;
		INTEGER wStyle

	DECLARE INTEGER CloseHandle IN kernel32;
		INTEGER hObject  
```  
***  


## 函数列表：
[CloseHandle](../libraries/kernel32/CloseHandle.md)  
[GetFileSize](../libraries/kernel32/GetFileSize.md)  
[OpenFile](../libraries/kernel32/OpenFile.md)  

## 备注：
GetFileSize 返回存储在两个 32 位无符号整数中的结果。 这对于任何文件或设备来说都是相当大的。
  
如果它只返回一个 32 位值————如今，4,294,967,296字节的最大容量已经不是什么高端容量了。
  
***  

