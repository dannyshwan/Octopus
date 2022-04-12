% Facts
% --------------------------------
sudoku([[2,1,4,3],[4,3,2,1],[1,2,3,4],[3,4,1,2]]).
sudoku([[2,1,4,3],[4,3,2,1],[1,2,3,3],[3,4,1,2]]).

% Question 1
% --------------------------------
% different/1 predicate.
% Checks if every element in the list is unique
different([H|T]) :- \+member(H,T), different(T). % Checks if each element appears in the rest of the list
different([]).

% Question 2
% --------------------------------
% extract4Columns/2 predicate.
% Get the columns of the sudoku
extract4Columns([[]|_], []).  % Boundary condition
extract4Columns(M, [L|Ls]) :- getColumn(M, L, Rest), extract4Columns(Rest, Ls).

% getColumn/3
% Recursive helper predicate for extract4Columns
% It gets the head of each row to for a column in the for of a list
getColumn([], [], []). % Boundary condition
getColumn([[H|T]| Rest], [H|Hs], [T|Ts]) :- getColumn(Rest, Hs, Ts).

% Question 3
% --------------------------------
% extract4Quadrants/2 predicate
% Get the quadrants of the sudoku
extract4Quadrants([], []).
extract4Quadrants([R,R2|T], [L,L2|Ls]) :- getQuad([R,R2], L, T1), getQuad(T1, L2, _), extract4Quadrants(T, Ls).
  
% getQuad/3 
% Recursive helper predicate for extract4Quadrants
% It gets the first two elements of the first 2 rows and creates a new list. (Repeated for all lists in the matrix)
getQuad([], [], []).
getQuad([[H,H2|T]| Rest], [H,H2|Hs], [T|Ts]) :- getQuad(Rest, Hs, Ts).

% Question 4
% --------------------------------
% allDifferent/1 predicate
% Check if the element in each row in the list is unique
allDifferent([H|T]) :- different(H), allDifferent(T).
allDifferent([]).

% Question 5
% --------------------------------
% checkSudoku/1 predicate
% Returns any valid sudoku M
checkSudoku(M) :- allDifferent(M), extract4Columns(M,L), allDifferent(L), extract4Quadrants(M,L2), allDifferent(L2).