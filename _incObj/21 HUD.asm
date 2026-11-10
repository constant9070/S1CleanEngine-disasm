  if WidescreenType
HUD_TargetXConstant	equ $80+$10-((ExtraWidth/2)+(ExtraWidth/8))	; resting position
  else
HUD_TargetXConstant equ $80+$10	; resting position
  endif

; ===========================================================================
; ---------------------------------------------------------------------------
; Object 21 - SCORE, TIME, RINGS
; ---------------------------------------------------------------------------

HUD:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	HUD_Index(pc,d0.w),d1
		jmp	HUD_Index(pc,d1.w)
; ===========================================================================
HUD_TargetX	= HUD_TargetXConstant	; resting position
HUD_SlideDist	= $60				; start this far to the left
HUD_SlideSpeed	= 2

HUD_Index:	dc.w HUD_Main-HUD_Index
		dc.w HUD_Slide-HUD_Index	; routine 4 (new)
		dc.w HUD_Flash-HUD_Index
; ===========================================================================

HUD_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)		; advance to HUD_Wait
		move.w	#HUD_TargetX-HUD_SlideDist,obX(a0)	; start off to the left
		move.w	#$80+$88,obScreenY(a0)
		move.l	#Map_HUD,obMap(a0)
		move.w	#ArtTile_HUD,obGfx(a0)
		move.b	#sprite_cam_screen,obRender(a0)
		move.b	#0,obPriority(a0)
		rts					; don't fall through, so it stays hidden
; ---------------------------------------------------------------------------

; ===========================================================================

HUD_Wait:	; Routine 2: hidden until the title card is gone
		tst.b	(v_ttlcardzone+obID).w		; <-- check this label (see below)
		bne.s	.return
		addq.b	#2,obRoutine(a0)		; advance to HUD_Slide
.return:
		rts
; ===========================================================================

HUD_Slide:	; Routine 4
		move.w	obX(a0),d0
		addq.w	#HUD_SlideSpeed,d0
		cmpi.w	#HUD_TargetX,d0
		blo.s	.move
		move.w	#HUD_TargetX,d0			; arrived: snap to final X
		addq.b	#2,obRoutine(a0)		; advance to HUD_Flash
.move:
		move.w	d0,obX(a0)
		jmp	(DisplaySprite).l
; ===========================================================================

HUD_Flash:	; Routine 2
	if FixBugs
		; Fix the HUD blinking
		; https://info.sonicretro.org/SCHG_How-to:Fix_the_HUD_blinking
		moveq	#0,d0				; use all-yellow frame by edefault
		btst	#3,(v_framebyte).w		; flash every 8 frames
		bne.s	.display			; branch on other frames
		tst.w	(v_rings).w			; do you have any rings?
		bne.s	.norings			; if so, branch
		addq.w	#1,d0				; make ring counter flash red
.norings:
	else
		tst.w	(v_rings).w			; do you have any rings?
		beq.s	.norings			; if not, branch
		clr.b	obFrame(a0)			; make all counters yellow
		jmp	(DisplaySprite).l		; display HUD
; ===========================================================================

.norings:
		moveq	#0,d0				; use all-yellow frame by default
		btst	#3,(v_framebyte).w		; flash every 8 frames
		bne.s	.display			; branch on other frames
		addq.w	#1,d0				; make ring counter flash red
	endif
		cmpi.b	#9,(v_timemin).w		; have 9 minutes elapsed?
		bne.s	.display			; if not, branch
		addq.w	#2,d0				; make time counter flash red

.display:
		move.b	d0,obFrame(a0)
		jmp	(DisplaySprite).l		; display HUD
; ===========================================================================

Map_HUD:	include	"_maps/HUD.asm"
