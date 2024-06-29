* Class Hierarchy ---
* Session
*	MyAbstractSession
*		Northwind
*		NorthwindResourceManager 
*   		Customer
*       	Product
*			Supplier
*			Order
*			OrderDetail
* XMLAdapter
*	NorthWindXMLAdapter 

*****************************************************
DEFINE CLASS Northwind AS MyAbstractSession OLEPUBLIC
*****************************************************
*--This class is exposed as an XML Web Service
*----------------------------------------------------
	Name = "Northwind"
			
 	*----------------------------------------------------------------
 	 Function GetOrdersByCustomerID(cCustomerID As String) As String
 	*----------------------------------------------------------------
        LOCAL oOrder
        LOCAL lcXML as String, loExc as Exception
            
		TRY        
	       oOrder = CREATEOBJECT("Order")
    	   lcXML = oOrder.GetOrdersByCustomerID(cCustomerID)
       	
       	CATCH TO loExc
       		*-- Throw an exception back to the client
			This.ReturnError(loExc)
			
		ENDTRY

        RETURN lcXML

    EndFunc
		
 	*------------------------------------------
    Function GetSupplierProducts() As String
 	*------------------------------------------
        LOCAL oSupplier
        LOCAL lcXML as String, loExc as Exception
         
        TRY
	        oSupplier = CREATEOBJECT("Supplier")
        	lcXML = oSupplier.GetSupplierProducts()
        
        CATCH TO loExc
			This.ReturnError(loExc)
			
		ENDTRY

        RETURN lcXML

    EndFunc

 	*--------------------------------------------------------------------------
    Function GetCustomersByCountryName( cCountryName As String) As String
   	*--------------------------------------------------------------------------
        LOCAL oCustomer
        LOCAL lcXML as String, loExc as Exception
        
        TRY
        	oCustomer = CREATEOBJECT("Customer")
			lcXML = oCustomer.GetCustomersByCountryName(cCountryName) 

		CATCH TO loExc
			This.ReturnError(loExc)
			
		ENDTRY

        RETURN lcXML

    EndFunc

 	*----------------------------------------------------------------
    Function GetCustomerByID(cID As String) As String
   	*----------------------------------------------------------------
        LOCAL oCustomer 
        LOCAL lcXML as String, loExc as Exception
        
        TRY
	        oCustomer = CREATEOBJECT("Customer")
	        lcXML = oCustomer.GetCustomerByID(cID)

        CATCH TO loExc
			This.ReturnError(loExc)
			
		ENDTRY

        RETURN lcXML

    ENDFUNC
    
    *----------------------------------------------------------------------------------------
    Function UpdateSingleTable(tcXMLDiffGram as String, rcErrorMessage as String @) as Boolean
   	*----------------------------------------------------------------------------------------
   	*-- This function updates a single table to the database. It also demonstrates
	*-- the passing of parameters by reference with the @ syntax. Instead of throwing 
	*-- an exception to the clients via COMRETURNERROR, it places the validation/exception 
	*-- error messages into the rcErrorMessage parameter which is returned via SOAP 
	*-- when called as a web service. 
	*-----------------------------------------------------------------------------------------
	
        LOCAL oCustomer 
        LOCAL lcXML as String, loExc as Exception
        
        TRY 
	        oCustomer = CREATEOBJECT("Customer")
	        lcXML = oCustomer.UpdateSingleTable(tcXMLDiffGram, @rcErrorMessage)

        CATCH TO loExc
			rcErrorMessage = loExc.Message
			
		ENDTRY

        RETURN lcXML

    EndFunc

ENDDEFINE

