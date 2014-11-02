.text

.globl _lzvn_encode
.globl _lzvn_encode_work_size

_lzvn_encode:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%r8, %rax
	movq	%rcx, %rbx
	movq	$0x0, -0x10(%rbp)
	leaq	-0x10(%rbp), %r8
	movq	%rax, %r9
	callq	_lzvn_encode_partial
	xorl	%ecx, %ecx
	cmpq	%rbx, -0x10(%rbp)
	cmoveq	%rax, %rcx
	movq	%rcx, %rax
	addq	$0x8, %rsp
	popq	%rbx
	popq	%rbp
	retq

_lzvn_encode_partial:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$0xc8, %rsp
	movq	%r9, -0xc0(%rbp)
	movq	%r8, -0xe8(%rbp)
	movq	%rdx, %r12
	movq	%r12, -0xb0(%rbp)
	movq	%rdi, -0xd8(%rbp)
	xorl	%edx, %edx
	cmpq	$0x8, %rsi
	jb		Lzvn_807d1
	cmpq	$0x8, %rcx
	movl	$0x0, %ebx
	jb		Lzvn_8092c
	movl	$0xffffffff, %eax
	addq	$-0x8, %rsi
	movl	(%r12), %r10d
	movd	%r10d, %xmm0
	pshufd	$0x0, %xmm0, %xmm0
	pxor	%xmm1, %xmm1
	xorl	%edx, %edx

Lzvn_7fa2a:
	movdqa	%xmm1, (%r9,%rdx)
	movdqa	%xmm0, 0x10(%r9,%rdx)
	addq	$0x20, %rdx
	cmpq	$0x80000, %rdx
	jne		Lzvn_7fa2a
	cmpq	%rax, %rcx
	cmovaq	%rax, %rcx
	movq	%rcx, -0x68(%rbp)
	leaq	(%rdi,%rsi), %r11
	movq	%r11, -0xc8(%rbp)
	xorl	%eax, %eax
	cmpq	$0x9, %rcx
	jb		Lzvn_807d8
	testq	%rsi, %rsi
	movq	%rdi, %r8
	jle		Lzvn_807db
	movq	%r11, %r14
	movq	%rcx, -0x68(%rbp)
	leaq	-0x1(%r12), %rax
	movq	%rax, -0xe0(%rbp)
	xorl	%eax, %eax
	movq	%rax, -0x90(%rbp)
	movq	%rdi, -0x78(%rbp)
	xorl	%r13d, %r13d
	xorl	%esi, %esi
	xorl	%eax, %eax
	movq	%rax, -0x50(%rbp)
	xorl	%eax, %eax
	movq	%rax, -0xb8(%rbp)
	movq	%rdi, -0xd0(%rbp)
	movq	%rdi, -0xd8(%rbp)
	xorl	%edi, %edi
	xorl	%r8d, %r8d
	xorl	%r11d, %r11d
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	movl	%r10d, %eax
	jmp		Lzvn_7faed

Lzvn_7fac5:
	movq	%r11, %r14
	incq	%rsi
	movl	(%r12,%rsi), %eax
	decq	-0x90(%rbp)
	movq	%rdi, %rcx
	movq	%rcx, -0x50(%rbp)
	movq	%rdx, %rdi
	movq	-0x40(%rbp), %r8
	movq	%rbx, %r11
	movq	%r10, %rdx
	movq	%r15, %rcx

Lzvn_7faed:
	movl	%eax, -0x84(%rbp)
	movl	%eax, %ebx
	andl	$0xffffff, %eax
	imull	$0x1041, %eax, %eax
	shrl	$0xc, %eax
	andl	$0x3fff, %eax
	shlq	$0x5, %rax
	movdqa	(%r9,%rax), %xmm0
	movdqa	0x10(%r9,%rax), %xmm1
	pshufd	$-0x70, %xmm1, %xmm3
	pshufd	$-0x70, %xmm0, %xmm4
	movd	%esi, %xmm2
	movss	%xmm2, %xmm4
	movd	%ebx, %xmm2
	movss	%xmm2, %xmm3
	movaps	%xmm3, 0x10(%r9,%rax)
	movaps	%xmm4, (%r9,%rax)
	testq	%rsi, %rsi
	je		Lzvn_7fc0f
	cmpq	%r13, %rsi
	jb		Lzvn_7fc0f
	movq	%rdi, -0xa8(%rbp)
	movq	%rcx, -0x80(%rbp)
	movq	%r11, -0xa0(%rbp)
	movq	-0x68(%rbp), %r10
	pshufd	$0x0, %xmm2, %xmm2
	pxor	%xmm2, %xmm1
	movd	%xmm1, %ecx
	testl	%ecx, %ecx
	movl	$0x4, %eax
	je		Lzvn_7fbba
	movq	%rdx, -0x70(%rbp)
	movl	%ecx, %eax
	bsfq	%rax, %rax
	cmpq	$0x18, %rax
	movl	$0x0, %ecx
	movq	%rcx, -0x48(%rbp)
	movl	$0x0, %ecx
	movq	%rcx, -0x60(%rbp)
	movl	$0x0, %edi
	movl	$0x0, %r11d
	movl	$0x0, %ecx
	jb		Lzvn_7fd23
	shrq	$0x3, %rax
	movq	-0x70(%rbp), %rdx

