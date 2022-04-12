% Daniel Shwan
% 300013694
indexOf(X,[]):-!, fail.
indexOf(X,[X|L],0). % Need to add the tail (set as L) 
indexOf(X,[Y|L],N):-indexOf(X,L,NN),N is NN+1.