
%Exercice 1 :

% 1.


% 2.



% 3.


% 4.


% 5.


%Exercice 2:

% 1.

% 2.

% 3.


%Exercice 3:

% 1.


% 2.



% 3.


% 4.


% 5.






% le reste est le code prédéfini du jeu

initialisation :-
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
  placer_dimitri,
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
  tour(0, _).

tour_(_, _) :-
  \+ verification,
  write('Dimitri s\'est fait mordre'),!.
tour_(N, R) :-
  verification,
  M is N + 1,
  tour(M, R).

tour(N, R) :-
  affichage,
  question(R),
  deplacement_joueur(R),
  deplacement_vaches,
  zombification,
  tour_(N, R).










