%task1
/*
opposite(left,right).
opposite(right,left).

unsafe(s(_,P,A,family(Dad,Mom,S1,S2,D1,D2))) :- 
	Lst=[Dad,Mom,S1,S2,D1,D2],
	opposite(P,A),memberchk(A,Lst).

unsafe(s(_,_,_,family(Dad,Mom,S1,S2,D1,D2))) :-
	opposite(Dad, Mom), (Mom = S1; Mom = S2).
unsafe(s(_,_,_,family(Dad,Mom,S1,S2,D1,D2))) :-
	opposite(Dad, Mom), (Dad = D1; Dad = D2).
	*/
%task2

visit(yes).
visit(no).
implic(A,B) :- call(A) -> call(B);true.

start :-
	visit(Andrey),visit(Dmitriy),visit(Boris),visit(Viktor),visit(Grigoriy),
	implic((Andrey = yes,Dmitriy=yes),(Boris=no)),
	implic((Andrey=yes,Dmitriy=no),(Boris=yes,Viktor=no)),
	(Andrey=yes,Viktor=yes;Andrey=no,Viktor=no),
	implic((Dmitriy=yes),(Grigoriy=no)),
	implic((Boris=no,Viktor=no),(Dmitriy=yes)),
	implic((Boris=no,Viktor=yes),(Dmitriy=no,Grigoriy=yes)),
	implic((Boris=yes),(Andrey=yes)),
	write(andrey), write(':'), write(Andrey), nl,
	write(dmitriy), write(':'), write(Dmitriy), nl,
	write(boris), write(':'), write(Boris), nl,
	write(viktor), write(':'), write(Viktor), nl,
	write(grigoriy), write(':'), write(Grigoriy), nl.