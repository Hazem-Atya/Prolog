homme(jean).
homme(alain).
femme(lucie) .
femme(nelly) .
femme(martine).
femme(elsa).
parent(jean,lucie).
parent(nelly,lucie).
parent(lucie,alain).
parent(alain,martine).
parent(martine,elsa).
ancetre(X,Y) :- parent(X,Y).
ancetre(X,Y):-parent(X,Z),ancetre(Z,Y).
pere(X,Y):-parent(X,Y),homme(X).
pere(X):-pere(X,_).
enfant(X,Y):-parent(Y,X).
fils(X,Y):-parent(Y,X),homme(X).
fille(X,Y):-parent(Y,X),femme(X).
mere(X,Y):-parent(X,Y),femme(X).
grand_parent(X,Y):-parent(X,Z),parent(Z,Y).