Lzvn_7fbba:
	movq	%rdx, -0x70(%rbp)
	movd	%xmm0, %ecx
	movl	%ecx, %r14d
	movq	%rsi, %r15
	subq	%r14, %r15
	cmpq	$0xffff, %r15
	movl	$0x0, %ecx
	movq	%rcx, -0x48(%rbp)
	movl	$0x0, %ecx
	movq	%rcx, -0x60(%rbp)
	movl	$0x0, %edi
	movl	$0x0, %r11d
	movl	$0x0, %ecx
	ja		Lzvn_7fd23
	leaq	(%rax,%rsi), %r11
	cmpq	$0x4, %rax
	jne		Lzvn_7fc6c
	movq	%r8, -0x40(%rbp)
	leaq	0x4(%rax,%rsi), %rax
	jmp		Lzvn_7fc37

Lzvn_7fc0f:
	movq	%rcx, %r15
	movq	%rdx, %r10
	movq	%r11, %rbx
	movq	%r8, -0x40(%rbp)
	movq	%rdi, %rdx
	movq	-0x50(%rbp), %rcx
	movq	%rcx, %rdi
	movq	-0x68(%rbp), %rcx
	movq	%r14, %r11
	jmp		Lzvn_807a7

Lzvn_7fc32:
	leaq	0x4(%rdx,%rax), %rax

Lzvn_7fc37:
	cmpq	%r10, %rax
	movq	%r11, %rax
	jae		Lzvn_7fc70
	movq	%rax, %rdx
	subq	%r15, %rdx
	movl	(%r12,%rax), %ebx
	movl	(%r12,%rdx), %edi
	cmpl	%edi, %ebx
	movl	$0x4, %edx
	je		Lzvn_7fc60
	xorl	%ebx, %edi
	bsfq	%rdi, %rdx
	shrq	$0x3, %rdx

Lzvn_7fc60:
	leaq	(%rdx,%rax), %r11
	cmpq	$0x4, %rdx
	je		Lzvn_7fc32
	jmp		Lzvn_7fc70

Lzvn_7fc6c:
	movq	%r8, -0x40(%rbp)

Lzvn_7fc70:
	movq	-0xe0(%rbp), %rax
	leaq	(%rax,%rsi), %rdx
	leaq	(%rax,%r14), %rdi
	xorl	%ebx, %ebx

Lzvn_7fc81:
	movq	%rbx, %rax
	leaq	(%rsi,%rax), %rcx
	movq	%r14, %rbx
	addq	%rax, %rbx
	je		Lzvn_7fcb3
	cmpq	%r13, %rcx
	jbe		Lzvn_7fcb3
	movq	%rcx, %r8
	movq	%rsi, %rcx
	movzbl	(%rdi,%rax), %esi
	movzbl	(%rdx,%rax), %r9d
	leaq	-0x1(%rax), %rbx
	cmpl	%esi, %r9d
	movq	%rcx, %rsi
	movq	%r8, %rcx
	je		Lzvn_7fc81

Lzvn_7fcb3:
	cmpq	$0x5ff, %r15
	seta	%dl
	movzbl	%dl, %r8d
	movq	%rsi, %r9
	leaq	0x2(%r8,%r9), %rsi
	subq	%r11, %rsi
	addq	%rax, %rsi
	setne	%sil
	cmpq	$0x1, %r11
	seta	%bl
	movq	-0x90(%rbp), %rdi
	leaq	(%r11,%rdi), %rdi
	movq	$-0x2, %rdx
	subq	%r8, %rdx
	addq	%rdi, %rdx
	subq	%rax, %rdx
	subq	%rax, %rdi
	orb		%sil, %bl
	movq	%r9, %rsi
	movl	$0x0, %eax
	cmoveq	%rax, %rdx
	movq	%rdx, -0x48(%rbp)
	cmoveq	%rax, %r15
	cmoveq	%rax, %rdi
	cmoveq	%rax, %r11
	cmoveq	%rax, %rcx
	movq	%r15, -0x60(%rbp)
	movq	-0x40(%rbp), %r8

Lzvn_7fd23:
	movq	%rdi, -0x58(%rbp)
	movq	%rcx, -0x40(%rbp)
	pshufd	$0x1, %xmm1, %xmm2
	movd	%xmm2, %eax
	testl	%eax, %eax
	movl	$0x4, %edx
	je		Lzvn_7fd4d
	movl	%eax, %eax
	bsfq	%rax, %rdx
	cmpq	$0x18, %rdx
	jb		Lzvn_7fd67
	shrq	$0x3, %rdx

Lzvn_7fd4d:
	pshufd	$0x1, %xmm0, %xmm2
	movd	%xmm2, %eax
	movl	%eax, %eax
	movq	%rsi, %rcx
	subq	%rax, %rcx
	cmpq	$0xffff, %rcx
	jbe		Lzvn_7fd72

Lzvn_7fd67:
	movq	%rsi, %r15
	movq	%r10, %r9
	jmp		Lzvn_7fe35

Lzvn_7fd72:
	movq	%rsi, %rdi
	leaq	(%rdx,%rdi), %rsi
	cmpq	$0x4, %rdx
	jne		Lzvn_7fdc3
	leaq	0x4(%rdx,%rdi), %rdx
	movq	%rdi, %r15
	jmp		Lzvn_7fd8e

Lzvn_7fd89:
	leaq	0x4(%rdi,%rdx), %rdx

Lzvn_7fd8e:
	cmpq	%r10, %rdx
	movq	%rsi, %rdx
	jae		Lzvn_7fdc6
	movq	%rdx, %rsi
	subq	%rcx, %rsi
	movl	(%r12,%rdx), %ebx
	movl	(%r12,%rsi), %esi
	cmpl	%esi, %ebx
	movl	$0x4, %edi
	je		Lzvn_7fdb7
	xorl	%ebx, %esi
	bsfq	%rsi, %rdi
	shrq	$0x3, %rdi

