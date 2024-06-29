*Class Hierarchy ---
* CursorAdapter
*    MyAbstractCursorAdapter
*    	SQLNorthwind
*		SQLADONorthwind
*		VFPADONorthwind
*       VFPNorthwind 
*       	CustomerDataSource 
*           SupplierDataSource 
*           ProductDataSource
*           OrderDataSource 
*			OrderDetailDataSource 

**********************************************************************
DEFINE CLASS SQLNorthwind as MyAbstractCursorAdapter
**********************************************************************
*-- SQL Server Data - Inherit from this class for SQL Server Northwind
*---------------------------------------------------------------------
	Name				= "SQLNorthwind"
	DataSourceType		= "ODBC"
	cConnectionString 	= "Driver={SQL Server};Server=localhost;Uid=sa;Pwd=;Database=northwind"
		
ENDDEFINE

**********************************************************************
DEFINE CLASS VFPNorthwind AS MyAbstractCursorAdapter 
**********************************************************************
*-- Local VFP Data - Inherit from this class for local Northwind.DBC
*---------------------------------------------------------------------
	Name			= "VFPNorthwind"
	DataSourceType	= "NATIVE"
	DataSource		= "C:\PROGRAM FILES\MICROSOFT VISUAL FOXPRO 8\SAMPLES\Northwind\Northwind.dbc"
	
ENDDEFINE

********************************************************************************
DEFINE CLASS SQLADONorthwind as MyAbstractCursorAdapter
********************************************************************************
*-- SQL Server Data - Inherit from this class for SQL Server Northwind Using ADO
*-------------------------------------------------------------------------------
	Name				= "SQLADONorthwind"
	DataSourceType		= "ADO"
	cConnectionString 	= "Provider=SQLOLEDB.1;Data Source=localhost;User Id=sa;Password=;Initial Catalog=northwind"
			
ENDDEFINE

********************************************************************************
DEFINE CLASS VFPADONorthwind as MyAbstractCursorAdapter
********************************************************************************
*-- Visual FoxPro Data - Inherit from this class for VFP Northwind Using ADO
*-------------------------------------------------------------------------------
	Name				= "VFPADONorthwind"
	DataSourceType		= "ADO"
	cConnectionString 	= "Provider=VFPOLEDB.1;Data Source=C:\PROGRAM FILES\MICROSOFT VISUAL FOXPRO 8\SAMPLES\Northwind\Northwind.dbc;SourceType=DBC"
		
ENDDEFINE


********************************************************
DEFINE CLASS CustomerDataSource as SQLNorthwind 
********************************************************

	Alias 			= "Customer"
	Tables 			= "CUSTOMERS"	
	KeyFieldList	= "CUSTOMERID"
	
	
	*---------------------------------------------------
	FUNCTION GetCustomerByID(cID as String)  As Boolean 
	*---------------------------------------------------	
		This.SelectCmd = "Select * From Customers Where CustomerID = '" + ALLTRIM(cID) + "'"

		RETURN This.CreateCursorFromBackend()
	ENDFUNC

	*---------------------------------------------------
	FUNCTION GetCustomersByCountryName(cName as String) As Boolean 
	*---------------------------------------------------	
				
		This.SelectCmd = "Select * From Customers Where UPPER(Country) LIKE '" + ;
						ALLTRIM(UPPER(cName)) + "%'"

		RETURN This.CreateCursorFromBackend()
	ENDFUNC
	
	
	*-------------------------------------------------
	PROTECTED FUNCTION ValidateCursor() 
	*-------------------------------------------------
	
		LOCAL llRetVal as Boolean 
		LOCAL lcMsg as String
		lcMsg = ""
		lcAlias = This.Alias	
		llRetVal = .T.
		
		SELECT(lcAlias)
		SCAN 
			IF EMPTY(CompanyName) OR ISNULL(CompanyName)
				lcMsg = lcMsg + "Customer: " + ALLTRIM(CustomerID) + " - Company name cannot be empty." + CHR(13)+CHR(10)
				llRetVal = .F.
			ENDIF
		ENDSCAN
		
		IF lcMsg != "" 
			*-- Validation failed. Throw the messages to the client.
			THROW lcMsg
		ENDIF	
		
		RETURN llRetVal
		
	ENDFUNC
	
		
ENDDEFINE

