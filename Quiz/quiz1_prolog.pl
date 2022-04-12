% Student: Daniel Shwan
% Number: 300013694
inOrder(X,Y,Z) :- X>Y, Y>Z,!.
inOrder(X,Y,Z) :- Z>Y, Y>X,!.