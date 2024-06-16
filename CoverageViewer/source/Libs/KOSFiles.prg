#IF 0                           KOSFiles.prg

  Purpose:  General purpose OS Drive, Directory and File handling.

Revisions:  March 20, 1999 - Ken Green - Adapted from original KOSFilers.prg
                        started in 6/22/1999 with a last rev date of 12/07/15.

 Requires:  zArrays.prg - ArrayObj classes used for DirInfo() and FileInfo()

******************************* Program Notes *******************************

    KOSFILES is just a front-end object for a function collection.  The
oOSFiles object was initialized by goApp.  So, calls to this are really just
method invocations.  For example, to open a low-level file for read-write
operations, you'd call this like:
        nHandle = goFiles.LL_Open( cFileName )

***************************** Available Methods *****************************

Drives:

 IsDrive() - Return .T. if passed drive letter is a valid drive
    Input: pcDrvLtr - Drive letter in question
     Retn: .T. if pcDirName is a valid drive, else .F.

 GetDriveFreeSpace() - Return a drive's free space in bytes
   Input: pcDrvLtr - Drive letter in question (can have trailing colon)
    Retn: Free space on drive in bytes


Directories:

 DirInfo() - Return an array object of file/dir information for a directory
    Input: pcDirSpec - Path for files (can be empty)
           pcFileSpec - File Spec (default = '*.*')
           pbSubdirs - .T. if you want subdirectories also
     Retn: DirArray object for passed directory with the following format:
                .aRA[x,1] - File name (C) (includes extension)
                .aRA[x,2] - File size (N):
                .aRA[x,3] - File date (D)
                .aRA[x,4] - File Time (C)
                .aRA[x,5] - File Attributes (C):
                      Letter        Attribute
                      컴컴컴        컴컴컴컴�
                        A            Archive (Read and Write)
                        H            Hidden
                        R            Read only
                        S            System
                        D            Directory

 DirListOnly() - Return an array object of dir information for a passed spec
    Input: pcDirSpec - Path for directories (can be empty for current dir)
           pbNoSort - Pass .T. if you don't want the list sorted by name
     Retn: DirArray object for passed directory with the following format:
                .aRA[x,1] - File name (C) (includes extension)
                .aRA[x,2] - File size (N):
                .aRA[x,3] - File date (D)
                .aRA[x,4] - File Time (C)
                .aRA[x,5] - File Attributes (C):
                      Letter        Attribute
                      컴컴컴        컴컴컴컴�
                        A            Archive (Read and Write)
                        H            Hidden
                        R            Read only
                        S            System
                        D            Directory

 AnyFiles() - Return .T. if any files exist matching the passed filespec
    Input: pcFileSpec - File Specification (e.g. "*.TXT" OR "JUNK??.TXT")
     Retn: .T. If any files exist that match the spec

 FileList() - Return a list of files matching passed specs as file1,file2...
    Input: pcDirSpec - Path string to get files from (can be empty)
           pcFileSpec - File Specification (e.g. *.TXT)
           pbKillExt - (optional) .T. if ext is to be removed from filename
     Retn: List of files as file1,file2,...

 CheckLastSep() - Make sure the passed path has a trailing \, or remove it
    Input: pcPath - Path string to test
           pbKillSep - If .T. last \ is removed if it's there
     Retn: pcPath with (or without) a trailing \

 CheckDirSep() - Return the passed path with all directory separators as \
    Input: pcPath - Path string to test
     Retn: pcPath with all directory separators as \

 LastDirPosn() - Return the last drive or directory separator position
    Input: pcPath - Path string to test
     Retn: Position of last directory separator: \ or :

 FullPath() - Return the full path from a partial directory (e.g. "..\..")
    Input: pcPathSpec - Path string to test
     Retn: The fully qualified directory name (e.g. "E:\ALI\DATA")

 MinPath() - Return the minimum path from current or passed directory
   Input: pcFullSpec - Full path or file string to check
          pcCompareTo - (optional) Directory to compare it to (default =
                          current directory
    Retn: The mimimallyy qualified directory name
      Example: MinPath([E:\ALI\DATA\SAVE], [E:\ALI]) = [DATA\SAVE]

 JustDrive() - Return only the drive and colon from the passed path/filespec
    Input: pcFileSpec - Path/File string to test
     Retn: Only the Drive and : part of pcFileSpec

 IsADir() - Determine whether the passed spec is a directory
    Input: pcDirName - Directory Name in question
     Retn: .T. if pcDirName is a directory, else .F.

 MakeDir() - Create the passed directory name
    Input: pcDirName - Directory Name to create
     Retn: .T. if pcDirName exists, else .F.

 RemDir() - Remove the passed directory (must be empty)
    Input: pcDirName - Directory Name to remove
     Retn: .T. if pcDirName is removed, else .F.

 ZapDir() - Remove an entire directory tree
    Input: pcDirName - Directory Name to remove
           nTrySecs - Secs to keep trying (0 = one try only)
     Retn: .T. if pcDirName removed, else .F.

 IncrDirName() - Return a directory name based on incrementing trailing digits
    Input: pcPref - Directory name's preface text
           pnFileLen - Desired length of filename
     Retn: Non-existing directory name as Preface + Number

 GetFileDescription() - Return a file's information in an object
    Input: pcDirName - Directory Name (can also have file name)
           pcFileName - (optional) File name (without path)
     Retn: File description object; properties:
            .cFileName (no path but with extension)
            .cExt - file extension
            .dDate - file date
            .cTime - file time
            .nSize - file size (bytes)
            .cAttrib - file attributes in RHSDA format
            .cPath - directory for file (with trailing backslash)
            .bFound - .T. if file found

 FindFirstFile() - Return an object containing the FIRST file's info in a dir
    Input: pcPathSpec - Path/file spec string
     Retn: File description object, see GetFileDescription()

 FindNextFile() - Return an object containing the NEXT file's info in a dir
    Input: pcPathSpec - Path/file spec string - same as FindFirstFile()
     Retn: File description object, see GetFileDescription()

 WaitForFile() - Return when a file has finished being created
    Input: pcPathSpec - Path/file spec string
           pnLimitSecs - Max. seconds to wait
     Retn: .T. if file found, else .F.


FileNames:

 UniqueTempName() - Return a temporary filename that doesn't exist
    Input: pcExt - The file extension that will be used
           pcDir - The directory for the file (default = '.\')
     Retn: A unique 8-character filename not on pcDir with pcExt

 JustPath() - Return only the path from the passed spec
    Input: pcPathSpec - Path/file string to test
     Retn: Only the drive and directory part of pcPathSpec

 JustFile() - Return only the file name/extension from the passed filespec
    Input: pcFileSpec - File string to test
     Retn: Only the file name/ext part of pcFileSpec

 JustFName() - Return only the file name (no ext) from the passed filespec
    Input: pcFileSpec - File string to test
     Retn: Only the file name (no ext) part of pcFileSpec

 JustFExt() - Return only the extension from the passed filespec
    Input: pcFileSpec - File string to test
     Retn: Only the file ext part of pcFileSpec

 IncrFName() - Return a filename setting the filename based on the next number
    Input: pcPref - Filename preface text
           pcExt - File's extension
           pcDir - Destination directory for file
     Retn: Non-existing filename as Preface + Number + .Ext

 IncrFName0() - Return a filename defined based on 0s + the next number
    Input: pcPref - Filename preface text
           pcExt - File's extension
           pcDir - Destination directory for file
           pnMaxDigits - (optional) Max digits to use (def: name = 8)
     Retn: Non-existing filename as Preface + Number + .Ext

 IncrFExt() - Return a filename setting the extension based on the next number
    Input: pcFileSpec - File Specification including directory (no extension)
     Retn: Non-existing filename as pcFileSpec + .NewExt

File Manipulations:

 IsAFile() - Return .T. if the passed file spec exists (wild cards OK)
    Input: pcFileName - File Name in question
     Retn: .T. if pcFileName is a file, else .F.

 FileInfo() - Return an array object of file information
    Input: pcFileNm - File name in question
     Retn: Array object for passed file in the format of:
           .aRA[1] - File name (C) (includes extension)
           .aRA[2] - File size (N)
           .aRA[3] - File date (D)
           .aRA[4] - File Time (C)
           .aRA[5] - File Attributes (C)

 FileSize() - Return the size of a file
    Input: pcFileNm - File name in question
     Retn: File Size (N)

 FileDate() - Return a file's date
    Input: pcFileNm - File name in question
     Retn: File Date (D)

 FileTime() - Return a file's time
    Input: pcFileNm - File name in question
     Retn: File Time (C>

 FileAttr() - Return a file's attributes
    Input: pcFileNm - File name in question
     Retn: Attributes (C)

 SetFileAttrs() - Change a file's attributes
    Input: pcFileNm - File name in question
           Desired new Attributes (C): A, R, H, S - singly or mixed together
     Retn: .T. if set properly

 FindAppFile() - Locate an application file on one of our directories
    Input: pcFileNm - File name to locate
     Retn: File name with directory (unchanged if not found)

 CopyFile() - Copy a file from one directory to another
    Input: pcSrcFile - Source file spec (name and dir as needed)
           pcDstDir - Destination file spec (can include filename)
           pbUseTemp - .T. if copy is to be done to a temp file, then renamed
           pbNoBugFileWanted - if a error will return .F. (not bug file created)
     Retn: .T. if copy succeeded, else .F.

 CopyAllFiles() - Copy file matching a passed spec from one directory to another
    Input: pcFilSpec - File spec including path and wildcards (can be *.*)
           pcDstDir - Destination file spec (can include filename)
     Retn: Number of files copied (0 if none)

 MoveFile() - Move a file from one drive/directory to another
    Input: pcSrcFile - Source file spec (name and dir as needed)
           pcDstDir - Destination file spec (can include filename)
           pbUseTemp - .T. if copy is to be done to a temp file, then renamed
           pbNoBugFileWanted - if a error will return .F. (not bug file created)
     Retn: .T. if move succeeded, else .F.

 RenameFile() - Rename a passed filename
    Input: pcFileName - File to rename (can include path)
           pcNewName - New name for the file
     Retn: .T. if file renamed (.F. if not)

 DeleteFile() - Delete a passed filename
    Input: pcDelFile - File to delete (can include path)
     Retn: .T. if file deleted (.F. if not)

 DeleteAllFiles() - Delete all files matching a passed file spec
    Input: pcDelSpec - File spec including path and wildcards (can be *.*)
     Retn: Number of files deleted (0 if none)

 FileToStr() - Open, read and close a file; return its contents as a string
    Input: pcFileName - File Name
     Retn: String containing file's contents.
           The error handler is called on any failure

 StrToFile() - Open a file, write a string into it and close it
    Input: pcOutStr - String to write
           pcFileName - File Name
           pbAppend - .T. if we're to append to the file
     Retn: .T.; The error handler is called on any failure

 FileToArray() - Open, read and close a file; return its contents as an array
    Input: pcFileName - File Name
     Retn: Array object (Class: ArrayObj) containing 1 line/row
           The error handler is called on any failure

 ArrayToFile() - Open a file, write each line from an array into it and close it
    Input: poLineArray - Array object (Class: ArrayObj) of lines to write
           pcFileName - File Name
           pbDoPurge - .T. if we're to clear the file first
     Retn: .T.; The error handler is called on any failure


Low-level file functions:

 LL_Open() - Return "handle" after create/open a "low-level" read/write file
    Input: pcFileName - File name to open
           pcAction - (optional) 'W' (default) = Read/Write, 'R' = Read Only,
                        'P' = Purge the file's contents (implies R/W)
     Retn: The file "handle" needed for future references to this file
           The error handler is called if open fails

 LL_Read() - Read a line from a low-level file
    Input: nLLHndl - Previously opened file handle
           bStripCRLF - (optional) If .T., strip CR, LF from end of line
           nBytes2Read - (optional) No. of bytes desired (default = 254)
     Retn: One line read from the file (if FEOF(), returns null string)
           The error handler is called if handle is invalid

 LL_Write() - Write a string to a low-level file
    Input: pnLLHndl - Previously opened file handle
           pcWriteStr - String to be written
           pbNoCrLf - (optional) If .T., no CR, LF's are added
     Retn: .T.; string written adding CR, LF if desired.
           Error handler called if incorrect number of bytes written or
             handle is invalid.

 LL_Flush() - Flush a low-level file
   Input: pnLLHndl - Previously opened file handle
          pbForceIt - .T. = Force Windows to flush now, .F. = let VFP do
                      it at its convenience
    Retn: .T. and file Flushed.

 LL_Close() - Close a low-level file
    Input: pnLLHndl - Previously opened file handle
     Retn: .T.; file closed.
           Error handler called if close fails.

 LL_ToEOF() - Position a low-level file to FEOF()
    Input: pnLLHndl - Previously opened file handle
     Retn: Number of bytes moved; file is at FEOF().
           The error handler is called if handle is invalid

 LL_ToBOF() - Position a low-level file to FBOF()
    Input: pnLLHndl - Previously opened file handle
     Retn: Number of bytes moved; file is at beginning.
           The error handler is called if handle is invalid

 LL_IsLock() - Return .T. if the file is locked
    Input: pcFileName - File name to locked
     Retn: .T. is return is the file is locked

Buffered File Handling:
    See notes in KBufferedFile Class and KBufferedLines Class, below.


Other:
 PROT ExtrToken() - Extract and return the text before a passed token (char)

 GetAttribNumb() - Convert attribute chars into numbers (rel or abs)
 AttrDW2Chars() - Convert an attribute double-word into characters
 GetLastAPIError() - Return the last error message
 ClearError() - Clear our error properties

 Release() - Removes this object from memory
    Input: none
     Retn: object gone, memory released

****************************** Classes Defined ******************************

* KOSFiles Class Definition for this function class
* KBufferedFile Class Definition for this function class
* KBufferedLines Class Definition for this function class

*****************************************************************************
#ENDIF

* Includes
#INCLUDE APPINCL.H

* Defines
#DEFINE OS_ADDCRLF  .F.
#DEFINE OS_NOCRLF   .T.
#DEFINE CR_LF       CHR(13) + CHR(10)

* FormatMessage() parameters (WinAPI)
#DEFINE FORMAT_MESSAGE_ALLOCATE_BUFFER 0x100
#DEFINE FORMAT_MESSAGE_ARGUMENT_ARRAY 0x2000
#DEFINE FORMAT_MESSAGE_FROM_STRING 0x400
#DEFINE FORMAT_MESSAGE_FROM_SYSTEM 0x1000
#DEFINE FORMAT_MESSAGE_IGNORE_INSERTS 0x200
#DEFINE FORMAT_MESSAGE_MAX_WIDTH_MASK 0xFF

* File Attributes (WinAPI)
#DEFINE FILE_ATTRIBUTE_READONLY       1
#DEFINE FILE_ATTRIBUTE_HIDDEN         2
#DEFINE FILE_ATTRIBUTE_SYSTEM         4
#DEFINE FILE_ATTRIBUTE_DIRECTORY     16
#DEFINE FILE_ATTRIBUTE_ARCHIVE       32
#DEFINE FILE_ATTRIBUTE_NORMAL       128
#DEFINE FILE_ATTRIBUTE_TEMPORARY    512
#DEFINE FILE_ATTRIBUTE_COMPRESSED  2048

* KOSFiles Class Definition for this function class
DEFINE CLASS KOSFiles AS Custom

    * Custom Properties
    Name = 'KOSFiles'
    bHandle1705 = .F.       && .T. if we're to handle 1705 - Access Denied errors
    nLastErrorNumb = 0          && API Error Code
    cLastErrorMsg = ''          && API Error Message

    * Block the Properties not relevant here
    PROTECTED Application, ClassLibrary, Comment, ControlCount, Controls, ;
      Height, HelpContextID, Left, Object, Picture, Tag, Top, WhatsThisHelpID, ;
      Width

    * Block the Methods not relevant here
    PROTECTED AddObject, AddProperty, NewObject, ReadExpression, ReadMethod, ;
      RemoveObject, ResetToDefault, SaveAsClass, ShowWhatsThis, ;
      WriteExpression, WriteMethod

    * Custom Methods (see list above).

    * Init() - Set ourselves up
    FUNCTION Init()
        LOCAL bRetVal
        bRetVal = DODEFAULT()
        NODEFAULT

        * Add our WinAPI Declarations
        DECLARE INTEGER CopyFile IN kernel32 ;
          STRING lpExistingFileName, STRING lpNewFileName, INTEGER bFailIfExists
        DECLARE INTEGER DeleteFile IN kernel32 STRING lpFileName

        DECLARE INTEGER FormatMessage IN kernel32 INTEGER dwFlags, ;
          INTEGER lpSource, INTEGER dwMessageId, INTEGER dwLanguageId, ;
          INTEGER @lpBuffer, INTEGER nSize, INTEGER Arguments
        DECLARE RtlMoveMemory IN kernel32 As CopyMemory ;
          STRING @Destination, INTEGER Source, INTEGER nLength
        DECLARE INTEGER LocalFree IN kernel32 INTEGER hMem

        DECLARE INTEGER GetFileAttributes IN kernel32 STRING lpFileName
        DECLARE SHORT SetFileAttributes IN kernel32 STRING lpFileName, ;
          INTEGER dwFileAttributes

        DECLARE INTEGER GetLastError IN kernel32

        * Done
        RETURN bRetVal
    ENDFUNC

    * IsDrive() - Return .T. if passed drive letter is a valid drive
    *    Input: pcDrvLtr - Drive letter in question
    *     Retn: .T. if pcDirName is a valid drive, else .F.
    FUNCTION IsDrive( pcDrvLtr )
        LOCAL nGoodDrives, bIsOK

        * Check for valid parameters
        IF NOT (PCOUNT() = 1 AND TYPE('pcDrvLtr') = 'C' AND ;
          LEN(pcDrvLtr) >= 1)
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Get a list of the valid drive letters
        DECLARE INTEGER GetLogicalDrives IN Win32API
        nGoodDrives = GetLogicalDrives()

        * Is the passed drive in that list?
        bIsOK = BITTEST( nGoodDrives, ASC( UPPER(pcDrvLtr) ) - 65)
        RETURN bIsOK
    ENDFUNC

    *- GetDriveFreeSpace() - Return a drive's free space in bytes
    *    Input: pcDrvLtr - Drive letter in question (can have trailing colon)
    *     Retn: Free space on drive in bytes
    FUNCTION GetDriveFreeSpace(cDrive)
        LOCAL nSpace
        nSpace = DISKSPACE(cDrive)
        RETURN nSpace
    ENDFUNC

    *- DirInfo() - Return an array object of file/dir information for a directory
    *     Input: pcDirSpec - Path for files (can be empty)
    *            pcFileSpec - File Spec (default = '*.*')
    *            pxSubdirs - .T. if you want subdirectories also, OR
    *                        your own attribute list (e.g. "AR")
    *      Retn: DirArray object for passed directory with the following format:
    *                 .aRA[x,1] - File name (C) (includes extension)
    *                 .aRA[x,2] - File size (N):
    *                 .aRA[x,3] - File date (D)
    *                 .aRA[x,4] - File Time (C)
    *                 .aRA[x,5] - File Attributes (C):
    *                       Letter        Attribute
    *                       컴컴컴        컴컴컴컴�
    *                         A            Archive (Read and Write)
    *                         H            Hidden
    *                         R            Read only
    *                         S            System
    *                         D            Directory
    FUNCTION DirInfo( pcDirSpec, pcFileSpec, pxSubdirs )
        LOCAL cDirSpec, cAttribs, oDirObj, nRARow

        * Define the directory desired
        IF NOT EMPTY(pcDirSpec)
            cDirSpec = THIS.CheckLastSep(pcDirSpec)
        ELSE
            cDirSpec = '.\'
        ENDIF

        * Define the file spec desired
        IF VARTYPE(pcFileSpec) = 'C' AND NOT EMPTY(pcFileSpec)
            cDirSpec = cDirSpec + pcFileSpec
        ELSE
            cDirSpec = cDirSpec + '*.*'
        ENDIF

        * Define the attributes we want
        IF VARTYPE(pxSubdirs) = 'C' AND NOT EMPTY(pxSubdirs)
            cAttribs = pxSubdirs
        ELSE
            cAttribs = 'AHRS' + IIF(pxSubdirs, 'D', '')
        ENDIF

        * Get the directory array object
        oDirObj = CREATEOBJECT( 'DirArray', cDirSpec, cAttribs)

        * If we're getting subdirectories, toss the "." and ".." directories
        IF 'D' $ cAttribs
            nRARow = oDirObj.Locate('.', 1)
            IF nRARow > 0
                oDirObj.DeleteRow(nRARow)
            ENDIF
            nRARow = oDirObj.Locate('..', 1)
            IF nRARow > 0
                oDirObj.DeleteRow(nRARow)
            ENDIF
        ENDIF

        * Return the object
        RETURN oDirObj
    ENDFUNC

    *- DirListOnly() - Return an array object of dir information for a passed spec
    *     Input: pcDirSpec - Path for directories (can be empty for current dir)
    *            pbNoSort - Pass .T. if you don't want the list sorted by name
    *      Retn: DirArray object for passed directory with the following format:
    *                 .aRA[x,1] - File name (C) (includes extension)
    *                 .aRA[x,2] - File size (N):
    *                 .aRA[x,3] - File date (D)
    *                 .aRA[x,4] - File Time (C)
    *                 .aRA[x,5] - File Attributes (C):
    *                       Letter        Attribute
    *                       컴컴컴        컴컴컴컴�
    *                         A            Archive (Read and Write)
    *                         H            Hidden
    *                         R            Read only
    *                         S            System
    *                         D            Directory
    FUNCTION DirListOnly(pcDirSpec, pbNoSort)
        LOCAL cDirSpec, cAttribs, oDirObj, nRARow

        * Define the directory desired
        cDirSpec = ''
        IF NOT EMPTY(pcDirSpec)
            cDirSpec = THIS.CheckLastSep(pcDirSpec)
        ENDIF

        * Define the attributes we want
        cAttribs = 'DR'

        * If a spec was passed, we must change to that directory (VFP will only
        *   give us a directory list if we pass an empty spec)
        cCurrDrvDir = ''
        IF NOT EMPTY(cDirSpec)
            cCurrDrvDir = SET('DEFAULT') + CURDIR()
            SET DEFAULT TO (cDirSpec)
        ENDIF

        * Get the directory array object
        oDirObj = CREATEOBJECT( 'DirArray', '', cAttribs)

        * Change our directory back
        IF NOT EMPTY(cCurrDrvDir)
            SET DEFAULT TO (cCurrDrvDir)
        ENDIF

        * As we're getting subdirectories, toss the "." and ".." directories
        nRARow = oDirObj.Locate('.', 1)
        IF nRARow > 0
            oDirObj.DeleteRow(nRARow)
        ENDIF
        nRARow = oDirObj.Locate('..', 1)
        IF nRARow > 0
            oDirObj.DeleteRow(nRARow)
        ENDIF

        * Sort the list unless they object
        IF NOT pbNoSort
            oDirObj.Sort(1)
        ENDIF

        * Return the object
        RETURN oDirObj
    ENDFUNC

    *- FileList() - Return a list of files matching passed specs as file1,file2...
    *    Input: pcDirSpec - Path string to get files from (can be empty)
    *           pcFileSpec - File Specification (e.g. *.TXT)
    *           pbKillExt - (optional) .T. if ext is to be removed from filename
    *     Retn: List of files as file1,file2,...
    FUNCTION FileList ( pcDirSpec, pcFileSpec, pbKillExt )
        LOCAL bNoExt, oFiles, cFilesOut, nX, cThisFile

        * Check for valid parameters
        IF NOT (PCOUNT() >= 2 AND TYPE('pcDirSpec') = 'C' AND ;
          TYPE('pcFileSpec') = 'C' AND NOT EMPTY(pcFileSpec))
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Are we to kill the extension?
        IF PCOUNT() > 2 AND TYPE('pbKillExt') = 'L'
            bNoExt = pbKillExt
        ELSE
            bNoExt = .F.
        ENDIF

        * Create an array object for the spec.  But, don't check for a
        *   trailing directory separator as this could be "D:*.*" where D:
        *   is a different drive
        oFiles = CREATEOBJECT("DirArray", pcDirSpec + pcFileSpec)

        * Make a list of all files we found
        cFilesOut = ""
        FOR nX = 1 TO oFiles.nRows
            cThisFile = oFiles.aRA[nX,1]
            IF bNoExt
                cThisFile = LEFT(cThisFile, AT('.', cThisFile) - 1)
            ENDIF
            IF NOT EMPTY(cThisFile)
                cFilesOut = cFilesOut + cThisFile + ","
            ENDIF
        ENDFOR

        * Done
        oFiles.Release()
        IF NOT EMPTY(cFilesOut)
            RETURN LEFT(cFilesOut, LEN(cFilesOut)-1 )
        ENDIF
        RETURN cFilesOut
    ENDFUNC

    *- CheckLastSep() - Make sure the passed path has a trailing \, or remove it
    *    Input: pcPath - Path string to test
    *           pbKillSep - If .T. last \ is removed if it's there
    *     Retn: pcPath with (or without) a trailing \
    FUNCTION CheckLastSep( pcPath, pbKillSep )
        LOCAL cRetSpec

        * Check for valid parameters
        IF NOT ((PCOUNT() = 1 OR PCOUNT() = 2) AND TYPE('pcPath') = 'C')
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Handle variants in directory separators
        cRetSpec = THIS.CheckDirSep( pcPath )

        * Check for the last separator
        IF LEN(cRetSpec) > 0
            DO CASE
            CASE pbKillSep AND RIGHT(cRetSpec, 1 ) = '\'
                cRetSpec = LEFT(cRetSpec, LEN(cRetSpec)-1)
            CASE RIGHT(cRetSpec, 1 ) <> '\' AND NOT pbKillSep
                cRetSpec = cRetSpec + '\'
            ENDCASE
        ENDIF
        RETURN cRetSpec
    ENDFUNC

    *- CheckDirSep() - Return the passed path with all directory separators as \
    *    Input: pcPath - Path string to test
    *     Retn: pcPath with all directory separators as \
    FUNCTION CheckDirSep( pcPath )
        LOCAL cRetSpec

        * Check for valid parameters
        IF NOT (PCOUNT() = 1 AND TYPE('pcPath') = 'C')
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Handle variants in directory separators
        cRetSpec = STRTRAN( pcPath, '/', '\')

        * Handle network paths as well
        IF '\\' $ cRetSpec
            cRetSpec = STRTRAN( cRetSpec, '\\', '\')
        ENDIF
        RETURN cRetSpec
    ENDFUNC

    *- LastDirPosn() - Return the last drive or directory separator position
    *    Input: pcPath - Path string to test
    *     Retn: Position of last directory separator: \ or :
    FUNCTION LastDirPosn( pcPath )
        LOCAL nLastSep

        * Check for valid parameters
        IF NOT (PCOUNT() = 1 AND TYPE('pcPath') = 'C')
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Find the last directory separator
        nLastSep = RAT('\', pcPath)
        IF nLastSep = 0       && No separator, how about a drive?
            nLastSep = AT(':', pcPath)
        ENDIF
        RETURN nLastSep
    ENDFUNC

    *- FullPath() - Return the full path from a partial directory (e.g. "..\..")
    *    Input: pcPathSpec - Path string to test
    *     Retn: The fully qualified directory name (e.g. "E:\ALI\DATA")
    FUNCTION FullPath( pcPathSpec )
        LOCAL cOrigDir, cFullDir

        * The passed spec must be a valid directory
        IF NOT THIS.IsADir(pcPathSpec)
            RETURN ''
        ENDIF

        * Change to that directory
        cOrigDir = SET('DEFAULT') + CURDIR()
        SET DEFAULT TO (pcPathSpec)
        cFullDir = SET('DEFAULT') + CURDIR()
        SET DEFAULT TO (cOrigDir)
        RETURN cFullDir
    ENDFUNC

    *- MinPath() - Return the minimum path from current or passed directory
    *    Input: pcFullSpec - Full path or file string to check
    *           pcCompareTo - (optional) Directory to compare it to (default =
    *                           current directory
    *     Retn: The mimimallyy qualified directory name
    *       Example: MinPath([E:\ALI\DATA\SAVE], [E:\ALI]) = [DATA\SAVE]
    FUNCTION MinPath(pcFullSpec, pcCompareTo)
        LOCAL cRetDir

        * VFP's SYS(2014) handles this one
        IF PCOUNT() = 2
            cRetDir = SYS(2014, pcFullSpec, pcCompareTo)
        ELSE
            cRetDir = SYS(2014, pcFullSpec)
        ENDIF
        RETURN cRetDir
    ENDFUNC

    *- JustDrive() - Return only the drive and colon from the passed path/filespec
    *    Input: pcFileSpec - Path/File string to test
    *     Retn: Only the Drive and : part of pcFileSpec
    FUNCTION JustDrive( pcFileSpec )
        LOCAL cRetDrv

        * Check for valid parameters
        IF NOT (PCOUNT() = 1 AND TYPE('pcFileSpec') = 'C')
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Check directory separators
        cRetDrv = THIS.CheckDirSep( pcFileSpec )

        * Look for the colon
        IF ':' $ cRetDrv
            cRetDrv = LEFT(cRetDrv, 2)
        ELSE
            cRetDrv = SET('DEFAULT')
        ENDIF
        RETURN cRetDrv
    ENDFUNC

    *- IsADir() - Determine whether the passed spec is a directory
    *    Input: pcDirName - Directory Name in question
    *     Retn: .T. if pcDirName is a directory, else .F.
    FUNCTION IsADir(pcDirName)
        LOCAL cCkDir, aTemp[1], nFileCnt, bGotIt, nX

        * Remove the last directory separator
        cCkDir = THIS.CheckLastSep(pcDirName, .T.)

        * If this is a root directory (\ or E:\), it's OK (VFP won't give us
        *   anything).
        IF EMPTY(cCkDir) OR (LEN(cCkDir) = 2 AND RIGHT(cCkDir,1) = ':')
            RETURN .T.
        ENDIF

        * Create a temporary array for ADIR()
        nFileCnt = ADIR( aTemp, cCkDir, "D")
        bGotIt = .F.
        FOR nX = 1 TO nFileCnt
            IF 'D' $ aTemp[nX,5]
                bGotIt = .T.
                EXIT
            ENDIF
        ENDFOR
        RETURN bGotIt
    ENDFUNC

    *- MakeDir() - Create the passed directory name
    *    Input: pcDirName - Directory Name to create
    *     Retn: .T. if pcDirName exists, else .F.
    FUNCTION MakeDir(pcDirName)
        LOCAL cDirName

        * Kill any trailing backslash
        cDirName = THIS.CheckLastSep(pcDirName, .T.)

        * If it's already a directory, we don't need to create it
        IF THIS.IsADir(cDirName)
            RETURN .T.
        ENDIF

        * Go make it and verify that it's made
        MD (cDirName)
        RETURN THIS.IsADir(cDirName)
    ENDFUNC

    *- RemDir() - Remove the passed directory (must be empty)
    *    Input: pcDirName - Directory Name to remove
    *     Retn: .T. if pcDirName is removed, else .F.
    FUNCTION RemDir(pcDirName)
        LOCAL cDirName, oDir, nFileCnt, bRetVal

        * If this isn't a directory, we're done
        IF NOT THIS.IsADir(pcDirName)
            RETURN .T.
        ENDIF

        * Kill any trailing backslash
        cDirName = THIS.CheckLastSep(pcDirName, .T.)

        * Make sure there's nothing in the directory
        oDir = THIS.DirInfo(cDirName, '*.*', .T.)
        nFileCnt = oDir.nRows
        IF nFileCnt = 0

            * Remove the directory
            RD (cDirName)
            bRetVal = (NOT THIS.IsADir(cDirName))
        ELSE
            bRetVal = .F.
        ENDIF

        * Return the result
        RETURN bRetVal
    ENDFUNC

    *- ZapDir() - Remove an entire directory tree
    *    Input: pcDirName - Directory Name to remove
    *           nTrySecs - Secs to keep trying (default = 5)
    *     Retn: .T. if pcDirName removed, else .F.
    FUNCTION ZapDir(pcDirName, nTrySecs)
        LOCAL cDir2Del, oDir, nFileCnt, nEndAt, bOld1705, bDidIt, bFirstPass, ;
          nLoopCntr, nX, cFName

        * If this isn't a directory, we're done
        IF NOT THIS.IsADir(pcDirName)
            RETURN .T.
        ENDIF

        * Make sure we have a trailing backslash
        cDir2Del = THIS.CheckLastSep(pcDirName)

        * Define our waiting seconds if we don't have any
        IF TYPE('nTrySecs') <> 'N'
            nTrySecs = 5
        ENDIF

        * Get an array object of all files and subdirectories
        oDir = THIS.DirInfo(cDir2Del, '*.*', .T.)
        nFileCnt = oDir.nRows

        * Define our ending time
        nEndAt = INT( SECONDS() + nTrySecs)

        * NT's cache doesn't always let us delete files right away.  So,
        *   we'll need to trap for Access Denied errors (#1705) and we'll
        *   need to keep trying up to our time limit
        bOld1705 = THIS.bHandle1705
        THIS.bHandle1705 = .T.
        bDidIt = (nFileCnt = 0)
        bFirstPass = (NOT bDidIt)
        nLoopCntr = 0               && For debugging purposes only
        DO WHILE bFirstPass OR (SECONDS() <= nEndAt AND NOT bDidIt)
            nLoopCntr = nLoopCntr + 1

            * Remove all of the files in oDir
            FOR nX = 1 TO nFileCnt

                * Define the file name
                *     .aRA[x,1] - File name (C) (includes extension)
                *     .aRA[x,2] - File size (N):
                *     .aRA[x,3] - File date (D)
                *     .aRA[x,4] - File Time (C)
                *     .aRA[x,5] - File Attributes (C):
                cFName = cDir2Del + oDir.aRA[nX,1]

                * For directories, call ourselves recursively to delete it
                IF 'D' $ oDir.aRA[nX,5]
                    THIS.ZapDir(cFName, nTrySecs)
                    nEndAt = INT( SECONDS() + nTrySecs)

                * For files, just delete them
                ELSE

                    * Sometimes we've seen that the file has already been
                    *   deleted - so just double-check
                    THIS.DeleteFile(cFName)
                    nEndAt = INT( SECONDS() + nTrySecs)
                ENDIF

                * Go handle the next one
            ENDFOR

            * Double-check that we got all of the files.  (It could be that
            *   we got an Access Denied and went on to the next file.)
            IF SECONDS() < nEndAt
                oDir = THIS.DirInfo(cDir2Del, '*.*', .T.)
                nFileCnt = oDir.nRows
                nEndAt = INT( SECONDS() + nTrySecs)
            ENDIF
            bDidIt = (nFileCnt = 0)
            bFirstPass = .F.
        ENDDO

        * Now, we can remove our directory
        bDidIt = .F.
        bFirstPass = .T.
        nLoopCntr = 0
        DO WHILE bFirstPass OR (SECONDS() <= nEndAt AND NOT bDidIt)
            nLoopCntr = nLoopCntr + 1

            * Try to remove the directory
            bDidIt = THIS.RemDir(cDir2Del)

            * If that didn't work, wait 1/4 second
            IF NOT bDidIt
                = PAUSEFR(0.25)
            ENDIF
            bFirstPass = .F.
        ENDDO
        THIS.bHandle1705 = bOld1705
        RETURN bDidIt
    ENDFUNC

    *- IncrDirName() - Return a directory name based on incrementing trailing digits
    *     Input: pcPref - Directory name's preface text
    *            pnFileLen - Desired length of filename
    *      Retn: Non-existing directory name as Preface + Number
    *      Note: Passed spaces are converted to underscores (_)
    FUNCTION IncrDirName( pcPref, pnFileLen )
        LOCAL cPrefix, cPath, cFileSpec, oDirObj, nDigitsNeeded, nLastNumb
        LOCAL bIsThere, cAddOn, nZ, nMaxLoops, nLoopCnt

        * Convert any spaces to underscores
        cPrefix = UPPER( STRTRAN(pcPref, ' ', '_') )

        * Separate the directory and filespec info
        cPath = THIS.JustPath(cPrefix)
        cFileSpec = THIS.JustFile(cPrefix)

        * Get a list of directories and filenames all matching the prefix
        oDirObj = THIS.DirInfo( cPath, cFileSpec + '*.*', .T.)

        * How many digits will we add?
        nDigitsNeeded = pnFileLen - LEN(cFileSpec)

        * Start a testing Loop
        nLastNumb = -1
        bIsThere = .T.
        nMaxLoops = 10 ^ nDigitsNeeded
        nLoopCnt = 0
        DO WHILE bIsThere

            * Increment the last number and make a string out of the result
            nLastNumb = nLastNumb + 1
            cAddOn = PADL(nLastNumb, nDigitsNeeded, '0')

            * See if this exists in oDirObj
            bIsThere = .F.
            FOR nZ = 1 TO oDirObj.nRows
                IF UPPER( oDirObj.aRA[nZ,1] ) == cPrefix + cAddOn
                    bIsThere = .T.
                    EXIT
                ENDIF
            ENDFOR

            * If it's not there, double-check
            *   Does a file exist?
            IF NOT bIsThere
                bIsThere = (FILE(cPrefix + cAddOn))

                *   Does a directory exist?
                IF NOT bIsThere
                    bIsThere = THIS.IsADir(cPrefix + cAddOn)
                ENDIF
            ENDIF

            * Try again if bIsThere
            IF bIsThere
                nLoopCnt = nLoopCnt + 1
                IF nLoopCnt >= nMaxLoops
                    ERROR [Loop maximum exceeded]
                ENDIF
            ENDIF
        ENDDO

        * That's it; return the result
        RETURN cPrefix + cAddOn
    ENDFUNC

    *- GetFileDescription() - Return a file's information in an object
    *     Input: pcDirName - Directory Name (can also have file name)
    *            pcFileName - (optional) File name (without path)
    *      Retn: File description object; properties:
    *             .cFileName (no path but with extension)
    *             .cExt - file extension
    *             .dDate - file date
    *             .cTime - file time
    *             .nSize - file size (bytes)
    *             .cAttrib - file attributes in RHSDA format
    *             .cPath - directory for file (with trailing backslash)
    *             .bFound - .T. if file found
    FUNCTION GetFileDescription(cPath, cFile)
        LOCAL oFD, oDirObj

        * Make sure we separate the file and path
        IF PCOUNT() = 1
            cFile = JUSTFNAME(cPath)
            cPath = JUSTPATH(cPath)
        ENDIF

        * Create our description object
        cPath = ADDBS(cPath)
        oFD = CREATEOBJECT('Empty')
        ADDPROPERTY(oFD, 'cFileName', cFile)
        ADDPROPERTY(oFD, 'cExt', '')
        ADDPROPERTY(oFD, 'dDate', {})
        ADDPROPERTY(oFD, 'cTime', '')
        ADDPROPERTY(oFD, 'nSize', 0)
        ADDPROPERTY(oFD, 'cAttrib', '')
        ADDPROPERTY(oFD, 'cPath', cPath)
        ADDPROPERTY(oFD, 'bFound', .F.)

        * If the passed filename is empty, we're done
        IF NOT EMPTY(cFile)

            * Get the directory array object for this file using attributes:
            *   Archive, Hidden ReadOnly or System files
            oDirObj = CREATEOBJECT( 'DirArray', cPath + cFile, 'AHRS')

            * Load up our description object
            WITH oFD
                .cExt = JUSTEXT(cFile)
                .dDate = oDirObj.aRA[1,3]
                .cTime = oDirObj.aRA[1,4]
                .nSize = oDirObj.aRA[1,2]
                .cAttrib = oDirObj.aRA[1,5]
                .bFound = .T.
            ENDWITH
        ENDIF
        RETURN oFD
    ENDFUNC

    *- FindFirstFile() - Return an object containing the FIRST file's info in a dir
    *     Input: pcPathSpec - Path/file spec string
    *      Retn: File description object; properties:
    *             .cFileName (no path but with extension)
    *             .cExt - file extension
    *             .dDate - file date
    *             .cTime - file time
    *             .nSize - file size (bytes)
    *             .cAttrib - file attributes in RHSDA format
    *             .cPath - directory for file
    *             .bFound - .T. if file found
    FUNCTION FindFirstFile(pcPathSpec)
        LOCAL cFileName, oFile

        * Get the first file name for the spec
        cFileName = SYS(2000, pcPathSpec)

        * Get the rest of its info and put it in a file description object
        oFile = THIS.GetFileDescription(JUSTPATH(pcPathSpec), cFileName)
        RETURN oFile
    ENDFUNC

    *- FindNextFile() - Return an object containing the NEXT file's info in a dir
    *     Input: pcPathSpec - Path/file spec string - same as FindFirstFile()
    *      Retn: File description object; same as FindFirstFile()
    FUNCTION FindNextFile(pcPathSpec)
        LOCAL cFileName, oFile

        * Get the next file name for the spec
        cFileName = SYS(2000, pcPathSpec, 1)

        * Get the rest of its info and put it in a file description object
        oFile = THIS.GetFileDescription(JUSTPATH(pcPathSpec), cFileName)
        RETURN oFile
    ENDFUNC

    *- WaitForFile() - Return when a file has finished being created
    *     Input: pcPathSpec - Path/file spec string
    *            pnLimitSecs - Max. seconds to wait
    *      Retn: .T. if file found, else .F.
    FUNCTION WaitForFile(pcPathSpec, pnLimitSecs)
        LOCAL nEndSecs, nSize, bGotIt, oFile

        * Setup for our Wait loop
        nEndSecs = -1
        IF PCOUNT() > 1 AND NOT EMPTY(pnLimitSecs)
            nEndSecs = SECONDS() + pnLimitSecs
        ENDIF
        nSize = -1
        bGotIt = .F.
        DO WHILE .T.
            oFile = THIS.GetFileDescription(pcPathSpec)

            * Our rules for waiting are:
            DO CASE

            *   1. Keep waiting if the file doesn't exist
            CASE oFile.nSize = 0 OR NOT oFile.bFound
                PAUSEFR(0.1)         && Wait for 1/10th of a second

            *   2. Keep waiting if the file size changes
            CASE oFile.bFound AND oFile.nSize > nSize
                nSize = oFile.nSize
                PAUSEFR(0.1)

            *   3. If we've timed out, just exit
            CASE nEndSecs > 0 AND SECONDS() > nEndSecs
                EXIT

            *   4. When the file size is stable and the file exists, wait
            *       another 1/2 second anyway.
            OTHERWISE
                bGotIt = .T.
                PAUSEFR(0.5)
                EXIT
            ENDCASE
        ENDDO
        RETURN bGotIt
    ENDFUNC

    *- UniqueTempName() - Return a temporary filename that doesn't exist
    *    Input: pcExt - The file extension that will be used
    *           pcDir - The directory for the file (default = '.\')
    *     Retn: A unique 8-character filename not on pcDir with pcExt
    FUNCTION UniqueTempName(pcExt, pcDir)
        LOCAL cFName

        * We may not be passed cDir
        IF TYPE('pcDir') <> 'C'
            pcDir = '.\'
        ENDIF

        * We used to use SYS(3) for this but VFP says, "SYS(3) may return a
        *   non-unique name when issued successionally on a fast computer.
        *   Use SUBSTR(SYS(2015), 3, 10) to create unique, legal 8 character
        *   file name.  So, we will.
        cFName = SUBSTR(SYS(2015), 3, 8)

        * VFP squawks if we use a name beginning with a number
        IF LEFT(cFName,1) $ '1234567890'
            cFName = 'X' + SUBSTR(cFName, 2)
        ENDIF

        * But, double-check to make sure it doesn't exist
        DO WHILE FILE( pcDir + cFName + '.' + pcExt )
            cFName = SUBSTR(SYS(2015), 3, 8)
            IF LEFT(cFName,1) $ '1234567890'
                cFName = 'X' + SUBSTR(cFName, 2)
            ENDIF
        ENDDO
        RETURN cFName
    ENDFUNC

    *- JustPath() - Return only the path from the passed spec
    *    Input: pcPathSpec - Path/file string to test
    *     Retn: Only the drive and directory part of pcPathSpec
    FUNCTION JustPath( pcPathSpec )
        LOCAL cRetPath, nLastSlash

        * Check for valid parameters
        IF NOT (PCOUNT() = 1 AND TYPE('pcPathSpec') = 'C')
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Check directory separators
        cRetPath = THIS.CheckDirSep( pcPathSpec )

        * Find the last directory separator
        nLastSlash = THIS.LastDirPosn( pcPathSpec )

        * Handle our variations
        DO CASE

        * There may be no path at all
        CASE nLastSlash = 0
            RETURN ''

        * There may be no filename if the last character is '\' or ':'
        CASE RIGHT(cRetPath,1) $ '\:'
            RETURN cRetPath

        * Otherwise, do the expected thing
        OTHERWISE
            RETURN LEFT(cRetPath, nLastSlash)
        ENDCASE
    ENDFUNC

    *- JustFile() - Return only the file name/extension from the passed filespec
    *    Input: pcFileSpec - File string to test
    *     Retn: Only the file name/ext part of pcFileSpec
    FUNCTION JustFile( pcFileSpec )
        LOCAL cRetFName, nLastSlash

        * Check for valid parameters
        IF NOT (PCOUNT() = 1 AND TYPE('pcFileSpec') = 'C')
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Check directory separators
        cRetFName = THIS.CheckDirSep( pcFileSpec )

        * Find the last directory separator
        nLastSlash = THIS.LastDirPosn( cRetFName )

        * Handle our variations
        DO CASE

        * There may be no path at all
        CASE nLastSlash = 0
            RETURN cRetFName

        * There may be no filename at all
        CASE nLastSlash = LEN(cRetFName)
            RETURN ''

        * Otherwise, do the expected thing
        OTHERWISE
            RETURN SUBSTR(cRetFName, nLastSlash + 1)
        ENDCASE
    ENDFUNC

    *- JustFName() - Return only the file name (no ext) from the passed filespec
    *    Input: pcFileSpec - File string to test
    *     Retn: Only the file name (no ext) part of pcFileSpec
    FUNCTION JustFName( pcFileSpec )
        LOCAL cRetFName, nPeriod

        * Check for valid parameters
        IF NOT (PCOUNT() = 1 AND TYPE('pcFileSpec') = 'C')
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Remove the directory info
        cRetFName = THIS.JustFile( pcFileSpec )

        * Find the extension separator
        nPeriod = AT( '.', cRetFName )

        * Remove the extension
        IF nPeriod > 0
            cRetFName = LEFT(cRetFName, nPeriod-1)
        ENDIF

        * Done
        RETURN cRetFName
    ENDFUNC

    *- JustFExt() - Return only the extension from the passed filespec
    *    Input: pcFileSpec - File string to test
    *     Retn: Only the file ext part of pcFileSpec
    FUNCTION JustFExt( pcFileSpec )
        LOCAL cRetExt, nPeriod

        * Check for valid parameters
        IF NOT (PCOUNT() = 1 AND TYPE('pcFileSpec') = 'C')
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Find the extension separator
        cRetExt = ''
        nPeriod = RAT( '.', pcFileSpec )
        IF nPeriod > 0 AND nPeriod < LEN(pcFileSpec)
            cRetExt = ALLTRIM( SUBSTR(pcFileSpec, nPeriod+1) )
        ENDIF

        * Done
        RETURN cRetExt
    ENDFUNC

    *- IncrFName() - Return a filename setting the filename based on the next number
    *    Input: pcPref - Filename preface text
    *           pcExt - File's extension
    *           pcDir - Destination directory for file
    *     Retn: Non-existing filename as Preface + Number + .Ext
    FUNCTION IncrFName(pcPref, pcExt, pcDir)
        LOCAL cNextNum, nNextNum

        * Make sure we have a valid directory
        IF VARTYPE(pcDir) <> 'C' OR EMPTY(pcDir)
            pcDir = ''
        ENDIF

        * The returned filename has the format:
        *       cBaseName cNewNumber . cExt
        * where cNewNumber is assigned such that the file currently does not
        * exist
        cExt = '.' + pcExt
        cNextNum = '1'
        DO WHILE FILE(pcDir + pcPref + cNextNum + cExt)
            nNextNum = VAL(cNextNum) + 1
            cNextNum = LTRIM(STR( nNextNum ))
        ENDDO
        RETURN pcPref + cNextNum + cExt
    ENDFUNC

    *- IncrFName0() - Return a filename defined based on 0s + the next number
    *    Input: pcPref - Filename preface text
    *           pcExt - File's extension
    *           pcDir - Destination directory for file
    *           pnMaxDigits - (optional) Max digits to use (def: name = 8)
    *     Retn: Non-existing filename as Preface + Number + .Ext
    FUNCTION IncrFName0(pcPref, pcExt, pcDir, pnMaxDigits)
        LOCAL nNumbLen, cExt, nNextNum, cNextNum

        * Make sure we have valid parameters
        IF VARTYPE(pcDir) <> 'C' OR EMPTY(pcDir)
            pcDir = ''
        ENDIF
        IF VARTYPE(pnMaxDigits) <> 'N' OR pnMaxDigits  < 1
            nNumbLen = MAX(1, 8 - LEN(pcPref))
        ELSE
            nNumbLen = pnMaxDigits
        ENDIF

        * The returned filename has the format:
        *       cBaseName cNewNumber . cExt
        * where cNewNumber is assigned such that the file currently does not
        * exist.  Set our extension and define the length of the numbers
        cExt = '.' + pcExt
        nNextNum = 1
        cNextNum = PADL(nNextNum, nNumbLen, '0')
        DO WHILE FILE(pcDir + pcPref + cNextNum + cExt)
            nNextNum = nNextNum + 1
            cNextNum = PADL(nNextNum, nNumbLen, '0')
        ENDDO
        RETURN pcPref + cNextNum + cExt
    ENDFUNC

    *- IncrFExt() - Return a filename setting the extension based on the next number
    *    Input: pcFileSpec - File Specification including directory (no extension)
    *     Retn: Non-existing filename as pcFileSpec + .NewExt
    FUNCTION IncrFExt(pcFileSpec)
        LOCAL cSpecOut, cNextNum, nNextNum

        * Make sure our filespec ends in a period
        cSpecOut = THIS.ExtrToken( pcFileSpec, '.' ) + '.'

        * We'll start with extension: "000"
        cNextNum = '000'
        DO WHILE FILE(cSpecOut + cNextNum)
            cNextNum = goStr.IncrAlpha(cNextNum)
        ENDDO

        * Done
        RETURN cSpecOut + cNextNum
    ENDFUNC

    *- AnyFiles() - Return .T. if any files matching passed specs exist
    *     Input: pcFileSpec - File Spec (e.g. junk\*.TXT) can include path
    *      Retn: .T. if any matching files exist
    FUNCTION AnyFiles(pcFileSpec)
        LOCAL oFiles, bGotSome

        * Create an array object for the full file spec.
        oFiles = CREATEOBJECT("DirArray", pcFileSpec)
        bGotSome = oFiles.nRows > 0
        oFiles.Release()

        * Done
        RETURN bGotSome
    ENDFUNC

    *- IsAFile() - Return .T. if the passed file spec exists (wild cards OK)
    *     Input: pcFileName - File Name in question
    *      Retn: .T. if pcFileName is a file, else .F.
    FUNCTION IsAFile(pcFileSpec)
        LOCAL oFiles, bGotSome

        * Create an array object for the full file spec.
        oFiles = CREATEOBJECT("DirArray", pcFileSpec, 'ARHS')
        bGotSome = oFiles.nRows > 0
        oFiles.Release()

        * Done
        RETURN bGotSome
    ENDFUNC

    *- FileInfo() - Return an array object of file information
    *    Input: pcFileNm - File name in question
    *     Retn: Array object for passed file in the format of:
    *           .aRA[1] - File name (C) (includes extension)
    *           .aRA[2] - File size (N):
    *           .aRA[3] - File date (D)
    *           .aRA[4] - File Time (C)
    *           .aRA[5] - File Attributes (C):
    FUNCTION FileInfo( pcFileNm )
        LOCAL oDirObj

        * Get the directory array object for this file using attributes:
        *   Archive, Hidden ReadOnly or System files
        oDirObj = CREATEOBJECT( 'DirArray', pcFileNm, 'AHRS')

        * Copy this to a single-dimension array
        oFileObj = CREATEOBJECT('ArrayObj', 1)
        FOR nZ = 1 TO 5
            oFileObj.AddRow( oDirObj.aRA[1,nZ] )
        ENDFOR

        * Return our file object
        RELEASE oDirObj
        RETURN oFileObj
    ENDFUNC

    *- FileSize() - Return the size of a file
    *    Input: pcFileNm - File name in question
    *     Retn: File Size (N)
    FUNCTION FileSize( pcFileNm )
        LOCAL oDirObj, nSize

        * Get the directory array object for this file using attributes:
        *   Archive, Hidden ReadOnly or System files
        oDirObj = CREATEOBJECT( 'DirArray', pcFileNm, 'AHRS')

        * The Size is in the 2nd column
        nSize = 0
        IF oDirObj.nRows > 0
            nSize = oDirObj.aRA[1,2]
        ENDIF
        RETURN nSize
    ENDFUNC

    *- FileDate() - Return a file's date
    *    Input: pcFileNm - File name in question
    *     Retn: File Date (D)
    FUNCTION FileDate( pcFileNm )
        LOCAL oDirObj, dDate

        * Get the directory array object for this file using attributes:
        *   Archive, Hidden ReadOnly or System files
*       oDirObj = CREATEOBJECT( 'DirArray', pcFileNm, 'AHRS')
*
*       * The Time is the 3rd column
*       dDate = {}
*       IF oDirObj.nRows > 0
*           dDate = oDirObj.aRA[1,3]
*       ENDIF

        * There's a better way
        dDate = FDATE(pcFileNm)
        RETURN dDate
    ENDFUNC

    *- FileTime() - Return a file's time
    *    Input: pcFileNm - File name in question
    *     Retn: File Time (C>
    FUNCTION FileTime( pcFileNm )
        LOCAL oDirObj, cTime

        * Get the directory array object for this file using attributes:
        *   Archive, Hidden ReadOnly or System files
*       oDirObj = CREATEOBJECT( 'DirArray', pcFileNm, 'AHRS')
*
*       * The Time is the 4th column
*       cTime = ''
*       IF oDirObj.nRows > 0
*           cTime = oDirObj.aRA[1,4]
*       ENDIF

        * There's a better way...
        cTime = FTIME(pcFileNm)

        * ...but we have to convert "01:29:12 PM" to "13:29:12"
        IF RIGHT(cTime,2) = 'PM'
            cTime = PADL( VAL(cTime)+12, 2, '0') + SUBSTR(cTime, 3, 6)
        ELSE
            cTime = LEFT(cTime, 8)
        ENDIF
        RETURN cTime
    ENDFUNC

    *- FileAttr() - Return a file's attributes
    *    Input: pcFileNm - File name in question
    *     Retn: Attributes (C)
    FUNCTION FileAttr(pcFileNm)
        LOCAL dwAttribs, cReturn

        * Get the file's attributes as a double-word
        dwAttribs = GetFileAttributes(pcFileNm)

        * Convert these into characters
        cReturn = THIS.AttrDW2Chars(dwAttribs)
        RETURN cReturn
    ENDFUNC

    *- SetFileAttrs() - Change a file's attributes
    *     Input: pcFileNm - File name in question
    *-           Desired new Attributes (C): A, R, H, S - singly or mixed together
    *      Retn: .T. if set properly
    FUNCTION SetFileAttrs(cFileNm, cAttribs)
        LOCAL dwAttribs, nNewAttribs, nResult, cMsg

        * Input Notes:
        *   cFileNm - The file whose attributes are to be changed
        *   cAttribs - The desired attributes. BUT, there are 2 ways to set:
        *       Absolute: Pass only the desired characters (e.g. "RA" or "RSH")
        *       Relative: Pass the changes - space separated (e.g. "-R +A")
        *       Note: If one attribute is relative, they all must be

        * Get the file's attributes as a double-word
        dwAttribs = GetFileAttributes(cFileNm)

        * What are we supposed to do to the file
        nNewAttribs = THIS.GetAttribNumb(cAttribs, dwAttribs)

        * Now, set the attributes
        nResult = SetFileAttributes(cFileNm, nNewAttribs)
        IF nResult = 0
            cMsg = 'Setting attributes failed for ' + cFileNm
            cMsg = THIS.GetLastAPIError(cMsg)
            ERROR cMsg
        ENDIF
        RETURN (nResult <> 0)
    ENDFUNC

    *- FindAppFile() - Locate an application file on one of our directories
    *    Input: pcFileNm - File name to locate
    *     Retn: File name with directory (unchanged if not found)
    FUNCTION FindAppFile( pcFileNm )
        LOCAL cFile, cSubDirs, cThisDir

        * It might exist as passed.  If so, return quickly
        IF FILE(pcFileNm)
            RETURN pcFileNm
        ENDIF

        * If it has a directory, strip that and check it again
        cFile = pcFileNm
        IF '\' $ cFile OR ':' $ cFile
            cFile = THIS.JustFile( cFile )
        ENDIF
        IF FILE(cFile)
            RETURN cFile
        ENDIF

        * We still can't find it.  So, look in our various subdirectories
        cSubDirs = gAppDirs
        DO WHILE NOT EMPTY(cSubDirs)
            cThisDir = gcAppDir + THIS.ExtrToken( @cSubDirs, '^' ) + '\'
            IF FILE(cThisDir + cFile)
                RETURN (cThisDir + cFile)
            ENDIF
        ENDDO

        * Struck out; let VFP handle it
        RETURN pcFileNm
    ENDFUNC

    *- CopyFile() - Copy a file from one directory to another
    *    Input: pcSrcFile - Source file spec (name and dir as needed)
    *           pcDstDir - Destination file spec (can include filename)
    *           pbUseTemp - .T. if copy is to be done to a temp file, then renamed
    *           pbNoBugFileWanted - if a error will return .F. (not bug file created)
    *     Retn: .T. if copy succeeded, else .F.
    FUNCTION CopyFile(pcSrcFile, pcDstDir, pbUseTemp, pbNoBugFileWanted)
        LOCAL cDstSpec, cTempFile, cDstFile, nResult, cMsg

        * Make sure the destination spec includes a filename
        cDstSpec = ALLTRIM(pcDstDir)
        IF THIS.IsADir(cDstSpec)
            cDstSpec = THIS.CheckLastSep(cDstSpec) + THIS.JustFile(pcSrcFile)
        ENDIF

        * Copy the file using a temp file name if requested.  We'll get a bug
        *   box if the passed spec is invalid.
        IF pbUseTemp
            cTempFile = SYS(3) + [.TMP]
            cDstFile = ADDBS( JUSTPATH(cDstSpec)) + cTempFile

            * The trailing .F. means if the dest file exists, overwrite it
            nResult = CopyFile(pcSrcFile, cDstFile, .F.)

            * If the destination file exists, delete it
            IF nResult <> 0
                IF FILE(cDstSpec)
                    ERASE (cDstSpec)
                ENDIF
                THIS.RenameFile(cDstFile, cDstSpec)
            ENDIF
        ELSE
            nResult = CopyFile(pcSrcFile, cDstSpec, .F.)
        ENDIF

        * Check our results
        IF nResult = 0 AND NOT pbNoBugFileWanted
            cMsg = 'File copy failed for ' + pcSrcFile + CR_LF + ;
              THIS.GetLastAPIError(cMsg)
            ERROR cMsg
        ENDIF
        RETURN (nResult > 0)
    ENDFUNC

    *- CopyAllFiles() - Copy file matching a passed spec from one directory to another
    *     Input: pcFilSpec - File spec including path and wildcards (can be *.*)
    *            pcDstDir - Destination file spec (can include filename)
    *      Retn: Number of files copied (0 if none)
    FUNCTION CopyAllFiles(pcFilSpec, pcDstDir)
        LOCAL oDirObj, cFileDir, nFileCnt, nX, cThisFile

        * Create an array object
        oDirObj = CREATEOBJECT("DirArray", pcFilSpec)

        * Define the directory
        cFileDir = THIS.JustPath(pcFilSpec)

        * Go through copying each file
        nFileCnt = 0
        FOR nX = 1 TO oDirObj.nRows
            cThisFile = oDirObj.aRA[nX,1]
            IF cThisFile == '.' OR cThisFile == '..'
                LOOP
            ENDIF

            * Copy the file
            IF THIS.CopyFile(cFileDir + cThisFile, pcDstDir)
                nFileCnt = nFileCnt + 1
            ENDIF
        ENDFOR
        RETURN nFileCnt
    ENDFUNC

    *- MoveFile() - Move a file from one drive/directory to another
    *    Input: pcSrcFile - Source file spec (name and dir as needed)
    *           pcDstDir - Destination file spec (can include filename)
    *           pbUseTemp - .T. if copy is to be done to a temp file, then renamed
    *           pbNoBugFileWanted - if a error will return .F. (not bug file created)
    *     Retn: .T. if move succeeded, else .F.
    FUNCTION MoveFile(pcSrcFil, pcDstDr, pbUseTemp, pbNoBugFileWanted)
        LOCAL bIsOk

        * Copy the file
        bIsOk = THIS.CopyFile(pcSrcFil, pcDstDr, pbUseTemp, pbNoBugFileWanted)

        * And delete it if the move was successful
        IF bIsOk
            bIsOk = THIS.DeleteFile(pcSrcFil)
        ENDIF
        RETURN bIsOk
    ENDFUNC

    *- RenameFile() - Rename a passed filename
    *     Input: pcFileName - File to rename (can include path)
    *            pcNewName - New name for the file
    *      Retn: .T. if file renamed (.F. if not)
    FUNCTION RenameFile(pcFileName, pcNewName)
        LOCAL cAttrs, bRetVal

        * Rename won't work for System/Hidden files utes
        cAttrs = THIS.FileAttr(pcFileName)
        IF 'H' $ cAttrs OR 'S' $ cAttrs
            THIS.SetFileAttrs(pcFileName, '-H -S')
        ENDIF

        * Rename the file
        bRetVal = .F.
        RENAME (pcFileName) TO (pcNewName)
        IF THIS.IsAFile(pcNewName)
            bRetVal = .T.

            * Reset the attributes if needed
            IF 'H' $ cAttrs OR 'S' $ cAttrs
                THIS.SetFileAttrs(pcNewName, cAttrs)
            ENDIF
        ENDIF
        RETURN bRetVal
    ENDFUNC

    *- DeleteFile() - Delete a passed filename
    *    Input: pcDelFile - File to delete (can include path)
    *     Retn: .T. if file deleted (.F. if not)
    FUNCTION DeleteFile(pcDelFile)
        LOCAL cAttrs, nResult, nX, cMsg

        * Don't bother if the file doesn't exist
        IF NOT THIS.IsAFile(pcDelFile)
            RETURN .T.
        ENDIF

        * Before we can delete the file, we must clear any Readonly attribute
        cAttrs = THIS.FileAttr(pcDelFile)
        IF 'R' $ cAttrs
            THIS.SetFileAttrs(pcDelFile, '-R')
        ENDIF
        nResult = DeleteFile(pcDelFile)
        IF nResult = 0
            FOR nX = 1 TO 100       && Try for a bunch of times
                INKEY(0.10)         && Wait 1/10th of a second
                nResult = DeleteFile( pcDelFile )
                IF nResult = 1
                    EXIT
                ENDIF
            ENDFOR
        ENDIF
        RETURN (NOT THIS.IsAFile(pcDelFile))
    ENDFUNC

    *- DeleteAllFiles() - Delete all files matching a passed file spec
    *    Input: pcDelSpec - File spec including path and wildcards (can be *.*)
    *     Retn: Number of files deleted (0 if none)
    FUNCTION DeleteAllFiles( pcDelSpec )
        LOCAL oDirObj, cFileDir, nFileCnt, nX, cThisFile

        * Create an array object
        oDirObj = CREATEOBJECT("DirArray", pcDelSpec)

        * Define the directory
        cFileDir = THIS.JustPath(pcDelSpec)

        * Go through deleting all files
        nFileCnt = 0
        FOR nX = 1 TO oDirObj.nRows
            cThisFile = oDirObj.aRA[nX,1]
            IF cThisFile == '.' OR cThisFile == '..'
                LOOP
            ENDIF

            * Delete the file
            THIS.DeleteFile(cFileDir + cThisFile)
            IF NOT FILE(cFileDir + cThisFile)
                nFileCnt = nFileCnt + 1
            ENDIF
        ENDFOR
        RETURN nFileCnt
    ENDFUNC

    *- FileToStr() - Open, read and close a file; return its contents as a string
    *    Input: pcFileName - File Name
    *     Retn: String containing file's contents.
    *           The error handler is called on any failure
    FUNCTION FileToStr( pcFileName )
        LOCAL nHndl, cRetStr

        * Don't bother if the file doesn't exist
        IF NOT FILE( pcFileName )
            RETURN ''
        ENDIF

        * Open the file
        nHndl = THIS.LL_Open( pcFileName, 'R' )

        * Read the file into a string
        cRetStr = ''
        DO WHILE NOT FEOF(nHndl)

            * Get 4K bytes from the file
            cRetStr = cRetStr + FREAD(nHndl, 4096)
        ENDDO

        * Close the file and return our string
        THIS.LL_Close( nHndl )
        RETURN cRetStr
    ENDFUNC

    *- StrToFile() - Open a file, write a string into it and close it
    *    Input: pcOutStr - String to write
    *           pcFileName - File Name
    *           pbAppend - .T. if we're to append to the file
    *     Retn: .T.; The error handler is called on any failure
    FUNCTION StrToFile ( pcOutStr, pcFileName, pbAppend )
        LOCAL nHndl

        * Check for valid parameters
        IF NOT (PCOUNT() >= 2 AND TYPE('pcOutStr') = 'C' AND ;
          TYPE('pcFileName') = 'C' AND NOT EMPTY(pcFileName))
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Have Fox do the work
        STRTOFILE( pcOutStr, pcFileName, pbAppend )
        RETURN .T.
    ENDFUNC

    *- FileToArray() - Open, read and close a file; return its contents as an array
    *    Input: pcFileName - File Name
    *     Retn: Array object (Class: ArrayObj) containing 1 line/row
    *           The error handler is called on any failure
    FUNCTION FileToArray( pcFileName )
        LOCAL nHndl, oRAObj, cLine

        * Don't bother if the file doesn't exist
        IF NOT FILE( pcFileName )
            RETURN ''
        ENDIF

        * Open the file
        nHndl = THIS.LL_Open( pcFileName, 'R' )

        * Create an array object
        oRAObj = CREATEOBJECT("ArrayObj")

        * Read the file - one line at a time
        DO WHILE NOT FEOF(nHndl)

            * If the line is longer than 4096, we'll split it
            cLine = FGETS(nHndl, 4096)
            oRAObj.AddRow(cLine)
        ENDDO

        * Close the file and return our array object
        THIS.LL_Close( nHndl )
        RETURN oRAObj
    ENDFUNC

    *- ArrayToFile() - Open a file, write each line from an array into it and close it
    *    Input: poLineArray - Array object (Class: ArrayObj) of lines to write
    *           pcFileName - File Name
    *           pbAppend - .T. if we're to append to the file
    *     Retn: .T.; The error handler is called on any failure
    FUNCTION ArrayToFile(poLineArray, pcFileName, pbAppend )
        LOCAL nHndl, cLine

        * Open the file
        cActionChar = IIF( pbAppend, 'W', 'P')
        nHndl = THIS.LL_Open( pcFileName, cActionChar)

        * If we're appending, go to FEOF()
        IF NOT pbAppend
            THIS.LL_ToEOF(nHndl)
        ENDIF

        * Go through each array row writing a line
        FOR nW = 1 TO poLineArray.nRows
            cLine =poLineArray.aRA[nW]

            * Write the string to the file adding a CR, LF
            THIS.LL_Write( nHndl, cLine, OS_ADDCRLF)
        ENDFOR

        * Close the file and we're done
        THIS.LL_Close( nHndl )
        RETURN .T.
    ENDFUNC

    *- LL_Open() - Return "handle" after create/open a "low-level" read/write file
    *    Input: pcFileName - File name to open
    *           pcAction - (optional) 'W' (default) = Read/Write, 'R' = Read
    *                       Only, 'P' = Purge the file's contents (implies R/W)
    *     Retn: The file "handle" needed for future references to this file
    *           The error handler is called if open fails
    FUNCTION LL_Open ( pcFileName, pcAction )
        LOCAL nOpenCode, bPurgeIt, bGotFile, nLLHndl, cActVerb, cDirName, bGotDir

        * Check for valid parameters
        IF NOT (PCOUNT() >= 1 AND TYPE('pcFileName') = 'C' AND ;
          NOT EMPTY(pcFileName))
            ERROR 'Invalid parameters were passed'
        ENDIF

        * VFP has different codes for file processing operations.
        *   Unfortunately, those codes aren't the same for file opening using
        *   FOPEN() and file creation using FCREATE().  The codes are:
        *           FOPEN()                            FCREATE()
        *    0 (Default) Read Only Buffered     0 (Default) Read-Write
        *    1 Write-Only Buffered              1 Read-Only
        *    2 Read and Write Buffered          2 Hidden
        *   10 Read-Only Unbuffered             3 Read-Only/Hidden
        *   11 Write-Only Unbuffered            4 System
        *   12 Read and Write Unbuffered        5 Read-Only/System
        *                                       6 System/Hidden
        *                                       7 Read-Only/Hidden/System
        * For FOPEN(), we don't need unbuffered access and I can't think of an
        *   instance where Write-only is preferrable to Read/Write so we'll
        *   ignore Write-only and just deal with Read-Only and Read/Write.
        * For FCREATE() we'll only use 0 for simplicity's sake, we don't need
        *   Read-Only, Hidden, or System files (or, if we have the one odd
        *   occasion where we do need that, we can call FCREATE directly).

        * Are we to purge the file?  Define the file open codes
        nOpenCode = 2               && Buffered Read/Write
        bPurgeIt = .F.
        IF VARTYPE(pcAction) = 'C' AND (NOT EMPTY(pcAction)) AND ;
          pcAction $ 'RP'
            IF pcAction = 'R'
                nOpenCode = 0       && Buffered Read-Only
            ELSE
                bPurgeIt = .T.
            ENDIF
        ENDIF

        * If we're to "purge" or overwrite the file, erase it first
        bGotFile = FILE(pcFileName)
        DO CASE
        CASE bPurgeIt AND bGotFile
            ERASE (pcFileName)
            nLLHndl = FCREATE(pcFileName)
            cActVerb = 'open/purge'
        CASE bGotFile
            nLLHndl = FOPEN(pcFileName, nOpenCode)
            cActVerb = 'open' + IIF( nOpenCode = 0, ' r/o', '')
        OTHERWISE
            nLLHndl = FCREATE(pcFileName)
            cActVerb = 'create'
        ENDCASE

        * Call the Error Handler if that failed
        IF nLLHndl < 1
            X_ERRMSG = 'Could not ' + cActVerb + ' the File: ' + pcFileName
            X_ERRCMD = 'F' + UPPER(cActVerb) + '("' + pcFileName + '"' + ;
              IIF(cActVerb = 'open', ', ' + STR(nOpenCode,1,0), '') + ')'

            * Why couldn't we create/open the file?  Check for directory
            *   and file existence
            bGotFile = FILE(pcFileName)
            cDirName = THIS.JustPath(pcFileName)
            bGotDir = THIS.IsADir(cDirName)
            X_ERRMSG = x_errmsg + '; (file ' + ;
              IIF( bGotFile, 'exists', 'does not exist') + ', dir ' + ;
              IIF( bGotDir, 'exists', 'does not exist') + ')'
            ERROR X_ERRMSG
        ENDIF
        RETURN nLLHndl
    ENDFUNC

    *- LL_Read() - Read a line from a low-level file
    *    Input: nLLHndl - Previously opened file handle
    *           bStripCRLF - (optional) If .T., strip CR, LF from end of line
    *           nBytes2Read - (optional) No. of bytes desired (default = 254)
    *     Retn: One line read from the file (if FEOF(), returns null string)
    *           The error handler is called if handle is invalid
    FUNCTION LL_Read ( pnLLHndl, pbStripCRLF, pnBytes2Read )
        LOCAL cLineRD

        * Check for valid parameters
        IF NOT (PCOUNT() >= 1 AND TYPE('pnLLHndl') = 'N' AND pnLLHndl > 0)
            ERROR 'Invalid parameters were passed'
        ENDIF

        * If we're at FEOF(), return a null string
        IF FEOF(pnLLHndl)
            RETURN ''
        ENDIF

        * Define our default bytes to read
        IF PCOUNT() < 3 OR TYPE('pnBytes2Read') <> 'N'
            pnBytes2Read = 254
        ENDIF

        * Fox has 2 functions for this:
        IF pbStripCRLF

            * FGETS( nHndl, [nBytes] ) - Returns up to nBytes (default = 254) or up
            *     to a CR, whichever comes first.  It strips any CR, LFs.
            cLineRD = FGETS( pnLLHndl, pnBytes2Read )
        ELSE

            * FREAD( nHndl, nBytes ) - Returns up to nBytes or until it hits FEOF(),
            *     whichever comes first.  It includes any CR, LFs.
            cLineRD = FREAD( pnLLHndl, pnBytes2Read )
        ENDIF
        RETURN cLineRD
    ENDFUNC

    *- LL_Write() - Write a string to a low-level file
    *    Input: pnLLHndl - Previously opened file handle
    *           pcWriteStr - String to be written
    *           pbNoCrLf - (optional) If .T., no CR, LF's are added
    *     Retn: .T.; string written adding CR, LF if desired.
    *           Error handler called if incorrect number of bytes written or
    *             handle is invalid.
    FUNCTION LL_Write ( pnLLHndl, pcWriteStr, pbNoCrLf )
        LOCAL nChkLen, nWrtLen, cAction

        * Check for valid parameters
        IF NOT (PCOUNT() >= 1 AND TYPE('pnLLHndl') = 'N' AND pnLLHndl > 0 AND ;
          TYPE('pcWriteStr') = 'C')
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Write the string adding a CR,LF
        nChkLen = LEN(pcWriteStr)
        IF pbNoCrLf

            * FWRITE() just does what you tell it to
            nWrtLen = FWRITE(pnLLHndl,pcWriteStr)
            cAction = 'FWRITE'
        ELSE

            * FPUTS() adds a CR, LF
            nWrtLen = FPUTS(pnLLHndl,pcWriteStr)
            nChkLen = nChkLen + 2
            cAction = 'FPUTS'
        ENDIF

        * Call the error handler if an incorrect number of bytes are written
        IF nWrtLen <> nChkLen
            FCLOSE(pnLLHndl)            && Try to close the file first
            X_ERRMSG = 'Incorrect number of bytes written to File.'
            X_ERRCMD = cAction + '(' + LTRIM( STR(pnLLHndl) ) + ',"' + ;
              pcWriteStr + '")'
            ERROR X_ERRMSG
        ENDIF
        RETURN .T.
    ENDFUNC

    *- LL_Flush() - Flush a low-level file
    *    Input: pnLLHndl - Previously opened file handle
    *           pbForceIt - .T. = Force Windows to flush now, .F. = let VFP do
    *                       it at its convenience
    *     Retn: .T. and file Flushed.
    FUNCTION LL_Flush ( pnLLHndl, pbForceIt)

        * Check for valid parameters
        IF NOT (PCOUNT() < 3 AND TYPE('pnLLHndl') = 'N' AND pnLLHndl > 0)
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Flush the file
        FFLUSH(pnLLHndl, pbForceIt)
        RETURN .T.
    ENDFUNC

    *- LL_Close() - Close a low-level file
    *    Input: pnLLHndl - Previously opened file handle
    *     Retn: .T.; file closed.
    *           Error handler called if close fails.
    FUNCTION LL_Close ( pnLLHndl )

        * Check for valid parameters
        IF NOT (PCOUNT() = 1 AND TYPE('pnLLHndl') = 'N' AND pnLLHndl > 0)
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Close the file
        FFLUSH(pnLLHndl)
        IF NOT FCLOSE(pnLLHndl)

            * Call the Error Handler if that failed
            X_ERRMSG = 'Could not close Text File.'
            X_ERRCMD = 'FCLOSE(' + LTRIM(STR(pnLLHndl)) + ')'
            ERROR [Could not close Text File]
        ENDIF
        RETURN .T.
    ENDFUNC

    *- LL_ToEOF() - Position a low-level file to FEOF()
    *    Input: pnLLHndl - Previously opened file handle
    *     Retn: Number of bytes moved; file is at FEOF().
    *           The error handler is called if handle is invalid
    FUNCTION LL_ToEOF ( pnLLHndl )

        * Check for valid parameters
        IF NOT (PCOUNT() = 1 AND TYPE('pnLLHndl') = 'N' AND pnLLHndl > 0)
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Re-position the file - move to offset 0 relative to End of File (2)
        RETURN FSEEK(pnLLHndl, 0, 2)
    ENDFUNC

    *- LL_ToBOF() - Position a low-level file to FBOF()
    *    Input: pnLLHndl - Previously opened file handle
    *     Retn: Number of bytes moved; file is at beginning.
    *           The error handler is called if handle is invalid
    FUNCTION LL_ToBOF ( pnLLHndl )

        * Check for valid parameters
        IF NOT (PCOUNT() = 1 AND TYPE('pnLLHndl') = 'N' AND pnLLHndl > 0)
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Re-position the file - move to offset 0 relative to End of File (2)
        RETURN FSEEK(pnLLHndl, 0, 0)
    ENDFUNC

    *- LL_IsLock() - Return .T. if the file is locked
    *    Input: pcFileName - File name to locked
    *     Retn: .T. is return is the file is locked
    FUNCTION LL_IsLock( pcFileName )
        LOCAL nLLHndl, bGotError

        * Check for valid parameters
        IF NOT (PCOUNT() = 1 AND TYPE('pcFileName') = 'C' AND ;
          NOT EMPTY(pcFileName))
            ERROR 'Invalid parameters were passed'
        ENDIF

        * Try to open the file.  If FOPEN errors a value less than 1 then
        *  the file musted be locked
        bGotError = .F.
        IF FILE(pcFileName)
            nLLHndl = FOPEN(pcFileName, 2)
            IF nLLHndl < 1
                bGotError = .T.
            ELSE
                FCLOSE(nLLHndl)
            ENDIF
        ENDIF

        * Done
        RETURN bGotError
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

    *- Error() - Error handlerr
    FUNCTION Error(nErrorNum, cMethod, nLine)
        LOCAL aErrInfo[7], cMethName, cSys16, cCmd, oParent, bGotGlobal, ;
          cAction, cHndlCmd, nChoice

        * We're going to handle only 1705 - Access Denied errors, but them only
        *   if THIS.bHandle1705 is .T.
        IF nErrorNum = 1705 AND THIS.bHandle1705

            * Ignore this; just return to the next line
            RETURN
        ENDIF

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
            goError.RegisterError(nErrorNum, cMethName, nLine, @aErrInfo, ;
              cSys16, THIS)
            bGotGlobal = .T.
        ENDIF

        * Handle this error as best we can after assuming our return action
        cAction = 'RETURN'
        DO CASE

        * First, try the parent
        CASE NOT ISNULL(oParent)
            cAction = oParent.Error(nErrorNum, cMethName, nLine)

        * Next, the global error handling object
        CASE bGotGlobal
            cAction = goError.HandleError(nErrorNum, cMethName, nLine, @aErrInfo, ;
              cSys16, THIS)

        * There may be some other global error handler.  So give it what it
        *   wants.  Caution: It may be called as a function or with a DO
        CASE NOT EMPTY( ON('ERROR') )
            cHndlCmd = UPPER(ON('ERROR') )
            cHndlCmd = STRTRAN( STRTRAN( STRTRAN( STRTRAN( STRTRAN( cHndlCmd, ;
              'PROGRAM()', '"' + cMethName + '"'), ;
              'ERROR()',   'nErrorNum'), ;
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
            nChoice = MESSAGEBOX('Error #: ' + LTRIM(STR(nErrorNum)) + ;
              CHR(13) + ;
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
    ENDFUNC

    *- PROT GetAttribNumb() - Convert attribute chars into numbers (rel or abs)
    PROTECTED FUNCTION GetAttribNumb(cAttribs, dwAttr)
        LOCAL cDesAttribs, cNewAttr, c2Do, nPosn, cThisAttr, bAdd, cLtr, ;
          nRetAttr

        * Attribute numbers are additive as follows:
        *                Numb   Ret. Char.  Bit Posn.
        *   ReadOnly   -    1       R           0
        *   Hidden     -    2       H           1
        *   System     -    4       S           2
        *   Directory  -   16       D           4
        *   Archive    -   32       A           5
        *   Normal     -  128       N           7
        *   Temporary  -  512       T           9
        *   Compressed - 2048       C          11

        * The passed cAttribs string can be either:
        *   Absolute characters like "RA" or "RSH"
        *   Relative space-separated characters like "-R +A"

        * We're to return dwAttr to reflect the desired result
        cDesAttribs = UPPER(cAttribs)
        IF [+] $ cDesAttribs OR [-] $ cDesAttribs

            * Convert the current attributes into letters
            cNewAttr = THIS.AttrDW2Chars(dwAttr)

            * Now, doctor that string to end up with the characters we want
            c2Do = ALLTRIM(cDesAttribs)
            DO WHILE NOT EMPTY(c2Do)

                * Extract one relative attribute change
                nPosn = AT(' ', c2Do)
                IF nPosn = 0
                    cThisAttr = c2Do
                    c2Do = 0
                ELSE
                    cThisAttr = LEFT(c2Do, nPosn-1)
                    c2Do = LTRIM( SUBSTR(c2Do, nPosn+1) )
                ENDIF
                bAdd = (cThisAttr = [+])
                cLtr = SUBSTR(cThisAttr, 2, 1)

                * Add or subtract that letter
                DO CASE

                * Don't add if it's already there
                CASE bAdd AND NOT cLtr $ cNewAttr
                    cNewAttr = cNewAttr + cLtr

                * Don't subtract unless it's there
                CASE cLtr $ cNewAttr AND NOT bAdd
                    cNewAttr = STRTRAN(cNewAttr, cLtr, '')
                ENDCASE
            ENDDO

            * These are the new absolute attributes we want
            cDesAttribs = cNewAttr
        ENDIF

        * Convert the absolute attributes into a number
        nRetAttr = 0
        IF 'R' $ cDesAttribs
            nRetAttr = 1
        ENDIF
        IF 'H' $ cDesAttribs
            nRetAttr = nRetAttr + 2
        ENDIF
        IF 'S' $ cDesAttribs
            nRetAttr = nRetAttr + 4
        ENDIF
        IF 'D' $ cDesAttribs
            nRetAttr = nRetAttr + 16
        ENDIF
        IF 'A' $ cDesAttribs
            nRetAttr = nRetAttr + 32
        ENDIF
        IF 'N' $ cDesAttribs
            nRetAttr = nRetAttr + 128
        ENDIF
        IF 'T' $ cDesAttribs
            nRetAttr = nRetAttr + 512
        ENDIF
        IF 'C' $ cDesAttribs
            nRetAttr = nRetAttr + 2048
        ENDIF
        RETURN nRetAttr
    ENDFUNC

    *- PROT AttrDW2Chars() - Convert an attribute double-word into characters
    PROTECTED FUNCTION AttrDW2Chars(dwAttrsIn)
        LOCAL cRetChars

        * Attribute numbers are additive as follows:
        *                Numb   Ret. Char.  Bit Posn.
        *   ReadOnly   -    1       R           0
        *   Hidden     -    2       H           1
        *   System     -    4       S           2
        *   Directory  -   16       D           4
        *   Archive    -   32       A           5
        *   Normal     -  128       N           7
        *   Temporary  -  512       T           9
        *   Compressed - 2048       C          11
        cRetChars = ''
        IF BITTEST(dwAttrsIn, 11)               && Compressed
            cRetChars = 'C'
        ENDIF
        IF BITTEST(dwAttrsIn, 9)                && Temporary
            cRetChars = 'T' + cRetChars
        ENDIF
        IF BITTEST(dwAttrsIn, 7)                && Normal
            cRetChars = 'N' + cRetChars
        ENDIF
        IF BITTEST(dwAttrsIn, 5)                && Archive
            cRetChars = 'A' + cRetChars
        ENDIF
        IF BITTEST(dwAttrsIn, 4)                && Directory
            cRetChars = 'D' + cRetChars
        ENDIF
        IF BITTEST(dwAttrsIn, 2)                && System
            cRetChars = 'S' + cRetChars
        ENDIF
        IF BITTEST(dwAttrsIn, 1)                && Hidden
            cRetChars = 'H' + cRetChars
        ENDIF
        IF BITTEST(dwAttrsIn, 0)                && ReadOnly
            cRetChars = 'R' + cRetChars
        ENDIF
        RETURN cRetChars
    ENDFUNC

    *- PROT GetLastAPIError() - Return the last error message
    PROTECTED FUNCTION GetLastAPIError(cMsgIn, nForceNum)
        LOCAL nDOSErrNum, cDosErrMsg, nFlags, cDOSBuffer, nLen, cBuffer, cRetMsg

        * Input Notes:
        *   cMsgIn - User-defined message preface (optional)

        * Get the last error from window
        IF VARTYPE(nForceNum) = 'N'
            nDOSErrNum = nForceNum
        ELSE
            nDOSErrNum = GetLastError()
        ENDIF
        cDosErrMsg = ''

        * Now, get the error message (if we can)
        nFlags = FORMAT_MESSAGE_ALLOCATE_BUFFER + FORMAT_MESSAGE_FROM_SYSTEM + ;
          FORMAT_MESSAGE_IGNORE_INSERTS
        cDOSBuffer = ''
        nLen = FormatMessage(nFlags, 0, nDOSErrNum, 0, @cDOSBuffer, 0, 0)
        IF nLen <> 0
            cBuffer = REPLICATE(Chr(0), 500)
            = CopyMemory(@cBuffer, cDOSBuffer, nLen)
            = LocalFree(cDOSBuffer)
            cDosErrMsg = STRTRAN(LEFT(cBuffer, nLen), Chr(13)+Chr(10), " ")
        ENDIF

        * Add this to our passed message as appropriate
        cRetMsg = 'API Error ' + TRANSFORM(nDOSErrNum)
        IF NOT EMPTY(cDosErrMsg)
            cRetMsg = cRetMsg + ' - ' +  ALLTRIM(cDosErrMsg)
        ENDIF
        IF VARTYPE(cMsgIn) = 'C' AND NOT EMPTY(cMsgIn)
            cRetMsg = cMsgIn + [ (] + cRetMsg + [)]
        ENDIF

        * Set our last error properties
        THIS.nLastErrorNumb = nDOSErrNum
        THIS.cLastErrorMsg = cRetMsg

        * Done
        RETURN cRetMsg
    ENDFUNC

    *- ClearError() - Clear our error properties
    FUNCTION ClearError()

        * Clear our error settings
        THIS.nLastErrorNumb = 0
        THIS.cLastErrorMsg = ''
    ENDFUNC

    *- Release() - Removes this object from memory
    *    Input: none
    *     Retn: object gone, memory released
    FUNCTION Release
        RELEASE THIS
    ENDFUNC
ENDDEFINE

* KBufferedFile Class Definition for this function class
DEFINE CLASS KBufferedFile AS KOSFiles

    * Some files are too large to use FILETOSTR() handling.  Instead we have to
    * use low level functions to open and read the file - but we can only read
    * part of it at a time.  This class handles that; here's how it works:
    *
    * 1. Open the file for buffered handling:
    *     oBuffFile = CREATEOBJECT([KBufferedFile], cFileName, nBufferSize)
    *
    *     This will create this buffered file object, open the file, and do
    *     the first read.
    *
    *     Note: Make sure nBufferSize is well over whatever amount of bytes you
    *           want to deal with at once.  The default is 10K bytes.
    *
    * 2. Setup to display the percentage read so far (optional)
    *     oBuffFile.SetupPercentage(nPctRow, nPctCol)
    *
    *     Note: While displaying the percentage read is optional, this
    *           percentage is always calculated and in THIS.nPctRead.   So, it
    *           could be used for progress bars, etc.
    *
    * 3. Read the file as follows:
    *     cFileStr = []
    *     DO WHILE LEN(cFileStr) > 0 OR NOT oBuffFile.bAtEOF()
    *
    *         * Get more of the file if we need it; get at least nXYZ bytes
    *         IF LEN(cFileStr) < nXYZ AND NOT oBuffFile.bAtEOF
    *             cFileStr = cFileStr + oBuffFile.GetString( nXYZ )
    *         ENDIF
    *
    *         * Handle this data
    *         ProcessString( @cFileStr )
    *     ENDDO
    *
    *     This will automatically close the file when it's Destroyed or when
    *     all bytes are read.

    * Standard Properties
    Name = 'KBufferedFile'

    * File Properties
    cFileName = []
    nFileHandle = 0             && File Handle
    bFileAtEOF = .F.            && .T. when nothing left to read
    nFileSize = 0
    nBytesRead = 0
    nPctRead = 0

    * Percentage Display properties
    bShowPercentRead = .F.
    nPctDspRow = 0
    nPctDspCol = 0

    * Buffer Properties
    nBufferSize = 10240         && 10K
    cBuffer = []                && Buffered characters for the file
    bAtEOF = .F.                && .T. when we have no chars left to give out

    * Custom Method List
    *- Init() - Set ourselves up
    *- GetString() - Return the number of bytes requested
    *- PROT ReadFile() - Read nBufferSize chars of the file into our buffer
    *- DisplayPercentage() - Display the current percentage read for file
    *- SetupPercentage() - Setup to display the file read percentage
    *- Destroy() - Make sure our file is closed

    * Custom Methods

    *- Init() - Set ourselves up
    FUNCTION Init(cFileNm, nBuffSize, bNoRead)
        IF NOT DODEFAULT()
            RETURN .F.
        ENDIF

        * Set our properties
        WITH THIS
            .cFileName = cFileNm
            IF VARTYPE(nBuffSize) = 'N' AND nBuffSize > 10240
                .nBufferSize = nBuffSize
            ENDIF

            * Open the file (Read-Only) and read the first chunk into it
            .nFileHandle = .LL_Open(cFileNm, [R])

            * Get the file size
            .nFileSize = .LL_ToEOF( .nFileHandle )
            .LL_ToBOF( .nFileHandle )

            * Read nBufferSize characters of the file into our buffer
            IF NOT bNoRead
                .ReadFile()
            ENDIF
        ENDWITH

        * Done
        RETURN .T.
    ENDFUNC

    *- GetString() - Return the number of bytes requested
    FUNCTION GetString( nBytesWanted )
        LOCAL cRetString
        WITH THIS

            * Read our file if we need to
            DO WHILE LEN( .cBuffer ) < nBytesWanted AND NOT .bFileAtEOF
                .ReadFile()
            ENDDO

            * Return the smaller of our buffer or the bytes they want
            IF LEN( .cBuffer ) < nBytesWanted
                cRetString = .cBuffer
                .cBuffer = []
                .bAtEOF = .T.
            ELSE
                cRetString = LEFT( .cBuffer, nBytesWanted)
                .cBuffer = SUBSTR(.cBuffer, nBytesWanted+1)
            ENDIF
        ENDWITH
        RETURN cRetString
    ENDFUNC

    *- PROT ReadFile() - Read nBufferSize chars of the file into our buffer
    PROTECTED PROCEDURE ReadFile()
        LOCAL cText, nPct

        * Can't read if we're at EOF()
        WITH THIS
            IF NOT .bFileAtEOF

                * Get some text but don't strip CR_LFs
                cText = .LL_Read( .nFileHandle, .F., .nBufferSize)
                IF FEOF( .nFileHandle )
                    .bFileAtEOF = .T.

                    * Close the file
                    .LL_Close( .nFileHandle )
                ENDIF

                * Add this to our buffer
                .cBuffer = .cBuffer + cText

                * Update our measures
                .nBytesRead = .nBytesRead + LEN(cText)
                nPct = ROUND(100 * .nBytesRead / .nFileSize, 1)
                .nPctRead = nPct

                * Display the percentage if we're supposed to
                IF .bShowPercentRead
                    .DisplayPercentage()
                ENDIF
            ENDIF   && NOT .bFileAtEOF
        ENDWITH

        * Done
        RETURN
    ENDPROC

    *- DisplayPercentage() - Display the current percentage read for file
    PROCEDURE DisplayPercentage()
        LOCAL nPctRow, nPctCol
        WITH THIS
            nPctRow = .nPctDspRow
            nPctCol = .nPctDspCol
            @ nPctRow,nPctCol SAY STR(.nPctRead, 5, 1) + [%]
        ENDWITH
        RETURN
    ENDPROC

    *- SetupPercentage() - Setup to display the file read percentage
    FUNCTION SetupPercentage(nRow, nCol)
        WITH THIS

            * Check our parameters
            IF VARTYPE(nRow) = [N] AND INT(nRow) >= 0
                .nPctDspRow = INT(nRow)
            ENDIF
            IF VARTYPE(nCol) = [N] AND INT(nCol) >= 0
                .nPctDspCol = INT(nCol)
            ENDIF
            .bShowPercentRead = .T.
            .DisplayPercentage()
        ENDWITH
        RETURN .T.
    ENDFUNC

    *- Destroy() - Make sure our file is closed
    PROCEDURE Destroy()
        IF NOT THIS.bFileAtEOF
            THIS.LL_Close( THIS.nFileHandle )
            THIS.bFileAtEOF = .T.
        ENDIF
        DODEFAULT()
    ENDPROC
ENDDEFINE

* KBufferedLines Class Definition for this function class
DEFINE CLASS KBufferedLines AS KBufferedFile

    * Some file buffering needs to be done for large searches that report line
    * numbers for matches. This class is similar to KBufferedFile except:
    *   1. There is no GetString() method. Instead, searches must be done
    *       within the cBuffer property. NOTHING SHOULD BE EXTRACTED.
    *   2. A ReloadBuffer() method will clear out the buffer and reload more
    *       data from the file. It will return the number of bytes read.
    *       bFileAtEOF will be set to .T. when there's nothing more to read.
    *   3. A GetLineNumber() method will return the absolute line number for a
    *       relative position within the buffer.

    * Standard Properties
    Name = 'KBufferedLines'

    * File Properties
    cFileName = []
    nFileHandle = 0             && File Handle
    bFileAtEOF = .F.            && .T. when nothing left to read
    nFileSize = 0
    nBytesRead = 0

    * Buffer Properties
    nBufferSize = 250000
    cBuffer = []                && Buffered characters for the file
    cExcess        = ''         && End incomplete line extracted from buffer
    bAtEOF = .F.                && .T. when we have no chars left to give out

    * We also want an array to define line numbers vs position as:
    *       .aRA[1] - One line of text
    *       .aRA[2] - Starting position in the BUFFER
    *       .aRA[3] - Absolute line number in the FILE
    *   Note that the row number is the relative line number
    oLinePosns = NULL

    * Special line properties
    nLastLineNum  = 0           && Last line NUMBER for earlier text

    * Custom Method List
    *- Init() - Set ourselves up
    *- ReloadBuffer() - Process a newly read buffer to
    *- GetAbsLineNumber() - Return the Absolute Line Number for a buffer line no.
    *- Buffer2Array() - Put THIS.cBuffer into an array with line positions
    *- Destroy() - Make sure our file is closed

    * Custom Methods

    *- Init() - Set ourselves up
    FUNCTION Init(cFileNm, nBuffSize)
        IF NOT DODEFAULT(cFileNm, nBuffSize, .T.)
            RETURN .F.
        ENDIF
        THIS.ReloadBuffer()
        RETURN .T.
    ENDFUNC

    *- ReloadBuffer() - Process a newly read buffer to
    FUNCTION ReloadBuffer()
        LOCAL cText, nLastEOL
        WITH THIS

            * Read the file to reload our buffer
            .cBuffer = .cExcess
            .ReadFile()     && Sets .cBuffer, .nBytesRead and .nPctRead
            cText = .cBuffer

            * We want to extract the last line and put it in cExcess. However,
            *   the last character could be a CR. So, if we look for the last
            *   LF, and put everything AFTER that into cExcess, we'll be OK.
            nLastEOL = RAT(LF, cText)
            IF nLastEOL = 0 OR nLastEOL = LEN(cText)
                .cExcess = ''
            ELSE
                .cExcess = SUBSTR(cText, nLastEOL+1)
                cText = LEFT(cText, nLastEOL)
            ENDIF
            .cBuffer = cText
        ENDWITH

        * Load up THIS.oLinePosns and define all position values
        THIS.Buffer2Array()

        * Done
        RETURN THIS.cBuffer
    ENDFUNC

    *- GetAbsLineNumber() - Return the Absolute Line Nu. for a buffer position
    FUNCTION GetAbsLineNumber(nBuffPosn, cTheText)
        LOCAL oLines, nLineRow, nLine

        * Get the array into a local object in case of a bug
        oLines = THIS.oLinePosns
        WITH oLines

            * Find the matching position in oLinePosns
            *       .aRA[1] - One line of text
            *       .aRA[2] - Starting position in the BUFFER
            *       .aRA[3] - Absolute line number in the FILE
            *   Note that the row number is the relative line number
            nLineRow = 1
            FOR nLine = 1 TO .nRows
                IF .aRA[nLine,2] > nBuffPosn
                    nLineRow = .aRA[nLine-1,3]
                    cTheText = .aRA[nLine-1,1]
                    EXIT
                ENDIF
            ENDFOR
        ENDWITH

        * Done
        oLines = NULL
        RETURN nLineRow
    ENDFUNC

    *- Buffer2Array() - Put THIS.cBuffer into an array with line positions
    FUNCTION Buffer2Array()
        LOCAL oLines, nBegAbsLine, nRelPosn, nLine, nLen

        * Get the file's text and put into an array - one row per line
        oLines = CREATEOBJECT('FileLines', THIS.cBuffer, .F., .T.)

        * Add 2 columns
        oLines.InsertCols(2)

        * ALINES() removed CR_LFs from each line; knowing that, fill in the 2nd
        *   and 3rd columns' starting positions and the absolute line number
        *       .aRA[1] - One line of text
        *       .aRA[2] - Starting position in the BUFFER
        *       .aRA[3] - Absolute line number in the FILE
        *   Note that the row number is the relative line number
        nBegAbsLine = THIS.nLastLineNum
        nRelPosn = 1
        WITH oLines
            FOR nLine = 1 TO .nRows
                nLen = LEN(.aRA[nLine,1]) + 2    && CR_LF
                .aRA[nLine,2] = nRelPosn
                .aRA[nLine,3] = nBegAbsLine + nLine

                * Update the relative position
                nRelPosn = nRelPosn + nLen
            ENDFOR
        ENDWITH

        * Set our properties
        THIS.nLastLineNum = oLines.aRA[oLines.nRows,3]
        THIS.oLinePosns = oLines
    ENDFUNC

    *- Destroy() - Make sure our file is closed
    PROCEDURE Destroy()
        IF NOT ISNULL(THIS.oLinePosns)
            THIS.oLinePosns.Release()
        ENDIF
    ENDPROC
ENDDEFINE
