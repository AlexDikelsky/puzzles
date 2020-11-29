% This doesnt work, should be taking 2 arguments. See pal_2.prolog
% Make sure first and last elements are the same
% Then run with list without the head or last element
p(A, B) :- 
    length(A, N),
    length(B, N),
    N/2 #= C,
    reverse(Reversed, B),
    first_n_equals(A, Reversed, C).

% Check off by one
first_n_equals(_, _, 0).
first_n_equals([A|A_t], [B|B_t], N) :-
    A = B,
    N #= N_i + 1,
    first_n_equals(A_t, B_t, N_i).

equal([], []).
equal([A|B], [C|D]) :-
    A = C,
    equal(B, D).
