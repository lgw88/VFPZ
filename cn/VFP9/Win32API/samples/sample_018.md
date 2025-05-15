[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

#如何不使用文件名而使用别名访问文件（硬链接）
_翻译：xinjie  2021.01.02_

## 开始之前：
NTFS支持文件的别名（硬链接）。一个文件最多可创建1023个别名。每个别名，都是文件的硬链接，是一个目录条目。创建硬链接后，您不仅可以使用文件名，还可以使用别名来访问文件。  

参考：

[将长文件名转换为短格式，反之亦然](sample_055.md)  

  
***  


## Code:
```foxpro  
DO declare

LOCAL cSource, cLink
cSource = "C:\aa.txt"
cLink = "C:\aa_hl.txt"

IF CreateHardLink(cLink, cSource, 0) = 0
	? "CreateHardLink 失败", GetLastError()
	RETURN
ELSE
	= ShellExecute(0, "print", cLink, "", "", 3)
	WAIT WINDOW "按任意键删除硬链接..."
	= DeleteFile(cLink)
ENDIF

PROCEDURE declare
	DECLARE INTEGER CreateHardLink IN kernel32;
		STRING lpFileName, STRING lpExistingFileName,;
		INTEGER lpSecurityAttributes

	DECLARE INTEGER DeleteFile IN kernel32 STRING lpFileName
	DECLARE INTEGER GetLastError IN kernel32

	DECLARE INTEGER ShellExecute IN shell32;
		INTEGER hwnd, STRING lpOperation,;
		STRING lpFile, STRING lpParameters,;
		STRING lpDirectory, INTEGER nShowCmd  
```  
***  


## 函数列表：
[CreateHardLink](../libraries/kernel32/CreateHardLink.md)  
[DeleteFile](../libraries/kernel32/DeleteFile.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[ShellExecute](../libraries/shell32/ShellExecute.md)  

## 备注：
需要检查是否将诸如MYFILE〜1.DOC之类的短名称创建为指向长名称文件的硬链接。
  
硬链接的一些用途包括：
- 通过使用具有不同访问控制列表（ACL）的路径创建硬链接，从而提供对一组文件的不同级别的访问。
- 将文件组织到不同的目录中，而不必复制数据。
- 同一文件的不同名称可用于引发应用程序的不同行为（包括应用程序自身名称的别名）。 
  
***  

