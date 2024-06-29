Lparameters tlOnlyRegister As Logical, tcOptionalIniFileName As Character, tcInternalCaller as Character

If Not tlOnlyRegister And Type("_TAB.CLASS")=="C"
	*-- Use Tabbing Navigation
	_Tab.Next()
Else
	*-- Create Manager
	Local lcCaller as Character
	lcCaller = Evl(tcInternalCaller,Sys(16,Program(-1)))	 
	Createobject("TabbingNavigationManager",lcCaller,tlOnlyRegister,tcOptionalIniFileName)
Endif

*-- Exit Programm
Return .T.

Define Class TabbingNavigationManager As Session
	*-- FileName of calling programm
	cCallerProgram = ""
	*-- FileName of configuration 
	cIniFileName = "TabbingNavigation.ini"
	*-- Keyboard Shortcut of calling TabForm
	cKey = "Ctrl+Tab"
	*-- UI
	cFontName = "Arial"
	*-- Window
	oTabForm = Null
	
	Procedure oTabForm_Access() as TabForm
		If Not Type("This.oTabForm.Class") == "C"
			This.CreateWindow()
		EndIf

		Return This.oTabForm
	EndProc

	Procedure LoadConfiguration(tcOptionalIniFileName as Character) as Void
		*-- Get Config FileName
		This.cIniFileName = Evl(tcOptionalIniFileName, This.cIniFileName)
		*-- Read Key
		This.cKey = This.GetIniString("General","Key",this.cKey)
		*-- Font
		This.cFontName = This.GetIniString("UserInterface","FontName",this.cFontName)
	EndProc
	
	Procedure Register() as VOID
		Public _Tab As TabbingNavigationManager
		_Tab = This

		Local lcExec as Character
		lcExec = 'ExecScript(Iif(Type("_TAB.Class")=="C","_TAB.Next()","Do ['+this.cCallerProgram+'] With .F.,['+this.cIniFileName+'],['+this.cCallerProgram+']"))' 

		Local lcKey as Character
		lcKey = This.cKey 
		On Key Label &lcKey &lcExec 
	EndProc

	Procedure CollectWindows() as Collection
		*-- Check window
		Local loForm As Form
		loForm = Createobject("Form")

		*-- Create Windows Collection
		Local loWindows As Collection
		loWindows = Createobject("Collection")

		*-- Get TabForm Handle
		Local lnNextHWND As Integer
		lnNextHWND = GetWindow(loForm.HWnd,2)
		Local lcCaption As Character, lcSourceFile as Character
		Local laEnv[25]
		Local loWinInfo as WindowInformation
		
		*-- Get All Windows
		Do While lnNextHWND<>0
			lcCaption = Replicate(" ",250)
			GetWindowText(lnNextHWND,@lcCaption,Len(lcCaption))
			lcCaption = Alltrim(Chrtran(lcCaption,Chr(0)+Chr(13)+Chr(10),''))
			If Not Empty(lcCaption)
				loWinInfo = CreateObject("WindowInformation")
				loWinInfo.nHWND = lnNextHWND
				loWinInfo.cTitle = lcCaption 
				
*!*					try
*!*						_EdGetEnv( lnNextHWND, @laEnv )
*!*						loWinInfo.cSource = laEnv[1]
*!*					Catch
*!*						*-- NOP
*!*					EndTry
	
				loWindows.Add(loWinInfo)
			Endif
			lnNextHWND = GetWindow(lnNextHWND,2)
		Enddo

		*-- Cleanup Counter Form
		loForm.Release()
		
		*-- Return Collection
		Return loWindows 
	EndProc
	
	Procedure CreateWindow()
		*-- Get ClientWindows
		Local loWindows as Collection
		loWindows = This.CollectWindows()

		*-- Create Tab Form
		This.oTabForm = Newobject("TabForm","TabControl.vcx")
		This.oTabForm.SetWindows(loWindows)
		This.oTabForm.CheckKeyboardTimer.Enabled = .T.
		This.oTabForm.AutoCenter = .T.
		
		*-- Show Windows
		This.oTabForm.Show()
	EndProc
	
	Procedure Init(tcCallerProgram as Character,tlOptionalOnlyRegister As Logical, tcOptionalIniFileName As Character)
		*-- Get Caller
		this.cCallerProgram = tcCallerProgram
		*-- Use different configuration
		This.cIniFileName = Evl(tcOptionalIniFileName,ForcePath(This.cIniFileName,Addbs(JustPath(tcCallerProgram))))
		*-- Sys Function
		This.DeclareSysFunctions()
		*-- Read config file
		This.LoadConfiguration()
		*-- Register APP/PRG
		This.Register()

		If Not tlOptionalOnlyRegister
			*-- Create Window
			This.Next()
		EndIf
	Endproc

	Procedure DeclareSysFunctions() As VOID
		*-- Sys Function
		Declare Integer GetWindow In Win32API Integer, Integer
		Declare Integer GetWindowText In Win32API Integer, String @lcCaption, Integer
		Declare Integer GetKeyState In Win32API Integer
		Declare Integer GetPrivateProfileString In kernel32;
			STRING   lpAppName,;
			STRING   lpKeyName,;
			STRING   lpDefault,;
			STRING @ lpReturnedString,;
			INTEGER  nSize,;
			STRING   lpFileName

		*-- Add FoxTools
		If not "FOXTOOLS.FLL" $ Upper(Set("Library"))
			Set Library to (Home()+"FoxTools.Fll") Additive
		Endif
	EndProc

	Procedure GetIniString(tcSection As Character,tcKey As Character,tcDefault As Character) As Character
		*-- Default
		tcSection = Evl(tcSection,"")
		tcDefault = Evl(tcDefault,"")

		*-- Return Value	
		Local lcString as Character
		lcString=Replicate(" ",200)
		If File(this.cIniFileName) 
			*-- get value
			GetPrivateProfileString(tcSection,tcKey,tcDefault,@lcString,Len(lcString),this.cIniFileName)
			lcString=Left(lcString,At(Chr(0),lcString)-1)
		EndIf
		lcString = Evl(lcString,tcDefault)   
		
		Return lcString
	EndProc
	
	Procedure Next() as VOID
		This.oTabForm.Next()
	EndProc

	Procedure Previous() as VOID
		This.oTabForm.Prev()
	EndProc
	
EndDefine

Define Class WindowInformation as Session
	nHWND = 0
	cTitle = ""
	cSource = ""
EndDefine


