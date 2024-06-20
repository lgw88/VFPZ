*-- Run a Report
*-- Instantiate a Report Listener (unless provided) and instantiate any
*-- classes needed to provide special effect features used in the report

*-- This program is an example of a "stub" program you can use to run all your reports. 
*-- Instead of running reports with REPORT FORM ... call this program with the 
*-- appropriate parameters and let it deal with running the reports in a manner that
*-- utilizes custom special effects. 

LPARAMETERS tlLabel, tcReportName, tcClauses, tnType, toListener

*-- tlLabel			.t. means it's a Label not a Report
*-- tcReportName	The name of the frx
*-- tcClauses		Any clauses you want appended to the REPORT FORM command
*-- tnType			Send the numeric type to indicate which Report Listener you want instantiated
*--	toListener		If you have already instantiated a Report Listener, send it here
*--					NOTE: If toListener is sent, tnType is ignored

LOCAL	lnSelect, ;
		lnFX, ;
		lcReportLabel, ;
		lcClass, ;
		loFeatures, ;
		lcFeature, ;
		llUseFX

*-- Instantiate the listener (if one wasn't passed in)
IF NOT VARTYPE(m.toListener) = 'O'
	DO InstantiateListener WITH m.tnType, m.toListener 
ENDIF

*-- Get out if no Report Listener instantiated
IF VARTYPE(m.toListener) <> 'O'
	RETURN
ENDIF

*-- Does the listener have the ability to use special effects?
llUseFX = PEMSTATUS(m.toListener, 'AddCollectionMember', 5)
IF m.llUseFX

	*-- Initialize
	loFeatures = CREATEOBJECT('Collection')
	lnSelect = SELECT(0)
	USE IN SELECT('fxRpts_Features')
	USE fxRpts_Features IN 0 SHARED
	USE IN SELECT('FRX')
	USE (FORCEEXT(m.tcReportName, 'FRX')) ALIAS FRX IN 0 SHARED


	*-- Look for special effects used in the FRX
	SELECT FRX
	SCAN FOR NOT EMPTY(Style)
		
		*-- Convert the STYLE field to a cursor full of special effect info
		lnFX = XMLTOCURSOR(Style, 'tmpFX')
		IF m.lnFX = 0
			LOOP
		ENDIF

		*-- Loop thru the special effect cursor and instantiate objects as needed
		SELECT tmpFX
		SCAN FOR Type == 'R'
			SELECT fxRpts_Features
			LOCATE FOR UPPER(ALLTRIM(NameSpace)) == UPPER(ALLTRIM(tmpFX.Name)) AND ;
						UPPER(ALLTRIM(Property)) == UPPER(ALLTRIM(tmpFX.ExecWhen))
			IF NOT FOUND() 
				LOOP
			ENDIF

			*-- Determine if the feature has already been added
			lcClass = UPPER(ALLTRIM(fxRpts_Features.Class))
			IF m.loFeatures.GetKey(m.lcClass) > 0
				LOOP
			ENDIF
			loFeatures.Add(m.lcClass)
			
			*-- Instantiate the applicable fx/gfx class
			m.toListener.AddCollectionMember( ;
					m.lcClass, ;
					ALLTRIM(fxRpts_Features.ClassLib), ;
					'', .t., fxRpts_Features.Gfx, .f.)
		ENDSCAN
	ENDSCAN

	*-- Clean up
	USE IN SELECT('fxRpts_Features')
	USE IN SELECT('tmpFX')
	USE IN SELECT('FRX')
	SELECT (m.lnSelect)
ENDIF

*-- Run the report
lcReportLabel = IIF(m.tlLabel, 'LABEL', 'REPORT')
&lcReportLabel FORM (m.tcReportName) &tcClauses OBJECT m.toListener

*-- Clean up
IF m.llUseFX
	FOR EACH lcFeature IN m.loFeatures FOXOBJECT
		m.toListener.RemoveCollectionMember(m.lcFeature, .f., .t.) &&  m.tcName, m.tlInGFX, m.tlNameIsClass
	ENDFOR
ENDIF
