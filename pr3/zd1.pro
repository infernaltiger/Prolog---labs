myReverse(L,RL) :-
	mr_it(L,RL,[]).
mr_it([],RL,RL).
mr_it([H|T],RL,X) :-
	mr_it(T,RL,[H|X]).

change_case(X,NX) :-
	((X = 'A' ; X = 'a') -> NX = 'a');
	((X = 'B' ; X = 'b') -> NX = 'b');
	((X = 'C' ; X = 'c') -> NX = 'c').
palindrom(L) :-
	p_it(L,[],X),
	myReverse(X,X1),
	X = X1.
p_it([],X,X).
p_it([H|T],NL,X) :-
	change_case(H,A),
	p_it(T,[A|NL],X).