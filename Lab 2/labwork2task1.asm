        ORG   $0000

; ----- Initialize Array A at $70 (5 elements) -----
START   LDAA  #8
        STAA  $70
        LDAA  #15
        STAA  $71
        LDAA  #6
        STAA  $72
        LDAA  #3
        STAA  $73
        LDAA  #10
        STAA  $74

; ----- Clear SUM at $90 -----
        LDAA  #0
        STAA  $90

; X points to Array A base
        LDX   #$70
        LDAB  #5

LOOP    LDAA  0,X        ; A = A[i]
        BITA  #1         ; test odd/even WITHOUT changing A
        BEQ   EVEN

; odd: A = A*4 + 1
        ASLA
        ASLA
        ADDA  #1
        BRA   STORE

; even: A = A/2
EVEN    LSRA

STORE   STAA  $10,X      ; store into B at (X + $10) => $80+i
        ADDA  $90        ; sum = sum + B[i]
        STAA  $90

        INX
        DECB
        BNE   LOOP

        END