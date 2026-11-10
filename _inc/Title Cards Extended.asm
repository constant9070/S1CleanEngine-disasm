; --- Extended Sonic 1 Title Cards System (AS Version) ---
; * Created by Selbi
; * AS port and Level/SS result screens extension by RobiWanKenobi
; * Lowercase letters taken from "Yuu Yuu Hakusho: Makyou Toitsusen"
; * Missing uppercase letter graphics "JQVWX" by SameyTheHedgie
; * Titlecase "Act" and fixed lowercase "a" graphics by MDTravis
; * Act "4" number graphics by Cinossu
; See also: https://www.deviantart.com/sameythehedgie/art/s1cardext-846313458

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone title card definitions. Stipulations:
; - All letters from the English alphabet are supported
; - Uppercase AND lowercase letters are supported
; - Maximum length 20 characters
; - ZONE text must be 5 characters or less
; - Sonic Has & Passed Text Combined must 20 or fewer characters
; - Special Stage Results Text must only be 20 characters or less
; ---------------------------------------------------------------------------

TitleCard_GHZ1:	equ "Green Hill"
TitleCard_GHZ2:	equ "Sunset Hill"
TitleCard_GHZ3:	equ "Night Hill"
TitleCard_GHZ4:	equ "Classic Hill"

TitleCard_Zone:	equ "Zone"
TitleCard_UseLowerAct: equ 1	; 0 = ACT // 1 = Act

; ---------------------------------------------------------------------------

TitleCard_SonicHas:	equ "Sonic Has"
TitleCard_Passed:	equ "Passed"

TitleCard_SpecialStage:	 equ "Special Stage"
TitleCard_ChaosEmeralds: equ "Chaos Emeralds"
TitleCard_GotThemAll:	 equ "Sonic Got Them All"

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to dynamically load title card letters into VRAM.
; Also see the related macro below.
; ---------------------------------------------------------------------------

TTL_LetterTiles:	equ 4	; tile count for a single letter (16x16 sprite)
TTL_NumberTiles:	equ 6	; tile count for an act number (16x24 sprite)
TTL_ActTxtTiles:	equ 3	; tile count for the act text (8x24 sprite)
TTL_OvalTiles:		equ 16	; tiles used by the blue oval (repurposed)
TTL_SmallOvalTiles:	equ 2	; tiles used by the blue oval (repurposed)
TTL_BonuTiles:		equ 8	; tiles used by the "BONU" results letters
SonicHasPassed_Tiles:	equ TTL_LetterTiles*(strlen(TitleCard_SonicHas) + strlen(TitleCard_Passed))

TTL_BONU:		equ TTL_OvalTiles+TTL_ActTxtTiles+SonicHasPassed_Tiles+2
TTL_SmOval:		equ TTL_BONU+TTL_BonuTiles
TTL_SmOvalSSR:		equ TTL_OvalTiles+100+TTL_BonuTiles+TTL_SmallOvalTiles

TTL_Numbers:		equ ("Z"-"A"+1)*TTL_LetterTiles*tile_size
TTL_ActText:		equ ("z"-"A"+1)*TTL_LetterTiles*tile_size+(TTL_ActTxtTiles*TitleCard_UseLowerAct*tile_size)
TTL_BlueOval:		equ ((("z"-"A"+1)*TTL_LetterTiles)+TTL_ActTxtTiles*2)*tile_size
TTL_EOL:		equ (((("z"-"A"+1)*TTL_LetterTiles)+TTL_ActTxtTiles*2)+TTL_OvalTiles)*tile_size
; ---------------------------------------------------------------------------

TitleCards_LoadArt:
		move.w	sr,-(sp)
		disable_ints

		; blue oval, act text, act number
		bsr.w	TTL_LoadMainPatterns

		; zone text
		lea	TTLCard_Zone_Array(pc),a2
		bsr.w	TTL_WriteLetters

		; letters
		moveq	#0,d0
		move.b	(v_zone).w,d0
		add.w	d0,d0
		add.w	d0,d0
		add.b	(v_act).w,d0
		lsl.b	#3,d0
		lea	TTL_ConData(pc),a2
		movea.l	4(a2,d0.w),a2
		bsr.w	TTL_WriteLetters

		move.w	(sp)+,sr
		rts

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; "Sonic Has Passed" title cards loading subroutine
; ---------------------------------------------------------------------------

