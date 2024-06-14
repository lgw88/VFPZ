*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-***********************************************************************************************
*-* Program to check for database setup
*-*
#IFNDEF GKKLibrarian
#INCLUDE GKKLibrarian.h
#ENDIF
FUNCTION CheckDatabaseNotExist
LPARAMETERS tcDirectory
LOCAL lcDBCFile
lcDBCFile = ADDBS(tcDirectory) + "GKKLibrarian.dbc"
IF FILE(lcDBCFile)
	RETURN False
ELSE
	RETURN True
ENDIF
ENDFUNC