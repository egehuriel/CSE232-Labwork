.data
newline:        .asciiz "\n"
msg_no_treat:   .asciiz "No treat this week.\n"
msg_goal:       .asciiz "Goal met! Nice.\n"

desk_total:     .word 0
hydr_total:     .word 0

steps:          .word 8234, 7411, 9876, 6543, 8120, 7055, 9322
temps:          .word 22, 19, 25, 23, 18, 24

.text
.globl main

# --- helpers ---
print_newline:
    la   a0, newline
    li   a7, 4
    ecall
    ret

print_int:
    li   a7, 1
    ecall
    ret

print_string:
    li   a7, 4
    ecall
    ret

# ============================================================
# main: run all exercises sequentially
# ============================================================
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
# Print totalItems in a0. Extension: store at desk_total.
# ============================================================
ex1:
    li   t0, 2          # notebooks
    li   t1, 3          # pens
    li   t2, 1          # markers
    add  t3, t0, t1
    add  t3, t3, t2     # totalItems

    la   t4, desk_total
    sw   t3, 0(t4)

    mv   a0, t3
    jal  ra, print_int
    jal  ra, print_newline
    ret

# ============================================================
# Exercise 2 — Allowance Snapshot
# Print remaining in a0, canBuyTreat in a0 (2nd line).
# Extension: if 0 print msg.
# (PDF says print remaining in a0 and canBuyTreat in a1;
# Venus print_int uses a0, so we print on two lines.)
# ============================================================
ex2:
    li   t0, 20         # allowance
    li   t1, 7          # lunch
    sub  t2, t0, t1     # remaining

    li   t3, 0          # canBuyTreat
    li   t4, 5
    blt  t2, t4, ex2_flag_done
    li   t3, 1
ex2_flag_done:

    mv   a0, t2
    jal  ra, print_int
    jal  ra, print_newline

    mv   a0, t3
    jal  ra, print_int
    jal  ra, print_newline

    bne  t3, x0, ex2_done
    la   a0, msg_no_treat
    jal  ra, print_string
ex2_done:
    ret

# ============================================================
# Exercise 3 — Hydration Tally
# Print total then needReminder.
# Extension: store total to memory and load back before printing.
# ============================================================
ex3:
    li   t0, 2
    li   t1, 3
    li   t2, 1
    add  t3, t0, t1
    add  t3, t3, t2     # total

    la   t4, hydr_total
    sw   t3, 0(t4)
    lw   t5, 0(t4)

    li   t6, 0          # needReminder
    li   t1, 6          # <-- 6'yı t1'e koyduk
    blt  t5, t1, ex3_need
    j    ex3_print

ex3_need:
    li   t6, 1

ex3_print:
    mv   a0, t5
    li   a7, 1
    ecall

    la   a0, newline
    li   a7, 4
    ecall

    mv   a0, t6
    li   a7, 1
    ecall

    la   a0, newline
    li   a7, 4
    ecall
    ret


# ============================================================
# Exercise 4 — Daily Step Tracker
# Sum steps[7] in a saved register; met_goal (>=50000).
# Print total then met_goal. Extension: print msg_goal if met.
# ============================================================
ex4:
    la   t0, steps
    li   t1, 7
    li   s0, 0          # total in saved reg

ex4_loop:
    lw   t2, 0(t0)
    add  s0, s0, t2
    addi t0, t0, 4
    addi t1, t1, -1
    bne  t1, x0, ex4_loop

    li   t3, 0          # met_goal
    li   t4, 50000
    blt  s0, t4, ex4_flag_done
    li   t3, 1
ex4_flag_done:

    mv   a0, s0
    jal  ra, print_int
    jal  ra, print_newline

    mv   a0, t3
    jal  ra, print_int
    jal  ra, print_newline

    beq  t3, x0, ex4_done
    la   a0, msg_goal
    jal  ra, print_string
ex4_done:
    ret

# ============================================================
# Exercise 5 — Classroom Temperature Alert
# alerts++ if t<20 or t>24; avg=sum/6
# Print alerts then avg. Extension: track coldest/hottest too.
# ============================================================
ex5:
    la   t0, temps
    li   t1, 6
    li   t2, 0          # sum
    li   t3, 0          # alerts

    li   s1,  1000000   # coldest init
    li   s2, -1000000   # hottest init

ex5_loop:
    lw   t4, 0(t0)      # t

    add  t2, t2, t4     # sum += t

    # extension: coldest/hottest
    blt  t4, s1, ex5_set_cold
    j    ex5_hot_check
ex5_set_cold:
    mv   s1, t4
ex5_hot_check:
    blt  s2, t4, ex5_set_hot
    j    ex5_alert_check
ex5_set_hot:
    mv   s2, t4

ex5_alert_check:
    li   t5, 20
    blt  t4, t5, ex5_alert
    li   t6, 24
    blt  t6, t4, ex5_alert
    j    ex5_next

ex5_alert:
    addi t3, t3, 1

ex5_next:
    addi t0, t0, 4
    addi t1, t1, -1
    bne  t1, x0, ex5_loop

    li   t5, 6
    div  t6, t2, t5     # avg

    mv   a0, t3         # alerts
    jal  ra, print_int
    jal  ra, print_newline

    mv   a0, t6         # avg
    jal  ra, print_int
    jal  ra, print_newline

    ret
