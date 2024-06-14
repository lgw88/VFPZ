*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              green.gregory@comcast.net
*-*
*-* Copyright ©2011 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Returns the file system datetime stamp for a file
*-*
FUNCTION GKPGetFileTimeStamp
LPARAMETERS tcFileName
LOCAL lnYr, lnMon, lnDay, lnHrs, lnMin, lnSec
LOCAL ARRAY laFileList[1,5]
IF ADIR(laFileList,tcFileName) > 0
	lnYr  = YEAR(laFileList[1,3])
	lnMon = MONTH(laFileList[1,3])
	lnDay = DAY(laFileList[1,3])
	lnHrs = VAL(LEFT(laFileList[1,4],2))
	lnMin = VAL(SUBSTR(laFileList[1,4],4,2))
	lnSec = VAL(SUBSTR(laFileList[1,4],7,2))
	RETURN DATETIME(lnYr, lnMon, lnDay, lnHrs, lnMin, lnSec)
ELSE
	RETURN DATETIME()
ENDIF
ENDFUNC