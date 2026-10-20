
;--------------------------------------------------------------------------------
;-                             Settings - Main                              -
;--------------------------------------------------------------------------------

DebugPathSwappers: = 1
;	| If 1, show path swappers in debug mode and play SFX when passing one (ProjectSonic1TwoEight only)

Revision = 1
; 	| If 0, build the original version of the game, dubbed REV00
; 	| If 1, build the later version, dubbed REV01, which includes various bugfixes and enhancements
; 	| If 2, build the hacked version from Sonic Mega Collection, dubbed REVXB,
;	|       which (sloppily) fixes the infamous "spike bug" -- not recommended

FixBugs = 1
;	| If 1, enables various bugfixes across the game and sound driver
;	|       (see also the "_Fixed Binary Files" folder, and FixMusicAndSFXDataBugs)

UnusedOptimization = 1

CheatsEnabled = 1
;	| If 1, all in-game cheats (Level Select, Debug Mode, Slow-Motion, Japanese Credits)
;	|       will be enabled by default, without requiring any title screen button inputs

AllOptimizations = 0
;	| If 1, enables all optimizations
SkipChecksumCheck = 0|AllOptimizations
;	| If 1, disables the slow bootup checksum calculation
ZeroOffsetOptimization = 0|AllOptimizations
;	| If 1, makes a handful of zero-offset instructions smaller
PaddingOptimization = 0|AllOptimizations
;	| If 1, removes about 3 KB of various superfluous padding

EnableSRAM = 0
;	| If 1, enable SRAM support
BackupSRAM = 1
;	| 0 = no saving (read-only SRAM); 1 = allow saving
AddressSRAM = 3
;	| 0 = odd+even; 2 = even only; 3 = odd only
;	| (odd only is the most common setting)

ZoneCount = 1
;	| Used for the "zonewarning" macro. Do not change, unless more zones get added.
;	| Discrete zones are: GHZ

ExtendedCamera = 1  ; Extend the camera! /j

;--------------------------------------------------------------------------------
;-                    Settings - Sonic Abilities                       -
;--------------------------------------------------------------------------------

PeelOut = 1  ; PeelOut, you know.

SpinDash = 1  ; Spindash

AirDash = 1  ; turn this on and you'll be able to dash in the air!

AirRoll = 1  ; turn this on and you'll be able to dash in the air!

Turbo = 0  ; He's gone Turbo.

