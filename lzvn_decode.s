.text

.globl _lzvn_decode

_lzvn_decode:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%r12
#	leaq	Lzvn_decode.opcode_table(%rip), %rbx
	leaq	0x2f2(%rip), %rbx
	xorq	%rax, %rax
	xorq	%r12, %r12
	subq	$8, %rsi
	jb	L_0x2b4
	leaq	-8(%rdx,%rcx), %rcx
	cmpq	%rcx, %rdx
	ja	L_0x2b4
	movzbq	(%rdx), %r9
	movq	(%rdx), %r8
	jmpq	*(%rbx,%r9,8)

L_0x037:
	addq	$1, %rdx
	cmpq	%rcx, %rdx
	ja	L_0x2b4
	movzbq	(%rdx), %r9
	movq	(%rdx), %r8
	jmpq	*(%rbx,%r9,8)
	nopw	%cs:(%rax,%rax)
	nop

L_0x056:
	shrq	$6, %r9
	leaq	2(%rdx,%r9), %rdx
	cmpq	%rcx, %rdx
	ja	L_0x2b4
	movq	%r8, %r12
	bswapq	%r12
	movq	%r12, %r10
	shlq	$5, %r12
	shlq	$2, %r10
	shrq	$53, %r12
	shrq	$61, %r10
	shrq	$16, %r8
	addq	$3, %r10

L_0x089:
	leaq	(%rax,%r9), %r11
	addq	%r10, %r11
	cmpq	%rsi, %r11
	jae	L_0x0d2
	movq	%r8, (%rdi,%rax)
	addq	%r9, %rax
	movq	%rax, %r8
	subq	%r12, %r8
	jb	L_0x2b4
	cmpq	$8, %r12
	jb	L_0x102

L_0x0ae:
	movq	(%rdi,%r8), %r9
	addq	$8, %r8
	movq	%r9, (%rdi,%rax)
	addq	$8, %rax
	subq	$8, %r10
	ja	L_0x0ae
	addq	%r10, %rax
	movzbq	(%rdx), %r9
	movq	(%rdx), %r8
	jmpq	*(%rbx,%r9,8)

L_0x0d2:
	testq	%r9, %r9
	je	L_0x0f6
	leaq	8(%rsi), %r11

L_0x0db:
	movb	%r8b, (%rdi,%rax)
	addq	$1, %rax
	cmpq	%rax, %r11
	je	L_0x2b7
	shrq	$8, %r8
	subq	$1, %r9
	jne	L_0x0db

L_0x0f6:
	movq	%rax, %r8
	subq	%r12, %r8
	jb	L_0x2b4

L_0x102:
	leaq	8(%rsi), %r11

L_0x106:
	movzbq	(%rdi,%r8), %r9
	addq	$1, %r8
	movb	%r9b, (%rdi,%rax)
	addq	$1, %rax
	cmpq	%rax, %r11
	je	L_0x2b7
	subq	$1, %r10
	jne	L_0x106
	movzbq	(%rdx), %r9
	movq	(%rdx), %r8
	jmpq	*(%rbx,%r9,8)

L_0x131:
	shrq	$6, %r9
	leaq	1(%rdx,%r9), %rdx
	cmpq	%rcx, %rdx
	ja	L_0x2b4
	movq	$56, %r10
	andq	%r8, %r10
	shrq	$8, %r8
	shrq	$3, %r10
	addq	$3, %r10
	jmp	L_0x089

L_0x15e:
	shrq	$6, %r9
	leaq	3(%rdx,%r9), %rdx
	cmpq	%rcx, %rdx
	ja	L_0x2b4
	movq	$56, %r10
	movq	$65535, %r12
	andq	%r8, %r10
	shrq	$8, %r8
	shrq	$3, %r10
	andq	%r8, %r12
	shrq	$16, %r8
	addq	$3, %r10
	jmp	L_0x089

