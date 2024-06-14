*-********************************************************************************************************************
*-*  Written by Gregory Green
*-*
*-*  Copyright 2016
*-********************************************************************************************************************
*-*  Function to return the schema code for table difference
*-*
#IFNDEF gkkmembership
#INCLUDE GKCDefines.h
#ENDIF
FUNCTION GKCGetDbfSchemaDiff
LPARAMETERS tcSrcTable, tcTgtTable
LOCAL loSchemaDiff, lnSrcFldCnt, lnSrcTagCnt, lnTgtFldCnt, lnTgtTagCnt, loException, lcUserMsg, lnNdx
LOCAL lcSchema, lcIndexes, lnFld, llIndexNotEqual
LOCAL ARRAY laSrcFlds[1, 18], laTgtFlds[1, 18]
loSchemaDiff = CREATEOBJECT("Empty")
ADDPROPERTY(loSchemaDiff, "Fields", "")
ADDPROPERTY(loSchemaDiff, "Indexes", "")
TRY
	USE SHARED (tcSrcTable) AGAIN ALIAS gkctabdiff IN 0
	lnSrcFldCnt = AFIELDS(laSrcFlds, "gkctabdiff")
	lnSrcTagCnt = ATAGINFO(laSrcTags, "gkctabdiff")
	USE IN gkctabdiff

	USE SHARED (tcTgtTable) AGAIN ALIAS gkctabdiff IN 0
	lnTgtFldCnt = AFIELDS(laTgtFlds, "gkctabdiff")
	lnTgtTagCnt = ATAGINFO(laTgtTags, "gkctabdiff")
	USE IN gkctabdiff

*-*	Get the fields to be dropped in the target table
	lcSchema = "ALTER TABLE '" + JUSTSTEM(tcTgtTable) + "'"
	FOR lnNdx=1 TO lnTgtFldCnt
		IF ASCAN(laSrcFlds, laTgtFlds[lnNdx, 1], 1, lnSrcFldCnt, 1, 15) = 0
			lcSchema = lcSchema + " DROP COLUMN " + laTgtFlds[lnNdx, 1]
		ENDIF
	ENDFOR
*-*	Add missing fields in source table not in target table
	FOR lnNdx=1 TO lnSrcFldCnt
		lnFld = ASCAN(laTgtFlds, laSrcFlds[lnNdx, 1], 1, lnTgtFldCnt, 1, 15)
		IF lnFld = 0
			lcSchema = lcSchema + " ADD COLUMN " + laSrcFlds[lnNdx, 1] + " "
			DO CASE
				CASE INLIST(laSrcFlds[lnNdx, 2], "L", "M", "W", "G", "D", "T", "Y")
					lcSchema = lcSchema + laSrcFlds[lnNdx, 2]
			
				CASE INLIST(laSrcFlds[lnNdx, 2], "C", "Q", "V")
					lcSchema = lcSchema + laSrcFlds[lnNdx, 2] + "(" + TRANSFORM(laSrcFlds[lnNdx, 3]) + ")"
			
				CASE INLIST(laSrcFlds[lnNdx, 2], "B", "F", "N")
					lcSchema = lcSchema + " " + laSrcFlds[lnNdx, 2] + "(" + TRANSFORM(laSrcFlds[lnNdx, 3]) + ", " + TRANSFORM(laSrcFlds[lnNdx, 4]) + ")"
			
				CASE laSrcFlds[lnNdx, 2] = "I"
					lcSchema = lcSchema + laSrcFlds[lnNdx, 2]
					IF laSrcFlds[lnNdx, 18] > 0
						lcSchema = lcSchema + " AUTOINC NEXTVALUE " + TRANSFORM(laSrcFlds[lnNdx, 17]) + " STEP " + TRANSFORM(laSrcFlds[lnNdx, 18])
					ENDIF
			ENDCASE
			IF laSrcFlds[lnNdx, 5]
				lcSchema = lcSchema + " NULL"
			ELSE
				lcSchema = lcSchema + " NOT NULL"
			ENDIF
			IF laSrcFlds[lnNdx, 6] .AND. INLIST(laSrcFlds[lnNdx, 2], "C", "M", "V")
				lcSchema = lcSchema + " NOCPTRANS"
			ENDIF
			IF  !EMPTY(laSrcFlds[lnNdx, 7])
				lcSchema = lcSchema + " CHECK " + laSrcFlds[lnNdx, 7]
			ENDIF
			IF  !EMPTY(laSrcFlds[lnNdx, 8])
				lcSchema = lcSchema + " ERROR " + laSrcFlds[lnNdx, 8]
			ENDIF
			IF  !EMPTY(laSrcFlds[lnNdx, 9])
				lcSchema = lcSchema + " DEFAULT " + laSrcFlds[lnNdx, 9]
			ENDIF
		ELSE
			IF laTgtFlds[lnFld, 2] != laSrcFlds[lnNdx, 2] .OR. laTgtFlds[lnFld, 3] != laSrcFlds[lnNdx, 3]    && Compare field types & sizes
				lcSchema = lcSchema + " ALTER COLUMN " + laTgtFlds[lnFld, 1] + " "
				DO CASE
					CASE INLIST(laSrcFlds[lnNdx, 2], "L", "M", "W", "G", "D", "T", "Y")
						lcSchema = lcSchema + laSrcFlds[lnNdx, 2]

					CASE INLIST(laSrcFlds[lnNdx, 2], "C", "Q", "V")
						lcSchema = lcSchema + laSrcFlds[lnNdx, 2] + "(" + TRANSFORM(laSrcFlds[lnNdx, 3]) + ")"

					CASE INLIST(laSrcFlds[lnNdx, 2], "B", "F", "N")
						lcSchema = lcSchema + " " + laSrcFlds[lnNdx, 2] + "(" + TRANSFORM(laSrcFlds[lnNdx, 3]) + ", " + TRANSFORM(laSrcFlds[lnNdx, 4]) + ")"

					CASE laSrcFlds[lnNdx, 2] = "I"
						lcSchema = lcSchema + laSrcFlds[lnNdx, 2]
						IF laSrcFlds[lnNdx, 18] > 0
							lcSchema = lcSchema + " AUTOINC NEXTVALUE " + TRANSFORM(laSrcFlds[lnNdx, 17]) + " STEP " + TRANSFORM(laSrcFlds[lnNdx, 18])
						ENDIF
				ENDCASE
			ENDIF
		ENDIF
	ENDFOR
	loSchemaDiff.Fields = lcSchema

