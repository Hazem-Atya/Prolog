%--------- Exercice 1  -------------
% Question 1+2+3
:-dynamic vache/4,arbre/2,rocher/2,dimitri/2. 

% Question 4
largeur(12).
hauteur(12).

% Question 5
nombre_rochers(3). %O
nombre_arbres(4).  %T
nombre_vaches(alpine_herens,11). %H
nombre_vaches(simmental,10). %S
nombre_vaches(brune,8).  %B

%--------- Exercice 2  -------------
% Question 1
occupe(X,Y):-arbre(X,Y).
occupe(X,Y):-rocher(X,Y).
occupe(X,Y):-vache(X,Y,_,_).
occupe(X,Y):-dimitri(X,Y).

% Question 2
libre(X,Y):-repeat,largeur(L),X is random(L),
            hauteur(H),Y is random(H),not(occupe(X,Y)),!.

% Question 3
placer_rochers(0).
placer_rochers(N):-N>0,libre(X,Y),assert(rocher(X,Y)),N1 is N-1,placer_rochers(N1).
placer_arbres(0).
placer_arbres(N):-N>0,libre(X,Y),assert(arbre(X,Y)),N1 is N-1,placer_arbres(N1).
placer_vaches(_,0).
placer_vaches(Race,N):-N>0,libre(X,Y),assert(vache(X,Y,Race,vivante)),N1 is N-1,placer_vaches(Race,N1).
placer_dimitri:- libre(X,Y),assert(dimitri(X,Y)),!.

% Question 4
vaches(L):-findall([X,Y,RACE,vivante],vache(X,Y,RACE,vivante),L).

% Question 5
creer_zombie:-vaches(L),length(L,LONG),N is random(LONG),nth0(N,L,[X,Y,Race,_]),retract(vache(X,Y,_,_)),assert(vache(X,Y,Race,zombie)).

%--------- Exercice 3  -------------
% Question 1
question(R):- write('Dans quelle direction veut tu deplacer dimitri'),nl,read(R).

%Question2

voisin([X,Y],[X1,Y1]):-A is X+1,B is X-1,C is Y+1, D is Y-1,
                ((X1=A,Y1=Y); (X1=B,Y1=Y);(X1 = X,Y1=D);(X1=X,Y1=C)).
vache_voisine([X,Y],[X1,Y1]):-vache(X1,Y1,_,_),voisin([X,Y],[X1,Y1]).
transformer_en_zombies([[]]).
transformer_en_zombies([[X,Y]|L]):-retract(vache(X,Y,Race,_)),assert(vache(X,Y,Race,zombie)),transformer_en_zombies(L).
zombification(X,Y):- findall([X1,Y1],vache_voisine([X,Y],[X1,Y1]),L),transformer_en_zombies(L),!.
zombification:-vache(X,Y,_,zombie),zombification(X,Y).
zombification:-!.

%Question3
deplacement_vache(_,_,reste):-!.
deplacement_vache(X,Y,nord):- Y1 is Y+1,hauteur(H),Y1<H,not(occupe(X,Y1)),retract(vache(X,Y,R,E)),assert(vache(X,Y1,R,E)),!.
deplacement_vache(X,Y,sud):- Y1 is Y-1,Y1>=0,not(occupe(X,Y1)),retract(vache(X,Y,R,E)),assert(vache(X,Y1,R,E)),!.
deplacement_vache(X,Y,est):- X1 is X+1,largeur(L),X1<L,not(occupe(X1,Y)),retract(vache(X,Y,R,E)),assert(vache(X1,Y,R,E)),!.
deplacement_vache(X,Y,ouest):- X1 is X-1,X1>=0,not(occupe(X1,Y)),retract(vache(X,Y,R,E)),assert(vache(X1,Y,R,E)),!.
deplacement_vache(_,_,_):-!.

deplacement_random_vache(X1,Y1):- findall([X,Y],vache(X,Y,_,_),V), length(V,SIZE),R is random(SIZE), nth0(R,V,[X1,Y1]),
L=[nord,sud,est,ouest],length(L,LONG),N is random(LONG),nth0(N,L,Direction),deplacement_vache(X1,Y1,Direction).
deplacement_N_vaches(0).
deplacement_N_vaches(N):-N>0,deplacement_random_vache(_,_),N1 is N-1,deplacement_N_vaches(N1).
deplacement_vaches:-findall([X,Y],vache(X,Y,_,_),V), length(V,SIZE),deplacement_N_vaches(SIZE).
%
%Question4
deplacement_joueur(reste):-!.
deplacement_joueur(nord):-dimitri(X,Y), Y1 is Y+1,hauteur(H),Y1<H,not(occupe(X,Y1)),retract(dimitri(X,Y)),assert(dimitri(X,Y1)),!.
deplacement_joueur(sud):- dimitri(X,Y),Y1 is Y-1,Y1>=0,not(occupe(X,Y1)),retract(dimitri(X,Y)),assert(dimitri(X,Y1)),!.
deplacement_joueur(est):-dimitri(X,Y), X1 is X+1,largeur(L),X1<L,not(occupe(X1,Y)),retract(dimitri(X,Y)),assert(dimitri(X1,Y)),!.
deplacement_joueur(ouest):- dimitri(X,Y),X1 is X-1,X1>=0,not(occupe(X1,Y)),retract(dimitri(X,Y)),assert(dimitri(X1,Y)),!.
deplacement_joueur(_):-!.
%Question5
zombies_voisines(X,Y):-dimitri(X1,Y1),vache(X,Y,_,zombie),voisin([X1,Y1],[X,Y]).
verification:-findall(X,zombies_voisines(X,_),L),length(L,Size),Size ==0.


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
    tour(0).
  
  tour_(_) :-
    \+ verification,
    write('Dimitri s\'est fait mordre'),!.
  tour_(N) :-
    verification,
    M is N + 1,
    tour(M).
  
  tour(N) :-
    affichage,
    question(R),
    deplacement_joueur(R),
    deplacement_vaches,
    zombification,
    tour_(N).
  test:-question(R), deplacement_joueur(R),affichage,test.