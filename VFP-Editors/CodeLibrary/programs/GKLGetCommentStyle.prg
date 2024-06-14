*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2005 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Determines users comment style
*-*
FUNCTION GKLGetCommentStyle
LOCAL lcVersion, lcRegistry, lcComment
lcVersion  = STR(INT(VAL(LEFT(VERSION(4),3))),1) + ".0"
lcRegistry = "SOFTWARE\Microsoft\VisualFoxPro\" + lcVersion + "\Options"
lcComment  = GKLGetRegString_HKCU(lcRegistry,"EditorCommentString")
IF EMPTY(lcComment)
	lcComment = "*!*"
ENDIF
RETURN lcComment
ENDFUNC