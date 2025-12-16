        ORG   $0000

START   LDAA  #5
        STAA  $70
        LDAA  #10
        STAA  $80

        LDAA  $70
        ANDA  #1
        BEQ   EVEN

ODD     LDAA  $70
        ASLA
        SUBA  $80
        STAA  $70
        JMP   EXIT

EVEN    LDAA  $70
        LSRA
        STAA  $70

        LDAA  $80
        ASLA
        ASLA
        STAA  $80

EXIT    END