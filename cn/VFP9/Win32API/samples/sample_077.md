[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 检索国家语言设置
_翻译：xinjie  2021.01.16_

## 请注意，本文件中包含一些与旧的news2news网站的链接，该网站目前无法使用。这些材料将在今后某个时候提供。


## 开始之前：
参考：

<!-- Anatoliy -->
* [LanguageBar ActiveX 控件](?solution=7)   
* [将可用的语言环境记录保存到游标中](sample_076.md)  
* [在键盘布局之间切换](sample_275.md)  
  
***  


## 代码：
```foxpro  
DO declare

? "系统默认 LangID:", GetSystemDefaultLangID()
? "用户默认 LangID:", GetUserDefaultLangID()

? "系统默认 LCID:", GetSystemDefaultLCID()
? "用户默认 LCID:", GetUserDefaultLCID()

? "当前线程语言环境:", GetThreadLocale()

? "OEM 编码页标识符:", GetOEMCP()
? "ANSI 编码页标识符:", GetACP()
? "当前代码页（应与GetOEMCP相同）:",;
	GetKBCodePage()

PROCEDURE declare
	DECLARE SHORT GetThreadLocale IN kernel32
	DECLARE SHORT GetSystemDefaultLangID IN kernel32
	DECLARE SHORT GetUserDefaultLangID IN kernel32
	DECLARE SHORT GetSystemDefaultLCID IN kernel32
	DECLARE SHORT GetUserDefaultLCID IN kernel32
	DECLARE INTEGER GetOEMCP IN kernel32
	DECLARE INTEGER GetACP IN kernel32
	DECLARE INTEGER GetKBCodePage IN user32  
```  
***  


## 函数列表：
[GetACP](../libraries/kernel32/GetACP.md)  
[GetKBCodePage](../libraries/user32/GetKBCodePage.md)  
[GetOEMCP](../libraries/kernel32/GetOEMCP.md)  
[GetSystemDefaultLCID](../libraries/kernel32/GetSystemDefaultLCID.md)  
[GetSystemDefaultLangID](../libraries/kernel32/GetSystemDefaultLangID.md)  
[GetThreadLocale](../libraries/kernel32/GetThreadLocale.md)  
[GetUserDefaultLCID](../libraries/kernel32/GetUserDefaultLCID.md)  
[GetUserDefaultLangID](../libraries/kernel32/GetUserDefaultLangID.md)  
