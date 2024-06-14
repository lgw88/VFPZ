*-***********************************************************************************************
*-* Modified by:  Gregory A. Green
*-*               980 Windmill Parkway
*-*               Evans, GA  30809
*-*               (706) 651-1640
*-*
*-***********************************************************************************************
*-*  Routine for determining if a window is already present at the left and top coordinates
*-*
FUNCTION GKLGetVFPForms
LPARAMETERS tnLeft,tnTop
LOCAL llFound, loWindow, loForm, lhDesktop, lhFirstChild, lhLastChild, lhCurrent, lcWinCap
#DEFINE GW_HWNDLAST   1
#DEFINE GW_HWNDNEXT   2
#DEFINE GW_CHILD      5
#DEFINE False         .F.
#DEFINE True          .T.
llFound = False
IF tnLeft > 0 .AND. tnTop > 0
	CREATE CURSOR c_wintext (winhandle I, wintitle C(200))
*-*	Get VFP forms
	loWindow = CREATEOBJECT("Twindow", _VFP.hWnd, 0)
*-*	Get Forms in Windows
	lhDesktop    = apiGetDesktopWindow()
	lhFirstChild = apiGetWindow(lhDesktop, GW_CHILD)
	lhLastChild  = apiGetWindow(lhFirstChild, GW_HWNDLAST)
	lhCurrent    = lhFirstChild
	DO WHILE True
		lcWinCap = GetWinText(lhCurrent)
		INSERT INTO c_wintext (winhandle,wintitle) VALUES (lhCurrent,lcWinCap)
		IF lhCurrent = lhLastChild
			EXIT
		ENDIF
		lhCurrent = apiGetWindow(lhCurrent, GW_HWNDNEXT)
	ENDDO
*-*	Check for position overlap
	SELECT c_wintext
	SCAN FOR !EMPTY(wintitle)
		lpRect = REPLICATE(CHR(0),16)
		=apiGetWindowRect(c_wintext.winhandle, @lpRect)
		lnLeft = buf2dword(SUBSTR(lpRect,1,4))
		lnTop  = buf2dword(SUBSTR(lpRect,5,4))
		IF lnLeft = tnLeft .AND. lnTop = tnTop
			llFound = True
			EXIT
		ENDIF
	ENDSCAN
	USE
ENDIF
RETURN llFound
ENDFUNC


*-***********************************************************************************************
*-* Converts buffer to integer
*-*
FUNCTION Buf2Dword(lcBuffer)
RETURN ASC(SUBSTR(lcBuffer, 1,1)) + ;
	BITLSHIFT(ASC(SUBSTR(lcBuffer, 2,1)),  8) + ;
	BITLSHIFT(ASC(SUBSTR(lcBuffer, 3,1)), 16) + ;
	BITLSHIFT(ASC(SUBSTR(lcBuffer, 4,1)), 24)
ENDFUNC


*-***********************************************************************************************
*-* Converts buffer to integer
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
		LPARAMETERS tnHandle, tnParent
		LOCAL lhChild, loChild, lhNext, loNext, lcWinCap
		IF tnHandle = 0
			RETURN False
		ENDIF
		lcWinCap = GetWinText(tnHandle)
		INSERT INTO c_wintext (winhandle,wintitle) VALUES (tnHandle,lcWinCap)
		lhChild = apiGetWindow(tnHandle, GW_CHILD)
		loChild = CREATEOBJECT("Twindow", lhChild, tnHandle)
		IF tnParent <> 0
			lhNext = apiGetWindow(tnHandle, GW_HWNDNEXT)
			loNext = CREATEOBJECT("Twindow", lhNext, tnParent)
		ENDIF
	ENDPROC
ENDDEFINE