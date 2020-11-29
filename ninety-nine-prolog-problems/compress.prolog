
% Have to start the state out with the first element,
% which needs to be preserved
c([Head|Tail], Answer) :-
    compress(Head, Tail, AnswerTail),
    [Head|AnswerTail] = Answer.

compress(_, [], []).

% State changes because Y ≠ X
compress(Y, [X|Xs], [X|Zs]) :- 
    \+(Y=X),
    compress(X, Xs, Zs).

% State stays the same, but keep checking the rest
% of the list
compress(X, [X|Xs], Zs) :- compress(X, Xs, Zs).
