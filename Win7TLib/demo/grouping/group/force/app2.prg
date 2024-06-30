*******************************************************************************************
* Win7TLib VFPX Library for VFP Forced Grouping Demo Application
* 
* This super simple application shows how two separate application executables can
* be forced to group together in the Windows 7 Taskbar, by simply setting the
* application id values to be the same for both applications.
*
* Typical (default Windows 7) behavior would be that each separate executable would
* group separately in the taskbar.
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
*Make VFP visible
_VFP.Visible = .T.

*Show the menu
DO exit.mpr

*Print Info to Screen
_SCREEN.FontSize = 32
?"I am Application #2"
?JUSTFNAME(SYS(16,0))
?

*Obtain AppID being used (even though we know what it is since we hardcoded it)
LOCAL loTBM, lcAppID
IF !Get_Win7TLib_Taskbar_Manager(@loTBM)
	RETURN .F.
ENDIF
lcAppID = loTBM.GetApplicationID()

*Print AppID
?"My AppID is: " 
?lcAppID

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
	cAppID = "Win7TLib.DemoApp.Grouping.Forced"
ENDDEFINE