Lzvn_7fdb7:
	leaq	(%rdi,%rdx), %rsi
	cmpq	$0x4, %rdi
	je		Lzvn_7fd89
	jmp		Lzvn_7fdc6

Lzvn_7fdc3:
	movq	%rdi, %r15

Lzvn_7fdc6:
	movq	%r10, %r9
	movq	%r15, %rdx

Lzvn_7fdcc:
	movq	%rdx, %r14
	testq	%rax, %rax
	je		Lzvn_7fdf0
	cmpq	%r13, %r14
	jbe		Lzvn_7fdf0
	leaq	-0x1(%r14), %rdx
	movzbl	-0x1(%r12,%rax), %edi
	decq	%rax
	movzbl	-0x1(%r12,%r14), %ebx
	cmpl	%edi, %ebx
    je		Lzvn_7fdcc

Lzvn_7fdf0:
	movq	%rsi, %rax
	subq	%r14, %rax
	cmpq	$0x5ff, %rcx
	seta	%dl
	movzbl	%dl, %edi
	orq		$0x2, %rdi
	movq	%rax, %rdx
	subq	%rdi, %rdx
	cmpq	-0x48(%rbp), %rdx
	ja		Lzvn_7fe22
	cmpq	-0x48(%rbp), %rdx
	jne		Lzvn_7fe35
	leaq	0x1(%r11), %rdi
	cmpq	%rdi, %rsi
	jbe		Lzvn_7fe35

Lzvn_7fe22:
	movq	%rdx, -0x48(%rbp)
	movq	%rcx, -0x60(%rbp)
	movq	%rax, -0x58(%rbp)
	movq	%rsi, %r11
	movq	%r14, -0x40(%rbp)

Lzvn_7fe35:
	movdqa	%xmm1, %xmm2
	punpckhdq	%xmm2, %xmm2
	movd	%xmm2, %eax
	testl	%eax, %eax
	movl	$0x4, %edx
	movq	%r9, %r14
	je		Lzvn_7fe5d
	movl	%eax, %eax
	bsfq	%rax, %rdx
	cmpq	$0x18, %rdx
	jb		Lzvn_7fe7a
	shrq	$0x3, %rdx

Lzvn_7fe5d:
	movdqa	%xmm0, %xmm2
	punpckhdq	%xmm2, %xmm2
	movd	%xmm2, %eax
	movl	%eax, %eax
	movq	%r15, %r9
	subq	%rax, %r9
	cmpq	$0xffff, %r9
	jbe		Lzvn_7fe86

Lzvn_7fe7a:
	movq	%r15, %r10
	movq	-0x70(%rbp), %r15
	jmp		Lzvn_7ff47

Lzvn_7fe86:
	leaq	(%rdx,%r15), %rsi
	cmpq	$0x4, %rdx
	jne		Lzvn_7fed4
	leaq	0x4(%rdx,%r15), %rdx
	movq	%r15, %r10
	jmp		Lzvn_7fe9f

Lzvn_7fe9a:
	leaq	0x4(%rdi,%rdx), %rdx

Lzvn_7fe9f:
	cmpq	%r14, %rdx
	movq	%rsi, %rdx
	jae		Lzvn_7fed7
	movq	%rdx, %rsi
	subq	%r9, %rsi
	movl	(%r12,%rdx), %ebx
	movl	(%r12,%rsi), %esi
	cmpl	%esi, %ebx
	movl	$0x4, %edi
	je		Lzvn_7fec8
	xorl	%ebx, %esi
	bsfq	%rsi, %rdi
	shrq	$0x3, %rdi

Lzvn_7fec8:
	leaq	(%rdi,%rdx), %rsi
	cmpq	$0x4, %rdi
	je		Lzvn_7fe9a
	jmp		Lzvn_7fed7

Lzvn_7fed4:
	movq	%r15, %r10

Lzvn_7fed7:
	movq	%r10, %rdi
	movq	-0x70(%rbp), %r15

Lzvn_7fede:
	movq	%rdi, %rdx
	testq	%rax, %rax
	je		Lzvn_7ff02
	cmpq	%r13, %rdx
	jbe		Lzvn_7ff02
	leaq	-0x1(%rdx), %rdi
	movzbl	-0x1(%r12,%rax), %ebx
	decq	%rax
	movzbl	-0x1(%r12,%rdx), %ecx
	cmpl	%ebx, %ecx
	je		Lzvn_7fede

Lzvn_7ff02:
	movq	%rsi, %rax
	subq	%rdx, %rax
	cmpq	$0x5ff, %r9
	seta	%cl
	movzbl	%cl, %ecx
	orq	$0x2, %rcx
	movq	%rax, %rdi
	subq	%rcx, %rdi
	cmpq	-0x48(%rbp), %rdi
	ja		Lzvn_7ff34
	cmpq	-0x48(%rbp), %rdi
	jne		Lzvn_7ff47
	leaq	0x1(%r11), %rcx
	cmpq	%rcx, %rsi
	jbe		Lzvn_7ff47

Lzvn_7ff34:
	movq	%rdi, -0x48(%rbp)
	movq	%r9, -0x60(%rbp)
	movq	%rax, -0x58(%rbp)
	movq	%rsi, %r11
	movq	%rdx, -0x40(%rbp)

