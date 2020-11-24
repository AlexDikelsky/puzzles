% Finds the number of elements 
% in the flattened version of a list
f([], 0).
f([Head|Tail], N) :-
    is_list(Head),
    f(Head, H_Sum),
    f(Tail, T_Sum),
    N #= H_Sum + T_Sum.
f([Head|Tail], N) :-
    \+(is_list(Head)),
    f(Tail, T_Sum),
    N #= 1 + T_Sum.
