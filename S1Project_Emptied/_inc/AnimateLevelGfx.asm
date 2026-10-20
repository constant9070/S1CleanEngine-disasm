; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to animate level graphics
; ---------------------------------------------------------------------------

AnimateLevelGfx:
		tst.w	(f_pause).w				; is the game paused?
		bne.s	.isPaused				; if yes, branch

		lea	(vdp_data_port).l,a6			; prepare VDP data port (shared by all gfx routines)
		bsr.w	AniArt_GiantRing			; load giant ring graphics, if necessary

		moveq	#0,d0					; clear d0
		move.b	(v_zone).w,d0				; get current zone ID
		add.w	d0,d0					; double for word-based indexing
		move.w	AniArt_Index(pc,d0.w),d0		; find entry in jump table
		jmp	AniArt_Index(pc,d0.w)			; jump to animation routine for current Zone
; ---------------------------------------------------------------------------

	.isPaused:
		rts						; don't animate level gfx while paused
; End of function AnimateLevelGfx

; ===========================================================================
AniArt_Index:	dc.w AniArt_GHZ-AniArt_Index			; GHZ
		zonewarning AniArt_Index,2
		dc.w AniArt_Ending-AniArt_Index			; Ending Sequence
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Animated pattern routine - Green Hill
; ---------------------------------------------------------------------------

AniArt_GHZ:

AniArt_GHZ_Waterfall:
		.size:	= 8					; number of tiles per frame

		subq.b	#1,(v_lani0_time).w			; decrement timer
		bpl.s	AniArt_GHZ_Bigflower			; if time remains, branch 

		move.b	#6-1,(v_lani0_time).w			; time to display each frame
		lea	(Art_GhzWater).l,a1			; load waterfall patterns
		move.b	(v_lani0_frame).w,d0			; get current frame ID
		addq.b	#1,(v_lani0_frame).w			; increment frame counter
		andi.w	#1,d0					; there are only 2 frames
		beq.s	.isFrame0				; branch if frame 0
		lea	.size*tile_size(a1),a1			; use graphics for frame 1
	.isFrame0:
		locVRAM	ArtTile_GHZ_Waterfall*tile_size		; VRAM address
		move.w	#.size-1,d1				; number of 8x8 tiles
		bra.w	LoadTiles				; transfer tiles to VRAM
; ===========================================================================

AniArt_GHZ_Bigflower:
		.size:	= 16					; number of tiles per frame

		subq.b	#1,(v_lani1_time).w			; decrement timer
		bpl.s	AniArt_GHZ_Smallflower			; if time remains, branch

		move.b	#16-1,(v_lani1_time).w			; time to display each frame
		lea	(Art_GhzFlower1).l,a1			; load big flower patterns
		move.b	(v_lani1_frame).w,d0			; get current frame ID
		addq.b	#1,(v_lani1_frame).w			; increment frame counter
		andi.w	#1,d0					; there are only 2 frames
		beq.s	.isFrame0				; branch if frame 0
		lea	.size*tile_size(a1),a1			; use graphics for frame 1
	.isFrame0:
		locVRAM	ArtTile_GHZ_Big_Flower_1*tile_size	; VRAM address
		move.w	#.size-1,d1				; number of 8x8 tiles
		bra.w	LoadTiles				; transfer tiles to VRAM
; ===========================================================================

AniArt_GHZ_Smallflower:
		.size:	= 12					; number of tiles per frame

		subq.b	#1,(v_lani2_time).w			; decrement timer
		bpl.s	.return					; if time remains, branch

		move.b	#8-1,(v_lani2_time).w			; time to display each frame
		move.b	(v_lani2_frame).w,d0			; get current frame ID
		addq.b	#1,(v_lani2_frame).w			; increment frame counter
		andi.w	#3,d0					; there are 4 frames
		move.b	.flowerSeq(pc,d0.w),d0			; get current flower frame (0-2)
		btst	#0,d0					; is frame 0 or 2? (actual frame, not frame counter)
		bne.s	.isFrame1				; if not, branch
		move.b	#128-1,(v_lani2_time).w			; set longer duration for frames 0 and 2
	.isFrame1:
		lsl.w	#7,d0					; multiply frame num by $80
		move.w	d0,d1					; multiply that by 3 (i.e. frame num times 12 * $20)
		add.w	d0,d0					; ''
		add.w	d1,d0					; ''
		locVRAM	ArtTile_GHZ_Small_Flower*tile_size	; VRAM address
		lea	(Art_GhzFlower2).l,a1			; load small flower patterns
		lea	(a1,d0.w),a1				; jump to appropriate tile
		move.w	#.size-1,d1				; number of 8x8 tiles
		bsr.w	LoadTiles				; transfer tiles to VRAM

	.return:
		rts						; return