********************************************************
DEFINE CLASS SupplierDataSource as SQLNorthwind 
********************************************************

	Alias 			= "Supplier"
	Tables 			= "SUPPLIERS"
	KeyFieldList	= "SUPPLIERID"
	
	*----------------------------------
	FUNCTION GetSuppliers() As Boolean 
	*----------------------------------
		
		This.SelectCmd = "Select * From Suppliers"

		RETURN This.CreateCursorFromBackend()
	ENDFUNC

ENDDEFINE

********************************************************
DEFINE CLASS ProductDataSource as SQLNorthwind 
********************************************************

	Alias 			= "Product"
	Tables 			= "PRODUCTS"
	KeyFieldList	= "PRODUCTID"
	
	*--------------------------------
	FUNCTION GetProducts() As Boolean 
	*--------------------------------
		
		This.SelectCmd = "Select * From Products"

		RETURN This.CreateCursorFromBackend()
	ENDFUNC

ENDDEFINE

********************************************************
DEFINE CLASS OrderDataSource as SQLNorthwind 
********************************************************

	Alias 			= "Order"
	Tables 			= "ORDERS"
	KeyFieldList	= "ORDERID"
		
	*-------------------------------------------------------
	FUNCTION GetOrdersByCustomerID(cID as String) As Boolean 
	*-------------------------------------------------------
		
		This.SelectCmd = "Select * From Orders Where CustomerID = '" + ALLTRIM(cID) + "'"

		RETURN This.CreateCursorFromBackend()
	ENDFUNC

ENDDEFINE

***********************************************************
DEFINE CLASS OrderDetailDataSource as SQLNorthwind 
***********************************************************

	Alias 			= "OrderDetail"
	*-- VFP Table Name 
	*Tables 		= "ORDERDETAILS"
	*-- SQL-Server table Name 
	Tables 			= "ORDER DETAILS"
	KeyFieldList	= "ORDERID,PRODUCTID"
		
	*-------------------------------------------------------------
	FUNCTION GetOrderDetailsByCustomerID(cID as String) As Boolean
	*------------------------------------------------------------- 
		
		*-- VFP SELECT 
		*This.SelectCmd = "Select OrderDetails.* From OrderDetails, Orders " + ;
		*				 "Where Orders.OrderID = OrderDetails.OrderID AND " + ;
		*				 "Orders.CustomerID = '" + ALLTRIM(cID) + "'"

		*-- SQL-Server SELECT Command
		This.SelectCmd = "Select [Order Details].*, Products.ProductName From [Order Details], Orders, Products " + ;
						 "Where Orders.OrderID = [Order Details].OrderID AND " + ;
						 "[Order Details].ProductID = Products.ProductID AND " + ;
						 "Orders.CustomerID = '" + ALLTRIM(cID) + "'"

		RETURN This.CreateCursorFromBackend()
	ENDFUNC

ENDDEFINE

