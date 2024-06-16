#IF 0                          MainProc.prg

  Purpose:  Main general procedure/function file

Revisions:  January 11, 2010  Ken Green - Original

Called by:  MAIN.PRG

************************** Functions and Procedures *************************

* DoBeep() - Play a beep sound
* GoodObj() - Return .T. if the passed parameter is a non-NULL object
* IsAbstract() - Return .T. if object's class is NOT abstract
* GetValidObject() - Return an empty validation object
* MakeMTObj() - Return an empty object with the passed property names
* BlankVal() - Return the blank value for a field/variable type
* KillBS() - Remove a trailing backslash from a string if it exists
* GetDurationStr() - Return a human readable time string
* Plural() - Return the plural form of the passed noun
* IsPropAnObject() - Return .T. if the passed object has an object property
* IsPropRO() - Return .T. if an object's property is Read-Only* IsTypeOf() - Return .T. if the passed object is of the passed class
* DoBeep() - Play a beep sound
* PauseFr() - Wait for fractional seconds
* RoundOff() - Round off a number to x decimal places.  If x is negative,
* IsArray() - Return .T. if the passed variable name is an array
* IsArrayErr() - PRIVATE - Special error handler for IsArray()
* Obj_Ht() - Return our design height (pixels) based on Font properties, # lines
* Obj_Wid() - Return our design width (pixels) based on Font, object properties
* Font_Ht() - Return the height (pixels) for a particular font
* Font_Wid() - Return the width (pixels) for a particular font
* FontType() - Return the Font Type character(s) for an object's font
* FontMono() - Return .T. if font is Mono-Spaced

************************** Functions and Procedures *************************
#ENDIF

* Includes and defines
#INCLUDE INC\APPINCL.H

* DoBeep() - Play a beep sound
PROCEDURE DoBeep()

    * Try to get our application to do this for us
    IF VARTYPE(goApp) = 'O'
        goApp.DoBeep()
    ELSE
        ?? CHR(7)
    ENDIF
ENDPROC

* GoodObj() - Return .T. if the passed parameter is a non-NULL object
FUNCTION GoodObj(xPossObj)
       RETURN TYPE('xPossObj') = "O" AND NOT ISNULL(xPossObj)
ENDFUNC

* IsAbstract() - Return .T. if object's class is NOT abstract
*   Adapted from Codebook 3.0, (c) Flash Creative Management, Inc., 1995
FUNCTION IsAbstract(pcClass, pcClassName)
    RETURN ( UPPER(pcClass) <> UPPER(pcClassName) )
ENDFUNC

* GetValidObject() - Return an empty validation object
FUNCTION GetValidObject(cLgnd, cType, cValids, xCurrVal, nMaxLen)
    LOCAL oRetObj

    * nMaxLen isn't appropriate for some controls (checkbox)
    IF VARTYPE(nMaxLen) <> 'N' OR nMaxLen < 1
        nMaxLen = 0
    ENDIF

    * Create the empty object
    oRetObj = MakeMTObj('cLegend', 'cType', 'nMaxLen', 'cValidCodes', ;
      'xCurrValue', 'bValueChanged', 'xNewValue', 'bHasError', 'cErrorMsg')

    * Load up what we can
    IF PCOUNT() > 0
        WITH oRetObj
            .cLegend       = cLgnd
            .cType         = cType
            .nMaxLen       = nMaxLen
            .cValidCodes   = cValids
            .xCurrValue    = xCurrVal

            * Validation defaults
            .bValueChanged = .F.
            .xNewValue     = xCurrVal
            .bHasError     = .F.
            .cErrorMsg     = ''
        ENDWITH
    ELSE

        * Put just the validation defaults in
        WITH oRetObj
            .bValueChanged = .F.
            .bHasError     = .F.
        ENDWITH
    ENDIF
    RETURN oRetObj
ENDFUNC

* MakeMTObj() - Return an empty object with the passed property names
FUNCTION MakeMTObj(cName1, cName2, cName3, cName4, cName5, cName6, cName7, cName8, cName9, cName10)
    LOCAL oObject, nX, cName, cType

    * Create an empty object
    oObject = CREATEOBJECT('Empty')

    * Add each property name
    FOR nX = 1 TO PCOUNT()
        cName = EVALUATE( 'cName' + TRANSFORM(nX) )
        cType = UPPER( LEFT(cName,1) )
        ADDPROPERTY(oObject, cName, BlankVal(cType))
    ENDFOR
    RETURN oObject
