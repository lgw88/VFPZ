[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 将十六进制字符串转换为整数
_翻译：xinjie  2021.06.16_

## 开始之前：
查看反向转换 [将整数转换为十六进制字符串](sample_260.md).  
  
***  


## 代码：
```foxpro  
#DEFINE STIF_DEFAULT               0
#DEFINE STIF_SUPPORT_HEX           1

DECLARE SHORT StrToIntEx IN Shlwapi;
	STRING    pszString,;
	INTEGER   dwFlags,;
	INTEGER @ pllRet

LOCAL lcHex, lnRet

lcHex = "0x800"
lnRet = 0

= StrToIntEx (lcHex, STIF_SUPPORT_HEX, @lnRet)
? lnRet  
```  
***  


## 函数列表：
[StrToIntEx](../libraries/shlwapi/StrToIntEx.md)  

## 备注：
STIF_DEFAULT 支持常规的十进制表示法。  
  
***  