******************************************************
DEFINE CLASS MyAbstractCursorAdapter as CursorAdapter 
******************************************************

	PROTECTED DataSourceType	, ;
	          Tables			, ;
	          SendUpdates 		, ;
	          AllowDelete		, ;
	          AllowInsert		, ;
	          AllowUpdate		, ;
	          WhereType			, ;
	          KeyFieldList		, ;
	          UpdateType		, ;
	          BufferModeOverride, ;  
			  nConnectionHandle , ;
	          cConnectionString , ;
	          lThrowExceptions	, ;
	          oADOConnection	, ;
	          oADORecordset		
	
	
	HIDDEN lWasConnected 
	lWasConnected			= .F.
	
	*--PUBLIC
	Alias 					= ""
	Name					= "MyAbstractCursorAdapter"
	lAssignPrimaryKeys		= .F.
	oException				= .NULL.

	*--PROTECTED
	BreakOnError			= .F.
	DataSourceType			= ""
	Tables 					= ""
	SendUpdates 			= .T.
	AllowDelete				= .T.
	AllowInsert				= .T.
	AllowUpdate				= .T.
	UpdateType				= 1 && Update
	WhereType				= 1 && DB_KEY
	KeyFieldList			= ""
	BufferModeOverride		= 5 &&Optimistic Table Buffering
	nConnectionHandle 		= -1	
	cConnectionString 		= ""
	lThrowExceptions		= .T.
	oADOConnection 			= .NULL.
	oADORecordset			= .NULL.
	
	*-------------------------------------------
	FUNCTION Destroy()
	*-------------------------------------------
		This.DisconnectFromBackend()
		This.oADORecordset = Null
		This.oADOConnection = Null
	ENDFUNC	

	*-------------------------------------------
	PROTECTED FUNCTION CreateCursorFromBackend()
	*-------------------------------------------
		LOCAL llRetVal
		LOCAL loExp As Exception
		llRetVal = .F.
		
		TRY
			DO CASE
				CASE This.ConnectToBackend() = .F.			
				CASE This.CursorFill() = .F.
		
			OTHERWISE
				llRetVal = .T.

			ENDCASE

		CATCH TO loExc
			This.oException = loExc
			IF This.lThrowExceptions
				THROW 
			ENDIF

		FINALLY
			This.DisconnectFromBackend() 
			
		ENDTRY
		
		RETURN llRetVal	
	ENDFUNC
	
	*--------------------------------------------------------------------------------------
	PROTECTED PROCEDURE BeforeCursorUpdate(nRows, lForce)
	*--------------------------------------------------------------------------------------
		LOCAL llRetVal As Boolean
		LOCAL loExc As Exception
		
		llRetVal = .F.
		TRY
			DO CASE
				CASE This.ValidateCursor() 		= .F.
				CASE This.CreateUpdateLists() 	= .F.
				CASE This.ConnectToBackend() 	= .F.		
				CASE This.AssignPrimaryKeys() 	= .F.
			OTHERWISE
				llRetVal = .T.
			ENDCASE
			
		CATCH TO loExc
			This.oException = loExc
			IF This.lThrowExceptions
				THROW 	
			ENDIF
	
		ENDTRY
		
		RETURN llRetVal
	ENDPROC
	
	
	*--------------------------------------------------------------------------------------
	PROTECTED PROCEDURE AfterCursorFill(lUseCursorSchema, lNoDataOnLoad, cSelectCmd, lResult)
	*--------------------------------------------------------------------------------------
		IF UPPER(This.DataSourceType)="NATIVE"
			*-- CursorFill by default leaves local tables open so we need to close it manually.
			*-- Because of this you need to watch out; with NATIVE you need to name your 
			*-- CursorAdapter Aliases DIFFERENT than the base table name.
			IF USED(This.Tables)
				USE IN (This.Tables)
			ENDIF	
		ENDIF	
			
	ENDPROC

	*------------------------------------
	HIDDEN FUNCTION ConnectToBackend() 
	*------------------------------------
		LOCAL llRetVal AS Boolean
		LOCAL loExc AS Exception 
		
		llRetVal = .T.
		TRY
		
			DO CASE 
				CASE UPPER(This.DataSourceType)="NATIVE" 
					IF NOT DBUSED(JUSTSTEM(This.DataSource))
						OPEN DATABASE (This.DataSource)	SHARED
					ELSE
						SET DATABASE TO JUSTSTEM(This.DataSource)
						This.lWasConnected = .T.
					ENDIF
				
				CASE UPPER(This.DataSourceType)="ODBC" 
					IF This.nConnectionHandle < 0 
						This.nConnectionHandle = SQLSTRINGCONNECT(This.cConnectionString, .T.)
						IF This.nConnectionHandle > -1 
							This.DataSource = This.nConnectionHandle 
						ELSE
							*-- SQLSTRINGCONNECT won't throw an exception so we have to do it.
							THROW "Could not connect to database - " + this.cConnectionString				
						ENDIF		
					ELSE
						This.lWasConnected = .T.
					ENDIF	
				
				
				CASE UPPER(This.DataSourceType)="ADO" 
					IF VARTYPE(This.oADOConnection) <> "O" 
						This.oADOConnection= CREATEOBJECT("ADODB.Connection")
					ENDIF
					
					IF This.oADOConnection.State = 0 &&adStateClosed
						This.oADOConnection.ConnectionString = This.cConnectionString
						This.oADOConnection.Open()
					ELSE
						This.lWasConnected = .T.
					ENDIF	
	
					IF VARTYPE(This.oADORecordset) <> "O" 
						This.oADORecordset = CREATEOBJECT("ADODB.Recordset")
					
						WITH This.oADORecordset 
							.CursorLocation 	= 3 &&adUseClient
							.LockType 			= 3 &&adLockOptimistic
							.ActiveConnection 	= This.oADOConnection
						ENDWITH
					
						This.DataSource = This.oADORecordset					
					ENDIF					
				
			ENDCASE		

		CATCH 
			llRetVal = .F.
			THROW 
			
		ENDTRY
				
		RETURN llRetVal	
	ENDFUNC

	*-----------------------------------------
	HIDDEN FUNCTION DisconnectFromBackend() 
	*-----------------------------------------
		LOCAL llRetVal AS Boolean
		LOCAL loExc AS Exception 
		llRetVal = .T.
		
		
		*-- Only close the connection if it was opened by this object. 
		*-- Otherwise this object may be part of a transaction and the connection is shared.
		*-- Or perhaps in the case of DatasourceType="NATIVE", the local DBC was open already.
		IF NOT This.lWasConnected 
			TRY	
				DO CASE 
					CASE UPPER(This.DataSourceType)="NATIVE" 
						IF DBUSED(JUSTSTEM(This.DataSource))
							SET DATABASE TO JUSTSTEM(This.DataSource)
							CLOSE DATABASE
						ENDIF	
						
					CASE UPPER(This.DataSourceType)="ODBC" 
						IF This.nConnectionHandle > -1
							llRetVal = (SQLDISCONNECT(This.nConnectionHandle) > -1)
							IF llRetVal
								This.nConnectionHandle = -1	
								This.DataSource = -1
							ENDIF	
						ENDIF	
		
					CASE UPPER(This.DataSourceType)="ADO" 
						IF VARTYPE(This.oADOConnection) = "O" AND This.oADOConnection.State = 1 &&adStateOpen
							This.oADOConnection.Close()
						ENDIF	
						
				ENDCASE	

			CATCH 
				llRetVal = .F.
				THROW 
				
			ENDTRY
		ELSE
			llRetVal = .F.
		ENDIF
			
		RETURN llRetVal	
	ENDFUNC

	*-------------------------------------
	PROTECTED FUNCTION CreateUpdateLists()
	*--------------------------------------------------------------------------
	*-- Creates the default Update Lists as every field in the attached cursor.
	*
	*-- NOTE: This assumes that the cursor field list matches the backend 
	*-- table's field list! If it doesn't, you must set these properties in the 
	*-- subclasses.
	*--------------------------------------------------------------------------
		LOCAL llRetVal as Boolean
		LOCAL lnPrevArea as Integer 
		LOCAL lcUpdatableFieldList as String
		LOCAL lcUpdateNameList as String
		LOCAL ARRAY laFields[1] 
		lcUpdateNameList = ""
		lcUpdatableFieldList = ""
		
		llRetVal = .F.
		IF EMPTY(This.UpdatableFieldList) AND EMPTY(This.UpdateNameList) 
			TRY
				lnPrevArea = SELECT()
				IF USED(This.Alias)	
					SELECT(This.Alias)
					AFIELDS(laFields)
					FOR i = 1 TO ALEN(laFields,1)
						IF NOT EMPTY(lcUpdatableFieldList )
							lcUpdatableFieldList= lcUpdatableFieldList  + ", "
						ENDIF
						IF NOT EMPTY(lcUpdateNameList)
							lcUpdateNameList	= lcUpdateNameList + ", "
						ENDIF
						lcUpdatableFieldList	= lcUpdatableFieldList + ALLTRIM(laFields[i,1])
						lcUpdateNameList 		= lcUpdateNameList + ALLTRIM(laFields[i,1]) + " " + UPPER(This.Tables) + "." + ALLTRIM(laFields[i,1]) 
					NEXT
					IF NOT EMPTY(lcUpdatableFieldList) AND NOT EMPTY(lcUpdateNameList)
						This.UpdateNameList 	= lcUpdateNameList
						This.UpdatableFieldList = lcUpdatableFieldList 
						llRetVal = .T.
					ENDIF
				ENDIF
			CATCH 
				llRetVal = .F.
				THROW
			
			FINALLY
				SELECT(lnPrevArea)
				
			ENDTRY
		
		ELSE
			llRetVal = .T.
		ENDIF
				
		RETURN llRetVal
	ENDFUNC
	
	*-------------------------------------
	PROTECTED FUNCTION AssignPrimaryKeys()
	*-------------------------------------
		LOCAL llRetVal as Boolean 

		llRetVal = .T.
		IF This.lAssignPrimaryKeys
			TRY
			**TODO: Write This funtion!		
			*-- Ideally you want to call a database stored proc to get unique keys from a key table
			CATCH
			ENDTRY
		ENDIF
	
		RETURN llRetVal
	ENDFUNC

	*-------------------------------------------------
	PROTECTED FUNCTION ValidateCursor() 
	*-------------------------------------------------
	*-- Overwrite this method in your concrete classes
	*-- so you can check the cursor values before saving.
	*-------------------------------------------------
		LOCAL llRetVal as Boolean 
	
		llRetVal = .T.
		
		RETURN llRetVal
		
	ENDFUNC
	
ENDDEFINE


