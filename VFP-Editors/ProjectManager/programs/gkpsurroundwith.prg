*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              green.gregory@comcast.net
*-*
*-* Copyright ©2010 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Surrounds the selected text with selected command
*-*
FUNCTION GKPSurroundWith
LPARAMETERS toRange,toCodeMax,tcMode
LOCAL loRange, lcTabs, lnEndLineNo, lnLine, lnLineData, lnNdx, lnPos, lcCodeLine, lcWithText, lnReplLen
LOCAL loChildForm
#INCLUDE GKPDefines.h
lcTabs = REPLICATE(TAB,OCCURS(TAB,toCodeMax.GetLine(toRange.StartLineNo)))
GKPContextMenuIndent(toCodeMax,toRange.IsEmpty)
IF toRange.EndLineNo != toRange.StartLineNo .AND. toRange.EndColNo = 0
	toRange.EndLineNo = toRange.EndLineNo - 1
ENDIF
WITH toCodeMax
	loRange = .GetSel(.T.)
	IF .DocViewNavigation
		.DocViewHighlightEnabled = .F.
	ENDIF
	.ExecuteCmd(cmCmdBeginUndo)                                          && Begin the Undo marker
	DO CASE
		CASE tcMode = "InsertDoWhile"
			.InsertLine(toRange.EndLineNo+1,lcTabs+"ENDDO")
			.InsertLine(toRange.StartLineNo,lcTabs+"DO WHILE ")
			loRange.StartColNo = LEN(lcTabs) + 9
			lnEndLineNo = toRange.EndLineNo + 2
	
		CASE tcMode = "InsertIf"
			.InsertLine(toRange.EndLineNo+1,lcTabs+"ELSE")
			.InsertLine(toRange.EndLineNo+2,lcTabs+"ENDIF")
			.InsertLine(toRange.StartLineNo,lcTabs+"IF ")
			loRange.StartColNo = LEN(lcTabs) + 3
			lnEndLineNo = toRange.EndLineNo + 3
	
		CASE tcMode = "InsertFor"
			.InsertLine(toRange.EndLineNo+1,lcTabs+"ENDFOR")
			.InsertLine(toRange.StartLineNo,lcTabs+"FOR lnNdx=1 TO ")
			loRange.StartColNo = LEN(lcTabs) + 15
			lnEndLineNo = toRange.EndLineNo + 2

		CASE tcMode = "InsertScan"
			.InsertLine(toRange.EndLineNo+1,lcTabs+"ENDSCAN")
			.InsertLine(toRange.StartLineNo,lcTabs+"SCAN FOR ")
			loRange.StartColNo = LEN(lcTabs) + 9
			lnEndLineNo = toRange.EndLineNo + 2

		CASE tcMode = "InsertTry"
			.InsertLine(toRange.EndLineNo+1,lcTabs+"CATCH TO loException")
			.InsertLine(toRange.EndLineNo+2,lcTabs+"ENDTRY")
			.InsertLine(toRange.StartLineNo,lcTabs+"TRY")
			loRange.StartColNo = LEN(lcTabs) + 3
			lnEndLineNo = toRange.EndLineNo + 3

		CASE tcMode = "InsertWith"
*-*			Get the default WITH clause
			lcWithText = ""
			lcCodeLine = ALLTRIM(.GetLine(toRange.StartLineNo),1,TAB," ")
			lnNdx = 0
			FOR lnPos=1 TO LEN(lcCodeLine)
				IF SUBSTR(lcCodeLine,lnPos,1) = "."
					lnNdx = lnPos - 1
				ENDIF
				IF SUBSTR(lcCodeLine,lnPos,1) = " "
					EXIT
				ENDIF
			ENDFOR
			IF lnNdx > 0
*-*				Get the WITH clause from user
				=INKEY(0.100,'H')
				lcWithText = LEFT(lcCodeLine,lnNdx)
				.Parent.clsLightBox.ShowLightbox(.T.,.T.)
				DO FORM GKPSurround WITH toCodeMax,toRange,lcWithText NAME loChildForm
				.Parent.SetModalBindEvents(loChildForm,.T.)
			ELSE
				.ExecuteCmd(cmCmdEndUndo)                               && End the Undo marker
				IF .DocViewNavigation
					.DocViewHighlightEnabled = .T.
				ENDIF
			ENDIF
			RETURN

	ENDCASE
	loRange.StartLineNo = toRange.StartLineNo
	loRange.EndLineNo   = loRange.StartLineNo
	loRange.EndColNo    = loRange.StartColNo
	.SetSel(loRange,.F.)
	.ExecuteCmd(cmCmdEndUndo)                                            && End the Undo marker
	IF .DocViewNavigation
		.DocViewHighlightEnabled = .T.
	ENDIF
*-*	Set the change control column indicator and modified indicator
	FOR lnLine=loRange.StartLineNo TO lnEndLineNo
		lnLineData = .GetItemData(lnLine)
		IF !BITTEST(lnLineData,2)
			lnLineData = BITSET(lnLineData,2)
			.SetMarginImages(lnLine,lnLineData)
			.SetItemData(lnLine,lnLineData)
		ENDIF
	ENDFOR
*-*	Set the method modified status
	.SetModified()
ENDWITH
ENDFUNC