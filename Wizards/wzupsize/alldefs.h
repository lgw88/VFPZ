*
* Note to localizers: anything that doesn't end with "_LOC" should be left alone
*

*Any given #def may be used in several places; the notes on the
*"location" where it's used is mostly for the developer's benefit

*Constants from ODBC include files, used in chooseDataSource (Step 2)
#DEFINE SQL_FETCH_FIRST					0
#DEFINE SQL_FETCH_NEXT					1
#DEFINE SQL_SUCCESS						0
#DEFINE SQL_NO_DATA						100
#DEFINE SQL_ERROR						-1
#DEFINE SQL_DBMS_NAME					17
#DEFINE SQL_DBMS_VER					18
			
*These are used in wzusz.prg

#DEFINE NO_DISK_SPACE_LOC				"Your computer is out of disk space."
#DEFINE DEVICE_SIZE_UNKNOWN 			-5		
#DEFINE RETRY_CANCEL					5
#DEFINE RETRY_CHOICE					4
#DEFINE RMT_OPERATOR					"?"
#DEFINE NOTHING_DO_LOC					"To finish the Upsizing Wizard, you must choose either to upsize or to save the SQL code generated by the Upsizing Wizard."
#DEFINE CREATE_DBSQL_LOC 				"/* Create database */"
#DEFINE CREATING_DATABASE_LOC 			"Creating database '|1'"
#DEFINE CREATE_DB_FAILED_LOC			"The Upsizing Wizard cannot continue because it was unable to create the database '|1'."
#DEFINE ERROR_COMMENT_LOC				"Unable to create database."
#DEFINE TAKES_AWHILE_LOC				"Server processing.  This may take a while..."
#DEFINE CREATING_TABLES_LOC				"Creating tables"
#DEFINE CANT_DROP2_LOC					"Unable to drop table."
#DEFINE CANT_CREATE_LOC					"Unable to create table."
#DEFINE CANT_CREATE_CLUST_LOC			"Unable to create cluster."
#DEFINE TABLE_NOT_CREATED_LOC			"Your table was not upsized because a table of same name already exists on the server."
#DEFINE CLUST_NOT_CREATED_LOC 			"Cluster '|1' was not created."
#DEFINE CLUST_IDX_FAILED_LOC			"Unable to create cluster index."
#DEFINE THIS_TABLE_LOC					"Table '|1'"
#DEFINE TABLE_SQL_LOC					"Generating table SQL"
#DEFINE CREATING_CLUST_SQL_LOC 			"Generating SQL for clusters"
#DEFINE CREATING_CLUSTERS_LOC 			"Creating clusters"
#DEFINE CLUST_EXISTS_LOC				"The cluster was not created because a cluster of the same name already exists on the server."
#DEFINE CANT_DROP_LOC					"Unable to drop cluster."
#DEFINE THIS_CLUST_LOC					"Creating cluster '|1'"
#DEFINE CLUST_INDEX_PREFIX 				"ic_"
#DEFINE TABLE_EXISTS_LOC	 			"Table '|1' already exists." + CHR(10)+CHR(13)+  "Overwrite?"
#DEFINE YES_LOC							"\<Yes"
#DEFINE YESALL_LOC						"Yes to \<All"
#DEFINE NO_LOC							"\<No"
#DEFINE CLUSTER_EXISTS_LOC			 	"Cluster '|1' already exists." + CHR(10)+CHR(13)+  "Drop cluster, all tables and their" + ;
										CHR(10)+CHR(13) + "relations?"
