*******************************************************************************************
* Win7TLib VFPX Library for VFP (Simple) Demo Application
* 
* This demo shows the smallest amount of code necessary to work with
* the Win7TLib project.
*******************************************************************************************

*Add Win7Tlib Path
SET PATH TO "..\..\Win7TLib" ADDITIVE

*Set up the Win7Tlib library of classes
SET PROCEDURE TO win7tlib

*Initialize
IF !Initialize_Win7TLib()
	RETURN .F.
ENDIF

*Make VFP visible
_VFP.Visible = .T.

*Load up form
DO FORM simple

*Start the Event Loop
READ EVENTS

*Uninit
UnInitialize_Win7TLib()

*clean up
CLEAR ALL

** END OF PROGRAM **

*********************************************************
* Define the Win7TLib Application Settings Class
*********************************************************
DEFINE CLASS Win7TLib_Application_Settings AS TaskBar_Library_Settings 
	cAppID = "Win7TLib.Simple.DemoApp"
ENDDEFINE