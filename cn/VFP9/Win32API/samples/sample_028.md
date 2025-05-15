[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 测试剪贴板功能：清空剪贴板
_翻译：xinjie  2021.01.03_

## 代码：
```foxpro  
DECLARE INTEGER EmptyClipboard IN user32
DECLARE INTEGER GetActiveWindow IN user32
DECLARE INTEGER CloseClipboard IN user32
DECLARE INTEGER OpenClipboard IN user32 INTEGER hwnd
	
IF OpenClipboard(GetActiveWindow()) <> 0
	= EmptyClipboard()
	= CloseClipboard()  && important
ENDIF  
```  
***  


## 函数列表：
[CloseClipboard](../libraries/user32/CloseClipboard.md)  
[EmptyClipboard](../libraries/user32/EmptyClipboard.md)  
[GetActiveWindow](../libraries/user32/GetActiveWindow.md)  
[OpenClipboard](../libraries/user32/OpenClipboard.md)  

## 备注：
使用VFP代码可以轻松完成上述操作：  
```foxpro
_cliptext=""
```
 
  
***  

