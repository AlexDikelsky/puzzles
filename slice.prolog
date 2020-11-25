% Lazier solution using answer to previous question
% You could make this faster by ignoring more values, but 
% this works fine
split(X, 0, [], X).
split([X|Xs], N, [X|Ys], Z) :-
    N1 #= N-1,
    split(Xs, N1, Ys, Z).

s(L, LowerBound, UpperBound, R) :-
    split(L, LowerBound, _, PartAfterLower),
    NewBound #= UpperBound - LowerBound,
    split(PartAfterLower, NewBound, R, _).
