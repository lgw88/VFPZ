#IF 0                           zSetMgr.prg

  Purpose:  Environmental Classes for saving and setting SET commands and some
            variations of our own devising. Version 3 of our efforts.

Revisions:  March 19, 2016 - Ken Green - Adapted from original ySetEnv.prg
                        started in 9/03/2001 with a last rev date of 8/27/07.
             4/08/16 - Added Release() method to zSetManager class

     Uses:  None

******************************** Class Notes ********************************

Goal: Easily save/restore one or more SET values.

There are 4 tpes of SETtings:

A. Global Settings - You wouldn't want your APP won't interfere with other user
    stuff, so save all relevant app-wide settings including the current data
    settings.
        obj = goSETs.SaveGlobal()

B. Table Settings - One table has a filter and index set and is on a particular
    record, ditto for another table. You have a function that messes about with
    both tables, but you don't want the filter or that index and you'll change
    the record pointer. Wnen done, the caller shouldn't notice anything
    different.
        obj = goSETs.SaveState([cAlias])

C. Ad hoc Setting Groups - You don't know what the current TALK or DELETE setting
    is but you want to change that for a bit.
        obj = goSETs.SaveGroup('TALK,DELETE')

D. One Setting - Quickly change one setting:
        obj = goSETs.SaveOne('NEAR')

The way this works is:

1. Create the object:
    goSets = ySetMgr()

2. Save one of the 4 kinds of settings
    oSET = goSETs.SaveGroup('TALK,DELETE')
    SET TALK ON
    SET DELETE OFF
    ...do your thing
    oSET.Release()          && Will reset the TALK, DELETE, both BELL settings

    Or, within a function
    FUNCTION abc
        LOCAL oSET
        oSET = goSETs.SaveGroup('TALK,DELETE')
        SET TALK ON
        SET DELETE OFF
        ...do your thing
        RETURN              && VFP will release oSET resetting everything
    ENDFUNC

3. Multi-state SETs are automatically handled.  For example,
    SET PRINT TO LPT1
    SET PRINTER ON
    obj = goSETs.SaveOne('PRINT')           && Saves both settings
    ...do your thing
    oObj.Release()                          && Restores both settings

4. Use the global object to print the App Settings; for example:
    obj = goSETs.SaveGlobal()
    obj.PrintAppSETs('Settings.txt')

****************************** Classes Defined ******************************

* zSetManager - Class for saving ALL SETs (including data session SETs)
* zTableState - Class for saving an alias's relevant SET commands
* zAppSets - Class for saving app-wide, global SET commands
* zSaveSets - Class for saving multiple SET commands
* zOneSet - Class for saving one SET's restoration commands
* zSet - Semi-abstract SETting class (subclass: Session)
* EnvArray Class Definition - General Array Object

*****************************************************************************
#ENDIF

* Defines
#DEFINE CR_LF   CHR(13) + CHR(10)

* Return our object
LOCAL oObj
oObj = CREATEOBJECT('zSetManager')
RETURN oObj


****************************** Classes Defined ******************************

