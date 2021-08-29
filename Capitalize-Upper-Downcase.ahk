#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
cycleNumber := 1
 
^+d::
If (cycleNumber==1)
{
ConvertUpper()
cycleNumber:= 2
}
Else If (cycleNumber==2)
{
ConvertLower()
cycleNumber:= 3
}
Else
{
ConvertSentence()
cycleNumber:= 1
}
Return
 
 
 
 
 
ConvertUpper()
{
	clipSave := Clipboard
	Clipboard = ; Empty the clipboard so that ClipWait has something to detect
	SendInput, ^c ;copies selected text
	ClipWait
	StringReplace, Clipboard, Clipboard, `r`n, `n, All ;Fix for SendInput sending Windows linebreaks 
	StringUpper, Clipboard, Clipboard ;Convert case
	Len:= Strlen(Clipboard) ;Set number of characters
    Send %Clipboard% ;Send new string
	Send +{left %Len%} ;Re-select text
    VarSetCapacity(OutputText, 0) ;free memory
	Clipboard := clipSave ;Restore previous clipboard
}
 
ConvertLower()
{
	clipSave := Clipboard
	Clipboard = ; Empty the clipboard so that ClipWait has something to detect
	SendInput, ^c ;copies selected text
	ClipWait
	StringReplace, Clipboard, Clipboard, `r`n, `n, All ;Fix for SendInput sending Windows linebreaks 
	StringLower, Clipboard, Clipboard ;Convert case
	Len:= Strlen(Clipboard) ;Set number of characters
    Send %Clipboard% ;Send new string
	Send +{left %Len%} ;Re-select text
    VarSetCapacity(OutputText, 0) ;free memory
	Clipboard := clipSave ;Restore previous clipboard
}
 
ConvertSentence()
{
	clipSave := Clipboard
	Clipboard = ; Empty the clipboard so that ClipWait has something to detect
	SendInput, ^c ;copies selected text
	ClipWait
	StringReplace, Clipboard, Clipboard, `r`n, `n, All ;Fix for SendInput sending Windows linebreaks 
	StringLower, Clipboard, Clipboard ;Convert case
	Clipboard := RegExReplace(Clipboard, "(((^|([.!?]+\s+))[a-z])| i | i')", "$u1")
	Len:= Strlen(Clipboard) ;Set number of characters
    Send %Clipboard% ;Send new string
	Send +{left %Len%} ;Re-select text
    VarSetCapacity(OutputText, 0) ;free memory
	Clipboard := clipSave ;Restore previous clipboard
}
