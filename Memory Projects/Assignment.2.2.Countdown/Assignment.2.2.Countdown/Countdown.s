	AREA	Countdown, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R0, =0
	LDR	R1, =cdWord		;Load origin address of word
	LDRB R2, [R1]		;Word
	LDR	R3, =cdLetters	;Load origin address of letters
	LDRB R4, [R3]		;Letters
	LDR R5, =9			;Count (Number of letters)
	LDR R6, ='!'
	
while
	CMP R5, #0			;Check if count is 0
	BEQ endwh1			;If  =0, 
	CMP R2, R4			;If !=0, Compare letter of word to letter in list
	BEQ foundMatch		;If match found, branch
	ADD R3, R3, #1		;Otherwise, change to next byte/letter
	LDRB R4, [R3]		;Load byte into R4
	SUB R5, R5, #1		;Decrease count by 1
	B while
	
foundMatch	
	SUB R5, R5, #1		;Subtract one from count
	STRB R6, [R3]		;Store ! in R3
	LDRB R4, [R3]		;Reload	letters	
	STRB R6, [R1]		;Store ! in R1
	LDRB R2, [R1]		;Reload word	
	ADD R3, R3, #1		;Next letter
	LDRB R4, [R3]		;Load
	B while

endwh1
	LDR R5, =9			;Reload count (number of letters) into R5
	CMP R2, #0			;Compare letter with 0
	BEQ reload			;If equal to 0 branch
	ADD R1, R1, #1		;Next letter
	LDRB R2, [R1]		;Load into R2
	LDR	R3, =cdLetters	;Reload letters into R3
	LDRB R4, [R3]		;Load into R4
	B while	

reload
	LDR R1, =cdWord		;Reload origin address of word
	LDRB R2, [R1]		;Load into R2
	B while2			
	
while2
	CMP R2, #0			;Compare word with 0
	BEQ plus			;If =0 brbanch
	CMP R2, R6			;Check if '!' in word
	BNE stopNow			;If there is not end the program.
	ADD R1, R1, #1		;If there is check next letter
	LDRB R2, [R1]
	B while2
		

plus
	ADD R0, R0, #1		;Adds one to R0 to indicate that the word can be formed
		
stopNow		
		

stop	B	stop



	AREA	TestData, DATA, READWRITE
	
cdWord
	DCB	"hello",0

cdLetters
	DCB	"abdhellok",0
	
	END	
	;Works