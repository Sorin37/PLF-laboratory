%occ cu subliste
occ_list([], Val, 0).
occ_list([H|T], Val, Return):-
    atom(H),
    occ_list(T, Val, ReturnR),
    Return is ReturnR.
occ_list([H|T], Val, Return):-
    is_list(H),
    occ(H, Val, ReturnOcc),
    occ_list(T, Val, ReturnR),
    Return is ReturnOcc + ReturnR.
occ_list([H|T], Val, Return):-
    number(H),
    H =:= Val,
    occ_list(T, Val, ReturnR),
    Return is ReturnR + 1.
occ_list([H|T], Val, Return):-
    number(H),
    H =\= Val,
    occ_list(T, Val, ReturnR),
    Return is ReturnR.

%occ_normal
occ([], _, 0).

occ([Cap|Coada], Val, Nr):-
    Cap =:= Val,
    occ(Coada, Val, Nr_rec),
    Nr is Nr_rec + 1.

occ([Cap|Coada], Val, Nr):-
    Cap =\= Val,
    occ(Coada, Val, Nr_rec),
    Nr is Nr_rec.
    
