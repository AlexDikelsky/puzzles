copy(0, _, []).
copy(N, K, [K|Ks]) :-
    N1 #= N-1,
    copy(N1, K, Ks).

d([], _, []).
d([Y|Ys], N, Result) :-
    copy(N,Y,Copied),
    d(Ys, N, X),
    append(Copied, X, Result).
