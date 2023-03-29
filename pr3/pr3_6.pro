%task6
q_sort([],[]).
q_sort([H|T],Lst) :-
	elsplit(H,T,Sm,Big),
	q_sort(Sm,S),
	q_sort(Big,B),
	append(S,[H|B],Lst).
elsplit(_,[],[],[]).
elsplit(N,[H|T],[H|T1],Big):-
	N >= H, elsplit(N,T,T1,Big).
elsplit(N,[H|T],Sm,[H|T1]) :-
	N < H, elsplit(N,T,Sm,T1).