************************************************************
DEFINE CLASS Customer AS NorthwindResourceManager 
************************************************************
	cPrimaryDataSourceClassName = "CustomerDataSource"

	*-------------------------------------------------
	FUNCTION GetCustomerByID(cID as String) as String
	*-------------------------------------------------
		LOCAL loCustomer
		LOCAL loExc As Exception 
		LOCAL llRetVal As Boolean 
		LOCAL lcXML As String
		lcXML = ""
				
		TRY
			IF This.CreateXMLAdapter()
	
				*-- Get a reference to the CustomerDataSource
				loCustomer = This.CreateDataSource() 

				*-- Opens a disconnected customer cursor in the current work area
				llRetVal = loCustomer.GetCustomerByID(cID)

				IF llRetVal AND USED(loCustomer.Alias)
					*-- Add the customer cursor to the XMLAdapter as an XMLTable
					This.oXMLAdapter.AddTableSchema(loCustomer.Alias)

					*-- Create the XML from the loaded XMLTables
					This.oXMLAdapter.ToXML("lcXML")

				ENDIF
			ENDIF
		CATCH 
			*-- For this example, all errors are thrown to the client.
			THROW	
	
		ENDTRY
		
		*-- CursorAdapters by default automatically close their associated cursors when they are destroyed.
		*-- If you don't what that to happen, you would call the CursorDetach() method on the CursorAdapter.
		loCustomer = Null 
		
		*-- Return the XML to the client
		RETURN lcXML	
	ENDFUNC	

	*-------------------------------------------------
	FUNCTION GetCustomersByCountryName(cName as String) as String
	*-------------------------------------------------
		LOCAL loCustomerDataSource 
		LOCAL loExc As Exception 
		LOCAL llRetVal As Boolean 
		LOCAL lcXML As String
		lcXML = ""		
		
		TRY
			IF This.CreateXMLAdapter()
							
				loCustomer = This.CreateDataSource() 
				llRetVal = loCustomer.GetCustomersByCountryName(cName)
								
				IF llRetVal AND USED(loCustomer.Alias)
				
					This.oXMLAdapter.AddTableSchema(loCustomer.Alias)
					This.oXMLAdapter.ToXML("lcXML")

				ENDIF
			ENDIF	
			
		CATCH 
			THROW	
				
		ENDTRY
		
		loCustomer	 = Null 
		
		RETURN lcXML	
	ENDFUNC	
	
ENDDEFINE

************************************************************
DEFINE CLASS Order AS NorthwindResourceManager 
************************************************************
	PROTECTED cOrderDetailDataSourceName 
	
	cPrimaryDataSourceClassName = "OrderDataSource"
	cOrderDetailDataSourceName 	= "OrderDetailDataSource"	

	*-------------------------------------------------
	FUNCTION GetOrdersByCustomerID(cID as String) as String
	*-------------------------------------------------
		LOCAL loOrder 
		LOCAL loOrderDetail
		LOCAL loExc As Exception 
		LOCAL llRetVal As Boolean 
		LOCAL lcXML As String
		lcXML = ""
		
		TRY
			IF This.CreateXMLAdapter()
		
				*-- Get a reference to the primary datasource, OrderDataSource
				loOrder = This.CreateDataSource() 

				*-- Get a reference to the OrderDetailDatasource 
				loOrderDetail = This.CreateDataSource(This.cOrderDetailDataSourceName) 

				*-- Opens a disconnected Order cursor 
				llRetVal = loOrder.GetOrdersByCustomerID(cID)

				IF llRetVal AND USED(loOrder.Alias)
					*-- Add the Order cursor to the XMLAdapter as an XMLTable
					This.oXMLAdapter.AddTableSchema(loOrder.Alias)
					
					*-- Opens a disconnected OrderDetail cursor 
					lRetVal = loOrderDetail.GetOrderDetailsByCustomerID(cID)
					
					IF llRetVal AND USED(loOrderDetail.Alias)
						*-- Add the OrderDetail cursor to the XMLAdapter as an XMLTable
						This.oXMLAdapter.AddTableSchema(loOrderDetail.Alias)

						*-- Create the XML from the loaded XMLTables
						This.oXMLAdapter.ToXML("lcXML")

					ENDIF	
				ENDIF
			ENDIF
		CATCH 
			THROW						
		ENDTRY
		
		loOrder 		= Null
		loOrderDetail 	= Null
		
		*-- Return the Orders as XML to the client
		RETURN lcXML	
	ENDFUNC	

ENDDEFINE

