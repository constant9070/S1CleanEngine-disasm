
; ---------------------------------------------------------------
SampleTable:
; name?                         type            pointer         Hz              flags?          ; sample id
                dcSample        TYPE_DPCM,      Kick,           8000                            ; $81
                dcSample        TYPE_PCM,       Snare,          24000                           ; $82
                dcSample        TYPE_DPCM,      Timpani,        7250                            ; $83
ErrorDAC:    dcSample    TYPE_DPCM,       ErrorPCM,      0, FLAGS_LOOP       ; $84  NOTE: sample rate is auto-detected from .WAV file                                                       ; $84
                dcSample        TYPE_NONE                                                       ; $85
                dcSample        TYPE_NONE                                                       ; $86
                dcSample        TYPE_NONE                                                       ; $87
                dcSample        TYPE_DPCM,      Timpani,        9750                            ; $88
                dcSample        TYPE_DPCM,      Timpani,        8750                            ; $89
                dcSample        TYPE_DPCM,      Timpani,        7150                            ; $8A
                dcSample        TYPE_DPCM,      Timpani,        7000                            ; $8B
                dcSample        TYPE_NONE                                                       ; $8C
                dc.w    -1      ; end marker

; ---------------------------------------------------------------
                incdac  Kick, "sound/dac/kick.dpcm"
                incdac  Snare, "sound/dac/snare.wav"
                incdac  Timpani, "sound/dac/timpani.dpcm"
                incdac  ErrorPCM, "sound/dac/no_signal.dpcmq"
                even
