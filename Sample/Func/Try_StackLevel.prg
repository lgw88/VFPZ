clear
	TRY
		a
	CATCH TO loE
		? "A:",loE.StackLevel
	ENDTRY

b()
PROCEDURE b
	TRY
		a
	CATCH TO loE
		? "B:",loE.StackLevel
	ENDTRY
