*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Locates the requested file based on project or in a sibbling subdirectory 
*-*
FUNCTION GKKGetFileNamePath
LPARAMETERS toForm, toCodeMax, tcType, tcStemName, tcFileExt
LOCAL lcFullName, lcProjFile, loException, lcErrMsg, lnFileCnt, lcBasePath, lnNumFldrs, lnFldr, lnForm
LOCAL ARRAY laFile[1,5], laFldList[1,5]
lcFullName = ""
IF PEMSTATUS(toForm,"ProjectName",5)
	lnForm = GKKGetGKKProjectForm(toForm.ProjectName)
ELSE
	lnForm = 0
ENDIF
IF lnForm > 0
	lcProjFile = _SCREEN.Forms(lnForm).ProjectName
	TRY
		USE (lcProjFile) ALIAS gkkpjx AGAIN IN 0
		SELECT gkkpjx
		LOCATE FOR type=tcType .AND. ALLTRIM(key)==UPPER(tcStemName)
		IF FOUND()
			lcFullName = GKKGetFileFullPath(gkkpjx.name, _SCREEN.Forms(lnForm).BasePath)
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

		CASE !ISNULL(toCodeMax) .AND. PEMSTATUS(toCodeMax,"BasePath",5) .AND. !EMPTY(toCodeMax.BasePath)
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