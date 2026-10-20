; ---------------------------------------------------------------------------
; Level Headers
; ---------------------------------------------------------------------------

GetLevelHeader:
		moveq	#0,d0					; clear d0
		move.b	(v_zone).w,d0				; get current zone ID
		lsl.w	#6,d0					; multiply by $40 (4 acts per zone * $10 bytes per act)
		move.w	d0,-(sp)				; backup d0 to stack
		moveq	#0,d0					; clear d0
		move.b	(v_act).w,d0				; get current act number
		lsl.w	#4,d0					; multiply by $10 (bytes for one level header)
		add.w	(sp)+,d0				; restore d0 from stack and add to get index
		lea	LevelHeaders(pc,d0.w),a2		; load level header for current zone/act into a2
		rts						; return
; ---------------------------------------------------------------------------

LevelHeaders:

; 1st PLC, level gfx, 2nd PLC, 16x16 data, 256x256 data, collision, palette
lhead:	macro plc1,lvlgfx,plc2,sixteen,onetwoeight,collision1,pal
		dc.l (plc1<<24)+lvlgfx
		dc.l (plc2<<24)+sixteen
		dc.l onetwoeight
		dc.l (collision1<<8)+pal
		endm

		;	1st PLC		level gfx	2nd PLC		16x16 data	256x256 data	collision	palette
		lhead	plcid_GHZ,	KosM_GHZ,	plcid_GHZ2,	Blk16_GHZ,	Blk128_GHZ,	Col_GHZ_1,	palid_GHZ1	; Green Hill 1
		lhead	plcid_GHZ,	KosM_GHZ,	plcid_GHZ2,	Blk16_GHZ,	Blk128_GHZ,	Col_GHZ_1,	palid_GHZ2	; Green Hill 2
		lhead	plcid_GHZ,	KosM_GHZ,	plcid_GHZ2,	Blk16_GHZ,	Blk128_GHZ,	Col_GHZ_1,	palid_GHZ3	; Green Hill 3
		lhead	plcid_GHZ,	KosM_GHZ,	plcid_GHZ2,	Blk16_GHZ,	Blk128_GHZ,	Col_GHZ_1,	palid_GHZ1	; Green Hill 4 (unused)


		zonewarning LevelHeaders,$10*4
		lhead	0,		KosM_GHZ,	0,		Blk16_GHZ,	Blk128_GHZ,	Col_GHZ_1,	palid_Ending	; Ending (good)
		lhead	0,		KosM_GHZ,	0,		Blk16_GHZ,	Blk128_GHZ,	Col_GHZ_1,	palid_Ending	; Ending (bad)

		even