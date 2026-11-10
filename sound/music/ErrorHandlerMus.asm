Error_Header:
    smpsHeaderStartSong 1
    smpsHeaderVoice     Error_Voices
    smpsHeaderChan      $01, $00
    smpsHeaderTempo     $01, $03

    smpsHeaderDAC       Error_DAC

Error_DAC:
    dc.b    ErrorDAC.id        ; play BGM sample (`bgm` label defined in sample table)
    smpsStop

Error_Voices: