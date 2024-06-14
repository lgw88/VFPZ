*-************************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-* Copyright ©2010 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-************************************************************************************************
*-*
*-*  Routine for clearing the Readonly attribute on a file
*-*
FUNCTION GKPFileAttributeClearReadOnly
LPARAMETERS tcFileType, tcFileName
LOCAL llSuccess
#INCLUDE "GKPDefines.h"
llSuccess = True
IF apiSetFileAttributes(tcFileName, BITAND(apiGetFileAttributes(tcFileName), BITNOT(FILE_ATTRIBUTE_READONLY))) != 0
	DO CASE
		CASE tcFileType = PRJTYPE_FORM
			tcFileName = FORCEEXT(tcFileName,"sct")
			IF apiSetFileAttributes(tcFileName, BITAND(apiGetFileAttributes(tcFileName), BITNOT(FILE_ATTRIBUTE_READONLY))) = 0
				llSuccess = False
			ENDIF
	
		CASE tcFileType = PRJTYPE_VCX
			tcFileName = FORCEEXT(tcFileName,"vct")
			IF apiSetFileAttributes(tcFileName, BITAND(apiGetFileAttributes(tcFileName), BITNOT(FILE_ATTRIBUTE_READONLY))) = 0
				llSuccess = False
			ENDIF
	
		CASE tcFileType = PRJTYPE_DBC
			tcFileName = FORCEEXT(tcFileName,"dct")
			IF apiSetFileAttributes(tcFileName, BITAND(apiGetFileAttributes(tcFileName), BITNOT(FILE_ATTRIBUTE_READONLY))) = 0
				llSuccess = False
			ENDIF
			tcFileName = FORCEEXT(tcFileName,"dcx")
			IF apiSetFileAttributes(tcFileName, BITAND(apiGetFileAttributes(tcFileName), BITNOT(FILE_ATTRIBUTE_READONLY))) = 0
				llSuccess = False
			ENDIF
	
		CASE tcFileType = PRJTYPE_TABLE
			tcFileName = FORCEEXT(tcFileName,"fpt")
			IF FILE(tcFileName)
				IF apiSetFileAttributes(tcFileName, BITAND(apiGetFileAttributes(tcFileName), BITNOT(FILE_ATTRIBUTE_READONLY))) = 0
					llSuccess = False
				ENDIF
			ENDIF
			tcFileName = FORCEEXT(tcFileName,"cdx")
			IF FILE(tcFileName)
				IF apiSetFileAttributes(tcFileName, BITAND(apiGetFileAttributes(tcFileName), BITNOT(FILE_ATTRIBUTE_READONLY))) = 0
					llSuccess = False
				ENDIF
			ENDIF
	
		CASE tcFileType = PRJTYPE_REPORT
			tcFileName = FORCEEXT(tcFileName,"frt")
			IF apiSetFileAttributes(tcFileName, BITAND(apiGetFileAttributes(tcFileName), BITNOT(FILE_ATTRIBUTE_READONLY))) = 0
				llSuccess = False
			ENDIF
	
		CASE tcFileType = PRJTYPE_LABEL
			tcFileName = FORCEEXT(tcFileName,"lrt")
			IF apiSetFileAttributes(tcFileName, BITAND(apiGetFileAttributes(tcFileName), BITNOT(FILE_ATTRIBUTE_READONLY))) = 0
				llSuccess = False
			ENDIF
	
		CASE tcFileType = PRJTYPE_MENU
			tcFileName = FORCEEXT(tcFileName,"mnt")
			IF apiSetFileAttributes(tcFileName, BITAND(apiGetFileAttributes(tcFileName), BITNOT(FILE_ATTRIBUTE_READONLY))) = 0
				llSuccess = False
			ENDIF
	
		CASE tcFileType = PRJTYPE_QUERY

		OTHERWISE
			llSuccess = True
	ENDCASE
ELSE
	llSuccess = False
ENDIF
RETURN llSuccess
ENDFUNC