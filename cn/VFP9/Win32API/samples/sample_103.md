[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 更改文件属性
_翻译：xinjie  2021.02.09_

## Code:
```foxpro  
LPARAMETERS  lpFileName

#DEFINE FILE_ATTRIBUTE_READONLY       1
#DEFINE FILE_ATTRIBUTE_HIDDEN         2
#DEFINE FILE_ATTRIBUTE_SYSTEM         4
#DEFINE FILE_ATTRIBUTE_DIRECTORY     16
#DEFINE FILE_ATTRIBUTE_ARCHIVE       32
#DEFINE FILE_ATTRIBUTE_NORMAL       128
#DEFINE FILE_ATTRIBUTE_TEMPORARY    512
#DEFINE FILE_ATTRIBUTE_COMPRESSED  2048

DECLARE SHORT SetFileAttributes IN kernel32;
	STRING lpFileName, INTEGER dwFileAttributes

DECLARE INTEGER GetFileAttributes IN kernel32 STRING lpFileName

* 读取此文件的当前属性
dwFileAttributes = GetFileAttributes (lpFileName)

IF dwFileAttributes = -1
* 文件不存在
	RETURN
ENDIF

IF dwFileAttributes > 0
	* 要设置的只读属性
	dwFileAttributes = BitOr(dwFileAttributes, FILE_ATTRIBUTE_READONLY)
		
	* 要删除的存档属性
	IF BitAnd(dwFileAttributes, FILE_ATTRIBUTE_ARCHIVE) = FILE_ATTRIBUTE_ARCHIVE
		dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_ARCHIVE
	ENDIF

	* 设置选定的属性
	= SetFileAttributes (lpFileName, dwFileAttributes)
ENDIF  
```  
***  


## 函数列表：
[GetFileAttributes](../libraries/kernel32/GetFileAttributes.md)  
[SetFileAttributes](../libraries/kernel32/SetFileAttributes.md)  

## 备注：
传递一个文件名给此过程。这段代码为所选文件设置只读和清除存档属性。 
  
DOS命令ATTRIB也可用于同样的目的。 
```dos
ATTRIB -R c:\mydir\*.* /S
```

***  

