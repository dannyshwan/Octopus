% Original: countDown(N):- repeat, writeln(N), N is N-1, N<0, !. 
% ---
% What happens in the original predicate is that it looks forever and only prints 5.
% The reason being is that the "repeat" makes the predicate loop forever. N is also not being re-assigned.
% To fix this, we can make the predicate recursive
countDown(N):- N>0, writeln(N), X is N-1, countDown(X).

% Boundary condition
countDown(0):-!.