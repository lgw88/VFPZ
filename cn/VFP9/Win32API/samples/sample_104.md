[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 大功率的ALLTRIM
_翻译：xinjie  2021.02.09_

## 代码：
```foxpro  
DECLARE SHORT StrTrim IN Shlwapi As StrTrim;
   	STRING @ pszSource,;
   	STRING   pszTrimChars

lcSrc = "____//Turtle Soup/  "
	
* 注意：三个字符包括在要修剪的字符列表中。
lcTrimChars = "_ /"

? "Before: ", "["+ lcSrc +"]"
= StrTrim (@lcSrc, lcTrimChars)
? "After:  ", "[" + LEFT(lcSrc, AT(Chr(0),lcSrc)-1) + "]"  
```  
***  


## 函数列表：
[StrTrim](../libraries/shlwapi/StrTrim.md)  

## 备注：
与原生的ALLTRIM不同，该函数不仅可以删除空白，还可以删除包含在修剪字符列表中的任何其他字符。  
  
例如，如果要修剪一个由空格、制表符和引号的任意组合包围的文本，则在此列表中包含这三个字符。  
	- space  
	- tab (Chr(9))  
	- "  
  
***  

