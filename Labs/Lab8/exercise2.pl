% Call recursive function
leafNodes(T,L) :- leafNodes(T,L,[]).

% Boundary conditions
leafNodes(nil,L,L) :- !. % Cut if root doesn't exist
leafNodes(t(Root,nil,nil), [Root|Leafs], Leafs) :- !. % Cut if root is a leaf and add value of leaf to the return list

% Recursive function for traversing through the tree (in-order)
leafNodes(t(_,Left,Right),Leafs,Tracker) :-
  leafNodes(Left, Temp, Tracker),
  leafNodes(Right, Leafs, Temp).