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
FUNCTION GKKCodeLibrary
LPARAMETERS tcFormInstance
IF PEMSTATUS(_SCREEN,"GKKTools",5)
	IF ISNULL(_SCREEN.GKKTools)
		_SCREEN.GKKTools = CREATEOBJECT("Empty")
	ENDIF
ELSE
	_SCREEN.AddProperty("GKKTools")
	_SCREEN.GKKTools = CREATEOBJECT("Empty")
ENDIF
IF !PEMSTATUS(_SCREEN.GKKTools,"SnippetMgr",5)
	ADDPROPERTY(_SCREEN.GKKTools,"SnippetMgr",.NULL.)
ENDIF
IF !('GKLDeclareAPI' $ SET( 'Procedure' ))
	SET PROCEDURE TO GKLDeclareAPI ADDITIVE
ENDIF
IF PCOUNT() = 0
	tcFormInstance = SYS(2015)
ENDIF
lcSystemApp = GKLGetSystemAPP()
IF !EMPTY(lcSystemApp)
	DO (lcSystemApp)
	DO FORM GKLCodeLibrary WITH tcFormInstance
ENDIF
ENDFUNC