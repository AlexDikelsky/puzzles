e([], []).

e([X], [X]).

% Duplicates, and state is same as head_list
% Created from smaller list with a smaller encoding
e([X,X|Xs], [[N,X]|Ls]) :-
    e([X|Xs], [[M,X]|Ls]),
    N #= M + 1.

% Duplicates, state same as head_item
e([X,X|Xs], [[2,X]|Ls]) :-
    e([X|Xs], [X|Ls]).

% Not duplicates
e([X,Y|Xs], [X|Ls]) :-
    Y \= X,
    e([Y|Xs], Ls).
