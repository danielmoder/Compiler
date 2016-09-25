	# From Translator

	movq %r12, (output)
	
	# ASCII for digits is 0x30 greater than digit value
	addq	$0x30, (output)

	movq	$1, %rdx	
	movq	$output, %rsi
	movq	$1, %rdi	# write to stdout
	movq	$1, %rax	# syscall number for write
	syscall

_CRLF:
	movq	$1, %rdx
	movq	$new_line, %rsi
	movq	$1, %rdi
	movq	$1, %rax
	syscall
		
_exit:	
	movq	$7, %rdi
	movq	$60, %rax
	popq %rbp
	syscall

	.data	
pingle:
	.ascii "hello\n"
