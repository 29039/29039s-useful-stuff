# Define the path to the scanpst.exe tool
$scanpstPath = "C:\Program Files\Microsoft Office\root\Office16\scanpst.exe"

# Define the directory containing the PST files
$pstDirectory = "$env:USERPROFILE\Documents\Outlook Files\"

# Ensure the directory exists
if (-Not (Test-Path -Path $pstDirectory)) {
    Write-Host "The specified directory does not exist: $pstDirectory"
    exit
}

# Get all .pst files in the directory
$pstFiles = Get-ChildItem -Path $pstDirectory -Filter *.pst

# Loop through each .pst file and run scanpst.exe
foreach ($pstFile in $pstFiles) {
    Write-Host "Processing file: $($pstFile.FullName)"
    
    # Start the scanpst.exe process
    $process = Start-Process -FilePath $scanpstPath -ArgumentList "-file ""$($pstFile.FullName)"" -force" -PassThru
    
    # Wait for the process to exit
    $process.WaitForExit()

    # Check if the process exited successfully
    if ($process.ExitCode -eq 0) {
        Write-Host "Scan completed successfully for: $($pstFile.FullName)"
    } else {
        Write-Host "Scan failed for: $($pstFile.FullName) with exit code: $($process.ExitCode)"
    }
}

Write-Host "All files processed."