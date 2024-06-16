#IF 0                          KStrings.prg

  Purpose:  General purpose String Handling

Revisions:  October 27, 2002 - Ken Green - Original
            10/18/04 - Moved Line2Code() and FormatCode() into a VFP Code
                        Formatting section, added Comm2Code()
            12/20/04 - Added ListMemo()
             1/04/05 - Added DecodeURL() and EncodeURL()
             4/28/05 - Added GetInitials()
            10/06/05 - Added CountPlural()
             2/06/06 - MakeProper() wasn't working properly if the string
                        started with numbers (such as an address)
             3/12/06 - Made this independent of any base class library
             3/14/06 - Added ParseName4ID()
             4/17/06 - ExtrLine() wasn't chopping a line where the 1st space
                        was very early in a commented string.  Changed to chop
                        string if space is < 1/2 the length
             5/10/06 - Changed calls to HANDLERR to just a simple ERROR call,
                        added Error() method
             6/07/06 - Added CleanString(), changed GetInitials() to call that
            10/31/06 - Added optional fill character to IncrNumeric()
            12/01/06 - Added RemoveSpecChar() function
             6/21/07 - Added optional exceptions parameter to CleanString()
            11/12/07 - Added EncryptIt() and DecryptIt() methods
            12/20/07 - Added ExtrNumber(), ExtrPlural(), NormalizeNumber(),
                        ClearEndPunct() and IsNumber() methods
             8/22/08 - In AddQuotes2Text(), switch the simple two if around
            12/04/08 - GetArticle() wasn't paying attention to its 2nd parameter
             3/11/10 - Added Format(), DateFormat(), NumericFormat(),
                        LogicalFormat() methods, xTypeNumber and KNumbers
                        classes
             3/19/10 - Added GetDurationStr(), AddToString(), AllDigits() and
                        AnyDigits() methods
             7/23/10 - Added SetTextLeftMargin() method, changed ASSERTs to
                        ERRORs
            11/04/11 - Changed FormatPhone() to remove any incoming formatting
             1/04/12 - Added LastAt() method
             4/10/12 - Added ClearPunct() method
             9/07/12 - Added StrToHTML() method
            11/30/12 - Refactored ExtrLine() for better accuracy
             2/11/13 - FirstAt() wasn't correctly looking for CR, LFs if
                        they're in pcStrList
             3/04/13 - Changed SetTextLeftMargin() to cleanly handle empty
                        passed text
             5/30/13 - Added ExtrVarValue() method
             4/03/14 - Renamed RemoveSpecChar() to RemoveOddHexChars() but made
                        sure RemoveSpecChar() would still work, changed to
                        remove FFh and 0h characters also (only went 1h - 31h)
             6/23/14 - SetCityStateZip() wasn't adding the dash for long Zip
                        codes
             7/22/14 - Added to ExtrPlural()
             7/28/14 - Minor tweaks to Plural() and GetDurationStr()
             7/28/14 - Added HasLowerCase() method
             1/26/16 - Added HasUpperCase(), GetNextWord(), GetLastWord() and
                        SwapPhrase() methods

****************************** Classes Defined ******************************

* KStrings Class Definition for this function class

******************************* Program Notes *******************************

    The KStrings class is just a front-end object for a function collection.
The goStr object was initialized upon startup.  So, calls to this are really
just method invocations.  For example, to force a string to a certain length,
you'd call this like:
        cNewStr = goStr.MakeLen( cOldStr, 25 )

***************************** Available Methods *****************************

These methods are broken down by categories.  Available categories are:
    Information                         PICTURE Functions
    Extract Parts (of a string)         Type Conversions
    Modify the String                   String Incrementing
    Output Formatting                   Multiple Option Strings
    VFP Code Formatting                 Combining Strings
    Object Functions

Information:
------------
 AllDigits() - Return .T. if the passed string contains only digits
    Input: cTheStr - The string to check
     Retn: .T. if it's all digits, else .F.

 AnyDigits() - Return .T. if the passed string contains ANY digits
    Input: cTheStr - The string to check
     Retn: .T. if there are any digits, else .F.

 IsNumber() - Return .T. if the passed string is a number
    Input: cTheStr - The string to check (pass as @cTheStr if you want
                      the numeric portion)
           cRem - Trailing characters after number (optional; passed as
                      @cRem)
     Retn: .T. if it's a number, else .F.
           cRem has trailing characters if passed as @cRem

 AtNotInDelim() - Return the pos'n of a char NOT within delimeters
    Input: cTheChar - The character in question
           cTheStr  - The string to search
           pcDelim  - The left and right delimeter pair
     Retn: The position (0 if not there or if only within ())

 AtNotInParen() - Return the position of a char in a string outside of any ()
    Input: cTheChar - The character in question
           cTheStr - The string to search
     Retn: The position (0 if not there or if only within ())

 FldsInExpr() - Returns a list of field names within an index expression
    Input: cExpr - The index expression in question
     Retn: List of Field Names

 FirstAt() - Find the first position of some strings in some text
    Input: cStrList - Comma-delimited strings to search for (e.g.
                          "ABC,DEF,GHI")
           cText    - Search for them in this text
           cFndStr  - (optional) if passed as @cFndStr, will contain the
                          string found
     Retn: The position number of one the first string found

 FirstCap() - Return the first number or capital letter of a string
    Input: cStrIn - String for evaluation
     Retn: 1st number or capital letter in string

 Get1stPosn() - Get the 1st position (R or L) of any of some chars
    Input: cCharList - A string of characters to look for
           cLongString - The string to search
           bFromRight - If .T., search starts from right, else from left
     Retn: 1st position number of one of the characters

 GetArg - Return the contents within parentheses for a passed name
    Input: cSrcTxt - String containing "name2(arg)" text
           cFuncName - Function name
           cSepChar - Character separating arguments (e.g. ",")
     Retn: Argument text within the parentheses

 GetArgValue() - Return the Value from a Name=Value clause
    Input: cTextIn - Text containing Name=Value clause (NOTE: Pass this
                      as @cTextIn and the Name=Value clause will be
                      extracted.)
           cName - Name where Value is desired
     Retn: The Value argument after the = sign

 GetArticle() - Return the appropriate article for the passed noun
    Input: cNoun - Noun in question
           bNoFirstCap - .T. if first letter of article should NOT be cap
     Retn: 'A' or 'An'

 GetInitials() - Return the initials for the passed name
    Input: cNameIn - Name from which initials are to be extracted
     Retn: Up to 5 initials within the name

 GetEndingDigits() - Return the trailing digits (if any) in a passed string
    Input: cStr - String in question
     Retn: The trailing digits in the string, e.g. "ABC45DH132" --> "132" or
            "cdefg" --> ""

  HasLowerCase() - Return .T. if the passed string has any lowercase letters
     Input: cStr - String in question
      Retn: .T. if there are any lowercase letters in cStr

  HasUpperCase() - Return .T. if the passed string has any uppercase letters
     Input: cStr - String in question
      Retn: .T. if there are any uppercase letters in cStr


