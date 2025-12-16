        .org  $0000
        jmp   START        ; PC $0000’dan baslarsa $1000’e atla

        .org  $1000

MAXFLOOR .equ  5
FLOOR    .equ  $1001       ; <-- SABIT ADRES (kritik nokta)

START    ldaa  #1
         staa  FLOOR

UP       ldaa  FLOOR
         inca
         staa  FLOOR
         cmpa  #MAXFLOOR
         bne   UP

         .end