% Make sure first and last elements are the same
% Then run with list without the head or last element

except_last([_], []).
except_last([A|B], [C|D]) :- A = C, except_last(B, D).
