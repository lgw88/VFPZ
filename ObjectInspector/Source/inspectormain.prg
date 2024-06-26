* Main program for object inspector
LPARAMETERS oObject, cObjectName, lDontAddKeys

* Check parameters
IF PCOUNT() < 1 OR VARTYPE(oObject) <> "O"
	MESSAGEBOX("You must pass a reference to the object you want to inspect.", 0 + 48, ;
	           "VFP Object Inspector")
	RETURN
ENDIF

Do Case
	Case PCOUNT() >= 2

	Case PemStatus(m.oObject, 'Name', 5) and not PemStatus(m.oObject, 'Name', 4)
		cObjectName = m.oObject.Name

	Otherwise 
		* Just supply something generic
		cObjectName = "[Object]"
Endcase

PUBLIC _oInspector
DO FORM Inspector WITH m.oObject, m.cObjectName, m.lDontAddKeys NAME _oInspector 

RETURN
