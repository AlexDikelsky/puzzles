e([], []).
e([A|B], [C|D]) :-
    A = C,
    e(B, D).
