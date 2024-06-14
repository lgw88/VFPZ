*-***********************************************************************************************
*-* Modified by:  Gregory A. Green
*-*               980 Windmill Parkway
*-*               Evans, GA  30809
*-*               (706) 651-1640
*-*
*-***********************************************************************************************
*-*  Routine for determining if a window is already present at the left and top coordinates
*-*
FUNCTION GKLCheckDebugOpen
LOCAL llFound, loWindow, lhDesktop, lhFirstChild, lhLastChild, lhCurrent
#DEFINE GW_HWNDLAST   1
#DEFINE GW_HWNDNEXT   2
#DEFINE GW_CHILD      5
CREATE CURSOR c_wintext (winhandle I, wintitle C(200))
llFound      = .F.
loWindow     = CREATEOBJECT("Twindow", _VFP.hWnd, 0)
lhDesktop    = apiGetDesktopWindow()
lhFirstChild = apiGetWindow(lhDesktop, GW_CHILD)
lhLastChild  = apiGetWindow(lhFirstChild, GW_HWNDLAST)
lhCurrent    = lhFirstChild
DO WHILE .T.
	INSERT INTO c_wintext (winhandle,wintitle) VALUES (lhCurrent,GetWinText(lhCurrent))
	IF lhCurrent = lhLastChild
		EXIT
	ENDIF
	lhCurrent = apiGetWindow(lhCurrent, GW_HWNDNEXT)
ENDDO
SELECT c_wintext
SCAN FOR !EMPTY(wintitle)
	IF c_wintext.wintitle = "VISUAL FOXPRO DEBUGGER"
		llFound = .T.
		EXIT
	ENDIF
ENDSCAN
USE
RETURN llFound
ENDFUNC


*-***********************************************************************************************
*-* Gets the open window name/caption
*-*
FUNCTION GetWinText(phHdl)
LOCAL lcBuffer, lnResult
lcBuffer = SPACE(200)
lnResult = apiGetWindowText(phHdl, @lcBuffer, LEN(lcBuffer))
RETURN UPPER(LEFT(lcBuffer, lnResult))
ENDFUNC

*-***********************************************************************************************
*-*  Retreives FoxPro based forms (In-Screen mode)
*-*
DEFINE CLASS Twindow As Custom
	PROCEDURE  Init
		LPARAMETERS pnHandle, pnParent
		LOCAL lhChild, loChild, lhNext, loNext, lcWinCap
		IF pnHandle = 0
			RETURN .F.
		ENDIF
		lcWinCap = GetWinText(pnHandle)
		INSERT INTO c_wintext (winhandle,wintitle) VALUES (pnHandle,lcWinCap)
		lhChild = apiGetWindow(pnHandle, GW_CHILD)
		loChild = CREATEOBJECT("Twindow", lhChild, pnHandle)
		IF pnParent <> 0
			lhNext = apiGetWindow(pnHandle, GW_HWNDNEXT)
			loNext = CREATEOBJECT("Twindow", lhNext, pnParent)
		ENDIF
	ENDPROC
ENDDEFINE