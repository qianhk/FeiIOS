//.text
//.align 2
//.globl _cmpxchg_64
//.globl _xchg_64
//// extern long xchg_64(register volatile long *pMem, register long reg);
//_xchg_64:
//xchg    %rsi, (%rdi)
//mov     %rsi, %rax
//ret
//

.text
.align 2
.globl _cmpxchg_64
// cmpData:rdi      loadReg:rsi     pMem:rdx
// extern long cmpxchg_64(register long cmpData, register long *loadReg, register volatile long *pMem);
_cmpxchg_64:
push    %rcx
push    %rbx
mov     %rdi, %rax
mov     (%rsi), %rcx
xor     %rbx, %rbx
cmpxchg %rcx, (%rdx)
cmovnz  %rax, %rcx
mov     $1, %rax
cmovz   %rax, %rbx
mov     %rcx, (%rsi)
mov     %rbx, %rax

pop     %rbx
pop     %rcx
ret

//注意，以上汇编都是64位形式的。如果将它们改为32位形式的话只需将寄存器前缀“r”改成“e”即可
