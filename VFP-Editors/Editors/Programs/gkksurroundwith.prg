*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Surrounds the selected text with selected command
*-*
#IFNDEF GKKDEFINES
#INCLUDE GKKDefines.h
#ENDIF
FUNCTION GKKSurroundWith
LPARAMETERS toRange,toCodeMax,tcMode
LOCAL loRange, lcTabs, lnEndLineNo, lnLine, lnLineData, lnNdx, lnPos, lcCodeLine, lcWithText, lnReplLen
LOCAL loChildForm, lcForm
lcTabs = REPLICATE(TAB,OCCURS(TAB,toCodeMax.GetLine(toRange.StartLineNo)))
GKKContextMenuIndent(toCodeMax,toRange.IsEmpty)
IF toRange.EndLineNo != toRange.StartLineNo .AND. toRange.EndColNo = 0
	toRange.EndLineNo = toRange.EndLineNo - 1
ENDIF
WITH toCodeMax
	loRange = .GetSel(True)
	IF .DocViewNavigation
		.DocViewHighlightEnabled = False
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
*-*			Get the WITH clause from user
			=INKEY(0.100,'H')
			IF lnNdx > 0
				lcWithText = LEFT(lcCodeLine,lnNdx)
			ELSE
				lcWithText = ""
			ENDIF
			.Parent.Parent.clsLightBox.ShowLightbox(True,True)
			lcForm = "GKKSurround"
			DO FORM (lcForm) WITH toCodeMax, toRange, lcWithText NAME loChildForm
			.Parent.Parent.SetModalBindEvents(loChildForm,True)
			RETURN

	ENDCASE
	loRange.StartLineNo = toRange.StartLineNo
	loRange.EndLineNo   = loRange.StartLineNo
	loRange.EndColNo    = loRange.StartColNo
	.SetSel(loRange,False)
	.ExecuteCmd(cmCmdEndUndo)                                            && End the Undo marker
	IF .DocViewNavigation
		.DocViewHighlightEnabled = True
	ENDIF
*-*	Set the change control column indicator and modified indicator
	.SetChangeControlMarkers(loRange.StartLineNo,lnEndLineNo)
*-*	Set the method modified status
	.SetModified()
ENDWITH
ENDFUNC