DEFINE CLASS colItemsVisited AS Collection 

oContainer = .null.
* If lAddToObject is .T., we'll add a unique key
* to each object the first time we encounter it.
* This should allow considerable speed-up of the
* process of loading data.
lAddToObject = .T.
nNextKey = 1

* Property name for cInspectorKey is unique for each run, so
* that leftovers from previous runs do not interfere / JRN / 2013-11-30
cInspectorKeyName = ''

PROCEDURE Init(oContainer)

This.oContainer = m.oContainer
This.cInspectorKeyName = '__cInspectorKey' + Sys(2015)

RETURN
ENDPROC

PROCEDURE AddItemVisited(oObject, cParentKey, cID, cType)

LOCAL oItem, cName

*!*	IF PEMSTATUS(oObject, "Name", 5)
*!*		cName = oObject.Name
*!*	ELSE
*!*		cName = "Unnamed object"
*!*	ENDIF 

*!*	This.oContainer.LogIt("Adding item visited: " + m.cName + "; parent key = " + m.cParentKey)

LOCAL cObjectKey
IF This.lAddToObject 
	cObjectKey = This.GetNewKey()
	ADDPROPERTY(m.oObject, This.cInspectorKeyName, m.cObjectKey)
ENDIF 

oItem = CREATEOBJECT("cusItemVisited", m.oObject, m.cParentKey, m.cID, m.cType)

IF This.lAddToObject
	This.Add(m.oItem, m.cObjectKey)
ELSE 
	This.Add(m.oItem)
ENDIF 

RETURN 

ENDPROC

PROCEDURE Destroy

* cleaning up after the party
For each loObject in This foxobject
	Try 
		RemoveProperty(loObject.oObject, this.cInspectorKeyName)
	Catch to loException
		
	EndTry
EndFor 

This.oContainer = .null.
This.Remove(-1)

ENDPROC

PROCEDURE IsItemVisited(oObject, cParentKey)
* Is the specified object with the specified parent key on the
* list of items already visited?
* We want to consider the item as visited if it's on the list
* with a parent key that's a subset of the one we passed in.
* That would meant that we visited it higher up in this same hierarchy.

LOCAL oItem, lFound

lFound = .F.

* If we're adding a key to each object, we can just look to
* see if the property exists.
IF This.lAddToObject
	IF PEMSTATUS(m.oObject, This.cInspectorKeyName, 5)
		lFound = .T.
	ELSE
		lFound = .F.
	ENDIF

ELSE 

	FOR EACH oItem IN This FOXOBJECT 
		IF oItem.oObject = m.oObject
			IF LEFT(m.cParentKey, LEN(oItem.cParentKey)) == oItem.cParentKey
				lFound = .T.
				EXIT
			ENDIF
		ENDIF
	ENDFOR
ENDIF 

RETURN m.lFound

PROCEDURE GetItemID(oObject)
* Return the ID stored for an object. If the object isn't
* in the collection, return the empty string.

LOCAL oItem, lFound, cID

lFound = .F.

* If we're adding a key to each object, we can look it up 
* that way.
IF This.lAddToObject
	IF PEMSTATUS(m.oObject, This.cInspectorKeyName, 5)
		oItem = This.GetByKey(GetPem(m.oObject, This.cInspectorKeyName))
		IF NOT ISNULL(m.oItem)
			cID = oItem.cID
			lFound = .T.
		ENDIF
	ENDIF
ELSE 

	FOR EACH oItem IN This FOXOBJECT 
		IF oItem.oObject = m.oObject
			lFound = .T.
			cID = oItem.cID
			EXIT
		ENDIF
	ENDFOR
ENDIF

IF NOT m.lFound
	cID = ""
ENDIF

RETURN m.cID
ENDPROC

PROCEDURE GetItemKey(oObject)
* Return the key for an object. If the object isn't
* in the collection, return the empty string.

LOCAL oItem, lFound, cID, cType, cKey

lFound = .F.

* If we're adding a key to each object, we can look it up 
* that way.
IF This.lAddToObject
	IF PEMSTATUS(m.oObject, This.cInspectorKeyName, 5)
		oItem = This.GetByKey(GetPem(oObject, This.cInspectorKeyName)) 
		IF NOT ISNULL(m.oItem)
			cID = oItem.cID
			cType = oItem.cType
			lFound = .T.
		ENDIF
	ENDIF
ELSE 
	FOR EACH oItem IN This FOXOBJECT 
		IF oItem.oObject = m.oObject
			lFound = .T.
			cID = oItem.cID
			cType = oItem.cType
			EXIT
		ENDIF
	ENDFOR
ENDIF 

IF m.lFound
	cKey = TRIM(m.cType) + "~" + TRIM(m.cID)
ELSE 
	cKey = ""
ENDIF

RETURN m.cKey
ENDPROC

PROCEDURE GetNewKey
* Return a new unique key for this collection.
* Since we only care within this collection, we can
* store the next value and bump it up as we go.

LOCAL cKey

cKey = TRANSFORM(This.nNextKey)
This.nNextKey = This.nNextKey + 1 

RETURN m.cKey
ENDPROC

PROCEDURE GetByKey(m.cKey)
* Return the member with the specified key

LOCAL oItem

TRY
	oItem = This.Item[m.cKey]
CATCH 
	oItem = .null.
ENDTRY

RETURN m.oItem
ENDPROC


ENDDEFINE

DEFINE CLASS cusItemVisited AS Custom 

oObject = .null.
cParentKey = ""
cID = ""
cType = ""

PROCEDURE Init(oObject, cParentKey, cID, cType)

IF PCOUNT() > 1
	WITH THIS
		.oObject = m.oObject
		.cParentKey= m.cParentKey
		.cID = m.cID
		.cType = m.cType
	ENDWITH
	
ENDIF 

RETURN
ENDPROC


PROCEDURE Destroy

This.oObject = .null.

RETURN
ENDPROC

ENDDEFINE

