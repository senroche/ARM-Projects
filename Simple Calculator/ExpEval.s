	AREA	ExpEval, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start
	MOV R4, #0				;  Starting values
	MOV R6, #0
	MOV R7, #10
	MOV R5, #10
	
while	
	BL	getkey				; Read input key from console
	
	CMP R0,#0x2A 			; Compare with multiplication sign 
	BEQ multiplication		;If R0 is multiplication branch to 'multiplication'
	
	CMP R0,#0X2B 			; Compare with addition sign 
	BEQ addition			; If R0 is addition branch to 'addition'
	
	CMP R0,#0X2D 			; Compare R0 with the subtraction sign 
	BEQ subtraction 		; If R0 is subtraction branch to 'subtraction'
	
	BL	sendchar			; Send key back to console
	MUL R4, R5, R4 
	SUB R0,R0, #0x30
	ADD R4, R0, R4 			; First number stored in R4
	B while
	
addition
	BL	sendchar 
additionoperation
	BL getkey
	BL sendchar
	CMP R0, #0x0D			; Check if enter key pressed 
	BEQ endAdd
	MUL R6, R7, R6
	SUB R0,R0, #0x30
	ADD R6, R0, R6 			; Second number stored in R6
	B additionoperation 
	
endAdd
	ADD R5,R4,R6 			; R4 + R6 stored in R5
	B endRead				;After addition is complete and answer is stored, end program
	
multiplication
	BL sendchar				; Send Key back to console

multioperation
	BL getkey
	BL sendchar 			; Echo key back to console
	CMP R0, #0x0D			; Check if enter key is pressed
	BEQ endmultiply
	MUL R6, R7, R6			; Multiply R6 by R7, store in R6
	SUB R0,R0, #0x30		; Convert to ASCII
	ADD R6, R0, R6
	B multioperation

endmultiply
	MUL R5,R4,R6
	B endRead				;After multiplication is complete and answer is stored, end program
	
subtraction
	BL sendchar

suboperation
	BL getkey
	BL sendchar
	CMP R0, #0x0D
	BEQ endsub
	MUL R6, R7, R6
	SUB R0,R0, #0x30
	ADD R6, R0, R6
	B suboperation			
	
endsub	
	SUB R5,R4,R6
	B endRead				;After subtraction is complete and answer is stored, end program
	
 B	while 	

endRead	

stop	B	stop
	END	