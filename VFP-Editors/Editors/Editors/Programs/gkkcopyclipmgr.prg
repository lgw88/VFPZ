*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              green.gregory@comcast.net
*-*
*-* Copyright ©2011 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Main entry point for application
*-*
FUNCTION GKKCopyClipMgr
IF PEMSTATUS(_SCREEN,"GKKTools",5)
	IF ISNULL(_SCREEN.GKKTools)
		_SCREEN.GKKTools = CREATEOBJECT("Empty")
	ENDIF
ELSE
	_SCREEN.AddProperty("GKKTools")
	_SCREEN.GKKTools = CREATEOBJECT("Empty")
ENDIF
IF PEMSTATUS(_SCREEN.GKKTools,"CopyClipMgr",5)
	IF VARTYPE(_SCREEN.GKKTools.CopyClipMgr) != "O"
		_SCREEN.GKKTools.CopyClipMgr = NEWOBJECT("CopyClipMgr","GKKCopyClipMgr.vcx")
	ENDIF
ELSE
	ADDPROPERTY(_SCREEN.GKKTools,"CopyClipMgr",.NULL.)
	_SCREEN.GKKTools.CopyClipMgr = NEWOBJECT("CopyClipMgr","GKKCopyClipMgr.vcx")
ENDIF
IF !('GKKDeclareAPI' $ SET( 'Procedure' ))
	SET PROCEDURE TO GKKDeclareAPI ADDITIVE
ENDIF
