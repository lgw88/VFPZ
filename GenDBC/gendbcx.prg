** For best results, view this file with: Courier New / Regular / 10
** TabWidth set to: 4
*******************************************************************************
** Program Name  : GenDBCX.PRG (nee GENDBC.PRG)
** Version       : 1.13
** Creation Dates: 94.12.01 (GENDBC.PRG)  2022.06.12 (GenDBCX.PRG)
**
** Purpose:
**   To take an existing FoxPro 3.0/5.0 database and generate an output
**	  program that can be used to "re-create" that database.
**
** Parameters:
**   tcOutFile   - The name of the output file.  This can contain path 
**                 information and an extension.
**                 If no extension is supplied, one will be provided.
**
**   tcClassName - The name of the class to create.  If not supplied,
**                 the default 'GenDBCX' will be used.
**
**   tlSeparateSPObjCode
**               - A flag that tells the program whether to append the
**                 Stored Procedures object code to the .krt file that
**                 holds the SP source code (the default), or write it
**                 to a separate .kro file.
**
** Modification History:
**            (KRT = Somebody at MS; SEA = Steve Arnott, SEA Drive;
**             SAS = Steve Sawyer; DH Doug Hennig; SF Lutz Scheffler)
**
** GENDBC:
** 1994.12.01 KRT  Created program, runs on Build 329 of VFP
** 1994.12.02 KRT  Added GetView function and cleaned up all code
** 1994.12.05 KRT  Modified some areas and verified run on Build 335
** 1994.12.06 KRT  Added things for international conversion
** 1994.12.08 KRT  Added function ADBOBJECTS() to code
** 1994.12.12 KRT  Added commands COPY PROCEDURES TO
** 1995.01.04 KRT  Added connection properties
** 1995.01.05 KRT  Added support for long filenames - thierryp
** 1995.01.05 KRT  Added support for RI
** 1995.01.06 KRT  Added support for MS-DOS short filenames (NAME clause)
** 1995.01.08 KRT  Added status bar line
** 1995.01.26 KRT  Fixed a few file bugs and localization bug
** 1995.02.19 KRT  Took advantage of AFIELDS() command
** 1995.02.22 KRT  Fixed AUSED() bug
** 1995.03.01 KRT  Removed ON ERROR problem
** 1995.03.20 KRT  Fixed "Exclusive" Error / Procedures created before
**                 Tables
** 1995.03.22 KRT  Allowed user to open database if one is not set current
**                 / Set SAFETY OFF in resulting code to prevent errors
**                   when validating rules/triggers that don't exist
** 1995.04.07 KRT  Put any database procedures into a seperate file to
**                 prevent "Program Too Large" errors
** 1995.04.20 KRT  Only change SAFETY when appending procedures
**
** 3.0b - Changes/Fixes
** 1995.09.15 KRT  Changed ADBOBJECTS() to DBF() in GETTABLE procedure.
**                 This allows for "real" table names instead of alias'
** 1995.09.15 KRT  Take into account CR+LF in comments for fields
** 1995.09.15 KRT  Store Source and Object code into external file
**                 So the code can be executed from the run-time version
** 1995.10.23 KRT  Changed DBF(cTableName ) to DBF(ALIAS() ) because
**                 VFP will automatically add underscores where spaces
**                 should be and I need to know what it did to the alias
**                 [Regress]
** 1995.10.25 KRT  Added OVERWRITE to append memo's [Regress]
** 1995.10.25 KRT  Added support for CR+LF in comments for Table
** 1995.10.25 KRT  Close all tables in generated code before adding
**                 Source and Object code from external file[Regress]
** 1995.10.25 KRT  Added warning about filter indices on Unique and
**                 Candidate keys (Not supported via language )
** 1995.12.20 KRT  Better lookup for adding RI information to database
** 1995.12.20 KRT  Added support for filter expressions on CANDIDATE keys
** 
** 5.0 - Changes/Fixes
** 1996.03.27 KRT  Added "exact match" support for Locate command
** 1996.04.12 KRT  Added new properties for Views, Fields and Connections
** 1996.05.14 KRT  Adjusted for some logical properties return spaces
** 1996.05.16 KRT  Added even more new properties for Views
** 1996.05.16 KRT  Add M. in front of all memory variables to prevent
**                 confusion with table fields and names
** 1996.06.01 KRT  Added support for Collate sequence on index files
** 1996.06.26 KRT  Added support for ParameterList in Views
** 1996.07.19 KRT  Added support for Offline Views
** 1996.08.07 KRT  Added support for comments and default values in views
**
** GenDBCX:
** 1997.02.01 SEA  Changed "Get Relations" code to build output in a
**                 memory variable to avoid creating 100+MB memo files
**                 when working with large databases
** 1997.02.24 SEA  Added code to avoid the dreaded "Program too large"
**                 error message by making (almost) everything in the
**                 database re-creation program a procedure
** 1997.02.24 SEA  Replaced usage of "Program" memo field with writing
**                 directly to a temporary file to prevent "Out of disk
**                 space" error caused by memo file bloat
** 1997.02.25 SEA  Changed format of CREATE TABLE output code to improve 
**                 (I hope) its readability
** 1997.03.23 SEA  Added code to create the DBC regeneration program as a
**                 class, so that you can recreate specific tables, views
**                 and connections by calling the output class' methods.
**                 To recreate the entire database, you either run the 
**                 program, or call the GenerateAll method.
** 1997.03.24 SEA  Added code to create a class Init routine that checks
**                 for the existence of the target database container and,
**                 if it finds it, loads the names of its tables into an
**                 array that the table creation methods search.  If the
**                 table name exists in the dbc, it's deleted and recreated.
** 1997.04.04 SEA  Added code to allow user to pass the name of the method
**                 to call as a parameter, rather than forcing the user to
**                 instantiate a GenDBCX object.
** 1997.05.01 SAS  Added code to recreate the dbc in two steps, with a hook
**                 in the middle that allows the user to append existing data
**                 to the new database, or do anything else that the user might
**                 require upon creation of the new database.
** 1997.07.29 SEA  Fixed some minor formatting errors.
**                 Fixed the RI "error" message line so that the number of the
**                 line in the regeneration program is displayed, rather than
**                 the number of the line in this program.
** 1997.09.05 SEA  Fixed procedure GetView to handle 5.0-specific properties
**                 when running under VFP 3.0.  Thanks to Nancy Folsom for
**                 catching this!
** 1997.09.05 SEA  Added code to handle table, view and connection names that
**                 contain spaces.
** 1997.10.01 SEA  Added parameter tlSeparateSPObjCode to allow the user to
**                 specify that the Stored Procedures object code is to be
**                 output to a separate .kro file, rather than appended to
**                 the .krt file that holds the SP source code.  Apparently,
**                 the inclusion of object code in the .krt prevents the file
**                 from being compared to a previous version in Visual
**                 SourceSafe projects.
** 1997.10.15 SEA  Added code to allow the user to sort the arrays that hold
**                 the table, view, connection and relation names alphabetically,
**                 so that they appear in alphabetical order in the output code.
** 1997.11.01 SEA  Added ability to control the appearance of the output code
**                 through the use of constants that control code indentation
**                 and the separation of field names from their data types
**                 in CREATE TABLE commands.
** 1997.11.01 SEA  Added code in procedure GetTable to handle "Program line too
**                 long" error which occurs when a table has a large number
**                 of fields.  Thanks to Ken Lee for reporting this!
** 1997.11.07 SEA  Added code to place each type of database "object" in a
**                 separate procedure/method, and added a constant to allow
**                 the user to specify that indices be created in a pass
**                 separate from the one that creates the table.
** 1997.12.07  SEA Added code to initialize local variables for each parameter
**                 in a parameterized view.  Note that this only works if you
**                 have added each parameter to the view's parameters list,
**                 either through the View Designer (Query/View Parameters) or
**                 with DBSetProp().  Thanks to Todd Arnold for telling me how
**                 to create the parameters list!
** 1997.12.07  SEA Added code to display a dialog, warning the user that
**                 his/her dbc and/or tables are about to be overwritten, and
**                 requesting confirmation to continue.
** 1997.12.14  SEA Set EXACT ON in generated program so that the ASCAN() in 
**                 RemoveTable() won't find "TABLE10" when it's looking for
**                 "TABLE1".  Thanks to Jeff Clauss and Ken Lee for catching
**                 this!
** 1997.12.29  SEA Added code to break up the RI regeneration code into
**                 multiple procedures when it exceeds 64K.  Thanks to Arnon
**                 Gal-Oz for letting me know that it was time to do this! 
** 1998.07.20  SEA Fixed bug that created a procedure without a name if the
**                 database has no tables.
** 1998.07.20  SEA UPPER()'d and ALLTRIM()'d the dbc's ObjectName field when
**                 searching for relations in procedure GetRI.  Thanks to
**                 Patrick Godfrey for catching this!
** 2022.06.11 SF   Included changes by DH from GenDBC.prg for additional file types
**                 Modified:
**                  PROCEDURE GetTable
**   2004.03.19 DH    Added support for Blob, VarChar, and VarBinary fields
**   2004.05.05 DH    Added support for binary indexe
**                  PROCEDURE GetView
**   2004.04.14 DH    Added support for AllowSimultaneousFetch,
**                    RuleExpression, and RuleText properties
**   2002.06.28 DH   Removed duplicate output of FetchSize property
**   2004.09.22 DH    Handled case where UpdateName has quotes (e.g. with
**                    calculated fields like "Test" AS SOMEFIELD)
**                  PROCEDURE GetConn
**   2004.03.19 DH    Added support for PacketSize
**                    added code to support WaitTime (it was retrieved but not written)
**           /SF
** 2022.06.11 SF   PROCEDURE GetRI
**                 The code to rewrite RIINFO might find the wrong record 
*******************************************************************************
LPARAMETERS tcOutFile, tcClassName, tlSeparateSPObjCode
#IF FILE("custproc.h")
	#INCLUDE custproc.h
#ENDIF

PRIVATE ALL EXCEPT g_*

**************************************************************************
** Constants
**************************************************************************
#DEFINE CRLF CHR(13) + CHR(10)
#DEFINE TAB  CHR(9)

*! SEA: CREATE TABLE command can exceed max command line length when 
*!      table has 180+ fields in 5.0, or 45+ fields in 3.0.  I'll try to
*!      alleviate the problem by allowing you to strip out the default
*!      formatting tabs and spaces.  If that's not enough, procedure
*!      GetTable will truncate the CREATE TABLE command and add as many
*!      ALTER TABLE commands as necessary to add the remaining fields.
#IFNDEF GDX_INDENT
	#DEFINE GDX_INDENT                   TAB
#ENDIF
#IFNDEF GDX_PRCMARGIN
	#DEFINE GDX_PRCMARGIN                GDX_INDENT
#ENDIF
#IFNDEF GDX_CMDMARGIN
	#DEFINE GDX_CMDMARGIN                GDX_PRCMARGIN + GDX_INDENT
#ENDIF
#IFNDEF GDX_FLDNAMEPAD
	#DEFINE GDX_FLDNAMEPAD               20
#ENDIF
#IFNDEF ALERT_USING_ALTER_TABLE
	#DEFINE ALERT_USING_ALTER_TABLE      .T.
#ENDIF
#IFNDEF ALTER_TABLE_NOVALIDATE
	#DEFINE ALTER_TABLE_NOVALIDATE       .F.
#ENDIF	

*! SEA: If you want to separate the index-creation routine from that which
*!      creates the related table, then #DEFINE MAKE_INDEX_PASS .T. in the
*!      CustProc.h header file.
#IFNDEF MAKE_INDEX_PASS
	#DEFINE MAKE_INDEX_PASS              .F.
#ENDIF

*! SEA: If you want to add field-level properties, such as CHECK, ERROR
*!      and DEFAULT separately from the code that creates the table, then
*!      #DEFINE CREATE_TABLE_SET_PROPS .F. in the CustProc.h header file.
#IFNDEF CREATE_TABLE_SET_PROPS
	#DEFINE CREATE_TABLE_SET_PROPS       .T.
#ENDIF

*! SEA: If you want your tables, views, connections and relations to be
*!      created in alphabetical order (rather than the order that they
*!      were created in the database container), then #DEFINE 
*!      GDX_SORT_OUTPUT .T. in the CustProc.h header file.
#IFNDEF GDX_SORT_OUTPUT
	#DEFINE GDX_SORT_OUTPUT              .F.
#ENDIF

**************************************************************************
** Error Messages
**************************************************************************
#DEFINE NO_DATABASE_IN_USE_LOC   "No Database is in use. " + ;
                                 "This program must have a database " + ;
                                 "available."
#DEFINE INVALID_PARAMETERS_LOC   "Invalid Parameters..." + CRLF + ;
                                 "An output file must be specified." + CRLF +;
                                 'ie: DO GENDBCX WITH "filename.prg"'
#DEFINE INVALID_DESTINATION_LOC  "Invalid Destination File "
#DEFINE NO_TEMP_FILE_LOC         "Could not create temporary file: "
#DEFINE NO_OUTPUT_WRITTEN_LOC    "Could not create or write to output file"
#DEFINE ERROR_TITLE_LOC          "Aborting GenDBCX..."
#DEFINE UNRECOVERABLE_LOC        "Unrecoverable Error: "
#DEFINE AT_LINE_LOC              " At Line: "
#DEFINE NO_FIND_LOC              "Could not set RI Information"
#DEFINE NO_FILE_FOUND_LOC        "Warning! No Procedure File Found!"
#DEFINE GETFILE_GEN_LOC          "Generate..."
#DEFINE NOT_SUPPORTED_LOC        "Filters on PRIMARY keys are not supported at this time. " + ;
                                 "A comment will be added to your output file specifying the filters."
