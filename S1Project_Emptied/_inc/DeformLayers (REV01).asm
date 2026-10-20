; ===========================================================================
; ---------------------------------------------------------------------------
; Background layer deformation subroutines
; ---------------------------------------------------------------------------

DeformLayers:
		tst.b	(f_nobgscroll).w			; is scrolling disabled?
		beq.s	.bgscroll				; if not, branch
		rts	
; ===========================================================================

	.bgscroll:
		clr.w	(v_fg_scroll_flags).w			; clear all redraw flags
		clr.w	(v_bg1_scroll_flags).w
		clr.w	(v_bg2_scroll_flags).w
		clr.w	(v_bg3_scroll_flags).w

		bsr.w	ScrollHoriz				; update camera position & redraw flags
		bsr.w	ScrollVertical
		bsr.w	DynamicLevelEvents			; update level boundaries, load bosses etc.

		move.w	(v_screenposy).w,(v_scrposy_vdp).w	; v_scrposy_vdp is sent to VSRAM during VBlank
		move.w	(v_bgscreenposy).w,(v_bgscrposy_vdp).w

		moveq	#0,d0
		move.b	(v_zone).w,d0				; get zone number
		add.w	d0,d0					; multiply by 2
		move.w	Deform_Index(pc,d0.w),d0
		jmp	Deform_Index(pc,d0.w)			; goto relevant deformation code
; End of function DeformLayers

; ===========================================================================
; ---------------------------------------------------------------------------
; Offset index for background layer deformation	code
; ---------------------------------------------------------------------------
Deform_Index:
		dc.w Deform_GHZ-Deform_Index
		zonewarning Deform_Index,2
		dc.w Deform_GHZ-Deform_Index

; ===========================================================================
; ---------------------------------------------------------------------------
; Green	Hill Zone background layer deformation code
; ---------------------------------------------------------------------------