Got_LoadArt:
		move.w	sr,-(sp)
		disable_ints

		; blue oval, act text, act number
		bsr.w	TTL_LoadMainPatterns

		; "Sonic Has" text
		lea	TTLCard_Got_SonicHas_Array(pc),a2
		bsr.w	TTL_WriteLetters

		; "Passed" text
 		lea	TTLCard_Got_Passed_Array(pc),a2
		bsr.w	TTL_WriteLetters

		; "BONU" and small oval
		lea	(Unc_TitleCard+TTL_EOL).l,a1
		moveq	#(TTL_SmallOvalTiles+TTL_BonuTiles)-1,d1
		bsr.w	TTL_LoadTiles

		move.w	(sp)+,sr
		rts

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Special Stage Results title cards loading subroutine
; ---------------------------------------------------------------------------

SpecStagResults_LoadArt:
		move.w	sr,-(sp)
		disable_ints

		; blue oval
		bsr.w	TTL_SetBaseAndLoadOval

		; header text, depending on emerald count
		lea	TTLCard_SSR_SpeStage_Array(pc),a2 ; no emeralds
		tst.b	(v_emeralds).w
		beq.s	.loadSSR
		lea	TTLCard_SSR_Chaos_Array(pc),a2	  ; some emeralds
		cmpi.b	#ss_emeralds_num,(v_emeralds).w
		blo.s	.loadSSR
		lea	TTLCard_SSR_GotAll_Array(pc),a2	  ; all emeralds
.loadSSR:
		bsr.s	TTL_WriteLetters

		locVRAM	(ArtTile_Title_Card+(17*4)+5+TTL_NumberTiles+TTL_ActTxtTiles+TTL_OvalTiles+20)*tile_size
		lea	(Unc_TitleCard+TTL_EOL).l,a1
		moveq	#(TTL_SmallOvalTiles+TTL_BonuTiles)-1,d1
		bsr.s	TTL_LoadTiles

		move.w	(sp)+,sr
		rts

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Helper subroutines
; ---------------------------------------------------------------------------

TTL_WriteLetters:
		move.l	#Unc_TitleCard,d4	; load base art offset
	.loop:	moveq	#0,d2			; clear d2
		move.b	(a2)+,d2		; get next letter from array
		beq.s	.done			; if it's 0, end
		cmpi.b	#' ',d2			; is it a space?
		beq.s	.loop			; if yes, go to next char
		subi.b	#'A',d2			; make letters 0-based
		lsl.l	#7,d2			; multiply by $40
		add.l	d4,d2			; add title card art offset
		movea.l	d2,a1			; write final offset to a1
		moveq	#TTL_LetterTiles-1,d1	; four tiles per letter
		bsr.s	TTL_LoadTiles		; write tiles to VRAM
		bra.s	.loop			; loop until all letters are written
	.done:	rts

; ---------------------------------------------------------------------------

TTL_LoadTiles:
		move.l	(a1)+,(a6)
		move.l	(a1)+,(a6)
		move.l	(a1)+,(a6)
		move.l	(a1)+,(a6)
		move.l	(a1)+,(a6)
		move.l	(a1)+,(a6)
		move.l	(a1)+,(a6)
		move.l	(a1)+,(a6)
		dbf	d1,TTL_LoadTiles
		rts

; ---------------------------------------------------------------------------

TTL_LoadMainPatterns:
		; blue oval
		bsr.s	TTL_SetBaseAndLoadOval

		; act text
		lea	(Unc_TitleCard+TTL_ActText).l,a1
		moveq	#TTL_ActTxtTiles-1,d1
		bsr.w	TTL_LoadTiles

		; act number
		lea	(Unc_TitleCard+TTL_Numbers).l,a1
		moveq	#0,d0
		move.b	(v_act).w,d0
		cmpi.w	#id_LZ_act4,(v_zone).w	; is this specifically SBZ3 (LZ4)?
		bne.s	.load			; if not, branch
		subq.b	#1,d0			; force to use act 3 number instead of 4
	.load:	mulu.w	#TTL_NumberTiles*tile_size,d0
		adda.w	d0,a1
		moveq	#TTL_NumberTiles-1,d1
		bra.s	TTL_LoadTiles

; ---------------------------------------------------------------------------

