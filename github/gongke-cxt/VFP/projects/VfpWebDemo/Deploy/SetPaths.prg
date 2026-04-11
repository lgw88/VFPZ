LPARAMETERS tcWebConnectionHome

LOCAL lcDeployPath, lcDataPath, lcWebPath, lcWcHome, lcWcClassesPath, llReady

lcDeployPath = ADDBS(JUSTPATH(SYS(16)))
lcDataPath = lcDeployPath + "..\Data\"
lcWebPath = lcDeployPath + "..\Web\"
lcWcHome = ALLTRIM(IIF(VARTYPE(tcWebConnectionHome) = "C", tcWebConnectionHome, ""))

IF EMPTY(lcWcHome)
    lcWcHome = ALLTRIM(GETENV("WC_HOME"))
ENDIF

IF EMPTY(lcWcHome)
    MESSAGEBOX("未找到 Web Connection 安装目录。请先设置环境变量 WC_HOME。", 16, "VfpWebDemo")
    RETURN .F.
ENDIF

lcWcHome = ADDBS(lcWcHome)
lcWcClassesPath = lcWcHome + "classes\"

IF !DIRECTORY(lcWcHome)
    MESSAGEBOX("WC_HOME 指向的目录不存在：" + lcWcHome, 16, "VfpWebDemo")
    RETURN .F.
ENDIF

SET PATH TO (lcDeployPath + ";" + lcDataPath + ";" + lcWebPath + ";" + lcWcHome + ";" + lcWcClassesPath) ADDITIVE

llReady = .T.
RETURN llReady
