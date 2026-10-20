; ---------------------------------------------------------------------------
; Animation script - ring sparkle (rings themselves are animated with Sync2)
; ---------------------------------------------------------------------------

Ani_Ring:	dc.w .sparkle-Ani_Ring

.ring:		dc.b 5, 1, 2, 3, 4, afRoutine

.sparkle:	dc.b 5
		dc.b 4, 5, 6, 7
		dc.b afRoutine
		even
