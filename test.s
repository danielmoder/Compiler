	.bss
output:
	.int


	.text
	.global _start

_start:
	// Numbers to be added
	movl	$3, %eax
	movl	$2, %ebx
	// Sum now in %ebx
	addl	%eax, %ebx
	
	movl	%ebx, (output)
	// ASCII for digit is 0x30 (48) greater than digit value
	addl	$0x30, output

	movl	$2, %edx
	movl	$output, %ecx
	movl	$1, %ebx
	movl	$4, %eax
	int	$0x80

_println:
	movl	$2, %edx
	movl	$13, (output)
	movl	$output, %ecx
	movl	$1, %ebx
	movl	$4, %eax
	int	$0x80

	movl	$2, %edx
	movl	$10, (output)
	movl	$output, %ecx
	movl	$1, %ebx
	movl	$4, %eax
	int	$0x80

_exit:	
	movl	$0, %ebx
	movl	$1, %eax
	int	$0x80
	
	.data

msg:
	.ascii		"hello, world!\n"
	len = . - msg
	