Lzvn_7ff47:
	movq	%r11, -0x98(%rbp)
	pshufd	$0x3, %xmm1, %xmm1
	movd	%xmm1, %eax
	testl	%eax, %eax
	movl	$0x4, %edx
	je		Lzvn_7ff70
	movl	%eax, %eax
	bsfq	%rax, %rdx
	cmpq	$0x18, %rdx
	jb		Lzvn_7ff8a
	shrq	$0x3, %rdx

Lzvn_7ff70:
	pshufd	$0x3, %xmm0, %xmm0
	movd	%xmm0, %eax
	movl	%eax, %eax
	movq	%r10, %r9
	subq	%rax, %r9
	cmpq	$0xffff, %r9
	jbe		Lzvn_7ff93

Lzvn_7ff8a:
	movq	%r10, -0x38(%rbp)
	jmp		Lzvn_8005e

Lzvn_7ff93:
	leaq	(%rdx,%r10), %rsi
	cmpq	$0x4, %rdx
	jne		Lzvn_7ffe2
	leaq	0x4(%rdx,%r10), %rdx
	movq	%r10, -0x38(%rbp)
	jmp		Lzvn_7ffad

Lzvn_7ffa8:
	leaq	0x4(%rdi,%rdx), %rdx

Lzvn_7ffad:
	cmpq	%r14, %rdx
	movq	%rsi, %rdx
	jae		Lzvn_7ffe6
	movq	%rdx, %rsi
	subq	%r9, %rsi
	movl	(%r12,%rdx), %ebx
	movl	(%r12,%rsi), %esi
	cmpl	%esi, %ebx
	movl	$0x4, %edi
	je		Lzvn_7ffd6
	xorl	%ebx, %esi
	bsfq	%rsi, %rdi
	shrq	$0x3, %rdi

Lzvn_7ffd6:
	leaq	(%rdi,%rdx), %rsi
	cmpq	$0x4, %rdi
	je		Lzvn_7ffa8
	jmp		Lzvn_7ffe6

Lzvn_7ffe2:
	movq	%r10, -0x38(%rbp)

Lzvn_7ffe6:
	movq	-0x38(%rbp), %rdi

Lzvn_7ffea:
	movq	%rdi, %rdx
	testq	%rax, %rax
	je		Lzvn_8000e
	cmpq	%r13, %rdx
	jbe		Lzvn_8000e
	leaq	-0x1(%rdx), %rdi
	movzbl	-0x1(%r12,%rax), %ebx
	decq	%rax
	movzbl	-0x1(%r12,%rdx), %ecx
	cmpl	%ebx, %ecx
	je		Lzvn_7ffea

Lzvn_8000e:
	movq	%rsi, %rax
	subq	%rdx, %rax
	cmpq	$0x5ff, %r9
	seta	%cl
	movzbl	%cl, %ecx
	orq	$0x2, %rcx
	movq	%rax, %rdi
	subq	%rcx, %rdi
	cmpq	-0x48(%rbp), %rdi
	ja		Lzvn_80047
	cmpq	-0x48(%rbp), %rdi
	jne		Lzvn_8005e
	movq	-0x98(%rbp), %rcx
	leaq	0x1(%rcx), %rcx
	cmpq	%rcx, %rsi
	jbe		Lzvn_8005e

Lzvn_80047:
	movq	%rdi, -0x48(%rbp)
	movq	%r9, -0x60(%rbp)
	movq	%rax, -0x58(%rbp)
	movq	%rsi, -0x98(%rbp)
	movq	%rdx, -0x40(%rbp)

Lzvn_8005e:
	movq	%r14, %r11
	movq	-0x50(%rbp), %rbx
	testq	%rbx, %rbx
	je		Lzvn_800bc
	movq	-0x38(%rbp), %rcx
	movq	%rcx, %r14
	subq	%rbx, %r14
	movl	(%r12,%r14), %edx
	movl	-0x84(%rbp), %esi
	cmpl	%edx, %esi
	movl	$0x4, %eax
	movq	-0x58(%rbp), %r10
	je		Lzvn_8009e
	xorl	%esi, %edx
	bsfq	%rdx, %rax
	cmpl	$0x18, %eax
	jb		Lzvn_801a7
	shrq	$0x3, %rax

Lzvn_8009e:
	cmpq	$0xffff, %rbx
	ja		Lzvn_801a7
	leaq	(%rax,%rcx), %rsi
	cmpq	$0x4, %rax
	jne		Lzvn_800fd
	leaq	0x4(%rax,%rcx), %rax
	jmp		Lzvn_800ca

Lzvn_800bc:
	movq	-0x58(%rbp), %r10
	jmp		Lzvn_801a7

Lzvn_800c5:
	leaq	0x4(%rdx,%rax), %rax

Lzvn_800ca:
	cmpq	%r11, %rax
	movq	%rsi, %rax
	jae		Lzvn_800fd
	movq	%rax, %rcx
	subq	%rbx, %rcx
	movl	(%r12,%rax), %edi
	movl	(%r12,%rcx), %esi
	cmpl	%esi, %edi
	movl	$0x4, %edx
	je		Lzvn_800f3
	xorl	%edi, %esi
	bsfq	%rsi, %rdx
	shrq	$0x3, %rdx

Lzvn_800f3:
	leaq	(%rdx,%rax), %rsi
	cmpq	$0x4, %rdx
	je		Lzvn_800c5

Lzvn_800fd:
    movq	-0xe0(%rbp), %rax
    movq	-0x38(%rbp), %rcx
    leaq	(%rax,%rcx), %r9
    leaq	(%rax,%r14), %rbx
    xorl	%ecx, %ecx

