*==============================================================================
* Program:				ControlRenamer.PRG
* Purpose:				Main class for Control Renamer Builder
* Copyright:			(c) 2005 Tamar E. Granor, Ph.D.
* Last revision:		05/02/05
* Notes:				You may freely distribute this builder
*                       as long as this header is retained.
* Contact:				tamar@thegranors.com
*==============================================================================

DEFINE CLASS ControlRenamerEngine AS Custom 

oObject = .null.
oDesignerForm = .null.
lIsForm = .F.
cOldExact = ""

DIMENSION aProcLines[1]
nCurLine = 0

PROCEDURE Init

* Create cursors
CREATE CURSOR AllControls ;
   (iID I AUTOINC, cControlOrig C(128), cControlNew C(128), ;
    mFullPath M, cInfo C(254), lReadOnly L)
INDEX on iID TAG iID
INDEX on UPPER(cControlOrig) TAG Name
SET ORDER TO 

CREATE CURSOR ControlRefs ;
	(iID I AUTOINC, iRefControlFK I, iCodeControlFK I, ;
	 cMethod C(128), nLine N(6), nOccurrence N(3))
* Create index so occurrences are processed from right to left
INDEX on UPPER(cMethod) + TRANSFORM(nLine) + TRANSFORM(1000-nOccurrence) TAG InnerFirst

* Settings
This.cOldExact = SET("Exact")
SET EXACT OFF 

* Get a reference to the containing object
This.oObject = This.GetTarget()

* Modified 24-November-2008 by TEG
* If no target found, bail out
IF ISNULL(This.oObject)
	RETURN .F.
ENDIF

IF UPPER(This.oObject.Baseclass) = "FORM"
	This.lIsForm = .T.
	This.oDesignerForm = This.oObject
ELSE
	This.lIsForm = .F.
	This.oDesignerForm = This.oObject.Parent
ENDIF 

RETURN 
ENDPROC

PROCEDURE Destroy

LOCAL cExact

cExact = This.cOldExact
SET EXACT &cExact

RETURN
ENDPROC

PROCEDURE GrabControls
* Traverse the form/container and populate the cursor of controls
LOCAL cInfo

* Add the form itself, then drill down
cInfo = This.GetInfo(This.oObject)
INSERT INTO AllControls ;
		(cControlOrig, mFullPath, cInfo, lReadOnly) ;
		VALUES (This.oObject.Name, "", m.cInfo, .F.)

This.DrillControls(This.oObject, This.oObject.Name)

* Now get a list of unique names
SELECT DISTINCT cControlOrig ;
	FROM AllControls ;
	INTO CURSOR ControlNames

GO TOP IN AllControls

RETURN
ENDPROC

PROCEDURE DrillControls(oContainer, cHierarchy)
* Drill into a container and add all the controls 
* inside to the cursor.

LOCAL nControls, aControls[1], nControl, oObject
LOCAL nPEMs, aPEMs[1], nNameRow, lReadOnly

nControls = AMEMBERS(aControls, oContainer, 2)

FOR nControl = 1 TO nControls
	* Figure out what info is available about
	* this control
	oObject = EVALUATE("oContainer." + aControls[nControl])
	cInfo = This.GetInfo(oObject)
		
	* Find out whether name can be changed.
	IF UPPER(oObject.BaseClass) <> "OLE"
		nPEMs = AMEMBERS(aPEMs, oObject, 3, "#+")
		nNameRow = ASCAN(aPEMs,"NAME",-1,-1,1,15)
		IF nNameRow <> 0
			lReadOnly = "R"$aPEMs[nNameRow,5]
		ELSE 
			lReadOnly = .T.
		ENDIF 
	ENDIF 
		
	INSERT INTO AllControls ;
		(cControlOrig, mFullPath, cInfo, lReadOnly) ;
		VALUES (aControls[nControl], cHierarchy, m.cInfo, m.lReadOnly)
		
	* Drill down
	IF PEMSTATUS(oObject, "Objects", 5)
		* Drill down
		This.DrillControls(oObject, ;
		                   cHierarchy + "." + aControls[nControl])
	ENDIF
ENDFOR

RETURN nControls

PROCEDURE GetInfo(oObject as Object)

LOCAL cInfo

DO CASE 
CASE UPPER(oObject.BaseClass) = "OLE"
	cInfo = oObject.OLEClass
CASE PEMSTATUS(oObject, "Caption", 5)
	cInfo = oObject.Caption
CASE PEMSTATUS(oObject, "Value", 5) AND NOT EMPTY(oObject.Value)
	cInfo = TRANSFORM(oObject.Value)
