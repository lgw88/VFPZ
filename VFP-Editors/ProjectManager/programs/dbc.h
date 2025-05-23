*!*	<pdm_sc_yes/>
*!*	<pdm_dd_yes/>

* Type of objects
#DEFINE _DBC_DataBase    PADR("Database",10)
#DEFINE _DBC_Table       PADR("Table",10)
#DEFINE _DBC_Field       PADR("Field",10)
#DEFINE _DBC_Index       PADR("Index",10)
#DEFINE _DBC_Relation    PADR("Relation",10)
#DEFINE _DBC_Connection  PADR("Connection",10)
#DEFINE _DBC_View        PADR("View",10)


* Properties ID
#DEFINE _DBCID_Path                 1
#DEFINE _DBCID_SubType              2
#DEFINE _DBCID_Comment              7
#DEFINE _DBCID_RuleExpression       9
#DEFINE _DBCID_RuleText            10
#DEFINE _DBCID_DefaultValue        11
#DEFINE _DBCID_ParameterList       12
#DEFINE _DBCID_ChildTag            13
#DEFINE _DBCID_InsertTrigger       14
#DEFINE _DBCID_UpdateTrigger       15
#DEFINE _DBCID_DeleteTrigger       16
#DEFINE _DBCID_Prim_Cand           17
#DEFINE _DBCID_ParentTable         18
#DEFINE _DBCID_ParentTag           19
#DEFINE _DBCID_PrimaryKey          20
#DEFINE _DBCID_Version             24
#DEFINE _DBCID_BatchUpdateCount    28
#DEFINE _DBCID_DataSource          29
#DEFINE _DBCID_ConnectName         32
#DEFINE _DBCID_UpdateName          35
#DEFINE _DBCID_FetchMemo           36
#DEFINE _DBCID_FetchSize           37
#DEFINE _DBCID_KeyField            38
#DEFINE _DBCID_MaxRecords          39
#DEFINE _DBCID_ShareConnection     40
#DEFINE _DBCID_SourceType          41
#DEFINE _DBCID_SQL                 42
#DEFINE _DBCID_Tables              43
#DEFINE _DBCID_SendUpdates         44
#DEFINE _DBCID_Updatable           45
#DEFINE _DBCID_UpdateType          46
#DEFINE _DBCID_UseMemoSize         47
#DEFINE _DBCID_WhereType           48
#DEFINE _DBCID_DisplayClass        50
#DEFINE _DBCID_DisplayClassLibrary 51
#DEFINE _DBCID_Format              55
#DEFINE _DBCID_InputMask           54
#DEFINE _DBCID_Caption             56
#DEFINE _DBCID_Asynchronous        64
#DEFINE _DBCID_BatchMode           65
#DEFINE _DBCID_ConnectString       66
#DEFINE _DBCID_ConnectTimeout      67
#DEFINE _DBCID_DispLogin           68
#DEFINE _DBCID_DispWarnings        69
#DEFINE _DBCID_IdleTimeout         70
#DEFINE _DBCID_QueryTimeout        71
#DEFINE _DBCID_Password            72
#DEFINE _DBCID_Transactions        73
#DEFINE _DBCID_UserID              74
#DEFINE _DBCID_WaitTime            75
#DEFINE _DBCID_TimeStamp           76
#DEFINE _DBCID_DataType            77
#DEFINE _DBCID_PacketSize          78
#DEFINE _DBCID_Database            79
#DEFINE _DBCID_Prepared            80
#DEFINE _DBCID_CompareMemo         81
#DEFINE _DBCID_FetchAsNeeded       82
#DEFINE _DBCID_Offline             83
*                                   84
*                                   85
#DEFINE _DBCID_DBCEvents               86
#DEFINE _DBCID_DBCEventFileName        87
#DEFINE _DBCID_AllowSimultaneousFetch  88
#DEFINE _DBCID_DisconnectRollback      89

                                   
* Table types
#DEFINE _DBF_FoxBASE     0x02 && FoxBASE
#DEFINE _DBF_FB_dBIII_NM 0x03 && FoxBASE+/dBASE III PLUS, no memo
#DEFINE _DBF_VFP         0x30 && Visual FoxPro
#DEFINE _DBF_dBIVSQLT_NM 0x43 && dBASE IV SQL table files, no memo
#DEFINE _DBF_dbIVSQLS_NM 0x63 && dBASE IV SQL system files, no memo
#DEFINE _DBF_FB_dBIII_M  0x83 && FoxBASE+/dBASE III PLUS, with memo
#DEFINE _DBF_dBIV_M      0x8B && dBASE IV with memo
#DEFINE _DBF_dBIVSQLT_M  0xCB && dBASE IV SQL table files, with memo
#DEFINE _DBF_FP2X        0xF5 && FoxPro 2.x (or earlier) with memo
#DEFINE _DBF_FoxBASE0    0xFB && FoxBASE


* Stored procedures type
#DEFINE _DBC_SP_Source   PADR("StoredProceduresSource",128)
#DEFINE _DBC_SP_FXP      PADR("StoredProceduresObject",128)
#DEFINE _DBC_SP_TSource  0
#DEFINE _DBC_SP_TFXP     1


* Errors
#DEFINE _DBC_ObjectNotType  -2
#DEFINE _DBC_ObjectNotFound -1
#DEFINE _DBC_ObjectFound     0

#DEFINE _DBC_ErrParamFailed         -103 && Wrong any parameter
#DEFINE _DBC_ErrNotOpenLowLevelFile -102 && I can not open file
#DEFINE _DBC_ErrOther               -100 && Any bug
#DEFINE _DBC_ErrOK                   0   && OK
