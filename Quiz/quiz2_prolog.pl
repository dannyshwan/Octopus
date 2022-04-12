% Student: Daniel Shwan
% Number: 300013694
gSeries(X,Y):-gSeries(X,0,Y).
gSeries(X,N,Y):-power(X,N,Y).
gSeries(X,N,Y):- N1 is N+1, 
                power(X,N1,_), % Change Y to _ because otherwise the Y in gseries will evaluate as false and end the predicate
                gSeries(X,N1,Y).

% created a power function to calculate X to the power of N
power(X,N,Y) :- Y is X**N.