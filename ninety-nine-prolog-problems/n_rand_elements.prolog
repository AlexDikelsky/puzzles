% This is with replacement. 
% See n_rand_no_replace.prolog for without replacement.
r(_, 0, []).

r(OriginalList, N, [SelectedElement|Xs]) :-
    N #= N1 + 1,
    r(OriginalList, N1, Xs),
    length(OriginalList, Len),
    random(RandNum),
    RandomlyChosenIndex is 1 + floor(RandNum * Len),
    nth(RandomlyChosenIndex, OriginalList, SelectedElement).