* zSetManager - Class for saving ALL SETs (including data session SETs)
DEFINE CLASS zSetManager AS Custom

    * Standard Properties
    Name = "zSetManager"

    * Special sets of command names
    cSpclSetNames = [^CURDIR^ONERROR^ONESCAPE^ONSHUTDOWN^SRCH1ST^]
    cSingleNamesNoTO = [^ANSI^AUTOINCERROR^AUTOSAVE^CARRY^COMPATIBLE^] + ;
      [CONFIRM^CONSOLE^CPDIALOG^CURSOR^DELETED^ECHO^ESCAPE^] + ;
      [EXACT^EXCLUSIVE^FIXED^FULLPATH^LOCK^MULTILOCKS^NEAR^NOTIFY^NULL^] + ;
      [OLEOBJECT^OPTIMIZE^PALLETTE^SAFETY^SECONDS^SPACE^STATUS^STATUS BAR^] + ;
      [UNIQUE^]
    cSingleNamesTO = [^BLOCKSIZE^CLASSLIB^DATABASE^DATASESSION^] + ;
      [DATE^DECIMALS^DEFAULT^FDOW^FWEEK^HOURS^KEYCOMP^MARGIN^MEMOWIDTH^] + ;
      [NOCPTRANS^ODOMETER^PATH^POINT^PROCEDURE^STRICTDATE^TYPEAHEAD^] + ;
      [UDFPARMS^]
    cMultiNamesBlnkTO = [^ALTERNATE^BELL^CLOCK^CURRENCY^RESOURCE^]

    * Custom Method List:

    ***** Basic Operations *****
    *- SaveGlobal() - Save our app-wide global list of SETs
    *- SaveState() - Save the current table's state and maybe one other
    *- SaveGroup() - Save the passed list of SETs
    *- SaveOne() - Return a single SET command's resetting object

    ***** Utilities *****
    *- GetRestoreCmds() - Return the SET command argument for restoration
    *- Release() - Remove this object from memory

    * Custom Method Code

    ***** Basic Operations *****

    *- SaveGlobal() - Save our app-wide global list of SETs
    FUNCTION SaveGlobal(bSetDefaults)
        LOCAL oObj
        oObj = CREATEOBJECT('zAppSets', '', THIS)

        * Add the current table state
        oObj.oTblState = CREATEOBJECT('zTableState')

        * Set the app-wide defaults if desired
        IF bSetDefaults
            oObj.SetDefaultValues()
        ENDIF
        RETURN oObj
    ENDFUNC

    *- SaveState() - Save the current table's state and maybe one other
    FUNCTION SaveState(cAlias)
        LOCAL oObj

        * SaveState(cAlias) has an optional cAlias parameter. If passed, after
        *   the current table's state is saved, that cAlias will be selected and
        *   its state will also be saved (2 birds with one stone). When state is
        *   restored upon release, both states will be restored properly.
        oObj = CREATEOBJECT('zTableState', cAlias)
        RETURN oObj
    ENDFUNC

    *- SaveGroup() - Save the passed list of SETs
    FUNCTION SaveGroup(cList)
        LOCAL oObj
        oObj = CREATEOBJECT('zSaveSets', cList, THIS)
        RETURN oObj
    ENDFUNC

    *- SaveOne() - Return a single SET command's resetting object
    FUNCTION SaveOne(cSetCmd)
        LOCAL oObj
        oObj = CREATEOBJECT('zOneSet', cSetCmd, THIS)
        RETURN oObj
    ENDFUNC


    ***** Utilities *****

    *- GetRestoreCmds() - Return the SET command argument for restoration
    FUNCTION GetRestoreCmds(cSet, cCmd1, cCmd2, cCmd3)
        LOCAL cName, xCurrSet, nCount, xCurrSet2, nLen, cLDelim, cRDelim, bIsOn

        * We're to return the complete command necessary to restore the
        *   current SETting.  That also means, we have to GET the current
        *   setting.
        cName = UPPER(cSet)

        * Handle the many commands
        DO CASE

        * Single-State commands without TO connector
        CASE '^' + cName + '^' $ THIS.cSingleNamesNoTO
            xCurrSet = SET(cSet)

            * These are all ON/OFF commands
            cCmd1 = [SET ] + cName + [ ] + xCurrSet
            RETURN 1

        * Single-State commands WITH a TO connector
        CASE '^' + cName + '^' $ THIS.cSingleNamesTO
            xCurrSet = SET(cSet)

            * These, of course, have TO connectors but the current setting
            *   could be numeric
            cCmd1 = [SET ] + cName + [ TO ] + TRANSFORM(xCurrSet)
            RETURN 1

        * Special commands
        CASE '^' + cName + '^' $ THIS.cSpclSetNames
            DO CASE
            CASE cName = 'CURDIR'
                cCmd1 = 'CD ' + SET('DEFAULT') + CURDIR()
            CASE cName = 'ONERROR'
                cCmd1 = 'ON ERROR ' + ON('ERROR')
            CASE cName = 'ONESCAPE'
                cCmd1 = 'ON ESCAPE ' + ON('ESCAPE')
            CASE cName = 'ONSHUTDOWN'
                xCurrSet = ON('SHUTDOWN')
                cCmd1 = 'ON SHUTDOWN ' + xCurrSet
            CASE cName = 'SRCH1ST'
                cCmd1 = 'SYS(2450, ' + SYS(2450) + ')'
            ENDCASE
            RETURN 1
        OTHERWISE

            * Multi-State commands - This requires work
            xCurrSet = SET(cSet)
            DO CASE

            * Commands, the 1st with no connecter, the 2nd with TO
            CASE '^' + cName + '^' $ THIS.cMultiNamesBlnkTO

                * Make the TO command go first
                xCurrSet = SET(cSet, 1)
                IF NOT EMPTY(xCurrSet)      && Add quotes
                    xCurrSet = ["] + xCurrSet + ["]
                ENDIF
                cCmd1 = [SET ] + cName + [ TO ] + xCurrSet
                xCurrSet = SET(cSet)
                cCmd2 = [SET ] + cName + [ ] + xCurrSet
                RETURN 2

            * Now, the real oddities
            * CENTURY - Determines how centuries are displayed
            *     SET CENTURY ON | OFF            SET('CENTURY')      --> ON or OFF
            *     SET CENTURY TO nCentury         SET('CENTURY', 1)   --> nCentury
            *         (defines the century for 2-digit dates)
            *     SET CENTURY TO nCentury ROLLOVER nYear
            *                                     SET('CENTURY',2)    --> nYear
            *         (defines year = current century; next year is next century)
            *                                     SET('CENTURY',3)    --> System
            *         (this is the System Regional Calendar setting - this passes a
            *          Calendar value of 2 (Gregorian (U.S.)) in a call to the
            *          Windows GetCalendarInfo() API) - we won't use this last
            CASE cName = 'CENTURY'
                cCmd1 = [SET ] + cName + [ ] + xCurrSet
                xCurrSet = SET(cSet, 1)
                cCmd2 = [SET ] + cName + [ TO ] + TRANSFORM(xCurrSet)
                xCurrSet = SET(cSet, 2)
                cCmd2 = cCmd2 + [ ROLLOVER ] + TRANSFORM(xCurrSet)
                RETURN 2

            * COLLATE - Collation (sorting) sequence for indexes, sorts
            *     SET COLLATE TO MACHINE (default) SET('COLLATE')     --> DEFAULT
            *         (see help for other settings)
            CASE cName = 'COLLATE'

                * This requires quotes around the SET() argument
                cCmd1 = [SET COLLATE  TO "] + xCurrSet + ["]
                RETURN 1

            * DEVICE - Sets @...SAY output to screen, printer or file
            *     SET DEVICE TO SCREEN            SET('DEVICE')       --> SCREEN
            *       | TO PRINTER [PROMPT]         SET('DEVICE')       --> PRINT
            *       | TO FILE FileName            SET('DEVICE')       --> FILE
            *                                     SET('DEVICE',1)     --> FileName
            CASE cName = 'DEVICE'
                cCmd1 = [SET ] + cName + [ TO ] + xCurrSet
                xCurrSet = SET(cSet, 1)
                cCmd2 = [SET ] + cName + [ TO ] + xCurrSet
                RETURN 2

            * FIELDS - Defines visible fields in table
            *     SET FIELDS ON | OFF             SET('FIELDS')       --> ON or OFF
            *     SET FIELDS LOCAL | GLOBAL       SET('FIELDS', 2)    --> LOCAL or GLOBAL
            *     SET FIELDS TO FldName1, FldName2
            *                                     SET('FIELDS', 1)    --> field list
            CASE cName = 'FIELDS'
                cCmd1 = [SET ] + cName + [ ] + xCurrSet
                xCurrSet = SET(cSet, 1)
                cCmd2 = [SET ] + cName + [ TO ] + xCurrSet
                xCurrSet = SET(cSet, 2)
                cCmd3 = [SET ] + cName + [ ] + xCurrSet
                RETURN 3

            * KEY - Access a range of records
            *     SET KEY TO [cExpr1]             SET('KEY')         --> cExpr1
            *     SET KEY RANGE [cExpr1][, cExpr2] SET('KEY')        --> cExpr1, cExpr2
            *                                     SET('KEY', 1)      --> cExpr1
            *                                     SET('KEY', 2)      --> cExpr2
            CASE cName = 'KEY'
                xCurrSet2 = SET(cSet, 1)
                IF EMPTY(xCurrSet2)
                    cCmd1 = [SET ] + cName + [ TO ] + xCurrSet
                ELSE
                    cCmd1 = [SET ] + cName + [ TO RANGE ] + xCurrSet + [,] + ;
                      xCurrSet2
                ENDIF
                RETURN 1

            * MESSAGE - Defines a message for display
            *     SET MESSAGE TO [nRow [LEFT |    SET('MESSAGE')      --> nRow
            *       CENTER | RIGHT]]
            *     SET MESSAGE TO [cMessageText]   SET('MESSAGE',1)    --> cMessageText
            *     SET MESSAGE WINDOW [WindowName]
            CASE cName = 'MESSAGE'
                cCmd1 = [SET ] + cName + [ TO ] + TRANSFORM(xCurrSet)
                xCurrSet = SET(cSet, 1)
                cCmd2 = [SET ] + cName + [ TO ] + xCurrSet
                RETURN 2

            * NULLDISPLAY - Define what to display for .NULL. values
            *     SET NULLDISPLAY TO [cNullText]  SET('NULLDISPLAY')  --> cNullText
            CASE cName = 'NULLDISPLAY'

                * This requires quotes around the SET() argument
                cCmd1 = [SET NULLDISPLAY  TO "] + xCurrSet + ["]
                RETURN 1

            * PRINTER - Dis/Enables output to a printer, file or port
            *     SET PRINTER ON [PROMPT] | OFF   SET('PRINTER')      --> ON or OFF
            *     SET PRINTER TO [FileName        SET('PRINTER',1)    --> FileName or
            *       [ADDITIVE] | PortName]                                 PortName
            *     SET PRINTER TO [DEFAULT |       SET('PRINTER',2)    --> Default Win
            *       NAME WindowsPrinterName]                               Printer
            *     SET PRINTER TO NAME             SET('PRINTER',3)    --> Default VFP
            *       \\ServerName\PrinterName                               Printer
            *     SET PRINTER FONT cFontName
            *       [, cFontSize] [STYLE cFontStyle]
            CASE cName = 'PRINT'

                * Unfortunately the SET()s don't quite work:
                *   1. If a printer was set to DEFAULT, there's no way to know that
                *   2. If a printer was set to another printer name, no
                *       SET('PRINTER', 2 or 3) will tell us that
                * So, if SET(,1) is empty, all we can do is SET PRINTER TO
                cCmd1 = [SET PRINTER ] + xCurrSet
                xCurrSet = SET(cSet, 1)
                IF EMPTY(xCurrSet)
                    xCurrSet = ''
                ENDIF
                cCmd2 = [SET PRINTER TO ] + xCurrSet
                RETURN 2

            * REFRESH - How often are data buffers updated with changes?
            *     SET REFRESH TO nSeconds1        SET('REFRESH')      --> nSeconds1
            *       [, nSeconds2]                 SET('REFRESH',1)    --> nSeconds2
            *     Note: nSeconds1 applies to browse windows (0 = no update)
            *           nSeconds2 applies to buffers; if not specified, it
            *           is usually nSeconds1.
            CASE cName = 'REFRESH'
                cCmd1 = [SET ] + cName + [ TO ] + TRANSFORM(xCurrSet)
                xCurrSet = SET(cSet, 1)
                IF NOT EMPTY(xCurrSet)
                    cCmd1 = cCmd1 + [,] + TRANSFORM(xCurrSet)
                ENDIF
                RETURN 1

            * REPROCESS - If lock fails, how much should VFP try again?
            *     SET REPROCESS TO nAttempts      SET('REPROCESS')      --> current session setting
            *       [SECONDS] [SYSTEM] | TO AUTOMATIC [SYSTEM]
            *                                     SET('REPROCESS', 1)   --> SYSTEM settting
            *     If nAttemps > 0, SECONDS means try for that long; SYSTEM
            *     means that SET REPROCESS applies to the system data session.
            CASE cName = 'REPROCESS'
                cCmd1 = [SET ] + cName + [ TO ] + TRANSFORM(xCurrSet)
                xCurrSet = SET(cSet, 1)
                IF NOT EMPTY(xCurrSet)
                    cCmd1 = cCmd1 + [,] + xCurrSet
                ENDIF
                RETURN 1

            * TALK - Should VFP display command results?
            *     SET TALK ON | OFF               SET('TALK')             --> ON or OFF
            *       | WINDOW [WindowName]         SET('TALK',1)           --> WINDOW,
            *       | NOWINDOW                                                 NOWINDOW
            *                                                                  or WindowName
            CASE cName = 'TALK'
                cCmd1 = [SET ] + cName + [ ] + xCurrSet
                xCurrSet = SET(cSet, 1)
                IF xCurrSet = 'WINDOW' OR xCurrSet = 'NOWINDOW'
                    cCmd2 = [SET ] + cName + [ ] + xCurrSet
                ELSE
                    cCmd2 = [SET ] + cName + [ WINDOW ] + xCurrSet
                ENDIF
                RETURN 2

            * TEXTMERGE - Dis/Enables text-merge output
            *     SET TEXTMERGE [ON | OFF]        SET('TEXTMERGE')        --> ON or OFF
            *       [TO [FileName] [ADDITIVE]]    SET('TEXTMERGE', 2)     --> FileName
            *       [WINDOW WindowName]
            *       [SHOW | NOSHOW]               SET('TEXTMERGE', 3)     --> SHOW/NOSHOW
            *     Note: SET('TEXTMERGE', 4) evaluates the source of TEXT ... ENDTEXT
            *           call and returns the TEXTMERGE nesting level - don't use
            *     SET TEXTMERGE DELIMETERS TO [cLeftDelim [, cRightDelim]]
            *                                     SET('TEXTMERGE', 1)     --> Delims
            CASE cName = 'TEXTMERGE'
                cCmd1 = [SET ] + cName + [ ] + xCurrSet
                bIsOn = (xCurrSet = [ON])
                xCurrSet = SET(cSet, 2)
                cCmd2 = [SET ] + cName + [ TO ] + xCurrSet
                xCurrSet = SET(cSet, 3)
                IF bIsOn AND NOT EMPTY(xCurrSet)
                    cCmd2 = cCmd2 + [ ] + xCurrSet
                ENDIF

                * DELIMITERS
                xCurrSet = SET(cSet, 1)
                nLen = LEN(xCurrSet) / 2
                cLDelim = ["] + LEFT(xCurrSet, nLen) + ["]
                cRDelim = ["] + SUBSTR(xCurrSet, nLen+1) + ["]
                cCmd3 = [SET TEXTMERGE DELIMITERS TO ] + cLDelim + [,] + cRDelim
                RETURN 3

            * TOPIC - Define the Help topic to open in the VFP Help system
            *     SET TOPIC TO [cTopic | bExpr]   SET('TOPIC')            --> cTopic or
            *                                                                  bExpr
            *     SET TOPIC ID TO nContextID      SET('TOPIC', 1)         --> nContextID
            CASE cName = 'TOPIC'
                cCmd1 = [SET ] + cName + [ TO ] + xCurrSet
                xCurrSet = SET(cSet, 1)
                cCmd2 = [SET ] + cName + [ TO ] + TRANSFORM(xCurrSet)
                RETURN 2
            ENDCASE
        ENDCASE

        * Oops!  If we got here, it's a SET we don't know about - toss a bug
        X_ERRMSG = 'Unknown SET Name: ' + cName
        X_ERRCMD = THIS.Name + [.GetRestoreCmds(cSet, cCmd1, cCmd2, cCmd3)]
        HANDLERR( 6969, PROGRAM(), LINENO(), SYS(16), THIS )

        * Done
        RETURN 0
    ENDFUNC

    *- Release() - Remove this object from memory
    PROCEDURE Release()
        THIS.Destroy()
        Release THIS
    ENDPROC
