% This follows the python range conventions rather than
% the ones in the solution

% If the bounds are the same, return the empty list
r(Upper, Upper, []).

% If the lower is less than the upper, add the lower to
% the list, then add 1 to the lower bound
r(Lower, Upper, [Lower|Xs]) :-
    Lower #< Upper,
    N #= Lower + 1,
    r(N, Upper, Xs).
