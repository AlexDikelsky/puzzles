% This is without replacement. 
% See n_rand_elements.prolog for with replacement.
r(_, 0, []).

r([Z|NewList], N, [SelectedElement|Xs]) :-
    N - 1 #= N1,
    r(NewList, N1, Xs),

    % Index Calculation
    length(OriginalList, Len),
    random(RandNum),
    RandomlyChosenIndex is 1 + floor(RandNum * Len),

    remove(Z, OriginalList, RandomlyChosenIndex, NewList),
    nth(RandomlyChosenIndex, OriginalList, SelectedElement).


remove(Element, [Element|OrigList], 0, OrigList).
remove(_, [X|Xs], N, [X|Ys]) :-
    N > 0,
    N1 is N - 1,
    remove(_, Xs, N1, Ys).
