DEFINE CLASS MyUtils AS CUSTOM
	PROCEDURE AlertResult (tnResult)
		DO CASE
			CASE tnResult < 0
				** Faded away. Do nothing.
			CASE tnResult = 1
				** Clicked close button. Do nothing
			CASE tnResult = 2
				** Clicked link
				MESSAGEBOX("You clicked the link!",64,"Alert Result")
			CASE tnResult = 3
				lcRun = ADDBS(GETENV("windir")) + "system32\cleanmgr.exe"
				IF FILE(lcRun)
					RUN /N &lcRun
				ELSE
					MESSAGEBOX("Could not find file " + ALLTRIM(lcRun) + ", so I could not start Disk Cleanup.",16,"File Not Found")
				ENDIF		
			CASE tnResult = 4
				MESSAGEBOX("You clicked Task #2!",64,"Alert Result")	
			OTHERWISE
				MESSAGEBOX("Got this result: " + TRANSFORM(tnResult) + ".",16,"Error")
		ENDCASE	
	ENDPROC
ENDDEFINE	

DEFINE CLASS MyInvoice AS CUSTOM
	PROCEDURE AlertResult (tnResult)
		DO CASE
			CASE tnResult < 0
				** Faded away. Do nothing.
			CASE tnResult = 1
				** Clicked close button. Do nothing
			CASE tnResult = 2
				** Clicked link
				DO FORM viewinvoice
			CASE tnResult = 3
				MESSAGEBOX("You clicked Task #1!",64,"Alert Result")	
			CASE tnResult = 4
				MESSAGEBOX("You clicked Task #2!",64,"Alert Result")	
			OTHERWISE
				MESSAGEBOX("Got this result: " + TRANSFORM(tnResult) + ".",16,"Error")
		ENDCASE	
	ENDPROC
ENDDEFINE	

DEFINE CLASS MyCustom AS CUSTOM
	PROCEDURE AlertResult (tnResult)
		DO CASE
			CASE tnResult < 0
				** Faded away. Do nothing.
			CASE tnResult = 1
				** Clicked close button. Do nothing
			CASE tnResult = 2
				** Clicked link
				MESSAGEBOX("You clicked the Message Link!",64,"Alert Result")	
			CASE tnResult = 3
				** Clicked Task #1
				MESSAGEBOX("You clicked Task #1!",64,"Alert Result")	
			CASE tnResult = 4
				** Clicked Task #2
				MESSAGEBOX("You clicked Task #2!",64,"Alert Result")	
			OTHERWISE
				MESSAGEBOX("Got this result: " + TRANSFORM(tnResult) + ".",16,"Error")
		ENDCASE	
	ENDPROC
ENDDEFINE	