*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2007-2011 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for opening a visual class as a table for processing
*-*
FUNCTION GKLOpenAsTable
LPARAMETERS tcClassLoc,tcAlias,toForm
LOCAL llExit, lnTryCnt, loException, llGetLoc, lnNdx, lcUserMsg, lcClassLoc
#DEFINE False    .F.
#DEFINE True     .T.
llExit   = False
lnTryCnt = 1
tcAlias  = STRTRAN(tcAlias," ","")
lcClassLoc = tcClassLoc
DO WHILE .NOT. llExit
	TRY
		USE (lcClassLoc) IN 0 AGAIN ALIAS &tcAlias SHARED
		llExit = True

	CATCH TO loException
		DO CASE
			CASE INLIST(loException.ErrorNo,1,202)        && File does not exist
				llGetLoc = True
				IF VARTYPE(toForm) = "O"
*-*					Check if file is to be ignored
					IF PEMSTATUS(toForm,"IgnoreAll",5)
						IF toForm.IgnoreAll
							llExit     = True
							llGetLoc   = False
							lcClassLoc = ""
						ENDIF
					ENDIF
*-*					Check for alternate file path locaton
					IF llGetLoc .AND. PEMSTATUS(toForm,"AlternatePaths",5)
						FOR lnNdx=lnTryCnt TO ALEN(toForm.AlternatePaths,1)
							IF !ISNULL(toForm.AlternatePaths[lnNdx])
								llGetLoc   = False
								lnTryCnt   = lnNdx + 1
								lcClassLoc = toForm.AlternatePaths[lnNdx] + JUSTFNAME(tcClassLoc)
								EXIT
							ENDIF
						ENDFOR
					ENDIF
				ENDIF
				IF llGetLoc
*-*					Prompt user for file path location
					IF PEMSTATUS(toForm,"clsLightBox",5)
						IF PEMSTATUS(toForm,"ShowLightbox",5)
							toForm.ShowLightbox()
						ELSE
							toForm.clsLightBox.ShowLightbox(True,True)
						ENDIF
					ENDIF
					DO FORM GKLLocFile WITH JUSTFNAME(tcClassLoc) TO lcClassLoc
					=INKEY(0.1,'H')
					IF PEMSTATUS(toForm,"clsLightBox",5)
						toForm.clsLightBox.ShowLightbox(False,False)
					ENDIF
					DO CASE
*-*						User selected to ignore all not found
						CASE ISNULL(lcClassLoc)
							IF VARTYPE(toForm)="O" .AND. PEMSTATUS(toForm,"IgnoreAll",5)
								toForm.IgnoreAll = True
							ENDIF
							lcClassLoc = ""
							llExit = True

*-*						User selected to ignore this occurrence of file
						CASE EMPTY(lcClassLoc)
							llExit = True

*-*						User selected location; add to alternate file paths
						OTHERWISE
							IF VARTYPE(toForm)="O" .AND. PEMSTATUS(toForm,"AlternatePaths",5)
								IF ISNULL(toForm.AlternatePaths[1])
									lnNdx = 1
								ELSE
									lnNdx = ALEN(toForm.AlternatePaths,1) + 1
								ENDIF
								DIMENSION toForm.AlternatePaths[lnNdx]
								toForm.AlternatePaths[lnNdx] = ADDBS(JUSTPATH(lcClassLoc))
							ENDIF
					ENDCASE
				ENDIF

			CASE INLIST(loException.ErrorNo,3,24,101,108) && File in use
				GKLDisplayMsg('Visual Class Library in use: "' + JUSTFNAME(lcClassLoc) + ';" cannot display object.')
				llExit = True

			CASE loException.ErrorNo = 15                 && Not a table
				GKLDisplayMsg('Visual Class Library files corrupted: "' + JUSTFNAME(lcClassLoc) + ';" cannot display object.')
				llExit = True

			CASE loException.ErrorNo = 41                 && Invalid memo file
				GKLDisplayMsg('Visual Class Library has invalid memo file: "' + JUSTFNAME(lcClassLoc) + ';" cannot display object.')
				llExit = True

			OTHERWISE
				GKLDisplayMsg('Error occurred while trying to open "' + JUSTFNAME(lcClassLoc) + '"; ' + GKLGetErrorMessage(loException.ErrorNo))
				llExit = True
		ENDCASE
	ENDTRY
ENDDO
RETURN lcClassLoc
ENDFUNC