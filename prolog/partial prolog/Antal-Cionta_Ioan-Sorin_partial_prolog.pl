/*
Pentru o lista liniară, eliminați elementele repetitive de pe poziții consecutive. 
Ordinea elementelor nu trebuie schimbată. Calculați produsul elementelor listei rezultate.

compress ([1 1 1 3 3 4 2 2 2 5 6 6 6 6 7 7 6 ],L,P) L = (1 3 4 2 5 6 7 6)

P = 30.240
    randu 2
    compress([l1, l2... ln]){
        l1, [l1]
        l1 U compress(removeSeq([l1, l2... ln], l1)), altfel
    }

    removeSeq([l1, l2... ln], nr){
        removeSeq([l2, l3... ln], nr), l1 = nr
        [l1, l2, l3... ln] , l1 =\= nr
        [], []
    }

    prodOfList([l1, l2... ln]){
        1, []
        l1 * prodOfList([l2.. ln]), altfel
    }

    r2(InputList, L, P){
        L = compress(InputList)
        P = prodOfList(L)
    }
*/
r2(L, ReturnCompress, ReturnProd):-
    compress(L, ReturnCompress),
    prodOfList(ReturnCompress, ReturnProd).

%prodOfList
prodOfList([], 1).
prodOfList([H|T], Return):-
    prodOfList(T, ReturnR),
    Return is H * ReturnR.

%removeSeq
removeSeq([], _, []).
removeSeq([H|T], Nr, [H|T]):-
    H =\= Nr.
removeSeq([H|T], Nr, ReturnR):-
    H =:= Nr,
    removeSeq(T, Nr, ReturnR).

%compress
compress([H], H).
compress([H|T], [H|ReturnR]):-
    removeSeq(T, H, ReturnSeq),
    compress(ReturnSeq, ReturnR).