TTL_SetBaseAndLoadOval:
		lea	(vdp_data_port).l,a6
		locVRAM	ArtTile_Title_Card*tile_size

		lea	(Unc_TitleCard+TTL_BlueOval).l,a1
		moveq	#TTL_OvalTiles-1,d1
		bra.s	TTL_LoadTiles


; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Macro to generate title card data dynamically:
; sprite mappings, letter loading array, and ConData
; ---------------------------------------------------------------------------

maketitlecard:	macro textline,hideAct,specialTileOffset,{INTLABEL}
__LABEL__:	label *

		; length check
		set len, strlen(textline)
		if len>20
			fatal "maximum length is 20 characters"
		endif

		; calculate sprite count and width
		set useSmallSpaces, 0
		set sizeX, $00
		set spaces, 0
		set i, 0
		while (i<len)
			set char, substr(textline,i,1)

			set sizeX, sizeX+$10
			if (char=' ')
				if (useSmallSpaces)
					set sizeX, sizeX-$08 ; small spaces are 8px smaller
				endif
				set spaces, spaces+1
			elseif (char='I')
				set sizeX, sizeX-8
			elseif (char>='a')&(char<='z')
				if (char='i')|(char='j')|(char='l')
					set sizeX, sizeX-7
				else
					set sizeX, sizeX-2
				endif
			endif
			set i, i+1

			if ((sizeX>$FF)&(useSmallSpaces<>1))
				set useSmallSpaces, 1
				set sizeX, $00
				set spaces, 0
				set i, 0
				; retry with small spaces
			endif
		endm
		dc.b len-spaces

		; special tile offset for zone text
		if specialTileOffset>0
			if specialTileOffset<>2 ; special tile offset for passed text
				if specialTileOffset<>3 ; special tile offset for passed text
					set tile, TTL_OvalTiles+TTL_ActTxtTiles+TTL_NumberTiles
				else
					set tile, TTL_OvalTiles
				endif
			else
				set tile, TTL_OvalTiles+TTL_ActTxtTiles+TTL_NumberTiles+((strlen(TitleCard_SonicHas)-1)*TTL_LetterTiles)
			endif
		else
			set tile, TTL_OvalTiles+TTL_ActTxtTiles+TTL_NumberTiles+(strlen(TitleCard_Zone)*TTL_LetterTiles)

		endif

		; write per-letter sprite mappings
		set x, $08-(sizeX/2)
		if specialTileOffset<>2
			set x, x-8 ; move "Passed" text forward by 1 tile
		endif

		set i, 0
		while (i<len)
			set char, substr(textline,i,1)

			set addX, $10
			if (char=' ')
				; space
				if (useSmallSpaces)
					set addX, addX-8
				endif
			elseif (char>='A')&(char<='z')
				set yOffset, 0
				if (char='p')|(char='q')|(char='y')
					set yOffset, 5
				elseif (char='g')
					set yOffset, 2
				endif
				dc.b ($F8+yOffset)&$FF, $05, $00, tile, x
				set tile, tile+4
				if (char>='a')&(char<='z')
					if (char='i')|(char='j')|(char='l')
						set addX, addX-7
					else
						set addX, addX-2
					endif
				elseif (char='I')
					set addX, 8
				endif
			else
				fatal "illegal char '\{char}' in \{textline}"
			endif
			set x, (x+addX)&$FF

			set i, i+1
		endm
		even

__LABEL___Array: label *	; create tile VRAM load array
		set i, 0
		while (i<len)
			set char, substr(textline,i,1)
			dc.b char
			set i, i+1
		endm
		dc.b 0
		even

__LABEL___ConData: label *	; create ConData
		if hideAct<>0
			set noActAdjust, $10
		else
			set noActAdjust, 0
		endif
		set name_target, $0120
		set name_start, $0000
		set zone_target, $00F0+(sizeX/2)+noActAdjust
		set zone_start, zone_target-$0240+noActAdjust
		set oval_target, zone_target+$0018-noActAdjust
		set oval_start, oval_target+$00C0
		if hideAct<>0
			set act_target, $03EC
			set act_start, act_target
		else
			set act_target, oval_target
			set act_start, act_target+$02C0
		endif

		dc.w name_start&$FFFF, name_target&$FFFF
		dc.w zone_start&$FFFF, zone_target&$FFFF
		dc.w  act_start&$FFFF,  act_target&$FFFF
		dc.w oval_start&$FFFF, oval_target&$FFFF
	endm

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Sprite mappings - Extended zone title cards including full alphabet.
; These are dynamically generated by the above macro.
; Act numbers and the oval had to be redesigned to accomedate for the new
; VRAM layout, and EOL and SSR both still require the old text.
; ---------------------------------------------------------------------------

