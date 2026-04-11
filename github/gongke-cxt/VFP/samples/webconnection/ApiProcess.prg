*
* Minimal Web Connection REST skeleton for a VFP-backed Web API.
* Prerequisite:
*   - A Web Connection project already created by the project wizard
*   - Script map / routing configured in IIS
*   - This class registered as a REST process inside the Web Connection project
*

DEFINE CLASS ApiProcess AS wwRestProcess
    cProcessName = "api"

    FUNCTION OnProcessInit
        LOCAL lcOrigin, lcVerb, lcRequestHeaders

        Response.Encoding = "UTF8"
        Request.lUtf8Encoding = .T.

        * Simple CORS handling for browser-based clients.
        lcOrigin = Request.ServerVariables("HTTP_ORIGIN")
        IF !EMPTY(lcOrigin)
            Response.AppendHeader("Access-Control-Allow-Origin", lcOrigin)
            Response.AppendHeader("Access-Control-Allow-Methods", "GET, POST, PUT, OPTIONS")

            lcRequestHeaders = Request.GetExtraHeader("Access-Control-Request-Headers")
            IF EMPTY(lcRequestHeaders)
                lcRequestHeaders = "Content-Type, Authorization"
            ENDIF

            Response.AppendHeader("Access-Control-Allow-Headers", lcRequestHeaders)
            Response.AppendHeader("Access-Control-Allow-Credentials", "true")
        ENDIF

        lcVerb = Request.GetHttpVerb()
        IF lcVerb == "OPTIONS"
            Response.Status = "204 No Content"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    FUNCTION Ping
        LOCAL loResult

        loResult = CREATEOBJECT("Empty")
        ADDPROPERTY(loResult, "Code", 0)
        ADDPROPERTY(loResult, "Message", "ok")
        ADDPROPERTY(loResult, "ServerTime", DATETIME())

        Serializer.PropertyNameOverrides = "Code,Message,ServerTime"
        RETURN loResult
    ENDFUNC

    FUNCTION Login(loInput)
        LOCAL loResult

        IF VARTYPE(loInput) # "O"
            ERROR "Missing login payload."
        ENDIF
        IF VARTYPE(loInput.UserCode) # "C" OR EMPTY(ALLTRIM(loInput.UserCode))
            ERROR "UserCode is required."
        ENDIF
        IF VARTYPE(loInput.Password) # "C" OR EMPTY(ALLTRIM(loInput.Password))
            ERROR "Password is required."
        ENDIF

        loResult = NEWOBJECT("OrderService", "OrderService.prg").Login(loInput)
        Serializer.PropertyNameOverrides = "Success,UserId,UserName,RoleNames,Token,ExpiresAt,Message"
        RETURN loResult
    ENDFUNC

    FUNCTION Orders(loFilter)
        Serializer.PropertyNameOverrides = "OrderId,OrderNo,CustomerName,OrderDate,Status,Amount"
        RETURN NEWOBJECT("OrderService", "OrderService.prg").ListOrders(loFilter)
    ENDFUNC

    FUNCTION SaveOrder(loPayload)
        Serializer.PropertyNameOverrides = "Success,OrderId,Message"
        RETURN NEWOBJECT("OrderService", "OrderService.prg").SaveOrder(loPayload)
    ENDFUNC
ENDDEFINE
