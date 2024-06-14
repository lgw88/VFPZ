*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for determining the Top and Left positions for form relative positioning
*-*
FUNCTION GKKGetFormCoordinates
LPARAMETERS toObject, toPosition
LOCAL loForm
#DEFINE True   .T.
toPosition.Top  = OBJTOCLIENT(toObject, 1) + toObject.Height
toPosition.Left = OBJTOCLIENT(toObject, 2)
IF VARTYPE(toObject.Parent) = "O"
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
ENDIF