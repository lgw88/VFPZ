[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 如何生成 GUID 值
_翻译：xinjie  2021.01.03_

## 开始之前：
结果以类似于以下示例的格式返回：  
<font color=#0000a0>{557cf400-1a04-11d3-9a73-0000f81ef32e}</font>  

参考：

* [随机生成 UUID 值](sample_024.md)  
* [生成连续的 UUID 值](sample_587.md)  

  
***  


## 代码：
```foxpro  
DO declare

LOCAL cGUID, cGUIDString, cGUID1
cGUID = REPLICATE(CHR(0), 16)  && 128 bits

IF CoCreateGuid(@cGUID) = 0
	cGUIDString = StringFromGUID(cGUID)
	? cGUID
	? cGUIDString
	
	* 从字符串转换回 GUID
	cGUID1 = REPLICATE(CHR(0), 16)
	= CLSIDFromString(STRCONV(cGUIDString,5), @cGUID1)
	? cGUID1
ENDIF
* 主程序结束

FUNCTION StringFromGUID(cGUID)
	LOCAL cBuffer, nBufsize
	nBufsize=128
	cBuffer = REPLICATE(CHR(0), nBufsize*2)
	= StringFromGUID2(cGUID, @cBuffer, nBufsize)
	cBuffer = SUBSTR(cBuffer, 1, AT(CHR(0)+CHR(0), cBuffer))
RETURN STRCONV(cBuffer, 6)

PROCEDURE declare
	DECLARE INTEGER CoCreateGuid IN ole32 STRING @pguid

	DECLARE INTEGER CLSIDFromString IN ole32;
		STRING lpsz, STRING @pclsid

	DECLARE INTEGER StringFromGUID2 IN ole32;
		STRING rguid, STRING @lpsz, INTEGER cchMax  
```  
***  


## 函数列表：
[CLSIDFromString](../libraries/ole32/CLSIDFromString.md)  
[CoCreateGuid](../libraries/ole32/CoCreateGuid.md)  
[StringFromGUID2](../libraries/ole32/StringFromGUID2.md)  

## 备注：
[GUID](https://en.wikipedia.org/wiki/Universally_unique_identifier) 是用于 [CLSID](https://msdn.microsoft.com/en-us/library/windows/desktop/ms691424(v=vs.85).aspx) 和接口标识符的*唯一* 128位整数。 
  

* * *  
有了与 SQL Server 的连接，就可以用 NewId() 函数生成 Guid。

```foxpro
FUNCTION NewGuid() As String  
	IF SQLEXEC(1, "SELECT NewId() As guid", "csGuid") > 0  
		RETURN csGuid.guid  
	ELSE  
		RETURN NULL  
	ENDIF
```

另一种方法是使用 Scriptlet.TypeLib COM。注意，你必须为每个要生成的 Guid 创建一个新的类实例，这可能会产生一些开销。  
```foxpro
obj = CreateObject("Scriptlet.TypeLib")  
? SUBSTR(obj.GUID,2,36)
```
经过简单的测试，我可以估计使用 COM 过程比 SQL 过程（本地服务器）快 5-10%；使用 API 最快，创建 GUID 的速度比 COM 快 15-20 倍--例如，每创建 10,000 个 guid ，API 用时 0.24 秒，而 COM 用时 4 秒。  
  
在同一台计算机上，C# 代码在 1.05 秒内生成 1,000,000 个 guid。  
  
***  

