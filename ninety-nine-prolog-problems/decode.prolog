% Empty list is done
d([], []).

% If the head is not a list,
% the result should start with that value
d([C|Ls], [C|Xs]) :-
    \+(is_list(C)),
    d(Ls, Xs).

% If the head [n, c] is a list of len 2, the result
% should start with n copies of c
d([[N,K]|Ls], Answer) :-
    copy(N, K, NCopiesOfK),
    d(Ls, Vs),
    append(NCopiesOfK, Vs, Answer).

copy(0, _, []).
copy(N, K, [K|Ks]) :-
    N1 #= N-1,
    copy(N1, K, Ks).
