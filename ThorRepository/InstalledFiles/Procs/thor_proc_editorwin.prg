Return   Execscript (_Screen.cThorDispatcher, [Result=], Newobject([EditorWin]))

#Define ccTab  Chr(9)
#Define ccCR   Chr(13)
#Define ccLF   Chr(10)
#Define ccSpace Chr(32)

Define Class EditorWin As Custom

	nHandle			   = 0
	cCaption		   = []
	cText			   = []
	cTitle			   = []
	nCurrentLineNumber = 0
	nCurrentLineStart  = 0
	nFileSize		   = 0
	nLastLine		   = 0
	nSelStart		   = 0
	nSelEnd			   = 0
	nWindowType		   = 0
	nSessionType	   = 0

	*  Values for nSessionType (WindowType)
	*    0 � Command Window
	*    1 � Program file (MODIFY COMMAND)
	*    2 � Text Editor (MODIFY FILE)
	*    8 � Menu code edit window
	*   10 � Method code edit window of the Class or Form Designer
	*   12 � Stored procedure in a DBC (MODIFY PROCEDURE)
	*   -1 - Failed

	*================================================================================
	*================================================================================
	Procedure CloseWindow
		Lparameters lnHandle
		If Vartype(m.lnHandle) # [N]
			lnHandle = This.nHandle
		Endif
		_WClose (m.lnHandle)
	Endproc


	*================================================================================
	*================================================================================
	Procedure Copy
		_EdCopy (This.nHandle)

	Endproc


	*================================================================================
	*================================================================================
	Procedure Cut
		_EdCut (This.nHandle)

	Endproc


	*!* ******** JRN Removed 2022-11-14 ********
	*!* *================================================================================
	*!* *================================================================================
	*!* Procedure Destroy
	*!*   This.Release()
	*!* Endproc


	*================================================================================
	*================================================================================
	Procedure EnsureVisible
		* Ensures the given offset is visible
		Lparameters lnPosition, lScroll

		_EdStoPos(This.nHandle, m.lnPosition, m.lScroll)


	Endproc


	*================================================================================
	*================================================================================
	Procedure FindLastWindow
		Local lnI, loWindows
		loWindows = This.GetOpenWindows()

		For lnI = 1 To m.loWindows.Count
			If m.loWindows (m.lnI).NWHandleType > 0 Or (m.loWindows (m.lnI).NWHandleType = 0 And m.loWindows (m.lnI).WindowName == [Command])
				This.nHandle	  = m.loWindows (m.lnI).nWHAndle
				This.nSessionType = m.loWindows (m.lnI).NWHandleType
				Return This.nSessionType
			Endif
		Endfor

		Return - 1

	Endproc


	*================================================================================
	*================================================================================
	Procedure FindWindow
		*  Result:
		*    0 � Command Window
		*    1 � Program file (MODIFY COMMAND)
		*    2 � Text Editor (MODIFY FILE)
		*    8 � Menu code edit window
		*     10 � Method code edit window of the Class or Form Designer
		*     12 � Stored procedure in a DBC (MODIFY PROCEDURE)
		*     -1 - Failed

		Local lnResult

		This.nHandle = This.GetWindowHandle()
		lnResult	 = This.GetEnvironment(25)

		If [N] # Vartype(m.lnResult)
			This.nHandle = 0
			Return - 1
		Else
			This.nSessionType = m.lnResult
			Return m.lnResult
		Endif

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetByteOffset
		* Returns the byte offset of the beginning of a line, given the line number
		Lparameters lnSelStart

		Return _EdGetLPos(This.nHandle, m.lnSelStart)

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetCharacter
		Lparameters lnSelStart
		If Vartype(m.lnPosition) # [N] && Current selected start is default
			lnPosition = This.nSelStart
		Endif
		Return _EdGetChar (This.nHandle, m.lnSelStart)

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetEnvironment
		Lparameters lnIndex

		Local laEnv[25], llResult, lnResult

		Try
			llResult = _EDGetenv (This.nHandle, @m.laEnv)
		Catch
			llResult = -1
		Endtry

		Do Case
			Case m.llResult = 0
				Return .F.
			Case m.llResult < 0
				Return m.llResult
			Case Pcount() = 0
				Return .T.
			Otherwise
				Return m.laEnv[m.lnIndex]
		Endcase

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetFileSize
		Return This.GetEnvironment(2)

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetHeight
		Return _WHeightP (This.nHandle)

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetLeft
		Return _WLeftP(This.nHandle)

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetLineNumber
		* Returns the line number given the byte offset
		Lparameters lnSelStart
		If Vartype(m.lnSelStart ) # [N] && Current selected start is default
			lnSelStart = This.nSelStart
		Endif

		Return _EdGetLNum(This.nHandle, m.lnSelStart)

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetLineStart
		Lparameters lnSelStart, lnLineOffset

		Local lnCurrentLine
		If Vartype(m.lnSelStart) # [N] && Current line is default
			lnSelStart = This.nSelStart
		Endif
		If Empty(m.lnLineOffset)
			lnLineOffset = 0
		Endif
		lnCurrentLine = _EdGetLNum (This.nHandle, m.lnSelStart)
		Return _EdGetLPos (This.nHandle, m.lnCurrentLine + m.lnLineOffset)
	Endproc


	*================================================================================
	*================================================================================
	Procedure GetOpenWindows
		Local loFoxTabs As [foxtabsmanager]
		loFoxTabs = Newobject([foxtabsmanager])
		Return m.loFoxTabs.GetWindows()
	Endproc


	*================================================================================
	*================================================================================
	Procedure GetSelEnd
		Return Max(This.GetEnvironment(17), This.GetEnvironment(18))

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetSelStart
		Return Min(This.GetEnvironment(17), This.GetEnvironment(18))

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetString
		Lparameters lnSelStart, lnSelEnd
		If Pcount() = 0
			lnSelStart = This.nSelStart
			lnSelEnd   = This.nSelEnd - 1
		Endif


		Return _EdGetStr (This.nHandle, m.lnSelStart, Min (m.lnSelEnd, This.GetFileSize()))

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetTitle
		Return _Wtitle (This.nHandle)

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetTop
		Return _WTopP (This.nHandle)

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetWidth
		Return _WWidthP (This.nHandle)

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetWindowHandle
		Set Library To (Home() + [FoxTools.fll]) Additive

		Return _WOnTop ()

	Endproc


	*================================================================================
	*================================================================================
	Procedure Init
		This.FindWindow()

	Endproc


	*================================================================================
	*================================================================================
	Procedure MoveWindow
		Lparameters lnLeft, lnTop

		_WMoveP (This.nHandle, m.lnLeft, m.lnTop)

	Endproc


	*================================================================================
	*================================================================================
	Procedure Paste
		Lparameters lcClipText

		Local lcOld
		If Pcount() = 0
			_EdPaste (This.nHandle)
		Else
			lcOld	  = _Cliptext
			_Cliptext = m.lcClipText
			_EdPaste (This.nHandle)
			_Cliptext = m.lcOld
		Endif

	Endproc


	*================================================================================
	*================================================================================
	Procedure ReSizeWindow
		Lparameters lnWidth, lnHeight

		_WSizeP (This.nHandle, m.lnWidth, m.lnHeight)

	Endproc


	*================================================================================
	*================================================================================
	Procedure Select
		Lparameters lnSelStart, lnSelEnd
		_EdSelect (This.nHandle, m.lnSelStart, Iif([N] = Vartype(m.lnSelEnd), m.lnSelEnd, m.lnSelStart))

	Endproc


	*================================================================================
	*================================================================================
	Procedure SelectWindow
		Lparameters lnHandle

		Local llSuccess
		Try
			_WSelect (m.lnHandle)
			llSuccess = .T.
		Catch
			llSuccess = .F.
		Endtry

	Endproc


	*================================================================================
	*================================================================================
	Procedure SetHandle
		Lparameters lnHandle
		This.nHandle = m.lnHandle
	Endproc


	*================================================================================
	*================================================================================
	Procedure SetInsertionPoint
		* Moves the insertion point to a given offset (and makes it visible)
		Lparameters lnPosition

		_EdSetPos (This.nHandle, m.lnPosition)
		_EdStoPos (This.nHandle, m.lnPosition, .T.)

	Endproc


	*================================================================================
	*================================================================================
	Procedure SetTitle
		Lparameters lcNewName
		_WSetTitle (This.nHandle, m.lcNewName)

	Endproc


	*================================================================================
	*================================================================================
	Procedure ShowPosition
		Lparameters tlScroll

		_EdSToSel (This.nHandle, m.tlScroll)
	Endproc


	*================================================================================
	*================================================================================
	Procedure SkipLine
		Lparameters lnSelStart, lnLines

		Return _EdSkipLin (This.nHandle, m.lnSelStart, m.lnLines)

	Endproc


	*================================================================================
	*================================================================================
	Procedure WinShow
		_WSelect(This.nHandle)

	Endproc


	*================================================================================
	*================================================================================
	Procedure FromInt
		Parameter tcString
		Private nValue, nT
		nValue = 0
		For nT = 1 To Len (m.tcString)
			nValue = m.nValue + Asc (Substr (m.tcString, m.nT, 1)) * 256^ (m.nT - 1)
		Endfor
		Return m.nValue

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetCaretCoordinates
		*========================================================================================
		*
		* Original code from ISX.Com (Christof)
		*
		* Version: 2010-02Feb-20
		*
		*========================================================================================
		*

		*-----------------------------------------------------------------
		* Make sure, FoxTools.Fll is loaded.
		*-----------------------------------------------------------------
		Local loResult As [Empty]
		Local lnEditSource, lnLeft, lnTop, lnWHandle

		If Not [FOXTOOLS.FLL] $ Upper (Set ([Library]))
			Set Library To (Home() + [FoxTools.Fll]) Additive
		Endif

		*-----------------------------------------------------------------
		* Get the current window and verify that it is a valid window.
		*-----------------------------------------------------------------
		lnWHandle = This.GetCurrentWindow()
		If m.lnWHandle == 0
			Return
		Endif

		*-----------------------------------------------------------------
		* Verify that the current window is indeed an edit window.
		*-----------------------------------------------------------------
		lnEditSource = This.GetEditSource (m.lnWHandle)
		If Not Inlist ( m.lnEditSource, 1, 8, 10, 12 )
			Return
		Endif

		*------------------------------------------------------------------
		* If called from within Thor which used InKey, use center of window
		*------------------------------------------------------------------

		If [L]	   = Type ([_Screen.lThorInkey]) And _Screen.lThorInkey
			lnTop  = _WTopP(m.lnWHandle) + Floor(_WHeightP(m.lnWHandle) / 2)
			lnLeft = _WLeftP(m.lnWHandle) + Floor(_WWidthP(m.lnWHandle) / 5)

			loResult = Createobject ([Empty])
			AddProperty (m.loResult, [Top],    m.lnTop)
			AddProperty (m.loResult, [Left],   m.lnLeft)
			AddProperty (m.loResult, [Source], [Center])
			Return m.loResult
		Endif

		*-----------------------------------------------------------------
		* Get the current caret position
		*-----------------------------------------------------------------
		If Not This.GetCaretPosition (m.lnWHandle, @m.lnTop, @m.lnLeft )
			Return .F.
		Endif

		loResult = Createobject ([Empty])
		AddProperty (m.loResult, [Top],    m.lnTop)
		AddProperty (m.loResult, [Left],   m.lnLeft)
		AddProperty (m.loResult, [Source], [Caret])
		Return m.loResult

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetCaretPosition
		*====================================================================
		* Returns the position of the text cursor (caret) in _SCREEN coordi-
		* nates. If the window identified by the passed window handle doesn't
		* have the focus, or the position can't be determined, this function
		* returns .F.
		*====================================================================

		Lparameter tnWHandle, rnTop, rnLeft

		*-----------------------------------------------------------------
		* Check whether this window has got the focus.
		*-----------------------------------------------------------------
		Declare Integer GetFocus In Win32API
		If GetFocus() # _WhToHWND ( m.tnWHandle )
			Return .F.
		Endif

		*-----------------------------------------------------------------
		* Determine the cursor position. This position is relative to the
		** OK
		* client area of the editing subwindow of the actual editing win-
		* dow.
		*-----------------------------------------------------------------
		Local lnLeft, lnTop, lcPOINT
		Declare Integer GetCaretPos In Win32API String@
		lcPOINT = Space(8)
		If GetCaretPos ( @m.lcPOINT ) == 0
			lnLeft = Mcol(3)
			lnTop  = Mrow(3)
		Else
			lnLeft = Asc (Left (m.lcPOINT, 1)) + 256 * Asc (Substr (m.lcPOINT, 2, 1))
			lnTop  = Asc (Substr (m.lcPOINT, 5, 1)) + 256 * Asc (Substr (m.lcPOINT, 6, 1))
		Endif

		*-----------------------------------------------------------------
		* To convert this postion to _SCREEN coordinates, we have to
		* determine the position of the client window relative to the
		* desktop window and correlate this with the absolute position of
		* the _SCREEN window. Hence, we need first the HWNDs of both
		* windows.
		*-----------------------------------------------------------------
		Local lnChild, lnScreen
		Declare Integer GetParent In Win32API Integer
		lnChild = This.GetClientWindow ( m.tnWHandle )
		If m.lnChild == 0
			Return .F.
		Endif
		lnScreen = GetParent ( _WhToHWND (m.tnWHandle) )
		If m.lnScreen == 0
			Return .F.
		Endif

		*-----------------------------------------------------------------
		* Now we can determine the position of both windows.
		*-----------------------------------------------------------------
		Local lnChildTop, lnChildLeft, lnScreenTop, lnScreenLeft, lcRect
		lcRect = Replicate ( Chr(0), 16 )
		Declare Integer GetWindowRect In Win32API Long, String@
		GetWindowRect ( m.lnChild, @m.lcRect )
		lnChildLeft	= This.FromInt ( Left (m.lcRect, 4) )
		lnChildTop	= This.FromInt ( Substr (m.lcRect, 5, 4) )
		GetWindowRect ( m.lnScreen, @m.lcRect )
		lnScreenLeft = This.FromInt ( Left (m.lcRect, 4) )
		lnScreenTop	 = This.FromInt ( Substr (m.lcRect, 5, 4) )

		*-----------------------------------------------------------------
		* Now combine the position of the edit window and the cursor
		* position.
		*-----------------------------------------------------------------
		rnLeft = m.lnLeft + m.lnChildLeft - m.lnScreenLeft
		rnTop  = m.lnTop + m.lnChildTop - m.lnScreenTop

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetClientWindow
		*====================================================================
		* The editor only works on the editor window and you can only get the
		* HWND of this window using the Window Handle. For many Windows ope-
		* rations, however, you need the HWND of the child window that con-
		* tains the actual editor area. This function returns the HWND of
		* this window. It's not that easy, because Method snippet windows
		* actually have two child windows, one for the text editor and one
		* with the method and object dropdown combos.
		*====================================================================

		Lparameter tnWHandle

		*-----------------------------------------------------------------
		* Convert the Window Handle into a HWND
		*-----------------------------------------------------------------
		Local lnHWND
		lnHWND = _WhToHWND ( m.tnWHandle )

		*-----------------------------------------------------------------
		* FindWindowEx returns all child windows of a given parent window.
		* We use it to find a child of the edit window that doesn't have
		* another child window, because method edit windows have a second
		* which we can identify since it has another child window.
		*-----------------------------------------------------------------
		Local lnChild
		Declare Integer FindWindowEx In Win32API		;
			Integer, Integer, String, String
		lnChild = 0
		Do While .T.
			lnChild = FindWindowEx ( m.lnHWND, m.lnChild, Null, Null )
			If m.lnChild == 0
				Exit
			Endif
			If FindWindowEx ( m.lnChild, 0, Null, Null ) == 0
				Exit
			Endif
		Enddo

		Return m.lnChild

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetCurrentWindow
		*====================================================================
		* Returns the WHandle of the current edit window or 0, if no edit
		* window is available.
		*====================================================================

		Local lnWindowOnTop
		lnWindowOnTop = _WOnTop()
		If m.lnWindowOnTop <= 0
			Return 0
		Endif
		If This.GetEditSource ( m.lnWindowOnTop ) == -1
			lnWindowOnTop = 0
		Endif

		Return m.lnWindowOnTop

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetEditSource
		*====================================================================
		* Determines the source of the window identified by the passed
		* WHandle. It returns the following values:
		*
		* -1     The window is not an edit window
		*  0     Command Window
		*  1     MODIFY COMMAND window
		*  2     MODIFY FILE window
		*  8     Menu Designer code window
		* 10     Method Edit Window in Class or Form Designer
		* 12     MODIFY PROCEDURE window
		*
		* This procedure uses _EdGetEnv() from the FoxTools.Fll to determine
		* the edit source. Passing an invalid handle causes an exception in
		* VFP 5 and VFP 3. In VFP 6 this raises an error 2028 (API function
		* caused an exception). Therefore we return -1 in this case, too.
		*====================================================================
		Lparameter tnWHandle

		Local laEnv[25], lcError, lnOK, lnSource
		lcError = On ( [Error] )
		On Error m.lnOK = 0
		lnOK = _EDGetenv ( m.tnWHandle, @m.laEnv )
		On Error &lcError
		If m.lnOK == 0
			lnSource = -1
		Else
			lnSource = m.laEnv[25]
		Endif

		Return m.lnSource

	Endproc


	*================================================================================
	*================================================================================
	Procedure GetPopupCoordinates
		* gets co-ordinates for a pop-up, either at the cursor position or mouse position

		Lparameters tlFoxels, tlAlignToMouse
		Local loResult

		If m.tlAlignToMouse
			loResult = This.GetMouseCoordinates()
		Else
			loResult = This.GetCaretCoordinates()
			If Type([loResult]) # [O]
				loResult = This.GetMouseCoordinates()
			Endif
		Endif

		If m.tlFoxels
			loResult.Left = This.Pix2Fox(m.loResult.Left, .F., _Screen.FontName, _Screen.FontSize)
			loResult.Top  = This.Pix2Fox(m.loResult.Top, .T., _Screen.FontName, _Screen.FontSize)
		Endif

		Return m.loResult

	Endproc

	*============================*
	* Start added TB 2023-03-10  *
	*============================*

	Procedure Append
		Lparameters tcText
		Local lnLen
		lnSelStart = This.GetSelStart()
		lnSelEnd   = This.GetSelEnd()
		lnLen	   = Len(m.tcText)
		This.SetInsertionPoint(This.nFileSize)
		llSuccess = _EdInsert(This.nHandle, m.tcText, m.lnLen)
		This.Select(m.lnSelStart, m.lnSelEnd)
		This.SetInsertionPoint(m.lnSelStart)
	Endproc
	Function cText_access
		Return This.GetString()
	Endfunc

	*************************************************************************************************

	Function cTitle_access
		Return This.GetTitle()
	Endfunc

	*************************************************************************************************

	Function Delete
		Return _EdDelete(This.nHandle)
	Endfunc

	*************************************************************************************************

	Function HighlightLines
		Lparameters tnStartLine, tnEndLine, tlNoHighlight
		Local lcReturn, lnEndPos, lcReturn
		If Vartype(m.tnStartLine ) = [L] Or m.tnStartLine < 0 && Current line
			tnStartLine  = This.GetLineNumber(This.GetLineStart(This.GetSelStart(), 0))
		Endif
		If Vartype(m.tnEndLine) = [L]
			tnEndLine = m.tnStartLine
		Endif
		If m.tnStartLine > This.nLastLine && + 1 && Illegal value
			Return []
		Endi
		lnStartPos = This.GetByteOffset(m.tnStartLine)
		lnEndPos   = This.GetByteOffset(m.tnEndLine + 1)
		If m.lnEndPos = This.nFileSize
			lnEndPos = m.lnEndPos
		Else
			lnEndPos = m.lnEndPos - 1
		Endif
		If Empty(m.tlNoHighlight)
			This.Select(m.lnStartPos, m.lnEndPos + 1)
			This.EnsureVisible(m.lnEndPos,.T.)
		Endif
		lcReturn = This.GetString(m.lnStartPos, m.lnEndPos)
		Return m.lcReturn
	Endfunc

	*************************************************************************************************

	Function HighlightStatement
		Lparameters tnLine, tlNoHighlight
		Local llCheckAfter, lnAdd, lnLine, lnSelEnd, lnSelStart, lnX
		If Vartype(m.tnLine) = [L]
			tnLine = -1
		Endif
		If m.tnLine < 0
			lnSelStart = This.GetLineStart(This.nSelStart, 0)
			lnSelEnd   = This.GetLineStart(This.nSelStart, 1) - 1
			lnLine	   = This.GetLineNumber(m.lnSelStart)
		Else
			lnSelStart = This.GetLineStart(0, m.tnLine)
			lnSelEnd   = This.GetLineStart(0, m.tnLine + 1) - 1
			lnLine	   = m.tnLine
		Endif
		If m.lnLine > This.nLastLine
			Return []
		Endif
		lnAdd		 = 1
		llCheckAfter = This.IsContinuationLine(This.ReadLine(m.lnLine))
		lnX			 = m.lnLine - 1
		Do While This.IsContinuationLine(This.ReadLine(m.lnX)) And m.lnX >= 0
			lnSelStart = This.GetLineStart(0, m.lnX)
			lnX		   = m.lnX - 1
			lnAdd	   = 0
		Enddo
		If m.llCheckAfter
			lnAdd = 0
			lnX	  = m.lnLine + 1
			Do While This.IsContinuationLine(This.ReadLine(m.lnX)) And m.lnX <= This.nLastLine
				lnX = m.lnX + 1
			Enddo
			lnSelEnd = This.GetLineStart(0, m.lnX + 1) && - 1
		Endif
		If Empty(m.tlNoHighlight)
			This.Select(m.lnSelStart, m.lnSelEnd + m.lnAdd )
		Endif
		lnAdd	 = Iif(m.llCheckAfter, 1, 0)
		lcReturn = This.GetString(m.lnSelStart, m.lnSelEnd - m.lnAdd )
		Return m.lcReturn
	Endfunc

	*************************************************************************************************
	Function Insert
		Lparameters tcText
		Local lnLen
		lnLen = Len(m.tcText)
		Return _EdInsert(This.nHandle, m.tcText, m.lnLen)
	Endfunc

	*************************************************************************************************

	Function IsContinuationLine
		Lparameters tcLine
		Local lcComments, lcTrimmed
		lcComments = [&] + [&]
		If m.lcComments $ m.tcLine
			tcLine = Left(m.tcLine, At(m.lcComments, m.tcLine) - 1)
		Endif
		lcTrimmed  = Trim(m.tcLine, 1, ccCR, ccLF, ccTab, [ ])
		Return [;] = Right(m.lcTrimmed, 1) And Not Empty(m.lcTrimmed)
	Endproc

	*************************************************************************************************

	Function nCurrentLineNumber_access
		Return This.GetLineNumber()
	Endfunc

	*************************************************************************************************

	Function nCurrentLineStart_access
		Return This.GetLineStart()
	Endfunc

	*************************************************************************************************

	Function nFileSize_access
		Return This.GetFileSize()
	Endfunc

	*************************************************************************************************

	Function nLastLine_access
		Return This.GetLineNumber(This.nFileSize)
	Endfunc

	*************************************************************************************************

	Function nSelEnd_access
		Return This.GetSelEnd()
	Endfunc

	*************************************************************************************************

	Function nSelStart_access
		Return This.GetSelStart()
	Endfunc

	*************************************************************************************************

	Function ReadHighlight
		Local lcReturn

		If This.nSelStart = This.nSelEnd
			lcReturn = []
		Else
			lcReturn = This.GetString(This.nSelStart, This.nSelEnd - 1)
		Endif
		Return m.lcReturn
	Endfunc

	*************************************************************************************************  

	Function ReadLine
		Lparameters tnLine
		If Vartype(m.tnLine) = [L]
			tnLine = -1 && Default is current line
		Endif
		Return This.HighlightLines(m.tnLine, ,.T.)
	Endfunc

	*************************************************************************************************

	Function ReadStatement
		Lparameters tnLine
		If Vartype(m.tnLine) = [L] && Current line
			tnLine = -1
		Endif
		Return This.HighlightStatement(m.tnLine, .T.)
	Endfunc

	*************************************************************************************************

	Function TrimAll(tcText)
		Return Alltrim(m.tcText, 0, ccCR, ccLF, ccTab, ccSpace )
	Endfunc

	*************************************************************************************************

	Function TrimEnd(tcText)
		Return Trim(m.tcText, 0, ccCR, ccLF )
	Endfunc

	*============================*
	* End added TB 2023-03-10    *
	*============================*