ENDDEFINE

* zTableState - Class for saving an alias's relevant SET commands
DEFINE CLASS zTableState AS zSet

    * Class Notes:
    *   1. Init([cAlias]) - Optionaln, if passed, after the current table's state
    *       is saved, that cAlias will be selected and its state will also be
    *       saved (2 birds with one stone). When state is restored upon release,
    *       both states will be restored properly (e.g. the alias first then the
    *       current alias).
    *   2. For each table, here's what's being saved of its "state":
    *           SELECT Area
    *           ALIAS
    *           RECNO()
    *           TAG
    *           FILTER
    *           SET SKIP Status
    *           DELETED() SETting
    *           NEAR SETting
    *           RELATION, RELATION target and RELATION target record number

    * Basic Properties
    Name = 'zTableState'
    bResetDone = .F.

    * State Properties
    nSelect  = 0
    cAlias   = ''
    nRecno   = 0
    cTag     = ''
    cFilter  = ''
    cDelete  = ''
    cNear    = ''
    cRelate  = ''       && CUST_ID INTO CONTACTS
    cRelTarg = ''
    nRelaRec = 0
    cSkip    = ''

    * And, there may be a 2nd state for the optional cAlias passed
    o2ndState = NULL

    * Custom Method List:
    *- Init() - Set ourselves up
    *- SaveTblState() - Save the current table's state
    *- RestoreState() - Restore a current table's state
    *- GetOrder() - Returns the current index tag (or '0')
    *- GetFilter() - Y2K Save filter setting retrieval
    *- Destroy() - Remove ourselves from memory resetting all SET commands

    * Custom Method Code

    *- Init() - Set ourselves up
    FUNCTION Init(cNewAlias)
        IF NOT DODEFAULT()
            RETURN .F.
        ENDIF

        * Save the current table's state
        THIS.SaveTblState(cNewAlias)

        * Done
        RETURN .T.
    ENDFUNC

    *- SaveTblState() - Save the current table's state
    FUNCTION SaveTblState(cAlias2)
        LOCAL nS, cRelaTarget

        * Put the current state into our properties
        WITH THIS
            .cDelete  = SET('DELETED')
            .cNear    = SET('NEAR')
            .nSelect  = SELECT()
            .cAlias   = ALIAS()
            IF NOT EMPTY(.cAlias)
                .nRecno   = IIF(EOF() .OR. BOF(), 0, RECNO())
                .cTag     = THIS.GetOrder()
                .cFilter  = THIS.GetFilter()
                .cSkip    = SET('SKIP')
                .cRelate  = SET('RELATION')     && CUST_ID INTO CONTACTS

                * Get the rest of the relation info if appropriate
                IF NOT EMPTY(.cRelate)
                    nS = AT('INTO ', .cRelate)
                    IF nS > 0

                        * Relation target
                        cRelaTarget = SUBSTR(.cRelate, nS+5)
                        nS = AT(',', cRelaTarget)
                        IF nS > 0
                            cRelaTarget = TRIM(LEFT(cRelaTarget, nS-1) )
                        ENDIF
                        .cRelTarg = cRelaTarget

                        * Relation target record number
                        .nRelaRec = IIF( EOF(cRelaTarget) OR BOF(cRelaTarget), ;
                          0, RECNO(cRelaTarget) )
                    ENDIF
                ENDIF
            ENDIF

            * Clear any filter
            IF NOT EMPTY(.cFilter)
                SET FILTER TO
            ENDIF
        ENDWITH

        * If we were passed an alias, select that alias and get its status
        IF VARTYPE(cAlias2) = 'C' AND NOT EMPTY(cAlias2)

            * No point if we've just saved the passed alias's state
            IF UPPER(ALIAS()) <> UPPER(cAlias2)
                SELECT (cAlias2)
                THIS.o2ndState = CREATEOBJECT(THIS.Class)
            ENDIF
        ENDIF
    ENDFUNC

    *- RestoreState() - Restore a current table's state
    FUNCTION RestoreState()
        LOCAL cSetting, cAlias, nSetting, cRelaTarget, nRelaRecord

        * This method restores the previously saved talbe state(s)

        * If we have a secondary state object, restore that state first
        IF NOT ISNULL(THIS.o2ndState)
            THIS.o2ndState.Release()
        ENDIF

        * Now handle our primary table's state restoration
        WITH THIS

            * DELETED
            cSetting = .cDelete
            SET DELETED &cSetting

            * NEAR
            cSetting = .cNear
            SET NEAR &cSetting

            * Get our alias
            cAlias = .cAlias

            * Don't do file stuff if the ALIAS is empty
            IF EMPTY( cAlias )

                * Select area
                nSetting = .nSelect
                SELECT (nSetting)
            ELSE
                SELECT (cAlias)

                * Relation
                cSetting = .cRelate
                IF NOT EMPTY(cSetting)
                    SET RELATION TO &cSetting
                ELSE
                    SET RELATION TO
                ENDIF

                * Set Skip
                cSetting = .cSkip
                IF NOT EMPTY(cSetting)
                    SET SKIP TO &cSetting
                ELSE
                    SET SKIP TO
                ENDIF

                * Filter
                cSetting = .cFilter
                IF NOT EMPTY(cSetting)
                    SET FILTER TO &cSetting
                ELSE
                    SET FILTER TO
                ENDIF

                * Tag/Order
                cSetting = .cTag
                IF cSetting = '0'
                    SET ORDER TO 0
                ELSE
                    IF ' DESCENDING' $ cSetting
                        SET ORDER TO &cSetting
                    ELSE
                        SET ORDER TO TAG (cSetting)
                    ENDIF
                ENDIF

                * Record pointer
                nSetting = .nRecno
                IF BETWEEN(nSetting, 1, RECCOUNT() )
                    GOTO nSetting
                ELSE
                    GO BOTTOM
                    IF NOT EOF()
                        SKIP
                    ENDIF
                ENDIF

                * If we had a relational target and record number, re-point the
                *   target.
                cRelaTarget = .cRelTarg
                nRelaRecord = .nRelaRec
                IF (NOT EMPTY(cRelaTarget) ) .AND. nRelaRecord > 0
                    SELECT (cRelaTarget)
                    IF BETWEEN( nRelaRecord, 1, RECCOUNT() )
                        GOTO nRelaRecord
                    ENDIF
                    SELECT (cAlias)
                ENDIF
            ENDIF
        ENDWITH
    ENDFUNC

    *- GetOrder() - Returns the current index tag (or '0')
    FUNCTION GetOrder()
        LOCAL cCurrTag

        * Get the current tag
        cCurrTag = SET('ORDER')
        IF EMPTY(cCurrTag)
            cCurrTag = '0'
        ELSE

            * Strip stuff surrounding tag name - TAG CONTCUST OF BLAHBLAH.CDX
            IF LEFT( cCurrTag,4) = 'TAG '
                cCurrTag = SUBSTR(cCurrTag,5)
            ENDIF
            IF ' ' $ cCurrTag
                cCurrTag = LEFT(cCurrTag,AT(' ',cCurrTag)-1)
            ENDIF

            * Is this in DESCENDING order?
            IF 'DESCENDING' $ SET('INDEX')
                cCurrTag = cCurrTag + ' DESCENDING'
            ENDIF
        ENDIF
        RETURN cCurrTag
    ENDFUNC

    *- GetFilter() - Y2K Save filter setting retrieval
    FUNCTION GetFilter( cAliasIn )
        LOCAL cAlias, cOldDate, cFiltExpr

        * The cAliasIn parameter is optional
        IF TYPE('cAliasIn') = 'C' AND NOT EMPTY(cAliasIn)
            cAlias = cAliasIn
        ELSE
            cAlias = ALIAS()
        ENDIF
        IF EMPTY(cAlias)
            RETURN ''           && Empty file = empty filter
        ENDIF

        * To be absolutely safe for Y2K, date constant expressions in filters
        *   must be in the unambiguous form of {^yyyy-mm-dd}.  So, what we'll
        *   do here is to convert any dates into that type of expression.

        * Get the SET DATE setting and change to YMD
        cOldDate = SET('DATE')
        SET DATE TO YMD

        * Now, get the filter expression
        cFiltExpr = FILTER(cAlias)

        * Correct any date expressions
        IF '{' $ cFiltExpr
            cFiltExpr = STRTRAN(cFiltExpr, '{', '{^')
        ENDIF

        * Done, reset and return
        SET DATE TO &cOldDate
        RETURN cFiltExpr
    ENDFUNC

    *- Destroy() - Remove ourselves from memory resetting all SET commands
    FUNCTION Destroy()
        IF NOT THIS.bResetDone
            THIS.RestoreState()
            THIS.bResetDone = .T.
        ENDIF
    ENDFUNC
