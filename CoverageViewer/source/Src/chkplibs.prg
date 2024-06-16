#IF 0                           ChkPLibs.prg

  Purpose:  Check our procs and libs table and do our associated SETs

Revisions:  February 17, 2016 - Ken Green - Adapted from earlier 1/15/10 version

     Uses:  APPINCL.H - Manifest constants

************************** Functions and Procedures *************************

* CheckProcsTable() - Make sure all appropriate items are in the PROCS table
* SetClassProcCmds() - Set our CLASSLIB and PROCEDURE commands
* AddSetCommand() - Add the passed files to the appropriate SET command

*****************************************************************************
#ENDIF

* Includes and defines
#INCLUDE APPINCL.H

* Get our parameters
PARAMETERS cPnLTable, bChkTable, cAppName

* Define our variables' scopes
LOCAL nSeleIn, cSETsOK

* If we're to check the table, do that first
nSeleIn = SELECT()
SELECT 0
cSETsOK = .T.
IF bChkTable
    cSETsOK = CheckProcsTable(cPnLTable)
ENDIF

* Now, go SET our CLASSLIB and PROCEDURE commands
SetClassProcCmds(cPnLTable, bChkTable, cAppName)

* Done
SELECT (nSeleIn)
RETURN cSETsOK


************************** Functions and Procedures *************************

* CheckProcsTable() - Make sure all appropriate items are in the PROCS table
FUNCTION CheckProcsTable(cProcsTbl)
    LOCAL cPTbl, cPrjTbl, cMsg, M.FNAME, M.FDIR, M.TYPE, M.EXCLUDE, ;
      M.DONT_LOAD, bGotSome, cName

    * 1. Open the table or create it if it doesn't exist
    cPTbl = cProcsTbl
    SELECT 0
    DO CASE
    CASE NOT FILE(cPTbl) AND NOT bDEBUGGING
        CREATE TABLE ('META\' + cPTbl) FREE (FNAME C(20), FDIR C(12), ;
          TYPE C(1), EXCLUDE L, DONT_LOAD L)
        INDEX ON UPPER(FNAME) TAG FULLNAME
    CASE USED('PROCLIBS')
        USE IN PROCLIBS
    ENDCASE
    USE (cPTbl) ALIAS PROCLIBS ORDER FULLNAME

    * 2. Open our project file
    cPrjTbl = APP_NAME + '.pjx'
    IF NOT FILE(cPrjTbl)
        cMsg = 'Project file, ' + cPrjTbl + ', not found; must exit.'

        * Display the message for 1 minute
        MESSAGEBOX(cMsg, 0, 'Critical Error', 60000)
        RETURN .F.
    ENDIF
    SELECT 0
    TRY
        USE (cPrjTbl) EXCLUSIVE ALIAS PROJECT
        PACK
    CATCH
        USE (cPrjTbl) AGAIN ALIAS PROJECT
    ENDTRY

    * Get all procedure and class library files except MAIN.PRG
    SELECT STRTRAN(NAME, CHR(0), '') AS FULLNAME, TYPE, ;
      EXCLUDE FROM PROJECT ;
      WHERE (TYPE = "V" OR (TYPE = "P" AND NOT UPPER(NAME) = 'MAIN.PRG')) ;
      AND NOT DELETED() ;
      ORDER BY FULLNAME, TYPE INTO CURSOR PLTemp

    * Make any needed changes
    M.DONT_LOAD = .F.
    SCAN
        SCATTER MEMVAR MEMO
        M.FNAME = JUSTFNAME(FULLNAME)
        M.FDIR = ADDBS( JUSTPATH(FULLNAME) )
        SELECT PROCLIBS
        SEEK UPPER(M.FNAME)
        DO CASE
        CASE NOT FOUND()
            INSERT INTO PROCLIBS FROM MEMVAR
        CASE FDIR <> M.FDIR OR TYPE <> M.TYPE OR EXCLUDE <> M.EXCLUDE
            SELECT PROCLIBS
            REPLACE FDIR WITH M.FDIR, TYPE WITH M.TYPE, EXCLUDE WITH M.EXCLUDE
        ENDCASE
        SELECT PLTemp
    ENDSCAN
    USE IN PLTemp
    USE IN PROJECT
    USE IN PROCLIBS
    RETURN .T.
ENDFUNC

* SetClassProcCmds() - Set our CLASSLIB and PROCEDURE commands
PROCEDURE SetClassProcCmds(cProcsTbl, bAddAllPaths, cAppNm)
    LOCAL cProcs, cLibs, cName

    * What we load depends on a number of factors. Here are the rules:
    *   1. Completely ignore any DONT_LOAD files - programmer's setting for
    *       files to be called directly.
    *   2. Add the path if requested or the file is excluded from the project.
    *   3. For class libraries, append IN <AppName> to the command if it's an
    *       APP or EXE.

    * Open our table
    USE (cProcsTbl) ALIAS PROCLIBS
    SET FILTER TO TYPE $ 'PV' AND NOT DONT_LOAD

    * Go thru the file setting procs and libs names
    STORE '' TO cProcs, cLibs
    cAppFullName = cAppPath + LOWER(cAppNm)
    bAddApp = ('.app' $ cAppFullName OR '.exe' $ cAppFullName)
    SCAN
        * We're to add the path to the name for all EXCLUDE names but, if
        *   bAddAllPaths = .T. we'll do it for all names
        IF EXCLUDE OR bAddAllPaths
            cName = cAppPath + TRIM(FDIR) + '\' + TRIM(FNAME)
        ELSE
            cName = TRIM(FNAME)
        ENDIF

        * Handle the appropriate types
        IF TYPE = 'V'       && VCXs - Class Libraries
            cLibs = cLibs + cName + ','

            * If the command is getting too long, set it now
            IF LEN(cLibs) > 4000
                cLibs = AddSetCommand('CLASSLIB', cLibs)
            ENDIF
        ELSE        && TYPE = 'P'       && PRGs - Programs
            cProcs = cProcs + cName + ','
            IF LEN(cProcs) > 4000
                cProcs = AddSetCommand('PROCEDURE', cProcs)
            ENDIF
        ENDIF
    ENDSCAN
    IF NOT EMPTY(cLibs)
        AddSetCommand('CLASSLIB', cLibs)
    ENDIF
    IF NOT EMPTY(cProcs)
        AddSetCommand('PROCEDURE', cProcs)
    ENDIF
    USE IN PROCLIBS
    RETURN .T.
ENDPROC

* AddSetCommand() - Add the passed files to the appropriate SET command
FUNCTION AddSetCommand(cSetType, cFiles)
    LOCAL cArgs

    * Toss the trailing comma in cFiles
    IF RIGHT(cFiles, 1) = ','
        cFiles = LEFT(cFiles, LEN(cFiles) - 1)
    ENDIF

    * Create our command
    cArgs = cSetType + ' TO ' + cFiles + ' ADDITIVE'
    SET &cArgs
    RETURN ''
ENDFUNC
