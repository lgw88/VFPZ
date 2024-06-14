*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              green.gregory@comcast.net
*-*
*-* Copyright ©2012 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Program to check for local configuration setup
*-*
#IFNDEF GKKLibrarian
#INCLUDE GKKLibrarian.h
#ENDIF
FUNCTION IsLocalConfigDefined
LPARAMETERS tcDirectory
LOCAL lcFile
lcFile = ADDBS(tcDirectory) + "gkkuser.dbf"
IF FILE(lcFile)
	RETURN False
ELSE
	RETURN True
ENDIF
ENDFUNC