#DEFINE NS_COMMENT_LOC           "****** These filters need to be added manually ******"
#DEFINE WARNING_TITLE_LOC        "GenDBCX Warning..." 
#DEFINE USING_ALTER_TABLE_LOC    "CREATE TABLE command line length exceeded," + CRLF + ;
                                 "using ALTER TABLE to add remaining fields for table. " + CRLF + ;
                                 "This is an information "
#DEFINE WARNING_OVERWRITING_LOC  "Warning!  This program will overwrite your existing database and tables!  Continue?"
#DEFINE PROGRAM_CANCELLED_LOC    "Program cancelled"

**************************************************************************
** Comments And Other Information
**************************************************************************
#DEFINE BEGIN_RELATION_LOC       "Relations Setup"
#DEFINE BEGIN_TABLE_LOC          "Table setup for "
#DEFINE BEGIN_INDEX_LOC          "Create each index for "
#DEFINE BEGIN_PROP_LOC           "Change properties for "
#DEFINE BEGIN_VIEW_LOC           "View setup for "
#DEFINE BEGIN_PROC_LOC           "Procedure Re-Creation"
#DEFINE BEGIN_CONNECTIONS_LOC    "Connection Definition"
#DEFINE BEGIN_RI_LOC             "Referential Integrity Setup"
#DEFINE OPEN_DATABASE_LOC        "Select Database..."
#DEFINE PACK_DATABASE_LOC        "Pack the Database"
#DEFINE SAVE_PRG_NAME_LOC        "Enter output program name..."
#DEFINE NO_MODIFY_LOC            "*** WARNING *** DO NOT MODIFY THIS FILE IN ANY WAY! *** WARNING ***"
#DEFINE TABLE_NAME_LOC           "*        Table Name: "
#DEFINE PRIMARY_KEY_LOC          "*       Primary Key: "
#DEFINE FILTER_EXP_LOC           "* Filter Expression: "
#DEFINE HEADING_LINE             "* *********************************************************************"
#DEFINE HEADING_1_LOC            HEADING_LINE + CRLF + ;
                                 "* *" + CRLF
#DEFINE HEADING_2_LOC            "* *" + CRLF + ;
                                 HEADING_LINE + CRLF + ;
                                 "* *" + CRLF + ;
                                 "* * Description:" + CRLF + ;
                                 "* * This program was automatically generated by GenDBCX Version 1.13," + CRLF + ;
                                 "* * a modified version of Microsoft's utility GenDBC Version 2.26.67." + CRLF + ;
                                 "* * with changes Made to this version on VFP9" + CRLF + ;
                                 "* *" + CRLF + ;
                                 HEADING_LINE + CRLF

#DEFINE CREATE_DBC_LOC           "*-- Create the Database Container"
#DEFINE CREATE_TABLES_LOC        "*-- Create Tables"
#DEFINE CREATE_INDICES_LOC       "*-- Create Indices"
#DEFINE CREATE_VIEWS_LOC         "*-- Create Views"
#DEFINE CREATE_CONNECTIONS_LOC   "*-- Create Connections"
#DEFINE CALL_CUSTOM_LOC          "*-- Call custom method"
#DEFINE FINISH_TABLES_LOC        "*-- Finish Tables (add rules/triggers/properties)"

**************************************************************************
** Public Variables
**************************************************************************
IF SET("TALK") = "ON"                     && To restore SET TALK after use
	SET TALK OFF                           && -- Have to do it this way so
	g_cSetTalk = "ON"                      && -- nothing gets on screen
ELSE
	g_cSetTalk = "OFF"
ENDIF
g_cFullPath = SET("FULLPATH")             && To restore old FULLPATH setting
g_cOnError = ON("ERROR")                  && To restore old ON ERROR condition
g_cSetDeleted = SET("DELETED")            && To restore SET DELETED later
g_cSetStatusBar = SET("STATUS BAR")       && To restore STATUS bar
g_cStatusText = SYS(2001, "MESSAGE", 1)   && To restore text that may be on it
g_nMax = 7                                && For status line information
g_nCurrentStat = 1                        && For status line information
g_cFilterExp = ""                         && For Non-Supported Filter Info
g_cSetSafety = SET("SAFETY")              && To restore SAFETY setting
g_cSetExact  = SET("EXACT")               && To restore EXACT setting
**************************************************************************

*! Our generic error handling routine
ON ERROR DO GenDBC_Error WITH MESSAGE(), LINENO()

DEACTIVATE WINDOW "Project Manager"

*! Begin program body
SET DELETED ON
SET FULLPATH ON
IF m.g_cSetStatusBar = "OFF"
	SET STATUS BAR ON
ENDIF
SET SAFETY OFF
SET EXACT ON

*! Hook for a custom process to run after the DBC and table structures are created
lcHookStr = CALL_CUSTOM_LOC + CRLF + GDX_CMDMARGIN + "=this.CustomProcess()"

*! Make sure a database is open
IF EMPTY(DBC())
	g_cFullDatabase = GETFILE("DBC", OPEN_DATABASE_LOC, GETFILE_GEN_LOC, 0)
	IF EMPTY(m.g_cFullDatabase)
		=FatalAlert(NO_DATABASE_IN_USE_LOC, .F.)
	ENDIF
	OPEN DATABASE (m.g_cFullDatabase)
ENDIF

*! Set global variable to the database name and format it
g_cDatabase = FULLPATH(DBC())
IF RAT("\", m.g_cDatabase) > 0
	m.g_cDatabase = SUBSTR(m.g_cDatabase, RAT("\", m.g_cDatabase) + 1)
ENDIF

*! Get the fullpath of database
g_cFullDatabase = DBC()

*! Check for valid parameters
IF TYPE('m.tcOutFile') != "C" or EMPTY(m.tcOutFile)
	tcOutFile = ""
	tcOutFile = PUTFILE(SAVE_PRG_NAME_LOC, SUBSTR(m.g_cDatabase, 1, RAT(".", m.g_cDatabase)) + "PRG", "PRG")
	IF EMPTY(m.tcOutFile)
		=FatalAlert(INVALID_PARAMETERS_LOC, .F.)
	ENDIF
ENDIF

*! Check for proper extensions or add one if none specified
IF RAT(".PRG", m.tcOutFile) = 0 AND RAT(".", m.tcOutFile) = 0
	tcOutFile = m.tcOutFile + ".PRG"
ENDIF

*! Make sure the output file is valid
hFile = FCREATE(m.tcOutFile)
IF m.hFile <= 0
	=FatalAlert(INVALID_DESTINATION_LOC + m.tcOutFile, .F.)
ENDIF
=FCLOSE(m.hFile)
ERASE (m.tcOutFile)

*! Remember all our tables that are open for this database
g_nTotal_Tables_Used = AUSED(g_aAlias_Used)
IF m.g_nTotal_Tables_Used > 0
	DIMENSION g_aTables_Used[m.g_nTotal_Tables_Used]

	*! Get real names of tables opened
	FOR nLoop = 1 TO m.g_nTotal_Tables_Used
		g_aTables_Used[m.nLoop] = DBF(g_aAlias_Used[m.nLoop, 1])
	ENDFOR
ENDIF

*! Get number of tables contained in database
nTotal_Tables = ADBOBJECTS(aAll_Tables, "Table")
g_nMax = m.g_nMax + m.nTotal_Tables
=Stat_Message()

*! Get number of views contained in database
nTotal_Views = ADBOBJECTS(aAll_Views, "View")
g_nMax = m.g_nMax + m.nTotal_Views
=Stat_Message()

*! Get number of connections contained in database
nTotal_Connections = ADBOBJECTS(aAll_Connections, "Connection")
g_nMax = m.g_nMax + m.nTotal_Connections
=Stat_Message()

*! Get number of relations contained in database
nTotal_Relations = ADBOBJECTS(aAll_Relations, "Relation")
*! SEA: We process relations so fast now, it's better not to include them
*! in the "status" line, as they distort the progress indicator
* m.g_nMax = m.g_nMax + m.nTotal_Relations
=Stat_Message()

CLOSE DATABASES ALL

**************************
*** Get Stored Procedures
**************************
*! Create an output file that will be appended to the database
*! as procedures
cFile = UPPER(SUBSTR(m.tcOutFile, 1, AT(".", m.tcOutFile))) + "krt"
cDPTemp = "GenDBC.$$$"
cSPTemp = "GenDBC.k$$"
IF tlSeparateSPObjCode
	cSPObjTemp = "GenDBC.o$$"
	cSPObjFile = UPPER(SUBSTR(m.tcOutFile, 1, AT(".", m.tcOutFile))) + "kro"
ENDIF

*! Place Header Information For Source/Object
hFile = FCREATE(m.cSPTemp)
IF m.hFile <= 0
	=FCLOSE(m.hFile)
	=FatalAlert(NO_OUTPUT_WRITTEN_LOC, .T.)
ENDIF

=FPUTS(m.hFile, NO_MODIFY_LOC)
=FCLOSE(m.hFile)

*! Now we are going to copy the object and source code
*! for the stored procedures
OPEN DATABASE (m.g_cFullDatabase) EXCLUSIVE
COMPILE DATABASE (m.g_cFullDatabase)
CLOSE DATABASES ALL
USE (m.g_cFullDatabase) SHARED
LOCATE FOR Objectname = 'StoredProceduresSource'
IF FOUND()
	COPY MEMO Code TO (m.cSPTemp) ADDITIVE
ENDIF
=ADIR(aTemp, m.cSPTemp)
nSourceSize = m.aTemp[1,2] - LEN(NO_MODIFY_LOC)

LOCATE FOR Objectname = 'StoredProceduresObject'
IF FOUND()
	IF tlSeparateSPObjCode
		COPY MEMO Code TO (m.cSPObjTemp)
	ELSE
		COPY MEMO Code TO (m.cSPTemp) ADDITIVE
	ENDIF
ENDIF
USE

*! Open the database again
OPEN DATABASE (m.g_cFullDatabase) EXCLUSIVE

hOutFile = FCREATE(cDPTemp)
IF m.hOutFile <= 0
	=FCLOSE(m.hFile)
	=FatalAlert(NO_OUTPUT_WRITTEN_LOC, .T.)
ENDIF

*******************************************************************************
** Create a class that holds all of the database regeneration code as
** public methods that can be called by anyone who can create a reference
** to the class.
**
** The body of the program now consists of two lines: 1) the creation of
** the GenDBCX class object, and 2) a call to a "summary" method that 
** calls all of the methods that create the database, tables, views and 
** connections, and set relations and referential integrity.
**
** Using this approach, you can now DO the program to recreate the entire
** database, or you can create an object reference to the GenDBCX class,
** and recreate tables, views and connections by appending the table/view
** name to its related prefix ("tb" for tables, "vw" for views, "cn" for
** connections), relations by calling the SetRelations method, and RI by
** calling the SetRI method.
** 
** Additionally, if you want to execute the code of a method without
** creating a GenDBCX object, you can call the program with the name of
** a single method to execute.
*******************************************************************************
*! Write the program heading
=WriteFile(m.hOutFile, ;
	HEADING_1_LOC + "* * " + DTOC(DATE()) +;
	SPACE(25 - LEN(m.g_cDatabase) / 2) + ;
	m.g_cDatabase + SPACE(25 - LEN(m.g_cDatabase) / 2) +;
	TIME() + CRLF + HEADING_2_LOC + CRLF + ;
	IIF(!EMPTY(m.g_cFilterExp), NS_COMMENT_LOC +  m.g_cFilterExp + ;
	CRLF + REPLICATE("*", 52) + CRLF, ""))

*! Write the body of the program
lcObjectName = "oDBC"
lcClassName = IIF(TYPE("m.tcClassName")="C" AND !EMPTY(m.tcClassName),tcClassName,"GenDBCX")
lcGenAllProc = "GenerateAll"
=WriteFile(m.hOutFile, ;
	"LPARAMETERS tcMethod" + CRLF + ;
	"LOCAL " + lcObjectName + CRLF + ;
	lcObjectName + " = CreateObject('" + m.lcClassName + "')" + CRLF + ;
	               "IF TYPE('" + lcObjectName + "') != 'O'" + CRLF + ;
	GDX_INDENT +   	"RETURN" + CRLF + ;
	               "ENDIF" + CRLF + ;
	               "cExactSet = SET('EXACT')" + CRLF + ;
	               "SET EXACT ON" + CRLF + ;
	               "IF EMPTY(tcMethod)" + CRLF + ;
	GDX_INDENT +   	"=" + lcObjectName + "." + m.lcGenAllProc + "()" + CRLF + ;
	               "ELSE" + CRLF + ;
	GDX_INDENT +   	"=EVALUATE('" + lcObjectName + ".' + tcMethod)" + CRLF + ;
	               "ENDIF" + CRLF + ;
	               "IF cExactSet = 'OFF'" + CRLF + ;
	GDX_INDENT +   	"SET EXACT OFF" + CRLF + ;
	               "ENDIF" + CRLF + CRLF ;
)

*! Begin defining the class
=WriteFile(m.hOutFile, ;
	"DEFINE CLASS " + m.lcClassName + " AS Custom" + CRLF + ;
	GDX_PRCMARGIN + "PROTECTED aTables[1]" + CRLF + ;
	GDX_PRCMARGIN + "PROTECTED nTables" + CRLF ;
)

*! Write the CustomProcess method
#IFDEF CUSTOM_METHOD_LOC
	=WriteFile(m.hOutFile, ;
		GDX_PRCMARGIN + "PROCEDURE CustomProcess" + CRLF + ;
		GDX_CMDMARGIN +    CUSTOM_METHOD_LOC + ;
		GDX_PRCMARGIN + "ENDPROC" + CRLF ;
	)
#ELSE
	=WriteFile(m.hOutFile, ;
		GDX_PRCMARGIN + "PROCEDURE CustomProcess" + CRLF + ;
		GDX_CMDMARGIN +    "*-- Your code goes here" + CRLF + ;
		GDX_PRCMARGIN + "ENDPROC" + CRLF ;
	)
#ENDIF

*! Write the Init method, storing the names of any tables in an existing dbc
*! into the class' "table names" array
=WriteFile(m.hOutFile, ;
	GDX_PRCMARGIN +              "PROCEDURE Init" + CRLF + ;
	GDX_CMDMARGIN +                 "IF FILE('" + m.g_cDatabase + "')" + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +       "OPEN DATABASE " + m.g_cDatabase + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +       "this.nTables = ADBOBJECTS(this.aTables, 'Table')" + CRLF + ;
	GDX_CMDMARGIN +                 "ENDIF" + CRLF + ;
	GDX_CMDMARGIN +                 "LOCAL ARRAY xx[1]" + CRLF + ;
	GDX_CMDMARGIN +                 "IF ADIR(xx,'*.DBC') > 0 OR ADIR(xx,'*.DBF') > 0" + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +       "IF MessageBox('" + WARNING_OVERWRITING_LOC + "', " + ;
	                                       LTRIM(STR(48+4+256)) + ;
	                                       ", '" + WARNING_TITLE_LOC + "') != 6" + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT + GDX_INDENT + "RETURN .F." + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +       "ENDIF" + CRLF + ;
	GDX_CMDMARGIN +                 "ENDIF" + CRLF + ;
	GDX_PRCMARGIN +              "ENDPROC" + CRLF ;
)

*! Create the call to the DBC recreation method, to be inserted into the
*! "summary" method below
lcCreateDBCProc = "CreateDBC"
lcCDStr = "=this." + m.lcCreateDBCProc + "()"

*! Begin the database container recreation method
=WriteFile(m.hOutFile, ;
	GDX_PRCMARGIN + "PROCEDURE " + m.lcCreateDBCProc + CRLF + ;
	GDX_CMDMARGIN +    CREATE_DBC_LOC + CRLF + ;
	GDX_CMDMARGIN +    "CLOSE DATA ALL" + CRLF + ;
	GDX_CMDMARGIN +    "CREATE DATABASE '" + m.g_cDatabase + "'" ;
)

*! If the database contained any stored procedures (i.e. we wrote something
*! other than the NO_MODIFY_LOC constant to the .k$$ file), then output
*! the code required to recreate the procedure file.
=ADIR(aTemp, m.cSPTemp)
IF m.aTemp[1, 2] > LEN(NO_MODIFY_LOC) + LEN(CRLF)
	=WriteFile(m.hOutFile, "")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    +                           "********* " + BEGIN_PROC_LOC + " *********")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    +                           "IF !FILE([" + SUBSTR(m.cFile, RAT("\", m.cFile) + 1) + "])")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT +                 "? [" + NO_FILE_FOUND_LOC + "]")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    +                           "ELSE")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT +                 "CLOSE DATABASE")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT +                 "USE '" +  m.g_cDatabase + "'")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT +                 "g_SetSafety = SET('SAFETY')")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT +                 "SET SAFETY OFF")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT +                 "LOCATE FOR Objectname = 'StoredProceduresSource'")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT +                 "IF FOUND()")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT + GDX_INDENT +        "APPEND MEMO Code FROM [" + SUBSTR(m.cFile, RAT("\", m.cFile) + 1) + "] OVERWRITE")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT + GDX_INDENT +        "REPLACE Code WITH SUBSTR(Code, " + ALLTRIM(STR(LEN(NO_MODIFY_LOC) + 3)) + ", " + ALLTRIM(STR(m.nSourceSize - 2)) + ")")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT +                 "ENDIF")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT +                 "LOCATE FOR Objectname = 'StoredProceduresObject'")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT +                 "IF FOUND()")
	IF tlSeparateSPObjCode
		=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + GDX_INDENT +        "APPEND MEMO Code FROM [" + SUBSTR(m.cSPObjFile, RAT("\", m.cSPObjFile) + 1) + "] OVERWRITE")
	ELSE
		=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + GDX_INDENT +        "APPEND MEMO Code FROM [" + SUBSTR(m.cFile, RAT("\", m.cFile) + 1) + "] OVERWRITE")
		=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + GDX_INDENT +        "REPLACE Code WITH SUBSTR(Code, " + ALLTRIM(STR(LEN(NO_MODIFY_LOC) + m.nSourceSize + 1)) + ")")
	ENDIF
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT +                 "ENDIF")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT +                 "IF UPPER(g_SetSafety) = 'ON'")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT + GDX_INDENT +        "SET SAFETY ON")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT +                 "ENDIF")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT +                 "USE")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    + GDX_INDENT +                 "OPEN DATABASE [" + m.g_cDatabase + "]")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN    +                           "ENDIF")
	=WriteFile(m.hOutFile, "")
