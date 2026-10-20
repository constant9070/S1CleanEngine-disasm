; ---------------------------------------------------------------------------
; Object pointers
; ---------------------------------------------------------------------------
Obj_Index:

objptr:	macro objectpointer,{INTLABEL}
__LABEL__:	label	((*-Obj_Index)/4)+1
		dc.l	objectpointer
		endm

; ---------------------------------------------------------------------------
; ID label:	non-zero index byte (see ID value)
; Object label:	main label to the actual object source

; ID label			Object label		  ID value
id_SonicPlayer:		objptr	SonicPlayer		; 01
id_Obj02:		objptr	NullObject		; 02
id_PathSwapper:		objptr	PathSwapper		; 03
id_Obj04:		objptr	NullObject		; 04
id_SpinDust:		objptr	SpinDust		; 05
id_Obj06:		objptr	NullObject		; 06
id_Obj07:		objptr	NullObject		; 07
id_Splash:		objptr	NullObject			; 08
id_SonicSpecial:	objptr	SonicSpecial		; 09
id_DrownCount:		objptr	NullObject		; 0A
id_Pole:		objptr	NullObject			; 0B
id_FlapDoor:		objptr	NullObject		; 0C
id_Signpost:		objptr	Signpost		; 0D
id_TitleSonic:		objptr	TitleSonic		; 0E
id_PSBTM:		objptr	PSBTM			; 0F
id_Obj10:		objptr	NullObject			; 10
id_Bridge:		objptr	Bridge			; 11
id_SpinningLight:	objptr	NullObject		; 12
id_LavaMaker:		objptr	NullObject		; 13
id_LavaBall:		objptr	NullObject		; 14
id_SwingingPlatform:	objptr	NullObject	; 15
id_Harpoon:		objptr	NullObject			; 16
id_Helix:		objptr	NullObject			; 17
id_BasicPlatform:	objptr	BasicPlatform		; 18
id_Obj19:		objptr	NullObject			; 19
id_CollapseLedge:	objptr	CollapseLedge		; 1A
id_WaterSurface:	objptr	NullObject		; 1B
id_Scenery:		objptr	Scenery			; 1C
id_MagicSwitch:		objptr	NullObject		; 1D
id_BallHog:		objptr	NullObject			; 1E
id_Crabmeat:		objptr	Crabmeat		; 1F
id_Cannonball:		objptr	NullObject		; 20
id_HUD:			objptr	HUD			; 21
id_BuzzBomber:		objptr	BuzzBomber		; 22
id_Missile:		objptr	NullObject			; 23
id_UnusedExplosion:	objptr	NullObject		; 24
id_Rings:		objptr	Rings			; 25
id_Monitor:		objptr	Monitor			; 26
id_ExplosionItem:	objptr	ExplosionItem		; 27
id_Animals:		objptr	Animals			; 28
id_Points:		objptr	Points			; 29
id_AutoDoor:		objptr	NullObject		; 2A
id_Chopper:		objptr	Chopper			; 2B
id_Jaws:		objptr	NullObject			; 2C
id_Burrobot:		objptr	Burrobot		; 2D
id_PowerUp:		objptr	PowerUp			; 2E
id_LargeGrass:		objptr	NullObject		; 2F
id_GlassBlock:		objptr	NullObject		; 30
id_ChainStomp:		objptr	NullObject		; 31
id_Button:		objptr	NullObject			; 32
id_PushBlock:		objptr	NullObject		; 33
id_TitleCard:		objptr	TitleCard		; 34
id_GrassFire:		objptr	NullObject		; 35
id_Spikes:		objptr	Spikes			; 36
id_RingLoss:		objptr	RingLoss		; 37
id_ShieldItem:		objptr	ShieldItem		; 38
id_GameOverCard:	objptr	GameOverCard		; 39
id_GotThroughCard:	objptr	GotThroughCard		; 3A
id_PurpleRock:		objptr	NullObject		; 3B
id_SmashWall:		objptr	SmashWall		; 3C
id_BossGreenHill:	objptr	NullObject		; 3D
id_Prison:		objptr	Prison			; 3E
id_Explosion:		objptr	Explosion		; 3F
id_MotoBug:		objptr	MotoBug			; 40
id_Springs:		objptr	Springs			; 41
id_Newtron:		objptr	Newtron			; 42
id_Roller:		objptr	NullObject			; 43
id_EdgeWalls:		objptr	EdgeWalls		; 44
id_SideStomp:		objptr	NullObject		; 45
id_MarbleBrick:		objptr	NullObject		; 46
id_Bumper:		objptr	NullObject			; 47
id_BossBall:		objptr	NullObject		; 48
id_WaterSound:		objptr	WaterSound		; 49
id_VanishSonic:		objptr	NullObject		; 4A
id_GiantRing:		objptr	NullObject		; 4B
id_GeyserMaker:		objptr	NullObject		; 4C
id_LavaGeyser:		objptr	NullObject		; 4D
id_LavaWall:		objptr	NullObject		; 4E
id_Obj4F:		objptr	NullObject		; 4F
id_Yadrin:		objptr	NullObject			; 50
id_SmashBlock:		objptr	NullObject		; 51
id_MovingBlock:		objptr	NullObject		; 52
id_CollapseFloor:	objptr	NullObject		; 53
id_LavaTag:		objptr	NullObject			; 54
id_Basaran:		objptr	NullObject			; 55
id_FloatingBlock:	objptr	NullObject		; 56
id_SpikeBall:		objptr	NullObject		; 57
id_BigSpikeBall:	objptr	NullObject		; 58
id_Elevator:		objptr	NullObject		; 59
id_CirclingPlatform:	objptr	NullObject	; 5A
id_Staircase:		objptr	NullObject		; 5B
id_Pylon:		objptr	NullObject			; 5C
id_Fan:			objptr	NullObject			; 5D
id_Seesaw:		objptr	NullObject			; 5E
id_Bomb:		objptr	NullObject			; 5F
id_Orbinaut:		objptr	NullObject		; 60
id_LabyrinthBlock:	objptr	NullObject		; 61
id_Gargoyle:		objptr	NullObject		; 62
id_LabyrinthConvey:	objptr	NullObject		; 63
id_Bubble:		objptr	Bubble			; 64
id_Waterfall:		objptr	NullObject		; 65
id_Junction:		objptr	NullObject		; 66
id_RunningDisc:		objptr	NullObject		; 67
id_Conveyor:		objptr	NullObject		; 68
id_SpinPlatform:	objptr	NullObject		; 69
id_Saws:		objptr	NullObject			; 6A
id_ScrapStomp:		objptr	NullObject		; 6B
id_VanishPlatform:	objptr	NullObject		; 6C
id_Flamethrower:	objptr	NullObject		; 6D
id_Electro:		objptr	NullObject			; 6E
id_SpinConvey:		objptr	NullObject		; 6F
id_Girder:		objptr	NullObject			; 70
id_Invisibarrier:	objptr	Invisibarrier		; 71
id_Teleport:		objptr	NullObject		; 72
id_BossMarble:		objptr	NullObject		; 73
id_BossFire:		objptr	NullObject		; 74
id_BossSpringYard:	objptr	NullObject		; 75
id_BossBlock:		objptr	NullObject		; 76
id_BossLabyrinth:	objptr	NullObject		; 77
id_Caterkiller:		objptr	NullObject		; 78
id_Lamppost:		objptr	Lamppost		; 79
id_BossStarLight:	objptr	NullObject		; 7A
id_BossSpikeball:	objptr	NullObject		; 7B
id_RingFlash:		objptr	RingFlash		; 7C
id_HiddenBonus:		objptr	HiddenBonus		; 7D
id_SSResult:		objptr	SSResult		; 7E
id_SSRChaos:		objptr	SSRChaos		; 7F
id_ContScrItem:		objptr	ContScrItem		; 80
id_ContSonic:		objptr	ContSonic		; 81
id_ScrapEggman:		objptr	NullObject		; 82
id_FalseFloor:		objptr	NullObject		; 83
id_EggmanCylinder:	objptr	NullObject		; 84
id_BossFinal:		objptr	NullObject		; 85
id_BossPlasma:		objptr	NullObject		; 86
id_EndSonic:		objptr	EndSonic		; 87
id_EndChaos:		objptr	EndChaos		; 88
id_EndSTH:		objptr	EndSTH			; 89
id_CreditsText:		objptr	CreditsText		; 8A
id_EndEggman:		objptr	EndEggman		; 8B
id_TryChaos:		objptr	TryChaos		; 8C

; ---------------------------------------------------------------------------

NullObject:
	if FixBugs
		; It would be safer to have this instruction here, otherwise it would just fall through to ObjectFall
		jmp	(DeleteObject).l
	endif
