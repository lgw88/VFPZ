*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Gets the bookmarks defined in the CodeMax block
*-*
FUNCTION GKKGetBookmarkSettings
LPARAMETERS toCodeMax, tnBegLine, tnEndLine
LOCAL lcBookmarks
lcBookmarks = ""
FOR lnLine=tnBegLine TO tnEndLine
	IF toCodeMax.GetBookmark(lnLine)
		lcBookmarks = lcBookmarks + "|" + TRANSFORM(lnLine)
	ENDIF
ENDFOR
RETURN IIF(EMPTY(lcBookmarks), "", SUBSTR(lcBookmarks,2))
ENDFUNC