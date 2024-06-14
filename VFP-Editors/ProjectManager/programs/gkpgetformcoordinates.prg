*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2005-2008 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for determining the Top and Left positions for form relative positioning
*-*
FUNCTION GKPGetFormCoordinates
LPARAMETERS toObject, toPosition
LOCAL loForm
#DEFINE True   .T.
toPosition.Top  = OBJTOCLIENT(toObject,1) + toObject.Height
toPosition.Left = OBJTOCLIENT(toObject,2)
loForm = toObject.Parent
DO WHILE True
	IF UPPER(loForm.BaseClass) = "FORM"
		IF loForm.ShowWindow != 2
			toPosition.Top  = toPosition.Top  + loForm.Top
			toPosition.Left = toPosition.Left + loForm.Left
		ENDIF
		EXIT
	ENDIF
	loForm = loForm.Parent
	IF VARTYPE(loForm) != "O"
		EXIT
	ENDIF
ENDDO