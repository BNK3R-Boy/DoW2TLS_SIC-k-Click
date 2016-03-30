/*                         HowTo Use SIC(k)Click                      2015-12-02

Prepairings
1. go into your steam libery
2. Right-click on "Warhammer 40,000: Dawn of War II: Retribution"
   or "Warhammer 40,000: Dawn of War II: The Last Standalone" under the
  Library in Steam and select Properties.
3. Under the General tab click the Set launch options... button.
4. Enter the launch options "-forceactive -freemouse -window -nomovies" without
   quotation marks and click OK.
5. Close the game's Properties window and launch DoW2TLS_SIC(k)Click.exe

All done!

Keys:
1-7 = Abillitys
qwert = Control bar
Space = Center cam
Tab = By switching camera between teammates
F = green ping
G = red ping

Rest in Tooltip. ;)
Have Fun, more is nothing to say.

BNK3R Boy
*/


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;Menu, Tray, Icon, %A_ScriptDir%, 3xhumed-Mega-Games-Pack-26-Warhammer-Battle-March-2.ico, 1
#SingleInstance force
#InstallKeybdHook
#InstallMouseHook

;########################################## Start ###########################################
CoordMode, Mouse, Screen
CoordMode, Tooltip, Screen
CoordMode, Pixel, Screen
SetDefaultMouseSpeed, 0
Menu, Tray, Icon,,,1

Global Debug:=0 ; <________________________DEBUG_____________________________________________

/*
If !A_IsAdmin AND !Debug
{
    Run *RunAs "%A_ScriptFullPath%", , UseErrorLevel   ; Requires v1.0.92.01+
    ExitApp
}
*/

Global inifile="%A_ScriptFullPath%.ini"
Global MapColor1:=0x9AFB8A 
Global MapColor2:=0xFFEBA1 
Global ChatColor:=0xE6D084
Global ColorPickX1:=253
Global ColorPickY1:=56
Global ColorPickX2:=363
Global ColorPickY2:=52
Global ChatColorPickX:=72
Global ChatColorPickY:=775
Global HowLongShouldISleep:=50
Global playertoggle:=false
Global BoxSize:=10
Global ToolTipToggle:=true
Global once:=false
Global isMouseClip:=false
Global RemSU:=false
Global DoWII:="ahk_exe DOW2.exe"
Global QuickAction:=true
Global TTN:=1
Global HKToolTip:="´ ´"
HKToolTip=%HKToolTip%                   SIC(k)Click                   ´ ´`n`n
HKToolTip=%HKToolTip%            ---- Chat Hotkeys ----`n
HKToolTip=%HKToolTip%  F1: ty`n
HKToolTip=%HKToolTip%  F2: omw`n
HKToolTip=%HKToolTip%  F3: np`n
HKToolTip=%HKToolTip%  F4: sry`n
HKToolTip=%HKToolTip%  F5: Good Job`n
HKToolTip=%HKToolTip%  F6: WAAAGH!!!`n
HKToolTip=%HKToolTip%  F7: LET NONE SURVIVE`n
HKToolTip=%HKToolTip%  F8: gg`n`n
HKToolTip=%HKToolTip%           ---- Tool Hotkeys ----`n
HKToolTip=%HKToolTip%  Ctrl+F1: Pause`n
HKToolTip=%HKToolTip%  Ctrl+F2:     >>>Toggle This<<<`n
HKToolTip=%HKToolTip%  Ctrl+F3: Quickaction`n
HKToolTip=%HKToolTip%  Ctrl+F4: Fix window position`n
HKToolTip=%HKToolTip%  Ctrl+F5: Reload`n
HKToolTip=%HKToolTip%  Ctrl+F8: Exit`n
HKToolTip=%HKToolTip%  Win+p: PickColor`n
HKToolTip=%HKToolTip%, ,                                       v.1.1dev    , ,


inifile=%A_ScriptFullPath%.ini

ReadIniFile()

Goto,Script

;######################################### HotKeys ##########################################
;-----------------------------;Alle Hotkeycoordinaten sind in der Auflösunf 1920x1080
;-----------------------------;angeben.


#If !once AND !CheckChatColor() ;CheckScreen()

1::mccb(1530, 880, 1) ;-------;Aktionstaste 1
2::mccb(1585, 880, 1) ;-------;Aktionstaste 2
3::mccb(1645, 880, 1) ;-------;Aktionstaste 3
4::mccb(1705, 880, 1) ;-------;Aktionstaste 4
5::mccb(1760, 880, 1) ;-------;Aktionstaste 5
6::mccb(1820, 880, 1) ;-------;Aktionstaste 6
7::mccb(1875, 880, 1) ;-------;Aktionstaste 7

q::mccb(1750, 1010, 1) ;--------------------;Befehlsleiste 1
w::mccb(1785, 1010, 1) ;------;Befehlsleiste 2 (benötigt für Quickaction) A
e::s ;------------------------;Befehlsleiste 3 mccb(1820, 1010, 1)
r::mccb(1855, 1010, 1) ;------;Befehlsleiste 4 (benötigt für Quickaction) Z
t::mccb(1890, 1010, 1) ;------;Befehlsleiste 5 (benötigt für Quickaction) G

