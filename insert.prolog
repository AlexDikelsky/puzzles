% You can do this with the inverse of the remove function as well
i(ToInsert, OriginalList, 0, [ToInsert|OriginalList]).

i(ToInsert, [X|Xs], N, [X|Ys]) :-
    N > 0,
    N1 is N - 1,
    i(ToInsert, Xs, N1, Ys).
