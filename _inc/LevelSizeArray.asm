; ---------------------------------------------------------------------------
; Level size array
; ---------------------------------------------------------------------------

lvlsize macro left,right,top,bottom
	; $0004 is an unused value, $0060 is the default vertical screen shift.
	; Both are always the same and redundant.
	dc.w $0004, left, right, top, bottom, $0060
	endm

; ---------------------------------------------------------------------------

		;           |---------------------------------Left boundary
		;           |      |--------------------------Right boundary
		;           |      |      |-------------------Top boundary
		;           |      |      |      |------------Bottom boundary
		; GHZ       |      |      |      |
		lvlsize     0, $24BF,     0,  $300 ; GHZ1
		lvlsize     0, $1EBF,     0,  $300 ; GHZ2
		lvlsize     0, $2960,     0,  $300 ; GHZ3
		lvlsize     0, $2ABF,     0,  $300 ; GHZ4 (unused)
		zonewarning LevelSizeArray,$30
		; Ending
		lvlsize     0,  $500,  $110,  $110 ; good ending
		lvlsize     0,  $DC0,  $110,  $110 ; bad ending
		lvlsize     0, $2FFF,     0,  $320 ; (unused)
		lvlsize     0, $2FFF,     0,  $320 ; (unused)
		even