CASE PEMSTATUS(oObject, "ControlSource", 5)
	cInfo = oObject.ControlSource
OTHERWISE
	cInfo = ""
ENDCASE 

RETURN cInfo
ENDPROC 

PROCEDURE ChangeNames
* Change the names of the objects based on the new values
* supplied.
#DEFINE CRLF CHR(13)+CHR(10)

This.BuildCodeRefs()

* Go through the list of refs and change them
SELECT ControlRefs
SET ORDER TO InnerFirst
SCAN 
	* Find the control to be replaced
	SELECT AllControls
	SEEK ControlRefs.iRefControlFK ORDER iID 
	
	IF NOT EMPTY(AllControls.cControlNew)
		* Replace only if a new name has been specified
		* Grab info
		SCATTER NAME oRefControl MEMO
		
		* Get the method
		SEEK ControlRefs.iCodeControlFK ORDER iID
		* Grab info on this control
		SCATTER NAME oCodeControl MEMO 
		SELECT ControlRefs
		
		IF EMPTY(ALLTRIM(oCodeControl.mFullPath))
			* It's the target object
			cControl = 	ALLTRIM(oCodeControl.cControlOrig)
			oControl = This.oObject
		ELSE
			cControl = STRTRAN(ALLTRIM(oCodeControl.mFullPath) + "." ;
			                   + ALLTRIM(oCodeControl.cControlOrig), ;
	                           This.oObject.Name + ".", ;
			                   "This.oObject.") 

			oControl = EVALUATE(cControl)
		ENDIF
		cMethodCode = oControl.ReadMethod(ALLTRIM(cMethod))

		* Replace and rebuild
		nLines = ALINES(aCodeLines, cMethodCode)
		cNewMethod = ""
		* Copy lines before replacement
		FOR nCodeLine = 1 TO nLine-1
			cNewMethod = cNewMethod + aCodeLines[nCodeLine] + CRLF
		ENDFOR 
		
		* Now replace the specified occurrence in the specified line
		* Add period to allow replacement at the end of the line.
		* Strip it off after replacement.
		cCodeLine = TRIM(aCodeLines[nCodeLine]) + "."
		cCodeLine = STRTRAN(cCodeLine, ;
		                    ALLTRIM(oRefControl.cControlOrig) + ".", ;
		                    ALLTRIM(oRefControl.cControlNew) + ".", ;
	                        ControlRefs.nOccurrence, 1, 1) 
	    cCodeLine = LEFT(cCodeLine, LEN(cCodeLine) - 1)
		cNewMethod = cNewMethod + cCodeLine + CRLF
		
		* Copy the rest
		FOR nCodeLine = nLine + 1 TO nLines	                     
			cNewMethod = cNewMethod + aCodeLines[nCodeLine] + CRLF
		ENDFOR 
		
		oControl.WriteMethod(ALLTRIM(cMethod), cNewMethod)
	ENDIF 
ENDSCAN

* Now change control names
SELECT cControlOrig, cControlNew, mFullPath, ;
       IIF(EMPTY(mFullPath), -1, OCCURS(".", mFullPath)) as nDepth ;
	FROM AllControls ;
	WHERE NOT EMPTY(cControlNew) ;
	ORDER BY nDepth DESC ;
	INTO CURSOR ReplaceControls
	
SCAN 	
	IF EMPTY(ALLTRIM(mFullPath))
		* It's the form.
		cControl = 	ALLTRIM(cControlOrig)
		oControl = This.oObject
	ELSE
		cControl = STRTRAN(ALLTRIM(mFullPath) + "." ;
		                   + ALLTRIM(cControlOrig), ;
                           This.oObject.Name + ".", ;
		                   "This.oObject.") 

		oControl = EVALUATE(cControl)
	ENDIF
	
	oControl.Name = cControlNew	

ENDSCAN

USE IN ReplaceControls

RETURN
ENDPROC

PROCEDURE CheckForDups
* Ensure that new names don't include duplicates.

LOCAL lReturn

SELECT UPPER(IIF(EMPTY(cControlNew), cControlOrig, cControlNew)), ;
       UPPER(mFullPath), CNT(*) ;
	FROM AllControls ;
	GROUP BY 1,2 ;
	HAVING CNT(*) > 1 ;
	INTO CURSOR Dups

lReturn = _Tally=0

USE IN Dups
RETURN lReturn


* First, check for duplicates
PROCEDURE BuildCodeRefs
* Build the cursor of references to controls

This.DrillCode(This.oObject)

RETURN
ENDPROC 

PROCEDURE DrillCode(oControl)

LOCAL aAllMem[1], nMembCount, nObject, nMember 

