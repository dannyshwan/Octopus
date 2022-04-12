% Predicate design similar to exercise 4

reverseDrop(List,Reverse) :- reverseDrop(List, 0, [], Reverse).

% boundary condition
reverseDrop([],_,Reverse,Reverse).     

% Flag will help us determine whether to drop an element or not from the list
% Flag = 1 means we will not add the current head to the new reverse list
% Flag = 0 means we will add the current head
reverseDrop([_|T],Flag,NewList,Reverse) :-
	Flag = 1,
	reverseDrop(T,0,NewList,Reverse).

reverseDrop([H|T],Flag,NewList,Reverse) :-
	Flag = 0,
  reverseDrop(T,1,[H|NewList],Reverse).