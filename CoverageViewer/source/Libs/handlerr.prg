#IF 0                            HANDLERR.PRG

  Purpose:  Generic Windows app-wide error handler

Revisions:  July 10, 2003 - Ken Green - Original - Adapted from an earlier
                        version dated 3/06/2001 with revisions up to 1/19/10

******************************* Program Notes *******************************

Parameters:
    nError - The error number - from ERROR()
    cPgm - The calling program/method name only: hard-coded or PROGRAM()
    nLine - The offending line number - from LINENO()
    cSys16 - (Optional) The program file name with path
    oErrObj - (Optional) The object with the error

Setup:
    1. Use ON ERROR HANDLERR( ERROR(), PROGRAM(), LINENO() ) to
        set this up as a global error handler.  Clear this with: ON ERROR.
    2. For programmer-defined errors, do the following:
        A. Define the global variables:
            X_ERRMSG - The error message
            X_ERRCMD - The command line causing the error
        B. Call this as: HANDLERR( 6969, PROGRAM(), LINENO(), SYS(16), THIS )

Actions:
    1. An advisory window is displayed
    2. Error information is put into files named: ERnnnnnn.TXT for later
        review by the programmer
    3. If EXIT_2_OS has been defined and is .T., control will return to
            the OS
       Else, RETURN TO MASTER is executed after closing the ActiveForm

****************************** Classes Defined ******************************

* ErrorHandler Class Definition - (base: Relation)
* BugForm Class Definition - (base: Form)
*  imgStop Class Definition - (subclass of: Image; base: image)
*  lblBugMsg Class Definition - (subclass of: Label; base: label)
*  edtBugMsg Class Definition - (subclass of: Editbox; base: editbox)
*  lblProgram Class Definition - (subclass of: Label; base: label)
*  txtProgram Class Definition - (subclass of: Textbox; base: textbox)
*  lblNote Class Definition - (subclass of: Label; base: label)
*  shpBug1 Class Definition - (subclass of: Shape; base: shape)
*  shpBug2 Class Definition - (subclass of: Shape; base: shape)
*  cmdContinue Class Definition - (subclass of: CommandButton; base: commandbutton)
*  tmrTimer Class Definition - (base: Timer)

*****************************************************************************
#ENDIF

* Includes
#INCLUDE 'INC\APPINCL.H'

* Some other defines
#DEFINE FORMFEED     CHR(12)
#DEFINE HEX_0        CHR(0)
#DEFINE HEX_FF       CHR(255)

* Get our parameters
PARAMETERS er_nError, er_cPgm, er_nErrLine, er_cSys16, er_oErrObj

* Make sure our X_ variables exist (they can sometimes be gone if we end too
*   soon and objects are still being destroyed)
IF VARTYPE(X_ERRMSG) <> 'C'
    X_ERRMSG = ''
ENDIF
IF VARTYPE(X_ERRCMD) <> 'C'
    X_ERRCMD = ''
ENDIF

* Make sure we have a line number
IF VARTYPE(er_nErrLine) <> 'N'
    er_nErrLine = 0
ENDIF

* Create our error object
LOCAL oErrObj
oErrObj = CREATEOBJECT('ErrorHandler')

* Go handle the error
oErrObj.HandleError(er_nError, er_cPgm, er_nErrLine, er_cSys16, er_oErrObj)

* Nothing left to do
QUIT


**************************** Class Definitions ******************************

