*-***********************************************************************************************
*-*  Builds the database in the selected directory
*-*
#IFNDEF GKKLibrarian
#INCLUDE GKKLibrarian.h
#ENDIF
FUNCTION BuildDatabase
LPARAMETERS tcPath
LOCAL lcDbcName, lcTableName, loException, llSuccess
llSuccess = True
TRY
	lcDbcName = ADDBS(tcPath) + "GKKLibrarian.dbc"
	CREATE DATABASE (lcDbcName)


CATCH TO loException
	SET STEP ON
	llSuccess = False
ENDTRY
RETURN llSuccess
ENDFUNC 