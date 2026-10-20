; ===========================================================================
; ---------------------------------------------------------------------------
; Palette cycling routine execution subroutine
; ---------------------------------------------------------------------------

PaletteCycle:
	if FixBugs
		; Fix palettes getting corrupted during level transitions between different zones
		tst.w	(f_restart).w				; is level set to restart?
		beq.s	.doCycle				; if not, branch
		rts						; don't execute palette cycle
	endif

	.doCycle:
		moveq	#0,d2					; clear d2 (redundant, not used here)
		moveq	#0,d0					; clear d0
		move.b	(v_zone).w,d0				; get zone ID
		add.w	d0,d0					; double for word-based indexing
		move.w	PalCycle_Index(pc,d0.w),d0		; find palette routine for current zone
		jmp	PalCycle_Index(pc,d0.w)			; jump to relevant palette routine
; End of function PaletteCycle

; ---------------------------------------------------------------------------
; Palette cycling routines per Zone
; ---------------------------------------------------------------------------

PalCycle_Index:	dc.w PalCycle_GHZ-PalCycle_Index		; Green Hill Zone
		zonewarning PalCycle_Index,2
		dc.w PalCycle_GHZ-PalCycle_Index		; Ending Sequence (reuses GHZ)


; ===========================================================================
; ---------------------------------------------------------------------------
; Palette cycling routine - Green Hill Zone & Title Screen
; ---------------------------------------------------------------------------

PalCycle_Title:
		lea	(Pal_TitleCyc_Water).l,a0		; use special palette cycle for the title screen
		bra.s	PCycGHZ_Go
; ===========================================================================

PalCycle_GHZ:
		lea	(Pal_GHZCyc_Water).l,a0			; use regular GHZ palette cycle data

	PCycGHZ_Go:
		; Waterfalls and background water reflections
		subq.w	#1,(v_pcyc_time).w			; decrement timer
		bpl.s	.return					; if time remains, branch

		move.w	#6-1,(v_pcyc_time).w			; reset timer
		move.w	(v_pcyc_num).w,d0			; get cycle number
		addq.w	#1,(v_pcyc_num).w			; increment cycle number
		andi.w	#3,d0					; if cycle > 3, reset to 0
		lsl.w	#3,d0					; data is arranged in blocks of 8 bytes each

		lea	(v_palette_line_3+(8*2)).w,a1		; target palette line 3, colors 8-B
		move.l	(a0,d0.w),(a1)+				; write 2 colors
		move.l	4(a0,d0.w),(a1)				; write 2 colors

	.return:
		rts						; return
; End of function PalCycle_GHZ

; ===========================================================================
; ---------------------------------------------------------------------------
; Palette cycle data bincludes
; ---------------------------------------------------------------------------

Pal_TitleCyc_Water:	binclude	"palette/Cycle - Title Screen Water.bin"
Pal_GHZCyc_Water:	binclude	"palette/Cycle - GHZ.bin"


; ===========================================================================
; ---------------------------------------------------------------------------
; useless
; ---------------------------------------------------------------------------

mSBZh:	macro {INTLABEL}
__LABEL__:	label	*
		dc.w ((__LABEL___end-__LABEL__-2)/6)-1
		endm

mSBZp:	macro duration,colours,sourceAddress,destinationPalette
		dc.b (duration-1), colours
		dc.w sourceAddress, destinationPalette
		endm

; duration in frames, number of colours, source palette data, target palette index in RAM buffer