* ErrorHandler Class Definition - (base: Relation)
DEFINE CLASS ErrorHandler AS Relation

    * Properties
    Name = "ErrorHandler"
    cOldErrorMgr = ''       && Original "ON ERROR" setting at startup
    cOnError = "ON ERROR HANDLERR( ERROR(), PROGRAM(), LINENO(), tcSys16, " + ;
      "toErrObj)"

    * Actual error info
    nError = 0              && The VFP Error number
    cErrorMessage = ''      && Text of the error messsage
    cErrorCmd = ''          && The command line that had the error
    cErrorProgram = ''      && Program/method where error occurred
    nErrorLine = 0          && The code line number that caused the error
    cSys16 = ''             && Executing program's filename (with path)
    oErrObj = .NULL.        && Active object when error occurred
    DIMENSION aErrorInfo[1] && Error info set in ErrorHandler()

    * Custom Method List (code below):
    *- Init() - Add any contained objects
    *- ErrorHandler() - Handle an error
    *- HandleError() - Handle an error
    *- CloseErroredForms() - Close forms affected by the current bug
    *- KillForm() - Release a form (affected by bug)
    *- GetFormWithError() - Return the error object's form (if any)
    *- GetSaveFileName() - Return a filename to use for saving error info
    *- CreateErrorFile() - Create our error file
    *- GetPgmHierarchy() - Return an array of the program hierarchy
    *- RetFileDate() - Return the date/time for the passed filename
    *- ResetErrorInfo() - Create an array of detailed error info
    *- ShowDataFiles() - List the current DBF information
    *- ListSessionDBFS() - List the data files for the passed data session
    *- PrintDBFInfo() - Print a DBF's current status
    *- ConvertField - Convert a field's contents for printing
    *- ShowError - Display the error message box
    *- MakeLength - Return a string at the length specified (space filled if needed)
    *- CopyRight - Our copyright notice
    *- RestoreOrigHandler - Restores the original Error Handler
    *- Destroy - Restore the original ON ERROR routine
    *  Release() - Remove ourselves from memory

    * Method Code:

    *- Init() - Set ourselves up
    FUNCTION Init()
        IF NOT DODEFAULT()
            RETURN .F.
        ENDIF

        * Save the current value of ON ERROR
        THIS.cOldErrorMgr = ON('ERROR')
        RETURN .T.
    ENDFUNC

    *- ErrorHandler() - Handle an error
    FUNCTION ErrorHandler(er_nError, er_cPgm, er_nErrLine, er_cSys16, er_oErrObj)

        * Note: These parameters are REQUIRED for MereMortals as many objects
        *       (classes) have error methods using them.

        * This is just a stub for HandleError() as MM calls ErrorHandler()
        RETURN THIS.HandleError(er_nError, er_cPgm, er_nErrLine, er_cSys16, ;
          er_oErrObj)
    ENDFUNC

    *- HandleError() - Handle an error
    PROCEDURE HandleError()
        PARAMETERS er_nError, er_cPgm, er_nErrLine, er_cSys16, er_oErrObj

        * Note: The parameters must be PRIVATE so they're visible to lower-
        *       level methods.
        * Define our variables' scopes
        LOCAL bProgDef, nReply, bDebug, nCount, nBugNumber, cPgmMsg, ;
          nWaitSecs, oMsg, cMsgStr
        PRIVATE er_oActivFrm, er_cTalk, er_cDele, er_wTopWind, er_cOnError, ;
          er_cOnKey, er_cOnEsc, er_cDevice, er_cPrint, er_cPrintFile, ;
          er_cSaveFile, er_cErrMsg, er_cErrPgm, er_cCallBy1, er_cCallBy2, ;
          er_cCmd

        * Save these parameters to our properties
        IF VARTYPE(X_ERRMSG) = 'C' AND NOT EMPTY(X_ERRMSG)
            IF VARTYPE(X_ERRCMD) <> 'C'
                X_ERRCMD = ''
            ENDIF
            THIS.cErrorMessage = X_ERRMSG
            THIS.cErrorCmd = X_ERRCMD
            X_ERRMSG = ''
            X_ERRCMD = ''
            bProgDef = .T.
        ELSE

            * Make sure our X_ variables exist (they can sometimes be gone if
            *   we end too soon and objects are still being destroyed)
            IF VARTYPE(X_ERRMSG) <> 'C'
                X_ERRMSG = ''
            ENDIF
            IF VARTYPE(X_ERRCMD) <> 'C'
                X_ERRCMD = ''
            ENDIF
            THIS.cErrorMessage = MESSAGE()
            THIS.cErrorCmd = MESSAGE(1)
            bProgDef = .F.
        ENDIF

        * Save the ON settings; but clear them to prevent eternal loops or unwanted
        *   actions while here.  (Note that we can't handle ON KEY LABEL unless we
        *   go through the entire label list for tests.)
        er_cOnError = ON('ERROR')
        ON ERROR
        er_cOnKey = ON('KEY')
        ON KEY
        er_cOnEsc = ON('ESCAPE')
        ON ESCAPE

        * Save some basic SETs
        er_cTalk = SET("TALK")                 && ON or OFF
        SET TALK OFF
        er_cDele = SET("DELETED")              && ON or OFF
        SET DELETED ON

        * From here on, we have to handle the error.  Start by saving the
        *   error parameters
        THIS.nError = er_nError
        THIS.cErrorProgram = er_cPgm
        THIS.nErrorLine = er_nErrLine
        THIS.cSys16 = er_cSys16
        IF VARTYPE(er_oErrObj) = 'O'
            THIS.oErrObj = er_oErrObj
        ENDIF

        * Create an array containing information about the error
        AERROR(THIS.aErrorInfo)

        * Define the currently active form
        er_oActivFrm = .NULL.
        IF TYPE('_Screen.ActiveForm') = 'O'
            er_oActivFrm = _Screen.ActiveForm
        ENDIF
        er_wTopWind = WOUTPUT()

        * Make sure our paths exist
        IF VARTYPE(goApp) <> "O" OR ISNULL(goApp)
            goApp = CREATEOBJECT('Empty')
            ADDPROPERTY(goApp, 'cAppPath', SET('DEFAULT') + CURDIR())
            ADDPROPERTY(goApp, 'cStartupDir', goApp.cAppPath)
            PRIVATE cSrcPath, cLibsPath
            IF VERSION(2) = 0       && Run-time
                cSrcPath = goApp.cAppPath
                cLibsPath = goApp.cAppPath
            ELSE
                cSrcPath = goApp.cAppPath + 'SRC\'
                cLibsPath = goApp.cAppPath + 'LIBS\'
            ENDIF
            ADDPROPERTY(goApp, 'cSrcPath', cSrcPath)
            ADDPROPERTY(goApp, 'cLibsPath', cLibsPath)
        ENDIF
        IF VARTYPE(goApp.cAppPath) <> 'C'
            goApp.cAppPath = SET('DEFAULT') + CURDIR()
        ENDIF
        IF VARTYPE(cSrcPath) <> 'C'
            PRIVATE cSrcPath
            IF VERSION(2) = 0       && Run-time
                cSrcPath = goApp.cAppPath
            ELSE
                cSrcPath = goApp.cAppPath + 'SRC\'
            ENDIF
        ENDIF
        IF VARTYPE(cLibsPath) <> 'C'
            PRIVATE cLibsPath
            IF VERSION(2) = 0       && Run-time
                cLibsPath = goApp.cAppPath
            ELSE
                cLibsPath = goApp.cAppPath + 'LIBS\'
            ENDIF
        ENDIF

        * Turn the printer off, if it's on
        er_cDevice = (SYS(101) = 'PRINT')       && SET DEVICE TO argument
        er_cPrint = (SYS(102) = 'ON')           && SET PRINT ON/OFF argument
        er_cPrintFile = SET("PRINT",1)          && SET PRINT TO filename
        IF er_cDevice
            SET DEVICE TO SCREEN
        ENDIF
        IF er_cPrint
            SET PRINT OFF
        ENDIF

        * Develop the file name to use for saving stuff
        nBugNumber = 0
        er_cSaveFile = THIS.GetSaveFileName( @nBugNumber )

        * Create our error file
        STORE '' TO er_cErrPgm, er_cCallBy1, er_cCallBy2, er_cCmd
        er_cErrMsg = THIS.cErrorMessage
        THIS.CreateErrorFile(er_oActivFrm)

        * Do we have an exit to OS variable?
        IF VARTYPE(EXIT_2_OS) <> 'L'
            EXIT_2_OS = .F.
        ENDIF
        CLEAR TYPEAHEAD

        * Overlay a message window
        cPgmMsg = ''
        IF LEN(er_cCallBy1) > 0
            cPgmMsg = ' (from ' + TRIM(er_cCallBy1)
            IF LEN(er_cCallBy2) > 0
                cPgmMsg = cPgmMsg + ' and ' + TRIM(er_cCallBy2)
            ENDIF
            cPgmMsg = cPgmMsg + ')'
        ENDIF
        cPgmMsg = 'Program: ' + er_cErrPgm + cPgmMsg + ' at line: ' + ;
          LTRIM(STR(er_nErrLine))
        IF EXIT_2_OS
            nWaitSecs = 60
        ELSE
            nWaitSecs = 15
        ENDIF
        oMsg = CREATEOBJECT("BugForm", nBugNumber, er_cErrMsg, cPgmMsg, nWaitSecs, ;
          er_oActivFrm)
        cMsgStr = "The bug info has been saved; please advise the programmer."
        oMsg.ShowMsg( cMsgStr )

        * Rollback any open transaction
        IF TXNLEVEL() > 0
            ROLLBACK
        ENDIF

        * Exit to the OS if we're supposed to
        IF EXIT_2_OS
            ON SHUTDOWN
            QUIT
        ELSE

            * Close affected form(s)
            THIS.CloseErroredForms(@er_oActivFrm, @er_oErrObj)
        ENDIF

        * Done
        gbGotBug = .T.
        gbAborted = .T.
        UNLOCK ALL
        IF VARTYPE(oMsg) = 'O'
            oMsg.Release()
        ENDIF

        * Make sure we're on the appropriate directory
        CD (goApp.cStartupDir)

        * Finish this off
        ON ERROR &er_cOnError
        SET TALK OFF
        SET DELETED &er_cDele
        CLEAR EVENTS
        RETURN TO MASTER
    ENDPROC

    *- CloseErroredForms() - Close forms affected by the current bug
    PROCEDURE CloseErroredForms(oActivFrm, oErrObj)
        LOCAL oParent, bGotActiveFrm

        * Get the parent form for the error object
        oParent = .NULL.
        IF VARTYPE(oErrObj) = [O] AND NOT ISNULL(oErrObj)
            oParent = THIS.GetFormWithError(oErrObj)
        ENDIF
        STORE .NULL. TO THIS.oErrObj, oErrObj

        * Kill the parent unless it's also the active form
        bGotActiveFrm = (VARTYPE(oActivFrm) = 'O' AND NOT ISNULL(oActivFrm))
        IF (NOT ISNULL(oParent)) AND bGotActiveFrm AND ;
          NOT oParent.Name = oActivFrm.Name
            THIS.KillForm(oParent)
        ENDIF

        * Done
        RETURN
    ENDPROC

    *- KillForm() - Release a form (affected by bug)
    PROCEDURE KillForm(oForm)
        LOCAL cStr

        * Call its Release() method if it has one
        IF PEMSTATUS(oForm,'Release', 5)
            oForm.Release()
        ELSE
            RELEASE &oForm
        ENDIF

        * Done
        RETURN
    ENDPROC

    *- GetFormWithError() - Return the error object's form (if any)
    FUNCTION GetFormWithError(oErrObj)
        LOCAL oRetObj, oCkObj
        oRetObj = .NULL.
        oCkObj = oErrObj
        DO WHILE PEMSTATUS(oCkObj, 'Parent', 5) AND ;
          TYPE("oCkObj.Parent") = [O] AND ;
          NOT ISNULL(oCkObj.Parent)
            IF oCkObj.Parent.BaseClass = 'Form'
                oRetObj = oCkObj.Parent
                EXIT
            ENDIF
            oCkObj = oCkObj.Parent
        ENDDO
        RETURN oRetObj
    ENDFUNC

    *- GetSaveFileName() - Return a filename to use for saving error info
    FUNCTION GetSaveFileName( nBugNumber )
        LOCAL cFileStart, nFileNumb, cSaveName, bCanUse, nFileHndl, nWriteLen

        * Our filenames will be ERnnnnnn.TXT where nnnnnn is a number
        *   continually incremented so we don't overwrite files
        cFileStart = goApp.cAppPath + 'ER'
        nFileNumb = 1

        * Keep going until we get a file name to use
        DO WHILE .T.
            cSaveName = cFileStart + PADL(nFileNumb, 6, '0') + '.TXT'

            * See if the file exists (returns null string if not)
            bCanUse = ( LEN( SYS(2000, cSaveName) ) = 0 )

            * If this is OK, create a tiny file to reserve the name
            IF bCanUse
                nFileHndl = FCREATE(cSaveName)      && Create the file
                bCanUse = ( nFileHndl > 0 )         && Somebody beat us to it
            ENDIF

            * Write a CR, LF to the file and close it
            IF bCanUse
                nWriteLen = FPUTS(nFileHndl,'')
                bCanUse = ( nWriteLen = 2 )
                FCLOSE(nFileHndl)                   && Close the file
            ENDIF

            * If that succeeded, we're done
            IF bCanUse
                EXIT
            ENDIF

            * Otherwise, get another file name
            nFileNumb = nFileNumb + 1
        ENDDO

        * Note our bug number
        nBugNumber = nFileNumb

        * Done
        RETURN cSaveName
    ENDFUNC

    *- CreateErrorFile() - Create our error file
    PROCEDURE CreateErrorFile(er_oActivFrm)
        LOCAL nDataSession, er_cUserMem, er_dDate, er_cTime, er_cFoxVer, ;
          er_cDosVer, er_cCpu, er_cFiles, er_nDiskSpace, er_cOSPath, ;
          er_nPgmCnt, ;
          er_margin, er_opsys, er_alte, er_altefl, er_autsav, er_bell, ;
          er_blink, er_carry, er_cent, er_clear, er_clock, er_color, ;
          er_colatt, er_compat, er_conf, er_crncpo, er_currnc, er_dDatest, ;
          er_deci, er_dele, er_deli, er_deve, er_dohist, er_escape, er_exact
        LOCAL er_excl, er_fields, er_fixed, er_fulpat, er_head, er_help, ;
          er_help1, er_hours, er_inten, er_mark, er_memo, er_mnmsgr, ;
          er_mnmsg, er_mouse, er_mousen, er_near, er_notif, er_odom, er_path, ;
          er_resrc, er_resrcf, er_safety, er_separ, er_shadow, er_space, ;
          er_status, er_score, er_type, er_unique, er_lock, er_multil, ;
          er_refrsh, er_reproc, er_comspec, nX, ep_cDate, ep_cExec, ep_cName, ;
          ep_nLine, ep_cCmd, er_aPgms, nRows, nSession

        * Save the current data session and setup the data session for the
        *   active form
        nDataSession = SET('DataSession')
        nSession = 1
        IF NOT ISNULL(er_oActivFrm)
            nSession = er_oActivFrm.DataSessionID
        ENDIF
        SET DATASESSION TO (nSession)

        * Record the current date and time and memory availability
        er_cUserMem = SYS(1016)
        er_dDate = DATE()
        er_cTime = TIME()
        er_cFoxVer = VERSION(1)
        er_cDosVer = OS()
        er_cCpu = SYS(17)
        er_cFiles = SYS(2010)
        er_nDiskSpace = DISKSPACE()
        er_cOSPath = GETENV('PATH')

        * Get the calling program hierarchy and some related variables but
        *   don't include any error handling programs/methods
        *   er_aPgms[x,1] - Col. 2's file date and time as: mm/dd/yyyy hh:mm:ss
        *   er_aPgms[x,2] - Executing file name (APP, EXE, FXP)
        *   er_aPgms[x,3] - Module or object name
        *   er_aPgms[x,4] - Source filename (PRG, VCX...)
        *   er_aPgms[x,5] - Line number in module or object source file
        *   er_aPgms[x,6] - Program line containing error
        STORE '' TO er_cErrPgm, er_cCallBy1, er_cCallBy2, er_cCmd
        DIMENSION er_aPgms[1,6]
        DIMENSION er_aErrorCalls[1,6]
        er_nErrorCnt = 0
        er_nPgmCnt = THIS.GetPgmHierarchy( @er_aPgms, @er_cErrPgm, ;
          @er_cCallBy1, @er_cCallBy2, @er_cCmd, @er_aErrorCalls, @er_nErrorCnt)

        * Save the margin setting and change the margin to 0 for our error file
        er_margin = SET("MARGIN")               && 0 to 254
        SET MARGIN TO 0

        * Save the SET definitions (except for DEBUG, ECHO and STEP).  Note that
        *   the following variables have already been set:
        *       er_cDevice (L) = the SET DEVICE ON/OFF status
        *       er_cPrint (L) = the SET PRINT ON/OFF status.
        *       er_cPrintFile   = the SET PRINT TO filename status.
        er_opsys  = OS()
        er_alte   = SET("ALTERNATE")            && ON or OFF
        er_altefl = SET("ALTERNATE",1)          && filename
        er_autsav = SET("AUTOSAVE")             && ON or OFF
        er_bell   = SET("BELL")                 && ON or OFF
        er_blink  = SET("BLINK")                && ON or OFF
        er_carry  = SET("CARRY")                && ON or OFF
        er_cent   = SET("CENTURY")              && ON or OFF
        er_clear  = SET("CLEAR")                && ON or OFF
        er_clock  = SET("CLOCK")                && ON or OFF
        er_color  = SET("COLOR")                && ON or OFF
        er_colatt = SET("COLOR",1)              && color setting
        er_compat = SET("COMPATIB")             && ON or OFF
        er_conf   = SET("CONFIRM")              && ON or OFF
        er_crncpo = SET("CURRENCY")             && LEFT or RIGHT
        er_currnc = SET("CURRENCY",1)           && TO <expC>
        er_dDatest = SET("DATE")                 && ANSI, AMERICAN, BRITISH, ITALIAN
                                                     *   FRENCH, or GERMAN
        er_deci   = SET("DECIMALS")             && 0 to 14
        er_dele   = SET("DELETED")              && ON or OFF
        er_deli   = SET("DELIMITED")            && ON or OFF
        er_deve   = SET("DEVELOPMENT")          && ON or OFF
        er_dohist = SET("DOHISTORY")            && ON or OFF
        er_escape = SET("ESCAPE")               && ON or OFF
        er_exact  = SET("EXACT")                && ON or OFF
        er_excl   = SET("EXCLUSIVE")            && ON or OFF
        er_fields = SET("FIELDS")               && ON or OFF
        er_fixed  = SET("FIXED")                && ON or OFF
        er_fulpat = SET("FULLPATH")             && ON or OFF
        er_head   = SET("HEADING")              && ON or OFF
        er_help   = SET("HELP")                 && ON or OFF
        er_help1  = SET("HELP,1")               && filename
        er_hours  = SET("HOURS")                && 12/24
        er_inten  = SET("INTENSITY")            && ON or OFF
        er_mark   = SET("MARK")                 && date separator
        er_memo   = SET("MEMOWIDTH")            && 8 to 8192
        er_mnmsgr = SET("MESSAGE")              && menu message row - numeric
        er_mnmsg  = SET("MESSAGE",1)            && menu message
        er_mouse  = SET("MOUSE")                && ON or OFF
        er_mousen = SET("MOUSE",1)              && mouse value - numeric
        er_near   = SET("NEAR")                 && ON or OFF
        er_notif  = SET("NOTIFY")               && ON or OFF
        er_odom   = SET("ODOMETER")             && expN
        er_path   = SET("PATH")                 && path
        er_resrc  = SET("RESOURCE")             && ON or OFF
        er_resrcf = SET("RESOURCE",1)           && filename
        er_safety = SET("SAFETY")               && ON or OFF
        er_separ  = SET("SEPARATOR")            && number separator
        er_shadow = SET("SHADOWS")              && ON or OFF
        er_space  = SET("SPACE")                && ON or OFF
        er_status = SET("STATUS")               && ON or OFF
        er_score  = SET("SCOREBOARD")           && ON or OFF
        er_type   = SET("TYPE")                 && 0 to 3200 (TYPEAHEAD)
        er_unique = SET("UNIQUE")               && ON or OFF

        * Now for the multi-user stuff
        er_lock   = SET("LOCK")             && ON or OFF
        er_multil = SET("MULTILOCKS")       && ON or OFF
        er_refrsh = SET("REFRESH")          && value
        er_reproc = SET("REPROCESS")        && value

        * Get the environment's COMSPEC
        er_comspec = GETENV('COMSPEC')

        * Save the current memory contents to a TXT file
        SET PRINT TO (er_cSaveFile)
        SET CONSOLE OFF
        SET PRINT ON
        SET MEMOWIDTH TO 2000

        * Put our main variables on top
        ?? 'ERROR: ' + er_cErrMsg
        IF er_cCmd <> er_cErrMsg
            ? '      Command: ' + er_cCmd
        ENDIF
        ? '      Program: ' + er_cErrPgm + ' at line ' + LTRIM(STR(er_nErrLine))
        IF .NOT. EMPTY(er_cCallBy1)
            ? '    Called by: ' + er_cCallBy1
            IF .NOT. EMPTY(er_cCallBy2)
                ?? ' (which was called by: ' + er_cCallBy2 + ')'
            ENDIF
        ENDIF
        ? '    Date/Time: ' + DTOC(er_dDate) + ' at ' + er_cTime
        ? '      (See: ER_NERROR, DATAFILE_STATUS, ERROR_OBJECT_PROPERTIES and/or Bottom)'
        ?
        ? "********************* Memory & VFP ***************************"
        ?
        ? "  User memory use: " + LTRIM( TRANSFORM( VAL(SYS(1016)), ;
          '@R 999,999,999,999') )
        ? "  Total Available: " + LTRIM( TRANSFORM( VAL(SYS(1001)), ;
          '@R 999,999,999,999') )
        ? "      VFP Version: " + er_cFoxVer
        ? "    VFP Directory: " + HOME()
        ? "    Resource file: " + SYS(2005)
        ? "    Graphics card: " + SYS(2006)
        ?
        ? "**************** Operating System ****************************"
        ?
        ? "  OS Version: " + er_opsys
        ? "         CPU: " + er_cCpu
        ? "Config FILES: " + er_cFiles
        ? "  Disk Space: " + LTRIM( TRANSFORM(er_nDiskSpace, '999,999,999,999,999') )
        ? "   Directory: " + SET('DEFAULT') + CURDIR()
        ? "  Network ID: " + SYS(0)
        ?
        ? "********************* Status *********************************"
        LIST STATUS TO PRINT
        LIST MEMORY TO PRINT
        LIST OBJECTS TO PRINT
        ?

        * Show the currently open databases and indexes
        THIS.ShowDataFiles(nSession)

        * Show the error-ing object's Properties
        IF NOT ISNULL( THIS.oErrObj )

            * Start with our find-able heading
            ? REPLICATE('-', 23) + " ERROR_OBJECT_PROPERTIES " + ;
              REPLICATE('-', 24)
            LOCAL oErrorObj
            oErrorObj = THIS.oErrObj
            LIST OBJECT LIKE oErrorObj TO PRINT
            ?
        ENDIF

        * Repeat the error info at the bottom of the file
        ? REPLICATE('-', 30) + ' Bottom ' + REPLICATE('-', 30)
        ? 'ERROR - ' + er_cErrMsg
        IF er_cCmd <> er_cErrMsg
            ? '      Command: ' + er_cCmd
        ENDIF
        ? '      Program - ' + er_cErrPgm + ' at line ' + LTRIM(STR(er_nErrLine))
        IF .NOT. EMPTY(er_cCallBy1)
            ? '    Called by: ' + er_cCallBy1
            IF .NOT. EMPTY(er_cCallBy2)
                ?? ' (which was called by: ' + er_cCallBy2 + ')'
            ENDIF
        ENDIF
        ? '    Date/Time: ' + DTOC(er_dDate) + ' at ' + er_cTime
        ?

        * Tweak the error array - then display those results
        *   aErrors[x,1] - Description of item
        *   aErrors[x,2] - Error info (char)
        DIMENSION aErrors[7,2]
        nRows = THIS.ResetErrorInfo( @aErrors )
        ? 'Extended Error Info:'
        FOR nX = 1 TO nRows
            ? '  ' + aErrors[nX,1] + aErrors[nX,2]
        ENDFOR
        ?

        * Show our error hierarchy
        IF er_nErrorCnt > 0
            ? 'Error calling hierarchy:'
            FOR nX = er_nErrorCnt TO 1 STEP -1

                * Our number is er_nPgmCnt + nX
                cNumb = STR(er_nPgmCnt + nX, 3, 0)
                ep_cDate = er_aErrorCalls[nX,1]
                ep_cExec = er_aErrorCalls[nX,2]
                ep_cName = er_aErrorCalls[nX,3]
                ep_nLine = er_aErrorCalls[nX,5]
                ep_cCmd  = ALLTRIM( er_aErrorCalls[nX,6] )

                * Create the string to look like:
                *   __2. Main - Line: 170 - Cmd: oNewObj = CREATEOBJECT( cClass )
                *          In: e:\album\libs\objmgr.fxp - 01/28/2002
                ? cNumb + '. ' + ep_cName + ' - Line: ' + ;
                  LTRIM(STR(ep_nLine)) + ' - Cmd: ' + ep_cCmd
                ? '       In: ' + ep_cExec + ' - ' + ep_cDate
            ENDFOR
            ?
        ENDIF

        * Show our calling hierarchy
        ? 'Program calling hierarchy:'
        FOR nX = er_nPgmCnt TO 1 STEP -1
            ep_cDate = er_aPgms[nX,1]
            ep_cExec = er_aPgms[nX,2]
            ep_cName = er_aPgms[nX,3]
            ep_nLine = er_aPgms[nX,5]
            ep_cCmd  = ALLTRIM( er_aPgms[nX,6] )

            * Create the string to look like:
            *   __2. Main - Line: 170 - Cmd: oNewObj = CREATEOBJECT( cClass )
            *          In: e:\album\libs\objmgr.fxp - 01/28/2002
            ? STR(nX,3,0) + '. ' + ep_cName + ' - Line: ' + ;
              LTRIM(STR(ep_nLine)) + ' - Cmd: ' + ep_cCmd
            ? '       In: ' + ep_cExec + ' - ' + ep_cDate
        ENDFOR
        ?
        SET PRINT OFF
        SET PRINT TO
        SET CONSOLE ON

        * Done
        SET DATASESSION TO nDataSession
        RETURN
    ENDPROC

    *- GetPgmHierarchy() - Return an array of the program hierarchy
    FUNCTION GetPgmHierarchy( aPgms, cErrPgm, cCallBy1, cCallBy2, cLastCmd, aErrs, nErrCnt)
        LOCAL nCount, nX, cPgmName, cFunction, bIsError, cSrcName, cCmd, nY

        * VFP gave us a pretty neat array for getting the program hierarchy:
        *   aPgms[x,1] - Stack level (same as row number)
        *   aPgms[x,2] - Executing file name (APP, EXE, FXP)
        *   aPgms[x,3] - Module or object name
        *   aPgms[x,4] - Source filename (PRG, VCX...)
        *   aPgms[x,5] - Line number in module or object source file
        *   aPgms[x,6] - Program line containing error
        DIMENSION aPgms[1,6]
        nCount = aStackInfo( aPgms )

        * Now, delete any HANDLERR calls going from the bottom up.
        FOR nX = nCount TO 1 STEP -1
            cPgmName = UPPER(aPgms[nX,4])
            cFunction = UPPER(aPgms[nX,3])
            bIsError = ('HANDLERR' $ cPgmName OR 'ON...' $ cPgmName OR ;
              EMPTY(cPgmName) )
            IF NOT bIsError
                bIsError = ('HANDLERR' $ cFunction OR 'ON...' $ cFunction OR ;
                  EMPTY(cFunction) )
            ENDIF
            IF bIsError
                ADEL( aPgms, nX )
                nCount = nCount - 1
            ELSE
                EXIT
            ENDIF
        ENDFOR
        IF nCount > 1
            DIMENSION aPgms[nCount,6]
        ENDIF

        * But, that's not quite good enough for us, we want to get column 2's
        * date/time and put it into column 1 as that is the same as the row:
        *   aPgms[x,1] - Col. 2's file date and time as: mm/dd/yyyy hh:mm:ss
        *   aPgms[x,2] - Executing file name (APP, EXE, FXP)
        *   aPgms[x,3] - Module or object name
        *   aPgms[x,4] - Source filename (PRG, VCX...)
        *   aPgms[x,5] - Line number in module or object source file
        *   aPgms[x,6] - Program line containing error
        * x = row number = stack level (starting program = 1)
        * nCount - number of rows
        STORE '' TO cErrPgm, cCallBy1, cCallBy2
        FOR nX = 1 TO nCount
            cPgmName = aPgms[nX,3]

            * Make the module/object name proper case
            cFunction = PROPER( aPgms[nX,3] )
            aPgms[nX,3] = cFunction

            * Get the latest file date
            cSrcName = aPgms[nX,2]
            aPgms[nX,1] = THIS.RetFileDate( cSrcName )

            * Make sure the command line is trimmed
            aPgms[nX,6] = ALLTRIM(aPgms[nX,6])
        ENDFOR

        * Move all 'ERROR.' calls to aErrs
        DIMENSION aErrs[1,6]
        nErrCnt = 0
        FOR nX = 1 TO nCount
            IF '.error' $ LOWER(aPgms[nX,3]) OR '.error' $ LOWER(aPgms[nX,3])
                nErrCnt = nErrCnt + 1
                DIMENSION aErrs[nErrCnt,6]
                FOR nY = 1 TO 6
                    aErrs[nErrCnt,nY] = aPgms[nX,nY]
                ENDFOR
            ENDIF
        ENDFOR

        * Decrement the count for aPgms
        nCount = nCount - nErrCnt

        * Note the last three errors for display
        IF nCount > 0
            cErrPgm = aPgms[nCount,3]
            cLastCmd = aPgms[nCount,6]
            IF nCount > 1
                cCallBy1 = aPgms[nCount-1,3]
                IF nCount > 2
                    cCallBy2 = aPgms[nCount-2,3]
                ENDIF
            ENDIF
        ENDIF

        * Done
        RETURN nCount
    ENDFUNC

    *- RetFileDate() - Return the date/time for the passed filename
    FUNCTION RetFileDate( cFName )
        LOCAL nFileCnt, cRetDate
        LOCAL aFileRA[1,5]

        * Look for the file on the goApp.cAppPath, cSrcPath or cLibsPath
        *   directories
        IF '\' $ cFName
            nFileCnt = ADIR( aFileRA, cFName)
        ELSE
            DO CASE
            CASE FILE(goApp.cAppPath + cFName)
                nFileCnt = ADIR( aFileRA, goApp.cAppPath + cFName)
            CASE FILE(cSrcPath + cFName)
                nFileCnt = ADIR( aFileRA, cSrcPath + cFName)
            CASE FILE(cLibsPath + cFName)
                nFileCnt = ADIR( aFileRA, cLibsPath + cFName)
            OTHERWISE
                nFileCnt = ADIR( aFileRA, cFName)
            ENDCASE
        ENDIF

        * There may not be any file
        IF nFileCnt = 0
            cRetDate = '<no file date>'
        ELSE

            * Format this as mm/dd/yyyy hh:mm:ss
            cRetDate = DTOC( aFileRA[1,3] ) + ' ' + aFileRA[1,4]
        ENDIF
        RETURN cRetDate
    ENDFUNC

    *- ResetErrorInfo() - Create an array of detailed error info
    PROCEDURE ResetErrorInfo( aErrors )
        LOCAL nErrRows, nErrNumb, bIsOLE, bIsODBC, cErrSys, cAError

        * Goal: fill aErrors as follows:
        *   aErrors[x,1] - Description of item
        *   aErrors[x,2] - Error info (char)

        * In the following code, we have taken into account OLE, ODBC and
        *   regular VFP errors.
        DIMENSION aErrors[2,2]
        nErrRows = 2

        * AERROR() - Element 1:
        *   VFP Errors - Numeric error number (same as ERROR())
        *   OLE Errors - Numeric - Contains 1427 or 1429
        *   ODBC Errors - Numeric - Contains 1526
        aErrors[1,1] = '   Error Number: '
        nErrNumb = THIS.aErrorInfo[1]
        STORE .F. TO bIsOLE, bIsODBC
        DO CASE
        CASE nErrNumb = 1427 OR nErrNumb = 1429
            cErrSys = 'OLE'
            bIsOLE = .T.
        CASE nErrNumb = 1526
            cErrSys = 'ODBC'
            bIsODBC = .T.
        OTHERWISE
            cErrSys = 'VFP'
        ENDCASE
        aErrors[1,2] = cErrSys + ': ' + ALLTRIM( STR(nErrNumb) )

        * AERROR() - Element 2:
        *   VFP Errors - Text of error message (same as MESSAGE())
        *   OLE Errors - Text of VFP error message
        *   ODBC Errors - Text of error message
        aErrors[2,1] = '  Error Message: '
        aErrors[2,2] = THIS.aErrorInfo[2]

        * AERROR() - Element 3:
        *   VFP Errors - Text of additional error parameter (same as SYS(2018))
        *   OLE Errors - OLE Text of error message
        *   ODBC Errors - ODBC Text of error message
        cAError = NVL(THIS.aErrorInfo[3],'.NULL.')
        IF NOT cAError = '.NULL.'
            nErrRows = nErrRows + 1
            DIMENSION aErrors[nErrRows,2]
            aErrors[nErrRows,1] = "  Add'l Message: "
            aErrors[nErrRows,2] = cAError
        ENDIF

        * AERROR() - Element 4:
        *   VFP Errors - Contains the .NULL. value. However, as appropriate,
        *       contains the number of the work area in which the error
        *       occurred.
        *   OLE Errors - Contains a string for the Application name. For
        *       example, Microsoft Excel.
        *   ODBC Errors - Contains a string for the current ODBC SQL state.
        DO CASE
        CASE ISNULL(THIS.aErrorInfo[4])
            cAError = '.NULL.'
        CASE TYPE("laError[xx,4]") = "C"
            cAError = THIS.aErrorInfo[4]
        CASE type("laError[xx,4]") = "N"
            cAError = ALLTRIM(STR(THIS.aErrorInfo[4]))
        OTHERWISE
            cAError = 'Unknown Error'
        ENDCASE
        IF NOT cAError = '.NULL.'
            nErrRows = nErrRows + 1
            DIMENSION aErrors[nErrRows,2]
            DO CASE
            CASE bIsOLE
                aErrors[nErrRows,1] = "     Appl. Name: "
            CASE bIsODBC
                aErrors[nErrRows,1] = "      SQL State: "
            OTHERWISE
                aErrors[nErrRows,1] = "    Select Area: "
            ENDCASE
            aErrors[nErrRows,2] = cAError
        ENDIF

        * AERROR() - Element 5:
        *   VFP Error - Contains .NULL.  However, if a trigger failed (error
        *       1539), this contains one of the following numeric values:
        *       1 - Insert trigger failed.
        *       2 - Update trigger failed.
        *       3 - Delete trigger failed.
        *   OLE Errors - Contains the null value or Character. Contains the
        *       name of the application's Help file where more information
        *       about the error can be found if the information is
        *       available from the application; otherwise contains the null
        *       value.
        *   ODBC Error - Numeric. The error number from the ODBC data source.
        DO CASE
        CASE ISNULL(THIS.aErrorInfo[5])
            cAERROR = '.NULL.'
        CASE TYPE('THIS.aErrorInfo[5]') = 'N'
            DO CASE
            CASE THIS.aErrorInfo = 1
                cAERROR = 'Insert Trigger Failed'
            CASE THIS.aErrorInfo = 2
                cAERROR = 'Update Trigger Failed'
            CASE THIS.aErrorInfo = 3
                cAERROR = 'Delete Trigger Failed'
            OTHERWISE
                cAERROR = ALLTRIM( STR(THIS.aErrorInfo[5]) )
            ENDCASE
        CASE TYPE('THIS.aErrorInfo[5]') = 'C'
            cAERROR = THIS.aErrorInfo[5]    && OLE errors have text here
        OTHERWISE
            cAError = 'Unknown Error'
        ENDCASE
        IF NOT cAError = '.NULL.'
            nErrRows = nErrRows + 1
            DIMENSION aErrors[nErrRows,2]
            DO CASE
            CASE bIsOLE
                aErrors[nErrRows,1] = "     Appl. Help: "
            CASE bIsODBC
                aErrors[nErrRows,1] = "   Source Error: "
            OTHERWISE
                aErrors[nErrRows,1] = "Trigger Failure: "
            ENDCASE
            aErrors[nErrRows,2] = cAError
        ENDIF

        * AERROR() - Element 6:
        *   VFP Error - .NULL.
        *   OLE Error - The null value or Character. Contains the help
        *       context ID for the appropriate help topic if the
        *       information is available from the application; otherwise
        *       contains the null value.
        *   ODBC Error - Numeric. The ODBC connection handle.
        DO CASE
        CASE ISNULL(THIS.aErrorInfo[6])
            cAError = '.NULL.'
        CASE TYPE('THIS.aErrorInfo[6]') = 'C'
            cAError = THIS.aErrorInfo[6]
        CASE TYPE('THIS.aErrorInfo[6]') = 'N'
            cAError = ALLTR(STR(THIS.aErrorInfo[6]))
        OTHERWISE
            cAError = 'Unknown Error'
        ENDCASE
        IF NOT cAError = '.NULL.'
            nErrRows = nErrRows + 1
            DIMENSION aErrors[nErrRows,2]
            DO CASE
            CASE bIsOLE
                aErrors[nErrRows,1] = "Help Context ID: "
            CASE bIsODBC
                aErrors[nErrRows,1] = "   Conn. Handle: "
            OTHERWISE
                aErrors[nErrRows,1] = "                 "
            ENDCASE
            aErrors[nErrRows,2] = cAError
        ENDIF

        * AERROR() - Element 7:
        *   VFP Error - .NULL.
        *   OLE Error - Numeric. An OLE 2.0 exception number.
        *   ODBC Error - .NULL.
        DO CASE
        CASE ISNULL(THIS.aErrorInfo[7])
            cAError = '.NULL.'
        CASE TYPE('THIS.aErrorInfo[7]') = 'N'
            cAError = ALLTR(STR(THIS.aErrorInfo[7]))
        OTHERWISE
            cAError = 'Unknown Error'
        ENDCASE
        IF NOT cAError = '.NULL.'
            nErrRows = nErrRows + 1
            DIMENSION aErrors[nErrRows,2]
            IF bIsOLE
                aErrors[nErrRows,1] = "OLD Exception #: "
            ELSE
                aErrors[nErrRows,1] = "                 "
            ENDIF
            aErrors[nErrRows,2] = cAError
        ENDIF

        * Done
        RETURN nErrRows
    ENDPROC

    *- ShowDataFiles() - List the current DBF information
    PROCEDURE ShowDataFiles(nFrmSession)
        LOCAL aDBs[1], nDBCount, nX, nSessionCount, aDataSess[1], nThisSession

        * Start with our find-able heading
        ? REPLICATE('-', 27) + ' DATAFILE_STATUS ' + REPLICATE('-', 28)

        * First, list all DBCs used
        ? [Databases:]
        nDBCount = ADATABASES(aDBs)
        FOR nX = 1 TO nDBCount
            ? SPACE(4) + aDBs(nX,2)
        ENDFOR
        IF nDBCount > 0
            ?
        ENDIF

        * Now, list the passed data session
        THIS.ListSessionDBFS(nFrmSession)

        * Get an array of all data sessions()
        *   aDataSess[x] = session number
        nSessionCount = ASESSIONS(aDataSess)
        FOR nX = 1 TO nSessionCount
            IF aDataSess[nX] <> nFrmSession
                nThisSession = aDataSess[nX]
                THIS.ListSessionDBFS(nThisSession)
            ENDIF
        ENDFOR
        SET DATASESSION TO (nFrmSession)
        RETURN
    ENDPROC

    *- ListSessionDBFS() - List the data files for the passed data session
    FUNCTION ListSessionDBFS(nSessNo)
        LOCAL nCurrSele, nLastDB, nD

        * Display our data session number
        ? 'Data Session: ' + TRANSFORM(nSessNo)
        SET DATASESSION TO (nSessNo)

        * We want to list all DBF info that we can; starting with the currently
        *   selected DBF
        nCurrSele = SELECT()

        * We're already there so show this DBF's info - if there is one
        IF NOT EMPTY( DBF(nCurrSele) )
            THIS.PrintDBFInfo(nCurrSele, .T.)
        ELSE
            ? 'Current Select Area = ' + LTRIM( STR(nCurrSele) ) + ;
              '; no DBF is open.'
        ENDIF

        * Now, add all other DBFs, then we're done
        SELECT 0
        nLastDB = SELECT()-1
        FOR nD = 1 TO nLastDB
            IF nD = nCurrSele OR EMPTY(DBF(nD))
                LOOP
            ENDIF
            THIS.PrintDBFInfo(nD)
        ENDFOR
        RETURN
    ENDPROC

    *- PrintDBFInfo() - Print a DBF's current status
    PROCEDURE PrintDBFInfo( nSel, bIsCurrent )
        LOCAL nMasterIndex, aInfo[1,3], nCount, nI, cTag, cKey, cFor, ;
          cLeadIn, nI, cLine, cExpr, cTarget, nMaxNameLen, cName, cValue

        * We want this to look like:
        *   123456789012345678901234567890123456789012345678901234567890
        *   Current - 2) E:\IBX\DATA\CLIPARTS.DBF - Alias: CLIPARTS
        *       Indexes: (Master) PART - Key: USER_ID + PART_NUM
        *                DESCR - Key: USER_ID + UPPER(DESCR)
        *      Relation: USER_ID + PART_NUM --> PARTXREF
        *        Filter: PART_NUM <> '1'
        *        Record: nnnnn of nnnnnnn  Deleted  At EOF() BOF()
        *        Fields: NAME       Value
        *                   rest of the fields
        *
        *   1) E:\IBX\DATA\PARTXREF.DBF - Alias: PARTXREF2
        *       Indexes: PART - Key: USER_ID + PART_NUM + OUR_PN
        *                (Master) PRIMARY - Key: USER_ID + PART_NUM FOR PRIMARY
        *                REL_PART - Key: USER_ID + OUR_PN
        *        Record: nnnnn of nnnnnnn  Deleted  At EOF() BOF()
        *        Fields: NAME       Value
        *                   rest of the fields

        * Get the name, path and alias and show it as:
        *   NN.  Name - Alias: ALIAS
        SELECT (nSel)
        ? IIF(bIsCurrent, 'Current - ', '') + LTRIM( STR(nSel) ) + ') ' + DBF() + ;
          ' - Alias: ' + ALIAS()

        * The indexes could consist of IDXs or CDXs.  Put their info in an array
        *   aInfo[x,1] - Tag
        *   aInfo[x,2] - Expression
        *   aInfo[x,3] - .T. if this is the master index
        nMasterIndex = TAGNO()
        nCount = 0
        FOR nI = 1 TO 254               && Max. 254 indexes
            cTag = TAG(nI)
            IF EMPTY(cTag)              && No more indexes
                EXIT
            ENDIF

            * Get the Key
            cKey = KEY(nI)

            * Add the FOR clause if any
            cFor = SYS(2021, nI)
            IF NOT EMPTY(cFor)
                cKey = cKey + ' FOR ' + cFor
            ENDIF

            * Add this to the array
            nCount = nCount + 1
            DIMENSION aInfo[nCount,3]
            aInfo[nCount,1] = cTag
            aInfo[nCount,2] = cKey
            aInfo[nCount,3] = (nI = nMasterIndex)
        ENDFOR

        * Now, print the index info
        cLeadIn = '    ' + IIF( nCount>1, 'Indexes: ', '  Index: ')
        IF nCount = 0
            ? cLeadIn + 'None'
        ELSE
            FOR nI = 1 TO nCount
                cLine = cLeadIn
                IF nI = 1
                    cLeadIn = SPACE( LEN(cLeadIn) )
                ENDIF
                IF aInfo[nI,3]
                    cLine = cLine + '(Master) '
                ENDIF
                cLine = cLine + aInfo[nI,1] + ' - ' + aInfo[nI,2]
                ? cLine
            ENDFOR
        ENDIF

        * Now we want any relations.  Again, we'll first put them in an array
        *   aInfo[x,1] - Expression
        *   aInfo[x,2] - Target
        DIMENSION aInfo[1,2]
        nCount = 0
        FOR nI = 1 TO 25                && Assume max. 25 relations

            * Get the relational expression
            cExpr = RELATION(nI)
            IF EMPTY(cExpr)              && No more relations
                EXIT
            ENDIF

            * Now get the target
            cTarget = TARGET(nI)

            * Add this to the array
            nCount = nCount + 1
            DIMENSION aInfo[nCount,2]
            aInfo[nCount,1] = cExpr
            aInfo[nCount,2] = cTarget
        ENDFOR

        * Now, print the relations info
        cLeadIn = '  ' + IIF( nCount>1, 'Relations: ', ' Relation: ')
        IF nCount > 0
            FOR nI = 1 TO nCount
                cLine = cLeadIn
                IF nI = 1
                    cLeadIn = SPACE( LEN(cLeadIn) )
                ENDIF
                cLine = cLine + aInfo[nI,1] + ' --> ' + aInfo[nI,2]
                ? cLine
            ENDFOR
        ENDIF

        * Add any filter
        cExpr = FILTER()
        IF NOT EMPTY(cExpr)

            * Translate any # to <>
            IF '#' $ cExpr
                cExpr = STRTRAN(cExpr, '#', ' <> ')
            ENDIF
            ? '     Filter: ' + cExpr
        ENDIF

        * What's the current record's status
        cLeadIn = '     Record: '
        IF BOF() OR EOF()
            ? cLeadIn + IIF( EOF(), 'EOF()', 'BOF()')
        ELSE
            ? cLeadIn + LTRIM( STR(RECNO()) ) + ' of ' + LTRIM( STR(RECCOUNT()) )
            IF DELETED()
                ?? '  Deleted'
            ENDIF
        ENDIF

        * Now, we need field info for this record.  Get the structure information
        DIMENSION aFlds[1,16]
        nCount = AFIELDS( aFlds )

        *   aInfo[x,1] - Field Name
        *   aInfo[x,2] - Field's value (converted to character)
        DIMENSION aInfo[nCount,2]
        nMaxNameLen = 10
        FOR nI = 1 TO nCount

            * Get the name and value
            cName = ''
            cValue = THIS.ConvertField(nI, @cName, @aFlds)
            IF LEN(cName) > nMaxNameLen
                nMaxNameLen = LEN(cName)
            ENDIF

            * Put these in our array
            DIMENSION aInfo[nI,2]
            aInfo[nI,1] = cName
            aInfo[nI,2] = cValue
        ENDFOR

        * Now, display the fields
        cLeadIn = '     Fields: '
        FOR nI = 1 TO nCount
            cLine = cLeadIn
            IF nI = 1
                cLeadIn = SPACE( LEN(cLeadIn) )
            ENDIF
            cLine = cLine + THIS.MakeLength(aInfo[nI,1], nMaxNameLen) + '   '

            * If this is a memo field, we may need more than one line
            nOldMemoWidth = SET('MEMOWIDTH')
            nNewWidth = 80 - LEN(cLine)
            SET MEMOWIDTH TO (nNewWidth)
            nLines = 1
            cType = aFlds[nI, 2]
            IF cType $ 'CMG'
                nLines = MEMLINES( aInfo[nI,2] )
            ENDIF
            IF nLines = 1
                ? cLine + aInfo[nI,2]
            ELSE
                nLines = ALINES( aMemo, aInfo[nI,2] )
                FOR nJ = 1 TO nLines
                    ? cLine + aMemo[nJ]
                    IF nJ = 1
                        cLine = SPACE( LEN(cLine) )
                    ENDIF
                ENDFOR
            ENDIF
        ENDFOR

        * Add a blank line and we're done
        ?
        RETURN
    ENDPROC

    *- ConvertField - Convert a field's contents for printing
    FUNCTION ConvertField( nFldNumb, cFldName, aStru )
        EXTERNAL ARRAY aStru
        LOCAL xFldContents, M.cType, cFldContents, nLen, nDec

        * Parameters:
        *   nFldNumb - Field number desired
        *   cFldName - Variable passed as @cFldName that will have the field name
        *   aStru[] - Field Structure for DBF
        *   nDBFRows  - Rows in aStru[]

        * Define the field name
        cFldName = ALLTRIM( aStru[nFldNumb, 1] )

        * Return quickly if the name's empty
        IF EMPTY(cFldName)
            RETURN ''
        ENDIF

        * Else, define its contents
        xFldContents = EVAL(cFldName)

        * Our conversion is based on type
        M.cType = aStru[nFldNumb, 2]
        DO CASE

        * Character, Memo, General
        CASE M.cType $ 'CMG'
            xFldContents = TRIM(xFldContents)
            DO CASE

            * Show "<empty>" if there is nothing
            CASE EMPTY(xFldContents) .AND. M.cType $ 'MG'
                cFldContents = '<empty>'

            * Show "<binary>" if it is
            CASE M.cType $ 'MG' .AND. THIS.HasBinaryChar(xFldContents)
                cFldContents = '<binary>'
            OTHERWISE
                cFldContents = xFldContents
            ENDCASE

        * Date
        CASE M.cType = 'D'
            cFldContents = DTOC( xFldContents )

        * DateTime
        CASE M.cType = 'T'
            cFldContents = TTOC( xFldContents )

        * Logical
        CASE M.cType = 'L'
            cFldContents = IIF( xFldContents, 'Y', 'N' )

        * Numeric, Float
        OTHERWISE   && M.cType $ 'NF'
            nLen = aStru[nFldNumb, 3]
            nDec = aStru[nFldNumb, 4]
            cFldContents = STR( xFldContents, nLen, nDec)
        ENDCASE
    RETURN cFldContents

    *- HasBinaryChar - Return .T. if a string has binary characters
    FUNCTION HasBinaryChar
        PARAMETERS cString
        PRIVATE bIsBinary, nX

        * Scan the string to see if it contains binary characters.  Binary
        *   characters are 0h and those above CHR(127)
        bIsBinary = .F.
        IF HEX_0 $ cString
            bIsBinary = .T.
        ELSE

            * Check each letter if this is a small string
            IF LEN(cString) < 126
                FOR nX = 1 TO LEN(cString)
                    IF ASC(SUBSTR(cString, nX, 1)) > 127
                        bIsBinary = .t.
                        EXIT
                    ENDIF
                ENDFOR
            ELSE

                * For long strings, check each possible binary character
                FOR nX = 127 TO 255
                    IF CHR(nX) $ cString
                        bIsBinary = .t.
                        EXIT
                    ENDIF
                ENDFOR
            ENDIF
        ENDIF
    RETURN bIsBinary

    *- ShowError - Display the error message box
    PROCEDURE ShowError
        LPARAMETERS tlDebug
        LOCAL lcMethod, lcModule, lcObject, cMsg, cCodes

        * Displays the error to the user and prompts for input. If in debug
        *   mode, asks if the user wants to activate the debug window.
        *   Otherwise, asks the user to report the problem.
        * Parameters:
        *   tlDebug - If TRUE, indicates in debug mode

        * Create the error message
        lcMethod = ALLTR(THIS.cErrorProgram)
        lcObject = IIF(ISNULL(THIS.oErrObj), '', SYS(1272,THIS.oErrObj))
        lcLine5  = 'Method:  ' + lcMethod
        lcLine6  = 'Object:  ' + lcObject

        * Display the error message. The text differs based on whether or
        *   not in Debug mode. Returns the value of MessageBox().
        cMsg = 'The following system error has been encountered: ' + CR_LF + ;
          CR_LF + ;
          '------------------------------------------------------------------------' + CR_LF + ;
          'Error #: ' + LTRIM( STR( THIS.aErrorInfo[ERR_NUMBER] ) ) + CR_LF +;
          'Message: ' + ALLTRIM( THIS.aErrorInfo[ERR_MESSAGE] ) + CR_LF +;
          'Line: ' + LTRIM( STR( THIS.nErrorLine ) ) + CR_LF +;
          'Code: ' + ALLTRIM( THIS.cErrorMessage ) + CR_LF +;
          '------------------------------------------------------------------------' + CR_LF + ;
          'Method: '+lcMethod+ CR_LF +;
          'Object: '+lcObject+ CR_LF +;
          '------------------------------------------------------------------------' + CR_LF + ;
          CR_LF
        IF tlDebug
            cMsg = cMsg + 'Activate the Debug Window?'
            cCodes = MB_YESNO + MB_ICONSTOP
        ELSE
            cMsg = cMsg + 'A system error has occurred. Please report ' + ;
              'this problem.'
            cCodes = MB_OK + MB_ICONSTOP
        ENDIF
        RETURN MESSAGEBOX( cMsg, cCodes, 'System Error')
    ENDPROC

    *- MakeLength - Return a string at the length specified (space filled if needed)
    FUNCTION MakeLength( cStrIn, nDesLen, bAddMT)
        LOCAL cRetStr

        * If this is a memo field, pick only the stuff to the left of CR's.
        cRetStr = cStrIn
        DO CASE
        CASE CR_LF $ cStrIn
            cRetStr = LEFT(cStrIn, AT( CR, cStrIn) - 1)

        * If it's empty, say so if they asked for it
        CASE EMPTY(cStrIn)
            cRetStr = IIF( nDesLen >= 7 AND bAddMT, '<empty>', SPACE(nDesLen) )
        ENDCASE

        * Now, adjust the length
        DO CASE
        CASE LEN(cRetStr) > nDesLen
            cRetStr = LEFT(cRetStr, nDesLen)
        CASE LEN(cRetStr) < nDesLen
            cRetStr = cRetStr + SPACE(nDesLen - LEN(cRetStr) )
        OTHERWISE
            cRetStr = cRetStr
        ENDCASE
        RETURN cRetStr
    ENDFUNC

    *- CopyRight - Our copyright notice
    PROCEDURE CopyRight

        *  Class.............: ErrorHandler
        *  Author............: Ken Green
        *  Created...........: 06/23/03
        *  Copyright.........: (c) 2003, Advance DataSystems
    ENDPROC

    *- RestoreOrigHandler - Restores the original Error Handler
    PROCEDURE RestoreOrigHandler
        LOCAL lcErrorMgr
        lcErrorMgr = THIS.cOldErrorMgr
        ON ERROR &lcErrorMgr
    ENDPROC

    *- Destroy - Restore the original ON ERROR routine
    PROCEDURE Destroy

        * Restore the original ON ERROR setting
        THIS.RestoreOrigHandler()

        * Release the built-in business object
        IF TYPE('THIS.ErrorMgrObj') == 'O' AND NOT ISNULL(THIS.ErrorMgrObj)
            THIS.ErrorMgrObj.Release()
        ENDIF
    ENDPROC

    *  Release() - Remove ourselves from memory
    PROCEDURE Release

        * Restore the original ON ERROR setting
        THIS.RestoreOrigHandler()
        DODEFAULT()
        CANCEL
    ENDPROC
