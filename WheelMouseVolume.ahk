;;--- Head --- Informations --- AHK ---

;;	mouse volume control - over taskbar only - with sound
;;	THANKS wOxxOm https://autohotkey.com/board/topic/7977-volumouse-trick-mouse-volume-control-over-taskbar-only/
;;	Compatibility: Windows
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode

;;--- Software options ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent

	SetEnv, title, MouseWheelVolume
	SetEnv, mode, Mouse volume control over taskbar.
	SetEnv, version, Version 2017-03-22
	SetEnv, author, LostByteSoft

	FileInstall, snd_tick.wav, snd_tick.wav, 0
	FileInstall, ico_volume.ico, ico_volume.ico, 0
	FileInstall, ico_volume_2.ico, ico_volume_2.ico, 0
	FileInstall, ico_shut.ico, ico_shut.ico, 0
	FileInstall, ico_about.ico, ico_about.ico, 0
	FileInstall, ico_mute.ico, ico_mute.ico, 0
	FileInstall, ico_wheel.ico, ico_wheel.ico, 0

;;--- Menu Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, --= Mouse Wheel Volume =--, about
	Menu, Tray, Icon, --= Mouse Wheel Volume =--, ico_wheel.ico, 1
	Menu, tray, add,
	Menu, tray, add, Exit Mouse Volume, GuiClose				; GuiClose exit program
	Menu, Tray, Icon, Exit Mouse Volume, ico_shut.ico
	Menu, tray, add,
	Menu, tray, add, About - %author%, about				; Creates a new menu item.
	Menu, Tray, Icon, About - %author%, ico_about.ico, 1
	Menu, tray, add, %Version%, version					; About version
	Menu, Tray, Icon, %Version%, ico_about.ico, 1
	Menu, tray, add,							; empty space
	Menu, tray, add, Win Mute / UnMute Sound, mute
	Menu, Tray, Icon, Win Mute / UnMute Sound, ico_mute.ico
	Menu, tray, add, Win Sound Mixer, SndVol				; Open windows sound mixer
	Menu, Tray, Icon, Win Sound Mixer, ico_volume_2.ico
	Menu, Tray, Tip, Mouse Volume Control

;;--- Software start here ---

start:
	~WheelUp::mouseWheelVolume("+4")
	~WheelDown::mouseWheelVolume("-8")
	mouseWheelVolume(step)
	{
		mouseGetPos, mx, my, wnd
		wingetClass, cls, ahk_id %wnd%
		if cls=Shell_TrayWnd
	{
		SoundSet %step%
		soundSet 0, , mute
		soundGet vol
		ifInString,vol,.
		stringMid, vol,vol,1, % inStr(vol,".")-1
		SoundPlay, snd_tick.wav
		tooltip, Volume : %vol%`%, % mx+25, % my-25, 19
		setTimer removeVolumeTip, 1000
	}
		return
		removeVolumeTip:
		tooltip,,,,19
		settimer removeVolumeTip,OFF
		return
	}
	Return

mute:
	IfEqual, var, 1, goto, unmute
	Send {Volume_Mute}
	Menu, Tray, Icon, Win Mute / UnMute Sound, ico_volume_2.ico
	SetEnv, var, 1
	Goto, Start

	unmute:
	Send {Volume_Mute}
	Menu, Tray, Icon, Win Mute / UnMute Sound, ico_mute.ico
	SetEnv, var, 0
	Goto, Start

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

SndVol:
	Run, SndVol.exe
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
;		     NO FUCKING WARRANTY AT ALL
;
;      The warranty is included in your anus. Look carefully you
;             might miss all theses small characters.
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
;	If you are unhappy with this software i do not care.
;
;;--- End of file ---