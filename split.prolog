% This one works
% Much better version in better_split.prolog
s(X, 0, [], X).
s([X|Xs], N, [X|Ys], Z) :-
    N1 #= N-1,
    s(Xs, N1, Ys, Z).
