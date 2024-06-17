LPARAM lcDBC
LOCAL lcPath,lcAlias,liCount,liIDT,liIDF,luValue,luValueO
LOCAL ARRAY xxa(1),xxb(1)
PRIVATE loDBC

CLEAR
#INCLUDE "dbc.h"

lcPath=SYS(16)
lcPath=IIF(RAT("\",m.lcPath)>0,LEFT(m.lcPath,RAT("\",m.lcPath)),m.lcPath)
SET PROCEDURE TO (m.lcPath+"dbc.prg")

lcAlias=SYS(2015)
lcDBC=IIF(EMPTY(m.lcDBC),HOME(2)+"\Tastrade\Data\tastrade.dbc",m.lcDBC)

loDBC=CREATEOBJECT("_DBC_Check") && _DBC


IF loDBC.OpenTable(m.lcDBC,m.lcAlias,"")#_DBC_ErrOK
   WAIT WIND "Can not open DBC file."
   RETURN
ENDIF


* Get all parts of database (inclusive of database)
liCount=loDBC.EnumObjects(m.lcAlias,_DBC_DataBase,"",@xxa)
=PrintObjects(m.liCount,@xxa)

* Get Stored Procedure
=m.loDBC.GetSP(m.lcAlias,_DBC_SP_TSource,@m.luValue)
?LEFT(m.luValue,100)+"..."
=loDBC.GetSP(m.lcAlias,_DBC_SP_TFXP,@m.luValue)
?LEFT(m.luValue,100)+"..."

* Set Stored Procedure
*!*	=DBC_SetSP(m.lcAlias,_DBC_SP_TSource,@m.luValue)
*!*	=DBC_SetSP(m.lcAlias,_DBC_SP_TFXP,@m.luValue)


* Get all tables
liCount=m.loDBC.EnumObjects(m.lcAlias,_DBC_Table,"",@xxa)
=PrintObjects(m.liCount,@xxa)

* Get all views
liCount=m.loDBC.EnumObjects(m.lcAlias,_DBC_View,"",@xxa)
=PrintObjects(m.liCount,@xxa)

* Get all Connections
liCount=m.loDBC.EnumObjects(m.lcAlias,_DBC_Connection,"",@xxa)
=PrintObjects(m.liCount,@xxa)


liIDT=m.loDBC.GetIDObject(m.lcAlias,_DBC_Table,"products")

* Get all Fields for table/view
liCount=m.loDBC.EnumObjects(m.lcAlias,_DBC_Field,m.liIDT,@xxa)
=PrintObjects(m.liCount,@xxa)

* Get all properties for Field
?"products."+xxa(1,2)
liCount=m.loDBC.EnumProperty(m.lcAlias,xxa(1,1),@xxb)
=PrintProperties(m.liCount,@xxb)

* xxa(1,1) - ID of Field
* xxb(2,1) - ID of Property, equal to _DBCID_Comment (in this case)

* Get property 
=m.loDBC.GetProperty(m.lcAlias,xxa(1,1),_DBCID_Comment,@m.luValueO)
?"Current value: products."+xxa(1,2)+"-"+m.loDBC.FormatProperty(_DBCID_Comment),m.luValueO

* Set property
=m.loDBC.SetProperty(m.lcAlias,xxa(1,1),_DBCID_Comment,"New comment"+SYS(2015))
=m.loDBC.GetProperty(m.lcAlias,xxa(1,1),_DBCID_Comment,@m.luValue)
?"New value: products."+xxa(1,2)+"-"+loDBC.FormatProperty(_DBCID_Comment),luValue

* Clear property
=m.loDBC.ClearProperty(m.lcAlias,xxa(1,1),_DBCID_Comment)
=m.loDBC.GetProperty(m.lcAlias,xxa(1,1),_DBCID_Comment,@m.luValue)
?"Droped: products."+xxa(1,2)+"-"+loDBC.FormatProperty(_DBCID_Comment),m.luValue

* Restore property
=loDBC.SetProperty(m.lcAlias,xxa(1,1),_DBCID_Comment,@m.luValueO)
=loDBC.GetProperty(m.lcAlias,xxa(1,1),_DBCID_Comment,@m.luValue)
?"Restored value: products."+xxa(1,2)+"-"+loDBC.FormatProperty(_DBCID_Comment),m.luValue

* Get all Relations for table/view
liCount=m.loDBC.EnumObjects(m.lcAlias,_DBC_Relation,m.liIDT,@xxa)
=PrintObjects(m.liCount,@xxa)

* Get RI Info for relation
=m.loDBC.RIInfo(m.lcAlias,xxa(1,1),@m.luValue)
?"products."+xxa(1,2),m.luValue


* Get all Indexes for table/view
liCount=m.loDBC.EnumObjects(m.lcAlias,_DBC_Index,m.liIDT,@xxa)
=PrintObjects(m.liCount,@xxa)

*****************************************************
* How to use connector for own properties
*****************************************************
#DEFINE MyProperty 1000 && user custom property (string)
#DEFINE MyProperty2 1001 && user custom property (any type)
#DEFINE _XXX_ValueType_XString 50000

loDBC.oConnector=CREATEOBJECT("_my_Connector")
* Set New property
=loDBC.SetProperty(m.lcAlias,m.liIDT,MyProperty,"Wow, I can write own property")
=loDBC.GetProperty(m.lcAlias,m.liIDT,MyProperty,@m.luValue)
?m.liIDT,MyProperty,m.luValue

liIDT=loDBC.GetIDObject(m.lcAlias,_DBC_Field,"products.product_id")
=m.loDBC.SetProperty(m.lcAlias,m.liIDT,MyProperty,"Wow, I can write own property")
=m.loDBC.GetProperty(m.lcAlias,m.liIDT,MyProperty,@luValue)
?m.liIDT,MyProperty,m.luValue

liIDT=loDBC.GetIDObject(m.lcAlias,_DBC_Field,"products.product_id")
?m.loDBC.SetProperty(m.lcAlias,m.liIDT,MyProperty2,"A") && OK
?m.loDBC.SetProperty(m.lcAlias,m.liIDT,MyProperty2,"G") && Failed

* Run checking method
=loDBC.Check(lcAlias, m.lcPath+"check.log")


=m.loDBC.CloseTable(m.lcAlias)


***********************************************************************************

PROCEDURE PrintObjects(liCount,laArray)
LOCAL lii
?PADR("ID",11)+" "+"Name"
FOR lii=1 TO m.liCount
    ?STR(laArray(m.lii,1),11)+" "+laArray(m.lii,2)
NEXT
?


PROCEDURE PrintProperties(liCount,laArray)
LOCAL lii,lcType
?PADR("ID",11)+" "+PADR("Name",30)+" "+"Value"
FOR lii=1 TO m.liCount
    lcType=TYPE("laArray(lii,2)")
    ?STR(laArray(m.lii,1),11)+" "+PADR(m.loDBC.FormatProperty(laArray(m.lii,1)),30)+" "+;
      IIF(ISNULL(laArray(m.lii,2)),".NULL.",;
      IIF(m.lcType="N",STR(laArray(m.lii,2),17),;
      IIF(m.lcType="C",laArray(m.lii,2),;
      IIF(m.lcType="L",IIF(laArray(m.lii,2),".T.",".F."),"Unknown"))))
NEXT
?


DEFINE CLASS _my_Connector AS _DBC_Connector
   
   PROCEDURE FormatProperty(liIDProp) && Convert property ID to Name
      * liIDProp   - Property ID
      RETURN IIF(m.liIDProp=MyProperty,"My New Property",;
             IIF(m.liIDProp=MyProperty2,"My New Property2","")) 
   ENDPROC

   PROCEDURE GetDefaultValue(liIDProp) && Get default Value
      * liIDProp   - Property ID
      RETURN IIF(m.liIDProp=MyProperty,"",;
             IIF(m.liIDProp=MyProperty2,"",.NULL.)) && default return value
   ENDPROC

   PROCEDURE GetValueType(liIDProp) && Return the property type
      * liIDProp - Property ID
      RETURN IIF(m.liIDProp=MyProperty,_DBC_ValueType_String,;
             IIF(m.liIDProp=MyProperty2,_XXX_ValueType_XString,_DBC_ValueType_Unknown))
   ENDPROC


   PROCEDURE DBCValueToValue(liType,lcValue) && Convert DBC value to Value
      * liType  - Property type
      * luValue - Property value
      RETURN IIF(m.liType=_XXX_ValueType_XString,LEFT(m.lcValue,LEN(m.lcValue)-1),m.lcValue)
   ENDPROC


   PROCEDURE ValueToDBCValue(liType,luValue) && Convert value to DBC value
      * liType  - Property type
      * luValue - Property value
      RETURN IIF(m.liType=_XXX_ValueType_XString,m.luValue+CHR(0),.NULL.)
   ENDPROC


   PROCEDURE CheckValue() && Check Value
      LPARAMETERS liIDProp,liType,luValue
      * liIDProp   - Property ID
      * liType     - Value type
      * luValue    - Value

      * 1) check type
      * 2) check interval
      * 4) return .T. is value valid or .F. is invalid
      RETURN IIF(m.liIDProp=MyProperty,.T.,;
             IIF(m.liIDProp=MyProperty2,TYPE("m.luValue")="C" AND INLIST(m.luValue,"A","B","C"),.F.))
   ENDPROC


   PROCEDURE CheckProperties() && Check property value (DBC value)
      LPARAMETERS liIDProp,liType,lcValue
      * liIDProp   - Property ID
      * liType     - Value type
      * lcValue    - DBC value

      RETURN IIF(m.liIDProp=MyProperty2,.T.,;
             IIF(m.liIDProp=MyProperty2,RIGHT(m.lcValue,1)=CHR(0) AND INLIST(m.lcValue,"A"+CHR(0),"B"+CHR(0),"C"+CHR(0)),.F.))
   ENDPROC

ENDDEFINE
