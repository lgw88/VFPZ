*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2008 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for determining if position is inside a delimited string
*-*
FUNCTION GKKCheckForDelimitedText
LPARAMETERS pcLine,pnCol
LOCAL llDelimited, lnNdx, lnPos
llDelimited = .F.
*-*	Check if position is within text string delimited by ""
lnNdx = 1
lnPos = ATC('"',pcLine,lnNdx)
DO WHILE lnPos > 0 .AND. lnPos < pnCol
	lnNdx = lnNdx + 1
	lnPos = ATC('"',pcLine,lnNdx)
	IF lnPos > 0 .AND. lnPos < pnCol
		lnNdx = lnNdx + 1
	ELSE
		llDelimited = .T.
	ENDIF
	lnPos = ATC('"',pcLine,lnNdx)
ENDDO
*-*	Check if position is within text string delimited by ''
lnNdx = 1
lnPos = ATC("'",pcLine,lnNdx)
DO WHILE lnPos > 0 .AND. lnPos < pnCol
	lnNdx = lnNdx + 1
	lnPos = ATC("'",pcLine,lnNdx)
	IF lnPos > 0 .AND. lnPos < pnCol
		lnNdx = lnNdx + 1
	ELSE
		llDelimited = .T.
	ENDIF
	lnPos = ATC("'",pcLine,lnNdx)
ENDDO
*-*	Check if position is within text string delimited by []
lnNdx = 1
lnPos = ATC("[",pcLine,lnNdx)
DO WHILE lnPos > 0 .AND. lnPos < pnCol
	lnNdx = lnNdx + 1
	lnPos = ATC("]",pcLine,lnNdx)
	IF lnPos > 0 .AND. lnPos < pnCol
		lnNdx = lnNdx + 1
	ELSE
		llDelimited = .T.
	ENDIF
	lnPos = ATC("[",pcLine,lnNdx)
ENDDO
RETURN llDelimited
ENDFUNC