        .org  $0000
        jmp   START
        .org  $1000
TEMPS   .byte 20,22,21
TOTAL   .rmb  1

START   ldx   #TEMPS
        ldaa  #0
        ldab  #3

LOOP    adda  0,x
        inx
        decb
        bne   LOOP

        staa  TOTAL
        .end