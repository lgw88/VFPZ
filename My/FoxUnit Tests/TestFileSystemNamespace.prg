**********************************************************************
DEFINE CLASS TestFileSystemNamespace as FxuTestCase OF FxuTestCase.prg
**********************************************************************
	#IF .f.
	*
	*  this LOCAL declaration enabled IntelliSense for
	*  the THIS object anywhere in this class
	*
	LOCAL THIS AS TestFileSystemNamespace OF TestFileSystemNamespace.PRG
	#ENDIF
	
	*  
	*  declare properties here that are used by one or
	*  more individual test methods of this class
	*
	*  for example, if you create an object to a custom
	*  THIS.Property in THIS.Setup(), estabish the property
	*  here, where it will be available (to IntelliSense)
	*  throughout:
	*
*!*		ioObjectToBeTested = .NULL.
*!*		icSetClassLib = SPACE(0)


	* the icTestPrefix property in the base FxuTestCase class defaults
	* to "TEST" (not case sensitive). There is a setting on the interface
	* tab of the options form (accessible via right-clicking on the
	* main FoxUnit form and choosing the options item) labeld as
	* "Load and run only tests with the specified icTestPrefix value in test classes"
	*
	* If this is checked, then only tests in any test class that start with the
	* prefix specified with the icTestPrefix property value will be loaded
	* into FoxUnit and run. You can override this prefix on a per-class basis.
	*
	* This makes it possible to create ancillary methods in your test classes
	* that can be shared amongst other test methods without being run as
	* tests themselves. Additionally, this means you can quickly and easily 
	* disable a test by modifying it and changing it's test prefix from
	* that specified by the icTestPrefix property
	
	* Additionally, you could set this in the INIT() method of your derived class
	* but make sure you dodefault() first. When the option to run only
	* tests with the icTestPrefix specified is checked in the options form,
	* the test classes are actually all instantiated individually to pull
	* the icTestPrefix value.

*!*		icTestPrefix = "<Your preferred prefix here>"
	
	********************************************************************
	FUNCTION Setup
	********************************************************************
	*
	*  put common setup code here -- this method is called
	*  whenever THIS.Run() (inherited method) to run each
	*  of the custom test methods you add, specific test
	*  methods that are not inherited from FoxUnit
	*
	*  do NOT call THIS.Assert..() methods here -- this is
	*  NOT a test method
	*
    *  for example, you can instantiate all the object(s)
    *  you will be testing by the custom test methods of 
    *  this class:
*!*		THIS.icSetClassLib = SET("CLASSLIB")
*!*		SET CLASSLIB TO MyApplicationClassLib.VCX ADDITIVE
*!*		THIS.ioObjectToBeTested = CREATEOBJECT("MyNewClassImWriting")

	********************************************************************
	ENDFUNC
	********************************************************************
	
	********************************************************************
	FUNCTION TearDown
	********************************************************************
	*
	*  put common cleanup code here -- this method is called
	*  whenever THIS.Run() (inherited method) to run each
	*  of the custom test methods you add, specific test
	*  methods that are not inherited from FoxUnit
	*
	*  do NOT call THIS.Assert..() methods here -- this is
	*  NOT a test method
	*
    *  for example, you can release  all the object(s)
    *  you will be testing by the custom test methods of 
    *  this class:
*!*	    THIS.ioObjectToBeTested = .NULL.
*!*		LOCAL lcSetClassLib
*!*		lcSetClassLib = THIS.icSetClassLib
*!*		SET CLASSLIB TO &lcSetClassLib        

	********************************************************************
	ENDFUNC
	********************************************************************	

	*
	*  test methods can use any method name not already used by
	*  the parent FXUTestCase class
	*    MODIFY COMMAND FXUTestCase
	*  DO NOT override any test methods except for the abstract 
	*  test methods Setup() and TearDown(), as described above
	*
	*  the three important inherited methods that you call
	*  from your test methods are:
	*    THIS.AssertTrue("Failure message",<Expression>)
	*    THIS.AssertEquals("Failure message",<ExpectedValue>,<Expression>)
	*    THIS.AssertNotNull("Failure message",<Expression>)
	*  all test methods either pass or fail -- the assertions
	*  either succeed or fail
    
	*
	*  here's a simple AssertNotNull example test method
	*
*!*		*********************************************************************
*!*		FUNCTION TestObjectWasCreated
*!*		*********************************************************************
*!*		THIS.AssertNotNull("Object was not instantiated during Setup()", ;
*!*			               THIS.ioObjectToBeTested)
*!*		*********************************************************************
*!*		ENDFUNC
*!*		*********************************************************************

	*
	*  here's one for AssertTrue
	*
*!*		*********************************************************************
*!*		FUNCTION TestObjectCustomMethod 
*!*		*********************************************************************
*!*		THIS.AssertTrue("Object.CustomMethod() failed", ;
*!*			            THIS.ioObjectToBeTested.CustomMethod())
*!*		*********************************************************************
*!*		ENDFUNC
*!*		*********************************************************************

	*
	*  and one for AssertEquals
	*
