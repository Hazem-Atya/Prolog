adjacent(a,b).
adjacent(b,e).
adjacent(e,d).
adjacent(d,a).
adjacent(c,a).
adjacent(c,b).
adjacent(c,e).
adjacent(c,d).
color(a,vert,sans_conflit).
color(b,bleu,sans_conflit).
color(c,rouge,sans_conflit).
color(d,bleu,sans_conflit).
color(e,vert,sans_conflit).

color(a,vert,avec_conflit).
color(b,vert,avec_conflit).
color(c,rouge,avec_conflit).
color(d,bleu,avec_conflit).
color(e,vert,avec_conflit).

conflit(X,Y,Coloriage):-adjacent(X,Y),color(X,C,Coloriage),color(Y,C,Coloriage).

conflit(Coloriage):-conflit(_,_,Coloriage).