; ---------------------------------------------------------------------------

.flowerSeq:	; Sequence of frame offsets for small flowers
		dc.b 0,	1, 2, 1

; End of function AniArt_GHZ

; ===========================================================================
; ---------------------------------------------------------------------------
; Animated pattern routine - ending sequence
; ---------------------------------------------------------------------------

AniArt_Ending:

AniArt_Ending_BigFlower:
		.size:	= 16					; number of tiles per frame

		subq.b	#1,(v_lani1_time).w			; decrement timer
		bpl.s	AniArt_Ending_SmallFlower		; if time remains, branch
		
		move.b	#8-1,(v_lani1_time).w			; time to display each frame
		lea	(Art_GhzFlower1).l,a1			; load big flower patterns
		lea	(v_128x128+$20*chunk_size_128).l,a2 ; load 2nd big flower from RAM (overwriting unused chunk RAM)
		move.b	(v_lani1_frame).w,d0			; get current frame ID
		addq.b	#1,(v_lani1_frame).w			; increment frame counter
		andi.w	#1,d0					; there are only 2 frames
		beq.s	.isFrame0				; branch if frame 0
		lea	.size*tile_size(a1),a1			; load second frame
		lea	.size*tile_size(a2),a2			; ''
	.isFrame0:
		locVRAM	ArtTile_GHZ_Big_Flower_1*tile_size	; VRAM address
		move.w	#.size-1,d1				; number of 8x8 tiles
		bsr.w	LoadTiles				; transfer tiles to VRAM

		movea.l	a2,a1					; load sunflower (wall) art address
		locVRAM	ArtTile_GHZ_Big_Flower_2*tile_size	; VRAM address
		move.w	#.size-1,d1				; number of 8x8 tiles
		bra.w	LoadTiles				; transfer tiles to VRAM
; ===========================================================================

AniArt_Ending_SmallFlower:
		.size:	= 12					; number of tiles per frame

		subq.b	#1,(v_lani2_time).w			; decrement timer
		bpl.s	AniArt_Ending_Flower3			; if time remains, branch
		
		move.b	#8-1,(v_lani2_time).w			; time to display each frame
		move.b	(v_lani2_frame).w,d0			; get current frame ID3
		addq.b	#1,(v_lani2_frame).w			; increment frame counter
		andi.w	#7,d0					; there are 8 frames
		move.b	AniArt_Ending_Flower2_sequence(pc,d0.w),d0 ; get actual frame num from sequence data
		lsl.w	#7,d0					; multiply frame num by $80
		move.w	d0,d1					; multiply that by 3 (i.e. frame num times 12 * $20)
		add.w	d0,d0					; ''
		add.w	d1,d0					; ''
		locVRAM	ArtTile_GHZ_Small_Flower*tile_size	; VRAM address
		lea	(Art_GhzFlower2).l,a1			; load small flower patterns
		lea	(a1,d0.w),a1				; jump to appropriate tile
		move.w	#.size-1,d1				; number of 8x8 tiles
		bra.w	LoadTiles				; transfer tiles to VRAM
; ===========================================================================
AniArt_Ending_Flower2_sequence:
		dc.b 0, 0, 0, 1, 2, 2, 2, 1
; ===========================================================================

AniArt_Ending_Flower3:
		.size:	= 16					; number of tiles per frame

		subq.b	#1,(v_lani4_time).w			; decrement timer
		bpl.s	AniArt_Ending_Flower4			; if time remains, branch
		
		move.b	#15-1,(v_lani4_time).w			; time to display each frame
		move.b	(v_lani4_frame).w,d0			; get current frame ID
		addq.b	#1,(v_lani4_frame).w			; increment frame counter
		andi.w	#3,d0					; there are 4 frames
		move.b	AniArt_Ending_Flower3_sequence(pc,d0.w),d0 ; get actual frame num from sequence data
		lsl.w	#8,d0					; multiply by $100
		add.w	d0,d0					; multiply by 2
		locVRAM	ArtTile_GHZ_Flower_3*tile_size		; VRAM address
		lea	(v_128x128+$28*chunk_size_128).l,a1 ; load special flower patterns from RAM (overwriting unused chunk RAM)
		lea	(a1,d0.w),a1				; jump to appropriate tile
		move.w	#.size-1,d1				; number of 8x8 tiles
		bra.w	LoadTiles				; transfer tiles to VRAM
