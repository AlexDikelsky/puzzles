split(X, 0, [], X).
split([X|Xs], N, [X|Ys], Z) :-
    N1 #= dist(N-1, 0),
    split(Xs, N1, Ys, Z).

% Since you can rotate 10 with a smaller list and
% still have a sensable operation, do N mod K where
% N is the rotation number and K is the length

% Theres a weird bug that doesn't allow the size
% of a negative argument to be greater than the magnitue
% of the list

r(L, N, X) :-
    N #>= 0,
    length(L, Len),
    SplitPoint #= N rem Len,
    split(L, SplitPoint, FirstHalf, SecondHalf),
    append(SecondHalf, FirstHalf, X).
r(L, N, X) :-
    N #< 0,
    length(L, Len),
    Added #= Len + N,
    SplitPoint #= Added rem Len,
    split(L, Added, FirstHalf, SecondHalf),
    append(SecondHalf, FirstHalf, X).