* Make sure list of controls to search for exists
IF NOT USED("ControlNames")
	RETURN .F.
ENDIF

nMembCount = AMEMBERS(aAllMem, oControl, 1)
FOR nMember = 1 TO nMembCount
	IF INLIST(UPPER(aAllMem[nMember, 2]), "EVENT", "METHOD" )
		This.AuditMethod(oControl, aAllMem[nMember,1])
	ENDIF
ENDFOR

* Work around bug with Grid.Objects
DO CASE 
CASE UPPER(oControl.BaseClass)="GRID"
	IF oControl.ColumnCount > 0
		FOR nObject = 1 TO oControl.ColumnCount
			This.DrillCode(oControl.Columns[ nObject ])
		ENDFOR 
	ENDIF 

OTHERWISE 
	IF PEMSTATUS(oControl, "Objects", 5)
		FOR nObject =1 TO oControl.Objects.Count
			This.DrillCode(oControl.Objects[nObject])
		ENDFOR
	ENDIF
ENDCASE 

RETURN
ENDPROC

PROCEDURE AuditMethod(oControl, cMethod)
* Find references in one method

LOCAL cCode, cHoldCode, nPos, cLine, aLineWords[1]
LOCAL cControl, cSearchFor, cChar, nOldSelect
LOCAL nOccurrence, nCount, nStartPos, cOwner, nFound
LOCAL cContainer, cControlPath, iCodeControl, iRefControl
LOCAL aCodeLines[1], nLines, nLine

cCode = oControl.ReadMethod(cMethod)

IF NOT EMPTY(cCode)
	* Use upper case to facilitate comparisons.
	cHoldCode = UPPER(cCode)
	
	* Preprocess code to make it possible to find references
	* at the end of lines. Note that even with this code,
	* references to controls (rather than their properties) on
	* the left-hand side of an assignment or comparison
	* will not be found. For example, this code would not
	* find a line like:
	* IF This.Text1 = oObject
	* This seems like an unlikely enough scenario to be
	* unimportant.
	nLines = ALINES(aCodeLines, cHoldCode)
	cHoldCode = ""
	FOR nLine = 1 TO nLines
		cHoldCode = cHoldCode + ALLTRIM(aCodeLines[nLine]) + ;
					IIF(EMPTY(ALLTRIM(aCodeLines[nLine])),"",".") + CRLF
	ENDFOR 

	* Go through list of controls to change
	nOldSelect = SELECT()
	SELECT ControlNames
	
	SCAN 
		* Is this control name used in the method?
		cControl = cControlOrig
		cSearchFor = "." + ALLTRIM(UPPER(cControl))+"."
		nFound = 0
		nPos = AT(cSearchFor, cHoldCode)
		* Find all occurrences
		DO WHILE nPos>0
			nFound = nFound + 1 
			* Figure out complete path.
			
			* Get the code line
			cLine = This.GetCodeLineByPos(cHoldCode,nPos)
			cLine = ALLTRIM(cLine)
			
			* Now work backwards to find the full reference
			nPos = AT(cSearchFor, cLine)
			nOccurrence = 1

			DO WHILE nPos>0
				* Move backward to find beginning of reference
				nStartPos = nPos-1
				cChar = SUBSTR(cLine, nStartPos, 1)
				DO WHILE ISALPHA(cChar) OR ISDIGIT(cChar) OR ;
				         INLIST(SUBSTR(cLine, nStartPos, 1), ;
				                "_", ".")
					nStartPos = nStartPos - 1 
					cChar = SUBSTR(cLine, nStartPos, 1)
				ENDDO
				
				* Everything from nStartPos through 
				* the found string is the reference
				cOwner = SUBSTR(cLine, nStartPos + 1, nPos-nStartPos)
				
				* Now is it good enough?
				IF LEFT(cOwner, 1) = "."
					* Need to look backwards for WITH
					cContainer = This.FindWith(This.nCurLine)
					cOwner = cContainer + cOwner
				ENDIF 
				
				* Now deal with indirect reference
				IF ".PARENT."$UPPER(cOwner)
					* Need to substitute actual parent name in path
					DO CASE 
					CASE UPPER(cOwner) = "THISFORM"
						IF This.lIsForm
							oStart = This.oObject
						ELSE
							* Can't handle this case. We're in a control
							* class and code refers to THISFORM, the form
							* hosting the control. There's no way to 
							* trace back to find out what's being referenced.
							* Making the same assignment as above ensures
							* that the control won't be found, so this reference
							* won't land in the table.
							oStart = This.oObject
						ENDIF 
					CASE UPPER(cOwner) = "THIS"
						oStart = oControl
					OTHERWISE
						* Direct reference
						* Ignore for now--extremely unlikely
					ENDCASE 
					
					nRefs = ALINES(aRefs, UPPER(cOwner), ".")
					FOR nRef = 2 TO nRefs
						* Skip first word--THIS or THISFORM
						IF aRefs[nRef] = "PARENT"
							oStart = oStart.Parent
						ELSE
							* Get the appropriate ref
							AMEMBERS(aObjMem, oStart, 2)
							IF ASCAN(aObjMem, aRefs[nRef])<>0
								* Add it 
								* Modified 16-August-2012 by TEG
								* oStart is the variable name, so needs quotes.
								* Thanks to Rick Schummer for reporting this one.
								oStart = EVALUATE("oStart." + aRefs[nRef])
							ELSE
								* Should never happen
							ENDIF
						ENDIF 
					ENDFOR 
					
					* Now get path
					cOwner = This.BuildControlPath(oStart)
				ENDIF 

				IF UPPER(cOwner)="THISFORM" AND This.lIsForm
					* Substitute form name
					IF UPPER(cOwner)=="THISFORM"
						cOwner = This.oObject.Name
					ELSE 
						cOwner = STRTRAN(cOwner, "THISFORM.", This.oObject.Name + ".", 1, 1, 3)
					ENDIF
				ENDIF

				IF UPPER(cOwner)="THIS" 
					* Substitute control name with full path
					cControlPath = This.BuildControlPath(oControl)
					IF UPPER(cOwner)=="THIS"
						cOwner = cControlPath
					ELSE 
						cOwner = STRTRAN(cOwner, "THIS.", cControlPath + ".", 1, 1, 3)
					ENDIF 					
				ENDIF
				
				* Make sure we have a trailing period
				cOwner = ALLTRIM(cOwner)
				IF RIGHT(cOwner,1) <> "."
					cOwner = cOwner + "."
				ENDIF
				
				* This code doesn't deal with local variables
				* that contain object references.
				
				* Add it
				iCodeControl = This.LookUpControl(oControl)
				iRefControl = This.LookUpControl(cOwner + cControl)
				INSERT INTO ControlRefs ;
					(iRefControlFK, iCodeControlFK, ;
					 cMethod, nLine, nOccurrence) ;
					VALUES (m.iRefControl,m.iCodeControl, ;
					        m.cMethod, This.nCurLine, m.nOccurrence)
				
				* Look for the next occurrence
				nOccurrence = nOccurrence + 1 
				nPos = AT(cSearchFor, cLine, nOccurrence)
				
			ENDDO
			
			nFound = nFound + nOccurrence - 2
			nPos = AT(cSearchFor, cHoldCode, nFound + 1)

		ENDDO 
		
	ENDSCAN
	
	* Clean up
	SELECT (nOldSelect)