#DEFINE SEND_DATA_LOC 					"Sending data"
#DEFINE ERRT_LOC						"DErrTbl"
#DEFINE DATA_PROC_NAME					"rwf_insert_"
#DEFINE STARTING_COMMENT_LOC			"Creating indexes"
#DEFINE TOO_MANY_FIELDS_LOC				"The number of fields in the local index exceeds the maximum allowed by the server."
#DEFINE INDEX_FAILED_LOC				"Unable to create index."
#DEFINE TABLE_NOT_EXPORTED_LOC			"Unable to create index because the table was not successfully upsized."
#DEFINE CANT_CREATE_INDEX_LOC			"Unable to create index because the indexes are not supported on bit columns."
#DEFINE ANALYZING_INDEXES_LOC			"Analyzing local indexes..."
#DEFINE SPROC_ERR_LOC					"Error creating stored procedure from validation rules."
#DEFINE DEFA_ERR_LOC					"Error creating default."
#DEFINE DRI_ERR_LOC						"Error creating referential integrity constraint."
#DEFINE TRIG_ERR_LOC					"Error creating trigger."
#DEFINE GETTING_INFO_LOC 				"Retrieving device information from '|1'..."
#DEFINE NEW_DEVICE_TOKEN_LOC 			"<Create new device...>"
#DEFINE NEW_CLUSTER_TOKEN_LOC 			"<Create new cluster...>"
#DEFINE DEFAULT_LOC						"Default"
#DEFINE DEVICE_SCRIPT_COMMENT_LOC		"/* Create device */"
#DEFINE CANT_CREATE_DEVICE_LOC			"The Upsizing Wizard cannot continue because it it is unable to create a new device."
#DEFINE SQS_ERR_DISK_INIT_FAIL  		5123		&&May occur if duplicate device name used
#DEFINE ALL_DONE_LOC					"Upsizing complete."
#DEFINE TITLE_TEXT_LOC					"Upsizing Wizard"
#DEFINE CREATING_DBDEVICE_LOC			"Creating database device"
#DEFINE CREATING_LOGDEVICE_LOC			"Creating log device"
#DEFINE DEVICE_ERR_COMMENT_LOC			"Unable to create device."
#DEFINE CONNECT_FAILURE_LOC				"Upsizing cannot continue because a connection error occurred.  Error |1."
#DEFINE FAIL_SCRIPT_LOC					"Continue generating SQL code anyway?"
#DEFINE QUERY_FAILURE_LOC				"The Upsizing Wizard cannot continue because a server query failed.  Server error |1."
#define LOCAL_SUFFIX_LOC 				"_local"
#DEFINE ANALYZING_FIELDS_LOC			"Analyzing tables selected for export..."
#DEFINE OPENED_EXCLUSIVE				108
#DEFINE EXCLUSIVE_LOC					"The table '|1' has been opened exclusively by another user.  The Wizard cannot upsize this table."
#DEFINE TABLE_DELETED_LOC				"The Upsizing Wizard cannot locate the table '|1'.  This table will not be upsized."
#DEFINE TABLE_DELETED					1
#DEFINE DUP_CLUSTNAME_LOC 				"The cluster name '|1' is already being used."
#DEFINE ONE_CLUSTER_LOC					"A table can only be in one cluster.  The table '|1' is already in the cluster '|2'."
#DEFINE IDX_NOT_CREATED_LOC				"Field '|1' changed to datatype that does not support indexes."
#DEFINE CANT_DROP_DEFA_LOC 				"Unable to drop existing default"
#DEFINE CANT_DROP_SPROC_LOC 			"Unable to drop existing stored procedure."
#DEFINE INVALID_SQL_LOC					"Unable to convert local expression to server syntax."
#DEFINE ORA_TRIG_PRE_LOC				"Trig_"
#DEFINE CONVERT_STEM_LOC				"Converting"
#DEFINE CONVERT_RULE_LOC				" validation rules "
#DEFINE AND_LOC							"and"
#DEFINE CONVERT_DEFAS_LOC				" defaults"
#DEFINE FTRIG_COMMENT_LOC 				"FIELD VALIDATION RULE FOR '|1'"
#DEFINE TTRIG_COMMENT_LOC 				"TABLE VALIDATION RULE"
#DEFINE TRIG_NAME 						"_test"
#DEFINE TBL_SPROC_PREFIX				"vrt_"
#DEFINE FLD_SPROC_PREFIX				"vrf_"
#DEFINE DEFLT_FLDMSG_LOC 				"Value in '|1' violates column validation rule on table '|2'."
#DEFINE DEFLT_TBLMSG_LOC 				"Value violates table validation rule on table '|1'."
#DEFINE DEFAULT_PREFIX 					"Dflt_"
#DEFINE ZERO_DEFAULT_NAME 				"UW_ZeroDefault"
#DEFINE FOREIGN_KEY_PREFIX				"fk_"
#DEFINE PRIMARY_KEY_PREFIX				"pk_"
#DEFINE TABLE_HAS_LOC 					"table has"
#DEFINE TABLES_HAVE_LOC 				"tables have"
#DEFINE TWO_LONGS_WRONG_LOC 			"Oracle allows only one field of type LONG or LONG RAW per table.;
The field '|1' currently has one of these data types."

#DEFINE LONG_TYPE_LOC 					"|1 |2 more than one memo or general field.  Server limits ;
require that some of these fields be mapped to fixed-length data types." + CHR(10)+CHR(13)+CHR(10)+ CHR(13)+ ;
"Data in some fields might exceed these lengths.  You can change this mapping in Step 4 or choose cancel ;
and then redesign your tables as needed." + CHR(10)+CHR(13)+CHR(10)+ CHR(13)+ ;
"If you are having trouble upsizing data, make sure to set Null mapping on Upsizing Options step to General and Memo field override."

