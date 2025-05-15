[<img src="../images/home.png"> 主页 ](https://github.com/VFPX/Win32API)  

# 将整数转换为十六进制字符串
_翻译：xinjie  2021.06.16_

## 开始之前：
查看反向转换 [将十六进制字符串转换为整数](sample_107.md).  
  
***  

## 代码：
```foxpro  
? int2hex(100)

FUNCTION  int2hex (num)
	DECLARE INTEGER wnsprintf IN Shlwapi;
		STRING @lpOut, INTEGER cchLimitIn,;
		STRING pszFmt, INTEGER

	LOCAL lnResult, lcResult
	lcResult = SPACE(20)
	lnResult = wnsprintf(@lcResult, 20, "%x", num)
RETURN Left(lcResult, lnResult)  
```  
***  


## 函数列表：
[wnsprintf](../libraries/shlwapi/wnsprintf.md)  

## 备注：
也可以这样做： 
```foxpro
TRANSFORM(num, "@0")
```

VFP3 不支持。  
  
***  

