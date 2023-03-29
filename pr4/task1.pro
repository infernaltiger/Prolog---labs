:- initialization(consult('kinship.pro')).
% task 1
pred(X,Y) :- parent(X,Y).
pred(X, Y) :- setof(C, (parent(X, C), pred(C, Y)), _).

%task 2
brother(X,Y) :-
	male(X), 
	parent(P1,X),parent(P1,Y),male(P1), %ищем батю
	parent(P2,X),parent(P2,Y),female(P2), %ищем мать(ее нет т.к. он дотер)
	X \= Y.

%TASK 3
married(X,Y):-
	bagof(L, (parent(X, L), parent(Y, L)), _),
	X \= Y.

%task 4
husband(X, Y) :-
	male(X),female(Y),
	bagof(L, (parent(X, L), parent(Y, L)), _),
	X \= Y.
	
%task 5
cousin(X, Y) :-
 parent(P1, X), parent(P2, Y),
 relative_BOS(P1,P2).

relative_BOS(X,Y) :-
	parent(P1, X), parent(P1, Y), male(P1),
	parent(P2, X), parent(P2, Y), female(P2),
	X \= Y.

%task 6
num_of_children(X,N) :-
	bagof(C,parent(X,C),Lst), length(Lst,N);
	(male(X);female(X)), \+ parent(X,_), N = 0.
	
nOch(X,N) :- (male(X) ; female(X)),
  findall(Ch, parent(X,Ch), Lst), length(Lst,N).	
  
%task7
nephews(Lst,Y) :-
	(male(Y) ; female(Y)),
	findall(C, (relative_BOS(Y,X), parent(X,C)), Lst1),sort(Lst1,Lst).
	
%task8

family([M,F|C]) :-
	husband(M,F),
	setof(X,(parent(M,X),parent(F,X)),C).
		