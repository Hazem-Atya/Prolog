
somme_max(0,SOMME,MAX):-SOMME is 0,MAX is 0.
somme_max(N,SOMME,MAX):-write("Donner un entier "),
nl,read(X),N1 is N-1,somme_max(N1,S1,M1),SOMME is S1+X,MAX is max(X,M1).