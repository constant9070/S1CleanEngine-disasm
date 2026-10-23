; ---------------------------------------------------------------------------
; Subroutine to load basic level data
; ---------------------------------------------------------------------------

LevelDataLoad:
	; --- Load Level Header ---
		jsr	(GetLevelHeader).l			; load level header for current zone/act into a2
		move.l	a2,-(sp)			; remember header address for later
		addq.l	#4,a2				; skip 1st PLC and level gfx entry (handled in GM_Level)

	; --- 16x16 Block Mappings ---
		move.l	(a2)+,(v_rom_blocks).w			; set ROM Blk16 pointer

	; --- 128x128 Chunk Mappings ---
		move.l	(a2)+,(v_rom_chunks).w			; set ROM Blk16 pointer

	; --- Level Layout (FG/BG) ---
		bsr.w	LevelLayoutLoad			; load FG and BG layout

	; --- Music (unused) ---
		move.w	(a2)+,d0			; load music (unused)

	; --- Palette ---
		move.w	(a2),d0				; load palette ID
		andi.w	#$FF,d0				; only use lower byte (palette ID is duplicated in headers)

		bsr.w	PalLoad_Fade			; load specified palette into fade-in buffer

	; --- 2nd PLC ---
		movea.l	(sp)+,a2			; restore base level header pointer
		addq.w	#4,a2				; advance to 2nd PLC entry
		moveq	#0,d0
		move.b	(a2),d0				; load 2nd PLC entry from level headers
		beq.s	.skipPLC			; if 2nd PLC is 0 (i.e. the ending sequence), branch
		bsr.w	AddPLC				; load secondary pattern load cues
	.skipPLC:
		rts					; return
; End of function LevelDataLoad

; ===========================================================================
; ---------------------------------------------------------------------------
; Level layout loading subroutine
; ---------------------------------------------------------------------------

LevelLayoutLoad:
		move.w	(v_zone_act).w,d0		; get current zone and act
		lsl.b	#6,d0				; shift only act byte
		lsr.w	#5,d0				; d0 = pointer for current level in Level_Index
		lea	(Level_Index).l,a0		; get layout index
		move.w	(a0,d0.w),d0			; advance to desired layout pointer in index
		lea	(a0,d0.w),a0			; load layout pointer from index
		lea	(v_lvllayout).w,a1		; MJ: FG and BG rows are interlaced $80 bytes each
		bra.w	KosDec				; MJ: decompress layout
; End of function LevelLayoutLoad
