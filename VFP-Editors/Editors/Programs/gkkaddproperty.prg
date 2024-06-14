*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
* Function to create the structure for holding the property name/value pair to be passed to the Layout Editor
*
FUNCTION GKKAddProperty
LPARAMETERS tcName, txValue
LOCAL loProperty
loProperty = CREATEOBJECT("Empty")
ADDPROPERTY(loProperty, "Name", CHRTRAN(tcName, '~', ''))
ADDPROPERTY(loProperty, "Value", txValue)
RETURN loProperty
ENDFUNC