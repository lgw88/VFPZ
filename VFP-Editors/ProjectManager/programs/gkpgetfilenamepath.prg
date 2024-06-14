*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              green.gregory@comcast.net
*-*
*-* Copyright ©2009 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Locates the requested file based on project or in a sibbling subdirectory 
*-*
FUNCTION GKPGetFileNamePath
LPARAMETERS toForm,toCodeMax,tcType,tcStemName,tcFileExt
LOCAL lcFullName, lcProjFile, loException, lcErrMsg, lnFileCnt, lcBasePath, lnNumFldrs, lnFldr
LOCAL ARRAY laFile[1,5], laFldList[1,5]
lcFullName = ""
IF !ISNULL(toForm.ProjectDock)
	lcProjFile = toForm.ProjectDock.ProjectName
	TRY
		USE (lcProjFile) ALIAS gkppjx AGAIN IN 0
		SELECT gkppjx
		LOCATE FOR type=tcType .AND. ALLTRIM(key)==UPPER(tcStemName)
		IF FOUND()
			lcFullName = GKPGetFileFullPath(gkppjx.name,toForm.ProjectDock.BasePath)
		ENDIF
		USE
	CATCH TO loException
	ENDTRY
ENDIF
IF EMPTY(lcFullName)
	DO CASE
		CASE PEMSTATUS(toForm,"BasePath",5) .AND. !EMPTY(toForm.BasePath)
			lcTestName = ADDBS(toForm.BasePath) + tcStemName + "." + tcFileExt
			lnFileCnt  = ADIR(laFile,lcTestName)
			IF lnFileCnt = 0
				lcBasePath = LEFT(toForm.BasePath,RATC("\",ADDBS(toForm.BasePath),2))
				lnNumFldrs = ADIR(laFldList,lcBasePath+"*.*","D")
				FOR lnFldr=1 TO lnNumFldrs
					IF laFldList[lnFldr,1] != "." .AND. ATC("D",laFldList[lnFldr,5]) > 0
						lcTestName = ADDBS(lcBasePath+laFldList[lnFldr,1]) + tcStemName + "." + tcFileExt
						lnFileCnt  = ADIR(laFile,lcTestName)
						IF lnFileCnt > 0
							lcFullName = LOWER(lcTestName)
							EXIT
						ENDIF
					ENDIF
				ENDFOR
			ELSE
				lcFullName = LOWER(lcTestName)
			ENDIF

		CASE PEMSTATUS(toCodeMax,"BasePath",5) .AND. !EMPTY(toCodeMax.BasePath)
			lcTestName = ADDBS(toCodeMax.BasePath) + tcStemName + "." + tcFileExt
			lnFileCnt  = ADIR(laFile,lcTestName)
			IF lnFileCnt = 0
				lcBasePath = LEFT(toCodeMax.BasePath,RATC("\",ADDBS(toCodeMax.BasePath),2))
				lnNumFldrs = ADIR(laFldList,lcBasePath+"*.*","D")
				FOR lnFldr=1 TO lnNumFldrs
					IF laFldList[lnFldr,1] != "." .AND. ATC("D",laFldList[lnFldr,5]) > 0
						lcTestName = ADDBS(lcBasePath+laFldList[lnFldr,1]) + tcStemName + "." + tcFileExt
						lnFileCnt  = ADIR(laFile,lcTestName)
						IF lnFileCnt > 0
							lcFullName = LOWER(lcTestName)
							EXIT
						ENDIF
					ENDIF
				ENDFOR
			ELSE
				lcFullName = LOWER(lcTestName)
			ENDIF
	ENDCASE
ENDIF
RETURN lcFullName
ENDFUNC