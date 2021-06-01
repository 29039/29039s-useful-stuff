### How to disable the Hotkey to change Language or Keyboard in Windows 10



# Full GUI way:

Windows 10 Settings > Time & Language > Language > Spelling, typing, & keyboard settings > Advanced keyboard settings > Input Language hot keys

# Run box way:

`rundll32 Shell32.dll,Control_RunDLL input.dll,,{C07337D3-DB2C-4D0B-9A93-B722A6C106E2}{HOTKEYS}`

# Registry way:

    Windows Registry Editor Version 5.00
    
    ; Disable hotkeys to change Language/Keyboard Layout
    
    ; for current user
    
    [HKEY_CURRENT_USER\Keyboard Layout\Toggle]
    "Hotkey"="3"
    "Language Hotkey"="3"
    "Layout Hotkey"="3"
    
    ; Disable language bar at bottom even if multiple languages are installed
    
    ; for current user
    
    [HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF\LangBar]
    "ShowStatus"=dword:00000003
    

Adapt as appropriate
