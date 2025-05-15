[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 锁定 VFP 应用程序的鼠标和键盘输入

## 开始之前：
参考：

* [使用Raw Input API（VFP9）捕获另一个应用程序的键盘活动](sample_572.md)  
  
***  


## 代码：
```foxpro  
DECLARE INTEGER GetActiveWindow IN user32

DECLARE INTEGER EnableWindow IN user32;
 INTEGER hwnd,;
 INTEGER fEnable

* 获取VFP主窗口的控制权
hwnd = GetActiveWindow()

? EnableWindow (hwnd, 0)
? "*** 输入锁定 - 仅VFP主窗口"
	
FOR ii=1 TO 10
	DO proc1
ENDFOR

? EnableWindow (hwnd, 1)
? "*** 解除锁定"

PROCEDURE  proc1
	LOCAL ii
	WAIT WINDOW NOWAIT "正在创建 cursor..."
	CREATE CURSOR cs (id N(6), dt D)
	FOR ii=1 TO 10000
		INSERT INTO cs VALUES (ii, date()-ii)
	ENDFOR
	WAIT CLEAR
	? Chr(9) + "- 游标被创建，时间：" + TTOC (datetime())
RETURN  
```  
***  


## 函数列表：
[EnableWindow](../libraries/user32/EnableWindow.md)  
[GetActiveWindow](../libraries/user32/GetActiveWindow.md)  

## 备注：
在此示例中，仅针对VFP应用程序锁定了用户输入。 此功能与BlockInput的工作方式不同。 后者锁定所有进程的窗口，而不仅仅是活动进程和线程。
  
使用EnableWindow，您可以有效地锁定VFP应用程序。 但这更像是“您锁上门并扔掉钥匙”。 要解锁它，请使用任务管理器，或者事先将说明与相应的HWND一起提交给其他应用程序。
  
应用于窗口控件时，此功能可以启用或禁用它们。 
  
***  

