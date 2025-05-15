[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 检索各种系统指标
_翻译：xinjie  221.01.16_

## 代码：
```foxpro  
#DEFINE SM_CXSCREEN 0
#DEFINE SM_CYSCREEN 1
#DEFINE SM_CYCAPTION 4
#DEFINE SM_CYMENU 15
#DEFINE SM_CXFULLSCREEN 16
#DEFINE SM_CYFULLSCREEN 17
#DEFINE SM_CXFRAME 32
#DEFINE SM_CYFRAME 33
#DEFINE SM_CMOUSEBUTTONS 43

	DECLARE INTEGER GetSystemMetrics IN user32 INTEGER nIndex
	
	= PrintLine("Screen 宽:               ", SM_CXSCREEN)
	= PrintLine("Screen 高:               ", SM_CYSCREEN)
	= PrintLine("Full-screen  客户端区域宽: ", SM_CXFULLSCREEN)
	= PrintLine("Full-screen  客户端区域高: ", SM_CYFULLSCREEN)
	= PrintLine("正常标题区域的高度:         ", SM_CYCAPTION)
	= PrintLine("单行菜单栏的高度:           ", SM_CYMENU)
	= PrintLine("可调整的窗体边框宽度:       ", SM_CXFRAME)
	= PrintLine("可调整的窗体边框高度:       ", SM_CYFRAME)
	= PrintLine("鼠标按键的数量:            ", SM_CMOUSEBUTTONS)

PROCEDURE PrintLine(cTitle, nMode)
	? cTitle
	?? GetSystemMetrics(nMode)  
```  
***  


## 函数列表：
[GetSystemMetrics](../libraries/user32/GetSystemMetrics.md)  

## 备注：
参考：SystemParametersInfo, <a href="http://msdn.microsoft.com/en-us/library/39ddf2h2(VS.80).aspx">SYSMETRIC</a>  
  
获取屏幕分辨率。在 Windows 7 的 Windows XP 模式下，从屏幕高度(SM_CYSCREEN)中减去两个像素。  
  
***  

