#IF 0                           zArrays.prg

  Purpose:  Special Array handling objects

Revisions:  March 2, 2010 - Ken Green - Adapted from original KArrays.prg
                        started in 8/20/1998 with a last rev date of 5/29/14,
                        removed FldsArray and IndexArray classes as we now use
                        collections

************************** Functions and Procedures *************************

* Split() - Split a string into a 1-dimensional array

***************************** Class Definitions *****************************

* ArrayObj Class Definition - General Array Object
*   CallingPgms Class (parent ArrayObj) - Handles program hierarchy list
*   ParamObj Class (parent ArrayObj) - Handles multiple parameters
*   DirArray Class (parent ArrayObj) - loads array with files matching spec
*   FileLines Class (parent ArrayObj) - loads array with all lines in a file
*   StringArray Class (parent ArrayObj) - Array Object to/from string list
*   MemoArray Class (parent ArrayObj) - Array Object to/from memo
*   NamedArrayCol Class (parent ArrayObj) - Array Object with column name access
*   NamedArrayCell Class (parent ArrayObj) - Array Object with cell name access
*   Collectn Class (parent ArrayObj) - Object Collection class

****************************  Class PEM Summary *****************************

Properties:
    aRA        - The actual array
    nRows      - Number of rows in the array
    nCols      - Number of columns in the array
    nNearRow   - Next larger row in a failed Seek

Methods:
    Init() - Initialize an array object
      Parameters: nCols (REQUIRED for multi-dimensional arrays)
        Note - nRows will be 0 after Init()

    IsEmpty() - Returns .T. if the array has no rows

    AddRow() - Add a row to the array and load up to 20 columns in that row
        Parameters: xVal1 [,xVal2] [,xVal3] [...to xVal20]
        Returns: the new row number
        Note - xValX values are ignored if they exceed the number of columns

    ReplaceRow() - Change up to 20 columns in an array row
        Parameters: nRowNum, xVal1 [,xVal2] [,xVal3] [...to xVal20]
        Note - xValX values are ignored if they exceed the number of columns

    InsertRow() - Add a row to the array (re-size it larger)
        Parameters: [nBeforeRow]
        Returns: The new number of rows in the array
        Notes:
            1. If nBeforeRow is passed, the new row is inserted into the array
                just before that row.  If not passed, the new row is added to
                the end of the array.
            2. All columns in the new row are initialized to ''

    AddBlankRows() - Add many rows to the array by reDIMENSIONing
        Parameters: nRowsWanted
        Returns: the new row count

    DeleteRow() - Remove a row to the array (re-size it smaller)
        Parameters: nRowNum
        Returns: The new number of rows in the array

    DeleteRemainingRows() - Remove rows from the bottom of the array
        Parameters: nRowCount
        Returns: The new number of rows in the array

    InsertCols() - Add columns to the array (re-size it larger)
        Parameters: nNumNewCols
        Returns: The new number of columns in the array
        Note: All elements in the new columns are initialized to ''

    DeleteCol() - Delete a column from the array (re-size it smaller)
        Parameters: nCol2Remove
        Returns: The new number of columns in the array

    Sort() - Sort the array
      Parameters: [nSortCol,] [bDescending,]  [, bCaseInSensitive]]
      Notes: 1. nSortCol is REQUIRED for multi-dimensional arrays or column
                  1 will be used for the sort
             2. All elements in the sort must be of the same data type.
             3. If a bCaseInSensitive sort is desired, the first 2
                  parameters MUST be passed

    MultiColSort() - Sort the array by multiple columns
      Parameters: nCol1, nCol2 [, nCol3] [, nCol4] [, nCol5,] [bDescending,]
                    [, bCaseInSensitive]]
      Returns: sorted array
      Notes: 1. At least 2 columns ARE REQUIRED for this sort (otherwise, use
                  the Sort() method instead)
             2. All elements in the sort must be of the same data type.
             3. If a bCaseInSensitive sort is desired, the first 5
                  parameters MUST be passed

    Seek() - Look through an ordered array for a passed value
        Parameters: xLookFor[, nSrchCol]
        Returns: Row found matching xLookFor (0 if not found)
                 Object.nNearRow is set if xLookFor is not found and array
                    contains a row with a larger value
        Notes: 1. nSrchCol is REQUIRED for multi-dimensional arrays or column
                    1 will be used for the Seek
               2. xLookFor's data type must match nSrchCol's
               3. Assumes a sorted array (results can be spurious if not)
               4. nNearRow property is set if not found

    Locate() - Case-Insensitive look thru a non-ordered array for a value
       Parameters: xLookFor[, nSrchCol[, bExactOn]]
       Returns: Row found matching xLookFor (0 if not found)
       Notes: 1. nSrchCol is REQUIRED for multi-dimensional arrays or column
                   1 will be used for the Locate
              2. xLookFor's data type must match nSrchCol's
              3. bExactOn - (optional) If .T., EXACT comparison will be done

    PrintToFile() - Outputs our array's contents to a text file
        Parameters: cFileName

    Print() - Uses ? output to list the array contents (max. 20 char elements)
        Parameters: [nLeftMargin] - number of spaces for left margin (default = 0)
        Returns: Nothing, output printed with ? command

    ZapArray() - Removes all data and rows in an array (columns are unchanged)

    Destroy() - Destory this object

    Release() - Release this object

*****************************************************************************
#ENDIF

#DEFINE     TAB     CHR(9)
#DEFINE     CR      CHR(13)
#DEFINE     LF      CHR(10)
#DEFINE     CR_LF   CR + LF
#DEFINE     HEX_FF  CHR(255)

************************** Functions and Procedures *************************

* Split() - Split a string into a 1-dimensional array
FUNCTION Split(cStr, cDelim)
    LOCAL cChar, oArray

    * Inputs:
    *   cStr - The string to split
    *   cDelim - The character delimiter for the split (default = ',')
    * Output: A 1 dimensional StringArray array object with each element of the
    *           string after the cDelim character has been removed.
    *   Note: See StringArray.Join() for getting the string back
    cChar = ','
    IF PCOUNT > 1 AND VARTYPE(cDelim) = 'C' AND LEN(cDelim) = 1
        cChar = cDelim
    ENDIF
    oArray = CREATEOBJECT('StringArray', cStr, cChar)
    RETURN oArray
ENDFUNC


***************************** Class Definitions *****************************

