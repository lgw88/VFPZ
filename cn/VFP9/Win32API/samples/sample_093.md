[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 ShellExecute 对文件进行操作
_翻译：xinjie  2020.12.31_

## 开始之前
在测试这段代码之前，请选择有效的文件和目录名。 

您可能感兴趣的其他代码样本：  
* [在 VFP 中使用 WinExec 启动外部应用程序](sample_002.md)  
* [通过使用 CreateProcess 从 VFP 应用程序启动可执行文件](sample_003.md)  
* [从 VFP 启动外部程序并等待其终止](sample_377.md)  
* [如何以其他用户的身份启动进程(NT/XP/2K))](sample_426.md)  
  
***  


## 代码：
```foxpro  
#DEFINE SW_SHOWNORMAL 1
#DEFINE SW_SHOWMINIMIZED 2
#DEFINE SW_SHOWMAXIMIZED 3

	DECLARE INTEGER GetSystemDirectory IN kernel32;
		STRING @lpBuffer, INTEGER nSize

	DECLARE INTEGER ShellExecute IN shell32;
		INTEGER hWindow, STRING lpOperation,;
		STRING lpFile, STRING lpParameters,;
		STRING lpDirectory, INTEGER nShowCmd

	* 打开数据文件及其相关应用程序
*	= ShellExecute(0, "open", "c:\aa\index.mdb", "", "", SW_SHOWMAXIMIZED)
*	= ShellExecute(0, "open", "c:\aa\aa.bmp", "", "", SW_SHOWMAXIMIZED)
*	= ShellExecute(0, "open", "c:\aa\lacrymosa.mp3", "", "", SW_SHOWMAXIMIZED)
*	= ShellExecute(0, "open", "c:\aa\mkart.doc", "", "", SW_SHOWMAXIMIZED)
*	= ShellExecute(0, "open", "c:\aa\aa.txt", "", "", SW_SHOWMAXIMIZED)

	* 打开一个目录
*	= ShellExecute(0, "explore", "c:\Temp", "", "", SW_SHOWMAXIMIZED)

	* 打开从指定目录开始的搜索窗口
*	= ShellExecute(0, "find", "", "", getSysDir(), SW_SHOWMAXIMIZED)
	
	* 使用相关应用程序打印文本文件
*	= ShellExecute(0, "print", "c:\aa\index.txt", "", "", SW_SHOWMAXIMIZED)

	* 访问互联网上的某个网站
*	= ShellExecute(0, "open", "http://www.microsoft.com/",;
*		"", "", SW_SHOWMAXIMIZED)

	* 发送电子邮件
	* Mike Lewis, http://www.ml-consult.demon.co.uk/foxst-22.htm

	LOCAL lcMail
	lcMail = "mailto:buddy1@somwhere.com" +;
		"?CC=buddy2@somwhere.com&Subject=Meet for lunch" +;
		"&Body=Please join me for a sandwich at noon."

	= ShellExecute(0, "open", lcMail, "", "", SW_SHOWNORMAL)
	
FUNCTION GetSysDir
	lpBuffer = SPACE(250)
	nSizeRet = GetSystemDirectory(@lpBuffer, Len(lpBuffer))
RETURN SUBSTR(lpBuffer, 1, nSizeRet)  
```  
***  


## 函数列表：
[GetSystemDirectory](../libraries/kernel32/GetSystemDirectory.md)  
[ShellExecute](../libraries/shell32/ShellExecute.md)  

## 备注
还有另一种操作类型-编辑。
  
对于某些失败的操作，GetLastError() 返回值1155，这意味着 ERROR_NO_ASSOCIATION |没有应用程序与此操作指定的文件关联。 
  
链接： 

* [HOWTO: 使用 ShellExecute 来启动关联文件（32位） (Q170918)](https://jeffpar.github.io/kbarchive/kb/170/Q170918/).  
* [技巧168: 使用 ShellExecute 函数打印文件](http://www.visualbasicsource.net/redirectpage.html?http://www.visualbasicsource.net/VBTips/168.html).  
* [从Visual FoxPro应用程序发送邮件的简单方法](http://www.ml-consult.co.uk/foxst-22.htm) -- an article of Mike Lewis.  
* VBNet: [通过 ShellExecute 发送大型电子邮件](http://www.mvps.org/vbnet/index.html?code/internet/shellexecutelargeemail.htm).  
  

  
***  

