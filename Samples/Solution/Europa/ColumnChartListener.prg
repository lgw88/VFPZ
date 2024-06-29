* Define some constants we'll use.

#define FRX_OBJCOD_TITLE                    0	&& OBJCODE for title band
#define FRX_OBJCOD_PAGEHEADER               1	&& OBJCODE for page header band
#define GDIPLUS_FontStyle_Regular           0	&& GDI+ font style: regular
#define GDIPLUS_Unit_Point                  3	&& GDI+ units: points

* The ColumnChartListener class.

define class ColumnChartListener as _ReportListener of ;
	home() + 'ffc\_ReportListener.vcx'

	oGDIGraphics = .NULL.			&& reference to GPGraphics _GDIPlus object
	dimension aRecords[1]			&& array of flags for each FRX record
	dimension aValues[1]			&& array of labels and values to chart
	nCurrentRow = 0					&& current row being processed in aValues
	dimension aColumnColors[1]		&& array of column colors

	nSpacing           = 100 		&& space between columns
	nLegendSpacing     = 300		&& spacing between the chart and its legend
	nLegendBoxSize     = 200		&& the size of a legend box
	nLegendBoxSpacing  = 100		&& the spacing between items in the legend
	nLegendTextSpacing = 50			&& the spacing between boxes and text in the legend
	cLegendFontName    = 'Arial'	&& font name for legend text
	nLegendFontSize    = 10			&& font size for legend text

* Set the colors for the various columns.

	function Init
		with This
			dimension .aColumnColors[8]
			.aColumnColors[1] = .CreateColor(rgb(  0,   0, 255))	&& Blue
			.aColumnColors[2] = .CreateColor(rgb(  0, 255,   0))	&& Green
			.aColumnColors[3] = .CreateColor(rgb(255,   0,   0))	&& Red
			.aColumnColors[4] = .CreateColor(rgb(255,   0, 255))	&& Magenta
			.aColumnColors[5] = .CreateColor(rgb(255, 255,   0))	&& Yellow
			.aColumnColors[6] = .CreateColor(rgb(  0, 255, 255))	&& Cyan
			.aColumnColors[7] = .CreateColor(rgb(255, 128,   0))	&& Orange
			.aColumnColors[8] = .CreateColor(rgb(128,   0, 255))	&& Purple
		endwith
		dodefault()
	endfunc

* Do some setup tasks before the report starts.

	function BeforeReport
		dodefault()
		with This

* Create a GPGraphics object so we can do GDI+ drawing.

			.oGDIGraphics = newobject('GPGraphics', ;
				home() + 'ffc\_GDIPlus.vcx')

* Dimension aRecords to as many records as there are in the FRX so we don't
* have to redimension it as the report runs. The first column indicates if
* we've processed that record in the FRX yet, the second column is .T. for a
* Column chart object, the third column is .T. for a field containing values for
* chart labels, and the fourth column is .T. for a field containing values for
* the chart data.

			.SetFRXDataSession()
			dimension .aRecords[reccount(), 4]
			.ResetDataSession()
		endwith
	endfunc

