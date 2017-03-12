;;--- Head --- Informations --- AHK --- File(s) needed ---
;;	Play the sound you want at Windows Start up.
;;	Compatibility: Windows , mp3 , wav
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode

;;--- Software options ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force

	SetEnv, title, StartUpPlaySound
	SetEnv, mode, Play the sound you want at Windows Start up.
	SetEnv, version, Version 2017-03-11
	SetEnv, author, LostByteSoft

	FileInstall, StartUpPlaySound.ini, StartUpPlaySound.ini, 0
	FileInstall, nt4.mp3, nt4.mp3
	FileInstall, vista.mp3, vista.mp3, 0
	FileInstall, wfw311.mp3, wfw311.mp3, 0
	FileInstall, win31.mp3, win31.mp3, 0
	FileInstall, win95.mp3, win95.mp3, 0
	FileInstall, win98.mp3, win98.mp3, 0
	FileInstall, win2000.mp3, win2000.mp3, 0
	FileInstall, winxp.mp3, winxp.mp3, 0
	FileInstall, Win10.wav, Win10.wav, 0
	FileInstall, ico_about.ico, ico_about.ico, 0
	FileInstall, ico_lock.ico, ico_lock.ico, 0
	FileInstall, ico_reboot.ico, ico_reboot.ico, 0
	FileInstall, ico_shut.ico, ico_shut.ico, 0

;;--- Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, Exit StartUpPlaySound, GuiClose	; GuiClose exit program
	Menu, Tray, Icon, Exit StartUpPlaySound, ico_shut.ico
	Menu, tray, add, Secret MsgBox, secret			; empty space
	Menu, Tray, Icon, Secret MsgBox, ico_lock.ico, 1
	Menu, tray, add,
	Menu, tray, add, About, about				; Creates a new menu item.
	Menu, Tray, Icon, About, ico_about.ico, 1
	Menu, tray, add, Version, version			; About version

;;--- Software start here ---

	t_UpTime := A_TickCount // 1000				; Elapsed seconds since start if uptime upper (Var timer specified in WMC fitscreen.ini) sec start imediately

start:
	IfGreater, t_UpTime, 3, goto, skipsleep			; Elapsed seconds since start if uptime upper variable timer sec start imediately
	sleep, 3000
	skipsleep:
	IniRead, soundfile, StartUpPlaySound.ini, options, sound
	IniRead, random, StartUpPlaySound.ini, options, random
	IfEqual, random, 0, goto, playfile
	IfEqual, random, 1, goto, random
	MsgBox, Error_01: normal=%normal% random=%random% Now Exit
	goto, GuiClose

random:								; Generate random audio file to play. Windows start sound.
	Random, number, 1, 9
	IfEqual, number, 1, SetEnv, soundfile, nt4.mp3
	IfEqual, number, 2, SetEnv, soundfile, vista.mp3
	IfEqual, number, 3, SetEnv, soundfile, wfw311.mp3
	IfEqual, number, 4, SetEnv, soundfile, win31.mp3
	IfEqual, number, 5, SetEnv, soundfile, win95.mp3
	IfEqual, number, 6, SetEnv, soundfile, win98.mp3
	IfEqual, number, 7, SetEnv, soundfile, win2000.mp3
	IfEqual, number, 8, SetEnv, soundfile, winxp.mp3
	IfEqual, number, 9, SetEnv, soundfile, Win10.wav
	IfNotExist, %soundfile%, MsgBox , 0, Error_03, File not found. Audio file must be in same folder as StartUpPlaySound.exe
	goto, playfile

playfile:				;; Play the file and wait to finish
	IfNotExist, %soundfile%, goto, random
	SoundPlay, %soundfile%, wait
	Sleep, 1000
	goto, GuiClose

;;--- Quit (escape , esc) ---

GuiClose:
	ExitApp

Escape::
	ExitApp

;;--- Tray Bar (must be at end of file) ---

about:
	TrayTip, %title%, %mode%, 2, 1
	Return

version:
	TrayTip, %title%, %version% by %author%, 2, 2
	Return

Secret:
	MsgBox, 0, Secret box, title=%title% mode=%mode% version=%version% author=%author%`n`nsoundfile=%soundfile% random=%random% t_UpTime=%t_UpTime% normal=%normal%
	Return

;;--- End of script ---
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   Version 3.14159265358979323846264338327950288419716939937510582
;                          March 2017
;
; Everyone is permitted to copy and distribute verbatim or modified
; copies of this license document, and changing it is allowed as long
; as the name is changed.
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;
;              You just DO WHAT THE FUCK YOU WANT TO.
;
;	As is customary and in compliance with current global and
;	interplanetary regulations, the author of these pages disclaims
;	all liability for the consequences of the advice given here,
;	in particular in the event of partial or total destruction of
;	the material, Loss of rights to the manufacturer's warranty,
;	electrocution, drowning, divorce, civil war, the effects of
;	radiation due to atomic fission, unexpected tax recalls or
;	    encounters with extraterrestrial beings 'elsewhere.
;
;              LostByteSoft no copyright or copyleft.
;
;;--- End of file ---