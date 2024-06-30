*******************************************************************************************
* Win7TLib VFPX Library for VFP Forced UnGrouping Demo Application
* 
* This super simple application shows how the same exact application executable can be
* forced to group separately (ungrouped) in the Windows 7 Taskbar when more than one 
* instance is launched.

* This is done by simply setting the application id values to be different at run time.
*
* Typical (default Windows 7) behavior would be that each executable instance would
* group together in the taskbar.
*******************************************************************************************

*NOTE: 
* VFP Window MUST BE INVISIBLE AT STARTUP *if you wish to set Application ID!!*
* Use a config.fpw with SCREEN=OFF setting, and then simply issue: _VFP.Visible = .T. anytime
* after setting the AppID.

***************
*** PATHING ***
***************
SET PATH TO ..\..\..\resources, ..\..\..\..\win7tlib

******************
*** PROCEDURES ***
******************
*Set up the Win7Tlib library of classes
SET PROCEDURE TO win7tlib

****************************
*** INITIALIZE Win7TLIB  ***
****************************
IF !Initialize_Win7TLib()
	RETURN .F.
ENDIF

********************************
*** VFP ENVIRONMENT SETTINGS ***
********************************
* Set up the On Shutdown handler, so user can close VFP by clicking the X or from the Jumplist close button
ON SHUTDOWN CLEAR EVENTS

*******************************
*** STARTUP THE APPLICATION ***
*******************************

*Determine if in debug mode
LOCAL llDebug, lcAppID
llDebug = FILE("debug.txt")

*Get Taskbar Manager
LOCAL loTBM
IF !Get_Win7TLib_Taskbar_Manager(@loTBM)
	RETURN .F.
ENDIF
*Retrieve current appid
lcAppID = loTBM.GetApplicationID()

*Modify it based on mode
loTBM.SetApplicationID(lcAppID+IIF(llDebug,".Debug",".Production"))

*Make VFP visible
_VFP.Visible = .T.

*Show the menu
DO exit.mpr

*Print Info to Screen
_SCREEN.FontSize = 32
?"I am the Application!"
?JUSTFNAME(SYS(16,0))
?

?"Mode: "
IF llDebug
	?"Debug Mode"
ELSE
	?"Production Mode"
ENDIF
?
*Print AppID
?"My AppID is: " 
_SCREEN.FontName = "Arial"
_SCREEN.FontSize = 24
?loTBM.GetApplicationID()

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
CLEAR ALL
** END OF PROGRAM **

*********************************************************
* Define the Win7TLib Application Settings Class and set
* all properties needed. 
*********************************************************
*NOTE: We use the SAME APPID for both APP1 and APP2 applications to force the grouping to be the same.
DEFINE CLASS Win7TLib_Application_Settings AS TaskBar_Library_Settings 
	cAppID = "Win7TLib.DemoApp.UnGrouping.Forced"
ENDDEFINE
