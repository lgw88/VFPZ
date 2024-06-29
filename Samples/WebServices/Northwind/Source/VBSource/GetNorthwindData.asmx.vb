Option Strict On
Option Explicit On

Imports System.Web.Services
Imports NorthwindWebservice.Customer
Imports NorthwindWebservice.Supplier

<System.Web.Services.WebService(Namespace:="http://ToledoSamples/", _
    Description:="This is a VB.NET XML Web Service that provides data access and updating to the Northwind SQL-Server database.")> _
Public Class Northwind
    Inherits System.Web.Services.WebService

#Region " Web Services Designer Generated Code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Web Services Designer.
        InitializeComponent()

        'Add your own initialization code after the InitializeComponent() call

    End Sub

    'Required by the Web Services Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Web Services Designer
    'It can be modified using the Web Services Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        'CODEGEN: This procedure is required by the Web Services Designer
        'Do not modify it using the code editor.
        If disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

#End Region

    <WebMethod(Description:="Returns all the customers where Country is LIKE the value of the cCountryName parameter.")> _
       Public Function GetCustomersByCountryName(ByVal cCountryName As String) As DataSet

        Dim oDataSource As New Customer()

        Return oDataSource.GetCustomersByCountryName(cCountryName)

    End Function

    <WebMethod(Description:="Retrieve customer orders and order details by passing in the customer ID.")> _
    Public Function GetOrdersByCustomerID(ByVal cCustomerID As String) As DataSet
        Dim oDataSource As New Customer()

        Return oDataSource.GetOrdersByCustomerID(cCustomerID)

    End Function

    <WebMethod(Description:="Returns a hierarchical dataset of suppliers and their products.")> _
    Public Function GetSupplierProducts() As DataSet
        Dim oDataSource As New Supplier()

        Return oDataSource.GetSupplierProducts()

    End Function

    <WebMethod(Description:="Returns the customer you request by Customer ID.")> _
    Public Function GetCustomerByID(ByVal cID As String) As DataSet
        Dim oDataSource As New Customer()

        Return oDataSource.GetCustomerByID(cID)

    End Function

    <WebMethod(Description:="Updates the Northwind database with the first table contained in the passed dataset.")> _
    Public Function UpdateSingleTable(ByVal ds As DataSet, ByRef cErrorMessage As String) As Boolean
        Dim oDataSource As New Customer()

        Return oDataSource.UpdateSingleTable(ds, cErrorMessage)

    End Function


    <WebMethod(Description:="Use this method to test the UpdateSingleTable method.")> _
    Public Function TestUpdateCustomer(ByVal cCustomerID As String, ByVal cFieldName As String, ByVal cFieldValue As String) As String

        Dim bRetVal As Boolean
        Dim oDataSource As New Customer()
        Dim myDs As DataSet
        Dim cErrorMessage As String

        Try
            myDs = oDataSource.GetCustomerByID(cCustomerID)

            With myDs.Tables("Customer").Rows(0)
                .Item(cFieldName) = cFieldValue
            End With

            bRetVal = oDataSource.UpdateSingleTable(myDs.GetChanges, cErrorMessage)
        Catch exp As Exception
            cErrorMessage = exp.Message
        End Try

        If bRetVal Then
            cErrorMessage = "Customer successfully saved"
        End If

        Return cErrorMessage

    End Function

    <WebMethod(Description:="Use this method to test the UpdateSingleTable method.")> _
    Public Function TestDeleteCustomer(ByVal cCustomerID As String) As String

        Dim bRetVal As Boolean
        Dim oDataSource As New Customer()
        Dim myDs As DataSet
        Dim cErrorMessage As String

        Try
            myDs = oDataSource.GetCustomerByID(cCustomerID)

            With myDs.Tables("Customer").Rows(0)
                .Delete()
            End With

            bRetVal = oDataSource.UpdateSingleTable(myDs.GetChanges, cErrorMessage)
        Catch exp As Exception
            cErrorMessage = exp.Message
        End Try

        If bRetVal Then
            cErrorMessage = "Customer successfully saved"
        End If

        Return cErrorMessage

    End Function
End Class
