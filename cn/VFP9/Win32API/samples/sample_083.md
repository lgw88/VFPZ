[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 禁用VFP主窗口的鼠标和键盘输入（应用程序仍在运行时）
_翻译：xinjie  2021.01.18_

## 代码：
```foxpro  
DECLARE INTEGER BlockInput IN user32 INTEGER fBlockIt

? BlockInput (1)
? "*** 阻断输入"
	
FOR ii=1 TO 10
	DO dataproc
ENDFOR

? BlockInput (0)
? "*** 解锁输入"

PROCEDURE  dataproc
* 这只是模拟一个耗时的过程
	LOCAL ii
	WAIT WINDOW NOWAIT "正在创建 cursor..."
	CREATE CURSOR cs (id N(6), dt D)
	FOR ii=1 TO 10000
		INSERT INTO cs VALUES (ii, date()-ii)
	ENDFOR
	WAIT CLEAR
	? Chr(9) + "- cursor 被创建，时间： " + TTOC (datetime())
	USE IN cs
RETURN  
```  
***  


## 函数列表：
[BlockInput](../libraries/user32/BlockInput.md)  

## 备注：
<font color=#800000>WinNT4，apr-99的User32.dll：在DLL中找不到入口点BlockInput。</font>  
  
在运行DATAPROC的N次循环中，用户输入实际上被阻塞了。您甚至不能访问任务管理器。

尽管旧的CTRL+ALT+DEL仍然可以突破。如果在这个循环中出现运行时错误，这是非常有用的。否则你就出不来了。

请注意，在阻塞期间，没有按键到达键盘缓冲区。这并不像睡眠功能所产生的延迟。 
  
***  

