���   r �  �                     )*-- (c) C Lutions 1996
*-- Application Specific Header File

*-- Always calls generic common include file
#INCLUDE "strings.h"
#INCLUDE "foxpro.h"

#DEFINE INIFILE     		CURDIR() + "MBOXWIZ.INI"

#DEFINE CANNOTQUIT_LOC      "Cannot quit from here."

#DEFINE APPLICATION_LOC     "Message Box Wizard"
#DEFINE VERSION_LOC         "5.x"
#DEFINE COPYRIGHT_LOC       "Copyright 1997 C Lutions"
#DEFINE RIGHTSRSRVD_LOC		"All rights reserved"

#DEFINE	PRODUCTID_LOC		"05X"
#DEFINE	VERSIONDATE_LOC		"14.03.96"

#DEFINE DEBUGMODE	.T.


#DEFINE	CRLF				CHR(13) + CHR(10)
#DEFINE	CR					CHR(13)
#DEFINE	TAB					CHR(9)

*-- Constants to identify which trigger failed
*-- using element 5 of the array returned by 
*-- AERROR(), as well as to reference the appropriate
*-- array element in the error message array: aErrorMsg[]
#DEFINE	INSERTTRIG  			1
#DEFINE	UPDATETRIG  			2
#DEFINE	DELETETRIG  			3

*-- Constants used to read the system registry
#DEFINE	HKEY_LOCAL_MACHINE			-2147483646  
#DEFINE	KEY_SHARED_TOOLS_LOCATION	"Software\Microsoft\Shared Tools Location"
#DEFINE	KEY_NTCURRENTVERSION		"Software\Microsoft\Windows NT\CurrentVersion"
#DEFINE	KEY_WIN4CURRENTVERSION		"Software\Microsoft\Windows\CurrentVersion"
#DEFINE	KEY_WIN4_MSINFO				"Software\Microsoft\Shared Tools\MSInfo"
#DEFINE	KEY_QUERY_VALUE				1
#DEFINE	ERROR_SUCCESS				0

#DEFINE	ADMINBAR_LOC 			"Administration"
#DEFINE	ALL_LOC 				"All"

#DEFINE	USER_APPDEV_LOC 		"APPLICATION DEVELOPER"
#DEFINE	USER_OPSMGR_LOC 		"OPERATIONS MANAGER"
#DEFINE	USER_NETADM_LOC 		"NETWORK ADMINISTRATOR"
*-- (c) Microsoft Corporation 1995

*-- STRINGS.H
*-- Include this file where needed for localization
*-- purposes

*-- Messagebox Titles
#DEFINE ERRORTITLE_LOC      "An error has occurred"

*-- Toolbar names
#DEFINE TB_FORMDESIGNER_LOC	"Form Designer"
#DEFINE TB_STANDARD_LOC		"Standard"
#DEFINE TB_LAYOUT_LOC		"Layout"
#DEFINE TB_QUERY_LOC		"Query Designer"
#DEFINE TB_VIEWDESIGNER_LOC	"View Designer"
#DEFINE TB_COLORPALETTE_LOC	"Color Palette"
#DEFINE TB_FORMCONTROLS_LOC	"Form Controls"
#DEFINE TB_DATADESIGNER_LOC	"Database Designer"
#DEFINE TB_REPODESIGNER_LOC	"Report Designer"
#DEFINE TB_REPOCONTROLS_LOC	"Report Controls"
#DEFINE TB_PRINTPREVIEW_LOC	"Print Preview"
#DEFINE WIN_COMMAND_LOC		"Command"			&& Command Window


*-- Messagebox Messages
#DEFINE NOTYET_LOC				"Under Construction"
#DEFINE VALIDATING_LOC			"Validating ..."
#DEFINE TABLERULEFAIL_LOC		"Table rule failed!"

*-- Trigger error messages
#DEFINE INSERTTRIGFAIL_LOC  "Insert trigger failed!"
#DEFINE UPDATETRIGFAIL_LOC  "Update trigger failed!"
#DEFINE DELETETRIGFAIL_LOC  "Delete trigger failed!"

#DEFINE ABOUT_LOC			"About "
#DEFINE VERSIONLABEL_LOC    "Version "
*-- Function Parameters
*-- MessageBox parameters
#DEFINE MB_OK                   0       && OK button only
#DEFINE MB_OKCANCEL             1       && OK and Cancel buttons
#DEFINE MB_ABORTRETRYIGNORE     2       && Abort, Retry, and Ignore buttons
#DEFINE MB_YESNOCANCEL          3       && Yes, No, and Cancel buttons
#DEFINE MB_YESNO                4       && Yes and No buttons
#DEFINE MB_RETRYCANCEL          5       && Retry and Cancel buttons

#DEFINE MB_ICONNONE             0       && No Icon
#DEFINE MB_ICONSTOP             16      && Critical message
#DEFINE MB_ICONQUESTION         32      && Warning query
#DEFINE MB_ICONEXCLAMATION      48      && Warning message
#DEFINE MB_ICONINFORMATION      64      && Information message

#DEFINE MB_APPLMODAL            0       && Application modal message box
#DEFINE MB_DEFBUTTON1           0       && First button is default
#DEFINE MB_DEFBUTTON2           256     && Second button is default
#DEFINE MB_DEFBUTTON3           512     && Third button is default
#DEFINE MB_SYSTEMMODAL          4096    && System Modal

