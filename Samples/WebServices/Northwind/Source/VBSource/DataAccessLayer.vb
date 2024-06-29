Option Strict On
Option Explicit On 

Imports System.Data.SqlClient

Public MustInherit Class NorthwindDataAccessLayer

    ' Modify these connection strings as necessary so a connection can
    ' be made to your Northwind database.

    'Protected Const SQL_CONNECTION_STRING As String = _
    '    "Data Source=localhost;" & _
    '    "Initial Catalog=northwind;" & _
    '    "Integrated Security=SSPI"

    Protected Const SQL_CONNECTION_STRING As String = _
       "Data Source=localhost;" & _
       "Initial Catalog=Northwind;" & _
       "User ID=sa;" & _
       "Password=;"

    Protected Const MSDE_CONNECTION_STRING As String = _
            "Server=(local)\NetSDK;" & _
            "DataBase=northwind;" & _
            "Integrated Security=SSPI"

    Protected Da As SqlDataAdapter
    Protected Cmd As SqlCommand
    Protected Cnn As SqlConnection
    Private trans As SqlTransaction

    Protected cConnectionString As String = SQL_CONNECTION_STRING

    Protected MustOverride ReadOnly Property cPrimaryTableName() As String

    Protected Function OpenConnection() As Boolean
        Dim bRetVal As Boolean = False
        Dim IsConnecting As Boolean = True

        While IsConnecting
            Try

                If (Cnn Is Nothing) Then
                    Cnn = New SqlConnection(cConnectionString)
                End If
                If (Cnn.State = ConnectionState.Closed) Then
                    Cnn.Open()
                End If

                bRetVal = True
                IsConnecting = False

            Catch exp As Exception
                If cConnectionString = SQL_CONNECTION_STRING Then
                    ' Couldn't connect to SQL Server.  Now try MSDE.
                    cConnectionString = MSDE_CONNECTION_STRING
                Else
                    ' Couldn't connect to any Server.  
                    IsConnecting = False
                    Throw exp
                End If

            End Try
        End While

        Return bRetVal

    End Function

    Protected Function CloseConnection() As Boolean
        Dim bRetVal As Boolean = False

        Try
            If (Not Cnn Is Nothing) AndAlso (Cnn.State = ConnectionState.Open) Then
                Cnn.Close()
            End If

            bRetVal = True

        Catch Exp As Exception
            Throw Exp
        End Try

        Return bRetVal

    End Function

    Protected Function ExecuteQuery(ByRef ds As DataSet) As Boolean
        Dim bRetVal As Boolean = False

        Try
            If OpenConnection() Then

                If (Cmd.Connection Is Nothing) Then
                    Cmd.Connection = Cnn
                End If

                Da = New SqlDataAdapter(Cmd)

                'Include all length information in this schema if a VFP client is consuming this data  
                'via an XMLAdapter otherwise all the client cursor fields will be memo fields. This is 
                'because the memo field is the default type in VFP for unlimited length strings.
                Da.MissingSchemaAction = MissingSchemaAction.AddWithKey

                Da.Fill(ds)

                bRetVal = True
            End If
        Catch Exp As Exception
            Throw Exp
        Finally
            CloseConnection()
        End Try

        Return bRetVal

    End Function

    Public Overridable Function Validate(ByVal inDS As DataSet) As Boolean
        'Concrete classes can perform dataset validation here
        Return True
    End Function


    Public Function UpdateSingleTable(ByVal inDS As DataSet, ByRef cErrorMessage As String) As Boolean
        Dim bRetVal As Boolean = False
        Dim nRowsUpdated As Integer
        Dim strSQL As String = ""

        Try
            ' If the DataSet that was passed in is Nothing, we will exit with false.
            ' We will also call our middle-tier validation before we update the database 
            If (Not inDS Is Nothing) AndAlso Me.Validate(inDS) Then

                Dim cTableName As String = inDS.Tables(0).TableName

                strSQL = "SELECT * FROM " & cPrimaryTableName

                If OpenConnection() Then
                    Try

                        Cmd = New SqlCommand(strSQL, Cnn)
                        Da = New SqlDataAdapter(Cmd)
                        Dim cb As New SqlCommandBuilder(Da)

                        'Begin a transaction 
                        trans = Cnn.BeginTransaction(IsolationLevel.ReadCommitted, "SimpleTransaction")
                        Cmd.Transaction = trans

                        ' Try to Update the DataTable.
                        nRowsUpdated = Da.Update(inDS, cTableName)

                        'If we get here then all is well. Commit the data to the database.
                        trans.Commit()

                        bRetVal = True

                    Catch Exp As Exception
                        'Something bad happened in our update. We better roll all changes back.
                        trans.Rollback("SimpleTransaction")
                        cErrorMessage = Exp.Message

                    Finally
                        CloseConnection()

                    End Try

                End If

            End If

        Catch Exp As Exception
            'Catch Validation messages (if any) and send them out to the client via byRef parameter
            cErrorMessage = Exp.Message

        End Try

        Return bRetVal
    End Function

End Class

