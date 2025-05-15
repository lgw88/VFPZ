[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 InternetGoOnline 函数
_翻译：xinjie  2021.01.11_

## 代码：
```foxpro  
DECLARE SHORT InternetGoOnline IN wininet.dll;
    	STRING  lpszURL,;
    	INTEGER hwndParent,;
    	INTEGER dwReserved

	DECLARE INTEGER GetActiveWindow IN user32
	
	hwnd = GetActiveWindow()
	lcUrl = "http://fox.wikis.com/wc.dll?Wiki~WinInet~WIN_COM_DNA"

	? InternetGoOnline (lcUrl, hwnd, 0)  
```  
***  


## 函数列表：
[GetActiveWindow](../libraries/user32/GetActiveWindow.md)  
[InternetGoOnline](../libraries/wininet/InternetGoOnline.md)  

## 备注：
在我的电脑上(有线Inet)，这个函数总是返回1作为响应，但什么都没有发生--没有出现对话框或消息框。 
  
也许在拨号上网时，它的表现会有所不同。有谁愿意尝试一下，请告诉我。  
  
***  