ENDFUNC

* BlankVal() - Return the blank value for a field/variable type
FUNCTION BlankVal(cFldType)
    DO CASE

    * Character, Memo or General
    CASE cFldType $ 'CMG'
        RETURN ''

    * Numeric, Double, Float, Integer (all 'N') or Currency ('Y')
    CASE cFldType $ 'NYI'
        RETURN 0

    * Logical
    CASE cFldType $ 'LB'
        RETURN .F.

    * Object
    CASE cFldType = 'O'
        RETURN .NULL.

    * Date
    CASE cFldType = 'D'
        RETURN {}

    * DateTime
    CASE cFldType = 'T'
        * DTOT( {} ) also works
        RETURN {  /  /    :  :  AM}
    ENDCASE
    RETURN ''
ENDFUNC

* KillBS() - Remove a trailing backslash from a string if it exists
FUNCTION KillBS(cStrIn)
    IF RIGHT(cStrIn,1) = '\'
        RETURN LEFT(cStrIn, LEN(cStrIn)-1)
    ENDIF
    RETURN cStrIn
ENDPROC

* GetDurationStr() - Return a human readable time string
FUNCTION GetDurationStr(nNumSecs)
    LOCAL cTimeStr, nDays, nHrs, nMins, nSecs

    * Convert the seconds to days, hours, minutes and seconds
    IF nNumSecs < 120
        cTimeStr = LTRIM(STR( nNumSecs )) + ' ' + Plural('sec', nNumSecs) + ;
          '.' + CR_LF
    ELSE
        STORE 0 TO nDays, nHrs, nMins
        nSecs = nNumSecs
        nHrs = INT(nSecs/3600)
        nSecs = nSecs - (nHrs * 3600)
        IF nHrs > 47
            nDays = INT(nHrs / 24)
            nHrs = nHrs = (nDays * 24)
        ENDIF
        nMins = INT(nSecs/60)
        nSecs = nSecs - (nMins * 60)
        cTimeStr = ''
        IF nDays > 0
            cTimeStr = LTRIM(STR( nDays )) + ' ' + Plural('day', nDays)
        ENDIF
        IF nHrs > 0 OR NOT EMPTY(cTimeStr)
            cTimeStr = IIF(EMPTY(cTimeStr), '', cTimeStr + ', ') + ;
              LTRIM(STR( nHrs )) + ' ' +  Plural('hr', nHrs)
        ENDIF
        IF nMins > 0 OR NOT EMPTY(cTimeStr)
            cTimeStr = IIF(EMPTY(cTimeStr), '', cTimeStr + ', ') + ;
              LTRIM(STR( nMins )) + ' ' + Plural('min', nMins)
        ENDIF
        cTimeStr = IIF(EMPTY(cTimeStr), '', cTimeStr + ' and ') + ;
          LTRIM(STR( nSecs )) + ' ' + Plural('sec', nSecs) + '.' + CR_LF
    ENDIF
    RETURN cTimeStr
ENDFUNC

* Plural() - Return the plural form of the passed noun
*     Input: cNoun - The singular noun to "pluralize"
*            nNumber - The number in question
*            cPluralExt - (optional) The string to add to the noun if the
*                    number is a plural (default = 's')
*      Retn: If nNumber = 1: only the cNoun is returned
*            Else: the cNoun + cPluralExt are returned
*      Note: Was PLURAL
FUNCTION Plural( cNoun, nNumber, cPluralExt )

    * Make sure nNumber is a number
    IF VARTYPE(nNumber) <> 'N'
        nNumber = VAL(nNumber)
    ENDIF

    * Handle the only non-plural first
    IF INT(nNumber) = 1
        RETURN cNoun
    ENDIF
    IF EMPTY(cPluralExt) OR VARTYPE(cPluralExt) <> 'C'
        cPluralExt = 's'
    ENDIF
    RETURN cNoun + cPluralExt
ENDFUNC