ELSE
	ERASE (m.cSPTemp)
ENDIF

*! Close the database container recreation method
=WriteFile(m.hOutFile, GDX_PRCMARGIN + "ENDPROC" + CRLF)

=Stat_Message()

**************************
*** Get Tables
**************************

lcCTProc     = ""
lcCRTPProc   = ""
lcCIDXProc   = ""
lcCrtTables  = ""
lcCrtIndices = ""
lcCrtRTPs    = ""
lcCTStr      = ""
lcCRTPStr    = ""
lcCIDXStr    = ""

lcProcPrefix = "tb"
IF m.nTotal_Tables > 0
	lcCTProc     = "CreateTables"
	lcCIDXProc   = "CreateIndices"
	lcCRTPProc   = "RulesTriggersProperties"
	lcCrtTables  = "=this." + lcCTProc + "()"
	lcCrtIndices = "=this." + lcCIDXProc + "()"
	lcCrtRTPs    = "=this." + lcCRTPProc + "()"
	lcCTStr      = GDX_CMDMARGIN + CREATE_TABLES_LOC
	lcCIDXStr    = GDX_CMDMARGIN + CREATE_INDICES_LOC
	lcCRTPStr    = GDX_CMDMARGIN + FINISH_TABLES_LOC
	#IF GDX_SORT_OUTPUT
		=ASORT(aAll_Tables,1)
	#ENDIF
	FOR m.nLoop = 1 TO m.nTotal_Tables
		lcProcName = m.lcProcPrefix + ALLTRIM(CHRTRAN(aAll_Tables[m.nLoop]," ","_"))
		DO GetTable WITH ALLTRIM(aAll_Tables(m.nLoop)), m.hOutFile, m.lcProcName
		lcCTStr   = lcCTStr   + CRLF + GDX_CMDMARGIN + "=this." + m.lcProcName + "(1)"
		lcCRTPStr = lcCRTPStr + CRLF + GDX_CMDMARGIN + "=this." + m.lcProcName + "(2)"
		lcCIDXStr = lcCIDXStr + CRLF + GDX_CMDMARGIN + "=this." + m.lcProcName + "(3)"
		=Stat_Message()
	ENDFOR
ENDIF

**************************
*** Get Connections
**************************
lcCCProc   = ""
lcCrtConns = ""
lcCCStr    = ""

lcProcPrefix = "cn"
IF m.nTotal_Connections > 0
	lcCCProc = "CreateConnections"
	lcCrtConns = "=this." + lcCCProc + "()"
	lcCCStr = GDX_CMDMARGIN + CREATE_CONNECTIONS_LOC
	#IF GDX_SORT_OUTPUT
		=ASORT(aAll_Connections,1)
	#ENDIF
	FOR m.nLoop = 1 TO m.nTotal_Connections
		lcProcName = m.lcProcPrefix + ALLTRIM(CHRTRAN(aAll_Connections[m.nLoop]," ","_"))
		DO GetConn WITH ALLTRIM(aAll_Connections[m.nLoop]), m.hOutFile, m.lcProcName
		lcCCStr = lcCCStr + CRLF + GDX_CMDMARGIN + "=this." + m.lcProcName + "()"
		=Stat_Message()
	ENDFOR
ENDIF

**************************
*** Get Views
**************************
lcCVProc   = ""
lcCrtViews = ""
lcCVStr    = ""

lcProcPrefix = "vw"
IF m.nTotal_Views > 0
	lcCVProc = "CreateViews"
	lcCrtViews = "=this." + m.lcCVProc + "()"
	lcCVStr = GDX_CMDMARGIN + CREATE_VIEWS_LOC
	#IF GDX_SORT_OUTPUT
		=ASORT(aAll_Views,1)
	#ENDIF
	FOR m.nLoop = 1 TO m.nTotal_Views
		lcProcName = m.lcProcPrefix + ALLTRIM(CHRTRAN(aAll_Views[m.nLoop]," ","_"))
		DO GetView WITH ALLTRIM(aAll_Views[m.nLoop]), m.hOutFile, m.lcProcName
		lcCVStr = lcCVStr + CRLF + GDX_CMDMARGIN + "=this." + m.lcProcName + "()"
		=Stat_Message()
	ENDFOR
ENDIF

**************************
*** Get Relations
**************************
lcSetRelStr = ""
lcProcName = "SetRelations"
IF m.nTotal_Relations > 0
	lcSetRelStr = "=this." + m.lcProcName + "()"
	LOCAL lcRelString
	lcRelString = CRLF + GDX_PRCMARGIN + "***** " + BEGIN_RELATION_LOC + " *****" + ;
	              CRLF + GDX_PRCMARGIN + "PROCEDURE " + m.lcProcName + CRLF
	#IF GDX_SORT_OUTPUT
		=ASORT(aAll_Relations,1)
	#ENDIF
	FOR m.nLoop = 1 TO m.nTotal_Relations
		lcRelString = lcRelString + GDX_CMDMARGIN + "ALTER TABLE '" + aAll_Relations[m.nLoop,1] +;
							 "' ADD FOREIGN KEY TAG " + aAll_Relations[m.nLoop,3] + ;
							 " REFERENCES " + IIF(" " $ aAll_Relations[m.nLoop,2], ["], []) + ;
							    aAll_Relations[m.nLoop,2] + IIF(" " $ aAll_Relations[m.nLoop,2], ["], []) + ;
							 " TAG " + aAll_Relations[m.nLoop,4] + IIF(ALTER_TABLE_NOVALIDATE, " NOVALIDATE", "") + CRLF
		*! SEA: As mentioned above, we process relations so fast now, it's better 
		*! not to include them in the progress bar, as they distort the indicator
		* =Stat_Message()
	ENDFOR
	lcRelString = m.lcRelString + GDX_PRCMARGIN + "ENDPROC" + CRLF
	=WriteFile(m.hOutFile, m.lcRelString)
ENDIF

CLOSE DATABASE  && Because we're going to start peeking into the
                && table structure of the DBC

**************************
*** Get RI Info
**************************
lcSetRIStr = ""
lcProcName = "SetRI"
IF m.nTotal_Relations > 0
	DO GetRI WITH m.hOutFile, m.lcProcName
	lcSetRIStr = "=this." + m.lcProcName + "()"
ENDIF
=Stat_Message()

******************************************************************************
*! Create the RemoveTable() function, which allows individual methods to
*! recreate a table that is part of the database, but has been accidentally
*! erased.
******************************************************************************
=WriteFile(m.hOutFile, CRLF + ;
	GDX_PRCMARGIN +                           "FUNCTION RemoveTable(tcTable, tcFile)" + CRLF + ;
	GDX_CMDMARGIN +                              "LOCAL ARRAY laTables[1]" + CRLF + ;
	GDX_CMDMARGIN +                              "=ADBOBJECTS(laTables,'Table')" + CRLF + ;
	GDX_CMDMARGIN +                              "IF ASCAN(laTables,tcTable) = 0" + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +                    "*-- No such table in the current dbc, nothing to do!" + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +                    "RETURN .t." + CRLF + ;
	GDX_CMDMARGIN +                              "ENDIF" + CRLF + ;
	GDX_CMDMARGIN +                              "IF !FILE(tcFile)" + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +                    "*-- If the file has been erased, REMOVE TABLE fails with a 'File does not" + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +                    "*-- exist' error, because it can't find the file to either remove its" + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +                    "*-- database reference or delete the file ." + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +                    "*-- We'll work around this problem by creating a phony file with the same" + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +                    "*-- name, and use REMOVE TABLE DELETE to both remove the table reference" + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +                    "*-- in the dbc, and erase the phony file." + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +                    "LOCAL lhFile" + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +                    "lhFile = FCREATE(tcFile)" + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +                    "IF lhFile = -1" + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT + GDX_INDENT +          "RETURN .f." + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +                    "ENDIF" + CRLF + ;
	GDX_CMDMARGIN + GDX_INDENT +                    "=FCLOSE(lhFile)" + CRLF + ;
	GDX_CMDMARGIN +                              "ENDIF" + CRLF + ;
	GDX_CMDMARGIN +                              "REMOVE TABLE (tcTable) DELETE" + CRLF + ;
	GDX_CMDMARGIN +                              "=ADBOBJECTS(laTables,'Table')" + CRLF + ;
	GDX_CMDMARGIN +                              "RETURN ASCAN(laTables,tcTable) = 0" + CRLF + ;
	GDX_PRCMARGIN +                           "ENDFUNC" + CRLF ;
)

******************************************************************************
*! Create the "summary" procedure that calls all the other procedures
*! to create tables, views, etc.
******************************************************************************
=WriteFile(m.hOutFile, "")
=WriteFile(m.hOutFile, GDX_PRCMARGIN + "PROCEDURE " + lcGenAllProc)
=WriteFile(m.hOutFile, GDX_CMDMARGIN +    m.lcCDStr)
IF !EMPTY(m.lcCrtTables)
	=WriteFile(m.hOutFile, GDX_CMDMARGIN + m.lcCrtTables)
ENDIF
=WriteFile(m.hOutFile, "")
=WriteFile(m.hOutFile, GDX_CMDMARGIN +    m.lcHookStr)
=WriteFile(m.hOutFile, "")
IF MAKE_INDEX_PASS and !EMPTY(m.lcCrtIndices)
	=WriteFile(m.hOutFile, GDX_CMDMARGIN + m.lcCrtIndices)
ENDIF
=WriteFile(m.hOutFile, GDX_CMDMARGIN +    m.lcCrtRTPs)
IF !EMPTY(m.lcCrtConns)
	=WriteFile(m.hOutFile, GDX_CMDMARGIN + m.lcCrtConns)
ENDIF
IF !EMPTY(m.lcCrtViews)
	=WriteFile(m.hOutFile, GDX_CMDMARGIN + m.lcCrtViews)
ENDIF
IF !EMPTY(m.lcSetRelStr)
	=WriteFile(m.hOutFile, GDX_CMDMARGIN + m.lcSetRelStr)
ENDIF
IF !EMPTY(m.lcSetRIStr)
	=WriteFile(m.hOutFile, GDX_CMDMARGIN + m.lcSetRIStr)
ENDIF
=WriteFile(m.hOutFile, GDX_PRCMARGIN + "ENDPROC")

IF !EMPTY(m.lcCTStr)
******************************************************************************
*! Create a method that creates the tables in the database
******************************************************************************
	=WriteFile(m.hOutFile, "")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "PROCEDURE " + m.lcCTProc)
	=WriteFile(m.hOutFile,                     m.lcCTStr)
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "ENDPROC")
ENDIF

IF MAKE_INDEX_PASS and !EMPTY(m.lcCIDXStr)
******************************************************************************
*! Create a method that creates the indexes for each table
******************************************************************************
	=WriteFile(m.hOutFile, "")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "PROCEDURE " + m.lcCIDXProc)
	=WriteFile(m.hOutFile,                     m.lcCIDXStr)
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "ENDPROC")
ENDIF