f::mccb(30, 820, 1) ;---------;Verteidigungs Ping (benötigt für Quickaction) F9
g::mccb(260, 1050, 1) ;-------;Angriffs Ping (benötigt für Quickaction) F8

F1::chat("ty")
F2::chat("omw")
F3::chat("np")
F4::chat("sry")

F5::chat("good job")
F6::chat("WAAAGH!!!")
F7::chat("Let None Survive")
F8::chat("gg")

Space::mccb(1410, 950, 1) ;---;Zentriert Spieler Charakter

Tab:: ;-----------------------;Wechselt zwischen Mitspielern hin und her
  playertoggle:=!playertoggle
  If (playertoggle)
    mccb(1880, 220, 2)
  If (!playertoggle)
    mccb(1880, 360, 2)
return

~LAlt::
  While(GetKeyState("LAlt", "P"))
    Sleep,1
  Sleep, 50
  MouseClip(true)
return

^F2:: ;------------------------;Hide HotkeyToolTip
  Suspend,Permit
    hotkeytooltip(true)
    TTN=10
    ToolTip,%HKToolTip%,5,155,%TTN%
    SetTimer, ToolTipDisable, 1500
return


#If

^F1:: ;-----------------------;Pause
  Suspend,Permit
  Pause,Toggle,1

  IF (RemSU)
  {
    Suspend,Off
    RemSU:=false
    MouseClip(!once)
    If !CheckScreen()
      hotkeytooltip(ToolTipToggle)
  }
  Else
  {
    Suspend,On
    RemSU:=true
    MouseClip(false)
    hotkeytooltip(false)
  }
return

^F2:: ;------------------------;Hide HotkeyToolTip
  Suspend,Permit
  ToolTipToggle:=!ToolTipToggle
  IniWrite, %ToolTipToggle%, %inifile%, Options, ToolTipToggle
  hotkeytooltip(ToolTipToggle)
return

^F3::
  Suspend,Permit
  QuickAction:=!QuickAction
  If (QuickAction)
    msg=On
  Else
    msg=Off
  TTN=17
  ToolTip,Quickaction ist: %msg%, 100, 100, %TTN%
  SetTimer, ToolTipDisable, 1500
  IniWrite, %QuickAction%, %inifile%, Options, QuickAction
return

^F4:: ;------------------------;StartUp - Windowtitel Windowposition
  Suspend,Permit
  StartUp()
return

^F5:: ;------------------------;Reload
  Suspend,Permit
  Reload
return

^F8:: ;------------------------;Exit
  Suspend,Permit
  ExitApp
return

#p::
  Suspend,Permit
  PickColor()
return

;####################################### Funktionen #########################################
mccb(x, y, c) ;---------------;Koordinaten und Click Zuweisung der Hotkeys
{
  ;BlockInput, On
  MouseGetPos, xpos, ypos
  Send, {ESC}
  Sleep, 20
  xn:=SR_x(x)
  yn:=SR_y(y)
  If (!QuickAction)
  {
    ;BlockInput, Off
    KeyWait, %A_ThisHotkey%
    ;BlockInput, On
  }
  Click %xn%, %yn%, %c%
  If (!Debug)
  {
    Sleep, 20
    MouseMove, xpos, ypos, 0
    If (QuickAction)
    {
      Sleep,250 ;-------------;Schablonen wartezeit
      ;BlockInput, Off
      KeyWait, %A_ThisHotkey%
      ;BlockInput, On
      Click 1
    }
  }
  ;BlockInput, Off
  If (Debug)
  {
    ToolTip,calculated to, xn-35, yn-40, 11
    ToolTip,(%x%x%y%) on (1920x1080), xn-70, yn-55, 12
    ToolTip,(%xn%x%yn%) on (%A_ScreenWidth%x%A_ScreenHeight%), xn-70, yn-25, 13
  }
}

chat(text) ;------------------;Chatmakro Funktion
{
  Send {Enter}
  Sleep, 100
  SendRaw %text%
  Sleep, 100
  Send {Enter}
}

