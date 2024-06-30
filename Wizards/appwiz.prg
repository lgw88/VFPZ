#INCLUDE APPBLDR.H

LPARAMETERS p1,p2,p3,p4,p5,p6,p7,p8,p9

PRIVATE cWizPath
cWizPath = JUSTPATH(SYS(16))
LOCAL loWiz
loWiz = CreateObject("APPWIZ")
loWiz.MakeApplication

DEFINE CLASS appwiz AS custom

	cHookFile = ""
	cHookClass = ""	
	cAppWizForm = ""
	
	PROCEDURE MakeApplication
		LOCAL oStyleRef, oParms , lcOutFile, lcProjectName, llCreateDir
		LOCAL lcHookFile, lcHookClass, lcAppWizForm

		oParms = Create("Custom")
		IF EMPTY(THIS.cAppWizForm)
			lcAppWizForm = m.cWizPath + "\APPWIZ.SCX"
		ELSE
			lcAppWizForm = THIS.cAppWizForm 
		ENDIF

		DO FORM (lcAppWizForm) WITH oParms 

		IF TYPE("oParms.cOutFile")#"C"
			RETURN
		ENDIF
		lcOutFile = oParms.cOutFile
		lcProjectName = oParms.cProjectName
		llCreateDir= oParms.lCreateDir

		oStyleRef = Create("Custom")
		WITH oStyleRef
			.AddProperty("cexistingdbc","")
			.AddProperty("cDatabaseTemplate","")
			.AddProperty("nDatabaseType",1)
			.AddProperty("nWizAction",1)
			.AddProperty("cProjectName",lcProjectName)
			.AddProperty("cOutFile",lcOutFile)
			.AddProperty("lCreateDir",llCreateDir)
			.AddProperty("nProjectType",3)
		ENDWITH

		DO (m.cWizPath+"\WZAPP.APP") WITH "","",oStyleRef

		IF FILE(lcOutFile)
			MODIFY PROJECT (lcOutFile) NOWAIT NOSHOW
			_VFP.Projects[lcOutFile].Build(FORCEEXT(lcOutFile,"APP"),2,.T.)

			* setup project hooks
			LOCAL lcHookFile, lcHookClass
			IF FILE(THIS.cHookFile) AND !EMPTY(THIS.cHookClass)
				* User overrides default class
				lcHookFile = ALLTRIM(THIS.cHookFile)
				lcHookClass = ALLTRIM(THIS.cHookClass)
			ELSE
				lcHookFile = m.cWizPath+"\"+APPHOOK_FILE
				IF !FILE(lcHookFile)
					MESSAGEBOX(C_NOHOOKFILE_LOC)
					RETURN
				ENDIF
				lcHookClass = APPHOOK_CLASS
			ENDIF
			
			_VFP.Projects[lcOutFile].ProjectHookLibrary = lcHookFile
			_VFP.Projects[lcOutFile].ProjectHookClass = lcHookClass
			_VFP.Projects[lcOutFile].Close
			MODIFY PROJECT (lcOutFile) NOWAIT	&&need to close and reopen to setup project hook object
			_SHELL = [DO (_WIZARD) WITH "Project",,"APP",.T.]
		ENDIF

	ENDPROC

ENDDEFINE