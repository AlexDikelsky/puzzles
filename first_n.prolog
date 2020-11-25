f(_, 0, []).
f([X|Xs], N, [X|Ys]) :-
    N1 #= N-1,
    f(Xs, N1, Ys).
