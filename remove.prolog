% First is element of list
% Second is original list
% third is index to remove
% fourth is resulting list

r(Element, [Element|OrigList], 0, OrigList).

r(_, [X|Xs], N, [X|Ys]) :-
    N > 0,
    N1 is N - 1,
    r(_, Xs, N1, Ys).
