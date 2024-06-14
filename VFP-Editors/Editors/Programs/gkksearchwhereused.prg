*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for building a whereused search list
*-*
#IFNDEF GKKDEFINES
#INCLUDE GKKDefines.h
#ENDIF
FUNCTION GKKSearchWhereUsed
LPARAMETERS toCodeMaxSrc, toResults, toCodeMax, tcFullName, tlRegExp, tlWhole, tlCase, tlCodeMaxOpen
LOCAL lnLine
WITH toCodeMaxSrc
	.Text = toCodeMax.Text
	.NoSearchWrap        = False
	.FindText            = toResults.SrchText
	.SearchRegExp        = tlRegExp
	.SearchWholeWord     = tlWhole
	.SearchCaseSensitive = tlCase
	.ExecuteCmd(cmCmdBookmarkClearAll)
	.ExecuteCmd(cmCmdFindMarkAll)
	FOR lnLine=0 TO .LineCount-1
		IF .IsBookMarkSet(lnLine)
			toResults.Count = toResults.Count + 1
			DIMENSION toResults.List[toResults.Count,5]
			toResults.List[toResults.Count,1] = tcFullName
			toResults.List[toResults.Count,3] = ALLTRIM(STRTRAN(.GetLine(lnLine),CHR(9)," "))
			toResults.List[toResults.Count,4] = toCodeMax.NodeKey
			toResults.List[toResults.Count,5] = tlCodeMaxOpen
			IF tlCodeMaxOpen
				toResults.List[toResults.Count,2] = toCodeMax.SetWhereUsedItemData(lnLine)
			ELSE
				toResults.List[toResults.Count,2] = lnLine
			ENDIF
		ENDIF
	ENDFOR
ENDWITH
ENDFUNC