IF !EMPTY(m.lcCRTPStr)
******************************************************************************
*! Create a method that creates the rules, triggers and properties for each table
******************************************************************************
	=WriteFile(m.hOutFile, "")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "PROCEDURE " + m.lcCRTPProc)
	=WriteFile(m.hOutFile,                     m.lcCRTPStr)
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "ENDPROC")
ENDIF

IF !EMPTY(m.lcCCStr)
******************************************************************************
*! Create a method that creates the database's connections
******************************************************************************
	=WriteFile(m.hOutFile, "")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "PROCEDURE " + m.lcCCProc)
	=WriteFile(m.hOutFile,                     m.lcCCStr)
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "ENDPROC")
ENDIF

IF !EMPTY(m.lcCVStr)
******************************************************************************
*! Create a method that creates the database's views
******************************************************************************
	=WriteFile(m.hOutFile, "")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "PROCEDURE " + m.lcCVProc)
	=WriteFile(m.hOutFile,                     m.lcCVStr)
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "ENDPROC")
ENDIF
******************************************************************************
*! End the class definition
******************************************************************************
=WriteFile(m.hOutFile, "ENDDEFINE")

******************************************************************************
*! Make the output file(s) permanent
******************************************************************************
=FCLOSE(m.hOutFile)
COPY FILE (m.cDPTemp) TO (m.tcOutFile)
ERASE (m.cDPTemp)
IF FILE(m.cSPTemp)
	COPY FILE (m.cSPTemp) to (m.cFile)
	ERASE (m.cSPTemp)
ENDIF
IF tlSeparateSPObjCode AND FILE(m.cSPObjTemp)
	COPY FILE (m.cSPObjTemp) to (m.cSPObjFile)
	ERASE (m.cSPObjTemp)
ENDIF

=Stat_Message()

COMPILE (m.tcOutFile)

=GenDBC_CleanUp(.T.)
*********************** END OF PROGRAM ***********************

**************************************************************************
**
** Function Name: GETRI()
** Creation Date: 1994.12.02
** Purpose:
**
**      To take existing FoxPro 3.0/5.0 RI Infomration, and generate an output
**      program that can be used to "re-create" this.
**
** Parameters:
**
**      hOutFile  - The file handle of the output file
**      cProcName - A character string containing the name of the
**                  current procedure
**
** Modification History:
**
**  1995.01.05  KRT  Created function
**  1995.12.20  KRT  Allow better lookup when trying to find
**                   the right record to add the RI information
**  1997.02.24  SEA  Output code within a PROCEDURE / ENDPROC block to
**                   avoid error when compiling procedures > 64K
**                   database re-creation program a procedure
**  1997.02.24  SEA  Write directly to a single output file, the handle 
**                   of which is passed in hOutFile
**  1997.12.29  SEA  Added code to break up the RI regeneration code
**                   into multiple procedures when it exceeds 64K
**  1998.03.26  SEA  ALLTRIM()'d the dbc's ObjectName field when searching
**                   for relations.
**  2022.06.11  SF   From VFP 6 up (at least)
**                   The code to rewrite RIINFO might find the wrong record 
**                   an odd set of tags and tables might be targeted with $ operator.
**                   Added delimiters
**************************************************************************
PROCEDURE GetRI
	LPARAMETERS hOutFile, cProcName

	PRIVATE ALL EXCEPT g_*

	llVersion5 ="VISUAL FOXPRO" $ upper(version(1)) AND;
			 VAL(LEFT(STRTRAN(VERSION(1),'Visual FoxPro ',''),AT('.',STRTRAN(VERSION(1),'Visual FoxPro ',''))-1))>=5

	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "***** " + BEGIN_RI_LOC + " *****")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "PROCEDURE " + cProcName)

	*! USE the database
	USE (m.g_cFullDatabase) EXCLUSIVE

	LOCATE FOR ObjectType = "Relation" AND !EMPTY(RiInfo)
	IF FOUND()
		=WriteFile(m.hOutFile, GDX_CMDMARGIN + "CLOSE DATABASE")
		=WriteFile(m.hOutFile, GDX_CMDMARGIN + "USE '" +  m.g_cDatabase + "'")
		lnRILen = 50	&& approx length of code so far
		lnRIProcNum = 1
		DO WHILE FOUND()
			*! SEA: If we're about to exceed the max size of a procedure (64K),
			*! close this proc and start another one, which we'll call from this proc.
			*! Since we're using approximations, I'll cut off at 64000 instead of
			*! 65000+.
			IF lnRILen > 64000
				=WriteFile(m.hOutFile, "")
				=WriteFile(m.hOutFile, GDX_CMDMARGIN + "=" + cProcName+"_"+ltrim(str(lnRIProcNum))+"()")
				=WriteFile(m.hOutFile, GDX_PRCMARGIN + "ENDPROC")
				=WriteFile(m.hOutFile, "")
				=WriteFile(m.hOutFile, GDX_PRCMARGIN + "PROCEDURE "+cProcName+"_"+ltrim(str(lnRIProcNum)))
				lnRIProcNum = lnRIProcNum + 1
				lnRILen = 20
			ENDIF
			*! Have to get the parent name to verify we are adding
			*! Information to the right record.
			m.nParentID = ParentID
			*! We use select so we won't mess up our LOCATE ... CONTINUE command
			SELECT ObjectName FROM (m.g_cFullDatabase) WHERE ObjectID = nParentID INTO ARRAY aTableName
			nStart = 1
			cITag = ""
			cTable = ""
			cRTag = ""
			DO WHILE m.nStart <= LEN(Property)
				nSize = ASC(SUBSTR(Property, m.nStart, 1)) +;
				(ASC(SUBSTR(Property, m.nStart + 1, 1)) * 256) +;
				(ASC(SUBSTR(Property, m.nStart + 2, 1)) * 256^2) + ;
				(ASC(SUBSTR(Property, m.nStart + 3, 1)) * 256^3)

				nKey = ASC(SUBSTR(Property, m.nStart + 6, 1))

				DO CASE
					CASE m.nKey = 13
						cITag = SUBSTR(Property, m.nStart + 7, m.nSize - 8)
					CASE m.nKey = 18
						cTable = SUBSTR(Property, m.nStart + 7, m.nSize - 8)
					CASE m.nKey = 19
						cRTag = SUBSTR(Property, m.nStart + 7, m.nSize - 8)
				ENDCASE
				nStart = m.nStart + m.nSize
			ENDDO
			=WriteFile(m.hOutFile, GDX_CMDMARGIN +                           "LOCATE FOR ObjectType = 'Table' AND UPPER(ALLTRIM(ObjectName)) == '" + UPPER(ALLTRIM(aTableName[1])) + "'")
			=WriteFile(m.hOutFile, GDX_CMDMARGIN +                           "IF FOUND()")
			=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT +                 "nObjectID = ObjectID")
** SF The code to rewrite RIINFO might find the wrong record 
**  an odd set of tags and tables might be targeted with $ operator like
**  ALTER TABLE myTab ADD FOREIGN KEY Tag longDay REFERENCES Day TAG lo
**  and
**  ALTER TABLE myTab ADD FOREIGN KEY Tag Day REFERENCES Long TAG ngd
**   searching for "Day"$Property AND "Long"$Property AND "ngd"$Property
**   might find the one or the other, because "longDay" holds all.
**   also the property field might hold a comment - and then it is unprdictable at all.
**   for that the gather of the values above is a bit more complex ...
**  added delimiters
**  out of 60DBCPRO.FRX:
**   Tag is between                  CHR(13) and next CHR(00)
**   Related table is between        CHR(18) and next CHR(00)
**   Tag of related table is between CHR(19) and next CHR(00)
**  Note: this is generic, so we can not use 0h00 or the like
**  Note: The normal way would be like the gathering above, with the search of the code using lenght and pos
**        Anyway, it is very unlikely to have a comment like CHR(13)+Text+(00) - in special since VFP offers no way to enter a comment.
**        There is a rare chance - at least not impossible -, but this would make the search overcomplex
**        If we need to go into this, we would need a function to search property field like the code above.
**        See https://github.com/VFPX/DBCLowLevelFunctions function GetProperty
**        Neither tags nor table should use those characters at all
**        So something like CHR(18)+Text+CHR(13)Text+(00) should not happen
			IF llVersion5 
				=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT +                 "LOCATE FOR ObjectType = 'Relation' AND " +;
						                                                              "CHR(13)+'" + m.cITag  + "'+CHR(0)$Property AND " +;
						                                                              "CHR(18)+'" + m.cTable + "'+CHR(0)$Property AND " +;
						                                                              "CHR(19)+'" + m.cRTag  + "'+CHR(0)$Property AND " +;
						                                                              "ParentID = nObjectID";
						)
			ELSE
				* until i figure out how it works below VFP 5.0
				=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT +                 "LOCATE FOR ObjectType = 'Relation' AND '" + m.cITag + ;
						                                                              "'$Property AND '" + m.cTable + "'$Property AND '" + m.cRTag + ;
						                                                              "'$Property AND ParentID = nObjectID")
			ENDIF
*** SF: end of new code
			=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT +                 "IF FOUND()")
			=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + GDX_INDENT +       "REPLACE RiInfo WITH '" + RiInfo + "'")
			=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT +                 "ELSE")
			=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + GDX_INDENT +       '? "' + NO_FIND_LOC + ', line " + ltrim(str(lineno()))')
			=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT +                 "ENDIF")
			=WriteFile(m.hOutFile, GDX_CMDMARGIN +                           "ENDIF")
			lnRILen = lnRILen + 400		&& approximate length of code we just added
			CONTINUE
		ENDDO
		=WriteFile(m.hOutFile, GDX_CMDMARGIN + "USE")
	ENDIF
	USE
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "ENDPROC")
RETURN

