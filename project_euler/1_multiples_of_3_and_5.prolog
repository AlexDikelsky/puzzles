% fizzbuzz(N, A) will result in the sum of all numbers divisible
% by 3 and 5 below and including N.


% Sum of all things divisible by 3 or 5 ≤ 0 is 0
fizzbuzz(0, 0).

% If this number is divisible by 3 or 5, then the sum
% of the numbers not including this one must have been
% N smaller than the value here
fizzbuzz(N, Sum) :-
    (0 #= N rem 3 ; 0 #= N rem 5),
    N1 #= (N - 1),
    S2 #= (Sum - N),
    fizzbuzz(N1, S2).

% If this number isn't divisible by 3 or 5, then the sum
% of the numbers less than this once was the same as this
fizzbuzz(N, Sum) :-
    0 #\= N rem 3, 
    0 #\= N rem 5,
    N1 #= N - 1,
    fizzbuzz(N1, Sum).
