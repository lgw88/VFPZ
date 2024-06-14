*-***********************************************************************************************
*-*
*-* Copyright ©2011 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Gets the specified GKC Tool window (thisform) reference
*-*
FUNCTION GKCGetGKKToolForm
LPARAMETERS tcGKCToolName
LOCAL llNotFound, lnForm
#INCLUDE "GKCDefines.h"
llNotFound = True
FOR lnForm=1 TO _SCREEN.FormCount
	IF PEMSTATUS(_SCREEN.Forms(lnForm),"FormName",5) .AND. _SCREEN.Forms(lnForm).FormName = tcGKCToolName
		llNotFound = False
		EXIT
	ENDIF
ENDFOR
IF llNotFound
	RETURN 0
ELSE
	RETURN lnForm
ENDIF
ENDFUNC