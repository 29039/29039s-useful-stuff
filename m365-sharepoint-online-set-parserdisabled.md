
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

Script 1 - Prerequisites installation stage 1:

    #Install scoop.sh if you don't already have it, then install nodejs:
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    scoop install git
    scoop bucket add main
    scoop install main/nodejs-lts
    npm install @pnp/cli-microsoft365

Script 2 - Prerequisites installation stage 2:

    #THere is annoying setup wizard which needs to be completed which can't be automated (AFAIK)
    #Take note of the clientId and tenantId! Save it, it will be needed.
    m365 setup
    
Script 3 - Change the ParserDisabled to true (No need to run as Admin):

(Make sure you update the $SiteURL and $SiteList as applicable)

    #Actually use the CLI for Microsoft 365 to change ParserDisabled to true (No need to run as Admin)
    #vars
    $SiteURL = "https://contoso.sharepoint.com"
    $SiteList = "Documents"
    $clientId = "00000000-0000-0000-0000-000000000000" #Replace with yours
    $tenantId = "11111111-1111-1111-1111-111111111111" #Replace with yours
    
    #version check and login
    m365 version
    m365 login --appId $clientId --tenant $tenantId --authType "deviceCode"
    
    ## Copy the code provided and enter it into https://login.microsoft.com/device
    
    #actually implement the changes
    $SiteID = m365 spo list get --webUrl $SiteURL --title $SiteList --properties "Id" --output "json" | ConvertFrom-JSON
    m365 spo list get --webUrl $SiteURL --title $SiteList --properties "Id,ParserDisabled"
    m365 spo list set --webUrl $SiteURL --id $SiteID.ID --parserDisabled true
    
    #end it
    m365 logout
