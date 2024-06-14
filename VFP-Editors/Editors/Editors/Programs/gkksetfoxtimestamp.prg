*=======================================================
* Returns a FOX system file timestamp 
* from a date time value, any data type
*
*=======================================================
FUNCTION GKKSetFoxTimeStamp
LPARAMETER tvDateTime
*-------------------------------------------------------
* Default to current datetime
*-------------------------------------------------------
LOCAL ltDateTime, lvFoxTimeStamp, lvTemp
ltDateTime = CTOT(TRANSFORM(tvDateTime))
IF EMPTY(ltDateTime)
   ltDateTime = DATETIME()
ENDIF
*-------------------------------------------------------
* bits 4-0, seconds in two-second increments
*-------------------------------------------------------
lvTemp = SEC(ltDateTime) / 2
lvFoxTimeStamp = PADL(RIGHT(fIntToBin(lvTemp),5),5,"0")
*-------------------------------------------------------
* bits 10-5, minutes
*-------------------------------------------------------
lvTemp = MINUTE(ltDateTime)
lvFoxTimeStamp = PADL(RIGHT(fIntToBin(lvTemp),6),6,"0") + lvFoxTimeStamp
*-------------------------------------------------------
* bits 15-11, hours
*-------------------------------------------------------
lvTemp = HOUR(ltDateTime)
lvFoxTimeStamp = PADL(RIGHT(fIntToBin(lvTemp),5),5,"0") + lvFoxTimeStamp
*-------------------------------------------------------
* bits 20-16, days
*-------------------------------------------------------
lvTemp = DAY(ltDateTime)
lvFoxTimeStamp = PADL(RIGHT(fIntToBin(lvTemp),5),5,"0") + lvFoxTimeStamp
*-------------------------------------------------------
* bits 24-21, months
*-------------------------------------------------------
lvTemp = MONTH(ltDateTime)
lvFoxTimeStamp = PADL(RIGHT(fIntToBin(lvTemp),4),4,"0") + lvFoxTimeStamp
*-------------------------------------------------------
* bits 31-25, years with a 1980 offset
*-------------------------------------------------------
lvTemp = YEAR(ltDateTime)-1980
lvFoxTimeStamp = PADL(RIGHT(fIntToBin(lvTemp),7),7,"0") + lvFoxTimeStamp
lvFoxTimeStamp = fBinToInt(lvFoxTimeStamp)
RETURN lvFoxTimeStamp
ENDFUNC


*=======================================================
* Returns a binary form of an integer
*
FUNCTION fIntToBin
LPARAMETERS tnInteger
LOCAL lnInteger,lcBinary,lnDivisor,lnCount
IF EMPTY(tnInteger)
	RETURN "0"
ENDIF
lnInteger=INT(tnInteger)
lcBinary=""
FOR lnCount = 31 TO 0 STEP -1
	lnDivisor=2^lnCount
	IF lnDivisor>lnInteger
		lcBinary=lcBinary+"0"
		LOOP
	ENDIF
	lcBinary=lcBinary+IIF((lnInteger/lnDivisor)>0,"1","0")
	lnInteger=INT(lnInteger-lnDivisor)
ENDFOR
RETURN lcBinary
ENDFUNC


*=======================================================
* Returns an integer form of binary data
*
FUNCTION fBinToInt
LPARAMETERS tcBinary
LOCAL lcInteger,lnInteger,lnCount,lnStrLen
IF EMPTY(tcBinary)
	RETURN 0
ENDIF
lnStrLen=LEN(tcBinary)
lnInteger=0
FOR lnCount = 0 TO (lnStrLen-1)
	IF SUBSTR(tcBinary,lnStrLen-lnCount,1)=="1"
		lnInteger=lnInteger+2^lnCount
	ENDIF
ENDFOR
RETURN INT(lnInteger)
ENDFUNC