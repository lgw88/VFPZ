*******************************************************************************************
* Win7TLib VFPX Library for VFP Demo Application
* 
* This version demonstrates the Taskbar library when running in TDI mode.
*
* In TDI ( Tabbed Document Interface ) Mode, one single Top Level VFP Form serves as the UI,
* ie, VFP main window will be hidden. This top level form contains 1 single Pageframe. 
* Each pageframe tab will have it's own preview window in the Windows 7 Taskbar. 
*
* Unfortunately, pulling off this stunt in VFP is very tricky since tabs of a pageframe
* in VFP are not real windows ( ie they don't have an hWND ). We fake it by creating a 
* pageframe and then using real vfp forms as the tabs that run ShowWindow = 1 so that
* they are constrained to the top level form. We also don't allow them to be moved, as they must
* act as if they are locked into the pageframe. This effect is complex as switching tabs and 
* resizing stuff requires a lot of manual handling to keep the windows and page frame in sync.
* Someday this might get incorporated into the Win7TLib library, but here it's done manually.
* 
* Since each tab / child window is not a real Top Level Window, we also still have some of the
* difficulties of getting the thumbnail and preview to work 100% properly.
* See the MDI Example notes as to why. Unlike in MDI Example, though, we don't have to worry
* about clipping and minimizing, so in theory, we should be able to fake the effect far 
* better than in MDI mode, but currently there's some sizing bugs / problems.
* 
* This approach needs a lot of work and class encapulation before being worth 
* anyone's time to work with for real IMO. This sample was just to prove it could be done.
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
_SCREEN.Icon = "note05.ico"

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
SET CLASSLIB TO demotab.vcx

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

*Load up the test forms
DO FORM demo_tdi NAME form1 LINKED

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
	cAppID = "Win7TLib.DemoApp.FormType.TDI"
	cDefaultFormMode = "TDI"
ENDDEFINE