*User-defined error numbers for RI triggers (same as Access Upsizing Wizard)
#DEFINE ERR_SVR_RULEVIO_SQL				"44444"
#DEFINE ERR_SVR_DELREFVIO	 			"44445"
#DEFINE ERR_SVR_UPDREFVIO				"44446"
#DEFINE ERR_SVR_INSREFVIO 				"44447"
#DEFINE ERR_SVR_DELREFVIO_ORA			"-20002"
#DEFINE ERR_SVR_UPDREFVIO_ORA			"-20003"
#DEFINE ERR_SVR_INSREFVIO_ORA			"-20004"
#DEFINE ERR_SVR_RULEVIO_ORA				"-20001"
#DEFINE	DEPENDENT_ROWS_LOC				"Cannot delete or change record.  Referential integrity rules would be violated because related records exist in table '|1'."
#DEFINE	CANT_ORPHAN_LOC 				"Cannot add or change record.  Referential integrity rules require a related record in table '|1'."
#DEFINE KEYS_MISMATCH_LOC				"Unequal number of fields in primary and foreign keys."
#DEFINE MULTIPLE_PKEYS_LOC				"Table '|1' is in multiple relationships using different primary keys.  This is not supported by Oracle."
#DEFINE REC_COUNT_VAR					"RecordCount"

*Constant comments for trigger code
#DEFINE PREVENT_M_UPDATES_LOC			"PREVENT UPDATES IF DEPENDENT RECORDS IN '|1'"
#DEFINE PREVENT_DELETES_LOC 			"PREVENT DELETES IF DEPENDENT RECORDS IN '|1'"
#DEFINE CASCADE_DELETES_LOC				"CASCADE DELETES TO '|1'"
#DEFINE CASCADE_UPDATES_LOC				"CASCADE UPDATES TO '|1'"
#DEFINE	PREVENT_INSERTS_LOC				"PREVENT INSERTS IF NO MATCHING KEY IN '|1'"
#DEFINE	PREVENT_C_UPDATES_LOC			"PREVENT UPDATES IF NO MATCHING KEY IN '|1'"

*Oracle comments
#DEFINE ORA_PKEY_COMMENT_LOC			"/* Add primary key for referential integrity */"
#DEFINE ORA_FKEY_COMMENT_LOC			"/* Add foreign key for referential integrity */"

*Thermometer comments
#DEFINE BUILDING_RI_LOC					"Generating referential integrity SQL"
#DEFINE RI_THIS_LOC						"Tables '|1' and '|2'"

#DEFINE UTRIG_PREFIX					"TrigU_"
#DEFINE DTRIG_PREFIX 					"TrigD_"
#DEFINE ITRIG_PREFIX 					"TrigI_"
#DEFINE ORA_BIUD_TRIG_PREFIX			"Trig_BIUD_"
#DEFINE ORA_AUD_TRIG_PREFIX				"Trig_AUD_"
#DEFINE ORA_CONST_TAB_PREFIX			"Const_Tab_"
#DEFINE ORA_CONST_COL_PREFIX			"Const_Col_"
#DEFINE TBLRULE_COMMENT_LOC				"/* TABLE VALIDATION RULE */" + CHR(10)
#DEFINE FLDRULE_COMMENT_LOC				"/* FIELD VALIDATION RULE FOR '|1' */" + CHR(10)
#DEFINE	ROLLBACK_LOC					"/* ROLLBACK THE TRANSACTION IF ANYTHING FAILED */"
#DEFINE	STATUS_COMMENT_LOC				"/* USED BY VALIDATION STORED PROCEDURES */"
#DEFINE CREA_TRIGGERS_LOC				"Creating triggers"
#DEFINE UPDATE_PROP_FAILED_LOC			"Unable to set the 'SendUpdates' property."
#DEFINE TABLES_PROP_FAILED_LOC			"Unable to set the 'Tables' property."
#DEFINE KEYFIELD_PROP_FAILED_LOC		"Unable to set Keyfield property on '|1'."
#DEFINE UPDATABLE_PROP_FAILED_LOC 		"Unable to set Updatable property on '|1'."
#DEFINE CONN_NAME_LOC					"Upsize"
#DEFINE NO_UNIQUEKEY_LOC				"Unable to make view updatable because no primary or candidate index exists on local table."
#DEFINE NEWDB_NAME_LOC					"Upsize"
#DEFINE ERROR_NAME_LOC 					"Errors_uw"
#DEFINE MISC_NAME_LOC					"Misc_uw"
#DEFINE FIELD_NAME_LOC					"Fields_uw"
#DEFINE TABLE_NAME_LOC					"Tables_uw"
#DEFINE REL_NAME_LOC					"Relationships_uw"
#DEFINE VIEW_NAME_LOC					"Views_uw"
#DEFINE INDEX_NAME_LOC 					"Indexes_uw"
#DEFINE SCRIPT_NAME_LOC					"SQL_uw"
#DEFINE NEWPROJ_NAME_LOC 				"Report"
#DEFINE ERR_REPORT_LOC 					"RptErrs"
#DEFINE FIELDS_REPORT_LOC 				"RptField"
#DEFINE INDEX_REPORT_LOC 				"RptIndex"
#DEFINE RELS_REPORT_LOC 				"RptRels"
#DEFINE TABLES_REPORT_LOC 				"RptTable"
#DEFINE VIEWS_REPORT_LOC 				"RptViews"
#DEFINE BUILDING_REPORT_LOC				"Creating upsizing report"
#DEFINE BUILDING_SCRIPT_LOC				"Creating SQL script"

