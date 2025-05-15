[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 检索系统错误信息字符串
_翻译：xinjie  2021.01.07_

## 代码：
```foxpro  
LPARAMETERS nErrorno  && 传递错误代码

#DEFINE FORMAT_MESSAGE_ALLOCATE_BUFFER 0x100
#DEFINE FORMAT_MESSAGE_ARGUMENT_ARRAY 0x2000
#DEFINE FORMAT_MESSAGE_FROM_STRING 0x400
#DEFINE FORMAT_MESSAGE_FROM_SYSTEM 0x1000
#DEFINE FORMAT_MESSAGE_IGNORE_INSERTS 0x200
#DEFINE FORMAT_MESSAGE_MAX_WIDTH_MASK 0xFF

	DECLARE INTEGER FormatMessage IN kernel32;
		INTEGER dwFlags, INTEGER lpSource, INTEGER dwMsgId,;
		INTEGER dwLangId, INTEGER @lpBuffer,;
		INTEGER nSize, INTEGER Arguments

	DECLARE INTEGER LocalFree IN kernel32 INTEGER hMem

	DECLARE RtlMoveMemory IN kernel32 As CopyMemory;
		STRING @dst, INTEGER src, INTEGER nLen

	LOCAL nFlags, hBuffer, nLen, cBuffer
	cBuffer=""

	* 指定格式参数
	nFlags = FORMAT_MESSAGE_ALLOCATE_BUFFER +;
		FORMAT_MESSAGE_FROM_SYSTEM +;
		FORMAT_MESSAGE_IGNORE_INSERTS

	hBuffer = 0
	nLen = FormatMessage(nFlags, 0,;
		nErrorno, 0, @hBuffer, 0, 0)

	IF nLen <> 0
		cBuffer = REPLICATE(Chr(0), 500)
		= CopyMemory(@cBuffer, hBuffer, nLen)
		= LocalFree(hBuffer)
		RETURN STRTRAN(LEFT(cBuffer, nLen), Chr(13)+Chr(10), "")
	ELSE
		RETURN "#empty#"
	ENDIF  
```  
***  


## 函数列表：
[FormatMessage](../libraries/kernel32/FormatMessage.md)  
[LocalFree](../libraries/kernel32/LocalFree.md)  

## 备注：
W32 函数 GetLastError 返回系统错误代码。大约有 2000 多个系统错误代码。

FormatMessage 从 KERNEL32.DLL 中的 MESSAGETABLE 资源中检索数据。最有可能的是，用 FindResource 和 LoadResource 调用(RT_MESSAGETABLE)也可以完成同样的工作。  
  
***  