* ArrayObj Class Definition - General Array Object
DEFINE CLASS ArrayObj AS Custom

    * Standard Properties
    Name = 'ArrayObj'

    * Custom Properties
    PROTECTED bMultiCol, nSortedCol
    DIMENSION aRA[1]
    nRows = 0               && Rows in the array
    nCols = 1               && Columns in the array
    bMultiCol = .F.         && Single-column array; .T. = multi-column
    nSortedCol = 0          && Unsorted, if > 0, the sort column number
    nNearRow = 0            && Next larger row in unfound Seek

    * Block the base class properties we'll never need
    PROTECTED Application, ClassLibrary, Comment, Height, HelpContextID, Left, ;
      Object, Picture, Top, WhatsThisHelpID, Width

    * Block the base class methods we'll never need
    PROTECTED ReadExpression, ReadMethod, ResetToDefault, SaveAsClass, ;
      ShowWhatsThis, WriteExpression, WriteMethod

    * Custom Method List
    *- Init() - Initialize an array object
    *- IsEmpty() - Returns .T. if the array has no rows
    *- AddRow() - Add a row to the array and load up to 20 columns in that row
    *- ReplaceRow() - Change up to 20 columns in an array row
    *- InsertRow() - Add a row to the array (re-size it larger)
    *- DeleteRow() - Remove a row to the array (re-size it smaller)
    *- DeleteRemainingRows() - Remove rows from the bottom of the array
    *- InsertCols() - Add columns to the array (re-size it larger)
    *- DeleteCol() - Delete a column from the array (re-size it smaller)
    *- Sort() - Sort the array
    *- MultiColSort() - Sort the array by multiple columns
    *- Seek() - Look through an ordered array for a passed value
    *- Locate() - Case-Insensitive look thru a non-ordered array for a value
    *- PROT MoveColTo1() - Move the passed column to col 1
    *- PROT ClnElem() - Return a "clean" element's contents for printing
    *- PrintToFile() - Outputs our array's contents to a text file
    *- Print() - Uses ? output to list the array contents (max. 20 char elements)
    *- PROT SetPrtWid() - Set our Print() column width
    *- ZapArray() - Removes all data and rows in an array (columns are unchanged)
    *- PROT XToChar() - Convert any value into a string
    *- PROT MakeLen() - Make a string to the length specified (space filled if needed)
    *- PROT FldsInExpr() - Returns a list of field names within an index expression
    *- PROT ExtrToken() - Extract and return the text before a passed token (char)
    *- PROT AtNotInParen() - Return the pos'n of a char NOT within parentheses
    *- PROT AtNotInDelim() - Return the pos'n of a char NOT within delimeters
    *- Error() - Handle/pass up any errors
    *- Destroy() - Kill our contents
    *- Release() - Remove this object from memory

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
        IF THIS.nCols = 1
            THIS.bMultiCol = .F.
        ELSE
            DIMENSION THIS.aRA[ 1, THIS.nCols ]
            THIS.bMultiCol = .T.
        ENDIF
        STORE '' TO THIS.aRA
        THIS.nRows = 0
        THIS.nSortedCol = 0
        NODEFAULT
        RETURN .T.
    ENDFUNC

    *- IsEmpty() - Returns .T. if the array has no rows
    FUNCTION IsEmpty()
        RETURN (THIS.nRows = 0)
    ENDFUNC

    *- AddRow() - Add a row to the array and load up to 20 columns in that row
    *     Parameters: xVal1 [,xVal2] [,xVal3] [...to xVal20]
    *     Returns: the new row number
    *     Note - xValX values are ignored if they exceed the number of columns
    FUNCTION AddRow (xVal1, xVal2, xVal3, xVal4, xVal5, xVal6, xVal7, xVal8, ;
      xVal9, xVal10, xVal11, xVal12, xVal13, xVal14, xVal15, xVal16, xVal17, ;
      xVal18, xVal19, xVal20 )
        LOCAL nNewRowNum, nX, cVarName, xValue

        * Add a new row
        nNewRowNum = THIS.InsertRow()

        * We must always have the first value
        IF THIS.bMultiCol
            THIS.aRA[nNewRowNum, 1] = xVal1
        ELSE
            THIS.aRA[nNewRowNum] = xVal1
        ENDIF

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

    *- ReplaceRow() - Change up to 20 columns in an array row
    *   Parameters: nRowNum, xVal1 [,xVal2] [,xVal3] [...to xVal20]
    *   Note - xValX values are ignored if they exceed the number of columns
    PROCEDURE ReplaceRow (nRowNum, xVal1, xVal2, xVal3, xVal4, xVal5, xVal6, ;
      xVal7, xVal8, xVal9, xVal10, xVal11, xVal12, xVal13, xVal14, xVal15, ;
      xVal16, xVal17, xVal18, xVal19, xVal20 )
        LOCAL nValCount, nX, cParamVar, xThisVal

        * How many values did we receive?  Or, rather, will we use?
        nValCount = MIN( PCOUNT() - 1, THIS.nCols )

        * We must always have the first value
        IF THIS.bMultiCol
            THIS.aRA[nRowNum, 1] = xVal1
        ELSE
            THIS.aRA[nRowNum] = xVal1
        ENDIF

        * Assign the rest of them
        FOR nX = 2 TO nValCount
            cParamVar = 'xVal' + LTRIM( STR( nX ))
            xThisVal = &cParamVar

            * These can only be for multicolumn arrays
            THIS.aRA[nRowNum, nX] = xThisVal
        ENDFOR
        RETURN
    ENDPROC

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

            * First, re-dimension the array, but there's a different syntax for
            *   single- vs multi-column array.
            IF .bMultiCol
                DIMENSION .aRA[.nRows+1, .nCols]
            ELSE
                DIMENSION .aRA[.nRows+1]
            ENDIF

            * Are we to insert a row or just add one at the end?
            IF TYPE('nRowNum') = 'N' AND BETWEEN(nRowNum, 1, .nRows)
                = AINS(.aRA, nRowNum)          && Insert the row
            ELSE

                * Add a row at the end (already done), just note the row
                nRowNum = .nRows + 1
            ENDIF

            * Initialize the new row
            IF .bMultiCol
                FOR nX = 1 to .nCols
                    .aRA[nRowNum, nX] = ''
                ENDFOR
            ELSE
                .aRA[nRowNum] = ''
            ENDIF

            * Reset the row count
            .nRows = ALEN(.aRA, 1)
        ENDWITH

        * Return the new row total
        RETURN THIS.nRows
    ENDFUNC

    *- AddBlankRows() - Add many rows to the array by reDIMENSIONing
    *   Parameters: nRowsWanted
    *   Returns: the new row count
    FUNCTION AddBlankRows(nRowsWanted)
        LOCAL nOldRows, nTotRows, nRow, nCol

        * First, re-dimension the array, but there's a different syntax for
        *   single- vs multi-column array.
        nOldRows = THIS.nRows
        nTotRows = nOldRows + nRowsWanted
        IF THIS.bMultiCol
            DIMENSION THIS.aRA[nTotRows, THIS.nCols]
        ELSE
            DIMENSION THIS.aRA[nTotRows]
        ENDIF

        * Initialize the new row
        FOR nRow = nOldRows + 1 TO nTotRows
            IF THIS.bMultiCol
                FOR nCol = 1 to THIS.nCols
                    THIS.aRA[nRow, nCol] = ''
                ENDFOR
            ELSE
                THIS.aRA[nRow] = ''
            ENDIF
        ENDFOR

        * Reset the row count
        THIS.nRows = nTotRows

        * Return the new row total
        RETURN nTotRows
    ENDFUNC

    *- DeleteRow() - Remove a row to the array (re-size it smaller)
    *   Parameters: nRowNum
    *   Returns: The new number of rows in the array
    FUNCTION DeleteRow( nRowNum )

        * If we have no rows, don't do anything
        DO CASE
        CASE THIS.nRows = 0

            * We're already happy

        * If this is the last row, don't delete anything
        CASE THIS.nRows = 1
            IF THIS.bMultiCol
                FOR nJ = 1 TO THIS.nCols
                    THIS.aRA[1,nJ] = ''
                ENDFOR
            ELSE
                THIS.aRA[1] = ''
            ENDIF
            THIS.nRows = 0
        OTHERWISE

            * Delete the row
            = ADEL( THIS.aRA, nRowNum )

            * Redimension the array
            IF THIS.bMultiCol
                DIMENSION THIS.aRA[ THIS.nRows-1, THIS.nCols ]
            ELSE
                DIMENSION THIS.aRA[ THIS.nRows-1 ]
            ENDIF

            * Decrement the row count and return the new total
            THIS.nRows = THIS.nRows - 1
        ENDCASE
        RETURN THIS.nRows
    ENDFUNC

    *- DeleteRemainingRows() - Remove rows from the bottom of the array
    *      Parameters: nRowCount
    *      Returns: The new number of rows in the array
    FUNCTION DeleteRemainingRows( nRowCount )

        * Here, we know we have at least 1 row in the array
        IF THIS.nRows = 1
            IF THIS.bMultiCol
                FOR nJ = 1 TO THIS.nCols
                    THIS.aRA[1,nJ] = ''
                ENDFOR
            ELSE
                THIS.aRA[1] = ''
            ENDIF
            THIS.nRows = 0
        ELSE

            * How many rows will we end up with?
            nNewRows = THIS.nRows - nRowCount

            * Redimension the array
            IF THIS.bMultiCol
                DIMENSION THIS.aRA[ nNewRows, THIS.nCols ]
            ELSE
                DIMENSION THIS.aRA[ nNewRows ]
            ENDIF

            * Define our new row count
            THIS.nRows = nNewRows
        ENDIF
        RETURN THIS.nRows
    ENDFUNC

    *- InsertCols() - Add columns to the array (re-size it larger)
    *   Parameters: nNumNewCols
    *   Returns: The new number of columns in the array
    *   Note: All elements in the new columns are initialized to ''
    FUNCTION InsertCols( nNumNewCols )
        LOCAL nOldCols, nNewCols, nX, nY, aTemp[1]

        * Copy the current array to aTemp[]
        = ACOPY( THIS.aRA, aTemp )

        * What's our old column count?
        nOldCols = THIS.nCols

        * Re-dimension our array
        nNewCols = THIS.nCols + nNumNewCols
        IF THIS.nRows = 0
            DIMENSION THIS.aRA[1, nNewCols]
        ELSE
            DIMENSION THIS.aRA[ THIS.nRows, nNewCols]
        ENDIF
        STORE '' TO THIS.aRA

        * Copy everything from aTemp into the new array
        FOR nX = 1 TO THIS.nRows
            FOR nY = 1 TO THIS.nCols
                IF nOldCols = 1
                    THIS.aRA[nX, nY] = aTemp[nX]
                ELSE
                    THIS.aRA[nX, nY] = aTemp[nX, nY]
                ENDIF
            ENDFOR
        ENDFOR

        * Reset our values
        THIS.nCols = nNewCols
        THIS.bMultiCol = (THIS.nCols > 1)

        * Return the new column count
        RETURN THIS.nCols
    ENDFUNC

    *- DeleteCol() - Delete a column from the array (re-size it smaller)
    *     Parameters: nCol2Remove
    *     Returns: The new number of columns in the array
    FUNCTION DeleteCol( nCol2Remove )
        LOCAL nX, nY, aTemp

        * Create a temporary array
        DIMENSION aTemp[ MAX(THIS.nRows,1), THIS.nCols]

        * Copy the current array to aTemp[]
        = ACOPY( THIS.aRA, aTemp )

        * Re-dimension our array
        DIMENSION THIS.aRA[ MAX(THIS.nRows,1), THIS.nCols-1]

        * Copy all from aTemp into the new array except the column we removed
        FOR nX = 1 TO THIS.nRows
            FOR nY = 1 TO THIS.nCols
                DO CASE
                CASE nY > nCol2Remove
                    THIS.aRA[nX, nY-1] = aTemp[nX, nY]
                CASE nY < nCol2Remove
                    THIS.aRA[nX, nY] = aTemp[nX, nY]
                ENDCASE
            ENDFOR
        ENDFOR

        * Reset our values
        THIS.nCols = THIS.nCols - 1
        THIS.bMultiCol = (THIS.nCols > 1)

        * Return the new column count
        RETURN THIS.nCols
    ENDFUNC

    *- Sort() - Sort the array
    *   Parameters: [nSortCol,] [bDescending,] [bCaseInSensitive]
    *   Notes: 1. nSortCol is REQUIRED for multi-dimensional arrays or column
    *               1 will be used for the sort
    *          2. All elements in the sort must be of the same data type.
    *          3. If a bCaseInSensitive sort is desired, the first 2
    *               parameters MUST be passed
    PROCEDURE Sort( nSortCol, bDescend, bCaseInSensitive )
        LOCAL nAscend, bChkCase, nNewCol, nM

        * Return quickly if < 2 rows
        IF THIS.nRows < 2
            RETURN
        ENDIF

        * If we got no sort col, make it column 1
        IF TYPE('nSortCol') <> 'N' OR NOT BETWEEN(nSortCol, 1, THIS.nCols)
            nSortCol = 1
        ENDIF

        * Check our ascending/descending parameter
        nAscend = 0         && Default is Ascending
        IF PCOUNT() > 1 AND TYPE('bDescend') = 'L'
            nAscend = IIF(bDescend, 1, 0)
        ENDIF

        * Check our case sensitivity parameter
        bChkCase = .F.      && Default is no case sensitivity
        IF TYPE('bCaseInSensitive') = 'L'
            bChkCase = bCaseInSensitive
        ENDIF

        * If this is a case insensitive sort, we have some special work to do
        IF bChkCase
            THIS.InsertCols(1)
            nNewCol = THIS.nCols
            FOR nM = 1 TO THIS.nRows
                THIS.aRA[nM,nNewCol] = UPPER( THIS.aRA[nM,nSortCol] )
            ENDFOR

            * Sort on our uppercase column
            = ASORT( THIS.aRA, nNewCol, THIS.nRows, nAscend )

            * Delete our added column
            THIS.DeleteCol(nNewCol)
        ELSE

            * Otherwise, just a normal sort
            = ASORT( THIS.aRA, nSortCol, THIS.nRows, nAscend )
        ENDIF

        * Note our sort column
        THIS.nSortedCol = nSortCol
        RETURN
    ENDPROC

    *- MultiColSort() - Sort the array by multiple columns
    *   Parameters: nCol1, nCol2 [, nCol3] [, nCol4] [, nCol5,] [bDescending,]
    *                 [, bCaseInSensitive]]
    *   Notes: 1. At least 2 columns ARE REQUIRED for this sort (otherwise, use
    *               the Sort() method instead)
    *          2. All elements in the sort must be of the same data type.
    *          3. If a bCaseInSensitive sort is desired, the first 5
    *               parameters MUST be passed
    PROCEDURE MultiColSort(nCol1, nCol2, nCol3, nCol4, nCol5, bDescend, bCaseInSensitive)
        LOCAL nAscend, bCaseInsen, nNewSortCol, nM, cNewData

        * Return quickly if < 2 rows
        IF THIS.nRows < 2
            RETURN
        ENDIF

        * We must have the 1st 2 sort columns; check the others
        IF VARTYPE(nCol3) <> 'N' OR NOT BETWEEN(nCol3, 1, THIS.nCols)
            nCol3 = 0
        ENDIF
        IF VARTYPE(nCol4) <> 'N' OR NOT BETWEEN(nCol4, 1, THIS.nCols)
            nCol4 = 0
        ENDIF
        IF VARTYPE(nCol5) <> 'N' OR NOT BETWEEN(nCol5, 1, THIS.nCols)
            nCol5 = 0
        ENDIF

        * Check our ascending/descending parameter
        nAscend = 0         && Default is Ascending
        IF PCOUNT() > 1 AND TYPE('bDescend') = 'L'
            nAscend = IIF(bDescend, 1, 0)
        ENDIF

        * Check our case sensitivity parameter
        bCaseInsen = .F.      && Default is no case sensitivity
        IF TYPE('bCaseInSensitive') = 'L'
            bCaseInsen = bCaseInSensitive
        ENDIF

        * We'll create the sort expression made up of multiple column's
        *   values and put it in a new column.  Then, we'll sort on that.
        THIS.InsertCols(1)
        nNewSortCol = THIS.nCols

        * Now, go thru each row and create the sort expression
        FOR nM = 1 TO THIS.nRows

            * Create an expression from the affected columns
            cNewData = THIS.aRA[nM,nCol1] + THIS.aRA[nM,nCol2]
            IF nCol3 > 0
                cNewData = cNewData + THIS.aRA[nM,nCol3]
            ENDIF
            IF nCol4 > 0
                cNewData = cNewData + THIS.aRA[nM,nCol4]
            ENDIF
            IF nCol5 > 0
                cNewData = cNewData + THIS.aRA[nM,nCol5]
            ENDIF

            * If this is a case insensitive sort, make it uppercase
            IF bCaseInsen
                cNewData = UPPER(cNewData)
            ENDIF
            THIS.aRA[nM,nNewSortCol] = cNewData
        ENDFOR

        * Sort on our uppercase column
        = ASORT( THIS.aRA, nNewSortCol, THIS.nRows, nAscend )

        * Delete our added column
        THIS.DeleteCol(nNewSortCol)

        * Note our sort column
        THIS.nSortedCol = nCol1
        RETURN
    ENDPROC

    *- Seek() - Look through an ordered array for a passed value
    *   Parameters: xLookFor[, nSrchCol]
    *   Returns: Row found matching xLookFor (0 if not found)
    *            Object.nNearRow is set if xLookFor is not found and array
    *               contains a row with a larger value
    *   Notes: 1. nSrchCol is REQUIRED for multi-dimensional arrays or column
    *               1 will be used for the Seek
    *          2. xLookFor's data type must match nSrchCol's
    *          3. Assumes a sorted array (results can be spurious if not)
    FUNCTION Seek( xLookFor, nSrchCol )
        LOCAL cSrchType, nRowx, xChkVal

        * If we got no Seek col, make it column 1
        IF TYPE('nSrchCol') <> 'N' OR NOT BETWEEN(nSrchCol, 1, THIS.nCols)
            nSrchCol = 1
        ENDIF

        * What's the type of the variable we're looking for?  If it's
        *   Character, make it uppercase
        cSrchType = TYPE('xLookFor')
        IF cSrchType = 'C'
            xLookFor = UPPER(xLookFor)
        ENDIF

        * Set our default near row
        THIS.nNearRow = 0

        * Search thru the array
        FOR nRowx = 1 TO THIS.nRows

            * Get this row's value
            IF THIS.bMultiCol
                xChkVal = THIS.aRA[nRowx, nSrchCol]
            ELSE
                xChkVal = THIS.aRA[nRowx]
            ENDIF

            * If character, make it uppercase
            IF cSrchType = 'C'
                xChkVal = UPPER( xChkVal )
            ENDIF

            * Does it match what we're looking for?  Is it > than that?
            IF xChkVal >= xLookFor

                * If it's a match, return the row
                IF xChkVal = xLookFor
                    RETURN nRowx
                ENDIF

                * It must be > than what we're looking for, set nNearRow and
                *   return noting a failed Seek
                THIS.nNearRow = nRowx
                RETURN 0
            ENDIF
        ENDFOR

        * If we didn't return by now, it's not there
        RETURN 0
    ENDFUNC

    *- Locate() - Case-Insensitive look thru a non-ordered array for a value
    *     Parameters: xLookFor[, nSrchCol[, bExactOn]]
    *     Returns: Row found matching xLookFor (0 if not found)
    *     Notes: 1. nSrchCol is REQUIRED for multi-dimensional arrays or column
    *                 1 will be used for the Locate
    *            2. xLookFor's data type must match nSrchCol's
    *            3. bExactOn - (optional) If .T., EXACT comparison will be done
    FUNCTION Locate(xLookFor, nSrchCol, bExactOn)
        LOCAL cSrchType, nRowx, xChkVal, bGotIt

        * If we got no search col, make it column 1
        IF TYPE('nSrchCol') <> 'N' OR NOT BETWEEN(nSrchCol, 1, THIS.nCols)
            nSrchCol = 1
        ENDIF

#IF 0               Didn't work: INI files have longer values on the right
                    so regardless of exact setting, they couldn'f find
                    strings "beginning with".
        * ASCAN() wants a flags value as the last parameter. That is a number
        *   made up of: Bits: 3210, where:
        *       Bit  Description
        *       ---  -----------
        *        0   Case Insensitive ON bit
        *        1   Exactness ON bit (Only effective if bit 2 is set)
        *        2   Override system Exact setting bit
        *        3   Return row number if 2D array
        * We always want to set exactness, and that means we have to set the
        *   exact system override; and we always want to return the row
        *   number, so our values must always be:
        *       1110 (14) - If NOT case insensitive (e.g. case sensitive)
        *       1111 (15) - If case insensitive
        nFlag = IIF(bExactOn, 14, 15)
        nRowx = ASCAN(THIS.aRA, xLookFor, -1, -1, nSrchCol, nFlag)
        RETURN nRowx
