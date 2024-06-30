CLEAR ALL
CLEAR

USE demo.vcx
PACK
USE

BuildExe("demo_vfp")
BuildExe("demo_top")
BuildExe("demo_mdi")
BuildExe("demo_tdi")


FUNCTION BuildExe(tcName)
	BUILD EXE (tcName) FROM (tcName)
	?"Built: " + tcName
ENDFUNC


