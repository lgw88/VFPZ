************************************************************************************************
* Written by:  Gregory A. Green
*
************************************************************************************************
*  Routine for Increment to the next sequential ID number using 0-9, A-Z
*
#IFNDEF GKKMembership
#INCLUDE ..\..\common\includes\gkkdefines.h
#ENDIF
FUNCTION INCSEQ
LPARAMETERS tcLastID
LOCAL lnLen, lcNextID, llNext, lnChr
tcLastID = ALLTRIM(tcLastID)
lnLen    = LEN(tcLastID)
lcNextID = ""
llNext   = True
DO WHILE llNext                                                && Loop to increment decimal places
	IF lnLen > 0
		lnChr = ASC(SUBSTR(tcLastID,lnLen,1))
		IF lnChr>=48 .AND. lnChr<57                            && Check if digit is 0-8
			lnChr = lnChr + 1                                  && Increment digit
			llNext = False
		ELSE
			IF lnChr = 57                                      && Check if digit is 9
				lnChr = 65                                     && Set to character A
				llNext = False
			ELSE
				IF lnChr < 90
					lnChr = lnChr + 1                          && Increment digit
					llNext = False
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
	lcNextID = LEFT(tcLastID,lnLen) + lcNextID
ENDIF
RETURN ALLTRIM(lcNextID)
ENDFUNC