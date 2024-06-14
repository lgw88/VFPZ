*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Gets the GKK Browser Tool window (thisform) reference
*-*
FUNCTION GKKGetGKKBrowserForm
LOCAL lnForm
FOR lnForm=1 TO _SCREEN.FormCount
	IF PEMSTATUS(_SCREEN.Forms(lnForm), "FormName", 5) .AND. _SCREEN.Forms(lnForm).FormName = "GKKTableBrowser"
		RETURN _SCREEN.Forms(lnForm)
	ENDIF
ENDFOR
RETURN .NULL.
ENDFUNC