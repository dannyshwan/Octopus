canalOpen( saturday ).
canalOpen( monday ).
canalOpen( tuesday ).

raining( saturday ).

melting( saturday ).
melting( sunday ).
melting( monday ).

% Winterlude function
winterlude(X) :- canalOpen(X), is_raining(X), is_melting(X).

% Check if it is raining
is_raining(X) :- raining(X),!,fail.
is_raining(_).

% Check if it is melting
is_melting(X) :- melting(X),!,fail.
is_melting(_).