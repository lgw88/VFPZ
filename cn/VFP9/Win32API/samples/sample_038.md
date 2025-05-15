[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 读取和设置当前进程的显式应用程序用户模型 ID （Win7）

## 请注意，本文件中包含一些与旧的news2news网站的链接，该网站目前无法使用。这些材料将在今后某个时候提供。


## 开始之前：
应用程序用户模型ID([AppUserModelIDs](http://msdn.microsoft.com/en-us/library/dd378459(v=vs.85).aspx))被[Windows 7中的任务栏](http://windows.microsoft.com/en-CA/windows7/products/features/windows-taskbar)（译者注：链接已失效）和更高版本的系统广泛使用，用于将进程、文件和窗口与特定应用程序关联起来。  

![](../images/jumplistvfp.png)  


参考：

* [访问 Windows 最近文档的列表](sample_094.md)  
  
***  


## 代码：
```foxpro  
LOCAL oAppUserModel As AppUserModel

oAppUserModel = CREATEOBJECT("AppUserModel")
? "[" + oAppUserModel.AppID + "]"

oAppUserModel.AppID = "VFP.MyApplication.MainForm"
? "[" + oAppUserModel.AppID + "]"

* 主程序结束

DEFINE CLASS AppUserModel As Custom
* 实现对应用程序用户模型ID(AppUserModelID)的访问，该ID将当前进程标识到任务栏上。

	AppID=""
	ErrorCode=0

PROCEDURE Init( cAppID As String )
	IF VAL(OS(3))*10 + VAL(OS(4)) < 61
		WAIT WINDOW "最低支持的操作系统。Win7 !" TIMEOUT 10
		RETURN .F.
	ENDIF

	THIS.declare
	IF NOT EMPTY(m.cAppID)
		THIS.AppID = m.cAppID
	ENDIF

PROCEDURE AppID_ASSIGN(vValue As Variant)
	LOCAL cAppID
	cAppID = TRANSFORM(m.vValue)

	* 注：转为Unicode
	THIS.ErrorCode = API_SetAppID(;
		STRCONV(m.cAppID,5) )

	IF THIS.ErrorCode = 0
	* 您可能需要隐藏和显示VFP主窗口以刷新其跳转列表
		THIS.AppID = m.cAppID
	ENDIF

PROCEDURE AppID_ACCESS() As String
	LOCAL hAppID, cAppID, nBufSize

	hAppID=0
	THIS.ErrorCode = API_GetAppID( @hAppID )
	
	IF THIS.ErrorCode = 0
		nBufSize = GlobalSize( m.hAppID )
		cAppID = REPLICATE( CHR(0), nBufSize )
		MemToStr( @cAppID, hAppId, nBufSize )
		
		* 注：由Unicode转换而来
		nBufSize = AT(CHR(0)+CHR(0), m.cAppID)
		IF nBufSize > 0
			cAppID = STRCONV(SUBSTR(m.cAppID, 1,;
				m.nBufSize), 6)
		ENDIF
	ELSE
		cAppID = ""
	ENDIF

	IF hAppId <> 0
		= CoTaskMemFree( hAppId )
	ENDIF
RETURN m.cAppID

PROCEDURE declare
	DECLARE INTEGER GlobalSize IN kernel32 INTEGER hMem
	DECLARE CoTaskMemFree IN Ole32 INTEGER hMem

	DECLARE RtlMoveMemory IN kernel32 As MemToStr;
		STRING @, INTEGER, INTEGER

	DECLARE SHORT GetCurrentProcessExplicitAppUserModelID IN Shell32;
	AS API_GetAppID;
		INTEGER @AppID

	DECLARE SHORT SetCurrentProcessExplicitAppUserModelID IN Shell32;
	AS API_SetAppID;
		STRING AppID

ENDDEFINE  
```  
***  


## 函数列表：
[CoTaskMemFree](../libraries/ole32/CoTaskMemFree.md)  
[GlobalSize](../libraries/kernel32/GlobalSize.md)  

## Comment:
阅读MSDN上的<a href="http://msdn.microsoft.com/en-us/library/dd378459(v=vs.85).aspx">应用程序用户模型ID </a>文章。
  
旧版应用程序不声明显式AppUserModelID。 在这种情况下，系统将使用一系列试探法来分配内部AppUserModelID。 应用程序无法检索系统分配的AppUserModelID。
  
如果应用程序使用显式AppUserModelID，则它还必须为所有正在运行的窗口或进程，快捷方式和文件关联分配相同的AppUserModelID。 在通过ICustomDestinationList自定义其跳转列表时以及在对SHAddToRecentDocs的任何调用中，它还必须使用该AppUserModelID。 
  
* * *  
最好在主应用窗口显示之前创建一个明确的应用ID，当VFP主窗口出现在屏幕上时，系统已经为这个VFP实例分配了默认的应用ID。当VFP主窗口出现在屏幕上时，系统已经为这个VFP实例分配了一个默认的应用程序ID。 
  
设置显式应用ID后，隐藏并重新显示VFP主窗口。这样就会刷新附着在VFP任务栏图标上的跳转列表。就这么简单：
```foxpro
_screen.Visible = .F.  
_screen.Visible = .T.
```
另一种选择是在 VFP 配置文件中使用 SCREEN=OFF 和 COMMAND 设置。COMMAND 应该启动一个程序，设置应用程序ID，然后打开主窗口。 
  
* * *  
<!-- Anatoliy -->
为单个VFP顶层表单设置应用ID，需要访问[IPropertyStore](http://msdn.microsoft.com/en-us/library/bb761474(v=vs.85).aspx)接口。显然，只有通过编写一个外部库才能完成。这种FLL的一个片段显示在这个代码示例的<a href="?example=38&ver=vcpp">C++部分</a>中。   
  
* * *  
如果一个窗口拥有一个显式的应用程序ID，用这个窗口句柄和属性名"{9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}调用GetProp。5 "返回有效的数据句柄（IPropertyStore ?）。  
  
***  

