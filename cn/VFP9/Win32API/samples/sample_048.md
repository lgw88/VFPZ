[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 Messageox Win32 函数
_翻译：xinjie  2021.01.07_

## 代码：
```foxpro  
* MessageBox() 标记
#DEFINE MB_OK                 0
#DEFINE MB_OKCANCEL           1
#DEFINE MB_ABORTRETRYIGNORE   2
#DEFINE MB_YESNOCANCEL        3
#DEFINE MB_YESNO              4
#DEFINE MB_RETRYCANCEL        5

*| 图标
#DEFINE MB_ICONSTOP          16
#DEFINE MB_ICONQUESTION      32
#DEFINE MB_ICONEXCLAMATION   48
#DEFINE MB_ICONINFORMATION   64
#DEFINE MB_USERICON         128

*| 默认按钮
#DEFINE MB_DEFBUTTON1 0
#DEFINE MB_DEFBUTTON2 0x100
#DEFINE MB_DEFBUTTON3 0x200
#DEFINE MB_DEFBUTTON4 0x300

*| 模式
#DEFINE MB_APPLMODAL          0
#DEFINE MB_SYSTEMMODAL  0x1000
#DEFINE MB_TASKMODAL  0x2000
#DEFINE MB_HELP  0x4000  && Help Button

*| 其它
#DEFINE MB_NOFOCUS  0x8000
#DEFINE MB_SETFOREGROUND  0x10000
#DEFINE MB_DEFAULT_DESKTOP_ONLY 0x20000

*| 定位
#DEFINE MB_TOPMOST  0x40000
#DEFINE MB_RIGHT  0x80000
#DEFINE MB_RTLREADING 0x100000

*| 通知
#DEFINE MB_SERVICE_NOTIFICATION   0x200000
#DEFINE MB_SERVICE_NOTIFICATION_NT3X   0x40000

*| 掩码
#DEFINE MB_TYPEMASK  0x0f
#DEFINE MB_ICONMASK 0xF0
#DEFINE MB_DEFMASK 0xF00
#DEFINE MB_MODEMASK 0x3000
#DEFINE MB_MISCMASK 0xC000

	DECLARE INTEGER MessageBox IN user32 As MsgBox;
		INTEGER hwnd,;
		STRING  lpText,;
		STRING  lpCaption,;
		INTEGER wType

	DECLARE INTEGER GetActiveWindow IN user32

	hwnd = GetActiveWindow()
	? MsgBox (0, "消息文本", "消息标题",;
		MB_ABORTRETRYIGNORE + MB_ICONEXCLAMATION +;
		MB_DEFBUTTON3 + MB_SYSTEMMODAL)  
```  
***  


## 函数列表：
[GetActiveWindow](../libraries/user32/GetActiveWindow.md)  
[MessageBox](../libraries/user32/MessageBox.md)  

## 备注：
在本例中，对话框被置于所有打开的窗口之上。  
  
当对话框存在时，VFP的主窗口不可用于输入。但所有其他打开的窗口都可以访问，尽管对话框窗口一直保持在顶部。 
  
关闭对话框后，VFP主窗口可能不会自动获得焦点，这取决于所使用的操作系统和VFP版本。 
  
注意本例中使用的HWND值为0。这意味着该对话框没有父窗口。您可以通过GetActiveWindow或GetFocus(有条件地)函数找到VFP主窗口的HWND。 
  
作为参数传递给这个函数的HWND--我想--意味着你可以从任何其他窗口中获取这个值。  
  
***  

