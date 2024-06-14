*-***********************************************************************************************
*-*
*-* Copyright ©2009 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine to determine if a user defined variable memberlist is to be displayed
*-*
#INCLUDE "GKCDefines.h"
FUNCTION GKCCheckForVarMemberList
LPARAMETERS toCodeMax,tnKeyAscii
LOCAL loRange, lcTextLine, lcComment, llReturn, lnNdx, loMbrList, lcVName, lnCol, loMbr, lcChr, lnChr
LOCAL lnMbrCnt
llReturn = False
WITH toCodeMax
*-*	Get the current text entered
	loRange = .GetSel(True)
	lcTextLine = .GetLine(loRange.StartLineNo)
	IF !EMPTY(lcTextLine)
		lcComment = GKCGetCommentStyle()
		IF LEFT(lcTextLine,1)!="*" .AND. lcTextLine!=lcComment     && Check line is not commented out
*-*			Check if position is after in-line comment (&&)
			lnCol = ATC(CHR(38)+CHR(38),lcTextLine)
			IF lnCol > 0 .AND. lnCol < loRange.StartColNo
				llReturn = False
			ELSE
*-*				Get the entered text by user
				lcVName = ""
				FOR lnCol=loRange.StartColNo TO 0 STEP -1
					lcChr = SUBSTR(lcTextLine,lnCol,1)
					lnChr = ASC(UPPER(lcChr))
					IF BETWEEN(lnChr,48,57) .OR. BETWEEN(lnChr,65,90) .OR. lnChr = 95
						lcVName = lcChr + lcVName
					ELSE
						EXIT
					ENDIF
				ENDFOR
				lcVName = lcVName + CHR(tnKeyAscii)
				IF LEN(lcVName) > 2
*-*					Reset the member list
					FOR lnNdx=0 TO .Globals.MemberLists.Count-1
						IF .Globals.MemberLists(lnNdx).Name = "VFPTempMbrList"
							.Globals.MemberLists.Remove("VFPTempMbrList")
							EXIT
						ENDIF
					ENDFOR
					loMbrList = CREATEOBJECT("CodeMax.MemberList.4")
					WITH loMbrList
						.Name = "VFPTempMbrList"
						.CaseSensitive = False
						.Language = toCodeMax.Language
*-*						Get the matching variables for current method
						lnMbrCnt = 0
						SELECT c_variables
						SCAN FOR ALLTRIM(UPPER(vmethod))==UPPER(toCodeMax.MethodName) .AND. UPPER(vname) = UPPER(lcVName)
							lnMbrCnt = lnMbrCnt + 1
							.Add(ALLTRIM(c_variables.vname),"",cmImgVariable)
						ENDSCAN
						DO CASE
							CASE lnMbrCnt = 1
								lnMbrCnt = lnMbrCnt + 1
								.Add(lcVName,"")
								.Register()
							CASE lnMbrCnt > 1
								.Register()
						ENDCASE
					ENDWITH
					IF lnMbrCnt > 0
						.MemberList = loMbrList
						.ExecuteCmd(cmCmdCompleteWord)
						llReturn = True
					ELSE
						llReturn = False
					ENDIF
				ELSE
					llReturn = False
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDWITH
RETURN llReturn
ENDFUNC