ENDDEFINE

* BugForm Class Definition - (base: form)
DEFINE CLASS BugForm AS Form

    * Custom Properties:
    AlwaysOnTop = .T.
    BackColor = RGB(255,194,193)
    Caption = "Bug Message #"
    Closable = .F.
    ControlBox = .F.
    Desktop = .F.                       && Window can only be in VFP screen
    HalfHeightCaption = .T.
    Height = 156
    Left = 20
    MaxButton = .F.
    MinButton = .F.
    Movable = .T.
    Name = "BugForm"
    ShowWindow = 1                      && In Top-Level form
    Desktop = .T.                   && But let it go anywhere
    Top = 20
    Width = 450
    WindowType = 1                      && 1 = Modal, 0 = Modeless

    * Custom Method List (code below):
    *- Init - Add any contained objects
    *- ShowMsg() - Show the message and either time out or get a button press
    *- Destroy() - Destroy ourselves

    * Method Code:

    *- Init - Add any contained objects
    FUNCTION Init( nBugNumb, cErrMsg, cPgmMsg, nWait, oActiveForm )
        bRetVal = DODEFAULT()
        THIS.Caption = THIS.Caption + LTRIM( STR(nBugNumb) )

        * Position ourselves over the active form if we can
        THIS.Left = 85
        THIS.Top = 200
