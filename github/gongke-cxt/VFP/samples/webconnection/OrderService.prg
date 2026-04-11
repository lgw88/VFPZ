*
* Example business service.
* Replace SQL connection logic and table names with your actual project code.
*

DEFINE CLASS OrderService AS Custom

    FUNCTION Login(loInput)
        LOCAL loResult

        * Replace this stub with your user table / password validation logic.
        loResult = CREATEOBJECT("Empty")
        ADDPROPERTY(loResult, "Success", .T.)
        ADDPROPERTY(loResult, "UserId", 1001)
        ADDPROPERTY(loResult, "UserName", ALLTRIM(loInput.UserCode))
        ADDPROPERTY(loResult, "RoleNames", "admin")
        ADDPROPERTY(loResult, "Token", SYS(2015))
        ADDPROPERTY(loResult, "ExpiresAt", DATETIME() + 1)
        ADDPROPERTY(loResult, "Message", "login ok")

        RETURN loResult
    ENDFUNC

    FUNCTION ListOrders(loFilter)
        LOCAL lcStatus, lcSql

        lcStatus = ""
        IF VARTYPE(loFilter) = "O" AND VARTYPE(loFilter.Status) = "C"
            lcStatus = UPPER(ALLTRIM(loFilter.Status))
        ENDIF

        TEXT TO lcSql NOSHOW TEXTMERGE PRETEXT 15
SELECT OrderId, OrderNo, CustomerName, OrderDate, Status, Amount ;
  FROM dbo.Orders ;
 WHERE (?EMPTY(m.lcStatus) OR UPPER(Status) = ?m.lcStatus) ;
 ORDER BY OrderDate DESC
        ENDTEXT

        IF !THIS.ExecSql(lcSql, "csrOrders")
            ERROR "Order query failed."
        ENDIF

        RETURN "cursor:csrOrders"
    ENDFUNC

    FUNCTION SaveOrder(loPayload)
        LOCAL loResult, lnOrderId

        IF VARTYPE(loPayload) # "O"
            ERROR "Missing order payload."
        ENDIF
        IF VARTYPE(loPayload.OrderNo) # "C" OR EMPTY(ALLTRIM(loPayload.OrderNo))
            ERROR "OrderNo is required."
        ENDIF

        * Replace this stub with real transaction logic.
        IF VARTYPE(loPayload.OrderId) = "N"
            lnOrderId = loPayload.OrderId
        ELSE
            lnOrderId = 0
        ENDIF

        loResult = CREATEOBJECT("Empty")
        ADDPROPERTY(loResult, "Success", .T.)
        ADDPROPERTY(loResult, "OrderId", lnOrderId)
        ADDPROPERTY(loResult, "Message", "saved")

        RETURN loResult
    ENDFUNC

    FUNCTION ExecSql(tcSql, tcCursor)
        LOCAL lnConn, lnResult

        * Replace connection string with a secure config source.
        lnConn = SQLSTRINGCONNECT("Driver=SQL Server;Server=.;Database=YourDb;Trusted_Connection=Yes;")
        IF lnConn < 1
            RETURN .F.
        ENDIF

        lnResult = SQLEXEC(lnConn, tcSql, tcCursor)
        =SQLDISCONNECT(lnConn)

        RETURN lnResult > 0
    ENDFUNC
ENDDEFINE