Lzvn_80112:
	movq	%rcx, %rdx
	movq	-0x38(%rbp), %rax
	leaq	(%rax,%rdx), %rax
	movq	%r14, %rcx
	addq	%rdx, %rcx
	je		Lzvn_8013c
	cmpq	%r13, %rax
	jbe		Lzvn_8013c
	movzbl	(%rbx,%rdx), %edi
	movzbl	(%r9,%rdx), %r15d
	leaq	-0x1(%rdx), %rcx
	cmpl	%edi, %r15d
	je		Lzvn_80112

Lzvn_8013c:
	movq	-0x90(%rbp), %rcx
	leaq	(%rcx,%rsi), %rcx
	subq	%rdx, %rcx
	leaq	-0x1(%rcx), %r14
	cmpq	-0x48(%rbp), %r14
	movq	-0x70(%rbp), %r15
	movq	-0x50(%rbp), %rbx
	movq	-0x58(%rbp), %rdi
	ja		Lzvn_8018e
	movq	%rdi, %r9
	movq	-0x48(%rbp), %rdi
	leaq	0x1(%rdi), %rdi
	subq	%rsi, %rdi
	addq	-0x38(%rbp), %rdi
	addq	%rdx, %rdi
	jne 	Lzvn_804a5
	movq	-0x98(%rbp), %rdx
	leaq	0x1(%rdx), %rdx
	cmpq	%rdx, %rsi
	movq	%r9, %r10
	jbe		Lzvn_801a7

Lzvn_8018e:
	movq	%r14, -0x48(%rbp)
	movq	%rbx, %rdx
	movq	%rdx, -0x60(%rbp)
	movq	%rcx, %r10
	movq	%rsi, -0x98(%rbp)
	movq	%rax, -0x40(%rbp)

Lzvn_801a7:
	testq	%r10, %r10
	je	Lzvn_80323
	testq	%r15, %r15
	movq	-0x38(%rbp), %rsi
	movq	-0xa0(%rbp), %rax
	movq	-0x80(%rbp), %rcx
	je		Lzvn_8035f
	movq	-0x40(%rbp), %rdx
	cmpq	%rdx, %rax
	movq	-0xc8(%rbp), %r11
	movq	-0x98(%rbp), %rbx
	jbe		Lzvn_80384
	movq	-0xa8(%rbp), %rsi
	cmpq	%rsi, -0x48(%rbp)
	cmovaq	-0x60(%rbp), %rcx
	movq	%rcx, -0x80(%rbp)
	cmovaq	%r10, %r15
	cmovaq	%rbx, %rax
	movq	%rax, %r10
	cmovaq	%rdx, %r8
	leaq	(%r12,%r13), %rsi
	subq	%r13, %r8
	cmpq	$0x10, %r8
	movq	-0xc0(%rbp), %r9
	movq	-0x78(%rbp), %r13
	jb		Lzvn_8027f

Lzvn_8021e:
	cmpq	$0x10f, %r8
	movl	$0x10f, %eax
	cmovbq	%r8, %rax
	leaq	0xa(%rax,%r13), %rcx
	cmpq	%r11, %rcx
	jae		Lzvn_80681
	movq	%rax, %rcx
	shlq	$0x8, %rcx
	addl	$0xf0e0, %ecx
	movw	%cx, (%r13)
	testq	%rax, %rax
	je		Lzvn_8026e
	leaq	0x2(%r13), %rcx
	xorl	%edx, %edx

Lzvn_80259:
	movq	(%rsi,%rdx), %rdi
	movq	%rdi, -0x30(%rbp)
	movq	%rdi, (%rcx,%rdx)
	addq	$0x8, %rdx
	cmpq	%rax, %rdx
	jb		Lzvn_80259

Lzvn_8026e:
	subq	%rax, %r8
	leaq	0x2(%rax,%r13), %r13
	addq	%rax, %rsi
	cmpq	$0xf, %r8
	ja		Lzvn_8021e

Lzvn_8027f:
	cmpq	$0x4, %r8
	jb		Lzvn_802cc
	leaq	0xa(%r8,%r13), %rax
	cmpq	%r11, %rax
	movq	%r11, %rbx
	jae		Lzvn_80689
	leal	0xe0(%r8), %eax
	movb	%al, (%r13)
	testq	%r8, %r8
	je		Lzvn_802c1
	leaq	0x1(%r13), %rax
	xorl	%ecx, %ecx

Lzvn_802ac:
	movq	(%rsi,%rcx), %rdx
	movq	%rdx, -0x30(%rbp)
	movq	%rdx, (%rax,%rcx)
	addq	$0x8, %rcx
	cmpq	%r8, %rcx
	jb		Lzvn_802ac

Lzvn_802c1:
	leaq	0x1(%r8,%r13), %r13
	addq	%r8, %rsi
	xorl	%r8d, %r8d

Lzvn_802cc:
	leaq	(%r8,%r8), %rax
	movl	$0xa, %edi
	subq	%rax, %rdi
	cmpq	%r15, %rdi
	cmovaeq	%r15, %rdi
	leaq	0x8(%r13), %rax
	cmpq	%r11, %rax
	movq	%r11, %rbx
	jae		Lzvn_80689
	movq	%r15, %rcx
	subq	%rdi, %rcx
	leaq	-0x3(%rdi), %rax
	movl	(%rsi), %ebx
	movq	-0x80(%rbp), %rsi
	cmpq	-0x50(%rbp), %rsi
	jne		Lzvn_804ad
	testq	%r8, %r8
	je		Lzvn_805d8
	movq	%r8, %rdx
	shlq	$0x6, %rdx
	leaq	0x6(%rdx,%rax,8), %rdi
	jmp		Lzvn_805df

