��� -  S )O �                    >�#  %   �>  0D  J  �  �D  �|eU    �  U  Q / %�� FoxTabsDeclareAPIC�	 Procedurev
��J � G+(� FoxTabsDeclareAPI� � U  FOXTABSDECLAREAPI' ��C� �� � � WMEventHandler�  ��1 ��C� � � WindowShowEvent� �
 WindowShow��7 ��C� � � WindowSetTextEvent� � WindowSetText��9 ��C� � � WindowSetFocusEvent� � WindowSetFocus��7 ��C� � � WindowDestroyEvent� � WindowDestroy�� U  BINDWINEVENT THIS WINDOWSEVENTS2 ��  Q� INTEGER� �� Q�	 EXCEPTION� �� Q� INTEGER� ��� � %�C �  � � ��f � ��C �  � � �� � T� �� �� +�a��� � T� �C �   � � � � �� %�C� ���� � !� � ��C � � � �� � �(� �+�T ��C� � � LogError� �4 Exception caught while loading existing IDE windows.�� �� U	  HWND
 OEXCEPTION LNCHILDHWND THIS ISIDEWINDOW	 NEWFOXTAB FINDWINDOWEX LOADWINDOWS PARENT� ��  Q� INTEGER� �� Q�	 EXCEPTION� �� Q� FOXTAB� ���" %�CCC�  � @0x_� � � �
��e � !� � T� �C� FoxTab���� T� �  �C�  � @0x_�� T� � �C �  � � �� ��C � C�  � @0x_� � � ��  ��C� � AddFoxTabEvent� �� ��C �  � �	 �
 �� �(� ��� � ���%�	 ��� �� �(� ���^ T� � ��N Unhandled exception caught while adding a new FoxTab object to the collection.��	 ��� �� �� U  HWND
 OEXCEPTION OFOXTAB THIS FOXTABS GETKEY
 WINDOWNAME GETWINDOWTITLE ADD WINDOWSEVENTS SETBINDINGS ERRORNO	 USERVALUEn  ��  Q� INTEGER� �� Q� STRING� T� �C��X�� ��C �  � C� >� �� T� �CC� C�  �  ����	 B�� �� U  HWND LCBUFFER GETWINDOWTEXT_ ��  Q� INTEGER� �� Q�	 EXCEPTION�/ �� Q� BOOLEAN� Q� STRING� Q� INTEGER� �� ���� T� ��  �� ��C�� ��� ���� T� �CC �  � � �  ���� T� �� �  �  � � �	 �
 �  �  	� C� �
	�i CC� @� compile� debugger� watch� locals� trace�
 call stack� debug output� parentclass browser�
	�; CC� @� expression builder� expression builder options�
	� C�� � ���������� 	�� T� �C �  �� �� T� �� �
 � �9�  	�� T� �� � C �  � � 	�� �(� �O�Q T� � ��A Unhandled exception caught checking if the hWnd is an IDE Window.��	 ��� �� ��	 B�� �� U  HWND
 OEXCEPTION LBRETURN LCWINDOWTITLE LNPARENTHWND
 LATOOLBARS THIS GETWINDOWTITLE APPLICATION PARENT FOXTABSTOOLBAR GETANCESTOR	 HASBORDER	 USERVALUE�  ��  Q� INTEGER�. �� Q� BOOLEAN� Q� STRING� Q� STRING� T� �C�<X�� ��C �  � � �� T� �CC� �%�\� 4rs���� %�C� �
  � ��
  � ��� � T� �a�� �	 B�� �� U  HWND LBRETURN LCBUFFER LCSTYLE GETWINDOWINFO@ ��  Q� INTEGER� �� Q�	 EXCEPTION� �� Q� INTEGER� �� Q� INTEGER� �� Q� INTEGER� ��� � �� ���(�� � � ��� � T� �CCC � � � � �  g8��$ T� � � �� ��	 �C � � �
 �� �� ��C �  � � �� �(� �9�T ��C� � � LogError� �4 Exception caught while loading existing IDE windows.�� �� U  HWND
 OEXCEPTION LNCHILDHWND I	 LNTABHWND THIS FOXTABS COUNT ITEM
 WINDOWNAME GETWINDOWTITLE LOADWINDOWS PARENT� ��  Q� INTEGER� �� Q� OBJECT� �� Q�	 EXCEPTION� ��B� %�C�  ���R � !� �" %�C�� DATA ENVIRONMENT -��� � ��C�C�  � � � �� �" %�CCC�  � @0x_� � � �
��� � %��9�  C �  ��	 ��� � ��C �  � �
 �� � !� � %�C �  � � 
��-�( ��C �  �� � � WMEventHandler� �� !� � ��C �  � � �� �(� ��� � ���e�	 ��� �� �(� ���^ T� � ��N Unhandled exception caught while adding a new FoxTab object to the collection.��	 ��� �� �� U  HWND OFOXTAB
 OEXCEPTION OFOXTABS FOXTABSMANAGER LOADWINDOWS THIS FOXTABS GETKEY GETANCESTOR WINDOWDESTROY ISIDEWINDOW UNBINDWINEVENTS WINDOWSEVENTS	 NEWFOXTAB ERRORNO	 USERVALUE� ��  Q� INTEGER� �� Q� OBJECT� �� Q�	 EXCEPTION� �� Q� STRING� ��Q� %�C�  ���c � !� � ��C �  � � ��! %�CCC�  � @0x_� � � ���� � !� � %��9�  C �  �� ��� � ��C �  � �	 �� !� � T� �CC�  � @0x_� � �
 �� T� �C �  � � �� %�� � � 
��M� T� � �� �� ��C� � OnChangeEvent� �� � �(� ��� � ���t�	 ��� �� �(� ���^ T� � ��N Unhandled exception caught while adding a new FoxTab object to the collection.��	 ��� �� �� U  HWND OFOXTAB
 OEXCEPTION CWINDOWCAPTION THIS
 WINDOWSHOW FOXTABS GETKEY GETANCESTOR WINDOWDESTROY ITEM GETWINDOWTITLE
 WINDOWNAME ERRORNO	 USERVALUEg ��  Q� INTEGER� �� Q� OBJECT� �� Q�	 EXCEPTION� ��� � %��9�  C �  �� ��o � ��C �  � � �� !� � T� �CC�  � @0x_� � � �� T� � �C �  � �	 �� ��C� � GotFocusEvent� �� �(� ��� �
 ���� �	 ��� �� �(� �`�_ T� � ��O Unhandled exception caught while updating the window name of the active FoxTab.��	 ��� �� �� U  HWND OFOXTAB
 OEXCEPTION GETANCESTOR THIS WINDOWDESTROY FOXTABS ITEM
 WINDOWNAME GETWINDOWTITLE ERRORNO	 USERVALUE� ��  Q� INTEGER� �� Q� OBJECT� �� Q�	 EXCEPTION� ��� �! %�CCC�  � @0x_� � � ���d � !� � T� �CC�  � @0x_� � � ��# ��C� � RemoveFoxTabEvent� �� T� ���� ��CC�  � @0x_� � � ��( ��C �  � � �	 � WMEventHandler� �� �(� ��� �
 ����	 ��� �� �(� ���` T� � ��P Unhandled exception caught while removing the active FoxTab from our collection.��	 ��� �� �� U  HWND OFOXTAB
 OEXCEPTION THIS FOXTABS GETKEY ITEM REMOVE UNBINDWINEVENTS WINDOWSEVENTS ERRORNO	 USERVALUEn $ +�C� This.FoxTabs[1]b� O��@ � ��CCC��  � � g�  � �� �' ��C� � �  � � WMEventHandler� �� U  THIS WINDOWDESTROY FOXTABS HWND UNBINDWINEVENTS WINDOWSEVENTS� ��  Q� STRING� �� � � � %�C� � �����	 M(� �� � Activate Event� � AdjustObjectSize Event � � AfterBand Event � � AfterBuild Event � � AfterCloseTables Event � � AfterCursorAttach Event � � AfterCursorClose Event � � AfterCursorDetach Event � � AfterCursorFill Event � � AfterCursorRefresh Event � � AfterCursorUpdate Event � � AfterDelete Event � � AfterInsert Event � � AfterRecordRefresh Event � � AfterUpdate Event � � AfterDock Event � � AfterReport Event � � AfterRowColChange Event � � BeforeBand Event � � BeforeCursorAttach Event � � BeforeCursorClose Event � � BeforeCursorDetach Event � � BeforeCursorFill Event �  � BeforeCursorRefresh Event � � BeforeCursorUpdate Event � � BeforeDelete Event � � BeforeInsert Event � � BeforeDock Event � � BeforeOpenTables Event �  � BeforeRecordRefresh Event � � BeforeReport Event � � BeforeRowColChange Event � � BeforeUpdate Event � � Click Event � � dbc_Activate Event � � dbc_AfterAddTable Event �  � dbc_AfterAppendProc Event �  � dbc_AfterCloseTable Event � � dbc_AfterCopyProc Event �& �  dbc_AfterCreateConnection Event �# � dbc_AfterCreateOffline Event �! � dbc_AfterCreateTable Event �  � dbc_AfterCreateView Event � � dbc_AfterDBGetProp Event � � dbc_AfterDBSetProp Event �& �  dbc_AfterDeleteConnection Event �! � dbc_AfterDropOffline Event � � dbc_AfterDropTable Event �& �  dbc_AfterModifyConnection Event �  � dbc_AfterModifyProc Event �! � dbc_AfterModifyTable Event �  � dbc_AfterModifyView Event � � dbc_AfterOpenTable Event �! � dbc_AfterRemoveTable Event �& �  dbc_AfterRenameConnection Event �! � dbc_AfterRenameTable Event �  � dbc_AfterRenameView Event �" � dbc_AfterValidateData Event � � dbc_BeforeAddTable Event �! � dbc_BeforeAppendProc Event �! � dbc_BeforeCloseTable Event � � dbc_BeforeCopyProc Event �' �! dbc_BeforeCreateConnection Event �$ � dbc_BeforeCreateOffline Event �" � dbc_BeforeCreateTable Event �! � dbc_BeforeCreateView Event �  � dbc_BeforeDBGetProp Event �  � dbc_BeforeDBSetProp Event �' �! dbc_BeforeDeleteConnection Event �" � dbc_BeforeDropOffline Event �  � dbc_BeforeDropTable Event �' �! dbc_BeforeModifyConnection Event �! � dbc_BeforeModifyProc Event �" � dbc_BeforeModifyTable Event �! � dbc_BeforeModifyView Event �  � dbc_BeforeOpenTable Event �" � dbc_BeforeRemoveTable Event �' �! dbc_BeforeRenameConnection Event �" � dbc_BeforeRenameTable Event �! � dbc_BeforeRenameView Event �# � dbc_BeforeValidateData Event � � dbc_CloseData Event � � dbc_Deactivate Event � � dbc_ModifyData Event � � dbc_OpenData Event � � dbc_PackData Event � � DblClick Event � � Deactivate Event � � Deleted Event � � Destroy Event � � DoCmd Method � � DownClick Event � � DragDrop Event � � DragOver Event � � DropDown Event � � Error Event� � ErrorMessage Event � � EvaluateContents Event � � GotFocus Event � � Init Event � � InteractiveChange Event � � KeyPress Event � � Load Event � � LoadReport Event � � LostFocus Event � � Message Event � � MiddleClick Event � � MouseDown Event � � MouseEnter Event � � MouseLeave Event � � MouseMove Event � � MouseUp Event � � MouseWheel Event � � Moved Event � � OLECompleteDrag Event � � OLEDragOver Event � � OLEGiveFeedback Event � � OLESetData Event � � OLEStartDrag Event � � OnMoveItem Event � � Paint Event � � ProgrammaticChange Event � � QueryAddFile Event � � QueryModifyFile Event � � QueryNewFile Event � � QueryRemoveFile Event � � QueryRunFile Event � � QueryUnload Event � � RangeHigh Event � � RangeLow Event � � ReadActivate Event � � ReadDeactivate Event � � ReadShow Event � � ReadValid Event � � ReadWhen Event � � Resize Event � � RightClick Event � � SCCInit Event � � SCCDestroy Event � � Scrolled Event � � Timer Event � � UIEnable Event � � UnDock Event � � Unload Event � � UnloadReport Event � � UpClick Event � � Valid Event � � When Event � �% ��C� � CC� �  Event�  �@����� �  T� �CC�  C�  � .��� .��@�� %�� [read only]� ��l�  T� �C� � [read only]�  ��� � %�� *� ���� T� �C� � *�  ��� �' T� �C� � � �� � ��� ��	 B�� �� U  LPCWINDOWNAME LCEVENTLIST LCMETHOD LLEVENT THIS
 AEVENTLIST  ��  Q� OBJECT� U  OFOXTAB  ��  Q� OBJECT� U  OFOXTAB  ��  Q� OBJECT� U  OFOXTAB  ��  Q� OBJECT� U  OFOXTAB<  ��  Q� STRING� T� � �C �  � � �� T� � ��  �� U  LPCWINDOWNAME THIS CONTENTTYPE GETCONTENTTYPE
 WINDOWNAME<  ��  Q� STRING� T� � �C �  � � �� T� � ��  �� U  LPCCONTENTTYPE THIS ASSOCIATEDICON GETASSOCIATEDICON CONTENTTYPE� ��  Q� STRING�  �� Q� STRING� Q� INTEGER� T� �CC� � g� � �� H�W ��� �C�  ���v � T� �� VFP��" �� project managerC�  @��� � T� �� PJX��  �� form designerC�  @��� � T� �� SCX��; �� class designerC�  @� � class browserC�  @��#� T� �� VCX��$ �� database designerC�  @��W� T� �� DBC��! �� table designerC�  @���� T� �� DBF��" �� report designerC�  @���� T� �� FRX��  �� menu designerC�  @���� T� �� MNX��! �� label designerC�  @��� T� �� LBX��! �� query designerC�  @��L� T� �� QPX��  �� view designerC�  @��}� T� �� VIEW��# �� data environmentC�  @���� T� �� DATAENV�� �CC� � g� � ���� T� �� FORM�� �C �  � � ��� T� �� DBF�� �� ���$� T� �� PRG�� �� ���E� T� �� TXT�� �� ���g� T� �� MEMO�� �� ����� T� �� QPX�� �� ����� T� �� MNX�� �� �	���� T� �� VIEW�� �C� �
����)� %�C �  � �	 �
 ��
� T� �� EVENT�� �%� T� �� METHOD�� � �� ���J� T� �� CUR�� 2��� T�  �C�  �  �  ��� T�  �C�  � *�  ���' %�C� .�  � � CC�  ��>�	���� T� �CC�  ��f�� ��� T� �� VFP�� � �	 B�� �� U  LPCWINDOWNAME LCCONTENTTYPE LNWINDOWTYPE THIS GETWINDOWTYPE HWND ISFORM ISUSED OFOXTABS FOXTABSMANAGER ISEVENT�  ��  Q� INTEGER�! �� Q� INTEGER� Q� INTEGER� �� ����) %�� FOXTOOLS.FLLCC� Libraryvf
��� � Gb(�C�Q� FoxTools.Fll�� � T� �C�	�  ]�� %�C � � � ���� � T� �C�� �� �� � T� �� �� �	 B�� �� U  HWND	 LNWHANDLE LNWINDOWTYPE LAENV	 _EDGETENV� ��  Q� STRING� �� Q� STRING� H�/ ��� ��  � VCX��X � T� �� icoClass�� ��  � CUR��� � T� ��	 icoCursor�� ��  � DBC��� � T� �� icoDatabase�� ��  � SCX��� � T� �� icoForm�� ��  � MNX��� � T� �� icoMenu�� ��  � PRG��)� T� ��
 icoProgram�� ��  � PJX��T� T� ��
 icoProject�� ��  � FRX��~� T� ��	 icoReport�� ��  � SLX���� T� �� icoSolution�� ��  � DBF���� T� �� icoTable��% �C�  � TXT� H� INI� LOG���� T� �� icoText�� �C�  � XML� XSD���:� T� �� icoXml�� �C�  � XSL� XSLT���i� T� �� icoXsl�� �C�  � QPX� VIEW����� T� �� icoQuery�� ��  � METHOD���� T� ��	 icoMethod�� ��  � EVENT���� T� �� icoEvent�� ��  � DATAENV��)� T� �� icoDataEnvironment�� ��  � MEMO��R� T� �� icoEdit�� ��  � FORM��~� T� ��
 icoFormRun�� 2��� T� �� icoVfp�� �	 B�� �� U  LPCCONTENTTYPE LCASSOCIATEDICON�  ��  Q� STRING� �� ���� �� � � ��� � T� �-�� ��C�� ���� �� � �� � G�(�� �� %�C�  ���� � T� �a�� !� � �� ��� � G�(�� � � �� ��	 B�� �� U  LPCWINDOWNAME
 LASESSIONS	 LNSESSION LLUSED OFOXTABS DATASESSION DATASESSIONID�  ��  Q� INTEGER� �� � � � T� �-�� T� ��9� �� �� ���(�� ��� � ��� � %�C � �9� �  �  ��� � T� �a�� !� � ��� � �� ��	 B�� �� U  HWND LLFORM LNFORMCOUNT LNFORM	 FORMCOUNT FORMS�  ��  Q� INTEGER� �� � � � T� ��  �� T� ��9� �� �� ���(�� ��� � ��� � %�C � �9� �  �  ��� � T� �C � �9� � �� !� � ��� � �� ��	 B�� �� U  HWND LCICON LNFORMCOUNT LNFORM	 FORMCOUNT FORMS ICONk / %�� FoxTabsDeclareAPIC�	 Procedurev
��J � G+(� FoxTabsDeclareAPI� � T� � �C�C� ���� �� U  FOXTABSDECLAREAPI THIS PREVWNDFUNC GETWINDOWLONG HWND( % ��C� �  � � WMEventHandler�  �� U  UNBINDWINEVENTS THIS�? ��  Q� INTEGER� Q� INTEGER� Q� INTEGER� Q� INTEGER� �� Q�	 EXCEPTION� �� Q� INTEGER� �� � � T� �� ��) %�C� hWndb� N� C� Msgb� N��� �	 B�� �� � ��n� T� �CC �  � �	 �
 @�� H�� �j�& �C� This.Parent.Parentb� O��� �� �	 work area���� H�/��� �� �����% ��C� � � � WMEventHandler� ��) ��C �  � � � WMEventHandler�� �� �� �����% ��C� � � � WMEventHandler� ��& ��C �  � � � WMEventHandler� �� 2��� � �� �����/ %�� �
 call stack� C� t� FOXTABS	����% ��C� � � � WMEventHandler� ��% ��C� � � � WMEventHandler� �� �# ��C� � WindowCreateEvent�  ��) ��C �  � � � WMEventHandler�� ��) ��C �  � � � WMEventHandler�� �� �� ���T�% ��C� � � � WMEventHandler� ��% ��C� � � � WMEventHandler� �� �� ����� %�� � ����! ��C� � WindowShowEvent�  �� � �C� ��G�"��� � %��  � � ���� T� � ��  ��% ��C� � WindowSetFocusEvent�  �� � �� ���5�$ ��C� � WindowSetTextEvent�  �� �� ���j�$ ��C� � WindowDestroyEvent�  �� � �(� �|�D %�C� This.Parent.Parentb� O� C� �	 �	 � LogError��h	��x�� ��C� �	 �	 � LogError� �6 Exception caught while handling windows message event.C� �  hWnd:C�  � @x0_�  Msg:C� � @x0_�  wParam:C� � @x0_�  lParam:C� � @x0_�� � ����$ T� �C� �  �   �  �  � � �� ��	 B�� �� U  HWND MSG WPARAM LPARAM
 OEXCEPTION LNRETURN LCWINDOWTITLE LCPARENTWINDOW THIS PARENT GETWINDOWTITLE UNBINDWINEVENTS BINDWINEVENT LASTHWND CALLWINDOWPROC PREVWNDFUNC ��  Q� INTEGER�) ��C �  � � � WMEventHandler�� ��) ��C �  � � � WMEventHandler�� ��) ��C �  � � � WMEventHandler�� ��\ %�CCC �  � � � @� project manager�
 properties� class designer� form designer����) ��C �  �G � � WMEventHandler�� �� � U  HWND BINDWINEVENT THIS PARENT GETWINDOWTITLE  ��  Q� INTEGER� U  HWND  ��  Q� INTEGER� U  HWND  ��  Q� INTEGER� U  HWND  ��  Q� INTEGER� U  HWND  ��  Q� INTEGER� U  HWND Init,       SetBindings�       LoadWindows�     	 NewFoxTabS      GetWindowTitley      IsIDEWindow
     	 HasBorder	      RefreshWindows�	     
 WindowShow�      WindowSetText_      WindowSetFocus�      WindowDestroy�      RemoveBindings�      IsEvent�      AddFoxTabEvent�&      RemoveFoxTabEvent�&      GotFocusEvent�&      OnChangeEvent'      WindowName_Assign5'     ContentType_Assign�'     GetContentType9(     GetWindowType�-     GetAssociatedIcon�.     IsUsed�2     IsForm�3     GetFormIconu4     Initf5     Destroy6     WMEventHandlerS6     SetBindings�<     WindowCreateEvent>     WindowShowEvent1>     WindowDestroyEventP>     WindowSetFocusEvento>     WindowSetTextEvent�>    �  �.�  Q� � �.� Q� � � ����
 ��    �
 ��    �
 ��    �
 ��    �
 ��    �
 ��    �
 ��    �
 ��    �
 �� 	   �
 �� 
   �
 ��    �
 ��    �
 ��    �
 ��    �
 ��    �
 ��    �
 ��    �
 ��    � U  FOXTABS
 COLLECTION WINDOWSEVENTS FOXTABSEVENTHANDLER
 AEVENTLIST�  T�  ��  �� T� ��  �� T� ��  �� T� ��  ��
 ��    �
 ��    �
 ��    �
 ��    �
 ��    �
 ��    �
 ��    �
 ��    � U  HWND
 WINDOWNAME CONTENTTYPE ASSOCIATEDICONw  T�  �� �� T� �� ��
 ��    �
 ��    �
 ��    �
 ��    �
 ��    �
 ��     �
 �� !   �
 �� "   �
 �� #   � U  PREVWNDFUNC LASTHWND FoxTabsManager Custom�A     FoxTab Custom�B     FoxTabsEventHandler Custom�C    �1 ��A 3 sq�q4 !B!� RA � � �� B A B � BB 4 !B� "A A c���C�� � �� B 4 !� r�� 4 !B�� � � �� �T��� � B � 4 !�� "��� A � 4 !B!"!� ��AA � BB 8 !A� � A A $QA #�A B A c�B A �� � �� B 4 !A� � A A B A �B A �QQ�A �� � �� B 4 !A� �B A ����� � �� B 4 !A� B A �3� ���� � � B 6 B�A r4 � b� A�aq�����������a��q�������q����!���a1��a�a�a!��qA!q!q!!q!1�����QqAA1aQQQ��Q�QqaA�aqqaAq!���q�q!�������aQ��QaQ1qAqQ!Q11�A!A QA �A "aA q� 7 4 4 4  1 �4 �4 �� � "�B"2A�RR�!� 1A � bar!� A B � 4 !� ��A 1�� � A � 3 � AQBaB�BABABqBqBaB�BQRA�1�1�QrabQ��RARr� 1B � 4 � � � � � � � � � A A A � !A � 3 !� � � q� �� A A � B A � 3 !� � � q� �qA A � B A � 01 ��A �4 S4 �B!� � �� A � �� e�� Q�Qa� B �QQA 3��RQA �CQA BBB � I�A � BB � 4 !�����A 8 !4 !4 !4 !4 !8 � � � � � � 0� p� � � �  � �� 0� �� P� �� � �
� � � � 4 � � � � � � � �� �� �� @� �  1 � � � � � ��  � � � � � 6                    �  =        e  F  #      W  �  /      �    S   3     P  {   :   _  �  �   M   �  �  �   W   �  I  �   f   �  �!  �   �   �!  })  #  �   �)  �-  a  �   �-  s2  �  �   3  �3  �  �   �3  �C  �  n  OD  �D  i  p  �D  �D  m  r  �D  /E  q  t  >E  }E  u  w  �F  �G  �  {  �G  �H  �    �H  �S  �  �  �S  �V    �  �V  �]  "  �  �]  �_  k    �_  Ma  �    ]a  �b  �  +  �d  �e  �  0  �e  
f  �  2  f  �{  �  j  �{  �}  D  r  s~  �~  U  t  �~    Y  v    S  ]  x  b  �  a  z  �  �  e  |  g  �E     �  F  	c  �  �  �c  G�  �  
* Common Stuff
#define BROADCAST_QUERY_DENY        0x424D5144  &&// Return this value to deny a query.("BMQD")
#define GWL_WNDPROC         (-4)
#define WM_USER                   	0x0400

*-- GA Flags
#DEFINE GA_PARENT     			0x0001 
#DEFINE GA_ROOT       			0x0002 
#DEFINE GA_ROOTOWNER  			0x0003 

*-- Windows messages
#define WM_NULL				0x0000
#define WM_CREATE				0x0001
#define WM_DESTROY			0x0002
#define WM_MOVE				0x0003
#define WM_SIZE				0x0005
#define WM_ACTIVATE			0x0006
#define WM_SETFOCUS			0x0007
#define WM_KILLFOCUS			0x0008
#define WM_ENABLE				0x000A
#define WM_SETREDRAW			0x000B
#define WM_SETTEXT			0x000C
#define WM_GETTEXT			0x000D
#define WM_GETTEXTLENGTH		0x000E
#define WM_PAINT				0x000F
#define WM_CLOSE				0x0010
#define WM_QUERYENDSESSION		0x0011
#define WM_QUIT				0x0012
#define WM_QUERYOPEN			0x0013
#define WM_ERASEBKGND			0x0014
#define WM_SYSCOLORCHANGE		0x0015
#define WM_ENDSESSION			0x0016
#define WM_SHOWWINDOW			0x0018
#define WM_WININICHANGE			0x001A
#define WM_DEVMODECHANGE		0x001B
#define WM_ACTIVATEAPP			0x001C
#define WM_FONTCHANGE			0x001D
#define WM_TIMECHANGE			0x001E
#define WM_CANCELMODE			0x001F
#define WM_SETCURSOR			0x0020
#define WM_MOUSEACTIVATE		0x0021
#define WM_CHILDACTIVATE		0x0022
#define WM_QUEUESYNC			0x0023
#define WM_GETMINMAXINFO		0x0024
#define WM_PAINTICON			0x0026
#define WM_ICONERASEBKGND		0x0027
#define WM_NEXTDLGCTL			0x0028
#define WM_SPOOLERSTATUS		0x002A
#define WM_DRAWITEM			0x002B
#define WM_MEASUREITEM			0x002C
#define WM_DELETEITEM			0x002D
#define WM_VKEYTOITEM			0x002E
#define WM_CHARTOITEM			0x002F
#define WM_SETFONT			0x0030
#define WM_GETFONT			0x0031
#define WM_SETHOTKEY			0x0032
#define WM_GETHOTKEY			0x0033
#define WM_QUERYDRAGICON		0x0037
#define WM_COMPAREITEM			0x0039
#define WM_COMPACTING			0x0041
#define WM_WINDOWPOSCHANGING		0x0046
#define WM_WINDOWPOSCHANGED		0x0047
#define WM_POWER				0x0048
#define WM_COPYDATA			0x004A
#define WM_CANCELJOURNAL		0x004B
#define WM_NCCREATE			0x0081
#define WM_NCDESTROY			0x0082
#define WM_NCCALCSIZE			0x0083
#define WM_NCHITTEST			0x0084
#define WM_NCPAINT			0x0085
#define WM_NCACTIVATE			0x0086
#define WM_GETDLGCODE			0x0087
#define WM_NCMOUSEMOVE			0x00A0
#define WM_NCLBUTTONDOWN		0x00A1
#define WM_NCLBUTTONUP			0x00A2
#define WM_NCLBUTTONDBLCLK		0x00A3
#define WM_NCRBUTTONDOWN		0x00A4
#define WM_NCRBUTTONUP			0x00A5
#define WM_NCRBUTTONDBLCLK		0x00A6
#define WM_NCMBUTTONDOWN		0x00A7
#define WM_NCMBUTTONUP			0x00A8
#define WM_NCMBUTTONDBLCLK		0x00A9
#define WM_KEYFIRST			0x0100
#define WM_KEYDOWN			0x0100
#define WM_KEYUP				0x0101
#define WM_CHAR				0x0102
#define WM_DEADCHAR			0x0103
#define WM_SYSKEYDOWN			0x0104
#define WM_SYSKEYUP			0x0105
#define WM_SYSCHAR			0x0106
#define WM_SYSDEADCHAR			0x0107
#define WM_KEYLAST			0x0108
#define WM_INITDIALOG			0x0110
#define WM_COMMAND			0x0111
#define WM_SYSCOMMAND			0x0112
#define WM_TIMER				0x0113
#define WM_HSCROLL			0x0114
#define WM_VSCROLL			0x0115
#define WM_INITMENU			0x0116
#define WM_INITMENUPOPUP		0x0117
#define WM_MENUSELECT			0x011F
#define WM_MENUCHAR			0x0120
#define WM_ENTERIDLE			0x0121
#define WM_CTLCOLORMSGBOX		0x0132
#define WM_CTLCOLOREDIT			0x0133
#define WM_CTLCOLORLISTBOX		0x0134
#define WM_CTLCOLORBTN			0x0135
#define WM_CTLCOLORDLG			0x0136
#define WM_CTLCOLORSCROLLBAR		0x0137
#define WM_CTLCOLORSTATIC		0x0138
#define WM_MOUSEFIRST			0x0200
#define WM_MOUSEMOVE			0x0200
#define WM_LBUTTONDOWN			0x0201
#define WM_LBUTTONUP			0x0202
#define WM_LBUTTONDBLCLK		0x0203
#define WM_RBUTTONDOWN			0x0204
#define WM_RBUTTONUP			0x0205
#define WM_RBUTTONDBLCLK		0x0206
#define WM_MBUTTONDOWN			0x0207
#define WM_MBUTTONUP			0x0208
#define WM_MBUTTONDBLCLK		0x0209
#define WM_MOUSELAST			0x0209
#define WM_PARENTNOTIFY			0x0210
#define WM_ENTERMENULOOP		0x0211
#define WM_EXITMENULOOP			0x0212
#define WM_POWERBROADCAST		0x0218
#define WM_DEVICECHANGE			0x0219
#define WM_MDICREATE			0x0220
#define WM_MDIDESTROY			0x0221
#define WM_MDIACTIVATE			0x0222
#define WM_MDIRESTORE			0x0223
#define WM_MDINEXT			0x0224
#define WM_MDIMAXIMIZE			0x0225
#define WM_MDITILE			0x0226
#define WM_MDICASCADE			0x0227
#define WM_MDIICONARRANGE		0x0228
#define WM_MDIGETACTIVE			0x0229
#define WM_MDISETMENU			0x0230
#define WM_DROPFILES			0x0233
#define WM_MDIREFRESHMENU		0x0234
#define WM_CUT				0x0300
#define WM_COPY				0x0301
#define WM_PASTE				0x0302
#define WM_CLEAR				0x0303
#define WM_UNDO				0x0304
#define WM_RENDERFORMAT			0x0305
#define WM_RENDERALLFORMATS		0x0306
#define WM_DESTROYCLIPBOARD		0x0307
#define WM_DRAWCLIPBOARD		0x0308
#define WM_PAINTCLIPBOARD		0x0309
#define WM_VSCROLLCLIPBOARD		0x030A
#define WM_SIZECLIPBOARD		0x030B
#define WM_ASKCBFORMATNAME		0x030C
#define WM_CHANGECBCHAIN		0x030D
#define WM_HSCROLLCLIPBOARD		0x030E
#define WM_QUERYNEWPALETTE		0x030F
#define WM_PALETTEISCHANGING		0x0310
#define WM_PALETTECHANGED		0x0311
#define WM_HOTKEY				0x0312
#define WM_THEMECHANGED			0x031A
#define WM_PENWINFIRST			0x0380
#define WM_PENWINLAST			0x038F

* WM_ACTIVATE state values
#define WA_INACTIVE			0
#define WA_ACTIVE				1
#define WA_CLICKACTIVE			2

* Shell notification fSources
#define SHCNRF_INTERRUPTLEVEL		0x0001
#define SHCNRF_SHELLLEVEL		0x0002
#define SHCNRF_RECURSIVEINTERRUPT	0x1000
#define SHCNRF_NEWDELIVERY		0x8000

* Device and Media Events
#define WM_USER_SHNOTIFY          WM_USER+10
#define SHCNE_RENAMEITEM          0x00000001
#define SHCNE_CREATE              0x00000002
#define SHCNE_DELETE              0x00000004
#define SHCNE_MKDIR               0x00000008
#define SHCNE_RMDIR               0x00000010
#define SHCNE_MEDIAINSERTED       0x00000020
#define SHCNE_MEDIAREMOVED        0x00000040
#define SHCNE_DRIVEREMOVED        0x00000080
#define SHCNE_DRIVEADD            0x00000100
#define SHCNE_NETSHARE            0x00000200
#define SHCNE_NETUNSHARE          0x00000400
#define SHCNE_ATTRIBUTES          0x00000800
#define SHCNE_UPDATEDIR           0x00001000
#define SHCNE_UPDATEITEM          0x00002000
#define SHCNE_SERVERDISCONNECT    0x00004000
#define SHCNE_UPDATEIMAGE         0x00008000
#define SHCNE_DRIVEADDGUI         0x00010000
#define SHCNE_RENAMEFOLDER        0x00020000
#define SHCNE_FREESPACE           0x00040000
#define SHCNE_ASSOCCHANGED	    0x08000000
 
#define SHCNE_DISKEVENTS          0x0002381F
#define SHCNE_GLOBALEVENTS        0x0C0581E0 
#define SHCNE_ALLEVENTS           0x7FFFFFFF
#define SHCNE_INTERRUPT           0x80000000 

#define CSIDL_DESKTOP                   0x0000        &&// <desktop>
#define CSIDL_INTERNET                  0x0001        &&// Internet Explorer (icon on desktop)
#define CSIDL_PROGRAMS                  0x0002        &&// Start Menu\Programs
#define CSIDL_CONTROLS                  0x0003        &&// My Computer\Control Panel
#define CSIDL_PRINTERS                  0x0004        &&// My Computer\Printers
#define CSIDL_PERSONAL                  0x0005        &&// My Documents
#define CSIDL_FAVORITES                 0x0006        &&// <user name>\Favorites
#define CSIDL_STARTUP                   0x0007        &&// Start Menu\Programs\Startup
#define CSIDL_RECENT                    0x0008        &&// <user name>\Recent
#define CSIDL_SENDTO                    0x0009        &&// <user name>\SendTo
#define CSIDL_BITBUCKET                 0x000a        &&// <desktop>\Recycle Bin
#define CSIDL_STARTMENU                 0x000b        &&// <user name>\Start Menu
#define CSIDL_MYDOCUMENTS               0x000c        &&// logical "My Documents" desktop icon
#define CSIDL_MYMUSIC                   0x000d        &&// "My Music" folder
#define CSIDL_MYVIDEO                   0x000e        &&// "My Videos" folder

#define WM_DEVICECHANGE         	    0x0219
#define DBT_DEVNODES_CHANGED            0x0007
#define DBT_DEVICEARRIVAL               0x8000  &&// system detected a new device
#define DBT_DEVICEQUERYREMOVE           0x8001  &&// wants to remove, may fail
#define DBT_DEVICEQUERYREMOVEFAILED     0x8002  &&// removal aborted
#define DBT_DEVICEREMOVEPENDING         0x8003  &&// about to remove, still avail.
#define DBT_DEVICEREMOVECOMPLETE        0x8004  &&// device is gone
#define DBT_DEVTYP_OEM                  0x00000000  &&// oem-defined device type
#define DBT_DEVTYP_DEVNODE              0x00000001  &&// devnode number
#define DBT_DEVTYP_VOLUME               0x00000002  &&// logical volume
#define DBT_DEVTYP_PORT                 0x00000003  &&// serial, parallel
#define DBT_DEVTYP_NET                  0x00000004  &&// network resource 
 
* Power Events
#define PBT_APMQUERYSUSPEND             0x0000
#define PBT_APMQUERYSTANDBY             0x0001
#define PBT_APMQUERYSUSPENDFAILED       0x0002
#define PBT_APMQUERYSTANDBYFAILED       0x0003
#define PBT_APMSUSPEND                  0x0004
#define PBT_APMSTANDBY                  0x0005
#define PBT_APMRESUMECRITICAL           0x0006
#define PBT_APMRESUMESUSPEND            0x0007
#define PBT_APMRESUMESTANDBY            0x0008
#define PBTF_APMRESUMEFROMFAILURE       0x00000001
#define PBT_APMBATTERYLOW               0x0009
#define PBT_APMPOWERSTATUSCHANGE        0x000A
#define PBT_APMOEMEVENT                 0x000B
#define PBT_APMRESUMEAUTOMATIC          0x0012

#define HWND_TOP        (0)
#define HWND_BOTTOM     (1)
#define HWND_TOPMOST    (0xffffffff)
#define HWND_NOTOPMOST  (0xfffffffe)

#define WS_OVERLAPPED       0x00000000
#define WS_POPUP            0x80000000
#define WS_CHILD            0x40000000
#define WS_MINIMIZE         0x20000000
#define WS_VISIBLE          0x10000000
#define WS_DISABLED         0x08000000
#define WS_CLIPSIBLINGS     0x04000000
#define WS_CLIPCHILDREN     0x02000000
#define WS_MAXIMIZE         0x01000000
#define WS_CAPTION          0x00C00000    
#define WS_BORDER           0x00800000
#define WS_DLGFRAME         0x00400000
#define WS_VSCROLL          0x00200000
#define WS_HSCROLL          0x00100000
#define WS_SYSMENU          0x00080000
#define WS_THICKFRAME       0x00040000
#define WS_GROUP            0x00020000
#define WS_TABSTOP          0x00010000
#define WS_MINIMIZEBOX      0x00020000
#define WS_MAXIMIZEBOX      0x00010000
#define WS_TILED            WS_OVERLAPPED
#define WS_ICONIC           WS_MINIMIZE
#define WS_SIZEBOX          WS_THICKFRAME
#define WS_TILEDWINDOW      WS_OVERLAPPEDWINDOW
#define WS_EX_DLGMODALFRAME     0x00000001
#define WS_EX_NOPARENTNOTIFY    0x00000004
#define WS_EX_TOPMOST           0x00000008
#define WS_EX_ACCEPTFILES       0x00000010
#define WS_EX_TRANSPARENT       0x00000020
#define WS_EX_MDICHILD          0x00000040
#define WS_EX_TOOLWINDOW        0x00000080
#define WS_EX_WINDOWEDGE        0x00000100
#define WS_EX_CLIENTEDGE        0x00000200
#define WS_EX_CONTEXTHELP       0x00000400
#define WS_EX_RIGHT             0x00001000
#define WS_EX_LEFT              0x00000000
#define WS_EX_RTLREADING        0x00002000
#define WS_EX_LTRREADING        0x00000000
#define WS_EX_LEFTSCROLLBAR     0x00004000
#define WS_EX_RIGHTSCROLLBAR    0x00000000
#define WS_EX_CONTROLPARENT     0x00010000
#define WS_EX_STATICEDGE        0x00020000
#define WS_EX_APPWINDOW         0x00040000
#define WS_EX_OVERLAPPEDWINDOW  (WS_EX_WINDOWEDGE | WS_EX_CLIENTEDGE)
#define WS_EX_PALETTEWINDOW     (WS_EX_WINDOWEDGE | WS_EX_TOOLWINDOW | WS_EX_TOPMOST)
#define WS_EX_LAYERED           0x00080000

* Show Window Constants
#define SW_FORCEMINIMIZE  		11 
#define SW_HIDE  				0 
#define SW_MAXIMIZE  			3 
#define SW_MINIMIZE  			6 
#define SW_RESTORE  			9 
#define SW_SHOW  				5 
#define SW_SHOWDEFAULT  		10 
#define SW_SHOWMAXIMIZED  		3 
#define SW_SHOWMINIMIZED  		2 
#define SW_SHOWMINNOACTIVE  	7 
#define SW_SHOWNA  				8 
#define SW_SHOWNOACTIVATE  		4 
#define SW_SHOWNORMAL  			1 

* Window Type returned from FoxTools _EdGetEnv defined in pro_ext.h
* Includes some not in documentation
#define EDCOMMAND		0
#define EDSCRIP			EDCOMMAND
#define EDPROGRAM		1
#define EDFILE			2
#define EDMEMO			3
#define EDQUERY			6
#define EDSCREEN		7
#define EDMENU			8
#define EDVIEW			9
#define EDSNIP		   10
#define EDTEXT		   11
#define EDPROC		   12
#define EDPROJTEXT     130A   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _1MB19JZ6L 891706641�7      �7  �7      kR      [y  v          �7                �7               COMMENT RESERVED                        �7                                                                   WINDOWS _1ME0VWJXL 995130714  1,  3&  5      &!      �q  '�            �                              COMMENT RESERVED                        �                                                                   WINDOWS _1LD0Z8KMD 995131014�      !  �      �p      ��  ��          �  �  km          �               WINDOWS _1MB1F4G99 995131015^R      d_  q_  9f  yk                                                           WINDOWS _1L60XN392 995130834Of      df  _  #f  gp      l  Lh                                               WINDOWS _1LD0ZUJ91 995130834yf      hc  Wc  Ac  Oi      +g  }g                                               WINDOWS _1MB19JZ6L 9951310150c      c  c  �b  Ib      n  }c                                               WINDOWS RESERVED   995131015<b      /b  b  �a  ua      1a  R`                                               WINDOWS _1ME0VWJXL 995131015E`      i^  S^  2^  �_      �]  v^                                               WINDOWS _1NB1D4NYJ 995131015�]      �]  �]  �]  �\      [[   Y                                               WINDOWS _1NB1D4NYK 995131015Y      nX  XX  ;X  �X      �W   W                                               WINDOWS _1NB1D4NYZ 995131015W      W  �V  �V  V      �U  �T                                               WINDOWS _1NB1DVHWE 995131015�T      �T  �T  �T  �R                                                           WINDOWS _1MB19JZ6L 995131015�R      �R  �R  3R  �Q                                                           WINDOWS RESERVED   995131015�Q      �Q  �Q  sQ  Q                                                           WINDOWS _1ME0VWJXL 995131015�P      �P  �P  �P  5P                                                           WINDOWS RESERVED   995131015(P      P  P  �O  %O                                                           WINDOWS _1LD0Z8KMD 963613613O      O  �N  �N  �M                                                           WINDOWS _1MB1F4G99 995131015�M      �M  �M  gM  �L                                                           WINDOWS _1L60XN392 879059463�L      L  kL  7L  TK                                                           WINDOWS _1MB19JZ6L 995131015DK      4K  !K  �J   J                                                           WINDOWS _1LD0Z8KMD 995131015�I      �I  �I  �I  �H                                                           WINDOWS _1L60XN392 995130834�H      �H  �H  �H  H      EF  �D                                               WINDOWS _1LD0ZUJ91 995130834oD      ZD  HD  D  YC      "A  \?                                               WINDOWS _1LD0Z8KMD 995131015O?      B?  4?   ?  E>                                                           WINDOWS _1MC01BDG9 9951310158>      +>  >  e<  f=                                                           WINDOWS _1MB19JZ6L 995131015X<      �8  �8  $<  �<                                                           WINDOWS _1MB19JZ6L 995130834�8      �8  w8  Y7  �7      �:  �8                                               WINDOWS _1LD0ZUJ91 995130834D7      /7  7  �6  (6      35  �3                                               WINDOWS _1MB19JZ6L 995131015y3      l3  ^3  *3  ]2                                                           WINDOWS RESERVED   879059463N2      ?2  ,2  �1  1                                                           WINDOWS _1MB19JZ6L 995131015	1       '  ,  �&  f0                                                           WINDOWS _2RS0XQ6GT 995131015�&      �&  �&  }&  �/                                                           WINDOWS _1NB1DVI0R 995131015l&      �!  t!  E&  �                                                           WINDOWS _1NB1DVI0S 995131015�      �  �  j  �                                                           WINDOWS _1NB1DVI16 995131015�      �  �  �                                                             WINDOWS _1NB1DVI17 962770603�      �  �  �  �                                                           WINDOWS _1MB19JZ6L 995131015�      �  l  @  f      �  �,                                               WINDOWS _1NB1DVI1M 995131015�      �  �  �  �                                                           WINDOWS _1MB19JZ6L 995131015�      �  �  �  �                                                           WINDOWS RESERVED   995131015�      �  s  G  q
                                                           WINDOWS _1ME0VWJXL 995131015a
      Q
  3
  
  ,	                                                           WINDOWS _1MB19JZ6L 995131015	      	  �  �  �                                                           WINDOWS _1NB1DVI2Y 995131015�      �  �  �  �                                                           WINDOWS _1NB1DVI3C 995131015�      �  l  @  i                                                           WINDOWS _1NB1DVI3D 995131015Y      I  *  �                                                             WINDOWS _2I31D2R5R 995131015      �  �  �  �                                                           COMMENT RESERVED                        r                                                                 WINDOWS _1LL1E4OR01163546347>      U_  M      }x      �  �&         (  5  ��                         WINDOWS _1MB19JZ6L1163546347{X      �<  �:  �:  �o      �e  �l                                               WINDOWS _2LE10ZJ9X1163546347y:      d:  T:  s/  �j      �4  �i                                               WINDOWS _1LL1EAV6U1163546347f/      r,  e!  ,  �f                                                           WINDOWS _1LL1EAV6V1163546347,  �+  �+  �+  !  +      k�  (                                               WINDOWS _1MB1A9WPT1163546347�   �   �  �  �  �'      -'  '                                               WINDOWS _2I912EDK31163546347�      �  y  c  O      �  �                                               COMMENT RESERVED                              �                                                           WINDOWS _1L81EZRLQ1432716477C      �  T      3      ~y �^         -  :  J                         WINDOWS _1L900QA8B1432716374&        
  �  X      ��  �!                                               WINDOWS _1MB1BJ0MB 979129639K      >  -    f                                                           WINDOWS _1LD0Z8KMD 979129639Y      L  ;  &  �                                                           WINDOWS _1L900VH3B1432716374v      i  T  ?  i      ��  5|                                               COMMENT RESERVED                        
                                                                   ��                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      RMicrosoft Sans Serif, 0, 7, 4, 12, 10, 18, 2, 0
Tahoma, 0, 8, 5, 13, 11, 21, 2, 0
      foxtabsoptions      Pixels      Class      45      form      foxtabsoptions      �Top = 156
Left = 47
Height = 15
Width = 111
FontName = "Tahoma"
FontSize = 8
AutoSize = .T.
Alignment = 0
BackStyle = 0
Caption = "Include Report files"
TabIndex = 6
Name = "chkIncludeReportFiles"
      $foxtabsoptions.oOptionPages.MRU.oMRU      chkIncludeReportFiles      checkbox      checkbox      �Top = 52
Left = 204
Height = 15
Width = 116
FontName = "Tahoma"
FontSize = 8
AutoSize = .T.
Alignment = 0
BackStyle = 0
Caption = "Include Solution files"
TabIndex = 11
Visible = .F.
Name = "chkIncludeSolutionFiles"
      $foxtabsoptions.oOptionPages.MRU.oMRU      chkIncludeSolutionFiles      checkbox      checkbox      �Top = 208
Left = 47
Height = 15
Width = 104
FontName = "Tahoma"
FontSize = 8
AutoSize = .T.
Alignment = 0
BackStyle = 0
Caption = "Include Table files"
TabIndex = 8
Name = "chkIncludeTableFiles"
      $foxtabsoptions.oOptionPages.MRU.oMRU      chkIncludeTableFiles      checkbox      checkbox      �Top = 182
Left = 47
Height = 15
Width = 124
FontName = "Tahoma"
FontSize = 8
AutoSize = .T.
Alignment = 0
BackStyle = 0
Caption = "Include Database files"
TabIndex = 7
Name = "chkIncludeDatabaseFiles"
      $foxtabsoptions.oOptionPages.MRU.oMRU      chkIncludeDatabaseFiles      checkbox      checkbox      �Top = 130
Left = 47
Height = 15
Width = 102
FontName = "Tahoma"
FontSize = 8
AutoSize = .T.
Alignment = 0
BackStyle = 0
Caption = "Include Form files"
TabIndex = 5
Name = "chkIncludeFormFiles"
      $foxtabsoptions.oOptionPages.MRU.oMRU      chkIncludeFormFiles      checkbox      checkbox      �Top = 104
Left = 47
Height = 15
Width = 118
FontName = "Tahoma"
FontSize = 8
AutoSize = .T.
Alignment = 0
BackStyle = 0
Caption = "Include Program files"
TabIndex = 4
Name = "chkIncludeProgramFiles"
      $foxtabsoptions.oOptionPages.MRU.oMRU      chkIncludeProgramFiles      checkbox      checkbox      �Top = 78
Left = 47
Height = 15
Width = 103
FontName = "Tahoma"
FontSize = 8
AutoSize = .T.
Alignment = 0
BackStyle = 0
Caption = "Include Class files"
TabIndex = 3
Name = "chkIncludeClassFiles"
      $foxtabsoptions.oOptionPages.MRU.oMRU      chkIncludeClassFiles      checkbox      checkbox      �Top = 52
Left = 47
Height = 15
Width = 112
FontName = "Tahoma"
FontSize = 8
AutoSize = .T.
Alignment = 0
BackStyle = 0
Caption = "Include Project files"
TabIndex = 2
Name = "chkIncludeProjectFiles"
      $foxtabsoptions.oOptionPages.MRU.oMRU      chkIncludeProjectFiles      checkbox      checkbox      �AutoSize = .T.
FontName = "Tahoma"
FontSize = 8
Caption = " Most recently used "
Height = 15
Left = 10
Top = 3
Width = 99
TabIndex = 12
ForeColor = 127,157,185
Name = "Label4"
      $foxtabsoptions.oOptionPages.MRU.oMRU      Label4      label      label      foxtabcontrol      Pixels      Class      5      	container      foxtabcontrol      �AutoSize = .T.
FontName = "Tahoma"
FontSize = 8
Anchor = 2
BackStyle = 0
Caption = "Desktop"
Height = 15
Left = 18
MousePointer = 15
Top = 5
Width = 41
ForeColor = 0,0,0
Name = "lblWindowName"
      foxtabcontrol      lblWindowName      label      label      �Anchor = 13
Picture = images\tabstyles\tabimage.right.2.gif
Stretch = 2
BackStyle = 0
Height = 26
Left = 60
Top = 0
Width = 14
Name = "imgRight2"
      foxtabcontrol      	imgRight2      image      image      �Anchor = 13
Picture = images\tabstyles\tabimage.right.1.gif
Stretch = 2
BackStyle = 0
Height = 26
Left = 60
Top = 0
Visible = .F.
Width = 14
Name = "imgRight1"
      foxtabcontrol      	imgRight1      image      image      �Anchor = 15
Picture = images\tabstyles\tabimage.body.gif
Stretch = 2
BackStyle = 0
Height = 26
Left = 0
Top = 0
Width = 60
Name = "imgBody"
      foxtabcontrol      imgBody      image      image      �Anchor = 15
Width = 72
Height = 26
BackStyle = 0
BorderWidth = 0
isactive = .F.
tabstyle = 1
foxtab = Null
Name = "foxtabcontrol"
      	container      %Webdings, 0, 8, 11, 17, 13, 44, 4, 0
      foxtabstoolbar      Pixels      Class      7      toolbar      foxtabstoolbar      foxtabstoolbar      tmrRemoveFoxTab      timer      timer     �PROCEDURE ProgrammaticChange
DoDefault()

* Toggle the enabled state of the inclusion settings
With This.Parent As Container

	* File inclusions
	.chkIncludeSolutionFiles.Enabled = This.Value
	.chkIncludeProjectFiles.Enabled = This.Value
	.chkIncludeClassFiles.Enabled = This.Value
	.chkIncludeProgramFiles.Enabled = This.Value
	.chkIncludeFormFiles.Enabled = This.Value
	.chkIncludeDatabaseFiles.Enabled = This.Value
	.chkIncludeTableFiles.Enabled = This.Value

	* On table selection
	.cboTableSelection.Enabled = This.Value

EndWith 

ENDPROC
PROCEDURE InteractiveChange
DoDefault()

* Toggle the state of the inclusion settings
This.ProgrammaticChange()
ENDPROC
      �Top = 27
Left = 28
Height = 15
Width = 166
FontName = "Tahoma"
FontSize = 8
AutoSize = .T.
Alignment = 0
BackStyle = 0
Caption = "Show recent files as menu item"
TabIndex = 1
Name = "chkShowRecent"
      $foxtabsoptions.oOptionPages.MRU.oMRU      chkShowRecent      checkbox      checkbox      �FontName = "Tahoma"
FontSize = 8
ColumnCount = 0
ColumnWidths = ""
RowSourceType = 1
RowSource = "Modify,Browse"
FirstElement = 1
Height = 22
Left = 75
NumberOfElements = 0
TabIndex = 9
Top = 229
Width = 80
Name = "cboTableSelection"
      $foxtabsoptions.oOptionPages.MRU.oMRU      cboTableSelection      combobox      combobox      �AutoSize = .T.
FontName = "Tahoma"
FontSize = 8
BackStyle = 0
Caption = "when selecting tables"
Height = 15
Left = 160
Top = 233
Width = 105
TabIndex = 10
Name = "Label1"
      $foxtabsoptions.oOptionPages.MRU.oMRU      Label1      IPROCEDURE Timer
This.Interval = 0
This.Parent.RemoveFoxTab()
ENDPROC
      HTop = 3
Left = 120
Height = 23
Width = 23
Name = "tmrRemoveFoxTab"
      foxtabstoolbar.foxtabDesktop      imgIcon      image      label      label      iTop = 10
Left = 2
Height = 260
Width = 350
BackStyle = 0
Curvature = 5
Style = 3
Name = "Shape1"
      $foxtabsoptions.oOptionPages.MRU.oMRU      Shape1      shape      shape      XWidth = 355
Height = 305
BackStyle = 0
BorderWidth = 0
TabIndex = 2
Name = "oMRU"
      1      ����    �   �                         p�   %   7       Q      K           �  U    �� U  
 RightClick,     ��1 B 1                       b       )   �                         1      foxtabsconfig      Pixels      Class      configurationblock      foxtabsconfig     �isactive Indicates whether the tab control is the active window
tabstyle Indicates what style of tab to display. 1 = first tab, 2 = middle tab, 3 = last tab
foxtab Reference to the FoxTab object for the window
*setactive Activates the assigned window
*tabstyle_assign 
*seticon sets the tab icon corresponding to the type of file in the window.
*isactive_assign 
*resizetab Resizes the tab control
*setwindowname Sets the window label caption
*foxtab_assign 
*setimageorientation Orientates the controls images relate to the docked position.
*showcontextmenu Displays the FoxTab control's context menu.
*setfont Sets the window label font.
      ����    �   �                         �g   %   y       �      �           �  U  #  T�  � �� �� ��C�  � � �� U  THIS INTERVAL PARENT REMOVEFOXTAB Timer,     ��1 1                       >       )   �                         foxtabsimages.vcx      
icodesktop      foxtabstoolbar      form      7checkappsettingsversion = .T.
Name = "foxtabsconfig"
      imgLeft      oMRU      	container     ����    �  �                        ��   %   �           �          �  U  -= %�C� AppSettings.DoubleClickToClose�  � � � true��&�A %�C� _screen.ActiveForm.WindowTypeb� N� �9� � �	��� � B� � ��� � T� �� � � �� T� �C� � �	 �
 � *�  ��� ��C � � � �� �(� �"�E ��C� � � � � LogError� � Exception caught closing C� _�� �� � U  OFOXTABS CONFIGURATION VALUE
 ACTIVEFORM
 WINDOWTYPE OFOXTABSTOOLBAR THIS PARENT LCWINDOWNAME FOXTAB
 WINDOWNAME RELEASEWINDOW
 OEXCEPTION  ��C�  � � �� U  THIS PARENT	 SETACTIVEM  ��  � � � � %�� � � 
��F � ��C�	 ForeColor� � � � �� � U	  NBUTTON NSHIFT NXCOORD NYCOORD THIS PARENT ISACTIVE LBLWINDOWNAME RESETTODEFAULTT  ��  � � � �> T� � � � �CC� AppSettings.ActiveFontColour� �	 �
 g�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS PARENT LBLWINDOWNAME	 FORECOLOR OFOXTABS CONFIGURATION VALUE DblClick,     �� Click�    ��
 MouseLeave!    ��
 MouseEnter�    ��1 �A A � 1�� RB A 2 2 1C�A 3 1�3                               ,  c        �  +        L  �  %    )   �                        
collection      foxtabsoptions.oOptionPages.MRU      	container      ,foxtabsoptions.oOptionPages.General.oGeneral      chkDoubleClickClose      checkbox      checkbox      ,foxtabsoptions.oOptionPages.General.oGeneral      label      mPROCEDURE RightClick
* Prevent FoxTab context menu from displaying on the desktop tab
NoDefault 
ENDPROC
      pAnchor = 514
Picture = images\icons\desktop.png
Height = 16
Left = 0
Top = 4
Width = 16
Name = "imgIcon"
     ����    �  �                        �T   %   �      i     5          �  U    T�  � � � ��  � �� U  THIS PARENT IMGLEFT HEIGHT� A %�C� _screen.ActiveForm.WindowTypeb� N� �9�  � �	��E � B� � t,� � %�CC����� � �,� t,� � %�CC��
��� � t,)�C��� � �� � �,� ��C� � �� � U 
 ACTIVEFORM
 WINDOWTYPE SCREEN THIS SETFOCUSe 	 ��C��� ��  Q� OBJECT�+ T�  �C� FoxTab� foxtabsmanager.prg���� T� � ��  �� ��C� � �� U  OFOXTAB THIS FOXTAB	 RESIZETAB  �� U   Resize,     ��	 setactivek     �� InitL    �� lblWindowName.RightClick�    ��1 �2 A A � � a � � � A � b � A 4 � �� 2 B 1                       :         Z   �        �  .        ]  �  /    )   �                        �Top = 3
Left = 49
Name = "foxtabDesktop"
imgBody.Name = "imgBody"
imgRight1.Name = "imgRight1"
imgRight2.Name = "imgRight2"
lblWindowName.Name = "lblWindowName"
      foxtabDesktop      	container      foxtabs.vcx      foxtabcontrol      foxtabstoolbar      9..\applicationblocks\configuration\configurationblock.vcx      image      Label8     ����    �  �                        &c   %         _     ?          �  U  � 	 ��C��� ���  � �Q�	 CONTAINER�� � T�� � ��  � �� T�� � ��  � �� T�� � ��  � �� T�� � ��  � �� T�� � ��  � �� T��	 � ��  � �� T��
 � ��  � �� T�� � ��  � �� �� U  THIS PARENT CHKINCLUDESOLUTIONFILES ENABLED VALUE CHKINCLUDEPROJECTFILES CHKINCLUDECLASSFILES CHKINCLUDEPROGRAMFILES CHKINCLUDEFORMFILES CHKINCLUDEDATABASEFILES CHKINCLUDETABLEFILES CBOTABLESELECTION 	 ��C��� ��C�  � �� U  THIS PROGRAMMATICCHANGE ProgrammaticChange,     �� InteractiveChange�    ��1 � �CAAAAAACB 3 � � 1                       +        S  �      )   �                        image      foxtabstoolbar      �Top = 202
Left = 50
Height = 15
Width = 138
FontName = "Tahoma"
FontSize = 8
AutoSize = .T.
Alignment = 0
BackStyle = 0
Caption = "Double-click tabs to close"
TabIndex = 6
Name = "chkDoubleClickClose"
      �FontName = "Tahoma"
FontSize = 8
BackStyle = 0
Caption = " characters"
Height = 15
Left = 257
Top = 155
Width = 55
TabIndex = 12
Name = "Label8"
      label      �FontName = "Tahoma"
FontSize = 8
Height = 24
KeyboardHighValue = 50
KeyboardLowValue = 1
Left = 214
SpinnerHighValue =  50.00
SpinnerLowValue =   1.00
TabIndex = 5
Top = 150
Width = 40
Name = "spnMaxChars"
      ,foxtabsoptions.oOptionPages.General.oGeneral      spnMaxChars      spinner      spinner      �AutoSize = .T.
FontName = "Tahoma"
FontSize = 8
BackStyle = 0
Caption = "Truncate FoxTab caption if more than "
Height = 15
Left = 28
Top = 155
Width = 186
TabIndex = 10
Name = "Label7"
      ,foxtabsoptions.oOptionPages.General.oGeneral      Label7      label      label     ?���    &  &                        �u   %   �       �      �           �  U  Z  ��  Q� INTEGER� T�  �C� � � � ��� %��  �����S � T� � � � ��  �� � U  LNFONTCOLOUR THIS PARENT TXTFONTCOLOUR	 FORECOLOR Click,     ��1 "�#aA 3                       �       )   &                        ^PROCEDURE Click
* Pause/Resume window event tracking.
This.Parent.PauseResume()

ENDPROC
      �PROCEDURE Click

Local lnFontColour As Integer 

lnFontColour  = GetColor(This.parent.txtFontColour.ForeColor)

* Set the font colour
If lnFontColour # -1
	This.parent.txtFontColour.ForeColor = lnFontColour
EndIf 


ENDPROC
      �AutoSize = .F.
Top = 75
Left = 284
Height = 23
Width = 20
FontName = "Tahoma"
FontSize = 8
Caption = "..."
TabIndex = 3
ToolTipText = "Colour picker"
Name = "cmdGetColour"
      ,foxtabsoptions.oOptionPages.General.oGeneral      cmdGetColour      commandbutton      commandbutton      ,foxtabsoptions.oOptionPages.General.oGeneral      
foxtabicon      Pixels      Class      image      
foxtabicon      image      �FontName = "Tahoma"
FontSize = 8
Height = 22
Left = 119
ReadOnly = .T.
TabIndex = 8
Top = 75
Width = 163
Name = "txtFontColour"
      txtFontColour      textbox      textbox      Label6      label     ����    n  n                        _L   %         %  	             �  U  �  %�C�  � ��� � B� � T�  � �C�  � �� ,���� T�  � �CC�  � �� ,��g��" T�  � �� BC�  � �� ,����" T�  � �� IC�  � �� ,���� U  THIS VALUE FONTNAME FONTSIZE FONTBOLD
 FONTITALIC Valid,     ��1 #A A ��!!3                       [      )   n                        cmdPause      commandbutton      commandbutton      foxtabstoolbar      
cmdOptions     fPROCEDURE Valid

* Check for an empty font setting
If Empty(This.Value)
	Return
EndIf

* Update the appearance of the texbox
This.FontName = GetWordNum(This.Value, 1, ",")
This.FontSize = Val(GetWordNum(This.Value, 2, ","))
This.FontBold = "B" $ GetWordNum(This.Value, 3, ",")
This.FontItalic = "I" $ GetWordNum(This.Value, 3, ",")	


ENDPROC
      ,foxtabsoptions.oOptionPages.General.oGeneral      label      ,foxtabsoptions.oOptionPages.General.oGeneral      commandbutton      �AutoSize = .T.
FontName = "Tahoma"
FontSize = 8
BackStyle = 0
Caption = "Active font colour"
Height = 15
Left = 28
Top = 79
Width = 87
TabIndex = 16
Name = "Label6"
      �AutoSize = .T.
FontName = "Tahoma"
FontSize = 8
Caption = " Tabs "
Height = 15
Left = 10
Top = 109
Width = 31
TabIndex = 15
ForeColor = 127,157,185
Name = "Label5"
      Label5      label      label      �AutoSize = .T.
FontName = "Tahoma"
FontSize = 8
Caption = " Appearance "
Height = 15
Left = 10
Top = 3
Width = 66
TabIndex = 14
ForeColor = 127,157,185
Name = "Label4"
      ,foxtabsoptions.oOptionPages.General.oGeneral      Label4      label      label     ����    �  �                        �   %   3      \     B          �  U  �  ��  Q� STRING� %�C� � � � ���6 � T�  �C�'�� �� �Q T�  �CC� � � � �� ,��CC� � � � �� ,��gC� � � � �� ,���'�� � %�C�  ���� � B� � T� � � � ��  �� ��C� � � � �� U  LCFONT THIS PARENT TXTFONT VALUE VALID Click,     ��1 �� � A � A A c12                       $      )   �                       /PROCEDURE Click

Local lcFont As String

* Get the font
If Empty(This.Parent.txtFont.Value)
	lcFont = GetFont()
Else
	* Pass current value as default to GetFont()
	lcFont = GetFont(	GetWordNum(This.Parent.txtFont.Value, 1, ","), ;
						Val(GetWordNum(This.Parent.txtFont.Value, 2, ",")), ;
						GetWordNum(This.Parent.txtFont.Value, 2, ",")	)
EndIf 

* Check if user selected a font or hit cancel
If Empty(lcFont)
	Return
EndIf

* Update the associated textbox
This.Parent.txtFont.Value = lcFont
This.Parent.txtFont.Valid()

ENDPROC
      �AutoSize = .F.
Top = 49
Left = 284
Height = 23
Width = 20
FontName = "Tahoma"
FontSize = 8
Caption = "..."
TabIndex = 2
ToolTipText = "Font picker"
Name = "cmdGetFont"
      ,foxtabsoptions.oOptionPages.General.oGeneral      
cmdGetFont      commandbutton      commandbutton     ����    �  �                        xF   %   4      W  
   C          �  U  �  %�C�  � ��� � B� � T�  � �C�  � �� ,���� T�  � �CC�  � �� ,��g��" T�  � �� BC�  � �� ,����" T�  � �� IC�  � �� ,���� T�  � � � ��  � �� U  THIS VALUE FONTNAME FONTSIZE FONTBOLD
 FONTITALIC PARENT TXTFONTCOLOUR Valid,     ��1 #A A ��!!�3                       �      )   �                       �PROCEDURE Valid

* Check for an empty font setting
If Empty(This.Value)
	Return
EndIf

* Update the appearance of the texbox
This.FontName = GetWordNum(This.Value, 1, ",")
This.FontSize = Val(GetWordNum(This.Value, 2, ","))
This.FontBold = "B" $ GetWordNum(This.Value, 3, ",")
This.FontItalic = "I" $ GetWordNum(This.Value, 3, ",")	

* Set the active fore colour text as well
This.Parent.txtFontColour.Value = This.Value


ENDPROC
      �FontName = "Tahoma"
FontSize = 8
Height = 22
Left = 119
ReadOnly = .T.
TabIndex = 7
Top = 49
Width = 163
Name = "txtFont"
      ,foxtabsoptions.oOptionPages.General.oGeneral      txtFont      textbox      textbox      �AutoSize = .T.
FontName = "Tahoma"
FontSize = 8
BackStyle = 0
Caption = "Font"
Height = 15
Left = 28
Top = 53
Width = 24
TabIndex = 13
Name = "Label3"
      ,foxtabsoptions.oOptionPages.General.oGeneral      Label3      label      label      �Top = 181
Left = 50
Height = 15
Width = 257
FontName = "Tahoma"
FontSize = 8
AutoSize = .T.
Alignment = 0
BackStyle = 0
Caption = "Show the window's full title as the FoxTab caption"
TabIndex = 6
Name = "chkFullname"
      ,foxtabsoptions.oOptionPages.General.oGeneral      chkFullname      checkbox      checkbox      �FontName = "Tahoma"
FontSize = 8
Height = 24
KeyboardHighValue = 20
KeyboardLowValue = 1
Left = 214
SpinnerHighValue =  20.00
SpinnerLowValue =   1.00
TabIndex = 4
Top = 124
Width = 40
Name = "spnMaxNumber"
      ,foxtabsoptions.oOptionPages.General.oGeneral      spnMaxNumber      spinner      spinner      �AutoSize = .T.
FontName = "Tahoma"
FontSize = 8
BackStyle = 0
Caption = "Maximum number of visible FoxTabs "
Height = 15
Left = 28
Top = 129
Width = 177
TabIndex = 11
Name = "Label2"
      ,foxtabsoptions.oOptionPages.General.oGeneral      Label2      label      label      �FontName = "Tahoma"
FontSize = 8
ColumnCount = 0
ColumnWidths = ""
RowSourceType = 1
RowSource = "Top,Bottom"
FirstElement = 1
Height = 22
Left = 119
NumberOfElements = 0
Style = 2
TabIndex = 1
Top = 23
Width = 185
Name = "cboDock"
      ,foxtabsoptions.oOptionPages.General.oGeneral      cboDock      combobox      combobox      �AutoSize = .T.
FontName = "Tahoma"
FontSize = 8
BackStyle = 0
Caption = "Show FoxTabs at"
Height = 15
Left = 28
Top = 27
Width = 85
TabIndex = 9
Name = "Label1"
      ,foxtabsoptions.oOptionPages.General.oGeneral      Label1      label      label      hTop = 10
Left = 2
Height = 95
Width = 350
BackStyle = 0
Curvature = 5
Style = 3
Name = "Shape1"
      ,foxtabsoptions.oOptionPages.General.oGeneral      Shape1      shape      shape      jTop = 116
Left = 2
Height = 112
Width = 350
BackStyle = 0
Curvature = 5
Style = 3
Name = "Shape2"
      ,foxtabsoptions.oOptionPages.General.oGeneral      Shape2      shape      shape      \Width = 355
Height = 305
BackStyle = 0
BorderWidth = 0
TabIndex = 1
Name = "oGeneral"
      #foxtabsoptions.oOptionPages.General      shape      =BackStyle = 0
Height = 16
Width = 16
Name = "foxtabicon"
      oGeneral      	container      	container     �ErasePage = .T.
PageCount = 2
ActivePage = 1
BorderWidth = 0
Top = 5
Left = 90
Width = 355
Height = 310
SpecialEffect = 2
Tabs = .F.
TabIndex = 3
Themes = .F.
Name = "oOptionPages"
Page1.FontName = "Microsoft Sans Serif"
Page1.FontSize = 7
Page1.Caption = "General"
Page1.BackStyle = 0
Page1.Name = "General"
Page2.FontName = "Microsoft Sans Serif"
Page2.FontSize = 7
Page2.Caption = "MRU"
Page2.BackStyle = 0
Page2.Name = "MRU"
      foxtabsoptions      oOptionPages      	pageframe      	pageframe      ����    �   �                         Ҥ   %   \       q      k           �  U    ��C� MRU�  � �� U  THISFORM
 SHOWOPTION Click,     ��1 12                       -       )   �                         8PROCEDURE Click
ThisForm.ShowOption("MRU")

ENDPROC
      �AutoSize = .T.
FontName = "Tahoma"
FontSize = 8
BackStyle = 0
Caption = "Recent files"
Height = 15
Left = 10
MousePointer = 15
Top = 35
Width = 58
Name = "lblOptionGroup"
      foxtabsoptions.optMRU      lblOptionGroup      label      label      ����    �   �                         Ҥ   %   \       q      k           �  U    ��C� MRU�  � �� U  THISFORM
 SHOWOPTION Click,     ��1 12                       -       )   �                         8PROCEDURE Click
ThisForm.ShowOption("MRU")

ENDPROC
      foxtabsoptions.optMRU      imgOptionGroup      image      commandbutton      {Picture = images\folder_time.png
Height = 32
Left = 23
MousePointer = 15
Top = 5
Width = 32
Name = "imgOptionGroup"
      image     3���                              L   %   d      �     �          �  U    ��C� MRU�  � �� U  THISFORM
 SHOWOPTION?  ��  � � � � T� � ���� T� � �C�������^�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS BORDERWIDTH	 BACKCOLOR?  ��  � � � � T� � �� �� T� � �C�������^�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS BORDERWIDTH	 BACKCOLOR Click,     ��
 MouseEnter\     ��
 MouseLeave�     ��1 13 1�3 1�1                       -         N   �         �   �      )                          �PROCEDURE Click
ThisForm.ShowOption("MRU")

ENDPROC
PROCEDURE MouseEnter
LPARAMETERS nButton, nShift, nXCoord, nYCoord

* Set border and back ground styles
This.BorderWidth = 1
This.BackColor = RGB(193,210,238)

ENDPROC
PROCEDURE MouseLeave
LPARAMETERS nButton, nShift, nXCoord, nYCoord

* Restore border and back ground styles
This.BorderWidth = 0
This.BackColor = RGB(255,255,255)
ENDPROC
      �Top = 60
Left = 6
Width = 78
Height = 50
BorderWidth = 0
MousePointer = 15
TabIndex = 2
BackColor = 255,255,255
BorderColor = 49,106,197
Name = "optMRU"
      foxtabsoptions      optMRU      	container      	container      <PROCEDURE Click
ThisForm.ShowOption("General")

ENDPROC
      foxtabsoptions.optGeneral      lblOptionGroup      label      ����    �   �                         ��   %   `       u      o           �  U    ��C� General�  � �� U  THISFORM
 SHOWOPTION Click,     ��1 q2                       1       )   �                         toolbar      shape      Shape2      cmdOk      �AutoSize = .T.
FontName = "Tahoma"
FontSize = 8
BackStyle = 0
Caption = "General"
Height = 15
Left = 19
MousePointer = 15
Top = 35
Width = 39
Name = "lblOptionGroup"
      label      ����    �   �                         ��   %   `       u      o           �  U    ��C� General�  � �� U  THISFORM
 SHOWOPTION Click,     ��1 q2                       1       )   �                         <PROCEDURE Click
ThisForm.ShowOption("General")

ENDPROC
      {Picture = images\window_gear.png
Height = 32
Left = 23
MousePointer = 15
Top = 5
Width = 32
Name = "imgOptionGroup"
      foxtabsoptions.optGeneral      imgOptionGroup      image      image      �Top = 6
Left = 6
Width = 78
Height = 50
BorderWidth = 0
MousePointer = 15
TabIndex = 1
BackColor = 255,255,255
BorderColor = 49,106,197
Name = "optGeneral"
      foxtabsoptions      
optGeneral      	container      	container      foxtabsoptions      	cmdCancel      commandbutton     7���                              _   %   h      �     �          �  U  ?  ��  � � � � T� � �� �� T� � �C�������^�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS BORDERWIDTH	 BACKCOLOR?  ��  � � � � T� � ���� T� � �C�������^�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS BORDERWIDTH	 BACKCOLOR  ��C� General�  � �� U  THISFORM
 SHOWOPTION
 MouseLeave,     ��
 MouseEnter�     �� Click4    ��1 1�2 1�3 q2                       �         �   W     	   s  �      )                           _PROCEDURE Click
* Display the FoxTabs context menu
This.Parent.ShowContextMenu()

ENDPROC
      foxtabsoptions      foxtabsoptions      commandbutton      commandbutton      commandbutton      �Anchor = 2
Picture = images\tabstyles\tabimage.left.gif
Stretch = 2
BackStyle = 0
Height = 26
Left = 36
Top = 3
Width = 13
Name = "imgLeft"
      JPROCEDURE Click
* Release the options form
ThisForm.Release

ENDPROC
      ����    �   �                         ��   %   P       e      _           �  U   
 ��  � � U  THISFORM RELEASE Click,     ��1 � 2                       ?       )   �                         ����    �   �                         �   %   �       �      �           �  U     ��C�  � �� ��C�  � � �� U  THISFORM UPDATECONFIGSETTINGS	 CMDCANCEL CLICK Click,     ��1 � 2                       u       )   �                         �Top = 320
Left = 359
Height = 23
Width = 85
FontName = "Tahoma"
FontSize = 8
Caption = "Cancel"
TabIndex = 5
Name = "cmdCancel"
      ����    �   �                         ��   %   ^       s      m           �  U    ��C�  � � �� U  THIS PARENT PAUSERESUME Click,     ��1 2                       S       )   �                         �Top = 3
