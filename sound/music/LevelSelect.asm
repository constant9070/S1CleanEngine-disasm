Menu_Header:
	smpsHeaderStartSong 2
	smpsHeaderVoice     Menu_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $02, $FC

	smpsHeaderDAC       Menu_DAC
	smpsHeaderFM        Menu_FM1,	$0C, $12
	smpsHeaderFM        Menu_FM2,	$0C, $19
	smpsHeaderFM        Menu_FM3,	$0C, $19
	smpsHeaderFM        Menu_FM4,	$0C, $19
	smpsHeaderFM        Menu_FM5,	$0C, $19
	smpsHeaderPSG       Menu_PSG1,	$F4, $06, $00, fTone_03
	smpsHeaderPSG       Menu_PSG2,	$F4, $06, $00, fTone_03
	smpsHeaderPSG       Menu_PSG3,	$00, $04, $00, fTone_03

Menu_Call00:
	dc.b	dKick, $12, dKick, $06, dKick, dHiTimpani, $0C, dKick, $06, dKick, $12, dKick
	dc.b	$06, dKick, dMidTimpani, dLowTimpani, $0C
	smpsReturn

; DAC Data
Menu_DAC:
	dc.b	nRst, $2A

Menu_Loop00:
	smpsCall            Menu_Call00
	smpsLoop            $01, $03, Menu_Loop00
	dc.b	dKick, $12, dKick, $06, dKick, dHiTimpani, $0C, dKick, $06, dKick, $02, dSnare
	dc.b	$03, dSnare, $01, dSnare, $0C, dSnare, $06, dSnare, $08, dSnare, dSnare

Menu_Loop01:
	smpsCall            Menu_Call00
	smpsLoop            $01, $03, Menu_Loop01
	dc.b	dLowTimpani, $06, dLowTimpani, dLowTimpani, $12, dLowTimpani, $06, dLowTimpani, dLowTimpani, $1E, dMidTimpani, $18

Menu_Loop02:
	smpsCall            Menu_Call00
	smpsLoop            $01, $07, Menu_Loop02
	dc.b	dKick, $12, dKick, $06, dKick, dHiTimpani, $0C, dKick, $06, dKick, dSnare, $0C
	dc.b	dSnare, $06, dSnare, $0C, dLowTimpani

Menu_Loop03:
	smpsCall            Menu_Call00
	smpsLoop            $01, $02, Menu_Loop03
	dc.b	dKick, $12, dKick, $06, dKick, dHiTimpani, $0C, dKick, $06, dKick, $12, dKick
	dc.b	$06, dKick, dMidTimpani, dLowTimpani, $0C, dLowTimpani, $06, dLowTimpani, dLowTimpani, $12, dLowTimpani, $06
	dc.b	dLowTimpani, dLowTimpani, $1E, dMidTimpani, $18

Menu_Loop04:
	smpsCall            Menu_Call00
	smpsLoop            $01, $03, Menu_Loop04
	dc.b	dLowTimpani, $06, dKick, $0C, dLowTimpani, $06, dKick, dLowTimpani, dLowTimpani, dMidTimpani, $0C, dKick
	dc.b	$12, dKick, $06, dKick, dHiTimpani, $0C

Menu_Loop05:
	smpsCall            Menu_Call00
	smpsLoop            $01, $02, Menu_Loop05
	dc.b	dKick, $12, dKick, $06, dKick, dHiTimpani, $0C, dKick, $06, dKick, $12, dKick
	dc.b	$06, dKick, dMidTimpani, dLowTimpani, $0C, dLowTimpani, dKick, $06, dLowTimpani, $0C, dKick, $06
	dc.b	dLowTimpani, nRst, $36
	smpsJump            Menu_Loop00

; FM1 Data
Menu_FM1:
	dc.b	nRst, $2A