*       IF VARTYPE(oActiveForm) = 'O' AND NOT ISNULL(oActiveForm)
*           THIS.Left = oActiveForm.Left + ;
*             INT((oActiveForm.Width - THIS.Width) / 2)
*           IF THIS.Left < 10
*               THIS.Left = 10
*           ENDIF
*           THIS.Top = oActiveForm.Top + ;
*             INT((oActiveForm.Height - THIS.Height) / 2)
*           IF THIS.Top < 30
*               THIS.Top = 30
*           ENDIF
*       ENDIF
        THIS.AddObject('oimgStop', 'imgStop')
        THIS.AddObject('olblBugMsg', 'lblBugMsg')
        THIS.AddObject('oedtBugMsg', 'edtBugMsg', cErrMsg)
        THIS.AddObject('olblProgram', 'lblProgram')
        THIS.AddObject('otxtProgram', 'txtProgram', cPgmMsg)
        THIS.AddObject('olblNote', 'lblNote')
        THIS.AddObject('oshpBug1', 'shpBug1')
        THIS.AddObject('oshpBug2', 'shpBug2')
        THIS.AddObject('ocmdContinue', 'cmdContinue')
        IF EXIT_2_OS
            THIS.oCmdContinue.Caption = 'Exit Program'
        ENDIF
        IF nWait > 0
            THIS.AddObject('otmrTimer', 'tmrTimer', nWait)
        ENDIF
        RETURN bRetVal
    ENDFUNC

    *- ShowMsg() - Show the message and either time out or get a button press
    FUNCTION ShowMsg( cMsg )
        THIS.olblNote.Caption = cMsg
        THIS.otmrTimer.Reset()