#DEFINE CLUST_COMMENT_LOC				"Create cluster '|1'"
#DEFINE CLUST_INDEX_LOC					"Create cluster index for cluster '|1'"
#DEFINE TABLE_COMMENT_LOC				"Create table '|1'"
#DEFINE TRIGGER_COMMENT_LOC				"/* Trigger code */"
#DEFINE INDEX_COMMENT_LOC				"/* Index code */"
#DEFINE DEFAULT_COMMENT_LOC				"/* Default code */"
#DEFINE SPROC_COMMENT_LOC				"/* Stored procedure code */"
#DEFINE INVALID_NAME_LOC 				"The name you entered isn't legal.  Please enter a new name or accept the name provided."
#DEFINE SEP_CHARACTER					"_"
#DEFINE MAX_DOSNAME_LEN					8
#DEFINE MAX_FIELDNAME_LEN				128
#DEFINE MAX_INDEX_FIELDS				16
#DEFINE ICON_EXCLAMATION				48
#DEFINE ICON_QUESTMARK					32
#DEFINE KEEP_GOING						6
#DEFINE MAX_NAME_LENGTH					30
#DEFINE YES_NO_BUTTONS					4
#DEFINE USER_YES						6
#DEFINE SUCCESS 						1
		
		
*These are used in the upsizing wizard formset class
#define STEP1_LOC	'Step 1 - Select Local Database'
#define STEP2_LOC	'Step 2 - Select Data Source'
#define STEP3_LOC	'Step 3 - Choose Tables'
#define STEP4_LOC	'Step 4 - Map Field Data Types'

* Sql Server specific steps
#define STEP5_S_LOC	'Step 5 - Select Target Database'
#define STEP6_S_LOC	'Step 6 - Set Database Properties'
#define STEP7_S_LOC	'Step 7 - Specify Log Properties'
#define STEP8_S_LOC 'Step 8 - Set Upsizing Options'
#define STEP9_S_LOC 'Step 9 - Finish'

* Oracle specific steps
#define STEP5_O_LOC 'Step 5 - Select Tablespaces'
#define STEP6_O_LOC 'Step 6 - Select Tablespace Files'
#define STEP7_O_LOC 'Step 7 - Specify Cluster Information'
#define STEP8_O_LOC 'Step 8 - Specify Cluster Tables'
#define STEP9_O_LOC 'Step 9 - Specify Cluster Key Fields'
#define STEP10_O_LOC 'Step 10 - Set Upsizing Options'
#define STEP11_O_LOC 'Step 11 - Finish'


#define DESC1_LOC 'Which local database do you want to upsize?'
#define DESC2_LOC 'Which data source do you want to upsize your database to?'
#define DESC3_LOC 'Select a database on the remote server that you want to upsize' + ;
				  ' to, or click New and name the new database.'
#define DESC4_LOC 'Which device do you want to store the new database on, and how much' + ;
				  ' space do you want to allocate for it?' + ;
			CHR(13) + CHR(10) + CHR(13) + CHR(10) + ;
			'SQL Server requires a minimum of 2MB per database.'
#define DESC5_LOC 'What are the properties for your optional tansaction log?' + ;
			CHR(13) + CHR(10) + CHR(13) + CHR(10) + ;
			'You can specify the device and allocate space for the log.'
#define DESC6_LOC 'Which tables do you want to upsize to the target database?'
#define DESC7_LOC 'Do you want to change the default mapping from local data types to server data types?' + ;
			CHR(13) + CHR(10) + CHR(13) + CHR(10) + ;
			'To change a server data type, select a table, click the Server Type column for the field you want to change, and then select a data type.'
#define DESC8_LOC 'Which upsizing option do you want to set?' + ;
			CHR(13) + CHR(10) + CHR(13) + CHR(10) + ;
			'You can set the table attributes you want to upsize and make local changes that optimize' + ;
			' using the remote data?'
