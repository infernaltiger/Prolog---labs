
fl_is_s_sl([],_).
fl_is_s_sl([H|T],[H|T1]) :- fl_is_s_sl(T,T1).
isSubL(Sub,L) :-
	fl_is_s_sl(Sub,L) ;
	L=[_|T], isSubL(Sub,T).