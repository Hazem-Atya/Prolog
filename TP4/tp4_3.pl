%EXERCICE1
%
%1°/
:- dynamic arbre/2.
:- dynamic rocher/2.

%2°/
:- dynamic vache/4.

%3°/
:- dynamic dimitri/2.

%4°/
largeur(8).
hauteur(8).

%5°/
nombre_rochers(4).
nombre_arbres(4).
nombre_vaches(brune, 1).
nombre_vaches(simmental, 1).
nombre_vaches(alpine_herens, 2).



%EXERCICE2
%
%1°/
occupe(X,Y):-dimitri(X,Y);arbre(X,Y);rocher(X,Y);vache(X,Y,_,_).

% 2°/
is_random_number_libre(X,Y):-largeur(L1),hauteur(L2),
    L11 is L1 - 1,
    L22 is L2 - 1,
    random_between(0,L11,X),
    random_between(0,L22,Y),
    not(occupe(X,Y)).
libre(X,Y):- repeat,
    is_random_number_libre(X,Y),
    true,
    !.

%3°/
placer_rochers(0):- fail.
placer_rochers(1):- libre(X,Y),assert(rocher(X,Y)).
placer_rochers(N):- N>1, libre(X,Y),assert(rocher(X,Y)),N1 is N-1,placer_rochers(N1).

placer_arbres(0).
placer_arbres(1):- libre(X,Y),assert(arbre(X,Y)).
placer_arbres(N):- N>1, libre(X,Y),assert(arbre(X,Y)),N1 is N-1,placer_arbres(N1).

placer_vaches(_,0):- fail.
placer_vaches(Race,1):- libre(X,Y),assert(vache(X,Y,Race,vivante)).
placer_vaches(Race,N):- N>1, libre(X,Y),assert(vache(X,Y,Race,vivante)),N1 is N-1, placer_vaches(Race,N1).

placer_dimitri:- libre(X,Y),assert(dimitri(X,Y)).

%4°/
vaches(L):-findall((X,Y),vache(X,Y,_,_),L).

%5°/
creer_zombie:- vaches(L),L=[V|_],V=(X,Y),retract(vache(X,Y,Race,vivante)),assert(vache(X,Y,Race,zombie)).



%EXERCICE3
%1°/
question(R):- write('Dans quelle direction vous voulez déplacer Dimitri, le résultat doit etre soit reste, nord, sud, est, ouest'),nl, read(R).
%2°/
est_vache(X,Y):- vache(X,Y,_,_).

est_voisine((X,Y),(X1,Y1)):- A is X1+1, B is X1-1, C is Y1-1, D is Y1+1,
                          ((X=A,Y=Y1); (X=B,Y=Y1);(X = X1,Y=D);(X=X1,Y=C)).

est_vache_voisine((X,Y),(A,B)):- est_vache(X,Y),est_voisine((X,Y),(A,B)).
lister_les_vaches_voisines(X,Y,L):- findall(((A,B)),est_vache_voisine((A,B),(X,Y)),L).

transformer_zombie(X,Y):- retract(vache(X,Y,Race,_)),assert(vache(X,Y,Race,zombie)).

transformer_liste_en_zombie([]).
transformer_liste_en_zombie([(X,Y)]):- transformer_zombie(X,Y).
transformer_liste_en_zombie(L):- L=[(X,Y)|L1], transformer_zombie(X,Y), transformer_liste_en_zombie(L1).

zombification:- est_zombie(X,Y),zombification(X,Y).
zombification(X,Y):- lister_les_vaches_voisines(X,Y,L),transformer_liste_en_zombie(L).

%3°/
deplacement_vaches:-deplacement_vache(X,Y,Direction).

deplacement_vache(X, Y, Direction):- Direction = reste,!.
deplacement_vache(X, Y, Direction):- Direction = nord, Y>0, Y1 is Y-1,not(occupe(X,Y1)),
                                     retract(vache(X,Y,Race,Etat)),assert(vache(X,Y1,Race,Etat)),!.
deplacement_vache(X, Y, Direction):- Direction = sud,hauteur(N),N1 is N-1, Y<N1, Y1 is Y+1,not(occupe(X,Y1)),
                                     retract(vache(X,Y,Race,Etat)),assert(vache(X,Y1,Race,Etat)),!.
deplacement_vache(X, Y, Direction):- Direction = est,largeur(N), N1 is N-1, X<N1, X1 is X+1,not(occupe(X1,Y)),
                                     retract(vache(X,Y,Race,Etat)),assert(vache(X1,Y,Race,Etat)),!.
