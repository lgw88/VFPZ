* Define a class that knows how to apply effects to objects in a report.

define class EffectsListener as _ReportListener of ;
	home() + 'ffc\_ReportListener.vcx'

	oEffectHandlers = .NULL.
		&& a collection of effect handlers
	dimension aRecords[1]
		&& an array of information for each record in the FRX

* Create a collection of effect handler objects and fill it with the handlers
* we know about. A subclass or instance could be filled with additional ones.

	function Init
		dodefault()
		with This
			.oEffectHandlers = createobject('Collection')
			.oEffectHandlers.Add(createobject('DynamicForeColorEffect'))
			.oEffectHandlers.Add(createobject('DynamicStyleEffect'))
		endwith
	endfunc

* Dimension aRecords to as many records as there are in the FRX so we don't
* have to redimension it as the report runs. The first column indicates if
* we've processed that record in the FRX yet and the second column contains
* a collection of effect handlers used to process the record.

	function BeforeReport
		dodefault()
		with This
			.SetFRXDataSession()
			dimension .aRecords[reccount(), 2]
			.ResetDataSession()
		endwith
	endfunc

* Apply any effects that were requested to the field about to be rendered.

	function EvaluateContents(tnFRXRecno, toObjProperties)
		local loEffectObject, ;
			loEffectHandler, ;
			lcExpression
		with This

* If we haven't already checked if this field needs any effects, do so and
* flag that we have checked it so we don't do it again.

			if not .aRecords[tnFRXRecno, 1]
				.aRecords[tnFRXRecno, 1] = .T.
				.aRecords[tnFRXRecno, 2] = .SetupEffectsForObject(tnFRXRecno)
			endif not .aRecords[tnFRXRecno, 1]

* Go through the collection of effect handlers for the field (the collection
* may be empty if the field doesn't need any effects), letting each one do its
* thing.

			for each loEffectObject in .aRecords[tnFRXRecno, 2]
				loEffectHandler = loEffectObject.oEffectHandler
				lcExpression    = loEffectObject.cExpression
				loEffectHandler.Execute(toObjProperties, lcExpression)
			next loEffect
		endwith

* Do the normal behavior.

		dodefault(tnFRXRecno, toObjProperties)
	endfunc

* Go through each effect handler to see if it'll handle the current report
* object. If so, add it to a collection of handlers for the object, and return
* that collection.

	function SetupEffectsForObject(tnFRXRecno)
		local loFRX, ;
			loHandlers, ;
			loObject
		with This
			loFRX      = .GetReportObject(tnFRXRecno)
			loHandlers = createobject('Collection')
			for each loEffectHandler in .oEffectHandlers
				loObject = loEffectHandler.GetEffect(loFRX)
				if vartype(loObject) = 'O'
					loHandlers.Add(loObject)
				endif vartype(loObject) = 'O'
			next loEffectHandler
		endwith
		return loHandlers
	endfunc

* Return a SCATTER NAME object for the specified record in the FRX.

	procedure GetReportObject(tnFRXRecno)
		local loObject
		This.SetFRXDataSession()
		go tnFRXRecno
		scatter memo name loObject
		This.ResetDataSession()
		return loObject
	endproc
enddefine

* Create a class that holds a reference to an effect handler and the expression
* the effect handler is supposed to act on for a particular record in the FRX.

define class EffectObject as Custom
	oEffectHandler = .NULL.
	cExpression    = ''
enddefine

* Define an abstract class for effect handler objects.

define class EffectHandler as Custom

* Execute is called by the EvaluateContents method of EffectsListener to
* perform an effect.

	function Execute(toObjProperties, tcExpression)
	endfunc

* GetEffects is called to return an object containing a reference to the
* handler and the expression it's supposed to work on if the specified report
* object needs this effect, or return null if not.

	function GetEffect(toFRX)
		local loObject
		loObject = .NULL.
		return loObject
	endfunc

* EvaluateExpression may be called by Execute to evaluate the specified
* expression.

	function EvaluateExpression(tcExpression)
		return evaluate(tcExpression)
	endfunc
enddefine

* Define an abstract class for effect handlers that look for
* "*:EFFECTS <effectname> = <effectexpression>" in the USER memo.

define class UserEffectHandler as EffectHandler
	cEffectsDirective = '*:EFFECTS'
		&& the directive that indicates an effect is needed
	cEffectName       = ''
		&& the effect name to look for (filled in in a subclass)

	function GetEffect(toFRX)
		local lcEffect, ;
			loObject
		lcEffect = This.cEffectsDirective + ' ' + This.cEffectName
		if atc(lcEffect, toFRX.User) > 0
			loObject = createobject('EffectObject')
			loObject.oEffectHandler = This
			loObject.cExpression = strextract(toFRX.User, lcEffect + ' = ', ;
				chr(13), 1, 3)
		else
			loObject = .NULL.
		endif atc(lcEffect, toFRX.User) > 0
		return loObject
	endfunc
enddefine

* Define a class to provide dynamic forecolor effects.

define class DynamicForeColorEffect as UserEffectHandler
	cEffectName = 'FORECOLOR'

* Evaluate the expression. If the result is a numeric value and doesn't match
* the existing color of the object, change the object's color and set the
* Reload flag to .T.

	function Execute(toObjProperties, tcExpression)
		local lnColor, ;
			lnPenRed, ;
			lnPenGreen, ;
			lnPenBlue
		lnColor = This.EvaluateExpression(tcExpression)
		if vartype(lnColor) = 'N'
			lnPenRed   = bitand(lnColor, 0x0000FF)
			lnPenGreen = bitrshift(bitand(lnColor, 0x00FF00),  8)
			lnPenBlue  = bitrshift(bitand(lnColor, 0xFF0000), 16)
			with toObjProperties
				if .PenRed <> lnPenRed or ;
					.PenGreen <> lnPenGreen or ;
					.PenBlue <> lnPenBlue
					.PenRed   = lnPenRed
					.PenGreen = lnPenGreen
					.PenBlue  = lnPenBlue
					.Reload   = .T.
				endif .PenRed <> lnPenRed ...
			endwith
		endif vartype(lnColor) = 'N'
	endfunc
enddefine

* Define a class to provide dynamic style effects.

define class DynamicStyleEffect as UserEffectHandler
	cEffectName = 'STYLE'

* Evaluate the expression. If the result is a numeric value and doesn't match
* the existing style of the object, change the object's style and set the
* Reload flag to .T.

	function Execute(toObjProperties, tcExpression)
		local lnStyle
		lnStyle = This.EvaluateExpression(tcExpression)
		with toObjProperties
			if vartype(lnStyle) = 'N' and .FontStyle <> lnStyle
				.FontStyle = lnStyle
				.Reload    = .T.
			endif vartype(lnStyle) = 'N' ...
		endwith
	endfunc
enddefine