ENDDEFINE

* zAppSets - Class for saving app-wide, global SET commands
DEFINE CLASS zAppSets AS zSaveSets

    * Class Notes:
    *   These SET names are those commonly used in applicatins. As that's our
    *   focus, developer sets are not included (SET STEP, SET MENU, etc.)

    * Properties
    Name = 'zAppSets'

    * Our list of global, app-wide SETs
    cSetList = [ALTERNATE,ANSI,AUTOINCERROR,AUTOSAVE,BELL,BLOCKSIZE,CARRY,] + ;
      [CENTURY,CLOCK,COLLATE,COMPATIBLE,CONFIRM,CONSOLE,CPDIALOG,CURDIR,] + ;
      [CURRENCY,CURSOR,DATABASE,DATE,DECIMALS,DELETED,DEVICE,ECHO,ESCAPE,] + ;
      [EXACT,EXCLUSIVE,FDOW,FIELDS,FIXED,FULLPATH,FWEEK,HOURS,KEYCOMP,] + ;
      [LOCK,MARGIN,MEMOWIDTH,MESSAGE,MULTILOCKS,NEAR,NOTIFY,NULL,] + ;
      [NULLDISPLAY,ODOMETER,OLEOBJECT,ONERROR,ONESCAPE,ONSHUTDOWN,OPTIMIZE,] + ;
      [POINT,PRINTER,REFRESH,REPROCESS,RESOURCE,SAFETY,SECONDS,SPACE,SRCH1ST,] + ;
      [STATUS BAR,STRICTDATE,TALK,TEXTMERGE,TOPIC,TYPEAHEAD,UDFPARMS,UNIQUE]

    * Starting table state
    oTblState = NULL

    * Custom Method List:
    *- SetDefaultValues() - SET our desired app environment values
    *- Destroy() - Remove ourselves from memory resetting all SET commands

    * Custom Method Code

    *- PrintAppSETs(cFile) - Print our global app settings to a file
    FUNCTION PrintAppSETs(cFileName)
        LOCAL cStr, nRow, nCount, nX, cCmd

        * Heading
        *                     Global Reset Commands         03/21/2016 at 10:40
        cStr = SPACE(30) + [Global Reset Commands] + SPACE(9) + DTOC(DATE()) + ;
          ' at ' + LEFT(TIME(), 5) + CR_LF + CR_LF

        * Go thru all rows of our array
        WITH THIS
            FOR nRow = 1 TO .nRows
                nCount = .aRA[nRow,2]
                FOR nX = 1 TO nCount
                    cCmd = .aRA[nRow,nX+2]
                    cStr = cStr + cCmd + CR_LF
                ENDFOR
            ENDFOR
        ENDWITH

        * Put this into the file and we're done
        STRTOFILE(cStr, cFileName)
   ENDFUNC

    *- SetDefaultValues() - SET our desired app environment values
    PROCEDURE SetDefaultValues()
        SYS(2450, 1)
        SET ALTERNATE TO
        SET ALTERNATE OFF
        SET ANSI ON
        SET AUTOINCERROR ON
        SET AUTOSAVE ON
        SET BELL TO
        SET BELL ON
        SET BLOCKSIZE TO 64
        SET CARRY OFF
        SET CENTURY TO
        SET CENTURY ON
        SET CLOCK TO
        SET CLOCK OFF
        SET COLLATE TO "MACHINE"
        SET COMPATIBLE OFF
        SET CONFIRM OFF
        SET CONSOLE ON
        SET CPDIALOG OFF
        SET CURRENCY TO $
        SET CURRENCY LEFT
        SET CURSOR ON
        SET DATABASE TO
        SET DATE AMERICAN
        SET DECIMALS TO 10
        SET DELETED ON
        SET DEVICE TO SCREEN
        IF VERSION(2) = 0           && Run-time version
            SET ESCAPE OFF
        ELSE
            SET ESCAPE ON
        ENDIF
        SET EXACT OFF
        SET EXCLUSIVE OFF
        SET FDOW TO 1               && Sunday
        SET FIELDS OFF
        SET FIELDS TO
        SET FIXED OFF
        SET FULLPATH ON
        SET FWEEK TO 1              && 1st week contains Jan. 1
        SET HOURS TO 24
        SET KEYCOMP TO WINDOWS
        SET LOCK OFF
        SET MARGIN TO 0
        SET MEMOWIDTH TO 100
        SET MESSAGE TO
        SET MULTILOCKS ON
        SET NEAR OFF
        IF VERSION(2) = 0           && Run-time version
           SET NOTIFY OFF
        ELSE
           SET NOTIFY ON
        ENDIF
        SET NULL OFF
        SET NULLDISPLAY TO "NULL"
        SET ODOMETER TO 100
        SET OLEOBJECT ON
        SET OPTIMIZE ON
        SET POINT TO .
        SET PRINTER OFF
        SET PRINTER TO
        SET REFRESH TO 5, 1 SECONDS     && Update browse in 5 secs, buffers in 1
        SET REPROCESS TO 1              && Retry locking after 1 second
        IF FILE("FOXUSER.DBF")
            SET RESOURCE TO ("FOXUSER.DBF")
            SET RESOURCE ON
        ELSE
            SET RESOURCE TO
            SET RESOURCE OFF
        ENDIF
        SET SAFETY OFF
        SET SECONDS ON
        SET SPACE ON
        SET STATUS BAR ON
        SET STRICTDATE TO 0         && Off
        SET TALK OFF
        SET TEXTMERGE OFF
        SET TEXTMERGE DELIMITERS
        SET TOPIC TO
        SET TOPIC ID TO
        SET TYPEAHEAD TO 20
        SET UDFPARMS TO VALUE
        SET UNIQUE OFF
        RETURN
    ENDPROC

    *- Destroy() - Remove ourselves from memory resetting all SET commands
    FUNCTION Destroy()
        LOCAL oState
        IF NOT THIS.bResetDone
            DODEFAULT()
            IF NOT ISNULL(THIS.oTblState)
                oState = THIS.oTblState
                THIS.oTblState = NULL
                RELEASE oState
            ENDIF
            THIS.bResetDone = .T.
        ENDIF
    ENDFUNC
