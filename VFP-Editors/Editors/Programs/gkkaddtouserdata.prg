*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for adding data to the user memo field value
*-*
FUNCTION GKKAddToUserData
LPARAMETERS tcName, tcDataValue, tcUserData
LOCAL lnNum,  lnNdx
LOCAL ARRAY lcMemo[1]
#DEFINE CRLF  CHR(13)+CHR(10)
tcName = tcName + " ="
IF ATC(tcName, tcUserData) > 0
	lnNum = ALINES(lcMemo, tcUserData, .T.)
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