Enddefine && EditorWin


* ================================================================================
* ================================================================================
*** JRN 2010-07-24 : Borrowed from FoxTabs (VFPx)
*** to be able to obtain list of all open wHandles


* _________________________________________________________________
*
* FoxTabs Manager Class
*
* [TODO] Describe class
* _________________________________________________________________

*  #Include "PEME_FoxTabs.h"
#Define GA_PARENT         0x0001
#Define WS_BORDER           0x00800000

* _________________________________________________________________
*
* FoxTab Manager class
*
Define Class FoxTabsManager As Custom

	* _____________________________________________________________
	*
	* Define class properties

	Add Object FoxTabs As Collection
	*!!!*    Add Object WindowsEvents As FoxTabsEventHandler

	* _____________________________________________________________
	*
	* Define class members

	Function Init()

		* Declare Win32 API functions
		Declare Integer FindWindowEx In Win32API Integer hWndParent, Integer hwndChildAfter, String lpszClass, String lpszWindow
		Declare Integer GetWindowInfo In Win32API Integer HWnd, String @ pwindowinfo
		Declare Integer GetWindowText In Win32API Integer HWnd, String @szText, Integer nLen
		Declare Integer GetAncestor In Win32API Integer HWnd, Integer gaFlags

	Endfunc

	Function SetBindings()

		*!!!*  * Bind to all WM_CREATE messages
		*!!!*  BindEvent(0, WM_CREATE, This.WindowsEvents, "WMEventHandler")

		*!!!*  * Setup event bindings to our Windows message event handler
		*!!!*  BindEvent(This.WindowsEvents, "WindowShowEvent", This, "WindowShow")
		*!!!*  BindEvent(This.WindowsEvents, "WindowSetTextEvent", This, "WindowSetText")
		*!!!*  BindEvent(This.WindowsEvents, "WindowSetFocusEvent", This, "WindowSetFocus")
		*!!!*  BindEvent(This.WindowsEvents, "WindowDestroyEvent", This, "WindowDestroy")

	Endfunc

	Function LoadWindows (HWnd As Integer)

		Local oException As Exception
		Local lnChildHWnd As Integer

		Try
			* Check if the window is a VFP IDE window
			If This.IsIDEWindow (m.HWnd)
				* Add a new FoxTab object to our collection
				This.NewFoxTab (m.HWnd)
			Endif

			* Check all child windows
			lnChildHWnd = 0
			Do While .T.

				* Look for a child window of the current hWnd
				lnChildHWnd = FindWindowEx (m.HWnd, m.lnChildHWnd, 0, 0)
				If Empty (m.lnChildHWnd)
					* No child exists
					Exit
				Endif

				* Call this method recursively until all child windows have been processed
				This.LoadWindows (m.lnChildHWnd)

			Enddo

		Catch To m.oException
			*!!!*    * Raise error event
			*!!!*    Raiseevent (This.Parent, 'LogError', oException, 'Exception caught while loading existing IDE windows.')

		Endtry

	Endfunc

	Function GetWindows
		This.LoadWindows(Application.HWnd)
		Return This.FoxTabs
	Endfunc

	Function NewFoxTab (HWnd As Integer)

		Local oException As Exception
		Local oFoxTab As FoxTab
		Local Array laEnv [25]
		Local lnResult
		Try
			* Check if a FoxTab already exists for this handle
			lnWHandle = Sys(2326, m.HWnd)
			If Not Empty (This.FoxTabs.GetKey (Transform (m.lnWHandle, [@0x])))
				Exit
			Endif

			* Create a new instance of our FoxTab class
			oFoxTab = Newobject ([FoxTab])

			* Set windows handle and window name properties
			oFoxTab.HWnd	   = m.HWnd
			oFoxTab.WindowName = This.GetWindowTitle (m.HWnd)
			*** JRN 2010-07-24 :
			oFoxTab.nHWnd	 = m.HWnd
			oFoxTab.nWHAndle = m.lnWHandle
			If 0 # _EDGetenv (m.lnWHandle, @m.laEnv )
				oFoxTab.NWHandleType  = m.laEnv[25] && Edit session Env[25]
			Endif

			* Add the class to our collection
			This.FoxTabs.Add (m.oFoxTab, Transform (m.lnWHandle, [@0x]))

			* Raise the add FoxTab event
			*!!!*  Raiseevent (This, 'AddFoxTabEvent', oFoxTab)

			* Setup event bindings for this window
			*!!!*      This.WindowsEvents.SetBindings (HWnd)

		Catch To m.oException When m.oException.ErrorNo = 2071    && user thrown
			* Throw to caller
			Throw m.oException

		Catch To m.oException
			* Set exception header details and throw to caller
			oException.UserValue = [Unhandled exception caught while adding a new FoxTab object to the collection.]
			Throw m.oException

		Endtry

	Endfunc

	Function GetWindowTitle (HWnd As Integer) As String

		Local lcBUffer As String

		* Get the title using the WIN32API function
		lcBUffer = Space(200)

		GetWindowText (m.HWnd, @m.lcBUffer, Len (m.lcBUffer))

		* Strip out nulls and trim
		lcBUffer = Alltrim (Chrtran (m.lcBUffer, Chr(0), []))

		Return m.lcBUffer

	Endfunc

	Function IsIDEWindow (HWnd As Integer) As Boolean

		Local oException As Exception
		Local lbReturn As Boolean, lcWindowTitle As String, lnParentHWnd As Integer

		Local laToolBars[1]
		laToolBars = []
		= Adockstate (laToolBars, 2)

		Try
			* Gather the windows title
			lcWindowTitle = Nvl (This.GetWindowTitle (m.HWnd), [])

			* Check the window title exclusion conditions
			*JAL*        lbReturn = Application.hWnd # hWnd										;          && Ignore the main FoxPro window
			*JAL*              And This.Parent.FoxTabsToolbar.hWnd # hWnd						;  && Ignore foxtabs toolbar
			*JAL*              And Not Empty(lcWindowTitle)										;        && Ignore windows with no titles
			*JAL*              And Not InList(Lower(lcWindowTitle), "compile", "command", "properties", "document view", "data session", "debugger", "watch", "locals", "trace", "call stack", "debug output", "parentclass browser") ;
			*JAL*              And Not InList(Lower(lcWindowTitle), "expression builder", "expression builder options") ;
			*JAL*              And Ascan(laToolbars,lcWindowTitle,-1,-1,1,7) = 0

			*!!!*  And This.Parent.FoxTabsToolbar.HWnd # HWnd		;  && Ignore foxtabs toolbar

			*JAL* Now allow tracking of IDE windows except debugger
			lbReturn = Application.HWnd # m.HWnd												;  && Ignore the main FoxPro window
				And Not Empty (m.lcWindowTitle)													;  && Ignore windows with no titles
				And Not Inlist (Lower (m.lcWindowTitle), [compile], [debugger], [watch], [locals], [trace], [call stack], [debug output], [parentclass browser]) ;
				And Not Inlist (Lower (m.lcWindowTitle), [expression builder], [expression builder options]) ;
				And Ascan (m.laToolBars, m.lcWindowTitle, -1, -1, 1, 7) = 0
			*Wait window nowait Transform(lcWindowTitle)

			* Gather the hWnd of this windows parent
			lnParentHWnd = GetAncestor (m.HWnd, GA_PARENT)

			* Only allow children of _Screen
			lbReturn = m.lbReturn And m.lnParentHWnd = _Screen.HWnd

			* Check the border style
			lbReturn = m.lbReturn And This.HasBorder (m.HWnd)

		Catch To m.oException
			* Set details and throw to caller
			oException.UserValue = [Unhandled exception caught checking if the hWnd is an IDE Window.]
			Throw m.oException

		Endtry

		Return m.lbReturn

	Endfunc

	Function HasBorder (HWnd As Integer) As Boolean

		Local lbReturn As Boolean, lcBUffer As String, lcStyle As String

		* Check the border style using the GetWindowInfo API
		lcBUffer = Space(60)

		GetWindowInfo (m.HWnd, @m.lcBUffer)

		* Parse WINDOWINFO struct
		lcStyle = CToBin (Substr (m.lcBUffer, (4 * 9) + 1, 4), [4rs])
		If Bitand (m.lcStyle, WS_BORDER) = WS_BORDER
			lbReturn = .T.
		Endif

		Return m.lbReturn

	Endfunc

	Function RefreshWindows (HWnd As Integer)

		Local oException As Exception
		Local lnChildHWnd As Integer

		Local i As Integer
		Local lnTabHWnd As Integer

		Try
			* Go through and refresh all the Windows
			For i = 1 To This.FoxTabs.Count
				* refresh all the FoxTabs titles
				* convert the hex back to integer first though
				lnTabHWnd  = Int (Val (This.FoxTabs.Item[m.i].HWnd))
				This.FoxTabs.Item[m.i].WindowName = This.GetWindowTitle (m.lnTabHWnd)
			Endfor

			This.LoadWindows (m.HWnd)

		Catch To m.oException
			*!!!*        * Raise error event
			*!!!*        Raiseevent (This.Parent, 'LogError', oException, 'Exception caught while loading existing IDE windows.')

		Endtry

	Endfunc

	* _____________________________________________________________
	*
	* Define event handlers

	Function WindowShow (HWnd As Integer)

		Local oFoxTab As Object
		Local oException As Exception

		Try
			* Check if a valid hWnd was passed
			If Empty (m.HWnd)
				Exit
			Endif

			* Check if a FoxTab object exists for this hWnd in our collection
			If Not Empty (This.FoxTabs.GetKey (Transform (m.HWnd, [@0x])))
				* Check the window is still a child of _Screen.
				If _Screen.HWnd  # GetAncestor (m.HWnd, GA_PARENT)
					* Remove FoxTab from our collection
					This.WindowDestroy (m.HWnd)
				Endif
				* Exit the try...catch block
				Exit
			Endif

			* Check if the window is a VFP IDE window we are intersted in
			If Not This.IsIDEWindow (m.HWnd)
				* Release WM_SETTEXT event binding to this window
				*!!!*  UnBindEvents(hWnd, WM_SETTEXT)
				* Exit the try...catch block
				Exit
			Endif

			* Add a new FoxTab object to our collection
			This.NewFoxTab (m.HWnd)

		Catch To m.oException When m.oException.ErrorNo = 2071    && user thrown
			* Throw to caller
			Throw m.oException

		Catch To m.oException
			* Set exception header details and throw to caller
			oException.UserValue = [Unhandled exception caught while adding a new FoxTab object to the collection.]
			Throw m.oException

		Endtry

	Endfunc

	Function WindowSetText (HWnd As Integer)

		Local oFoxTab As Object
		Local oException As Exception
		Local cWindowCaption As String

		Try
			* Check if a valid hWnd was passed
			If Empty (m.HWnd)
				Exit
			Endif

			* Sometimes the WM_SETEXT event occurs before the WM_SHOWWINDOW (eg when VFP opens a window maximised)
			*  so we check if we need to add a FoxTab object here as well.
			This.WindowShow (m.HWnd)

			* Check if a FoxTab object exists for this hWnd in our collection
			If Empty (This.FoxTabs.GetKey (Transform (m.HWnd, [@0x])))
				* Exit the try...catch block
				Exit
			Endif

			* Check the window is still a child of _Screen.
			*   I have noticed VFP will create a child of _Screen, then
			*  SetParent to a descendent of _Screen later.
			If _Screen.HWnd  # GetAncestor (m.HWnd, GA_PARENT)
				* Remove FoxTab from our collection
				This.WindowDestroy (m.HWnd)
				* Exit the try...catch block
				Exit
			Endif

			* Set the window name of the corresponding FoxTab object
			oFoxTab		   = This.FoxTabs.Item (Transform (m.HWnd, [@0x]))
			cWindowCaption = This.GetWindowTitle (m.HWnd)
			If Not m.oFoxTab.WindowName == m.cWindowCaption
				oFoxTab.WindowName = m.cWindowCaption

				* Raise the OnChange event
				*!!!*  Raiseevent (This, 'OnChangeEvent', oFoxTab)
			Endif

			* Set the window name of the corresponding FoxTab object
			*oFoxTab = This.FoxTabs.Item(Transform(hWnd, "@0x"))
			*oFoxTab.WindowName = This.getWindowTitle(hWnd)

			* Raise the OnChange event
			*RaiseEvent(This, "OnChangeEvent", oFoxTab)

		Catch To m.oException When m.oException.ErrorNo = 2071    && user thrown
			* Throw to caller
			Throw m.oException

		Catch To m.oException
			* Set exception header details and throw to caller
			oException.UserValue = [Unhandled exception caught while adding a new FoxTab object to the collection.]
			Throw m.oException

		Endtry

	Endfunc

	Function WindowSetFocus (HWnd As Integer)

		Local oFoxTab As Object
		Local oException As Exception

		Try
			* Check the window is still a child of _Screen.
			*   I have noticed VFP will create a child of _Screen, then
			*  SetParent to a descendent of _Screen later.
			If _Screen.HWnd  # GetAncestor (m.HWnd, GA_PARENT)
				* Remove FoxTab from our collection
				This.WindowDestroy (m.HWnd)
				* Exit the try...catch block
				Exit
			Endif

			* Obtain a reference to the FoxTab object to pass to event delegate
			oFoxTab = This.FoxTabs.Item (Transform (m.HWnd, [@0x]))

			* Update the window name
			oFoxTab.WindowName = This.GetWindowTitle (m.HWnd)

			* Raise the got focus event
			*!!!*  Raiseevent (This, 'GotFocusEvent', oFoxTab)

		Catch To m.oException When m.oException.ErrorNo = 2071    && user thrown
			* Throw to caller
			Throw m.oException

		Catch To m.oException
			* Set exception header details and throw to caller
			oException.UserValue = [Unhandled exception caught while updating the window name of the active FoxTab.]
			Throw m.oException

		Endtry

	Endfunc

	Function WindowDestroy (HWnd As Integer)

		Local oFoxTab As Object
		Local oException As Exception

		Try
			* Check if a FoxTab object exists for this hWnd in our collection
			If Empty (This.FoxTabs.GetKey (Transform (m.HWnd, [@0x])))
				* Not interested
				Exit
			Endif

			* Obtain a reference to the FoxTab object to pass to event delegate
			oFoxTab = This.FoxTabs.Item (Transform (m.HWnd, [@0x]))

			* Raise the remove FoxTab event
			*!!!*  Raiseevent (This, 'RemoveFoxTabEvent', oFoxTab)

			* Release FoxTab reference so we can remove it from the collection
			oFoxTab = Null

			* Remove the FoxTab from the collection
			This.FoxTabs.Remove (Transform (m.HWnd, [@0x]))

			* Release event bindings to this window
			*!!!*  UnBindEvents(hWnd)

		Catch To m.oException When m.oException.ErrorNo = 2071    && user thrown
			* Throw to caller
			Throw m.oException

		Catch To m.oException
			* Set exception header details and throw to caller
			oException.UserValue = [Unhandled exception caught while removing the active FoxTab from our collection.]
			Throw m.oException

		Endtry

	Endfunc

	* Remove all bindings
	* Pause function when user wants to avoid any interaction while testing their app
	Function RemoveBindings()

		Do While Type ('This.FoxTabs[1]') = [O]
			This.WindowDestroy (Val (This.FoxTabs[1].HWnd))
		Enddo

		*!!!*  UnBindEvents(0)

	Endfunc

	* _____________________________________________________________
	*
	* Define event delegates

	Function AddFoxTabEvent (oFoxTab As Object)
		* Event interface
	Endfunc

	Function RemoveFoxTabEvent (oFoxTab As Object)
		* Event interface
	Endfunc

	Function GotFocusEvent (oFoxTab As Object)
		* Event interface
	Endfunc

	Function OnChangeEvent (oFoxTab As Object)
		* Event interface
	Endfunc