L_0x199:
	shrq	$3, %r9
	andq	$3, %r9
	leaq	3(%rdx,%r9), %rdx
	cmpq	%rcx, %rdx
	ja	L_0x2b4
	movq	%r8, %r10
	andq	$775, %r10
	shrq	$10, %r8
	movzbq	%r10b, %r12
	shrq	$8, %r10
	shlq	$2, %r12
	orq	%r12, %r10
	movq	$16383, %r12
	addq	$3, %r10
	andq	%r8, %r12
	shrq	$14, %r8
	jmp	L_0x089

L_0x1e3:
	addq	$1, %rdx
	cmpq	%rcx, %rdx
	ja	L_0x2b4
	movq	%r8, %r10
	andq	$15, %r10
	jmp	L_0x218

L_0x1f9:
	addq	$2, %rdx
	cmpq	%rcx, %rdx
	ja	L_0x2b4
	movq	%r8, %r10
	shrq	$8, %r10
	andq	$255, %r10
	addq	$16, %r10

L_0x218:
	movq	%rax, %r8
	subq	%r12, %r8
	leaq	(%rax,%r10), %r11
	cmpq	%rsi, %r11
	jae	L_0x102
	cmpq	$8, %r12
	jae	L_0x0ae
	jmp	L_0x102

L_0x23a:
	andq	$15, %r8
	leaq	1(%rdx,%r8), %rdx
	jmp	L_0x259

L_0x245:
	shrq	$8, %r8
	andq	$255, %r8
	addq	$16, %r8
	leaq	2(%rdx,%r8), %rdx

L_0x259:
	cmpq	%rcx, %rdx
	ja	L_0x2b4
	leaq	(%rax,%r8), %r11
	negq	%r8
	cmpq	%rsi, %r11
	ja	L_0x28d
	leaq	(%rdi,%r11), %r11

L_0x26e:
	movq	(%rdx,%r8), %r9
	movq	%r9, (%r11,%r8)
	addq	$8, %r8
	jae	L_0x26e
	movq	%r11, %rax
	subq	%rdi, %rax
	movzbq	(%rdx), %r9
	movq	(%rdx), %r8
	jmpq	*(%rbx,%r9,8)

L_0x28d:
	leaq	8(%rsi), %r11

L_0x291:
	movzbq	(%rdx,%r8), %r9
	movb	%r9b, (%rdi,%rax)
	addq	$1, %rax
	cmpq	%rax, %r11
	je	L_0x2b7
	addq	$1, %r8
	jne	L_0x291
	movzbq	(%rdx), %r9
	movq	(%rdx), %r8
	jmpq	*(%rbx,%r9,8)

L_0x2b4:
	xorq	%rax, %rax

L_0x2b7:
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret

.data
#Lzvn_decode.opcode_table:
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x2b7
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x037
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x037
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x2b4
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x2b4
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x2b4
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x2b4
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x2b4
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x131
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x131
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x131
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x131
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x131
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x131
.quad L_0x15e
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x131
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x131
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x131
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x131
.quad L_0x15e
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x199
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x131
.quad L_0x15e
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x056
.quad L_0x131
.quad L_0x15e
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x2b4
.quad L_0x245
.quad L_0x23a
.quad L_0x23a
.quad L_0x23a
.quad L_0x23a
.quad L_0x23a
.quad L_0x23a
.quad L_0x23a
.quad L_0x23a
.quad L_0x23a
.quad L_0x23a
.quad L_0x23a
.quad L_0x23a
.quad L_0x23a
.quad L_0x23a
.quad L_0x23a
.quad L_0x1f9
.quad L_0x1e3
.quad L_0x1e3
.quad L_0x1e3
.quad L_0x1e3
.quad L_0x1e3
.quad L_0x1e3
.quad L_0x1e3
.quad L_0x1e3
.quad L_0x1e3
.quad L_0x1e3
.quad L_0x1e3
.quad L_0x1e3
.quad L_0x1e3
.quad L_0x1e3
.quad L_0x1e3