Menu_Jump04:
	smpsSetvoice        $00
	dc.b	nC1, $12, nG1, nC2, $0C, nF1, $12, nC2, nF2, $0C, nBb0, $12
	dc.b	nF1, nBb1, $0C, nG0, $12, nD1, nG1, $0C, nC1, $12, nG1, nC2
	dc.b	$0C, nF1, $12, nC2, nF2, $0C, nBb0, $12, nC1, nD1, $0C, nRst
	dc.b	$30, nC1, $12, nG1, nC2, $0C, nF1, $12, nC2, nF2, $0C, nBb0
	dc.b	$12, nF1, nBb1, $0C, nG1, $12, nD2, nG2, $0C, nC1, $12, nG1
	dc.b	nC2, $0C, nF1, $12, nC2, nF2, $0C, nBb0, $06, nBb0, nBb0, nRst
	dc.b	$0C, nBb0, $06, nBb0, nBb0, nRst, $30, nF1, $12, nC2, nF2, $0C
	dc.b	nBb0, $12, nF1, nBb1, $0C, nEb1, $12, nBb1, nEb2, $0C, nEb1, $12
	dc.b	nBb1, nEb2, $0C, nF1, $12, nC2, nF2, $0C, nBb0, $12, nF1, nBb1
	dc.b	$0C, nEb1, $12, nBb1, nEb2, $0C, nEb1, $12, nF1, nFs1, $0C, nG1
	dc.b	$12, nD2, nG2, $0C, nC1, $12, nG1, nC2, $0C, nF1, $12, nC2
	dc.b	nF2, $0C, nD1, $12, nA1, nD2, $0C, nG1, $12, nD2, nG2, $0C
	dc.b	nC1, $12, nG1, nC2, $0C, nF1, $12, nC1, nF0, $0C, nRst, $30
	dc.b	nC1, $12, nG1, nC2, $0C, nF1, $12, nC2, nF2, $0C, nBb0, $12
	dc.b	nF1, nBb1, $0C, nG1, $12, nD2, nG2, $0C, nC1, $12, nG1, nC2
	dc.b	$0C, nF1, $12, nC2, nF2, $0C, nBb0, $06, nBb0, nBb0, nRst, $0C
	dc.b	nBb0, $06, nBb0, nBb0, nRst, $30, nF1, $12, nC2, nF2, $0C, nF1
	dc.b	$12, nC2, nF2, $0C, nF1, $12, nC2, nF2, $0C, nG1, $18, nFs1
	dc.b	nF1, $12, nC2, nF2, $0C, nF1, $12, nC2, nF2, $0C, nBb1, $12
	dc.b	nBb1, $06, nRst, nF1, nFs1, nG1, $0C, nG1, $06, nD2, $0C, nG2
	dc.b	$06, nD2, nG1, $0C, nF1, $12, nC2, nF2, $0C, nF1, $12, nC2
	dc.b	nF2, $0C, nF1, $12, nC2, nF2, $0C, nG1, $18, nFs1, nF1, $12
	dc.b	nC2, nF2, $0C, nF1, $12, nC2, nF2, $0C, nBb0, $12, nC1, nD1
	dc.b	$0C, nRst, $30
	smpsJump            Menu_Jump04

; FM2 Data
Menu_FM2:
	smpsSetvoice        $06
	smpsAlterNote       $00
	smpsModSet          $03, $01, $FC, $05
	smpsPan             panCenter, $00
	dc.b	nBb3, $0C, nBb3, $06, nBb3, $08, nA3, nBb3

Menu_Jump03:
	dc.b	nA3, $03, nBb3, nA3, $0C, nG3, $26, nA3, $08, nBb3, nC4, nA3
	dc.b	nG3, nG3, $03, nA3, nG3, $0C, nF3, $21, nCs3, $03, nD3, $0C
	dc.b	nEb3, $06, nF3, $08, nG3, nD3, nF3, $12, nEb3, $0F, nA3, $03
	dc.b	nBb3, $0C, nA3, $12, nG3, nA3, $0C, nG3, $03, nA3, nG3, $0C
	dc.b	nF3, $24, nBb3, $0C, nBb3, $06, nBb3, $08, nA3, nBb3, nA3, $03
	dc.b	nBb3, nA3, $0C, nG3, $26, nA3, $08, nBb3, nC4, nA3, nG3, nG3
	dc.b	$03, nA3, nG3, $0C, nF3, $22, nFs3, $04, nG3, $08, nA3, nB3
	dc.b	nC4, nD4, nEb4, $12, nG3, nBb3, $0C, nA3, $12, nG3, nA3, $0C
	dc.b	nBb3, $06, nBb3, nBb3, $12, nBb3, $06, nBb3, nBb3, $2A
	smpsSetvoice        $04
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $06, $05
	dc.b	nC5, $03, nRst, nD5, nRst, nEb5, $12, nAb4, nEb5, $0C, nD5, $18
	dc.b	nRst, $0C, nBb4, $03, nRst, nC5, nRst, nD5, $12, nG5, nD5, $0C
	dc.b	nC5, $18, nRst, $0C, nC5, $03, nRst, nD5, nRst, nEb5, $12, nAb4
	dc.b	nEb5, $0C, nD5, $12, nF5, nD5, $0C, nC5, $03, nD5, nC5, $0C
	dc.b	nBb4, $36, nRst, $0C, nD5, $03, nRst, nE5, nRst, nF5, $12, nBb4
	dc.b	nF5, $0C, nE5, $18, nRst, $0C, nC5, $03, nRst, nD5, nRst, nE5
	dc.b	$12, nA5, nE5, $0C, nD5, $18, nRst, $0C, nA4, $06, nBb4, nC5
	dc.b	$03, nRst, $09, nD5, $03, nRst, nBb4, nRst, $09, nC5, $03, nRst
	dc.b	$09, nA4, $03, nRst, $09, nBb4, $03, nRst, $09, nG4, $03, nRst
	dc.b	$09, nA4, $0C, nAb4, $02, nG4, nFs4, nF4, $06, nRst, $30
	smpsSetvoice        $06
	smpsAlterNote       $00
	smpsModSet          $03, $01, $FC, $05
	smpsPan             panCenter, $00
	dc.b	nBb3, $0C, nBb3, $06, nBb3, $08, nA3, nBb3, nA3, $03, nBb3, nA3
	dc.b	$0C, nG3, $26, nA3, $08, nBb3, nC4, nA3, nG3, nG3, $03, nA3
	dc.b	nG3, $0C, nF3, $22, nFs3, $04, nG3, $08, nA3, nB3, nC4, nD4
	dc.b	nEb4, $12, nG3, nBb3, $0C, nA3, $12, nG3, nA3, $0C, nBb3, $06
	dc.b	nBb3, nBb3, $12, nBb3, $06, nBb3, nBb3, $3C
	smpsSetvoice        $03
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b	nD3, $03, nRst, nF3, nRst, nA3, nRst, nC4, nRst, $09, nBb3, $03
	dc.b	nRst, nC4, nRst, $09, nBb3, $03, nRst, nC4, nRst, nBb3, $0C
	smpsSetvoice        $02
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nG3, $03, nRst, nA3, $06, nBb3, $0C
	smpsSetvoice        $03
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $06, nG3, $03, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	smpsSetvoice        $04
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $06, $05
	dc.b	nBb4, $06, nA4, nF4, nD4, nBb3, nA3, nG3, $0C, nRst, $30
	smpsSetvoice        $03
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b	nD3, $03, nRst, nF3, nRst, nA3, nRst, nC4, nRst, $09, nBb3, $03
	dc.b	nRst, nC4, nRst, $09, nBb3, $03, nRst, nC4, nRst, nBb3, $0C
	smpsSetvoice        $02
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nG3, $03, nRst, nA3, $06, nBb3, $0C
	smpsSetvoice        $03
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	smpsSetvoice        $04
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $06, $05
	dc.b	nBb4, $06, nA4, nF4, nD4, nBb3, nA3, nG3, $0C
	smpsSetvoice        $06
	smpsAlterNote       $00
	smpsModSet          $03, $01, $FC, $05
	smpsPan             panCenter, $00
	dc.b	nBb3, $0C, nBb3, $06, nBb3, $08, nA3, nBb3
	smpsJump            Menu_Jump03

