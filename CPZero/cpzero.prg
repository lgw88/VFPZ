* CPZERO -- Poke a codepage byte into a database header
* Copyright Microsoft Corp, 1993-2001
*
* Usage: 
*    DO CPZERO WITH dbfname                     && marks the database with codepage 0 (i.e., no codepage)
* 
*    DO CPZERO WITH dbfname, codepage_number    && marks the database with specified codepage
*
* Some common valid numbers are:
*   Windows            1252
*   DOS                 437
*   International DOS   850
*

PARAMETER m.fname, m.cpbyte
IF SET("TALK") = "ON"
   SET TALK OFF
   m.mtalk = "ON"
ELSE
   m.mtalk = "OFF"
ENDIF   

#define C_TOTAL 29     && total code page numbers supported

IF PARAMETERS() < 2
   m.cpbyte = 0
ENDIF   

PRIVATE m.mtalk, m.vuename

#define c_buf_size 32

#define c_noopen   1
#define c_badbyte  2
#define c_notfox   3
#define c_maxerror 4

#DEFINE c_notopened_LOC 	"The table could not be opened."
#DEFINE c_invalid_page_LOC	"Invalid code page specified."
#DEFINE c_NotFoxTable_LOC	"Not a FoxPro table."

#DEFINE c_OpenTable_LOC		"Table:"

m.vuename = ""

DECLARE error_array[c_maxerror]
error_array[c_noopen] = c_notopened_LOC
error_array[c_badbyte] = c_invalid_page_LOC
error_array[c_notfox] = c_NotFoxTable_LOC

DO setup
DO main
DO cleanup

PROCEDURE setup
m.vuename = SYS(2023)+"\"+SYS(3)+".VUE"
CREATE VIEW (m.vuename)


PROCEDURE cleanup
IF FILE(m.vuename)
   SET VIEW TO (m.vuename)
   DELETE FILE (m.vuename)
ENDIF   
SET TALK &mtalk

PROCEDURE main
PRIVATE m.fp_in, m.buf, m.found_one, m.i, m.outbyte

* Set up table of code pages and DBF bytes numbers
DIMENSION cpnums[C_TOTAL,2] 
cpnums[ 1,1] = 437		&& MS-DOS, U.S.A.
cpnums[ 1,2] = 1
cpnums[ 2,1] = 850		&& MS-DOS, International
cpnums[ 2,2] = 2
cpnums[ 3,1] = 1252		&& Windows, U.S.A & West European
cpnums[ 3,2] = 3
cpnums[ 4,1] = 10000	&& Macintosh, U.S.A.
cpnums[ 4,2] = 4
cpnums[ 5,1] = 852		&& MS-DOS, East European
cpnums[ 5,2] = 100
cpnums[ 6,1] = 866		&& MS-DOS, Russian
cpnums[ 6,2] = 101
cpnums[ 7,1] = 865		&& MS-DOS, Nordic
cpnums[ 7,2] = 102
cpnums[ 8,1] = 861		&& MS-DOS, Iceland
cpnums[ 8,2] = 103
cpnums[ 9,1] = 895		&& MS-DOS, Kamenicky (Czech)
cpnums[ 9,2] = 104
cpnums[10,1] = 620		&& MS-DOS, Mazovia (Polish)
cpnums[10,2] = 105
cpnums[11,1] = 737		&& MS-DOS, Greek
cpnums[11,2] = 106
cpnums[12,1] = 857		&& MS-DOS, Turkey
cpnums[12,2] = 107
cpnums[13,1] = 863		&& MS-DOS, Canada
cpnums[13,2] = 108
cpnums[14,1] = 950		&& Windows, Traditional Chinese
cpnums[14,2] = 120
cpnums[15,1] = 949		&& Windows, Korean (Hangul)
cpnums[15,2] = 121
cpnums[16,1] = 936		&& Windows, Simplified Chinese
cpnums[16,2] = 122
cpnums[17,1] = 932		&& Windows, Japanese (Shift-jis)
cpnums[17,2] = 123
cpnums[18,1] = 874		&& Windows, Thai
cpnums[18,2] = 124
cpnums[19,1] = 10007	&& Macintosh, Russian
cpnums[19,2] = 150
cpnums[20,1] = 10029	&& Macintosh, East European
cpnums[20,2] = 151
cpnums[21,1] = 10006	&& Macintosh, Greek
cpnums[21,2] = 152
cpnums[22,1] = 1250		&& Windows, East European
cpnums[22,2] = 200
cpnums[23,1] = 1251		&& Windows, Russian
cpnums[23,2] = 201
cpnums[24,1] = 1253		&& Windows, Greek
cpnums[24,2] = 203
cpnums[25,1] = 1254		&& Windows, Turkish
cpnums[25,2] = 202
cpnums[26,1] = 1255		&& Windows, Hebrew (Only supported on Hebrew OS)
cpnums[26,2] = 125
cpnums[27,1] = 1256		&& Windows, Arabic (Only supported on Arabic OS)
cpnums[27,2] = 126
cpnums[28,1] = 1257		&& Windows, Baltic
cpnums[28,2] = 204
cpnums[29,1] = 0		&& No codepage mark.
cpnums[29,2] = 0

IF EMPTY(m.fname)
   m.fname = getfile("DBF|SCX|VCX|FRX|LBX|MNX",c_OpenTable_LOC)
ENDIF
IF !EMPTY(m.fname)
   CLOSE DATABASES
   m.outbyte = m.cpbyte
   m.found_one = .F.
   FOR m.i = 1 TO C_TOTAL
      IF m.cpbyte = cpnums[m.i,1]
         m.outbyte = cpnums[m.i,2]
         m.found_one = .T.
         EXIT
      ENDIF
   ENDFOR
   IF m.found_one
      m.cpbyte = m.outbyte
   ELSE
      * Was it a valid DBF byte if it wasn't a valid code page?
      FOR m.i = 1 TO C_TOTAL
         IF m.cpbyte = cpnums[m.i,2]
            m.found_one = .T.
         ENDIF
      ENDFOR
      IF !m.found_one
         DO errormsg WITH c_badbyte
         RETURN TO cpzero
      ENDIF
   ENDIF
   
   IF FILE(m.fname)
       m.fp_in = FOPEN(m.fname,2)
       IF m.fp_in > 0
          * First check that we have a FoxPro table...
          m.buf=FREAD(m.fp_in,c_buf_size)
          IF (SUBSTR(m.buf,1,1) = CHR(139) OR SUBSTR(m.buf,1,1) = CHR(203);
             OR SUBSTR(m.buf,31,1) != CHR(0) OR SUBSTR(m.buf,32,1) != CHR(0))
              =fclose(m.fp_in)
              DO errormsg WITH c_notfox
              RETURN TO cpzero
          ELSE
              * Now poke the codepage id into byte 29
              =FSEEK(m.fp_in,29)
              =FWRITE(m.fp_in,CHR(m.cpbyte)) 
              =FCLOSE(m.fp_in)
          ENDIF
       ELSE
          DO errormsg WITH c_noopen
          RETURN TO cpzero
       ENDIF
    ELSE
       DO errormsg WITH c_noopen
       RETURN TO cpzero
    ENDIF
ENDIF      


PROCEDURE errormsg
PARAMETER num
WAIT WINDOW error_array[num] NOWAIT
