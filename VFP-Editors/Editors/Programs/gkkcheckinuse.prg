************************************************************************************************
* Written by:  Gregory A. Green
*              980 Windmill Parkway
*              Evans, GA  30809
*              (706) 651-1640
*
* Copyright ©2005 Gregory A. Green
*
************************************************************************************************
*  Routine for checking if a file is being used/edited (checks open window titles and tries file)
*
FUNCTION GKKCheckInUse
LPARAMETERS pcFileName
LOCAL llFileInUse, loWindow, lcFileName
#DEFINE GW_HWNDNEXT   2
#DEFINE GW_CHILD      5
CREATE CURSOR c_wintext (winhandle N(12), parentwin N(12), wintitle C(200))
loWindow = CreateObject("Twindow", _VFP.hWnd, 0)
lcFileName = JUSTFNAME(pcFileName)
llFileInUse = .F.
SELECT c_wintext
SCAN
	IF ATC(lcFileName,c_wintext.wintitle) > 0
		llFileInUse = .T.
		EXIT
	ENDIF
ENDSCAN
USE
IF !llFileInUse
	IF FILE(pcFileName)
		lhFile = FOPEN(pcFileName,2)
		IF lhFile >= 0
			=FCLOSE(lhFile)
		ELSE
			llFileInUse = .T.
		ENDIF
	ELSE
		llFileInUse = .T.
	ENDIF
ENDIF
RETURN llFileInUse
ENDFUNC


DEFINE CLASS Twindow As Custom
	PROCEDURE  Init
		LPARAMETERS pnHandle, pnParent
		LOCAL lhChild, loChild, lhNext, loNext, lcBuffer, lnResult, lcWinCap
		IF pnHandle = 0
			RETURN .F.
		ENDIF

		lcBuffer = SPACE(200)
		lnResult = apiGetWindowText(pnHandle, @lcBuffer, LEN(lcBuffer))
		lcWinCap = UPPER(LEFT(lcBuffer, lnResult))
		INSERT INTO c_wintext (winhandle,parentwin,wintitle) VALUES (pnHandle,pnParent,lcWinCap)

		lhChild = apiGetWindow(pnHandle, GW_CHILD)
		loChild = CREATEOBJECT("Twindow", lhChild, pnHandle)

		IF pnParent <> 0
			lhNext = apiGetWindow(pnHandle, GW_HWNDNEXT)
			loNext = CREATEOBJECT("Twindow", lhNext, pnParent)
		ENDIF
	ENDPROC
ENDDEFINE