Map_Card:	mappingsTable
	mappingsTableEntry.w	TTLCard_GHZ1	; Green Hill Zone 1
	mappingsTableEntry.w	TTLCard_GHZ2	; Green Hill Zone 2
	mappingsTableEntry.w	TTLCard_GHZ3	; Green Hill Zone 3
	mappingsTableEntry.w	TTLCard_GHZ4	; Green Hill Zone 4
	zonewarning Map_Card,4*2
	mappingsTableEntry.w	TTLCard_Zone	; "ZONE" text
	mappingsTableEntry.w	TTLCard_Act	; Act number
	mappingsTableEntry.w	TTLCard_Oval	; Blue oval

TTLCard_GHZ1:	maketitlecard TitleCard_GHZ1,0,0
TTLCard_GHZ2:	maketitlecard TitleCard_GHZ2,0,0
TTLCard_GHZ3:	maketitlecard TitleCard_GHZ3,0,0
TTLCard_GHZ4:	maketitlecard TitleCard_GHZ4,0,0
TTLCard_Zone:	maketitlecard TitleCard_Zone,1,1	; ZONE label (alternate tile offset)

TTLCard_Act:	spriteHeader	; "ACT" and number 1/2/3/4
	spritePiece	-$14, 4, 3, 1, TTL_OvalTiles, 0, 0, 0, 0
	spritePiece	 $08, -$C, 2, 3, TTL_OvalTiles+TTL_ActTxtTiles, 0, 0, 0, 0
TTLCard_Act_End

TTLCard_Oval:	spriteHeader	; Blue oval, updated tile offsets
	spritePiece	 -$C, -$1C, 4, 1, $00, 0, 0, 0, 0
	spritePiece	 $14, -$1C, 1, 3, $04, 0, 0, 0, 0
	spritePiece	-$14, -$14, 2, 1, $07, 0, 0, 0, 0
	spritePiece	 -$1C, -$C, 2, 2, $09, 0, 0, 0, 0
	spritePiece	 -$14, $14, 4, 1, $00, 1, 1, 0, 0
	spritePiece	   -$1C, 4, 1, 3, $04, 1, 1, 0, 0
	spritePiece 	     4, $C, 2, 1, $07, 1, 1, 0, 0
	spritePiece	    $C, -4, 2, 2, $09, 1, 1, 0, 0
	spritePiece	  -4, -$14, 3, 1, $0D, 0, 0, 0, 0
	spritePiece	  -$C, -$C, 4, 1, $0C, 0, 0, 0, 0
	spritePiece	   -$C, -4, 3, 1, $0C, 0, 0, 0, 0
	spritePiece	   -$14, 4, 4, 1, $0C, 0, 0, 0, 0
	spritePiece	  -$14, $C, 3, 1, $0C, 0, 0, 0, 0
TTLCard_Oval_End
	even

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Configuration data and dynamic letter loading index, generated by the macro
; ---------------------------------------------------------------------------

TTL_ConData:
	dc.l TTLCard_GHZ1_ConData, TTLCard_GHZ1_Array	; GHZ1
	dc.l TTLCard_GHZ2_ConData, TTLCard_GHZ2_Array	; GHZ2
	dc.l TTLCard_GHZ3_ConData, TTLCard_GHZ3_Array	; GHZ3
	dc.l TTLCard_GHZ4_ConData, TTLCard_GHZ4_Array	; GHZ4

	zonewarning TTL_ConData,4*2*4
	even

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Sprite mappings - Extended "Sonic Has Passed" title cards.
; ---------------------------------------------------------------------------

Map_Got:	mappingsTable
	mappingsTableEntry.w	TTLCard_Got_SonicHas
	mappingsTableEntry.w	TTLCard_Got_Passed
	mappingsTableEntry.w	TTLCard_Got_Score
	mappingsTableEntry.w	TTLCard_Got_TBonus
	mappingsTableEntry.w	TTLCard_Got_RBonus
	mappingsTableEntry.w	TTLCard_Oval
	mappingsTableEntry.w	TTLCard_Act
	mappingsTableEntry.w	TTLCard_Act
	mappingsTableEntry.w	TTLCard_Act
	mappingsTableEntry.w	TTLCard_Act

