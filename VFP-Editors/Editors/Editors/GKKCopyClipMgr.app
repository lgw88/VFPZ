��� &   �I 7E N                    u   %         E       7�Q?    �  U  � %�C�9� GKKTools��h��I � %�C�9�  ���E � T�9�  �C� Empty�N�� � � � ��C� GKKTools�9� �� T�9�  �C� Empty�N�� �# %�C�9�  � CopyClipMgr��h��� � %�C�9�  � ��� O��� �5 T�9�  � �C� CopyClipMgr� GKKCopyClipMgr.vcx���� � �S� ��C�9�  � CopyClipMgr�
��5 T�9�  � �C� CopyClipMgr� GKKCopyClipMgr.vcx���� �+ %�� GKKDeclareAPIC�	 Procedurev
���� G+(� GKKDeclareAPI� � U  GKKTOOLS ADDPROPERTY COPYCLIPMGR GKKDECLAREAPI GKKCopyClipMgr,     ��< �qA � qqA 1�QA � �QA �qA 1                    �  I     0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _3C70PF76N1264322386�        �             ~  �	          �  �  �          �      ~  �   COMMENT RESERVED                        k      B                                                           '                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      "  ..\programs\gkkdefines.h�o��fF      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      copyclipmgr      ..\programs\gkkdefines.h      Pixels      Class      1      form      copyclipmgr     �_memberdata XML Metadata for customizable properties
copyclipform Handle to the GKK Copy Clip Manager form
*addcopycliptocursor Adds the selected code text to the Copy Clip cursor
*displaycopyclipmgr Displays the GKK Copy Clip Manager form
*getcopyclipcount Returns the count of Copy Clip texts in the cursor buffer
*getcopyclipfromcursor Gets the selected copy clip text from the cursor buffer
*getcopycliplist Returns the copy clip list in an array object
     �_memberdata = <VFPData><memberdata name="Caption" type="property" display="Caption"/><memberdata name="copyclipform" type="property" display="CopyClipForm"/><memberdata name="DataSession" type="property" display="DataSession"/><memberdata name="DoCreate" type="property" display="DoCreate"/><memberdata name="Height" type="property" display="Height"/><memberdata name="Icon" type="property" display="Icon"/><memberdata name="Left" type="property" display="Left"/><memberdata name="MaxButton" type="property" display="MaxButton"/><memberdata name="MinButton" type="property" display="MinButton"/><memberdata name="Name" type="property" display="Name"/><memberdata name="TitleBar" type="property" display="TitleBar"/><memberdata name="Top" type="property" display="Top"/><memberdata name="Width" type="property" display="Width"/><memberdata name="addcopycliptocursor" type="method" display="AddCopyClipToCursor"/><memberdata name="displaycopyclipmgr" type="method" display="DisplayCopyClipMgr"/><memberdata name="getcopyclipcount" type="method" display="GetCopyClipCount"/><memberdata name="getcopyclipfromcursor" type="method" display="GetCopyClipFromCursor"/><memberdata name="getcopycliplist" type="method" display="GetCopyClipList"/></VFPData>
UserNotes =      ����    �  �                        .   %           >   �          �  U    ��  � �� � � � � � �� ���� %�C�  �
���5 T� �CC� C�
 �  C� C�
 C� C�
 ����� %�C� ���� � T� ��  �� �6 r��
 c_copyclip� � �	 ��C��]��� ���  ��% %�C�
 � �
� C�
 � ��� O	���* ��CC� � �C�
 c_copyclipO�
 � � � �� � � U 
 TCCODETEXT	 LNLINECNT
 LCCODETEXT
 LCCODELINE
 LOBEAUTIFY LNLINE LACODE CODEID CODELINE CODETEXT THIS COPYCLIPFORM LSTCOPYLIST ADDLISTITEM
 C_COPYCLIP{  ��  � %�C� � ���\ � � GKKCopyClipMgrJ�  � %�C�  ��� O��X � T� � ��  �� � �t � ��C� � � �� � U  LOFORM THISFORM COPYCLIPFORM GKKCOPYCLIPMGR SHOW?  ��  � F� � G � T�  �C�
 c_copyclipN�� G�	 B��  �� U 
 LNRECCOUNT
 C_COPYCLIP�  ��  � F� � %�C�  �CN���f � #� ��  �� %�C'��H � T� ��  �� �b � T� �C� � ��� � �{ � T� ��  �� �	 B�� �� U  TNRECNO
 C_COPYCLIP
 LCCODETEXT CODETEXT�  ��  � ��  � �� � T� �� �� F� � ~�C'
��� � T� �� ��� �  �� ����� T�  �� �����C� � ��� T�  �� �����C� � ��� �	 B�� �� U 
 TACOPYLIST LNCNT
 C_COPYCLIP CODELINE CODETEXT< 9 h��
 c_copyclip� � C��
�� � C����� � M� U 
 C_COPYCLIP CODEID CODELINE CODETEXT addcopycliptocursor,     �� displaycopyclipmgr�    �� getcopyclipcount�    �� getcopyclipfromcursor    �� getcopycliplist�    �� Load�    ��1 q q� �Q� � A aQ�A A 2 q !�QA � A 2 q q a �a � 2 q q A� � � � !A � � A � 2 q � q � q � 1��A � 2 �1                               D    (      /  �  3   !   �  �  ;   /   �  $
  J   <   ?
  �
  X    )   �                       
�PROCEDURE addcopycliptocursor
LPARAMETERS tcCodeText
LOCAL lnLineCnt, lcCodeText, lcCodeLine, loBeautify, lnLine
LOCAL ARRAY laCode[1]
IF !EMPTY(tcCodeText)
*	lnLineCnt = ALINES(laCode, tcCodeText, 1)
*	IF lnLineCnt > 1
*		lcCodeText = ""
*		lcCodeLine = ALLTRIM(laCode[1], 1, " ", TAB)
*		FOR lnLine=1 TO lnLineCnt
*			lcCodeText = lcCodeText + ALLTRIM(laCode[lnLine], 1, " ", TAB) + CRLF
*		ENDFOR
*		loBeautify = CREATEOBJECT("Empty")
*		ADDPROPERTY(loBeautify, "TabChr", 1)
*		ADDPROPERTY(loBeautify, "TabSize", 4)
*		ADDPROPERTY(loBeautify, "AlignComment", True)
*		ADDPROPERTY(loBeautify, "AlignCommentCol", 80)
*		ADDPROPERTY(loBeautify, "Keywords", 1)
*		ADDPROPERTY(loBeautify, "Symbols", 3)
*		ADDPROPERTY(loBeautify, "CommentIndent", False)
*		ADDPROPERTY(loBeautify, "IndentCase", True)
*		ADDPROPERTY(loBeautify, "IndentProc", False)
*		ADDPROPERTY(loBeautify, "IndentDefine", False)
*		lcCodeText = GKKBeautifyText(lcCodeText, loBeautify)
*	ELSE
*		lcCodeText = ALLTRIM(tcCodeText, 1, " ", TAB)
*		lcCodeLine = lcCodeText
*	ENDIF
*	INSERT INTO c_copyclip (codeid, codeline, codetext) VALUES (SYS(2015), lcCodeLine, lcCodeText)
	lcCodeLine = STREXTRACT(CRLF+tcCodeText, CRLF, CRLF, 1)
	IF EMPTY(lcCodeLine)
		lcCodeLine = tcCodeText
	ENDIF
	INSERT INTO c_copyclip (codeid, codeline, codetext) VALUES (SYS(2015), lcCodeLine, tcCodeText)
	IF !ISNULL(this.CopyClipForm) .AND. VARTYPE(this.CopyClipForm) = "O"
		this.CopyClipForm.lstCopyList.AddListItem(ALLTRIM(c_copyclip.codeline), RECNO('c_copyclip'))
	ENDIF
ENDIF
ENDPROC
PROCEDURE displaycopyclipmgr
LOCAL loForm
IF ISNULL(thisform.CopyClipForm)
	DO FORM GKKCopyClipMgr NAME loForm
	IF VARTYPE(loForm) = "O"
		thisform.CopyClipForm = loForm
	ENDIF
ELSE
	thisform.CopyClipForm.Show()
ENDIF
ENDPROC
PROCEDURE getcopyclipcount
LOCAL lnRecCount
SELECT c_copyclip
SET DELETED ON
lnRecCount = RECCOUNT('c_copyclip')
SET DELETED OFF
RETURN lnRecCount
ENDPROC
PROCEDURE getcopyclipfromcursor
LPARAMETERS tnRecNo
SELECT c_copyclip
IF BETWEEN(tnRecNo, 1, RECCOUNT())
	GOTO RECORD tnRecNo IN c_copyclip
	IF DELETED()
		lcCodeText = ""
	ELSE
		lcCodeText = ALLTRIM(c_copyclip.codetext)
	ENDIF
ELSE
	lcCodeText = ""
ENDIF
RETURN lcCodeText
ENDPROC
PROCEDURE getcopycliplist
LPARAMETERS taCopyList
EXTERNAL ARRAY taCopyList
LOCAL lnCnt
lnCnt = 0
SELECT c_copyclip
SCAN FOR !DELETED()
	lnCnt = lnCnt + 1
	DIMENSION taCopyList[lnCnt, 2]
	taCopyList[lnCnt, 1] = ALLTRIM(c_copyclip.codeline)
	taCopyList[lnCnt, 2] = ALLTRIM(c_copyclip.codetext)
ENDSCAN
RETURN lnCnt
ENDPROC
PROCEDURE Load
CREATE CURSOR c_copyclip (codeid C(10), codeline C(200), codetext M)
ENDPROC
      form     �DataSession = 2
Top = 0
Left = 0
Height = 39
Width = 259
DoCreate = .T.
Caption = "GKK Copy Clip Manager"
MaxButton = .F.
MinButton = .F.
Icon = ..\graphics\gkkgkk.ico
TitleBar = 0
_memberdata =      501<VFPData><memberdata name="copyclipform" type="property" display="CopyClipForm"/><memberdata name="addcopycliptocursor" type="method" display="AddCopyClipToCursor"/><memberdata name="displaycopyclipmgr" type="method" display="DisplayCopyClipMgr"/><memberdata name="getcopyclipcount" type="method" display="GetCopyClipCount"/><memberdata name="getcopyclipfromcursor" type="method" display="GetCopyClipFromCursor"/><memberdata name="getcopycliplist" type="method" display="GetCopyClipList"/></VFPData>

copyclipform = .NULL.
Name = "copyclipmgr"
   %   �      �  �   �  �LaI�   �  U  � ��  � � �+ �� � � � � � �	 �
 � � � �� � � �� ���� T� ��  �� T� �C�� �  a���� T� �� �� �� ���(�� ��;�  T� �CC � � �C�	 �  ��� H�� ��� �C� �=� *��� %�� � ��� � T� �� �� �� T� �� ��� �� .� � �C� ���C� T� �� ��� �� .�? �CC� �=f� DEFINE CLASS� CC� �	=f�	 DEF CLASS���� %�� � ���� T� ���� ��� T� �� �� �` �CCC� �=f� PROTECTED FUNC� PROTECTED PROC��% CCC� �	=f�	 PROT FUNC�	 PROT PROC���N� %�� � ��5� T� ���� �J� T� �� �� �L �CCC� �=f� FUNCTION� PROCEDUR�� CCC� �=f� FUNC � PROC ����� %�� � ���� T� ���� ��� T� �� �� �" �CCC� �=f� IF � TRY����� T� ����+ �CCC� �=f� FOR � SCAN� TEXT���7� T� ���� �CC� �=f� WITH ��a� T� ����* �CCC� �=f� DO WHIL� PRINTJO����� %�� � ���� T� ���� ��� T� �� �� � �CC� �=f� ELSE���� T� ���� T� �� ��� �CC� �=f� CATCH��6� T� ���� T� �� ��� �CC� �=f� FINALLY��s� T� ���� T� �� ��� �CC� �=f� DO CASE���� %�� � ���� T� ���� ��� T� �� �� � T�	 �-�� �CC� �=f� CASE��)� T� ���� %��	 ��� T� �� ��� � T�	 �a��! �CC� �	=f�	 OTHERWISE��h� T� ���� T� �� ��� �CC� �=f� NEXT���� T� �� �� T� �� ���& �CCC� �=f� ENDDO� ENDIF����� T� �� �� T� �� ���# �CC� �=f� ENDPRINTJOB��'� T� �� �� T� �� ���1 �CCC� �=f� ENDTRY� ENDFOR� ENDDEF���v� T� �� �� T� �� ��� �CC� �=f� ENDCASE���� T� �� �� %�� � ���� T� �� ��� ��� T� �� ��� �4 �CCC� �=f� ENDTEXT� ENDSCAN� ENDWITH���2� T� �� �� T� �� ���* �CCC� �=f� ENDFUNC� ENDPROC����� T� �� �� %�� � ���� T� �� ��� � 2��� T� �� �� � %�� � ���� T� �� �� �" T� �� ��CC�	 � Q� � �� T� �� � �� %�C� �R� ;��"� T� �C�	 �� �7� T� ��  �� � �� %�� � ���
� �� ���(�� ���
� T�
 �C� &� &C � � ��� %��
 � ���
� T� �� �� T� ���� +�a��.	�  %�CC � � � �\C�	 ���� T� �� ��� � T� �� ���& %�� CC � � >� � � � ��*	� !� � �% T� �� � �
 � � � ��� H�d	��
� �� � ���
� T� �C� �� T� �� ��" �� ��
 ��(�����������	�  %�CC � � � �\C�X���	� T� �� ��� ��	� !� � �� %�� ����
� %�� � ���E
�' T� �� ��CC � � �
 � � �  [�� ��
� T� �� ���' T� �� ��CC � � �
 � � �  [�� � � �� � ���
�- T� �� ��CC � � �
 �� C�  � Q[�� � � �� � %�� � ���5� �� ���(�� ��1�+ T� �� ��CC � � C�	 C�  � � Q��� �� � %�C� ��� %�� � ����� �� ���(�� ����- T� �� ��CC � � � � � KEYWORDS� �� �� � %�� � ���� �� ���(�� ����, T� �� ��CC � � � � � SYMBOLS� �� �� � Q� � � T� ��  �� �� ���(�� ���\�" T� �� C � � C� C�
 �� �� T� �� C � � ��	 B�� �� U 
 TCCODETEXT
 TOBEAUTIFY	 TNTABSIZE
 LNNUMLINES LNLINE
 LCCODETEXT LNTAB LCCODEBEAUTIFY LNTABINC LLDOCASE LNPOS LNADJ LNSPACE LNCHR
 LCCONTINUE LCCODELINES COMMENTINDENT INDENTDEFINE
 INDENTPROC
 INDENTCASE ALIGNCOMMENT ALIGNCOMMENTCOL TABSIZE TABCHR GKKOPENFDKEYWRD KEYWORDS FSETCASE SYMBOLS FDKEYWRD ��  � � � �� � � � �. T� �� !@#$%&*()-+={}<,>.?/;C�XC�	 �� T� ���� T� ����  %�C�  �C�	 �  �� *��o� +�� C�  >��k� %�C�  � �\� &� &��� � !� �# %�CC�  � �\� "� '� [���M� +�� C�  >��I� T� �� ���# %�CC�  � �\� "� '� ]���E� T� �� ��� !� � � � %�C�  � �\� 
��N� T� �� ��� +�� C�  >���� %�C�  � �\� ���� !� � T� �� ��� � T� �C�  � � � \�� H���y� �� � KEYWORDS��4�. -�CC� � f�CC� f�� C� �	 � M� P�
	�� �� � SYMBOLS��y�- -�CC� � f�CC� f�� C� �	 � M� P�	�� � %�C4��9� H���� �� ����� T� �C� f�� �� ����� T� �C� @�� �� ����� T� �C� � ��� �� ���� T� �C� ��� � T�  �C�  � � � � [�� � T� �� ��� �g� T� �� ��� � � �	 B��  �� U
 
 TCCODELINE
 TNBEAUTIFY TCMODE LNBEG LNEND LCTOKEN LCDELIMITERS FDKEYWRD TOKEN CODE GKKBeautifyText,     �� fSetCase�    ��= � �� � � a� q� q� � 1A A � 1A �� � � A � � � A �� � � A "� �� �� �� � � A �� �� �� �� � � A � �� � A � � �� b� 2� � �� � A B� �� A � � A � A !q� � � A A q�� � � A aA A A R� � � !� A A A Qq� qA A �A A A A Bq�A A � Bq�A A Bq�A A � A � �!A a� 7 � 1�� � A�A A 2A1A A A A �A�A A A �� ����A � � � � !� A �A � A A A � 1                    T  >     �   �  �  �     %   B�      g�  b  ��  bN�@�   �  U  8 5 B�CC�Jg�@B CC�Jg�'CC�Jg�dCC�	Jg�� U  E ��  � � � �� � � H�' ���" �C�  ��� C�
 C�  >� ��z �( R,:�� apiSUBSTR: Invalid parameters��	 B��  ��  �C�t�� C� ��� N	��� � T� �C�  >� ��/ �C�t�� C� ��� N	� C� ��� N	���� H�� ��� �C�  >� ��	� T� ���� �C�  >� � ��3� T� �C�  >� �� �C�  >� ����E R,:��: apiSUBSTR: Invalid parameters (tnBeg is outside of string)��	 B��  �� � 2���( R,:�� apiSUBSTR: Invalid parameters��	 B��  �� � T� �CC� � C�  >� �� ��C�(
� C�  >�  ]�� T� �C�(
� � �� ]�� ��CC� �  � � ��	 B�� �� U  TCSTRING TNBEG TNLEN LNADDR LCSUBSTR APIHEAPALLOC APIGETPROCESSHEAP APIHEAPFREE ��  � �� � �" %�C�  ��� C�
 C�  >� ��c �( R,:�� apiSUBSTR: Invalid parameters�� B���� � ��� � T� �C� Empty�N�� ��C� � SizeOfC�  >
��% ��C� � HandleCC� � C�  >� 
�� ��C�(
� � C�  >�  ]�� �(� �� T� ���� R,:�� � �� ��	 B�� �� U  TCSTRING LOEXCEPTION LOSTRING APIHEAPALLOC APIGETPROCESSHEAP HANDLE MESSAGEo  ��  � �� � %�C�  ��� O��* � B�-�� � ��CC� � �  � � �� T�  � �� �� T�  � �� �� B�a�� U  TOSTRING LCNAME APIHEAPFREE APIGETPROCESSHEAP HANDLE SIZEOFv ��  � � � H� �R�: �C�  ��� O� C�  � Handle��h
� �  � � ��� �, R,:��! apiSUBSTR: Memory not initialized��	 B��  ��: �C�  ��� O� C�  � SizeOf��h
� �  � � ��� �( R,:�� apiSUBSTR: Invalid parameters��	 B��  ��  �C�t�� C� ��� N	��*� T� ��  � � ��/ �C�t�� C� ��� N	� C� ��� N	��� H�f�� ��  � � ���� T� ���� ��  � � � ���� T� ��  � � �� ��  � � ���E R,:��: apiSUBSTR: Invalid parameters (tnBeg is outside of string)��	 B��  �� � 2�R�( R,:�� apiSUBSTR: Invalid parameters��	 B��  �� � B�C�(
�  � � �� ]�� U  TOSTRING TNBEG TNLEN HANDLE SIZEOF]  ��  � � �5 |�� RtlMoveMemory� WIN32APIQ�
 apiReadMem���� B�C�   �  � � �� U 	 OUTBUFFER INBUFFER
 BYTES2COPY RTLMOVEMEMORY WIN32API
 APIREADMEMH  ��  �0 |��
 GlobalFree� WIN32APIQ� apiGlobalFree�� B�C �  � �� U  NHMEM
 GLOBALFREE WIN32API APIGLOBALFREET  ��  � �4 |�� GlobalAlloc� WIN32APIQ� apiGlobalAlloc��� B�C �   � � �� U  NFLAGS NBYTES GLOBALALLOC WIN32API APIGLOBALALLOC\  ��  � � �4 |� RtlMoveMemory� kernel32Q� apiWriteMem���� B�C �   �  � � �� U 	 OUTBUFFER INBUFFER BYTES2WRITE RTLMOVEMEMORY KERNEL32 APIWRITEMEMH  ��  �0 |��
 GlobalSize� WIN32APIQ� apiGlobalSize�� B�C �  � �� U  NHMEM
 GLOBALSIZE WIN32API APIGLOBALSIZEn  ��  � � � �> |�� mciSendString�	 WinMM.DLLQ� apimciSendString����� B�C �  �  �  � � �� U 
 CMCISTRING
 CRETSTRING
 NRETLENGTH	 HINSTANCE MCISENDSTRING WINMM DLL APIMCISENDSTRINGl  ��  � � �D |�� mciGetErrorString�	 WINMM.DLLQ� apiMciGetErrorString���� B�C �  �  � � �� U  NERRORNO CBUFFER NBUFSIZE MCIGETERRORSTRING WINMM DLL APIMCIGETERRORSTRING`  ��  � �@ |�� SetFileAttributes� WIN32APIQ� apiSetFileAttributes��� B�C �   � � �� U 
 TCFILENAME TNFILEATTRIBUTES SETFILEATTRIBUTES WIN32API APISETFILEATTRIBUTESV  ��  �> |�� GetFileAttributes� WIN32APIQ� apiGetFileAttributes�� B�C �  � �� U 
 TCFILENAME GETFILEATTRIBUTES WIN32API APIGETFILEATTRIBUTESl  ��  � � � � �4 |�� LockFile� kernel32Q� apiLockFile������ B�C �   �  �  �  � � �� U  THFILE TDWFILEOFFSETLOW TDWFILEOFFSETHIGH TNNUMBEROFBYTESTOLOCKLOW TNNUMBEROFBYTESTOLOCKHIGH LOCKFILE KERNEL32 APILOCKFILEp  ��  � � � � �8 |��
 UnlockFile� kernel32Q� apiUnlockFile������ B�C �   �  �  �  � � �� U  THFILE TDWFILEOFFSETLOW TDWFILEOFFSETHIGH TNNUMBEROFBYTESTOUNLOCKLOW TNNUMBEROFBYTESTOUNLOCKHIGH
 UNLOCKFILE KERNEL32 APIUNLOCKFILEY  ��  � � �1 |�� OpenFile� kernel32Q� apiOpenFile���� B�C �  �  � � �� U  TLPFILENAME TLPREOPENBUFF TWSTYLE OPENFILE KERNEL32 APIOPENFILEH  ��  �0 |�� CloseHandle� kernel32Q� apiCloseFile�� B�C �  � �� U  THOBJECT CLOSEHANDLE KERNEL32 APICLOSEFILEX  ��  � � �0 |�� CopyFile� Win32APIQ� apiCopyFile���� B�C �   �  � � �� U  TCSOURCEFILENAME TCDESTFILENAME TLFAILIFEXISTS COPYFILE WIN32API APICOPYFILEN  ��  � �. |�� MoveFile� Win32APIQ� apiMoveFile��� B�C �   � � �� U  TCSOURCEFILENAME TCDESTFILENAME MOVEFILE WIN32API APIMOVEFILEY  ��  � � �1 |�� OpenFile� Kernel32Q� apiOpenFile���� B�C �  �  � � �� U 
 LPFILENAME O_LPREOPENBUFF USTYLE OPENFILE KERNEL32 APIOPENFILE�  ��  � � � � � �P |�� DocumentProperties� winspool.drvQ� apiDocumentProperties�������" B�C �   �  � � �  � �	 �� U
  LHWND	 LHPRINTER PCPRINTERNAME LCDEVMODEOUTPUT LCDEVMODEINPUT LNMODE DOCUMENTPROPERTIES WINSPOOL DRV APIDOCUMENTPROPERTIES�  ��  � � � � �M |�� DeviceCapabilities� winspool.drvQ� apiDeviceCapabilities������ B�C �   �  � �  � � �� U	  PDEVICE PPORT FWCAPABILITY POUTPUT PDEVMODE DEVICECAPABILITIES WINSPOOL DRV APIDEVICECAPABILITIES~  ��  � � � � � �> |��	 EnumForms� winspool.drvQ� apiEnumForms�������" B�C �   �  �  � � � �	 �� U
 	 THPRINTER TNLEVEL TNFORM TNBUF TNNEEDED
 TNRETURNED	 ENUMFORMS WINSPOOL DRV APIENUMFORMSP  ��  �8 |�� ClosePrinter� winspool.drvQ� apiClosePrinter�� B�C �  � �� U 	 LHPRINTER CLOSEPRINTER WINSPOOL DRV APICLOSEPRINTERc  ��  � � �; |�� OpenPrinter� winspool.drvQ� apiOpenPrinter���� B�C �  �  � � �� U  PCPRINTERNAME	 LHPRINTER	 LNDEFAULT OPENPRINTER WINSPOOL DRV APIOPENPRINTER[  ��  � � �3 |�� AddForm� winspool.drvQ�
 apiAddForm���� B�C �   �  � � �� U 	 THPRINTER TNLEVEL TCFORM ADDFORM WINSPOOL DRV
 APIADDFORMV  ��  � �6 |��
 DeleteForm� winspool.drvQ� apiDeleteForm��� B�C �   � � �� U 	 THPRINTER TCFORM
 DELETEFORM WINSPOOL DRV APIDELETEFORMN  ��  � �. |�� StartDoc� Win32APIQ� apiStartDoc��� B�C �   � � �� U  HDC LPDI STARTDOC WIN32API APISTARTDOC@  ��  �( |�� EndDoc� Win32APIQ�	 apiEndDoc�� B�C �  � �� U  HDC ENDDOC WIN32API	 APIENDDOCB  ��  �* |�� EndPage� Win32APIQ�
 apiEndPage�� B�C �  � �� U  HDC ENDPAGE WIN32API
 APIENDPAGEF  ��  �. |��	 StartPage� Win32APIQ� apiStartPage�� B�C �  � �� U  HDC	 STARTPAGE WIN32API APISTARTPAGED  ��  �, |�� AbortDoc� Win32APIQ� apiAbortDoc�� B�C �  � �� U  HDC ABORTDOC WIN32API APIABORTDOCP  ��  �8 |�� CoCreateGuid��	 OLE32.dll�Q� apiCoCreateGuid�� B�C�  � �� U  TPGUID COCREATEGUID APICOCREATEGUIDj  ��  � � �B |�� StringFromGUID2��	 OLE32.dll�Q� apiStringFromGUID2���� B�C �  �  � � �� U  TRGUID TPSZ TCHMAX STRINGFROMGUID2 APISTRINGFROMGUID2a  ��  �I |�� UuidCreateSequential��
 RPCRT4.dll�Q� apiUuidCreateSequential�� B�C�  � �� U  TUUID UUIDCREATESEQUENTIAL APIUUIDCREATESEQUENTIAL]  ��  � �= |�� UuidFromString�
 rpcrt4.DLLQ� apiUuidFromString��� B�C �  � � �� U  TSSTRINGUUID TSGUID UUIDFROMSTRING RPCRT4 DLL APIUUIDFROMSTRINGj  ��  � � �B |�� GdiplusStartup� GDIPLUS.DLLQ� apiGdiplusStartup���� B�C�  � � � �� U  TNTOKEN PCINPUT TNOUTPUT GDIPLUSSTARTUP GDIPLUS DLL APIGDIPLUSSTARTUPU  ��  �= |�� GdiplusShutdown� GDIPLUS.DLLQ� apiGdiplusShutdown�� B�C �  � �� U  TNTOKEN GDIPLUSSHUTDOWN GDIPLUS DLL APIGDIPLUSSHUTDOWNx  ��  � �X |�� GdipGetImageGraphicsContext� GDIPLUS.DLLQ� apiGdipGetImageGraphicsContext��� B�C �  � � �� U  TNIMAGE
 TNGRAPHICS GDIPGETIMAGEGRAPHICSCONTEXT GDIPLUS DLL APIGDIPGETIMAGEGRAPHICSCONTEXTd  ��  � �D |�� GdipCreateFromHDC� GdiPlus.DLLQ� apiGdipCreateFromHDC��� B�C �  � � �� U  HDC
 TNGRAPHICS GDIPCREATEFROMHDC GDIPLUS DLL APIGDIPCREATEFROMHDC[  ��  �C |�� GdipDeleteGraphics� GDIPLUS.DLLQ� apiGdipDeleteGraphics�� B�C �  � �� U  TNIMAGE GDIPDELETEGRAPHICS GDIPLUS DLL APIGDIPDELETEGRAPHICSq  ��  � �Q |�� GdipSetTextRenderingHint� GDIPLUS.DLLQ� apiGdipSetTextRenderingHint��� B�C �   � � �� U 
 TNGRAPHICS TNTEXTRENDERINGHINT GDIPSETTEXTRENDERINGHINT GDIPLUS DLL APIGDIPSETTEXTRENDERINGHINT� ' ��  � � � � � � � � �T |�� GdipMeasureString� GDIPLUS.DLLQ� apiGdipMeasureString����������. B�C �   �  �  �  �  � � � � � �� U 
 TNGRAPHICS	 PCUNICODE TNLENGTH TNFONT PCLAYOUTRECT TNSTRINGFORMAT	 PCRECTOUT TNCHARS TNLINES GDIPMEASURESTRING GDIPLUS DLL APIGDIPMEASURESTRING�  ��  � � � � � � �H |�� GdipDrawString� GDIPLUS.DLLQ� apiGdipDrawString��������& B�C �   �  �  � �  �  � �
 �� U 
 TNGRAPHICS
 TCWIDECHAR TNLENGTH TNFNT TCRECTF TNSTRINGFORMAT TNBRUSH GDIPDRAWSTRING GDIPLUS DLL APIGDIPDRAWSTRING� ; ��  � � � � � � � � �	 �
 � � � �c |�� GdipDrawImageRectRect� GDIPLUS.DLLQ� apiGdipDrawImageRectRect���������������B B�C �   �  �  �  �  �  �  �  �  �	  �
  �  �  � � �� U 
 TNGRAPHICS TNIMAGE TNDSTX TNDSTY
 TNDSTWIDTH TNDSTHEIGHT TNSRCX TNSRCY
 TNSRCWIDTH TNSRCHEIGHT	 TNSRCUNIT TNIMAGEATTRIBUTES
 TNCALLBACK TNCALLBACKDATA GDIPDRAWIMAGERECTRECT GDIPLUS DLL APIGDIPDRAWIMAGERECTRECTo  ��  � � � �? |�� GdipDrawImage� GDIPLUS.DLLQ� apiGdipDrawImage����� B�C �   �  �  � � �� U 
 TNGRAPHICS TNIMAGE TNX TNY GDIPDRAWIMAGE GDIPLUS DLL APIGDIPDRAWIMAGE�  ��  � � � � � �K |�� GdipFillRectangle� GDIPLUS.DLLQ� apiGdipFillRectangle�������" B�C �   �  �  �  �  � �	 �� U
 
 TNGRAPHICS TNBRUSH TNX TNY TNWIDTH TNHEIGHT GDIPFILLRECTANGLE GDIPLUS DLL APIGDIPFILLRECTANGLE�  ��  � � � � � �K |�� GdipDrawImageRect� GDIPLUS.DLLQ� apiGdipDrawImageRect�������" B�C �   �  �  �  �  � �	 �� U
 
 TNGRAPHICS TNIMAGE TNX TNY
 TNIMGWIDTH TNIMGHEIGHT GDIPDRAWIMAGERECT GDIPLUS DLL APIGDIPDRAWIMAGERECT�  ��  � � � � � �\ |�� GdipCreateBitmapFromScan0� GDIPLUS.DLLQ� apiGdipCreateBitmapFromScan0�������" B�C �   �  �  �  � � �	 �� U
  TNWIDTH TNHEIGHT TNSTRIDE TNPIXELFORMAT TNSCAN0 TNIMAGE GDIPCREATEBITMAPFROMSCAN0 GDIPLUS DLL APIGDIPCREATEBITMAPFROMSCAN0�  ��  � � � � � �M |�� GdipDrawImageRectI� GdiPlus.dllQ� apiGdipDrawImageRectI�������" B�C �   �  �  �  �  � �	 �� U
 	 PGRAPHICS PIMAGE NX NY NWIDTH NHEIGHT GDIPDRAWIMAGERECTI GDIPLUS DLL APIGDIPDRAWIMAGERECTIq  ��  � � � �A |�� GdipDrawImageI� GdiPlus.DLLQ� apiGdipDrawImageI����� B�C �   �  �  � � �� U 	 PGRAPHICS PIMAGE NX NY GDIPDRAWIMAGEI GDIPLUS DLL APIGDIPDRAWIMAGEIl  ��  � �L |�� GdipLoadImageFromFile� GDIPLUS.DLLQ� apiGdipLoadImageFromFile��� B�C �  � � �� U 
 PCFILENAME TNIMAGE GDIPLOADIMAGEFROMFILE GDIPLUS DLL APIGDIPLOADIMAGEFROMFILE{  ��  � � � �K |�� GdipSaveImageToFile� GDIPLUS.DLLQ� apiGdipSaveImageToFile����� B�C �   �  �  � � �� U  TNIMAGE
 PCFILENAME PCCLSIDENCODER TNENCODERPARAMS GDIPSAVEIMAGETOFILE GDIPLUS DLL APIGDIPSAVEIMAGETOFILEW  ��  �? |�� GdipDisposeImage� GDIPLUS.DLLQ� apiGdipDisposeImage�� B�C �  � �� U  TNIMAGE GDIPDISPOSEIMAGE GDIPLUS DLL APIGDIPDISPOSEIMAGEz  ��  � � � �J |�� GdipBitmapGetPixel� GDIPLUS.DLLQ� apiGdipBitmapGetPixel����� B�C �   �  � � � �� U  TNBITMAP TNX TNY TNARGB GDIPBITMAPGETPIXEL GDIPLUS DLL APIGDIPBITMAPGETPIXELd  ��  � �D |�� GdipGetImageWidth� GDIPLUS.DLLQ� apiGdipGetImageWidth��� B�C �  � � �� U  TNIMAGE TNWIDTH GDIPGETIMAGEWIDTH GDIPLUS DLL APIGDIPGETIMAGEWIDTHf  ��  � �F |�� GdipGetImageHeight� GDIPLUS.DLLQ� apiGdipGetImageHeight��� B�C �  � � �� U  TNIMAGE TNHEIGHT GDIPGETIMAGEHEIGHT GDIPLUS DLL APIGDIPGETIMAGEHEIGHT�  ��  � � �Z |�� GdipCreateHBITMAPFromBitmap� GdiPlus.dllQ� apiGdipCreateHBITMAPFromBitmap���� B�C �  �  � � �� U  TNIMAGE TNHEIGHT NARGB GDIPCREATEHBITMAPFROMBITMAP GDIPLUS DLL APIGDIPCREATEHBITMAPFROMBITMAPp  ��  � �P |�� GdipGetImagePixelFormat� GdiPlus.dllQ� apiGdipGetImagePixelFormat��� B�C �  � � �� U  PIMAGE NPIXELFORMAT GDIPGETIMAGEPIXELFORMAT GDIPLUS DLL APIGDIPGETIMAGEPIXELFORMATj  ��  �R |�� GdipCreateImageAttributes� GDIPLUS.DLLQ� apiGdipCreateImageAttributes�� B�C�  � �� U  TNIMAGEATTR GDIPCREATEIMAGEATTRIBUTES GDIPLUS DLL APIGDIPCREATEIMAGEATTRIBUTES�  ��  � � � � �g |��  GdipSetImageAttributesRemapTable� GDIPLUS.DLLQ�# apiGdipSetImageAttributesRemapTable������ B�C �   �  �  �  � � �� U	  TNIMAGEATTR TNCOLORADJUSTTYPE TNENABLEFLAG	 TNMAPSIZE
 PCCOLORMAP  GDIPSETIMAGEATTRIBUTESREMAPTABLE GDIPLUS DLL# APIGDIPSETIMAGEATTRIBUTESREMAPTABLE�  ��  � � � � � �k |��! GdipSetImageAttributesColorMatrix� GDIPLUS.DLLQ�$ apiGdipSetImageAttributesColorMatrix�������" B�C �   �  �  �  �  � �	 �� U
  TNIMAGEATTR TNTYPE TNENABLEFLAG PCCOLORMATRIX TNGRAYMATRIX TNFLAGS! GDIPSETIMAGEATTRIBUTESCOLORMATRIX GDIPLUS DLL$ APIGDIPSETIMAGEATTRIBUTESCOLORMATRIXk  ��  �S |�� GdipDisposeImageAttributes� GDIPLUS.DLLQ� apiGdipDisposeImageAttributes�� B�C �  � �� U  TNIMAGEATTR GDIPDISPOSEIMAGEATTRIBUTES GDIPLUS DLL APIGDIPDISPOSEIMAGEATTRIBUTESx  ��  � � �P |�� GdipCreateStringFormat� GDIPLUS.DLLQ� apiGdipCreateStringFormat���� B�C �   � � � �� U  TNFORMATATTRIBUTES
 TNLANGUAGE TNFMT GDIPCREATESTRINGFORMAT GDIPLUS DLL APIGDIPCREATESTRINGFORMATc  ��  �K |�� GdipDeleteStringFormat� GDIPLUS.DLLQ� apiGdipDeleteStringFormat�� B�C �  � �� U  TNSTRINGFORMAT GDIPDELETESTRINGFORMAT GDIPLUS DLL APIGDIPDELETESTRINGFORMAT  ��  � �_ |�� GdipSetStringFormatHotkeyPrefix� GDIPLUS.DLLQ�" apiGdipSetStringFormatHotkeyPrefix��� B�C �   � � �� U 
 TNGRAPHICS TNHOTKEYPREFIX GDIPSETSTRINGFORMATHOTKEYPREFIX GDIPLUS DLL" APIGDIPSETSTRINGFORMATHOTKEYPREFIX�  ��  �j |��% GdipStringFormatGetGenericTypographic� GDIPLUS.DLLQ�( apiGdipStringFormatGetGenericTypographic�� B�C�  � �� U  TNHANDLE% GDIPSTRINGFORMATGETGENERICTYPOGRAPHIC GDIPLUS DLL( APIGDIPSTRINGFORMATGETGENERICTYPOGRAPHIC|  ��  � � � � �D |�� GdipCreateFont� GDIPLUS.DLLQ� apiGdipCreateFont������ B�C �   �  �  � � � �� U	  TNFONTFAMILY TNEMSIZE TNFONTSTYLE TNUNIT TNFONT GDIPCREATEFONT GDIPLUS DLL APIGDIPCREATEFONT�  ��  � � �\ |�� GdipCreateFontFamilyFromName� GDIPLUS.DLLQ� apiGdipCreateFontFamilyFromName���� B�C �   � � � �� U  PCFAMILYNAME TNFONTCOLLECTION TNFONTFAMILY GDIPCREATEFONTFAMILYFROMNAME GDIPLUS DLL APIGDIPCREATEFONTFAMILYFROMNAMES  ��  �; |�� GdipDeleteFont� GDIPLUS.DLLQ� apiGdipDeleteFont�� B�C �  � �� U  TNFONT GDIPDELETEFONT GDIPLUS DLL APIGDIPDELETEFONT_  ��  �G |�� GdipDeleteFontFamily� GDIPLUS.DLLQ� apiGdipDeleteFontFamily�� B�C �  � �� U  TNFONTFAMILY GDIPDELETEFONTFAMILY GDIPLUS DLL APIGDIPDELETEFONTFAMILYh  ��  � �H |�� GdipCreateSolidFill� GDIPLUS.DLLQ� apiGdipCreateSolidFill��� B�C �  � � �� U  TNCOLOR TNBRUSH GDIPCREATESOLIDFILL GDIPLUS DLL APIGDIPCREATESOLIDFILL�  ��  � � � � � � �T |�� GdipCreateLineBrushI� GDIPLUS.DLLQ� apiGdipCreateLineBrushI��������& B�C �   �  �  �  �  � � �
 �� U  PCPOINT1 PCPOINT2 TNCOLOR1 TNCOLOR2 TNMODE
 TNWRAPMODE TNLINEGRADIENT GDIPCREATELINEBRUSHI GDIPLUS DLL APIGDIPCREATELINEBRUSHI�  ��  � � � � � �a |�� GdipCreateLineBrushFromRect� GDIPLUS.DLLQ� apiGdipCreateLineBrushFromRect�������" B�C�   �  �  �  � � �	 �� U
  TNRECT TNCOLOR1 TNCOLOR2 TNMODE TNWRAPMD TNLINEGRADIENT GDIPCREATELINEBRUSHFROMRECT GDIPLUS DLL APIGDIPCREATELINEBRUSHFROMRECT�  ��  � � � � � �c |�� GdipCreateLineBrushFromRectI� GDIPLUS.DLLQ� apiGdipCreateLineBrushFromRectI�������" B�C�   �  �  �  � � �	 �� U
  TNRECT TNCOLOR1 TNCOLOR2 TNMODE
 TNWRAPMODE TNLINEGRADIENT GDIPCREATELINEBRUSHFROMRECTI GDIPLUS DLL APIGDIPCREATELINEBRUSHFROMRECTI�  ��  � � � �Q |�� GdipSetLinePresetBlend� GDIPLUS.DLLQ� apiGdipSetLinePresetBlend����� B�C �   �  �  � � �� U  TNBRUSH TNBLEND PCPOSITIONS TNCOUNT GDIPSETLINEPRESETBLEND GDIPLUS DLL APIGDIPSETLINEPRESETBLENDU  ��  �= |�� GdipDeleteBrush� GDIPLUS.DLLQ� apiGdipDeleteBrush�� B�C �  � �� U  TNBRUSH GDIPDELETEBRUSH GDIPLUS DLL APIGDIPDELETEBRUSH^  ��  � �> |�� GdipCreatePath� GDIPLUS.DLLQ� apiGdipCreatePath��� B�C �  � � �� U  TNBRUSHMODE TNPATH GDIPCREATEPATH GDIPLUS DLL APIGDIPCREATEPATH�  ��  � � � � �O |�� GdipAddPathRectangle� GDIPLUS.DLLQ� apiGdipAddPathRectangle������ B�C �   �  �  �  � � �� U	  TNPATH TNX TNY TNWIDTH TNHEIGHT GDIPADDPATHRECTANGLE GDIPLUS DLL APIGDIPADDPATHRECTANGLE~  ��  � �^ |�� GdipCreatePathGradientFromPath� GDIPLUS.DLLQ�! apiGdipCreatePathGradientFromPath��� B�C �  � � �� U  TNPATH TNPOLYGRADIENT GDIPCREATEPATHGRADIENTFROMPATH GDIPLUS DLL! APIGDIPCREATEPATHGRADIENTFROMPATH}  ��  � �] |�� GdipSetPathGradientCenterColor� GDIPLUS.DLLQ�! apiGdipSetPathGradientCenterColor��� B�C �   � � �� U  TNBRUSH TNCOLORS GDIPSETPATHGRADIENTCENTERCOLOR GDIPLUS DLL! APIGDIPSETPATHGRADIENTCENTERCOLOR�  ��  � � �y |��* GdipSetPathGradientSurroundColorsWithCount� GDIPLUS.DLLQ�- apiGdipSetPathGradientSurroundColorsWithCount���� B�C �  � � � �� U  TNBRUSH TNARGB TNCOUNT* GDIPSETPATHGRADIENTSURROUNDCOLORSWITHCOUNT GDIPLUS DLL- APIGDIPSETPATHGRADIENTSURROUNDCOLORSWITHCOUNTS  ��  �; |�� GdipDeletePath� GDIPLUS.DLLQ� apiGdipDeletePath�� B�C �  � �� U  TNPATH GDIPDELETEPATH GDIPLUS DLL APIGDIPDELETEPATH: - |��
 CreateMenu� User32Q� apiCreateMenu�
 B�C� �� U 
 CREATEMENU USER32 APICREATEMENUH  ��  �0 |�� DrawMenuBar� User32Q� apiDrawMenuBar�� B�C �  � �� U 	 THWNDMENU DRAWMENUBAR USER32 APIDRAWMENUBAR@  ��  �( |�� GetMenu� User32Q�
 apiGetMenu�� B�C �  � �� U 	 THWNDMENU GETMENU USER32
 APIGETMENUV  ��  � �6 |�� GetSystemMenu� User32Q� apiGetSystemMenu��� B�C �   � � �� U 	 THWNDMAIN TBREVERT GETSYSTEMMENU USER32 APIGETSYSTEMMENUJ  ��  � �* |�� SetMenu� User32Q�
 apiSetMenu��� B�C �   � � �� U 	 THWNDMENU THMENU SETMENU USER32
 APISETMENUD 7 |�� CreatePopupMenu� User32Q� apiCreatePopupMenu�
 B�C� �� U  CREATEPOPUPMENU USER32 APICREATEPOPUPMENU>  ��  �& |�� IsMenu� User32Q�	 apiIsMenu�� B�C �  � �� U  THMENU ISMENU USER32	 APIISMENUH  ��  �0 |�� DestroyMenu� User32Q� apiDestroyMenu�� B�C �  � �� U  THMENU DESTROYMENU USER32 APIDESTROYMENUd  ��  � � � �4 |��
 AppendMenu� User32Q� apiAppendMenu����� B�C �   �  �  � � �� U  THMENU TUFLAGS TUIDNEWITEM
 TLPNEWITEM
 APPENDMENU USER32 APIAPPENDMENUn  ��  � � � � �6 |W�
 ModifyMenu� User32Q� apiModifyMenu������ B�C �   �  �  �  � � �� U  THMENU TNPOSID TNFLAGS TNNEWID TLPNEWID
 MODIFYMENU USER32 APIMODIFYMENUb  ��  � � �: |�� EnableMenuItem� User32Q� apiEnableMenuItem���� B�C �   �  � � �� U  THMENU TNITEMID TNFLAGS ENABLEMENUITEM USER32 APIENABLEMENUITEMS  ��  � �3 |�� GetMenuInfo� User32Q� apiGetMenuInfo��� B�C �  � � �� U  THMENU TLPCMI GETMENUINFO USER32 APIGETMENUINFOS  ��  � �3 |�� SetMenuInfo� User32Q� apiSetMenuInfo��� B�C �  � � �� U  THMENU TLPCMI SETMENUINFO USER32 APISETMENUINFOm  ��  � � � �= |�� GetMenuBarInfo� User32Q� apiGetMenuBarInfo����� B�C �   �  � � � �� U  TNHWND	 TIDOBJECT TIDITEM TLPMBI GETMENUBARINFO USER32 APIGETMENUBARINFOu  ��  � � � � �= |�� GetMenuString� User32Q� apiGetMenuString������ B�C �   � �  �  � � �� U  THMENU TUIDITEM	 TLPSTRING
 TNMAXCOUNT TUFLAG GETMENUSTRING USER32 APIGETMENUSTRINGo  ��  � � � �? |W� GetMenuItemRect� User32Q� apiGetMenuItemRect����� B�C �   �  � � � �� U 	 THWNDMENU THMENU TNITEM TLPITEMRECT GETMENUITEMRECT USER32 APIGETMENUITEMRECTR  ��  �: |�� GetMenuItemCount� User32Q� apiGetMenuItemCount�� B�C �  � �� U  THMENU GETMENUITEMCOUNT USER32 APIGETMENUITEMCOUNTV  ��  � �6 |�� GetMenuItemID� User32Q� apiGetMenuItemID��� B�C �   � � �� U  THMENU TNPOSID GETMENUITEMID USER32 APIGETMENUITEMIDo  ��  � � � �? |�� GetMenuItemInfo� User32Q� apiGetMenuItemInfo����� B�C �   �  � � � �� U  THMENU TUITEM TFBYPOSITION TLPMII GETMENUITEMINFO USER32 APIGETMENUITEMINFOn  ��  � � � �> |W� SetMenuItemInfo� User32Q� apiSetMenuItemInfo����� B�C �   �  �  � � �� U  THMENU TUITEM TFBYPOSITION TLPMII SETMENUITEMINFO USER32 APISETMENUITEMINFOr  ��  � � � �B |�� MenuItemFromPoint� User32Q� apiMenuItemFromPoint����� B�C �   �  �  � � �� U  TNHWND THMENU TNX TNY MENUITEMFROMPOINT USER32 APIMENUITEMFROMPOINT]  ��  � �= |�� GetMenuPosFromID� ShlwApiQ� apiGetMenuPosFromID��� B�C �   � � �� U  THMENU TNID GETMENUPOSFROMID SHLWAPI APIGETMENUPOSFROMID�  ��  � � � � � � �B |�� TrackPopupMenu� User32Q� apiTrackPopupMenu��������& B�C �   �  �  �  �  �  � �	 �� U
  THMENU TUFLAGS TNX TNY
 TNRESERVED TNHWND TPRCRECT TRACKPOPUPMENU USER32 APITRACKPOPUPMENUv  ��  � � � � � �6 |��	 LoadImage� User32Q� apiLoadImage�������" B�C �   �  �  �  �  � � �� U	  THINST	 TLPSZNAME TUTYPE
 TCXDESIRED
 TCYDESIRED TFULOAD	 LOADIMAGE USER32 APILOADIMAGEK  ��  �3 |�� GetCursorPos� User32Q� apiGetCursorPos�� B�C �  � �� U  TLPPOINT GETCURSORPOS USER32 APIGETCURSORPOSW  ��  � �7 |�� GetClientRect� User32Q� apiGetClientRect��� B�C �  � � �� U  TNHWND TLPRECT GETCLIENTRECT USER32 APIGETCLIENTRECT<  ��  �$ |�� GetDC� User32Q� apiGetDC�� B�C �  � �� U  TNHWND GETDC USER32 APIGETDCU  ��  �= |�� CreateCompatibleDC� GDI32Q� apiCreateCompatibleDC�� B�C �  � �� U  THDC CREATECOMPATIBLEDC GDI32 APICREATECOMPATIBLEDCq  ��  � � �I |�� CreateCompatibleBitmap� GDI32Q� apiCreateCompatibleBitmap���� B�C �   �  � � �� U  THDC TNWIDTH TNHEIGHT CREATECOMPATIBLEBITMAP GDI32 APICREATECOMPATIBLEBITMAPS  ��  � �3 |�� SelectObject� GDI32Q� apiSelectObject��� B�C �   � � �� U  THDC THOBJECT SELECTOBJECT GDI32 APISELECTOBJECTX  ��  � � �0 |��	 GetObject� GDI32Q� apiGetObject���� B�C �   � � � �� U  HGDIOBJ NBUFLEN THOBJECT	 GETOBJECT GDI32 APIGETOBJECTN  ��  � �. |��	 ReleaseDC� User32Q� apiReleaseDC��� B�C �   � � �� U  TNHWND THDC	 RELEASEDC USER32 APIRELEASEDCb  ��  � � � �2 |�� CreateDC� Win32APIQ� apiCreateDC����� B�C �   �  �  � � �� U  TPDRIVERNAME TPDEVICENAME TPOUTPUT	 TCDEVMODE CREATEDC WIN32API APICREATEDCA  ��  �) |�� DeleteDC� GDI32Q� apiDeleteDC�� B�C �  � �� U  THDC DELETEDC GDI32 APIDELETEDCI  ��  �1 |�� DeleteObject� GDI32Q� apiDeleteObject�� B�C �  � �� U  THDC DELETEOBJECT GDI32 APIDELETEOBJECTU  ��  � �5 |�� GetDeviceCaps� GDI32Q� apiGetDeviceCaps��� B�C �   � � �� U  THDC TNINDEX GETDEVICECAPS GDI32 APIGETDEVICECAPSR  ��  �: |�� GetSysColorBrush� User32Q� apiGetSysColorBrush�� B�C �  � �� U  TNINDEX GETSYSCOLORBRUSH USER32 APIGETSYSCOLORBRUSHO  ��  � �/ |��
 SetBkColor� GDI32Q� apiSetBkColor��� B�C �   � � �� U  THDC TCRCOLOR
 SETBKCOLOR GDI32 APISETBKCOLORQ  ��  �9 |�� CreateSolidBrush� GDI32Q� apiCreateSolidBrush�� B�C �  � �� U  TCRCOLOR CREATESOLIDBRUSH GDI32 APICREATESOLIDBRUSHM  ��  � �- |��	 SetBkMode� GDI32Q� apiSetBkMode��� B�C �   � � �� U  THDC TIBKMODE	 SETBKMODE GDI32 APISETBKMODEM  ��  �5 |�� GetStockObject� GDI32Q� apiGetStockObject�� B�C �  � �� U 	 TFNOBJECT GETSTOCKOBJECT GDI32 APIGETSTOCKOBJECTU  ��  �= |�� CreatePatternBrush� GDI32Q� apiCreatePatternBrush�� B�C �  � �� U  THBMP CREATEPATTERNBRUSH GDI32 APICREATEPATTERNBRUSHQ  ��  �9 |�� GdiSetBatchLimit� GDI32Q� apiGdiSetBatchLimit�� B�C �  � �� U  TDWLIMIT GDISETBATCHLIMIT GDI32 APIGDISETBATCHLIMITx  ��  � � � �H |�� GetTextExtentPoint32� GDI32Q� apiGetTextExtentPoint32����� B�C �   �  � � � �� U  THDC TCSTRING TNSTRLEN TPSIZE GETTEXTEXTENTPOINT32 GDI32 APIGETTEXTEXTENTPOINT32W  ��  � � �/ |�� FillRect� User32Q� apiFillRect���� B�C �  �  � � �� U  THDC TLPRECT THBRUSH FILLRECT USER32 APIFILLRECTk  ��  � � � � �3 |�� DrawText� User32Q� apiDrawText������ B�C �   �  � �  � � �� U  THDC	 TLPSTRING TNCOUNT TLPRECT TUFORMAT DRAWTEXT USER32 APIDRAWTEXT� # ��  � � � � � � � �= |��
 ExtTextOut� GDI32Q� apiExtTextOut���������* B�C �   �  �  � �  �  � � �
 �� U  THDC TNX TNY
 TFUOPTIONS TLSRECT TCTEXT	 TNTEXTLEN TLPADX
 EXTTEXTOUT GDI32 APIEXTTEXTOUTa  ��  � � � �1 |�� DrawEdge� User32Q� apiDrawEdge����� B�C �  �  �  � � �� U  THDC TLPRECT
 TNEDGETYPE TNBORDERTYPE DRAWEDGE USER32 APIDRAWEDGEW  ��  � � �/ |��	 CreatePen� GDI32Q� apiCreatePen���� B�C �   �  � � �� U  TFNPENSTYLE TNWIDTH TCRCOLOR	 CREATEPEN GDI32 APICREATEPENt  ��  � � � � �< |�� ExtCreatePen� Win32APIQ� apiExtCreatePen������ B�C �   �  �  �  � � �� U 
 DWPENSTYLE DWWIDTH LPLB DWSTYLECOUNT LPSTYLE EXTCREATEPEN WIN32API APIEXTCREATEPEN`  ��  � � � �0 |�� MoveToEx� GDI32Q� apiMoveToEx����� B�C �   �  �  � � �� U  THDC TNX TNY TLPPOINT MOVETOEX GDI32 APIMOVETOEXQ  ��  � � �) |�� LineTo� GDI32Q�	 apiLineTo���� B�C �   �  � � �� U  THDC TNENDX TNENDY LINETO GDI32	 APILINETOk  ��  � � � � �3 |��	 Rectangle� GDI32Q� apiRectangle������ B�C �   �  �  �  � � �� U  THDC
 TNLEFTRECT	 TNTOPRECT TNRIGHTRECT TNBOTTOMRECT	 RECTANGLE GDI32 APIRECTANGLE  ��  � � � � � � �7 |��	 RoundRect� GDI32Q� apiRoundRect��������& B�C �   �  �  �  �  �  � �	 �� U
  THDC
 TNLEFTRECT	 TNTOPRECT TNRIGHTRECT TNBOTTOMRECT TNWIDTHCURVE TNHEIGHTCURVE	 ROUNDRECT GDI32 APIROUNDRECTi  ��  � � � � �1 |�� SetRect� User32Q�
 apiSetRect������ B�C �   �  �  �  � � �� U  TLPRECT TNLEFT TNTOP TNRIGHT TNBOTTOM SETRECT USER32
 APISETRECT}  ��  � � � � � �= |�� GradientFill� MsImg32Q� apiGradientFill�������" B�C �   �  �  �  �  � � �� U	  THDC TPVERTEX TDWNUMVERTEX TPMESH
 TDWNUMMESH TDWMODE GRADIENTFILL MSIMG32 APIGRADIENTFILLU  ��  � � �- |�� GetPixel� GDI32Q� apiGetPixel���� B�C �   �  � � �� U  THDC TNXPOS TNYPOS GETPIXEL GDI32 APIGETPIXELa  ��  � � � �1 |��	 SetPixelV� GDI32Q� apiSetPixelV����� B�C �   �  �  � � �� U  THDC TNXPOS TNYPOS TNCOLOR	 SETPIXELV GDI32 APISETPIXELV� / ��  � � � � � � � � �	 �
 �K |�� TransparentBlt� MsImg32Q� apiTransparentBlt������������6 B�C �   �  �  �  �  �  �  �  �  �	  �
 � �� U  THDCDEST TNXDEST TNYDEST TNWIDTHDEST THHEIGHTDEST THDCSRC TNXSRC TNYSRC
 TNWIDTHSRC TNHEIGHTSRC TCRTRANSPARENT TRANSPARENTBLT MSIMG32 APITRANSPARENTBLT� ' ��  � � � � � � � � �5 |�� BitBlt� GDI32Q�	 apiBitBlt����������. B�C �   �  �  �  �  �  �  �  � � �� U  THDCDEST TNXDEST TNYDEST TNWIDTHDEST THHEIGHTDEST THDCSRC TNXSRC TNYSRC TDWROP BITBLT GDI32	 APIBITBLT� / ��  � � � � � � � � �	 �
 �C |��
 AlphaBlend� MsImg32Q� apiAlphaBlend������������6 B�C �   �  �  �  �  �  �  �  �  �	  �
 � �� U  THDCDEST TNXDEST TNYDEST TNWIDTHDEST TNHEIGHTDEST THDCSRC TNXSRC TNYSRC
 TNWIDTHSRC TNHEIGHTSRC TBLENDFUNCTION
 ALPHABLEND MSIMG32 APIALPHABLENDU  ��  �= |�� CreateFontIndirect� GDI32Q� apiCreateFontIndirect�� B�C �  � �� U 
 TLPLOGFONT CREATEFONTINDIRECT GDI32 APICREATEFONTINDIRECTY  ��  � �9 |�� ClientToScreen� User32Q� apiClientToScreen��� B�C �  � � �� U  TNHWND TLPPOINT CLIENTTOSCREEN USER32 APICLIENTTOSCREENY  ��  � �9 |�� ScreenToClient� User32Q� apiScreenToClient��� B�C �  � � �� U  TNHWND TLPPOINT SCREENTOCLIENT USER32 APISCREENTOCLIENTo  ��  � � � �? |�� MapWindowPoints� User32Q� apiMapWindowPoints����� B�C �   � �  � � �� U 	 THWNDFROM THWNDTO TCPOINTS TNPOINTCOUNTS MAPWINDOWPOINTS USER32 APIMAPWINDOWPOINTSW  ��  � � �/ |�� PtInRect� User32Q� apiPtInRect���� B�C�   �  � � �� U  TLPRECT TNX TNY PTINRECT USER32 APIPTINRECTD  ��  �, |��	 SetCursor� User32Q� apiSetCursor�� B�C �  � �� U  THCURSOR	 SETCURSOR USER32 APISETCURSORP  ��  � �0 |��
 LoadCursor� User32Q� apiLoadCursor��� B�C �   � � �� U 
 THINSTANCE
 TNCURSORID
 LOADCURSOR USER32 APILOADCURSORT  ��  � � �, |�� MulDiv� Kernel32Q�	 apiMulDiv���� B�C �   �  � � �� U  TNNUMBER TNNUMERATOR TNDENOMINATOR MULDIV KERNEL32	 APIMULDIV�  ��  � � � � � �G |�� CreateRoundRectRgn� GDI32Q� apiCreateRoundRectRgn�������" B�C �   �  �  �  �  � � �� U	 
 TNLEFTRECT	 TNTOPRECT TNRIGHTRECT TNBOTTOMRECT TNWIDTHELLIPSE TNHEIGHTELLIPSE CREATEROUNDRECTRGN GDI32 APICREATEROUNDRECTRGNU  ��  � �5 |�� SelectClipRgn� GDI32Q� apiSelectClipRgn��� B�C �   � � �� U  THDC THREGION SELECTCLIPRGN GDI32 APISELECTCLIPRGNA 4 |�� IsThemeActive� uxThemeQ� apiIsThemeActive�
 B�C� �� U  ISTHEMEACTIVE UXTHEME APIISTHEMEACTIVE]  ��  � � �5 |��
 RegOpenKey� Win32APIQ� apiRegOpenKey���� B�C �   � � � �� U  TNHKEY TCSUBKEY TNHANDLE
 REGOPENKEY WIN32API APIREGOPENKEY� # ��  � � � � � � � �G |�� RegEnumValue� Win32APIQ� apiRegEnumValue���������* B�C �   � � �  � � � � �
 �� U  TNHKEY TNINDEX TPSZVALUENAME TPDWSIZE
 TWRESERVED TPDWTYPE TPBDATA TPCBDATA REGENUMVALUE WIN32API APIREGENUMVALUEJ  ��  �2 |�� RegCloseKey� Win32APIQ� apiRegCloseKey�� B�C �  � �� U  TNHKEY REGCLOSEKEY WIN32API APIREGCLOSEKEY�  ��  � � � � � �G |�� RegQueryValueEx� Win32APIQ� apiRegQueryValueEx�������" B�C �   �  � � � � � �� U	  TNHKEY TPSZVALUENAME
 TWRESERVED TPDWTYPE TPBDATA TPCBDATA REGQUERYVALUEEX WIN32API APIREGQUERYVALUEEXa  ��  � � �9 |�� RegCreateKey� Win32APIQ� apiRegCreateKey���� B�C �   � � � �� U  TNHKEY TCSUBKEY TNHANDLE REGCREATEKEY WIN32API APIREGCREATEKEY^  ��  � �> |�� RegDeleteValue� Win32APIQ� apiRegDeleteValueINTEGER� B�C �   � � �� U  TNHKEY TCENTRY REGDELETEVALUE WIN32API APIREGDELETEVALUEINTEGER APIREGDELETEVALUE�  ��  � � � � � �@ |�� RegSetValueEx� Win32APIQ� apiRegSetValueEx�������" B�C �   �  �  �  �  � � �� U	  TNHKEY	 TPSZENTRY
 TWRESERVED TDWTYPE TPBDATA TCBDATA REGSETVALUEEX WIN32API APIREGSETVALUEEXx  ��  � � � � �@ |�� ExtractIconEx� shell32Q� apiExtractIconEx������ B�C�   � � �  � � �� U  TFILE	 ICONINDEX
 TICONLARGE
 TICONSMALL TNICONS EXTRACTICONEX SHELL32 APIEXTRACTICONEXH  ��  �0 |W� DestroyIcon� user32Q� apiDestroyIcon�� B�C �  � �� U  HICON DESTROYICON USER32 APIDESTROYICONs  ��  � � �K |�� ExtractAssociatedIcon� shell32Q� apiExtractAssociatedIcon���� B�C �  � � � �� U  THINST
 TPICONPATH TPIICON EXTRACTASSOCIATEDICON SHELL32 APIEXTRACTASSOCIATEDICON�  ��  � � � �U |�� OleCreatePictureIndirect� oleaut32Q� apiOleCreatePictureIndirect���.� B�C �  �  � � � �� U  TPICDESC TREFIID TFPICTUREOWNSHANDLE TIPIC OLECREATEPICTUREINDIRECT OLEAUT32 APIOLECREATEPICTUREINDIRECT�  ��  � � � �R |�� SHGetSpecialFolderPath� Shell32.DLLQ� apiSHGetSpecialFolderPath�����" B�C ��  ��  ��  �� � �� U 	 HWNDOWNER LPSZPATH NFOLDER IFCREATE SHGETSPECIALFOLDERPATH SHELL32 DLL APISHGETSPECIALFOLDERPATH^  ��  � �: |�� GetProcAddress� win32apiQ� apiGetProcAddress��� B�C ��   �� � �� U  HMODULE
 LPPROCNAME GETPROCADDRESS WIN32API APIGETPROCADDRESSL  ��  �2 |�� FreeLibrary� win32apiQ� apiFreeLibrary�� B�C ��  � �� U 
 HLIBMODULE FREELIBRARY WIN32API APIFREELIBRARYM  ��  �3 |�� GetCaretPos� win32apiQ� apiGetCaretPos�� B�C��  � �� U  LPPOINT GETCARETPOS WIN32API APIGETCARETPOSL  ��  �2 |�� CloseHandle� win32apiQ� apiCloseHandle�� B�C ��  � �� U  HOBJECT CLOSEHANDLE WIN32API APICLOSEHANDLEx  ��  � � � � �6 |�� ReadFile� win32apiQ� apiReadFile������( B�C ��  ��  �� ��  �� � �� U  HFILE LPBUFFER NNUMBEROFBYTESTOREAD LPNUMBEROFBYTESREAD LPOVERLAPPED READFILE WIN32API APIREADFILEj  ��  � �F |�� FileTimeToSystemTime� win32apiQ� apiFileTimeToSystemTime��� B�C ��   �� � �� U 
 LPFILETIME LPSYSTEMTIME FILETIMETOSYSTEMTIME WIN32API APIFILETIMETOSYSTEMTIME�  ��  � � � � � � �< |��
 CreateFile� win32apiQ� apiCreateFile��������4 B�C ��   ��  ��  ��  ��  ��  �� �	 �� U
 
 LPFILENAME DWDESIREDACCESS DWSHAREMODE LPSECURITYATTRIBUTES DWCREATIONDISPOSITION DWFLAGSANDATTRIBUTES HTEMPLATEFILE
 CREATEFILE WIN32API APICREATEFILE�  ��  � � � � �E |�� SetFilePointerEx� win32apiQ� apiSetFilePointerEx������( B�C ��   ��  �� ��  �� � �� U  HFILE IDISTANCETOMOVELOW IDISTANCETOMOVEHIGH LPNEWFILEPOINTER DWMOVEMETHOD SETFILEPOINTEREX WIN32API APISETFILEPOINTEREX]  ��  � �9 |�� GetFileSizeEx� win32apiQ� apiGetFileSizeEx��� B�C ��  �� � �� U  HFILE
 LPFILESIZE GETFILESIZEEX WIN32API APIGETFILESIZEEXy  ��  � � � � �7 |��	 WriteFile� win32apiQ� apiWriteFile������( B�C ��   ��  �� ��  �� � �� U  HFILE LPBUFFER NNUMBEROFBYTESTOWRITE LPNUMBEROFBYTESWRITTEN LPOVERLAPPED	 WRITEFILE WIN32API APIWRITEFILE}  ��  � � � � %�C�� ��� C��L �" B�C ��   ��  �� �� � �� �v �" B�C ��   ��  ��  �� � �� � U  NHWND MSG WPARAM LPARAM APISENDMESSAGESTRING APISENDMESSAGEINTEGERw  ��  � � � �? |�� SendMessage� win32apiQ� apiSendMessageInteger�����" B�C ��   ��  ��  �� � �� U  NHWND MSG WPARAM LPARAM SENDMESSAGE WIN32API APISENDMESSAGEINTEGERw  ��  � � � �? |�� SendMessage� win32apiQ� apiSendMessageString�����" B�C ��   ��  �� �� � �� U  NHWND MSG WPARAM LPARAM SENDMESSAGE WIN32API APISENDMESSAGESTRING�  ��  � � � � � �A |�� GetDateFormat� win32apiQ� apiGetDateFormat�������. B�C ��   ��  ��  �� ��  �� � �� U	  LOCALE DWFLAGS LPDATE LPFORMAT	 LPDATESTR CCHDATE GETDATEFORMAT WIN32API APIGETDATEFORMATI  ��  �/ |��
 UuidCreate� rpcrt4Q� apiUuidCreate�� B�C��  � �� U  UUID
 UUIDCREATE RPCRT4 APIUUIDCREATEO  ��  �5 |�� UuidCreateNil� rpcrt4Q� apiUuidCreateNil�� B�C��  � �� U  NIL_UUID UUIDCREATENIL RPCRT4 APIUUIDCREATENIL APIUUIDCREATEY  ��  � �5 |�� UuidToString� rpcrt4Q� apiUuidToString��� B�C ��  �� � �� U  UUID
 STRINGUUID UUIDTOSTRING RPCRT4 APIUUIDTOSTRINGH  ��  �. |��	 GetParent� win32apiQ� apiGetParent�� B�C ��  � �� U  NHWND	 GETPARENT WIN32API APIGETPARENTZ  ��  � �6 |�� GetScrollPos� win32apiQ� apiGetScrollPos��� B�C ��   �� � �� U  NWND NBAR GETSCROLLPOS WIN32API APIGETSCROLLPOSh  ��  � � �: |�� ShowScrollBar� win32apiQ� apiShowScrollBar���� B�C ��   ��  �� � �� U  NHWND WBAR BSHOW SHOWSCROLLBAR WIN32API APISHOWSCROLLBARZ  ��  � �6 |�� EnableWindow� win32apiQ� apiEnableWindow��� B�C ��   �� � �� U  NHWND BENABLE ENABLEWINDOW WIN32API APIENABLEWINDOWt  ��  � � � �< |�� SetScrollInfo� win32apiQ� apiSetScrollInfo�����" B�C ��   ��  ��  �� � �� U  NHWND FNBAR LPSI FREDRAW SETSCROLLINFO WIN32API APISETSCROLLINFO� 3 ��  � � � � � � � � �	 �
 � �N |�� CreateWindowEx� win32apiQ� apiCreateWindowEx�������������R B�C ��   ��  ��  ��  ��  ��  ��  ��  ��  ��	  ��
  �� � �� U 	 DWEXSTYLE LPCLASSNAME LPWINDOWNAME DWSTYLE NX NY NWIDTH NHEIGHT NHWNDPARENT HMENU	 HINSTANCE LPPARAM CREATEWINDOWEX WIN32API APICREATEWINDOWEX�  ��  � � � %�C� �
  ��{ �; |�� SetWindowTheme� uxthemeQ� apiSetWindowTheme���� B�C ��   ��  �� � �� �� �	 B�� �� � U  NHWND PSZSUBAPPNAME PSZSUBIDLIST CTLGETOSVERSION SETWINDOWTHEME UXTHEME APISETWINDOWTHEMEx  ��  � � � �@ |�� GetScrollRange� win32apiQ� apiGetScrollRange�����" B�C ��   �� �� �� � �� U  NHWND NBAR LPMINPOS LPMAXPOS GETSCROLLRANGE WIN32API APIGETSCROLLRANGE�  ��  � � %�C� �
  ��m �7 |�� OpenThemeData� uxthemeQ� apiOpenThemeData��� B�C ��   �� � �� �~ �	 B�� �� � U  NHWND PSZCLASSLIST CTLGETOSVERSION OPENTHEMEDATA UXTHEME APIOPENTHEMEDATA�  ��  � � � � � %�C� �
  ��� �> |�� GetThemeColor� uxthemeQ� apiGetThemeColor������( B�C ��   ��  ��  �� �� � �� �� �	 B���� � U	  HTHEME IPARTID ISTATEID IPROPID PCOLOR CTLGETOSVERSION GETTHEMECOLOR UXTHEME APIGETTHEMECOLOR{  ��  � %�C� �
  ��c �7 |�� CloseThemeData� uxthemeQ� apiCloseThemeData�� B�C ��  � �� �t �	 B�� �� � U  HTHEME CTLGETOSVERSION CLOSETHEMEDATA UXTHEME APICLOSETHEMEDATA@ 3 |�� GetTickCount� win32apiQ� apiGetTickCount�
 B�C� �� U  GETTICKCOUNT WIN32API APIGETTICKCOUNTf  ��  � � �8 |�� SetWindowRgn� win32apiQ� apiSetWindowRgn���� B�C ��   ��  �� � �� U  NHWND HRGN BREDRAW SETWINDOWRGN WIN32API APISETWINDOWRGNt  ��  � � � �< |�� CreateRectRgn� win32apiQ� apiCreateRectRgn�����" B�C ��   ��  ��  �� � �� U  X1 Y1 X2 Y2 CREATERECTRGN WIN32API APICREATERECTRGNP  ��  �6 |�� DestroyWindow� win32apiQ� apiDestroyWindow�� B�C ��  � �� U  NHWND DESTROYWINDOW WIN32API APIDESTROYWINDOWF 9 |�� GetActiveWindow� win32apiQ� apiGetActiveWindow�
 B�C� �� U  GETACTIVEWINDOW WIN32API APIGETACTIVEWINDOWn  ��  � � � �6 |��
 LoadString� win32apiQ� apiLoadString�����" B�C ��   �� ��  �� � �� U 	 HINSTANCE UID LPBUFFER
 NBUFFERMAX
 LOADSTRING WIN32API APILOADSTRINGT  ��  �: |�� GetModuleHandle� win32apiQ� apiGetModuleHandle�� B�C ��  � �� U  LPMODULE GETMODULEHANDLE WIN32API APIGETMODULEHANDLEu  ��  � � � �= |�� GetLocaleInfo� win32apiQ� apiGetLocaleInfo�����" B�C ��   �� ��  �� � �� U  LOCALE LCTYPE LPLCDATA CCHDATA GETLOCALEINFO WIN32API APIGETLOCALEINFOD 7 |�� GetProcessHeap� win32apiQ� apiGetProcessHeap�
 B�C� �� U  GETPROCESSHEAP WIN32API APIGETPROCESSHEAPF  ��  �, |�� SetFocus� win32apiQ� apiSetFocus�� B�C ��  � �� U  NHWND SETFOCUS WIN32API APISETFOCUST  ��  � �0 |��	 SetParent� win32apiQ� apiSetParent��� B�C ��   �� � �� U 
 NHWNDCHILD NHWNDNEWPARENT	 SETPARENT WIN32API APISETPARENTs  ��  � � �E |�� RealGetWindowClass� win32apiQ� apiRealGetWindowClass���� B�C ��  ��  �� � �� U  NHWND PSZTYPE CCHTYPE REALGETWINDOWCLASS WIN32API APIREALGETWINDOWCLASSF  ��  �, |�� IsWindow� win32apiQ� apiIsWindow�� B�C ��  � �� U  NHWND ISWINDOW WIN32API APIISWINDOWL ? |�� GetDoubleClickTime� win32apiQ� apiGetDoubleClickTime�
 B�C� �� U  GETDOUBLECLICKTIME WIN32API APIGETDOUBLECLICKTIMEr  ��  � � � �: |�� RedrawWindow� win32apiQ� apiRedrawWindow�����" B�C ��   ��  ��  �� � �� U  NHWND
 LPRCUPDATE
 HRGNUPDATE UFLAGS REDRAWWINDOW WIN32API APIREDRAWWINDOW^  ��  �D |�� InitCommonControlsEx� comctl32Q� apiInitCommonControlsEx�� B�C ��  � �� U  LPINITCTRLS INITCOMMONCONTROLSEX COMCTL32 APIINITCOMMONCONTROLSEXL  ��  �2 |�� LoadLibrary� win32apiQ� apiLoadLibrary�� B�C ��  � �� U  LPLIBFILENAME LOADLIBRARY WIN32API APILOADLIBRARYy  ��  � � � �I |�� SystemParametersInfo� User32Q� apiSystemParametersInfo����� B�C �   � �  � � �� U  UIACTION UIPARAM PVPARAM NUPDATEWININ SYSTEMPARAMETERSINFO USER32 APISYSTEMPARAMETERSINFO� ; ��  � � � � � � � � �	 �
 � � � �J |��
 CreateFont� Win32APIQ� apiCreateFont���������������B B�C �   �  �  �  �  �  �  �  �  �	  �
  �  �  � � �� U  NHEIGHT NWIDTH NESCAPEMENT NORIENTATION NWEIGHT NITALIC
 NUNDERLINE
 NSTRIKEOUT NCHARSET NOUTPUTPRECISION NCLIPPRECISION NQUALITY NPITCHANDFAMILY CFACE
 CREATEFONT WIN32API APICREATEFONTf  ��  � � � �6 |�� PostMessage� User32Q� apiPostMessage����� B�C �   �  �  � � �� U  NHWND UMSG WPARAM LPARAM POSTMESSAGE USER32 APIPOSTMESSAGE@ 3 |�� GetLastError� kernel32Q� apiGetLastError�
 B�C� �� U  GETLASTERROR KERNEL32 APIGETLASTERRORT  ��  �< |�� LockWindowUpdate� WIN32APIQ� apiLockWindowUpdate�� B�C �  � �� U  TNHANDLE LOCKWINDOWUPDATE WIN32API APILOCKWINDOWUPDATEf  ��  � � �> |�� FindExecutable� Shell32Q� apiFindExecutable���� B�C�  � � � �� U  LPFILE LPDIRECTORY LPRESULT FINDEXECUTABLE SHELL32 APIFINDEXECUTABLEv  ��  � � � � �> |�� SHGetFileInfo� shell32Q� apiSHGetFileInfo������ B�C �   � �  �  � � �� U  TPSZPATH TDWFILEATTRIBUTES TSHFILEINFO TCBFILEINFO TUFLAGS SHGETFILEINFO SHELL32 APISHGETFILEINFO^  ��  � �> |�� GetComputerName� kernel32Q� apiGetComputerName��� B�C�  � � �� U  TCBUFFER TNSIZE GETCOMPUTERNAME KERNEL32 APIGETCOMPUTERNAME� # ��  � � � � � � � �X |�� GetVolumeInformation� WIN32APIQ� apiGetVolumeInformation���������* B�C�  �  � � � � �  � �
 �� U  TPROOTPATHNAME TPVOLNAMEBUF TNVOLNAMESZ TPVOLSERIALNUM TPMAXCOMPLEN TPFILESYSFLAGS TPFILESYSNAMEBUF TNFILESYSNAMESZ GETVOLUMEINFORMATION WIN32API APIGETVOLUMEINFORMATIONi  ��  � � �A |�� GetShortPathName� Win32APIQ� apiGetShortPathName���� B�C �  �  � � �� U 
 TCLONGNAME TCSHORTNAME TNSIZEOF GETSHORTPATHNAME WIN32API APIGETSHORTPATHNAMET  ��  �< |�� BringWindowToTop� Win32APIQ� apiBringWindowToTop�� B�C �  � �� U  THWND BRINGWINDOWTOTOP WIN32API APIBRINGWINDOWTOTOP}  ��  � � � � � �= |�� ShellExecute� Shell32Q� apiShellExecute�������" B�C �   �  �  �  �  � � �� U	  TNHWND	 TLPACTION TLPFILE	 TLPPARAMS TLPDIRECTORY	 TNSHOWCMD SHELLEXECUTE SHELL32 APISHELLEXECUTEH  ��  �0 |W� GetKeyState� User32Q� apiGetKeyState�� B�C �  � �� U  TKEYCODE GETKEYSTATE USER32 APIGETKEYSTATER  ��  �: |W� GetAsyncKeyState� User32Q� apiGetAsyncKeyState�� B�C �  � �� U  TKEYCODE GETASYNCKEYSTATE USER32 APIGETASYNCKEYSTATES  ��  �; |�� GetKeyboardState� user32Q� apiGetKeyboardState�� B�C�  � �� U 
 TCKEYCODES GETKEYBOARDSTATE USER32 APIGETKEYBOARDSTATEN  ��  � �. |��	 KillTimer� User32Q� apiKillTimer��� B�C �   � � �� U  TNHWND	 TNIDEVENT	 KILLTIMER USER32 APIKILLTIMER`  ��  � � � �0 |�� SetTimer� User32Q� apiSetTimer����� B�C �   �  �  � � �� U  TNHWND	 TNIDEVENT TUELAPSE TLPTIMERFUNC SETTIMER USER32 APISETTIMERc  ��  � �C |�� GetSystemDirectory� kernel32Q� apiGetSystemDirectory��� B�C�   � � �� U  TPBUFFER TNSIZE GETSYSTEMDIRECTORY KERNEL32 APIGETSYSTEMDIRECTORYR  ��  �: |�� GetSystemMetrics� User32Q� apiGetSystemMetrics�� B�C �  � �� U  TNINDEX GETSYSTEMMETRICS USER32 APIGETSYSTEMMETRICSH  ��  �0 |�� GetSysColor� User32Q� apiGetSysColor�� B�C �  � �� U  TNINDEX GETSYSCOLOR USER32 APIGETSYSCOLORS  ��  � �3 |�� SetTextColor� GDI32Q� apiSetTextColor��� B�C �   � � �� U  THDC TCRCOLOR SETTEXTCOLOR GDI32 APISETTEXTCOLORx  ��  � � � � � �8 |��
 MoveWindow� User32Q� apiMoveWindow�������" B�C �   �  �  �  �  � � �� U	  THWND TNX TNY TNWIDTH TNHEIGHT	 TBREPAINT
 MOVEWINDOW USER32 APIMOVEWINDOW�  ��  � � � � � � �> |�� SetWindowPos� User32Q� apiSetWindowPos��������& B�C �   �  �  �  �  �  � �	 �� U
  TNHWND THWNDINSERTAFTER TNX TNY TNWIDTH TNHEIGHT TUFLAGS SETWINDOWPOS USER32 APISETWINDOWPOSZ  ��  � �: |�� WindowFromPoint� User32Q� apiWindowFromPoint��� B�C �   � � �� U  TNX TNY WINDOWFROMPOINT USER32 APIWINDOWFROMPOINTF 9 |�� GetDesktopWindow� user32Q� apiGetDesktopWindow�
 B�C� �� U  GETDESKTOPWINDOW USER32 APIGETDESKTOPWINDOWH  ��  �0 |�� GetWindowDC� User32Q� apiGetWindowDC�� B�C �  � �� U  TNHWND GETWINDOWDC USER32 APIGETWINDOWDC`  ��  � � �8 |�� SetWindowLong� user32Q� apiSetWindowLong���� B�C �   �  � � �� U  TNHWND TNINDEX
 TDWNEWLONG SETWINDOWLONG USER32 APISETWINDOWLONGv  ��  � � � � �> |�� CallWindowProc� User32Q� apiCallWindowProc������ B�C �   �  �  �  � � �� U  TLPPREVWNDFUNC TNHWND TUMSG TWPARAM TLPARAM CALLWINDOWPROC USER32 APICALLWINDOWPROCV  ��  � �6 |�� GetWindowLong� User32Q� apiGetWindowLong��� B�C �   � � �� U  TNHWND TNINDEX GETWINDOWLONG USER32 APIGETWINDOWLONGN  ��  � �. |��	 GetWindow� user32Q� apiGetWindow��� B�C �   � � �� U  TNHWND TWFLAG	 GETWINDOW USER32 APIGETWINDOWa  ��  � � �9 |�� GetWindowText� user32Q� apiGetWindowText���� B�C �  �  � � �� U  THWND TPSTRING TCCH GETWINDOWTEXT USER32 APIGETWINDOWTEXTR  ��  � �2 |��
 ShowWindow� win32apiQ� apiShowWindow��� B�C �   � � �� U  TNHWND	 TNCMDSHOW
 SHOWWINDOW WIN32API APISHOWWINDOWB  ��  �* |�� IsIconic� user32Q� apiIsIconic�� B�C �  � �� U  THWND ISICONIC USER32 APIISICONICW  ��  � �7 |�� GetWindowRect� User32Q� apiGetWindowRect��� B�C �  � � �� U  TNHWND TLPRECT GETWINDOWRECT USER32 APIGETWINDOWRECTX  ��  � � �0 |�� HeapFree� Kernel32Q� apiHeapFree���� B�C �   �  � � �� U  THHEAP TDWFLAGS TLPHEAP HEAPFREE KERNEL32 APIHEAPFREEZ  ��  � � �2 |��	 HeapAlloc� Kernel32Q� apiHeapAlloc���� B�C �   �  � � �� U  THHEAP TDWFLAGS TDWBYTES	 HEAPALLOC KERNEL32 APIHEAPALLOCJ  ��  �2 |�� HeapDestroy� Kernel32Q� apiHeapDestroy�� B�C �  � �� U  THHEAP HEAPDESTROY KERNEL32 APIHEAPDESTROY\  ��  � � �4 |��
 HeapCreate� Kernel32Q� apiHeapCreate���� B�C �   �  � � �� U 
 TFLOPTIONS TDWINITIALSIZE TDWMAXIMUMSIZE
 HEAPCREATE KERNEL32 APIHEAPCREATEX  ��  � � �0 |�� HeapSize� Win32ApiQ� apiHeapSize���� B�C �   �  � � �� U  THHEAP TNALLOC TNADDR HEAPSIZE WIN32API APIHEAPSIZEB  ��  �* |�� lstrlen� Kernel32Q�
 apilstrlen�� B�C �  � �� U 	 TLPSTRING LSTRLEN KERNEL32
 APILSTRLEND  ��  �, |�� lstrlenW� Kernel32Q� apilstrlenW�� B�C �  � �� U 	 TLPSTRING LSTRLENW KERNEL32 APILSTRLENWY  ��  � �9 |�� GetUserName� advapi32.dllQ� apiGetUserName��� B�C �  � � �� U  TPBUFFER TNSIZE GETUSERNAME ADVAPI32 DLL APIGETUSERNAMEY  ��  � � �1 |� RtlMoveMemory� Kernel32Q� CopyMem���� B�C�   �  � � �� U  LPDEST LPSOURCE NLENGTH RTLMOVEMEMORY KERNEL32 COPYMEM]  ��  � � �5 |� RtlMoveMemory� Kernel32Q� CopyMem2Num���� B�C�   �  � � �� U  LPDEST LPSOURCE NLENGTH RTLMOVEMEMORY KERNEL32 COPYMEM2NUMZ  ��  � � �2 |� RtlMoveMemory� Kernel32Q� Copy2Mem���� B�C �  �  � � �� U  LPDEST LPSOURCE NLENGTH RTLMOVEMEMORY KERNEL32 COPY2MEM]  ��  � � �5 |� RtlMoveMemory� Kernel32Q� CopyNum2Mem���� B�C �  �  � � �� U  LPDEST LPSOURCE NLENGTH RTLMOVEMEMORY KERNEL32 COPYNUM2MEMA  ��  �) |�� lstrlen� Kernel32Q�	 GetStrLen�� B�C �  � �� U  LPSTRING LSTRLEN KERNEL32	 GETSTRLENy  ��  � � � �I |�� SystemParametersInfo� User32Q� SystemParametersInfoStr����� B�C �   � �  � � �� U  UIACTION UIPARAM PVPARAM NUPDATEWININI SYSTEMPARAMETERSINFO USER32 SYSTEMPARAMETERSINFOSTRf  ��  � � � �6 |�� PostMessage� User32Q� PostMessageStr����� B�C �   �  �  � � �� U  NHWND UMSG WPARAM LPARAM POSTMESSAGE USER32 POSTMESSAGESTR ctlGetOsVersion,     ��	 apiSUBSTRh     �� apiSUBSTR_ALLOC	    �� apiSUBSTR_FREEr    �� apiSUBSTR_GET'    ��
 apiReadMem�    �� apiGlobalFreep    �� apiGlobalAlloc�    �� apiWriteMemw	    �� apiGlobalSize
    �� apiMciSendString�
    �� apiMciGetErrorStringe    �� apiSetFileAttributes'    �� apiGetFileAttributes�    �� apiLockFileu    �� apiUnlockFileh    �� apiOpenFileg    �� apiCloseFile
    �� apiCopyFile�    �� apiMoveFile4    �� apiOpenFile�    �� apiDocumentPropertiesk    �� apiDeviceCapabilities�    �� apiEnumFormsw    �� apiClosePrinterZ    �� apiOpenPrinter�    ��
 apiAddForm�    �� apiDeleteForm>    �� apiStartDoc�    ��	 apiEndDocS    ��
 apiEndPage�    �� apiStartPage#    �� apiAbortDoc�    �� apiCoCreateGuid    �� apiStringFromGUID2~    �� apiUuidCreateSequential'    �� apiUuidFromString�    �� apiGdiplusStartupi    �� apiGdiplusShutdown$    �� apiGdipGetImageGraphicsContext�    �� apiGdipCreateFromHDC�    �� apiGdipDeleteGraphicsE    �� apiGdipSetTextRenderingHint�    �� apiGdipMeasureString�     �� apiGdipDrawString"    �� apiGdipDrawImageRectRect#    �� apiGdipDrawImage�$    �� apiGdipFillRectangle�%    �� apiGdipDrawImageRect�&    �� apiGdipCreateBitmapFromScan0�'    �� apiGdipDrawImageRectI�(    �� apiGdipDrawImageI�)    �� apiGdipLoadImageFromFilev*    �� apiGdipSaveImageToFile:+    �� apiGdipDisposeImage*,    �� apiGdipBitmapGetPixel�,    �� apiGdipGetImageWidth�-    �� apiGdipGetImageHeightG.    �� apiGdipCreateHBITMAPFromBitmap�.    �� apiGdipGetImagePixelFormat�/    �� apiGdipCreateImageAttributes�0    ��# apiGdipSetImageAttributesRemapTablew1    ��$ apiGdipSetImageAttributesColorMatrix�2    �� apiGdipDisposeImageAttributes4    �� apiGdipCreateStringFormat�4    �� apiGdipDeleteStringFormat�5    ��" apiGdipSetStringFormatHotkeyPrefixd6    ��( apiGdipStringFormatGetGenericTypographicV7    �� apiGdipCreateFontE8    �� apiGdipCreateFontFamilyFromName+9    �� apiGdipDeleteFont.:    �� apiGdipDeleteFontFamily�:    �� apiGdipCreateSolidFilll;    �� apiGdipCreateLineBrushI%<    �� apiGdipCreateLineBrushFromRectN=    �� apiGdipCreateLineBrushFromRectI|>    �� apiGdipSetLinePresetBlend�?    �� apiGdipDeleteBrush�@    �� apiGdipCreatePath3A    �� apiGdipAddPathRectangle�A    ��! apiGdipCreatePathGradientFromPath�B    ��! apiGdipSetPathGradientCenterColor�C    ��- apiGdipSetPathGradientSurroundColorsWithCount�D    �� apiGdipDeletePath�E    �� apiCreateMenuPF    �� apiDrawMenuBar�F    ��
 apiGetMenu-G    �� apiGetSystemMenu�G    ��
 apiSetMenu1H    �� apiCreatePopupMenu�H    ��	 apiIsMenu$I    �� apiDestroyMenu�I    �� apiAppendMenuJ    �� apiModifyMenu�J    �� apiEnableMenuItemyK    �� apiGetMenuInfo%L    �� apiSetMenuInfo�L    �� apiGetMenuBarInfo=M    �� apiGetMenuString�M    �� apiGetMenuItemRect�N    �� apiGetMenuItemCount�O    �� apiGetMenuItemID%P    �� apiGetMenuItemInfo�P    �� apiSetMenuItemInfoQ    �� apiMenuItemFromPointDR    �� apiGetMenuPosFromIDS    �� apiTrackPopupMenu�S    �� apiLoadImage�T    �� apiGetCursorPosmU    �� apiGetClientRect�U    �� apiGetDC�V    �� apiCreateCompatibleDC�V    �� apiCreateCompatibleBitmaptW    �� apiSelectObject<X    �� apiGetObject�X    �� apiReleaseDCaY    �� apiCreateDC�Y    �� apiDeleteDC�Z    �� apiDeleteObject[    �� apiGetDeviceCaps|[    �� apiGetSysColorBrush\    �� apiSetBkColor�\    �� apiCreateSolidBrush]    �� apiSetBkMode�]    �� apiGetStockObject-^    �� apiCreatePatternBrush�^    �� apiGdiSetBatchLimitE_    �� apiGetTextExtentPoint32�_    �� apiFillRect�`    �� apiDrawText8a    �� apiExtTextOut�a    �� apiDrawEdge�b    �� apiCreatePen�c    �� apiExtCreatePen.d    �� apiMoveToExe    ��	 apiLineTo�e    �� apiRectangle"f    �� apiRoundRect�f    ��
 apiSetRect�g    �� apiGradientFill�h    �� apiGetPixelzi    �� apiSetPixelVj    �� apiTransparentBlt�j    ��	 apiBitBltl    �� apiAlphaBlend
m    �� apiCreateFontIndirectVn    �� apiClientToScreen�n    �� apiScreenToClient�o    �� apiMapWindowPoints!p    �� apiPtInRect�p    �� apiSetCursor{q    �� apiLoadCursor�q    ��	 apiMulDiv}r    �� apiCreateRoundRectRgns    �� apiSelectClipRgn(t    �� apiIsThemeActive�t    �� apiRegOpenKey(u    �� apiRegEnumValue�u    �� apiRegCloseKey�v    �� apiRegQueryValueEx^w    �� apiRegCreateKeyXx    �� apiRegDeleteValuey    �� apiRegSetValueEx�y    �� apiExtractIconEx�z    �� apiDestroyIcon~{    �� apiExtractAssociatedIcon�{    �� apiOleCreatePictureIndirect�|    �� apiSHGetSpecialFolderPath�}    �� apiGetProcAddress�~    �� apiFreeLibraryX    �� apiGetCaretPos�    �� apiCloseHandle\�    �� apiReadFile܀    �� apiFileTimeToSystemTimeÁ    �� apiCreateFile��    �� apiSetFilePointerEx��    �� apiGetFileSizeExǄ    �� apiWriteFilef�    �� apiSendMessageT�    �� apiSendMessageInteger�    �� apiSendMessageString�    �� apiGetDateFormat��    �� apiUuidCreate��    �� apiUuidCreateNil�    �� apiUuidToString��    �� apiGetParent;�    �� apiGetScrollPos��    �� apiShowScrollBarD�    �� apiEnableWindow�    �� apiSetScrollInfo��    �� apiCreateWindowExF�    �� apiSetWindowTheme��    �� apiGetScrollRange��    �� apiOpenThemeData�    �� apiGetThemeColorX�    �� apiCloseThemeDatam�    �� apiGetTickCount1�    �� apiSetWindowRgn��    �� apiCreateRectRgnG�    �� apiDestroyWindow��    �� apiGetActiveWindow��    �� apiLoadString��    �� apiGetModuleHandle��    �� apiGetLocaleInfoG�    �� apiGetProcessHeap�    �� apiSetFocus��    �� apiSetParent��    �� apiRealGetWindowClass��    �� apiIsWindowQ�    �� apiGetDoubleClickTimeÛ    �� apiRedrawWindowH�    �� apiInitCommonControlsEx�    �� apiLoadLibrary��    �� apiSystemParametersInfo<�    �� apiCreateFont�    �� apiPostMessage��    �� apiGetLastError]�    �� apiLockWindowUpdateʡ    �� apiFindExecutable]�    �� apiSHGetFileInfo�    �� apiGetComputerName��    �� apiGetVolumeInformation��    �� apiGetShortPathName��    �� apiBringWindowToTop��    �� apiShellExecuteK�    �� apiGetKeyState4�    �� apiGetAsyncKeyState��    �� apiGetKeyboardState>�    �� apiKillTimerЩ    �� apiSetTimerV�    �� apiGetSystemDirectory�    �� apiGetSystemMetrics��    �� apiGetSysColor@�    �� apiSetTextColor��    �� apiMoveWindowG�    �� apiSetWindowPos�    �� apiWindowFromPoint�    �� apiGetDesktopWindow��    �� apiGetWindowDC�    �� apiSetWindowLong��    �� apiCallWindowProc7�    �� apiGetWindowLong�    �� apiGetWindow��    �� apiGetWindowText$�    �� apiShowWindowɳ    �� apiIsIconicW�    �� apiGetWindowRectô    �� apiHeapFreeX�    �� apiHeapAlloc�    �� apiHeapDestroy��    �� apiHeapCreate
�    �� apiHeapSize��    ��
 apilstrlenQ�    �� apilstrlenW��    �� apiGetUserName5�    �� CopyMemй    �� CopyMem2Numj�    �� Copy2Mem�    �� CopyNum2Mem��    ��	 GetStrLenJ�    �� SystemParametersInfoStr��    �� PostMessageStr��    ��7 Q6 � � � !�� 1�� 1� q11Q� A � �� A �q�Q� 7 q � !�q A � Q�Q�� � � A � 4 q q Qq A qq 4 � � ��� ��� A�� A� �AAQ� A � �� A �6 � Qa4 q � 4 � A!4 � Aa4 q � 7 1��4 � Aa7 � !4 q �� 4 qA�4 q��4 � a4 q � 4 � a4 � �!4 � a7 �!4 q��4 ��!4 q �� 4 � �a4 � 1a4 � a!4 � �!4 q �� 4 q �� 4 q �� 4 q �� 7 q �� 4 � !a4 q �� 4 � �!6 � !a4 q �� 7 � �!4 � A!4 q 1� 4 � !4 qB�4 ��a4 �2!4 1��4 ��!4 ��!8 ��!4 ��!4 1�4 � �!4 1��4 q �� 4 1��4 � A!4 � a!4 � �a4 � !7 q !� 4 qq�4 ��!4 q 1� 8 � a4 q �� 4 � �!4 q �� 8 qA�4 � �a4 q �� 4 q q� 7 � �!4 �Aa4 �!4 �1!4 1�4 q �� 4 � �!4 q��4 � �!4 � �!4 � �a4 q �� 7 �� 4 q � 4 q �� 4 � a!4 � �!4 q� 4 q a� 4 q � 4 1A�4 qa�4 � �a4 � 1!4 � 1!4 1��4 q��4 1��4 q �� 4 � a!4 1��4 1��4 1!�4 � �!4 �!a4 �a!4 q 1� 4 � q!4 q A� 4 q �� 4 � �a4 � 1!4 � a4 � �!4 1!�4 q �� 4 q � 4 � Q!4 q �� 4 � �!4 q �� 4 � �!4 q Q� 4 q �� 4 q �� 4 1��4 � �a4 q1�4 1��4 1�4 � �a4 q��4 1�4 � �a4 q1�4 �qa4 q�4 ��!4 � �a4 1�4 ��a4 qQ�4 �1a4 q �� 4 � �!4 � �!4 1��4 � �a4 q �� 4 � !4 � �a4 �q!4 � Q!4 A� 7 � Qa4 1q�4 q !� 4 �q!4 � �a4 � �!4 �!7 q�4 q � 4 � �a4 1Q�7 1!!4 � �a4 q !4 q 14 q !4 qa�4 � aa4 ��A4 qQ�4 � �a4 qv�4 1s!� !A 4 1�!4 1�!4 ��4 q �4 q R4 � Sa4 q �4 � ca4 � ��4 � ca4 1�!4 1�!4 � Q��� � A 4 1!4 � Qsa� � A 4 qQ��� � A 4 q Qr� � A 4 1� 4 � ��4 1�!4 q b4 �� 4 1e!4 q �4 1�!4 q� 4 q �4 � a4 � T�4 q �4 �� 4 1�!4 q B4 q !4 1��4 ��!4 1a�4 1� 4 q �� 4 � �a4 q��4 � �!4 1��4 � a4 q �� 4 ��!4 q � 4 q �� 4 q �� 4 � �!4 1�4 � 1!4 q �� 4 q � 4 � 1!7 ��!4 ��a4 � �!4 �� 4 q � 4 � �a4 q��4 � a!4 � �!4 � �a4 � !!4 q �� 4 � q!7 � a4 � !a4 q !� 4 � Aa4 � a4 q �� 4 q �� 7 � �!7 � a4 � Qa4 � !a4 � Qa4 q �� 4 1��4 1a�1                    f   �         �  �        _  �  5   0   �  �	  K   :   �	  �  Y   T   �  Z  |   X   �  �  �   \   !  �  �   `   �  �  �   d   �  R  �   h       �   l   C  $  �   p   �  �  �   t   �  m  �   x   �  0  �   |   W    �   �   ,    �   �   +  �  �   �   �  �  �   �   �  �  �   �   �  �  �   �   \   �!  �   �   "  :#  �   �   `#  �$    �   �$  <%  
  �   d%  M&    �   q&  &'    �   N'  �'    �   (  �(  &  �   �(  &)  -  �   J)  �)  4  �   �)  H*  ;  �   m*  �*  B  �   �+  ,  L  �   8,  �,  S  �   1-  �-  Z  �   �-  �.  a  �   \/  +0  j  �   W0  �0  q  �   �1  y2  {  �   �2  V3  �  �   �3  4  �  �   R4  K5  �  �   y5  _7  �  �   �7  9  �  �   89  �;  �  �   #<  =  �  �   /=  ^>  �     �>  �?  �    �@  �A  �    $B  EC  �    pC  BD  �    tD  BE  �    rE  �F  �    �F  ]G  �    �G  uH  �     �H  ]I  �  $  �I  LJ  �  (  �J  qK    ,  �K  uL    0  3M  �M    4  +N  �O    8  �O  �Q  %  <  �Q  �R  ,  @  @S  NT  7  D  �T  :U  >  H  vU  uV  E  L  �V  �W  L  P  ;X  hY  W  T  �Y  �Z  ^  X   [  �[  e  \  �[  g\  l  `  ]  �]  v  d  
^  �_  }  h  �_  )a  �  l  ba  �b  �  p  c  d  �  t  ;d  �d  �  x  �d  �e  �  |  �e  �f  �  �  g  h  �  �  <h  i  �  �  [i  tj  �  �  �j  "k  �  �  �k  l  �  �  Dl  �l  �  �  �l  Xm  �  �  �m  (n  �  �  Ln  �n  �  �  o  ao  �  �  �o  �o  �  �  p  �p  �  �  �p  �q    �  �q  �r  
  �  �r  �s    �  �s  Tt    �  |t  u    �  <u  v  &  �  Hv  Xw  -  �  �w  vx  4  �  �x  *y  ;  �  Ty  �y  B  �  z  {  I  �  1{  |  P  �  I|  }  W  �  B}  �}  ^  �  ~  8  e  �  ^  ��  l  �  ��  /�  s  �  Y�  ��  z  �  �  |�  �  �  ��  .�  �  �  a�  1�  �    Z�  �  �    �  ҅  �  
  ��  ��  �    ��  ��  �    ·  3�  �    \�  ͈  �    ��  ��  �    ��  G�  �  "  n�  ��  �  &  (�  ��  �  *  ׋  g�  �  .  ��  �  �  2  J�  Ѝ  �  6  ��  ��  �  :  ��  ��  �  >  Ώ  y�  �  B  ��  ��    F  ��  �    J  &�  �    N  +�  �    R  �  5�  "  V  Z�  �  )  Z  3�  З  0  ^  ��  �  7  b  6�  ��  >  f  ٚ  ʛ  E  j  �  �  L  n  B�  �  S  r  �  О  Z  v  ��  �  a  z  0�  ��  h  ~  ޢ  �  o  �  �  ��  v  �  ۥ  �  }  �  ��  N�  �  �  z�  }�  �  �  ��  ;�  �  �  a�  ֩  �  �  ��  ��  �  �  ƪ  ��  �  �  ˫  [�  �  �  ��  �  �  �  H�  ��  �  �  K�  �  �  �  <�  ޱ  �  �  �  ��  �  �  ��  �  �  �  7�  �  �  �  0�  ص  �  �  �  B�  �  �  �  �  �  �  0�  ��     �  ٹ  ƺ    �  ��  )�    �  �  �    �  /�  �    �  �  ��  &  �  ſ  J�  -  �  r�  ��  4  �  �  ��  ;  �  ��  ��  B  �  ��  ��  I  �  ��  ��  P  �  ��  f�  W    ��  �  ^    C�  ��  j    ��  ��  v    ��  ��  �    �  v�  �    ��  �  �    C�  ��  �     ��  ��  �  $  ��  P�  �  (  y�  �  �  ,  G�  �  �  0  =�  ��  �  4  �  �  �  8  8�  ��  �  <  ��  �  �  D  ?�  I�    H  s�  x�    P  ��  9�    X  d�  5�  *  `  `�  ��  6  c  ��  ��  <  g  ��  ��  F  k  ��  \�  Q  o  ��  ��  Y  r  �  �  _  v  G�  ��  j  z  �  �  r  ~  ?�  ��  }  �  ��  :�  �  �  `�  *�  �  �  Y�  F�  �  �  k�  ��  �  �  �  ~�  �  �  ��  ��  �  �  ��  ��  �  �  ��  U�  �  �  ��  ��  �  �  ��  o�  �  �  ��  [�  �  �  ��  ��  �  �  �  ��  �  �  ��  ��  �  �  ��  �  �  �  >�  ��  �  �  "�  X�  �  �  ��  k�    �  ��  "�    �  K�  ��    �  ��  5�    �  b�  ��     �  �  ��  '  �  ��  p�  .  �  ��  u  5  �  �  Z <  �  �  C  �  < � J  �  � s Q  �   % [  �  N � b  �  � I i  �  v � p    � t v    � k	 }  
  �	 �
 �    �
 f �    �  �    I 	 �    0 � �    � g �  "  � / �  &  � � �  *  � b �  .  �  �  2  (  �  6  5 � �  :   � �  >  � ' �  B  � | �  F  2 � �  J   � �  N  � �   R  � h   V  � �   Z  0 ?   ^  h .              �     (       @         �                        �  �   �� �   � � ��  ��� ��� �ʦ ��� ��� ��� k�� H�� %��  ��  ��  z�  b�  Js  2P ��� ��� ��� k�� Hs� %W�  U�  I�  =�  1�  %s  P ��� ��� ��� kk� HH� %%�   �   �   �   �   s   P ��� Ǳ� ��� �k� sH� W%� U � I � = � 1 � % s  P ��� �� Ԏ� �k� �H� �%� � � � � z � b � J s 2 P ��� ��� ��� �k� �H� �%� � � � � � � � � s s P P ��� ��� ��� �k� �H� �%� � � � � � z � b s J P 2 ��� ��� ��� �k� �Hs �%W � U � I � = � 1 s % P  ��� ��� ��� �kk �HH �%% �   �   �   �   s   P   ��� �Ǳ ��� ��k �sH �W% �U  �I  �=  �1  s%  P  ��� �� �Ԏ ��k ��H ��% ��  ܒ  �z  �b  sJ  P2  ��� ��� ��� ��k ��H ��% ��  ��  ��  ��  ss  PP  ��� ��� ��� ��k ��H ��% ��  ��  z�  b�  Js  2P  ��� ��� ��� ��k s�H W�% U�  I�  =�  1�  %s  P  ��� ��� ��� k�k H�H %�%  �   �   �   �   s   P  ��� ��� ��� k�� H�s %�W  �U  �I  �=  �1  s%  P ��� ��� ��� k�� H�� %��  ��  ܒ  �z  �b  sJ  P2 ��� ��� ��� k�� H�� %��  ��  ��  ��  ��  ss  PP ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� zzz nnn bbb VVV JJJ >>> 222 &&&   ��� ��� ���   �  �   �� �   � � ��  ��� �����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������    � �  ����  �  ����  �������       �  ���   �  ���   ������   ���  �  ��   ��  ��   �������  ����  �  �   ���  �   ��������  ��    �     ����     ���������  ��    �     ����     ���������  �������  �   ���  �   ��������   ���� �  ��   ��  ��   ��������       �  ���   �  ���   ��������     ��  ����  �  ����  �����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������                                                                                                                                   %   �      H     
  LaI�   �  U  � ��  � � %�C� fdkeywrd���4 � T� �a�� F� � �}� T�  �� FDKEYWRD.DBF�� ��� � Q�  ���  �� �� token� F� � T� �a�� �(� �y�  T�  �C��]� FDKEYWRD.DBF�� ��� � Q�  ���  �� �� token� F� � T� �a�� �(� �u�( T�  �C��]� WIZARDS\FDKEYWRD.DBF�� ��Z� Q�  ���  �� �� token� F� � T� �a�� �(� �q� T� �-�� �� �� �� �	 B�� �� U 
 LCFILENAME LLRETURN FDKEYWRD TOKEN LOEXCEPTION GKKOpenFDKEYWRD,     ��= � q� q � �� �q � � � �q � � �� �q � � � A A A A � 1                      �     0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Screen                                                                                            WINDOWS _3C712SQAS10623102628      O  f      }                          �      �                       WINDOWS _3C712SQAT1264321789�      �              4  �8                  C                      w   WINDOWS _3C712ZYMC1062695741�  �  �  �  �  �      H  2                                               WINDOWS _3C712ZYMD1062695741;  L  n    �  �      �  �                                               WINDOWS _3C80MYHA21062695741�    �  =  �  V                                                           WINDOWS _3C712SQAS1062695741%  �    �  �  �      �  D%                                               WINDOWS _3CA161QL41062695741�  �  �  �  t  2"      /#  �                                               WINDOWS _3C712SQAS1062695741a  O  L  :  $  %!      ?(  E-                                               WINDOWS _3CD0UX4GK1264321667  �  �  �  �  �      84  j                                               COMMENT RESERVED                                f                      <                                    =�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      ..\programs\gkkdefines.h      dataenvironment      dataenvironment      Dataenvironment      YTop = 0
Left = 0
Width = 0
Height = 0
DataSource = .NULL.
Name = "Dataenvironment"
      1      1      form      form      GKKCOPYCLIPMGR     Height = 370
Width = 620
ShowWindow = 2
DoCreate = .T.
AutoCenter = .T.
Caption = "GKK Copy Clip Manager"
MaxButton = .F.
MinButton = .F.
MinHeight = 370
MinWidth = 620
Icon = ..\graphics\gkkgkk.ico
AllowOutput = .F.
_memberdata = 
Name = "GKKCOPYCLIPMGR"
     .PROCEDURE Resize
WITH thisform
	.cmdDelete.Top      = .Height - 24
	.cmdRestore.Top     = .Height - 24
	.cmdSave.Top        = .Height - 24
	.cmdCopy.Top        = .Height - 24
	.lstCopyList.Height = .cmdSave.Top - .lstCopyList.Top - 4
	.clsSplitter.Height = .Height - 10
	.clsCodeMax.Height  = .Height - 10
	.clsCodeMax.Width   = .Width - .clsCodeMax.Left - 4
ENDWITH
ENDPROC
PROCEDURE Init
LOCAL lnValue
WITH thisform
	.NewObject("clsCodeMax","CodeMax","GKKClipCodeMax.vcx")
	WITH .clsCodeMax
		.Top      = 5
		.Left     = thisform.clsSplitter.Left + 6
		.Height   = this.Height - 10
		.Width    = this.Width  - .Left - 4
		.Readonly = True
		.Visible  = True
	ENDWITH
	.clsWindowPosition.Restore()
	.Resize()
	lnValue = VAL(GKKGetString_VFP("Form",.Name+"-SplitterPos"))
	IF lnValue > 0
		.clsSplitter.Left = lnValue
		.clsSplitter.Split()
	ENDIF
ENDWITH
ENDPROC
PROCEDURE Destroy
WITH thisform
*-*	Save window position
	.clsWindowPosition.Save()
	=GKKSetString_VFP("Form",.Name+"-SplitterPos",.clsSplitter.Left)
ENDWITH
ENDPROC
     ����    �  �                        d�   %         X     $          �  U   ��  � � � � � � � �� ����  T�  �CC�]C� :C�]��\�� T�  �C�  C� \�  ��=��# T�  ��  � GKKCopyClipMgr.txt�� %�C�  0���� F� � T� �C�  ���� T� �C�� � ����� �� ���(�� ���� T� �CC � � �
=�� -��	 � � C'
	�� %�C4
���� T� �CC � � �\��" T� �C� � {GKK}C� C�
 ���! T� �C� �  C� C�
 �����3 r��
 c_copyclip�	 �
 � ��� ��� ��� ��8 ��CC� � � �_� : � C�
 c_copyclipO� � � �� � �� ��  ��C� Copy Text not found� �� � U 
 LCFILENAME
 LCSAVETEXT	 LNNUMCOPY LNNDX LCCODEID
 LCCODETEXT
 LCCODELINE LALINES
 C_COPYCLIP CODEID CODELINE CODETEXT THISFORM LSTCOPYLIST ADDLISTITEM	 LISTCOUNT GKKDISPLAYMSG  U   Click,     �� Init     ��1 �� �1� q �qqQ� q!1�A A � A 2 6                       �        �  ^      )   �                        "  ..\programs\gkkdefines.h�o��fF      AArial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 0, 7, 4, 12, 9, 24, 3, 0
      GKKCOPYCLIPMGR      cmdCopy      commandbutton      ..\classes\gkkbaseclasses.vcx      _commandbutton      GKKCOPYCLIPMGR      
cmdRestore      commandbutton      _commandbutton     �_memberdata = <VFPData><memberdata name="AllowOutput" type="property" display="AllowOutput"/><memberdata name="AutoCenter" type="property" display="AutoCenter"/><memberdata name="Caption" type="property" display="Caption"/><memberdata name="DoCreate" type="property" display="DoCreate"/><memberdata name="Height" type="property" display="Height"/><memberdata name="Icon" type="property" display="Icon"/><memberdata name="MaxButton" type="property" display="MaxButton"/><memberdata name="MinButton" type="property" display="MinButton"/><memberdata name="MinHeight" type="property" display="MinHeight"/><memberdata name="MinWidth" type="property" display="MinWidth"/><memberdata name="Name" type="property" display="Name"/><memberdata name="ShowInTaskBar" type="property" display="ShowInTaskBar"/><memberdata name="ShowWindow" type="property" display="ShowWindow"/><memberdata name="Width" type="property" display="Width"/></VFPData>
FormDescription =
UserNotes =       6_memberdata XML Metadata for customizable properties
      _listbox      ..\classes\gkkbaseclasses.vcx      listbox      lstCopyList      GKKCOPYCLIPMGR      RHeight = 339
Left = 4
TabIndex = 1
Top = 5
Width = 240
Name = "lstCopyList"
     �PROCEDURE InteractiveChange
IF this.ListItemId > 0
	SELECT c_copyclip
	GOTO RECORD this.ListItemId IN c_copyclip
	thisform.clsCodeMax.Text = ALLTRIM(c_copyclip.codetext)
ELSE
	thisform.clsCodeMax.Text = ""
ENDIF
ENDPROC
PROCEDURE Init
LOCAL lnNdx
lnNdx = 0
SELECT c_copyclip
SCAN FOR !DELETED()
	lnNdx = lnNdx + 1
	this.AddListItem(TRANSFORM(lnNdx) + ": " + ALLTRIM(c_copyclip.codeline),RECNO())
ENDSCAN
ENDPROC
     I���    0  0                        �5   %   �       �      �           �  U  d  ���  ��] � T�� � �� � ��� T�� � �� � ���  T�� � ��  � �� � ��� �� U  THISFORM LSTCOPYLIST WIDTH THIS LEFT
 CLSCODEMAX split,     ��1 � ��A 1                       �       )   0                        ..\classes\gkkbaseclasses.vcx      GKKCOPYCLIPMGR      cmdSave      commandbutton      ..\classes\gkkbaseclasses.vcx      _commandbutton      GKKCOPYCLIPMGR      	cmdDelete      commandbutton      _commandbutton      	splitterv      ..\classes\gkksplitter.vcx      	container      clsSplitter      GKKCOPYCLIPMGR     CTop = 5
Left = 246
Height = 360
TabIndex = 6
rangemin = 246
Name = "clsSplitter"
imgSplitter.Picture = ..\graphics\gkkvsplitter.bmp
imgSplitter.Height = 35
imgSplitter.Left = 0
imgSplitter.MousePointer = 9
imgSplitter.Top = 82
imgSplitter.Width = 3
imgSplitter.ZOrderSet = 48
imgSplitter.Name = "imgSplitter"
      �PROCEDURE split
WITH thisform
	.lstCopyList.Width = this.Left - 2
	.clsCodeMax.Left   = this.Left + 6
	.clsCodeMax.Width  = thisform.Width - .clsCodeMax.Left - 4
ENDWITH
ENDPROC
      �Top = 346
Left = 184
Height = 23
Width = 60
FontSize = 7
Picture = ..\graphics\gkkcopy16.bmp
Caption = "Copy"
TabIndex = 5
ToolTipText = "Copies selected Code to clipboard"
Visible = .T.
PicturePosition = 1
Alignment = 0
Name = "cmdCopy"
      ..\classes\gkkbaseclasses.vcx      GKKCOPYCLIPMGR      label      windowposition       ..\classes\gkkwindowposition.vcx      clsWindowPosition      `Caption = "clsWindowPosition"
Left = 484
Top = 346
TabIndex = 7
Name = "clsWindowPosition"
      �Top = 346
Left = 4
Height = 23
Width = 60
FontSize = 7
Picture = ..\graphics\gkkcopycodedelete.bmp
Caption = "Delete"
TabIndex = 2
ToolTipText = "Delete selected copy code"
Visible = .T.
PicturePosition = 1
Alignment = 0
Name = "cmdDelete"
     PROCEDURE Click
LOCAL lnListItemId, lnIndex, lnNdx
IF thisform.lstCopyList.ListItemId > 0
	lnListItemId = thisform.lstCopyList.ListItemId
	SELECT c_copyclip
	GOTO RECORD lnListItemId IN c_copyclip
	DELETE
	lnIndex = thisform.lstCopyList.ItemIdToIndex(lnListItemId)
	thisform.lstCopyList.RemoveListItem(lnListItemId)
	lnNdx = 0
	SCAN FOR !DELETED()
		lnNdx = lnNdx + 1
		thisform.lstCopyList.AddListItem(TRANSFORM(lnNdx) + ": " + ALLTRIM(c_copyclip.codeline),RECNO())
	ENDSCAN
	IF thisform.lstCopyList.ListCount > 0
		thisform.lstCopyList.ListItemId = thisform.lstCopyList.IndexToItemId(lnIndex)
	ELSE
		thisform.lstCopyList.ListItemId = 0
	ENDIF
	thisform.lstCopyList.InteractiveChange()
	GKKDisplayMsg("Selected Copy Text Deleted")
ENDIF
ENDPROC
     P���    7  7                        ��   %   �      �     �          �  U  ! ��  � � � T�  ��  �� F� � ~�C'
��| �' T� �CC� � �C� C�
 � {GKK}���$ T�  ��  � � � C� C�
 �� �  T� �CC�]C� :C�]��\�� T� �C� C� \� ��=��# T� �� � GKKCopyClipMgr.txt�� ��C�  � � ���� ��C� Copy Text Saved� �� T� � �	 �a�� U
 
 LCSAVETEXT
 LCCODETEXT
 LCFILENAME
 C_COPYCLIP CODETEXT CODEID GKKDISPLAYMSG THISFORM
 CMDRESTORE ENABLED Click,     ��1 � � q � qAA �1!�1                             )   7                       Top = 346
Left = 124
Height = 23
Width = 60
FontSize = 7
Picture = ..\graphics\gkkfolderopen16.bmp
Caption = "Restore"
TabIndex = 4
ToolTipText = "Restores saved copy clip buffer"
Visible = .T.
PicturePosition = 1
Alignment = 0
Name = "cmdRestore"
      �Top = 346
Left = 64
Height = 23
Width = 60
FontSize = 7
Picture = ..\graphics\gkksave.bmp
Caption = "Save"
TabIndex = 3
ToolTipText = "Saves copy clip buffer to file"
Visible = .T.
PicturePosition = 1
Alignment = 0
Name = "cmdSave"
     PROCEDURE Click
LOCAL lcSaveText, lcCodeText, lcFileName
lcSaveText = ""
SELECT c_copyclip
SCAN FOR !DELETED()
	lcCodeText = STRTRAN(ALLTRIM(c_copyclip.codetext),CRLF,"{GKK}")
	lcSaveText = lcSaveText + c_copyclip.codeid + lcCodeText + CRLF
ENDSCAN
lcFileName = SUBSTR(SYS(16), ATC(":",SYS(16))-1)
lcFileName = LEFT(lcFileName, RATC("\",lcFileName,2))
lcFileName = lcFileName + "GKKCopyClipMgr.txt"
STRTOFILE(lcSaveText,lcFileName,0)
GKKDisplayMsg("Copy Text Saved")
thisform.cmdRestore.Enabled = True
ENDPROC
     ����    �  �                        �   %   T      �     c          �  U  e ��  � � � %�� � � � ��^� T�  �� � � �� F� � #� ��  �� � T� �C �  � � � �� ��C �  � � � �� T� �� �� ~�C'
��� � T� �� ���& ��CC� _� : C� �
 �CO� � �	 �� � %�� � � � ��� T� � � �C � � � � �� �#� T� � � �� �� � ��C� � � ��' ��C� Selected Copy Text Deleted� �� � U  LNLISTITEMID LNINDEX LNNDX THISFORM LSTCOPYLIST
 LISTITEMID
 C_COPYCLIP ITEMIDTOINDEX REMOVELISTITEM ADDLISTITEM CODELINE	 LISTCOUNT INDEXTOITEMID INTERACTIVECHANGE GKKDISPLAYMSG Click,     ��1 � q1q � A �A� � aA q�� 1A qA 1                       �      )   �                       �PROCEDURE Init
LOCAL lcFileName
lcFileName = SUBSTR(SYS(16), ATC(":",SYS(16))-1)
lcFileName = LEFT(lcFileName,RATC("\",lcFileName,2))
lcFileName = lcFileName + "GKKCopyClipMgr.txt"
IF FILE(lcFileName)
	this.Enabled = True
ELSE
	this.Enabled = False
ENDIF
ENDPROC
PROCEDURE Click
LOCAL lcFileName, lcSaveText, lnNumCopy, lnNdx, lcCodeId, lcCodeText, lcCodeLine
LOCAL ARRAY laLines[1]
lcFileName = SUBSTR(SYS(16),ATC(":",SYS(16))-1)
lcFileName = LEFT(lcFileName,RATC("\",lcFileName,2))
lcFileName = lcFileName + "GKKCopyClipMgr.txt"
IF FILE(lcFileName)
	SELECT c_copyclip
	lcSaveText = FILETOSTR(lcFileName)
	lnNumCopy = ALINES(laLines,lcSaveText,1)
	FOR lnNdx=1 TO lnNumCopy
		lcCodeId = LEFT(laLines[lnNdx],10)
		LOCATE FOR codeid = lcCodeId .AND. !DELETED()
		IF !FOUND()
			lcCodeText = SUBSTR(laLines[lnNdx],11)
			lcCodeText = STRTRAN(lcCodeText,"{GKK}",CRLF)
			lcCodeLine = STREXTRACT(lcCodeText,"",CRLF,1)
			INSERT INTO c_copyclip (codeid, codeline, codetext) VALUES (lcCodeId, lcCodeLine, lcCodeText)
			thisform.lstCopyList.AddListItem(TRANSFORM(thisform.lstCopyList.ListCount+1) + ": " + lcCodeLine,RECNO('c_copyclip'))
		ENDIF
	ENDFOR
	GKKDisplayMsg("Copy Text restored")
ELSE
	GKKDisplayMsg("Copy Text not found")
ENDIF
ENDPROC
     ����    �  �                        �N   %   �      C  $   �          �  U  �  ��  �  T�  �CC�]C� :C�]��\�� T�  �C�  C� \�  ��=��# T�  ��  � GKKCopyClipMgr.txt�� %�C�  0��� � T� � �a�� �� � T� � �-�� � U 
 LCFILENAME THIS ENABLED4 ��  � � � � � � � �� ����  T�  �CC�]C� :C�]��\�� T�  �C�  C� \�  ��=��# T�  ��  � GKKCopyClipMgr.txt�� %�C�  0��� F� � T� �C�  ���� T� �C�� � ����� �� ���(�� ���� T� �CC � � �
=�� -��	 � � C'
	�� %�C4
���� T� �CC � � �\��" T� �C� � {GKK}C� C�
 ���! T� �C� �  C� C�
 �����3 r��
 c_copyclip�	 �
 � ��� ��� ��� ��8 ��CC� � � �_� : � C�
 c_copyclipO� � � �� � �� ��C� Copy Text restored� �� �-�  ��C� Copy Text not found� �� � U 
 LCFILENAME
 LCSAVETEXT	 LNNUMCOPY LNNDX LCCODEID
 LCCODETEXT
 LCCODELINE LALINES
 C_COPYCLIP CODEID CODELINE CODETEXT THISFORM LSTCOPYLIST ADDLISTITEM	 LISTCOUNT GKKDISPLAYMSG Init,     �� Click�     ��1 q �1� � � � A 2 �� �1� q �qqQ� q!1�A A �� A 1                               #  �      )   �                       .���                              ^�   %   q      �     �          �  U  e  %��  � � ��C � F� � #� ��  � �� T� � � �C� � ��� �^ � T� � � ��  �� � U  THIS
 LISTITEMID
 C_COPYCLIP THISFORM
 CLSCODEMAX TEXT CODETEXTd  ��  � T�  �� �� F� � ~�C'
��] � T�  ��  ���# ��CC�  _� : C� � �CO� � �� � U  LNNDX
 C_COPYCLIP THIS ADDLISTITEM CODELINE InteractiveChange,     �� Init�     ��1 Aq �� 1A 2 q � q � 1A 1                       �      	   �   �  
    )                          iPROCEDURE Click
LOCAL lcFileName, lcSaveText, lnNumCopy, lnNdx, lcCodeId, lcCodeText, lcCodeLine
LOCAL ARRAY laLines[1]
lcFileName = SUBSTR(SYS(16),ATC(":",SYS(16))-1)
lcFileName = LEFT(lcFileName,RATC("\",lcFileName,2))
lcFileName = lcFileName + "GKKCopyClipMgr.txt"
IF FILE(lcFileName)
	SELECT c_copyclip
	lcSaveText = FILETOSTR(lcFileName)
	lnNumCopy = ALINES(laLines,lcSaveText,1)
	FOR lnNdx=1 TO lnNumCopy
		lcCodeId = LEFT(laLines[lnNdx],10)
		LOCATE FOR codeid = lcCodeId .AND. !DELETED()
		IF !FOUND()
			lcCodeText = SUBSTR(laLines[lnNdx],11)
			lcCodeText = STRTRAN(lcCodeText,"{GKK}",CRLF)
			lcCodeLine = STREXTRACT(lcCodeText,"",CRLF,1)
			INSERT INTO c_copyclip (codeid, codeline, codetext) VALUES (lcCodeId, lcCodeLine, lcCodeText)
			thisform.lstCopyList.AddListItem(TRANSFORM(thisform.lstCopyList.ListCount+1) + ": " + lcCodeLine,RECNO('c_copyclip'))
		ENDIF
	ENDFOR
ELSE
	GKKDisplayMsg("Copy Text not found")
ENDIF
ENDPROC
PROCEDURE Init
*IF EMPTY(thisform.clsCodeMax.SelText)
*	_CLIPTEXT = thisform.clsCodeMax.Text
*ELSE
*	_CLIPTEXT = thisform.clsCodeMax.SelText
*ENDIF
ENDPROC
     ���    �  �                        �   %         �  %   C          �  U  �  ���  ��� � T�� � ��� ��� T�� � ��� ��� T�� � ��� ��� T�� � ��� ���! T�� � ��� � �� � ��� T�� � ��� �
�� T��	 � ��� �
�� T��	 �
 ���
 ��	 � ��� �� U  THISFORM	 CMDDELETE TOP HEIGHT
 CMDRESTORE CMDSAVE CMDCOPY LSTCOPYLIST CLSSPLITTER
 CLSCODEMAX WIDTH LEFTI ��  � ��� ��B�7 ��C�
 clsCodeMax� CodeMax� GKKClipCodeMax.vcx�� �� ���� ��� � T�� ���� T�� �� � � ��� T�� �� � �
�� T��	 �� �	 �� ��� T��
 �a�� T�� �a�� �� ��C�� � �� ��C�� ��+ T�  �CC� Form�� � -SplitterPos� g�� %��  � ��>� T�� � ��  �� ��C�� � �� � �� U  LNVALUE THISFORM	 NEWOBJECT
 CLSCODEMAX TOP LEFT CLSSPLITTER HEIGHT THIS WIDTH READONLY VISIBLE CLSWINDOWPOSITION RESTORE RESIZE GKKGETSTRING_VFP NAME SPLITN  ���  ��G � ��C�� � ��, ��C� Form�� � -SplitterPos�� � � �� �� U  THISFORM CLSWINDOWPOSITION SAVE GKKSETSTRING_VFP NAME CLSSPLITTER LEFT Resize,     �� Initz    �� Destroyt    ��1 � aaaaaa�A 2 q � q� � �Q�� � A � � �� A A 2 � � �A 1                       x        �  v         �  #  "    )   �                  0%   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _31K0N0QX01027691920�      �	  ^	      n	                      �  �              �               COMMENT RESERVED                        �      z                                                           WINDOWS _31L0YJ20A1027768539}      �  �      �                      �  �              {               COMMENT RESERVED                        7                                                                   WINDOWS _3B91ALY6H1059958171�      �  �      '                      �  �              o
               COMMENT RESERVED                        @
      �                                                           WINDOWS _3B91AMS561059958190:      c  G      �                      $  1                             COMMENT RESERVED                        U                                                                   WINDOWS _3BA1B4P311060024182      p  �      �                      �  �              �               COMMENT RESERVED                        X                                                                   WINDOWS _3CD0X51L11062697852�      %	  �      �                      �  �              �               COMMENT RESERVED                        �                                                                   WINDOWS _3CJ0JYKAC1063078492|      �  �      �                      Q	  �	              C	               COMMENT RESERVED                        6	                                                                   WINDOWS _3CJ0JZ8FM1063078528i      F  W      �                      �  �	              �               COMMENT RESERVED                        i                                                                   WINDOWS _0UW18BM8S1063086287�      v  �      ;$        ]!          �  	  �          �               COMMENT RESERVED                        �      �                                                           WINDOWS _2NS1CNK6K1063213547      �  V      �                      �    �          P
               COMMENT RESERVED                        -
                                                                   WINDOWS _3F60XKFBI1077837078)      g  8      \                        =                             COMMENT RESERVED                        �                                                                   WINDOWS _21A0ZMCA21078898252      i  )      �)      �  ]               �          �               COMMENT RESERVED                        �      �                                                           WINDOWS _3FS0UT99N1079341781�      o  �      {                      �  �              �               COMMENT RESERVED                        �      -                                                           WINDOWS _3N31B53QX1097510922 
      �	  
      �	                      F  =              S               COMMENT RESERVED                        a                                                                   WINDOWS _14X0R4ZMP1217428747v      �  �      
.      �  4          `  m  �          R               COMMENT RESERVED                        A                                                                 WINDOWS _1V50XQICP1230590136,      �  ;      j      �
  �            #  K                         COMMENT RESERVED                        �      �                                                           WINDOWS _0UY13Q5CE1251509170H      �  v      Y1      �'  D          |  �  +#          n               COMMENT RESERVED                        ^
      E                                                           WINDOWS _0VB0YA1D81335526353g      �  |      65      8  �          Q  ^  }
          �               COMMENT RESERVED                        ;                                                                  9d                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      	_checkbox      Pixels      Class      1      checkbox      	_checkbox      checkbox      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      _listbox      Pixels      Class      Pixels      1      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      _commandbutton      Class      1      commandbutton      _commandbutton      commandbutton      Class      
collection      1      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      _textbox      Pixels      Class      1      textbox      _textbox      F_memberdata XML Metadata for customizable properties
*value_assign 
      textbox      _grid      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      _optiongroup      Pixels      Class      1      optiongroup      _optiongroup      1      	pageframe      
_pageframe      	pageframe      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      _spinner      Pixels      Class      1      spinner      ����    �   �                         �N   %   b       �      x           �  U    ��  � T� � ���  �� U  VNEWVAL THIS VALUE value_assign,     ��1 q "2                       x       )   �                         >Caption = "Page1"
Height = 200
Width = 200
Name = "_page"
      Pixels      Class      1      shape      _shape      _shape      shape      shape      label      1      listbox      _listbox      �_memberdata XML Metadata for customizable properties
lastlistitemid Last selected listitem ID value
^itemlist[1,0] Pointers to items in list
*addlistrow Adds items to row with columns
      listbox      
_container      Pixels      Class      1      	container      
_container      ?Width = 200
Height = 200
BackStyle = 0
Name = "_container"
      	container      _page      Pixels      Class      _spinner      -Height = 24
Width = 121
Name = "_spinner"
      spinner      1      1      image      9BackStyle = 0
Height = 20
Width = 20
Name = "_image"
      _image      image      _collection      _editbox      Pixels      	_combobox      Pixels      Z_memberdata XML Metadata for customizable properties
*onclick User Click() event method
      �PROCEDURE value_assign
LPARAMETERS vNewVal
*To do: Modify this routine for the Assign method
THIS.Value = m.vNewVal

ENDPROC
      RHeight = 23
SelectOnEntry = .T.
Width = 284
_memberdata = 
Name = "_textbox"
      _label      ]AutoSize = .T.
BackStyle = 0
Caption = "Label1"
Height = 17
Width = 40
Name = "_label"
      _label      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      Pixels      Class      �_memberdata XML Metadata for customizable properties
previousoptionvalue Previously selected optionvalue; set in the default InteractiveChange event
^itemvalues[1,4] Array of user defined values
*enabled_assign 
      optiongroup      page      Class      Pixels      page      1      }_memberdata XML Metadata for customizable properties
tag2 Additional data
*userinteractivechange Called InteractiveChange
      1      Class      Pixels      _image      grid      +Height = 200
Width = 320
Name = "_grid"
      _grid      grid      1      Class      Pixels      Class      Class      shape      1      
collection      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      _collection      
_pageframe      Pixels      +Height = 17
Width = 100
Name = "_shape"
      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      1      �ErasePage = .T.
MemberClassLibrary = gkkbaseclasses.vcx
MemberClass = "_page"
PageCount = 2
Width = 241
Height = 169
Themes = .F.
Name = "_pageframe"
_page1.Name = "_page1"
_page2.Name = "_page2"
      _page      NHeight = 41
Width = 191
BackStyle = 0
SpecialEffect = 0
Name = "_border"
      -Height = 65
Width = 205
Name = "_editbox"
      <Width = 391
Height = 60
BackStyle = 0
Name = "_control"
      _border      label      Class     -PROCEDURE enabled_assign
LPARAMETERS tEnabled
This.Enabled = tEnabled
FOR lnButton=1 TO this.ButtonCount
	this.Buttons(lnButton).Enabled = tEnabled
ENDFOR
ENDPROC
PROCEDURE InteractiveChange
this.PreviousOptionValue = this.Value
ENDPROC
PROCEDURE Init
this.Enabled = this.Enabled
ENDPROC
      _control      Pixels      Class      control      _control      combobox      _border      control      	_combobox      combobox      editbox      _editbox      editbox      Pixels      �_memberdata XML Metadata for customizable properties
currentkey Currently selected key
mainkey Handle to the main key
*closeall User implemented close all method
     +PROCEDURE LostFocus
this.FontBold = .F.
ENDPROC
PROCEDURE GotFocus
this.FontBold = .T.
ENDPROC
PROCEDURE MouseEnter
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.FontBold = .T.
ENDPROC
PROCEDURE MouseLeave
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.FontBold = .F.
ENDPROC
     Height = 23
Width = 23
_memberdata = <VFPData><memberdata name="closeall" type="method" display="CloseAll"/><memberdata name="currentkey" display="CurrentKey"/><memberdata name="mainkey" display="MainKey"/></VFPData>
currentkey = .NULL.
mainkey = .NULL.
Name = "_collection"
     g���    N  N                        J�   %   O      �     �          �  U  $  ��  � � � � T� � �-�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS FONTBOLD$  ��  � � � � T� � �a�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS FONTBOLD  T�  � �-�� U  THIS FONTBOLD  T�  � �a�� U  THIS FONTBOLD  ��C�  � �� U  THIS ONCLICK
 MouseLeave,     ��
 MouseEnter�     ��	 LostFocus�     �� GotFocus    �� Click,    ��1 1� 2 1� 2 � 2 � 2 � 1                       X         y   �         �   �   	   	              <  J      )   N                       ����    �  �                        �   %   �      3               �  U  � ' ��  � � � � � � � � � ��	 �
 �# ��	 ���(�C� � C�t�F��� � T�
 �� tcItemC�	 _�� ��CC�
 � �   �	 � � �� �� U  TNITEMID TCITEM1 TCITEM2 TCITEM3 TCITEM4 TCITEM5 TCITEM6 TCITEM7 TCITEM8 LNCNT LCPARM THIS COLUMNCOUNT ADDLISTITEM
  ��  � U 
 TNLISTTYPEC  ��  � %�C�t� ��% � T�  ���� � B�C� �  �  � � �� U  TNCOL THIS LISTITEM
 LISTITEMID
 addlistrow,     �� setlistvalues@    �� getcolvalueforselecteditemZ    ��1 q� 1��A 2 q 2 q � A q1                               B  X  	   
   �  �      )   �                       +PROCEDURE addlistrow
LPARAMETERS tnItemID, tcItem1, tcItem2, tcItem3, tcItem4, tcItem5, tcItem6, tcItem7, tcItem8
LOCAL lnCnt, lcParm
FOR lnCnt=1 TO MIN(This.ColumnCount, PCOUNT()-1)
  lcParm = "tcItem" + TRANSFORM(lnCnt)
  this.AddListItem(EVALUATE(lcParm), tnItemID, lnCnt)
ENDFOR
ENDPROC
     !���                              |B   %   ,      �     y          �  U    T�  � �-�� U  THIS FONTBOLD  T�  � �a�� U  THIS FONTBOLD$  ��  � � � � T� � �a�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS FONTBOLD$  ��  � � � � T� � �-�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS FONTBOLD	 LostFocus,     �� GotFocusQ     ��
 MouseEnterv     ��
 MouseLeave�     ��1 � 2 � 2 1� 2 1� 1                       (         G   Z         {   �         �          )                          ����    �  �                        �~   %         v     `          �  U  Q  ��  � T� � ��  �� �� ���(�� � ��J � T� � �� �� ��  �� �� U  TENABLED THIS ENABLED LNBUTTON BUTTONCOUNT BUTTONS  T�  � ��  � �� U  THIS PREVIOUSOPTIONVALUE VALUE  T�  � ��  � �� U  THIS ENABLED enabled_assign,     �� InteractiveChange�     �� Init�     ��1 q ��A 2 12 11                       �         �   �      	     "      )   �                       ����    �  �                        �   %   @      d     T          �  U  � ' ��  � � � � � � � � � ��	 �
 �# ��	 ���(�C� � C�t�F��� � T�
 �� tcItemC�	 _�� ��CC�
 � �   �	 � � �� �� U  TNITEMID TCITEM1 TCITEM2 TCITEM3 TCITEM4 TCITEM5 TCITEM6 TCITEM7 TCITEM8 LNCNT LCPARM THIS COLUMNCOUNT ADDLISTITEM
 addlistrow,     ��1 q� 1��A 1                              )   �                       _memberdata XML Metadata for customizable properties
^itemlist[1,0] Pointers for items in list
*addlistrow Adds items to row with columns
*setlistvalues Sets the list values
*getcolvalueforselecteditem Returns the column value for the currently selected item
     RHeight = 122
Width = 167
ItemTips = .T.
_memberdata =      227<VFPData><memberdata name="addlistrow" type="method" display="AddListRow"/><memberdata name="itemlist" type="property" display="ItemList"/><memberdata name="lastlistitemid" type="property" display="LastListItemID"/></VFPData>

lastlistitemid = 0
Name = "_listbox"
     �PROCEDURE addlistrow
LPARAMETERS tnItemID, tcItem1, tcItem2, tcItem3, tcItem4, tcItem5, tcItem6, tcItem7, tcItem8
LOCAL lnCnt, lcParm
FOR lnCnt=1 TO MIN(This.ColumnCount, PCOUNT()-1)
	lcParm = "tcItem" + TRANSFORM(lnCnt)
	this.AddListItem(EVALUATE(lcParm), tnItemID, lnCnt)
ENDFOR
ENDPROC
PROCEDURE setlistvalues
LPARAMETERS tnListType
ENDPROC
PROCEDURE getcolvalueforselecteditem
LPARAMETERS tnCol
IF PCOUNT() = 0
	tnCol = 2
ENDIF
RETURN this.ListItem(this.ListItemId, tnCol)
ENDPROC
     nMemberClassLibrary = ..\programs\gkkoptionmbrclass.prg
MemberClass = "GKKOption"
ButtonCount = 1
BackStyle = 0
BorderStyle = 0
Value = 1
Height = 67
Width = 142
_memberdata =      281<VFPData><memberdata name="itemvalues" type="property" display="ItemValues"/><memberdata name="previousoptionvalue" type="property" display="PreviousOptionValue"/><memberdata name="enabled" display="Enabled"/><memberdata name="enabled_assign" display="Enabled_Assign"/></VFPData>

previousoptionvalue = 1
Name = "_optiongroup"
GKKOPTION1.Value = 1
GKKOPTION1.Left = 5
GKKOPTION1.Top = 5
GKKOPTION1.Name = "GKKOPTION1"
     GHeight = 17
Width = 60
AutoSize = .T.
Alignment = 0
BackStyle = 0
Caption = "Check1"
Value = .F.
_memberdata =      165<VFPData><memberdata name="userinteractivechange" type="method" display="UserInteractiveChange"/><memberdata name="tag2" type="property" display="Tag2"/></VFPData>

tag2 = 
Name = "_checkbox"
     �Height = 24
SpecialEffect = 2
Style = 2
Width = 100
BorderColor = 127,157,185
ItemTips = .T.
_memberdata =      321<VFPData><memberdata name="addlistrow" type="method" display="AddListRow"/><memberdata name="itemlist" type="property" display="ItemList"/><memberdata name="setlistvalues" type="method" display="SetListValues"/><memberdata name="getcolvalueforselecteditem" type="method" display="GetColValueForSelectedItem"/></VFPData>

Name = "_combobox"
     �Height = 27
Width = 84
Caption = "Command1"
SpecialEffect = 2
_memberdata =       81<VFPData><memberdata name="onclick" type="method" display="OnClick"/></VFPData>

Name = "_commandbutton"
     UPROCEDURE MouseLeave
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.FontBold = .F.
ENDPROC
PROCEDURE MouseEnter
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.FontBold = .T.
ENDPROC
PROCEDURE LostFocus
this.FontBold = .F.
ENDPROC
PROCEDURE GotFocus
this.FontBold = .T.
ENDPROC
PROCEDURE Click
this.OnClick()
ENDPROC
0   m                 �  PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _1890LRE8T1019720086�              �  )    ��          �  �  �
          o  }           COMMENT RESERVED                                                                                           WINDOWS _1890LRE8T1048883008�      �
  
      3  2  �9  ��          �  �            r  �           COMMENT RESERVED                        "                                                                   WINDOWS _3C80O3P7G1062363892b�      �  Q�      )�  ��  ��  �          |�  s�  ��          ��               WINDOWS _3C80PC26G1062363892g�      t�  ��  ��  ��      9�   x                                               COMMENT RESERVED                        ԋ                                                                   WINDOWS _3C80OD4IN10829564764z      ��  Ez      �~  �y  U�   e          z  +z  @|          z               WINDOWS _3C80PL8XW10623637763|      &|  |  |  n{      Vz  8c                                               COMMENT RESERVED                        �y                                                                    �s                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      	hsplitter      >readme^
hidecontrols^
showcontrols^
hiddencontrols^
Init
      Pixels      \Up-Down Splitter class. Support ActiveX controls. Author: gerald.santerre@siteintranet.qc.ca      Class      1      shape      	hsplitter      shape      splitter      8readme^
hidecontrols^
showcontrols^
hiddencontrols^
      Pixels      _Left-Right Splitter class. Support ActiveX controls. Author: gerald.santerre@siteintranet.qc.ca      Class      1      shape      splitter     rangemin The splitter can be dragged to the left side down to this value. Pixels from the left side of the parent. Value < 1 is percent of parent width.
rangemax The splitter can be dragged to the right side up to this value. Pixels from the left side of the parent. Value < 1 is percent of parent width.
_memberdata XML Metadata for customizable properties
*readme 
*hidecontrols internal use
*showcontrols internal use
*split This method is called at the end of a split operation
^hiddencontrols[1,1] Array of controls
     mHeight = 203
Width = 4
MousePointer = 9
SpecialEffect = 0
rangemin = 0.2
rangemax = 0.8
_memberdata =      479<VFPData><memberdata name="hiddencontrols" type="property" display="HiddenControls"/><memberdata name="hidecontrols" type="method" display="HideControls"/><memberdata name="rangemax" type="property" display="RangeMax"/><memberdata name="rangemin" type="property" display="RangeMin"/><memberdata name="readme" type="method" display="ReadMe"/><memberdata name="showcontrols" type="method" display="ShowControls"/><memberdata name="split" type="method" display="Split"/></VFPData>

Name = "splitter"
      shape     �rangemin The splitter can be dragged to the top down to this value. Value < 1 is percent of parent height.
rangemax The splitter can be dragged to the bottom up to this value. Pixels from the top of the parent. Value < 1 is percent of parent height.
_memberdata XML Metadata for customizable properties
*readme 
*hidecontrols internal use
*showcontrols internal use
*split This method is called at the end of the split operation.
^hiddencontrols[1,1] Array of controls
     nHeight = 4
Width = 100
MousePointer = 7
SpecialEffect = 0
rangemin = 0.2
rangemax = 0.8
_memberdata =      479<VFPData><memberdata name="hiddencontrols" type="property" display="HiddenControls"/><memberdata name="hidecontrols" type="method" display="HideControls"/><memberdata name="rangemax" type="property" display="RangeMax"/><memberdata name="rangemin" type="property" display="RangeMin"/><memberdata name="readme" type="method" display="ReadMe"/><memberdata name="showcontrols" type="method" display="ShowControls"/><memberdata name="split" type="method" display="Split"/></VFPData>

Name = "hsplitter"
     (�PROCEDURE readme
*!*	Splitter class
*!*	May 2004

*!*	Active-X controls always drive me nuts because they use there own windows handle.
*!*	You cannot put a fox native control over them to resize the control visually.
*!*	You have to use some tricks like changing the control to 
*!*	another one for this operation and rechange it back after.
*!*	( See the class browser code )

*!*	What I want is a splitter that can handle this in a visual way 
*!*	while keeping the form (look) unchanged until the end of the split.

*!*	After many try and fail, I have finally found a way to do it
*!*	by the use of API calls. IT WORK!!!
*!* Days of work to end with only a couple of code lines :)

*!*	I am not an API guru, so if you find a way to improve this class
*!*	feel free to let me know how :)

*!*	Tested with VFP 8-7 on Windows 2000 
*!*	(no animal other than the usual fox was used in the tests)
*!*	Disclaimer: (...) <- put the usual disclaimer here!

*!*	G�rald Santerre
*!*	gerald.santerre@siteintranet.qc.ca


*!*		USAGE:

*!*		Drop this class on a form or a container between the objects that share the container. 

*!*	New release, complete redesing.
*!*	If you already use a previous version of the class, read this carefully. 
*!*	I have removed a couple of properties and change the way the classes work. 
*!*	For this reason I have also renamed the classlib to avoid conflicts 
*!*	with previous version of the class. The new design is cleaner and the control 
*!*	don't touch anything in the form (except hiding controls during split). 

*!*	A large part of the new design is from suggestions received 
*!*	from "Jarom�r Stacha" from Czech Republic. 
*!*		Thank you Jaromir :). 

*!*	The new splitter classes don't move or resize controls anymore. 
*!*	The splitter.split() method is always called after a split operation 
*!*	and you have to resize/reposition your controls from this (fake)event. 
*!*	If you don't put code in the split() method, the form.resize() event 
*!*	of the form will be called. See the resize() and splitter1.split() 
*!*	method of the demo form for a working sample.

*!*	You have only 2 properties to set in the class, 
*!*	RangeMin and RangeMax. 
*!*	If you set the value of this properties between 0 and 1, 
*!*	the value is handled as a % of the splitter's parent container width ot height. 
*!*	For example, if you enter 0.2 as value for RangeMin, 
*!*	you will be able to move the splitter down to 20% of the width/height 
*!*	of the splitter's parent container. 
*!*	Values greater than 1 will be handle as absolute values. 
*!*	Don't forget to reset absolute values when the splitter's parent container is resized.

*!*	The splitter API is now self contained and you dont have 
*!*	to worry about releasing the references to API functions. 
*!*	The splitter now also handle correctly multiple instances 
*!*	of the same form (or forms with the same name). 
*!*	The splitter automatically hide every controls that are in 
*!*	the same parent container (recursive) to avoid side effects 
*!*	(like mouse cursor beam over text boxes).

*!*	Contact: gerald.santerre@siteintranet.qc.ca

ENDPROC
PROCEDURE hidecontrols
* hide all controls include ActiveX with property visible inside container tObject
* without this splitter and form

LPARAMETERS tObject,nIndex
*	tObject is root object, if not passed, thisform is used
IF EMPTY(nIndex)
	nIndex=2
ENDIF 

LOCAL lcObjectBaseClass, lObject, lTempObject
* build collection hidden object for reverse setting in showcontrols
* set valid object
IF VARTYPE(tObject)="O"
	lObject= tObject
ELSE
	lObject= THISFORM
ENDIF

* ignore this splitter
IF lObject = THIS
	RETURN nIndex
ENDIF

* unify
lcObjectBaseClass = LOWER(lObject.BASECLASS)+" " && " " for unique (page # pageframe)

* do not hide form window
IF lcObjectBaseClass # "form " AND PEMSTATUS(lObject,"visible",5)
	IF lObject.VISIBLE
		DIMENSION this.HiddenControls[nIndex]
		this.hiddencontrols[nIndex]=lObject
		lObject.VISIBLE = .F.
		nIndex=nIndex+1
	ENDIF
ENDIF

* recurse for all children
DO CASE
	CASE INLIST(lcObjectBaseClass,"pageframe ")
		FOR EACH lTempObject IN lObject.PAGES
			nIndex=THIS.hidecontrols(lTempObject,nIndex)
		ENDFOR
	CASE INLIST(lcObjectBaseClass,"form ","container ","page ")
		FOR EACH lTempObject IN lObject.CONTROLS
			nIndex=THIS.hidecontrols(lTempObject,nIndex)
		ENDFOR
	CASE INLIST(lcObjectBaseClass,"commandgroup ","optiongroup ")
		FOR EACH lTempObject IN lObject.BUTTONS
			nIndex=THIS.hidecontrols(lTempObject,nIndex)
		ENDFOR
ENDCASE

RETURN nIndex+1
ENDPROC
PROCEDURE showcontrols
* show temporary hidden objects and clear list (collection)
LPARAMETERS toRoot

IF ALEN(THIS.hiddencontrols,1)<2
	RETURN
ENDIF
FOR i=2 TO ALEN(THIS.hiddencontrols,1)
	IF TYPE("THIS.hiddencontrols[i]")="O"
		THIS.hiddencontrols[i].Visible=.T.
	ENDIF 	
ENDFOR

DIMENSION THIS.hiddencontrols[1]

ENDPROC
PROCEDURE split
*default behaviour
THISFORM.RESIZE()
ENDPROC
PROCEDURE Init
this.BorderStyle = 0
ENDPROC
PROCEDURE MouseDown
LPARAMETERS nButton, nShift, nXCoord, nYCoord
LOCAL lcWindowName,lnScaleMode,lnMinRow,lnMaxRow,lnMRow1,lnMRow2
LOCAL lnRows,lnTop,lnOldTop,lnMin,oldMRow2
LOCAL llLockScreen,lnMousePointer
LOCAL lhDC,lhMemDC,lhMemBmp,lHWnd,lnBmpHeight,nLeftOffset,nTopOffset,oContainer,xHeight
LOCAL lcOldFormName,lhMemSplit

IF nButton#1
	RETURN
ENDIF

lcOldFormName = THISFORM.NAME
THISFORM.NAME = SYS(2015)

lcWindowName=THISFORM.NAME
lnScaleMode=THISFORM.SCALEMODE
THISFORM.SCALEMODE=3  && pixels

oContainer=THIS.PARENT
nLeftOffset=OBJTOCLIENT(THIS,2)-THIS.LEFT
nTopOffset=OBJTOCLIENT(THIS,1)-THIS.TOP

lnMRow1=MROW(lcWindowName,3)
IF TYPE("lnMRow1")#"N" OR lnMRow1<=0
	THISFORM.SCALEMODE=lnScaleMode
	THISFORM.NAME = lcOldFormName
	RETURN
ENDIF

lnMRow1=lnMRow1-nTopOffset
IF lnMRow1 <> THIS.TOP+1
	lnMRow1 = THIS.TOP+1
	MOUSE AT lnMRow1+nTopOffset, MCOL(lcWindowName,3) PIXELS WINDOW (lcWindowName)
ENDIF

* set some vars
llLockScreen=THISFORM.LOCKSCREEN
lnMousePointer=THISFORM.MOUSEPOINTER
THISFORM.MOUSEPOINTER= 7
lnTop=THIS.TOP

* check two parent level for Height- suppose that parent form always present
IF PEMSTATUS(oContainer,"Height",5)
	xHeight	=	oContainer.HEIGHT
ELSE
	IF PEMSTATUS(oContainer.PARENT,"PageHeight",5)
		xHeight	=	oContainer.PARENT.PAGEHEIGHT
	ELSE
		* if error that oContainer.Height and oContainer.parent.width not exist, something wrong
		xHeight	=	oContainer.PARENT.HEIGHT
	ENDIF
ENDIF

* RangeMin (RangeMax) < 1
* 		RangeMin (RangeMax) are used as coeficient (%/100)
* RangeMin (RangeMax) > 1
*		RangeMin (RangeMax) are used as absolute offset in pixels
* RangeMin (RangeMax) =0
*		RangeMin (RangeMax) are ignored - no restriction
DO CASE
	CASE THIS.RangeMin <= 0
		lnMinRow=THIS.HEIGHT*2
	CASE THIS.RangeMin > 1
		lnMinRow=MAX(THIS.HEIGHT*2,INT(THIS.RangeMin))
	CASE THIS.RangeMin < 1
		lnMinRow=MAX(THIS.HEIGHT*2,INT(THIS.RangeMin*xHeight))
ENDCASE

DO CASE
	CASE THIS.RangeMax <= 0
		lnMaxRow=xHeight-(THIS.HEIGHT*3)
	CASE THIS.RangeMax > 1
		lnMaxRow=MIN(xHeight-(THIS.HEIGHT*3),THIS.RangeMax)
	CASE THIS.RangeMax < 1
		lnMaxRow=MIN(xHeight-(THIS.HEIGHT*3),THIS.RangeMax*xHeight)
ENDCASE

IF lnMinRow>lnMaxRow
	* nothing to move!!!
	THISFORM.SCALEMODE=lnScaleMode
	THISFORM.NAME = lcOldFormName
	RETURN
ENDIF

lnMRow2=lnMRow1
oldMRow2=lnMRow2

#DEFINE SRCCOPY		13369376

* API CALLS
IF THISFORM.SHOWWINDOW= 2
	* workaround, when showwindow=2 the handle is not the right one...
	* worst if you have a toolbar!
	*#define GW_HWNDFIRST        0
	#define GW_HWNDLAST         1
	*#define GW_HWNDNEXT         2
	*#define GW_HWNDPREV         3
	*#define GW_OWNER            4
	#define GW_CHILD            5

	lHWnd=THISFORM.HWND
	lHWnd=apiGetWindow(lHWnd,GW_CHILD)
	lHWnd=apiGetWindow(lHWnd,GW_HWNDLAST)
ELSE
	lHWnd=THISFORM.HWND
ENDIF

lhDC    = apiGetDC(lHWnd)
lhMemDC = apiCreateCompatibleDC(lhDC)
* Take a copy of the portion of the form that can be dragged over
lnBmpHeight = THIS.HEIGHT + 1
lhMemBmp    = apiCreateCompatibleBitmap(lhDC, THIS.WIDTH, lnBmpHeight)
lhMemSplit  = apiCreateCompatibleBitmap(lhDC, THIS.WIDTH, lnBmpHeight)
= apiSelectObject(lhMemDC , lhMemBmp)
= apiBitBlt(lhMemDC, 0, 0,  THIS.WIDTH, lnBmpHeight, lhDC, THIS.LEFT+nLeftOffset, lnMRow1-1+nTopOffset, SRCCOPY)
= apiSelectObject(lhMemDC , lhMemSplit)
= apiBitBlt(lhMemDC, 0, 0,  THIS.WIDTH, lnBmpHeight, lhDC, THIS.LEFT+nLeftOffset, lnMRow1-1+nTopOffset, SRCCOPY)

* Stop fox drawing in the screen
THISFORM.LOCKSCREEN=.T.
THIS.hidecontrols(oContainer)

* update the display while dragging
DO WHILE MDOWN()
	DOEVENTS
	lnMRow2=MROW(lcWindowName,3)-nTopOffset
	IF TYPE("lnMRow2")#"N" OR lnMRow2=0
		LOOP
	ENDIF
	IF lnMRow2<=lnMinRow
		*force the mouse to stay at this position
		MOUSE AT lnMinRow+nTopOffset, MCOL(lcWindowName,3) PIXELS WINDOW (lcWindowName)
		lnMRow2=lnMinRow+1
	ENDIF
	IF lnMRow2>=(lnMaxRow-THIS.HEIGHT)
		*force the mouse to stay at this position
		MOUSE AT lnMaxRow-THIS.HEIGHT+nTopOffset, MCOL(lcWindowName,3) PIXELS WINDOW (lcWindowName)
		lnMRow2=lnMaxRow-THIS.HEIGHT
	ENDIF
	lnMRow2=MIN(MAX(lnMRow2,lnMinRow),lnMaxRow)
	IF oldMRow2=lnMRow2
		LOOP
	ELSE
		* on mouse move, redraw a part of the screen from the memory copy
		* and draw "this" image at the mouse position
		* bitblt (dest...source...)
		WITH THIS
			.TOP=lnTop+(lnMRow2-lnMRow1)
			*restore
			= apiSelectObject(lhMemDC , lhMemBmp)
			= apiBitBlt(lhDC, .LEFT+nLeftOffset, oldMRow2-1+nTopOffset, .WIDTH, .HEIGHT+3, lhMemDC, 0, 0,  SRCCOPY)
			*take a new copy
			= apiBitBlt(lhMemDC, 0, 0,  THIS.WIDTH, lnBmpHeight, lhDC, THIS.LEFT+nLeftOffset, lnMRow2-1+nTopOffset, SRCCOPY)
			*draw
			= apiSelectObject(lhMemDC , lhMemSplit)
			= apiBitBlt(lhDC, .LEFT+nLeftOffset, .TOP+nTopOffset, .WIDTH, .HEIGHT+1, lhMemDC, 0, 0,  SRCCOPY)

		ENDWITH
		oldMRow2=lnMRow2
	ENDIF
ENDDO

THIS.showcontrols()
THISFORM.NAME = lcOldFormName

IF lnMRow2<0
	lnMRow2=lnMRow1
ENDIF

lnRows=lnMRow2-lnMRow1
THIS.TOP=lnTop+lnRows
THISFORM.SCALEMODE=lnScaleMode
THISFORM.MOUSEPOINTER=lnMousePointer

This.Split()

THISFORM.LOCKSCREEN=llLockScreen

* free the memory
= apiReleaseDC(lHWnd, lhDC)
= apiDeleteObject(lhMemBmp)
= apiDeleteObject(lhMemSplit)
= apiDeleteDC(lhMemDC)

ENDPROC
     )8PROCEDURE readme
*!*	Splitter class
*!*	May 2004

*!*	Active-X controls always drive me nuts because they use there own windows handle.
*!*	You cannot put a fox native control over them to resize the control visually.
*!*	You have to use some tricks like changing the control to 
*!*	another one for this operation and rechange it back after.
*!*	( See the class browser code )

*!*	What I want is a splitter that can handle this in a visual way 
*!*	while keeping the form (look) unchanged until the end of the split.

*!*	After many try and fail, I have finally found a way to do it
*!*	by the use of API calls. IT WORK!!!
*!* Days of work to end with only a couple of code lines :)

*!*	I am not an API guru, so if you find a way to improve this class
*!*	feel free to let me know how :)

*!*	Tested with VFP 8-7 on Windows 2000 
*!*	(no animal other than the usual fox was used in the tests)
*!*	Disclaimer: (...) <- put the usual disclaimer here!

*!*	G�rald Santerre
*!*	gerald.santerre@siteintranet.qc.ca


*!*		USAGE:

*!*		Drop this class on a form or in a container between
*!*		objects that share the same container (form,page or container).

*!*	New release, complete redesing.
*!*	If you already use a previous version of the class, read this carefully. 
*!*	I have removed a couple of properties and change the way the classes work. 
*!*	For this reason I have also renamed the classlib to avoid conflicts 
*!*	with previous version of the class. The new design is cleaner and the control 
*!*	don't touch anything in the form (except hiding controls during split). 

*!*	A large part of the new design is from suggestions received 
*!*	from "Jarom�r Stacha" from Czech Republic. 
*!*		Thank you Jaromir :). 

*!*	The new splitter classes don't move or resize controls anymore. 
*!*	The splitter.split() method is always called after a split operation 
*!*	and you have to resize/reposition your controls from this (fake)event. 
*!*	If you don't put code in the split() method, the form.resize() event 
*!*	of the form will be called. See the resize() and splitter1.split() 
*!*	method of the demo form for a working sample.

*!*	You have only 2 properties to set in the class, 
*!*	RangeMin and RangeMax. 
*!*	If you set the value of this properties between 0 and 1, 
*!*	the value is handled as a % of the splitter's parent container width ot height. 
*!*	For example, if you enter 0.2 as value for RangeMin, 
*!*	you will be able to move the splitter down to 20% of the width/height 
*!*	of the splitter's parent container. 
*!*	Values greater than 1 will be handle as absolute values. 
*!*	Don't forget to reset absolute values when the splitter's parent container is resized.

*!*	The splitter API is now self contained and you dont have 
*!*	to worry about releasing the references to API functions. 
*!*	The splitter now also handle correctly multiple instances 
*!*	of the same form (or forms with the same name). 
*!*	The splitter automatically hide every controls that are in 
*!*	the same parent container (recursive) to avoid side effects 
*!*	(like mouse cursor beam over text boxes).

*!*	Contact: gerald.santerre@siteintranet.qc.ca







ENDPROC
PROCEDURE hidecontrols
* hide all controls include ActiveX with property visible inside container tObject
* without this splitter and form

LPARAMETERS tObject,nIndex
*	tObject is root object, if not passed, thisform is used
IF EMPTY(nIndex)
	nIndex=2
ENDIF 

LOCAL lcObjectBaseClass, lObject, lTempObject
* build collection hidden object for reverse setting in showcontrols
* set valid object
IF VARTYPE(tObject)="O"
	lObject= tObject
ELSE
	lObject= THISFORM
ENDIF

* ignore this splitter
IF lObject = THIS
	RETURN nIndex
ENDIF

* unify
lcObjectBaseClass = LOWER(lObject.BASECLASS)+" " && " " for unique (page # pageframe)

* do not hide form window
IF lcObjectBaseClass # "form " AND PEMSTATUS(lObject,"visible",5)
	IF lObject.VISIBLE
		DIMENSION this.HiddenControls[nIndex]
		this.hiddencontrols[nIndex]=lObject
		lObject.VISIBLE = .F.
		nIndex=nIndex+1
	ENDIF
ENDIF

* recurse for all children
DO CASE
	CASE INLIST(lcObjectBaseClass,"pageframe ")
		FOR EACH lTempObject IN lObject.PAGES
			nIndex=THIS.hidecontrols(lTempObject,nIndex)
		ENDFOR
	CASE INLIST(lcObjectBaseClass,"form ","container ","page ")
		FOR EACH lTempObject IN lObject.CONTROLS
			nIndex=THIS.hidecontrols(lTempObject,nIndex)
		ENDFOR
	CASE INLIST(lcObjectBaseClass,"commandgroup ","optiongroup ")
		FOR EACH lTempObject IN lObject.BUTTONS
			nIndex=THIS.hidecontrols(lTempObject,nIndex)
		ENDFOR
ENDCASE

RETURN nIndex+1
ENDPROC
PROCEDURE showcontrols
* show temporary hidden objects and clear list (collection)
LPARAMETERS toRoot

IF ALEN(THIS.hiddencontrols,1)<2
	RETURN
ENDIF
FOR i=2 TO ALEN(THIS.hiddencontrols,1)
	IF TYPE("THIS.hiddencontrols[i]")="O"
		THIS.hiddencontrols[i].Visible=.T.
	ENDIF 	
ENDFOR

DIMENSION THIS.hiddencontrols[1]

ENDPROC
PROCEDURE split
*default behaviour
THISFORM.RESIZE()
ENDPROC
PROCEDURE Init
this.BorderStyle = 0
ENDPROC
PROCEDURE MouseDown
LPARAMETERS nButton, nShift, nXCoord, nYCoord
LOCAL lcWindowName,lnScaleMode,lnMinCol,lnMaxCol,lnMCol1,lnMCol2
LOCAL lnColumns,lnLeft,lnOldLeft,lnMin,oldMCol2
LOCAL llLockScreen,lnMousePointer
LOCAL lhDC,lhMemDC,lhMemBmp,lHWnd,lnBmpWidth,nLeftOffset,nTopOffset,oContainer,xWidth
LOCAL lcOldFormName,lhMemSplit

IF nButton#1
	RETURN
ENDIF

lcOldFormName = THISFORM.NAME
THISFORM.NAME = SYS(2015)

lcWindowName=THISFORM.NAME
lnScaleMode=THISFORM.SCALEMODE
THISFORM.SCALEMODE=3  && pixels

oContainer=THIS.PARENT
nLeftOffset=OBJTOCLIENT(THIS,2)-THIS.LEFT
nTopOffset=OBJTOCLIENT(THIS,1)-THIS.TOP

TRY
	lnMCol1=MCOL(lcWindowName,3)
CATCH
ENDTRY
IF TYPE("lnMCol1")#"N" OR lnMCol1<=0
	THISFORM.SCALEMODE=lnScaleMode
	THISFORM.NAME = lcOldFormName
	RETURN
ENDIF

lnMCol1=lnMCol1-nLeftOffset
IF lnMCol1 <> THIS.LEFT+1
	lnMCol1=THIS.LEFT+1
	MOUSE AT MROW(lcWindowName,3), lnMCol1+nLeftOffset PIXELS WINDOW (lcWindowName)
ENDIF

* set some vars
llLockScreen			=	THISFORM.LOCKSCREEN
lnMousePointer			=	THISFORM.MOUSEPOINTER
THISFORM.MOUSEPOINTER	=	9
lnLeft					=	THIS.LEFT

* check two parent level for width - suppose that parent form always present
IF PEMSTATUS(oContainer,"Width",5)
	xWidth	=	oContainer.WIDTH
ELSE
	IF PEMSTATUS(oContainer.PARENT,"PageWidth",5)
		xWidth	=	oContainer.PARENT.PAGEWIDTH
	ELSE
		* if error that oContainer.width and oContainer.parent.width not exist, something wrong
		xWidth	=	oContainer.PARENT.WIDTH
	ENDIF
ENDIF

* RangeMin (RangeMax) < 1
* 		RangeMin (RangeMax) are used as coeficient (%/100)
* RangeMin (RangeMax) > 1
*		RangeMin (RangeMax) are used as absolute offset in pixels
* RangeMin (RangeMax) =0
*		RangeMin (RangeMax) are ignored - let 2 times this.width
DO CASE
	CASE THIS.RangeMin <= 0
		lnMinCol=THIS.WIDTH*2
	CASE THIS.RangeMin > 1
		lnMinCol=MAX(THIS.WIDTH*2,INT(THIS.RangeMin))
	CASE THIS.RangeMin < 1
		lnMinCol=MAX(THIS.WIDTH*2,INT(THIS.RangeMin*xWidth))
ENDCASE

DO CASE
	CASE THIS.RangeMax <= 0
		lnMaxCol=xWidth-(THIS.WIDTH*3)
	CASE THIS.RangeMax > 1
		lnMaxCol=MIN(xWidth-(THIS.WIDTH*3),THIS.RangeMax)
	CASE THIS.RangeMax < 1
		lnMaxCol=MIN(xWidth-(THIS.WIDTH*3),THIS.RangeMax*xWidth)
ENDCASE

IF lnMinCol>lnMaxCol
	* nothing to move!!!
	THISFORM.SCALEMODE=lnScaleMode
	THISFORM.NAME = lcOldFormName
	RETURN
ENDIF

lnMCol2=lnMCol1
oldMCol2=lnMCol2

#DEFINE SRCCOPY		13369376

* API CALLS
IF THISFORM.SHOWWINDOW= 2
	* workaround, when showwindow=2 the handle is not the right one...
	* worst if you have a toolbar!
	*#define GW_HWNDFIRST        0
	#define GW_HWNDLAST         1
	*#define GW_HWNDNEXT         2
	*#define GW_HWNDPREV         3
	*#define GW_OWNER            4
	#define GW_CHILD            5

	lHWnd=THISFORM.HWND
	lHWnd=apiGetWindow(lHWnd,GW_CHILD)
	lHWnd=apiGetWindow(lHWnd,GW_HWNDLAST)
ELSE
	lHWnd=THISFORM.HWND
ENDIF

lhDC    = apiGetDC(lHWnd)
lhMemDC = apiCreateCompatibleDC(lhDC)
* Take a copy of the portion of the form that can be dragged over
lnBmpWidth = THIS.WIDTH+1
lhMemBmp   = apiCreateCompatibleBitmap(lhDC, lnBmpWidth, THIS.HEIGHT)
lhMemSplit = apiCreateCompatibleBitmap(lhDC, lnBmpWidth, THIS.HEIGHT)
= apiSelectObject(lhMemDC , lhMemBmp)
= apiBitBlt(lhMemDC, 0, 0, lnBmpWidth, THIS.HEIGHT, lhDC, lnMCol1+nLeftOffset-2, THIS.TOP+nTopOffset, SRCCOPY)
= apiSelectObject(lhMemDC , lhMemSplit)
= apiBitBlt(lhMemDC, 0, 0, lnBmpWidth, THIS.HEIGHT, lhDC, lnMCol1+nLeftOffset-1, THIS.TOP+nTopOffset, SRCCOPY)

* Stop fox drawing in the screen
THISFORM.LOCKSCREEN=.T.
THIS.hidecontrols(oContainer)

* update the display while dragging
DO WHILE MDOWN()
	DOEVENTS
	lnMCol2=MCOL(lcWindowName,3)-nLeftOffset
	IF TYPE("lnMCol2")#"N" OR lnMCol2=0
		LOOP
	ENDIF
	IF lnMCol2<=lnMinCol
		*force the mouse to stay at this position
		MOUSE AT MROW(lcWindowName,3), lnMinCol+nLeftOffset PIXELS WINDOW (lcWindowName)
		lnMCol2=lnMinCol+1
	ENDIF
	IF lnMCol2>=(lnMaxCol-THIS.WIDTH)
		*force the mouse to stay at this position
		MOUSE AT MROW(lcWindowName,3), lnMaxCol-THIS.WIDTH+nLeftOffset+1 PIXELS WINDOW (lcWindowName)
		lnMCol2=lnMaxCol-THIS.WIDTH
	ENDIF
	lnMCol2=MIN(MAX(lnMCol2,lnMinCol),lnMaxCol)
	IF oldMCol2=lnMCol2
		LOOP
	ELSE
		* on mouse move, redraw a part of the screen from the memory copy
		* and draw "this" image at the mouse position
		* bitblt (dest...source...)
		WITH THIS
			.LEFT=lnLeft+(lnMCol2-lnMCol1)
			*restore
			= apiSelectObject(lhMemDC , lhMemBmp)
			= apiBitBlt(lhDC, oldMCol2+nLeftOffset-2, .TOP+nTopOffset, lnBmpWidth, .HEIGHT, lhMemDC, 0, 0,  SRCCOPY)
			*take a new copy
			= apiBitBlt(lhMemDC, 0, 0, lnBmpWidth, THIS.HEIGHT, lhDC, lnMCol2+nLeftOffset-2, THIS.TOP+nTopOffset, SRCCOPY)
			*draw the bar
			= apiSelectObject(lhMemDC , lhMemSplit)
			= apiBitBlt(lhDC, .LEFT+nLeftOffset-1, .TOP+nTopOffset, lnBmpWidth, .HEIGHT, lhMemDC, 0, 0,  SRCCOPY)
		ENDWITH
		oldMCol2=lnMCol2
	ENDIF
ENDDO

THIS.showcontrols()

THISFORM.NAME = lcOldFormName
IF lnMCol2<0
	lnMCol2=lnMCol1
ENDIF
lnColumns=lnMCol2-lnMCol1
THIS.LEFT=lnLeft + lnColumns
THISFORM.SCALEMODE=lnScaleMode
THISFORM.MOUSEPOINTER=lnMousePointer

This.Split()

THISFORM.LOCKSCREEN=llLockScreen

* free the memory
= apiReleaseDC(lHWnd, lhDC)
= apiDeleteObject(lhMemBmp)
= apiDeleteObject(lhMemSplit)
= apiDeleteDC(lhMemDC)

ENDPROC
     ����    �  �                        �<   %         N     @          �  U  6  ��  � � � �  ��C �   �  �  � � � � �� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS PARENT
 MOUSEENTER6  ��  � � � �  ��C �   �  �  � � � � �� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS PARENT	 MOUSEDOWN
 MouseEnter,     ��	 MouseDown�     ��1 12 11                       ~         �         )   �                       ����    �  �                        �   %   b      F  �   �          �  U  X ��  � � %�C� ���' � T� ���� � �� � � � %�C�  ��� O��\ � T� ��  �� �q � T� �� �� � %�� � ��� �	 B�� �� � T� �C� � @�  ��- %�� � form � C� � visible��h	��0� %�� � ��,� � �	 �� �� T� �	 �� ��� �� T� � �-�� T� �� ��� � � H�A�D� �C� �
 pageframe ����� �� � �
 ��� T� �C �  � � � �� ��, �C� � form �
 container � page ����� �� � � ��� T� �C �  � � � �� ��. �C� � commandgroup � optiongroup ���D� �� � � �@� T� �C �  � � � �� �� � B�� ��� U  TOBJECT NINDEX LCOBJECTBASECLASS LOBJECT LTEMPOBJECT THISFORM THIS	 BASECLASS VISIBLE HIDDENCONTROLS PAGES HIDECONTROLS CONTROLS BUTTONS�  ��  � %�C� � �����$ � B� � �� ���(�C� � ����� �* %�C� THIS.hiddencontrols[i]b� O��� � T� � �� �� �a�� � �� � � ���� U  TOROOT THIS HIDDENCONTROLS I VISIBLE  ��C�  � �� U  THISFORM RESIZE/ , T�  � � �C�  � ��  � � �8�� U  THIS IMGSPLITTER TOP HEIGHT(	 ��  � � � � �� � � � � �	 � ��
 � � � � � �� � �' �� � � � � � � � � � �� � � %��  ���� � B� � T� �� � �� T� � �C��]�� T� �� � �� T� �� � �� T� � ���� T� �� �  �� T� �C� ��]� �! �� T� �C� ��]� �" �� ��L� T� �C� ���� ��T� ��& %�C� lnMCol1b� N� � � ���� T� � �� �� T� � �� �� B� � T� �� � �� %�� � �! ���� T� �� �! ���! ��,�� ��C� ����� � �� � T� �� �# �� T� �� �$ �� T� �$ ��	�� T� �� �! �� %�C� � Width��h��s� T� �� �% �� ���" %�C� �  �	 PageWidth��h���� T� �� �  �& �� ��� T� �� �  �% �� � � H���p� �� �' � ��� T� �� �% ��� �� �' ���:� T� �C� �% �C� �' 8D�� �� �' ���p�" T� �C� �% �C� �' � 8D�� � H���� �� �( � ���� T� �� � �% ��� �� �( �����! T� �C� � �% �� �( F�� �� �( ����% T� �C� � �% �� �( � F�� � %�� � ��U� T� � �� �� T� � �� �� B� � T�	 �� �� T� ��	 �� %�� �) ����� T� �� �* �� T� �C � ��+ �� T� �C � ��+ �� ��� T� �� �* �� � T� �C � �, �� T� �C � �- �� T� �� �% ��� T� �C �  � � �/ �. �� T� �C �  � � �/ �. �� ��C �  � �0 ��= ��C � � �  � � �/  � � � �� �" � �  � �1 �� ��C �  � �0 ��= ��C � � �  � � �/  � � � �� �" � �  � �1 �� T� �# �a�� ��C � � �2 �� +�C���D� �� T�	 �C� ��� ��& %�C� lnMCol2b� N� �	 � ��[� .� � %��	 � ����! ��,�� ��C� ����� � �� T�	 �� ��� � %��	 � � �% ����, ��,�� ��C� ����� � �% � ��� T�	 �� � �% �� � T�	 �CC�	 � D� F�� %�� �	 ��/� .� �@� ��� ��/� T��! �� �	 � �� ��C �  � �0 ��9 ��C � � � ���" �  � ��/  � � � �  � �1 ��= ��C � � �  � � �/  � �	 � �� �" � �  � �1 �� ��C �  � �0 ��: ��C � ��! � ���" �  � ��/  � � � �  � �1 �� �� T� ��	 �� � � ��C� �3 �� T� � �� �� %��	 � ���� T�	 �� �� � T�
 ��	 � �� T� �! �� �
 �� T� � �� �� T� �$ �� �� ��C� �4 �� T� �# �� �� ��C �  � �5 �� ��C � �6 �� ��C � �6 �� ��C � �7 �� U8  NBUTTON NSHIFT NXCOORD NYCOORD LCWINDOWNAME LNSCALEMODE LNMINCOL LNMAXCOL LNMCOL1 LNMCOL2	 LNCOLUMNS LNLEFT	 LNOLDLEFT LNMIN OLDMCOL2 LLLOCKSCREEN LNMOUSEPOINTER LHDC LHMEMDC LHMEMBMP LHWND
 LNBMPWIDTH NLEFTOFFSET
 NTOPOFFSET
 OCONTAINER XWIDTH LCOLDFORMNAME
 LHMEMSPLIT THISFORM NAME	 SCALEMODE THIS PARENT LEFT TOP
 LOCKSCREEN MOUSEPOINTER WIDTH	 PAGEWIDTH RANGEMIN RANGEMAX
 SHOWWINDOW HWND APIGETWINDOW APIGETDC APICREATECOMPATIBLEDC APICREATECOMPATIBLEBITMAP HEIGHT APISELECTOBJECT	 APIBITBLT HIDECONTROLS SHOWCONTROLS SPLIT APIRELEASEDC APIDELETEOBJECT APIDELETEDC3  T�  � ��  � �� T�  � �� �� ��C�  � �� U  THIS RELATIVELEFT LEFT BORDERWIDTH RESIZE hidecontrols,     �� showcontrols    �� split�    �� Resize    ��	 MouseDownh    �� Init�    ��1 � � � A � S� � � A � A s�a� A A � �!�A �!�A �!�A A � 2 r �A A ��qA A 3 � 2 �2 1�q� q� A A 1��� !� A aA A �AA �� !1� 2A A � AAA�A!A � A�AAQA A A � � E
QQ� A "!B��!�!�� � A aaA A A ��AA qA � � q"��"�A � A A � � A A� #� � � 3 1� 1                       �     '   �  �  8   2     =  H   4   Z  �  L   6   �  �  O   �   �    
   )   �                       ����    �  �                        �<   %         N     @          �  U  6  ��  � � � �  ��C �   �  �  � � � � �� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS PARENT	 MOUSEDOWN6  ��  � � � �  ��C �   �  �  � � � � �� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS PARENT
 MOUSEENTER	 MouseDown,     ��
 MouseEnter�     ��1 12 11                       |         �         )   �                        	splitterv      /hidecontrols^
showcontrols^
hiddencontrols^
      Pixels      Class      2      	container      	splitterv     PROCEDURE MouseEnter
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.Parent.MouseEnter(nButton, nShift, nXCoord, nYCoord)
ENDPROC
PROCEDURE MouseDown
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.Parent.MouseDown(nButton, nShift, nXCoord, nYCoord)
ENDPROC
      �Picture = ..\graphics\gkkvsplitter.bmp
Height = 35
Left = 0
MousePointer = 9
Top = 82
Width = 3
ZOrderSet = 48
Name = "imgSplitter"
      	splitterv      imgSplitter      image      image     Mrangemin The splitter can be dragged to the left side down to this value. Pixels from the left side of the parent. Value < 1 is percent of parent width.
rangemax The splitter can be dragged to the right side up to this value. Pixels from the left side of the parent. Value < 1 is percent of parent width.
_memberdata XML Metadata for customizable properties
relativeleft Relative Left position to container before Resize event
*hidecontrols internal use
*showcontrols internal use
*split This method is called at the end of a split operation
^hiddencontrols[1,1] Array of controls
     {Width = 4
Height = 200
MousePointer = 9
rangemin = 0.2
rangemax = 0.8
_memberdata =      493<VFPData><memberdata name="hiddencontrols" type="property" display="HiddenControls"/><memberdata name="hidecontrols" type="method" display="HideControls"/><memberdata name="rangemax" type="property" display="RangeMax"/><memberdata name="rangemin" type="property" display="RangeMin"/><memberdata name="relativeleft" type="property" display="RelativeLeft"/><memberdata name="showcontrols" type="method" display="ShowControls"/><memberdata name="split" type="method" display="Split"/></VFPData>

relativeleft = 0
Name = "splitterv"
      	container     [Width = 200
Height = 4
MousePointer = 7
rangemin = 0.2
rangemax = 0.8
_memberdata =      479<VFPData><memberdata name="hiddencontrols" type="property" display="HiddenControls"/><memberdata name="hidecontrols" type="method" display="HideControls"/><memberdata name="rangemax" type="property" display="RangeMax"/><memberdata name="rangemin" type="property" display="RangeMin"/><memberdata name="readme" type="method" display="ReadMe"/><memberdata name="showcontrols" type="method" display="ShowControls"/><memberdata name="split" type="method" display="Split"/></VFPData>

Name = "splitterh"
     �rangemin The splitter can be dragged to the top down to this value. Value < 1 is percent of parent height.
rangemax The splitter can be dragged to the bottom up to this value. Pixels from the top of the parent. Value < 1 is percent of parent height.
_memberdata XML Metadata for customizable properties
*hidecontrols internal use
*showcontrols internal use
*split This method is called at the end of the split operation.
^hiddencontrols[1,1] Array of controls
      image      image      imgSplitter      	splitterh      �Picture = ..\graphics\gkkhsplitter.bmp
Height = 3
Left = 82
MousePointer = 7
Top = 1
Width = 35
ZOrderSet = 85
Name = "imgSplitter"
     PROCEDURE MouseDown
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.Parent.MouseDown(nButton, nShift, nXCoord, nYCoord)
ENDPROC
PROCEDURE MouseEnter
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.Parent.MouseEnter(nButton, nShift, nXCoord, nYCoord)
ENDPROC
      	splitterh      	container      2      Class      Pixels      5hidecontrols^
showcontrols^
hiddencontrols^
Init
      	splitterh     ����    �  �                        �	   %   '        �   �          �  U  X ��  � � %�C� ���' � T� ���� � �� � � � %�C�  ��� O��\ � T� ��  �� �q � T� �� �� � %�� � ��� �	 B�� �� � T� �C� � @�  ��- %�� � form � C� � visible��h	��0� %�� � ��,� � �	 �� �� T� �	 �� ��� �� T� � �-�� T� �� ��� � � H�A�D� �C� �
 pageframe ����� �� � �
 ��� T� �C �  � � � �� ��, �C� � form �
 container � page ����� �� � � ��� T� �C �  � � � �� ��. �C� � commandgroup � optiongroup ���D� �� � � �@� T� �C �  � � � �� �� � B�� ��� U  TOBJECT NINDEX LCOBJECTBASECLASS LOBJECT LTEMPOBJECT THISFORM THIS	 BASECLASS VISIBLE HIDDENCONTROLS PAGES HIDECONTROLS CONTROLS BUTTONS�  ��  � %�C� � �����$ � B� � �� ���(�C� � ����� �* %�C� THIS.hiddencontrols[i]b� O��� � T� � �� �� �a�� � �� � � ���� U  TOROOT THIS HIDDENCONTROLS I VISIBLE  ��C�  � �� U  THISFORM RESIZE   T�  � �� �� ��C�  � �� U  THIS BORDERWIDTH RESIZE	 ��  � � � � �� � � � � �	 � ��
 � � � � � �� � �' �� � � � � � � � � � �� � � %��  ���� � B� � T� �� � �� T� � �C��]�� T� �� � �� T� �� � �� T� � ���� T� �� �  �� T� �C� ��]� �! �� T� �C� ��]� �" �� T� �C� ����& %�C� lnMRow1b� N� � � ���� T� � �� �� T� � �� �� B� � T� �� � �� %�� � �" ����� T� �� �" ���! ��,�� ��� � ��C� ���� � T� �� �# �� T� �� �$ �� T� �$ ���� T� �� �" �� %�C� � Height��h��`� T� �� �% �� ���# %�C� �  �
 PageHeight��h���� T� �� �  �& �� ��� T� �� �  �% �� � � H���^� �� �' � ���� T� �� �% ��� �� �' ���(� T� �C� �% �C� �' 8D�� �� �' ���^�" T� �C� �% �C� �' � 8D�� � H�o�
� �� �( � ���� T� �� � �% ��� �� �( �����! T� �C� � �% �� �( F�� �� �( ���
�% T� �C� � �% �� �( � F�� � %�� � ��C� T� � �� �� T� � �� �� B� � T�	 �� �� T� ��	 �� %�� �) ����� T� �� �* �� T� �C � ��+ �� T� �C � ��+ �� ��� T� �� �* �� � T� �C � �, �� T� �C � �- �� T� �� �% ��� T� �C � � �/  � �. �� T� �C � � �/  � �. �� ��C �  � �0 ��= ��C � � � � �/  �  � � �! � � �� �  � �1 �� ��C �  � �0 ��= ��C � � � � �/  �  � � �! � � �� �  � �1 �� T� �# �a�� ��C � � �2 �� +�C���2� �� T�	 �C� ��� ��& %�C� lnMRow2b� N� �	 � ��I� .� � %��	 � ����! ��,�� ��� � ��C� ���� T�	 �� ��� � %��	 � � �% ����( ��,�� ��� � �% � ��C� ���� T�	 �� � �% �� � T�	 �CC�	 � D� F�� %�� �	 ��� .� �.� ��� ��� T��" �� �	 � �� ��C �  � �0 ��= ��C � ��! � � �� ��/ ��% � � � � �  � �1 ��= ��C � � � � �/  �  � � �! � �	 �� �  � �1 �� ��C �  � �0 ��: ��C � ��! � ��" � ��/ ��% � � � � �  � �1 �� �� T� ��	 �� � � ��C� �3 �� T� � �� �� %��	 � ��q� T�	 �� �� � T�
 ��	 � �� T� �" �� �
 �� T� � �� �� T� �$ �� �� ��C� �4 �� T� �# �� �� ��C �  � �5 �� ��C � �6 �� ��C � �6 �� ��C � �7 �� U8  NBUTTON NSHIFT NXCOORD NYCOORD LCWINDOWNAME LNSCALEMODE LNMINROW LNMAXROW LNMROW1 LNMROW2 LNROWS LNTOP LNOLDTOP LNMIN OLDMROW2 LLLOCKSCREEN LNMOUSEPOINTER LHDC LHMEMDC LHMEMBMP LHWND LNBMPHEIGHT NLEFTOFFSET
 NTOPOFFSET
 OCONTAINER XHEIGHT LCOLDFORMNAME
 LHMEMSPLIT THISFORM NAME	 SCALEMODE THIS PARENT LEFT TOP
 LOCKSCREEN MOUSEPOINTER HEIGHT
 PAGEHEIGHT RANGEMIN RANGEMAX
 SHOWWINDOW HWND APIGETWINDOW APIGETDC APICREATECOMPATIBLEDC APICREATECOMPATIBLEBITMAP WIDTH APISELECTOBJECT	 APIBITBLT HIDECONTROLS SHOWCONTROLS SPLIT APIRELEASEDC APIDELETEOBJECT APIDELETEDC/ , T�  � � �C�  � ��  � � �8�� U  THIS IMGSPLITTER LEFT WIDTH hidecontrols,     �� showcontrols    �� split�    �� Init    ��	 MouseDownT    �� Resize�    ��1 � � � A � S� � � A � A s�a� A A � �!�A �!�A �!�A A � 2 r �A A ��qA A 3 � 2 � 2 1�q� q� A A 1��"aA A �AA �� 11� 2A A � AAA�A!A � A�AAQA A A � � E
QQ� A "!B��!�!�� � A aaA A A ��AA qA � � q"��"�B � A A � � A A� #� � � 3 �1                       �     '   �  �  8   2     =  H   4   X  {  L   7   �  \  P   �   y  �  
   )   �                        	container     �PROCEDURE hidecontrols
* hide all controls include ActiveX with property visible inside container tObject
* without this splitter and form

LPARAMETERS tObject,nIndex
*	tObject is root object, if not passed, thisform is used
IF EMPTY(nIndex)
	nIndex=2
ENDIF 

LOCAL lcObjectBaseClass, lObject, lTempObject
* build collection hidden object for reverse setting in showcontrols
* set valid object
IF VARTYPE(tObject)="O"
	lObject= tObject
ELSE
	lObject= THISFORM
ENDIF

* ignore this splitter
IF lObject = THIS
	RETURN nIndex
ENDIF

* unify
lcObjectBaseClass = LOWER(lObject.BASECLASS)+" " && " " for unique (page # pageframe)

* do not hide form window
IF lcObjectBaseClass # "form " AND PEMSTATUS(lObject,"visible",5)
	IF lObject.VISIBLE
		DIMENSION this.HiddenControls[nIndex]
		this.hiddencontrols[nIndex]=lObject
		lObject.VISIBLE = .F.
		nIndex=nIndex+1
	ENDIF
ENDIF

* recurse for all children
DO CASE
	CASE INLIST(lcObjectBaseClass,"pageframe ")
		FOR EACH lTempObject IN lObject.PAGES
			nIndex=THIS.hidecontrols(lTempObject,nIndex)
		ENDFOR
	CASE INLIST(lcObjectBaseClass,"form ","container ","page ")
		FOR EACH lTempObject IN lObject.CONTROLS
			nIndex=THIS.hidecontrols(lTempObject,nIndex)
		ENDFOR
	CASE INLIST(lcObjectBaseClass,"commandgroup ","optiongroup ")
		FOR EACH lTempObject IN lObject.BUTTONS
			nIndex=THIS.hidecontrols(lTempObject,nIndex)
		ENDFOR
ENDCASE

RETURN nIndex+1
ENDPROC
PROCEDURE showcontrols
* show temporary hidden objects and clear list (collection)
LPARAMETERS toRoot

IF ALEN(THIS.hiddencontrols,1)<2
	RETURN
ENDIF
FOR i=2 TO ALEN(THIS.hiddencontrols,1)
	IF TYPE("THIS.hiddencontrols[i]")="O"
		THIS.hiddencontrols[i].Visible=.T.
	ENDIF 	
ENDFOR

DIMENSION THIS.hiddencontrols[1]

ENDPROC
PROCEDURE split
*default behaviour
THISFORM.RESIZE()
ENDPROC
PROCEDURE Init
this.BorderWidth = 0
this.Resize()
ENDPROC
PROCEDURE MouseDown
LPARAMETERS nButton, nShift, nXCoord, nYCoord
LOCAL lcWindowName,lnScaleMode,lnMinRow,lnMaxRow,lnMRow1,lnMRow2
LOCAL lnRows,lnTop,lnOldTop,lnMin,oldMRow2
LOCAL llLockScreen,lnMousePointer
LOCAL lhDC,lhMemDC,lhMemBmp,lHWnd,lnBmpHeight,nLeftOffset,nTopOffset,oContainer,xHeight
LOCAL lcOldFormName,lhMemSplit

IF nButton#1
	RETURN
ENDIF

lcOldFormName = THISFORM.NAME
THISFORM.NAME = SYS(2015)

lcWindowName=THISFORM.NAME
lnScaleMode=THISFORM.SCALEMODE
THISFORM.SCALEMODE=3  && pixels

oContainer=THIS.PARENT
nLeftOffset=OBJTOCLIENT(THIS,2)-THIS.LEFT
nTopOffset=OBJTOCLIENT(THIS,1)-THIS.TOP

lnMRow1=MROW(lcWindowName,3)
IF TYPE("lnMRow1")#"N" OR lnMRow1<=0
	THISFORM.SCALEMODE=lnScaleMode
	THISFORM.NAME = lcOldFormName
	RETURN
ENDIF

lnMRow1=lnMRow1-nTopOffset
IF lnMRow1 <> THIS.TOP+1
	lnMRow1 = THIS.TOP+1
	MOUSE AT lnMRow1+nTopOffset, MCOL(lcWindowName,3) PIXELS WINDOW (lcWindowName)
ENDIF

* set some vars
llLockScreen=THISFORM.LOCKSCREEN
lnMousePointer=THISFORM.MOUSEPOINTER
THISFORM.MOUSEPOINTER= 7
lnTop=THIS.TOP

* check two parent level for Height- suppose that parent form always present
IF PEMSTATUS(oContainer,"Height",5)
	xHeight	=	oContainer.HEIGHT
ELSE
	IF PEMSTATUS(oContainer.PARENT,"PageHeight",5)
		xHeight	=	oContainer.PARENT.PAGEHEIGHT
	ELSE
		* if error that oContainer.Height and oContainer.parent.width not exist, something wrong
		xHeight	=	oContainer.PARENT.HEIGHT
	ENDIF
ENDIF

* RangeMin (RangeMax) < 1
* 		RangeMin (RangeMax) are used as coeficient (%/100)
* RangeMin (RangeMax) > 1
*		RangeMin (RangeMax) are used as absolute offset in pixels
* RangeMin (RangeMax) =0
*		RangeMin (RangeMax) are ignored - no restriction
DO CASE
	CASE THIS.RangeMin <= 0
		lnMinRow=THIS.HEIGHT*2
	CASE THIS.RangeMin > 1
		lnMinRow=MAX(THIS.HEIGHT*2,INT(THIS.RangeMin))
	CASE THIS.RangeMin < 1
		lnMinRow=MAX(THIS.HEIGHT*2,INT(THIS.RangeMin*xHeight))
ENDCASE

DO CASE
	CASE THIS.RangeMax <= 0
		lnMaxRow=xHeight-(THIS.HEIGHT*3)
	CASE THIS.RangeMax > 1
		lnMaxRow=MIN(xHeight-(THIS.HEIGHT*3),THIS.RangeMax)
	CASE THIS.RangeMax < 1
		lnMaxRow=MIN(xHeight-(THIS.HEIGHT*3),THIS.RangeMax*xHeight)
ENDCASE

IF lnMinRow>lnMaxRow
	* nothing to move!!!
	THISFORM.SCALEMODE=lnScaleMode
	THISFORM.NAME = lcOldFormName
	RETURN
ENDIF

lnMRow2=lnMRow1
oldMRow2=lnMRow2

#DEFINE SRCCOPY		13369376

* API CALLS
IF THISFORM.SHOWWINDOW= 2
	* workaround, when showwindow=2 the handle is not the right one...
	* worst if you have a toolbar!
	*#define GW_HWNDFIRST        0
	#define GW_HWNDLAST         1
	*#define GW_HWNDNEXT         2
	*#define GW_HWNDPREV         3
	*#define GW_OWNER            4
	#define GW_CHILD            5

	lHWnd=THISFORM.HWND
	lHWnd=apiGetWindow(lHWnd,GW_CHILD)
	lHWnd=apiGetWindow(lHWnd,GW_HWNDLAST)
ELSE
	lHWnd=THISFORM.HWND
ENDIF

lhDC    = apiGetDC(lHWnd)
lhMemDC = apiCreateCompatibleDC(lhDC)
* Take a copy of the portion of the form that can be dragged over
lnBmpHeight = THIS.HEIGHT + 1
lhMemBmp    = apiCreateCompatibleBitmap(lhDC, THIS.WIDTH, lnBmpHeight)
lhMemSplit  = apiCreateCompatibleBitmap(lhDC, THIS.WIDTH, lnBmpHeight)
= apiSelectObject(lhMemDC , lhMemBmp)
= apiBitBlt(lhMemDC, 0, 0,  THIS.WIDTH, lnBmpHeight, lhDC, THIS.LEFT+nLeftOffset, lnMRow1-1+nTopOffset, SRCCOPY)
= apiSelectObject(lhMemDC , lhMemSplit)
= apiBitBlt(lhMemDC, 0, 0,  THIS.WIDTH, lnBmpHeight, lhDC, THIS.LEFT+nLeftOffset, lnMRow1-1+nTopOffset, SRCCOPY)

* Stop fox drawing in the screen
THISFORM.LOCKSCREEN=.T.
THIS.hidecontrols(oContainer)

* update the display while dragging
DO WHILE MDOWN()
	DOEVENTS
	lnMRow2=MROW(lcWindowName,3)-nTopOffset
	IF TYPE("lnMRow2")#"N" OR lnMRow2=0
		LOOP
	ENDIF
	IF lnMRow2<=lnMinRow
		*force the mouse to stay at this position
		MOUSE AT lnMinRow+nTopOffset, MCOL(lcWindowName,3) PIXELS WINDOW (lcWindowName)
		lnMRow2=lnMinRow+1
	ENDIF
	IF lnMRow2>=(lnMaxRow-THIS.HEIGHT)
		*force the mouse to stay at this position
		MOUSE AT lnMaxRow-THIS.HEIGHT+nTopOffset, MCOL(lcWindowName,3) PIXELS WINDOW (lcWindowName)
		lnMRow2=lnMaxRow-THIS.HEIGHT
	ENDIF
	lnMRow2=MIN(MAX(lnMRow2,lnMinRow),lnMaxRow)
	IF oldMRow2=lnMRow2
		LOOP
	ELSE
		* on mouse move, redraw a part of the screen from the memory copy
		* and draw "this" image at the mouse position
		* bitblt (dest...source...)
		WITH THIS
			.TOP=lnTop+(lnMRow2-lnMRow1)
			*restore
			= apiSelectObject(lhMemDC , lhMemBmp)
			= apiBitBlt(lhDC, .LEFT+nLeftOffset, oldMRow2-1+nTopOffset, .WIDTH, .HEIGHT+3, lhMemDC, 0, 0,  SRCCOPY)
			*take a new copy
			= apiBitBlt(lhMemDC, 0, 0,  THIS.WIDTH, lnBmpHeight, lhDC, THIS.LEFT+nLeftOffset, lnMRow2-1+nTopOffset, SRCCOPY)
			*draw
			= apiSelectObject(lhMemDC , lhMemSplit)
			= apiBitBlt(lhDC, .LEFT+nLeftOffset, .TOP+nTopOffset, .WIDTH, .HEIGHT+1, lhMemDC, 0, 0,  SRCCOPY)

		ENDWITH
		oldMRow2=lnMRow2
	ENDIF
ENDDO

THIS.showcontrols()
THISFORM.NAME = lcOldFormName

IF lnMRow2<0
	lnMRow2=lnMRow1
ENDIF

lnRows=lnMRow2-lnMRow1
THIS.TOP=lnTop+lnRows
THISFORM.SCALEMODE=lnScaleMode
THISFORM.MOUSEPOINTER=lnMousePointer

This.Split()

THISFORM.LOCKSCREEN=llLockScreen

* free the memory
= apiReleaseDC(lHWnd, lhDC)
= apiDeleteObject(lhMemBmp)
= apiDeleteObject(lhMemSplit)
= apiDeleteDC(lhMemDC)

ENDPROC
PROCEDURE Resize
this.imgSplitter.Left = INT((this.Width/2) - (this.imgSplitter.Width/2))
ENDPROC
     l���    S  S                        _   %   �      �  �   F          �  U    U  X ��  � � %�C� ���' � T� ���� � �� � � � %�C�  ��� O��\ � T� ��  �� �q � T� �� �� � %�� � ��� �	 B�� �� � T� �C� � @�  ��- %�� � form � C� � visible��h	��0� %�� � ��,� � �	 �� �� T� �	 �� ��� �� T� � �-�� T� �� ��� � � H�A�D� �C� �
 pageframe ����� �� � �
 ��� T� �C �  � � � �� ��, �C� � form �
 container � page ����� �� � � ��� T� �C �  � � � �� ��. �C� � commandgroup � optiongroup ���D� �� � � �@� T� �C �  � � � �� �� � B�� ��� U  TOBJECT NINDEX LCOBJECTBASECLASS LOBJECT LTEMPOBJECT THISFORM THIS	 BASECLASS VISIBLE HIDDENCONTROLS PAGES HIDECONTROLS CONTROLS BUTTONS�  ��  � %�C� � �����$ � B� � �� ���(�C� � ����� �* %�C� THIS.hiddencontrols[i]b� O��� � T� � �� �� �a�� � �� � � ���� U  TOROOT THIS HIDDENCONTROLS I VISIBLE  ��C�  � �� U  THISFORM RESIZE  T�  � �� �� U  THIS BORDERSTYLE(	 ��  � � � � �� � � � � �	 � ��
 � � � � � �� � �' �� � � � � � � � � � �� � � %��  ���� � B� � T� �� � �� T� � �C��]�� T� �� � �� T� �� � �� T� � ���� T� �� �  �� T� �C� ��]� �! �� T� �C� ��]� �" �� ��L� T� �C� ���� ��T� ��& %�C� lnMCol1b� N� � � ���� T� � �� �� T� � �� �� B� � T� �� � �� %�� � �! ���� T� �� �! ���! ��,�� ��C� ����� � �� � T� �� �# �� T� �� �$ �� T� �$ ��	�� T� �� �! �� %�C� � Width��h��s� T� �� �% �� ���" %�C� �  �	 PageWidth��h���� T� �� �  �& �� ��� T� �� �  �% �� � � H���p� �� �' � ��� T� �� �% ��� �� �' ���:� T� �C� �% �C� �' 8D�� �� �' ���p�" T� �C� �% �C� �' � 8D�� � H���� �� �( � ���� T� �� � �% ��� �� �( �����! T� �C� � �% �� �( F�� �� �( ����% T� �C� � �% �� �( � F�� � %�� � ��U� T� � �� �� T� � �� �� B� � T�	 �� �� T� ��	 �� %�� �) ����� T� �� �* �� T� �C � ��+ �� T� �C � ��+ �� ��� T� �� �* �� � T� �C � �, �� T� �C � �- �� T� �� �% ��� T� �C �  � � �/ �. �� T� �C �  � � �/ �. �� ��C �  � �0 ��= ��C � � �  � � �/  � � � �� �" � �  � �1 �� ��C �  � �0 ��= ��C � � �  � � �/  � � � �� �" � �  � �1 �� T� �# �a�� ��C � � �2 �� +�C���D� �� T�	 �C� ��� ��& %�C� lnMCol2b� N� �	 � ��[� .� � %��	 � ����! ��,�� ��C� ����� � �� T�	 �� ��� � %��	 � � �% ����, ��,�� ��C� ����� � �% � ��� T�	 �� � �% �� � T�	 �CC�	 � D� F�� %�� �	 ��/� .� �@� ��� ��/� T��! �� �	 � �� ��C �  � �0 ��9 ��C � � � ���" �  � ��/  � � � �  � �1 ��= ��C � � �  � � �/  � �	 � �� �" � �  � �1 �� ��C �  � �0 ��: ��C � ��! � ���" �  � ��/  � � � �  � �1 �� �� T� ��	 �� � � ��C� �3 �� T� � �� �� %��	 � ���� T�	 �� �� � T�
 ��	 � �� T� �! �� �
 �� T� � �� �� T� �$ �� �� ��C� �4 �� T� �# �� �� ��C �  � �5 �� ��C � �6 �� ��C � �6 �� ��C � �7 �� U8  NBUTTON NSHIFT NXCOORD NYCOORD LCWINDOWNAME LNSCALEMODE LNMINCOL LNMAXCOL LNMCOL1 LNMCOL2	 LNCOLUMNS LNLEFT	 LNOLDLEFT LNMIN OLDMCOL2 LLLOCKSCREEN LNMOUSEPOINTER LHDC LHMEMDC LHMEMBMP LHWND
 LNBMPWIDTH NLEFTOFFSET
 NTOPOFFSET
 OCONTAINER XWIDTH LCOLDFORMNAME
 LHMEMSPLIT THISFORM NAME	 SCALEMODE THIS PARENT LEFT TOP
 LOCKSCREEN MOUSEPOINTER WIDTH	 PAGEWIDTH RANGEMIN RANGEMAX
 SHOWWINDOW HWND APIGETWINDOW APIGETDC APICREATECOMPATIBLEDC APICREATECOMPATIBLEBITMAP HEIGHT APISELECTOBJECT	 APIBITBLT HIDECONTROLS SHOWCONTROLS SPLIT APIRELEASEDC APIDELETEOBJECT APIDELETEDC readme,     �� hidecontrols3     �� showcontrols%    �� split�    �� Init    ��	 MouseDownF    ��1 �1 � � � A � S� � � A � A s�a� A A � �!�A �!�A �!�A A � 2 r �A A ��qA A 3 � 2 2 1�q� q� A A 1��� !� A aA A �AA �� !1� 2A A � AAA�A!A � A�AAQA A A � � E
QQ� A "!B��!�!�� � A aaA A A ��AA qA � � q"��"�A � A A � � A A� #� � � 2                       �        �  ^  O   )   �  �  �   4   �  �  �   6     "  �   8   B  -)  �    )   S                       R���    9  9                        /\   %   �      �  �   2          �  U    U  X ��  � � %�C� ���' � T� ���� � �� � � � %�C�  ��� O��\ � T� ��  �� �q � T� �� �� � %�� � ��� �	 B�� �� � T� �C� � @�  ��- %�� � form � C� � visible��h	��0� %�� � ��,� � �	 �� �� T� �	 �� ��� �� T� � �-�� T� �� ��� � � H�A�D� �C� �
 pageframe ����� �� � �
 ��� T� �C �  � � � �� ��, �C� � form �
 container � page ����� �� � � ��� T� �C �  � � � �� ��. �C� � commandgroup � optiongroup ���D� �� � � �@� T� �C �  � � � �� �� � B�� ��� U  TOBJECT NINDEX LCOBJECTBASECLASS LOBJECT LTEMPOBJECT THISFORM THIS	 BASECLASS VISIBLE HIDDENCONTROLS PAGES HIDECONTROLS CONTROLS BUTTONS�  ��  � %�C� � �����$ � B� � �� ���(�C� � ����� �* %�C� THIS.hiddencontrols[i]b� O��� � T� � �� �� �a�� � �� � � ���� U  TOROOT THIS HIDDENCONTROLS I VISIBLE  ��C�  � �� U  THISFORM RESIZE  T�  � �� �� U  THIS BORDERSTYLE	 ��  � � � � �� � � � � �	 � ��
 � � � � � �� � �' �� � � � � � � � � � �� � � %��  ���� � B� � T� �� � �� T� � �C��]�� T� �� � �� T� �� � �� T� � ���� T� �� �  �� T� �C� ��]� �! �� T� �C� ��]� �" �� T� �C� ����& %�C� lnMRow1b� N� � � ���� T� � �� �� T� � �� �� B� � T� �� � �� %�� � �" ����� T� �� �" ���! ��,�� ��� � ��C� ���� � T� �� �# �� T� �� �$ �� T� �$ ���� T� �� �" �� %�C� � Height��h��`� T� �� �% �� ���# %�C� �  �
 PageHeight��h���� T� �� �  �& �� ��� T� �� �  �% �� � � H���^� �� �' � ���� T� �� �% ��� �� �' ���(� T� �C� �% �C� �' 8D�� �� �' ���^�" T� �C� �% �C� �' � 8D�� � H�o�
� �� �( � ���� T� �� � �% ��� �� �( �����! T� �C� � �% �� �( F�� �� �( ���
�% T� �C� � �% �� �( � F�� � %�� � ��C� T� � �� �� T� � �� �� B� � T�	 �� �� T� ��	 �� %�� �) ����� T� �� �* �� T� �C � ��+ �� T� �C � ��+ �� ��� T� �� �* �� � T� �C � �, �� T� �C � �- �� T� �� �% ��� T� �C � � �/  � �. �� T� �C � � �/  � �. �� ��C �  � �0 ��= ��C � � � � �/  �  � � �! � � �� �  � �1 �� ��C �  � �0 ��= ��C � � � � �/  �  � � �! � � �� �  � �1 �� T� �# �a�� ��C � � �2 �� +�C���2� �� T�	 �C� ��� ��& %�C� lnMRow2b� N� �	 � ��I� .� � %��	 � ����! ��,�� ��� � ��C� ���� T�	 �� ��� � %��	 � � �% ����( ��,�� ��� � �% � ��C� ���� T�	 �� � �% �� � T�	 �CC�	 � D� F�� %�� �	 ��� .� �.� ��� ��� T��" �� �	 � �� ��C �  � �0 ��= ��C � ��! � � �� ��/ ��% � � � � �  � �1 ��= ��C � � � � �/  �  � � �! � �	 �� �  � �1 �� ��C �  � �0 ��: ��C � ��! � ��" � ��/ ��% � � � � �  � �1 �� �� T� ��	 �� � � ��C� �3 �� T� � �� �� %��	 � ��q� T�	 �� �� � T�
 ��	 � �� T� �" �� �
 �� T� � �� �� T� �$ �� �� ��C� �4 �� T� �# �� �� ��C �  � �5 �� ��C � �6 �� ��C � �6 �� ��C � �7 �� U8  NBUTTON NSHIFT NXCOORD NYCOORD LCWINDOWNAME LNSCALEMODE LNMINROW LNMAXROW LNMROW1 LNMROW2 LNROWS LNTOP LNOLDTOP LNMIN OLDMROW2 LLLOCKSCREEN LNMOUSEPOINTER LHDC LHMEMDC LHMEMBMP LHWND LNBMPHEIGHT NLEFTOFFSET
 NTOPOFFSET
 OCONTAINER XHEIGHT LCOLDFORMNAME
 LHMEMSPLIT THISFORM NAME	 SCALEMODE THIS PARENT LEFT TOP
 LOCKSCREEN MOUSEPOINTER HEIGHT
 PAGEHEIGHT RANGEMIN RANGEMAX
 SHOWWINDOW HWND APIGETWINDOW APIGETDC APICREATECOMPATIBLEDC APICREATECOMPATIBLEBITMAP WIDTH APISELECTOBJECT	 APIBITBLT HIDECONTROLS SHOWCONTROLS SPLIT APIRELEASEDC APIDELETEOBJECT APIDELETEDC readme,     �� hidecontrols3     �� showcontrols%    �� split�    �� Init    ��	 MouseDownF    ��1 `1 � � � A � S� � � A � A s�a� A A � �!�A �!�A �!�A A � 2 r �A A ��qA A 3 � 2 2 1�q� q� A A 1��"aA A �AA �� 11� 2A A � AAA�A!A � A�AAQA A A � � E
QQ� A "!B��!�!�� � A aaA A A ��AA qA � � q"��"�B � A A � � A A� #� � � 2                       }        �  0  H   )   S  �     4   �  �  �   6   �  �  �   8     �(  �    )   9                       PROCEDURE hidecontrols
* hide all controls include ActiveX with property visible inside container tObject
* without this splitter and form

LPARAMETERS tObject,nIndex
*	tObject is root object, if not passed, thisform is used
IF EMPTY(nIndex)
	nIndex=2
ENDIF 

LOCAL lcObjectBaseClass, lObject, lTempObject
* build collection hidden object for reverse setting in showcontrols
* set valid object
IF VARTYPE(tObject)="O"
	lObject= tObject
ELSE
	lObject= THISFORM
ENDIF

* ignore this splitter
IF lObject = THIS
	RETURN nIndex
ENDIF

* unify
lcObjectBaseClass = LOWER(lObject.BASECLASS)+" " && " " for unique (page # pageframe)

* do not hide form window
IF lcObjectBaseClass # "form " AND PEMSTATUS(lObject,"visible",5)
	IF lObject.VISIBLE
		DIMENSION this.HiddenControls[nIndex]
		this.hiddencontrols[nIndex]=lObject
		lObject.VISIBLE = .F.
		nIndex=nIndex+1
	ENDIF
ENDIF

* recurse for all children
DO CASE
	CASE INLIST(lcObjectBaseClass,"pageframe ")
		FOR EACH lTempObject IN lObject.PAGES
			nIndex=THIS.hidecontrols(lTempObject,nIndex)
		ENDFOR
	CASE INLIST(lcObjectBaseClass,"form ","container ","page ")
		FOR EACH lTempObject IN lObject.CONTROLS
			nIndex=THIS.hidecontrols(lTempObject,nIndex)
		ENDFOR
	CASE INLIST(lcObjectBaseClass,"commandgroup ","optiongroup ")
		FOR EACH lTempObject IN lObject.BUTTONS
			nIndex=THIS.hidecontrols(lTempObject,nIndex)
		ENDFOR
ENDCASE

RETURN nIndex+1
ENDPROC
PROCEDURE showcontrols
* show temporary hidden objects and clear list (collection)
LPARAMETERS toRoot

IF ALEN(THIS.hiddencontrols,1)<2
	RETURN
ENDIF
FOR i=2 TO ALEN(THIS.hiddencontrols,1)
	IF TYPE("THIS.hiddencontrols[i]")="O"
		THIS.hiddencontrols[i].Visible=.T.
	ENDIF 	
ENDFOR

DIMENSION THIS.hiddencontrols[1]

ENDPROC
PROCEDURE split
*default behaviour
THISFORM.RESIZE()
ENDPROC
PROCEDURE Resize
this.imgSplitter.Top = INT((this.Height/2) - (this.imgSplitter.Height/2))
ENDPROC
PROCEDURE MouseDown
LPARAMETERS nButton, nShift, nXCoord, nYCoord
LOCAL lcWindowName,lnScaleMode,lnMinCol,lnMaxCol,lnMCol1,lnMCol2
LOCAL lnColumns,lnLeft,lnOldLeft,lnMin,oldMCol2
LOCAL llLockScreen,lnMousePointer
LOCAL lhDC,lhMemDC,lhMemBmp,lHWnd,lnBmpWidth,nLeftOffset,nTopOffset,oContainer,xWidth
LOCAL lcOldFormName,lhMemSplit

IF nButton#1
	RETURN
ENDIF

lcOldFormName = THISFORM.NAME
THISFORM.NAME = SYS(2015)

lcWindowName=THISFORM.NAME
lnScaleMode=THISFORM.SCALEMODE
THISFORM.SCALEMODE=3  && pixels

oContainer=THIS.PARENT
nLeftOffset=OBJTOCLIENT(THIS,2)-THIS.LEFT
nTopOffset=OBJTOCLIENT(THIS,1)-THIS.TOP

TRY
	lnMCol1=MCOL(lcWindowName,3)
CATCH
ENDTRY
IF TYPE("lnMCol1")#"N" OR lnMCol1<=0
	THISFORM.SCALEMODE=lnScaleMode
	THISFORM.NAME = lcOldFormName
	RETURN
ENDIF

lnMCol1=lnMCol1-nLeftOffset
IF lnMCol1 <> THIS.LEFT+1
	lnMCol1=THIS.LEFT+1
	MOUSE AT MROW(lcWindowName,3), lnMCol1+nLeftOffset PIXELS WINDOW (lcWindowName)
ENDIF

* set some vars
llLockScreen			=	THISFORM.LOCKSCREEN
lnMousePointer			=	THISFORM.MOUSEPOINTER
THISFORM.MOUSEPOINTER	=	9
lnLeft					=	THIS.LEFT

* check two parent level for width - suppose that parent form always present
IF PEMSTATUS(oContainer,"Width",5)
	xWidth	=	oContainer.WIDTH
ELSE
	IF PEMSTATUS(oContainer.PARENT,"PageWidth",5)
		xWidth	=	oContainer.PARENT.PAGEWIDTH
	ELSE
		* if error that oContainer.width and oContainer.parent.width not exist, something wrong
		xWidth	=	oContainer.PARENT.WIDTH
	ENDIF
ENDIF

* RangeMin (RangeMax) < 1
* 		RangeMin (RangeMax) are used as coeficient (%/100)
* RangeMin (RangeMax) > 1
*		RangeMin (RangeMax) are used as absolute offset in pixels
* RangeMin (RangeMax) =0
*		RangeMin (RangeMax) are ignored - let 2 times this.width
DO CASE
	CASE THIS.RangeMin <= 0
		lnMinCol=THIS.WIDTH*2
	CASE THIS.RangeMin > 1
		lnMinCol=MAX(THIS.WIDTH*2,INT(THIS.RangeMin))
	CASE THIS.RangeMin < 1
		lnMinCol=MAX(THIS.WIDTH*2,INT(THIS.RangeMin*xWidth))
ENDCASE

DO CASE
	CASE THIS.RangeMax <= 0
		lnMaxCol=xWidth-(THIS.WIDTH*3)
	CASE THIS.RangeMax > 1
		lnMaxCol=MIN(xWidth-(THIS.WIDTH*3),THIS.RangeMax)
	CASE THIS.RangeMax < 1
		lnMaxCol=MIN(xWidth-(THIS.WIDTH*3),THIS.RangeMax*xWidth)
ENDCASE

IF lnMinCol>lnMaxCol
	* nothing to move!!!
	THISFORM.SCALEMODE=lnScaleMode
	THISFORM.NAME = lcOldFormName
	RETURN
ENDIF

lnMCol2=lnMCol1
oldMCol2=lnMCol2

#DEFINE SRCCOPY		13369376

* API CALLS
IF THISFORM.SHOWWINDOW= 2
	* workaround, when showwindow=2 the handle is not the right one...
	* worst if you have a toolbar!
	*#define GW_HWNDFIRST        0
	#define GW_HWNDLAST         1
	*#define GW_HWNDNEXT         2
	*#define GW_HWNDPREV         3
	*#define GW_OWNER            4
	#define GW_CHILD            5

	lHWnd=THISFORM.HWND
	lHWnd=apiGetWindow(lHWnd,GW_CHILD)
	lHWnd=apiGetWindow(lHWnd,GW_HWNDLAST)
ELSE
	lHWnd=THISFORM.HWND
ENDIF

lhDC    = apiGetDC(lHWnd)
lhMemDC = apiCreateCompatibleDC(lhDC)
* Take a copy of the portion of the form that can be dragged over
lnBmpWidth = THIS.WIDTH+1
lhMemBmp   = apiCreateCompatibleBitmap(lhDC, lnBmpWidth, THIS.HEIGHT)
lhMemSplit = apiCreateCompatibleBitmap(lhDC, lnBmpWidth, THIS.HEIGHT)
= apiSelectObject(lhMemDC , lhMemBmp)
= apiBitBlt(lhMemDC, 0, 0, lnBmpWidth, THIS.HEIGHT, lhDC, lnMCol1+nLeftOffset-2, THIS.TOP+nTopOffset, SRCCOPY)
= apiSelectObject(lhMemDC , lhMemSplit)
= apiBitBlt(lhMemDC, 0, 0, lnBmpWidth, THIS.HEIGHT, lhDC, lnMCol1+nLeftOffset-1, THIS.TOP+nTopOffset, SRCCOPY)

* Stop fox drawing in the screen
THISFORM.LOCKSCREEN=.T.
THIS.hidecontrols(oContainer)

* update the display while dragging
DO WHILE MDOWN()
	DOEVENTS
	lnMCol2=MCOL(lcWindowName,3)-nLeftOffset
	IF TYPE("lnMCol2")#"N" OR lnMCol2=0
		LOOP
	ENDIF
	IF lnMCol2<=lnMinCol
		*force the mouse to stay at this position
		MOUSE AT MROW(lcWindowName,3), lnMinCol+nLeftOffset PIXELS WINDOW (lcWindowName)
		lnMCol2=lnMinCol+1
	ENDIF
	IF lnMCol2>=(lnMaxCol-THIS.WIDTH)
		*force the mouse to stay at this position
		MOUSE AT MROW(lcWindowName,3), lnMaxCol-THIS.WIDTH+nLeftOffset+1 PIXELS WINDOW (lcWindowName)
		lnMCol2=lnMaxCol-THIS.WIDTH
	ENDIF
	lnMCol2=MIN(MAX(lnMCol2,lnMinCol),lnMaxCol)
	IF oldMCol2=lnMCol2
		LOOP
	ELSE
		* on mouse move, redraw a part of the screen from the memory copy
		* and draw "this" image at the mouse position
		* bitblt (dest...source...)
		WITH THIS
			.LEFT=lnLeft+(lnMCol2-lnMCol1)
			*restore
			= apiSelectObject(lhMemDC , lhMemBmp)
			= apiBitBlt(lhDC, oldMCol2+nLeftOffset-2, .TOP+nTopOffset, lnBmpWidth, .HEIGHT, lhMemDC, 0, 0,  SRCCOPY)
			*take a new copy
			= apiBitBlt(lhMemDC, 0, 0, lnBmpWidth, THIS.HEIGHT, lhDC, lnMCol2+nLeftOffset-2, THIS.TOP+nTopOffset, SRCCOPY)
			*draw the bar
			= apiSelectObject(lhMemDC , lhMemSplit)
			= apiBitBlt(lhDC, .LEFT+nLeftOffset-1, .TOP+nTopOffset, lnBmpWidth, .HEIGHT, lhMemDC, 0, 0,  SRCCOPY)
		ENDWITH
		oldMCol2=lnMCol2
	ENDIF
ENDDO

THIS.showcontrols()

THISFORM.NAME = lcOldFormName
IF lnMCol2<0
	lnMCol2=lnMCol1
ENDIF
lnColumns=lnMCol2-lnMCol1
THIS.LEFT=lnLeft + lnColumns
THISFORM.SCALEMODE=lnScaleMode
THISFORM.MOUSEPOINTER=lnMousePointer

This.Split()

THISFORM.LOCKSCREEN=llLockScreen

* free the memory
= apiReleaseDC(lHWnd, lhDC)
= apiDeleteObject(lhMemBmp)
= apiDeleteObject(lhMemSplit)
= apiDeleteDC(lhMemDC)

ENDPROC
PROCEDURE Init
this.RelativeLeft = this.Left
this.BorderWidth = 0
this.Resize()
ENDPROC
0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _3C80MEJ6F1264322925�      :  �      <6      �  �  �  �    �  �          q      Q       COMMENT RESERVED                        B                                                                  :$                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      "  ..\programs\gkkdefines.h�m��fF      codemax      ..\programs\gkkdefines.h      Pixels      Class      1      
olecontrol      codemax     �_memberdata XML Metadata for customizable properties
globals Handle to the global CodeMax Object
allowcmdcompletion Flag to allow for command completion
changecontrol Flag to track ChangeControl during edit
readonlylinebkgd Read only line background color - RGB(240,240,240)
showcodetips Flag to display code tips at mouse cursor
showlinehighlight Flag to display a line highlight for the current line being edited
*setuserpreferences Sets the CodeMax editor for user preferences
      AOLEObject = E:\My Work\C_Source\CodeMax 4.0.0.12\bin\cmax40.dll
     
 ��ࡱ�                >  ��	                               ����        ��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������R o o t   E n t r y                                               ��������                                h3�O�           O l e O b j e c t D a t a                                            ����                                        �        A c c e s s O b j S i t e D a t a                             &  ������������                                       8        C h a n g e d P r o p s                                         ������������                                       �          ����         ����   ���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������� ����C������G.�                                 �8                              8                                 �   Text 	   H           DisplayLeftMargin    L    
   VSp      ��������������������������������C o u r i e r   N e w                                                  ����          
    ��������         �   p
                          litter    L    
   HSplitter    L       BorderStyle 	   I
                                                                       ����    �  �                        �4   %   #      L  u   b          �  U   ��  � � � � � �� ���� ��� ���4 T�  �C�� C� SETTINGS� CodeMaxSettings� a���� %��  ����� �� ���(��  ���� T� �CCC � � �� =���� T� �CCC � � �� =���� H�� ��� �� � ShowLineNum��� T�� �C� � .T.� a� -6��  �� � SyntaxHighlight��P� T��	 �C� � .T.� a� -6�� �� �
 LeftMargin��k� �� � ShowCodeTips���� T��
 �C� � .T.� a� -6��" �� � CommandCompletion���� T�� �C� � .T.� a� -6�� �� � ParameterTips��%� T�� �C� � .T.� a� -6�� �� � ChangeControl��b� T�� �C� � .T.� a� -6�� �� � BlockMatching���� T�� �C� � .T.� a� -6�� �� � NormalizeCase���� T�� �C� � .T.� a� -6��" �� � ShowLineHighlight��� T�� �C� � .T.� a� -6�� �� � SmoothScroll��Y� T�� �C� � .T.� a� -6�� �� � VirtualSpace���� T�� �C� � .T.� a� -6�� �� �
 LineScroll���� T�� �C� � .T.� a� -6�� �� � CopyRTF��� T�� �C� � .T.� a� -6�� �� � TabSize��0� T�� �CC� g8��! �� � ReadOnlyLineBkGd��c� T�� �CC� g8�� �� � ConvertTabs���� T�� �C� � .T.� a� -6�� �� � IndentStyle���� T�� �CC� g8�� �� � LineHighlight��	� T�� �C� � .T.� a� -6��% �� � LangPrefLineComments����+ T�� � � �� �� �CCC� �� |��g8��+ T�� � � �� �� �CCC� �� |��g8��+ T�� � � �� �� �CCC� �� |��g8��# �� � LangPrefHyperlinks��S�+ T�� � � ���� �CCC� �� |��g8��+ T�� � � ���� �CCC� �� |��g8��+ T�� � � ���� �CCC� �� |��g8��  �� � LangPrefStrings����+ T�� � � ���� �CCC� �� |��g8��+ T�� � � ���� �CCC� �� |��g8��+ T�� � � ���� �CCC� �� |��g8��$ �� � LangPrefAttribNames����+ T�� � � ���� �CCC� �� |��g8��+ T�� � � ���� �CCC� �� |��g8��+ T�� � � ���� �CCC� �� |��g8��" �� � LangPrefVFPSysVar��<�+ T�� � � ���� �CCC� �� |��g8��+ T�� � � ���� �CCC� �� |��g8��+ T�� � � ���� �CCC� �� |��g8��& �� � LangPrefScopeKeywords����+ T�� � � ���� �CCC� �� |��g8��+ T�� � � ���� �CCC� �� |��g8��+ T�� � � ���� �CCC� �� |��g8��! �� � LangPrefKeywords���	�+ T�� � � ���� �CCC� �� |��g8��+ T�� � � ���� �CCC� �� |��g8��+ T�� � � ���� �CCC� �� |��g8��" �� � LangPrefOperators��(
�+ T�� � � ��	�� �CCC� �� |��g8��+ T�� � � ��	�� �CCC� �� |��g8��+ T�� � � ��	�� �CCC� �� |��g8��  �� � LangPrefNumbers���
�+ T�� � � ��
�� �CCC� �� |��g8��+ T�� � � ��
�� �CCC� �� |��g8��+ T�� � � ��
�� �CCC� �� |��g8�� �� � LangPrefText���
� �� � FontName��� T�� �  �� �� �� � FontSize��>� T�� �! �CC� g8�� �� � ColorValues���� �� �� �(��	����$ ��C � CCC� � �� |��g8��" �� �� � �� �� ��C�C�������^��" �� ��C�C�������^��" �� ��C�C�������^��" �� T�� �! ��	�� � �� U#  LNCNT LNNDX LCITEM LCVALUE LNITM
 LCSETTINGS THIS GKKGETSTRING_VFP LINENUMBERING COLORSYNTAX SHOWCODETIPS ALLOWCMDCOMPLETION PARAMETERINFO CHANGECONTROL BRACEMATCHING NORMALIZECASE SHOWLINEHIGHLIGHT SMOOTHSCROLLING VIRTUALSPACE LINETOOLTIPS RTFCOPY TABSIZE READONLYLINEBKGD
 EXPANDTABS AUTOINDENTMODE LANGUAGE	 TOKENSETS ITEM	 FORECOLOR	 BACKCOLOR	 FONTSTYLE FONT NAME SIZE SETCOLOR  ��  � � ��C� � �� U  TNROW TNCOL THIS CANCELEVENT�  ��  � ��� ��� �" T�� �C� CodeMax.Globals.4�N��" T�  �C� CodeMax.Language.4�N�� ���  ��� �$ T�� �C� GKKVisualFoxPro.xml���� T�� �� VFP C��]�� ��C�� �� �� T�� ��  �� �� U 
 LOLANGUAGE THIS GLOBALS XML NAME REGISTER LANGUAGE setuserpreferences,     �� ContextMenu�    �� Init    ��1 q� � Aq��� ������!���������!����������!!���!��Q���1������A���!���a������!���������Q�qAA A A � ���A A 2 � � 2 q � !!� A�� A � B 1                       �     f   �    k   i   1  \  o    )   �                       gPROCEDURE setuserpreferences
LOCAL lnCnt, lnNdx, lcItem, lcValue, lnItm
LOCAL ARRAY lcSettings[1]
WITH this
	lnCnt = ALINES(lcSettings,GKKGetString_VFP("SETTINGS","CodeMaxSettings"),True)
	IF lnCnt > 1
		FOR lnNdx=1 TO lnCnt
			lcItem  = ALLTRIM(GETWORDNUM(lcSettings[lnNdx],1,"="))
			lcValue = ALLTRIM(GETWORDNUM(lcSettings[lnNdx],2,"="))
			DO CASE
				CASE lcItem = "ShowLineNum"
					.LineNumbering = IIF(lcValue='.T.',True,False)
				CASE lcItem = "SyntaxHighlight"
					.ColorSyntax = IIF(lcValue='.T.',True,False)
				CASE lcItem = "LeftMargin"
*					.DisplayLeftMargin = IIF(lcValue='.T.',True,False)
				CASE lcItem = "ShowCodeTips"
					.ShowCodeTips = IIF(lcValue='.T.',True,False)
				CASE lcItem = "CommandCompletion"
					.AllowCmdCompletion = IIF(lcValue='.T.',True,False)
				CASE lcItem = "ParameterTips"
					.ParameterInfo = IIF(lcValue='.T.',True,False)
				CASE lcItem = "ChangeControl"
					.ChangeControl = IIF(lcValue='.T.',True,False)
				CASE lcItem = "BlockMatching"
					.BraceMatching = IIF(lcValue='.T.',True,False)
				CASE lcItem = "NormalizeCase"
					.NormalizeCase = IIF(lcValue='.T.',True,False)
				CASE lcItem = "ShowLineHighlight"
					.ShowLineHighlight = IIF(lcValue='.T.',True,False)
				CASE lcItem = "SmoothScroll"
					.SmoothScrolling = IIF(lcValue='.T.',True,False)
				CASE lcItem = "VirtualSpace"
					.VirtualSpace = IIF(lcValue='.T.',True,False)
				CASE lcItem = "LineScroll"
					.LineToolTips = IIF(lcValue='.T.',True,False)
				CASE lcItem = "CopyRTF"
					.RTFCopy = IIF(lcValue='.T.',True,False)
				CASE lcItem = "TabSize"
					.TabSize = INT(VAL(lcValue))
				CASE lcItem = "ReadOnlyLineBkGd"
					.ReadOnlyLineBkGd = INT(VAL(lcValue))
				CASE lcItem = "ConvertTabs"
					.ExpandTabs = IIF(lcValue='.T.',True,False)
				CASE lcItem = "IndentStyle"
					.AutoIndentMode = INT(VAL(lcValue))
				CASE lcItem = "LineHighlight"
					.ShowLineHighlight = IIF(lcValue='.T.',True,False)
				CASE lcItem = "LangPrefLineComments"
					.Language.TokenSets.Item(0).Forecolor = INT(VAL(GETWORDNUM(lcValue,1,"|")))
					.Language.TokenSets.Item(0).Backcolor = INT(VAL(GETWORDNUM(lcValue,2,"|")))
					.Language.TokenSets.Item(0).Fontstyle = INT(VAL(GETWORDNUM(lcValue,3,"|")))
				CASE lcItem = "LangPrefHyperlinks"
					.Language.TokenSets.Item(3).Forecolor = INT(VAL(GETWORDNUM(lcValue,1,"|")))
					.Language.TokenSets.Item(3).Backcolor = INT(VAL(GETWORDNUM(lcValue,2,"|")))
					.Language.TokenSets.Item(3).Fontstyle = INT(VAL(GETWORDNUM(lcValue,3,"|")))
				CASE lcItem = "LangPrefStrings"
					.Language.TokenSets.Item(4).Forecolor = INT(VAL(GETWORDNUM(lcValue,1,"|")))
					.Language.TokenSets.Item(4).Backcolor = INT(VAL(GETWORDNUM(lcValue,2,"|")))
					.Language.TokenSets.Item(4).Fontstyle = INT(VAL(GETWORDNUM(lcValue,3,"|")))
				CASE lcItem = "LangPrefAttribNames"
					.Language.TokenSets.Item(5).Forecolor = INT(VAL(GETWORDNUM(lcValue,1,"|")))
					.Language.TokenSets.Item(5).Backcolor = INT(VAL(GETWORDNUM(lcValue,2,"|")))
					.Language.TokenSets.Item(5).Fontstyle = INT(VAL(GETWORDNUM(lcValue,3,"|")))
				CASE lcItem = "LangPrefVFPSysVar"
					.Language.TokenSets.Item(6).Forecolor = INT(VAL(GETWORDNUM(lcValue,1,"|")))
					.Language.TokenSets.Item(6).Backcolor = INT(VAL(GETWORDNUM(lcValue,2,"|")))
					.Language.TokenSets.Item(6).Fontstyle = INT(VAL(GETWORDNUM(lcValue,3,"|")))
				CASE lcItem = "LangPrefScopeKeywords"
					.Language.TokenSets.Item(7).Forecolor = INT(VAL(GETWORDNUM(lcValue,1,"|")))
					.Language.TokenSets.Item(7).Backcolor = INT(VAL(GETWORDNUM(lcValue,2,"|")))
					.Language.TokenSets.Item(7).Fontstyle = INT(VAL(GETWORDNUM(lcValue,3,"|")))
				CASE lcItem = "LangPrefKeywords"
					.Language.TokenSets.Item(8).Forecolor = INT(VAL(GETWORDNUM(lcValue,1,"|")))
					.Language.TokenSets.Item(8).Backcolor = INT(VAL(GETWORDNUM(lcValue,2,"|")))
					.Language.TokenSets.Item(8).Fontstyle = INT(VAL(GETWORDNUM(lcValue,3,"|")))
				CASE lcItem = "LangPrefOperators"
					.Language.TokenSets.Item(9).Forecolor = INT(VAL(GETWORDNUM(lcValue,1,"|")))
					.Language.TokenSets.Item(9).Backcolor = INT(VAL(GETWORDNUM(lcValue,2,"|")))
					.Language.TokenSets.Item(9).Fontstyle = INT(VAL(GETWORDNUM(lcValue,3,"|")))
				CASE lcItem = "LangPrefNumbers"
					.Language.TokenSets.Item(10).Forecolor = INT(VAL(GETWORDNUM(lcValue,1,"|")))
					.Language.TokenSets.Item(10).Backcolor = INT(VAL(GETWORDNUM(lcValue,2,"|")))
					.Language.TokenSets.Item(10).Fontstyle = INT(VAL(GETWORDNUM(lcValue,3,"|")))
				CASE lcItem = "LangPrefText"
*-*						.Language.TokenSets.Item(11).Forecolor = INT(VAL(GETWORDNUM(lcValue,1,"|")))
*-*						.Language.TokenSets.Item(11).Backcolor = INT(VAL(GETWORDNUM(lcValue,2,"|")))
*-*						.Language.TokenSets.Item(11).Fontstyle = INT(VAL(GETWORDNUM(lcValue,3,"|")))
				CASE lcItem = "FontName"
					.Font.Name = lcValue
				CASE lcItem = "FontSize"
					.Font.Size = INT(VAL(lcValue))
				CASE lcItem = "ColorValues"
					FOR lnItm=0 TO 9
						.SetColor(lnItm,INT(VAL(GETWORDNUM(lcValue,lnItm+1,"|"))))
					ENDFOR
			ENDCASE
		ENDFOR
	ELSE
		.SetColor(cmClrLeftMargin,RGB(192,192,192))
		.SetColor(cmClrLineNumber,RGB(255,255,255))
		.SetColor(cmClrLineNumberBk,RGB(128,128,128))
		.Font.Size = 9
	ENDIF
ENDWITH
ENDPROC
PROCEDURE ContextMenu
LPARAMETERS tnRow, tnCol
this.CancelEvent()
ENDPROC
PROCEDURE Init
LOCAL loLanguage
WITH this
	.Globals = CREATEOBJECT("CodeMax.Globals.4")
	loLanguage = CREATEOBJECT("CodeMax.Language.4")
	WITH loLanguage
		.Xml = FILETOSTR("GKKVisualFoxPro.xml")
		.Name = "VFP " + SYS(2015)
		.Register()
	ENDWITH
	.Language = loLanguage
*	.SetUserPreferences()
ENDWITH
ENDPROC
     �Height = 101
Width = 315
_memberdata =      249<VFPData><memberdata name="registervfplanguage" type="method" display="RegisterVFPLanguage"/><memberdata name="setuserpreferences" type="method" display="SetUserPreferences"/><memberdata name="globals" type="property" display="Globals"/></VFPData>

globals = .NULL.
allowcmdcompletion = .T.
changecontrol = .T.
readonlylinebkgd = 15790320
showcodetips = .T.
showlinehighlight = .T.
Name = "codemax"
      
olecontrol<memberlist name="VFPMbrList" casesensitive="no">
<member name="ABS" proto="ABS(nExpression)" help="Returns the absolute value of the specified numeric expression." image="method"/>
<member name="ACLASS" proto="ACLASS(ArrayName, oExpression)" help="Places an object's class name and its ancestor class names into a variable array." image="method"/>
<member name="ACOPY" proto="ACOPY(SourceArrayName, DestinationArrayName[, nFirstSourceElement [, nNumberElements [, nFirstDestElement ]]])" help="Copies elements from one array to another array." image="method"/>
<member name="ACOS" proto="ACOS(nExpression)" help="Returns the arc cosine of a specified numeric expression." image="method"/>
<member name="ADATABASES" proto="ADATABASES(ArrayName)" help="Places the names of all open databases and their paths into a variable array." image="method"/>
<member name="ADBOBJECTS" proto="ADBOBJECTS(ArrayName, cSetting)" help="Places the names of named connections, relations, tables, or SQL views in the current database into a variable array." image="method"/>
<member name="ADDBS" proto="ADDBS(cPath)" help="Adds a backslash (if needed) to a path expression." image="method"/>
<member name="ADDPROPERTY" proto="ADDPROPERTY(oObjectName, cPropertyName, [, eNewValue ])" help="Adds a new property to an object at run time." image="method"/>
<member name="ADEL" proto="ADEL(ArrayName, nElementNumber [, 2])" help="Deletes an element from a one-dimensional array, or a row or column from a two-dimensional array." image="method"/>
<member name="ADIR" proto="ADIR(ArrayName [, cFileSkeleton [, cAttribute [, nFlag]]])" help="Places information about files into an array and then returns the number of files." image="method"/>
<member name="ADLLS" proto="ADLLS(ArrayName)" help="Returns an array containing the names of functions loaded by DECLARE DLLs." image="method"/>
<member name="ADOCKSTATE" proto="ADOCKSTATE( ArrayName [, nType | nExtended])" help="Retrieves the dock state of any dockable form, Integrated Development Environment (IDE) window, or toolbar. For forms only, you can use the GetDockState Method. ADOCKSTATE( ) is available in the run time." image="method"/>
<member name="AELEMENT" proto="AELEMENT(ArrayName, nRowSubscript [, nColumnSubscript])" help="Returns the number of an array element from the element's subscripts." image="method"/>
<member name="AERROR" proto="AERROR(ArrayName)" help="Creates a variable array containing information about the most recent Visual FoxPro, OLE, or ODBC error." image="method"/>
<member name="AEVENTS" proto="AEVENTS( ArrayName [, 0 | 1 | oEventObject ] )" help="You can use the AEVENTS(�) function to retrieve the number of existing event bindings." image="method"/>
<member name="AFIELDS" proto="AFIELDS( ArrayName [, nWorkArea | cTableAlias ] )" help="Retrieves and stores information about the structure of the table in a specified work area, specified by a table alias, or in the currently selected work area in an array and returns the number of fields in the table." image="method"/>
<member name="AFONT" proto="AFONT(ArrayName [, cFontName [, nFontSize | nFontCharSet [, nFlags]]])" help="Places information about available fonts, such as their names, into an array." image="method"/>
<member name="AGETCLASS" proto="AGETCLASS(ArrayName [, cLibraryName [, cClassName [, cTitleText[, cFileNameCaption [, cButtonCaption]]]]])" help="Displays class libraries in the Open dialog box and creates an array containing the name of the class library and class chosen." image="method"/>
<member name="AGETFILEVERSION" proto="AGETFILEVERSION(ArrayName, cFileName)" help="Creates an array containing information about files with Windows version resources such as .exe, .dll, and .fll files, or automation servers created in Visual FoxPro." image="method"/>
<member name="AINS" proto="AINS(ArrayName, nElementNumber [, 2])" help="Inserts an element into a one-dimensional array, or a row or column into a two-dimensional array." image="method"/>
<member name="AINSTANCE" proto="AINSTANCE(ArrayName, cClassName)" help="Places instances of a class into a variable array and returns the number of instances placed in the array." image="method"/>
<member name="ALANGUAGE" proto="ALANGUAGE(ArrayName, nType)" help="Returns an array containing the names of all valid Visual FoxPro commands, functions, or base classes." image="method"/>
<member name="ALEN" proto="ALEN(ArrayName [, nArrayAttribute])" help="Returns the number of elements, rows, or columns in an array." image="method"/>
<member name="ALIAS" proto="ALIAS([nWorkArea | cTableAlias])" help="Returns the table alias of the current or specified work area." image="method"/>
<member name="ALINES" proto="ALINES(ArrayName, cExpression [, nFlags] [, cParseChar [, cParseChar2 [, ...]]])" help="Copies each line in a character expression or memo field to a corresponding row in an array." image="method"/>
<member name="ALLTRIM" proto="ALLTRIM(Expression [, nFlags] [, cParseChar [, cParseChar2 [, ...]]])" help="Removes all leading and trailing spaces or parsing characters from the specified character expression, or all leading and trailing zero (0) bytes from the specified binary expression." image="method"/>
<member name="AMEMBERS" proto="AMEMBERS(ArrayName, oObjectName | cClassName [, nArrayContentsID] [, cFlags])" help="Places the names of properties, procedures, and member objects for an object into a variable array." image="method"/>
<member name="AMOUSEOBJ" proto="AMOUSEOBJ(ArrayName [, 1])" help="Creates an array containing information about the mouse pointer position and the object over which the mouse pointer is positioned." image="method"/>
<member name="ANETRESOURCES" proto="ANETRESOURCES(ArrayName, cNetworkName, nResourceType)" help="Places the names of network shares or printers into an array and then returns the number of resources." image="method"/>
<member name="APRINTERS" proto="APRINTERS(ArrayName [, nValue])" help="Stores information about currently-available printers into an array." image="method"/>
<member name="APROCINFO" proto="APROCINFO(ArrayName, cFileName [, nType])" help="Creates an array containing Visual FoxPro language elements contained in a program file." image="method"/>
<member name="ASC" proto="ASC(cExpression)" help="Returns the ANSI value for the leftmost character in a character expression." image="method"/>
<member name="ASCAN" proto="ASCAN(ArrayName, eExpression [, nStartElement [, nElementsSearched [, nSearchColumn [, nFlags ]]]])" help="Searches an array for an element containing the same data and data type as an expression." image="method"/>
<member name="ASELOBJ" proto="ASELOBJ( ArrayName, [ 1 | 2 | 3 ] )" help="Places an object reference for the currently selected control or container that exists in the Form Designer, Class Designer, or code editing window into a specified variable array. When calling ASELOBJ( ) in a code editing window, the array also includes elements for forms (.scx), visual class libraries (.vcx), and #INCLUDE file names. You can also use ASELOBJ(�) to create control builders." image="method"/>
<member name="ASESSIONS" proto="ASESSIONS(ArrayName)" help="Creates an array of existing data session IDs." image="method"/>
<member name="ASIN" proto="ASIN(nExpression)" help="Returns in radians the arc sine of a numeric expression." image="method"/>
<member name="ASORT" proto="ASORT(ArrayName [, nStartElement [, nNumberSorted [, nSortOrder [, nFlags]]])" help="Sorts elements in an array in ascending or descending order." image="method"/>
<member name="ASQLHANDLES" proto="ASQLHANDLES(ArrayName [, nStatementHandle])" help="Stores numeric references to all active SQL connection statement handles in an array." image="method"/>
<member name="ASTACKINFO" proto="ASTACKINFO(ArrayName)" help="Creates an array and populates it with information about the current state of the call stack." image="method"/>
<member name="ASUBSCRIPT" proto="ASUBSCRIPT(ArrayName, nElementNumber, nSubscript)" help="Returns the row or column subscript of an element from the element's number." image="method"/>
<member name="AT" proto="AT(cSearchExpression, cExpressionSearched [, nOccurrence])" help="Searches a character expression for the occurrence of another character expression." image="method"/>
<member name="ATAGINFO" proto="ATAGINFO(ArrayName [,cCDXName [, nWorkArea | cTableAlias]])" help="Creates an array that contains information about index files for the selected table." image="method"/>
<member name="ATAN" proto="ATAN(nExpression)" help="Returns in radians the arc tangent of a numeric expression." image="method"/>
<member name="ATC" proto="ATC(cSearchExpression, cExpressionSearched [, nOccurrence])" help="Returns the beginning numeric position of the first occurrence of a character expression or memo field within another character expression or memo field, without regard for the case of these two expressions." image="method"/>
<member name="ATCC" proto="ATCC(cSearchExpression, cExpressionSearched [, nOccurrence])" help="Returns the beginning numeric position of the first occurrence of a character expression or memo field within another character expression or memo field, without regard for the case of these two expressions." image="method"/>
<member name="ATCLINE" proto="ATCLINE(cSearchExpression, cExpressionSearched)" help="Returns the line number of the first occurrence of a character expression or memo field within another character expression or memo field, without regard for the case (upper or lower) of the characters in either expression." image="method"/>
<member name="ATLINE" proto="ATLINE(cSearchExpression, cExpressionSearched)" help="Returns the line number of the first occurrence of a character expression or memo field within another character expression or memo field, counting from the first line." image="method"/>
<member name="ATN2" proto="ATN2(nYCoordinate, nXCoordinate)" help="Returns the arc tangent in all four quadrants from specified values." image="method"/>
<member name="AT_C" proto="AT_C(cSearchExpression, cExpressionSearched [, nOccurrence])" help="Returns the beginning numeric position of the first occurrence of a character expression or memo field within another character expression or memo field, counting from the leftmost character." image="method"/>
<member name="AUSED" proto="AUSED(ArrayName [, nDataSessionNumber [, cTableName]])" help="Places table aliases and work areas for a data session into a variable array." image="method"/>
<member name="AVCXCLASSES" proto="AVCXCLASSES(ArrayName, cLibraryName)" help="Places the information about classes in a class library into an array." image="method"/>
<member name="BAR" proto="BAR( )" help="Returns the number of the most recently chosen item from a menu defined with DEFINE POPUP or a menu item chosen from a Visual FoxPro menu." image="method"/>
<member name="BETWEEN" proto="BETWEEN(eTestValue, eLowValue, eHighValue)" help="Determines whether the value of an expression is inclusively between the values of two expressions of the same type." image="method"/>
<member name="BINDEVENT" proto="BINDEVENT(oEventSource, cEvent, oEventHandler, cDelegate [, nFlags])" help="Provides ability to execute user code (an object method) when an event occurs." image="method"/>
<member name="BINDEVENT" proto="BINDEVENT(hWnd | 0, nMessage, oEventHandler, cDelegate [, nFlags])" help="Provides ability to execute user code (an object method) when an event occurs." image="method"/>
<member name="BINTOC" proto="BINTOC(nExpression [, eFlags])" help="Converts a numeric value to a binary character representation." image="method"/>
<member name="BITAND" proto="BITAND(nNumericExpression1, nNumericExpression2, ... , nNumericExpression26)" help="Performs a bitwise AND operation on two or more values of Numeric, Varbinary, or Blob type and returns the result. There is a numeric and a binary version of the syntax." image="method"/>
<member name="BITAND" proto="BITAND(BinaryExpression1, BinaryExpression2, ... , BinaryExpression26)" help="Performs a bitwise AND operation on two or more values of Numeric, Varbinary, or Blob type and returns the result. There is a numeric and a binary version of the syntax." image="method"/>
<member name="BITCLEAR" proto="BITCLEAR(nNumericExpression1, nNumericExpression2)" help="Clears the specified bit in a Numeric, Varbinary, or Blob value by setting it to 0 and returns the resulting value. There is a numeric and a binary version of the syntax." image="method"/>
<member name="BITCLEAR" proto="BITCLEAR(BinaryExpression [, nStartBit [, nBitCount]])" help="Clears the specified bit in a Numeric, Varbinary, or Blob value by setting it to 0 and returns the resulting value. There is a numeric and a binary version of the syntax." image="method"/>
<member name="BITLSHIFT" proto="BITLSHIFT(nExpression1, nExpression2)" help="Moves bits in a numeric value to the left by the specified number of positions and returns the resulting value." image="method"/>
<member name="BITNOT" proto="BITNOT(nNumericExpression)" help="Performs a bitwise NOT operation on a value of Numeric, Varbinary, or Blob type and returns the bitwise complement on the specified value. There is a numeric and a binary version of the syntax." image="method"/>
<member name="BITNOT" proto="BITNOT(BinaryExpression [, nStartBit [, nBitCount]])" help="Performs a bitwise NOT operation on a value of Numeric, Varbinary, or Blob type and returns the bitwise complement on the specified value. There is a numeric and a binary version of the syntax." image="method"/>
<member name="BITOR" proto="BITOR(nNumericExpression1, nNumericExpression2, ... , nNumericExpression26)" help="Perform a bitwise inclusive OR operation on two or more values of Numeric, Varbinary, or Blob type and returns the result. There is a numeric and a binary version of the syntax." image="method"/>
<member name="BITOR" proto="BITOR(BinaryExpression1, BinaryExpression2, ... , BinaryExpression26)" help="Perform a bitwise inclusive OR operation on two or more values of Numeric, Varbinary, or Blob type and returns the result. There is a numeric and a binary version of the syntax." image="method"/>
<member name="BITRSHIFT" proto="BITRSHIFT(nExpression1, nExpression2)" help="Moves bits in a numeric value to the right by the specified number of positions and returns the resulting value." image="method"/>
<member name="BITSET" proto="BITSET(nNumericExpression1, nNumericExpression2)" help="Sets a bit to 1 in a value of Numeric, Varbinary, or Blob type and returns the resulting value. There is a numeric and a binary version of the syntax." image="method"/>
<member name="BITSET" proto="BITSET(BinaryExpression [, nStartBit [, nBitCount]])" help="Sets a bit to 1 in a value of Numeric, Varbinary, or Blob type and returns the resulting value. There is a numeric and a binary version of the syntax." image="method"/>
<member name="BITTEST" proto="BITTEST(nNumericExpression1, nNumericExpression2)" help="Determines whether a specific bit in a Numeric, Varbinary, or Blob value is set to 1. There is a numeric and a binary version of the syntax." image="method"/>
<member name="BITTEST" proto="BITTEST(BinaryExpression, nBitNumber)" help="Determines whether a specific bit in a Numeric, Varbinary, or Blob value is set to 1. There is a numeric and a binary version of the syntax." image="method"/>
<member name="BITXOR" proto="BITXOR(nNumericExpression1, nNumericExpression2 ..., nNumericExpression26)" help="Perform a bitwise exclusive OR operation on two or more values of Numeric, Varbinary, or Blob type and returns the result. There is a numeric and a binary version of the syntax." image="method"/>
<member name="BITXOR" proto="BITXOR(BinaryExpression1, BinaryExpression2 ..., BinaryExpression26)" help="Perform a bitwise exclusive OR operation on two or more values of Numeric, Varbinary, or Blob type and returns the result. There is a numeric and a binary version of the syntax." image="method"/>
<member name="BOF" proto="BOF([nWorkArea | cTableAlias])" help="Determines whether the record pointer is positioned at the beginning of a table." image="method"/>
<member name="CANDIDATE" proto="CANDIDATE([nIndexNumber] [, nWorkArea | cTableAlias])" help="Returns true (.T.) if an index tag is a candidate index tag; otherwise, returns false (.F.)." image="method"/>
<member name="CAPSLOCK" proto="CAPSLOCK([lExpression])" help="Returns the current mode of the CAPS LOCK key or sets the CAPS LOCK key mode on or off." image="method"/>
<member name="CAST" proto="CAST(eExpression AS cDataType [(nFieldWidth [, nPrecision])][NULL | NOT NULL])" help="Converts an expression from one data type to another." image="method"/>
<member name="CDOW" proto="CDOW(dExpression | tExpression)" help="Returns the day of the week from a given Date or DateTime expression." image="method"/>
<member name="CDX" proto="CDX(nIndexNumber [, nWorkArea | cTableAlias])" help="Returns the names of the open compound index (.cdx) file that has the specified index position number." image="method"/>
<member name="CEILING" proto="CEILING(nExpression)" help="Returns the next highest integer that is greater than or equal to the specified numeric expression." image="method"/>
<member name="CHR" proto="CHR(nANSICode)" help="Returns the character associated with the specified numeric ANSI code." image="method"/>
<member name="CHRSAW" proto="CHRSAW([nSeconds])" help="Determines whether or not a character is present in the keyboard buffer." image="method"/>
<member name="CHRTRAN" proto="CHRTRAN(cSearchedExpression, cSearchExpression, cReplacementExpression)" help="Replaces each character in a character expression that matches a character in a second character expression with the corresponding character in a third character expression." image="method"/>
<member name="CHRTRANC" proto="CHRTRANC(cSearched, cSearchFor, cReplacement)" help="Replaces each character in a character expression that matches a character in a second character expression with the corresponding character in a third character expression." image="method"/>
<member name="CLEARRESULTSET" proto="CLEARRESULTSET(�)" help="Clears the marker from a cursor marked by SETRESULTSET(�) in the current data session." image="method"/>
<member name="CMONTH" proto="CMONTH(dExpression | tExpression)" help="Returns the name of the month from a given date or DateTime expression." image="method"/>
<member name="CNTBAR" proto="CNTBAR(cMenuName)" help="Returns the number of menu items on a user-defined menu or the Visual FoxPro system menu." image="method"/>
<member name="CNTPAD" proto="CNTPAD(cMenuBarName)" help="Returns the number of menu titles on a user-defined menu bar or the Visual FoxPro system menu bar." image="method"/>
<member name="COL" proto="SPACE(nSpaces)" help="Included for backward compatibility. Use the CurrentX, CurrentY Properties." image="method"/>
<member name="COMARRAY" proto="COMARRAY(oObject [, nNewValue])" help="Specifies how to pass arrays to COM objects." image="method"/>
<member name="COMCLASSINFO" proto="COMCLASSINFO(oObject [, nInfoType])" help="Returns registry information about a COM object such as a Visual FoxPro automation server." image="method"/>
<member name="COMPOBJ" proto="COMPOBJ(oExpression1, oExpression2)" help="Compares the properties of two objects and returns True (.T.) if their properties and property values are identical." image="method"/>
<member name="COMPROP" proto="COMPROP(oCOMObject, cProperty [, eValue])" help="Sets or returns the behavior setting of a COM object property." image="method"/>
<member name="COMRETURNERROR" proto="COMRETURNERROR(cExceptionSource, cExceptionText)" help="Populates the COM exception structure with information that Automation clients can use to determine the source of Automation errors." image="method"/>
<member name="COS" proto="COS(nExpression)" help="Returns the cosine of a numeric expression." image="method"/>
<member name="CPCONVERT" proto="CPCONVERT(nCurrentCodePage, nNewCodePage, cExpression)" help="Converts character or memo fields or character expressions to another code page." image="method"/>
<member name="CPCURRENT" proto="CPCURRENT([1 | 2])" help="Returns the code page setting (if any) in your Visual FoxPro configuration file, or returns the current operating system code page." image="method"/>
<member name="CPDBF" proto="CPDBF([nWorkArea | cTableAlias])" help="Returns the code page with which an open table has been marked." image="method"/>
<member name="CREATEBINARY" proto="CREATEBINARY(cExpression)" help="Converts character type data created in Visual FoxPro to a binary type character string you can pass to an ActiveX control or automation object." image="method"/>
<member name="CREATEOBJECT" proto="CREATEOBJECT(cClassName [, eParameter1, eParameter2, ...])" help="Creates an object from a class definition or an Automation-enabled application." image="method"/>
<member name="CREATEOBJECTEX" proto="CREATEOBJECTEX(cCLSID | cPROGID, cComputerName [, cIID])" help="Creates an instance of a registered COM object (such as a Visual FoxPro Automation server) on a remote computer." image="method"/>
<member name="CREATEOFFLINE" proto="CREATEOFFLINE(ViewName [, cPath])" help="Takes an existing view offline." image="method"/>
<member name="CTOBIN" proto="CTOBIN(cExpression [, cFlags])" help="Converts a binary character representation to a numeric value." image="method"/>
<member name="CTOD" proto="CTOD(cExpression)" help="Converts a character expression to a date expression." image="method"/>
<member name="CTOT" proto="CTOT(cCharacterExpression)" help="Returns a DateTime value from a character expression." image="method"/>
<member name="CURDIR" proto="CURDIR([cExpression])" help="Returns the current directory." image="method"/>
<member name="CURSORGETPROP" proto="CURSORGETPROP(cProperty [, nWorkArea | cTableAlias])" help="Retrieves the current property settings for a Visual FoxPro table or a cursor." image="method"/>
<member name="CURSORSETPROP" proto="CURSORSETPROP( cProperty [, eExpression] [,cTableAlias | nWorkArea])" help="Specifies property settings for a Visual FoxPro table or a cursor." image="method"/>
<member name="CURSORTOXML" proto="CURSORTOXML(nWorkArea | cTableAlias, cOutput [, nOutputFormat[, nFlags [, nRecords [, cSchemaName [, cSchemaLocation [, cNameSpace ]]]]]])" help="Converts a Visual FoxPro cursor to XML." image="method"/>
<member name="CURVAL" proto="CURVAL(cExpression [, cTableAlias | nWorkArea])" help="Returns field values directly from disk for a table or a remote data source." image="method"/>
<member name="DATE" proto="DATE([nYear, nMonth, nDay])" help="Returns the current system date, which is controlled by the operating system, or creates a year 2000-compliant Date value." image="method"/>
<member name="DATETIME" proto="DATETIME([nYear, nMonth, nDay [, nHours [, nMinutes [, nSeconds]]]])" help="Returns the current date and time as a DateTime value, or creates a year 2000-compliant DateTime value." image="method"/>
<member name="DAY" proto="DAY(dExpression | tExpression)" help="Returns the numeric day of the month for a given Date or DateTime expression." image="method"/>
<member name="DBC" proto="DBC(�)" help="Returns the name and path of the current database." image="method"/>
<member name="DBF" proto="DBF([cTableAlias | nWorkArea])" help="Returns the name of a table open in a specified work area or a table name from a table alias." image="method"/>
<member name="DBGETPROP" proto="DBGETPROP(cName, cType, cProperty)" help="Retrieves the value of a property for the current database or for fields, named connections, tables, or views in the current database." image="method"/>
<member name="DBSETPROP" proto="DBSETPROP(cName, cType, cProperty, ePropertyValue)" help="Sets a property for the current database or for fields, named connections, tables, or views in the current database." image="method"/>
<member name="DBUSED" proto="DBUSED(cDatabaseName)" help="Returns true (.T.) if the specified database is open." image="method"/>
<member name="DDEAbortTrans" proto="DDEAbortTrans(nTransactionNumber)" help="Ends an asynchronous dynamic data exchange (DDE) transaction." image="method"/>
<member name="DDEAdvise" proto="DDEAdvise(nChannelNumber, cItemName, cUDFName, nLinkType)" help="Creates a notify link or an automatic link used in a dynamic data exchange (DDE)." image="method"/>
<member name="DDEEnabled" proto="DDEEnabled([lExpression1 | nChannelNumber [, lExpression2]])" help="Enables or disables dynamic data exchange (DDE) processing or returns the status of DDE processing." image="method"/>
<member name="DDEExecute" proto="DDEExecute(nChannelNumber, cCommand [, cUDFName])" help="Sends a command to another application, using dynamic data exchange (DDE)." image="method"/>
<member name="DDEInitiate" proto="DDEInitiate(cServiceName, cTopicName)" help="Establishes a dynamic data exchange (DDE) channel between Visual FoxPro and another Microsoft Windows-based application." image="method"/>
<member name="DDELastError" proto="DDELastError(�)" help="Returns an error number for the last dynamic data exchange (DDE) function." image="method"/>
<member name="DDEPoke" proto="DDEPoke(nChannelNumber, cItemName, cDataSent[, cDataFormat [, cUDFName]])" help="Sends data between client and server applications in a dynamic data exchange (DDE) conversation." image="method"/>
<member name="DDERequest" proto="DDERequest(nChannelNumber, cItemName [, cDataFormat [, cUDFName]])" help="Requests data from a server application in a dynamic data exchange (DDE) conversation." image="method"/>
<member name="DDESetOption" proto="DDESetOption(cOption [, nTimeoutValue | lExpression])" help="Changes or returns dynamic data exchange (DDE) settings." image="method"/>
<member name="DDESetService" proto="DDESetService(cServiceName, cOption [, cDataFormat | lExpression])" help="Creates, releases, or modifies DDE service names and settings." image="method"/>
<member name="DDESetTopic" proto="DDESetTopic(cServiceName, cTopicName [, cUDFName])" help="Creates or releases a topic name from a service name in a dynamic data exchange (DDE) conversation." image="method"/>
<member name="DDETerminate" proto="DDETerminate(nChannelNumber | cServiceName)" help="Closes a dynamic data exchange (DDE) channel established with DDEInitiate(�)." image="method"/>
<member name="DEFAULTEXT" proto="DEFAULTEXT(cFileName, cDefault)" help="Returns a file name with a new extension if one does not already exist." image="method"/>
<member name="DELETED" proto="DELETED([cTableAlias | nWorkArea])" help="Returns a logical value that indicates whether the current record is marked for deletion." image="method"/>
<member name="DESCENDING" proto="DESCENDING([CDXFileName[, nIndexNumber [, nWorkArea | cTableAlias]]])" help="Returns a logical value that indicates whether an index tag was created with the DESCENDING keyword or whether the DESCENDING keyword was included in USE, SET INDEX, or SET ORDER." image="method"/>
<member name="DIFFERENCE" proto="DIFFERENCE(cExpression1, cExpression2)" help="Returns an integer, 0 through 4, which represents the relative phonetic difference between two character expressions." image="method"/>
<member name="DIRECTORY" proto="DIRECTORY(cDirectoryName [, nFlags])" help="Locates the specified directory." image="method"/>
<member name="DISKSPACE" proto="DISKSPACE([cVolumeName [, nType]])" help="Retrieves the number of bytes with the specified type that are available on the default or specified hard disk drive or volume." image="method"/>
<member name="DISPLAYPATH" proto="DISPLAYPATH(cFilename, nMaxLength)" help="Truncates long path expressions to a specified length for display." image="method"/>
<member name="DMY" proto="DMY(dExpression | tExpression)" help="Returns a character expression in day-month-year format (for example, 31 May 1998) from a Date or DateTime expression. The month name isn't abbreviated." image="method"/>
<member name="DODEFAULT" proto="DODEFAULT( [ eParameter1 [, eParameter2] ...] )" help="Executes the parent class event or method of the same name from within a subclass." image="method"/>
<member name="DOW" proto="DOW(dExpression | tExpression [, nFirstDayOfWeek])" help="Returns a numeric day-of-the-week value from a Date or DateTime expression." image="method"/>
<member name="DRIVETYPE" proto="DRIVETYPE(cDrive)" help="Returns the type of the specified drive." image="method"/>
<member name="DROPOFFLINE" proto="DROPOFFLINE(cViewName)" help="Discards all changes made to an offline view and takes the offline view back online." image="method"/>
<member name="DTOC" proto="DTOC(dExpression | tExpression [, 1])" help="Returns a Character-type date from a Date or DateTime expression." image="method"/>
<member name="DTOR" proto="DTOR(nExpression)" help="Converts degrees to radians." image="method"/>
<member name="DTOS" proto="DTOS(dExpression | tExpression)" help="Returns a character-string date in a yyyymmdd format from a specified Date or DateTime expression." image="method"/>
<member name="DTOT" proto="DTOT(dDateExpression)" help="Returns a DateTime value from a Date expression." image="method"/>
<member name="EDITSOURCE" proto="EDITSOURCE(cShortCutID | [ cFilename [, nLineNo] [, cClassName][, cMethodName|cProcName]])" help="Opens the Visual FoxPro editor and, optionally positions the cursor." image="method"/>
<member name="EMPTY" proto="EMPTY(eExpression)" help="Determines whether an expression evaluates to empty." image="method"/>
<member name="EOF" proto="EOF([nWorkArea | cTableAlias])" help="Determines whether the record pointer is positioned past the last record in the current or specified table." image="method"/>
<member name="ERROR" proto="ERROR(�)" help="Returns the error number for the error that triggered an ON ERROR routine." image="method"/>
<member name="EVALUATE" proto="EVALUATE(cExpression)" help="Evaluates a character expression and returns the result." image="method"/>
<member name="EVENTHANDLER" proto="EVENTHANDLER(oCOMObject, oVFPObject [, lUnbind])" help="Binds a COM server event to implemented interface methods on a Visual FoxPro object." image="method"/>
<member name="EVL" proto="EVL( eExpression1, eExpression2 )" help="Returns a non-empty value from two expressions." image="method"/>
<member name="EXECSCRIPT" proto="EXECSCRIPT(cExpression [, eParameter1, eParameter2, ...])" help="Enables you to run multiple lines of code from variables, tables, and other text at runtime." image="method"/>
<member name="EXP" proto="EXP(nExpression)" help="Returns the value of ex where x is a specified numeric expression." image="method"/>
<member name="FCHSIZE" proto="FCHSIZE(nFileHandle, nNewFileSize)" help="Changes the size of a file opened with a low-level file function." image="method"/>
<member name="FCLOSE" proto="FCLOSE(nFileHandle)" help="Flushes and closes a file or communication port opened with a low-level file function." image="method"/>
<member name="FCOUNT" proto="FCOUNT([nWorkArea | cTableAlias])" help="Returns the number of fields in a table." image="method"/>
<member name="FCREATE" proto="FCREATE(cFileName [, nFileAttribute])" help="Creates and opens a low-level file." image="method"/>
<member name="FDATE" proto="FDATE(cFileName [, nType])" help="Returns the last modification Date or DateTime for a file." image="method"/>
<member name="FEOF" proto="FEOF(nFileHandle)" help="Determines whether the file pointer is positioned at the end of a file." image="method"/>
<member name="FERROR" proto="FERROR(�)" help="Returns a number corresponding to the most recent low-level file function error." image="method"/>
<member name="FFLUSH" proto="FFLUSH(nFileHandle [, lForce])" help="Flushes to disk a file opened with a low-level function." image="method"/>
<member name="FGETS" proto="FGETS(nFileHandle [, nBytes])" help="Returns a series of bytes from a file or a communication port opened with a low-level file function until it encounters a carriage return." image="method"/>
<member name="FIELD" proto="FIELD(nFieldNumber | cFieldName [, nWorkArea | cTableAlias [, nFlags]])" help="Returns the name of a field, referenced by number, in a table." image="method"/>
<member name="FILE" proto="FILE(cFileName [, nFlags])" help="Locates the specified file." image="method"/>
<member name="FILETOSTR" proto="FILETOSTR(cFileName)" help="Returns the contents of a file as a character string." image="method"/>
<member name="FILTER" proto="FILTER([nWorkArea | cTableAlias])" help="Returns the table filter expression specified in SET FILTER." image="method"/>
<member name="FKLABEL" proto="FKLABEL(nFunctionKeyNumber)" help="Returns the name of the function key (F1, F2, F3 ...) from the key's corresponding function key number." image="method"/>
<member name="FKMAX" proto="FKMAX(�)" help="Returns the number of programmable function keys or function key combinations on your keyboard." image="method"/>
<member name="FLOCK" proto="FLOCK([nWorkArea | cTableAlias])" help="Attempts to lock the current or specified table." image="method"/>
<member name="FLOOR" proto="FLOOR(nExpression)" help="Returns the nearest integer that is less than or equal to the specified numeric expression." image="method"/>
<member name="FONTMETRIC" proto="FONTMETRIC(nAttribute [, cFontName, nFontSize [, cFontStyle]])" help="Returns font attributes for the current installed operating system fonts." image="method"/>
<member name="FOPEN" proto="FOPEN(cFileName [, nAttribute])" help="Opens a file for use with low-level file functions." image="method"/>
<member name="FOR" proto="FOR([nIndexNumber [, nWorkArea | cTableAlias]])" help="Returns the index filter expression, in uppercase, of an open single-entry index (.idx) file or an index tag." image="method"/>
<member name="FORCEPATH" proto="FORCEPATH(cFileName, cPath)" help="Returns a file name with a new path name substituted for the old one." image="method"/>
<member name="FOUND" proto="FOUND([nWorkArea | cTableAlias])" help="Determines whether the most recently executed CONTINUE, FIND, LOCATE, or SEEK command was successful or if the record pointer was moved in a related table." image="method"/>
<member name="FPUTS" proto="FPUTS(nFileHandle, cExpression [, nCharactersWritten])" help="Writes a character string, carriage return, and line feed to a file opened with a low-level file function." image="method"/>
<member name="FREAD" proto="FREAD(nFileHandle, nBytes)" help="Returns a specified number of bytes from a file opened with a low-level function." image="method"/>
<member name="FSEEK" proto="FSEEK(nFileHandle, nBytesMoved [, nRelativePosition])" help="Moves the file pointer in a file opened with a low-level file function." image="method"/>
<member name="FSIZE" proto="FSIZE(cFieldName [, nWorkArea | cTableAlias] | cFileName)" help="Returns the size in bytes of a specified field or file." image="method"/>
<member name="FTIME" proto="FTIME(cFileName)" help="Returns the last modification time for a file." image="method"/>
<member name="FULLPATH" proto="FULLPATH(cFileName1 [, nMSDOSPath | cFileName2])" help="Returns the path to a specified file or the path relative to another file." image="method"/>
<member name="FV" proto="FV(nPayment, nInterestRate, nPeriods)" help="Returns the future value of a financial investment." image="method"/>
<member name="FWRITE" proto="FWRITE(nFileHandle, cExpression [, nCharactersWritten])" help="Writes a character string to a file opened with a low-level file function." image="method"/>
<member name="GETAUTOINCVALUE" proto="GETAUTOINCVALUE([nDataSessionNumber | 0])" help="Returns the last value generated for an autoincremented field within a data session." image="method"/>
<member name="GETBAR" proto="GETBAR(MenuItemName, nMenuPosition)" help="Returns the number of an item on a menu defined with DEFINE POPUP or the Visual FoxPro system menu." image="method"/>
<member name="GETCOLOR" proto="GETCOLOR([nDefaultColorNumber])" help="Displays the Windows Color dialog box and returns the color number of the chosen color." image="method"/>
<member name="GETCP" proto="GETCP([nCodePage] [, cText] [, cDialogTitle])" help="Prompts for a code page by displaying the Code Page dialog box, and then returns the number of the code page chosen." image="method"/>
<member name="GETCURSORADAPTER" proto="GETCURSORADAPTER( [ cAlias ] )" help="Returns an object reference to a CursorAdapter object at run time by referencing the cursor name." image="method"/>
<member name="GETDIR" proto="GETDIR([cDirectory [, cText [, cCaption [, nFlags [, lRootOnly]]]]])" help="Displays the Select Directory dialog box from which you can choose a directory." image="method"/>
<member name="GETENV" proto="GETENV(cVariableName)" help="Returns the contents of the specified MS-DOS environment variable." image="method"/>
<member name="GETFILE" proto="GETFILE([cFileExtensions] [, cText] [, cOpenButtonCaption][, nButtonType] [, cTitleBarCaption])" help="Displays the Open dialog box." image="method"/>
<member name="GETFLDSTATE" proto="GETFLDSTATE(cFieldName | nFieldNumber [, cTableAlias | nWorkArea])" help="Returns a numeric value indicating if a field in a table or cursor has been modified or had a record appended, or if the deleted status of the current record has been changed." image="method"/>
<member name="GETFONT" proto="GETFONT([cFontName [, nFontSize [, cFontStyle [, nFontCharSet]]]])" help="Displays the Font dialog box and returns information about the font you choose." image="method"/>
<member name="GETINTERFACE" proto="GETINTERFACE(oObject [, cIID | cInterface[, cTypelib | cProgID]])" help="Provides access to COM object properties, methods, and events through early binding." image="method"/>
<member name="GETNEXTMODIFIED" proto="GETNEXTMODIFIED(nRecordNumber [, cTableAlias | nWorkArea] [, lNoFire])" help="Returns the record number for the next modified record in a buffered table or cursor." image="method"/>
<member name="GETOBJECT" proto="GETOBJECT(cFileName | Moniker [, cClassName])" help="Activates an Automation object and creates a reference to the object." image="method"/>
<member name="GETPAD" proto="GETPAD(cMenuBarName, nMenuBarPosition)" help="Returns the menu title for a given position on the menu bar." image="method"/>
<member name="GETPEM" proto="GETPEM(oObjectName | cClassName, cProperty | cEvent | cMethod)" help="Returns the current value for a property or program code for an event or method at design time." image="method"/>
<member name="GETPICT" proto="GETPICT([cFileExtensions] [, cFileNameCaption] [, cOpenButtonCaption])" help="Displays the Open Picture dialog box and returns the name of the picture file you chose." image="method"/>
<member name="GETPRINTER" proto="GETPRINTER(�)" help="Displays the Printer dialog box and returns the name of the selected printer." image="method"/>
<member name="GETRESULTSET" proto="GETRESULTSET(�)" help="Retrieves the work area number of a cursor marked by SETRESULTSET(�) in the current data session." image="method"/>
<member name="GETWORDCOUNT" proto="GETWORDCOUNT(cString[, cDelimiters])" help="Counts the words in a string." image="method"/>
<member name="GETWORDNUM" proto="GETWORDNUM(cString, nIndex[, cDelimiters])" help="Returns a specified word from a string." image="method"/>
<member name="GOMONTH" proto="GOMONTH(dExpression | tExpression, nNumberOfMonths)" help="Returns the date that is a specified number of months before or after a given Date or Date/Time expression." image="method"/>
<member name="HEADER" proto="HEADER([nWorkArea | cTableAlias])" help="Returns the number of bytes in the header of the current or specified table file." image="method"/>
<member name="HOME" proto="HOME([nLocation])" help="Returns the names of the Visual FoxPro and Visual Studio directories." image="method"/>
<member name="HOUR" proto="HOUR(tExpression)" help="Returns the hour portion from a DateTime expression." image="method"/>
<member name="ICASE" proto="ICASE( lCondition1, eResult1 [, lCondition2, eResult2] ...[, eOtherwiseResult])" help="Evaluates the results from a list of conditions." image="method"/>
<member name="ID" proto="ID(�)" help="ID( ) returns network machine information when using Visual FoxPro in a network environment. The same functionality is available by using SYS(0)" image="method"/>
<member name="IDXCOLLATE" proto="IDXCOLLATE([cCDXFileName,] nIndexNumber [, nWorkArea | cTableAlias])" help="Returns the collating sequence for an index or index tag." image="method"/>
<member name="IIF" proto="IIF(lExpression, eExpression1, eExpression2)" help="Returns one of two values depending on the value of a logical expression." image="method"/>
<member name="IMESTATUS" proto="IMESTATUS([nExpression])" help="Turns the IME (Input Method Editor) window on or off or returns the current IME status." image="method"/>
<member name="INDBC" proto="INDBC(cDatabaseObjectName, cType)" help="Returns true (.T.) if the specified database object is in the current database; otherwise returns false (.F.)." image="method"/>
<member name="INDEXSEEK" proto="INDEXSEEK(eExpression [, lMovePointer [, nWorkArea | cTableAlias[, nIndexNumber | cIDXIndexFileName | cTagName]]])" help="Without moving the record pointer, searches an indexed table for the first occurrence of a record whose index key matches a specified expression." image="method"/>
<member name="INKEY" proto="INKEY([nSeconds] [, cHideCursor])" help="Returns a number corresponding to the first mouse click or key press in the type-ahead buffer." image="method"/>
<member name="INLIST" proto="INLIST(eExpression1, eExpression2 [, eExpression3 ...])" help="Determines whether an expression matches another expression in a set of expressions." image="method"/>
<member name="INPUTBOX" proto="INPUTBOX(cInputPrompt [, cDialogCaption [, cDefaultValue [, nTimeout [,cTimeoutValue] [,cCancelValue]]]])" help="Displays a modal dialog used by a parameterized view for input of a single string." image="method"/>
<member name="INSMODE" proto="INSMODE([lExpression])" help="Returns the current insert mode, or sets the insert mode on or off." image="method"/>
<member name="INT" proto="INT(nExpression)" help="Evaluates a numeric expression and returns the integer portion of the expression." image="method"/>
<member name="ISALPHA" proto="ISALPHA(cExpression)" help="Determines whether the leftmost character in a character expression is alphabetic." image="method"/>
<member name="ISBLANK" proto="ISBLANK(eExpression)" help="Determines whether an expression is blank." image="method"/>
<member name="ISCOLOR" proto="ISCOLOR(�)" help="Determines whether a computer can display color." image="method"/>
<member name="ISDIGIT" proto="ISDIGIT(cExpression)" help="Determines whether the leftmost character of the specified character expression is a digit (0 through 9)." image="method"/>
<member name="ISEXCLUSIVE" proto="ISEXCLUSIVE([cTableAlias | nWorkArea | cDatabaseName [, nType]])" help="Returns true (.T.) if a table or database is opened for exclusive use; otherwise, returns false (.F.)." image="method"/>
<member name="ISFLOCKED" proto="ISFLOCKED([nWorkArea | cTableAlias])" help="Returns the table lock status." image="method"/>
<member name="ISLEADBYTE" proto="ISLEADBYTE(cExpression)" help="Returns true (.T.) if the first byte of the first character in a character expression is the lead byte of a double-byte character." image="method"/>
<member name="ISLOWER" proto="ISLOWER(cExpression)" help="Determines whether the leftmost character of the specified character expression is a lowercase alphabetic character." image="method"/>
<member name="ISMEMOFETCHED" proto="ISMEMOFETCHED(cFieldName | nFieldNumber [, nWorkArea | cTableAlias])" help="Determines if a memo field has been fetched during a delayed memo fetch." image="method"/>
<member name="ISMOUSE" proto="ISMOUSE(�)" help="Returns true (.T.) if mouse hardware is present." image="method"/>
<member name="ISNULL" proto="ISNULL(eExpression)" help="Returns true (.T.) if an expression evaluates to a null value; otherwise, ISNULL(�) returns false (.F.)." image="method"/>
<member name="ISPEN" proto="ISPEN(�)" help="Determines if the last Tablet PC mouse event was a pen tap." image="method"/>
<member name="ISREADONLY" proto="ISREADONLY([nWorkArea | cTableAlias])" help="Determines whether a table or database is opened read-only." image="method"/>
<member name="ISRLOCKED" proto="ISRLOCKED([nRecordNumber, [nWorkArea | cTableAlias]])" help="Returns the record lock status." image="method"/>
<member name="ISTRANSACTABLE" proto="ISTRANSACTABLE([nWorkArea | cAlias])" help="Returns a logical value indicating if a free table or free cursor supports transactions." image="method"/>
<member name="ISUPPER" proto="ISUPPER(cExpression)" help="Determines whether the first character in a character expression is an uppercase alphabetic character." image="method"/>
<member name="JUSTDRIVE" proto="JUSTDRIVE(cPath)" help="Returns the drive letter from a complete path." image="method"/>
<member name="JUSTEXT" proto="JUSTEXT(cPath)" help="Returns the characters of a file extension from a complete path." image="method"/>
<member name="JUSTFNAME" proto="JUSTFNAME(cFileName)" help="Returns the file name portion of a complete path and file name." image="method"/>
<member name="JUSTPATH" proto="JUSTPATH(cFileName)" help="Returns the path portion of a complete path and file name." image="method"/>
<member name="JUSTSTEM" proto="JUSTSTEM(cFileName)" help="Returns the stem name (the file name before the extension) from a complete path and file name." image="method"/>
<member name="KEY" proto="KEY([CDXFileName,] nIndexNumber [, nWorkArea | cTableAlias])" help="Returns the index key expression for an index tag or index file." image="method"/>
<member name="KEYMATCH" proto="KEYMATCH(eIndexKey [, nIndexNumber [, nWorkArea | cTableAlias]])" help="Searches an index tag or index file for an index key." image="method"/>
<member name="LASTKEY" proto="LASTKEY(�)" help="Returns an integer corresponding to the last key pressed." image="method"/>
<member name="LEFT" proto="LEFT(cExpression, nExpression)" help="Returns a specified number of characters from a character expression, starting with the leftmost character." image="method"/>
<member name="LEFTC" proto="LEFTC(cExpression, nExpression)" help="Returns a specified number of characters from a character expression, starting with the leftmost character." image="method"/>
<member name="LEN" proto="LEN(cExpression)" help="Determines the number of characters in a character expression, indicating the length of the expression." image="method"/>
<member name="LENC" proto="LENC(cExpression)" help="Returns the number of characters in a character expression or memo field." image="method"/>
<member name="LIKE" proto="LIKE(cExpression1, cExpression2)" help="Determines if a character expression matches another character expression." image="method"/>
<member name="LIKEC" proto="LIKEC(cExpression1, cExpression2)" help="Determines whether a character expression matches another character expression." image="method"/>
<member name="LINENO" proto="LINENO([1])" help="Returns the line number of a line being executed in a program relative to the first line of the main program." image="method"/>
<member name="LOADPICTURE" proto="LOADPICTURE([cFileName])" help="Creates an object reference for a bitmap, icon, or Windows meta file." image="method"/>
<member name="LOCFILE" proto="LOCFILE(cFileName [, cFileExtensions] [, cFileNameCaption])" help="Locates a file on disk and returns the file name with its path." image="method"/>
<member name="LOCK" proto="LOCK([nWorkArea | cTableAlias]|[cRecordNumberList, nWorkArea | cTableAlias])" help="Attempts to lock one or more records in a table." image="method"/>
<member name="LOG" proto="LOG(nExpression)" help="Returns the natural logarithm (base e) of the specified numeric expression." image="method"/>
<member name="LOG10" proto="LOG10(nExpression)" help="Returns the common logarithm (base 10) of the specified numeric expression." image="method"/>
<member name="LOOKUP" proto="LOOKUP(ReturnField, eSearchExpression, SearchedField [, cTagName])" help="Searches a table for the first record with a field matching the specified expression." image="method"/>
<member name="LOWER" proto="LOWER(cExpression)" help="Returns a specified character expression in lowercase letters." image="method"/>
<member name="LTRIM" proto="LTRIM(Expression [, nFlags] [, cParseChar [, cParseChar2 [, ...]]])" help="Removes all leading spaces or parsing characters from the specified character expression, or all leading zero (0) bytes from the specified binary expression." image="method"/>
<member name="LUPDATE" proto="LUPDATE([nWorkArea | cTableAlias])" help="Returns the date on which a table was last updated." image="method"/>
<member name="MAKETRANSACTABLE" proto="MAKETRANSACTABLE([nWorkArea | cAlias])" help="Allows a free table or free cursor to support transactions." image="method"/>
<member name="MAX" proto="MAX(eExpression1, eExpression2 [, eExpression3 ...])" help="Evaluates a set of expressions and returns the expression with the maximum value." image="method"/>
<member name="MCOL" proto="MCOL([cWindowName | 0 [, nScaleMode]])" help="Returns the column position of the mouse pointer in the main Visual FoxPro window or a user-defined window or form." image="method"/>
<member name="MDX" proto="MDX(nIndexNumber [, nWorkArea | cTableAlias])" help="Returns the name of the open .cdx compound index file that has the specified index position number." image="method"/>
<member name="MDY" proto="MDY(dExpression | tExpression)" help="Returns the specified date or datetime expression in month-day-year format with the name of the month spelled out." image="method"/>
<member name="MEMLINES" proto="MEMLINES(MemoFieldName)" help="Returns the number of lines in a memo field." image="method"/>
<member name="MEMORY" proto="MEMORY(�)" help="Returns the amount of memory available to run an external program." image="method"/>
<member name="MENU" proto="MENU(�)" help="Returns the name of the active menu bar as an uppercase character string." image="method"/>
<member name="MESSAGE" proto="MESSAGE([1])" help="Returns the current error message or the program line that caused the error." image="method"/>
<member name="MESSAGEBOX" proto="MESSAGEBOX(eMessageText [, nDialogBoxType ][, cTitleBarText][, nTimeout])" help="Displays a user-defined dialog box." image="method"/>
<member name="MIN" proto="MIN(eExpression1, eExpression2 [, eExpression3 ...])" help="Evaluates a set of expressions and returns the expression with the minimum value." image="method"/>
<member name="MINUTE" proto="MINUTE(tExpression)" help="Returns the minute portion from a DateTime expression." image="method"/>
<member name="MLINE" proto="MLINE(MemoFieldName, nLineNumber [, nNumberOfCharacters])" help="Returns a specific line from a Memo field as a character string." image="method"/>
<member name="MOD" proto="MOD(nDividend, nDivisor)" help="Divides one numeric expression by another numeric expression and returns the remainder." image="method"/>
<member name="MONTH" proto="MONTH(dExpression | tExpression)" help="Returns the number of the month for a given Date or DateTime expression." image="method"/>
<member name="MRKBAR" proto="MRKBAR(cMenuName, nMenuItemNumber | cSystemMenuItemName)" help="Determines whether a menu item on a user-defined or Microsoft Visual FoxPro system menu is marked." image="method"/>
<member name="MRKPAD" proto="MRKPAD(cMenuBarName, cMenuTitleName)" help="Determines whether a menu title on a user-defined menu bar or on the Visual FoxPro system menu bar is marked." image="method"/>
<member name="MROW" proto="MROW([cWindowName | 0 [, nScaleMode]])" help="Returns the row position of the mouse pointer in the main Visual FoxPro window or in a user-defined window or form." image="method"/>
<member name="MTON" proto="MTON(mExpression)" help="Returns a Numeric value from a Currency expression." image="method"/>
<member name="MWINDOW" proto="MWINDOW([cWindowName])" help="Returns the name of the window over which the mouse pointer is positioned." image="method"/>
<member name="NDX" proto="NDX(nIndexNumber [, nWorkArea | cTableAlias])" help="Returns the name of an open index (.IDX) file for the current or specified table." image="method"/>
<member name="NEWOBJECT" proto="NEWOBJECT(cClassName [, cModule [, cInApplication | 0[, eParameter1, eParameter2, ...]]])" help="Creates a new class or object directly from a visual class library (.vcx) file or program (.prg) file without opening the file." image="method"/>
<member name="NORMALIZE" proto="NORMALIZE(cExpression)" help="Converts a character expression, supplied by a user, into a form that can be compared with Visual FoxPro function return values." image="method"/>
<member name="NTOM" proto="NTOM(nExpression)" help="Returns a Currency value from a Numeric expression." image="method"/>
<member name="NUMLOCK" proto="NUMLOCK([lExpression])" help="Returns the current mode of the NUM LOCK key or sets the mode of the NUM LOCK key on or off." image="method"/>
<member name="NVL" proto="NVL(eExpression1, eExpression2)" help="Returns a non-null value from two expressions." image="method"/>
<member name="OBJTOCLIENT" proto="OBJTOCLIENT(ObjectName, nPosition)" help="Returns a position or dimension of a control or object relative to its form." image="method"/>
<member name="OCCURS" proto="OCCURS(cSearchExpression, cExpressionSearched)" help="Returns the number of times a character expression occurs within another character expression." image="method"/>
<member name="OLDVAL" proto="OLDVAL(cExpression [, cTableAlias | nWorkArea])" help="Returns original field values for fields that have been modified but not updated." image="method"/>
<member name="ON" proto="ON(cONCommand [, KeyLabelName])" help="Returns the command assigned to each of these event-handling commands: ON ERROR, ON ESCAPE, ON KEY LABEL, or ON PAGE." image="method"/>
<member name="ORDER" proto="ORDER([nWorkArea | cTableAlias [, nPath]])" help="Returns the name of the controlling index file or tag for the current or specified table." image="method"/>
<member name="OS" proto="OS([nValue])" help="Returns the name and version number of the operating system under which Microsoft Visual FoxPro is running." image="method"/>
<member name="PAD" proto="PAD([cMenuTitle [, cMenuBarName]])" help="Returns as an uppercase character string the menu title most recently chosen from a menu bar, or returns a logical value indicating if a menu title is defined for an active menu bar." image="method"/>
<member name="PADC" proto="PADC(eExpression, nResultSize [, cPadCharacter])" help="Returns a string from an expression, padded with spaces or characters to a specified length on both sides" image="method"/>
<member name="PADL" proto="PADL(eExpression, nResultSize [, cPadCharacter])" help="Returns a string from an expression, padded with spaces or characters to a specified length on the left side" image="method"/>
<member name="PADR" proto="PADR(eExpression, nResultSize [, cPadCharacter])" help="Returns a string from an expression, padded with spaces or characters to a specified length right side" image="method"/>
<member name="PARAMETERS" proto="PARAMETERS(�)" help="Returns the number of parameters passed to the most recently called program, procedure, or user-defined function." image="method"/>
<member name="PAYMENT" proto="PAYMENT(nPrincipal, nInterestRate, nPayments)" help="Returns the amount of each periodic payment on a fixed-interest loan." image="method"/>
<member name="PCOL" proto="PCOL(�)" help="Returns the current column position of the printer's print head." image="method"/>
<member name="PCOUNT" proto="PCOUNT(�)" help="Returns the number of parameters passed to the current program, procedure, or user-defined function." image="method"/>
<member name="PEMSTATUS" proto="PEMSTATUS(oObjectName | cClassName, cProperty | cEvent | cMethod| cObject, nAttribute)" help="Retrieves an attribute for a property, event, method, or object." image="method"/>
<member name="PI" proto="PI(�)" help="Returns the numeric constant pi." image="method"/>
<member name="POPUP" proto="POPUP([cMenuName])" help="Returns as a string the name of the active menu, or a logical value indicating if a menu has been defined." image="method"/>
<member name="PRIMARY" proto="PRIMARY([nIndexNumber] [, nWorkArea | cTableAlias])" help="Returns true (.T.) if an index tag is a primary index tag; otherwise, returns false (.F.)." image="method"/>
<member name="PRINTSTATUS" proto="PRINTSTATUS(�)" help="Returns the status of the printer. Included for backward compatibility." image="method"/>
<member name="PRMBAR" proto="PRMBAR(cMenuName, nMenuItemNumber)" help="Returns the text of a menu item." image="method"/>
<member name="PRMPAD" proto="PRMPAD(MenuBarName, MenuTitleName)" help="Returns the text of a menu title." image="method"/>
<member name="PROGRAM" proto="PROGRAM([nLevel])" help="Returns the name of the program at a specified program level, the name of the currently executing program, the current program level, or the name of the program executing when an error occurred." image="method"/>
<member name="PROMPT" proto="PROMPT(�)" help="Returns the text for a menu title chosen from a menu bar or for a menu item chosen from a menu." image="method"/>
<member name="PROPER" proto="PROPER(cExpression)" help="Returns from a character expression a string capitalized as appropriate for proper names." image="method"/>
<member name="PROW" proto="PROW(�)" help="Returns the current row number of the printer's print head." image="method"/>
<member name="PRTINFO" proto="PRTINFO(nPrinterSetting [, cPrinterName])" help="Returns the current specified printer setting." image="method"/>
<member name="PUTFILE" proto="PUTFILE([cCustomText] [, cFileName] [, cFileExtensions])" help="Invokes the Save As dialog box and returns the file name you specify." image="method"/>
<member name="PV" proto="PV(nPayment, nInterestRate, nTotalPayments)" help="Returns the present value of an investment." image="method"/>
<member name="QUARTER" proto="QUARTER(dExpression | tExpression [, nMonth])" help="Returns the quarter of the year in which a date or datetime expression occurs." image="method"/>
<member name="RAISEEVENT" proto="RAISEEVENT( oEventSource, cEvent [, eParm1...] )" help="You can use RAISEEVENT(�) to raise, or trigger, an event from a custom method. Though RAISEEVENT(�) applies primarily to custom methods, you can use it for raising native events and methods." image="method"/>
<member name="RAND" proto="RAND([nSeedValue])" help="Returns a random number between 0 and 1." image="method"/>
<member name="RAT" proto="RAT(cSearchExpression, cExpressionSearched [, nOccurrence])" help="Returns the numeric position of the last (rightmost) occurrence of a character string within another character string." image="method"/>
<member name="RATC" proto="RATC(cSearchExpression, cExpressionSearched [, nOccurrence])" help="Returns the numeric position of the last occurrence of a character expression or memo field within another character expression or memo field." image="method"/>
<member name="RATLINE" proto="RATLINE(cSearchExpression, cExpressionSearched)" help="Returns the line number of the last occurrence of a character expression within another character expression or memo field, counting from the last line." image="method"/>
<member name="RECCOUNT" proto="RECCOUNT([nWorkArea | cTableAlias])" help="Returns the number of records in the current or specified table." image="method"/>
<member name="RECNO" proto="RECNO([nWorkArea | cTableAlias])" help="Returns the current record number in the current or specified table." image="method"/>
<member name="RECSIZE" proto="RECSIZE([nWorkArea | cTableAlias])" help="Returns the size (width) of a table record." image="method"/>
<member name="REFRESH" proto="REFRESH([nRecords [, nRecordOffset]] [, cTableAlias | nWorkArea])" help="Refreshes data in an updatable SQL remote or local view, or CursorAdapter cursor." image="method"/>
<member name="RELATION" proto="RELATION(nRelationNumber [, nWorkArea | cTableAlias])" help="Returns a specified relational expression for a table open in a specific work area." image="method"/>
<member name="REMOVEPROPERTY" proto="REMOVEPROPERTY(oObjectName, cPropertyName)" help="Removes a property from an object at run time." image="method"/>
<member name="REPLICATE" proto="REPLICATE(cExpression, nTimes)" help="Returns a character string that contains a specified character expression repeated a specified number of times." image="method"/>
<member name="REQUERY" proto="REQUERY([nWorkArea | cTableAlias])" help="Retrieves data again for a SQL view." image="method"/>
<member name="RGB" proto="RGB(nRedValue, nGreenValue, nBlueValue)" help="Returns a single color value from a set of red, green, and blue color components." image="method"/>
<member name="RGBSCHEME" proto="RGBSCHEME(nColorSchemeNumber [, nColorPairPosition])" help="Returns an RGB color pair or an RGB color pair list from a specified color scheme." image="method"/>
<member name="RIGHT" proto="RIGHT(cExpression, nCharacters)" help="Returns the specified number of rightmost characters from a character string." image="method"/>
<member name="RIGHTC" proto="RIGHTC(cExpression, nCharacters)" help="Returns the specified number of rightmost characters from a character string." image="method"/>
<member name="RLOCK" proto="RLOCK([nWorkArea | cTableAlias] | [cRecordNumberList, nWorkArea| cTableAlias])" help="Attempts to lock a table record or records." image="method"/>
<member name="ROUND" proto="ROUND(nExpression, nDecimalPlaces)" help="Returns a numeric expression rounded to a specified number of decimal places." image="method"/>
<member name="RTOD" proto="RTOD(nExpression)" help="Converts radians to its equivalent in degrees." image="method"/>
<member name="RTRIM" proto="RTRIM(cExpression [, nFlags] [, cParseChar [, cParseChar2 [, ...]]])" help="Removes all trailing spaces or parsing characters from the specified character expression, or all trailing zero (0) bytes from the specified binary expression." image="method"/>
<member name="SAVEPICTURE" proto="SAVEPICTURE(oObjectReference, cFileName)" help="Creates a bitmap (.bmp) file from a picture object reference." image="method"/>
<member name="SCHEME" proto="SCHEME(nSchemeNumber [, nColorPairNumber])" help="Returns a color pair list or a single color pair from a specified color scheme." image="method"/>
<member name="SCOLS" proto="SCOLS(�)" help="Returns the number of columns available in the main Microsoft Visual FoxPro window." image="method"/>
<member name="SEC" proto="SEC(tExpression)" help="Returns the seconds portion from a DateTime expression." image="method"/>
<member name="SECONDS" proto="SECONDS(�)" help="Returns the number of seconds that have elapsed since midnight." image="method"/>
<member name="SEEK" proto="SEEK(eExpression [, nWorkArea | cTableAlias[, nIndexNumber | cIDXIndexFileName | cTagName]])" help="Searches an indexed table for the first occurrence of a record whose index key matches a specified expression. Issuing SEEK(�) is equivalent to issuing SEEK and FOUND(�) in succession." image="method"/>
<member name="SELECT" proto="SELECT([ 0 | 1 | cTableAlias ])" help="Returns the number of the currently selected work area or the highest-numbered unused work area." image="method"/>
<member name="SET" proto="SET(cSETCommand [, 1 | cExpression | 2 | 3 | 4])" help="Returns the status of various SET commands." image="method"/>
<member name="SETFLDSTATE" proto="SETFLDSTATE(cFieldName | nFieldNumber, nFieldState [, cTableAlias| nWorkArea])" help="Assigns a field modification or deletion state value to a field or record in a table or cursor." image="method"/>
<member name="SETRESULTSET" proto="SETRESULTSET( nWorkArea | cTableAlias )" help="Marks a cursor as a result set in the current data session." image="method"/>
<member name="SIGN" proto="SIGN(nExpression)" help="Returns a numeric value of 1, -1, or 0 if the specified numeric expression evaluates to a positive, negative, or 0 value." image="method"/>
<member name="SIN" proto="SIN(nExpression)" help="Returns the sine of an angle." image="method"/>
<member name="SKPBAR" proto="SKPBAR(cMenuName, MenuItemNumber)" help="Determines if a menu item is enabled or disabled with SET SKIP OF." image="method"/>
<member name="SKPPAD" proto="SKPPAD(cMenuBarName, cMenuTitleName)" help="Determines whether a menu title is enabled or disabled with SET SKIP OF." image="method"/>
<member name="SOUNDEX" proto="SOUNDEX(cExpression)" help="Returns a phonetic representation of the specified character expression." image="method"/>
<member name="SPACE" proto="SPACE(nSpaces)" help="Returns a character string composed of a specified number of spaces." image="method"/>
<member name="SQLCANCEL" proto="SQLCANCEL(nStatementHandle)" help="Requests cancellation of an executing SQL statement." image="method"/>
<member name="SQLCOLUMNS" proto="SQLCOLUMNS(nStatementHandle, cTableName[, 'FOXPRO' | 'NATIVE'] [, cCursorName])" help="Stores a list of column names and information about each column for the specified data source table to a Visual FoxPro cursor." image="method"/>
<member name="SQLCOMMIT" proto="SQLCOMMIT(nStatementHandle)" help="Commits a transaction." image="method"/>
<member name="SQLCONNECT" proto="SQLCONNECT([nStatementHandle])SQLCONNECT([cConnectionName | cDataSourceName [, cUserID [, cPassword ]][, lShared]])" help="Establishes a connection to a data source. There are two versions of the syntax." image="method"/>
<member name="SQLDISCONNECT" proto="SQLDISCONNECT(nStatementHandle)" help="Terminates a connection to a data source." image="method"/>
<member name="SQLEXEC" proto="SQLEXEC(nStatementHandle [, cSQLCommand [, cCursorName[, aCountInfo]]])" help="Sends a SQL statement to the data source, where the statement is processed." image="method"/>
<member name="SQLGETPROP" proto="SQLGETPROP(nStatementHandle, cSetting)" help="Retrieves the current or default settings for an active connection." image="method"/>
<member name="SQLIDLEDISCONNECT" proto="SQLIDLEDISCONNECT(nStatementHandle)" help="Allows a SQL pass-through connection or connections to be temporarily disconnected." image="method"/>
<member name="SQLMORERESULTS" proto="SQLMORERESULTS(nStatementHandle [, cCursorName [, aCountInfo]]))" help="Copies another result set to a Visual FoxPro cursor if more result sets are available." image="method"/>
<member name="SQLPREPARE" proto="SQLPREPARE(nStatementHandle, cSQLCommand, [cCursorName])" help="Prepares a SQL statement for remote execution by SQLEXEC(�)." image="method"/>
<member name="SQLROLLBACK" proto="SQLROLLBACK(nStatementHandle)" help="Cancels any changes made during the current transaction." image="method"/>
<member name="SQLSETPROP" proto="SQLSETPROP(nStatementHandle, cSetting [, eExpression])" help="Specifies settings for an active connection. You can use SQLSETPROP(�) to specify settings at the connection level. To specify Visual FoxPro default settings at the environment level, include 0 as the statement handle." image="method"/>
<member name="SQLSTRINGCONNECT" proto="SQLSTRINGCONNECT([lShared] | [cConnectString [, lSharable]])" help="Establishes a connection to a data source using a connection string." image="method"/>
<member name="SQLTABLES" proto="SQLTABLES(nStatementHandle [, cTableTypes] [, cCursorName])" help="Stores the names of tables in a data source to a Visual FoxPro cursor." image="method"/>
<member name="SQRT" proto="SQRT(nExpression)" help="Returns the square root of the specified numeric expression." image="method"/>
<member name="SROWS" proto="SROWS(�)" help="Returns the number of rows available in the main Visual FoxPro window." image="method"/>
<member name="STR" proto="STR(nExpression [, nLength [, nDecimalPlaces]])" help="Returns the character equivalent of a numeric expression." image="method"/>
<member name="STRCONV" proto="STRCONV(cExpression, nConversionSetting [, nRegionalIdentifier [, nRegionalIDType]])" help="Converts character expressions between single-byte, double-byte, UNICODE, and locale-specific representations." image="method"/>
<member name="STREXTRACT" proto="STREXTRACT(cSearchExpression, cBeginDelim [, cEndDelim [, nOccurrence[, nFlag]]]])" help="Retrieves a string between two delimiters." image="method"/>
<member name="STRTOFILE" proto="STRTOFILE(cExpression, cFileName [, lAdditive | nFlag])" help="Writes the contents of a character string to a file." image="method"/>
<member name="STRTRAN" proto="STRTRAN(cSearched, cExpressionSought [, cReplacement][, nStartOccurrence] [, nNumberOfOccurrences] [, nFlags])" help="Searches a character expression or memo field for a second character expression or memo field and replaces each occurrence with a third character expression or memo field. You can specify where the replacement begins and how many replacements are made." image="method"/>
<member name="STUFF" proto="STUFF(cExpression, nStartReplacement, nCharactersReplaced, cReplacement)" help="Returns a character string created by replacing a specified number of characters in a character expression with another character expression." image="method"/>
<member name="STUFFC" proto="STUFFC(cExpression, nStartReplacement, nCharactersReplaced, cReplacement)" help="Returns a character string created by replacing a specified number of characters in a character expression with another character expression." image="method"/>
<member name="SUBSTR" proto="SUBSTR(cExpression, nStartPosition [, nCharactersReturned])" help="Returns a character string from the given character expression or memo field, starting at a specified position in the character expression or memo field and continuing for a specified number of characters." image="method"/>
<member name="SUBSTRC" proto="SUBSTRC(cExpression, nStartPosition [, nCharactersReturned])" help="Returns a character string from the given character expression or memo field." image="method"/>
<member name="SYS" proto="SYS(�)" help="Returns Microsoft Visual FoxPro system information." image="method"/>
<member name="SYSMETRIC" proto="SYSMETRIC(nScreenElement)" help="Returns the size of the operating system's screen elements." image="method"/>
<member name="TABLEREVERT" proto="TABLEREVERT( [lAllRows [, cTableAlias | nWorkArea] ] )" help="Discards changes made to a buffered row or a buffered table or cursor and restores the OLDVAL(�) data for remote cursors and the current disk values for local tables and cursors." image="method"/>
<member name="TABLEUPDATE" proto="TABLEUPDATE( [nRows [, lForce]] [, cTableAlias | nWorkArea] [, cErrorArray] )" help="Commits changes made to a buffered row, a buffered table, cursor, or cursor adapter." image="method"/>
<member name="TAG" proto="TAG([CDXFileName[, nTagNumber[, nWorkArea | cTableAlias]]])" help="Returns a tag name from an open compound index (.cdx) file or the name of an open single-entry (.idx) index file." image="method"/>
<member name="TAGCOUNT" proto="TAGCOUNT([CDXFileName [, nWorkArea | cTableAlias]])" help="Returns the number of .cdx compound index file tags and open .idx single-entry index files." image="method"/>
<member name="TAGNO" proto="TAGNO([IndexName [, CDXFileName [, nExpression | cExpression]]])" help="Returns the index position for .cdx compound index file tags and open .idx single-entry index files." image="method"/>
<member name="TAN" proto="TAN(nExpression)" help="This trigonometric function returns the tangent of an angle." image="method"/>
<member name="TARGET" proto="TARGET(nRelationshipNumber [, nWorkArea | cTableAlias])" help="Returns the alias of a table that is the target for a relation as specified in the INTO clause of SET RELATION." image="method"/>
<member name="TEXTMERGE" proto="TEXTMERGE(cExpression [, lRecursive [, cLeftDelim [, cRightDelim]]])" help="Provides evaluation of a character expression." image="method"/>
<member name="TIME" proto="TIME([nExpression])" help="Returns the current system time in 24-hour, eight-character string (hh:mm:ss) format." image="method"/>
<member name="TRANSFORM" proto="TRANSFORM(eExpression, [cFormatCodes])" help="Returns a character string from an expression in a format determined by a format code." image="method"/>
<member name="TRIM" proto="TRIM(cExpression [, nFlags] [, cParseChar [, cParseChar2 [, ...]]])" help="Removes all trailing spaces or parsing characters from the specified character expression, or all trailing zero (0) bytes from the specified binary expression." image="method"/>
<member name="TTOC" proto="TTOC(tExpression [, 1 | 2 | 3])" help="Converts a DateTime expression to a Character value with the specified format." image="method"/>
<member name="TTOD" proto="TTOD(tExpression)" help="Returns a Date value from a DateTime expression." image="method"/>
<member name="TXNLEVEL" proto="TXNLEVEL(�)" help="Returns a numeric value indicating the current transaction level." image="method"/>
<member name="TXTWIDTH" proto="TXTWIDTH(cExpression [, cFontName, nFontSize [, cFontStyle]])" help="Returns the length of a character expression with respect to the average character width for a font." image="method"/>
<member name="TYPE" proto="TYPE(cExpression [, 1])" help="Returns the data type of an expression." image="method"/>
<member name="UNBINDEVENTS" proto="UNBINDEVENTS(oEventSource, cEvent, oEventHandler, cDelegate)" help="You can use UNBINDEVENTS(�) to unbind, or detach, an event that was originally bound to a Visual FoxPro object using BINDEVENT(�). To detach events from Component Object Model (COM) objects, use the EVENTHANDLER(�) function. There are three versions of the syntax." image="method"/>
<member name="UNBINDEVENTS" proto="UNBINDEVENTS(oEventObject)" help="You can use UNBINDEVENTS(�) to unbind, or detach, an event that was originally bound to a Visual FoxPro object using BINDEVENT(�). To detach events from Component Object Model (COM) objects, use the EVENTHANDLER(�) function. There are three versions of the syntax." image="method"/>
<member name="UNBINDEVENTS" proto="UNBINDEVENTS(hWnd [, nMessage])" help="You can use UNBINDEVENTS(�) to unbind, or detach, an event that was originally bound to a Visual FoxPro object using BINDEVENT(�). To detach events from Component Object Model (COM) objects, use the EVENTHANDLER(�) function. There are three versions of the syntax." image="method"/>
<member name="UPPER" proto="UPPER(cExpression)" help="Returns the specified character expression in uppercase." image="method"/>
<member name="USED" proto="USED([nWorkArea | cTableAlias])" help="Determines if an alias is in use or a table is open in a specific work area." image="method"/>
<member name="VAL" proto="VAL(cExpression)" help="Returns a numeric or currency value from a character expression composed of numbers. You can use VAL(�) to convert the character strings returned by the Visual FoxPro SYS(�) functions to numeric values." image="method"/>
<member name="VARTYPE" proto="VARTYPE(eExpression [, lNullDataType])" help="Returns the data type of an expression." image="method"/>
<member name="VERSION" proto="VERSION(nExpression)" help="Returns information about the Visual FoxPro version you are using." image="method"/>
<member name="WBORDER" proto="WBORDER([WindowName])" help="Determines whether the active or specified window has a border." image="method"/>
<member name="WCHILD" proto="WCHILD([WindowName] [nChildWindow])" help="Returns either the number of child windows in a parent window or the names of the child windows in the order in which they are stacked in the parent window." image="method"/>
<member name="WCOLS" proto="WCOLS([WindowName])" help="Returns the number of columns within the active or specified window." image="method"/>
<member name="WDOCKABLE" proto="WDOCKABLE(cWindowName [, lEnable])" help="Returns the dockable state of the specified window" image="method"/>
<member name="WEEK" proto="WEEK(dExpression | tExpression [, nFirstWeek] [, nFirstDayOfWeek])" help="Returns a number representing the week of the year from a Date or DateTime expression." image="method"/>
<member name="WEXIST" proto="WEXIST(WindowName)" help="Determines whether the specified user-defined window exists." image="method"/>
<member name="WFONT" proto="WFONT(nFontAttribute [, WindowName])" help="Returns the name, size, or style of the current font for a window in Visual FoxPro for Windows." image="method"/>
<member name="WLAST" proto="WLAST([WindowName])" help="Returns the name of the window that was active prior to the current window or determines whether the specified window was active prior to the current window." image="method"/>
<member name="WLCOL" proto="WLCOL([WindowName])" help="Returns the column coordinate of the upper-left corner of the active or specified window." image="method"/>
<member name="WLROW" proto="WLROW([WindowName])" help="Returns the row coordinate of the upper-left corner of the active or specified window." image="method"/>
<member name="WMAXIMUM" proto="WMAXIMUM([WindowName])" help="Determines whether the active or specified window is maximized." image="method"/>
<member name="WMINIMUM" proto="WMINIMUM([WindowName])" help="Determines whether the active or specified window is minimized." image="method"/>
<member name="WONTOP" proto="WONTOP([WindowName])" help="Determines whether the active or specified window is in front of all other windows." image="method"/>
<member name="WOUTPUT" proto="WOUTPUT([WindowName])" help="Determines whether output is being directed to the active or specified window." image="method"/>
<member name="WPARENT" proto="WPARENT([WindowName])" help="Returns the name of the parent window of the active or specified window." image="method"/>
<member name="WROWS" proto="WROWS([WindowName])" help="Returns the number of rows within the active or specified window." image="method"/>
<member name="WTITLE" proto="WTITLE([WindowName])" help="Returns the title assigned to the active or specified window." image="method"/>
<member name="WVISIBLE" proto="WVISIBLE(WindowName)" help="Determines if the specified window has been activated and isn't hidden." image="method"/>
<member name="XMLTOCURSOR" proto="XMLTOCURSOR(eExpression | cXMLFile [, cCursorName [, nFlags ]])" help="Converts XML text into a Visual FoxPro cursor or table." image="method"/>
<member name="XMLUPDATEGRAM" proto="XMLUPDATEGRAM( [ cAliasList [, nFlags [, cSchemaLocation]]])" help="Mirrors changes made in a buffered table or cursor in an XML UpdateGram and returns a character string that contains the UpdateGram." image="method"/>
<member name="YEAR" proto="YEAR(dExpression | tExpression)" help="Returns the year from the specified date or datetime expression." image="method"/>
</memberlist><language name="Visual FoxPro" casesensitive="no" wordchars="[\w]" whitespaceasparamblock="no">
	<tokenset name="Line Comments" id="linecomments" type="scope" forecolor="green" fontstyle="italic">
		<validscope name=""/>
		<validscope name="Scope Keywords"/>
		<validscope name="Parameter Block"/>
		<tokens>
			<token>*-*</token>
			<token>*!*</token>
			<token>&amp;&amp;</token>
			<token rule="AsterickComment">*</token>
		</tokens>
	</tokenset>
	<tokenset name="Parameter Block" id="parameterblocks" type="scope" hidden="yes" inheritfrom="Text">\
		<validscope name=""/>
		<validscope name="Scope Keywords"/>
		<validscope name="Parameter Block"/>
		<tokens>
			<token action="ParameterInfo">(</token>
			<token>[</token>
		</tokens>
		<tokens2>
			<token>)</token>
			<token>]</token>
		</tokens2>
	</tokenset>
	<tokenset name="Argument Separators" id="argseparators" hidden="yes" inheritfrom="Operators">
		<validscope name=""/>
		<validscope name="Parameter Block"/>
		<tokens>
			<token action="CommitMember">,</token>
		</tokens>
	</tokenset>
	<tokenset name="Hyperlinks" id="hyperlinks" forecolor="blue" fontstyle="underline">
		<validscope name="Strings"/>
		<validscope name="Line Comments"/>
		<tokens regexp="yes">
			<token>file://((\w:)?\w*)([/\\][\w\s\.]+)+([/\\][\w\.]*)+</token>
			<token>https?://([\.~:?#=\w]+\w+)(/[\.~:?#=\w]+\w)*</token>
			<token>(ftp|news|telnet|gopher)://[\.~:?#=\w]*\w(\.[\.~:?#=\w]*\w)+</token>
			<token>mailto:[\w-]+(@[\w-]+(\.?[\w-])*)?</token>
		</tokens>
	</tokenset>
	<tokenset name="Strings" id="strings" type="scope" normalizecase="no" singlelinescope="yes" forecolor="purple">
		<validscope name=""/>
		<validscope name="Scope Keywords"/>
		<validscope name="Parameter Block"/>
		<tokens>
			<token>'</token>
			<token>"</token>
		</tokens>
		<tokens2>
			<token>'</token>
			<token>"</token>
		</tokens2>
	</tokenset>
	<tokenset name="Data Types" id="valuenames" normalizecase="no" forecolor="blue">
		<validscope name=""/>
		<validscope name="Scope Keywords"/>
		<validscope name="Parameter Block"/>
		<tokens rule="LocalRule">
			<token>BOOLEAN</token>
			<token>BYTE</token>
			<token>CHARACTER</token>
			<token>CHECKBOX</token>
			<token>COLLECTION</token>
			<token>COLUMN</token>
			<token>COMBOBOX</token>
			<token>COMMANDBUTTON</token>
			<token>COMMANDGROUP</token>
			<token>CONTAINER</token>
			<token>CONTROL</token>
			<token>CURRENCY</token>
			<token>CURSOR</token>
			<token>CURSORADAPTER</token>
			<token>CUSTOM</token>
			<token>DATE</token>
			<token>DATETIME</token>
			<token>DECIMAL</token>
			<token>DOUBLE</token>
			<token>EDITBOX</token>
			<token>EXCEPTION</token>
			<token>FORM</token>
			<token>FORMSET</token>
			<token>GRID</token>
			<token>HEADER</token>
			<token>HYPERLINK</token>
			<token>IMAGE</token>
			<token>INTEGER</token>
			<token>LABEL</token>
			<token>LINE</token>
			<token>LISTBOX</token>
			<token>LOGICAL</token>
			<token>LONG</token>
			<token>NUMBER</token>
			<token>OBJECT</token>
			<token>OPTIONBUTTON</token>
			<token>OPTIONGROUP</token>
			<token>PAGE</token>
			<token>PAGEFRAME</token>
			<token>PROJECTHOOK</token>
			<token>RELATION</token>
			<token>REPORTLISTENER</token>
			<token>SEPARATOR</token>
			<token>SESSION</token>
			<token>SHAPE</token>
			<token>SHORT</token>
			<token>SINGLE</token>
			<token>SPINNER</token>
			<token>STRING</token>
			<token>TEXTBOX</token>
			<token>TIMER</token>
			<token>TOOLBAR</token>
			<token>VARIANT</token>
			<token>VISUALFOXPRO</token>
			<token>VOID</token>
			<token>XML WEB SERVICE</token>
			<token>XMLADAPTER</token>
			<token>XMLFIELD</token>
			<token>XMLTABLE</token>
		</tokens>
	</tokenset>
	<tokenset name="Attribute Names" id="tagattributenames" normalizecase="no" forecolor="blue">
		<validscope name=""/>
		<validscope name="Scope Keywords"/>
		<validscope name="Parameter Block"/>
		<tokens rule="AttributeRule">
			<token>ACCELERATE</token>
			<token>ACTIVATE</token>
			<token>ACTIVATECELL</token>
			<token>ACTIVECOLUMN</token>
			<token>ACTIVECONTROL</token>
			<token>ACTIVEFORM</token>
			<token>ACTIVEOBJECTID</token>
			<token>ACTIVEPAGE</token>
			<token>ACTIVEPROJECT</token>
			<token>ACTIVEROW</token>
			<token>ADD</token>
			<token>ADDCOLUMN</token>
			<token>ADDITEM</token>
			<token>ADDLINEFEEDS</token>
			<token>ADDLISTITEM</token>
			<token>ADDOBJECT</token>
			<token>ADDPROPERTY</token>
			<token>ADDTABLESCHEMA</token>
			<token>ADDTOSCC</token>
			<token>ADJUSTOBJECTSIZE</token>
			<token>ADOCODEPAGE</token>
			<token>AFTERBAND</token>
			<token>AFTERBUILD</token>
			<token>AFTERCLOSETABLES</token>
			<token>AFTERCURSORATTACH</token>
			<token>AFTERCURSORCLOSE</token>
			<token>AFTERCURSORDETACH</token>
			<token>AFTERCURSORFILL</token>
			<token>AFTERCURSORREFRESH</token>
			<token>AFTERCURSORUPDATE</token>
			<token>AFTERDELETE</token>
			<token>AFTERDOCK</token>
			<token>AFTERINSERT</token>
			<token>AFTERRECORDREFRESH</token>
			<token>AFTERREPORT</token>
			<token>AFTERROWCOLCHANGE</token>
			<token>AFTERUPDATE</token>
			<token>ALIAS</token>
			<token>ALIGN</token>
			<token>ALIGNMENT</token>
			<token>ALLOWADDNEW</token>
			<token>ALLOWAUTOCOLUMNFIT</token>
			<token>ALLOWCELLSELECTION</token>
			<token>ALLOWDELETE</token>
			<token>ALLOWHEADERSIZING</token>
			<token>ALLOWINSERT</token>
			<token>ALLOWMODALMESSAGES</token>
			<token>ALLOWOUTPUT</token>
			<token>ALLOWRESIZE</token>
			<token>ALLOWROWSIZING</token>
			<token>ALLOWSIMULTANEOUSFETCH</token>
			<token>ALLOWTABS</token>
			<token>ALLOWUPDATE</token>
			<token>ALWAYSONBOTTOM</token>
			<token>ALWAYSONTOP</token>
			<token>ANCHOR</token>
			<token>APPLICATION</token>
			<token>APPLYDIFFGRAM</token>
			<token>ATGETCOLORS</token>
			<token>ATLISTCOLORS</token>
			<token>ATTACH</token>
			<token>AUTOACTIVATE</token>
			<token>AUTOCENTER</token>
			<token>AUTOCLOSETABLES</token>
			<token>AUTOCOMPLETE</token>
			<token>AUTOCOMPSOURCE</token>
			<token>AUTOCOMPTABLE</token>
			<token>AUTOFIT</token>
			<token>AUTOHIDESCROLLBAR</token>
			<token>AUTOINCREMENT</token>
			<token>AUTOOPEN</token>
			<token>AUTOOPENTABLES</token>
			<token>AUTORELEASE</token>
			<token>AUTOSIZE</token>
			<token>AUTOVERBMENU</token>
			<token>AUTOYIELD</token>
			<token>AVAILNUM</token>
			<token>BACKCOLOR</token>
			<token>BACKSTYLE</token>
			<token>BASECLASS</token>
			<token>BATCHUPDATECOUNT</token>
			<token>BEFOREBAND</token>
			<token>BEFOREBUILD</token>
			<token>BEFORECURSORATTACH</token>
			<token>BEFORECURSORCLOSE</token>
			<token>BEFORECURSORDETACH</token>
			<token>BEFORECURSORFILL</token>
			<token>BEFORECURSORREFRESH</token>
			<token>BEFORECURSORUPDATE</token>
			<token>BEFOREDELETE</token>
			<token>BEFOREDOCK</token>
			<token>BEFOREINSERT</token>
			<token>BEFOREOPENTABLES</token>
			<token>BEFORERECORDREFRESH</token>
			<token>BEFOREREPORT</token>
			<token>BEFOREROWCOLCHANGE</token>
			<token>BEFOREUPDATE</token>
			<token>BINDCONTROLS</token>
			<token>BORDERCOLOR</token>
			<token>BORDERSTYLE</token>
			<token>BORDERWIDTH</token>
			<token>BOUND</token>
			<token>BOUNDCOLUMN</token>
			<token>BOUNDTO</token>
			<token>BOX</token>
			<token>BREAKONERROR</token>
			<token>BROWSEALIGNMENT</token>
			<token>BROWSECELLMARG</token>
			<token>BROWSEDESTWIDTH</token>
			<token>BUFFERMODE</token>
			<token>BUFFERMODEOVERRIDE</token>
			<token>BUILDDATETIME</token>
			<token>BUTTONCOUNT</token>
			<token>BUTTONINDEX</token>
			<token>BUTTONS</token>
			<token>CANACCELERATE</token>
			<token>CANCEL</token>
			<token>CANCELREPORT</token>
			<token>CANGETFOCUS</token>
			<token>CANLOSEFOCUS</token>
			<token>CAPTION</token>
			<token>CENTERED</token>
			<token>CENTURY</token>
			<token>CHANGESTOCURSOR</token>
			<token>CHECKIN</token>
			<token>CHECKOUT</token>
			<token>CHILDALIAS</token>
			<token>CHILDORDER</token>
			<token>CHILDTABLE</token>
			<token>CIRCLE</token>
			<token>CLASS</token>
			<token>CLASSLIBRARY</token>
			<token>CLEAR</token>
			<token>CLEARDATA</token>
			<token>CLEARSTATUS</token>
			<token>CLICK</token>
			<token>CLIPCONTROLS</token>
			<token>CLIPRECT</token>
			<token>CLONEOBJECT</token>
			<token>CLOSABLE</token>
			<token>CLOSEEDITOR</token>
			<token>CLOSETABLES</token>
			<token>CLS</token>
			<token>CLSID</token>
			<token>CODEPAGE</token>
			<token>COLORSCHEME</token>
			<token>COLORSOURCE</token>
			<token>COLUMNCOUNT</token>
			<token>COLUMNHEADERS</token>
			<token>COLUMNLINES</token>
			<token>COLUMNORDER</token>
			<token>COLUMNS</token>
			<token>COLUMNWIDTHS</token>
			<token>COMMANDCLAUSES</token>
			<token>COMMANDTARGETEXEC</token>
			<token>COMMANDTARGETQUERY</token>
			<token>COMMANDTARGETQUERYSTAS</token>
			<token>COMMENT</token>
			<token>COMPAREMEMO</token>
			<token>CONFLICTCHECKCMD</token>
			<token>CONFLICTCHECKTYPE</token>
			<token>CONNECTSTRING</token>
			<token>CONTAINERRELEASE</token>
			<token>CONTAINERRELEASETYPE</token>
			<token>CONTINUOUSSCROLL</token>
			<token>CONTROLBOX</token>
			<token>CONTROLCOUNT</token>
			<token>CONTROLINDEX</token>
			<token>CONTROLS</token>
			<token>CONTROLSOURCE</token>
			<token>CONVERSIONFUNC</token>
			<token>COUNT</token>
			<token>CURRENTCONTROL</token>
			<token>CURRENTDATASESSION</token>
			<token>CURRENTPASS</token>
			<token>CURRENTX</token>
			<token>CURRENTY</token>
			<token>CURSORATTACH</token>
			<token>CURSORDETACH</token>
			<token>CURSORFILL</token>
			<token>CURSORREFRESH</token>
			<token>CURSORSCHEMA</token>
			<token>CURSORSOURCE</token>
			<token>CURSORSTATUS</token>
			<token>CURVATURE</token>
			<token>DATABASE</token>
			<token>DATASESSION</token>
			<token>DATASESSIONID</token>
			<token>DATASOURCE</token>
			<token>DATASOURCEOBJ</token>
			<token>DATASOURCETYPE</token>
			<token>DATATOCLIP</token>
			<token>DATATYPE</token>
			<token>DATEFORMAT</token>
			<token>DATEMARK</token>
			<token>DBLCLICK</token>
			<token>DEACTIVATE</token>
			<token>DEBUG</token>
			<token>DECLAREXMLPREFIX</token>
			<token>DECLASS</token>
			<token>DECLASSLIBRARY</token>
			<token>DEFAULT</token>
			<token>DEFAULTFILEPATH</token>
			<token>DEFBUTTON</token>
			<token>DEFBUTTONORIG</token>
			<token>DEFHEIGHT</token>
			<token>DEFINEWINDOWS</token>
			<token>DEFLEFT</token>
			<token>DEFOLELCID</token>
			<token>DEFTOP</token>
			<token>DEFWIDTH</token>
			<token>DELAYEDMEMOFETCH</token>
			<token>DELETE</token>
			<token>DELETECMD</token>
			<token>DELETECMDDATASOURCE</token>
			<token>DELETECMDDATASOURCETYPE</token>
			<token>DELETECOLUMN</token>
			<token>DELETED</token>
			<token>DELETEMARK</token>
			<token>DESCRIPTION</token>
			<token>DESKTOP</token>
			<token>DESTROY</token>
			<token>DETAILS</token>
			<token>DIRTY</token>
			<token>DISABLEDBACKCOLOR</token>
			<token>DISABLEDBYEOF</token>
			<token>DISABLEDFORECOLOR</token>
			<token>DISABLEDITEMBACKCOLOR</token>
			<token>DISABLEDITEMFORECOLOR</token>
			<token>DISABLEDPICTURE</token>
			<token>DISABLEENCODE</token>
			<token>DISPLAYCOUNT</token>
			<token>DISPLAYORIENTATION</token>
			<token>DISPLAYVALUE</token>
			<token>DISPPAGEHEIGHT</token>
			<token>DISPPAGEWIDTH</token>
			<token>DOCK</token>
			<token>DOCKABLE</token>
			<token>DOCKED</token>
			<token>DOCKPOSITION</token>
			<token>DOCMD</token>
			<token>DOCREATE</token>
			<token>DOCUMENTFILE</token>
			<token>DOMESSAGE</token>
			<token>DOSCROLL</token>
			<token>DOSTATUS</token>
			<token>DOVERB</token>
			<token>DOWNCLICK</token>
			<token>DOWNPICTURE</token>
			<token>DRAG</token>
			<token>DRAGDROP</token>
			<token>DRAGICON</token>
			<token>DRAGMODE</token>
			<token>DRAGOVER</token>
			<token>DRAGSTATE</token>
			<token>DRAW</token>
			<token>DRAWMODE</token>
			<token>DRAWSTYLE</token>
			<token>DRAWWIDTH</token>
			<token>DROPDOWN</token>
			<token>DYNAMICALIGNMENT</token>
			<token>DYNAMICBACKCOLOR</token>
			<token>DYNAMICCURRENTCONTROL</token>
			<token>DYNAMICFONTBOLD</token>
			<token>DYNAMICFONTITALIC</token>
			<token>DYNAMICFONTNAME</token>
			<token>DYNAMICFONTOUTLINE</token>
			<token>DYNAMICFONTSHADOW</token>
			<token>DYNAMICFONTSIZE</token>
			<token>DYNAMICFONTSTRIKETHRU</token>
			<token>DYNAMICFONTUNDERLINE</token>
			<token>DYNAMICFORECOLOR</token>
			<token>DYNAMICINPUTMASK</token>
			<token>DYNAMICLINEHEIGHT</token>
			<token>EDITFLAGS</token>
			<token>EDITOROPTIONS</token>
			<token>ENABLED</token>
			<token>ENABLEDBYREADLOCK</token>
			<token>ENABLEHYPERLINKS</token>
			<token>ENCRYPTED</token>
			<token>ENTERFOCUS</token>
			<token>ENVLEVEL</token>
			<token>ERASEPAGE</token>
			<token>ERROR</token>
			<token>ERRORMESSAGE</token>
			<token>ERRORNO</token>
			<token>EVALUATECONTENTS</token>
			<token>EXCLUSIVE</token>
			<token>EXITFOCUS</token>
			<token>FETCHASNEEDED</token>
			<token>FETCHMEMO</token>
			<token>FETCHMEMOCMDLIST</token>
			<token>FETCHMEMODATASOURCE</token>
			<token>FETCHMEMODATASOURCETYPE</token>
			<token>FETCHSIZE</token>
			<token>FILECLASS</token>
			<token>FILECLASSLIBRARY</token>
			<token>FILES</token>
			<token>FILLCOLOR</token>
			<token>FILLSTYLE</token>
			<token>FILTER</token>
			<token>FIRSTELEMENT</token>
			<token>FIRSTNESTEDTABLE</token>
			<token>FLAGS</token>
			<token>FONTBOLD</token>
			<token>FONTCHARSET</token>
			<token>FONTCONDENSE</token>
			<token>FONTEXTEND</token>
			<token>FONTITALIC</token>
			<token>FONTNAME</token>
			<token>FONTOUTLINE</token>
			<token>FONTSHADOW</token>
			<token>FONTSIZE</token>
			<token>FONTSTRIKETHRU</token>
			<token>FONTUNDERLINE</token>
			<token>FORCECLOSETAG</token>
			<token>FORCEFOCUS</token>
			<token>FORECOLOR</token>
			<token>FORMAT</token>
			<token>FORMATCHANGE</token>
			<token>FORMATTEDOUTPUT</token>
			<token>FORMCOUNT</token>
			<token>FORMINDEX</token>
			<token>FORMPAGEINDEX</token>
			<token>FORMS</token>
			<token>FOXFONT</token>
			<token>FRACTIONDIGITS</token>
			<token>FRXDATASESSION</token>
			<token>FULLNAME</token>
			<token>GDIPLUSGRAPHICS</token>
			<token>GETDATA</token>
			<token>GETDOCKSTATE</token>
			<token>GETFORMAT</token>
			<token>GETKEY</token>
			<token>GETLATESTVERSION</token>
			<token>GETPAGEHEIGHT</token>
			<token>GETPAGEWIDTH</token>
			<token>GOBACK</token>
			<token>GOFIRST</token>
			<token>GOFORWARD</token>
			<token>GOLAST</token>
			<token>GOTFOCUS</token>
			<token>GRIDHITTEST</token>
			<token>GRIDLINECOLOR</token>
			<token>GRIDLINES</token>
			<token>GRIDLINEWIDTH</token>
			<token>HALFHEIGHTCAPTION</token>
			<token>HASCLIP</token>
			<token>HEADERCLASS</token>
			<token>HEADERCLASSLIBRARY</token>
			<token>HEADERGAP</token>
			<token>HEADERHEIGHT</token>
			<token>HEIGHT</token>
			<token>HELPCONTEXTID</token>
			<token>HIDE</token>
			<token>HIDEDOC</token>
			<token>HIDESELECTION</token>
			<token>HIGHLIGHT</token>
			<token>HIGHLIGHTBACKCOLOR</token>
			<token>HIGHLIGHTFORECOLOR</token>
			<token>HIGHLIGHTROW</token>
			<token>HIGHLIGHTROWLINEWIDTH</token>
			<token>HIGHLIGHTSTYLE</token>
			<token>HOMEDIR</token>
			<token>HOSTNAME</token>
			<token>HOTKEY</token>
			<token>HOURS</token>
			<token>HPROJ</token>
			<token>HSCROLLSMALLCHANGE</token>
			<token>HWND</token>
			<token>ICON</token>
			<token>IGNOREINSERT</token>
			<token>IMEMODE</token>
			<token>INCLUDEPAGEINOUTPUT</token>
			<token>INCREMENT</token>
			<token>INCREMENTALSEARCH</token>
			<token>INDEXTOITEMID</token>
			<token>INIT</token>
			<token>INITIALSELECTEDALIAS</token>
			<token>INPUTMASK</token>
			<token>INRESIZE</token>
			<token>INSERTCMD</token>
			<token>INSERTCMDDATASOURCE</token>
			<token>INSERTCMDDATASOURCETYPE</token>
			<token>INSERTCMDREFRESHCMD</token>
			<token>INSERTCMDREFRESHFIELDLIST</token>
			<token>INSERTCMDREFRESHKEYFIELDLIST</token>
			<token>INSTANCING</token>
			<token>INTEGRALHEIGHT</token>
			<token>INTERACTIVECHANGE</token>
			<token>INTERVAL</token>
			<token>ISATTRIBUTE</token>
			<token>ISBASE64</token>
			<token>ISBINARY</token>
			<token>ISDIFFGRAM</token>
			<token>ISLOADED</token>
			<token>ISNULL</token>
			<token>ITEM</token>
			<token>ITEMBACKCOLOR</token>
			<token>ITEMDATA</token>
			<token>ITEMFORECOLOR</token>
			<token>ITEMIDDATA</token>
			<token>ITEMIDTOINDEX</token>
			<token>ITEMTIPS</token>
			<token>IXMLDOMELEMENT</token>
			<token>JUSTREADLOCKED</token>
			<token>KEYBOARDHIGHVALUE</token>
			<token>KEYBOARDLOWVALUE</token>
			<token>KEYFIELD</token>
			<token>KEYFIELDLIST</token>
			<token>KEYPRESS</token>
			<token>KEYPREVIEW</token>
			<token>KEYSORT</token>
			<token>LANGUAGEOPTIONS</token>
			<token>LASTMODIFIED</token>
			<token>LEFT</token>
			<token>LEFTCOLUMN</token>
			<token>LINE</token>
			<token>LINECONTENTS</token>
			<token>LINENO</token>
			<token>LINESLANT</token>
			<token>LINKMASTER</token>
			<token>LIST</token>
			<token>LISTCOUNT</token>
			<token>LISTENERTYPE</token>
			<token>LISTINDEX</token>
			<token>LISTITEM</token>
			<token>LISTITEMID</token>
			<token>LOAD</token>
			<token>LOADREPORT</token>
			<token>LOADXML</token>
			<token>LOCKCOLUMNS</token>
			<token>LOCKCOLUMNSLEFT</token>
			<token>LOCKDATASOURCE</token>
			<token>LOCKSCREEN</token>
			<token>LOSTFOCUS</token>
			<token>MACDESKTOP</token>
			<token>MAINCLASS</token>
			<token>MAINFILE</token>
			<token>MAPBINARY</token>
			<token>MAPN19_4TOCURRENCY</token>
			<token>MAPVARCHAR</token>
			<token>MARGIN</token>
			<token>MAXBUTTON</token>
			<token>MAXHEIGHT</token>
			<token>MAXLEFT</token>
			<token>MAXLENGTH</token>
			<token>MAXRECORDS</token>
			<token>MAXTOP</token>
			<token>MAXWIDTH</token>
			<token>MDIFORM</token>
			<token>MEMBERCLASS</token>
			<token>MEMBERCLASSLIBRARY</token>
			<token>MEMOWINDOW</token>
			<token>MESSAGE</token>
			<token>MIDDLECLICK</token>
			<token>MINBUTTON</token>
			<token>MINHEIGHT</token>
			<token>MINWIDTH</token>
			<token>MODIFY</token>
			<token>MOUSEDOWN</token>
			<token>MOUSEENTER</token>
			<token>MOUSEICON</token>
			<token>MOUSELEAVE</token>
			<token>MOUSEMOVE</token>
			<token>MOUSEPOINTER</token>
			<token>MOUSEUP</token>
			<token>MOUSEWHEEL</token>
			<token>MOVABLE</token>
			<token>MOVE</token>
			<token>MOVED</token>
			<token>MOVEITEM</token>
			<token>MOVERBARS</token>
			<token>MULTISELECT</token>
			<token>NAME</token>
			<token>NAPTIME</token>
			<token>NAVIGATETO</token>
			<token>NEST</token>
			<token>NESTEDINTO</token>
			<token>NEWINDEX</token>
			<token>NEWITEMID</token>
			<token>NEWOBJECT</token>
			<token>NEXTSIBLINGTABLE</token>
			<token>NOCPTRANS</token>
			<token>NODATA</token>
			<token>NODATAONLOAD</token>
			<token>NODEFINE</token>
			<token>NOTIFYCONTAINER</token>
			<token>NULLDISPLAY</token>
			<token>NUMBEROFELEMENTS</token>
			<token>OBJECTS</token>
			<token>OLECLASS</token>
			<token>OLECLASSID</token>
			<token>OLECOMPLETEDRAG</token>
			<token>OLECONTROLCONTAINER</token>
			<token>OLEDRAG</token>
			<token>OLEDRAGDROP</token>
			<token>OLEDRAGMODE</token>
			<token>OLEDRAGOVER</token>
			<token>OLEDRAGPICTURE</token>
			<token>OLEDROPEFFECTS</token>
			<token>OLEDROPHASDATA</token>
			<token>OLEDROPMODE</token>
			<token>OLEDROPTEXTINSERTION</token>
			<token>OLEGIVEFEEDBACK</token>
			<token>OLEIDISPATCHOUTGOING</token>
			<token>OLEIDISPINVALUE</token>
			<token>OLEIDISPOUTVALUE</token>
			<token>OLELCID</token>
			<token>OLEREQUESTPENDINGTIMOU</token>
			<token>OLESERVERBUSYRAISEERRO</token>
			<token>OLESERVERBUSYTIMOUT</token>
			<token>OLESETDATA</token>
			<token>OLESTARTDRAG</token>
			<token>OLETYPEALLOWED</token>
			<token>ONETOMANY</token>
			<token>ONMOVEITEM</token>
			<token>ONPREVIEWCLOSE</token>
			<token>ONRESIZE</token>
			<token>OPENEDITOR</token>
			<token>OPENTABLES</token>
			<token>OPENVIEWS</token>
			<token>OPENWINDOW</token>
			<token>OPTIMIZE</token>
			<token>ORDER</token>
			<token>ORDERDIRECTION</token>
			<token>OUTPUTPAGE</token>
			<token>OUTPUTPAGECOUNT</token>
			<token>OUTPUTTYPE</token>
			<token>PAGECOUNT</token>
			<token>PAGEHEIGHT</token>
			<token>PAGENO</token>
			<token>PAGEORDER</token>
			<token>PAGES</token>
			<token>PAGETOTAL</token>
			<token>PAGEWIDTH</token>
			<token>PAINT</token>
			<token>PANEL</token>
			<token>PANELLINK</token>
			<token>PARENT</token>
			<token>PARENTALIAS</token>
			<token>PARENTCLASS</token>
			<token>PARENTTABLE</token>
			<token>PARTITION</token>
			<token>PASSWORDCHAR</token>
			<token>PICTURE</token>
			<token>PICTUREMARGIN</token>
			<token>PICTUREPOSITION</token>
			<token>PICTURESELECTIONDISPLAY</token>
			<token>PICTURESPACING</token>
			<token>PICTUREVAL</token>
			<token>POINT</token>
			<token>POLYPOINTS</token>
			<token>PREPARED</token>
			<token>PRESERVEWHITESPACE</token>
			<token>PREVIEWCONTAINER</token>
			<token>PRINT</token>
			<token>PRINTJOBNAME</token>
			<token>PROCESSID</token>
			<token>PROGID</token>
			<token>PROGRAMMATICCHANGE</token>
			<token>PROJECTHOOKCLASS</token>
			<token>PROJECTHOOKLIBRARY</token>
			<token>PROJECTS</token>
			<token>PSET</token>
			<token>QUERYADDFILE</token>
			<token>QUERYMODIFYFILE</token>
			<token>QUERYNEWFILE</token>
			<token>QUERYREMOVEFILE</token>
			<token>QUERYRUNFILE</token>
			<token>QUERYUNLOAD</token>
			<token>QUIETMODE</token>
			<token>RANGEHIGH</token>
			<token>RANGELOW</token>
			<token>READACTIVATE</token>
			<token>READCOLORS</token>
			<token>READCYCLE</token>
			<token>READDEACTIVATE</token>
			<token>READEXPRESSION</token>
			<token>READFILLER</token>
			<token>READLOCK</token>
			<token>READMETHOD</token>
			<token>READMOUSE</token>
			<token>READONLY</token>
			<token>READSAVE</token>
			<token>READSHOW</token>
			<token>READSIZE</token>
			<token>READTIMEOUT</token>
			<token>READVALID</token>
			<token>READWHEN</token>
			<token>RECORDMARK</token>
			<token>RECORDREFRESH</token>
			<token>RECORDSOURCE</token>
			<token>RECORDSOURCETYPE</token>
			<token>RECT</token>
			<token>REFRESH</token>
			<token>REFRESHALIAS</token>
			<token>REFRESHCMD</token>
			<token>REFRESHCMDDATASOURCE</token>
			<token>REFRESHCMDDATASOURCETYPE</token>
			<token>REFRESHIGNOREFIELDLIST</token>
			<token>REFRESHTIMESTAMP</token>
			<token>RELATIONALEXPR</token>
			<token>RELATIVECOLUMN</token>
			<token>RELATIVEROW</token>
			<token>RELEASE</token>
			<token>RELEASEERASE</token>
			<token>RELEASETYPE</token>
			<token>RELEASEWINDOWS</token>
			<token>RELEASEXML</token>
			<token>REMOVE</token>
			<token>REMOVEFROMSCC</token>
			<token>REMOVEITEM</token>
			<token>REMOVELISTITEM</token>
			<token>REMOVEOBJECT</token>
			<token>RENDER</token>
			<token>REQUERY</token>
			<token>REQUESTDATA</token>
			<token>RESERVED</token>
			<token>RESET</token>
			<token>RESETTODEFAULT</token>
			<token>RESIZABLE</token>
			<token>RESIZE</token>
			<token>RESPECTCURSORCP</token>
			<token>RESPECTNESTING</token>
			<token>RIGHTCLICK</token>
			<token>RIGHTTOLEFT</token>
			<token>ROTATEFLIP</token>
			<token>ROTATION</token>
			<token>ROWCOLCHANGE</token>
			<token>ROWHEIGHT</token>
			<token>ROWSOURCE</token>
			<token>ROWSOURCETYPE</token>
			<token>RUN</token>
			<token>SAVEAS</token>
			<token>SAVEASCLASS</token>
			<token>SCALEMODE</token>
			<token>SCCDESTROY</token>
			<token>SCCDESTROY</token>
			<token>SCCINIT</token>
			<token>SCCPROVIDER</token>
			<token>SCCSTATUS</token>
			<token>SCROLLBARS</token>
			<token>SCROLLED</token>
			<token>SDIFORM</token>
			<token>SECONDS</token>
			<token>SELECTCMD</token>
			<token>SELECTED</token>
			<token>SELECTEDBACKCOLOR</token>
			<token>SELECTEDFORECOLOR</token>
			<token>SELECTEDID</token>
			<token>SELECTEDITEMBACKCOLOR</token>
			<token>SELECTEDITEMFORECOLOR</token>
			<token>SELECTIONNAMESPACES</token>
			<token>SELECTONENTRY</token>
			<token>SELFEDIT</token>
			<token>SELLENGTH</token>
			<token>SELSTART</token>
			<token>SELTEXT</token>
			<token>SENDGDIPLUSIMAGE</token>
			<token>SENDUPDATES</token>
			<token>SERVERCLASS</token>
			<token>SERVERCLASSLIBRARY</token>
			<token>SERVERHELPFILE</token>
			<token>SERVERNAME</token>
			<token>SERVERPROJECT</token>
			<token>SETALL</token>
			<token>SETDATA</token>
			<token>SETFOCUS</token>
			<token>SETFORMAT</token>
			<token>SETMAIN</token>
			<token>SETVAR</token>
			<token>SETVIEWPORT</token>
			<token>SHOW</token>
			<token>SHOWDOC</token>
			<token>SHOWINTASKBAR</token>
			<token>SHOWTIPS</token>
			<token>SHOWWHATSTHIS</token>
			<token>SHOWWINDOW</token>
			<token>SIZABLE</token>
			<token>SIZE</token>
			<token>SIZEBOX</token>
			<token>SKIP</token>
			<token>SKIPFORM</token>
			<token>SOM</token>
			<token>SORTED</token>
			<token>SOURCETYPE</token>
			<token>SPARSE</token>
			<token>SPECIALEFFECT</token>
			<token>SPINNERHIGHVALUE</token>
			<token>SPINNERLOWVALUE</token>
			<token>SPLITBAR</token>
			<token>STACKLEVEL</token>
			<token>STARTMODE</token>
			<token>STATUSBARTEXT</token>
			<token>STRETCH</token>
			<token>STRICTDATEENTRY</token>
			<token>STYLE</token>
			<token>SUPPORTSLISTENERTYPE</token>
			<token>SYSTEMREFCOUNT</token>
			<token>TABHIT</token>
			<token>TABINDEX</token>
			<token>TABLES</token>
			<token>TABORIENTATION</token>
			<token>TABS</token>
			<token>TABSTOP</token>
			<token>TABSTRETCH</token>
			<token>TABSTYLE</token>
			<token>TAG</token>
			<token>TERMINATEREAD</token>
			<token>TEXTHEIGHT</token>
			<token>TEXTWIDTH</token>
			<token>THEMES</token>
			<token>THREADID</token>
			<token>TIMER</token>
			<token>TIMESTAMPFIELDLIST</token>
			<token>TITLEBAR</token>
			<token>TOCURSOR</token>
			<token>TOOLTIPTEXT</token>
			<token>TOP</token>
			<token>TOPINDEX</token>
			<token>TOPITEMID</token>
			<token>TOXML</token>
			<token>TWOPASSPROCESS</token>
			<token>TYPELIBCLSID</token>
			<token>TYPELIBDESC</token>
			<token>TYPELIBNAME</token>
			<token>UIENABLE</token>
			<token>UNDOCHECKOUT</token>
			<token>UNDOCK</token>
			<token>UNICODE</token>
			<token>UNLOAD</token>
			<token>UNLOADREPORT</token>
			<token>UNLOCKDATASOURCE</token>
			<token>UNNEST</token>
			<token>UPCLICK</token>
			<token>UPDATABLEFIELDLIST</token>
			<token>UPDATECMD</token>
			<token>UPDATECMDDATASOURCE</token>
			<token>UPDATECMDDATASOURCETYPE</token>
			<token>UPDATECMDREFRESHCMD</token>
			<token>UPDATECMDREFRESHFIELDLIST</token>
			<token>UPDATECMDREFRESHKEYFIELDLIST</token>
			<token>UPDATEGRAM</token>
			<token>UPDATEGRAMSCHEMALOCATION</token>
			<token>UPDATENAMELIST</token>
			<token>UPDATESTATUS</token>
			<token>UPDATETYPE</token>
			<token>USECODEPAGE</token>
			<token>USECURSORSCHEMA</token>
			<token>USEDEDATASOURCE</token>
			<token>USEMEMOSIZE</token>
			<token>USERVALUE</token>
			<token>USETRANSACTIONS</token>
			<token>UTF8ENCODED</token>
			<token>VALID</token>
			<token>VALUE</token>
			<token>VALUEDIRTY</token>
			<token>VERSIONCOMMENTS</token>
			<token>VERSIONCOMPANY</token>
			<token>VERSIONCOPYRIGHT</token>
			<token>VERSIONDESCRIPTION</token>
			<token>VERSIONLANGUAGE</token>
			<token>VERSIONNUMBER</token>
			<token>VERSIONPRODUCT</token>
			<token>VERSIONTRADEMARKS</token>
			<token>VIEW</token>
			<token>VIEWPORTHEIGHT</token>
			<token>VIEWPORTLEFT</token>
			<token>VIEWPORTTOP</token>
			<token>VIEWPORTWIDTH</token>
			<token>VISIBLE</token>
			<token>VISUALEFFECT</token>
			<token>VSCROLLSMALLCHANGE</token>
			<token>WASACTIVE</token>
			<token>WASOPEN</token>
			<token>WHATSTHISBUTTON</token>
			<token>WHATSTHISHELP</token>
			<token>WHATSTHISHELPID</token>
			<token>WHATSTHISMODE</token>
			<token>WHEN</token>
			<token>WHERETYPE</token>
			<token>WIDTH</token>
			<token>WINDOWLIST</token>
			<token>WINDOWNTILIST</token>
			<token>WINDOWSTATE</token>
			<token>WINDOWTYPE</token>
			<token>WORDWRAP</token>
			<token>WRAPCHARINCDATA</token>
			<token>WRAPINCDATA</token>
			<token>WRAPMEMOINCDATA</token>
			<token>WRITEEXPRESSION</token>
			<token>WRITEMETHOD</token>
			<token>XMLADAPTER</token>
			<token>XMLCONSTRAINTS</token>
			<token>XMLNAME</token>
			<token>XMLNAMEISXPATH</token>
			<token>XMLNAMESPACE</token>
			<token>XMLPREFIX</token>
			<token>XMLSCHEMALOCATION</token>
			<token>XMLTABLE</token>
			<token>XMLTYPE</token>
			<token>XSDFRACTIONDIGITS</token>
			<token>XSDMAXLENGTH</token>
			<token>XSDTOTALDIGITS</token>
			<token>XSDTYPE</token>
			<token>ZOOMBOX</token>
			<token>ZORDER</token>
			<token>ZORDERSET</token>
		</tokens>
	</tokenset>
	<tokenset name="VFP System Keywords" id="attributekeywordblocks" forecolor="blue" normalizecase="no">
		<validscope name=""/>
		<validscope name="Scope Keywords"/>
		<validscope name="Parameter Block"/>
		<tokens>
			<token>_ALIGNMENT</token>
			<token>_ASCIICOLS</token>
			<token>_ASCIIROWS</token>
			<token>_ASSIST</token>
			<token>_BEAUTIFY</token>
			<token>_BOX</token>
			<token>_BROWSER</token>
			<token>_BUILDER</token>
			<token>_CALCMEM</token>
			<token>_CALCVALUE</token>
			<token>_CLIPTEXT</token>
			<token>_CODESENSE</token>
			<token>_CONVERTER</token>
			<token>_COVERAGE</token>
			<token>_CUROBJ</token>
			<token>_DBLCLICK</token>
			<token>_DIARYDATE</token>
			<token>_DOS</token>
			<token>_FOXCODE</token>
			<token>_FOXDOC</token>
			<token>_FOXGRAPH</token>
			<token>_FOXREF</token>
			<token>_FOXTASK</token>
			<token>_GALLERY</token>
			<token>_GENGRAPH</token>
			<token>_GENHTML</token>
			<token>_GENMENU</token>
			<token>_GENPD</token>
			<token>_GENSCRN</token>
			<token>_GENXTAB</token>
			<token>_GETEXPR</token>
			<token>_INCLUDE</token>
			<token>_INCSEEK</token>
			<token>_INDENT</token>
			<token>_LMARGIN</token>
			<token>_MAC</token>
			<token>_MBROWSE</token>
			<token>_MDATA</token>
			<token>_MDIARY</token>
			<token>_MEDIT</token>
			<token>_MENUDESIGNER</token>
			<token>_MFILER</token>
			<token>_MFIRST</token>
			<token>_MLABEL</token>
			<token>_MLAST</token>
			<token>_MLINE</token>
			<token>_MMACRO</token>
			<token>_MMBLDR</token>
			<token>_MPROJ</token>
			<token>_MRECORD</token>
			<token>_MREPORT</token>
			<token>_MRQBE</token>
			<token>_MSCREEN</token>
			<token>_MSYSMENU</token>
			<token>_MSYSTEM</token>
			<token>_MTABLE</token>
			<token>_MWINDOW</token>
			<token>_MWIZARDS</token>
			<token>_NETWARE</token>
			<token>_OBJECTBROWSER</token>
			<token>_ORACLE</token>
			<token>_PADVANCE</token>
			<token>_PAGENO</token>
			<token>_PAGETOTAL</token>
			<token>_PBPAGE</token>
			<token>_PCOLNO</token>
			<token>_PCOPIES</token>
			<token>_PDPARMS</token>
			<token>_PDRIVER</token>
			<token>_PDSETUP</token>
			<token>_PECODE</token>
			<token>_PEJECT</token>
			<token>_PEPAGE</token>
			<token>_PFORM</token>
			<token>_PLENGTH</token>
			<token>_PLINENO</token>
			<token>_PLOFFSET</token>
			<token>_PPITCH</token>
			<token>_PQUALITY</token>
			<token>_PRETEXT</token>
			<token>_PSCODE</token>
			<token>_PSPACING</token>
			<token>_PWAIT</token>
			<token>_REPORTBUILDER</token>
			<token>_REPORTOUTPUT</token>
			<token>_REPORTPREVIEW</token>
			<token>_RMARGIN</token>
			<token>_RUNACTIVEDOC</token>
			<token>_SAMPLES</token>
			<token>_SCCTEXT</token>
			<token>_SCREEN</token>
			<token>_SHELL</token>
			<token>_SHELL</token>
			<token>_SPELLCHK</token>
			<token>_SQLSERVER</token>
			<token>_STARTUP</token>
			<token>_TABS</token>
			<token>_TALLY</token>
			<token>_TASKLIST</token>
			<token>_TASKPANE</token>
			<token>_TEXT</token>
			<token>_THROTTLE</token>
			<token>_TOOLBOX</token>
			<token>_TOOLTIPTIMEOUT</token>
			<token>_TRANSPORT</token>
			<token>_TRIGGERLEVEL</token>
			<token>_UNIX</token>
			<token>_VFP</token>
			<token>_VSBUILD</token>
			<token>_WEBDEVONLY</token>
			<token>_WEBMENU</token>
			<token>_WEBMSFTHOMEPAGE</token>
			<token>_WEBVFPHOMEPAGE</token>
			<token>_WEBVFPONLINESUPPORT</token>
			<token>_WINDOWS</token>
			<token>_WIZARD</token>
			<token>_WRAP</token>
			<token>THIS</token>
			<token>THISFORM</token>
			<token>THISFORMSET</token>
		</tokens>
	</tokenset>
	<tokenset name="Scope Keywords" id="scopekeywords" normalizecase="yes" type="scope" autoindent="yes" hidden="yes" forecolor="blue" chain="yes">
		<validscope name=""/>
		<validscope name="Scope Keywords"/>
		<tokens rule="ScopeBegKW">
			<token>IF</token>
			<token>IF</token>
			<token rule="ScopeMidKW">ELSE</token>
			<token>#IFDEF</token>
			<token>#IFDEF</token>
			<token>#IFNDEF</token>
			<token>#IF</token>
			<token>#IF</token>
			<token>#ELSE</token>
			<token>DO WHILE</token>
			<token>FUNCTION</token>
			<token>DEFINE CLASS</token>
			<token>PROCEDURE</token>
			<token>PROTECTED FUNCTION</token>
			<token>PROTECTED PROCEDURE</token>
			<token>PROTECTED PROC</token>
			<token>PRINTJOB</token>
			<token>DO CASE</token>
			<token>SCAN</token>
			<token>TEXT</token>
			<token>TRY</token>
			<token>TRY</token>
			<token>CATCH</token>
			<token>CATCH</token>
			<token>FINALLY</token>
			<token>FOR EACH</token>
			<token rule="ScopeBegSpKW">FOR</token>
			<token rule="ScopeBegSpKW">FOR</token>
			<token>WITH</token>
			<token>{</token>
			<token>BEGIN TRANSACTION</token>
		</tokens>
		<tokens2 rule="ScopeBegKW">
			<token rule="ScopeMidKW">ELSE</token>
			<token>ENDIF</token>
			<token>ENDIF</token>
			<token>#ELSE</token>
			<token>#ENDIF</token>
			<token>#ENDIF</token>
			<token>#ENDIF</token>
			<token>#ENDIF</token>
			<token>#ENDIF</token>
			<token>ENDDO</token>
			<token>ENDFUNC</token>
			<token>ENDDEFINE</token>
			<token>ENDPROC</token>
			<token>ENDFUNC</token>
			<token>ENDPROC</token>
			<token>ENDPROC</token>
			<token>ENDPRINTJOB</token>
			<token>ENDCASE</token>
			<token>ENDSCAN</token>
			<token>ENDTEXT</token>
			<token>ENDTRY</token>
			<token>CATCH</token>
			<token>FINALLY</token>
			<token>ENDTRY</token>
			<token>ENDTRY</token>
			<token>ENDFOR</token>
			<token>ENDFOR</token>
			<token>NEXT</token>
			<token>ENDWITH</token>
			<token>}</token>
			<token>END TRANSACTION</token>
		</tokens2>
	</tokenset>
	<tokenset name="Debug Start" id="unknown" normalizecase="no" fontstyle="bold" forecolor="red" backcolor="cyan">
		<validscope name=""/>
		<validscope name="Scope Keywords"/>
		<validscope name="Parameter Block"/>
		<tokens>
			<token>SET STEP ON</token>
		</tokens>
	</tokenset>
	<tokenset name="Keywords" id="keywords" forecolor="blue" normalizecase="yes">
		<validscope name=""/>
		<validscope name="Scope Keywords"/>
		<validscope name="Parameter Block"/>
		<tokens>
			<token>#DEFINE</token>
			<token>#INCLUDE</token>
			<token>#ITSEXPRESSION</token>
			<token>#READCLAUSES</token>
			<token>#REGION</token>
			<token>#SECTION</token>
			<token>#UNDEF</token>
			<token>#WNAME</token>
			<token>?</token>
			<token>??</token>
			<token>???</token>
			<token regexp="yes" action="ListMembers">ZLOC\s</token>
			<token regexp="yes" action="ListMembers">ZDEF\s</token>
			<token rule="CommandsKW">ACCEPT</token>
			<token rule="CommandsKW">ACCESS</token>
			<token rule="CommandsKW">ACTIVATE</token>
			<token rule="CommandsKW">ADD</token>
			<token rule="CommandsKW">ADDITIVE</token>
			<token rule="CommandsKW">ADDRELATIONTOENV</token>
			<token rule="CommandsKW">ADDTABLETOENV</token>
			<token rule="CommandsKW">AFTER</token>
			<token rule="CommandsKW">AGAIN</token>
			<token rule="CommandsKW">AINDENT</token>
			<token rule="CommandsKW">ALIGNRIGHT</token>
			<token rule="CommandsKW">ALL</token>
			<token rule="CommandsKW">ALT</token>
			<token rule="CommandsKW">ALTER</token>
			<token rule="CommandsKW">ALTERNATE</token>
			<token rule="CommandsKW">AMERICAN</token>
			<token rule="CommandsKW">ANSI</token>
			<token rule="CommandsKW">ANY</token>
			<token rule="CommandsKW">APLABOUT</token>
			<token rule="CommandsKW">APP</token>
			<token rule="CommandsKW">APPEND</token>
			<token rule="CommandsKW">ARRAY</token>
			<token rule="CommandsKW">AS</token>
			<token rule="CommandsKW">ASCENDING</token>
			<token rule="CommandsKW">ASCII</token>
			<token rule="CommandsKW">ASSERT</token>
			<token rule="CommandsKW">ASSERTS</token>
			<token rule="CommandsKW">ASSIST</token>
			<token rule="CommandsKW">ASYNCHRONOUS</token>
			<token rule="CommandsKW">ATTRIBUTES</token>
			<token rule="CommandsKW">AUTOFORM</token>
			<token rule="CommandsKW">AUTOINC</token>
			<token rule="CommandsKW">AUTOINCERROR</token>
			<token rule="CommandsKW">AUTOINCERROR</token>
			<token rule="CommandsKW">AUTOMATIC</token>
			<token rule="CommandsKW">AUTOREPORT</token>
			<token rule="CommandsKW">AUTOSAVE</token>
			<token rule="CommandsKW">AVERAGE</token>
			<token rule="CommandsKW">BEFORE</token>
			<token rule="CommandsKW">BEGIN</token>
			<token rule="CommandsKW">BELL</token>
			<token rule="CommandsKW">BELLSOUND</token>
			<token rule="CommandsKW">BITMAP</token>
			<token rule="CommandsKW">BLANK</token>
			<token rule="CommandsKW">BLINK</token>
			<token rule="CommandsKW">BLOB</token>
			<token rule="CommandsKW">BLOCKSIZE</token>
			<token rule="CommandsKW">BORDER</token>
			<token rule="CommandsKW">BOTTOM</token>
			<token rule="CommandsKW">BRITISH</token>
			<token rule="CommandsKW">BROWSE</token>
			<token rule="CommandsKW">BROWSEREFRESH</token>
			<token rule="CommandsKW">BRSTATUS</token>
			<token rule="CommandsKW">BUCKET</token>
			<token rule="CommandsKW">BUFFERING</token>
			<token rule="CommandsKW">BUFFERS</token>
			<token rule="CommandsKW">BUILD</token>
			<token rule="CommandsKW">BUILDERLOCK</token>
			<token rule="CommandsKW">BY</token>
			<token rule="CommandsKW">CALCULATE</token>
			<token rule="CommandsKW">CALL</token>
			<token rule="CommandsKW">CANCEL</token>
			<token rule="CommandsKW">CARRY</token>
			<token rule="CommandsKW">CASCADE</token>
			<token rule="CommandsKW">CASE</token>
			<token rule="CommandsKW">CATALOG</token>
			<token rule="CommandsKW">CD</token>
			<token rule="CommandsKW">CENTER</token>
			<token rule="CommandsKW">CENTRAL</token>
			<token rule="CommandsKW">CENTURY</token>
			<token rule="CommandsKW">CENTURY</token>
			<token rule="CommandsKW">CGA</token>
			<token rule="CommandsKW">CHAR</token>
			<token rule="CommandsKW">CHARACTER</token>
			<token rule="CommandsKW">CHDIR</token>
			<token rule="CommandsKW">CHECK</token>
			<token rule="CommandsKW">CLASS</token>
			<token rule="CommandsKW">CLASSLIB</token>
			<token rule="CommandsKW">CLEAR</token>
			<token rule="CommandsKW">CLOCK</token>
			<token rule="CommandsKW">CLOSE</token>
			<token rule="CommandsKW">CODEPAGE</token>
			<token rule="CommandsKW">COLLATE</token>
			<token rule="CommandsKW">COLOR</token>
			<token rule="CommandsKW">COLUMN</token>
			<token rule="CommandsKW">COM1</token>
			<token rule="CommandsKW">COM2</token>
			<token rule="CommandsKW">COMMAND</token>
			<token rule="CommandsKW">COMPACT</token>
			<token rule="CommandsKW">COMPATIBLE</token>
			<token rule="CommandsKW">COMPILE</token>
			<token rule="CommandsKW">COMPRESS</token>
			<token rule="CommandsKW">COMPUTE</token>
			<token rule="CommandsKW">CONCAT</token>
			<token rule="CommandsKW">CONFIRM</token>
			<token rule="CommandsKW">CONNECTBUSY</token>
			<token rule="CommandsKW">CONNECTHANDLE</token>
			<token rule="CommandsKW">CONNECTION</token>
			<token rule="CommandsKW">CONNECTNAME</token>
			<token rule="CommandsKW">CONNECTTIMEOUT</token>
			<token rule="CommandsKW">CONNSTRING</token>
			<token rule="CommandsKW">CONSOLE</token>
			<token rule="CommandsKW">CONTINUE</token>
			<token rule="CommandsKW">COPIES</token>
			<token rule="CommandsKW">COPY</token>
			<token rule="CommandsKW">COVERAGE</token>
			<token rule="CommandsKW">CPDIALOG</token>
			<token rule="CommandsKW">CREATE</token>
			<token rule="CommandsKW">CRSBUFFERING</token>
			<token rule="CommandsKW">CRSFETCHMEMO</token>
			<token rule="CommandsKW">CRSFETCHSIZE</token>
			<token rule="CommandsKW">CRSMAXROWS</token>
			<token rule="CommandsKW">CRSMETHODUSED</token>
			<token rule="CommandsKW">CRSNUMBATCH</token>
			<token rule="CommandsKW">CRSSHARECONNECTION</token>
			<token rule="CommandsKW">CRSUSEMEMOSIZ</token>
			<token rule="CommandsKW">CRSWHERECLAUSE</token>
			<token rule="CommandsKW">CSV</token>
			<token rule="CommandsKW">CURDATE</token>
			<token rule="CommandsKW">CURRENCY</token>
			<token rule="CommandsKW">CURRLEFT</token>
			<token rule="CommandsKW">CURRSYMBOL</token>
			<token rule="CommandsKW">CURSOR</token>
			<token rule="CommandsKW">CURTIME</token>
			<token rule="CommandsKW">CYCLE</token>
			<token rule="CommandsKW">DATA</token>
			<token rule="CommandsKW">DATABASE</token>
			<token rule="CommandsKW">DATABASES</token>
			<token rule="CommandsKW">DATASESSION</token>
			<token rule="CommandsKW">DATASOURCE</token>
			<token rule="CommandsKW">DB4</token>
			<token rule="CommandsKW">DBCEVENTS</token>
			<token rule="CommandsKW">DBMEMO3</token>
			<token rule="CommandsKW">DEACTIVATE</token>
			<token rule="CommandsKW">DEBUG</token>
			<token rule="CommandsKW">DEBUGOUT</token>
			<token rule="CommandsKW">DECIMALS</token>
			<token rule="CommandsKW">DECLARE</token>
			<token rule="CommandsKW">DEFAULTSOURCE</token>
			<token rule="CommandsKW">DEFAULTVALUE</token>
			<token rule="CommandsKW">DEFINE</token>
			<token rule="CommandsKW">DEGREES</token>
			<token rule="CommandsKW">DELE</token>
			<token rule="CommandsKW">DELETE</token>
			<token rule="CommandsKW">DELETETABLES</token>
			<token rule="CommandsKW">DELETETRIGGER</token>
			<token rule="CommandsKW">DELIMITED</token>
			<token rule="CommandsKW">DELIMITERS</token>
			<token rule="CommandsKW">DESCRIPTION</token>
			<token rule="CommandsKW">DESIGN</token>
			<token rule="CommandsKW">DEVELOPMENT</token>
			<token rule="CommandsKW">DEVICE</token>
			<token rule="CommandsKW">DIMENSION</token>
			<token rule="CommandsKW">DIR</token>
			<token rule="CommandsKW">DISABLED</token>
			<token rule="CommandsKW">DISPLAY</token>
			<token rule="CommandsKW">DISPLOGIN</token>
			<token rule="CommandsKW">DISPWARNINGS</token>
			<token rule="CommandsKW">DISTINCT</token>
			<token rule="CommandsKW">DLL</token>
			<token rule="CommandsKW">DMY</token>
			<token rule="CommandsKW">DO</token>
			<token rule="CommandsKW">DOCK</token>
			<token rule="CommandsKW">DOEVENTS</token>
			<token rule="CommandsKW">DOS</token>
			<token rule="CommandsKW">DOSMEM</token>
			<token rule="CommandsKW">DOUBLE</token>
			<token rule="CommandsKW">DRIVER</token>
			<token rule="CommandsKW">DROP</token>
			<token rule="CommandsKW">DUPLEX</token>
			<token rule="CommandsKW">EACH</token>
			<token rule="CommandsKW">ECHO</token>
			<token rule="CommandsKW">EDIT</token>
			<token rule="CommandsKW">EDITWORK</token>
			<token rule="CommandsKW">EGA25</token>
			<token rule="CommandsKW">EGA43</token>
			<token rule="CommandsKW">EJECT</token>
			<token rule="CommandsKW">EMS64</token>
			<token rule="CommandsKW">EMS</token>
			<token rule="CommandsKW">ENCRYPT</token>
			<token rule="CommandsKW">ENCRYPTION</token>
			<token rule="CommandsKW">END</token>
			<token rule="CommandsKW">ENDPRINTJOB</token>
			<token rule="CommandsKW">ENVIRONMENT</token>
			<token rule="CommandsKW">ERASE</token>
			<token rule="CommandsKW">ESCAPE</token>
			<token rule="CommandsKW">EVENTS</token>
			<token rule="CommandsKW">EVENTTRACKING</token>
			<token rule="CommandsKW">EXACT</token>
			<token rule="CommandsKW">EXCEPT</token>
			<token rule="CommandsKW">EXCLUSIVE</token>
			<token rule="CommandsKW">EXE</token>
			<token rule="CommandsKW">EXIT</token>
			<token rule="CommandsKW">EXPORT</token>
			<token rule="CommandsKW">EXTENDED</token>
			<token rule="CommandsKW">EXTERNAL</token>
			<token rule="CommandsKW">FETCH</token>
			<token rule="CommandsKW">FIEL</token>
			<token rule="CommandsKW">FIELDS</token>
			<token rule="CommandsKW">FILL</token>
			<token rule="CommandsKW">FIND</token>
			<token rule="CommandsKW">FIXED</token>
			<token rule="CommandsKW">FLAGS</token>
			<token rule="CommandsKW">FLUSH</token>
			<token rule="CommandsKW">FONT</token>
			<token rule="CommandsKW">FOOTER</token>
			<token rule="CommandsKW">FOR</token>
			<token rule="CommandsKW">FORCE</token>
			<token rule="CommandsKW">FOREIGN</token>
			<token rule="CommandsKW">FORM</token>
			<token rule="CommandsKW">FORMAT</token>
			<token rule="CommandsKW">FORMSCLASS</token>
			<token rule="CommandsKW">FORMSET</token>
			<token rule="CommandsKW">FORMSETCLASS</token>
			<token rule="CommandsKW">FORMSETLIB</token>
			<token rule="CommandsKW">FORMSLIB</token>
			<token rule="CommandsKW">FOX2X</token>
			<token rule="CommandsKW">FOXCODE</token>
			<token rule="CommandsKW">FOXDOC</token>
			<token rule="CommandsKW">FOXGEN</token>
			<token rule="CommandsKW">FOXGRAPH</token>
			<token rule="CommandsKW">FOXPLUS</token>
			<token rule="CommandsKW">FOXPRO</token>
			<token rule="CommandsKW">FOXVIEW</token>
			<token rule="CommandsKW">FREE</token>
			<token rule="CommandsKW">FRENCH</token>
			<token rule="CommandsKW">FROM</token>
			<token rule="CommandsKW">FULL</token>
			<token rule="CommandsKW">FW2</token>
			<token rule="CommandsKW">GATHER</token>
			<token rule="CommandsKW">GENERAL</token>
			<token rule="CommandsKW">GERMAN</token>
			<token rule="CommandsKW">GET</token>
			<token rule="CommandsKW">GETS</token>
			<token rule="CommandsKW">GETEXPR</token>
			<token rule="CommandsKW">GLOBAL</token>
			<token rule="CommandsKW">GO</token>
			<token rule="CommandsKW">GOTO</token>
			<token rule="CommandsKW">GRAPH</token>
			<token rule="CommandsKW">GROUP</token>
			<token rule="CommandsKW">GROW</token>
			<token rule="CommandsKW">HALFHEIGHT</token>
			<token rule="CommandsKW">HAVING</token>
			<token rule="CommandsKW">HEADING</token>
			<token rule="CommandsKW">HEADINGS</token>
			<token rule="CommandsKW">HELP</token>
			<token rule="CommandsKW">HELPFILTER</token>
			<token rule="CommandsKW">HELPON</token>
			<token rule="CommandsKW">HELPSTRING</token>
			<token rule="CommandsKW">HELPTO</token>
			<token rule="CommandsKW">HIDDEN</token>
			<token rule="CommandsKW">HIDE</token>
			<token rule="CommandsKW">IDLETIMEOUT</token>
			<token rule="CommandsKW">IMPLEMENTS</token>
			<token rule="CommandsKW">IMPORT</token>
			<token rule="CommandsKW">IN</token>
			<token rule="CommandsKW">INCLUDE</token>
			<token rule="CommandsKW">INDE</token>
			<token rule="CommandsKW">INDEX</token>
			<token rule="CommandsKW">INNER</token>
			<token rule="CommandsKW">INSERT</token>
			<token rule="CommandsKW">INSERTTRIGGER</token>
			<token rule="CommandsKW">INTEGER</token>
			<token rule="CommandsKW">INTENSITY</token>
			<token rule="CommandsKW">INTERSECT</token>
			<token rule="CommandsKW">INTO</token>
			<token rule="CommandsKW">ISOMETRIC</token>
			<token rule="CommandsKW">ITALIAN</token>
			<token rule="CommandsKW">JAPAN</token>
			<token rule="CommandsKW">JOIN</token>
			<token rule="CommandsKW">KEYBOARD</token>
			<token rule="CommandsKW">KEY</token>
			<token rule="CommandsKW">KEYCOLUMNS</token>
			<token rule="CommandsKW">KEYCOMP</token>
			<token rule="CommandsKW">KEYFIELD</token>
			<token rule="CommandsKW">LABEL</token>
			<token rule="CommandsKW">LAST</token>
			<token rule="CommandsKW">LEDIT</token>
			<token rule="CommandsKW">LEFT</token>
			<token rule="CommandsKW">LIBRARY</token>
			<token rule="CommandsKW">LINE</token>
			<token rule="CommandsKW">LIST</token>
			<token rule="CommandsKW">LOCAL</token>
			<token rule="CommandsKW">LOCATE</token>
			<token rule="CommandsKW">LOGERRORS</token>
			<token rule="CommandsKW">LOGOUT</token>
			<token rule="CommandsKW">LONG</token>
			<token rule="CommandsKW">LOOP</token>
			<token rule="CommandsKW">LPARA</token>
			<token rule="CommandsKW">LPARAMETER</token>
			<token rule="CommandsKW">LPARAMETERS</token>
			<token rule="CommandsKW">MAC</token>
			<token rule="CommandsKW">MACROS</token>
			<token rule="CommandsKW">MAIL</token>
			<token rule="CommandsKW">MARK</token>
			<token rule="CommandsKW">MASTER</token>
			<token rule="CommandsKW">MAXMEM</token>
			<token rule="CommandsKW">MD</token>
			<token rule="CommandsKW">MEMO</token>
			<token rule="CommandsKW">MEMORY</token>
			<token rule="CommandsKW">MEMOWIDTH</token>
			<token rule="CommandsKW">MEMVAR</token>
			<token rule="CommandsKW">MENU</token>
			<token rule="CommandsKW">MINIMIZE</token>
			<token rule="CommandsKW">MKDIR</token>
			<token rule="CommandsKW">MODAL</token>
			<token rule="CommandsKW">MODIFY</token>
			<token rule="CommandsKW">MONO43</token>
			<token rule="CommandsKW">MOUSE</token>
			<token rule="CommandsKW">MOVE</token>
			<token rule="CommandsKW">MTDLL</token>
			<token rule="CommandsKW">MULTILOCKS</token>
			<token rule="CommandsKW">MVARSIZ</token>
			<token rule="CommandsKW">NAME</token>
			<token rule="CommandsKW">NEAR</token>
			<token rule="CommandsKW">NEGOTIATE</token>
			<token rule="CommandsKW">NEW</token>
			<token rule="CommandsKW">NEXT</token>
			<token rule="CommandsKW">NEXTVALUE</token>
			<token rule="CommandsKW">NOALIAS</token>
			<token rule="CommandsKW">NOAPPEND</token>
			<token rule="CommandsKW">NOCAPTIONS</token>
			<token rule="CommandsKW">NOCLEAR</token>
			<token rule="CommandsKW">NOCLOSE</token>
			<token rule="CommandsKW">NOCONSOLE</token>
			<token rule="CommandsKW">NOCPTRANS</token>
			<token rule="CommandsKW">NODATA</token>
			<token rule="CommandsKW">NODEBUG</token>
			<token rule="CommandsKW">NODEFAULT</token>
			<token rule="CommandsKW">NODELETE</token>
			<token rule="CommandsKW">NODIALOG</token>
			<token rule="CommandsKW">NODUP</token>
			<token rule="CommandsKW">NOEDIT</token>
			<token rule="CommandsKW">NOEJECT</token>
			<token rule="CommandsKW">NOENVIRONMENT</token>
			<token rule="CommandsKW">NOFLOAT</token>
			<token rule="CommandsKW">NOFOLLOW</token>
			<token rule="CommandsKW">NOGROW</token>
			<token rule="CommandsKW">NOINIT</token>
			<token rule="CommandsKW">NOLGRID</token>
			<token rule="CommandsKW">NOLINK</token>
			<token rule="CommandsKW">NOLOCK</token>
			<token rule="CommandsKW">NOMARGIN</token>
			<token rule="CommandsKW">NOMDI</token>
			<token rule="CommandsKW">NOMENU</token>
			<token rule="CommandsKW">NOMINIMIZE</token>
			<token rule="CommandsKW">NOMODIFY</token>
			<token rule="CommandsKW">NOMOUSE</token>
			<token rule="CommandsKW">NONE</token>
			<token rule="CommandsKW">NOOPTIMIZE</token>
			<token rule="CommandsKW">NOOVERWRITE</token>
			<token rule="CommandsKW">NOPAGEEJECT</token>
			<token rule="CommandsKW">NOPROJECTHOOK</token>
			<token rule="CommandsKW">NOPROMPT</token>
			<token rule="CommandsKW">NOREAD</token>
			<token rule="CommandsKW">NOREFRESH</token>
			<token rule="CommandsKW">NOREQUERY</token>
			<token rule="CommandsKW">NORESET</token>
			<token rule="CommandsKW">NORGRID</token>
			<token rule="CommandsKW">NOSAVE</token>
			<token rule="CommandsKW">NOSHADOW</token>
			<token rule="CommandsKW">NOSHOW</token>
			<token rule="CommandsKW">NOSPACE</token>
			<token rule="CommandsKW">NOT</token>
			<token rule="CommandsKW">NOTAB</token>
			<token rule="CommandsKW">NOTE</token>
			<token rule="CommandsKW">NOTIFY</token>
			<token rule="CommandsKW">NOUPDATE</token>
			<token rule="CommandsKW">NOVALIDATE</token>
			<token rule="CommandsKW">NOVERIFY</token>
			<token rule="CommandsKW">NOW</token>
			<token rule="CommandsKW">NOWAIT</token>
			<token rule="CommandsKW">NOWINDOW</token>
			<token rule="CommandsKW">NOWRAP</token>
			<token rule="CommandsKW">NOZOOM</token>
			<token rule="CommandsKW">NPV</token>
			<token rule="CommandsKW">NULL</token>
			<token rule="CommandsKW">NULLSTRING</token>
			<token rule="CommandsKW">NUMBER</token>
			<token rule="CommandsKW">OBJECT</token>
			<token rule="CommandsKW">OBJECTS</token>
			<token rule="CommandsKW">ODBCHDBC</token>
			<token rule="CommandsKW">ODBCHSTMT</token>
			<token rule="CommandsKW">ODOMETER</token>
			<token rule="CommandsKW">OF</token>
			<token rule="CommandsKW">OFF</token>
			<token rule="CommandsKW">ONLY</token>
			<token rule="CommandsKW">OPEN</token>
			<token rule="CommandsKW">OPTIMIZE</token>
			<token rule="CommandsKW">ORIENTATION</token>
			<token rule="CommandsKW">OTHERWISE</token>
			<token rule="CommandsKW">OUTER</token>
			<token rule="CommandsKW">OUTPUT</token>
			<token rule="CommandsKW">OVERWRITE</token>
			<token rule="CommandsKW">PACK</token>
			<token rule="CommandsKW">PACKETSIZE</token>
			<token rule="CommandsKW">PAPERLENGTH</token>
			<token rule="CommandsKW">PAPERSIZE</token>
			<token rule="CommandsKW">PAPERWIDTH</token>
			<token rule="CommandsKW">PASSWORD</token>
			<token rule="CommandsKW">PATH</token>
			<token rule="CommandsKW">PDSETUP</token>
			<token rule="CommandsKW">PEN</token>
			<token rule="CommandsKW">PIVOT</token>
			<token rule="CommandsKW">PIXELS</token>
			<token rule="CommandsKW">PLAIN</token>
			<token rule="CommandsKW">PLAY</token>
			<token rule="CommandsKW">PLAY</token>
			<token rule="CommandsKW">POINT</token>
			<token rule="CommandsKW">POP</token>
			<token rule="CommandsKW">POWER</token>
			<token rule="CommandsKW">PRECISION</token>
			<token rule="CommandsKW">PRETEXT</token>
			<token rule="CommandsKW">PREVIEW</token>
			<token rule="CommandsKW">PRIMARYKEY</token>
			<token rule="CommandsKW">PRINT</token>
			<token rule="CommandsKW">PRINTER</token>
			<token rule="CommandsKW">PRINTJOB</token>
			<token rule="CommandsKW">PRIVATE</token>
			<token rule="CommandsKW">PROCEDURE</token>
			<token rule="CommandsKW">PROGRAM</token>
			<token rule="CommandsKW">PROJECT</token>
			<token rule="CommandsKW">PROTECTED</token>
			<token rule="CommandsKW">PUBLIC</token>
			<token rule="CommandsKW">PUSH</token>
			<token rule="CommandsKW">QUERY</token>
			<token rule="CommandsKW">QUERYTIMEOUT</token>
			<token rule="CommandsKW">QUIT</token>
			<token rule="CommandsKW">RANGE</token>
			<token rule="CommandsKW">READ</token>
			<token rule="CommandsKW">READWRITE</token>
			<token rule="CommandsKW">RECALL</token>
			<token rule="CommandsKW">RECOMPILE</token>
			<token rule="CommandsKW">RECORD</token>
			<token rule="CommandsKW">RECYCLE</token>
			<token rule="CommandsKW">REGIONAL</token>
			<token rule="CommandsKW">REINDEX</token>
			<token rule="CommandsKW">RELA</token>
			<token rule="CommandsKW">RELATEDCHILD</token>
			<token rule="CommandsKW">RELATEDTABLE</token>
			<token rule="CommandsKW">RELATEDTAG</token>
			<token rule="CommandsKW">RELATIVE</token>
			<token rule="CommandsKW">RELEASE</token>
			<token rule="CommandsKW">REMO</token>
			<token rule="CommandsKW">REMOTE</token>
			<token rule="CommandsKW">REMOVE</token>
			<token rule="CommandsKW">RENAME</token>
			<token rule="CommandsKW">REPL</token>
			<token rule="CommandsKW">REPLACE</token>
			<token rule="CommandsKW">REPORT</token>
			<token rule="CommandsKW">REPORTBEHAVIOR</token>
			<token rule="CommandsKW">REPROCESS</token>
			<token rule="CommandsKW">RESET</token>
			<token rule="CommandsKW">RESOURCE</token>
			<token rule="CommandsKW">RESOURCES</token>
			<token rule="CommandsKW">REST</token>
			<token rule="CommandsKW">RESTORE</token>
			<token rule="CommandsKW">RESUME</token>
			<token rule="CommandsKW">RETRY</token>
			<token rule="CommandsKW">RETURN</token>
			<token rule="CommandsKW">RIGHT</token>
			<token rule="CommandsKW">RMDIR</token>
			<token rule="CommandsKW">ROLLBACK</token>
			<token rule="CommandsKW">RULEEXPRESSION</token>
			<token rule="CommandsKW">RULETEXT</token>
			<token rule="CommandsKW">RUN</token>
			<token rule="CommandsKW">RUNSCRIPT</token>
			<token rule="CommandsKW">SAFETY</token>
			<token rule="CommandsKW">SAVE</token>
			<token rule="CommandsKW">SAY</token>
			<token rule="CommandsKW">SAY</token>
			<token rule="CommandsKW">SCATTER</token>
			<token rule="CommandsKW">SCREEN</token>
			<token rule="CommandsKW">SCROLL</token>
			<token rule="CommandsKW">SDF</token>
			<token rule="CommandsKW">SELE</token>
			<token rule="CommandsKW">SELECTION</token>
			<token rule="CommandsKW">SEPARATOR</token>
			<token rule="CommandsKW">SHARE</token>
			<token rule="CommandsKW">SHARECONNECTION</token>
			<token rule="CommandsKW">SHARED</token>
			<token rule="CommandsKW">SHIFT</token>
			<token rule="CommandsKW">SHORT</token>
			<token rule="CommandsKW">SHORTCUT</token>
			<token rule="CommandsKW">SHOW</token>
			<token rule="CommandsKW">SHUTDOWN</token>
			<token rule="CommandsKW">SINGLE</token>
			<token rule="CommandsKW">SIZE</token>
			<token rule="CommandsKW">SKIP</token>
			<token rule="CommandsKW">SOME</token>
			<token rule="CommandsKW">SORT</token>
			<token rule="CommandsKW">SOURCENAME</token>
			<token rule="CommandsKW">SQL</token>
			<token rule="CommandsKW">SQLASYNCHRONOUS</token>
			<token rule="CommandsKW">SQLBATCHMODE</token>
			<token rule="CommandsKW">SQLCONNECTTIMEOUT</token>
			<token rule="CommandsKW">SQLDISPLOGIN</token>
			<token rule="CommandsKW">SQLDISPWARNINGS</token>
			<token rule="CommandsKW">SQLIDLETIMEOUT</token>
			<token rule="CommandsKW">SQLQUERYTIMEOUT</token>
			<token rule="CommandsKW">SQLTRANSACTIONS</token>
			<token rule="CommandsKW">SQLWAITTIME</token>
			<token rule="CommandsKW">STANDALONE</token>
			<token rule="CommandsKW">STATUS</token>
			<token rule="CommandsKW">STATUSBAR</token>
			<token rule="CommandsKW">STEP</token>
			<token rule="CommandsKW">STORE</token>
			<token rule="CommandsKW">STRING</token>
			<token rule="CommandsKW">STRUCTURE</token>
			<token rule="CommandsKW">SUSPEND</token>
			<token rule="CommandsKW">SYLK</token>
			<token rule="CommandsKW">SYSM</token>
			<token rule="CommandsKW">SYSMENU</token>
			<token rule="CommandsKW">SYSTEM</token>
			<token rule="CommandsKW">TABLE</token>
			<token rule="CommandsKW">TABLE</token>
			<token rule="CommandsKW">TABLEPROMPT</token>
			<token rule="CommandsKW">TABLEPROMPT</token>
			<token rule="CommandsKW">TABORDERING</token>
			<token rule="CommandsKW">TAIWAN</token>
			<token rule="CommandsKW">TALK</token>
			<token rule="CommandsKW">TEDIT</token>
			<token rule="CommandsKW">THROW</token>
			<token rule="CommandsKW">TIMEOUT</token>
			<token rule="CommandsKW">TITLE</token>
			<token rule="CommandsKW">TO</token>
			<token rule="CommandsKW">TOP</token>
			<token rule="CommandsKW">TOPIC</token>
			<token rule="CommandsKW">TOTAL</token>
			<token rule="CommandsKW">TRANSACTION</token>
			<token rule="CommandsKW">TRBET</token>
			<token rule="CommandsKW">TRBETWEEN</token>
			<token rule="CommandsKW">TRIGGER</token>
			<token rule="CommandsKW">TRUNCATE</token>
			<token rule="CommandsKW">UDFPARMS</token>
			<token rule="CommandsKW">UNDEFINE</token>
			<token rule="CommandsKW">UNION</token>
			<token rule="CommandsKW">UNLOCK</token>
			<token rule="CommandsKW">UPDATABLE</token>
			<token rule="CommandsKW">UPDATENAME</token>
			<token rule="CommandsKW">UPDATETRIGGER</token>
			<token rule="CommandsKW">USA</token>
			<token rule="CommandsKW">USE</token>
			<token rule="CommandsKW">VALIDATE</token>
			<token rule="CommandsKW">VALUE</token>
			<token rule="CommandsKW">VALUES</token>
			<token rule="CommandsKW">VAR</token>
			<token rule="CommandsKW">VARBINARY</token>
			<token rule="CommandsKW">VARCHAR</token>
			<token rule="CommandsKW">VARCHARMAPPING</token>
			<token rule="CommandsKW">VGA25</token>
			<token rule="CommandsKW">VGA50</token>
			<token rule="CommandsKW">VIEW</token>
			<token rule="CommandsKW">WAIT</token>
			<token rule="CommandsKW">WAITTIME</token>
			<token rule="CommandsKW">WHERE</token>
			<token rule="CommandsKW">WHERETYPE</token>
			<token rule="CommandsKW">WHEN</token>
			<token rule="CommandsKW">WHILE</token>
			<token rule="CommandsKW">WINDOW</token>
			<token rule="CommandsKW">WITH</token>
			<token rule="CommandsKW">WK1</token>
			<token rule="CommandsKW">WK3</token>
			<token rule="CommandsKW">WKS</token>
			<token rule="CommandsKW">WORKAREA</token>
			<token rule="CommandsKW">WR1</token>
			<token rule="CommandsKW">WRK</token>
			<token rule="CommandsKW">XL5</token>
			<token rule="CommandsKW">XL8</token>
			<token rule="CommandsKW">XLS</token>
			<token rule="CommandsKW">XML</token>
			<token rule="CommandsKW">YMD</token>
			<token rule="CommandsKW">ZAP</token>
			<token rule="CommandsKW">ZOOM</token>
			<token rule="FunctCmdKW">ALIA</token>
			<token rule="FunctCmdKW">ALIAS</token>
			<token rule="FunctCmdKW">AVG</token>
			<token rule="FunctCmdKW">BAR</token>
			<token rule="FunctCmdKW">CANDIDATE</token>
			<token rule="FunctCmdKW">COUNT</token>
			<token rule="FunctCmdKW">DATE</token>
			<token rule="FunctCmdKW">DBF</token>
			<token rule="FunctCmdKW">DEFAULT</token>
			<token rule="FunctCmdKW">DELETED</token>
			<token rule="FunctCmdKW">DESC</token>
			<token rule="FunctCmdKW">DESCENDING</token>
			<token rule="FunctCmdKW">ERROR</token>
			<token rule="FunctCmdKW">FILE</token>
			<token rule="FunctCmdKW">FILT</token>
			<token rule="FunctCmdKW">FILTER</token>
			<token rule="FunctCmdKW">FULLPATH</token>
			<token rule="FunctCmdKW">LIKE</token>
			<token rule="FunctCmdKW">LOCK</token>
			<token rule="FunctCmdKW">MDY</token>
			<token rule="FunctCmdKW">MESSAGE</token>
			<token rule="FunctCmdKW">ON</token>
			<token rule="FunctCmdKW">ORDE</token>
			<token rule="FunctCmdKW">ORDER</token>
			<token rule="FunctCmdKW">PAD</token>
			<token rule="FunctCmdKW">PARA</token>
			<token rule="FunctCmdKW">PARAMETER</token>
			<token rule="FunctCmdKW">PARAMETERS</token>
			<token rule="FunctCmdKW">POPU</token>
			<token rule="FunctCmdKW">POPUP</token>
			<token rule="FunctCmdKW">POPUPS</token>
			<token rule="FunctCmdKW">PROM</token>
			<token rule="FunctCmdKW">PROMPT</token>
			<token rule="FunctCmdKW">RELATION</token>
			<token rule="FunctCmdKW">SEEK</token>
			<token rule="FunctCmdKW">SELECT</token>
			<token rule="FunctCmdKW">SET</token>
			<token rule="FunctCmdKW">SUM</token>
			<token rule="FunctCmdKW">SYS</token>
			<token rule="FunctCmdKW">TAG</token>
			<token rule="FunctCmdKW">TEXTMERGE</token>
			<token rule="FunctCmdKW">TYPE</token>
			<token rule="FunctCmdKW">UNIQUE</token>
			<token rule="FunctCmdKW">UPDATE</token>
			<token rule="FunctionKW">ABS</token>
			<token rule="FunctionKW">ACLA</token>
			<token rule="FunctionKW">ACLASS</token>
			<token rule="FunctionKW">ACOP</token>
			<token rule="FunctionKW">ACOPY</token>
			<token rule="FunctionKW">ACOS</token>
			<token rule="FunctionKW">ADAT</token>
			<token rule="FunctionKW">ADATABASES</token>
			<token rule="FunctionKW">ADBO</token>
			<token rule="FunctionKW">ADBOBJECTS</token>
			<token rule="FunctionKW">ADDB</token>
			<token rule="FunctionKW">ADDBS</token>
			<token rule="FunctionKW">ADDP</token>
			<token rule="FunctionKW">ADDPROPERTY</token>
			<token rule="FunctionKW">ADEL</token>
			<token rule="FunctionKW">ADIR</token>
			<token rule="FunctionKW">ADLL</token>
			<token rule="FunctionKW">ADLLS</token>
			<token rule="FunctionKW">ADOC</token>
			<token rule="FunctionKW">ADOCKSTATE</token>
			<token rule="FunctionKW">AELE</token>
			<token rule="FunctionKW">AELEMENT</token>
			<token rule="FunctionKW">AERR</token>
			<token rule="FunctionKW">AERROR</token>
			<token rule="FunctionKW">AEVE</token>
			<token rule="FunctionKW">AEVENTS</token>
			<token rule="FunctionKW">AFIE</token>
			<token rule="FunctionKW">AFIELDS</token>
			<token rule="FunctionKW">AFON</token>
			<token rule="FunctionKW">AFONT</token>
			<token rule="FunctionKW">AGETC</token>
			<token rule="FunctionKW">AGETCLASS</token>
			<token rule="FunctionKW">AGETF</token>
			<token rule="FunctionKW">AGETFILEVERSION</token>
			<token rule="FunctionKW">AINS</token>
			<token rule="FunctionKW">AINST</token>
			<token rule="FunctionKW">AINSTANCE</token>
			<token rule="FunctionKW">ALAN</token>
			<token rule="FunctionKW">ALANGUAGE</token>
			<token rule="FunctionKW">ALEN</token>
			<token rule="FunctionKW">ALIN</token>
			<token rule="FunctionKW">ALINES</token>
			<token rule="FunctionKW">ALLT</token>
			<token rule="FunctionKW">ALLTRIM</token>
			<token rule="FunctionKW">AMEM</token>
			<token rule="FunctionKW">AMEMBERS</token>
			<token rule="FunctionKW">AMOU</token>
			<token rule="FunctionKW">AMOUSEOBJ</token>
			<token rule="FunctionKW">ANET</token>
			<token rule="FunctionKW">ANETRESOURCES</token>
			<token rule="FunctionKW">ANSI</token>
			<token rule="FunctionKW">ANSITOOEM</token>
			<token rule="FunctionKW">APRI</token>
			<token rule="FunctionKW">APRINTERS</token>
			<token rule="FunctionKW">APRO</token>
			<token rule="FunctionKW">APROCINFO</token>
			<token rule="FunctionKW">ASC</token>
			<token rule="FunctionKW">ASCA</token>
			<token rule="FunctionKW">ASCAN</token>
			<token rule="FunctionKW">ASEL</token>
			<token rule="FunctionKW">ASELOBJ</token>
			<token rule="FunctionKW">ASES</token>
			<token rule="FunctionKW">ASESSIONS</token>
			<token rule="FunctionKW">ASIN</token>
			<token rule="FunctionKW">ASOR</token>
			<token rule="FunctionKW">ASORT</token>
			<token rule="FunctionKW">ASQL</token>
			<token rule="FunctionKW">ASQLHANDLES</token>
			<token rule="FunctionKW">ASTA</token>
			<token rule="FunctionKW">ASTACKINFO</token>
			<token rule="FunctionKW">ASUB</token>
			<token rule="FunctionKW">ASUBSCRIPT</token>
			<token rule="FunctionKW">AT</token>
			<token rule="FunctionKW">AT_C</token>
			<token rule="FunctionKW">ATAG</token>
			<token rule="FunctionKW">ATAGINFO</token>
			<token rule="FunctionKW">ATAN</token>
			<token rule="FunctionKW">ATC</token>
			<token rule="FunctionKW">ATCC</token>
			<token rule="FunctionKW">ATCL</token>
			<token rule="FunctionKW">ATCLINE</token>
			<token rule="FunctionKW">ATLI</token>
			<token rule="FunctionKW">ATLINE</token>
			<token rule="FunctionKW">ATN2</token>
			<token rule="FunctionKW">AUSE</token>
			<token rule="FunctionKW">AUSED</token>
			<token rule="FunctionKW">AVCX</token>
			<token rule="FunctionKW">AVCXCLASSES</token>
			<token rule="FunctionKW">BARCOUNT</token>
			<token rule="FunctionKW">BARPROMPT</token>
			<token rule="FunctionKW">BETW</token>
			<token rule="FunctionKW">BETWEEN</token>
			<token rule="FunctionKW">BIND</token>
			<token rule="FunctionKW">BINDEVENT</token>
			<token rule="FunctionKW">BINT</token>
			<token rule="FunctionKW">BINTOC</token>
			<token rule="FunctionKW">BITA</token>
			<token rule="FunctionKW">BITAND</token>
			<token rule="FunctionKW">BITC</token>
			<token rule="FunctionKW">BITCLEAR</token>
			<token rule="FunctionKW">BITL</token>
			<token rule="FunctionKW">BITLSHIFT</token>
			<token rule="FunctionKW">BITN</token>
			<token rule="FunctionKW">BITNOT</token>
			<token rule="FunctionKW">BITO</token>
			<token rule="FunctionKW">BITOR</token>
			<token rule="FunctionKW">BITR</token>
			<token rule="FunctionKW">BITRSHIFT</token>
			<token rule="FunctionKW">BITS</token>
			<token rule="FunctionKW">BITSET</token>
			<token rule="FunctionKW">BITT</token>
			<token rule="FunctionKW">BITTEST</token>
			<token rule="FunctionKW">BITX</token>
			<token rule="FunctionKW">BITXOR</token>
			<token rule="FunctionKW">BOF</token>
			<token rule="FunctionKW">CAND</token>
			<token rule="FunctionKW">CAPS</token>
			<token rule="FunctionKW">CAPSLOCK</token>
			<token rule="FunctionKW">CAST</token>
			<token rule="FunctionKW">CDOW</token>
			<token rule="FunctionKW">CDX</token>
			<token rule="FunctionKW">CEIL</token>
			<token rule="FunctionKW">CEILING</token>
			<token rule="FunctionKW">CHANGE</token>
			<token rule="FunctionKW">CHR</token>
			<token rule="FunctionKW">CHRS</token>
			<token rule="FunctionKW">CHRSAW</token>
			<token rule="FunctionKW">CHRT</token>
			<token rule="FunctionKW">CHRTRAN</token>
			<token rule="FunctionKW">CHRTRANC</token>
			<token rule="FunctionKW">CLEARR</token>
			<token rule="FunctionKW">CLEARRESULTSET</token>
			<token rule="FunctionKW">CMON</token>
			<token rule="FunctionKW">CMONTH</token>
			<token rule="FunctionKW">CNTB</token>
			<token rule="FunctionKW">CNTBAR</token>
			<token rule="FunctionKW">CNTP</token>
			<token rule="FunctionKW">CNTPAD</token>
			<token rule="FunctionKW">COL</token>
			<token rule="FunctionKW">COMA</token>
			<token rule="FunctionKW">COMARRAY</token>
			<token rule="FunctionKW">COMC</token>
			<token rule="FunctionKW">COMCLASSINFO</token>
			<token rule="FunctionKW">COMP</token>
			<token rule="FunctionKW">COMPLETED</token>
			<token rule="FunctionKW">COMPOBJ</token>
			<token rule="FunctionKW">COMPROP</token>
			<token rule="FunctionKW">COMR</token>
			<token rule="FunctionKW">COMRETURNERROR</token>
			<token rule="FunctionKW">COS</token>
			<token rule="FunctionKW">CPCO</token>
			<token rule="FunctionKW">CPCONVERT</token>
			<token rule="FunctionKW">CPCU</token>
			<token rule="FunctionKW">CPCURRENT</token>
			<token rule="FunctionKW">CPDB</token>
			<token rule="FunctionKW">CPDBF</token>
			<token rule="FunctionKW">CPNOTRANS</token>
			<token rule="FunctionKW">CREATEB</token>
			<token rule="FunctionKW">CREATEBINARY</token>
			<token rule="FunctionKW">CREATEOBJECT</token>
			<token rule="FunctionKW">CREATEOBJECTEX</token>
			<token rule="FunctionKW">CREATEOF</token>
			<token rule="FunctionKW">CREATEOFFLINE</token>
			<token rule="FunctionKW">CREATEOFFLINE</token>
			<token rule="FunctionKW">CTOB</token>
			<token rule="FunctionKW">CTOBIN</token>
			<token rule="FunctionKW">CTOD</token>
			<token rule="FunctionKW">CTOT</token>
			<token rule="FunctionKW">CURDIR</token>
			<token rule="FunctionKW">CURSORG</token>
			<token rule="FunctionKW">CURSORGETPROP</token>
			<token rule="FunctionKW">CURSORS</token>
			<token rule="FunctionKW">CURSORSETPROP</token>
			<token rule="FunctionKW">CURSORTOX</token>
			<token rule="FunctionKW">CURSORTOXML</token>
			<token rule="FunctionKW">CURV</token>
			<token rule="FunctionKW">CURVAL</token>
			<token rule="FunctionKW">DATET</token>
			<token rule="FunctionKW">DATETIME</token>
			<token rule="FunctionKW">DAY</token>
			<token rule="FunctionKW">DBAL</token>
			<token rule="FunctionKW">DBALIAS</token>
			<token rule="FunctionKW">DBC</token>
			<token rule="FunctionKW">DBGE</token>
			<token rule="FunctionKW">DBGETPROP</token>
			<token rule="FunctionKW">DBSE</token>
			<token rule="FunctionKW">DBSETPROP</token>
			<token rule="FunctionKW">DBUS</token>
			<token rule="FunctionKW">DBUSED</token>
			<token rule="FunctionKW">DDEAB</token>
			<token rule="FunctionKW">DDEABORTTRANS</token>
			<token rule="FunctionKW">DDEAD</token>
			<token rule="FunctionKW">DDEADVISE</token>
			<token rule="FunctionKW">DDEEN</token>
			<token rule="FunctionKW">DDEENABLED</token>
			<token rule="FunctionKW">DDEEX</token>
			<token rule="FunctionKW">DDEEXECUTE</token>
			<token rule="FunctionKW">DDEI</token>
			<token rule="FunctionKW">DDEINITIATE</token>
			<token rule="FunctionKW">DDEL</token>
			<token rule="FunctionKW">DDELASTERROR</token>
			<token rule="FunctionKW">DDEP</token>
			<token rule="FunctionKW">DDEPOKE</token>
			<token rule="FunctionKW">DDER</token>
			<token rule="FunctionKW">DDEREQUEST</token>
			<token rule="FunctionKW">DDES</token>
			<token rule="FunctionKW">DDESETOPTION</token>
			<token rule="FunctionKW">DDESETS</token>
			<token rule="FunctionKW">DDESETSERVICE</token>
			<token rule="FunctionKW">DDESETT</token>
			<token rule="FunctionKW">DDESETTOPIC</token>
			<token rule="FunctionKW">DDET</token>
			<token rule="FunctionKW">DDETERMINATE</token>
			<token rule="FunctionKW">DEFAULTEXT</token>
			<token rule="FunctionKW">DIFF</token>
			<token rule="FunctionKW">DIFFERENCE</token>
			<token rule="FunctionKW">DIRE</token>
			<token rule="FunctionKW">DIRECTORY</token>
			<token rule="FunctionKW">DISK</token>
			<token rule="FunctionKW">DISKSPACE</token>
			<token rule="FunctionKW">DISP</token>
			<token rule="FunctionKW">DISPLAYPATH</token>
			<token rule="FunctionKW">DMY</token>
			<token rule="FunctionKW">DODE</token>
			<token rule="FunctionKW">DODEFAULT</token>
			<token rule="FunctionKW">DOW</token>
			<token rule="FunctionKW">DRIV</token>
			<token rule="FunctionKW">DRIVETYPE</token>
			<token rule="FunctionKW">DRIVETYPE</token>
			<token rule="FunctionKW">DROP</token>
			<token rule="FunctionKW">DROPOFFLINE</token>
			<token rule="FunctionKW">DTOC</token>
			<token rule="FunctionKW">DTOR</token>
			<token rule="FunctionKW">DTOS</token>
			<token rule="FunctionKW">DTOT</token>
			<token rule="FunctionKW">EDITSOURCE</token>
			<token rule="FunctionKW">EMPT</token>
			<token rule="FunctionKW">EMPTY</token>
			<token rule="FunctionKW">EOF</token>
			<token rule="FunctionKW">ERRO</token>
			<token rule="FunctionKW">EVAL</token>
			<token rule="FunctionKW">EVALUATE</token>
			<token rule="FunctionKW">EVENT</token>
			<token rule="FunctionKW">EVENTHANDLER</token>
			<token rule="FunctionKW">EVL</token>
			<token rule="FunctionKW">EXEC</token>
			<token rule="FunctionKW">EXECSCRIPT</token>
			<token rule="FunctionKW">EXP</token>
			<token rule="FunctionKW">FCHS</token>
			<token rule="FunctionKW">FCHSIZE</token>
			<token rule="FunctionKW">FCLO</token>
			<token rule="FunctionKW">FCLOSE</token>
			<token rule="FunctionKW">FCOU</token>
			<token rule="FunctionKW">FCOUNT</token>
			<token rule="FunctionKW">FCRE</token>
			<token rule="FunctionKW">FCREATE</token>
			<token rule="FunctionKW">FDAT</token>
			<token rule="FunctionKW">FDATE</token>
			<token rule="FunctionKW">FEOF</token>
			<token rule="FunctionKW">FERR</token>
			<token rule="FunctionKW">FERROR</token>
			<token rule="FunctionKW">FFLU</token>
			<token rule="FunctionKW">FFLUSH</token>
			<token rule="FunctionKW">FGET</token>
			<token rule="FunctionKW">FGETS</token>
			<token rule="FunctionKW">FILES</token>
			<token rule="FunctionKW">FILET</token>
			<token rule="FunctionKW">FILETOSTR</token>
			<token rule="FunctionKW">FIXED</token>
			<token rule="FunctionKW">FKLA</token>
			<token rule="FunctionKW">FKLABEL</token>
			<token rule="FunctionKW">FKMA</token>
			<token rule="FunctionKW">FKMAX</token>
			<token rule="FunctionKW">FLDCOUNT</token>
			<token rule="FunctionKW">FLDLIST</token>
			<token rule="FunctionKW">FLOAT</token>
			<token rule="FunctionKW">FLOC</token>
			<token rule="FunctionKW">FLOCK</token>
			<token rule="FunctionKW">FLOO</token>
			<token rule="FunctionKW">FLOOR</token>
			<token rule="FunctionKW">FONT</token>
			<token rule="FunctionKW">FONTMETRIC</token>
			<token rule="FunctionKW">FONTMETRIC</token>
			<token rule="FunctionKW">FOPE</token>
			<token rule="FunctionKW">FOPEN</token>
			<token rule="FunctionKW">FORCEE</token>
			<token rule="FunctionKW">FORCEEXT</token>
			<token rule="FunctionKW">FORCEP</token>
			<token rule="FunctionKW">FORCEPATH</token>
			<token rule="FunctionKW">FOUN</token>
			<token rule="FunctionKW">FOUND</token>
			<token rule="FunctionKW">FPUT</token>
			<token rule="FunctionKW">FPUTS</token>
			<token rule="FunctionKW">FREA</token>
			<token rule="FunctionKW">FREAD</token>
			<token rule="FunctionKW">FSEE</token>
			<token rule="FunctionKW">FSEEK</token>
			<token rule="FunctionKW">FSIZ</token>
			<token rule="FunctionKW">FSIZE</token>
			<token rule="FunctionKW">FTIM</token>
			<token rule="FunctionKW">FTIME</token>
			<token rule="FunctionKW">FV</token>
			<token rule="FunctionKW">FWRI</token>
			<token rule="FunctionKW">FWRITE</token>
			<token rule="FunctionKW">GETA</token>
			<token rule="FunctionKW">GETAUTOINCVALUE</token>
			<token rule="FunctionKW">GETB</token>
			<token rule="FunctionKW">GETBAR</token>
			<token rule="FunctionKW">GETC</token>
			<token rule="FunctionKW">GETCOLOR</token>
			<token rule="FunctionKW">GETCP</token>
			<token rule="FunctionKW">GETCU</token>
			<token rule="FunctionKW">GETCURSORADAPTER</token>
			<token rule="FunctionKW">GETD</token>
			<token rule="FunctionKW">GETDIR</token>
			<token rule="FunctionKW">GETE</token>
			<token rule="FunctionKW">GETENV</token>
			<token rule="FunctionKW">GETF</token>
			<token rule="FunctionKW">GETFILE</token>
			<token rule="FunctionKW">GETFL</token>
			<token rule="FunctionKW">GETFLDSTATE</token>
			<token rule="FunctionKW">GETFO</token>
			<token rule="FunctionKW">GETFONT</token>
			<token rule="FunctionKW">GETH</token>
			<token rule="FunctionKW">GETHOST</token>
			<token rule="FunctionKW">GETI</token>
			<token rule="FunctionKW">GETINTERFACE</token>
			<token rule="FunctionKW">GETN</token>
			<token rule="FunctionKW">GETNEXTMODIFIED</token>
			<token rule="FunctionKW">GETO</token>
			<token rule="FunctionKW">GETOBJECT</token>
			<token rule="FunctionKW">GETP</token>
			<token rule="FunctionKW">GETPAD</token>
			<token rule="FunctionKW">GETPEM</token>
			<token rule="FunctionKW">GETPI</token>
			<token rule="FunctionKW">GETPICT</token>
			<token rule="FunctionKW">GETPR</token>
			<token rule="FunctionKW">GETPRINTER</token>
			<token rule="FunctionKW">GETR</token>
			<token rule="FunctionKW">GETRESULTSET</token>
			<token rule="FunctionKW">GETWORDC</token>
			<token rule="FunctionKW">GETWORDCOUNT</token>
			<token rule="FunctionKW">GETWORDN</token>
			<token rule="FunctionKW">GETWORDNUM</token>
			<token rule="FunctionKW">GO</token>
			<token rule="FunctionKW">GOMO</token>
			<token rule="FunctionKW">GOMONTH</token>
			<token rule="FunctionKW">HEAD</token>
			<token rule="FunctionKW">HEADER</token>
			<token rule="FunctionKW">HOME</token>
			<token rule="FunctionKW">HOUR</token>
			<token rule="FunctionKW">HOURS</token>
			<token rule="FunctionKW">ICAS</token>
			<token rule="FunctionKW">ICASE</token>
			<token rule="FunctionKW">ID</token>
			<token rule="FunctionKW">IDXC</token>
			<token rule="FunctionKW">IDXCOLLATE</token>
			<token rule="FunctionKW">IIF</token>
			<token rule="FunctionKW">IMES</token>
			<token rule="FunctionKW">IMESTATUS</token>
			<token rule="FunctionKW">INDB</token>
			<token rule="FunctionKW">INDBC</token>
			<token rule="FunctionKW">INDEXSEEK</token>
			<token rule="FunctionKW">INKE</token>
			<token rule="FunctionKW">INKEY</token>
			<token rule="FunctionKW">INLI</token>
			<token rule="FunctionKW">INLIST</token>
			<token rule="FunctionKW">INPU</token>
			<token rule="FunctionKW">INPUTBOX</token>
			<token rule="FunctionKW">INSM</token>
			<token rule="FunctionKW">INSMODE</token>
			<token rule="FunctionKW">INT</token>
			<token rule="FunctionKW">ISAL</token>
			<token rule="FunctionKW">ISALPHA</token>
			<token rule="FunctionKW">ISBL</token>
			<token rule="FunctionKW">ISBLANK</token>
			<token rule="FunctionKW">ISCO</token>
			<token rule="FunctionKW">ISCOLOR</token>
			<token rule="FunctionKW">ISDI</token>
			<token rule="FunctionKW">ISDIGIT</token>
			<token rule="FunctionKW">ISEX</token>
			<token rule="FunctionKW">ISEXCLUSIVE</token>
			<token rule="FunctionKW">ISFL</token>
			<token rule="FunctionKW">ISHO</token>
			<token rule="FunctionKW">ISHOSTED</token>
			<token rule="FunctionKW">ISLE</token>
			<token rule="FunctionKW">ISLEADBYTE</token>
			<token rule="FunctionKW">ISLO</token>
			<token rule="FunctionKW">ISLOWER</token>
			<token rule="FunctionKW">ISME</token>
			<token rule="FunctionKW">ISMEMOFETCHED</token>
			<token rule="FunctionKW">ISMO</token>
			<token rule="FunctionKW">ISMOUSE</token>
			<token rule="FunctionKW">ISNU</token>
			<token rule="FunctionKW">ISNULL</token>
			<token rule="FunctionKW">ISPE</token>
			<token rule="FunctionKW">ISPEN</token>
			<token rule="FunctionKW">ISRE</token>
			<token rule="FunctionKW">ISREADONLY</token>
			<token rule="FunctionKW">ISRL</token>
			<token rule="FunctionKW">ISRLOCKED</token>
			<token rule="FunctionKW">ISTR</token>
			<token rule="FunctionKW">ISTRANSACTABLE</token>
			<token rule="FunctionKW">ISUP</token>
			<token rule="FunctionKW">ISUPPER</token>
			<token rule="FunctionKW">JUSTD</token>
			<token rule="FunctionKW">JUSTDRIVE</token>
			<token rule="FunctionKW">JUSTE</token>
			<token rule="FunctionKW">JUSTEXT</token>
			<token rule="FunctionKW">JUSTF</token>
			<token rule="FunctionKW">JUSTFNAME</token>
			<token rule="FunctionKW">JUSTP</token>
			<token rule="FunctionKW">JUSTPATH</token>
			<token rule="FunctionKW">JUSTS</token>
			<token rule="FunctionKW">JUSTSTEM</token>
			<token rule="FunctionKW">KEY</token>
			<token rule="FunctionKW">KEYM</token>
			<token rule="FunctionKW">KEYMATCH</token>
			<token rule="FunctionKW">LASTKEY</token>
			<token rule="FunctionKW">LEFT</token>
			<token rule="FunctionKW">LEFTC</token>
			<token rule="FunctionKW">LEN</token>
			<token rule="FunctionKW">LENC</token>
			<token rule="FunctionKW">LIKEC</token>
			<token rule="FunctionKW">LINENO</token>
			<token rule="FunctionKW">LOADPICTURE</token>
			<token rule="FunctionKW">LOCF</token>
			<token rule="FunctionKW">LOCFILE</token>
			<token rule="FunctionKW">LOG10</token>
			<token rule="FunctionKW">LOG1</token>
			<token rule="FunctionKW">LOG</token>
			<token rule="FunctionKW">LOOK</token>
			<token rule="FunctionKW">LOOKUP</token>
			<token rule="FunctionKW">LOWE</token>
			<token rule="FunctionKW">LOWER</token>
			<token rule="FunctionKW">LTRI</token>
			<token rule="FunctionKW">LTRIM</token>
			<token rule="FunctionKW">LUPD</token>
			<token rule="FunctionKW">LUPDATE</token>
			<token rule="FunctionKW">MAKE</token>
			<token rule="FunctionKW">MAKETRANSACTABLE</token>
			<token rule="FunctionKW">MAX</token>
			<token rule="FunctionKW">MCOL</token>
			<token rule="FunctionKW">MDOW</token>
			<token rule="FunctionKW">MDOWN</token>
			<token rule="FunctionKW">MDX</token>
			<token rule="FunctionKW">MEMLIMIT</token>
			<token rule="FunctionKW">MEMLINES</token>
			<token rule="FunctionKW">MEMORY</token>
			<token rule="FunctionKW">MENU</token>
			<token rule="FunctionKW">MESS</token>
			<token rule="FunctionKW">MESSAGEB</token>
			<token rule="FunctionKW">MESSAGEBOX</token>
			<token rule="FunctionKW">MESSAGES</token>
			<token rule="FunctionKW">MIN</token>
			<token rule="FunctionKW">MINUS</token>
			<token rule="FunctionKW">MINUTE</token>
			<token rule="FunctionKW">MLIN</token>
			<token rule="FunctionKW">MLINE</token>
			<token rule="FunctionKW">MOD</token>
			<token rule="FunctionKW">MONT</token>
			<token rule="FunctionKW">MONTH</token>
			<token rule="FunctionKW">MRKB</token>
			<token rule="FunctionKW">MRKBAR</token>
			<token rule="FunctionKW">MRKP</token>
			<token rule="FunctionKW">MRKPAD</token>
			<token rule="FunctionKW">MROW</token>
			<token rule="FunctionKW">MTON</token>
			<token rule="FunctionKW">MWIN</token>
			<token rule="FunctionKW">MWINDOW</token>
			<token rule="FunctionKW">NDX</token>
			<token rule="FunctionKW">NETWORK</token>
			<token rule="FunctionKW">NEWO</token>
			<token rule="FunctionKW">NEWOBJECT</token>
			<token rule="FunctionKW">NORM</token>
			<token rule="FunctionKW">NORMALIZE</token>
			<token rule="FunctionKW">NTOM</token>
			<token rule="FunctionKW">NUML</token>
			<token rule="FunctionKW">NUMLOCK</token>
			<token rule="FunctionKW">NVL</token>
			<token rule="FunctionKW">OBJNUM</token>
			<token rule="FunctionKW">OBJT</token>
			<token rule="FunctionKW">OBJTOCLIENT</token>
			<token rule="FunctionKW">OBJVAR</token>
			<token rule="FunctionKW">OCCU</token>
			<token rule="FunctionKW">OCCURS</token>
			<token rule="FunctionKW">OEMTOANSI</token>
			<token rule="FunctionKW">OLDV</token>
			<token rule="FunctionKW">OLDVAL</token>
			<token rule="FunctionKW">OS</token>
			<token rule="FunctionKW">PADC</token>
			<token rule="FunctionKW">PADL</token>
			<token rule="FunctionKW">PADPROMPT</token>
			<token rule="FunctionKW">PADR</token>
			<token rule="FunctionKW">PAYM</token>
			<token rule="FunctionKW">PAYMENT</token>
			<token rule="FunctionKW">PCOL</token>
			<token rule="FunctionKW">PCOU</token>
			<token rule="FunctionKW">PCOUNT</token>
			<token rule="FunctionKW">PEMS</token>
			<token rule="FunctionKW">PEMSTATUS</token>
			<token rule="FunctionKW">PI</token>
			<token rule="FunctionKW">PRIM</token>
			<token rule="FunctionKW">PRIMARY</token>
			<token rule="FunctionKW">PRINTSTATUS</token>
			<token rule="FunctionKW">PRMB</token>
			<token rule="FunctionKW">PRMBAR</token>
			<token rule="FunctionKW">PRMP</token>
			<token rule="FunctionKW">PRMPAD</token>
			<token rule="FunctionKW">PROG</token>
			<token rule="FunctionKW">PROGRAM</token>
			<token rule="FunctionKW">PROP</token>
			<token rule="FunctionKW">PROPER</token>
			<token rule="FunctionKW">PROW</token>
			<token rule="FunctionKW">PRTI</token>
			<token rule="FunctionKW">PRTINFO</token>
			<token rule="FunctionKW">PUTF</token>
			<token rule="FunctionKW">PUTFILE</token>
			<token rule="FunctionKW">PV</token>
			<token rule="FunctionKW">QUAR</token>
			<token rule="FunctionKW">QUARTER</token>
			<token rule="FunctionKW">RAIS</token>
			<token rule="FunctionKW">RAISEEVENT</token>
			<token rule="FunctionKW">RAND</token>
			<token rule="FunctionKW">RAT</token>
			<token rule="FunctionKW">RATC</token>
			<token rule="FunctionKW">RATL</token>
			<token rule="FunctionKW">RATLINE</token>
			<token rule="FunctionKW">RD</token>
			<token rule="FunctionKW">RDLEVEL</token>
			<token rule="FunctionKW">READKEY</token>
			<token rule="FunctionKW">RECC</token>
			<token rule="FunctionKW">RECCOUNT</token>
			<token rule="FunctionKW">RECN</token>
			<token rule="FunctionKW">RECNO</token>
			<token rule="FunctionKW">RECS</token>
			<token rule="FunctionKW">RECSIZE</token>
			<token rule="FunctionKW">REFR</token>
			<token rule="FunctionKW">REFRESH</token>
			<token rule="FunctionKW">REMOVEPROPERTY</token>
			<token rule="FunctionKW">REPLICATE</token>
			<token rule="FunctionKW">REQU</token>
			<token rule="FunctionKW">REQUERY</token>
			<token rule="FunctionKW">RGB</token>
			<token rule="FunctionKW">RGBS</token>
			<token rule="FunctionKW">RGBSCHEME</token>
			<token rule="FunctionKW">RIGH</token>
			<token rule="FunctionKW">RIGHT</token>
			<token rule="FunctionKW">RIGHTC</token>
			<token rule="FunctionKW">RLOC</token>
			<token rule="FunctionKW">RLOCK</token>
			<token rule="FunctionKW">ROUN</token>
			<token rule="FunctionKW">ROUND</token>
			<token rule="FunctionKW">ROW</token>
			<token rule="FunctionKW">RTOD</token>
			<token rule="FunctionKW">RTRI</token>
			<token rule="FunctionKW">RTRIM</token>
			<token rule="FunctionKW">SAVEPICTURE</token>
			<token rule="FunctionKW">SCHE</token>
			<token rule="FunctionKW">SCHEME</token>
			<token rule="FunctionKW">SCOL</token>
			<token rule="FunctionKW">SCOLS</token>
			<token rule="FunctionKW">SEC</token>
			<token rule="FunctionKW">SECO</token>
			<token rule="FunctionKW">SECONDS</token>
			<token rule="FunctionKW">SETF</token>
			<token rule="FunctionKW">SETFLDSTATE</token>
			<token rule="FunctionKW">SETR</token>
			<token rule="FunctionKW">SETRESULTSET</token>
			<token rule="FunctionKW">SIGN</token>
			<token rule="FunctionKW">SIN</token>
			<token rule="FunctionKW">SKPB</token>
			<token rule="FunctionKW">SKPBAR</token>
			<token rule="FunctionKW">SKPP</token>
			<token rule="FunctionKW">SKPPAD</token>
			<token rule="FunctionKW">SOUN</token>
			<token rule="FunctionKW">SOUNDEX</token>
			<token rule="FunctionKW">SPAC</token>
			<token rule="FunctionKW">SPACE</token>
			<token rule="FunctionKW">SQLCA</token>
			<token rule="FunctionKW">SQLCANCEL</token>
			<token rule="FunctionKW">SQLCANCEL</token>
			<token rule="FunctionKW">SQLCOL</token>
			<token rule="FunctionKW">SQLCOLUMNS</token>
			<token rule="FunctionKW">SQLCOLUMNS</token>
			<token rule="FunctionKW">SQLCOM</token>
			<token rule="FunctionKW">SQLCOMMIT</token>
			<token rule="FunctionKW">SQLCOMMIT</token>
			<token rule="FunctionKW">SQLCON</token>
			<token rule="FunctionKW">SQLCONNECT</token>
			<token rule="FunctionKW">SQLD</token>
			<token rule="FunctionKW">SQLDISCONNECT</token>
			<token rule="FunctionKW">SQLE</token>
			<token rule="FunctionKW">SQLEXEC</token>
			<token rule="FunctionKW">SQLG</token>
			<token rule="FunctionKW">SQLGETPROP</token>
			<token rule="FunctionKW">SQLI</token>
			<token rule="FunctionKW">SQLIDLEDISCONNECT</token>
			<token rule="FunctionKW">SQLM</token>
			<token rule="FunctionKW">SQLMORERESULTS</token>
			<token rule="FunctionKW">SQLP</token>
			<token rule="FunctionKW">SQLPREPARE</token>
			<token rule="FunctionKW">SQLR</token>
			<token rule="FunctionKW">SQLROLLBACK</token>
			<token rule="FunctionKW">SQLSE</token>
			<token rule="FunctionKW">SQLSETPROP</token>
			<token rule="FunctionKW">SQLST</token>
			<token rule="FunctionKW">SQLSTRINGCONNECT</token>
			<token rule="FunctionKW">SQLT</token>
			<token rule="FunctionKW">SQLTABLES</token>
			<token rule="FunctionKW">SQRT</token>
			<token rule="FunctionKW">SROW</token>
			<token rule="FunctionKW">SROWS</token>
			<token rule="FunctionKW">STR</token>
			<token rule="FunctionKW">STRC</token>
			<token rule="FunctionKW">STRCONV</token>
			<token rule="FunctionKW">STRE</token>
			<token rule="FunctionKW">STREXTRACT</token>
			<token rule="FunctionKW">STRT</token>
			<token rule="FunctionKW">STRTO</token>
			<token rule="FunctionKW">STRTOFILE</token>
			<token rule="FunctionKW">STRTR</token>
			<token rule="FunctionKW">STRTRAN</token>
			<token rule="FunctionKW">STUF</token>
			<token rule="FunctionKW">STUFF</token>
			<token rule="FunctionKW">STUFFC</token>
			<token rule="FunctionKW">SUBS</token>
			<token rule="FunctionKW">SUBSTR</token>
			<token rule="FunctionKW">SUBSTRC</token>
			<token rule="FunctionKW">SYSMETRIC</token>
			<token rule="FunctionKW">TABLEREFRESH</token>
			<token rule="FunctionKW">TABLEREVERT</token>
			<token rule="FunctionKW">TABLEU</token>
			<token rule="FunctionKW">TABLEUPDATE</token>
			<token rule="FunctionKW">TAGC</token>
			<token rule="FunctionKW">TAGCOUNT</token>
			<token rule="FunctionKW">TAGN</token>
			<token rule="FunctionKW">TAGNO</token>
			<token rule="FunctionKW">TAN</token>
			<token rule="FunctionKW">TARG</token>
			<token rule="FunctionKW">TARGET</token>
			<token rule="FunctionKW">TIME</token>
			<token rule="FunctionKW">TRAN</token>
			<token rule="FunctionKW">TRANSFORM</token>
			<token rule="FunctionKW">TRIM</token>
			<token rule="FunctionKW">TTOC</token>
			<token rule="FunctionKW">TTOD</token>
			<token rule="FunctionKW">TXNL</token>
			<token rule="FunctionKW">TXNLEVEL</token>
			<token rule="FunctionKW">TXNLEVEL</token>
			<token rule="FunctionKW">TXTW</token>
			<token rule="FunctionKW">TXTWIDTH</token>
			<token rule="FunctionKW">TYPEAHEAD</token>
			<token rule="FunctionKW">UNBI</token>
			<token rule="FunctionKW">UNBINDEVENT</token>
			<token rule="FunctionKW">UNBINDEVENTS</token>
			<token rule="FunctionKW">UNPACK</token>
			<token rule="FunctCmdKW">UPDATE</token>
			<token rule="FunctionKW">UPDATED</token>
			<token rule="FunctionKW">UPPE</token>
			<token rule="FunctionKW">UPPER</token>
			<token rule="FunctionKW">USED</token>
			<token rule="FunctionKW">VAL</token>
			<token rule="FunctionKW">VARREAD</token>
			<token rule="FunctionKW">VART</token>
			<token rule="FunctionKW">VARTYPE</token>
			<token rule="FunctionKW">VERS</token>
			<token rule="FunctionKW">VERSION</token>
			<token rule="FunctionKW">WBOR</token>
			<token rule="FunctionKW">WBORDER</token>
			<token rule="FunctionKW">WCHI</token>
			<token rule="FunctionKW">WCHILD</token>
			<token rule="FunctionKW">WCOL</token>
			<token rule="FunctionKW">WCOLS</token>
			<token rule="FunctionKW">WDOC</token>
			<token rule="FunctionKW">WDOCKABLE</token>
			<token rule="FunctionKW">WEEK</token>
			<token rule="FunctionKW">WEXI</token>
			<token rule="FunctionKW">WEXIST</token>
			<token rule="FunctionKW">WFON</token>
			<token rule="FunctionKW">WFONT</token>
			<token rule="FunctionKW">WLAS</token>
			<token rule="FunctionKW">WLAST</token>
			<token rule="FunctionKW">WLCO</token>
			<token rule="FunctionKW">WLCOL</token>
			<token rule="FunctionKW">WLRO</token>
			<token rule="FunctionKW">WLROW</token>
			<token rule="FunctionKW">WMAX</token>
			<token rule="FunctionKW">WMAXIMUM</token>
			<token rule="FunctionKW">WMIN</token>
			<token rule="FunctionKW">WMINIMUM</token>
			<token rule="FunctionKW">WONT</token>
			<token rule="FunctionKW">WONTOP</token>
			<token rule="FunctionKW">WOUT</token>
			<token rule="FunctionKW">WOUTPUT</token>
			<token rule="FunctionKW">WPAR</token>
			<token rule="FunctionKW">WPARENT</token>
			<token rule="FunctionKW">WREAD</token>
			<token rule="FunctionKW">WROW</token>
			<token rule="FunctionKW">WROWS</token>
			<token rule="FunctionKW">WTIT</token>
			<token rule="FunctionKW">WTITLE</token>
			<token rule="FunctionKW">WVIS</token>
			<token rule="FunctionKW">WVISIBLE</token>
			<token rule="FunctionKW">XMLT</token>
			<token rule="FunctionKW">XMLTOCURSOR</token>
			<token rule="FunctionKW">XMLU</token>
			<token rule="FunctionKW">XMLUPDATEGRAM</token>
			<token rule="FunctionKW">XMLUPDATEGRAM</token>
			<token rule="FunctionKW">YEAR</token>
		</tokens>
	</tokenset>
	<tokenset name="Operators" id="operators" forecolor="red">
		<validscope name=""/>
		<validscope name="Scope Keywords"/>
		<validscope name="Parameter Block"/>
		<tokens>
			<token action="ListMembers">.</token>
			<token action="CommitMember">=</token>
			<token action="CommitMember">+</token>
			<token action="CommitMember">-</token>
			<token action="CommitMember">*</token>
			<token action="CommitMember">/</token>
			<token action="CommitMember">#</token>
			<token action="CommitMember">!</token>
			<token action="CommitMember">$</token>
			<token action="CommitMember">^</token>
			<token action="CommitMember">%</token>
			<token rule="CommandsKW">OR</token>
			<token>AND</token>
			<token>.NOT.</token>
			<token>.NULL.</token>
			<token>.OR.</token>
			<token>.F.</token>
			<token>.T.</token>
			<token>==</token>
			<token>!=</token>
			<token>&lt;</token>
			<token>&lt;=</token>
			<token>&gt;</token>
			<token>&gt;=</token>
			<token>&lt;&gt;</token>
			<token>:</token>
			<token>;</token>
			<token>@</token>
			<token>\</token>
			<token>\\</token>
		</tokens>
	</tokenset>
	<tokenset name="Numbers" id="numbers" forecolor="black">
		<validscope name=""/>
		<validscope name="Scope Keywords"/>
		<validscope name="Parameter Block"/>
		<tokens regexp="yes">
			<token>&amp;H[a-fA-F0-9]+</token>
			<token>-?\d+(\.\d*)?([eE]-?\d+)?</token>
			<token>&amp;O[0-7]+</token>
		</tokens>
	</tokenset>
	<tokenset name="Define Names" id="unknown" normalizecase="no" forecolor="26367">
		<validscope name=""/>
		<validscope name="Scope Keywords"/>
		<validscope name="Parameter Block"/>
		<tokens>
			<token>GREG4KIM</token>
		</tokens>
	</tokenset>
	<tokenset name="Selected Variable" id="unknown" normalizecase="no" forecolor="black" backcolor="cyan">
		<validscope name=""/>
		<validscope name="Scope Keywords"/>
		<validscope name="Parameter Block"/>
		<tokens>
			<token>GKKGKK</token>
		</tokens>
	</tokenset>
	<tokenset name="Text" id="text" normalizecase="no">
		<validscope name=""/>
		<validscope name="Scope Keywords"/>
	</tokenset>
</language>  %   ,  �  9       LaI�  �  U    T�  � �a�� U  THIS FONTBOLD  T�  � �-�� U  THIS FONTBOLD$  ��  � � � � T� � �a�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS FONTBOLD$  ��  � � � � T� � �-�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS FONTBOLD GotFocus,      	 LostFocusQ      
 MouseEnterv      
 MouseLeave�      Y  T�  �a�� T� ��	 GKKOption�� T� �� ��
 ��    �
 ��    �
 ��    �
 ��    � U  AUTOSIZE CAPTION	 BACKSTYLE	 GKKOption OptionButtony    > � 2 � 2 1� 2 1� 2 � a� � � � � 4                    Y  n        �  �        �          1  w          �  
      %   �      C  /   �  8LaI  �  U  � ��  � � � �� � � � � � T� �C�� %�C� gkkuser� ���� H�W ��� �C� ��� C��{ � T� �C� ��� �C� ��� N��� � T� �C� 8�� T� �� � �'�� T� �C� _� .C� _�� �C� ��� D��� � T� �C� *�� �C� ��� T��� T� �C� ��� �C� ��� L��g� %�� ��K� T� �� .T.�� �c� T� �� .F.�� � �C� ��� Y���� T� �C� _�� 2��� T� �� �� � T�	 �CCC��C� �\]�g�� F�
 �> -�� � GKKSETTINGS� C� �C�  f	� C� �C� f	� C'
	�� %�C4��@� >�
 � ��� �� >�
 � ���	 �� >�
 � ��C$�� ���\ r�� gkkuser� � � � � � ��� GKKSETTINGS��C�  f��C� f��� ���	 ��C$�� � %�C� �
����
 F�� �� � Q�
 � T� �a�� ��� T� �-�� �	 B�� �� U  TCSUBKEY TCENTRY
 TCSTRVALUE LCALIAS LCSTRBUFFER
 LNINTVALUE
 LNDECVALUE LLRETURN GKKGETRESOURCE LNCKVAL GKKUSER TYPE ID NAME DATA CKVAL UPDATED GKKSetString_VFP,     ��= � q� �� Q� Q� q�Q� QQ� � A Q� � � A �r �� � � �A � A � � � � A � 1                    6  L	        %   �      �     �  KaIR  �  U   ��  � � �� � � T� �C�� %�C� gkkuser� ��� � F� �> -�� � GKKSETTINGS� C� �C�  f	� C� �C� f	� C'
	�� %�C4��� � T� �C� �	 ��� �� � T� ��  �� � %�C� �
��� �
 F�� �� � Q� � �� � T� ��  �� �	 B�� �� U
  TCSUBKEY TCENTRY LCRETURN LCALIAS GKKGETRESOURCE GKKUSER TYPE ID NAME DATA GKKGetString_VFP,     ��: � � � �q �� !� � A � A � � � A � 1                    
  �  
   BM�      6   (      #         �  �  �          ���������   ������B0)   ���B0)B0)   ���������   ���������   ������B0)   ���B0)B0)   ���������   ���������   ������B0)   ���B0)B0)   ���������   ���������   ������B0)   ���B0)B0)   ���������   ���������   ������B0)   ���B0)B0)   ���������   ���������   ������B0)   ���B0)B0)   ���������   ���������   ������B0)   ���B0)B0)   ���������   ���������   ������B0)   ���B0)B0)   ���������   ���������   ������B0)   ���B0)B0)   0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _2590VCE181254054023�      W  �      �      b  �          �  �  �          x      X       COMMENT RESERVED                        B                                                                  d                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      "  ..\programs\gkkdefines.h�p��fF      windowposition      ..\programs\gkkdefines.h      Pixels      Class      1      label      windowposition      �_memberdata XML Metadata for customizable properties
*save Saves the current form position
*restore Restores the form position from saved
*checkwindowpos Checks if window already at position
     ����    �  �                        �$   %   �      ^  K   �          �  U  � ��  � � � � ��� ���� %�C� � FormName��h��L � T� ��� �� �b � T� ��� �� � T� ��� �� T� ��� �� %�C� �	 oToolBars��h��b� ��	 ���(�C��
 ����^� %�CC �	 ��
 ��� O��Z� H�� �V� �CC �	 ��
 � � ����� T� �� C �	 ��
 � �� �CC �	 ��
 � �����V� T� �� C �	 ��
 � �� � � �� �M T�  �C�� _� ;C�� _� ;C� _� ;C� _� ;C�� _� ;CC�P� _��/ ��C� EditForm� � -WindowPosition �  � �� �� U  LCWINDOW
 LCFORMNAME LNWIDTH LNHEIGHT THISFORM FORMNAME NAME HEIGHT WIDTH LNNDX	 OTOOLBARS DOCKPOSITION TOP LEFT WINDOWSTATE APIGETSYSTEMMETRICS GKKSETSTRING_VFP�# ��  � � � � � � � � ��� ���� %�C� � FormName��h��\ � T� ���	 �� �r � T� ���
 �� �/ T�  �C� EditForm� � -WindowPosition� �� %�C�  ���� � T� �-�� ��� T� �CC�  �� ;��g�� T� �CC�  �� ;��g�� T� �CC�  �� ;��g�� T� �CC�  �� ;��g�� T� �CC�  �� ;��g�� %�� C�N� ��� T� ���� T� ���� %�� C��%���� T� �C��%��� %�� � � ���� T� �� � �� � � %�� C��%��� T� �C��%� �
�� %�� � � ��� T� �� � �� � � � +�C �  � � ��b� T� �� C�	�%�� T� �� C�	�%�� � T�� �� �� T�� �� �� %��� ����� T�� �� �� T�� �� �� � T�� �� �� T� �a�� � ��C�� �� ��	 B�� �� U  LCWINDOW LLRETURN LNTOP LNLEFT LNWIDTH LNHEIGHT
 LCFORMNAME	 LNWINSTAT THISFORM FORMNAME NAME GKKGETSTRING_VFP APIGETSYSTEMMETRICS MINWIDTH	 MINHEIGHT GKKGETVFPFORMS TOP LEFT BORDERSTYLE WIDTH HEIGHT WINDOWSTATE RESIZE save,     �� restore�    ��1 1� �� � � A � � ���� ����A A A A ��A 2 1� �� � � A �� � � �����Q� � AAAA A A�AA A A rAAA � � !� � A � � A � A � 1                       �        �  	      )   �                       	�PROCEDURE save
LOCAL lcWindow, lcFormName, lnWidth, lnHeight
WITH thisform
	IF PEMSTATUS(thisform, "FormName", 5)
		lcFormName = .FormName
	ELSE
		lcFormName = .Name
	ENDIF
	lnHeight = .Height
	lnWidth  = .Width
	IF PEMSTATUS(thisform, "oToolBars", 5)
		FOR lnNdx=1 TO ALEN(.oToolBars, 1)
			IF VARTYPE(.oToolBars[lnNdx]) = "O"
				DO CASE
					CASE INLIST(.oToolBars[lnNdx].DockPosition, TOOL_TOP, TOOL_BOTTOM)
						lnHeight = lnHeight + .oToolBars[lnNdx].Height
					
					CASE INLIST(.oToolBars[lnNdx].DockPosition, TOOL_LEFT, TOOL_RIGHT)
						lnWidth = lnWidth + .oToolBars[lnNdx].Width
				ENDCASE
			ENDIF
		ENDFOR
	ENDIF
	lcWindow = TRANSFORM(.Top) + ';' + TRANSFORM(.Left) + ';' + TRANSFORM(lnWidth) + ';' + TRANSFORM(lnHeight) + ';' + TRANSFORM(.WindowState) + ";" + TRANSFORM(apiGetSystemMetrics(SM_CMONITORS))
	=GKKSetString_VFP("EditForm", lcFormName+"-WindowPosition", lcWindow)
ENDWITH
ENDPROC
PROCEDURE restore
LOCAL lcWindow, llReturn, lnTop, lnLeft, lnWidth, lnHeight, lcFormName, lnWinStat
WITH thisform
	IF PEMSTATUS(thisform, "FormName", 5)
		lcFormName = .FormName
	ELSE
		lcFormName = .Name
	ENDIF
	lcWindow = GKKGetString_VFP("EditForm", lcFormName+"-WindowPosition")
	IF EMPTY(lcWindow)
		llReturn = False
	ELSE
		lnTop     = VAL(GETWORDNUM(lcWindow, 1, ";"))
		lnLeft    = VAL(GETWORDNUM(lcWindow, 2, ";"))
		lnWidth   = VAL(GETWORDNUM(lcWindow, 3, ";"))
		lnHeight  = VAL(GETWORDNUM(lcWindow, 4, ";"))
		lnWinStat = VAL(GETWORDNUM(lcWindow, 5, ";"))
		IF lnLeft >= apiGetSystemMetrics(SM_CXVIRTUALSCREEN)
*-*			Adjust restore position - previously on two monitors, now one monitor
			lnTop  = 4
			lnLeft = 4
			IF lnWidth > SYSMETRIC(1)
				lnWidth = SYSMETRIC(1) - 8
				IF lnWidth < thisform.MinWidth
					lnWidth = thisform.MinWidth
				ENDIF
			ENDIF
			IF lnHeight > SYSMETRIC(2)
				lnHeight = SYSMETRIC(2) - lnTop - 10
				IF lnHeight < thisform.MinHeight
					lnHeight = thisform.MinHeight
				ENDIF
			ENDIF
		ENDIF
*-*		Check if a form window at the left and top coordinates
		DO WHILE GKKGetVFPForms(lnLeft, lnTop)
			lnLeft = lnLeft + SYSMETRIC(9)
			lnTop  = lnTop  + SYSMETRIC(9)
		ENDDO
*-*		Restore window position
		.Top  = lnTop
		.Left = lnLeft
		IF .BorderStyle != 2
			.Width  = lnWidth
			.Height = lnHeight
		ENDIF
		.WindowState = lnWinStat
		llReturn = True
	ENDIF
	.Resize()
ENDWITH
RETURN llReturn
ENDPROC
     [AutoSize = .T.
Caption = "WindowPosition"
Height = 17
Visible = .F.
Width = 91
_memberdata =      209<VFPData><memberdata name="save" type="method" display="Save"/><memberdata name="restore" type="method" display="Restore"/><memberdata name="checkwindowpos" type="method" display="CheckWindowPos"/></VFPData>

Name = "windowposition"
      labelBMz      6   (   #            D  �  �          ���������������������������������������������������������������������������������������������������������   B0)���������B0)���������B0)���������B0)���������B0)���������B0)���������B0)���������B0)���������B0)������   B0)B0)������B0)B0)������B0)B0)������B0)B0)������B0)B0)������B0)B0)������B0)B0)������B0)B0)������B0)B0)���      %           3     �JaI�  �  U  � ��  � �� � � � �  %�C�t� � C�  ��� C��N � T�  �� gkkuser�� � %�C�  ���l � T� �a�� ��� T� �-�� T� �-�� T� �C� �  � .dbf�� +�� 
� � 
	���� ��� � Q�  ��� ����  �� T� �a�� �(� ��� H�� ��� �� � ����� ��w� F�  � H�0�d� �C�  @� gkkuser����` h1�� ��� � C���� � C����	 � M�
 � L� � N����� �� � M� � D� F� � & �� ��� � & �� ��� � �C�  @� gkkobjs��d�Z h1�� ��� � C���� � C��d�� � C��
�� � M� � M� � M� � T� F� � & �� ��� � & �� ��� � � Q� T� �a�� �(� ��� T� �a�� ��C� � � �� �� 2��� T� �a�� ��C� � � �� � �� %�� ���� !� � � �	 B�� �� U  TCALIAS LLOPENED LOEXCEPTION LCGKKRESOURCE LLERROR GKKGETCONFIGPATH ERRORNO TYPE ID NAME READONLY CKVAL DATA UPDATED GKKUSER OTYPE ONAME OMETHODS OPROPERTIES OEVENTS GKKOBJS GKKDISPLAYMSG MESSAGE GKKGetResource,     ��= q 1AA � � � � � �q� �� � � A� � � �q � � ��q � � B A � � � A � � A A � A A A A � 1                      �       %   �  �  n  ;   �  KaI  �  U   ��  � �# �� � � � � � � �	 � T� �-�� %��  � � � � 	���) h��	 c_wintext� � I� � C����� T� �C� Twindow�C� � �N�� T� �C� �� T� �C � �� �� T� �C � �� �� T� �� �� +�a��V� T�	 �C � � ��( r��	 c_wintext� � ��� ���	 �� %�� � ��=� !� � T� �C � �� �� � F�
 � ~�C� �
���� T� �CC�  �Q�� ��C�
 � � � �� T� �CC� ��\� �� T� �CC� ��\� �� %�� �  � � � 	���� T� �a�� !� � � Q� �	 B�� �� U  TNLEFT TNTOP LLFOUND LOWINDOW LOFORM	 LHDESKTOP LHFIRSTCHILD LHLASTCHILD	 LHCURRENT LCWINCAP	 C_WINTEXT	 WINHANDLE WINTITLE HWND APIGETDESKTOPWINDOW APIGETWINDOW
 GETWINTEXT LPRECT APIGETWINDOWRECT LNLEFT	 BUF2DWORD LNTOPY  ��  �O B�CC�  ��\CCC�  ��\��CCC�  ��\��CCC�  ��\���� U  LCBUFFERO  ��  � �� � � T� �C��X�� T� �C �  � C� >� �� B�CC� � =f�� U  PHHDL LCBUFFER LNRESULT APIGETWINDOWTEXT�  ��  � � �� � � � � � %��  � ��: � B�-�� � T� �C �  � ��( r��	 c_wintext� �	 ���  ��� �� T� �C �  ��
 �� T� �C� Twindow �  �  �N�� %�� � ��� � T� �C �  ��
 �� T� �C� Twindow �  � �N�� � U  TNHANDLE TNPARENT LHCHILD LOCHILD LHNEXT LONEXT LCWINCAP
 GETWINTEXT	 WINHANDLE WINTITLE APIGETWINDOW GKKGetVFPForms,     ��	 Buf2Dword1    ��
 GetWinText�    �� Init      
 ��    � U   Twindow Custom�    : � 1� ���� QQ� � !�A A QA r AA���� A A A A A � 7 q �7 q � � �7 � qq A !�Q�Q�A 2 � ?                      �  
   "   x  G  8   %   �  �	  C   +   j
  B  O   9   X
  L  N      %   U      �  (   j  KaI1  �  U  � ��  � �� � � � � � � � T� �a�� %�C�  ���
���� T� �C� \�  ��� %�C�  �=� \\��} � T� ���� �� � %�C�  ��\� :��� � T� ���� �� � T� �-�� � � T� �C�  C� \�  � ��=�� +�� � ���� ��"� %�C� ���
���
 ��� �� � �(� �9� T� �-�� �� %�� 
��O� !� � T� �� ��� T� �C�  C� \�  � ��=�� � %�� ���� ����
 ���  �� �(� ��� T� �-�� �� � �	 B�� �� U  TCDIRECTORY	 LLSUCCESS LCPATH LNLEN LNNDX LOEXCEPTION LNSLASH
 LNSLASHCNT GKKMakePath,     ��= q �� A1�� � �� � � A A �!� A� A � � A � A A �A � � � � � A A A � 1                      �        %   �       �      �   �h1IZ  �  U  H  ��  �' � GKKDisplayMsg���      �?��  � ��C�����MbP?� H7�� U 	 TCMESSAGE GKKDISPLAYMSG GKKDisplayMsg,     ��; q qq1                    �  H     0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Screen                                                                                            WINDOWS _0420NWASD 6832356168      O  f      }                          �      �                       WINDOWS _0420NWASX1091282962�      �              N  �                  �                           WINDOWS _0420NWASX 978884962�      �  �  �  �                                                           WINDOWS _0420O4GWD 9788849621      >  K  Y  n                                                           WINDOWS _0420NWASD 978884962�      �  �  �  .                                                           WINDOWS _37O0LYFBI1089776963  �  �  �  �  i      �  a
                                               COMMENT RESERVED                                �                      �                                    �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      ..\programs\gkkdefines.h      dataenvironment      dataenvironment      Dataenvironment      YTop = 0
Left = 0
Width = 0
Height = 0
DataSource = .NULL.
Name = "Dataenvironment"
      1      1      form      form      GKKDISPLAYMSG     )BorderStyle = 2
Height = 38
Width = 402
Desktop = .F.
ShowWindow = 1
DoCreate = .T.
AutoCenter = .T.
Caption = "Form1"
FontSize = 10
MaxButton = .F.
MinButton = .F.
Icon = ..\graphics\gkkgkk.ico
TitleBar = 0
AlwaysOnTop = .T.
AllowOutput = .F.
rtnvalue = 0
_memberdata =      227<VFPData><memberdata name="rtnvalue" type="property" display="RtnValue"/><memberdata name="gettextwidth" type="method" display="GetTextWidth"/><memberdata name="updatecaption" type="method" display="UpdateCaption"/></VFPData>

Name = "GKKDISPLAYMSG"
     PROCEDURE gettextwidth
LPARAMETERS tcFontName,tnFontSize,tnFontStyle,tcText
RETURN FONTMETRIC(6,tcFontName,tnFontSize,tnFontStyle) * LEN(tcText) * 1.3
ENDPROC
PROCEDURE updatecaption
LPARAMETERS tcMsgText
thisform.lblMsgText.Caption = tcMsgText
ENDPROC
PROCEDURE Init
LPARAMETERS tnMsgInterval, tcMsgText
WITH thisform
	.lblMsgText.Caption = tcMsgText
	.lblMsgText.Width   = MAX(.GetTextWidth(.lblMsgText.FontName,.lblMsgText.FontSize,"N",tcMsgText), 200)
	.Container1.Width   = .lblMsgText.Width + 14
	.Width = .Container1.Left + .Container1.Width + 7
	INKEY(0.001,"H")
	IF tnMsgInterval > 0
		.clsMsgTimer.Interval = tnMsgInterval
		.clsMsgTimer.Active = True
	ENDIF
	IF tcMsgText = "Show OffScreen"
		.Left = -50
		.Top  = -50
	ENDIF
ENDWITH
ENDPROC
     #���    
  
                        ��   %   �       �      �           �  U  4  ��  � � � � T� � �-�� <� �	 B�� �� U  THWND TNMSG TWPARAM TLPARAM THIS ACTIVE THISFORM ontimerinterval,     ��1 1� q � 1                       v       )   
                        "  ..\programs\gkkdefines.h�p��fF      "Arial, 0, 10, 6, 16, 13, 35, 3, 0
      �PROCEDURE ontimerinterval
LPARAMETERS thWnd, tnMsg, twParam, tlParam
this.Active = False
RELEASE thisform
RETURN 0
ENDPROC
      VCaption = "clsMsgTimer"
Left = 316
Top = 11
interval = 1500
Name = "clsMsgTimer"
      GKKDISPLAYMSG      clsMsgTimer      label      ..\classes\gkkapitimer.vcx      apitimer      �FontBold = .T.
FontSize = 10
BackStyle = 0
Caption = "MsgText"
Height = 18
Left = 50
Top = 10
Width = 344
Name = "lblMsgText"
      GKKDISPLAYMSG      
lblMsgText      label      �rtnvalue RtnValue
_memberdata XML Metadata for customizable properties
*gettextwidth GetTextWidth
*updatecaption Updates the caption display
      	container      	container      
Container1      GKKDISPLAYMSG      VTop = 3
Left = 44
Width = 356
Height = 32
SpecialEffect = 1
Name = "Container1"
      image      image      Image1      GKKDISPLAYMSG      oPicture = ..\graphics\gkkinfo.bmp
BackStyle = 0
Height = 36
Left = 2
Top = 1
Width = 36
Name = "Image1"
      label     ����    w  w                        �
   %   �           �          �  U  =  ��  � � � �' B�C��  � � �$C� >��������?�� U 
 TCFONTNAME
 TNFONTSIZE TNFONTSTYLE TCTEXT  ��  � T� � � ��  �� U 	 TCMSGTEXT THISFORM
 LBLMSGTEXT CAPTION" ��  � � ��� ��� T�� � �� ��. T�� � �CC�� � �� � � N � �� ��D�� T��	 � ��� � ��� T�� ���	 �
 ��	 � ��� ��C�����MbP?� H7�� %��  � ��� � T�� � ��  �� T�� � �a�� � %�� � Show OffScreen��� T��
 ������ T�� ������ � �� U  TNMSGINTERVAL	 TCMSGTEXT THISFORM
 LBLMSGTEXT CAPTION WIDTH GETTEXTWIDTH FONTNAME FONTSIZE
 CONTAINER1 LEFT CLSMSGTIMER INTERVAL ACTIVE TOP gettextwidth,     �� updatecaption�     �� Init�     ��1 1q2 q 12 � � ���q� A �� � A A 1                       �         �   �              	    )   w                  BMF      v   (   $   $                                   �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� �����������������������������������������������    ��������������� DDDD ������������DDDDDD@����������DDDDDDDD@����������DDO������D��������DDO������D@��������DDDO������DD������DDDDD���DDDD@������DDDDD���DDDD@������DDDDDD���DDDDD�����DDDDDD���DDDDD�����DDDDDD���DDDDD����DDDDDD���DDDDD@����DDDDDD���DDDDD@����DDDDDD���DDDDD@����DDDDDD���DDDDD@����DDDDDD���DDDDD@����DDDDDD���DDDDD@����DDDDDD���DDDDD@����DDDDO����DDDDD@�����DDDDO����DDDDD�����DDDDDDDDDDDDDD�����DDDDDDDDDDDDDD�����DDDDD��DDDDD@������DDDDO���DDDD@�������DDDD����DDDD�������DDD����DDD@���������DDD����DDD���������DDO���DD@����������DD��DD@������������ DDDD ��������������    ����������������������������������������������� 0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _37K0PIHDB1091335498�      X  �      �  r  �
  �          �  �            �      R       COMMENT RESERVED                        B                                                                  e                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      "  ..\programs\gkkdefines.h�p��fF      apitimer      ..\programs\gkkdefines.h      Pinitializetimer^
cleartimer^
interval_assign^
active_assign^
Init
Destroy
      Pixels      Class      1      label      apitimer     �timerid Numeric Timer ID
_memberdata XML Metadata for customizable properties
hwnd Handle to Timer
interval Interval of timer; value assigned in seconds and displayed in milliseconds; default is 30min
active Indicates that the timer is active
*ontimerinterval Occurs when the Timer interval completes
*initializetimer Initializes the timer
*cleartimer Clears the timer function
*interval_assign 
*active_assign 
     ����    �  �                        �1   %           /   �          �  U  E  ��  � � � �" %�� � �  � � � � 	��5 � �	 B�� �� U  THWND TNMSG	 TNTIMERID TLPARAM THIS HWND TIMERID� $ %�C�  � apiTimerCount��h
��C � ��C�  � apiTimerCount� 
�� � %�� � ��� � T�  � ��  � ���( ��C� � �� � OnTimerInterval�� ��C� � � � � � � � �� � U  THISFORM THIS ACTIVE APITIMERCOUNT HWND APISETTIMER TIMERID INTERVAL~  ��C� � � � �  ��# %�C� � apiTimerCount��h��w � T� � �� � ��� %�� � � ��s � ��C� � �� � � U  APIKILLTIMER THIS HWND TIMERID THISFORM APITIMERCOUNT�  ��  � T�  ��  ���� H�& �� � ��  �
��G � T� � ��
�� ��  �
�����n � T� � ��
����� 2�� � T� � ��  �� � U 
 TNINTERVAL THIS INTERVALM  ��  � T� � ��  �� %��  ��1 � ��C� � �� �F � ��C� � �� � U  TLACTIVE THIS ACTIVE INITIALIZETIMER
 CLEARTIMER)  T�  � �� � �� T�  � ��  � �� U  THIS HWND THISFORM INTERVAL  ��C�  � �� U  THIS
 CLEARTIMER ontimerinterval,     �� initializetimer�     ��
 cleartimer�    �� interval_assignw    �� active_assign$    �� Init�    �� Destroy�    ��1 1!B � 2 A�A q��A 2 a1qA� A A 2 q !� B1� A 2 q � � � � A 3 112 � 1                       �         �   �        �  �        �       "   A  �  )   *   �  	  3   -   '  8  7    )   �                       CPROCEDURE ontimerinterval
LPARAMETERS thWnd, tnMsg, tnTimerID, tlParam
IF this.hWnd = thWnd .AND. this.TimerID = tnTimerID

ENDIF
RETURN 0
ENDPROC
PROCEDURE initializetimer
IF !PEMSTATUS(thisform,"apiTimerCount",5)
	ADDPROPERTY(thisform,"apiTimerCount",0)
ENDIF
IF this.Active
	thisform.apiTimerCount = thisform.apiTimerCount + 1
	BINDEVENT(this.hWnd, WM_TIMER, This, 'OnTimerInterval')
	apiSetTimer(this.hWnd, this.TimerID, this.Interval, 0)
ENDIF
ENDPROC
PROCEDURE cleartimer
apiKillTimer(this.hWnd, this.TimerID)
IF PEMSTATUS(thisform,"apiTimerCount",5)
	thisform.apiTimerCount = thisform.apiTimerCount - 1
	IF thisform.apiTimerCount = 0
		UNBINDEVENTS(this.hWnd)
	ENDIF
ENDIF
ENDPROC
PROCEDURE interval_assign
LPARAMETERS tnInterval
tnInterval = tnInterval * 1000     && Convert seconds to milli-seconds
DO CASE
	CASE tnInterval < USER_TIMER_MINIMUM
		this.Interval = USER_TIMER_MINIMUM

	CASE tnInterval > USER_TIMER_MAXIMUM
		this.Interval = USER_TIMER_MAXIMUM

	OTHERWISE
		this.Interval = tnInterval
ENDCASE
ENDPROC
PROCEDURE active_assign
LPARAMETERS tlActive
this.Active = tlActive
IF tlActive
	this.InitializeTimer()
ELSE
	this.ClearTimer()
ENDIF

ENDPROC
PROCEDURE Init
this.hWnd = thisform.hWnd
this.Interval = this.Interval
ENDPROC
PROCEDURE Destroy
this.ClearTimer()
ENDPROC
     rAutoSize = .T.
BackStyle = 0
Caption = "apiTimer"
Height = 17
Visible = .F.
Width = 51
timerid = 0
_memberdata =      685<VFPData><memberdata name="timerid" type="property" display="TimerID"/><memberdata name="hwnd" type="property" display="hWnd"/><memberdata name="interval" type="property" display="Interval"/><memberdata name="ontimerinterval" type="method" display="OnTimerInterval"/><memberdata name="initializetimer" type="method" display="InitializeTimer"/><memberdata name="cleartimer" type="method" display="ClearTimer"/><memberdata name="interval_assign" display="Interval_Assign"/><memberdata name="active" type="property" display="Active"/><memberdata name="active_assign" display="Active_Assign"/><memberdata name="destroy" display="Destroy"/><memberdata name="init" display="Init"/></VFPData>
hwnd = 0
interval = 900000
active = .F.
Name = "apitimer"
      labelBM6      6   (                              ������������������������������������������������������������������  ����������������������������������������������  �  �������������������  �������������������������  �  ����������������  �������������������������  �  ����������  �  �������������������������������  �  �������  �  ����������                  ���  �  �  �  �  �������������   ������������   ������  �  �  ����������������   ������������   ���  �  �  �  ����������������   ������������        �        �  ��������������  �  �  �  �    �  �  ����   ���  �  �����������  �  �  �  �  �  ���������   ������  �  �������������������   ������������   �������������������������������  �  �  �  �  �  �������������������������������  �  �  �  �  �  ���������������������������������������������������������������BM�      6   (               �              ����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������G�G�G�G�G�G�G�G�G�G�G�G�G�G�������������������G����W3�������������������������W3����G�������������������G�rO�W3�������������������������W3�rO�G�������������������G�rO�W3�������������������������W3�rO�G�������������������G�rO�W3�������������������������W3�rO�G�������������������G�rO�W3�������������������������W3�rO�G�������������������G�tQ�W3�������������������������W3�tQ�G�������������������G�wV�]:�W3�W3�W3�W3�W3�W3�W3�W3�]:�wV�G�������������������G�_�_�_�_�_�_�_�_�_�_�_�_�G�������������������G��l��u��|��|��|��|��|��|��|��|��y��l�G�������������������G��~��c��c�X4Ž�Ž�Ž�Ž�Ž�Ž�Ž���w�G�������������������G�����c��c�X4��������������c�X4�������G�������������������G�����c��c�X4��������������c�a?�������G�������������������G�Ÿ��h��c�X4����������������������}c�G�������������������G�G�G�G�G�G�G�G�G�G�G�G�G������������������������������������������������������������������������������������������������������������������������������������BM6      6   (                              �������������������������������������������������� �� �� �� �� }� z� x� u� r� o� m� i�p������� ��N��?��'����������
�������� �� �������� ��T��z��l��c��U��G��>��0��#��������
�������� ��,�և��z��l��c��U��G��>��0��#��������|���� �� �ǉ�����z��l��c��U��G��>��0��#����,������� ��	��_�������z��l��c��U��G��>��0��
��?��,����� ����0�ڙ��������z��l��c��U��G��>����K��V��{� ��E���� �� �� �� �� �� �� �� �� �� }� z� x�}� ��`��S��K��@��5��-�� �������� �� y���������� ��v��i��c��V��K��B��6��-��"������ {���������� �ˍ�����v��m��c��V��O������ �� ��`�����������@��:�ߗ��������z��m��&��`��������������������������@�� �� �� �� �� ��P��������������������������������������������������������������������������������������������������������������������������BM6      6   (                              �gŁF�|H�yI�uJ�pM�mM�jN�eQ�`Rf33���������������шA��������������������������k51���������������ٌ@����̙�̙�̙�̙�̙�̙�̙���u:,�mM�jN�eQ�`Rf33ڏC���������������������������@&�����������k51ޗO����̙�̙�̙�̙�̙�̙�̙��ЈD"�̙�̙�̙���u:,�[��������������������������֎G������������@&�g����̙�̙�̙�̙�̙�̙�̙��ޘM�̙�̙�̙��ЈD"�n���������������������������Q�����������֎G�{���������������������������T�̙�̙�̙��ޘM�����������������a�m'�W�Q�Y������������Q�Ē����������������w(��>�u �eԚf������������T�Ț���������������Ņ0��y��!ߟa����a�m'�W�Q�Y�Х���������������͏5�S�l�������w(��>�u �eԚf�ʕ����w�l�\�M��=����������Ņ0��y��!ߟa�������������������Х���������������͏5�S�l����������������������ʕ����w�l�\�M��=����������   %   -      c     G  �JaI  �  U  �  ��  � T�  �C��X�� %�C� �  �� � ���D � T�  �C�  ��� �_ � T�  �CC��]���� �- T�  �C�  ��� GKK Industries\GKKEditors�� %�C �  � 
��� � T�  �CC��]���� � B�C�  ���� U 
 LCBASEPATH APISHGETSPECIALFOLDERPATH GKKMAKEPATH GKKGetConfigPath,     ��= q � �� � 1A �11A � 1                            programs\gkkcopyclipmgr.prg c:\users\andur\appdata\local\temp\ gkkcopyclipmgr.fxp classes\ gkkcopyclipmgr.vcx gkkcopyclipmgr.vct programs\gkkbeautifytext.prg gkkbeautifytext.fxp programs\gkkdeclareapi.prg gkkdeclareapi.fxp graphics\ gkkgkk.ico programs\gkkopenfdkeywrd.prg gkkopenfdkeywrd.fxp forms\ gkkcopyclipmgr.scx gkkcopyclipmgr.sct gkkbaseclasses.vcx gkkbaseclasses.vct gkksplitter.vcx gkksplitter.vct gkkclipcodemax.vcx gkkclipcodemax.vct misc\ gkkvfpmbrlist.xml gkkvisualfoxpro.xml programs\gkkoptionmbrclass.prg gkkoptionmbrclass.fxp programs\gkksetstring_vfp.prg gkksetstring_vfp.fxp programs\gkkgetstring_vfp.prg gkkgetstring_vfp.fxp gkkvsplitter.bmp gkkwindowposition.vcx gkkwindowposition.vct gkkhsplitter.bmp programs\gkkgetresource.prg gkkgetresource.fxp programs\gkkgetvfpforms.prg gkkgetvfpforms.fxp programs\gkkmakepath.prg gkkmakepath.fxp programs\gkkdisplaymsg.prg gkkdisplaymsg.fxp gkkdisplaymsg.scx gkkdisplaymsg.sct gkkinfo.bmp gkkapitimer.vcx gkkapitimer.vct gkkcopycodedelete.bmp gkksave.bmp gkkfolderopen16.bmp gkkcopy16.bmp programs\gkkgetconfigpath.prg gkkgetconfigpath.fxp  )   �     ?           �  �  R   [           �  (  R   n            (  <     �            <  �.    �           �. �7 �   �            �7 :              	: �B %  ,          �B �� %  ?          �� L� R   R          L� �� R   e          �� g� R   x          g� �� R   �          �� )� R   �          )� M R   �          M UI �  �          UI 0� �  �           0� ��    	           �� ,�    =           ,� �    p          � �� �   �          �� ?� R   �          ?� �� R   �          �� � �   �           � ��    �           �� ��               �� d�    J           d� 7�    u          	7� � %  �          � 2 %  �          2 x �   �          x � R   �          � ,5 R   �          ,5 b8 �   �          b8 H= �   �          H= ~@ �   �          ~@ �C �              �C 7E    9          