Left = 21
Height = 22
Width = 16
FontName = "Webdings"
FontSize = 8
Caption = ";"
ToolTipText = "Pause"
SpecialEffect = 2
PicturePosition = 12
Name = "cmdPause"
      �Top = 5
Left = 5
Height = 340
Width = 80
Curvature = 5
BackColor = 255,255,255
BorderColor = 127,157,185
Name = "Shape2"
      �PROCEDURE Click
* Save the changes and exit
ThisForm.UpdateConfigSettings()

* Exit
ThisForm.cmdCancel.Click()

ENDPROC
      ����    �   �                         ��   %   b       w      q           �  U    ��C�  � � �� U  THIS PARENT SHOWCONTEXTMENU Click,     ��1 2                       T       )   �                         �*showoption Shows the specified options container
*updateconfigsettings Updates changes to the configuration settings.
*bindconfigsettings 
     �PROCEDURE MouseLeave
LPARAMETERS nButton, nShift, nXCoord, nYCoord

* Restore border and back ground styles
This.BorderWidth = 0
This.BackColor = RGB(255,255,255)
ENDPROC
PROCEDURE MouseEnter
LPARAMETERS nButton, nShift, nXCoord, nYCoord

* Set border and back ground styles
This.BorderWidth = 1
This.BackColor = RGB(193,210,238)