; ===========================================================================
AniArt_Ending_Flower3_sequence:
AniArt_Ending_Flower4_sequence:
		dc.b 0,	1, 2, 1
; ===========================================================================

AniArt_Ending_Flower4:
		.size:	= 16					; number of tiles per frame

		subq.b	#1,(v_lani5_time).w			; decrement timer
		bpl.s	.return					; if time remains, branch
		
		move.b	#12-1,(v_lani5_time).w			; time to display each frame
		move.b	(v_lani5_frame).w,d0			; get current frame ID
		addq.b	#1,(v_lani5_frame).w			; increment frame counter
		andi.w	#3,d0					; there are 4 frames
		move.b	AniArt_Ending_Flower4_sequence(pc,d0.w),d0 ; get actual frame num from sequence data
		lsl.w	#8,d0					; multiply by $100
		add.w	d0,d0					; multiply by 2
		locVRAM	ArtTile_GHZ_Flower_4*tile_size		; VRAM address
		lea	(v_128x128+$34*chunk_size_128).l,a1	; load special flower patterns from RAM (overwriting unused chunk RAM)
		lea	(a1,d0.w),a1				; jump to appropriate tile
		move.w	#.size-1,d1				; number of 8x8 tiles
		bra.w	LoadTiles				; transfer tiles to VRAM

	.return:
		rts						; return
; End of function AniArt_Ending


; ===========================================================================
; ---------------------------------------------------------------------------
; Animated pattern routine - zones without animated gfx (LZ, SLZ, SYZ)
; ---------------------------------------------------------------------------

AniArt_none:
		rts						; do nothing
; End of function AniArt_none


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to transfer raw tile data to VRAM
; 
; input:
; 	a1 = source address
; 	a6 = vdp_data_port ($C00000)
; 	d1 = number of tiles to transfer (minus one)
; ---------------------------------------------------------------------------

LoadTiles:
	rept 8							; 1 tile requires 8 longword transfers
		move.l	(a1)+,(a6)				; transfer 1/8th of a tile and advance source pointer
	endr
		dbf	d1,LoadTiles				; loop for number of tiles
		rts						; return
; End of function LoadTiles

; ===========================================================================
; ---------------------------------------------------------------------------
; Animated pattern routine - load uncompressed Giant Ring patterns
; The graphics are loaded incrementally at 14 tiles per frame.
; This gets triggered from GRing_Okay by setting v_gfxbigring to:
; Art_BigRing_size = 98 tiles * tile_size = $C40
; ---------------------------------------------------------------------------

AniArt_GiantRing:
		tst.w	(v_gfxbigring).w			; are giant ring graphics set to be loaded?
		bne.s	.loadTiles				; if so, get to work
		rts						; nothing to do
; ---------------------------------------------------------------------------

	.loadTiles:
		.size:	= 14					; number of tiles to load per frame

		subi.w	#.size*tile_size,(v_gfxbigring).w	; count-down the 14 tiles we're going to load now
		lea	(Art_BigRing).l,a1			; load uncompressed giant ring patterns
		moveq	#0,d0					; clear d0
		move.w	(v_gfxbigring).w,d0			; load current tile offset for giant ring patterns
		lea	(a1,d0.w),a1				; jump to appropriate tile in patterns

		; Turn VRAM address into VDP command
		addi.w	#ArtTile_Giant_Ring*tile_size,d0	; advance to starting VRAM address of giant ring
		lsl.l	#2,d0					; push upper address bits into upper word
		lsr.w	#2,d0					; send rest back
		ori.w	#$4000,d0				; set VDP mode bits (VRAM write mode)
		swap	d0					; align for VDP in order
		move.l	d0,4(a6)				; send VDP command (write to VRAM at address contained in v_gfxbigring)

		move.w	#.size-1,d1				; number of 8x8 tiles
		bra.w	LoadTiles				; transfer tiles to VRAM
; End of function AniArt_GiantRing
