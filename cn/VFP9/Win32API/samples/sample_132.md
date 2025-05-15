[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 检索环境字符串的另一种方法

_翻译：xinjie  2022.01.30_

## 开始之前：
参看：

* [创建 INI 文件并向其添加字符串](sample_137.md)  
* [读取和设置环境变量](sample_152.md)  
* [在 Cursor 中存储环境字符串](sample_089.md)  
  
***  


## Code:
```foxpro  
DECLARE INTEGER ExpandEnvironmentStrings IN kernel32;
	STRING   lpSrc,;
	STRING @ lpDst,;
	INTEGER  nSize

? "COMPSPEC=",     getVar ("%comspec%")
? "COMPUTERNAME=", getVar ("%computername%")
? "USERDOMAIN=",   getVar ("%userdomain%")
? "USERNAME=",     getVar ("%username%")
? "USERPROFILE=",  getVar ("%userprofile%")
? "SYSTEMROOT=",   getVar ("%systemroot%")
? "TEMP=",         getVar ("%temp%")
? "TMP=",          getVar ("%tmp%")
? "PATH=",         getVar ("%path%")

FUNCTION  getVar (lcVarname)
	LOCAL lnBufferSize, lcResult
	lnBufferSize = 2048
	lcResult = SPACE(lnBufferSize)
	lnResult = ExpandEnvironmentStrings (lcVarname, @lcResult, lnBufferSize)
RETURN IIF(lnResult > 0, LEFT(lcResult, AT(Chr(0), lcResult)-1), "#nothing#")  
```  
***  


## 函数列表：
[ExpandEnvironmentStrings](../libraries/kernel32/ExpandEnvironmentStrings.md)  

## 备注：
如果没有对应的环境变量，该函数返回输入的参数。
  
***  

