LPARAMETERS llUseIisExpress, tcWebConnectionHome, tcLaunchUrl

LOCAL llReady, lcUrl, lcDeployPath
llReady = .F.
lcDeployPath = ADDBS(JUSTPATH(SYS(16)))

DO (lcDeployPath + "SetPaths.prg") WITH tcWebConnectionHome TO llReady
IF !llReady
    RETURN .F.
ENDIF

IF VARTYPE(tcLaunchUrl) = "C" AND !EMPTY(ALLTRIM(tcLaunchUrl))
    lcUrl = ALLTRIM(tcLaunchUrl)
ELSE
    IF VARTYPE(llUseIisExpress) = "L" AND llUseIisExpress
        lcUrl = "http://localhost:8080/vfpwebdemo/default.htm"
    ELSE
        lcUrl = "http://localhost/vfpwebdemo/default.htm"
    ENDIF
ENDIF

RUN /N start "" &lcUrl
DO (lcDeployPath + "VfpWebDemoMain.prg")
RETURN .T.
