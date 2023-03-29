%task 3
 sumCubes(N,X) :-
	 number(N),
	 N >= 0,
	 X is (N*(N+1))^2 div 4,!
	 ;
	 var(N),number(X),
	 iter1(N,0,X,0),!
	 ;
	 var(N),var(X),
	 iter2(N,0,0,X,0).
iter1(A,S,S,A).
iter1(A,S,X,NA) :-
	S < X,
	A1 is NA+1,
	S1 is S+(A1*A1*A1),
	iter1(A,S1,X,A1).

iter2(A,A,S,S,S).
iter2(N,A,S,X,_) :-
	A1 is A + 1,
	S1 is S+(A1*A1*A1),
	X1 is S1,
	iter2(N,A1,S1,X,X1).
	
	