* IsPropAnObject() - Return .T. if the passed object has an object property
FUNCTION IsPropAnObject(oObj2Test, cProp2Test)
    LOCAL xPropVal

    * First, the object must have th property in question
    IF PEMSTATUS(oObj2Test, cProp2Test, 5)

        * Then, it's type must be [O] and it can't be NULL
        xPropVal = EVALUATE([oObj2Test.] + cProp2Test)
        IF VARTYPE(xPropVal) = 'O' AND NOT ISNULL(oObj2Test)
            RETURN .T.
        ENDIF
    ENDIF

    * No such property or it isn't an object
    RETURN .F.
ENDFUNC

* IsPropRO() - Return .T. if an object's property is Read-Only
FUNCTION IsPropRO(cProperty, oObject)
    LOCAL nPeriod, cObject

    * Inputs: cProperty - property in <object.property> or (property name> form
    *         oObject - only used if cProperty in (property name> form

    * If we got parameters of the 2nd type, convert them into parameters of
    *   the first type
    nPeriod = AT([.], cProperty)
    IF nPeriod > 0
        cObject = LEFT(cProperty, nPeriod-1)
        oObject = EVAL(cObject)
        cProperty = SUBSTR(cProperty, nPeriod+1)
    ENDIF

    * Return the property's Read-Only status
    RETURN SYS(1269, oObject, cProperty, 1)       && 1 = R/O status
ENDFUNC

* IsTypeOf() - Return .T. if the passed object is of the passed class
FUNCTION IsTypeOf(oObject, cType)
    LOCAL ARRAY aClasses[1]
    LOCAL nFound

    * Check our parameters
    ASSERT VARTYPE(oObject) = 'O'
    ASSERT VARTYPE(cType) = 'C'

    * Get an array of the object's classes into aClasses[]
    ACLASS(aClasses, oObject)

    * Now, look for the class in the array: the -1s mean use the default value
    *   for nStartElement, nElementsSearched and nSearchColumn, the 15 means:
    *   Case Insensitive; Return row number; Exact ON
    nFound = ASCAN(aClasses, cType, -1, -1, -1, 15)
    RETURN (nFound > 0)
ENDFUNC

* DoBeep() - Play a beep sound
PROCEDURE DoBeep()

    * Try to get our application to do this for us
    IF VARTYPE(goApp) = 'O'
        goApp.DoBeep()
    ELSE
        ?? CHR(7)
    ENDIF
ENDPROC

* PauseFr() - Wait for fractional seconds
PROCEDURE PauseFr( nSecs, bSetAbort )
    LOCAL nEndSecs, nSecs2Do, nKey

    * Define our ending time
    nEndSecs = SECONDS() + nSecs

    * We'll use INKEY() for the wait but the user might press a key
    DO WHILE nEndSecs > SECONDS()
        IF MDOWN() OR CHRSAW()
            DOEVENTS
        ENDIF
        nSecs2Do = nEndSecs - SECONDS()
        nKey = INKEY( ABS(nSecs2Do) )

        * Handle special keys: Esc and Alt-K
        IF nKey = K_ESC OR nKey = ALT_K
            DO CASE

            * If the user hit Esc, return quickly...
            CASE nKey = K_ESC
                IF bSetAbort        && ...but set gbAborted if we're supposed to
                    gbAborted = .T.
                ENDIF
                EXIT

            * If this is the frantic programmer trying to figure out what's
            *   going on, pull up the debugger
            CASE nKey = ALT_K
                SET STEP ON
            ENDCASE
        ENDIF
    ENDDO

    * Done
    RETURN
ENDPROC

* RoundOff() - Round off a number to x decimal places.  If x is negative,
*   round to whole numbers (i.e. round -2 set hundreds to 0's).  Correctly
*   handles negative numbers and halves (if previous digit is even, rounds up,
*   else truncates).
FUNCTION RoundOff( nNumVar, nDecPlcs )
    nPower = 10 ^ nDecPlcs
    nNumb = nNumVar * nPower

    * Delta is what we add to nNumb before taking the integer.  However, the
    *   special case of exactly half must be dealt with (round up if the next
    *   highest integer is even; round down if odd).  Then we have to make
    *   delta negative if we're dealing with a negative number.
    nDelta = IIF( MOD(nNumb,1) = 0.500000 .AND. MOD(INT(nNumb),2)=1, 0, 0.5 ) ;
      * IIF( nNumVar < 0, -1, 1 )

    * Add the delta based on whether this is a negative number or not, take the
    *   integer, divide by the power, and return.
    RETURN INT(nNumb + nDelta) / nPower
ENDFUNC

* IsArray - Return .T. if the passed variable name is an array
FUNCTION IsArray( cVarName)
    PRIVATE bRAError
    LOCAL nRows

    * We've found no reliable test except to trap any ALEN() errors.
    *   TYPE() returns true for oObj.Baseclass[1] and oObj.Baseclass[1,1]
    * So, we'll have to trap for not an array errors (#232)
    bRAError = .F.
    ON ERROR DO IsArrayErr WITH LINENO()

    * Get the number of rows in the "array"
    nRows = ALEN( &cVarName )

    * Reset the error handler and return
    ON ERROR
    RETURN (NOT bRAError)
ENDFUNC

* IsArrayErr() - PRIVATE - Special error handler for IsArray()
PROCEDURE IsArrayErr
    PARAMETERS nLineNumb
    X_ERRNUM = ERROR()

    * Error  232 - <name> is not an array
    IF X_ERRNUM = 232
        bRAError = .T.
        ON ERROR
    ENDIF
    RETURN
ENDPROC

* Obj_Ht() - Return our design height (pixels) based on Font properties, # lines
FUNCTION Obj_Ht(pxObjProp, nNumLines, nFontSize, cFontStyle, nMargin, cBaseClass)
    LOCAL cFontName, cStyle, nMarg, nPadding, nWinHt

    * Inputs are EITHER:
    *   pxObjProp  - An object with FontName, FontSize, FontBold, Margin, and
    *                  BaseClass properties
    *   nNumLines  - Number of lines in the object (default = 1 if not passed)
    * OR:
    *   pxObjProp  - FontName
    *   nNumLines  - Number of lines in the object (default = 1 if not passed)
    *   nFontSize  - Font Size (default = 9)
    *   cFontStyle - Font Style letter(s) - "BI" = Bold, Italic (default = "N")
    *   nMargin    - Desired Margin (default = 0)
    *   cBaseClass - Base class for sizing (default = 'TextBox')

    * Assume 1 line if it isn't passed
    IF TYPE('nNumLines') <> 'N' OR nNumLines < 1
        nNumLines = 1
    ENDIF

    * Define our other parameters
    nMarg = 0
    IF TYPE('pxObjProp') = 'O'
        cFontName = pxObjProp.FontName
        nFontSize = pxObjProp.FontSize

        * Define the style characters for this font
        cStyle = FONTTYPE(pxObjProp)
        cBaseClass = UPPER( pxObjProp.BaseClass )

        * We want to take into account an object's margin if it has one
        IF TYPE('pxObjProp.Margin') = 'N' AND pxObjProp.Margin >= 0
            nMarg = pxObjProp.Margin
        ENDIF
    ELSE    && TYPE('pxObjProp') = 'C'
        cFontName = pxObjProp
        IF TYPE('nFontSize') <> 'N' OR nFontSize < 6
            nFontSize = 9
        ENDIF
        IF TYPE('cFontStyle') <> 'C' OR EMPTY(cFontStyle)
            cStyle = 'N'
        ELSE
        	cStyle = cFontStyle
        ENDIF

        * Make sure cBaseClass is uppercase
        IF TYPE('cBaseClass') <> 'C' OR EMPTY(cBaseClass)
            cBaseClass = 'TEXTBOX'
        ELSE
            cBaseClass = UPPER(cBaseClass)
        ENDIF

        * We want to take into account a margin if we got one
        IF TYPE('nMargin') = 'N' AND nMargin >= 0
            nMarg = nMargin
        ENDIF
    ENDIF

    * If this is a ListBox, it has no Margin property but, VFP adds 6 pixels
    *   to the height
    IF cBaseClass = 'LISTBOX'
        nMarg = 3
    ENDIF

    * Is this a mono-spaced font?  They're only used for entry fields so are
    *   calculated differently than propertional fonts.
    IF FONTMONO( cFontName )

        * Here we have a 4 pixel padding used for the surrounding box's lines
        IF cBaseClass = 'INLIST'        && In a ListBox
            nPadding = 2                && so, no lines to worry about
        ELSE
            nPadding = 4
        ENDIF

        * Now, calculate the height
        nWinHt = (FONTMETRIC(1, cFontName, nFontSize, cStyle) * nNumLines) + ;
          nPadding + (2 * nMarg)

        * If this is only a 1 line field (most are), and it's an odd number
        *   height, round up to make it and even number (that will make
        *   Spinner's arrows even heights).
        IF nNumLines = 1 AND MOD(nWinHt, 2) = 1
            nWinHt = nWinHt + 1
        ENDIF
    ELSE        && Propertional fonts

        * Proportional fonts are usually used for legends and display text -
        *   not entry fields, so this calculation is different than monospaced
        *   fields.  This takes into account a 2 pixel "padding" we discovered
        *   for propertional fonts.
        * EXCEPTION: CheckBoxes have an integral legend, so they also use
        *   propertional fonts.  But their height is exactly the same as a
        *   normal legend height, so these calculations are OK.  (If we were
        *   to make them the same height as fields, nothing would change
        *   except the surrounding background - so there's no point.)
        nPadding = 2

        * Now, calculate the height
        nWinHt = (FONTMETRIC(1, cFontName, nFontSize, cStyle) * nNumLines) + ;
          nPadding
    ENDIF
    RETURN nWinHt
ENDFUNC

* Obj_Wid() - Return our design width (pixels) based on Font, object properties
FUNCTION Obj_Wid(pxObjProp, pxStrProp, nFontSize, cFontStyle, nMargin, cBaseClass)
    LOCAL cStyle, nAvgChar, nCharLen, cStr, nPadding, nMarg, nWidgetWidth, ;
      nWinWidth, nCharWid

    * pxStrProp can be:
    *   Numeric - the string length
    *   Character - the actual string (best for proportional fonts)
    *   nothing - the object's properties are used as follows:
    *       If the object has a MaxLength property, that is used
    *       Else, the length of the InputMask property is used.

    * Other inputs are EITHER:
    *   pxObjProp  - An object with FontName, FontSize, FontBold, Margin, and
    *                  BaseClass properties
    * OR:
    *   pxObjProp  - FontName
    *   nFontSize  - Font Size (default = 9)
    *   cFontStyle - Font Style letter(s) - "BI" = Bold, Italic (default = "N")
    *   nMargin    - Desired Margin (default = 0)
    *   cBaseClass - Base class for sizing (default = 'TextBox')

    * Define our parameters except for pxStrProp
    nMarg = 0
    IF TYPE('pxObjProp') = 'O'
        cFontName = pxObjProp.FontName
        nFontSize = pxObjProp.FontSize

        * Define the style characters for this font
        cStyle = FONTTYPE(pxObjProp)
        cBaseClass = UPPER( pxObjProp.BaseClass )

        * We want to take into account an object's margin if it has one
        IF TYPE('pxObjProp.Margin') = 'N' AND pxObjProp.Margin >= 0
            nMarg = pxObjProp.Margin
        ENDIF
    ELSE    && TYPE('pxObjProp') = 'C'
        cFontName = pxObjProp
        IF TYPE('nFontSize') <> 'N' OR nFontSize < 6
            nFontSize = 9
        ENDIF
        IF TYPE('cFontStyle') <> 'C' OR EMPTY(cFontStyle)
            cStyle = 'N'
        ELSE
        	cStyle = cFontStyle
        ENDIF

        * Make sure cBaseClass is uppercase
        IF TYPE('cBaseClass') <> 'C' OR EMPTY(cBaseClass)
            cBaseClass = 'TEXTBOX'
        ELSE
            cBaseClass = UPPER(cBaseClass)
        ENDIF

        * We want to take into account a margin if we got one
        IF TYPE('nMargin') = 'N' AND nMargin >= 0
            nMarg = nMargin
        ENDIF
    ENDIF

    * Get the average character width for this font
    nAvgChar = FONTMETRIC(6, cFontName, nFontSize, cStyle)

    * Is this a mono-spaced font?  They're only used for entry fields so are
    *   calculated differently than propertional fonts.
    IF FONTMONO( cFontName )

        * Convert pxStrProp (or whatever) into the number of characters
        DO CASE
        CASE TYPE('pxStrProp') = 'C'
            nCharLen = LEN(pxStrProp)
        CASE TYPE('pxStrProp') = 'N'
            nCharLen = pxStrProp
        CASE TYPE('pxObjProp.MaxLength') = 'N'
            nCharLen = pxObjProp.MaxLength
        OTHERWISE
            nCharLen = LEN(pxObjProp.InputMask)
        ENDCASE

        * Here we have a 7 pixel padding used for the surrounding box's lines
        *   plus some extra space VFP wants
        nPadding = 7
        IF cBaseClass = 'INLIST'        && In a ListBox

            * For fields in a list box, the line padding isn't needed.  But,
            *   we empirically found that we want to add 5p so that there's a
            *   little gap between columns.
            nPadding = 5
        ENDIF

        * The field object may have a widget (Spinner arrows, scroll bars)
        IF UPPER(cBaseClass) = 'LISTBOX' OR ;
          UPPER(cBaseClass) = 'EDITBOX' OR ;
          UPPER(cBaseClass) = 'SPINNER'
            nWidgetWidth = 17
        ELSE
            nWidgetWidth = 0
        ENDIF

        * Calculate the width of the field
        nWinWidth = (nAvgChar * nCharLen) + nPadding + (2 * nMarg) + ;
          nWidgetWidth

    * Propertional fonts
    ELSE

        * Here we have a 4 pixel padding used for the surrounding box's lines
        nPadding = 4

        * EXCEPTION: CheckBoxes have an integral legend, so they also use
        *   propertional fonts.  But their width is exactly the same as a
        *   normal legend width (with an added space), PLUS 13 pixels for the
        *   box.
        IF cBaseClass = 'CHECKBOX'
            nPadding = nPadding + 13
            IF TYPE('pxStrProp') = 'C' AND RIGHT(pxStrProp,1) <> ' ' AND ;
              NOT EMPTY(pxStrProp)
                pxStrProp = pxStrProp + ' '
            ENDIF
        ENDIF

        * Convert pxStrProp (or whatever) into a string
        DO CASE
        CASE TYPE('pxStrProp') = 'C'
            cStr = pxStrProp
        CASE TYPE('pxStrProp') = 'N'
            cStr = REPLICATE( 'a', pxStrProp)
        CASE TYPE('pxObjProp.MaxLength') = 'N'
            cStr = REPLICATE( 'a', pxObjProp.MaxLength)
        OTHERWISE
            cStr = pxObjProp.InputMask
        ENDCASE

        * Calculate the width of the text
        nCharWid = TXTWIDTH(cStr, cFontName, nFontSize, cStyle)
        nWinWidth = (nCharWid * nAvgChar) + nPadding
    ENDIF
    RETURN nWinWidth
ENDFUNC

* Font_Ht() - Return the height (pixels) for a particular font
FUNCTION Font_Ht(poFontObject, pcType)
    LOCAL cStyle, nWinHt, nVGap

    * Heights can have 4 components:
    *   Char - Normal character height
    *   VGap - Gap between lines
    *   Extra - Extra pixels we add on for good design appearance
    *   Margin - Added if the object has a non-zero Margin property

    * Now, we always add the Margin if it exists.  So, the passed Type can be:
    *   'N' - Normal design style (Char + VGap + Extra)
    *   'C' - Only the Char height
    *   'L' - Line height (Char + Vgap only)
    *   'V' - Only the VGap

    * The default Type is 'N'
    IF TYPE('pcType') <> 'C' OR NOT pcType $ 'NCLV'
        pcType = 'N'
    ENDIF

    * Define the style characters for this font
    cStyle = FONTTYPE(poFontObject)

    * Get FONTMETRIC's idea of the character height, if appropriate
    *  FONTMETRIC(1) - Character height in pixels
    nWinHt = 0
    IF pcType $ 'NCL'
        nWinHt = FONTMETRIC( 1, poFontObject.FontName, poFontObject.FontSize, ;
          cStyle)
    ENDIF

    * Add the gap between lines if appropriate
    *  FONTMETRIC(4) - Leading (space between lines) in pixels
    IF pcType $ 'NVL'
        nVGap = FONTMETRIC( 4, poFontObject.FontName, poFontObject.FontSize, ;
          cStyle)

        * Some gaps are 0, make it at least 1
        nWinHt = nWinHt + MAX( 1, nVGap )
    ENDIF

    * Add our design padding if appropriate
    IF pcType = 'N'
        nWinHt = nWinHt + 2
    ENDIF

    * If this object has a Margin, the height must also include 2 * that
    IF TYPE('poFontObject.Margin') = 'N' .AND. poFontObject.Margin > 0
        nWinHt = nWinHt + (2 * poFontObject.Margin)
    ENDIF
    RETURN nWinHt
ENDFUNC

* Font_Wid() - Return the width (pixels) for a particular font
FUNCTION Font_Wid(poFontObject, pxStrProp, pcType)
    LOCAL cStyle, nCharWid, cStr, nWinWidth, nStrLen

    * The passed Type can be:
    *   'N' - Normal design style (Avg + Extra)
    *   'A' - Only the Average Char width
    *   'M' - Only the Maximum Char width
    * pxStrProp can be:
    *   Numeric - the string length
    *   Character - the actual string (best for proportional fonts)

    * The default Type is 'N'
    IF TYPE('pcType') <> 'C' OR NOT pcType $ 'NAM'
        pcType = 'N'
    ENDIF

    * Define the style characters for this font
    cStyle = FONTTYPE(poFontObject)

    * Get FONTMETRIC's idea of the Maximum or Average character widths
    IF pcType = 'M'

        *  FONTMETRIC(7) - Maximum character width in pixels
        nCharWid = FONTMETRIC( 7, poFontObject.FontName, ;
          poFontObject.FontSize, cStyle)
    ELSE    && pcType = 'A' or 'N'

        *  FONTMETRIC(6) - Average character width in pixels
        nCharWid = FONTMETRIC( 6, poFontObject.FontName, ;
          poFontObject.FontSize, cStyle)
    ENDIF

    * nCharWid has the single character width.  Get the full string length.
    IF pcType = 'N'
        IF TYPE('pxStrProp') = 'C'
            cStr = pxStrProp
        ELSE            && TYPE('pxStrProp') = 'N'
            cStr = REPLICATE( 'a', pxStrProp + 2)   && Allow for 2 extra chars
        ENDIF
        nWinWidth = nCharWid * TXTWIDTH(cStr, poFontObject.FontName, ;
          poFontObject.FontSize, cStyle)
    ELSE
        IF TYPE('pxStrProp') = 'C'
            nStrLen = LEN(pxStrProp)
        ELSE            && TYPE('pxStrProp') = 'N'
            nStrLen = pxStrProp
        ENDIF
        nWinWidth = nCharWid * nStrLen
    ENDIF
    RETURN nWinWidth
ENDFUNC

* FontType() - Return the Font Type character(s) for an object's font
FUNCTION FontType(poFontObj)
    LOCAL nStyleStr

    * The first character is "N"ormal or "B"old
    nStyleStr = 'N'
    IF TYPE('poFontObj.FontBold') = 'L' AND poFontObj.FontBold
        nStyleStr = 'B'
    ENDIF

    * All other properties just add letters:
    *       Property        Letter        Notes
    *       컴컴컴컴        컴컴컴      컴컴컴컴컴컴컴컴컴컴컴컴컴
    *       FontItalic         I
    *       FontOutline        O        Macintosh only - don't use
    *       FontShadow         S        Macintosh only - don't use
    *       FontStrikeThru     -
    *       FontUnderline      U
    *       Opaque             Q        Not applicable - ignore
    *       Transparent        T        Not applicable - ignore
    IF TYPE('poFontObj.FontItalic') = 'L' AND poFontObj.FontItalic
        nStyleStr = nStyleStr + 'I'
    ENDIF
    IF TYPE('poFontObj.FontStrikeThru') = 'L' AND poFontObj.FontStrikeThru
        nStyleStr = nStyleStr + '-'
    ENDIF
    IF TYPE('poFontObj.FontUnderline') = 'L' AND poFontObj.FontUnderline
        nStyleStr = nStyleStr + 'U'
    ENDIF
    RETURN nStyleStr
ENDFUNC

* FontMono() - Return .T. if font is Mono-Spaced
FUNCTION FontMono(pcFName)
    LOCAL bRetValue

    * We don't know how to do this yet, so assume "Courier New" is monospaced
    *   but all others aren't.
    bRetValue = ('COURIER' $ UPPER(pcFName) )
    RETURN bRetValue
ENDFUNC
