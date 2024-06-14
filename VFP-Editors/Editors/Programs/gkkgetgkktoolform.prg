*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Gets the specified GKK Tool window (thisform) reference
*-*
FUNCTION GKKGetGKKToolForm
LPARAMETERS tcGKKToolName
LOCAL llNotFound, lnForm
#IFNDEF GKKDEFINES
#INCLUDE gkkdefines.h
#ENDIF
llNotFound = True
FOR lnForm=1 TO _SCREEN.FormCount
	IF PEMSTATUS(_SCREEN.Forms(lnForm),"FormName",5) .AND. _SCREEN.Forms(lnForm).FormName = tcGKKToolName
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