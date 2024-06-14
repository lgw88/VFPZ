*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-***********************************************************************************************
*-*  Routine for adding data to the user memo field value
*-*
FUNCTION GKPAddToUserData
LPARAMETERS tcName, tcDataValue, tcUserData
LOCAL lnNum, lnNdx
LOCAL ARRAY lcMemo[1]
#INCLUDE "GKPDefines.h"
tcName = tcName + " ="
IF ATC(tcName, tcUserData) > 0
	lnNum = ALINES(lcMemo, tcUserData, True)
	tcUserData = ""
	FOR lnNdx=1 TO lnNum
		IF lcMemo[lnNdx] != tcName .AND. !EMPTY(lcMemo[lnNdx])
			tcUserData = tcUserData + lcMemo[lnNdx] + CRLF
		ENDIF
	ENDFOR
ELSE
	IF !EMPTY(tcUserData)
		tcUserData = tcUserData + CRLF
	ENDIF
ENDIF
tcUserData = tcUserData + tcName + " " + tcDataValue
RETURN tcUserData
ENDFUNC