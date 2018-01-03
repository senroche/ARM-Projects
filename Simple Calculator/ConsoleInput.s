	AREA	ConsoleInput, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start
	MOV R4, #0			;Starter values
	MOV R5, #10			

while	
	BL getkey			; Read input key from console
	CMP R0, #0x0D 		; Check if enter is pressed
	BEQ endwh 			; If enter is clicked go to end of loop
	BL sendchar			; Echo key back to console
	MUL R4, R5, R4		
	SUB R0, R0, #0X30	;Convert to ASCII
	ADD R4, R0, R4		
	B while
	

endwh					; End while loop
stop	B	stop		; Stop program

	END	