in(A, [A|_], 0).
in(A, [_|T], N) :- 
    V #= N-1, in(A, T, V).