Enddefine

* _________________________________________________________________
*
* FoxTab class
*
Define Class FoxTab As Custom

	* Define class properties
	HWnd		   = []
	WindowName	   = []
	ContentType	   = []
	AssociatedIcon = []

	*** JRN 2010-07-24 :
	nHWnd		 = 0
	nWHAndle	 = 0
	NWHandleType = 0 && Edit session Env[25]
	lMatched	 = .F.

	* Define class members
	Function WindowName_Assign (lpcWindowName As String)

		* Set the content type derived from the window name
		This.ContentType = This.GetContentType (m.lpcWindowName)

		* Finally, set the property value
		This.WindowName = m.lpcWindowName

	Endfunc

	Function ContentType_Assign (lpcContentType As String)

		* Set the associated icon that corresponds to this content type
		This.AssociatedIcon = This.GetAssociatedIcon (m.lpcContentType)

		* Finally, set the property value
		This.ContentType = m.lpcContentType

	Endfunc

	Function GetContentType (lpcWindowName As String) As String

		Local lcContentType As String

		* [TODO] Complete remaining content types
		Do Case
			Case Empty (m.lpcWindowName)  && should not occur
				lcContentType = [VFP]

			Case [project manager] $ Lower (m.lpcWindowName)
				lcContentType = [PJX]

			Case [form designer] $ Lower (m.lpcWindowName)
				lcContentType = [SCX]

			Case [class designer] $ Lower (m.lpcWindowName)			;
					Or [class browser] $ Lower (m.lpcWindowName)
				lcContentType = [VCX]

			Case [database designer] $ Lower (m.lpcWindowName)
				lcContentType = [DBC]

			Case [table designer] $ Lower (m.lpcWindowName)
				lcContentType = [DBF]

			Case [report designer] $ Lower (m.lpcWindowName)
				lcContentType = [FRX]

			Case [menu designer] $ Lower (m.lpcWindowName)
				lcContentType = [MNX]

			Case [label designer] $ Lower (m.lpcWindowName)
				lcContentType = [LBX]

			Case [query designer] $ Lower (m.lpcWindowName)
				lcContentType = [QPX]

			Case Used (m.lpcWindowName)
				lcContentType = [DBF]

			Otherwise
				* Check if the window name contains the name of the file
				lpcWindowName = Strtran (m.lpcWindowName, [ ], [])
				lpcWindowName = Strtran (m.lpcWindowName, [*], [])

				If At ([.], m.lpcWindowName) > 0 And Len (Justext (m.lpcWindowName)) <= 3
					lcContentType = Upper (Justext (m.lpcWindowName))
				Else
					* Default to VFP type
					lcContentType = [VFP]
				Endif

		Endcase

		Return m.lcContentType

	Endfunc

	Function GetAssociatedIcon (lpcContentType As String) As String

		Local lcAssociatedIcon As String

		* Set the associated icon that corresponds to this content type
		Do Case
			Case m.lpcContentType = [VCX]
				lcAssociatedIcon = [icoClass]

			Case m.lpcContentType = [CUR]
				lcAssociatedIcon = [icoCursor]

			Case m.lpcContentType = [DBC]
				lcAssociatedIcon = [icoDatabase]

			Case m.lpcContentType = [SCX]
				lcAssociatedIcon = [icoForm]

			Case m.lpcContentType = [MNX]
				lcAssociatedIcon = [icoMenu]

			Case m.lpcContentType = [PRG]
				lcAssociatedIcon = [icoProgram]

			Case m.lpcContentType = [PJX]
				lcAssociatedIcon = [icoProject]

			Case m.lpcContentType = [FRX]
				lcAssociatedIcon = [icoReport]

			Case m.lpcContentType = [SLX]
				lcAssociatedIcon = [icoSolution]

			Case m.lpcContentType = [DBF]
				lcAssociatedIcon = [icoTable]

			Case Inlist (m.lpcContentType, [TXT], [H], [INI], [LOG])
				lcAssociatedIcon = [icoText]

			Case Inlist (m.lpcContentType, [XML], [XSD])
				lcAssociatedIcon = [icoXml]

			Case Inlist (m.lpcContentType, [XSL], [XSLT])
				lcAssociatedIcon = [icoXsl]

			Otherwise
				lcAssociatedIcon = [icoVfp]

		Endcase

		Return m.lcAssociatedIcon

	Endfunc

