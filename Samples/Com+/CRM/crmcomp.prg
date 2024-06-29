EXTERNAL ARRAY pLogRecord
#INCLUDE crmfiles.h

DEFINE CLASS CrmFilesCompensatorVFP AS session OLEPUBLIC

	PROTECTED lHadError, oCrmLogControl, nAction, cFileName, cTempFileName 
	lHadError = .F.
	oCrmLogControl = ""
	nAction = 0
	cFileName = ""
	cTempFileName = ""
	
	IMPLEMENTS ICrmCompensatorVariants IN "comsvcs.dll"

	PROTECTED PROCEDURE OutputLog(cStr)
		IF EMPTY(cStr) OR LOGGINGOFF
			RETURN
		ENDIF
		STRTOFILE(TRANSFORM(cStr) + CRLF,LOGFILE,.T.)
	ENDPROC

	PROCEDURE ICrmCompensatorVariants_SetLogControlVariants(pLogControl AS VARIANT) AS VOID;
 				HELPSTRING "method SetLogControlVariants"
		THIS.OutputLog("SetLogControlVariants...")
		LOCAL lcTransactionUOW
		THIS.oCrmLogControl = pLogControl
		* This is failing
		* lcTransactionUOW = pLogControl.TransactionUOW
		* THIS.OutputLog("TransactionUOW: "+TRANSFORM(lcTransactionUOW))
	ENDPROC

	PROCEDURE ICrmCompensatorVariants_PrepareRecordVariants(pLogRecord AS VARIANT) AS LOGICAL;
 				HELPSTRING "method PrepareRecordVariants"
		THIS.OutputLog("PrepareVariants...")
		*OPTIONAL: FORGET the record that was just delivered to us?
		* Setting this to .T. causes CommitRecordVariants not to get called
		RETURN .F.
	ENDPROC

	PROCEDURE ICrmCompensatorVariants_BeginPrepareVariants() AS VOID;
 				HELPSTRING "method BeginPrepareVariants"
		THIS.OutputLog("BeginPrepareVariants...")		
	ENDPROC

	PROCEDURE ICrmCompensatorVariants_EndPrepareVariants() AS LOGICAL;
 				HELPSTRING "method EndPrepareVariants"
		* VOTE ON THE OUTCOME OF THE TRANSACTION   
		THIS.OutputLog("EndPrepareVariants...")		
	    RETURN .T.
	ENDPROC

	PROCEDURE ICrmCompensatorVariants_AbortRecordVariants(pLogRecord AS VARIANT) AS LOGICAL;
 				HELPSTRING "method AbortRecordVariants"		
 		* Note: Log records are delivered in the reverse of the order in which they were originally written.
		
		THIS.nAction = VAL(pLogRecord[1])
		THIS.cFileName = pLogRecord[2]
		THIS.cTempFileName = pLogRecord[3]

		IF THIS.nAction = 1
			* Handle Create File abort
			IF FILE(THIS.cFileName)
				DELETE FILE (THIS.cFileName)
			ENDIF
		ELSE
			* Handle Delete File abort -- restore temp saved file
			IF FILE(THIS.cTempFileName) AND !FILE(THIS.cFileName)
				COPY FILE (THIS.cTempFileName) TO (THIS.cFileName)
			ENDIF
			IF FILE(THIS.cFileName) AND FILE(THIS.cTempFileName)
				DELETE FILE (THIS.cTempFileName)
			ENDIF
		ENDIF	
			
		THIS.OutputLog("AbortRecordVariants...")
		RETURN .T.
		* OPTIONAL: FORGET the record that was just delivered to us?
		* NOTE: this forget is not forced - could force on next record if required
	ENDPROC

	PROCEDURE ICrmCompensatorVariants_CommitRecordVariants(pLogRecord AS VARIANT) AS LOGICAL;
 				HELPSTRING "method CommitRecordVariants"
 		* Note: Log records are delivered in the order they were originally written.
	
		THIS.nAction = VAL(pLogRecord[1])
		THIS.cFileName = pLogRecord[2]
		THIS.cTempFileName = pLogRecord[3]

		IF THIS.nAction = 1 
			IF !FILE(THIS.cFileName)
				* Create File. Need to handle situation where action was never taken even though log written out (very rare)
				STRTOFILE("VFP CRM Sample",THIS.cFileName)
			ENDIF
		ELSE
			* Delete File. Need to handle situation where action was never taken even though log written out (very rare)
			IF FILE(THIS.cFileName)
				DELETE FILE (THIS.cFileName)
			ENDIF
			* Now remove temp file assumming other one was deleted
			IF !FILE(THIS.cFileName)
				DELETE FILE (THIS.cTempFileName)
			ENDIF
		ENDIF

		THIS.OutputLog("CommitRecordVariants...")
 		RETURN .T.
		* OPTIONAL: FORGET the record that was just delivered to us?
		* NOTE: this forget is not forced - could force on next record if required
	ENDPROC

	PROCEDURE ICrmCompensatorVariants_BeginCommitVariants(bRecovery AS LOGICAL) AS VOID;
 				HELPSTRING "method BeginCommitVariants"
		THIS.OutputLog("BeginCommitVariants...")
	ENDPROC

	PROCEDURE ICrmCompensatorVariants_EndCommitVariants() AS VOID;
 				HELPSTRING "method EndCommitVariants"
		THIS.OutputLog("EndCommitVariants...")
	ENDPROC

	PROCEDURE ICrmCompensatorVariants_BeginAbortVariants(bRecovery AS LOGICAL) AS VOID;
 				HELPSTRING "method BeginAbortVariants"
		THIS.OutputLog("BeginAbortVariants...")
	ENDPROC

	PROCEDURE ICrmCompensatorVariants_EndAbortVariants() AS VOID;
 				HELPSTRING "method EndAbortVariants"
		THIS.OutputLog("EndAbortVariants...")
	ENDPROC

PROCEDURE ERROR(nError, cMethod, nLine)
LOCAL lcStr
THIS.lHadError=.T.
TEXT TO lcStr TEXTMERGE NOSHOW
Error in CRM Compensator ...
 Error: <<TRANSFORM(nError)>>
 Method: <<TRANSFORM(cMethod)>>
 Line: <<TRANSFORM(nLine)>>
 Message: <<TRANSFORM(MESSAGE())>>
ENDTEXT
STRTOFILE(lcStr+CRLF,ERRLOG,.T.)
RETURN
ENDPROC

ENDDEFINE