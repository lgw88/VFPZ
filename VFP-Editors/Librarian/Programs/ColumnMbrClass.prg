*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-* Copyright ©2014 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Routine for defining the MemberClass for Grid Columns
*-*
DEFINE CLASS GKKColumn AS Column
	PROCEDURE FontBold_Assign
		LPARAMETERS tnValue
		this.FontBold = tnValue
		SET STEP ON
	ENDPROC
ENDDEFINE