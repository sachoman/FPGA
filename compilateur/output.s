JUMP 25
LOADSP r0 sp-0
PUSHR r0
PUSHV 20
POP r0
POP r1
ADD r0 r0 r1
PUSHR r0
POP r0
LOADBP r1 bp
LOADRET sp bp-2
LOADBP bp bp-1
JUMPR r1
PUSHV 2
LOADSP r0 sp-1
PUSHR r0
POP r0
POP r1
MUL r0 r0 r1
PUSHR r0
POP r0
LOADBP r1 bp
LOADRET sp bp-2
LOADBP bp bp-1
JUMPR r1
PUSHV 15
PUSHV 50
LOADSP r0 sp-1
PUSHR r0
PUSHSP sp
PUSHR bp
PUSHV 37
PUSHSP sp
POP bp
LOADSP r0 sp-4
PUSHR r0
JUMP 13
PUSHR r0
POP r1
POP r0
LT r0 r0 r1
PUSHR r0
POP r0
JUMPNOTCOND 90
PUSHSP sp
PUSHR bp
PUSHSP sp
POP bp
PUSHSP sp
PUSHR bp
PUSHV 56
PUSHSP sp
POP bp
LOADSP r0 sp-6
PUSHR r0
JUMP 1
PUSHR r0
POP r0
STORE sp-3 r0
LOADSP r0 sp-3
PUSHR r0
PUSHV 95
POP r1
POP r0
GE r0 r0 r1
PUSHR r0
POP r0
JUMPNOTCOND 78
LOADSP r0 sp-3
PUSHR r0
PUSHV 4
POP r1
POP r0
SUB r0 r0 r1
PUSHR r0
POP r0
STORE sp-3 r0
JUMP 87
LOADSP r0 sp-3
PUSHR r0
PUSHV 1
POP r0
POP r1
ADD r0 r0 r1
PUSHR r0
POP r0
STORE sp-3 r0
LOADRET sp bp-1
LOADBP bp bp
JUMP 27
LOADSP r0 sp-1
PUSHR r0
POP r0
LOADBP r1 bp
LOADRET sp bp-2
LOADBP bp bp-1
JUMPR r1
