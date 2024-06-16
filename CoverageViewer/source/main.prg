#IF 0                       Main.prg (CvgViewr.exe)

  Purpose:  Analyze a COVERAGE log file and put it in an HTML file for drilling
            down to find the slow performer(s).

Revisions:  October 21, 2015 - Ken Green - Original
             1/10/16 - Changed so that if we're debugging, the data goes on
                        ./LogData

     Uses:  APPINCL.H - Manifest constants
            ProcCntl.prg - Handle searching files for the string
            AppForm.VCX - Our process and advisory form
            ChkPLibs.prg - Setup or CLASSLIB and PROCEDURE commands
            HandlErr.prg - Generic error handler
            zSetMgr.prg - Classes for saving and setting SET commands
            zArrays.prg - Special Array handling objects
            kStrings.prg - General purpose String Handling
            KOSFiles.prg - OS Drive, Directory and File handling
            MainProc.prg - Our general utilities
            AppCntls.vcx - Special form control classes
            PIX\WinExitM.WAV - "Bell" sound

************************** Functions and Procedures *************************

* CheckParams() - Check the parameters and return an app edit object

****************************** Class Definitions ****************************

* UtilApp Class Definition - (base: Custom)

*****************************************************************************
#ENDIF

* Includes and Defines
#INCLUDE INC\APPINCL.H

* Get our parameters
PARAMETERS cParm1, cParm2, cParm3, cParm4

* Define our variable's scope
PRIVATE EXIT_2_OS, tcSys16, toErrObj, X_ERRMSG, X_ERRCMD, goApp, goStr, ;
  goFiles, goSETs, S_nFormLeft, S_nFormTop, gbAborted, gbGotBug, goProcess
LOCAL nNumParms, oGlobalSets, cPosnFile, oForm

* Preliminary setup
nNumParms = PCOUNT()

* Save our global SETtings and set some special stuff we'll use
goSETs = NEWOBJECT('zSetManager', 'libs\zSetMgr.prg')
oGlobalSets = goSETs.SaveGlobal(.T.)
SYS(3050, 1, 1023410160)     && Only have VFP use 10 Mb of memory

* Setup our error handler
EXIT_2_OS = .T.
STORE .F. TO tcSys16, toErrObj
X_ERRMSG = ''
X_ERRCMD = ''
ON ERROR DO LIBS\HANDLERR WITH ERROR(), PROGRAM(), LINENO(), tcSys16, toErrObj

* Create our application object
goApp = CREATEOBJECT('UtilApp')
ON ERROR DO HANDLERR WITH ERROR(), PROGRAM(), LINENO(), tcSys16, toErrObj
EXIT_2_OS = .F.

* Setup our common objects
goStr = CREATEOBJECT('KStrings')
goFiles = CREATEOBJECT('KOSFiles')

* Create our default variables then go check our parameters
goApp.oAppEdit = CheckParams(cParm1, cParm2, cParm3, cParm4, nNumParms)

* Get our saved forn position variables (if any)
STORE 0 TO S_nFormLeft, S_nFormTop
cPosnFile = goApp.cAppPath + APP_NAME + '.MEM'
IF FILE(cPosnFile)
    RESTORE FROM (cPosnFile) ADDITIVE
ENDIF

* Setup some global control variables
gbAborted = .F.
gbGotBug = .F.

* Create our processing object
goProcess = CREATEOBJECT('ProcCntl')

set print to RunLog.txt
set print on
? 'goProcess = ' + VARTYPE(goProcess) + ' at ' + TIME()

* Show our form
oForm = CREATEOBJECT('AppForm')

? 'oForm = ' + VARTYPE(oForm) + ' at ' + TIME()

oForm.Show()

* Can we just run our process
IF goApp.oAppEdit.oForm.OKToRun()
    goApp.oAppEdit.oForm.btnProcess.Enabled = .T.
    KEYBOARD "{ENTER}" PLAIN
ENDIF

? 'OKToRun()= ' + TRANSFORM(goApp.oAppEdit.oForm.OKToRun(), 'Y') + ' at ' + TIME()

READ EVENTS

? 'Passed READ EVENTS' + ' at ' + TIME()
set print off
set print to

* Save our form and control S_ variables
SAVE ALL LIKE S_* TO (cPosnFile)

* Clean up and we're done
IF NOT ISNULL(goApp.oAppEdit.oForm)
    goApp.oAppEdit.oForm = NULL
ENDIF
IF NOT ISNULL(oForm)
    oForm.Release()
ENDIF
goProcess.Release()
IF NOT ISNULL(oGlobalSets)
    oGlobalSets.Release()
ENDIF
goApp.Release()
goStr.Release()
goFiles.Release()
goSETs.Release()

* Done
QUIT


************************** Functions and Procedures *************************