; FM3 Data
Menu_FM3:
	smpsSetvoice        $06
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $04, $05
	smpsPan             panCenter, $00
	dc.b	nBb2, $0C, nBb2, $06, nBb2, $08, nA2, nBb2

Menu_Jump02:
	smpsSetvoice        $06
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $04, $05
	smpsPan             panCenter, $00
	dc.b	nA2, $03, nBb2, nA2, $0C, nG2, $26, nA2, $08, nBb2, nC3, nA2
	dc.b	nG2, nG2, $03, nA2, nG2, $0C, nF2, $21, nCs2, $03, nD2, $0C
	dc.b	nEb2, $06, nF2, $08, nG2, nD2, nF2, $12, nEb2, $0F, nA2, $03
	dc.b	nBb2, $0C, nA2, $12, nG2, nA2, $0C, nG2, $03, nA2, nG2, $0C
	dc.b	nF2, $24, nBb2, $0C, nBb2, $06, nBb2, $08, nA2, nBb2, nA2, $03
	dc.b	nBb2, nA2, $0C, nG2, $26, nA2, $08, nBb2, nC3, nA2, nG2, nG2
	dc.b	$03, nA2, nG2, $0C, nF2, $22, nFs2, $04, nG2, $08, nA2, nB2
	dc.b	nC3, nD3, nEb3, $12, nG2, nBb2, $0C, nA2, $12, nG2, nA2, $0C
	dc.b	nBb2, $06, nBb2, nBb2, $12, nBb2, $06, nBb2, nBb2, $30
	smpsSetvoice        $04
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $06, $05
	smpsAlterVol      $14
	dc.b	nC5, $03, nRst, nD5, nRst, nEb5, $12, nAb4, nEb5, $0C, nD5, $18
	dc.b	nRst, $0C, nBb4, $03, nRst, nC5, nRst, nD5, $12, nG5, nD5, $0C
	dc.b	nC5, $18, nRst, $0C, nC5, $03, nRst, nD5, nRst, nEb5, $12, nAb4
	dc.b	nEb5, $0C, nD5, $12, nF5, nD5, $0C, nC5, $03, nD5, nC5, $0C
	dc.b	nBb4, $36, nRst, $0C, nD5, $03, nRst, nE5, nRst, nF5, $12, nBb4
	dc.b	nF5, $0C, nE5, $18, nRst, $0C, nC5, $03, nRst, nD5, nRst, nE5
	dc.b	$12, nA5, nE5, $0C, nD5, $18, nRst, $0C, nA4, $06, nBb4, nC5
	dc.b	$03, nRst, $09, nD5, $03, nRst, nBb4, nRst, $09, nC5, $03, nRst
	dc.b	$09, nA4, $03, nRst, $09, nBb4, $03, nRst, $09, nG4, $03, nRst
	dc.b	$09, nA4, $0C, nAb4, $02, nG4, nFs4, nF4, $06, nRst, $2A
	smpsAlterVol      $EC
	smpsSetvoice        $06
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $04, $05
	smpsPan             panCenter, $00
	dc.b	nBb2, $0C, nBb2, $06, nBb2, $08, nA2, nBb2, nA2, $03, nBb2, nA2
	dc.b	$0C, nG2, $26, nA2, $08, nBb2, nC3, nA2, nG2, nG2, $03, nA2
	dc.b	nG2, $0C, nF2, $22, nFs2, $04, nG2, $08, nA2, nB2, nC3, nD3
	dc.b	nEb3, $12, nG2, nBb2, $0C, nA2, $12, nG2, nA2, $0C, nBb2, $06
	dc.b	nBb2, nBb2, $12, nBb2, $06, nBb2, nBb2, $3C
	smpsSetvoice        $03
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b	nBb2, $03, nRst, nD3, nRst, nF3, nRst, nA3, nRst, $09, nG3, $03
	dc.b	nRst, nA3, nRst, $09, nG3, $03, nRst, nA3, nRst, nG3, $0C
	smpsSetvoice        $02
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nEb3, $03, nRst, nF3, $06, nG3, $0C
	smpsSetvoice        $03
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nC3, $06, nEb3, $03, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	smpsSetvoice        $04
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	dc.b	nG4, $06, nF4, nD4, nBb3, nG3, nF3, nD3, $0C, nRst, $30
	smpsSetvoice        $03
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b	nBb2, $03, nRst, nD3, nRst, nF3, nRst, nA3, nRst, $09, nG3, $03
	dc.b	nRst, nA3, nRst, $09, nG3, $03, nRst, nA3, nRst, nG3, $0C
	smpsSetvoice        $02
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nEb3, $03, nRst, nF3, $06, nG3, $0C
	smpsSetvoice        $03
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	smpsSetvoice        $04
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	dc.b	nG4, $06, nF4, nD4, nBb3, nG3, nF3, nD3, $0C
	smpsSetvoice        $06
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $04, $05
	smpsPan             panCenter, $00
	dc.b	nBb2, $08, nRst, $04, nBb2, $06, nBb2, $08, nA2, nBb2
	smpsJump            Menu_Jump02

