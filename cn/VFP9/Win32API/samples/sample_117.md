[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 监视目录中的更改

_翻译：xinjie  2020.01.29_

## 请注意，本文档包含一些指向旧版 news2news 网站的链接，这些链接目前无法使用。 该材料将在未来的某个时间提供。

## 开始之前：
想象一下，应用程序需要在特定目录中的文件更改时收到通知：添加或删除、更改或访问文件。 ChangeNotification 函数就是一个答案。

启动此代码示例后，尝试添加、更改或删除目标目录中的文件（必须是有效路径）。 在其中创建一个 FoxPro 表并对其记录进行操作。

参看：

<!-- Anatoliy -->
* [用于 Visual FoxPro 的 FileSystemWatcher ActiveX 控件](?solution=8)   
* [监视目录中发生的更改](sample_400.md)  
* [枚举在网络上打开的文件](sample_121.md)  
  
***  


## 代码：
```foxpro  
PUBLIC oForm
oForm = CREATEOBJECT("Tform", SYS(2023)) && watching TEMP dir
oForm.Visible = .T.
* 主程序结束

DEFINE CLASS Tform As Form
#DEFINE FILE_NOTIFY_CHANGE_FILE_NAME 1
#DEFINE FILE_NOTIFY_CHANGE_DIR_NAME 2
#DEFINE FILE_NOTIFY_CHANGE_ATTRIBUTES 4
#DEFINE FILE_NOTIFY_CHANGE_SIZE 8
#DEFINE FILE_NOTIFY_CHANGE_LAST_WRITE 16
#DEFINE FILE_NOTIFY_CHANGE_LAST_ACCESS 32
#DEFINE FILE_NOTIFY_CHANGE_CREATION 64
#DEFINE FILE_NOTIFY_CHANGE_SECURITY 128
#DEFINE INVALID_HANDLE_VALUE -1
#DEFINE WAIT_OBJECT_0 0
#DEFINE WATCHING_INTERVAL 1000  && milliseconds

PROTECTED hNotify, PathBeingWatched

	Width=400
	Height=150
	MaxButton=.F.
	BorderStyle=2
	AutoCenter=.T.
	Caption="Watching directory"

	hNotify=INVALID_HANDLE_VALUE
	PathBeingWatched=""
	
	ADD OBJECT lblTarget As Label WITH Left=10, Top=7, Autosize=.T.
	ADD OBJECT tm As Timer WITH Interval=0

	ADD OBJECT lblAlert As Label WITH Left=10, Top=30,;
	Autosize=.T., Caption="Notification:"

FUNCTION Init(cPath)
	THIS.declare
	THIS.PathBeingWatched = FULLPATH(m.cPath)

	IF Not THIS.StartWatching()
		= MESSAGEBOX("Notification handle error.")
		RETURN .F.
	ENDIF

PROCEDURE Destroy
	THIS.StopWatching

PROTECTED FUNCTION StartWatching
	LOCAL lResult

	* 没有监视子目录
	THIS.hNotify = FindFirstChangeNotification(;
		THIS.PathBeingWatched, 0,;
		FILE_NOTIFY_CHANGE_FILE_NAME +;
		FILE_NOTIFY_CHANGE_LAST_WRITE )

	lResult = (THIS.hNotify <> INVALID_HANDLE_VALUE)

	IF lResult
		THIS.lblTarget.Caption = "Watched: " +;
			THIS.PathBeingWatched
		THIS.tm.Interval = WATCHING_INTERVAL
	ENDIF
RETURN  lResult

PROTECTED PROCEDURE ContinueWatching
	IF FindNextChangeNotification(THIS.hNotify) = 0
		THIS.StopWatching
		= MESSAGEBOX("Request error.")
		THIS.Release
	ENDIF
	THIS.tm.Interval = WATCHING_INTERVAL

PROTECTED FUNCTION StopWatching
	THIS.tm.Interval = 0
	IF THIS.hNotify <> INVALID_HANDLE_VALUE
		= FindCloseChangeNotification(THIS.hNotify)
	ENDIF

FUNCTION _signaled		&& 返回信号状态
RETURN (WaitForSingleObject(THIS.hNotify, 0) = WAIT_OBJECT_0)

PROCEDURE _notify		&& 触发事件
	LOCAL cMessage
	cMessage = "Notification: " + TTOC(DATETIME())
	THIS.lblAlert.Caption = cMessage
	ACTIVATE SCREEN
	? cMessage
	THIS.ContinueWatching

PROCEDURE tm.Timer
	IF ThisForm._signaled()
		ThisForm._notify
	ENDIF

PROTECTED PROCEDURE declare
	DECLARE SHORT FindNextChangeNotification IN kernel32;
		INTEGER hChangeHandle

	DECLARE SHORT FindCloseChangeNotification IN kernel32;
		INTEGER hChangeHandle

	DECLARE INTEGER FindFirstChangeNotification IN kernel32;
		STRING lpPathName, INTEGER bWatchSubtree,;
		INTEGER dwNotifyFilter

	DECLARE INTEGER WaitForSingleObject IN kernel32;
		INTEGER hHandle, INTEGER dwMilliseconds

ENDDEFINE  
```  
***  


## 函数列表：
[FindCloseChangeNotification](../libraries/kernel32/FindCloseChangeNotification.md)  
[FindFirstChangeNotification](../libraries/kernel32/FindFirstChangeNotification.md)  
[FindNextChangeNotification](../libraries/kernel32/FindNextChangeNotification.md)  
[WaitForSingleObject](../libraries/kernel32/WaitForSingleObject.md)  
