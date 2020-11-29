d([],[]).
d([X|Xs],[X,X|Zs]) :- d(Xs,Zs).
