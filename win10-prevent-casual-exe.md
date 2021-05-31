# Prevent casual user from running EXE files

It's not going to be as good/comprehensive as AppLocker, but if the aim is to prevent the average user from casually downloading an exe and running it, you can remove Execute permissions from the Downloads folder and anywhere else they might download the file to.

    i.e. ICACLS C:\Users\test.user\Downloads /deny "Users":(OI)(CI)(X) /T
    
There is a good chance of application incompatibility, especially if you apply it to the whole profile, so be on the look out for weird program behaviour.

If I apply it to the whole profile, I at least give the following folders explicit execute permission:

    %LocalAppData%\GoTo Opener
    %LocalAppData%\GoToMeeting
    %LocalAppData%\Microsoft\OneDrive
    %LocalAppData%\Microsoft\Teams
    %LocalAppData%\WebEx
    %AppData%\Zoom

(And you'd want to actually install those programs if applicable since they can't do it themselves anymore)

Clearly anyone with IT knowledge would find it easy to bypass, i.e. change the permissions themselves, or put into an allowed folder, but hopefully users like that would know enough not to install Malware.