; FM4 Data
Menu_FM4:
	dc.b	nRst, $2A
	smpsSetvoice        $02
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00

Menu_Jump01:
	dc.b	nEb3, $06, nRst, nBb3, nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst
	dc.b	nG3, nRst, nD4, nEb3, nRst, nD3, nRst, nA3, nF3, nRst, nC4, nRst
	dc.b	nD3, nRst, nA3, nRst, nG3, nRst, nD4, nD3, nRst, nEb3, nRst, nBb3
	dc.b	nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b	nRst, nD3, nRst, $0C, nEb3, $06, nRst, $0C, nF3, $06, nRst, $0C
	smpsSetvoice        $05
	smpsAlterVol      $06
	dc.b	nG4, $06, nG5, nG4, nRst, $18
	smpsAlterVol      $FA
	smpsSetvoice        $02
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $06, nRst, nBb3, nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst
	dc.b	nG3, nRst, nD4, nEb3, nRst, nD3, nRst, nA3, nF3, nRst, nC4, nRst
	dc.b	nD3, nRst, nA3, nRst, nG3, nRst, nD4, nD3, nRst, nEb3, nRst, nBb3
	dc.b	nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b	nRst, nF3, nF3, nF3, nRst, $0C, nF3, $06, nF3, nF3, nRst, $3C
	smpsSetvoice        $01
	smpsAlterNote       $03
	smpsModSet          $03, $01, $FD, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, $0F, nEb3, $03, nRst, $0F, nD3, $0C, nRst, $06
	dc.b	nD3, $03, nRst, $0F, nD3, $0C, nRst, nD3, $03, nRst, $0F, nD3
	dc.b	$03, nRst, $0F, nC3, $0C, nRst, $06, nD3, $0C, nRst, $06, nEb3
	dc.b	$0C, nRst, nEb3, $03, nRst, $0F, nEb3, $03, nRst, $0F, nD3, $0C
	dc.b	nRst, $06, nD3, $03, nRst, $0F, nD3, $0C, nRst, $06, nG3, $03
	dc.b	nRst, nAb3, nRst, nBb3, nRst, nEb4, nRst, nD4, nRst, nBb3, nRst, nG3
	dc.b	$12, nRst, $30
	smpsSetvoice        $01
	smpsAlterNote       $03
	smpsModSet          $03, $01, $FD, $05
	smpsPan             panLeft, $00
	dc.b	nF3, $03, nRst, $0F, nF3, $03, nRst, $0F, nE3, $0C, nRst, $06
	dc.b	nE3, $03, nRst, $0F, nE3, $0C, nRst, nE3, $03, nRst, $0F, nE3
	dc.b	$03, nRst, $0F, nD3, $0C, nRst, $06, nE3, $0C, nRst, $06, nF3
	dc.b	$0C, nRst, nF3, $03, nRst, $0F, nF3, $03, nRst, $0F, nE3, $0C
	dc.b	nRst, $06, nE3, $03, nRst, $0F, nE3, $0C, nF3, nRst, $06, nF3
	dc.b	$0C, nRst, $06, nF3, nRst, $36
	smpsSetvoice        $02
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $06, nRst, nBb3, nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst
	dc.b	nG3, nRst, nD4, nEb3, nRst, nD3, nRst, nA3, nF3, nRst, nC4, nRst
	dc.b	nD3, nRst, nA3, nRst, nG3, nRst, nD4, nD3, nRst, nEb3, nRst, nBb3
	dc.b	nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b	nRst, nF3, nF3, nF3, nRst, $0C, nF3, $06, nF3, nF3, nRst, $36
	smpsSetvoice        $01
	smpsAlterNote       $03
	smpsModSet          $03, $01, $FD, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b	nD3, $03, nRst, nF3, nRst, nA3, nRst, nC4, nRst, $09, nBb3, $03
	dc.b	nRst, nC4, nRst, $09, nBb3, $03, nRst, nC4, nRst, nBb3, $0C
	smpsSetvoice        $02
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nG3, $03, nRst, nA3, nRst, nBb3, nRst, $09
	smpsSetvoice        $01
	smpsAlterNote       $03
	smpsModSet          $03, $01, $FD, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b	$0C
	smpsSetvoice        $02
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nD3, $06, nRst, $0C, nEb3, $06, nRst, $0C, nF3, $06, nRst, $3C
	smpsSetvoice        $01
	smpsAlterNote       $03
	smpsModSet          $03, $01, $FD, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b	nD3, $03, nRst, nF3, nRst, nA3, nRst, nC4, nRst, $09, nBb3, $03
	dc.b	nRst, nC4, nRst, $09, nBb3, $03, nRst, nC4, nRst, nBb3, $0C
	smpsSetvoice        $02
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nG3, $03, nRst, nA3, nRst, nBb3, nRst, $09
	smpsSetvoice        $01
	smpsAlterNote       $03
	smpsModSet          $03, $01, $FD, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b	$0C
	smpsSetvoice        $02
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nD3, $06, nRst, $0C, nEb3, $06, nRst, $0C, nF3, $06, nRst, $36
	smpsJump            Menu_Jump01

