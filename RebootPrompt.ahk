#Requires AutoHotkey v2
#SingleInstance Force

RebootConfirmation() {
    HWNDs := WinGetList(,, "Program Manager")
    maxCount := Min(15, HWNDs.Length)
    titlesText := "
    (
    Are you sure you want to reboot?
    Unsaved work will be lost.
    Please save and exit all your work if possible.
    
    Software still open:`n
    )"

    emptyTitleCount := 0

    Loop maxCount {
        title := WinGetTitle(HWNDs[A_Index])
        if (title = ""){
            emptyTitleCount++
            title := WinGetProcessName(HWNDs[A_Index])
            }
        titlesText .= "• " title "`n"
    }

    if (emptyTitleCount = maxCount) {
        result := MsgBox("Rebooting in 5 seconds", "Reboot", "OKCancel Icon! 262144 T5")
        return result
    }

    if (maxCount < HWNDs.Length) {
        titlesText .= "... and " HWNDs.Length - maxCount " more programs"
    }

    result := MsgBox(titlesText, "Reboot Confirmation", "YesNo Icon! Default2 262144")
    return result
}

result := RebootConfirmation()
if (result = "Yes" or result = "OK" or result = "Timeout")
    Run("shutdown.exe -r -t 5")
else if (result = "No" or result = "Cancel")
    Run("shutdown.exe -a")
