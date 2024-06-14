*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-***********************************************************************************************
*-*  Routine for saving the settings to the resource file
*-*
#IFNDEF gkkmembership
#INCLUDE ..\..\common\includes\gkkdefines.h
#ENDIF
FUNCTION SetStringLocal
LPARAMETERS tcSubkey, tcEntry, tcStrValue
LOCAL lcAlias, lcStrBuffer, lnIntValue, lnDecValue, llReturn
lcAlias = ALIAS()
IF GetResource()
*-*	Convert data to type character
	DO CASE                                           && Determine data type to write
		CASE VARTYPE(tcStrValue) = "C"                && User string is of char type
			lcStrBuffer = ALLTRIM(tcStrValue)

		CASE VARTYPE(tcStrValue) = "N"                && User string is numeric
			lnIntValue = INT(tcStrValue)
			lnDecValue = (tcStrValue - lnIntValue) * 10000
			lcStrBuffer = TRANSFORM(lnIntValue) + "." + TRANSFORM(lnDecValue)

		CASE VARTYPE(tcStrValue) = "D"                && User string is date
			lcStrBuffer = DTOC(tcStrValue)

		CASE VARTYPE(tcStrValue) = "T"                && User string is date-time
			lcStrBuffer = TTOC(tcStrValue)

		CASE VARTYPE(tcStrValue) = "L"                && User string is logical
			IF tcStrValue
				lcStrBuffer = ".T."
			ELSE
				lcStrBuffer = ".F."
			ENDIF

		CASE VARTYPE(tcStrValue) = "Y"                && User string is currency
			lcStrBuffer = TRANSFORM(tcStrValue)

		OTHERWISE
			lcStrBuffer = tcStrValue
	ENDCASE
	lnCkVal = VAL(ALLTRIM(SYS(2007, SUBSTR(lcStrBuffer, 3))))
*-*	Save the settings
	SELECT gkkuser
	LOCATE FOR type='GKKSETTINGS' .AND. ALLTRIM(id)==UPPER(tcSubkey) .AND. ALLTRIM(name)==UPPER(tcEntry) .AND. !DELETED()
	IF FOUND()
		REPLACE gkkuser.data    WITH lcStrBuffer
		REPLACE gkkuser.ckval   WITH lnCkVal
		REPLACE gkkuser.updated WITH DATE()
	ELSE
		INSERT INTO gkkuser (type, id, NAME, data, ckval, updated) ;
			VALUES ('GKKSETTINGS', UPPER(tcSubkey), UPPER(tcEntry), lcStrBuffer, lnCkVal, DATE())
	ENDIF
	USE IN gkkuser
	llReturn = True
	IF !EMPTY(lcAlias)
		SELECT (lcAlias)
	ENDIF
ELSE
	llReturn = False
ENDIF
RETURN llReturn
ENDFUNC