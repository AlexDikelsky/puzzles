% Empty list is the same
pack([], []).

% Lists of len=1 are the one further nested versions of themselves
pack([X], [[X]]).

% First 2 are the same means that the second list starts
% with another X
pack([X, X|Xs], [[X|Zs]|Ys]) :-
    pack([X|Xs], [Zs|Ys]).

% First 2 are different means we need to start a new
% list at the head of the right list
pack([X, Y|Xs], [[X]|Ys]) :-
    X \= Y,
    pack([Y|Xs], Ys).


% Head of list encodes to the length and the first character
e(ListToPack, Answer) :-
    pack(ListToPack, Packed),
    encode(Packed, Answer).

encode([], []).
encode([[C]|Ls], [C|Xs]) :-
    encode(Ls, Xs).
encode([[C|Cs]|Ls], [[N, C]|Xs]) :-
    length([C|Cs], N),
    N \= 1,
    encode(Ls, Xs).
