*******************************************************************************************
* Win7TLib VFPX Library for VFP Demo Application
* 
* This version demonstrates the Taskbar library when running in MDI Mode.
*
* In MDI ( Multiple Document Interface ) Mode, the VFP Main window serves as the
* primary user interface with VFP managing multiple child windows. 
*
* The difference between this mode and the VFP mode is that here, each child window
* will have it's own preview window in the Windows 7 Taskbar. 
*
* NOTE: This mode can work with either setting of the MDIForm property of each form.
* When set to .F. ( the default ), each child form remains an independant window when VFP's window
* is maximized. When set to .T., each child form will maximize when VFP's window maximizes also.
*
* To accomplish giving each child form it's own preview window, requires some trickery, since
* the Windows 7 Taskbar functionality only operates with Top Level windows.
*
* The Win7Tlib library works around this limitation by managing an invisible top-level vfp proxy form.
* It then hooks into Custom Thumbnail & LivePeek drawing mode for each child window and creates a
* snapshot of the VFP child form to fake the effect. As a result, users' currently cannot provide
* their own custom drawing for thumbnail & livepeek, but this restriction may be removed in the future.
*
* Generating the screen capture for each child window is currently not 100% perfect.
* The main issue is that the screen capture cannot get an image for clipped and minimized form's.
* The results of the Thumbnail & LivePreview images are less then satisfying in those cases. 
* Perhaps a workaround for this can be found and addressed by the library in the future. 
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
_SCREEN.Icon = "mycomp.ico"

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
DO FORM demo_mdi NAME form1 LINKED
DO FORM demo_mdi NAME form2 LINKED

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
	cAppID = "Win7TLib.DemoApp.FormType.MDI"
	cDefaultFormMode = "MDI"
ENDDEFINE
