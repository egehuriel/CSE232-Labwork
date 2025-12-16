.data
newline:        .asciiz "\n"
msg_no_treat:   .asciiz "No treat this week.\n"
msg_goal:       .asciiz "Goal met! Nice.\n"

desk_total:     .word 0

steps:          .word 8234, 7411, 9876, 6543, 8120, 7055, 9322
temps:          .word 22, 19, 25, 23, 18, 24

.text
.globl main

# -------------------------
# Small helpers
# -------------------------
print_newline:
    la   a0, newline
    li   a7, 4
    ecall
    ret

print_int_a0:
    li   a7, 1
    ecall
    ret

print_string_a0:
    li   a7, 4
    ecall
    ret

# -------------------------
# MAIN: run all exercises
# -------------------------
main:
    jal  ra, ex1
    jal  ra, ex2
    jal  ra, ex3
    jal  ra, ex4
    jal  ra, ex5

    li   a7, 10
    ecall

# ============================================================
# Exercise 1 — Desk Supplies Count
# notebooks=2; pens=3; markers=1; totalItems = sum
# Print total once. Extension: store to desk_total
# ============================================================
ex1:
    li   t0, 2          # notebooks
    li   t1, 3          # pens
    li   t2, 1          # markers
    add  t3, t0, t1
    add  t3, t3, t2     # totalItems in t3

    la   t4, desk_total
    sw   t3, 0(t4)

    mv   a0, t3
    jal  ra, print_int_a0
    jal  ra, print_newline
    ret

# ============================================================
# Exercise 2 — Allowance Snapshot
# allowance=20; lunch=7; remaining=allowance-lunch
# canBuyTreat = (remaining >= 5)
# Print remaining (a0) and canBuyTreat (a1)
# Extension: if 0 print msg
# ============================================================
ex2:
    li   t0, 20         # allowance
    li   t1, 7          # lunch
    sub  t2, t0, t1     # remaining

    li   t3, 0          # canBuyTreat default 0
    li   t4, 5
    blt  t2, t4, ex2_setdone
    li   t3, 1
ex2_setdone:
    mv   a0, t2
    jal  ra, print_int_a0
    jal  ra, print_newline

    mv   a0, t3         # print canBuyTreat
    jal  ra, print_int_a0
    jal  ra, print_newline

    bne  t3, x0, ex2_done
    la   a0, msg_no_treat
    jal  ra, print_string_a0
ex2_done:
    ret

# ============================================================
# Exercise 3 — Hydration Tally
# cupsMorning=2; cupsAfternoon=3; cupsEvening=1
# total = sum; needReminder=1 if total < 6 else 0
# Print total then needReminder
# Extension: store total to memory and load before printing
# ============================================================
ex3:
    li   t0, 2
    li   t1, 3
    li   t2, 1
    add  t3, t0, t1
    add  t3, t3, t2     # total

    li   t4, 0          # needReminder
    li   t5, 6
    blt  t3, t5, ex3_need
    j    ex3_print
ex3_need:
    li   t4, 1

ex3_print:
    mv   a0, t3
    jal  ra, print_int_a0
    jal  ra, print_newline

    mv   a0, t4
    jal  ra, print_int_a0
    jal  ra, print_newline
    ret

# ============================================================
# Exercise 4 — Daily Step Tracker
# steps[7] sum, met_goal = (total >= 50000)
# Print total then met_goal
# Extension: if met_goal print msg_goal
# ============================================================
ex4:
    la   t0, steps      # ptr
    li   t1, 7          # count
    li   s0, 0          # total in saved reg (as requested)

ex4_loop:
    lw   t2, 0(t0)
    add  s0, s0, t2
    addi t0, t0, 4
    addi t1, t1, -1
    bne  t1, x0, ex4_loop

    li   t3, 0          # met_goal
    li   t4, 50000
    blt  s0, t4, ex4_doneflag
    li   t3, 1
ex4_doneflag:
    mv   a0, s0
    jal  ra, print_int_a0
    jal  ra, print_newline

    mv   a0, t3
    jal  ra, print_int_a0
    jal  ra, print_newline

    beq  t3, x0, ex4_done
    la   a0, msg_goal
    jal  ra, print_string_a0
ex4_done:
    ret

# ============================================================
# Exercise 5 — Classroom Temperature Alert
# temps[6] = {22,19,25,23,18,24}
# alerts++ if (t < 20 || t > 24)
# avg = sum / 6
# Print alerts then avg (as ints)
# ============================================================
ex5:
    la   t0, temps
    li   t1, 6
    li   t2, 0          # sum
    li   t3, 0          # alerts

ex5_loop:
    lw   t4, 0(t0)      # t = temps[i]
    add  t2, t2, t4     # sum += t

    li   t5, 20
    blt  t4, t5, ex5_alert
    li   t6, 24
    blt  t6, t4, ex5_alert   # if 24 < t => t > 24
    j    ex5_next

ex5_alert:
    addi t3, t3, 1

ex5_next:
    addi t0, t0, 4
    addi t1, t1, -1
    bne  t1, x0, ex5_loop

    li   t5, 6
    div  t6, t2, t5     # avg = sum / 6

    mv   a0, t3         # print alerts
    jal  ra, print_int_a0
    jal  ra, print_newline

    mv   a0, t6         # print avg
    jal  ra, print_int_a0
    jal  ra, print_newline
    ret