*-*	Get the index tags to be dropped in the target table
	lcIndexes = ""
	FOR lnNdx=1 TO lnSrcTagCnt
		IF ASCAN(laTgtTags, laSrcTags[lnNdx, 1], 1, lnTgtTagCnt, 1, 15) = 0
			lcIndexes = lcIndexes + "DELETE TAG " + laSrcTags[lnNdx, 1] + CRLF
		ENDIF
	ENDFOR
*-*	Get the index tags to be added or changed
	FOR lnNdx=1 TO lnTgtTagCnt
		lnTag = ASCAN(laSrcTags, laTgtTags[lnNdx, 1], 1, lnSrcTagCnt, 1, 15)
		IF lnTag = 0
			lcIndexes = lcIndexes + "INDEX ON " + laTgtTags[lnNdx, 3] + " TAG " + laTgtTags[lnNdx, 1]
			IF !EMPTY(laTgtTags[lnNdx, 4])
				lcIndexes = lcIndexes + " FOR " + laTgtTags[lnNdx, 4]
			ENDIF
			IF UPPER(laTgtTags[lnNdx, 5]) = "DESCENDING"
				lcIndexes = lcIndexes + "DESCENDING"
			ENDIF
			lcIndexes = lcIndexes + CRLF
		ELSE
			llIndexNotEqual = False
			DO CASE
				CASE CHRTRAN(laTgtTags[lnNdx, 3], " ", "") != CHRTRAN(laSrcTags[lnTag, 3], " ", "")     && Check expressions equal
					llIndexNotEqual = True
				
				CASE CHRTRAN(laTgtTags[lnNdx, 4], " ", "") != CHRTRAN(laSrcTags[lnTag, 4], " ", "")     && Check filter equal
					llIndexNotEqual = True
				
				CASE laTgtTags[lnNdx, 5] != laSrcTags[lnTag, 5]                                         && Check order equal
					llIndexNotEqual = True

				OTHERWISE
					llIndexNotEqual = False
			ENDCASE
			IF llIndexNotEqual
				lcIndexes = lcIndexes + "DELETE TAG " + laSrcTags[lnTag, 1] + CRLF
				lcIndexes = lcIndexes + "INDEX ON " + laTgtTags[lnNdx, 3] + " TAG " + laTgtTags[lnNdx, 1]
				IF !EMPTY(laTgtTags[lnNdx, 4])
					lcIndexes = lcIndexes + " FOR " + laTgtTags[lnNdx, 4]
				ENDIF
				IF UPPER(laTgtTags[lnNdx, 5]) = "DESCENDING"
					lcIndexes = lcIndexes + "DESCENDING"
				ENDIF
				lcIndexes = lcIndexes + CRLF
			ENDIF
		ENDIF
	ENDFOR
	loSchemaDiff.Indexes = lcIndexes

CATCH TO loException
	SET STEP ON
	lcUserMsg = 'Unable to open table for difference: ' + loException.Message
	GKCWMSGBOX(lcUserMsg, "GKC Project Manager", 16, "WARNING")
ENDTRY
RETURN loSchemaDiff
ENDFUNC