* CheckParams() - Check the parameters and return an app edit object
FUNCTION CheckParams(cPar1, cPar2, cPar3, cPar4, nParCnt)
    LOCAL oEdit

    * First create an app edit object
    oEdit = CREATEOBJECT('Empty')
    ADDPROPERTY(oEdit, 'oForm', NULL)
    ADDPROPERTY(oEdit, 'cLogFile', '')
    ADDPROPERTY(oEdit, 'cProjFile', '')
    ADDPROPERTY(oEdit, 'bGoToIt', .F.)
    ADDPROPERTY(oEdit, 'bNeedProj', .F.)
    ADDPROPERTY(oEdit, 'bKeepTbls', .F.)
    IF goApp.bDEBUGGING
        oEdit.bKeepTbls = .T.
    ENDIF

    * If we have any parameters, load them up
    IF nParCnt > 0
        IF NOT EMPTY(cPar1)
            oEdit.cLogFile = cPar1
        ENDIF
        IF nParCnt > 1
            IF LEN(cPar2) = 1
                oEdit.bGoToIt = UPPER(cPar2) $ 'YT'
                IF nParCnt > 2
                    oEdit.bKeepTbls = UPPER(cPar3) $ 'YT'
                ENDIF
            ELSE
                oEdit.cProjFile = cPar2
                IF nParCnt >= 3
                    oEdit.bGoToIt = UPPER(cPar3) $ 'YT'
                    IF nParCnt = 4
                        oEdit.bKeepTbls = UPPER(cPar3) $ 'YT'
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDIF
    RETURN oEdit
ENDFUNC


****************************** Class Definitions ****************************