ENDIF

RETURN
ENDPROC

PROCEDURE GetTarget
* Grab a reference to the top-level control/form
LOCAL aSelected[1], oTarget, oLast

IF ASELOBJ(aSelected) = 0
	IF ASELOBJ(aSelected, 1) = 0
		oTarget = .null.
	ENDIF
ENDIF

IF VARTYPE(aSelected[1]) = "O"
	oTarget = aSelected[1]
	DO WHILE UPPER(oTarget.Parent.BaseClass)<>"FORMSET"
		oLast = oTarget
		oTarget = oTarget.Parent
	ENDDO
	
	* Form class/form or something else? If not a form class
	* need to go back down one level
	IF NOT PEMSTATUS(oTarget, "BufferMode", 5)
		* It's not a real form; it's the pseudo-form
		* represented by the Class Designer
		oTarget = oLast
	ENDIF
ELSE
	oTarget = .null.
ENDIF

RETURN oTarget

PROCEDURE BuildControlPath(oControl)
* Return the complete hierarchy to the specified control

LOCAL cReturn, oContainer

oContainer = oControl
cReturn = ""

DO WHILE oContainer <> This.oObject
	cReturn = "." + oContainer.Name + cReturn
	oContainer = oContainer.Parent
ENDDO

cReturn = oContainer.Name + cReturn

RETURN cReturn
ENDPROC

PROCEDURE GetCodeLineByPos(cCode, nPos)
* Extract the line of code containing the specified position

LOCAL nLineCount, nLinesToPos

nLineCount = ALINES(This.aProcLines, cCode)
nLinesToPos = OCCURS(CHR(13), LEFT(cCode, nPos)) + 1

This.nCurLine = nLinesToPos

RETURN This.aProcLines[nLinesToPos]
ENDPROC

