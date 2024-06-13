* GridScroll
* from: https://mp.weixin.qq.com/s/cRdgLMbuLmHWwcpGdRv9og

DECLARE LONG PostMessage IN User32 LONG, LONG, LONG, LONG
CREATE CURSOR tt (f1 C(4), f2 I)
FOR i = 1 TO 100
	INSERT INTO tt VALUES (PADL(i, 4, "0"), i)
ENDFOR
GO TOP
of = CREATEOBJECT("form1")
of.show(1)
Use in Select([tt])
RETURN

DEFINE CLASS form1 as Form
	Caption = "Grid Scroll"
	ADD OBJECT grid1 as _grid

	PROCEDURE Activate
	this.grid1._InitVal()
	ENDPROC
ENDDEFINE

DEFINE CLASS _grid as grid
	Visible = .T.
	nRows = 1
	nRect = 1

	PROCEDURE init
	BINDEVENT(thisform.hWnd, 0x401, this, "_BlankRows")
	ENDPROC

	PROCEDURE Scrolled(nDirection)
	IF INLIST(nDirection, 1,3)
		PostMessage(thisform.hWnd, 0x401, 0, 0)
	ENDIF
	ENDPROC

	PROCEDURE MouseWheel(nDirection, nShift, nXCoord, nYCoord)
	IF nDirection < 0
		PostMessage(thisform.hWnd, 0x401, 0, 0)
	ENDIF
	ENDPROC

	*	
	PROCEDURE AfterRowColChange(nColIndex)
	IF this.RowColChange != 2
		PostMessage(thisform.hWnd, 0x401, 0, 0)
	ENDIF
	ENDPROC

	* 
	FUNCTION _InitVal()
	this.nRows = 1
	this.ActivateCell(this.nRows, 1)
	this.setfocus
	DO WHILE this.RelativeRow == this.nRows
		this.nRows = this.nRows+1
		this.ActivateCell(this.nRows, 1)
		this.setfocus
	ENDDO
	this.ActivateCell(1, 1)
	this.nRows = this.nRows-1
	this.nRect = RECCOUNT()-this.nRows+1
	ENDFUNC

	* 
	FUNCTION _SetCell(nRow, nCol, nRecno)
	IF nRow <= nRecno
		GO nRecno
		this.SetFocus
		this.ActivateCell(nRow, nCol)
		DO WHILE RECNO() != nRecno
			this.DoScroll(IIF(RECNO() < nRecno, 1, 0))
			this.SetFocus
			this.ActivateCell(nRow, nCol)
		ENDDO
	ENDIF
	ENDFUNC

	* 
	FUNCTION _BlankRows(hWnd, Msg, wParam, lParam)
	LOCAL nRow, nCol
	nRow = this.RelativeRow
	nCol = this.RelativeColumn
	this.SetFocus
	IF (RECNO()-nRow+1) > this.nRect
		thisform.LockScreen = .T.
		this._SetCell(1, nCol, this.nRect)
		this.ActivateCell(this.nRows, nCol)
		thisform.LockScreen = .F.
	ENDIF
	ENDPROC
ENDDEFINE
