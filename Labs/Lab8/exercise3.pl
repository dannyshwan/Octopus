/* Constraint 8: Replaced C5 with brown because of the 8th constraint and the fact that every bottom color starts with b*/
bunkbeds(L):- L=[[N1,C1],[N2,C2],[kayla,C3],[N4,C4],[N5,brown],[N6,C6]],
  ((N1=reeva,N2=haley);(N2=reeva,N1=haley)),  /* Constraint 1.*/
  member(C1, [black,blue]), /* Constraint 2.*/
  member(C3, [black,blue]),
  member([beth,C], Sol), member(C, [red,yellow,green]), /* Constraint 3.*/
  member([blue, red],[[C1,C2], [C3,C4],]), /* Constraint 4.*/
  member(liza, [N1,N5]), /* Constraint 5.*/
  not(N4=zoe), /* Constraint 7.*/
  member(zoe,[N1,N2,N5,N6]),
  member([black,yellow],[[C1,C2], [C3,C4]]), /* Constraint 9.*/
  member(green, [C1,C2,C3,C4,C6]).

  
  