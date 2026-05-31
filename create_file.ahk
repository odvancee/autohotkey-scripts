; Creates and opens a file with specified FilePath, FileContent, Editor and Extension.
; Leave Editor empty for default or add "path\text_editor.exe".

#NoTrayIcon

!^+n:: ; Ctrl + Alt + Shift + N
    CreateAndOpenFile()
return

CreateAndOpenFile() {
    FilePath = %A_Desktop%\
    FileContent = # %A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%`n`n
    Editor = 
    Extension = .md
    
    FormatTime, CurrentDateTime, , yyyy-MM-dd-HH-mm
    FullPath := FilePath . CurrentDateTime . Extension
    
    if !FileExist(FullPath)
        FileAppend, %FileContent%, %FullPath%
    
    if Editor
        Run, %Editor% "%FullPath%"
    else
        Run, %FullPath%
    
    Sleep, 200
    Send, ^{End}
}