* Because the GDI+ plus handle changes on every page, we need to set our
* SharedGDIPlusGraphics property appropriately and set the handle for our
* GPGraphics object.

	function BeforeBand(tnBandObjCode, tnFRXRecNo)
		with This
			if inlist(tnBandObjCode, FRX_OBJCOD_PAGEHEADER, FRX_OBJCOD_TITLE)
				if not .IsSuccessor
				   .SharedGDIPlusGraphics = .GDIPlusGraphics
				endif not .IsSuccessor
				.oGDIGraphics.SetHandle(.SharedGDIPlusGraphics)
			endif inlist(tnBandObjCode ...
			dodefault(tnBandObjCode, tnFRXRecNo)
		endwith
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

* Handle a shape to see if it's a column chart.

	procedure AdjustObjectSize(tnFRXRecno, toObjProperties)
		local loObject
		with This

* If we haven't already checked if this object is a column chart, find its
* record in the FRX and see if its USER memo contains "COLUMNCHART". Then flag
* that we have checked it so we don't do it again.

			if not .aRecords[tnFRXRecno, 1]
				loObject = .GetReportObject(tnFRXRecno)
				.aRecords[tnFRXRecno, 1] = .T.
				.aRecords[tnFRXRecno, 2] = atc('COLUMNCHART', loObject.User) > 0
			endif not .aRecords[tnFRXRecno, 1]

* If this is supposed to be a column chart, make its width the same as its
* height.

			if .aRecords[tnFRXRecno, 2]
				toObjProperties.Height = toObjProperties.Width
				toObjProperties.Reload = .T.
			endif .aRecords[tnFRXRecno, 2]
		endwith
	endproc

* Handle a field to see if it's involved in the column chart.

	procedure EvaluateContents(tnFRXRecno, toObjProperties)
		local loObject, ;
			lcText, ;
			lnRow
		with This

* If we haven't already checked if this object is involved in the column chart,
* find its record in the FRX and see if its USER memo contains "LABEL" or
* "VALUE". Then flag that we have checked it so we don't do it again.

			if not .aRecords[tnFRXRecno, 1]
				loObject = .GetReportObject(tnFRXRecno)
				.aRecords[tnFRXRecno, 1] = .T.
				.aRecords[tnFRXRecno, 3] = atc('LABEL', loObject.User) > 0
				.aRecords[tnFRXRecno, 4] = atc('DATA',  loObject.User) > 0
			endif not .aRecords[tnFRXRecno, 1]

* Get the value for the field, then decide what to do with it.

			lcText = toObjProperties.Text
			do case

* If this is a label, ensure it's in our array.

				case .aRecords[tnFRXRecno, 3]
					lnRow = ascan(.aValues, lcText, -1, -1, 1, 15)
					if lnRow = 0
						lnRow = iif(empty(.aValues[1]), 1, alen(.aValues, 1) + 1)
						dimension .aValues[lnRow, 2]
						.aValues[lnRow, 1] = lcText
						.aValues[lnRow, 2] = 0
					endif lnRow = 0
					.nCurrentRow = lnRow

* If this is a data value, add it to the current total.

				case .aRecords[tnFRXRecno, 4]
					.aValues[.nCurrentRow, 2] = .aValues[.nCurrentRow, 2] + ;
						val(lcText)
			endcase
		endwith
	endproc

* If we're supposed to draw a column chart, do so. Otherwise do the normal
* rendering.

	procedure Render(tnFRXRecno, tnLeft, tnTop, tnWidth, tnHeight, ;
		tnObjectContinuationType, tcContentsToBeRendered, tiGDIPlusImage)
		with This
			if .aRecords[tnFRXRecno, 2]
				.DrawColumnChart(tnLeft, tnTop, tnWidth, tnHeight)
				nodefault
			endif .aRecords[tnFRXRecno, 2]
		endwith
	endproc

	procedure DrawColumnChart(tnLeft, tnTop, tnWidth, tnHeight)
		local lnMax, ;
			lnColumns, ;
			lnI, ;
			lnColumnWidth, ;
			loColumnBrush, ;
			loPen, ;
			loFont, ;
			loStringFormat, ;
			loPoint, ;
			loTextBrush, ;
			lnColors, ;
			lnColor, ;
			lnLeft, ;
			lnHeight, ;
			lnTop
		with This

* Figure out the highest value and the width of each column.

			lnMax     = 0
			lnColumns = alen(.aValues, 1)
			for lnI = 1 to lnColumns
				lnMax = max(lnMax, .aValues[lnI, 2])
			next lnI
			lnColumnWidth = (tnWidth - (lnColumns * .nSpacing))/lnColumns

* Create _GDIPlus objects we'll need for drawing.

			loColumnBrush  = newobject('GPSolidBrush',   home() + 'ffc\_GDIPlus.vcx')
			loPen          = newobject('GPPen',          home() + 'ffc\_GDIPlus.vcx')
			loFont         = newobject('GPFont',         home() + 'ffc\_GDIPlus.vcx')
			loStringFormat = newobject('GPStringFormat', home() + 'ffc\_GDIPlus.vcx')
			loPoint        = newobject('GPPoint',        home() + 'ffc\_GDIPlus.vcx')
			loTextBrush    = newobject('GPSolidBrush',   home() + 'ffc\_GDIPlus.vcx')
			loPen.Create(.CreateColor(0))	&& Black
			loFont.Create(.cLegendFontName, .nLegendFontSize, ;
				GDIPLUS_FontStyle_Regular, GDIPLUS_Unit_Point)

* Draw the border for the column chart.

			.oGDIGraphics.DrawLine(loPen, tnLeft, tnTop, tnLeft, ;
				tnTop + tnHeight)
			.oGDIGraphics.DrawLine(loPen, tnLeft, tnTop + tnHeight, ;
				tnLeft + tnWidth, tnTop + tnHeight)

* Draw the column.

			lnColors = alen(.aColumnColors)
			for lnI = 1 to lnColumns
				lnColor = .aColumnColors[(lnI - 1) % lnColors + 1]
				loColumnBrush.Create(lnColor)
				lnLeft   = tnLeft + lnI * .nSpacing + (lnI - 1) * lnColumnWidth
				lnHeight = cast(tnHeight/lnMax * .aValues[lnI, 2] as Numeric(7, 2))
				lnTop    = tnTop + tnHeight - lnHeight
				.oGDIGraphics.DrawRectangle(loPen, lnLeft, lnTop, ;
					lnColumnWidth, lnHeight)
				.oGDIGraphics.FillRectangle(loColumnBrush, lnLeft, lnTop, ;
					lnColumnWidth, lnHeight)

* Draw the legend for the column.

				lnLeft = tnLeft + tnWidth + .nLegendSpacing
				lnTop  = tnTop + (lnI - 1) * (.nLegendBoxSize + .nLegendBoxSpacing)
				.oGDIGraphics.DrawRectangle(loPen, lnLeft, lnTop, ;
					.nLegendBoxSize, .nLegendBoxSize)
				.oGDIGraphics.FillRectangle(loColumnBrush, lnLeft, lnTop, ;
					.nLegendBoxSize, .nLegendBoxSize)
				lnLeft = lnLeft + .nLegendBoxSize + .nLegendTextSpacing
				loPoint.Create(lnLeft, lnTop)
				loTextBrush.Create(.CreateColor(0)) && Black
				.oGDIGraphics.DrawStringA(.aValues[lnI, 1], loFont, loPoint, ;
					loStringFormat, loTextBrush)
			next lnI
		endwith
	endproc

* GDI+ colors are represented by a number as 0xAARRGGBB, where AA is the alpha,
* RR is the red, GG is the green, and BB is the blue. Unfortunately, the VFP
* RGB() function gives us 0xBBGGRR, so we need to add the alpha component and
* reverse the red and blue component positions.

	procedure CreateColor(tnRGB, tnAlpha)
		local lnAlpha
		lnAlpha = iif(pcount() = 1, 255, tnAlpha)
		return bitlshift(lnAlpha, 24) + bitand(tnRGB, 0x00FF00) + ;
			bitlshift(tnRGB, 16) + bitrshift(tnRGB, 16)
	endproc
enddefine