ENDDEFINE

* zSaveSets - Class for saving multiple SET commands
DEFINE CLASS zSaveSets AS EnvArray

    * Class Notes:
    *   1. Init's cSetList - This is a comma-delimited list of SETs to save comes
    *       from either the Init() parameter or the .cSetList property.
    *       No set list = bug.
    *   2. When this object is destroyed, all saved SET values are set to
    *       the ones in effect at object creation.

    * Properties
    Name = 'zSaveSets'
    cSetList = ''           && List of SETs to save/restore
    bResetDone = .F.

    * Our array properties:
    *   .aRA[x,1] - SET command Name
    *   .aRA[x,2] - Number of restore commands
    *   .aRA[x,3] - Restore command #1
    *   .aRA[x,4] - Restore command #2
    *   .aRA[x,5] - Restore command #3
    nCols = 5

    * Custom Method List:
    *- Init() - Set ourselves up
    *- PROT SaveSETtings() - Save all SETtings in our our list
    *- PROT GetNextName() - Extract and return the next name from a string
    *- Destroy() - Remove ourselves from memory resetting all SET commands

    * Custom Method Code

    *- Init() - Set ourselves up
    FUNCTION Init(cSetList, oCaller)
        IF NOT DODEFAULT()
            RETURN .F.
        ENDIF

        * Save the parameter if we have it
        IF VARTYPE(cSetList) = 'C' AND NOT EMPTY(cSetList)
            THIS.cSetList = cSetList
        ENDIF

        * We must have a SET list to work on or it's a bug
        IF EMPTY(THIS.cSetList)
            ERROR 'No SET List is available for saving'
            RETURN .F.
        ENDIF

        * Save the current settings
        THIS.SaveSETtings(oCaller)

        * Done
        RETURN .T.
    ENDFUNC

    *- PROT SaveSETtings() - Save all SETtings in our our list
    PROTECTED FUNCTION SaveSETtings(oCaller)
        LOCAL cToDo, cName, cRest1, cRest2, cRest3, nCmdCnt

        * Load up our array with the commands from the passed list
        cToDo = UPPER(THIS.cSetList)
        DO WHILE NOT EMPTY(cToDo)

            * Get the SET name
            cName = THIS.GetNextName( @cToDo )

            * Get our restoration SET commands
            STORE '' TO cRest1, cRest2, cRest3
            nCmdCnt = oCaller.GetRestoreCmds(cName, @cRest1, @cRest2, @cRest3)

            * Add these to the array
            THIS.AddRow(cName, nCmdCnt, cRest1, cRest2, cRest3)

            * Next command
        ENDDO
        RETURN
    ENDFUNC

    *- PROT GetNextName() - Extract and return the next name from a string
    PROTECTED FUNCTION GetNextName(cStr)
        LOCAL nPosn, cRetVal

        * Inputs: cStr - Comma-delimited list of SET names.  Must be passed
        *           as @cStr for extraction to work
        * Output: First name on the list (its comma is extracted also)

        * Extract the name from the passed string
        nPosn = AT(',', cStr)
        IF nPosn = 0
            cRetVal = TRIM( cStr )
            cStr = ''
        ELSE
            cRetVal = TRIM( LEFT(cStr, nPosn-1) )
            cStr = LTRIM( SUBSTR(cStr, nPosn+1) )
        ENDIF
        RETURN cRetVal
    ENDFUNC

    *- Destroy() - Remove ourselves from memory resetting all SET commands
    FUNCTION Destroy()
        LOCAL nX, cCmdCnt, nY, cCmd
        WITH THIS
            IF NOT .bResetDone
                FOR nX = 1 TO .nRows
                    nCmdCnt = .aRA[nX,2]
                    FOR nY = 1 TO nCmdCnt
                        cCmd = .aRA[nX,2+nY]
                        &cCmd
                    ENDFOR
                ENDFOR
                .bResetDone = .T.
            ENDIF
        ENDWITH
    ENDFUNC
