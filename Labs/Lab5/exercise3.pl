% Recursive predicate for adding the sums of the first N integer.
% Predicate counts downwards from N until N is 0 and calculates the sum.
sum_int(N,X) :- 
  N > 0, % Checks if N is still greater than 0
  N1 is N-1, % Set a new N that is set to the decremented value of N
  sum_int(N1,Sum), % Recursive predicate call
  X is Sum+N. % Adds the sum together

% boundary condition
sum_int(0,0).

