��� B   hM iG �                    ��  %   �  �       �  ͊5?    ��. %�� GKTDeclareWinAPIC�	 Procedurev
��H � G+(� GKTDeclareWinAPI� � %�C�9� GKKTools��h��� � %�C�9� ���� � T�9� �C� Empty�N�� � �� � ��C� GKKTools�9� �� T�9� �C� Empty�N�� �& %�C�9� � LastDirectory��h
��"�- ��C�9� � LastDirectoryCC�]C��]��
�� �$ %�C�9� � oGKTToolBar��h
��g� ��C�9� � oGKTToolBar�
�� � %�C�9� � ����� T�9� � �C� GKTTools���� � U  GKTDECLAREWINAPI GKKTOOLS ADDPROPERTY OGKTTOOLBARv ; ��C�
 GKTToolbar� GKKTOOLBARMRU� GKTTOOLBAR.VCX�  � �� ��C� �  � � �� T�  � � ����� T�  � � �a�� U  THIS	 NEWOBJECT
 GKTTOOLBAR DOCK LEFT VISIBLE Init      
 ��    � U   GKTTools Custom�    ��A �qA � qqA a�A B�A B�A 3 �1A2 � 6                    �  ]        �  g     0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _3AP1AMAVW1256552302�      �v  �      t      m  "f          �  �  �e          �      �       WINDOWS _3AM0YKT351256552302�e  e  ne  \e  Ge  �c      9_  UZ                                               WINDOWS _3AP1DCBF11256552302DZ  ,Z  Z  Z  �Y  mX      aT   P                                               WINDOWS _3AR0P9DXB1256552302P  �O  �O  �O  �O  |N      |J  CF                                               WINDOWS _3AP1AMAVW12565523022F  F  	F  �E  �E  �D      �@  N<                                               WINDOWS _3AP1AMAVW1256552302=<  %<  <  <  �;  q:      M6  �1                                               WINDOWS _4QC0X9VKT1256552302�1  �1  �1  �1  �1  �/      �+  s'                                               WINDOWS _3AM0YKT351256552302b'      Q'  ?'  *'  �&                                                           WINDOWS _3AR0P9DXJ1256552302�&  �&  �&  {&  f&  �$      �   p                                               WINDOWS _3AP1AMAVW1256552302Z  @  +            {  T                                               WINDOWS _4YH0VMDGM1256552302>  $    �  �        a  6                                               WINDOWS _3MT029FSS1256552302     �  �  �  �      >                                                 WINDOWS _3AR0T8JYT1256552302�      �  �  �  a                                                           WINDOWS _3AS0JACJ61256552302P  8  '    �  �      �	                                                 COMMENT RESERVED                        �      B                                                          w                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      "  ..\programs\gktdefines.h�ܗ|0?      DSymbol, 0, 11, 9, 19, 15, 17, 4, 0
Arial, 0, 8, 5, 14, 11, 29, 3, 0
      gkktoolbarmru      ..\programs\gktdefines.h      Pixels      Class      14      toolbar      gkktoolbarmru     ����    j  j                        !C   %   �        !   �          �  U   ��  � ��C� � ��" %�� � � � � � � ��C � ��C� � �� � T�  �� � �� s�� �� � ��� � �W�4 s����� "�� GKK Form Editor���� GKTForm.bmp��4 s����� "�� GKK Menu Editor���� GKTMenu.bmp��7 s����� "�� GKK Program Editor���� GKTCode.bmp��@ s����� "�� GKK Visual Class Editor���� GKTClassLib.bmp��= s����� "�� GKK Project Manager���� GKTSmProject.bmp��; s����� "�� GKK Comparison Editors���� compare.bmp��; s����� "�� GKK Code Library���� GKTSnippetMgr.bmp��7 s����� "�� GKK Copy Clip Manager���� Copy.bmp��< s��	��� "�� GKK Table Designer���� GKTTableEdit.bmp��; s��
��� "�� GKK Table Browser���� GKTTableBrow.bmp��8 1������ �& loToolBar.OpenGKKProject("GKKEDITSCX")�8 1������ �& loToolBar.OpenGKKProject("GKKEDITMNU")�8 1������ �& loToolBar.OpenGKKProject("GKKEDITPRG")�8 1������ �& loToolBar.OpenGKKProject("GKKEDITVCX")�< 1������ �* loToolBar.OpenGKKProject("GKKPROJECTDOCK")�8 1������ �& loToolBar.OpenGKKProject("GKKCOMPARE")�< 1������ �* loToolBar.OpenGKKProject("GKKCODELIBRARY")�< 1������ �* loToolBar.OpenGKKProject("GKKCOPYCLIPMGR")�> 1���	��� �, loToolBar.OpenGKKProject("GKKTABLEDESIGNER")�= 1���
��� �+ loToolBar.OpenGKKProject("GKKTABLEBROWSER")� t�� � <�� � U 	 LOTOOLBAR THIS GETMENUPOSITION NSMROW NSMCOL PARENT SHORTCUT  � GKTBuildAll� U  GKTBUILDALL
 onmruclick,     ��
 onfileopen�    ��1 q � !� A �AAq���q������������� � 2 11                               '  :  "    )   j                       EPROCEDURE onmruclick
LOCAL loToolBar
this.GetMenuPosition()
IF this.nSMRow <= 0 .OR. this.nSMCol <= 0
	this.GetMenuPosition()
ENDIF
loToolBar = this.Parent
DEFINE POPUP shortcut SHORTCUT FROM this.nSMRow, this.nSMCol
DEFINE BAR 1 OF shortcut PROMPT "GKK Form Editor" PICTURE "GKTForm.bmp"
DEFINE BAR 2 OF shortcut PROMPT "GKK Menu Editor" PICTURE "GKTMenu.bmp"
DEFINE BAR 3 OF shortcut PROMPT "GKK Program Editor" PICTURE "GKTCode.bmp"
DEFINE BAR 4 OF shortcut PROMPT "GKK Visual Class Editor" PICTURE "GKTClassLib.bmp"
DEFINE BAR 5 OF shortcut PROMPT "GKK Project Manager" PICTURE "GKTSmProject.bmp"
DEFINE BAR 6 OF shortcut PROMPT "GKK Comparison Editors" PICTURE "compare.bmp"
DEFINE BAR 7 OF shortcut PROMPT "GKK Code Library" PICTURE "GKTSnippetMgr.bmp"
DEFINE BAR 8 OF shortcut PROMPT "GKK Copy Clip Manager" PICTURE "Copy.bmp"
DEFINE BAR 9 OF shortcut PROMPT "GKK Table Designer" PICTURE "GKTTableEdit.bmp"
DEFINE BAR 10 OF shortcut PROMPT "GKK Table Browser" PICTURE "GKTTableBrow.bmp"

ON SELECTION BAR 1 OF shortcut loToolBar.OpenGKKProject("GKKEDITSCX")
ON SELECTION BAR 2 OF shortcut loToolBar.OpenGKKProject("GKKEDITMNU")
ON SELECTION BAR 3 OF shortcut loToolBar.OpenGKKProject("GKKEDITPRG")
ON SELECTION BAR 4 OF shortcut loToolBar.OpenGKKProject("GKKEDITVCX")
ON SELECTION BAR 5 OF shortcut loToolBar.OpenGKKProject("GKKPROJECTDOCK")
ON SELECTION BAR 6 OF shortcut loToolBar.OpenGKKProject("GKKCOMPARE")
ON SELECTION BAR 7 OF shortcut loToolBar.OpenGKKProject("GKKCODELIBRARY")
ON SELECTION BAR 8 OF shortcut loToolBar.OpenGKKProject("GKKCOPYCLIPMGR")
ON SELECTION BAR 9 OF shortcut loToolBar.OpenGKKProject("GKKTABLEDESIGNER")
ON SELECTION BAR 10 OF shortcut loToolBar.OpenGKKProject("GKKTABLEBROWSER")

ACTIVATE POPUP shortcut
RELEASE POPUPS shortcut
ENDPROC
PROCEDURE onfileopen
DO FORM GKTBuildAll
ENDPROC
     Top = 3
Left = 603
TabIndex = 10
ToolTipText = "GKK Builder"
Name = "clsMRUBuild"
cmdMRUOpen.Name = "cmdMRUOpen"
cmdOpenFile.Picture = ..\graphics\gktcompile.bmp
cmdOpenFile.Caption = "Build"
cmdOpenFile.ToolTipText = "GKK Builder"
cmdOpenFile.Name = "cmdOpenFile"
      gkktoolbarmru      clsMRUBuild      	container      gktmrubutton.vcx      	mrubutton      [Top = 3
Left = 603
Height = 0
Width = 0
Style = 1
Visible = .T.
Name = "Separator2"
      gkktoolbarmru      
Separator2      	separator      	separator     )���                              "g   %   �       �      �           �  U  ^  ��  �6 T�  �C� GKKSearchGlobal� GKKSearchGlobal.app� �� %�C�  �
��W �
 ��  �� � U 	 LCAPPNAME GKTGETTOOLSPATH Click,     ��1 q a� A 1                       �       )                           �PROCEDURE Click
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKSearchGlobal","GKKSearchGlobal.app")
IF !EMPTY(lcAppName)
	DO (lcAppName)
ENDIF
ENDPROC
      �Top = 3
Left = 546
Height = 22
Width = 50
FontSize = 8
Picture = ..\graphics\gktfind.bmp
Caption = "Srch"
TabIndex = 9
ToolTipText = "GKK Global Search"
SpecialEffect = 2
PicturePosition = 1
Name = "cmdSearch"
      gkktoolbarmru      	cmdSearch      commandbutton      gktbaseclasses.vcx      _commandbutton     #���    
  
                        ��   %   �       �      �           �  U  X  ��  �0 T�  �C� GKKLibrarian� GKKLibrarian.app� �� %�C�  �
��Q �
 ��  �� � U 	 LCAPPNAME GKTGETTOOLSPATH Click,     ��1 q � A 1                       �       )   
                        �PROCEDURE Click
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKLibrarian","GKKLibrarian.app")
IF !EMPTY(lcAppName)
	DO (lcAppName)
ENDIF
ENDPROC
      �Top = 3
Left = 496
Height = 22
Width = 50
FontSize = 8
Picture = ..\graphics\gktclasslib.bmp
Caption = "Lib"
TabIndex = 8
ToolTipText = "GKK Librarian"
SpecialEffect = 2
PicturePosition = 1
Name = "cmdLibrary"
      gkktoolbarmru      
cmdLibrary      commandbutton      gktbaseclasses.vcx      _commandbutton     ���                              '   %   �       �      �           �  U  T  ��  �, T�  �C�
 GKKCompare� GKKCompare.app� �� %�C�  �
��M �
 ��  �� � U 	 LCAPPNAME GKTGETTOOLSPATH Click,     ��1 q �� A 1                       �       )                           �PROCEDURE Click
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKCompare","GKKCompare.app")
IF !EMPTY(lcAppName)
	DO (lcAppName)
ENDIF
ENDPROC
      �Top = 3
Left = 446
Height = 22
Width = 50
FontSize = 8
Picture = ..\graphics\compare.bmp
Caption = "Comp"
TabIndex = 8
ToolTipText = "GKK Comparison Editors"
SpecialEffect = 2
PicturePosition = 1
Name = "cmdCompare"
      gkktoolbarmru      
cmdCompare      commandbutton      gktbaseclasses.vcx      _commandbutton     G���    .  .                        �H   %   B      �  "   �          �  U  } ��  � � � ��� � ��v� %��� � ��r� T�  �� �� ��C� � ��" %�� � � � � � � ��z � ��C� � �� � s��	 �� � ��� � �W� �� ���(��� ��^�6 T� �� loTempRef.OpenFileFromMRUList(C� _� )�� T�
 �CC � �� @��+ s�� ���	 "��
 ���� GKTSmProject.bmp��7 ON SELECTION BAR (lnBar) OF shortcut &lcExecCommand
 �� t��	 � <��	 � � �� U 	 LOTEMPREF LNBAR LCEXECCOMMAND THIS	 GLOBALMRU MRUCOUNT GETMENUPOSITION NSMROW NSMCOL SHORTCUT LCPROMPT MRULISTb  ��  �: T�  �C� GKKProjectManager� GKKProjectManager.APP� �� %�C�  �
��[ �
 ��  �� � U 	 LCAPPNAME GKTGETTOOLSPATHm  ��  � �� �: T� �C� GKKProjectManager� GKKProjectManager.APP� �� %�C� �
��f � �� ���  � � U 
 TCFILENAME	 LCAPPNAME GKTGETTOOLSPATH
 onmruclick,     ��
 onfileopen'    �� onopenfrommru�    ��1 � !� � !� A ��aQ�qA � � A A 2 q �� A 2 q q �� A 1                       �        �  1        U        )   .                       PROCEDURE onmruclick
LOCAL loTempRef, lnBar, lcExecCommand
WITH this.GlobalMRU
	IF .MRUCount > 0
		loTempRef = this
		this.GetMenuPosition()
		IF this.nSMRow <= 0 .OR. this.nSMCol <= 0
			this.GetMenuPosition()
		ENDIF
		DEFINE POPUP shortcut SHORTCUT FROM this.nSMRow, this.nSMCol
		FOR lnBar=1 TO .MRUCount
			lcExecCommand = "loTempRef.OpenFileFromMRUList(" + TRANSFORM(lnBar) + ")"
			lcPrompt = LOWER(.MRUList[lnBar])
			DEFINE BAR (lnBar) OF shortcut PROMPT lcPrompt PICTURE "GKTSmProject.bmp"
			ON SELECTION BAR (lnBar) OF shortcut &lcExecCommand
		ENDFOR
		ACTIVATE POPUP shortcut
		RELEASE POPUPS shortcut
	ENDIF
ENDWITH
ENDPROC
PROCEDURE onfileopen
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKProjectManager","GKKProjectManager.APP")
IF !EMPTY(lcAppName)
	DO (lcAppName)
ENDIF
ENDPROC
PROCEDURE onopenfrommru
LPARAMETERS tcFileName
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKProjectManager","GKKProjectManager.APP")
IF !EMPTY(lcAppName)
	DO (lcAppName) WITH tcFileName
ENDIF
ENDPROC
     �Top = 3
Left = 384
TabIndex = 7
ToolTipText = "Open Project Manager"
mruname = GKKPROJECTDOCK
menubmp = GKKSmProject.bmp
Name = "clsMRUProj"
cmdMRUOpen.Picture = ..\graphics\gktdownarrow.bmp
cmdMRUOpen.Name = "cmdMRUOpen"
cmdOpenFile.Picture = ..\graphics\project.bmp
cmdOpenFile.Caption = "Proj"
cmdOpenFile.ToolTipText = "Open Project Manager"
cmdOpenFile.Name = "cmdOpenFile"
      gkktoolbarmru      
clsMRUProj      	container      gktmrubutton.vcx      	mrubutton      [Top = 3
Left = 384
Height = 0
Width = 0
Style = 1
Visible = .T.
Name = "Separator1"
      gkktoolbarmru      
Separator1      	separator      	separator     C���    *  *                        �   %   >      �  "   }          �  U  } ��  � � � ��� � ��v� %��� � ��r� T�  �� �� ��C� � ��" %�� � � � � � � ��z � ��C� � �� � s��	 �� � ��� � �W� �� ���(��� ��^�6 T� �� loTempRef.OpenFileFromMRUList(C� _� )�� T�
 �CC � �� @��+ s�� ���	 "��
 ���� gkttablebrow.bmp��7 ON SELECTION BAR (lnBar) OF shortcut &lcExecCommand
 �� t��	 � <��	 � � �� U 	 LOTEMPREF LNBAR LCEXECCOMMAND THIS	 GLOBALMRU MRUCOUNT GETMENUPOSITION NSMROW NSMCOL SHORTCUT LCPROMPT MRULIST^  ��  �6 T�  �C� GKKTableBrowser� GKKTableBrowser.APP� �� %�C�  �
��W �
 ��  �� � U 	 LCAPPNAME GKTGETTOOLSPATHm  ��  � �� �2 T� �C�
 GKKEditDBF� GKKTableDesigner.APP� �� %�C� �
��f � �� ���  ������� � U 
 TCFILENAME	 LCAPPNAME GKTGETTOOLSPATH
 onmruclick,     ��
 onfileopen'    �� onopenfrommru�    ��1 � !� � !� A ��aQ�qA � � A A 2 q a� A 2 q q !aA 1                       �        �  -        Q        )   *                       PROCEDURE onmruclick
LOCAL loTempRef, lnBar, lcExecCommand
WITH this.GlobalMRU
	IF .MRUCount > 0
		loTempRef = this
		this.GetMenuPosition()
		IF this.nSMRow <= 0 .OR. this.nSMCol <= 0
			this.GetMenuPosition()
		ENDIF
		DEFINE POPUP shortcut SHORTCUT FROM this.nSMRow, this.nSMCol
		FOR lnBar=1 TO .MRUCount
			lcExecCommand = "loTempRef.OpenFileFromMRUList(" + TRANSFORM(lnBar) + ")"
			lcPrompt = LOWER(.MRUList[lnBar])
			DEFINE BAR (lnBar) OF shortcut PROMPT lcPrompt PICTURE "gkttablebrow.bmp"
			ON SELECTION BAR (lnBar) OF shortcut &lcExecCommand
		ENDFOR
		ACTIVATE POPUP shortcut
		RELEASE POPUPS shortcut
	ENDIF
ENDWITH
ENDPROC
PROCEDURE onfileopen
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKTableBrowser","GKKTableBrowser.APP")
IF !EMPTY(lcAppName)
	DO (lcAppName)
ENDIF
ENDPROC
PROCEDURE onopenfrommru
LPARAMETERS tcFileName
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKEditDBF","GKKTableDesigner.APP")
IF !EMPTY(lcAppName)
	DO (lcAppName) WITH tcFileName, .NULL., .NULL.
ENDIF
ENDPROC
     �Top = 3
Left = 315
TabIndex = 6
ToolTipText = "Browse Tables"
mruname = GKKEDITDBF
menubmp = GKTTableEdit.bmp
Name = "clsMRUBrowTbl"
cmdMRUOpen.Picture = ..\graphics\gktdownarrow.bmp
cmdMRUOpen.TabIndex = 2
cmdMRUOpen.Name = "cmdMRUOpen"
cmdOpenFile.Picture = ..\graphics\gkttablebrow.bmp
cmdOpenFile.Caption = "DBF"
cmdOpenFile.TabIndex = 1
cmdOpenFile.ToolTipText = "Browse Tables"
cmdOpenFile.Name = "cmdOpenFile"
      gkktoolbarmru      clsMRUBrowTbl      	container      gktmrubutton.vcx      	mrubutton     P���    7  7                        ��   %   K      �  "   �          �  U  ~  ��  � �� �2 T� �C�
 GKKEditDBF� GKKTableDesigner.APP� �� %�C� �
��w �' �� ���  ����������a������� � U 
 TCFILENAME	 LCAPPNAME GKTGETTOOLSPATHZ  ��  �2 T�  �C�
 GKKEditDBF� GKKTableDesigner.APP� �� %�C�  �
��S �
 ��  �� � U 	 LCAPPNAME GKTGETTOOLSPATH} ��  � � � ��� � ��v� %��� � ��r� T�  �� �� ��C� � ��" %�� � � � � � � ��z � ��C� � �� � s��	 �� � ��� � �W� �� ���(��� ��^�6 T� �� loTempRef.OpenFileFromMRUList(C� _� )�� T�
 �CC � �� @��+ s�� ���	 "��
 ���� gkttableedit.bmp��7 ON SELECTION BAR (lnBar) OF shortcut &lcExecCommand
 �� t��	 � <��	 � � �� U 	 LOTEMPREF LNBAR LCEXECCOMMAND THIS	 GLOBALMRU MRUCOUNT GETMENUPOSITION NSMROW NSMCOL SHORTCUT LCPROMPT MRULIST onopenfrommru,     ��
 onfileopen�     ��
 onmruclickP    ��1 q q !qA 2 q !� A 2 � !� � !� A ��aQ�qA � � A A 1                       �         �   }  	      �        )   7                       PROCEDURE onopenfrommru
LPARAMETERS tcFileName
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKEditDBF","GKKTableDesigner.APP")
IF !EMPTY(lcAppName)
	DO (lcAppName) WITH tcFileName, 3, .NULL., .NULL., True, -1
ENDIF
ENDPROC
PROCEDURE onfileopen
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKEditDBF","GKKTableDesigner.APP")
IF !EMPTY(lcAppName)
	DO (lcAppName)
ENDIF
ENDPROC
PROCEDURE onmruclick
LOCAL loTempRef, lnBar, lcExecCommand
WITH this.GlobalMRU
	IF .MRUCount > 0
		loTempRef = this
		this.GetMenuPosition()
		IF this.nSMRow <= 0 .OR. this.nSMCol <= 0
			this.GetMenuPosition()
		ENDIF
		DEFINE POPUP shortcut SHORTCUT FROM this.nSMRow, this.nSMCol
		FOR lnBar=1 TO .MRUCount
			lcExecCommand = "loTempRef.OpenFileFromMRUList(" + TRANSFORM(lnBar) + ")"
			lcPrompt = LOWER(.MRUList[lnBar])
			DEFINE BAR (lnBar) OF shortcut PROMPT lcPrompt PICTURE "gkttableedit.bmp"
			ON SELECTION BAR (lnBar) OF shortcut &lcExecCommand
		ENDFOR
		ACTIVATE POPUP shortcut
		RELEASE POPUPS shortcut
	ENDIF
ENDWITH
ENDPROC
     uTop = 3
Left = 253
TabIndex = 5
ToolTipText = "Edit Tables"
mruname = GKKEDITDBF
menubmp = GKTTableEdit.bmp
Name = "clsMRUDbf"
cmdMRUOpen.Picture = ..\graphics\gktdownarrow.bmp
cmdMRUOpen.Name = "cmdMRUOpen"
cmdOpenFile.Picture = ..\graphics\gkttableedit.bmp
cmdOpenFile.Caption = "DBF"
cmdOpenFile.ToolTipText = "Edit Tables"
cmdOpenFile.Name = "cmdOpenFile"
      gkktoolbarmru      	clsMRUDbf      	container      gktmrubutton.vcx      	mrubutton     ?���    &  &                        [�   %   :      �  "   y          �  U  x ��  � � � ��� � ��q� %��� � ��m� T�  �� �� ��C� � ��" %�� � � � � � � ��z � ��C� � �� � s��	 �� � ��� � �W� �� ���(��� ��Y�6 T� �� loTempRef.OpenFileFromMRUList(C� _� )�� T�
 �CC � �� @��& s�� ���	 "��
 ���� GKTMenu.bmp��7 ON SELECTION BAR (lnBar) OF shortcut &lcExecCommand
 �� t��	 � <��	 � � �� U 	 LOTEMPREF LNBAR LCEXECCOMMAND THIS	 GLOBALMRU MRUCOUNT GETMENUPOSITION NSMROW NSMCOL SHORTCUT LCPROMPT MRULISTT  ��  �, T�  �C�
 GKKEditMnu� GKKEditMnu.app� �� %�C�  �
��M �
 ��  �� � U 	 LCAPPNAME GKTGETTOOLSPATHx  ��  � �� �, T� �C�
 GKKEditMNU� GKKEditMNU.APP� �� %�C� �
��q �' �� ���  ����������a������� � U 
 TCFILENAME	 LCAPPNAME GKTGETTOOLSPATH
 onmruclick,     ��
 onfileopen"    �� onopenfrommru�    ��1 � !� � !� A ��aQaqA � � A A 2 q �� A 2 q q �qA 1                       �        �          B         )   &                       PROCEDURE onmruclick
LOCAL loTempRef, lnBar, lcExecCommand
WITH this.GlobalMRU
	IF .MRUCount > 0
		loTempRef = this
		this.GetMenuPosition()
		IF this.nSMRow <= 0 .OR. this.nSMCol <= 0
			this.GetMenuPosition()
		ENDIF
		DEFINE POPUP shortcut SHORTCUT FROM this.nSMRow, this.nSMCol
		FOR lnBar=1 TO .MRUCount
			lcExecCommand = "loTempRef.OpenFileFromMRUList(" + TRANSFORM(lnBar) + ")"
			lcPrompt = LOWER(.MRUList[lnBar])
			DEFINE BAR (lnBar) OF shortcut PROMPT lcPrompt PICTURE "GKTMenu.bmp"
			ON SELECTION BAR (lnBar) OF shortcut &lcExecCommand
		ENDFOR
		ACTIVATE POPUP shortcut
		RELEASE POPUPS shortcut
	ENDIF
ENDWITH
ENDPROC
PROCEDURE onfileopen
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKEditMnu","GKKEditMnu.app")
IF !EMPTY(lcAppName)
	DO (lcAppName)
ENDIF
ENDPROC
PROCEDURE onopenfrommru
LPARAMETERS tcFileName
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKEditMNU","GKKEditMNU.APP")
IF !EMPTY(lcAppName)
	DO (lcAppName) WITH tcFileName, 3, .NULL., .NULL., True, -1
ENDIF
ENDPROC
     3Top = 3
Left = 191
TabIndex = 4
ToolTipText = "Edit Menus"
mruname = GKKEDITMNU
menubmp = GKTMenu.bmp
Name = "clsMRUMnu"
cmdMRUOpen.Name = "cmdMRUOpen"
cmdOpenFile.Picture = ..\graphics\menu.bmp
cmdOpenFile.Caption = "MNU"
cmdOpenFile.ToolTipText = "Edit Menus"
cmdOpenFile.Name = "cmdOpenFile"
      gkktoolbarmru      	clsMRUMnu      	container      gktmrubutton.vcx      	mrubutton     1���                              bZ   %   ,      �  "   k          �  U  x ��  � � � ��� � ��q� %��� � ��m� T�  �� �� ��C� � ��" %�� � � � � � � ��z � ��C� � �� � s��	 �� � ��� � �W� �� ���(��� ��Y�6 T� �� loTempRef.OpenFileFromMRUList(C� _� )�� T�
 �CC � �� @��& s�� ���	 "��
 ���� GKTCode.bmp��7 ON SELECTION BAR (lnBar) OF shortcut &lcExecCommand
 �� t��	 � <��	 � � �� U 	 LOTEMPREF LNBAR LCEXECCOMMAND THIS	 GLOBALMRU MRUCOUNT GETMENUPOSITION NSMROW NSMCOL SHORTCUT LCPROMPT MRULISTT  ��  �, T�  �C�
 GKKEditPrg� GKKEditPrg.app� �� %�C�  �
��M �
 ��  �� � U 	 LCAPPNAME GKTGETTOOLSPATHj  ��  � �� �, T� �C�
 GKKEditPRG� GKKEditPRG.APP� �� %�C� �
��c � �� ���  �a������� � U 
 TCFILENAME	 LCAPPNAME GKTGETTOOLSPATH
 onmruclick,     ��
 onfileopen"    �� onopenfrommru�    ��1 � !� � !� A ��aQaqA � � A A 2 q �� A 2 q q ��A 1                       �        �          B  �      )                          �PROCEDURE onmruclick
LOCAL loTempRef, lnBar, lcExecCommand
WITH this.GlobalMRU
	IF .MRUCount > 0
		loTempRef = this
		this.GetMenuPosition()
		IF this.nSMRow <= 0 .OR. this.nSMCol <= 0
			this.GetMenuPosition()
		ENDIF
		DEFINE POPUP shortcut SHORTCUT FROM this.nSMRow, this.nSMCol
		FOR lnBar=1 TO .MRUCount
			lcExecCommand = "loTempRef.OpenFileFromMRUList(" + TRANSFORM(lnBar) + ")"
			lcPrompt = LOWER(.MRUList[lnBar])
			DEFINE BAR (lnBar) OF shortcut PROMPT lcPrompt PICTURE "GKTCode.bmp"
			ON SELECTION BAR (lnBar) OF shortcut &lcExecCommand
		ENDFOR
		ACTIVATE POPUP shortcut
		RELEASE POPUPS shortcut
	ENDIF
ENDWITH
ENDPROC
PROCEDURE onfileopen
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKEditPrg","GKKEditPrg.app")
IF !EMPTY(lcAppName)
	DO (lcAppName)
ENDIF
ENDPROC
PROCEDURE onopenfrommru
LPARAMETERS tcFileName
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKEditPRG","GKKEditPRG.APP")
IF !EMPTY(lcAppName)
	DO (lcAppName) WITH tcFileName, True, -1
ENDIF
ENDPROC
     <Top = 3
Left = 129
TabIndex = 3
ToolTipText = "Edit Programs"
mruname = GKKEDITPRG
menubmp = GKTCode.bmp
Name = "clsMRUPrg"
cmdMRUOpen.Name = "cmdMRUOpen"
cmdOpenFile.Picture = ..\graphics\program.bmp
cmdOpenFile.Caption = "PRG"
cmdOpenFile.ToolTipText = "Edit Programs"
cmdOpenFile.Name = "cmdOpenFile"
      gkktoolbarmru      	clsMRUPrg      	container      gktmrubutton.vcx      	mrubutton     9���                                )�   %   4      �  "   s          �  U  | ��  � � � ��� � ��u� %��� � ��q� T�  �� �� ��C� � ��" %�� � � � � � � ��z � ��C� � �� � s��	 �� � ��� � �W� �� ���(��� ��]�6 T� �� loTempRef.OpenFileFromMRUList(C� _� )�� T�
 �CC � �� @��* s�� ���	 "��
 ���� GKTClassLib.bmp��7 ON SELECTION BAR (lnBar) OF shortcut &lcExecCommand
 �� t��	 � <��	 � � �� U 	 LOTEMPREF LNBAR LCEXECCOMMAND THIS	 GLOBALMRU MRUCOUNT GETMENUPOSITION NSMROW NSMCOL SHORTCUT LCPROMPT MRULISTT  ��  �, T�  �C�
 GKKEditVCX� GKKEditVCX.APP� �� %�C�  �
��M �
 ��  �� � U 	 LCAPPNAME GKTGETTOOLSPATHn  ��  � �� �, T� �C�
 GKKEditVCX� GKKEditVCX.APP� �� %�C� �
��g � �� ���  ����a������� � U 
 TCFILENAME	 LCAPPNAME GKTGETTOOLSPATH
 onmruclick,     ��
 onfileopen&    �� onopenfrommru�    ��1 � !� � !� A ��aQ�qA � � A A 2 q �� A 2 q q ��A 1                       �        �  "        F  �      )                           PROCEDURE onmruclick
LOCAL loTempRef, lnBar, lcExecCommand
WITH this.GlobalMRU
	IF .MRUCount > 0
		loTempRef = this
		this.GetMenuPosition()
		IF this.nSMRow <= 0 .OR. this.nSMCol <= 0
			this.GetMenuPosition()
		ENDIF
		DEFINE POPUP shortcut SHORTCUT FROM this.nSMRow, this.nSMCol
		FOR lnBar=1 TO .MRUCount
			lcExecCommand = "loTempRef.OpenFileFromMRUList(" + TRANSFORM(lnBar) + ")"
			lcPrompt = LOWER(.MRUList[lnBar])
			DEFINE BAR (lnBar) OF shortcut PROMPT lcPrompt PICTURE "GKTClassLib.bmp"
			ON SELECTION BAR (lnBar) OF shortcut &lcExecCommand
		ENDFOR
		ACTIVATE POPUP shortcut
		RELEASE POPUPS shortcut
	ENDIF
ENDWITH
ENDPROC
PROCEDURE onfileopen
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKEditVCX","GKKEditVCX.APP")
IF !EMPTY(lcAppName)
	DO (lcAppName)
ENDIF
ENDPROC
PROCEDURE onopenfrommru
LPARAMETERS tcFileName
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKEditVCX","GKKEditVCX.APP")
IF !EMPTY(lcAppName)
	DO (lcAppName) WITH tcFileName, .NULL., True, -1
ENDIF
ENDPROC
     ~Top = 3
Left = 67
TabIndex = 2
ToolTipText = "Edit Visual Classes"
menubmp = GKTClassLib.bmp
mruname = GKKEDITVCX
Name = "clsMRUClass"
cmdMRUOpen.Picture = ..\graphics\gktdownarrow.bmp
cmdMRUOpen.Name = "cmdMRUOpen"
cmdOpenFile.Picture = ..\graphics\class.bmp
cmdOpenFile.Caption = "VCX"
cmdOpenFile.ToolTipText = "Edit Visual Classes"
cmdOpenFile.Name = "cmdOpenFile"
      gkktoolbarmru      clsMRUClass      	container      gktmrubutton.vcx      	mrubutton     ����    �  �                        �$   %   �      J  (   �          �  U  x ��  � � � ��� � ��q� %��� � ��m� T�  �� �� ��C� � ��" %�� � � � � � � ��z � ��C� � �� � s��	 �� � ��� � �W� �� ���(��� ��Y�6 T� �� loTempRef.OpenFileFromMRUList(C� _� )�� T�
 �CC � �� @��& s�� ���	 "��
 ���� GKTForm.bmp��7 ON SELECTION BAR (lnBar) OF shortcut &lcExecCommand
 �� t��	 � <��	 � � �� U 	 LOTEMPREF LNBAR LCEXECCOMMAND THIS	 GLOBALMRU MRUCOUNT GETMENUPOSITION NSMROW NSMCOL SHORTCUT LCPROMPT MRULISTT  ��  �, T�  �C�
 GKKEditSCX� GKKEditSCX.APP� �� %�C�  �
��M �
 ��  �� � U 	 LCAPPNAME GKTGETTOOLSPATHj  ��  � �� �, T� �C�
 GKKEditSCX� GKKEditSCX.APP� �� %�C� �
��c � �� ���  �a������� � U 
 TCFILENAME	 LCAPPNAME GKTGETTOOLSPATHT  ��  �, T�  �C�
 GKKEditSCX� GKKEditSCX.APP� �� %�C�  �
��M �
 ��  �� � U 	 LCAPPNAME GKTGETTOOLSPATH
 onmruclick,     ��
 onfileopen"    �� onopenfrommru�    �� cmdOpenFile.Click,    ��1 � !� � !� A ��aQaqA � � A A 2 q �� A 2 q q ��A 2 q �� A 1                       �        �          B  �     "     �  %    )   �                       �PROCEDURE onmruclick
LOCAL loTempRef, lnBar, lcExecCommand
WITH this.GlobalMRU
	IF .MRUCount > 0
		loTempRef = this
		this.GetMenuPosition()
		IF this.nSMRow <= 0 .OR. this.nSMCol <= 0
			this.GetMenuPosition()
		ENDIF
		DEFINE POPUP shortcut SHORTCUT FROM this.nSMRow, this.nSMCol
		FOR lnBar=1 TO .MRUCount
			lcExecCommand = "loTempRef.OpenFileFromMRUList(" + TRANSFORM(lnBar) + ")"
			lcPrompt = LOWER(.MRUList[lnBar])
			DEFINE BAR (lnBar) OF shortcut PROMPT lcPrompt PICTURE "GKTForm.bmp"
			ON SELECTION BAR (lnBar) OF shortcut &lcExecCommand
		ENDFOR
		ACTIVATE POPUP shortcut
		RELEASE POPUPS shortcut
	ENDIF
ENDWITH
ENDPROC
PROCEDURE onfileopen
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKEditSCX","GKKEditSCX.APP")
IF !EMPTY(lcAppName)
	DO (lcAppName)
ENDIF
ENDPROC
PROCEDURE onopenfrommru
LPARAMETERS tcFileName
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKEditSCX","GKKEditSCX.APP")
IF !EMPTY(lcAppName)
	DO (lcAppName) WITH tcFileName, True, -1
ENDIF
ENDPROC
PROCEDURE cmdOpenFile.Click
LOCAL lcAppName
lcAppName = GKTGetToolsPath("GKKEditSCX","GKKEditSCX.APP")
IF !EMPTY(lcAppName)
	DO (lcAppName)
ENDIF
ENDPROC
     eTop = 3
Left = 5
TabIndex = 1
ToolTipText = "Edit Forms"
mruname = GKKEDITSCX
menubmp = GKTForm.bmp
Name = "clsMRUForm"
cmdMRUOpen.Picture = ..\graphics\gktdownarrow.bmp
cmdMRUOpen.Name = "cmdMRUOpen"
cmdOpenFile.Picture = ..\graphics\form.bmp
cmdOpenFile.Caption = "SCX"
cmdOpenFile.ToolTipText = "Edit Forms"
cmdOpenFile.Name = "cmdOpenFile"
      gkktoolbarmru      
clsMRUForm      	container      gktmrubutton.vcx      	mrubutton      r_memberdata XML Metadata for customizable properties
*opengkkproject Opens the selected GKK project for editing
     ����    �  �                        UE   %           *   +          �  U  � ��  � H� ���! ��  � GKKTABLEDESIGNER��� �6 G(��+ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS�� /�� GKKTableDesigner.pjx:� ��  � GKKFORMLAYOUT��� �6 G(��+ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS�� /�� GKKLayoutEditor.pjx:� ��  �
 GKKEDITMNU��`�6 G(��+ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS�� /�� GKKEditMNU.pjx:� ��  �
 GKKEDITPRG����6 G(��+ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS�� /�� GKKEditPRG.pjx:� ��  �
 GKKEDITSCX��0�6 G(��+ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS�� /�� GKKEditSCX.pjx:� ��  �
 GKKEDITVCX����6 G(��+ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS�� /�� GKKEditVCX.pjx:� ��  � GKKPROJECTDOCK���= G(��2 E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\PROJECTMANAGER�� /�� GKKProjectManager.pjx:� ��  �
 GKKCOMPARE��}�9 G(��. E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\COMPARISON�� /�� GKKCompare.pjx:� ��  � GKKCODELIBRARY����: G(��/ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\CODELIBRARY�� /�� GKKCodeLibrary.pjx:� ��  � GKKCOPYCLIPMGR��a�6 G(��+ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS�� /�� GKKCopyClipMgr.pjx:�  ��  � GKKTABLEBROWSER����6 G(��+ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS�� /�� GKKTableBrowser.pjx:� � U 	 TCGKKTOOL GKKTABLEDESIGNER PJX GKKLAYOUTEDITOR
 GKKEDITMNU
 GKKEDITPRG
 GKKEDITSCX
 GKKEDITVCX GKKPROJECTMANAGER
 GKKCOMPARE GKKCODELIBRARY GKKCOPYCLIPMGR GKKTABLEBROWSER4   %�C�9� oGKTToolBar��h��- � T�9�  ���� � U  OGKTTOOLBAR opengkkproject,     �� Destroy�    ��1 q � a��a��aq�aq�aq�aq�����q����a�a�B 2 � A 1                            &   �  �  2    )   �                       �PROCEDURE opengkkproject
LPARAMETERS tcGKKTool
DO CASE
	CASE tcGKKTool = "GKKTABLEDESIGNER"
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS"
		MODIFY PROJECT GKKTableDesigner.pjx NOWAIT

	CASE tcGKKTool = "GKKFORMLAYOUT"
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS"
		MODIFY PROJECT GKKLayoutEditor.pjx NOWAIT

	CASE tcGKKTool = "GKKEDITMNU"
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS"
		MODIFY PROJECT GKKEditMNU.pjx NOWAIT

	CASE tcGKKTool = "GKKEDITPRG"
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS"
		MODIFY PROJECT GKKEditPRG.pjx NOWAIT

	CASE tcGKKTool = "GKKEDITSCX"
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS"
		MODIFY PROJECT GKKEditSCX.pjx NOWAIT

	CASE tcGKKTool = "GKKEDITVCX"
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS"
		MODIFY PROJECT GKKEditVCX.pjx NOWAIT

	CASE tcGKKTool = "GKKPROJECTDOCK"
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\PROJECTMANAGER"
		MODIFY PROJECT GKKProjectManager.pjx NOWAIT	

	CASE tcGKKTool = "GKKCOMPARE"
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\COMPARISON"
		MODIFY PROJECT GKKCompare.pjx NOWAIT
		
	CASE tcGKKTool = "GKKCODELIBRARY"
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\CODELIBRARY"
		MODIFY PROJECT GKKCodeLibrary.pjx NOWAIT
		
	CASE tcGKKTool = "GKKCOPYCLIPMGR"
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS"
		MODIFY PROJECT GKKCopyClipMgr.pjx NOWAIT
		
	CASE tcGKKTool = "GKKTABLEBROWSER"
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS"
		MODIFY PROJECT GKKTableBrowser.pjx NOWAIT
		
ENDCASE
ENDPROC
PROCEDURE Destroy
IF PEMSTATUS(_SCREEN,"oGKTToolBar",5)
	_SCREEN.oGKTToolBar = .NULL.
ENDIF
ENDPROC
     �Caption = "Toolbar1"
Height = 28
Left = 0
Top = 0
Width = 670
_memberdata =       95<VFPData><memberdata name="opengkkproject" type="method" display="OpenGKKProject"/></VFPData>

Name = "gkktoolbarmru"
      toolbarBMn      6   (               8                  ���������������������������������������������������������   ������������������������������������   ������������������   ���������������������������������   ��    ���������������   ������������������������������   �� �� ��    ������������   ���������������������������������   �� �� ��    ���������   ������������������������������������   ��    ������������   ���������������������������������������   ���������������   ���������������������������������������������������������   ���������������������������������������   ���������������   ������������   ���������������������     �   ������������   ���������    ��   ���������������   � �  �  �   ���������   ������    �� �� ��   ���������������   � �  �  �   ������   ���    �� �� �� �� ��   ���������������   � �   ���������   ������    �� �� �� �� ��   ���������������   ������������   ���������    �� �� ��   ���������������������������������   ������������    ��   ������������������������������������   ���������������   ���������������������������������������   ���������������������������������������������������������   BM6      6   (                              ���������������������������������������������������������������������������������������������������������������������������������������������������                                       ���������   ����� ����� ����� ����� ����� ���   ���������   ��          ��                ��    ���������   ����� ����� ���   ���������   ���   ���������   ��          ��                ��    ���������   ����� ����� ����� ����� ����� ���   ���������   ��          ��                ��    ���������   ����� ����� ���   ���������   ���   ���������   ��          ��                ��    ���������   ����� ����� ����� ����� ����� ���   ���������                                       ������������������������������������������������������������������������������������������������������BM6      6   (                              ���������������������������������������������������������������������������������������������������������������                        ������������������������   ������������������   ������������������������   ���            ���   ������������������������   ������������������   ������������������������   ���         ������   ������������������������   ������������������   ������������������������   �  �  �  �  �  �     ������������������������   ������������������   ������������������������   ���            ���   ������������������������   ������������������   ������������                                          ������   ����������  �  �  �  �  ������������   ������                                          ���������������������������������������������������BM6      6   (                  �  �          ������������������������������������������������������������������������������������������������                                             ���   ���������������������������������������   ���   ���������������������������������������   ���   ���   ���   ���      ���������      ���   ���   ���   ���   ���   ���   ���   ���������   ���   ���         ���      ������   ���������   ���   ���   ���   ���   ���   ���   ���������   ���   ������   ������      ���������      ���   ���   ���������������������������������������   ����  �  �  �  �  �  �  �  �  �  �  �  �  �  �  ����  �  �  �  �  �  �  �  �  �  �  �  �  �  �  ����  �  �  �  �  �  �  �  �  �  �  �  �  �  �  ���������������������������������������������������������������������������������������������������BMv      6   (               @  �  �          ��������������������������������������������������� ���                                             ��� ���   ���������������������������������������   ��� ���   ���������������                     ���   ��� ���   ���������������   ���������������   ���   ��� ���   ���               ���������������   ���   ��� ���   ���   ���������   ���������������   ���   ��� ���   ���   ����������  �  �  �  �  �  �  ���   ��� ���   ���   ����������  �  �  �  �  �  �  ���   ��� ���   ���   ���������������������   ���������   ��� ���   ����  �  �  �  �  �  �  �  �  ���������   ��� ���   ����  �  �  �  �  �  �  �  �  ���������   ��� ���   ���������������������������������������   ��� ����  �  �  �  �  �  �  �  �  �  �  �  �  �  �  ��� ����  �  �  �  �  �  �  �  �  �  �  �  �  �  �  ��� ��������������������������������������������������� BM6      6   (                                  ������������������������������������������������������������������������������������������  `  �  �  `??_������?__ `` �� �� @@���������  _  �  �  �  �  � �� �� �� �� �� @@���  �  �  �  �  �  �  @ __ �� �� �� �� �� ��  �  �  �  �  �  �  _ __ �� �� �� �� �� ��  �  �  �  �  �  �  @  �� �� �� �� �� �����    �  �  �  �  � �� �� �� �� �� @@���������  ????  _??������? �� `` �� __������������������������������������???������������������???������������������???  ���������������������������������?? �   ��� �   ������������������������������    �������������������������������������������������������������������������������������������������������������������������������������������������������������   %   �e      �|  �  w  |0?�   �  U  m  ��  � � � �5 |�� SHGetSpecialFolderPath� Shell32.DLL�����" B�C ��  ��  ��  �� � �� U 	 HWNDOWNER LPSZPATH NFOLDER IFCREATE SHGETSPECIALFOLDERPATH SHELL32 DLLY  ��  � � �1 |� RtlMoveMemory� WIN32APIQ� RtlS2PL���� B�C�  �  � � �� U  TNDEST TCSRC TNLEN RTLMOVEMEMORY WIN32API RTLS2PLH  ��  � �( |�� SetFileAttributes� WIN32API��� B�C �   � � �� U 
 TCFILENAME TNFILEATTRIBUTES SETFILEATTRIBUTES WIN32API>  ��  �& |�� GetFileAttributes� WIN32API�� B�C �  � �� U 
 TCFILENAME GETFILEATTRIBUTES WIN32APII  ��  � � �! |�� CopyFile� Win32API���� B�C �   �  � � �� U  TCSOURCEFILENAME TCDESTFILENAME TLFAILIFEXISTS COPYFILE WIN32API?  ��  � � |�� MoveFile� Win32API��� B�C �   � � �� U  TCSOURCEFILENAME TCDESTFILENAME MOVEFILE WIN32APIw  ��  � � � � � �7 |�� DocumentProperties� winspool.drv�������" B�C �   �  � � �  � � �� U	  LHWND	 LHPRINTER PCPRINTERNAME LCDEVMODEOUTPUT LCDEVMODEINPUT LNMODE DOCUMENTPROPERTIES WINSPOOL DRV=  ��  �% |�� ClosePrinter� winspool.drv�� B�C �  � �� U 	 LHPRINTER CLOSEPRINTER WINSPOOL DRVQ  ��  � � �) |�� OpenPrinter� winspool.drv���� B�C �  �  � � �� U  PCPRINTERNAME	 LHPRINTER	 LNDEFAULT OPENPRINTER WINSPOOL DRV?  ��  � � |�� StartDoc� Win32API��� B�C �   � � �� U  HDC LPDI STARTDOC WIN32API3  ��  � |�� EndDoc� Win32API�� B�C �  � �� U  HDC ENDDOC WIN32API4  ��  � |�� EndPage� Win32API�� B�C �  � �� U  HDC ENDPAGE WIN32API6  ��  � |��	 StartPage� Win32API�� B�C �  � �� U  HDC	 STARTPAGE WIN32API5  ��  � |�� AbortDoc� Win32API�� B�C �  � �� U  HDC ABORTDOC WIN32API=  ��  �% |�� CoCreateGuid��	 OLE32.dll��� B�C�  � �� U  TPGUID COCREATEGUIDT  ��  � � �, |�� StringFromGUID2��	 OLE32.dll����� B�C �  �  � � �� U  TRGUID TPSZ TCHMAX STRINGFROMGUID2F  ��  �. |�� UuidCreateSequential��
 RPCRT4.dll��� B�C�  � �� U  TUUID UUIDCREATESEQUENTIALH  ��  � �( |�� UuidFromString�
 rpcrt4.DLL��� B�C �  � � �� U  TSSTRINGUUID TSGUID UUIDFROMSTRING RPCRT4 DLLU  ��  � � �- |�� GdiplusStartup� GDIPLUS.DLL���� B�C�  � � � �� U  TNTOKEN PCINPUT TNOUTPUT GDIPLUSSTARTUP GDIPLUS DLL?  ��  �' |�� GdiplusShutdown� GDIPLUS.DLL�� B�C �  � �� U  TNTOKEN GDIPLUSSHUTDOWN GDIPLUS DLLV  ��  � �6 |�� GdipGetImageGraphicsContext� GDIPLUS.DLL��� B�C �  � � �� U  TNIMAGE
 TNGRAPHICS GDIPGETIMAGEGRAPHICSCONTEXT GDIPLUS DLLB  ��  �* |�� GdipDeleteGraphics� GDIPLUS.DLL�� B�C �  � �� U  TNIMAGE GDIPDELETEGRAPHICS GDIPLUS DLLR  ��  � �2 |�� GdipSetTextRenderingHint� GDIPLUS.DLL��� B�C �   � � �� U 
 TNGRAPHICS TNTEXTRENDERINGHINT GDIPSETTEXTRENDERINGHINT GDIPLUS DLL� ' ��  � � � � � � � � �< |�� GdipMeasureString� GDIPLUS.DLL����������. B�C �   �  �  �  �  � � � � �	 �� U 
 TNGRAPHICS	 PCUNICODE TNLENGTH TNFONT PCLAYOUTRECT TNSTRINGFORMAT	 PCRECTOUT TNCHARS TNLINES GDIPMEASURESTRING GDIPLUS DLL{  ��  � � � � � � �3 |�� GdipDrawString� GDIPLUS.DLL��������& B�C �   �  �  � �  �  � � �� U
 
 TNGRAPHICS
 TCWIDECHAR TNLENGTH TNFNT TCRECTF TNSTRINGFORMAT TNBRUSH GDIPDRAWSTRING GDIPLUS DLL� ; ��  � � � � � � � � �	 �
 � � � �G |�� GdipDrawImageRectRect� GDIPLUS.DLL���������������B B�C �   �  �  �  �  �  �  �  �  �	  �
  �  �  � � �� U 
 TNGRAPHICS TNIMAGE TNDSTX TNDSTY
 TNDSTWIDTH TNDSTHEIGHT TNSRCX TNSRCY
 TNSRCWIDTH TNSRCHEIGHT	 TNSRCUNIT TNIMAGEATTRIBUTES
 TNCALLBACK TNCALLBACKDATA GDIPDRAWIMAGERECTRECT GDIPLUS DLL[  ��  � � � �+ |�� GdipDrawImage� GDIPLUS.DLL����� B�C �   �  �  � � �� U 
 TNGRAPHICS TNIMAGE TNX TNY GDIPDRAWIMAGE GDIPLUS DLLs  ��  � � � � � �3 |�� GdipFillRectangle� GDIPLUS.DLL�������" B�C �   �  �  �  �  � � �� U	 
 TNGRAPHICS TNBRUSH TNX TNY TNWIDTH TNHEIGHT GDIPFILLRECTANGLE GDIPLUS DLLs  ��  � � � � � �3 |�� GdipDrawImageRect� GDIPLUS.DLL�������" B�C �   �  �  �  �  � � �� U	 
 TNGRAPHICS TNIMAGE TNX TNY
 TNIMGWIDTH TNIMGHEIGHT GDIPDRAWIMAGERECT GDIPLUS DLL|  ��  � � � � � �< |�� GdipCreateBitmapFromScan0� GDIPLUS.DLL�������" B�C �   �  �  �  � � � �� U	  TNWIDTH TNHEIGHT TNSTRIDE TNPIXELFORMAT TNSCAN0 TNIMAGE GDIPCREATEBITMAPFROMSCAN0 GDIPLUS DLLP  ��  � �0 |�� GdipLoadImageFromFile� GDIPLUS.DLL��� B�C �  � � �� U 
 PCFILENAME TNIMAGE GDIPLOADIMAGEFROMFILE GDIPLUS DLLa  ��  � � � �1 |�� GdipSaveImageToFile� GDIPLUS.DLL����� B�C �   �  �  � � �� U  TNIMAGE
 PCFILENAME PCCLSIDENCODER TNENCODERPARAMS GDIPSAVEIMAGETOFILE GDIPLUS DLL@  ��  �( |�� GdipDisposeImage� GDIPLUS.DLL�� B�C �  � �� U  TNIMAGE GDIPDISPOSEIMAGE GDIPLUS DLLa  ��  � � � �1 |�� GdipBitmapGetPixel� GDIPLUS.DLL����� B�C �   �  � � � �� U  TNBITMAP TNX TNY TNARGB GDIPBITMAPGETPIXEL GDIPLUS DLLL  ��  � �, |�� GdipGetImageWidth� GDIPLUS.DLL��� B�C �  � � �� U  TNIMAGE TNWIDTH GDIPGETIMAGEWIDTH GDIPLUS DLLM  ��  � �- |�� GdipGetImageHeight� GDIPLUS.DLL��� B�C �  � � �� U  TNIMAGE TNHEIGHT GDIPGETIMAGEHEIGHT GDIPLUS DLLJ  ��  �2 |�� GdipCreateImageAttributes� GDIPLUS.DLL�� B�C�  � �� U  TNIMAGEATTR GDIPCREATEIMAGEATTRIBUTES GDIPLUS DLLx  ��  � � � � �@ |��  GdipSetImageAttributesRemapTable� GDIPLUS.DLL������ B�C �   �  �  �  � � �� U  TNIMAGEATTR TNCOLORADJUSTTYPE TNENABLEFLAG	 TNMAPSIZE
 PCCOLORMAP  GDIPSETIMAGEATTRIBUTESREMAPTABLE GDIPLUS DLL�  ��  � � � � � �C |��! GdipSetImageAttributesColorMatrix� GDIPLUS.DLL�������" B�C �   �  �  �  �  � � �� U	  TNIMAGEATTR TNTYPE TNENABLEFLAG PCCOLORMATRIX TNGRAYMATRIX TNFLAGS! GDIPSETIMAGEATTRIBUTESCOLORMATRIX GDIPLUS DLLJ  ��  �2 |�� GdipDisposeImageAttributes� GDIPLUS.DLL�� B�C �  � �� U  TNIMAGEATTR GDIPDISPOSEIMAGEATTRIBUTES GDIPLUS DLL[  ��  � � �3 |�� GdipCreateStringFormat� GDIPLUS.DLL���� B�C �   � � � �� U  TNFORMATATTRIBUTES
 TNLANGUAGE TNFMT GDIPCREATESTRINGFORMAT GDIPLUS DLLF  ��  �. |�� GdipDeleteStringFormat� GDIPLUS.DLL�� B�C �  � �� U  TNSTRINGFORMAT GDIPDELETESTRINGFORMAT GDIPLUS DLLY  ��  � �9 |�� GdipSetStringFormatHotkeyPrefix� GDIPLUS.DLL��� B�C �   � � �� U 
 TNGRAPHICS TNHOTKEYPREFIX GDIPSETSTRINGFORMATHOTKEYPREFIX GDIPLUS DLLV  ��  �> |��% GdipStringFormatGetGenericTypographic� GDIPLUS.DLL�� B�C�  � �� U  TNHANDLE% GDIPSTRINGFORMATGETGENERICTYPOGRAPHIC GDIPLUS DLLg  ��  � � � � �/ |�� GdipCreateFont� GDIPLUS.DLL������ B�C �   �  �  � � � �� U  TNFONTFAMILY TNEMSIZE TNFONTSTYLE TNUNIT TNFONT GDIPCREATEFONT GDIPLUS DLLa  ��  � � �9 |�� GdipCreateFontFamilyFromName� GDIPLUS.DLL���� B�C �   � � � �� U  PCFAMILYNAME TNFONTCOLLECTION TNFONTFAMILY GDIPCREATEFONTFAMILYFROMNAME GDIPLUS DLL>  ��  �& |�� GdipDeleteFont� GDIPLUS.DLL�� B�C �  � �� U  TNFONT GDIPDELETEFONT GDIPLUS DLLD  ��  �, |�� GdipDeleteFontFamily� GDIPLUS.DLL�� B�C �  � �� U  TNFONTFAMILY GDIPDELETEFONTFAMILY GDIPLUS DLLN  ��  � �. |�� GdipCreateSolidFill� GDIPLUS.DLL��� B�C �  � � �� U  TNCOLOR TNBRUSH GDIPCREATESOLIDFILL GDIPLUS DLL�  ��  � � � � � � �9 |�� GdipCreateLineBrushI� GDIPLUS.DLL��������& B�C �   �  �  �  �  � � � �� U
  PCPOINT1 PCPOINT2 TNCOLOR1 TNCOLOR2 TNMODE
 TNWRAPMODE TNLINEGRADIENT GDIPCREATELINEBRUSHI GDIPLUS DLL  ��  � � � � � �? |�� GdipCreateLineBrushFromRect� GDIPLUS.DLL�������" B�C�   �  �  �  � � � �� U	  TNRECT TNCOLOR1 TNCOLOR2 TNMODE TNWRAPMD TNLINEGRADIENT GDIPCREATELINEBRUSHFROMRECT GDIPLUS DLL�  ��  � � � � � �@ |�� GdipCreateLineBrushFromRectI� GDIPLUS.DLL�������" B�C�   �  �  �  � � � �� U	  TNRECT TNCOLOR1 TNCOLOR2 TNMODE
 TNWRAPMODE TNLINEGRADIENT GDIPCREATELINEBRUSHFROMRECTI GDIPLUS DLLd  ��  � � � �4 |�� GdipSetLinePresetBlend� GDIPLUS.DLL����� B�C �   �  �  � � �� U  TNBRUSH TNBLEND PCPOSITIONS TNCOUNT GDIPSETLINEPRESETBLEND GDIPLUS DLL?  ��  �' |�� GdipDeleteBrush� GDIPLUS.DLL�� B�C �  � �� U  TNBRUSH GDIPDELETEBRUSH GDIPLUS DLLI  ��  � �) |�� GdipCreatePath� GDIPLUS.DLL��� B�C �  � � �� U  TNBRUSHMODE TNPATH GDIPCREATEPATH GDIPLUS DLLl  ��  � � � � �4 |�� GdipAddPathRectangle� GDIPLUS.DLL������ B�C �   �  �  �  � � �� U  TNPATH TNX TNY TNWIDTH TNHEIGHT GDIPADDPATHRECTANGLE GDIPLUS DLLY  ��  � �9 |�� GdipCreatePathGradientFromPath� GDIPLUS.DLL��� B�C �  � � �� U  TNPATH TNPOLYGRADIENT GDIPCREATEPATHGRADIENTFROMPATH GDIPLUS DLLX  ��  � �8 |�� GdipSetPathGradientCenterColor� GDIPLUS.DLL��� B�C �   � � �� U  TNBRUSH TNCOLORS GDIPSETPATHGRADIENTCENTERCOLOR GDIPLUS DLLp  ��  � � �H |��* GdipSetPathGradientSurroundColorsWithCount� GDIPLUS.DLL���� B�C �  � � � �� U  TNBRUSH TNARGB TNCOUNT* GDIPSETPATHGRADIENTSURROUNDCOLORSWITHCOUNT GDIPLUS DLL>  ��  �& |�� GdipDeletePath� GDIPLUS.DLL�� B�C �  � �� U  TNPATH GDIPDELETEPATH GDIPLUS DLL)  |��
 CreateMenu� User32�
 B�C�  �� U 
 CREATEMENU USER326  ��  � |�� DrawMenuBar� User32�� B�C �  � �� U 	 THWNDMENU DRAWMENUBAR USER322  ��  � |�� GetMenu� User32�� B�C �  � �� U 	 THWNDMENU GETMENU USER32B  ��  � �" |�� GetSystemMenu� User32��� B�C �   � � �� U 	 THWNDMAIN TBREVERT GETSYSTEMMENU USER32<  ��  � � |�� SetMenu� User32��� B�C �   � � �� U 	 THWNDMENU THMENU SETMENU USER32. ! |�� CreatePopupMenu� User32�
 B�C�  �� U  CREATEPOPUPMENU USER321  ��  � |�� IsMenu� User32�� B�C �  � �� U  THMENU ISMENU USER326  ��  � |�� DestroyMenu� User32�� B�C �  � �� U  THMENU DESTROYMENU USER32S  ��  � � � �# |��
 AppendMenu� User32����� B�C �   �  �  � � �� U  THMENU TUFLAGS TUIDNEWITEM
 TLPNEWITEM
 APPENDMENU USER32]  ��  � � � � �% |W�
 ModifyMenu� User32������ B�C �   �  �  �  � � �� U  THMENU TNPOSID TNFLAGS TNNEWID TLPNEWID
 MODIFYMENU USER32M  ��  � � �% |�� EnableMenuItem� User32���� B�C �   �  � � �� U  THMENU TNITEMID TNFLAGS ENABLEMENUITEM USER32A  ��  � �! |�� GetMenuInfo� User32��� B�C �  � � �� U  THMENU TLPCMI GETMENUINFO USER32A  ��  � �! |�� SetMenuInfo� User32��� B�C �  � � �� U  THMENU TLPCMI SETMENUINFO USER32X  ��  � � � �( |�� GetMenuBarInfo� User32����� B�C �   �  � � � �� U  TNHWND	 TIDOBJECT TIDITEM TLPMBI GETMENUBARINFO USER32a  ��  � � � � �) |�� GetMenuString� User32������ B�C �   � �  �  � � �� U  THMENU TUIDITEM	 TLPSTRING
 TNMAXCOUNT TUFLAG GETMENUSTRING USER32Y  ��  � � � �) |W� GetMenuItemRect� User32����� B�C �   �  � � � �� U 	 THWNDMENU THMENU TNITEM TLPITEMRECT GETMENUITEMRECT USER32;  ��  �# |�� GetMenuItemCount� User32�� B�C �  � �� U  THMENU GETMENUITEMCOUNT USER32B  ��  � �" |�� GetMenuItemID� User32��� B�C �   � � �� U  THMENU TNPOSID GETMENUITEMID USER32Y  ��  � � � �) |�� GetMenuItemInfo� User32����� B�C �   �  � � � �� U  THMENU TUITEM TFBYPOSITION TLPMII GETMENUITEMINFO USER32X  ��  � � � �( |W� SetMenuItemInfo� User32����� B�C �   �  �  � � �� U  THMENU TUITEM TFBYPOSITION TLPMII SETMENUITEMINFO USER32Z  ��  � � � �* |�� MenuItemFromPoint� User32����� B�C �   �  �  � � �� U  TNHWND THMENU TNX TNY MENUITEMFROMPOINT USER32F  ��  � �& |�� GetMenuPosFromID� ShlwApi��� B�C �   � � �� U  THMENU TNID GETMENUPOSFROMID SHLWAPIu  ��  � � � � � � �- |�� TrackPopupMenu� User32��������& B�C �   �  �  �  �  �  � � �� U	  THMENU TUFLAGS TNX TNY
 TNRESERVED TNHWND TPRCRECT TRACKPOPUPMENU USER32f  ��  � � � � � �& |��	 LoadImage� User32�������" B�C �   �  �  �  �  � � �� U  THINST	 TLPSZNAME TUTYPE
 TCXDESIRED
 TCYDESIRED TFULOAD	 LOADIMAGE USER328  ��  �  |�� GetCursorPos� User32�� B�C �  � �� U  TLPPOINT GETCURSORPOS USER32C  ��  � �# |�� GetClientRect� User32��� B�C �  � � �� U  TNHWND TLPRECT GETCLIENTRECT USER320  ��  � |�� GetDC� User32�� B�C �  � �� U  TNHWND GETDC USER32<  ��  �$ |�� CreateCompatibleDC� GDI32�� B�C �  � �� U  THDC CREATECOMPATIBLEDC GDI32T  ��  � � �, |�� CreateCompatibleBitmap� GDI32���� B�C �   �  � � �� U  THDC TNWIDTH TNHEIGHT CREATECOMPATIBLEBITMAP GDI32@  ��  � �  |�� SelectObject� GDI32��� B�C �   � � �� U  THDC THOBJECT SELECTOBJECT GDI32>  ��  � � |��	 ReleaseDC� User32��� B�C �   � � �� U  TNHWND THDC	 RELEASEDC USER32S  ��  � � � �# |�� CreateDC� Win32API����� B�C �   �  �  � � �� U  TPDRIVERNAME TPDEVICENAME TPOUTPUT	 TCDEVMODE CREATEDC WIN32API2  ��  � |�� DeleteDC� GDI32�� B�C �  � �� U  THDC DELETEDC GDI326  ��  � |�� DeleteObject� GDI32�� B�C �  � �� U  THDC DELETEOBJECT GDI32A  ��  � �! |�� GetDeviceCaps� GDI32��� B�C �   � � �� U  THDC TNINDEX GETDEVICECAPS GDI32;  ��  �# |�� GetSysColorBrush� User32�� B�C �  � �� U  TNINDEX GETSYSCOLORBRUSH USER32>  ��  � � |��
 SetBkColor� GDI32��� B�C �   � � �� U  THDC TCRCOLOR
 SETBKCOLOR GDI32:  ��  �" |�� CreateSolidBrush� GDI32�� B�C �  � �� U  TCRCOLOR CREATESOLIDBRUSH GDI32=  ��  � � |��	 SetBkMode� GDI32��� B�C �   � � �� U  THDC TIBKMODE	 SETBKMODE GDI328  ��  �  |�� GetStockObject� GDI32�� B�C �  � �� U 	 TFNOBJECT GETSTOCKOBJECT GDI32<  ��  �$ |�� CreatePatternBrush� GDI32�� B�C �  � �� U  THBMP CREATEPATTERNBRUSH GDI32:  ��  �" |�� GdiSetBatchLimit� GDI32�� B�C �  � �� U  TDWLIMIT GDISETBATCHLIMIT GDI32]  ��  � � � �- |�� GetTextExtentPoint32� GDI32����� B�C �   �  � � � �� U  THDC TCSTRING TNSTRLEN TPSIZE GETTEXTEXTENTPOINT32 GDI32H  ��  � � �  |�� FillRect� User32���� B�C �  �  � � �� U  THDC TLPRECT THBRUSH FILLRECT USER32\  ��  � � � � �$ |�� DrawText� User32������ B�C �   �  � �  � � �� U  THDC	 TLPSTRING TNCOUNT TLPRECT TUFORMAT DRAWTEXT USER32| # ��  � � � � � � � �, |��
 ExtTextOut� GDI32���������* B�C �   �  �  � �  �  � � � �� U
  THDC TNX TNY
 TFUOPTIONS TLSRECT TCTEXT	 TNTEXTLEN TLPADX
 EXTTEXTOUT GDI32R  ��  � � � �" |�� DrawEdge� User32����� B�C �  �  �  � � �� U  THDC TLPRECT
 TNEDGETYPE TNBORDERTYPE DRAWEDGE USER32G  ��  � � � |��	 CreatePen� GDI32���� B�C �   �  � � �� U  TFNPENSTYLE TNWIDTH TCRCOLOR	 CREATEPEN GDI32Q  ��  � � � �! |�� MoveToEx� GDI32����� B�C �   �  � � � �� U  THDC TNX TNY TLPPOINT MOVETOEX GDI32D  ��  � � � |�� LineTo� GDI32���� B�C �   �  � � �� U  THDC TNENDX TNENDY LINETO GDI32[  ��  � � � � �# |��	 Rectangle� GDI32������ B�C �   �  �  �  � � �� U  THDC
 TNLEFTRECT	 TNTOPRECT TNRIGHTRECT TNBOTTOMRECT	 RECTANGLE GDI32o  ��  � � � � � � �' |��	 RoundRect� GDI32��������& B�C �   �  �  �  �  �  � � �� U	  THDC
 TNLEFTRECT	 TNTOPRECT TNRIGHTRECT TNBOTTOMRECT TNWIDTHCURVE TNHEIGHTCURVE	 ROUNDRECT GDI32[  ��  � � � � �# |�� SetRect� User32������ B�C �   �  �  �  � � �� U  TLPRECT TNLEFT TNTOP TNRIGHT TNBOTTOM SETRECT USER32j  ��  � � � � � �* |�� GradientFill� MsImg32�������" B�C �   �  �  �  �  � � �� U  THDC TPVERTEX TDWNUMVERTEX TPMESH
 TDWNUMMESH TDWMODE GRADIENTFILL MSIMG32F  ��  � � � |�� GetPixel� GDI32���� B�C �   �  � � �� U  THDC TNXPOS TNYPOS GETPIXEL GDI32Q  ��  � � � �! |��	 SetPixelV� GDI32����� B�C �   �  �  � � �� U  THDC TNXPOS TNYPOS TNCOLOR	 SETPIXELV GDI32� / ��  � � � � � � � � �	 �
 �6 |�� TransparentBlt� MsImg32������������6 B�C �   �  �  �  �  �  �  �  �  �	  �
 � �� U  THDCDEST TNXDEST TNYDEST TNWIDTHDEST THHEIGHTDEST THDCSRC TNXSRC TNYSRC
 TNWIDTHSRC TNHEIGHTSRC TCRTRANSPARENT TRANSPARENTBLT MSIMG32� ' ��  � � � � � � � � �( |�� BitBlt� GDI32����������. B�C �   �  �  �  �  �  �  �  � �	 �� U  THDCDEST TNXDEST TNYDEST TNWIDTHDEST THHEIGHTDEST THDCSRC TNXSRC TNYSRC TDWROP BITBLT GDI32� / ��  � � � � � � � � �	 �
 �2 |��
 AlphaBlend� MsImg32������������6 B�C �   �  �  �  �  �  �  �  �  �	  �
 � �� U  THDCDEST TNXDEST TNYDEST TNWIDTHDEST TNHEIGHTDEST THDCSRC TNXSRC TNYSRC
 TNWIDTHSRC TNHEIGHTSRC TBLENDFUNCTION
 ALPHABLEND MSIMG32<  ��  �$ |�� CreateFontIndirect� GDI32�� B�C �  � �� U 
 TLPLOGFONT CREATEFONTINDIRECT GDI32D  ��  � �$ |�� ClientToScreen� User32��� B�C �  � � �� U  TNHWND TLPPOINT CLIENTTOSCREEN USER32D  ��  � �$ |�� ScreenToClient� User32��� B�C �  � � �� U  TNHWND TLPPOINT SCREENTOCLIENT USER32Y  ��  � � � �) |�� MapWindowPoints� User32����� B�C �   � �  � � �� U 	 THWNDFROM THWNDTO TCPOINTS TNPOINTCOUNTS MAPWINDOWPOINTS USER32H  ��  � � �  |�� PtInRect� User32���� B�C�   �  � � �� U  TLPRECT TNX TNY PTINRECT USER324  ��  � |��	 SetCursor� User32�� B�C �  � �� U  THCURSOR	 SETCURSOR USER32?  ��  � � |��
 LoadCursor� User32��� B�C �   � � �� U 
 THINSTANCE
 TNCURSORID
 LOADCURSOR USER32G  ��  � � � |�� MulDiv� Kernel32���� B�C �   �  � � �� U  TNNUMBER TNNUMERATOR TNDENOMINATOR MULDIV KERNEL32n  ��  � � � � � �. |�� CreateRoundRectRgn� GDI32�������" B�C �   �  �  �  �  � � �� U 
 TNLEFTRECT	 TNTOPRECT TNRIGHTRECT TNBOTTOMRECT TNWIDTHELLIPSE TNHEIGHTELLIPSE CREATEROUNDRECTRGN GDI32A  ��  � �! |�� SelectClipRgn� GDI32��� B�C �   � � �� U  THDC THREGION SELECTCLIPRGN GDI32-   |�� IsThemeActive� uxTheme�
 B�C�  �� U  ISTHEMEACTIVE UXTHEMEL  ��  � � �$ |��
 RegOpenKey� Win32API���� B�C �   � � � �� U  TNHKEY TCSUBKEY TNHANDLE
 REGOPENKEY WIN32API� # ��  � � � � � � � �4 |�� RegEnumValue� Win32API���������* B�C �   � � �  � � � � � �� U
  TNHKEY TNINDEX TPSZVALUENAME TPDWSIZE
 TWRESERVED TPDWTYPE TPBDATA TPCBDATA REGENUMVALUE WIN32API8  ��  �  |�� RegCloseKey� Win32API�� B�C �  � �� U  TNHKEY REGCLOSEKEY WIN32APIq  ��  � � � � � �1 |�� RegQueryValueEx� Win32API�������" B�C �   �  � � � � � �� U  TNHKEY TPSZVALUENAME
 TWRESERVED TPDWTYPE TPBDATA TPCBDATA REGQUERYVALUEEX WIN32APIN  ��  � � �& |�� RegCreateKey� Win32API���� B�C �   � � � �� U  TNHKEY TCSUBKEY TNHANDLE REGCREATEKEY WIN32APIE  ��  � �% |�� RegDeleteValue� Win32API��� B�C �   � � �� U  TNHKEY TCENTRY REGDELETEVALUE WIN32APIl  ��  � � � � � �, |�� RegSetValueEx� Win32API�������" B�C �   �  �  �  �  � � �� U  TNHKEY	 TPSZENTRY
 TWRESERVED TDWTYPE TPBDATA TCBDATA REGSETVALUEEX WIN32APId  ��  � � � � �, |�� ExtractIconEx� shell32������ B�C�   � � �  � � �� U  TFILE	 ICONINDEX
 TICONLARGE
 TICONSMALL TNICONS EXTRACTICONEX SHELL326  ��  � |W� DestroyIcon� user32�� B�C �  � �� U  HICON DESTROYICON USER32W  ��  � � �/ |�� ExtractAssociatedIcon� shell32���� B�C �  � � � �� U  THINST
 TPICONPATH TPIICON EXTRACTASSOCIATEDICON SHELL32f  ��  � � � �6 |�� OleCreatePictureIndirect� oleaut32���.� B�C �  �  � � � �� U  TPICDESC TREFIID TFPICTUREOWNSHANDLE TIPIC OLECREATEPICTUREINDIRECT OLEAUT32-   |�� GetLastError� kernel32�
 B�C�  �� U  GETLASTERROR KERNEL32=  ��  �% |�� LockWindowUpdate� Win32API�� B�C �  � �� U  TNHANDLE LOCKWINDOWUPDATE WIN32APIQ  ��  � � �) |�� FindExecutable� Shell32���� B�C�  � � � �� U  LPFILE LPDIRECTORY LPRESULT FINDEXECUTABLE SHELL32b  ��  � � � � �* |�� SHGetFileInfo� shell32������ B�C �   � �  �  � � �� U  TPSZPATH TDWFILEATTRIBUTES TSHFILEINFO TCBFILEINFO TUFLAGS SHGETFILEINFO SHELL32}  ��  � � � � %�C�� ��� C��L �" B�C ��   ��  �� �� � �� �v �" B�C ��   ��  ��  �� � �� � U  NHWND MSG WPARAM LPARAM APISENDMESSAGESTRING APISENDMESSAGEINTEGERw  ��  � � � �? |�� SendMessage� win32apiQ� apiSendMessageInteger�����" B�C ��   ��  ��  �� � �� U  NHWND MSG WPARAM LPARAM SENDMESSAGE WIN32API APISENDMESSAGEINTEGERw  ��  � � � �? |�� SendMessage� win32apiQ� apiSendMessageString�����" B�C ��   ��  �� �� � �� U  NHWND MSG WPARAM LPARAM SENDMESSAGE WIN32API APISENDMESSAGESTRINGH  ��  � �( |�� GetComputerName� kernel32��� B�C�  � � �� U  TCBUFFER TNSIZE GETCOMPUTERNAME KERNEL32� # ��  � � � � � � � �= |�� GetVolumeInformation� WIN32API���������* B�C�  �  � � � � �  � � �� U
  TPROOTPATHNAME TPVOLNAMEBUF TNVOLNAMESZ TPVOLSERIALNUM TPMAXCOMPLEN TPFILESYSFLAGS TPFILESYSNAMEBUF TNFILESYSNAMESZ GETVOLUMEINFORMATION WIN32APIR  ��  � � �* |�� GetShortPathName� Win32API���� B�C �  �  � � �� U 
 TCLONGNAME TCSHORTNAME TNSIZEOF GETSHORTPATHNAME WIN32API=  ��  �% |�� BringWindowToTop� Win32API�� B�C �  � �� U  THWND BRINGWINDOWTOTOP WIN32APIj  ��  � � � � � �* |�� ShellExecute� Shell32�������" B�C �   �  �  �  �  � � �� U  TNHWND	 TLPACTION TLPFILE	 TLPPARAMS TLPDIRECTORY	 TNSHOWCMD SHELLEXECUTE SHELL326  ��  � |W� GetKeyState� User32�� B�C �  � �� U  TKEYCODE GETKEYSTATE USER32;  ��  �# |W� GetAsyncKeyState� User32�� B�C �  � �� U  TKEYCODE GETASYNCKEYSTATE USER32<  ��  �$ |�� GetKeyboardState� user32�� B�C�  � �� U 
 TCKEYCODES GETKEYBOARDSTATE USER32 GETASYNCKEYSTATE>  ��  � � |��	 KillTimer� User32��� B�C �   � � �� U  TNHWND	 TNIDEVENT	 KILLTIMER USER32Q  ��  � � � �! |�� SetTimer� User32����� B�C �   �  �  � � �� U  TNHWND	 TNIDEVENT TUELAPSE TLPTIMERFUNC SETTIMER USER32J  ��  � �* |�� GetSystemDirectory� kernel32��� B�C�   � � �� U  TPBUFFER TNSIZE GETSYSTEMDIRECTORY KERNEL32;  ��  �# |�� GetSystemMetrics� User32�� B�C �  � �� U  TNINDEX GETSYSTEMMETRICS USER326  ��  � |�� GetSysColor� User32�� B�C �  � �� U  TNINDEX GETSYSCOLOR USER32@  ��  � �  |�� SetTextColor� GDI32��� B�C �   � � �� U  THDC TCRCOLOR SETTEXTCOLOR GDI32g  ��  � � � � � �' |��
 MoveWindow� User32�������" B�C �   �  �  �  �  � � �� U  THWND TNX TNY TNWIDTH TNHEIGHT	 TBREPAINT
 MOVEWINDOW USER32s  ��  � � � � � � �+ |�� SetWindowPos� User32��������& B�C �   �  �  �  �  �  � � �� U	  TNHWND THWNDINSERTAFTER TNX TNY TNWIDTH TNHEIGHT TUFLAGS SETWINDOWPOS USER32D  ��  � �$ |�� WindowFromPoint� User32��� B�C �   � � �� U  TNX TNY WINDOWFROMPOINT USER32/ " |�� GetDesktopWindow� user32�
 B�C�  �� U  GETDESKTOPWINDOW USER326  ��  � |�� GetWindowDC� User32�� B�C �  � �� U  TNHWND GETWINDOWDC USER32L  ��  � � �$ |�� SetWindowLong� user32���� B�C �   �  � � �� U  TNHWND TNINDEX
 TDWNEWLONG SETWINDOWLONG USER32a  ��  � � � � �) |�� CallWindowProc� User32������ B�C �   �  �  �  � � �� U  TLPPREVWNDFUNC TNHWND TUMSG TWPARAM TLPARAM CALLWINDOWPROC USER32B  ��  � �" |�� GetWindowLong� User32��� B�C �   � � �� U  TNHWND TNINDEX GETWINDOWLONG USER32>  ��  � � |��	 GetWindow� user32��� B�C �   � � �� U  TNHWND TWFLAG	 GETWINDOW USER32M  ��  � � �% |�� GetWindowText� user32���� B�C �  �  � � �� U  THWND TPSTRING TCCH GETWINDOWTEXT USER32A  ��  � �! |��
 ShowWindow� win32api��� B�C �   � � �� U  TNHWND	 TNCMDSHOW
 SHOWWINDOW WIN32API3  ��  � |�� IsIconic� user32�� B�C �  � �� U  THWND ISICONIC USER32;  ��  �# |W� BringWindowToTop� user32�� B�C �  � �� U  THWND BRINGWINDOWTOTOP USER32C  ��  � �# |�� GetWindowRect� User32��� B�C �  � � �� U  TNHWND TLPRECT GETWINDOWRECT USER32I  ��  � � �! |�� HeapFree� Kernel32���� B�C �   �  � � �� U  THHEAP TDWFLAGS TLPHEAP HEAPFREE KERNEL32J  ��  � � �" |��	 HeapAlloc� Kernel32���� B�C �   �  � � �� U  THHEAP TDWFLAGS TDWBYTES	 HEAPALLOC KERNEL328  ��  �  |�� HeapDestroy� Kernel32�� B�C �  � �� U  THHEAP HEAPDESTROY KERNEL32K  ��  � � �# |��
 HeapCreate� Kernel32���� B�C �   �  � � �� U 
 TFLOPTIONS TDWINITIALSIZE TDWMAXIMUMSIZE
 HEAPCREATE KERNEL324  ��  � |�� lstrlen� Kernel32�� B�C �  � �� U 	 TLPSTRING LSTRLEN KERNEL325  ��  � |�� lstrlenW� Kernel32�� B�C �  � �� U 	 TLPSTRING LSTRLENW KERNEL32I  ��  � � �! |�� HeapSize� Win32Api���� B�C �   �  � � �� U  THHEAP TNALLOC TNADDR HEAPSIZE WIN32APIH  ��  � �( |�� GetUserName� advapi32.dll��� B�C�  � � �� U  TPBUFFER TNSIZE GETUSERNAME ADVAPI32 DLL SHGetSpecialFolderPath,     �� RtlS2PL�     �� SetFileAttributes�    �� GetFileAttributes    �� CopyFiler    �� MoveFile    �� DocumentProperties~    �� ClosePrinterf    �� OpenPrinter�    �� StartDoce    �� EndDoc�    �� EndPage    ��	 StartPagee    �� AbortDoc�    �� CoCreateGuid    �� StringFromGUID2b    �� UuidCreateSequential�    �� UuidFromStringH    �� GdiplusStartup�    �� GdiplusShutdownZ	    �� GdipGetImageGraphicsContext�	    �� GdipDeleteGraphics_
    �� GdipSetTextRenderingHint�
    �� GdipMeasureStringo    �� GdipDrawString�    �� GdipDrawImageRectRectt    �� GdipDrawImage    �� GdipFillRectangle�    �� GdipDrawImageRectj    �� GdipCreateBitmapFromScan0:    �� GdipLoadImageFromFile!    �� GdipSaveImageToFile�    �� GdipDisposeImagem    �� GdipBitmapGetPixel�    �� GdipGetImageWidth}    �� GdipGetImageHeight     �� GdipCreateImageAttributes�    ��  GdipSetImageAttributesRemapTable
    ��! GdipSetImageAttributesColorMatrix�    �� GdipDisposeImageAttributes�    �� GdipCreateStringFormat�    �� GdipDeleteStringFormat-    �� GdipSetStringFormatHotkeyPrefix�    ��% GdipStringFormatGetGenericTypographicU    �� GdipCreateFont�    �� GdipCreateFontFamilyFromName�    �� GdipDeleteFontk    �� GdipDeleteFontFamily�    �� GdipCreateSolidFillM    �� GdipCreateLineBrushI�    �� GdipCreateLineBrushFromRect�    �� GdipCreateLineBrushFromRectI�    �� GdipSetLinePresetBlend�     �� GdipDeleteBrush[!    �� GdipCreatePath�!    �� GdipAddPathRectangleF"    �� GdipCreatePathGradientFromPath�"    �� GdipSetPathGradientCenterColor�#    ��* GdipSetPathGradientSurroundColorsWithCount?$    �� GdipDeletePath%    ��
 CreateMenuo%    �� DrawMenuBar�%    �� GetMenu
&    �� GetSystemMenu\&    �� SetMenu�&    �� CreatePopupMenu2'    �� IsMenu}'    �� DestroyMenu�'    ��
 AppendMenu!(    ��
 ModifyMenu�(    �� EnableMenuItemX)    �� GetMenuInfo�)    �� SetMenuInfoF*    �� GetMenuBarInfo�*    �� GetMenuStringH+    �� GetMenuItemRect�+    �� GetMenuItemCount�,    �� GetMenuItemID�,    �� GetMenuItemInfob-    �� SetMenuItemInfo�-    �� MenuItemFromPoint�.    �� GetMenuPosFromID,/    �� TrackPopupMenu�/    ��	 LoadImagei0    �� GetCursorPos"1    �� GetClientRect~1    �� GetDC�1    �� CreateCompatibleDC82    �� CreateCompatibleBitmap�2    �� SelectObject)3    ��	 ReleaseDC�3    �� CreateDC�3    �� DeleteDC�4    �� DeleteObject�4    �� GetDeviceCaps35    �� GetSysColorBrush�5    ��
 SetBkColor�5    �� CreateSolidBrushd6    ��	 SetBkMode�6    �� GetStockObject(7    �� CreatePatternBrush�7    �� GdiSetBatchLimit�7    �� GetTextExtentPoint32I8    �� FillRect�8    �� DrawText_9    ��
 ExtTextOut�9    �� DrawEdge�:    ��	 CreatePenb;    �� MoveToEx�;    �� LineTo_<    ��	 Rectangle�<    ��	 RoundRectu=    �� SetRectO>    �� GradientFill�>    �� GetPixel�?    ��	 SetPixelV@    �� TransparentBlt�@    �� BitBlt�A    ��
 AlphaBlend�B    �� CreateFontIndirect�C    �� ClientToScreenSD    �� ScreenToClient�D    �� MapWindowPoints7E    �� PtInRect�E    ��	 SetCursorKF    ��
 LoadCursor�F    �� MulDivG    �� CreateRoundRectRgn�G    �� SelectClipRgnrH    �� IsThemeActive�H    ��
 RegOpenKey&I    �� RegEnumValue�I    �� RegCloseKey�J    �� RegQueryValueEx�J    �� RegCreateKey�K    �� RegDeleteValueLL    �� RegSetValueEx�L    �� ExtractIconEx�M    �� DestroyIcon6N    �� ExtractAssociatedIcon�N    �� OleCreatePictureIndirect$O    �� GetLastError�O    �� LockWindowUpdate*P    �� FindExecutable�P    �� SHGetFileInfoQ    �� SendMessage�Q    �� apiSendMessageInteger�R    �� apiSendMessageStringkS    �� GetComputerName/T    �� GetVolumeInformation�T    �� GetShortPathName�U    �� BringWindowToTopjV    �� ShellExecute�V    �� GetKeyState�W    �� GetAsyncKeyState�W    �� GetKeyboardStateOX    ��	 KillTimer�X    �� SetTimer/Y    �� GetSystemDirectory�Y    �� GetSystemMetrics?Z    �� GetSysColor�Z    �� SetTextColor�Z    ��
 MoveWindowb[    �� SetWindowPos\    �� WindowFromPoint�\    �� GetDesktopWindowH]    �� GetWindowDC�]    �� SetWindowLong�]    �� CallWindowProcp^    �� GetWindowLong_    ��	 GetWindow�_    �� GetWindowText�_    ��
 ShowWindowp`    �� IsIconic�`    �� BringWindowToTop.a    �� GetWindowRect�a    �� HeapFree�a    ��	 HeapAllocyb    �� HeapDestroy�b    ��
 HeapCreateSc    �� lstrlen�c    �� lstrlenW:d    �� HeapSize�d    �� GetUserNamee    ��1 1Q!5 � a5 � �!5 q a� 4 � a3 � �!3 �q!3 q Q� 3 � �a3 � �!3 q �� 3 q �� 3 q �� 3 q �� 3 q Q� 3 � �a3 q �� 3 � �!3 � �a3 q q� 3 � a!3 q �� 3 � !!3 q��3 �1a3 �q!3 1��3 �1!3 �1!3 ��!3 � !3 1�3 q �� 3 1�3 � �!3 � �!3 q !� 3 q�3 �1!3 q !� 3 � 1a3 q �� 3 � �!3 q �� 3 q��3 � �a3 q a� 3 q �� 3 � �!3 ��a3 ��!3 �!3 1A�3 q q� 3 � �!3 qA�3 � �!3 � �!3 � �a3 q a� 3 �� 3 q �� 3 q �� 3 � !!3 � �!3 � 3 q �� 3 q �� 3 11�3 qQ�3 � Qa3 � !3 � !3 1��3 q��3 1��3 q 1� 3 � !!3 1��3 1��3 1��3 � a!3 ��a3 �a!3 q � 3 � 1!3 q �� 3 q A� 3 � �a3 � !3 � �!3 11�3 q �� 3 q �� 3 � !3 q 1� 3 � �!3 q !� 3 � �!3 q � 3 q A� 3 q !� 3 1��3 � a3 qA�3 1��3 1!�3 � �a3 1�3 � �a3 q1�3 �qa3 q1�3 ��!3 � �a3 1�3 �aa3 q��3 �!a3 q A� 3 � A!3 � A!3 1��3 � a3 q �� 3 � �!3 � �a3 ��!3 � !3 � 3 � Aa3 1A�3 q � 3 �!3 � aa3 � Q!3 ��!3 q��3 q �� 3 � �a3 1a�3 � 3 q Q� 3 � �a3 q��9 1s!� !A 3 1�!3 1�!3 � �!3 1��3 � �a3 q Q� 3 ��!3 q �� 3 q 1� 3 q A� 3 � �!3 1�3 � �!3 q 1� 3 q �� 3 � !3 �q!3 ��a3 � A!3 !� 3 q �� 3 � Aa3 q��3 � !!3 � �!3 � Qa3 � !3 q �� 3 q 1� 3 � 1!3 � a3 � !a3 q � 3 � 1a3 q �� 3 q �� 3 � a3 � �!2                    !   $        I  �  	   	     �        �  t        �  O         q    &      .  S  ,      y  �  2   !   	  �  8   %   �  C  >   )   c  �  D   -   �  $	  J   1   G	  �	  P   5   �	  
  V   9   7
  �
  \   =   �
  _  b   A   �    h   E   *  �  n   I   �  }  t   M   �    z   Q   A  �  �   U     �  �   Y   �  p  �   ]   �    �   a   7  \  �   e   �  �  �   i   �  t  �   m   �  �  �   q   �  �  �   u   �  �  �   y   (  �  �   }   �  �  �   �   �  f  �   �   �  H  �   �   s    �   �   -  �  �   �   �  }  �   �   �  �   �   �   !  E"  �   �   y"  #  �   �   3#  �#  �   �   .$  �$  �   �   �$  �%    �   �%  �&  
  �   �&  �'    �   �'  �(    �   �(  @)    �   n)  �)  "  �   *  �*  (  �   �*  �+  .  �   1,  ?-  4  �   u-  �.  :  �   �.  �/  @  �   �/  0  F  �   >0  �0  L  �   �0  �1  R  �   �1  �2  X  �   �2  r3  ^  �   �3  �4  d  �   �4  5  j  �   45  j5  p  �   �5  �5  u  �   6  b6  {  �   �6  7  �     %7  �7  �    �7  �7  �    8  f8  �    �8  �8  �    9  �9  �    �9  �:  �    �:  F;  �    k;  �;  �    <  t<  �  #  �<  H=  �  '  o=  ?>  �  +  h>  ?  �  /  I?  �?  �  3  �?  G@  �  7  p@  "A  �  ;  KA  �A  �  ?  &B  �B  �  C  �B  `C  �  G  �C  tD  �  K  �D  xE  �  O  �E  �E  �  S  &F  �F    W  �F  G  
  [  4G  �G    _  �G  ^H    c  �H  �H    g  I  }I  "  k  �I  aJ  (  o  �J  �J  .  s  �J  IK  4  w  pK  �K  :  {  L  tL  @    �L  M  F  �  ,M  �M  L  �  �M  !N  R  �  IN  �N  X  �  �N  <O  ^  �  fO  �O  d  �  �O  �P  j  �  �P  WQ  p  �  yQ  9R  v  �  ]R  ]S  |  �  S  )T  �  �  LT  �T  �  �  U  �U  �  �  �U  -V  �  �  PV  &W  �  �  IW  kX  �  �  �X  IY  �  �  oY  QZ  �  �  sZ  �Z  �  �  [  �[  �  �  �[  h]  �  �  �]  �^  �  �  �^  l`  �  �  �`  a  �  �  .a  �a  �  �  �a  Nb  �  �  wb  :c  �  �  \c  �c  �  �  �c  Nd  �  �  rd  �d  �  �  e  �e  �  �  �e  g     �  -g  �g      �g  h      (h  �h    
  �h  *j      Oj  �j      �j  �k  #    l  �l  )    �l  Lm  /    sm  en  5  "  �n  ao  ;  &  �o  �o  A  *  p  �p  G  .  �p  �q  M  2  �q  9r  S  5  cr  �r  X  9  �r  �s  ^  =  �s  �t  d  A  �u  w  p  H  :w  "x  {  L  Px  8y  �  P  ay  �y  �  T  z  �{  �  X  �{  �|  �  \  �|  &}  �  `  L}  B~  �  d  g~  �~  �  h  �~  Y  �  l  �  �  �  p  �  ��  �  t  ��  Q�  �  x  }�  	�  �  |  3�  ��  �  �  ��  �  �  �  C�  ��  �  �  Ճ  ��  �  �  Ȅ  ��  �  �  �  S�  �  �  }�    �  �  �  >�  �  �  e�  �  �  �  *�  �  �  �  �  ��    �  ��  #�  
  �  J�  ݊    �  �  }�    �  ��  �    �  �  ��  "  �  ��   �  (  �  B�  Ǎ  .  �  �  s�  4  �  ��  �  :  �  �  ��  @  �  �  ;�  F  �  ]�  ��  L  �  ې  h�  R  �  ��  �  X     %   �           �  s�?�   �  U   ��  � � �� � � � � � T� �� �� T� �C�  � �  � � �� %�� � ��e �	 B��  �� � T� �C��X�� T� �C� >�� T� �� ��% T� �C �  � � � � � �	 �� ��C � �
 �� %�� � ��� �	 B��  �� � %�� ��� �	 B��  �� � B�C� �� �\�� U  TCSUBKEY TCENTRY LNREGHANDLE LNRESULT LNSIZE LCDATABUFFER TNTYPE
 REGOPENKEY LNTYPE REGQUERYVALUEEX REGCLOSEKEY GKTGetRegString_HKCU,     ��1 � r� �� A � � Q� � A � A Q1                       g        %   |      �     �  �?+  �  U  �  ��  � � �� �6 T� �C�! Software\GKK Industries\GKK Tools �  � �� %�C� ���� � �
 GKTLocFile(� �� � %�C� �� C� ���� � �� �8 ��C�! Software\GKK Industries\GKK Tools �  C� ��� �� � �� � T� �C� ��� �� �	 B�� �� U  TCKEY
 TCFILENAME LCPATH GKTGETREGSTRING_HKCU
 GKTLOCFILE GKTSETREGSTRING_HKCU GKTGetToolsPath,     ��< � q a� ��� �A � AA � 1                    �  k        %   �        -   �  s�?\  �  U  � ��  � � �# �� � � � � � �	 �
 � H�? ��� �C� ��� C��c � T� �C� ��� �C� ��� N��� � T�	 �C� 8�� T�
 �� �	 �'�� T� �C�	 _� .C�
 _�� �C� ��� D��� � T� �C� *�� �C� ��� T��� T� �C� ��� �C� ��� L��O� %�� ��3� T� �� .T.�� �K� T� �� .F.�� � �C� ��� Y��s� T� �C� _�� 2��� T� �� �� � T� �� �� T� �C�  � �  � � �� %�� � ���� T� �C�  � �  � � �� %�� � ���� B���� � � %�C� �
��E� T� �C� >��$ T� �C �  � � � �  � � �� �c� T� �C �  � � �� � ��C � � �� %�� � ���� B���� � B�a�� U  TCSUBKEY TCENTRY
 TCSTRVALUE LNREGHANDLE LNRESULT LNSIZE LCDATABUFFER TNTYPE LCSTRBUFFER
 LNINTVALUE
 LNDECVALUE
 REGOPENKEY REGCREATEKEY REGSETVALUEEX REGDELETEVALUE REGCLOSEKEY GKTSetRegString_HKCU,     ��1 � 2� Q� Q� q�Q� QQ� � A Q� � � A � ��q A A � A� aA � q A q 1                       �     0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Screen                                                                                            WINDOWS _0L80KODD6 7422804098      O  f      }                          �      �                       WINDOWS _0L80KODD71058581057�      �              �
  �                  >d                           WINDOWS _0L80KODD6 983470862�f      �f  �f  �f  �f                                                           WINDOWS _0L80KODD6 983470862jg      wg  �g  �g  �g                                                           WINDOWS _0L80L8KAR10442125624h      Ch  Rh  eh  wh      i  �`                                               WINDOWS _0L810JNAY 983470862�m      n  n  !n  3n                                                           WINDOWS _0L80KODD6 983470862�n      �n  �n  �n  o                                                           WINDOWS _0L80KODD61058377393{  a�  �o  �o  �o  p      �p  6^                                               WINDOWS _0L80KODD61058581057Cy  �z  �u  �u  v  "v      �v  �[                                               WINDOWS _0L80KODD6 983470862�o  �u  �z  �z  �z  0{      qz  �Z                                               WINDOWS _1JZ0M87851044212562_z  ;z  )z  
z  �y  �y      �{  �I  ��  Yy                                       WINDOWS _2K71CUM68 983470862�o  �u  �u  �m  �m  �x      �m  �H                                               WINDOWS _2K91CIN8B 983470862qm      _m  Nm  <m  �l              �  �l                                       WINDOWS _2K91D4F9M1044212562�l  �l  ul  `l  Nl  �k      s  �E  ��  �k                                       WINDOWS _2N313GC3M1058377889�k  �k  wk  gk  ,d  �j      v�  �@                                               COMMENT RESERVED                                d                      �c                                    ��                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      ..\programs\gktdefines.h      dataenvironment      dataenvironment      Dataenvironment      YTop = 0
Left = 0
Width = 0
Height = 0
DataSource = .NULL.
Name = "Dataenvironment"
      1      1      form      form      
GKTLOCFILE     �Height = 298
Width = 562
Desktop = .F.
ShowWindow = 1
DoCreate = .T.
ShowTips = .F.
AutoCenter = .T.
BorderStyle = 2
Caption = "Locate File"
HalfHeightCaption = .T.
MaxButton = .F.
MinButton = .F.
Icon = ..\graphics\gktgkt.ico
WindowType = 1
AllowOutput = .F.
rtnvalue = 
currentdirectory = 
_memberdata =      985<VFPData><memberdata name="currentdirectory" type="property" display="CurrentDirectory"/><memberdata name="filelist" type="property" display="FileList"/><memberdata name="getassocicon" type="method" display="GetAssocIcon"/><memberdata name="getdrivelist" type="method" display="GetDriveList"/><memberdata name="rtnvalue" type="property" display="RtnValue"/><memberdata name="getdirectory" type="method" display="GetDirectory"/><memberdata name="getvolumename" type="method" display="GetVolumeName"/><memberdata name="computername" type="property" display="ComputerName"/><memberdata name="desktoppath" type="property" display="DesktopPath"/><memberdata name="lastmode" type="property" display="LastMode"/><memberdata name="mydocpath" type="property" display="MyDocPath"/><memberdata name="oiconbuddy" type="property" display="oIconBuddy"/><memberdata name="fileext" type="property" display="FileExt"/><memberdata name="filetolocate" type="property" display="FileToLocate"/></VFPData>

computername = 
desktoppath = 
lastmode = 
mydocpath = 
oiconbuddy = .NULL.
fileext = 
filetolocate = 
Name = "GKTLOCFILE"
     6PROCEDURE getdrivelist
LOCAL lnNumDrives, lnDriveID, lnDriveType, lcDrive, lnRow
LOCAL ARRAY lcDriveList[1,2]
thisform.CurrentDirectory = ""
thisform.lblCurrentFolder.caption = "Desktop"
lnNumDrives = 0
FOR lnDriveID=0 TO 25                              && Loop to check for drives
	lcDrive = CHR(lnDriveID+65) + ":"
	lnDriveType = DRIVETYPE(lcDrive)               && Check for drive ID attached to PC
	IF lnDriveType > 1 .AND. lnDriveType < 6
		lnNumDrives = lnNumDrives + 1
		DIMENSION lcDriveList[lnNumDrives,2]
		lcDriveList[lnNumDrives,1] = lcDrive
		lcDriveList[lnNumDrives,2] = lnDriveType
	ENDIF
ENDFOR
WITH thisform.grdCurrentDirectoryList
	.lockstate = True
	.Rows.Removeall()
	FOR lnRow=1 TO lnNumDrives
		.Rows.Add()
		WITH .listitem(lnRow,1)
			.text = " " + lcDriveList[lnRow,1]
			.pictureindex = lcDriveList[lnRow,2]
		ENDWITH
		DIMENSION thisform.FileList[lnRow,2]
		thisform.FileList[lnRow,1] = lcDriveList[lnRow,1]
		thisform.FileList[lnRow,2] = "D"
	ENDFOR
	.lockstate = False
ENDWITH
thisform.SetLookInCombo()
ENDPROC
PROCEDURE getassocicon
LPARAMETERS	tcFile
LOCAL lnIndex, lcImgKey
lnIndex = 0
IF !EMPTY(tcFile)
	IF INLIST(LOWER(JUSTEXT(tcFile)),"exe","dll","ico")
		lcImgKey = "_" + LOWER(JUSTFNAME(tcFile))
	ELSE
		lcImgKey = "_" + LOWER(JUSTEXT(tcFile))
	ENDIF		
	lnIndex = thisform.oIconBuddy.Extract2ImageList(tcFile,lcImgKey,This.OleImages,True,-1)
ENDIF
RETURN lnIndex
ENDPROC
PROCEDURE getdirectory
LPARAMETERS tcMode, tcSelDirectory
LOCAL lnNumFolders, lnRow, lnNdx, lnNumPath, lnPath, lcPath, lnIndent, lnDriveID, lcDrive, lnRow
LOCAL lcDriveName, lnIcon, lnNumDeskFldrs, lnNumMyDocFldrs
LOCAL ARRAY lcDirectoryList[1], lcDesktopList[1], lcMyDocList[1], lcDriveList[1,2]
WITH thisform
	.LastMode = tcMode
	.CurrentDirectory = tcSelDirectory
	.lblCurrentFolder.Caption = tcSelDirectory
	WITH .grdCurrentDirectoryList
		.LockState = True
		.RemoveAll()
	ENDWITH
	WITH .cboFolderList
		.RemoveAll()
		.FolderListKey = 0
	ENDWITH
	lnNumDeskFldrs  = ADIR(lcDesktopList,ADDBS(.DesktopPath)+"*.*","D",1)
	lnNumMyDocFldrs = ADIR(lcMyDocList,ADDBS(.MyDocPath)+"*.*","D",1)
	DO CASE
		CASE tcMode = "DESKTOP"
			WITH .cboFolderList
				lnRow = .AddListItem(0,"DeskTop",thisform.DesktopPath,7,0)
				lnRow = .AddListItem(lnRow,"My Documents",thisform.MyDocPath,10,1)
				lnRow = .AddListItem(lnRow,thisform.ComputerName,thisform.ComputerName,8,1)
				FOR lnDriveID=0 TO 25                                && Loop to add drives
					lcDrive = CHR(lnDriveID+65) + ":"
					lnIcon  = DRIVETYPE(lcDrive)
					IF lnIcon > 1
						lcDriveName = thisform.GetVolumeName(lcDrive,lnIcon)
						lnRow = .AddListItem(lnRow,lcDriveName,lcDrive,lnIcon,2)
					ENDIF
				ENDFOR
				FOR lnNdx=1 TO lnNumDeskFldrs                        && Add the folders attached to the desktop
					IF lcDesktopList[lnNdx,1] != "." .AND. ATC("D",lcDesktopList[lnNdx,5]) > 0
						lnRow = .AddListItem(lnRow,lcDesktopList[lnNdx,1],ADDBS(thisform.DesktopPath)+lcDesktopList[lnNdx,1],1,1)
					ENDIF
				ENDFOR
				.ComboItems(1).Selected = True
			ENDWITH
			WITH .grdCurrentDirectoryList
				lnRow = .AddListItem(0,10,"My Documents",thisform.MyDocPath,"D")
				lnRow = .AddListItem(lnRow,8,thisform.ComputerName,thisform.ComputerName,"D")
*-*				Get the directory list to display first
				FOR lnNdx=1 TO lnNumDeskFldrs
					IF lcDesktopList[lnNdx,1] != "." .AND. ATC("D",lcDesktopList[lnNdx,5]) > 0
						lnRow = .AddListItem(lnRow,1,lcDesktopList[lnNdx,1],ADDBS(thisform.DesktopPath)+lcDesktopList[lnNdx,1],"D")
					ENDIF
				ENDFOR
*-*				Get the files in the current directory to display
				FOR lnNdx=1 TO lnNumDeskFldrs
					IF ATC("D",lcDesktopList[lnNdx,5]) = 0 .AND. UPPER(JUSTEXT(lcDesktopList[lnNdx,1])) = thisform.FileExt
						lcFullName   = ADDBS(thisform.DesktopPath) + lcDesktopList[lnNdx,1]
						lnImageIndex = thisform.GetAssocIcon(lcFullName)
						DO CASE
							CASE lnImageIndex > .PictureCount .AND. lnImageIndex < 101
								.Pictures(lnImageIndex).Load(4,thisform.OleImages.ListImages(lnImageIndex).Picture)
								.PictureCount = lnImageIndex
							CASE lnImageIndex > .PictureCount .AND. lnImageIndex >= 101
								lnImageIndex = 6
							CASE lnImageIndex < 0
								lnImageIndex = 6
							OTHERWISE
								lnImageIndex = lnImageIndex
						ENDCASE
						lnRow = .AddListItem(lnRow,lnImageIndex,lcDesktopList[lnNdx,1],lcFullName,"F")
						IF UPPER(lcDesktopList[lnNdx,1]) = thisform.FileToLocate
							thisform.txtFileName.Tag = lcFullName
						ENDIF
					ENDIF
				ENDFOR
			ENDWITH

		CASE tcMode = "MY DOCUMENTS"
			WITH .cboFolderList
				lnRow = .AddListItem(0,"DeskTop",thisform.DesktopPath,7,0)
				lnRow = .AddListItem(lnRow,"My Documents",thisform.MyDocPath,10,1)
				lnRow = .AddListItem(lnRow,thisform.ComputerName,thisform.ComputerName,8,1)
				FOR lnDriveID=0 TO 25                                && Loop to add drives
					lcDrive = CHR(lnDriveID+65) + ":"
					lnIcon  = DRIVETYPE(lcDrive)
					IF lnIcon > 1
						lcDriveName = thisform.GetVolumeName(lcDrive,lnIcon)
						lnRow = .AddListItem(lnRow,lcDriveName,lcDrive,lnIcon,2)
					ENDIF
				ENDFOR
				FOR lnNdx=1 TO lnNumDeskFldrs                        && Add the folders attached to the desktop
					IF lcDesktopList[lnNdx,1] != "." .AND. ATC("D",lcDesktopList[lnNdx,5]) > 0
						lnRow = .AddListItem(lnRow,lcDesktopList[lnNdx,1],ADDBS(thisform.DesktopPath)+lcDesktopList[lnNdx,1],1,1)
					ENDIF
				ENDFOR
				.ComboItems(2).Selected = True
			ENDWITH
			WITH .grdCurrentDirectoryList
*-*				Get the directory list to display first
				lnRow = 0
				FOR lnNdx=1 TO lnNumMyDocFldrs
					IF lcMyDocList[lnNdx,1] != "." .AND. ATC("D",lcMyDocList[lnNdx,5]) > 0
						lnRow = .AddListItem(lnRow,1,lcMyDocList[lnNdx,1],ADDBS(thisform.MyDocPath)+lcMyDocList[lnNdx,1],"D")
					ENDIF
				ENDFOR
*-*				Get the files in the current directory to display
				FOR lnNdx=1 TO lnNumMyDocFldrs
					IF ATC("D",lcMyDocList[lnNdx,5]) = 0 .AND. UPPER(JUSTEXT(lcMyDocList[lnNdx,1])) = thisform.FileExt
						lcFullName   = ADDBS(thisform.MyDocPath) + lcMyDocList[lnNdx,1]
						lnImageIndex = thisform.GetAssocIcon(lcFullName)
						DO CASE
							CASE lnImageIndex > .PictureCount .AND. lnImageIndex < 101
								.Pictures(lnImageIndex).Load(4,thisform.OleImages.ListImages(lnImageIndex).Picture)
								.PictureCount = lnImageIndex
							CASE lnImageIndex > .PictureCount .AND. lnImageIndex >= 101
								lnImageIndex = 6
							CASE lnImageIndex < 0
								lnImageIndex = 6
							OTHERWISE
								lnImageIndex = lnImageIndex
						ENDCASE
						lnRow = .AddListItem(lnRow,lnImageIndex,lcMyDocList[lnNdx,1],lcFullName,"F")
						IF UPPER(lcMyDocList[lnNdx,1]) = thisform.FileToLocate
							thisform.txtFileName.Tag = lcFullName
						ENDIF
					ENDIF
				ENDFOR
			ENDWITH

		CASE tcMode = UPPER(.ComputerName)
			WITH .cboFolderList
				lnRow = .AddListItem(0,"DeskTop",thisform.DesktopPath,7,0)
				lnRow = .AddListItem(lnRow,"My Documents",thisform.MyDocPath,10,1)
				lnRow = .AddListItem(lnRow,thisform.ComputerName,thisform.ComputerName,8,1)
				FOR lnDriveID=0 TO 25                                && Loop to add drives
					lcDrive = CHR(lnDriveID+65) + ":"
					lnIcon  = DRIVETYPE(lcDrive)
					IF lnIcon > 1
						lcDriveName = thisform.GetVolumeName(lcDrive,lnIcon)
						lnRow = .AddListItem(lnRow,lcDriveName,lcDrive,lnIcon,2)
					ENDIF
				ENDFOR
				FOR lnNdx=1 TO lnNumDeskFldrs                        && Add the folders attached to the desktop
					IF lcDesktopList[lnNdx,1] != "." .AND. ATC("D",lcDesktopList[lnNdx,5]) > 0
						lnRow = .AddListItem(lnRow,lcDesktopList[lnNdx,1],ADDBS(thisform.DesktopPath)+lcDesktopList[lnNdx,1],1,1)
					ENDIF
				ENDFOR
				.ComboItems(3).Selected = True
			ENDWITH
			WITH .grdCurrentDirectoryList
				lnRow = 0
				FOR lnDriveID=0 TO 25                                && Loop to add drives
					lcDrive = CHR(lnDriveID+65) + ":"
					lnIcon  = DRIVETYPE(lcDrive)
					IF lnIcon > 1
						lcDriveName = thisform.GetVolumeName(lcDrive,lnIcon)
						lnRow = .AddListItem(lnRow,lnIcon,lcDriveName,lcDrive,"D")
					ENDIF
				ENDFOR
			ENDWITH

		CASE tcMode = "SELECTED DIRECTORY"
*-*			Display the current directory hierarchy in combobox drop-down
			lnSelRow = 3
			WITH .cboFolderList
				lnRow = .AddListItem(0,"DeskTop",thisform.DesktopPath,7,0)
				lnRow = .AddListItem(lnRow,"My Documents",thisform.MyDocPath,10,1)
				lnRow = .AddListItem(lnRow,thisform.ComputerName,thisform.ComputerName,8,1)
				FOR lnDriveID=0 TO 25                                && Loop to add drives
					lcDrive = CHR(lnDriveID+65) + ":"
					lnIcon  = DRIVETYPE(lcDrive)
					IF lnIcon > 1
						lcDriveName = thisform.GetVolumeName(lcDrive,lnIcon)
						lnRow = .AddListItem(lnRow,lcDriveName,lcDrive,lnIcon,2)
						IF GETWORDNUM(tcSelDirectory,1,"\") = lcDrive
							lnIndent   = 2                           && Add the selected folder levels
							lnNumPath  = GETWORDCOUNT(tcSelDirectory,"\")
							lcFullPath = lcDrive
							FOR lnPath=2 TO lnNumPath
								lnIndent   = lnIndent + 1
								lcPath     = GETWORDNUM(tcSelDirectory,lnPath,"\")
								lcFullPath = ADDBS(lcFullPath) + lcPath
								lnRow      = .AddListItem(lnRow,lcPath,lcFullPath,1,lnIndent)
							ENDFOR
							lnSelRow = lnRow
						ENDIF
					ENDIF
				ENDFOR
				FOR lnNdx=1 TO lnNumDeskFldrs                        && Add the folders attached to the desktop
					IF lcDesktopList[lnNdx,1] != "." .AND. ATC("D",lcDesktopList[lnNdx,5]) > 0
						lnRow = .AddListItem(lnRow,lcDesktopList[lnNdx,1],ADDBS(thisform.DesktopPath)+lcDesktopList[lnNdx,1],1,1)
					ENDIF
				ENDFOR
				.ComboItems(lnSelRow).Selected = True
			ENDWITH
			tcSelDirectory = ADDBS(tcSelDirectory)
			lnNumFolders = ADIR(lcDirectoryList,tcSelDirectory+"*.*","D",1)
			WITH .grdCurrentDirectoryList
*-*				Display the current directory listing
				lnRow = 0
				FOR lnNdx=1 TO lnNumFolders
					IF lcDirectoryList[lnNdx,1] != "." .AND. ATC("D",lcDirectoryList[lnNdx,5]) > 0
						lnRow = .AddListItem(lnRow,1,lcDirectoryList[lnNdx,1],tcSelDirectory+lcDirectoryList[lnNdx,1],"D")
					ENDIF
				ENDFOR
*-*				Get the files in the current directory to display
				FOR lnNdx=1 TO lnNumFolders
					IF ATC("D",lcDirectoryList[lnNdx,5]) = 0 .AND. UPPER(JUSTEXT(lcDirectoryList[lnNdx,1])) = thisform.FileExt
						lcFullName   = ADDBS(tcSelDirectory) + lcDirectoryList[lnNdx,1]
						lnImageIndex = thisform.GetAssocIcon(lcFullName)
						DO CASE
							CASE lnImageIndex > .PictureCount .AND. lnImageIndex < 101
								.Pictures(lnImageIndex).Load(4,thisform.OleImages.ListImages(lnImageIndex).Picture)
								.PictureCount = lnImageIndex
							CASE lnImageIndex > .PictureCount .AND. lnImageIndex >= 101
								lnImageIndex = 6
							CASE lnImageIndex < 0
								lnImageIndex = 6
							OTHERWISE
								lnImageIndex = lnImageIndex
						ENDCASE
						lnRow = .AddListItem(lnRow,lnImageIndex,lcDirectoryList[lnNdx,1],lcFullName,"F")
						IF UPPER(lcDirectoryList[lnNdx,1]) = thisform.FileToLocate
							thisform.txtFileName.Tag = lcFullName
						ENDIF
					ENDIF
				ENDFOR
			ENDWITH
	ENDCASE
	.cboFolderList.Refresh()
	WITH .grdCurrentDirectoryList
		.LockState = False
		.SetFocus()
	ENDWITH
ENDWITH
ENDPROC
PROCEDURE getvolumename
LPARAMETERS tcDrive,tnType
LOCAL lcVolumeName, lnVolumeNameSize, lnVolumeSerial, lnMaxCompLength, lnFileSysFlag, lcFileSysNameBuf
LOCAL lnFileSysNameSize, lnReturn
tcDrive = ADDBS(tcDrive)
lcVolumeName      = SPACE(256)
lnVolumeNameSize  = 256
lnVolumeSerial    = 0
lnMaxCompLength   = 256
lnFileSysFlag     = 0
lcFileSysNameBuf  = SPACE(256)
lnFileSysNameSize = 256
lnReturn = GetVolumeInformation(@tcDrive,@lcVolumeName,lnVolumeNameSize,@lnVolumeSerial,@lnMaxCompLength,@lnFileSysFlag,@lcFileSysNameBuf,lnFileSysNameSize)
lcVolumeName = ALLTRIM(lcVolumeName," ",CHR(0))
IF EMPTY(lcVolumeName)
	DO CASE
		CASE tnType = 2                      && Floppy disk
			lcVolumeName = "Floppy Disk"
		CASE tnType = 3                      && Hard disk
			lcVolumeName = "Local Disk"
		CASE tnType = 4                      && Removable drive OR network drive
			lcVolumeName = "Removable Disk"
		CASE tnType = 5                      && CD-ROM
			lcVolumeName = "CD-ROM"
	ENDCASE
ENDIF
lcVolumeName = lcVolumeName + " (" + tcDrive + ")"
RETURN lcVolumeName
ENDPROC
PROCEDURE Destroy
thisform.oIconBuddy = .NULL.
ENDPROC
PROCEDURE Unload
RETURN thisform.RtnValue
ENDPROC
PROCEDURE Activate
SET CURSOR ON
ENDPROC
PROCEDURE Init
LPARAMETER tcFileName
LOCAL lnNdx, lcCurPath, lcMode, lnSize, lcBuffer
lnSize   = 100
lcBuffer = SPACE(lnSize)
GetComputerName(@lcBuffer, @lnSize)
WITH thisform
	.FileToLocate = UPPER(tcFileName)
	.FileExt      = UPPER(JUSTEXT(tcFileName))
	.ComputerName = ALLTRIM(lcBuffer," ",CHR(0))
	.DesktopPath  = GKTGetRegString_HKCU("SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders","Desktop")
	.MyDocPath    = GKTGetRegString_HKCU("SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders","Personal")
	.oIconBuddy   = NEWOBJECT("iconbuddy","gkticonbuddy.vcx")
	.txtFileName.Value = tcFileName
*-*	Set the current directory listing
	DO CASE
		CASE UPPER(_SCREEN.GKKTools.LastDirectory) = UPPER(.DesktopPath)
			lcMode = "DESKTOP"
		CASE UPPER(_SCREEN.GKKTools.LastDirectory) = UPPER(.MyDocPath)
			lcMode = "MY DOCUMENTS"
		CASE UPPER(_SCREEN.GKKTools.LastDirectory) = UPPER(.ComputerName)
			lcMode = UPPER(.ComputerName)
		OTHERWISE
			lcMode = "SELECTED DIRECTORY"
	ENDCASE
	.GetDirectory(lcMode,_SCREEN.GKKTools.LastDirectory)
ENDWITH
ENDPROC
     ����    �  �                        P�   %   �      -  $   �          �  U  |' ��  � � � � � � � � � ��	 �������	 ��C���& T� �C� Form� FavoritePlaces�
 �� %�C� ����� T� �� �� +�a���� T�  �� PlaceC� _��[ T� �C�F SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\comdlg32\PlacesBar\ �  � �� %�C� ���� !� � +�C� %� �� ���� T� �C� � %� %���� T� �C� 5�� T� �C� %� ���� T� �C� %� ����  T� �C� � � � �� [�� � T� �C� C� \� ��\�� ��C �  � � � �� T� �� ��� � �u� �� ���(�C� � |����q� T�  �C� � � |���� T� �C�  �� >���� T� �C�  �� >���� ��C �  � � � �� �� � U  LCPLACE LCKEY LNCNT LCENV LNBEG LNEND LCNAME LCFAVORITES LNPLACE LAPLACES GKTGETSTRING_VFP GKTGETREGSTRING_HKCU THIS ADDCMDBUTTON:  ��  �0 ��C� SELECTED DIRECTORYC �  � � � � � �� U  TNCMDBUTTON THISFORM GETDIRECTORY THIS CMDCOLLECTION TOOLTIPTEXT Init,     �� usercmdclick<    ��1 q1� a� � � ��� A A ��� aaA �QA � �qqqQA A 2 q 1                       �     !   �  n  "    )   �                       2���                              �   %   6      �     x          �  U   ��  � H� �� �  �C� � � f� DESKTOP��H � T�  �� DESKTOP��% �C� � � f� MY DOCUMENTS��� � T�  �� MY DOCUMENTS�� �C� � � fC� � f��� � T�  �C� � f�� 2�� � T�  �� SELECTED DIRECTORY�� �! ��C �  C� � � � � � � �� U	  LCMODE THIS SELECTEDITEM TEXT THISFORM COMPUTERNAME GETDIRECTORY ITEMLIST INDEX  T�  � � �-�� U  THISFORM LABEL1 FONTBOLD  T�  � �� � �� U  THIS	 IMAGELIST THISFORM	 OLEIMAGES  T�  � � �a�� U  THISFORM LABEL1 FONTBOLD Click,     ��	 LostFocus�    �� Init�    �� GotFocus    ��1 q � AQ��!� �A 2 2 12 1                       �        �  �          &        E  d      )                           ����    �   �                         ��   %   \       s      k           �  U    T�  � ���� <�  � U  THISFORM RTNVALUE Click,     ��1 � q 1                       =       )   �                        )���                                 %   �      g  �   C          �  U  � ��  � � � � �� � %��  � ���� ��� ���� H�E ��� �C �  �� � � D��m� H�o �L�( �CC �  �� � �	 f� DESKTOP��� � T� �� DESKTOP��- �CC �  �� � �	 f� MY DOCUMENTS��� � T� �� MY DOCUMENTS��$ �CC �  �� � �	 fC��
 f��%� T� �C��
 f�� 2�L� T� �� SELECTED DIRECTORY�� � ��C � C �  �� � �� �� �C �  �� � � F���� T�� � �CC �  �� � ���� T�� � �C �  �� � �� ��C�� � �� � �� � U  TNROW NCOLUMNINDEX BONTEXT
 BONPICTURE LCMODE THISFORM THIS ITEMLIST LISTITEM TEXT COMPUTERNAME GETDIRECTORY TXTFILENAME VALUE TAG	 CMDSELECT CLICK�  ��  � ��� ��� � %��  � ��� � %�C �  �� � � F��} � T�� � �CC �  �� � ���� T�� � �C �  �� � �� � � �� U  TNROW THISFORM THIS ITEMLIST TXTFILENAME VALUE TAG ��  � �� � � �� ����" %��  �� � � � � 	��� T� �� � � �� ��� �� � H�n ��� �C � �� � � D���� H�� �u�( �CC � �� �	 �
 f� DESKTOP��� � T� �� DESKTOP��- �CC � �� �	 �
 f� MY DOCUMENTS��� T� �� MY DOCUMENTS��$ �CC � �� �	 �
 fC�� f��N� T� �C�� f�� 2�u� T� �� SELECTED DIRECTORY�� � ��C � C � �� � �� �� �C � �� � � F���� T�� � �CC � �� � ���� T�� � �C � �� � �� ��C�� � �� � �� � U 
 TNKEYASCII LNROW LCMODE
 LCFILELIST THIS ROWS HIGHLIGHTEDINDEX THISFORM ITEMLIST LISTITEM TEXT COMPUTERNAME GETDIRECTORY TXTFILENAME VALUE TAG	 CMDSELECT CLICKf ��  � �� � � � � � ��� ��_� %��  ��;�( T� �C� � ��CC��
 � ���	 � ��� T� �a�� �� ���(���
 � ��� %�CC � ��� fC� f���2 T� ��% The entered directory already exists.��& ��C � �
 New Folder�� ERROR� �� T� �-�� !� � �� %�� ��� ��2�
 ��� �� �(� ���1 T� ��$ Could not create the entered folder.��& ��C � �
 New Folder�� ERROR� �� �� %�C� ����� �� ���
 � ����� T�� ���
 � ������ �� T�� ���
 � ������ D�� ��C��
 � ��� �� � �7� ��C��
 � ���
 � �� � �[� ��C��
 � ���
 � �� � �� U  BSAVED LLDIROK LNNDX	 LCUSERMSG LCDIRECTORY LOEXCEPTION THIS THISFORM CURRENTDIRECTORY LISTITEM ROWS COUNT TEXT ITEMLIST
 GKTWMSGBOX ONITEMLDOUBLECLICK REMOVEy  ��  � �( %�� � � C � �� � � F	��r �! T� � � �CC � �� � ���� T� � � �C � �� � �� � U  CSEARCHSTRING TNROW THIS ITEMLIST THISFORM TXTFILENAME VALUE TAG�  ��  � � � � � ��� ��� � T�  ��  ��� ��C�� � �� T�� ��  �����	 �� �� T�� ��  �����
 �� �� �� ��  ����� T�� ��  ������ �� T�� ��  ������ �� ��	 B��  �� U  TNROW	 TNPICTURE TCTEXT
 TCFULLTEXT TCTYPE THIS ROWS ADD LISTITEM PICTUREINDEX TEXT ITEMLISTI ���  ��B� ��C��� � �� ��C��� ��O � T�� ���� T�� � ���� �� ��C��� ��� � T�� ��  � �2�� T�� � ���� �� T�� � ���� T�� �-�� T��	 �a�� T��
 �-�� T�� ���� T�� �a�� T�� �-��! ��C��C�� � � � �� ��! ��C��C�� � � � �� ��! ��C��C�� � � � �� ��! ��C��C�� � � � �� ��! ��C��C�� � � � �� ��! ��C��C�� � � � �� ��! ��C��C�� � � � �� ��! ��C��C�� � � � �� ��! ��C�	�C�	� � � � �� ��! ��C�
�C�
� � � � �� �� T�� ��
�� �� U  THIS COLUMNS ADD WIDTH DEFAULTS CONTENTTYPE ROWS HEIGHT HEADERVISIBLE INCREMENTALSEARCH MULTIPLESELECTION KEYPRESSBOUNDCOLUMN ALWAYSSHOWSELECTION HORIZONTALSCROLLBARSHOWABLE
 SETPICTURE THISFORM	 OLEIMAGES
 LISTIMAGES PICTURE PICTURECOUNT OnItemLDoubleClick,     �� AfterRowChanged�    ��
 OnKeyPress    �� OnEndOfItemEdit>    �� OnItemFoundV	    �� addlistitem
    �� Init\    ��1 1q � � �� �A��A� �A ����� A A A 2 q � ���A A A 2 q � � !1� � �� �A��A� �A ����� A A A 2 q q� � �� ��!a� A A A � � � � aA ���QA � �A � �A A 2 � ��A 2 q� � ��A��A � 2 � !� A !QA � � � � � � � A 1                               <       $   4  �  '   ?   �  [  D   b   }  J  h   h   l  �  o   t   �  �  |    )                           ����    �   �                         ��   %   ^       u      m           �  U    T�  � ��  �� <�  � U  THISFORM RTNVALUE Click,     ��1 q 1                       9       )   �                        m���    T  T                        �   %   �           �          �  U  ? ��  � ��� ��8� %�C�� � ���v �( T�  �� File has not been selected.��' ��C �  � Locate File�� ERROR� �� �4� %�C�� � 0��� � T�9� � �CC�� � ������ T�� ��� � �� <� � �0�- T�  ��  The entered file does not exist.��' ��C �  � Locate File�� ERROR� �� ��C�� �	 �� � � �� U
 	 LCUSERMSG THISFORM TXTFILENAME VALUE
 GKTWMSGBOX TAG GKKTOOLS LASTDIRECTORY RTNVALUE SETFOCUS Click,     ��1 q � 1�q� 1�!q � �q� A A A 1                       �      )   T                       ����    �  �                        l,   %         B               �  U  m ��  � ��� � ��f� H�$ �-� ��� � ���F � T�  ��  ��* �CC�� � ��� � f� DESKTOP��� � T�  �� DESKTOP��/ �CC�� � ��� � f� MY DOCUMENTS��� � T�  �� MY DOCUMENTS��( �CC�� � ��� � fC� � f��� T�  �C� � f�� 2�-� T�  �� SELECTED DIRECTORY�� � %�C�  �
��b�! ��C �  C�� � ���	 � � �� � �� U
  LCMODE THISFORM CBOFOLDERLIST SELECTEDITEM INDEX
 COMBOITEMS TEXT COMPUTERNAME GETDIRECTORY ITEMLIST Click,     ��1 q � Q� �A���!� �A A A 1                       S      )   �                       ����    �  �                        
a   %   �      M     /          �  U  9  %�C�  � �
��2 � T�  � �C� � ��C�  � ��� � U  THIS VALUE TAG THISFORM CURRENTDIRECTORY  T�  � � �a�� U  THISFORM LABEL2 FONTBOLD  T�  � � �-�� U  THISFORM LABEL2 FONTBOLD'  ��  � � � � T� � � �a�� U  NBUTTON NSHIFT NXCOORD NYCOORD THISFORM LABEL2 FONTBOLD'  ��  � � � � T� � � �-�� U  NBUTTON NSHIFT NXCOORD NYCOORD THISFORM LABEL2 FONTBOLD Valid,     �� GotFocus�     ��	 LostFocus�     ��
 MouseEnter�     ��
 MouseLeavei    ��1 1�A 2 2 2 12 11                       q         �   �         �   �   	   	     ^          �      )   �                        "  ..\programs\gktdefines.h��|0?      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      
GKTLOCFILE     ]rtnvalue RtnValue
currentdirectory CurrentDirectory
_memberdata XML Metadata for customizable properties
computername ComputerName    
desktoppath DesktopPath
lastmode Last selected mode on cboFolderList
mydocpath My Documents directory path
oiconbuddy Object handle to IconBuddy
fileext File extension of file to locate
filetolocate File name to locate
^filelist[1,5] Listing of files and directories in the current directory
*getdrivelist GetDriveList
*getassocicon Gets the associated icon for the file
*getdirectory Gets the selected directory
*getvolumename Gets the drive volume name
      label      label      Label1      
GKTLOCFILE      �AutoSize = .T.
FontBold = .F.
Caption = "Look in:"
Height = 17
Left = 107
Top = 13
Width = 45
TabIndex = 10
Name = "Label1"
      label      label      Label2      
GKTLOCFILE      �AutoSize = .T.
FontBold = .F.
Caption = "File name:"
Height = 17
Left = 107
Top = 235
Width = 60
TabIndex = 12
Name = "Label2"
      textbox      textbox      txtFileName      
GKTLOCFILE      �Height = 24
Left = 171
ReadOnly = .T.
SelectOnEntry = .T.
TabIndex = 2
Top = 231
Width = 273
DisabledBackColor = 255,255,255
Name = "txtFileName"
     �PROCEDURE Valid
IF !EMPTY(this.Value)
	this.Tag = ADDBS(thisform.CurrentDirectory) + ALLTRIM(this.Value)
ENDIF
ENDPROC
PROCEDURE GotFocus
thisform.label2.FontBold = True
ENDPROC
PROCEDURE LostFocus
thisform.label2.FontBold = False
ENDPROC
PROCEDURE MouseEnter
LPARAMETERS nButton, nShift, nXCoord, nYCoord
thisform.label2.FontBold = True
ENDPROC
PROCEDURE MouseLeave
LPARAMETERS nButton, nShift, nXCoord, nYCoord
thisform.label2.FontBold = False
ENDPROC
      dTop = 8
Left = 6
Width = 87
Height = 285
TabIndex = 8
Name = "Sidebar1"
Line1.Name = "Line1"
      Sidebar1      	container      ..\classes\gktoutlookbar.vcx      sidebar      .OLEObject = C:\WINDOWS\system32\MSCOMCTL.OCX
      UTop = 8
Left = 169
Height = 24
Width = 357
TabIndex = 6
Name = "cboFolderList"
      
GKTLOCFILE      cboFolderList      
olecontrol      ..\classes\gktitemlist.vcx      	imagelist      .OLEObject = C:\WINDOWS\system32\MSCOMCTL.OCX
      DTop = 262
Left = 108
Height = 43
Width = 49
Name = "OleImages"
      
GKTLOCFILE      	OleImages      
olecontrol      
olecontrol      HPROCEDURE Click
thisform.RtnValue = .NULL.
RELEASE thisform
ENDPROC
      
GKTLOCFILE      cmdIgnoreAll      label      label      Label4      
GKTLOCFILE      �AutoSize = .T.
FontBold = .F.
Caption = "Current Folder:"
Height = 17
Left = 107
Top = 39
Width = 84
TabIndex = 11
Name = "Label4"
      label      label      lblCurrentFolder      
GKTLOCFILE      �AutoSize = .F.
Caption = "lblCurrentFolder"
Height = 17
Left = 204
Top = 39
Width = 352
TabIndex = 13
Name = "lblCurrentFolder"
      _commandbutton      _commandbutton      commandbutton      cmdUpFolder      
GKTLOCFILE      �Top = 9
Left = 534
Height = 22
Width = 22
Picture = ..\graphics\folderback.bmp
Caption = ""
TabIndex = 7
ToolTipText = "Up one folder"
Name = "cmdUpFolder"
     ^PROCEDURE Click
LOCAL lcMode
WITH thisform.cboFolderList
	DO CASE
		CASE .SelectedItem.Index = 1
			lcMode = ""
		CASE UPPER(.ComboItems(.SelectedItem.Index-1).Text) = "DESKTOP"
			lcMode = "DESKTOP"
		CASE UPPER(.ComboItems(.SelectedItem.Index-1).Text) = "MY DOCUMENTS"
			lcMode = "MY DOCUMENTS"
		CASE UPPER(.ComboItems(.SelectedItem.Index-1).Text) = UPPER(thisform.ComputerName)
			lcMode = UPPER(thisform.ComputerName)
		OTHERWISE
			lcMode = "SELECTED DIRECTORY"
	ENDCASE
	IF !EMPTY(lcMode)
		thisform.GetDirectory(lcMode, .ItemList[.SelectedItem.Index-1])
	ENDIF
ENDWITH
ENDPROC
     oPROCEDURE Click
LOCAL lcMode
DO CASE
	CASE UPPER(this.SelectedItem.Text) = "DESKTOP"
		lcMode = "DESKTOP"
	CASE UPPER(this.SelectedItem.Text) = "MY DOCUMENTS"
		lcMode = "MY DOCUMENTS"
	CASE UPPER(this.SelectedItem.Text) = UPPER(thisform.ComputerName)
		lcMode = UPPER(thisform.ComputerName)
	OTHERWISE
		lcMode = "SELECTED DIRECTORY"
ENDCASE
thisform.GetDirectory(lcMode, this.ItemList[this.SelectedItem.Index])
ENDPROC
PROCEDURE LostFocus
thisform.label1.FontBold = False
ENDPROC
PROCEDURE Init
this.ImageList = thisform.OleImages
ENDPROC
PROCEDURE GotFocus
thisform.label1.FontBold = True
ENDPROC
      commandbutton      ..\classes\gktbaseclasses.vcx      ..\classes\gktbaseclasses.vcx      commandbutton      	cmdSelect      
GKTLOCFILE      �Top = 228
Left = 456
Height = 22
Width = 100
Caption = "Select"
Default = .F.
TabIndex = 3
SpecialEffect = 0
Name = "cmdSelect"
     �PROCEDURE Click
LOCAL lcUserMsg
WITH thisform
	IF EMPTY(.txtFileName.value)
		lcUserMsg = "File has not been selected."
		=GKTWMSGBOX(lcUserMsg,"Locate File",16,"ERROR")
	ELSE
		IF FILE(.txtFileName.Tag)
			_SCREEN.GKKTools.LastDirectory = ADDBS(JUSTPATH(.txtFileName.Tag))
			.RtnValue = .txtFileName.Tag
			RELEASE thisform
		ELSE
			lcUserMsg = "The entered file does not exist."
			=GKTWMSGBOX(lcUserMsg,"Locate File",16,"ERROR")
			.txtFileName.setfocus()
		ENDIF
	ENDIF
ENDWITH
ENDPROC
      �Top = 272
Left = 456
Height = 22
Width = 100
Caption = "Ignore All"
TabIndex = 5
SpecialEffect = 0
Name = "cmdIgnoreAll"
      _commandbutton      .OLEObject = C:\WINDOWS\system32\BBLIST~1.OCX
      aTop = 58
Left = 101
Height = 165
Width = 455
TabIndex = 1
Name = "grdCurrentDirectoryList"
      
GKTLOCFILE      grdCurrentDirectoryList      
olecontrol      ..\classes\gktbblistview.vcx      
bblistview      DPROCEDURE Click
thisform.RtnValue = ""
RELEASE thisform
ENDPROC
      
GKTLOCFILE      	cmdIgnore      commandbutton      ..\classes\gktbaseclasses.vcx      _commandbutton      zTop = 250
Left = 456
Height = 22
Width = 100
Caption = "Ignore"
TabIndex = 4
SpecialEffect = 0
Name = "cmdIgnore"
     �PROCEDURE OnItemLDoubleClick
LPARAMETERS tnRow, ncolumnindex, bontext, bonpicture
LOCAL lcMode
IF tnRow > 0
	WITH thisform
		DO CASE
			CASE this.ItemList[tnRow,2] = "D"
				DO CASE
					CASE UPPER(this.ListItem(tnRow,2).Text) = "DESKTOP"
						lcMode = "DESKTOP"
					CASE UPPER(this.ListItem(tnRow,2).Text) = "MY DOCUMENTS"
						lcMode = "MY DOCUMENTS"
					CASE UPPER(this.ListItem(tnRow,2).Text) = UPPER(.ComputerName)
						lcMode = UPPER(.ComputerName)
					OTHERWISE
						lcMode = "SELECTED DIRECTORY"
				ENDCASE
				.GetDirectory(lcMode, this.ItemList[tnRow,1])

			CASE this.ItemList[tnRow,2] = "F"
				.txtFileName.value = JUSTFNAME(this.ItemList[tnRow,1])
				.txtFileName.Tag   = this.ItemList[tnRow,1]
				.cmdSelect.Click()
		ENDCASE
	ENDWITH
ENDIF
ENDPROC
PROCEDURE AfterRowChanged
LPARAMETERS tnRow
WITH thisform
	IF tnRow > 0
		IF this.ItemList[tnRow,2] = "F"
			.txtFileName.value = JUSTFNAME(this.ItemList[tnRow,1])
			.txtFileName.Tag   = this.ItemList[tnRow,1]
		ENDIF
	ENDIF
ENDWITH
ENDPROC
PROCEDURE OnKeyPress
LPARAMETERS tnKeyAscii
LOCAL lnRow, lcMode
LOCAL ARRAY lcFileList[1]
IF tnKeyAscii = 13 .AND. this.Rows.HighLightedIndex > 0
	lnRow = this.Rows.HighLightedIndex
	WITH thisform
		DO CASE
			CASE this.ItemList[lnRow,2] = "D"
				DO CASE
					CASE UPPER(this.ListItem(lnRow,2).Text) = "DESKTOP"
						lcMode = "DESKTOP"
					CASE UPPER(this.ListItem(lnRow,2).Text) = "MY DOCUMENTS"
						lcMode = "MY DOCUMENTS"
					CASE UPPER(this.ListItem(lnRow,2).Text) = UPPER(.ComputerName)
						lcMode = UPPER(.ComputerName)
					OTHERWISE
						lcMode = "SELECTED DIRECTORY"
				ENDCASE
				.GetDirectory(lcMode, this.ItemList[lnRow,1])

			CASE this.ItemList[lnRow,2] = "F"
				.txtFileName.value = JUSTFNAME(this.ItemList[lnRow,1])
				.txtFileName.Tag   = this.ItemList[lnRow,1]
				.cmdSelect.Click()
		ENDCASE
	ENDWITH
ENDIF
ENDPROC
PROCEDURE OnEndOfItemEdit
LPARAMETERS bsaved
LOCAL llDirOK, lnNdx, lcUserMsg, lcDirectory, loException
WITH this
	IF bsaved
		lcDirectory = ADDBS(thisform.CurrentDirectory) + ALLTRIM(.ListItem(.Rows.Count,2).text)
		llDirOK = True
		FOR lnNdx=1 TO .Rows.Count
			IF UPPER(.ItemList[lnNdx,1]) == UPPER(lcDirectory)
				lcUserMsg = "The entered directory already exists."
				=GKTWMSGBOX(lcUserMsg,"New Folder",16,"ERROR")
				llDirOK = False
				EXIT
			ENDIF
		ENDFOR
		IF llDirOK
			TRY
				MKDIR (lcDirectory)
			CATCH TO loException
				lcUserMsg = "Could not create the entered folder."
				=GKTWMSGBOX(lcUserMsg,"New Folder",16,"ERROR")
			ENDTRY
			IF DIRECTORY(lcDirectory)
				DIMENSION .ItemList[.Rows.Count,2]
				.ItemList[.Rows.Count,1] = lcDirectory
				.ItemList[.Rows.Count,2] = "D"
				.OnItemLDoubleClick(.Rows.Count,1)
			ENDIF
		ELSE
			.Rows.Remove(.Rows.Count,1)
		ENDIF
	ELSE
		.Rows.Remove(.Rows.Count,1)
	ENDIF
ENDWITH
ENDPROC
PROCEDURE OnItemFound
LPARAMETERS csearchstring, tnRow
IF tnRow>0 .AND. this.ItemList[tnRow,2] = "F"
	thisform.txtFileName.value = JUSTFNAME(this.ItemList[tnRow,1])
	thisform.txtFileName.Tag   = this.ItemList[tnRow,1]
ENDIF
ENDPROC
PROCEDURE addlistitem
LPARAMETERS tnRow,tnPicture,tcText,tcFullText,tcType
WITH this
	tnRow = tnRow + 1
	.Rows.Add()
	.ListItem(tnRow,1).PictureIndex = tnPicture
	.ListItem(tnRow,2).Text = tcText
	DIMENSION .ItemList[tnRow,2]
	.ItemList[tnRow,1] = tcFullText
	.ItemList[tnRow,2] = tcType
ENDWITH
RETURN tnRow
ENDPROC
PROCEDURE Init
WITH this
	.Columns.Add(2)
	WITH .Columns(1)
		.Width = 20
		.Defaults.ContentType = 2
	ENDWITH
	WITH .Columns(2)
		.Width = this.width - 50
		.Defaults.ContentType = 1
	ENDWITH
	.Rows.Height       = 18
	.HeaderVisible     = False
	.IncrementalSearch = True
	.MultipleSelection = False
	.KeyPressBoundColumn = 2
	.AlwaysShowSelection = True
	.HorizontalScrollBarShowable = False
	.SetPicture(1,4,thisform.OleImages.ListImages(1).Picture)
	.SetPicture(2,4,thisform.OleImages.ListImages(2).Picture)
	.SetPicture(3,4,thisform.OleImages.ListImages(3).Picture)
	.SetPicture(4,4,thisform.OleImages.ListImages(4).Picture)
	.SetPicture(5,4,thisform.OleImages.ListImages(5).Picture)
	.SetPicture(6,4,thisform.OleImages.ListImages(6).Picture)
	.SetPicture(7,4,thisform.OleImages.ListImages(7).Picture)
	.SetPicture(8,4,thisform.OleImages.ListImages(8).Picture)
	.SetPicture(9,4,thisform.OleImages.ListImages(9).Picture)
	.SetPicture(10,4,thisform.OleImages.ListImages(10).Picture)
	.PictureCount = 10
ENDWITH
ENDPROC
     yPROCEDURE Init
LOCAL lcPlace, lcKey, lnCnt, lcEnv, lnBeg, lnEnd, lcName, lcFavorites, lnPlace
LOCAL ARRAY laPlaces[1,2]
DODEFAULT()
lcFavorites = GKTGetString_VFP("Form","FavoritePlaces")
IF EMPTY(lcFavorites)
	lnCnt = 0
	DO WHILE True
		lcPlace = "Place" + TRANSFORM(lnCnt)
		lcKey = GKTGetRegString_HKCU("SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\comdlg32\PlacesBar\",lcPlace)
		IF EMPTY(lcKey)
			EXIT
		ENDIF
		DO WHILE ATC("%",lcKey) > 0
			lcEnv = STREXTRACT(lcKey,"%","%")
			lcEnv = GETENV(lcEnv)
			lnBeg = ATC("%",lcKey,1)
			lnEnd = ATC("%",lcKey,2)
			lcKey = STUFF(lcKey,lnBeg,lnEnd-lnBeg+1,lcEnv)
		ENDDO
		lcName = SUBSTR(lcKey,RATC("\",lcKey)+1)
		this.AddCmdButton(lcName,lcKey)
		lnCnt = lnCnt + 1
	ENDDO
ELSE
	FOR lnPlace=1 TO GETWORDCOUNT(lcFavorites,"|")
		lcPlace = GETWORDNUM(lcFavorites,lnPlace,"|")
		lcName  = GETWORDNUM(lcPlace,1,">")
		lcKey   = GETWORDNUM(lcPlace,2,">")
		this.AddCmdButton(lcName,lcKey)
	ENDFOR
ENDIF
ENDPROC
PROCEDURE usercmdclick
LPARAMETERS tnCmdButton
thisform.GetDirectory("SELECTED DIRECTORY",this.CmdCollection(tnCmdButton).TooltipText)
ENDPROC
     
 ��ࡱ�                >  ��	                               ����        ��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������R o o t   E n t r y                                               ��������                               �WR��b�   @       O l e O b j e c t D a t a                                            ����                                        ~        A c c e s s O b j S i t e D a t a                             &  ������������                                       \        C h a n g e d P r o p s                                         ������������                                       '             ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������f��ݔ���j ��(6(!C4   �$  {  $�U   >           �ͫ   �kSw\                          $   8                       9368265E-85FE-11d1-8BE3-0000F8754DA1    ��      ��      4�      v�        �   Text    H       cboFolderList T�      z�      �      o   �  ���   c b o F o l d e r L i s t     ��  ��   v�      D�      
�      ��      ��      l     B�      
�      ��      z     ��      ��      ��      ��      �      �      �|           0M      $�      $�      ��      n�      $�           
 ��ࡱ�                >  ��	                               ����        ��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������R o o t   E n t r y                                               ��������                               �WR��b�           O l e O b j e c t D a t a                                            ����                                        H        A c c e s s O b j S i t e D a t a                             &  ������������                                       8        C h a n g e d P r o p s                                         ������������                                                 ����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������#.�����  �{N�  /                                8                              8                       5 4 9 E   �- 3 8 9 4 - 1 1 D 2 - B B 7 F - 0 0 A 0 C 9 9 9 C 4 C 1 }      ...I N N T \ S y s t e m 3 2 \ L M R T . d l l   L M   R u n t i m e   C o n t r o l 	 { 1 8 3 C 2 5 9 A - 0 4 8 0 - 1 1 d 1 - 8 7 E A - 0 0 C 0 4 F C 2 9 D 4 6 }   C : \ W I N N T \ S y s t e m 3 2 \ L M R T . d l l   M i c r o s o f t   M u l t i m e d i a   C o n t r o l ,   v e r s i o n   6 . 0 	 { C 1 A 8 A      , ��ࡱ�                >  ��	                               ����        ����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������      ������������������������                           ��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������R o o t   E n t r y                                               ��������                               �WR��b�   �        O l e O b j e c t D a t a                                            ����                                       �       A c c e s s O b j S i t e D a t a                             &  ������������                                        \        C h a n g e d P r o p s                                         ������������                                       =          ����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������\                          $   8                       9368265E-85FE-11d1-8BE3-0000F8754DA1$   8                       9368265E  �   ImageHeight 	   I
         ImageWidth 	   I
       0 #$,����j ��(6(!C4       �~��        ��� ��  �ͫ    �   ����  �    
      C l s d F o l d    F l o p p y    H D d r i v e    N k D r i v e    C D R O M    F i l e I c o n    D e s k t o p 
   M y C o m p u t e r 	   M y N e t w o r k    M y D o c u m e n t s   (   lt  >       s   P ��� Ǳ� ��� �k� sH� W%� U � I � = � 1 � % s  P ��� �� Ԏ� �k� �H� �%� � � � � z � b � J s 2 P ��� ��� ��� �k� �H� �%� � � � � � � � � s s P P ��� ��� ��� �k� �H� �%� � � � � � z � b s J P 2 ��� ��� ��� �k� �Hs �%W � U � I � = � 1 s % P  ��� ��� ��� �kk �HH �%% �   �   �   �   s   P   ��� �Ǳ ��� ��k �sH �W% �U  �I  �=  �1  s%  P  ��� �� �Ԏ ��k ��H ��% ��  ܒ  �z  �b  sJ  P2  ��� ��� ��� ��k ��H ��% ��  ��  ��  ��  ss  PP  ��� ��� ��� ��k ��H ��% ��  ��  z�  b�  Js  2P  ��� ��� ��� ��k s�H W�% U�  I�  =�  1�  %s  P  ��� ��� ��� k�k H�H %�%  �   �   �   �   s   P  ��� ��� ��� k�� H�s %�W  �U  �I  �=  �1  s%  P ��� ��� ��� k�� H�� %��  ��  ܒ  �z  �b  sJ  P2 ��� ��� ��� k�� H�� %��  ��  ��  ��  ��  ss  PP ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� zzz nnn bbb VVV JJJ >>> 222 &&&   ��� ��� ���   �  �   �� �   � � ��  ���   �������������  �����������������������������������������������������������ッ���������������������������������낂�������������⃃�������� ���������vv���  �����������     ����������      ���������   �  �                                           �   �  �  �  ���p������p������p wwwwwwp                                        ��  ��  �                         �   �  ��  ��  ��  ��  ��     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���           �:�   ��2�`  ��2�h  ���,f� xx�,h����p*� xx�PQ����*��xxp
���x��� hf�x�x  �l#x��  �#x��   �x�          �  �  �  �  �                          �  �  �  �  �     lt  ~          h     (                @                        �  �   �� �   � � ��  ��� ��� �ʦ ��� ��� ��� k�� H�� %��  ��  ��  z�  b�  Js  2P ��� ��� ��� k�� Hs� %W�  U�  I�  =�  1�  %s  P ��� ��� ��� kk� HH� %%�   �   �   �   �   s   P ��� Ǳ� ��� �k� sH� W%� U � I � = � 1 � % s  P ��� �� Ԏ� �k� �H� �%� � � � � z � b � J s 2 P ��� ��� ��� �k� �H� �%� � � � � � � � � s s P P ��� ��� ��� �k� �H� �%� � � � � � z � b s J P 2 ��� ��� ��� �k� �Hs �%W � U � I � = � 1 s % P  ��� ��� ��� �kk �HH �%% �   �   �   �   s   P   ��� �Ǳ ��� ��k �sH �W% �U  �I  �=  �1  s%  P  ��� �� �Ԏ ��k ��H ��% ��  ܒ  �z  �b  sJ  P2  ��� ��� ��� ��k ��H ��% ��  ��  ��  ��  ss  PP  ��� ��� ��� ��k ��H ��% ��  ��  z�  b�  Js  2P  ��� ��� ��� ��k s�H W�% U�  I�  =�  1�  %s  P  ��� ��� ��� k�k H�H %�%  �   �   �   �   s   P  ��� ��� ��� k�� H�s %�W  �U  �I  �=  �1  s%  P ��� ��� ��� k�� H�� %��  ��  ܒ  �z  �b  sJ  P2 ��� ��� ��� k�� H�� %��  ��  ��  ��  ��  ss  PP ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� zzz nnn bbb VVV JJJ >>> 222 &&&   ��� ��� ���   �  �   �� �   � � ��  ���                    ����������      ��   � �      ��������      �� �   �      ��������      ��   � �      ��������      �� �   �      ��������      ��   � �      ��������      ��  �         ����� ��      ������� �                    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� �       �f����f`~o��wwn`v�   wv`����ww`����ww������w����w���� ������;0w`v��s�`vg��;0n`~f��s`vfgww;0p     q       x                                                         ��  ��     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���         wwwwp �Gwww�0 ��wwxxp G�8�  �        �wwww� xffffp�vffflt�x��ftxx�~�ft�xw~vftwx�w�l�wx�  twwwwwwt DDDDDD@�   �   �   �   �  �   �   �   �   �   �   �   �   �   �   �  	   lt  >     ; CdFl               0�     Ђ � @z �� � ��ࡱ�                >  ��                        ����    ����        ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������� #$,����j ��(6(!C4       �~��   �     ��� ��  �ͫ    �   ����  �    
      C l s d F o l d    F l o p p y    H D d r i v e    N k D r i v e    C D R O M    F i l e I c o n    D e s k t o p 
   M y C o m p u t e r 	   M y N e t w o r k    M y D o c u m e n t s 
      lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���                         wwwwwww ������ ������ ������ ������ ������ ������ ������ ������ x���www ���     wwp            ��  ��  �                                ��  ��  ��     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���         wwwwwww x������pxwp w�px��wx��px������p������p������p www����    �  �    �  �    ����    ����    ����    ����    ���̀                         �   �   �   �   �   �   �   �   �      lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���                         wwwwwww x������pxwwwww�px������px������p������p������p wwwwwwp                                        ��  ��  �                         �   �  ��  ��  ��  ��  ��     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���                         wwwwwww x������pxwwwww�px������px������p������p������p wwwwwwp                                        ��  ��  �                         �   �  ��  ��  ��  ��  ��     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���           �:�   ��2�`  ��2�h  ���,f� xx�,h����p*� xx�PQ����*��xxp
���x��� hf�x�x  �l#x��  �#x��   �x�          �  �  �  �  �                          �  �  �  �  �     lt  ~          h     (                @                        �  �   �� �   � � ��  ��� ��� �ʦ ��� ��� ��� k�� H�� %��  ��  ��  z�  b�  Js  2P ��� ��� ��� k�� Hs� %W�  U�  I�  =�  1�  %s  P ��� ��� ��� kk� HH� %%�   �   �   �   �   s   P ��� Ǳ� ��� �k� sH� W%� U � I � = � 1 � % s  P ��� �� Ԏ� �k� �H� �%� � � � � z � b � J s 2 P ��� ��� ��� �k� �H� �%� � � � � � � � � s s P P ��� ��� ��� �k� �H� �%� � � � � � z � b s J P 2 ��� ��� ��� �k� �Hs �%W � U � I � = � 1 s % P  ��� ��� ��� �kk �HH �%% �   �   �   �   s   P   ��� �Ǳ ��� ��k �sH �W% �U  �I  �=  �1  s%  P  ��� �� �Ԏ ��k ��H ��% ��  ܒ  �z  �b  sJ  P2  ��� ��� ��� ��k ��H ��% ��  ��  ��  ��  ss  PP  ��� ��� ��� ��k ��H ��% ��  ��  z�  b�  Js  2P  ��� ��� ��� ��k s�H W�% U�  I�  =�  1�  %s  P  ��� ��� ��� k�k H�H %�%  �   �   �   �   s   P  ��� ��� ��� k�� H�s %�W  �U  �I  �=  �1  s%  P ��� ��� ��� k�� H�� %��  ��  ܒ  �z  �b  sJ  P2 ��� ��� ��� k�� H�� %��  ��  ��  ��  ��  ss  PP ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� zzz nnn bbb VVV JJJ >>> 222 &&&   ��� ��� ���   �  �   �� �   � � ��  ���                    ����������      ��   � �      ��������      �� �   �      ��������      ��   � �      ��������      �� �   �      ��������      ��   � �      ��������      ��  �         ����� ��      ������� �                    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� �       �f����f`~o��wwn`v�   wv`����ww`����ww������w����w���� ������;0w`v��s�`vg��;0n`~f��s`vfgww;0p     q       x                                                         ��  ��     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���         wwwwp �Gwww�0 ��wwxxp G�8�  �        �wwww� xffffp�vffflt�x��ftxx�~�ft�xw~vftwx�w�l�wx�  twwwwwwt DDDDDD@�   �   �   �   �  �   �   �   �   �   �   �   �   �   �   �  	   lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���  DDDD@  �����@  �w�@  �    ~~p ��p   �����  ��~v�   ��w��DDD������������p��x���  ���G�H*"�G~H��"��H "�"(wwx  ��    �             �9   3   7                      �   �   �   ��  
   lt  ~          h     (                @                        �  �   �� �   � � ��  ��� ��� �ʦ ��� ��� ��� k�� H�� %��  ��  ��  z�  b�  Js  2P ��� ��� ��� k�� Hs� %W�  U�  I�  =�  1�  %s  P ��� ��� ��� kk� HH� %%�   �   �   �   �        #J���    1#  1#                        �*   %   P      x"  G  �          �  U  / ��  � � � � � �� ������� T� � ��  �� T� � �	 �� Desktop�� T�  �� �� �� �� �(����� T� �C� �A � :�� T� �C� ���� %�� �� � �	��� T�  ��  ��� � ��  ����� T� ��  ������ �� T� ��  ������ �� � �� ��� �
 ��� T�� �a�� ��C�� � �� �� ���(��  ��� ��C�� � �� ��C � ��� ���� T�� ��  C � �� �� T�� �C � �� �� �� � � �� �����$ T� � �� �����C � �� �� T� � �� ������ D�� �� T�� �-�� �� ��C� � �� U  LNNUMDRIVES	 LNDRIVEID LNDRIVETYPE LCDRIVE LNROW LCDRIVELIST THISFORM CURRENTDIRECTORY LBLCURRENTFOLDER CAPTION GRDCURRENTDIRECTORYLIST	 LOCKSTATE ROWS	 REMOVEALL ADD LISTITEM TEXT PICTUREINDEX FILELIST SETLOOKINCOMBO�  ��  � �� � � T� �� �� %�C�  �
��� �& %�CCC�  ��@� exe� dll� ico���l � T� �� _CC�  ��@�� �� � T� �� _CC�  ��@�� �' T� �C �   � � � a���� � � �� �	 B�� �� U  TCFILE LNINDEX LCIMGKEY THISFORM
 OICONBUDDY EXTRACT2IMAGELIST THIS	 OLEIMAGES& ��  � �+ �� � � � � � � �	 �
 � � �� � � � �1 �� ���� ���� ���� ������� ��� ��� T�� ��  �� T�� �� �� T�� � �� �� ���� ��� � T�� �a�� ��C�� �� �� ���� ��� ��C�� �� T�� �� �� ��' T� �C�� C�� ��� *.*� D����' T� �C�� C�� ��� *.*� D���� H�c��� ��  � DESKTOP���� ���� ��7�( T� �C� � DeskTop� � �� �� ��. T� �C � � My Documents� � �
��� ��% T� �C � � �  � �  ���� �� ��	 �� �(������ T�
 �C�	 �A � :�� T� �C�
 ���� %�� ����� T� �C �
  � � �! ��" T� �C �  �  �
  � ��� �� � �� �� ���(�� ���3 %�C � �� � .� C� DC � �� �� 	���9 T� �C � C � �� C� � ��C � �� ���� �� � �� T��" ����# �a�� �� ���� ����. T� �C� �
� My Documents� � � D�� ��& T� �C � �� �  � �  � D�� �� �� ���(�� ��%�3 %�C � �� � .� C� DC � �� �� 	��!�: T� �C � �C � �� C� � ��C � �� � D�� �� � �� �� ���(�� ����: %�C� DC � �� �� � CCC � �� ��f� �$ 	���� T�% �C� � ��C � �� �� T�& �C �% � �' �� H���n� ��& ��( � �& �e	���+ ���) ��& ��* ����C �& � �+ �, �- �� T��( ��& �� ��& ��( � �& �e	��;� T�& ���� ��& � ��Y� T�& ���� 2�n� T�& ��& �� �* T� �C �  �& C � ��  �% � F�� �� %�CC � �� f� �. ���� T� �/ �0 ��% �� � � �� �� ��  � MY DOCUMENTS��
� ���� ����( T� �C� � DeskTop� � �� �� ��. T� �C � � My Documents� � �
��� ��% T� �C � � �  � �  ���� �� ��	 �� �(����� T�
 �C�	 �A � :�� T� �C�
 ���� %�� ���� T� �C �
  � � �! ��" T� �C �  �  �
  � ��� �� � �� �� ���(�� ����3 %�C � �� � .� C� DC � �� �� 	����9 T� �C � C � �� C� � ��C � �� ���� �� � �� T��" ����# �a�� �� ���� ��
� T� �� �� �� ���(�� ��]�3 %�C � �� � .� C� DC � �� �� 	��Y�: T� �C � �C � �� C� � ��C � �� � D�� �� � �� �� ���(�� ��
�: %�C� DC � �� �� � CCC � �� ��f� �$ 	��	
� T�% �C� � ��C � �� �� T�& �C �% � �' �� H����	� ��& ��( � �& �e	��I	�+ ���) ��& ��* ����C �& � �+ �, �- �� T��( ��& �� ��& ��( � �& �e	��s	� T�& ���� ��& � ���	� T�& ���� 2��	� T�& ��& �� �* T� �C �  �& C � ��  �% � F�� �� %�CC � �� f� �. ��
� T� �/ �0 ��% �� � � �� �� ��  C��  f���� ���� ����( T� �C� � DeskTop� � �� �� ��. T� �C � � My Documents� � �
��� ��% T� �C � � �  � �  ���� �� ��	 �� �(����A� T�
 �C�	 �A � :�� T� �C�
 ���� %�� ���=� T� �C �
  � � �! ��" T� �C �  �  �
  � ��� �� � �� �� ���(�� ����3 %�C � �� � .� C� DC � �� �� 	����9 T� �C � C � �� C� � ��C � �� ���� �� � �� T��" ����# �a�� �� ���� ���� T� �� �� ��	 �� �(������ T�
 �C�	 �A � :�� T� �C�
 ���� %�� ����� T� �C �
  � � �! ��# T� �C �  �  �  �
 � D�� �� � �� ��# ��  � SELECTED DIRECTORY���� T�1 ���� ���� ��[�( T� �C� � DeskTop� � �� �� ��. T� �C � � My Documents� � �
��� ��% T� �C � � �  � �  ���� �� ��	 �� �(������ T�
 �C�	 �A � :�� T� �C�
 ���� %�� ����� T� �C �
  � � �! ��" T� �C �  �  �
  � ��� �� %�C� �� \���
 ���� T� ���� T� �C� � \���� T�2 ��
 �� �� ���(�� ���� T� �� ��� T� �C� � � \���� T�2 �C�2 ��� ��" T� �C �  �  �2 � � �� �� �� T�1 �� �� � � �� �� ���(�� ��B�3 %�C � �� � .� C� DC � �� �� 	��>�9 T� �C � C � �� C� � ��C � �� ���� �� � �� T��" ��1 ��# �a�� �� T� �C� ����# T� �C�� � � *.*� D���� ���� ���� T� �� �� �� ���(�� ��/�3 %�C � �� � .� C� DC � �� �� 	��+�4 T� �C � �C � �� � C � �� � D�� �� � �� �� ���(�� ����: %�C� DC � �� �� � CCC � �� ��f� �$ 	���� T�% �C� ��C � �� �� T�& �C �% � �' �� H���u� ��& ��( � �& �e	���+ ���) ��& ��* ����C �& � �+ �, �- �� T��( ��& �� ��& ��( � �& �e	��B� T�& ���� ��& � ��`� T�& ���� 2�u� T�& ��& �� �* T� �C �  �& C � ��  �% � F�� �� %�CC � �� f� �. ���� T� �/ �0 ��% �� � � �� �� � ��C�� �3 �� ���� ��� T�� �-�� ��C��4 �� �� �� U5  TCMODE TCSELDIRECTORY LNNUMFOLDERS LNROW LNNDX	 LNNUMPATH LNPATH LCPATH LNINDENT	 LNDRIVEID LCDRIVE LCDRIVENAME LNICON LNNUMDESKFLDRS LNNUMMYDOCFLDRS LCDIRECTORYLIST LCDESKTOPLIST LCMYDOCLIST LCDRIVELIST THISFORM LASTMODE CURRENTDIRECTORY LBLCURRENTFOLDER CAPTION GRDCURRENTDIRECTORYLIST	 LOCKSTATE	 REMOVEALL CBOFOLDERLIST FOLDERLISTKEY DESKTOPPATH	 MYDOCPATH ADDLISTITEM COMPUTERNAME GETVOLUMENAME
 COMBOITEMS SELECTED FILEEXT
 LCFULLNAME LNIMAGEINDEX GETASSOCICON PICTURECOUNT PICTURES LOAD	 OLEIMAGES
 LISTIMAGES PICTURE FILETOLOCATE TXTFILENAME TAG LNSELROW
 LCFULLPATH REFRESH SETFOCUS� ��  � � �� � � � � � � �� �	 � T�  �C�  ���� T� �C� X�� T� �� �� T� �� �� T� �� �� T� �� �� T� �C� X�� T� �� ��. T�	 �C�  �  � � � � �  � �
 �� T� �C� �  C�  ��� %�C� ����� H���� �� ���0� T� �� Floppy Disk�� �� ���X� T� ��
 Local Disk�� �� ����� T� �� Removable Disk�� �� ����� T� �� CD-ROM�� � � T� �� �  (�  � )��	 B�� �� U  TCDRIVE TNTYPE LCVOLUMENAME LNVOLUMENAMESIZE LNVOLUMESERIAL LNMAXCOMPLENGTH LNFILESYSFLAG LCFILESYSNAMEBUF LNFILESYSNAMESIZE LNRETURN GETVOLUMEINFORMATION  T�  � ���� U  THISFORM
 OICONBUDDY  B��  � �� U  THISFORM RTNVALUE	  G] � U  p ��  � �� � � � � � T� ��d�� T� �C� X�� ��C� � � �� ��� ��i� T�� �C�  f�� T��	 �CC�  ��f�� T��
 �C� �  C�  ���\ T�� �C�@ SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders� Desktop� ��] T�� �C�@ SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders� Personal� ��- T�� �C�	 iconbuddy� gkticonbuddy.vcx���� T�� � ��  �� H���N� �C�9� � fC�� f���� T� �� DESKTOP�� �C�9� � fC�� f���� T� �� MY DOCUMENTS�� �C�9� � fC��
 f��'� T� �C��
 f�� 2�N� T� �� SELECTED DIRECTORY�� � ��C � �9� � �� �� �� U 
 TCFILENAME LNNDX	 LCCURPATH LCMODE LNSIZE LCBUFFER GETCOMPUTERNAME THISFORM FILETOLOCATE FILEEXT COMPUTERNAME DESKTOPPATH GKTGETREGSTRING_HKCU	 MYDOCPATH
 OICONBUDDY TXTFILENAME VALUE GKKTOOLS LASTDIRECTORY GETDIRECTORY getdrivelist,     �� getassociconJ    �� getdirectoryi    �� getvolumename    �� Destroy�    �� Unload�    �� Activate�    �� Init�    ��1 q1�� q��1��A A � � q� a�aA aA�A � A � 2 q � � aq� qA qA � 2 � �1� � � � � � A � � � A qq� �� ��Qq��!A A q1�A A QA � �ar1�A A r��Q� ��� �� � � � A ��1A A A A �� ��Qq��!A A q1�A A QA � � q1�A A r��Q� ��� �� � � � A ��1A A A A B� ��Qq��!A A q1�A A QA � � q��1A A A 2� � ��Qq��!�� A� qqA!A � A A A q1�A A QA 1� � q1AA A r��Q� ��� �� � � � A ��1A A A A A � � � � A A 2 � �� � � � � � ��� � �q�1A A �� 2 � 2 � 2 a 2 q q� � !� 1����� �A���� �A qA 1                       %     !   H  �  "   .   �  �,  0     �,  "1    '  @1  \1  5  )  y1  �1  8  +  �1  �1  ;  -  �1  6  >   )   1#                        ..\classes\gktbaseclasses.vcx          �     (       @         �                        �  �   �� �   � � ��  ��� ��� �ʦ ��� ��� ��� k�� H�� %��  ��  ��  z�  b�  Js  2P ��� ��� ��� k�� Hs� %W�  U�  I�  =�  1�  %s  P ��� ��� ��� kk� HH� %%�   �   �   �   �   s   P ��� Ǳ� ��� �k� sH� W%� U � I � = � 1 � % s  P ��� �� Ԏ� �k� �H� �%� � � � � z � b � J s 2 P ��� ��� ��� �k� �H� �%� � � � � � � � � s s P P ��� ��� ��� �k� �H� �%� � � � � � z � b s J P 2 ��� ��� ��� �k� �Hs �%W � U � I � = � 1 s % P  ��� ��� ��� �kk �HH �%% �   �   �   �   s   P   ��� �Ǳ ��� ��k �sH �W% �U  �I  �=  �1  s%  P  ��� �� �Ԏ ��k ��H ��% ��  ܒ  �z  �b  sJ  P2  ��� ��� ��� ��k ��H ��% ��  ��  ��  ��  ss  PP  ��� ��� ��� ��k ��H ��% ��  ��  z�  b�  Js  2P  ��� ��� ��� ��k s�H W�% U�  I�  =�  1�  %s  P  ��� ��� ��� k�k H�H %�%  �   �   �   �   s   P  ��� ��� ��� k�� H�s %�W  �U  �I  �=  �1  s%  P ��� ��� ��� k�� H�� %��  ��  ܒ  �z  �b  sJ  P2 ��� ��� ��� k�� H�� %��  ��  ��  ��  ��  ss  PP ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� zzz nnn bbb VVV JJJ >>> 222 &&&   ��� ��� ���   �  �   �� �   � � ��  ��� �����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������    � �  ����  �  ����  �������       �  ���   �  ���   ������   ���  �  ��   ��  ��   �������  ����  �  �   ���  �   ��������  ��    �     ����     ���������  ��    �     ����     ���������  �������  �   ���  �   ��������   ���� �  ��   ��  ��   ��������       �  ���   �  ���   ��������     ��  ����  �  ����  �����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������                                                                                                                                0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _0V80NJ85G1058580022�      �&  �      �&      �  H  @  
  �  �  �          t      T       COMMENT RESERVED                        B                                                                  .h                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      "  ..\programs\gktdefines.h��|0?      
bblistview      ..\programs\gktdefines.h      Pixels      Class      1      
olecontrol      
bblistview     Fsortorder Order to be sorted Ascending=1, Descending=-1
sortcolumn Column the order is sorted on
_memberdata XML Metadata for customizable properties
picturecount Count of pictures initialized
colorgridrows Colors the grid rows with alternating colors
lastrowselected Last selected row
afterrowchangeok Flag to allow AfterRowChange event to process
defaultbackcolor Default row backcolor setting - initialized in Init()
defaultforecolor Default row forecolor setting - initialized in Init()
firstrowselected First selected row in multi-valued selection
lastkeykeyascii Last key entered Ascii value
^itemlist[1,0] Item reference list
*addlistitem Adds item to list display
*setcelltext Sets the cell text
*savecolumnwidths Saves the column widths
*restorecolumnwidths Rstores the column widths
*removeall Removes all rows
      .OLEObject = C:\WINDOWS\system32\BBLIST~1.OCX
     
 ��ࡱ�                >  ��	                               ����        ��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������R o o t   E n t r y                                               ��������                               �x+��b�           O l e O b j e c t D a t a                                            ����                                        H        A c c e s s O b j S i t e D a t a                             &  ������������                                       8        C h a n g e d P r o p s                                         ������������                                                 ����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������#.�����  �{N�  �  �
                              8                              8                       5 4 9 E   �- 3 8 9 4 - 1 1 D 2 - B B 7 F - 0 0 A 0 C 9 9 9 C 4 C 1 }      ...I N N T \ S y s t e m 3 2 \ L M R T . d l l   L M   R u n t i m e   C o n t r o l 	 { 1 8 3 C 2 5 9 A - 0 4 8 0 - 1 1 d 1 - 8 7 E A - 0 0 C 0 4 F C 2 9 D 4 6 }   C : \ W I N N T \ S y s t e m 3 2 \ L M R T . d l l   M i c r o s o f t   M u l t i m e d i a   C o n t r o l ,   v e r s i o n   6 . 0 	 { C 1 A 8 A      ����    j  j                        �Q   %   c	      �
  _   
          �  U  �7 ��  � � � � � � � � �	 �
 � � � �� � � %�C������ ��� ���� ��C�� � �� �� ���(�C����0� T� �� cItemC� _��! IF VARTYPE(&lcText) = "C"�� �1 .ListItem(nRow,lnCol).Text = ALLTRIM(&lcText)
 �,�3 .ListItem(nRow,lnCol).Text = TRANSFORM(&lcText)
 � �� %��� ���� %�C�  �G� ���� �� ���(��� � ����  T�� ��  ��� �� ����� �� �� ��� �� ���(��� � ����  T�� ��  ��� �� ����� �� �� � � �� � U  NROW CITEM1 CITEM2 CITEM3 CITEM4 CITEM5 CITEM6 CITEM7 CITEM8 CITEM9 CITEM10 CITEM11 CITEM12 LNCOL LCTEXT THIS ROWS ADD COLORGRIDROWS COLUMNS COUNT LISTITEM	 BACKCOLOR3  ��  � � �! T� � �� ��� �� �C�  ��� U  CITEM NROW NCOL THIS LISTITEM TEXT�  ��  � � ��� ��� � T� ��  �� ��  ���(��� � ��� � T� �� CC �  �� � _�� %��  �� � ��� � T� �� � ;�� � ��* ��C� Form� � � GridColumns � � �� �� U	  LNCOL LCCOLUMNSIZES THIS COLUMNS COUNT WIDTH GKTSETSTRING_VFP THISFORM NAME�  ��  � �* T�  �C� Form� � � GridColumns� �� %�C�  �
��� � ��� ��� � �� ���(��� � ��� �% T�� �� �� �CCC�  � � ;��g8�� �� �� � U	  LCCOLUMNSIZES LNCOL GKTGETSTRING_VFP THISFORM NAME THIS COLUMNS COUNT WIDTH9  ��C�  � � �� �  � ���� T�  � �����  �� U  THIS ROWS	 REMOVEALL ITEMLIST; ��  � � � � � �� � � %��  � ��4� ��� ��0� T�� �a�� T��	 ��  ��. %�C �  ��
 � �� C �  ��
 � �	��� � T�� ������ �� � T�� ���� � �� ���(��� � ��� � T��
 �� �� ���� T��
 �� �� ���� �� T��
 ��  �� ����* T��
 ��  �� �C�� �� �� �6�� ��C�� ��	 �� �� %��� �� � �� ���(��� � ��� %�C� �G� ���� �� ���(��� � ����  T�� �� ��� �� ����� �� �� �� �� ���(��� � ���  T�� �� ��� �� ����� �� �� � �� � T�� �-�� �� � U  NCOLUMNINDEX BONTEXT
 BONPICTURE NXCOORD NYCOORD LNNDX LNROW THIS	 LOCKSTATE
 SORTCOLUMN COLUMNHEADERS CONTENTTYPE PICTUREINDEX	 SORTORDER COLUMNS COUNT SORTLISTITEMS COLORGRIDROWS ROWS LNCOL LISTITEM	 BACKCOLOR=  T�  � �C��  � � � �� T�  � �C��  � � � �� U  THIS DEFAULTBACKCOLOR COLUMNS DEFAULTS	 BACKCOLOR DEFAULTFORECOLOR	 FORECOLOR addlistitem,     �� setcelltext�    �� savecolumnwidths>    �� restorecolumnwidthsS    ��	 removeallM    �� OnHeaderLDoubleClick�    �� Init�    ��1 q� � � ��� 1A A � a�A � �A A A A A 2 � 2 � � � ��Q!A A �A 2 � �� �QA A A 2 a2 q� � � � �� � � A �qqA q�A� �a�A � �A A A A � A A 2 ��1                       �        �  5        \  �  !   +   �  �  .   5   �  ?  9   9   j  /
  >   \   J
  �
  b    )   j                       
�PROCEDURE addlistitem
LPARAMETERS nRow,cItem1,cItem2,cItem3,cItem4,cItem5,cItem6,cItem7,cItem8,cItem9,cItem10,cItem11,cItem12
LOCAL lnCol, lcText
IF PARAMETERS() > 1
	WITH this
		.Rows.Add()
		FOR lnCol=1 TO PARAMETERS()-1
			lcText = "cItem" + TRANSFORM(lnCol)
			IF VARTYPE(&lcText) = "C"
				.ListItem(nRow,lnCol).Text = ALLTRIM(&lcText)
			ELSE
				.ListItem(nRow,lnCol).Text = TRANSFORM(&lcText)
			ENDIF
		ENDFOR
		IF .ColorGridRows
			IF MOD(nRow,2) = 0
				FOR lnCol=1 TO .Columns.Count
					.ListItem(nRow,lnCol).BackColor = 16777215
				ENDFOR
			ELSE
				FOR lnCol=1 TO .Columns.Count
					.ListItem(nRow,lnCol).BackColor = 14286809
				ENDFOR
			ENDIF
		ENDIF
	ENDWITH
ENDIF
ENDPROC
PROCEDURE setcelltext
LPARAMETERS cItem,nRow,nCol
this.ListItem(nRow,nCol).Text = ALLTRIM(cItem)
ENDPROC
PROCEDURE savecolumnwidths
LOCAL lnCol, lcColumnSizes
WITH this
	lcColumnSizes = ""
	FOR lnCol=1 TO .Columns.Count
		lcColumnSizes = lcColumnSizes + TRANSFORM(.Columns(lnCol).Width)
		IF lnCol != .Columns.Count
			lcColumnSizes = lcColumnSizes + ";"
		ENDIF
	ENDFOR
	=GKTSetString_VFP("Form",thisform.Name+"GridColumns",lcColumnSizes)
ENDWITH
ENDPROC
PROCEDURE restorecolumnwidths
LOCAL lcColumnSizes, lnCol
lcColumnSizes = GKTGetString_VFP("Form",thisform.Name+"GridColumns")
IF !EMPTY(lcColumnSizes)
	WITH this
		FOR lnCol=1 TO .Columns.Count
			.Columns(lnCol).Width = INT(VAL(GETWORDNUM(lcColumnSizes,lnCol,";")))
		ENDFOR
	ENDWITH
ENDIF
ENDPROC
PROCEDURE removeall
this.Rows.RemoveAll()
DIMENSION this.ItemList[1]
this.ItemList[1] = ""
ENDPROC
PROCEDURE OnHeaderLDoubleClick
LPARAMETERS ncolumnindex, bontext, bonpicture, nxcoord, nycoord
LOCAL lnNdx, lnRow
IF nColumnIndex > 0
	WITH this
		.LockState = .T.
		.SortColumn = nColumnIndex
		IF .ColumnHeaders(nColumnIndex).ContentType=3 .AND. .ColumnHeaders(nColumnIndex).PictureIndex=1
			.SortOrder = -1
		ELSE
			.SortOrder = 1
		ENDIF
		FOR lnNdx=1 TO .Columns.count
			.ColumnHeaders(lnNdx).ContentType  = 1
			.ColumnHeaders(lnNdx).PictureIndex = 1
		ENDFOR
		.ColumnHeaders(nColumnIndex).ContentType = 3 
		.ColumnHeaders(nColumnIndex).PictureIndex = IIF(.SortOrder=1,1,2)
		.SortListItems(.SortOrder*.SortColumn)
		IF .ColorGridRows
			FOR lnRow=1 TO .Rows.count
				IF MOD(lnRow,2) = 0
					FOR lnCol=1 TO .Columns.Count
						.ListItem(lnRow,lnCol).BackColor = 16777215
					ENDFOR
				ELSE
					FOR lnCol=1 TO .Columns.Count
						.ListItem(lnRow,lnCol).BackColor = 14286809
					ENDFOR
				ENDIF
			ENDFOR
		ENDIF
		.LockState = .F.
	ENDWITH
ENDIF
ENDPROC
PROCEDURE Init
this.DefaultBackColor = this.Columns(1).Defaults.BackColor
this.DefaultForeColor = this.Columns(1).Defaults.ForeColor
ENDPROC
      
olecontrol     �Height = 106
Width = 277
sortorder = 1
sortcolumn = 1
_memberdata =     1169<VFPData><memberdata name="addlistitem" type="method" display="AddListItem"/><memberdata name="setcelltext" type="method" display="SetCellText"/><memberdata name="itemlist" type="property" display="ItemList"/><memberdata name="sortcolumn" type="property" display="SortColumn"/><memberdata name="sortorder" type="property" display="SortOrder"/><memberdata name="picturecount" type="property" display="PictureCount"/><memberdata name="colorgridrows" type="property" display="ColorGridRows"/><memberdata name="lastrowselected" type="property" display="LastRowSelected"/><memberdata name="afterrowchangeok" type="property" display="AfterRowChangeOK"/><memberdata name="restorecolumnwidths" type="method" display="RestoreColumnWidths"/><memberdata name="savecolumnwidths" type="method" display="SaveColumnWidths"/><memberdata name="removeall" type="method" display="RemoveAll"/><memberdata name="defaultbackcolor" type="property" display="DefaultBackColor"/><memberdata name="defaultforecolor" type="property" display="DefaultForeColor"/><memberdata name="firstrowselected" display="FirstRowSelected"/><memberdata name="lastkeykeyascii" display="LastKeyKeyAscii"/></VFPData>
picturecount = 0
colorgridrows = .T.
lastrowselected = 0
afterrowchangeok = .T.
defaultbackcolor = 0
defaultforecolor = 0
firstrowselected = 0
lastkeykeyascii = 0
Name = "bblistview"
0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _0TN0VOIFQ1058580068�      V  �      d  s  �  S�          �  �  �          �      S       COMMENT RESERVED                        B                                                                  ��                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      "  ..\programs\gktdefines.h��|0?      	iconbuddy      ..\programs\gktdefines.h      
addicons
      Pixels      Class      1      custom      	iconbuddy     �cassocfile The associated Executable that we get from .GetAssocFile()
niconcount How many Icons ar in a specific file?
cfiletype The filetype of a file for that an icon has been retrieved using .ShellGetFileInfo() or GetAssocIconPairObjects()
cversion IconBuddy's version-number
*iconhandle2object Create an Icon-Object from a provided IconHandle
*dword Convert LONG Type into DWORD
*long2string convert LONG to STRING (same function as  ==> .DWORD)
*getassociconhandle Get an IconHandle for a given associated File
*getassociconobject Get the associated PictureObject from a file like Test.xls
*destroyicon Destroy a given IconHandle when not needed anymore
*declaredlls Declare the DLL's needed for the job
*releasedlls Release The DLLS I have declared in the init
*getassocexecutable Return the associated Executable FileName for a given Extension or File
*geticonpairobjects Retrieves the Large and Small Icon Pair as Objects and adds this to the aIcons[] array.
*cleariconarray GarbageCollects the aIcons[] array to avoid dangling references to IconObjects. This is done automatically upon destroy but You can call it anytime when You need a "fresh" array container
*geticoncount Return the Number of Icons in a DLL or EXE.
^aicons[1,2] This array holds the IconObjects You get using GetIconPairObjects() or GetAllIcons()
*geticonpairhandle Retrieves the Icon Handles for a specific large and small Icon in an Executable or DLL
*getallicons Retrieve all Icons as Pairs (Large/Small) from an EXE or DLL and store them as Objects in the aIcons[] array.
*addicons Add Icons retrieved by GetAllIcons() to the aIcons[] Array
*shellgetfileinfo Retrieve a handle to a large or small Icon to from a file or the associated executable using SHGetFileInfo()
*string2long Convert a string var to a long
*getassociconpairobjects Returns the Object-Handles to an associated IconPair (large, small) 
*imglistindex Return the index of a given key in a ImageList
*extract2imagelist Directly extract an Icon from a file and add it to an imageListControl
*add2imagelist Add an image to an ImageList and return its index
*gethwnd Get the HWND necessary for GetAssocIcon
      custom      nHeight = 21
Width = 30
cassocfile = 
niconcount = 0
cfiletype = 
cversion = ("1.3")
Name = "iconbuddy"
     �qPROCEDURE iconhandle2object
*=========================================================
*
*         PROCEDURE: .ICONHANDLE2OBJECT             
*
*=========================================================
*
*  Created...........:  29.November 2002, 15:00 Uhr
*  Changed...........:   
*  Description.......:  Return an Object-Reference for a given Icon-Handle
*  Calling Samples...:  IconHandle2Object(<ExpI>[,<ExpL>])
*  Parameters........:  thIconHandle, tlKeepHandle
*  Returns...........:  Object
*  Additional Info...:  The logic is part of a message #656045 from the UT
*	
*						Normally after creating the ObjectReference
*						I can properly destroy the IconHandle.
*						However if I need it for further action 
*						I can pass tlKeepHandle = .T. and thus return
*						responsibility for that job to te calling method
*
lparameters thIconHandle, tlKeepHandle
thIconHandle = iif(vartype(thIconHandle) $ "IN", thIconHandle, 0)
LOCAL toRetVal, PictDesc, IPic, iid

#define PICTYPE_ICON 3
*-- #define IID_IDispatch Chr(0x00)+Chr(0x04)+Chr(0x02)+Chr(0x00)+ ;
*-- 		Replicate(Chr(0x00), 4)+Chr(0xC0)+Replicate(Chr(0x00), 6)+Chr(0x46)

*-- declare LONG IIDFromString in OLE32 STRING lpsz, STRING @ lpIID
*-- lcGUID 		= "{7BF80981-BF32-101A-8BBB-00AA00300CAB}"
*-- lnSuccess   = IIDFromString( StrConv(StrConv(lcGUID, 1), 5), @lcGUID)

toRetVal = .NULL.

*=========================================================*
*  Create Picture object according to PICTDESC structure  *
*=========================================================*
*-- PictDesc = This.DWord(16) ;				&& Size of PICTDESC structure
*-- 		 + This.DWord(PICTYPE_ICON) ;	&& Type of picture
*-- 		 + This.DWord(thIconHandle) ;	&& IconHandle
*-- 		 + This.DWord(0)				&& HPALETTE

PictDesc = This.Long2String(16) ;			&& Size of PICTDESC structure
		 + This.Long2String(PICTYPE_ICON) ;	&& Type of picture
		 + This.Long2String(thIconHandle) ;	&& IconHandle
		 + This.Long2String(0)				&& HPALETTE


IPic = 0
*iid  = IID_IDispatch
iid  = repl(chr(0),8)+chr(0xC0)+ repl(chr(0), 6) + chr(0x46)
OleCreatePictureIndirect(@PictDesc, @iid, 1, @IPic)

if vartype(IPic)="O" and ! isNull(IPic)
	toRetVal = IPic
endif	

if tlKeepHandle
	*-- Nothing to do here, the calling
	*-- method will have to destroy the
	*-- IconHandle
else
	This.DestroyIcon(thIconHandle)	
endif	

return toRetVal
*-- eof .ICONHANDLE2OBJECT

ENDPROC
PROCEDURE dword
*=========================================================
*
*         PROCEDURE: .DWORD             
*
*=========================================================
*
*  Created...........:  29.November 2002, 17:09 Uhr
*  Changed...........:   
*  Description.......:  Convert a LONG to a DWord 
*  Calling Samples...:  ? DWORD(<ExpI>)
*  Parameters........:  tnLongVal
*  Returns...........:  Character
*
lparameters tnLongVal
tnLongVal = iif(vartype(tnLongVal) = "N", tnLongVal, 0)

return This.Long2String(tnLongVal)
*-- eof .DWORD

ENDPROC
PROCEDURE long2string
*=========================================================
*
*         PROCEDURE: .LONG2STRING             
*
*=========================================================
*
*  Created...........:  29.November 2002, 14:55 Uhr
*  Changed...........:   
*  Description.......:  Convert a LONG value to a STRING or DWORD-Value
*  Calling Samples...:  ? Long2String(<ExpI>)
*  Parameters........:  tnLongValue
*  Returns...........:  Character
*  Additional Info...:	We need four loops as a LONG is 
*						has a length of four bytes
*
lparameters tnLongValue
LOCAL lnLoop, lcRetVal

tnLongValue = iif(vartype(tnLongValue) = "N", tnLongValue, 0)

lcRetVal 	= ""


*===================================*
*  We need four loops as a LONG is  *
*  has a length of four bytes       *
*===================================*
FOR lnLoop 		= 24 TO 0 STEP -8	&& Long ist vier bytes lang
	lcRetVal 	= CHR(INT(tnLongValue/(2^lnLoop))) + lcRetVal
	tnLongValue = MOD(tnLongValue, (2^lnLoop))
NEXT

return lcRetVal
*-- eof .LONG2STRING

ENDPROC
PROCEDURE getassociconhandle
*=========================================================
*
*         PROCEDURE: .GETASSOCICONHANDLE             
*
*=========================================================
*
*  Created...........:  29.November 2002, 17:14 Uhr
*  Changed...........:   
*  Description.......:  Get a handle to the Icon that is associated with a given file
*  Calling Samples...:  ? o.GetAssocIconHandle(<ExpC>)
*  Parameters........:  tcFile
*  Returns...........:  Integer (Handle)
*
*  Additional Info...:  Be sure to destroy the Handle when
*						not needed anymore Using .DestroyIcon()
*
lparameters tcFile
LOCAL lnIconIndex, lnRetVal, lcFile, hwnd

tcFile 		= iif(vartype(tcFile) = "C", tcFile, This.cAssocFile)

*-- DD changed on 04.12.02
*hwnd 		= _vfp.hWnd
hwnd		= This.GetHWND()

lnRetVal 	= 0
lnIconIndex = 0
lpiIcon	    = 0

*-- eventually find the filename of the EXE
*lcFile		= This.GetAssocFile(tcFile)
lcFile 		= tcFile

if empty(lcFile) or ! file(lcFile)
	return lnRetVal
endif	

*-- DECLARE INTEGER ExtractAssociatedIcon IN shell32; 
*--     INTEGER   hInst,; 
*--     STRING  @ lpIconPath,; 
*--     INTEGER @ lpiIcon 

*========================================================*
*  All documentation I found states that filename        *
*  and IconIndex of the actual associated file and       *
*  Index will be placed in lcFile and lpiIcon, meaning   *
*  that if I transfer "c:\foo\SomeSheet.xls" and "0" as  *
*  parameters I should get                               *
*  C:\Program Files\Office\...\EXCEL.XLS and 5           *
*  in return witch acutally is not true. I never         *
*  received anything different from what I provided.     *
*  So we can't query the small Icon from what we get     *
*  here.                                                 *
*========================================================*

lnRetVal = ExtractAssociatedIcon(hwnd, @lcFile, @lpiIcon)

return lnRetVal
*-- eof .GETASSOCICONHANDLE

ENDPROC
PROCEDURE getassociconobject
*=========================================================
*
*         PROCEDURE: .GETASSOCICONOBJECT             
*
*=========================================================
*
*  Created...........:  29.November 2002, 17:23 Uhr
*  Changed...........:   
*  Description.......:  Return an object reference to an icon 
*						that is associated with a given file
*  Calling Samples...:  ?GetAssocIconObject(<ExpC>)
*  Parameters........:  tcFile
*  Returns...........:  Object or .NULL.
*
lparameters tcFile
LOCAL loRetVal

tcFile 	= iif(vartype(tcFile) = "C", tcFile, This.cAssocFile)
loRetVal= .NULL.

if empty(tcFile) or ! file(tcFile)
	*-- Nothing to do here
else
	*==========================================*
	*  Call IconHandle2Object() and tell       *
	*  it to destroy the IconHandle when done  *
	*==========================================*
	loRetVal = This.IconHandle2Object( This.GetAssocIconHandle(tcFile), .F. )
endif	

return loRetVal
*-- eof .GETASSOCICONOBJECT

ENDPROC
PROCEDURE destroyicon

*=========================================================
*
*         PROCEDURE: .DESTROYICON             
*
*=========================================================
*
*  Created...........:  29.November 2002, 17:21 Uhr
*  Changed...........:   
*  Description.......:  Destroy an IconHandle when not needed anymore
*  Calling Samples...:  ?DestroyIcon(<ExpN>)
*  Parameters........:  thIconHandle
*  Returns...........:  Number of destroyed Icons
*
lparameters thIconHandle
thIconHandle = iif(vartype(thIconHandle) = "H", thIconHandle, 0)

*-- DECLARE SHORT DestroyIcon IN user32 INTEGER thIconHandle

return DestroyIcon(thIconHandle)
*-- eof .DESTROYICON

ENDPROC
PROCEDURE declaredlls


*-*	*-- We want do cleanup properly don't we
*-*	DECLARE SHORT DestroyIcon IN user32 INTEGER hIcon

*-*	*-- Get the Associated Icon for a given File
*-*	DECLARE INTEGER ExtractAssociatedIcon IN shell32; 
*-*	    INTEGER   hInst,; 
*-*	    STRING  @ lpIconPath,; 
*-*	    INTEGER @ lpiIcon 
	
*-- Needed for retrieving IconPairs (Large/Small)
*-*	Declare long ExtractIconEx in shell32 String @ File, long iconIndex, ;
*-*		long @ iconLarge, long @ iconSmall, long nIcons

*-*	*-- Retrieve the associated Executable for a specific file
*-*	DECLARE INTEGER FindExecutable IN Shell32;
*-*		  STRING @lpFile, STRING @lpDirectory, STRING @lpResult

*-*	declare long SHGetFileInfo in shell32 ;
*-*	 	string  pszPath, long  dwFileAttributes, string @ SHFILEINFO, ;
*-*	    integer cbFileInfo, integer uFlags 

*-- declare LONG IIDFromString in OLE32 STRING lpsz, STRING @ lpIID

*-- #IF Version(5) < 700
*-- 	*-- This one is needed for transformation from IconHandle to Object
*-- 	Declare Long OleCreatePictureIndirect In oleaut32 ;
*-- 		String @ PicDesc, String @ RefIID, Long fPictureOwnsHandle, LONG @ IPic
*-- #ELSE

	*-- This one is needed for transformation from IconHandle to Object
*-*		DECLARE LONG OleCreatePictureIndirect IN oleaut32 ;
*-*			STRING @tPicDesc, STRING @tRefIID, LONG tfPictureOwnsHandle, OBJECT @tIPic


*-- #ENDIF

ENDPROC
PROCEDURE releasedlls
clear Dlls 	"DestroyIcon"
clear Dlls "ExtractAssociatedIcon"
clear Dlls "ExtractIconEx"
clear Dlls "FindExecutable"
* clear Dlls "OleCreatePictureIndirect"   && comment out 28Aug2008 due to crash in VFP9 SP2
clear Dlls "SHGetFileInfo"
ENDPROC
PROCEDURE getassocexecutable

*=========================================================
*
*         PROCEDURE: .GETASSOCFILE             
*
*=========================================================
*
*  Created...........:  29.November 2002, 18:02 Uhr
*  Changed...........:   
*  Description.......:  Return the Associated Executable 
*						for a provided Extension or File
*  Calling Samples...:  ?GetAssocFile(<ExpC>[,<ExpL>])
*  Parameters........:  tcFile, tlIsExtension
*  Returns...........:  Character
*
lparameters tcFile, tlIsExtension
LOCAL lcRetVal, lcPath, lcBuffer, lnLength, lcFile, lnResult
tcFile = iif(vartype(tcFile) = "C", tcFile, "")

lcRetVal = ""

if empty(tcFile) 
	*-- Nothing to do here
else  && empty(tcFile) 

	if tlIsExtension
		*==================================*
		*  We are not geting a full file   *
		*  but a simple Extension instead  *
		*  So create a simple dummy file   *
		*==================================*
		if left(tcFile,1)="."
			*-- Strip off the first .
			*-- if provided
			tcFile = substr(tcFile, 2)
		endif
					
		*=========================================*
		*  And now create a simple Dummy File to  *
		*  fool the FindExecutable()-funktion     *
		*=========================================*
		tcFile = fullPath( addBS(sys(2023)) +"TMP"+ sys(2015) +"."+ tcFile )
		=StrToFile("Temporary Content", tcFile)
		
	endif	&& tlIsExtension

	if file(tcFile)
	
		*=====================================*
		*  If a DLL or EXE-File is provided   *
		*  take this directly. otherwise try  *
		*  to get the associated EXE for the  *
		*  provided file                      *
		*=====================================*
		if inList( lower(JustExt(tcFile)), "dll","exe")
			lcRetVal = tcFile
		else

			*===========================================*
			*  No, we need to find the associated file  *
			*===========================================*
*-- 			DECLARE INTEGER FindExecutable IN Shell32;
*-- 			  STRING @lpFile, STRING @lpDirectory, STRING @lpResult
 	  
			lcPath 		= "" +chr(0) && JustPath(tcfile)
			lcBuffer 	= SPACE(250)
			lcFile		= tcFile + chr(0)
			
			lnResult 	= FindExecutable(@lcFile, @lcpath, @lcbuffer)

			if lnResult > 32 && OK
				lcRetVal = alltrim( strTran(lcBuffer, chr(0),"") )
			else
				*-- something went wrong
			    *    2 = ERROR_FILE_NOT_FOUND 
			    *    3 = ERROR_PATH_NOT_FOUND 
			    *   21 = ERROR_NOT_READY 
			    *  127 = ERROR_PROC_NOT_FOUND 
			    * 1008 = ERROR_NO_TOKEN 

			    *-- DECLARE INTEGER GetLastError IN kernel32 
			    *-- ? "Error code:", GetLastError() 
				*-- But I don't want to really catch this here
				*-- Simply return an empty String instead
				
			endif	&& lnResult > 32
			
		endif &&  inList( lower(JustExt...			
			
	endif && file(tcFile)
	
	*=================================================*
	*  CleanUp if we are dealing with extension only  *
	*=================================================*
	if tlIsExtension and file(tcFile)
		erase(tcFile)
	endif		
	
endif  && empty(tcFile)

this.cAssocFile = lcRetVal

return lcRetVal
*-- eof .GETASSOCFILE


ENDPROC
PROCEDURE geticonpairobjects
*=========================================================
*
*         PROCEDURE: .GETICONPAIROBJECTS             
*
*=========================================================
*
*  Created...........:  30.November 2002, 14:52 Uhr
*  Changed...........:   
*  Version...........:  1.0
*  Author............:  Frank Dietrich
*  Contact...........:  frank.dietrich@dd-tech.de
*  Copyright(c)......:  2002
*  Description.......:  Retrieve the IconPair for a given 
*						Index in a provided Exe or DLL
*  Calling Samples...:  ? GetIconPairObjects([<ExpC>[, <ExpN>[, <@ExpO1>[, <@ExpO2>]]]])
*  Parameters........:  tcFile, tnIconIndex, toIconLarge, toIconSmall
*
*						tcFile: 
*							if not provided, the .cAssocFile
*							that can be filled with .GetAssocExecutable
*							is taken
*						tnIconIndex:
*							The Index of the Icon in the provided
*							File. This is a HighLevel-Method so
*							lets start this with 1 (One-based) 
*						toIconLarge, toIconSmall:
*							References to the two Icons that will
*							be retrieved. Also added to the aIcons[]array
*
*  Returns...........:  Numeric -> Number of Icons
*
lparameters tcFile, tnIconIndex, toIconLarge, toIconSmall
LOCAL lnRetVal, lhIconLarge, lhIconSmall

tcFile 		= iif(vartype(tcFile) = "C", tcFile, This.cAssocFile)
tnIconIndex = iif(vartype(tnIconIndex) = "N", tnIconIndex, 1)
toIconLarge = iif(vartype(toIconLarge) = "O", toIconLarge, .NULL.)
toIconSmall = iif(vartype(toIconSmall) = "O", toIconSmall, .NULL.)
lnRetVal	= 0

if empty(tcFile) or ! file(tcFile)
	*=============================*
	*  No File, so nothing to do  *
	*=============================*

else 	&&  empty(tcFile) or ! file(tcFile)

	*====================================*
	*  Maybe someone gets confused with  *
	*  the Zero-based stuff. So better   *
	*  check the Index                   *
	*====================================*
	tnIconIndex = iif(tnIconIndex < 1, 1, tnIconIndex)

	lhIconLarge = 0 && Handle for the large Icon
	lhIconSmall = 0 && Handle for the small Icon

	*==============================================*
	*  Get the IconHandles for the two Icons       *
	*  This is a low-level, so make it Zero-based  *
	*==============================================*
	lnRetVal	= This.GetIconPairHandle(tcFile, tnIconIndex-1, @lhIconLarge, @lhIconSmall)

	*======================================*
	*  And create IconObjects from them,   *
	*  Immediately destroying the Handles  *
	*======================================*
	toIconLarge = This.IconHandle2Object(lhIconLarge, .F.)
	toIconSmall = This.IconHandle2Object(lhIconSmall, .F.)

	*=========================================*
	*  And append these to the aIcons[Array]  *
	*=========================================*
	This.AddIcons(toIconLarge, toIconSmall)

endif 	&& empty(tcFile) or ! file(tcFile)

*===============================================*
*  And return the number of Icons we retrieved  *
*===============================================*
return lnRetVal
*-- eof .GETICONPAIROBJECTS

ENDPROC
PROCEDURE cleariconarray
*=========================================================
*
*         PROCEDURE: .CLEARICONARRAY             
*
*=========================================================
*
*  Created...........:  30.November 2002, 13:46 Uhr
*  Changed...........:   
*  Version...........:  1.0
*  Author............:  Frank Dietrich
*  Contact...........:  frank.dietrich@dd-tech.de
*  Copyright(c)......:  2002
*  Description.......:  GarbageCollect the aIcons[] - Array and redemension it to one row
*  Calling Samples...:  =ClearIconArray()
*  Parameters........:  
*  Returns...........:  .T.
*
LOCAL lnI

for lnI = alen(This.aIcons,1) to 1 step -1
	This.aIcons[lnI, 1] = .NULL. && Large Icon Column
	This.aIcons[lnI, 2] = .NULL. && Small Icon Column
endfor &&* lnI = alen(This.aIcons,1) to 1 step -1

dimension This.aIcons[1,2]
This.aIcons[1,1] = .NULL.	&& Large Icon's Column
This.aIcons[1,2] = .NULL.	&& Small Icon's Column

return .T.
*-- eof .CLEARICONARRAY



ENDPROC
PROCEDURE geticoncount
*=========================================================
*
*         PROCEDURE: .GETICONCOUNT             
*
*=========================================================
*
*  Created...........:  30.November 2002, 13:29 Uhr
*  Changed...........:   
*  Version...........:  1.0
*  Author............:  Frank Dietrich
*  Contact...........:  frank.dietrich@dd-tech.de
*  Copyright(c)......:  2002
*  Description.......:  Return the number of icons in a File
*  Calling Samples...:  ?GetIconCount(<ExpC>)
*  Parameters........:  tcFile
*  Returns...........:  numeric -> Number of Icons
*
lparameters tcFile
LOCAL lnRetVal

tcFile 	 = iif(vartype(tcFile) = "C", tcFile, This.cAssocFile)
lnRetVal = 0

if empty(tcFile) or ! file(tcFile)
	*-- Nothing to do here

else	&& empty(tcFile) or ! file(tcFile)
	*===============================================*
	*  Call ExtractIconEx in a way that it returns  *
	*  the number of Icons instead of IconHandles   *
	*===============================================*
	lnRetVal = This.GetIconPairHandle(tcFile, -1, .NULL., .NULL.)

endif	&& empty(tcFile) or ! file(tcFile)

This.nIconCount = lnRetVal

return lnRetVal
*-- eof .GETICONCOUNT






ENDPROC
PROCEDURE geticonpairhandle
*=========================================================
*
*         PROCEDURE: .GETICONPAIRHANDLE             
*
*=========================================================
*
*  Created...........:  30.November 2002, 11:35 Uhr
*  Changed...........:   
*  Description.......:  Retrieves the Icon Handles for a 
*						specific large and small Icon Pair 
*						in an Executable or DLL
*  Calling Samples...:  ? GetIconPairHandle(<ExpC>, <ExpN1>, <@ExpN2>, <@ExpN3>)
*  Parameters........:  tcFile, tnIconIndex, thIconLarge, thIconSmall
*						
*						tcFile: 
*							if not provided, the .cAssocFile
*							that can be filled with .GetAssocExecutable
*							is taken
*						tnIconIndex:
*							The Index of the Icon in the provided
*							File. This is a LowLevel-Method dealing
*							with handles so let's keep it Zero-Based
*						thIconLarge, thIconSmall:
*							will be the handles for the retrieved Icons
*							so please provide them per reference

*  Returns...........:  Numeric, the number of found icons
*
lparameters tcFile, tnIconIndex, thIconLarge, thIconSmall
LOCAL lnRetVal, lcFile

tcFile 		= iif(vartype(tcFile) = "C", tcFile, this.cAssocFile)
tnIconIndex = iif(vartype(tnIconIndex) = "N", tnIconIndex, 0)
thIconLarge = iif(vartype(thIconLarge) = "N", thIconLarge, 0)
thIconSmall = iif(vartype(thIconSmall) = "N", thIconSmall, 0)
lnRetVal	= 0

if empty(tcFile) or ! file(tcFile)
	return lnRetVal
endif	
	
*-- Declare long ExtractIconEx in shell32 String @ File, long iconIndex, ;
*-- 	long @ iconLarge, long @ iconSmall, long nIcons


lcFile		= tcFile + chr(0)

lnIconsReceived = ExtractIconEx(lcFile, tnIconIndex, @thIconLarge, @thIconSmall, 1)

*-- And immediately cleanup while testing
*-- This.DestroyIcon(thIconLarge)
*-- This.DestroyIcon(thIconSmall)

lnRetVal 		= lnIconsReceived

return lnRetVal
*-- eof .GETICONPAIRHANDLE

*--
*-- From: http://msdn.microsoft.com/library/en-us/winui/winui/windowsuserinterface/resources/icons/iconreference/iconfunctions/extracticonex.asp
*-- 
*-- The ExtractIconEx function creates an array of handles to 
*-- large or small icons extracted from the specified executable 
*-- file, dynamic-link library (DLL), or icon file. 
*-- 
*-- 
*-- UINT ExtractIconEx( 
*--     LPCTSTR lpszFile,
*--     int nIconIndex,
*--     HICON* phiconLarge,
*--     HICON* phiconSmall,
*--     UINT nIcons
*-- );
*-- 
*-- 
*-- Parameters
*-- 
*-- 	lpszFile
*-- 		[in] Pointer to a null-terminated string specifying 
*-- 		the name of an executable file, DLL, or icon file from 
*-- 		which icons will be extracted. 
*-- 	nIconIndex
*-- 		[in] Specifies the zero-based index of the first icon 
*-- 		to extract. For example, if this value is zero, the 
*-- 		function extracts the first icon in the specified file. 
*-- 		
*-- 	If this value is �1 and phiconLarge and phiconSmall are both NULL, 
*-- 	the function returns the total number of icons in the specified file. 
*-- 	If the file is an executable file or DLL, the return value is the number 
*-- 	of RT_GROUP_ICON resources. If the file is an .ico file, the return value is 1. 
*-- 
*-- 	Windows 95/98/Me, Windows NT 4.0 and later: If this value is a 
*-- 	negative number and either phiconLarge or phiconSmall is not NULL, 
*-- 	the function begins by extracting the icon whose resource identifier 
*-- 	is equal to the absolute value of nIconIndex. For example, use -3 to 
*-- 	extract the icon whose resource identifier is 3. 
*-- 
*-- 	phiconLarge
*-- 		[out] Pointer to an array of icon handles that receives handles to the large icons extracted from the file. If this parameter is NULL, no large icons are extracted from the file. 
*-- 	phiconSmall
*-- 		[out] Pointer to an array of icon handles that receives handles to the small icons extracted from the file. If this parameter is NULL, no small icons are extracted from the file. 
*-- 	nIcons
*-- 		[in] Specifies the number of icons to extract from the file. 
*-- 		
*-- Return Value
*-- 
*-- 	If the nIconIndex parameter is -1, the phiconLarge parameter is NULL, 
*-- 	and the phiconSmall parameter is NULL, then the return value is the 
*-- 	number of icons contained in the specified file. Otherwise, the return 
*-- 	value is the number of icons successfully extracted from the file. 
*-- 



ENDPROC
PROCEDURE getallicons
*=========================================================
*
*         PROCEDURE: .GETALLICONS             
*
*=========================================================
*
*  Created...........:  30.November 2002, 13:36 Uhr
*  Changed...........:   
*  Version...........:  1.0
*  Author............:  Frank Dietrich
*  Contact...........:  frank.dietrich@dd-tech.de
*  Copyright(c)......:  2002
*  Description.......:  Retrieve all Icons as Pairs (Large/Small) 
*						from an EXE or DLL and store them as 
*						Objects in the aIcons[] array.
*  Calling Samples...:  ? GetAllIcons(<ExpC>[, <ExpL>])
*  Parameters........:  tcFile, tlAppend
*	
*						tcFile: 
*							if not provided, the .cAssocFile
*							that can be filled with .GetAssocExecutable
*							is taken
*						tlAppend:
*							Normally the aIcons[] array will
*							be cleared. However if You like
*							You can append to existing icons
*
*  Returns...........:  numeric => number of retrieved Icons
*
lparameters tcFile, tlAppend
LOCAL lnRetVal, lnHasIcons, lnI, loIconLarge, loIconSmall

tcFile 		= iif(vartype(tcFile) = "C", tcFile, This.cAssocFile)
tlAppend 	= iif(vartype(tlAppend) = "L", tlAppend, .F.)
lnRetVal	= 0


*=============================*
*  No File, so nothing to do  *
*=============================*
if empty(tcFile) or ! file(tcFile)
	return lnRetVal
endif	


*=================================*
*  Clean up all ObjectReferences  *
*  possibly in the Array          *
*=================================*
if ! tlAppend
	This.ClearIconArray
endif	

*====================================*
*  How Many Icons are there at all?  *
*====================================*
lnHasIcons  = This.GetIconCount(tcFile)

loIconLarge = .NULL.
loIconSmall = .NULL.

if lnHasIcons > 0
	
	for lnI = 1 to lnHasIcons
		*-- 		lhIconLarge = 0 && Handle for the large Icon
		*-- 		lhIconSmall = 0 && Handle for the small Icon
		*-- 		
		*-- 		*-- Get the IconHandles for the two 
		*-- 		*-- Icons
		*-- 		lnIconsGot = This.GetIconPairHandle(tcFile, lnI-1, @lhIconLarge, @lhIconSmall)
		*-- 		
		*-- 		*-- And create IconObjects from them 
		*-- 		*-- Immediately destroying the Handles
		*-- 		loIconLarge = This.IconHandle2Object(lhIconLarge, .F.)
		*-- 		loIconSmall = This.IconHandle2Object(lhIconSmall, .F.)
		*-- 
		*-- 		*-- And append these to the aIcons[Array]
		*-- 		This.AddIcons(loIconLarge, loIconSmall)
		
		*-- Create the objects and add them to the array
		*-- This is One-Based
		= This.GetIconPairObjects(tcFile, lnI, @loIconLarge, @loIconSmall)
		
		loIconLarge = .NULL.
		loIconSmall = .NULL.
	
	endfor &&* lnI = 1 to lnHasIcons

	lnRetVal = lnHasIcons

endif

return lnRetVal
*-- eof .GETALLICONS

ENDPROC
PROCEDURE addicons
*=========================================================
*
*         PROCEDURE: .ADDICONS             
*
*=========================================================
*
*  Created...........:  30.November 2002, 13:42 Uhr
*  Changed...........:   
*  Version...........:  1.0
*  Author............:  Frank Dietrich
*  Contact...........:  frank.dietrich@dd-tech.de
*  Copyright(c)......:  2002
*  Description.......:  Add Icons retrieved by GetAllIcons() to the aIcons[] Array
*  Calling Samples...:  ? AddIcons(<ExpO1>, <ExpO2>)
*  Parameters........:  toIconLarge, toIconSmall
*  Returns...........:  .T.
*
lparameters toIconLarge, toIconSmall
LOCAL lnNextRow
toIconLarge = iif(vartype(toIconLarge) = "O", toIconLarge, .NULL.)
toIconSmall = iif(vartype(toIconSmall) = "O", toIconSmall, .NULL.)

if alen(This.aIcons, 1) = 1 ;
  and isNull(This.aIcons[1, 1]) ;
  and isNull(this.AIcons[1, 2])
	lnNextRow = 1
else
	lnNextRow = alen(This.aIcons, 1) + 1
endif	

dimension This.aIcons[lnNextRow, 2]
This.aIcons[lnNextRow, 1] = toIconLarge
This.aIcons[lnNextRow, 2] = toIconSmall

return .T.
*-- eof .ADDICONS



ENDPROC
PROCEDURE shellgetfileinfo
*=========================================================
*
*         PROCEDURE: .ShellGetFileInfo
*
*=========================================================
*
*  Created...........:  2.December 2002, 16:31 Uhr
*  Changed...........:   
*  Version...........:  1.0
*  Author............:  Frank Dietrich
*  Contact...........:  frank.dietrich@dd-tech.de
*  Copyright(c)......:  2002
*  Description.......:  Retrieve large or small icons from 
*						files or associated executables using 
*						SHGetFileInfo()
*						This is the same function Windows-Explorer
*						uses to display icons.
*  Calling Samples...:  ? ShellGetFileInfo(<ExpC>[,<ExpN>])
*			
*						
*  Parameters........:  tcFile, tnIconType
*						
*						tcFile
*							Filename to find the associated icon for
*
*						tvIconType
*							
*							accepts either local 
*								.F. = large icon
*								.T. = small icon
*							or numeric
*								for generic use of SHGetFileInfo
*								 (see code below)
*
*  Returns...........:  numeric (Handle to the Icon
*  Additional Info...:	The property cFileType also gets
*						filled from here. It contains the
*						filetype Windows-Explorer displays
*						for a given extension 
*						like xls => "Microsoft Excel Worksheet"
*						or   exe => "Application"
*						
*--
*-- Info from http://msdn.microsoft.com/library/default.asp?url=/library/en-us/shellcc/platform/shell/reference/functions/shgetfileinfo.asp
*--

#define SHGFI_ATTRIBUTES 		0x800
#define SHGFI_DISPLAYNAME		0x200
#define SHGFI_EXETYPE			0x2000
#define SHGFI_ICON				0x100
#define SHGFI_ICONLOCATION		0x1000
#define SHGFI_LARGEICON			0x0
#define SHGFI_LINKOVERLAY		0x8000
#define SHGFI_OPENICON			0x2
#define SHGFI_PIDL				0x8
#define SHGFI_SELECTED			0x10000
#define SHGFI_SHELLICONSIZE		0x4
#define SHGFI_SMALLICON			0x1
#define SHGFI_SYSICONINDEX		0x4000
#define SHGFI_TYPENAME  		0x400
#define SHGFI_USEFILEATTRIBUTES 0x10

#define MAX_PATH 				260

lparameters tcFile, tnIconType
LOCAL lnRetVal, lcSHFileInfo

tcFile 	   = iif(vartype(tcFile) = "C", tcFile, This.cAssocFile)

if vartype(tnIconType)= "L"
	tnIconType = iif(tnIconType = .T., SHGFI_ICON + SHGFI_SMALLICON, SHGFI_ICON + SHGFI_LARGEICON )
else
	tnIconType = iif(vartype(tnIconType) = "N", tnIconType, SHGFI_ICON + SHGFI_LARGEICON)
endif	

*===================================================*
*  in order to retrieve the corresponding icon      *
*  to the File-extension we need to send            *
*  SHGFI_ICON + SHGFI_LARGEICON for the large and   *
*  SHGFI_ICON + SHGFI_SMALLICON for the small icon  *
*===================================================*
lnRetVal = 0

if empty(tcFile) or ! file(tcFile)
	return lnRetVal
endif	

if vartype(tnIconType)# "N"
	tnIconType = SHGFI_ICON
endif	

*-- typedef struct _SHFILEINFO {
*--     HICON hIcon;					 0:4
*--     int iIcon;						 4:4
*--     DWORD dwAttributes;				 8:4
*--     TCHAR szDisplayName[MAX_PATH];	12:260
*--     TCHAR szTypeName[80];		   272:80	
*-- } SHFILEINFO;

#define _SHFILEINFO 12 + MAX_PATH + 80

*-- declare long SHGetFileInfo in shell32 ;
*--  	string  pszPath,;
*--  	long    dwFileAttributes, ;
*--  	string @ SHFILEINFO, ;
*--     integer cbFileInfo, ;
*--     integer uFlags 

lcSHFileInfo = repl( chr(0), _SHFILEINFO)
*lnRetVal 	 = SHGetFileInfo(tcFile,0, @lcSHFileInfo, _SHFILEINFO, tnIconType + SHGFI_ICONLOCATION  + SHGFI_TYPENAME)
lnRetVal 	 = SHGetFileInfo(tcFile,0, @lcSHFileInfo, _SHFILEINFO, tnIconType + SHGFI_TYPENAME)
if lnRetVal = 0
	*-- Call failed, return 0
else
	*-- Return the handle to the icon
	*-- Remember to destroy() this later
	*-- when not needed anymore
	lnRetVal = This.String2Long( substr(lcSHFileInfo, 1, 4) )
	
	*=============================================*
	*  Also keep the filetype that is associated  *
	*  with that Extension / icon                 *
	*=============================================*
	This.cFileType = chrTran( subStr(lcSHFileInfo ,13 + MAX_PATH, 80), chr(0), "" ) 
endif	

return lnRetval
*-- eof .ShellGetFileInfo



ENDPROC
PROCEDURE string2long
*=========================================================
*
*         PROCEDURE: .STRING2LONG             
*
*=========================================================
*
*  Created...........:  2.December 2002, 15:07 Uhr
*  Changed...........:   
*  Description.......:  Convert a String var to a long
*  Calling Samples...:  ? String2Long(<ExpC>)
*  Parameters........:  tcLongStr
*  Returns...........:  numeric (long)
*
lparameters tcLongStr
LOCAL lnLoopVar, lnRetVal

* This function converts a String to a Long

lnRetVal = 0
  
FOR lnLoopVar 	= 0 TO 24 STEP 8
	lnRetVal 	= lnRetVal + (ASC(tcLongStr) * (2^lnLoopVar))
    tcLongStr 	= RIGHT(tcLongStr, LEN(tcLongStr) - 1)
NEXT

return lnRetVal
*-- eof .STRING2LONG

ENDPROC
PROCEDURE getassociconpairobjects
*=========================================================
*
*         PROCEDURE: .GETASSOCICONPAIROBJECTS             
*
*=========================================================
*
*  Created...........:  2.December 2002, 15:59 Uhr
*  Changed...........:   
*  Version...........:  1.0
*  Author............:  Frank Dietrich
*  Contact...........:  frank.dietrich@dd-tech.de
*  Copyright(c)......:  2002
*  Description.......:  Get large and small icon for a given file or extension
*  Calling Samples...:  ? GetAssocIconPairObjects(<ExpC>[, <@ExpO1>[, <@ExpO2>]])
*  Parameters........:  tcFile, toIconLarge, toIconSmall
*  Returns...........:  Numeric (Number of Icons found)
*
lparameters tcFile, toIconLarge, toIconSmall
LOCAL lnRetVal, lhIconLarge, lhIconSmall

tcFile 		= iif(vartype(tcFile) = "C", tcFile, This.cAssocFile)
toIconLarge = iif(vartype(toIconLarge) = "O", toIconLarge, .NULL.)
toIconSmall = iif(vartype(toIconSmall) = "O", toIconSmall, .NULL.)
lnRetVal	= 0

if empty(tcFile) or ! file(tcFile)
	*=============================*
	*  No File, so nothing to do  *
	*=============================*

else 	&&  empty(tcFile) or ! file(tcFile)

	*====================================*
	*  Maybe someone gets confused with  *
	*  the Zero-based stuff. So better   *
	*  check the Index                   *
	*====================================*
	#define SHGFI_ICON				0x100
	#define SHGFI_LARGEICON			0x0
	#define SHGFI_SMALLICON			0x1
	
	lhIconLarge = 0 && Handle for the large Icon
	lhIconSmall = 0 && Handle for the small Icon
	
	*====================================*
	*  Now retrieve the handles for the  *
	*  small and the large icon using    *
	*  SHGetFileInfo just like Windows   *
	*  Explorer does                     *
	*====================================*
	lhIconLarge = This.ShellGetFileInfo(tcFile, SHGFI_ICON + SHGFI_LARGEICON)
	lhIconSmall = This.ShellGetFileInfo(tcFile, SHGFI_ICON + SHGFI_SMALLICON)

	lnRetVal    = lnRetVal + iif(lhIconLarge > 0, 1, 0)
	lnRetVal    = lnRetVal + iif(lhIconsmall > 0, 1, 0)

	*======================================*
	*  And create IconObjects from them,   *
	*  Immediately destroying the Handles  *
	*======================================*
	toIconLarge = This.IconHandle2Object(lhIconLarge, .F.)
	toIconSmall = This.IconHandle2Object(lhIconSmall, .F.)

	*=========================================*
	*  And append these to the aIcons[Array]  *
	*=========================================*
	This.AddIcons(toIconLarge, toIconSmall)

endif 	&& empty(tcFile) or ! file(tcFile)

*===============================================*
*  And return the number of Icons we retrieved  *
*===============================================*
return lnRetVal
*-- eof .GETASSOCICONPAIROBJECTS

ENDPROC
PROCEDURE imglistindex
*=========================================================
*
*         PROCEDURE: .ImgListIndex
*
*=========================================================
*
*  Created...........:  3.December 2002, 09:17 Uhr
*  Changed...........:   
*  Version...........:  1.0
*  Author............:  Frank Dietrich
*  Contact...........:  frank.dietrich@dd-tech.de
*  Copyright(c)......:  2002
*  Description.......:  Return the index to an image in an imagelist or 0 if the provided key cannot be found
*  Calling Samples...:  ? ImgListIndex(<ExpO>, <ExpC>)
*  Parameters........:  toImgList, tcKey
*  Returns...........:  numeric: Index of Image or 0 if not found
*
lparameters toImgList, tcKey
LOCAL lnRetVal
toImgList = iif(vartype(toImgList) = "O", toImgList, .NULL.)
tcKey 	  = iif(vartype(tcKey) = "C", tcKey, "-NONE-")
lnRetVal  = 0

if isNull(toImgList) or tcKey = "-NONE-" ;
  or toImgList.ListImages.Count = 0
	return lnRetVal
endif

for lnIndex = 1 to toImgList.ListImages.Count
	if lower(toImgList.ListImages.Item(lnIndex).Key) = lower(tcKey)
		*-- Found it, so we're done
		lnRetVal = lnIndex
		exit
	endif		
endfor &&* 
	
return lnRetVal
*-- eof .ImgListIndex

ENDPROC
PROCEDURE extract2imagelist
*=========================================================
*
*         PROCEDURE: .Extract2ImageList             
*
*=========================================================
*
*  Created...........:  3.December 2002, 09:41 Uhr
*  Changed...........:   
*  Version...........:  1.0
*  Author............:  Frank Dietrich
*  Contact...........:  frank.dietrich@dd-tech.de
*  Copyright(c)......:  2002
*  Description.......:  Directly extract an icon from a file 
*						and add it to an imageList.
*						If the key already exists, the image
*						will not be added again. instead the
*						index of the existing image will be
*						returned
*  Calling Samples...:  ? Extract2ImageList(<ExpC1>, <ExpC2>, <ExpO>[, <ExpL>[, <ExpN>]]) 
*  Parameters........:  tcFile, tcKey, toImgList, tlSmallIcon, tnIconIndex
*
*						tcFile: 
*							if not provided, the .cAssocFile
*							that can be filled with .GetAssocExecutable
*							is taken
*						tcKey:
*							Key of the Image in the imageList that
*							the icon should be added to. If not
*							provided, the lower extension of tcFile
*							will be taken
*						toImgList:
*							ImageListObject to add the image to
*						tlSmallIcon:
*							if .T., add the small icon, if .F.
*							add the large one
*						tnIconIndex:
*							The index of the icon in the resourceFile
*							if <=0 the associated icon will be taken (default)
*
*  Returns...........:  numeric: Index of the image in the ImageList
*
lparameters tcFile, tcKey, toImgList, tlSmallIcon, tnIconIndex
LOCAL lnRetVal, lhIconLarge, lhIconSmall, lhTmpIcon, loImg, loTmpImg

tcFile 		= iif(vartype(tcFile) 		= "C", tcFile, This.cAssocFile)
tcKey 		= iif(vartype(tcKey) 		= "C", tcKey, lower(justExt( tcFile )))
toImgList 	= iif(vartype(toImgList) 	= "O", toImgList, .NULL.)
tlSmallIcon = iif(vartype(tlSmallIcon) 	= "L", tlSmallIcon, .F.)
tnIconIndex = iif(vartype(tnIconIndex) 	= "N", tnIconIndex, -1)

lnRetVal 	= -1
lhTmpIcon	= 0			&& temporary handle to the icon
loTmpImg	= .NULL.	&& temporary Image

if empty(tcFile) or ! file(tcFile) ;
  or empty(tcKey) or isNull(toImgList)
	return lnRetVal
endif	

*-- Is the image already present in the ImageList?
lnRetVal 	= This.ImgListIndex(toImgList, tcKey)

if lnRetVal <= 0
	*======================================*
	*  No, a new key and thus image needs  *
	*  to be added to the imageList.       *
	*======================================*
	
	*===================================*
	*  Now it depends on what the User  *
	*  wants. The standard-associated   *
	*  or a special Icon                *
	*===================================*
	if tnIconIndex > 0 
		*===============================*
		*  He/she wants a special icon  *
		*===============================*
		
		*========================================*
		*  Retrieve the handles to the IconPair  *
		*  Remember this is zero-based, but we   *
		*  get one-based here                    *
		*========================================*
		lhIconLarge = 0
		lhIconSmall = 0
		
		=This.GetIconPairHandle(tcFile, tnIconIndex-1, @lhIconLarge, @lhIconSmall)
	
		*=========================================*
		*  We do get two IconHandles here. As we  *
		*  only need one, we need to destroy the  *
		*  other manually.                        *
		*=========================================*
		if tlSmallIcon
			lhTmpIcon = lhIconSmall
			This.DestroyIcon(lhIconLarge)
		else
			lhTmpIcon = lhIconLarge
			This.DestroyIcon(lhIconSmall)
		endif

	else && tnIconIndex > 0 
		*==================================*
		*  He/she wants the standard-Icon  *
		*==================================*
		
		lhTmpIcon	= This.ShellGetFileInfo(tcFile, tlSmallIcon)

	endif && tnIconIndex > 0 
	
	*===============================*
	*  Now take the IconHandle and  *
	*  convert it to an object.     *
	*  Immediately destroying the   *
	*  IconHandle                   *
	*===============================*
	loTmpImg = This.IconHandle2Object(lhTmpIcon, .F.)
	
	*==============================*
	*  And if successfull, add it  *
	*  to the ImageList            *
	*==============================*
	if ! isNull(loTmpImg)
		lnRetVal = This.Add2ImageList(toImgList, loTmpImg, tcKey)
	endif

	loTmpImg = .NULL.

else  && lnRetVal <= 0
	
	*==================================*
	*  Yes, the Icon (key) is already  *
	*  present in the imagelist. So    *
	*  simply take that one.           *
	*==================================*
endif	&& lnRetVal <= 0


return lnRetVal
*-- eof .Extract2ImageList

ENDPROC
PROCEDURE add2imagelist
*=========================================================
*
*         PROCEDURE: Add2ImageList             
*
*=========================================================
*
*  Created...........:  3.December 2002, 10:12 Uhr
*  Changed...........:   
*  Version...........:  1.0
*  Author............:  Frank Dietrich
*  Contact...........:  frank.dietrich@dd-tech.de
*  Copyright(c)......:  2002
*  Description.......:  Add an Image to an ImageList and return the Index
*  Calling Samples...:  ? Add2ImageList(<ExpO1>, <ExpO2>, <ExpC>)
*  Parameters........:  toImgList, toImg, tcKey
*  Returns...........:  numeric: Index of the image in the imageList or 0
*
lparameters toImgList, toImg, tcKey
LOCAL lnRetVal
toImgList 	= iif(vartype(toImgList) = "O", toImgList, .NULL.)
toImg 		= iif(vartype(toImg) = "O", toImg, .NULL.)
tcKey 		= iif(vartype(tcKey) = "C", tcKey, "-NONE-")

lnRetVal 	= -1

if isNull(toImgList) or isNull(toImg) ;
  or empty(tcKey) or tcKey = "-NONE-"
	return lnRetVal
endif

*-- Check for existance
lnRetVal 	= This.ImgListIndex(toImglist, tcKey)

if lnRetVal > 0
	*-- Oh... we're done already
else
	*-- Add the provided image
	= toImgList.ListImages.Add( , tcKey, toImg)	
	lnRetVal = toImgList.ListImages.Count
endif

return lnRetVal
*-- eof Add2ImageList

ENDPROC
PROCEDURE gethwnd
*=========================================================
*
*         PROCEDURE: .GetHwnd             
*
*=========================================================
*
*  Created...........:  4.Dezember 2002, 20:05 Uhr
*  Changed...........:   
*  Version...........:  1.0
*  Author............:  Frank Dietrich
*  Contact...........:  frank.dietrich@dd-tech.de
*  Copyright(c)......:  2002
*  Description.......:  Return the WindowsHandle (used in GetAssocIconHandle)
*  Calling Samples...:  ?GetHwnd
*  Parameters........:  
*  Returns...........:  numeric: Window-Handle
*
local lnRetVal

#IF Version(5) >= 700
	lnRetVal = _vfp.hWnd
#else
	
	if atc("foxtools", set("LIBRARY")) = 0
		set Library to (this.cFoxtoolsLoc) additive
	endif
		
	lnRetVal = MainHWND()

#endif	

return lnRetVal
*-- eof .GetHwnd

ENDPROC
PROCEDURE Destroy

*========================*
*  Do GarbageCollection  *
*========================*
This.ClearIconArray

*===============================*
*  And release the needed DLLs  *
*===============================*
This.ReleaseDLLs

ENDPROC
PROCEDURE Init


if Version(5) < 700 and lower(this.ParentClass) = "custom"
	=MessageBox(;
		"This class is for VFP7 and higher only. Please use IconBuddyVFP6 instead.", ;
		64, "IconBuddy")
	return .F.
ENDIF	



*================================*
*  Initialize the Array that     *
*  possibly will hold IconPairs  *
*  -> .GetAllIcons()             *
*  -> .ClearIconArray()          *
*================================*
This.ClearIconArray

*-- dimension This.aIcons[1,2]
*-- This.aIcons[1,1] = .NULL.	&& Large Icon's Column
*-- This.aIcons[1,2] = .NULL.	&& Small Icon's Column

*================================================*
*  Declare the needed DLL's -> This.ReleaseDLLs  *
*================================================*
This.DeclareDLLs

ENDPROC
     $����    j$  j$                        �O   %   �      �"  a  �          �  U  : ��  � �$ T�  �CC�  ��� IN� �  � � 6�� �� � � � � T� ����6 T� �C�� � C�� � C �  � � C� � � �� T� �� ��+ T� �CC�  �QC�� CC�  �QC�F �� ��C� � �� � �� %�C� ��� O� C� �
	�� � T� �� �� � %�� ��� �*� ��C �  � �	 �� �	 B�� �� U
  THICONHANDLE TLKEEPHANDLE TORETVAL PICTDESC IPIC IID THIS LONG2STRING OLECREATEPICTUREINDIRECT DESTROYICON>  ��  �# T�  �CC�  ��� N� �  � � 6�� B�C �  � � �� U 	 TNLONGVAL THIS LONG2STRING�  ��  � �� � �# T�  �CC�  ��� N� �  � � 6�� T� ��  �� �� ���(�� ��������� � T� �CC�  �� 8 � �� T�  �C�  �� G�� ��	 B�� �� U  TNLONGVALUE LNLOOP LCRETVAL�  ��  � �� � � � �& T�  �CC�  ��� C� �  � � � 6�� T� �C� � �� T� �� �� T� �� �� T� �� �� T� ��  �� %�C� �� C� 0
��� �	 B�� �� � T� �C � � � �	 ��	 B�� �� U
  TCFILE LNICONINDEX LNRETVAL LCFILE HWND THIS
 CASSOCFILE GETHWND LPIICON EXTRACTASSOCIATEDICON�  ��  � �� �& T�  �CC�  ��� C� �  � � � 6�� T� ���� %�C�  �� C�  0
��X � �} � T� �CC �  � � -� � �� �	 B�� �� U  TCFILE LORETVAL THIS
 CASSOCFILE ICONHANDLE2OBJECT GETASSOCICONHANDLE;  ��  �# T�  �CC�  ��� H� �  � � 6�� B�C �  � �� U  THICONHANDLE DESTROYICON  U  x  V� DestroyIcon� V� ExtractAssociatedIcon� V� ExtractIconEx� V� FindExecutable� V� SHGetFileInfo� U   ��  � � �� � � � � � �# T�  �CC�  ��� C� �  � �  6�� T� ��  �� %�C�  ���e � ��� %�� ��� � %�C�  �=� .��� � T�  �C�  �\�� �, T�  �CCC��]��� TMPC��]� .�  ���  ��C� Temporary Content�  ���� � %�C�  0����  %�CCC�  ��@� dll� exe���3� T� ��  �� ��� T� ��  C�  �� T� �C��X�� T� ��  C�  �� T� �C� � � � �� %�� � ���� T� �CC� C�  �  ���� ��� � � � %�� � C�  0	����
  ��  �� � � T�	 �
 �� ��	 B�� �� U  TCFILE TLISEXTENSION LCRETVAL LCPATH LCBUFFER LNLENGTH LCFILE LNRESULT FINDEXECUTABLE THIS
 CASSOCFILE� ��  � � � � �� � � �& T�  �CC�  ��� C� �  � � � 6��# T� �CC� ��� N� � � �6��! T� �CC� ��� O� � � �6��! T� �CC� ��� O� � � �6�� T� �� �� %�C�  �� C�  0
��� � �y� T� �C� �� �� � 6�� T� �� �� T� �� ��$ T� �C �  � �� � � �	 �� T� �C � -� �
 �� T� �C � -� �
 �� ��C �  � � � �� �	 B�� �� U  TCFILE TNICONINDEX TOICONLARGE TOICONSMALL LNRETVAL LHICONLARGE LHICONSMALL THIS
 CASSOCFILE GETICONPAIRHANDLE ICONHANDLE2OBJECT ADDICONS�  ��  �& ��  �C� � ���(����������a � T� � ��  �������� T� � ��  �������� �� � � ������� T� � ���������� T� � ���������� B�a�� U  LNI THIS AICONS�  ��  � �� �& T�  �CC�  ��� C� �  � � � 6�� T� �� �� %�C�  �� C�  0
��Z � �} � T� �C �  ������ � �� � T� � �� ��	 B�� �� U  TCFILE LNRETVAL THIS
 CASSOCFILE GETICONPAIRHANDLE
 NICONCOUNT- ��  � � � � �� � �& T�  �CC�  ��� C� �  � � � 6��# T� �CC� ��� N� � � � 6��# T� �CC� ��� N� � � � 6��# T� �CC� ��� N� � � � 6�� T� �� �� %�C�  �� C�  0
��� �	 B�� �� � T� ��  C�  ��! T� �C �  � � � ��	 �� T� �� ��	 B�� �� U
  TCFILE TNICONINDEX THICONLARGE THICONSMALL LNRETVAL LCFILE THIS
 CASSOCFILE LNICONSRECEIVED EXTRACTICONEX_ ��  � � �� � � � � �& T�  �CC�  ��� C� �  � � � 6��! T� �CC� ��� L� � � -6�� T� �� �� %�C�  �� C�  0
��� �	 B�� �� � %�� 
��� �
 �� �	 � � T� �C �  � �
 �� T� ���� T� ���� %�� � ��O� �� ���(�� ��>� ��C �   � � � � � �� T� ���� T� ���� �� T� �� �� �	 B�� �� U  TCFILE TLAPPEND LNRETVAL
 LNHASICONS LNI LOICONLARGE LOICONSMALL THIS
 CASSOCFILE CLEARICONARRAY GETICONCOUNT GETICONPAIROBJECTS ��  � � �� �! T�  �CC�  ��� O� �  � �6��! T� �CC� ��� O� � � �6��? %�C� � ���� CC��� � �	� CC��� � �	��� � T� ���� �� � T� �C� � ����� � � � �� ����� T� � �� ������  �� T� � �� ������ �� B�a�� U  TOICONLARGE TOICONSMALL	 LNNEXTROW THIS AICONS� ��  � � �� � �& T�  �CC�  ��� C� �  � � � 6�� %�C� ��� L��p � T� �C� a� �� � 6�� �� �$ T� �CC� ��� N� � � � 6�� � T� �� �� %�C�  �� C�  0
��� �	 B�� �� � %�C� ��� N��� � T� �� �� � T� �CC�  �`Q��% T� �C �  � � �`� � � �� %�� � ��E� ��� T� �CC� ��\� � ��# T� � �CC� ��P\C�  �  ��� �	 B�� �� U	  TCFILE
 TNICONTYPE LNRETVAL LCSHFILEINFO THIS
 CASSOCFILE SHGETFILEINFO STRING2LONG	 CFILETYPE�  ��  � �� � � T� �� �� �� �� �(��������q � T� �� C�  �� �� T�  �C�  C�  >�R�� ��	 B�� �� U 	 TCLONGSTR	 LNLOOPVAR LNRETVAL� ��  � � � �� � � �& T�  �CC�  ��� C� �  � � � 6��! T� �CC� ��� O� � � �6��! T� �CC� ��� O� � � �6�� T� �� �� %�C�  �� C�  0
��� � ��� T� �� �� T� �� �� T� �C �  � � � �� T� �C �  �� � ��# T� �� C� � � �� � 6��# T� �� C� � � �� � 6�� T� �C � -� �	 �� T� �C � -� �	 �� ��C �  � � �
 �� �	 B�� �� U  TCFILE TOICONLARGE TOICONSMALL LNRETVAL LHICONLARGE LHICONSMALL THIS
 CASSOCFILE SHELLGETFILEINFO ICONHANDLE2OBJECT ADDICONS ��  � � �� �! T�  �CC�  ��� O� �  � �6��) T� �CC� ��� C� � �	 � -NONE-6�� T� �� ��1 %�C�  �� � � -NONE-� �  � � � ��� �	 B�� �� � �� ���(��  � � ��� �# %�CC � �  � � � @C� @��� � T� �� �� !� � ��	 B�� �� U 	 TOIMGLIST TCKEY LNRETVAL
 LISTIMAGES COUNT LNINDEX ITEM KEY� ��  � � � � � �� � � � �	 �
 �& T�  �CC�  ��� C� �  � � � 6��( T� �CC� ��� C� � � CC�  ��@6��! T� �CC� ��� O� � � �6��! T� �CC� ��� L� � � -6��$ T� �CC� ��� N� � � ���6�� T� ������ T� �� �� T�
 ����+ %�C�  �� C�  0
� C� �� C� ���@�	 B�� �� � T� �C �  � � � �� %�� � ���� %�� � ��� T� �� �� T� �� ��  ��C �  � �� � � � �� %�� ���� T� �� �� ��C � � � �� �
� T� �� �� ��C � � � �� � �/� T� �C �   � � � �� � T�
 �C � -� � �� %�C�
 �
��v� T� �C �  �
  � � � �� � T�
 ���� ��� �	 B�� �� U  TCFILE TCKEY	 TOIMGLIST TLSMALLICON TNICONINDEX LNRETVAL LHICONLARGE LHICONSMALL	 LHTMPICON LOIMG LOTMPIMG THIS
 CASSOCFILE IMGLISTINDEX GETICONPAIRHANDLE DESTROYICON SHELLGETFILEINFO ICONHANDLE2OBJECT ADD2IMAGELIST< ��  � � � �� �! T�  �CC�  ��� O� �  � �6��! T� �CC� ��� O� � � �6��) T� �CC� ��� C� � �	 � -NONE-6�� T� ������2 %�C�  �� C� �� C� �� � � -NONE-��� �	 B�� �� � T� �C �   � � � �� %�� � ��� � �,� ��C� �  � �  � � �� T� ��  � � �� �	 B�� �� U	 	 TOIMGLIST TOIMG TCKEY LNRETVAL THIS IMGLISTINDEX
 LISTIMAGES ADD COUNT"  ��  � T�  ��C� ��	 B��  �� U  LNRETVAL HWND 
 ��  � �
 ��  � � U  THIS CLEARICONARRAY RELEASEDLLS� * %�C�h��� C�  � @� custom	��� �d ��C�I This class is for VFP7 and higher only. Please use IconBuddyVFP6 instead.�@�	 IconBuddy�x�� B�-�� �
 ��  � �
 ��  � � U  THIS PARENTCLASS CLEARICONARRAY DECLAREDLLS iconhandle2object,     �� dword�    �� long2string?    �� getassociconhandle    �� getassociconobjectD    �� destroyicon     �� declaredllsz    �� releasedlls�    �� getassocexecutable�    �� geticonpairobjects~    �� cleariconarray�
    �� geticoncountp    �� geticonpairhandleT    �� getallicons�    �� addicons�    �� shellgetfileinfo:    �� string2long?    �� getassociconpairobjects�    �� imglistindex    �� extract2imagelistY    �� add2imagelist�    �� gethwndq    �� Destroy�    �� Init�    ��1 @� A1� m� ���� A � � A � 4 ~ 14 � q � 2� ��qA � 4  q 1b� � � � �� A 0�� 4  q b� �� �A � 4  1� 4 p1 A�aqb2 � � �1� � � � v#A �B � � � 8� 1��� M B B e� A B � 5 �1� b1� �� �� � FfaUB � 4 q b��A b��r 6 q q b� �� �B � 9 �1� b111� �� A 6� � �1 �� qb� �� A � � A U� � r�� � B � B � 4 � q �� � �A b��r 6  � � bR�� AA � �� A R� A  QR� �6A � 6 ~ � � ���A � 4 � � b� �� � � ��21faUB � 4 � q �� � A �1� A A A � 4 �q�b�A� � � �� A �� � � � � � A � �B h�A � � G � 4 � q �� #� A �� �1A � 4 q � � 4 � � 3 �Cq A � � 2                       �	        �	  �  G      �    \   "   +  �  �   2        �   <   5  �  �   @     _$  �   B   �$  p%  "  H   �%  �1  *  k   2  *>  �     O>  *B  �  �   MB  G    �   =G  XX  =  �   zX  Xc  �  �   wc  �g    �   h  Dx  ;  �   fx  Q{  �  �   {  ��  �    ��  U�  ,    }�  ��  U  @  ��  �  �  R  �  I�    W  g�  O�  6  Z  j�  f�  C   )   j$                  BM6      6   (                  2  2          ���������������������������������������������������                                          ���������������������������������������������   ��������� ����� ����� ����� ����� ����� �����   ������������ ��                      ��������   ��������� �����   ��� ����� ����� ����� �����   ������������ ��    ����� ����� ����� ��������   ���������               ��� ����� ����� �����   ������������         ��� ����� ����� ��������   ��������� �����   ��� ����� ����� ����� �����   ���������������������������������������������   ��������� ����� ����� �������������������������������������� ����� ��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Screen                                                                                            WINDOWS _0L80KODD6 7422804098      O  f      }                          �      �                       WINDOWS _0L80KODD71058581138�      �              �  =�                  hJ                      eD   WINDOWS _0L80KODD6 983470786�K      �K  �K  �K  �K                                                           WINDOWS _0L810JNAY 983470786mL      zL  �L  �L  �L                                                           WINDOWS _0L80KODD61058377928��  MM  rM  �M  �M  �M      [N  �P                                               WINDOWS _0L80KODD61058581138_W  mS  �S  �S  �S  �S      sT  �@                                               WINDOWS _1731892971058377928�S  :W  uW  �W  �W  �W      1X  �?                                               WINDOWS _0L80KODD61058377928'Y      Y  Y  �X  9Y              �Y  �X                                       WINDOWS _28S16V5HD1058581138�X  �X  (W  eX  W  �V      ��  �4  -�  vV                                       WINDOWS _0L80KODD6 983470786fV  GV  XD  /V  DD  �U                                                           WINDOWS _0L80KODD610585811383D  D  �C  �C  �C  yC      ��  Q1  5�  CC                                       WINDOWS _0L80KODD610585811384C  C  �B  �B  �B  oB      !�  �,                                               COMMENT RESERVED                                FB                      B                                    �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      ..\programs\gktdefines.h      dataenvironment      dataenvironment      Dataenvironment      YTop = 0
Left = 0
Width = 0
Height = 0
DataSource = .NULL.
Name = "Dataenvironment"
      1      1      form      form      GKTSELECTDIR     �Height = 286
Width = 561
Desktop = .F.
ShowWindow = 1
DoCreate = .T.
ShowTips = .T.
AutoCenter = .T.
BorderStyle = 2
Caption = "Select Directory"
HalfHeightCaption = .T.
MaxButton = .F.
MinButton = .F.
Icon = ..\graphics\gktgkt.ico
WindowType = 1
AllowOutput = .F.
_memberdata =      515<VFPData><memberdata name="computername" type="property" display="ComputerName"/><memberdata name="currentdirectory" type="property" display="CurrentDirectory"/><memberdata name="desktoppath" type="property" display="DesktopPath"/><memberdata name="getdirectory" type="method" display="GetDirectory"/><memberdata name="getvolumename" type="method" display="GetVolumeName"/><memberdata name="mydocpath" type="property" display="MyDocPath"/><memberdata name="rtnvalue" type="property" display="RtnValue"/></VFPData>

computername = My Computer
currentdirectory = 
desktoppath = 
mydocpath = 
rtnvalue = 
Name = "GKTSELECTDIR"
     #�PROCEDURE getdirectory
LPARAMETERS tcMode, tcSelDirectory
LOCAL lnNumFolders, lnRow, lnNdx, lnNumPath, lnPath, lcPath, lnIndent, lnDriveID, lcDrive, lnRow
LOCAL lcDriveName, lnIcon, lnNumDeskFldrs, lnNumMyDocFldrs
LOCAL ARRAY laDirectoryList[1], laDesktopList[1], laMyDocList[1], lcDriveList[1,2]
WITH thisform
	.CurrentDirectory = tcSelDirectory
	.lblCurrentFolder.Caption = tcSelDirectory
	WITH .grdCurrentDirectoryList
		.LockState = True
		.RemoveAll()
	ENDWITH
	WITH .cboFolderList
		.RemoveAll()
		.FolderListKey = 0
	ENDWITH
	lnNumDeskFldrs  = ADIR(laDesktopList,ADDBS(.DesktopPath)+"*.*","D",1)
	lnNumMyDocFldrs = ADIR(laMyDocList,ADDBS(.MyDocPath)+"*.*","D",1)
	lnNumFolders    = ADIR(laDirectoryList,ADDBS(tcSelDirectory)+"*.*","D",1)
	DO CASE
		CASE tcMode = "DESKTOP"
			WITH .cboFolderList
				lnRow = .AddListItem(0,"DeskTop",thisform.DesktopPath,7,0)
				lnRow = .AddListItem(lnRow,"My Documents",thisform.MyDocPath,10,1)
				lnRow = .AddListItem(lnRow,thisform.ComputerName,thisform.ComputerName,8,1)
				FOR lnDriveID=0 TO 25                                && Loop to add drives
					lcDrive = CHR(lnDriveID+65) + ":"
					lnIcon  = DRIVETYPE(lcDrive)
					IF lnIcon > 1
						lcDriveName = thisform.GetVolumeName(lcDrive,lnIcon)
						lnRow = .AddListItem(lnRow,lcDriveName,lcDrive,lnIcon,2)
					ENDIF
				ENDFOR
				FOR lnNdx=1 TO lnNumDeskFldrs                        && Add the folders attached to the desktop
					IF laDesktopList[lnNdx,1] != "." .AND. ATC("D",laDesktopList[lnNdx,5]) > 0
						lnRow = .AddListItem(lnRow,laDesktopList[lnNdx,1],ADDBS(thisform.DesktopPath)+laDesktopList[lnNdx,1],1,1)
					ENDIF
				ENDFOR
				.ComboItems(1).Selected = True
			ENDWITH
			WITH .grdCurrentDirectoryList
				lnRow = .AddListItem(0,10,"My Documents",thisform.MyDocPath)
				lnRow = .AddListItem(lnRow,8,thisform.ComputerName,thisform.ComputerName)
				FOR lnNdx=1 TO lnNumDeskFldrs
					IF laDesktopList[lnNdx,1] != "." .AND. ATC("D",laDesktopList[lnNdx,5]) > 0
						lnRow = .AddListItem(lnRow,1,laDesktopList[lnNdx,1],ADDBS(thisform.DesktopPath)+laDesktopList[lnNdx,1])
					ENDIF
				ENDFOR
			ENDWITH

		CASE tcMode = "MY DOCUMENTS"
			WITH .cboFolderList
				lnRow = .AddListItem(0,"DeskTop",thisform.DesktopPath,7,0)
				lnRow = .AddListItem(lnRow,"My Documents",thisform.MyDocPath,10,1)
				lnRow = .AddListItem(lnRow,thisform.ComputerName,thisform.ComputerName,8,1)
				FOR lnDriveID=0 TO 25                                && Loop to add drives
					lcDrive = CHR(lnDriveID+65) + ":"
					lnIcon  = DRIVETYPE(lcDrive)
					IF lnIcon > 1
						lcDriveName = thisform.GetVolumeName(lcDrive,lnIcon)
						lnRow = .AddListItem(lnRow,lcDriveName,lcDrive,lnIcon,2)
					ENDIF
				ENDFOR
				FOR lnNdx=1 TO lnNumDeskFldrs                        && Add the folders attached to the desktop
					IF laDesktopList[lnNdx,1] != "." .AND. ATC("D",laDesktopList[lnNdx,5]) > 0
						lnRow = .AddListItem(lnRow,laDesktopList[lnNdx,1],ADDBS(thisform.DesktopPath)+laDesktopList[lnNdx,1],1,1)
					ENDIF
				ENDFOR
				.ComboItems(2).Selected = True
			ENDWITH
			WITH .grdCurrentDirectoryList
				lnRow = 0
				FOR lnNdx=1 TO lnNumMyDocFldrs
					IF laMyDocList[lnNdx,1] != "." .AND. ATC("D",laMyDocList[lnNdx,5]) > 0
						lnRow = .AddListItem(lnRow,1,laMyDocList[lnNdx,1],ADDBS(thisform.MyDocPath)+laMyDocList[lnNdx,1])
					ENDIF
				ENDFOR
			ENDWITH

		CASE tcMode = UPPER(.ComputerName)
			WITH .cboFolderList
				lnRow = .AddListItem(0,"DeskTop",thisform.DesktopPath,7,0)
				lnRow = .AddListItem(lnRow,"My Documents",thisform.MyDocPath,10,1)
				lnRow = .AddListItem(lnRow,thisform.ComputerName,thisform.ComputerName,8,1)
				FOR lnDriveID=0 TO 25                                && Loop to add drives
					lcDrive = CHR(lnDriveID+65) + ":"
					lnIcon  = DRIVETYPE(lcDrive)
					IF lnIcon > 1
						lcDriveName = thisform.GetVolumeName(lcDrive,lnIcon)
						lnRow = .AddListItem(lnRow,lcDriveName,lcDrive,lnIcon,2)
					ENDIF
				ENDFOR
				FOR lnNdx=1 TO lnNumDeskFldrs                        && Add the folders attached to the desktop
					IF laDesktopList[lnNdx,1] != "." .AND. ATC("D",laDesktopList[lnNdx,5]) > 0
						lnRow = .AddListItem(lnRow,laDesktopList[lnNdx,1],ADDBS(thisform.DesktopPath)+laDesktopList[lnNdx,1],1,1)
					ENDIF
				ENDFOR
				.ComboItems(3).Selected = True
			ENDWITH
			WITH .grdCurrentDirectoryList
				lnRow = 0
				FOR lnDriveID=0 TO 25                                && Loop to add drives
					lcDrive = CHR(lnDriveID+65) + ":"
					lnIcon  = DRIVETYPE(lcDrive)
					IF lnIcon > 1
						lcDriveName = thisform.GetVolumeName(lcDrive,lnIcon)
						lnRow = .AddListItem(lnRow,lnIcon,lcDriveName,lcDrive)
					ENDIF
				ENDFOR
			ENDWITH

		CASE tcMode = "SELECTED DIRECTORY"
*-*			Display the current directory hierarchy in combobox drop-down
			lnSelRow = 3
			WITH .cboFolderList
				lnRow = .AddListItem(0,"DeskTop",thisform.DesktopPath,7,0)
				lnRow = .AddListItem(lnRow,"My Documents",thisform.MyDocPath,10,1)
				lnRow = .AddListItem(lnRow,thisform.ComputerName,thisform.ComputerName,8,1)
				FOR lnDriveID=0 TO 25                                && Loop to add drives
					lcDrive = CHR(lnDriveID+65) + ":"
					lnIcon  = DRIVETYPE(lcDrive)
					IF lnIcon > 1
						lcDriveName = thisform.GetVolumeName(lcDrive,lnIcon)
						lnRow = .AddListItem(lnRow,lcDriveName,lcDrive,lnIcon,2)
						IF GETWORDNUM(tcSelDirectory,1,"\") = lcDrive
							lnIndent   = 2                           && Add the selected folder levels
							lnNumPath  = GETWORDCOUNT(tcSelDirectory,"\")
							lcFullPath = lcDrive
							FOR lnPath=2 TO lnNumPath
								lnIndent   = lnIndent + 1
								lcPath     = GETWORDNUM(tcSelDirectory,lnPath,"\")
								lcFullPath = ADDBS(lcFullPath) + lcPath
								lnRow      = .AddListItem(lnRow,lcPath,lcFullPath,1,lnIndent)
							ENDFOR
							lnSelRow = lnRow
						ENDIF
					ENDIF
				ENDFOR
				FOR lnNdx=1 TO lnNumDeskFldrs                        && Add the folders attached to the desktop
					IF laDesktopList[lnNdx,1] != "." .AND. ATC("D",laDesktopList[lnNdx,5]) > 0
						lnRow = .AddListItem(lnRow,laDesktopList[lnNdx,1],ADDBS(thisform.DesktopPath)+laDesktopList[lnNdx,1],1,1)
					ENDIF
				ENDFOR
				.ComboItems(lnSelRow).Selected = True
			ENDWITH
*-*			Display the current directory listing
			tcSelDirectory = ADDBS(tcSelDirectory)
			WITH .grdCurrentDirectoryList
				lnRow = 0
				FOR lnNdx=1 TO lnNumFolders
					IF laDirectoryList[lnNdx,1] != "." .AND. ATC("D",laDirectoryList[lnNdx,5]) > 0
						lnRow = .AddListItem(lnRow,1,laDirectoryList[lnNdx,1],tcSelDirectory+laDirectoryList[lnNdx,1])
					ENDIF
				ENDFOR
			ENDWITH
	ENDCASE
	.cboFolderList.Refresh()
	WITH .grdCurrentDirectoryList
		.LockState = False
		.SetFocus()
	ENDWITH
ENDWITH
ENDPROC
PROCEDURE getvolumename
LPARAMETERS tcDrive,tnType
LOCAL lcVolumeName, lnVolumeNameSize, lnVolumeSerial, lnMaxCompLength, lnFileSysFlag, lcFileSysNameBuf
LOCAL lnFileSysNameSize, lnReturn
tcDrive = ADDBS(tcDrive)
lcVolumeName      = SPACE(256)
lnVolumeNameSize  = 256
lnVolumeSerial    = 0
lnMaxCompLength   = 256
lnFileSysFlag     = 0
lcFileSysNameBuf  = SPACE(256)
lnFileSysNameSize = 256
lnReturn = GetVolumeInformation(@tcDrive,@lcVolumeName,lnVolumeNameSize,@lnVolumeSerial,@lnMaxCompLength,@lnFileSysFlag,@lcFileSysNameBuf,lnFileSysNameSize)
lcVolumeName = ALLTRIM(lcVolumeName," ",CHR(0))
IF EMPTY(lcVolumeName)
	DO CASE
		CASE tnType = 2                      && Floppy disk
			lcVolumeName = "Floppy Disk"
		CASE tnType = 3                      && Hard disk
			lcVolumeName = "Local Disk"
		CASE tnType = 4                      && Removable drive OR network drive
			lcVolumeName = "Removable Disk"
		CASE tnType = 5                      && CD-ROM
			lcVolumeName = "CD-ROM"
	ENDCASE
ENDIF
lcVolumeName = lcVolumeName + " (" + tcDrive + ")"
RETURN lcVolumeName
ENDPROC
PROCEDURE Load
IF !PEMSTATUS(_SCREEN.GKKTools,"LastDirectory",5)
	ADDPROPERTY(_SCREEN.GKKTools,"LastDirectory",ADDBS(SYS(5) + SYS(2003)))
ENDIF
ENDPROC
PROCEDURE Init
LPARAMETERS tcCaption
LOCAL lnSize, lcBuffer, lcMode
lnSize   = 100
lcBuffer = SPACE(lnSize)
GetComputerName(@lcBuffer, @lnSize)
WITH thisform
	.Caption      = tcCaption
	.ComputerName = ALLTRIM(lcBuffer," ",CHR(0))
	.DesktopPath  = GKTGetRegString_HKCU("SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders","Desktop")
	.MyDocPath    = GKTGetRegString_HKCU("SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders","Personal")
	DO CASE
		CASE UPPER(_SCREEN.GKKTools.LastDirectory) = UPPER(.DesktopPath)
			lcMode = "DESKTOP"
		CASE UPPER(_SCREEN.GKKTools.LastDirectory) = UPPER(.MyDocPath)
			lcMode = "MY DOCUMENTS"
		CASE UPPER(_SCREEN.GKKTools.LastDirectory) = UPPER(.ComputerName)
			lcMode = UPPER(.ComputerName)
		OTHERWISE
			lcMode = "SELECTED DIRECTORY"
	ENDCASE
	.GetDirectory(lcMode, _SCREEN.GKKTools.LastDirectory)
ENDWITH
ENDPROC
PROCEDURE Activate
SET CURSOR ON
ENDPROC
PROCEDURE Unload
RETURN thisform.RtnValue
ENDPROC
     ����    �  �                        P�   %   �      -  $   �          �  U  :  ��  �0 ��C� SELECTED DIRECTORYC �  � � � � � �� U  TNCMDBUTTON THISFORM GETDIRECTORY THIS CMDCOLLECTION TOOLTIPTEXT|' ��  � � � � � � � � � ��	 �������	 ��C���& T� �C� Form� FavoritePlaces�
 �� %�C� ����� T� �� �� +�a���� T�  �� PlaceC� _��[ T� �C�F SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\comdlg32\PlacesBar\ �  � �� %�C� ���� !� � +�C� %� �� ���� T� �C� � %� %���� T� �C� 5�� T� �C� %� ���� T� �C� %� ����  T� �C� � � � �� [�� � T� �C� C� \� ��\�� ��C �  � � � �� T� �� ��� � �u� �� ���(�C� � |����q� T�  �C� � � |���� T� �C�  �� >���� T� �C�  �� >���� ��C �  � � � �� �� � U  LCPLACE LCKEY LNCNT LCENV LNBEG LNEND LCNAME LCFAVORITES LNPLACE LAPLACES GKTGETSTRING_VFP GKTGETREGSTRING_HKCU THIS ADDCMDBUTTON usercmdclick,     �� Init�     ��1 q 2 q1� a� � � ��� A A ��� aaA �QA � �qqqQA A 1                       �         �   n      )   �                       J���    1  1                        ��   %   L      �     �          �  U   ��  � H� �� �  �C� � � f� DESKTOP��H � T�  �� DESKTOP��% �C� � � f� MY DOCUMENTS��� � T�  �� MY DOCUMENTS�� �C� � � fC� � f��� � T�  �C� � f�� 2�� � T�  �� SELECTED DIRECTORY�� �! ��C �  C� � � � � � � �� U	  LCMODE THIS SELECTEDITEM TEXT THISFORM COMPUTERNAME GETDIRECTORY ITEMLIST INDEX  T�  � � �-�� U  THISFORM LABEL1 FONTBOLD$  T�  � �� � �� T�  � �a�� U  THIS	 IMAGELIST THISFORM	 OLEIMAGES LOCKED  T�  � � �a�� U  THISFORM LABEL1 FONTBOLD Click,     ��	 LostFocus�    �� Init�    �� GotFocus    ��1 q � AQ��!� �A 2 2 1� 2 1                       �        �  �          :        Y  x      )   1                       '���                              h�   %   5	      u
  ]   �	          �  U  @ ��  � � � � �� � %��  � ��9� H�8 ��( �CC �  �� � � f� DESKTOP��t � T� �� DESKTOP��- �CC �  �� � � f� MY DOCUMENTS��� � T� �� MY DOCUMENTS��& �CC �  �� � � fC� �	 f��� � T� �C� �	 f�� 2�� T� �� SELECTED DIRECTORY�� � ��C � C �  � � � �
 �� � U  TNROW NCOLUMNINDEX BONTEXT
 BONPICTURE LCMODE THIS LISTITEM TEXT THISFORM COMPUTERNAME GETDIRECTORY ITEMLIST  ��  � %��  � �� � � U 	 NROWINDEX� ��  � �� � � � � ��� ���� %��  ���� T� �a�� �� ���(�C�� ����� �, %�CC � �� fCCC�� �	 ��� �
 �f��� �2 T� ��% The entered directory already exists.��* ��C � � System Message�� ERROR� �� T� �-�� !� � �� %�� ���� �� ��� �	 ��) T�� ��� �	 ��CC�� �	 ��� �
 ���  T� �� � � C�� �	 �� ��
 ��� �� ��C�� �	 ��� �� ��� ��C�� �	 ��� � �� � ��� ��C�� �	 ��� � �� � �� U  BSAVED LLDIROK LNNDX	 LCUSERMSG LCDIRECTORY THIS ITEMLIST LISTITEM ROWS COUNT TEXT
 GKTWMSGBOX THISFORM LBLCURRENTFOLDER TOOLTIPTEXT ONITEMLDOUBLECLICK REMOVE#  ��  � � %�� � �� � � U  CSEARCHSTRING	 NROWINDEXI ���  ��B� ��C��� � �� ��C��� ��O � T�� ���� T�� � ���� �� ��C��� ��� � T�� ��  � �2�� T�� � ���� �� T�� � ���� T�� �-�� T��	 �a�� T��
 �-�� T�� ���� T�� �a�� T�� �-��! ��C��C�� � � � �� ��! ��C��C�� � � � �� ��! ��C��C�� � � � �� ��! ��C��C�� � � � �� ��! ��C��C�� � � � �� ��! ��C��C�� � � � �� ��! ��C��C�� � � � �� ��! ��C��C�� � � � �� ��! ��C�	�C�	� � � � �� ��! ��C�
�C�
� � � � �� �� T�� ��
�� �� U  THIS COLUMNS ADD WIDTH DEFAULTS CONTENTTYPE ROWS HEIGHT HEADERVISIBLE INCREMENTALSEARCH MULTIPLESELECTION KEYPRESSBOUNDCOLUMN ALWAYSSHOWSELECTION HORIZONTALSCROLLBARSHOWABLE
 SETPICTURE THISFORM	 OLEIMAGES
 LISTIMAGES PICTURE PICTURECOUNT�  ��  � � � � ��� ��� � T�  ��  ��� ��C�� � �� T�� ��  ����� �� �� T�� ��  �����	 �� �� ��
 ��  �� T��
 ��  ��� �� ��	 B��  �� U  TNROW	 TNPICTURE TCTEXT
 TCFULLTEXT THIS ROWS ADD LISTITEM PICTUREINDEX TEXT ITEMLIST OnItemLDoubleClick,     �� AfterRowChanged�    �� OnEndOfItemEdit    �� OnItemFound�    �� Init�    �� addlistitem'    ��1 1q � �A��a!� �A �A 2 q B 2 q 1� � � ��!�� A A A � !�� Q� �A � �A A 2 � B 2 � !� A !QA � � � � � � � A 2 1� � ��� AA � 1                               .  �        �  �     0   �  C  4   4   ^  `
  :   R   �
  �  Y    )                           ����    �   �                         ;   %   D       Y      S           �  U  
  <�  � U  THISFORM Click,     ��1 q 1                       !       )   �                        ���    f  f                        ��   %   �         	             �  U  r  ���  ��k �( %�C�� � �
� C�� fC�� � f	��g � T�9� � �C�� � ���� T�� ��� � �� <�  � � �� U  THISFORM LBLCURRENTFOLDER TOOLTIPTEXT COMPUTERNAME GKKTOOLS LASTDIRECTORY RTNVALUE Click,     ��1 � ��!q A A 1                       '      )   f                        "  ..\programs\gktdefines.h��|0?      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      dTop = 7
Left = 4
Width = 87
Height = 275
TabIndex = 7
Name = "Sidebar1"
Line1.Name = "Line1"
      GKTSELECTDIR      Sidebar1      	container      ..\classes\gktoutlookbar.vcx      sidebar      .OLEObject = C:\WINDOWS\system32\MSCOMCTL.OCX
      UTop = 7
Left = 161
Height = 24
Width = 366
TabIndex = 4
Name = "cboFolderList"
      GKTSELECTDIR      cboFolderList      
olecontrol      ..\classes\gktitemlist.vcx      	imagelist      GKTSELECTDIR      label     �_memberdata = <VFPData><memberdata name="AutoCenter" type="property" display="AutoCenter"/><memberdata name="BorderStyle" type="property" display="BorderStyle"/><memberdata name="Caption" type="property" display="Caption"/><memberdata name="computername" type="property" display="ComputerName"/><memberdata name="currentdirectory" type="property" display="CurrentDirectory" proptype="ShortText"/><memberdata name="Desktop" type="property" display="Desktop"/><memberdata name="desktoppath" type="property" display="DesktopPath" proptype="ShortText"/><memberdata name="DoCreate" type="property" display="DoCreate"/><memberdata name="getdirectory" type="method" display="GetDirectory"/><memberdata name="getvolumename" type="method" display="GetVolumeName"/><memberdata name="Height" type="property" display="Height"/><memberdata name="Icon" type="property" display="Icon"/><memberdata name="MaxButton" type="property" display="MaxButton"/><memberdata name="MinButton" type="property" display="MinButton"/><memberdata name="mydocpath" type="property" display="MyDocPath" proptype="ShortText"/><memberdata name="Name" type="property" display="Name"/><memberdata name="rtnvalue" type="property" display="RtnValue" proptype="LongText"/><memberdata name="ShowTips" type="property" display="ShowTips"/><memberdata name="ShowWindow" type="property" display="ShowWindow"/><memberdata name="Width" type="property" display="Width"/><memberdata name="WindowType" type="property" display="WindowType"/></VFPData>
FormDescription =
UserNotes =      &_memberdata XML Metadata for customizable properties
computername Computer Name
currentdirectory Current directory
desktoppath User Desktop path
mydocpath User My Documents Path
rtnvalue RtnValue
*getdirectory Gets a list of the subdirectories
*getvolumename Gets the drive volume name
      label      label      Label1      GKTSELECTDIR      �AutoSize = .T.
FontBold = .F.
BackStyle = 0
Caption = "Look in:"
Height = 17
Left = 105
Top = 13
Width = 45
TabIndex = 9
Name = "Label1"
      label      label      Label4      GKTSELECTDIR      �AutoSize = .T.
FontBold = .F.
BackStyle = 0
Caption = "Selected Folder:"
Height = 17
Left = 105
Top = 39
Width = 91
TabIndex = 10
Name = "Label4"
      ..\classes\gktbaseclasses.vcx      commandbutton      cmdUpFolder      GKTSELECTDIR      �Top = 9
Left = 532
Height = 22
Width = 22
Picture = ..\graphics\folderback.bmp
Caption = ""
TabIndex = 5
ToolTipText = "Up one folder"
Name = "cmdUpFolder"
     ^PROCEDURE Click
LOCAL lcMode
WITH thisform.cboFolderList
	DO CASE
		CASE .SelectedItem.Index = 1
			lcMode = ""
		CASE UPPER(.ComboItems(.SelectedItem.Index-1).Text) = "DESKTOP"
			lcMode = "DESKTOP"
		CASE UPPER(.ComboItems(.SelectedItem.Index-1).Text) = "MY DOCUMENTS"
			lcMode = "MY DOCUMENTS"
		CASE UPPER(.ComboItems(.SelectedItem.Index-1).Text) = UPPER(thisform.ComputerName)
			lcMode = UPPER(thisform.ComputerName)
		OTHERWISE
			lcMode = "SELECTED DIRECTORY"
	ENDCASE
	IF !EMPTY(lcMode)
		thisform.GetDirectory(lcMode, .ItemList[.SelectedItem.Index-1])
	ENDIF
ENDWITH
ENDPROC
     ����    �  �                        l,   %         B               �  U  m ��  � ��� � ��f� H�$ �-� ��� � ���F � T�  ��  ��* �CC�� � ��� � f� DESKTOP��� � T�  �� DESKTOP��/ �CC�� � ��� � f� MY DOCUMENTS��� � T�  �� MY DOCUMENTS��( �CC�� � ��� � fC� � f��� T�  �C� � f�� 2�-� T�  �� SELECTED DIRECTORY�� � %�C�  �
��b�! ��C �  C�� � ���	 � � �� � �� U
  LCMODE THISFORM CBOFOLDERLIST SELECTEDITEM INDEX
 COMBOITEMS TEXT COMPUTERNAME GETDIRECTORY ITEMLIST Click,     ��1 q � Q� �A���!� �A A A 1                       S      )   �                        ..\classes\gktbaseclasses.vcx      _commandbutton      commandbutton      	cmdSelect      GKTSELECTDIR      �Top = 257
Left = 226
Height = 26
Width = 100
Caption = "Select"
Default = .F.
TabIndex = 2
SpecialEffect = 0
Name = "cmdSelect"
     2PROCEDURE Click
WITH thisform
	IF !EMPTY(.lblCurrentFolder.ToolTipText) .AND. UPPER(.ComputerName) != UPPER(.lblCurrentFolder.ToolTipText)
		_SCREEN.GKKTools.LastDirectory = ADDBS(.lblCurrentFolder.ToolTipText)
		.RtnValue = .lblCurrentFolder.ToolTipText
		RELEASE thisform
	ENDIF
ENDWITH
ENDPROC
      zBackStyle = 0
Caption = "lblCurrentFolder"
Left = 202
Top = 39
Width = 352
TabIndex = 12
Name = "lblCurrentFolder"
      lblCurrentFolder      ..\classes\gktlabel.vcx      lbllabel      .OLEObject = C:\WINDOWS\system32\BBLIST~1.OCX
      `Top = 60
Left = 99
Height = 192
Width = 455
TabIndex = 1
Name = "grdCurrentDirectoryList"
      GKTSELECTDIR      
olecontrol      ..\classes\gktbaseclasses.vcx      _commandbutton      commandbutton      	cmdCancel      GKTSELECTDIR      zTop = 257
Left = 326
Height = 26
Width = 100
Caption = "Cancel"
TabIndex = 3
SpecialEffect = 0
Name = "cmdCancel"
      ,PROCEDURE Click
RELEASE thisform
ENDPROC
      grdCurrentDirectoryList      ..\classes\gktbblistview.vcx      
bblistview      .OLEObject = C:\WINDOWS\system32\MSCOMCTL.OCX
      GKTSELECTDIR      	OleImages      
olecontrol      
olecontrol      DTop = 254
Left = 525
Height = 43
Width = 49
Name = "OleImages"
     , ��ࡱ�                >  ��	                               ����        ����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������      ������������������������                           ��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������R o o t   E n t r y                                               ��������                               �8+0�b�   �        O l e O b j e c t D a t a                                            ����                                       �       A c c e s s O b j S i t e D a t a                             &  ������������                                        \        C h a n g e d P r o p s                                         ������������                                       =          ����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������\                          $   8                       9368265E-85FE-11d1-8BE3-0000F8754DA1$   8                       9368265E  �   ImageHeight 	   I
         ImageWidth 	   I
       0 #$,����j ��(6(!C4       �~��        ��� ��  �ͫ   H�%    ����  �    
      C l s d F o l d    F l o p p y    H D d r i v e    N k D r i v e    C D R O M    F i l e I c o n    D e s k t o p 
   M y C o m p u t e r 	   M y N e t w o r k    M y D o c u m e n t s   (   lt  >       s   P ��� Ǳ� ��� �k� sH� W%� U � I � = � 1 � % s  P ��� �� Ԏ� �k� �H� �%� � � � � z � b � J s 2 P ��� ��� ��� �k� �H� �%� � � � � � � � � s s P P ��� ��� ��� �k� �H� �%� � � � � � z � b s J P 2 ��� ��� ��� �k� �Hs �%W � U � I � = � 1 s % P  ��� ��� ��� �kk �HH �%% �   �   �   �   s   P   ��� �Ǳ ��� ��k �sH �W% �U  �I  �=  �1  s%  P  ��� �� �Ԏ ��k ��H ��% ��  ܒ  �z  �b  sJ  P2  ��� ��� ��� ��k ��H ��% ��  ��  ��  ��  ss  PP  ��� ��� ��� ��k ��H ��% ��  ��  z�  b�  Js  2P  ��� ��� ��� ��k s�H W�% U�  I�  =�  1�  %s  P  ��� ��� ��� k�k H�H %�%  �   �   �   �   s   P  ��� ��� ��� k�� H�s %�W  �U  �I  �=  �1  s%  P ��� ��� ��� k�� H�� %��  ��  ܒ  �z  �b  sJ  P2 ��� ��� ��� k�� H�� %��  ��  ��  ��  ��  ss  PP ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� zzz nnn bbb VVV JJJ >>> 222 &&&   ��� ��� ���   �  �   �� �   � � ��  ���   �������������  �����������������������������������������������������������ッ���������������������������������낂�������������⃃�������� ���������vv���  �����������     ����������      ���������   �  �                                           �   �  �  �  ���p������p������p wwwwwwp                                        ��  ��  �                         �   �  ��  ��  ��  ��  ��     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���           �:�   ��2�`  ��2�h  ���,f� xx�,h����p*� xx�PQ����*��xxp
���x��� hf�x�x  �l#x��  �#x��   �x�          �  �  �  �  �                          �  �  �  �  �     lt  ~          h     (                @                        �  �   �� �   � � ��  ��� ��� �ʦ ��� ��� ��� k�� H�� %��  ��  ��  z�  b�  Js  2P ��� ��� ��� k�� Hs� %W�  U�  I�  =�  1�  %s  P ��� ��� ��� kk� HH� %%�   �   �   �   �   s   P ��� Ǳ� ��� �k� sH� W%� U � I � = � 1 � % s  P ��� �� Ԏ� �k� �H� �%� � � � � z � b � J s 2 P ��� ��� ��� �k� �H� �%� � � � � � � � � s s P P ��� ��� ��� �k� �H� �%� � � � � � z � b s J P 2 ��� ��� ��� �k� �Hs �%W � U � I � = � 1 s % P  ��� ��� ��� �kk �HH �%% �   �   �   �   s   P   ��� �Ǳ ��� ��k �sH �W% �U  �I  �=  �1  s%  P  ��� �� �Ԏ ��k ��H ��% ��  ܒ  �z  �b  sJ  P2  ��� ��� ��� ��k ��H ��% ��  ��  ��  ��  ss  PP  ��� ��� ��� ��k ��H ��% ��  ��  z�  b�  Js  2P  ��� ��� ��� ��k s�H W�% U�  I�  =�  1�  %s  P  ��� ��� ��� k�k H�H %�%  �   �   �   �   s   P  ��� ��� ��� k�� H�s %�W  �U  �I  �=  �1  s%  P ��� ��� ��� k�� H�� %��  ��  ܒ  �z  �b  sJ  P2 ��� ��� ��� k�� H�� %��  ��  ��  ��  ��  ss  PP ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� zzz nnn bbb VVV JJJ >>> 222 &&&   ��� ��� ���   �  �   �� �   � � ��  ���                    ����������      ��   � �      ��������      �� �   �      ��������      ��   � �      ��������      �� �   �      ��������      ��   � �      ��������      ��  �         ����� ��      ������� �                    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� �       �f����f`~o��wwn`v�   wv`����ww`����ww������w����w���� ������;0w`v��s�`vg��;0n`~f��s`vfgww;0p     q       x                                                         ��  ��     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���         wwwwp �Gwww�0 ��wwxxp G�8�  �        �wwww� xffffp�vffflt�x��ftxx�~�ft�xw~vftwx�w�l�wx�  twwwwwwt DDDDDD@�   �   �   �   �  �   �   �   �   �   �   �   �   �   �   �  	   lt  >  w0:w:w�9wD;wH�w    ��@           �w    ��@       �8            �  T a h o m a                                                               ����         ��;w`:w0:w:w�9wD;wH�w    T�@           �w    T�@       �8            �  T a h o m a                                                               ����         +��;w`:w0:w:w#$,����j ��(6(!C4       �~��   �     ��� ��  �ͫ   H�%    ����  �    
      C l s d F o l d    F l o p p y    H D d r i v e    N k D r i v e    C D R O M    F i l e I c o n    D e s k t o p 
   M y C o m p u t e r 	   M y N e t w o r k    M y D o c u m e n t s 
      lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���                         wwwwwww ������ ������ ������ ������ ������ ������ ������ ������ x���www ���     wwp            ��  ��  �                                ��  ��  ��     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���         wwwwwww x������pxwp w�px��wx��px������p������p������p www����    �  �    �  �    ����    ����    ����    ����    ���̀                         �   �   �   �   �   �   �   �   �      lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���                         wwwwwww x������pxwwwww�px������px������p������p������p wwwwwwp                                        ��  ��  �                         �   �  ��  ��  ��  ��  ��     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���                         wwwwwww x������pxwwwww�px������px������p������p������p wwwwwwp                                        ��  ��  �                         �   �  ��  ��  ��  ��  ��     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���           �:�   ��2�`  ��2�h  ���,f� xx�,h����p*� xx�PQ����*��xxp
���x��� hf�x�x  �l#x��  �#x��   �x�          �  �  �  �  �                          �  �  �  �  �     lt  ~          h     (                @                        �  �   �� �   � � ��  ��� ��� �ʦ ��� ��� ��� k�� H�� %��  ��  ��  z�  b�  Js  2P ��� ��� ��� k�� Hs� %W�  U�  I�  =�  1�  %s  P ��� ��� ��� kk� HH� %%�   �   �   �   �   s   P ��� Ǳ� ��� �k� sH� W%� U � I � = � 1 � % s  P ��� �� Ԏ� �k� �H� �%� � � � � z � b � J s 2 P ��� ��� ��� �k� �H� �%� � � � � � � � � s s P P ��� ��� ��� �k� �H� �%� � � � � � z � b s J P 2 ��� ��� ��� �k� �Hs �%W � U � I � = � 1 s % P  ��� ��� ��� �kk �HH �%% �   �   �   �   s   P   ��� �Ǳ ��� ��k �sH �W% �U  �I  �=  �1  s%  P  ��� �� �Ԏ ��k ��H ��% ��  ܒ  �z  �b  sJ  P2  ��� ��� ��� ��k ��H ��% ��  ��  ��  ��  ss  PP  ��� ��� ��� ��k ��H ��% ��  ��  z�  b�  Js  2P  ��� ��� ��� ��k s�H W�% U�  I�  =�  1�  %s  P  ��� ��� ��� k�k H�H %�%  �   �   �   �   s   P  ��� ��� ��� k�� H�s %�W  �U  �I  �=  �1  s%  P ��� ��� ��� k�� H�� %��  ��  ܒ  �z  �b  sJ  P2 ��� ��� ��� k�� H�� %��  ��  ��  ��  ��  ss  PP ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� zzz nnn bbb VVV JJJ >>> 222 &&&   ��� ��� ���   �  �   �� �   � � ��  ���                    ����������      ��   � �      ��������      �� �   �      ��������      ��   � �      ��������      �� �   �      ��������      ��   � �      ��������      ��  �         ����� ��      ������� �                    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� �       �f����f`~o��wwn`v�   wv`����ww`����ww������w����w���� ������;0w`v��s�`vg��;0n`~f��s`vfgww;0p     q       x                                                         ��  ��     lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���         wwwwp �Gwww�0 ��wwxxp G�8�  �        �wwww� xffffp�vffflt�x��ftxx�~�ft�xw~vftwx�w�l�wx�  twwwwwwt DDDDDD@�   �   �   �   �  �   �   �   �   �   �   �   �   �   �   �  	   lt  >         (     (                �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���  DDDD@  �����@  �w�@  �    ~~p ��p   �����  ��~v�   ��w��DDD������������p��x���  ���G�H*"�G~H��"��H "�"(wwx  ��    �             �9   3   7                      �   �   �   ��  
   lt  ~          h     (                @                        �  �   �� �   � � ��  ��� ��� �ʦ ��� ��� ��� k�� H�� %��  ��  ��  z�  b�  Js  2P ��� ��� ��� k�� Hs� %W�  U�  I�  =�  1�  %s  P ��� ��� ��� kk� HH� %%�   �   �   �   �        �PROCEDURE OnItemLDoubleClick
LPARAMETERS tnRow, ncolumnindex, bontext, bonpicture
LOCAL lcMode
IF tnRow > 0
	DO CASE
		CASE UPPER(this.ListItem(tnRow,2).Text) = "DESKTOP"
			lcMode = "DESKTOP"
		CASE UPPER(this.ListItem(tnRow,2).Text) = "MY DOCUMENTS"
			lcMode = "MY DOCUMENTS"
		CASE UPPER(this.ListItem(tnRow,2).Text) = UPPER(thisform.ComputerName)
			lcMode = UPPER(thisform.ComputerName)
		OTHERWISE
			lcMode = "SELECTED DIRECTORY"
	ENDCASE
	thisform.GetDirectory(lcMode, this.ItemList[tnRow])
ENDIF
ENDPROC
PROCEDURE AfterRowChanged
LPARAMETERS nrowindex
IF nrowindex > 0
*	thisform.FileName.value = thisform.FileList[nrowindex,1]
ENDIF
ENDPROC
PROCEDURE OnEndOfItemEdit
LPARAMETERS bsaved
LOCAL llDirOK, lnNdx, lcUserMsg, lcDirectory
WITH this
	IF bsaved
		llDirOK = True
		FOR lnNdx=1 TO ALEN(.ItemList,1)
			IF UPPER(.ItemList[lnNdx]) == UPPER(ALLTRIM(.ListItem(.Rows.Count,1).Text))
				lcUserMsg = "The entered directory already exists."
				=GKTWMSGBOX(lcUserMsg,"System Message",16,"ERROR")
				llDirOK = False
				EXIT
			ENDIF
		ENDFOR
		IF llDirOK
			DIMENSION .ItemList[.Rows.Count]
			.ItemList[.Rows.Count] = ALLTRIM(.ListItem(.Rows.Count,1).Text)
			lcDirectory = thisform.lblCurrentFolder.ToolTipText + .ItemList[.rows.count]
			MKDIR (lcDirectory)
			.OnItemLDoubleClick(.Rows.Count,1)
		ELSE
			.Rows.Remove(.Rows.Count,1)
		ENDIF
	ELSE
		.Rows.Remove(.Rows.Count,1)
	ENDIF
ENDWITH
ENDPROC
PROCEDURE OnItemFound
LPARAMETERS csearchstring, nrowindex
IF nrowindex > 0
*	thisform.FileName.value = this.ItemList[nrowindex]
ENDIF
ENDPROC
PROCEDURE Init
WITH this
	.Columns.Add(2)
	WITH .Columns(1)
		.Width = 20
		.Defaults.ContentType = 2
	ENDWITH
	WITH .Columns(2)
		.Width = this.width - 50
		.Defaults.ContentType = 1
	ENDWITH
	.Rows.Height       = 18
	.HeaderVisible     = False
	.IncrementalSearch = True
	.MultipleSelection = False
	.KeyPressBoundColumn = 2
	.AlwaysShowSelection = True
	.HorizontalScrollBarShowable = False
	.SetPicture(1,4,thisform.OleImages.ListImages(1).Picture)
	.SetPicture(2,4,thisform.OleImages.ListImages(2).Picture)
	.SetPicture(3,4,thisform.OleImages.ListImages(3).Picture)
	.SetPicture(4,4,thisform.OleImages.ListImages(4).Picture)
	.SetPicture(5,4,thisform.OleImages.ListImages(5).Picture)
	.SetPicture(6,4,thisform.OleImages.ListImages(6).Picture)
	.SetPicture(7,4,thisform.OleImages.ListImages(7).Picture)
	.SetPicture(8,4,thisform.OleImages.ListImages(8).Picture)
	.SetPicture(9,4,thisform.OleImages.ListImages(9).Picture)
	.SetPicture(10,4,thisform.OleImages.ListImages(10).Picture)
	.PictureCount = 10
ENDWITH
ENDPROC
PROCEDURE addlistitem
LPARAMETERS tnRow,tnPicture,tcText,tcFullText
WITH this
	tnRow = tnRow + 1
	.Rows.Add()
	.ListItem(tnRow,1).PictureIndex = tnPicture
	.ListItem(tnRow,2).Text = tcText
	DIMENSION .ItemList[tnRow]
	.ItemList[tnRow] = tcFullText
ENDWITH
RETURN tnRow
ENDPROC
     yPROCEDURE usercmdclick
LPARAMETERS tnCmdButton
thisform.GetDirectory("SELECTED DIRECTORY",this.CmdCollection(tnCmdButton).TooltipText)
ENDPROC
PROCEDURE Init
LOCAL lcPlace, lcKey, lnCnt, lcEnv, lnBeg, lnEnd, lcName, lcFavorites, lnPlace
LOCAL ARRAY laPlaces[1,2]
DODEFAULT()
lcFavorites = GKTGetString_VFP("Form","FavoritePlaces")
IF EMPTY(lcFavorites)
	lnCnt = 0
	DO WHILE True
		lcPlace = "Place" + TRANSFORM(lnCnt)
		lcKey = GKTGetRegString_HKCU("SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\comdlg32\PlacesBar\",lcPlace)
		IF EMPTY(lcKey)
			EXIT
		ENDIF
		DO WHILE ATC("%",lcKey) > 0
			lcEnv = STREXTRACT(lcKey,"%","%")
			lcEnv = GETENV(lcEnv)
			lnBeg = ATC("%",lcKey,1)
			lnEnd = ATC("%",lcKey,2)
			lcKey = STUFF(lcKey,lnBeg,lnEnd-lnBeg+1,lcEnv)
		ENDDO
		lcName = SUBSTR(lcKey,RATC("\",lcKey)+1)
		this.AddCmdButton(lcName,lcKey)
		lnCnt = lnCnt + 1
	ENDDO
ELSE
	FOR lnPlace=1 TO GETWORDCOUNT(lcFavorites,"|")
		lcPlace = GETWORDNUM(lcFavorites,lnPlace,"|")
		lcName  = GETWORDNUM(lcPlace,1,">")
		lcKey   = GETWORDNUM(lcPlace,2,">")
		this.AddCmdButton(lcName,lcKey)
	ENDFOR
ENDIF
ENDPROC
     �PROCEDURE Click
LOCAL lcMode
DO CASE
	CASE UPPER(this.SelectedItem.Text) = "DESKTOP"
		lcMode = "DESKTOP"
	CASE UPPER(this.SelectedItem.Text) = "MY DOCUMENTS"
		lcMode = "MY DOCUMENTS"
	CASE UPPER(this.SelectedItem.Text) = UPPER(thisform.ComputerName)
		lcMode = UPPER(thisform.ComputerName)
	OTHERWISE
		lcMode = "SELECTED DIRECTORY"
ENDCASE
thisform.GetDirectory(lcMode, this.ItemList[this.SelectedItem.Index])
ENDPROC
PROCEDURE LostFocus
thisform.label1.FontBold = False
ENDPROC
PROCEDURE Init
this.ImageList = thisform.OleImages
this.Locked = True
ENDPROC
PROCEDURE GotFocus
thisform.label1.FontBold = True
ENDPROC
     
 ��ࡱ�                >  ��	                               ����        ��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������R o o t   E n t r y                                               ��������                               ��-0�b�   @       O l e O b j e c t D a t a                                            ����                                        H        A c c e s s O b j S i t e D a t a                             &  ������������                                       8        C h a n g e d P r o p s                                         ������������                                       C          ����   ��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������#.�����  �{N�  /  �                            8                              8                       5 4 9 E   �   FullRowSelection    L      AlwaysShowSelection    L   ...I N N T \ S y s t e m 3 2 \ L M R T . d l l   L M   R u     i m e   C o n t r o l 	 { 1 8 3 C 2 5 9 A - 0 4 8 0 - 1 1 d 1 - 8 7 E A - 0 0 C 0 4 F C 2 9 D 4 6 }   C : \ W I N N T \ S y s t e m 3 2 \ L M R T . d l l   M i c r o s o f t   M u l t i m e d i a   C o n t r o l ,   v e r s i o n   6 . 0 	 { C 1 A 8 A      
 ��ࡱ�                >  ��	                               ����        ��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������R o o t   E n t r y                                               ��������                               ��-0�b�   @       O l e O b j e c t D a t a                                            ����                                        ~        A c c e s s O b j S i t e D a t a                             &  ������������                                       \        C h a n g e d P r o p s                                         ������������                                       '             ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������f��ݔ���j ��(6(!C4   �%  {  $�U   >           �ͫ   �kSw\                          $   8                       9368265E-85FE-11d1-8BE3-0000F8754DA1    ��      ��      4�      v�        �   Text    H       cboFolderList T�      z�      �      o   �  �8�%    c b o F o l d e r L i s t     ��  ��   v�      D�      
�      ��      ��      l     B�      
�      ��      z     ��      ��      ��      ��      �      �      �|           0M      $�      $�      ��      n�      $�           ����    �  �                        �   %   �        �   V          �  U  � ��  � �+ �� � � � � � � �	 �
 � � �� � � � �1 �� ���� ���� ���� ������� ��� ���� T�� �� �� T�� � �� �� ���� ��� � T�� �a�� ��C�� �� �� ���� ��� � ��C�� �� T�� �� �� ��' T� �C�� C�� ��� *.*� D����' T� �C�� C�� ��� *.*� D����& T� �C�� C� ��� *.*� D���� H�{��� ��  � DESKTOP��9� ���� ��O�( T� �C� � DeskTop� � �� �� ��. T� �C � � My Documents� � �
��� ��% T� �C � � � � � ���� �� ��	 �� �(������ T�
 �C�	 �A � :�� T� �C�
 ���� %�� ����� T� �C �
  � � �  ��" T� �C �  �  �
  � ��� �� � �� �� ���(�� ��6�3 %�C � �� � .� C� DC � �� �� 	��2�9 T� �C � C � �� C� � ��C � �� ���� �� � �� T��! ����" �a�� �� ���� ��5�* T� �C� �
� My Documents� � �� ��" T� �C � �� � � � �� �� �� ���(�� ��1�3 %�C � �� � .� C� DC � �� �� 	��-�6 T� �C � �C � �� C� � ��C � �� �� �� � �� �� ��  � MY DOCUMENTS���� ���� ���( T� �C� � DeskTop� � �� �� ��. T� �C � � My Documents� � �
��� ��% T� �C � � � � � ���� �� ��	 �� �(����n� T�
 �C�	 �A � :�� T� �C�
 ���� %�� ���j� T� �C �
  � � �  ��" T� �C �  �  �
  � ��� �� � �� �� ���(�� ����3 %�C � �� � .� C� DC � �� �� 	����9 T� �C � C � �� C� � ��C � �� ���� �� � �� T��! ����" �a�� �� ���� ���� T� �� �� �� ���(�� ����3 %�C � �� � .� C� DC � �� �� 	����6 T� �C � �C � �� C� � ��C � �� �� �� � �� �� ��  C�� f��@	� ���� ����( T� �C� � DeskTop� � �� �� ��. T� �C � � My Documents� � �
��� ��% T� �C � � � � � ���� �� ��	 �� �(������ T�
 �C�	 �A � :�� T� �C�
 ���� %�� ����� T� �C �
  � � �  ��" T� �C �  �  �
  � ��� �� � �� �� ���(�� ��t�3 %�C � �� � .� C� DC � �� �� 	��p�9 T� �C � C � �� C� � ��C � �� ���� �� � �� T��! ����" �a�� �� ���� ��<	� T� �� �� ��	 �� �(����8	� T�
 �C�	 �A � :�� T� �C�
 ���� %�� ���4	� T� �C �
  � � �  �� T� �C �  �  �  �
 �� �� � �� ��# ��  � SELECTED DIRECTORY���� T�# ���� ���� ����( T� �C� � DeskTop� � �� �� ��. T� �C � � My Documents� � �
��� ��% T� �C � � � � � ���� �� ��	 �� �(����[� T�
 �C�	 �A � :�� T� �C�
 ���� %�� ���W� T� �C �
  � � �  ��" T� �C �  �  �
  � ��� �� %�C� �� \���
 ��S� T� ���� T� �C� � \���� T�$ ��
 �� �� ���(�� ��B� T� �� ��� T� �C� � � \���� T�$ �C�$ ��� ��" T� �C �  �  �$ � � �� �� �� T�# �� �� � � �� �� ���(�� ����3 %�C � �� � .� C� DC � �� �� 	����9 T� �C � C � �� C� � ��C � �� ���� �� � �� T��! ��# ��" �a�� �� T� �C� ���� ���� ���� T� �� �� �� ���(�� ����3 %�C � �� � .� C� DC � �� �� 	����0 T� �C � �C � �� � C � �� �� �� � �� �� � ��C�� �% �� ���� ���� T�� �-�� ��C��& �� �� �� U'  TCMODE TCSELDIRECTORY LNNUMFOLDERS LNROW LNNDX	 LNNUMPATH LNPATH LCPATH LNINDENT	 LNDRIVEID LCDRIVE LCDRIVENAME LNICON LNNUMDESKFLDRS LNNUMMYDOCFLDRS LADIRECTORYLIST LADESKTOPLIST LAMYDOCLIST LCDRIVELIST THISFORM CURRENTDIRECTORY LBLCURRENTFOLDER CAPTION GRDCURRENTDIRECTORYLIST	 LOCKSTATE	 REMOVEALL CBOFOLDERLIST FOLDERLISTKEY DESKTOPPATH	 MYDOCPATH ADDLISTITEM COMPUTERNAME GETVOLUMENAME
 COMBOITEMS SELECTED LNSELROW
 LCFULLPATH REFRESH SETFOCUS� ��  � � �� � � � � � � �� �	 � T�  �C�  ���� T� �C� X�� T� �� �� T� �� �� T� �� �� T� �� �� T� �C� X�� T� �� ��. T�	 �C�  �  � � � � �  � �
 �� T� �C� �  C�  ��� %�C� ����� H���� �� ���0� T� �� Floppy Disk�� �� ���X� T� ��
 Local Disk�� �� ����� T� �� Removable Disk�� �� ����� T� �� CD-ROM�� � � T� �� �  (�  � )��	 B�� �� U  TCDRIVE TNTYPE LCVOLUMENAME LNVOLUMENAMESIZE LNVOLUMESERIAL LNMAXCOMPLENGTH LNFILESYSFLAG LCFILESYSNAMEBUF LNFILESYSNAMESIZE LNRETURN GETVOLUMEINFORMATIONZ & %�C�9�  � LastDirectory��h
��S �- ��C�9�  � LastDirectoryCC�]C��]��
�� � U  GKKTOOLS ��  � �� � � � T� ��d�� T� �C� X�� ��C� � � �� ��� ��� T�� ��  �� T�� �C� �  C�  ���\ T�� �C�@ SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders� Desktop�	 ��] T��
 �C�@ SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders� Personal�	 �� H�>��� �C�9� � fC�� f��m� T� �� DESKTOP�� �C�9� � fC��
 f���� T� �� MY DOCUMENTS�� �C�9� � fC�� f���� T� �C�� f�� 2��� T� �� SELECTED DIRECTORY�� � ��C � �9� � �� �� �� U 	 TCCAPTION LNSIZE LCBUFFER LCMODE GETCOMPUTERNAME THISFORM CAPTION COMPUTERNAME DESKTOPPATH GKTGETREGSTRING_HKCU	 MYDOCPATH GKKTOOLS LASTDIRECTORY GETDIRECTORY	  G] � U    B��  � �� U  THISFORM RTNVALUE getdirectory,     �� getvolumename    �� Load�    �� Init�    �� Activate�    �� Unload�    ��1 � �1� � � � � A � � � A qqa� �� ��Qq��!A A q1�A A QA � �!q1aA A A �� ��Qq��!A A q1�A A QA � � q1aA A A B� ��Qq��!A A q1�A A QA � � q���A A A 2� � ��Qq��!�� A� qqA!A � A A A q1�A A QA � � q1A A A A � � � � A A 2 � �� � � � � � ��� � �q�1A A �� 2 a�A 2 q � � � !� � ���� �A���� �A qA 2 a 2 � 1                       �     �     B  �   �   ]  �  �   �   �  g#  �   �   �#  �#  �   �   �#  �#  �    )   �                        _commandbuttonBM6      6   (                  "  "          ������������������������������������������������������������������������������������������������������������������������������������������������������ ����� ����� ����� ����� ����� �������������������� ����� ����� ����� ����� �������������������� ����� ����� ����� ����� ����� �������������������� ����� ����� ����� ����� �������������������� ����� ����� ����� ����� ����� �������������������� ����� ����� �����   ��� �� ��������   ������ ����� ����� ����� ����� �����   ��� ��������������������������������������    ��   ������������ ����� ����� �������� ��   ���   ���    ����������� ����� �����������������    ��   ������������������������������������ �����   ��� ��������������������������������   ������ ��������   ������������������������������������������������   %   6      l     P  s�?L  �  U  �  ��  � � �� � � T� �C� � �� H�4 �� � �� � H��[ � T� �C � �X� �� �� � V��� � T� �C � �Z� �� � T� �C�  � � �� B��  ��� �� U  TNPIXELS TCDIRECTION LHDEVICEHDL LNPIXELSPERINCH GETDC GETDEVICECAPS	 RELEASEDC GKTPixelsToTwips,     �� 1 � � � !Q!QA Q!1                    �  i     0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _1HT1A7HWP1046053608�      �  s      C      �  2k          s  �            �          4   COMMENT RESERVED                        �      J                                                           WINDOWS _1HT11EO9Y1046053658V      �  �      �'      �2  [P          �  �            �      S  [K   COMMENT RESERVED                        �                            )                                   WINDOWS _1HT1A7HWP1046053691�      �  h      �      #  s          �  �  �          :          �    COMMENT RESERVED                        �      �                                                           WINDOWS _1HU0OPM3K1058580216�      �  �      =      �Z  Y)          z  �  e          ,      H  nN   COMMENT RESERVED                        �      <                                                         WINDOWS _2FF13Q49L1058580252      �        �F      �?  /          �  �  s          �      �  �   WINDOWS _2FF1FBW05 956153628�      >  1  "                                                             COMMENT RESERVED                        �                              k                                    o�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      6_memberdata XML Metadata for customizable properties
      commandbutton      "  ..\programs\gktdefines.h��|0?      sidebar      Pixels      commandbutton      1      1      2      1      6_memberdata XML Metadata for customizable properties
      "  ..\programs\gktdefines.h��|0?      ..\programs\gktdefines.h      	cmdbutton      ..\programs\gktdefines.h      1      !Arial, 0, 8, 5, 14, 11, 29, 3, 0
      	cmdbutton      Pixels      Class      	container      sidebar      sidebar      Line1      line      !Arial, 0, 8, 5, 14, 11, 29, 3, 0
      Class      commandbutton      cmdgroup      commandbutton      Class      line      cmdgroup      	container      cmdmove      !Arial, 0, 8, 5, 14, 11, 29, 3, 0
      Pixels      Pixels      ..\programs\gktdefines.h      
cmdsidebar      Class      commandbutton      commandgroup      
cmdsidebar      cmdmove      Class      Pixels      commandbutton     _memberdata XML Metadata for customizable properties
attop Flag to indicate if at position of button is at top of outlook bar (.T.) or at bottom (.F.)
commandcount Count of command buttons in folder group
^cmdcollection[1,0] Collection of command buttons in group
      VHeight = 0
Left = 0
Top = 0
Width = 87
BorderColor = 128,128,128
Name = "Line1"
     r_memberdata XML Metadata for customizable properties
commandcount Count of command buttons
selectedcommand Currently selected command button reference in collection
*addcmdbutton Adds command button to collection
*removecmdbutton Removes command button from collection
*usercmdclick Command Button Click Event
^cmdcollection[1,0] Collection of the commandbuttons
     _memberdata = <VFPData><memberdata name="BackColor" type="property" display="BackColor"/><memberdata name="BorderColor" type="property" display="BorderColor"/><memberdata name="cmdcollection" type="property" display="CmdCollection"/><memberdata name="commandcount" type="property" display="CommandCount"/><memberdata name="Height" type="property" display="Height"/><memberdata name="Name" type="property" display="Name"/><memberdata name="selectedcommand" type="property" display="SelectedCommand"/><memberdata name="Width" type="property" display="Width"/><memberdata name="addcmdbutton" type="method" display="AddCmdButton"/><memberdata name="removecmdbutton" type="method" display="RemoveCmdButton"/><memberdata name="usercmdclick" type="method" display="UserCmdClick"/></VFPData>
UserNotes =       "  ..\programs\gktdefines.h��|0?      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      6_memberdata XML Metadata for customizable properties
      commandgroup      �Height = 50
Width = 87
Caption = "cmdButton"
FontSize = 8
Picture = ..\graphics\gktfavfolder.bmp
PicturePosition = 13
SpecialEffect = 2
Name = "cmdsidebar"
_memberdata = 
     ����    �  �                        ��   %   �      '  ,   �          �  U    ��  � � � � U  NBUTTON NSHIFT NXCOORD NYCOORD  ��  � � � � U  NBUTTON NSHIFT NXCOORD NYCOORD� ��  � � ��� � ���� T�  �� ��& %�C� � � grpCollection��h���% �� ���(�CC�� �� � ����� �% %�C � C�� �� � � � � ��� � T�  �� �� !� � �� %��  � ��� � T�� �� �� B� � T�� ��  �� ��C��  �  ��	 �� ��CC�� �� �
 �� ��� �� ���(��� ��^� %�C � �� � � � ��Z� T�  �� �� !� � �� %��  � ���� T�� �� �� B� � T�� ��  �� ��C �  ��	 �� � �� U  LNCMDPOS LNCMD THIS PARENT GRPCOLLECTION SELECTEDGROUP CMDCOLLECTION NAME SELECTEDCOMMAND USERCMDCLICK SETFOCUS COMMANDCOUNTX  ��  � � T� � ��  �� T� � �� �� T� � ���� T� � �� � � ��� U 	 TCCAPTION TCFOLDERPATH THIS CAPTION TOOLTIPTEXT LEFT WIDTH PARENT
 MouseEnter,     ��
 MouseLeavei     �� Click�     �� Init�    ��1 13 13 � � aQQ� A A A � A A � 11� ��� A A A � A A � � A A 2 � �1                       f         �   �         �   �  	   &     �  +    )   �                       �_memberdata = <VFPData><memberdata name="Caption" type="property" display="Caption"/><memberdata name="FontSize" type="property" display="FontSize"/><memberdata name="Height" type="property" display="Height"/><memberdata name="Name" type="property" display="Name"/><memberdata name="PicturePosition" type="property" display="PicturePosition"/><memberdata name="SpecialEffect" type="property" display="SpecialEffect"/><memberdata name="Width" type="property" display="Width"/></VFPData>
UserNotes =      ���    �  �                        A/   %   �      z  4             �  U  � ��  � � �� � � � ��� ���� T�� ��� ���) T� ��	 cmdButtonCC^� :�  �C�� _��; ��C � �
 cmdSideBar� GKTOutlookbar.vcx�   �   � �� �� T� �� this.� �� loCmdButton = &lcCmdButton
 �� ��� �� T�� ��� ��� �� %��� ���� T� �	 ���� �N�. T� �	 �C�� ��� �	 C�� ��� �
 �� � %���
 � �	 � �
 ��}� T� � �a�� ��� T�� � �a�� ��C� �� � �� � �� B�� � �� U 	 TCCAPTION TCFOLDERPATH LOCMDBUTTON LCCMDBUTTON LNBOTTOM THIS COMMANDCOUNT	 NEWOBJECT CMDCOLLECTION TOP HEIGHT VISIBLE CMDMOVE ZORDER�  ��  � �� � ��� ��� � %�C�  ��� ���� � T�� ��� ��� T� �C �  �� � �� ��C � �� �� %��� � ��� � ��C�� �  ��� �� ��� �� %��� �  ��� � T�� �� �� � �� � T�� ������� T�� �� �� � � �� U 	 TNCOMMAND LCCMDBUTTON THIS COMMANDCOUNT CMDCOLLECTION NAME REMOVEOBJECT SELECTEDCOMMAND
  ��  � U  TNCMDBUTTON� 5 ��C� cmdMove� cmdMove� GKTOutlookbar.vcx�  � ��  T�  � � ��  � �  � � ��  T�  � � ��  � �  � � �� T�  � � ��  � �� U  THIS	 NEWOBJECT CMDMOVE LEFT WIDTH TOP HEIGHT LINE1 addcmdbutton,     �� removecmdbutton~    �� usercmdclick�    �� Init�    ��1 � � � 1��b�� Q"� �A �� � � A A � 2 q q � a1a� !� !� A � !� A A A 2 q 2 Qa1                       �        #  �     -     5  3   /   P    6    )   �                        �Height = 50
Width = 87
Caption = "cmdButton"
FontSize = 8
PicturePosition = 13
SpecialEffect = 2
Name = "cmdbutton"
_memberdata = 
     _PROCEDURE Click
LOCAL lnCmdPos, lnCmd
WITH this.Parent
	lnCmdPos = 0
	IF PEMSTATUS(this.Parent,"grpCollection",5)
		FOR lnCmd=1 TO ALEN(.grpCollection(.SelectedGroup).cmdCollection,1)
			IF .grpCollection(.SelectedGroup).cmdCollection(lnCmd).Name = this.Name
				lnCmdPos = lnCmd
				EXIT
			ENDIF
		ENDFOR
		IF lnCmdPos = 0
			.SelectedCommand = 0
			RETURN
		ENDIF
		.SelectedCommand = lnCmdPos
		.UserCmdClick(.SelectedGroup,lnCmdPos)
		.grpCollection(.SelectedGroup).Setfocus()
	ELSE
		FOR lnCmd=1 TO .CommandCount
			IF .cmdCollection(lnCmd).Name = this.Name
				lnCmdPos = lnCmd
				EXIT
			ENDIF
		ENDFOR
		IF lnCmdPos = 0
			.SelectedCommand = 0
			RETURN
		ENDIF
		.SelectedCommand = lnCmdPos
		.UserCmdClick(lnCmdPos)
	ENDIF
ENDWITH
ENDPROC
PROCEDURE Init
LPARAMETERS tcCaption,tcToolTip,tcPicture,tlLarge,tcMiscText
this.Tag = tcMiscText
this.Picture = tcPicture
this.Caption = tcCaption
this.TooltipText = tcToolTip
IF tlLarge
	this.Height = 50
ELSE
	this.PicturePosition = 1
	this.Height = 30
ENDIF
this.left  = 1
this.width = this.parent.width - 2
ENDPROC
     �ButtonCount = 2
BackStyle = 0
BorderStyle = 0
Value = 1
Height = 65
Width = 95
_memberdata = 
Name = "cmdmove"
Command1.Top = 5
Command1.Left = 5
Command1.Height = 27
Command1.Width = 84
Command1.Caption = "Command1"
Command1.Name = "Command1"
Command2.Top = 34
Command2.Left = 5
Command2.Height = 27
Command2.Width = 84
Command2.Caption = "Command2"
Command2.Name = "Command2"
     1_memberdata = <VFPData><memberdata name="Caption" type="property" display="Caption"/><memberdata name="FontSize" type="property" display="FontSize"/><memberdata name="Height" type="property" display="Height"/><memberdata name="Name" type="property" display="Name"/><memberdata name="Picture" type="property" display="Picture"/><memberdata name="PicturePosition" type="property" display="PicturePosition"/><memberdata name="SpecialEffect" type="property" display="SpecialEffect"/><memberdata name="Width" type="property" display="Width"/></VFPData>
UserNotes =      �PROCEDURE MouseEnter
LPARAMETERS nButton, nShift, nXCoord, nYCoord
*this.Picture = "gktfoldrs02.bmp"
ENDPROC
PROCEDURE MouseLeave
LPARAMETERS nButton, nShift, nXCoord, nYCoord
*this.Picture = "gktfoldrs01.bmp"
ENDPROC
PROCEDURE Click
LOCAL lnCmdPos, lnCmd
WITH this.Parent
	lnCmdPos = 0
	IF PEMSTATUS(this.Parent,"grpCollection",5)
		FOR lnCmd=1 TO ALEN(.grpCollection(.SelectedGroup).cmdCollection,1)
			IF .grpCollection(.SelectedGroup).cmdCollection(lnCmd).Name = this.Name
				lnCmdPos = lnCmd
				EXIT
			ENDIF
		ENDFOR
		IF lnCmdPos = 0
			.SelectedCommand = 0
			RETURN
		ENDIF
		.SelectedCommand = lnCmdPos
		.UserCmdClick(.SelectedGroup,lnCmdPos)
		.grpCollection(.SelectedGroup).Setfocus()
	ELSE
		FOR lnCmd=1 TO .CommandCount
			IF .cmdCollection(lnCmd).Name = this.Name
				lnCmdPos = lnCmd
				EXIT
			ENDIF
		ENDFOR
		IF lnCmdPos = 0
			.SelectedCommand = 0
			RETURN
		ENDIF
		.SelectedCommand = lnCmdPos
		.UserCmdClick(lnCmdPos)
	ENDIF
ENDWITH
ENDPROC
PROCEDURE Init
LPARAMETERS tcCaption,tcFolderPath
this.Caption = tcCaption
this.TooltipText = tcFolderPath
this.left   = 1
this.width  = this.parent.width - 2
ENDPROC
     �Height = 20
Width = 107
Caption = "cmdGroup1"
FontSize = 8
PicturePosition = 1
PictureSpacing = 0
SpecialEffect = 0
attop = .T.
commandcount = 0
Name = "cmdgroup"
_memberdata = <VFPData><memberdata name="attop" type="property" display="AtTop"/><memberdata name="cmdcollection" type="property" display="CmdCollection"/><memberdata name="commandcount" type="property" display="CommandCount"/></VFPData>
     	?���    &	  &	                        ��   %   �      �  m             �  U   ��  � � � � � ��� � ���& %�C� � � grpCollection��h��N� %�� � ���v�' %�CC��	 �� � C��	 �� �
 � 
��r� T� �� ��  ��  ���(�C��	 �� � ��� %�C �  C��	 �� �
 � ��� T� �C �  C��	 �� �
 � �� T� ��  �� !� � �� %�� � ��n� %���	 �� ��H� T� �C��	 ��� � �� �c� T� ��� �� �� � T�� ���	 ��
 �� �� �-�� T� �� ���  ��  �� �(�C��	 �� � ��j�& %�� C �  C��	 �� �
 � � ��?�! T�� ���	 ��
 ��  �� �� �� T�� ���	 ��
 ��  �� �a��" T� �� C �  C��	 �� �
 � �� �f� T�� ���	 ��
 ��  �� �-�� � �� � � �7� T� �� ��  ��  ���(�C��	 �� � �� � %�C �  C��	 �� �
 � ���� T� �C �  C��	 �� �
 � �� T� ��  ��� !� � �� %�� � ��3� %���	 �� ��B� T� �C��	 ��� � �� �X� T� ��� �� �  ��  �� �(�C��	 �� � ��/�& %�� C �  C��	 �� �
 � � ���! T�� ���	 ��
 ��  �� �� �� T�� ���	 ��
 ��  �� �a��" T� �� C �  C��	 �� �
 � �� �+� T�� ���	 ��
 ��  �� �-�� � �� � � ��CC��	 �� � �� �� %�� � ����� %�C�� ��
 � 
���� T� �� �� ��  ���(��� ���� %�C �  ��
 � ���� T� �C �  ��
 � �� T� ��  �� !� � �� %�� � ���� T��
 �� �� �-�� T� �� ��� ��  �� �(��� ����% %�� C �  ��
 � �� �� ���� T��
 ��  �� �� �� T��
 ��  �� �a�� T� �� C �  ��
 � �� ��� T��
 ��  �� �-�� � �� � � ��� T� �� �� ��  ���(��� ��D� %�C �  ��
 � ��@� T� �C �  ��
 � �� T� ��  ��� !� � �� %�� � ���� ��  �� �(��� ���� %�� C �  ��
 � �� ���� T��
 ��  �� �� �� T��
 ��  �� �a�� T� �� C �  ��
 � �� ��� T��
 ��  �� �-�� � �� � � � �� U  LNCMD LLTOGGLEVISIBLE LNTOP LNMAXTOP LNPOS THIS PARENT VALUE GRPCOLLECTION SELECTEDGROUP CMDCOLLECTION COMMANDCOUNT VISIBLE TOP
 GROUPCOUNT HEIGHT LNBOTTOM SETFOCUS Click,     ��1 qaBr� ��� A A A 2�� 1A �a�!� �A A A A � � ��A A A 2�� � A a�!� �A A A A 1� Br� �aa� A A A R�QqQ�� QA A A A � � �aaA A A ��qQ�� QA A A A A A 1                       I      )   &	                       PROCEDURE MouseEnter
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.FontBold = True
ENDPROC
PROCEDURE MouseLeave
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.FontBold = False
ENDPROC
PROCEDURE GotFocus
this.FontBold = True
ENDPROC
PROCEDURE LostFocus
this.FontBold = False
ENDPROC
PROCEDURE Click
LOCAL lnCmd, loCmdButton, lnGrp, loPrvButton, lnTop, lnBottom, lnGrpPos, loTreeView
WITH this.parent
*-*	Hide the command move button
	.cmdMove.visible = False
*-*	Remove the previous group command buttons
	IF .SelectedGroup > 0
		IF .grpCollection(.SelectedGroup).CommandCount = -1
			.grpCollection(.SelectedGroup).cmdCollection(1).visible = False
		ELSE
			FOR lnCmd=1 TO .grpCollection(.SelectedGroup).CommandCount
				.grpCollection(.SelectedGroup).cmdCollection(lnCmd).visible = False
			ENDFOR
		ENDIF
	ENDIF
*-*	Set the selected group to this group
	lnGrpPos = 0
	.SelectedCommand = 0
	FOR lnCmd=1 TO ALEN(.grpCollection,1)
		IF .grpCollection(lnCmd).Name = this.Name
			lnGrpPos = lnCmd
			EXIT
		ENDIF
	ENDFOR
	IF lnGrpPos = 0
		.SelectedGroup = 0
		RETURN
	ENDIF
	.SelectedGroup = lnGrpPos
*-*	Position group buttons
	IF this.AtTop
		IF lnGrpPos+1 <= .GroupCount
			FOR lnGrp=.GroupCount TO lnGrpPos+1 STEP -1
				IF .grpCollection(lnGrp).AtTop
					IF lnGrp = .GroupCount
						.grpCollection(lnGrp).Top = .Height - .grpCollection(lnGrp).Height - 1
					ELSE
						.grpCollection(lnGrp).Top = .grpCollection(lnGrp+1).Top - .grpCollection(lnGrp).Height
					ENDIF
					.grpCollection(lnGrp).AtTop = .NOT. .grpCollection(lnGrp).AtTop
				ENDIF
			ENDFOR
		ENDIF
	ELSE
		IF lnGrpPos > 1
			FOR lnGrp=2 TO lnGrpPos
				IF .NOT. .grpCollection(lnGrp).AtTop
					.grpCollection(lnGrp).Top = .grpCollection(lnGrp-1).Top + .grpCollection(lnGrp-1).Height
					.grpCollection(lnGrp).AtTop = .NOT. .grpCollection(lnGrp).AtTop
				ENDIF
			ENDFOR
		ENDIF
	ENDIF
*-*	Position the command move button
	IF lnGrpPos < .GroupCount
		.cmdMove.top = .grpCollection(lnGrpPos+1).Top - .cmdMove.height
	ELSE
		.cmdMove.top = .Height - .cmdMove.height
	ENDIF
*-*	Enable the selected group command buttons
	DO CASE
		CASE this.CommandCount = -1
			loTreeView = this.cmdCollection(1)
			loTreeView.Width = this.width
			loTreeView.Top   = this.Top + this.Height
			IF lnGrpPos = .GroupCount
				loTreeView.Height = .Height - loTreeView.Top - 2
			ELSE
				loTreeView.Height = .grpCollection(lnGrpPos+1).Top - loTreeView.Top - 2
			ENDIF
			loTreeView.Visible = True
			this.Parent.cmdMove.visible = False
		CASE this.CommandCount > 0
			lnTop = this.Top + this.Height
			IF .GroupCount = 1 .OR. lnGrpPos = .GroupCount
				lnBottom = .Height
			ELSE
				lnBottom = .grpCollection(lnGrpPos+1).Top
			ENDIF
			FOR lnCmd=1 TO this.CommandCount
				WITH this.cmdCollection(lnCmd)
					IF lnTop+.Height < lnBottom
						.Top = lnTop
						.Visible = True
						lnTop = lnTop + .Height
					ELSE
						this.Parent.cmdMove.ZOrder(0)
						this.Parent.cmdMove.visible = True
					ENDIF
				ENDWITH
			ENDFOR
	ENDCASE
*-*	Execute the user click event
	.UserGrpClick(lnGrpPos)
ENDWITH
ENDPROC
PROCEDURE Init
LPARAMETERS tcTitle,tcPicture
this.Caption = tcTitle
this.Picture = tcPicture
this.left    = 1
this.width   = this.parent.width - 2
ENDPROC
     PROCEDURE addcmdbutton
LPARAMETERS tcCaption,tcFolderPath
LOCAL loCmdButton, lcCmdButton, lnBottom
WITH this
	.CommandCount = .CommandCount + 1
*-*	Add command button to sidebar
	lcCmdButton = "cmdButton" + CHRTRAN(TIME(),":","") + TRANSFORM(.CommandCount)
	.NewObject(lcCmdButton,"cmdSideBar","GKTOutlookbar.vcx","",tcCaption,tcFolderPath)
*-*	Save object reference in command button collection
	lcCmdButton = "this." + lcCmdButton
	loCmdButton = &lcCmdButton
	DIMENSION .cmdCollection(.CommandCount)
	.cmdCollection(.CommandCount) = loCmdButton
*-*	Position the command button
	IF .CommandCount = 1
		loCmdButton.Top = 1
	ELSE
		loCmdButton.Top = .cmdCollection(.CommandCount-1).Top + .cmdCollection(.CommandCount-1).Height
	ENDIF
*-*	Set the visibility of the scroll buttons and visiblity of the added command button
	IF .Height > (loCmdButton.Top + loCmdButton.Height)
		loCmdButton.Visible = True
	ELSE
		.cmdMove.Visible = True
		.cmdMove.ZOrder(0)
	ENDIF
ENDWITH
RETURN this.CommandCount
ENDPROC
PROCEDURE removecmdbutton
LPARAMETERS tnCommand
LOCAL lcCmdButton
WITH this
	IF BETWEEN(tnCommand,1,.CommandCount)
		.CommandCount = .CommandCount - 1
		lcCmdButton = .cmdCollection(tnCommand).Name
		.RemoveObject(lcCmdButton)
		IF .CommandCount > 0
			=ADEL(.cmdCollection,tnCommand)
			DIMENSION .cmdCollection(.CommandCount)
			IF .SelectedCommand = tnCommand
				.SelectedCommand = 0
			ENDIF
		ELSE
			.cmdCollection(1) = .NULL.
			.SelectedCommand = 0
		ENDIF
	ENDIF
ENDWITH
ENDPROC
PROCEDURE usercmdclick
LPARAMETERS tnCmdButton
ENDPROC
PROCEDURE Init
this.NewObject("cmdMove","cmdMove","GKTOutlookbar.vcx")
this.cmdMove.left = this.Width - this.cmdMove.width
this.cmdMove.top  = this.Height - this.cmdMove.height
this.Line1.Width  = this.Width
ENDPROC
     qWidth = 87
Height = 200
BackColor = 255,255,255
BorderColor = 128,128,128
_memberdata =      461<VFPData><memberdata name="cmdcollection" type="property" display="CmdCollection"/><memberdata name="commandcount" type="property" display="CommandCount"/><memberdata name="selectedcommand" type="property" display="SelectedCommand"/><memberdata name="addcmdbutton" type="method" display="AddCmdButton"/><memberdata name="removecmdbutton" type="method" display="RemoveCmdButton"/><memberdata name="usercmdclick" type="method" display="UserCmdClick"/></VFPData>

commandcount = 0
selectedcommand = 0
Name = "sidebar"
     _memberdata = <VFPData><memberdata name="attop" type="property" display="AtTop"/><memberdata name="Caption" type="property" display="Caption"/><memberdata name="cmdcollection" type="property" display="CmdCollection"/><memberdata name="commandcount" type="property" display="CommandCount"/><memberdata name="FontSize" type="property" display="FontSize"/><memberdata name="Height" type="property" display="Height"/><memberdata name="Name" type="property" display="Name"/><memberdata name="PicturePosition" type="property" display="PicturePosition"/><memberdata name="PictureSpacing" type="property" display="PictureSpacing"/><memberdata name="SpecialEffect" type="property" display="SpecialEffect"/><memberdata name="Width" type="property" display="Width"/></VFPData>
UserNotes =      �_memberdata = <VFPData><memberdata name="BackStyle" type="property" display="BackStyle"/><memberdata name="BorderStyle" type="property" display="BorderStyle"/><memberdata name="ButtonCount" type="property" display="ButtonCount"/><memberdata name="Height" type="property" display="Height"/><memberdata name="Name" type="property" display="Name"/><memberdata name="Value" type="property" display="Value"/><memberdata name="Width" type="property" display="Width"/></VFPData>
UserNotes =      
s���    Z
  Z
                        LZ   %   �      �	  i   �          �  U  $  ��  � � � � T� � �a�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS FONTBOLD$  ��  � � � � T� � �-�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS FONTBOLD  T�  � �a�� U  THIS FONTBOLD  T�  � �-�� U  THIS FONTBOLD�# ��  � � � � � � � � ��� �	 ���� T��
 � �-�� %��� � ��� � %�C�� �� � ������ � T�� ��� �� ���� �-�� �� �  ��  ���(�C�� �� � ��� � T�� ��� �� ��  �� �-�� �� � � T� �� �� T�� �� �� ��  ���(�C�� ����K� %�C �  �� � � � ��G� T� ��  �� !� � �� %�� � ��r� T�� �� �� B� � T�� �� �� %�� � ���� %�� ��� ����# �� ��� �(�� ���������� %�C � �� � ��{� %�� �� ���) T�� �� �� ��� C � �� � ��� �V�0 T�� �� �� �C� ��� � C � �� � �� �! T�� �� �� �C � �� � 
�� � �� � �.� %�� ���*� �� ���(�� ��&� %�C � �� � 
��"�3 T�� �� �� �C� ��� � C� ��� � ��! T�� �� �� �C � �� � 
�� � �� � � %�� �� ��i�% T��
 � �C� ��� � ��
 � �� ��� T��
 � ��� ��
 � �� � H����� �� � �����u� T� �C�� � �� T� � �� � �� T� � �� � � � �� %�� �� �� � T� � ��� � � ��� �O�' T� � �C� ��� � � � ��� � T� � �a�� T� �	 �
 � �-�� �� � � ���� T� �� � � � �� %��� ��	 � �� ���� T� ��� �� ��� T� �C� ��� � �� � ��  ���(�� � ���� ��C �  � � ���� %�� �� � ��b� T�� �� �� T�� �a�� T� �� �� �� ��� ��C� � �	 �
 � �� T� �	 �
 � �a�� � �� �� � ��C � �� �� �� U  LNCMD LOCMDBUTTON LNGRP LOPRVBUTTON LNTOP LNBOTTOM LNGRPPOS
 LOTREEVIEW THIS PARENT CMDMOVE VISIBLE SELECTEDGROUP GRPCOLLECTION COMMANDCOUNT CMDCOLLECTION SELECTEDCOMMAND NAME ATTOP
 GROUPCOUNT TOP HEIGHT WIDTH ZORDER USERGRPCLICKX  ��  � � T� � ��  �� T� � �� �� T� � ���� T� � �� � � ��� U  TCTITLE	 TCPICTURE THIS CAPTION PICTURE LEFT WIDTH PARENT
 MouseEnter,     ��
 MouseLeave�     �� GotFocus�     ��	 LostFocus    �� Click,    �� Init�    ��1 1� 2 1� 2 � 2 � 2 1� "��� �A A A � � ��� A A A � A A � a1a!�� A A A A � qq1A A A A "Q� �A � QA1�!�� qA � AAq�� � �A �Qa� � !� aAA A A A � A 2 � �1                       Y         z   �         �   �   	   	     &        B  g     c   �  	  o    )   Z
                       TPROCEDURE Click
LOCAL lnCmd, llToggleVisible, lnTop, lnMaxTop, lnPos
WITH this.parent
	IF PEMSTATUS(this.Parent,"grpCollection",5)
*-*		Outlook class
		IF this.Value = 1
*-*			 Move buttons from top to bottom by one
			IF .NOT. .grpCollection(.SelectedGroup).cmdCollection(.grpCollection(.SelectedGroup).CommandCount).visible
*-*				Get the first visible button from the top
				lnPos = 0
				FOR lnCmd=1 TO .grpCollection(.SelectedGroup).CommandCount
					IF .grpCollection(.SelectedGroup).cmdCollection(lnCmd).visible
						lnTop = .grpCollection(.SelectedGroup).cmdCollection(lnCmd).top
						lnPos = lnCmd
						EXIT
					ENDIF
				ENDFOR
				IF lnPos > 0
*-*					Move the buttons up
					IF .SelectedGroup < .GroupCount
						lnMaxTop = .grpCollection(.SelectedGroup+1).Top
					ELSE
						lnMaxTop = .Top + .Height
					ENDIF
					.grpCollection(.SelectedGroup).cmdCollection(lnPos).visible = False
					lnPos = lnPos + 1
					FOR lnCmd=lnPos TO .grpCollection(.SelectedGroup).CommandCount
						IF lnTop+.grpCollection(.SelectedGroup).cmdCollection(lnCmd).Height < lnMaxTop
							.grpCollection(.SelectedGroup).cmdCollection(lnCmd).top = lnTop
							.grpCollection(.SelectedGroup).cmdCollection(lnCmd).visible = True
							lnTop = lnTop + .grpCollection(.SelectedGroup).cmdCollection(lnCmd).height
						ELSE
							.grpCollection(.SelectedGroup).cmdCollection(lnCmd).visible = False
						ENDIF
					ENDFOR
				ENDIF
			ENDIF
		ELSE
*-*			Move buttons from top to bottom by one
*-*			Get the last non-visible button from the top before the visible buttons
			lnPos = 0
			FOR lnCmd=1 TO .grpCollection(.SelectedGroup).CommandCount
				IF .grpCollection(.SelectedGroup).cmdCollection(lnCmd).visible
					lnTop = .grpCollection(.SelectedGroup).cmdCollection(lnCmd).top
					lnPos = lnCmd - 1
					EXIT
				ENDIF
			ENDFOR
			IF lnPos > 0
*-*				Move the buttons down
				IF .SelectedGroup < .GroupCount
					lnBottom = .grpCollection(.SelectedGroup+1).Top
				ELSE
					lnBottom = .Height
				ENDIF
				FOR lnCmd=lnPos TO .grpCollection(.SelectedGroup).CommandCount
					IF lnTop+.grpCollection(.SelectedGroup).cmdCollection(lnCmd).Height <= lnBottom
						.grpCollection(.SelectedGroup).cmdCollection(lnCmd).top = lnTop
						.grpCollection(.SelectedGroup).cmdCollection(lnCmd).visible = True
						lnTop = lnTop + .grpCollection(.SelectedGroup).cmdCollection(lnCmd).height
					ELSE
						.grpCollection(.SelectedGroup).cmdCollection(lnCmd).visible = False
					ENDIF
				ENDFOR
			ENDIF
		ENDIF
		.grpCollection(.SelectedGroup).Setfocus()
	ELSE
*-*		Sidebar class
		IF this.Value = 1
*-*			 Move buttons from top to bottom by one
			IF .NOT. .cmdCollection(.CommandCount).visible
*-*				Get the first visible button from the top
				lnPos = 0
				FOR lnCmd=1 TO .CommandCount
					IF .cmdCollection(lnCmd).visible
						lnTop = .cmdCollection(lnCmd).top
						lnPos = lnCmd
						EXIT
					ENDIF
				ENDFOR
				IF lnPos > 0
*-*					Move the buttons up
					.cmdCollection(lnPos).visible = False
					lnPos = lnPos + 1
					FOR lnCmd=lnPos TO .CommandCount
						IF lnTop+.cmdCollection(lnCmd).Height < (.Top + .Height)
							.cmdCollection(lnCmd).top = lnTop
							.cmdCollection(lnCmd).visible = True
							lnTop = lnTop + .cmdCollection(lnCmd).height
						ELSE
							.cmdCollection(lnCmd).visible = False
						ENDIF
					ENDFOR
				ENDIF
			ENDIF
		ELSE
*-*			Move buttons from top to bottom by one
*-*			Get the last non-visible button from the top before the visible buttons
			lnPos = 0
			FOR lnCmd=1 TO .CommandCount
				IF .cmdCollection(lnCmd).visible
					lnTop = .cmdCollection(lnCmd).top
					lnPos = lnCmd - 1
					EXIT
				ENDIF
			ENDFOR
			IF lnPos > 0
*-*				Move the buttons down
				FOR lnCmd=lnPos TO .CommandCount
					IF lnTop+.cmdCollection(lnCmd).Height <= .Height
						.cmdCollection(lnCmd).top = lnTop
						.cmdCollection(lnCmd).visible = True
						lnTop = lnTop + .cmdCollection(lnCmd).height
					ELSE
						.cmdCollection(lnCmd).visible = False
					ENDIF
				ENDFOR
			ENDIF
		ENDIF
	ENDIF
ENDWITH
ENDPROC
     ����    �  �                        .z   %   �      F  0   �          �  U  � ��  � � ��� � ���� T�  �� ��& %�C� � � grpCollection��h���% �� ���(�CC�� �� � ����� �% %�C � C�� �� � � � � ��� � T�  �� �� !� � �� %��  � ��� � T�� �� �� B� � T�� ��  �� ��C��  �  ��	 �� ��CC�� �� �
 �� ��� �� ���(��� ��^� %�C � �� � � � ��Z� T�  �� �� !� � �� %��  � ���� T�� �� �� B� � T�� ��  �� ��C �  ��	 �� � �� U  LNCMDPOS LNCMD THIS PARENT GRPCOLLECTION SELECTEDGROUP CMDCOLLECTION NAME SELECTEDCOMMAND USERCMDCLICK SETFOCUS COMMANDCOUNT�  ��  � � � � � T� � �� �� T� � �� �� T� � ��  �� T� �	 �� �� %�� ��t � T� �
 ��2�� �� � T� � ���� T� �
 ���� � T� � ���� T� � �� � � ��� U 	 TCCAPTION	 TCTOOLTIP	 TCPICTURE TLLARGE
 TCMISCTEXT THIS TAG PICTURE CAPTION TOOLTIPTEXT HEIGHT PICTUREPOSITION LEFT WIDTH PARENT Click,     �� Initj    ��1 � � aQQ� A A A � A A � 11� ��� A A A � A A � � A A 2 q� � A �1                            "   !  T  #    )   �                     %   |      �     �  ��?�  �  U  �  ��  � � �� � � T� �C�� %�C� ��� � F� �> -�� � GKKSETTINGS� C� �C�  f	� C� �C� f	� C'
	�� %�C4��� � T� �C� �	 ��� �� � T� ��  �� � Q� � %�C� �
��� �
 F�� �� � �� � T� ��  �� �	 B�� �� U
  TCSUBKEY TCENTRY LCRETURN LCALIAS GKTGETRESOURCE GKKUSER TYPE ID NAME DATA GKTGetString_VFP,     ��: � � � � q �� !� � A � � A � � A � 1                    �  k  
      %   �      9  /   �  ��?�  �  U  � ��  � � � �� � � � � � T� �C�� %�C� ���� H�M ��� �C� ��� C��q � T� �C� ��� �C� ��� N��� � T� �C� 8�� T� �� � �'�� T� �C� _� .C� _�� �C� ��� D��� � T� �C� *�� �C� ��� T��� T� �C� ��� �C� ��� L��]� %�� ��A� T� �� .T.�� �Y� T� �� .F.�� � �C� ��� Y���� T� �C� _�� 2��� T� �� �� � T�	 �CCC��C� �\]�g�� F�
 �> -�� � GKKSETTINGS� C� �C�  f	� C� �C� f	� C'
	�� %�C4��6� >�
 � ��� �� >�
 � ���	 �� >�
 � ��C$�� ���\ r�� gkkuser� � � � � � ��� GKKSETTINGS��C�  f��C� f��� ���	 ��C$�� � Q�
 � T� �a�� %�C� �
����
 F�� �� � ��� T� �-�� �	 B�� �� U  TCSUBKEY TCENTRY
 TCSTRVALUE LCALIAS LCSTRBUFFER
 LNINTVALUE
 LNDECVALUE LLRETURN GKTGETRESOURCE LNCKVAL GKKUSER TYPE ID NAME DATA CKVAL UPDATED GKTSetString_VFP,     ��: � q� � � Q� Q� q�Q� QQ� � A Q� � � A �r �� � � �A � � � A � � A � 1                    �  �  
      %   �         
   
  s�?	  �  U  �  ��  � � � � �� � %�C� tcIconb� L��H � T� �� EXCLAIM�� � T� �� ��% �	 GKTMsgBox(� ��  � � � �	 B�� �� U 	 TCMESSAGE TCTITLE	 TNBUTTONS TCICON LNBUTTON	 GKTMSGBOX
 GKTWMSGBOX,     ��7 1q �AA � Q� 1                    9          %         �  3   1  F}0?0  �  U  , ��  � � � � � � %�C� gkkuser���< � T�  �-�� �� T� �-�� T�  �a�� T� �C��X�� %�C� � �� � ���� � T� �C� ��� �� � T� �CC��]���� �- T� �C� ��� GKK Industries\GKKEditors�� %�C � � 
��	� T� �CC��]���� � T� �C� ��� gkkuser.dbf�� +��  ��� ��b� Q�  ��� ��� � T�  �-�� �(� ��� H�{��� �� �	 ����� ��1� F�  �` h1�� ���
 � C���� � C���� � M� � L� � N����� �� � M� � D� F� � & ��
 ���
 � & �� ��� � Q� T�  �a�� �(� ��� T� �a��6 T� ��) Unable to create GKKTools Resource Table.�� ��C � � �� �� 2��� T� �a��I T� ��< Unable to open GKKTools Resource Table to retrieve settings.�� ��C � � �� � �� %�� ��� !� � � �
 B��  
�� U 	 LLNOTOPEN	 LCUSERMSG LOEXCEPTION LCGKKRESOURCE LLERROR
 LCBASEPATH SHGETSPECIALFOLDERPATH GKTMAKEPATH GKKUSER ERRORNO TYPE ID NAME READONLY CKVAL DATA UPDATED GKTDISPLAYMSG GKTGetResource,     ��= �a� � � � � �� � 1A �11A �� � Q� � � A� � q � � A � � � a� A � � �� A A � A A A A � 1                    �  a     0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Screen                                                                                            WINDOWS _0420NWASD 6832356168      O  f      }                          �      �                       WINDOWS _0420NWASX1058580006�      �              �  �                  �                           WINDOWS _0420NWASX 812485141=      N  _  q  �                                                           WINDOWS _0420O4GWD 958952324�      �  �  	                                                             WINDOWS _0420NWASD 926067908�      �  �  �  �                                                           WINDOWS _0420NWAT7 926068413�      �  �  �  .                                                           WINDOWS _0420O4GWE 683240545z      n  a  P  �                                                           WINDOWS _1BM1BHI4X 824736034�  �  �  �  �  5      �  �                                               WINDOWS _1BM1BHI4Y 824736034�  �  �  �  |  *      �  �                                               WINDOWS _1BM1BHI4Z 824736034�  �  �  �  �  .      �  �                                               COMMENT RESERVED                                �                      �                                    �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      ..\programs\gktdefines.h      dataenvironment      dataenvironment      Dataenvironment      YTop = 0
Left = 0
Width = 0
Height = 0
DataSource = .NULL.
Name = "Dataenvironment"
      1      1      form      form      	GKTMSGBOX     �Height = 180
Width = 406
Desktop = .F.
ShowWindow = 1
DoCreate = .T.
AutoCenter = .T.
BorderStyle = 2
Caption = "Form1"
HalfHeightCaption = .T.
MaxButton = .F.
MinButton = .F.
Icon = ..\graphics\gktgkt.ico
WindowType = 1
AllowOutput = .F.
rtnvalue = 0
_memberdata =       85<VFPData><memberdata name="rtnvalue" type="property" display="RtnValue"/></VFPData>

Name = "GKTMSGBOX"
     9PROCEDURE Init
LPARAMETERS pcMessage,pcTitle,pnButtons,pcIcon
thisform.msgtext.caption = pcMessage
thisform.caption = pcTitle
DO CASE
	CASE pnButtons = 16
		WITH thisform.cmdOk
			.enabled = .T.
			.visible = .T.
		ENDWITH
		WITH thisform.cmdYes
			.enabled = .F.
			.visible = .F.
		ENDWITH
		WITH thisform.cmdNo
			.enabled = .F.
			.visible = .F.
		ENDWITH
	CASE pnButtons = 36
		WITH thisform.cmdOk
			.enabled = .F.
			.visible = .F.
		ENDWITH
		WITH thisform.cmdYes
			.enabled = .T.
			.visible = .T.
		ENDWITH
		WITH thisform.cmdNo
			.enabled = .T.
			.visible = .T.
		ENDWITH
	CASE pnButtons = 48
		WITH thisform.cmdOk
			.enabled = .F.
			.visible = .F.
		ENDWITH
		WITH thisform.cmdYes
			.enabled = .T.
			.visible = .T.
			.caption = 'Suspend'
		ENDWITH
		WITH thisform.cmdNo
			.enabled = .T.
			.visible = .T.
			.caption = 'Cancel'
		ENDWITH
ENDCASE
DO CASE
	CASE pcIcon = 'EXCLAIM'
		thisform.image1.picture = 'GKTEXCLAIM.BMP'
		thisform.header.caption = 'WARNING'
	CASE pcIcon = 'INFO'
		thisform.image1.picture = 'GKTINFO.BMP'
		thisform.header.caption = 'INFORMATION'
	CASE pcIcon = 'QUESTION'
		thisform.image1.picture = 'GKTQUESTION.BMP'
		thisform.header.caption = 'QUESTION'
	CASE pcIcon = 'ERROR'
		thisform.image1.picture = 'GKTSTOP.BMP'
		thisform.header.caption = 'ERROR'
	OTHERWISE
		thisform.image1.picture = 'GKTEXCLAIM.BMP'
		thisform.header.caption = 'WARNING'
ENDCASE
ENDPROC
PROCEDURE Unload
RETURN thisform.RtnValue
ENDPROC
PROCEDURE Activate
LOCAL lcName
lcName = this.Name
MOUSE CLICK AT 10,10 WINDOW (lcName)
MOUSE CLICK AT 1,1 WINDOW (lcName)
IF thisform.cmdOk.Visible
	MOUSE AT 165,203 PIXELS WINDOW (lcName)
	thisform.cmdOk.SetFocus()
ELSE
	MOUSE AT 156,160 PIXELS WINDOW (lcName)
	thisform.cmdYes.SetFocus()
ENDIF

ENDPROC
      ����    �   �                         ��   %   ^       u      m           �  U    T�  � ���� <�  � U  THISFORM RTNVALUE Click,     ��1 q 1                       8       )   �                         ����    �   �                         ��   %   ^       u      m           �  U    T�  � �� �� <�  � U  THISFORM RTNVALUE Click,     ��1 q 1                       8       )   �                         ����    �   �                         ��   %   ^       u      m           �  U    T�  � ���� <�  � U  THISFORM RTNVALUE Click,     ��1 q 1                       8       )   �                         "  ..\programs\gktdefines.h��|0?      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      CPROCEDURE Click
thisform.RtnValue = 7
RELEASE thisform
ENDPROC
      JTop = 151
Left = 203
Caption = "No"
SpecialEffect = 0
Name = "cmdNo"
      	GKTMSGBOX      cmdNo      commandbutton      _commandbutton      _commandbutton      CPROCEDURE Click
thisform.RtnValue = 0
RELEASE thisform
ENDPROC
      JTop = 151
Left = 161
Caption = "Ok"
SpecialEffect = 0
Name = "cmdOk"
      	GKTMSGBOX      cmdOk      commandbutton      ..\classes\gktbaseclasses.vcx      _commandbutton      CPROCEDURE Click
thisform.RtnValue = 6
RELEASE thisform
ENDPROC
      LTop = 151
Left = 118
Caption = "Yes"
SpecialEffect = 0
Name = "cmdYes"
      	GKTMSGBOX      cmdYes      commandbutton      ..\classes\gktbaseclasses.vcx      label      YHeight = 0
Left = 80
Top = 37
Width = 304
BorderColor = 255,255,255
Name = "Line1"
      	GKTMSGBOX      Line1      line      line      	GKTMSGBOX      Header      label      label      	GKTMSGBOX      MsgText      label      Irtnvalue RtnValue
_memberdata XML Metadata for customizable properties
      	container      	container      
Container1      	GKTMSGBOX      WTop = 8
Left = 64
Width = 336
Height = 138
SpecialEffect = 1
Name = "Container1"
      image      image      Image1      	GKTMSGBOX      pPicture = ..\graphics\gktinfo.bmp
BackStyle = 0
Height = 36
Left = 13
Top = 8
Width = 36
Name = "Image1"
      �FontBold = .T.
FontSize = 10
WordWrap = .T.
BackStyle = 0
Caption = "MsgText"
Height = 95
Left = 83
Top = 45
Width = 293
Name = "MsgText"
      �AutoSize = .T.
FontBold = .T.
FontSize = 14
BackStyle = 0
Caption = "WARNING"
Height = 25
Left = 80
Top = 16
Width = 91
ForeColor = 255,0,0
Name = "Header"
     ����    �  �                        �q   %   �      r  O   �          �  U  � ��  � � � � T� � � ��  �� T� � �� �� H�C �+� �� ���� � ��� � ��| � T�� �a�� T��	 �a�� �� ��� �
 ��� � T�� �-�� T��	 �-�� �� ��� � ��� � T�� �-�� T��	 �-�� �� �� �$��m� ��� � ��� T�� �-�� T��	 �-�� �� ��� �
 ��=� T�� �a�� T��	 �a�� �� ��� � ��i� T�� �a�� T��	 �a�� �� �� �0��+� ��� � ���� T�� �-�� T��	 �-�� �� ��� �
 ���� T�� �a�� T��	 �a�� T�� �� Suspend�� �� ��� � ��'� T�� �a�� T��	 �a�� T�� �� Cancel�� �� � H�<��� �� � EXCLAIM����! T� � � �� GKTEXCLAIM.BMP�� T� � � �� WARNING�� �� � INFO���� T� � � �� GKTINFO.BMP�� T� � � �� INFORMATION�� �� � QUESTION��6�" T� � � �� GKTQUESTION.BMP�� T� � � �� QUESTION�� �� � ERROR���� T� � � �� GKTSTOP.BMP�� T� � � �� ERROR�� 2���! T� � � �� GKTEXCLAIM.BMP�� T� � � �� WARNING�� � U 	 PCMESSAGE PCTITLE	 PNBUTTONS PCICON THISFORM MSGTEXT CAPTION CMDOK ENABLED VISIBLE CMDYES CMDNO IMAGE1 PICTURE HEADER  B��  � �� U  THISFORM RTNVALUE�  ��  � T�  �� � �� �,��  ����
���
�� �,��  ��������� %�� � � ��� � ��,��  ���������� ��C� � � �� �� � ��,��  ���������� ��C� � � �� � U  LCNAME THIS NAME THISFORM CMDOK VISIBLE SETFOCUS CMDYES Init,     �� Unload�    �� Activate�    ��1 11� � � A � � A � � A � � A � � A � � A � � A � � QA � � AA A � ��Q���!�a��� �A 2 � 2 q ��1�� �A 2                       �     A   �  �  B   C     .  E    )   �                        ..\classes\gktbaseclasses.vcx   %   �       �      �   s�?{  �  U  H  ��  �' � GKTDisplayMsg���      �?��  � ��C�����MbP?� H7�� U 	 TCMESSAGE GKTDISPLAYMSG GKTDisplayMsg,     ��� 1 q qq1                    �  �     0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Screen                                                                                            WINDOWS _0420NWASD 6832356168      O  f      }                          �      �                       WINDOWS _0420NWASX1058580000�      �              ^  �                  �                           WINDOWS _0420NWASX 978884962.      ?  P  b  w                                                           WINDOWS _0420O4GWD 978884962�      {  m  X  �                                                           WINDOWS _0420NWASD 978884962�      �  �  �                                                             WINDOWS _2JG0PMZWF 978884962      �  �  �  �      O  8
                                               COMMENT RESERVED                                %                      �
                                    @                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      ..\programs\gktdefines.h      dataenvironment      dataenvironment      Dataenvironment      YTop = 0
Left = 0
Width = 0
Height = 0
DataSource = .NULL.
Name = "Dataenvironment"
      1      1      form      form      GKTDISPLAYMSG     9Height = 38
Width = 402
Desktop = .F.
ShowWindow = 1
DoCreate = .T.
AutoCenter = .T.
BorderStyle = 2
Caption = "Form1"
FontSize = 10
MaxButton = .F.
MinButton = .F.
Icon = ..\graphics\gktgkt.ico
TitleBar = 0
WindowType = 0
AlwaysOnTop = .T.
AllowOutput = .F.
rtnvalue = 0
_memberdata =      227<VFPData><memberdata name="rtnvalue" type="property" display="RtnValue"/><memberdata name="gettextwidth" type="method" display="GetTextWidth"/><memberdata name="updatecaption" type="method" display="UpdateCaption"/></VFPData>

Name = "GKTDISPLAYMSG"
     �PROCEDURE gettextwidth
LPARAMETERS pcFontName,pnFontSize,pnFontStyle,pcText
RETURN FONTMETRIC(6,pcFontName,pnFontSize,pnFontStyle) * LEN(pcText) * 1.3
ENDPROC
PROCEDURE updatecaption
LPARAMETERS pcMsgText
thisform.lblMsgText.Caption = pcMsgText
ENDPROC
PROCEDURE Init
LPARAMETERS pnMsgInterval,pcMsgText
WITH thisform
	.lblMsgText.Caption = pcMsgText
	.lblMsgText.Width   = MAX(.GetTextWidth(.lblMsgText.FontName,.lblMsgText.FontSize,"N",pcMsgText),200)
	.Container1.Width   = .lblMsgText.Width + 14
	.Width = .Container1.Left + .Container1.Width + 7
	INKEY(0.001,"H")
	.tmrMsgTimer.Interval = pnMsgInterval * 1000
	IF pcMsgText = "Show OffScreen"
		.Left = -50
		.Top  = -50
	ENDIF
ENDWITH
ENDPROC
      ����    �   �                         ;   %   D       Y      S           �  U  
  <�  � U  THISFORM Timer,     ��1 q 1                       !       )   �                         "  ..\programs\gktdefines.h��|0?      "Arial, 0, 10, 6, 16, 13, 35, 3, 0
      ,PROCEDURE Timer
RELEASE thisform
ENDPROC
      DTop = 7
Left = 367
Height = 25
Width = 23
Name = "tmrMsgTimer"
      GKTDISPLAYMSG      tmrMsgTimer      timer      timer      �FontBold = .T.
FontSize = 10
BackStyle = 0
Caption = "MsgText"
Height = 18
Left = 50
Top = 10
Width = 344
Name = "lblMsgText"
      GKTDISPLAYMSG      
lblMsgText      label      label      oPicture = ..\graphics\gktinfo.bmp
BackStyle = 0
Height = 36
Left = 2
Top = 1
Width = 36
Name = "Image1"
      GKTDISPLAYMSG      Image1      image      image      �rtnvalue RtnValue
_memberdata XML Metadata for customizable properties
*gettextwidth GetTextWidth
*updatecaption Updates the caption display
      	container      	container      
Container1      GKTDISPLAYMSG      VTop = 3
Left = 44
Width = 356
Height = 32
SpecialEffect = 1
Name = "Container1"
     c���    J  J                        {�   %   |      �     �          �  U  =  ��  � � � �' B�C��  � � �$C� >��������?�� U 
 PCFONTNAME
 PNFONTSIZE PNFONTSTYLE PCTEXT  ��  � T� � � ��  �� U 	 PCMSGTEXT THISFORM
 LBLMSGTEXT CAPTION ��  � � ��� ��� � T�� � �� ��. T�� � �CC�� � �� � � N � �� ��D�� T��	 � ��� � ��� T�� ���	 �
 ��	 � ��� ��C�����MbP?� H7�� T�� � ��  ���� %�� � Show OffScreen��� � T��
 ������ T�� ������ � �� U  PNMSGINTERVAL	 PCMSGTEXT THISFORM
 LBLMSGTEXT CAPTION WIDTH GETTEXTWIDTH FONTNAME FONTSIZE
 CONTAINER1 LEFT TMRMSGTIMER INTERVAL TOP gettextwidth,     �� updatecaption�     �� Init�     ��1 1q2 q 12 � � ���qa�� � A A 1                       �         �   �           �  	    )   J                  BM6      6   (                              ������������������������������������������������������������������������������������������������������������������������������������������������������                                    ������������   ������������������������������   ������������   ������������������������������   ������������   ������������������������������   ������������   ������������������������������   ������������   ������������������������������   ������������   ������������������������������   ������������   ������������������������������   ������������                                    ������������   �� �� �� �� �� �� �� �� �� ��    ������������                                    ������������������������������������������������������������������������������������������������������BM6      6   (                              ���������������������������������������������������������������������������������������������������������������������������������������������������                                       ���������   ����� ����� ����� ����� ����� ���   ���������   ��          ��                ��    ���������   ����� ����� ���   ���������   ���   ���������   ��          ��                ��    ���������   ����� ����� ����� ����� ����� ���   ���������   ��          ��                ��    ���������   ����� ����� ���   ���������   ���   ���������   ��          ��                ��    ���������   ����� ����� ����� ����� ����� ���   ���������                                       ������������������������������������������������������������������������������������������������������BM6      6   (                              ���������������������������������������������������������������������������������������������������������������������������������������������������                     ������������         ������     �   �      �    ������������    ��   ������     �   �      �    ���������    ��   ���������     �   �      �    ���������    ��   ���������     �   �      �    ������    ��   ������������     �   �      �    ������    ��   ������������     �   �      �    ���    ��   ���������������     �          �    ���    ��   ���������������     �   ���    �        ��   ������������������         ���                  ���������������������������������������������������������������������������������������������������������������������������������������������������������������BM�       v   (               �   "  "                �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ����    �wwpww��    ����������w��������p�w��p�w�����  0������    ������wp�������      �������      BM6      6   (                                  ���������������������                c�������  ������  c�������  ������  c�������  �        �  c�������  ������  c�������  �      ��  c�������  cccccc  c�������          c�������  ������  c�������  �        �  c����ccc  ������  ccc�                            c�  ���     ����  c�                            �����������������BMf       6   (               0   �  �          ������   ������ ���         ���                 BM6      6   (                              �������������������������������������������������� �� �� �� �� }� z� x� u� r� o� m� i�p������� ��N��?��'����������
�������� �� �������� ��T��z��l��c��U��G��>��0��#��������
�������� ��,�և��z��l��c��U��G��>��0��#��������|���� �� �ǉ�����z��l��c��U��G��>��0��#����,������� ��	��_�������z��l��c��U��G��>��0��
��?��,����� ����0�ڙ��������z��l��c��U��G��>����K��V��{� ��E���� �� �� �� �� �� �� �� �� �� }� z� x�}� ��`��S��K��@��5��-�� �������� �� y���������� ��v��i��c��V��K��B��6��-��"������ {���������� �ˍ�����v��m��c��V��O������ �� ��`�����������@��:�ߗ��������z��m��&��`��������������������������@�� �� �� �� �� ��P��������������������������������������������������������������������������������������������������������������������������BM      6   (               �  �  �          ������������������������������������������������������������������������������  ����������谰����������������������������������������������������������������  ��������Ȉ�Ȉ�Ȉ�Ȉ�Ȉ�Ȉ�Ȑ�Ȩ�а��������������������������������������������  ���������H��h��h��`��X��P��H��H��H����Ȩ��������������������������������������  ���������@��`��h��h��h��h��h��`��`��X��H��P��P�؀�Ȑ�Ȱ�����������������������  ���������@��`��h��`��`��h��h��h��h��h��h��h��`��X��P��H��P��P�ؐ��������������  ���������@��`��h��`��`��h��h��h��h��h��h��h��`��`��`��`��`��`��P��������������  ���������@��X��h��`��h��h��h��h��h��h��h��h��h��h��h��h��h��h��P�������������  ���������H��X��h��`��h��`��h��`��h��`��h��h��h��`��`��`��`��h��X������������  ������p��H��P��h��`��`��`��`��`��`��h��`��`��`��`��h��h��`��h��X��������������  ������p��H��P��h��`��`��`��`��`��`��h��`��`��`��`��h��h��`��h��X��������������  ������h��P��X��x��x��x��h��h��h��h��h��h��h��h��`��`��`��`��`��`��X�����������  ������X��X��X�����������������x��x��x��x��x��x��h��h��h��h��h��h��X�����������  ������X��h��`�����������������������������������x��x��x��x��x��x��h�����������  ������X��h��`��������������������������������������������x��x��x��h�����������  ������X�����������������������������������������������������������������������  ������`����������������������������������������������������������������������  ������`����������������������������������������������������������������������  ������`����������������������������������������������������������������������  ������������������������������������������������������������������������������  ���������������������������������������������������������������x��������������  ������������������������������������������������������������������������������  ��������������舨舨舨萨萨舘����������������������������������������������  ������������������������������������������������������������������������������  ������������������������������������������������������������������������������  BMF      v   (   $   $                                   �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� �����������������������������������������������    ��������������� DDDD ������������DDDDDD@����������DDDDDDDD@����������DDO������D��������DDO������D@��������DDDO������DD������DDDDD���DDDD@������DDDDD���DDDD@������DDDDDD���DDDDD�����DDDDDD���DDDDD�����DDDDDD���DDDDD����DDDDDD���DDDDD@����DDDDDD���DDDDD@����DDDDDD���DDDDD@����DDDDDD���DDDDD@����DDDDDD���DDDDD@����DDDDDD���DDDDD@����DDDDDD���DDDDD@����DDDDO����DDDDD@�����DDDDO����DDDDD�����DDDDDDDDDDDDDD�����DDDDDDDDDDDDDD�����DDDDD��DDDDD@������DDDDO���DDDD@�������DDDD����DDDD�������DDD����DDD@���������DDD����DDD���������DDO���DD@����������DD��DD@������������ DDDD ��������������    ����������������������������������������������� 0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _1VI1BS66T10109115655        %      �      M  �          K  B  v          X               COMMENT RESERVED                        f                                                                    v                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      label      lbllabel      label      1      Class      Pixels      lbllabel     _memberdata XML Metadata for customizable properties
typetext Type of text to assign to caption property; choices TEXT or PATH
trimtext Indicator to trim text to fit inside label width
*caption_assign 
*settextwidth Sets the width of the caption text based on width of label
     M���    4  4                        I�   %         �  8   [          �  U  q  ��  � %�C�  �R�  *��: � T� � �C�  C�  >�=�� �R � T� � ��  �� � T� � �C �  � � �� U 	 TCCAPTION THIS TOOLTIPTEXT CAPTION SETTEXTWIDTH� ��  � �� � � � � %�� � ���� H�7 ��� �� � � PATH���� T� �C� :\�  ��� %�� � ���� T� �� ��� T� �� �� T� ��  �� T� �C�  � =� ..�� +�C �  � �	 � �
 ���� T� �� ���0 +�C�  � � �\� \� � � C�  >	��&� T� �� ��� � %�C�  � � �\� \��Y� T�  �� �� !� � T� �� C�  � � \�� %�C � � �	 � �
 ���� T�  �� �� !� � � � �� � � TEXT���� T� ��  �� +�C � � �	 � �
 ���� %�C� �R� ...��#� T� �C� C� >�=�� � T� �C�  � ��� %�� � ��i� T� �C� � �=� ...�� ��� T� �C� C� >�=� ...�� � � T�  �� �� � �	 B��  �� U 	 TCCAPTION LNNDX LCDRIVE	 LCCAPTION LNSTART THIS TRIMTEXT TYPETEXT THISFORM	 TEXTWIDTH WIDTH  T�  � ��  �� U  THIS CAPTION caption_assign,     �� settextwidth�     �� Init�    ��1 q ��� A �2 q 1� �A� � ��A �� A A ��� A A A A �� ���A A�� �A A � A A � 2 1                       �      	   �   �  
   6       9    )   4                       ZCaption = "Label1"
Height = 17
Width = 100
_memberdata =      219<VFPData><memberdata name="settextwidth" type="method" display="SetTextWidth"/><memberdata name="typetext" type="property" display="TypeText"/><memberdata name="trimtext" type="property" display="TrimText"/></VFPData>

typetext = TEXT
trimtext = .T.
Name = "lbllabel"
     !PROCEDURE caption_assign
LPARAMETERS tcCaption
IF RIGHT(tcCaption,2) = " *"
	this.ToolTipText = LEFT(tcCaption,LEN(tcCaption)-2)
ELSE
	this.ToolTipText = tcCaption
ENDIF
this.Caption = this.SetTextWidth(tcCaption)
ENDPROC
PROCEDURE settextwidth
LPARAMETERS tcCaption
LOCAL lnNdx, lcDrive, lcCaption, lnStart
IF this.TrimText
	DO CASE
		CASE this.TypeText = "PATH"
			lnStart = ATC(":\",tcCaption)
			IF lnStart > 0
				lnStart = lnStart + 1
				lnNdx   = 0
				lcCaption = tcCaption
				lcDrive = LEFT(tcCaption,lnStart) + ".."
				DO WHILE thisform.TextWidth(tcCaption) > this.width
					lnNdx = lnNdx + 1
					DO WHILE SUBSTR(tcCaption,lnStart+lnNdx,1) != "\" .AND. lnStart+lnNdx <= LEN(tcCaption)
						lnNdx = lnNdx + 1
					ENDDO
					IF SUBSTR(tcCaption,lnStart+lnNdx,1) != "\"
						tcCaption = lcCaption
						EXIT
					ENDIF
					lcCaption = lcDrive + SUBSTR(tcCaption,lnStart+lnNdx)
					IF thisform.TextWidth(lcCaption) <= this.width
						tcCaption = lcCaption
						EXIT
					ENDIF
				ENDDO
			ENDIF

		CASE this.TypeText = "TEXT"
			lcCaption = tcCaption
			DO WHILE thisform.TextWidth(lcCaption) > this.width
				IF RIGHT(lcCaption,3) = "..."
					lcCaption = LEFT(lcCaption,LEN(lcCaption)-3)
				ENDIF
				lnNdx = RATC(" ",lcCaption)
				IF lnNdx > 0
					lcCaption = LEFT(lcCaption,lnNdx-1) + "..."
				ELSE
					lcCaption = LEFT(lcCaption,LEN(lcCaption)-3) + "..."
				ENDIF
			ENDDO
			tcCaption = lcCaption
	ENDCASE
ENDIF
RETURN tcCaption
ENDPROC
PROCEDURE Init
this.Caption = " "
ENDPROC
0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _1CW0VU7I7 960859382k      �  }      �  )  �  �    �  ^  G  �          P               COMMENT RESERVED                                                                                            &                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      	imagelist      folderlistkey_access
      1      Pixels      Class      
olecontrol      	imagelist      
olecontrol      LOLEObject = C:\Program Files\GKK Industries\GKK Bible Scanner\mscomctl.ocx
      �_memberdata XML Metadata for customizable properties
folderlistkey Auto key for oleImageList
^itemlist[1,0] List collection
*addlistitem Adds item to list
*removeall Removes all rows
*folderlistkey_access 
     ����    �  �                        ��   %   �      (     
          �  U  �  ��  � � � � � T�  ��  ���* ��C �  � �  �  �  �  � � � � �� � �	 ��  �� T� �	 ��  ��� ��	 B��  �� U
  PNINDEX
 PCITEMTEXT
 PCFULLTEXT PNICON PNINDENT THIS
 COMBOITEMS ADD FOLDERLISTKEY ITEMLIST9  ��C�  � � �� �  � ���� T�  � �����  �� U  THIS
 COMBOITEMS CLEAR ITEMLIST4  T�  � ��  � ��� B�� _C�  � �� 0��� U  THIS FOLDERLISTKEY addlistitem,     ��	 removeall    �� folderlistkey_accessw    ��1 q�a� 2 a2 q�1                               1  {  	      �  �      )   �                       	PROCEDURE addlistitem
LPARAMETERS pnIndex,pcItemText,pcFullText,pnIcon,pnIndent
pnIndex = pnIndex + 1
this.ComboItems.Add(pnIndex,this.FolderListKey,pcItemText,pnIcon,pnIcon,pnIndent)
DIMENSION this.ItemList[pnIndex]
this.ItemList[pnIndex] = pcFullText
RETURN pnIndex
ENDPROC
PROCEDURE removeall
this.ComboItems.Clear()
DIMENSION this.ItemList[1]
this.ItemList[1] = ""
ENDPROC
PROCEDURE folderlistkey_access
this.FolderListKey = this.FolderListKey + 1
RETURN "_" + PADL(this.FolderListKey,5,"0")
ENDPROC
     �Height = 24
Width = 100
_memberdata =      291<VFPData><memberdata name="itemlist" type="property" display="ItemList"/><memberdata name="addlistitem" type="method" display="AddListItem"/><memberdata name="removeall" type="method" display="RemoveAll"/><memberdata name="folderlistkey" type="property" display="FolderListKey"/></VFPData>

folderlistkey = .T.
Name = "imagelist"
     
 ��ࡱ�                >  ��	                               ����        ��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������R o o t   E n t r y                                               ��������                               `���2'�   @       O l e O b j e c t D a t a                                            ����                                        z        A c c e s s O b j S i t e D a t a                             &  ������������                                       \        C h a n g e d P r o p s                                         ������������                                       %             ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������f��ݔ���j ��(6(!C4   V
  {  $�U   :           �ͫ   \-Tw\                          $   8                       9368265E-85FE-11d1-8BE3-0000F8754DA1    ��      ��      4�      v�        �   Text    H       Olecontrol1   T�      z�      �      o   �  ��    O l e c o n t r o l 1     ��  �       v�      D�      
�      ��      ��      l     B�      
�      ��      z     ��      ��      ��      ��      �      �      �|           0M      $�      $�      ��      n�      $�      BM      v   (               �  #  #              �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ������wwwwwwp   �����           �����������    �wwwwww���    �     �����    ������wwww    ����������    �wx������    ��������7w    ����������    wwx����    ������  �      wwx����0D    w�����˳    ������  �     ��������0          ���0    ��������� �    �����ww �   ���ww�ww�     ������������   ��        ��   ������������   ������������   ��        ��      %   �       &       *Y?�  �  U  �  ��  � � � � �� � %�C�t���S �( T� ��  CC� � �� �6� � �$�� �} �" T� ��  CC� � �� �6�$�� �	 B�� �� U  TNPIXELS
 TLVERTICAL
 TCFONTNAME
 TNFONTSIZE LNFOXELS GKTPixelsToFoxels,     �� 1 1q �� !A � 1                    x  v     BM6      6  (                  #  #         {   �   �   �  �  � � �  � � � � s 1� !� � � � � 1{! Z�! �! �! !{) 9�) R�) )�) J�) R�) �) �) !�) B�1 9�1 1�1 !�1 1�1 !�1 !�9 �9 9�9 )�9 k�B �B 1�B 9�B B�B )�B Z�J B�J {�J s�J ��J R�J 1�J RRR kcR 9�R 1�R 9�R ZZZ {sZ �Z c�Z ��Z !�Z J�Z 9�Z ccc skc �sc �sc c�c s�c B�c !Jk kkk ksk c�k B�k J�k B�k J�k )Zs J�s )J{ 1k{ Bk{ ss{ ��{ ��{ ��{ {�{ Z�{ c�{ R�{ B� )R� Rc� �� έ� s�� sք R� Z�  B� )Z� Bk� ��� ��� !J�  R� !R� !c� k�� )c� J�� s�� ��� ��� 1�� Ƶ�  c� c�  k� s� J�� ��� ��  k� k� s� !s� �� ��� s�  {� !{� ){� !�� 1�� 9�� ƽ� ��  {� �� !�� �� c�� s�� �ƽ  �� �� )�� �� B�� ��� �� �� )��  �� �� �� �� ��� ��� �� �� �� )�� !�� 9�� Z�� c�� ��� ��� ��� �� !�� )�� B�� 1�� J�� B�� B�� ��� ��� ��� )�� 9�� B�� 1�� 9�� B�� R�� c�� k�� 9�� J�� B�� J�� R�� Z�� k�� J�� J�� R�� � � Z�� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� ��� �������������������������ui����������ф�a��jo{�������Ѷ�{������������p��������ib�����n����t}��|q��������˺LS���������&��˺LV�����?	 9x���DW�����P#9'>.y7G�����PTC9/%*�����(#TTfe����рr_P�
I������JPP�-%��������]P�l05H����������JmE4��������0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Screen                                                                                            WINDOWS _2BW0W2JCT 9474196818      O  f      }                          �      �                       WINDOWS _2BW0W2JCU1129537249�      �              {  �S                  �                      _   WINDOWS _2BW0W2JCT1078489838q      ~  �  �  �                                                           WINDOWS _2BW0W2JCT1129537249  $  I  Y  n  �                                                           WINDOWS _2BW0WEMVM1129537249"  3  X  h  }  �                                                           WINDOWS _2BW0WEMVN11295372491  B  g  w  �  �                                                           WINDOWS _2BW0WEMVO1129537249@  Q  v  �  �  �                                                           WINDOWS _2BW0WEMVP1129537249O  `  �  �  �  �                                                           WINDOWS _2BW0W2JCT1129537249^  o  �  �  �  �                                                           WINDOWS _2BW0W2JCT1129537249�  �  �  �  �  �      _  �7                                               WINDOWS _2BW0W2JCT1078489838�J      �J  �J  �J  �J                                                           WINDOWS _2BW0W2JCT1129537249&K  7K  \K  lK  �K  �K      3L  J                                               WINDOWS _2E30YVJI11078489838,O      9O  FO  TO  gO                                                           WINDOWS _2BW0W2JCT1129537249�O      �O  �O  �O  P                                                           WINDOWS _2BW0W2JCT1129537249�P      �P  �P  �P  �P                                                           WINDOWS _2BW0W2JCT1129537249bQ  sQ  �Q  �Q  �Q  �Q      wR  ,                                               WINDOWS _2LR1AK4L61129537249�S  O  �N  �N  �N  �R                                                           WINDOWS _2BW0W2JCT1129537249�N  �N  �N  uN  bN  �M                                                           WINDOWS _2BW0W2JCT1129537249�M  �M  qM  XM  L  �                                                           WINDOWS _2BW0W2JCT1129537249�  k  [  C  0  �                                                           WINDOWS _3WN0PJI5W1129537249s  N  >  '    j                                                           COMMENT RESERVED                                A                                                          Y�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      ..\programs\gktdefines.h      dataenvironment      dataenvironment      Dataenvironment      YTop = 0
Left = 0
Width = 0
Height = 0
DataSource = .NULL.
Name = "Dataenvironment"
      1      1      form      form      gkkbuildall     XBorderStyle = 3
Height = 545
Width = 148
DoCreate = .T.
AutoCenter = .T.
Caption = "GKK Tools"
MaxButton = .T.
MinButton = .T.
Icon = ..\graphics\gktgkt.ico
AllowOutput = .F.
Dockable = 1
_memberdata = <VFPData><memberdata name="setprojectversioninfo" type="method" display="SetProjectVersionInfo"/></VFPData>
Name = "gkkbuildall"
     �PROCEDURE setprojectversioninfo
LPARAMETERS tcProjVerFile
LOCAL lcBldVers, lcVersion, lcRelease, lcBuild, lcVersNum, lcFile, lcSetup, lnNum, lnDash, lnLine
LOCAL ARRAY lcLines[1]
lcBldVers = TRANSFORM(thisform.txtVersion.Value)
WITH _VFP.ActiveProject
	lcVersion = GETWORDNUM(.VersionNumber,1,".")
	IF lcVersion != lcBldVers
		lcVersion = lcBldVers
	ENDIF
	lcRelease = GETWORDNUM(.VersionNumber,2,".")
	IF thisform.chkReleaseBuild.Value
		lcRelease = TRANSFORM(INT(VAL(lcRelease))+1)
	ENDIF
	lcBuild   = TRANSFORM(INT(VAL(GETWORDNUM(.VersionNumber,3,".")))+1)
	lcVersNum = lcVersion + "." + lcRelease + "." + lcBuild
	.VersionNumber = lcVersNum
	.Debug     = thisform.chkDebug.Value
	.Encrypted = thisform.chkReleaseBuild.Value
	.Close()
ENDWITH
STRTOFILE(lcVersNum,tcProjVerFile,0)

IF thisform.chkReleaseBuild.Value
	lcFile = ".\GKKTools\Setup\" + FORCEEXT(tcProjVerFile,"iss")
	IF FILE(lcFile)
		lcSetup = FILETOSTR(lcFile)
		lnNum   = ALINES(lcLines,lcSetup,True)
		lcSetup = lcLines[1]
		lcSetup = lcSetup + CRLF + '#define MyAppVersion   "' + lcVersNum + '"'
		lnDash  = ATC("-",lcLines[3]) - 1
		lcSetup = lcSetup + CRLF + '#define MyAppVerName   "GKK Tools '  + lcVersNum + SUBSTR(lcLines[3],lnDash)
		FOR lnLine=4 TO lnNum
			lcSetup = lcSetup + CRLF + lcLines[lnLine]
		ENDFOR
		STRTOFILE(lcSetup,lcFile)
	ENDIF
ENDIF
ENDPROC
PROCEDURE Destroy
SET SAFETY OFF
STRTOFILE(TRANSFORM(thisform.txtVersion.Value),"Version.txt")
SET DEFAULT TO "E:\MY WORK\FOXPRO"
ENDPROC
PROCEDURE Init
SET SAFETY OFF
SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS"
thisform.txtVersion.Value = INT(VAL(FILETOSTR(".\EDITORS\Version.txt")))
thisform.Dock(1)
ENDPROC
     ���    �   �                         s{   %   �       �      �           �  U  ?  T�  � � �� � 
�� %�� � ��8 � T�  � � �-�� � U  THISFORM CHKDEBUG ENABLED THIS VALUE Click,     ��1 qA 1                       p       )   �                        ����    �  �                        ��   %   4      c  
   O          �  U  �  ���  ��� � T�� � �� � �� T�� � �� � �� T�� � �� � �� T�� � �� � �� T�� � �� � �� T�� � �� � �� �� U	  THISFORM CHKGKKCOMPARE VALUE THIS CHKGKKEDITMNU CHKGKKEDITSCX CHKGKKEDITVCX CHKGKKEDITPRG CHKGKKPROJECTMANAGER InteractiveChange,     ��1 � AAAAAAA 1                             )   �                        "  ..\programs\gktdefines.h��|0?      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      �Top = 296
Left = 10
Height = 17
Width = 120
AutoSize = .T.
Alignment = 0
Caption = "GKKTableBrowser"
Value = .F.
TabIndex = 14
Name = "chkTableBrowser"
      gkkbuildall      chkTableBrowser      checkbox      ..\classes\gktbaseclasses.vcx      	_checkbox      �Top = 278
Left = 10
Height = 17
Width = 125
AutoSize = .T.
Alignment = 0
Caption = "GKKTableDesigner"
Value = .F.
TabIndex = 13
Name = "chkTableDesigner"
      gkkbuildall      chkTableDesigner      checkbox      ..\classes\gktbaseclasses.vcx      	_checkbox      �Top = 260
Left = 10
Height = 17
Width = 110
AutoSize = .T.
Alignment = 0
Caption = "GKKCodeLibrary"
Value = .F.
TabIndex = 12
Name = "chkGKKCodeLibrary"
      gkkbuildall     �_memberdata = <VFPData><memberdata name="AllowOutput" type="property" display="AllowOutput"/><memberdata name="AutoCenter" type="property" display="AutoCenter"/><memberdata name="BorderStyle" type="property" display="BorderStyle"/><memberdata name="Caption" type="property" display="Caption"/><memberdata name="DoCreate" type="property" display="DoCreate"/><memberdata name="Dockable" type="property" display="Dockable"/><memberdata name="Height" type="property" display="Height"/><memberdata name="Icon" type="property" display="Icon"/><memberdata name="MaxButton" type="property" display="MaxButton"/><memberdata name="MinButton" type="property" display="MinButton"/><memberdata name="Name" type="property" display="Name"/><memberdata name="Width" type="property" display="Width"/><memberdata name="setprojectversioninfo" type="method" display="SetProjectVersionInfo"/></VFPData>
FormDescription =
UserNotes =       p_memberdata XML Metadata for customizable properties
*setprojectversioninfo Sets the project verso/build info
      shape      shape      Shape1      gkkbuildall      _Top = 103
Left = 4
Height = 241
Width = 140
SpecialEffect = 0
Style = 0
Name = "Shape1"
      	_checkbox      ..\classes\gktbaseclasses.vcx      checkbox      chkGKKCompare      gkkbuildall      �Top = 134
Left = 10
Height = 17
Width = 95
AutoSize = .T.
Alignment = 0
Caption = "GKKCompare"
Value = .F.
TabIndex = 5
Name = "chkGKKCompare"
      	_checkbox      ..\classes\gktbaseclasses.vcx      checkbox      chkGKKEditMNU      gkkbuildall      �Top = 152
Left = 10
Height = 17
Width = 91
AutoSize = .T.
Alignment = 0
Caption = "GKKEditMNU"
Value = .F.
TabIndex = 6
Name = "chkGKKEditMNU"
      	_checkbox      ..\classes\gktbaseclasses.vcx      checkbox      chkGKKEditSCX      gkkbuildall      �Top = 170
Left = 10
Height = 17
Width = 88
AutoSize = .T.
Alignment = 0
Caption = "GKKEditSCX"
Value = .F.
TabIndex = 7
Name = "chkGKKEditSCX"
      	_checkbox      ..\classes\gktbaseclasses.vcx      checkbox      chkGKKEditVCX      gkkbuildall      �Top = 188
Left = 10
Height = 17
Width = 87
AutoSize = .T.
Alignment = 0
Caption = "GKKEditVCX"
Value = .F.
TabIndex = 8
Name = "chkGKKEditVCX"
      	_checkbox      ..\classes\gktbaseclasses.vcx      checkbox      chkGKKEditPRG      gkkbuildall      �Top = 206
Left = 10
Height = 17
Width = 90
AutoSize = .T.
Alignment = 0
Caption = "GKKEditPRG"
Value = .F.
TabIndex = 9
Name = "chkGKKEditPRG"
      	_checkbox      ..\classes\gktbaseclasses.vcx      checkbox      chkGKKProjectManager      gkkbuildall      �Top = 224
Left = 10
Height = 17
Width = 101
AutoSize = .T.
Alignment = 0
Caption = "GKKProjectMgr"
Value = .F.
TabIndex = 10
Name = "chkGKKProjectManager"
      _commandbutton      ..\classes\gktbaseclasses.vcx      commandbutton      cmdBuild      gkkbuildall      dTop = 317
Left = 26
Height = 20
Width = 95
Caption = "Build"
TabIndex = 15
Name = "cmdBuild"
     �PROCEDURE Click
LOCAL loException
TRY
	IF thisform.chkTableDesigner.Value
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS"
		WAIT WINDOW "Building GKKTableDesigner..." NOCLEAR NOWAIT
		ERASE GKKTableDesigner.app
		USE GKKTableDesigner.pjx IN 0 EXCLUSIVE ALIAS gkkproj
		SELECT gkkproj
		PACK
		PACK MEMO
		USE

		MODIFY PROJECT GKKTableDesigner.pjx NOWAIT NOSHOW NOPROJECTHOOK
*		thisform.SetProjectVersionInfo("GKKEditVCX.ver")

		BUILD APP GKKTableDesigner.app FROM GKKTableDesigner.pjx RECOMPILE
		MODIFY PROJECT GKKTableDesigner.pjx NOWAIT NOSHOW NOPROJECTHOOK
		WITH _VFP.ActiveProject
			.Encrypted = False
			.Debug = True
			.Close()
		ENDWITH
	ENDIF
	
	IF thisform.chkTableBrowser.Value
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS"
		WAIT WINDOW "Building GKKTableBrowser..." NOCLEAR NOWAIT
		ERASE GKKTableBrowser.app
		USE GKKTableBrowser.pjx IN 0 EXCLUSIVE ALIAS gkkproj
		SELECT gkkproj
		PACK
		PACK MEMO
		USE

		MODIFY PROJECT GKKTableBrowser.pjx NOWAIT NOSHOW NOPROJECTHOOK
*		thisform.SetProjectVersionInfo("GKKEditVCX.ver")

		BUILD APP GKKTableBrowser.app FROM GKKTableBrowser.pjx RECOMPILE
		MODIFY PROJECT GKKTableBrowser.pjx NOWAIT NOSHOW NOPROJECTHOOK
		WITH _VFP.ActiveProject
			.Encrypted = False
			.Debug = True
			.Close()
		ENDWITH
	ENDIF

	IF thisform.chkGKKCodeLibrary.Value
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\CODELIBRARY"
		WAIT WINDOW "Building GKKCodeLibrary..." NOCLEAR NOWAIT
		ERASE GKKCodeLibrary.app
		USE GKKCodeLibrary.pjx IN 0 EXCLUSIVE ALIAS gkkproj
		SELECT gkkproj
		PACK
		PACK MEMO
		USE

		MODIFY PROJECT GKKCodeLibrary.pjx NOWAIT NOSHOW NOPROJECTHOOK
*		thisform.SetProjectVersionInfo("GKKEditVCX.ver")

		BUILD APP GKKCodeLibrary.app FROM GKKCodeLibrary.pjx RECOMPILE
		MODIFY PROJECT GKKCodeLibrary.pjx NOWAIT NOSHOW NOPROJECTHOOK
		WITH _VFP.ActiveProject
			.Encrypted = False
			.Debug = True
			.Close()
		ENDWITH
	ENDIF

	IF thisform.chkGKKCopyClipMgr.Value
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS"
		WAIT WINDOW "Building GKKCopyClipMgr..." NOCLEAR NOWAIT
		ERASE GKKCopyClipMgr.app
		USE GKKCopyClipMgr.pjx IN 0 EXCLUSIVE ALIAS gkkproj
		SELECT gkkproj
		PACK
		PACK MEMO
		USE

		MODIFY PROJECT GKKCopyClipMgr.pjx NOWAIT NOSHOW NOPROJECTHOOK
*		thisform.SetProjectVersionInfo("GKKEditVCX.ver")

		BUILD APP GKKCopyClipMgr.app FROM GKKCopyClipMgr.pjx RECOMPILE
		MODIFY PROJECT GKKCopyClipMgr.pjx NOWAIT NOSHOW NOPROJECTHOOK
		WITH _VFP.ActiveProject
			.Encrypted = False
			.Debug = True
			.Close()
		ENDWITH
	ENDIF

	IF thisform.chkGKKCompare.Value
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\COMPARISON"
		WAIT WINDOW "Building GKKCompare..." NOCLEAR NOWAIT
		ERASE GKKCompare.app
		USE GKKCompare.pjx IN 0 EXCLUSIVE ALIAS gkkproj
		SELECT gkkproj
		PACK
		PACK MEMO
		USE

		MODIFY PROJECT GKKCompare.pjx NOWAIT NOSHOW NOPROJECTHOOK
		thisform.SetProjectVersionInfo("GKKCompare.ver")

		BUILD APP GKKCompare.app FROM GKKCompare.pjx RECOMPILE
		MODIFY PROJECT GKKCompare.pjx NOWAIT NOSHOW NOPROJECTHOOK
		WITH _VFP.ActiveProject
			.Encrypted = False
			.Debug = True
			.Close()
		ENDWITH
	ENDIF

	IF thisform.chkGKKEditMNU.Value
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS"
		WAIT WINDOW "Building GKKEditMNU..." NOCLEAR NOWAIT
		ERASE GKKEditMNU.app
		USE GKKEditMNU.pjx IN 0 EXCLUSIVE ALIAS gkkproj
		SELECT gkkproj
		PACK
		PACK MEMO
		USE

		MODIFY PROJECT GKKEditMNU.pjx NOWAIT NOSHOW NOPROJECTHOOK
		thisform.SetProjectVersionInfo("GKKEditMNU.ver")

		BUILD APP GKKEditMNU.app FROM GKKEditMNU.pjx RECOMPILE
		MODIFY PROJECT GKKEditMNU.pjx NOWAIT NOSHOW NOPROJECTHOOK
		WITH _VFP.ActiveProject
			.Encrypted = False
			.Debug = True
			.Close()
		ENDWITH
	ENDIF

	IF thisform.chkGKKEditSCX.Value
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS"
		WAIT WINDOW "Building GKKEditSCX..." NOCLEAR NOWAIT
		ERASE GKKEditSCX.app
		USE GKKEditSCX.pjx IN 0 EXCLUSIVE ALIAS gkkproj
		SELECT gkkproj
		PACK
		PACK MEMO
		USE

		MODIFY PROJECT GKKEditSCX.pjx NOWAIT NOSHOW NOPROJECTHOOK
		thisform.SetProjectVersionInfo("GKKEditSCX.ver")

		BUILD APP GKKEditSCX.app FROM GKKEditSCX.pjx RECOMPILE
		MODIFY PROJECT GKKEditSCX.pjx NOWAIT NOSHOW NOPROJECTHOOK
		WITH _VFP.ActiveProject
			.Encrypted = False
			.Debug = True
			.Close()
		ENDWITH
	ENDIF

	IF thisform.chkGKKEditVCX.Value
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS"
		WAIT WINDOW "Building GKKEditVCX..." NOCLEAR NOWAIT
		ERASE GKKEditVCX.app
		USE GKKEditVCX.pjx IN 0 EXCLUSIVE ALIAS gkkproj
		SELECT gkkproj
		PACK
		PACK MEMO
		USE

		MODIFY PROJECT GKKEditVCX.pjx NOWAIT NOSHOW NOPROJECTHOOK
		thisform.SetProjectVersionInfo("GKKEditVCX.ver")

		BUILD APP GKKEditVCX.app FROM GKKEditVCX.pjx RECOMPILE
		MODIFY PROJECT GKKEditVCX.pjx NOWAIT NOSHOW NOPROJECTHOOK
		WITH _VFP.ActiveProject
			.Encrypted = False
			.Debug = True
			.Close()
		ENDWITH
	ENDIF

	IF thisform.chkGKKEditPRG.Value
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS"
		WAIT WINDOW "Building GKKEditPRG..." NOCLEAR NOWAIT
		ERASE GKKEditPRG.app
		USE GKKEditPRG.pjx IN 0 EXCLUSIVE ALIAS gkkproj
		SELECT gkkproj
		PACK
		PACK MEMO
		USE

		MODIFY PROJECT GKKEditPRG.pjx NOWAIT NOSHOW NOPROJECTHOOK
		thisform.SetProjectVersionInfo("GKKEditPRG.ver")

		BUILD APP GKKEditPRG.app FROM GKKEditPRG.pjx RECOMPILE
*-*			MODIFY PROJECT GKKEditPRG.pjx NOWAIT NOSHOW NOPROJECTHOOK
*-*			WITH _VFP.ActiveProject
*-*				.SetMain("gkkeditprgmainexe.prg")
*-*				.Close()
*-*			ENDWITH
*-*			BUILD EXE GKKEditPRG1.exe FROM GKKEditPRG.pjx RECOMPILE


		MODIFY PROJECT GKKEditPRG.pjx NOWAIT NOSHOW NOPROJECTHOOK
		WITH _VFP.ActiveProject
*-*				.SetMain("gkkeditprg.prg")
			.Encrypted = False
			.Debug = True
			.Close()
		ENDWITH

	ENDIF

	IF thisform.chkGKKProjectManager.Value
		SET DEFAULT TO "E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\PROJECTMANAGER"
		WAIT WINDOW "Building GKKProjectManager..." NOCLEAR NOWAIT
		ERASE GKKProjectManager.app
		USE GKKProjectManager.pjx IN 0 EXCLUSIVE ALIAS gkkproj
		SELECT gkkproj
		PACK
		PACK MEMO
		USE

		MODIFY PROJECT GKKProjectManager.pjx NOWAIT NOSHOW NOPROJECTHOOK
		thisform.SetProjectVersionInfo("GKKProjectManager.ver")

		BUILD APP GKKProjectManager.app FROM GKKProjectManager.pjx RECOMPILE
		MODIFY PROJECT GKKProjectManager.pjx NOWAIT NOSHOW NOPROJECTHOOK
		WITH _VFP.ActiveProject
			.Encrypted = False
			.Debug = True
			.Close()
		ENDWITH
	ENDIF

CATCH TO loException
	WAIT CLEAR
	GKTDisplayMsg("Unable to build file: " + loException.Message)
ENDTRY
WAIT CLEAR
ENDPROC
     ����    w  w                        �   %   �      .  �   �          �  U  � ��  � ��^� %�� � � ��}�6 G(��+ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS��( R,�:�� Building GKKTableDesigner...��  � GKKTableDesigner.app�% Q�  �� GKKTableDesigner.pjx� � F� � 3� 3� Q� /�� GKKTableDesigner.pjx:]��5 ��� GKKTableDesigner.app� GKKTableDesigner.pjx�� /�� GKKTableDesigner.pjx:]�� ���C� ��y� T��	 �-�� T��
 �a�� ��C�� �� �� � %�� � � ����6 G(��+ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS��' R,�:�� Building GKKTableBrowser...��  � GKKTableBrowser.app�$ Q�  �� GKKTableBrowser.pjx� � F� � 3� 3� Q� /�� GKKTableBrowser.pjx:]��3 ��� GKKTableBrowser.app� GKKTableBrowser.pjx�� /�� GKKTableBrowser.pjx:]�� ���C� ���� T��	 �-�� T��
 �a�� ��C�� �� �� � %�� � � ��P�: G(��/ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\CODELIBRARY��& R,�:�� Building GKKCodeLibrary...��  � GKKCodeLibrary.app�# Q�  �� GKKCodeLibrary.pjx� � F� � 3� 3� Q� /�� GKKCodeLibrary.pjx:]��1 ��� GKKCodeLibrary.app� GKKCodeLibrary.pjx�� /�� GKKCodeLibrary.pjx:]�� ���C� ��L� T��	 �-�� T��
 �a�� ��C�� �� �� � %�� � � ����6 G(��+ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS��& R,�:�� Building GKKCopyClipMgr...��  � GKKCopyClipMgr.app�# Q�  �� GKKCopyClipMgr.pjx� � F� � 3� 3� Q� /�� GKKCopyClipMgr.pjx:]��1 ��� GKKCopyClipMgr.app� GKKCopyClipMgr.pjx�� /�� GKKCopyClipMgr.pjx:]�� ���C� ���� T��	 �-�� T��
 �a�� ��C�� �� �� � %�� � � ���9 G(��. E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\COMPARISON��" R,�:�� Building GKKCompare...��  � GKKCompare.app� Q�  �� GKKCompare.pjx� � F� � 3� 3� Q� /�� GKKCompare.pjx:]�� ��C� GKKCompare.ver� � ��) ��� GKKCompare.app� GKKCompare.pjx�� /�� GKKCompare.pjx:]�� ���C� ��� T��	 �-�� T��
 �a�� ��C�� �� �� � %�� � � ����6 G(��+ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS��" R,�:�� Building GKKEditMNU...��  � GKKEditMNU.app� Q�  �� GKKEditMNU.pjx� � F� � 3� 3� Q� /�� GKKEditMNU.pjx:]�� ��C� GKKEditMNU.ver� � ��) ��� GKKEditMNU.app� GKKEditMNU.pjx�� /�� GKKEditMNU.pjx:]�� ���C� ��� T��	 �-�� T��
 �a�� ��C�� �� �� � %�� � � ���	�6 G(��+ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS��" R,�:�� Building GKKEditSCX...��  � GKKEditSCX.app� Q�  �� GKKEditSCX.pjx� � F� � 3� 3� Q� /�� GKKEditSCX.pjx:]�� ��C� GKKEditSCX.ver� � ��) ��� GKKEditSCX.app� GKKEditSCX.pjx�� /�� GKKEditSCX.pjx:]�� ���C� ���	� T��	 �-�� T��
 �a�� ��C�� �� �� � %�� � � ��O�6 G(��+ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS��" R,�:�� Building GKKEditVCX...��  � GKKEditVCX.app� Q�  �� GKKEditVCX.pjx� � F� � 3� 3� Q� /�� GKKEditVCX.pjx:]�� ��C� GKKEditVCX.ver� � ��) ��� GKKEditVCX.app� GKKEditVCX.pjx�� /�� GKKEditVCX.pjx:]�� ���C� ��K� T��	 �-�� T��
 �a�� ��C�� �� �� � %�� � � ����6 G(��+ E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\EDITORS��" R,�:�� Building GKKEditPRG...��  � GKKEditPRG.app� Q�  �� GKKEditPRG.pjx� � F� � 3� 3� Q� /�� GKKEditPRG.pjx:]�� ��C� GKKEditPRG.ver� � ��) ��� GKKEditPRG.app� GKKEditPRG.pjx�� /�� GKKEditPRG.pjx:]�� ���C� ���� T��	 �-�� T��
 �a�� ��C�� �� �� � %�� � � ��Z�= G(��2 E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS\PROJECTMANAGER��) R,�:�� Building GKKProjectManager...��  � GKKProjectManager.app�& Q�  �� GKKProjectManager.pjx� � F� � 3� 3� Q�  /�� GKKProjectManager.pjx:]��% ��C� GKKProjectManager.ver� � ��7 ��� GKKProjectManager.app� GKKProjectManager.pjx��  /�� GKKProjectManager.pjx:]�� ���C� ��V� T��	 �-�� T��
 �a�� ��C�� �� �� � �(�  ��� R�* ��C� Unable to build file: �  �  � �� �� R� U!  LOEXCEPTION THISFORM CHKTABLEDESIGNER VALUE GKKTABLEDESIGNER APP PJX GKKPROJ ACTIVEPROJECT	 ENCRYPTED DEBUG CLOSE CHKTABLEBROWSER GKKTABLEBROWSER CHKGKKCODELIBRARY GKKCODELIBRARY CHKGKKCOPYCLIPMGR GKKCOPYCLIPMGR CHKGKKCOMPARE
 GKKCOMPARE SETPROJECTVERSIONINFO CHKGKKEDITMNU
 GKKEDITMNU CHKGKKEDITSCX
 GKKEDITSCX CHKGKKEDITVCX
 GKKEDITVCX CHKGKKEDITPRG
 GKKEDITPRG CHKGKKPROJECTMANAGER GKKPROJECTMANAGER GKTDISPLAYMSG MESSAGE Click,     ��1 q � 1a��Qq A Q A �S�� � � � A A 2aq�Aq A Q A �3�� � � � A A 2�a�1q A Q A ��� � � � A A 2aa�1q A Q A ��� � � � A A 2�!Q�q A Q A ����� � � � A A 2a!Q�q A Q A ����� � � � A A 2a!Q�q A Q A ����� � � � A A 2a!Q�q A Q A ����� � � � A A 2a!Q�q A Q A ����� � � � A B 2���aq A Q A Qr� � � � A A � Q �A Q 1                       |      )   w                        shape      shape      Shape3      gkkbuildall      ]Top = 53
Left = 4
Height = 44
Width = 140
SpecialEffect = 0
Style = 0
Name = "Shape3"
      	_checkbox      ..\classes\gktbaseclasses.vcx      checkbox      chkSelectAll      gkkbuildall      �Top = 107
Left = 10
Height = 17
Width = 68
AutoSize = .T.
Alignment = 0
Caption = "Select All"
Value = .F.
TabIndex = 4
Name = "chkSelectAll"
     PROCEDURE InteractiveChange
WITH thisform
	.chkGKKCompare.Value = this.Value
	.chkGKKEditMNU.Value = this.Value
	.chkGKKEditSCX.Value = this.Value
	.chkGKKEditVCX.Value = this.Value
	.chkGKKEditPRG.Value = this.Value
	.chkGKKProjectManager.Value = this.Value
ENDWITH
ENDPROC
      chkGKKCodeLibrary      checkbox      ..\classes\gktbaseclasses.vcx      	_checkbox      �Top = 242
Left = 10
Height = 17
Width = 113
AutoSize = .T.
Alignment = 0
Caption = "GKKCopyClipMgr"
Value = .F.
TabIndex = 11
Name = "chkGKKCopyClipMgr"
      gkkbuildall      chkGKKCopyClipMgr      checkbox      ..\classes\gktbaseclasses.vcx      	_checkbox      gkkbuildall      chkDebug      checkbox      ..\classes\gktbaseclasses.vcx      shape      shape      Shape4      gkkbuildall      ]Top = 11
Left = 4
Height = 36
Width = 140
SpecialEffect = 0
Style = 0
Name = "Shape4"
      textbox      textbox      
txtVersion      gkkbuildall      �Alignment = 3
Value = 1
Height = 22
InputMask = "999"
Left = 13
SelectOnEntry = .T.
TabIndex = 1
Top = 19
Width = 105
Name = "txtVersion"
      label      label      Label1      gkkbuildall      tAutoSize = .T.
Caption = " Version "
Height = 17
Left = 10
Top = 2
Width = 50
TabIndex = 16
Name = "Label1"
      	_checkbox      ..\classes\gktbaseclasses.vcx      checkbox      chkReleaseBuild      gkkbuildall      �Top = 58
Left = 11
Height = 17
Width = 96
AutoSize = .T.
Alignment = 0
Caption = "Release Build"
Value = .F.
TabIndex = 2
Name = "chkReleaseBuild"
      {PROCEDURE Click
thisform.chkDebug.Enabled = !this.Value
IF this.Value
	thisform.chkDebug.Value = False
ENDIF
ENDPROC
      �Top = 76
Left = 11
Height = 17
Width = 86
AutoSize = .T.
Alignment = 0
Caption = "Debug Build"
Value = .T.
TabIndex = 3
Name = "chkDebug"
      	_checkbox     6���                              s�   %         �  /   V          �  U  � ��  �+ �� � � � � � � � �	 �
 � �� ���� T� �C� � � _�� ���C� ��e� T� �C�� �� .���� %�� � ��� � T� �� �� � T� �C�� �� .���� %�� � � ��� � T� �CCC� g8�_�� �" T� �CCCC�� �� .��g8�_�� T� �� � .� � .� �� T�� �� �� T�� �� � � �� T�� �� � � �� ��C�� �� �� ��C� �  � ���� %�� � � ����+ T� �� .\GKKTools\Setup\C�  � iss���� %�C� 0���� T� �C� ���� T� �C�� � a���� T� �C�� ��> T� �� C� C�
 � #define MyAppVersion   "� � "�� T�	 �C� -C�� ����P T� �� C� C�
 �" #define MyAppVerName   "GKK Tools � CC�� �	 \�� ��
 ���(�� ����" T� �� C� C�
 C �
 � �� �� ��C� � ���� � � U  TCPROJVERFILE	 LCBLDVERS	 LCVERSION	 LCRELEASE LCBUILD	 LCVERSNUM LCFILE LCSETUP LNNUM LNDASH LNLINE LCLINES THISFORM
 TXTVERSION VALUE ACTIVEPROJECT VERSIONNUMBER CHKRELEASEBUILD DEBUG CHKDEBUG	 ENCRYPTED CLOSEG  G.�" ��CC�  � � _� Version.txt���� G(�� E:\MY WORK\FOXPRO�� U  THISFORM
 TXTVERSION VALUEv  G.�. G(��# E:\MY WORK\FOXPRO\PROJECTS\GKKTOOLS��/ T�  � � �CCC� .\EDITORS\Version.txt��g8�� ��C��  � �� U  THISFORM
 TXTVERSION VALUE DOCK setprojectversioninfo,     �� Destroy    �� Init{    ��1 q �� Q� �� A �1qA !�� AA� A !2�� a��q!A � A A 2 a !�2 a ��1                    !   T     &   r  �  (   *   �  �  -    )                     BM6      6   (                              ���������������������Ơ�Îh��f��d��a��_�~\�{X�yW���������������������Ȓl��������������������������������Ť�����������آy��������������������������娨����������������٣y��������������������������������������ҽ��Ŗuۤz���������������������������������������ʚy���ܧ{ܧ{ܧ{ܧ{ܧ{ܧ{ܧ{ܧ{ܧ{���������������ة����ݭ�蹒蹒蹒蹒蹒蹒蹒蹒���������������٪����ֿ�ݴ�ܧ{ܦzڤzآyՠvҝsϚr���������������أz���������������������������������������������߱�߱�ް�ް�ް�߱�ݯ�߲�߲�ؤzో���������������ߵ�������违������违������㶐�������������������ʾὟ߱�ް�ݭ�ܬ�ש�ש�զ�͙q˦���������������������������������ꮮ���������������������������������������������������������������������������������������������������������������������������ø��������������������������������   %   U      �  )   j  �{0?  �  U  � ��  � �� � � � � � � � T� �a�� %�C�  ���
���� T� �C� \�  ��� %�C�  �=� \\��} � T� ���� �� � %�C�  ��\� :��� � T� ���� �� � T� �-�� � � T� �C�  C� \�  � ��=�� +�� � ���� ��"� %�C� ���
���
 ��� �� � �(� �9� T� �-�� �� %�� 
��O� !� � T� �� ��� T� �C�  C� \�  � ��=�� � %�� ���� ����
 ���  �� �(� ��� T� �-�� �� � �	 B�� �� U  TCDIRECTORY	 LLSUCCESS LCPATH LNLEN LNNDX LOEXCEPTION LNSLASH
 LNSLASHCNT GKTMakePath,     ��� 1 q �� A1�� � �� � � A A �!� A� A � � A � A A �A � � � � � A A A � 1                    u  �     BM�      6   (               �              ������������������������������������������������������������������������   ���   ���   ���   ���������������������������������������������������������      ������������������������������������������������������         ���������������������������������������������������   ������   ������������������                                  �� �����               ���   ������������������������������    �� ��   ���������   ���   ������������������������������    �� �����   ������   ���   ���������������������������������    �� �� ��   ���   ���   ���������������������������������    �� �����   ���   ���   ������������������������������������    �� �� ��      ���   ������������������������������������    �� �����      ���   ���������������������������������������    ��         ���   ���������������������������������������     �  �  �   ���   ���         ���������������������������     �  �  �   ���   ������������������������������������������            ���   �������  �  �  �  �  �  �  �  �  �  �  �  �  �  �     ���   �������  �  �  �  �  �  �  �  �  �  �  �  �  �  �     ���                                                         ���������������������������������������������������������������BM6      6   (                              �������������������������������������������������������������������������������������������������������������������  �  �  �  �  �  �  �  �  ����������������������  ����������������������  ����������������������  ���               ����  ���                  �  ����������������������  ���   ����������������  ���               ����  ���   ���            �  ����������������������  ���   ����������������  ���      ����  �  �  �  ���   ���            �  �������������  ����  ������   ����������������  �������������  �  ���������   ���      ���   �  �  �  �  �  �  ������������   ������������   ���   ������������������������   ������������      ���������������������������                  ������������������������������������������������������������������������������0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _1NG14ZR161062840602  �<  �<  $      	5  �  #  /          �  	  �          �      �  �   WINDOWS _1NG15NYGY1062713476�  �  o  ]  L  m
      �  �                                               WINDOWS _1NG15NYGZ1062840602�  �  l  Y  H  M        5                                               COMMENT RESERVED                        �      B                                                          <�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      "  ..\programs\gktdefines.h��|0?      DSymbol, 0, 11, 9, 19, 15, 17, 4, 0
Arial, 0, 8, 5, 14, 11, 29, 3, 0
      	mrubutton      ..\programs\gktdefines.h      'addtomru
removefrommru^
openfrommru
      Pixels      Class      3      
_container      	mrubutton      ����    �   �                         E�   %   ]       r      l           �  U    ��C�  � � �� U  THIS PARENT
 ONFILEOPEN Click,     ��1 1                       )       )   �                         4PROCEDURE Click
this.Parent.OnFileOpen()
ENDPROC
      �Top = 0
Left = 0
Height = 22
Width = 50
FontSize = 8
Picture = ..\graphics\gktfolderopen16.bmp
Caption = ""
Enabled = .T.
TabIndex = 1
ToolTipText = "Open"
Visible = .T.
SpecialEffect = 2
PicturePosition = 1
Name = "cmdOpenFile"
      	mrubutton      cmdOpenFile      commandbutton      gktbaseclasses.vcx      _commandbutton     ����    �  �                        �s   %   �      W     =          �  U    ��C�  � � �� U  THIS PARENT
 ONMRUCLICK  T�  � � � ���� U  THIS PARENT CMDOPENFILE VISUALEFFECT  T�  � � � �� �� U  THIS PARENT CMDOPENFILE VISUALEFFECT,  ��  � � � � T� � � � ���� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS PARENT CMDOPENFILE VISUALEFFECT,  ��  � � � � T� � � � �� �� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS PARENT CMDOPENFILE VISUALEFFECT Click,     �� GotFocus]     ��	 LostFocus�     ��
 MouseEnter�     ��
 MouseLeavee    ��1 2 a2 a2 1a2 1a1                       )         H   p         �   �         �   0  
   
   Q  �      )   �                       �PROCEDURE Click
this.Parent.OnMRUClick()
ENDPROC
PROCEDURE GotFocus
this.Parent.cmdOpenFile.VisualEffect = 1
ENDPROC
PROCEDURE LostFocus
this.Parent.cmdOpenFile.VisualEffect = 0
ENDPROC
PROCEDURE MouseEnter
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.Parent.cmdOpenFile.VisualEffect = 1
ENDPROC
PROCEDURE MouseLeave
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.Parent.cmdOpenFile.VisualEffect = 0
ENDPROC
      �Top = 0
Left = 50
Height = 22
Width = 12
FontName = "Symbol"
FontSize = 11
Picture = ..\graphics\gktdownarrow.bmp
Caption = ""
TabIndex = 2
ToolTipText = "MRU List"
SpecialEffect = 2
Name = "cmdMRUOpen"
      	mrubutton      
cmdMRUOpen      commandbutton      gktbaseclasses.vcx      _commandbutton     _memberdata XML Metadata for customizable properties
mrumaxcount Maximum number of files on MRU list
mruname Type of GKK Tool being referenced in MRU
menubmp Menu item bitmap to display
globalmru Global MRU object attached to _SCREEN
nsmcol Mouse column Position
nsmrow Mouse row Position
*addtomru Adds file to MRU list if not present
*formselectfile Return hander for GKKSelectFile form
*onfileopen Executes when the user selects the file open commandbutton
*onopenfrommru Executed when user selects a file from the MRU list; passes the file name selected
*removefrommru Removes selected file from MRU list
*onmruclick User code for MRU click() event
*addfiletomrulist User called function to add the filename to the MRU list
*settextwidth Sets the caption text to fit within the form width
*openfrommru Opens selected file from MRU list
*openfilefrommrulist User function to open a file on the MRU list
*getmenuposition Determines the mouse coordinates for positioning the shortcut menu
*long2num Converts a Long to Num value
     S_memberdata = <VFPData><memberdata name="BackStyle" type="property" display="BackStyle"/><memberdata name="BorderWidth" type="property" display="BorderWidth"/><memberdata name="gkktooltype" type="property" display="GKKToolType"/><memberdata name="Height" type="property" display="Height"/><memberdata name="mrucount" type="property" display="MRUCount"/><memberdata name="mrulist" type="property" display="MRUList"/><memberdata name="mrumaxcount" type="property" display="MRUMaxCount"/><memberdata name="Name" type="property" display="Name"/><memberdata name="Width" type="property" display="Width"/><memberdata name="addtomru" type="method" display="AddToMRU"/><memberdata name="formselectfile" type="method" display="FormSelectFile"/><memberdata name="onfileopen" type="method" display="OnFileOpen"/><memberdata name="onopenfrommru" type="method" display="OnOpenFromMRU"/><memberdata name="openfrommru" type="method" display="OpenFromMRU"/><memberdata name="removefrommru" type="method" display="RemoveFromMRU"/><memberdata name="settextwidth" type="method" display="SetTextWidth"/></VFPData>
UserNotes =      ����    �  �                        !�   %   �      �  �   �          �  U  \ ��  � �� � � � ��� � ��U� T� �a�� �� ���(��� ��w � %�CC � �� fC�  f��s � T� �-�� !� � �� %�� ��Q� %��� � � ��� � T�� ��� ��� �� ��� �� � ��C�� ���� T�� �����  �� T� ��  �� �� ���(��� ��/�# T� �� C � �� C� C�
 �� �� ��C� MRUList� �
  � �	 �� � �� U 
 TCFILENAME
 LLNOTFOUND LNNDX LCMRUSETTING THIS	 GLOBALMRU MRUCOUNT MRULIST MRUMAXCOUNT GKTSETSTRING_VFP MRUNAME  U    U  
  ��  � U 
 TCFILENAME�  ��  � ��� � ��� � ��C�� �  ��� %�C�� �����e � T�� �C�� ����� �� ��� �� �� � �� ���� T�� �����  �� T�� �� �� � �� U  TNNDX THIS	 GLOBALMRU MRULIST MRUCOUNT.  ��  � %�C�  0��' � ��C �  � � �� � U 
 TCFILENAME THIS ADDTOMRU� ��  � �� � � � � � T� �C� :\�  ��� %�� � ���� T� �� ��� T� �� �� T�  �C�  C�  >�=�� T� ��  �� T� �C�  � =� ..�� T� �C � � � ��' +�� � � �(�
 C� >�@���� T� �� ���0 +�C�  � � �\� \� � � C�  >	��,� T� �� ��� � %�C�  � � �\� \��R� !� � T� �� C�  � � \�� T� �C � � � �� � �	 B�� �� U	  TCTEXTSTRING LNNDX LCDRIVE LCTEXTSTRING LNSTART LNLEN THISFORM	 TEXTWIDTH WIDTH�  ��  � �� � �� ���� ��� � ��� � T� �C �  �� �� %�C�� � �� ��� � %��  ���� � ��C�� �  ��� ��C�� ���� T�� ����� �� � ��C � � � �� �� � ��C� File not found� �� ��C �  � � �� � �� U	  TNBAR
 LCFILENAME LATEMP THIS	 GLOBALMRU MRULIST ONOPENFROMMRU GKTDISPLAYMSG REMOVEFROMMRU  ��  � ��C �  � � �� U  TNBAR THIS OPENFROMMRU�  ��  � T�  �CC�  �Q�� ��C�  � �� ��C�9� �  � ��+ T� � �CCC�  �=� � -�9� �9�	 � ��+ T� �
 �CCC�  �R� � a�9� �9�	 � �� U  LCPOINT GETCURSORPOS SCREENTOCLIENT HWND THIS NSMCOL GKTPIXELSTOFOXELS LONG2NUM FONTNAME FONTSIZE NSMROW<  ��  � �� � T� �� �� ��C�  �  �� ��	 B�� �� U  TCLONG LNNUM RTLS2PL� ��  � � � � �� ���� ���� %�C� � �
���� T� �� � �� %�C�9� � GKKMRU��h��� � %�C�9� �	 ���� � T�9� �	 �C� Empty�N�� � �� �" ��C�9� � GKKMRUC� Empty�N
�� � %�C�9� �	 � ��h
���� ��C�9� �	 � C� Empty�N
��P ADDPROPERTY(_SCREEN.GKKTools.GKKMRU.&lcMRUProperty,"MRUList[1]",.NULL.)     
P ADDPROPERTY(_SCREEN.GKKTools.GKKMRU.&lcMRUProperty,"MRUCount",0)            
 �; this.GlobalMRU = _SCREEN.GKKTools.GKKMRU.&lcMRUProperty
 ��� �
 ���� %�CC��� �����' T� �C�� C� MRUList� � � a���� %�� � ���� T� �� �� ��  ���(�� ���� %�C�� C �  � �� ���� T� �� ��� �� �� �� T�� �� ��C �  � �� � �� T�� �� �� � � �� � U  LNNDX LNCNT	 LNFILECNT LCMRUPROPERTY
 LASETTINGS LATEMP THIS MRUNAME GKKTOOLS GKKMRU	 GLOBALMRU MRULIST GKTGETSTRING_VFP MRUCOUNT addtomru,     �� formselectfile    ��
 onfileopen    �� onopenfrommru    �� removefrommru-    �� addfiletomrulist    �� settextwidthR    �� openfrommruG    �� openfilefrommrulist�    �� getmenuposition�    �� long2num�    �� Init;    ��1 q � � ��� A A A � R1� A A� �1A �A A 2 5 5 q 3 q q�� � � A� A A 2 q � A 2 q qA� �� �QqA �A A �QA A � 2 q q � 1�AA � �A A 2 q 2 q A� 2��2 q q � Q� 2 1q1�A�A � !A ��A �Aq� q�� �A A � A A A A 1                       �        �  
        +  Q  #      u  �  (      �  �  ,   +   �    :   0   >  <  @   H   ^  
  Y   Z   =
  g
  n   ]   �
  d  r   d   �  �  }   j   �  �  �    )   �                       �PROCEDURE addtomru
LPARAMETERS tcFileName
LOCAL llNotFound, lnNdx, lcMRUSetting
WITH this.GlobalMRU
*-*	Check if file already on MRU list
	llNotFound = True
	FOR lnNdx=1 TO .MRUCount
		IF UPPER(.MRUList[lnNdx]) == UPPER(tcFileName)
			llNotFound = False
			EXIT
		ENDIF
	ENDFOR
	IF llNotFound
*-*		Add to MRU list
		IF .MRUCount < this.MRUMaxCount
			.MRUCount = .MRUCount + 1
			DIMENSION .MRUList[.MRUCount]
		ENDIF
		=AINS(.MRUList,1)
		.MRUList[1] = tcFileName
*-*		Save the menu MRU list
		lcMRUSetting = ""
		FOR lnNdx=1 TO .MRUCount
			lcMRUSetting = lcMRUSetting + .MRUList[lnNdx] + CRLF
		ENDFOR
		=GKTSetString_VFP("MRUList",this.MRUName,lcMRUSetting)
	ENDIF
ENDWITH
ENDPROC
PROCEDURE formselectfile
*-*
*-*	TODO: Add your code here
*-*
ENDPROC
PROCEDURE onfileopen
*-*
*-*	TODO: Add your code here
*-*
ENDPROC
PROCEDURE onopenfrommru
LPARAMETERS tcFileName

ENDPROC
PROCEDURE removefrommru
LPARAMETERS tnNdx
WITH this.GlobalMRU
	=ADEL(.MRUList,tnNdx)
	IF ALEN(.MRUList,1) > 1
		.MRUCount = ALEN(.MRUList,1) - 1
		DIMENSION .MRUList[.MRUCount]
	ELSE
		DIMENSION .MRUList[1]
		.MRUList[1] = ""
		.MRUCount   = 0
	ENDIF
ENDWITH
ENDPROC
PROCEDURE addfiletomrulist
LPARAMETERS tcFileName
IF FILE(tcFileName)
	this.AddToMRU(tcFileName)
ENDIF
ENDPROC
PROCEDURE settextwidth
LPARAMETERS tcTextString
LOCAL lnNdx, lcDrive, lcTextString, lnStart, lnLen
lnStart = ATC(":\",tcTextString)
IF lnStart > 0
	lnStart = lnStart + 1
	lnNdx   = 0
	tcTextString = LEFT(tcTextString,LEN(tcTextString)-4)
	lcTextString = tcTextString
	lcDrive = LEFT(tcTextString,lnStart) + ".."
	lnLen = thisform.TextWidth(lcTextString)
	DO WHILE lnLen > (thisform.width-40) .OR. LEN(lcTextString) > 64
		lnNdx = lnNdx + 1
		DO WHILE SUBSTR(tcTextString,lnStart+lnNdx,1) != "\" .AND. lnStart+lnNdx <= LEN(tcTextString)
			lnNdx = lnNdx + 1
		ENDDO
		IF SUBSTR(tcTextString,lnStart+lnNdx,1) != "\"
			EXIT
		ENDIF
		lcTextString = lcDrive + SUBSTR(tcTextString,lnStart+lnNdx)
		lnLen = thisform.TextWidth(lcTextString)
	ENDDO
ENDIF
RETURN lcTextString
ENDPROC
PROCEDURE openfrommru
LPARAMETERS tnBar
LOCAL lcFileName
LOCAL ARRAY laTemp[1]
WITH this.GlobalMRU
	lcFileName = .MRUList[tnBar]
*-*	Test for form existance
	IF ADIR(laTemp,lcFileName) > 0
		IF tnBar > 1
*-*			Update position on local MRU list
			=ADEL(.MRUList,tnBar)
			=AINS(.MRUList,1)
			.MRUList[1] = lcFileName
		ENDIF
		this.OnOpenFromMRU(lcFileName)
	ELSE
		GKTDisplayMsg("File not found")
		this.RemoveFromMRU(tnBar)
	ENDIF
ENDWITH
ENDPROC
PROCEDURE openfilefrommrulist
LPARAMETERS tnBar
this.OpenFromMRU(tnBar)
ENDPROC
PROCEDURE getmenuposition
LOCAL lcPoint
lcPoint = REPLICATE(CHR(0), 8)
* Get mouse location in Windows desktop coordinates (pixels)
GetCursorPos(@lcPoint)
* Convert to VFP Desktop (_Screen) coordinates
ScreenToClient(_Screen.hWnd, @lcPoint)
* Covert the coordinates to foxels
this.nSMCol = GKTPixelsToFoxels(this.Long2Num(LEFT(lcPoint,4)), False, _Screen.FontName, _Screen.FontSize)
this.nSMRow = GKTPixelsToFoxels(this.Long2Num(RIGHT(lcPoint,4)), True, _Screen.FontName, _Screen.FontSize)
ENDPROC
PROCEDURE long2num
LPARAMETERS tcLong
LOCAL lnNum
lnNum = 0
RtlS2PL(@lnNum, tcLong, 4)
RETURN lnNum
ENDPROC
PROCEDURE Init
LOCAL lnNdx, lnCnt, lnFileCnt, lcMRUProperty
LOCAL ARRAY laSettings[1], laTemp[1]
IF !EMPTY(this.MRUName)
*-*	Initialize the MRU properties
	lcMRUProperty = this.MRUName
	IF PEMSTATUS(_SCREEN.GKKTools,"GKKMRU",5)
		IF ISNULL(_SCREEN.GKKTools.GKKMRU)
			_SCREEN.GKKTools.GKKMRU = CREATEOBJECT("Empty")
		ENDIF
	ELSE
		ADDPROPERTY(_SCREEN.GKKTools,"GKKMRU",CREATEOBJECT("Empty"))
	ENDIF
	IF !PEMSTATUS(_SCREEN.GKKTools.GKKMRU,lcMRUProperty,5)
		ADDPROPERTY(_SCREEN.GKKTools.GKKMRU,lcMRUProperty,CREATEOBJECT("Empty"))
		ADDPROPERTY(_SCREEN.GKKTools.GKKMRU.&lcMRUProperty,"MRUList[1]",.NULL.)     && List of files previously opened
		ADDPROPERTY(_SCREEN.GKKTools.GKKMRU.&lcMRUProperty,"MRUCount",0)            && Count of files previously opened
	ENDIF
	this.GlobalMRU = _SCREEN.GKKTools.GKKMRU.&lcMRUProperty
	WITH this.GlobalMRU
		IF ISNULL(.MRUList[1])
			lnCnt = ALINES(laSettings,GKTGetString_VFP("MRUList",this.MRUName),True)
			IF lnCnt > 0
				lnFileCnt = 0
				FOR lnNdx=1 TO lnCnt
					IF ADIR(laTemp,laSettings[lnNdx]) > 0
						lnFileCnt = lnFileCnt + 1
						DIMENSION .MRUList[lnFileCnt]
						.MRUList[lnFileCnt] = laSettings[lnNdx]
					ENDIF
				ENDFOR
				.MRUCount = lnFileCnt
			ENDIF
		ENDIF
	ENDWITH
ENDIF
ENDPROC
     wWidth = 62
Height = 22
BackStyle = 0
BorderWidth = 0
_memberdata =     1207<VFPData><memberdata name="mrumaxcount" type="property" display="MRUMaxCount"/><memberdata name="addtomru" type="method" display="AddToMRU"/><memberdata name="formselectfile" type="method" display="FormSelectFile"/><memberdata name="onfileopen" type="method" display="OnFileOpen"/><memberdata name="onopenfrommru" type="method" display="OnOpenFromMRU"/><memberdata name="removefrommru" type="method" display="RemoveFromMRU"/><memberdata name="mruname" display="MRUName"/><memberdata name="menubmp" type="property" display="MenuBMP"/><memberdata name="onmruclick" type="method" display="OnMRUClick"/><memberdata name="addfiletomrulist" type="method" display="AddFileToMRUList"/><memberdata name="globalmru" type="property" display="GlobalMRU"/><memberdata name="settextwidth" display="SetTextWidth"/><memberdata name="openfrommru" display="OpenFromMRU"/><memberdata name="openfilefrommrulist" type="method" display="OpenFileFromMRUList"/><memberdata name="getmenuposition" type="method" display="GetMenuPosition"/><memberdata name="long2num" type="method" display="Long2Num"/><memberdata name="nsmcol" type="property" display="nSMCol"/><memberdata name="nsmrow" type="property" display="nSMRow"/></VFPData>

mrumaxcount = 10
mruname = 
menubmp = 
globalmru = .NULL.
nsmcol = 0
nsmrow = 0
Name = "mrubutton"
      	container      gktbaseclasses.vcx0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _14X0R4ZMP1027691452v      �  �      �0      �  �.          `  m  �	          R               COMMENT RESERVED                        A                                                                 WINDOWS _0VB0YA1D81027691459g      �  |      !      �  a,          Q  ^  �          �               COMMENT RESERVED                        ;                                                                 WINDOWS _2NS1CNK6K1027691466!      c
  3      O      �  #          G
  >
  F                         COMMENT RESERVED                        A                                                                   WINDOWS _1V50XQICP1027691469�      �  �      y      �  �          �  �  �          }               COMMENT RESERVED                        1      T                                                           WINDOWS _0UW18BM8S1027691473T
      "  �
      �      u  �          �  	  �          �               COMMENT RESERVED                        �      �                                                           WINDOWS _21A0ZMCA21027691697�      �        |$      �  �          �	  �            �               COMMENT RESERVED                        �      �                                                           WINDOWS _31K0N0QX01027691920�      �	  n	      ~	                      �  �              �               COMMENT RESERVED                        �      �                                                           WINDOWS _31L0YJ20A1027768539~      �  p                            �  �              �               COMMENT RESERVED                        �                                                                   WINDOWS _0UY13Q5CE1027824338�
      �  �
      )      '  �          �
  �
            �
               COMMENT RESERVED                        u
      �
                                                           WINDOWS _3B91ALY6H1059958171�"      D"  �"      S"                      �"  �"              �"               COMMENT RESERVED                        �"      �"                                                           WINDOWS _3B91AMS561059958190H      q  U      u!                      2  ?              $               COMMENT RESERVED                        c                                                                   WINDOWS _3BA1B4P311060024182"      ~  �!      �!                      "  �              '"               COMMENT RESERVED                        5"                                                                   WINDOWS _3CD0X51L11062697852�3      a4  4      4                      �3  �3              �3               COMMENT RESERVED                        �3                                                                    4r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      	_checkbox      Pixels      Class      1      checkbox      	_checkbox      checkbox      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      _listbox      Pixels      Class      Pixels      1      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      _commandbutton      Class      1      commandbutton      _commandbutton      6_memberdata XML Metadata for customizable properties
     ����    �  �                        �s   %   �       ;  	   )          �  U  Q  ��  � T� � ��  �� �� ���(�� � ��J � T� � �� �� ��  �� �� U  TENABLED THIS ENABLED LNBUTTON BUTTONCOUNT BUTTONS  T�  � ��  � �� U  THIS PREVIOUSOPTIONVALUE VALUE enabled_assign,     �� InteractiveChange�     ��1 q ��A 2 11                       �         �   �       )   �                        !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      _spinner      Pixels      Class      1      spinner     +PROCEDURE GotFocus
this.FontBold = .T.
ENDPROC
PROCEDURE LostFocus
this.FontBold = .F.
ENDPROC
PROCEDURE MouseEnter
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.FontBold = .T.
ENDPROC
PROCEDURE MouseLeave
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.FontBold = .F.
ENDPROC
      Pixels      Class      1      shape      _shape      _shape      shape      shape      commandbutton     ����    �  �                        �   %   @      d     T          �  U  � ' ��  � � � � � � � � � ��	 �
 �# ��	 ���(�C� � C�t�F��� � T�
 �� pcItemC�	 _�� ��CC�
 � �   �	 � � �� �� U  PNITEMID PCITEM1 PCITEM2 PCITEM3 PCITEM4 PCITEM5 PCITEM6 PCITEM7 PCITEM8 LNCNT LCPARM THIS COLUMNCOUNT ADDLISTITEM
 addlistrow,     ��1 q� 1��A 1                              )   �                        _spinner      -Height = 24
Width = 121
Name = "_spinner"
      spinner      Class      g_memberdata XML Metadata for customizable properties
*userinteractivechange Called InteractiveChange
      1      Class      listbox      
collection      	_combobox      _listbox      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      Pixels      Class      1      combobox      	_combobox      �_memberdata XML Metadata for customizable properties
^itemlist[1,0] Pointers for items in list
*addlistrow Adds items to row with columns
*setlistvalues Sets the list values
      ����    �   �                         �N   %   b       �      x           �  U    ��  � T� � ���  �� U  VNEWVAL THIS VALUE value_assign,     ��1 q "2                       x       )   �                         1      optiongroup      �PROCEDURE enabled_assign
lparameters tEnabled
This.Enabled = tEnabled
FOR lnButton=1 TO this.ButtonCount
	this.Buttons(lnButton).Enabled = tEnabled
ENDFOR
ENDPROC
PROCEDURE InteractiveChange
this.PreviousOptionValue = this.Value
ENDPROC
      Pixels      combobox     +PROCEDURE MouseLeave
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.FontBold = .F.
ENDPROC
PROCEDURE MouseEnter
LPARAMETERS nButton, nShift, nXCoord, nYCoord
this.FontBold = .T.
ENDPROC
PROCEDURE GotFocus
this.FontBold = .T.
ENDPROC
PROCEDURE LostFocus
this.FontBold = .F.
ENDPROC
      Pixels      listbox      _textbox      _collection      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      Pixels      Class      1      textbox      _textbox      F_memberdata XML Metadata for customizable properties
*value_assign 
      �_memberdata XML Metadata for customizable properties
previousoptionvalue Previously selected optionvalue; set in the default InteractiveChange event
^itemvalues[1,4] Array of user defined values
*enabled_assign 
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
      1      textbox     ���    �  �                        C�   %   Z      �  
   �          �  U  � ' ��  � � � � � � � � � ��	 �
 �# ��	 ���(�C� � C�t�F��� � T�
 �� pcItemC�	 _�� ��CC�
 � �   �	 � � �� �� U  PNITEMID PCITEM1 PCITEM2 PCITEM3 PCITEM4 PCITEM5 PCITEM6 PCITEM7 PCITEM8 LNCNT LCPARM THIS COLUMNCOUNT ADDLISTITEM
  ��  � U 
 PNLISTTYPE
 addlistrow,     �� setlistvalues@    ��1 q� 1��A 2 q 1                                D  Z  	    )   �                        label      ]AutoSize = .T.
BackStyle = 0
Caption = "Label1"
Height = 17
Width = 40
Name = "_label"
      _label      label      1      Class      Pixels      _label      optiongroup      _optiongroup      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      _optiongroup      
collection      _collection      �_memberdata XML Metadata for customizable properties
currentpropgrid Currently selected property grid key
mainpropgrid Handle to the main form/class property grid
*closeallpropgrids Closes all open property grids
     ePROCEDURE addlistrow
LPARAMETERS pnItemID, pcItem1, pcItem2, pcItem3, pcItem4, pcItem5, pcItem6, pcItem7, pcItem8
LOCAL lnCnt, lcParm
FOR lnCnt=1 TO MIN(This.ColumnCount, PCOUNT()-1)
  lcParm = "pcItem" + TRANSFORM(lnCnt)
  this.AddListItem(EVALUATE(lcParm), pnItemID, lnCnt)
ENDFOR
ENDPROC
PROCEDURE setlistvalues
LPARAMETERS pnListType
ENDPROC
      �PROCEDURE closeallpropgrids
LOCAL lnGrid
FOR lnGrid=1 TO this.Count
	thisform.RemoveObject(this.Item(1).Name)
ENDFOR
this.Remove(-1)
this.CurrentPropGrid = .NULL.
ENDPROC
     ZHeight = 23
Width = 23
_memberdata =      221<VFPData><memberdata name="closeallpropgrids" display="CloseAllPropGrids"/><memberdata name="currentpropgrid" display="CurrentPropGrid"/><memberdata name="mainpropgrid" type="property" display="MainPropGrid"/></VFPData>

currentpropgrid = .NULL.
mainpropgrid = .NULL.
Name = "_collection"
      �_memberdata XML Metadata for customizable properties
lastlistitemid Last selected listitem ID value
^itemlist[1,0] Pointers to items in list
*addlistrow Adds items to row with columns
     +PROCEDURE addlistrow
LPARAMETERS pnItemID, pcItem1, pcItem2, pcItem3, pcItem4, pcItem5, pcItem6, pcItem7, pcItem8
LOCAL lnCnt, lcParm
FOR lnCnt=1 TO MIN(This.ColumnCount, PCOUNT()-1)
  lcParm = "pcItem" + TRANSFORM(lnCnt)
  this.AddListItem(EVALUATE(lcParm), pnItemID, lnCnt)
ENDFOR
ENDPROC
     RHeight = 122
Width = 167
ItemTips = .T.
_memberdata =      227<VFPData><memberdata name="addlistrow" type="method" display="AddListRow"/><memberdata name="itemlist" type="property" display="ItemList"/><memberdata name="lastlistitemid" type="property" display="LastListItemID"/></VFPData>

lastlistitemid = 0
Name = "_listbox"
      kHeight = 27
Width = 84
Caption = "Command1"
SpecialEffect = 2
_memberdata = 
Name = "_commandbutton"
      +Height = 17
Width = 100
Name = "_shape"
      NHeight = 41
Width = 191
BackStyle = 0
SpecialEffect = 0
Name = "_border"
      _border      shape      Class      Pixels      _border      editbox      -Height = 65
Width = 205
Name = "_editbox"
      _editbox      editbox      1      Class      Pixels      _editbox      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
     p���    W  W                        ��   %   �            �           �  U  a  ��  � ��  ���(�� � ��; � ��CC�� � � � � �� �� ��C���� � �� T� � ���� U	  LNGRID THIS COUNT THISFORM REMOVEOBJECT ITEM NAME REMOVE CURRENTPROPGRID closeallpropgrids,     ��1 q ��A � 1                       �       )   W                       }MemberClassLibrary = ..\programs\gktoptionmbrclass.prg
MemberClass = "GKTOption"
ButtonCount = 1
BackStyle = 0
BorderStyle = 0
Value = 1
Enabled = .T.
Height = 67
Width = 142
_memberdata =      281<VFPData><memberdata name="itemvalues" type="property" display="ItemValues"/><memberdata name="previousoptionvalue" type="property" display="PreviousOptionValue"/><memberdata name="enabled" display="Enabled"/><memberdata name="enabled_assign" display="Enabled_Assign"/></VFPData>

previousoptionvalue = 1
Name = "_optiongroup"
GKTOPTION1.Value = 1
GKTOPTION1.Left = 5
GKTOPTION1.Top = 5
GKTOPTION1.Name = "GKKOPTION1"
     XHeight = 24
SpecialEffect = 2
Style = 2
Width = 100
ItemTips = .T.
_memberdata =      223<VFPData><memberdata name="addlistrow" type="method" display="AddListRow"/><memberdata name="itemlist" type="property" display="ItemList"/><memberdata name="setlistvalues" type="method" display="SetListValues"/></VFPData>

Name = "_combobox"
     !���                              |B   %   ,      �     y          �  U    T�  � �a�� U  THIS FONTBOLD  T�  � �-�� U  THIS FONTBOLD$  ��  � � � � T� � �a�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS FONTBOLD$  ��  � � � � T� � �-�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS FONTBOLD GotFocus,     ��	 LostFocusQ     ��
 MouseEnterv     ��
 MouseLeave�     ��1 � 2 � 2 1� 2 1� 1                       '         G   Z         {   �         �          )                          !���                              |B   %   ,      �     y          �  U  $  ��  � � � � T� � �-�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS FONTBOLD$  ��  � � � � T� � �a�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS FONTBOLD  T�  � �a�� U  THIS FONTBOLD  T�  � �-�� U  THIS FONTBOLD
 MouseLeave,     ��
 MouseEnter�     �� GotFocus�     ��	 LostFocus    ��1 1� 2 1� 2 � 2 � 1                       X         y   �         �   �   	   	            )                          Height = 17
Width = 60
AutoSize = .T.
Alignment = 0
BackStyle = 0
Caption = "Check1"
Value = .F.
_memberdata =      109<VFPData><memberdata name="userinteractivechange" type="method" display="UserInteractiveChange"/></VFPData>

Name = "_checkbox"
      
_container      Pixels      Class      1      	container      
_container      ?Width = 200
Height = 200
BackStyle = 0
Name = "_container"
      	container  %   ,  �  ;       ��W?�  �  U    T�  � �a�� U  THIS FONTBOLD  T�  � �-�� U  THIS FONTBOLD$  ��  � � � � T� � �a�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS FONTBOLD$  ��  � � � � T� � �-�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS FONTBOLD GotFocus,      	 LostFocusQ      
 MouseEnterv      
 MouseLeave�      Y  T�  �a�� T� ��	 GKTOption�� T� �� ��
 ��    �
 ��    �
 ��    �
 ��    � U  AUTOSIZE CAPTION	 BACKSTYLE	 GKTOption OptionButtony    � 1 � 2 � 2 1� 2 1� 2 � a� � � � � 4                    =  R        t  �        �  �     	     [        �  e     BM6      6   (                  �  �          ������������   ���   ���   ���   ������������������������@@@���������������������������������������������@@@@@@������������������������������������      @@@@@@@@@                        ���������   ���@@@ �� ��@@@������������������   ���������   ���@@@ �� ��@@@      ���      ���   ���������   ������@@@ �� ��@@@���������������   ���������   ���   @@@ �� ��@@@   ���      ���   ���������   ���������@@@ �� ��@@@������������   ���������   ���      @@@ �� ��@@@���      ���   ���������   ������������@@@ �� ��@@@���������   ����������  �  �  �  �  @@@ �� ��@@@�  �  �  �  ����������  ����  �  ������@@@ �� ��@@@�  ����  ����������  �  �  �  �  �  @@@ �� ��@@@�  �  �  ������������������������������  �  �  �  ����������������������������������������  �  �  �������������BM2      6   (               �              ���������������������������������������������������������   ���������������������������������������������������������   ������               ���������������               ������   ������   ���         ���������������   ���         ������   ������   ���         ���������������   ���         ������   ������                     ���                     ������   ������      ���                  ���               ������   ������      ���         ���      ���               ������   ������      ���         ���      ���               ������   ���������                                       ���������   ������������   ���         ���   ���         ������������   ������������               ���               ������������   ���������������         ���������         ���������������   ���������������   ���   ���������   ���   ���������������   ���������������         ���������         ���������������   ���������������������������������������������������������   ���������������������������������������������������������   BM6      6   (                  �  �          ���������������  @  @  @���������������  @  @  @���������������  @ @@  @���������������  @ @@  @���������������  @  @  @ @@��������� @@  @  @  @���              @  @  @  @  @  @  @  @  @  @  @���   ���������  @ @@  @  @  @  @ @@  @  @  @  @���   ���        @ @@  @  @  @  @ @@  @  @  @  @���   ���������  @  @  @  @  @  @  @  @  @  @  @���   ���      ���  @  @  @  @���  @  @  @  @������   ���������������  @  @���������  @  @���������   ���      ���     @  @���        @  @���������   ���������������  @  @���������  @  @����������  �  �  �  �  �  �  �  �  �  �  �  �  ����������  ����  �  �������  �������  �  ����  ����������  �  �  �  �  �  �  �  �  �  �  �  �  ������������������������������������������������������������������������������������������������������programs\gkttoolbar.prg c:\users\gregory\appdata\local\temp\ gkttoolbar.fxp classes\ gkttoolbar.vcx gkttoolbar.vct graphics\ class.bmp form.bmp menu.bmp program.bmp project.bmp compare.bmp programs\gktdeclarewinapi.prg gktdeclarewinapi.fxp programs\gktgetregstring_hkcu.prg gktgetregstring_hkcu.fxp programs\gktgettoolspath.prg gktgettoolspath.fxp programs\gktsetregstring_hkcu.prg gktsetregstring_hkcu.fxp forms\ gktlocfile.scx gktlocfile.sct gktgkt.ico gktbblistview.vcx gktbblistview.vct gkticonbuddy.vcx gkticonbuddy.vct folderback.bmp gktselectdir.scx gktselectdir.sct foldernew.bmp programs\gktpixelstotwips.prg gktpixelstotwips.fxp gktoutlookbar.vcx gktoutlookbar.vct programs\gktgetstring_vfp.prg gktgetstring_vfp.fxp programs\gktsetstring_vfp.prg gktsetstring_vfp.fxp programs\gktwmsgbox.prg gktwmsgbox.fxp programs\gktgetresource.prg gktgetresource.fxp gktmsgbox.scx gktmsgbox.sct programs\gktdisplaymsg.prg gktdisplaymsg.fxp gktdisplaymsg.scx gktdisplaymsg.sct gktcode.bmp gktform.bmp gktclasslib.bmp gktsmproject.bmp gktmenu.bmp gktdownarrow.bmp gktfolderopen16.bmp gktfavfolder.bmp gktinfo.bmp gktlabel.vcx gktlabel.vct gktitemlist.vcx gktitemlist.vct gktproject.bmp programs\gktpixelstofoxels.prg gktpixelstofoxels.fxp gktcompile.bmp gktbuildall.scx gktbuildall.sct gktsnippetmgr.bmp programs\gktmakepath.prg gktmakepath.fxp gktformedit.bmp copy.bmp gktmrubutton.vcx gktmrubutton.vct gktbaseclasses.vcx gktbaseclasses.vct programs\gktoptionmbrclass.prg gktoptionmbrclass.fxp gkttableedit.bmp gktfind.bmp gkttablebrow.bmp  )   v     =           v  N  L   U           N  R�  L   d           R�  ��  s   }           ��  ��  s   �           ��  ,�  s   �           ,�  b�  s   �           b�  ؖ  s   �           ؖ  �  s   �            �  x"    �            x" �$               �$ y&    H           y& �*    ~          	�* �5 �  �          �5 g+ �  �          g+ %4 s   �          %4 t9 L   �          t9 �g L   �          �g +m L   �          +m 	H L   �          	H ?K s             	?K >U �            >U S �  -          S � s   >           �     j           9' L             9' +� L   �           +� �    �           � d�    �           d� ��    !           �� Y�    L          	Y� ~� �  _          ~� |� �  m           |� Q�    �          	Q� �� �  �          �� � �  �          � 8� s   �          8� n� s   �          n� �� s   �          �� �� s   �          �� �� s             �� 6� s             6� l� s   "          l� r� s   6          r� � s   G          �  L   S           } L   `          } � L   m          � �4 L   }          �4 �6 s   �           �6 >8    �          >8 t= s   �          	t= HK �  �          HK -� �  �          -� c� s               c� ?�    +          ?� %� s   ;          %� [� s   K          [� �� L   T          �� 7� L   e          7� � L   v          � 0: L   �           0: �<    �          �< @ s   �          @ 3D s   �          3D iG s   �          