#define DESC9_LOC 'Select the tablespaces you want to upsize to.'
#define DESC10_LOC 'Which data files do you want to add to the tablespaces?'
#define DESC11_LOC 'Upsize and/or create SQL scripts.'
#define DESC12_LOC 'Which cluster objects do you want to create?' + ;
				CHR(13) + CHR(10) + CHR(13) + CHR(10) + ;
				'Clusters group together related tables; tables in the same cluster will share a common cluster key'
#define DESC13_LOC 'Which tables do you want to include in clusters?' + ;
				CHR(13) + CHR(10) + CHR(13) + CHR(10) + ;
				'Select a cluster, and then select an available table.' + ;
				CHR(13) + CHR(10) + ;
				'To add related tables, click Default. To look for potential cluster keys, select tables and click Verify.'
#define DESC14_LOC 'Which fields do you want to include in the cluster key?' + ;
				CHR(13) + CHR(10) + ;
				'Select a cluster and a table. The set of fields you select from the table become the pattern for the cluster key.'

#define CAPTION_UW 'Upsizing Wizard'
#define CAPTION_ORACLE 'Oracle Upsizing Wizard'
#define CAPTION_SQL 'SQL Server Upsizing Wizard'
#define CAPTION_ODBC 'Upsizing Wizard - ODBC Server'

#DEFINE GETTING_SERVER_DBS_LOC 			"Retrieving names of databases on '|1'..."
#DEFINE NEW_CLUSTERNAME_LOC 			"Name of new cluster:"
#DEFINE HASH_CAPTION_LOC 				"Please enter value for hashkeys or accept default."
#DEFINE DONT_EXPORT 					7
#DEFINE YES_NO_CANC_BUTTONS				3
#DEFINE DONT_INDEX						6
#DEFINE CASCADE							6
#DEFINE TYPE_INDEX						1

#DEFINE TABLE_IN_CLUSTER_LOC 			"The table '|1' is part of cluster '|2'.  If you don't export ;
'|1', this cluster will not be created." + CHR(13)+CHR(10)  ;
+ CHR(13)+CHR(10)+"Do you want to export table '|1'?"

#DEFINE CASCADE_TYPE_CHANGE_LOC			 "'|1' is a key field in one or more relationships.  You may ;
want to change the related key fields to the same datatype as '|1'."

#DEFINE IN_INDEX_LOC					"The datatype '|2' does not support indexing.  The field '|1' is ;
in one or more indexes.  These will not be created if you change the field's datatype to '|2'." + ;
CHR(10)+ CHR(13) + CHR(10) + CHR(13) + "Continue?"

#DEFINE NO_NO_LOC						"The datatype '|2' does not support indexing.  ;
Because '|1' is a key field, this change is not allowed."


*From the ChooseDataSource class
#DEFINE NO_DATASOURCES_DEFINED_LOC "(No datasources defined)"
#DEFINE NO_CONNDEFS_DEFINED_LOC 	"(No connections defined)"
#DEFINE DELETE_DEVICE_INFO_LOC		"If you change your datasource, you will lose some information you already provided the wizard." + CHR(10) + CHR(13) + CHR(10) + CHR(13) + "Continue?"
#DEFINE LOG_IN_FAILED_LOC 			"Unable to connect to '|1'."
#DEFINE CHECK_PERMS_LOC				"Server processing..."
#DEFINE SQLCONN_FAIL_LOC			"An error occurred connecting to '|1'."
#DEFINE ODBC 						1
#DEFINE ORA_NOT_COOL_LOC			"The Upsizing Wizard does not support Oracle 6."
#DEFINE NO_USERID_LOC 				"You do not have an account on '|1'."

*From the ChooseSourceDB class
#DEFINE NO_DBS_LOC 					"<No database open>"
#DEFINE NO_SUCH_FILE_LOC	 		"File does not exist."
#DEFINE LOCATE_LOC					"Locate: |1"

#DEFINE DUMP_ANALYSIS_INFO_LOC	"You have changed the database ;
you are upsizing.  If you continue, the tables you chose to ;
upsize will be reset." + CHR(10) + CHR(13) + CHR(10) + CHR(13)+ "Continue?"

*From the ChooseTargetDB class
#DEFINE EXISTING 					1
#DEFINE NEW_DB 						2
#DEFINE CANT_CONNECT_LOC			"You do not have an account on the database '|1'."
#DEFINE DUPLICATE_DBNAME_LOC 		"The database '|1' already exists.  Please enter a different name."
#DEFINE NEW_LBL_DESC_LOC 			"New database name:"
#DEFINE EXISTING_LBL_DESC_LOC 		"Available databases on '|1':"
#DEFINE REALLY_CHANGE_TARGET_LOC	"Discard device information for new database?"

