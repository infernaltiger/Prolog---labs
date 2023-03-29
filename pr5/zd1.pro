%task 1 
map(_,[],_,[]).
map([],_,_,[]).
map([H|T],[H1|T1],F,[Hres|Tres]) :-
	Term =.. [F,H,H1,Hres], call(Term),
	map(T,T1,F,Tres).
add(A,B,C) :- C is A + B.

%task 2
choosePairs(L,L1,Pr,Lres) :-
	cPi(L,L1,Pr,X),
	(var(Lres) -> X = Lres;
	sort(X,R1),sort(Lres,R1)).	
	
cPi([],[],_,[]).
cPi([H|T],[H1|T1],Pr,Lst) :-
	Term=.. [Pr,H,H1],
	call(Term) ->
		Hres= H-H1, cPi(T,T1,Pr,Tres), Lst=[Hres|Tres]
		;
		cPi(T,T1,Pr,Lst).

%task3
foldl(X,_,[],X).
foldl(X0,F,[H|T],Lst) :-
	Term=.. [F,X0,H,X1],
	call(Term),
	foldl(X1,F,T,Lst).
	
%4 task
%insert из 2 практики

insert(tr(X,L,R),X,tr(X,L,R)). % т.к. не оговорено что делать при равенстве корня и введенного числа, сохраняем число в корне
insert(nil,X,T) :- T = tr(X,nil,nil).
insert(tr(X,L,R),N,T) :-
	X > N, L = nil,
	NL = tr(N, nil,nil),
	T = tr(X,NL,R)
	;
	X < N, R = nil,
	NR = tr(N, nil,nil),
	T = tr(X,L,NR).
insert(tr(X,L,R),N,tr(NX, NL, NR)) :-
	X > N, \+ L = nil,
	insert(L, N, L1),
	tr(NX, NL, NR) = tr(X, L1, R)
	;
	X < N, \+ R = nil,
	insert(R, N, R1),
	tr(NX, NL, NR) = tr(X, L, R1).
	
treeFromList([H|T],Tree) :-
	foldl(tr(H,nil,nil),insert,T,Tree).
	
	
%task5
addHead(_,[],[]).
addHead(X,[H|T],[[X|H]|Tres]) :-
	addHead(X,T,Tres).
	
%task6
fl_is_s_sl([],_).
fl_is_s_sl([H|T],[H|T1]) :- fl_is_s_sl(T,T1).
isSubL(Sub,L) :-
	fl_is_s_sl(Sub,L) ;
	L=[_|T], isSubL(Sub,T).

subsets([],[]).
subsets(L1,L2) :-
	nonvar(L1),
	 foldl([[]],addHeading, L1, Lres),
	(var(L2) -> L2=Lres;
	map(L2,sort,Ln1),sort(Ln1,L), map(Lres,sort,Ln2),sort(Ln2,L))
	;
	var(L1),nonvar(L2),
	maxSub(L2,Res,0,[]),L1 =Res,subsets(L1,L2).

maxSub([],L,_,L) :-!.
maxSub([H|T],L,N,Max_L) :-
	length(H,X), X> N ->
	maxSub(T,L,X,H);
	maxSub(T,L,N,Max_L).
%превращает в список, в котором голова - исходный,
% а хвост - списки, голова которых, - X
addHeading(Lst, Elem, R) :-
 addHead(Elem, Lst, Res), append(Lst, Res, R).
 
 %map, принимающий 1 список
map([],_,[]).
map([H|T],Func,[H1|T1]) :- 
   Term =.. [Func,H,H1], call(Term),
   map(T,Func,T1).

%task7*
%пример из задания
thing(plate, 1, 1.5).
thing(jar, 3, 5).
thing(silverSpoon, 0.3, 15).
thing(something, 2.7, 20).
sack(3).

%функции для счета цены и веса
countPrice([], 0).
countPrice([H | T], Price) :-
	thing(H, _, X), countPrice(T, Sum), Price is Sum + X.

countWeight([], 0).
countWeight([H | T], Weight) :-
	thing(H, X, _), countWeight(T, Sum), Weight is Sum + X.
%главная функция
pack(Things, MaxPrice) :- 
	findall(X, thing(X, _, _), Lst),
	subsets(Lst, Lst_subs),
	pack_it(Lst_subs, [], 0, Things, MaxPrice), !.
	
pack_it([], Things, MaxPrice, Things, MaxPrice).
pack_it([H | T], Things, Price, GoodThings, MaxPrice) :-
	countPrice(H, X),
	countWeight(H, Y),
	sack(W),
	(Y =< W, X > Price -> pack_it(T, H, X, GoodThings, MaxPrice); 
		pack_it(T, Things, Price, GoodThings, MaxPrice)).