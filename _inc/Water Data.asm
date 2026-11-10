; ---------------------------------------------------------------------------
; Water data
; One entry per zone and act, in zone order (4 acts per zone, 8 bytes each).
;
;	byte 0:	water flag (0 = this zone/act has no water, 1 = it has water)
;	byte 1:	palette ID loaded for the level underwater
;	byte 2:	palette ID loaded for Sonic underwater
;	byte 3:	dynamic water routine number (0 = none, 1 = first entry of DynWater_Index, ...)
;	word 4:	starting water height
;	word 6:	unused (padding to 8 bytes)
;
; The water flag is also the water's speed in pixels per frame, so keep it at 1.
;
; To give another zone/act water, change its entry here. Nothing else in
; GM_Level needs to know which zones have water.
; ---------------------------------------------------------------------------

water_entry:	macro hasWater,levelPal,sonicPal,height,dynRoutine
		dc.b	hasWater, levelPal, sonicPal, dynRoutine
		dc.w	height, 0
		endm

nowater_entry:	macro
		water_entry 0, 0, 0, 0, 0
		endm

WaterData:
		; Green Hill
		nowater_entry
		nowater_entry
		nowater_entry
		nowater_entry
WaterData_End:
		; If your tree has the zonewarning macro, you can check the size with it here.

; ---------------------------------------------------------------------------
; Subroutine to get the water table entry for the current zone and act
;
; output:
;	a1 = address of the entry
; (d0 is clobbered)
; ---------------------------------------------------------------------------

GetWaterData:
		moveq	#0,d0
		move.b	(v_zone).w,d0			; get current zone
		lsl.w	#2,d0				; four acts per zone
		add.b	(v_act).w,d0			; add current act
		lsl.w	#3,d0				; eight bytes per entry
		lea	(WaterData).l,a1
		adda.w	d0,a1
		rts
; End of function GetWaterData