* UtilApp Class Definition - (base: Custom)
DEFINE CLASS UtilApp AS Custom

    * Key Properties
    cAppName    = ''            && Our app's name
    cAppSubDirs = 'SRC,LIBS,META,INC,PIXS'      && App's subdirectories
    cStartupDir = ''            && Current directory upon startup
    cAppPath    = ''            && Location of main program file: prg, app, exe
    bIsRunTime  = .F.           && .T. if we're a run-time app
    bDEBUGGING  = .F.           && .T. if we're debugging
    bIsDev      = .F.           && .T. this is the developer
    cDataPath   = ''            && Path to our working tables
    oAppEdit    = NULL          && Edit object for processing parameters

    * Other properties

    * Custom Method List (code below):
    *- Init() - Set ourselves up
    *-  SetupApp() - Do the detailed setup steps
    *-   PathsNProcs() - Set the PATH, CLASSLIB and PROCEDURE stuff
    *-    GetAppNameNPath() - Get our application's Name and PATH
    *- Error() - Our error handler
    *- Destroy() - Cleanup after ourselves
    *- Release() - Remove ourselves from memory

    * Custom Method Code:

    *- Init() - Set ourselves up
    FUNCTION Init()
        IF NOT DODEFAULT()
            RETURN .F.
        ENDIF
        THIS.SetupApp()
        RETURN .T.
    ENDFUNC

    *- SetupApp() - Do the detailed setup steps
    FUNCTION SetupApp()

        * Setup our path and procedures
        IF NOT THIS.PathsNProcs()
            QUIT        && Any messages already displayed
        ENDIF

        * Define our data folder; default = TEMP folder
        IF THIS.bDEBUGGING
            THIS.cDataPath = '.\LogData\'
        ELSE
            THIS.cDataPath = ADDBS(GETENV('TEMP'))
        ENDIF

        * Done
    ENDFUNC

    *- PathsNProcs() - Set the PATH, CLASSLIB and PROCEDURE stuff
    FUNCTION PathsNProcs()
        LOCAL cPath2Do, cCmd, nPosn, cDir, nCnt, aTemp[1], cProcLibsTable, bAllOK

        * We're to:
        *   1. Setup some operational variables
        *   2. Set the application's PATHs
        *   3. Issue our CLASSLIB and PROCEDURE SET commands
        *   4. Setup our "Bell" file
        * We'll return .T. if all went OK or .F. if not

        * Setup the operational variables
        THIS.cStartupDir = SET('DEFAULT') + ADDBS(SYS(2003))
        THIS.bIsRunTime = (VERSION(2) = 0)
        THIS.bDEBUGGING = (FILE('ADSDEBUG.TXT') AND NOT THIS.bIsRunTime)

        * Now, get our application's path
        THIS.cAppPath = THIS.GetAppNameNPath(Application.StartMode)

        * Is this the developer?
        THIS.bIsDev = THIS.bDEBUGGING AND NOT ('.APP' $ THIS.cAppName OR ;
          '.EXE' $ THIS.cAppName)

        * Define our desired path: we want a complete path if this is an FXP -
        *   NOT if this is an APP or EXE.
        cPath2Do = THIS.cAppSubDirs
        IF RIGHT(cPath2Do,1) <> ','
            cPath2Do = cPath2Do + ','
        ENDIF
        cCmd = THIS.cAppPath
        IF '.FXP' $ THIS.cAppName

            * Add the passed directories to our command line
            DO WHILE NOT EMPTY(cPath2Do)
                nPosn = AT(',', cPath2Do)
                cDir = LEFT(cPath2Do, nPosn-1)
                cPath2Do = SUBSTR(cPath2Do,nPosn+1)
                cCmd = cCmd + ';' + THIS.cAppPath + cDir
            ENDDO
        ELSE

            * Toss INC as that's not needed here
            cPath2Do = STRTRAN(cPath2Do, 'INC,', '')

            * Load the rest up but only if the directories exist
            DO WHILE NOT EMPTY(cPath2Do)
                nPosn = AT(',', cPath2Do)
                cDir = LEFT(cPath2Do, nPosn-1)
                cPath2Do = SUBSTR(cPath2Do,nPosn+1)
                nCnt = ADIR( aTemp, cDir, "D")
                IF nCnt > 0 AND 'D' $ aTemp[1,5]
                    cCmd = cCmd + ';' + THIS.cAppPath + cDir
                ENDIF
            ENDDO
        ENDIF
        SET PATH TO &cCmd

        * If this is the developer and we're not debugging, create/update our
        *   procs and libs file
        PRIVATE bDEBUGGING, cAppPath
        bDEBUGGING = THIS.bDEBUGGING
        cAppPath = THIS.cAppPath
        cProcLibsTable = 'ProcLibs.dbf'
        bAllOK = ChkPLibs(cProcLibsTable, THIS.bIsDev, THIS.cAppName)

        * 4. Setup our "Bell" file
        SET BELL TO 'WinExitM.wav'
        SET BELL ON
        RETURN bAllOK
    ENDFUNC

    *- GetAppNameNPath() - Get our application's Name and PATH
    PROCEDURE GetAppNameNPath(nStartMode)
        LOCAL nBytes, cAppPath, nLastSlash, aPgms[1,6], nCount

        * Use the API to retrieve the EXE file name
        DECLARE integer GetModuleFileName IN WIN32API ;
          integer hinst, string @lpszFilename, integer @cbFileName
        cAppPath = SPACE(256)
        nBytes = 255
        nBytes = GetModuleFileName(0, @cAppPath, @nBytes)
        cAppPath = LEFT(cAppPath, nBytes)

        * Get our application's startup directory based on Application.StartMode:
        *   1 - VFP non-Runtime Out-of-Process OLE server started as:
        *         oMyObject = CREATEOBJECT('VisualFoxPro.Application')
        *   0 - Normal, VFP interactive session.
        *   2 - Runtime Out-of-Process .EXE Automation Server
        *   3 - Runtime In-Process .DLL Automation Server
        *   4 - VFP Distributable APP or EXE
        *   5 - Runtime In-Process .DLL Automation Server for multithreaded use
        DO CASE

        * Runtime Out-of-Process OLE Server
        CASE nStartMode = 2

            * Do nothing; already done above

        * Runtime In-Process OLE Server
        CASE nStartMode = 3
            cAppPath = HOME() + SYS(16, 0)

        * Everything else
        *   StartMode = 0 - Normal, VFP interactive session.
        *   StartMode = 1 - VFP non-Runtime Out-of-Process OLE server.
        *   StartMode = 4 - VFP Distributable APP or EXE
        *   StartMode = 5 - Runtime In-Process .DLL Automation Server for multithreaded use
        OTHERWISE
            cAppPath = SYS(16, 0)   && Startup program name
        ENDCASE
        cAppPath = UPPER(cAppPath)

        * Make sure we can handle different directory separators
        IF '/' $ cAppPath
            cAppPath = STRTRAN( cAppPath, '/', '\')
        ENDIF
        IF '\\' $ cAppPath
            cAppPath = STRTRAN( cAppPath, '\\', '\')
        ENDIF

        * Find the last directory separator
        nLastSlash = RAT('\', cAppPath)
        IF nLastSlash = 0       && No separator, how about a drive
            nLastSlash = RAT(':', cAppPath)
        ENDIF

        * Extract the filename if the last character is not '\' or ':'
        IF nLastSlash > 0 AND NOT RIGHT(cAppPath,1) $ '\:'
            cAppPath = LEFT(cAppPath, nLastSlash)
        ENDIF

        * Get our correct topmost program file (not FOX*.EXE)
        nCount = aStackInfo( aPgms )

        * Our top level program is in [1,2]
        THIS.cAppName = UPPER( JUSTFNAME(aPgms[1,2]) )

        * Return the path
        RETURN cAppPath
    ENDFUNC

    *- Error() - Our error handler
    PROCEDURE Error
        LPARAMETERS nError, cMethod, nLine, tcSys16, toErrObj
        LOCAL lcName

        * If tcSys16 is empty, it indicates this object is the source of the error. If
        *   so, set tcSys16 to SYS(16) and make toErrObj a reference to this object
        IF EMPTY(tcSys16)
            tcSys16 = SYS(16)
            toErrObj = THIS
        ENDIF

        * Handle the error
        HANDLERR(nError, cMethod, nLine, tcSys16, toErrObj)
    ENDPROC

    *- Destroy() - Cleanup after ourselves
    FUNCTION Destroy()
        THIS.oAppEdit = NULL
        DODEFAULT()
    ENDFUNC

    *- Release() - Remove ourselves from memory
    FUNCTION Release()
        THIS.Destroy()
        RELEASE THIS
    ENDFUNC
ENDDEFINE
