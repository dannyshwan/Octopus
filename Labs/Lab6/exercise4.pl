% Loop through the entire list until we reach the second last element
% Checks if the tail only contains one element. Stops loop if so. Assigns X to the Head (Head would contain second last element)
% at this point
secondLast(X,[X|[_]]):- !.
secondLast(X,[_|L]) :- secondLast(X,L).