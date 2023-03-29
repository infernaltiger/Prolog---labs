%task5
% в пункте б придется выделить 2 случая, когда обе и когда N неизвестна
numlst(0,[0]).
numlst(N,Lst) :-
	number(N),
	numlst_it1(N,Lst, [])% сразу включает пункт а
	;
	var(N),nonvar(Lst), 
	numlst_it2(N,Lst, 0) 
	;
	var(N),var(Lst),
	numlst_it3(N,Lst, 0,_).
	
	
numlst_it1(0,L,L) :- L \== [].
numlst_it1(N, Lst, NL) :-
	N>0,
	N1 is N // 10,
	H is N mod 10,
	numlst_it1(N1,Lst,[H|NL]).
	
numlst_it2(N,[],N) :- N \== 0.
numlst_it2(N,[H|T],X) :-
	X1 is X*10 + H, numlst_it2(N,T,X1).
	
numlst_it3(N,Lst, N, Lst):- N \= 0.
numlst_it3(N,Lst, X, _) :-
	X1 is X+1,
	numlst_it1(X1,S1,[]),
	numlst_it3(N,Lst, X1, S1).