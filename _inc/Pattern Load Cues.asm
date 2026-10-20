; ---------------------------------------------------------------------------
; Pattern load cues
; ---------------------------------------------------------------------------

; Macro to define PLC pointer entry
plcptr:		macro plc,{INTLABEL}
__LABEL__:	label	(*-ArtLoadCues)/2
		dc.w	plc-ArtLoadCues
		endm

; Macro for the header of a PLC list
plcheader:	macro {INTLABEL}
__LABEL__:	label	*
		dc.w ((__LABEL___end-__LABEL__-2)/6)-1
		endm

; Macro for single pattern load cue entry
plcm:		macro gfx,vram
		dc.l gfx
		dc.w (vram)*tile_size
		endm

; ---------------------------------------------------------------------------

; Index and ID definitions
ArtLoadCues:

plcid_Main:		plcptr	PLC_Main
plcid_Main2:		plcptr	PLC_Main2
plcid_Explode:		plcptr	PLC_Explode
plcid_GameOver:		plcptr	PLC_GameOver

	PLC_Levels:
plcid_GHZ:		plcptr	PLC_GHZ
plcid_GHZ2:		plcptr	PLC_GHZ2
	zonewarning PLC_Levels,4

plcid_TitleCard:	plcptr	PLC_TitleCard
plcid_Signpost:		plcptr	PLC_Signpost
plcid_Warp:		plcptr	PLC_Warp
plcid_SpecialStage:	plcptr	PLC_SpecialStage

	PLC_Animals:
plcid_GHZAnimals:	plcptr	PLC_GHZAnimals
	zonewarning PLC_Animals,2

plcid_SSResult:		plcptr	PLC_SSResult
plcid_Ending:		plcptr	PLC_Ending
plcid_TryAgain:		plcptr	PLC_TryAgain

plcid_Sega:		plcptr	PLC_Sega
plcid_TitleSonicTeam:	plcptr	PLC_TitleSonicTeam
plcid_TitleForeground:	plcptr	PLC_TitleForeground
plcid_TitleBackground:	plcptr	PLC_TitleBackground
plcid_Continue:		plcptr	PLC_Continue
plcid_Credits:		plcptr	PLC_Credits

; ---------------------------------------------------------------------------
; Pattern load cues - standard block 1
; ---------------------------------------------------------------------------
PLC_Main:	plcheader
		plcm	KosM_Lamp,	ArtTile_Lamppost		; lamppost
		plcm	KosM_Hud,	ArtTile_HUD			; HUD
		plcm	KosM_Lives,	ArtTile_Lives_Counter		; lives counter
		plcm	KosM_Sparkles, ArtTile_Sparkles    ; ring sparkles
		plcm	KosM_Points,	ArtTile_Points			; points from enemy
PLC_Main_end:

; ---------------------------------------------------------------------------
; Pattern load cues - standard block 2
; ---------------------------------------------------------------------------
PLC_Main2:	plcheader
		plcm	KosM_Monitors,	ArtTile_Monitor			; monitors
		plcm	KosM_Shield,	ArtTile_Shield			; shield
		plcm	KosM_Stars,	ArtTile_Invincibility		; invincibility stars
PLC_Main2_end:

; ---------------------------------------------------------------------------
; Pattern load cues - explosion
; ---------------------------------------------------------------------------
PLC_Explode:	plcheader
		plcm	KosM_Explode,	ArtTile_Explosion		; explosion
PLC_Explode_end:

; ---------------------------------------------------------------------------
; Pattern load cues - game/time over
; ---------------------------------------------------------------------------
PLC_GameOver:	plcheader
		plcm	KosM_GameOver,	ArtTile_Game_Over		; game/time over
PLC_GameOver_end:

; ---------------------------------------------------------------------------
; Pattern load cues - Green Hill
; ---------------------------------------------------------------------------
PLC_GHZ:	plcheader
		plcm	KosM_GHZ,	ArtTile_Level			; GHZ main patterns
		plcm	KosM_Stalk,	ArtTile_GHZ_Flower_Stalk	; flower stalk
		plcm	KosM_PplRock,	ArtTile_GHZ_Purple_Rock		; purple rock
		plcm	KosM_Crabmeat,	ArtTile_Crabmeat		; crabmeat enemy
		plcm	KosM_Buzz,	ArtTile_Buzz_Bomber		; buzz bomber enemy
		plcm	KosM_Chopper,	ArtTile_Chopper			; chopper enemy
		plcm	KosM_Newtron,	ArtTile_Newtron			; newtron enemy
		plcm	KosM_Motobug,	ArtTile_Moto_Bug		; motobug enemy
		plcm	KosM_Spikes,	ArtTile_Spikes			; spikes
		plcm	KosM_HSpring,	ArtTile_Spring_Horizontal	; horizontal spring
		plcm	KosM_VSpring,	ArtTile_Spring_Vertical		; vertical spring
