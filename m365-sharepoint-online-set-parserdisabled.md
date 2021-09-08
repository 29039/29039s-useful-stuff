
# M365 SharePoint Online Set  ParserDisabled

## Intro

SharePoint has this thing that for certain document types like docx, doc, or xlsx etc. it tries to be a bit too clever for it's own good when you upload file(s) to it, because it populates metadata from the uploaded document, into the SharePoint Document Library itself, and when it does so, that modifies the binary contents of the document which was uploaded.

The document will look the same, but if you were to run a hash on it (like an MD5) or a file comparison tool (like WinMerge), there will be slight changes to it which will make the file different from the original. 

The culprit of this behaviour is the SharePoint Document Parser.

The conventional wisdom to this problem is to change a property called *ParserEnabled* to *false* to disable this behaviour on the whole site.

However Microsoft, in their infinite wisdom, have decided not to make this property available in SharePoint Online, only the On-Premises version of it. 

So the geniuses SharePointed & Abhijit Rajurkar have figured out that there is a property called *ParserDisabled* which can be set to *true* which DOES work on SharePoint online, and on a per-Library level rather than the whole site. 

However, because Microsoft seem allergic to GUI tools (i.e. being able to change it in the SharePoint settings or admin center) which would be too easy, it has to be done using the SharePoint API, and the instructions don't always work or can be a bit hard to understand.

This is where I come in and have tried to make it as simple as possible.

## Instructions

Either Copy & Paste each script at once, line-by-line, or put it into a real .ps1 script as you see fit.

## References

 - https://www.sharepointed.com/2021/03/sharepoint-online-and-copied-metadata/
 - https://docs.microsoft.com/en-us/sharepoint/technical-reference/default-crawled-file-name-extensions-and-parsed-file-types


## The meat

Three scripts...

Script 1 - Prerequisites installation stage 1 (Run as Admin):

    #pre-requisite installation stage 1 (run as admin)
    #https://chocolatey.org/install
    #https://nodejs.org/en/download/package-manager/#windows
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    choco install -y nvs
    #powershell needs restarting for nvs to actually work
    Write-Host "Please exit powershell and re-open" -ForegroundColor Green
    Pause
    exit

Make sure you EXIT powershell after you run Script 1, or Script 2 won't work.

Script 2 - Prerequisites installation stage 2 (Run as Admin):

    #pre-requisite installation stage 2 (Run as Sdmin)
    #https://pnp.github.io/cli-microsoft365/user-guide/installing-cli/
    nvs add lts
    nvs use lts
    npm install -g @pnp/cli-microsoft365

Script 3 - Change the ParserDisabled to true (Run as Admin):

    #Actually use the Microsoft 365 CLI to change ParserDisabled (no admin needed)
    #vars
    $SiteURL = "https://contoso.sharepoint.com"
    $SiteList = "Documents"
    
    #lets go
    m365 version
    m365 login --authType browser
    $SiteID = m365 spo list get --webUrl $SiteURL --title $SiteList --properties "Id" --output "json" | ConvertFrom-JSON
    m365 spo list get --webUrl $SiteURL --title $SiteList --properties "Id,ParserDisabled"
    m365 spo list set --webUrl $SiteURL --id $SiteID.ID --parserDisabled true
    
    #end it
    m365 logout
