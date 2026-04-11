DEFINE CLASS OrderService AS Custom

    FUNCTION Login(loInput)
        LOCAL loResult

        * Replace this stub with your real user validation logic.
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

        IF THIS.ExecSql(lcSql, "csrOrders")
            RETURN "cursor:csrOrders"
        ENDIF

        RETURN THIS.BuildSampleOrders(lcStatus)
    ENDFUNC

    FUNCTION SaveOrder(loPayload)
        LOCAL loResult, lnOrderId

        IF VARTYPE(loPayload) # "O"
            ERROR "Missing order payload."
        ENDIF
        IF VARTYPE(loPayload.OrderNo) # "C" OR EMPTY(ALLTRIM(loPayload.OrderNo))
            ERROR "OrderNo is required."
        ENDIF

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

    FUNCTION BuildSampleOrders(tcStatus)
        LOCAL loItems

        loItems = CREATEOBJECT("Collection")

        THIS.AddSampleOrder(loItems, tcStatus, 1, "SO-20260328001", "宁波测试客户", DATETIME() - 1, "Open", 1280.50)
        THIS.AddSampleOrder(loItems, tcStatus, 2, "SO-20260328002", "上海体验门店", DATETIME() - 2, "Closed", 880.00)
        THIS.AddSampleOrder(loItems, tcStatus, 3, "SO-20260328003", "杭州移动终端部", DATETIME(), "Open", 3560.00)

        RETURN loItems
    ENDFUNC

    FUNCTION AddSampleOrder(toItems, tcStatus, tnOrderId, tcOrderNo, tcCustomerName, ttOrderDate, tcOrderStatus, tnAmount)
        LOCAL loOrder

        IF !EMPTY(tcStatus) AND UPPER(tcOrderStatus) # tcStatus
            RETURN
        ENDIF

        loOrder = CREATEOBJECT("Empty")
        ADDPROPERTY(loOrder, "OrderId", tnOrderId)
        ADDPROPERTY(loOrder, "OrderNo", tcOrderNo)
        ADDPROPERTY(loOrder, "CustomerName", tcCustomerName)
        ADDPROPERTY(loOrder, "OrderDate", TTOC(ttOrderDate, 1))
        ADDPROPERTY(loOrder, "Status", tcOrderStatus)
        ADDPROPERTY(loOrder, "Amount", tnAmount)

        toItems.Add(loOrder)
    ENDFUNC

    FUNCTION ExecSql(tcSql, tcCursor)
        LOCAL lnConn, lnResult, lcConnString

        * Replace this connection string with a project-local secure config source.
        lcConnString = "Driver=SQL Server;Server=.;Database=YourDb;Trusted_Connection=Yes;"
        lnConn = SQLSTRINGCONNECT(lcConnString)
        IF lnConn < 1
            RETURN .F.
        ENDIF

        lnResult = SQLEXEC(lnConn, tcSql, tcCursor)
        =SQLDISCONNECT(lnConn)

        RETURN lnResult > 0
    ENDFUNC
ENDDEFINE
