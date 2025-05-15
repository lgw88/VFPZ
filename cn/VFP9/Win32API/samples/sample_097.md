[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 如何测试文件属性(FileExists和DirectoryExists例程的关键方法)
_翻译：xinjie  2021.02.06_

## 代码：
```foxpro  
#DEFINE FILE_ATTRIBUTE_READONLY       1
#DEFINE FILE_ATTRIBUTE_HIDDEN         2
#DEFINE FILE_ATTRIBUTE_SYSTEM         4
#DEFINE FILE_ATTRIBUTE_DIRECTORY     16
#DEFINE FILE_ATTRIBUTE_ARCHIVE       32
#DEFINE FILE_ATTRIBUTE_NORMAL       128
#DEFINE FILE_ATTRIBUTE_TEMPORARY    512
#DEFINE FILE_ATTRIBUTE_COMPRESSED  2048

    DECLARE INTEGER GetLastError IN kernel32
    DECLARE INTEGER GetFileAttributes IN kernel32 STRING lpFileName

    * 两种都可以接受
    lpFileName = "c:\Program Files\Microsoft Office"
*    lpFileName = "//thatbloke/c/windows/system"

    lnAttributes = GetFileAttributes (lpFileName)
    IF lnAttributes >= 0
    ? "文件名: ", lpFileName
    ? "属性: ", lnAttributes

    = displayFlag (lnAttributes, FILE_ATTRIBUTE_READONLY, "只读: ")
    = displayFlag (lnAttributes, FILE_ATTRIBUTE_HIDDEN, "隐藏: ")
    = displayFlag (lnAttributes, FILE_ATTRIBUTE_SYSTEM, "系统: ")
    = displayFlag (lnAttributes, FILE_ATTRIBUTE_DIRECTORY, "目录: ")
    = displayFlag (lnAttributes, FILE_ATTRIBUTE_ARCHIVE, "存档: ")
    = displayFlag (lnAttributes, FILE_ATTRIBUTE_NORMAL, "常规: ")
    = displayFlag (lnAttributes, FILE_ATTRIBUTE_TEMPORARY, "临时: ")
    = displayFlag (lnAttributes, FILE_ATTRIBUTE_COMPRESSED, "压缩: ")
    ELSE
        *  2 - 系统不能找到指定的文件 = ERROR_FILE_NOT_FOUND
        *  3 - 系统不能找到指定的路径 = ERROR_PATH_NOT_FOUND
        * 21 - 设备未准备好 = ERROR_NOT_READY
        ? "错误代码: ", GetLastError()
    ENDIF

PROCEDURE  displayFlag (lnFlags, lnMask, lcCaption)
    lcResult = IIF (BitAnd(lnFlags, lnMask) = lnMask, "[x]", "[ ]")
    ? "   ", lcResult, lcCaption
RETURN  
```  
***  


## 函数列表：
[GetFileAttributes](../libraries/kernel32/GetFileAttributes.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  

## 备注：
顺便说一下，这个例程可以非常准确地测试对一个目录的访问。检查你的框架中的DirectoryExists函数。 
  
不仅是目录的可访问性，这个函数还返回ReadOnly状态。 
  
***  

