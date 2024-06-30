*******************************************************************************************
* Win7TLib VFPX Library for VFP Demo Application
* 
* This version demonstrates the Taskbar library when running in VFP Mode.
*
* In VFP Mode, the VFP Main window serves as the primary user interface with
* VFP managing multiple child windows. This is the typical scenario most VFP apps
* are developed in. Only the VFP main window will get it's own preview window 
* in the Windows 7 Taskbar.
*
* Since the Win7 taskbar functionality supports this directly and provides automatic
* drawing of Thumbnail & Live Peek, this approach works 100% perfectly.
*******************************************************************************************

*NOTE: 
* VFP Window MUST BE INVISIBLE AT STARTUP *if you wish to set Application ID!!*
* Use a config.fpw with SCREEN=OFF setting, and then simply issue: _VFP.Visible = .T. anytime
* after setting the AppID.

*****************************************************
**** OPEN FILE HANDLING FROM THE JUMP LIST ITEMS ****
*****************************************************
*NOTE: LPARAMETERS line MUST BE THE FIRST LINE OF EXECUTABLE CODE
LPARAMETERS tcOpenFile

*Specify an Icon for the Application Window
_SCREEN.Icon = "audio.ico"

*Handle File opening
IF VARTYPE(tcOpenFile)="C" AND !EMPTY(tcOpenFile)
	*Show VFP
	_VFP.Visible = .T.
	*Message to User
	=MESSAGEBOX("You requested to open: " + tcOpenFile,64,"Notice!")
	*DONE CLOSE APP!
	RETURN
ENDIF

***************
*** PATHING ***
***************
* Running within VFP? ( Paths are one level deeper than where .EXE is stored )
IF _VFP.StartMode = 0

	*Add Win7Tlib Path
	SET PATH TO "..\..\..\Win7TLib" ADDITIVE
	*Resources
	SET PATH TO "..\..\resources" ADDITIVE

* Running as .EXE 
ELSE
	*Add Win7Tlib Path
	SET PATH TO "..\..\Win7TLib" ADDITIVE
	*Resources
	SET PATH TO "..\resources" ADDITIVE
ENDIF

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

*Show the menu
DO exit.mpr

*Load up the test forms
DO FORM demo_vfp NAME form1 LINKED
DO FORM demo_vfp NAME form2 LINKED

*Modify captions & placement
form1.Caption = form1.Caption + " - Form #1"
form2.Caption = form2.Caption + " - Form #2"
form2.Top = form2.Top + 120
form2.Left = form2.Left + 120

*Start the Event Loop
READ EVENTS

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
	cAppID = "Win7TLib.DemoApp.FormType.VFP"
	cDefaultFormMode = "VFP"
ENDDEFINE