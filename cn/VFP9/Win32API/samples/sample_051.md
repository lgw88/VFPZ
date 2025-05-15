[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 检索 VFP 会话的命令行
_翻译：xinjie  2021.01.07_

## 开始之前：
参考：

* [如何：使用命令行选项启动 Visual FoxPro](http://msdn.microsoft.com/en-us/library/bzb50fbk(VS.80).aspx)  

  
***  


## 代码：
```foxpro  
DO declare

LOCAL nAddress, cBuffer, nBufsize
nAddress = GetCommandLine()  && 返回内存中的地址
nBufsize = GlobalSize(nAddress)

* 分配和填充缓冲区
IF nBufsize <> 0
	cBuffer = Repli(Chr(0), nBufsize)
	= CopyMemory(@cBuffer, nAddress, nBufsize)
ELSE
* 可在Win98/Me中使用
	cBuffer = Repli(Chr(0), 512)
	= CopyMemory(@cBuffer, nAddress, 512)
	cBuffer = SUBSTR(cBuffer, 1, AT(Chr(0)+Chr(0),cBuffer)+1)
ENDIF

cBuffer = STRTRAN(cBuffer, CHR(0), "")
? "命令行: [" + cBuffer + "]"

PROCEDURE declare
	DECLARE INTEGER GetCommandLine IN kernel32

	DECLARE INTEGER GlobalSize IN kernel32;
		INTEGER hMem

	DECLARE RtlMoveMemory IN kernel32;
	As CopyMemory;
		STRING @Destination, INTEGER Source,;
		INTEGER nLength  
```  
***  


## 函数列表：
[GetCommandLine](../libraries/kernel32/GetCommandLine.md)  
[GlobalSize](../libraries/kernel32/GlobalSize.md)  
