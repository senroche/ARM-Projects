	AREA	Sets, CODE, READONLY
	IMPORT	main
	EXPORT	start


start
   LDR R3, = AElems	;Load elements of A
   LDR R4, = BElems	;Load elements of B
   LDR R5, = CElems	;Load elements of C
   LDR R0, = ASize 	;Load size of A for (Count 1)
   LDR R0, [R0]		
   LDR R1, = BSize 	;Load size of B for (Count 2)
   LDR R1, [R1]
   LDR R2, = CSize	;Load size of C
   LDR R2, [R2]
   LDR R8, = '!'	

while
  CMP R0,#0			;If Count 1 !=0, continue loop.
  BEQ endwh1		;If Count 1 =0, branch to second loop.
  LDR R7, [R4]		;Load element of B into R7.
  LDR R6, [R3]		;Load element of A into R6.
  CMP R6,R7 		;Compare one element of A with one of B.
  BNE notSame		;If not same branch.
  STR R8, [R3]		;If there is a match store '!' for both
  STR R8, [R4]		;
  ADD R3,R3,#4		;Next element
  SUB R0,R0,#1		;Subtract one from Count 1
  B   while
  
notSame
  CMP R1,#0			;Check if Count 2 is 0
  BEQ checkedAll	;If checked all elements of B, branch to checked all to store in C.
  SUB R1,R1,#1 		;If !=0, subtract one from Count 2
  ADD R4,R4,#4		;Next element
  B     while
  
checkedAll
  STR R6,   [R5] 	;Store element in C
  ADD R5,R5,#4		;Next element
  ADD R3,R3,#4		;Next element
  ADD R2,R2,#1		;Add one to size of C
  SUB R0,R0,#1		;Subtract 1 from Count 1
  LDR R1, = BSize	;Reload size of B into R1
  LDR R4, = BElems	;Reload elements of B into R4
  LDR R1, [R1]		;
  B   while
  
endwh1

while2
  CMP R1,#0
  BEQ endwh			;If Count 2 (BSize) is also 0, terminate program.
  LDR R7, [R4]		;Otherwise, load elements of B into R7
  CMP R7,#'!'		;Compare to '!'
  BEQ next			;If equal, check next digit
  STR R7, [R5]		;Otherwise, store in C
  ADD R5,R5,#4		;Next digit
  ADD R4,R4,#4		;Next digit
  ADD R2,R2,#1		;Increase size of C by 1
  SUB R1,R1,#1		;Decrease size of B (Count 2) by 1
  B   while2
  
next
  ADD R4,R4,#4 		;Next digit
  SUB R1,R1,#1		;Decrease Count 2 by 1
  B     while2		

endwh


stop  B   stop


	AREA	TestData, DATA, READWRITE
	
ASize	DCD	8			; Number of elements in A
AElems	DCD	4,6,2,13,19,7,1,3	; Elements of A

BSize	DCD	6			; Number of elements in B
BElems	DCD	13,9,1,20,5,8		; Elements of B

CSize	DCD	0			; Number of elements in C
CElems	SPACE	56			; Elements of C

	END	
	
	;Answer should be:
	;2,3,4,5,6,7,8,9,19,20
	
	;R4 origin address stores:
	;4,6,2,19,7,9,20,8,3,5
	;(correct)