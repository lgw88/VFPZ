*****************************************************************************
*!*                                                                       *!*
*!* ATFixDbfFpt 1.3 repairs invalid                                      *!*
*!* dbc, dbf, frx, lbx, mnx, pjx, scx, vcx (or user defined xBase)        *!*
*!* and memo file headers                                                 *!*
*!*                                                                       *!*
*!* FoxBASE, FoxBASE+, dBASE III PLUS, FoxPro, dBaseIV and                *!*
*!* Visual FoxPro  version 3.0 - 7.x type table and memo files supported. *!*
*!*                                                                       *!*
*!* This version can't fix table / memo if table field block is           *!*
*!* corrupted!                                                            *!*
*!*                                                                       *!*
*!* Copyright (C) 2001  Arto Toikka.                                      *!*
*!*                                                                       *!*
*!* This library is free software; you can redistribute it and/or         *!*
*!* modify it under the terms of the GNU Library General Public           *!*
*!* License as published by the Free Software Foundation; either          *!*
*!* version 2 of the License, or any later version.                       *!*
*!*                                                                       *!*
*!* This library is distributed in the hope that it will be useful,       *!*
*!* but WITHOUT ANY WARRANTY; without even the implied warranty of        *!*
*!* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU     *!*
*!* Library General Public License for more details.                      *!*
*!*                                                                       *!*
*!* You should have received a copy of the GNU Library General Public     *!*
*!* License along with this library; if not, write to the                 *!*
*!* Free Software Foundation, Inc., 59 Temple Place - Suite 330,          *!*
*!* Boston, MA  02111-1307, USA. You can get it also at:                  *!*
*!* http://www.gnu.org/copyleft/library.html#SEC3                         *!*
*!*                                                                       *!*
*!* Even this is under a license of GNU you can always send whatever      *!*
*!* payment for a future development of this and other free tools to me,  *!*
*!* but it's totally up to you.                                           *!*
*!*                                                                       *!*
*!* Arto Toikka                                                           *!*
*!* Eestinkallio 1                                                        *!*
*!* 02280 Espoo                                                           *!*
*!* Finland                                                               *!*
*!* at@mp.utu.net                                                         *!*
*!* tel. +358 400 665566                                                  *!*
*!* fax +358 9 8552367                                                    *!*
*!*                                                                       *!*
*****************************************************************************
*!*
*!* Syntax (Program)
*!*
*!* DO ATFixDbfFpt WITH tWhatDbf, tnRepairMode, tcContainer, tnMemoBlockSice, tlNoInfo, tlNoBackups, tnLang
*!*
*!* Syntax (Function)
*!*
*!* ATFixDbfFpt(tWhatDbf, tnRepairMode, tcContainer, tnContainerBlockSize, tnMemoBlockSice, tlNoInfo, tlNoBackups, tnLang)
*!*
*!* tWhatDbf              Name (with .ext) of the table to repair
*!*                       dbc, dbf, frx, lbx, mnx, pjx, scx, vcx or user defined
*!* tnRepairMode          0 (Default) Only report generated
*!*                       1 table header checked and fixed.
*!*                       2 memo header checked and fixed.
*!*                       3 table and memo header checked and fixed.
*!*                       ** values 4 and greater not supported yet
*!*                       ** values 4 and greater are for greater data-anlysis.
*!*                       4 All scannable data readed per record from old table file
*!*                         and writed to the new table file, new header writed,
*!*                         new field block writed form template file (if exist)
*!*                       5 All scannable data readed per record from old memo file
*!*                         and writed to the new memo file, new header writed,
*!*                         new field block writed form template file (if exist)
*!*                       6 All scannable data readed per record from old table and memo files
*!*                         and writed to the new table and memo files file, new headers writed,
*!*                         new field blocks writed form template files (if exist)
*!* tcContainer           Relative path and name of the container (+ .EXT). Give it if there is
*!*                       a problem with table / container link and you like to refresh it.
*!*                       (Default empty i.e. no container link refreshed)
*!*                       NOTE!!!! If there isn't container block in the file header
*!*                       tcContainer value shoud be logical .F. (all VFP data files have a 263 
*!*                       character long container block)
*!* tnMemoBlockSice		  Memo block size (Default 64)
*!* tlNoInfo        	  .T. = do not show info screen (only errors) (Default show info)
*!* tlNoBackups     	  .T. = do not make backups from corrupted? files (Default make backups)
*!* tnLang          	  Language, 1 = finnish, others are english (Default finnish)
*!*                       If you add languages please email your addition to me
*!*
*!*
*!* NOTE:  (Backup)
*!*        If make backup is selected following files are generated
*!*        (to the same directory where table is lovated)
*!*        Table: table name (with .EXT) + nn (nn = 1 to 99)
*!*        Memo:  memo name (with .EXT) + nn (nn = 1 to 99)
*!*
*!*
*!* NOTE:  (RETURN VALUE)
*!*        Look tnRepairMode
*!*        positive value (including zero) - > event succesful
*!*        negative values - > event not succesful
*!'  -10 = Only report generated, not succesful
*!*  -50 = Invalid parameters
*!*
*!* NOTE:  (REPORT)
*!*        ATFixDbfFpt writes info file to the same direcory where table file is located.
*!*        Name of the info file is:
*!*        "ATFix_" + name of the table file (without .EXT) + ".TXT"
*!*
*!*        IF RETURN VALUE <> 0 AND <> 1, report is not generated
*!*
*!* Last modified:
*!* 07/01/2001  Started
*!* 07/03/2001  Version 1.0
*!* 07/04/2001  - possibility to rewrite container block added
*!*             -
*!* 07/10/2001  Sorry 1.1b was VFP7 version, VFP5 - 6 support added
*!* 07/11/2001  Reporting bugs fixed
*!* 07/20/2001  Forgotten SET STEP ON line removed
*!*
*!*
*!* 07/24/2001  All messages (except info) moved to the FixMessage function
*!* 07/24/2001  Parameter tcContainer changed.
*!*             If type of the tcContainer is Character -> container block exist 
*!*             (VFP data file)
*!*             - if length of tcContainer is zero, container block isn't overwritten
*!*             - if length of tcContainer is greater than zero, 
*!*               container block is overwritten with the value in tcContainer
*!*             If type of the tcContainer is not Character -> container block 
*!*             doesn't exist (no VFP data file)
*!* 07/24/2001  tnRepairMode = 1 generated an error, FIXED
*!* 07/24/2001  error when fixing free table without container block, FIXED
*!*             NOTE: in the above case DO NOT GIVE a character value to the tcContainer
*!* 07/24/2001  tnRepairMode = 4 ADDED. If tnRepairMode 1 or 3 (table), 
*!*             new fixed header is overwritten to the old data file
*!*             If tnRepairmode = 4 new file is generated first and old data file
*!*             is overwritten with the new one. (this is the next step to the 
*!*             next version where user can input field block if it is corrupted.
*!* 07/25/2001  Windir changed to the Temp dir
*!*
*!* Notes:      Please if you have any wishes or improvments (or bugs??), e-mail me.
*!*
*!*
*!****************************************************************************

*!**!**!**!**!**!**!**!**!**!*
*!*                        *!*
*!* Function FIXDBF        *!*
*!*                        *!*
*!**!**!**!**!**!**!**!**!**!*

* FUNCTION FIXDBF

*!**!**!**!**!**!**!**!**!**!*

Lparameters tWhatDbf, tnRepairMode, tcContainer, tnMemoBlockSice, tlNoInfo, tlNoBackups, tnLang

*!* tWhatDbf              Name (with .ext) of the table to repair
*!*                       dbc, dbf, frx, lbx, mnx, pjx, scx, vcx or user defined
*!* tnRepairMode          0 (Default) Only report generated
*!*                       1 table header checked and fixed.
*!*                       2 memo header checked and fixed.
*!*                       3 table and memo header checked and fixed.
*!*                       ** values 4 and greater not supported yet
*!*                       ** values 4 and greater are for greater data-anlysis.
*!*                       4 All scannable data readed per record from old table file
*!*                         and writed to the new table file, new header writed,
*!'                         new field block writed form template file (if exist)
*!*                       5 All scannable data readed per record from old memo file
*!*                         and writed to the new memo file, new header writed,
*!'                         new field block writed form template file (if exist)
*!*                       6 All scannable data readed per record from old table and memo files
*!*                         and writed to the new table and memo files file, new headers writed,
*!*                         new field blocks writed form template files (if exist)
*!* tcContainer           Relative path and name of the container (+ .EXT). Give it if there is
*!*                       a problem with table / container link and you like to refresh it.
*!*                       (Default empty i.e. no container link refreshed)
*!*                       NOTE!!!! If there isn't container block in the file header
*!*                       tcContainer value shoud be logical .F. (all VFP data files have a 263 
*!*                       character long container block)
*!* tnMemoBlockSice		  Memo block size (Default 64)
*!* tlNoInfo        	  .T. = do not show info screen (only errors) (Default show info)
*!* tlNoBackups           .T. = do not make backups from corrupted? files (Default make backups)
*!* tnLang          	  Language, 1 = finnish, others are english (Default finnish)
*!* tnLang          	  Language, 1 = finnish, others are english (Default finnish)
*!*                       If you add languages please email your addition to me

*!* i.e.
*!* m.tnRepairMode = 0					&& Only report generated (return -10) if not succesful
*!* INLIST(m.tnRepairMode, 1, 4)		&& Only Table repair
*!* INLIST(m.tnRepairMode, 1, 3, 4, 6)	&& Also Table repair
*!* INLIST(m.tnRepairMode, 2, 5)		&& Only Memo repair
*!* INLIST(m.tnRepairMode, 2, 3, 5, 6)	&& Also Memo repair

If Type("m.tnLang") # "N" Or m.tnLang < 1
  m.tnLang = 1  && FIN
Endif

m.tWhatDbf = Fullpath(m.tWhatDbf)

If !File(m.tWhatDbf)
  FixMessage(100, m.tWhatDbf,,m.tnLang)
  Return -50
Endif

If Type("m.tnRepairMode") # "N"
  m.tnRepairMode = 0
Else
  m.tnRepairMode = Abs(m.tnRepairMode)
  * If m.tnRepairMode > 4
  *   m.tnRepairMode = 0
  * Endif
Endif

If Type("m.tcContainer") = "C"
  m.tcContainer = Lower(Alltrim(m.tcContainer))
  IF !EMPTY(m.tcContainer)
    If !File(m.tcContainer)
      FixMessage(101, m.tcContainer,,m.tnLang)
      Return -50
    ENDIF
  Endif  
Else
  m.tcContainer = .F.
Endif

If Type("m.tnMemoBlockSice") # "N" Or ;
    M.tnMemoBlockSice < 0
  m.tnMemoBlockSice = Set("BLOCKSIZE")
Else
  m.tnMemoBlockSice = Int(m.tnMemoBlockSice)
Endif

If Type("m.tlNoInfo") # "L"
  m.tlNoInfo = .F.  && Show info
Endif

If Type("m.tlNoBackups") # "L"
  m.tlNoBackups = .F.  && make backups
Endif

Local ;
  lnSelect, ;
  lcTmpDbf

m.lnSelect = Select()
lcTmpDbf = ""

If m.tnRepairMode > 3 Or Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) < 7
  Local ;
    cMyTEMPDir

  Select 0

  m.cMyTEMPDir = ;
    IIF(Len(Getenv('TEMP'))=0,Sys(5)+Curdir()+;
    IIF(!Right(Curdir(),1)=='\','\',''),;
   Getenv('TEMP')+Iif(!Right(Getenv('TEMP'),1)=='\','\',''))
   
  m.lcTmpDbf = m.cMyTEMPDir + Sys(2015)

  Do While File(m.lcTmpDbf+".DBF") Or File(m.lcTmpDbf+".FPT")
    m.lcTmpDbf = m.cMyTEMPDir + Sys(2015)
  Enddo

  Create Table (m.lcTmpDbf) Free ;
    (ATFIX M Nocptrans)

  Append Blank

Endif

*!* FoxPro Advisor - September 1997 pages 42-48 / VFP7 help file 2001
*!*
*!* Header Block
*!*
*!*  Byte	Value
*!*     1	0x02   FoxBASE
*!*         0x03   FoxBASE+/dBASE III PLUS, FoxPro, dBaseIV, no memo
*!*         0x30   Visual FoxPro (with or without memo)
*!*         0x43   dBASE IV SQL table files, no memo
*!*         0x63   dBASE IV SQL system files, no memo
*!*         0x83   FoxBASE+/dBASE III PLUS, with memo
*!*         0x8B   dBASE IV with memo
*!*         0xCB   dBASE IV SQL table files, with memo
*!*         0xF5   FoxPro 2.x (or earlier) with memo
*!*         0xFB   FoxBASE with memo
*!*
*!*   2-4	Date of last update	YYMMDD
*!*
*!*   5-8	Number of records LSB-MSB format (see function UnLSBMSB)
*!*
*!*  9-10	Offset to start of data LSB-MSB format, same as HEADER()
*!*			(+1 is deletion flag 2Ah if deleted and 20h if not deleted
*!*			 +2 is the actuall address where the data begins).
*!*
*!* 11-12	Size of record LSB-MSB format (including deletion flag)
*!*
*!* 13-28	Not used
*!*
*!*    29	Bit flags
*!*			1	Structural compound index	(FoxPro, Visual FoxPro)
*!*			2	Memo fields					(Visual FoxPro)
*!*			3	Database container (DBC)	(Visual FoxPro)
*!*			4
*!*			5
*!*			6
*!*			7
*!*			8
*!*
*!*    30	Code Page
*!*
*!* 31-32	Not used
*!*
*!*
*!* Field Blocks - 32 bytes describe each field in the table.
*!*
*!*  Byte	Value
*!*  1-10	Field name
*!*
*!*    11	OOh
*!*
*!*    12	42h	Double    , B
*!*      	43h	Character , C
*!*      	44h	Date      , D
*!*      	46h	Float     , F
*!*      	47h	General   , G
*!*      	49h	Integer   , I
*!*      	4Ch	Logical   , L
*!*      	4Dh	Memo      , M
*!*      	4Eh	Numeric   , N
*!"         50h Picture   , P
*!*      	54h	DateTime  , T
*!*      	59h	Currency  , Y
*!*
*!* 13-14	Offset of field from beginning of record, LSB-MSB format
*!*         Where the data of this field begins is calculated as:
*!*			ASC(DBFHdrByte9)+ASC(DBFHdrByte10)*256+1+ASC(FldHdrByte13)+;
*!*         ASC(FldHdrByte14)*256 (same as)
*!*
*!* 15-16	Not used
*!*
*!* 17-18	Field length (non-numeric fields), LSB-MSB format
*!*
*!*    17	Field length (numeric fields)
*!*
*!*    18	Field decimals (numeric fields)
*!*
*!*    19	Visual Foxpro Sum of:
*!*			01h	Invisible system column
*!*			02h	Null value support
*!*			04h	Indicate binary data (Character, Memo, Currency, Integer,
*!*			DateTime, Double fields)
*!*			Others not used
*!*
*!* 20-32	Not used
*!*

Local ;
  lnHandler, ;
  lcReason, ;
  lnI, ;
  lcBackFile, ;
  lcInfo, ;
  lcInfoFile

*!* m.lnHandler		handler of the "fopened" file
*!* m.lcReason		reason if it can't be opened
*!* m.lnI			counter
*!* m.lcBackfile	Backup file name

Note: no binary Value

If !m.tlNoBackups And m.tnRepairMode # 0

  m.lcBackFile = m.tWhatDbf + "00"

  *!* && DataFixBacked = DFB
  If File(m.lcBackFile)
    For m.lnI = 1 To 99
      m.lcBackFile = m.tWhatDbf + Padl(Transform(m.lnI),2,"0")

      *!* && DataFixBacked = EXTnn, nn = 01-99
      If !File(m.lcBackFile)
        Exit
      Else
        If m.lnI = 99 And File(m.lcBackFile)
          Erase (m.lcBackFile)
          Exit
        Endif
      Endif
    Endfor
  Endif

  Wait Clear

  Note: Wait For makeing Dbf backup
  FixMessage(102, m.tWhatDbf, m.lcBackFile, tnLang)
  Copy File (m.tWhatDbf) To (m.lcBackFile)

  Wait Clear

  Note: backup ok
  FixMessage(103, m.lcBackFile,, tnLang)

Endif

m.lnHandler = Fopen(m.tWhatDbf, 12)			&& unbuffered

If m.lnHandler < 0  				        && Error generated creating file

  FixMessage(104+Val(Set("POINT")+Alltrim(Str(Ferror()))), m.tWhatDbf,, tnLang)
  Return FixExit(Iif(m.tnRepairMode = 0, -10, -1 * m.tnRepairMode), m.lcTmpDbf, m.lnSelect, m.lnHandler, m.tnLang)

Endif


*!* No errors so now we are in business

Local ;
  llTableIsAlreadyOK, ;
  lnFileSize, ;
  lnHeaderBlockSize, ;
  lcTableHeader, ;
  lcTableFixedHdr, ;
  lcMemoByte, ;
  lcTableContainer1, ;
  lcTableContainer2, ;
  lcFixedContainer1, ;
  lcFixedContainer2, ;
  lnOneFieldBlockSize, ;
  lcHeaderRecTerminator, ;
  lnContainerBlockSize, ;
  lnDataStart1, ;
  lnRecSize1, ;
  lnRecCount1, ;
  lnDataStart2, ;
  lnRecSize2, ;
  lnRecCount2, ;
  lnDataStart3, ;
  lnRecSize3, ;
  lnRecCount3, ;
  lnFieldCo3, ;
  lnRecSize4, ;
  lnNullFlagLen, ;
  lnAllFieldBlockSize, ;
  llIsMemo1, ;
  llIsMemo2, ;
  llIsMemo3, ;
  lcCodePage, ;
  lcFixError, ;
  lcFieldError, ;
  lcWhatFpt, ;
  lcFieldInfo, ;
  lcAllFieldInfo, ;
  llFieldNameOk, ;
  llFieldTypeOk, ;
  llFieldDecOk, ;
  lnFieldLen, ;
  lnI, ;
  lnK, ;
  lcSafety, ;
  llTableRepaired, ;
  llMemoRepaired, ;
  lnTooSlowToHandle


m.llTableIsAlreadyOK = .F.
m.lnFileSize = 0
m.lcTableHeader = ""
m.lcTableFixedHdr = ""
m.lcMemoByte = ""
m.lcTableContainer1 = "" && Actual container block
m.lcTableContainer2 = "" && File name in the container block
m.lcFixedContainer1 = "" && Actual container block
m.lcFixedContainer2 = "" && File name in the container block
m.lnDataStart1 = 0
m.lnRecSize1 = 0
m.lnRecCount1 = 0
m.lnDataStart2 = 0
m.lnRecSize2 = 0
m.lnRecCount2 = 0
m.lnRecCount3 = 0
m.lnAllFieldBlockSize = 0
m.llIsMemo1 = .F.
m.llIsMemo2 = .F.
m.llIsMemo3 = .F.
m.lcCodePage = Chr(0)
m.lcFixError = ""
m.lcFieldError = ""
m.lcWhatFpt = ""
m.lcFieldInfo = ""
m.lcAllFieldInfo = ""
m.llFieldNameOk = .F.
m.llFieldTypeOk = .F.
m.llFieldDecOk = .F.
m.lnFieldLen = 0
m.lnI = 0
m.lnK = 0
m.llTableRepaired = .F.
m.llMemoRepaired = .F.


*!* m.lcTableHeader		First m.lnHeaderBlockSize bytes of the file
*!* m.lnFileSize		Size of the file
*!* m.lnDataStartN		HEADER()
*!* m.lnRecSizeN		Length of the record + 1 (deleted flag)
*!* m.lnRecCountN		RECCOUNT()
*!* N = 1				values calculated from file size etc.
*!* N = 2				from header block (first m.lnHeaderBlockSize bytes of file)
*!* N = 3				values from data field block
*!* N = 4				Data offset

m.lnNullFlagLen = 0     && _NullFlags hidden field size (normally 4)
*!* 0 if _NullFlags doesn't exist

*!* m.llIsMemo1			Is there physical memo file
*!* m.llIsMemo2			Is there memo, What the header info says
*!* m.llIsMemo3			Is there memo, What the field info says
*!* m.lcFieldInfo       Field block

*!* m.llFieldNameOk		field name is okay
*!* m.llFieldTypeOK		field type is okay
*!* m.llFieldDecOk		field decimals is okay (if any)
*!* m.nFieldLen         field length

m.lnDataStart3 = 0		&& Offset to start of data, calulated
                        *!* from Field Block
*!* Total record width m.lnRecSize3 and m.lnRecSize3
m.lnRecSize3 = 0		&& This is calculated from the cFieldInfo
                        *!* FIELD length
m.lnRecSize4 = 0		&& This is evaluated from the offset
                        *!* of the last data field + length of
                        *!* that field
m.lnFieldCo3 = 0		&& How many fields there are


*!* Change next value if needed
m.lnHeaderBlockSize = 32
m.lcHeaderRecTerminator = Chr(0x0D)
m.lnOneFieldBlockSize = 32

*!* Depending on your machine speed
*!* fix next variable value (it is used 
*!* when m.tnRepairMode value is 4 or 6
m.lnTooSlowToHandle = 3000


m.lcWhatFpt = Addbs(Justpath(m.tWhatDbf))+Juststem(m.tWhatDbf)

Do Case
  Case Upper(Justext(m.tWhatDbf)) = "DBC" && "DCT"
    m.lcWhatFpt = m.lcWhatFpt + ".DCT"
  Case Upper(Justext(m.tWhatDbf)) = "DBF"
    m.lcWhatFpt = m.lcWhatFpt + ".FPT"
  Case Upper(Justext(m.tWhatDbf)) = "FRX"
    m.lcWhatFpt = m.lcWhatFpt + ".FRT"
  Case Upper(Justext(m.tWhatDbf)) = "LBX"
    m.lcWhatFpt = m.lcWhatFpt + ".LBT"
  Case Upper(Justext(m.tWhatDbf)) = "MNX"
    m.lcWhatFpt = m.lcWhatFpt + ".MNT"
  Case Upper(Justext(m.tWhatDbf)) = "PJX"
    m.lcWhatFpt = m.lcWhatFpt + ".PJT"
  Case Upper(Justext(m.tWhatDbf)) = "SCX"
    m.lcWhatFpt = m.lcWhatFpt + ".SCT"
  Case Upper(Justext(m.tWhatDbf)) = "VCX"
    m.lcWhatFpt = m.lcWhatFpt + ".VCT"
  Otherwise
    *!* User defined add your code here
Endcase

m.lcFixError = "00000000"

m.lnFileSize = Fseek(m.lnHandler, 0, 2)
Fseek(m.lnHandler, 0, 0)              && go to begining of the file

m.lcTableHeader = Fread(m.lnHandler, m.lnHeaderBlockSize)	&& first m.lnHeaderBlockSize
*!* bytes of the header

If Ferror() <> 0
  FixMessage(105, m.tWhatDbf,, tnLang)
  Return FixExit(Iif(m.tnRepairMode = 0, -10, -1 * m.tnRepairMode), m.lcTmpDbf, m.lnSelect, m.lnHandler, m.tnLang)
Endif

m.llIsMemo1 = File(m.lcWhatFpt)

Do Case
  Case Left(m.lcTableHeader, 1) = Chr(0x83) && FoxBase+. dBASE III plus
    m.llIsMemo2 = .T.
    m.tcContainer = .F.
  Case Left(m.lcTableHeader, 1) = Chr(0x8B) && dBASE IV
    m.llIsMemo2 = .T.
    m.tcContainer = .F.
  Case Left(m.lcTableHeader, 1) = Chr(0xCB) && dBASE IV SQL table files
    m.llIsMemo2 = .T.
    m.tcContainer = .F.
  Case Left(m.lcTableHeader, 1) = Chr(0xF5) && FoxPro 2.x (or ealier)
    m.llIsMemo2 = .T.
    m.tcContainer = .F.
  Case Left(m.lcTableHeader, 1) = Chr(0x30) && Visual FoxPro
    m.llIsMemo2 = (Substr(DECTOBIN(Asc(Substr(m.lcTableHeader, 29, 1))), 7, 1) = "1")
    IF !TYPE("m.tcContainer") == "C"
       m.tcContainer = ""
    ENdif   
  Otherwise
    m.llIsMemo2 = .F.
    m.tcContainer = .F.
Endcase

*!* Change next value if needed
m.lnContainerBlockSize = Iif(TYPE("m.tcContainer")=="C",263,0)

m.llIsMemo3 = .F.   && This get the real value during the field validation

*!* Define Old code page if possible
m.lcCodePage = ;
  CHR(0x01) + ;
  CHR(0x69) + ;
  CHR(0x6A) + ;
  CHR(0x02) + ;
  CHR(0x64) + ;
  CHR(0x6B) + ;
  CHR(0x67) + ;
  CHR(0x66) + ;
  CHR(0x65) + ;
  CHR(0x68) + ;
  CHR(0xC8) + ;
  CHR(0xC9) + ;
  CHR(0x03) + ;
  CHR(0xCB) + ;
  CHR(0xCA) + ;
  CHR(0x04) + ;
  CHR(0x98) + ;
  CHR(0x96) + ;
  CHR(0x97)

m.lcCodePage = ;
  IIF(Substr(m.lcTableHeader, 30, 1) $ m.lcCodePage, ;
  Substr(m.lcTableHeader, 30, 1), Chr(0))

*!*
*!* Offset to start of data LSB-MSB format, same as HEADER()
*!*	(+1 is deletion flag 2Ah if deleted and 20h if not deleted
*!*	 +2 is the actuall address where the data begins).
*!*
*!* Bytes number 9 and 10 point it! Same as HEADER().
*!*
m.lnDataStart2 = UnLSBMSB(Substr(m.lcTableHeader, 9, 2))

*!*
*!* The record length.
*!*
*!* Bytes 11 and 12 is the length of the record including (deleted flag)
*!*
m.lnRecSize2 = UnLSBMSB(Substr(m.lcTableHeader, 11, 2))

&& 1, Field name doesn't start
&& with A, B, C...Z
&& 2, Field name starts with
&& chr(0) (no name)
&& 3, Other character of the
&& field's name are not valid
&& 4, Field type is not
&& valid BCDFGILMNTY
&& 5, Field decimals size is
&& same or greater than field's length
m.lcFieldError = "00000"

* m.aDBFisGarbage = .F.

Fseek(m.lnHandler, m.lnHeaderBlockSize, 0) && go to the begining of the Field Block

Do While .T.
  *!* If everything is ok, you should
  *!* never reach the FEOF
  *!* because of exit on m.lcHeaderRecTerminator, except
  *!* if recco() = 0 or some fatal error

  m.lcFieldInfo = Fread(m.lnHandler, m.lnOneFieldBlockSize)

  If Ferror() <> 0
    FixMessage(105, m.tWhatDbf,, tnLang)
    Return FixExit(Iif(m.tnRepairMode = 0, -10, -1 * m.tnRepairMode), m.lcTmpDbf, m.lnSelect, m.lnHandler, m.tnLang)
  Endif

  If !Left(m.lcFieldInfo, 1) == m.lcHeaderRecTerminator AND !Feof(m.lnHandler)
  
    *!* Next is used whe data file is overwritten
    m.lcAllFieldInfo = m.lcAllFieldInfo + m.lcFieldInfo
  
    *!* 0Dh i.e. Header record terminator = Enter

    *!* Now we can check also if the field name and type is ok
    m.llFieldNameOk = .T.   && field name is okay checking later
    m.llFieldTypeOk = .T.   && field type is okay checking later
    m.llFieldDecOk = .T.    && field decimals is okay (if any) checking later

    If Left(m.lcFieldInfo, 10) <> "_NullFlags"

      m.lnFieldCo3 = m.lnFieldCo3 + 1  && Counting fields

      m.lnFieldLen = Asc(Substr(m.lcFieldInfo, 17, 1))
      Note: Does the Field Name Start With A, B, C...Z ?
      m.llFieldNameOk = Isalpha(Left(m.lcFieldInfo, 1))
      If !m.llFieldNameOk
        m.lcFieldError = Stuff(m.lcFieldError, 1, 1, "1")
      Endif

      Note: Rest Of the Field Name, If shorter than
      Note: 10 Is filled With Chr(0)
      m.lnI = At(Chr(0), Substr(m.lcFieldInfo, 1, 10))

      If m.lnI = 1
        m.lcFieldError = Stuff(m.lcFieldError, 2, 1, "1")
      Endif

      m.lnI = Iif(m.lnI = 0, 10, m.lnI - 1)

      Note: Are the Rest characters Of the Name alpha, digit Or _ ?
      For m.lnK = 2 To m.lnI
        m.llFieldNameOk = Iif(!(Isalpha(Substr(m.lcFieldInfo, m.lnK, 1)) Or ;
          isdigit(Substr(m.lcFieldInfo, m.lnK, 1)) Or ;
          substr(m.lcFieldInfo, m.lnK, 1) = Chr(95) ), .F., m.llFieldNameOk)
      Endfor

      If !m.llFieldNameOk
        m.lcFieldError = Stuff(m.lcFieldError, 3, 1, "1")
      Endif

      Note: Is the Field Type ok ?
      If Left(m.lcTableHeader, 1) = "0"  && vfoxpro table
        m.llFieldTypeOk = (Substr(m.lcFieldInfo, 12, 1) $ "BCDFGILMNPTY")
      Else
        m.llFieldTypeOk = (Substr(m.lcFieldInfo, 12, 1) $ "CNFDLMG")
      Endif

      If !m.llFieldTypeOk
        m.lcFieldError = Stuff(m.lcFieldError, 4, 1, "1")
      Endif

      Note: Is the Field Decimals ok ?
      IF Substr(m.lcFieldInfo, 12, 1) # "B"
        m.llFieldDecOk = (Asc(Substr(m.lcFieldInfo, 18, 1)) < m.lnFieldLen)
      ELSE
        *!* Field type is double and decimals can be large than field length
        *!* because field length is fixed 8 and decimals can be 18
        m.llFieldDecOk = .T.
      Endif  

      If !m.llFieldDecOk
        m.lcFieldError = Stuff(m.lcFieldError, 5, 1, "1")
      Endif

      *!* Now we have checked if the field name and type is ok

      *!* Now we check if the field info says "there is a memo"
      If m.llFieldTypeOk
        Note: There Is no P, Picture Field)
        m.llIsMemo3 = Iif(Substr(m.lcFieldInfo, 12, 1) $ "GM", .T., m.llIsMemo3)
      Endif
      If At("1", m.lcFieldError) > 0
        Exit  && Best repair the DBF manually!!
      Else
        m.lnRecSize3 = Iif(m.lnRecSize3 = 0, 1, 0) + m.lnRecSize3 + ;
          UnLSBMSB(Substr(m.lcFieldInfo, 17, 1))
        *!* && iif(m.lnRecSize3 = 0, 1, 0) is because otherwise
        *!* && it points the byte what is the last byte of
        *!* && the last field's name, So + 1 and now it
        *!* && points where it should point
      Endif

      *!* we can use max() function because the offset is cumulative
      m.lnRecSize4 = Max(m.lnRecSize4, UnLSBMSB(Substr(m.lcFieldInfo, 13, 2)) + ;
        M.lnFieldLen)

    Else

      m.lnNullFlagLen = UnLSBMSB(Substr(m.lcFieldInfo, 17, 1))

    ENDIF

  Else

    If !Left(m.lcFieldInfo, 1) == m.lcHeaderRecTerminator OR ;
      Occurs(m.lcHeaderRecTerminator, m.lcFieldInfo) > 1
      *!* 0Dh i.e. Header record terminator = Enter
      *!* Fatal error situation
      *!* There is info about more than one field
      *!* but the info about the last field is only partial
      *!* Not fixable
      m.lcFixError = Stuff(m.lcFixError, 3, 1, "1")
    Endif

    m.lnAllFieldBlockSize = m.lnFieldCo3 * m.lnOneFieldBlockSize
    *!* But this is still a "plain" value
    *!* Add m.lnHeaderBlockSize for the size of Header Block and
    *!* Add m.lnOneFieldBlockSize if _NullFlags "field" exist
    *!* Add LEN(m.lcHeaderRecTerminator) for the Header record terminator (0x0D)
    *!* Add m.lnContainerBlockSize If Visual FoxPro (there are
    *!* m.lnContainerBlockSize bytes reserved after header record terminator
    *!* for DBC relative path and name
    Exit
  Endif
Enddo

*!* Now checking if m.lnAllFieldBlockSize is logic

If Feof(m.lnHandler)	&& error because eof reached
  *!* before header record terminator
  Do Case
    Case m.lnFieldCo3 = 0
      *!* Fatal error situation
      *!* There is no info for any fields
      *!* Not fixable
      m.lcFixError = Stuff(m.lcFixError, 1, 1, "1")
    Case m.lnAllFieldBlockSize = 0
      *!* Fatal error situation
      *!* There is some info about first field
      *!* but the info is only partial
      *!* Not fixable
      m.lcFixError = Stuff(m.lcFixError, 2, 1, "1")
    Case (m.lnAllFieldBlockSize - 1)%32 <> 0
      *!* Fatal error situation
      *!* There is info about more than one field
      *!* but the info about the last field is only partial
      *!* Not fixable
      m.lcFixError = Stuff(m.lcFixError, 3, 1, "1")
    Case Left(m.lcTableHeader, 1) = "0"  && atc("Visual", version())>0
      *!* Not fatal error situation
      *!* Because m.lnContainerBlockSize bytes is after 0Dh and
      *!* normaly you can't reach feof()
      *!* Possible to fix, check that between 0Dh and delete flag
      *!* are m.lnContainerBlockSize bytes (00h or path and name of DBC)
      *!* if not write those.
      *!* Not fixed in this version
      m.lcFixError = Stuff(m.lcFixError, 4, 1, "1")
    Case Left(m.lcTableHeader, 1) <> "0"
      *!* Non Visual (no m.lnContainerBlockSize bytes added)

      *!* NOTE Header record terminator is also in the same block with eof

      If Len(m.lcFieldInfo) = 1 && and m.lcFieldInfo = chr(13)
        *!* This is normal situation and reccount() = 0
      Else
        *!* This is normal situation if there is less than
        *!* m.lnOneFieldBlockSize bytes of data
        *!* otherwise there is a record size / Header inconsistency error
        *!* i.e. eof mark can't be in the same block with
        *!* the header record terminator if record size > = m.lnOneFieldBlockSize
        If m.lnRecSize3 >= m.lnOneFieldBlockSize   && not ok if > = m.lnOneFieldBlockSize
          *!*
          *!*
          m.lcFixError = Stuff(m.lcFixError, 5, 1, "1")
        Endif
      Endif
    Otherwise
      *!* Admin notice only in english
*!*	      Wait Window "It should not come ever here. Press a key to debug" Timeout 3
*!*	      If Lastkey() = 65 Or Lastkey() = 97 && A or a (press a key... Heh)
*!*	        Set Step On
*!*	      Endif
  Endcase
Else
  *!* Normal situation, recco()>0
Endif

*!* real m.lnDataStart3 value (header())
m.lnDataStart3 = m.lnHeaderBlockSize + ;
  m.lnAllFieldBlockSize + ;
  SIGN(m.lnNullFlagLen) * m.lnOneFieldBlockSize + ;
  LEN(m.lcHeaderRecTerminator) + ;
  Iif(Left(m.lcTableHeader, 1) = "0", m.lnContainerBlockSize, 0)

If m.lnRecSize4 <> m.lnRecSize3
  m.lcFixError = Stuff(m.lcFixError, 6, 1, "1")
Endif

m.lnRecSize3 = m.lnRecSize3 + m.lnNullFlagLen
m.lnRecSize4 = m.lnRecSize4 + m.lnNullFlagLen

*!*
*!* Find out how many record there is.
*!*

*!* First evaluate it from the filesize and record length
m.lnRecCount1 = Int((m.lnFileSize - m.lnDataStart2) / m.lnRecSize2)

*!* Secondly evaluate it from the bytes 5-8 (returned by reccount()
m.lnRecCount2 = UnLSBMSB(Substr(m.lcTableHeader, 5, 4))

*!* Thirdly evaluate it from the actual data
m.lnRecCount3 = Int((m.lnFileSize - m.lnDataStart3) / m.lnRecSize3)
*!* This is the most correct one value

If m.lnRecCount3 <> m.lnRecCount2 Or m.lnRecCount3 <> m.lnRecCount1 ;
    or m.lnRecCount2 <> m.lnRecCount1
  m.lcFixError = Stuff(m.lcFixError, 7, 1, "1")
Endif

If Inlist(m.tnRepairMode, 0, 1, 2, 3, 4, 5, 6)
  Do Case
    Case (At("1", m.lcFixError) > 0 And At("1", m.lcFixError) < 5) Or ;
        at("1", m.lcFieldError) > 0

      Note: Not repairable
      FixMessage(106, m.tWhatDbf, "R"+m.lcFixError+" F"+m.lcFieldError, tnLang)

    Case At("1", m.lcFixError) > 5 Or ;
        m.lnDataStart2 <> m.lnDataStart3 Or ;
        m.tnRepairMode = 0
        
        && Report

      m.lcFixedContainer1 = ""

      If Type("m.tcContainer") = "C" And ;
          !Empty(m.tcContainer)
        m.lcFixedContainer1 = Padr(m.tcContainer,m.lnContainerBlockSize,Chr(0x00))
        m.lcFixedContainer2 = Strtran(m.lcFixedContainer1, Chr(0x00), "")
      Endif

      If Left(m.lcTableHeader, 1) = "0"  && Visual FoxPro

        If m.llIsMemo3
          m.lcMemoByte = Stuff(DECTOBIN(Asc(Subs(m.lcTableHeader, 29, 1))), 7, 1, "1")
        Else
          m.lcMemoByte = Stuff(DECTOBIN(Asc(Subs(m.lcTableHeader, 29, 1))), 7, 1, "0")
        Endif

        m.lcTableFixedHdr = Left(m.lcTableHeader, 1) + ;
          CHR(Val(Right(Str(Year(Date())), 2))) + ;
          CHR(Month(Date())) + ;
          CHR(Day(Date())) + ;
          ToLSBMSB(m.lnRecCount3, 4) + ;
          ToLSBMSB(m.lnDataStart3, 2) + ;
          ToLSBMSB(m.lnRecSize3, 2) + ;
          SUBSTR(m.lcTableHeader, 13, 16) + ;
          CHR(BINTODEC(m.lcMemoByte)) + ;
          M.lcCodePage + ;
          SUBSTR(m.lcTableHeader, 31, 2)

      ELSE
      
        If m.llIsMemo3
          Do Case
            Case Left(m.lcTableHeader, 1) = Chr(0x02) Or ;
                Left(m.lcTableHeader, 1) = Chr(0xFB)
              *!* FoxBase
              m.lcMemoByte = Chr(0xFB)
            Case Left(m.lcTableHeader, 1) = Chr(0x03)
              *!* "FoxBASE+/dBASE III PLUS, FoxPro, dBaseIV, no memo"
              m.lcMemoByte = Chr(0xF5) && FoxPro2x
            Case Left(m.lcTableHeader, 1) = Chr(0x43)
              *!* "dBASE IV SQL table files, no memo"
              m.lcMemoByte = Chr(0xCB)
            Case Left(m.lcTableHeader, 1) = Chr(0x83)
              *!* "FoxBASE+/dBASE III PLUS, with memo"
              m.lcMemoByte = Chr(0x83)
            Case Left(m.lcTableHeader, 1) = Chr(0x8B)
              *!* "dBASE IV with memo"
              m.lcMemoByte = Chr(0x8B)
            Case Left(m.lcTableHeader, 1) = Chr(0xF5)
              *!* "FoxPro 2.x (or earlier) with memo"
              m.lcMemoByte = Chr(0xF5)
            Case Left(m.lcTableHeader, 1) = Chr(0x63)
              *!* "dBASE IV SQL system files, no memo"
              *!* Don't know ??
              *!* This is a quess
              *!* m.lcMemoByte = Chr(0xEB) ??
              m.lcMemoByte = Chr(0xCB)
            Otherwise
              *!* "dBASE IV with memo" the newest one
              m.lcMemoByte = Chr(0x8B)
          Endcase
        Else
          m.lcMemoByte = Chr(0x03)
        Endif

        m.lcTableFixedHdr = m.lcMemoByte + ;
          CHR(Val(Right(Str(Year(Date())), 2))) + ;
          CHR(Month(Date())) + ;
          Chr(Day(Date())) + ;
          ToLSBMSB(m.lnRecCount3, 4) + ;
          ToLSBMSB(m.lnDataStart3, 2) + ;
          ToLSBMSB(m.lnRecSize3, 2) + ;
          SUBSTR(m.lcTableHeader, 13, 17) + ;
          M.lcCodePage + ;
          SUBSTR(m.lcTableHeader, 31, 2)

      Endif

      If Type("m.tcContainer") = "C"

        *!* Go to the right position to read original container block
        Fseek(m.lnHandler, ;
          M.lnHeaderBlockSize + ;
          M.lnAllFieldBlockSize + ;
          SIGN(m.lnNullFlagLen) * m.lnOneFieldBlockSize + ;
          LEN(m.lcHeaderRecTerminator), 0)

        m.lcTableContainer1 = Fread(m.lnHandler, ;
          M.lnContainerBlockSize) && Actual container block

        m.lcTableContainer2 = Strtran(m.lcTableContainer1, Chr(0x00), "")

        If Ferror()<>0 And m.tnRepairMode # 0
          FixMessage(105, m.tWhatDbf,, tnLang)
          Return FixExit(Iif(m.tnRepairMode = 0, -10, -1 * m.tnRepairMode), m.lcTmpDbf, m.lnSelect, m.lnHandler, m.tnLang)
        Endif

      Endif

      Do Case

        Case Inlist(m.tnRepairMode, 1, 3)             && Table
          Fseek(m.lnHandler, 0, 0)                  && go to begining of the file
          Fwrite(m.lnHandler, m.lcTableFixedHdr)    && write new header to the table

          If Ferror()<>0
            FixMessage(105, m.tWhatDbf,, tnLang)
            Return FixExit(Iif(m.tnRepairMode = 0, -10, -1 * m.tnRepairMode), m.lcTmpDbf, m.lnSelect, m.lnHandler, m.tnLang)
          Endif

          If Type("m.tcContainer") = "C" And !Empty(m.lcFixedContainer1)
            *!* GO to the Header record terminator

            *!* Go to the right position to write fixed container block
            Fseek(m.lnHandler, ;
              M.lnHeaderBlockSize + ;
              M.lnAllFieldBlockSize + ;
              SIGN(m.lnNullFlagLen) * m.lnOneFieldBlockSize, 0)

            Fwrite(m.lnHandler, m.lcHeaderRecTerminator + m.lcFixedContainer1)    && Write new container info

            If Ferror()<>0
              FixMessage(105, m.tWhatDbf,, tnLang)
              Return FixExit(Iif(m.tnRepairMode = 0, -10, -1 * m.tnRepairMode), m.lcTmpDbf, m.lnSelect, m.lnHandler, m.tnLang)
            Endif

          ENDIF
          m.llTableRepaired = .T.


        Case Inlist(m.tnRepairMode, 4, 6) && Whole data file is overwritten
        
          *!* This works but for the next version
          *!* add input / template for field block if
          *!* it is corrupted
        
          LOCAL ;
            lcTotalHeader, ;
            lcRecordData, ;
            lnRecCounter, ;
            lnProceed

          *!* Save Header info to the memo file
          m.lcTotalHeader = ;
            m.lcTableFixedHdr + ;
            m.lcAllFieldInfo + ;
            m.lcHeaderRecTerminator

          Do Case
            Case !Empty(m.lcFixedContainer1)
              m.lcTotalHeader = m.lcTotalHeader + m.lcFixedContainer1
            Case !Empty(m.lcTableContainer1)
              m.lcTotalHeader = m.lcTotalHeader + m.lcTableContainer1
          Endcase

          Replace ATFIX With m.lcTotalHeader IN (JUSTSTEM(m.lcTmpDbf))

          *!* Fetch all data and append it to the memo file
          Fseek(m.lnHandler, ;
            m.lnHeaderBlockSize + ;
            m.lnAllFieldBlockSize + ;
            SIGN(m.lnNullFlagLen) * m.lnOneFieldBlockSize + ;
            LEN(m.lcHeaderRecTerminator) + ;
            m.lnContainerBlockSize, 0)

          *!* Now the pointer is in the beginning of data
          
          
          IF !FEOF(m.lnHandler)
            
            m.lnRecCounter = 1
            
            SET ESCAPE ON
            
            m.lnProceed = 600
            
            IF m.lnRecCount3 > m.lnTooSlowToHandle
              m.lnProceed = FixMessage(108, m.lnRecCount3, m.tnRepairMode, tnLang) * 100
            Endif  
              
            IF m.lnProceed = 600 OR m.lnProceed = -100
                        
              DO WHILE .T.
  
                m.lcRecordData = Fread(m.lnHandler, m.lnRecSize3)
                If Ferror()<>0
                  FixMessage(105, m.tWhatDbf,, tnLang)
                  Return FixExit(Iif(m.tnRepairMode = 0, -10, -1 * m.tnRepairMode), m.lcTmpDbf, m.lnSelect, m.lnHandler, m.tnLang)
                ENDIF
              
                FixMessage(109, m.lnRecCounter, m.lnRecCount3, tnLang)
                Replace ATFIX With ATFIX + m.lcRecordData IN (JUSTSTEM(m.lcTmpDbf))
            
                IF FEOF(m.lnHandler)
                  EXIT
                ENDIF
              
                m.lnRecCounter = m.lnRecCounter  + 1
              
              ENDDO
            ELSE
              Return FixExit(m.lnProceed, m.lcTmpDbf, m.lnSelect, m.lnHandler, m.tnLang)
            ENDIF  
          Endif  
          *!* Now memo file ATFIX contains m.tWhatDbf in binary format
          Fclose(m.lnHandler)
          m.lcSafety = Set("SAFETY")
          Set Safety Off
          Copy Memo ATFIX To (m.tWhatDbf)
          Set Safety &lcSafety
          m.llTableRepaired = .T.

      ENDCASE
      
    Otherwise
      Note: Data File Is ok
      m.llTableIsAlreadyOK = .T.
      m.lcTableFixedHdr = m.lcTableHeader
  Endcase

Else

  *!* m.tnRepairMode > 3
  *!* Not supported yet

Endif

Fclose(m.lnHandler)                && Close DBF pointed by m.lnHandler

*!* Now We check the FPT file

If m.llIsMemo3
  If !m.llIsMemo1
    *!* no fpt file but there is a memo field
    *!* Error 41 but in this case Memo file is missing
    *!* So create it!!!

    Local ;
      lcTmpTable, ;
      lnTmpSele, ;
      cMyTEMPDir
      
    m.lnTmpSele = Select()      

    Select 0

    m.cMyTEMPDir = ;
      IIF(Len(Getenv('TEMP'))=0,Sys(5)+Curdir()+;
      IIF(!Right(Curdir(),1)=='\','\',''),;
      Getenv('TEMP')+Iif(!Right(Getenv('TEMP'),1)=='\','\',''))

    m.lcTmpTable = m.cMyTEMPDir + Sys(2015)

    Do While File(m.lcTmpTable+".DBF") Or File(m.lcTmpTable+".FPT")
      m.lcTmpTable = m.cMyTEMPDir + Sys(2015)
    Enddo

    Select 0
    Create Table (m.lcTmpTable) (temp M)
    Use

    Copy File (m.lcTmpTable+".FPT") To ;
      (m.lcWhatFpt)

    Erase (m.cTmpTable+".FPT")
    Erase (m.cTmpTable+".DBF")

  Else

    *!* all other cases (memo header coud be corrupted)
    *!* or memo indicator in DBF Header Block is invalid
    *!* So correct the header and possibly write memo
    *!* indicator into the DBF Header Block
    *!* note!! DBF header is fixed already

    If !m.tlNoBackups And m.tnRepairMode # 0  && data file backed

      *!* && DataFixBacked = EXT00
      If File(m.lcBackFile)
        For m.lnI = 1 To 99
          m.lcBackFile = m.lcWhatFpt + Padl(Transform(m.lnI),2,"0")

          *!* && DataFixBacked = EXTnn, nn = 01-99
          If !File(m.lcBackFile)
            Exit
          Else
            If m.lnI = 99 And File(m.lcBackFile)
              Erase (m.lcBackFile)
              Exit
            Endif
          Endif
        Endfor
      Endif

      Wait Clear

      Note: making FPT backup
      FixMessage(102, m.lcWhatFpt, m.lcBackFile, tnLang)

      Copy File (m.lcWhatFpt) To (m.lcBackFile)

      Wait Clear

      Note: FPT backup ok

      Note: backup ok
      FixMessage(103, m.lcBackFile,, tnLang)

    Endif

    m.lnHandler = Fopen(m.lcWhatFpt, 12)    && unbuffered

    If m.lnHandler < 0                    && Error generated creating file
      FixMessage(104+Val(Set("POINT")+Alltrim(Str(Ferror()))),m.lcWhatFpt,, tnLang)
      Return FixExit(Iif(m.tnRepairMode = 0, -10, -1 * m.tnRepairMode), m.lcTmpDbf, m.lnSelect, m.lnHandler, m.tnLang)
    Endif

    Note: Now the FPT-fix starts

    *!* Memo files contain one header record and any number of
    *!* block structures. The header record contains a pointer
    *!* to the next free block and the size of the block in bytes.
    *!* The size is determined by the SET BLOCKSIZE command when
    *!* the file is created. The header record starts at file
    *!* position zero and occupies 512 bytes. The SET BLOCKSIZE TO 0
    *!* command sets the block size width to 1.

    *!* Following the header record are the blocks that contain a
    *!* block header and the text of the memo. The table file contains
    *!* block numbers that are used to reference the memo blocks.
    *!* The position of the block in the memo file is determined by
    *!* multiplying the block number by the block size (found in the
    *!* memo file header record). All memo blocks start at even block
    *!* boundary addresses. A memo block can occupy more than one
    *!* consecutive block.

    *!* Memo Header Record

    *!* Byte offset Description
    *!* 00 – 03 Location of next free block 1)
    *!* 04 – 05 Unused
    *!* 06 – 07 Block size (bytes per block) 1)
    *!* 08 – 511 Unused

    *!* 1) Integers stored with the most significant byte first.

    *!* --------------------

    *!* Memo Block Header and Memo Text

    *!* Byte offset Description
    *!* 00 – 03 Block signature (indicates the type of data in the block) 1)
    *!* 0 – picture (picture field type)
    *!* 1 – text (memo field type)
    *!* 04 – 07 Length (n) memo (in bytes) 1)
    *!* 08 – n Memo text (n = length)

    *!* 1) Integers stored with the most significant byte first.

    Local ;
      lcFptHeader, ;
      lnFptSize, ;
      lnFptBlockSize, ;
      lnFptNFB

    *!* m.lcFptHeader    First 8 bytes of the file
    *!* m.lnFptSize      Size of the file
    *!* m.lnFptNFB       Address of next free memo block

    m.lcFptHeader = Fread(m.lnHandler, 8)  && first 8 bytes of the header

    If Ferror()<>0
      FixMessage(105, m.lcWhatFpt,, tnLang)
      Return FixExit(Iif(m.tnRepairMode = 0, -10, -1 * m.tnRepairMode), m.lcTmpDbf, m.lnSelect, m.lnHandler, m.tnLang)
    Endif

    *!* Fpt i.e all memo file types
    m.lnFptSize = Fseek(m.lnHandler, 0, 2)
    m.lnFptNFB = UnMSBLSB(Subs(m.lcFptHeader, 1, 4))
    m.lnFptBlockSize = UnMSBLSB(Subs(m.lcFptHeader, 7, 2))

    Note: ask Or Calculate Blocksize (Not In This Version)
    If m.lnFptNFB <> Int(m.lnFptSize / m.lnFptBlockSize)
      *  && Next free address is not the same as calculated
      *  && maybe the default blocksize is incorrect ???
      *  local lcTmpWin2
      *  m.lcTmpWin2 = sys(3)
      *  define window m.cTmpWin2 at 5, 3 size 9, 30 ;
      *         title " FPT Datayksikön koko ??? " double shadow
      *
      *  acti window m.lcTmpWin2
      *
      *  do while .t.
      *    note: gimme ok blocksize
      *  enddo
      m.lnFptBlockSize = m.tnMemoBlockSice
    Endif

    Do Case
      Case m.lnFptBlockSize = 0
        m.lnFptBlockSize = 1
      Case m.lnFptBlockSize = 33
        m.lnFptBlockSize = 512 * m.lnFptBlockSize
      Otherwise
        m.lnFptBlockSize = m.lnFptBlockSize
    Endcase

    *!* This is a same than above
    *!* m.nFptGetBSize = IIF(m.nFptGetBSize<33, ;
    *!* IIF(m.nFptGetBSize = 0, 1, m.nFptGetBSize*512), m.nFptGetBSize)

    m.lcFptFixedHdr = ToMSBLSB(Int(m.lnFptSize / m.lnFptBlockSize), 4) + ;
      chr(0) + Chr(0) + ToMSBLSB(m.lnFptBlockSize, 2)

    If Inlist(m.tnRepairMode, 0, 2, 3, 5, 6) AND ;
      !m.lcFptHeader == m.lcFptFixedHdr

      If Inlist(m.tnRepairMode, 2, 3, 5, 6) && 0 = Also memo
        Fseek(m.lnHandler, 0, 0)             && go to begining of the file
        Fwrite(m.lnHandler, m.lcFptFixedHdr)

        If Ferror()<>0
          FixMessage(105, m.lcWhatFpt,, tnLang)
          Return FixExit(Iif(m.tnRepairMode = 0, -10, -1 * m.tnRepairMode), m.lcTmpDbf, m.lnSelect, m.lnHandler, m.tnLang)
        Endif
      ENDIF
      m.llMemoRepaired = .T.
    Else

      *!* m.tnRepairMode > 3
      *!* Not supported yet

    Endif
  Endif

  Fclose(m.lnHandler)                && Close FPT pointed by m.lnHandler

Endif  && Memo field exist m.llIsMemo3 = .T.

*!* Report file generation

Local ;
  lcTmpWin1, ;
  lcFileOrigin, ;
  llChr7Exist, ;
  lcInfo, ;
  lcInfoFile, ;
  lcNot1, ;
  lcNot2, ;
  lcLineFeed
  
m.lcInfo = ""
m.lcNot1 = ""  && or "not"
m.lcNot2 = ""  && or "not"
m.lcLineFeed = Chr(13) + Chr(10)

Do Case
  Case Left(m.lcTableHeader, 1) = Chr(0x02)
    m.lcFileOrigin = "FoxBASE"
  Case Left(m.lcTableHeader, 1) = Chr(0x03)
    m.lcFileOrigin = "FoxBASE+ / dBASE III PLUS, FoxPro, dBaseIV, no memo"
  Case Left(m.lcTableHeader, 1) = Chr(0x30)
    m.lcFileOrigin = "Visual FoxPro"
  Case Left(m.lcTableHeader, 1) = Chr(0x43)
    m.lcFileOrigin = "dBASE IV SQL table files, no memo"
  Case Left(m.lcTableHeader, 1) = Chr(0x63)
    m.lcFileOrigin = "dBASE IV SQL system files, no memo"
  Case Left(m.lcTableHeader, 1) = Chr(0x83)
    m.lcFileOrigin = "FoxBASE+ / dBASE III PLUS, with memo"
  Case Left(m.lcTableHeader, 1) = Chr(0x8B)
    m.lcFileOrigin = "dBASE IV with memo"
  Case Left(m.lcTableHeader, 1) = Chr(0xCB)
    m.lcFileOrigin = "dBASE IV SQL table files, with memo"
  Case Left(m.lcTableHeader, 1) = Chr(0xF5)
    m.lcFileOrigin = "FoxPro 2.x (or earlier) with memo"
  Case Left(m.lcTableHeader, 1) = Chr(0xFB)
    m.lcFileOrigin = "FoxBASE with memo"
Endcase

If !Empty(m.lcTableContainer2)
  m.lcInfo = m.lcInfo + m.lcFileOrigin + " file: " + ;
    JUSTFNAME(m.lcTableContainer2) + "!" + Justfname(m.tWhatDbf)
Else
  m.lcInfo = m.lcInfo + m.lcFileOrigin + " file: " + Justfname(m.tWhatDbf)
ENDIF
IF LEN(m.lcInfo) < 45
  m.lcInfo = m.lcInfo + " | Size "+;
    allt(Str(m.lnFileSize, 10, 0)) + " Bytes.   " + m.lcLineFeed + m.lcLineFeed
ELSE
  m.lcInfo = m.lcInfo + m.lcLineFeed + "Size "+;
    allt(Str(m.lnFileSize, 10, 0)) + " Bytes.   " + m.lcLineFeed + m.lcLineFeed
Endif    

m.lcInfo = m.lcInfo + "From          Data Start, Total RecSize,  Reccount, FieldCount" + m.lcLineFeed
m.lcInfo = m.lcInfo + "Filesize" + Space(32) + Str(m.lnRecCount1, 10, 0) + m.lcLineFeed
m.lcInfo = m.lcInfo + "Header Block  " + Str(m.lnDataStart2, 10, 0) + ;
  SPACE(5) + Str(m.lnRecSize2, 10, 0) + " " + ;
  str(m.lnRecCount2, 10, 0) + m.lcLineFeed
m.lcInfo = m.lcInfo + "Data Block    " + Str(m.lnDataStart3, 10, 0) + ;
  SPACE(5) + Str(m.lnRecSize3, 10, 0) + " " + ;
  str(m.lnRecCount3, 10, 0) + "  " + ;
  Str(m.lnFieldCo3, 10, 0) + m.lcLineFeed
m.lcInfo = m.lcInfo + "Data offset" + Space(18) + Str(m.lnRecSize4, 10, 0) + m.lcLineFeed
m.lcInfo = m.lcInfo + m.lcLineFeed
If Substr(m.lcFixError, 1, 1) = "1"
  m.lcInfo = m.lcInfo + "- There isn't Any Info For Fields" + m.lcLineFeed
Else
  m.lcInfo = m.lcInfo + "- Field info Ok" + m.lcLineFeed
Endif
If Substr(m.lcFixError, 2, 1) = "1"
  m.lcInfo = m.lcInfo + "- There is some info about first field" + m.lcLineFeed
  m.lcInfo = m.lcInfo + "  but the info is only partial" + m.lcLineFeed
Else
  m.lcInfo = m.lcInfo + "- First field info Ok" + m.lcLineFeed
Endif
If Substr(m.lcFixError, 3, 1) = "1"
  m.lcInfo = m.lcInfo + "- There is info about more than one field but" + m.lcLineFeed
  m.lcInfo = m.lcInfo + "  the info about the last field is only partial" + m.lcLineFeed
Else
  m.lcInfo = m.lcInfo + "- There are more than one field and the last field info is Ok" + m.lcLineFeed
Endif
If Substr(m.lcFixError, 4, 1) = "1"
  m.lcInfo = m.lcInfo + "- " + Transform(m.lnContainerBlockSize) + ;
    " bytes for container info are missing" + m.lcLineFeed
Else
  If Left(m.lcTableHeader, 1) = "0"
    m.lcInfo = m.lcInfo + "- Space for DBC info Ok" + m.lcLineFeed
  Else
    * ?"Reserved for the Visual FoxPro"
  Endif
Endif
If Substr(m.lcFixError, 5, 1) = "1"
  m.lcInfo = m.lcInfo + "- Record size from the field info is more than " + ;
    Transform(m.lnOneFieldBlockSize) + m.lcLineFeed
Else
  * ?"5 Ok"
Endif
If Substr(m.lcFixError, 6, 1) = "1"
  m.lcInfo = m.lcInfo + "- Record size from the field info and offset differs" + m.lcLineFeed
Else
  m.lcInfo = m.lcInfo + "- Record size from the field info and offset are Ok" + m.lcLineFeed
Endif
If Substr(m.lcFixError, 7, 1) = "1"
  m.lcInfo = m.lcInfo + "- Record count differs" + m.lcLineFeed
Else
  m.lcInfo = m.lcInfo + "- Record count from file size, header and actual data are same (Ok)" + m.lcLineFeed
Endif
If Substr(m.lcFixError, 8, 1) = "1"
  *?"Error 8"
Else
  *?"8 Ok"
Endif
m.lcInfo = m.lcInfo + m.lcLineFeed
m.lcInfo = m.lcInfo + "- First letter of the field's Name, Rest Of the Name, Type, Length" + m.lcLineFeed
m.lcInfo = m.lcInfo + "  Ok?"+Space(26)+Iif(Subs(m.lcFieldError, 1, 1) = "1" Or ;
  SUBS(m.lcFieldError, 2, 1) = "1", " No", "Yes")+;
  SPACE(15)+Iif(Subs(m.lcFieldError, 3, 1) = "1", " No", "Yes")+;
  SPACE(3)+Iif(Subs(m.lcFieldError, 4, 1) = "1", " No", "Yes")+;
  SPACE(5)+Iif(Subs(m.lcFieldError, 5, 1) = "1", " No", "Yes") + m.lcLineFeed

If At("1", m.lcFieldError)>0
  m.lcInfo = m.lcInfo + m.lcLineFeed
  m.lcInfo = m.lcInfo + "- Because of the error in field, no automatic fix can be done" + m.lcLineFeed
Endif

*!* Next TABLE HEADERS
m.lcInfo = m.lcInfo + m.lcLineFeed
m.lcInfo = m.lcInfo + "Table 0riginal Hdr.....:"

** NOTE NOTE NOTE **
*!* CHR(7) is shown OK with Font "Terminal"
*!* If you trouble with CHR(7), uncomment all **CHR(7)** lines
*!* AND COMMENT ALL && **CHR(7) OK** lines

**CHR(7)** For m.lnI = 1 To Len(m.lcTableHeader)						&& **CHR(7)**
**CHR(7)**   If Substr(m.lcTableHeader,m.lnI,1) = Chr(7)				&& **CHR(7)**
**CHR(7)**     m.lcInfo = m.lcInfo + "7"								&& **CHR(7)**
**CHR(7)**     m.llChr7Exist = .T.										&& **CHR(7)**
**CHR(7)**   Else														&& **CHR(7)**
**CHR(7)**     m.lcInfo = m.lcInfo + Substr(m.lcTableHeader,m.lnI,1)	&& **CHR(7)**
**CHR(7)**   Endif														&& **CHR(7)**
**CHR(7)** Endfor														&& **CHR(7)**

m.lcInfo = m.lcInfo + m.lcTableHeader									&& **CHR(7) OK**

m.lcInfo = m.lcInfo + m.lcLineFeed

m.lcInfo = m.lcInfo + "Table Fixed Hdr........:"
**CHR(7)** For m.lnI = 1 To Len(m.lcTableFixedHdr)						&& **CHR(7)**
**CHR(7)**   If Substr(m.lcTableFixedHdr,m.lnI,1) = Chr(7)				&& **CHR(7)**
**CHR(7)**     m.lcInfo = m.lcInfo + "7"								&& **CHR(7)**
**CHR(7)**     m.llChr7Exist = .T.										&& **CHR(7)**
**CHR(7)**   Else														&& **CHR(7)**
**CHR(7)**     m.lcInfo = m.lcInfo + Substr(m.lcTableFixedHdr,m.lnI,1)	&& **CHR(7)**
**CHR(7)**   Endif														&& **CHR(7)**
**CHR(7)** Endfor														&& **CHR(7)**

m.lcInfo = m.lcInfo + m.lcTableFixedHdr									&& **CHR(7) OK**

m.lcInfo = m.lcInfo + m.lcLineFeed

*!* Next Fixed container
If !Empty(m.lcFixedContainer2)

  m.lcInfo = m.lcInfo + "- Original container    "
  For m.lnI = 1 To Len(m.lcTableContainer2)
    If Substr(m.lcTableContainer2,m.lnI,1) = Chr(7)
      m.lcInfo = m.lcInfo + "7"
      m.llChr7Exist = .T.
    Else
      m.lcInfo = m.lcInfo + Substr(m.lcTableContainer2,m.lnI,1)
    Endif
  Endfor
  m.lcInfo = m.lcInfo + m.lcLineFeed
  m.lcInfo = m.lcInfo + "- New container         "
  For m.lnI = 1 To Len(m.lcFixedContainer2)
    If Substr(m.lcFixedContainer2,m.lnI,1) = Chr(7)
      m.lcInfo = m.lcInfo + "7"
      m.llChr7Exist = .T.
    Else
      m.lcInfo = m.lcInfo + Substr(m.lcFixedContainer2,m.lnI,1)
    Endif
  Endfor
  m.lcInfo = m.lcInfo + m.lcLineFeed

Endif

* IF m.llChr7Exist
*   m.lcInfo = m.lcInfo + "Note "
*   m.lcInfo = m.lcInfo + "7"
*   m.lcInfo = m.lcInfo + " is CHR(7)               "
* ENDIF

m.lcInfo = m.lcInfo + m.lcLineFeed

m.lcInfo = m.lcInfo + "- FPT file, Memo flag, Memo field"
If m.llIsMemo1 Or m.llIsMemo3
  m.lcInfo = m.lcInfo + ", Size (Now), Size (True), Block size" + m.lcLineFeed
Endif
m.lcInfo = m.lcInfo + Space(7) + Iif(m.llIsMemo1, "Yes", " No") + ;
  SPACE(8) + Iif(m.llIsMemo2, "Yes", " No") + ;
  SPACE(9) + Iif(m.llIsMemo3, "Yes", " No")

If m.llIsMemo1 Or m.llIsMemo3
  Local ;
    laMemoFileInfo[1], ;
    lnMemoFileSize1, ;
    lnMemoFileSize2

  Do Case
    Case m.llIsMemo1 And m.llIsMemo3
      Adir(laMemoFileInfo, m.lcWhatFpt)
      m.lnMemoFileSize1 = Iif(Type("m.laMemoFileInfo[1,2]") = "N", ;
        M.laMemoFileInfo[1,2], "Undefined")
      m.lnMemoFileSize2 = m.lnFptSize
      m.lcInfo = m.lcInfo + "  "+Padl(Transform(m.lnMemoFileSize1), 10, " ") + ;
        "   " + Padl(Transform(m.lnMemoFileSize2), 10, " ")
    Case m.llIsMemo1 And !m.llIsMemo3
      Adir(laMemoFileInfo, m.lcWhatFpt)
      m.lnMemoFileSize1 = Iif(Type("m.laMemoFileInfo[1,2]") = "N", m.laMemoFileInfo[1,2], "Undefined")
      m.lnMemoFileSize2 = 0
      m.lcInfo = m.lcInfo + "  "+Padl(Transform(m.lnMemoFileSize1), 10, " ") + ;
        "   " + Padl(Transform(m.lnMemoFileSize2), 10, " ")
    Case !m.llIsMemo1 And m.llIsMemo3
      m.lnMemoFileSize1 = 0
      m.lnMemoFileSize2 = "Undefined"
      m.lcInfo = m.lcInfo + "  "+Padl(Transform(m.lnMemoFileSize1), 10, " ") + ;
        "   " + Padl(m.lnMemoFileSize1, 10, " ")
  Endcase

  m.lcInfo = m.lcInfo + Padl(Transform(m.lnFptBlockSize), 12, " ") + m.lcLineFeed

  *!* Next MEMO HEADERS
  m.lcInfo = m.lcInfo + m.lcLineFeed
  m.lcInfo = m.lcInfo + "Memo 0riginal Hdr......:"

  ** NOTE NOTE NOTE **
  *!* CHR(7) is shown OK with Font "Terminal"
  *!* If you trouble with CHR(7), uncomment all **CHR(7)** lines
  *!* AND COMMENT ALL && **CHR(7) OK** lines

  **CHR(7)** For m.lnI = 1 To Len(m.lcFptHeader)						 && **CHR(7)**
  **CHR(7)**   If Substr(m.lcFptHeader,m.lnI,1) = Chr(7)				 && **CHR(7)**
  **CHR(7)**     m.lcInfo = m.lcInfo + "7"							 && **CHR(7)**
  **CHR(7)**     m.llChr7Exist = .T.									 && **CHR(7)**
  **CHR(7)**   Else													 && **CHR(7)**
  **CHR(7)**     m.lcInfo = m.lcInfo + Substr(m.lcFptHeader,m.lnI,1)	 && **CHR(7)**
  **CHR(7)**   Endif													 && **CHR(7)**
  **CHR(7)** Endfor													 && **CHR(7)**

  m.lcInfo = m.lcInfo + m.lcFptHeader									 && **CHR(7) OK**

  m.lcInfo = m.lcInfo + m.lcLineFeed

  m.lcInfo = m.lcInfo + "Memo Fixed Hdr.........:"
  **CHR(7)** For m.lnI = 1 To Len(m.lcFptFixedHdr)					 && **CHR(7)**
  **CHR(7)**   If Substr(m.lcFptFixedHdr,m.lnI,1) = Chr(7)			 && **CHR(7)**
  **CHR(7)**     m.lcInfo = m.lcInfo + "7"							 && **CHR(7)**
  **CHR(7)**     m.llChr7Exist = .T.									 && **CHR(7)**
  **CHR(7)**   Else													 && **CHR(7)**
  **CHR(7)**     m.lcInfo = m.lcInfo + Substr(m.lcFptFixedHdr,m.lnI,1) && **CHR(7)**
  **CHR(7)**   Endif													 && **CHR(7)**
  **CHR(7)** Endfor													 && **CHR(7)**

  m.lcInfo = m.lcInfo + m.lcFptFixedHdr								 && **CHR(7) OK**

  **CHR(7)** m.lcInfo = m.lcInfo + m.lcLineFeed + m.lcLineFeed		 && **CHR(7)**

  **CHR(7)** If m.llChr7Exist											 && **CHR(7)**
  **CHR(7)**   m.lcInfo = m.lcInfo + "*) Note "						 && **CHR(7)**
  **CHR(7)**   m.lcInfo = m.lcInfo + "7"								 && **CHR(7)**
  **CHR(7)**   m.lcInfo = m.lcInfo + " is CHR(7) "					 && **CHR(7)**
  **CHR(7)** ENDIF													 && **CHR(7)**

*   m.lcInfo = m.lcInfo + m.lcLineFeed + m.lcLineFeed

* ELSE
  
* m.lcInfo = m.lcInfo + m.lcLineFeed + m.lcLineFeed

Endif

m.lcInfo = m.lcInfo + m.lcLineFeed + m.lcLineFeed

*!* Results
m.lcInfo = m.lcInfo + "RESULTS (Repair mode " + Transform(m.tnRepairMode) + "):" + m.lcLineFeed

*!* For a table
m.lcInfo = m.lcInfo + "- " + Justfname(m.tWhatDbf) + " is"

If Substr(m.lcTableHeader, 5, 25) == Substr(m.lcTableFixedHdr, 5, 25) And ;
    (m.lcTableContainer1 == m.lcFixedContainer1 Or Empty(m.lcFixedContainer1))
  m.lcInfo = m.lcInfo + " not"
Endif

m.lcInfo = m.lcInfo + " corrupted and" + ;
  IIF(!m.llTableRepaired, ;
  " NOT", "") + " REPAIRED!"

m.lcInfo = m.lcInfo + m.lcLineFeed

*!* For a memo
If m.llIsMemo1 Or m.llIsMemo3
  m.lcInfo = m.lcInfo + "- " + Justfname(m.lcWhatFpt) + " is"
  If m.lcFptHeader == m.lcFptFixedHdr And ;
      M.lnMemoFileSize1 == m.lnMemoFileSize2
    m.lcInfo = m.lcInfo + " not"
  Endif
  m.lcInfo = m.lcInfo + " corrupted and" + ;
    IIF(!m.llMemoRepaired, ;
    " NOT", "") + " REPAIRED!"
Endif

m.lcInfo = m.lcInfo + m.lcLineFeed
m.lcInfo = m.lcInfo + "- " + Iif(!m.tlNoBackups And m.tnRepairMode = 0,"", "No ") + "Backups done."

m.lcInfo = m.lcInfo + m.lcLineFeed + m.lcLineFeed
m.lcInfo = m.lcInfo + "(c) 2001 Arto Toikka"

m.lcInfoFile = Addbs(Justpath(m.tWhatDbf)) + "ATFix_" + Juststem(m.tWhatDbf) + ".TXT"


m.lcSafety = Set("SAFETY")
Set Safety Off

#If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
  *!* VFP 7
*!*	  Strtofile(m.lcInfo, m.lcInfoFile, 0)
#Else
  Replace ATFIX With m.lcInfo In (JUSTSTEM(m.lcTmpDbf))
*!*	  Copy Memo ATFIX To (m.lcInfoFile)
#Endif

Set Safety &lcSafety

If !m.tlNoInfo  && Show info window

*!*	  m.lcTmpWin1 = "A"+Sys(3)  && plain sys(3) doesn't work define window

*!*	  Define Window (m.lcTmpWin1) At 1, 3 Size 35, 78 ;
*!*	    IN Desktop Font "Terminal", 10 Title " Statistics for the " + Allt(m.tWhatDbf) ;
*!*	    SYSTEM Close Float Grow Minimize Zoom

*!*	  Modify Command (m.lcInfoFile) Window (m.lcTmpWin1)

*!*	  Release Wind (m.lcTmpWin1)

Endif

*!*!*!* Uncomment next line if report file is not needed
*!*!*!* ERASE (m.lcInfoFile)

Return FixExit(m.tnRepairMode, m.lcTmpDbf, m.lnSelect, m.lnHandler, m.tnLang)

*!*
*!* End of function FIXDBF
*!*

*!**!**!**!**!**!**!**!**!**!*
*!*                        *!*
*!* Function UnLSBMSB      *!*
*!*                        *!*
*!**!**!**!**!**!**!**!**!**!*

Function UnLSBMSB

*!**!**!**!**!**!**!**!**!**!*

*!*	Example
*!* m.cSomeBytes = "¦¥ÃÓ"  && ascii characters from 0 to 255
*!*
*!* m.nSolved = ASC(SUBSTR(m.cSomeBytes, 1, 1))+;
*!*           ASC(SUBSTR(m.cSomeBytes, 2, 1))*256+;
*!*           ASC(SUBSTR(m.cSomeBytes, 3, 1))*256*256+;
*!*           ASC(SUBSTR(m.cSomeBytes, 4, 1))*256*256*256;
*!* OR
*!* m.nSolved = ASC("¦")+ASC("¥")*256+;
*!*           ASC("Ã")*256*256+ASC("Ó")*256*256*256;
*!*

Lparameters tcSomeBytes

Local ;
  lnRetVal, ;
  lnI

m.lnRetVal = 0

*!* for m.i = 1 to len(tcSomeBytes)
*!*   m.nSolved = m.nSolved+asc(substr(tcSomeBytes, i, 1))*(256^(i-1))
*!* endfor

*!* OR maybe the quicker one

For m.lnI = Len(tcSomeBytes) To 1 Step -1
  m.lnRetVal = m.lnRetVal*256+Asc(Substr(tcSomeBytes, m.lnI, 1))
Endfor

Return m.lnRetVal

*!*
*!* End of function UnLSBMSB
*!*

*!**!**!**!**!**!**!**!**!**!*
*!*                        *!*
*!* Function ToLSBMSB      *!*
*!*                        *!*
*!**!**!**!**!**!**!**!**!**!*

Function ToLSBMSB

*!**!**!**!**!**!**!**!**!**!*

Lparameters tnSomeNum, tnCount

Local ;
  lcRetVal, ;
  lnI

m.lcRetVal = ""

If Type("m.tnCount")<>"N"
  m.tnCount = 1
Else
  m.tnCount = Int(m.tnCount)
Endif

For m.lnI = 1 To m.tnCount
  m.lcRetVal = m.lcRetVal+Chr(Mod(m.tnSomeNum, 256))
  m.tnSomeNum = Int(m.tnSomeNum/256)
Endfor

Return m.lcRetVal

*!*
*!* End of function ToLSBMSB
*!*


*!**!**!**!**!**!**!**!**!**!*
*!*                        *!*
*!* Function UnMSBLSB      *!*
*!*                        *!*
*!**!**!**!**!**!**!**!**!**!*

Function UnMSBLSB

*!**!**!**!**!**!**!**!**!**!*

*!*	Example
*!* m.cSomeBytes = "¦¥ÃÓ"  && ascii characters from 0 to 255
*!*
*!* m.nSolved = ASC(SUBSTR(m.cSomeBytes, 4, 1))+;
*!*           ASC(SUBSTR(m.cSomeBytes, 3, 1))*256+;
*!*           ASC(SUBSTR(m.cSomeBytes, 2, 1))*256*256+;
*!*           ASC(SUBSTR(m.cSomeBytes, 1, 1))*256*256*256;
*!* OR
*!* m.nSolved = ASC("¦")+ASC("¥")*256+;
*!*           ASC("Ã")*256*256+ASC("Ó")*256*256*256;
*!*

Lparameters tcSomeBytes

Local ;
  lnRetVal, ;
  lnI

m.lnRetVal = 0

For m.lnI = 1 To Len(m.tcSomeBytes)
  m.lnRetVal = m.lnRetVal * 256 + Asc(Substr(m.tcSomeBytes, m.lnI, 1))
Endfor

Return m.lnRetVal

*!*
*!* End of function UnMSBLSB
*!*

*!**!**!**!**!**!**!**!**!**!*
*!*                        *!*
*!* Function ToMSBLSB      *!*
*!*                        *!*
*!**!**!**!**!**!**!**!**!**!*

Function ToMSBLSB

*!**!**!**!**!**!**!**!**!**!*

Lparameters tnSomeNum, tnCount

Local ;
  lcRetVal, ;
  lnI

m.lcRetVal = ""

If Type("m.tnCount")<>"N"
  m.tnCount = 1
Else
  m.tnCount = Int(m.tnCount)
Endif

For m.lnI = 1 To m.tnCount
  m.lcRetVal = Chr(Mod(m.tnSomeNum, 256)) + m.lcRetVal
  m.tnSomeNum = Int(m.tnSomeNum / 256)
Endfor

Return m.lcRetVal

*!*
*!* End of function ToMSBLSB
*!*


*!**!**!**!**!**!**!**!**!**!*
*!*                        *!*
*!* Function dectohex      *!*
*!*                        *!*
*!**!**!**!**!**!**!**!**!**!*

Function dectohex

*!**!**!**!**!**!**!**!**!**!*

Lparameters tdn1  && decnum

Private ;
  lcPrefix, ;
  lnI, ;
  laDntoHex, ;
  lcHexnum, ;
  ldn0

m.lcPrefix = Iif(m.tdn1 < 0, "-", "")
m.tdn1 = Abs(m.tdn1)
m.lnI = 0
If m.tdn1 > 15
  Do While m.tdn1 > 15
    m.lnI = m.lnI + 1
    Dimension laDntoHex(i)
    m.ldn0 = m.tdn1 - Int(m.tdn1/16) * 16
    m.laDntoHex(i) = Iif(m.ldn0 = 10, "A", Iif(m.ldn0 = 11, "B", Iif(m.ldn0 = 12, "C", ;
      iif(m.ldn0 = 13, "D", Iif(m.ldn0 = 14, "E", Iif(m.ldn0 = 15, "F", Str(m.ldn0, 1)))))))
    m.tdn1 = Int(m.tdn1/16)
  Enddo
  Dimension laDntoHex(m.lnI + 1)
  m.laDntoHex(m.lnI + 1) = Iif(m.tdn1 = 10, "A", Iif(m.tdn1 = 11, "B", Iif(m.tdn1 = 12, "C", ;
    iif(m.tdn1 = 13, "D", Iif(m.tdn1 = 14, "E", Iif(m.tdn1 = 15, "F", Str(m.ldn1, 1)))))))
  m.lcHexnum = ""
  For m.lnI = Alen(m.laDntoHex) To 1 Step -1
    m.lcHexnum = m.lcHexnum + m.laDntoHex(m.lnI)
  Endfor
  m.lcHexnum = Iif(Mod(Len(m.lcHexnum), 2) <> 0, "0" + m.lcHexnum, m.lcHexnum)
Else
  m.lcHexnum = Iif(m.tdn1 = 10, "0A", Iif(m.tdn1 = 11, "0B", Iif(m.tdn1 = 12, "0C", ;
    iif(m.tdn1 = 13, "0D", Iif(m.tdn1 = 14, "0E", Iif(m.tdn1 = 15, "0F", "0" + Str(m.tdn1, 1)))))))
Endif
Return m.lcHexnum

*!*
*!* End of function dectohex
*!*

*!**!**!**!**!**!**!**!**!**!*
*!*                        *!*
*!* Function hextodec      *!*
*!*                        *!*
*!**!**!**!**!**!**!**!**!**!*

Function hextodec

*!**!**!**!**!**!**!**!**!**!*

Lparameters thn1  && hexnum

Local ;
  lcPrefix, ;
  lnI, ;
  lnDecNum, ;
  lcHn0

m.lcPrefix = Iif(Left(m.thn1, 1) = "-", "-", "")
m.lnDecNum = 0
m.thn1 = Strtran(m.thn1, "-", "")
m.thn1 = Upper(Strtran(m.thn1, " ", ""))
For m.lnI = Len(m.thn1) To 1 Step -1
  m.lcHn0 = Substr(m.thn1, i, 1)
  m.lnDecNum = m.lnDecNum + (16^(Len(m.thn1) - m.lnI)) * ;
    Iif(Asc(m.lcHn0) > 64, Asc(m.lcHn0) - 55, Val(m.lcHn0))
Endfor
Return Int(m.lnDecNum)

*!*
*!* End of function hextodec
*!*

*!**!**!**!**!**!**!**!**!**!*
*!*                        *!*
*!* Function dectobin      *!*
*!*                        *!*
*!**!**!**!**!**!**!**!**!**!*

Function DECTOBIN  && 0-255 needed only here

*!**!**!**!**!**!**!**!**!**!*

Lparameters tdn1  && decnum

Local ;
  lnI, ;
  lnDecToBin, ;
  lcBinNum

Do Case
  Case Type("m.tDn1")<>"N"
    Return "00000000"
  Case m.tdn1 = 0
    Return "00000000"
    *case tDn1>255
    *  tDn1 = 255
Endcase

m.lnDecToBin = m.tdn1
m.lcBinNum = ""

* m.lcBinNum = stuff(m.lcBinNum, m.lnI, 1, str(m.lnDecToBin%2, 0))

Do While .T.
  m.lcBinNum = Str(m.lnDecToBin%2, 1, 0) + m.lcBinNum
  m.lnDecToBin = Int(m.lnDecToBin/2)
  If m.lnDecToBin <=1
    m.lcBinNum = Str(m.lnDecToBin, 1, 0) + m.lcBinNum
    Exit
  Endif
Enddo

If Len(m.lcBinNum)%8 <> 0
  m.lcBinNum = Repl("0", 8 - Len(m.lcBinNum)%8) + m.lcBinNum
Endif

Return m.lcBinNum

*!*
*!* End of function dectobin
*!*


*!**!**!**!**!**!**!**!**!**!*
*!*                        *!*
*!* Function bintodec      *!*
*!*                        *!*
*!**!**!**!**!**!**!**!**!**!*

Function BINTODEC

*!**!**!**!**!**!**!**!**!**!*

Lparameters tBn1  && binnum

Local ;
  lnI, ;
  lnDecNum

m.lnDecNum = 0

If Type("m.tBn1") = "N"
  m.tBn1 = Alltr(Str(Int(m.tBn1)))
Endif

For m.lnI = 1 To Len(m.tBn1)
  If !Inlist(Substr(m.tBn1, m.lnI, 1), "0", "1")
    Note: no binary Value
    *!* Note only in english
    FixMessage(107,,, tnLang)    
  Endif
Endfor

For m.lnI = Len(m.tBn1) To 1 Step -1
  m.lnDecNum = m.lnDecNum + Val(Substr(m.tBn1, m.lnI, 1)) * 2^(Len(m.tBn1) - m.lnI)
Endfor

Return m.lnDecNum

*!*
*!* End of function bintodec
*!*

Function FixMessage

Lparameters tnMessage, tcVariable1, tcVariable2, tnLang, tnHandler

LOCAL ;
  lnRetVal

m.lnRetVal = 0

Do Case

  Case Int(m.tnMessage) = 100
    Do Case
      Case m.tnLang = 1  && FIN
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox("Tiedostoa " + Chr(13) + ;
*!*	            M.tcVariable1 + " ei löydy!", 16, "ATFixDbfFpt error", 3000)
          m.lnRetVal = Messagebox("Tiedostoa " + Chr(13) + ;
            M.tcVariable1 + " ei löydy!", 16, "ATFixDbfFpt error", 1)


        #Else
*!*	          m.lnRetVal = Messagebox("Tiedostoa " + Chr(13) + ;
*!*	            M.tcVariable1 + " ei löydy!", 16, "ATFixDbfFpt error")
          m.lnRetVal = Messagebox("Tiedostoa " + Chr(13) + ;
            M.tcVariable1 + " ei löydy!", 16, "ATFixDbfFpt error",1)

        #Endif
      Case m.tnLang > 1  && ENG
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox("Can't find data file: " + Chr(13) + ;
*!*	            M.tcVariable1, 16, "ATFixDbfFpt error", 3000)
          m.lnRetVal = Messagebox("Can't find data file: " + Chr(13) + ;
            M.tcVariable1, 16, "ATFixDbfFpt error", 1)

        #Else
          m.lnRetVal = Messagebox("Can't find data file: " + Chr(13) + ;
            M.tcVariable1, 16, "ATFixDbfFpt error")
          m.lnRetVal = Messagebox("Can't find data file: " + Chr(13) + ;
            M.tcVariable1, 16, "ATFixDbfFpt error",1)
            
        #Endif
    Endcase

  Case Int(m.tnMessage) = 101
    Do Case
      Case m.tnLang = 1  && FIN
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox("Tiedostoa " + Chr(13) + ;
*!*	            M.tcVariable1 + " ei löydy!", 16, "ATFixDbfFpt error", 3000)
          m.lnRetVal = Messagebox("Tiedostoa " + Chr(13) + ;
            M.tcVariable1 + " ei löydy!", 16, "ATFixDbfFpt error", 1)

        #Else
*!*	          m.lnRetVal = Messagebox("Tiedostoa " + Chr(13) + ;
*!*	            M.tcVariable1 + " ei löydy!", 16, "ATFixDbfFpt error")
          m.lnRetVal = Messagebox("Tiedostoa " + Chr(13) + ;
            M.tcVariable1 + " ei löydy!", 16, "ATFixDbfFpt error",1)

        #Endif
      Case m.tnLang > 1  && ENG
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox("Can't find container " + Chr(13) + ;
*!*	            M.tcVariable1, 16, "ATFixDbfFpt error", 3000)
          m.lnRetVal = Messagebox("Can't find container " + Chr(13) + ;
            M.tcVariable1, 16, "ATFixDbfFpt error", 1)

        #Else
*!*	          m.lnRetVal = Messagebox("Can't find container " + Chr(13) + ;
*!*	            M.tcVariable1, 16, "ATFixDbfFpt error")
          m.lnRetVal = Messagebox("Can't find container " + Chr(13) + ;
            M.tcVariable1, 16, "ATFixDbfFpt error",1)

        #Endif
    Endcase

  Case Int(m.tnMessage) = 102
    Do Case
      Case m.tnLang = 1  && FIN
        Wait Window "Odottele teen varmuuskopioa: " + m.tcVariable2 ;
        AT WROWS()/2, WCOLS()/2-20 Nowait
      Case m.tnLang > 1  && ENG
        Wait Window "Wait for backing up " + ;
          JUSTFNAME(m.tcVariable1) + " to " + Justfname(m.tcVariable2) ;
          AT WROWS()/2, WCOLS()/2-30 Nowait
    Endcase

  Case Int(m.tnMessage) = 103
    Do Case
      Case m.tnLang = 1  && FIN
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox("Varmuuskopio:" + Chr(13) + ;
*!*	            m.tcVariable1 + " valmis!", 64, "ATFixDbfFpt", 1500)
          m.lnRetVal = Messagebox("Varmuuskopio:" + Chr(13) + ;
            m.tcVariable1 + " valmis!", 64, "ATFixDbfFpt", 1)

        #Else
*!*	          m.lnRetVal = Messagebox("Varmuuskopio:" + Chr(13) + ;
*!*	            m.tcVariable1 + " valmis!", 64, "ATFixDbfFpt")
          m.lnRetVal = Messagebox("Varmuuskopio:" + Chr(13) + ;
            m.tcVariable1 + " valmis!", 64, "ATFixDbfFpt",1)

        #Endif
      Case m.tnLang > 1  && ENG
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox("Backup file :" + Chr(13) + ;
*!*	            m.tcVariable1 + " is done!", 64, "ATFixDbfFpt", 1500)
          m.lnRetVal = Messagebox("Backup file :" + Chr(13) + ;
            m.tcVariable1 + " is done!", 64, "ATFixDbfFpt", 1)

        #Else
*!*	          m.lnRetVal = Messagebox("Backup file :" + Chr(13) + ;
*!*	            m.tcVariable1 + " is done!", 64, "ATFixDbfFpt")
          m.lnRetVal = Messagebox("Backup file :" + Chr(13) + ;
            m.tcVariable1 + " is done!", 64, "ATFixDbfFpt",1)

        #Endif
    Endcase

  Case Int(m.tnMessage) = 104

    Local ;
      lcReason

    Do Case
      Case m.tnLang = 1  && FIN
        Do Case                				&& Determine the error
          Case m.tnMessage - Int(m.tnMessage) = (2/10)
            m.lcReason = "Tiedostoa ei löydy (2)"
          Case m.tnMessage - Int(m.tnMessage) = (4/10)
            m.lcReason = "Liian monta tiedostoa auki (tiedosto kahvat loppu) (4)"
          Case m.tnMessage - Int(m.tnMessage) = (5/10)
            m.lcReason = "Tiedostoon pääsy kielletty (5)"
          Case m.tnMessage - Int(m.tnMessage) = (6/10)
            m.lcReason = "Väärä tiedosto kahva (6)"
          Case m.tnMessage - Int(m.tnMessage) = (8/10)
            m.lcReason = "Muisti loppu (8)"
          Case m.tnMessage - Int(m.tnMessage) = (25/100)
            m.lcReason = "Haku ei saa kohdistua paikkaan ennen tiedoston alkua (25)"
          Case m.tnMessage - Int(m.tnMessage) = (29/100)
            m.lcReason = "Levy täynnä (29)"
          Case m.tnMessage - Int(m.tnMessage) = (31/100)
            m.lcReason = "Tiedoston avaus ei onnistu (31)"
          Otherwise
            m.lcReason = "Virhe (" + Allt(Str((m.tnMessage - Int(m.tnMessage))*100)) + ")"
        Endcase
      Case m.tnLang > 1  && ENG
        Do Case                				&& Determine the error
          Case m.tnMessage - Int(m.tnMessage) = (2/10)
            m.lcReason = "File not found (2)"
          Case m.tnMessage - Int(m.tnMessage) = (4/10)
            m.lcReason = "Too many files open (out of file handles) (4)"
          Case m.tnMessage - Int(m.tnMessage) = (5/10)
            m.lcReason = "Access denied (5)"
          Case m.tnMessage - Int(m.tnMessage) = (6/10)
            m.lcReason = "Invalid file handle given (6)"
          Case m.tnMessage - Int(m.tnMessage) = (8/10)
            m.lcReason = "Out of memory (8)"
          Case m.tnMessage - Int(m.tnMessage) = (25/100)
            m.lcReason = "Seek error (can't seek before the start of a file) (25)"
          Case m.tnMessage - Int(m.tnMessage) = (29/100)
            m.lcReason = "Disk full (29)"
          Case m.tnMessage - Int(m.tnMessage) = (31/100)
            m.lcReason = "Error opening file (31)"
          Otherwise
            m.lcReason = "Error (" + Allt(Str((m.tnMessage - Int(m.tnMessage))*100)) + ")"
        Endcase

    Endcase

    Note: Dbf Is corrupte but cannot Fopen

    Do Case
      Case m.tnLang = 1  && FIN
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox("Tiedostoa " + m.tcVariable1 + Chr(13) + ;
*!*	            "Ei voi avata, koska:" + Chr(13) + ;
*!*	            M.lcReason + Chr(13) + ;
*!*	            "Ota virhe muistiin.", 16, "ATFixDbfFpt virhe", 0)
          m.lnRetVal = Messagebox("Tiedostoa " + m.tcVariable1 + Chr(13) + ;
            "Ei voi avata, koska:" + Chr(13) + ;
            M.lcReason + Chr(13) + ;
            "Ota virhe muistiin.", 16, "ATFixDbfFpt virhe", 1)

        #Else
*!*	          m.lnRetVal = Messagebox("Tiedostoa " + m.tcVariable1 + Chr(13) + ;
*!*	            "Ei voi avata, koska:" + Chr(13) + ;
*!*	            M.lcReason + Chr(13) + ;
*!*	            "Ota virhe muistiin.", 16, "ATFixDbfFpt virhe")
          m.lnRetVal = Messagebox("Tiedostoa " + m.tcVariable1 + Chr(13) + ;
            "Ei voi avata, koska:" + Chr(13) + ;
            M.lcReason + Chr(13) + ;
            "Ota virhe muistiin.", 16, "ATFixDbfFpt virhe",1)

        #Endif
      Case m.tnLang > 1  && ENG
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox("Can't open file " + m.tcVariable1 + Chr(13) + ;
*!*	            "because of error:" + Chr(13) + ;
*!*	            M.lcReason + Chr(13) + ;
*!*	            "Write this error down.", 16, "ATFixDbfFpt error", 0)
          m.lnRetVal = Messagebox("Can't open file " + m.tcVariable1 + Chr(13) + ;
            "because of error:" + Chr(13) + ;
            M.lcReason + Chr(13) + ;
            "Write this error down.", 16, "ATFixDbfFpt error", 1)

        #Else
*!*	          m.lnRetVal = Messagebox("Can't open file " + m.tcVariable1 + Chr(13) + ;
*!*	            "because of error:" + Chr(13) + ;
*!*	            M.lcReason + Chr(13) + ;
*!*	            "Write this error down.", 16, "ATFixDbfFpt error")
          m.lnRetVal = Messagebox("Can't open file " + m.tcVariable1 + Chr(13) + ;
            "because of error:" + Chr(13) + ;
            M.lcReason + Chr(13) + ;
            "Write this error down.", 16, "ATFixDbfFpt error",1)

        #Endif
        
    Endcase

  Case Int(m.tnMessage) = 105
    Do Case
      Case m.tnLang = 1  && FIN
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox("Tiedostoa " + m.tcVariable1 + Chr(13) + ;
*!*	            "ei voi avata. Sulje mahdolliset muut" + Chr(13) + ;
*!*	            "ohjelmat, jotka käyttävät tätä tiedostoa" + Chr(13) + ;
*!*	            "ja yritä uudelleen.", 16, "ATFixDbfFpt error", 5000)
          m.lnRetVal = Messagebox("Tiedostoa " + m.tcVariable1 + Chr(13) + ;
            "ei voi avata. Sulje mahdolliset muut" + Chr(13) + ;
            "ohjelmat, jotka käyttävät tätä tiedostoa" + Chr(13) + ;
            "ja yritä uudelleen.", 16, "ATFixDbfFpt error", 1)

        #Else
*!*	          m.lnRetVal = Messagebox("Tiedostoa " + m.tcVariable1 + Chr(13) + ;
*!*	            "ei voi avata. Sulje mahdolliset muut" + Chr(13) + ;
*!*	            "ohjelmat, jotka käyttävät tätä tiedostoa" + Chr(13) + ;
*!*	            "ja yritä uudelleen.", 16, "ATFixDbfFpt error")
          m.lnRetVal = Messagebox("Tiedostoa " + m.tcVariable1 + Chr(13) + ;
            "ei voi avata. Sulje mahdolliset muut" + Chr(13) + ;
            "ohjelmat, jotka käyttävät tätä tiedostoa" + Chr(13) + ;
            "ja yritä uudelleen.", 16, "ATFixDbfFpt error",1)

        #Endif
      Case m.tnLang > 1  && ENG
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox("Can't open file " + m.tcVariable1 + Chr(13) + ;
*!*	            "Close other applications using this file" + Chr(13) + ;
*!*	            "and try again...", 16, "ATFixDbfFpt error", 5000)
          m.lnRetVal = Messagebox("Can't open file " + m.tcVariable1 + Chr(13) + ;
            "Close other applications using this file" + Chr(13) + ;
            "and try again...", 16, "ATFixDbfFpt error", 1)

        #Else
*!*	          m.lnRetVal = Messagebox("Can't open file " + m.tcVariable1 + Chr(13) + ;
*!*	            "Close other applications using this file" + Chr(13) + ;
*!*	            "and try again...", 16, "ATFixDbfFpt error")
          m.lnRetVal = Messagebox("Can't open file " + m.tcVariable1 + Chr(13) + ;
            "Close other applications using this file" + Chr(13) + ;
            "and try again...", 16, "ATFixDbfFpt error",1)

        #Endif
    Endcase

  Case Int(m.tnMessage) = 106
    Do Case
      Case m.tnLang = 1  && FIN
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox("Virhe: " + m.tcVariable2 + Chr(13) + ;
*!*	            "Tiedosto " + m.tcVariable1 + Chr(13) + ;
*!*	            "on korjauskelvoton, palauta nauhavarmistuskopio...", 16, "ATFixDbfFpt error", 5000)
          m.lnRetVal = Messagebox("Virhe: " + m.tcVariable2 + Chr(13) + ;
            "Tiedosto " + m.tcVariable1 + Chr(13) + ;
            "on korjauskelvoton, palauta nauhavarmistuskopio...", 16, "ATFixDbfFpt error", 1)

        #Else
*!*	          m.lnRetVal = Messagebox("Virhe: " + m.tcVariable2 + Chr(13) + ;
*!*	            "Tiedosto " + m.tcVariable1 + Chr(13) + ;
*!*	            "on korjauskelvoton, palauta nauhavarmistuskopio...", 16, "ATFixDbfFpt error")
          m.lnRetVal = Messagebox("Virhe: " + m.tcVariable2 + Chr(13) + ;
            "Tiedosto " + m.tcVariable1 + Chr(13) + ;
            "on korjauskelvoton, palauta nauhavarmistuskopio...", 16, "ATFixDbfFpt error",1)

        #Endif
      Case m.tnLang > 1  && ENG
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox("Fatal error: " + m.tcVariable2 + Chr(13) + ;
*!*	            "File " + m.tcVariable1 + Chr(13) + ;
*!*	            "is unrepairable, restore tape backup...", 16, "ATFixDbfFpt error", 5000)
          m.lnRetVal = Messagebox("Fatal error: " + m.tcVariable2 + Chr(13) + ;
            "File " + m.tcVariable1 + Chr(13) + ;
            "is unrepairable, restore tape backup...", 16, "ATFixDbfFpt error", 1)

        #Else
*!*	          m.lnRetVal = Messagebox("Fatal error: " + m.tcVariable2 + Chr(13) + ;
*!*	            "File " + m.tcVariable1 + Chr(13) + ;
*!*	            "is unrepairable, restore tape backup...", 16, "ATFixDbfFpt error")
          m.lnRetVal = Messagebox("Fatal error: " + m.tcVariable2 + Chr(13) + ;
            "File " + m.tcVariable1 + Chr(13) + ;
            "is unrepairable, restore tape backup...", 16, "ATFixDbfFpt error",1)

        #Endif
    Endcase

  Case Int(m.tnMessage) = 107
    DO case
      CASE m.tnLang = 1  && FIN
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox("Ei binääri arvo", 48, "ATFixDbfFpt", 3000)
                   m.lnRetVal = Messagebox("Ei binääri arvo", 48, "ATFixDbfFpt", 1)

        #Else
*!*	          m.lnRetVal = Messagebox("Ei binääri arvo", 48, "ATFixDbfFpt")
          m.lnRetVal = Messagebox("Ei binääri arvo", 48, "ATFixDbfFpt",1)

        #Endif
      
      CASE m.tnLang > 1  && ENG
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox("Not a binary value", 48, "ATFixDbfFpt", 3000)
      m.lnRetVal = Messagebox("Not a binary value", 48, "ATFixDbfFpt", 1)
        #Else
        
*!*	          m.lnRetVal = Messagebox("Not a binary value", 48, "ATFixDbfFpt")
          m.lnRetVal = Messagebox("Not a binary value", 48, "ATFixDbfFpt",1)
        #Endif
    Endcase  

  Case Int(m.tnMessage) = 108
    Do Case
      Case m.tnLang = 1  && FIN
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox(ALLTRIM(STR(m.tcVariable1)) + ;
*!*	            " tiedostoa löytynyt. Niiden palauttaminen voi kestää kauan." + Chr(13) + ;
*!*	            "Haluatko jatkaa?" + Chr(13) + Chr(13) + ;
*!*	            "NOTE: tnRepairMode arvo " + ALLTRIM(STR(m.tcVariable2-3)) + ;
*!*	            " on paljon nopeampi!", 292, "Hidas prosessi?", 10000)
          m.lnRetVal = Messagebox(ALLTRIM(STR(m.tcVariable1)) + ;
            " tiedostoa löytynyt. Niiden palauttaminen voi kestää kauan." + Chr(13) + ;
            "Haluatko jatkaa?" + Chr(13) + Chr(13) + ;
            "NOTE: tnRepairMode arvo " + ALLTRIM(STR(m.tcVariable2-3)) + ;
            " on paljon nopeampi!", 292, "Hidas prosessi?", 1)

        #Else
*!*	          m.lnRetVal = Messagebox(ALLTRIM(STR(m.tcVariable1)) + ;
*!*	            " tiedostoa löytynyt. Niiden palauttaminen voi kestää kauan." + Chr(13) + ;
*!*	            "Haluatko jatkaa?" + Chr(13) + Chr(13) + ;
*!*	            "NOTE: tnRepairMode arvo " + ALLTRIM(STR(m.tcVariable2-3)) + ;
*!*	            " on paljon nopeampi!", 292, "Hidas prosessi?")
          m.lnRetVal = Messagebox(ALLTRIM(STR(m.tcVariable1)) + ;
            " tiedostoa löytynyt. Niiden palauttaminen voi kestää kauan." + Chr(13) + ;
            "Haluatko jatkaa?" + Chr(13) + Chr(13) + ;
            "NOTE: tnRepairMode arvo " + ALLTRIM(STR(m.tcVariable2-3)) + ;
            " on paljon nopeampi!", 292, "Hidas prosessi?",1)

        #Endif
      Case m.tnLang > 1  && ENG
        #If Val(Alltrim(Strtran(Upper(Version()),'VISUAL FOXPRO',''))) > 6
*!*	          m.lnRetVal = Messagebox(ALLTRIM(STR(m.tcVariable1)) + ;
*!*	            " records found. It could take a while to repair." + Chr(13) + ;
*!*	            "Do you want to continue?" + Chr(13) + Chr(13) + ;
*!*	            "NOTE: tnRepairMode value " + ALLTRIM(STR(m.tcVariable2-3)) + ;
*!*	            " would be much faster!", 292, "Slow process?", 10000)
          m.lnRetVal = Messagebox(ALLTRIM(STR(m.tcVariable1)) + ;
            " records found. It could take a while to repair." + Chr(13) + ;
            "Do you want to continue?" + Chr(13) + Chr(13) + ;
            "NOTE: tnRepairMode value " + ALLTRIM(STR(m.tcVariable2-3)) + ;
            " would be much faster!", 292, "Slow process?", 1)

        #Else
*!*	          m.lnRetVal = Messagebox(ALLTRIM(STR(m.tcVariable1)) + ;
*!*	            " records found. It could take a while to repair." + Chr(13) + ;
*!*	            "Do you wnat to continue?" + Chr(13) + Chr(13) + ;
*!*	            "NOTE: tnRepairMode value " + ALLTRIM(STR(m.tcVariable2-3)) + ;
*!*	            " would be much faster!", 292, "Slow process?")
          m.lnRetVal = Messagebox(ALLTRIM(STR(m.tcVariable1)) + ;
            " records found. It could take a while to repair." + Chr(13) + ;
            "Do you wnat to continue?" + Chr(13) + Chr(13) + ;
            "NOTE: tnRepairMode value " + ALLTRIM(STR(m.tcVariable2-3)) + ;
            " would be much faster!", 292, "Slow process?",1)

        #Endif
    Endcase


  Case Int(m.tnMessage) = 109
    Do Case
      Case m.tnLang = 1  && FIN
        Wait Window "Tietue  " + ;
          PADR(ALLTRIM(STR(m.tcVariable1)) + "/" + ALLTRIM(STR(m.tcVariable2)),21," ") ;
          AT WROWS()/2, WCOLS()/2-15 Nowait
      Case m.tnLang > 1  && ENG
        Wait Window "Reading record  " + ;
          PADR(ALLTRIM(STR(m.tcVariable1)) + "/" + ALLTRIM(STR(m.tcVariable2)),21," ") ;
          AT WROWS()/2, WCOLS()/2-15 Nowait
    Endcase

  Case Int(m.tnMessage) = 200
    Do Case
      Case m.tnLang = 1  && FIN
        Wait Window "ATFixDbfFpt käyttäjän keskeytys. Korjauksia ei suoritettu." ;
        AT WROWS()/2, WCOLS()/2-25 Nowait
      Case m.tnLang > 1  && ENG
        Wait Window "ATFixDbfFpt cancelled by the user. No fixing done." ;
        AT WROWS()/2, WCOLS()/2-25 Nowait    
    Endcase

  Case Int(m.tnMessage) = 201
    Do Case
      Case m.tnLang = 1  && FIN
        Wait Window "ATFixDbfFpt keskeytetty virheen takia." ;
        AT WROWS()/2, WCOLS()/2-20 Nowait
      Case m.tnLang > 1  && ENG
        Wait Window "ATFixDbfFpt cancelled because of an error." ;
        AT WROWS()/2, WCOLS()/2-20 Nowait    
    Endcase

Endcase

If Type("m.tnHandler") = "N"
  Fclose(m.tnHandler)
Endif

RETURN m.lnRetVal


Function FixExit

Lparameters lnRetVal, lcTmpDbf, lnSelect, tnHandler, tnLang

IF TYPE("m.tnHandler") = "N"
  FCLOSE(m.tnHandler)
ENdif  

If Type("m.lcTmpDbf") = "C" AND ;
  !Empty(JUSTSTEM(m.lcTmpDbf))

  If Used(JUSTSTEM(m.lcTmpDbf))
    Use In (JUSTSTEM(m.lcTmpDbf))
  Endif

  Erase m.lcTmpDbf+".DBF"
  Erase m.lcTmpDbf+".FPT"
ENdif  

If Type("m.lnSelect") = "N" AND ;
  m.lnSelect > 0
  Select (m.lnSelect)
ENDIF

DO CASE
  CASE INLIST(m.lnRetVal, 200, 300, 700)
    FixMessage(200,,, tnLang)
  CASE m.lnRetVal < 0
    FixMessage(201,,, tnLang)
Endcase    

Return m.lnRetVal
