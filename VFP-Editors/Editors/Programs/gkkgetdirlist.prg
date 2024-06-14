*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              gregnkim@bellsouth.net
*-*
*-* Copyright ©2003 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Gets the sub-directories under the Root directory (parameter)
*-*
FUNCTION GKKGetDirList
LPARAMETERS pcRootDir,plGetSubDirectories
LOCAL lnNumDirs, lnNdx, lcRootDir, lcDirectory
LOCAL ARRAY lcDirList[1]
INSERT INTO c_dirlist (directory) VALUES (ADDBS(pcRootDir))
lcRootDir = ADDBS(pcRootDir)
lnNumDirs = ADIR(lcDirList,lcRootDir+"*","D")
FOR lnNdx=1 TO lnNumDirs
	IF !INLIST(lcDirList[lnNdx,1],".","..") .AND. "D" $ lcDirList[lnNdx,5]
		lcDirectory = lcRootDir + lcDirList[lnNdx,1]
		IF plGetSubDirectories
			=GKKGetDirList(lcDirectory,.T.)
		ELSE
			INSERT INTO c_dirlist (directory) VALUES (ADDBS(lcDirectory))
		ENDIF
	ENDIF
ENDFOR
ENDFUNC