*From the device class
#DEFINE DB_OR_LOG_TOO_BIG_LOC 		" size exceeds free space on selected device."
#DEFINE DATABASE_LOC				"Database"
#DEFINE LOG_LOC						"Log"
#DEFINE DEVICE_TOO_BIG_LOC			" device size exceeds available server disk space."
#DEFINE DB_TOO_SMALL_LOC			"The database size you set needs to be 2 megabytes or larger."
#DEFINE SAME_DEVICE_LOC				"Both the database and log are on the same device.  Their combined size exceeds the free space on the selected device."
#DEFINE DVCS_BOTH_TOO_BIG_LOC		"The combined size of the new devices you are creating exceeds available server disk space."
#DEFINE DEVICE_THING_LOC			"The |1 device is part of the 'Default' device chosen for the |2.  Together, the log and database cannot exceed the size of the 'Default' device."
#DEFINE DEVICE_AMBIGUITY_LOC		"The Upsizing Wizard cannot put the database on the 'Default' device and the log on a device that's part of the 'Default' device."
#DEFINE DISK_UNITS_LOC 				" MB"
#DEFINE DB_SIZE_LOC 				"Database Size: "
#DEFINE LOG_SIZE_LOC				"Log Size: "
#DEFINE DB_DEVICE_CAPTION_LOC		"Database Device:"
#DEFINE LOG_DEVICE_CAPTION_LOC		"Log Device:"
#DEFINE NO_DEVICE_NUMBERS_LOC 		"The server has no more device numbers available."
#DEFINE NEW_DEVICE_NAME_LOC 		"New device name:"
#DEFINE NO_DEVICE_PERM_LOC			"You must be a system administrator to create a new device."
#DEFINE USER_DEVICE 				-1			
#DEFINE OK_BUTTON					0

#DEFINE ERR_TBL_PREFIX_LOC			"ExportErrors_"
#DEFINE ERROR_COUNT_LOC				"errors"
#DEFINE DATA_ERR_FRACTION			.1
#DEFINE DATA_ERR_MIN				100
#DEFINE DATA_ERRORS_LOC				"Errors occurred during upsizing.  Would you like to save the tables containing error information?"

#DEFINE LOG_FULL_LOC			"The Upsizing Wizard cannot continue because the log is full."
#DEFINE DEVICE_FULL_LOC			"The Upsizing Wizard cannot continue because the database device is full."
#DEFINE SQL_BUG_LOC				"Someone has dropped a device on the server.  The server must be restarted before you can create any more devices."
#DEFINE VERS_NOT_SUPPORTED_LOC 	"The Upsizing Wizard does not support SQL Server version 1.x"
#DEFINE NO_CREATEDB_PERM_LOC	"The Upsizing Wizard cannot continue because you do not have CREATE DATABASE permissions on '|1'."
#DEFINE PREVENT_SELF_O_LOC		"PREVENT INSERTS AND UPDATES IF NO MATCHING KEY IN '|1'"
#DEFINE AVAIL_DSOURCE_LOC		"Available Data Sources:"
#DEFINE CONNS_INDB_LOC			"Existing Connections:"
#DEFINE LOG_SIZE_CAPT_LOC		"Log Size:"


#DEFINE UNKNOWN_SERV_ERROR		"The Upsizing Wizard cannot continue because server error '|1' occurred."
#DEFINE LACKING_PERMS_LOC		"With your permissions on the database '|1' the Upsizing Wizard will be unable to "
#DEFINE OR_LOC					" or "

#DEFINE CANT_CREATE_TABLE		"create tables"
#DEFINE CANT_CREATE_DEFAS		"create defaults" 
#DEFINE CANT_CREATE_SPROCS		"create stored procedures"

#DEFINE RMTZING_VIEW_LOC		"Redirecting local views"
#DEFINE RMTZING_TABLE_LOC		"Creating remote views based on tables"

#DEFINE CANT_CREATE_INDEX		"create indexes"
#DEFINE CANT_CREATE_TRIGGER		"create triggers"

#DEFINE THIS_VIEW_LOC			"View '|1'"

#DEFINE DEXPORT_FAILED_LOC		"Data export halted because of export errors."
#DEFINE SOME_ERRS_LOC			"|1 records not exported successfully."
#DEFINE DATA_EXPORT_LOC			"Data export"
#DEFINE CLUSTER_LOC				"Cluster"
#DEFINE TABLE_LOC				"Table"
#DEFINE TRIGGER_LOC				"Trigger"
#DEFINE DEFAULT_LOC				"Default"
#DEFINE TABLE_RULE_LOC			"Table validation rule"
#DEFINE FIELD_RULE_LOC			"Field validation rule"
#DEFINE RI_LOC					"Referential integrity"
#DEFINE INDEX_LOC				"Index"
#DEFINE RECORD_EXP_LOC			"Data export"
#DEFINE CONVTO_TRIG_ERR_LOC		"Unable to convert rule to trigger."
#DEFINE RECCOUNT_LOC			"records exported"
#DEFINE CANCELED_LOC			"Canceled"
#DEFINE PREP_ERR_LOC			"Storing error information."
#DEFINE SCRIPT_INDB_LOC			"Creating database and project for generated SQL."
#DEFINE PREP_ERRTBLS_LOC		"Storing error information."
#DEFINE ESCAPE_CONT_LOC			"Cancel Upsizing Wizard?"

