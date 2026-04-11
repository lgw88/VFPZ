LPARAMETERS tcWebConnectionHome

LOCAL llReady, lcDeployPath
llReady = .F.
lcDeployPath = ADDBS(JUSTPATH(SYS(16)))

DO (lcDeployPath + "SetPaths.prg") WITH tcWebConnectionHome TO llReady
IF !llReady
    RETURN .F.
ENDIF

DO (lcDeployPath + "VfpWebDemoMain.prg")
RETURN .T.