*       THIS.ocmdContinue.SetFocus()
        THIS.Show()
    ENDFUNC

    *- Destroy() - Destroy ourselves
    FUNCTION Destroy()

        * Kill any objects we added
        LOCAL nX
        FOR nX = THIS.ControlCount TO 1 STEP -1
            DO CASE
            CASE ISNULL( THIS.Controls[nX] )
                RELEASE THIS.Controls[nX]
            CASE PEMSTATUS(THIS.Controls[nX], 'Release', 5)
                THIS.Controls[nX].Release()
            OTHERWISE
                THIS.Controls[nX].Destroy()
                RELEASE (THIS.Controls[nX].Name)
            ENDCASE
        ENDFOR
    ENDFUNC
ENDDEFINE

*  imgStop Class Definition - (subclass of: Image; base: image)
DEFINE CLASS imgStop AS Image

    * Custom Properties:
    BackStyle = 0
    Height = 32
    Left = 10
    Name = "imgStop"
    Picture = "stop.ico"
    Top = 10
    Width = 32
    Visible = .T.
ENDDEFINE

*  lblBugMsg Class Definition - (subclass of: Label; base: label)
DEFINE CLASS lblBugMsg AS Label

    * Custom Properties:
    Alignment = 0
    AutoSize = .T.
    BackColor = RGB(255,194,193)
    Caption = "Bug:"
    FontSize = 10
    Height = 18
    Left = 54
    Name = "lblBugMsg"
    TabIndex = 1
    Top = 15
    Width = 29
    Visible = .T.
