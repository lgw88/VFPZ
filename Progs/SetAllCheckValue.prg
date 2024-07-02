* LGW
LPARAMETERS toThis, tlV
FOR EACH loC IN toThis.Controls
	IF loC.BaseClass = "Checkbox"
		loC.Value = tlV
	ENDIF
ENDFOR

