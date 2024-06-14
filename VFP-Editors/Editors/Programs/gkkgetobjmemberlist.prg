*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for Getting the member list for a FoxPro object
*-*
#IFNDEF GKKDEFINES
#INCLUDE GKKDefines.h
#ENDIF
FUNCTION GKKGetObjMemberList
LPARAMETERS toMember, tcClassLoc, tcOLE2, tcBaseClass, tcClass, tlGetStockName
LOCAL lnNumPEMs, loObjRef, lnNdx, lcMethName, lcClassLoc, loException, lcVcxClassLoc, lcVcxClass, lcVcxClassProp
LOCAL ARRAY lcCustom[1]
lnNumPEMs = 0
DO CASE
	CASE EMPTY(tcOLE2) .AND. EMPTY(tcClassLoc) .AND. !EMPTY(tcBaseClass)
*-*		Member is a stock object on form
		loObjRef  = ALLTRIM(tcBaseClass)
		lnNumPEMs = AMEMBERS(toMember.PEMList, loObjRef, 1)
		FOR lnNdx=1 TO lnNumPEMs
			IF tlGetStockName
				lcMethName = GKKGetStockName(toMember.PEMList[lnNdx, 1])
				IF EMPTY(lcMethName)
					lcMethName = PROPER(toMember.PEMList[lnNdx, 1])
				ENDIF
			ELSE
				lcMethName = PROPER(toMember.PEMList[lnNdx, 1])
			ENDIF
			toMember.PEMList[lnNdx, 1] = lcMethName
		ENDFOR

	CASE EMPTY(tcOLE2) .AND. !EMPTY(tcClassLoc) .AND. UPPER(JUSTEXT(tcClassLoc)) = "PRG" .AND. !EMPTY(tcBaseClass)
*-*		Member is defined in a procedure file (memberlibr) (use same as stock object)
		loObjRef  = ALLTRIM(tcBaseClass)
		lnNumPEMs = AMEMBERS(toMember.PEMList, loObjRef, 1)
		FOR lnNdx=1 TO lnNumPEMs
			IF tlGetStockName
				lcMethName = GKKGetStockName(toMember.PEMList[lnNdx, 1])
				IF EMPTY(lcMethName)
					lcMethName = PROPER(toMember.PEMList[lnNdx, 1])
				ENDIF
			ELSE
				lcMethName = PROPER(toMember.PEMList[lnNdx, 1])
			ENDIF
			toMember.PEMList[lnNdx, 1] = lcMethName
		ENDFOR

	CASE EMPTY(tcOLE2) .AND. !EMPTY(tcClassLoc) .AND. UPPER(JUSTEXT(tcClassLoc)) = "VCX"
*-*		Member is defined in a visual class
		CREATE CURSOR c_memberdata (name C(30), display C(30))
		INDEX ON name TAG name
		lcClassLoc = GKKGetFileFullPath(ALLTRIM(tcClassLoc), toMember.BasePath)
		lcClassLoc = GKKOpenAsTable(lcClassLoc, "gkk_vcx", toMember.MainForm)
		IF USED("gkk_vcx")
			SELECT gkk_vcx
			LOCATE FOR LOWER(ALLTRIM(objname)) == LOWER(ALLTRIM(tcClass)) .AND. reserved1 = "Class"
			IF FOUND()
				tcOLE2 = ALLTRIM(gkk_vcx.ole2)
				lcVcxClassLoc  = ALLTRIM(gkk_vcx.classloc)
				lcVcxClass     = ALLTRIM(gkk_vcx.class)
				lcVcxClassProp = gkk_vcx.properties
				USE IN gkk_vcx
				GKKGetClassMemberData(lcVcxClassLoc, lcVcxClass, lcVcxClassProp, JUSTPATH(lcClassLoc))
				IF EMPTY(tcOLE2)
