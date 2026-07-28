#NoTrayIcon
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

#!delete:: ; Win + Alt + Delete
	Run, shell:RecycleBinFolder
return