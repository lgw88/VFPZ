Clear-Host

#=== Variable definitions =========================================
$sourceFolder = "H:\Work\Repos\GoFish4_Source\"
$localVersionFile = "GoFishVersionFile.txt"
$cloudVersionFile = "_GoFishVersionFile.txt"

$beta = $true

If ($beta -eq $true) {
	$appName = "GoFish4_Beta"
	$zipFile = "GoFish4_Beta.zip"
	$appFile = "GoFish4_Beta.app"
	$ftpServerPath = "mattslay.com/VFP/GoFish4/Beta/"
}
else {
	$appName = "GoFish4"
	$zipFile = "GoFish4.zip"
	$appFile = "GoFish4.app"
	$ftpServerPath = "mattslay.com/VFP/GoFish4/"
}

$ftpFolder = "ftp://u54457625:<<password>>@" + $ftpServerPath
$passwordFile = "M:\MyFtpPassword.txt"

Write-Host "Package builder and uploader - " + $appName
Write-Host ""
If (Test-Path $passwordFile)
{	
	$password = Get-Content $passwordFile
}
else
{	
	$password = Read-Host "Password: "
	clear-host
}
$ftpFolder = $ftpFolder.Replace("<<password>>", $password)

set-location $sourceFolder
If (Test-Path $zipFile){
	remove-item $zipFile
}

#--- Create fully qualified paths to filenames
$p = $PWD.path + "\"
$localZipFile = $p + $zipFile
$localAppFile = $p + $appFile
$localVersionFile = $p + $localVersionFile

#--- Create an empty ZIP file ---
set-content $zipFile ("PK" + [char]5 + [char]6 + ("$([char]0)" * 18))
(dir $zipFile).IsReadOnly = $false	

#--- Prepare to add files to the Zip  ---
"Building Zip"
$shellApplication = new-object -com shell.application
$zipPackage = $shellApplication.NameSpace($localZipFile)

#-- Add local version file to Zip ---
$zipPackage.CopyHere($localVersionFile)
Start-Sleep -Milliseconds 10

#-- Add .app file to Zip ---
$zipPackage.CopyHere($localAppFile)
Start-Sleep -Milliseconds 1000
""

#--- Upload files ----------------------------
If ($zipPackage.Items().Count -eq 2)
{
	"Deploying " + $appName + " to ftp://" + $ftpServerPath
	" "

	$webClient = New-Object System.Net.WebClient

	"Uploading Zip file..."
	$ftpZipFile = New-Object System.Uri($ftpFolder + $zipFile)
	$webclient.UploadFile($ftpZipFile, $localZipFile)

	"Uploading cloud version file..."
	$ftpVersionFile = New-Object System.Uri($ftpFolder + $cloudVersionFile)
	$webclient.UploadFile($ftpVersionFile, $p + $cloudVersionFile)


	""
	"Finished."
}
else
{
	"File count in ZIP is not correct."
}
	
	