Enddefine

*!!!*  * _________________________________________________________________
*!!!*  *
*!!!*  * Windows Message Events Handler
*!!!*  *
*!!!*  Define Class FoxTabsEventHandler As Custom

*!!!*    * _____________________________________________________________
*!!!*    *
*!!!*    * Define class properties

*!!!*    *!!!*  PrevWndFunc  = 0
*!!!*    LastHWnd = 0

*!!!*    * _____________________________________________________________
*!!!*    *
*!!!*    * Define class members
*!!!*    Function Init()

*!!!*      * Declare Win32 API functions
*!!!*      Declare Integer CallWindowProc In Win32API Integer lpPrevWndFunc, Integer HWnd, Integer Msg, Integer wParam, Integer Lparam
*!!!*      Declare Integer GetWindowLong In Win32API Integer HWnd, Integer nIndex

*!!!*      * Store handle for use in CallWindowProc
*!!!*      *!!!*  This.PrevWndFunc = GetWindowLong (_vfp.HWnd, GWL_WNDPROC)

*!!!*    Endfunc

*!!!*    Function Destroy()

*!!!*      * Unbind all windows message events
*!!!*      *!!!*  UnBindEvents(0)

*!!!*    Endfunc

*!!!*    *!!!*  Function WMEventHandler(hWnd As Integer, Msg As Integer, wParam As Integer, lParam As Integer)

