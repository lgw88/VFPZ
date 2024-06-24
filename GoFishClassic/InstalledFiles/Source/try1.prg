		Text To lcCode Noshow 
  		Do '<<lcFullAppName>>'
EndProc 


Define Class clsGoFishFormatGrid As Custom

	Source				= 'GoFish4_Beta'
	PlugIn				= 'GoFish Results Grid'
	Description			= 'Provides access to GoFish results grid to set colors and other dynamic properties.'
	Tools				= 'GoFish5'
	FileNames			= 'Thor_Proc_GoFish_FormatGrid.PRG'
	DefaultFileName		= '*Thor_Proc_GoFish_FormatGrid.PRG'
	DefaultFileContents	= ''

	Procedure Init
		****************************************************************
		****************************************************************
		***TEXT*** To This.DefaultFileContents Noshow
Lparameters toGrid, tcResultsCursor

*-- Sample 1: Dynamic row coloring as used by GF
Local lcComments, lcPRG, lcPRGColor, lcSCX, lcSCXColor, lcVCX, lcVCXColor

lcSCX	   = 'Upper(' + tcResultsCursor + '.filetype) = "SCX"'
lcSCXColor = 'RGB(0,0,128)'

lcVCX	   = 'Upper(' + tcResultsCursor + '.filetype) = "VCX"'
lcVCXColor = 'RGB(0,128,0)'

lcPRG	   = 'Upper(' + tcResultsCursor + '.filetype) $ "PRG TXT H INI XML HTM HTML ASP ASPX"'
lcPRGColor = 'RGB(255,0,0)'

toGrid.SetAll('DynamicForeColor', 'Iif(' + m.lcSCX + ', ' + m.lcSCXColor + ', ' +		;
	  'Iif(' + m.lcVCX + ', ' + m.lcVCXColor + ', ' +									;
	  'Iif(' + m.lcPRG + ',' + m.lcPRGColor + ', RGB(0,0,0))' +							;
	  ')' +																				;
	  ')', 'COLUMN')
Return

*-- Sample 2: Alternative provided by Jim R. Nelson
*-- Assigns row colors based on field MatchType
#Define ccBolds "<Method>", "<Procedure>", "<Function>", "<Constant>", "<<Class Def>>", "<<Method Def>>", "<<Property Def>>"
#Define ccPropertyName "<Property Name>"
#Define ccPropertyValue "<Property Value>"

Local lcBolds, lcCode, lcCodeColor, lcComments, lcCommentsColor, lcFileName, lcOthersColor
Local lcPropNameColor, lcPropertyName

lcPropertyName = [0 # Atc("<Property", ] + m.tcResultsCursor + [.MatchType)]
lcComments	   = [0 # Atc("<Comment", ] + m.tcResultsCursor + [.MatchType)]
lcFileName	   = [0 # Atc("<File", ] + m.tcResultsCursor + [.MatchType)]
lcCode		   = 'Left(' + m.tcResultsCursor + '.MatchType, 1) # "<"'

* ForeColor
lcPropNameColor	= 'RGB(0,128,0)'
lcCommentsColor	= 'RGB(0,0,0)'
lcCodeColor		= 'RGB(0,0,0)'
lcOthersColor	= 'RGB(0,0,255)'

m.toGrid.SetAll ('DynamicForeColor', 'ICase(' +					;
	  m.lcPropertyName + ', ' + m.lcPropNameColor + ', ' +		;
	  m.lcComments + ', ' + m.lcCommentsColor + ', ' +			;
	  m.lcCode + ', ' + m.lcCodeColor + ', ' +					;
	  m.lcOthersColor + ')')

* BackColor
lcCommentsColor	= 'RGB(192,192,192)'
lcFileNameColor	= 'Rgb(176, 224, 230)'
m.toGrid.SetAll ('DynamicBackColor', 'ICase(' +				;
	  m.lcComments + ', ' + m.lcCommentsColor + ', ' +		;
	  m.lcFileName + ', ' + m.lcFileNameColor + ', ' +		;
	  ' Rgb(255,255,255))')

* Bold
lcBolds		 = [Inlist(] + m.tcResultsCursor + [.MatchType, ccBolds)]
m.toGrid.SetAll ('DynamicFontBold', m.lcBolds)

Return
		End***TEXT***
  		  
		EndText
		?Strtran(lcCode, '***TEXT***', 'Text')
