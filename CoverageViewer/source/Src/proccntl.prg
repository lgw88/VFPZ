#IF 0                           ProcCntl.prg

  Purpose:  Handle removing a directory and its contents

Revisions:  October 27, 2015 - Ken Green - Original

     Uses:  APPINCL.H - Manifest constants
            DataFile.prg - App's table classes
            AppCntls.vcx - Our parent classes
            Template.htm - Template page for output

Datafiles:  See DD.txt

****************************** Class Definition ****************************

* ProcCntl Class Definition - (base: Custom)

*****************************************************************************
#ENDIF

* Includes and defines
#INCLUDE INC\APPINCL.H
#DEFINE TAB_SPACES  SPACE(4)

* ProcCntl Class Definition - (base: Custom)
DEFINE CLASS ProcCntl AS zCustom

    * Key Properties
    oForm = NULL
    bNeedProj = .F.
    cProjDir  = ''

    * Our manipulation tables
    oLOG      = NULL
    oCALLS    = NULL
    oLINES    = NULL
    oSUMMARY  = NULL
    oCODEFILE = NULL
    oCHUNKS   = NULL
    oPROJECT  = NULL

    * Other process properties
    c1stProc  = ''                  && First procedure line
    nOATime   = 0                   && Total Processing time (secs)
    cTemplate = 'Template.htm'      && Used for HTML output page
    cOutFile  = 'CvgViewr.htm'
    bGotAppOrExe = .F.              && .T. if log file is from an APP/EXE file
    cLogFolder = ''

    * Array object of files to process in order by STACK_LVL. Format:
    *   .aRA[x,1] - Full filename
    *   .aRA[x,2] - STACK_LVL
    oFiles2Do = NULL

    * Custom Method List (code below):
    *- DoProcess() - Control our search thru all desired files

    *- CreateTables() - Create our support tables on the TEMP folder
    *- GetFileArray() - Return an array of filenames in processing order
    *- LoadCodeText() - Load code segments and other fields into SUMMARY.DBF
    *- GetFilesCode() - Return the code for a file
    *- ProcessChunk() - Process one code chunk in SUMMARY.DBF
    *- SetCXRecs() - Set USES and TOT_SECS for scx/vcx files
    *- GetFormattedCode() - Return the formatted code for a procedure

    *- GenerateWebPage() - Generate our HTML page of code chunk's uses and times
    *- GetHTMHeading() - Return the heading for the current CHUNKS.DBF record
    *- IndentMethods() - Properly indent method code
    *- GetTime() - Return a reasonably human readable time

    *- ProjNeeded() - Return .T. if we need the project file
    *- Destroy() - Clean up after ourselves

    * Custom Method Code:

    *- DoProcess() - Control our search thru all desired files
    FUNCTION DoProcess()
        LOCAL cMsg

        * Create and/or open our various tables.
        THIS.CreateTables()

        * That opened all of our tables; LOG, LINES and SUMMARY have been
        *   loaded with all values except SUMMARY.CODEFILE.
        * Now, we need an array of the files and their earliest
        *   STACK_LVL. Sort that by STACK_LVL.
        THIS.oFiles2Do = THIS.GetFileArray()

        * Get all code segments into SUMMARY and set the rest of SUMMARY's fields
        THIS.LoadCodeText()

        * Now, generate our HTML page then open it
        THIS.GenerateWebPage()

        * We're done; advise and quit
        cMsg = 'Analyzing ' + THIS.oForm.oEdit.cLogFile + 'has been completed.'
        MESSAGEBOX(cMsg, 0 + 64, 'CvgViewr is Done', 10 * 1000)
        IF goApp.oAppEdit.bGoToIt
            CLEAR EVENTS
        ENDIF
    ENDFUNC

    *- CreateTables() - Create our support tables on the TEMP folder
    FUNCTION CreateTables()
        LOCAL cMsg, nLogRecs, cMsg2, nLines

        * Before we do anything, make sure the LogData subdirectory exists if
        *   they wamt to keep the work tables.
        THIS.cLogFolder = ADDBS( JUSTPATH(THIS.oForm.oEdit.cLogFile))
        IF goApp.oAppEdit.bKeepTbls
            goApp.cDataPath = THIS.cLogFolder + 'LogData\'
            goFiles.MakeDir(goApp.cDataPath)
        ENDIF

        * Open the project file if needed
        IF THIS.bNeedProj
            THIS.oPROJECT = NULL
            THIS.oPROJECT = CREATEOBJECT('PROJECT', goApp.oAppEdit.cProjFile)
            GO TOP
            THIS.cProjDir = ADDBS( JUSTPATH(NAME) )
        ENDIF

        * Get the log file into LOG.DBF
        THIS.oForm.DisplayMsg(CR_LF, .T.)
        cMsg = 'Reading LOG file into table...'
        THIS.oForm.DisplayMsg(cMsg, .T.)
        THIS.oLOG = CREATEOBJECT('LOG', goApp.cDataPath)
        SET TALK ON
        nLogRecs = THIS.oLOG.CreateTable(THIS.oForm.oEdit.cLogFile)
        SET TALK OFF
        cMsg2 = 'Done - ' + TRANSFORM(nLogRecs) + ' records'
        THIS.oForm.ChangeMsgLine(cMsg, cMsg2, .T.)
        THIS.c1stProc = THIS.oLOG.c1stProc

        * Now, summarize all prg/function/method calls into CALLS.DBF.
        cMsg = 'Extracting callers and targets...'
        THIS.oForm.DisplayMsg(cMsg, .T.)
        THIS.oCALLS = CREATEOBJECT('CALLS', goApp.cDataPath)
        nCalls = THIS.oCALLS.CreateTable(THIS.oLOG, THIS.oForm)
        cMsg2 = 'Done - ' + TRANSFORM(nCalls) + ' calls'
        THIS.oForm.ChangeMsgLine(cMsg, cMsg2, .T.)

        * Summarize those lines
        cMsg = 'Adding up line totals...'
        THIS.oForm.DisplayMsg(cMsg, .T.)
        THIS.oLINES = CREATEOBJECT('LINES', goApp.cDataPath)

        * Here, TALK ON is useless, pass it the form and let it handle display
        nLines = THIS.oLINES.CreateTable(THIS.oLOG, THIS.oForm)
        cMsg2 = 'Done - ' + TRANSFORM(nLines) + ' unique lines'
        THIS.oForm.ChangeMsgLine(cMsg, cMsg2, .T.)

        * Done with the log table
        THIS.oLOG.Release()

        * Summarize only the calling LINES into SUMMARY.DBF
        cMsg = 'Summarizing procedures and functions...'
        THIS.oForm.DisplayMsg(cMsg, .T.)
        THIS.oSUMMARY = CREATEOBJECT('SUMMARY', goApp.cDataPath)

        * Again, pass it the form and let it handle display
        nLines = THIS.oSUMMARY.CreateTable(THIS.oLINES, THIS.oForm)
        cMsg2 = 'Done - ' + TRANSFORM(nLines) + ' calling routines'
        THIS.oForm.ChangeMsgLine(cMsg, cMsg2, .T.)

        * Note the overall processing time
        THIS.nOATime = THIS.oSUMMARY.nOATime

        * Create CHUNKS
        THIS.oCHUNKS = CREATEOBJECT('CHUNKS', goApp.cDataPath)
        THIS.oCHUNKS.CreateTable()

        * Create CODEFILE
        THIS.oCODEFILE = CREATEOBJECT('CODEFILE', goApp.cDataPath)
        THIS.oCODEFILE.CreateTable()

        * Done
        RETURN
    ENDFUNC

    *- GetFileArray() - Return an array of filenames in processing order
    FUNCTION GetFileArray()
        LOCAL oFiles, cFilesDone, cFile

        * Create our array object as:
        *   .aRA[x,1] - Full filename
        *   .aRA[x,2] - STACK_LVL
        oFiles = CREATEOBJECT('ArrayObj', 2)

        * Setup SUMMARY.DBF
        THIS.oSUMMARY.PushState()
        SET ORDER TO STACK          && Key: STACK_LVL

        * Load this from SUMMARY.DBF
        cFilesDone = ''
        SCAN
            cFile = TRIM(FILE)
            IF NOT (cFile $ cFilesDone OR EMPTY(cFile))
                oFiles.AddRow(cFile, STACK_LVL)
                cFilesDone = cFilesDone + cFile + ','
            ENDIF
        ENDSCAN

        * Done
        THIS.oSUMMARY.PopState()
        RETURN oFiles
    ENDFUNC

    *- LoadCodeText() - Load code segments and other fields into SUMMARY.DBF
    FUNCTION LoadCodeText()
        LOCAL nFileLen, cFirstChunk, bNeedFirstChunk, oFiles2Do, nRow, cFile, ;
          cMsg, cText, nChunk, nBegLine, nEndLine, nTotSecs, cKey, cDspOrd, ;
          nPosn, cClass, cProc

        * Setup LINES.DBF
        THIS.oLINES.PushState()
        nFileLen = LEN(FILE)

        * Setup SUMMARY.DBF
        THIS.oSUMMARY.PushState()

        * Note our first file/class/procedure
        SET ORDER TO STACK          && Key: STACK_LVL
        GO TOP
        cFirstChunk = FILE + CLASS + PROCEDURE
        bNeedFirstChunk = .T.

        * We want to go thru all files in THIS.oFiles2Do formatted as:
        *   .aRA[x,1] - Full filename
        *   .aRA[x,2] - STACK_LVL
        SET ORDER TO FILE           && Key: UPPER(FILE + CLASS + PROCEDURE)
        oFiles2Do = THIS.oFiles2Do
        FOR nRow = 1 TO oFiles2Do.nRows
            cFile = oFiles2Do.aRA[nRow,1]
            cMsg = '    Parsing file: ' + JUSTFNAME(cFile) + ': Code Chunk: '
            THIS.oForm.DisplayMsg(cMsg, .T.)

            * Get the file's text and put it in CODEFILE.DBF
            cText = THIS.GetFilesCode(cFile)
            THIS.oCODEFILE.LoadFilesCode(cFile, cText)

            * Load every proc we have in SUMMARY.DBF
            THIS.oSUMMARY.Select()
            SEEK UPPER(cFile)
            nChunk = 0
            SCAN WHILE FILE = cFile
                nChunk = nChunk + 1
                THIS.oForm.DisplayNumber(nChunk)

                * Handle our first chunk if needed
                IF bNeedFirstChunk
                    SEEK UPPER(cFirstChunk)
                ENDIF

                * Get the beginning and ending line # and add up the seconds
                STORE 0 TO nBegLine, nEndLine, nTotSecs
                cKey = CLASS + PROCEDURE + FILE
                SCAN WHILE CLASS + PROCEDURE + FILE = cKey
                    IF LINENUM < nBegLine OR nBegLine = 0
                        nBegLine = LINENUM
                    ENDIF
                    IF LINENUM > nEndLine
                        nEndLine = LINENUM
                    ENDIF
                    nTotSecs = nTotSecs + TOT_SECS
                ENDSCAN
                SKIP -1         && Point back to last record of chunk

                * Handle this chunk of code; first set its display order
                cDspOrd = STR(nRow, 2, 0) + STR(nChunk, 3, 0)
                THIS.ProcessChunk(cDspOrd, UPPER(cKey), nBegLine, nEndLine, ;
                  nTotSecs)

                * Reset for all other chunks
                IF bNeedFirstChunk
                    bNeedFirstChunk = .F.
                    SET FILTER TO NOT FILE + CLASS + PROCEDURE = cFirstChunk
                    SEEK UPPER(cFile)
                ENDIF

                * Next proc
            ENDSCAN
            IF nRow = 1
                SET FILTER TO
            ENDIF

            * Next file
        ENDFOR

        * Have oCALLS do the final tweaking
        cMsg = '    Adding code links...'
        THIS.oForm.DisplayMsg(cMsg, .T.)
        THIS.oCHUNKS.Select()
        SET ORDER TO DISPORDER          && DISPORDER (File # + Chunk #)
        SCAN

            * Get our capitalized version of the proc name
            nPosn = AT('.', PROCEDURE)
            IF nPosn > 0
                cClass = LEFT(PROCEDURE, nPosn)
                cProc = JUSTEXT(PROCEDURE)
                cCapProc = THIS.oCALLS.GetProcsCaps(cProc, CODETEXT)
                cProc = goStr.MakeProper(cClass) + cCapProc
            ELSE
                cProc = THIS.oCALLS.GetProcsCaps(PROCEDURE, CODETEXT)
            ENDIF
            REPLACE CAPSPROC WITH cProc

            * Have oCALLS put link tags in our code
            cText = THIS.oCALLS.AddCodeLinks(PROCEDURE, CODETEXT)
            IF NOT (cText == PROCEDURE OR EMPTY(cText))
                REPLACE CODETEXT WITH cText
            ENDIF
        ENDSCAN

        * Done
        THIS.oSUMMARY.PopState()
        THIS.oLINES.PopState()
    ENDFUNC

    *- ProcessChunk() - Process one code chunk in SUMMARY.DBF
    FUNCTION ProcessChunk(cDspOrder, cKey, nBegLine, nEndLine, nTotSecs)
        PRIVATE M.FILE, M.PROCEDURE, M.CLASS, M.DISPORDER, M.TOT_SECS, ;
          M.ACTBEGLN, M.CHUNKTYPE, M.ACTENDLN, M.LINKNAME, M.BACKLINKS, ;
          M.CODETEXT
        LOCAL cSummProc, cExt, cLINESAlias, cCHUNKSAlias, cText

        * Here, SUMMARY is selected, CODELOG has the file loaded, and:
        *   nBegLine, nEndLine have the recorded extreme line nos of the chunk
        *   nTotSecs has the sum of all lines times
        * We'lre to load CHUNKS with the data for this chunk.
        THIS.oCHUNKS.Select()
        SCATTER MEMVAR BLANK    && Loads All of the M. vars we need
        THIS.oSUMMARY.Select()
        SCATTER MEMVAR          && Loads only those from SUMMARY.dbf
        M.DISPORDER = cDspOrder
        M.TOT_SECS  = nTotSecs
        cSummProc   = PROCEDURE
        cFile       = TRIM(FILE)
        cExt        = JUSTEXT(cFile)

        * First, load this chunk in CODELOG with the actual USES and TOT_SECS for
        *   each line of this chunk
        cLINESAlias = THIS.oLINES.cAlias
        THIS.oCODEFILE.Select()

        * PRGs are relatively easy
        IF cExt = 'fxp'
            SET RELATION TO cKey + STR(RECNO(),5,0) INTO (cLINESAlias)
            GOTO nBegLine
            REPLACE USES WITH &cLINESAlias..USES, ;
              TOT_SECS WITH &cLINESAlias..TOT_SECS ;
              FOR FOUND(cLINESAlias) ;
              WHILE RECNO() <= nEndline
            SET RELATION TO

            * Have CODEFILE get us the actual beginning and ending lines and the
            *   chunk type
            M.CHUNKTYPE = ''
            M.ACTENDLN = 0
            M.ACTBEGLN = THIS.oCODEFILE.GetActualCodeLines(nBegLine, nEndLine, ;
              nTotSecs, @M.ACTENDLN, @M.CHUNKTYPE)
        ELSE        && cExt = 'vcx' or 'scx'
            THIS.SetCXRecs(cKey, nBegLine, nEndLine, nTotSecs, cLINESAlias)
        ENDIF

        * Have oCALLS get us our link and backlinks
        M.BACKLINKS = ''
        M.LINKNAME = THIS.oCALLS.GetLinkInfo(cSummProc, @M.BACKLINKS)

        * Get our formatted code text
        M.CODETEXT = THIS.GetFormattedCode(M.ACTBEGLN, M.ACTENDLN)

        * And save the results in our file
        cCHUNKSAlias = THIS.oCHUNKS.cAlias
        THIS.oCHUNKS.Select()
        INSERT INTO (cCHUNKSAlias) FROM MEMVAR

        * Done
        THIS.oSUMMARY.Select()
    ENDFUNC

    *- SetCXRecs() - Set USES and TOT_SECS for scx/vcx files
    FUNCTION SetCXRecs(cKey, nBegLn, nEndLn, nTotSecs, cLINES)
        LOCAL nClassBeg, nClassEnd, cLookFor, nMethBeg, nMethEnd

        * CODEFILE is SELECTed, and we have M.FILE, M.PROCEDURE, M.CLASS
        * First find the class - it will be the 2nd to last extension
        *   e.g. CLASS = 'appform.txtlogfile.valid'
        cProc = TRIM(M.PROCEDURE)
        cMethod = JUSTEXT(cProc)
        nPosn = AT('.' + cMethod, cProc)
        cProc = LEFT(cProc, nPosn-1)
        cClass = JUSTEXT(cProc)
        IF EMPTY(cClass)
            cClass = cProc
        ENDIF

        * First find the Class's limits
        LOCATE FOR CODETYPE = 'C' AND BREAKPT = 'S' AND ;
          LOWER(LINE) = 'define class ' + cClass
        nClassBeg = RECNO()
        LOCATE FOR CODETYPE = 'C' AND BREAKPT = 'E' WHILE NOT EOF()
        nClassEnd = RECNO()

        * Now, find the method's limits within that class
        GOTO nClassBeg
        cLookFor = '    procedure ' + cMethod
        LOCATE FOR LOWER(LINE) = cLookFor AND BREAKPT = 'S' WHILE RECNO() < nClassEnd
        nMethBeg = RECNO()
        REPLACE TOT_SECS WITH nTotSecs
        LOCATE FOR CODETYPE = 'M' AND BREAKPT = 'E' WHILE RECNO() < nClassEnd
        nMethEnd = RECNO()

        * Now, set a relation and get the USES and TOT_SECS. This is tricky:
        *   LINES line 1 matches CODEFILE nMethBeg + 1
        * So nMethBeg + 1 is our relate
        SET RELATION TO cKey + STR(RECNO() - nMethBeg, 5, 0) INTO (cLINES)
        GOTO nMethBeg + 1
        REPLACE USES WITH &cLINES..USES, ;
          TOT_SECS WITH &cLINES..TOT_SECS ;
          FOR FOUND(cLINES) ;
          WHILE RECNO() < nMethEnd
        SET RELATION TO

        * Set our field M. variables
        M.CHUNKTYPE = 'M'
        M.ACTBEGLN = nMethBeg
        M.ACTENDLN = nMethEnd

        * Done
    ENDFUNC

    *- GetFormattedCode() - Return the formatted code for a procedure
    FUNCTION GetFormattedCode(nBegLn, nEndLn)
        LOCAL cTrimLine, nCutAt, cLine, oText, nMinimum, nRow, nSecs, ;
          cRetCode

        * Our code is between nBegLn and nEndLn in CODEFILE.DBF. It will sort of
        *   look like:
        *            1         2         3
        *   123456789012345678901234567890...
        *   Hits  Time(secs)    Code
        *   9999  9999.9999
        *                      PROCEDURE/FUNCTION <name>
        *                          *- MakeHistFCCharts() - Create the History/Forecast charts for each NSN
        *          171.1915        FUNCTION MakeHistFCCharts(nCnt, oSQAWARDS)
        *      1     0.0001        PRIVATE cNSN
        *      1     0.0010        IF NOT goFiles.<a href="#kosfiles-isadir">
        *                            IsADir</a>(cClientDir)
        *       etc for rest of code
        *                      ENDPROC
        THIS.oCODEFILE.PushState()
        GOTO nBegLn

        * As this is the start of the code, calculate the excess margin to trim
        cTrimLine = LTRIM(LINE)
        nCutAt = AT(cTrimLine, LINE)

        * Put these lines in an array object as:
        *   .aRA[x,1] - Code text
        *   .aRA[x,2] - TOT_SECS
        *   .aRA[x,3] - Line number (within the Code Text
        *   .aRA[x,4] - BREAKPT
        oText = CREATEOBJECT('ArrayObj', 4)

        * Now, go get all of the lines of code inserting uses and times
        nLine = 1
        SCAN WHILE RECNO() <= nEndLn
            DO CASE
            CASE BREAKPT = 'S'
                cLine = SPACE(6) + STR(TOT_SECS, 9, 4) + SPACE(4)
            CASE USES > 0
                IF USES > 0
                    cLine = STR(USES, 4, 0)
                ELSE
                    cLine = SPACE(4)
                ENDIF
                cLine = cLine + '  ' + STR(TOT_SECS, 9, 4) + SPACE(4)
            OTHERWISE
                cLine = SPACE(19)
            ENDCASE
            cLine = cLine + RTRIM( SUBSTR(LINE, nCutAt))

            * Add this to our array
            oText.AddRow(cLine, TOT_SECS, nLine, BREAKPT)
            nLine = nLine + 1

            * Next line
        ENDSCAN

        * Sort this by TOT_SECS descending
        oText.Sort(2, .T.)

        * We want to preface the longest line as:
        *   <span class="redBand">the line of code</span)
        * And the next 2 longest, if they're within 80%, with:
        *   <span class="yellowBand">the line of code</span)
        WITH oText
            nRow = 1                && Ignore the FUNCTION or PROCEDURE line
            IF .aRA[nRow,4] = 'S'
                nRow = nRow + 1
            ENDIF
            IF .aRA[nRow,2] > 0
                .aRA[nRow,1] = [<span class="redBand">] + .aRA[nRow,1] + [</span>]
                nMinimum = .aRA[nRow,2] * 0.20

                * Do up to 2 more
                FOR nX = 1 TO 2
                    nSecs = .aRA[nX + nRow,2]
                    IF nSecs > nMinimum
                        .aRA[nX + nRow,1] = [<span class="yellowBand">] + ;
                          .aRA[nX + nRow,1] + [</span>]
                    ENDIF
                ENDFOR
            ENDIF
        ENDWITH

        * Now, put it back in Line number order
        oText.Sort(3)

        * Get our text
        cRetCode = ''
        WITH oText
            FOR nRow = 1 TO .nRows
                cLine = .aRA[nRow,1]
                cRetCode = cRetCode + cLine + CR_LF
            ENDFOR
        ENDWITH

        * Done
        THIS.oCODEFILE.PopState()
        RETURN cRetCode
    ENDFUNC

    *- GetFilesCode() - Return the code for a file
    FUNCTION GetFilesCode(cFileName)
        LOCAL nSeleIn, cFullNm, cExt, cFullText, cText

        * If we have a project, get the full path to the file
        nSeleIn = SELECT()
        IF THIS.bNeedProj
            cFullNm = THIS.oPROJECT.GetFullName(cFileName)
        ELSE
            cFullNm = cFileName
        ENDIF
        IF NOT FILE(cFullNm)
            ERROR 'Code Filename not found: ' + cFullNm
        ENDIF

        * Read this file's code
        cExt = LOWER( JUSTEXT(cFullNm) )
        IF cExt $ 'scx,vcx'
            SELECT 0
            USE (cFullNm)
            SET FILTER TO NOT (UNIQUEID = 'Class' OR UNIQUEID = 'RESERVED' OR ;
              UNIQUEID = 'Screen' OR EMPTY(METHODS))
            GO TOP

            * We'll surround each class like:
            *   DEFINE CLASS <objname>
            *       method text
            *   ENDDFINE
            cFullText = ''
            SCAN
                cText = THIS.IndentMethods(METHODS, 4)
                cText = 'DEFINE CLASS ' + OBJNAME + CR_LF + ;
                  cText + ;
                  'ENDDEFINE' + CR_LF + CR_LF

                * Add this to the pile
                cFullText = cFullText + cText

                * Next class
            ENDSCAN
        ELSE        && cExt = 'prg' or 'fxp'
            IF cExt = 'fxp'
                cFullNm = FORCEEXT(cFullNm, 'prg')
            ENDIF
            cFullText = FILETOSTR(cFullNm)
        ENDIF

        * Make tabs 4 spaces
        IF TAB $ cFullText
            cFullText = STRTRAN(cFullText, TAB, TAB_SPACES)
        ENDIF

        * Done
        SELECT (nSeleIn)
        RETURN cFullText
    ENDFUNC

    *- GenerateWebPage() - Generate our HTML page of code chunk's uses and times
    FUNCTION GenerateWebPage()
        LOCAL cOutFile, cMsg, cFile, cBody, cText, cType, cOutput, cPgTitle

        * Show advisory
        cOutFile = THIS.cLogFolder + THIS.cOutFile
        cMsg = 'Generating web page: ' + cOutFile + '...'
        THIS.oForm.DisplayMsg(cMsg, .T.)

        * All our stuff is in CHUNKS.DBF
        THIS.oCHUNKS.PushState()
        SET ORDER TO DISPORDER          && DISPORDER (File # + Chunk #)

        * Display all of our chunks
        cBody = ''
        SCAN
            cText = ''
            cFile = TRIM(FILE)

            * What kind of chunk is this? Show our headings accordingly
            cType = ''
            cText = cText + THIS.GetHTMHeading(cFile, @cType)

            * Now, add our code
            cText = cText + [<pre class="color] + cType + [">] + CR_LF + ;
              [<span class="preBold">Hits  Time(secs)   Code</span>] + CR_LF + ;
              CODETEXT + CR_LF + ;
              [</pre><br />] + CR_LF

            * Add this to the pile
            cBody = cBody + cText

            * Next chunk
        ENDSCAN

        * Load our template file
        cOutput = FILETOSTR(THIS.cTemplate)

        * Set our title and process date/time
        cPgTitle = THIS.oForm.oEdit.cLogFile + ' Coverage Analysis'
        cOutput  = STRTRAN(cOutput, '<UI cTitle>', cPgTitle)
        cOutput  = STRTRAN(cOutput, '<UI cDate>', DTOC(DATE()))
        cOutput  = STRTRAN(cOutput, '<UI cTime>', THIS.GetTime())

        * Put the body stuff into the page
        cOutput = STRTRAN(cOutput, '<UI cCodeText>', cBody)

        * Save this to our file name
        STRTOFILE(cOutput, cOutFile)

        * Now, open it
        THIS.ShellExecute(cOutFile)
        cMsg = 'DONE'
        THIS.oForm.DisplayMsg(cMsg)
        THIS.oCHUNKS.PopState()
    ENDFUNC

    *- GetHTMHeading() - Return the heading for the current CHUNKS.DBF record
    FUNCTION GetHTMHeading(cFileNm, cType)
        LOCAL cHdg, cBackLinks, cText, cLink

        * These can be quite different background colors and names. Example:
        *   <p class="hdgChunk colorB">Program: <span class="big">Siteind3.Fxp</span>
        *     <a name="siteind3_Code"></a><br />
        *     Starts at Line: 43</p>
        cType = CHUNKTYPE
        cHdg = [<p class="hdgChunk color] + cType + [">]
        DO CASE

        *   Program: <Name></span><a name="name"></a>
        CASE cType = 'B'        && Bare PRG code
            cHdg = cHdg + [Program: <span class="big">] + ;
              goStr.MakeProper(JUSTFNAME(cFileNm)) + ;
              [</span>] + CR_LF + ;
              [<a name="] + TRIM(LINKNAME) + ["></a>]

        *   Function: <Name>
        *   File: <FileName></span><a name="name"></a>
        CASE cType = 'F'        && Function
            cHdg = cHdg + [Function: <span class="big">] + ;
              goStr.MakeProper(TRIM(PROCEDURE)) + [</span><a name="] + ;
              TRIM(LINKNAME) + ["></a><br />] + CR_LF + ;
              [File: ] + cFileNm

        *   Class/Method: <Name>
        *   File: <FileName></span><a name="name"></a>
        CASE cType = 'M'        && Method
            cHdg = cHdg + [Method: <span class="big">] + TRIM(CAPSPROC) + ;
              [</span><a name="] + TRIM(LINKNAME) + ["></a><br />] ;
              + CR_LF + [File: ] + cFileNm
        ENDCASE

        * Add the starting line number unless this is a vcx/scx file
        *   Starts at Line: nnnnn            - Bare prgs only
        cHdg = cHdg + [<br />] + CR_LF + ;
          [Starts at Line: ] + LTRIM(TRANSFORM(ACTBEGLN, '999,999'))

        * Add the called by backlinks, if any, as:
        *   Called by: <backlinks>
        cBackLinks = ALLTRIM(BACKLINKS)
        cText = ''
        DO WHILE NOT EMPTY(cBackLinks)
            cLink = ALLTRIM(goStr.ExtrToken(@cBackLinks, ','))
            cText = cText + THIS.oCHUNKS.GetAnchorText(cLink)
            IF NOT EMPTY(cBackLinks)
                cText = cText + ', '
            ENDIF
        ENDDO
        IF NOT EMPTY(cText)
            cHdg = cHdg + [<br />] + CR_LF + ;
              [Called by: ] + cText
        ENDIF
        cHdg = cHdg + [<br />] + CR_LF

        * Done
        RETURN cHdg
    ENDFUNC

    *- IndentMethods() - Properly indent method code
    FUNCTION IndentMethods(cMethod, nMarg)
        LOCAL cMainMarg, cIntMarg, oText, nRow, cLine, cRetText

        * All text is to be indented by nMarg spaces. But, code within PROCEDURE,
        *   ENDPROC lines should be indented by an additional nMarg spaces.
        cMainMarg = SPACE(nMarg)
        cIntMarg = SPACE(nMarg * 2)

        * Put the text into a memo array (we don't care about line length)
        oText = CREATEOBJECT('MemoArray', cMethod, 400)

        * Change every line to the full indent
        oText.ChangeLeftMargin(nMarg * 2, .T.)    && .T. = toss last empty line

        * Now, go thru changing only the PROCDURE/ENDPROC lines
        WITH oText
            FOR nRow = 1 TO .nRows
                cLine = .aRA[nRow,1]
                IF cLine = cIntMarg + 'PROCEDURE ' OR cLine = cIntMarg + 'ENDPROC'
                    cLine = cMainMarg + LTRIM(cLine)
                    .aRA[nRow,1] = cLine
                ENDIF
            ENDFOR
        ENDWITH

        * Now, get our new text back
        cRetText = oText.Array2Memo()
        RETURN cRetText + CR_LF
    ENDFUNC

    *- GetTime() - Return a reasonably human readable time
    FUNCTION GetTime()
        LOCAL cTime, nHrs, nMins, cLtr, nDigits, cRetTime

        * Get the hours and minutes
        cTime = LEFT( TIME(), 5)
        nHrs = VAL( cTime )
        nMins = VAL( SUBSTR( cTime, 4) )

        * Adjust the hours and set AM/PM as needed
        cLtr = IIF( nHrs >= 12, 'P', 'A')
        IF nHrs > 12
            nHrs = nHrs - 12
        ENDIF

        * Put this into our return string
        nDigits = IIF( nHrs < 10, 1, 2)
        cRetTime = STR(nHrs, nDigits, 0) + ':' + PADL( INT(nMins), 2, '0')
        RETURN cRetTime
    ENDFUNC

    *- ProjNeeded() - Return .T. if we need the project file
    FUNCTION ProjNeeded(cLogFile)
        LOCAL nHndl, bGotAppOrExe, nX, cLine

        * This is called by our form and:
        * We're to return .T. if we need the project file. We only need it if
        *   the log file was from an app or exe. If it was from a PRG, the log
        *   file will have source code paths like:
        *       0.000256,arrayobj,arrayobj.addrow,316,f:\tooldev\coverage\testprog\libs\karrays.fxp,4

        * Open the log file
        nHndl = goFiles.LL_Open(cLogFile, 'R')

        * Read 10 lines to see if we have an app or exe. If so, we need a project
        *   file
        bGotAppOrExe = .F.
        FOR nX = 1 TO 10
            cLine = goFiles.LL_Read(nHndl, .T.)
            IF '.exe,' $ cLine OR '.app,' $ cLine
                bGotAppOrExe = .T.
                EXIT
            ENDIF
        ENDFOR

        * OK do we need a project or not?
        THIS.bNeedProj = bGotAppOrExe
        THIS.bGotAppOrExe = bGotAppOrExe

        * Close our file
        goFiles.LL_Close(nHndl)
        RETURN THIS.bNeedProj
    ENDFUNC

    *- ShellExecute() - Execute a shell program
    FUNCTION ShellExecute(cAppFile, cDefaDir, cOthrParms )
        LOCAL nFoxHwnd, nHInstance

        * Check our parameters
        cDefaDir = IIF( VARTYPE(cDefaDir) <> 'C', '', cDefaDir)
        cOthrParms = IIF( VARTYPE(cOthrParms) <> 'C', '', cOthrParms)

        * Declare a couple of DLLs
        DECLARE LONG FindWindow IN Win32Api STRING cClass, STRING cTitle
        DECLARE LONG ShellExecute IN SHELL32.dll LONG nWinHandle, ;
          STRING cOperation, STRING cFileName, STRING cParameters, ;
          STRING cDirectory, INTEGER nShowWindow

        * Get our window handle
        nFoxHwnd = FindWindow(0, _SCREEN.Caption)

        * Now, execute the command
        nHInstance = ShellExecute( nFoxHwnd, 'open', cAppFile, cOthrParms, ;
          cDefaDir, 1)

        * Clear our DLLs and we're done
        CLEAR DLLS "FindWindow", "ShellExecute"
        RETURN nHInstance
    ENDFUNC

    *- Destroy() - Clean up after ourselves
    PROCEDURE Destroy()
        IF NOT ISNULL(THIS.oForm)
            THIS.oForm = NULL
        ENDIF
        IF NOT ISNULL(THIS.oPROJECT)
            THIS.oPROJECT.Release()
        ENDIF
        IF NOT ISNULL(THIS.oCHUNKS)
            THIS.oCHUNKS.Release()
        ENDIF
        IF NOT ISNULL(THIS.oCODEFILE)
            THIS.oCODEFILE.Release()
        ENDIF
        IF NOT ISNULL(THIS.oSUMMARY)
            THIS.oSUMMARY.Release()
        ENDIF
        IF NOT ISNULL(THIS.oLINES)
            THIS.oLINES.Release()
        ENDIF
        IF NOT ISNULL(THIS.oCALLS)
            THIS.oCALLS.Release()
        ENDIF
        IF NOT ISNULL(THIS.oLOG)
            THIS.oLOG.Release()
        ENDIF
        DODEFAULT()
    ENDPROC
ENDDEFINE