ENDDEFINE

*  edtBugMsg Class Definition - (subclass of: Editbox; base: editbox)
DEFINE CLASS edtBugMsg AS Editbox

    * Custom Properties:
    DisabledBackColor = RGB(255,255,128)
    DisabledForeColor = RGB(0,0,0)
    Enabled = .F.
    FontSize = 10
    Height = 40
    IntegralHeight = .T.
    Left = 87
    Name = "edtBugMsg"
    TabIndex = 2
    Top = 12
    Value = "Invalid preceptor received"
    Width = 340
    Visible = .T.

    *- Init - Add any contained objects
    FUNCTION Init( cMsg )
        THIS.Value = cMsg
        RETURN DODEFAULT()
    ENDFUNC
ENDDEFINE

*  lblProgram Class Definition - (subclass of: Label; base: label)
DEFINE CLASS lblProgram AS Label

    * Custom Properties:
    Alignment = 0
    AutoSize = .T.
    BackColor = RGB(255,194,193)
    Caption = "Program:"
    FontSize = 10
    Height = 18
    Left = 28
    Name = "lblProgram"
    TabIndex = 3
    Top = 59
    Width = 55
    Visible = .T.
ENDDEFINE

*  txtProgram Class Definition - (subclass of: Textbox; base: textbox)
DEFINE CLASS txtProgram AS Textbox

    * Custom Properties:
    DisabledBackColor = RGB(255,255,128)
    DisabledForeColor = RGB(0,0,0)
    Enabled = .F.
    FontSize = 10
    Height = 24
    IntegralHeight = .T.
    Left = 87
    Name = "txtProgram"
    TabIndex = 4
    Top = 58
    Value = "MAIN.PRG at line 172"
    Width = 340
    Visible = .T.

    *- Init - Add any contained objects
    FUNCTION Init( cMsg )
        THIS.Value = cMsg
        RETURN DODEFAULT()
    ENDFUNC
