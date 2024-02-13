# Specify the URL of the VBScript file on GitHub
$scriptUrl = "https://raw.githubusercontent.com/29039/29039s-useful-stuff/main/RegisterMicrosoftUpdate.vbs"

# Specify the local path where you want to save the VBScript file
$localScriptPath = "C:\IT-Disks\RegisterMicrosoftUpdate.vbs"

# Download the VBScript file from GitHub
Invoke-WebRequest -Uri $scriptUrl -OutFile $localScriptPath

# Run the VBScript using cscript
Start-Process -FilePath "cscript.exe" -ArgumentList $localScriptPath -Wait