*!!!*    *!!!*    Local oException As Exception
*!!!*    *!!!*    Local lnReturn As Integer

*!!!*    *!!!*    lnReturn = 0

*!!!*    *!!!*    * In some scenarios, the hWnd and/or Msg variables do not exist.
*!!!*    *!!!*    * I don't see how that's possible, given that they are defined above, but it happens.
*!!!*    *!!!*    * See http://www.codeplex.com/VFPX/WorkItem/View.aspx?WorkItemId=20989 for an example.
*!!!*    *!!!*    * My hope is that this code will prevent other scenarios that cause C5s.
*!!!*    *!!!*    If Type("hWnd") <> "N" or Type("Msg") <> "N"
*!!!*    *!!!*      Return 0
*!!!*    *!!!*    EndIf

*!!!*    *!!!*    Try
*!!!*    *!!!*      * Handle each windows message case
*!!!*    *!!!*      Do Case
*!!!*    *!!!*        *CASE INLIST(lParam, 1235848, 1236368, 1236268, 1238376, 1238848, 1234504, 1235024, 1237032, 1236884, 1235540, 1234504)
*!!!*    *!!!*          * Don't do anything if these paramaters are passed, they refer to compile dialog events
*!!!*    *!!!*          * This was the nasty workaround - we've left the code in here for laughs for now
*!!!*    *!!!*
*!!!*    *!!!*        Case Type('This.Parent.Parent') <> 'O'
*!!!*    *!!!*          * Don't do anything  - the simple Compile error work around
*!!!*    *!!!*          * If we can't reference our parent's parent, then something weird is happening
*!!!*    *!!!*          * eg we are in the middle of a compile and VFP has totally shelled out to a
*!!!*    *!!!*          * different memory space which can't even recognise our parent
*!!!*    *!!!*          * so just let it fall through with out trying to bind to the events
*!!!*    *!!!*
*!!!*    *!!!*        Case Msg = WM_CREATE
*!!!*    *!!!*
*!!!*    *!!!*          *JAL* VFP crashes if bound to WM_CREATE when Call Stack window is opened manually after
*!!!*    *!!!*          *  a program is suspended. This code temporarily unbinds WM_CREATE and turns it back on
*!!!*    *!!!*          *  in the WM_ACTIVATE event below.
*!!!*    *!!!*          * See http://www.codeplex.com/VFPX/WorkItem/View.aspx?WorkItemId=19307
*!!!*    *!!!*          If Lower(This.Parent.GetWindowTitle(hWnd)) =  "call stack" and Program(0) <> "FOXTABS"
*!!!*    *!!!*            UnBindEvents(0, WM_CREATE)
*!!!*    *!!!*            BindEvent(0, WM_ACTIVATE, This, "WMEventHandler")
*!!!*    *!!!*          EndIf
*!!!*    *!!!*
*!!!*    *!!!*          * Raise the window create event
*!!!*    *!!!*          RaiseEvent(This, "WindowCreateEvent", hWnd)
*!!!*    *!!!*
*!!!*    *!!!*          * Bind to these events so we can add it to our collection
*!!!*    *!!!*          BindEvent(hWnd, WM_SHOWWINDOW, This, "WMEventHandler", 4)
*!!!*    *!!!*          BindEvent(hWnd, WM_SETTEXT, This, "WMEventHandler", 4)
*!!!*    *!!!*
*!!!*    *!!!*        Case Msg = WM_ACTIVATE
*!!!*    *!!!*          * Rebind CM_CREATE event after unbound above
*!!!*    *!!!*          UnBindEvents(0, WM_ACTIVATE)
*!!!*    *!!!*          BindEvent(0, WM_CREATE, This, "WMEventHandler")