PROCEDURE FindWith(nStartLine)
* Find the first occurrence of WITH preceding 
* the specified line and extract the referenced object

LOCAL nLine, cWithLine, nNamePos, cObject, cContainer

* Modified 16-August-2012 by TEG
* Handle WITH/ENDWITH encountered in the search
LOCAL nWithLevel
nWithLevel = 0

nLine = nStartLine - 1
* Modified 16-August-2012 by TEG
* Strip tabs as well. 
cWithLine = ALLTRIM(This.aProcLines[nLine], 1, " ", CHR(9))

DO WHILE nLine > 0 

    DO CASE 
        CASE UPPER(cWithLine) = "WITH " And nWITHLevel = 0
            EXIT 
        CASE UPPER(cWithLine) = "ENDW"
            nWITHLevel = nWITHLevel + 1
        CASE UPPER(cWithLine) = "WITH "
            nWITHLevel = nWITHLevel - 1
    ENDCASE 

	nLine = nLine - 1 
	cWithLine = ALLTRIM(This.aProcLines[nLine], 1, " ", CHR(9))
ENDDO 

* Modified 16-August-2012 by TEG
* Allow match on line 1
IF nLine > 0 && 1
	nNamePos = AT(" ", ALLTRIM(cWithLine))
	cObject = ALLTRIM(SUBSTR(cWithLine, nNamePos + 1))
	* Remove trailing period
	IF RIGHT(cObject,1)="."
		cObject = LEFT(cObject, LEN(cObject)-1)
	ENDIF
	
ELSE
	cObject = ""
ENDIF

IF LEFT(cObject, 1) = "."
	* Nested WITH, keep going back
	cContainer = This.FindWith(nLine)
	cObject = cContainer + cObject
ENDIF

RETURN cObject
ENDPROC

PROCEDURE LookUpControl(uControl)
* Find the specified control in AllControls
* and return its PK.
* The control can be passed as an object reference 
* or a string.

LOCAL cName, iReturn, nOldSelect, nOldRec

IF VARTYPE(uControl) = "O"
	cName = This.BuildControlPath(uControl)
ELSE
	cName = ALLTRIM(uControl)
ENDIF

nOldSelect = SELECT()
SELECT AllControls
nOldRec = RECNO()
GO TOP
LOCATE FOR UPPER(IIF(EMPTY(ALLTRIM(mFullPath)),"", ALLTRIM(mFullPath) + ".") + ALLTRIM(cControlOrig)) == UPPER(cName)
IF FOUND()
	iReturn = iID
ELSE
	iReturn = -1
ENDIF

* Reset
IF nOldRec <> 0
	GO nOldRec 
ELSE
	GO bottom
	SKIP 
ENDIF

SELECT (nOldSelect)

RETURN iReturn
ENDPROC 

PROCEDURE About
* Documentation method for this class
*==============================================================================
* Class:				ControlRenamer
* Based On: 			Custom
* Purpose:				Engine class for Control Renamer Builder
* Author:				Tamar E. Granor
* Copyright:			(c) 2005 Tamar E. Granor, Ph.D.
* Last revision:		05/02/05
* Include file:			None

* Changes in "Based On" class properties:
*	None
*
* Changes in "Based On" class methods:
*	Destroy--cleans up
*	Init--Creates necessary cursors, sets up environment
*
* Custom public properties added:
*	aProcLines--holds lines of a method while parsing
*	cOldExact--holds old EXACT setting.
*	lIsForm--indicates whether top-level object is a form/form class or not.
*	nCurLine--tracks lines in method while parsing
*	oObject--object reference to object being built
*
* Custom protected properties added:
*	None
*
* Custom public methods added:
*	About--this documentation method
*	AuditMethod--look for references to controls in a method
* 	BuildCodeRefs--kicks off process of searching for references 
*                  to controls in code
*	BuildControlPath--returns the complete path to a control
*	ChangeNames--main method for changing control names. 
*                Called after new names have been specified.
*	CheckForDups--checks specified names to ensure they are unique 
*                 within containers.
*	DrillCode--recursive method to check code for references
*	DrillControls--recursive method to find the list of controls
*	FindWith--searches backward through code in a method to find a
*             containing WITH command
*	GetCodeLineByPos--takes code and a position and returns the line of
*                     code containing that position
*	GetTarget--gets an object reference to the form or class that called on this builder
*	GrabControls--main method for building the list of controls
*	LookUpControl--Finds a specified control in the list of controls and
*                  returns its PK.
*
* Custom protected methods added:
*	None
*	
*==============================================================================


ENDDEFINE