#DEFINE RMTIZE_VIEW_FAILED_LOC	"Local view not converted to remote view."
#DEFINE VIEW_LOC				"View"
#DEFINE VIEW_PROPS_FAILED_LOC	"Setting of properties on remote views failed."
#DEFINE FATAL_ODBCERR_LOC		"The Upsizing Wizard cannot continue because an ODBC error has occurred."
#DEFINE CANT_OPENDB_LOC			"Unable to open '|1'."
#DEFINE F_ACC_DENIED_LOC		"File access denied."
#DEFINE DEVICE_STUFF_FAILED_LOC	"The Upsizing Wizard cannot continue because it was unable to retrieve device information."
#DEFINE cascade_char_loc 		"C"
#DEFINE restrict_char_loc 		"R"
#DEFINE ignore_char_loc			"I"

#DEFINE NO_OPEN_EXCLU_LOC		"The Upsizing Wizard was not able to open all database tables.  These will not be available for upsizing.  You may want to run the VALIDATE DATABASE command on your database."

#DEFINE BIND_DEFAS_LOC			"Binding defaults to bit fields"
#DEFINE ZD_DESC_LOC				"/* This zero default is bound to one or more fields.  */"

#DEFINE NO_MULTIPLE_LOC 		gcQT + "|1 affecting multiple records in '|2' not allowed because of referential integrity constraints."  + gcQT
#DEFINE NO_MULTI_TITLE_LOC 		"PREVENT |1 AFFECTING MULTIPLE RECORDS"
#DEFINE UPDATES_LOC 			"UPDATEs"
#DEFINE DELETES_LOC				"DELETEs"

#define KP_BACKSPACE	127
#define KP_TAB			9
#define KP_ENTER		13
#define KP_ESCAPE		27
#define KP_LEFTARROW	19
#define KP_RIGHTARROW	4
#define KP_UPARROW		5
#define KP_DOWNARROW	24
#define KP_DELETE		7
#define KP_HOME			1
#define KP_END			6
#define KP_INSERT		22

#define KP_SHIFT_HOME	55
#define KP_SHIFT_END	49
#define KP_SHIFT_TAB	15

#define KP_BACKTAB				15
#define KP_ESCAPE				27
#define KP_NEXT					305
#define KP_BACK					304
#define KP_FINISH				289

#DEFINE SUPPORT_ORACLE			.T.

#DEFINE NEW_DIRNAME_LOC			"Upsize"
#DEFINE REQ_PROVERSION_LOC 		"The Upsizing Wizard requires the Professional edition of Visual FoxPro."

#DEFINE MAX_FIELDS				255
#DEFINE MIN_DEVICESIZE_LOC		"You must set the size of the device to 2 megabytes or larger."

#DEFINE SQL_ALLOCERR_LOC		"The Upsizing Wizard cannot continue because ODBC could not be started."

#DEFINE NO_ODBC_LOC				"The Upsizing Wizard requires ODBC, which is not currently installed."

* For Advanced Export Options class (jvf)
#DEFINE VIEW_PREFIX_REQD_LOC       "You must supply a prefix for the view name, or choose None."
#DEFINE VIEW__NAME_SUFFIX_REQD_LOC "You must supply a suffix for the view name, or choose None."
#DEFINE DROP_TABLE_WARNING_LOC "You have chosen to Drop Local Tables! " + ;
		"You should make sure you have a recent backup of the local database before completing the Wizard."
#DEFINE VIEW_NAME_DUPE_SUFFIX_LOC LOCAL_SUFFIX_LOC + " is the default suffix the Upsizng Wizard uses when renaming local tables. " + ;
		"You must either change this suffix or choose to Drop Local Tables."

* For checking if ODBC is installed
#DEFINE DLLPATH_32S				"\SYSTEM\WIN32S\"
#DEFINE DLLPATH_NT				"\SYSTEM32\"
#DEFINE DLLPATH_WIN95			"\SYSTEM\"
#DEFINE DLL_ODBC				"ODBC32.DLL"

#DEFINE NOT_EXCLUSIBLE_LOC		"Databases which are not opened exclusively will not be available for upsizing."

#DEFINE NEED_SQL6DRVR_LOC		"To upsize to SQL Server 6.x, please install a SQL Server ODBC driver version 2.05 or later."

