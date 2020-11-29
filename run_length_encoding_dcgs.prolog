

% Empty list is finished
encode([]) --> [].

encode([N, C]) --> [C], { N1 #= N + 1, encode([N1, C]) }.
