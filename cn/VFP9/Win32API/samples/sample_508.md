[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 复制文件时显示标准进度对话框
_翻译:xinjie  2021.01.01_

## 简述：
如果您曾考虑过淘汰老化的VFP命令COPY FILE和RENAME，请尝试使用此代码。

SHFileOperation复制，删除和移动一个或多个文件。 fFlags成员可以采用的各种标志提供了极大的灵活性。 例如，在单个SHFileOperation调用中，一组文件不仅可以复制到一个目标，还可以复制到多个目标。 该过程伴随着熟悉的OS对话框，该对话框显示进度或在即将替换现有文件时发送提醒。
***  


## 开始之前：
如果您一直在考虑淘汰老化的VFP命令COPY FILE和RENAME，请尝试使用此代码。 

![](../images/copyfilewithprogress.png)  

参考：

* [如何删除非空目录](sample_541.md)  
  
***  


## 代码：
```foxpro  
LOCAL oForm As Explorer
oForm = CREATEOBJECT("Explorer")
oForm.Visible=.T.
READ EVENTS
* 主程序结束

DEFINE CLASS Explorer As Form
	Width=500
	Height=300
	BorderStyle=2
	AutoCenter=.T.
	Caption="在 ListView 控件上拖放文件"
	ShowWindow=2
	defaultpath="c:\temp"  && replace with valid name

	ADD OBJECT lst As TListView WITH;
	Left=5, Top=35, Width=490, Height=250

	ADD OBJECT Label1 As TLabel WITH;
	Left=7, Top=7, Caption="地址:"
	
	ADD OBJECT txtFolder As TextBox WITH;
	Left=60, Top=5, Width=410, ControlSource="THIS.Parent.defaultpath"

	ADD OBJECT cmdFolder As CommandButton WITH;
	Left=470, Top=4, Width=24, Height=24, Caption=".."

PROCEDURE Init
	DECLARE STRING StrFormatByteSizeA IN Shlwapi;
		INTEGER dw, STRING @pszBuf, INTEGER cchBuf

	= BINDEVENT(THIS.cmdFolder, "Click", THIS, "GetFolder")
	THIS.populatelist(THIS.defaultpath)

PROCEDURE Destroy
	CLEAR EVENTS

PROCEDURE defaultpath_ASSIGN(cPath)
	IF THIS.PopulateList(@m.cPath)
		THIS.defaultpath = m.cPath
		THIS.Refresh
	ENDIF

PROTECTED PROCEDURE GetFolder
	LOCAL cStoredPath, cPath
	cStoredPath = SYS(5) + SYS(2003)
	cPath = GETDIR(THIS.defaultpath, "文件夹:", "选择文件夹")
	SET DEFAULT TO (m.cStoredPath)
	IF NOT EMPTY(m.cPath)
		THIS.defaultpath = m.cPath
	ENDIF

PROCEDURE lst.OLEDragDrop
LPARAMETERS oDataObject, nEffect, nButton, nShift, nXCoord, nYCoord
	THIS.Parent.onlist_oledragdrop(@oDataObject)

PROCEDURE onlist_oledragdrop
PARAMETERS oDataObject
	LOCAL oShell As SHFileOperation, oFiles, oFile
	
	oShell = CREATEOBJECT("SHFileOperation", THIS.HWnd)

	oFiles = oDataObject.Files
	FOR EACH oFile IN oFiles
		oShell.AddSourceFile(m.oFile)
	NEXT
	
	WITH oShell
		.TargetFolder = THIS.defaultpath
		.CopyFiles
		THIS.populatelist(THIS.defaultpath)
		
		IF .Aborted
			= MESSAGEBOX("该操作已被用户中止。     ", 64, "被用户取消")
		ENDIF
	ENDWITH

PROTECTED PROCEDURE PopulateList(cPath)
	cPath = ALLTRIM(m.cPath)
	THIS.lst.ListItems.Clear
	
	LOCAL nCount, nIndex, oItem

	nCount = ADIR(arrListOfFiles, m.cPath + "\*.*", "D", 1)
	FOR nIndex=1 TO nCount
		IF arrListOfFiles[nIndex, 1] = "."
			LOOP
		ENDIF
		
		IF DIRECTORY(m.cPath + "\" + arrListOfFiles[nIndex, 1])
			oItem = THIS.lst.ListItems.Add(,,arrListOfFiles[nIndex, 1])
			WITH oItem
				.Bold=1
				.Subitems(1) = "Folder"
				.Subitems(2) = DTOC(arrListOfFiles[nIndex, 3]) +;
					" " + arrListOfFiles[nIndex, 4]
			ENDWITH
		ENDIF
	NEXT
	RELEASE arrListOfFiles

	nCount = ADIR(arrListOfFiles, m.cPath + "\*.*", "A", 1)
	FOR nIndex=1 TO nCount
		IF NOT DIRECTORY(m.cPath + "\" + arrListOfFiles[nIndex, 1])
			oItem = THIS.lst.ListItems.Add(,,arrListOfFiles[nIndex, 1])
			WITH oItem
				.Subitems(1) = THIS.FormatFilesize(arrListOfFiles[nIndex, 2])
				.Subitems(2) = DTOC(arrListOfFiles[nIndex, 3]) +;
					" " + arrListOfFiles[nIndex, 4]
			ENDWITH
		ENDIF
	NEXT
	RELEASE arrListOfFiles

PROTECTED PROCEDURE FormatFilesize(nSize)
	LOCAL cBuffer
	cBuffer = REPLICATE(CHR(0), 128)
	= StrFormatByteSizeA(m.nSize, @cBuffer, LEN(m.cBuffer))
RETURN STRTRAN(m.cBuffer, CHR(0), "")

ENDDEFINE

DEFINE CLASS TLabel As Label
	Autosize=.T.
	BackStyle=0
ENDDEFINE

DEFINE CLASS TListView As OleControl
	OleClass="MSComctlLib.ListViewCtrl"

PROCEDURE Init
	WITH THIS
		.View=3
		.Appearance=0
		.BorderStyle=1
		.OleDropMode=1  && manual
		.Arrange=0
		.LabelEdit=1
		.FullRowSelect=0
		.AddColumnHeader("Name", 210)
		.AddColumnHeader("Size", 100)
		.AddColumnHeader("Modified", 160)
	ENDWITH

PROTECTED PROCEDURE AddColumnHeader(cCaption, nWidth)
	WITH THIS.ColumnHeaders.Add()
		.Text=cCaption
		.Width=nWidth
	ENDWITH
ENDDEFINE

DEFINE CLASS SHFileOperation As Custom
#DEFINE FO_MOVE 1
#DEFINE FO_COPY 2
#DEFINE FO_DELETE 3
#DEFINE FO_RENAME 4
#DEFINE FOF_ALLOWUNDO 64
	hwnd=0
	OperationMode=0
	SourceFiles=""
	TargetFolder=""
	OperationFlags=0
	errorcode=0
	aborted=.F.

PROCEDURE Init(hWindow)
	THIS.hwnd = m.hWindow

PROCEDURE AddSourceFile(cFilename)
	THIS.SourceFiles = THIS.SourceFiles + m.cFilename + CHR(0)

PROCEDURE CopyFiles
	THIS.DoVerb(FO_COPY, FOF_ALLOWUNDO)

PROCEDURE MoveFiles
	THIS.DoVerb(FO_MOVE, FOF_ALLOWUNDO)

PROCEDURE DeleteFiles
	THIS.DoVerb(FO_DELETE, FOF_ALLOWUNDO)

PROCEDURE DoVerb(nOperatioMode, nFlags)
	DECLARE INTEGER SHFileOperation IN Shell32 STRING @lpFileOp

	THIS.OperationMode = m.nOperatioMode

	IF VARTYPE(m.nFlags)="N"
		THIS.OperationFlags = m.nFlags
	ENDIF

	LOCAL cBuffer, oFrom, oTo

	oFrom = CREATEOBJECT("PChar", THIS.SourceFiles)

	IF NOT EMPTY(THIS.TargetFolder)
		oTo = CREATEOBJECT("PChar", THIS.TargetFolder)
	ENDIF

	cBuffer = num2dword(THIS.hwnd) +;
		num2dword(THIS.OperationMode) +;
		num2dword(oFrom.GetAddr()) +;
		num2dword(IIF(EMPTY(THIS.TargetFolder), 0, oTo.GetAddr())) +;
		num2word(THIS.OperationFlags) +;
		num2word(0) +;
		num2dword(0) + num2dword(0)

	THIS.errorcode = SHFileOperation(@cBuffer)
	THIS.aborted = (buf2word(SUBSTR(cBuffer, 19, 2)) <> 0)

ENDDEFINE

FUNCTION buf2word(lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
       Asc(SUBSTR(lcBuffer, 2,1)) * 256

FUNCTION num2word(lnValue)
RETURN Chr(MOD(m.lnValue,256)) + CHR(INT(m.lnValue/256))

FUNCTION num2dword(lnValue)
#DEFINE m0 0x0000100
#DEFINE m1 0x0010000
#DEFINE m2 0x1000000
	IF lnValue < 0
		lnValue = 0x100000000 + lnValue
	ENDIF
	LOCAL b0, b1, b2, b3
	b3 = Int(lnValue/m2)
	b2 = Int((lnValue - b3*m2)/m1)
	b1 = Int((lnValue - b3*m2 - b2*m1)/m0)
	b0 = Mod(lnValue, m0)
RETURN Chr(b0)+Chr(b1)+Chr(b2)+Chr(b3)

FUNCTION buf2dword(cBuffer)
RETURN Asc(SUBSTR(cBuffer, 1,1)) + ;
	BitLShift(Asc(SUBSTR(cBuffer, 2,1)),  8) +;
	BitLShift(Asc(SUBSTR(cBuffer, 3,1)), 16) +;
	BitLShift(Asc(SUBSTR(cBuffer, 4,1)), 24)

DEFINE CLASS PChar As Session
PROTECTED hMem

PROCEDURE Init(lcString)
	THIS.hMem = 0
	THIS.setValue(lcString)

PROCEDURE Destroy
	THIS.ReleaseString

FUNCTION GetAddr
RETURN THIS.hMem

FUNCTION GetValue
	LOCAL lnSize, lcBuffer
	lnSize = THIS.getAllocSize()
	lcBuffer = SPACE(lnSize)

	IF THIS.hMem <> 0
		DECLARE RtlMoveMemory IN kernel32 As MemToStr;
			STRING @, INTEGER, INTEGER
		= MemToStr(@lcBuffer, THIS.hMem, lnSize)
	ENDIF
RETURN lcBuffer

FUNCTION GetAllocSize
	DECLARE INTEGER GlobalSize IN kernel32 INTEGER hMem
RETURN Iif(THIS.hMem=0, 0, GlobalSize(THIS.hMem))

PROCEDURE SetValue(lcString)
#DEFINE GMEM_FIXED 0
	THIS.ReleaseString

	DECLARE INTEGER GlobalAlloc IN kernel32 INTEGER, INTEGER
	DECLARE RtlMoveMemory IN kernel32 As StrToMem;
		INTEGER, STRING @, INTEGER

	LOCAL lnSize
	lcString = lcString + Chr(0)
	lnSize = Len(lcString)
	THIS.hMem = GlobalAlloc(GMEM_FIXED, lnSize)
	IF THIS.hMem <> 0
		= StrToMem(THIS.hMem, @lcString, lnSize)
	ENDIF

PROCEDURE ReleaseString
	IF THIS.hMem <> 0
		DECLARE INTEGER GlobalFree IN kernel32 INTEGER
		= GlobalFree (THIS.hMem)
		THIS.hMem = 0
	ENDIF
ENDDEFINE  
```  
***  


## 函数列表：
[GlobalAlloc](../libraries/kernel32/GlobalAlloc.md)  
[GlobalFree](../libraries/kernel32/GlobalFree.md)  
[GlobalSize](../libraries/kernel32/GlobalSize.md)  
[SHFileOperation](../libraries/shell32/SHFileOperation.md)  

## 备注：
SHFileOperation 复制，删除和移动一个或多个文件。 它需要一个指向SHFILEOPSTRUCT结构的参数。 在调用函数之前，必须先填充该结构。
  
大多数 SHFILEOPSTRUCT 成员易于填充，但可能是 *pFrom* 和 *pTo*，因为它们是指向字符串的指针，而 VFP 中不直接支持此类对象。 代码内部的 PChar 类处理字符串指针。 它分配和释放内存块，并在 VFP 字符串和内存中的地址之间移动数据。
  
*fFlags* 成员可以采用的各种标志提供了极大的灵活性。 例如，在单个 SHFileOperation 调用中，一组文件不仅可以复制到一个目标，还可以复制到多个目标。 该过程伴随着熟悉的OS对话框，该对话框显示进度或在即将替换现有文件时发送提醒。
  
* * *  
Shell 一如既往的简短高效。以下代码将源文件夹中的所有文件复制到目标文件夹中。谨慎测试： 
  
```foxpro
LOCAL oShell, oSrcFolder, oDstFolder  
  
oShell = CREATEOBJECT("Shell.Application")  
oSrcFolder = oShell.NameSpace("c:\temp1")  
oDstFolder = oShell.NameSpace("c:\temp")  
  
IF VARTYPE(oDstFolder)="O" AND VARTYPE(oSrcFolder.Items)="O"  
	oDstFolder.CopyHere(oSrcFolder.Items)  
ENDIF
```

***  

