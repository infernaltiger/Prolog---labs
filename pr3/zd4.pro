isTLsortFS([],[],[]).
isTLsortFS([],L,L).
isTLsortFS(L,[],L).
isTLsortFS([H1|T1],[H2|T2],X) :-
	H1 =< H2,
	X = [H1|T3],
	isTLsortFS(T1,[H2|T2],T3)
	;
	H1 > H2,
	X = [H2|T3],
	isTLsortFS([H1|T1],T2,T3).