Lzvn_80323:
	movq	-0x80(%rbp), %rax
	movq	%r15, %r10
	movq	%rax, %r15
	movq	-0xa0(%rbp), %rax
	movq	%r8, -0x40(%rbp)
	movq	-0xa8(%rbp), %rdx
	movq	%rbx, %rdi
	movq	%r11, %rcx
	movq	%rax, %rbx
	movq	-0xc8(%rbp), %r11
	movq	-0xc0(%rbp), %r9
	movq	-0x38(%rbp), %rsi
	jmp		Lzvn_807a7

Lzvn_8035f:
	movq	%rbx, %rdi
	movq	-0xc8(%rbp), %r11
	movq	-0xc0(%rbp), %r9
	movq	-0x48(%rbp), %rdx
	movq	-0x60(%rbp), %r15
	movq	-0x98(%rbp), %rbx
	jmp		Lzvn_807a3

Lzvn_80384:
	movq	%r10, -0x58(%rbp)
	leaq	(%r12,%r13), %rsi
	subq	%r13, %r8
	cmpq	$0x10, %r8
	movq	-0xc0(%rbp), %r9
	movq	-0x78(%rbp), %r13
	jb		Lzvn_80401

Lzvn_803a0:
	cmpq	$0x10f, %r8
	movl	$0x10f, %eax
	cmovbq	%r8, %rax
	leaq	0xa(%rax,%r13), %rcx
	cmpq	%r11, %rcx
	jae		Lzvn_80752
	movq	%rax, %rcx
	shlq	$0x8, %rcx
	addl	$0xf0e0, %ecx
	movw	%cx, (%r13)
	testq	%rax, %rax
	je		Lzvn_803f0
	leaq	0x2(%r13), %rcx
	xorl	%edx, %edx

Lzvn_803db:
	movq	(%rsi,%rdx), %rdi
	movq	%rdi, -0x30(%rbp)
	movq	%rdi, (%rcx,%rdx)
	addq	$0x8, %rdx
	cmpq	%rax, %rdx
	jb		Lzvn_803db

Lzvn_803f0:
	subq	%rax, %r8
	leaq	0x2(%rax,%r13), %r13
	addq	%rax, %rsi
	cmpq	$0xf, %r8
	ja		Lzvn_803a0

Lzvn_80401:
	cmpq	$0x4, %r8
	jb		Lzvn_8044e
	leaq	0xa(%r8,%r13), %rax
	cmpq	%r11, %rax
	movq	%r11, %rdx
	jae		Lzvn_8075a
	leal	0xe0(%r8), %eax
	movb	%al, (%r13)
	testq	%r8, %r8
	je		Lzvn_80443
	leaq	0x1(%r13), %rax
	xorl	%ecx, %ecx

Lzvn_8042e:
	movq	(%rsi,%rcx), %rdx
	movq	%rdx, -0x30(%rbp)
	movq	%rdx, (%rax,%rcx)
	addq	$0x8, %rcx
	cmpq	%r8, %rcx
	jb		Lzvn_8042e

Lzvn_80443:
	leaq	0x1(%r8,%r13), %r13
	addq	%r8, %rsi
	xorl	%r8d, %r8d

Lzvn_8044e:
	leaq	(%r8,%r8), %rcx
	movl	$0xa, %eax
	subq	%rcx, %rax
	cmpq	%r15, %rax
	cmovaeq	%r15, %rax
	movq	%r15, %rdi
	leaq	0x8(%r13), %rcx
	cmpq	%r11, %rcx
	movq	%r11, %rdx
	jae		Lzvn_8075a
	movq	%rdi, %rcx
	subq	%rax, %rcx
	leaq	-0x3(%rax), %rdx
	movl	(%rsi), %r15d
	movq	-0x80(%rbp), %rsi
	cmpq	-0x50(%rbp), %rsi
	jne		Lzvn_804e0
	testq	%r8, %r8
	je		Lzvn_805ee
	movq	%r8, %rax
	shlq	$0x6, %rax
	leaq	0x6(%rax,%rdx,8), %rax
	jmp		Lzvn_805f4

Lzvn_804a5:
	movq	%r9, %r10
	jmp		Lzvn_801a7

Lzvn_804ad:
	cmpq	$0x5ff, %rsi
	ja		Lzvn_80517
	movq	%r8, %rdx
	shlq	$0x6, %rdx
	movl	%esi, %edi
	shrl	$0x8, %edi
	addl	%edi, %edx
	shlq	$0x3, %rax
	addl	%edx, %eax
	movb	%al, (%r13)
	movb	%sil, 0x1(%r13)
	movl	%ebx, 0x2(%r13)
	leaq	0x2(%r8,%r13), %rax
	jmp     Lzvn_8062b

Lzvn_804e0:
	cmpq	$0x5ff, %rsi
	ja      Lzvn_80579
	movq	%r8, %rax
	shlq	$0x6, %rax
	movl	%esi, %edi
	shrl	$0x8, %edi
	addl	%edi, %eax
	shlq	$0x3, %rdx
	addl	%eax, %edx
	movb	%dl, (%r13)
	movb	%sil, 0x1(%r13)
	movl	%r15d, 0x2(%r13)
	leaq	0x2(%r8,%r13), %rax
	jmp		Lzvn_806fc