*!!!*    *!!!*        Case Msg = WM_SHOWWINDOW

*!!!*    *!!!*          If wParam # 0
*!!!*    *!!!*            * Raise the window show event
*!!!*    *!!!*            RaiseEvent(This, "WindowShowEvent", hWnd)
*!!!*    *!!!*          EndIf
*!!!*    *!!!*
*!!!*    *!!!*          * Unbind to the this event as we do not require it any more
*!!!*    *!!!*          UnBindEvents(hWnd, WM_SHOWWINDOW)
*!!!*    *!!!*
*!!!*    *!!!*        Case InList(Msg, WM_SETFOCUS, WM_WINDOWPOSCHANGED, WM_CHILDACTIVATE)
*!!!*    *!!!*          * Raise the window set focus event
*!!!*    *!!!*          * Only raise when window is different than last time, to avoid flicker in toolbar
*!!!*    *!!!*          If hWnd <> This.LastHWnd
*!!!*    *!!!*            This.LastHWnd = hWnd
*!!!*    *!!!*            RaiseEvent(This, "WindowSetFocusEvent", hWnd)
*!!!*    *!!!*          EndIf

*!!!*    *!!!*        Case Msg = WM_SETTEXT
*!!!*    *!!!*          * Raise the window set text event
*!!!*    *!!!*          RaiseEvent(This, "WindowSetTextEvent", hWnd)
*!!!*    *!!!*
*!!!*    *!!!*        Case Msg = WM_DESTROY
*!!!*    *!!!*          * Raise the window destroy event
*!!!*    *!!!*          RaiseEvent(This, "WindowDestroyEvent", hWnd)
*!!!*    *!!!*
*!!!*    *!!!*      EndCase
*!!!*    *!!!*
*!!!*    *!!!*    Catch To oException
*!!!*    *!!!*      * Raise error event
*!!!*    *!!!*
*!!!*    *!!!*      * log the event call - used for debugging the compile dialog error
*!!!*    *!!!*      * Temporary code for catching the compile crash lParam
*!!!*    *!!!*      * Again, just left in for amusement value for now
*!!!*    *!!!*      * lcLog = CHR(13) + TRANSFORM(DATETIME()) + ' - ' + TRANSFORM(hWnd) + ' - ' + TRANSFORM(Msg) + ' - ' + TRANSFORM(wParam) + ' - ' + TRANSFORM(lParam) + ' - Crash '
*!!!*    *!!!*      * = STRTOFILE( lcLog, 'c:\foxtabscrashlog.txt', 1)

