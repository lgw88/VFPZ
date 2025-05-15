[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 检索窗口和菜单帮助上下文标识符
_翻译：xinjie  2021.01.03_

## 代码：
```foxpro  
DO decl

LOCAL hWindow, hMenu
hWindow = GetFocus()
hMenu = GetMenu(hWindow)

ACTI SCREEN
? "窗口句柄:", hWindow
? "窗口帮助上下文ID:", GetWindowContextHelpId(hWindow)

IF hMenu <> 0
	? "菜单句柄:", hMenu
	? "菜单帮助上下文ID:", GetMenuContextHelpId(hMenu)
ELSE
	? "此窗口无菜单"
ENDIF

PROCEDURE decl
	DECLARE INTEGER GetWindowContextHelpId IN user32 INTEGER hWnd
	DECLARE INTEGER GetMenuContextHelpId IN user32 INTEGER hmenu
	DECLARE INTEGER GetFocus IN user32
	DECLARE INTEGER GetMenu IN user32 INTEGER hWnd  
```  
***  


## 函数列表：
[GetFocus](../libraries/user32/GetFocus.md)  
[GetMenu](../libraries/user32/GetMenu.md)  
[GetMenuContextHelpId](../libraries/user32/GetMenuContextHelpId.md)  
[GetWindowContextHelpId](../libraries/user32/GetWindowContextHelpId.md)  
