**********************************************************************
DEFINE CLASS TestSettingsNamespace as FxuTestCase OF FxuTestCase.prg
**********************************************************************
	#IF .f.
	*
	*  this LOCAL declaration enabled IntelliSense for
	*  the THIS object anywhere in this class
	*
	LOCAL THIS AS TestSettingsNamespace OF TestSettingsNamespace.PRG
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


	function TestAdd
		local My as My
		My = newobject('My', 'my.vcx')
		My.Settings.Add('Test', 'Value')
		This.Asserttrue('Add failed', type('My.Settings.Test') = 'C' and ;
			My.Settings.Test = 'Value')
	endfunc

	function TestSave
		local My as My
		My = newobject('My', 'my.vcx')
		My.Settings.Add('Test1', 'Value')
		My.Settings.Add('Test2', 25)
		My.Settings.Add('Test3', .T.)
		My.Settings.Add('Test4', .F.)
		My.Settings.Add('Test5', 17.56)
		My.Settings.Add('Test6', cast(30.02 as Y))
		My.Settings.Save('test.xml')
		text to lcXML noshow
<?xml version="1.0" encoding="utf-8"?>
<SettingsFile xmlns="http://schemas.microsoft.com/VisualStudio/2004/01/settings" CurrentProfile="(Default)" GeneratedClassNamespace="" GeneratedClassName="Settings">
	<Profiles/>
	<Settings>
		<Setting Name="Test1" Type="System.String" Scope="User">
			<Value Profile="(Default)">Value</Value>
		</Setting>
		<Setting Name="Test2" Type="System.Integer" Scope="User">
			<Value Profile="(Default)">25</Value>
		</Setting>
		<Setting Name="Test3" Type="System.Boolean" Scope="User">
			<Value Profile="(Default)">True</Value>
		</Setting>
		<Setting Name="Test4" Type="System.Boolean" Scope="User">
			<Value Profile="(Default)">False</Value>
		</Setting>
		<Setting Name="Test5" Type="System.Double" Scope="User">
			<Value Profile="(Default)">17.56</Value>
		</Setting>
		<Setting Name="Test6" Type="System.Decimal" Scope="User">
			<Value Profile="(Default)">$30.02</Value>
		</Setting>
	</Settings>
</SettingsFile>
		endtext
		This.Asserttrue('Save failed', file('test.xml') and ;
			filetostr('test.xml') = lcXML)
	endfunc

	function TestLoad
		local My as My
		My = newobject('My', 'my.vcx')
		My.Settings.Add('Test1', 'Value')
		My.Settings.Add('Test2', 25)
		My.Settings.Add('Test3', .T.)
		My.Settings.Add('Test4', .F.)
		My.Settings.Add('Test5', 17.56)
		My.Settings.Add('Test6', cast(30.02 as Y))
		My.Settings.Save('test.xml')
		My = newobject('My', 'my.vcx')
		My.Settings.Load('test.xml')
		This.Asserttrue('Add of Test 1 failed', type('My.Settings.Test1') = 'C' and ;
			My.Settings.Test1 = 'Value')
		This.Asserttrue('Add of Test 2 failed', type('My.Settings.Test2') = 'N' and ;
			My.Settings.Test2 = 25)
		This.Asserttrue('Add of Test 3 failed', type('My.Settings.Test3') = 'L' and ;
			My.Settings.Test3)
		This.Asserttrue('Add of Test 4 failed', type('My.Settings.Test4') = 'L' and ;
			not My.Settings.Test4)
		This.Asserttrue('Add of Test 5 failed', type('My.Settings.Test5') = 'N' and ;
			My.Settings.Test5 = 17.56)
		This.Asserttrue('Add of Test 6 failed', type('My.Settings.Test6') = 'Y' and ;
			My.Settings.Test6 = $30.02)
	endfunc

**********************************************************************
ENDDEFINE
**********************************************************************
