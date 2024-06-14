*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-* Copyright ©2014 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Routine for Getting the ActiveX Properties, Methods, and Events
*-*	Based on the ObjectBrowser solution provided in XSource
*-*
#IFNDEF GKKDEFINES
#INCLUDE GKKDefines.h
#ENDIF
FUNCTION GKKExploreActiveX
LPARAMETERS toTLI
LOCAL loPEMs, lnNdx, lnNdx2, lnNdx3, lnNdx4, loInterface, lcName, lnFound, loCoClass, lcPropList, lcMethList
LOCAL lcEventList, lcGKKResource
LOCAL ARRAY laInterfaceMap[1, 2], laPEMs[1]
*-*	Define the return PEM structure
loPEMs = CREATEOBJECT('Empty')
ADDPROPERTY(loPEMs, "Properties[1, 4]")
ADDPROPERTY(loPEMs, "PropCount", 0)
ADDPROPERTY(loPEMs, "Events[1, 4]")
ADDPROPERTY(loPEMs, "EventCount", 0)
ADDPROPERTY(loPEMs, "Methods[1, 4]")
ADDPROPERTY(loPEMs, "MethCount", 0)
ADDPROPERTY(loPEMs, "Objects[1, 2]")
ADDPROPERTY(loPEMs, "ObjCount", 0)
*-*	Get the PEMs if already stored in table for quick access
IF GKKGetResource('gkkobjs')
	SELECT gkkobjs
	LOCATE FOR otype = "ACTIVEX" .AND. id = toTLI.GUID .AND. !DELETED()
	IF FOUND()
		lcGKKResource = GKKGetConfigPath() + "gkkobjs.dbf"
		IF gkkobjs.updated > FDATE(lcGKKResource, 1)
			loPEMs.PropCount = ALINES(laPEMs, ALLTRIM(gkkobjs.oproperties), 5)
			IF loPEMs.PropCount > 0
				DIMENSION loPEMs.Properties[loPEMs.PropCount, 4]
				FOR lnNdx=1 TO loPEMs.PropCount
					FOR lnNdx2=1 TO 4
						loPEMs.Properties[lnNdx, lnNdx2] = GETWORDNUM(laPEMs[lnNdx], lnNdx2, ":")
					ENDFOR
				ENDFOR
			ENDIF

			loPEMs.EventCount = ALINES(laPEMs, ALLTRIM(gkkobjs.oevents), 5)
			IF loPEMs.EventCount > 0
				DIMENSION loPEMs.Events[loPEMs.EventCount, 4]
				FOR lnNdx=1 TO loPEMs.EventCount
					FOR lnNdx2=1 TO 4
						loPEMs.Events[lnNdx, lnNdx2] = GETWORDNUM(laPEMs[lnNdx], lnNdx2, ":")
					ENDFOR
				ENDFOR
			ENDIF

			loPEMs.MethCount = ALINES(laPEMs, ALLTRIM(gkkobjs.omethods), 5)
			IF loPEMs.MethCount > 0
				DIMENSION loPEMs.Methods[loPEMs.MethCount, 4]
				FOR lnNdx=1 TO loPEMs.PropCount
					FOR lnNdx2=1 TO 4
						loPEMs.Methods[lnNdx, lnNdx2] = GETWORDNUM(laPEMs[lnNdx], lnNdx2, ":")
					ENDFOR
				ENDFOR
			ENDIF
			RETURN loPEMs
		ELSE
			DELETE IN gkkobjs
		ENDIF
	ENDIF
ENDIF
*-*	Get the methods and properties
loPEMs.MethCount = 0
loPEMs.PropCount = 0
FOR lnNdx = 1 TO toTLI.Interfaces.Count
	loInterface = toTLI.Interfaces(lnNdx)
	FOR lnNdx2 = 1 TO loInterface.Members.Count
		lcName = loInterface.Members(lnNdx2).Name
		SET EXACT ON
		IF INLIST(LOWER(lcName), "addref", "getidsofnames", "gettypeinfocount", "invoke", "queryinterface", "release", "gettypeinfo")
			LOOP
		ENDIF
		SET EXACT OFF
		DO CASE
			CASE BITTEST(loInterface.Members(lnNdx2).InvokeKind, 0)		            && Method
				lnFound = ASCAN(loPEMs.Methods, lcName, 1 , ALEN(loPEMs.Methods, 1), 1, 15)
				IF lnFound > 0 
					IF ATC("|" + loInterface.Name + "|", loPEMs.Methods[lnFound, 2]) = 0
						loPEMs.Methods[lnFound, 2] = loPEMs.Methods[lnFound, 2] + loInterface.Name + "|"
					ENDIF
				ELSE
					loPEMs.MethCount = loPEMs.MethCount + 1
					DIMENSION loPEMs.Methods[loPEMs.MethCount, 4]
					loPEMs.Methods[loPEMs.MethCount, 1] = lcName
					loPEMs.Methods[loPEMs.MethCount, 2] = "|" + loInterface.Name + "|"
					loPEMs.Methods[loPEMs.MethCount, 3] = fCheckFlag(loInterface.Members(lnNdx2).AttributeMask, 64)
					loPEMs.Methods[loPEMs.MethCount, 4] = "|"
				ENDIF

			CASE INLIST(loInterface.Members(lnNdx2).InvokeKind, 2, 4, 8 ) ;		    && Properties
				.OR. (loInterface.Members(lnNdx2).InvokeKind = 0 .AND. loInterface.Members(lnNdx2).DescKind = 2)
				lnFound = ASCAN(loPEMs.Properties, lcName, 1 , ALEN(loPEMs.Properties, 1), 1, 15)
				IF lnFound > 0
					IF ATC("|" + loInterface.Name + "|", loPEMs.Properties[lnFound, 2]) = 0
						loPEMs.Properties[lnFound, 2] = loPEMs.Properties[lnFound, 2] + loInterface.Name + "|"
					ENDIF
				ELSE
					loPEMs.PropCount = loPEMs.PropCount + 1
					DIMENSION loPEMs.Properties[loPEMs.PropCount, 4]
					loPEMs.Properties[loPEMs.PropCount, 1] = lcName
					loPEMs.Properties[loPEMs.PropCount, 2] = "|" + loInterface.Name + "|"
					loPEMs.Properties[loPEMs.PropCount, 3] = fCheckFlag(loInterface.Members(lnNdx2).AttributeMask, 64)
					loPEMs.Properties[loPEMs.PropCount, 4] = "|"
				ENDIF
		ENDCASE
	ENDFOR