; FM5 Data
Menu_FM5:
	dc.b	nRst, $2A

Menu_Jump00:
	smpsSetvoice        $02
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nEb2, $06, nRst, nBb2, nG2, nRst, nD3, nRst, nEb2, nRst, nA2, nRst
	dc.b	nG2, nRst, nD3, nEb2, nRst, nD2, nRst, nA2, nF2, nRst, nC3, nRst
	dc.b	nD2, nRst, nA2, nRst, nG2, nRst, nD3, nD2, nRst, nEb2, nRst, nBb2
	dc.b	nG2, nRst, nD3, nRst, nEb2, nRst, nA2, nRst, nG2, nRst, nD3, nEb2
	dc.b	nRst, nBb2, nRst, $0C, nC3, $06, nRst, $0C, nD3, $06, nRst, $0C
	smpsSetvoice        $05
	smpsAlterVol      $08
	dc.b	nG4, $06, nG5, nG4, nRst, $18
	smpsAlterVol      $FA
	smpsSetvoice        $02
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nEb2, $06, nRst, nBb2, nG2, nRst, nD3, nRst, nEb2, nRst, nA2, nRst
	dc.b	nG2, nRst, nD3, nEb2, nRst, nD2, nRst, nA2, nF2, nRst, nC3, nRst
	dc.b	nD2, nRst, nA2, nRst, nG2, nRst, nD3, nD2, nRst, nEb2, nRst, nBb2
	dc.b	nG2, nRst, nD3, nRst, nEb2, nRst, nA2, nRst, nG2, nRst, nD3, nEb2
	dc.b	nRst, nD3, nD3, nD3, nRst, $0C, nD3, $06, nD3, nD3, nRst, $3C
	smpsSetvoice        $01
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $03, $05
	smpsPan             panRight, $00
	dc.b	nAb2, $03, nRst, $0F, nAb2, $03, nRst, $0F, nAb2, $0C, nRst, $06
	dc.b	nAb2, $03, nRst, $0F, nAb2, $0C, nRst, nG2, $03, nRst, $0F, nG2
	dc.b	$03, nRst, $0F, nG2, $0C, nRst, $06, nF2, $0C, nRst, $06, nG2
	dc.b	$0C, nRst, nAb2, $03, nRst, $0F, nAb2, $03, nRst, $0F, nAb2, $0C
	dc.b	nRst, $06, nAb2, $03, nRst, $0F, nAb2, $0C, nRst, $06, nBb2, $03
	dc.b	nRst, nC3, nRst, nD3, nRst, nG3, nRst, nF3, nRst, nD3, nRst, nBb2
	dc.b	$12, nRst, $30
	smpsSetvoice        $01
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $03, $05
	smpsPan             panRight, $00
	dc.b	nBb2, $03, nRst, $0F, nBb2, $03, nRst, $0F, nBb2, $0C, nRst, $06
	dc.b	nBb2, $03, nRst, $0F, nBb2, $0C, nRst, nA2, $03, nRst, $0F, nA2
	dc.b	$03, nRst, $0F, nA2, $0C, nRst, $06, nG2, $0C, nRst, $06, nA2
	dc.b	$0C, nRst, nBb2, $03, nRst, $0F, nBb2, $03, nRst, $0F, nBb2, $0C
	dc.b	nRst, $06, nBb2, $03, nRst, $0F, nBb2, $0C, nA2, nRst, $06, nA2
	dc.b	$0C, nRst, $06, nA2, nRst, $36
	smpsSetvoice        $02
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nEb2, $06, nRst, nBb2, nG2, nRst, nD3, nRst, nEb2, nRst, nA2, nRst
	dc.b	nG2, nRst, nD3, nEb2, nRst, nD2, nRst, nA2, nF2, nRst, nC3, nRst
	dc.b	nD2, nRst, nA2, nRst, nG2, nRst, nD3, nD2, nRst, nEb2, nRst, nBb2
	dc.b	nG2, nRst, nD3, nRst, nEb2, nRst, nA2, nRst, nG2, nRst, nD3, nEb2
	dc.b	nRst, nD3, nD3, nD3, nRst, $0C, nD3, $06, nD3, nD3, nRst, $36
	smpsSetvoice        $01
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $03, $05
	smpsPan             panRight, $00
	dc.b	nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b	nBb2, $03, nRst, nD3, nRst, nF3, nRst, nA3, nRst, $09, nG3, $03
	dc.b	nRst, nA3, nRst, $09, nG3, $03, nRst, nA3, nRst, nG3, $0C
	smpsSetvoice        $02
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nEb3, $03, nRst, nF3, nRst, nG3, nRst, $09
	smpsSetvoice        $01
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $03, $05
	smpsPan             panRight, $00
	dc.b	nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b	$0C
	smpsSetvoice        $02
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nBb2, $06, nRst, $0C, nC3, $06, nRst, $0C, nD3, $06, nRst, $3C
	smpsSetvoice        $01
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $03, $05
	smpsPan             panRight, $00
	dc.b	nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b	nBb2, $03, nRst, nD3, nRst, nF3, nRst, nA3, nRst, $09, nG3, $03
	dc.b	nRst, nA3, nRst, $09, nG3, $03, nRst, nA3, nRst, nG3, $0C
	smpsSetvoice        $02
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nEb3, $03, nRst, nF3, nRst, nG3, nRst, $09
	smpsSetvoice        $01
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $03, $05
	smpsPan             panRight, $00
	dc.b	nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b	$0C
	smpsSetvoice        $02
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nBb2, $06, nRst, $0C, nC3, $06, nRst, $0C, nD3, $06, nRst, $36
	smpsJump            Menu_Jump00