*-- MsgBox return values
#DEFINE IDOK            1       && OK button pressed
#DEFINE IDCANCEL        2       && Cancel button pressed
#DEFINE IDABORT         3       && Abort button pressed
#DEFINE IDRETRY         4       && Retry button pressed
#DEFINE IDIGNORE        5       && Ignore button pressed
#DEFINE IDYES           6       && Yes button pressed
#DEFINE IDNO            7       && No button pressed
   %   P      �  0   �  6Rx@   �� 4�  � K� %�C� nStartItb� N��i� %��  � ��e�= s��x���"�� MsgBox Wizard������ CTRL+F11�� ^F11��, 1���x���� DO SYS(2004)+'MBoxWiz.APP'� GY��� ��C�� Usage of the Message Box Wizard Output requires <foxpro.h> to be included in your current prg., form, menu, etc... OR Deselect <Use #DEFINE name constants>.�@� Information�x�� B� � �+ |�� RegOpenKeyEx� Win32API������1 |�� RegQueryValueEx� Win32API�������  |�� RegCloseKey� Win32API��; |�� GetProfileString� Win32APIQ�	 GetProStr������ 7� � � %�C�	 ����# T� �C� oApplicationManager�N�� %�C� oAppb� O���� ��C� �
 �� � <� � G&(� <� � <R� cApplicationManager� <R� cBaseClassLibrary� � B�a�� U  NSTARTIT REGOPENKEYEX WIN32API REGQUERYVALUEEX REGCLOSEKEY GETPROFILESTRING	 GETPROSTR OAPP	 WZLIBRARY SETENVIRONMENT DO CAPPLICATIONMANAGER CBASECLASSLIBRARYT  ��  � � T�  �a��2 G~(� cApplicationManager� cBaseClassLibrary�	 B��  �� U  LLRETVAL	 CFOXTOOLS CAPPLICATIONMANAGER CBASECLASSLIBRARY( ! ��C� Under Construction�@�x�� B� U  o  ��  � �� � � T� �C�
 COMPATIBLEv�� GA � T� �C�  ���# SET COMPATIBLE &lcSetCompatible
	 B�� �� U 
 TCFILENAME LCSETCOMPATIBLE
 LNFILESIZE= : ��C� Cannot quit from here.�0� Message Box Wizard�x�� U   SetEnvironment�    �� NotYetG    �� FileSizes    ��
 OnShutdown    ��q Q ���a �A A A ��� � 1�� A q e q ��E q 2 � � &� 3 A 3 q � �a � 1� 3 �2                    G  x	  ;   #   �	  �	  G   &   �	  �
  L   .   �
  *  V   0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _RE30ZJTPM 577733485      &  4      O      l  :                        ^               COMMENT RESERVED                                                                                            �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      custom      custom      oapplicationmanager      �Height = 80
Width = 100
lisclean = .F.
cmainwindcaption = MessageBox Wizard by C Lutions 1997
coldwindcaption = Microsoft Visual FoxPro
Name = "oapplicationmanager"
      Class      1      >lisclean
cmainwindcaption
coldwindcaption
*cleanup 
*do 
      Pixels     �
PROCEDURE cleanup
 _SCREEN.CAPTION = THIS.COLDWINDCAPTION
 CLEAR EVENTS 
 POP MENU TO MASTER _MSYSMENU
 THIS.LISCLEAN = .T.
ENDPROC
*------
PROCEDURE do
 DO FORM msgboxwiz
  THIS.CLEANUP()
ENDPROC
*------
PROCEDURE Init
 THIS.COLDWINDCAPTION = _SCREEN.CAPTION
 _SCREEN.CAPTION = THIS.CMAINWINDCAPTION
ENDPROC
*------
PROCEDURE Destroy
 IF  .NOT. THIS.LISCLEAN
     THIS.CLEANUP()
 ENDIF 
ENDPROC
*------      oapplicationmanager     W���    >  >                        �P   %   i      �     �          �  U  1  T�9�  �� � �� ��	 �(��� T� � �a�� U  CAPTION THIS COLDWINDCAPTION LISCLEAN!  �	 msgboxwiz� ��C� � �� U 	 MSGBOXWIZ THIS CLEANUP'  T�  � ��9� �� T�9� ��  � �� U  THIS COLDWINDCAPTION CAPTION CMAINWINDCAPTION%  %��  � 
�� � ��C�  � �� � U  THIS LISCLEAN CLEANUP cleanup,     �� do�     �� Init�     �� Destroy'    ��2 !Q � � 3 � 3 !!3 � A 2                       �         �   �   	   	   �   <        c  �      )   >                  0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _RE30WNJYD 557283796      (  8      I                      �  �              �               COMMENT RESERVED                        �      �                                                           WINDOWS _RE30WP9DC 557283836�              2                      �  �              �               COMMENT RESERVED                        �      �                                                           WINDOWS _RE30WUESL 557283953�      �                               )  6              ?               COMMENT RESERVED                        M                                                                   WINDOWS _RE30WUXR6 557283968\      k  z      �                      �  �              �               COMMENT RESERVED                        �      �                                                           WINDOWS _RE30WWA9E 557283997      )  6      D                      v  �              �               COMMENT RESERVED                        �                                                                   WINDOWS _RE30WXKA1 557284038�      �  �      �                      %  2              ;               COMMENT RESERVED                        I                                                                   WINDOWS _RE30X5FSF 557284228W      d  q                            �  �              �               COMMENT RESERVED                        �                                                                   WINDOWS _RE30X721W 557284266�      �  �                            =  J              S               COMMENT RESERVED                        a                                                                   WINDOWS _RFG0M92A9 560681733o        �      �                      �  �              �               COMMENT RESERVED                                                                                         WINDOWS _RE30X6CED 560893519A      P  _      o                      �  �              �               COMMENT RESERVED                        �      �                                                           WINDOWS _0Y40S3TRS 782723293�      �  �      �                      �  �              t               COMMENT RESERVED                        �      K                                                           WINDOWS _REV1D9IH81062630997[	      ?  g	            
  �	          E	  R	  t	          7	               COMMENT RESERVED                        *	      	                                                            �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      checkbox      checkbox      	ocheckbox      CHeight = 17
Width = 73
Caption = "CheckBox"
Name = "ocheckbox"
      Class      1      Pixels      	ocheckbox      !Arial, 0, 9, 5, 15, 12, 13, 3, 0
      commandbutton      commandbutton      ocommandbutton      GHeight = 27
Width = 77
Caption = "Command"
Name = "ocommandbutton"
      Class      1      Pixels      ocommandbutton      !Arial, 0, 9, 5, 15, 12, 13, 3, 0
      custom      custom      ocustom      Name = "ocustom"
      Class      1      Pixels      ocustom      editbox      editbox      oeditbox      -Height = 53
Width = 100
Name = "oeditbox"
      Class      1      Pixels      oeditbox      !Arial, 0, 9, 5, 15, 12, 13, 3, 0
      image      image      oimage      *Height = 68
Width = 68
Name = "oimage"
      Class      1      Pixels      oimage      label      label      olabel      MAutoSize = .T.
Caption = "Label"
Height = 17
Width = 33
Name = "olabel"
      Class      1      Pixels      olabel      shape      shape      oshape      *Height = 68
Width = 68
Name = "oshape"
      Class      1      Pixels      oshape      timer      timer      otimer      *Height = 23
Width = 23
Name = "otimer"
      Class      1      Pixels      otimer      combobox      combobox      odropdownlist      3Style = 2
Width = 100
Name = "odropdownlistbox"
      Class      1      Pixels      odropdownlist      !Arial, 0, 9, 5, 15, 12, 13, 3, 0
      textbox      textbox      otextbox      -Height = 23
Width = 100
Name = "otextbox"
      Class      1      Pixels      otextbox      !Arial, 0, 9, 5, 15, 12, 13, 3, 0
      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      oform      Pixels      Class      1      form      oform      :lhaderror
lseterroroff
^aerrormsg[3,0] 
*refreshform 
     F���    -  -                        ��   %   �      �  <   ,          �  U  ,  T�  � �a�� ��C�  � �� T�  � �-�� U  THISFORM
 LOCKSCREEN REFRESH  T�  � �-�� U  THISFORM VISIBLE� ��  � � � �� � �� �� � � %�� �	 ��J � T�
 � �a�� B� � ��C�� �z�� H�i ��� ��  ���� � ��C� ��/ ��CCC�� � � �0� Message Box Wizard�x�� %�C�� ���� � ��C� � �� � T� �a�� ��  �/��2� %�a��#� R,:�� Table rule failed!�� � T� �a�� ��  �.���� ��C� ��/ T� �CC� .C�� � Field� RuleText��� T� �C� � "�  ���$ ��C� �0� Message Box Wizard�x�� 2��� ��C� ��, T� �CEC� � � C� � CC� Z���+ T� �C� �� An error has occurred�x�� H�5��� �� ���s� %�a��U� L� �o�
 �� � � � B� � �� ����� X� 2��� B� � �	 B�� �� U  NERROR CMETHOD NLINE LLHANDLEDERROR LAERROR AERRORARRAY	 LCMESSAGE LNANSWER THISFORM LSETERROROFF THIS	 LHADERROR	 AERRORMSG RESTORE
 METHOD_LOC LINENUM_LOC OAPP CLEANUP� , T�  � ����� Insert trigger failed!��, T�  � ����� Update trigger failed!��, T�  � ����� Delete trigger failed!�� U  THISFORM	 AERRORMSG  t�:� G&(��  � �� U  THISFORM CAPTION refreshform,     �� Destroy{     �� Error�     �� Init    �� Activate�    ��1 � � � 2 � 2 � �� A A � � !� �Q� A � !� �A � !� �aA� � ��� � A � � A A A A � A A A � 2 ���2 � � 2                       c         �   �         �   �  	   5   �  A  :   9   `  �  ?    )   -                        3DoCreate = .T.
Caption = "oForm"
Name = "oform"
      form      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      Pixels      Class      1      spinner      ospinner      ,Height = 23
Width = 71
Name = "ospinner"
      spinner      ospinner     �PROCEDURE refreshform
 THISFORM.LOCKSCREEN = .T.
  THISFORM.REFRESH()
 THISFORM.LOCKSCREEN = .F.
ENDPROC
PROCEDURE Destroy
 THISFORM.VISIBLE = .F.
ENDPROC
PROCEDURE Error
LPARAMETER NERROR , CMETHOD , NLINE
 LOCAL LLHANDLEDERROR , LAERROR( AERRORARRAY ) , LCMESSAGE , LNANSWER
 IF THISFORM.LSETERROROFF
    THIS.LHADERROR = .T.
    RETURN 
 ENDIF 
  AERROR(LAERROR)
 DO CASE 
 CASE NERROR = 1539
    ?? CHR(7)
     MESSAGEBOX(THISFORM.AERRORMSG(LAERROR(5)),48,'Message Box Wizard')
    IF LAERROR(5) = 3
        THISFORM.RESTORE()
    ENDIF 
    LLHANDLEDERROR = .T.
 CASE NERROR = 1583
    IF .T.
       WAIT WINDOW NOWAIT 'Table rule failed!'
    ENDIF 
    LLHANDLEDERROR = .T.
 CASE NERROR = 1582
    ?? CHR(7)
    LCMESSAGE = DBGETPROP(ALIAS() + '.' + LAERROR(3),'Field','RuleText')
    LCMESSAGE = STRTRAN(LCMESSAGE,'"','')
     MESSAGEBOX(LCMESSAGE,48,'Message Box Wizard')
 OTHERWISE 
    ?? CHR(7)
    LCMESSAGE =  ;
         MESSAGE() + CHR(13) + METHOD_LOC + CMETHOD + CHR(13) + LINENUM_LOC +  ;
   ALLTRIM(STR(NLINE))
    LNANSWER = MESSAGEBOX(LCMESSAGE,18,'An error has occurred')
    DO CASE 
    CASE LNANSWER = 3
       IF .T.
          SUSPEND  
       ELSE 
           OAPP.CLEANUP
          CANCEL 
          RETURN 
       ENDIF 
    CASE LNANSWER = 4
       RETRY  
    OTHERWISE 
       RETURN 
    ENDCASE 
 ENDCASE 
 RETURN LLHANDLEDERROR
ENDPROC
PROCEDURE Init
 THISFORM.AERRORMSG( 1 ) = 'Insert trigger failed!'
 THISFORM.AERRORMSG( 2 ) = 'Update trigger failed!'
 THISFORM.AERRORMSG( 3 ) = 'Delete trigger failed!'
ENDPROC
PROCEDURE Activate
 ACTIVATE MENU _MSYSMENU NOWAIT
 SET MESSAGE TO THISFORM.CAPTION
 
ENDPROC
0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Screen                                                                                              WINDOWS _RIW10MMTG 577669290      /  F      ]                          �      �                       WINDOWS _RIW10MMTJ1081639535�  �  �              
  x�                  6                           WINDOWS _RIW1ERCOO1081627667C7  X7  u7  �7  �7  �7      �8  �1                                               WINDOWS _RIW10MMUR 782723559W=  m=  �=  �=  �=  �=      2>  �0                                               WINDOWS _RIW10MMTG1081573188�?  �?  �?  �?  �?  @      |@  �X                                               WINDOWS _RIW10MMV61081626354�g  �g  �g  �g  �g  h                                                           WINDOWS _RIW10MMVE1081627667�h  �h  �h  i   i  1i      �j  �/                                               WINDOWS _RIW1424NE1081626318Nl  ^l  {l  �l  �l  �l                                                           WINDOWS _RIW10MMTG 587568306xm  �m  �m  �m  �m  �m                                                           WINDOWS _RIW1424NR 587568306Wn  en  �n  �n  �n  �n                                                           WINDOWS _RIW1424OX 587568306&o  4o  Qo  ^o  mo  ~o                                                           WINDOWS _RIW1424P3 782723559�o  p  p  3p  Ep  Vp      �p  m.                                               WINDOWS _RIW1424PJ 587568306�r  �r  s  s  $s  5s                                                           WINDOWS _RIW10MMTG 782723559�s  �s  �s  �s  t  t      �t  �,                                               WINDOWS _RIW10MMTG1081628013}w  �w  �w  �w  �w  �w      �x  D+                                               WINDOWS _RIW10MMTG 782723559<{  M{  j{  z{  �{  �{      w|  �)                                               WINDOWS _RIX0QSS8D1081628013�~    (  8  F  W      ,�  1(                                               WINDOWS _RIX0QSS9A1081626318g�  J�  :�  )�  �  ~                                                           WINDOWS _RIX00AYTY 782723559.{  �}  !{  {  {  k}                                                           WINDOWS _RIW10MMTG1081628309lw  Ow  ?w  �r  �r  Yz      �y  �&                                               WINDOWS _RMW13UK421081626882�r  �r  �r  rr  ar  �v      �u  [%                                               WINDOWS _RIZ015T7P 782723559=l   l  l  �?  |?  �q      k  �#                                               WINDOWS _RIW10MMTG1081166249n?  Q?  D?  5?  $?  �>                                                           WINDOWS _RMU0LO7CK1081628256B=  �>  2=  �5  �5  i<      r;  T"                                               WINDOWS _0Y40SEPL0 782723559�5  �5  �5  �5  �5  �:                                                           WINDOWS _0Y40SEPL1 782723559v5  Y5  L5  =5  ,5  �4                                                           COMMENT RESERVED                                p4                                                            �,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      dataenvironment      dataenvironment      Dataenvironment      YTop = 0
Left = 0
Width = 0
Height = 0
DataSource = .NULL.
Name = "Dataenvironment"
      1      1      oform      cbaseclasslibrary.vcx      form      	__MBOXWIZ     �Height = 263
Width = 370
DoCreate = .T.
ShowTips = .T.
AutoCenter = .T.
Caption = "Message Box Wizard"
ControlBox = .T.
Closable = .T.
MaxButton = .F.
MinButton = .F.
MaxHeight = 263
MaxWidth = 370
MinHeight = 263
MinWidth = 370
MaxTop = 0
MaxLeft = 0
WindowType = 1
WindowState = 0
AlwaysOnTop = .T.
mbbuttons = ""
mbdefbutton = ""
mbicon = ""
nbbuttons = 0
nbdefbutton = 0
nbicon = 0
idreturn = ""
inreturn = 0
osettings = .NULL.
_memberdata =      611<VFPData><memberdata name="finish" display="Finish"/><memberdata name="ctitle" display="cTitle"/><memberdata name="cmessage" display="cMessage"/><memberdata name="cbuttons" display="cButtons"/><memberdata name="cdefaultbutton" display="cDefaultButton"/><memberdata name="ldocase" display="lDoCase"/><memberdata name="lif" display="lIF"/><memberdata name="ldefines" display="lDefines"/><memberdata name="cifvalue" display="cIFValue"/><memberdata name="createrowsource" display="CreateRowSource"/><memberdata name="crowsource" display="cRowSource"/><memberdata name="getreturnid" display="GetReturnID"/></VFPData>
ctitle = 
cmessage = 
cbuttons = Ok
cdefaultbutton = Ok
ldocase = .F.
lif = .F.
ldefines = .F.
cifvalue = 
crowsource = Ok
Name = "__MBOXWIZ"
     IPROCEDURE msgformat
 LPARAMETER CMESSAGE
 LOCAL NMSGWORDS
 CMESSAGE = ALLTRIM(CMESSAGE)
  NOTYET()
 RETURN CMESSAGE
ENDPROC
PROCEDURE pmsgformat
 LPARAMETER CMESSAGE
 CMESSAGE = ALLTRIM(CMESSAGE)
  NOTYET()
 RETURN CMESSAGE
ENDPROC
PROCEDURE finish
#Define CR      Chr(13)
#Define LF      Chr(10)
#Define INDENT1 '   '
#Define INDENT2 '      '

* timeout added for vfp7 by BAB
Local lcComments, lcDialogType, lcMessageBox, lcMessageText, lcText, lcTimeout, lcTitleBar
Local lnCaseState, lnSelection

lcMessageText = Alltrim (Thisform.EDTMESSAGE.Value)
lcMessageText = '"' + Strtran (Strtran(lcMessageText, LF, ''), CR, '" + Chr(13) + "') + '"'

If Thisform.CBDEFINES.Value = .T.
	lcDialogType = Thisform.MBBUTTONS  ;
		+ '+' + Thisform.MBDEFBUTTON   ;
		+ Iif ( Not Empty (Thisform.MBICON), '+' + Thisform.MBICON, '')
Else
	lcDialogType = Transform (Thisform.NBBUTTONS + Thisform.NBDEFBUTTON + Thisform.NBICON)
Endif

lcTitleBar = '"' + Alltrim (Thisform.TXTTITLE.Value) + '"'

lcTimeout = ''
If Not Empty (Thisform.Ospinner1.Value)
	lcTimeout = ', ' + Alltrim (Str (Thisform.Ospinner1.Value * 1000))
Endif

lcMessageBox = 'MESSAGEBOX(' + lcMessageText + ', ' +  ;
	lcDialogType + ', ' + lcTitleBar + lcTimeout + ')'

Do Case
	Case Thisform.CBIF.Value
		_Cliptext =															   ;
			'IF ' + lcMessageBox + ' = ' + ;
			Trans(Thisform.GetReturnID()) + CR +  ;
			INDENT1 + '^^^' + CR +											   ;
			'ELSE' + CR +													   ;
			INDENT1 + CR +													   ;
			'ENDIF'
	Case Thisform.CBDOCASE.Value
		lcText =  ;
			'lnMsgBoxAns = ' + lcMessageBox
		Do Case
			Case Thisform.DDLBDEFBUTTON.RowSource = 'Ok,Cancel'
				lnCaseState =														   ;
					'DO CASE' + CR +												   ;
					INDENT1 + 'CASE lnMsgBoxAns = IDOK' + CR + INDENT2 + '^^^' + CR +  ;
					INDENT1 + 'CASE lnMsgBoxAns = IDCANCEL' + CR + INDENT2 + CR +	   ;
					'ENDCASE'
			Case Thisform.DDLBDEFBUTTON.RowSource = 'Ok'
				lnCaseState =														   ;
					'DO CASE' + CR +												   ;
					INDENT1 + 'CASE lnMsgBoxAns = IDOK' + CR + INDENT2 + '^^^' + CR +  ;
					'ENDCASE'
			Case Thisform.DDLBDEFBUTTON.RowSource = 'Abort,Retry,Ignore'
				lnCaseState =															  ;
					'DO CASE' + CR +													  ;
					INDENT1 + 'CASE lnMsgBoxAns = IDABORT' + CR + INDENT2 + '^^^' + CR +  ;
					INDENT1 + 'CASE lnMsgBoxAns = IDRETRY' + CR + INDENT2 + CR +		  ;
					INDENT1 + 'CASE lnMsgBoxAns = IDIGNORE' + CR + INDENT2 + CR +		  ;
					'ENDCASE'
			Case Thisform.DDLBDEFBUTTON.RowSource = 'Yes,No,Cancel'
				lnCaseState =															;
					'DO CASE' + CR +													;
					INDENT1 + 'CASE lnMsgBoxAns = IDYES' + CR + INDENT2 + '^^^' + CR +	;
					INDENT1 + 'CASE lnMsgBoxAns = IDNO' + CR + INDENT2 + CR +			;
					INDENT1 + 'CASE lnMsgBoxAns = IDCANCEL' + CR  + INDENT2 + CR +		;
					'ENDCASE'
			Case Thisform.DDLBDEFBUTTON.RowSource = 'Yes,No'
				lnCaseState =															;
					'DO CASE' + CR +													;
					INDENT1 + 'CASE lnMsgBoxAns = IDYES' + CR + INDENT2 + '^^^' + CR +	;
					INDENT1 + 'CASE lnMsgBoxAns = IDNO' + CR + INDENT2 + CR +			;
					'ENDCASE'
			Case Thisform.DDLBDEFBUTTON.RowSource = 'Retry,Cancel'
				lnCaseState =															  ;
					'DO CASE' + CR +													  ;
					INDENT1 + 'CASE lnMsgBoxAns = IDRETRY' + CR + INDENT2 + '^^^' + CR +  ;
					INDENT1 + 'CASE lnMsgBoxAns = IDCANCEL' + CR + INDENT2 + CR +		  ;
					'ENDCASE'
			Otherwise
				lnCaseState =														   ;
					'DO CASE' + CR +												   ;
					INDENT1 + 'CASE lnMsgBoxAns = IDOK' + CR + INDENT2 + '^^^' + CR +  ;
					'ENDCASE'
		Endcase
		_Cliptext = lcText + CR + lnCaseState
	Otherwise
		_Cliptext = lcMessageBox
Endcase

If Not Thisform.CBDEFINES.Value
	lcComments = ' &' + '& '
	_Cliptext  = Strtran (_Cliptext, 'IDOK',     '1' + lcComments + 'OK')
	_Cliptext  = Strtran (_Cliptext, 'IDCANCEL', '2' + lcComments + 'Cancel')
	_Cliptext  = Strtran (_Cliptext, 'IDABORT',  '3' + lcComments + 'Abort')
	_Cliptext  = Strtran (_Cliptext, 'IDRETRY',  '4' + lcComments + 'Retry')
	_Cliptext  = Strtran (_Cliptext, 'IDIGNORE', '5' + lcComments + 'Ignore')
	_Cliptext  = Strtran (_Cliptext, 'IDYES',    '6' + lcComments + 'Yes')
	_Cliptext  = Strtran (_Cliptext, 'IDNO',     '7' + lcComments + 'No')
Endif

Thisform.Visible = .F.
Thisform.Release()
Clear Events
ENDPROC
PROCEDURE createrowsource
Do Case
	Case This.cButtons = 'Ok / Cancel'
		This.MBBUTTONS	= 'MB_OKCANCEL'
		This.NBBUTTONS	= 1
		This.cRowSource	= 'Ok,Cancel'
	Case This.cButtons = 'Ok'
		This.MBBUTTONS	= 'MB_OK'
		This.NBBUTTONS	= 0
		This.cRowSource	= 'Ok'
	Case This.cButtons = 'Abort / Retry / Ignore'
		This.MBBUTTONS	= 'MB_ABORTRETRYIGNORE'
		This.NBBUTTONS	= 2
		This.cRowSource	= 'Abort,Retry,Ignore'
	Case This.cButtons = 'Yes / No / Cancel'
		This.MBBUTTONS	= 'MB_YESNOCANCEL'
		This.NBBUTTONS	= 3
		This.cRowSource	= 'Yes,No,Cancel'
	Case This.cButtons = 'Yes / No'
		This.MBBUTTONS	= 'MB_YESNO'
		This.NBBUTTONS	= 4
		This.cRowSource	= 'Yes,No'
	Case This.cButtons = 'Retry / Cancel'
		This.MBBUTTONS	= 'MB_RETRYCANCEL'
		This.NBBUTTONS	= 5
		This.cRowSource	= 'Retry,Cancel'
	Otherwise
		This.MBBUTTONS	= 'MB_OK'
		This.NBBUTTONS	= 0
		This.cRowSource	= 'Ok'
Endcase

ENDPROC
PROCEDURE getreturnid
lcIFValue = Thisform.cIFValue
ALines(laReturns, 'Ok, Cancel, Abort, Retry, Ignore, Yes, No', 5, ',')
Return Ascan (laReturns, lcIFValue, 1, -1, -1, 1) 
ENDPROC
PROCEDURE Destroy
Thisform.osettings.Save(ThisForm)
ENDPROC
PROCEDURE Init
This.MBBUTTONS	 = 'MB_OK'
This.NBBUTTONS	 = 0
This.MBDEFBUTTON = 'MB_DEFBUTTON1'
This.NBDEFBUTTON = 0
This.MBICON		 = 0
This.NBICON		 = 0
This.IDRETURN	 = 'IDOK'
This.INRETURN	 = 1

This.osettings = Execscript (_Screen.cThorDispatcher, 'class= ThorFormSettings', 'thor_tool_messagebox_wiz')
This.osettings.Restore (Thisform)
This.osettings.Restore (Thisform, 'cButtons, cDefaultButton, lDoCase, lIF, cIFValue, lDefines'	;
	  + ', MBButtons, MBDEFButton, MBIcon, NBButtons, NBDEFBUTTON, NBIcon')

This.CreateRowSource()
This.Refresh()

ENDPROC
PROCEDURE QueryUnload
thisform.cmdCancel.Click()
ENDPROC
     p���    W  W                        ��   %   �                       �  U  z  T�  � �� � �� %��  � �  � 
��U �* T�  � �C�  � C� ,�  � � ,�=�� � T�  � �� � � � � 
	�� U  THIS	 ROWSOURCE THISFORM
 CROWSOURCE VALUE ENABLED LIF LDOCASE Refresh,     ��1 1��A �1                       �       )   W                       ����    n  n                        _L   %         %  	             �  U    T�  � �� MB_ICONSTOP�� T�  � ���� T�  � � �-�� T�  � � �-�� T�  � � �-�� T�  � � �-�� ��C�  � �� U	  THISFORM MBICON NBICON	 CBEXCLAIM VALUE
 CBQUESTION CBINFO CBNONE REFRESHFORM Click,     ��1 �� 1                       �       )   n                       _���    F  F                        E�   %   �       �      �           �  U  %  %��  � �� � T� � �-�� � U  THISFORM LIF THIS VALUE#  ��C�  � � �� ��C�  � � �� U  THISFORM CBIF REFRESH
 DDLBRETURN Refresh,     �� Validq     ��1 � A 3 2                       >         Z   �       )   F                       g���    N  N                        �   %   �       �      �           �  U  #  ��C�  � � �� ��C�  � � �� U  THISFORM CBDOCASE REFRESH
 DDLBRETURN%  %��  � �� � T� � �-�� � U  THISFORM LDOCASE THIS VALUE Valid,     �� Refresh|     ��1 3 � A 2                       M         k   �       )   N                       |���    c  c                        ,�   %   �         	             �  U  t  T�  � �� �� T�  � �� �� T�  � � �-�� T�  � � �-�� T�  � � �-�� T�  � � �-�� ��C�  � �� U	  THISFORM MBICON NBICON	 CBEXCLAIM VALUE
 CBQUESTION CBINFO CBSTOP REFRESHFORM Click,     ��1 � 1                       �       )   c                       ����    n  n                        _L   %         %  	             �  U  �  T�  � �� MB_ICONQUESTION�� T�  � �� �� T�  � � �-�� T�  � � �-�� T�  � � �-�� T�  � � �-�� ��C�  � �� U	  THISFORM MBICON NBICON	 CBEXCLAIM VALUE CBSTOP CBINFO CBNONE REFRESHFORM Click,     ��1 �� 1                       �       )   n                       ����    u  u                        �   %         ,  	             �  U  � " T�  � �� MB_ICONINFORMATION�� T�  � ��@�� T�  � � �-�� T�  � � �-�� T�  � � �-�� T�  � � �-�� ��C�  � �� U	  THISFORM MBICON NBICON	 CBEXCLAIM VALUE CBSTOP
 CBQUESTION CBNONE REFRESHFORM Click,     ��1 !� 1                       �       )   u                       ����    r  r                        �   %         )  	             �  U  � " T�  � �� MB_ICONEXCLAMATION�� T�  � ��0�� T�  � � �-�� T�  � � �-�� T�  � � �-�� T�  � � �-�� ��C�  � �� U	  THISFORM MBICON NBICON CBINFO VALUE CBSTOP
 CBQUESTION CBNONE REFRESHFORM Click,     ��1 !� 1                       �       )   r                       @���    '  '                        4f   %   �       �      �           �  U  C  T�  �� � � � � � ��" ��CC� � � ��  C� � � ��x�� U  LNSELECTION THISFORM	 NBBUTTONS NBDEFBUTTON NBICON
 EDTMESSAGE VALUE TXTTITLE Click,     ��1 �!1                       �       )   '                       )���                              "g   %   �       �      �           �  U  ;  ���  ��4 � ��C�� �� ��C�� � �� ��C�� � �� �� U  THISFORM CREATEROWSOURCE DDLBDEFBUTTON REFRESH
 DDLBRETURN Valid,     ��1 � � � � A 4                       u       )                           ����    �   �                         �   %   {       �      �           �  U  /  T���  �� T�  � �-�� ��C�  � �� �� U  THISFORM VISIBLE RELEASE Click,     ��1 � � � Q 1                       _       )   �                        ����    i  i                        �   %   �           �          �  U  �  H� �� � ��  � ���N � T� � �� MB_DEFBUTTON1�� T� � �� �� ��  � ���� � T� � �� MB_DEFBUTTON2�� T� � �� �� ��  � ���� � T� � �� MB_DEFBUTTON3�� T� � �� �� � U  THIS	 LISTINDEX THISFORM MBDEFBUTTON NBDEFBUTTON\  T�  � �� � �� %��  � �  � 
��U �* T�  � �C�  � C� ,�  � � ,�=�� � U  THIS	 ROWSOURCE THISFORM
 CROWSOURCE VALUE Valid,     �� Refresh>    ��1 � A�A�A�A 3 1��A 1                       G        e  �      )   i                        !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      �AutoSize = .T.
BackStyle = 0
Caption = "Timeout(Secs)"
Height = 17
Left = 277
Top = 220
Width = 83
TabIndex = 22
Name = "Olabel7"
      	__MBOXWIZ      Olabel7      label      cbaseclasslibrary.vcx      olabel      	__MBOXWIZ      	Ospinner1      spinner      cbaseclasslibrary.vcx      ospinner      	__MBOXWIZ      
ddlbReturn     6mbbuttons
mbdefbutton
mbicon
nbbuttons
nbdefbutton
nbicon
idreturn
inreturn
osettings
_memberdata XML Metadata for customizable properties
ctitle
cmessage
cbuttons
cdefaultbutton
ldocase
lif
ldefines
cifvalue
crowsource
*msgformat 
*pmsgformat 
*finish 
*createrowsource 
*getreturnid 
      odropdownlist      cbaseclasslibrary.vcx      combobox      ddlbDefButton      	__MBOXWIZ     RowSourceType = 1
RowSource = "Ok"
Value = Ok
ControlSource = "Thisform.cDefaultButton"
Height = 24
Left = 9
SelectOnEntry = .T.
TabIndex = 4
ToolTipText = "Select Default Message Box Button"
Top = 184
Width = 95
ZOrderSet = 0
Name = "ddlbDefButton"
     PROCEDURE Valid
Do Case
	Case This.ListIndex = 1
		Thisform.MBDEFBUTTON = 'MB_DEFBUTTON1'
		Thisform.NBDEFBUTTON = 0
	Case This.ListIndex = 2
		Thisform.MBDEFBUTTON = 'MB_DEFBUTTON2'
		Thisform.NBDEFBUTTON = 256
	Case This.ListIndex = 3
		Thisform.MBDEFBUTTON = 'MB_DEFBUTTON3'
		Thisform.NBDEFBUTTON = 512
Endcase

ENDPROC
PROCEDURE Refresh
This.RowSource = Thisform.cRowSource
If Not This.Value $ This.RowSource
	This.Value = Left (This.RowSource, At (',', This.RowSource + ',') - 1)
Endif
ENDPROC
      �InputMask = "99"
KeyboardHighValue = 99
KeyboardLowValue = 1
Left = 277
SpinnerHighValue =  99.00
SpinnerLowValue =   1.00
Top = 235
Name = "Ospinner1"
      �PROCEDURE Refresh
This.RowSource = Thisform.cRowSource
If Not This.Value $ This.RowSource
	This.Value = Left (This.RowSource, At (',', This.RowSource + ',') - 1)
Endif

This.Enabled = Thisform.lIF and not Thisform.lDoCase 
ENDPROC
      �RowSourceType = 1
RowSource = "Ok"
ControlSource = "Thisform.cIFValue"
Enabled = .F.
Height = 24
Left = 214
SelectOnEntry = .T.
TabIndex = 7
Top = 159
Width = 87
Name = "ddlbReturn"
      combobox      odropdownlist      ocommandbutton      cbaseclasslibrary.vcx      commandbutton      	cmdCancel      	__MBOXWIZ      iTop = 231
Left = 182
Width = 65
Caption = "Cancel"
TabIndex = 16
ZOrderSet = 1
Name = "cmdCancel"
      jPROCEDURE Click
 _CLIPTEXT = ''
 THISFORM.VISIBLE = .F.
  THISFORM.RELEASE()
 CLEAR EVENTS 
ENDPROC
      cbaseclasslibrary.vcx      [Caption = "constants"
Left = 190
Top = 202
Width = 56
TabIndex = 22
Name = "Olabel6"
      	__MBOXWIZ      Olabel6      label      cbaseclasslibrary.vcx      olabel      	__MBOXWIZ      cbStop      ocommandbutton      cbaseclasslibrary.vcx      commandbutton      cmdOk      	__MBOXWIZ      sTop = 231
Left = 93
Width = 65
Caption = "Finish"
Default = .T.
TabIndex = 15
ZOrderSet = 2
Name = "cmdOk"
      PROCEDURE Click
Thisform.Finish()
Return


* timeout addes for vfp7 by BAB
lcTimeout = "0"
IF NOT EMPTY(ThisForm.Ospinner1.value) 
	lcTimeout = ALLTRIM(STR(ThisForm.Ospinner1.value*1000))
ENDIF
 DO CASE 
 CASE THISFORM.CBIF.VALUE
    DO CASE 
    CASE THISFORM.CBDEFINES.VALUE = .T.
       _CLIPTEXT =  ;
            'IF MESSAGEBOX("' + ALLTRIM(THISFORM.EDTMESSAGE.VALUE) + '",' + THISFORM.MBBUTTONS +  ;
      '+' + THISFORM.MBDEFBUTTON +  ;
      IIF( .NOT. EMPTY(THISFORM.MBICON),'+' + THISFORM.MBICON,'') + ',"' + ALLTRIM(THISFORM.TXTTITLE.VALUE) +'"'+;
      ',' +lcTimeout+') = ' + ALLTRIM(THISFORM.IDRETURN) + CHR(13) + 'ELSE' + CHR(13) + 'ENDIF'
    CASE THISFORM.CBDEFINES.VALUE = .F.
       LNSELECTION = THISFORM.NBBUTTONS + THISFORM.NBDEFBUTTON + THISFORM.NBICON
       _CLIPTEXT =  ;
            'IF MESSAGEBOX("' + ALLTRIM(THISFORM.EDTMESSAGE.VALUE) + '",' +  ;
      ALLTRIM(STR(LNSELECTION)) + ',"' + ALLTRIM(THISFORM.TXTTITLE.VALUE) +'",'+;
      	lcTimeout+') = ' + ;
      ALLTRIM(STR(THISFORM.INRETURN)) + CHR(13) + 'ELSE' + CHR(13) + 'ENDIF'
    OTHERWISE 
    ENDCASE 
 CASE THISFORM.CBDOCASE.VALUE
    DO CASE 
    CASE THISFORM.CBDEFINES.VALUE = .T.
       LCTEXT =  ;
            'lnMsgBoxAns = MESSAGEBOX("' + ALLTRIM(THISFORM.EDTMESSAGE.VALUE) + '",' +  ;
      THISFORM.MBBUTTONS + '+' + THISFORM.MBDEFBUTTON +  ;
      IIF( .NOT. EMPTY(THISFORM.MBICON),'+' + THISFORM.MBICON,'') + ',"' +  ;
      ALLTRIM(THISFORM.TXTTITLE.VALUE) + '")'
       DO CASE 
       CASE THISFORM.DDLBDEFBUTTON.ROWSOURCE = 'Ok,Cancel'
          LNCASESTATE =  ;
               CHR(13) + 'DO CASE' + CHR(13) + '   CASE lnMsgBoxAns = IDOK' + CHR(13) +  ;
         '   CASE lnMsgBoxAns = IDCANCEL' + CHR(13) + 'ENDCASE'
       CASE THISFORM.DDLBDEFBUTTON.ROWSOURCE = 'Ok'
          LNCASESTATE =  ;
               CHR(13) + 'DO CASE' + CHR(13) + '   CASE lnMsgBoxAns = IDOK' + CHR(13) + 'ENDCASE'
       CASE THISFORM.DDLBDEFBUTTON.ROWSOURCE = 'Abort,Retry,Ignore'
          LNCASESTATE =  ;
               CHR(13) + 'DO CASE' + CHR(13) + '   CASE lnMsgBoxAns = IDABORT' + CHR(13) +  ;
         '   CASE lnMsgBoxAns = IDRETRY' + CHR(13) +  ;
         '   CASE lnMsgBoxAns = IDIGNORE' + CHR(13) + 'ENDCASE'
       CASE THISFORM.DDLBDEFBUTTON.ROWSOURCE = 'Yes,No,Cancel'
          LNCASESTATE =  ;
               CHR(13) + 'DO CASE' + CHR(13) + '   CASE lnMsgBoxAns = IDYES' + CHR(13) +  ;
         '   CASE lnMsgBoxAns = IDNO' + CHR(13) + '   CASE lnMsgBoxAns = IDCANCEL' +  ;
         CHR(13) + 'ENDCASE'
       CASE THISFORM.DDLBDEFBUTTON.ROWSOURCE = 'Yes,No'
          LNCASESTATE =  ;
               CHR(13) + 'DO CASE' + CHR(13) + '   CASE lnMsgBoxAns = IDYES' + CHR(13) +  ;
         '   CASE lnMsgBoxAns = IDNO' + CHR(13) + 'ENDCASE'
       CASE THISFORM.DDLBDEFBUTTON.ROWSOURCE = 'Retry,Cancel'
          LNCASESTATE =  ;
               CHR(13) + 'DO CASE' + CHR(13) + '   CASE lnMsgBoxAns = IDRETRY' + CHR(13) +  ;
         '   CASE lnMsgBoxAns = IDCANCEL' + CHR(13) + 'ENDCASE'
       OTHERWISE 
          LNCASESTATE =  ;
               CHR(13) + 'DO CASE' + CHR(13) + '   CASE lnMsgBoxAns = IDOK' + CHR(13) + 'ENDCASE'
       ENDCASE 
    CASE THISFORM.CBDEFINES.VALUE = .F.
       LNSELECTION = THISFORM.NBBUTTONS + THISFORM.NBDEFBUTTON + THISFORM.NBICON
       LCTEXT =  ;
            'lnMsgBoxAns = MESSAGEBOX("' + ALLTRIM(THISFORM.EDTMESSAGE.VALUE) + '",' +  ;
      ALLTRIM(STR(LNSELECTION)) + ',"' + ALLTRIM(THISFORM.TXTTITLE.VALUE) +'"'+;
       ',' +lcTimeout+') = '+  ;
      ALLTRIM(STR(THISFORM.INRETURN))
       DO CASE 
       CASE THISFORM.DDLBDEFBUTTON.ROWSOURCE = 'Ok,Cancel'
          LNCASESTATE =  ;
               CHR(13) + 'DO CASE' + CHR(13) + '   CASE lnMsgBoxAns = 1' + CHR(13) +  ;
         '   CASE lnMsgBoxAns = 2' + CHR(13) + 'ENDCASE'
       CASE THISFORM.DDLBDEFBUTTON.ROWSOURCE = 'Ok'
          LNCASESTATE =  ;
               CHR(13) + 'DO CASE' + CHR(13) + '   CASE lnMsgBoxAns = 1' + CHR(13) + 'ENDCASE'
       CASE THISFORM.DDLBDEFBUTTON.ROWSOURCE = 'Abort,Retry,Ignore'
          LNCASESTATE =  ;
               CHR(13) + 'DO CASE' + CHR(13) + '   CASE lnMsgBoxAns = 3' + CHR(13) +  ;
         '   CASE lnMsgBoxAns = 4' + CHR(13) + '   CASE lnMsgBoxAns = 5' + CHR(13) +  ;
         'ENDCASE'
       CASE THISFORM.DDLBDEFBUTTON.ROWSOURCE = 'Yes,No,Cancel'
          LNCASESTATE =  ;
               CHR(13) + 'DO CASE' + CHR(13) + '   CASE lnMsgBoxAns = 6' + CHR(13) +  ;
         '   CASE lnMsgBoxAns = 7' + CHR(13) + '   CASE lnMsgBoxAns = 2' + CHR(13) +  ;
         'ENDCASE'
       CASE THISFORM.DDLBDEFBUTTON.ROWSOURCE = 'Yes,No'
          LNCASESTATE =  ;
               CHR(13) + 'DO CASE' + CHR(13) + '   CASE lnMsgBoxAns = 6' + CHR(13) +  ;
         '   CASE lnMsgBoxAns = 7' + CHR(13) + 'ENDCASE'
       CASE THISFORM.DDLBDEFBUTTON.ROWSOURCE = 'Retry,Cancel'
          LNCASESTATE =  ;
               CHR(13) + 'DO CASE' + CHR(13) + '   CASE lnMsgBoxAns = 4' + CHR(13) +  ;
         '   CASE lnMsgBoxAns = 2' + CHR(13) + 'ENDCASE'
       OTHERWISE 
          LNCASESTATE =  ;
               CHR(13) + 'DO CASE' + CHR(13) + '   CASE lnMsgBoxAns = 1' + CHR(13) + 'ENDCASE'
       ENDCASE 
    OTHERWISE 
    ENDCASE 
    _CLIPTEXT = LCTEXT + LNCASESTATE
 OTHERWISE 
    DO CASE 
    CASE THISFORM.CBDEFINES.VALUE = .T.
    
    
       _CLIPTEXT =  ;
            'MESSAGEBOX("' + ALLTRIM(THISFORM.EDTMESSAGE.VALUE) + '",' + THISFORM.MBBUTTONS +  ;
      '+' + THISFORM.MBDEFBUTTON +  ;
      IIF( .NOT. EMPTY(THISFORM.MBICON),'+' + THISFORM.MBICON,'') + ',"' + ALLTRIM(THISFORM.TXTTITLE.VALUE) +'"'+;
      	',' +lcTimeout+')'
    CASE THISFORM.CBDEFINES.VALUE = .F.
       LNSELECTION = THISFORM.NBBUTTONS + THISFORM.NBDEFBUTTON + THISFORM.NBICON
       _CLIPTEXT =  ;
            'MESSAGEBOX("' + ALLTRIM(THISFORM.EDTMESSAGE.VALUE) + '",' +  ;
      ALLTRIM(STR(LNSELECTION)) + ',"' + ALLTRIM(THISFORM.TXTTITLE.VALUE) +'"'+;
      	',' +lcTimeout+')'
    OTHERWISE 
    ENDCASE 
 ENDCASE 
 THISFORM.VISIBLE = .F.
  THISFORM.RELEASE()
 CLEAR EVENTS 
ENDPROC
     ���    �  �                        �   %         �  I   $          �  U  � ��C�  � �� B� T� �� 0�� %�C�  � � �
��Q � T� �CC�  � � ��Z��� � H�b ��� ��  � � ��� H�� �� ��  � � a��E�� T��� IF MESSAGEBOX("C�  � � �� ",�  � � +�  �	 CC�  �
 �
� � +�  �
 � �  6� ,"C�  � � �� "� ,� � ) = C�  � �C� � ELSEC� � ENDIF�� ��  � � -���� T� ��  � �  � �  � ��� T��� IF MESSAGEBOX("C�  � � �� ",CC� Z�� ,"C�  � � �� ",� � ) = CC�  � Z�C� � ELSEC� � ENDIF�� 2�� � ��  � � ��z� H�%�f� ��  � � a����� T� �� lnMsgBoxAns = MESSAGEBOX("C�  � � �� ",�  � � +�  �	 CC�  �
 �
� � +�  �
 � �  6� ,"C�  � � �� ")�� H�����  ��  � � �	 Ok,Cancel��b�w T� �C� � DO CASEC� �    CASE lnMsgBoxAns = IDOKC� �    CASE lnMsgBoxAns = IDCANCELC� � ENDCASE�� ��  � � � Ok����O T� �C� � DO CASEC� �    CASE lnMsgBoxAns = IDOKC� � ENDCASE��) ��  � � � Abort,Retry,Ignore����� T� �C� � DO CASEC� �    CASE lnMsgBoxAns = IDABORTC� �    CASE lnMsgBoxAns = IDRETRYC� �    CASE lnMsgBoxAns = IDIGNOREC� � ENDCASE��$ ��  � � � Yes,No,Cancel��T�� T� �C� � DO CASEC� �    CASE lnMsgBoxAns = IDYESC� �    CASE lnMsgBoxAns = IDNOC� �    CASE lnMsgBoxAns = IDCANCELC� � ENDCASE�� ��  � � � Yes,No����t T� �C� � DO CASEC� �    CASE lnMsgBoxAns = IDYESC� �    CASE lnMsgBoxAns = IDNOC� � ENDCASE��# ��  � � � Retry,Cancel����z T� �C� � DO CASEC� �    CASE lnMsgBoxAns = IDRETRYC� �    CASE lnMsgBoxAns = IDCANCELC� � ENDCASE�� 2���O T� �C� � DO CASEC� �    CASE lnMsgBoxAns = IDOKC� � ENDCASE�� � ��  � � -��^� T� ��  � �  � �  � ��t T� �� lnMsgBoxAns = MESSAGEBOX("C�  � � �� ",CC� Z�� ,"C�  � � �� "� ,� � ) = CC�  � Z��� H���Z�  ��  � � �	 Ok,Cancel���m T� �C� � DO CASEC� �    CASE lnMsgBoxAns = 1C� �    CASE lnMsgBoxAns = 2C� � ENDCASE�� ��  � � � Ok����L T� �C� � DO CASEC� �    CASE lnMsgBoxAns = 1C� � ENDCASE��) ��  � � � Abort,Retry,Ignore��:	�� T� �C� � DO CASEC� �    CASE lnMsgBoxAns = 3C� �    CASE lnMsgBoxAns = 4C� �    CASE lnMsgBoxAns = 5C� � ENDCASE��$ ��  � � � Yes,No,Cancel���	�� T� �C� � DO CASEC� �    CASE lnMsgBoxAns = 6C� �    CASE lnMsgBoxAns = 7C� �    CASE lnMsgBoxAns = 2C� � ENDCASE�� ��  � � � Yes,No��v
�m T� �C� � DO CASEC� �    CASE lnMsgBoxAns = 6C� �    CASE lnMsgBoxAns = 7C� � ENDCASE��# ��  � � � Retry,Cancel���m T� �C� � DO CASEC� �    CASE lnMsgBoxAns = 4C� �    CASE lnMsgBoxAns = 2C� � ENDCASE�� 2�Z�L T� �C� � DO CASEC� �    CASE lnMsgBoxAns = 1C� � ENDCASE�� � 2�f� � T��� � �� 2��� H����� ��  � � a��&�� T��� MESSAGEBOX("C�  � � �� ",�  � � +�  �	 CC�  �
 �
� � +�  �
 � �  6� ,"C�  � � �� "� ,� � )�� ��  � � -���� T� ��  � �  � �  � ��W T��� MESSAGEBOX("C�  � � �� ",CC� Z�� ,"C�  � � �� "� ,� � )�� 2��� � � T�  � �-�� ��C�  � �� �� U  THISFORM FINISH	 LCTIMEOUT	 OSPINNER1 VALUE CBIF	 CBDEFINES
 EDTMESSAGE	 MBBUTTONS MBDEFBUTTON MBICON TXTTITLE IDRETURN LNSELECTION	 NBBUTTONS NBDEFBUTTON NBICON INRETURN CBDOCASE LCTEXT DDLBDEFBUTTON	 ROWSOURCE LNCASESTATE VISIBLE RELEASE Click,     ��1 � A � a�A � 1� Q�
Q�� A 1� QE� s���
A�	�C1�� �A Q�E� �����A���1�� �A � A � � Q'Q�t� A A � � Q 1                       �      )   �                        oeditbox      cbaseclasslibrary.vcx      editbox      
edtMessage      	__MBOXWIZ      �Height = 56
Left = 9
TabIndex = 2
ToolTipText = "Enter text to be displayed in message box"
Top = 64
Width = 291
ZOrderSet = 3
ControlSource = "Thisform.cMessage"
Name = "edtMessage"
      odropdownlist      cbaseclasslibrary.vcx      combobox      ddlbButtons      	__MBOXWIZ     [ColumnCount = 1
RowSourceType = 1
RowSource = "Ok,Ok / Cancel,Abort / Retry / Ignore,Yes / No / Cancel,Yes / No,Retry / Cancel"
Value = Ok
ControlSource = "Thisform.cButtons"
Height = 24
Left = 9
SelectOnEntry = .T.
TabIndex = 3
ToolTipText = "Select buttons for message box"
Top = 140
Width = 140
ZOrderSet = 4
Name = "ddlbButtons"
      �PROCEDURE Valid
With Thisform
	.CreateRowSource()
	.DDLBDEFBUTTON.Refresh()
	.ddlbReturn.Refresh()
Endwith



ENDPROC
      �PROCEDURE Click
 THISFORM.MBICON = 'MB_ICONSTOP'
 THISFORM.NBICON = 16
 THISFORM.CBEXCLAIM.VALUE = .F.
 THISFORM.CBQUESTION.VALUE = .F.
 THISFORM.CBINFO.VALUE = .F.
 THISFORM.CBNONE.VALUE = .F.
  THISFORM.REFRESHFORM()
ENDPROC
      checkbox      cbaseclasslibrary.vcx      	ocheckbox      otextbox      cbaseclasslibrary.vcx      textbox      txtTitle      	__MBOXWIZ      �ControlSource = "Thisform.cTitle"
Height = 23
Left = 9
TabIndex = 1
ToolTipText = "Enter Text to be displayed as Title of Message Box"
Top = 21
Width = 291
ZOrderSet = 5
Name = "txtTitle"
      olabel      cbaseclasslibrary.vcx      label      Olabel1      	__MBOXWIZ      Caption = "Dialog Box Buttons"
Height = 17
Left = 9
Top = 122
Width = 106
TabIndex = 17
ZOrderSet = 6
Name = "Olabel1"
      olabel      cbaseclasslibrary.vcx      label      Olabel2      	__MBOXWIZ      oCaption = "Title"
Height = 17
Left = 9
Top = 3
Width = 25
TabIndex = 18
ZOrderSet = 7
Name = "Olabel2"
      olabel      cbaseclasslibrary.vcx      label      Olabel3      	__MBOXWIZ      eCaption = "Message"
Left = 9
Top = 46
Width = 53
TabIndex = 19
ZOrderSet = 8
Name = "Olabel3"
      ocommandbutton      cbaseclasslibrary.vcx      commandbutton      
cmdPreview      	__MBOXWIZ      iTop = 231
Left = 3
Width = 65
Caption = "Preview"
TabIndex = 14
ZOrderSet = 9
Name = "cmdPreview"
      �PROCEDURE Click
 LNSELECTION = THISFORM.NBBUTTONS + THISFORM.NBDEFBUTTON + THISFORM.NBICON
  MESSAGEBOX(ALLTRIM(THISFORM.EDTMESSAGE.VALUE),LNSELECTION,ALLTRIM(THISFORM.TXTTITLE.VALUE))
ENDPROC
      �Top = 135
Left = 316
Height = 40
Width = 40
Picture = w95stop.ico
Alignment = 0
Caption = ""
Style = 1
TabIndex = 12
ToolTipText = "Select for stop icon"
ZOrderSet = 19
Name = "cbStop"
      	__MBOXWIZ      cbDoCase      checkbox      cbaseclasslibrary.vcx      	ocheckbox      	__MBOXWIZ      cbIF      olabel      cbaseclasslibrary.vcx      label      Olabel4      	__MBOXWIZ      {Caption = "Default Button"
Height = 17
Left = 9
Top = 167
Width = 79
TabIndex = 20
ZOrderSet = 10
Name = "Olabel4"
      	ocheckbox      cbaseclasslibrary.vcx      checkbox      	cbExclaim      	__MBOXWIZ      �Top = 55
Left = 316
Height = 40
Width = 40
Picture = w95exclaim.ico
Alignment = 0
Caption = ""
Style = 1
TabIndex = 10
ToolTipText = "Select for exclamation icon"
ZOrderSet = 11
Name = "cbExclaim"
      �PROCEDURE Click
 THISFORM.MBICON = 'MB_ICONEXCLAMATION'
 THISFORM.NBICON = 48
 THISFORM.CBINFO.VALUE = .F.
 THISFORM.CBSTOP.VALUE = .F.
 THISFORM.CBQUESTION.VALUE = .F.
 THISFORM.CBNONE.VALUE = .F.
  THISFORM.REFRESHFORM()
ENDPROC
      �PROCEDURE Refresh
If Thisform.lIF
	This.Value = .F.
Endif

ENDPROC
PROCEDURE Valid
Thisform.cbIF.Refresh()
Thisform.ddlbReturn.Refresh()

ENDPROC
      �Top = 138
Left = 173
Width = 71
Alignment = 0
Caption = "DO CASE"
Value = .F.
ControlSource = "Thisform.lDoCase"
TabIndex = 5
ZOrderSet = 17
Name = "cbDoCase"
      checkbox      cbaseclasslibrary.vcx      	ocheckbox      	ocheckbox      cbaseclasslibrary.vcx      checkbox      cbInfo      	__MBOXWIZ      �Top = 15
Left = 316
Height = 40
Width = 40
Picture = w95info.ico
Alignment = 0
Caption = ""
Style = 1
TabIndex = 9
ToolTipText = "Select for Information Icon"
ZOrderSet = 12
Name = "cbInfo"
      �PROCEDURE Click
Thisform.MBICON			  = 'MB_ICONINFORMATION'
Thisform.NBICON			  = 64
Thisform.CBEXCLAIM.Value  = .F.
Thisform.CBSTOP.Value	  = .F.
Thisform.CBQUESTION.Value = .F.
Thisform.CBNONE.Value	  = .F.
Thisform.REFRESHFORM()
ENDPROC
      �PROCEDURE Valid
Thisform.cbDoCase.Refresh()
Thisform.ddlbReturn.Refresh()

ENDPROC
PROCEDURE Refresh
If Thisform.lDoCase
	This.Value = .F.
EndIf

ENDPROC
      �Top = 163
Left = 173
Width = 44
Alignment = 0
Caption = "IF =  "
Value = .F.
ControlSource = "Thisform.lIF"
TabIndex = 6
ZOrderSet = 17
Name = "cbIF"
      	__MBOXWIZ      Olabel5      label      olabel      	ocheckbox      cbaseclasslibrary.vcx      checkbox      
cbQuestion      	__MBOXWIZ      �Top = 95
Left = 316
Height = 40
Width = 40
Picture = w95quest.ico
Alignment = 0
Caption = ""
Style = 1
TabIndex = 11
ToolTipText = "Select for question mark icon"
ZOrderSet = 13
Name = "cbQuestion"
      �PROCEDURE Click
 THISFORM.MBICON = 'MB_ICONQUESTION'
 THISFORM.NBICON = 32
 THISFORM.CBEXCLAIM.VALUE = .F.
 THISFORM.CBSTOP.VALUE = .F.
 THISFORM.CBINFO.VALUE = .F.
 THISFORM.CBNONE.VALUE = .F.
  THISFORM.REFRESHFORM()
ENDPROC
      wBackStyle = 0
Caption = " Icon "
Height = 17
Left = 321
Top = -1
TabIndex = 21
ZOrderSet = 16
Name = "Olabel5"
      cbaseclasslibrary.vcx      �Top = 188
Left = 173
AutoSize = .T.
Alignment = 0
Caption = "Use #DEFINE"
Value = .F.
ControlSource = "Thisform.lDefines"
TabIndex = 8
ToolTipText = "#Define contants are found in FoxPro.h"
ZOrderSet = 15
Name = "cbDefines"
      	ocheckbox      cbaseclasslibrary.vcx      checkbox      cbNone      	__MBOXWIZ      �Top = 175
Left = 316
Height = 40
Width = 40
Alignment = 0
Caption = "None"
Value = .T.
Style = 1
TabIndex = 13
ToolTipText = "Select for no icon to be displayed"
ZOrderSet = 14
Name = "cbNone"
      �PROCEDURE Click
Thisform.MBICON			  = 0
Thisform.NBICON			  = 0
Thisform.CBEXCLAIM.Value  = .F.
Thisform.CBQUESTION.Value = .F.
Thisform.CBINFO.Value	  = .F.
Thisform.CBSTOP.Value	  = .F.
Thisform.REFRESHFORM()
ENDPROC
      	__MBOXWIZ      	cbDefines      checkbox      cbaseclasslibrary.vcx      	ocheckbox     ����    �  �                        ߟ   %   S      �  w   �          �  U  3  ��  � �� � T�  �C�  ���
 ��C� ��	 B��  �� U  CMESSAGE	 NMSGWORDS NOTYET,  ��  � T�  �C�  ���
 ��C� ��	 B��  �� U  CMESSAGE NOTYET	 ��  � � � � � � � �� � � T� �C�	 �
 � ���: T� �� "CC� C�
 �  �C� � " + Chr(13) + "�� "�� %��	 � � a��� �< T� ��	 � � +�	 � CC�	 � �
� � +�	 � � �  6�� �� �  T� �C�	 � �	 � �	 � _�� � T� �� "C�	 � � �� "�� T� ��  �� %�C�	 � � �
��Z�" T� �� , CC�	 � � ��Z��� �9 T� �� MESSAGEBOX(� � , � � , � � � )�� H����� ��	 � � ���b T��� IF � �  = CC�	 � _C� �    � ^^^C� � ELSEC� �    C� � ENDIF�� ��	 � � ���� T� �� lnMsgBoxAns = � �� H�X���  ��	 � � �	 Ok,Cancel���� T� �� DO CASEC� �    � CASE lnMsgBoxAns = IDOKC� �       � ^^^C� �    � CASE lnMsgBoxAns = IDCANCELC� �       C� � ENDCASE�� ��	 � � � Ok����d T� �� DO CASEC� �    � CASE lnMsgBoxAns = IDOKC� �       � ^^^C� � ENDCASE��) ��	 � � � Abort,Retry,Ignore����� T� �� DO CASEC� �    � CASE lnMsgBoxAns = IDABORTC� �       � ^^^C� �    � CASE lnMsgBoxAns = IDRETRYC� �       C� �    � CASE lnMsgBoxAns = IDIGNOREC� �       C� � ENDCASE��$ ��	 � � � Yes,No,Cancel����� T� �� DO CASEC� �    � CASE lnMsgBoxAns = IDYESC� �       � ^^^C� �    � CASE lnMsgBoxAns = IDNOC� �       C� �    � CASE lnMsgBoxAns = IDCANCELC� �       C� � ENDCASE�� ��	 � � � Yes,No��S�� T� �� DO CASEC� �    � CASE lnMsgBoxAns = IDYESC� �       � ^^^C� �    � CASE lnMsgBoxAns = IDNOC� �       C� � ENDCASE��# ��	 � � � Retry,Cancel���� T� �� DO CASEC� �    � CASE lnMsgBoxAns = IDRETRYC� �       � ^^^C� �    � CASE lnMsgBoxAns = IDCANCELC� �       C� � ENDCASE�� 2���d T� �� DO CASEC� �    � CASE lnMsgBoxAns = IDOKC� �       � ^^^C� � ENDCASE�� � T��� C� � �� 2��� T��� �� � %��	 � � 
���� T�  ��  &� & ��" T��C�� IDOK� 1�  � OK���* T��C�� IDCANCEL� 2�  � Cancel���( T��C�� IDABORT� 3�  � Abort���( T��C�� IDRETRY� 4�  � Retry���* T��C�� IDIGNORE� 5�  � Ignore���$ T��C�� IDYES� 6�  � Yes���" T��C�� IDNO� 7�  � No��� � T�	 � �-�� ��C�	 � �� �� U 
 LCCOMMENTS LCDIALOGTYPE LCMESSAGEBOX LCMESSAGETEXT LCTEXT	 LCTIMEOUT
 LCTITLEBAR LNCASESTATE LNSELECTION THISFORM
 EDTMESSAGE VALUE	 CBDEFINES	 MBBUTTONS MBDEFBUTTON MBICON	 NBBUTTONS NBDEFBUTTON NBICON TXTTITLE	 OSPINNER1 CBIF GETRETURNID CBDOCASE DDLBDEFBUTTON	 ROWSOURCE VISIBLE RELEASE� H� ��� ��  � � Ok / Cancel��p � T�  � �� MB_OKCANCEL�� T�  � ���� T�  � ��	 Ok,Cancel�� ��  � � Ok��� � T�  � �� MB_OK�� T�  � �� �� T�  � �� Ok��* ��  � � Abort / Retry / Ignore��<�# T�  � �� MB_ABORTRETRYIGNORE�� T�  � ����" T�  � �� Abort,Retry,Ignore��% ��  � � Yes / No / Cancel���� T�  � �� MB_YESNOCANCEL�� T�  � ���� T�  � �� Yes,No,Cancel�� ��  � � Yes / No��� T�  � �� MB_YESNO�� T�  � ���� T�  � �� Yes,No��" ��  � � Retry / Cancel��r� T�  � �� MB_RETRYCANCEL�� T�  � ���� T�  � �� Retry,Cancel�� 2��� T�  � �� MB_OK�� T�  � �� �� T�  � �� Ok�� � U  THIS CBUTTONS	 MBBUTTONS	 NBBUTTONS
 CROWSOURCEr  T�  �� � ��A ��C�� �) Ok, Cancel, Abort, Retry, Ignore, Yes, No�� ,���� B�C�� �  ����������� U 	 LCIFVALUE THISFORM CIFVALUE	 LARETURNS  ��C �  �  � � �� U  THISFORM	 OSETTINGS SAVE� T�  � �� MB_OK�� T�  � �� �� T�  � �� MB_DEFBUTTON1�� T�  � �� �� T�  � �� �� T�  � �� �� T�  � �� IDOK�� T�  � ����J T�  �	 �C�9�
 � class= ThorFormSettings� thor_tool_messagebox_wiz���� ��C � �  �	 � ��� ��C � �: cButtons, cDefaultButton, lDoCase, lIF, cIFValue, lDefines�@ , MBButtons, MBDEFButton, MBIcon, NBButtons, NBDEFBUTTON, NBIcon�  �	 � �� ��C�  � �� ��C�  � �� U  THIS	 MBBUTTONS	 NBBUTTONS MBDEFBUTTON NBDEFBUTTON MBICON NBICON IDRETURN INRETURN	 OSETTINGS CTHORDISPATCHER RESTORE THISFORM CREATEROWSOURCE REFRESH  ��C�  � � �� U  THISFORM	 CMDCANCEL CLICK	 msgformat,     ��
 pmsgformat�     �� finish�     �� createrowsource    �� getreturnid�    �� Destroy�    �� Init�    �� QueryUnload     ��1 q q � � � 2 q � � � 2 �� R�R�� A �� a!A �� 1'1�� 
�D��A���	15
� DA a� � A BQ!����A!A � � Q 2 � ���aQ!�1!Q����a!��� Q!A 3 �2 A2 Q�A�AR	� � 3 1                       x         �   �           0     B   V  �  y   a   �  �  �   e   �  �  �   g   �    �   u   $  >  �    )   �                             �  &        (    (       @         �                        �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���   wwwwwwwwwwww   wwwwwwwwwwwwwp 0           ww�������������ww;�������������w;�������������w;������ ������p;������ �����p������ �����w ������ ������w  ;�����������p  ;����������p  ����������w   ����������w    ;���� ����p    ;���� ����p    ���0 ;���w     ���  ���w      ;��  ��p      ;��  ��p      ��  ��w       ��  ��w        ;�� ��p        ;�����p        �����w         �����w          ;���p          ;���p          ���w           ���p            ;�              3        �  �  �   �                 �  �  �  �  �  �  �  �  �  ?�  ?�  �  �  ��  �� �� ��������������������������(                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� wwwwwwp       w��������������������p������p �����  �����  � �p  � �p   �     ���    ��p    ��p     �       p   �              �  �  �  �  �  �  �  �  �  �  �?  �             �  &        (    (       @         �                        �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���          p              wp              p             p             �p           �p          ww�ww        wp ��www       ���� wwp      ������� ww     ���������wp   ����������ww   �����������wp ������������wp�������������w�������������wx��������������w��������������w��������������w��������������w��������������w��������������px��������������p������������� �������������   ������������   �����������     ����������     ���������p      w�������w        wx����w          wwwp      ����������������������� ��  ?�  �  �  �  �  �  �   �                             �  �  �  �  �  ?�  �  �� ����(                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���                �     ��p   ��� w  x����p������p������w������������������������ ������ ������  w����p   wwwp  ��  �  �  �  �  �  �  �                  �  �  �  �             �  &        (    (       @         �                        �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���          p              wp              p             p             �p           �p          ww�ww        wp ��www       ���� wwp      ������� ww     ���������wp   ����������ww   �����̏����wp ������������wp�������������w������̏�����wx��������������w��������������w������̏������w��������������w��������������w��������������px��������������p������������� �������������   ������������   ������̏���     ����������     ���������p      w�������w        wx����w          wwwp      ����������������������� ��  ?�  �  �  �  �  �  �   �                             �  �  �  �  �  ?�  �  �� ����(                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���                �     ��p   ��� w  x����p������p������w������������������������ ������ ������  w����p   wwwp  ��  �  �  �  �  �  �  �                  �  �  �  �             �  &        (    (       @         �                        �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���       wwwp          wwwwwww        qwwp      ����wwp     q�������ww    ��������wp   ����������wp  �����������w  �����������wp ������������wp�������������p�������������w�������������w��������������w��������������w��������������w��������������w��������������w��������������w��������������p��������������p�������������p������������� �������������  ������������p  �����������   �����������    ����������     ��������      �������        ����                ����� ��� �  �  �  �  �  �  �  �  �   �                                 �  �  �  �  �  �  �  ?�  � �� ����(                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���   www    w  ����p������p������w������������������������������������������������ ������  ����     �  �  �  �  �                              �  �  �  �  .\ main.h strings.h foxpro.h main.prg c:\foxtmp\ main.fxp capplicationmanager.vcx capplicationmanager.vct cbaseclasslibrary.vcx cbaseclasslibrary.vct msgboxwiz.scx msgboxwiz.sct w95exclaim.ico w95info.ico w95quest.ico w95stop.ico )   f                 f        
             �                  �  <  &   1           <  �      :           �  %$      R           %$  �2      j           �2  �J      �           	�J  �Z      �           �Z  ��      �           ��  ��      �           ��   �      �            �  V�      �           V�  �      �           