	AREA	Lotto, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R0, =TICKETS
	LDRB R10,[R0]
	LDR R6, =COUNT 		;Number of Tickets
	LDR R6,[R6]
	LDR R5, =DRAW
	LDR R1, =0 			;Count 4 match 
	LDR R2, =0 			;Count 5 match
	LDR R3, =0 			;Count 6 match
	LDR R7, =0 			;Number of tickets ran
	LDR R9, =0 			;Count tickets
	LDR R12, =0 		;All ticket matches

While1
    CMP R7,#6 			;While less than 7 numbers have been checked(1 ticket)
	BHS end1
	LDR R8, =DRAW 		;Address of winning numbers
	LDRB R11,[R8]

While2
    ADD R8, R8, #1 		;If the numbers are the same add to match counter
    LDRB R11, [R8]
    CMP R10,R11		
    BEQ Count
    CMP R11,#0 			;if there is no number left to check break
    BEQ end2
    B While2

Count
    ADD R12,R12,#1 		;Add to match counter
	ADD R8,R8,#1
	LDRB R11,[R8] 		;Load byte into R11
    CMP R11,#0
    BEQ end2
    B While2
	
end1
   ADD R9,R9,#1 		;Add to count
   CMP R12,#4 			;If 4 matches, branch to Count4
   BEQ Count4
   CMP R12,#5 			;If 5 matches, branch to Count5
   BEQ Count5
   CMP R12,#6
   BEQ Count6 			;If 6 matches, branch to Count 6
   
end2
    ADD R0,R0,#1 		;Next ticket
	LDRB R10,[R0]
	ADD R7,R7,#1 		;Add to count for tickets ran
	B While1

nextTicket
   LDR R7, =0 			;Reset tickets ran
   LDR R12, =0 			;Reset matches
   CMP R9,R6 			;Check if all tickets have ran through
   BHS storeResults		;Store results
   B While1

Count4
   ADD R1,R1,#1 		;Add 1 to count of 4 match
   LDR R7, =0
   LDR R12, =0
   CMP R9,R6
   BHS storeResults
   B While1

Count5
   ADD R2,R2,#1 		;Add 1 to count of 5 match
   LDR R7, =0
   LDR R12, =0
   CMP R9,R6
   BHS storeResults
   B While1

Count6
   ADD R3,R3,#1 		;Add 1 to count of 6 match
   LDR R7, =0
   LDR R12, =0
   CMP R9,R6
   BHS storeResults
   B While1

storeResults
   LDR R4, =MATCH4
   STR R1,[R4] 
   LDR R5, =MATCH5
   STR R2,[R5]
   LDR R6, =MATCH6
   STR R3,[R6]

stop	B	stop 



	AREA	TestData, DATA, READWRITE
	
COUNT	DCD	3			            ; Number of Tickets
TICKETS	DCB	3, 8, 11, 21, 22, 31	; Tickets
	DCB	7, 23, 25, 28, 29, 32
	DCB	10, 11, 12, 22, 26, 30
	

DRAW	DCB	10, 11, 12, 22, 26, 30	; Lottery Draw

MATCH4	DCD	0
MATCH5	DCD	0
MATCH6	DCD	0

	END	