*!*		*********************************************************************
*!*		FUNCTION TestObjectCustomMethod100ReturnValue 
*!*		*********************************************************************
*!*
*!*		* Please note that string Comparisons with AssertEquals are
*!*		* case sensitive. 
*!*
*!*		THIS.AssertEquals("Object.CustomMethod100() did not return 'John Smith'", ;
*!*		                "John Smith", ;
*!*			            THIS.ioObjectToBeTested.Object.CustomMethod100())
*!*		*********************************************************************
*!*		ENDFUNC
*!*		*********************************************************************

	function TestGetDirectoryInfo
		local My as My
		My = newobject('My', 'my.vcx')
		loFolder = My.Computer.FileSystem.GetDirectoryInfo(sys(5) + curdir())
		This.Assertequals('GetDirectoryInfo failed', ;
			sys(5) + curdir(), addbs(upper(loFolder.Path)))
	endfunc

	function TestGetDriveInfo
		local My as My
		My = newobject('My', 'my.vcx')
		loDrive = My.Computer.FileSystem.GetDriveInfo('d:')
		This.Assertequals('GetDriveInfo failed', ;
			'NTFS', loDrive.FileSystem)
	endfunc

	function TestGetFileInfo
		local My as My
		My = newobject('My', 'my.vcx')
		loFile = My.Computer.FileSystem.GetFileInfo('d:\ms\my\my.vcx')
		This.Assertequals('GetFileInfo failed', ;
			'D:\MS\MY\MY.VCX', upper(loFile.Path))
	endfunc

	function TestDrives
		local My as My
		My = newobject('My', 'my.vcx')
		loDrives = My.Computer.FileSystem.Drives
		This.Assertequals('Drives failed', 8, loDrives.Count)
	endfunc

	function TestGetShortFileName
		local My as My
		My = newobject('My', 'my.vcx')
		#define HKEY_LOCAL_MACHINE	-2147483646
		loRegistry = newobject('Registry', home() + 'FFC\Registry.vcx')
		lcPath     = ''
		loRegistry.GetRegKey('Path', @lcPath, ;
			'Software\Microsoft\Windows\CurrentVersion\App Paths\hhw.exe', ;
			HKEY_LOCAL_MACHINE)
		lcPath = forcepath('hhc.exe', lcPath)
		lcShortPath = My.Computer.FileSystem.GetShortFileName(lcPath)
		This.Assertequals('GetShortFileNamefailed', ;
			'd:\PROGRA~1\HTMLHE~1\hhc.exe', lcShortPath)
	endfunc

	function TestGetLongFileName
		local My as My
		My = newobject('My', 'my.vcx')
		#define HKEY_LOCAL_MACHINE	-2147483646
		loRegistry = newobject('Registry', home() + 'FFC\Registry.vcx')
		lcPath     = ''
		loRegistry.GetRegKey('Path', @lcPath, ;
			'Software\Microsoft\Windows\CurrentVersion\App Paths\hhw.exe', ;
			HKEY_LOCAL_MACHINE)
		lcPath = forcepath('hhc.exe', lcPath)
		lcLongPath = My.Computer.FileSystem.GetLongFileName('d:\PROGRA~1\HTMLHE~1\hhc.exe')
		This.Assertequals('GetLongFileNamefailed', ;
			lcPath, lcLongPath)
	endfunc

	function TestCopyFile
		local My as My
		My = newobject('My', 'my.vcx')
		lcFile = fullpath('settings.xml')
		lcCopy = addbs(justpath(lcFile)) + 'Copy of ' + justfname(lcFile)
		llCopied = My.Computer.FileSystem.CopyFile(lcFile, lcCopy)
		This.AssertTrue('CopyFile failed', llCopied and file(lcCopy))
		erase (lcCopy)
	endfunc

	function TestMoveFile
		local My as My
		My = newobject('My', 'my.vcx')
		lcFile = fullpath('settings.xml')
		copy file (lcFile) to temp.xml
		lcCopy = forcepath(lcFile, sys(5) + addbs(curdir()) + 'Hold')
		llCopied = My.Computer.FileSystem.MoveFile(lcFile, lcCopy)
		This.AssertTrue('MoveFile failed', llCopied and file(lcCopy) and ;
			not file(lcFile))
		erase (lcCopy)
		copy file temp.xml to (lcFile)
	endfunc

	function TestCopyDirectory
		local My as My
		My = newobject('My', 'my.vcx')
		lcDir  = sys(5) + addbs(curdir()) + 'Hold'
		lcCopy = sys(5) + addbs(curdir()) + 'Temp'
		llCopied = My.Computer.FileSystem.CopyDirectory(lcDir, lcCopy)
		This.AssertTrue('CopyDirectoryfailed', llCopied and ;
			file(lcCopy + '\my.vcx'))
		erase (lcCopy + '\*.*')
		rd (lcCopy)
	endfunc

	function TestMoveDirectory
		local My as My
		My = newobject('My', 'my.vcx')
		lcDir  = sys(5) + addbs(curdir()) + 'Hold'
		lcCopy = sys(5) + addbs(curdir()) + 'Temp'
		llCopied = My.Computer.FileSystem.MoveDirectory(lcDir, lcCopy)
		This.AssertTrue('MoveDirectoryfailed', llCopied and ;
			file(lcCopy + '\my.vcx') and not directory(lcDir))
		md (lcDir)
		copy file (lcCopy + '\*.*') to (lcDir + '\*.*')
		erase (lcCopy + '\*.*')
		rd (lcCopy)
	endfunc

**********************************************************************
ENDDEFINE
**********************************************************************
