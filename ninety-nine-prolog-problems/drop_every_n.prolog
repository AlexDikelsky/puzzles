d(L, N, X) :-
    drop(L, N-1, X, N-1).

% If the lists are empty, stop
drop([], _, [], _).

% If N = V, skip this one, and next iteration
% starts with 1.
drop([_|Xs], N, Ys, 0) :-
    drop(Xs, N, Ys, N).

% If N ≠ V, counter U and contine
drop([C|Xs], N, [C|Ys], U) :-
    U #= V + 1,
    drop(Xs, N, Ys, V).
