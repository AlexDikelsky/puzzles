% Takes 2 args, first is list to 
% flatten, X is resulting list
f([], []).
f([Head|Tail], Answer) :-
    is_list(Head),
    f(Head, MatchingHead),
    f(Tail, MatchingTail),
    append(MatchingHead, MatchingTail, Answer).
f([Head|Tail], Answer) :-
    \+(is_list(Head)),
    f(Tail, MatchingTail),
    append([Head], MatchingTail, Answer).

