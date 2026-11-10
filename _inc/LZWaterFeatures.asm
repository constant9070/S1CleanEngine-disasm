; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to do special water effects in Labyrinth Zone
; ---------------------------------------------------------------------------

LZWaterFeatures:
		tst.b	(f_water).w				; does this level have water? (set from WaterData)
		beq.s	.return					; if not, don't run any water effects at all

	if Revision<>0
		tst.b   (f_nobgscroll).w			; is Sonic drowning? (BG no-scroll flag)
		bne.s	.setWaterHeight				; if yes, skip other effects
	endif
		cmpi.b	#6,(v_player+obRoutine).w		; has Sonic just died?
		bhs.s	.setWaterHeight				; if yes, skip other effects
   nop ; put here because of build warnings
; ---------------------------------------------------------------------------

.setWaterHeight:
		clr.b	(f_wtr_state).w				; clear "screen is completely underwater" flag
		moveq	#0,d0					; clear d0 for word-sized water height
		move.b	(v_oscillate+2).w,d0			; get first entry in oscillatory values (frequency = 2; middle value = $10)
		lsr.w	#1,d0					; divide by 2
		add.w	(v_waterpos2).w,d0			; add internal water height without surface sway
		move.w	d0,(v_waterpos1).w			; set water height including surface sway

		move.w	(v_waterpos1).w,d0			; get water height including surface sway again (could've used d0 again...)
		sub.w	(v_screenposy).w,d0			; subtract current camera Y-position
		bhs.s	.checkWaterVisible			; if water is below top of screen, branch
		tst.w	d0					; check result again (redundant)
		bpl.s	.checkWaterVisible			; if water is below top of screen, branch
		move.b	#223,(v_hblank_line).w			; HBlank interrupt every 224 scanlines (starts at 0)
		move.b	#1,(f_wtr_state).w			; set screen is all underwater

	.checkWaterVisible:
		cmpi.w	#223,d0					; is water within 223 pixels of top of screen?
		blo.s	.setHBlankLine				; if yes, branch
		move.w	#223,d0					; HBlank interrupt every 224 scanlines (starts at 0)

	.setHBlankLine:
		move.b	d0,(v_hblank_line).w			; set chosen HBlank trigger scanline for swapping to underwater palette

	.return:
		rts						; return
; End of function LZWaterFeatures


; ===========================================================================
; Initial water heights now come from WaterData (see _inc/Water Data.asm).

