lire(X):- write('Donner un entier'),nl,read(X),nl,write('Votre entier est '),write(X),nl,nl.
calcul_carre(X,Y):-Y is X*X.
ecrire_resultat(X,Y):- write('Le carr? de '),write(X),write(' est '),write(Y),nl,nl.
aller:-lire(X),calcul_carre(X,Y),ecrire_resultat(X,Y).
carre:-write('Donner un entier'),nl,read(X),nl,write('Le carre de '),write(X),write(' est '),Y is X*X,write(Y),nl,nl.
boucle_carre:-write('Donner un entier'), nl,read(X),X\==0,write('le carre de '), write(X), write(' est '),Y is X*X,write(Y),nl,nl,boucle_carre.
factorielle(0,Y):-Y is 1.
factorielle(X,Y):-X1 is X-1,factorielle(X1,Y1),Y is X*Y1.
diff(X,Y,Z):- Z is Y-X.
ecart(A,B,RES):- RES is A-B.
