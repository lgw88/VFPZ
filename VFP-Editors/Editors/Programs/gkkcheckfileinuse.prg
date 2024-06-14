*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2005 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for checking if a file is being used/edited
*-*
FUNCTION GKKCheckFileInUse
LPARAMETERS tcFileName
LOCAL lhFile, llFileInUse
IF FILE(tcFileName)
	lhFile = FOPEN(tcFileName,2)
	IF lhFile >= 0
		=FCLOSE(lhFile)
		llFileInUse = .F.
	ELSE
		llFileInUse = .T.
	ENDIF
ELSE
	llFileInUse = .T.
ENDIF
RETURN llFileInUse
ENDFUNC