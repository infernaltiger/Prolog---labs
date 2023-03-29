%4 task
%)a

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

%)b
contains(T,X) :-
	(number(X), %варик, когда x это число
	(T = tr(X,_,_) %проверим корень
	;
	T = tr(N,L,_),% проверим левое, если число меньше корня
	X < N,
	contains(L,X)
	;
	T = tr(N,L,R),% анологично с правым
	X > N,
	contains(R,X)))
	;
	var(X),%варик, когда x это неизвестная
	(T = tr(N, nil, _), X = N %берем корень, левая часть пустая т.к. нам надо идти по возрастанию
	;
	T = tr(_,L,_),%  берем левое поддерево т.к. нам надо идти по возрастанию
	\+ L = nil,% варик с nil есть
	contains(L, X)
	;
	T=tr(N,L,R), % прошли левое поддерево, вытащем корень перед правым
	\+ L = nil,\+ R = nil,
	X = N
	;
	T= tr(_,_,R),%анологично с левым
	\+ R = nil,
	contains(R, X)).
%)в
isSearchTree(tr(X,nil,nil)) :- number(X).%если дерево без поддеревьев,то значит в корне можно
%проверку на число, или вообще ничего не ставить, если дерево на вхо только с числами
isSearchTree(tr(X,L,R)) :-
	iter(tr(X,L,R),-10000000,10000000).%не знаю есть ли бесконечностьБ если есть то можете подсказать?
iter(nil, _, _).%когда доходим до пустого дерева, то конец
iter(tr(X,L,R),MIN,MAX):- %min и max это как корни поддеревьев
	MIN < X, X < MAX,
	iter(L, MIN, X),
	iter(R, X, MAX).
%)г*
%решил брать минимальные элемент из правого поддерева как начало 
%тк запутался с использыванием ;(или) выделил в отдельные предикаты
removeNT(nil, _, nil). %случай пустых
removeNT(tr(X, nil, nil), X, nil) :- !.  %случай с 1 корнем
removeNT(tr(X, L, nil), X, Tree) :- Tree = L, !.  %случаи с одним из пустых и совпадением корня
removeNT(tr(X, nil, R), X, Tree) :- Tree = R, !. 
removeNT(tr(X, L, R), X, Tree) :- minT(R,N1),
	removeNT(R,N1,R1), Tree = tr(N1,L,R1),!.  % корень совпал с удаляемым, а левое и правое не пустые
removeNT(tr(N, L, R), X, Tree) :- 
	X < N -> removeNT(L, X, L1), Tree = tr(N, L1, R);
	removeNT(R, X, R1), Tree = tr(N, L, R1).
	%знаем что на вход дерево поиска пользуемя этим
	
	
minT(T, N) :-%решил брать минимальные элемент из правого поддерева как начало 
	T = tr(H,L,_), %2 случая, когда конец и когда еще искать надо
	(L = nil, N = H
	;
	minT(L,N)
	).
	
/*
write_it(0).
write_it(A) :-
	tab(A), write('|').
writeT(tr(X,L,R),A) :-
	A1 is A +1,
	(L = nil,R=nil,
	write_it(A),nl
	write(X)
	
	;
	\+ L = nil, R = nil,
	write(X),nl,write('|'),write_it(A),nl,write(+),write(-),
	writeT(L,A1)
	;
	L = nil,\+ R=nil,
	write(X),nl,write('|'),write_it(A),nl,write_it(A),nl,
	writeT(R,A1)
	;
	\+ L = nil,\+ R=nil,
	write(X),nl,write('|'),write_it(A),nl,write(+),write(-),
	
	writeT(L,A),nl,writeT(R,A1)).

*/