**************************************************************************
**
** Function Name: GETTABLE(, )
** Creation Date: 1994.12.01
** Purpose        :
**
**              To take an existing FoxPro 3.0/5.0 Table, and generate an output
**              program that can be used to "re-create" that Table.
**
** Parameters:
**
**      cTableName       A character string representing the name of the
**                       existing Table
**
**      hOutFile         The handle of the output file
**
**      cProcName        The name of the procedure within which we wrap the
**                       code that recreates the table
**
** Modification History:
**
**  1994.12.02  KRT      Created function
**  1994.12.05  KRT      Made it a function and cleaned it up
**  1994.12.08  KRT      Assume Database is open to speed up operation
**  1995.09.15  KRT      Use DBF() to find the real table name
**  1995.09.15  KRT      Take into account CR+LF in comment fields
**  1996.04.12  KRT      Added new properties for Visual FoxPro 5.0
**                       InputMask / Format / DisplayClass
**                       DisplayClassLibrary
**  1996.06.01  KRT      Added support for Collate sequence on index
**  1997.02.24  SEA      Output code within a PROCEDURE / ENDPROC block to
**                       avoid error when compiling procedures > 64K
**  1997.02.24  SEA      Write directly to a single output file, the handle 
**                       of which is passed in hOutFile
**  1997.02.25  SEA      Changed format of CREATE TABLE output code to
**                       improve its readability
**  1997.02.28  SEA      Only write the field ERROR clause if we have
**                       a CHECK clause
**  1997.05.01  SAS      Make two passes through the routine, the first to
**                       create the table, and the second to create its
**                       properties.
**  1997.09.05  SEA      When creating the procedure name, replace spaces
**                       with underscores.
**  1997.11.01  SEA      Added code to handle "Program line too long" error
**                       which occurs when a table has a large number of fields
**  1997.11.07  SEA      Added a constant to allow the user to specify that
**                       indices be created in a pass separate from the one
**                       that creates the table.
**  1997.12.16  SEA      Check for TAGCOUNT() > 0 before writing any index
**                       regeneration code.  Thanks to Mike Rothaus for
**                       suggesting this!
**  2022.06.11  SF       Included changes by DH from GenDBC.prg for additional file types
**    2004.03.19  DH        Added support for Blob, VarChar, and
**                          VarBinary fields
**    2004.05.05  DH        Added support for binary indexe
**             /SF
*******************************************************************************
PROCEDURE GetTable
	LPARAMETERS cTableName, hOutFile, cProcName

	PRIVATE ALL EXCEPT g_*

	*! Open Table to get field info
	USE (m.cTableName) EXCLUSIVE

	*! Get all the fields
	nNumberOfFields = AFIELDS(aAll_Fields)

	*! Header Information
	=WriteFile(m.hOutFile, "")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "**************************************************")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "** " + BEGIN_TABLE_LOC + m.cTableName)
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "**************************************************")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "PROCEDURE " + m.cProcName)
	=WriteFile(m.hOutFile, GDX_CMDMARGIN +    "LPARAMETERS tnPassNumber")
	=WriteFile(m.hOutFile, "")
	
	*! NOTE * NOTE * NOTE
	*! If the table is greater than 8 characters then it will fail on platforms that
	*! do not support this (Such as Win32s).
	cOldSetFullPath = SET("FULLPATH")
	SET FULLPATH ON
	cTableFileName = DBF(ALIAS())

	*-- Start pass 1, create the table
	=WriteFile(m.hOutFile, GDX_CMDMARGIN + "DO CASE" + CRLF + ;
	                       GDX_CMDMARGIN + "CASE tnPassNumber = 1")
		
	=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "=this.RemoveTable('" + m.cTableName + "', '" + ;
		m.cTableFileName + "')" + CRLF)

	SET FULLPATH OFF
	cTableFileName = DBF(ALIAS())
	IF UPPER(cOldSetFullPath) = "ON"
		SET FULLPATH ON
	ENDIF

	*! SEA: The CREATE TABLE command we construct below can exceed the command line
	*!      length limitation, especially in 3.0.  We can work around this problem
	*!      by using CREATE TABLE to add as many fields as possible, and adding the
	*!      rest through ALTER TABLE commands.
	IF "VISUAL FOXPRO 03" $ upper(version(1))
		nMaxCommandLen = 2048		&& max in 3.0 is 2K
	ELSE
		nMaxCommandLen = 8192		&& max in 5.0 or greater is (at least) 8K
	ENDIF
	nMaxLine = 100		&& an arbitrary buffer to ensure we don't exceed the limit
	lUseAlterTable = .F.

	cFieldLineEnd = ", ;" + CRLF
	cTableFileName = SUBSTR(m.cTableFileName, RAT(":", m.cTableFileName) + 1)
	cCreateTable = GDX_CMDMARGIN + GDX_INDENT + "CREATE TABLE '" + m.cTableFileName + ;
		"' NAME '" + m.cTableName + "' ( ;" + CRLF
	
	*! Information about each field that can been written with CREATE TABLE - SQL
	FOR nInner_Loop = 1 TO m.nNumberOfFields
		*! If we're approaching the command line length limit, switch to "ALTER TABLE"
		IF !lUseAlterTable and LEN(cCreateTable) > nMaxCommandLen - nMaxLine
			IF ALERT_USING_ALTER_TABLE
				=MessageBox(USING_ALTER_TABLE_LOC + m.cTableName, 64, WARNING_TITLE_LOC)
			ENDIF
			*! Since the previous field is the last we're including in the
			*! CREATE TABLE command, we have to remove the comma that follows
			*! the field info.
			cCreateTable = left(cCreateTable,len(cCreateTable)-len(cFieldLineEnd)) + " ;" + CRLF
			*! Close the CREATE TABLE command and switch to ALTER TABLE
			cCreateTable = cCreateTable + GDX_CMDMARGIN + GDX_INDENT + ")" + CRLF
			lUseAlterTable = .T.
		ENDIF
		IF lUseAlterTable
			cCreateTable = cCreateTable + GDX_CMDMARGIN + GDX_INDENT + "ALTER TABLE " + m.cTableName + " ADD COLUMN " + PADR(aAll_Fields(m.nInner_Loop, 1),MAX(LEN(aAll_Fields(m.nInner_Loop, 1)),GDX_FLDNAMEPAD)) + " " + aAll_Fields(m.nInner_Loop, 2)
		ELSE
			cCreateTable = cCreateTable + GDX_CMDMARGIN + GDX_INDENT + GDX_INDENT + PADR(aAll_Fields(m.nInner_Loop, 1),MAX(LEN(aAll_Fields(m.nInner_Loop, 1)),GDX_FLDNAMEPAD)) + " " + aAll_Fields(m.nInner_Loop, 2)
		ENDIF
		DO CASE
*** SF: Changes by DH from GenDBC.prg for additional file types
*** 2022/06/12
*** DH: changed to support V fields
***			CASE aAll_Fields(m.nInner_Loop, 2) == "C"
			CASE aAll_Fields(m.nInner_Loop, 2) == "C" or ;
				aAll_Fields(m.nInner_Loop, 2) == "V"
				cCreateTable = m.cCreateTable + "(" + ;
								ALLTRIM(STR(aAll_Fields(m.nInner_Loop, 3))) + ")"
				IF aAll_Fields(m.nInner_Loop, 6)
					cCreateTable = m.cCreateTable + " NOCPTRANS"
				ENDIF
*** DH: new code to support Q fields
			CASE aAll_Fields(m.nInner_Loop, 2) == "Q"
				m.cCreateTable = m.cCreateTable + "(" + ;
								ALLTRIM(STR(aAll_Fields(m.nInner_Loop, 3))) + ")"
*** DH: end of new code
***	/SF
		CASE aAll_Fields(m.nInner_Loop, 2) == "M"
				IF aAll_Fields(m.nInner_Loop, 6)
					cCreateTable = m.cCreateTable + " NOCPTRANS"
				ENDIF
			CASE aAll_Fields(m.nInner_Loop, 2) == "N" OR ;
				aAll_Fields(m.nInner_Loop, 2) == "F"
				cCreateTable = m.cCreateTable + "(" + ;
				ALLTRIM(STR(aAll_Fields(m.nInner_Loop, 3))) + ;
				", " + ALLTRIM(STR(aAll_Fields(m.nInner_Loop, 4))) + ")"
			CASE aAll_Fields(m.nInner_Loop, 2) == "B"
				cCreateTable = m.cCreateTable + "(" + ;
				ALLTRIM(STR(aAll_Fields(m.nInner_Loop, 4))) + ")"
		ENDCASE

		IF aAll_Fields(m.nInner_Loop, 5)
			cCreateTable = m.cCreateTable + " NULL"
		ELSE
			cCreateTable = m.cCreateTable + " NOT NULL"
		ENDIF

		#IF CREATE_TABLE_SET_PROPS
			*! Get properties for fields
			IF !EMPTY(aAll_Fields[m.nInner_Loop,7])
				cCreateTable = m.cCreateTable + " CHECK " + aAll_Fields[m.nInner_Loop,7]
				*! SEA: Only insert the ERROR message if we have a CHECK clause
				IF !EMPTY(aAll_Fields[m.nInner_Loop,8])
					cCreateTable = m.cCreateTable + " ERROR " + aAll_Fields[m.nInner_Loop,8]
				ENDIF
			ENDIF

			IF !EMPTY(aAll_Fields(m.nInner_Loop, 9))
				cCreateTable = m.cCreateTable + " DEFAULT " + aAll_Fields[m.nInner_Loop,9]
			ENDIF
		#ENDIF

		IF m.nInner_Loop <> m.nNumberOfFields
			IF !lUseAlterTable
				cCreateTable = m.cCreateTable + m.cFieldLineEnd
			ELSE
				cCreateTable = cCreateTable + CRLF
			ENDIF
		ELSE
			IF !lUseAlterTable
				cCreateTable = m.cCreateTable + " ;" + CRLF + ;
					GDX_CMDMARGIN + GDX_INDENT + ")"
			ENDIF
		ENDIF
	ENDFOR
	*! Output the code to create the table
	=WriteFile(m.hOutFile, m.cCreateTable)

	IF TAGCOUNT() > 0
		*! Get Index Information
		#IF MAKE_INDEX_PASS
			*-- Start pass 3, create the table's indexes in a separate pass
			=WriteFile(m.hOutFile, CRLF + GDX_CMDMARGIN +                    "CASE tnPassNumber = 3")
			=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT +                 "IF !USED('" + m.cTableName + "')")
			=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + GDX_INDENT +       "USE " + m.cTableName + " AGAIN IN 0 ALIAS " + m.cTableName)
			=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT +                 "ENDIF")
			=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT +                 "SELECT " + m.cTableName)
			=WriteFile(m.hOutFile, "")
		#ENDIF

		=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "***** " + BEGIN_INDEX_LOC + m.cTableName + " *****")
		cCollate = ""
*** SF: Changes by DH from GenDBC.prg for additional file types
*** 2022/06/12
*** DH: added next line to support binary indexes
		ATAGINFO(laTags)
*** /SF
		FOR nInner_Loop = 1 TO TAGCOUNT()
			cTag = UPPER(ALLTRIM(TAG(m.nInner_Loop)))
			IF m.cCollate <> IDXCOLLATE(m.nInner_Loop)
				cCollate = IDXCOLLATE(m.nInner_Loop)
				=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "SET COLLATE TO '" + m.cCollate + "'")
			ENDIF
			IF !EMPTY(m.cTag)
*** SF: Changes by DH from GenDBC.prg for additional file types
*** 2022/06/12
				lnIndex  = ASCAN(laTags, m.cTag, -1, -1, 1, 15)
				llBinary = IIF(m.lnIndex > 0, laTags[lnIndex, 2] = "BINARY", .F.)
*** /SF
				DO CASE
					CASE PRIMARY(m.nInner_Loop)
						IF !EMPTY(SYS(2021, m.nInner_Loop))
							IF EMPTY(m.g_cFilterExp)
								=MessageBox(NOT_SUPPORTED_LOC, 64, WARNING_TITLE_LOC)
							ENDIF
							g_cFilterExp = GDX_CMDMARGIN + GDX_INDENT + m.g_cFilterExp + CRLF + ;
							               GDX_CMDMARGIN + GDX_INDENT + TABLE_NAME_LOC + m.cTableName + CRLF + ;
							               GDX_CMDMARGIN + GDX_INDENT + PRIMARY_KEY_LOC + SYS(14, m.nInner_Loop) + CRLF + ;
							               GDX_CMDMARGIN + GDX_INDENT + FILTER_EXP_LOC + SYS(2021, m.nInner_Loop)
						ENDIF
						=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "ALTER TABLE '" + m.cTableName + ;
							"' ADD PRIMARY KEY " + SYS(14, m.nInner_Loop) ;
							+ " TAG " + m.cTag + IIF(ALTER_TABLE_NOVALIDATE, " NOVALIDATE", ""))

					CASE CANDIDATE(m.nInner_Loop)
						IF EMPTY(SYS(2021, m.nInner_Loop))
							=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "INDEX ON " + SYS(14, m.nInner_Loop) + ;
								" TAG " + m.cTag + " CANDIDATE")
						ELSE
							=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "INDEX ON " + SYS(14, m.nInner_Loop) + ;
								" TAG " + m.cTag + " FOR " + SYS(2021, m.nInner_Loop) + ;
								+ " CANDIDATE")
						ENDIF
	
					CASE UNIQUE(m.nInner_Loop)
						IF(EMPTY(SYS(2021, m.nInner_Loop)))
							=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "INDEX ON " + SYS(14, m.nInner_Loop) + ;
								" TAG " + m.cTag + " UNIQUE")
						ELSE
							=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "INDEX ON " + SYS(14, m.nInner_Loop);
								+ " TAG " + m.cTag + " FOR " + SYS(2021, m.nInner_Loop) ;
								+ " UNIQUE")
						ENDIF