; PSG1 Data
Menu_PSG1:
	smpsPSGvoice        fTone_04
	smpsAlterNote       $00
	dc.b	nRst, $2A

Menu_Jump07:
	smpsPSGvoice        fTone_04
	smpsCall            Menu_Call03
	dc.b	nD3, nRst, $0C, nEb3, $06, nRst, $0C, nF3, $06, nRst, $0C, nG4
	dc.b	$06, nG5, nG4, nRst, $18
	smpsCall            Menu_Call03
	dc.b	nF3, nF3, nF3, nRst, $0C, nF3, $06, nF3, nF3, nRst, $3C, nEb3
	dc.b	$03, nRst, $0F, nEb3, $03, nRst, $0F, nD3, $0C, nRst, $06, nD3
	dc.b	$03, nRst, $0F, nD3, $0C, nRst, nD3, $03, nRst, $0F, nD3, $03
	dc.b	nRst, $0F, nC3, $0C, nRst, $06, nD3, $0C, nRst, $06, nEb3, $0C
	dc.b	nRst, nEb3, $03, nRst, $0F, nEb3, $03, nRst, $0F, nD3, $0C, nRst
	dc.b	$06, nD3, $03, nRst, $0F, nD3, $0C, nRst, $06, nG3, $03, nRst
	dc.b	nAb3, nRst, nBb3, nRst, nEb4, nRst, nD4, nRst, nBb3, nRst, nG3, $12
	dc.b	nRst, $30, nF3, $03, nRst, $0F, nF3, $03, nRst, $0F, nE3, $0C
	dc.b	nRst, $06, nE3, $03, nRst, $0F, nE3, $0C, nRst, nE3, $03, nRst
	dc.b	$0F, nE3, $03, nRst, $0F, nD3, $0C, nRst, $06, nE3, $0C, nRst
	dc.b	$06, nF3, $0C, nRst, nF3, $03, nRst, $0F, nF3, $03, nRst, $0F
	dc.b	nE3, $0C, nRst, $06, nE3, $03, nRst, $0F, nE3, $0C, nF3, nRst
	dc.b	$06, nF3, $0C, nRst, $06, nF3, nRst, $36
	smpsCall            Menu_Call03
	smpsCall            Menu_Call04
	dc.b	nF4, $02, nRst, $04, nF5, $06, nF4, $02, nRst, $0A, nF4, $06
	dc.b	nF5, $06, nF4, $02, nRst, $0A, nF4, $06, nF5, $06, nF4, $02
	dc.b	nRst, $0A
	smpsCall            Menu_Call05
	smpsJump            Menu_Jump07

Menu_Call03:
	dc.b	nEb3, $06, nRst, nBb3, nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst
	dc.b	nG3, nRst, nD4, nEb3, nRst, nD3, nRst, nA3, nF3, nRst, nC4, nRst
	dc.b	nD3, nRst, nA3, nRst, nG3, nRst, nD4, nD3, nRst, nEb3, nRst, nBb3
	dc.b	nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b	nRst
	smpsReturn

Menu_Call04:
	dc.b	nF3, $06, nF3, nF3, nRst, $0C, nF3, $06, nF3, nF3, nRst, $36
	smpsReturn

Menu_Call05:
	dc.b	nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06
	dc.b	nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4
	dc.b	$0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4
	dc.b	$06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5
	dc.b	nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C
	dc.b	nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06
	dc.b	nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4
	dc.b	$0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4
	dc.b	$06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5
	dc.b	nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C
	dc.b	nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06
	dc.b	nF5, nF4, $36
	smpsReturn