*!!!*    *!!!*      If Type('This.Parent.Parent') = 'O' and PemStatus(This.Parent.Parent, "LogError", 5)
*!!!*    *!!!*        RaiseEvent(This.Parent.Parent, "LogError", oException, "Exception caught while handling windows message event." + Chr(13) + " hWnd:" + Transform(hWnd, "@x0") + " Msg:" + Transform(Msg, "@x0") + " wParam:" + Transform(wParam, "@x0") + " lParam:" + Transform(lParam, "@x0"))
*!!!*    *!!!*      EndIf
*!!!*    *!!!*
*!!!*    *!!!*    Finally
*!!!*    *!!!*      * Must pass the message on
*!!!*    *!!!*      lnReturn = CallWindowProc(This.PrevWndFunc, hWnd, Msg, wParam, lParam)
*!!!*    *!!!*
*!!!*    *!!!*    EndTry

*!!!*    *!!!*    Return lnReturn
*!!!*    *!!!*
*!!!*    *!!!*  EndFunc

*!!!*    Function SetBindings (HWnd As Integer)

*!!!*      *!!!*  * Setup event bindings for this window
*!!!*      *!!!*  BindEvent(hWnd, WM_DESTROY, This, "WMEventHandler", 4)
*!!!*      *!!!*  BindEvent(hWnd, WM_SETTEXT, This, "WMEventHandler", 4)
*!!!*      *!!!*  BindEvent(hWnd, WM_SETFOCUS, This, "WMEventHandler", 4)
*!!!*      *!!!*  * Some IDE Windows don't have WM_SETFOCUS event, so use other events
*!!!*      *!!!*  If InList(Lower(This.Parent.GetWindowTitle(hWnd)), "project manager", "properties", "class designer", "form designer")
*!!!*      *!!!*    BindEvent(hWnd, WM_WINDOWPOSCHANGED, This, "WMEventHandler", 4)
*!!!*      *!!!*  EndIf

*!!!*    Endfunc

*!!!*    * _____________________________________________________________
*!!!*    *
*!!!*    * Define event delegates

*!!!*    Function WindowCreateEvent (HWnd As Integer)
*!!!*      * Event interface
*!!!*    Endfunc

*!!!*    Function WindowShowEvent (HWnd As Integer)
*!!!*      * Event interface
*!!!*    Endfunc

*!!!*    Function WindowDestroyEvent (HWnd As Integer)
*!!!*      * Event interface
*!!!*    Endfunc

*!!!*    Function WindowSetFocusEvent (HWnd As Integer)
*!!!*      * Event interface
*!!!*    Endfunc

*!!!*    Function WindowSetTextEvent (HWnd As Integer)
*!!!*      * Event interface
*!!!*    Endfunc

*!!!*    * _____________________________________________________________

*!!!*  Enddefine

*!!!*  * _________________________________________________________________
