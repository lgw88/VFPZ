#INCLUDE WCONNECT.H

LPARAMETERS llNoReadEvents

PUBLIC glExitServer, goWCServer
glExitServer = .F.

DO WCONNECT

goWCServer = CREATEOBJECT("VfpWebDemoServer")

IF VARTYPE(llNoReadEvents) = "L" AND llNoReadEvents
    RETURN goWCServer
ENDIF

READ EVENTS
RETURN


DEFINE CLASS VfpWebDemoServer AS WWC_SERVER OLEPUBLIC
    cAppName = "VFP Web Demo"

    PROTECTED FUNCTION OnInit
        THIS.cAppIniFile = ADDBS(THIS.cAppStartPath) + "VfpWebDemo.ini"
        THIS.cAppName = "VFP Web Demo"
        THIS.oConfig = CREATEOBJECT("VfpWebDemoConfig")
        THIS.oConfig.cFileName = THIS.cAppIniFile

        SET CENTURY ON
        SET DATE YMD

        RETURN .T.
    ENDFUNC

    PROTECTED FUNCTION OnLoad
        IF THIS.lShowServerForm AND TYPE("THIS.oServerForm") = "O" AND !ISNULL(THIS.oServerForm)
            THIS.oServerForm.Caption = THIS.cServerId + " - " + THIS.cAppName + " " + WWVERSION
        ENDIF

        * Development-time paths. Runtime deployments should prefer relative config.
        DO PATH WITH THIS.cAppStartPath
        DO PATH WITH FULLPATH("..\Data\", THIS.cAppStartPath)
        DO PATH WITH FULLPATH("..\Web\", THIS.cAppStartPath)

        RETURN .T.
    ENDFUNC

    PROTECTED FUNCTION Process
        LOCAL lcParameter, lcExtension, lcPhysicalPath

        lcParameter = UPPER(THIS.oRequest.QueryString(1))

        DO CASE
        CASE lcParameter == "WWMAINT"
            DO wwMaint WITH THIS

        OTHERWISE
            lcPhysicalPath = THIS.oRequest.GetPhysicalPath()
            lcExtension = UPPER(JUSTEXT(lcPhysicalPath))

            DO CASE
            CASE lcExtension == "VAPI"
                DO ApiProcess WITH THIS

            CASE lcExtension == "WC" OR lcExtension == "FXP" OR lcExtension == "MD"
                DO wwScriptMaps WITH THIS

            OTHERWISE
                Response = CREATE([WWC_RESPONSESTRING])
                Response.StandardPage("Unhandled Request", ;
                    "The server is not configured to handle this request type: <b>." + lcExtension + "</b>" + ;
                    "<p>For API calls, map the .vapi extension to ApiProcess.prg.</p>")
            ENDCASE
        ENDCASE

        RETURN
    ENDFUNC
ENDDEFINE


DEFINE CLASS VfpWebDemoConfig AS wwServerConfig
    cVirtualPath = "/vfpwebdemo/"
    cHtmlPagePath = "..\Web\"
    cDataPath = "..\Data\"
    cSqlConnectString = "Driver=SQL Server;Server=.;Database=YourDb;Trusted_Connection=Yes;"
ENDDEFINE
