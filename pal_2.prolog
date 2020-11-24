% Make sure first and last elements are the same
% Then run with list without the head or last element
p(A) :- 
    length(A, N),
    N_Div_2 is floor(N/2),
    reverse(Reversed, A),
    first_n_equals(A, Reversed, N_Div_2).

% Check off by one
first_n_equals(_, _, 0).
first_n_equals([A|A_t], [B|B_t], N) :-
    A = B,
    N #= N_i + 1,
    first_n_equals(A_t, B_t, N_i).

% Actual solution on the website
k(L) :- reverse(L, L).