#ENDIF

        * What's the type of the variable we're looking for?  If it's
        *   Character, make it uppercase
        cSrchType = TYPE('xLookFor')
        IF cSrchType = 'C'
            xLookFor = UPPER(xLookFor)
        ENDIF

        * Set our default near row
        THIS.nNearRow = 0

        * Search thru the array
        FOR nRowx = 1 TO THIS.nRows

            * Get this row's value
            IF THIS.bMultiCol
                xChkVal = THIS.aRA[nRowx, nSrchCol]
            ELSE
                xChkVal = THIS.aRA[nRowx]
            ENDIF

            * If character, make it uppercase
            IF cSrchType = 'C'
                xChkVal = UPPER( xChkVal )
            ENDIF

            * Does it match what we're looking for?
            IF bExactOn
                bGotIt = (xChkVal == xLookFor)
            ELSE
                bGotIt = (xChkVal = xLookFor)
            ENDIF
            IF bGotIt
                RETURN nRowx
            ENDIF

            * Set Near Row (though I'm not sure what it's good for)
            IF xChkVal > xLookFor AND THIS.nNearRow = 0
                THIS.nNearRow = nRowx
            ENDIF
        ENDFOR

        * If we didn't return by now, it's not there
        RETURN 0
    ENDFUNC

    *- PROT MoveColTo1() - Move the passed column to col 1
    *   Parameters: nMoveCol
    *   Note - ONLY APPLIES to multi-column arrays
    PROTECTED PROCEDURE MoveColTo1( nMoveCol )
        LOCAL nRowx, nColx
        LOCAL ARRAY aTemp[ THIS.nRows, THIS.nCols ]

        * Copy the existing array into a temporary array
        ACOPY( THIS.aRA, aTemp )

        * Now, copy the temporary array back into our array, moving columns
        FOR nRowx = 1 TO THIS.nRows

            * Copying is done as follows (assume 4 cols, we're to move #3)
            *   Old array col       New array col
            *        1                    2
            *        2                    3
            *        3      move col      1
            *        4                    4
            * So, the move rules are:
            *   A. Move the nMoveCol to column 1
            *   B. If the old column < nMoveCol, move it to col + 1
            *   C. Else, move it to the same column number
            FOR nColx = 1 TO THIS.nCols
                DO CASE
                CASE nColx = nMoveCol
                    THIS.aRA[nRowx,1] = aTemp[nRowx,nMoveCol]
                CASE nColx < nMoveCol
                    THIS.aRA[nRowx,nColx+1] = aTemp[nRowx,nColx]
                OTHERWISE
                    THIS.aRA[nRowx,nColx] = aTemp[nRowx,nColx]
                ENDCASE
            ENDFOR
        ENDFOR
        RETURN
    ENDPROC

    *- PROT ClnElem() - Return a "clean" element's contents for printing
    *   Parameters: xElem, nMaxLen
    *   Returns: Trimmed string, <= nMaxLen with no internal CR, LF, or TABs)
    *               ready for printing
    PROTECTED FUNCTION ClnElem( xElem, nMaxLen )
        LOCAL cStrOut

        * Convert the passed element into a string
        cStrOut = TRIM( THIS.XToChar( xElem ) )

        * Convert TABs into 2 spaces
        IF TAB $ cStrOut
            cStrOut = STRTRAN(cStrOut, TAB, '  ')
        ENDIF

        * But, the string ends at the first CR or LF
        IF CR $ cStrOut
            cStrOut = LEFT(cStrOut, AT(CR, cStrOut)-1 )
        ENDIF
        IF LF $ cStrOut
            cStrOut = LEFT(cStrOut, AT(LF, cStrOut)-1 )
        ENDIF

        * Chop it if it's greater than nMaxLen (if we have nMaxLen)
        IF VARTYPE(nMaxLen) = 'N' AND nMaxLen > 0 AND LEN(cStrOut) > nMaxLen
            cStrOut = LEFT(cStrOut, nMaxLen)
        ENDIF

        * Done
        RETURN cStrOut
    ENDFUNC

    *- PrintToFile() - Outputs our array's contents to a text file
    PROCEDURE PrintToFile( cFileName )
        SET PRINT TO (cFileName)
        SET PRINT ON
        SET CONSOLE OFF
        THIS.Print(0)
        SET CONSOLE ON
        SET PRINT OFF
        SET PRINT TO
        RETURN
    ENDPROC

    *- Print() - Uses ? output to list the array contents (max. 20 char elements)
    *   Parameters: [nLeftMargin] - number of spaces for left margin (default = 0)
    PROCEDURE Print( nLeftMargin )
        LOCAL cMargin, cRows, cCols, cColGap, cHdg, cStrOut, nR, nC, nMaxCols, ;
          cThisElem
        LOCAL WidthRA[1]

        * What's our left margin
        cMargin = ''
        IF TYPE('nLeftMargin') = 'N' AND nLeftMargin > 0
            cMargin = SPACE(nLeftMargin)
        ENDIF

        * Print the heading - first, get a row and column string
        cRows = ALLTRIM( THIS.XToChar( THIS.nRows ) ) + ' row' + ;
          IIF( THIS.nRows = 1, '', 's')
        cCols = ALLTRIM( THIS.XToChar( THIS.nCols ) ) + ' column' + ;
          IIF( THIS.nCols = 1, '', 's')
        ?? cMargin + THIS.Name + "'s aRA[] contents - " + cRows + ', ' + ;
          cCols + ':'

        * We want to print out the array kinda like:
        *       nnnn:  Cell1    Cell2   Cell3   ...
        * where nnnn = row number.  But, each element might have long
        * strings and we want this all to line up.  So, we'll determine the
        * maximum width for each column.  We'll make a quick little array
        * where each row is the maximum column width.
        cColGap = SPACE(2)

        * Create another array to hold the widths
        DIMENSION WidthRA[ THIS.nCols ]
        STORE 0 TO WidthRA

        * If this is a multi-column array, things are tricky
        IF THIS.bMultiCol
            cHdg = THIS.SetPrtWid( @WidthRA, 6+LEN(cMargin), LEN(cColGap) )
            cStrOut = cMargin + SPACE(4) + '  ' + cHdg
            ? cStrOut
        ELSE
            WidthRA[1] = 80
            cHdg = ''
        ENDIF

        * Go thru and print all rows in the array
        FOR nR = 1 TO THIS.nRows

            * Define our row number string
            cStrOut = cMargin + STR( nR, 4, 0) + ': '

            * Add all columns
            FOR nC = 1 TO THIS.nCols

                * What's our maximum length
                nMaxCols = WidthRA[nC]
                IF THIS.bMultiCol
                    cThisElem = THIS.ClnElem( THIS.aRA[nR,nC] )
                ELSE
                    cThisElem = THIS.ClnElem( THIS.aRA[nR] )
                ENDIF
                IF LEN(cThisElem) > nMaxCols
                    cThisElem = LEFT(cThisElem,nMaxCols-3) + '...'
                ELSE
                    cThisElem = THIS.MakeLen( cThisElem, nMaxCols)
                ENDIF
                cStrOut = cStrOut + cThisElem + cColGap
            ENDFOR

            * Print this line
            ? cStrOut
        ENDFOR

        * Add a blank line and we're done
        ?
        RETURN
    ENDPROC

    *- PROT SetPrtWid() - Set our Print() column width
    PROTECTED FUNCTION SetPrtWid( aColWidths, nMargLen, nColGap)
        EXTERNAL ARRAY aColWidths
        LOCAL nE, nF, cThisElem, nLen, nOAWid, nCols, nMaxWid, nToCut, nChg, ;
          cHdgLine

        * This is a multi-dimensional array.  We want to print it out at a
        *   maximum width of 80 characters including the left margin.  Like:
        *       Row#:  Cell1    Cell2   Cell3   ...

        * First, find the maximum width of each column
        FOR nE = 1 TO THIS.nRows
            FOR nF = 1 TO THIS.nCols
                cThisElem = THIS.ClnElem( THIS.aRA[nE,nF], 80 )
                nLen = LEN(cThisElem)
                IF nLen > aColWidths[nF]
                    aColWidths[nF] = nLen
                ENDIF
            ENDFOR
        ENDFOR

        * Make sure we at least have room for the heading and calculate the
        *   overall width
        nOAWid = 0
        nCols = THIS.nCols
        FOR nF = 1 TO nCols
            nLen = aColWidths[nF]

            * We must have at least room for the heading
            IF nLen < LEN( LTRIM( STR(nF) ))
                nLen = LEN( LTRIM( STR(nF) ))
                aColWidths[nF] = nLen
            ENDIF

            * Add to the overall totals
            nOAWid = nOAWid + aColWidths[nF] + IIF(nF < nCols, nColGap, 0)
        ENDFOR

        * If we're over our 80 column length, we'll have to do some chopping
        nMaxWid = 80 - nMargLen + 5         && An extra 5 is OK
        IF nOAWid > nMaxWid

            * How much do we have to cut?
            nToCut = nOAWid - nMaxWid

            * We'll take it all from columns > 20 chars starting from the end
            FOR nF = nCols TO 1 STEP -1
                IF aColWidths[nF] > 20
                    nChg = aColWidths[nF] - 20
                    aColWidths[nF] = 20
                    nToCut = nToCut - nChg
                    IF nToCut <= 0
                        EXIT
                    ENDIF
                ENDIF
            ENDFOR
        ENDIF

        * Now, create a heading line
        cHdgLine = ''
        FOR nF = 1 TO nCols
            cHdgLine = cHdgLine + ;
              PADC( LTRIM( STR( nF )), aColWidths[nF], '-') + SPACE(nColGap)
        ENDFOR

        * Done, return the heading line
        RETURN cHdgLine
    ENDFUNC

    *- ZapArray() - Removes all data and rows in an array (columns are unchanged)
	PROCEDURE ZapArray()
        IF THIS.bMultiCol
            DIMENSION THIS.aRA[ 1, THIS.nCols ]
        ELSE
            DIMENSION THIS.aRA[1]
        ENDIF
        THIS.nRows = 0
        STORE '' TO THIS.aRA
        RETURN
    ENDPROC

    *- PROT XToChar() - Convert any value into a string
    *     Input: xValue - Value to be converted
    *      Retn: String after conversion
    *      Note: Was XTOCHAR
    PROTECTED FUNCTION XToChar( pxValue )
        LOCAL cOldSet, cRetVal

        * Do the conversion, logicals are special
        DO CASE

        * Nulls
        CASE ISNULL(pxValue)
            RETURN '.NULL.'

        * Objects
        CASE VARTYPE(pxValue) = 'O'
            IF PEMSTATUS(pxValue, [Name], 5)
                RETURN 'Object: ' + pxValue.Name
            ENDIF
            RETURN 'Object: Empty class'

        * Logicals
        CASE VARTYPE(pxValue) = 'L'
            RETURN TRANSFORM(pxValue, "Y")

        * Use DTOS for dates.  DTOS() is independent of the SET DATE or SET
        *   CENTURY settings - but be aware that all returns are in yyyymmdd format.
        CASE VARTYPE(pxValue) = 'D'
            RETURN DTOS(pxValue)

        * Use TTOS for DateTimes.  TTOS() is independent of the SET SECONDS or
        *   SET CENTURY settings, but the string will be in
        *   yyyy:mm:dd:hh:mm:ss format.  If the DateTime contains only a time,
        *   VFP adds the default date of 12/30/1899.  If it's only a date, VFP
        *   adds the default time of midnight (12:00:00 A.M.).
        CASE VARTYPE(pxValue) = 'T'
            RETURN TTOC(pxValue, 1)

        * Numerics are tricky as we'll get a bunch of trailing 0's depending on
        *   the SET DECIMALS setting
        CASE VARTYPE(pxValue) = 'N'
            cOldSet = SET('DECIMALS')
            SET DECIMALS TO 10
            cRetVal = ALLTRIM( TRANSFORM(pxValue, "") )

            * Strip any trailing 0s and .s from fractions
            DO WHILE '.' $ cRetVal AND RIGHT(cRetVal, 1) $ '0.'
                cRetVal = LEFT(cRetVal, LEN(cRetVal)-1 )
            ENDDO
            SET DECIMALS TO cOldSet
            RETURN cRetVal

        * Character and memos are the easiest
        CASE VARTYPE(pxValue) $ 'CMG'
            RETURN pxValue

        * Objects???  Does anyone care?
        CASE VARTYPE(pxValue) = 'O'
            RETURN 'Object: ' + pxValue.Name

        * Everything else
        OTHERWISE
            RETURN ALLTRIM( TRANSFORM(pxValue, "") )
        ENDCASE
    ENDFUNC

    *- PROT MakeLen() - Make a string to the length specified (space filled if needed)
    PROTECTED FUNCTION MakeLen( cStrIn, nDesLen, bAddMT)
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

    *- PROT FldsInExpr() - Returns a list of field names within an index expression
    *     Input: cExpr - The index expression in question
    *      Retn: List of Field Names
    *      Note: Was EXPRFLDS
    PROTECTED FUNCTION FldsInExpr( pcExpr )
        LOCAL cWkgExpr, cFldList, nX, cThisFld

        * First, extract any "FOR" or "UNIQUE" clauses
        cWkgExpr = UPPER( ALLTRIM(pcExpr) )
        IF ' FOR ' $ cWkgExpr
            cWkgExpr = LEFT( cWkgExpr, AT(' FOR ',cWkgExpr)-1 )
        ENDIF
        IF ' UNIQUE' $ cWkgExpr
            cWkgExpr = LEFT( cWkgExpr, AT(' UNIQUE',cWkgExpr)-1 )
        ENDIF
        IF ' DESCENDING' $ cWkgExpr
            cWkgExpr = LEFT( cWkgExpr, AT(' DESCENDING',cWkgExpr)-1 )
        ENDIF
        IF ' ASCENDING' $ cWkgExpr
            cWkgExpr = LEFT( cWkgExpr, AT(' ASCENDING',cWkgExpr)-1 )
        ENDIF

        * Initialize our return field list string
        cFldList = ''

        * Now, the expression is of the form:
        *   fld_nm1 + fld_nm2 + fld_nm3 ...
        * So, we have to extract the fields between plus signs.  However, they
        *   could be of the form: UPPER(fld_nm1+fld_nm3) + DTOS(fld_nm3)...
        DO WHILE LEN(cWkgExpr) > 0
            nX = THIS.AtNotInParen('+', cWkgExpr)    && But not within parentheses

            * Extract the field from cWkgExpr
            IF nX = 0
                cThisFld = cWkgExpr
                cWkgExpr = ''
            ELSE
                cThisFld = TRIM( LEFT(cWkgExpr, nX-1) )
                cWkgExpr = LTRIM( SUBSTR(cWkgExpr, nX+1) )
            ENDIF

            * Remove any field conversions
            cThisFld = THIS.ExtrFldName(cThisFld)

            * If we still have a '+' sign in cThisFld, it needs more
            *   processing, so put it back in cWkgExpr.  Otherwise, add it to
            *   our return string
            IF '+' $ cThisFld
                cWkgExpr = cThisFld + cWkgExpr
            ELSE
                cFldList = cFldList + IIF( EMPTY(cFldList), '', ',') + cThisFld
            ENDIF
        ENDDO
        RETURN cFldList
    ENDFUNC

    *- PROT ExtrToken() - Extract and return the text before a passed token (char)
    *     Input: cStrIn - String for extraction (if passed as @cStrIn, the
    *                       fragment and token are really extracted)
    *            pcTokenChar - Character separator
    *      Retn: Text in cStrIn before the first pcTokenChar
    *     Tests: 1: ExtrToken('AB^CD', '^') --> 'AB'
    *            2: cVar = '123.45'
    *               ExtrToken( @cVar, '.') --> '123'
    *               cVar now = '45'
    *      Note: Was EXTR_TKN
    PROTECTED FUNCTION ExtrToken( pcStrIn, pcTokenChar )
        LOCAL cRetTxt, nChrPosn

        * We're passed a block of text (pcStrIn) supposedly containing at
        *   least one instance of a character (pcTokenChar).  Our job is to
        *   extract and return the text UP TO but not including pcTokenChar,
        *   and to remove that text and pcTokenChar from pcStrIn (will only
        *   work if pcStrIn passed as @pcStrIn).
        * If the text doesn't have the character, we'll return the full string
        *   and empty out pcStrIn.
        cRetTxt = ''

        * Look for pcTokenChar
        nChrPosn = AT( pcTokenChar, pcStrIn)

        * If it isn't there, clear pcStrIn
        IF nChrPosn = 0
            cRetTxt = pcStrIn
            pcStrIn = ''
        ELSE

            * Get the text to the left of the character
            cRetTxt = LEFT( pcStrIn, nChrPosn-1)

            * Remove the text and character from pcStrIn
            IF nChrPosn+1 > LEN( pcStrIn )
                pcStrIn = ''
            ELSE
                pcStrIn = SUBSTR( pcStrIn, nChrPosn+1 )
            ENDIF
        ENDIF
        RETURN cRetTxt
    ENDFUNC

    *- PROT AtNotInParen() - Return the pos'n of a char NOT within parentheses
    *     Input: cTheChar - The character in question
    *            cTheStr - The string to search
    *      Retn: The position (0 if not there or if only within ())
    *      Note: Was AT_NOPAR
    PROTECTED FUNCTION AtNotInParen( pcTheChar, pcTheStr )
        RETURN THIS.AtNotInDelim( pcTheChar, pcTheStr, '()' )
    ENDFUNC

    *- PROT AtNotInDelim() - Return the pos'n of a char NOT within delimeters
    *     Input: cTheChar - The character in question
    *            cTheStr  - The string to search
    *            pcDelim  - The left and right delimeter pair
    *      Retn: The position (0 if not there or if only within ())
    *      Note: Was AT_DELIM
    PROTECTED FUNCTION AtNotInDelim( pcTheChar, pcTheStr, pcDelim )
        LOCAL cRDelim, cLDelim, cWkgStr, cDiscards, nCharPosn, nLPosn, nRPosn, ;
          cLeftSide, cRightSide

        * This function will look for, and return, the position of a character
        *   in a string but NOT within the passed delimiters.
        *            12345678901
        *   Example: ABC(DEF)GFX  For "F", returns 10

        * Delimiters may be passed as one pair rather than 2 separate
        *   characters.  Delimiter pairs can be anything reasonable (except
        *   the character being searched for); for example: "", '', (), {},
        *   [], <>, etc.

        * Return quickly if the character isn't in the string at all
        IF NOT pcTheChar $ pcTheStr
            RETURN 0
        ENDIF

        * Separate our delimiters
        cRDelim = SUBSTR(pcDelim, 2)
        cLDelim = LEFT(pcDelim, 1)

        * Return almost as quickly if the left delimiter isn't in the string --
        *   giving the best answer we can
        IF NOT cLDelim $ pcTheStr
            RETURN AT(pcTheChar,pcTheStr)
        ENDIF

        * Now, we know the character is in the string and we DO have
        *   delimiters.  But, we really have 2 routines:
        *       1. If the delimeters are the same
        *       2. If they're different
        IF cRDelim = cLDelim

            * This is simpler than different delimeters as, by definition,
            *   nested delimeters is a meaningless term
            cWkgStr = pcTheStr
            cDiscards = ''
            nCharPosn = 0
            DO WHILE LEN(cWkgStr) > 0

                * Find the first instance of left and right delimiters
                nLPosn = AT( cLDelim, cWkgStr )
                nRPosn = AT( cLDelim, cWkgStr, 2 )

                * Find the first instance of our character
                nCharPosn = AT(pcTheChar,cWkgStr)

                * Possibilities
                *   1. nCharPosn = 0 -- just return 0 because it was only
                *       in the string inside of delimiters
                IF nCharPosn = 0
                    RETURN 0
                ENDIF

                *   2. nCharPosn < nLPosn -- return nCharPosn + cDiscards length
                IF nCharPosn < nLPosn OR nLPosn = 0 OR nRPosn = 0 OR nRPosn < nLPosn
                    RETURN nCharPosn + LEN(cDiscards)
                ENDIF

                *   3. nCharPosn < nRPosn -- doesn't count as it's within the
                *       delimeters
                *   4. nCharPosn > nRPosn -- indeterminate as that might be within
                *       a later set of delimeters
                * Put everything up to and including the right position into Discards
                cDiscards = cDiscards + LEFT( cWkgStr, nRPosn )
                IF nRPosn = LEN(cWkgStr)
                    cWkgStr = ''
                ELSE
                    cWkgStr = SUBSTR(cWkgStr, nRPosn+1 )
                ENDIF
            ENDDO   && WHILE LEN(cWkgStr) > 0
        ELSE    && Delimiters are different

            * The tricky part with different delimiters is that the delimiters might
            *   be nested.
            cWkgStr = pcTheStr
            cDiscards = ''
            nCharPosn = 0
            DO WHILE LEN(cWkgStr) > 0

                * Find the first instances of left and right delimiters
                nLPosn = AT( cLDelim, cWkgStr )
                nRPosn = AT( cRDelim, cWkgStr )

                * Find the first instance of our character
                nCharPosn = AT(pcTheChar,cWkgStr)

                * Possibilities
                *   1. nCharPosn = 0 -- just return 0 because it was only
                *       in the string inside of delimiters
                *   2. nCharPosn < nLPosn -- return nCharPosn + cDiscards length
                *   3. Delimeters don't match:  i.e. just "(" or just ")" --
                *       by definition, the character isn't within nested parens, so
                *       return nCharPosn + cDiscards length
                *   4. nCharPosn > nRPosn -- indeterminate yet until we extract nested
                *       delimiters
                IF nCharPosn = 0
                    RETURN 0
                ENDIF
                IF nCharPosn < nLPosn OR nLPosn = 0 OR nRPosn = 0 OR nRPosn < nLPosn
                    RETURN nCharPosn + LEN(cDiscards)
                ENDIF

                *   3. nCharPosn > nRPosn -- indeterminate yet until we extract nested
                *       delimiters
                nLPosn = RAT( cLDelim, LEFT(cWkgStr,nRPosn) )        && Match right paren

                * Save that which we are about to extract
                cDiscards = cDiscards + SUBSTR( cWkgStr, nLPosn, nRPosn-nLPosn+1 )

                * Extract the nested parenthesis
                cLeftSide = IIF( nLPosn=1, '', LEFT(cWkgStr,nLPosn-1) )
                cRightSide = IIF( nRPosn=LEN(cWkgStr), '', SUBSTR(cWkgStr,nRPosn+1) )
                cWkgStr = cLeftSide + cRightSide

                * Reset for our loop
                nCharPosn = 0
            ENDDO   && WHILE LEN(cWkgStr) > 0
        ENDIF

        * Done
        RETURN nCharPosn + LEN(cDiscards)
    ENDFUNC

    *- ExtrFldName() - Extract the first field name from an expression
    *     Input: cExpr - String for extraction
    *      Retn: Extracted field name
    *      Note: Was EXTRFNAM
    FUNCTION ExtrFldName( pcExpr )
        LOCAL cRetName, nX, nY

        * Expressions can have the form:
        *   Character fields: field or UPPER(field) or LEFT(field,n)
        *        Date fields: DTOS(field)
        *     Numeric fields: STR(field,len,dec) or STR(INT(field+str),len,dec)
        *     Logical fields: IIF(field,'Y','N')
        * Conditional fields: IIF(EMPTY(field),expr1,DTOS(date))
        *                 or: IIF(field='A',uvw,xyz)
        cRetName = pcExpr

        * In most cases, we'll:
        *   A. Throw away whatever's to the left of any '('
        *   B. Throw away whatever's to the right of any ')'
        * But, notice that the conditional expression has some special problems:
        *   1st () removal --> EMPTY(field),expr1,DTOS(date)
        *   2nd () removal --> field),expr1,DTOS(date
        *   3rd () removal --> ''
        DO WHILE '(' $ cRetName
            nX = AT('(', cRetName)
            nY = RAT(')', cRetName)
            IF nY > nX
                cRetName = SUBSTR( cRetName, nX+1, nY-nX-1)
            ELSE

                * nY < nX: field),expr1,DTOS(date  ... so throw away all to the right
                *   of ")"
                cRetName = LEFT(cRetName, nY-1)
            ENDIF
        ENDDO

        *   C. Remove any rightmost portions after commas
        DO WHILE ',' $ cRetName
            nY = RAT(',', cRetName)
            cRetName = LEFT(cRetName, nY-1)
        ENDDO

        *   D. Remove any rightmost portions after the equals sign
        DO WHILE '=' $ cRetName
            nY = RAT('=', cRetName)
            cRetName = LEFT(cRetName, nY-1)
        ENDDO

        * Done
        RETURN cRetName
    ENDFUNC

    *- Error() - Handle/pass up any errors
    PROCEDURE Error()
        LPARAMETERS nError, cMethod, nLine
        LOCAL aErrInfo[7], cMethName, cSys16, cCmd, oParent, bGotGlobal, ;
          cAction, cHndlCmd, nChoice

        * Get the error info and define stuff about ourselves
        AERROR(aErrInfo)
        cMethName = THIS.Name + '.' + cMethod
        cSys16 = SYS(16)
        cCmd = MESSAGE(1)

        * First, do we have a parent?
        oParent = NULL
        IF PEMSTATUS(THIS, [Parent], 5) AND TYPE([THIS.Parent]) = [O] AND ;
          PEMSTATUS(THIS.Parent, [Error], 5)
            oParent = THIS.Parent
        ENDIF

        * Now, register the error if we have a global handler
        bGotGlobal = .F.
        IF TYPE('goError.Name') = 'C'
            goError.RegisterError(nError, cMethName, nLine, @aErrInfo, cSys16, ;
              THIS)
            bGotGlobal = .T.
        ENDIF

        * Handle this error as best we can after assuming our return action
        cAction = 'RETURN'
        DO CASE

        * First, try the parent
        CASE NOT ISNULL(oParent)
            cAction = oParent.Error(nError, cMethName, nLine)

        * Next, the global error handling object
        CASE bGotGlobal
            cAction = goError.HandleError(nError, cMethName, nLine, @aErrInfo, ;
              cSys16, THIS)

        * There may be some other global error handler.  So give it what it
        *   wants.  Caution: It may be called as a function or with a DO
        CASE NOT EMPTY( ON('ERROR') )
            cHndlCmd = UPPER(ON('ERROR') )
            cHndlCmd = STRTRAN( STRTRAN( STRTRAN( STRTRAN( STRTRAN( cHndlCmd, ;
              'PROGRAM()', '"' + cMethName + '"'), ;
              'ERROR()',   'nError'), ;
              'LINENO()',  'nLine'), ;
              'MESSAGE()', 'aErrInfo[2]'), ;
              'SYS(2018)', 'aErrInfo[3]')
            IF LEFT(cHndlCmd, 3) = [DO ]
                &cHndlCmd
            ELSE
                cAction = &cHndlCmd
            ENDIF
        OTHERWISE

            * Nothing else left to do.  Ask if they want to Continue, Cancel or
            *   get the debugger; this must only happen in test.  The
            *   parameter MB_YESNOCANCEL = 3 + MB_ICONSTOP = 16 = 19
            nChoice = MESSAGEBOX('Error #: ' + LTRIM(STR(nError)) + CHR(13) + ;
              'Message: ' + aErrInfo[2] + CHR(13) + ;
              'Line: ' + LTRIM(STR(nLine)) + CHR(13) + ;
              'Code: ' + cCmd + CHR(13) + ;
              'Method: ' + cMethName + CHR(13) + ;
              'Object: ' + THIS.Name + CHR(13) + CHR(13) + ;
              'Choose Yes to display the debugger, No to ' + ;
              'Continue without the debugger, or Cancel to ' + ;
              'cancel execution', 19, _VFP.Caption)

            * If we're to debug, do it here and set for RETURN
            DO CASE
            CASE nChoice = 6            && IDYES
                cAction = [RETURN]
                DEBUG
                SUSPEND
            CASE nChoice = 7            && IDNO
                cAction = [RETURN]
            CASE nChoice = 2            && IDCANCEL
                cAction = [CANCEL]
            ENDCASE
        ENDCASE

        * Handle the return value but check the hierarchy first
        DO CASE
        CASE '.' $ cMethName
            RETURN cAction              && Calling method
        CASE cAction = 'CLOSEFORM'
            THISFORM.Release()
        CASE NOT EMPTY(cAction)         && RETURN, RETRY, CANCEL
            &cAction                    && Do it
        ENDCASE
        RETURN                          && What else?
    ENDPROC

    *- Destroy() - Kill our contents
    PROCEDURE Destroy()
        LOCAL nX

        * Kill any objects we added
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
        DODEFAULT()
    ENDPROC

    *- Release() - Remove this object from memory
    PROCEDURE Release()
        THIS.Destroy()
        Release THIS
    ENDPROC
ENDDEFINE

*   CallingPgms Class (parent ArrayObj) - Handles program hierarchy list
DEFINE CLASS CallingPgms AS ArrayObj

    * Our error handlers typically display a program calling hierarchy. But
    *   we can also need that for other reasons.

    * Array structure definition
    *   .aRA[x,1] - Col. 2's file date and time as: mm/dd/yyyy hh:mm:ss
    *   .aRA[x,2] - Executing file name (APP, EXE, FXP)
    *   .aRA[x,3] - Module or object name
    *   .aRA[x,4] - Source filename (PRG, VCX...)
    *   .aRA[x,5] - Line number in module or object source file
    *   .aRA[x,6] - Program line containing error

    * Standard Properties
    Name = 'CallingPgms'

    * Custom Properties
    cExcludeNames = ''      && Comma-delimited list of stem names to exclude

    * Custom Method List:
    *- Init() - Initialize our array object
    *- LoadArray() - Load up our array with the program calling hierarchy
    *- RetFileDate() - Return the date/time for the passed filename

    * Custom Method Code:

    *- Init() - Initialize our array object
    *   Parameters: cFileSpec [, cDirAttrib ]
    *   Notes: This creates an array of the files matching cFileSpec.  The
    *             array is automatically sized as needed.
    FUNCTION Init(cExclNames)

        * Do the default Init() for 6 columns
        IF NOT DODEFAULT(6)
            RETURN .F.
        ENDIF

        * Load the hierarchy array
        IF VARTYPE(cExclNames) = 'C'
            THIS.cExcludeNames = cExclNames
        ENDIF
        THIS.LoadArray()
        RETURN .T.
    ENDFUNC

    *- LoadArray() - Load up our array with the program calling hierarchy
    FUNCTION LoadArray()
        LOCAL cNames2Skip, nX, cName, cName2

        * Get the programs
        THIS.nRows = aStackInfo(THIS.aRA)

        * Now, massage this array to make it more useful
        WITH THIS
            cNames2Skip = .cExcludeNames
            FOR nX = .nRows TO 1 STEP -1
                cName = JUSTSTEM( UPPER(.aRA[nX,4]) )
                cName2 = JUSTSTEM( UPPER(.aRA[nX,3]) )

                * Delete all instances of program names in cNames2Skip
                IF cName $ cNames2Skip OR cName2 $ cNames2Skip
                    THIS.DeleteRow(nX)

                * Currently col 1 has the Stack level. We don't care about that
                *   as it's the same as the row number. So, instead we want to
                *   replace that with column 2's date/time. And, we want to
                *   clean up the name a bit.
                ELSE
                    cName2 = PROPER(.aRA[nX,3])
                    .aRA[nX,3] = cName2

                    * Get the latest file date
                    .aRA[nX,1] = .RetFileDate(.aRA[nX,4])
                ENDIF
            ENDFOR
        ENDWITH
        RETURN .T.
    ENDFUNC

    *- RetFileDate() - Return the date/time for the passed filename
    FUNCTION RetFileDate( cFName )
        LOCAL nFileCnt, cRetDate
        LOCAL aFileRA[1,5]

        * Look for the file on the cAppPath or cSrcPath directories
        nFileCnt = ADIR(aFileRA, cFName)

        * There may not be any file
        IF nFileCnt = 0
            cRetDate = '<no file date>'
        ELSE

            * Format this as mm/dd/yyyy hh:mm:ss
            cRetDate = DTOC( aFileRA[1,3] ) + ' ' + aFileRA[1,4]
        ENDIF
        RETURN cRetDate
    ENDFUNC

    *- GetPgmList() - Return a string of our hierarchy - the excluded names
    FUNCTION GetPgmList(nMarg)
        LOCAL cRet, cMarg, nX, cName, cDate, cExec, nLine, cCmd
        WITH THIS
            cRet = ''
            IF NOT EMPTY(.cExcludeNames)
                cRet = '(Exclusions: ' + .cExcludeNames + ')' + CR_LF
            ENDIF

            * We'll show this in reverse order with each program looking like:
            *  _10. Webconnectali.crfqcntl.crfqsearch2 - Line: 4544 - Cmd:
            *         In: g:\aliweb\source\crfqcntl.fxp - 10/28/2013 11:36:34
            cMarg = SPACE(nMarg)
            FOR nX = .nRows TO 1 STEP -1
                cName = JUSTSTEM(.aRA[nX,3])
                cDate = .aRA[nX,1]
                cExec = .aRA[nX,2]
                nLine = .aRA[nX,5]
                cCmd  = ALLTRIM( .aRA[nX,6] )
                cRet = cRet + cMarg + STR(nX,3,0) + '. ' + cName + ;
                  ' - Line: ' + LTRIM(TRANSFORM(nLine)) + ' - Cmd: ' + ;
                  cCmd + CR_LF + ;
                  cMarg + SPACE(3) + 'In: ' + cExec + ' - ' + cDate + CR_LF
            ENDFOR
        ENDWITH
        RETURN cRet
    ENDFUNC
ENDDEFINE

*   ParamObj Class (parent ArrayObj) - Handles multiple parameters
DEFINE CLASS ParamObj AS ArrayObj

    * Creating a Parameter Object to pass (2 ways):
    *   1. Pass up to 4 name/value pairs to Init():
    *       oParam = CREATEOBJECT('ParamObj', Name1, Value1, etc.)
    *   2. Create the object and use AddParam() to add parameter values:
    *       oParam = CREATEOBJECT('ParamObj')
    *       WITH oParams
    *           .AddParam([StrParam], [Characters])
    *           .AddParam([NumParam], 54.236)
    *           etc.
    *       ENDWITH

    * Retrieving passed parameters (2 ways):
    *   1. Access as a property:
    *       PARAMETERS oArgs
    *       cStrParam = oArgs.StrParam
    *   2. Use GetValue():
    *       PARAMETERS oArgs
    *       nNumParam = oArgs.GetValue([NumParam])
    *       Note: bNameFound property is .F. if name is not in parameters

    * Other Notes:
    *   1. These methods get parameter information:
    *       GetValue() - Return the Value of the passed parameter
    *       GetType() - Return the Type of the passed parameter
    *       GetEmpty() - Return the Empty status of the passed parameter
    *       GetWasPassed() - Return the Was Passed status of the parameter
    *   2. All Get() methods set some properties for the passed name, so after
    *       calling one Get() method, you can access the following properties
    *       directly:
    *           xLastValue = .F.
    *           cLastType = ''
    *           bLastWasEmpty = .F.
    *           bLastWasPassed = .F.
    *       Example:
    *           cRFQType = oParms.GetValue([RFQType])
    *           IF oParms.cLastType = [C] AND NOT oParms.bLastWasEmpty
    *               your action code goes here
    *           ENDIF

    * Array structure definition
    *   .aRA[x,1] - Parameter name (C)
    *   .aRA[x,2] - Parameter Value (any type)
    *   .aRA[x,3] - Value Type (C) - set with VARTYPE()
    *   .aRA[x,4] - .T. if value is empty or null
    *   .aRA[x,5] - .T. if value was passed

    * Standard Properties
    Name = 'ParamObj'

    * Special parameter properties (set by all Get methods)
    bNameFound = .F.                    && .T. if name found in Get() methods
    cLastName = ''
    nLastRow = 0
    xLastValue = .F.
    cLastType = ''
    bLastWasEmpty = .F.                 && Empty or Null (objects)
    bLastWasPassed = .F.

    * Custom Method List:
    *- Init() - Initialize our array object
    *- AddParam() - Add a parameter set to our array
    *- GetValue() - Return the Value of the passed parameter
    *- GetType() - Return the Type of the passed parameter
    *- GetEmpty() - Return the Empty status of the passed parameter
    *- GetWasPassed() - Return the Was Passed status of the passed parameter
    *- SetProperties() - Set our "Last" properties from the passed row
    *- LoadParameters() - Load the passed parameters into our array

    * Custom Method Code:

    *- Init() - Initialize our array object
    *   Parameters: cFileSpec [, cDirAttrib ]
    *   Notes: This creates an array of the files matching cFileSpec.  The
    *             array is automatically sized as needed.
    FUNCTION Init(cName1, xVal1, cName2, xVal2, cName3, xVal3, cName4, xVal4)
        LOCAL nNumParms

        * Do the default Init() for 5 columns
        IF NOT DODEFAULT(5)
            RETURN .F.
        ENDIF

        * Load the passed parameter pairs
        nNumParms = PCOUNT()
        IF nNumParms > 0
            THIS.LoadParameters(nNumParms, cName1, xVal1, cName2, xVal2, ;
              cName3, xVal3, cName4, xVal4)
        ENDIF
        RETURN .T.
    ENDFUNC

    *- AddParam() - Add a parameter set to our array
    FUNCTION AddParam(cPName, xPValue, bGotValue)
        LOCAL bValuePassed, cType, bIsMT

        * Was the value passed?
        bValuePassed = .F.
        DO CASE
        CASE PCOUNT() = 2
            bValuePassed = .T.
        CASE PCOUNT() = 3
            bValuePassed = bGotValue
        ENDCASE

        * What's its type?
        cType = VARTYPE(xPValue)

        * Is it empty?
        IF cType = [O]
            bIsMT = ISNULL(xPValue)
        ELSE
            bIsMT = EMPTY(xPValue)
        ENDIF

        * Add this to our array
        THIS.AddRow(cPName, xPValue, cType, bIsMT, bValuePassed)

        * Add this as a property
        ADDPROPERTY(THIS, cPName, xPValue)
        RETURN THIS.nRows
    ENDFUNC

    *- GetValue() - Return the Value of the passed parameter
    FUNCTION GetValue(cPName)
        LOCAL xRetVal, nRow

        * By default, we'll return .F.
        xRetVal = .F.

        * This may be quick if we've already found this name
        IF UPPER(cPName) == UPPER(THIS.cLastName)
            xRetVal = THIS.xLastValue
        ELSE

            * Find the parameter's row
            nRow = THIS.Locate(cPName, 1, .T.)      && .T. = Exact On
            THIS.bNameFound = BETWEEN(nRow, 1, THIS.nRows)
            IF THIS.bNameFound
                THIS.SetProperties(nRow)
                xRetVal = THIS.xLastValue
            ENDIF
        ENDIF

        * Done
        RETURN xRetVal
    ENDFUNC

    *- GetType() - Return the Type of the passed parameter
    FUNCTION GetType(cPName)
        LOCAL xRetVal, nRow
        xRetVal = .F.
        IF UPPER(cPName) == UPPER(THIS.cLastName)
            xRetVal = THIS.xLastType
        ELSE
            nRow = THIS.Locate(cPName, 1, .T.)
            THIS.bNameFound = BETWEEN(nRow, 1, THIS.nRows)
            IF THIS.bNameFound
                THIS.SetProperties(nRow)
                xRetVal = THIS.xLastType
            ENDIF
        ENDIF

        * Done
        RETURN xRetVal
    ENDFUNC

    *- GetEmpty() - Return the Empty status of the passed parameter
    FUNCTION GetEmpty(cPName)
        LOCAL xRetVal, nRow
        xRetVal = .F.
        IF UPPER(cPName) == UPPER(THIS.cLastName)
            xRetVal = THIS.bLastWasEmpty
        ELSE
            nRow = THIS.Locate(cPName, 1, .T.)
            THIS.bNameFound = BETWEEN(nRow, 1, THIS.nRows)
            IF THIS.bNameFound
                THIS.SetProperties(nRow)
                xRetVal = THIS.bLastWasEmpty
            ENDIF
        ENDIF

        * Done
        RETURN xRetVal
    ENDFUNC

    *- GetWasPassed() - Return the Was Passed status of the passed parameter
    FUNCTION GetEmpty(cPName)
        LOCAL xRetVal, nRow
        IF UPPER(cPName) == UPPER(THIS.cLastName)
            xRetVal = THIS.bLastWasPassed
        ELSE
            nRow = THIS.Locate(cPName, 1, .T.)
            THIS.bNameFound = BETWEEN(nRow, 1, THIS.nRows)
            IF THIS.bNameFound
                THIS.SetProperties(nRow)
                xRetVal = THIS.bLastWasPassed
            ENDIF
        ENDIF

        * Done
        RETURN xRetVal
    ENDFUNC

    *- SetProperties() - Set our "Last" properties from the passed row
    PROCEDURE SetProperties(nRowNum)
        WITH THIS
            .nLastRow       = nRowNum
            .xLastValue     = .aRA[nRowNum, 2]
            .cLastType      = .aRA[nRowNum, 3]
            .bLastWasEmpty  = .aRA[nRowNum, 4]
            .bLastWasPassed = .aRA[nRowNum, 5]
        ENDWITH
        RETURN
    ENDPROC

    *- LoadParameters() - Load the passed parameters into our array
    FUNCTION LoadParameters(nNumParms, cNm1, xValue1, cNm2, xValue2, cNm3, xValue3, cNm4, xValue4)
        LOCAL nParmCnt, xValue

        * Make sure we know how many parameters we have
        IF VARTYPE(nNumParms) = [N] AND nNumParms > 0
            nParmCnt = nNumParms
        ELSE
            nParmCnt = PCOUNT() - 1
        ENDIF

        * Get the 1st parameter set
        IF nParmCnt >= 2
            xValue = xValue1
        ELSE
            xValue = .F.            && Default value
        ENDIF
        THIS.AddParam(cNM1, xValue, (nParmCnt >= 2) )

        * Get the 2nd parameter set
        IF nParmCnt > 2
            IF nParmCnt >= 4
                xValue = xValue2
            ELSE
                xValue = .F.            && Default value
            ENDIF
            THIS.AddParam(cNM2, xValue, (nParmCnt >= 4) )

            * Get the 3rd parameter set
            IF nParmCnt > 4
                IF nParmCnt >= 6
                    xValue = xValue3
                ELSE
                    xValue = .F.            && Default value
                ENDIF
                THIS.AddParam(cNM3, xValue, (nParmCnt >= 6) )

                * Get the 4rd parameter set
                IF nParmCnt > 6
                    IF nParmCnt = 8
                        xValue = xValue4
                    ELSE
                        xValue = .F.            && Default value
                    ENDIF
                    THIS.AddParam(cNM4, xValue, (nParmCnt = 8) )
                ENDIF
            ENDIF
        ENDIF
        RETURN THIS.nRows
    ENDFUNC

    *- Destroy - Kill our contents
    PROCEDURE Destroy
        LOCAL nX, cName

        * Kill any properties we added
        FOR nX = 1 TO THIS.nRows
            cName = THIS.aRA[nX,1]
            xValue = EVALUATE( [THIS.] + cName)
            IF VARTYPE(xValue) = [O]
                cName = [THIS.] + cName
                STORE NULL TO &cName
            ENDIF
        ENDFOR
        THIS.nRows = 0
        DODEFAULT()
    ENDPROC
ENDDEFINE

*   DirArray Class (parent ArrayObj) - loads array with files matching spec
DEFINE CLASS DirArray AS ArrayObj

    * Array structure definition
    *   .aRA[x,1] - File name (C) (includes extension)
    *   .aRA[x,2] - File size (N):
    *   .aRA[x,3] - File date (D)
    *   .aRA[x,4] - File Time (C)
    *   .aRA[x,5] - File Attributes (C):

    * Standard Properties
    Name = 'DirArray'

    * All ArrayObj properties are the same, but we'll add the file spec
    cFileSpec = ''
    cDirAttr = ''
    nCaseFlag = 0               && VFP's default = 0; make filenames uppercase

    * Custom Method List:
    *- Init() - Initialize our array object
    *- Dir2Array() - Create an array of files matching a passed filespec
    *- AddExts() - Add more files to the array for different extensions
    *- DeleteExts() - Delete all files matching the passed extensions
    *- DeleteFiles() - Remove all files matching the passed list

    * Custom Method Code:

    *- Init() - Initialize our array object
    *     Parameters: cFileSpec [, cAttrib [, cKeepCase]]
    *     Notes: This creates an array of the files matching cFileSpec.  The
    *             array is automatically sized as needed.
    FUNCTION Init(cSpec, cAttr, bStdCase)

        * Do the default Init() for 5 columns
        IF NOT DODEFAULT(5)
            RETURN .F.
        ENDIF

        * Load the array based on the passed file spec
        THIS.Dir2Array(cSpec, cAttr, bStdCase)
        NODEFAULT
        RETURN .T.
    ENDFUNC

    *- Dir2Array() - Create an array of files matching a passed filespec
    *     Parameters: cFileSpec [, cAttrib [, cKeepCase]]
    *     Returns: The number of files found (if 0, THIS.nRows will be 1)
    *     Notes: 1. If called directly, the array must have been initialized
    *                first, but rows and columns may be changed here.
    *            2. Attributes are (also see notes below):
    *                A - Archive (Read and Write), H - Hidden, R - Read only,
    *                S - System, D - Directory, V - Volume Label
    FUNCTION Dir2Array(cDirSpec, cDirAttr, bKeepCase)
        LOCAL nFileCnt, nW, nCase

        * cDirSpec notes - This is any normal DOS file spec (e.g. "*.*") and
        *   it can include drive and directory paths.  However, if cDirSpec
        *   is a null string (and the appropriate attribute letters have also
        *   been sent (see below), you will ONLY get Directory names, Hidden
        *   files or System files.

        * cDirAttr Attribute notes - Generally, this function will return
        *   a list of all files, including Read-Only files, matching
        *   cDirSpec.  If that's all you want, don't use the cDirAttr
        *   parameter.
        * But, for Hidden, System or Directories, use any combination of the
        *   following letters:
        *       Letter        Attribute
        *       컴컴컴        컴컴컴컴�
        *         H            Hidden
        *         S            System
        *         D            Directory
        *   For example, using "HS" would include all Hidden and System files
        *   (in addition to the regular files) but would not include
        *   Directories.
        * For Volume Labels, use only:
        *       Letter        Attribute
        *       컴컴컴        컴컴컴컴�
        *         V            Volume Label
        *   (other letters with "V" will be ignored).

        * bKeepCase notes - By default, VFP converts all filenames into
        *   uppercase. This optional flag allows keeping the current case
        *   used in naming the file.

        * Set our name case flag for ADIR()
        IF PCOUNT() = 3 AND VARTYPE(bKeepCase) = 'L'
            THIS.nCaseFlag = IIF(bKeepCase, 1, 0)
        ENDIF

        * We'll use ADIR() to get the directory info, it will automatically
        *   adjust the size of the array.  But, reset it to 1 row and 5
        *   columns first.
        IF THIS.nCols < 5
            THIS.InsertCols(5 - THIS.nCols)
        ENDIF
        IF THIS.nRows > 0
            THIS.ZapArray()
        ENDIF

        * Save this file spec
        THIS.cFileSpec = cDirSpec

        * We may not have an attribute parameter
        IF TYPE('cDirAttr') = 'C'
            nFileCnt = ADIR(THIS.aRA, cDirSpec, cDirAttr, THIS.nCaseFlag)
            THIS.cDirAttr = cDirAttr
        ELSE
            nFileCnt = ADIR(THIS.aRA, cDirSpec, '', THIS.nCaseFlag)
        ENDIF

        * Our structure is:
        *   .aRA[x,1] - File name (C) (includes extension)
        *   .aRA[x,2] - File size (N):
        *   .aRA[x,3] - File date (D)
        *   .aRA[x,4] - File Time (C)
        *   .aRA[x,5] - File Attributes (C):
        *         Letter        Attribute
        *         컴컴컴        컴컴컴컴�
        *           A            Archive (Read and Write)
        *           H            Hidden
        *           R            Read only
        *           S            System
        *           D            Directory
        *       These may be combined.

        * Do some tweaking of the results
        THIS.nRows = nFileCnt
        IF nFileCnt > 0

            * Clean up time and attributes
            FOR nW = 1 TO nFileCnt

                * Time can have spaces for AM hours
                IF ' ' $ THIS.aRA[nW,4]
                    THIS.aRA[nW,4] = STRTRAN(THIS.aRA[nW,4], ' ', '0')
                ENDIF

                * Attributes come in a form of ".A..."; get rid of the periods
                THIS.aRA[nW,5] = ALLTRIM( STRTRAN( THIS.aRA[nW,5], '.', '') )
            ENDFOR
        ELSE

            * Make sure each column is the right data type
            WITH THIS
                IF VARTYPE( .aRA[1,1] ) <> 'C'
                    .aRA[1,1] = ''
                ENDIF
                IF VARTYPE( .aRA[1,2] ) <> 'N'
                    .aRA[1,2] = 0
                ENDIF
                IF VARTYPE( .aRA[1,3] ) <> 'D'
                    .aRA[1,3] = {}
                ENDIF
                IF VARTYPE( .aRA[1,4] ) <> 'C'
                    .aRA[1,4] = ''
                ENDIF
                IF VARTYPE( .aRA[1,5] ) <> 'C'
                    .aRA[1,5] = ''
                ENDIF
            ENDWITH
        ENDIF

        * Done
        RETURN nFileCnt
    ENDFUNC

    *- AddExts() - Add more files to the array for different extensions
    *     Parameters: cExtList - Comma-delimited list of file extensions to
    *                               add to the array.  Example:
    *                               "FXP,PRG,TXT" - NO SPACES
    *     Returns: The total number of files in the array
    FUNCTION AddExts(cExtList)
        LOCAL cFileSpec, cDirAttr, cExts2Do, nPosn, cExt, nFileCnt, nOldRows, ;
          nX, cTime
        LOCAL aTemp[1]

        * We're passed a comma-delimeted list of file extensions.  We're to
        *   add any new files to our array having those extensions
        WITH THIS
            cFileSpec = .cFileSpec
            cDirAttr = .cDirAttr
            cExts2Do = ALLTRIM(cExtList)
            DO WHILE NOT EMPTY(cExts2Do)

                * Get this extension
                nPosn = AT([,], cExts2Do)
                IF nPosn = 0
                    cExt = cExts2Do
                    cExts2Do = []
                ELSE
                    cExt = LEFT(cExts2Do, nPosn-1)
                    cExts2Do = SUBSTR(cExts2Do, nPosn+1)
                ENDIF

                * Get an array of these files
                cFileSpec = FORCEEXT(cFileSpec, cExt)
                IF NOT EMPTY(cDirAttr)
                    nFileCnt = ADIR(aTemp, cFileSpec, cDirAttr, THIS.nCaseFlag)
                ELSE
                    nFileCnt = ADIR(aTemp, cFileSpec, '', THIS.nCaseFlag)
                ENDIF

                * Re-dimension our array
                IF nFileCnt > 0
                    nOldRows = .nRows
                    .nRows = nOldRows + nFileCnt
                    DIMENSION .aRA(.nRows, 5)

                    * Now, clean up each row as we put it in the array
                    FOR nX = 1 TO nFileCnt

                        * Time needs special handling
                        cTime = aTemp[nX,4]
                        IF ' ' $ cTime
                            cTime = STRTRAN(cTime, ' ', '0')
                        ENDIF

                        * Add this to our array
                        nRow = nX + nOldRows
                        .aRA[nX,1] = aTemp[nX,1]
                        .aRA[nX,2] = aTemp[nX,2]
                        .aRA[nX,3] = aTemp[nX,3]
                        .aRA[nX,4] = cTime
                        .aRA[nX,5] = ALLTRIM( STRTRAN( aTemp[nX,5], '.', '') )
                    ENDFOR
                ENDIF

                * Next extension
            ENDDO
        ENDWITH

        * Done
        RETURN THIS.nRows
    ENDFUNC

    *- DeleteExts() - Remove all files matching the passed extensions
    *     Parameters: cExtList - Comma-delimited list of file extensions to
    *                               remove from the array.  Example:
    *                               "FXP,PRG,TXT" - NO SPACES
    *     Returns: The number of files removed from the array
    FUNCTION DeleteExts(cExtList)
        LOCAL nCnt, nZ, cExt

        * We're passed a comma-delimeted list of file extensions.  We're to
        *   remove all files in our array having those extensions.
        nCnt = 0
        cExtList = ',' + UPPER(cExtList) + ','
        WITH THIS
            FOR nZ = .nRows TO 1 STEP -1
                cExt = ',' + UPPER( TRIM(JUSTEXT( .aRA[nZ,1] ))) + ','
                IF cExt $ cExtList
                    .DeleteRow(nZ)
                    nCnt = nCnt + 1
                ENDIF
            ENDFOR
        ENDWITH

        * Done
        RETURN nCnt
    ENDFUNC

    *- DeleteFiles() - Remove all files matching the passed list
    *     Parameters: cFileList - Comma-delimited list of file names to remove
    *                               from the array.  Example:
    *                               "JUNK.TXT,TEMP.DBF"
    *     Returns: The number of files removed from the array
    FUNCTION DeleteFiles(cFileList)
        LOCAL nCnt, nZ, cFile

        * We're passed a comma-delimeted list of files.  We're to remove
        *   those from our array.
        nCnt = 0
        cFileList = ',' + UPPER(cFileList) + ','
        WITH THIS
            FOR nZ = .nRows TO 1 STEP -1
                cFile = ',' + UPPER( TRIM(.aRA[nZ,1] )) + ','
                IF cFile $ cFileList
                    .DeleteRow(nZ)
                    nCnt = nCnt + 1
                ENDIF
            ENDFOR
        ENDWITH

        * Done
        RETURN nCnt
    ENDFUNC
ENDDEFINE

*   FileLines Class (parent ArrayObj) - loads array with all lines in a file
DEFINE CLASS FileLines AS ArrayObj

    * This is a fast ArrayObj that reads all of the lines in a file into a
    *   single column array. The default line terminator is CR_LF; whatever
    *   terminator is used, it is removed from the line upon loading.

    * Standard Properties
    Name = 'cusFileLines'

    * Line Terminator (removed from line in array)
    cLineEnd = CR_LF
    cFileName = ''

    * Custom Methods:
    *- Init() - Initialize our array object
    *- File2Array() - Load the array from the passed memo string
    *- String2Array() - Load the passed string into the array

    * Custom Method Code:

    *- Init() - Initialize our array object
    *   Parameters: cFileOrStr[, cLineEnd[, bIsString]]
    FUNCTION Init(cFileOrStr, cLineEnd, bIsString)
        IF NOT DODEFAULT(1)
            RETURN .F.
        ENDIF

        * Redefine our line terminator if appropriate
        IF TYPE('cLineEnd') = 'C' AND LEN(cLineEnd) = 1
            THIS.cLineEnd = cLineEnd
        ENDIF

        * Load the array from the passed string (if available)
        DO CASE
        CASE PCOUNT() < 3 AND NOT EMPTY(cFileOrStr)
            THIS.File2Array(cFileOrStr)
        CASE PCOUNT() = 3 AND bIsString
            THIS.String2Array(cFileOrStr)
        ENDCASE
        RETURN .T.
    ENDFUNC

    *- File2Array() - Load the array from the tokenized string
    FUNCTION File2Array(pcFileNm)
        LOCAL cText

        * Save the file name property and get the file's contents
        THIS.cFileName = pcFileNm
        cText =  FILETOSTR(pcFileNm)
        RETURN THIS.String2Array(cText)
    ENDFUNC

    *- String2Array() - Load the passed string into the array
    FUNCTION String2Array(cTextIn)

        * The reason that this is so fast is because it uses VFP's ALINES()
        IF THIS.cLineEnd = CR_LF
            THIS.nRows = ALINES(THIS.aRA, cTextIn)
        ELSE
            THIS.nRows = ALINES(THIS.aRA, cTextIn, .F., THIS.cLineEnd)
        ENDIF

        * Done
        RETURN THIS.nRows
    ENDFUNC
ENDDEFINE

*   StringArray Class (parent ArrayObj) - Array Object to/from string list
DEFINE CLASS StringArray AS ArrayObj

    * Standard Properties
    Name = 'cusStringArray'

    * This is an ArrayObj that can be loaded from a string (one element/row
    *   per token).  It can also regenerate the string.

    * All ArrayObj properties are the same, but we need to define our token
    cToken = '^'        && Default

    * Custom Methods:
    *- Init() - Initialize our array object
    *- String2Array() - Load the array from the tokenized string
    *- Join() - Create a tokenized string from the array
    *- Array2String() - Create a tokenized string from the array

    *- Init() - Initialize our array object
    *   Parameters: cString [, cToken]
    FUNCTION Init( cString, cToken )

        * Do the default Init() for 1 column
        IF NOT DODEFAULT(1)
            RETURN .F.
        ENDIF

        * Redefine our token if appropriate
        IF TYPE('cToken') = 'C' AND LEN(cToken) = 1
            THIS.cToken = cToken
        ENDIF

        * Load the array from the passed string
        THIS.String2Array(cString)
        NODEFAULT
        RETURN .T.
    ENDFUNC

    *- String2Array() - Load the array from the tokenized string
    FUNCTION String2Array( pcString )
        LOCAL cString, nRowsDone, cThisItem

        * THIS.cToken already has the token we'll use
        cString = pcString
        nRowsDone = 0
        DO WHILE NOT EMPTY(cString)
            cThisItem = THIS.ExtrToken( @cString, THIS.cToken )

            * If the row already exists, just change it; else add it
            IF THIS.nRows <= nRowsDone
                THIS.AddRow( cThisItem )
            ELSE
                THIS.aRA[nRowsDone+1] = cThisItem
            ENDIF
            nRowsDone = nRowsDone + 1
        ENDDO

        * If there are more rows, delete them
        DO WHILE THIS.nRows > nRowsDone
            THIS.DeleteRow( THIS.nRows )
        ENDDO

        * Done
    ENDFUNC

    *- Join() - Create a tokenized string from the array
    *   Inputs: cSeparator - Separator between items, can be > 1 char (default
    *               = THIS.cToken)
    FUNCTION Join(cSeparator)
        LOCAL cStr
        cStr = THIS.Array2String(cSeparator)
        RETURN cStr
    ENDFUNC

    *- Array2String() - Create a tokenized string from the array
    *   Inputs: cPicture - Optional, used with TRANSFORM() to generate output
    *           cSeparator - Separator between items, can be > 1 char (default
    *               = THIS.cToken)
    FUNCTION Array2String(cPicture, cSeparator)
        LOCAL cString, nX

        * Make sure we use the right separator
        cSep = THIS.cToken
        IF TYPE('cSeparator') = 'C' AND NOT EMPTY(cSeparator)
            cSep = cSeparator
        ENDIF

        * Define the picture
        cPic = ''
        IF TYPE('cPicture') = 'C'
            cPic = cPicture
        ENDIF

        * Generate the string
        cString = ''
        FOR nX = 1 TO THIS.nRows

            * Define our item (apply the picture if we have one)
            IF EMPTY(cPic)
                cThisItem = THIS.aRA[nX]
            ELSE
                cThisItem = TRANSFORM( THIS.aRA[nX], cPic )
            ENDIF

            * Preface this item with the separator if it's not item #1
            IF nX > 1
                cString = cString + cSep + cThisItem
            ELSE
                cString = cString + cThisItem
            ENDIF
        ENDFOR

        * Done
        RETURN cString
    ENDFUNC
ENDDEFINE

*   MemoArray Class (parent ArrayObj) - Array Object to/from memo
DEFINE CLASS MemoArray AS ArrayObj

    * Standard Properties
    Name = 'cusMemoArray'

    * This is an ArrayObj that can be loaded from a memo field as:
    *   oObj.aRA[x,1] - The line no longer than THIS.nLineWidth
    *   oObj.aRA[x,2] - .T. if the line was terminated with a CR_LF (hard)
    * This can also regenerate the memo.

    * All ArrayObj properties are the same, but we need to define our token
    nLineWidth = 80             && MEMOWIDTH for this object

    * Custom Methods:
    *- Init() - Initialize our array object
    *- Memo2Array() - Load the array from the passed memo string
    *- SplitString() - Split the passed string to the desired length
    *- Array2Memo() - Create a memo string from the array
    *- ChangeLeftMargin() - Change the left margin of the current text
    *- GetLeftMargin() - Return the current left margin of the text

    *- Init() - Initialize our array object
    FUNCTION Init( cMemoStr, nLineWidth )

        * Do the default Init() for 2 columns
        IF NOT DODEFAULT(2)
            RETURN .F.
        ENDIF

        * Define our line width
        IF TYPE('nLineWidth') = 'N' AND nLineWidth > 10
            THIS.nLineWidth = nLineWidth
        ELSE
            nLineWidth = SET('MEMOWIDTH')
            IF nLineWidth > 10
                THIS.nLineWidth = nLineWidth
            ENDIF
        ENDIF

        * Load the array from the passed memo
        THIS.Memo2Array(cMemoStr)
        NODEFAULT
        RETURN .T.
    ENDFUNC

    *- Memo2Array() - Load the array from the passed string
    FUNCTION Memo2Array( pcString )
        LOCAL aMemoLns[1], nLines, nMaxLen, nX, cLine2Do, cLine
        PRIVATE bHardCR

        * Ignore empty incoming strings
        IF NOT EMPTY(pcString)

            * This process uses ALINES() to get each line from the memo into an
            *   array very quickly.  But, that ignores the line length; so, for
            *   longer lines, we'll still have to split them.  (This scheme proved
            *   to be 28% faster than just always calling SplitString() for the
            *   entire memo.

            * Put this into a separate array
            nLines = ALINES(aMemoLns, pcString)

            * Go convert the entire memo
            nMaxLen = THIS.nLineWidth
            FOR nX = 1 TO nLines
                cLine2Do = aMemoLns[nX]
                IF LEN(cLine2Do) <= nMaxLen
                    THIS.AddRow(cLine2Do, .T.)
                ELSE

                    * Split this line
                    DO WHILE NOT EMPTY(cLine2Do)

                        * Extract the next line
                        bHardCR = .F.
                        cLine = THIS.SplitString( @cLine2Do )

                        * Add this to our memo
                        THIS.AddRow(cLine, bHardCR)
                    ENDDO
                ENDIF
            ENDFOR
        ENDIF

        * We're done
        RETURN THIS.nRows
    ENDFUNC

    *- SplitString() - Split the passed string to the desired length
    FUNCTION SplitString( cStrIn )
        LOCAL cStrOut, cWhiteSpace, nSplitPoint

        * Parameter Notes:
        *       cStrIn - The input string to be split (passed as @cStrIn)
        * Operations:
        *       cStrIn is split on spaces as close to THIS.nLineWidth as
        *           possible (if there are no spaces, it's just chopped).
        * Returned values:
        *       cStrOut - Returned as the leftmost part of cStrIn after split
        *       cStrIn - LTRIMmed remainder of cStrIn after split (only if
        *           passed as @cStrIn)
        *       bHardCR - Must be PRIVATE, set based on split type

        * Initialize our return string
        cStrOut = ''
        bHardCR = .F.

        * We may have nothing to do
        IF LEN(cStrIn) <= THIS.nLineWidth AND NOT HEX_FF $ cStrIn
            cStrOut = cStrIn
            cStrIn = ''
            RETURN cStrOut
        ENDIF

        * Define what whitespace looks like
        cWhiteSpace = TAB + CR + LF + HEX_FF

        * Look for the first HEX_FF character.  If that's before
        *   THIS.nLineWidth, extract the string and return.
        nSplitPoint = AT( HEX_FF, cStrIn )
        IF BETWEEN( nSplitPoint, 1, THIS.nLineWidth)
            bHardCR = .T.
            cStrOut = TRIM( LEFT(cStrIn, nSplitPoint-1) )
            cStrIn = SUBSTR(cStrIn, nSplitPoint+1)
            DO WHILE RIGHT( cStrOut, 1) $ cWhiteSpace
                cStrOut = LEFT(cStrOut, LEN(cStrOut)-1)
            ENDDO
        ELSE

            * Otherwise, find the first space character starting at
            *   THIS.nLineWidth and working backwords.
            nSplitPoint = RAT(' ', LEFT(cStrIn, THIS.nLineWidth) )

            * If we didn't find any spaces, just chop it
            IF nSplitPoint = 0
                cStrOut = LEFT(cStrIn,THIS.nLineWidth)
                cStrIn = SUBSTR(cStrIn,THIS.nLineWidth+1)
            ELSE

                * We got a split point, use it
                cStrOut = TRIM( LEFT(cStrIn,nSplitPoint) )
                cStrIn = SUBSTR(cStrIn,nSplitPoint+1)
                DO WHILE RIGHT( cStrOut, 1) $ cWhiteSpace
                    cStrOut = LEFT(cStrOut, LEN(cStrOut)-1)
                ENDDO
            ENDIF
        ENDIF

        * Return our result
        RETURN cStrOut
    ENDFUNC

    *- Array2Memo() - Create a memo string from the array
    FUNCTION Array2Memo( bUseCRLFs )
        LOCAL cRetMemo, nX

        * This will recreate the memo string from the array.
        * If bUseCRLFs = .T., it will use CR_LFs as all line separators
        * Else, it will add either a space or a CR_LF between lines based
        *   on the orginal settings for the memo.
        cRetMemo = ''
        FOR nX = 1 TO THIS.nRows

            * Add a space or CR_LF as needed
            IF nX > 1
                IF bUseCRLFs OR THIS.aRA[nX-1,2]
                    cRetMemo = cRetMemo + CR_LF
                ELSE
                    cRetMemo = cRetMemo + ' '
                ENDIF
            ENDIF

            * Now, add the line
            cRetMemo = cRetMemo + THIS.aRA[nX,1]
        ENDFOR
        RETURN cRetMemo
    ENDFUNC

    *- ChangeLeftMargin() - Change the left margin of the current text
    PROCEDURE ChangeLeftMargin(nNewLMarg, bTossLast)
        LOCAL cText, nMargNow, cAdd, nX, nNewPosn

        * Inputs:
        *   nNewLMarg - Desired new margin
        *   bTossLast - If .T. and the last line is empty, it will be deleted
        * Note: No text is thrown away (see bTossLast for the one exception).
        *       This will first determine the existing left margin and then
        *       add or remove spaces as needed.

        * Toss the last row if we're supposed to and it's empty
        cText = THIS.aRA[THIS.nRows,1]
        IF bTossLast AND EMPTY(cText)
            THIS.DeleteRow(THIS.nRows)
        ENDIF

        * Get the existing left margin
        nMargNow = THIS.GetLeftMargin()

        * Now change the margin as appropriate
        WITH THIS
            DO CASE
            CASE nMargNow < nNewLMarg           && Add spaces
                cAdd = SPACE(nNewLMarg - nMargNow)
                FOR nX = 1 TO THIS.nRows
                    IF NOT EMPTY(.aRA[nX,1])         && Ignore empty rows
                        .aRA[nX,1] =  cAdd + .aRA[nX,1]
                    ENDIF
                ENDFOR
            CASE nMargNow > nNewLMarg           && Remove spaces

                * 1234567890                    WANT = 2
                *      Text starts here         OLD = 5
                *   Text starts here            NEW = 2 = SUBSTR(OLD, 3)
                nNewPosn = (nMargNow - nNewLMarg + 1)
                FOR nX = 1 TO THIS.nRows
                    IF NOT EMPTY(.aRA[nX,1])         && Ignore empty rows
                        .aRA[nX,1] =  SUBSTR(.aRA[nX,1], nNewPosn)
                    ENDIF
                ENDFOR
            ENDCASE
        ENDWITH
        RETURN
    ENDPROC

    *- GetLeftMargin() - Return the current left margin of the text
    FUNCTION GetLeftMargin()
        LOCAL nMarg, nRow, cText, nThisMarg
        nMarg = 1000
        WITH THIS
            FOR nRow = 1 TO .nRows
                cText = .aRA[nRow,1]
                IF EMPTY(cText)         && Ignore empty rows
                    LOOP
                ENDIF
                nThisMarg = AT(LTRIM(cText), cText) - 1
                IF nThisMarg < nMarg
                    nMarg = nThisMarg
                    IF nMarg = 0
                        EXIT
                    ENDIF
                ENDIF
            ENDFOR
        ENDWITH
        RETURN nMarg
    ENDFUNC
ENDDEFINE

*   NamedArrayCol Class (parent ArrayObj) - Array Object with column name access
DEFINE CLASS NamedArrayCol AS ArrayObj

    * Standard Properties
    Name = 'cusNamedArray'

    * We'll add a second array to hold the column names
    DIMENSION aNameRA[1]         && 1 Row/column

    * Custom Methods:
    *- Init() - Initialize our array object
    *- GetVal() - Return a value from a row and column in the array
    *- SaveVal() - Store a value to a row and column in the array
    *- GetNameCol() - Return the column number for a name
    *- LoadColNames() - Load the names of all columns in the array
    *- Load1Name() - Load one column name in the array

    *- Init() - Initialize an array object
    *   Parameters: nCols (REQUIRED for multi-dimensional arrays)
    *     Note - nRows will be 0 after Init()
    FUNCTION Init( nColCnt )
        IF NOT DODEFAULT(nColCnt)
            RETURN .F.
        ENDIF

        * Now, dimension our name array to match the number of columns
        DIMENSION THIS.aNameRA[THIS.nCols]
        STORE '' TO THIS.aNameRA
        NODEFAULT
        RETURN .T.
    ENDFUNC

    *- GetVal() - Return a value from a row and column in the array
    FUNCTION GetVal( nRowNumb, xCol )
        LOCAL nCol

        * xCol can be either a name or a number
        IF TYPE('xCol') = 'C'
            nCol = THIS.GetNameCol(xCol)
        ELSE
            nCol = xCol
        ENDIF
        RETURN THIS.aRA[nRowNumb,nCol]
    ENDFUNC

    *- SaveVal() - Store a value to a row and column in the array
    FUNCTION SaveVal( nRowNumb, xCol, xValue )
        LOCAL nCol

        * xCol can be either a name or a number
        IF TYPE('xCol') = 'C'
            nCol = THIS.GetNameCol(xCol)
        ELSE
            nCol = xCol
        ENDIF
        THIS.aRA[nRowNumb,nCol] = xValue
        RETURN .T.
    ENDFUNC

    *- GetNameCol() - Return the column number for a name
    FUNCTION GetNameCol( cNameStr )
        LOCAL cName, nRowx

        * Make sure it's uppercase
        cName = UPPER( cNameStr )

        * Search thru our name array
        FOR nRowx = 1 TO THIS.nCols     && Main array's col's = name array rows
            IF THIS.aNameRA[nRowx] == cName
                RETURN nRowx
            ENDIF
        ENDFOR

        * If we got here, there was no name match.  Throw a bug
        X_ERRNUM = 6969
        X_ERRMSG = 'Invalid name entry!'
        X_ERRCMD = THIS.Name + '.GetNameCol( ' + cNameStr + ')'
        HANDLERR( X_ERRNUM, PROGRAM(), LINENO(), SYS(16), THIS )
    ENDFUNC

    *- LoadColNames() - Load the names of all columns in the array
    FUNCTION LoadColNames( cNameStr )
        LOCAL nNextCol, cThisName

        * cNameStr is structured as: Name1*Name2*Name3*....
        nNextCol = 0
        DO WHILE nNextCol <= THIS.nCols AND NOT EMPTY(cNameStr)
            nNextCol = nNextCol + 1
            cThisName = THIS.ExtrToken( @cNameStr, '*')
            THIS.aNameRA[nNextCol] = UPPER(cThisName)
        ENDDO
        RETURN nNextCol
    ENDFUNC

    *- Load1Name() - Load one column name in the array
    FUNCTION Load1Name( nColNum, cNameStr )
        THIS.aNameRA[nColNum] = UPPER(cNameStr)
        RETURN .T.
    ENDFUNC
ENDDEFINE

*   NamedArrayCell Class (parent ArrayObj) - Array Object with cell name access
DEFINE CLASS NamedArrayCell AS ArrayObj

    * Standard Properties
    Name = 'cusNamedArrayCell'

    * We'll add a second array to hold the cell names
    DIMENSION aNameRA[1]

    * CAUTION: Cell naming rules are:
    *   1. Each column 1 name must be unique
    *   2. Each name, within a row, must be unique
    * But, this also means that "Name" can be used for Row 2, Col. 3 as well as
    * for Row4, Col. 4.

    * Custom Methods:
    *- Init() - Initialize our array object
    *- GetVal() - Return a value from a row and column in the array
    *- SaveVal() - Store a value to a row and column in the array
    *- IsCellNamed() - Returns .T. if a cell has a name, else .F.
    *- GetNameRow() - Return the row number for a column 1 name
    *- GetNameCol() - Return the column number for a name
    *- CheckArraySizes() - Resize the arrays so they match largest
    *- LoadAllNames() - Load the names of all columns in the array
    *- Load1RowNames() - Load one row's names in the array
    *- Load1Name() - Load one name in the array

    *- Init() - Initialize an array object
    *   Parameters: nCols (REQUIRED for multi-dimensional arrays)
    *     Note - nRows will be 0 after Init()
    FUNCTION Init( nColCnt )
        IF NOT DODEFAULT(nColCnt)
            RETURN .F.
        ENDIF

        * Now, dimension our name array to match
        DIMENSION THIS.aNameRA[ 1, THIS.nCols]
        STORE '' TO THIS.aNameRA
        NODEFAULT
        RETURN .T.
    ENDFUNC

    *- GetVal() - Return a value from a row and column in the array
    FUNCTION GetVal( xRow, xCol )
        LOCAL nRow, nCol

        * xRow can be either a name or a number
        IF TYPE('xRow') = 'C'
            nRow = THIS.GetNameRow(xRow)
        ELSE
            nRow = xRow
        ENDIF

        * xCol can also be either a name or a number
        IF TYPE('xCol') = 'C'
            nCol = THIS.GetNameCol(nRow, xCol)
        ELSE
            nCol = xCol
        ENDIF

        * Return the value
        RETURN THIS.aRA[ nRow, nCol]
    ENDFUNC

    *- SaveVal() - Store a value to a row and column in the array
    FUNCTION SaveVal( xRow, xCol, xValue )
        LOCAL nRow, nCol

        * xRow can be either a name or a number
        IF TYPE('xRow') = 'C'
            nRow = THIS.GetNameRow(xRow)
        ELSE
            nRow = xRow
        ENDIF

        * xCol can also be either a name or a number
        IF TYPE('xCol') = 'C'
            nCol = THIS.GetNameCol(nRow, xCol)
        ELSE
            nCol = xCol
        ENDIF

        * Save the passed value
        THIS.aRA[ nRow, nCol] = xValue
        RETURN .T.
    ENDFUNC

    *- IsCellNamed() - Returns .T. if a cell has a name, else .F.
    FUNCTION IsCellNamed( nRow, nCol )

        * If aNameRA[nRow, nCol] is not empty, we return .T., else .F.
        *   We also return .F. on bad row and column nos.
        IF NOT BETWEEN( nRow, 1, THIS.nRows )
            RETURN .F.
        ENDIF
        IF NOT BETWEEN( nCol, 1, THIS.nCols )
            RETURN .F.
        ENDIF
        RETURN (NOT EMPTY(THIS.aNameRA[nRow,nCol]))
    ENDFUNC

    *- GetNameRow() - Return the row number for a column 1 name
    FUNCTION GetNameRow( cNameStr )
        LOCAL cName, nRowx

        * Make sure it's uppercase
        cName = UPPER( cNameStr )

        * Search thru our name array in Col. 1 only
        FOR nRowx = 1 TO THIS.nRows
            IF THIS.aNameRA[nRowx,1] == cName
                RETURN nRowx
            ENDIF
        ENDFOR

        * If we got here, there was no name match.  Throw a bug
        X_ERRNUM = 6969
        X_ERRMSG = 'Invalid row name entry!'
        X_ERRCMD = THIS.Name + '.GetNameRow("' + cNameStr + '")'
        HANDLERR( X_ERRNUM, PROGRAM(), LINENO(), SYS(16), THIS )
    ENDFUNC

    *- GetNameCol() - Return the column number for a name
    FUNCTION GetNameCol( nRowNum, cNameStr )
        LOCAL cName, nColx

        * Make sure it's uppercase
        cName = UPPER( cNameStr )

        * Search thru our name array in the passed row only
        FOR nColx = 1 TO THIS.nCols
            IF THIS.aNameRA[nRowNum, nColx] == cName
                RETURN nColx
            ENDIF
        ENDFOR

        * If we got here, there was no name match.  Throw a bug
        X_ERRNUM = 6969
        X_ERRMSG = 'Invalid column name entry!'
        X_ERRCMD = THIS.Name + '.GetNameCol("' + cNameStr + '")'
        HANDLERR( X_ERRNUM, PROGRAM(), LINENO(), SYS(16), THIS )
    ENDFUNC

    *- CheckArraySizes() - Resize the arrays so they match largest
    FUNCTION CheckArraySizes()
        LOCAL bAnyChange

        * We're only checking rows here
        DO CASE

        * If the name array is smaller, adjust it
        CASE ALEN(THIS.aNameRA, 1) < ALEN(THIS.aRA, 1)
            DIMENSION THIS.aNameRA[ THIS.nRows, THIS.nCols ]
            bAnyChange = .T.

        * If the main array is smaller, adjust it
        CASE ALEN(THIS.aNameRA, 1) > ALEN(THIS.aRA, 1)
            DO WHILE ALEN(THIS.aNameRA, 1) > ALEN(THIS.aRA, 1)
                THIS.InsertRow()
                bAnyChange = .T.
            ENDDO
        ENDCASE

        * nRows must also match the main array
        IF ALEN(THIS.aRA, 1) <> THIS.nRows
            THIS.nRows = ALEN(THIS.aRA, 1)
        ENDIF
        RETURN bAnyChange
    ENDFUNC

    *- LoadAllNames() - Load the names of all columns in the array
    FUNCTION LoadAllNames( cNameStr )
        LOCAL nNamesDone, nNextRow, cRowNames, nNextCol, cThisName

        * Make sure our array rows match the main array's rows
        THIS.CheckArraySizes()

        * cNameStr is structured as:
        *   1st Row - Name1*Name2*Name3*....*^
        *   2nd Row - Name1*Name2*Name3*....*^, etc.
        * We could have more rows that THIS.nRows
        nNamesDone = 0
        nNextRow = 1
        DO WHILE NOT EMPTY(cNameStr)

            * Get all names for this row
            cRowNames = THIS.ExtrToken( @cNameStr, '^')

            * Here we MAY need another row in our name array.  But, if so
            *   we have to add it to both arrays
            IF ALEN( THIS.aNameRA, 1 ) < nNextRow
                DIMENSION THIS.aNameRA[ nNextRow, THIS.nCols]
                FOR nNextCol = 1 TO THIS.nCols
                    THIS.aNameRA[ nNextRow, nNextCol] = ''
                ENDFOR
                THIS.InsertRow()
            ENDIF

            * Load this row's names in each column
            nNextCol = 0
            DO WHILE nNextCol <= THIS.nCols AND NOT EMPTY(cRowNames)
                nNextCol = nNextCol + 1
                cThisName = THIS.ExtrToken( @cRowNames, '*')
                THIS.aNameRA[nNextRow,nNextCol] = UPPER(cThisName)
                nNamesDone = nNamesDone + 1
            ENDDO

            * Done with this row
            nNextRow = nNextRow + 1
        ENDDO
        RETURN nNamesDone
    ENDFUNC

    *- Load1RowNames() - Load one row's names in the array
    FUNCTION Load1RowNames( nRowNum, cNameStr )
        LOCAL nOldRow, nNextRow, nNextCol, cThisName

        * Make sure we have enough rows in our array
        nOldRow = ALEN( THIS.aNameRA, 1 )
        IF nOldRow < nRowNum
            DIMENSION THIS.aNameRA[ nRowNum, THIS.nCols]
            FOR nNextRow = nOldRow + 1 TO nRowNum
                FOR nNextCol = 1 TO THIS.nCols
                    THIS.aNameRA[ nRowNum, nNextCol] = ''
                ENDFOR
            ENDFOR
            THIS.CheckArraySizes()
        ENDIF

        * cNameStr is structured as: Name1*Name2*Name3*....
        nNextCol = 0
        DO WHILE nNextCol <= THIS.nCols AND NOT EMPTY(cNameStr)
            nNextCol = nNextCol + 1
            cThisName = THIS.ExtrToken( @cNameStr, '*')
            THIS.aNameRA[nRowNum, nNextCol] = UPPER(cThisName)
        ENDDO
        RETURN nNextCol
    ENDFUNC

    *- Load1Name() - Load one name in the array
    FUNCTION Load1Name( nRowNum, nColNum, cNameStr )
        LOCAL nOldRow, nNextRow, nNextCol

        * Make sure we have enough rows in our array
        nOldRow = ALEN( THIS.aNameRA, 1 )
        IF nOldRow < nRowNum
            DIMENSION THIS.aNameRA[ nRowNum, THIS.nCols]
            FOR nNextRow = nOldRow + 1 TO nRowNum
                FOR nNextCol = 1 TO THIS.nCols
                    THIS.aNameRA[ nRowNum, nNextCol] = ''
                ENDFOR
            ENDFOR
            THIS.CheckArraySizes()
        ENDIF

        * Now, load the name
        THIS.aNameRA[nRowNum, nColNum] = UPPER(cNameStr)
        RETURN .T.
    ENDFUNC
ENDDEFINE

*   Collectn Class (parent ArrayObj) - Object Collection class
DEFINE CLASS Collectn AS ArrayObj

    * Properties
    Name = [Collectn]
    nCount = 0                  && Number of items in the collection

    * Array is organized as follows:
    *   .aRA[x,1] - Object/Item to be stored
    *   .aRA[x,2] - Name associated with the item
    *   .aRA[x,3] - Sort value associated with the item

    * Class Notes:
    *   This collection class is for storing any single item (usually objects).
    *   It is NOT for multi-column storage.  However, a name and a sort value
    *   can be associated with each item. Item access is then done by one of 2
    *   methods:
    *       oColl.Item(3) - Returns item stored in row 3
    *       oColl.Item('XYZ') - Returns item whose name is "XYZ"
    *   The collection can be sorted using oColl.SortColl() which sorts by the
    *   sort value.

    * Method Notes:
    *   Add(xItem, cName[, cSortValue]) - Adds an Item to the collection (the
    *       cSortValue is optional.
    *   Item(xKey) - Returns the item stored in the collection by row or name
    *   Remove(xKey) - Removes the item from the collection (by row or name)
    *   SortColl([bDescending[, bCaseInSensitive]]) - Sort the array by sort
    *       value
    *   PrintToFile() - Output our collection's contents to a text file
    * These next 2 only work if the item stored is an object; but otherwise:
    *   GetProperty(cItemNameOrRow, cPropName) - Retrieve an object's property
    *   SetProperty(cItemNameOrRow, cPropName, xNewValue) - Load an object's
    *       property

    * Creating new collection objects can be tedious.  These can help:
    *   SetPropertyNames() - Saves a comma-delimeted list of property names
    *   LoadObject(xValue1, xValue2, ...) - Creates an empty object, assigns
    *       the property names from the saved list, puts in the values, and
    *       adds the item to the collections.
    *   NOTE: This will only work if all objects have the same number of
    *         values. Current limit: 10 properties.

    * Object Properties; only for LoadObject()
    oPropList      = .NULL.         && Property list array object
    cItmNameProp   = ''             && Property for the item name
    cSortValueProp = ''             && Property for the sort value (optional)

    * Block access to other array object properties and methods not needed here
    PROTECTED nRows, nCols, bMultiCol, nSortedCol, nNearRow
    PROTECTED IsEmpty, AddRow, ReplaceRow, InsertRow, DeleteRow, ;
      DeleteRemainingRows, InsertCols, DeleteCol, Sort, MultiColSort, Seek, ;
      Locate, Print, ZapArray

    * Custom Method List
    *- Init() - Initialize an array object
    *- Add() - Add an Item to the collection
    *- Item() - Return an item from the array (returns .F. if not found)
    *- Remove() - Removes the item from the collection (by row or name)
    *- GetProperty() - Retrieve an object's property
    *- SetProperty() - Load an object's property
    *- SortColl() - Sort the array by sort value
    *- SetPropertyNames() - Save a comma-delimeted list of property names
    *- LoadObject() - Add an item of values to our array
    *- PrintToFile() - Output our collection's contents to a text file
    *- PROT PrintObjectProps() - Print an object's properties
    *- PROT GetRow() - Return the row number for a name or column
    *- Destroy() - Remove our components

    * Custom Method Code:

    *- Init() - Initialize an array object
    *   Parameters: [nCols] (REQUIRED for multi-dimensional arrays)
    *     Note - nRows will be 0 after Init()
    FUNCTION Init()
        IF NOT DODEFAULT(3)
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *- Add() - Add an Item to the collection
    FUNCTION Add(xItem, cItmName, cSortValue)
        LOCAL nRow

        * Make sure the name and sort value are characters
        IF VARTYPE(cItmName) <> 'C'
            cItmName = [ ]
        ENDIF
        IF VARTYPE(cSortValue) <> 'C'
            cSortValue = [ ]
        ENDIF

        * Add this to the array
        nRow = THIS.AddRow(xItem, cItmName, cSortValue)
        THIS.nCount = THIS.nRows
        RETURN nRow
    ENDFUNC

    *- Item() - Return an item from the array (returns .F. if not found)
    FUNCTION Item(xKey)
        LOCAL nFndRow, xRetValue

        * This is based on a row (numeric) or a name (character)
        nFndRow = THIS.GetRow(xKey)

        * Now, get the return value
        xRetValue = .F.
        IF nFndRow > 0
            xRetValue = THIS.aRA[nFndRow,1]
        ENDIF
        RETURN xRetValue
    ENDFUNC

    *- Remove() - Removes the item from the collection (by row or name)
    FUNCTION Remove(xKey)
        LOCAL nFndRow

        * This is based on a row (numeric) or a name (character)
        nFndRow = THIS.GetRow(xKey)

        * Now, remove the item
        IF nFndRow > 0
            THIS.aRA[nFndRow,1] = NULL      && Make sure object is gone
            THIS.DeleteRow(nFndRow)
        ENDIF
        THIS.nCount = THIS.nRows
        RETURN THIS.nCount
    ENDFUNC

    *- GetProperty() - Retrieve an object's property
    FUNCTION GetProperty(cItemNameOrRow, cPropName)
        LOCAL oObj, xRetValue
        oObj = THIS.Item(cItemNameOrRow)
        xRetValue = EVAL('oObj.' + cPropName)
        RETURN xRetValue
    ENDFUNC

    *- SetProperty() - Load an object's property
    FUNCTION SetProperty(cItemNameOrRow, cPropName, xNewValue)
        LOCAL oObj
        oObj = THIS.Item(cItemNameOrRow)
        STORE xNewValue TO ('oObj.' + cPropName)
        xRetValue = EVAL('oObj.' + cPropName)
        RETURN xRetValue
    ENDFUNC

    *- SortColl() - Sort the array by sort value
    FUNCTION SortColl(bDesc, bNotCaseSensitive)
        DO CASE
        CASE PCOUNT() = 0
            RETURN THIS.Sort(1)
        CASE PCOUNT() = 1
            RETURN THIS.Sort(1, bDesc)
        ENDCASE
        RETURN THIS.Sort(1, bDesc, bNotCaseSensitive)
    ENDFUNC

    *- PROT GetRow() - Return the row number for a name or column
    PROTECTED FUNCTION GetRow(xKeyTry)
        LOCAL nTheRow
        nTheRow = 0
        DO CASE
        CASE VARTYPE (xKeyTry) = [N]
            IF BETWEEN(xKeyTry, 1, THIS.nRows)
                nTheRow = xKeyTry
            ENDIF
        CASE VARTYPE (xKeyTry) = [C]
            nTheRow = THIS.Locate(xKeyTry, 2, .T.)       && Exact is ON
        ENDCASE
        RETURN nTheRow
    ENDFUNC

    *- SetPropertyNames() - Save a comma-delimeted list of property names
    FUNCTION SetPropertyNames(cPropList, cItmName, cSortValue)

        * Check our parameters
        IF VARTYPE(cItmName) <> 'C'
            cItmName = ''
        ENDIF
        IF VARTYPE(cSortValue) <> 'C'
            cSortValue = ''
        ENDIF

        * Save this as a string list object
        WITH THIS
            .oPropList = CREATEOBJECT('StringArray', cPropList, ',')
            .cItmNameProp = cItmName
            .cSortValueProp = cSortValue
        ENDWITH
        RETURN THIS.oPropList
    ENDFUNC

    *- LoadObject() - Add an item of values to our array
    FUNCTION LoadObject(xVal1, xVal2, xVal3, xVal4, xVal5, xVal6, xVal7, xVal8, xVal9, xVal10)
        LOCAL oObj, nLimit, nX, cValueName, cItmNm, cSortVal

        * We're to:
        *   1. Create an empty object,
        *   2. Assign the property names from the saved list,
        *   3. Load the passed values, and
        *   4. Add the object to this collection

        * Create an empty object
        oObj = CREATEOBJECT('Empty')

        * Go through our property array adding properties and values
        WITH THIS.oPropList
            nLimit = MIN(.nRows, 10)
            FOR nX = 1 TO nLimit
                cValueName = 'xVal' + TRANSFORM(nX)
                ADDPROPERTY(oObj, .aRA[nX], EVAL(cValueName))
            ENDFOR
        ENDWITH

        * What item name shall we use? What Sort Value name?
        WITH THIS
            STORE '' TO cItmNm, cSortVal
            IF NOT EMPTY(.cItmNameProp)
                cItmNm = EVALUATE('oObj.' + THIS.cItmNameProp)
            ENDIF
            IF NOT EMPTY(.cSortValueProp)
                cSortVal = EVALUATE('oObj.' + THIS.cSortValueProp)
            ENDIF
        ENDWITH

        * Add this to our collection
        RETURN THIS.Add(oObj, cItmNm, cSortVal)
    ENDFUNC

    *- PrintToFile() - Output our collection's contents to a text file
    PROCEDURE PrintToFile(cFileName)
        LOCAL cText, nItem, xValue, cName, xSort, cLine

        * We'll put this into a string first, then put it into the file.  Start
        *   with the heading.
        cText = [Collection Contents (] + ;
          ALLTRIM( THIS.XToChar( THIS.nCount ) ) + ' item' + ;
          IIF( THIS.nRows = 1, '', 's') + [):] + CR_LF

        * We have 3 columns for each item.  We'll print them as follows
        *   Collection Contents (10 items):
        *     Item x: <col2>      Sort Value: <col3>
        *       Value: Object, properties: or <col1>
        *         <prop_name>: <prop_value>
        * We'll only print the properties if the value is an object.  And,
        *   we'll figure out the longest property name and make them all the
        *   same length and flush right.
        WITH THIS
            FOR nItem = 1 TO .nCount
                xValue = .aRA[nItem,1]
                cName  = .aRA[nItem,2]
                xSort  = .aRA[nItem,3]

                * Item Line:
                cLine = [  Item ] + TRANSFORM(nItem) + [: ] + cName + ;
                  [      Sort Value: ] + .XToChar(xSort)
                cText = cText + cLine + CR_LF

                * Now, the value
                cLine = [    Value: ]
                IF VARTYPE(xValue) = 'O'
                    cLine = cLine + [Object, properties:]
                ELSE
                    cLine = cLine + .XToChar(xValue)
                ENDIF
                cText = cText + cLine + CR_LF

                * Print the object properties if appropriate
                IF VARTYPE(xValue) = 'O'
                    cLine = .PrintObjectProps(xValue, SPACE(8))
                    cText = cText + cLine
                ENDIF
                IF nItem < .nCount
                    cText = cText + CR_LF       && Blank line between items
                ENDIF
            ENDFOR
        ENDWITH

        * Pop this into a file and we're done
        STRTOFILE(cText, cFileName)
        RETURN cText
    ENDPROC

    *- PROT PrintObjectProps() - Print an object's properties
    PROTECTED FUNCTION PrintObjectProps(oObj, cLMargin)
        LOCAL nPropCnt, aProps[1,5], nNameLen, nX, cName, cPropVals, ;
          cDspName, xValue, cOneProp

        * Get a list of properties for this object
        nPropCnt = AMEMBERS(aProps, oObj, 0)        && 0 = Properties only

        * Find the longest name and note the length
        nNameLen = 0
        FOR nX = 1 TO nPropCnt
            cName = aProps[nX]
            IF LEN(cName) > nNameLen
                nNameLen = LEN(cName)
            ENDIF
        ENDFOR

        * Now, create a string of property names and values
        cPropVals = ''
        FOR nX = 1 TO nPropCnt
            cName = aProps[nX]
            IF LEN(cName) < nNameLen
                cDspName = SPACE(nNameLen - LEN(cName)) + cName + [: ]
            ELSE
                cDspName = cName + [: ]
            ENDIF
            xValue = EVALUATE('oObj.' + cName)
            cOneProp = cLMargin + cDspName + THIS.XToChar(xValue)
            cPropVals = cPropVals + cOneProp + CR_LF
        ENDFOR
        RETURN cPropVals
    ENDFUNC

    *- Destroy() - Remove our components
    PROCEDURE Destroy()
        LOCAL nZ
        WITH THIS
            FOR nZ = 1 TO .nRows
                .aRA[nZ,1] = NULL
            ENDFOR
        ENDWITH
    ENDPROC
ENDDEFINE