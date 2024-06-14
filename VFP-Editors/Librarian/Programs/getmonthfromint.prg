*-************************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-* Copyright ©2015 Gregory A. Green
*-*
*-************************************************************************************************
*-*
*-*  Routine for returning the name of a month given the numeric value of the month; i.e. 1=January
*-*
#IFNDEF GKKLibrarian
#INCLUDE GKKLibrarian.h
#ENDIF
FUNCTION GetMonthFromInt
LPARAMETERS tnMonth, tlFullName
IF PCOUNT() < 2
	tlFullName = True
ENDIF
IF tlFullName
	RETURN CMONTH(DATE(YEAR(DATE()), tnMonth, 1))
ELSE
	RETURN LEFT(CMONTH(DATE(YEAR(DATE()), tnMonth, 1)), 3)
ENDIF
ENDFUNC