#INCLUDE "dbc.h"

*!*	<pdm_sc_yes/>
*!*	<pdm_dd_yes/>
******************************************************************
**
** DBC low level function
** 
** Version: 0.2.0
** 
** Author: Martin Jindra
** E-mail: martin.jindra@egservis.cz
** Date:   2006-06-04
** 
** Acknowledgments:
** Doug Henning: SPECIAL REPORT - Visual FoxPro Data Dictionary,
**               Pinnacle Publishing Inc.,
**               Kent,1995, ISBN 1-880935-41-4 
**
******************************************************************


*********************************************************************************
*
*********************************************************************************
DEFINE CLASS _DBC AS SESSION && Base dbc class
   Name="_DBC" && Name of class

   PROTECTED _DataSessionID
   _DataSessionID=0 && Backup datasession ID 
   DataSession=2 && Private data session
   Catch=.NULL. && Catch flag
   nErr=0 && Error number
   cErrMSG="" && Error message
   oConnector=.NULL. && Object reference to connector which can  (support for user custom properties)...
  
   PROCEDURE Init() && Backup session ID
      *!*   <pdm_sc_yes/>
      This._DataSessionID=This.DataSessionID
   ENDPROC

   PROCEDURE Destroy() && Restore Datasession ID
      *!*   <pdm_sc_yes/>
      IF This.DataSessionID#This._DataSessionID
         This.DataSessionID=This._DataSessionID
      ENDIF
   ENDPROC


   PROCEDURE GetIDObject(lcAlias,lcType,lcObjName) && Get Object ID
      * lcAlias   - Alias of opened DBC
      * lcType    - Object Type
      * lcObjName - Object Name

      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>

      SELE (m.lcAlias) && Skip to DBC 
      IF INLIST(m.lcType,_DBC_Field,_DBC_Index,_DBC_Relation)
         LOCAL lcParent,lii,lcObj
         lii=AT(".",m.lcObjName) && Find dot
         lcParent=PADR(UPPER(LEFT(m.lcObjName,m.lii-1)),128)
         lcObj=PADR(UPPER(SUBST(m.lcObjName,m.lii+1)),128)
         * Find Parent
         LOCATE FOR INLIST(ObjectType,_DBC_Table,_DBC_View) AND;
                    UPPER(ObjectName)==m.lcParent  AND ! DELE()
         IF FOUND() && If found
            lii=ObjectID
            * Find object
            LOCATE FOR ParentID=m.lii AND ObjectType==m.lcType AND ;
                       UPPER(ObjectName)==m.lcObj AND ! DELE()
         ENDIF
      ELSE
         LOCATE FOR ObjectType==m.lcType AND UPPER(ObjectName)==PADR(UPPER(m.lcObjName),128) AND ! DELE()
      ENDIF
      RETURN IIF(FOUND(),ObjectID,_DBC_ObjectNotFound)
   ENDPROC


   PROCEDURE EnumObjects() && Get list of object by type
      LPARAMETERS lcAlias,lcType,liIDParent,laObjects
      * lcAlias    - Alias of opened DBC
      * lcType     - Object Type
      * liIDParent - Parent ID
      * @laObjects - Output array for object

      EXTERNAL ARRAY laObjects

      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>

      IF EMPTY(m.lcType)
         RETURN _DBC_ErrParamFailed
      ENDIF
      LOCAL llFound,liCount,lii,liID
      liCount=0
      SELE (m.lcAlias) && Skip to DBC 
      IF INLIST(m.lcType,_DBC_Field,_DBC_Index,_DBC_Relation)
         SET FILTER TO ParentID=m.liIDParent AND ObjectType==m.lcType AND ! DELE()
      ELSE
         SET FILTER TO ObjectType==m.lcType AND ! DELE()
      ENDIF
      GO TOP
      COUNT TO liCount
      IF m.liCount>0
         DIME laObjects(m.liCount,2)
         GO TOP
         lii=0
         SCAN ALL
              lii=m.lii+1
              laObjects(m.lii,1)=OBJECTID
              laObjects(m.lii,2)=ALLT(OBJECTNAME)
         ENDSCAN
      ENDIF
      SET FILTER TO
      RETURN m.liCount
   ENDPROC


   PROCEDURE EnumProperty() && Get list of object properties
      LPARAMETERS lcAlias,liIDObject,laProp
      * lcAlias    - Alia sof opened DBC
      * liIDObject - Object ID
      * @laProp    - Output array for Properties and their values

      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>

      EXTERNAL ARRAY laProp

      LOCAL liStart,liLen,liLenID,lii
      liStart=1 && First char

      SELE (m.lcAlias) && Skip to DBC 
      LOCATE FOR ObjectID=m.liIDObject && Find object
      IF !FOUND() && If not found
         RETURN _DBC_ObjectNotFound && Get out
      ENDIF
      lii=0 && Reset counter
      DO WHILE m.liStart<=LEN(Property)
         liLen=This.C4ToI(SUBS(Property,m.liStart,4)) && Lenght
         * This is lenght of Property ID
         liLenID=IIF(This.C2ToI(SUBS(Property,m.liStart+4,2))>256,2,1)

         lii=m.lii+1 && Increment counter
         DIME laProp(m.lii,3)
         * Property ID
         laProp(m.lii,1)=IIF(m.liLenID=1,ASC(SUBS(Property,m.liStart+4+2,m.liLenID)),;
                             This.C2ToI(SUBS(Property,m.liStart+4+2,m.liLenID)))
         * Convert DBC value to Value
         laProp(lii,2)=This.DBCValueToValue(laProp(m.lii,1),;
                       SUBS(Property,m.liStart+3+2+m.liLenID+1,m.liLen-(3+2+m.liLenID+1)))
         liStart=m.liStart+m.liLen
      ENDDO
      RETURN m.lii
   ENDPROC


   PROCEDURE RIInfo() && Get RI Info for Relation
      LPARAMETERS lcAlias,liIDObject,luValue
      * lcAlias    - Alias of opened DBC
      * liIDObject - Object ID
      * @luValue   - (output) RI Info

      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>

      SELE (m.lcAlias) && Skip to DBC 
      LOCATE FOR ObjectID=m.liIDObject && Find object
      IF !FOUND() && If not found
         RETURN _DBC_ObjectNotFound && Get out
      ENDIF
      IF OBJECTTYPE#_DBC_Relation
         RETURN _DBC_ObjectNotType
      ENDIF
      luValue=RIINFO
      RETURN _DBC_ObjectFound
   ENDPROC


   PROCEDURE GetSP(lcAlias,liType,luValue) && Get Stored Procedure
      * lcAlias  - Alias of opened DBC
      * liType   - Type (Source code/ P-Code)
      * @luValue - (output) Stored procedures source code/P-Code

      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>

      SELE (m.lcAlias) && Skip to DBC 
      * Find object
      LOCATE FOR OBJECTTYPE=_DBC_DataBase AND;
             UPPER(ObjectName)==UPPER(IIF(liType=_DBC_SP_TSource,_DBC_SP_Source,_DBC_SP_FXP))
      IF !FOUND() && If not found
         RETURN _DBC_ObjectNotFound && Get out
      ENDIF
      luValue=CODE
      RETURN _DBC_ObjectFound
   ENDPROC


   PROCEDURE SetSP(lcAlias,liType,luValue) && Set Stored Procedure
      * lcAlias  - Alias of opened DBC
      * liType   - Type (Source code/ P-Code)
      * @luValue - (output) Stored procedures source code/P-Code

      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>

      SELE (m.lcAlias) && Skip to DBC 
      * Find object
      LOCATE FOR OBJECTTYPE=_DBC_DataBase AND ;
             UPPER(ObjectName)==UPPER(IIF(m.liType=_DBC_SP_TSource,_DBC_SP_Source,_DBC_SP_FXP))
      IF !FOUND() && If not found
         RETURN _DBC_ObjectNotFound && Get out
      ENDIF
      REPLACE CODE WITH m.luValue
      RETURN _DBC_ObjectFound
   ENDPROC


   PROCEDURE GetProperty() && Get Property's value
      LPARAMETERS lcAlias,liIDObject,liIDProp,luValue
      * lcAlias    - Alias of opened DBC
      * liIDObject - Object ID
      * liIDProp   - Property ID
      * @luValue   - (output) Value of property

      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>

      LOCAL liStart,liLen,liLenID
      liStart=1 && First char

      SELE (m.lcAlias) && Skip to DBC 
      LOCATE FOR ObjectID=m.liIDObject && Find object
      IF !FOUND() && If not found
         RETURN _DBC_ObjectNotFound && Get out
      ENDIF
      DO WHILE m.liStart<=LEN(Property)
         liLen=This.C4ToI(SUBS(Property,m.liStart,4)) && Lenght
         * This is lenght of Property ID
         liLenID=This.C2ToI(SUBS(Property,m.liStart+4,2))

         * Is't finding property
         IF This.CnToI(SUBS(Property,m.liStart+4+2,m.liLenID))=m.liIDProp
            luValue=This.DBCValueToValue(m.liIDProp,;
                    SUBS(Property,m.liStart+4+2+m.liLenID,m.liLen-(4+2+m.liLenID)) )
            RETURN _DBC_ObjectFound
         ENDIF
         liStart=m.liStart+m.liLen
      ENDDO
      luValue=This.GetDefaultValue(m.liIDProp)
      RETURN _DBC_ObjectFound
   ENDPROC


   PROCEDURE SetProperty(lcAlias,liIDObject,liIDProp,luValue) && Set Value of property
      * lcAlias    - Alias of opened DBC
      * liIDObject - Object ID
      * liIDProp   - Property ID
      * luValue    -  Value

      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>

      LOCAL liStart,liLen,liLenID,lcPom,liType
      liStart=1 && First char

      SELE (m.lcAlias) && Skip to DBC 
      LOCATE FOR ObjectID=m.liIDObject && Find object
      IF !FOUND() && If not found
         RETURN _DBC_ObjectNotFound && Get out
      ENDIF

      * Convert value to DBC value
      luValue=This.ValueToDBCValue(m.liIDProp,m.luValue)

      IF ISNULL(m.luValue)
         RETURN _DBC_ValueInvalid
      ENDIF

      DO WHILE m.liStart<=LEN(Property)
         liLen=This.C4ToI(SUBS(Property,m.liStart,4)) && Lenght
         * This is lenght of Property ID
         liLenID=This.C2ToI(SUBS(Property,m.liStart+4,2))

         * Is't finding property
         IF This.CnToI(SUBS(Property,m.liStart+4+2,m.liLenID))=m.liIDProp
            REPL Property WITH STUFF(Property,m.liStart,m.liLen,;
                          This.IToC4(4+2+m.liLenID+LEN(m.luValue))+;
                          This.IToC2(m.liLenID)+;
                          This.IToCn(m.liIDProp)+m.luValue)
            RETURN _DBC_ObjectFound
         ENDIF
         liStart=m.liStart+m.liLen
      ENDDO
      lcPom=This.IToCn(m.liIDProp)
      REPL Property WITH Property+;
                         This.IToC4(4+2+LEN(m.lcPom)+LEN(m.luValue))+;
                         This.IToC2(LEN(m.lcPom))+;
                         m.lcPom+m.luValue
      RETURN _DBC_ObjectFound
   ENDPROC


   PROCEDURE ClearProperty(lcAlias,liIDObject,liIDProp) && Clear property
      * lcAlias    - Alias of opened DBC
      * liIDObject - Object ID
      * liIDProp   - Property ID

      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>

      LOCAL liStart,liLen,liLenID
      liStart=1 && First char

      SELE (m.lcAlias) && Skip to DBC 
      LOCATE FOR ObjectID=m.liIDObject && Find object
      IF !FOUND() && If not found
         RETURN _DBC_ObjectNotFound && Get out
      ENDIF

      DO WHILE m.liStart<=LEN(Property)
         liLen=This.C4ToI(SUBS(Property,m.liStart,4)) && Lenght
         * This is lenght of Property ID
         liLenID=This.C2ToI(SUBS(Property,m.liStart+4,2))

         * Is't finding property
         IF This.CnToI(SUBS(Property,m.liStart+4+2,m.liLenID))=m.liIDProp
            REPL Property WITH STUFF(Property,m.liStart,m.liLen,"")
            EXIT
         ENDIF
         liStart=m.liStart+m.liLen
      ENDDO

      RETURN _DBC_ObjectFound
   ENDPROC


   PROCEDURE CheckProperties() && Check Property's value
      LPARAMETERS lcAlias,liIDObject,laProp
      * lcAlias    - Alias of opened DBC
      * liIDObject - Object ID
      * @laProp    - Output array for Properties, their values and results

      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>

      LOCAL liStart,liLen,liLenID,lii,liID,liType
      liStart=1 && First char

      SELE (m.lcAlias) && Skip to DBC 
      LOCATE FOR ObjectID=m.liIDObject && Find object
      IF !FOUND() && If not found
         RETURN _DBC_ObjectNotFound && Get out
      ENDIF
      lii=0 && Reset counter
      DO WHILE m.liStart<=LEN(Property)
         liLen=This.C4ToI(SUBS(Property,m.liStart,4)) && Lenght
         * This is lenght of Property ID
         liLenID=This.C2ToI(SUBS(Property,m.liStart+4,2))
         
         lii=m.lii+1
         DIMENSION laProp(m.lii,4)
         * Property ID
         laProp(m.lii,1)=This.CnToI(SUBS(Property,m.liStart+4+2,m.liLenID))

         * Native Value
         laProp(m.lii,3)=SUBS(Property,m.liStart+3+2+m.liLenID+1,m.liLen-(3+2+m.liLenID+1))

         * Check ID property
         liType=This.GetValueType(laProp(m.lii,1))
         IF liType=_DBC_ValueType_Unknown
            laProp(m.lii,4)=_DBC_Check_PropertyType_Unknown
         ELSE
            * Check if native value have right format
            IF IIF(m.liType=_DBC_ValueType_String, RIGHT(laProp(m.lii,3),1)#CHR(0),;
               IIF(m.liType=_DBC_ValueType_Byte, LEN(laProp(m.lii,3))#1,;
               IIF(m.liType=_DBC_ValueType_SI32R,LEN(laProp(m.lii,3))#4,;
               IIF(m.liType=_DBC_ValueType_I32R, LEN(laProp(m.lii,3))#4,;
               IIF(m.liType=_DBC_ValueType_Boolean, ;
                   LEN(laProp(m.lii,3))#1 OR !INLIST(ASC(laProp(m.lii,3)),0,1),;
               IIF(!ISNULL(This.oConnector),This.oConnector.CheckProperties(laProp(m.lii,1),liType,laProp(m.lii,3)),;
               .T.))))))
               laProp(m.lii,4)=_DBC_Check_PropertyValue_Invalid
            ELSE
               * Convert DBC value to Value
               laProp(m.lii,2)=This.DBCValueToValue(laProp(m.lii,1),laProp(m.lii,3))
               laProp(m.lii,4)=_DBC_Check_OK
            ENDIF
         ENDIF
         liStart=m.liStart+m.liLen
      ENDDO
      RETURN m.lii
   ENDPROC



   PROCEDURE IsBaseType(liType) && Return is value type is base or not
      * liType     - Value type

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
       
      RETURN INLIST(m.liType,;
          _DBC_ValueType_Unknown,;
          _DBC_ValueType_String,;
          _DBC_ValueType_Byte,;
          _DBC_ValueType_SI32R,;
          _DBC_ValueType_I32R,;
          _DBC_ValueType_Boolean)
   ENDPROC

   PROCEDURE GetValueType(liIDProp) && Return the property type
      * liIDProp - Property ID

      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>

      LOCAL liRet
      liRet=IIF(INLIST(m.liIDProp,_DBCID_Comment,_DBCID_Path,;
                _DBCID_RuleExpression,_DBCID_RuleText,_DBCID_InsertTrigger,;
                _DBCID_UpdateTrigger,_DBCID_DeleteTrigger,_DBCID_PrimaryKey,;
                _DBCID_DefaultValue,_DBCID_Caption,_DBCID_ChildTag,;
                _DBCID_ParentTable,_DBCID_Database) OR ;
                INLIST(m.liIDProp,_DBCID_ParentTag,_DBCID_DataSource,;
       	       _DBCID_ConnectString,_DBCID_Password,_DBCID_UserID,;
         	    _DBCID_ParameterList,_DBCID_ConnectName,_DBCID_SQL,;
                _DBCID_Tables,_DBCID_UpdateName,_DBCID_DataType,;
                _DBCID_DisplayClass,_DBCID_DisplayClassLibrary,;
                _DBCID_Format,_DBCID_InputMask,;
                _DBCID_DBCEventFileName),_DBC_ValueType_String,;
            IIF(INLIST(m.liIDProp,_DBCID_SubType,_DBCID_DispLogin,;
                _DBCID_Transactions,_DBCID_SourceType,;
                _DBCID_UpdateType,_DBCID_WhereType),_DBC_ValueType_Byte,;
            IIF(INLIST(m.liIDProp,_DBCID_FetchSize,_DBCID_MaxRecords),_DBC_ValueType_SI32R,;
            IIF(INLIST(m.liIDProp,_DBCID_ConnectTimeout,_DBCID_IdleTimeout,_DBCID_QueryTimeout,;
                _DBCID_WaitTime,_DBCID_PacketSize,_DBCID_UseMemoSize,;
                _DBCID_Version,_DBCID_BatchUpdateCount),_DBC_ValueType_I32R,;
            IIF(INLIST(m.liIDProp,_DBCID_Prim_Cand,_DBCID_Asynchronous,_DBCID_BatchMode,;
                _DBCID_DispWarnings,_DBCID_FetchMemo,_DBCID_ShareConnection,;
                _DBCID_SendUpdates,_DBCID_KeyField,_DBCID_Updatable,;
                _DBCID_CompareMemo,_DBCID_FetchAsNeeded,_DBCID_Offline,;
                _DBCID_Prepared,_DBCID_DBCEvents,_DBCID_AllowSimultaneousFetch,;
                _DBCID_DisconnectRollback),_DBC_ValueType_Boolean,_DBC_ValueType_Unknown)))))

      RETURN IIF(m.liRet=_DBC_ValueType_Unknown AND !ISNULL(This.oConnector),;
                 This.oConnector.GetValueType(m.liIDProp),m.liRet)
   ENDPROC


   PROCEDURE DBCValueToValue(liIDProp,lcValue) && Convert DBC value to Value
      * liIDProp - Property ID
      * luValue  - Property value

      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>

      LOCAL liType
      liType=This.GetValueType(m.liIDProp)

      IF !This.IsBaseType(m.liType) AND !ISNULL(This.oConnector)
         RETURN This.oConnector.DBCValueToValue(m.liType,@m.lcValue)
      ENDIF

      RETURN IIF(m.liType=_DBC_ValueType_String,LEFT(m.lcValue,LEN(m.lcValue)-1),;
             IIF(m.liType=_DBC_ValueType_Byte,ASC(m.lcValue),;
             IIF(m.liType=_DBC_ValueType_SI32R,;
                 IIF(m.lcValue=CHR(255)+CHR(255)+CHR(255)+CHR(255),-1,This.C4ToIRev(@m.lcValue)),;
             IIF(m.liType=_DBC_ValueType_I32R,This.C4ToIRev(@m.lcValue),;
             IIF(m.liType=_DBC_ValueType_Boolean,ASC(m.lcValue)=1,m.lcValue)))))

   ENDPROC


   PROCEDURE ValueToDBCValue(liIDProp,luValue) && Convert value to DBC value
      * liIDProp - Property ID
      * luValue  - Property value

      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>


      LOCAL liType
      liType=This.GetValueType(m.liIDProp)

      * Check value if is valid
      IF !This.CheckValue(m.liIDProp,m.liType,m.luValue)
         RETURN .NULL.
      ENDIF

      IF !This.IsBaseType(m.liType) AND !ISNULL(This.oConnector)
         RETURN This.oConnector.ValueToDBCValue(m.liType,m.luValue)
      ENDIF

      RETURN IIF(ISNULL(m.luValue),.NULL.,;
             IIF(m.liType=_DBC_ValueType_String ,m.luValue+CHR(0),;
             IIF(m.liType=_DBC_ValueType_Byte,CHR(m.luValue),;
             IIF(m.liType=_DBC_ValueType_SI32R,;
                 IIF(m.luValue=-1,CHR(255)+CHR(255)+CHR(255)+CHR(255),This.IToC4Rev(@m.luValue)),;
             IIF(m.liType=_DBC_ValueType_I32R,This.IToC4Rev(@m.luValue),;
             IIF(m.liType=_DBC_ValueType_Boolean,IIF(m.luValue,CHR(1),CHR(0)),.NULL.))))))
   ENDPROC



   PROCEDURE CheckValue() && Check Value
      LPARAMETERS liIDProp,liType,luValue
      * liIDProp   - Property ID
      * liType     - Value type
      * luValue    - Value

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
 
      * 1) check type
      * 2) interval
      * 3) if type is not base, call connector if defined
      * 4) return .T. is value valid or .F. is invalid
       
      IF (m.liType=_DBC_ValueType_String AND (!INLIST(TYPE("m.luValue"),"C","M") OR ISNULL(m.luValue))) OR ;
         (m.liType=_DBC_ValueType_Byte AND (!TYPE("m.luValue")="N" OR ISNULL(m.luValue))) OR ;
         (m.liType=_DBC_ValueType_SI32R AND (!TYPE("m.luValue")="N" OR ISNULL(m.luValue))) OR ;
         (m.liType=_DBC_ValueType_I32R AND (!TYPE("m.luValue")="N" OR ISNULL(m.luValue))) OR ;
         (m.liType=_DBC_ValueType_Boolean AND (!TYPE("m.luValue")="L" OR ISNULL(m.luValue)))
         RETURN .F.
      ENDIF

      DO CASE
         CASE INLIST(m.liIDProp,_DBCID_Comment,_DBCID_Path,;
              _DBCID_RuleExpression,_DBCID_RuleText,_DBCID_InsertTrigger,;
              _DBCID_UpdateTrigger,_DBCID_DeleteTrigger,_DBCID_PrimaryKey,;
              _DBCID_DefaultValue,_DBCID_Caption,_DBCID_ChildTag,;
              _DBCID_ParentTable,_DBCID_Database) OR ;
              INLIST(m.liIDProp,_DBCID_ParentTag,_DBCID_DataSource,;
              _DBCID_ConnectString,_DBCID_Password,_DBCID_UserID,;
              _DBCID_ParameterList,_DBCID_ConnectName,_DBCID_SQL,;
              _DBCID_Tables,_DBCID_UpdateName,_DBCID_DataType,;
              _DBCID_DisplayClass,_DBCID_DisplayClassLibrary,;
              _DBCID_Format,_DBCID_InputMask,;
              _DBCID_DBCEventFileName)
              RETURN .T.

         CASE m.liIDProp=_DBCID_SubType
              RETURN INLIST(m.luValue,1,6,7)

         CASE m.liIDProp=_DBCID_DispLogin
              RETURN INLIST(m.luValue,1,2,3)

         CASE m.liIDProp=_DBCID_Transactions
              RETURN INLIST(m.luValue,1,2)

         CASE m.liIDProp=_DBCID_SourceType
              RETURN INLIST(m.luValue,1,2)

         CASE m.liIDProp=_DBCID_UpdateType
              RETURN INLIST(m.luValue,1,2)

         CASE m.liIDProp=_DBCID_WhereType
              RETURN INLIST(m.luValue,1,2,3,4)

         CASE m.liIDProp=_DBCID_FetchSize
              RETURN m.luValue=-1 OR BETWEEN(m.luValue,0,0x7FFFFFFF)

         CASE m.liIDProp=_DBCID_MaxRecords
              RETURN m.luValue=-1 OR BETWEEN(m.luValue,0,0x7FFFFFFF)

         CASE m.liIDProp=_DBCID_ConnectTimeout
              RETURN BETWEEN(m.luValue,0,0x7FFFFFFF)

         CASE m.liIDProp=_DBCID_IdleTimeout
              RETURN BETWEEN(m.luValue,0,0xA8C0)

         CASE m.liIDProp=_DBCID_QueryTimeout
              RETURN BETWEEN(m.luValue,0,0x7FFFFFFF)

         CASE m.liIDProp=_DBCID_WaitTime
              RETURN BETWEEN(m.luValue,0,0x7FFFFFFF)

         CASE m.liIDProp=_DBCID_PacketSize
              RETURN BETWEEN(m.luValue,0,0x7FFFFFFF)

         CASE m.liIDProp=_DBCID_UseMemoSize
              RETURN BETWEEN(m.luValue,1,255)

         CASE m.liIDProp=_DBCID_Version
              RETURN INLIST(m.luValue,10,11)

         CASE m.liIDProp=_DBCID_BatchUpdateCount
              RETURN BETWEEN(m.luValue,0,0x7FFFFFFF)

         CASE INLIST(m.liIDProp,_DBCID_Prim_Cand,_DBCID_Asynchronous,_DBCID_BatchMode,;
              _DBCID_DispWarnings,_DBCID_FetchMemo,_DBCID_ShareConnection,;
              _DBCID_SendUpdates,_DBCID_KeyField,_DBCID_Updatable,;
              _DBCID_CompareMemo,_DBCID_FetchAsNeeded,_DBCID_Offline,;
              _DBCID_Prepared,_DBCID_DBCEvents,_DBCID_AllowSimultaneousFetch,;
              _DBCID_DisconnectRollback)
              RETURN .T.

         OTHERWISE !ISNULL(This.oConnector)
              RETURN This.oConnector.CheckValue(m.liIDProp,m.liType,m.luValue)

      ENDCASE
      RETURN .F.
   ENDPROC

   PROCEDURE GetDefaultValue(liIDProp) && Get default Value
      * liIDProp   - Property ID

      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL liRet
      liRet=IIF(INLIST(m.liIDProp,_DBCID_Comment,_DBCID_Path,;
                _DBCID_RuleExpression,_DBCID_RuleText,_DBCID_InsertTrigger,;
                _DBCID_UpdateTrigger,_DBCID_DeleteTrigger,_DBCID_PrimaryKey,;
                _DBCID_DefaultValue,_DBCID_Caption,_DBCID_ChildTag,;
                _DBCID_ParentTable,_DBCID_Database) OR ;
                INLIST(m.liIDProp,_DBCID_ParentTag,_DBCID_DataSource,;
       	       _DBCID_ConnectString,_DBCID_Password,_DBCID_UserID,;
       	       _DBCID_ParameterList,_DBCID_ConnectName,_DBCID_SQL,;
                _DBCID_Tables,_DBCID_UpdateName,_DBCID_DataType,;
                _DBCID_DisplayClass,_DBCID_DisplayClassLibrary,;
                _DBCID_Format,_DBCID_InputMask,_DBCID_DBCEventFileName),"",;
            IIF(INLIST(m.liIDProp,_DBCID_SubType,_DBCID_ConnectTimeout,;
                _DBCID_IdleTimeout,_DBCID_QueryTimeout),0,;
            IIF(INLIST(m.liIDProp,_DBCID_DispLogin,_DBCID_Transactions,;
                _DBCID_BatchUpdateCount,;
                _DBCID_SourceType,_DBCID_UpdateType,_DBCID_WhereType),1,;
            IIF(m.liIDProp=_DBCID_MaxRecords,-1,;
            IIF(m.liIDProp=_DBCID_Version,10,;
            IIF(INLIST(m.liIDProp,_DBCID_WaitTime,_DBCID_FetchSize),100,;
            IIF(m.liIDProp=_DBCID_PacketSize,4096,;
            IIF(m.liIDProp=_DBCID_UseMemoSize,255,;
            IIF(INLIST(m.liIDProp,_DBCID_DispWarnings,_DBCID_ShareConnection,;
                _DBCID_CompareMemo),.T.,;
            IIF(INLIST(m.liIDProp,_DBCID_Prim_Cand,_DBCID_Asynchronous,_DBCID_BatchMode,;
                _DBCID_FetchMemo,_DBCID_AllowSimultaneousFetch,_DBCID_DisconnectRollback,;
                _DBCID_SendUpdates,_DBCID_KeyField,_DBCID_Updatable,;
                _DBCID_FetchAsNeeded,_DBCID_Offline,;
                _DBCID_Prepared,_DBCID_DBCEvents),.F.,.NULL.))))))))))

      RETURN IIF(ISNULL(m.liRet) AND !ISNULL(This.oConnector),;
                 This.oConnector.GetDefaultValue(m.liIDProp),m.liRet)
   ENDPROC


   PROCEDURE FormatProperty(liIDProp) && Convert property ID to Name
      * liIDProp   - Property ID

      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>

      DO CASE
         CASE m.liIDProp=_DBCID_Path
              RETURN "Path"

         CASE m.liIDProp=_DBCID_SubType
              RETURN "SubType"

         CASE m.liIDProp=_DBCID_Comment
              RETURN "Comment"

         CASE m.liIDProp=_DBCID_RuleExpression
              RETURN "RuleExpression"

         CASE m.liIDProp=_DBCID_RuleText
              RETURN "RuleText"

         CASE m.liIDProp=_DBCID_DefaultValue
              RETURN "DefaultValue"

         CASE m.liIDProp=_DBCID_ParameterList
              RETURN "ParameterList"

         CASE m.liIDProp=_DBCID_ChildTag
              RETURN "ChildTag"

         CASE m.liIDProp=_DBCID_InsertTrigger
              RETURN "InsertTrigger"

         CASE m.liIDProp=_DBCID_UpdateTrigger
              RETURN "UpdateTrigger"

         CASE m.liIDProp=_DBCID_DeleteTrigger
              RETURN "DeleteTrigger"

         CASE m.liIDProp=_DBCID_Prim_Cand
              RETURN "Prim_Cand"

         CASE m.liIDProp=_DBCID_ParentTable
              RETURN "ParentTable"

         CASE m.liIDProp=_DBCID_ParentTag
              RETURN "ParentTag"

         CASE m.liIDProp=_DBCID_PrimaryKey
              RETURN "PrimaryKey"

         CASE m.liIDProp=_DBCID_Version
              RETURN "Version"

         CASE m.liIDProp=_DBCID_BatchUpdateCount
              RETURN "BatchUpdateCount"

         CASE m.liIDProp=_DBCID_DataSource
              RETURN "DataSource"

         CASE m.liIDProp=_DBCID_ConnectName
              RETURN "ConnectName"

         CASE m.liIDProp=_DBCID_UpdateName
              RETURN "UpdateName"

         CASE m.liIDProp=_DBCID_FetchMemo
              RETURN "FetchMemo"

         CASE m.liIDProp=_DBCID_FetchSize
              RETURN "FetchSize"

         CASE m.liIDProp=_DBCID_KeyField
              RETURN "KeyField"

         CASE m.liIDProp=_DBCID_MaxRecords
              RETURN "MaxRecords"

         CASE m.liIDProp=_DBCID_ShareConnection
              RETURN "ShareConnection"

         CASE m.liIDProp=_DBCID_SourceType
              RETURN "SourceType"

         CASE m.liIDProp=_DBCID_SQL
              RETURN "SQL"

         CASE m.liIDProp=_DBCID_Tables
              RETURN "Tables"

         CASE m.liIDProp=_DBCID_SendUpdates
              RETURN "SendUpdates"

         CASE m.liIDProp=_DBCID_Updatable
              RETURN "Updatable"

         CASE m.liIDProp=_DBCID_UpdateType
              RETURN "UpdateType"

         CASE m.liIDProp=_DBCID_UseMemoSize
              RETURN "UseMemoSize"

         CASE m.liIDProp=_DBCID_WhereType
              RETURN "WhereType"

         CASE m.liIDProp=_DBCID_DisplayClass
              RETURN "DisplayClass"

         CASE m.liIDProp=_DBCID_DisplayClassLibrary
              RETURN "DisplayClassLibrary"

         CASE m.liIDProp=_DBCID_Format
              RETURN "Format"

         CASE m.liIDProp=_DBCID_InputMask
              RETURN "InputMask"

         CASE m.liIDProp=_DBCID_Caption
              RETURN "Caption"

         CASE m.liIDProp=_DBCID_Asynchronous
              RETURN "Asynchronous"

         CASE m.liIDProp=_DBCID_BatchMode
              RETURN "BatchMode"

         CASE m.liIDProp=_DBCID_ConnectString
              RETURN "ConnectString"

         CASE m.liIDProp=_DBCID_ConnectTimeout
              RETURN "ConnectTimeout"

         CASE m.liIDProp=_DBCID_DispLogin
              RETURN "DispLogin"

         CASE m.liIDProp=_DBCID_DispWarnings
              RETURN "DispWarnings"

         CASE m.liIDProp=_DBCID_IdleTimeout
              RETURN "IdleTimeout"

         CASE m.liIDProp=_DBCID_QueryTimeout
              RETURN "QueryTimeout"

         CASE m.liIDProp=_DBCID_Password
              RETURN "Password"

         CASE m.liIDProp=_DBCID_Transactions
              RETURN "Transactions"

         CASE m.liIDProp=_DBCID_UserID
              RETURN "UserID"

         CASE m.liIDProp=_DBCID_WaitTime
              RETURN "WaitTime"

         CASE m.liIDProp=_DBCID_TimeStamp
              RETURN "TimeStamp"

         CASE m.liIDProp=_DBCID_DataType
              RETURN "DataType"

         CASE m.liIDProp=_DBCID_PacketSize
              RETURN "PacketSize"

         CASE m.liIDProp=_DBCID_Database
              RETURN "Database"

         CASE m.liIDProp=_DBCID_Prepared
              RETURN "Prepared"

         CASE m.liIDProp=_DBCID_CompareMemo
              RETURN "CompareMemo"

         CASE m.liIDProp=_DBCID_FetchAsNeeded
              RETURN "FetchAsNeeded"

         CASE m.liIDProp=_DBCID_Offline
              RETURN "Offline"

         CASE m.liIDProp=_DBCID_DBCEvents
              RETURN "DBCEvents"

         CASE m.liIDProp=_DBCID_DBCEventFileName
              RETURN "DBCEventFileName"

         CASE m.liIDProp=_DBCID_AllowSimultaneousFetch
              RETURN "AllowSimultaneousFetch"

         CASE m.liIDProp=_DBCID_DisconnectRollback
              RETURN "DisconnectRollback"

        OTHERWISE
             RETURN IIF(!ISNULL(This.oConnector),;
                    This.oConnector.FormatProperty(m.liIDProp),"")

      ENDCASE
      RETURN ""
   ENDPROC

   PROCEDURE CnToI(lcInt) && Convert 1-5 bytes string to Integer
      * lcInt - Binary format of integer
      *!*   <pdm_sc_yes/>
      LOCAL liLen,lii,liInt
      liLen=LEN(m.lcInt)
      DO CASE
         CASE m.liLen=1
              RETURN ASC(m.lcInt)
         CASE m.liLen=2
              RETURN This.C2ToI(m.lcInt)
         CASE m.liLen=4
              RETURN This.C4ToI(m.lcInt)

         OTHERWISE
              liInt=0
              FOR lii=1 TO LEN(m.lcInt)
                  liInt=m.liInt+ASC(SUBS(m.lcInt,m.lii,1))*2^((m.lii-1)*8)
              NEXT
              RETURN m.liInt
      ENDCASE

      RETURN 0
   ENDPROC

   PROCEDURE IToCn(liInt) && Convert Integer to 1-5 bytes string
      * liInt - Integer
      *!*   <pdm_sc_yes/>
      LOCAL lcVal,lii
      DO CASE
         CASE m.liInt<0x100
              RETURN CHR(liInt)
         CASE m.liInt<0x10000
              RETURN This.IToC2(m.liInt)
         CASE m.liInt<0x10000
              RETURN This.IToC4(m.liInt)

         OTHERWISE
             lcVal=""
             DO WHILE m.liInt>0
                 lii=INT(m.liInt/256) && Vydìl 256
                 lcVal=m.lcVal+CHR(m.liInt-m.lii*256) && Pøeveï rozdíl na znak a pøièti ho
                 liInt=m.lii && Zapiš novou hodnotu pro pøevod
             ENDDO
      ENDCASE

      RETURN 0
   ENDPROC



   PROCEDURE C4ToI(lcInt)  && Convert binnary format to number (32)
      * lcInt - Binary format of integer
      *!*   <pdm_sc_yes/>
      RETURN ASC(LEFT(m.lcInt,1))+;
             ASC(SUBS(m.lcInt,2,1))*256+;
             ASC(SUBS(m.lcInt,3,1))*65536+;
             ASC(RIGHT(m.lcInt,1))*16777216
   ENDPROC


   PROCEDURE C4ToIRev(lcInt)  && Convert binnary format (reverz) to number (32)
      * lcInt - Binary format of integer
      *!*   <pdm_sc_yes/>
      RETURN ASC(LEFT(m.lcInt,1))*16777216+;
             ASC(SUBS(m.lcInt,2,1))*65536+;
             ASC(SUBS(m.lcInt,3,1))*256+;
             ASC(RIGHT(m.lcInt,1))
   ENDPROC


   PROCEDURE C2ToI(lcInt)  && Convert binnary format to number (16)
      * lcInt - Binary format of integer
      *!*   <pdm_sc_yes/>
      RETURN ASC(LEFT(m.lcInt,1))+ASC(RIGHT(m.lcInt,1))*256  
   ENDPROC


   PROCEDURE IToC2(liVal) && Convert number (16) to binnary format
      * liInt - Integer
      LOCAL lcVal,lii
      *!*   <pdm_sc_yes/>

      lii=INT(m.liVal/256) && Vydìl 256
      lcVal=CHR(m.liVal-m.lii*256) && Pøeveï rozdíl na znak a pøièti ho
      liVal=m.lii && Zapiš novou hodnotu pro pøevod

      lii=INT(m.liVal/256) && Vydìl 256
      RETURN m.lcVal+CHR(m.liVal-m.lii*256)
   ENDPROC


   PROCEDURE IToC4(liVal) && Convert number (32) to binnary format
      * liInt - Integer
      LOCAL lcVal,lii
      *!*   <pdm_sc_yes/>

      lii=INT(m.liVal/256) && Vydìl 256
      lcVal=CHR(m.liVal-m.lii*256) && Pøeveï rozdíl na znak a pøièti ho
      liVal=m.lii && Zapiš novou hodnotu pro pøevod

      lii=INT(m.liVal/256) && Vydìl 256
      lcVal=m.lcVal+CHR(m.liVal-m.lii*256)
      liVal=m.lii && Zapiš novou hodnotu pro pøevod

      lii=INT(m.liVal/256) && Vydìl 256
      lcVal=m.lcVal+CHR(m.liVal-m.lii*256)
      liVal=m.lii && Zapiš novou hodnotu pro pøevod

      lii=INT(m.liVal/256) && Vydìl 256
      RETURN m.lcVal+CHR(m.liVal-m.lii*256) && Pøeveï rozdíl na znak a pøièti ho
   ENDPROC

   PROCEDURE IToC4Rev(liVal) && Convert number (32) to binnary format (reverz)
      * liInt - Integer
      LOCAL lcVal,lii
      *!*   <pdm_sc_yes/>

      lii=INT(m.liVal/256) && Vydìl 256
      lcVal=CHR(m.liVal-m.lii*256) && Pøeveï rozdíl na znak a pøièti ho
      liVal=m.lii && Zapiš novou hodnotu pro pøevod

      lii=INT(m.liVal/256) && Vydìl 256
      lcVal=CHR(m.liVal-m.lii*256)+m.lcVal
      liVal=m.lii && Zapiš novou hodnotu pro pøevod

      lii=INT(m.liVal/256) && Vydìl 256
      lcVal=CHR(m.liVal-m.lii*256)+m.lcVal
      liVal=m.lii && Zapiš novou hodnotu pro pøevod

      lii=INT(m.liVal/256) && Vydìl 256
      RETURN CHR(m.liVal-m.lii*256)+m.lcVal && Pøeveï rozdíl na znak a pøièti ho
   ENDPROC


   PROCEDURE SetCatch(llCatch) && Catching error
      * llCatch - Mode cathing (.T. - catch, .F. - nocatch, .NULL. - nocatch,???? )
 
      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>

      LOCAL luCatch
      luCatch=This.Catch
      This.Catch=m.llCatch
      IF llCatch && If catching
         * the reset error and message number
         This.nErr=0 
         This.cErrMSG=""
      ENDIF
      RETURN m.luCatch && Return old catch flag
   ENDPROC


   PROCEDURE AttachSession(liSessionID) && Attach Session
      * liSessionID - Datasession ID

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>

      LOCAL luCatch
      luCatch=m.This.SetCatch(.T.)
      SET DATASESSION TO (m.liSessionID)
      =m.This.SetCatch(m.luCatch)
      RETURN m.This.nErr
   ENDPROC

   PROCEDURE OpenTable(lcFile,lcAlias,lcParam) && Open Table
      * lcFile  - Folder and name of table
      * lcAlias - Alias
      * lcParam - Parameters

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
      LOCAL luCatch
      luCatch=m.This.SetCatch(.T.)
      USE (m.lcFile) ALIAS (m.lcAlias) IN 0 &lcParam.
      =m.This.SetCatch(m.luCatch)
      RETURN m.This.nErr
   ENDPROC

   PROCEDURE CloseTable(lcAlias) && Close table
      * lcAlias - Alias 
      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>

      IF USED(m.lcAlias)
         USE IN (m.lcAlias)
      ENDIF
      RETURN _DBC_ErrOK
   ENDPROC

   PROCEDURE Error(nError,cMethod,nLine) && Error routine
      * nError  - Error number
      * cMethod - Name of Method
      * nLine   - Number in method

      *!*   <pdm_sc_yes/>

      IF ISNULL(m.This.Catch)
         This.nErr=m.nError
         This.cErrMSG=MESSAGE() 
         ERROR m.nError
         RETURN
      ENDIF
      IF This.Catch && Catch
         This.nErr=m.nError
         This.cErrMSG=MESSAGE()
      ELSE
         ERROR m.nError
      ENDIF
   ENDPROC