#DEFINE TIMESTAMP_LOC			"Timestamp_column"
#DEFINE FIELDS_UNEQUAL_LOC		"Unable to set field properties because remote and local views have an unequal number of fields."


#DEFINE	CANT_OPEN_EXCLU_LOC		"Unable to open '|1' exclusively."

#DEFINE DB_GONE_LOC				"The database '|1' in the selected connection definition no longer exists.  Please choose a different definition."
#DEFINE SQL_SERVER				"SQL Server"
#DEFINE ORACLE_SERVER			"Oracle"
#DEFINE MS_SERVER				"MS"
#DEFINE UNKNOWN_SERVER			""

#DEFINE KB_LABEL				"  KB"
#DEFINE CREATING_TABLESPACE_LOC 			"Creating tablespace '|1'"
#DEFINE NO_CREATETS_PERM_LOC	"The Upsizing Wizard cannot continue because you do not have CREATE TABLESPACE permissions on '|1'."
#DEFINE CREATE_TS_FAILED_LOC	"The Upsizing Wizard cannot continue because it was unable to create the tablespace '|1'."
#DEFINE CREATE_TSSQL_LOC 		"/* Create tablespace */"

#DEFINE CLUSTER_TABLE_F_LOC		"Verification failed. Tables selected for cluster '|1' cannot have a common key"
#DEFINE CLUSTER_TABLE_T_LOC		"Verification succeded. Tables selected for cluster '|1' may have a common key"
#DEFINE CLUSTER_KEY_F_LOC		"Verification failed. Cluster key for cluster '|1' is not consistent across cluster tables"
#DEFINE CLUSTER_KEY_T_LOC		"Verification succeded. Cluster key for cluster '|1' is consistent across cluster tables"
#DEFINE CANT_PERMISSION_LOC		"Unable to retrive permissions"

#DEFINE INVALID_SERVER_LOC		"Server type is not '|1'. Select another datasource."
#DEFINE CL_LOC					"cl_"
#DEFINE IDENTCOL_LOC			"Identity_column"
#DEFINE CANT_UPSIZE_LOC			"Table '|1' may not be upsized:"
#DEFINE EXCEED_FIELDS_LOC		"the number of fields exceed 250"
#DEFINE EXCEED_RECSIZE_LOC		"the record size exceed 1962"
#DEFINE CANTDEFCLUSTERS_LOC		"Unable to create default clusters. No relations between tables were found."
#DEFINE CANTUPSIZE_TABLE_LOC	"The Upsizing Wizard was unable to upsize tables: "

*Oracle permissions
#DEFINE LACKING_PERMS_ORA		"You don't have the following permissions that may be required by the Upsizing Wizard: "

#DEFINE CANT_CREATE_OTABLE_LOC	"CREATE TABLE"
#DEFINE CANT_CREATE_TABLESPACE_LOC	"CREATE TABLESPACE"
#DEFINE CANT_ALTER_TABLESPACE_LOC	"ALTER TABLESPACE"
#DEFINE CANT_UNLIMITED_TS_LOC	"UNLIMITED TABLESPACE"
#DEFINE CANT_CREATE_OCLUST_LOC	"CREATE CLUSTER"
#DEFINE CANT_CREATE_ORAINDEX_LOC "CREATE ANY INDEX"
#DEFINE CANT_CREATE_TRIGGER_LOC	"CREATE TRIGGER"
#DEFINE CANT_CREATE_OPROC_LOC	"CREATE PROCEDURE"

#DEFINE NO_SQL7UPSIZEMASTER_LOC	"The Upsizing Wizard does not support upsizing to the SQL Server 7.0 Master database."
* #DEFINE NO_SQL7BADCOMPLEVEL_LOC "The Upsizing Wizard could not set the SQL Server 7.0 database to proper compatibility level for upsizing."

#define NO_SQL7BADCOMPLEVEL_LOC "The Upsizing Wizard could not set the SQL Server database to proper compatibility level for upsizing." + CHR(10) + CHR(10) + ;
 "In order to upsize, Visual FoxPro must set the compatibility level of the target SQL database to 6.5." + CHR(10) + CHR(10) + ;
 "This is done by calling the sp_dbcmptlevel stored procedure on SQL Server." + ;
 "  Only the DBO, members of the sysadmin fixed server role, and the db_owner fixed " + ;
 "database role (if the database whose compatibility level is to be changed is the " + ;
 "current database) can execute this procedure." + CHR(10) + CHR(10) + ;
 "Please ensure the SQL login you are " + ;
 "using has the appropriate rights to perform this action."

 
#DEFINE NO_SQL7NONEWDB_LOC "The Upsizing Wizard does not support creation of new databases for SQL Server 7.0 or higher." 