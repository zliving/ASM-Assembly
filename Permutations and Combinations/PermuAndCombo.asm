.586
.MODEL FLAT
EXTRN _printf:PROC
EXTRN _scanf:PROC
.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
count DWORD ?
sumtop DWORD ?
sumbottom DWORD ?
permusum  DWORD ?
combsum   DWORD ?
k DWORD  ?
messagen	db  	"Enter n :", 10, 0
messagek	db  	"Enter k :", 10, 0
inputn	db	"%d", 0 
inputk	db	"%d", 0 
permuout	db  "There are %d permutations ", 10, 0
comboout	db	"There are %d combinations", 10, 0


.CODE                           ; start of main program code
main    PROC        

	mov esi, offset count	;move address of count into esi
	mov eax, 0

	;ask user for n
	pusha					; restore all registers
	push offset messagen	;enter n
	call _printf
	add esp, 4				; restore top of the stack
	popa					;restore all registers
	
	;input: take in n and store it
	pusha				;push all registers
	push esi
	push offset inputn	;take in n
	call _scanf
	add esp, 8
	popa
	
		  add eax, dword ptr [esi]       ;move the value of esi into eax
		  add esi, 4					;buffer stack
		  mov	count,  eax				;move n into count

		  mov esi, offset k				;move the address of k into esi
		  mov eax, 0


	;ask user for k
	pusha					; restore all registers
	push offset messagek	;enter k
	call _printf
	add esp, 4				; restore top of the stack
	popa					;restore all registers
	
	;input: take in k and store it
	pusha				;push all registers
	push esi
	push offset inputk	;take in k
	call _scanf
	add esp, 8
	popa	

	      add eax, dword ptr [esi]       ;move esi value into eax
		  add esi, 4					;buffer esi
		  mov	k,  eax					;move eax into k					

		  mov   eax, 1
          mov   ecx, count				;setup for factorial
factorial: imul   eax, ecx
          loop  factorial

		mov sumtop, eax
		mov eax, count
		sub eax, k
		mov ecx,1
divisorfac: imul eax, ecx			;calculations for divisor for permutations
			loop divisorfac
		mov sumbottom, eax			;move divisor into sumbottom
		cdq							; prepare for division
		mov eax, sumtop
		mov ecx, sumbottom

		idiv  ecx
		mov permusum, eax			;move value of number of permutations into permusum

		mov   eax, 1
        mov   ecx, k
kfactorial: imul   eax, ecx			;find factorial of k to determine combinations
          loop  kfactorial

		mov sumbottom, eax

		mov eax, permusum
		mov ecx, sumbottom
		idiv ecx					;divide to find number of combinations
		mov combsum,eax


	;output: show the number of permutations and combinations
	push permusum				; put persumations into stack 
	push offset permuout		; print number of permutations
	call _printf
	add esp, 8
	push combsum				; put persumations into stack 
	push offset comboout		; print number of permutations
	call _printf
	add esp, 8

	ret 0	
main    ENDP

END	                             ; end of source code