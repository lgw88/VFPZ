[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 将小数字符串转换为整数
_翻译：xinjie  2021.06.16_

## 代码:
```foxpro  
DECLARE INTEGER StrToInt IN Shlwapi STRING lpSrc
DECLARE INTEGER StrToLong IN Shlwapi STRING lpSrc
	
= _show("0")
= _show("1")
= _show("abc")
= _show("54")
= _show("0x100")
= _show("2001")
= _show("2 * 3")
= _show("3.14")

PROCEDURE _show(cSrc)
	? cSrc, StrToInt(cSrc), VAL(cSrc)  
```  
***  


## 函数列表
[StrToInt](../libraries/shlwapi/StrToInt.md)  

## 备注：
Native TryParse in C# works a few time faster than the StrToIntEx. But the latter"s flags are less complex that the NumberStyles flags.  
  
***  

