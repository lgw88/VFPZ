*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-* Copyright ©2005-2010 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for Getting the member list for a FoxPro object
*-*
FUNCTION GKPGetObjMemberList
LPARAMETERS toMember, tcClassLoc, tcOLE2, tcBaseClass, tcClass
#INCLUDE gkpdefines.h
LOCAL lnNumPEMs, loObjRef, lnNdx, lcMethName, lcClassLoc, loException, loError
LOCAL ARRAY lcCustom[1]
lnNumPEMs = 0
DO CASE
	CASE EMPTY(tcOLE2) .AND. EMPTY(tcClassLoc) .AND. !EMPTY(tcBaseClass)
*-*		Member is a stock object on form
		loObjRef = ALLTRIM(tcBaseClass)
		lnNumPEMs = AMEMBERS(toMember.PEMList, loObjRef, 1)
		FOR lnNdx=1 TO lnNumPEMs
			lcMethName = GKPGetStockName(toMember.PEMList[lnNdx, 1])
			IF EMPTY(lcMethName)
				lcMethName = PROPER(toMember.PEMList[lnNdx, 1])
			ENDIF
			toMember.PEMList[lnNdx, 1] = lcMethName
		ENDFOR

	CASE EMPTY(tcOLE2) .AND. !EMPTY(tcClassLoc) .AND. UPPER(JUSTEXT(tcClassLoc)) = "PRG" .AND. !EMPTY(tcBaseClass)
*-*		Member is defined in a procedure file (memberlibr) (use same as stock object)
		loObjRef = ALLTRIM(tcBaseClass)
		lnNumPEMs = AMEMBERS(toMember.PEMList, loObjRef, 1)
		FOR lnNdx=1 TO lnNumPEMs
			lcMethName = GKPGetStockName(toMember.PEMList[lnNdx, 1])
			IF EMPTY(lcMethName)
				lcMethName = PROPER(toMember.PEMList[lnNdx, 1])
			ENDIF
			toMember.PEMList[lnNdx, 1] = lcMethName
		ENDFOR

	CASE EMPTY(tcOLE2) .AND. !EMPTY(tcClassLoc) .AND. UPPER(JUSTEXT(tcClassLoc)) = "VCX"
*-*		Member is defined in a visual class
		lcClassLoc = GKPGetFileFullPath(ALLTRIM(tcClassLoc), toMember.BasePath)
		lcClassLoc = GKPOpenAsTable(lcClassLoc, "gkp_vcx", toMember.MainForm)
		IF USED("gkp_vcx")
*-*			Check if class is a ActiveX
			SELECT gkp_vcx
			LOCATE FOR LOWER(ALLTRIM(objname)) == LOWER(ALLTRIM(tcClass)) .AND. reserved1 = "Class"
			IF FOUND()
				tcOLE2 = ALLTRIM(gkp_vcx.ole2)
				USE IN gkp_vcx
				IF EMPTY(tcOLE2)
*-*					Class is not an ActiveX
					TRY
						loObjRef = NEWOBJECT(ALLTRIM(tcClass), lcClassLoc, 0)
						lnNumPEMs = AMEMBERS(toMember.PEMList, loObjRef, 1)
						FOR lnNdx=1 TO lnNumPEMs
							lcMethName = GKPGetStockName(toMember.PEMList[lnNdx, 1])
							IF EMPTY(lcMethName)
								lcMethName = PROPER(toMember.PEMList[lnNdx, 1])
							ENDIF
							toMember.PEMList[lnNdx, 1] = lcMethName
						ENDFOR
						loObjRef = .NULL.
						CLEAR CLASSLIB (lcClassLoc)

					CATCH TO loException
						loError = CREATEOBJECT("Empty")
						ADDPROPERTY(loError, "ErrorNum", TRANSFORM(loException.ErrorNo))
						ADDPROPERTY(loError, "LineNum", TRANSFORM(loException.LineNo))
						ADDPROPERTY(loError, "CodeLine", loException.LineContents)
						ADDPROPERTY(loError, "ErrMsg", loException.Message)
						ADDPROPERTY(loError, "Method", "GetObjMemberList")
						ADDPROPERTY(loError, "ErrStack[1]")
						=ASTACKINFO(loError.ErrStack)
						DO FORM GKPErrMsgBox WITH loError
					ENDTRY
				ELSE
*-*					Class is an ActiveX
					lnNumPEMs = fGetActiveXPEMs(toMember, tcOLE2, tcClassLoc, tcClass)

				ENDIF
			ELSE
				USE IN gkp_vcx
			ENDIF
		ENDIF

	CASE !EMPTY(tcOLE2)
*-*		Member is an ActiveX control
		lnNumPEMs = fGetActiveXPEMs(toMember, tcOLE2, tcClassLoc, tcClass)

	OTHERWISE
		lnNumPEMs = 0
ENDCASE
=ASORT(toMember.PEMList)
RETURN lnNumPEMs
ENDFUNC



