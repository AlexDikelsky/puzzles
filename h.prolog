hail(N, N).
hail(N0, N) :-
    N0 #= 2 * N1,
    hail(N1, N).
hail(N0, N) :-
    N0 #= 2*_ + 1,
    N1 #= 3*N0 + 1,
    hail(N1, N).