*** SF: Changes by DH from GenDBC.prg for additional file types
*** 2022/06/12
*** DH: added to support binary indexes
					CASE llBinary
						WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "INDEX ON " + SYS(14, m.nInner_Loop) + ;
						" TAG " + m.cTag + " BINARY")
*** DH: end of new code
*** /SF

					OTHERWISE
						IF(EMPTY(SYS(2021, m.nInner_Loop)))
							=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "INDEX ON " + SYS(14, m.nInner_Loop) + ;
								" TAG " + m.cTag)
						ELSE
							=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "INDEX ON " + SYS(14, m.nInner_Loop);
								+ " TAG " + m.cTag + " FOR " + SYS(2021, m.nInner_Loop))
						ENDIF
				ENDCASE
			ELSE
				EXIT FOR
			ENDIF
		ENDFOR
	ENDIF
	
	IF lUseAlterTable
		*! ALTER TABLE commands can leave numerous deleted rows in the
		*! database container, so we should pack the dbc.  Note that the dbc
		*! must have been opened exclusively in order for this to work.
		=WriteFile(m.hOutFile, "")
		=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "***** " + PACK_DATABASE_LOC + " *****")
		=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "CLOSE TABLES")
		=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "PACK DATABASE")
	ENDIF

	*-- Start pass 2, create the table's properties
	=WriteFile(m.hOutFile, CRLF + GDX_CMDMARGIN + "CASE tnPassNumber = 2")
	
	*! Get Properties For Table
	=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "***** " + BEGIN_PROP_LOC + m.cTableName + " *****")
	FOR m.nInner_Loop = 1 TO m.nNumberOfFields
		cFieldAlias = aAll_Fields(m.nInner_Loop, 1)
		cFieldHeaderAlias = GDX_CMDMARGIN + GDX_INDENT + "ALTER TABLE '" + m.cTableName + "' ALTER COLUMN " + m.cFieldAlias

		#IF !CREATE_TABLE_SET_PROPS
			*! Get properties for fields
			IF !EMPTY(aAll_Fields[m.nInner_Loop,7])
				cTemp = m.cFieldHeaderAlias + " SET CHECK " + aAll_Fields[m.nInner_Loop,7]
				*! SEA: Only insert the ERROR message if we have a CHECK clause
				IF !EMPTY(aAll_Fields[m.nInner_Loop,8])
					cTemp = m.cTemp + " ERROR " + aAll_Fields[m.nInner_Loop,8]
				ENDIF
				cTemp = m.cTemp + " NOVALIDATE"
				=WriteFile(hOutFile, m.cTemp)
			ENDIF

			IF !EMPTY(aAll_Fields(m.nInner_Loop, 9))
				=WriteFile(hOutFile, m.cFieldHeaderAlias + " SET DEFAULT " + aAll_Fields[m.nInner_Loop,9] + " NOVALIDATE")
			ENDIF
		#ENDIF

		cFieldAlias = m.cTableName + "." + aAll_Fields(m.nInner_Loop, 1)
		*!*	cFieldHeaderAlias = GDX_CMDMARGIN + GDX_INDENT + [=DBSetProp('] + m.cFieldAlias + [', 'Field', ]
		cFieldHeaderAlias = GDX_CMDMARGIN + GDX_INDENT + [DBSetProp('] + m.cFieldAlias + [', 'Field', ]
		cTemp = DBGETPROP(m.cFieldAlias, "Field", "Caption")
		IF !EMPTY(cTemp)
			cTemp = STRTRAN(m.cTemp, ["], ['])
			=WriteFile(hOutFile, m.cFieldHeaderAlias + ['Caption', "] + m.cTemp + [")])
		ENDIF
		cTemp = DBGETPROP(m.cFieldAlias, "Field", "Comment")
		IF !EMPTY(m.cTemp)
			cTemp = STRTRAN(m.cTemp, ["], ['])
			*! Strip Line Feeds
			cTemp = STRTRAN(m.cTemp, CHR(10)) 
			*! Convert Carriage Returns To Programmatic Carriage Returns
			cTemp = STRTRAN(m.cTemp, CHR(13), '" + CHR(13) + "')
			=WriteFile(m.hOutFile, m.cFieldHeaderAlias + ['Comment', "] + m.cTemp + [")])
		ENDIF

		*! The remaining field-level properties don't apply to version 3
		IF "VISUAL FOXPRO" $ upper(version(1)) and !"VISUAL FOXPRO 03" $ upper(version(1))
			* We're not running version 3, so we must be running 5 or higher
			cTemp = DBGETPROP(m.cFieldAlias, "Field", "InputMask")
			IF !EMPTY(m.cTemp)
				m.cTemp = STRTRAN(m.cTemp, ["], ['])
				=WriteFile(m.hOutFile, m.cFieldHeaderAlias + ['InputMask', "] + m.cTemp + [")])
			ENDIF
			cTemp = DBGETPROP(m.cFieldAlias, "Field", "Format")
			IF !EMPTY(m.cTemp)
				cTemp = STRTRAN(m.cTemp, ["], ['])
				=WriteFile(m.hOutFile, m.cFieldHeaderAlias + ['Format', "] + m.cTemp + [")])
			ENDIF
			cTemp = DBGETPROP(m.cFieldAlias, "Field", "DisplayClass")
			IF !EMPTY(m.cTemp)
				cTemp = STRTRAN(m.cTemp, ["], ['])
				=WriteFile(m.hOutFile, m.cFieldHeaderAlias + ['DisplayClass', "] + m.cTemp + [")])
			ENDIF
			cTemp = DBGETPROP(m.cFieldAlias, "Field", "DisplayClassLibrary")
			IF !EMPTY(m.cTemp)
				cTemp = STRTRAN(m.cTemp, ["], ['])
				=WriteFile(m.hOutFile, m.cFieldHeaderAlias + ['DisplayClassLibrary', "] + m.cTemp + [")])
			ENDIF
		ENDIF
	ENDFOR
	
	cTemp = DBGETPROP(m.cTableName, "Table", "Comment")
	IF !EMPTY(m.cTemp)
		cTemp = STRTRAN(m.cTemp, ["], ['])
		*! Strip Line Feeds
		cTemp = STRTRAN(m.cTemp, CHR(10))
		*! Convert Carriage Returns To Programmatic Carriage Returns
		cTemp = STRTRAN(m.cTemp, CHR(13), '" + CHR(13) + "')
		=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + [DBSetProp('] + m.cTableName + [', 'Table', ] + ['Comment', "] + m.cTemp + [")])
	ENDIF

	cTemp = DBGETPROP(m.cTableName, "Table", "DeleteTrigger")
	IF !EMPTY(m.cTemp)
		=WriteFile(hOutFile, GDX_CMDMARGIN + GDX_INDENT + "CREATE TRIGGER ON '" + m.cTableName + ;
							  "' FOR DELETE AS " + m.cTemp)
	ENDIF

	cTemp = DBGETPROP(m.cTableName, "Table", "InsertTrigger")
	IF !EMPTY(m.cTemp)
		=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "CREATE TRIGGER ON '" + m.cTableName + ;
							  "' FOR INSERT AS " + m.cTemp)
	ENDIF

	cTemp = DBGETPROP(m.cTableName, "Table", "UpdateTrigger")
	IF !EMPTY(m.cTemp)
		=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "CREATE TRIGGER ON '" + m.cTableName + ;
							  "' FOR UPDATE AS " + m.cTemp)
	ENDIF

	cTemp = DBGETPROP(m.cTableName, "Table", "RuleExpression")
	IF !EMPTY(m.cTemp)
		cError = DBGETPROP(m.cTableName, "Table", "RuleText")
		IF !EMPTY(cError)
			=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "ALTER TABLE '" + m.cTableName + ;
								  "' SET CHECK " + m.cTemp + " ERROR " + ;
								  m.cError)
		ELSE
			=WriteFile(m.hOutFile, GDX_CMDMARGIN + GDX_INDENT + "ALTER TABLE '" + m.cTableName + ;
								  "' SET CHECK " + m.cTemp)
		ENDIF
	ENDIF
	
	=WriteFile(m.hOutFile, GDX_CMDMARGIN + "ENDCASE")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "ENDPROC")
	=WriteFile(m.hOutFile, "")

RETURN

**************************************************************************
**
** Function Name: GETVIEW(, )
** Creation Date: 1994.12.01
** Purpose        :
**
**              To take an existing FoxPro 3.0/5.0 View, and generate an
**              output program that can be used to "re-create" that view.
**
** Parameters:
**
**      cViewName        A character string representing the name of the 
**                       existing view
**
**      hOutFile         The handle of the output file
**
**      cProcName        The name of the procedure within which we wrap the
**                       code that recreates the view
**
** Modification History:
**
**  1994.12.01  JHL      Created Program, runs on Build 329 of FoxPro 3.0
**  1994.12.02  KRT      Added to GenDBC, removed third parameter, cleaned up
**  1994.12.08  KRT      Assume Database is open to speed up operation
**  1996.04.12  KRT      Added new properties for Visual FoxPro 5.0
**                       Prepared / CompareMemo / FetchAsNeeded
**  1996.05.14  KRT      Added more properties for views
**  1996.05.16  KRT      Adjusted for return a blank string instead of a logical
**                       value on Prepared, etc.. if the field does not exist
**                       in the database (Version 3.0 database converted to 5.0)
**  1996.05.16  KRT      Added the DataType property
**  1996.06.26  KRT      Added support for ParameterList
**  1996.07.19  KRT      Added support for Offline Views
**  1996.08.07  KRT      Added support for BatchUpdateCount, Comment
**  1997.02.24  SEA      Output code within a PROCEDURE / ENDPROC block to
**                       avoid error when compiling procedures > 64K
**                       database re-creation program a procedure
**  1997.02.24  SEA      Write directly to a single output file, the handle 
**                       of which is passed in hOutFile
**  1997.09.05  SEA      Removed duplicate "FetchSize" output line (bug fix).
**  1997.09.05  SEA      Added check for VFP 3.0 before attempting to retrieve
**                       5.0-specific properties (bug fix).  (Thanks to
**                       Nancy Folsom for catching this!)
**  1997.09.05  SEA      Added code to handle view names that contain spaces when
**                       creating the view-recreation procedure name
**  1997.12.07  SEA      Added code to initialize local variables for each parameter
**                       in a parameterized view.  Note that this only works if you
**                       have added each parameter to the view's parameters list,
**                       either through the View Designer (Query/View Parameters) or
**                       with DBSetProp().
**  2022.06.11  SF       Included changes by DH from GenDBC.prg for additional file types
**                       just fitted into one block for VFP 9 and VFPA
**    2004.04.14  DH        Added support for AllowSimultaneousFetch,
**                          RuleExpression, and RuleText properties
**    2002.06.28  DH        Removed duplicate output of FetchSize property
**    2004.09.22  DH        Handled case where UpdateName has quotes (e.g. with
**                          calculated fields like "Test" AS SOMEFIELD)
**             /SF
***************************************************************************************
PROCEDURE GetView
	LPARAMETERS cViewName, hOutFile, cProcName

	PRIVATE ALL EXCEPT g_*

	*! Get View Information for later use
	nSourceType       = DBGetProp(m.cViewName, 'View', 'SourceType')
	cConnectName      = ALLTRIM(DBGetProp(m.cViewName, 'View', 'ConnectName'))
	cSQL              = ALLTRIM(DBGetProp(m.cViewName, 'View', 'SQL'))
	cnUpdateType      = ALLTRIM(STR(DBGetProp(m.cViewName, 'View', 'UpdateType')))
	cnWhereType       = ALLTRIM(STR(DBGetProp(m.cViewName, 'View', 'WhereType')))
	clFetchMemo       = IIF(DBGetProp(m.cViewName, 'View', 'Fetchmemo'),'.T.','.F.')
	clShareConnection = IIF(DBGetProp(m.cViewName, 'View', 'ShareConnection'),'.T.','.F.')
	clSendUpdates     = IIF(DBGetProp(m.cViewName, 'View', 'SendUpdates'),'.T.','.F.')
	cnUseMemoSize     = ALLTRIM(STR(DBGetProp(m.cViewName, 'View', 'UseMemoSize')))
	cnFetchSize       = ALLTRIM(STR(DBGetProp(m.cViewName, 'View', 'FetchSize')))
	cnMaxRecords      = ALLTRIM(STR(DBGetProp(m.cViewName, 'View', 'MaxRecords')))
	ccTables          = ALLTRIM(DBGetProp(m.cViewName, 'View', 'Tables'))
	cParams           = ALLTRIM(DBGetProp(m.cViewName, 'View', 'ParameterList'))
		cComment          = DBGETPROP(m.cViewName, 'View', 'Comment')
	IF !EMPTY(m.cComment )
		cComment = STRTRAN(m.cComment , ["], ['])
		*! Strip Line Feeds
		cComment = STRTRAN(m.cComment , CHR(10)) 
		*! Convert Carriage Returns To Programmatic Carriage Returns
		cComment = STRTRAN(m.cComment , CHR(13), '" + CHR(13) + "')
	ENDIF
	cnBatchUpdateCount = ALLTRIM(STR(DBGetProp(m.cViewName, 'View', 'BatchUpdateCount')))

	*! Generate Heading
	=WriteFile(m.hOutFile, "")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "**************************************************")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "** " + BEGIN_VIEW_LOC + m.cViewName)
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "**************************************************")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "PROCEDURE " + m.cProcName)

	IF !EMPTY(m.cParams)
		*! Generate code to create parameters before we create the view, so that VFP
		*! doesn't ask the user for the parameters' values.
		cParamList = cParams + "; "
		cLocalsStr = GDX_CMDMARGIN + "LOCAL "
		cParamsStr = ""
		do while !empty(cParamList)
			cParamName = left(cParamList,at(",",cParamList)-1)
			cDataType  = substr(cParamList,at(",",cParamList)+2,1)
			cCrtParam  = cParamName + " = " + DataValue(cDataType)
			cLocalsStr = cLocalsStr + cParamName + ","
			cParamsStr = cParamsStr + GDX_CMDMARGIN + cCrtParam + CRLF
			cParamList = substr(cParamList,at(";",cParamList)+1)
		enddo
		*! Strip the trailing comma from the LOCAL statement
		cLocalsStr = left(cLocalsStr,len(cLocalsStr)-1)
		*! Write the code
		=WriteFile(m.hOutFile, cLocalsStr)
		=WriteFile(m.hOutFile, cParamsStr)
	ENDIF

	*! Generate CREATE VIEW command
	cCreateString = GDX_CMDMARGIN + 'CREATE SQL VIEW "' + ALLTRIM(m.cViewName) + '" ; ' + CRLF

	IF m.nSourceType != 1     && If it isn't a local view
		cCreateString = m.cCreateString + GDX_CMDMARGIN + GDX_INDENT + 'REMOTE '
		IF !EMPTY(m.cConnectName)
			cCreateString = m.cCreateString + 'CONNECTION "' + m.cConnectName + '" ; '+CRLF
		ENDIF
	ENDIF
	cCreateString = m.cCreateString + GDX_CMDMARGIN + GDX_INDENT + 'AS '+ m.cSQL + CRLF

	=WriteFile(m.hOutFile, m.cCreateString)

	*! GENERATE code to Set View Level Properties
	cViewDBSetPrefix = GDX_CMDMARGIN + [DBSetProp('] + m.cViewName + [', 'View', ]

	=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['UpdateType', ] + m.cnUpdateType + [)])
	=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['WhereType', ] + m.cnWhereType + [)])
	=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['FetchMemo', ] + m.clFetchMemo + [)])
	=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['SendUpdates', ] + m.clSendUpdates + [)])
	=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['UseMemoSize', ] + m.cnUseMemoSize + [)])
	=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['FetchSize', ] + m.cnFetchSize + [)])
	=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['MaxRecords', ] + m.cnMaxRecords + [)])
	=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['Tables', '] + m.ccTables + [')])