PLC_GHZ_end:

PLC_GHZ2:	plcheader
		plcm	KosM_Swing,	ArtTile_GHZ_MZ_Swing		; swinging platform
		plcm	KosM_Bridge,	ArtTile_GHZ_Bridge		; bridge
		plcm	KosM_SpikePole,	ArtTile_GHZ_Spike_Pole		; spiked pole
		plcm	KosM_Ball,	ArtTile_GHZ_Giant_Ball		; giant ball
		plcm	KosM_GhzWall1,	ArtTile_GHZ_SLZ_Smashable_Wall	; breakable wall
		plcm	KosM_GhzWall2,	ArtTile_GHZ_Edge_Wall		; normal wall
PLC_GHZ2_end:

; ---------------------------------------------------------------------------
; Pattern load cues - title card
; ---------------------------------------------------------------------------
PLC_TitleCard:	plcheader
		plcm	KosM_TitleCard,	ArtTile_Title_Card
PLC_TitleCard_end:

; ---------------------------------------------------------------------------
; Pattern load cues - act 1/2 signpost
; ---------------------------------------------------------------------------
PLC_Signpost:	plcheader
		plcm	KosM_SignPost,	ArtTile_Signpost		; signpost
		plcm	KosM_Bonus,	ArtTile_Hidden_Points		; hidden bonus points
PLC_Signpost_end:

; ---------------------------------------------------------------------------
; Pattern load cues - beta special stage warp effect
; ---------------------------------------------------------------------------
PLC_Warp:
	if Revision=0
PLC_WarpRev0:	plcheader
		plcm	KosM_Warp,	ArtTile_Warp
PLC_WarpRev0_end:
	endif

; ---------------------------------------------------------------------------
; Pattern load cues - special stage
; ---------------------------------------------------------------------------
PLC_SpecialStage:	plcheader
		plcm	KosM_SSBgCloud,	ArtTile_SS_Background_Clouds	; bubble and cloud background
		plcm	KosM_SSBgFish,	ArtTile_SS_Background_Fish	; bird and fish background
		plcm	KosM_SSWalls,	ArtTile_SS_Wall			; walls
		plcm	KosM_SSGOAL,	ArtTile_SS_Goal			; GOAL block
		plcm	KosM_SSUpDown,	ArtTile_SS_Up_Down		; UP and DOWN blocks
		plcm	KosM_SSRBlock,	ArtTile_SS_R_Block		; R block
		plcm	KosM_SS1UpBlock,	ArtTile_SS_Extra_Life		; 1UP block
		plcm	KosM_SSEmStars,	ArtTile_SS_Emerald_Sparkle	; emerald collection stars
		plcm	KosM_SSRedWhite,	ArtTile_SS_Red_White_Block	; red and white block
		plcm	KosM_SSGhost,	ArtTile_SS_Ghost_Block		; ghost block
		plcm	KosM_SSWBlock,	ArtTile_SS_W_Block		; W block
		plcm	KosM_SSGlass,	ArtTile_SS_Glass		; glass block
		plcm	KosM_SSEmerald,	ArtTile_SS_Emerald		; emeralds
		plcm	KosM_SSZone1,	ArtTile_SS_Zone_1		; ZONE 1 block
		plcm	KosM_SSZone2,	ArtTile_SS_Zone_2		; ZONE 2 block
		plcm	KosM_SSZone3,	ArtTile_SS_Zone_3		; ZONE 3 block
PLC_SpecialStage_end:

		; Unused
		plcm	KosM_SSZone4,	ArtTile_SS_Zone_4		; ZONE 4 block
		plcm	KosM_SSZone5,	ArtTile_SS_Zone_5		; ZONE 5 block
		plcm	KosM_SSZone6,	ArtTile_SS_Zone_6		; ZONE 6 block

; ---------------------------------------------------------------------------
; Pattern load cues - GHZ animals
; ---------------------------------------------------------------------------
PLC_GHZAnimals:	plcheader
		plcm	KosM_Rabbit,	ArtTile_Animal_1		; rabbit
		plcm	KosM_Flicky,	ArtTile_Animal_2		; flicky
