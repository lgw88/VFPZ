*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Gets the specified GKK Project Dock form
*-*
#IFNDEF GKKDEFINES
#INCLUDE gkkdefines.h
#ENDIF
FUNCTION GKKGetGKKProjectForm
LPARAMETERS tcProjectName
LOCAL llNotFound, lnForm
IF VARTYPE(tcProjectName) != "C" .OR. EMPTY(tcProjectName)
	RETURN 0
ENDIF
llNotFound = True
FOR lnForm=1 TO _SCREEN.FormCount
	IF PEMSTATUS(_SCREEN.Forms(lnForm),"FormName",5) .AND. _SCREEN.Forms(lnForm).FormName = "GKKProjectDock"
		IF _SCREEN.Forms(lnForm).ProjectName = tcProjectName
			llNotFound = False
			EXIT
		ENDIF
	ENDIF
ENDFOR
IF llNotFound
	RETURN 0
ELSE
	RETURN lnForm
ENDIF
ENDFUNC