; PSG2 Data
Menu_PSG2:
	smpsPSGvoice        fTone_04
	smpsAlterNote       $FF
	dc.b	nRst, $2A

Menu_Jump06:
	smpsPSGvoice        fTone_04
	smpsCall            Menu_Call03
	dc.b	nBb3, nRst, $0C, nC4, $06, nRst, $0C, nD4, $06, nRst, $0C, nG5
	dc.b	$06, nG6, nG5, nRst, $18
	smpsCall            Menu_Call03
	dc.b	nD4, nD4, nD4, nRst, $0C, nD4, $06, nD4, nD4, nRst, $3C, nAb2
	dc.b	$03, nRst, $0F, nAb2, $03, nRst, $0F, nAb2, $0C, nRst, $06, nAb2
	dc.b	$03, nRst, $0F, nAb2, $0C, nRst, nG2, $03, nRst, $0F, nG2, $03
	dc.b	nRst, $0F, nG2, $0C, nRst, $06, nF2, $0C, nRst, $06, nG2, $0C
	dc.b	nRst, nAb2, $03, nRst, $0F, nAb2, $03, nRst, $0F, nAb2, $0C, nRst
	dc.b	$06, nAb2, $03, nRst, $0F, nAb2, $0C, nRst, $06, nBb2, $03, nRst
	dc.b	nC3, nRst, nD3, nRst, nG3, nRst, nF3, nRst, nD3, nRst, nBb2, $12
	dc.b	nRst, $30, nBb2, $03, nRst, $0F, nBb2, $03, nRst, $0F, nBb2, $0C
	dc.b	nRst, $06, nBb2, $03, nRst, $0F, nBb2, $0C, nRst, nA2, $03, nRst
	dc.b	$0F, nA2, $03, nRst, $0F, nA2, $0C, nRst, $06, nG2, $0C, nRst
	dc.b	$06, nA2, $0C, nRst, nBb2, $03, nRst, $0F, nBb2, $03, nRst, $0F
	dc.b	nBb2, $0C, nRst, $06, nBb2, $03, nRst, $0F, nBb2, $0C, nA2, nRst
	dc.b	$06, nA2, $0C, nRst, $06, nA2, nRst, $36
	smpsCall            Menu_Call03
	smpsCall            Menu_Call04
	dc.b	nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06
	dc.b	nF5, nF4, $0C
	smpsCall            Menu_Call05
	smpsJump            Menu_Jump06

; PSG3 Data
Menu_PSG3:
	smpsPSGvoice        fTone_02
	smpsPSGform         $E7
	dc.b	nRst, $2A

Menu_Jump05:
	smpsCall            Menu_Call01
	smpsCall            Menu_Call01
	smpsCall            Menu_Call01
	smpsPSGAlterVol     $FD
	dc.b	nMaxPSG
	dc.b	$06
	smpsPSGAlterVol     $03
	dc.b	nMaxPSG
	dc.b	$03, nMaxPSG, nMaxPSG, $06, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, $0C
	smpsPSGAlterVol     $FD
	dc.b	nMaxPSG
	dc.b	$0C, nMaxPSG, $06, nMaxPSG, $08, nMaxPSG, nMaxPSG, $02
	smpsPSGAlterVol     $03
	dc.b	nRst
	dc.b	$06
	smpsCall            Menu_Call01
	smpsCall            Menu_Call01
	smpsPSGAlterVol     $FD
	dc.b	nMaxPSG
	dc.b	$06
	smpsPSGAlterVol     $03
	dc.b	nMaxPSG
	dc.b	$03, nMaxPSG

Menu_Loop06:
	dc.b	nMaxPSG, $06
	smpsLoop            $00, $0D, Menu_Loop06
	dc.b	nMaxPSG, $32, nMaxPSG, $34
	smpsCall            Menu_Call02
	smpsCall            Menu_Call02
	smpsCall            Menu_Call02
	smpsCall            Menu_Call02
	smpsCall            Menu_Call02
	smpsCall            Menu_Call02
	smpsCall            Menu_Call02
	dc.b	nMaxPSG, $06, nMaxPSG, $03, nMaxPSG, nMaxPSG, $06, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG
	dc.b	$36
	smpsCall            Menu_Call01
	smpsCall            Menu_Call01
	smpsPSGAlterVol     $FD
	dc.b	nMaxPSG
	dc.b	$06
	smpsPSGAlterVol     $03
	dc.b	nMaxPSG
	dc.b	$03, nMaxPSG

Menu_Loop07:
	dc.b	nMaxPSG, $06
	smpsLoop            $00, $0D, Menu_Loop07
	dc.b	nMaxPSG, $32, nMaxPSG, $34, nMaxPSG, $06, nMaxPSG, $03, nMaxPSG, nMaxPSG, $06
	smpsPSGAlterVol     $FD
	dc.b	nMaxPSG
	smpsPSGAlterVol     $03
	dc.b	nMaxPSG
	dc.b	nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG

Menu_Loop08:
	dc.b	nMaxPSG, $06, nMaxPSG, $03, nMaxPSG, nMaxPSG, $06
	smpsPSGAlterVol     $FD
	dc.b	nMaxPSG
	smpsPSGAlterVol     $03
	dc.b	nMaxPSG
	dc.b	nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG
	smpsLoop            $00, $06, Menu_Loop08
	dc.b	nMaxPSG, $06, nMaxPSG, $03, nMaxPSG, nMaxPSG, $06
	smpsPSGAlterVol     $FD
	dc.b	nMaxPSG
	smpsPSGAlterVol     $03
	dc.b	nMaxPSG
	dc.b	nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG
	dc.b	nMaxPSG, $03, nMaxPSG, nMaxPSG, $06
	smpsPSGAlterVol     $FD
	dc.b	nMaxPSG
	smpsPSGAlterVol     $03
	dc.b	nMaxPSG
	dc.b	nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG
	dc.b	nMaxPSG, $03, nMaxPSG, nMaxPSG, $06
	smpsPSGAlterVol     $FD
	dc.b	nMaxPSG
	dc.b	nMaxPSG
	smpsPSGAlterVol     $03	; restore volume so it does not drift each loop
	smpsJump            Menu_Jump05

Menu_Call01:
	smpsPSGAlterVol     $FD
	dc.b	nMaxPSG
	dc.b	$06
	smpsPSGAlterVol     $03
	dc.b	nMaxPSG
	dc.b	$03, nMaxPSG

Menu_Loop0A:
	dc.b	nMaxPSG, $06
	smpsLoop            $01, $0E, Menu_Loop0A
	smpsReturn

Menu_Call02:
	dc.b	nMaxPSG, $06, nMaxPSG, $03, nMaxPSG

Menu_Loop09:
	dc.b	nMaxPSG, $06
	smpsLoop            $01, $0E, Menu_Loop09
	smpsReturn

Menu_Voices:
;   Synth Bass 2
;	Voice $00
;	$3C
;	$01, $00, $00, $00, 	$1F, $1F, $15, $1F, 	$11, $0D, $12, $05
;	$07, $04, $09, $02, 	$55, $3A, $25, $1A, 	$1A, $80, $07, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $15, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $12, $0D, $11
	smpsVcDecayRate2    $02, $09, $04, $07
	smpsVcDecayLevel    $01, $02, $03, $05
	smpsVcReleaseRate   $0A, $05, $0A, $05
	smpsVcTotalLevel    $00, $07, $00, $1A

;   Bell Horn-type thing
;	Voice $01
;	$3C
;	$71, $72, $3F, $34, 	$8D, $52, $9F, $1F, 	$09, $00, $00, $0D
;	$00, $00, $00, $00, 	$23, $08, $02, $F7, 	$15, $80, $1D, $87
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $04, $0F, $02, $01
	smpsVcRateScale     $00, $02, $01, $02
	smpsVcAttackRate    $1F, $1F, $12, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $00, $00, $09
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $00, $00, $02
	smpsVcReleaseRate   $07, $02, $08, $03
	smpsVcTotalLevel    $07, $1D, $00, $15

;   Wood Block
;	Voice $02
;	$3C
;	$36, $31, $76, $71, 	$94, $9F, $96, $9F, 	$12, $00, $14, $0F
;	$04, $0A, $04, $0D, 	$2F, $0F, $4F, $2F, 	$33, $80, $1A, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $03, $03
	smpsVcCoarseFreq    $01, $06, $01, $06
	smpsVcRateScale     $02, $02, $02, $02
	smpsVcAttackRate    $1F, $16, $1F, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0F, $14, $00, $12
	smpsVcDecayRate2    $0D, $04, $0A, $04
	smpsVcDecayLevel    $02, $04, $00, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1A, $00, $33

;   Strike Bass
;	Voice $03
;	$38
;	$63, $31, $31, $31, 	$10, $13, $1A, $1B, 	$0E, $00, $00, $00
;	$00, $00, $00, $00, 	$3F, $0F, $0F, $0F, 	$1A, $19, $1A, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $06
	smpsVcCoarseFreq    $01, $01, $01, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1B, $1A, $13, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $0E
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $03
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1A, $19, $1A

;   Bright Piano
;	Voice $04
;	$04
;	$71, $41, $31, $31, 	$12, $12, $12, $12, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$23, $80, $23, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $04, $07
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $12, $12, $12, $12
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $23, $00, $23

;   Church Bell
;	Voice $05
;	$14
;	$75, $72, $35, $32, 	$9F, $9F, $9F, $9F, 	$05, $05, $00, $0A
;	$05, $05, $07, $05, 	$2F, $FF, $0F, $2F, 	$1E, $80, $14, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $02
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $02, $05, $02, $05
	smpsVcRateScale     $02, $02, $02, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $00, $05, $05
	smpsVcDecayRate2    $05, $07, $05, $05
	smpsVcDecayLevel    $02, $00, $0F, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $14, $00, $1E

;   Bell Piano
;	Voice $06
;	$1C
;	$73, $72, $33, $32, 	$94, $99, $94, $99, 	$08, $0A, $08, $0A
;	$00, $05, $00, $05, 	$3F, $4F, $3F, $4F, 	$1E, $80, $19, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $03
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $02, $03, $02, $03
	smpsVcRateScale     $02, $02, $02, $02
	smpsVcAttackRate    $19, $14, $19, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $08, $0A, $08
	smpsVcDecayRate2    $05, $00, $05, $00
	smpsVcDecayLevel    $04, $03, $04, $03
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $19, $00, $1E