*-* Match the interface to a component class...
	DIMENSION laInterfaceMap[lnNdx, 2]
	laInterfaceMap[lnNdx, 1] = loInterface.Name
	laInterfaceMap[lnNdx, 2] = ""
	FOR lnNdx3=1 TO toTLI.CoClasses.Count
		loCoClass = toTLI.CoClasses(lnNdx3)
		FOR lnNdx4=1 TO loCoClass.Interfaces.Count
			IF loCoClass.Interfaces(lnNdx4).Name = laInterfaceMap[lnNdx, 1]
				laInterfaceMap[lnNdx, 2] = loCoClass.Name
				EXIT
			ENDIF
		ENDFOR
	ENDFOR
ENDFOR
*-*	Get the events
loPEMs.EventCount = 0
FOR lnNdx=1 TO toTLI.CoClasses.Count
	FOR lnNdx2=1 TO toTLI.CoClasses(lnNdx).Interfaces.Count
		loInterface = toTLI.CoClasses(lnNdx).Interfaces(lnNdx2)
		IF loInterface.TypeKind = 4		                                            && Display IDispatch interfaces only
			IF fCheckFlag(loInterface.AttributeMask, 2)
				FOR lnNdx3=1 TO loInterface.Members.Count
					IF BITTEST(loInterface.Members(lnNdx3).InvokeKind, 0)		    && Method
						lcName  = loInterface.Members(lnNdx3).Name
						lnFound = ASCAN(loPEMs.Events, lcName, 1 , ALEN(loPEMs.Events, 1), 1, 15)
						IF lnFound > 0
							IF ATC("|" + loInterface.Name + "|", loPEMs.Properties[lnFound, 2]) = 0
								loPEMs.Events[lnFound, 2] = loPEMs.Events[lnFound, 2] + loInterface.Name + "|"
							ENDIF
							IF ATC("|" + toTLI.CoClasses(lnNdx).Name + "|", loPEMs.Properties[lnFound, 4]) = 0
								loPEMs.Events[lnFound, 4] = loPEMs.Events[lnFound, 4] + toTLI.CoClasses(lnNdx).Name + "|"
							ENDIF
						ELSE
							loPEMs.EventCount = loPEMs.EventCount + 1
							DIMENSION loPEMs.Events[loPEMs.EventCount, 4]
							loPEMs.Events[loPEMs.EventCount, 1] = lcName
							loPEMs.Events[loPEMs.EventCount, 2] = "|" + loInterface.Name + "|"
							loPEMs.Events[loPEMs.EventCount, 3] = fCheckFlag(loInterface.Members(lnNdx3).AttributeMask, 64)
							loPEMs.Events[loPEMs.EventCount, 4] = "|" + toTLI.CoClasses(lnNdx).Name + "|"
						ENDIF
					ENDIF
				ENDFOR
			ENDIF
		ENDIF
	ENDFOR
ENDFOR
IF loPEMs.PropCount > 0
*-*	Map all the interfaces to component classes...
	ASORT(loPEMs.Properties)
	lcPropList = ""
	FOR lnNdx=1 TO loPEMs.PropCount
		lcInterfaces = loPEMs.Properties[lnNdx, 2]
		DO WHILE NOT EMPTY(lcInterfaces)
			IF "|" $ lcInterfaces
				lnAt = AT("|", lcInterfaces)
				lcInterface = LEFT(lcInterfaces, lnAt-1)
				lcInterfaces = SUBSTR(lcInterfaces, lnAt+1)
			ELSE
				lcInterface = lcInterfaces
				lcInterfaces = ""
			ENDIF