ENDDEFINE

*  lblNote Class Definition - (subclass of: Label; base: label)
DEFINE CLASS lblNote AS Label

    * Custom Properties:
    Alignment = 2
    BackColor = RGB(255,194,193)
    Caption = "The bug info has been saved; please advise the programmer."
    Height = 17
    Left = 55
    Name = "lblNote"
    TabIndex = 5
    Top = 92
    Width = 339
    Visible = .T.
ENDDEFINE

*  shpBug1 Class Definition - (subclass of: Shape; base: shape)
DEFINE CLASS shpBug1 AS Shape

    * Custom Properties:
    BackColor = RGB(128,128,128)
    BorderColor = RGB(128,128,128)
    Height = 1
    Left = 5
    Name = "shpBug1"
    Top = 115
    Width = 440
    Visible = .T.
ENDDEFINE

*  shpBug2 Class Definition - (subclass of: Shape; base: shape)
DEFINE CLASS shpBug2 AS Shape

    * Custom Properties:
    BackColor = RGB(255,255,255)
    BorderColor = RGB(255,255,255)
    Height = 1
    Left = 5
    Name = "shpBug2"
    Top = 116
    Width = 440
    Visible = .T.
ENDDEFINE

*  cmdContinue Class Definition - (subclass of: CommandButton; base: commandbutton)
DEFINE CLASS cmdContinue AS CommandButton

    * Custom Properties:
    Caption = "Continue"
    Height = 26
    Left = 152
    Name = "cmdContinue"
    TabIndex = 6
    Top = 124
    Width = 145
    Visible = .T.

    * Custom Method Code:
    *- Click
    PROCEDURE Click
        THISFORM.Hide()
        IF EXIT_2_OS
            CLEAR EVENTS
        ENDIF
    ENDPROC