Deform_GHZ:
; REV01 - additional scrolling for clouds

		; block 3 - distant mountains
		move.w	(v_scrshiftx).w,d4			; get camera x pos change since last frame
		ext.l	d4
		asl.l	#5,d4
		move.l	d4,d1
		asl.l	#1,d4
		add.l	d1,d4					; multiply by $60
		moveq	#0,d6
		bsr.w	BGScroll_Block3			; update bg x pos and set redraw flags

		; block 2 - hills & waterfalls
		move.w	(v_scrshiftx).w,d4			; get camera x pos change since last frame
		ext.l	d4
		asl.l	#7,d4					; multiply by $80
		moveq	#0,d6
		bsr.w	BGScroll_Block2			; update bg x pos and set redraw flags

		; calculate Y position
		lea	(v_hscrolltablebuffer).w,a1
		move.w	(v_screenposy).w,d0			; get camera pos
		andi.w	#$7FF,d0				; maximum $7FF
		lsr.w	#5,d0					; divide by $20
		neg.w	d0
		addi.w	#$20,d0
		bpl.s	.limitY					; branch if v_screenposy is between 0 and $400
		moveq	#0,d0					; use 0 if greater
	.limitY:
		move.w	d0,d4
		move.w	d0,(v_bgscrposy_vdp).w			; update bg y pos

		; get FG X position (force 0 on title screen)
		move.w	(v_screenposx).w,d0			; use regular camera X-position as input
		cmpi.b	#id_Title,(v_gamemode).w		; are we on the title screen?
		bne.s	.notTitle				; if not, branch
		moveq	#0,d0					; force FB X-position to 0 at all times (to keep Title Screen emblem in place)
	.notTitle:
		neg.w	d0
		swap	d0

		; auto-scroll clouds
		lea	(v_bgscroll_buffer).w,a2
		addi.l	#$10000,(a2)+				; autoscroll upper cloud fastest
		addi.l	#$C000,(a2)+
		addi.l	#$8000,(a2)+

		; calculate background scroll
		move.w	(v_bgscroll_buffer).w,d0		; get autoscroll position of upper cloud
		add.w	(v_bg3screenposx).w,d0			; add current bg position
		neg.w	d0					; reverse
		move.w	#32-1,d1
		sub.w	d4,d1
		bcs.s	.gotoCloud2
	.cloudLoop1:						; upper cloud (32px)
		move.l	d0,(a1)+				; write to v_hscrolltablebuffer
		dbf	d1,.cloudLoop1

	.gotoCloud2:
		move.w	(v_bgscroll_buffer+4).w,d0		; get autoscroll position of middle cloud
		add.w	(v_bg3screenposx).w,d0			; add current bg position
		neg.w	d0					; reverse
		move.w	#16-1,d1
	.cloudLoop2:						; middle cloud (16px)
		move.l	d0,(a1)+				; write to v_hscrolltablebuffer
		dbf	d1,.cloudLoop2

		move.w	(v_bgscroll_buffer+8).w,d0		; get autoscroll position of lower cloud
		add.w	(v_bg3screenposx).w,d0			; add current bg position
		neg.w	d0					; reverse
		move.w	#16-1,d1
	.cloudLoop3:						; lower cloud (16px)
		move.l	d0,(a1)+				; write to v_hscrolltablebuffer
		dbf	d1,.cloudLoop3

		; mountains
		move.w	#48-1,d1
		move.w	(v_bg3screenposx).w,d0
		neg.w	d0
	.mountainLoop:						; distant mountains (48px)
		move.l	d0,(a1)+
		dbf	d1,.mountainLoop

		; hills and waterfalls
		move.w	#40-1,d1
		move.w	(v_bg2screenposx).w,d0
		neg.w	d0
	.hillLoop:						; hills & waterfalls (40px)
		move.l	d0,(a1)+
		dbf	d1,.hillLoop

		; water
		move.w	(v_bg2screenposx).w,d0
		move.w	(v_screenposx).w,d2
		sub.w	d0,d2
		ext.l	d2
		asl.l	#8,d2
		divs.w	#$68,d2
		ext.l	d2
		asl.l	#8,d2
		moveq	#0,d3
		move.w	d0,d3
		move.w	#72-1,d1
		add.w	d4,d1
	.waterLoop:
		move.w	d3,d0
		neg.w	d0
		move.l	d0,(a1)+
		swap	d3
		add.l	d2,d3
		swap	d3
		dbf	d1,.waterLoop
		rts
; End of function Deform_GHZ


	; ScrollHoriz and ScrollVertical camera position update subroutines.
	; Extracted into a separate file because they are only tangentially
	; related to background deformation, and identical in REV00 and REV01.
	; (This file includes MoveScreenHoriz!)
	include	"_inc/ScrollHoriz & ScrollVertical.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to	update bg position and redraw flags
; 
; input:
;	d4 = background x-diff
;	d5 = background y-diff
; ---------------------------------------------------------------------------

; ScrollBlock1:
BGScroll_XY:
		move.l	(v_bgscreenposx).w,d2
		move.l	d2,d0					; save old bg position
		add.l	d4,d0					; apply difference
		move.l	d0,(v_bgscreenposx).w			; update bg position
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	(v_bg1_xblock).w,d3
		eor.b	d3,d1
		bne.s	BGScroll_YRelative				; insufficient change to redraw bg
		eori.b	#$10,(v_bg1_xblock).w
		sub.l	d2,d0					; new bg pos minus old
		bpl.s	.redraw_right				; branch if positive (i.e. moving right)
		bset	#2,(v_bg1_scroll_flags).w
		bra.s	BGScroll_YRelative

	.redraw_right:
		bset	#3,(v_bg1_scroll_flags).w
		; Fall-through to BGScroll_YRelative...
; ---------------------------------------------------------------------------

