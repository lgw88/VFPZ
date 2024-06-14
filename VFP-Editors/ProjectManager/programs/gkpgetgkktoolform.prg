*-***********************************************************************************************
*-* Copyright ©2011-2013 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Gets the specified GKK Tool window (thisform) reference
*-*
FUNCTION GKPGetGKKToolForm
LPARAMETERS tcGKKToolName, tcFileName
LOCAL llNotFound, lnForm
#INCLUDE "GKPDefines.h"
IF PCOUNT() = 1
	tcFileName = .NULL.
ENDIF
llNotFound = True
FOR lnForm=1 TO _SCREEN.FormCount
	IF PEMSTATUS(_SCREEN.Forms(lnForm),"FormName",5) .AND. _SCREEN.Forms(lnForm).FormName = tcGKKToolName
		IF ISNULL(tcFileName)
			llNotFound = False
			EXIT
		ELSE
			IF PEMSTATUS(_SCREEN.Forms(lnForm),"FileName",5) .AND. UPPER(_SCREEN.Forms(lnForm).FileName) == UPPER(tcFileName)
				llNotFound = False
				EXIT
			ENDIF
		ENDIF
	ENDIF
ENDFOR
IF llNotFound
	RETURN 0
ELSE
	RETURN lnForm
ENDIF
ENDFUNC