*-***********************************************************************************************
*-*  Routine for getting the properties/methods in an ActiveX
*-*
FUNCTION fGetActiveXPEMs
LPARAMETERS toMember, tcOLE2, tcClassLoc, tcClass
LOCAL lnNumPEMs, lcOleFile, lcSysPath, loObjRef, lnNdx, loInterface, lnMbr, lcName, lcClassLoc, lcAlias
LOCAL lnPos, lnLen, lcXML, lnNumCustom, llProperty
lnNumPEMs = 0
lcOleFile = ALLTRIM(SUBSTR(tcOLE2, ATC("=", tcOLE2)+1), 1, " ", CHR(10), CHR(12), CHR(13))
IF !FILE(lcOleFile)
	lcSysPath = SPACE(256)
	apiGetSystemDirectory(@lcSysPath, 256)
	lcSysPath = ALLTRIM(lcSysPath, 1, " ", CHR(0))
	lcOleFile = lcSysPath + SUBSTR(lcOleFile, RATC("\", lcOleFile))
	IF !FILE(lcOleFile)
		RETURN lnNumPEMs
	ENDIF
ENDIF
*-*	Get the PEMs for the control
loObjRef = CREATEOBJECT('TLI.TLIApplication')
IF VARTYPE(loObjRef) = "O"
	loObjRef = loObjRef.TypeLibInfoFromFile(lcOleFile)
	IF VARTYPE(loObjRef) = "O"
		FOR lnNdx=1 TO loObjRef.Interfaces.Count
			loInterface = loObjRef.Interfaces(lnNdx)
			FOR lnMbr=1 TO loInterface.Members.Count
				lcName = loInterface.Members(lnMbr).Name
				IF LEFT(lcName, 1)!="_" .AND. ASCAN(toMember.PEMList, lcName)=0 .AND. !fCheckFlag(loInterface.Members(lnMbr).AttributeMask, 64)
					DO CASE
*-*						Properties
						CASE INLIST(loInterface.Members(lnMbr).InvokeKind, 2, 4, 8) .OR. (loInterface.Members(lnMbr).InvokeKind=0 .AND. loInterface.Members(lnMbr).DescKind = 2)
							lnNumPEMs = lnNumPEMs + 1
							DIMENSION toMember.PEMList[lnNumPEMs, 2]
							toMember.PEMList[lnNumPEMs, 1] = lcName
							toMember.PEMList[lnNumPEMs, 2] = "Property"

*-*							Methods
						CASE BITTEST(loInterface.Members(lnMbr).InvokeKind, 0)
							lnNumPEMs = lnNumPEMs + 1
							DIMENSION toMember.PEMList[lnNumPEMs, 2]
							toMember.PEMList[lnNumPEMs, 1] = lcName
							toMember.PEMList[lnNumPEMs, 2] = "Method"
					ENDCASE
				ENDIF
			ENDFOR
		ENDFOR
	ENDIF
	loObjRef = .NULL.
ENDIF
IF !EMPTY(tcClassLoc)
*-*	Member is an ActiveX visual class; get any custom methods/properties
	lcClassLoc = GKPGetFileFullPath(ALLTRIM(tcClassLoc), toMember.BasePath)
	lcAlias = STRTRAN(JUSTSTEM(lcClassLoc), " ", "")
	=GKPOpenAsTable(lcClassLoc, lcAlias, "")
	IF USED(lcAlias)
		SELECT &lcAlias
		LOCATE FOR UPPER(ALLTRIM(objname)) == UPPER(ALLTRIM(tcClass)) .AND. !DELETED()
		IF FOUND()
*-*			Get the memberdata if defined for class
			lnPos = ATC("<VFPData>", &lcAlias..properties)
			IF lnPos > 0
				lnLen = ATC("</VFPData>", &lcAlias..properties)
				IF lnLen > 0
					lcXML = SUBSTR(&lcAlias..properties, lnPos, lnLen-lnPos+10)
					=XMLTOCURSOR(lcXML)
				ENDIF
			ENDIF
			lnNumCustom = ALINES(lcCustom, &lcAlias..reserved3, True)
			FOR lnNdx=1 TO lnNumCustom
				lcName = GETWORDNUM(lcCustom[lnNdx], 1, " ")
				DO CASE
					CASE LEFT(lcName, 1) = "*"
						llProperty = False
						lcName = SUBSTR(lcName, 2)

					CASE LEFT(lcName, 1) = "^"
						llProperty = True
						lcName = SUBSTR(lcName, 2)
						lnPos = ATC("(", lcName)
						IF lnPos > 0
							lcName = LEFT(lcName, lnPos-1)
						ELSE
							lnPos = ATC("[", lcName)
							IF lnPos > 0
								lcName = LEFT(lcName, lnPos-1)
							ENDIF
						ENDIF

					OTHERWISE
						llProperty = True
				ENDCASE
				IF USED('xmlresult')
					SELECT xmlresult
					LOCATE FOR ALLTRIM(name) == LOWER(lcName)
					IF FOUND()
						lcName = ALLTRIM(xmlresult.display)
					ENDIF
				ENDIF
				lnNumPEMs = lnNumPEMs + 1
				DIMENSION toMember.PEMList[lnNumPEMs, 2]
				toMember.PEMList[lnNumPEMs, 1] = lcName
				toMember.PEMList[lnNumPEMs, 2] = IIF(llProperty, "Property", "Method")
			ENDFOR
		ENDIF
		USE IN &lcAlias
		IF USED('xmlresult')
			USE IN xmlresult
		ENDIF
	ENDIF
ENDIF
RETURN lnNumPEMs
ENDFUNC



*-***********************************************************************************************
*-*  Routine for determining if bit is set for property/method in ActiveX
*-*
FUNCTION fCheckFlag
LPARAMETERS tnValue, tnFlag
LOCAL lnBit, lnCounter
lnBit = 0
DO WHILE tnFlag > 1
	lnBit = lnBit + 1
	tnFlag = tnFlag / 2	
ENDDO
RETURN BITTEST(tnValue, lnBit)
ENDFUNC