; loc_679C:
BGScroll_YRelative:
		move.l	(v_bgscreenposy).w,d3
		move.l	d3,d0
		add.l	d5,d0
		move.l	d0,(v_bgscreenposy).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	(v_bg1_yblock).w,d2
		eor.b	d2,d1
		bne.s	.return
		eori.b	#$10,(v_bg1_yblock).w
		sub.l	d3,d0
		bpl.s	.redraw_bottom
		bset	#0,(v_bg1_scroll_flags).w
		rts

	.redraw_bottom:
		bset	#1,(v_bg1_scroll_flags).w

	.return:
		rts
; End of function BGScroll_XY
; ===========================================================================

; ScrollBlock2: Bg_Scroll_Y:
BGScroll_Y:
		move.l	(v_bgscreenposy).w,d3
		move.l	d3,d0
		add.l	d5,d0
		move.l	d0,(v_bgscreenposy).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	(v_bg1_yblock).w,d2
		eor.b	d2,d1
		bne.s	.return
		eori.b	#$10,(v_bg1_yblock).w
		sub.l	d3,d0
		bpl.s	.redraw_bottom
		bset	#4,(v_bg1_scroll_flags).w
		rts

	.redraw_bottom:
		bset	#5,(v_bg1_scroll_flags).w

	.return:
		rts
; End of function BGScroll_Y

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to	update bg y position and redraw flags
; 
; input:
;	d0 = new background y position
; ---------------------------------------------------------------------------

; ScrollBlock3:
BGScroll_YAbsolute:
		move.w	(v_bgscreenposy).w,d3			; save old bg position
		move.w	d0,(v_bgscreenposy).w			; update bg position
		move.w	d0,d1
		andi.w	#$10,d1
		move.b	(v_bg1_yblock).w,d2
		eor.b	d2,d1
		bne.s	.return
		eori.b	#$10,(v_bg1_yblock).w
		sub.w	d3,d0
		bpl.s	.redraw_bottom
		bset	#0,(v_bg1_scroll_flags).w
		rts

	.redraw_bottom:
		bset	#1,(v_bg1_scroll_flags).w

	.return:
		rts
; End of function BGScroll_YAbsolute

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutines to update bg position and redraw flags for bg blocks 1, 2 and 3
; 
; input:
;	d4 = background x diff
;	d6 = bit to set for redraw direction
; ---------------------------------------------------------------------------

BGScroll_Block1:
		move.l	(v_bgscreenposx).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(v_bgscreenposx).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	(v_bg1_xblock).w,d3
		eor.b	d3,d1
		bne.s	.return
		eori.b	#$10,(v_bg1_xblock).w
		sub.l	d2,d0
		bpl.s	.scrollRight
		bset	d6,(v_bg1_scroll_flags).w
		bra.s	.return

	.scrollRight:
		addq.b	#1,d6
		bset	d6,(v_bg1_scroll_flags).w

	.return:
		rts
; End of function BGScroll_Block1
; ===========================================================================

BGScroll_Block2:
		move.l	(v_bg2screenposx).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(v_bg2screenposx).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	(v_bg2_xblock).w,d3
		eor.b	d3,d1
		bne.s	.return
		eori.b	#$10,(v_bg2_xblock).w
		sub.l	d2,d0
		bpl.s	.scrollRight
		bset	d6,(v_bg2_scroll_flags).w
		bra.s	.return

	.scrollRight:
		addq.b	#1,d6
		bset	d6,(v_bg2_scroll_flags).w

	.return:
		rts
; End of function BGScroll_Block2
; ===========================================================================

BGScroll_Block3:
		move.l	(v_bg3screenposx).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(v_bg3screenposx).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	(v_bg3_xblock).w,d3
		eor.b	d3,d1
		bne.s	.return
		eori.b	#$10,(v_bg3_xblock).w
		sub.l	d2,d0
		bpl.s	.scrollRight
		bset	d6,(v_bg3_scroll_flags).w
		bra.s	.return

	.scrollRight:
		addq.b	#1,d6
		bset	d6,(v_bg3_scroll_flags).w

	.return:
		rts
; End of function BGScroll_Block3
