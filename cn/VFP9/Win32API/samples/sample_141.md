[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 另一种上网方式（与选择 ISP 无关）

_翻译：xinjie  2022.01.30_

## 代码：
```foxpro  
DECLARE INTEGER InternetGoOnline IN wininet;
	STRING  lpszURL, INTEGER hwndParent,;
	INTEGER dwReserved

? InternetGoOnline ("http://www.microsoft.com", 0, 0)  
```  
***  


## 函数列表：
[InternetGoOnline](../libraries/wininet/InternetGoOnline.md)  

## 备注：
如果您处于脱机模式，此代码会提示您获得联机权限。
  
如果您在线，则此代码不一定会将您转发到所选 URL。 
  
***  

