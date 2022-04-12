interval(X,L,H) :- number(X), number(L), number(H),
  !, X >= L, X =< H.
interval(X,X,H) :- number(X), number(H),
  X=< H.
interval(X,L,H) :- number(L), number(H), 
  L < H, L1 is L+1,
  interval(X,L1,H).

% 1.
% bagof(K,interval(K,1,10),L).
% L = [1,2,3,4,5,6,7,8,9,10].

% 2.
% bagof((K,K2),(interval(K,1,3),interval(K2,1,3)),L).
% L = [(1,1),(1,2),(1,3),(2,1),(2,2),(2,3),(3,1),(3,2),(3,3)].

% 3.
% Note: Change round bracket to square bracket in first parameter from the 2nd scenario
%
% bagof([K,K2],(interval(K,1,3),interval(K2,1,3)),L).
% L = [[1,1],[1,2],[1,3],[2,1],[2,2],[2,3],[3,1],[3,2],[3,3]].

% 4.
% We add the K =\= K2 condition to ensure that we don't have an element [X,Y] where X = Y
%
% bagof([K,K2],(interval(K,1,3),interval(K2,1,3), K=\=K2),L).
% L = [[1,2],[1,3],[2,1],[2,3],[3,1],[3,2]].