[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 操作系统的版本和修订版
_翻译：xinjie  2021.01.03_

## 代码：
```foxpro  
DECLARE INTEGER GetVersion IN kernel32

DECLARE SHORT StrToIntEx IN Shlwapi;
	STRING pszString, INTEGER dwFlags, INTEGER @pllRet

lnVersion = GetVersion()

* 低位
lnVersionLo = BitRShift(BitLShift(lnVersion, 16), 16)
? "主要版本: ", BitAnd(lnVersionLo, hex2dec("0x00ff"))
? "次要版本: ", BitRShift(BitAnd(lnVersionLo, hex2dec("0xff00")), 8)
?

* 高位
lnVersionHi = BitRShift(BitAnd(lnVersion, hex2dec("0xffff0000")), 16)
? lnVersionHi

FUNCTION  hex2dec (lcHex)
#DEFINE STIF_SUPPORT_HEX           1
	LOCAL lnRet
	lnRet = 0
	IF StrToIntEx (lcHex, STIF_SUPPORT_HEX, @lnRet) = 1
		RETURN lnRet
	ELSE
		RETURN 0
	ENDIF  
```  
***  


## 函数列表：
[GetVersion](../libraries/kernel32/GetVersion.md)  
[StrToIntEx](../libraries/shlwapi/StrToIntEx.md)  
