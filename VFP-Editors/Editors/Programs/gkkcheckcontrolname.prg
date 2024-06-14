*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for checking invalid characters in a control name and for checking if duplicate
*-*  name entered
*-*
#IFNDEF GKKDEFINES
#INCLUDE gkkdefines.h
#ENDIF
FUNCTION GKKCheckControlName
LPARAMETERS tcNewName, toCtrlForm
LOCAL lnNdx
IF EMPTY(tcNewName)
	RETURN "You must enter a name."
ENDIF
FOR lnNdx=1 TO LEN(tcNewName)
	IF SUBSTR(tcNewName,lnNdx,1) $ ".~`!@#$%^&*()-+={}[]:;|/\?,<>'" .OR. SUBSTR(tcNewName,lnNdx,1)='"'
		RETURN "Invalid character entered in name at position " + TRANSFORM(lnNdx)
	ENDIF
ENDFOR
IF LEFT(tcNewName,1) $ "0123456789"
	RETURN "Invalid character entered (cannot use numeric as leading character)"
ENDIF
IF !BETWEEN(ASC(UPPER(LEFT(tcNewName,1))),65,90) .AND. ASC(LEFT(tcNewName,1))!=95
	RETURN "Invalid name (name must start with A-Z or underscore)."
ENDIF
IF ATC(" ",tcNewName) > 0
	RETURN "Invalid name (spaces not allowed)."
ENDIF
IF ISNULL(toCtrlForm)
	IF USED('c_editbuffer')
		SELECT c_editbuffer
		LOCATE FOR objtype = OBJTYPE_CTRL .AND. ALLTRIM(UPPER(objname)) == UPPER(tcNewName)
		IF FOUND()
			RETURN "Name already used for an existing control."
		ENDIF
	ENDIF
ELSE
	FOR lnNdx=1 TO toCtrlForm.ObjectNames.Count
		IF toCtrlForm.ObjectNames(lnNdx) == UPPER(tcNewName)
			RETURN "Name already used for an existing control."
		ENDIF
	ENDFOR
ENDIF
RETURN ""
ENDFUNC