ENDPROC
PROCEDURE Click
ThisForm.ShowOption("General")

ENDPROC
      �Top = 3
Left = 5
Height = 22
Width = 16
FontName = "Webdings"
FontSize = 8
Caption = "5"
ToolTipText = "Options"
SpecialEffect = 2
PicturePosition = 12
Name = "cmdOptions"
      �Top = 320
Left = 271
Height = 23
Width = 85
FontName = "Tahoma"
FontSize = 8
Caption = "OK"
TabIndex = 4
Name = "cmdOk"
      �Height = 350
Width = 450
DoCreate = .T.
AutoCenter = .T.
BorderStyle = 2
Caption = "Options"
ControlBox = .F.
FontName = "Microsoft Sans Serif"
FontSize = 7
WindowType = 1
Name = "foxtabsoptions"
     @PROCEDURE getdefaultsettings
Lparameters lpcSection As String

Local lcDefaultSettings As String

* Handle AppSettings section only
If lpcSection # "AppSettings"
	Return DoDefault(lpcSection)
EndIf 

* Define default application settings
Text To lcDefaultSettings NoShow 
	<DockPosition>Bottom</DockPosition>
	<Font>Tahoma,8,N</Font>
	<ActiveFontColour>33023</ActiveFontColour>
	<MaxNumTabs>10</MaxNumTabs>
	<ShowFullName>false</ShowFullName>
	<MaxChars>30</MaxChars>
	<ShowRecentFiles>true</ShowRecentFiles>
	<IncludeSolutionFiles>true</IncludeSolutionFiles>
	<IncludeProjectFiles>true</IncludeProjectFiles>
	<IncludeClassFiles>true</IncludeClassFiles>
	<IncludeProgramFiles>true</IncludeProgramFiles>
	<IncludeFormFiles>true</IncludeFormFiles>
	<IncludeReportFiles>true</IncludeReportFiles>
	<IncludeDatabaseFiles>true</IncludeDatabaseFiles>
	<IncludeTableFiles>true</IncludeTableFiles>	
	<OnTableSelection>browse</OnTableSelection>
	<DoubleClickToClose>true</DoubleClickToClose>
EndText 

