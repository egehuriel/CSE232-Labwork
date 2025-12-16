        ORG   $00

        LDAA  $90        ; A = X
        ADDA  #7         ; A = X + 7
        ASLA             ; A = (X + 7) * 2
        STAA  $92        ; temp = (X+7)*2

        LDAA  $91        ; A = Y
        ASLA             ; A = Y * 2
        ASLA             ; A = Y * 4

        SUBA  $92        ; A = 4Y - (X+7)*2  (note: if you want (X+7)*2 - 4Y, swap order below)
       
        STAA  $93        ; store result

        END