#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
;#UseHook ; Ensures that hotkeys are not triggered again when using the Send command.
#Persistent

;SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, RegEx ; Match anywhere in a window's title and allow regex matches
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

enabledIcon := "disabled.ico"
disabledIcon := "enabled.ico"
Menu, Tray, Icon, %enabledIcon%

SetTimer, IdleHandler, 1000 ; Wait for more presses within a 400 millisecond window.

Timeout := 1000 * 60 * 5 ;; five minutes for now

IdleHandler:
   If ( A_TimeIdle > Timeout ) {
      Menu, Tray, Icon, disabled.ico
      Suspend On
   }
   return

+#q::
WinGetClass, class, A
MsgBox, The active window's class is "%class%".
return

CtrlXPrefix = 0

; caps to control
CapsLock::Ctrl
Tab::Alt
Alt::Tab

^k::
    if (OutputVar = "RichEdit20WPT2" or OutputVar = "RichEdit20WPT3")
        Send ^k
    else {
      Send +{End}
      Send ^{c}
      Send {Delete}
    }
  return

$^s::
   if CtrlXPrefix = 1
     Send, ^s
   else
     Send, ^f
   CtrlXPrefix = 0   
   return
^g::send {Esc}
^a::send {Home}
^e::send {End}
^n::send {Down}
^p::send {Up}
^d::send {Del}

^/::^z          ;; Ctrl+/ to undo
^+/::^y         ;; Ctrl+Shift+/ to redo

^j::send {Enter}
^o::send {Enter}{Left}
$^f::send {Right}
^b::send {Left}

$^w::
   If WinActive("ahk_class Chrome_WidgetWin_1")
     send ^{w}
   Else
     send ^{x}
   return 

^y:: Send ^v
	
$^v::send {PgDn}

!v::send {PgUp}      ; alt+v -> page up
!d::^Del
!w::Send ^{c}

!f::send ^{Right}
!^f::send +^{Right}
!b::send ^{Left}
!^b::send +^{Left}

!BS::send ^{BS}
^!e::send ^{End}
^!a::send ^{Home}

$^x::
  CtrlXPrefix = 1
  return
			
^#p::	; Ctrl+win+p
	Suspend, Toggle
        if (A_IsSuspended)
		Menu, Tray, Icon, %disabledIcon%
        Else
		Menu, Tray, Icon, %enabledIcon%
   
Return