TTLCard_Got_SonicHas:	maketitlecard TitleCard_SonicHas,1,1
TTLCard_Got_Passed:	maketitlecard TitleCard_Passed,1,2

TTLCard_Got_Score:	spriteHeader		; SCORE
	spritePiece	-$50, -8, 4, 2, $14A, 0, 0, 0, 0	; "SCOR"
	spritePiece	-$30, -8, 1, 2, $160, 0, 0, 0, 0	; "E"
	spritePiece	-$33, -9, 2, 1, TTL_SmOval, 0, 0, 0, 0	; Small oval (upper half)
	spritePiece	-$34, -1, 2, 1, TTL_SmOval, 1, 1, 0, 0	; Small oval (lower half)
	spritePiece	 $18, -8, 3, 2, $164, 0, 0, 0, 0	; Tally (first four digits)
	spritePiece	 $30, -8, 4, 2, $16A, 0, 0, 0, 0	; Tally (last four digits)
TTLCard_Got_Score_End

TTLCard_Got_TBonus:	spriteHeader		; TIME BONUS
	spritePiece	-$50, -8, 4, 2, $15A, 0, 0, 0, 0	; "TIME"
	spritePiece	-$27, -7, 4, 2, TTL_BONU, 0, 0, 0, 0	; "BONU"
	spritePiece	-$07, -8, 1, 2, $14A, 0, 0, 0, 0	; "S"
	spritePiece	-$0A, -9, 2, 1, TTL_SmOval, 0, 0, 0, 0	; Small oval (upper half)
	spritePiece	-$0B, -1, 2, 1, TTL_SmOval, 1, 1, 0, 0	; Small oval (lower half)
	spritePiece	 $28, -$8, 4, 2, -$10, 0, 0, 0, 0	; Tally (first four digits)
	spritePiece	 $48, -8, 1, 2, $170, 0, 0, 0, 0	; Tally (last four digits)
TTLCard_Got_TBonus_End

TTLCard_Got_RBonus:	spriteHeader		; RING BONUS
	spritePiece	-$50, -8, 4, 2, $152, 0, 0, 0, 0	; "RING"
	spritePiece	-$27, -7, 4, 2, TTL_BONU, 0, 0, 0, 0	; "BONU"
	spritePiece	-$07, -8, 1, 2, $14A, 0, 0, 0, 0	; "S"
	spritePiece	-$0A, -9, 2, 1, TTL_SmOval, 0, 0, 0, 0	; Small oval (upper half)
	spritePiece	-$0B, -1, 2, 1, TTL_SmOval, 1, 1, 0, 0	; Small oval (lower half)
	spritePiece	 $28, -$8, 4, 2, -8, 0, 0, 0, 0		; Tally (first four digits)
	spritePiece	 $48, -8, 1, 2, $170, 0, 0, 0, 0	; Tally (last four digits)
TTLCard_Got_RBonus_End
	even

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Sprite mappings - Extended Special Stage Results title cards.
; ---------------------------------------------------------------------------

Map_SSR:	mappingsTable
	mappingsTableEntry.w	TTLCard_SSR_Chaos	; "CHAOS EMERLADS" text
	mappingsTableEntry.w	TTLCard_SSR_Score	; Score tally
	mappingsTableEntry.w	TTLCard_SSR_Ring	; Ring Bonus tally
	mappingsTableEntry.w	TTLCard_Oval		; Blue oval (cross-referended from the regular title card mappings)
	mappingsTableEntry.w	TTLCard_SSR_ContSon1	; Continue tally with mini Sonic (foot down)
	mappingsTableEntry.w	TTLCard_SSR_ContSon2	; Continue tally with mini Sonic (foot up)
	mappingsTableEntry.w	TTLCard_SSR_Continue	; Continue tally without mini Sonic
	mappingsTableEntry.w	TTLCard_SSR_SpeStage	; "SPECIAL STAGE" text
	mappingsTableEntry.w	TTLCard_SSR_GotAll	; "SONIC GOT THEM ALL" text

