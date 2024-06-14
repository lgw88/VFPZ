*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for determining the new nodekey and relationship to add to treeview
*-*
FUNCTION GKKAddToTreeview
LPARAMETERS poThisform,poTreeview
LOCAL lcWBSMeth, lcWBSObjc, lcWBSCurs, lnRecNo, lcObjName, lcParent, lnIcon, lcWBS, lnNodeColor, lcNodeKey
LOCAL lcParentKey, lcRelativeKey, lnRelation, llNotFound, lnKeyLen
#INCLUDE gkkdefines.h
SET DELETED ON
lcWBSMeth = poThisform.WBSMeth
lcWBSObjc = poThisform.WBSObjc
lcWBSCurs = poThisform.WBSCurs
SELECT c_editbuffer
SET ORDER TO TAG AscOrder
GOTO TOP
LOCATE FOR EMPTY(wbs) .AND. !DELETED()
DO WHILE FOUND()
	lnRecNo   = RECNO('c_editbuffer')
	lcObjName = ALLTRIM(c_editbuffer.objname)
	lcParent  = UPPER(ALLTRIM(c_editbuffer.parent))
	DO CASE
		CASE c_editbuffer.objtype = OBJTYPE_INCL
			lnIcon      = 56
			lcWBS       = "100"
			lnNodeColor = poThisform.MethForeColor
		CASE INLIST(c_editbuffer.objtype,OBJTYPE_METH,OBJTYPE_PROP,OBJTYPE_DMET,OBJTYPE_CMET,OBJTYPE_RMET,OBJTYPE_TMET)
			lnIcon    = 54
			lcWBSMeth = GKKINCSEQ(lcWBSMeth)
			lcWBS     = lcWBSMeth
			IF EMPTY(c_editbuffer.methods)
				lcObjName   = lcObjName + " (Inherited)"
				lnNodeColor = poThisform.InhertForeColor
			ELSE
				lnNodeColor = poThisform.MethForeColor
			ENDIF
		CASE INLIST(c_editbuffer.objtype,OBJTYPE_CURS,OBJTYPE_RELA)
			lnIcon      = poThisform.GetObjectIcon(c_editbuffer.baseclass)
			lcWBSCurs   = GKKINCSEQ(lcWBSCurs)
			lcWBS       = lcWBSCurs
			lnNodeColor = poThisform.ObjectForeColor
		CASE c_editbuffer.objtype = OBJTYPE_CTRL
			lnIcon      = poThisform.GetObjectIcon(c_editbuffer.baseclass)
			lcWBSObjc   = GKKINCSEQ(lcWBSObjc)
			lcWBS       = lcWBSObjc
			lnNodeColor = poThisform.ObjectForeColor
	ENDCASE
*-*	Find record with same parent or parent record		
	SELECT c_editbuffer
	SKIP -1
	DO WHILE lcParent != UPPER(ALLTRIM(c_editbuffer.parent)) .OR. !c_editbuffer.treeview
		IF BOF()
			EXIT
		ENDIF
		SKIP -1
	ENDDO
*-*	Determine node relationship
	DO CASE
		CASE BOF()
			lcNodeKey     = "_100." + lcWBS
			lcParentKey   = "_100"
			lcRelativeKey = "_100"
			lnRelation    = 4

		CASE EMPTY(c_editbuffer.parent)
			lcNodeKey   = ALLTRIM(c_editbuffer.nodekey) + "." + lcWBS
			lcParentKey = ALLTRIM(c_editbuffer.nodekey)
			lnKeyLen    = LEN(lcParentKey)
*-*			This added node is right under parent, determine if a child node is already present
			SKIP 2
			IF lcParentKey == LEFT(c_editbuffer.parentkey,lnKeyLen)
				IF c_editbuffer.treeview
					lcRelativeKey = ALLTRIM(c_editbuffer.nodekey)
					lnRelation    = 3
				ELSE
					llNotFound = .T.
					SKIP
					DO WHILE lcParentKey == LEFT(c_editbuffer.parentkey,lnKeyLen)
						IF c_editbuffer.treeview
							lcRelativeKey = ALLTRIM(c_editbuffer.nodekey)
							lnRelation    = 3
							llNotFound    = .F.
							EXIT
						ENDIF
						SKIP
					ENDDO
					IF llNotFound
						lcRelativeKey = lcParentKey
						lnRelation    = 4
					ENDIF
				ENDIF
			ELSE
				lcRelativeKey = lcParentKey
				lnRelation    = 4
			ENDIF

		CASE lcParent == UPPER(ALLTRIM(c_editbuffer.fullname))
			lcNodeKey   = ALLTRIM(c_editbuffer.nodekey) + "." + lcWBS
			lcParentKey = ALLTRIM(c_editbuffer.nodekey)
			lnKeyLen    = LEN(lcParentKey)
			SKIP 2
			IF lcParentKey == LEFT(c_editbuffer.parentkey,lnKeyLen)
				IF c_editbuffer.treeview
					lcRelativeKey = ALLTRIM(c_editbuffer.nodekey)
					lnRelation    = 3
				ELSE
					llNotFound = .T.
					SKIP
					DO WHILE lcParentKey == LEFT(c_editbuffer.parentkey,lnKeyLen)
						IF c_editbuffer.treeview
							lcRelativeKey = ALLTRIM(c_editbuffer.nodekey)
							lnRelation    = 3
							llNotFound    = .F.
							EXIT
						ENDIF
						SKIP
					ENDDO
					IF llNotFound
						lcRelativeKey = lcParentKey
						lnRelation    = 4
					ENDIF
				ENDIF
			ELSE
				lcRelativeKey = lcParentKey
				lnRelation    = 4
			ENDIF
		
		OTHERWISE
			lcNodeKey     = LEFT(ALLTRIM(c_editbuffer.nodekey),RATC(".",ALLTRIM(c_editbuffer.nodekey))) + lcWBS
			lcParentKey   = ALLTRIM(c_editbuffer.parentkey)
			lcRelativeKey = ALLTRIM(c_editbuffer.nodekey)
			lnRelation    = 2

	ENDCASE
*-*	Add to treeview display
	poTreeview.Nodes.Add(lcRelativeKey,lnRelation,lcNodeKey,lcObjName,lnIcon)
	poTreeview.Nodes.Item(lcNodeKey).Forecolor = lnNodeColor
*-*	Update treeview characteristics for object added to treeview
	GOTO RECORD lnRecNo
	REPLACE c_editbuffer.wbs       WITH SUBSTR(lcNodeKey,2)
	REPLACE c_editbuffer.treeview  WITH .T.
	REPLACE c_editbuffer.nodekey   WITH lcNodeKey
	REPLACE c_editbuffer.parentkey WITH lcParentKey
	GOTO TOP
	LOCATE FOR EMPTY(wbs) .AND. !DELETED()
ENDDO
poThisform.WBSMeth = lcWBSMeth
poThisform.WBSObjc = lcWBSObjc
poThisform.WBSCurs = lcWBSCurs
SET ORDER TO
SET DELETED OFF
RETURN lcNodeKey
ENDFUNC