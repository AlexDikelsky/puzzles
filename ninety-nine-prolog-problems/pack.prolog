% Empty list is the same
p([], []).

% Lists of len=1 are the one further nested versions of themselves
p([X], [[X]]).

% First 2 are the same means that the second list starts
% with another X
p([X, X|Xs], [[X|Zs]|Ys]) :-
    p([X|Xs], [Zs|Ys]).

% First 2 are different means we need to start a new
% list at the head of the right list
p([X, Y|Xs], [[X]|Ys]) :-
    X \= Y,
    p([Y|Xs], Ys).
