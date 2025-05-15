[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 检索系统启动后的已过时间
_翻译：xinjie  2021.01.11_

## 代码：
```foxpro  
DECLARE INTEGER GetTickCount IN kernel32.dll
	lnSeconds = GetTickCount() / 1000

	lnHours = INT (lnSeconds/3600)
	lnSeconds = lnSeconds - lnHours * 3600
	
	lnMinutes = INT (lnSeconds/60)
	lnSeconds = lnSeconds - lnMinutes * 60
	
	? "重启以来的时间: "
	?? STRTRAN (STR(lnHours,2) + ":" + STR(lnMinutes,2) + ":";
		+ STR(lnSeconds,2), " ","0")  
```  
***  


## 函数列表：
[GetTickCount](../libraries/kernel32/GetTickCount.md)  