*-*					Class is not an ActiveX
					TRY
						loObjRef  = NEWOBJECT(ALLTRIM(tcClass), lcClassLoc, 0)
						lnNumPEMs = AMEMBERS(toMember.PEMList, loObjRef, 1)
						FOR lnNdx=1 TO lnNumPEMs
							IF tlGetStockName
								lcMethName = GKKGetStockName(toMember.PEMList[lnNdx, 1])
								IF EMPTY(lcMethName)
									IF SEEK(PADR(LOWER(toMember.PEMList[lnNdx, 1]), 30, " "), "c_memberdata", "name")
										lcMethName = ALLTRIM(c_memberdata.display)
									ELSE
										lcMethName = PROPER(toMember.PEMList[lnNdx, 1])
									ENDIF
								ENDIF
							ELSE
								IF SEEK(PADR(LOWER(toMember.PEMList[lnNdx, 1]), 30, " "), "c_memberdata", "name")
									lcMethName = ALLTRIM(c_memberdata.display)
								ELSE
									lcMethName = PROPER(toMember.PEMList[lnNdx, 1])
								ENDIF
							ENDIF
							toMember.PEMList[lnNdx, 1] = lcMethName
						ENDFOR
						loObjRef = .NULL.
						CLEAR CLASSLIB (lcClassLoc)
			
					CATCH TO loException
						GKKDisplayMsg(loException.Message)
					ENDTRY
				ELSE
*-*					Class is an ActiveX
					lnNumPEMs = fGetActiveXPEMs(toMember, tcOLE2, tcClassLoc, tcClass)
				ENDIF
			ELSE
				USE IN gkk_vcx
			ENDIF
		ENDIF
		USE IN c_memberdata 

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
LOCAL lnPos, lnLen, lcXML, lnNumCustom, llProperty, loException
*-*	Get the TypeLib component
IF !PEMSTATUS(_SCREEN, "TLIApplication", 5)
	_SCREEN.AddProperty("TLIApplication", CREATEOBJECT('Empty'))
	ADDPROPERTY(_SCREEN.TLIApplication, "TypeLibApp", .NULL.)
	ADDPROPERTY(_SCREEN.TLIApplication, "TypeLibs[1,3]")
ENDIF
IF ISNULL(_SCREEN.TLIApplication.TypeLibApp)
	TRY
		_SCREEN.TLIApplication.TypeLibApp = CREATEOBJECT('TLI.TLIApplication')
	CATCH TO loException
		GKKDisplayMsg(loException.Message)
		_SCREEN.TLIApplication.TypeLibApp = .NULL.
	ENDTRY
ENDIF
IF ISNULL(_SCREEN.TLIApplication.TypeLibApp)
	RETURN 0
ENDIF



lcOleFile = ALLTRIM(SUBSTR(tcOLE2, ATC("=", tcOLE2)+1), 1, " ", CHR(10), CHR(12), CHR(13))
IF !FILE(lcOleFile)
	lcSysPath = SPACE(256)
	apiGetSystemDirectory(@lcSysPath, 256)
	lcSysPath = ALLTRIM(lcSysPath, 1, " ", CHR(0))
	lcOleFile = lcSysPath + SUBSTR(lcOleFile, RATC("\", lcOleFile))
	IF !FILE(lcOleFile)
		RETURN 0
	ENDIF
ENDIF
lnNumPEMs = 0
loObjRef  = _SCREEN.TLIApplication.TypeLibApp.TypeLibInfoFromFile(lcOleFile)
IF VARTYPE(loObjRef) = "O"
	FOR lnNdx=1 TO loObjRef.Interfaces.Count
		loInterface = loObjRef.Interfaces(lnNdx)
		FOR lnMbr=1 TO loInterface.Members.Count
			lcName = loInterface.Members(lnMbr).Name
			IF LEFT(lcName, 1)!="_" .AND. ASCAN(toMember.PEMList, lcName)=0 .AND. !fCheckFlag(loInterface.Members(lnMbr).AttributeMask, 64)
				DO CASE
*-*					Properties
					CASE INLIST(loInterface.Members(lnMbr).InvokeKind, 2, 4, 8) .OR. (loInterface.Members(lnMbr).InvokeKind=0 .AND. loInterface.Members(lnMbr).DescKind = 2)
						lnNumPEMs = lnNumPEMs + 1
						DIMENSION toMember.PEMList[lnNumPEMs, 2]
						toMember.PEMList[lnNumPEMs, 1] = lcName
						toMember.PEMList[lnNumPEMs, 2] = "Property"

*-*					Methods
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


IF !EMPTY(tcClassLoc)
*-*	Member is an ActiveX visual class; get any custom methods/properties
	lcClassLoc = GKKGetFileFullPath(ALLTRIM(tcClassLoc), toMember.BasePath)
	lcAlias    = STRTRAN(JUSTSTEM(lcClassLoc), " ", "")
	=GKKOpenAsTable(lcClassLoc, lcAlias, "")
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