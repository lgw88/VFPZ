[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 设置和获取鼠标双击时间
_翻译：xinjie  2021.01.07_

## 代码：
```foxpro  
DO declare

LOCAL nTime

nTime = GetDoubleClickTime()
? "双击时间:", nTime, "msec"

* 传递0相当于将此参数设置为OS默认值，通常为500毫秒。

*= SetDoubleClickTime(0)

* 主程序结束

PROCEDURE declare
	DECLARE INTEGER SetDoubleClickTime IN user32;
		INTEGER wCount

	DECLARE INTEGER GetDoubleClickTime IN user32  
```  
***  


## 函数列表：
[GetDoubleClickTime](../libraries/user32/GetDoubleClickTime.md)  
[SetDoubleClickTime](../libraries/user32/SetDoubleClickTime.md)  

## 备注：
当设置双击时间为零时，系统使用默认的双击时间500毫秒。  
  
***  

