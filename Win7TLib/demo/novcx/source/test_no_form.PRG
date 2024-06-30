*** Test the Taskbar_Helper class when not used in a form ***

***************
*** PATHING ***
***************
*Path to our icon graphics when running code as a PRG ( makes it easier for development )
IF !(INLIST(RIGHT(SYS(16,1), 3), "APP", "EXE"))
	SET PATH TO "C:\Program Files (x86)\Microsoft Visual FoxPro 9\Graphics\Icons\Win95\"
ENDIF
*Add Win7Tlib Path
SET PATH TO "..\..\Win7TLib" ADDITIVE

******************
*** PROCEDURES ***
******************
*Set up the Win7Tlib library of classes
SET PROCEDURE TO win7tlib

********************************
*** VFP ENVIRONMENT SETTINGS ***
********************************
*For file overwriting
SET SAFETY OFF

* Set up the On Shutdown handler, so user can close VFP by clicking the X or from the Jumplist close button
ON SHUTDOWN CLEAR EVENTS

****************************
*** INITIALIZE Win7TLIB  ***
****************************
IF !Initialize_Win7TLib()
	RETURN .F.
ENDIF

*******************************
*** STARTUP THE APPLICATION ***
*******************************

*Make VFP visible now that we set the AppID
_VFP.Visible = .T.

*Do the work
CLEAR
?"Click the X to terminate the program and return to VFP"
DO TestIt

READ EVENTS

?"Bye bye!"
_VFP.oHelper = NULL
REMOVEPROPERTY(_VFP,"oHelper")

*******************************
*** UNINITIALIZE Win7TLIB   ***
*******************************
UnInitialize_Win7TLib()

****************
*** Cleam up ***
****************
ON SHUTDOWN
SET SYSMENU TO DEFAULT
_SCREEN.Icon = ""
SET PROCEDURE TO 
SET PATH TO
CLEAR ALL

** END OF PROGRAM **

*********************************************************
* Define the Win7TLib Application Settings Class and set
* all properties needed. 
* 
* REQUIRED STEP even if you wish to use all the default
* settings by omitting all the properties leaving just
* an empty class definition. 
*
*
* NOTE: The class MUST BE NAMED:
* ------------------------------
*		Win7TLib_Application_Settings
*
* 		otherwise, the library won't know how to find it.
*********************************************************
DEFINE CLASS Win7TLib_Application_Settings AS TaskBar_Library_Settings 
	cAppID = "Win7TLib.DemoApp.FormType.NOFORM"
	cDLLPath = "C:\Users\Steve\Documents\Visual Studio 2008\Projects\Win7TLib\Debug\"
	cDefaultFormMode = "VFP"
ENDDEFINE

***************************************
*** Define the Taskbar Helper Class ***
***************************************
DEFINE CLASS demoapp_tbhelper AS TaskBar_Helper

	*Set custom handling for the Toolbar button click event
	FUNCTION On_Toolbar_Button_Click(toToolbar, toForm, tnID)
		?"On_Toolbar_Button_Click() was called!"
		DODEFAULT(toToolbar, toForm, tnID)
	ENDFUNC
	
ENDDEFINE

FUNCTION TestIt
	LOCAL loH, loT
	*Create helper
	loH = CREATEOBJECT("demoapp_tbhelper","","oHelper")
	IF !(VARTYPE(loH)="O" AND !ISNULL(loH))
		RETURN .F.
	ENDIF

	*Add to _VFP
	ADDPROPERTY(_VFP,"oHelper",loH)
	
	loT = loH.oTaskbar
	WITH loT.TaskbarButton
		.Flash(5)
	ENDWITH

	* Access the Taskbar's Toolbar Object
	WITH loT.Toolbar

		*Set # of buttons to use
		.nButtonCount = 1

		*Set the Tooltip Text
		.cToolbarText = "One Button To Rule Them With"

		***********************	
		*** SET EACH BUTTON ***
		***********************

		*Button #1
		loB = .GetButton(1)
		WITH loB
			.cIcon = "note03.ico"	&& NOTE: This is an EXTERNAL icon file
			.cToolTip = "I am the one!"
		ENDWITH
	
		**************************
		*** UPDATE THE TOOLBAR ***
		**************************	
		.UpdateToolbar()
	ENDWITH
ENDFUNC