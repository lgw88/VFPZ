*=======================================================================================
* Dynamic Form Deployment Builder - By Matt Slay					
*--------------------------------------------------------------------------------------
*-- This file is only used to help be deploy the files to the cloud server for dowloading through Thor.
*-- It has nothing to do with using DynamicForm.

Local lcBuildDate, lcCloudVersionFileContents, lcCode, lcContents, lcDate, lcHeader
Local lcLocalVersionFile, lcMonthDay, lcName, lcVersion, lcVersionStringForVersionFile, lcYear
Local laParse[1]

Cd 'h:\work\repos\DynamicForm'

lcVersion = '1.7.0 Alpha'
lcName = 'Dynamic Form'
lcAuthor = 'Matt Slay'

*-- Create a file in the source file which contains the Version number
lcDate = Transform(Date(), '@YL')
lcMonthDay = Alltrim(Getwordnum(lcDate, 2, ','))
lcYear = Alltrim(Getwordnum(lcDate, 3, ','))
lcBuildDate = lcMonthDay + ', ' + lcYear

lcVersionStringForVersionFile = lcName + ' - ' + lcVersion + ' - ' + lcBuildDate + ' - ' + Dtoc (Date(), 1)

lcLocalVersionFile = 'DynamicFormVersionFile.txt'
Delete File (lcLocalVersionFile)
Strtofile(lcVersionStringForVersionFile, lcLocalVersionFile)


*======================================================================================= 
*-- Build the cloud version file ------------

Text To lcCloudVersionFileContents Noshow Textmerge Pretext 3

	Lparameters toUpdateInfo

		###Text to lcNote NoShow
			<<FileToStr('Changelog.txt')>>
		###EndText 


		AddProperty(toUpdateInfo, 'AvailableVersion', '<<lcVersionStringForVersionFile>>')
		AddProperty(toUpdateInfo, 'SourceFileUrl', 'http://bit.ly/DynamicForm_Alpha')
		AddProperty(toUpdateInfo, 'LinkPrompt', 'Dynamic Form Home Page')
		AddProperty(toUpdateInfo, 'Link', 'http://vfpx.codeplex.com/wikipage?title=Dynamic%20Forms')
		AddProperty(toUpdateInfo, 'Notes', lcNote)

		Execscript (_Screen.cThorDispatcher, 'Result=', toUpdateInfo)
		Return toUpdateInfo

Endtext

lcCode = Strtran(lcCloudVersionFileContents, '###', '')

Strtofile(lcCode, '_' + lcLocalVersionFile )


*======================================================================================================
*-- Add version info and Header to the top of DynamicForm.prg

Text To lcHeader Textmerge Noshow
*=======================================================================================================
* <<lcVersionStringForVersionFile>>
*
* By: Matt Slay 
*-------------------------------------------------------------------------------------------------------
Endtext

lcContents = lcHeader + Chr(13) + Chr(10)
Dimension laParse[1]
Alines(laParse, Filetostr('DynamicForm.prg'))


For ix = 6 To Alen(laParse)

	lcContents = lcContents + laParse[m.ix]  && AParse[m.ix] contains current line in loop - do whatever with it
	lcContents = lcContents + Chr(13) + Chr(10)

EndFor
Copy File 'DynamicForm.prg' to ('Backups\DynamicForm_' + Ttoc(DateTime(), 1) + '.prg')

Delete File 'DynamicForm.prg'
StrToFile(lcContents, 'DynamicForm.prg')

? ' '
? ' '
? ' '
? '================================='
? lcVersionStringForVersionFile
