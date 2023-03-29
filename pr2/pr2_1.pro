%1 task
% (8,10) ~~> (10, 8)
%toSquares(A,A,1).
/* 
toSquares(A,B,X) :- A = B, X is 1.
toSquares(A,B,X) :-
	(A>1 ; B>1),
	A > B,
	A1 is A-B, 
	toSquares(A1,B,X1),
	X is X1 + 1
	;
	A < B,
	B1 is B-A,
	toSquares(A,B1,X1),
	X is X1 + 1.
*/

%  while (b != 0) 
% (a,b) -> (b, a mod b) || (S += a // b)
% ~~> a -- otvet


toSquares(A,B,X) :-
	iter(A,B,0,X).
iter(A,B,S,X) :-
	B =\= 0,
	A1 is A mod B,
	S1 is S + (A//B),
	iter(B,A1,S1,X).
iter(_,0,S,X) :- X is S.

%2 task
qntDigit(A,B,DIG,N) :-
	