Extract Parts (of a string):
----------------------------
 ExtrNumber() - Extract a number from the beginning of a string
    Input: cStr - String for extraction (passed as @cStr if you want
                      the remainder returned)
     Retn: Number or Numeric Expression extracted from the string
           Remainder in cStr if it was passed as @cStr

 EvalLogicExpr() - Evaluate "Arg" in a Name(Arg) str as .T. (default) or .F.
    Input: cSrcTxt - String containing Name(Arg) clause like:
                      "Name1(arg1), Name2(arg2), ..."
           cFuncName - Name in the Name(Arg) clause
           cClauSep - Character separating multiple clauses (e.g. ",")
     Retn: Extracted clause

 ExtrClauseArg() - Extract a clause argument: (IN clause AS clause)
    Input: cSrcTxt - String for extraction (must be passed as @cStrIn for
                      any extraction to actually take place)
           cIDWord - Word in cSrcText (such as "IN" or "AS")
     Retn: Extracted clause

 ExtrFldName() - Extract the first field name from an expression
    Input: cExpr - String for extraction
     Retn: Extracted field name

 ExtrLine() - Extract a max length line from a large string
    Input: cStrIn - String for extraction (must be passed as @cStrIn for
                      any extraction to actually take place)
           nDesLen - Desired length of string
           pbKillIntEnds - (Optional) .T. if internal blank lines are to
                      be removed (default = .F.)
     Retn: Extracted line
           cStrIn is split on whitespace as close to nDesLen as possible
              (if there is no whitespace, it's just chopped).  Whitespace
              is: spaces, TABs, CRs, LFs, and HEX_FFs.

 IsQuoted() - Return .T. if the string is surrounded by quotes
    Input: cStrIn - String for evaluation
           cQuoteChar - (optional; passed as @cQuoteChar) The quote
                  character use for quotation
     Retn: .T. if the string is quoted and cQuoteChar filled in, or .F.

 ExtrQuoted() - Extract the contents, within quotes, from a string
    Input: cStrIn - String for extraction (must be passed as @cStrIn for
                      any extraction to actually take place)
           cQuoteChar - The quotation character (' or ")
     Retn: Quoted contents
           cStrIn - String without the quoted contents or quotes

 ExtrToken() - Extract and return the text before a passed token (char)
    Input: cStrIn - String for extraction (if passed as @cStrIn, the
                      fragment and token are really extracted)
           pcTokenChar - Character separator
     Retn: Text in cStrIn before the first pcTokenChar

 ExtrVarValue() - Return "Val" from many "VarName=Val^" entries in text
    Input: cVarName - The name of the variable
           cTextIn - The string that might contain a "VarName=Value^"
                      line.
                     Notice that values are terminated with ^s or CRs.
     Retn: The "Val" caluse of the value line

 GetVarValue - Return the value in a "VarName=Val" line
    Input: cValLine - The string containing a "VarName=Val" line.  The
                      string can contain more than one of these but only
                      the value after the first = sign is returned.
     Retn: The "Val" caluse of the value line

 ParseName4ID() - Extract parts of a name for trial as an ID
    Input: cTheName - The name to be parsed
           nMaxLen - The maximum length of the ID
     Retn: An EMPTY object with the following properties:
              .cFirstWord
              .cInitials  (no longer than nMaxLen)
              .cNumber    (no longer than nMaxLen)
              .cFirstLtrs (from the first words; no longer than nMaxLen-1)

 SplitPosition() - Cut a string at the passed position number and return the left side
    Input: cStrIn - The input string to be split (passed as @cStrIn)
           nPosn - The position to cut the string at
     Retn: The LEFT part of the string up to and including nPosn
           cStrIn - RIGHT part of the string starting at nPosn + 1
     Note: If nPosn < 1, the returned string will be empty and pcStrIn
              is unchanged.

 SplitString() - Split the passed string to the desired length
    Input: cStrIn - The input string to be split (passed as @cStrIn)
           nLength - Desired line length
     Retn: String returned as the leftmost part of cStrIn after split
           cStrIn - LTRIMmed remainder of cStrIn after split (only if
                  passed as @cStrIn)
           bHardCR - (must have been setup as PRIVATE) set as .T. if
                  split occurs at HEX_FF
     Note: Will convert CR_LFs to HEX_FFs.

 CleanString() - Remove non-alpha, non-digit, non-space characters
    Input: cStrIn - The input string to be checked
           cExceptions - (optional) Characters to leave in (e.g. ".")
     Retn: String returned with only alpha or digit characters

 GetNextWord() - Extract the next word from a string
    Input: cTextIn - The string to work on - NUST BE PASSED as @cTextIn
                      for the extraction to take place.
           cAddChars - (Optional) Chars to be added to THIS.cWordChars
                       for check.
     Retn: The next word ending at the first non-word character
           cTextIn will have the remaining text starting with that
              non-word character - if passed as @cTextIn.

 GetLastWord() - Extract the last word from a string
    Input: cTextIn - The string to work on - NUST BE PASSED as @cTextIn
                      for the extraction to take place.
           cAddChars - (Optional) Chars to be added to THIS.cWordChars
                       for check.
     Retn: The Last word ending at the first non-word character
           cTextIn will have the text prior to that word - if passed as
              @cTextIn.


Modify the String:
------------------
 SetTextLeftMargin() - Change the left margin of the passed text
    Input: cTextIn - String needing reduced/added margin
           nWantLMarg - Desired new margin
     Retn: cTextIn has spaces at left matching new margin

 NormalizeNumber() - Return a number string in normal form
    Input: cStrIn - Number string to be normalized
     Retn: cStrIn converted 3 significant digits in d.ddEee form

 ClearEndPunct() - Remove ending punctuation characters
    Input: cTheStr - The passed string to de-punctuate (is that a word?)
     Retn: String with trailing punctuation chars removed

 AddQuotes2Text() - Add appropriate quote characters to the passed text
     Input: cStrIn - String that may have embedded quotes
      Retn: cStrIn with quotes added no matter what

 CleanMemo() - Remove a memo's leading lines and trailing white space
    Input: cMemoIn - Memo string to be cleaned up
           cLeadOpt - (optional) Char. that defines what to cleanup:
                  'B' - (default) Cleanup both the start and the end
                  'L' - Only remove completely blank beginning lines
                      (but no other whitespace on a line with real
                      characters)
                  'N' - Don't remove anything from the start; only at
                      the end
     Retn: Cleaned up memo string

 FormatPhone() - Apply the correct formatting to the passed phone
    Input: cPhoneIn - 9999999 or 9999999999 or empty string
     Retn: 999-9999 or (999) 999-9999 or ''

 EncryptIt() - Return an encrypted string
     Input: cStrIn - URL String to be encrypted
      Retn: Encrypted string

 DecryptIt() - Decrypt a string that was encrypted with EncryptIt()
     Input: cStrIn - URL String to be decrypted
      Retn: Decrypted string

 EncodeURL() - Encode a string in an HTML FORM's GET METHOD format
     Input: cStrIn - String to be URL encoded
      Retn: Encoded string

 DecodeURL() - Decode a string in an HTML FORM's GET METHOD format
    Input: cStrIn - URL String to be decoded
     Retn: Decoded string

 FlushLeft() - Return a string with characters moved flush left
    Input: cStrIn - String that may not be flush left
     Retn: cStrIn guaranteed to be flush left

 FlushRight() - Return a string with characters moved flush right
    Input: cStrIn - String that may not be flush right
     Retn: cStrIn guaranteed to be flush right

 FlushRZero() - Return a string with characters flush right, 0-filled
    Input: cStrIn - String that may not be flush right or 0-filled
     Retn: cStrIn guaranteed to be flush right and 0-filled if needed

 ListMemo() - Return a memo converted to CR_LF terminated lines
    Input: pcMemo - Memo field or string
           pnMaxLen - Maximum desired line length
           pcIndentStr - Preface to 2nd and remaining lines
           pbIsDisplay - If .T. and EMPTY(pcMemo), "(none>" is returned, else
    Retn:  str1 + CR_LF +
           pcIndentStr + str2 + CR_LF +
           pcIndentStr + str3 + CR_LF... +
           pcIndentStr + strX

 MakeLen() - Return a string at the desired length (chop or space fill)
    Input: cStrIn - String to have length changed
           pnDesLen - New desired length
           pbAddMT - .T. if "<empty>" should be put in empty strings that
                      are long enough
     Retn: cStrIn at the new length

 MakeProper() - PROPERly capitalize a string IF it's all UC or all LC
    Input: cStrIn - String to be checked
     Retn: String with proper capitalization

 ForceProper() - Convert string to lower, then proper capitalization
    Input: cStrIn - String to be checked
     Retn: String with proper capitalization

 ExtrQuotes() - Return an array object with quoted and non-quoted parts
    Input: cLineIn - String line to be split
     Retn: Array Object with rows for quoted and unquoted lines as:
              oObj.aRA[x,1] = Text part of line
              oObj.aRA[x,2] = .T. if text is quoted

 Plural() - Return the plural form of the passed noun
    Input: cNoun - The singular noun to "pluralize"
           nNumber - The number in question
           cPluralExt - (optional) The string to add to the noun if the
                   number is a plural (default = 's')
     Retn: If nNumber = 1: only the cNoun is returned
           Else: the cNoun + cPluralExt are returned

 CountPlural() - Return the count and plural form of the passed noun
    Input: cNoun - The singular noun to "pluralize"
           nNumber - The number in question
           cPluralExt - (optional) The string to add to the noun if the
                   number is a plural (default = 's')
           bFirstCap - .T. if the first return letter is to be capitalized
     Retn: If nNumber = 0: "no " + cNoun + cPluralExt is returned
           If nNumber = 1: "one " and the cNoun is returned
           Else: the number + cNoun + cPluralExt are returned

 ExtrPlural() - Return the singular form of the passed plural
    Input: cPlural - The plural noun
     Retn: The singular form of that plural

 StrToHTML() - Convert &, <, > chars for HTML output
    Input: cStrIn - Incoming string
    Output: TRIMmed cStrIn where &, < and >s are converted to escaped
            equivalents. If cStrIn is empty, it becomes "&nbsp;".
    CAUTION: Not to be used for INPUT values

 WebTrim() - Trim a string variable for HTML output
    Input: cStrIn - String to be trimmed
     Retn: Trimmed cStrIn, or non-breaking space if cStrIn is empty
     Note: Was HTM_TRIM

 PostTrim() - Trim a string variable and remove artifacts
    Input: cStrIn - String to be checked
     Retn: Trimmed cStrIn with Non-breaking spaces and 0FFhs removed

 PostVal() - Return a numeric after removing artifacts
    Input: cStrIn - String to be checked
     Retn: VAL() of cStrIn after non-breaking spaces and 0FFhs removed

 StripChrs() - Remove one or more characters from a passed string
    Input: cStrIn - String to be checked
           cDelChars - String of characters to be removed
     Retn: String with cDelChars characters removed

 WordWrapString() - Reformat a string with CR_LF lines
    Input: cStrIn - String to be word-wrapped
           pnMaxLinLen - Max. length of a line
           pnIndentSpcs - Prepend this from 2nd line on
           pbKillIntEnds - (Optional) .T. if internal blank lines are to
                      be removed (default = .F.)
     Retn: Word-wrapped string

 SwapPhrase() - Substitute all instances of a word/phrase with a 2nd word/phrase
    Input: cStrIn - String to be word-wrapped
           cPhraseIn - Phrase to be changed
           cNewPhrase - Phrase to be put in plase of cPhraseIn
     Retn: Changed string
    Notes: 1. This is a case-insensitive swap.
           2. cPhraseIn must be within word boundaries at each end


Output Formatting:
------------------
 Format() - Return the passed string with variable values inserted
    Input: cString - String to have variable values inserted. Example:
              {0}, your {1:D} purchase total was {2:c}. Thank you {0}."
                  The curly brackets define the variable number to be
                  inserted (0-based). the : defines formatting codes.
           vPara0, vPara1,...vPara9 - Variables to be converted to
              strings and inserted (up to 9 variables)
     Retn: String with variable values inserted.  For example, if the
           variable values were:
              cUserName   = "Joe"
              dBuyDate    = {03/19/2010}
              nInvoiceAmt = $43.63
           The string would be: "Joe, your March 19, 2010 purchase total
                                 was $43.63. Thank you Joe."

 DateFormat() - Format a Date or DateTime into a string
    Input: dtConvert - Date or DateTime variable to be converted
           cFormat - Formatting codes (see above)
     Retn: String of Date or DateTime converted according to the format

    Formatting Codes are:
      Code      Convert to                    Output Format
      ----    --------------------------  -----------------------------
        d     Short date                  10/12/2002
        D     Long date, short month      Dec. 10, 2002
        L     Long date                   December 10, 2002
        f     Full date & time            December 10, 2002 10:11 PM
        F     Full date & time (long)     December 10, 2002 10:11:29 PM
        g     Default date & time         10/12/2002 10:11 PM
        G     Default date & time (long)  10/12/2002 10:11:29 PM
        M     Month day pattern           December 10
        r     RFC1123 date string         Tue, 10 Dec 2002 22:11:29 GMT
        s     Sortable date string        2002-12-10T22:11:29
        t     Short time                  10:11 PM
        T     Long time                   10:11:29 PM
        u     UTC sortable format*        2002-12-10 22:13:50Z
        U     UTC time (long)*            December 11, 2002 3:13:50 AM
        Y     Year month pattern          December, 2002
      * This format does no conversion from the passed date/time variable - it
        must already be a UTC date or date/time value.

 NumericFormat() - Format a Number or Currency value into a string
    Input: dtConvert - Number or Currency variable to be converted
           cFormat - Formatting codes (see above)
     Retn: String of Number or Currency converted according to the format

    Formatting Codes are (these codes may be followed by an integer, y):
      Codes   Type       y = (default)   Example                      Notes
      -----  ----------- -------------  --------------------------  ---------------
      Cy cy  Currency    Decimals (2)   C2: -123.456 -> ($123.46)   Rounded
      Iy Iy  Integer     Min. digits    I6: -1234 -> -001234        Note 1
      Ey ey  Exponent    Decimals (6)   e3: -1052.9 -> -1.053e+003  Note 2, rounded
      Fy fy  Fixed-pt    Decimals (6)   F4: -1234.56 -> -1234.5600  Rounded
      Gy gy  General     Sig. Digits    G4: 123.4546 -> 123.5       Rounded, 9 max.
      Ny ny  Number      Decimals (2)   N1: 1234.567 -> 1,234.6     Rounded
      Py py  Percent     Decimals (2)   P1: -0.39678 -> -39.7%      Rounded, * 100
      Xy xy  Hexadecimal Min. digits    x4: 255 -> 0x00ff           Note 2
      Notes:
      1. I Format: This is not used in C#. We use it here because the numbers
         to be formatted are supposed to be integers.  However, in C# this is
         called the D(ecimal) format -- which makes no sense to me. Though not
         shown above the D format is implemented in KStrings and it does the
         same thing as the I format.
      2. Note that output letters are the same case as the passed format
         letter.
      3. C# implements a Ry/ry Round-Trip code. Its purpose is to define a
         string that can go on a round-trip and be comverted back to the same
         number. It only applies to Single, Double, and BigInteger numbers.
         That code is not implemented here as it isn't of any use.
      4. For more examples, see Ref\Numeric.txt.

 LogicalFormat() - Format a Logical value into a string
    Input: bValue - Logical value to be converted
           cFormat - Formatting codes (see above)
     Retn: String of Logical converted according to the format

    Formatting Codes are (these codes may be followed by an integer, y):
      Codes   Type            z =          Example            Notes
      -----  ------------- -------------  ------------------  ------
      Tz tz  True or False Chars to show  T4: .F. -> Fals     Note 1
      Yz yz  Yes or No     Chars to show  y3: .F. -> no       Note 1
      Notes:
      1. Note that the first output letter is the same case as the passed
         format letter.


VFP Code Formatting:
--------------------
 Comm2Code() - Format one comment line to fit within a specified length
    Input: cLineIn - Comment line to be formatted
           nMaxLen - Max. length of output string
     Retn: Formatted line with any necessary " ;" line continuations.

 Line2Code() - Format one line of code to fit within a specified length
    Input: cLineIn - String line to be formatted
           nMaxLen - Max. length of output string
     Retn: Formatted line with any necessary " ;" line continuations.
              Quoted strings will be split properly (with quotes at split)

 FormatCode() - Format a block of text as VFP Code with ; carry-overs
    Input: cTextIn - String to be formatted (can be multiple lines)
           nRightMargin - (optional) desired right margin (e.g. max.
                  length of output string - default = 80)
     Retn: Formatted string with any necessary " ;" line continuations.
              Quoted strings will be split properly (with quotes at split)


Object Functions:
-----------------
 PropsToStr() - Put an object's properties into a string
    Input: cStrIn - String to be checked
     Retn: Long string of properties as:
          PROPS START objname objclass FF
          t propname = propval FF
          t propname = propval FF
          .
          .
          t propname = propval FF
          PROPS END objname FF
          where, generally:
              t - variable type
              propname - property name
              propval - property value (converted into a string)
  WARNING: Won't work for General fields, Arrays of Objects or memos
              with internal 0FFh characters

 StrToProps() - Set an object's properties from the passed string
    Input: cPropStr - Property string (see PropsToStr() for format)
           oObj - The object to have its properties set
     Retn: .T. and the Object with its properties set from the string
  WARNING: Won't work for General fields, Arrays of Objects or memos
              with internal 0FFh characters


PICTURE Functions:
------------------
 ClearPict() - Remove all except characters and digits from passed string
    Input: cTheVar - Passed PICTURE string
           pbKeepSpcs - (optional) .T. if you want to keep spaces
     Retn: String with non-formatting chars removed

 GetPicChrs() - Return the text substitute chars in a "PICTURE" string
    Input: cTheVar - Passed PICTURE string
     Retn: String with non-formatting chars removed

 TrimPict() - Remove trailing picture characters from the passed string
    Input: cTheVar - Passed string
     Retn: String with trailing -,./\s removed

 RemoveOddHexChars() - Remove hex characters 0h-31h, 255h except LF, CR, FF
    Input: cMemoIn - Memo string to be cleaned up
           bKillFF - Also remove the Form-Feed character (12h)


Type Conversions:
-----------------
 CharToX() - Convert a string to a variable of the passed type
     Input: cTextIn - String that may have embedded quotes
            cType - Type of conversion desired
      Retn: Desired value

 XToChar() - Convert any value into a string
    Input: xValue - Value to be converted
     Retn: String after conversion

 GetDurationStr() - Return a human readable time string
    Input: xSeconds - Number of elapsed seconds
     Retn: ww days, xx hrs, yy mins and zz secs
     Note: The leading items won't be shown if they're 0

String Incrementing:
--------------------
    Notes: There are 5 incrementing methods.  They all take an input string as
           the starting point and that string length is never changed.  But,
           some functions will fill in spaces within the string if they need
           to.  These are the functions:

 IncrNumbPart() - Increment numbers within a string keeping any chars
      Base 10; no length change, will use spaces on right if needed.
    Input: cStrIn - String to be incremented
     Retn: Incremented String

 IncrNumeric() - Numerically increment a string and 0-fill on left
      Base 10; no length change, will 0-fill from left if needed.
    Input: cStrIn - String to be incremented
           nIncrAmt - (optional) desired incrementing amount (default = 1)
           cLeftFill - (optional) Other left filling character (default = '0')
     Retn: Incremented String

 IncrAlpha() - Alpha- or Alphanum- increment a string and zero-fill on left
      Base 26 (alpha) or 36 (alphanum); no length change, will 0 fill
      (alphanum) or space fill (alpha) from left if needed; ignores
      trailing spaces.
    Input: cStrIn - String to be incremented
           bAlphaOnly - (optional) .T. if base 26 incrementing is wanted,
                          default = .F.
     Retn: Incremented String

 IncrFLStr() - Alphanum- or numerically-increment a flush left string
      Base 36 (alphanum) or 10 (numeric); no length change but spaces on
      the right may be used if needed, no other fills.
    Input: cStrIn - String to be incremented
           cIncrType - (optional) Increment type:
                          'A' - alphanumeric incrementing (base 36)
                          '1' - numeric incrementing (base 10)
                      default is: do an alphanumeric increment if the passed
                      string has any characters, else to do a numeric
                      increment.
     Retn: Incremented String

 IncrFRStr() - Alphanum- or numerically-increment a flush right string
      Base 36 (alphanum) or 10 (numeric); no length change but spaces on
      the left may be used if needed, no other fills.
    Input: cStrIn - String to be incremented
           cIncrType - (optional) Increment type:
                          'A' - alphanumeric incrementing (base 36)
                          '1' - numeric incrementing (base 10)
                      default is to do an alphanumeric increment if the
                      passed string has any characters, else to do a
                      numeric increment.
     Retn: Incremented String


Multiple Option Strings:
------------------------
 GetNextOption() - Extract the next Name:Value pair from an option string
    Input: cOptStr - String of options containing Name=Value pairs like:
                      "Name1=Value1^Name2=Value2^Name3=Value3^..."
           cValue - The option's value (passed as @cValue; default = '')
           cNameSep - (optional) char separating Name and Value (default = ':')
           cOptionSep - (optional) char separating Options (default = '~')
     Retn: The Name of the option; cValue is filled in


Combining Strings:
------------------
 SetCityStateZip() - Return City, State, Zip combined
    Input: cOptStr - String of options containing Name=Value pairs like:
                      "Name1:Value1^Name2:Value2^Name3:Value3^...".  Must
                      be passed as @cOptStr for extraction to take place
           cValue - The option's value (passed as @cValue; default = '')
           cNameSep - (optional) char separating Name and Value (default = ':')
           cOptionSep - (optional) char separating Options (default = '~')
     Retn: The Name of the option; cValue is filled in
     Note: Only string options are used.

 AddToString() - Add string to another with separator if neither is empty
    Input: cStr1 - The starting string
           cStr2 - The string to be added
           cSep - The separator (, ; and so forth)
    Retn: If neither string is empty: cStr1 + cSep + ' ' + cStr2
          If either string is empty, it's just the non-empty string

*****************************************************************************
#ENDIF

* Some Defines
#DEFINE CR           CHR(13)
#DEFINE LF           CHR(10)
#DEFINE CR_LF        CHR(13) + CHR(10)
#DEFINE TAB          CHR(9)
#DEFINE FORMFEED     CHR(12)
#DEFINE HEX_FF       CHR(255)
#DEFINE NBSP         CHR(160)

* Create and return our object
LOCAL oObj
oObj = CREATEOBJECT('KStrings')
RETURN oObj


****************************** Classes Defined ******************************

* KStrings Class Definition for this function class
DEFINE CLASS KStrings AS Custom

    * Standard Properties
    Name = 'KStrings'

    * Custom Properties
    cPictFormatChrs = '@ANXY9#!$'   && PICTURE format directive characters
    cPictTextChrs = '-,./\'         && PICTURE Textual substitution characters
    cWhiteSpace = ' ' + TAB         && What whitespace is within a line
    cLineEnds = CR + LF + HEX_FF    && Line ending chars (also whitespace)
    cWordChars = 'abcdefghijklmnopqrstuvwxyz01234567890'

    * Block the Properties not relevant here
    PROTECTED ClassLibrary, Comment, ControlCount, Controls, Height, Left, ;
      Object, Picture, Tag, Top, Width

    * Block the Methods not relevant here
    PROTECTED AddObject, AddProperty, NewObject, ReadExpression, ReadMethod, ;
      RemoveObject, ResetToDefault, SaveAsClass, WriteExpression, WriteMethod

    * Custom Methods (see list above)

        ***** Information *****

    *- AllDigits() - Return .T. if the passed string contains only digits
    *     Input: cTheStr - The string to check
    *      Retn: .T. if it's all digits, else .F.
    FUNCTION AllDigits(pcTheStr)
        LOCAL cGoodChars, nX

        * Check for the digits
        cGoodChars = '1234567890'
        FOR nX = 1 TO LEN(pcTheStr)
            IF NOT SUBSTR(pcTheStr, nX, 1) $ cGoodChars
                RETURN .F.
            ENDIF
        ENDFOR
        RETURN .T.
    ENDFUNC

    *- AnyDigits() - Return .T. if the passed string contains ANY digits
    *     Input: cTheStr - The string to check
    *      Retn: .T. if there are any digits, else .F.
    FUNCTION AnyDigits(pcTheStr)
        LOCAL cGoodChars, nX

        * Check for the digits
        cGoodChars = '1234567890'
        FOR nX = 1 TO LEN(pcTheStr)
            IF SUBSTR(pcTheStr, nX, 1) $ cGoodChars
                RETURN .T.
            ENDIF
        ENDFOR
        RETURN .F.
    ENDFUNC

    *- IsNumber() - Return .T. if the passed string is a number
    *     Input: cTheStr - The string to check (pass as @cTheStr if you want
    *                       the numeric portion)
    *            cRem - Trailing characters after number (optional; passed as
    *                       @cRem)
    *      Retn: .T. if it's a number, else .F.
    *            cRem has trailing characters if passed as @cRem
    FUNCTION IsNumber(pcTheStr, cRem)
        LOCAL cNumb, cGoodChars, nX

        * Assumption: 8X9216 is NOT a number; 45" IS a number as is 25YARDS

        * We're to:
        *   1. Extract non-numeric trailing characters
        *   2. See if what's left is a number

        * Extract the numeric part
        cRem = pcTheStr
        cNumb = THIS.ExtrNumber(@cRem)
        IF EMPTY(cNumb)     && Not a number
            RETURN .F.
        ENDIF

        * Here, we know we start with a number and cRem has any trailing
        *   characters.  Now, we have to check each digit.
        *   Note: Commas were removed by ExtrNumber()
        cGoodChars = '1234567890+-*/.'
        FOR nX = 1 TO LEN(cNumb)
            IF NOT SUBSTR(cNumb, nX, 1) $ cGoodChars
                RETURN .F.
            ENDIF
        ENDFOR

        * Here, we know it's a number, put it in the passed string
        pcTheStr = cNumb
        RETURN .T.
    ENDFUNC

    *- AtNotInDelim() - Return the pos'n of a char NOT within delimeters
    *     Input: cTheChar - The character in question
    *            cTheStr  - The string to search
    *            pcDelim  - The left and right delimeter pair
    *      Retn: The position (0 if not there or if only within ())
    *      Note: Was AT_DELIM
    FUNCTION AtNotInDelim( pcTheChar, pcTheStr, pcDelim )
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

    *- AtNotInParen() - Return the pos'n of a char NOT within parentheses
    *     Input: cTheChar - The character in question
    *            cTheStr - The string to search
    *      Retn: The position (0 if not there or if only within ())
    *      Note: Was AT_NOPAR
    FUNCTION AtNotInParen( pcTheChar, pcTheStr )
        RETURN THIS.AtNotInDelim( pcTheChar, pcTheStr, '()' )
    ENDFUNC

    *- FldsInExpr() - Returns a list of field names within an index expression
    *     Input: cExpr - The index expression in question
    *      Retn: List of Field Names
    *      Note: Was EXPRFLDS
    FUNCTION FldsInExpr( pcExpr )
        LOCAL cWkgExpr, cFldList, nX, cThisFld

        * First, extract any "FOR" or "UNIQUE" clauses
        cWkgExpr = UPPER( ALLTRIM(pcExpr) )
        IF ' FOR ' $ cWkgExpr
            cWkgExpr = LEFT( cWkgExpr, AT(' FOR ',cWkgExpr)-1 )
        ENDIF
        IF ' UNIQUE' $ cWkgExpr
            cWkgExpr = LEFT( cWkgExpr, AT(' UNIQUE',cWkgExpr)-1 )
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

    *- FirstAt() - Find the first position of some strings in some text
    *     Input: cStrList - Comma-delimited strings to search for (e.g.
    *                           "ABC,DEF,GHI")
    *            cText    - Search for them in this text
    *            cFndStr  - (optional) if passed as @cFndStr, will contain the
    *                           string found
    *      Retn: The position number of one the first string found
    *      Note: Was FIRST_AT
    FUNCTION FirstAt( pcStrList, pcTextIn, pcFoundStr)
        LOCAL nFndPosn, cLookFor, nZ

        * Example:
        *   pcStrList = "ABC,DEF,GHI"
        *               1234567890123456789012345678901
        *   pcTextIn = "Now I know my ABCs.  Oh DEF, GHI it!"
        *   Returns: 14 (position of ABC; DEF is at 24, GHI is at 27)
        *            pcFoundStr = 'ABC'

        * Assume we'll find nothing
        nFndPosn = 0
        pcFoundStr = ''

        * pcStrList is a comma-delimited string of items to search for (e.g.
        *   "ABC,DEF,GHI".  We have to look for each one
        pcTextIn = UPPER(pcTextIn)
        DO WHILE LEN(pcStrList) > 0
            cLookFor = THIS.ExtrToken( @pcStrList, ',')
            nZ = AT( UPPER(cLookFor), pcTextIn )
            IF nZ > 0 AND (nFndPosn = 0 OR nZ < nFndPosn)
                nFndPosn = nZ
                pcFoundStr = cLookFor
            ENDIF
        ENDDO

        * Done
        RETURN nFndPosn
    ENDFUNC

    *- LastAt() - Find the LAST position of some strings in some text
    *     Input: cStrList - Comma-delimited strings to search for (e.g.
    *                           "ABC,DEF,GHI")
    *            cText    - Search for them in this text
    *            cFndStr  - (optional) if passed as @cFndStr, will contain the
    *                           string found
    *      Retn: The position number of one the first string found
    FUNCTION LastAt( pcStrList, pcTextIn, pcFoundStr)
        LOCAL nFndPosn, cLookFor, nZ

        * Example:
        *   pcStrList = "ABC,DEF,GHI"
        *               1234567890123456789012345678901
        *   pcTextIn = "Now I know my ABCs.  Oh DEF, GHI it!"
        *   Returns: 14 (position of ABC; DEF is at 24, GHI is at 27)
        *            pcFoundStr = 'ABC'

        * Assume we'll find nothing
        nFndPosn = 0
        pcFoundStr = ''

        * pcStrList is a comma-delimited string of items to search for (e.g.
        *   "ABC,DEF,GHI".  We have to look for each one
        pcTextIn = UPPER(pcTextIn)
        DO WHILE NOT EMPTY(pcStrList)
            cLookFor = THIS.ExtrToken( @pcStrList, ',')
            nZ = RAT( UPPER(cLookFor), pcTextIn )
            IF nZ > 0 AND (nFndPosn = 0 OR nZ > nFndPosn)
                nFndPosn = nZ
                pcFoundStr = cLookFor
            ENDIF
        ENDDO

        * Done
        RETURN nFndPosn
    ENDFUNC

    *- FirstCap() - Return the first number or capital letter of a string
    *     Input: cStrIn - String for evaluation
    *      Retn: 1st number or capital letter in string
    *      Note: Was FIRSTCAP
    FUNCTION FirstCap( pcStr )
        LOCAL nW, cLtr
        IF EMPTY(pcStr)
            RETURN ''
        ENDIF
        FOR nW = 1 TO LEN(pcStr)
            cLtr = SUBSTR( pcStr, nW, 1)
            IF (UPPER(cLtr) == cLtr AND ISALPHA(cLtr)) OR ISDIGIT(cLtr)
                RETURN cLtr
            ENDIF
        ENDFOR

        * If we didn't find anything, just return the first letter
        RETURN UPPER( LEFT(pcStr,1) )
    ENDFUNC

    *- Get1stPosn()  Get the 1st position (R or L) of any of some chars
    *     Input: cCharList - A string of characters to look for
    *            cLongString - The string to search
    *            bFromRight - If .T., search starts from right, else from left
    *      Retn: 1st position number of one of the characters
    *      Note: Was GET1STPOSN
    FUNCTION Get1stPosn( pcCharList, pcLongString, pbFromRight )
        LOCAL nMinPosn, nListLen, nI, cThisChar, nCharAt

        * We have to return the leftmost position number (non-0) of any
        *   character (in pcCharList) in the string pcLongString.  If
        *   pbFromRight = .T., we need to return the rightmost position.
        nMinPosn = 0
        nListLen = LEN(pcCharList)

        * Look from the Right or Left
        IF pbFromRight
            FOR nI = 1 TO nListLen
                cThisChar = SUBSTR(pcCharList, nI, 1)
                IF cThisChar $ pcLongString
                    nCharAt = RAT(cThisChar, pcLongString)
                    IF nMinPosn = 0 OR nCharAt > nMinPosn
                        nMinPosn = nCharAt
                    ENDIF
                ENDIF
            ENDFOR
        ELSE            && From the left
            FOR nI = 1 TO nListLen
                cThisChar = SUBSTR(pcCharList, nI, 1)
                IF cThisChar $ pcLongString
                    nCharAt = AT(cThisChar, pcLongString)
                    IF nMinPosn = 0 OR nCharAt < nMinPosn
                        nMinPosn = nCharAt
                    ENDIF
                ENDIF
            ENDFOR
        ENDIF
        RETURN nMinPosn
    ENDFUNC

    *- GetArg - Return the contents within parentheses for a passed name
    *     Input: cSrcTxt - String containing "name2(arg)" text
    *            cFuncName - Function name
    *            cSepChar - Character separating arguments (e.g. ",")
    *      Retn: Argument text within the parentheses
    *      Note: Was GET_ARG
    FUNCTION GetArg( pcSrcTxt, pcFuncName, pcSepChar)
        LOCAL nPosn, cSrcRmndr, cSepar, nX, nY, cNounNArg

        * We're passed a block of text (pcSrcTxt) supposedly containing at
        *   least one instance of pcFuncName.  It may also have an argument
        *   within parentheses and will be separated from other functions (and
        *   args) by the pcSepChar.  For example:
        *       pcSrcTxt: "REQD( TYPE = 'A' ), NOEDIT( TYPE = 'E')"
        * But, the control character may exist within the parentheses.  For
        *   example, if the control character is our default: ",":
        *       pcSrcTxt: "REQD( TYPE = 'A' ), VALID( TYPE $ 'EB', 'E or B')"

        * Our job is to get the entire argument for pcFuncName, up to but
        *   excluding the pcSepChar and to return the argument within the
        *   parentheses.

        * If pcFuncName isn't in pcSrcTxt, return quickly
        nPosn = AT( pcFuncName, pcSrcTxt)
        IF nPosn = 0
            RETURN ''
        ENDIF

        * Our name is in pcSrcTxt, get everything from then on
        cSrcRmndr = SUBSTR(pcSrcTxt, nPosn)

        * Remove the function name
        IF LEN(cSrcRmndr) = LEN(pcFuncName)
            RETURN ''
        ELSE
            cSrcRmndr = LTRIM( SUBSTR(cSrcRmndr, LEN(pcFuncName)+1) )
        ENDIF

        * The default cSepar is ","; but use the passed one if appropriate
        cSepar = ','
        IF TYPE('pcSepChar') = 'C' AND LEN(pcSepChar) = 1
            cSepar = pcSepChar
        ENDIF

        * Now, the next character should be the left parenthesis.  But, if we
        *   encounter a control character before that, there is no argument.
        nX = AT('(', cSrcRmndr)
        nY = AT(cSepar, cSrcRmndr)
        IF nX = 0 OR (nY > 0 AND nY < nX)
            RETURN ''
        ENDIF

        * Throw away everything before the left parenthesis
        THIS.ExtrToken( @cSrcRmndr, '(')

        * Return a null string if no no right parenthesis exists.
        IF NOT ')' $ cSrcRmndr
            RETURN ''
        ENDIF

        * Now we want to extract the contents up to the MATCHING right
        *   parenthesis but there may also be embedded parentheses
        nX = goStr.AtNotInParen(')', cSrcRmndr)
        cNounNArg = LEFT(cSrcRmndr, nX-1)

        * Done
        RETURN ALLTRIM( cNounNArg )
    ENDFUNC

    *- GetArgValue() - Return the Value from a Name=Value clause
    *     Input: cTextIn - Text containing Name=Value clause (NOTE: Pass this
    *                       as @cTextIn and the Name=Value clause will be
    *                       extracted.)
    *            cName - Name where Value is desired
    *      Retn: The Value argument after the = sign
    *      Note: Was GETARGVAL
    FUNCTION GetArgValue( pcSrcTxt, pcName )
        LOCAL nY, cValue, cQuote

        * There are many instances of Name=Value clauses in text.  These exist
        * in INI files as well has in HTML text.  Some HTML examples are:
        *   1. <FORM NAME="sol" ACTION="rfqquery.cfm" METHOD=POST>
        *   2. <input type="hidden" name="Query" value="F">
        *   3. <select name=date1>

        * In the above examples, we might want to know the value of the "NAME"
        *   label.  This function returns that value.  Note that in examples
        *   #1 and #2, the NAME value is surrounded by quotes (it isn't in
        *   #3). These quotes are stripped from the value before it's
        *   returned.

        * WARNING: This routine assumes the label's value ends at:
        *   1. If within quotes (" or '), the 2nd instance of the quote
        *   2. Else, the first space or '>' character; whichever comes first

        * Extract everything before the label
        cLeft = ''
        nY = AT( UPPER(pcName), UPPER(pcSrcTxt))
        DO CASE
        CASE nY = 0
            RETURN ''
        CASE nY > 1
            cLeft = TRIM( LEFT(pcSrcTxt, nY-1) )
            cClauseText = SUBSTR(pcSrcTxt, nY)
        OTHERWISE
            cClauseText = pcSrcTxt
        ENDCASE

        * Extract the = sign
        = THIS.ExtrToken( @cClauseText, '=')
        IF cClauseText = ' '
            cClauseText = LTRIM(cClauseText)
        ENDIF

        * Where does our value end.  That's at:
        *   1. If within quotes (" or '), the 2nd instance of the quote
        IF LEFT(cClauseText,1) $ '"' + "'"
            cQuote = LEFT(cClauseText,1)
            cClauseText = SUBSTR(cClauseText,2)
            cValue = THIS.ExtrToken( @cClauseText, cQuote)

        *   2. Else, the first space or '>' character; whichever comes first
        ELSE
            nY = THIS.FirstAt(' ,>', cClauseText)
            DO CASE
            CASE nY = 1
                cValue = ''
            CASE nY = 0
                cValue = cClauseText
                cClauseText = ''
            OTHERWISE   && nY > 0
                cValue = LEFT(cClauseText, nY-1)
            ENDCASE
            IF LEN(cClauseText) = nY
                cClauseText = ''
            ELSE
                cClauseText = SUBSTR(cClauseText,nY+1)
            ENDIF
        ENDIF

        * Put the overall argument back together.  Separate with a space unless
        *   one of them is empty
        IF (NOT EMPTY(cLeft)) AND NOT EMPTY(cClauseText)
            pcSrcTxt = LTRIM(cLeft + ' ' + LTRIM(cClauseText) )
        ELSE
            pcSrcTxt = cLeft + LTRIM(cClauseText)
        ENDIF

        * Done
        RETURN cValue
    ENDFUNC

    *- GetArticle() - Return the appropriate article for the passed noun
    *     Input: cNoun - Noun in question
    *            bNoFirstCap - .T. if first letter of article should NOT be cap
    *      Retn: 'A' or 'An'
    *      Note: Was NOUN_ART
    FUNCTION GetArticle( pcNoun, pbNoFirstCap )
        LOCAL cArticle
        cArticle = 'A '
        IF UPPER( LEFT( LTRIM(pcNoun), 1) ) $ 'AEIOU'
            cArticle = 'An '
        ENDIF
        IF pbNoFirstCap
            cArticle = LOWER(cArticle)
        ENDIF
        RETURN cArticle
    ENDFUNC

    *- GetInitials() - Return the initials for the passed name
    *     Input: cNameIn - Name from which initials are to be extracted
    *      Retn: Up to 5 initials within the name
    FUNCTION GetInitials( cNameIn )
        LOCAL cName, cRetInits, nX

        * Initials are, of course, whatever starts a word; e.g. whatever's at
        *   the beginning and whatever follows a space
        cName = ALLTRIM( cNameIn )
        DO WHILE [  ] $ cName
            cName = STRTRAN(cName, [  ], [ ])
        ENDDO
        cRetInits = ''
        cName = THIS.CleanString(cName)

        * We'll return a maximum of 5 initials
        DO WHILE LEN(cRetInits) < 5
            cRetInits = cRetInits + LEFT( cName, 1)

            * Where's the space?
            nX = AT(' ', cName)
            IF nX = 0

                * There isn't one, so we're done
                EXIT
            ELSE
                cName = LTRIM( SUBSTR(cName, nX) )
            ENDIF
        ENDDO

        * Return our initials
        RETURN UPPER(cRetInits)
    ENDFUNC

    *- GetEndingDigits() - Return the trailing digits (if any) in a string
    *     Input: cStr - String in question
    *      Retn: The trailing digits in the string, e.g. "ABC45DH132" -->
    *               "132" or "cdefg" --> ""
    FUNCTION GetEndingDigits( pcStr )
        LOCAL cRetStr, cChar

        * Go thru the entire string
        cRetStr = ''
        FOR nW = LEN(pcStr) TO 1 STEP -1
            cChar = SUBSTR(pcStr, nW, 1)
            IF ISDIGIT(cChar)
                cRetStr = cChar + cRetStr
            ELSE

                * Not a digit so we're done
                EXIT
            ENDIF
        ENDFOR
        RETURN cRetStr
    ENDFUNC

    *- HasLowerCase() - Return .T. if the passed string has any lowercase letters
    *     Input: cStr - String in question
    *      Retn: .T. if there are any lowercase letters in cStr
    FUNCTION HasLowerCase(cStr)
        LOCAL cChars, nX, cCh
        cChars = 'abcdefghijklmnopqrstuvwxyz'
        FOR nX = 1 TO LEN(cStr)
            cCh = SUBSTR(cStr, nX, 1)
            IF cCh $ cChars
                RETURN .T.
            ENDIF
        ENDFOR
        RETURN .F.
    ENDFUNC

    *-  HasUpperCase() - Return .T. if the passed string has any uppercase letters
    *      Input: cStr - String in question
    *       Retn: .T. if there are any uppercase letters in cStr
    FUNCTION HasUpperCase(cStr)
        LOCAL cChars, nX, cCh
        cChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        FOR nX = 1 TO LEN(cStr)
            cCh = SUBSTR(cStr, nX, 1)
            IF cCh $ cChars
                RETURN .T.
            ENDIF
        ENDFOR
        RETURN .F.
    ENDFUNC


        ***** Extract Parts *****

    *- ExtrNumber() - Extract a number from the beginning of a string
    *     Input: cStr - String for extraction (passed as @cStr if you want
    *                       the remainder returned)
    *      Retn: Number or Numeric Expression extracted from the string
    *            Remainder in cStr if it was passed as @cStr
    FUNCTION ExtrNumber(cStr)
        LOCAL cNumChars, cWhatsLeft, cNumber, nX, cChar

        * Expressions can have the form:
        *   1252 Yards      -30DegC
        *   1/4"
        *   0.375MM
        cNumChars = [01234567890.,+-*/]

        * Go thru the string extracting all numeric expression characters
        cWhatsLeft = cStr
        cNumber = []
        FOR nX = 1 TO LEN(cStr)
            cChar = SUBSTR(cStr, nX, 1)
            IF cChar $ cNumChars

                * Toss any commas - they mess up VAL() conversions
                IF NOT cChar = [,]
                    cNumber = cNumber + cChar
                ENDIF
                cWhatsLeft = SUBSTR(cStr, nX+1)
            ELSE
                EXIT
            ENDIF
        ENDFOR

        * Toss any trailing non-digit in the number
        DO WHILE (NOT EMPTY(cNumber)) AND RIGHT(cNumber, 1) $ [.+-*/]
            cNumber = LEFT(cNumber, LEN(cNumber)-1)
        ENDDO

        * Return whatever's left in the passed parameter
        cStr = cWhatsLeft

        * Return the number
        RETURN cNumber
    ENDFUNC

    *- EvalLogicExpr() - Evaluate "Arg" in a Name(Arg) str as .T. (default) or .F.
    *     Input: cSrcTxt - String containing Name(Arg) clause like:
    *                       "Name1(arg1), Name2(arg2), ..."
    *            cFuncName - Name in the Name(Arg) clause
    *            cClauSep - Character separating multiple clauses (e.g. ",")
    *      Retn: Extracted clause
    *      Note: Was EVAL_ARGB
    FUNCTION EvalLogicExpr( pcSrcTxt, pcFuncName, cClauSep )
        LOCAL cArg

        * Get the argument from the source text
        cArg = THIS.GetArg( @pcSrcTxt, pcFuncName, cClauSep)

        * Throw away any leading "IF "
        IF (NOT EMPTY(cArg)) AND UPPER(LEFT(cArg,3)) = 'IF '
            IF LEN(cArg) = 3
                cArg = ''
            ELSE
                cArg = LTRIM( SUBSTR( cArg, 4 ) )
            ENDIF
        ENDIF

        * If something's there, EVALuate it
        IF NOT EMPTY(cArg)
            RETURN EVAL( cArg )
        ENDIF

        * Our default return value is always .T.
        RETURN .T.
    ENDFUNC

    *- ExtrClauseArg() - Extract a clause argument: (IN clause AS clause)
    *     Input: cSrcTxt - String for extraction (must be passed as @cStrIn for
    *                       any extraction to actually take place)
    *            cIDWord - Word in cSrcText (such as "IN" or "AS")
    *      Retn: Extracted clause
    *      Note: Was EXTR_CLS
    FUNCTION ExtrClauseArg(pcSrcTxt, pcIDWord)
        LOCAL nPosn, cClause, cRetCls

        * We're passed a block of text (pcSrcTxt) containing a number of ID
        *   Words with following clauses.  For example:
        *           "IN ITEMS AS ITEM_NUMB"
        *   The ID words and clauses, in this case are:
        *       #1: ID: "IN", Clause: "ITEMS"
        *       #2: ID: "AS", Clause: "ITEM_NUMB"
        *   The key separators are spaces.
        * We're passed the ID Word.  Our job is to extract and return the ID
        *   Word and it's clause from the passed string.

        * Our ID word could be within a clause in the string.  (If the word is
        *   "IN" and we have a string: "AS FINAN_NTS".)  So, we have to be
        *   careful that we check for: ' ' + pcIDWord + ' '.  Of course, it
        *   could be at the beginning of the string, in which case we wouldn't
        *   have the leading space.
        nPosn = AT(' ' + pcIDWord + ' ', pcSrcTxt)
        IF nPosn = 0
            nPosn = AT(pcIDWord + ' ', pcSrcTxt)
            IF nPosn > 1
                nPosn = 0
            ENDIF
        ELSE
            nPosn = nPosn + 1
        ENDIF

        * If the ID word isn't in the string, return quickly
        IF nPosn = 0
            RETURN ''
        ENDIF

        * OK, we've found our ID Word at nPosn.  Remove earlier parts of the
        *   string
        cClause = SUBSTR(pcSrcTxt, nPosn)
        IF nPosn = 1
            pcSrcTxt = ''
        ELSE
            pcSrcTxt = LEFT(pcSrcTxt, nPosn-1 )
        ENDIF

        * Extract our ID Word and our clause from the remainder.  Note that
        *   our "separators" are spaces.
        THIS.ExtrToken( @cClause, ' ')
        cRetCls = THIS.ExtrToken( @cClause, ' ')

        * Add whatever's left back into the source string
        pcSrcTxt = pcSrcTxt + cClause

        * We're done
        RETURN cRetCls
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
        RETURN cRetName
    ENDFUNC

    *- ExtrLine() - Extract a max length line from a large string
    *     Input: cStrIn - String for extraction (must be passed as @cStrIn for
    *                       any extraction to actually take place)
    *            nDesLen - Desired length of string
    *            pbKillIntEnds - (Optional) .T. if internal blank lines are to
    *                       be removed (default = .F.)
    *      Retn: Extracted line
    *            cStrIn is split on whitespace as close to nDesLen as possible
    *               (if there is no whitespace, it's just chopped).  Whitespace
    *               is: spaces and TABs; line ends are: CRs, LFs, and HEX_FFs.
    *      Note: Was EXTR_LINE and WORDTRIM
    FUNCTION ExtrLine( pcStrIn, pnDesLen, pbKillIntEnds )
        LOCAL cStrIn, cStrOut, cLineEnds, cWhiteSpc, bHasLine, nX, cFragment, ;
          nSplitPoint, bKillChar

        * Function Example:
        *       * Print the 150 character DESCR in 35 char lines
        *       cToPrint = TRIM(DESCR)
        *       DO WHILE NOT EMPTY(cToPrint)
        *           cPrtLine = goStr.ExtrLine( @cToPrint, 35)
        *           @ x,y SAY cPrtLine
        *           x = x + 1
        *       ENDDO

        * Initialize our return string
        cStrOut = ''

        * Bug if pnDesLen isn't > 0
        IF pnDesLen < 1
            ERROR [goStr.ExtrLine() Des. Length must be > 0]
        ENDIF

        * Define what we mean by white space and line ends
        cLineEnds = THIS.cLineEnds
        cWhiteSpc = THIS.cWhiteSpace

        * Find the first line ending character
        nEndPosn = THIS.Get1stPosn(cLineEnds, pcStrIn)
        DO WHILE BETWEEN(nEndPosn, 1, pnDesLen)
            cChar = SUBSTR(pcStrIn, nEndPosn, 1)
            cStrOut = LEFT(pcStrIn, nEndPosn-1)     && Toss line ending char
            pcStrIn = SUBSTR(pcStrIn, nEndPosn+1)

            * If the line ended with a CR, toss the next LF character
            IF cChar = CR AND pcStrIn = LF
                pcStrIn = SUBSTR(pcStrIn, 2)
            ENDIF

            * If we're to kill internal blank lines, keep going
            IF nEndPosn = 1 AND pbKillIntEnds AND NOT EMPTY(pcStrIn)
                nEndPosn = THIS.Get1stPosn(cLineEnds, pcStrIn)
                LOOP
            ENDIF
            RETURN cStrOut
        ENDDO

        * Here we have no line ends within the desired length. So, get a
        *   of the string no longer than pnDesLen
        IF LEN(pcStrIn) <= pnDesLen
            cFragment = pcStrIn
        ELSE
            cFragment = LEFT(pcStrIn, pnDesLen)
        ENDIF

        * Find the last white space in the line (.T. = last one)
        nSplitPoint = THIS.Get1stPosn(cWhiteSpc, cFragment, .T.)

        * Act on that result
        DO CASE

        * No white space at all or if the split point is too small, just chop it
        CASE nSplitPoint = 0 OR nSplitPoint < (pnDesLen/2)
            cStrOut = LEFT(pcStrIn,pnDesLen)
            pcStrIn = SUBSTR(pcStrIn,pnDesLen+1)

        * Last space matches the desired length
        CASE nSplitPoint = LEN(pcStrIn)
            cStrOut = pcStrIn
            pcStrIn = ''

        * We got a split point, use it
        OTHERWISE
            cStrOut = LEFT(pcStrIn, nSplitPoint)        && Don't trim
            pcStrIn = LTRIM( SUBSTR(pcStrIn,nSplitPoint+1) )
        ENDCASE

        * Return our result
        RETURN cStrOut
    ENDFUNC

    *- IsQuoted() - Return .T. if the string is surrounded by quotes
    *     Input: cStrIn - String for evaluation
    *            cQuoteChar - (optional; passed as @cQuoteChar) The quote
    *                   character use for quotation
    *      Retn: .T. if the string is quoted and cQuoteChar filled in, or .F.
    FUNCTION IsQuoted( pcStrIn, pcQuoteChar )
        LOCAL cLeftChar, cRightChar

        * Handle the trivial situation first
        IF EMPTY(pcStrIn)
            RETURN .F.
        ENDIF

        * There are only 2 kinds of quote characters: "" ''.  We won't use
        *   [] as they're string delimiters - not quotation characters
        cLeftChar = LEFT(pcStrIn,1)
        cRightChar = RIGHT(pcStrIn,1)

        * Test for quotations
        DO CASE
        CASE cLeftChar = ['] AND cRightChar = [']
            pcQuoteChar = [']
            RETURN .T.
        CASE cLeftChar = ["] AND cRightChar = ["]
            pcQuoteChar = ["]
            RETURN .T.
        ENDCASE
        RETURN .F.
    ENDFUNC

    *- ExtrQuoted() - Extract the contents, within quotes, from a string
    *     Input: cStrIn - String for extraction (must be passed as @cStrIn for
    *                       any extraction to actually take place)
    *            cQuoteChar - The quotation character (' or ")
    *      Retn: Quoted contents
    *            cStrIn - String without the quoted contents or quotes
    *      Note: Was EXTRQUOT
    FUNCTION ExtrQuoted( pcStrIn, pcQuoteChar )
        LOCAL cLeftSide, cRightSide, cTheWord, nX

        * Setup
        STORE '' TO cLeftSide, cRightSide, cTheWord

        * Look for the first instance of the quote
        nX = AT(pcQuoteChar, pcStrIn)
        IF nX > 0
            IF nX = 1
                cRightSide = SUBSTR(pcStrIn, 2)
            ELSE
                cLeftSide = LEFT(pcStrIn, nX-1)
                cRightSide = SUBSTR(pcStrIn, nX+1)
            ENDIF

            * Here, cLeftSide has the string before the quote and cRightSide
            *   has the string after the quote (the quote is gone).  Look for
            *   the next instance of the quote
            nX = AT(pcQuoteChar, cRightSide)
            IF nX > 0
                IF nX = 1
                    cRightSide = SUBSTR(cRightSide, 2)
                ELSE
                    cTheWord = LEFT(cRightSide, nX-1)
                    cRightSide = SUBSTR(cRightSide, nX+1)
                ENDIF
            ENDIF   && nX > 0

            * Put the string back together
            pcStrIn = cLeftSide + cRightSide
        ENDIF   && nX > 0
        RETURN cTheWord
    ENDFUNC

    *- ExtrToken() - Extract and return the text before a passed token (char)
    *     Input: cStrIn - String for extraction (if passed as @cStrIn, the
    *                       fragment and token are really extracted)
    *            pcTokenChar - Character separator
    *      Retn: Text in cStrIn before the first pcTokenChar
    *     Tests: 1: ExtrToken('AB^CD', '^') --> 'AB'
    *            2: cVar = '123.45'
    *               ExtrToken( @cVar, '.') --> '123'
    *               cVar now = '45'
    *      Note: Was EXTR_TKN
    FUNCTION ExtrToken( pcStrIn, pcTokenChar )
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

    *- ExtrVarValue() - Return "Val" from many "VarName=Val^" entries in text
    *     Input: cVarName - The name of the variable
    *            cTextIn - The string that might contain a "VarName=Value^"
    *                       line.
    *                      Notice that values are terminated with ^s or CRs.
    *      Retn: The "Val" caluse of the value line
    FUNCTION ExtrVarValue(cVarName, cTextIn)
        LOCAL nPosn, cRemText, cEndChar, cRetVal

        * Find the name
        nPosn = AT( UPPER(cVarName) + '=', UPPER(cTextIn))
        IF nPosn = 0
            RETURN ''
        ENDIF

        * Extract the "VarName=Value" line
        cRemText = SUBSTR(cTextIn, nPosn)
        cEndChar = ''
        THIS.FirstAt('^,' + CR, cRemText, @cEndChar)
        cRetVal = goStr.ExtrToken(cRemText, cEndChar)

        * Get the value after the '=' sign
        THIS.ExtrToken(@cRetVal, '=')
        RETURN cRetVal
    ENDFUNC

    *- GetVarValue - Return the value in a "VarName=Val" line
    *     Input: cValLine - The string containing a "VarName=Val" line.  The
    *                       string can contain more than one of these but only
    *                       the value after the first = sign is returned.
    *      Retn: The "Val" caluse of the value line
    *      Note: Was GETPROP_VAL
    FUNCTION GetVarValue( pcValLine )
        LOCAL cRetVal, nX

        * Get the value after the '=' sign
        cRetVal = pcValLine
        THIS.ExtrToken( @cRetVal, '=')

        * If we have a CR_LF, chop it just before that
        nX = AT(CR_LF, cRetVal)
        IF nX > 0
            cRetVal = LEFT( cRetVal, nX-1 )
        ENDIF
        RETURN cRetVal
    ENDFUNC

    *- ParseName4ID() - Extract parts of a name for trial as an ID
    *     Input: cTheName - The name to be parsed
    *            nMaxLen - The maximum length of the ID
    *      Retn: An EMPTY object with the following properties:
    *               .cFirstWord
    *               .cInitials  (no longer than nMaxLen)
    *               .cNumber    (no longer than nMaxLen)
    *               .cFirstLtrs (from the first words; no longer than nMaxLen-1)
    FUNCTION ParseName4ID(cTheName, nMaxLen)
        LOCAL oRetObj, cClnName, oWords, cName2Do, cWord, cFirstWord, cInits, ;
          cNumber, nW, bAllDigits, nZ

        * Create an object to return
        oRetObj = CREATEOBJECT('Empty')

        * Get rid of all except characters, digits and spaces from the name
        *   (.T. = keep spaces)
        cClnName = UPPER( ALLTRIM( goStr.ClearPict( cTheName, .T. ) ))
        DO WHILE '  ' $ cClnName
            cClnName = STRTRAN( cClnName, '  ', ' ' )
        ENDDO

        * Put all words into an array
        oWords = CREATEOBJECT('ArrayObj', 1)
        cName2Do = cClnName
        DO WHILE NOT EMPTY(cName2Do)
            cWord = goStr.ExtrToken(@cName2Do, [ ])
            IF NOT EMPTY(cWord)
                oWords.AddRow(cWord)
            ENDIF
        ENDDO

        *   1. Extract the first word in the name
        cFirstWord = oWords.aRA[1]
        ADDPROPERTY(oRetObj, 'cFirstWord', cFirstWord)

        *   2. Extract possible initials
        cInits = goStr.GetInitials( cClnName )
        IF LEN(cInits) > nMaxLen
            cInits = LEFT(cInits, nMaxLen)
        ENDIF
        ADDPROPERTY(oRetObj, 'cInitials', cInits)

        *   3. Try to extract any integral number <= nMaxLen
        cNumber = []
        FOR nW = 1 TO oWords.nRows
            cWord = oWords.aRA[nW]
            IF LEN(cWord) <= nMaxLen
                bAllDigits = .T.
                FOR nZ = 1 TO LEN(cWord)
                    IF NOT ISDIGIT( SUBSTR(cWord, nZ, 1) )
                        bAllDigits = .F.
                        EXIT
                    ENDIF
                ENDFOR
                IF bAllDigits AND LEN(cWord) > LEN(cNumber)
                    cNumber = cWord
                ENDIF
            ENDIF
        ENDFOR
        ADDPROPERTY(oRetObj, 'cNumber', cNumber)

        *   4. Extract the first (nMaxLen-1) letters from the name
        cWord = cFirstWord
        IF LEN(cFirstWord) < nMaxLen-1
            IF oWords.nRows > 1
                cWord = cWord + oWords.aRA[2]
            ENDIF
        ENDIF
        cWord = LEFT(cWord, nMaxLen-1)
        ADDPROPERTY(oRetObj, 'cFirstLtrs', cWord)

        * We're done
        RETURN oRetObj
    ENDFUNC

    *- SplitPosition() - Cut a string at the passed position number and return the left side
    *     Input: cStrIn - The input string to be split (passed as @cStrIn)
    *            nPosn - The position to cut the string at
    *      Retn: The LEFT part of the string up to and including nPosn
    *            cStrIn - RIGHT part of the string starting at nPosn + 1
    *      Note: If nPosn < 1, the returned string will be empty and pcStrIn
    *               is unchanged.  Was CUT_STRP
    FUNCTION SplitPosition( pcStrIn, nPosn)
        LOCAL cRetStr

        * Examples of use:
        *   Given a string: "ABCDEFGHIJK" we want to cut it at position
        *       5 so that from F on will be in the second string.
        *           cMyStr = "ABCDEFGHIJK"
        *           cLeftStr = goStr.SplitPosition( @cMyStr, 5 )
        *   Result:              12345
        *           cMyStr:     "ABCDE"
        *           cLeftStr:   "FGHIJK"

        * Trivial stuff first
        IF EMPTY( pcStrIn ) OR nPosn > LEN(pcStrIn)
            RETURN ''
        ENDIF
        DO CASE
        CASE nPosn < 1
            cRetStr = ''
        CASE nPosn = LEN(pcStrIn)
            cRetStr = pcStrIn
            pcStrIn = ''
        OTHERWISE
            cRetStr = LEFT(pcStrIn, nPosn)
            pcStrIn = SUBSTR(pcStrIn, nPosn+1 )
        ENDCASE
        RETURN cRetStr
    ENDFUNC

    *- SplitString() - Split the passed string to the desired length
    *     Input: cStrIn - The input string to be split (passed as @cStrIn)
    *            nLength - Desired line length
    *      Retn: String returned as the leftmost part of cStrIn after split
    *            cStrIn - LTRIMmed remainder of cStrIn after split (only if
    *                   passed as @cStrIn)
    *            bHardCR - (must have been setup as PRIVATE) set as .T. if
    *                   split occurs at HEX_FF
    *      Note: Will convert CR_LFs to HEX_FFs.  Was SPLITSTR
    FUNCTION SplitString( pcStrIn, pnLength )
        LOCAL cStrOut, cWhiteSpc, nSplitPoint

        * Initialize our return string
        cStrOut = ''
        bHardCR = .F.
        cWhiteSpc = THIS.cWhiteSpace + THIS.cLineEnds

        * Convert any CR_LFs to HEX_FFs
        IF CR_LF $ pcStrIn
            pcStrIn = STRTRAN(pcStrIn, CR_LF, HEX_FF)
        ENDIF

        * We may have nothing to do
        IF LEN(pcStrIn) <= pnLength AND NOT HEX_FF $ pcStrIn
            cStrOut = pcStrIn
            pcStrIn = ''
            RETURN cStrOut
        ENDIF

        * Look for the first HEX_FF character.  If that's before
        *   pnLength, extract the string and return.
        nSplitPoint = AT( HEX_FF, pcStrIn )
        IF BETWEEN( nSplitPoint, 1, pnLength)
            bHardCR = .T.
            cStrOut = TRIM( LEFT(pcStrIn, nSplitPoint-1) )
            pcStrIn = LTRIM( SUBSTR(pcStrIn, nSplitPoint+1) )
            DO WHILE RIGHT( cStrOut, 1) $ cWhiteSpc
                cStrOut = LEFT(cStrOut, LEN(cStrOut)-1)
            ENDDO
        ELSE

            * Otherwise, find the first space character starting at
            *   pnLength and working backwords.
            nSplitPoint = RAT(' ', LEFT(pcStrIn, pnLength) )

            * If we didn't find any spaces, just chop it
            IF nSplitPoint = 0
                cStrOut = LEFT(pcStrIn,pnLength)
                pcStrIn = SUBSTR(pcStrIn,pnLength+1)
            ELSE

                * We got a split point, use it
                cStrOut = TRIM( LEFT(pcStrIn,nSplitPoint) )
                pcStrIn = LTRIM( SUBSTR(pcStrIn,nSplitPoint+1) )
                DO WHILE RIGHT( cStrOut, 1) $ cWhiteSpc
                    cStrOut = LEFT(cStrOut, LEN(cStrOut)-1)
                ENDDO
            ENDIF
        ENDIF

        * Return our result
        RETURN cStrOut
    ENDFUNC

    *- CleanString() - Remove non-alpha, non-digit, non-space characters
    *     Input: cStrIn - The input string to be checked
    *            cExceptions - (optional) Characters to leave in (e.g. ".")
    *      Retn: String returned with only alpha or digit characters
    FUNCTION CleanString(cStrIn, cExceptions)
        LOCAL cRetStr, nLen, nX, cChar

        * Check our optional parameter and add a space to the exceptions
        DO CASE
        CASE PCOUNT() = 1 OR VARTYPE(cExceptions) <> 'C'
            cExceptions = [ ]
        CASE NOT [ ] $ cExceptions
            cExceptions = cExceptions + [ ]
        ENDCASE

        * Check each character
        cRetStr = []
        nLen = LEN(cStrIn)
        FOR nX = 1 TO nLen
            cChar = SUBSTR(cStrIn, nX, 1)
            IF ISALPHA(cChar) OR ISDIGIT(cChar) OR cChar $ cExceptions
                cRetStr = cRetStr + cChar
            ENDIF
        ENDFOR
        RETURN cRetStr
    ENDFUNC

    *- GetNextWord() - Extract the next word from a string
    *     Input: cTextIn - The string to work on - NUST BE PASSED as @cTextIn
    *                       for the extraction to take place.
    *            cAddChars - (Optional) Chars to be added to THIS.cWordChars
    *                        for check.
    *      Retn: The next word ending at the first non-word character
    *            cTextIn will have the remaining text starting with that
    *               non-word character - if passed as @cTextIn.
    FUNCTION GetNextWord(cText, cAddChars)
        LOCAL cWordChars, cRetWord, cChar

        * This is a simple chaaracter search but they might have added
        *   characters for identifiers.
        cWordChars = THIS.cWordChars
        IF VARTYPE(cAddChars) = 'C'
            cWordChars = cWordChars + cAddChars
        ENDIF

        * Go to it
        cRetWord = ''
        DO WHILE NOT EMPTY(cText)

            * Extract the character
            cChar = LEFT(cText, 1)
            cText = SUBSTR(cText, 2)

            * Is it a word char?
            IF LOWER(cChar) $ cWordChars
                cRetWord = cRetWord + cChar
            ELSE

                * Non-word character; put it back in and we're done
               cText = cChar + cText
               EXIT
            ENDIF
        ENDDO
        RETURN cRetWord
    ENDFUNC

    *- GetLastWord() - Extract the last word from a string
    *     Input: cTextIn - The string to work on - NUST BE PASSED as @cTextIn
    *                       for the extraction to take place.
    *            cAddChars - (Optional) Chars to be added to THIS.cWordChars
    *                        for check.
    *      Retn: The Last word ending at the first non-word character
    *            cTextIn will have the text prior to that word - if passed as
    *               @cTextIn.
    FUNCTION GetLastWord(cText, cAddChars)
        LOCAL cWordChars, cRetWord, cChar

        * This is a simple chaaracter search but they might have added
        *   characters for identifiers.
        cWordChars = THIS.cWordChars
        IF VARTYPE(cAddChars) = 'C'
            cWordChars = cWordChars + cAddChars
        ENDIF

        * Go to it
        cRetWord = ''
        DO WHILE NOT EMPTY(cText)

            * Extract the last character
            cChar = RIGHT(cText, 1)
            cText = LEFT(cText, LEN(cText)-1)

            * Is it a word char?
            IF LOWER(cChar) $ cWordChars
                cRetWord = cChar + cRetWord
            ELSE

                * Non-word character; put it back in and we're done
               cText = cChar + cText
               EXIT
            ENDIF
        ENDDO
        RETURN cRetWord
    ENDFUNC


        ***** Modify the String *****

    *- SetTextLeftMargin() - Change the left margin of the passed text
    *     Input: cTextIn - String needing reduced/added margin
    *            nWantLMarg - Desired new margin
    *      Retn: cTextIn has spaces at left matching new margin
    FUNCTION SetTextLeftMargin(cTextIn, nWantLMarg)
        LOCAL oText, cTextOut

        * The passed text could be empty
        IF EMPTY(cTextIn)
            cTextOut = SPACE(nWantLMarg)
        ELSE

            * Put the text into a memo array (we don't care about line length)
            oText = CREATEOBJECT('MemoArray', cTextIn, 400)

            * Change the margin
            oText.ChangeLeftMargin(nWantLMarg, .T.)    && .T. = toss last empty line

            * Get the resultant text
            cTextOut = oText.Array2Memo()
        ENDIF
        RETURN cTextOut
    ENDFUNC

    *- NormalizeNumber() - Return a number string in normal form
    *     Input: cStrIn - Number string to be normalized
    *      Retn: cStrIn converted 3 significant digits in d.ddEee form
    FUNCTION NormalizeNumber( cNumbIn )
        LOCAL nNumber, bIsNeg, nPower, nMultiplier, bPowerNeg, cRetStr

        * Get the value
        nNumber = VAL(cNumbIn)

        * If the number is 0, we're done
        IF nNumber = 0
            RETURN '0.00'
        ENDIF

        * Is it negative?
        bIsNeg = (nNumber < 0)
        IF bIsNeg
            nNumber = ABS(nNumber)
        ENDIF

        * Get the logarithm (power of 10)
        nPower = LOG10(nNumber)

        * If this is negative, multiply the number by the power + 1 (it's a
        *   fraction)
        bPowerNeg = .F.
        DO CASE
        CASE nPower < 0
            nPower = ABS(INT(nPower)) + 1
            nMultiplier = (10 ^ nPower)
            bPowerNeg = .T.
        CASE INT(nPower) = 0
            nMultiplier = 1
        OTHERWISE       && nPower > 1, so divide by power of 10
            nPower = INT(nPower)
            nMultiplier = 1 / (10 ^ nPower)
        ENDCASE

        * Put the number in d.dd form but round off to 2 digits
        nNumber = RoundOff(nNumber * nMultiplier, 2)

        * Make this into our return string
        cRetStr = IIF(bIsNeg, '-', '') + STR(nNumber, 4, 2) + [E] + ;
          IIF(bPowerNeg, '-', '') + LTRIM( STR(nPower) )
        RETURN cRetStr
    ENDFUNC

    *- ClearPunct() - Remove all except characters and digits from passed string
    *     Input: cStrIn - String to process
    *            pbKeepSpcs - If .T., spaces are retained (default = .F.)
    *      Retn: String with non-formatting chars removed
    FUNCTION ClearPunct(pcStrIn, pbKeepSpcs)
        PRIVATE cGoodChars, cStrIn, nLenIn, cRetStr, nX, cThisChar

        * Define the allowable characters
        cGoodChars = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ' + ;
          'abcdefghijklmnopqrstuvwxyz' + IIF( pbKeepSpcs, ' ', '')

        * Copy only characters, digits, and (optionally) spaces into our return
        *   string
        cStrIn = pcStrIn
        nLenIn = LEN(cStrIn)
        cRetStr = ''
        FOR nX = 1 TO nLenIn
            cThisChr = SUBSTR(cStrIn, nX, 1)

            * Skip the characters we want to remove
            IF cThisChr $ cGoodChars
                cRetStr = cRetStr + cThisChr
            ENDIF
        ENDFOR
        RETURN cRetStr
    ENDFUNC

    *- ClearEndPunct() - Remove ending punctuation characters
    *     Input: cTheStr - The passed string to de-punctuate (is that a word?)
    *      Retn: String with trailing punctuation chars removed
    FUNCTION ClearEndPunct( pcStrIn )
        LOCAL cGoodChars, cRetStr

        * Define the allowable characters
        cGoodChars = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'

        * Only look at trailing characters
        cRetStr = pcStrIn
        DO WHILE LEN(cRetStr) > 0 AND NOT RIGHT(cRetStr,1) $ cGoodChars
            cRetStr = LEFT(cRetStr, LEN(cRetStr)-1)
        ENDDO
        RETURN cRetStr
    ENDFUNC

    *- AddQuotes2Text() - Add appropriate quote characters to the passed text
    *     Input: cStrIn - String that may have embedded quotes
    *      Retn: cStrIn with quotes added no matter what
    *      Note: Was ADD_QUOTES2TXT
    FUNCTION AddQuotes2Text( pcStrIn )
        LOCAL cRetLine, nSglPosn, nDblPosn, cQuoteChar

        * We're passed a line of text that may have quote marks embedded
        *   within it.  We have to add quotes so that it can be output as part
        *   of a valid VFP string definition.

        * Example 1: I can't understand "THIS"
        *   becomes: "I can't understand " + '"THIS".'
        * Example 2: CTRL+S, 'CTRL+S'
        *   becomes: "CTRL+S, 'CTRL+S'"

        * Two simple cases (no quotes) means we can return quickly
        IF NOT ["] $ pcStrIn        && No " quote marks
            RETURN ["] + pcStrIn + ["]
        ENDIF
        IF NOT ['] $ pcStrIn        && No ' quote marks
            RETURN ['] + pcStrIn + [']
        ENDIF

        * Here, we know that we have both ' and " within the line.  So, we'll
        *   have to do some fancy footwork.
        cRetLine = ''
        DO WHILE NOT EMPTY( pcStrIn )

            * Where are the quote marks?
            nSglPosn = AT(['], pcStrIn)
            nDblPosn = AT(["], pcStrIn)

            * Handle the possibilities.  But, note that the first time thru,
            *   both positions must be > 0.  After we've extracted a fragment,
            *   though, either position might be 0.

            DO CASE

            * No single quote in string (or remainder)
            CASE nSglPosn = 0
                cQuoteChar = [']        && Single quote
                cRetLine = cRetLine + cQuoteChar + pcStrIn + cQuoteChar
                pcStrIn = ''            && We're done

            * No double quote in string
            CASE nDblPosn = 0
                cQuoteChar = ["]        && Double quote
                cRetLine = cRetLine + cQuoteChar + pcStrIn + cQuoteChar
                pcStrIn = ''            && We're done

            * We have both characters in the string - the first is "
            CASE nSglPosn > nDblPosn    && have both in string, 1st is "
                cQuoteChar = [']

                * Extract the fragment but add the + sign to the string
                *   definition
                cRetLine = cRetLine + cQuoteChar + LEFT(pcStrIn, nSglPosn-1) ;
                  + cQuoteChar + ' + '
                pcStrIn = SUBSTR(pcStrIn, nSglPosn)

            * We have both characters in the string - the first is '
            OTHERWISE                   && nSglPosn < nDblPosn
                cQuoteChar = ["]        && double quote

                * Extract the fragment but add the + sign to the string
                *   definition
                cRetLine = cRetLine + cQuoteChar + substr(pcStrIn,1,nDblPosn-1) + ;
                  cQuoteChar + ' + '
                pcStrIn = SUBSTR(pcStrIn,nDblPosn)
            ENDCASE
        ENDDO   && WHILE NOT EMPTY( pcStrIn )

        * Done
        RETURN cRetLine
    ENDFUNC

    *- CleanMemo() - Remove a memo's leading lines and trailing white space
    *     Input: cMemoIn - Memo string to be cleaned up
    *            cLeadOpt - (optional) Char. that defines what to cleanup:
    *                   'B' - (default) Cleanup both the start and the end
    *                   'L' - Only remove completely blank beginning lines
    *                       (but no other whitespace on a line with real
    *                       characters)
    *                   'N' - Don't remove anything from the start; only at
    *                       the end
    *      Retn: Cleaned up memo string
    *      Note: Was CLN_MEMO
    FUNCTION CleanMemo( pcMemoIn, pcLeadOpt)
        LOCAL cLeadOpt, cWhiteSpace, cMemo, cLine, cThisChar

        * Our default mode is that we clean all white space from the start and
        *   end of the memo.  The optional parameter, pcLeadOpt, can overwride
        *   that as follows:
        *       'B' - (default) Cleanup both the start and the end
        *       'L' - Only remove completely blank beginning lines (but no
        *           other whitespace on a line with real characters)
        *       'N' - Don't remove anything from the start; only at the end
        IF TYPE('pcLeadOpt') = 'C' AND pcLeadOpt $ 'BLN' AND LEN(pcLeadOpt) = 1
            cLeadOpt = pcLeadOpt
        ELSE
            cLeadOpt = 'B'
        ENDIF

        * Whitespace is: CR, LF, TAB and space
        cWhiteSpace = CR_LF + ' ' + TAB

        * Get the string we're to play with
        IF cLeadOpt = 'B'
            cMemo = ALLTRIM( pcMemoIn)
        ELSE
            cMemo = TRIM( pcMemoIn)
        ENDIF

        * Clean the starting part of the memo as appropriate
        DO CASE
        CASE cLeadOpt = 'B'
            DO WHILE (NOT EMPTY(cMemo)) AND LEFT(cMemo, 1) $ cWhiteSpace
                IF LEN(cMemo) > 1
                    cMemo = SUBSTR( cMemo, 2)
                ELSE
                    cMemo = ''
                ENDIF
            ENDDO
        CASE cLeadOpt = 'L'

            * Get rid of all leading blank lines - including those with only
            *   whitespace.  This means we have to look at all characters in
            *   the line.  If they're all all white space, we'll strip the
            *   line.  If we find a real character, we'll exit.
            cLine = ''
            DO WHILE (NOT EMPTY(cMemo)) AND LEFT(cMemo, 1) $ cWhiteSpace

                * Extract this character from the memo
                cThisChar = LEFT(cMemo,1)
                IF LEN(cMemo) > 1
                    cMemo = SUBSTR( cMemo, 2)
                ELSE
                    cMemo = ''
                ENDIF

                * If this is a LF, we know all the stuff in cLine is whitespace
                *   (otherwise our DO LOOP wouldn't be here).  So, this first
                *   chunk is a blank line.  So, throw away that stuff.
                IF cThisChar = LF
                    cLine = ''          && No need to add the character

                * This is a whitespace character, so add it to the line
                ELSE
                    cLine = cLine + cThisChar
                ENDIF
            ENDDO
            IF LEN(cLine) > 0
                cMemo = cLine + cMemo
            ENDIF
        ENDCASE

        * Eliminate all trailing white space
        DO WHILE (NOT EMPTY(cMemo)) AND RIGHT(cMemo,1) $ cWhiteSpace
            IF LEN(cMemo) > 1
                cMemo = LEFT(cMemo,LEN(cMemo)-1)
            ELSE
                cMemo = ''
            ENDIF
        ENDDO
        RETURN cMemo
    ENDFUNC

    *- FormatPhone() - Apply the correct formatting to the passed phone
    *     Input: cPhoneIn - 9999999 or 9999999999 or empty string
    *      Retn: 999-9999 or (999) 999-9999 or ''
    FUNCTION FormatPhone( cPhoneIn )
        LOCAL cRetPhone

        * Toss any existing formatting
        cRetPhone = cPhoneIn
        DO WHILE '-' $ cRetPhone
            cRetPhone = STRTRAN(cRetPhone, '-', '')
        ENDDO
        DO WHILE '(' $ cRetPhone
            cRetPhone = STRTRAN(cRetPhone, '(', '')
        ENDDO
        DO WHILE ')' $ cRetPhone
            cRetPhone = STRTRAN(cRetPhone, ')', '')
        ENDDO
        cRetPhone = ALLTRIM(cPhoneIn)

        * Apply formatting where appropriate
        DO CASE
        CASE LEN(cRetPhone) = 7
            cRetPhone = TRANSFORM(cRetPhone, "@R 999-9999")
        CASE LEN(cRetPhone) = 10
            cRetPhone = TRANSFORM(cRetPhone, "@R (999) 999-9999")
        ENDCASE
        RETURN cRetPhone
    ENDFUNC

    *- EncryptIt() - Return an encrypted string
    *     Input: cStrIn - URL String to be encrypted
    *      Retn: Encrypted string
    FUNCTION EncryptIt(cPlainIn)
        LOCAL cPlainIn, cStr2Do, cSwapped, cEncrypt, nW, ;
          nChar, nXform, nStrLen

        * Make the string an even length, after trimming
        cStr2Do = TRIM(cPlainIn)
        IF MOD( LEN(cStr2Do),2) = 1
            cStr2Do = TRIM(cStr2Do) + ' '
        ENDIF

        * Add a leading and trailing space
        cStr2Do = ' ' + cStr2Do + ' '
        nStrLen = LEN(cStr2Do)

        * Swap characters as follows:
        *       1 --> 10
        *       2 --> 8
        *       3 --> 6
        *       4 --> 4
        *       5 --> 2
        *       6 --> 9
        *       7 --> 7
        *       8 --> 5
        *       9 --> 3
        *      10 --> 1
        * Do the EVEN chars first
        cEven = ''
        FOR x = nStrLen TO 2 STEP -2
            cEven = cEven + SUBSTR(cStr2Do, x, 1)
        ENDFOR

        * Do the ODD chars next
        cOdd = ''
        FOR x = nStrLen-1 TO 1 STEP -2
            cOdd = cOdd + SUBSTR(cStr2Do, x, 1)
        ENDFOR
        cSwapped = cEven + cOdd

        * Now, XOR each character with 0FFh
        cEncrypt = ''
        FOR nW = 1 TO LEN(cStr2Do)
            nChar = ASC( SUBSTR(cSwapped, nW, 1) )
            nXform = BITXOR( nChar, 255 )
            cEncrypt = cEncrypt + CHR(nXForm)
        ENDFOR

        * Done
        RETURN cEncrypt
    ENDFUNC

    *- DecryptIt() - Decrypt a string that was encrypted with EncryptIt()
    *     Input: cStrIn - URL String to be decrypted
    *      Retn: Decrypted string
    FUNCTION DecryptIt(cCoded)
        LOCAL cDecrypt, nW, nChar, nXform, cUnSwapped

        * Each character was XORed.  XOR again to get the original
        cDecrypt = ''
        FOR nW = 1 TO LEN(cCoded)
            nChar = ASC( SUBSTR(cCoded, nW, 1) )
            nXform = BITXOR( nChar, 255 )
            cDecrypt = cDecrypt + CHR(nXForm)
        ENDFOR

        * Swap characters as follows:
        *  RAND 1 --> 10
        *       2 --> 8
        *       3 --> 6
        *       4 --> 4
        *       5 --> 2
        *       6 --> 9
        *       7 --> 7
        *       8 --> 5
        *       9 --> 3
        *      10 --> 1
        cUnSwapped = ''
        DO WHILE NOT EMPTY(cDecrypt)

            * Get the first and middle characters
            nLen = LEN(cDecrypt)
            cEvenChar = LEFT(cDecrypt, 1)
            nAdjLen = LEN(cDecrypt) / 2
            cOddChar = SUBSTR(cDecrypt, nAdjLen+1, 1)

            * Now loose them
            cDecrypt = LEFT(cDecrypt, nAdjLen) + SUBSTR(cDecrypt,nAdjLen+2)
            cDecrypt = SUBSTR(cDecrypt,2)

            * Add to the string
            cUnSwapped = cOddChar + cEvenChar + cUnSwapped
        ENDDO
        cUnSwapped = SUBSTR(cUnSwapped, 2, LEN(cUnSwapped)-2)

        * Done
        RETURN ALLTRIM(cUnSwapped)
    ENDFUNC

    *- EncodeURL() - Encode a string in an HTML FORM's GET METHOD format
    *     Input: cStrIn - String to be URL encoded
    *      Retn: Encoded string
    FUNCTION EncodeURL( cLonger )
        LOCAL cEncoded, nChkLen, nX, cChar

        * Simple HTML forms usually pass their entry variables in one line
        * appended to the URL.  Example:
        *   http://www.adssoftware.com?User=Ken+Green&Addr=123+Elm+St.%0A%0DChino+Hills
        * This is called URL encoding.  This must be on one line without
        *   spaces, the spaces must be converted to the "+" character.  Other
        *   characters that aren't digits or alphabetic characters are
        *   converted into their hexadecimal equivalent with a format of: %hh,
        *   where h=hex char.
        * By definition, the string cannot already contain "+" or "%"

        * Check each character
        cEncoded = ''
        nChkLen = LEN(cLonger)
        FOR nX = 1 TO nChkLen
            cChar = SUBSTR( cLonger, nX, 1)
            DO CASE
            CASE cChar = ' '
                cEncoded = cEncoded + '+'
            CASE UPPER(cChar) $ "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                cEncoded = cEncoded + cChar
            OTHERWISE

                * Convert this to its hex equivalent using TRANSFORM(@0).  But,
                *   that gets us something like: 0x000000hh, so we'll just use
                *   the last 2 digits
                cChar = RIGHT( TRANSFORM( ASC(cChar), "@0"), 2)
                cEncoded = cEncoded + '%' + cChar
            ENDCASE
        ENDFOR

        * Done
        RETURN cEncoded
    ENDFUNC

    *- DecodeURL() - Decode a string in an HTML FORM's GET METHOD format
    *     Input: cStrIn - URL String to be decoded
    *      Retn: Decoded string
    FUNCTION DecodeURL( cLonger )
        LOCAL cStr2Do, cDecoded, nChkLen

        * Simple HTML forms usually pass their entry variables in one line
        *   appended to the URL.  Example:
        *       http://www.adssoftware.com?User=Ken+Green&Address=15171+Rolling+Ridge+Dr.%0A%0DChino+Hills
        * This is called URL encoding.  This is on one line; any spaces have
        *   been converted to the "+" character.  Other characters that aren't
        *   digits or alphabetic characters were converted into their
        *   hexadecimal equivalent with a format of: %hh, where h=hex char.
        * By definition, the string could not have contained "+" or "%"

        * So, first we'll convert the + signs into spaces
        cStr2Do = STRTRAN( cLonger, "+", " ")

        * Now, we have to convert all hex encoded characters formatted as %hh
        cDecoded = ''
        DO WHILE NOT EMPTY(cStr2Do)

            * Look for the next %
            nX = AT('%', cStr2Do)

            * We're done if there aren't any
            IF nX = 0 OR nX + 2 > LEN(cStr2Do)
                cDecoded = cDecoded + cStr2Do
                cStr2Do = ''
                EXIT
            ENDIF

            * Put everything up to % into our output
            IF nX > 1
                cDecoded = cDecoded + LEFT(cStr2Do, nX-1)
                cStr2Do = SUBSTR(cStr2Do, nX)
            ENDIF

            * The next 2 characters must be hex digits
            bIsHex = .F.
            FOR nX = 1 TO 2
                cChar = SUBSTR(cStr2Do, nX+1, 1)
                IF UPPER(cChar) $ '0123456789ABCDEF'
                    bIsHex = .T.
                ENDIF
            ENDFOR

            * If this is a hex character, do the conversion
            IF bIsHex

                * VFP's format for hex numbers is: 0x000000hh
                cChar = SUBSTR(cStr2Do, 2, 2)
                cChar = CHR( EVALUATE( "0x" + cChar ) )
                cDecoded = cDecoded + cChar

                * Extract these characters from cStr2Do
                IF LEN(cStr2Do) = 3
                    cStr2Do = ''
                ELSE
                    cStr2Do = SUBSTR(cStr2Do, 4)
                ENDIF
            ELSE

                * Just move the % sign to the output string
                cDecoded = cDecoded + '%'
                cStr2Do = SUBSTR(cStr2Do, 2)
            ENDIF
        ENDDO

        * Done
        RETURN cDecoded
    ENDFUNC

    *- FlushLeft() - Return a string with characters moved flush left
    *     Input: cStrIn - String that may not be flush left
    *      Retn: cStrIn guaranteed to be flush left
    *      Note: Was FLUSH_L
    FUNCTION FlushLeft( cStrVar )
        RETURN PADR( LTRIM(cStrVar), LEN(cStrVar) )
    ENDFUNC

    *- FlushRight() - Return a string with characters moved flush right
    *     Input: cStrIn - String that may not be flush right
    *      Retn: cStrIn guaranteed to be flush right
    *      Note: Was FLUSH_R
    FUNCTION FlushRight( cStrVar )
        RETURN PADL( TRIM(cStrVar), LEN(cStrVar) )
    ENDFUNC

    *- FlushRZero() - Return a string with characters flush right, 0-filled
    *     Input: cStrIn - String that may not be flush right or 0-filled
    *      Retn: cStrIn guaranteed to be flush right and 0-filled if needed
    *      Note: Was FLUSH_R0
    FUNCTION FlushRZero( cStrVar )
        RETURN PADL( ALLTRIM(cStrVar), LEN(cStrVar), '0')
    ENDFUNC

    *- ListMemo() - Return a memo converted to CR_LF terminated lines
    FUNCTION ListMemo( pcMemo, pnMaxLen, pcIndentStr, pbIsDisplay )
        LOCAL nOldMemo, cRetStr, nNumLns, nL

        * Parameters:
        *   pcMemo - Memo field or string
        *   pnMaxLen - Maximum desired line length
        *   pcIndentStr - Preface to 2nd and remaining lines
        *   pbIsDisplay - If .T. and EMPTY(pcMemo), "(none>" is returned, else
        *                   a single space is returned
        * Returns:
        *   str1 + CR_LF
        *   pcIndentStr + str2 + CR_LF
        *   pcIndentStr + str3 + CR_LF...
        *   pcIndentStr + strX

        * Do the trivial situation quickly
        IF EMPTY(pcMemo)
            IF pbIsDisplay
                RETURN '(none)'
            ELSE
                RETURN ' '
            ENDIF
        ENDIF

        * Save our current MEMOWIDTH setting
        nOldMemo = SET('MEMOWIDTH')
        SET MEMOWIDTH TO (pnMaxLen)

        * Get the first line; it's the only one without the indent
        cRetStr = MLINE(pcMemo, 1)

        * Extract that from the memo
        pcMemo = SUBSTR(pcMemo, LEN(cRetStr)+1)
        IF LEFT(pcMemo,2) = CR_LF
            pcMemo = SUBSTR(pcMemo, 3)
        ENDIF

        * Add boldfacing only if pbIsDisplay
        IF pbIsDisplay
            cRetStr = '<B>' + cRetStr
        ENDIF

        * How many lines do we have left to print?
        SET MEMOWIDTH TO (pnMaxLen - LEN(pcIndentStr))
        nNumLns = MEMLINES(pcMemo)

        * Go to it.
        FOR nL = 1 TO nNumLns
            cRetStr = cRetStr + CR_LF + pcIndentStr + MLINE(pcMemo, nL)
        ENDFOR

        * Done, clean up and return
        SET MEMOWIDTH TO (nOldMemo)
        IF pbIsDisplay
            cRetStr = cRetStr + '</B>'
        ENDIF
        RETURN cRetStr
    ENDFUNC

    *- MakeLen() - Return a string at the desired length (chop or space fill)
    *     Input: cStrIn - String to have length changed
    *            pnDesLen - New desired length
    *            pbAddMT - .T. if "<empty>" should be put in empty strings that
    *                       are long enough
    *      Retn: cStrIn at the new length
    *      Note: Was MAKE_LEN
    FUNCTION MakeLen( pcStrIn, pnDesLen, pbAddMT)
        LOCAL cRetStr

        * If this is a memo field, pick only the stuff to the left of CR's.
        DO CASE
        CASE CR_LF $ pcStrIn
            cRetStr = LEFT(pcStrIn, AT(CR,pcStrIn) - 1)

        * If it's empty, say so if they asked for it
        CASE EMPTY(pcStrIn)
            cRetStr = IIF( pnDesLen >= 7 AND pbAddMT, '<empty>', ;
              SPACE(pnDesLen) )
        OTHERWISE
            cRetStr = pcStrIn
        ENDCASE

        * Now, adjust the length
        DO CASE
        CASE LEN(cRetStr) > pnDesLen
            cRetStr = LEFT(cRetStr, pnDesLen)
        CASE LEN(cRetStr) < pnDesLen
            cRetStr = cRetStr + SPACE(pnDesLen - LEN(cRetStr) )
        ENDCASE
        RETURN cRetStr
    ENDFUNC

    *- MakeProper() - PROPERly capitalize a string IF it's all UC or all LC
    *     Input: cStrIn - String to be checked
    *      Retn: String with proper capitalization
    *      Note: Was PROPR
    FUNCTION MakeProper( pcStrIn )
        LOCAL nLengthIn, cConvStr, bMixed, nPos, bLower, nStart, cTestStr, ;
          bOpposite

        * Get the passed string's length
        nLengthIn = LEN(pcStrIn)
        cConvStr = TRIM(pcStrIn)

        * Our objective is to automatically capitalize the first letters of
        *   each word.  But, some capitalizations shouldn't be changed:
        *       "McMinn", "IBM, Inc.", etc.
        * A "word" starts with the first alpha character that follows a
        *   non-alpha, non-numeric character.

        * First, define if we have a mixed case entry.  First, find the
        *   first character and see if it's upper- or lower-case
        bMixed = .F.
        FOR nPos = 1 TO LEN(cConvStr)
            IF ISALPHA( SUBSTR(cConvStr, nPos) )
                bLower = ISLOWER( SUBSTR( cConvStr, nPos, 1) )
                EXIT
            ENDIF
        ENDFOR

        * We may not have found any characters
        IF nPos = LEN(cConvStr)
            RETURN pcStrIn
        ENDIF

        * Here, nPos has the position of the character we found.  Go thru the
        *   rest to see if we have mixed characters
        nStart = nPos + 1
        FOR nPos = nStart TO LEN(cConvStr)
            IF bLower
                bMixed = ISUPPER( SUBSTR( cConvStr, nPos, 1) )
            ELSE
                bMixed = ISLOWER( SUBSTR( cConvStr, nPos, 1) )
            ENDIF
            IF bMixed = .T.
                EXIT
            ENDIF
        ENDFOR

        * If we have a mixed case entry, we still want to capitalize if they
        *   had CAPS LOCK on and still hit the shift key, (we could have "sAN
        *   bERNARDINO")
        IF bMixed

            * Did they have CAPS LOCK on?  The only way to know is to convert
            *   the string to proper capitalization and look for opposites.
            cTestStr = THIS.ForceProper(cConvStr)

            * Now, is this the exact opposite of the entry string?  Assume so
            bOpposite = .T.
            FOR nPos = 1 to LEN(cConvStr)
                IF ISLOWER( SUBSTR( cConvStr, nPos, 1) ) <> ;
                  ISUPPER( SUBSTR( cTestStr, nPos, 1) )
                    bOpposite = .F.
                    EXIT
                ENDIF
            ENDFOR

            * If they were opposites, return our converted string, else return
            *   the input string
            IF bOpposite

                * Add spaces to get the right string length
                IF LEN(cTestStr) < nLengthIn
                    cTestStr = cTestStr + SPACE( nLengthIn - LEN(cTestStr))
                ENDIF
                RETURN cTestStr
            ELSE
                RETURN pcStrIn
            ENDIF
        ENDIF

        * Case is not mixed, so we do a conversion
        cConvStr = THIS.ForceProper(cConvStr)

        * Add spaces to get the right string length
        IF LEN(cConvStr) < nLengthIn
            cConvStr = cConvStr + SPACE( nLengthIn - LEN(cConvStr))
        ENDIF
        RETURN cConvStr
    ENDFUNC

    *- ForceProper() - Convert string to lower, then proper capitalization
    *     Input: cStrIn - String to be checked
    *      Retn: String with proper capitalization
    *      Note: Was PROPCAP
    FUNCTION ForceProper( pcStrIn )
        LOCAL cOutStr, bMakeUpc, nCharPos, cThisChar

        * Make the entire string lowercase
        cOutStr = ALLTRIM( LOWER( pcStrIn ) )

        * Now, the first alpha character must be uppercase.
        bMakeUpc = .T.

        * From then on, making it uppercase is determined by the existence of
        *   non-alpha characters.
        FOR nCharPos = 1 to LEN(cOutStr)
            cThisChar = SUBSTR( cOutStr, nCharPos, 1)
            DO CASE
            CASE ISALPHA(cThisChar)
                IF ISLOWER(cThisChar) AND bMakeUpc
                    cThisChar = UPPER(cThisChar)
                    cOutStr = STUFF( cOutStr, nCharPos, 1, cThisChar)
                ENDIF
                bMakeUpc = .F.

            * Any char following a number should not be capitalized: e.g. 1st
            CASE ISDIGIT(cThisChar)
                bMakeUpc = .F.

            * Any character following an apostrophe should not be capitalized:
            *   e.g. Proprieter's
            CASE cThisChar = "'"
                bMakeUpc = .F.

            * Anything else is a non-alpha, non-numeric character, so the next
            *   one should be capitalized
            OTHERWISE
                bMakeUpc = .T.
            ENDCASE
        ENDFOR
        RETURN cOutStr
    ENDFUNC

    *- ExtrQuotes() - Return an array object with quoted and non-quoted parts
    *     Input: cLineIn - String line to be split
    *      Retn: Array Object with rows for quoted and unquoted lines as:
    *               oObj.aRA[x,1] = Text part of line
    *               oObj.aRA[x,2] = .T. if text is quoted
    FUNCTION ExtrQuotes( cLineIn )
        LOCAL cQuotMarks, oObj, cLine2Do, nQuotePosn, cText2Add, cLeftQuote, ;
          cRightQuote

        * We're passed a line made up of quoted and non-quoted text.  We're to
        *   return an array object with the quoted and non-quoted stuff as follows:
        *       oObj.aRA[x,1] = Text part
        *       oObj.aRA[x,2] = .T. if text is quoted
        cQuotMarks = [",']

        * Create our string part object
        oObj = CREATEOBJECT('ArrayObj', 2)

        * Go thru the string chopping it up
        cLine2Do = cLineIn
        DO WHILE NOT EMPTY(cLine2Do)
            nQuotePosn = THIS.FirstAt(cQuotMarks, cLine2Do)

            * If we have none left, this is just text
            IF nQuotePosn = 0
                cText2Add = cLine2Do
                cLine2Do = ''
                oObj.AddRow(cText2Add, .F.)
                EXIT
            ENDIF

            * Extract any text before the quote
            IF nQuotePosn > 1
                cText2Add = LEFT(cLine2Do, nQuotePosn-1 )
                cLine2Do = SUBSTR(cLine2Do, nQuotePosn )
                oObj.AddRow(cText2Add, .F.)
            ENDIF

            * Extract the quote character
            cLeftQuote = LEFT(cLine2Do, 1)
            cLine2Do = SUBSTR(cLine2Do, 2 )
            IF cLeftQuote = '['
                cRightQuote = ']'
            ELSE
                cRightQuote = cLeftQuote
            ENDIF

            * Find the rightmost quote
            nQuotePosn = AT(cRightQuote, cLine2Do)

            * If we didn't get anything, this first quote was spurious
            *   so, just add the quote as text
            IF nQuotePosn = 0
                IF oObj.nRows > 0 AND NOT oObj.aRA[oObj.nRows,2]
                    oObj.aRA[oObj.nRows,1] = oObj.aRA[oObj.nRows,1] + cLeftQuote
                ELSE
                    oObj.AddRow(cLeftQuote, .F.)
                ENDIF
                LOOP
            ENDIF

            * Extract the quoted text and put it in our array
            cText2Add = cLeftQuote + LEFT(cLine2Do, nQuotePosn )
            IF nQuotePosn = LEN(cLine2Do)
                cLine2Do = ''
            ELSE
                cLine2Do = SUBSTR(cLine2Do, nQuotePosn+1 )
            ENDIF
            oObj.AddRow(cText2Add, .T.)
        ENDDO WHILE NOT EMPTY(cLine2Do)

        * Return our array object
        RETURN oObj
    ENDFUNC

    *- Plural() - Return the plural form of the passed noun
    *     Input: cNoun - The singular noun to "pluralize"
    *            nNumber - The number in question
    *            cPluralExt - (optional) The string to add to the noun if the
    *                    number is a plural (default = 's')
    *      Retn: If nNumber = 1: only the cNoun is returned
    *            Else: the cNoun + cPluralExt are returned
    *      Note: Was PLURAL
    FUNCTION Plural(cNoun, nNumber, cPluralExt)

        * Make sure nNumber is a number
        IF VARTYPE(nNumber) <> 'N'
            nNumber = VAL(nNumber)
        ENDIF

        * Handle the only non-plural first
        IF nNumber == 1.0000000000
            RETURN cNoun
        ENDIF
        IF EMPTY(cPluralExt) OR VARTYPE(cPluralExt) <> 'C'
            cPluralExt = 's'
        ENDIF
        RETURN cNoun + cPluralExt
    ENDFUNC

    *- CountPlural() - Return the count and plural form of the passed noun
    *     Input: cNoun - The singular noun to "pluralize"
    *            nNumber - The number in question
    *            cPluralExt - (optional) The string to add to the noun if the
    *                    number is a plural (default = 's')
    *            bFirstCap - .T. if the first return letter is to be capitalized
    *      Retn: If nNumber = 0: "no " + cNoun + cPluralExt is returned
    *            If nNumber = 1: "one " and the cNoun is returned
    *            Else: the number + cNoun + cPluralExt are returned
    FUNCTION CountPlural( cNoun, nNumber, cPluralExt, bFirstCap )
        LOCAL cFirstLtrs

        * Check our parameters
        IF VARTYPE(nNumber) <> 'N'
            nNumber = VAL(nNumber)
        ENDIF
        IF EMPTY(cPluralExt) OR VARTYPE(cPluralExt) <> 'C'
            cPluralExt = 's'
        ENDIF

        * Define our first letters
        IF bFirstCap
            cFirstLtrs = 'NO'
        ELSE
            cFirstLtrs = 'no'
        ENDIF

        * Handle the possibilities
        DO CASE
        CASE nNumber = 0
            RETURN LEFT(cFirstLtrs,1) + 'o ' + cNoun + cPluralExt
        CASE nNumber = 1
            RETURN RIGHT(cFirstLtrs,1) + 'ne ' + cNoun
        ENDCASE

        * Here we're neither 0 nor 1
        RETURN ALLTRIM( TRANSFORM(nNumber) ) + [ ] + cNoun + cPluralExt
    ENDFUNC

     *- ExtrPlural() - Return the singular form of the passed plural
     *     Input: cPlural - The plural noun
     *      Retn: The singular form of that plural
     FUNCTION ExtrPlural( cStrIn )
         LOCAL cStrOut

         * For now, we'll do the obvious; as we learn more, we'll add heuristics
         cStrOut = cStrIn
         IF RIGHT(cStrIn, 2) <> [SS]                             && Compass
             cStrIn = UPPER(cStrIn)
             DO CASE
             CASE RIGHT(cStrIn, 3) = [IES] && Boundaries
                 cStrOut = LEFT(cStrOut, LEN(cStrOut)-3) + 'y'
             CASE RIGHT(cStrIn, 2) = [ES] && Purposes
                 cStrOut = LEFT(cStrOut, LEN(cStrOut)-2)
             CASE RIGHT(cStrIn, 1) = [S] && Tattoos
                 cStrOut = LEFT(cStrOut, LEN(cStrOut)-1)
             ENDCASE
         ENDIF
         RETURN cStrOut
    ENDFUNC

    *- StrToHTML() - Convert &, <, > chars for HTML output
    *     Input: cStrIn - Incoming string
    *     Output: TRIMmed cStrIn where &, < and >s are converted to escaped
    *             equivalents. If cStrIn is empty, it becomes "&nbsp;".
    *     CAUTION: Not to be used for INPUT values
    FUNCTION StrToHTML(cStrIn)
        LOCAL cRetVal, cLeft, nPosn

        * If it's empty, handle that
        IF EMPTY(cStrIn)
            RETURN '&nbsp;'
        ENDIF

        * Trim the string
        cRetVal = ALLTRIM(cStrIn)

        * Convert any <, > and &s
        IF [<] $ cRetVal
            cRetVal = STRTRAN(cRetVal, [<], [&lt])
        ENDIF
        IF [>] $ cRetVal
            cRetVal = STRTRAN(cRetVal, [>], [&gt])
        ENDIF
        IF [&] $ cRetVal        && Might already be &amp; or &nbsp;
            cLeft = ''
            nPosn = AT([&], cRetVal)
            DO WHILE nPosn > 0
                cLeft = LEFT(cRetVal, nPosn)
                cRetVal = SUBSTR(cRetVal, nPosn+1)
                nPosn = AT([;], cRetVal)
                IF nPosn = 0 OR nPosn > 5
                    cLeft = cLeft + [amp;]
                ENDIF
                nPosn = AT([&], cRetVal)
            ENDDO
            cRetVal = cLeft + cRetVal
        ENDIF

        * Done
        RETURN cRetVal
    ENDFUNC

    *- WebTrim() - Trim a string variable for HTML output
    *     Input: cStrIn - String to be trimmed
    *      Retn: Trimmed cStrIn, or non-breaking space if cStrIn is empty
    *      Note: Was HTM_TRIM
    FUNCTION WebTrim( cStrIn )

        * If empty, make it a non-break space, otherwise just trim it
        IF EMPTY(cStrIn)
            RETURN '&nbsp;'
        ELSE
            RETURN ALLTRIM( cStrIn )
        ENDIF
    ENDFUNC

    *- PostTrim() - Trim a string variable and remove artifacts
    *     Input: cStrIn - String to be checked
    *      Retn: Trimmed cStrIn with Non-breaking spaces and 0FFhs removed
    *      Note: Was POSTTRIM
    FUNCTION PostTrim( pcStrIn )
        LOCAL cStrOut

        * First, trim it
        cStrOut = ALLTRIM( pcStrIn )

        * Now, remove any non-breaking spaces and Hex FFs
        IF NBSP $ cStrOut
            cStrOut = STRTRAN(cStrOut, NBSP, '')
        ENDIF
        IF HEX_FF $ cStrOut
            cStrOut = STRTRAN(cStrOut, HEX_FF, '')
        ENDIF
        RETURN cStrOut
    ENDFUNC

    *- PostVal() - Return a numeric after removing artifacts
    *     Input: cStrIn - String to be checked
    *      Retn: VAL() of cStrIn after non-breaking spaces and 0FFhs removed
    *      Note: Was POSTVAL
    FUNCTION PostVal( pcStrIn )
        LOCAL nNumbOut

        * First, POST trim it and kill the artifacts
        cStrOut = THIS.PostTrim( pcStrIn )

        * Now, remove any internal commas...
        IF ',' $ cStrOut
            cStrOut = STRTRAN(cStrOut, ',', '')
        ENDIF

        * ...and return the numeric equivalent
        RETURN VAL(cStrOut)
    ENDFUNC

    *- StripChrs() - Remove one or more characters from a passed string
    *     Input: cStrIn - String to be checked
    *            cDelChars - String of characters to be removed
    *      Retn: String with cDelChars characters removed
    *      Note: Was STRIPCHR
    FUNCTION StripChrs( pcStrIn, pcDelChars )
        LOCAL cRetVal, nDelLen, nZ, cChar

        * Note that we could, more easily, use CHRTRAN().  But, it's known for
        *   sometimes throwing bugs if the return string is shorter than the
        *   starting string.  This was especially true in VFP 5, but also true
        *   in VFP 6 though Microsoft claimed it was fixed.  Hence the need to
        *   roll our own.

        * Two possible versions were tested:
        *   a. A function that added good characters to the return string but
        *       then required testing for each input string character.  Test
        *       time for 100,000 function calls: 30 seconds.
        *   b. This function that tests each bad character and uses STRTRAN()
        *       to remove them all.  Test time for 100,000 function calls: 12
        *       seconds.

        * Initialize our return value
        cRetVal = pcStrIn

        * Pull out the desired characters
        nDelLen = LEN(pcDelChars)
        FOR nZ = 1 TO nDelLen
            cChar = SUBSTR(pcDelChars, nZ, 1)
            IF cChar $ cRetVal
                cRetVal = STRTRAN(cRetVal, cChar, '')
            ENDIF
        ENDFOR
        RETURN cRetVal
    ENDFUNC

    *- WordWrapString() - Reformat a string with CR_LF lines
    *     Input: cStrIn - String to be word-wrapped
    *            pnMaxLinLen - Max. length of a line
    *            pnIndentSpcs - Prepend this from 2nd line on
    *            pbKillIntEnds - (Optional) .T. if internal blank lines are to
    *                       be removed (default = .F.)
    *      Retn: Word-wrapped string
    *      Note: Was FORMAT_STRING
    FUNCTION WordWrapString( pcStrIn, pnMaxLinLen, pnIndentSpcs, pbKillIntEnds)
        IF EMPTY(pcStrIn)
            RETURN ''
        ENDIF

        * We have 2 tasks to do:
        *   1. Make sure no individual line is longer than pnMaxLinLen
        *   2. Indent the 2nd line on by pnIndentSpcs
        * Define our indent count
        nIndent = 0
        IF TYPE('pnIndentSpcs') = 'N' AND pnIndentSpcs > 0
            nIndent = pnIndentSpcs
        ENDIF

        * To make this easy, we'll change all CR_LFs into 0FFh
        cRawMemo = STRTRAN(pcStrIn, CR_LF, HEX_FF)

        * Do the conversion for the 1st line
        cStrOut = THIS.ExtrLine( @cRawMemo, pnMaxLinLen, pbKillIntEnds)
        IF NOT EMPTY(cStrOut)
            cStrOut = cStrOut + CR_LF
        ENDIF

        * Now handle the rest of the lines indenting them as appropriate
        DO WHILE NOT EMPTY(cRawMemo)
            cFrag = THIS.ExtrLine( @cRawMemo, pnMaxLinLen - nIndent, pbKillIntEnds)
            IF NOT EMPTY(cFrag)
                cStrOut = cStrOut + SPACE(nIndent) + cFrag + CR_LF
            ENDIF
        ENDDO
        RETURN cStrOut
    ENDFUNC

    *- SwapPhrase() - Substitute all instances of a word/phrase with a 2nd word/phrase
    *     Input: cStrIn - String to be word-wrapped
    *            cPhraseIn - Phrase to be changed
    *            cNewPhrase - Phrase to be put in plase of cPhraseIn
    *      Retn: Changed string
    *     Notes: 1. This is a case-insensitive swap.
    *            2. cPhraseIn must be within word boundaries at each end
    FUNCTION SwapPhrase(cStrIn, cPhraseIn, cNewPhrase)
        LOCAL cStr2Do, cWordChars, cRetStr, nPhraseLen, nPosn, cCapPhase

        * Is the word in here at all?
        IF NOT UPPER(cPhraseIn) $ UPPER(cStrIn)
            RETURN cStrIn
        ENDIF

        * Setup for processing
        cStr2Do = cStrIn
        cWordChars = THIS.cWordChars
        cRetStr = ''
        nPhraseLen = LEN(cPhraseIn)

        * Find all instances of cPhraseIn
        nPosn = AT(UPPER(cPhraseIn), UPPER(cStr2Do))
        DO WHILE nPosn > 0

            * The prior character can't be a word character
            IF SUBSTR(cStr2Do, nPosn-1, 1) $ cWordChars
                cRetStr = cRetStr + LEFT(cStr2Do, nPosn + 1)
                cStr2Do = SUBSTR(cStr2Do, nPosn + 1)
                LOOP
            ENDIF

            * Extract all before the phrase
            cRetStr = cRetStr + LEFT(cStr2Do, nPosn-1)
            cStr2Do = SUBSTR(cStr2Do, nPosn)

            * The following character can't be a word character
            IF SUBSTR(cStr2Do, nPhraseLen + 1, 1) $ cWordChars
                cRetStr = cRetStr + LEFT(cStr2Do, nPhraseLen)
                cStr2Do = SUBSTR(cStr2Do, nPhraseLen + 1)
                LOOP
            ENDIF

            * Here we have our phrase; substitute it
            cRetStr = cRetStr + cNewPhrase
            cStr2Do = SUBSTR(cStr2Do, nPhraseLen + 1)

            * Find the next instance of the phrase
            nPosn = AT(UPPER(cPhraseIn), UPPER(cStr2Do))
        ENDDO

        * Add anything left in cStr2Do and we're done
        cRetStr = cRetStr + cStr2Do
        RETURN cRetStr
    ENDFUNC


        ***** Output Formatting *****

    *- Format() - Return the passed string with variable values inserted
    *     Input: cString - String to have variable values inserted. Example:
    *               {0}, your {1:D} purchase total was {2:c}. Thank you {0}."
    *                   The curly brackets define the variable number to be
    *                   inserted (0-based). the : defines formatting codes.
    *            vPara0, vPara1,...vPara9 - Variables to be converted to
    *               strings and inserted (up to 9 variables)
    *      Retn: String with variable values inserted.  For example, if the
    *            variable values were:
    *               cUserName   = "Joe"
    *               dBuyDate    = {03/19/2010}
    *               nInvoiceAmt = $43.63
    *            The string would be: "Joe, your March 19, 2010 purchase total
    *                                  was $43.63. Thank you Joe."
    FUNCTION Format(cString, vPara0, vPara1, vPara2, vPara3, vPara4, vPara5, vPara6, vPara7, vPara8, vPara9)
        LOCAL nOldDec, cRet, nCount, cCount, cArg, cFormat

        * This method mostly mimics the String.Format() C# or C++ methods in
        *   .NET.

        * Acknowledgement: This, and related mothods, are based on code in
        *   article by Jrgen Wondzinski (aka wOOdy) in the MSDN Code Gallery
        *   (see http://code.msdn.microsoft.com/FoxPro/Release/ProjectReleases.aspx?ReleaseId=442)
        * It was adjusted by Eric Selje (http://saltydogllc.com/) as part of an
        *   article, "String.Format for VFP," in the FoxRockX magazine, dated
        *   Jan. 2010.
        * While I've (KAG) modified this somewhat - especially the
        *   NumericFormat(), its lower methods and the LogicalFormat() method -
        *   it's those others that deserve the credit for good ideas and
        *   realistic implementation.

        * Save the current DECIMALS setting and change to 18
        nOldDec = SET('DECIMALS')
        SET DECIMALS TO 18          && Maximum for VFP

        * Get the string we'll return
        cRet = cString

        * Extract all parameters within {}s and convert them
        FOR nCount = 1 TO OCCURS("{", cString)

            * Extract the parameter and its count (if any)
            cArg = STREXTRACT(cString, "{", "}", nCount, 4)
            cFormat = STREXTRACT(cArg, ":", "}")
            cCount = CHRTRAN(STRTRAN(cArg, cFormat,""), "{:}","")

            * If there is no format letter, just do a direct TRANSFORM()
            IF EMPTY(cFormat)
                cRet = STRTRAN(cRet, cArg, ;
                  TRANSFORM( EVALUATE("vPara"+cCount) ))
            ELSE

                * Handle formatting based on the variable's type
                xParam = EVALUATE("vPara"+cCount)
                DO CASE

                * Dates and DateTimes
                CASE INLIST(VARTYPE(xParam),'D','T')
                    cRet = STRTRAN(cRet, cArg, THIS.DateFormat(xParam, cFormat))

                * Numbers and Currencies
                CASE INLIST(VARTYPE(xParam),'N','Y')
                    cRet = STRTRAN(cRet, cArg, ;
                      THIS.NumericFormat(xParam, cFormat))

                * Logicals
                CASE VARTYPE(xParam) = 'L'
                    cRet = STRTRAN(cRet, cArg, ;
                      THIS.LogicalFormat(xParam, cFormat))

                * All others just get a direct TRANSFORM()
                OTHERWISE
                    cRet = STRTRAN(cRet, cArg, TRANSFORM(xParam, cFormat) )
                ENDCASE
            ENDIF
        ENDFOR
        SET DECIMALS TO (nOldDec)
        RETURN cRet
    ENDFUNC

    *- DateFormat() - Format a Date or DateTime into a string
    *     Input: dtConvert - Date or DateTime variable to be converted
    *            cFormat - Formatting codes (see above)
    *      Retn: String of Date or DateTime converted according to the format
    FUNCTION DateFormat(dtConvert, cFormat)
        LOCAL cResult, dConvert, cTimeZone, iBiasSeconds, cPattern

        * Define our return value
        cResult = ""

        * For consistency's sake, get both a date and datetime variable
        IF VARTYPE(dtConvert)="D"
            dConvert = dtConvert
            dtConvert = DTOT(dConvert)  && Defaults time to midnight (00:00:00)
        ELSE
            dConvert = TTOD(dtConvert)
        ENDIF

        * We only have 1-character formats here
        IF LEN(cFormat) = 1
            IF INLIST(cFormat, 'r', 'u', 'U')

                * Adjust time to GMT
                DECLARE INTEGER GetTimeZoneInformation IN kernel32 ;
                  STRING @lpTimeZoneInformation
                cTimeZone = REPLICATE(Chr(0), 172)
                GetTimeZoneInformation(@cTimeZone)
                iBiasSeconds = 60 * INT( ASC(SUBSTR(cTimeZone, 1,1)) + ;
                  BITLSHIFT(ASC(SUBSTR(cTimeZone,2,1)), 8)+;
                  BITLSHIFT(ASC(SUBSTR(cTimeZone,3,1)),16)+;
                  BITLSHIFT(ASC(SUBSTR(cTimeZone,4,1)),24))
                dtConvert = dtConvert - iBiasSeconds
                dConvert = TTOD(dtConvert)
            ENDIF
            DO CASE

            * Short date eg 10/12/2002
            CASE cFormat = 'd'
                cPattern = 'MM/dd/yyyy'

            * Long date, short month eg. Dec. 10, 2002
            CASE cFormat = 'D'
                cPattern = 'MMM. dd, yyyy'

            * Long date eg. December 10, 2002.
            CASE cFormat = 'L'
                cPattern = 'MMMM dd, yyyy'

            * Full date & time eg December 10, 2002 10:11 PM
            CASE cFormat = 'f'
                cPattern = 'MMMM dd, yyyy hh:mm tt'

            * Full date & time (long) eg December 10, 2002 10:11:29 PM
            CASE cFormat = 'F'
                cPattern = 'MMMM dd, yyyy hh:mm:ss tt'

            * Default date & time eg 10/12/2002 10:11 PM
            CASE cFormat = 'g'
                cPattern = 'MM/dd/yyyy hh:mm tt'

            * Default date & time (long) eg 10/12/2002 10:11:29 PM
            CASE cFormat = 'G'
                cPattern = 'MM/dd/yyyy hh:mm:ss tt'

            * Month day pattern eg December 10
            CASE cFormat = 'M'
                cPattern = 'MMMM dd'

            * RFC1123 date string Tue, 10 Dec 2002 22:11:29 GMT
            CASE cFormat = 'r'
                cPattern = 'ddd, dd MMM yyyy hh:mm:ss GMT'

            * Sortable date string eg 2002-12-10T22:11:29
            CASE cFormat = 's'
                cPattern = TTOC(dtConvert,3)

            * Short time eg 10:11 PM
            CASE cFormat = 't'
                cPattern = 'hh:mm tt'

            * Long time eg 10:11:29 PM
            CASE cFormat = 'T'
                cPattern = 'hh:mm:ss tt'

            * Universal sortable, local time eg 2002-12-10 22:13:50Z
            CASE cFormat = 'u'
                cPattern = 'yyyy-MM-dd hh:mm:ddZ'

            * Universal sortable, GMT eg December 11, 2002 3:13:50 AM
            CASE cFormat = 'U'
                cPattern = "MMMM dd, yyyy hh:mm:ss tt"

            * Year month pattern eg December, 2002
            CASE cFormat = 'Y'
                cPattern = "MMMM, yyyy"
            ENDCASE
            cResult = THIS.ParseDateFormat(cPattern, dtConvert)
        ENDIF
        RETURN cResult
    ENDFUNC

    *- PROT ParseDateFormat() - Parse a format to return a Date/Time string
    PROTECTED FUNCTION ParseDateFormat(cFrmt, dtVar)
        LOCAL cRetStr, bChgTo12Hr, nHrs, cHrs
        cRetStr = cFrmt

        * Check the hours; they can be funny
        nHrs = HOUR(dtVar)
        bChgTo12Hr = ('tt' $ cRetStr)
        IF bChgTo12Hr AND nHrs > 12
            nHrs = nHrs - 12
        ENDIF
        IF bChgTo12Hr
            cHrs = TRANSFORM(nHrs)
        ELSE
            cHrs = PADL(nHrs,2,'0')
        ENDIF

        * Just do what needs doing; insert the values into the passed string
        cRetStr= STRTRAN(cRetStr,"hh", cHrs)
        cRetStr= STRTRAN(cRetStr,"mm", PADL( MINUTE(dtVar),2,'0'))
        cRetStr= STRTRAN(cRetStr,"ss", PADL( SEC(dtVar),2,'0'))
        cRetStr= STRTRAN(cRetStr,"MMMM", CMONTH(dtVar))
        cRetStr= STRTRAN(cRetStr,"MMM.", LEFT( CMONTH(dtVar),3) + '.')
        cRetStr= STRTRAN(cRetStr,"MMM", LEFT( CMONTH(dtVar),3))
        cRetStr= STRTRAN(cRetStr,"MM", PADL( MONTH(dtVar),2,'0'))
        cRetStr= STRTRAN(cRetStr,"ddd", LEFT( CDOW(dtVar),3))
        cRetStr= STRTRAN(cRetStr,"dd", PADL( DAY(dtVar),2,'0'))
        cRetStr= STRTRAN(cRetStr,"yyyy", TRANSFORM( YEAR(dtVar)))
        cRetStr= STRTRAN(cRetStr,"yy", RIGH(TRANSFORM( YEAR(dtVar)),2))
        cRetStr= STRTRAN(cRetStr,"tt", IIF( HOUR(dtVar) < 12, "AM", "PM"))
        RETURN cRetStr
    ENDFUNC

    *- NumericFormat() - Format a Number or Currency value into a string
    *     Input: dtConvert - Number or Currency variable to be converted
    *            cFormat - Formatting codes (see above)
    *      Retn: String of Number or Currency converted according to the format
    FUNCTION NumericFormat(nNumbIn, cFormat)
        LOCAL cFrmtLtr, nPrec, cClass, oNumb, cResult

        * All formats start with a single letter
        cFrmtLtr = LEFT(cFormat, 1)

        * They may have a precision; if not, we'll have to setup our defaults
        IF LEN(cFormat) > 1
            nPrec = VAL( SUBSTR(cFormat, 2) )
        ENDIF

        * Define our number object class
        IF UPPER(cFrmtLtr) = 'D'
            cClass = [I] + [TypeNumber]
        ELSE
            cClass = UPPER(cFrmtLtr) + [TypeNumber]
        ENDIF

        * Create the number object
        IF VARTYPE(nPrec) = 'N'
            oNumb = CREATEOBJECT(cClass, cFrmtLtr, nNumbIn, nPrec)
        ELSE
            oNumb = CREATEOBJECT(cClass, cFrmtLtr, nNumbIn)
        ENDIF

        * Get the conversion
        cResult = oNumb.ToString()
        RETURN cResult
    ENDFUNC

    *- LogicalFormat() - Format a Logical value into a string
    *     Input: bValue - Logical value to be converted
    *            cFormat - Formatting codes (see above)
    *      Retn: String of Logical converted according to the format
    FUNCTION LogicalFormat(bValue, cFormat)
        LOCAL cFrmtLtr, nChars, cResult

        * All formats start with a single letter
        cFrmtLtr = LEFT(cFormat, 1)

        * How many characters do they want?
        IF LEN(cFormat) > 1
            nChars = VAL( SUBSTR(cFormat, 2) )
        ELSE
            nChars = 0
        ENDIF

        * Handle each type of formatting
        DO CASE

        * True/False: "Tz" or "tz"
        CASE LOWER(cFrmtLtr) = 't'
            cResult = IIF(bValue, 'true', 'false')

        * Yes/No: "Yz" or "yz"
        CASE LOWER(cFrmtLtr) = 'y'
            cResult = IIF(bValue, 'yes', 'no')

        * Don' know what to do here, boss.
        OTHERWISE
            ERROR [Invalid Format: ] + cFormat
        ENDCASE

        * Should that first letter be uppercase?
        IF cFrmtLtr $ 'TY'
            cResult = UPPER( LEFT(cResult,1) ) + SUBSTR(cResult,2)
        ENDIF

        * Chop the result as desired
        IF nChars > 0 AND nChars < LEN(cResult)
            cResult = LEFT(cResult, nChars)
        ENDIF
        RETURN cResult
    ENDFUNC


        ***** VFP Code Formatting *****

    *- Comm2Code() - Format one comment line to fit within a specified length
    *     Input: cLineIn - Comment line to be formatted
    *            nMaxLen - Max. length of output string
    *      Retn: Formatted line with any necessary " ;" line continuations.
    FUNCTION Comm2Code( cLineIn, nMaxLen )

        * Trivial situation first
        IF LEN(cLineIn) <= nMaxLen
            RETURN cLineIn + CR_LF
        ENDIF

        * What's our current left margin?
        cLineOut = LTRIM(cLineIn)
        cLftMarg = SPACE( LEN(cLineIn) - LEN(cLineOut) )

        * Go to it; comments are much simpler than other lines because we
        * don't have to worry about quotes.  But, we do have to:
        *   1. Start each additional line with a properly indented *
        *   2. Add 2 more spaces to the text within the comment
        cLineOut = ''
        cWkgText = cLineIn
        DO WHILE NOT EMPTY(cWkgText)
            cLine = goStr.ExtrLine( @cWkgText, nMaxLen)
            cLineOut = cLineOut + cLine + CR_LF
            IF NOT EMPTY(cWkgText)
                cWkgText = cLftMarg + [*   ] + cWkgText
            ENDIF
        ENDDO

        * Done
        RETURN cLineOut
    ENDFUNC

    *- Line2Code() - Format one line of code to fit within a specified length
    *     Input: cLineIn - String line to be formatted
    *            nMaxLen - Max. length of output string
    *      Retn: Formatted line with any necessary " ;" line continuations.
    *               Quoted strings will be split properly (with quotes at split)
    FUNCTION Line2Code( cLineIn, nMaxLen )
        LOCAL cLineOut, cLftMarg, cQuotMarks, nChopLen, cLine2Do, oQuoteObj, ;
          cLinePart, nX, cThisLine, bIsQuoted, cLeftQuote, cRightQuote, cLeft, ;
          bHandleLine

        * Trivial situation first
        IF LEN(cLineIn) <= nMaxLen
            RETURN cLineIn
        ENDIF

        * What's our current left margin?
        cLineOut = LTRIM(cLineIn)
        cLftMarg = SPACE( LEN(cLineIn) - LEN(cLineOut) )

        * Define quote characters and our chopping length (to allow for " ;")
        *   (We won't use [] as they're also used for array notation and it
        *   wouldn't do to split "oObj.aRA[100,45]" as oObj.aRA[10] + [0,45]
        cQuotMarks = [",']
        nChopLen = nMaxLen - 2

        * If the line is longer than nMaxLen we want to split it as follows:
        *   1. Split it at the closest whitespace to nMaxLen (chop it if we
        *       have to).  But, manage quotation marks so if the line is split
        *       within quotes, the strings are properly terminated.
        *   2. Add a line continuation character (;) to the first line after it's
        *       split and indent the next line 2 spaces.
        cLineOut = ''
        cLine2Do = cLineIn

        * Do we have any quotes?  If so, we have a different process
        IF THIS.FirstAt(cQuotMarks, cLine2Do) > 0

            * Get an array object of the line split at quotes
            oQuoteObj = THIS.ExtrQuotes(cLineIn)

            * Now, go thru the array adding line parts
            cLinePart = ''
            FOR nX = 1 TO oQuoteObj.nRows
                cThisLine = oQuoteObj.aRA[nX,1]
                bIsQuoted = oQuoteObj.aRA[nX,2]

                * Will this cause our line part to be too long?
                DO CASE

                * Don't try to stuff the new line onto this
                CASE LEN(cLinePart) + 6 > nMaxLen

                    * Process the partial line
                    bHandleLine = .T.

                * Do we have to split this line?
                CASE LEN(cLinePart + cThisLine) > nMaxLen
                    IF bIsQuoted
                        cLeftQuote = LEFT(cThisLine,1)
                        cRightQuote = RIGHT(cThisLine,1)
                        nChopLen = nMaxLen - 1 - LEN(cLinePart)
                    ELSE
                        nChopLen = nMaxLen - LEN(cLinePart)
                    ENDIF
                    cLeft = THIS.ExtrLine( @cThisLine, nChopLen )
                    IF bIsQuoted
                        cLeft = cLeft + cRightQuote
                        cThisLine = "+ " + cLeftQuote + cThisLine
                    ENDIF
                    cLinePart = cLinePart + cLeft
                    bHandleLine = .T.
                OTHERWISE       && Nope
                    cLinePart = cLinePart + cThisLine
                    cThisLine = ''
                    bHandleLine = (nX = oQuoteObj.nRows)
                ENDCASE

                * If this partial line is done, process it
                IF bHandleLine
                    cLineOut = cLineOut + cLinePart
                    IF nX < oQuoteObj.nRows
                        cLineOut = cLineOut + ' ;' + CR_LF
                        cLinePart = cLftMarg + '  ' + cThisLine
                    ELSE
                        cLinePart = ''
                        IF NOT EMPTY(cThisLine)
                            cLineOut = cLineOut + ' ;' + CR_LF + cLftMarg + ;
                              '  ' + cThisLine
                        ENDIF
                    ENDIF
                ENDIF
            ENDFOR
        ELSE

            * No quotes, so we just split the line as needed
            DO WHILE NOT EMPTY(cLine2Do)

                * Get the part of the line
                IF LEN(cLine2Do) <= nMaxLen
                    cLinePart = cLine2Do
                    cLine2Do = ''
                ELSE
                    cLinePart = THIS.ExtrLine( @cLine2Do, nChopLen ) + ' ;'
                ENDIF   && LEN(cLine2Do) <= nMaxLen

                * Add this to our output text
                cLineOut = cLineOut + cLinePart + CR_LF

                * "Indent" cLine2Do
                cLine2Do = cLftMarg + '  ' + cLine2Do
            ENDDO
        ENDIF
        RETURN cLineOut
    ENDFUNC

    *- FormatCode() - Format a block of text as VFP Code with ; carry-overs
    *     Input: cTextIn - String to be formatted (can be multiple lines)
    *            nRightMargin - (optional) desired right margin (e.g. max.
    *                   length of output string - default = 80)
    *      Retn: Formatted string with any necessary " ;" line continuations.
    *               Quoted strings will be split properly (with quotes at split)
    FUNCTION FormatCode( cTextIn, nRightMargin )
        LOCAL nRtMarg, cText2Do, cTextOut, cLine

        * Set the number of characters we want (default = 80)
        nRtMarg = 80
        IF VARTYPE(nRightMargin) = 'N' AND nRightMargin > 0
            nRtMarg = nRightMargin
        ENDIF

        * Convert all CR_LFs to HEX_FFs
        cText2Do = STRTRAN(cTextIn, CR_LF, HEX_FF)

        * Go thru the entire input string creating our output string
        cTextOut = ''
        DO WHILE NOT EMPTY(cText2Do)

            * Get this line
            cLine = THIS.ExtrToken( @cText2Do, HEX_FF)

            * We want to split this line but every line after the 1st should be
            *   indented 2 chars.  Further, we want to add the ; line continuation
            *   character
            IF LEN(cLine) > nRtMarg
                cLine = THIS.Line2Code( cLine, nRtMarg)
            ENDIF
            cTextOut = cTextOut + cLine + CR_LF
        ENDDO
        RETURN cTextOut
    ENDFUNC


        ***** Object Functions *****

    *- PropsToStr() - Put an object's properties into a string
    *     Input: cStrIn - String to be checked
    *      Retn: Long string of properties as:
    *           PROPS START objname objclass FF
    *           t propname = propval FF
    *           t propname = propval FF
    *           .
    *           .
    *           t propname = propval FF
    *           PROPS END objname FF
    *           where, generally:
    *               t - variable type
    *               propname - property name
    *               propval - property value (converted into a string)
    *   WARNING: Won't work for General fields, Arrays of Objects or memos
    *               with internal 0FFh characters
    *      Note: Was PROP2STR
    FUNCTION PropsToStr( poObj )
        LOCAL nPropCnt, cRetStr, nZ, cPropName, cType, xPropVal, nRARows, nRACols, ;
          cPropVal, nY
        LOCAL aPropList[1,2], aTemp[1,2]

        * We're going to create a string whose first line is:
        *       PROPS START objname objclass FF
        * and whose last line is:
        *       PROPS END objname FF
        * Note that our line separators are 0FFh (or the HEX_FF char)

        * Within those 2 lines, we'll create a series of strings with the format:
        *       t propname = propval FF
        *   where, generally:
        *       t - variable type
        *       propname - property name
        *       propval - property value (converted into a string)
        * But, Arrays and Objects require special handling, see below

        * Get a list of this array's properties
        *   aPropList[nX] = Property Name
        nPropCnt = AMEMBERS(aPropList, poObj)

        * Start our string
        cRetStr = 'PROPS START ' + poObj.Name + ' ' + poObj.Class + HEX_FF

        * Go through all properties creating our formatted lines
        FOR nZ = 1 TO nPropCnt
            cPropName = 'poObj.' + aPropList[nZ]
            cType = TYPE(cPropName)

            * If it's undefined, ignore it
            IF cType = 'U'
                LOOP
            ENDIF

            * If this isn't an object, test for an array
            IF cType <> 'O'             && Object

                * Is this an array?
                IF ISARRAY(cPropName)
                    cType = 'A'
                ELSE

                    * As it's not an array or an object, define it's value
                    xPropVal = EVAL( cPropName )
                ENDIF
            ENDIF

            * Handle based on type
            DO CASE
            CASE cType = 'A'            && Array

                *   Array properties require that we save all row and column info.  So,
                *       we'll format these as:
                *       A propname = rr,cc^Telem1^Telem2...
                *   where:
                *       rr - array rows
                *       cc - array cols
                *       T - element's variable type
                *       elemX - element's value

                * Our special type character is "A"
                cType = 'A'             && Our special type

                * How many rows and columns does the array have
                nRARows = ALEN( &cPropName, 1 )
                nRACols = ALEN( &cPropName )
                IF nRARows = nRACols        && Same for single dimension arrays
                    nRACols = 1
                ELSE
                    nRACols = nRACols / nRARows
                ENDIF

                * Copy the array into aTemp[] so we don't have a lot of indirect
                *   referencing.  But, make sure aTemp[] is the right size
                DIMENSION aTemp[nRARows, nRACols]
                ACOPY( &cPropName, aTemp)

                * Save the array info as: rr,cc^Telem1^Telem2...
                *   where:
                *       rr - array rows
                *       cc - array cols
                *       T - element's variable type
                *       elemX - element's value
                cPropVal = LTRIM( STR(nRARows) ) + ',' + LTRIM( STR(nRACols) ) + '^'

                * Save each element
                FOR nY = 1 TO (nRARows * nRACols)
                    xPropVal = aTemp[nY]
                    cPropVal = cPropVal + TYPE('xPropVal') + ;
                      THIS.XToChar(xPropVal) + '^'
                ENDFOR

            * Character, Numeric, Currency, Date, DateTime, Logical and Memo can
            *   all be handled by our THIS.XToChar() function.  But, if the memo
            *   contains embedded 0FFh characters, we're in trouble
            CASE cType $ 'CNYDTLM'
                cPropVal = THIS.XToChar(xPropVal)

            * We need special handling for contained Objects as they have their
            *   own sets of properties.  So, we'll just call ourselves recursively
            *   to get a string of those properties (they will be between the
            *   "PROPS START" and the "PROPS END" lines).
            CASE cType = 'O'

                * But, this DOES NOT apply to the PARENT property; we'll ignore that
                IF UPPER(cPropName) <> 'POOBJ.PARENT'

                    * Call ourselves recursively
                    cPropVal = THIS.PropsToStr( &cPropName )
                    cRetStr = cRetStr + cPropVal
                ENDIF
                LOOP
            ENDCASE

            * Add a line for this property that looks like:
            *       t propname = propval CRLF
            *   where, generally:
            *       t - variable type
            *       propname - property name
            *       propval - property value (converted into a string)
            cRetStr = cRetStr + cType + ' ' + cPropName + ' = ' + cPropVal + ;
              HEX_FF

            * Get the next property
        ENDFOR  && nZ = 1 TO nPropCnt

        * End our string and return it
        RETURN cRetStr + 'PROPS END ' + poObj.Name + HEX_FF
    ENDFUNC

    *- StrToProps() - Set an object's properties from the passed string
    *     Input: cPropStr - Property string (see PropsToStr() for format)
    *            oObj - The object to have its properties set
    *      Retn: .T. and the Object with its properties set from the string
    *   WARNING: Won't work for General fields, Arrays of Objects or memos
    *               with internal 0FFh characters
    *      Note: Was STR2PROP
    FUNCTION StrToProps( pcPropStr, poObj )
        LOCAL nPosn, cWkgLine, cObjName, cObjText, cObjClass, cType, cPropName, ;
          cPropVal, nRARows, nRACols, nY, cRAVal
        LOCAL aTemp[1,2]

        * Generally, our string has the format of:
        *       PROPS START objname objclass FF
        *           (bunch of properties)
        *       PROPS END objname FF
        * Note that our line separators are 0FFh (or the HEX_FF char)

        * If the object contains other objects, those are nested within that; they
        *   will also have the PROPS START and PROPS END lines.  For example:
        *       PROPS START obj1name obj1class FF
        *           (bunch of obj1 properties)
        *       PROPS START obj2name obj2class FF
        *           (bunch of obj2 properties)
        *       PROPS END obj2name FF
        *           (more obj1 properties)
        *       PROPS END obj1name FF

        * Generally, the object's property lines are formatted as:
        *       t propname = propval FF
        *   where, generally:
        *       t - variable type
        *       propname - property name
        *       propval - property value (converted into a string)
        * Arrays and Objects have special handling:
        *   Arrays: Here, we'll need to dimension the arrays and load them.  So,
        *           the array format is:
        *               A propname = rr,cc^Telem1^Telem2...
        *           where:
        *               rr - array rows
        *               cc - array cols
        *               T - element's variable type
        *               elemX - element's value
        *   Objects: As mentioned above, these have their own PROPS START and
        *           PROPS END lines.  So, we'll have to use AddObject() to add
        *           these objects to our master object.  We'll also have to
        *           extract the text within the PROPS START and PROPS END lines
        *           and call ourselves recursively to assign those properties to
        *           that object.

        * Extract the START line for this object
        *       1234567890123456789012345678901234567890
        *       PROPS START objname objclass FF
        nPosn = AT('PROPS START', pcPropStr)
        IF nPosn > 1
            pcPropStr = SUBSTR(pcPropStr, nPosn)
        ENDIF
        cWkgLine = THIS.ExtrToken( @pcPropStr, HEX_FF)

        * All we need to do with the START line is to assign the name
        cWkgLine = ALLTRIM( SUBSTR( cWkgLine, 13) )
        nPosn = AT(' ', cWkgLine)
        cObjName = TRIM( LEFT(cWkgLine, nPosn) )
        poObj.Name = cObjName

        * Extract the END line for this object and throw it away
        *       1234567890123456789012345678901234567890
        *       PROPS END objname FF
        nPosn = AT('PROPS END ' + cObjName, pcPropStr)
        pcPropStr = LEFT( pcPropStr, nPosn-1 )

        * Now, go through each line of the remainder setting properties
        DO WHILE NOT EMPTY(pcPropStr)

            * Get a line
            cWkgLine = ALLTRIM( THIS.ExtrToken( @pcPropStr, HEX_FF) )
            IF EMPTY(cWkgLine)
                LOOP
            ENDIF

            * Is this the start of another object?
            IF cWkgLine = 'PROPS START'

                * Save this start line
                cObjText = cWkgLine + HEX_FF

                * Get the object's name and class
                *   1234567890123456789012345678901234567890
                *   PROPS START objname objclass FF
                cWkgLine = ALLTRIM( SUBSTR( cWkgLine, 13) )
                nPosn = AT(' ', cWkgLine)
                cObjName = TRIM( LEFT(cWkgLine, nPosn) )
                cObjClass = ALLTRIM( SUBSTR( cWkgLine, nPosn) )

                * Find the PROPS END line
                nPosn = AT('PROPS END ' + cObjName, pcPropStr)

                * Extract all of the intervening text
                cObjText = cObjText + LEFT( pcPropStr, nPosn-1 )
                pcPropStr = SUBSTR(pcPropStr, nPosn)

                * Add the end line
                cWkgLine = ALLTRIM( THIS.ExtrToken( @pcPropStr, HEX_FF) )
                cObjText = cObjText + cWkgLine + HEX_FF

                * Add the object
                pcObj.AddObject(cObjName, cObjClass)

                * Call ourselves recursively to set this object's properties
                THIS.StrToProps(cObjText, poObj.&cObjName)

                * Done
                LOOP
            ENDIF

            * Here, we have a normal property line (though it could be an array):
            *       t propname = propval FF
            * Get the type, property name and value
            cType = ALLTRIM( THIS.ExtrToken( @cWkgLine, ' ') )
            cPropName = ALLTRIM( THIS.ExtrToken( @cWkgLine, '=') )
            cPropVal = ALLTRIM( cWkgLine )

            * Don't try to set this property if it's Read-Only
            IF IsPropRO(cPropName)
                LOOP
            ENDIF

            * Do our standard conversion for all except arrays
            IF cType $ 'CMGNCLDT'
                STORE THIS.CharToX(cPropVal, cType) TO &cPropName

            * Arrays
            ELSE    && cType = 'A'

                * Here, we'll need to dimension the arrays and load them.  The
                * array format is:
                *     A propname = rr,cc^Telem1^Telem2...
                * where:
                *     rr - array rows
                *     cc - array cols
                *     T - element's variable type
                *     elemX - element's value

                * Get the number of rows and columns
                nRARows = VAL( THIS.ExtrToken( @cPropVal, ',') )
                nRACols = VAL( THIS.ExtrToken( @cPropVal, '^') )

                * Create a temporary array, aTemp([] so we don't have a lot of
                *   indirect referencing
                DIMENSION aTemp[ nRARows, nRACols ]

                * Load each element
                FOR nY = 1 TO (nRARows * nRACols)

                    * Get this element's string value
                    cRAVal = THIS.ExtrToken( @cPropVal, '^')

                    * Extract its type
                    cType = LEFT(cRAVal, 1)
                    IF LEN(cRAVal) = 1
                        cRAVal = ''
                    ELSE
                        cRAVal = SUBSTR(cRAVal, 2)
                    ENDIF

                    * Convert and save it
                    aTemp[nY] = THIS.CharToX(cRAVal, cType)

                    * If nothing's left in our string, we're done
                    IF EMPTY(cPropVal)
                        EXIT
                    ENDIF
                ENDFOR

                * Copy aTemp[] to make the object's property
                ACOPY( aTemp, &cPropName)
            ENDIF

            * Get the next line
        ENDDO   && WHILE NOT EMPTY(pcPropStr)

        * Done
        RETURN .T.
    ENDFUNC


        ***** PICTURE Functions *****

    *- ClearPict() - Remove all except characters and digits from passed string
    *     Input: cTheVar - Passed PICTURE string
    *            pbKeepSpcs - (optional) .T. if you want to keep spaces
    *      Retn: String with non-formatting chars removed
    *      Note: Was CLR_PICT
    FUNCTION ClearPict( pcStrIn, pbKeepSpcs )
        PRIVATE cGoodChars, cStrIn, nLenIn, cRetStr, nX, cThisChar

        * Define the allowable characters
        cGoodChars = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ' + ;
          IIF( pbKeepSpcs, ' ', '')

        * Copy only characters, digits, and (optionally) spaces into our return
        *   string
        cStrIn = pcStrIn
        nLenIn = LEN(cStrIn)
        cRetStr = ''
        FOR nX = 1 TO nLenIn
            cThisChr = SUBSTR(cStrIn, nX, 1)

            * Skip the characters we want to remove
            IF UPPER( cThisChr ) $ cGoodChars
                cRetStr = cRetStr + cThisChr
            ENDIF
        ENDFOR
        RETURN cRetStr
    ENDFUNC

    *- GetPicChrs() - Return the text substitute chars in a "PICTURE" string
    *     Input: cPictStr - Passed PICTURE string
    *      Retn: String with non-formatting chars removed
    *      Note: Was GTPICCHR
    FUNCTION GetPicChrs( pcPictStr )
        LOCAL cPicFmtChrs, cRetStr, nStrLen, nI, cChar

        * We want to return a string of the non-formatting picture characters
        cPicFmtChrs = THIS.cPictFormatChrs
        cRetStr = ''
        nStrLen = LEN(pcPictStr)
        FOR nI = 1 TO nStrLen
            cChar = SUBSTR( pcPictStr, nI, 1 )

            * Picture characters come in 2 flavors:
            *   -,.       = textual substitutions
            *   @ANXY9#!$ = format directive characters
            * Non-formatting picture characters are the textual substitution
            *   characters and any other non format directive characters.  Of
            *   course, we don't want to return spaces either
            IF NOT cChar $ cPicFmtChrs
                cRetStr = cRetStr + cChar
            ENDIF
        ENDFOR
        RETURN cRetStr
    ENDFUNC

    *- TrimPict() - Remove trailing picture characters from the passed string
    *     Input: cTheVar - Passed string
    *      Retn: String with trailing -,./\s removed
    *      Note: Was TRIMPICT
    FUNCTION TrimPict( pcTheVar )
        LOCAL cPicChrs, cRetVar, nX

        * Define the picture characters we want to remove.  Picture characters
        *   come as either format directives (@R, etc.) or:
        *       -,./\     = textual substitutions
        * We want to remove the textual substitution characters
        cPicChrs = THIS.cPictTextChrs
        cRetVar = pcTheVar
        IF RIGHT( TRIM(cRetVar), 1) $ cPicChrs
            DO WHILE RIGHT( TRIM(cRetVar), 1) $ cPicChrs
                nX = LEN( TRIM(cRetVar) )        && Point to the character
                cRetVar = STUFF(cRetVar, nX, 1, ' ')
            ENDDO
        ENDIF

        * Done
        RETURN cRetVar
    ENDFUNC

    * RemoveOddHexChars() - Remove hex characters 0h-31h, 255h except LF, CR, FF
    *     Input: cMemoIn - Memo string to be cleaned up
    *            bKillFF - Also remove the Form-Feed character (12h)
    FUNCTION RemoveOddHexChars(pcMemoIn, bKillFF)
        LOCAL cMemo, nX

        * Take out the special chars (DEC 1-31). VFP can't find 0h
        cMemo = pcMemoIn
        FOR nX = 0 TO 31

            * Leave 10 (LF), 13 (CR) and 12 (FF) there
            IF nX = 10 OR nX = 13 OR (nX = 12 AND NOT bKillFF)
                LOOP
            ENDIF

            * Do the comparing first
            IF CHR(nX) $ cMemo
                cMemo = STRTRAN(cMemo, CHR(nX), '')
            ENDIF
        ENDFOR

        * Also toss FFh character
        IF HEX_FF $ cMemo
            cMemo = STRTRAN(cMemo, HEX_FF, '')
        ENDIF

        * Done
        RETURN cMemo
    ENDFUNC

    * RemoveSpecChar() - Remove all hex characters 0h-31h but 10h, 12h and 13h
    FUNCTION RemoveSpecChar(cMemoIn)
        RETURN THIS.RemoveOddHexChars(cMemoIn)
    ENDFUNC


        ***** Type Conversions *****

    *- CharToX() - Convert a string to a variable of the passed type
    *     Input: cStrIn - String that may have embedded quotes
    *            cType - Type of conversion desired
    *      Retn: Desired value
    *      Note: Was CHARTOX
    FUNCTION CharToX( pcStrIn, pcType )
        LOCAL xRetVal

        * Did we goof?
        IF NOT (PCOUNT() = 2 AND TYPE('pcStrIn') = 'C' AND ;
          TYPE('pcType') = 'C' AND LEN(pcType) = 1)
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Assume this is Character, Memo, or General (no conversion)
        xRetVal = pcStrIn

        * Handle special conversions based on type
        DO CASE

        * Numeric, Currency
        CASE pcType $ 'NY'
            RETURN THIS.PostVal(pcStrIn)

        * Logical
        CASE pcType = 'L'
            RETURN (pcStrIn = 'Y' OR pcStrIn = '.T.')

        * Date
        CASE pcType = 'D'
            RETURN goDates.SToD(pcStrIn)

        * DateTime
        CASE pcType = 'T'
            RETURN goDates.C1ToT(pcStrIn)
        ENDCASE

        * Return our value if we haven't done so already
        RETURN xRetVal
    ENDFUNC

    *- XToChar() - Convert any value into a string
    *     Input: xValue - Value to be converted
    *      Retn: String after conversion
    *      Note: Was XTOCHAR
    FUNCTION XToChar( pxValue )
        LOCAL cOldSet, cRetVal

        * Did we goof?
        IF NOT PCOUNT() = 1
            ERROR 'Invalid parameters were passed'
        ENDIF

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

    *- GetDurationStr() - Return a human readable time string
    *     Input: xSeconds - Number of elapsed seconds
    *      Retn: ww days, xx hrs, yy mins and zz secs
    *      Note: The leading items won't be shown if they're 0
    FUNCTION GetDurationStr(nNumSecs)
        LOCAL cTimeStr, nDays, nHrs, nMins, nSecs, cNewStr

        * Convert the seconds to days, hours, minutes and seconds
        IF nNumSecs < 120
            cSecs = TRANSFORM(nNumSecs)
            DO WHILE RIGHT(cSecs, 1) = '0'
                cSecs = LEFT(cSecs, LEN(cSecs)-1)
            ENDDO
            IF RIGHT(cSecs, 1) = '.'
                cSecs = LEFT(cSecs, LEN(cSecs)-1)
            ENDIF
            cTimeStr = LTRIM(STR( nNumSecs )) + ' ' + ;
              THIS.Plural('sec', nNumSecs)
        ELSE
            nSecs = ROUNDOFF(nNumSecs, 0)
            nSecs = INT(nSecs)
            STORE 0 TO nDays, nHrs, nMins
            nHrs = INT(nSecs/3600)
            nSecs = nSecs - (nHrs * 3600)
            IF nHrs > 47
                nDays = INT(nHrs / 24)
                nHrs = nHrs - (nDays * 24)
            ENDIF
            nMins = INT(nSecs/60)
            nSecs = nSecs - (nMins * 60)
            cTimeStr = ''
            IF nDays > 0
                cTimeStr = LTRIM(STR( nDays )) + ' ' + THIS.Plural('day', nDays)
            ENDIF
            IF nHrs > 0 OR NOT EMPTY(cTimeStr)
                cNewStr = LTRIM(STR( nHrs )) + ' ' +  THIS.Plural('hr', nHrs)
                cTimeStr = THIS.AddToString(cTimeStr, cNewStr, ',')
            ENDIF
            IF nMins > 0 OR NOT EMPTY(cTimeStr)
                cNewStr = LTRIM(STR( nMins )) + ' ' + THIS.Plural('min', nMins)
                cTimeStr = THIS.AddToString(cTimeStr, cNewStr, ',')
            ENDIF
            cNewStr = LTRIM(STR( nSecs )) + ' ' + THIS.Plural('sec', nSecs)
            IF EMPTY(cTimeStr)
                cTimeStr = cNewStr
            ELSE
                cTimeStr = THIS.AddToString(cTimeStr, cNewStr, ' and')
            ENDIF
            cTimeStr = cTimeStr
        ENDIF
        RETURN cTimeStr
    ENDFUNC


        ***** String Incrementing *****

    *- IncrNumbPart() - Increment numbers within a string keeping any chars
    *       Base 10; no length change, will use spaces on right if needed.
    *     Input: cStrIn - String to be incremented
    *      Retn: Incremented String
    *      Note: Was INCR_CHR
    FUNCTION IncrNumbPart( pcStrIn )
        LOCAL bFlushRt, nVarLen, cVarIn, cDigitStr, cCharStr, nX, cChar, ;
          nDigLen, nNewNumb, cRetStr

        * pcStrIn has a character string composed of letters and digits; for
        *   example: "A2B109".  We have to increment the numeric part ("109)
        *   and return the result.

        * The passed variable could be flush-right or flush-left.
        bFlushRt = (LEFT(pcStrIn,1) = ' ')

        * And, we can't change the overall length
        nVarLen = LEN(pcStrIn)

        * Trim the passed variable and put the trailing digits into cDigitStr
        *   and any alpha characters into cChars
        cVarIn = ALLTRIM(pcStrIn)
        STORE '' TO cDigitStr, cCharStr
        FOR nX = LEN(cVarIn) TO 1 STEP -1
            cChar = SUBSTR(cVarIn, nX, 1)
            IF cChar $ '1234567890'
                cDigitStr = cChar + cDigitStr
            ELSE
                cCharStr = LEFT(cVarIn, nX)
                EXIT
            ENDIF
        ENDFOR

        * Increment the digits part
        nDigLen = LEN(cDigitStr)
        nNewNumb = INT( VAL(cDigitStr)) + 1

        * Put 'em back in a string - but don't let it be shorter than the
        *   original string (longer is OK).
        cDigitStr = LTRIM( STR(nNewNumb) )
        IF LEN(cDigitStr) < nDigLen
            cDigitStr = PADL(cDigitStr, nDigLen, '0')
        ENDIF

        * Add any characters from the original
        cRetStr = cCharStr + cDigitStr

        * Make the variable the correct length; but throw a bug if we can't
        *   make it longer
        DO CASE
        CASE LEN(cRetStr) < nVarLen
            IF bFlushRt
                cRetStr = PADL(cRetStr, nVarLen, ' ')
            ELSE
                cRetStr = PADR(cRetStr, nVarLen, ' ')
            ENDIF
        CASE LEN(cRetStr) <> nVarLen
            ERROR 'Variable too long in THIS.IncrNumbPart(' + pcStrIn + ')'
        ENDCASE
        RETURN cRetStr
    ENDFUNC

    *- IncrNumeric() - Numerically increment a string and 0-fill on left
    *       Base 10; no length change, will 0-fill from left if needed.
    *     Input: cStrIn - String to be incremented
    *            nIncrAmt - (optional) desired incrementing amount (default = 1)
    *            cLeftFill - (optional) Other left filling character (default = '0')
    *      Retn: Incremented String
    *      Note: Was INCR_ID
    *      Retn: Incremented String
    FUNCTION IncrNumeric(pcStrIn, pnIncrAmt, pcLeftFill)
        LOCAL nStrLen, cRetStr

        * Get the length
        nStrLen = LEN(pcStrIn)

        * Check the parameters
        IF TYPE('pnIncrAmt') <> 'N'
            pnIncrAmt = 1
        ENDIF
        IF TYPE('pcLeftFill') <> 'C'
            pcLeftFill = [0]
        ENDIF

        * Get the value and increment it
        nNewVal = THIS.PostVal(pcStrIn) + pnIncrAmt

        * Note that if we overflow, we'll get a bug for the STR() conversion
        cRetStr = LTRIM( STR(nNewVal, nStrLen) )
        RETURN PADL(cRetStr, nStrLen, pcLeftFill)
    ENDFUNC

    *- IncrAlpha() - Alpha- or Alphanum- increment a string and zero-fill on left
    *       Base 26 (alpha) or 36 (alphanum); no length change, will 0 fill
    *       (alphanum) or space fill (alpha) from left if needed; ignores
    *       trailing spaces.
    *     Input: cStrIn - String to be incremented
    *            bAlphaOnly - (optional) .T. if base 26 incrementing is wanted
    *                           default = .F.
    *      Retn: Incremented String
    *      Note: Was INCR_IDA
    FUNCTION IncrAlpha( pcStrIn, pbAlphaOnly )
        LOCAL cIncrOrder, cRetStr, nX, cThisChar, nY

        * If the string is empty, return something like '00001'
        IF EMPTY(pcStrIn)
            IF LEN(pcStrIn) < 2
                IF pbAlphaOnly
                    RETURN 'A'
                ELSE
                    RETURN '1'
                ENDIF
            ENDIF
            IF pbAlphaOnly
                RETURN REPLICATE( ' ', LEN(pcStrIn) - 1 ) + 'A'
            ELSE
                RETURN REPLICATE( '0', LEN(pcStrIn) - 1 ) + '1'
            ENDIF
        ENDIF

        * Here, we want to alpha-numerically increment the passed string.
        *   Increment is based on the following letter order:
        IF pbAlphaOnly           && Used to increment Revision letters, etc.
            cIncrOrder = " ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        ELSE
            cIncrOrder = " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        ENDIF

        * Setup our return string
        cRetStr = pcStrIn

        * We won't touch trailing spaces
        nX = LEN( TRIM(cRetStr) )

        * As the string is not empty, increment the characters
        DO WHILE nX > 0
            cThisChar = SUBSTR( cRetStr, nX, 1 )
            nY = AT( cThisChar, cIncrOrder)

            * Handle all possible conditions
            DO CASE

            * Unknown character - leave it alone
            CASE nY = 0
                nX = nX - 1     && Go increment the previous character

            * If it's at the end, substitute the first character, but keep going
            *   to handle a "carry"
            CASE cThisChar = RIGHT( cIncrOrder, 1)

                * Our increment string has the first character as a space, but
                *   that's only for incrementing spaces; skip that and use the
                *   next character
                cRetStr = STUFF( cRetStr, nX, 1, SUBSTR( cIncrOrder, 2, 1) )
                nX = nX - 1     && Go increment the previous character

            * Otherwise, the character is in our string and incrementable
            OTHERWISE
                cRetStr = STUFF( cRetStr, nX, 1, SUBSTR( cIncrOrder, nY+1, 1) )
                EXIT
            ENDCASE
        ENDDO
        RETURN cRetStr
    ENDFUNC

    *- IncrFLStr() - Alphanum- or numerically-increment a flush left string
    *       Base 36 (alphanum) or 10 (numeric); no length change but spaces on
    *       the right may be used if needed, no other fills.
    *     Input: cStrIn - String to be incremented
    *            cIncrType - (optional) Increment type:
    *                           'A' - alphanumeric incrementing (base 36)
    *                           '1' - numeric incrementing (base 10)
    *                       default is to do an alphanumeric increment if the
    *                       passed string has any characters, else to do a
    *                       numeric increment.
    *      Retn: Incremented String
    *      Note: Was INCR_L
    FUNCTION IncrFLStr( pcStrIn, pcIncrType )
        LOCAL nStrLen, cTrimStr, nTrimLen, bAlpha, nY

        * Our incoming string is flush left (e.g. "11   ") it is to be
        *   incremented and, new digits added to the right).

        * We have 2 modes of incrementing:
        *   Numerically (e.g. add 1 to the VALue of the string)
        *   Alphabetically (e.g. add 1 to a base-36 number consisting of:
        *       01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ)
        * The default behavior is to look in the passed string for an
        *   alphabetic character; if found we do an alpha increment, otherwise
        *   we do a decimal increment.
        * But, pcIncrType is for overriding that default behavior.  If
        *   pcIncrType is passed, we'll look thru that string to decide how to
        *   increment.  For example:
        *       If pcIncrType = 'A', we'll increment alphabetically
        *       If pcIncrType = '1', we'll increment numerically

        * If the string is empty, return '1'
        IF EMPTY(pcStrIn)
            IF LEN(pcStrIn) < 2
                RETURN '1'
            ENDIF
        ENDIF

        * Define the length of the string and the length of the trimmed string
        nStrLen = LEN(pcStrIn)
        cTrimStr = TRIM(pcStrIn)
        nTrimLen = MIN(nStrLen, LEN( TRIM(cTrimStr) ) )

        * Do we have any alphabetic characters in the string?
        bAlpha = .F.
        IF TYPE('pcIncrType') = 'C' AND NOT EMPTY(pcIncrType)
            bAlpha = ISALPHA( LEFT(pcIncrType, 1) )
        ELSE
            FOR nY = 1 TO nTrimLen
                IF ISALPHA( SUBSTR(cTrimStr,nY,1) )
                    bAlpha = .T.
                    EXIT
                ENDIF
            ENDFOR
        ENDIF

        * Now, we'll call the appropriate INCR function with the TRIMMED string
        *   after testing for overflow
        IF bAlpha
            IF cTrimStr = REPLICATE( 'Z', nTrimLen )
                cTrimStr = ' ' + cTrimStr
                nTrimLen = nTrimLen + 1
                IF nTrimLen > nStrLen
                    nStrLen = nTrimLen
                ENDIF
            ENDIF
            cTrimStr = THIS.IncrAlpha(cTrimStr)
        ELSE
            IF cTrimStr = REPLICATE( '9', nTrimLen )
                cTrimStr = ' ' + cTrimStr
                nTrimLen = nTrimLen + 1
                IF nTrimLen > nStrLen
                    nStrLen = nTrimLen
                ENDIF
            ENDIF
            cTrimStr = THIS.IncrNumeric(cTrimStr)
        ENDIF

        * Now, make sure the string is the correct length
        RETURN cTrimStr + SPACE( nStrLen - nTrimLen )
    ENDFUNC

    *- IncrFRStr() - Alphanum- or numerically-increment a flush right string
    *       Base 36 (alphanum) or 10 (numeric); no length change but spaces on
    *       the left may be used if needed, no other fills.
    *     Input: cStrIn - String to be incremented
    *            cIncrType - (optional) Increment type:
    *                           'A' - alphanumeric incrementing (base 36)
    *                           '1' - numeric incrementing (base 10)
    *                       default is to do an alphanumeric increment if the
    *                       passed string has any characters, else to do a
    *                       numeric increment.
    *      Retn: Incremented String
    *      Note: Was INCR_R
    FUNCTION IncrFRStr( pcStrIn, pcIncrType )
        LOCAL nStrLen, cRetStr

        * Our incoming string is flush right (e.g. "   11") it is to be
        *   incremented and, new digits added to the left).
        nStrLen = LEN(pcStrIn)

        * We're going to call THIS.IncrFLStr but that expects a flush-left
        *   string; so give it that plus a space
        IF LEFT(pcStrIn, 1) = ' '
            cRetStr = THIS.IncrFLStr( ' ' + THIS.FlushLeft(pcStrIn), pcIncrType )
        ELSE
            cRetStr = THIS.IncrFLStr( pcStrIn, pcIncrType )
        ENDIF

        * Now, make it the right length
        IF LEN(cRetStr) <> nStrLen
            cRetStr = THIS.MakeLen(cRetStr, nStrLen)
        ENDIF

        * Return the string flush right
        RETURN THIS.FlushRight( cRetStr )
    ENDFUNC


        ***** Multiple Option Strings *****

    *- GetNextOption() - Extract the next Name:Value pair from an option string
    *     Input: cOptStr - String of options containing Name=Value pairs like:
    *                       "Name1=Value1^Name2=Value2^Name3=Value3^..."
    *            cValue - The option's value (passed as @cValue; default = '')
    *            cNameSep - (optional) char separating Name and Value (default = ':')
    *            cOptionSep - (optional) char separating Options (default = '~')
    *      Retn: The Name of the option; cValue is filled in
    FUNCTION GetNextOption( pcOptStr, pcValue, pcNameSep, pcOptionSep )
        LOCAL cNameSep, cOptionSep, cThisOpt, cOptName

        * Define our separator characters and override them as needed
        cNameSep = ':'
        IF VARTYPE(pcNameSep) = 'C' AND LEN(pcNameSep) = 1
            cNameSep = pcNameSep
        ENDIF
        cOptionSep = '~'
        IF VARTYPE(pcOptionSep) = 'C' AND LEN(pcOptionSep) = 1
            cOptionSep = pcOptionSep
        ENDIF

        * Get the next option
        cThisOpt = THIS.ExtrToken( @pcOptStr, cOptionSep)

        * Separate the option's Name and Value
        cOptName = ALLTRIM( THIS.ExtrToken( @cThisOpt, cNameSep) )

        * Set the return value
        pcValue = ALLTRIM(cThisOpt)

        * Done, return the name
        RETURN cOptName
    ENDFUNC


        ***** Combining Strings *****

    *- SetCityStateZip() - Return City, State, Zip combined
    *     Input: cCity - The city in question
    *            cState - The state
    *            cZip - The Zip code
    * Retn: [City, State  Zip]
    FUNCTION SetCityStateZip(cCity, cState, cZip)
        LOCAL cRetStr

        * Define our default
        cRetStr = ''

        * Put in the City (if we have it)
        IF VARTYPE(cCity) = 'C' AND NOT EMPTY(cCity)
            cRetStr = ALLTRIM(cCity)
        ENDIF

        * Add the state and a comma
        IF VARTYPE(cState) = 'C' AND NOT EMPTY(cState)
            cRetStr = IIF( EMPTY(cRetStr), '', cRetStr + [, ]) + ALLTRIM(cState)
        ENDIF

        * Finally, the Zip Code prefaced by 2 spaces
        IF VARTYPE(cZip) = 'C' AND NOT EMPTY(cZip)
            cOurZip = THIS.TrimPict( ALLTRIM(cZip) )
            IF LEN(cOurZip) > 5
                cOurZip = TRANSFORM(cOurZip, '@R 99999-9999')
            ENDIF
            cRetStr = IIF( EMPTY(cRetStr), '', cRetStr + [  ]) + cOurZip
        ENDIF

        * Done, return the string
        RETURN cRetStr
    ENDFUNC

    *- AddToString() - Add string to another with separator if neither is empty
    *     Input: cStr1 - The starting string
    *            cStr2 - The string to be added
    *            cSep - The separator (, ; and so forth)
    *     Retn: If neither string is empty: cStr1 + cSep + ' ' + cStr2
    *           If either string is empty, it's just the non-empty string
    FUNCTION AddToString(cStr1, cStr2, cSep)
        LOCAL cRetStr

        * There are only 3 possibilities
        DO CASE
        CASE EMPTY(cStr2)
            cRetStr = cStr1
        CASE EMPTY(cStr1)
            cRetStr = cStr2
        OTHERWISE
            cRetStr = cStr1 + cSep + ' ' + cStr2
        ENDCASE
        RETURN cRetStr
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

    *- Release() - Releases a FormSet or Form from memory.
    PROCEDURE Release
        RELEASE THIS
    ENDPROC
ENDDEFINE
