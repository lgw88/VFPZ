*-***********************************************************************************************
*-*
*-* Copyright ©2014 Gregory A. Green
*-*
*-***********************************************************************************************
*-*
*-*  Procedure for handling errors trapped by TRY-CATCH
*-*
FUNCTION WriteErrorLog
LPARAMETERS toException
LOCAL lcLogText, lnNdx, lhLogFile, lcHdrText
SET STEP ON
lcLogText = "An error has occurred - please close the current form."
WMSGBOX(lcLogText, "GKK Librarian", 16, "ERROR")

lcLogText =             "          Error Number:            " + TRANSFORM(toException.ErrorNo)        + CHR(13)+CHR(10)
lcLogText = lcLogText + "          Error Message:           " + toException.Message                   + CHR(13)+CHR(10)
lcLogText = lcLogText + "          Line of code with error: " + toException.LineContents              + CHR(13)+CHR(10)
lcLogText = lcLogText + "          Line number of error:    " + TRANSFORM(toException.LineNo)         + CHR(13)+CHR(10)
lcLogText = lcLogText + "          Procedure with Error:    " + toException.Procedure                 + CHR(13)+CHR(10)
lcLogText = lcLogText + "          Error Details:           " + toException.Details                   + CHR(13)+CHR(10)
lcLogText = lcLogText + "          Form Name:               " + toException.FormName                  + CHR(13)+CHR(10)
lcLogText = lcLogText + "          Object Name:             " + toException.ObjectName                + CHR(13)+CHR(10)
lcLogText = lcLogText + "          Object's Parent Name:    " + toException.ObjectParent              + CHR(13)+CHR(10)
lcLogText = lcLogText + "          Calling Stack:           "                                         + CHR(13)+CHR(10)
FOR lnNdx=1 TO ALEN(toException.StackInfo, 1)-1
	lcLogText = lcLogText + "               " + TRANSFORM(toException.StackInfo[lnNdx, 5]) + ": " + ;
				SUBSTR(toException.StackInfo[lnNdx, 3], ATC(".", toException.StackInfo[lnNdx, 3])+1) + ;
				" [" + JUSTSTEM((toException.StackInfo[lnNdx, 4])) + "]" + CHR(13)+CHR(10)
ENDFOR
IF GetSetting("AutoErrorNotification") = ".T."
	SendErrorEmail(lcLogText)
ELSE
	lcLogFile = ADDBS(_SCREEN.GKKTools.DataPath) + "Error.log"
	IF FILE(lcLogFile)
		lhLogFile = FOPEN(lcLogFile, 12)
		=FSEEK(lhLogFile, 0, 2)
	ELSE
		lhLogFile = FCREATE(lcLogFile)
	ENDIF
	IF lhLogFile >= 0
		lcHdrText =             "===========================================================================" + CHR(13)+CHR(10)
		lcHdrText = lcHdrText + "================== " + DTOC(DATE()) + ", "  + TIME() + " ==================" + CHR(13)+CHR(10)
		lcLogText = lcHdrText + lcLogText
		lcLogText = lcLogText + "===========================================================================" + CHR(13)+CHR(10)
		=FPUTS(lhLogFile, lcLogText)
		=FCLOSE(lhLogFile)
	ENDIF
ENDIF
ENDFUNC