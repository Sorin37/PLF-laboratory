occ([], _, 0).

occ([Cap|Coada], Val, Nr):-
    Cap =:= Val,
    occ(Coada, Val, Nr_rec),
    Nr is Nr_rec + 1.

occ([Cap|Coada], Val, Nr):-
    Cap =\= Val,
    occ(Coada, Val, Nr_rec),
    Nr is Nr_rec.

suma([], 0).

suma([H|T], S):-
    suma(T, S_rec),
    S is H + S_rec.
