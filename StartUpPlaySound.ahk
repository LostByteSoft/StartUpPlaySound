;;--- Head AHK Informations ---
;; Play the sound you want at Windows Start up.
;; Compatibility: Windows , mp3 , wav

	SetEnv, title, StartUpPlaySound
	SetEnv, mode, Play the sound you want at Windows Start up.
	SetEnv, version, Version 2017-03-07-10:43
	SetEnv, author, LostByteSoft

;;--- Software options ---

	#SingleInstance Force

;;--- Tray options ---

	Menu, tray, add, --------, secret		; empty space
	Menu, tray, add, About, about			; Creates a new menu item.
	Menu, tray, add, Version, version		; About version

;;--- Software start here ---

start:
	sleep, 3000
	IniRead, soundfile, StartUpPlaySound.ini, options, sound
	IniRead, random, StartUpPlaySound.ini, options, random
	IfNotExist, StartUpPlaySound.ini, goto, default
	IfEqual, random, 0, goto, normal
	IfEqual, random, 1, goto, random
	MsgBox, Error_01: normal=%normal% random=%random% Now Exit
	goto, GuiClose

normal:					;; Play your music.
	IfNotExist, %soundfile%, MsgBox , 0, Error_02, File not found. Audio file must be in same folder as StartUpPlaySound.exe, 3
	goto, playfile

random:					;; Generate random audio file to play. Windows start sound.
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
	IfNotExist, %soundfile%, MsgBox , 0, Error_03, File not found. Audio file must be in same folder as StartUpPlaySound.exe, 3
	goto, playfile

playfile:				;; Play the file and wait to finish
	IfNotExist, %soundfile%, goto, default
	SoundPlay, %soundfile%, wait
	Sleep, 1000
	goto, GuiClose

default:
	FileInstall, win95.mp3, win95.mp3, 0
	SoundPlay, win95.mp3, wait
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
	MsgBox, Secret box. soundfile=%soundfile% random=%random%
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
;              LostByteSoft no copyright or copyleft.
;
;;--- End of file ---