StartUp() ;-------------------;Startet bei bedarf Dawn of War II: Retribution mittels Steam rungameid, entfernt Titelleiste, Maximiert, Fokusiert und positioniert auf 0x0.
{
  sumsg:=false
  IfWinNotExist, %DoWII%
  {
    If (!Debug)
    {
      Run, steam://rungameid/56400
      WinWait, %DoWII%
      Loop, 80
      {
        perc:=Floor(100/80*A_Index)
        lumsg:="Wait few seconds to avoid crashes...`n"
        lumsg=%lumsg%`n                             %perc%`%`n
        lumsg=%lumsg%`n             writen by BNK3R Boy`n
        ToolTip,%lumsg%, A_Screenwidth/2-100, 160, 12
        Sleep,100
      }
      ToolTip,,,,12
      Sleep,10
      sumsg:=true
    }
  }

  WinSet, Style, -0xC40000, %DoWII%
  WinMove, %DoWII%, , 0, 0, A_ScreenWidth, A_ScreenHeight
  WinMaximize, %DoWII%
  WinActivate, %DoWII%
  If (sumsg)
  {
    TTN=17
    ToolTip,Thank you for waiting!, A_Screenwidth/2-70, 200, %TTN%
    SetTimer, ToolTipDisable, 2000
  }
}

CheckScreen()
{
  erg:=0
  erg:=erg+SCS(ColorPickX1, ColorPickY1, MapColor1)
  erg:=erg+SCS(ColorPickX2, ColorPickY2, MapColor2)
  If (erg=0)
    erg:=true
  Else
    erg:=false
  If (Debug)
    ToolTip,CheckScreen: %erg%, 450, 450, 1
  return erg
}

CheckChatColor()
{
  erg:=0
  erg:=SCS(ChatColorPickX, ChatColorPickY, ChatColor, 20) ; 69, 777 alt 72, 773
  If (erg=0)
    erg:=true
  Else
    erg:=false
  If (Debug)
    ToolTip,ChatScreen: %erg%, 450, 500, 2

  return erg
}

SCS(x, y, n, c=50)
{
  xn:=SR_x(x+BoxSize)
  yn:=SR_y(y+BoxSize)
  BoxX:=SR_x(x-BoxSize)
  BoxY:=SR_y(y-BoxSize)
  PixelSearch, OutputVarX, OutputVarY, BoxX, BoxY, xn, yn, %n%, %c%, Fast
  return %ErrorLevel%
}

ReadIniFile()
{
  If !FileExist(inifile)
  {
    IniWrite, %MapColor1%, %inifile%, Colors, MapColor1 ;0x9AFB8A
    IniWrite, %MapColor2%, %inifile%, Colors, MapColor2 ;0xFFEBA1
    IniWrite, %ChatColor%, %inifile%, Colors, ChatColor ;0xFBE38F
    IniWrite, false, %inifile%, Options, QuickAction
    IniWrite, true, %inifile%, Options, ToolTipToggle
  }
  IniRead, MapColor1, %inifile%, Colors, MapColor1
  IniRead, MapColor2, %inifile%, Colors, MapColor2
  IniRead, ChatColor, %inifile%, Colors, ChatColor
  IniRead, QuickAction, %inifile%, Options, QuickAction
  IniRead, ToolTipToggle, %inifile%, Options, ToolTipToggle
}

PickColor()
{
  Loop, 20
    ToolTip,,,,%A_Index%

  SinglePickColor(ColorPickX1, ColorPickY1, "MapColor1")
  SinglePickColor(ColorPickX2, ColorPickY2, "MapColor2")
  Send {Enter}
  Sleep, 250
  SinglePickColor(ChatColorPickX, ChatColorPickY, "ChatColor")
  Sleep, 250
  Send {ESC}
}

SinglePickColor(x, y, n)
{
  xn:=SR_x(x)
  yn:=SR_y(y)
  PixelGetColor, OutputVar, xn, yn
  IniWrite, %OutputVar%, %inifile%, Colors, %n%
  MapColor%n%:=OutputVar
}

SR_x(x)
{
  x:=Floor(x/1920*A_ScreenWidth)
  return x
}

SR_y(y)
{
  y:=Floor(y/1080*A_ScreenHeight)
  return y
}

MouseClip(switch)
{
  If (switch)
  {
    WinActivate, %DoWII%
    VarSetCapacity(R,16,0)
    NumPut(0,&R+0)
    NumPut(0,&R+4)
    NumPut(A_ScreenWidth,&R+8)
    NumPut(A_ScreenHeight,&R+12)
    DllCall("ClipCursor", UInt,&R)
    isMouseClip:=true
  }
  else
  {
    DllCall("ClipCursor")
    WinActivate, ahk_class Shell_TrayWnd
    isMouseClip:=false
  }
}

hotkeytooltip(switch)
{
  If (switch=true)
    ToolTip,%HKToolTip%,5,155,10
  If (switch=false)
    ToolTip,,,,10
}

ToolTipDisable:
  SetTimer, ToolTipDisable, Off
  ToolTip,,,,%TTN%
return


;######################################### Ablauf ###########################################
Script:
StartUp()

While WinExist(DoWII) OR (Debug)
{
  If CheckScreen() AND once
  {
    SoundPlay, WAAAGH.wav
    MouseClip(once)
    MouseMove, A_ScreenWidth/2, A_ScreenHeight/2
    hotkeytooltip(false)
    Loop, 1000
      MouseClick, WheelDown
    HowLongShouldISleep:=1000
    once:=!once
  }
  If !CheckScreen() AND !once
  {
    MouseClip(once)
    hotkeytooltip(ToolTipToggle)
    HowLongShouldISleep:=50
    once:=!once
  }
  Sleep, HowLongShouldISleep
}
WinActivate,ahk_class Shell_TrayWnd
ExitApp
;############################################################## that's the bottom line ;) ###