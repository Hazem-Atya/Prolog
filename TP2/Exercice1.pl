personne(k,f,85,tunis).
personne(c,m,63,nabeul).
personne(d,f,60,nabeul).
personne(e,m,35,tunis).
personne(g,f,27,sousse).
personne(h,f,39,nabeul).
personne(i,m,40,nabeul).
personne(j,m,19,sousse).
personne(l,f,9,sousse).
personne(m,f,19,tunis).
personne(n,m,1,tunis).
profession(k,retraite,2000).
profession(c,retraite,1200).
profession(d,retraite,1400).
profession(e,ingenieur,1800).
profession(g,vendeuse,800).
profession(h,vendeuse,800).
profession(i,ingenieur,1700).
profession(j,eleve,0).
profession(l,eleve,0).
profession(m,etudiant,0).
profession(n,rien,0).

individu(X):- personne(X,_,_,_).
masculin(X):- personne(X,m,_,_).
feminin(X):- personne(X,f,_,_).
est_age_de(X,Y):-personne(X,_,Y,_).
habite_a(X,Y):- personne(X,_,_,Y).
majeur(X):- personne(X,_,Y,_),Y>=18.
mineur(X):-personne(X,_,Y,_),Y<18.
meme_age(X,Y):- personne(X,_,Z1,_),personne(Y,_,Z2,_),X\==Y,Z1==Z2.
habite_a_la_meme_ville(X,Y):-personne(X,_,_,Z), personne(Y,_,_,Z).

ecart_abs(A1,A2,RES):-A1>A2,RES is A1-A2.
ecart_abs(A1,A2,RES):-A1<A2,RES is A2-A1.
epoux_possible(X,Y):- personne(X,m,A1,_),personne(Y,f,A2,_),
ecart_abs(A1,A2,E),E<20,A1>=18,A2>=18.
meme_profession(X,Y):-profession(X,Z,_),profession(Y,Z,_).
gagnge_plus(X,Y):-profession(X,_,S1),profession(Y,_,S2),S1>S2.
ont_des_salaires_de_meme_ordres(X,Y):-profession(X,_,S1),
profession(Y,_,S2), abs(S1-S2)<((min(S1,S2)/100)*20).
