*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Checks the method/property name for syntax
*-*
FUNCTION GKKCheckPropertyName
LPARAMETERS tcName,tcClassName,tlProperty,tlCheckDupl
LOCAL lcName, lnNumProp, lnNdx, llNameErr
LOCAL ARRAY lcPropList[1,2]
#INCLUDE GKKDefines.h
lcPropList[1,1] = ""
lcPropList[1,2] = ""
lcName = UPPER(ALLTRIM(tcName))
*-*	Check for spaces or invalid leading character
IF BETWEEN(ASC(LEFT(lcName,1)),65,90) .OR. ASC(LEFT(lcName,1))=95
	IF ATC(" ",lcName) > 0
		GKKDisplayMsg("Invalid name (spaces not allowed).")
		RETURN False
	ENDIF
ELSE
	GKKDisplayMsg("Invalid name (name must start with A-Z or underscore).")
	RETURN False
ENDIF
*-*	Check for valid characters
FOR lnNdx=1 TO LEN(lcName)
	IF SUBSTR(lcName,lnNdx,1) $ "~`!@#$%^&*-+={}:;|/\?.<>'" .OR. SUBSTR(lcName,lnNdx,1)='"'
		GKKDisplayMsg("Invalid character entered in name at position " + TRANSFORM(lnNdx))
		RETURN False
	ENDIF
ENDFOR
*-*	Check if name is an array
IF tlProperty
	DO CASE
		CASE ATC("[",lcName) > 0
			IF RIGHT(lcName,1) != "]"
				GKKDisplayMsg("Invalid property name (array must have matching brackets).")
				RETURN False
			ELSE
				llNameErr = True
				FOR lnNdx=ATC("[",lcName)+1 TO LEN(lcName)-1
					IF SUBSTR(lcName,lnNdx,1) $ "0123456789,"
						llNameErr = False
					ELSE
						GKKDisplayMsg("Invalid character entered in array name at position " + TRANSFORM(lnNdx))
						RETURN False
					ENDIF
				ENDFOR
				IF llNameErr .OR. ATC("[,",lcName)>0 .OR.  ATC(",]",lcName)>0 .OR. ATC("[0",lcName)>0
					GKKDisplayMsg("Invalid property name (array must have valid dimensions).")
					RETURN False
				ENDIF
			ENDIF
		CASE ATC("(",lcName) > 0
			IF RIGHT(lcName,1) != ")"
				GKKDisplayMsg("Invalid property name (array must have matching brackets).")
				RETURN False
			ELSE
				llNameErr = True
				FOR lnNdx=ATC("(",lcName)+1 TO LEN(lcName)-1
					IF SUBSTR(lcName,lnNdx,1) $ "0123456789,"
						llNameErr = False
					ELSE
						GKKDisplayMsg("Invalid character entered in array name at position " + TRANSFORM(lnNdx))
						RETURN False
					ENDIF
				ENDFOR
				IF llNameErr .OR. ATC("(,",lcName)>0 .OR. ATC(",)",lcName)>0 .OR. ATC("(0",lcName)>0
					GKKDisplayMsg("Invalid property name (array must have valid dimensions).")
					RETURN False
				ENDIF
			ENDIF
		OTHERWISE
			FOR lnNdx=1 TO LEN(lcName)
				IF SUBSTR(lcName,lnNdx,1) $ "[](),"
					GKKDisplayMsg("Invalid character entered in name at position " + TRANSFORM(lnNdx))
					RETURN False
				ENDIF
			ENDFOR
	ENDCASE
ELSE
	FOR lnNdx=1 TO LEN(lcName)
		IF SUBSTR(lcName,lnNdx,1) $ "[](),"
			GKKDisplayMsg("Invalid character entered in name at position " + TRANSFORM(lnNdx))
			RETURN False
		ENDIF
	ENDFOR
ENDIF
*-*	Check if name is a reserved FoxPro name
lnNumProp = AMEMBERS(lcPropList,"form",1)
FOR lnNdx=1 TO lnNumProp
	IF lcName == UPPER(lcPropList[lnNdx,1])
		GKKDisplayMsg("Invalid name (reserved method/property name).")
		RETURN False
	ENDIF
ENDFOR
*-*	Check if name is already used as a custom name
IF tlCheckDupl
	SELECT c_property
	GOTO TOP
	LOCATE FOR ALLTRIM(classname) == LOWER(tcClassName) .AND. UPPER(ALLTRIM(c_property.pname)) == lcName .AND. !DELETED()
	IF FOUND()
		GKKDisplayMsg("Invalid name (already used).")
		RETURN False
	ENDIF
ENDIF
RETURN True
ENDFUNC