Lzvn_80517:
	cmpq	$0x3fff, %rsi
	movq	%r15, %rdx
	ja		Lzvn_80606
	cmpq	%rdi, %rdx
	je		Lzvn_80606
	cmpq	$0x23, %rdx
	jae		Lzvn_80606
	addl	$-0x3, %edx
	movl	%edx, %eax
	shrl	$0x2, %eax
	leaq	(,%r8,8), %rcx
	leal	0xa0(%rax,%rcx), %eax
	movb	%al, (%r13)
	movq	-0x80(%rbp), %rax
	leaq	(,%rax,4), %rax
	andl	$0x3, %edx
	orl		%edx, %eax
	movw	%ax, 0x1(%r13)
	movl	%ebx, 0x3(%r13)
	leaq	0x3(%r8,%r13), %rbx
	jmp		Lzvn_80689

Lzvn_80579:
	cmpq	$0x3fff, %rsi
	ja		Lzvn_806d7
	cmpq	%rax, %rdi
	je		Lzvn_806d7
	cmpq	$0x23, %rdi
	jae		Lzvn_806d7
	addl	$-0x3, %edi
	movl	%edi, %eax
	shrl	$0x2, %eax
	leaq	(,%r8,8), %rcx
	leal	0xa0(%rax,%rcx), %eax
	movb	%al, (%r13)
	movq	-0x80(%rbp), %rax
	leaq	(,%rax,4), %rax
	andl	$0x3, %edi
	orl		%edi, %eax
	movw	%ax, 0x1(%r13)
	movl	%r15d, 0x3(%r13)
	leaq	0x3(%r8,%r13), %rdx
	jmp		Lzvn_8075a

Lzvn_805d8:
	addq	$0xf0, %rdi

Lzvn_805df:
	movb	%dil, (%r13)
	movl	%ebx, 0x1(%r13)
	leaq	0x1(%r8,%r13), %rax
	jmp		Lzvn_8062b

Lzvn_805ee:
	addq	$0xf0, %rax

Lzvn_805f4:
	movb	%al, (%r13)
	movl	%r15d, 0x1(%r13)
	leaq	0x1(%r8,%r13), %rax
	jmp		Lzvn_806fc

Lzvn_80606:
	movq	%r8, %rdx
	shlq	$0x6, %rdx
	shlq	$0x3, %rax
	leal	0x7(%rax,%rdx), %eax
	movb	%al, (%r13)
	movq	-0x80(%rbp), %rax
	movw	%ax, 0x1(%r13)
	movl	%ebx, 0x3(%r13)
	leaq	0x3(%r8,%r13), %rax

Lzvn_8062b:
	cmpq	$0x10, %rcx
	jb		Lzvn_80663

Lzvn_80631:
	leaq	0x2(%rax), %rdx
	cmpq	%r11, %rdx
	jae		Lzvn_80681
	cmpq	$0x10f, %rcx
	movl	$0x10f, %esi
	cmovbq	%rcx, %rsi
	subq	%rsi, %rcx
	shlq	$0x8, %rsi
	addl	$0xf0f0, %esi
	movw	%si, (%rax)
	cmpq	$0xf, %rcx
	movq	%rdx, %rax
	ja		Lzvn_80631

Lzvn_80663:
	testq	%rcx, %rcx
	je		Lzvn_80686
	leaq	0x1(%rax), %rsi
	cmpq	%r11, %rsi
	movq	%r11, %rbx
	jae		Lzvn_80689
	addl	$0xf0, %ecx
	movb	%cl, (%rax)
	movq	%rsi, %rbx
	jmp		Lzvn_80689

Lzvn_80681:
	movq	%r11, %rbx
	jmp	Lzvn_80689

Lzvn_80686:
	movq	%rax, %rbx

Lzvn_80689:
	cmpq	%r11, %rbx
	movq	-0xd0(%rbp), %rax
	cmovbq	%rbx, %rax
	movq	%rax, -0xd0(%rbp)
	movq	-0xb8(%rbp), %rax
	movq	%r10, %r13
	cmovbq	%r13, %rax
	movq	%rax, -0xb8(%rbp)
	xorl	%r15d, %r15d
	xorl	%r10d, %r10d
	xorl	%eax, %eax
	movq	%rax, -0x40(%rbp)
	xorl	%edx, %edx
	movq	%rbx, -0x78(%rbp)
	xorl	%ebx, %ebx
	movq	-0x38(%rbp), %rsi
	movq	-0x80(%rbp), %rcx
	movq	%rcx, %rdi
	jmp		Lzvn_807a3

Lzvn_806d7:
	movq	%r8, %rax
	shlq	$0x6, %rax
	shlq	$0x3, %rdx
	leal	0x7(%rdx,%rax), %eax
	movb	%al, (%r13)
	movq	-0x80(%rbp), %rax
	movw	%ax, 0x1(%r13)
	movl	%r15d, 0x3(%r13)
	leaq	0x3(%r8,%r13), %rax

Lzvn_806fc:
	cmpq	$0x10, %rcx
	jb		Lzvn_80734

Lzvn_80702:
	leaq	0x2(%rax), %rdx
	cmpq	%r11, %rdx
	jae		Lzvn_80752
	cmpq	$0x10f, %rcx
	movl	$0x10f, %esi
	cmovbq	%rcx, %rsi
	subq	%rsi, %rcx
	shlq	$0x8, %rsi
	addl	$0xf0f0, %esi
	movw	%si, (%rax)
	cmpq	$0xf, %rcx
	movq	%rdx, %rax
	ja		Lzvn_80702

