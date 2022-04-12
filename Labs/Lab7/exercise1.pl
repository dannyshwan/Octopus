% Call the recursive function
maxmin([H|T],Max,Min) :- maxmin([H|T],H,H,Max,Min).

% boundary condition
maxmin([],Max,Min,Max,Min).

% Check for max
% M1 for temp max
% M2 for temp min
maxmin([H|T], M1, M2, Max, Min) :- 
  H > M1,
  maxmin(T,H,M2,Max,Min).

% Check for min
% M1 for temp max
% M2 for temp min
maxmin([H|T], M1, M2, Max, Min) :- 
  H < M2,
  maxmin(T,M1,H,Max,Min).

% This is for when there is no change to the min or max
% ie. above two predicates are not true
maxmin([_|T], M1, M2, Max, Min) :- 
  maxmin(T,M1,M2,Max,Min).