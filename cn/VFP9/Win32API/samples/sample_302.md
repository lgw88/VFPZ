[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 如何检索回收站中存储的对象数量
_翻译：xinjie  2021.01.01_

## 开始之前：
![](../images/recyclebin.png)  

参考：

* [删除文件到回收站](sample_321.md)  
* [如何清空回收站](sample_301.md)  
* [如何删除非空目录](sample_541.md)  
* [复制文件时显示标准进度对话框](sample_508.md)  

  
***  


## 代码：
```foxpro  
#DEFINE S_OK 0

*|typedef struct _SHQUERYRBINFO{
*|    DWORD cbSize;
*|    #if !defined(_MAC) || defined (_MAC_INT_64)
*|        __int64 i64Size;
*|        __int64 i64NumItems;
*|    #else
*|        DWORDLONG i64Size;
*|        DWORDLONG i64NumItems;
*|    #endif
*|} SHQUERYRBINFO, *LPSHQUERYRBINFO; total bytes = 20

	LOCAL lcBuffer
	lcBuffer = Chr(20) + Repli(Chr(0), 19)

	DECLARE INTEGER SHQueryRecycleBin IN shell32;
		STRING pszRootPath, STRING @pSHQueryRBInfo

	IF SHQueryRecycleBin ("C:", @lcBuffer) = S_OK
		?"*** 回收站："

		? "所有对象的总大小，字节：",;
			buf2i64(SUBSTR(lcBuffer, 5,8))

		? "对象总数：",;
			buf2i64(SUBSTR(lcBuffer, 13,8))
	ENDIF
RETURN

FUNCTION  buf2dword (lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
	BitLShift(Asc(SUBSTR(lcBuffer, 2,1)),  8) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 3,1)), 16) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 4,1)), 24)

FUNCTION  buf2i64 (lcBuffer)
#DEFINE BITSHIFT32 0x100000000
RETURN buf2dword(SUBSTR(lcBuffer, 1,4)) +;
	BITSHIFT32 * buf2dword(SUBSTR(lcBuffer, 5,4))  
```  
***  


## 函数列表：
[SHQueryRecycleBin](../libraries/shell32/SHQueryRecycleBin.md)  
