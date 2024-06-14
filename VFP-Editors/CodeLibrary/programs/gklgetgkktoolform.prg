*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              green.gregory@comcast.net
*-*
*-* Copyright ©2011 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Gets the specified GKL Tool window (thisform) reference
*-*
FUNCTION GKLGetGKLToolForm
LPARAMETERS tcGKLToolName
LOCAL llNotFound, lnForm
#IFNDEF GKLDEFINES
#INCLUDE gkldefines.h
#ENDIF
llNotFound = True
FOR lnForm=1 TO _SCREEN.FormCount
	IF PEMSTATUS(_SCREEN.Forms(lnForm),"FormName",5) .AND. _SCREEN.Forms(lnForm).FormName = tcGKLToolName
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