ENDDEFINE

*  tmrTimer Class Definition - (base: Timer)
DEFINE CLASS tmrTimer AS timer

    * Parent Class: timer
    *   Base Class: timer

    * Custom Properties:
    Height = 23
    Interval = 10000
    Left = 364
    Name = "tmrTimer"
    Top = 67
    Width = 23

    * Custom Properties:
    nWaitSecs = 0                   && How many seconds we're to wait
    cOldCapt = 0                    && Form's caption (that we'll change)
    nSecs = 0                       && Current seconds we've waited

    * Custom Method List (code below):
    *- Init - Set ourselves up
    *  Reset
    *  Timer

    * Method Code:

    *- Init - Set ourselves up
    PROCEDURE Init(nWaitSecs)
        DODEFAULT()
        THIS.nWaitSecs = nWaitSecs
        THIS.cOldCapt = THISFORM.Caption
        THISnSecs = 0
    ENDPROC

    *- Reset
    PROCEDURE Reset
        THIS.nSecs = 0
    ENDPROC

    *- Timer
    PROCEDURE Timer
        THIS.nSecs = THIS.nSecs + 1
        THISFORM.Caption = THIS.cOldCapt + ' - ' + LTRIM( STR(THIS.nSecs) )
        IF THIS.nSecs >= THIS.nWaitSecs
            cLockAction = 'T'
            THISFORM.Hide()
        ENDIF
    ENDPROC
ENDDEFINE
