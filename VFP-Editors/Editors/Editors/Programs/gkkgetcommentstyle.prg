*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Determines users comment style
*-*
FUNCTION GKKGetCommentStyle
LOCAL lcVersion, lcRegistry, lcComment
lcVersion  = STR(INT(VAL(LEFT(VERSION(4),3))),1) + ".0"
lcRegistry = "SOFTWARE\Microsoft\VisualFoxPro\" + lcVersion + "\Options"
lcComment  = GKKGetRegString_HKCU(lcRegistry,"EditorCommentString")
IF EMPTY(lcComment)
	lcComment = "*!*"
ENDIF
RETURN lcComment
ENDFUNC