%3 задане
even(X) :- X mod 2 =:= 0.
%4 задане
dfact(0,1).
dfact(1,1).
%dfact(N,DF) :- N =< 2,DF = N.
dfact(N,DF) :- N >1, N1 is N-2, dfact(N1,DF1), DF is N*DF1.

%5 задане
prime(N) :- N>1,prost(N,2).
prost(N,D) :- D*D >= N.
prost(N,D) :- D*D =<N ,N mod D =\= 0, D1 is D + 1 ,prost(N, D1).


%6 задание
sirakuz(N,_) :- N =< 0.
sirakuz(N,A0) :- even(A0),
	A1 is A0//2,N1 is N - 1,
	write(A1),nl,
	sirakuz(N1,A1).
sirakuz(N,A0) :- \+ even(A0),
	A1 is (A0*3)+1, N1 is N-1,
	write(A1),nl,
	sirakuz(N1,A1).
%7 задание
numOfDays(jan, 31).
numOfDays(feb, 28).
numOfDays(mar, 31).
numOfDays(apr, 30).
numOfDays(may, 31).
numOfDays(jun, 30).
numOfDays(jul, 31).
numOfDays(aug, 31).
numOfDays(sep, 30).
numOfDays(oct, 31).
numOfDays(nov, 30).
numOfDays(dec, 31).
nextMonth(jan, feb).
nextMonth(feb, mar).
nextMonth(mar, apr).
nextMonth(apr, may).
nextMonth(may, jun).
nextMonth(jun, jul).
nextMonth(jul, aug).
nextMonth(aug, sep).
nextMonth(sep, oct).
nextMonth(oct, nov).
nextMonth(nov, dec).
nextMonth(dec, jan).



nextDate(date(M1, D1), date(M2, D2)) :-
	numOfDays(M1, X),
	X = D1,
	nextMonth(M1, M2),
	D2 = Y.
%	nextMonth(M1, Y),
%	date(M2, D2) = date(Y, 1).
	
nextDate(date(M1, D1), date(M2, D2)) :-
	numOfDays(M1, X),
	X > D1,
	ND is D1 + 1,
	date(M2, D2) = date(M1, ND). 
	
choosePairs(Lst1, Lst2, Func, Lst) :- 
	choosePairs_help(Lst1, Lst2, Func, X),
	(var(Lst) -> sort(X, Lst); sort(X, Res1), sort(Lst, Res2), Res1 = Res2).

choosePairs_help([], [], _, []).
choosePairs_help([H1 | T1], [H2 | T2], Func, Lst) :-
	Term =.. [Func, H1, H2],
	(call(Term) -> Hr = H1-H2, choosePairs_help(T1, T2, Func, Tr), Lst = [Hr | Tr];
		choosePairs_help(T1, T2, Func, Lst)).