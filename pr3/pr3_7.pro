%task3
fl_is_s_sl([],_).
fl_is_s_sl([H|T],[H|T1]) :- fl_is_s_sl(T,T1).
isSubL(Sub,L) :-
	fl_is_s_sl(Sub,L) ;
	L=[_|T], isSubL(Sub,T).

%task7 использую 3 задачу
p([],[]).
p(L1,L2) :-
	bagof(S, (isSubL(S,L1), incr_l(S)),L_sub), % находим все подсписки, у которых есть возрастание 
	maxSub(L_sub,L2,0,[]).%выделяем самый большой
incr_l([_]).%1 элементный всегда упорядочен + это база рек
incr_l(Lst) :- Lst = [H1 | T], T = [H2 | _], H1 < H2, incr_l(T).	%проверяем что возростает

maxSub([],L,_,L) :-!.
maxSub([H|T],L,N,Max_L) :-
	length(H,X), X> N ->
	maxSub(T,L,X,H);
	maxSub(T,L,N,Max_L).