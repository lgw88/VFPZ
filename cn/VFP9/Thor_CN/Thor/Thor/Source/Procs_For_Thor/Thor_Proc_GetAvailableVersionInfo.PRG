#Define CR 			Chr[13]
#Define STARS 		Replicate('=', 40)
#Define MaxTries 	4

Lparameters toUpdateInfo

*-- 2011-07 M. Slay - Revised to set properties on passed toUpdateInfo
Local lcLocalVersionFile, lcVersionFileCode, lcVersionFileUrl, llReturn, lnAttempt, laLines[1]

lcLocalVersionFile = Addbs (Sys(2023)) + Justfname (toUpdateInfo.VersionLocalFilename) && Temp folder
lcVersionFileUrl   = toUpdateInfo.VersionFileUrl

If Not Empty (lcVersionFileUrl)

	For lnAttempt = 1 To MaxTries
		toUpdateInfo.ErrorCode = 0
		llReturn			   = Execscript (_Screen.cThorDispatcher, 'Thor_Proc_DownloadFileFromURL', lcVersionFileUrl, lcLocalVersionFile)

		If llReturn = .T.
			lcVersionFileCode = Filetostr (lcLocalVersionFile)

			*-- The downloaded file above contains VFP code which will set properties on the passed object:
			Try
				WritetoCFULog( [从下载的版本文件执行代码...] )
				toUpdateInfo = Execscript (lcVersionFileCode, toUpdateInfo)
			Catch
				WritetoCFULog( [从下载的版本文件执行代码时出现错误！] )
				toUpdateInfo.ErrorCode = -1
			Endtry

			Do Case
				Case toUpdateInfo.ErrorCode = 0
					Exit
				Case lnAttempt = MaxTries
					If Alines (laLines, lcVersionFileCode) > 4 && ignore messages about earlier versions which did not pass objects
						ErrorMessage ( [版本文件中的格式无效 ]  + toUpdateInfo.AppName + CR	+ ;
							  STARS + CR + 'URL: ' + lcVersionFileUrl + CR +					;
							  STARS + CR + lcVersionFileCode + CR +								;
							  STARS, toUpdateInfo.AppName)
					Endif
				Otherwise
			Endcase

		Else
			toUpdateInfo.ErrorCode = -5
			WritetoCFULog( [从服务器获取版本信息时出错。] )
			If lnAttempt = MaxTries
				ErrorMessage ( [从服务器获取版本信息时出错。]  + toUpdateInfo.AppName + CR	+ ;
					  STARS + CR + 'URL: ' + lcVersionFileUrl + CR +							;
					  STARS, toUpdateInfo.AppName)
			Endif
		EndIf
		
	Endfor

Endif

If Empty(toUpdateInfo.AvailableVersion)
	toUpdateInfo.AvailableVersion = toUpdateInfo.ApplicationName + ' - ' +		;
		Transform(toUpdateInfo.VersionNumber) + ' - ' +							;
		Transform(toUpdateInfo.VersionNumber) + ' - ' +							;
		Dtoc(Evl(toUpdateInfo.VersionDate, Date(2001,1,1)), 1)
Endif
		
Return Execscript (_Screen.cThorDispatcher, 'Result=', toUpdateInfo)


Procedure ErrorMessage (tcMessage, tcAppName)
	#Define CR Chr[13]
	Local lcMessage
	WritetoCFULog( [消息： ]  + tcMessage)
	lcMessage = tcMessage + CR + CR +  [正在取消 ... ]  + CR + CR +  [如果再次运行“检查更新”，此错误可能会自行更正。] 
	Messagebox (lcMessage, 0,  [错误]  + [:] + tcAppName)

Endproc


Procedure WritetoCFULog (tcText, tlDivider)
	Execscript (_Screen.cThorDispatcher, 'Thor_Proc_WriteToCFULog', tcText, tlDivider)
EndProc 