'Concrete Class
Public Class Customer
    Inherits NorthwindDataAccessLayer

    Protected Overrides ReadOnly Property cPrimaryTableName() As String
        Get
            Return "Customers"
        End Get
    End Property

    Public Overrides Function Validate(ByVal inDS As DataSet) As Boolean
        Dim bRetVal As Boolean = True
        Dim cMsg As String = ""
        Dim sb As Text.StringBuilder
        Dim oRow As DataRow
        Try
            'Validate the customer table    
            For Each oRow In inDS.Tables("Customer").Rows
                If oRow.RowState = DataRowState.Added OrElse oRow.RowState = DataRowState.Modified Then
                    If CStr(oRow.Item("CompanyName")) = "" Then
                        If sb Is Nothing Then
                            'String builders are better to use if we are appending lots of strings together.
                            'Since we don't know how many records may fail in this DataTable, 
                            'it is probably best to use the StringBuilder class.
                            sb = New Text.StringBuilder()
                        End If
                        sb.Append("Customer: " & CStr(oRow.Item("CustomerID")) & " - Company Name cannot be empty." & vbCrLf)
                    End If
                End If
            Next
            If Not sb Is Nothing Then
                cMsg = sb.ToString
            End If
        Catch exp As Exception
            bRetVal = False
            Throw exp
        End Try

        If Not cMsg = "" Then
            bRetVal = False
            'Throw the validation messages if there were any.
            Throw New System.Exception(cMsg)
        End If

        Return bRetVal
    End Function

    Public Function GetCustomersByCountryName(ByVal cCountryName As String) As DataSet

        Dim ds As DataSet
        Dim lcName As String
        lcName = Trim(cCountryName)

        '-- SQLClient syntax
        Dim strSQL As String = _
          "Select * from Customers Where Country LIKE @Country"

        ds = New DataSet()

        Try

            Cmd = New SqlCommand(strSQL)
            Cmd.Parameters.Add("@Country", lcName & "%")

            If ExecuteQuery(ds) Then
                ds.Tables(0).TableName = "Customer"
            End If

        Catch Exp As Exception

        End Try

        ' Return the DataSet
        ds.DataSetName = "Customer"
        Return ds

    End Function

    Public Function GetOrdersByCustomerID(ByVal cID As String) As DataSet

        Dim dsOrders As DataSet
        Dim lcID As String
        lcID = Trim(cID).ToUpper()

        'This string is two separate SELECT statements separated by a semicolon. 
        'This produces two separate data tables when the dataset is filled below.
        Dim strSQL As String = _
            "Select Orders.* From Orders Where Orders.CustomerID = @CustID " & _
            "; Select [Order Details].*, Products.ProductName " & _
            " From [Order details], Products, Orders " & _
            " Where Products.ProductID = [Order Details].ProductID AND " & _
            " Orders.OrderID = [Order Details].OrderID AND " & _
            " Orders.CustomerID = @CustID "

        dsOrders = New DataSet()

        Try

            Cmd = New SqlCommand(strSQL)
            Cmd.Parameters.Add("@CustID", lcID)

            If ExecuteQuery(dsOrders) Then

                dsOrders.Tables(0).TableName = "Order"
                dsOrders.Tables(1).TableName = "OrderDetail"
                dsOrders.Relations.Add("Order_Detail", _
                   dsOrders.Tables("Order").Columns("OrderID"), _
                   dsOrders.Tables("OrderDetail").Columns("OrderID"))

                'Return Hierarchical dataset
                dsOrders.Relations("Order_Detail").Nested = True

            End If

        Catch Exp As Exception

        End Try

        ' Return the DataSet
        dsOrders.DataSetName = "Order"


        Return dsOrders

    End Function

    Public Function GetCustomerByID(ByVal cID As String) As DataSet

        Dim ds As DataSet
        Dim strSQL As String = _
                     "Select * from Customers Where CustomerID = @CustID"

        ds = New DataSet()

        Try

            Cmd = New SqlCommand(strSQL)
            Cmd.Parameters.Add("@CustID", cID)

            If ExecuteQuery(ds) Then
                ds.Tables(0).TableName = "Customer"
            End If

        Catch Exp As Exception

        End Try

        ' Return the DataSet       
        ds.DataSetName = "Customer"
        Return ds

    End Function

End Class

'Concrete Class
Public Class Supplier
    Inherits NorthwindDataAccessLayer

    Protected Overrides ReadOnly Property cPrimaryTableName() As String
        Get
            Return "Suppliers"
        End Get
    End Property

    Public Function GetSupplierProducts() As DataSet
        Dim dsSupplierProducts As DataSet

        'This string is two separate SELECT statements separated by a semicolon. 
        'This produces two separate data tables when the dataset is filled below.
        Dim strSQL As String = _
            "SELECT * FROM Suppliers;SELECT * FROM Products"

        dsSupplierProducts = New DataSet()

        Try

            Cmd = New SqlCommand(strSQL)

            If ExecuteQuery(dsSupplierProducts) Then

                dsSupplierProducts.Tables(0).TableName = "Suppliers"
                dsSupplierProducts.Tables(1).TableName = "Products"
                dsSupplierProducts.Relations.Add("Supplier_Products", _
                    dsSupplierProducts.Tables("Suppliers").Columns("SupplierID"), _
                    dsSupplierProducts.Tables("Products").Columns("SupplierID"))

                'Return Hierarchical dataset
                dsSupplierProducts.Relations("Supplier_Products").Nested = True

            End If

        Catch Exp As Exception

        End Try

        ' Return the DataSet
        dsSupplierProducts.DataSetName = "SupplierProducts"
        Return dsSupplierProducts

    End Function

End Class