************************************************************
DEFINE CLASS Supplier AS NorthwindResourceManager 
************************************************************
	PROTECTED cProductDataSourceName 
	
	cPrimaryDataSourceClassName = "SupplierDataSource"
	cProductDataSourceName 		= "ProductDataSource"	

	*-------------------------------------------------
	FUNCTION GetSupplierProducts() as String
	*-------------------------------------------------
		LOCAL loSupplier
		LOCAL loProduct 
		LOCAL loExc As Exception 
		LOCAL llRetVal As Boolean 
		LOCAL lcXML As String
		lcXML = ""
		
		TRY
			IF This.CreateXMLAdapter()
		
				loSupplier 	= This.CreateDataSource() 
				loProduct 	= This.CreateDataSource(This.cProductDataSourceName) 

				llRetVal = loSupplier.GetSuppliers()

				IF llRetVal AND USED(loSupplier.Alias)

					This.oXMLAdapter.AddTableSchema(loSupplier.Alias)
					
					llRetVal = loProduct.GetProducts()
					
					IF llRetVal AND USED(loProduct.Alias)
						This.oXMLAdapter.AddTableSchema(loProduct.Alias)
					ENDIF	
		
					This.oXMLAdapter.ToXML("lcXML")	
			
				ENDIF
			ENDIF						
		CATCH 
			THROW					
		
		ENDTRY
				
		loSupplier = Null
		loProduct = Null
		
		RETURN lcXML	
	ENDFUNC	

ENDDEFINE

*****************************************************
DEFINE CLASS NorthWindXMLAdapter AS XMLAdapter
*****************************************************
	UTF8Encoded 	= .T. 
    IsDiffGram		= .T. 
      	
ENDDEFINE

