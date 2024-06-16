#DEFINE _SourceType_1 "1 - Local SQL View"
#DEFINE _SourceType_2 "2 - Remote SQL View"
#DEFINE _SourceType_3 "3 - Table"
#DEFINE _SourceType_4 "4 - ADO"



#DEFINE _SourceType_101 "101 - Local SQL View CA - CursorFill()"
#DEFINE _SourceType_201 "201 - Local SQL View CA - CursorAttach()"

#DEFINE _SourceType_102 "102 - Remote SQL View CA - CursorFill()"
#DEFINE _SourceType_202 "202 - Remote SQL View CA - CursorAttach()"

#DEFINE _SourceType_103 "103 - Table CA - CursorFill()"
#DEFINE _SourceType_203 "203 - Table CA - CursorAttach()"

#DEFINE _SourceType_104 "104 - ADO CA - CursorFill()"
#DEFINE _SourceType_204 "204 - ADO CA - CursorAttach()"


#DEFINE _CA_Properties ",SelectCmd,"+;
        "AllowDelete,AllowInsert,AllowUpdate,BreakOnError,BufferModeOverride,ConversionFunc,"+;
        "CursorSchema,CursorStatus,DataSource,DataSourceType,DeleteCmd,DeleteCmdDataSource,"+;
        "DeleteCmdDataSourceType,Flags,InsertCmd,InsertCmdDataSource,InsertCmdDataSourceType,"+;
        "UpdateCmd,UpdateCmdDataSource,UpdateCmdDataSourceType,UpdateGram,"+;
        "UpdateGramSchemaLocation,UseDeDataSource,"
