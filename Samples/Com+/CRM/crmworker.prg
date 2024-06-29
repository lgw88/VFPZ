#INCLUDE crmfiles.h

DEFINE CLASS CrmFilesWorkerVFP AS session OLEPUBLIC

PROTECTED oCrmLogControl, lHadError, cTempFile
oCrmLogControl = ""
lHadError = .F.
cTempFile = ""

PROCEDURE mydocmd(cCmd as string) as void
	&cCmd
	
PROCEDURE myeval(cExpr as string) as variant
	return &cexpr
	
PROCEDURE Init
	DECLARE Sleep IN Win32API Integer
ENDPROC

PROTECTED PROCEDURE OutputLog(cStr)
	IF EMPTY(cStr) OR LOGGINGOFF
		RETURN
	ENDIF
	STRTOFILE(TRANSFORM(cStr) + CRLF,LOGFILE,.T.)
ENDPROC

PROTECTED PROCEDURE RegisterCrmFilesCompensator
	LOCAL lcProgIdCompensator, lcDescription, lnErr
	lcProgIdCompensator = COMP_PROGID
	lcDescription = COMP_DESC_LOC
	IF VARTYPE(THIS.oCrmLogControl)#"O"
		THIS.oCrmLogControl = CREATEOBJECTEX(CLERKCLASS,"","")
	ENDIF
	FOR i = 1 TO RETRIES
		* we may have to wait while recovery is in progress (XACT_E_RECOVERYINPROGRESS) 
		lnErr = THIS.oCrmLogControl.RegisterCompensator(lcProgIdCompensator, lcDescription, CRMREGFLAG_ALLPHASES)
		IF !THIS.lHadError
			EXIT
		ENDIF
	ENDFOR
	RETURN THIS.lHadError
ENDPROC

PROTECTED PROCEDURE WriteLog(cFileName,cType)
	LOCAL lcFileName, lcTempFile, lcType, laLogRecord
	lcFileName = cFileName
	lcType = cType
    lcTempFile = ADDBS(SYS(2023))+SYS(2015)+".TMP"
    THIS.cTempFile = lcTempFile

	DIMENSION laLogRecord[3]
	laLogRecord[1] = lcType
	laLogRecord[2] = lcFileName
	laLogRecord[3] = lcTempFile
    
	* Register the CRM Compensator
	IF THIS.RegisterCrmFilesCompensator()
    	RETURN .F.
	ENDIF
	THIS.OutputLog("RegisterCrmFilesCompensator...")

    * Create and write durable log of action to take (create file)
	COMARRAY(THIS.oCrmLogControl,0)								&& must call - zero based array
    THIS.oCrmLogControl.WriteLogRecordVariants(@laLogRecord)	&&write out the log record -- array of variants
    
	IF THIS.lHadError
		THIS.oCrmLogControl.ForceTransactionToAbort()
		RETURN .F.		
	ENDIF
	THIS.OutputLog("WriteLogRecordVariants...")

	* Write out log
	THIS.oCrmLogControl.ForceLog()
	IF THIS.lHadError
		THIS.oCrmLogControl.ForceTransactionToAbort()
		RETURN .F.
	ENDIF
	THIS.OutputLog("ForceLog...")
	RETURN .T.
ENDPROC

PROCEDURE CreateFile(cFileName)
	* Check if file exists
	LOCAL lcFileName
	lcFileName = ALLTRIM(cFileName)
	IF FILE(lcFileName)
		THIS.OutputLog(FILEMSG1_LOC + TRANSFORM(lcFileName))
		RETURN .F.
	ENDIF
	THIS.OutputLog(FILEMSG2_LOC + TRANSFORM(lcFileName))
	
	* Write out durable log
	IF !THIS.WriteLog(lcFileName,"1")
		RETURN .F.
	ENDIF
	
	* Try to create file now
	STRTOFILE("VFP CRM Sample",lcFileName)
	IF THIS.lHadError
		THIS.oCrmLogControl.ForceTransactionToAbort()
		RETURN .F.
	ENDIF
	
	* Success
	RETURN .T.
ENDPROC

PROCEDURE DeleteFile(cFileName)
	* Check if file does not exist
	LOCAL lcFileName
	lcFileName = ALLTRIM(cFileName)	
	IF !FILE(lcFileName)
		THIS.OutputLog(FILEMSG2_LOC + TRANSFORM(lcFileName))
		RETURN .F.
	ENDIF
	THIS.OutputLog(FILEMSG1_LOC + TRANSFORM(lcFileName))
		
	* Write out durable log
	IF !THIS.WriteLog(lcFileName,"2")
		RETURN .F.
	ENDIF
	
	* Try to make backup file and delete original
	COPY FILE (lcFileName) TO (THIS.cTempFile)
	IF FILE(THIS.cTempFile)
		DELETE FILE (lcFileName)
	ENDIF
	IF THIS.lHadError
		THIS.oCrmLogControl.ForceTransactionToAbort()
		RETURN .F.
	ENDIF
	
	* Success
	RETURN .T.
ENDPROC

PROCEDURE ERROR(nError, cMethod, nLine)
LOCAL lcStr
THIS.lHadError=.T.
TEXT TO lcStr TEXTMERGE NOSHOW
Error in CRM Worker...
 Error: <<TRANSFORM(nError)>>
 Method: <<TRANSFORM(cMethod)>>
 Line: <<TRANSFORM(nLine)>>
 Message: <<TRANSFORM(MESSAGE())>>
ENDTEXT
STRTOFILE(lcStr+CRLF,ERRLOG,.T.)
ENDPROC

ENDDEFINE