Lzvn_80734:
	testq	%rcx, %rcx
	je		Lzvn_80757
	leaq	0x1(%rax), %rsi
	cmpq	%r11, %rsi
	movq	%r11, %rdx
	jae		Lzvn_8075a
	addl	$0xf0, %ecx
	movb	%cl, (%rax)
	movq	%rsi, %rdx
    jmp		Lzvn_8075a

Lzvn_80752:
	movq	%r11, %rdx
    jmp		Lzvn_8075a

Lzvn_80757:
	movq	%rax, %rdx

Lzvn_8075a:
	cmpq	%r11, %rdx
	movq	-0xd0(%rbp), %rax
	cmovbq	%rdx, %rax
	movq	%rax, -0xd0(%rbp)
	movq	-0xb8(%rbp), %rax
	movq	-0xa0(%rbp), %r13
	cmovbq	%r13, %rax
	movq	%rax, -0xb8(%rbp)
	movq	%rdx, -0x78(%rbp)
	movq	-0x38(%rbp), %rsi
	movq	-0x80(%rbp), %rcx
	movq	%rcx, %rdi
	movq	-0x58(%rbp), %r10
	movq	-0x48(%rbp), %rdx
	movq	-0x60(%rbp), %r15

Lzvn_807a3:
	movq	-0x68(%rbp), %rcx

Lzvn_807a7:
	leaq	0x9(%rsi), %rax
	cmpq	%rcx, %rax
	jae		Lzvn_807ba
	cmpq	%r11, -0x78(%rbp)
	jb		Lzvn_7fac5

Lzvn_807ba:
	movq	-0xb8(%rbp), %rax
	movq	-0xd0(%rbp), %r8
	movq	-0xd8(%rbp), %rdi
	jmp		Lzvn_807db

Lzvn_807d1:
	xorl	%ebx, %ebx
	jmp		Lzvn_8092c

Lzvn_807d8:
	movq	%rdi, %r8

Lzvn_807db:
	movq	%rdi, -0xd8(%rbp)
	cmpq	%rax, %rcx
	jbe		Lzvn_80902
	cmpq	%r11, %r8
	jae		Lzvn_80902
	movq	%rax, %rdx
	movq	%r8, %rbx

Lzvn_807fa:
	movq	%rbx, -0x40(%rbp)
	movq	%rdx, -0x38(%rbp)
	movq	%rax, -0xb8(%rbp)
	movq	%rcx, %rdx
	subq	%rax, %rdx
	cmpq	$0x10f, %rdx
	movl	$0x10f, %ecx
	cmovaq	%rcx, %rdx
	movq	%rdx, -0x48(%rbp)
	leaq	(%r12,%rax), %r15
	cmpq	$0x10, %rdx
	movq	%rdx, %r14
	jb		Lzvn_80897

Lzvn_80830:
	cmpq	$0x10f, %r14
	movl	$0x10f, %r13d
	cmovbq	%r14, %r13
	leaq	0xa(%r13,%r8), %rax
	cmpq	%r11, %rax
	jae		Lzvn_8090a
	movq	%r13, %rax
	shlq	$0x8, %rax
	addl	$0xf0e0, %eax
	movw	%ax, (%r8)
	subq	%r13, %r14
	testq	%r13, %r13
	je		Lzvn_80889
	leaq	0x2(%r8), %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	movq	%r11, %rbx
	movq	%r8, %r12
	callq	_memcpy
	movq	%r12, %r8
	movq	-0xb0(%rbp), %r12
	movq	%rbx, %r11

Lzvn_80889:
	leaq	0x2(%r13,%r8), %r8
	addq	%r13, %r15
	cmpq	$0xf, %r14
	ja		Lzvn_80830

Lzvn_80897:
	testq	%r14, %r14
	je		Lzvn_808d0
	leaq	0xa(%r14,%r8), %rax
	cmpq	%r11, %rax
	jae		Lzvn_8090a
	leal	0xe0(%r14), %eax
	leaq	0x1(%r8), %rdi
	movb	%al, (%r8)
	movq	%r15, %rsi
	movq	%r14, %rdx
	movq	%r11, %r15
	movq	%r8, %rbx
	callq	_memcpy
	movq	%rbx, %r8
	movq	%r15, %r11
	leaq	0x1(%r14,%r8), %r8

Lzvn_808d0:
	movq	-0xb8(%rbp), %rax
	addq	-0x48(%rbp), %rax
	cmpq	%r11, %r8
	movq	-0x40(%rbp), %rbx
	cmovbq	%r8, %rbx
	movq	-0x38(%rbp), %rdx
	cmovbq	%rax, %rdx
	movq	-0x68(%rbp), %rcx
	cmpq	%rax, %rcx
	jbe		Lzvn_80912
	cmpq	%r11, %r8
	jb		Lzvn_807fa
	jmp		Lzvn_80912

Lzvn_80902:
	movq	%rax, %rdx
	movq	%r8, %rbx
	jmp		Lzvn_80912

Lzvn_8090a:
	movq	-0x38(%rbp), %rdx
	movq	-0x40(%rbp), %rbx

Lzvn_80912:
	movq	$0x6, -0x30(%rbp)
	movq	$0x6, (%rbx)
	addq	$0x8, %rbx
	subq	-0xd8(%rbp), %rbx

Lzvn_8092c:
	movq	-0xe8(%rbp), %rax
	movq	%rdx, (%rax)
	movq	%rbx, %rax
	addq	$0xc8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

_lzvn_encode_work_size:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$0x80000, %eax
	popq	%rbp
	retq
