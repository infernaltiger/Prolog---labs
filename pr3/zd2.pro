prime(N) :- N>1,prost(N,2).
prost(N,D) :- D*D >= N.
prost(N,D) :- D*D =<N ,N mod D =\= 0, D1 is D + 1 ,prost(N, D1).

prost_list([],[]).
prost_list([H|T],X) :-
	(prime(H) ; H =:= 1) ->
	X = [H|T1],
	prost_list(T,T1)
	;
	prost_list(T,X).
	