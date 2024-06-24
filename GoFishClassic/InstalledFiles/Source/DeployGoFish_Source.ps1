#== Include this library file ===========================
. "H:\work\repos\GoFish4_Source\pslib.ps1"

#=== Variable definitions =========================================
$appName = "GoFish Source"
$sourceFolder = "H:\Work\Repos\GoFish4_Source\"
$zipFile = "GoFish4_Source.zip"
$localZipFile = $sourceFolder + $zipFile
$ftpFolder = "ftp://u54457625:<<password>>@mattslay.com/VFP/GoFish4/"
$passwordFile = "M:\MyFtpPassword.txt"

Clear-Host
Write-Host "Package builder and uploader - " + $appName
Write-Host ""
If (Test-Path $passwordFile){	
	$password = Get-Content $passwordFile
} else {	
	$password = Read-Host "Password: "
	clear-host
}

$ftpFolder = $ftpFolder.Replace("<<password>>", $password)

set-location $sourceFolder

If (Test-Path $zipFile){
	remove-item $zipFile
}

#--- Create an empty ZIP file -----------------------
set-content $zipFile ("PK" + [char]5 + [char]6 + ("$([char]0)" * 18))
(dir $zipFile).IsReadOnly = $false	

#=== Add files to Zip file ====================================
write-host  "Building Zip..."
$shellApplication = new-object -com shell.application
$zipPackage = $shellApplication.NameSpace($localZipFile)

#--- Add Folders (with some exclusions ) ------------------------------------------------
dir . | Where-Object { $_.PSIsContainer } | ForEach-Object {
	If ( -not ($_.fullname).EndsWith(".hg"))
	{
		AddItemToZip $zipPackage $_.fullname
	}
}

#--- Add files, with some filtering
$filesToSkip = "*.hgignore", "*.hg", "*.ps1", "*.bat", "*.zip", "*.app", "*_ref.*", "*.bak"
Get-ChildItem *.* -exclude $filesToSkip | foreach {
	AddItemToZip $zipPackage $_.fullname
}

write-host  "  done."

#--- Upload the file ----------------------------
If (Test-Path $localZipFile)
{
	Write-Host "Uploading Zip file..."
	$ftpZipFile = New-Object System.Uri($ftpFolder + $zipFile)
	$webClient = New-Object System.Net.WebClient
	$webclient.UploadFile($ftpZipFile, $localZipFile)
	Write-Host "  done."
}
else
{
	"Error. - No Zip file"
}
	



	


