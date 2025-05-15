[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 随机生成 UUID 值
_翻译：xinjie  2021.01.03_

## 开始之前：
参考：

* [如何生成 GUID 值](sample_456.md)  
  
***  


## 代码：
```foxpro  
FOR nIndex=1 TO 10
	? GetUUID()
NEXT
* 主程序结束

PROCEDURE GetUUID()
	DECLARE INTEGER UuidCreate IN Rpcrt4 STRING @Uuid
	DECLARE INTEGER RpcStringFree IN Rpcrt4 LONG @StringUuid

	DECLARE INTEGER UuidToString IN Rpcrt4;
		STRING @Uuid, LONG @StringUuid

	DECLARE RtlMoveMemory IN kernel32 As MemToStr;
		STRING @, INTEGER, INTEGER

	LOCAL cUUID, hBuffer, nBufsize, cResult
	cResult=""
	hBuffer=0
	cUUID=REPLICATE(CHR(0), 16)

	= UuidCreate(@cUUID)

	IF UuidToString(@cUUID, @hBuffer)=0
		nBufsize=36
		cResult=REPLICATE(CHR(0), nBufsize)
		MemToStr(@cResult, hBuffer, nBufsize)
		RpcStringFree(@hBuffer)
	ENDIF
	cResult=UPPER(STRTRAN(m.cResult, CHR(0), ""))
RETURN m.cResult  
```  
***  


## 函数列表：
[RpcStringFree](../libraries/rpcrt4/RpcStringFree.md)  
[UuidCreate](../libraries/rpcrt4/UuidCreate.md)  
[UuidToString](../libraries/rpcrt4/UuidToString.md)  