* Return default xml string
Return lcDefaultSettings 
ENDPROC
     f���    M  M                        �   %   �      �     �          �  U    ��C�  � � �� U  THIS PARENT	 SETACTIVE  ��C�  � � �� U  THIS PARENT SHOWCONTEXTMENU�  ��K � T�  �� � � �� T� �C� � � � � *�  ��� ��C � �  � �� �(� �� �E ��C� � � � � LogError� � Exception caught closing C� _�� �� U  OFOXTABSTOOLBAR THIS PARENT LCWINDOWNAME FOXTAB
 WINDOWNAME RELEASEWINDOW
 OEXCEPTION Click,     ��
 RightClick\     �� DblClick�     ��1 2 3 � 1�� RB 2                       ?         `   �         �   �  
    )   M                        �Caption = "FoxTabs"
Height = 32
Left = 0
Movable = .F.
Top = 0
Width = 148
_memberdata = <VFPData><memberdata name="atabstoremove" display="aTabsToRemove"/></VFPData>
lpaused = .F.
Name = "foxtabstoolbar"
     �PROCEDURE Click
* Tracey P suggestion
This.Parent.SetActive()
ENDPROC
PROCEDURE RightClick
* Display the FoxTab control's context menu
This.Parent.ShowContextMenu()

ENDPROC
PROCEDURE DblClick
* Optionally close the Window if double-clicking on it

Try
	oFoxTabsToolbar = This.Parent.Parent

	* We need to remove the * character appended when changes have been made to the file
	lcWindowName = Chrtran(This.Parent.FoxTab.WindowName, "*", "")

	oFoxTabsToolbar.ReleaseWindow(lcWindowName)

Catch To oException
	* Raise error event on FoxTabs application class
	RaiseEvent(This.Parent.Parent.Parent, "LogError", oException, "Exception caught closing " + Transform(lcWindowName))

EndTry	

ENDPROC
     _���    F  F                        �S   %   &      �     �          �  U  -= %�C� AppSettings.DoubleClickToClose�  � � � true��&�A %�C� _screen.ActiveForm.WindowTypeb� N� �9� � �	��� � B� � ��� � T� �� � � �� T� �C� � �	 �
 � *�  ��� ��C � � � �� �(� �"�E ��C� � � � � LogError� � Exception caught closing C� _�� �� � U  OFOXTABS CONFIGURATION VALUE
 ACTIVEFORM
 WINDOWTYPE OFOXTABSTOOLBAR THIS PARENT LCWINDOWNAME FOXTAB
 WINDOWNAME RELEASEWINDOW
 OEXCEPTION  ��C�  � � �� U  THIS PARENT	 SETACTIVET  ��  � � � �> T� � � � �CC� AppSettings.ActiveFontColour� �	 �
 g�� U  NBUTTON NSHIFT NXCOORD NYCOORD THIS PARENT LBLWINDOWNAME	 FORECOLOR OFOXTABS CONFIGURATION VALUEM  ��  � � � � %�� � � 
��F � ��C�	 ForeColor� � � � �� � U	  NBUTTON NSHIFT NXCOORD NYCOORD THIS PARENT ISACTIVE LBLWINDOWNAME RESETTODEFAULT\ A %�C� _screen.ActiveForm.WindowTypeb� N� �9�  � �	��E � B� � ��C� � � �� U 
 ACTIVEFORM
 WINDOWTYPE THIS PARENT SHOWCONTEXTMENU DblClick,     �� Click�    ��
 MouseEnter!    ��
 MouseLeave�    ��
 RightClick�    ��1 �A A � 1�� RB A 2 2 1�3 1C�A 3 A A 2                               ,  c        �  5        V  �  #           ,    )   F                       PROCEDURE DblClick
* Optionally close the Window if double-clicking on it, if option is enabled
IF oFoxTabs.Configuration("AppSettings.DoubleClickToClose").Value = "true"
	* If modal form is active, return
	If Type("_screen.ActiveForm.WindowType") = "N" and _screen.ActiveForm.WindowType = 1
		Return 
	EndIf 

	Try
		oFoxTabsToolbar = This.Parent.Parent

		* We need to remove the * character appended when changes have been made to the file
		lcWindowName = Chrtran(This.Parent.FoxTab.WindowName, "*", "")

		oFoxTabsToolbar.ReleaseWindow(lcWindowName)

	Catch To oException
		* Raise error event on FoxTabs application class
		RaiseEvent(This.Parent.Parent.Parent, "LogError", oException, "Exception caught closing " + Transform(lcWindowName))

	EndTry	
ENDIF 
ENDPROC
PROCEDURE Click
* Activate the assigned window
This.Parent.SetActive()
ENDPROC
PROCEDURE MouseEnter
LPARAMETERS nButton, nShift, nXCoord, nYCoord

* Set the font colour
This.Parent.lblWindowName.ForeColor = Val(oFoxTabs.Configuration("AppSettings.ActiveFontColour").Value)

ENDPROC
PROCEDURE MouseLeave
Lparameters nButton, nShift, nXCoord, nYCoord

* Reset the font colour
If Not This.Parent.IsActive
	This.Parent.lblWindowName.ResetToDefault("ForeColor")
EndIf 

ENDPROC
PROCEDURE RightClick
* If modal form is active, don't show menu
If Type("_screen.ActiveForm.WindowType") = "N" and _screen.ActiveForm.WindowType = 1
	Return 
EndIf 

* Display the FoxTab control's context menu
This.Parent.ShowContextMenu()

ENDPROC
     ����    �  �                        �   %   �      a  <   �          �  U  �  ��  Q� STRING� H� �p � ��  � General��I � T� � � ���� ��  � MRU��p � T� � � ���� �
 �� � � U  LPCOPTIONCLASS THISFORM OOPTIONPAGES
 ACTIVEPAGE REFRESHF# ���  � � � �Q�	 CONTAINER���5 T� � �� AppSettings.DockPosition�� ��� � ��- T� � �� AppSettings.Font�� ��� � ��; T� � �� AppSettings.ActiveFontColour�� �C��	 �
 _��5 T� � �� AppSettings.MaxNumTabs�� �C�� � _��3 T� � �� AppSettings.MaxChars�� �C�� � _��N T� � �� AppSettings.ShowFullName�� �CC�� � �� � false� � true6��T T� � �� AppSettings.DoubleClickToClose�� �CC�� � �� � false� � true6�� ��# ���  � � � �Q�	 CONTAINER��Q T� � �� AppSettings.ShowRecentFiles�� �CC�� � �� � false� � true6��V T� � ��  AppSettings.IncludeSolutionFiles�� �CC�� � �� � false� � true6��U T� � �� AppSettings.IncludeProjectFiles�� �CC�� � �� � false� � true6��S T� � �� AppSettings.IncludeClassFiles�� �CC�� � �� � false� � true6��U T� � �� AppSettings.IncludeProgramFiles�� �CC�� � �� � false� � true6��R T� � �� AppSettings.IncludeFormFiles�� �CC�� � �� � false� � true6��T T� � �� AppSettings.IncludeReportFiles�� �CC�� � �� � false� � true6��V T� � ��  AppSettings.IncludeDatabaseFiles�� �CC�� � �� � false� � true6��S T� � �� AppSettings.IncludeTableFiles�� �CC�� � �� � false� � true6��; T� � �� AppSettings.OnTableSelection�� �C�� � ��� �� ��C� � � �� ��C� � � �� U  THISFORM OOPTIONPAGES GENERAL OGENERAL OFOXTABS CONFIGURATION VALUE CBODOCK TXTFONT TXTFONTCOLOUR	 FORECOLOR SPNMAXNUMBER SPNMAXCHARS CHKFULLNAME CHKDOUBLECLICKCLOSE MRU OMRU CHKSHOWRECENT CHKINCLUDESOLUTIONFILES CHKINCLUDEPROJECTFILES CHKINCLUDECLASSFILES CHKINCLUDEPROGRAMFILES CHKINCLUDEFORMFILES CHKINCLUDEREPORTFILES CHKINCLUDEDATABASEFILES CHKINCLUDETABLEFILES CBOTABLESELECTION
 SAVECONFIG FOXTABSTOOLBAR REFRESHTABS# ���  � � � �Q�	 CONTAINER���3 T�� � �C� AppSettings.DockPosition� � � ��+ T�� � �C� AppSettings.Font� � � ��+ T��	 � �C� AppSettings.Font� � � ��9 T��	 �
 �CC� AppSettings.ActiveFontColour� � � g��3 T�� � �CC� AppSettings.MaxNumTabs� � � g��1 T�� � �CC� AppSettings.MaxChars� � � g��< T�� � �C� AppSettings.ShowFullName� � � � true��B T�� � �C� AppSettings.DoubleClickToClose� � � � true�� ��# ���  � � � �Q�	 CONTAINER�x�? T�� � �C� AppSettings.ShowRecentFiles� � � � true��D T�� � �C�  AppSettings.IncludeSolutionFiles� � � � true��C T�� � �C� AppSettings.IncludeProjectFiles� � � � true��A T�� � �C� AppSettings.IncludeClassFiles� � � � true��C T�� � �C� AppSettings.IncludeProgramFiles� � � � true��@ T�� � �C� AppSettings.IncludeFormFiles� � � � true��B T�� � �C� AppSettings.IncludeReportFiles� � � � true��D T�� � �C�  AppSettings.IncludeDatabaseFiles� � � � true��A T�� � �C� AppSettings.IncludeTableFiles� � � � true��9 T�� � �CC� AppSettings.OnTableSelection� � � ��� �� U  THISFORM OOPTIONPAGES GENERAL OGENERAL CBODOCK VALUE OFOXTABS CONFIGURATION TXTFONT TXTFONTCOLOUR	 FORECOLOR SPNMAXNUMBER SPNMAXCHARS CHKFULLNAME CHKDOUBLECLICKCLOSE MRU OMRU CHKSHOWRECENT CHKINCLUDESOLUTIONFILES CHKINCLUDEPROJECTFILES CHKINCLUDECLASSFILES CHKINCLUDEPROGRAMFILES CHKINCLUDEFORMFILES CHKINCLUDEREPORTFILES CHKINCLUDEDATABASEFILES CHKINCLUDETABLEFILES CBOTABLESELECTION9 ) T�  � ��  � �  - FoxTabs � � �� ��C�  � �� U  THIS CAPTION OFOXTABS VERSION BINDCONFIGSETTINGS
 showoption,     �� updateconfigsettings�     �� bindconfigsettings�    �� Init    ��1 � �1B1B � 3 4S��S1�AB 3cQ1Q!Aa1�B 2 43���3�!B 3�D11!A�B 3 �� 2                       >     
   i  n
     "   �
  �  >   9   �  �  i    )   �                       
PROCEDURE DblClick
* Optionally close the Window if double-clicking on it, if option is enabled
IF oFoxTabs.Configuration("AppSettings.DoubleClickToClose").Value = "true"
	* If modal form is active, return
	If Type("_screen.ActiveForm.WindowType") = "N" and _screen.ActiveForm.WindowType = 1
		Return 
	EndIf 

	Try
		oFoxTabsToolbar = This.Parent.Parent

		* We need to remove the * character appended when changes have been made to the file
		lcWindowName = Chrtran(This.Parent.FoxTab.WindowName, "*", "")

		oFoxTabsToolbar.ReleaseWindow(lcWindowName)

	Catch To oException
		* Raise error event on FoxTabs application class
		RaiseEvent(This.Parent.Parent.Parent, "LogError", oException, "Exception caught closing " + Transform(lcWindowName))

	EndTry	
ENDIF 
ENDPROC
PROCEDURE Click
* Activate the assigned window
This.Parent.SetActive()
ENDPROC
PROCEDURE MouseLeave
LPARAMETERS nButton, nShift, nXCoord, nYCoord

* Reset the font colour
If Not This.Parent.IsActive
	This.Parent.lblWindowName.ResetToDefault("ForeColor")
EndIf 

ENDPROC
PROCEDURE MouseEnter
LPARAMETERS nButton, nShift, nXCoord, nYCoord

* Set the font colour
This.Parent.lblWindowName.ForeColor = Val(oFoxTabs.Configuration("AppSettings.ActiveFontColour").Value)


ENDPROC
     �PROCEDURE showoption
Lparameters lpcOptionClass As String

* Show the corresponding options page page
Do Case
	Case lpcOptionClass = "General"
		ThisForm.oOptionPages.ActivePage = 1

	Case lpcOptionClass = "MRU"
		ThisForm.oOptionPages.ActivePage = 2

EndCase 

* Refresh the container
ThisForm.Refresh

ENDPROC
PROCEDURE updateconfigsettings
* Update changes to configuration settings

* General settings
With ThisForm.oOptionPages.General.oGeneral As Container

	* Appearance settings
	oFoxTabs.Configuration("AppSettings.DockPosition").Value = .cboDock.Value
	oFoxTabs.Configuration("AppSettings.Font").Value = .txtFont.Value
	oFoxTabs.Configuration("AppSettings.ActiveFontColour").Value = Transform(.txtFontColour.ForeColor)

	* Tab settings
	oFoxTabs.Configuration("AppSettings.MaxNumTabs").Value = Transform(.spnMaxNumber.Value)
	oFoxTabs.Configuration("AppSettings.MaxChars").Value = Transform(.spnMaxChars.Value)
	oFoxTabs.Configuration("AppSettings.ShowFullName").Value = Iif(Empty(.chkFullname.Value), "false", "true")
	oFoxTabs.Configuration("AppSettings.DoubleClickToClose").Value = IIF(EMPTY(.chkDoubleClickClose.Value), "false", "true")

EndWith

* MRU settings
With ThisForm.oOptionPages.MRU.oMRU As Container

	* Show recent files menu item
	oFoxTabs.Configuration("AppSettings.ShowRecentFiles").Value = Iif(Empty(.chkShowRecent.Value), "false", "true")

	* File inclusions
	oFoxTabs.Configuration("AppSettings.IncludeSolutionFiles").Value = Iif(Empty(.chkIncludeSolutionFiles.Value), "false", "true")
	oFoxTabs.Configuration("AppSettings.IncludeProjectFiles").Value = Iif(Empty(.chkIncludeProjectFiles.Value), "false", "true")
	oFoxTabs.Configuration("AppSettings.IncludeClassFiles").Value = Iif(Empty(.chkIncludeClassFiles.Value), "false", "true")
	oFoxTabs.Configuration("AppSettings.IncludeProgramFiles").Value = Iif(Empty(.chkIncludeProgramFiles.Value), "false", "true")
	oFoxTabs.Configuration("AppSettings.IncludeFormFiles").Value = Iif(Empty(.chkIncludeFormFiles.Value), "false", "true")
	oFoxTabs.Configuration("AppSettings.IncludeReportFiles").Value = Iif(Empty(.chkIncludeReportFiles.Value), "false", "true")
	oFoxTabs.Configuration("AppSettings.IncludeDatabaseFiles").Value = Iif(Empty(.chkIncludeDatabaseFiles.Value), "false", "true")
	oFoxTabs.Configuration("AppSettings.IncludeTableFiles").Value = Iif(Empty(.chkIncludeTableFiles.Value), "false", "true")

	* On table selection
	oFoxTabs.Configuration("AppSettings.OnTableSelection").Value = Proper(.cboTableSelection.Value)

EndWith 

* Save configuration
oFoxTabs.Configuration.SaveConfig()
oFoxTabs.FoxTabsToolbar.RefreshTabs()
ENDPROC
PROCEDURE bindconfigsettings
* Bind controls to configuration settings

* General settings
With ThisForm.oOptionPages.General.oGeneral As Container

	* Appearance settings
	.cboDock.Value = oFoxTabs.Configuration("AppSettings.DockPosition").Value
	.txtFont.Value = oFoxTabs.Configuration("AppSettings.Font").Value
	.txtFontColour.Value = oFoxTabs.Configuration("AppSettings.Font").Value
	.txtFontColour.ForeColor = Val(oFoxTabs.Configuration("AppSettings.ActiveFontColour").Value)

	* Tab settings
	.spnMaxNumber.Value = Val(oFoxTabs.Configuration("AppSettings.MaxNumTabs").Value)
	.spnMaxChars.Value 	= Val(oFoxTabs.Configuration("AppSettings.MaxChars").Value)
	.chkFullname.Value 	= ( oFoxTabs.Configuration("AppSettings.ShowFullName").Value = "true" )
	.chkDoubleClickClose.Value = ( oFoxTabs.Configuration("AppSettings.DoubleClickToClose").Value = "true" )

EndWith

* MRU settings
With ThisForm.oOptionPages.MRU.oMRU As Container

	* Show recent files menu item
	.chkShowRecent.Value = ( oFoxTabs.Configuration("AppSettings.ShowRecentFiles").Value = "true" )

	* File inclusions
	
	.chkIncludeSolutionFiles.Value	= ( oFoxTabs.Configuration("AppSettings.IncludeSolutionFiles").Value = "true" )
	.chkIncludeProjectFiles.Value 	= ( oFoxTabs.Configuration("AppSettings.IncludeProjectFiles").Value = "true" )
	.chkIncludeClassFiles.Value 	= ( oFoxTabs.Configuration("AppSettings.IncludeClassFiles").Value = "true" )
	.chkIncludeProgramFiles.Value 	= ( oFoxTabs.Configuration("AppSettings.IncludeProgramFiles").Value = "true" )
	.chkIncludeFormFiles.Value 		= ( oFoxTabs.Configuration("AppSettings.IncludeFormFiles").Value = "true" )
	.chkIncludeReportFiles.Value 	= ( oFoxTabs.Configuration("AppSettings.IncludeReportFiles").Value = "true" )
	.chkIncludeDatabaseFiles.Value 	= ( oFoxTabs.Configuration("AppSettings.IncludeDatabaseFiles").Value = "true" )
	.chkIncludeTableFiles.Value 	= ( oFoxTabs.Configuration("AppSettings.IncludeTableFiles").Value = "true" )

	* On table selection
	.cboTableSelection.Value = Proper(oFoxTabs.Configuration("AppSettings.OnTableSelection").Value)

EndWith 

ENDPROC
PROCEDURE Init

* Set the version number on the caption
This.Caption = This.Caption + " - FoxTabs " + oFoxTabs.Version

* Bind configuration settings to controls
This.BindConfigSettings()

ENDPROC
     �PROCEDURE Resize
This.Parent.imgLeft.Height = This.Height
ENDPROC
PROCEDURE setactive
* The desktop tab is a special case as it is not assigned to any IDE window.
* When the user clicks on this tab we need to hide all windows in the IDE
* If windows are already hidden, show them all

* If modal form is active, do nothing
If Type("_screen.ActiveForm.WindowType") = "N" and _screen.ActiveForm.WindowType = 1
	Return 
EndIf 

Activate Window Screen 
If Empty(Wontop())
	Show Window All
	Activate Window Screen 
	If !Empty(Wontop())
		Activate Window (Wontop()) Top 
	EndIf 
Else 
	* Hide all windows
	Hide Window All
	* Set focus to this tab
	This.SetFocus()
EndIf 


ENDPROC
PROCEDURE Init
* Set a reference to an empty FoxTab object so the Desktop control
*	behaves the same as all other controls

* Do base class method code
DoDefault()

Local oFoxTab As Object

* Create a new instance of our FoxTab class
oFoxTab = NewObject("FoxTab", "foxtabsmanager.prg")

* Set the class property
This.FoxTab = oFoxTab

This.ResizeTab()
ENDPROC
PROCEDURE lblWindowName.RightClick
* Prevent FoxTab context menu from displaying on the desktop tab
NoDefault 
ENDPROC
     ����    m  m                        �   %   �      $     �          �  U  � ��  Q� STRING� �� Q� STRING� %��  � AppSettings��K � B�C �  ��� �	 M(� ��* �$ 	<DockPosition>Bottom</DockPosition>� � 	<Font>Tahoma,8,N</Font>�1 �+ 	<ActiveFontColour>33023</ActiveFontColour>�" � 	<MaxNumTabs>10</MaxNumTabs>�) �# 	<ShowFullName>false</ShowFullName>� � 	<MaxChars>30</MaxChars>�. �( 	<ShowRecentFiles>true</ShowRecentFiles>�8 �2 	<IncludeSolutionFiles>true</IncludeSolutionFiles>�6 �0 	<IncludeProjectFiles>true</IncludeProjectFiles>�2 �, 	<IncludeClassFiles>true</IncludeClassFiles>�6 �0 	<IncludeProgramFiles>true</IncludeProgramFiles>�0 �* 	<IncludeFormFiles>true</IncludeFormFiles>�4 �. 	<IncludeReportFiles>true</IncludeReportFiles>�8 �2 	<IncludeDatabaseFiles>true</IncludeDatabaseFiles>�3 �- 	<IncludeTableFiles>true</IncludeTableFiles>	�2 �, 	<OnTableSelection>browse</OnTableSelection>�4 �. 	<DoubleClickToClose>true</DoubleClickToClose>� �	 B�� �� U 
 LPCSECTION LCDEFAULTSETTINGS getdefaultsettings,     ��1 �� A � ��!����a!aA�1!AA � 1                       5      )   m                       \_memberdata XML Metadata for customizable properties
lpaused Is .T. when event tracking is paused.
*showoptionsdialog Displays the FoxTabs options dialog
*addfoxtab Event handler for the FoxTabsManager AddFoxTab event
*removefoxtab Event handler for the FoxTabsManager RemoveFoxTab event
*gotfocus Event handler for the FoxTabsManager GotFocus event
*onchange Event handler for the FoxTabsManager OnChange event
*setbindings Setup event bindings to the FoxTabs manager.
*controlexists Returns true if a FoxTab control exists for the given windows handle.
*releasewindow Releases the specified IDE window. Pass "ALL" to release all IDE windows.
*oktoaddfoxtab Returns true if it is ok to add the new FoxTab control. Otherwise false.
*activatewindow Activate the window with the specified name
*showlastfoxtab Set the most recent hidden FoxTab control visible
*hidefirstfoxtab Hides the first visible FoxTab control
*getfoxwindowname Returns the window name used by Windows messaging from the window name used by VFP
*savewindow Saves one or all of the active windows
*setdockposition Docks the toolbar according to the application setting DockPosition.
*showcontextmenu Display the FoxTabToolbar context menu
*definemrumenu Defines the most recently used files popup menu
*definemrusubmenu Defines the most recently used submenu for the given file type.
*getmruid Returns the Mru id for the given file type.
*modifyfile Executes the MODIFY statement for the given file
*refreshtabs Force a refresh of the row of tabs
*pauseresume Pause/Resume window event tracking.
^atabstoremove[1,0] FoxTab to remove.
     f�PROCEDURE showoptionsdialog

Local oDialog As Form

* Display the options dialog
oDialog = NewObject("foxtabsOptions", "foxtabs.vcx")
oDialog.Show(1)

* Re-dock the FoxTabs toolbar
This.SetDockPosition()
ENDPROC
PROCEDURE addfoxtab
* Add a new FoxTab control to the toolbar
Lparameters oFoxTab As Object

Local oException As Exception, oFoxTabControl As Object
Local lcControlName As String, lcWindowName As String

Try
	* Perform the checks to determine if its ok to add a new tab control
	If Not This.OkToAddFoxTab(oFoxTab)
		Exit
	EndIf 

	* Lock the screen
	This.LockScreen = .T.

	* Set the tab style of the other tab controls
	For Each oFoxTabControl In This.Controls
		If Lower(oFoxTabControl.Class) = "foxtabcontrol"
			oFoxTabControl.TabStyle = 2
		EndIf 
	Next 

	* Create a unqiue name for the new control
	lcControlName = Sys(2015)

	* Create a new instance of our FoxTab control
	This.NewObject(lcControlName, "Foxtabcontrol", "foxtabs.vcx")
	oFoxTabControl = Evaluate("This." + lcControlName)

	* Add a reference to our FoxTab object
	oFoxTabControl.FoxTab = oFoxTab

	* Set window icon
	oFoxTabControl.SetIcon()

	* Set window name
	oFoxTabControl.setWindowName()

	* Show the FoxTab control
	oFoxTabControl.Visible = .T.

Catch To oException
	Throw oException

Finally
	* Lock the screen
	This.LockScreen = .F.

EndTry 
ENDPROC
PROCEDURE removefoxtab
* Remove the corresponding FoxTab control from the toolbar
Lparameters oFoxTab As Object

Local oFoxTabControl As Object
Local lnControl As Integer

* Delay removal of tabs because of timing issues with error reporting
* See http://www.codeplex.com/VFPX/WorkItem/View.aspx?WorkItemId=19330
* This can be called multiple times before timer fires, so put hWnds in queue.
If Vartype(oFoxTab) = "O"
	If !Empty(This.aTabsToRemove[1])
		Dimension This.aTabsToRemove[Alen(This.aTabsToRemove)+1]
		Ains(This.aTabsToRemove, 1)
	EndIf 
	This.aTabsToRemove[1] = oFoxTab.hWnd
	This.tmrRemoveFoxTab.Interval = 100
	Return 
EndIf 

* Remove all tabs in queue
Do while !Empty(This.aTabsToRemove[1])
	* Locate the FoxTab control
	For Each oFoxTabControl In This.Controls
		If Lower(oFoxTabControl.Class) = "foxtabcontrol" ;
			And oFoxTabControl.FoxTab.hWnd = This.aTabsToRemove[1]
			
			* Release the reference to the FoxTab object
			oFoxTabControl.FoxTab = Null
			
			* Remove the FoxTab control
			This.RemoveObject(oFoxTabControl.Name)	
				
			* All done	
			Exit
		EndIf 
	Next 
	Adel(This.aTabsToRemove, 1)
EndDo 

* Show the most recent hidden FoxTab control
This.ShowLastFoxTab()
		
* Set the tab style of the last tab control
For lnControl = This.ControlCount To 1 Step -1		
	oFoxTabControl = This.Controls(lnControl)
	If Lower(oFoxTabControl.Class) = "foxtabcontrol" And oFoxTabControl.Visible
		oFoxTabControl.TabStyle = 3		&& last tab			
		* All done. Exit For Each loop
		Exit
	EndIf 			
Next 

ENDPROC
PROCEDURE gotfocus
* Set focus to the corresponding FoxTab control
Lparameters oFoxTab As Object

Local oException As Exception, oFoxTabControl As Object

Try
	* Lock the screen
	This.LockScreen = .T.

	* Locate the FoxTab control
	For Each oFoxTabControl In This.Controls
		If Lower(oFoxTabControl.Class) = "foxtabcontrol" ;
			And oFoxTabControl.FoxTab.hWnd = oFoxTab.hWnd
			
			* Show the FoxTab control if not visible
			If Not oFoxTabControl.Visible
				This.HideFirstFoxTab()
				oFoxTabControl.Visible = .T.
			EndIf 

			* Set the focus to this control
			oFoxTabControl.SetFocus()

			* All done. Exit For Each loop
			Exit

		EndIf 
	Next 

Catch To oException
	Throw oException

Finally
	* Lock the screen
	This.LockScreen = .F.

EndTry 
ENDPROC
PROCEDURE onchange
* Update the corresponding FoxTab control
Lparameters oFoxTab As Object

Local oException As Exception, oFoxTabControl As Object

Try
	* Lock the screen
	This.LockScreen = .T.

	* Locate the FoxTab control
	For Each oFoxTabControl In This.Controls
		If Lower(oFoxTabControl.Class) = "foxtabcontrol" ;
			And oFoxTabControl.FoxTab.hWnd = oFoxTab.hWnd
			
			* Set window name
			oFoxTabControl.setWindowName()

			* All done. Exit For Each loop
			Exit

		EndIf 
	Next 

Catch To oException
	Throw oException
	
Finally
	* Lock the screen
	This.LockScreen = .F.

EndTry 
ENDPROC
PROCEDURE setbindings
* Setup bindings to the FoxTabs Manager 
BindEvent(oFoxTabs.FoxTabsManager, "AddFoxTabEvent", This, "AddFoxTab")
BindEvent(oFoxTabs.FoxTabsManager, "RemoveFoxTabEvent", This, "RemoveFoxTab")
BindEvent(oFoxTabs.FoxTabsManager, "GotFocusEvent", This, "GotFocus")
BindEvent(oFoxTabs.FoxTabsManager, "OnChangeEvent", This, "OnChange")

ENDPROC
PROCEDURE controlexists
Lparameters lpcHWnd As String

Local oFoxTabControl As Object

* Check if a FoxTab control exists in the collection for the given hWnd
For Each oFoxTabControl In This.Controls
	* Check if it is a match	
	If 	Lower(oFoxTabControl.Class) = "foxtabcontrol" And ;		&& tab container control
		oFoxTabControl.FoxTab.hWnd == lpcHWnd							&& matching windows handle
		
		Return .T.
	EndIf
Next 

Return .F.
ENDPROC
PROCEDURE releasewindow
Lparameters lpcWindowName As String
	
Local oFoxTab As Object

* Release all windows when "ALL" is passed
If lpcWindowName = "ALL"
	Do While oFoxTabs.FoxTabsManager.FoxTabs.Count > 0
		* Obtain a reference to the first FoxTab
		oFoxTab = oFoxTabs.FoxTabsManager.FoxTabs.Item(1)

		* Patch submitted by mk to fix issue when Command Window is undocked,
		*	form is open, and Close All is selected.
		*	See https://vfpx.codeplex.com/workitem/35441
		lpcWindowName = Chrtran(m.oFoxTab.WindowName, "*", "")
		If Upper(lpcWindowName)='COMMAND'
			oFoxTab = oFoxTabs.FoxTabsManager.FoxTabs.Item(2)
		Endif		
		
		* Strip the has changes flag
		lpcWindowName = Chrtran(oFoxTab.WindowName, "*", "")	
		If Not Empty(lpcWindowName)
			* Recursion call
			This.ReleaseWindow(lpcWindowName)
		EndIf 
	EndDo

	Return

EndIf

* Gather the VFP window name from the one used by Window's
lpcWindowName = This.GetFoxWindowName(lpcWindowName)

* Check the Fox window exists
If Not Wexist(lpcWindowName)
	Return 
EndIf

* Switched to calling the Close menu item as VFP Release Windows function
*	was not working correctly on some code windows and IDE tool windows.

* First activate the window
Activate Window (lpcWindowName)

* Now call the Close menu item
Sys(1500, "_MFI_CLOSE", "_MFILE")
*JAL: Not sure why using menu call above, but Release Window in case menu not available
* Do not release window if name starts with "Screen", or VFP will close. See http://vfpx.codeplex.com/WorkItem/View.aspx?WorkItemId=24767.
If UPPER(lpcWindowName) <> "SCREEN"
	Release Windows (lpcWindowName)
EndIf 

* CJB 06 Sep2 006 - to force the resize of the toolbar
this.Resize()

Return
ENDPROC
PROCEDURE oktoaddfoxtab
* Perform the checks to determine if its ok to add a new tab control
Lparameters oFoxTab As Object

Local lnMaxFoxTabs As Integer

* Check if a FoxTab control already exists for the passed FoxTab object
If This.ControlExists(oFoxTab.hWnd)
	* Not interested
	Return .F.
EndIf 

* Check if the maximum allowable FoxTabs have already been reached
If oFoxTabs.FoxTabsManager.FoxTabs.Count > Val(oFoxTabs.Configuration("AppSettings.MaxNumTabs").Value)
	* Hide the first visible FoxTab control
	This.HideFirstFoxTab()
EndIf 

* Otherwise all checks have been met
Return .T.

ENDPROC
PROCEDURE activatewindow
Lparameters lpcWindowName As String

Local oFoxTabControl As Object
Local oException As Exception

Try
	* Lock the screen
	This.LockScreen = .T.

	* Locate the FoxTab control
	For Each oFoxTabControl In This.Controls
		If Lower(oFoxTabControl.Class) = "foxtabcontrol" ;
			And oFoxTabControl.FoxTab.WindowName == lpcWindowName
			
			* Show the FoxTab control if not visible
			If Not oFoxTabControl.Visible
				This.HideFirstFoxTab()
				oFoxTabControl.Visible = .T.
			EndIf 
			
			* Activate the window
			oFoxTabControl.SetActive()

			* All done
			Exit
		EndIf 
	Next 

Catch To oException
	* Set exception header details and throw to caller
	oException.UserValue = "Exception caught while activating window: " + Transform(lpcWindowName)
	Throw oException

Finally
	* Lock the screen
	This.LockScreen = .F.

EndTry 
ENDPROC
PROCEDURE showlastfoxtab
* Set the most recent hidden FoxTab control visible

Local oFoxTabControl As Object
Local lnControl As Integer 

* Loop through FoxTab controls from most recent first
For lnControl = This.ControlCount To 1 Step -1		
	oFoxTabControl = This.Controls(lnControl)
	If Lower(oFoxTabControl.Class) = "foxtabcontrol" ;
		And Not oFoxTabControl.Visible
		
		* Set the FoxTab control visible
		oFoxTabControl.Visible = .T.
		* All done. Exit For Each loop
		Exit
	EndIf 			
Next 
ENDPROC
PROCEDURE hidefirstfoxtab

Local oFoxTabControl As Object
Local lnControl As Integer

* Hide the first visible FoxTab control
For lnControl = 1 To This.ControlCount
	oFoxTabControl = This.Controls(lnControl)
	If Lower(oFoxTabControl.Class) = "foxtabcontrol" ;
		And Lower(oFoxTabControl.Name) # "foxtabdesktop" ;
		And oFoxTabControl.Visible
		
		* Hide the FoxTab control 
		oFoxTabControl.Visible = .F.
		Exit
	EndIf 			
Next 

ENDPROC
PROCEDURE getfoxwindowname
* Gather the VFP window name from the Window's window name
* 	That is, check for IDE tools such as class browser, taskpane, e.t.c.
*	which have different window names in VFP to that used by Windows messaging.
Lparameters lpcFoxWindowName As String

Local lcWindowName As String

Do Case
	Case Wexist(lpcFoxWindowName)
		* No need to transform window name as the same name is used by VFP
		lcWindowName = lpcFoxWindowName
		
*JAL: Handle by window name in Otherwise instead, because that supports more than one instance of the tool
*JAL*		Case "class browser" $ Lower(lpcFoxWindowName) And Type("_oBrowser") = "O"
*JAL*			lcWindowName = _oBrowser.Name
*JAL*			
*JAL*		Case "component gallery" $ Lower(lpcFoxWindowName) And Type("_oBrowser") = "O"
*JAL*			lcWindowName = _oBrowser.Name
*JAL*			
*JAL*		Case "object browser" $ Lower(lpcFoxWindowName) And Type("_oObjectBrowser") = "O"
*JAL*			lcWindowName = _oObjectBrowser.Name

	Case "tasks" == Lower(lpcFoxWindowName) And Type("_oTaskList") = "O"
		lcWindowName = _oTaskList.TaskUI.Name

	Case "intellisense manager" $ Lower(lpcFoxWindowName) And Type("_oIntMgr") = "O"
		lcWindowName = _oIntMgr.Name

	Case "task pane manager" $ Lower(lpcFoxWindowName) And Type("_oTaskPane") = "O"
		lcWindowName = _oTaskPane.Name

	Case "toolbox" = Lower(lpcFoxWindowName) And Type("_oToolBox") = "O"
		lcWindowName = _oToolBox.Name
		
	Case "code references" $ Lower(lpcFoxWindowName) And Type("_oFoxRef") = "O"
		lcWindowName = _oFoxRef.Name
		
	Case Lower(lpcFoxWindowName) = "document view"
		* Document View title/name changes when each code window is activated
		* But VFP still expects "Document View"
		* See https://vfpx.codeplex.com/workitem/31281
		lcWindowName = "Document View"
		
	Otherwise

		* Try to find Fox window with matching title
		* JAL: It would be more efficient to determine the window name when it is opened,
		*	but I was able to make this change in one place without breaking anything else.
		*	I may change this after I get more familiar with the code.
		Local lnFoxWinCnt, lcFoxWin, lnFoxWindow
		lnFoxWinCnt = Wchild("")
		lcFoxWin = Wchild("",0) && first window name
		For lnFoxWindow = 1 to lnFoxWinCnt
		      If !Empty(lcFoxWin) and Upper(Wtitle(lcFoxWin)) == Upper(lpcFoxWindowName)
		            lcWindowName = lcFoxWin
		            Exit
		      EndIf
		      lcFoxWin = Wchild("",1)
		EndFor
		 
		* Unknown
		If Empty(lcWindowName)
		      lcWindowName = lpcFoxWindowName
		EndIf

EndCase

* Return the Window's window name to caller
Return lcWindowName

ENDPROC
PROCEDURE savewindow
Lparameters lpcWindowName As String
	
Local oException As Exception, oFoxTab As Object

* Save all windows when "ALL" is passed
If lpcWindowName = "ALL"
	For Each oFoxTab In oFoxTabs.FoxTabsManager.FoxTabs
		* Strip the has changes flag
		lpcWindowName = Chrtran(oFoxTab.WindowName, "*", "")	
		If Not Empty(lpcWindowName)
			* Recursion call
			This.SaveWindow(lpcWindowName)
		EndIf 
	Next 	

	Return

EndIf

* Gather the VFP window name from the one used by Window's
lpcWindowName = This.GetFoxWindowName(lpcWindowName)

* Check the Fox window exists
If Not Wexist(lpcWindowName)
	Return 
EndIf

* First activate the window
Activate Window (lpcWindowName)

* Now call the Save menu item
Sys(1500, "_MFI_SAVE", "_MFILE")

* All done
Return


ENDPROC
PROCEDURE setdockposition

Local lcDockPosition As String

* Gather the dock position from the application settings
lcDockPosition = This.Parent.Configuration("AppSettings.DockPosition").Value

* Dock the toolbar
Do Case
	Case lcDockPosition = "Top" 
		If This.DockPosition # 0
			* Set a large y coordinate so we position the toolbar at the bottom of 
			* 	any other toolbars
			This.Dock(0, 0, 1000)	
		EndIf 

	Case lcDockPosition = "Bottom"
 		If This.DockPosition # 3
	 		This.Dock(3)		
	 	EndIf 

	Otherwise
		If  This.DockPosition # 3
			* Default to bottom ('cause I prefer it there!)
			This.Dock(3)
		EndIf 
		
EndCase

ENDPROC
PROCEDURE showcontextmenu
* Display the FoxTabs context menu

Local oException As Exception, oFoxTabsToolbar As Toolbar, oFoxTab As Object
Local lnRow As Integer, lnColumn As Integer, lnFoxelWidth As Integer, lnPixelWidth As Integer, lnFoxelHeight As Integer, lnPixelHeight As Integer, lnMenuHeight As Integer 
Local lnFoxTabCount As Integer, lnFoxTab As Integer, lbShowRecentFiles As Boolean, lnMenuBars As Integer 

Try
	* Obtain a reference to the toolbar for ease of use with the popup menu
	oFoxTabsToolbar = This

	* Calculate scale factor
	Activate Screen	&& make sure using SCREEN for menu position
	_Screen.ScaleMode = 0
	lnFoxelWidth = _Screen.Width  
	lnFoxelHeight = _Screen.Height 
	_Screen.ScaleMode = 3
	lnPixelWidth = _Screen.Width  
	lnPixelHeight = _Screen.Height 

	* Gather the number of FoxTabs
	lnFoxTabCount = This.Parent.FoxTabsManager.FoxTabs.Count

	* Determine if we are to show recent files
	lbShowRecentFiles = ( This.Parent.Configuration("AppSettings.ShowRecentFiles").Value = "true" )

	* Menu height is calculated as follows
	*	19 pixels per bar 				+
	*	6  pixels per horizontal line 	+ 
	*	8  for the top and bottom margins

	* Gather number of menu items and hr's
	lnMenuBars = lnFoxTabCount + Iif(lbShowRecentFiles, 6, 5)
	lnMenuLines = ICase(lnFoxTabCount > 0 And lbShowRecentFiles, 4, ;
						lnFoxTabCount > 0 Or lbShowRecentFiles, 3, ;
						2)	

	* Calculate menu height
	lnMenuHeight = 	(19 * lnMenuBars ) + ;
					( 6 * lnMenuLines ) + ;
					8

	* Determine where to position the context menu
	lnColumn = Wlcol("FoxTabs")	&& toolbar column
	Do Case
		Case This.DockPosition = 0	&& Top
			lnRow = 0
		Case This.DockPosition = 3	&& Bottom
			lnRow = Wlrow("FoxTabs") - (lnMenuHeight * (lnFoxelHeight / lnPixelHeight))
		Case This.DockPosition = -1	&& Undocked
			lnRow = (This.Top - lnMenuHeight) * (lnFoxelHeight / lnPixelHeight)
		Otherwise
			lnRow = Mrow("Screen", 0) * (lnFoxelHeight / lnPixelHeight)
	EndCase 

	* Define context menu
	*	Note: There is never a OO menu class when you need one?
	Define Popup foxtabContextMenu ShortCut Relative From lnRow, lnColumn 

	* Add each FoxTab to window list
	For lnFoxTab = 1 To lnFoxTabCount 
		* Obtain a reference to the FoxTab
		oFoxTab = This.Parent.FoxTabsManager.FoxTabs.Item(lnFoxTab)
		* Add window menu item
		Define Bar (lnFoxTab) Of foxtabContextMenu Prompt (oFoxTab.WindowName)
	Next

	* Define static context menu items
	If lnFoxTabCount > 0
		Define Bar (lnFoxTabCount+1) Of foxtabContextMenu Prompt "\-" 
	EndIf

	Define Bar (lnFoxTabCount+2) Of foxtabContextMenu Prompt "Close All" 
	Define Bar (lnFoxTabCount+3) Of foxtabContextMenu Prompt "Save All" 
	Define Bar (lnFoxTabCount+4) Of foxtabContextMenu Prompt "\-" 

	* Are we showing the recent files sub menu
	If lbShowRecentFiles

		* Define menu item
		Define Bar (lnFoxTabCount+5) Of foxtabContextMenu Prompt "Recent files" 
		Define Bar (lnFoxTabCount+6) Of foxtabContextMenu Prompt "\-" 

		* Define MRU popup menu
		This.DefineMRUMenu()
		
	EndIf 

	Define Bar (lnFoxTabCount+7) Of foxtabContextMenu Prompt "Options" 
	Define Bar (lnFoxTabCount+8) Of foxtabContextMenu Prompt "Refresh" 
	Define Bar (lnFoxTabCount+9) Of foxtabContextMenu Prompt "\-" 
	Define Bar (lnFoxTabCount+10) Of foxtabContextMenu Prompt "Exit" 

	* Bind event handlers
	On Selection Bar (lnFoxTabCount+2) Of foxtabContextMenu oFoxTabsToolbar.ReleaseWindow("ALL")
	On Selection Bar (lnFoxTabCount+3) Of foxtabContextMenu oFoxTabsToolbar.SaveWindow("ALL")

	* Are we showing the recent files sub menu
	If lbShowRecentFiles
		On Bar (lnFoxTabCount+5) Of foxtabContextMenu Activate Popup foxtabMRUMenu
	EndIf 
	
	On Selection Bar (lnFoxTabCount+7) Of foxtabContextMenu oFoxTabsToolbar.ShowOptionsDialog()
	On Selection Bar (lnFoxTabCount+8) Of foxtabContextMenu oFoxTabsToolbar.RefreshTabs()
	On Selection Bar (lnFoxTabCount+10) Of foxtabContextMenu oFoxTabsToolbar.Release()
	On Selection Popup foxtabContextMenu oFoxTabsToolbar.ActivateWindow(Prompt())

	* Show menu
	Activate Popup foxtabContextMenu 

Catch To oException
	* Raise error event on FoxTabs application class
	RaiseEvent(This.Parent, "LogError", oException, "Exception caught while activating the options context menu.")

EndTry

ENDPROC
PROCEDURE definemrumenu
* Define the most recently used files menu

Local lcMruFileTypeList As String, lcMruFileType As String, lnMruBar As Integer, lbMenuDefined As Boolean 

* Define Mru file types allowed
*JAL: Solution explorer currently not available, so removed from menu for now
*JAL*	lcMruFileTypeList = [Solution,Project,Class,Program,Form,Database,Table]
lcMruFileTypeList = [Project,Class,Program,Form,Report,Database,Table]

For lnMruBar = 1 To GetWordCount(lcMruFileTypeList, ",")

	* Gather mru file type from list
	lcMruFileType = Alltrim(GetWordNum(lcMruFileTypeList, lnMruBar, ","))

	* Check file type include settings
	If ( This.Parent.Configuration("AppSettings.Include" + lcMruFileType + "Files").Value = "true" )

		If Not lbMenuDefined
			* At least one option is enabled, so define popup menu
			Define Popup foxtabMruMenu Relative ShortCut
			
			* Set boolean so we do not define the menu again
			lbMenuDefined = .T.
		EndIf
				
		* Add mru menu item for this file type
		Define Bar (lnMruBar) Of foxtabMruMenu Prompt (lcMruFileType)
		
		* Bind event handler
		On Bar (lnMruBar) Of foxtabMruMenu Activate Popup (lcMruFileType + "MruMenu")

		* Define Mru submenu
		This.DefineMruSubmenu(lcMruFileType)
		
	Endif	
	
Next




ENDPROC
PROCEDURE definemrusubmenu
* Define the Mru submenu for the given file type
Lparameters lpcMruFileType As String

Local oResource As Object, oFoxTabsToolbar As Toolbar 
Local lcSubmenuName As String, lcMruId As String, lnMruBar As Integer, lcResourceData As String, lcBuffer As String, lcMruData As String, lcMruFile As String, lcMruPrompt As String, lbMenuDefined As Boolean

* Obtain a reference to the toolbar for ease of use with the popup menu
oFoxTabsToolbar = This

* Construct the submenu name from the given file type
lcSubmenuName = lpcMruFileType + "MruMenu"

* Gather Mru data from the resource table
oResource  = NewObject("FoxResource", "..\ApplicationBlocks\Common\FoxResource.prg")

* Determine Mru id from the given file type
lcMruId = This.getMruId(lpcMruFileType)

* Query for MRU file list of type specified
lcResourceData = oResource.GetData(lcMruId)

If Not Empty(Nvl(lcResourceData,""))

	* Clean up resource data (as it is stored as a memory array)
	lcBuffer = Substrc(lcResourceData, 3, Len(lcResourceData))
	lcBuffer = Strtran(lcBuffer, Chr(0), ",")
	lcBuffer = Substrc(lcBuffer, 1, Len(lcBuffer) - 2)
	
	* Loop through each file in the list
	For lnMruBar = 1 To GetWordCount(lcBuffer,",")

		* Gather the Mru data
		lcMruData = Alltrim(GetWordNum(lcBuffer, lnMruBar, ","))
		
		* Note: Special case for classes. The Mru data will be in the format:
		*	<class library>|<class>
		lcMruFile = GetWordNum(lcMruData, 1, "|")
		
		* Format the menu prompt so class libraries read correctly
		lcMruPrompt = Iif(lpcMruFileType = "Class", GetWordNum(lcMruData, 2, "|") + [ of "] + lcMruFile + ["], lcMruFile )
		
		* Format UNC paths (thanks chj124)
		lcMruPrompt = IIF(LEFT(lcMruPrompt,2) == '\\', '\','') + lcMruPrompt

		* Check file still exists
		*If File(lcMruFile)

			If Not lbMenuDefined
				* At least one file is in the list, so define popup menu
				Define Popup (lcSubmenuName) Relative Shortcut
				
				* Set boolean so we do not define the menu again
				lbMenuDefined = .T.
			EndIf
		
			* Define bar
			Define Bar (lnMruBar) Of (lcSubmenuName) Prompt (lcMruPrompt)
			
			* Bind delegate
			On Selection Bar (lnMruBar) Of (lcSubmenuName) oFoxTabsToolbar.ModifyFile(Prompt())

		*EndIf 
						
	Next
	
EndIf



ENDPROC
PROCEDURE getmruid
* Return the Mru id for the given file type
Lparameters lpcMruFileType As String

Local lcMruId As String

* Determine the resource file Mru id of the given file type
Do Case
	Case lpcMruFileType = "Solution"
		lcMruId = "MRUX"
	
	Case lpcMruFileType = "Project"
		lcMruId = "MRUL"
	
	Case lpcMruFileType = "Program"
		lcMruId = "MRUB"
	
	Case lpcMruFileType = "Class"
		lcMruId = "MRUI"
	
	Case lpcMruFileType = "Form"
		lcMruId = "MRUH"
	
	Case lpcMruFileType = "Report"
		lcMruId = "MRUG"
	
	Case lpcMruFileType = "Table"
		lcMruId = "MRUS"
	
	Case lpcMruFileType = "Database"
		lcMruId = "MRUK"
	
	Otherwise 
		lcMruId = ""
		
EndCase

Return lcMruId
	
ENDPROC
PROCEDURE modifyfile
Lparameters lpcFileName As String

Local oException As Exception 
Local lcFileType As String, lcModifyCommand As String

Try
	* Determine file type
	lcFileType = Upper(JustExt(lpcFileName))
	
	* Handle each type
	Do Case
		Case "SLX" $ lcFileType
			* [TODO] Modify solution file
			
		Case "PJX" $ lcFileType
			* Modify project file
			lcModifyCommand = [Modify Project "] + lpcFileName + [" NoWait Save ]
			
		Case "VCX" $ lcFileType
			* Modify class in class library
			*	Note: file name may be passed as <class> of "<class library>"
			lcModifyCommand = [Modify Class ] + lpcFileName + [ NoWait Save ]
			
		Case "PRG" $ lcFileType
			* Modify program file
			lcModifyCommand = [Modify Command "] + lpcFileName + [" NoWait Save ]
			
		Case "SCX" $ lcFileType
			* Modify form file
			lcModifyCommand = [Modify Form "] + lpcFileName + [" NoWait Save ]
			
		Case "FRX" $ lcFileType
			* Modify report file
			lcModifyCommand = [Modify Report "] + lpcFileName + [" NoWait Save ]
			
		Case "DBC" $ lcFileType
			* Modify database file
			lcModifyCommand = [Modify Database "] + lpcFileName + [" NoWait ]
			
		Case "DBF" $ lcFileType
			
			* Check if we are modifying the table or browsing
			If This.Parent.Configuration("AppSettings.OnTableSelection").Value = "Modify"
				* Modify table structure
				Text To lcModifyCommand TextMerge Noshow PreText 1+2+4
					* Open the table in the default data session
					Select 0
					Use "<<lpcFileName>>" Exclusive
					Modify Structure				
				EndText
			Else
				* Browse table
				Text To lcModifyCommand TextMerge Noshow PreText 1+2+4
					* Open the table in the default data session
					Select 0
					Use "<<lpcFileName>>" Again Shared
					Browse Last Nowait Save
				EndText
			EndIf
					
		Otherwise
			* Issue a modify file command
			lcModifyCommand = [Modify File "] + lpcFileName + [" NoWait ]
			
	EndCase 
	
	* Open file in previous datasession
	Set Datasession To (oFoxTabs.PrevDataSession)
	
	* Execute the modify command
	ExecScript(lcModifyCommand)

	Set Datasession To (oFoxTabs.DataSession.DataSessionID)

Catch To oException
	* Set exception header details and throw to caller
	oException.UserValue = "Exception caught while opening the selected most recently used file: " + Transform(lpcFileName)
	Throw oException

EndTry


ENDPROC
PROCEDURE refreshtabs

* Refresh the row of FoxTabs
oFoxTabs.FoxTabsManager.RefreshWindows(Application.hWnd)

* Update each FoxTab control 
For Each oFoxTabControl In This.Controls
	If Lower(oFoxTabControl.Class) = "foxtabcontrol"
		oFoxTabControl.SetFont()
		oFoxTabControl.SetWindowName()
		oFoxTabControl.ResizeTab()
	EndIf
Next 

ENDPROC
PROCEDURE pauseresume
* Pause/Resume window event tracking

If !This.lPaused
	* Pause tracking
	This.lPaused = .t.
	oFoxTabs.FoxTabsManager.RemoveBindings()
	This.cmdPause.Caption = "4"	&& WebDings Play Button
	This.cmdPause.ToolTipText = "Resume"
Else
	* Resume tracking
	This.lPaused = .f.
	oFoxTabs.FoxTabsManager.SetBindings()
	This.RefreshTabs()
	This.cmdPause.Caption = ";"	&& WebDings Pause Button
	This.cmdPause.ToolTipText = "Pause"
EndIf 
ENDPROC
PROCEDURE Release
* Destroy instance of FoxTabs
oFoxTabs = Null

ENDPROC
PROCEDURE Init

* Dock the FoxTabs toolbar
This.SetDockPosition()


ENDPROC
PROCEDURE AfterDock

Local oFoxTabControl As Object

* Update the FoxTab image orientations
* 	Set the options button and first (left) image controls
This.cmdOptions.Caption = Iif(This.DockPosition = 3, "5", "6")
This.imgLeft.RotateFlip = Iif(This.DockPosition = 3, 0, 6)

* Update each FoxTab control 
For Each oFoxTabControl In This.Controls
	If Lower(oFoxTabControl.Class) = "foxtabcontrol"
		oFoxTabControl.SetImageOrientation()
	EndIf
Next 


ENDPROC
PROCEDURE DblClick
* Don't allow toolbar to be undocked with double-click
NoDefault 
ENDPROC
     7����    �7  �7                        �   %   �/      �5  �  2          �  U  [  ��  Q� FORM�, T�  �C� foxtabsOptions� foxtabs.vcx���� ��C��  � �� ��C� � �� U  ODIALOG SHOW THIS SETDOCKPOSITION� ��  Q� OBJECT�" �� Q�	 EXCEPTION� Q� OBJECT� �� Q� STRING� Q� STRING� ��b� %�C �  � � 
��t � !� � T� � �a�� �� � � �� �# %�C� �	 @� foxtabcontrol��� � T� �
 ���� � �� T� �C��]��/ ��C � � Foxtabcontrol� foxtabs.vcx� � �� T� �C� This.� ��� T� � ��  �� ��C� � �� ��C� � �� T� � �a�� �(� �w�	 ��� �� ���� T� � �-�� �� U  OFOXTAB
 OEXCEPTION OFOXTABCONTROL LCCONTROLNAME LCWINDOWNAME THIS OKTOADDFOXTAB
 LOCKSCREEN CONTROLS CLASS TABSTYLE	 NEWOBJECT FOXTAB SETICON SETWINDOWNAME VISIBLE� ��  Q� OBJECT� �� Q� OBJECT� �� Q� INTEGER� %�C�  ��� O��� � %�CC�� � �
��� � � � �C� � ���� ��C� � ���� � T� � �����  � �� T� � � ��d�� B� � +�CC�� � �
��g� �� � � �Q�; %�C� �	 @� foxtabcontrol� � �
 � C�� � 	��M� T� �
 ���� ��C� � � � �� !� � �� ��C� � ���� � ��C� � ��! �� �� � �(������������ T� �C � � � ��- %�C� �	 @� foxtabcontrol� � � 	���� T� � ���� !� � �� U  OFOXTAB OFOXTABCONTROL	 LNCONTROL THIS ATABSTOREMOVE HWND TMRREMOVEFOXTAB INTERVAL CONTROLS CLASS FOXTAB REMOVEOBJECT NAME SHOWLASTFOXTAB CONTROLCOUNT VISIBLE TABSTYLE ��  Q� OBJECT�" �� Q�	 EXCEPTION� Q� OBJECT� ��� � T� � �a�� �� � � �� �7 %�C� � @� foxtabcontrol� � � � �  � 	��� � %�� �	 
��� � ��C� �
 �� T� �	 �a�� � ��C� � �� !� � �� �(� �� �	 ��� �� ��� T� � �-�� �� U  OFOXTAB
 OEXCEPTION OFOXTABCONTROL THIS
 LOCKSCREEN CONTROLS CLASS FOXTAB HWND VISIBLE HIDEFIRSTFOXTAB SETFOCUS�  ��  Q� OBJECT�" �� Q�	 EXCEPTION� Q� OBJECT� ��� � T� � �a�� �� � � �� �7 %�C� � @� foxtabcontrol� � � � �  � 	��� � ��C� �	 �� !� � �� �(� �� �	 ��� �� ��� � T� � �-�� �� U
  OFOXTAB
 OEXCEPTION OFOXTABCONTROL THIS
 LOCKSCREEN CONTROLS CLASS FOXTAB HWND SETWINDOWNAME� / ��C�  � � AddFoxTabEvent� �	 AddFoxTab��5 ��C�  � � RemoveFoxTabEvent� � RemoveFoxTab��- ��C�  � � GotFocusEvent� � GotFocus��- ��C�  � � OnChangeEvent� � OnChange�� U  OFOXTABS FOXTABSMANAGER THIS�  ��  Q� STRING� �� Q� OBJECT� �� � � �s �4 %�C� � @� foxtabcontrol� � � � �  	��o � B�a�� � �� B�-�� U  LPCHWND OFOXTABCONTROL THIS CONTROLS CLASS FOXTAB HWND� ��  Q� STRING� �� Q� OBJECT� %��  � ALL��� +�� � � � � ��� � T� �C�� � � � �� T�  �C�� � � *�  ��� %�C�  f� COMMAND��� � T� �C�� � � � �� � T�  �C� � � *�  ��� %�C�  �
��� � ��C �  � �	 �� � � B� � T�  �C �  � �
 �� %�C�  �
��1� B� � t,��  ��" ��C���
 _MFI_CLOSE� _MFILE]�� %�C�  f� SCREEN���� <,��  �� � ��C� � �� B� U  LPCWINDOWNAME OFOXTAB OFOXTABS FOXTABSMANAGER FOXTABS COUNT ITEM
 WINDOWNAME THIS RELEASEWINDOW GETFOXWINDOWNAME RESIZE�  ��  Q� OBJECT� �� Q� INTEGER� %�C�  � � � ��A � B�-�� �< %�� � � � CC� AppSettings.MaxNumTabs� �	 �
 g��� � ��C� � �� � B�a�� U  OFOXTAB LNMAXFOXTABS THIS CONTROLEXISTS HWND OFOXTABS FOXTABSMANAGER FOXTABS COUNT CONFIGURATION VALUE HIDEFIRSTFOXTABM ��  Q� STRING� �� Q� OBJECT� �� Q�	 EXCEPTION� ��� � T� � �a�� �� � � �� �4 %�C� � @� foxtabcontrol� � � � �  	��� � %�� �	 
��� � ��C� �
 �� T� �	 �a�� � ��C� � �� !� � �� �(� �0�@ T� � ��* Exception caught while activating window: C�  _��	 ��� �� ��F� T� � �-�� �� U  LPCWINDOWNAME OFOXTABCONTROL
 OEXCEPTION THIS
 LOCKSCREEN CONTROLS CLASS FOXTAB
 WINDOWNAME VISIBLE HIDEFIRSTFOXTAB	 SETACTIVE	 USERVALUE�  ��  Q� OBJECT� �� Q� INTEGER�! �� �� � �(����������� � T�  �C � � � ��. %�C�  � @� foxtabcontrol� �  � 
	��� � T�  � �a�� !� � �� U  OFOXTABCONTROL	 LNCONTROL THIS CONTROLCOUNT CONTROLS CLASS VISIBLE�  ��  Q� OBJECT� �� Q� INTEGER� �� ���(�� � ��� � T�  �C � � � ��J %�C�  � @� foxtabcontrol� C�  � @� foxtabdesktop	� �  � 	��� � T�  � �-�� !� � �� U  OFOXTABCONTROL	 LNCONTROL THIS CONTROLCOUNT CONTROLS CLASS NAME VISIBLE� ��  Q� STRING� �� Q� STRING� H�/ ��� �C�  ���K � T� ��  ��0 �� tasksC�  @� C�
 _oTaskListb� O	��� � T� �� � � ��= �� intellisense managerC�  @� C� _oIntMgrb� O	��� � T� �� � ��< �� task pane managerC�  @� C�
 _oTaskPaneb� O	��'� T� �� � ��1 �� toolboxC�  @� C�	 _oToolBoxb� O	��h� T� �� � ��8 �� code referencesC�  @� C� _oFoxRefb� O	���� T� �� � ��  �C�  @� document view���� T� �� Document View�� 2��� ��	 �
 � � T�	 �C�  ��� T�
 �C�  � ��� �� ���(��	 ����" %�C�
 �
� CC�
 � fC�  f	��n� T� ��
 �� !� � T�
 �C�  ���� �� %�C� ����� T� ��  �� � �	 B�� �� U  LPCFOXWINDOWNAME LCWINDOWNAME
 _OTASKLIST TASKUI NAME _OINTMGR
 _OTASKPANE	 _OTOOLBOX _OFOXREF LNFOXWINCNT LCFOXWIN LNFOXWINDOW ��  Q� STRING�" �� Q�	 EXCEPTION� Q� OBJECT� %��  � ALL��� � �� � � � �� � T�  �C� � � *�  ��� %�C�  �
��� � ��C �  � � �� � �� B� � T�  �C �  � �	 �� %�C�  �
��� � B� � t,��  ��! ��C���	 _MFI_SAVE� _MFILE]�� B� U
  LPCWINDOWNAME
 OEXCEPTION OFOXTAB OFOXTABS FOXTABSMANAGER FOXTABS
 WINDOWNAME THIS
 SAVEWINDOW GETFOXWINDOWNAME	 ��  Q� STRING�2 T�  �C� AppSettings.DockPosition� � � � �� H�P �� ��  � Top��� � %�� � � ��� � ��C� � ��� � �� � ��  � Bottom��� � %�� � ���� � ��C�� � �� � 2�� %�� � ���� � ��C�� � �� � � U  LCDOCKPOSITION THIS PARENT CONFIGURATION VALUE DOCKPOSITION DOCK�1 ��  Q�	 EXCEPTION� Q� TOOLBAR� Q� OBJECT�l �� Q� INTEGER� Q� INTEGER� Q� INTEGER� Q� INTEGER� Q� INTEGER� Q� INTEGER�	 Q� INTEGER�? ��
 Q� INTEGER� Q� INTEGER� Q� BOOLEAN� Q� INTEGER� ��A� T� �� �� t&� T�9� �� �� T� ��9� �� T� ��9� �� T�9� ���� T� ��9� �� T� ��9� �� T�
 �� � � � � ��> T� �C� AppSettings.ShowRecentFiles� � � � � true�� T� ��
 C� � �� �6��> T� �C�
 � � � 	� �� �
 � � � � �� ��� T�	 ��� �� ��� T� �C� FoxTabs��� H�F��� �� � � ��g� T� �� �� �� � �����$ T� �C� FoxTabs��	 � � �� �� � ������� T� �� � �	 � � �� 2���! T� �C� Screen� �� � �� � s�� �� ��� ��W� �� ���(��
 ��c� T� �C � � � � � � �� s�� ��� "�� � �� �� %��
 � ���� s��
 ���� "�� \-�� �" s��
 ���� "��	 Close All��! s��
 ���� "�� Save All�� s��
 ���� "�� \-�� %�� ��O�% s��
 ���� "�� Recent files�� s��
 ���� "�� \-�� ��C� � �� �  s��
 ���� "�� Options��  s��
 ���� "�� Refresh�� s��
 �	��� "�� \-�� s��
 �
��� "�� Exit��; 1���
 ���� �$ oFoxTabsToolbar.ReleaseWindow("ALL")�8 1���
 ���� �! oFoxTabsToolbar.SaveWindow("ALL")� %�� ��c� 1��
 ���� ��� � �: 1���
 ���� �# oFoxTabsToolbar.ShowOptionsDialog()�4 1���
 ���� � oFoxTabsToolbar.RefreshTabs()�0 1���
 �
��� � oFoxTabsToolbar.Release()�4 1��� �( oFoxTabsToolbar.ActivateWindow(Prompt())� t�� � �(�  ���[ ��C� � � LogError�  �; Exception caught while activating the options context menu.�� �� U  
 OEXCEPTION OFOXTABSTOOLBAR OFOXTAB LNROW LNCOLUMN LNFOXELWIDTH LNPIXELWIDTH LNFOXELHEIGHT LNPIXELHEIGHT LNMENUHEIGHT LNFOXTABCOUNT LNFOXTAB LBSHOWRECENTFILES
 LNMENUBARS THIS	 SCALEMODE WIDTH HEIGHT PARENT FOXTABSMANAGER FOXTABS COUNT CONFIGURATION VALUE LNMENULINES DOCKPOSITION TOP FOXTABCONTEXTMENU ITEM
 WINDOWNAME DEFINEMRUMENU FOXTABMRUMENUo= ��  Q� STRING� Q� STRING� Q� INTEGER� Q� BOOLEAN�= T�  ��0 Project,Class,Program,Form,Report,Database,Table�� �� ���(�C�  � ,����h� T� �CC�  � � ,����C %�C� AppSettings.Include� � Files� � � � � true��d� %�� 
���
 s�� �W� T� �a�� � s�� ��� "�� ��" 1�� ��� ���� � MruMenu�� ��C � � �	 �� � �� U
  LCMRUFILETYPELIST LCMRUFILETYPE LNMRUBAR LBMENUDEFINED THIS PARENT CONFIGURATION VALUE FOXTABMRUMENU DEFINEMRUSUBMENU� ��  Q� STRING�  �� Q� OBJECT� Q� TOOLBAR�� �� Q� STRING� Q� STRING� Q� INTEGER� Q� STRING� Q� STRING� Q� STRING�	 Q� STRING�
 Q� STRING� Q� BOOLEAN� T� �� �� T� ��  � MruMenu��I T� �C� FoxResource�+ ..\ApplicationBlocks\Common\FoxResource.prg���� T� �C �  � � �� T� �C � � � �� %�CC� �  ҡ
���� T� �C� �C� >��� T� �C� C�  � ,��� T� �C� �C� >���� �� ���(�C� � ,������ T� �CC� � � ,���� T�	 �C� �� |����@ T�
 �C�  � Class�" C� �� |���  of "�	 � "� �	 6��+ T�
 �CC�
 �=� \\� � \� �  6�
 �� %�� 
���� s��� ��W� T� �a�� � s�� ���� �"��
 ��: 1��� ���� ��$ oFoxTabsToolbar.ModifyFile(Prompt())� �� � U  LPCMRUFILETYPE	 ORESOURCE OFOXTABSTOOLBAR LCSUBMENUNAME LCMRUID LNMRUBAR LCRESOURCEDATA LCBUFFER	 LCMRUDATA	 LCMRUFILE LCMRUPROMPT LBMENUDEFINED THIS GETMRUID GETDATA� ��  Q� STRING� �� Q� STRING� H�/ ��� ��  � Solution��Y � T� �� MRUX�� ��  � Project��� � T� �� MRUL�� ��  � Program��� � T� �� MRUB�� ��  � Class��� � T� �� MRUI�� ��  � Form��� � T� �� MRUH�� ��  � Report�� � T� �� MRUG�� ��  � Table��G� T� �� MRUS�� ��  � Database��q� T� �� MRUK�� 2��� T� ��  �� �	 B�� �� U  LPCMRUFILETYPE LCMRUID� ��  Q� STRING� �� Q�	 EXCEPTION� �� Q� STRING� Q� STRING� ��5� T� �CC�  ��f�� H�k �� �� SLX� �� � �� PJX� ��� �3 T� �� Modify Project "�  � " NoWait Save �� �� VCX� ��	�/ T� �� Modify Class �  �  NoWait Save �� �� PRG� ��P�3 T� �� Modify Command "�  � " NoWait Save �� �� SCX� ����0 T� �� Modify Form "�  � " NoWait Save �� �� FRX� ����2 T� �� Modify Report "�  � " NoWait Save �� �� DBC� ���/ T� �� Modify Database "�  �	 " NoWait �� �� DBF� ����@ %�C� AppSettings.OnTableSelection� � � � � Modify��� M(� `������7 �1 					* Open the table in the default data session� � 					Select 0�* �$ 					Use "<<lpcFileName>>" Exclusive� � 					Modify Structure				� � ��� M(� `������7 �1 					* Open the table in the default data session� � 					Select 0�- �' 					Use "<<lpcFileName>>" Again Shared�" � 					Browse Last Nowait Save� � � 2��+ T� �� Modify File "�  �	 " NoWait �� � G�(�� �	 �� ��C� ���� G�(�� �
 � �� �(� ���[ T� � ��E Exception caught while opening the selected most recently used file: C�  _��	 ��� �� �� U  LPCFILENAME
 OEXCEPTION
 LCFILETYPE LCMODIFYCOMMAND THIS PARENT CONFIGURATION VALUE OFOXTABS PREVDATASESSION DATASESSION DATASESSIONID	 USERVALUE}  ��C� � �  � � �� �� � � �v �# %�C� � @� foxtabcontrol��r � ��C� �	 �� ��C� �
 �� ��C� � �� � �� U  OFOXTABS FOXTABSMANAGER REFRESHWINDOWS APPLICATION HWND OFOXTABCONTROL THIS CONTROLS CLASS SETFONT SETWINDOWNAME	 RESIZETAB�  %��  � 
��\ � T�  � �a�� ��C� � � �� T�  � � �� 4�� T�  � � �� Resume�� �� � T�  � �-�� ��C� � � �� ��C�  �	 �� T�  � � �� ;�� T�  � � �� Pause�� � U
  THIS LPAUSED OFOXTABS FOXTABSMANAGER REMOVEBINDINGS CMDPAUSE CAPTION TOOLTIPTEXT SETBINDINGS REFRESHTABS  T�  ���� U  OFOXTABS  ��C�  � �� U  THIS SETDOCKPOSITION�  ��  Q� OBJECT�* T� � � �C� � �� � 5� � 66��( T� � � �C� � �� � � �6�� ��  � � �� �# %�C�  � @� foxtabcontrol��� � ��C�  �	 �� � �� U
  OFOXTABCONTROL THIS
 CMDOPTIONS CAPTION DOCKPOSITION IMGLEFT
 ROTATEFLIP CONTROLS CLASS SETIMAGEORIENTATION  �� U   showoptionsdialog,     ��	 addfoxtab�     �� removefoxtab�    �� gotfocus�    �� onchange<    �� setbindings�    �� controlexistsg	    �� releasewindow*
    �� oktoaddfoxtabO    �� activatewindowr    �� showlastfoxtabU    �� hidefirstfoxtabF    �� getfoxwindownameR    ��
 savewindow�    �� setdockposition    �� showcontextmenun    �� definemrumenu�    �� definemrusubmenu�!    �� getmruid1%    ��
 modifyfile�&    �� refreshtabs0,    �� pauseresume8-    �� Releaseq.    �� Init�.    ��	 AfterDock�.    �� DblClick�/    ��1 � �� 2 "�� bA A � #1A A ��� � � � � � � B 2 !Uq�!A �1A A �"�� 3C A A !A � Q�B A A 3 "� � #r� � A � C B A � � � � B 2 "� � #r� C B A � � � � B 2 �Q��3 #Cr A A r 2 C�����A �A A B B SA A � #�� A � B 2 "sr A �� A s 3 A� � #B� � A � C A A � � � � B 2 !Q�� B A A 2 !�Q�� A A A 3 � � � 1����� � 1q!� A A 1A � � A B � 3 "CQ�A A B B SA A � C 4 #� AAsA rAA � AA B 3 ��� � S � � � � � � �����c� A� AAQ�� A ds��A �A "�� S�� B ����� �A �AA� � �B 3 ����3� � � A c#B B 6 1� ��SSR�����t�� � � A ��D B 5 � ���bRrb�� � B � 3 B�� "� AC2B�B2BB"B�Bq1��A � q1�!A A � �B � � "� �� B 4 c#1� � � A A 3 � A�� � � A�A 2 � 3 � 4 ��#1� A A 4 B 1                       �         �   s         �  �  ?   ?   �  �  u   S   �  2  �   c   T  �  �   h   �  e  �   q   �  3  �   �   W  �    �   �  "!  &  �   G!  ,#  N  �   R#  �$  a  �   %  E/  t  �   f/  q2  �  �   �2  5  �    45  F    E  6F  *K  v  T  QK  @T  �  n  _T  W  �  �  5W  �`    �  �`  �a  d  �  
b  �c  s  �  �c  d  �  �  ,d  dd  �  �  �d  >f  �  �  ]f  �f  �   )   �7                       ����    �  �                        L   %         �  �   $          �  U  � ��  Q�	 EXCEPTION� �� Q� STRING�k %�CC�� CLASS DESIGNER� FORM DESIGNER�
�( C� _screen.ActiveForm.WindowTypeb� N	� �9� � �	��� � B� � ���� T� �C� � � � *�  ��� T� �C � � � � �� %�C� �
���, ��� Window, C� _� , does not exist.�� � �,�� �� t,)�� �� %�C� ���G� �,�� ��� �, ��C� isActive-� foxtabcontrol� � �	 �� T� �
 �a�� �(�  ���[ ��C� � � � LogError�  �2 Exception caught while activating the IDE window: C� _�� �� U 
 OEXCEPTION LCWINDOWNAME
 ACTIVEFORM
 WINDOWTYPE THIS FOXTAB
 WINDOWNAME PARENT GETFOXWINDOWNAME SETALL ISACTIVE�  ��  Q� INTEGER� %�� � �  ��* � B� � T� � � ��  ��� T� � � ��  ��� ��C� � �� T� � ��  �� B� U  LPNTABSTYLE THIS TABSTYLE	 IMGRIGHT1 VISIBLE	 IMGRIGHT2 SETIMAGEORIENTATION� ��  Q� STRING� Q� STRING� T�  �� � � ��  %�C� This.imgIconb� O��� � %�C� � � @C�  @��q � B� �� � ��C� imgIcon� � �� � �/ ��C� imgIcon �  � FoxTabsImages.vcx� � �� %��  �
 icoFormRun��M� T� �CC� � �
 g� � �	 �� %�C� 0��I� T� � � �� �� T� � � ���� T� � � ���� � � ��� � �Q� IMAGE��� T�� ���� T�� �� �� T�� ���� T�� �a�� �� B� U  LCICONCLASS LCICON THIS FOXTAB ASSOCIATEDICON IMGICON CLASS REMOVEOBJECT	 NEWOBJECT GETFORMICON HWND PICTURE HEIGHT WIDTH TOP LEFT ANCHOR VISIBLE�  ��  Q� BOOLEAN� %�� � �  ��* � B� � %��  ��v �; T� � � �CC� AppSettings.ActiveFontColour� � � g�� �� � ��C�	 ForeColor� � � �� � T� � ��  �� U	  LPBISACTIVE THIS ISACTIVE LBLWINDOWNAME	 FORECOLOR OFOXTABS CONFIGURATION VALUE RESETTODEFAULT0 ��  Q� INTEGER� Q� INTEGER� Q� INTEGER� ��� � �Q� LABEL�� �, T�  �C��� �� C�� � � B� � N6�$��1 T� ��  C�� �� �� C�� � � B� � N6�#��, T� �C��� �� C�� � � B� � N6�$�� ��$ T� �	 �� �
 �	 � � � �	 �� T� � �� ��� U 
 LNFONTSIZE LNLABELWIDTH LNLABELHEIGHT THIS LBLWINDOWNAME FONTNAME FONTSIZE FONTBOLD CAPTION WIDTH IMGICON	 IMGRIGHT1 HEIGHT�  ��  Q� STRING� Q� INTEGER�# %�C� � @� foxtabdesktop��G � B� �8 %�C� AppSettings.ShowFullName� � � � true��� � T�  �C� � � `�� ��� H�� ���' �� class designerC� � � @��� H�� �{� �� (� � � ���$ T�  �C� � � � (� )������ �� --� � � ��^�( T�  �C� � � � -- �  of������ 2�{� T�  �C� � � `�� �C �� designerC� � � @� � project managerC� � � @���� %�� --� � � ��R� %�� \� � � ���( T�  �C� � � C� \� � � ��\�� �N�+ T�  �C� � � C�  -- � � � �\�� � ���* T�  �C� � � C�  - � � � �\�� �= �� class browserC� � � @� C� (� � � � 	����+ T�  �C� � � �C� (� � � �\��+ �C� � � @� data environment -��@�% T�  ��	 DataEnv -C� � � �\��( �CCC� � � �Rf� AM)� PM)�����* T�  �CC� � � C� (� � � ��=`�� 2��� T�  �C� � � `�� � � T� �	 �
 �C� � � `�� %�� [Read Only]�  ���  T�  �C�  � [Read Only]�  ��� �- T� �CC� AppSettings.MaxChars� � � g�� %�C�  >� ����3 T�  �C�  � �=C� *�  �	 � ..*� � ...6�� � %�� �	 � C�  ����� B� � T� �	 � ��  �� T� �
 �� � � �� ��C� � �� ��C� � �� B� U 	 LCCAPTION
 LNMAXCHARS THIS NAME OFOXTABS CONFIGURATION VALUE FOXTAB
 WINDOWNAME LBLWINDOWNAME TOOLTIPTEXT CAPTION	 RESIZETAB SETICON$  ��  Q� OBJECT� T� � ��  �� U  OFOXTAB THIS FOXTAB�  ��  Q� INTEGER� %�C� This.Parentb� O��5 � B� �h T�  �C� � � � � ��E � � � �� � �/ � � � �� � � � � � �� � � � �� T� � � ��  �� T� � � ��  �� T� � � ��  �� U 
 LNROTATION THIS PARENT DOCKPOSITION IMGBODY
 ROTATEFLIP	 IMGRIGHT1	 IMGRIGHT2"# ��  Q�	 EXCEPTION� Q� TOOLBAR�z �� Q� INTEGER� Q� INTEGER� Q� INTEGER� Q� INTEGER� Q� INTEGER� Q� INTEGER� Q� INTEGER�	 Q� STRING� ���� T� ��
 � �� T�	 �C�
 � � � *�  ��� t&� T�9� �� �� T� ��9� �� T� ��9� �� T�9� ���� T� ��9� �� T� ��9� �� T� ��Z��0 T� �C� FoxTabs�C� FoxTabs��� � �� H�z�2� �� � � ���� T� �� �� �� � �����$ T� �C� FoxTabs�� � � �� �� � �����	�! T� ��
 � � � � � �� 2�2�! T� �C� Screen� �� � �� � s�� �� ��� ��W� s����� "�� Save�� s����� "�� Close�� s����� "�� \-�� s����� "�� Save All�� s����� "��	 Close All��: 1������ �( oFoxTabsToolbar.SaveWindow(lcWindowName)�= 1������ �+ oFoxTabsToolbar.ReleaseWindow(lcWindowName)�3 1������ �! oFoxTabsToolbar.SaveWindow("ALL")�6 1������ �$ oFoxTabsToolbar.ReleaseWindow("ALL")� t�� � �(�  ��[ ��C�
 � � � LogError�  �2 Exception caught while dislaying context menu for C�	 _�� �� U 
 OEXCEPTION OFOXTABSTOOLBAR LNROW LNCOLUMN LNFOXELWIDTH LNPIXELWIDTH LNFOXELHEIGHT LNPIXELHEIGHT LNMENUHEIGHT LCWINDOWNAME THIS PARENT FOXTAB
 WINDOWNAME	 SCALEMODE WIDTH HEIGHT DOCKPOSITION TOP FOXTABCONTEXTMENU�   ��  Q� STRING� Q� INTEGER�' T�  �C� AppSettings.Font� � � �� %�C�  �
��� � T� � � �C�  �� ,���� T� � � �CC�  �� ,��g��" T� � �	 �� BC�  �� ,����" T� � �
 �� IC�  �� ,���� � U  LCFONT LNFONTCOLOUR OFOXTABS CONFIGURATION VALUE THIS LBLWINDOWNAME FONTNAME FONTSIZE FONTBOLD
 FONTITALIC= , ��C� isActive-� foxtabcontrol�  � � �� T�  � �a�� U  THIS PARENT SETALL ISACTIVES  ��  Q� INTEGER� %�C�  �
��2 � T� � ��  �� � ��C� � �� ��C� � �� U  LPNTABSTYLE THIS TABSTYLE SETIMAGEORIENTATION SETFONT4  %�C� This.FoxTabb� O��- � T�  � ���� � U  THIS FOXTAB	 setactive,     �� tabstyle_assign�    �� seticonr    �� isactive_assign�    ��	 resizetab�    �� setwindowname~    �� foxtab_assign    �� setimageorientationE    �� showcontextmenuy    �� setfont�    �� SetFocus�    �� Init=    �� Destroy�    ��1 B�A A � ���A � � � A �� � �B 3 !CA A ��� B 2 �3�B � rA A ���� 111A A �� � � � A B 4 !CA A � �� �A 3 ���A CA4 3A A �R� � q� �B��� QA 3���� �A � �A ���Q��� RB A ��A �12A �A A 3c� � B 3 2 #�A A �3114 3�� �S � � � � � � � � A� AAQ� A c��a����1a� � �B 3 s��!!A 3 �� 3 !A � � 3 �� A 1                       �        �  �  0   !   �  �  D   ;   �  �  r   F   �  M  �   O   q  �  �   �   �    �   �   A  �      �   �   �+    �   ,  �-  \  �   .  �.  k  �   �.  �/  s  �   �/  \0  �   )   �                       0gPROCEDURE setactive

Local oException As Exception 
Local lcWindowName As String

* If modal form is active, don't switch windows
* Form in Class/Form designer could be modal, so don't check if those are active
If !InList(Wontop(), "CLASS DESIGNER", "FORM DESIGNER") and Type("_screen.ActiveForm.WindowType") = "N" ;
		and _screen.ActiveForm.WindowType = 1
	Return 
EndIf 

Try

	* We need to remove the * character appended when changes have been made to the file
	lcWindowName = Chrtran(This.FoxTab.WindowName, "*", "")

	* Gather the VFP window name from the one used by Window's
	lcWindowName = This.Parent.GetFoxWindowName(lcWindowName)

	* Check the Fox window exists
	If Not Wexist(lcWindowName)
		Error "Window, " + Transform(lcWindowName) + ", does not exist." 
	EndIf

	* Activate the assigned window
	Show Window (lcWindowName)	&& make sure visible
	Activate Window (lcWindowName) Top
	
	* Restore window if minimized
	If Wminimum(lcWindowName)
		Zoom WINDOW (lcWindowName) Normal
	EndIf 

	* Reset isActive properties for all other tab controls
	This.Parent.SetAll("isActive", .F., "foxtabcontrol")

	* Set the isActive property of this tab control
	This.isActive = .T.

Catch To oException
	* Raise error event on FoxTabs application class
	RaiseEvent(This.Parent.Parent, "LogError", oException, "Exception caught while activating the IDE window: " + Transform(lcWindowName))

EndTry

ENDPROC
PROCEDURE tabstyle_assign
Lparameters lpnTabStyle As Integer 

* Check if tab style has changed first. This is to prevent excessive screen flicker
If This.tabStyle = lpnTabStyle
	Return
EndIf

* Set visible the coresponding right hand image control
This.imgRight1.Visible = ( lpnTabStyle = 2) && Middle tab
This.imgRight2.Visible = ( lpnTabStyle # 2) && Last tab

* Set the orientation of the new image
This.setImageOrientation()

* Set class property
This.tabStyle = lpnTabStyle

Return 
ENDPROC
PROCEDURE seticon
* Set the associated icon

Local lcIconClass As String, lcIcon as String

* Gather the icon class we set when the FoxTab object was created
lcIconClass = This.FoxTab.AssociatedIcon

* Check if we are updating or creating the icon control
If Type("This.imgIcon") = "O"
	* Check if the associated icon has changed
	If Lower(This.imgIcon.Class) = Lower(lcIconClass)
		* No change so fall out
		Return
	Else
		* Remove the existing control
		This.RemoveObject("imgIcon")
	EndIf
EndIf

* Add a new instance of the associated icon control
This.NewObject("imgIcon", lcIconClass, "FoxTabsImages.vcx")
If lcIconClass = "icoFormRun"
	* Try to use icon from running form
	lcIcon = This.FoxTab.GetFormIcon(Val(This.FoxTab.hWnd))
	If File(lcIcon)
		This.imgIcon.Picture = lcIcon
		This.imgIcon.Height = 16
		This.imgIcon.Width = 16
	EndIf 
EndIf 

* Position and anchor icon control
With This.imgIcon As Image
	.Top	= 4
	.Left	= 0
	.Anchor	= 514
	
	* Finally, show the control
	.Visible = .T.
EndWith

Return


ENDPROC
PROCEDURE isactive_assign
Lparameters lpbIsActive As Boolean 

* Check if active status has changed first. This is to prevent excessive screen flicker
If This.isActive = lpbIsActive
	Return
EndIf 

If lpbIsActive 
	* Set the FoxTab got focus settings
	This.lblWindowName.ForeColor = Val(oFoxTabs.Configuration("AppSettings.ActiveFontColour").Value)
Else
	* Reset the FoxTab settings
	This.lblWindowName.ResetToDefault("ForeColor")
EndIf 

* Set the class property
This.isActive = lpbIsActive

ENDPROC
PROCEDURE resizetab
Local lnFontSize As Integer, lnLabelWidth As Integer, lnLabelHeight as Integer

With This.lblWindowName As Label
	* Calculate the pixel width required
	lnFontSize = Fontmetric(6, .FontName, .FontSize, Iif(.FontBold, "B", "N"))
	lnLabelWidth = lnFontSize * Txtwidth(.Caption, .FontName, .FontSize, Iif(.FontBold, "B", "N"))
	lnLabelHeight = Fontmetric(1, .FontName, .FontSize, Iif(.FontBold, "B", "N"))
EndWith

* Resize the tab container (the anchor property does the rest)
This.Width = This.imgIcon.Width + lnLabelWidth + This.imgRight1.Width
This.Height = lnLabelHeight + 11


ENDPROC
PROCEDURE setwindowname

Local lcCaption As String, lnMaxChars As Integer 

* Don't update Desktop caption
If Lower(This.Name) == "foxtabdesktop"
	Return 
EndIf 

* Check if we are using full titles for the FoxTab caption
If ( oFoxTabs.Configuration("AppSettings.ShowFullName").Value = "true" )
	* Use Windows name
	lcCaption = Trim(This.FoxTab.WindowName)
Else
	* Derive short name from Windows name
	Do Case
		Case "class designer" $ Lower(This.FoxTab.WindowName)
			* Extract the class name from the VFP naming convention used
			*	e.g. Class Designer - <library> (<class name>)
			Do Case
			Case "(" $ This.FoxTab.WindowName
				* Standard VFP format
				lcCaption = StrExtract(This.FoxTab.WindowName, "(", ")", 1, 1)
			Case "--" $ This.FoxTab.WindowName
				* PEM Editor changes window title
				lcCaption = StrExtract(This.FoxTab.WindowName, "-- ", " of", 1, 1)
			Otherwise 
				lcCaption = Trim(This.FoxTab.WindowName)
			EndCase 
		
		Case "designer" $ Lower(This.FoxTab.WindowName) ;
				Or "project manager" $ Lower(This.FoxTab.WindowName)
			If "--" $ This.FoxTab.WindowName
				* PEM Editor changes window title
				If "\" $ This.FoxTab.WindowName
					* Contains directory name
					lcCaption = Substr(This.FoxTab.WindowName, Rat("\", This.FoxTab.WindowName) + 1)
				Else 
					lcCaption = Substr(This.FoxTab.WindowName, At(" -- ", This.FoxTab.WindowName) + 4)
				EndIf 
			Else 
				* Extract the short name from the VFP naming convention used
				*	e.g. Menu Designer - <menu name>
				lcCaption = Substr(This.FoxTab.WindowName, At(" - ", This.FoxTab.WindowName) + 3)
			EndIf 		
		Case "class browser" $ Lower(This.FoxTab.WindowName) ;
				And At("(", This.FoxTab.WindowName) > 0
			* Extract the class library from the VFP naming convention used
			*	e.g. <class library> (<filename>) - Class Browser
			lcCaption = Substr(This.FoxTab.WindowName, 1, At("(", This.FoxTab.WindowName) - 2)
		
		Case Lower(This.FoxTab.WindowName) = "data environment -"
			lcCaption = "DataEnv -" + Substr(This.FoxTab.WindowName, 19)

		Case InList(Upper(Right(This.FoxTab.WindowName, 3)), "AM)", "PM)")
			* PEM Editor may add date/time to code editor title
			lcCaption = Trim(Left(This.FoxTab.WindowName, Rat("(", This.FoxTab.WindowName) - 1))
			
		Otherwise
			* Default to Windows name
			lcCaption = Trim(This.FoxTab.WindowName)
					
	EndCase 
EndIf

* Display full window title in tooltip
This.lblWindowName.ToolTipText = Trim(This.FoxTab.WindowName)

* Remove [Read Only]
If "[Read Only]" $ lcCaption
	lcCaption = Strtran(lcCaption, "[Read Only]", "")
EndIf 

* Check the maximum FoxTab caption size
lnMaxChars = Val(oFoxTabs.Configuration("AppSettings.MaxChars").Value)
If Len(lcCaption) > lnMaxChars 
	* Truncate short name
	lcCaption = Left(lcCaption, lnMaxChars - 3) + Iif("*" $ lcCaption, "..*", "...")	&& make sure we include the "modified" character
EndIf 

* Only set the caption when the value changes. This obviously prevents screen flicker
If This.lblWindowName.Caption == Alltrim(lcCaption)
	Return
EndIf 

* Set the label controls caption property
This.lblWindowName.Caption = lcCaption 

* Set the tool tip text to the full Windows name
This.ToolTipText = This.FoxTab.WindowName

* Resize the tab container
This.ResizeTab()

* Set the icon for this window
This.setIcon()

Return

ENDPROC
PROCEDURE foxtab_assign
Lparameters oFoxTab As Object

* Set the class property
This.FoxTab = oFoxTab
ENDPROC
PROCEDURE setimageorientation
* Orientate the controls images relate to the dock position

Local lnRotation As Integer 

* First check the dock position is known
If Type("This.Parent") # "O"
	Return
EndIf 

* Determine the amount of rotation relate to the dock position required
lnRotation = ICase( This.Parent.DockPosition = 0, 6, ;		&& top
					This.Parent.DockPosition = 1, 0, ;		&& [TODO] left
					This.Parent.DockPosition = 2, 0, ;		&& [TODO] right
					This.Parent.DockPosition = 3, 0, 0 )	&& bottom
										
* Rotate the images relate
This.imgBody.RotateFlip		= lnRotation 
This.imgRight1.RotateFlip	= lnRotation 
This.imgRight2.RotateFlip	= lnRotation 


ENDPROC
PROCEDURE showcontextmenu
* Display the FoxTab context menu

Local oException As Exception, oFoxTabsToolbar As Toolbar
Local lnRow As Integer, lnColumn As Integer, lnFoxelWidth As Integer, lnPixelWidth As Integer, lnFoxelHeight As Integer, lnPixelHeight As Integer, lnMenuHeight As Integer, lcWindowName As String

Try
	* Obtain a reference to the parent toolbar control for ease of use with the popup menu
	oFoxTabsToolbar = This.Parent

	* We need to remove the * character appended when changes have been made to the file
	lcWindowName = Chrtran(This.FoxTab.WindowName, "*", "")

	* Calculate scale factor
	Activate Screen	&& make sure using SCREEN for menu position
	_Screen.ScaleMode = 0
	lnFoxelWidth = _Screen.Width  
	lnFoxelHeight = _Screen.Height 
	_Screen.ScaleMode = 3
	lnPixelWidth = _Screen.Width  
	lnPixelHeight = _Screen.Height 

	* Menu height is calculated as follows
	*	19 pixels per bar 				+
	*	6  pixels per horizontal line 	+ 
	*	8  for the top and bottom margins
	lnMenuHeight = 	(19 * 4) + 6 + 8

	* Determine where to position the context menu. Ensure that the menu is shown
	*	above the current FoxTab. 
*JAL*		lnColumn = Max(Mcol("Screen", 0), This.Left * (lnFoxelWidth / lnPixelWidth))
*JAL*		lnColumn = Min(lnColumn, (This.Left + This.Width) * (lnFoxelWidth / lnPixelWidth))
	lnColumn = Wlcol("FoxTabs") + (Mcol("FoxTabs", 3) * (lnFoxelWidth / lnPixelWidth))

	Do Case
		Case oFoxTabsToolbar.DockPosition = 0	&& Top
			lnRow = 0
		Case oFoxTabsToolbar.DockPosition = 3	&& Bottom
			lnRow = Wlrow("FoxTabs") - (lnMenuHeight * (lnFoxelHeight / lnPixelHeight))
		Case oFoxTabsToolbar.DockPosition = -1	&& Undocked
			lnRow = (This.Parent.Top - lnMenuHeight) * (lnFoxelHeight / lnPixelHeight)
		Otherwise
			lnRow = Mrow("Screen", 0) * (lnFoxelHeight / lnPixelHeight)
	EndCase 

	* Define context menu
	Define Popup foxtabContextMenu ShortCut Relative From lnRow, lnColumn && In Screen
	Define Bar 1 Of foxtabContextMenu Prompt "Save" 
	Define Bar 2 Of foxtabContextMenu Prompt "Close" 
	Define Bar 3 Of foxtabContextMenu Prompt "\-" 
	Define Bar 4 Of foxtabContextMenu Prompt "Save All" 
	Define Bar 5 Of foxtabContextMenu Prompt "Close All" 

	* Bind delegates
	On Selection Bar 1 Of foxtabContextMenu oFoxTabsToolbar.SaveWindow(lcWindowName)
	On Selection Bar 2 Of foxtabContextMenu oFoxTabsToolbar.ReleaseWindow(lcWindowName)
	On Selection Bar 4 Of foxtabContextMenu oFoxTabsToolbar.SaveWindow("ALL")
	On Selection Bar 5 Of foxtabContextMenu oFoxTabsToolbar.ReleaseWindow("ALL")

	* Show menu
	Activate Popup foxtabContextMenu 

Catch To oException
	* Raise error event on FoxTabs application class
	RaiseEvent(This.Parent.Parent, "LogError", oException, "Exception caught while dislaying context menu for " + Transform(lcWindowName))

EndTry	

ENDPROC
PROCEDURE setfont
* Set window label font
Local lcFont As String, lnFontColour As Integer 

* Gather the default font settings
lcFont = oFoxTabs.Configuration("AppSettings.Font").Value
If Not Empty(lcFont)
	* Set the default font
	This.lblWindowName.FontName = GetWordNum(lcFont, 1, ",")
	This.lblWindowName.FontSize = Val(GetWordNum(lcFont, 2, ","))
	This.lblWindowName.FontBold = "B" $ GetWordNum(lcFont, 3, ",")
	This.lblWindowName.FontItalic = "I" $ GetWordNum(lcFont, 3, ",")	
EndIf

ENDPROC
PROCEDURE SetFocus
* Reset isActive properties for all other tab controls
This.Parent.SetAll("isActive", .F., "foxtabcontrol")

* Set the isActive property of this tab control
This.isActive = .T.

ENDPROC
PROCEDURE Init
Lparameters lpnTabStyle As Integer 

* Set the tab style if passed
If Not Empty(lpnTabStyle)
	This.TabStyle = lpnTabStyle
EndIf

* Set the orientation of the images
This.setImageOrientation()

* Set window label font
This.SetFont()

ENDPROC
PROCEDURE Destroy
* Release reference to FoxTab if one exists
If Type("This.FoxTab") = "O"
	This.FoxTab = Null
EndIf
ENDPROC
  %   �  �  �  ~   �  Ee$Vs   �� ��  �# %�C��  �
� C��  @� -m	��=� �� � � � T�� ���� +�CC��� ]�
��� �, %�C�� �� C� .appC��� ]�� ��� � T�� �C��� ]�� � T�� ��� ��� � %�C�� 0��5� T�� �� ��# ��� ���(�C� _MTOOLS���h�@ %�C� _MTOOLSC� _MTOOLS�� ��C�	 \<FoxTabs� \<�  ���d� T�� �C� _MTOOLS�� ��� !� � �� %��� � ���� T�� �C� _MTOOLS���� �. T�� �� DO LOCFILE("�� �	 ", "APP")��7 s��� ���"��	 \<FoxTabs�-������ Runs FoxTabs��0 ON SELECTION BAR m.nBar OF _mtools &cAppName
 � B� � 7� Q� FOXTABSAPPLICATION�" T� �C� FoxTabsApplication���� ��C� � �� G�(�� � �� B� U 	 LCOPTIONS NLEVEL CAPPNAME NBAR I OFOXTABS MAIN PREVDATASESSION8 ��  Q� STRING� � T� � �C� Datasessionv�� T� � �C� Session�N�� T� � � �� FoxTabs�� G�(�� � � �� G2� G� G �( T� � �CC�C���t�]� config����% T� � �CC�C���t�]� log����; ��C� Configuration� foxtabsconfig� foxtabs.vcx� �	 �� T� �
 � �� � �� ��C� � � �
 � ��= ��C� FoxTabsToolbar� foxtabstoolbar� foxtabs.vcx� �	 ��D ��C� FoxTabsManager� foxtabsmanager� foxtabsmanager.prg� �	 �� ��C� � �� ��C� � � � � �� T� � � �a�� T� �C��� %�C� �
��1� �,�� �� �,�� �� t,)�� �� � U  LCCONFIGFILE LCWONTOP THIS PREVDATASESSION DATASESSION NAME DATASESSIONID
 CONFIGFILE LOGFILE	 NEWOBJECT CONFIGURATION APPSETTINGSVERSION VERSION
 LOADCONFIG SETBINDINGS FOXTABSMANAGER LOADWINDOWS APPLICATION HWND FOXTABSTOOLBAR VISIBLE�  ��C�  � � ��2 ��C�  � � AddFoxTabEvent�  � �	 AddFoxTab��8 ��C�  � � RemoveFoxTabEvent�  � � RemoveFoxTab��0 ��C�  � � GotFocusEvent�  � � GotFocus��0 ��C�  � � OnChangeEvent�  � � OnChange�� U  THIS FOXTABSMANAGER SETBINDINGS FOXTABSTOOLBAR�" ��  Q�	 EXCEPTION� Q� STRING�  �� Q� STRING� Q� INTEGER� T� ��  �� T� ���� ���� +�a���� %�� ����� M(� `������" � 						<<Replicate("_", 80)>>� � 						�. �( 						Time:    <<Transform(Datetime())>>�6 �0 						Error:   <<Transform(oException.ErrorNo)>>�8 �2 						Program: <<Transform(oException.Procedure)>>�5 �/ 						Line no: <<Transform(oException.LineNo)>>�; �5 						Line:  	 <<Transform(oException.LineContents)>>�6 �0 						Message: <<Transform(oException.Message)>>� � 						Details:  	 �+ �% 						<<Nvl(oException.Details, "")>>� � 						User details:�t �n 						<<Iif(VarType(oException.UserValue) = "C", Transform(oException.UserValue), Transform(lpcUserDetails))>>� � 						� � �;� M(� `������C �= 						<<Replicate(Space(3), lnDepth)>><<Replicate("- ", 40)>>�V �P 						<<Replicate(Space(3), lnDepth)>>Error:   <<Transform(oException.ErrorNo)>>�X �R 						<<Replicate(Space(3), lnDepth)>>Program: <<Transform(oException.Procedure)>>�U �O 						<<Replicate(Space(3), lnDepth)>>Line no: <<Transform(oException.LineNo)>>�[ �U 						<<Replicate(Space(3), lnDepth)>>Line:  	 <<Transform(oException.LineContents)>>�V �P 						<<Replicate(Space(3), lnDepth)>>Message: <<Transform(oException.Message)>>�8 �2 						<<Replicate(Space(3), lnDepth)>>Details:  	 �K �E 						<<Replicate(Space(3), lnDepth)>><<Nvl(oException.Details, "")>>�9 �3 						<<Replicate(Space(3), lnDepth)>>User details:�} �w 						<<Replicate(Space(3), lnDepth)>><<Iif(VarType(oException.UserValue) = "C", Transform(oException.UserValue), "")>>� � 						� � � %�C�  � ��� O��x� T�  ��  � �� T� �� ��� ��� !� � � ��C� � � ����� ���� �� U 
 OEXCEPTION LPCUSERDETAILS
 LCLOGENTRY LNDEPTH	 USERVALUE THIS LOGFILE"  ��  Q� STRING� Q� STRING� U  LPCEVENT LPCUSERDETAILS Main      SetBindingsN      LogErrorb      LogEventa     k  T�  �� 1.3�� T� ��  �� T� ��  �� T� �-�� T� �-��
 ��    �
 ��    �
 ��    �
 ��    � U  VERSION
 CONFIGFILE LOGFILE PREVDATASESSION DATASESSION FoxTabsApplication Custom�    q 3� � ��aA QA � 1�A A A 1�A �sA B A �#� � C : R���!a a a �Q�aa�C� c� � � � A 4 #�5 !� � � � !� �a�Q�a���A� A � 1a�Q�a����� A A �� A A B S� B 4 �7 � � � � � `� � �� 4                 !   d    8   :   @  9  o   @   k  H  |   p   X  �  �   r   �  �  0   03   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _1MB19MJD6 859155077k  �  �  }      �                      U  b              G               COMMENT RESERVED                                                                                           WINDOWS _1MB19MJD6 859155095�    +  �      F                      �  �              �               COMMENT RESERVED                                                                                           WINDOWS _1MB19MJD6 859155109�  $  7  �      Z                      �  �              �               COMMENT RESERVED                                                                                           WINDOWS _1MB19MJD6 859155119�  <  O  �      n                      �  �              �               COMMENT RESERVED                        0                                                                   WINDOWS _1MB19MJD6 859155216*  A  M  \      s                        D              8               COMMENT RESERVED                                                                                           WINDOWS _1MB19MJD6 859155239p  �  �  b                            �  �              �               COMMENT RESERVED                        �                                                                   WINDOWS _1MB19MJD6 859155517�  	    	      )	                      �  �              �               COMMENT RESERVED                        �                                                                   WINDOWS _1MB19MJD6 859158358P
  �	  �	  =
      �	                      k
  b
              x
               COMMENT RESERVED                        �
                                                                   WINDOWS _1MB19MJD6 859158377h  �
  �
  Y                            �  z              �               COMMENT RESERVED                        �                                                                   WINDOWS _1MB19MJD6 859158383{  �  �  i                            �  �              �               COMMENT RESERVED                        �                                                                   WINDOWS _1MB19MJD6 859158393�  �    �      .                      �  �              �               COMMENT RESERVED                        �                                                                   WINDOWS _1MB19MJD6 859158532�    &  �      @                      �  �              �               COMMENT RESERVED                                                                                           WINDOWS _1MB19MJD6 859158542�  &  9  �      F                      �  �              �               COMMENT RESERVED                        �                                                                   WINDOWS _1MB19MJD6 859158554�
  �  �
  �                            �	  �
              .               COMMENT RESERVED                        �	                                                                   WINDOWS _1MB19MJD6 859158567T  �  f  �                                                           COMMENT RESERVED                        �                                                                   WINDOWS _1MB19MJD6 859158574�  �  :  *      �                      #  %              �               COMMENT RESERVED                        �                                                                   WINDOWS _1MB19MJD6 859158583  �  3        �                      �                               COMMENT RESERVED                                                                                           WINDOWS _1MB19MJD6 859158594�
  �  �  �
      m                      �	  �	              �	               COMMENT RESERVED                        �                                                                   WINDOWS _1MB19MJD6 859158601R  �  �  d      r                      <  I              �               COMMENT RESERVED                        �                                                                   WINDOWS _1MB19MJD61432328581�  4  '  �      �                      �  �              �               COMMENT RESERVED                        w                                                                   WINDOWS _1MB19MJD61432332294�  F  Y  �      u                      �  �                             COMMENT RESERVED                                                                                           WINDOWS _1MB19MJD61432442927�      �      1                      �  �              �               COMMENT RESERVED                        �                                                                   WINDOWS _1MB19MJD61432443352!  �  �  f      3                      0  =              "               COMMENT RESERVED                                                                                           WINDOWS _1MB19MJD61432715442{     �  �      �                      e  r              W               COMMENT RESERVED                        G                                                                   WINDOWS _1MB19MJD61432716482�  e  X  �      �                      �  �              �               COMMENT RESERVED                        �                                                                    x                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      
icoprogram      icotable      image      Pixels      Class      1      
foxtabicon      
icoprogram      image      foxtabs.vcx      OPicture = images\icons\program.bmp
Height = 16
Width = 16
Name = "program"
      
icoproject      foxtabs.vcx      image      Pixels      NPicture = images\icons\class.bmp
Height = 18
Width = 19
Name = "icoclass"
      icoclass      
foxtabicon      1      Class      Pixels      foxtabs.vcx      
foxtabicon      icoclass      Class      foxtabs.vcx      image      1      image      OPicture = images\icons\cursor.bmp
Height = 16
Width = 16
Name = "icoclass"
      	icocursor      
foxtabicon      1      Class      Pixels      icosolution      Pixels      	icocursor      
foxtabicon      foxtabs.vcx      image      
icoproject      PPicture = images\icons\custom.bmp
Height = 16
Width = 16
Name = "icocursor"
      	icocustom      
foxtabicon      1      Class      Pixels      Class      1      Class      	icocustom      foxtabs.vcx      
foxtabicon      image      QPicture = images\icons\project.bmp
Height = 16
Width = 17
Name = "icocustom"
      
icodesktop      foxtabs.vcx      image      Pixels      NPicture = images\icons\vfp.gif
Height = 16
Width = 16
Name = "icoproject"
      icovfp      
foxtabicon      1      Class      Pixels      icosolution      foxtabs.vcx      icovfp      Class      1      icoxsl      Pixels      image      icowebservice      Pixels      Class      1      
foxtabicon      icoxsl      JPicture = images\icons\xsl.gif
Height = 16
Width = 16
Name = "icoxml"
      image      foxtabs.vcx      icoxml      
foxtabicon      foxtabs.vcx      
icodesktop      PPicture = images\icons\desktop.png
Height = 16
Width = 16
Name = "icodummy"
      icotext      Class      Pixels      foxtabs.vcx      image      Class      1      TPicture = images\icons\database.bmp
Height = 16
Width = 16
Name = "icodesktop2"
      icodatabase      
foxtabicon      1      Class      Pixels      1      
foxtabicon      image      icodatabase      
foxtabicon      foxtabs.vcx      image      icoxml      PPicture = images\icons\form.bmp
Height = 16
Width = 16
Name = "icodatabase"
      icoform      
foxtabicon      1      Class      Pixels      icotext      Pixels      icoform      image      Class      foxtabs.vcx      image      Pixels      OPicture = images\icons\formset.bmp
Height = 16
Width = 16
Name = "icoform"
      
icoformset      
foxtabicon      1      Class      Pixels      foxtabs.vcx      foxtabs.vcx      
icoformset      foxtabs.vcx      foxtabs.vcx      image      1      1      RPicture = images\icons\library.bmp
Height = 15
Width = 16
Name = "icoformset"
      
icolibrary      
foxtabicon      1      Class      Pixels      	icoreport      Pixels      
icolibrary      
foxtabicon      foxtabs.vcx      image      image      OPicture = images\icons\menu.bmp
Height = 16
Width = 16
Name = "icolibrary"
      icomenu      
foxtabicon      1      Class      Pixels      Class      1      icotable      icomenu      icowebservice      foxtabs.vcx      image      NPicture = images\icons\report.bmp
Height = 16
Width = 16
Name = "icomenu"
      	icoreport      
foxtabicon      OPicture = images\icons\websvc.bmp
Height = 16
Width = 16
Name = "icotable"
      OPicture = images\icons\scrap.bmp
Height = 16
Width = 16
Name = "icoreport"
      QPicture = images\icons\xml.gif
Height = 16
Width = 16
Name = "icowebservice"
      QPicture = images\icons\table.bmp
Height = 16
Width = 16
Name = "icosolution"
      PPicture = images\icons\solution.gif
Height = 16
Width = 16
Name = "icotext"
      	icomethod      Pixels      Class      1      
foxtabicon      	icomethod      PPicture = images\icons\method.bmp
Height = 16
Width = 16
Name = "icomethod"
      image      foxtabs.vcx      icoquery      Pixels      Class      1      
foxtabicon      icoquery      NPicture = images\icons\query.bmp
Height = 15
Width = 17
Name = "icoquery"
      image      foxtabs.vcx      icoedit      Pixels      Class      1      foxtabs.vcx      image      icoedit      NPicture = images\icons\event.bmp
Height = 16
Width = 16
Name = "icoevent"
      icoevent      
foxtabicon      1      Class      Pixels      icoevent      
foxtabicon      LPicture = images\icons\edit.bmp
Height = 13
Width = 16
Name = "icoedit"
      image      foxtabs.vcx      icodataenvironment      Pixels      Class      1      
foxtabicon      icodataenvironment      image      foxtabs.vcx      bPicture = images\icons\dataenvironment.bmp
Height = 16
Width = 16
Name = "icodataenvironment"
      
icoformrun      Pixels      Class      1      
foxtabicon      
icoformrun      [Picture = images\icons\vfp.gif
Stretch = 1
Height = 16
Width = 16
Name = "icoformrun"
      image      foxtabs.vcxGIF89a  �  ��$�����������������������������������������������$                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             !�   ,        H���������!>`���ŋ'Rd��#G(.Ir$Ȑ�\��$E�+]RL@��̆r�I��	��s�С(X*�(҆�6EJ���N�>�5�֦^��ժ��� fӪ]˶-��  ;�PNG

   IHDR         ��a   +tEXtCreation Time Do 20 Feb 2003 23:25:45 +0100�w�%   tIME�;	t��   	pHYs    ��~�   gAMA  ���a  ^IDATxڽ�_HSqǿ�m�:��?ufk�ped�A��RAقH�BH����C�����%4z	#XF��L8ć�D�).�5u�m�nns���h4�/}�|���;����)��Si���]5<��ڰ�q;�M[��f�H H�����_�����d�����B�C><�R1�op�gg��+}[�Y�4~�b���/k�Ɨ\*����Q���,	���tm��2��=#C��������D�"��Ggh��ܒ"�K���,���&�͏���I?�5��ɉۙ�ǫ)������D�Y��ɬJ[��/��x'yo�M��C�Ɋww]���P��	4-�'Au��硨�#RB-�E�C#xm�����w].�d�"^/��������A}�)L-LC�,�'�)������8�CA$���	�qÊ�H,Ǽ�K�(G�ZK���p��e�`��E�����M�$�tObr��Y3Jd�$�▗�����|u�'�p"c�P�B\S�P\�j�0<~��B>/������Ga$��\׏id]��F��$��4�4�\``x^���p�6�l�u!�(
l �(��,[�G����ۅG�    IEND�B`�GIF89aX �  ��$�����������������������������$                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               !�  
 ,    X  � H����*\Ȱ�Ç#J�H��ŋ3j�ȱ�Ǐ C�,���ɓ(S�\ɲ�˗0cʜI��͛8s��ɳ�ϟ@�
J�(JH�*]ʴ�ӧP�J�J��իX�j�ʵ�ׯ`ÊK��ٳh�X˶�۷p�ʝK��ݻx���˷�߿�L���È+^�ր�ǐ#K�L���˘3k�̹��ϠC�M���ӨS�^ͺ���b˞M���۸s��ͻ�����N����ȓ+_μ���У�&@����سk�ν�������O�����ӫ_Ͼ�����˟O��������Ͽ��� (��h��&���6���F(�Vh�f��v�!��(�$�h�(���,���0�(�4�h�8��<���@)�Di�H&��L6��PF)�TVi�Xf��\v��`�)�d�i�h���l���p�)�t�i�x�g���矀*蠄j衈&�袌6�裐F*餔Vj饘f�馜v
�Q��*ꨤ�jꩨ��ꪬ�4ҫ]��*무�j뭸��)���+��k��&���6���F+���Vk���f����v�����+��k�覫������+���k�� ;GIF89a  �  ��$�����������������������������������������������������$                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       !�   ,       � H�`��F� ��#2����ŋ-:�ȑ#ÎB��p$��(O2L�2�ʔb�\�pfL8s*`�g��@�sg��
(Uʰ�ҥ�FmA�TX0� �aV����5�ذҒ��0�[k��u+ �ܲ�˷kþ��L�0��  ;GIF89a  �  ��$��������������������������������������������������$                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          !�   ,       { H� ��B �#2���ŋ'Fh��cG��9䂓(O���2�J0c*X!�͛	h"�ɓfM�9Rz�hQ�(U����H#�J ꀫQ#`:�k��\�(��ٳhӪ� ;BM�       v   (               �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ����������������       ������������ ���  ����� ������������������������������������������������BMn      6   (               8                  ���������������������������������������������������������   ������������������������������������   ������������������   ���������������������������������   ��    ���������������   ������������������������������   �� �� ��    ������������   ���������������������������������   �� �� ��    ���������   ������������������������������������   ��    ������������   ���������������������������������������   ���������������   ���������������������������������������������������������   ���������������������������������������   ���������������   ������������   ���������������������     �   ������������   ���������    ��   ���������������   � �  �  �   ���������   ������    �� �� ��   ���������������   � �  �  �   ������   ���    �� �� �� �� ��   ���������������   � �   ���������   ������    �� �� �� �� ��   ���������������   ������������   ���������    �� �� ��   ���������������������������������   ������������    ��   ������������������������������������   ���������������   ���������������������������������������   ���������������������������������������������������������   BM6      6   (                              ���������������������������������������������������������������������������������������      ������������������������������   ������      ������                                 ���      ������   ������������������������            ���������   ���      ���      ���                     ���   ������������������������               ������   ���      ���      ���               ���������   ������������������������            ���������   ���      ���      ���         ���   ���������   ������������������������   ������   ���������   ���      ���      ���      ������   ���������   ���������������������������������   ����������  �  �  �  �  �  �  �  �  �  �  �  �  ����������  ����  �  �  �  ����  �  �  �  ����  ����������  �  �  �  �  �  �  �  �  �  �  �  �  ���������BM6      6   (                  �  �          ���������������������������������������������������������������������������������������������������������������������            ���������������������������������   �  �  �  �     ���������������������������   �  �  �  �  �  �     ������������������������   �  �  �  �  �  �     ������������������������   �  �  �  �  �  �     ������������   ���������   �  �  �  �  �  �     ������������   � �   ������   �  �  �  �     ���������������   � �� �� �   ������      ���            ������   � �� �� �� �� �   ������     �  �  �   ������   � �� �� �   ������������     �  �  �   ������   � �   ������������������     �  �  �   ������   ������������������������               ���������������������������������������������������������������������������������������������������BM6      v   (               �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ���������   �       �   ���������   ����   ��   ���������   ��  �����   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   GIF89a  �  �c�pL�L1�U)�T �_"�Z5�S0�k5�d1�o3�m0�{,�x1�}2�r]��@ޜ����0��-��!��#��3�����������������������������������#��$��0ɓxħp��a�J��[��u������	������������������������������������������(��8��5��M��F��x��q׮�Ծ��ô�֠�ҧ�����������$                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     !�  X ,       � ��e�����h��!�"|AbDD�_|ࠁ��+T2ڠ!��V�0� !F�;z����

@h��P�81A���  3�@*C Ed� b��� 1� @��=r��!ł�؛$	�H���%	X`Xe���@ ;BM6      6   (                  �  �          ������������������������������������������������������������������������������������������������������������������                           ���������������������   ���������������������   ���                           ���������������   ���   ���������������������   ���������������   ���   ���������������������   ���������������   ���   ���������������������   ���������������   ���   ���������������������   �  �  �  �  �  �  ���   ���������������������   �  �  �  �  �  �  ����  �  �  �  �  �  �  �  �  ������   �������������  �  �  �  �  �  �  �  �  ������   ���������������������   ���������������������   ����������������������  �  �  �  �  �  �  �  �  ����������������������  �  �  �  �  �  �  �  �  ������������������������������������������������������������BM8      6   (                               ���������������������������������������������������������������������������������������������������������������������������������������������������                                       ���������   ����� ����� ����� ����� ����� ���   ���������   ��          ��                ��    ���������   ����� ����� ���   ���������   ���   ���������   ��          ��                ��    ���������   ����� ����� ����� ����� ����� ���   ���������   ��          ��                ��    ���������   ����� ����� ���   ���������   ���   ���������   ��          ��                ��    ���������   ����� ����� ����� ����� ����� ���   ���������                                       ������������������������������������������������������������������������������������������������������  BM8      6   (                               ������������������������������������������������������������������������������������������������������������                                 ���������������   �� ����� ����� ����� �����    ���������         ���      ��             ���   ���������   ��    �� ����� ���   ������   ��    ���         ���   ���      ��             ���   ���   ��    ��    �� ����� ����� ����� �����    ���   ���   ���   ���      ��             ���   ���   ��    ��    �� ����� ����� ����� �����    ���   ���   ���                                 ���   ��    �� ����� ����� ����� �����    ���������   ���                                 ���������   �� ����� ����� ����� �����    ���������������                                 ���������������������������������������������������������������  BM�       v   (                                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� �������  ��  � `  0�`p�0p�`p�0w`p�0`p�0p`p�0`p�0p`p�0w   �  �p��p������  �  ����� ��BM8      6   (                               ���������������������������������������������������������������������������������������������������������������                        ������������������������   ������������������   ������������������������   ���            ���   ������������������������   ������������������   ������������������������   ���         ������   ������������������������   ������������������   ������������������������   �  �  �  �  �  �     ������������������������   ������������������   ������������������������   ���            ���   ������������������������   ������������������   ������������                                          ������   ����������  �  �  �  �  ������������   ������                                          ���������������������������������������������������  BM6      6   (                  �  �          ������������������������������������������������������������������������������������������������������������������������������������������������������                                 ������������    ��   �� ����� ����� ����� ���   ���������������      ����� ����� ����� �����    ������������    ��   �� ����� ����� ����� ���   ���������������      ����� ����� ����� �����    ������������    ��   �� ����� ����� ����� ���   ���������������      ���                  ��    ������������    ��   ��    ������������   ���   ���������������      ���                  ��    ������������    ��   �� ����� ����� ����� ���   ���������������                                 ���������������������������������������������������������������������������������������������������������BM�       v   (               �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� �����������������     ��������������www��������www��������www��������ww� ���������������    �����������GIF89a  �       �  � �  � �  �  �� �� ���������������                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      !�   ,       � H� �*��A(�8Q��#J�8�"!V���!E�Kf�RA� 8��  � �  ���P'� -@��
t`p`�Ϧ$   �O60�Y��P�<{�ٰW 6P[��Ͳ7����0  ;BM8      6   (                               ���������������������������������������������������������������������������������������������������������������������������������������������������                                       ���������   ���������������������������������   ���������   ���      ���         ���      ���   ���������   ���������������������������������   ���������   ���      ���         ���      ���   ���������   ���������������������������������   ���������   ���      ���         ���      ���   ���������   ���������������������������������   ����������  �  �  �  �  �  �  �  �  �  �  �  �  ����������  ����  �  ����  �  �  ����  �  ����  ����������  �  �  �  �  �  �  �  �  �  �  �  �  ������������������������������������������������������������������������������������������������������  BM�       v   (               �   �  �                �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ""DO����/��O����/��O����"!�������������@����D�|Ȉ�$�r̢���z,�*���z,�JB���$��x���J*"���|¢w����ww����������GIF89a  �       �  �  �3f�3f�3�  ��3��3��3��� ����������������� �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          !�   ,       � #0H���BXȰ�	4d� � *�ȱbE  (|Р�,�� Rb@P�  %[��x@A*�l	ag����(Ɋ�����cǎN	hݺ��īV=f����°`���*2�۷! ;GIF89a  �       �  �  �3f�3f�3�  ��3��3��3���� �� ������������������                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       !�   ,       � %4H��@	B���!�$l��a�$*���G :Xx�@�A6��@@� A�H�-P��@��6U�tY ��4mBPa������ �)�+Ve�u�M��k �f]j@�� Ď�*�lW ւ��l^�)%|L�c@  ;�PNG

   IHDR           szz�   +tEXtCreation Time Do 13 Feb 2003 16:46:38 +0100M0�   tIME�
*�� �   	pHYs  
�  
�B�4�   gAMA  ���a  �IDATx��W[OG��bl���I.i�B�P"�*�DU��Ї��'��*������J��RUQ��((U"��RQ�!�!8��� 0�`���uόYXcl��f�c��������3�q�����	�?D>��� ʎ��)1��{|�衑_f�� ;�'`�ci��w�@�E�	�E�&�\�
�X {���k �a`�O?fsv Ȳ�+f^��WFF^^v l�2�w��}W�rWU�%�쟍����Y�f�u���x�q v���m�m���6��n2����ăp��qtw����Q��� P��^ܺՇ�����Á �b*rr$��������Do�S������F���Z�����,��C(�AJ�#hn~^����Z��l�P����C���4Ν+'��ɱD��x��Qx�)J��b�q�f/��DB��~t8 ��(�E~�	��8���|�C�L��Q1TW��``ۉ���۽B��	`�hl|w��1�Q�3\.7n����	T"A��9~M��ʊw_d06����ԩ7IEE��Fׯ����J�9�6FF����"DB2:������$�(�b��H�������A�G9�X,��� Ο?���r~������%�����=~����`qq��'��Āv��LR��|L�3	�V<�r�J417�S���Ъ��T�ܽ�[
�+k �)Ŵt�%K�?B�/���~�2^��xSS˴^&��fʤ�����*��0��Q�&� .\h"*��q�w�y?�l�Y���lf~0��*�_Q�x�؅���T16��Vl=7�9O�� s� ׽��JԿA�F6�8�	��D��	\�˥(>����Ԃ�L�k<������Q\l����=���������^���Nr,�@]]I3��>z}?��鵓�jj���3L@�&L�LR�<����:_��@�A��F���>�� ��Bʻ��˗?����OWS���z�g�{N�W�|�O�k׺���
�.]La Sl�@���$Ihh��Zg6�x��OTV���`�:;�i���ح�S$H��tt|�D13A�:͔��sÈO�J�� �X���Y�$�lo� ����m���`�k]�?��:Y��^H�1�����h,r��(Y��)��̆}�R����ȵ#�8=��/襁����4    IEND�B`�0   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _1ME0VHWJ2 962830837V      5  h      �4      �  �          @  M  �          2               COMMENT RESERVED                                                                                            5$                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      configurationblock      Pixels      Class      1      
collection      configurationblock     nconfigfile Full path and filename of the current application configuration file.
ixmldomelement Reference to the msxml dom object containing the current configuration file. Set by LoadFile().
appsettingsversion Version of the application settings configuration section. When CheckAppSettingsVersion is true, this value is checked against the version attribute of the AppSettings node in the configuration file.
checkappsettingsversion Set this to true to enforce version checking of the AppSettings section of the configuration file.
*setdefaultfile Creates a new default configuration file.
*loadconfig Loads the current configuration file.
*loadxml Reads an xml file into a Msxml dom parser.
*saveconfig Saves the configuration settings to the current configuration file.
*loadsection Loads the specified configuration section.
*createsettingobject Creates a new configuration setting object.
*createxmldom Creates a new instance of the Msxml dom parser.
*getdefaultsettings Returns an xml string of defaults for the given configuration setting
*isvalid Returns true if the currently loaded configuration file is valid
     ����    m  m                        �
   %   �      �  �   �          �  U  }; ��  Q� STRING� Q� STRING� Q� STRING� Q� STRING� T� �C� Logging� � �� T� �C� AppSettings� � �� T� �C�	 Providers� � �� M(�  `������ � 	<?xml version="1.0"?>� � 	<ApplicationConfig>� � 		<Logging>�1 �+ 			<<Iif(Empty(lcLogging), "", lcLogging)>>� � 		</Logging>�o �i 		<AppSettings version="<<Iif(Empty(This.AppSettingsVersion), "", Transform(This.AppSettingsVersion))>>">�9 �3 			<<Iif(Empty(lcAppSettings), "", lcAppSettings)>>� � 		</AppSettings>� � 		<Providers>�5 �/ 			<<Iif(Empty(lcProviders), "", lcProviders)>>� � 		</Providers>� � 	</ApplicationConfig>� � ��C�  � � � ���� U  LCXMLCONFIG	 LCLOGGING LCAPPSETTINGS LCPROVIDERS THIS GETDEFAULTSETTINGS
 CONFIGFILE ��  Q� STRING� �� Q� MSXML2.IXMLDOMNode� %�C�  ���[ � T�  �CC�� ]� config���� � T� � ��  ��( %�C�  0
�	 C� � 
�	 C� � 
��� � ��C� � �� ��C� � �� � +�� � � ��� � ��C�� � �� � �� � �	 �
 � �� ��C � � � �� �� B� U  LPCCONFIGFILE OSECTIONNODE THIS
 CONFIGFILE LOADXML ISVALID SETDEFAULTFILE COUNT REMOVE IXMLDOMELEMENT DOCUMENTELEMENT
 CHILDNODES LOADSECTION�  ��  Q� MSXML2.DOMDocument� T�  �C� � �� T�  � �-�� ��C� � �  � �� %�C�  � � �
��� �4 ���" Failed to load configuration file C� � _�� B�-�� � T� � ��  �� B� U	  OXMLDOM THIS CREATEXMLDOM ASYNC LOAD
 CONFIGFILE
 PARSEERROR	 ERRORCODE IXMLDOMELEMENTQQ ��  Q� MSXML2.DOMDocument� Q� MSXML2.IXMLDOMNode� Q� MSXML2.IXMLDOMNode� �� Q� OBJECT� T�  �� � �� �� � �3� T� �C� � �  � �� %�C� �
��� � T� � �� �	 �� �/� T� �CC� � ���  �
 �� T� � �� �	 �� T� �CC� � ���  � �� %�C� �
��+� ��C � � � �� � � �� ��C� � �  � �� B� U  OXMLDOC OSETTINGSNODE OSECTIONNODE OSETTING THIS IXMLDOMELEMENT SELECTSINGLENODE XPATH TEXT VALUE CREATEELEMENT APPENDCHILD SAVE
 CONFIGFILE�  ��  Q� MSXML2.IXMLDOMNode�. �� Q� MSXML2.IXMLDOMElement� Q� OBJECT�- �� Q� STRING� Q� STRING� Q� STRING� T� �C�  � `�� �� �  � �� �# T� �C � C� � `� �
 � �	 �� ��C � � � � � �� �� B� U  OSECTIONNODE OSETTINGNODE OSETTING LCSECTIONNAME LCSETTINGNAME LCSETTINGVALUE NODENAME
 CHILDNODES THIS CREATESETTINGOBJECT TEXT ADD KEY� - ��  Q� STRING� Q� STRING� Q� STRING� �� Q� EMPTY� T� �C� Empty���� ��C� � Section�  
�� ��C� � Name� 
�� ��C� � Value� 
�� ��C� � Key�  � .� 
��& ��C� � XPath� //�  � /� 
��	 B�� �� U  LPCSECTIONNAME LPCSETTINGNAME LPCSETTINGVALUE OSETTINGO  ��  Q� MSXML2.DOMDocument�& T�  �C� Msxml2.DomDocument.4.0����	 B��  �� U  OXMLDOM� ��  Q� STRING� �� � H�% ��� ��  � Logging��� � M(� ������H �B 			<ExceptionLogProvider>DefaultLogProvider</ExceptionLogProvider>�@ �: 			<EventLogProvider>DefaultLogProvider</EventLogProvider>� � ��  � AppSettings��� T� ��  �� ��  �	 Providers���� M(� ������ � 			<DefaultLogProvider>�' �! 				<Type>TextFileProvider</Type>� � 				<Filename></Filename>� � 			</DefaultLogProvider>� � 2��� T� ��  �� �	 B�� �� U 
 LPCSECTION LCDEFAULTSETTINGS ��  Q� MSXML2.IXMLDOMNode�  �� Q� BOOLEAN� Q� STRING� T� �a�� %�� � �
 C� � �
	��� �$ T�  �C� //AppSettings� � � �� %�C�  ���� � B�-�� � T� �C� version�  � �� %�CC� �  ҡ��� � B�-�� � T� �� � � �� �	 B�� �� U	  OSETTINGSNODE	 LBISVALID LCAPPSETTINGSVERSION THIS CHECKAPPSETTINGSVERSION APPSETTINGSVERSION IXMLDOMELEMENT SELECTSINGLENODE GETATTRIBUTE9  ��C�  � �� +��  � � ��2 � ��C��  � �� � U  THIS
 SAVECONFIG COUNT REMOVE setdefaultfile,     ��
 loadconfig    �� loadxml�    ��
 saveconfig�    �� loadsection�    �� createsettingobject<	    �� createxmldomc
    �� getdefaultsettings�
    �� isvalid�    �� DestroyO    ��1 ������!��a1QA�A S3 �� �A �� � B SA �A B 3 �� 1cBq A B 3 � s2� �1�A B B 3B 3 ���##3sB B 3 �U�aq�a� 3 �c� 3 r � �� �A �� �� �q��A � � B � 2 �� �C� q A �Aq A SB � 7 � SA 2                       �        �  K     '   i  	  F   2   ?	    \   E   ?  �  �   O   �  V  �   Y   y    �   ]   =  �  �   s   �  C  �   �   a  �     )   m                       �PROCEDURE setdefaultfile

Local lcXmlConfig As String, lcLogging As String, lcAppSettings As String, lcProviders As String

* Gather default settings for each section.
lcLogging		= This.getDefaultSettings("Logging")
lcAppSettings	= This.getDefaultSettings("AppSettings")
lcProviders		= This.getDefaultSettings("Providers")

* Generate default xml configuration document
Text To lcXmlConfig TextMerge NoShow PreText 2
	<?xml version="1.0"?>
	<ApplicationConfig>
		<Logging>
			<<Iif(Empty(lcLogging), "", lcLogging)>>
		</Logging>
		<AppSettings version="<<Iif(Empty(This.AppSettingsVersion), "", Transform(This.AppSettingsVersion))>>">
			<<Iif(Empty(lcAppSettings), "", lcAppSettings)>>
		</AppSettings>
		<Providers>
			<<Iif(Empty(lcProviders), "", lcProviders)>>
		</Providers>
	</ApplicationConfig>
EndText 

* Write file to disk
StrToFile(lcXmlConfig, This.ConfigFile, 0)

ENDPROC
PROCEDURE loadconfig
Lparameters lpcConfigFile As String

Local oSectionNode As Msxml2.IXMLDOMNode 
	
* Check if a config file was passed
If Empty(lpcConfigFile)
	* Derive the config file from the running application
	lpcConfigFile = ForceExt(Sys(16, 0), "config")
EndIf

* Set class property
This.ConfigFile = lpcConfigFile 

* Check if we need to create a default config file
If Not File(lpcConfigFile) ;		&& Check if the file exists
	Or Not This.LoadXml() ;			&& Check the file loads into the dom
	Or Not This.IsValid()			&& Check the file content is valid

	* Create a new default config file
	This.SetDefaultFile()

	* Load the config file into the dom
	This.LoadXml()

EndIf 

* Clear any existing settings
Do While This.Count > 0
	This.Remove(1)
EndDo

* Load each configuration section
For Each oSectionNode In This.IXMLDOMElement.documentElement.childNodes 
	This.LoadSection(oSectionNode)
Next 

Return

ENDPROC
PROCEDURE loadxml

Local oXmlDom As Msxml2.DOMDocument

* Create a new instance of the Msxml DOM parser
oXmlDom = This.CreateXmlDom()
oXmlDom.async = .F.
oXmlDom.load(This.ConfigFile)

* Check for success
If Not Empty(oXmlDom.parseError.errorCode)
	* Raise an exception
	Error "Failed to load configuration file " + Transform(This.ConfigFile)
	Return .F.
EndIf 

* Set class property for later use
This.IXMLDOMElement = oXmlDom

Return

ENDPROC
PROCEDURE saveconfig

Local oXmlDoc As Msxml2.DOMDocument, oSettingsNode As Msxml2.IXMLDOMNode, oSectionNode As Msxml2.IXMLDOMNode 
Local oSetting As Object

* Obtain a reference to the msxml dom for ease of use
oXmlDoc = This.IXMLDOMElement 

* Read configuration collection
For Each oSetting In This

	* Obtain a reference to the setting node in the config document
	oSettingsNode = oXmlDoc.selectSingleNode(oSetting.XPath)
	If Not IsNull(oSettingsNode)
		* Update the value
		oSettingsNode.text = oSetting.Value	
	Else
		* Create new settings node and set value
		oSettingsNode = oXmlDoc.createElement(JustStem(oSetting.XPath))	
		oSettingsNode.text = oSetting.Value	
		
		* Add settings node to section parent node
		oSectionNode = oXmlDoc.selectSingleNode(JustPath(oSetting.XPath))
		If Not IsNull(oSectionNode)
			oSectionNode.appendChild(oSettingsNode)
		EndIf 			

	EndIf 
				
Next 

* Save the xml configuration document to disk
oXmlDoc.Save(This.ConfigFile)

Return

ENDPROC
PROCEDURE loadsection
Lparameters oSectionNode As Msxml2.IXMLDOMNode

Local oSettingNode As Msxml2.IXMLDOMElement, oSetting As Object
Local lcSectionName As String, lcSettingName As String, lcSettingValue As String

* Determine the configuration section name
lcSectionName = Trim(oSectionNode.nodeName)

* Loop through each setting in the passed section
For Each oSettingNode In oSectionNode.childNodes 
	
	* Create an instance of our configuration setting class
	oSetting = This.CreateSettingObject(lcSectionName, Trim(oSettingNode.nodeName), oSettingNode.text)

	* Add them to the configuration collection
	This.Add(oSetting, oSetting.Key)			
	
Next 

Return	

ENDPROC
PROCEDURE createsettingobject
Lparameters lpcSectionName As String, lpcSettingName As String, lpcSettingValue As String

Local oSetting As Empty

* [TODO] Create interface class

* Create an instance of the Empty class
oSetting = NewObject("Empty")

* Add class properties
AddProperty(oSetting, "Section", lpcSectionName)
AddProperty(oSetting, "Name", lpcSettingName)
AddProperty(oSetting, "Value", lpcSettingValue)
AddProperty(oSetting, "Key", lpcSectionName + "." + lpcSettingName)
AddProperty(oSetting, "XPath", "//" + lpcSectionName + "/" + lpcSettingName)

* Return setting object to caller
Return oSetting	

ENDPROC
PROCEDURE createxmldom

Local oXmlDom As Msxml2.DOMDocument

* Create a new instance of the Msxml DOM parser
oXmlDom = NewObject("Msxml2.DomDocument.4.0")

Return oXmlDom

ENDPROC
PROCEDURE getdefaultsettings
* GetDefaultSettings
*
* Returns the default xml settings string for the given confgiuration section
*
* Configuration Sections
*		Logging		- Exception and event logging settings
*		AppSettings	- User application settings
*		Providers	- Common provider settings
*
* When overriding this method, be sure to handle each section case.
* Use Return DoDefault(lpcSection) when no inherited case exists.
*
Lparameters lpcSection As String

Local lcDefaultSettings 

Do Case
	Case lpcSection = "Logging"
		* Define the default logging settings
		Text To lcDefaultSettings NoShow PreText 1+2+4
			<ExceptionLogProvider>DefaultLogProvider</ExceptionLogProvider>
			<EventLogProvider>DefaultLogProvider</EventLogProvider>
		EndText 
	
	Case lpcSection = "AppSettings"
		lcDefaultSettings = ""
	
	Case lpcSection = "Providers"
		* [TODO] Define the default provider settings
		Text To lcDefaultSettings NoShow PreText 1+2+4
			<DefaultLogProvider>
				<Type>TextFileProvider</Type>
				<Filename></Filename>
			</DefaultLogProvider>
		EndText 
	
	Otherwise
		lcDefaultSettings = ""
		
EndCase

* Return default xml settings string
Return lcDefaultSettings 
ENDPROC
PROCEDURE isvalid
* Check the loaded configuration file is valid
* [TODO] Implement optional schema validation

Local oSettingsNode As Msxml2.IXMLDOMNode
Local lbIsValid As Boolean, lcAppSettingsVersion As String
lbIsValid = .T.

* Check the AppSettings version if required
If This.CheckAppSettingsVersion And Not Empty(This.AppSettingsVersion)
	
	* Gather AppSettings version from config file
	oSettingsNode = This.IXMLDOMElement.selectSingleNode("//AppSettings")
	If IsNull(oSettingsNode)
		Return .F.
	EndIf 
	
	* Obtain a reference to the version attribute
	lcAppSettingsVersion = oSettingsNode.getAttribute("version")
	If Empty(Nvl(lcAppSettingsVersion, ""))
		Return .F.
	EndIf
	
	* Check this against the class property
	lbIsValid = ( This.AppSettingsVersion == lcAppSettingsVersion )
	
EndIf

Return lbIsValid


	


ENDPROC
PROCEDURE Destroy
* Save the configuration
This.SaveConfig()

* Remove setting objects from the collection
Do While This.Count > 0
	This.Remove(1)
EndDo 

ENDPROC
      �configfile = .F.
ixmldomelement = .NULL.
appsettingsversion = .F.
checkappsettingsversion = .F.
Name = "configurationblock"
      
collection  %   �  �       �  �fYE|  �  U  3  T�  � �C�
 Collection�N�� T�  � �C��]�� U  THIS OCOLLECTION RESOURCEFILE  ��C�  � �� U  THIS CLOSERESOURCE  ��C����  � � �� U  THIS OCOLLECTION REMOVE]  ��  � � %�C ��  � � ��9 � ��CC��  f� � � �� � B�C �� C��  f� � � �� U  COPTION XVALUE THIS OPTIONEXISTS OCOLLECTION REMOVE ADD�  ��  � �� � �� � T�� ���� T��  �C��  f�� ��� ���(�� � � ��� �" %�CC �� � � � f��  ��� � T�� �C �� � � � �� !� � �� B��� �� U  COPTION XVALUE I THIS OCOLLECTION COUNT GETKEY ITEM�  ��  � �� � �� � T�� �-�� T��  �C��  f�� ��� ���(�� � � ��� �" %�CC �� � � � f��  ��� � T�� �a�� !� � �� B��� �� U  COPTION I LEXISTS THIS OCOLLECTION COUNT GETKEY�  %�C� RESOURCEv� ON
��& � B�-�� � %�C� FoxResource�
��� � %�C�  � 0��� � ��w � Q�  ���  � ��� � �� � �� � � B�C� FoxResource��� U  THIS RESOURCEFILE FOXRESOURCE)  %�C� FoxResource���" � Q�  � � U  FOXRESOURCEV ��  � � �� � �� � �� � �� ���� %�C�� ��� C��S � T�� ��  �� � %�C� � ��O� T�� �CW�� T�� �C� � C�	 �
 >��� T��  �C��  C�	 � >��� F�	 �* -��
 �� �
 � ��  	�
 � �� 	�� %�C4
��'�	 �	 �3 >�	 �
 ���� �� ���� �� ����  �� ��-�� � %��	 � 
��2� %�� � � � ���� � �� � � ����� ��� ���(�� � � ����( T� ��� �����C �� � � � ��( T� ��� �����C �� � � � �� �� D(� � aOptions� �	� ��	 � � �% >�	 � ��C$�� ��CC���	 � ]g�� � ��C� � �� F��� �� � U  CID CNAME NSELECT CTYPE I AOPTIONS THIS OPENRESOURCE RESOURCETYPE FOXRESOURCE TYPE ID NAME READONLY IN OCOLLECTION COUNT GETKEY ITEM DATA UPDATED CKVAL CLOSERESOURCE� ��  � � �� � �� � �� � �� � �� ���� %�C�� ��� C��Z � T�� ��  �� � %�C� � ���� T�� �CW�� T�� �C� �	 C�
 � >��� T��  �C��  C�
 � >��� F�
 �* -�� �� �
 � ��  	�
 � �� 	��) %�C4� C� �
	� � CC��� ]g	����
 @� � %�CC��� ��� C���� T�� �C�� ���� ��� ���(��� ����' ��CC �� �� C �� �� � � �� �� � � ��C� � �� F��� �� � U  CID CNAME NSELECT CTYPE I NCNT AOPTIONS THIS OPENRESOURCE RESOURCETYPE FOXRESOURCE TYPE ID NAME DATA CKVAL SET CLOSERESOURCE5 ��  � � �� � �� � �� � %�C�� ��� C��F � T�� ��  �� � T�� ���� %�C� � ��#� T�� �CW�� T�� �C� � C� �	 >��� T��  �C��  C� �
 >��� F� �* -��	 �� �
 �
 ��  	�
 � �� 	�� %�C4� C� �
	��� T�� �� � �� � ��C� � �� F��� �� � B��� �� U  CID CNAME CDATA NSELECT CTYPE THIS OPENRESOURCE RESOURCETYPE FOXRESOURCE TYPE ID NAME DATA CLOSERESOURCE� ��  � � � � �� � �� � �� � %�C�� ��� C��N � T�� ��  �� � T�� �-�� %�C� � ���� T�� �CW�� T�� �C� �	 C�
 � >��� T��  �C��  C�
 � >��� F�
 �* -�� �� �
 � ��  	�
 � �� 	�� %�C4
��/�	 �
 �3 >�
 � ���� �� ���� �� ����  �� ��-�� � %��
 � 
���� >�
 � ���� �� %�C� ��� N���� T� �CC���
 � ]g�� � >�
 � ��C$�� ��� �� T�� �a�� � ��C� � �� F��� �� � B��� �� U  CID CNAME CSETDATA NCKVAL NSELECT CTYPE LSUCCESS THIS OPENRESOURCE RESOURCETYPE FOXRESOURCE TYPE ID NAME READONLY IN DATA UPDATED CKVAL CLOSERESOURCEP ��  � � �� � �� � �� � �� � �� ���� %�C� � ��I� T�� �CW�� T��	 �C� �
 C� � >��� T��  �C��  C� � >��� F� �& -�� ��	 �
 � ��  	� C� �	�� %�C4
���	 � �I >� � ����	 �� ���  �� ����  �� ��-�� ��C� C�  C�  �� � %�� � 
��,�% T�� �C�� C� � �\-C�  ���� T�� ��� C�  �� ��� ���(��� ����  %�C�� fCC �� � f
����" T�� ��� C �� � C�  �� � �� T�� ��� C�  ��< >� � ��C� C�  �� �� ��CC���� ]g�� ��C$�� T�� �a�� � ��C� � �� F��� �� � U  CMRUNAME CMRUITEM CMRUDATA NSELECT I NCNT AMRULIST THIS OPENRESOURCE CTYPE RESOURCETYPE FOXRESOURCE TYPE ID NAME READONLY DATA IN CMRULIST CKVAL UPDATED LSUCCESS CLOSERESOURCE� ��  � � �� � �� � �� � �� ���� %�C�� ��� C��R � T�� �C�� � %�C�� ����� T�� �CW�� F��� �� %�� � � � ��N� � �� � � ����� ��� ���(�� � � �� �( T� ��� �����C �� � � �	 ��( T� ��� �����C �� � � �
 �� ��* SAVE TO MEMO &cField ALL LIKE aOptions
 �}�' BLANK FIELDS &cField IN FoxResource
 � F��� �� T�� �a�� ��� T�� �-�� � B��� �� U  CFIELD CALIAS I NSELECT LSUCCESS AOPTIONS THIS OCOLLECTION COUNT GETKEY ITEMb ��  � � �� � �� � �� � �� ���� %�C�� ��� C��R � T�� �C�� � %�C�� ���;� T�� �CW�� F��� ��& RESTORE FROM MEMO &cField ADDITIVE
 %�CC��� ��� C��� T�� �C�� ���� ��� ���(��� ���' ��CC �� �� C �� �� � � �� �� � F��� �� T�� �a�� �P� T�� �-�� � B��� �� U	  CFIELD CALIAS I NSELECT LSUCCESS AOPTIONS NCNT THIS SET Init,       Destroy�       Clear�       Set�       Get�      OptionExistso      OpenResourceG      CloseResource      SaveJ      Loada      GetData�	      SetData[      AddToMRU�      SaveTo      RestoreFrom     �  ��  � T�  ���� T� �� PREFW�� T� ��  ��
 ��    �
 ��    �
 ��    �
 ��    �
 ��    �
 ��    �
 ��    �
 ��    �
 �� 	   �
 �� 
   �
 ��    �
 ��    �
 ��    �
 ��    �
 ��    � U  OCOLLECTION RESOURCETYPE RESOURCEFILE FoxResource Custom�    > �13 � 4 A3 � rqA �3 q q q � 1�!�A A A � 3 q q q � 1�!� A A A � 3 �q A �!� �� A A A b3 �� A 3 � q q q � r� A � ��r �� � 6A q����A a� � A UA � � A 3 � q q q q � r� A � ��r ��� �Q�qA A A � � A 3 � q q q r� A � � ��r �a!A � � A � 3 1q q q r� A � � ��r �� � 6A 1R�A �� A � � A � 4 � q q q q � � ��r a� � �A Qr�!A A q�� A � � A 4 � q q q � r� A � � r����A �� qA � � � � A � 4 � q q q � r� A � � b�Q�qA A � � � � A � 3 q � "� � � � � � � � � �  � �  � 0� �� @� 0� � �1                    �   B        g  }        �  �        �  �        �  �  %        +  5   (   T  `  F   5   �  �  W   9   �    \   \   �  �  �   x   �    �   �   *  /  �   �   ]  ?    �   n  )  :  �   9  m  \    z   w     �PNG

   IHDR           szz�   +tEXtCreation Time Do 21 Nov 2002 11:45:45 +0100���   tIME�
��su   	pHYs  
�  
�B�4�   gAMA  ���a  cIDATxڵWylT������]�.��z}��&8N �L
9U�Z�P�*�Ґ��?��B�Z�HmS%QR����D���;$�� ��p�����^{��;������	.��'}�y�f����'����0G�׉��i{����`�V%�@%
]4����t���}G�jh���S�t�҆׈g���3��
���u��[�tU=zTl:q����'��aւB�m�1���n���	���X��{��T'b��.HŇ�����&&��T�����RIxf��zf{����#4�$�VS�'���;P�G5���W�ڮ�^�K°9s�w�Q��.�z��A�������
rַ�����sU9��]`�"�*�XYџ'�q�[F�X|4ca���� M��,� �ͭ$���\=EIB�����PM^]X�+�M 㣪�Kk\u*T9�6�d"���kj�ȨO��e!�D�&��
�����a&MU���s7މ|^��we�Sh�"A]k���N~9y��9I�v�N�ٝ�9lp�l�vl���3�u"Ӊ@�#��P,Z��y����O;\99>o~9|k*��#X��o?Ϛ8�rij��P1O�K�I����2hQ�]LBJvÙ��`j��vU\���o��<�2�XM�0�	�j�&9tu9�ї�>�0��x4$b-$@��
4K�c���>���c��P,K�,�2b�y+��г\#YS�7>n|����$�O��ό/E �&X5Й��������<��|2�7t&]"3N�m��Y_`�.ڭ��Ac�97	_h����بK9����'g>����ݍ'm|�%.�yRV<a�D��)��u�4F��mD<Y����18$A��"��� �<�E�N�J���`zQ��u��$	�2?�d
"�tHJ0:��j!^��m'�<�Nر���	`:�A�e��8b��x�� 6m��ē�-�dZ�0q���а0���j�;�N�T1&9��&����t��ex��.�{K0���]���0����=�yl'F�x����"XoF5<}�t�[��|ץ3�a��8j�B��7��o������v��B
iئ�	<�'@)�Fh�.d�i\����-�0����+sOMQ�S9?�b_�av>��q'���!Sz��o;73�JV�J��� dh���(�����7�[��k�_Ln�,>!%4i�RF��䭚L�FIp3p!�B\�2����(b�4���g�_��>��A��5����!>=�ʔ�툄��V�qҭ��7ފ���{���#a�|�ݡ��� 14���σ���@n��n^�,~��A\���[��I�|g��Pi������/��xb)��H�<�����|���f�1X�]=ՈyE1���Cѕ��}���c�?��_�#�cϳ/a�+���8m�,$3�F�5�.�23��`a�N�`�u�#.:#���e9����|��6G��w��D�ص�9��@"���0.�
L��4@_v'���w������V. �̙�g5�<e��4�(���(쑦���[����ނ	&���i*uvݽ}<ֵ��U��{Z۟,�+55`��&ИJ(Ou��8��P\@�����'�ٚ��k�D��eb���DtS�A���ʗ]y+�ղg>�4�X��R�H�qOy6���m��
	�ڣ�N�"�0�9��K2i"M'��n
��"}�Ƣ����.V^�X��ڍ������GJ*�n{ڬ-���S�iW019!�kn���w��$�4����[0�����q�e�����W?�X�M4]�~.�͒���`�@�9{n�fI_5O����� ��͗ڵ��m�l�/K	ā/nߝM>U���\d�5!���7ʴ0��Q�сN4�ܨoiia���0̸����ԛ��'E/�JKJ��OlkjW���dUU��� oN�3�w����U�/��\ ��OѡR����4��T�Wϵ������	����ĵ������8'e7�b�kV���IIAA��G���V���0�>�O����wvv.p���7s�%��?�l��iy�`dI�"����a�g?�o���J��Kpu����)V���w��:��9�~�ŋ��r�� ��{��|�    IEND�B`�    %           �     �  �<U�  � ��  � � � � � �� �/ %�� BINDWINEVENTAPICC�	 Procedurevf
��f � G+(� BindWinEventAPI� �. %�C�9� oEventHandler��h
� C�9� ���� �P ��C� oEventHandler� VFPxWin32EventHandler� VFPxWin32EventHandler.prg�9� �� � H�� �� �C�t���-�# T� �C �   �  �  � �9� �	 �� �C�t���e�' T� �C �   �  �  �  � �9� �	 �� 2�� T� �� ��� ��-���1 BindWinEvent requires 4 or 5 parameters. Syntax: C� C� �C BindWinEvent(thWnd, tnMessage, toEventHandler, tcDelegate, tnFlags)�� �	 B�� �� U
  THWND	 TNMESSAGE TOEVENTHANDLER
 TCDELEGATE TNFLAGS LNRETURN BINDWINEVENTAPI OEVENTHANDLER	 NEWOBJECT	 BINDEVENTsq ��A �A � 1q� � 	A � 1                     %           ^     D  q;U�  ��  ��  � � � �. %�C�9� oEventHandler��h
� C�9� ���E � B� � H�V �� � �C�t���z � ��C �  �9� � �� �C�t���� � ��C �   � �9� � �� 2�� � ��C �   �  �  � �9� � �� � U  THWND	 TNMESSAGE TOEVENTHANDLER
 TCDELEGATE OEVENTHANDLER UNBINDEVENTS3�A A � 1q� �A 1                   %    
  f  �  n   �  �NU"  �  U  � ��  � � � � �D �� Q� WINEVENT�� VFPxWin32EventHandler.prg� �	 �
 � � � �� ������� T� �C�  _� ~C� _�� %�C � � � � ��<�4 T� �C� WinEvent� VFPxWin32EventHandler.prg���� T� � ��  �� T� � �� �� T� � �� � �� ��C �  � � � �� ��C�  � � �
 EventFired�� �Y� T� �C � � � �� � %�C�t�����# T� �C� �
 EventFired� � �� ���& T� �C� �
 EventFired� � � �� � ��C� � ��	 B�� �� U  THWND	 TNMESSAGE TOEVENTHANDLER
 TCDELEGATE TNFLAGS LOBIND VFPXWIN32EVENTHANDLER PRG LNNUM LNNDX LBEVENTNOTBINDED LCKEY LNRETURN LAEVENTS THIS GETKEY HWND NMESSAGE PREVWNDFUNC ADD ITEM CLEANUPEVENTS�  %��  � ��= �- T�  � �C� GKKWin32EventHandler.log� ��� �/ %�� BINDWINEVENTAPICC�	 Procedurevf
��� � G+(� BindWinEventAPI� � T�  � �C�C� ���� �� U  THIS BDEBUG HDLDEBUG BINDWINEVENTAPI PREVWNDFUNC GETWINDOWLONG HWND6  %��  � ��/ � ��C�  � ��� T�  � ������ � U  THIS BDEBUG HDLDEBUG� ��  � � � �8 �� � Q� WINEVENT�� VFPxWin32EventHandler.prg� � H�X �w� �C�t���u � ��C�  �� �C�t���� � ��C�  � �� �C�t����� %�C� �
��!� T� �C�  _� ~C� _�� %�C � �	 �
 � ��� T� �C � �	 � �� ��C� �
 EventFired� � �� � ��� �� ���(��	 � ���� T� �C � �	 � �� %�� � �  ���� ��C� �
 EventFired� � �� � �� � 2�w�� ��-���5 UnBindEvents requires 1, 2, or 4 parameters. Syntax: C� C� � UnBindEvents(oEventObject)C� � UnBindEvents(thWnd, tnMessage)C� �: UnBindEvents(thWnd, tnMessage, toEventHandler, tcDelegate)�� � ��C�	 � �� U  THWND	 TNMESSAGE TOEVENTHANDLER
 TCDELEGATE LCKEY
 LOWINEVENT VFPXWIN32EVENTHANDLER PRG LNITEM THIS GETKEY ITEM COUNT HWND CLEANUPEVENTS�# ��  ������� �������@ �� � Q� WINEVENT�� VFPxWin32EventHandler.prg� � � � T� �C�� �	�� T� ���� +�� �	 �
 ���� T� �-�� T� �C � �	 � �� �� ���(�� ���2 %�C � �� � � � C � �� � � 	��� T� �a�� !� � �� %�� 
��=� ��C � �	 � �� .� �! %�C��  C � �	 � 	� ��w� ��C � �	 � �� .� � T� �� ��� � U  LAOBJEVENTS LAWINEVENTS LNITEM
 LOWINEVENT VFPXWIN32EVENTHANDLER PRG LNROW LLEVENTFOUND LNEVENTS THIS COUNT ITEM HWND NMESSAGE REMOVEJ  ��  � � � � �� �$ T� �C� �  �   �  �  � � ��	 B�� �� U  THWND	 TNMESSAGE TWPARAM TNPARAM LNRETURN CALLWINDOWPROC THIS PREVWNDFUNC	 BindEvent,       Init�      Destroy�      UnBindEvents2      CleanupEventsV     
 EventFired�	    [  T�  �-�� T� ������ T� �� ��
 ��    �
 ��    �
 ��    �
 ��    �
 ��    � U  BDEBUG HDLDEBUG PREVWNDFUNC4  T�  �� �� T� �� �� T� �� ��
 ��    � U  HWND NMESSAGE PREVWNDFUNC VFPxWin32EventHandler
 Collection�
     WinEvent Custom    @1 qA1��A1Q�� QA 1� aA � � 5 �A ��A �5 � A 5 1�� � � ��Q�A � �QA�A A A � �A � 5 1S� Q� Qs"� A A A � A A A A B = 1q C� 3 � � � � �� � � �� p1 � � � � 9                    8  
  %      *
  [  D         �  S   %   /  �  \   @     �  �   X   o  �  �   ]   �  �      i   	  �  �      %   N           �  �fYEV  �  U  c  ��  � � � � �+ |�� CallWindowProc� Win32API������ B�C �   �  �  �  � � �� U  LPPREVWNDFUNC HWND NMSG WPARAM LPARAM CALLWINDOWPROC WIN32APID  ��  � �$ |�� GetWindowLong� Win32API��� B�C �   � � �� U  HWND NINDEX GETWINDOWLONG WIN32APIW  ��  � � � �' |�� FindWindowEx� Win32API����� B�C �   �  �  � � �� U 
 HWNDPARENT HWNDCHILDAFTER	 LPSZCLASS
 LPSZWINDOW FINDWINDOWEX WIN32APIE  ��  � �% |�� GetWindowInfo� Win32API��� B�C �  � � �� U  HWND PWINDOWINFO GETWINDOWINFO WIN32APIO  ��  � � �' |�� GetWindowText� Win32API���� B�C �  �  � � �� U  HWND SZTEXT NLEN GETWINDOWTEXT WIN32APIB  ��  � �" |�� GetAncestor� Win32API��� B�C �   � � �� U  HWND GAFLAGS GETANCESTOR WIN32API CallWindowProc,     �� GetWindowLong�     �� FindWindowExG    �� GetWindowInfo�    �� GetWindowTextb    �� GetAncestor�    ��6 q��4 � A!4 1q�4 � Q!4 � qa4 � !!1                    �  �        �  M     	   s  t        �  2        Y  �  "         �  )      %   G      �  	   v  �=U�  �  U  c  ��  � � � � �+ |�� CallWindowProc� Win32API������ B�C �   �  �  �  � � �� U  LPPREVWNDFUNC HWND NMSG WPARAM LPARAM CALLWINDOWPROC WIN32APID  ��  � �$ |�� GetWindowLong� Win32API��� B�C �   � � �� U  HWND NINDEX GETWINDOWLONG WIN32API CallWindowProc,     �� GetWindowLong�     ��6 q��4 � A!1                    �  �        �  M     BM�       v   (               �                     �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ��������������� ��     ��������������D��    ��������      � �������� �����D������� � ����������� � �����������     ���BM�       v   (                   �
  �
              ��� ��  � �  �    � �    �� ��� ���   �  �   �� �   � � ��                  x    y�   � x  p
�     BM6      6   (                  �  �          ������������������������������������������������������������������������������������������������������������      ������������������������������������������    ��   ������������������������������������������    ��   ���������������������������������������    �� ��   ���������������������������������������    �� ��   ������������������������������������       �� ��   ������������������������������    �� �� ��      ���������������������������������    �� ��   ������������������������������������    �� �� ��   ������������������������������������    �� �� ��   ���������������������������������               ������������������������������������������������������������������������������������������������������������������������������������������������������������BM�       v   (               �                         �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� �������������������������������������  ����������
�� ���� ���
��"���   ����������  ����������������������������������BM*      v   (               �                       �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ���������   �     ���   ���������   ���������   ���������   ���     �   ���������   ���������   ���������   �DDDDD���   �DDDDD���   ���������   ���������   ���DDDDD�   ���DDDDD�   foxtabsmanager.prg c:\users\joel\appdata\local\temp\ foxtabsmanager.fxp foxtabs\ foxtabs.h foxtabs.vcx foxtabs.vct foxtabsapplication.prg foxtabsapplication.fxp foxtabsimages.vcx foxtabsimages.vct foxtabs\images\tabstyles\ tabimage.left.gif foxtabs\images\icons\ desktop.png tabimage.body.gif tabimage.right.1.gif tabimage.right.2.gif program.bmp class.bmp cursor.bmp custom.bmp project.bmp vfp.gif database.bmp form.bmp formset.bmp library.bmp menu.bmp report.bmp scrap.bmp solution.gif table.bmp websvc.bmp xml.gif xsl.gif foxtabs\images\ window_gear.png applicationblocks\configuration\ configurationblock.vcx configurationblock.vct ..\applicationblocks\common\foxresource.prg foxresource.fxp foxtabs\images\ folder_time.png bindwinevent.prg bindwinevent.fxp unbindwinevents.prg unbindwinevents.fxp vfpxwin32eventhandler.prg vfpxwin32eventhandler.fxp foxtabsdeclareapi.prg foxtabsdeclareapi.fxp bindwineventapi.prg bindwineventapi.fxp dataenvironment.bmp edit.bmp event.bmp method.bmp query.bmp  )   �L     5           �L  }  H   Q           }  Ĝ  H   [           Ĝ  �F H   g            �F �W    �           �W �q H   �           �q �� H   �           �� �� �   �           �� �� �             �� � �             � ܗ �   %          ܗ z� �   :          z� p� �   O          p� ޠ �   [          ޠ � �   e          � J� �   p          J� �� �   {          �� K� �   �          K� �� �   �          �� �� �   �          �� � �   �          � ߶ �   �          ߶ � �   �          � M� �   �          M� C� �   �          C� �� �   �          �� ,� �   �          ,� "� �   �          "� �� �   �          �� �� �             �� ��             �� � -  N          � * -  e           * R'    �          R' ]0 �  �           ]0 N3    �           N3 �4               �4 �A    <           �A GF    l           GF �G    �          �G �H �   �          �H �I �   �          �I 	M �   �          	M �M �   �          �M )O �   �          