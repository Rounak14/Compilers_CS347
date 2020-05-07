.data
endline: .asciiz "\n"
.text
_fib:
subu $sp, $sp, 144
sw $ra, 140($sp)
sw $fp, 136($sp)
move $fp, $sp
li $t0, 0
li $t1, 0
li $t2, 0
add $t2, $t2, $t0
li $t3, 2
mul $t2, $t2, $t3
add $t2, $t2, $t1
li $t3, 1
mul $t2, $t2, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t2
sw $t3, 0($s0)
li $t3, 0
li $t2, 1
li $t1, 0
add $t1, $t1, $t3
li $t0, 2
mul $t1, $t1, $t0
add $t1, $t1, $t2
li $t0, 1
mul $t1, $t1, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t1
sw $t0, 0($s0)
li $t0, 1
li $t1, 0
li $t2, 0
add $t2, $t2, $t0
li $t3, 2
mul $t2, $t2, $t3
add $t2, $t2, $t1
li $t3, 1
mul $t2, $t2, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t2
sw $t3, 0($s0)
li $t3, 1
li $t2, 1
li $t1, 0
add $t1, $t1, $t3
li $t0, 2
mul $t1, $t1, $t0
add $t1, $t1, $t2
li $t0, 0
mul $t1, $t1, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t1
sw $t0, 0($s0)
li $t0, 0
li $t1, 0
li $t2, 0
add $t2, $t2, $t0
li $t3, 2
mul $t2, $t2, $t3
add $t2, $t2, $t1
li $t3, 1
mul $t2, $t2, 4
li $s1, 32
addu $s0, $sp, $s1
sub $s0, $s0, $t2
sw $t3, 0($s0)
li $t3, 0
li $t2, 1
li $t1, 0
add $t1, $t1, $t3
li $t0, 2
mul $t1, $t1, $t0
add $t1, $t1, $t2
li $t0, 1
mul $t1, $t1, 4
li $s1, 32
addu $s0, $sp, $s1
sub $s0, $s0, $t1
sw $t0, 0($s0)
li $t0, 1
li $t1, 0
li $t2, 0
add $t2, $t2, $t0
li $t3, 2
mul $t2, $t2, $t3
add $t2, $t2, $t1
li $t3, 1
mul $t2, $t2, 4
li $s1, 32
addu $s0, $sp, $s1
sub $s0, $s0, $t2
sw $t3, 0($s0)
li $t3, 1
li $t2, 1
li $t1, 0
add $t1, $t1, $t3
li $t0, 2
mul $t1, $t1, $t0
add $t1, $t1, $t2
li $t0, 0
mul $t1, $t1, 4
li $s1, 32
addu $s0, $sp, $s1
sub $s0, $s0, $t1
sw $t0, 0($s0)
lw $t0, 144($sp)
li $t1, 0
seq $t2, $t0, $t1
beq $t2, 0, L79
li $t2, 0
move $v0, $t2
j end__fib
L79:
li $t2, 2
sw $t2, 16($sp)
L82:
lw $t1, 16($sp)
lw $t0, 144($sp)
sle $t3, $t1, $t0
beq $t3, 0, L276
j L94
L88:
li $t0, 1
lw $t1, 16($sp)
add $t0, $t0, $t1
sw $t0, 16($sp)
j L82
L94:
li $t0, 0
li $t3, 0
li $t2, 0
add $t2, $t2, $t0
li $t1, 2
mul $t2, $t2, $t1
add $t2, $t2, $t3
mul $t2, $t2, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t2
lw $t1, 0($s0)
li $t2, 0
li $t3, 0
li $t0, 0
add $t0, $t0, $t2
li $t4, 2
mul $t0, $t0, $t4
add $t0, $t0, $t3
mul $t0, $t0, 4
li $s1, 32
addu $s0, $sp, $s1
sub $s0, $s0, $t0
lw $t4, 0($s0)
mul $t0, $t1, $t4
li $t4, 0
li $t1, 1
li $t3, 0
add $t3, $t3, $t4
li $t2, 2
mul $t3, $t3, $t2
add $t3, $t3, $t1
mul $t3, $t3, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t3
lw $t2, 0($s0)
li $t3, 1
li $t1, 0
li $t4, 0
add $t4, $t4, $t3
li $t5, 2
mul $t4, $t4, $t5
add $t4, $t4, $t1
mul $t4, $t4, 4
li $s1, 32
addu $s0, $sp, $s1
sub $s0, $s0, $t4
lw $t5, 0($s0)
mul $t4, $t2, $t5
add $t5, $t0, $t4
sw $t5, 12($sp)
li $t5, 0
li $t4, 0
li $t0, 0
add $t0, $t0, $t5
li $t2, 2
mul $t0, $t0, $t2
add $t0, $t0, $t4
mul $t0, $t0, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t0
lw $t2, 0($s0)
li $t0, 0
li $t4, 1
li $t5, 0
add $t5, $t5, $t0
li $t1, 2
mul $t5, $t5, $t1
add $t5, $t5, $t4
mul $t5, $t5, 4
li $s1, 32
addu $s0, $sp, $s1
sub $s0, $s0, $t5
lw $t1, 0($s0)
mul $t5, $t2, $t1
li $t1, 0
li $t2, 1
li $t4, 0
add $t4, $t4, $t1
li $t0, 2
mul $t4, $t4, $t0
add $t4, $t4, $t2
mul $t4, $t4, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t4
lw $t0, 0($s0)
li $t4, 1
li $t2, 1
li $t1, 0
add $t1, $t1, $t4
li $t3, 2
mul $t1, $t1, $t3
add $t1, $t1, $t2
mul $t1, $t1, 4
li $s1, 32
addu $s0, $sp, $s1
sub $s0, $s0, $t1
lw $t3, 0($s0)
mul $t1, $t0, $t3
add $t3, $t5, $t1
sw $t3, 8($sp)
li $t3, 1
li $t1, 0
li $t5, 0
add $t5, $t5, $t3
li $t0, 2
mul $t5, $t5, $t0
add $t5, $t5, $t1
mul $t5, $t5, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t5
lw $t0, 0($s0)
li $t5, 0
li $t1, 0
li $t3, 0
add $t3, $t3, $t5
li $t2, 2
mul $t3, $t3, $t2
add $t3, $t3, $t1
mul $t3, $t3, 4
li $s1, 32
addu $s0, $sp, $s1
sub $s0, $s0, $t3
lw $t2, 0($s0)
mul $t3, $t0, $t2
li $t2, 1
li $t0, 1
li $t1, 0
add $t1, $t1, $t2
li $t5, 2
mul $t1, $t1, $t5
add $t1, $t1, $t0
mul $t1, $t1, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t1
lw $t5, 0($s0)
li $t1, 1
li $t0, 0
li $t2, 0
add $t2, $t2, $t1
li $t4, 2
mul $t2, $t2, $t4
add $t2, $t2, $t0
mul $t2, $t2, 4
li $s1, 32
addu $s0, $sp, $s1
sub $s0, $s0, $t2
lw $t4, 0($s0)
mul $t2, $t5, $t4
add $t4, $t3, $t2
sw $t4, 4($sp)
li $t4, 1
li $t2, 0
li $t3, 0
add $t3, $t3, $t4
li $t5, 2
mul $t3, $t3, $t5
add $t3, $t3, $t2
mul $t3, $t3, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t3
lw $t5, 0($s0)
li $t3, 0
li $t2, 1
li $t4, 0
add $t4, $t4, $t3
li $t0, 2
mul $t4, $t4, $t0
add $t4, $t4, $t2
mul $t4, $t4, 4
li $s1, 32
addu $s0, $sp, $s1
sub $s0, $s0, $t4
lw $t0, 0($s0)
mul $t4, $t5, $t0
li $t0, 1
li $t5, 1
li $t2, 0
add $t2, $t2, $t0
li $t3, 2
mul $t2, $t2, $t3
add $t2, $t2, $t5
mul $t2, $t2, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t2
lw $t3, 0($s0)
li $t2, 1
li $t5, 1
li $t0, 0
add $t0, $t0, $t2
li $t1, 2
mul $t0, $t0, $t1
add $t0, $t0, $t5
mul $t0, $t0, 4
li $s1, 32
addu $s0, $sp, $s1
sub $s0, $s0, $t0
lw $t1, 0($s0)
mul $t0, $t3, $t1
add $t1, $t4, $t0
sw $t1, 0($sp)
li $t1, 0
li $t0, 0
li $t4, 0
add $t4, $t4, $t1
li $t3, 2
mul $t4, $t4, $t3
add $t4, $t4, $t0
lw $t3, 12($sp)
mul $t4, $t4, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t4
sw $t3, 0($s0)
li $t3, 0
li $t4, 1
li $t0, 0
add $t0, $t0, $t3
li $t1, 2
mul $t0, $t0, $t1
add $t0, $t0, $t4
lw $t1, 8($sp)
mul $t0, $t0, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t0
sw $t1, 0($s0)
li $t1, 1
li $t0, 0
li $t4, 0
add $t4, $t4, $t1
li $t3, 2
mul $t4, $t4, $t3
add $t4, $t4, $t0
lw $t3, 4($sp)
mul $t4, $t4, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t4
sw $t3, 0($s0)
li $t3, 1
li $t4, 1
li $t0, 0
add $t0, $t0, $t3
li $t1, 2
mul $t0, $t0, $t1
add $t0, $t0, $t4
lw $t1, 0($sp)
mul $t0, $t0, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t0
sw $t1, 0($s0)
j L88
L276:
li $t1, 0
li $t0, 0
li $t4, 0
add $t4, $t4, $t1
li $t3, 2
mul $t4, $t4, $t3
add $t4, $t4, $t0
mul $t4, $t4, 4
li $s1, 48
addu $s0, $sp, $s1
sub $s0, $s0, $t4
lw $t3, 0($s0)
move $v0, $t3
j end__fib
end__fib:
move $sp, $fp
lw $ra, 140($sp)
lw $fp, 136($sp)
addu $sp, $sp, 144
j $ra
main:
subu $sp, $sp, 104
sw $ra, 100($sp)
sw $fp, 96($sp)
move $fp, $sp
li $t3, 0
sw $t3, 4($sp)
li $v0 5
syscall
move $t3, $v0
sw $t3, 8($sp)
li $t3, 0
sw $t3, 4($sp)
L294:
lw $t4, 4($sp)
lw $t0, 8($sp)
slt $t1, $t4, $t0
beq $t1, 0, L314
j L305
L300:
lw $t0, 4($sp)
addu $t4, $t0, 1
sw $t4, 4($sp)
j L294
L305:
lw $t4, 4($sp)
sub $sp, $sp, 4
sw $t4, 0($sp)
sw $t0, 96($sp)
sw $t1, 92($sp)
sw $t2, 88($sp)
sw $t3, 84($sp)
sw $t4, 80($sp)
sw $t5, 76($sp)
sw $t6, 72($sp)
sw $t7, 68($sp)
sw $t8, 64($sp)
sw $t9, 60($sp)
s.s $f0, 56($sp)
s.s $f1, 52($sp)
s.s $f2, 48($sp)
s.s $f3, 44($sp)
s.s $f4, 40($sp)
s.s $f5, 36($sp)
s.s $f6, 32($sp)
s.s $f7, 28($sp)
s.s $f8, 24($sp)
s.s $f9, 20($sp)
s.s $f10, 16($sp)
jal _fib
lw $t0, 96($sp)
lw $t1, 92($sp)
lw $t2, 88($sp)
lw $t3, 84($sp)
lw $t4, 80($sp)
lw $t5, 76($sp)
lw $t6, 72($sp)
lw $t7, 68($sp)
lw $t8, 64($sp)
lw $t9, 60($sp)
l.s $f0, 56($sp)
l.s $f1, 52($sp)
l.s $f2, 48($sp)
l.s $f3, 44($sp)
l.s $f4, 40($sp)
l.s $f5, 36($sp)
l.s $f6, 32($sp)
l.s $f7, 28($sp)
l.s $f8, 24($sp)
l.s $f9, 20($sp)
l.s $f10, 16($sp)
move $t4, $v0
add $sp, $sp, 4
sw $t4, 0($sp)
lw $t4, 0($sp)
move $a0, $t4
li $v0 1
syscall
li $v0, 4
la $a0, endline
syscall
j L300
L314:
li $t4, 0
move $v0, $t4
j end_main
end_main:
move $sp, $fp
lw $ra, 100($sp)
lw $fp, 96($sp)
addu $sp, $sp, 104
j $ra
