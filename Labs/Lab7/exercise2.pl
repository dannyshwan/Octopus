% boundary condition
oddEven([], []).

% Check if even
oddEven([EvenNum|L], [even | L2]) :- 
  0 is EvenNum mod 2, !,
  oddEven(L,L2).

% Check if odd
oddEven([OddNum|L], [odd | L2]) :- 
  1 is abs(OddNum mod 2), !,
  oddEven(L,L2).