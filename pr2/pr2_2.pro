%task 2

qntDigit(A,A,D,1):- digf(A, D).
qntDigit(A,A,D,0):- \+ digf(A, D).
qntDigit(A,B,D,X):-
	A < B,
	digf(A, D), 
	A1 is A+1,
	qntDigit(A1,B,D,X1),
	X is X1+1, ! %как можно избавиться от "!"? 
	;
	A < B,
	\+ digf(A, D), 
	A1 is A+1,
	qntDigit(A1,B,D,X).

%1 реализация без !
digf(NUM, D) :-
	abs(NUM)>=0,
	abs(NUM)<10,
	abs(NUM) =:= D
	;
	abs(NUM)>=10,
		(abs(NUM) mod 10 =:= D
		; 
		NUM1 is NUM//10,
		digf(NUM1,D)
		).
/* 2 реализация, но с ! (Какая лучше?)
digf(0,0).
digf(NUM, D) :-
	abs(NUM) mod 10 =:= D, !
		; 
	NUM1 is NUM//10, 
	digf(NUM1,D). */
