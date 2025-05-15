[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 当前键盘类型
_翻译：xinjie  2021.02.06_

## 代码：
```foxpro  
DECLARE INTEGER GetKeyboardType IN user32 INTEGER nTypeFlag
	
? "键盘类型:", getTypeName()
? "OEM 子类型:", GetKeyboardType(1)
? "功能键数量:", GetKeyboardType(2)

FUNCTION  getTypeName
	lnType = GetKeyboardType (0)
	DO CASE
	CASE lnType = 1
		RETURN "IBM PC/XT or compatible (83-key) keyboard"
	CASE lnType = 2
		RETURN "Olivetti ICO (102-key) keyboard"
	CASE lnType = 3
		RETURN "IBM PC/AT (84-key) or similar keyboard"
	CASE lnType = 4
		RETURN "IBM enhanced (101- or 102-key) keyboard"
	CASE lnType = 5
		RETURN "Nokia 1050 and similar keyboards"
	CASE lnType = 6
		RETURN "Nokia 9140 and similar keyboards"
	CASE lnType = 7
		RETURN "Japanese keyboard"
	OTHER
		RETURN "未知键盘类型: " + LTRIM(STR(lnType))
	ENDCASE  
```  
***  


## 函数列表：
[GetKeyboardType](../libraries/user32/GetKeyboardType.md)  