TTLCard_SSR_Chaos:	maketitlecard TitleCard_ChaosEmeralds,1,3
TTLCard_SSR_SpeStage:	maketitlecard TitleCard_SpecialStage,1,3
TTLCard_SSR_GotAll:	maketitlecard TitleCard_GotThemAll,1,3

TTLCard_SSR_Score:	spriteHeader	; Score tally
	spritePiece	-$50, -8, 4, 2, $14A, 0, 0, 0, 0	; "SCOR"
	spritePiece	-$30, -8, 1, 2, $162, 0, 0, 0, 0	; "E"
	spritePiece	-$33, -9, 2, 1, TTL_SmOvalSSR, 0, 0, 0, 0	; Small oval (upper half)
	spritePiece	-$34, -1, 2, 1, TTL_SmOvalSSR, 1, 1, 0, 0	; Small oval (lower half)
	spritePiece	 $18, -8, 3, 2, $164, 0, 0, 0, 0	; Tally (first four digits)
	spritePiece	 $30, -8, 4, 2, $16A, 0, 0, 0, 0	; Tally (last four digits)
TTLCard_SSR_Score_End

TTLCard_SSR_Ring:	spriteHeader	; Ring Bonus tally
	spritePiece	-$50, -8, 4, 2, $152, 0, 0, 0, 0	; "RING"
	spritePiece	-$27, -7, 4, 2, TTL_SmOvalSSR-TTL_BonuTiles, 0, 0, 0, 0 ; "BONU"
	spritePiece	-$07, -8, 1, 2, $14A, 0, 0, 0, 0	; "S"
	spritePiece	-$0A, -9, 2, 1, TTL_SmOvalSSR, 0, 0, 0, 0 ; Small oval (upper half)
	spritePiece	-$0B, -1, 2, 1, TTL_SmOvalSSR, 1, 1, 0, 0 ; Small oval (lower half)
	spritePiece	 $28, -8, 4, 2, -8, 0, 0, 0, 0		; Tally (first four digits)
	spritePiece	 $48, -8, 1, 2, $170, 0, 0, 0, 0	; Tally (last four digits)
TTLCard_SSR_Ring_End

TTLCard_SSR_ContSon1:	spriteHeader	; Continue tally with mini Sonic (foot down)
	spritePiece	-$50, -8, 4, 2, -$2F, 0, 0, 0, 0	; "CONT"
	spritePiece	-$30, -8, 4, 2, -$27, 0, 0, 0, 0	; "INUE" and small oval (left half)
	spritePiece	-$10, -8, 1, 2, -$1F, 0, 0, 0, 0	; Small oval (right half)
	spritePiece	 $40, -8, 2, 3, -$1D, 0, 0, 1, 0	; Mini Sonic (foot down)
TTLCard_SSR_ContSon1_End

TTLCard_SSR_ContSon2:	spriteHeader	; Continue tally with mini Sonic (foot up)
	spritePiece	-$50, -8, 4, 2, -$2F, 0, 0, 0, 0	; "CONT"
	spritePiece	-$30, -8, 4, 2, -$27, 0, 0, 0, 0	; "INUE" and small oval (left half)
	spritePiece	-$10, -8, 1, 2, -$1F, 0, 0, 0, 0	; Small oval (right half)
	spritePiece	 $40, -8, 2, 3, -$17, 0, 0, 1, 0	; Mini Sonic (foot up)
TTLCard_SSR_ContSon2_End

TTLCard_SSR_Continue:	spriteHeader	; Continue tally without mini Sonic
	spritePiece	-$50, -8, 4, 2, -$2F, 0, 0, 0, 0	; "CONT"
	spritePiece	-$30, -8, 4, 2, -$27, 0, 0, 0, 0	; "INUE" and small oval (left half)
	spritePiece	-$10, -8, 1, 2, -$1F, 0, 0, 0, 0	; Small oval (right half)
TTLCard_SSR_Continue_End
	even

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Extended uncompressed title card letter data. Letter art is arranged so
; that A-Z and a-z have ASCII-compliant distance between them. The gap is
; filled with the act numbers. 1 has been widened to for ease of use.
; "Act" text comes after lowercase z, and oval art right after that, and
; lastly the "BONU" and small oval used for results screens.
; ---------------------------------------------------------------------------
Unc_TitleCard:	incbin	"artunc/Title Cards Extended.unc"
		even
; ---------------------------------------------------------------------------
; ===========================================================================
