#INCLUDE crmfiles.h

DEFINE CLASS CrmFilesVFP AS session OLEPUBLIC

PROTECTED lHadError, oMTX, oContext, nAction, cFileName

lHadError = .F.
oMTX = ""
oContext = ""
nAction = 1
cFileName = ""

PROCEDURE Init
	IF RESETLOGS
		DELETE FILE (ERRLOG)
		DELETE FILE (LOGFILE)
	ENDIF
ENDPROC

PROTECTED PROCEDURE OutputLog(cStr)
	IF EMPTY(cStr) OR LOGGINGOFF
		RETURN
	ENDIF
	STRTOFILE(TRANSFORM(cStr) + CRLF,LOGFILE,.T.)
ENDPROC

PROCEDURE mydocmd(cCmd as string) as void
	&cCmd
ENDPROC
	
PROCEDURE myeval(cExpr as string) as variant
	return &cexpr
ENDPROC

PROTECTED PROCEDURE UpdateFile
	LOCAL loWorker,lSuccess
	THIS.oMTX = CREATEOBJECT(MTX_CLASS)
	THIS.oContext = THIS.oMTX.GetObjectContext()
	loWorker = CreateObject(CRM_WORKER_VFP)
	lSuccess = .F.
	IF VARTYPE(loWorker)="O"
		DO CASE
		CASE THIS.nAction = 1
			lSuccess = loWorker.CreateFile(THIS.cFileName)
		CASE THIS.nAction = 2
			lSuccess = loWorker.DeleteFile(THIS.cFileName)
		OTHERWISE
			RETURN lSuccess	
		ENDCASE
	ENDIF
	IF !lSuccess
		THIS.AbortFile()
	ENDIF
	RETURN lSuccess
ENDPROC

PROCEDURE CreateFile(cFileName)
	THIS.cFileName = cFileName
	THIS.nAction = 1
	RETURN THIS.UpdateFile()
ENDPROC

PROCEDURE DeleteFile(cFileName)
	THIS.cFileName = cFileName
	THIS.nAction = 2
	RETURN THIS.UpdateFile()
ENDPROC

PROTECTED PROCEDURE Cleanup
	THIS.oContext = null
	THIS.oMTX = null
ENDPROC

PROCEDURE CommitFile()
	IF VARTYPE(THIS.oContext)="O"
		THIS.oContext.SetComplete()
	ENDIF
	THIS.CleanUp()
ENDPROC

PROCEDURE AbortFile()
	IF VARTYPE(THIS.oContext)="O"
		THIS.oContext.SetAbort()
	ENDIF
	THIS.CleanUp()
ENDPROC

PROCEDURE ERROR(nError, cMethod, nLine)
LOCAL lcStr
THIS.lHadError=.T.
TEXT TO lcStr TEXTMERGE NOSHOW
Error in CRM Files Client...
 Error: <<TRANSFORM(nError)>>
 Method: <<TRANSFORM(cMethod)>>
 Line: <<TRANSFORM(nLine)>>
 Message: <<TRANSFORM(MESSAGE())>>
ENDTEXT
STRTOFILE(lcStr+CRLF,ERRLOG,.T.)
RETURN
ENDPROC

ENDDEFINE
