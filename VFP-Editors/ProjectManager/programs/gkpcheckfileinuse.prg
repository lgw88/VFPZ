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
FUNCTION GKPCheckFileInUse
LPARAMETERS tcFileName
#INCLUDE "GKPDefines.h"
LOCAL lhFile, llFileInUse
IF FILE(tcFileName)
	lhFile = FOPEN(tcFileName,2)
	IF lhFile >= 0
		=FCLOSE(lhFile)
		llFileInUse = False
	ELSE
		llFileInUse = True
	ENDIF
ELSE
	llFileInUse = True
ENDIF
RETURN llFileInUse
ENDFUNC