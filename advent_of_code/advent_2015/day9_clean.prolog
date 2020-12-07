path(tristram, alphacentauri, 34).
path(tristram, snowdin, 100).
path(tristram, tambi, 63).
path(tristram, faerun, 108).
path(tristram, norrath, 111).
path(tristram, straylight, 89).
path(tristram, arbre, 132).
path(alphacentauri, snowdin, 4).
path(alphacentauri, tambi, 79).
path(alphacentauri, faerun, 44).
path(alphacentauri, norrath, 147).
path(alphacentauri, straylight, 133).
path(alphacentauri, arbre, 74).
path(snowdin, tambi, 105).
path(snowdin, faerun, 95).
path(snowdin, norrath, 48).
path(snowdin, straylight, 88).
path(snowdin, arbre, 7).
path(tambi, faerun, 68).
path(tambi, norrath, 134).
path(tambi, straylight, 107).
path(tambi, arbre, 40).
path(faerun, norrath, 11).
path(faerun, straylight, 66).
path(faerun, arbre, 144).
path(norrath, straylight, 115).
path(norrath, arbre, 135).
path(straylight, arbre, 127).

%    Run part 1 with this
% length(D, 8), fd_minimize(travel(A, B, C, D), C).
%    Run part 2 with this
% length(D, 8), fd_maximize(travel(A, B, C, D), C).

% You start with no places left to visit
% End just needs to be a valid location
% note that this puts the starting position at the end of
% the output list
travel(_, Start, 0, [Start]) :-
    path(Start, _, _).

travel(Start, End, Dist, [End|Visited]) :-
    (path(Start, End, D) ; path(End, Start, D)),
    travel(_, Start, PreviousDist, Visited),
    \+member(End, Visited),
    Dist is D + PreviousDist.
