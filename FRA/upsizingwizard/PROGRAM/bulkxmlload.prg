*==============================================================================
* Function:			BulkXMLLoad
* Purpose:			Performs a SQL Server bulk XML load
* Author:			Doug Hennig
* Last revision:	07/12/2006
* Parameters:		tcAlias    - the alias of the cursor to export
*					tcTable    - the name of the table to import into
*					ttBlank    - the value to use for blank DateTime values
*						(optional: if it isn't specified, 01/01/1900 is used)
*					tcDatabase - the database the table belongs to
*					tcServer   - the SQL Server name
*					tcUserName - the user name for the connection (optional:
*						if it isn't specified, Windows Integrated Security is
*						used)
*					tcPassword - the password for the connection (optional:
*						if it isn't specified, Windows Integrated Security is
*						used)
* Returns:			an empty string if the bulk load succeeded or the text of
*						an error message if it failed
* Environment in:	the alias specified in tcAlias must be open
*					the specified table and database must exist
*					the specified server must be accessible
*					there must be enough disk space for the XML files
* Environment out:	if an empty string is returned, the data was imported into
*						the specified table
*==============================================================================

lparameters tcAlias, ;
	tcTable, ;
	ttBlank, ;
	tcDatabase, ;
	tcServer, ;
	tcUserName, ;
	tcPassword
local lnSelect, ;
	lcAlias, ;
	laFields[1], ;
	lnFields, ;
	lnPos, ;
	ltBlank, ;
	lnI, ;
	lcField, ;
	llClose, ;
	lcSchema, ;
	lcData, ;
	lcReturn, ;
	loException as Exception, ;
	lcXSD, ;
	loBulkLoad
#define SQL_SERVER_EMPTY_DATE {^1900-01-01}

* If there are any date fields in the selected cursor and we're not supposed to
* upsize blank dates as NULL, create a cursor from it with the appropriate
* value for blank dates.

lnSelect = select()
lcAlias  = tcAlias
select (tcAlias)
if not isnull(ttBlank)
	lnFields = afields(laFields)
	lnPos    = ascan(laFields, 'D', -1, -1, 2, 15)
	if lnPos = 0
		lnPos = ascan(laFields, 'T', -1, -1, 2, 15)
	endif lnPos = 0
	if lnPos > 0
		lcAlias = sys(2015)
		select * from (tcAlias) into cursor (lcAlias) readwrite
		ltBlank = iif(vartype(ttBlank) $ 'TD', ttBlank, SQL_SERVER_EMPTY_DATE)
		for lnI = 1 to lnFields
			if laFields[lnI, 2] $ 'TD'
				lcField = laFields[lnI, 1]
				replace (lcField) with ltBlank for empty(&lcField)
			endif laFields[lnI, 2] $ 'TD'
		next lnI
		llClose = .T.
	endif lnPos > 0
endif not isnull(ttBlank)

* Create the XML data and schema files.

lcSchema = forceext(tcTable, 'xsd')
lcData   = forceext(tcTable, 'xml')
try
	cursortoxml(alias(), lcData, 1, 512 + 8, 0, lcSchema)
	lcReturn = ''
catch to loException
	lcReturn = loException.Message
endtry

* If we created a cursor, close it.

if llClose
	use
endif llClose

* Convert the XSD into a format acceptable by SQL Server. Add the SQL
* namespace, convert the <xsd:choice> start and end tags to <xsd:sequence>,
* use the sql:datatype attribute for DateTime fields, and specify the table
* imported into with the sql:relation attribute.

if empty(lcReturn)
	lcXSD = filetostr(lcSchema)
	lcXSD = strtran(lcXSD, ':xml-msdata">', ;
		':xml-msdata" xmlns:sql="urn:schemas-microsoft-com:mapping-schema">')
	lcXSD = strtran(lcXSD, 'IsDataSet="true">', ;
		'IsDataSet="true" sql:is-constant="1">')
	lcXSD = strtran(lcXSD, '<xsd:choice maxOccurs="unbounded">', ;
		'<xsd:sequence>')
	lcXSD = strtran(lcXSD, '</xsd:choice>', ;
		'</xsd:sequence>')
	lcXSD = strtran(lcXSD, 'type="xsd:dateTime"', ;
		'type="xsd:dateTime" sql:datatype="dateTime"')
	lcXSD = strtran(lcXSD, 'minOccurs="0"', ;
		'sql:relation="' + lower(tcTable) + '" minOccurs="0"')
	strtofile(lcXSD, lcSchema)

* Instantiate the SQLXMLBulkLoad object, set its ConnectionString and other
* properties, and call Execute to perform the bulk import.

	try
		loBulkLoad = createobject('SQLXMLBulkLoad.SQLXMLBulkload.4.0')
		lcConnString = 'Provider=SQLOLEDB.1;Initial Catalog=' + tcDatabase + ;
			';Data Source=' + tcServer + ';Persist Security Info=False;'
		if empty(tcUserName)
			lcConnString = lcConnString + 'Integrated Security=SSPI'
		else
			lcConnString = lcConnString + 'User ID=' + tcUserName + ;
				';Password=' + tcPassword
		endif empty(tcUserName)
		loBulkLoad.ConnectionString = lcConnString
*** Can set the ErrorLogFile property to the name of a file to write import
*** errors to
		loBulkLoad.KeepNulls        = .T.
		loBulkLoad.Execute(lcSchema, lcData)
		lcReturn = ''
	catch to loException
		lcReturn = loException.Message
	endtry

* Clean up.

	erase (lcSchema)
	erase (lcData)
endif empty(lcReturn)
select (lnSelect)
return lcReturn
