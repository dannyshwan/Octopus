% Pass parameters to recursion predicate
% Pass list, start A at 0 and add positive
% S represent the sum
addAlternate(L,S) :- addAlternate(L, 0, p, S).

% boundary condition
addAlternate([],A,_,A).     

addAlternate([H|T],A,p,S) :- !,
	AA is A + H,
	addAlternate(T,AA,m,S).

addAlternate([H|T],A,m,S) :- !, 
	AA is A - H,
        addAlternate(T,AA,p,S).