deplacement_vache(X, Y, Direction):- Direction = ouest, X>0, X1 is X-1,not(occupe(X1,Y)),
                                     retract(vache(X,Y,Race,Etat)),assert(vache(X1,Y,Race,Etat)),!.
deplacement_vache(X, Y, Direction):- !.

%4°/
deplacement_joueur(Direction):- Direction = reste,!.
deplacement_joueur(Direction):- Direction = nord, dimitri(X,Y), Y>0, Y1 is Y-1,not(occupe(X,Y1)),
                                retract(dimitri(X,Y)),assert(dimitri(X,Y1)),!.
deplacement_joueur(Direction):- Direction = sud, dimitri(X,Y),hauteur(N),N1 is N-1, Y<N1, Y1 is Y+1,not(occupe(X,Y1)),
                                retract(dimitri(X,Y)),assert(dimitri(X,Y1)),!.
deplacement_joueur(Direction):- Direction = est, dimitri(X,Y),largeur(N), N1 is N-1, X<N1, X1 is X+1,not(occupe(X1,Y)),
                                retract(dimitri(X,Y)),assert(dimitri(X1,Y)),!.
deplacement_joueur(Direction):- Direction = ouest, dimitri(X,Y), X>0, X1 is X-1,not(occupe(X1,Y)),
                                retract(dimitri(X,Y)),assert(dimitri(X1,Y)),!.
deplacement_joueur(Direction):- !.


%5°/
est_zombie(X,Y):- vache(X,Y,_,zombie).

is_liste_contient_zombie([]):- fail.
is_liste_contient_zombie([(X,Y)]):- est_zombie(X,Y).
is_liste_contient_zombie(L):- L=[(X,Y)|L1],est_zombie(X,Y),!.
is_liste_contient_zombie(L):- L=[(X,Y)|L1],not(est_zombie(X,Y)),is_liste_contient_zombie(L1).

verification:- dimitri(X,Y),lister_les_vaches_voisines(X,Y,L),is_liste_contient_zombie(L).


% le reste est le code prédéfini du jeu

initialisation :-
  placer_dimitri,
  nombre_rochers(NR),
  placer_rochers(NR),
  nombre_arbres(NA),
  placer_arbres(NA),
  nombre_vaches(brune, NVB),
  placer_vaches(brune, NVB),
  nombre_vaches(simmental, NVS),
  placer_vaches(simmental, NVS),
  nombre_vaches(alpine_herens, NVH),
  placer_vaches(alpine_herens, NVH),
  creer_zombie,
  !.

affichage(L, _) :-
  largeur(L),
  nl.

affichage(L, H) :-
  rocher(L, H),
  print('O'),
  L_ is L + 1,
  affichage(L_, H).

affichage(L, H) :-
  arbre(L, H),
  print('T'),
  L_ is L + 1,
  affichage(L_, H).

affichage(L, H) :-
  dimitri(L, H),
  print('D'),
  L_ is L + 1,
  affichage(L_, H).

affichage(L, H) :-
  vache(L, H, brune, vivante),
  print('B'),
  L_ is L + 1,
  affichage(L_, H).
affichage(L, H) :-
  vache(L, H, brune, zombie),
  print('b'),
  L_ is L + 1,
  affichage(L_, H).

affichage(L, H) :-
  vache(L, H, simmental, vivante),
  print('S'),
  L_ is L + 1,
  affichage(L_, H).
affichage(L, H) :-
  vache(L, H, simmental, zombie),
  print('s'),
  L_ is L + 1,
  affichage(L_, H).

affichage(L, H) :-
  vache(L, H, alpine_herens, vivante),
  print('H'),
  L_ is L + 1,
  affichage(L_, H).
affichage(L, H) :-
  vache(L, H, alpine_herens, zombie),
  print('h'),
  L_ is L + 1,
  affichage(L_, H).

affichage(L, H) :-
  \+ occupe(L, H),
  print('.'),
  L_ is L + 1,
  affichage(L_, H).

affichage(H) :-
  hauteur(H).

affichage(H) :-
  hauteur(HMax),
  H < HMax,
  affichage(0, H),
  H_ is H + 1,
  affichage(H_).

affichage :-
  affichage(0),!.

jouer :-
  initialisation,
  tour(0).

tour_(_) :- verification, write('Dimitri s\'est fait mordre'),!.

tour_(N) :-
  not(verification),
  M is N + 1,
  tour(M).

tour(N) :-
  affichage,
  question(R),
  deplacement_joueur(R),
  deplacement_vaches,
  zombification,
  tour_(N).
