LPARAMETERS tcVirtualPath

LOCAL lcDeployPath, lcWebPath, lcVirtualPath, lcMessage

lcDeployPath = ADDBS(JUSTPATH(SYS(16)))
lcWebPath = lcDeployPath + "..\Web\"
lcVirtualPath = IIF(VARTYPE(tcVirtualPath) = "C" AND !EMPTY(ALLTRIM(tcVirtualPath)), ALLTRIM(tcVirtualPath), "/vfpwebdemo/")

TEXT TO lcMessage NOSHOW TEXTMERGE PRETEXT 15
This file is a source-controlled placeholder for the Web Connection generated IIS configuration program.

Expected settings for this demo:
- Virtual Path: <<lcVirtualPath>>
- Web Path: <<lcWebPath>>
- Script Map: .vapi -> ApiProcess
- Main Program: VfpWebDemoMain.prg

Recommended action:
1. Open the Web Connection Console.
2. Create or open a project named VfpWebDemo.
3. Regenerate the project ServerConfig program if you want full IIS automation.
4. Keep this file in sync with the generated values you actually deploy.
ENDTEXT

? lcMessage
RETURN .T.