PLC_GHZAnimals_end:

; ---------------------------------------------------------------------------
; Pattern load cues - special stage results screen
; ---------------------------------------------------------------------------
PLC_SSResult:	plcheader
		plcm	KosM_ResultEm,	ArtTile_SS_Results_Emeralds	; emeralds
		plcm	KosM_MiniSonic,	ArtTile_Mini_Sonic		; mini Sonic
PLC_SSResult_end:

; ---------------------------------------------------------------------------
; Pattern load cues - ending sequence
; ---------------------------------------------------------------------------
PLC_Ending:	plcheader
		plcm	KosM_GHZ,	ArtTile_Level			; GHZ main patterns
		plcm	KosM_Stalk,	ArtTile_GHZ_Flower_Stalk	; flower stalk
		plcm	KosM_EndFlower,	ArtTile_Ending_Flowers		; flowers
		plcm	KosM_EndEm,	ArtTile_Ending_Emeralds		; emeralds
		plcm	KosM_EndSonic,	ArtTile_Ending_Sonic		; Sonic
	if Revision=0
		plcm	KosM_EndEggman,	ArtTile_Ending_Eggman		; Eggman's death (unused)
	endif
		plcm	KosM_Rabbit,	ArtTile_Ending_Rabbit		; rabbit
		plcm	KosM_Chicken,	ArtTile_Ending_Chicken		; chicken
		plcm	KosM_Penguin,	ArtTile_Ending_Penguin		; penguin
		plcm	KosM_Seal,	ArtTile_Ending_Seal		; seal
		plcm	KosM_Pig,	ArtTile_Ending_Pig		; pig
		plcm	KosM_Flicky,	ArtTile_Ending_Flicky		; flicky
		plcm	KosM_Squirrel,	ArtTile_Ending_Squirrel		; squirrel
		plcm	KosM_EndStH,	ArtTile_Ending_STH		; "SONIC THE HEDGEHOG"
PLC_Ending_end:

; ---------------------------------------------------------------------------
; Pattern load cues - "TRY AGAIN" and "END" screens
; ---------------------------------------------------------------------------
PLC_TryAgain:	plcheader
		plcm	KosM_EndEm,	ArtTile_Try_Again_Emeralds	; emeralds
		plcm	KosM_TryAgain,	ArtTile_Try_Again_Eggman	; Eggman
		plcm	KosM_CreditText,	ArtTile_Credits_Font		; credits alphabet
PLC_TryAgain_end:

; ---------------------------------------------------------------------------
; Pattern load cues - Sega screen
; ---------------------------------------------------------------------------
PLC_Sega:	plcheader
		plcm	KosM_SegaLogo,	ArtTile_Sega_Tiles
PLC_Sega_end:

; ---------------------------------------------------------------------------
; Pattern load cues - "SONIC TEAM PRESENTS" before title screen
; ---------------------------------------------------------------------------
PLC_TitleSonicTeam:	plcheader
		plcm	KosM_JapNames,	ArtTile_Title_Japanese_Text
		plcm	KosM_CreditText,	ArtTile_Sonic_Team_Font
PLC_TitleSonicTeam_end:

; ---------------------------------------------------------------------------
; Pattern load cues - Title screen FG (while Sonic Team Presents is displayed)
; ---------------------------------------------------------------------------
PLC_TitleForeground:	plcheader
		plcm	KosM_TitleFg,	ArtTile_Title_Foreground
		plcm	KosM_TitleSonic,	ArtTile_Title_Sonic
		plcm	KosM_TitleTM,	ArtTile_Title_Trademark
PLC_TitleForeground_end:

; ---------------------------------------------------------------------------
; Pattern load cues - Title screen BG (after Sonic Team Presents faded out)
; ---------------------------------------------------------------------------
PLC_TitleBackground:	plcheader
		plcm	KosM_Title,	ArtTile_Level
PLC_TitleBackground_end:

; ---------------------------------------------------------------------------
; Pattern load cues - Continue screen
; ---------------------------------------------------------------------------
PLC_Continue:	plcheader
		plcm	KosM_ContSonic,	ArtTile_Continue_Sonic
		plcm	KosM_MiniSonic,	ArtTile_Mini_Sonic
PLC_Continue_end:

; ---------------------------------------------------------------------------
; Pattern load cues - Credits screen
; ---------------------------------------------------------------------------
PLC_Credits:	plcheader
		plcm	KosM_CreditText,	ArtTile_Credits_Font
PLC_Credits_end:
