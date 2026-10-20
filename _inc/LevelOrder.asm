; ===========================================================================
; ---------------------------------------------------------------------------
; Level order array (extracted from "_incObj/3A Got Through Card.asm").
; An entry specifying "0" as next level (technically GHZ1) will immediately
; return to the Sega screen instead (see Got_NextLevel in object 3A).
; ---------------------------------------------------------------------------

		; Green Hill Zone
		dc.w id_GHZ_act2	; Act 1
		dc.w id_GHZ_act3	; Act 2
		dc.w id_GHZ_act1		; Act 3
		dc.w 0			; Act 4 (unused)

; Note: Even though this array properly defines the level order for SBZ2/SBZ3/FZ,
; those transitions are not handled here, as they were hardcoded elsewhere:
; SBZ2 -> SBZ3: "01 Sonic.asm" under "Boundary_Bottom"
; SBZ3 -> FZ:   "DynamicLevelEvents.asm" under "DLE_SBZ3"

		zonewarning LevelOrder,8
		even
