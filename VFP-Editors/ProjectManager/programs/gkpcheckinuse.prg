************************************************************************************************
* Written by:  Gregory A. Green
*
* Copyright ©2005 Gregory A. Green
*
************************************************************************************************
*  Defines
*
#DEFINE GW_HWNDLAST   1
#DEFINE GW_HWNDNEXT   2
#DEFINE GW_CHILD      5
#DEFINE False         .F.
#DEFINE True          .T.
*
************************************************************************************************
*  Routine for checking if a file is being used/edited (checks open window titles and tries file)
*
FUNCTION GKPCheckInUse
LPARAMETERS tcFileName
LOCAL llFileInUse, loWindow, lcFileName
CREATE CURSOR c_wintext (winhandle N(12), parentwin N(12), wintitle C(200))
loWindow = CreateObject("Twindow", _VFP.hWnd, 0)
lcFileName = JUSTFNAME(tcFileName)
llFileInUse = False
SELECT c_wintext
SCAN
	IF ATC(lcFileName, c_wintext.wintitle) > 0
		llFileInUse = True
		EXIT
	ENDIF
ENDSCAN
USE
IF !llFileInUse
	IF FILE(tcFileName)
		lhFile = FOPEN(tcFileName, 2)
		IF lhFile >= 0
			=FCLOSE(lhFile)
		ELSE
			llFileInUse = True
		ENDIF
	ELSE
		llFileInUse = True
	ENDIF
ENDIF
RETURN llFileInUse
ENDFUNC


DEFINE CLASS Twindow As Custom
	PROCEDURE  Init
		LPARAMETERS tnHandle, tnParent
		LOCAL lhChild, loChild, lhNext, loNext, lcBuffer, lnResult, lcWinCap
		IF tnHandle = 0
			RETURN False
		ENDIF

		lcBuffer = SPACE(200)
		lnResult = apiGetWindowText(tnHandle, @lcBuffer, LEN(lcBuffer))
		lcWinCap = UPPER(LEFT(lcBuffer, lnResult))
		INSERT INTO c_wintext (winhandle, parentwin, wintitle) VALUES (tnHandle, tnParent, lcWinCap)

		lhChild = apiGetWindow(tnHandle, GW_CHILD)
		loChild = CREATEOBJECT("Twindow", lhChild, tnHandle)

		IF tnParent <> 0
			lhNext = apiGetWindow(tnHandle, GW_HWNDNEXT)
			loNext = CREATEOBJECT("Twindow", lhNext, tnParent)
		ENDIF
	ENDPROC
ENDDEFINE