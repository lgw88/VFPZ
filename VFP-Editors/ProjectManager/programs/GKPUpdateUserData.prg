*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-***********************************************************************************************
*-*  Routine for adding data to the user memo field value
*-*
FUNCTION GKPUpdateUserData
LPARAMETERS tcName, tcDataValue, tcUserData
LOCAL lnNum, lnNdx
LOCAL ARRAY lcMemo[1]
#INCLUDE "GKPDefines.h"
tcName = tcName + " ="
IF ATC(tcName, tcUserData) > 0
	lnNum = ALINES(lcMemo, tcUserData, True)
	tcUserData = ""
	FOR lnNdx=1 TO lnNum
		IF !EMPTY(lcMemo[lnNdx])
			IF lcMemo[lnNdx] = tcName
				tcUserData = tcUserData + tcName + " " + tcDataValue + CRLF
			ELSE
				tcUserData = tcUserData + lcMemo[lnNdx] + CRLF
			ENDIF
		ENDIF
	ENDFOR
ELSE
	IF !EMPTY(tcUserData) .AND. RIGHT(tcUserData, 2) != CRLF
		tcUserData = tcUserData + CRLF
	ENDIF
	tcUserData = tcUserData + tcName + " " + tcDataValue + CRLF
ENDIF
RETURN tcUserData
ENDFUNC