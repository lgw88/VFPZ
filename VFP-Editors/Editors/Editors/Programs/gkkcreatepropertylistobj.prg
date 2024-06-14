************************************************************************************************
* Copyright ©2012 Gregory A. Green
*
* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*
************************************************************************************************
* Function to create the structure for holding the property name/value pair to be passed to the Layout Editor
*
FUNCTION GKKCreatePropertyListObj
LOCAL loPropList
loPropList = CREATEOBJECT("Empty")
ADDPROPERTY(loPropList, "FileName", "")
ADDPROPERTY(loPropList, "ObjParent", "")
ADDPROPERTY(loPropList, "ObjName", "")
ADDPROPERTY(loPropList, "ObjClass", "")
ADDPROPERTY(loPropList, "ObjUniqueId", "")
ADDPROPERTY(loPropList, "ObjClassLoc", "")
ADDPROPERTY(loPropList, "ObjBaseClass", "")
ADDPROPERTY(loPropList, "ZOrder", 0)
ADDPROPERTY(loPropList, "WBS", "")
ADDPROPERTY(loPropList, "ChildWBS", NEWOBJECT("GKKCollection", "GKKCollection.vcx"))
ADDPROPERTY(loPropList, "Property", NEWOBJECT("GKKCollection", "GKKCollection.vcx"))
ADDPROPERTY(loPropList, "ChildObjects", NEWOBJECT("GKKCollection", "GKKCollection.vcx"))
RETURN loPropList
ENDFUNC