************************************************************************************************
* Written by:  Gregory A. Green
*              980 Windmill Parkway
*              Evans, GA  30809
*              (706) 651-1640
*
************************************************************************************************
*  Routine for Increment to the next sequential ID number using 0-9, A-Z
*
FUNCTION GKPINCSEQ
LPARAMETERS pcFieldName,pcFirstChar
LOCAL lcOrgAlias, lcFirst, lnDecPlace, lcAlias, lcField, lnNdx, lnLen, lcNextID, lcFieldValue, llNext
LOCAL lnChr
lcOrgAlias = ALIAS()
pcFieldName = ALLTRIM(pcFieldName)
lcFirst = "1"
lnDecPlace = ATC(".",pcFieldName)
pcFieldName = ALLTRIM(pcFieldName)
lnLen    = LEN(pcFieldName)
lcNextID = ""                                                  && Get next ID number
llNext   = .T.
DO WHILE llNext                                                && Loop to increment decimal places
	IF lnLen > 0
		lnChr = ASC(SUBSTR(pcFieldName,lnLen,1))
		IF lnChr>=48 .AND. lnChr<57                            && Check if digit is 0-8
			lnChr = lnChr + 1                                  && Increment digit
			llNext = .F.
		ELSE
			IF lnChr = 57                                      && Check if digit is 9
				lnChr = 65                                     && Set to character A
				llNext = .F.
			ELSE
				IF lnChr < 90
					lnChr = lnChr + 1                          && Increment digit
					llNext = .F.
				ELSE
					lnChr = 48                                 && Set to character 0
				ENDIF
			ENDIF
		ENDIF
		lcNextID = CHR(lnChr) + lcNextID
		lnLen    = lnLen - 1
	ELSE
		lcNextID = "1" + lcNextID
		EXIT
	ENDIF
ENDDO
IF lnLen > 0
	lcNextID = LEFT(pcFieldName,lnLen) + lcNextID
ENDIF
RETURN ALLTRIM(lcNextID)
ENDFUNC