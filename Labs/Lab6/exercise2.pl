element(chlorine,'Cl').
element(helium,'He').
element(hydrogen,'H').
element(nitrogen,'N').
element(oxygen,'O').

start :- writeln('Elements in the Periodic Table'), search.

search :- 
  write('Symbol to look-up: '), 
  read(Element), 
  answer(Element).

answer(El) :- element(Ans, El), write(El), write(' is the symbol for: '), writeln(Ans), search, !.
answer(El) :- write("Don't know the symbol: "), writeln(El), write('Exiting.'), !.