*** SF: Changes by DH from GenDBC.prg for additional file types
*** 2022/06/12
*** DH: Removed duplicate output of FetchSize property
*** SF: This is not visible in GenDBC
*	=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['FetchSize', ] + m.cnFetchSize + [)])
*** /SF
	IF !EMPTY(m.cParams)
		=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['ParameterList', "] + m.cParams + [")])
	ENDIF
	=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['Comment', "] +  m.cComment + [")])
	=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['BatchUpdateCount', ] + m.cnBatchUpdateCount + [)])
	=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['ShareConnection', ] + m.clShareConnection + [)])

	*! The remaining view properties don't apply to version 3
	IF "VISUAL FOXPRO" $ upper(version(1)) and !"VISUAL FOXPRO 03" $ upper(version(1))
		clPrepared = IIF(!EMPTY(DBGetProp(m.cViewName, 'View', 'Prepared')), '.T.', '.F.')
		clCompareMemo = IIF(!EMPTY(DBGetProp(m.cViewName, 'View', 'CompareMemo')), '.T.', '.F.')
		clFetchAsNeeded = IIF(!EMPTY(DBGetProp(m.cViewName, 'View', 'FetchAsNeeded')), '.T.', '.F.')
		lOffline = DBGetProp(m.cViewName, 'View', 'Offline')

		=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['Prepared', ] + m.clPrepared + [)])
		=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['CompareMemo', ] + m.clCompareMemo + [)])
		=WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['FetchAsNeeded', ] + m.clFetchAsNeeded + [)])
		IF m.lOffline
			=WriteFile(m.hOutFile, GDX_CMDMARGIN + 'CREATEOFFLINE("' + m.cViewName + '")')
		ENDIF
	ENDIF

		
*** SF: Changes by DH from GenDBC.prg for additional file types
*** 2022/06/12
*** just fitted into one block for VFP 9 and VFPA
*** DH: new code to support AllowSimultaneousFetch
*** SF just for VFP 9 and following
	m.clAllowSimultaneousFetch = IIF(!EMPTY(DBGetProp(m.cViewName, 'View', 'AllowSimultaneousFetch')), '.T.', '.F.')
	IF "VISUAL FOXPRO" $ upper(version(1)) AND;
			 VAL(LEFT(STRTRAN(VERSION(1),'Visual FoxPro ',''),AT('.',STRTRAN(VERSION(1),'Visual FoxPro ',''))-1))>=9
		clAllowSimultaneousFetch = IIF(!EMPTY(DBGetProp(m.cViewName, 'View', 'AllowSimultaneousFetch')), '.T.', '.F.')
		cRuleExpression          = DBGETPROP(m.cViewName, "View", "RuleExpression")
		cRuleText                = DBGETPROP(m.cViewName, "View", "RuleText")

		WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['AllowSimultaneousFetch', ] + m.clAllowSimultaneousFetch + [)])
		IF !EMPTY(m.cRuleExpression)
			WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['RuleExpression', '] + m.cRuleExpression + [')])
		ENDIF
		IF !EMPTY(m.cRuleExpression)
			WriteFile(m.hOutFile, m.cViewDBSetPrefix + ['RuleText', '] + m.cRuleText + [')])
		ENDIF
	ENDIF
*** DH: end of new code
*** /SF

	*! GENERATE code to Set Field Level Properties
	USE (DBC()) AGAIN IN 0 ALIAS GenViewCursor EXCLUSIVE
	SELECT GenViewCursor
	LOCATE FOR ALLTRIM(UPPER(GenViewCursor.ObjectName)) == m.cViewName AND ;
    	GenViewCursor.ObjectType = 'View'
	nObjectId = GenViewCursor.ObjectId
	SELECT ObjectName FROM GenViewCursor ;
			WHERE GenViewCursor.ParentId = m.nObjectId ;
			INTO ARRAY aViewFields
	USE in GenViewCursor
	=WriteFile(m.hOutFile, "")
	=WriteFile(m.hOutFile, GDX_CMDMARGIN + '*!* Field Level Properties for ' + m.cViewName)

	IF _TALLY # 0
		FOR m.nLoop = 1 TO ALEN(aViewFields, 1)
			cFieldAlias = m.cViewName + "." + ALLTRIM(aViewFields(nLoop, 1))
			clKeyField = IIF(DBGetProp(m.cFieldAlias, 'Field', 'KeyField'),'.T.','.F.')
			clUpdatable = IIF(DBGetProp(m.cFieldAlias, 'Field', 'Updatable'),'.T.','.F.')
			ccUpdateName = ALLTRIM(DBGetProp(m.cFieldAlias, 'Field', 'UpdateName'))
			cViewFieldSetPrefix = GDX_CMDMARGIN + [DBSetProp('] + m.cFieldAlias + [', 'Field', ]
			
			=WriteFile(m.hOutFile, GDX_CMDMARGIN + '* Props for the '+m.cFieldAlias+' field.')
			=WriteFile(m.hOutFile, m.cViewFieldSetPrefix + ['KeyField', ] + m.clKeyField + [)])
*** DH 2023-05-20: added missing line
			=WriteFile(m.hOutFile, m.cViewFieldSetPrefix + ['Updatable', ] + m.clUpdatable + [)])
*** SF: Changes by DH from GenDBC.prg for additional file types
*** 2022/06/12
*** DH: added code to handle quotes in UpdateName properly
*			=WriteFile(m.hOutFile, m.cViewFieldSetPrefix + ['UpdateName', '] + m.ccUpdateName + [')])
			lcDelimiter = iif(['] $ m.ccUpdateName, ["], ['])
			WriteFile(m.hOutFile, m.cViewFieldSetPrefix + ['UpdateName', ] + ;
				m.lcDelimiter + m.ccUpdateName + m.lcDelimiter + [)])
