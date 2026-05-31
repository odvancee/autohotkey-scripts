; Prefix-based Obsidian search (Native) with a GUI prompt.
; Enter a prefix before your search query to select the vault you want to search in.
; Example: entering "p cookie" sends "cookie" to the Obsidian Search engine in your Personal vault.
; Get vault ID: launch Obsidian > 3 dots menu on a desired vault > copy vault ID.

#NoTrayIcon
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

^!+Space:: ; Ctrl + Alt + Shift + Space

	IfWinExist, Obsidian Search
	{
		WinActivate, Obsidian Search
		return
	}
	
	Gui, New, , Obsidian_Search
	Gui, Color, 141414, 212121
	Gui, Font, s14 cFDFDFD, Consolas
	Gui, Add, Edit, vfull_input R1 -Multi W500 Background1C1B22 -Theme
	Gui, Font, s10
	Gui, Add, Button, Default xs w80 h20 cFFFFFF Background1C1B22, OK
	Gui, Add, Button, x+10 w80 h20 cFFFFFF Background1C1B22, Cancel
	Gui, Show, W540, Obsidian Search
return

ButtonOK:
	Gui, Submit
	
	; Prefix : Vault ID
	; You can have many prefixes mapped to a single vault
	; You can use vault names instead of IDs
	; The default vault is opened if no prefix is entered
	vaults := {"p": "ef54b002f99dk3d5", "e": "22f8k1djh5ed5610", "u": "22f8d6dj28ed5610"}
	defaultVault := "ef54b002f99dk3d5"
	
	prefix := SubStr(full_input, 1, 1)
	
	if (vaults.HasKey(prefix) && SubStr(full_input, 2, 1) = " ")
	{
		vault := vaults[prefix]
		query_text := SubStr(full_input, 3)
	}
	else
	{
		vault := defaultVault
		query_text := full_input
	}
	
	query_text := LTrim(query_text)
	Run, obsidian://search?vault=%vault%&query=%query_text% 
	
	Gui, Destroy
return

ButtonCancel:
GuiClose:
GuiEscape:
	Gui, Destroy
return

#IfWinActive Obsidian_Search
Enter::
	Gosub, ButtonOK
return
#IfWinActive

#IfWinActive Obsidian_Search
^Backspace::
	Send ^+{Left}{Backspace}
return
#IfWinActive