% This implementation doesn't work,
% I confused myself with the counter. See
% split.prolog instead
s(X, N, Start, End) :-
    split(X, N, Start, End, 0).

split(RestOfList, SplitNum, _, RestOfList, Counter) :-
    SplitNum #= Counter,
    split(RestOfList, SplitNum, _, [], Counter).

split([X|Xs], SplitNum, [X|Ys], [], Counter) :-
    Counter1 #= Counter + 1,
    split(Xs, SplitNum, Ys, [], Counter1).