*** DH: end of new code
*** /SF

			cTemp = DBGETPROP(m.cFieldAlias, "Field", "RuleExpression")
			IF !EMPTY(m.cTemp)
				cTemp = STRTRAN(m.cTemp, ["], ['])
				=WriteFile(m.hOutFile, m.cViewFieldSetPrefix + ['RuleExpression', "]+m.cTemp+[")])
			ENDIF
			
			cTemp = DBGETPROP(m.cFieldAlias, "Field", "RuleText")
			IF !EMPTY(m.cTemp)
				cTemp = STRTRAN(m.cTemp, ["], ['])
				=WriteFile(m.hOutFile, m.cViewFieldSetPrefix + ['RuleText', "]+m.cTemp+[")])
			ENDIF
			*-- SAS
			* cTemp = DBGETPROP(m.cFieldAlias, "Field", "Caption")
			cTemp = ALLTRIM(DBGETPROP(m.cFieldAlias, "Field", "Caption"))
			*-- SAS
			IF !EMPTY(m.cTemp)
				cTemp = STRTRAN(m.cTemp, ["], ['])
				=WriteFile(m.hOutFile, m.cViewFieldSetPrefix + ['Caption', "] + m.cTemp + [")])
			ENDIF
			cTemp = DBGETPROP(m.cFieldAlias, "Field", "Comment")
			IF !EMPTY(m.cTemp)
				cTemp = STRTRAN(m.cTemp, ["], ['])
				*! Strip Line Feeds
				cTemp = STRTRAN(m.cTemp, CHR(10)) 
				*! Convert Carriage Returns To Programmatic Carriage Returns
				cTemp = STRTRAN(m.cTemp, CHR(13), '" + CHR(13) + "')
				=WriteFile(m.hOutFile, m.cViewFieldSetPrefix + ['Comment', "] + m.cTemp + [")])
			ENDIF
			cTemp = DBGETPROP(m.cFieldAlias, "Field", "DataType")
			IF !EMPTY(m.cTemp)
				=WriteFile(m.hOutFile, m.cViewFieldSetPrefix + ['DataType', "] + m.cTemp + [")])
			ENDIF
			cTemp = DBGETPROP(m.cFieldAlias, "Field", "DefaultValue")
			IF !EMPTY(m.cTemp)
				cTemp = STRTRAN(m.cTemp, ["], ['])
				=WriteFile(m.hOutFile, m.cViewFieldSetPrefix + ['DefaultValue', "] + m.cTemp + [")])
			ENDIF

			*! The remaining field-level properties don't apply to version 3
			IF "VISUAL FOXPRO" $ upper(version(1)) and !"VISUAL FOXPRO 03" $ upper(version(1))
				cTemp = DBGETPROP(m.cFieldAlias, "Field", "InputMask")
				IF !EMPTY(m.cTemp)
					cTemp = STRTRAN(m.cTemp, ["], ['])
					=WriteFile(m.hOutFile, m.cViewFieldSetPrefix + ['InputMask', "] + m.cTemp + [")])
				ENDIF
				cTemp = DBGETPROP(m.cFieldAlias, "Field", "Format")
				IF !EMPTY(m.cTemp)
					cTemp = STRTRAN(m.cTemp, ["], ['])
					=WriteFile(m.hOutFile, m.cViewFieldSetPrefix + ['Format', "] + m.cTemp + [")])
				ENDIF
				cTemp = DBGETPROP(m.cFieldAlias, "Field", "DisplayClass")
				IF !EMPTY(m.cTemp)
					cTemp = STRTRAN(m.cTemp, ["], ['])
					=WriteFile(m.hOutFile, m.cViewFieldSetPrefix + ['DisplayClass', "] + m.cTemp + [")])
				ENDIF
				cTemp = DBGETPROP(m.cFieldAlias, "Field", "DisplayClassLibrary")
				IF !EMPTY(m.cTemp)
					cTemp = STRTRAN(m.cTemp, ["], ['])
					=WriteFile(m.hOutFile, m.cViewFieldSetPrefix + ['DisplayClassLibrary', "] + m.cTemp + [")])
				ENDIF
			ENDIF
		ENDFOR
	ENDIF

	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "ENDPROC")

RETURN

**************************************************************************
**
** Function Name: GETCONN(, )
** Creation Date: 1995.01.03
** Purpose        :
**
**              To take an existing FoxPro 3.0/5.0 Connection, and generate
**              an output program that can be used to "re-create" that connection.
**
** Parameters:
**
**      cConnectionName  A character string representing the name of the 
**                       existing connection
**
**      hOutFile         The handle of the output file
**
**      cProcName        The name of the procedure within which we wrap the
**                       code that recreates the connection
**
** Modification History:
**
**  1995.01.03  JHL      Created Program, runs on Build 329 of FoxPro 3.0
**  1995.01.05  KRT      Incorporated into GenDBC with modifications
**  1996.04.12  KRT      Added new property for Visual FoxPro 5.0 (Database)
**  1997.02.24  SEA      Output code within a PROCEDURE / ENDPROC block to
**                       avoid error when compiling procedures > 64K
**                       database re-creation program a procedure
**  1997.02.24  SEA      Write directly to a single output file, the handle 
**                       of which is passed in hOutFile
**  1997.09.05  SEA      When creating the procedure name, replace spaces
**                       with underscores.
**  2022.06.11  SF       Included changes by DH from GenDBC.prg for additional file types
**                       just fitted into one block for VFP 9 and VFPA
**    2004.03.19 DH         Added support for PacketSize
**                         added code to support WaitTime (it was retrieved but not written)
**             /SF
***************************************************************************************
PROCEDURE GetConn
	LPARAMETERS cConnectionName, hOutFile, cProcName

	PRIVATE ALL EXCEPT g_*

	*! Get Connection Information for later use
	clAsynchronous = IIF(DBGetProp(m.cConnectionName, 'Connection', 'Asynchronous'),'.T.','.F.')
	clBatchMode = IIF(DBGetProp(m.cConnectionName, 'Connection', 'BatchMode'),'.T.','.F.')
	ccComment = ALLTRIM(DBGetProp(m.cConnectionName, 'Connection', 'Comment'))
	ccConnectString = ALLTRIM(DBGetProp(m.cConnectionName, 'Connection', 'ConnectString'))
	cnConnectTimeOut = ALLTRIM(STR(DBGetProp(m.cConnectionName, 'Connection', 'ConnectTimeOut')))
	ccDataSource = ALLTRIM(DBGetProp(m.cConnectionName, 'Connection', 'DataSource'))
	cnDispLogin = ALLTRIM(STR(DBGetProp(m.cConnectionName, 'Connection', 'DispLogin')))
	clDispWarnings = IIF(DBGetProp(m.cConnectionName, 'Connection', 'DispWarnings'),'.T.','.F.')
	cnIdleTimeOut = ALLTRIM(STR(DBGetProp(m.cConnectionName, 'Connection', 'IdleTimeOut')))
	ccPassword = ALLTRIM(DBGetProp(m.cConnectionName, 'Connection', 'Password'))
	cnQueryTimeOut = ALLTRIM(STR(DBGetProp(m.cConnectionName, 'Connection', 'QueryTimeOut')))
	cnTransactions = ALLTRIM(STR(DBGetProp(m.cConnectionName, 'Connection', 'Transactions')))
	ccUserId = ALLTRIM(DBGetProp(m.cConnectionName, 'Connection', 'UserId'))
	cnWaitTime = ALLTRIM(STR(DBGetProp(m.cConnectionName, 'Connection', 'WaitTime')))
	ccDatabase = DBGetProp(m.cConnectionName, 'Connection', 'Database')
*** SF: Changes by DH from GenDBC.prg for additional file types
*** 2022/06/12
*** DH: added code to support PacketSize
	m.cnPacketSize = ALLTRIM(STR(DBGetProp(m.cConnectionName, 'Connection', 'PacketSize')))
*** DH: end of code
*** /SF

	*! Generate Heading
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "**************************************************")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "** " + BEGIN_CONNECTIONS_LOC + " " + m.cConnectionName)
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "**************************************************")
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "PROCEDURE " + m.cProcName)

	*! Generate CREATE Connection command
	cCreateString = GDX_CMDMARGIN + 'CREATE CONNECTION '+ALLTRIM(m.cConnectionName)+' ; '+CRLF

	IF EMPTY(ALLTRIM(m.ccConnectString))  && If connectstring not specified
		cCreateString = m.cCreateString + ;
			GDX_CMDMARGIN + GDX_INDENT + 'DATASOURCE "' + ALLTRIM(m.ccDataSource)    + '" ; ' + CRLF + ;
		   GDX_CMDMARGIN + GDX_INDENT + 'USERID "'     + ALLTRIM(m.ccUserId)        + '" ; ' + CRLF + ;
			GDX_CMDMARGIN + GDX_INDENT + 'PASSWORD "'   + ALLTRIM(m.ccPassword)      + '"'    + CRLF
	ELSE
		cCreateString = m.cCreateString + ;
			GDX_CMDMARGIN + GDX_INDENT + 'CONNSTRING "' + ALLTRIM(m.ccConnectString) + '"'
	ENDIF

	=WriteFile(m.hOutFile, m.cCreateString)

	*! GENERATE code to Set Connection Level Properties
	cConnectionDBSetPrefix = GDX_CMDMARGIN + [DBSetProp(']+m.cConnectionName+[', 'Connection', ]

	cConnectionProps = GDX_CMDMARGIN + '****' + CRLF
	cConnectionProps = m.cConnectionProps + m.cConnectionDBSetPrefix + ;
						['Asynchronous', ] + m.clAsynchronous + [)]+ CRLF
	cConnectionProps = m.cConnectionProps + m.cConnectionDBSetPrefix + ;
						['BatchMode', ] + m.clBatchMode + [)]+ CRLF
	cConnectionProps = m.cConnectionProps + m.cConnectionDBSetPrefix + ;
						['Comment', '] + m.ccComment + [')]+ CRLF
	cConnectionProps = m.cConnectionProps + m.cConnectionDBSetPrefix + ;
						['DispLogin', ] + m.cnDispLogin + [)]+ CRLF
	cConnectionProps = m.cConnectionProps + m.cConnectionDBSetPrefix + ;
						['ConnectTimeOut', ] + m.cnConnectTimeOut + [)]+ CRLF
	cConnectionProps = m.cConnectionProps + m.cConnectionDBSetPrefix + ;
						['DispWarnings', ] + m.clDispWarnings + [)]+ CRLF
	cConnectionProps = m.cConnectionProps + m.cConnectionDBSetPrefix + ;
						['IdleTimeOut', ] + m.cnIdleTimeOut + [)]+ CRLF
	cConnectionProps = m.cConnectionProps + m.cConnectionDBSetPrefix + ;
						['QueryTimeOut', ] + m.cnQueryTimeOut + [)]+ CRLF
	cConnectionProps = m.cConnectionProps + m.cConnectionDBSetPrefix + ;
						['Transactions', ] + m.cnTransactions + [)]+ CRLF
	cConnectionProps = m.cConnectionProps + m.cConnectionDBSetPrefix + ;
					    ['Database', '] + m.ccDatabase + [')] + CRLF
*** SF: Changes by DH from GenDBC.prg for additional file types
*** 2022/06/12
*** DH: added code to support PacketSize
	m.cConnectionProps = m.cConnectionProps + m.cConnectionDBSetPrefix + ;
						['PacketSize', ] + m.cnPacketSize + [)]+ CRLF
*** DH: added code to support WaitTime (it was retrieved but not written)
	m.cConnectionProps = m.cConnectionProps + m.cConnectionDBSetPrefix + ;
						['WaitTime', ] + m.cnWaitTime + [)]+ CRLF
*** DH: end of code
*** /SF
					    
	=WriteFile(m.hOutFile, m.cConnectionProps)
	=WriteFile(m.hOutFile, GDX_PRCMARGIN + "ENDPROC")

RETURN

**************************************************************************
**
** Function Name: FatalAlert()
** Creation Date: 1994.12.02
** Purpose:
**
**              Place a message box to alert user of a fatal error.
**
** Parameters:
**
**      cAlert_Message - Message to display to user
**      lCleanup       - If we should try to restore environment
**
** Modification History:
**
**      1994.12.02  KRT  Added to GenDBC
**************************************************************************
PROCEDURE FatalAlert
	LPARAMETERS cAlert_Message, lCleanup

	=MessageBox(m.cAlert_Message, 16, ERROR_TITLE_LOC)

	=GenDBC_CleanUp(m.lCleanup)

	CANCEL
RETURN

**************************************************************************
**
** Function Name: GenDBC_CleanUp()
** Creation Date: 1995.03.01
** Purpose:
**
**              Restore the environment
**
** Parameters:
**
**      lCleanup - If we should try to restore tables open
**
** Modification History:
**
**      1994.03.01  KRT         Added to GenDBC
**      1997.10.01  SEA         Added code to check for existence of
**                              file before trying to reopen each table.
**************************************************************************
PROCEDURE GenDBC_CleanUp
	LPARAMETERS lCleanup

	*! Restore everything
	IF !EMPTY(m.g_cOnError)
		ON ERROR &g_cOnError
	ELSE
		ON ERROR
	ENDIF
	
	IF !EMPTY(m.g_cSetTalk)
		SET TALK &g_cSetTalk
	ENDIF
	
	IF !EMPTY(m.g_cSetDeleted)
		SET DELETED &g_cSetDeleted
	ENDIF
	
	SET EXACT &g_cSetExact
	SET SAFETY &g_cSetSafety

	IF m.g_cSetStatusBar = "OFF"
		SET STATUS BAR OFF
	ENDIF
	
	IF !EMPTY(m.g_cStatusText)
		SET MESSAGE TO (m.g_cStatusText)
	ELSE
		SET MESSAGE TO
	ENDIF
	
	SET FULLPATH &g_cFullPath
	CLOSE ALL

	IF m.lCleanUp
		IF !EMPTY(m.g_cFullDatabase) AND m.lCleanUp
			OPEN DATABASE (m.g_cFullDatabase) EXCLUSIVE
			IF m.g_nTotal_Tables_Used > 0
				FOR m.nLoop = 1 TO m.g_nTotal_Tables_Used
					*-- Make sure the file still exists!  If we had an "auto-erase"
					*-- cursor open, its file has been deleted, and can't be restored.
					*-- Thanks to Michael Colbert for finding this bug!
					IF FILE(m.g_aTables_Used(m.nLoop))
						USE (m.g_aTables_Used(m.nLoop)) AGAIN IN (m.g_aAlias_Used(m.nLoop, 2)) EXCLUSIVE ;
							ALIAS (m.g_aAlias_Used(m.nLoop, 1))
					ENDIF
				ENDFOR
			ENDIF
		ENDIF
	ENDIF
RETURN

**************************************************************************
**
** Function Name: WriteFile(, )
** Creation Date: 1994.12.02
** Purpose        :
**
**              Centralized file output routine to check for proper output
**
** Parameters:
**
**      hFileHandle - Handle of output file
**      cText       - Contents to write to file
**
** Modification History:
**
**      1994.12.02  KRT         Added to GenDBC
**************************************************************************
PROCEDURE WriteFile
	LPARAMETERS hFileHandle, cText

	nBytesSent = FPUTS(m.hFileHandle, m.cText)
	IF m.nBytesSent < LEN(m.cText)
		=FatalAlert(NO_OUTPUT_WRITTEN_LOC, .T.)
	ENDIF
RETURN

**************************************************************************
**
** Function Name: GenDBC_Error(, )
** Creation Date: 1994.12.02
** Purpose        :
**
**              Generalized Error Routine
**
** Parameters:
**
**      cMess   - Message to give user
**      nLineNo - Line Number Error Occurred
**
** Modification History:
**
**      1994.12.02  KRT         Added to GenDBC
**************************************************************************
PROCEDURE GenDBC_Error
	LPARAMETERS cMess, nLineNo

	=FatalAlert(UNRECOVERABLE_LOC + CRLF + m.cMess + CRLF + ;
				  AT_LINE_LOC + ALLTRIM(STR(m.nLineNo)), .T.)
RETURN

**************************************************************************
**
** Function Name: Stat_Message()
** Creation Date: 1994.01.08
** Purpose        :
**
**              Generalized Status Bar Progression
**
** Parameters:
**
**              None
**
** Modification History:
**
**      1994.01.08  KRT         Added to GenDBC
**************************************************************************
PROCEDURE Stat_Message
	PRIVATE ALL EXCEPT g_*
	
	nStat = m.g_nCurrentStat * (160 / g_nMax)
	SET MESSAGE TO REPLICATE("|", m.nStat) + " " + ;
		ALLTRIM(STR(INT(100 * (m.g_nCurrentStat / m.g_nMax)))) + "%"
	g_nCurrentStat = m.g_nCurrentStat + 1
RETURN


**************************************************************************
**
** Function Name: DataValue()
** Creation Date: 1997.12.07
** Purpose      : Return a representative value for parameter cDataTypeCode
**
** Parameters:
**
**     cDataTypeCode  A string holding indicating the desired
**                    data type (e.g. "C", "N", "L")
**
** Modification History:
**
**      1997.12.07  SEA         Added to GenDBCX
**************************************************************************
FUNCTION DataValue
	LPARAMETERS cDataTypeCode
	LOCAL cDataValue
	DO CASE
		CASE cDataTypeCode = "C"
			cDataValue = ["A"]
		CASE cDataTypeCode = "N" or cDataTypeCode = "Y"
			cDataValue = [0]
		CASE cDataTypeCode = "L"
			cDataValue = [.F.]
		CASE cDataTypeCode = "D"
			cDataValue = [{}]
		CASE cDataTypeCode = "T"
			cDataValue = [{}]
		OTHERWISE
			cDataValue = [null]
	ENDCASE
	RETURN cDataValue
ENDFUNC