**************************************************************************************
DEFINE CLASS NorthwindResourceManager AS MyAbstractSession
**************************************************************************************
*-- Resource Managers manage the incoming and outgoing XML from/to the client and 
*-- take care of calling datasources so that the backend is isolated from the frontend.
*-------------------------------------------------------------------------------------
	PROTECTED 	cPrimaryDataSourceClassName	, ;
				cDataSourceClassLocation	, ;
				cXMLAdapterClassName		, ;
				oXMLAdapter					

	
	Name						= "NorthwindResourceManager"
	cXMLAdapterClassName		= "NorthwindXMLAdapter"	
	oXMLAdapter					= .NULL.
	
	*---------------
	FUNCTION Init()
	*---------------
		IF _VFP.StartMode = 0
		*-- If we're debugging, then set the location of our datasources. 
			This.cDataSourceClassLocation = "DataAccessLayer.prg"
		ENDIF
		SET MULTILOCKS ON
		SET EXACT ON
		SET DELETED ON
		RETURN DODEFAULT()
	ENDFUNC
	
	*---------------
	FUNCTION Destroy()
	*---------------
		This.oXMLAdapter = Null
	ENDFUNC
	
	*--------------------------------------------------------------------------
	FUNCTION UpdateSingleTable(tcXML as String, rcErrorMessage as String) as Boolean
	*--------------------------------------------------------------------------
	
		LOCAL llRetVal As Boolean
		LOCAL lExceptionAlreadyCaught As Boolean 
		LOCAL loDataSource As Object 
		LOCAL loTable as XMLTable
		LOCAL loExc As Exception
						
		llRetVal = .F.
		lExceptionAlreadyCaught = .F.
		
		TRY
			IF This.CreateXMLAdapter()
				
				This.oXMLAdapter.LoadXML(tcXML)
				loTable = This.oXMLAdapter.Tables.Item(1)
			
				*-- This returns a reference to our datasource which is 
				*-- a subclass of the CursorAdapter
				loDataSource = This.CreateDataSource()
				
				*-- Creates a changed cursor based on our DiffGram
				loTable.ChangesToCursor(loDataSource.Alias)
				
				IF USED(loDataSource.Alias)	
					*-- Attach the cursor to our CursorAdapter
					loDataSource.CursorAttach(loDataSource.Alias)
									
					*-- Update the table like normal. 
					*-- This will trigger events on our CursorAdapter
					llRetVal = TABLEUPDATE(.T.)					
				ENDIF
			ENDIF
			
		CATCH 					
		ENDTRY
		
		*-- This records the validation messages (stored in the UserValue property 
		*-- of the datasource's exception object) when we return .F. from the 
		*-- CursorAdapter.BeforeCursorUpdate method. 
		IF NOT llRetVal AND VARTYPE(loDataSource.oException) = "O" 
			lExceptionAlreadyCaught = .T.
			IF VARTYPE(loDataSource.oException.UserValue)!="O" AND NOT EMPTY(loDataSource.oException.UserValue)
				*-- Validation messages
				rcErrorMessage = loDataSource.oException.UserValue
			ELSE
				*-- Other exceptions 
				rcErrorMessage = loDataSource.oException.Message
			ENDIF
		ENDIF
		
		IF NOT llRetVal AND NOT lExceptionAlreadyCaught
			*-- Check for other "non-exception" style errors
			rcErrorMessage = MESSAGE()
		ENDIF		
		
		loDataSource = Null 
			
		RETURN llRetVal
		
	ENDFUNC

	*-------------------------------------------------------------------
	PROTECTED FUNCTION CreateDataSource(tcDataSourceClassName) As Object
	*-------------------------------------------------------------------
	*-- Returns a reference to the datasource object
	*-------------------------------------------------------------------
		LOCAL loDS
		LOCAL lcDataSourceClassName
		LOCAL loExc as Exception 
		
		TRY	
			lcDataSourceClassName = IIF(EMPTY(tcDataSourceClassName),This.cPrimaryDataSourceClassName, tcDataSourceClassName)
			loDS = This.CreateMyObject(lcDataSourceClassName, This.cDataSourceClassLocation)
		
		CATCH 
			loDS = .NULL.
			THROW 
					
		ENDTRY	
	
		RETURN loDS
	ENDFUNC
	
	*------------------------------------------------
	PROTECTED FUNCTION CreateXMLAdapter() As Boolean
	*------------------------------------------------
	*-- Returns a reference to the XMLAdapter object
	*------------------------------------------------
		LOCAL llRetVal
		LOCAL loExc As Exception
		llRetVal = .T.

		TRY	

			IF VARTYPE(This.oXMLAdapter)<>"O"
				This.oXMLAdapter = This.CreateMyObject(This.cXMLAdapterClassName)
			ENDIF
		
			*-- If we already had a reference to an XMLAdapter, make sure it is clean 
			IF This.oXMLAdapter.IsLoaded
				This.oXMLAdapter.ReleaseXML(.T.)
			ENDIF		
		
		CATCH 
			llRetVal = .F.
			This.oXMLAdapter = .NULL.
			THROW
		
		ENDTRY	
	
		RETURN llRetVal
	ENDFUNC
					
ENDDEFINE

******************************************
DEFINE CLASS MyAbstractSession AS Session 
******************************************
	Name = "MyAbstractSession"
			
	*------------------------------------------------------------------------
	PROTECTED FUNCTION CreateMyObject(tcClassName, tcClassLocation) As Object
	*------------------------------------------------------------------------
	*-- Returns an object reference to the requested class
	*------------------------------------------------------------------------
		LOCAL loObj, loExc as Exception 
		
		TRY
			IF EMPTY(tcClassLocation)
				loObj = CREATEOBJECT(tcClassName) 
			ELSE
				loObj = NEWOBJECT(tcClassName,tcClassLocation) 
			ENDIF	
			
		CATCH 
			loObj = .NULL.
			THROW 
				
		ENDTRY
			
		RETURN loObj 	
	ENDFUNC	
	
	*------------------------------------------------------------------------
	PROTECTED PROCEDURE ReturnError(toException As Exception ) 
	*------------------------------------------------------------------------
		LOCAL lcMessage as String
		
		IF VARTYPE(toException.UserValue)="C" AND NOT EMPTY(toException.UserValue)
			lcMessage = toException.UserValue
		ELSE
			lcMessage = toException.Message
		ENDIF		
		
		IF _VFP.StartMode = 0
			*-- If we're debugging, then just put up a messagebox
			MESSAGEBOX(lcMessage,16,This.Name)		
		ELSE
			COMRETURNERROR(This.Name,lcMessage)
		ENDIF
	
	ENDPROC

ENDDEFINE


