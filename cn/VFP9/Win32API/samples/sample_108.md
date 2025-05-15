[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 磁盘或内存容量的字符串表示
_翻译：xinjie  2021.02.09_

## 代码：
```foxpro  
DECLARE STRING StrFormatByteSizeA IN Shlwapi;
   	INTEGER   dw,;
    STRING  @ pszBuf,;
	INTEGER   cchBuf

= _show (532)
= _show (1340)
= _show (23506)
= _show (2400016)
= _show (2400000000)

* 注意 StrFormatByteSizeA 在 0xffffffff 之后无法返回正确的值

= _show (4294967295)	&& 支持的最大值
= _show (4294967296)

FUNCTION  _show (dw)
	pszBuf = SPACE(50)
	? dw, " ->  "
	?? StrFormatByteSizeA (m.dw, @pszBuf, Len(pszBuf))  
```  
***  


## 函数列表：
[StrFormatByteSize](../libraries/shlwapi/StrFormatByteSize.md)  