ENDDEFINE

* zOneSet - Class for saving one SET's restoration commands
DEFINE CLASS zOneSet AS zSet

    * Properties
    Name = 'zOneSet'
    cSetName = ''           && SET command name
    nNumArgs = 1            && How many SET commands to execute (up to 3)
    cCmdArg1 = 'SET DECIMALS TO 10'           && Argument for the restoration SET command
    cCmdArg2 = ''           && Multi-state SET command arguments
    cCmdArg3 = ''
    bResetDone = .F.

    * Custom Method List:
    *- Init() - Set ourselves up
    *- Destroy() - Remove ourselves from memory resetting our SET command(s)

    * Custom Method Code

    *- Init() - Set ourselves up
    FUNCTION Init(cSet, oCaller)
        LOCAL cRest1, cRest2, cRest3, nCount

        * Make sure only our allowed creator is there
        IF PCOUNT() <> 2 OR VARTYPE(oCaller) <> 'O' OR ISNULL(oCaller)
            RETURN .F.
        ENDIF
        IF NOT DODEFAULT()
            RETURN .F.
        ENDIF
        THIS.cSetName = cSet

        * Get our restoration commands
        STORE '' TO cRest1, cRest2, cRest3
        nCount = oCaller.GetRestoreCmds(cSet, @cRest1, @cRest2, @cRest3)
        WITH THIS
            .nNumArgs = nCount
            .cCmdArg1 = cRest1
            .cCmdArg2 = cRest2
            .cCmdArg3 = cRest3
        ENDWITH
        RETURN .T.
    ENDFUNC

    *- Destroy() - Remove ourselves from memory resetting our SET command(s)
    FUNCTION Destroy()
        PUBLIC cCmd
        WITH THIS
            IF NOT .bResetDone
                cCmd = .cCmdArg1
                &cCmd
                IF .nNumArgs > 1
                    cCmd = .cCmdArg2
                    &cCmd
                    IF .nNumArgs > 2
                        cCmd = .cCmdArg3
                        &cCmd
                    ENDIF
                ENDIF
                .bResetDone = .T.
            ENDIF
        ENDWITH
    ENDFUNC