ENDDEFINE

*********************************************************************************
*
*********************************************************************************
DEFINE CLASS _DBC_Check AS _DBC && Class for checking DBC
   Name="_DBC_Check"
   cLogFile=""
   hLogFile=0

   PROCEDURE Check(lcAlias, m.lcFile) && Check DBC integrity
      * lcAlias - Alias of opened DBC

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>

      LOCAL loInfo
      loInfo=CREATEOBJECT("_DBC_CheckInfo")

      =This.FindLostObjects(m.lcAlias,m.loInfo)
      =This.FindObsoleteObjects(m.lcAlias,m.loInfo)
      =This.CheckPropertiesOfAllObjects(m.lcAlias,m.loInfo)
      =This.CheckSPFXP(m.lcAlias,m.loInfo)

      This.cLogFile=m.lcFile
      This.hLogFile=IIF(NOT EMPTY(m.lcFile), FCREATE(m.lcFile), 0)
      
      =This.CreateLog(m.lcAlias,m.loInfo)
      
      =IIF(This.hLogFile>0, FCLOSE(This.hLogFile), .T.)
   ENDPROC


   PROCEDURE FindLostObjects(lcAlias,loInfo) && Find lost objects
      * lcAlias - Alias of opened DBC
      * loInfo  - Info object

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
      SELECT AA.OBJECTID FROM (m.lcAlias) AA;
             WHERE NOT DELETED() AND NOT AA.PARENTID IN (SELECT AB.OBJECTID FROM (m.lcAlias) AB);
             INTO ARRAY loInfo.aLostObjects

      loInfo.iLostObjects=_TALLY
      RETURN 
   ENDPROC

   PROCEDURE FindObsoleteObjects(lcAlias,loInfo) && Find obsolete objects
      * lcAlias - Alias of opened DBC
      * loInfo  - Info object

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
      SELECT AA.OBJECTID FROM (m.lcAlias) AA;
             WHERE DELETED();
             INTO ARRAY loInfo.aObsoleteObjects

      loInfo.iObsoleteObjects=_TALLY
      RETURN 
   ENDPROC

   PROCEDURE CheckPropertiesOfAllObjects(lcAlias,loInfo) && Check properties of all objects
      * lcAlias    - Alias of opened DBC
      * loInfo - Info object

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>

      LOCAL lii,liCount,liy
      LOCAL ARRAY laProp(1)

      liy=0
      SELECT (m.lcAlias)
      SCAN FOR !DELETED() AND OBJECTNAME#PADR("TransactionLog",128) AND ;
               OBJECTNAME#PADR("StoredProceduresSource",128) AND ;
               OBJECTNAME#PADR("StoredProceduresObject",128)

           liCount=This.CheckProperties(m.lcAlias,OBJECTID,@laProp) && Check Property's value

           FOR lii=1 TO m.liCount
               IF laProp(m.lii,4)#_DBC_Check_OK
                  liy=m.liy+1
                  DIMENSION m.loInfo.aInvalidProperties(m.liy)
                  loInfo.aInvalidProperties(m.liy)=CREATEOBJECT("_DBC_CheckInfo_InvalidProperties")
                  loInfo.aInvalidProperties(m.liy).ObjectID=OBJECTID
                  ACOPY(laProp,m.loInfo.aInvalidProperties(m.liy).aInvalidProperties)
                  loInfo.aInvalidProperties(liy).iInvalidProperties=m.liCount
                  EXIT
               ENDIF
           NEXT

      ENDSCAN
      loInfo.iInvalidProperties=m.liy
   ENDPROC


   PROCEDURE CheckSPFXP(lcAlias,loInfo) && Check stored procedures FXP code
      * lcAlias - Alias of opened DBC
      * loInfo  - Info object

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>

      * backup SET DEFA
      * set DBC path as SET DEFA
      * save SP as PRG and recompile it
      * Get SP FXP and compare it with recompiled source code

      LOCAL lcOldDEFA,lcSC,lcFXP,lcTMP,lcFRXPN,luCatch
      lcOldDEFA=SET("DEFA")+CURDIR()

      SET DEFAULT TO (JUSTPATH(DBF(m.lcAlias))+"\")
      * Get Stored Procedure
      =loDBC.GetSP(m.lcAlias,_DBC_SP_TSource,@m.lcSC)
      =loDBC.GetSP(m.lcAlias,_DBC_SP_TFXP,@m.lcFXP)
      lcTMP=SYS(2023)+"\"+SYS(2015)+".prg"
      loInfo.SPFXP=_DBC_SP_CheckFXP_OK

      luCatch=m.This.SetCatch(.T.)
      =STRTOFILE(m.lcSC,m.lcTMP)
      IF This.nErr#0
         loInfo.SPFXP=_DBC_SP_CheckFXP_CantSavePRG
      ENDIF
      IF This.nErr=0
         =m.This.SetCatch(.T.)
         COMPILE (m.lcTMP) 
         IF This.nErr#0
            loInfo.SPFXP=_DBC_SP_CheckFXP_CantCompilePRG
         ENDIF
      ENDIF     

      IF This.nErr=0
         =m.This.SetCatch(.T.)
         lcFXPN=FILETOSTR(FORCEEXT(m.lcTMP,"fxp"))
         IF This.nErr#0
            loInfo.SPFXP=_DBC_SP_CheckFXP_CantReadFXP
         ENDIF
      ENDIF     

      IF This.nErr=0
         loInfo.SPFXP = IIF(m.lcFXP==m.lcFXPN,_DBC_SP_CheckFXP_OK,_DBC_SP_CheckFXP_Failed) && Stored procedures FXP status
         IF FILE(FORCEEXT(m.lcTMP,"err"))
            =m.This.SetCatch(.T.)
            loInfo.SPFXPResult = FILETOSTR(FORCEEXT(m.lcTMP,"err")) && Stored procedures Error result
            IF This.nErr#0
               loInfo.SPFXP=_DBC_SP_CheckFXP_CantReadErr
            ENDIF
         ENDIF
      ENDIF

      DELETE FILE (m.lcTMP)
      DELETE FILE (FORCEEXT(m.lcTMP,"fxp"))
      DELETE FILE (FORCEEXT(m.lcTMP,"err"))
      SET DEFAULT TO (m.lcOldDEFA)
      =m.This.SetCatch(m.luCatch)
   ENDPROC


   PROCEDURE CheckTablesStructure(lcAlias,loInfo) && Check tables structure
      * lcAlias - Alias of opened DBC
      * loInfo  - Info object

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>

   ENDPROC

   PROCEDURE CreateLog(lcAlias,loInfo) && Create output file
      * lcAlias - Alias of opened DBC
      * loInfo - Info object

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
      LOCAL m.lcData, m.lii, m.liy
      
      IF m.loInfo.iLostObjects>0
         m.lcData="Lost objects"+_DBC_CRLF+;
                  "================"
         This.WriteToLog(m.lcData)
         FOR m.lii=1 TO m.loInfo.iLostObjects  
             SELE (m.lcAlias) && Skip to DBC 
             LOCATE FOR ObjectID=m.loInfo.aLostObjects(m.lii) && Find object
             m.lcData="ID: "+LTRIM(STR(OBJECTID))+", Name: "+ALLTRIM(ObjectName)+", Object type: "+ALLTRIM(ObjectType)
             This.WriteToLog(m.lcData)
         NEXT
         This.WriteToLog("")
      ENDIF 

      IF m.loInfo.iObsoleteObjects>0
         m.lcData="Obsolete objects"+_DBC_CRLF+;
                  "================"
         This.WriteToLog(m.lcData)
         FOR m.lii=1 TO m.loInfo.iObsoleteObjects  
             SELE (m.lcAlias) && Skip to DBC 
             LOCATE FOR ObjectID=m.loInfo.aObsoleteObjects(m.lii) && Find object
             m.lcData="ID: "+LTRIM(STR(OBJECTID))+", Name: "+ALLTRIM(ObjectName)+", Object type: "+ALLTRIM(ObjectType)
             This.WriteToLog(m.lcData)
         NEXT
         This.WriteToLog("")
      ENDIF 

      IF m.loInfo.iInvalidProperties>0
         m.lcData="Invalid properties"+_DBC_CRLF+;
                  "=================="
         This.WriteToLog(m.lcData)
         FOR m.lii=1 TO m.loInfo.iInvalidProperties
             SELE (m.lcAlias) && Skip to DBC 
             LOCATE FOR ObjectID=m.loInfo.aInvalidProperties(m.lii).ObjectID && Find object
             m.lcData="ID: "+LTRIM(STR(OBJECTID))+", Name: "+ALLTRIM(ObjectName)+", Object type: "+ALLTRIM(ObjectType)+", Invalid props: "+LTRIM(STR(loInfo.aInvalidProperties(m.lii).iInvalidProperties))
             This.WriteToLog(m.lcData)

             WITH m.loInfo.aInvalidProperties(m.lii)
             FOR m.liy=1 TO .iInvalidProperties
                 IF .aInvalidProperties(m.liy, 4)=_DBC_Check_OK
                    LOOP
                 ENDIF 

                 m.lcData="  Property ID: "+LTRIM(STR(.aInvalidProperties(m.liy, 1)))+_DBC_CRLF+;
                          "  Status: "+IIF(.aInvalidProperties(m.liy, 4)=_DBC_Check_PropertyType_Unknown, "Unknown",;
                                            IIF(.aInvalidProperties(m.liy, 4)=_DBC_Check_PropertyValue_Invalid, "Invalid", "OK"))+_DBC_CRLF+;
                          "  Native Value: "+STRCONV(.aInvalidProperties(m.liy, 3), 15)+_DBC_CRLF+;
                          "  VFP Value: "+TRANSFORM(.aInvalidProperties(m.liy, 2))+_DBC_CRLF
                 This.WriteToLog(m.lcData)

              NEXT
              ENDWITH
         NEXT
         This.WriteToLog("")
      ENDIF


      m.lcData="Stored procedures"+_DBC_CRLF+;
               "================="+_DBC_CRLF+;
               "FXP Status: "+STR(m.loInfo.SPFXP, 2)+" - "+;
                              IIF(m.loInfo.SPFXP=_DBC_SP_CheckFXP_OK, "OK",;
                              IIF(m.loInfo.SPFXP=_DBC_SP_CheckFXP_Failed, "Failed",;
                              IIF(m.loInfo.SPFXP=_DBC_SP_CheckFXP_CantSavePRG, "Can't Save PRG",;
                              IIF(m.loInfo.SPFXP=_DBC_SP_CheckFXP_CantCompilePRG, "Can't Compile PRG",;
                              IIF(m.loInfo.SPFXP=_DBC_SP_CheckFXP_CantReadFXP, "Can't Read FXP", "Can't read ERR file.")))))+_DBC_CRLF+;
                "FXP Result: "+m.loInfo.SPFXPResult
      This.WriteToLog(m.lcData)
      This.WriteToLog("")

   ENDPROC

   PROCEDURE WriteToLog(lcData) && Write to log file
      DEBUGOUT m.lcData
      =IIF(This.hLogFile>0, FPUTS(This.hLogFile, m.lcData), .T.)
   ENDPROC

ENDDEFINE

*********************************************************************************
*
*********************************************************************************
DEFINE CLASS _DBC_CheckInfo AS custom && Class about checking DBC
   Name="_DBC_CheckInfo"

   iLostObjects=0 && Count of Lost objects
   DIME aLostObjects(1) && List of Lost objects

   iObsoleteObjects=0 && Count of obsolete objects
   DIME aObsoleteObjects(1) && List of obsolete objects

   iInvalidProperties=0 && Count of objects which have invalid properties
   DIME aInvalidProperties(1) && List of objects which have invalid properties

   SPFXP = _DBC_SP_CheckFXP_OK && Stored procedures FXP status
   SPFXPEx = _DBC_SP_CheckFXP_OK && Extended Stored procedures status
   SPFXPResult = "" && Stored procedures Error result
ENDDEFINE

*********************************************************************************
*
*********************************************************************************
DEFINE CLASS _DBC_CheckInfo_InvalidProperties AS custom && Class about checking DBC - invalid properties
   Name="_DBC_CheckInfo_InvalidProperties"

   ObjectID=0 && Object ID
   iInvalidProperties=0 && Count of objects which have invalid properties
   DIME aInvalidProperties(1) && List of objects which have invalid properties

ENDDEFINE

*********************************************************************************
*
*********************************************************************************
DEFINE CLASS _DBC_Connector AS custom && DBC connector for user custom properties
   Name="_DBC_Connector"

   PROCEDURE FormatProperty(liIDProp) && Convert property ID to Name
      * liIDProp   - Property ID

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>

      RETURN "" && default return value
   ENDPROC


   PROCEDURE GetDefaultValue(liIDProp) && Get default Value
      * liIDProp   - Property ID

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>

      RETURN .NULL. && default return value
   ENDPROC


   PROCEDURE GetValueType(liIDProp) && Return the property type
      * liIDProp - Property ID

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>

      RETURN _DBC_ValueType_Unknown && default return value
   ENDPROC


   PROCEDURE DBCValueToValue(liType,lcValue) && Convert DBC value to Value
      * liType  - Property type
      * luValue - Property value

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>

      RETURN lcValue
   ENDPROC


   PROCEDURE ValueToDBCValue(liType,luValue) && Convert value to DBC value
      * liType  - Property type
      * luValue - Property value

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>

      RETURN .NULL.
   ENDPROC


   PROCEDURE CheckValue() && Check Value
      LPARAMETERS liIDProp,liType,luValue
      * liIDProp   - Property ID
      * liType     - Value type
      * luValue    - Value

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>

      * 1) check type
      * 2) check interval
      * 4) return .T. is value valid or .F. is invalid
   
      RETURN .T.
   ENDPROC


   PROCEDURE CheckProperties() && Check property value (DBC value)
      LPARAMETERS liIDProp,liType,lcValue
      * liIDProp   - Property ID
      * liType     - Value type
      * lcValue    - DBC value

      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>

      RETURN .T.
   ENDPROC

ENDDEFINE
