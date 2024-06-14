*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Restores the bookmarks defined in the CodeMax block
*-*
FUNCTION GKKSetBookmarkSettings
LPARAMETERS toCodeMax, tcBookmarks
LOCAL lnCnt
#DEFINE True  .T.
FOR lnCnt=1 TO GETWORDCOUNT(tcBookmarks,"|")
	toCodeMax.SetBookmark(INT(VAL(GETWORDNUM(tcBookmarks,lnCnt,"|"))), True)
ENDFOR
ENDFUNC