ENDDEFINE

* zSet - Semi-abstract SETting class (subclass: Session)
DEFINE CLASS zSet AS Line

    * We want this to be a very lightweight class; our goal (after adding
    *   Release()) is to prevent unused properties and methods from being
    *   visible to subclasses.

    * Properties
    Name = 'zSet'

    * Define the protected properties
    PROTECTED Application, ClassLibrary, Comment, DataSession, DataSessionID, ;
      Parent, ParentClass, Tag

    * Define the protected methods
    PROTECTED ReadExpression, ReadMethod, ResetToDefault, WriteExpressionMethod

    * Note: Tests showed that this object uses about 2384 bytes of memory

    * Custom Method List:
    *- Release() - Release ourselves

    * Custom Method Code

    *- Release() - Release ourselves
    FUNCTION Release()
        RELEASE THIS
    ENDFUNC
ENDDEFINE

* EnvArray Class Definition - General Array Object
DEFINE CLASS EnvArray AS Custom

    * Class Note: This is a greatly stripped-donw version of our ArrayObj class
    *             but it's necessary here as we want to save the incoming state
    *             before SET PROCEDURE.

    * Standard Properties
    Name = 'EnvArray'

    * Custom Properties
    DIMENSION aRA[1]
    nRows = 0               && Rows in the array
    nCols = 1               && Columns in the array

    * Block the base class properties we'll never need
    PROTECTED Application, ClassLibrary, Comment, Height, HelpContextID, Left, ;
      Object, Picture, Top, WhatsThisHelpID, Width

    * Block the base class methods we'll never need
    PROTECTED ReadExpression, ReadMethod, ResetToDefault, SaveAsClass, ;
      ShowWhatsThis, WriteExpression, WriteMethod

    * Custom Method List
    *- Init() - Initialize an array object

    * Custom Method Code:

    *- Init() - Initialize an array object
    *   Parameters: [nCols] (REQUIRED for multi-dimensional arrays)
    *     Note - nRows will be 0 after Init()
    FUNCTION Init( nColCnt )
        IF NOT DODEFAULT()
            RETURN .F.
        ENDIF

        * Define the column count if it was passed
        IF TYPE('nColCnt') = 'N' AND nColCnt >= 1
            THIS.nCols = nColCnt
        ENDIF

        * Create the barebones array
        DIMENSION THIS.aRA[1, THIS.nCols]
        STORE '' TO THIS.aRA
        THIS.nRows = 0
        NODEFAULT
        RETURN .T.
    ENDFUNC

    *- AddRow() - Add a row to the array and load up to 20 columns in that row
    *     Parameters: xVal1 [,xVal2] [,xVal3] [...to xVal20]
    *     Returns: the new row number
    *     Note - xValX values are ignored if they exceed the number of columns
    FUNCTION AddRow (xVal1, xVal2, xVal3, xVal4, xVal5, xVal6, xVal7, xVal8)
        LOCAL nNewRowNum, nX, cVarName, xValue

        * Add a new row
        nNewRowNum = THIS.InsertRow()

        * We must always have the first value
        THIS.aRA[nNewRowNum,1] = xVal1

        * How many values did we receive?  Or, rather, will we use?
        nValCount = MIN( PCOUNT(), THIS.nCols )

        * Change only the passed parameters
        FOR nX = 2 TO nValCount
            cVarName = 'xVal' + LTRIM( STR(nX,2,0) )
            xValue = EVAL(cVarName)

            * These can only be for multicolumn arrays
            THIS.aRA[nNewRowNum, nX] = xValue
        ENDFOR
        RETURN nNewRowNum
    ENDFUNC

    *- InsertRow() - Add a row to the array (re-size it larger)
    *   Parameters: [nBeforeRow]
    *   Returns: The new number of rows in the array
    *   Notes:
    *       1. If nBeforeRow is passed, the new row is inserted into the array
    *           just before that row.  If not passed, the new row is added to
    *           the end of the array.
    *       2. All columns in the new row are initialized to ''
    FUNCTION InsertRow(nRowNum)
        LOCAL nX
        WITH THIS

            * First, re-dimension the array
            DIMENSION .aRA[.nRows+1, .nCols]

            * Are we to insert a row or just add one at the end?
            IF TYPE('nRowNum') = 'N' AND BETWEEN(nRowNum, 1, .nRows)
                = AINS(.aRA, nRowNum)          && Insert the row
            ELSE

                * Add a row at the end (already done), just note the row
                nRowNum = .nRows + 1
            ENDIF

            * Initialize the new row
            FOR nX = 1 to .nCols
                .aRA[nRowNum, nX] = ''
            ENDFOR

            * Reset the row count
            .nRows = ALEN(.aRA, 1)
        ENDWITH

        * Return the new row total
        RETURN THIS.nRows
    ENDFUNC

    *- Release() - Remove this object from memory
    PROCEDURE Release()
        THIS.Destroy()
        Release THIS
    ENDPROC
ENDDEFINE