*-*			Search the interface name in the map array
			lnAt = ASCAN(laInterfaceMap, lcInterface, 1, 0, 1)
			IF lnAt > 0
				lnAt = (lnAt + 1)/2
				IF !EMPTY(laInterfaceMap[lnAt, 2]) .AND. ATC("|" + laInterfaceMap[lnAt, 2] + "|" , loPEMs.Properties[lnNdx, 4]) = 0
					loPEMs.Properties[lnNdx, 4] = loPEMs.Properties[lnNdx, 4] + laInterfaceMap[lnAt, 2] + "|"
				ENDIF
			ENDIF
		ENDDO
		FOR lnNdx2=1 TO 4
			lcPropList = lcPropList + loPEMs.Properties[lnNdx, lnNdx2] + ":"
		ENDFOR
		lcPropList = LTRIM(lcPropList, 1, ":") + CRLF
		DEBUGOUT " "
		DEBUGOUT "Property Name: ", loPEMs.Properties[lnNdx, 1]
		DEBUGOUT "Interface Map: ", loPEMs.Properties[lnNdx, 2]
		DEBUGOUT "Hidden: ",        loPEMs.Properties[lnNdx, 3]
		DEBUGOUT "Class Map: ",     loPEMs.Properties[lnNdx, 4]
	ENDFOR
ENDIF
IF loPEMs.MethCount > 0
*-*	Map all the interfaces to component classes...
	ASORT(loPEMs.Methods)
	lcMethList = ""
	FOR lnNdx=1 TO loPEMs.MethCount
		lcInterfaces = loPEMs.Methods[lnNdx, 2]
		DO WHILE NOT EMPTY(lcInterfaces)
			IF "|" $ lcInterfaces
				lnAt = AT("|", lcInterfaces)
				lcInterface = LEFT(lcInterfaces, lnAt-1)
				lcInterfaces = SUBSTR(lcInterfaces, lnAt+1)
			ELSE
				lcInterface = lcInterfaces
				lcInterfaces = ""
			ENDIF
*-*			Search the interface name in the map array
			lnAt = ASCAN(laInterfaceMap, lcInterface, 1, 0, 1)
			IF lnAt > 0
				lnAt = (lnAt + 1)/2
				IF !EMPTY(laInterfaceMap[lnAt, 2]) .AND. ATC("|" + laInterfaceMap[lnAt, 2] + "|" , loPEMs.Methods[lnNdx, 4]) = 0
					loPEMs.Methods[lnNdx, 4] = loPEMs.Methods[lnNdx, 4] + laInterfaceMap[lnAt, 2] + "|"
				ENDIF
			ENDIF
		ENDDO
		FOR lnNdx2=1 TO 4
			lcMethList = lcMethList + loPEMs.Methods[lnNdx, lnNdx2] + ":"
		ENDFOR
		lcMethList = RTRIM(lcMethList, 1, ":") + CRLF
		DEBUGOUT " "
		DEBUGOUT "Method Name: ",   loPEMs.Methods[lnNdx, 1]
		DEBUGOUT "Interface Map: ", loPEMs.Methods[lnNdx, 2]
		DEBUGOUT "Hidden: ",        loPEMs.Methods[lnNdx, 3]
		DEBUGOUT "Class Map: ",     loPEMs.Methods[lnNdx, 4]
	ENDFOR
ENDIF
IF loPEMs.EventCount > 0
	ASORT(loPEMs.Events)
	lcEventList = ""
	FOR lnNdx=1 TO loPEMs.EventCount
		FOR lnNdx2=1 TO 4
			lcEventList = lcEventList + loPEMs.Events[lnNdx, lnNdx2] + ":"
		ENDFOR
		lcEventList = RTRIM(lcEventList, 1, ":") + CRLF
		DEBUGOUT " "
		DEBUGOUT "Event Name: ",    loPEMs.Events[lnNdx, 1]
		DEBUGOUT "Interface Map: ", loPEMs.Events[lnNdx, 2]
		DEBUGOUT "Hidden: ",        loPEMs.Events[lnNdx, 3]
		DEBUGOUT "Class Map: ",     loPEMs.Events[lnNdx, 4]
	ENDFOR
ENDIF
*-*	Save the found PEMs to a table for quick access
IF GKKGetResource('gkkobjs')
	INSERT INTO gkkobjs (otype, id, oname, omethods, oproperties, oevents, updated) ;
		VALUES ("ACTIVEX", toTLI.GUID, "PEMS", lcMethList, lcPropList, lcEventList, DATETIME())
ENDIF
RETURN loPEMs
ENDFUNC



*-***********************************************************************************************
*-*  Routine for determining if bit is set for property/method in ActiveX
*-*
FUNCTION fCheckFlag
LPARAMETERS lnValue, lnFlag
LOCAL lnBit, lnNdx
lnBit = 0
DO WHILE lnFlag > 1
	lnBit = lnBit + 1
	lnFlag = lnFlag / 2	
ENDDO
RETURN BITTEST(lnValue, lnBit)
ENDFUNC