[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 在 ANSI 和 OEM 之间转换字符串
_翻译：xinjie  2021.02.06_

## 代码：
```foxpro  
DECLARE SHORT CharToOem IN user32;
	STRING lpszSrc,;
	STRING @ lpszDst

DECLARE SHORT OemToChar IN user32;
	STRING lpszSrc,;
	STRING @ lpszDst

* 源字串(1251)
lcSrc = "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÜÛÚÝÞß" +;
	"àáâãäåæçèéêëìíîïðñòóôõö÷øùüûúýþÿ"

* 缓冲区
lcDst = SPACE(Len(lcSrc))
	
? lcSrc

* 从ANSI转换到OEM
= CharToOem (lcSrc, @lcDst)
? lcDst

* 从OEM转换回ANSI
= OemToChar (lcDst, @lcSrc)
? lcSrc  
```  
***  


## 函数列表：
[CharToOem](../libraries/user32/CharToOem.md)  
[OemToChar](../libraries/user32/OemToChar.md)  
