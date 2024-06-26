**********************************************************************
DEFINE CLASS TestPrinterNamespace as FxuTestCase OF FxuTestCase.prg
**********************************************************************
	#IF .f.
	*
	*  this LOCAL declaration enabled IntelliSense for
	*  the THIS object anywhere in this class
	*
	LOCAL THIS AS TestPrinterNamespace OF TestPrinterNamespace.PRG
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


	function TestPageSetup
		local My as My
		My = newobject('My', 'My.VCX')
		messagebox('Click Cancel')
		llPrinter = My.Computer.Printer.PageSetup()
		This.assertequals('PageSetup returned wrong value', .F., llPrinter)
	endfunc

	function TestAvailablePrinters
		local My as My
		My = newobject('My', 'My.VCX')
		text to lcExpected noshow pretext 2
		SnagIt 8 (SnagIt 8 Printer)
		deskPDF (deskPDF)
		ActiveTouch Document Loader (ActiveTouch Document Loader)
		\\COMPUTER1\HP4000 (HP LaserJet 4000 Series PCL 6)
		\\ssg001\HP LaserJet 4000 Series PCL (HP LaserJet 4000 Series PCL)

		endtext
		lcPrinters = ''
		for each loPrinter in My.Computer.Printer.AvailablePrinters
			lcPrinters = lcPrinters + loPrinter.PrinterName + ' (' + ;
				loPrinter.Driver + ')' + chr(13)
		next loPrinter
		This.assertequals('AvailablePrinters returned wrong value', ;
			lcExpected, lcPrinters)
	endfunc

	function TestDefaultWindowsPrinter
		local My as My
		My = newobject('My', 'My.VCX')
		lcExpected = '\\ssg001\HP LaserJet 4000 Series PCL'
		lcPrinter = My.Computer.Printer.DefaultWindowsPrinter
		This.assertequals('DefaultWindowsPrinter returned wrong value', ;
			lcExpected, lcPrinter)
	endfunc

	function TestDefaultVFPPrinter
		local My as My
		My = newobject('My', 'My.VCX')
		lcExpected = '\\ssg001\HP LaserJet 4000 Series PCL'
		lcPrinter = My.Computer.Printer.DefaultVFPPrinter
		This.assertequals('DefaultVFPPrinter returned wrong value', ;
			lcExpected, lcPrinter)
		My.Computer.Printer.DefaultVFPPrinter = '\\COMPUTER1\HP4000'
		lcPrinter = My.Computer.Printer.DefaultVFPPrinter
		This.assertequals('DefaultVFPPrinter returned wrong value', ;
			'\\COMPUTER1\HP4000', lcPrinter)
		My.Computer.Printer.DefaultVFPPrinter = 'default'
		lcPrinter = My.Computer.Printer.DefaultVFPPrinter
		This.assertequals('DefaultVFPPrinter returned wrong value', ;
			lcExpected, lcPrinter)
	endfunc


**********************************************************************
ENDDEFINE
**********************************************************************
