/*
    Nume: Antal-Cionta Ioan Sorin
    Grupa: 10LF301

3.(a) Concatenați 2 liste sortate, cu ștergerea valorilor duplicate.
  (b) Pentru o listă Eterogenă, formată din numere întregi și liste de numere, 
  scrieți un predicat care concateneaza toate sublistele, cu ștergerea valorilor duplicate.
  Exemplu: [1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5, [1, 1, 11], 8] => [1, 2, 3, 4, 6, 7, 9, 10, 11].
    sort([l1, l2... ln]){
        l1 , [l1]
        min([l1, l2... ln]) U sort(deleteFirstOcc([l1, l2... ln], min([l1, l2... ln]))), altfel
    }

    min(n1, n2){
      n1 , n1 < n2
      n2 , n1 >= n2
   }

   deleteFirstOcc([l1, l2.. ln], el, found){
        [] , [] sau found = 1
        l1 U deleteFirstOcc([l2, l3... ln], found) , el =\= l1 si found = 0
        deleteFirstOcc([l2, l3... ln], found + 1) , el == l1 si found = 0
   }

   removeOcc([l1, l2.. ln], el){
        [] , []
        l1 U removeOcc([l2, l3... ln]) , el =\= l1 
        removeOcc([l2, l3... ln]) , el == l1
   }

   minOfList([l1, l2, ...ln]){
        l1, [l1]
        minOfList([l1, l3, l4... ln]), l1 < l2
        minOfList([l2, l3, l4... ln]), l1 > l2
   }

   removeDuplicates([l1, l2... ln]){
        [], []
        l1 U removeDuplicates(removeOcc([l1, l2... ln], l1)) , altfel
   }

   ex3([a1, a2... an], [b1, b2... bn]){
        removeDuplicates(sort(([a1, a2... an] U [b1, b2... bn])))
   }

   Cazuri de testare:
   ex3([1, 2], [1, 3], R). => R = [1, 2, 3]
   ex3([1, 2, 5, 9], [4, 3], R). => R = [1, 2, 3, 4, 5, 9]
   ex3([69, 17, 23, 19], [17, 7, 4, 13], R). => R = [4, 7, 13, 17, 19, 23, 69]

   ex3b([1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5, [1, 1, 11], 8],R). => R = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10|11]
   ex3b([1, [1], [1], 2, [2, 1], 2, [1], [2]], R). => R = [1|2]
   ex3b([1], R). => R = [1]
*/
%ex3
ex3(L1, L2, Return):-
    myAppend(L1, L2, ReturnAppend),
    removeDuplicates(ReturnAppend, ReturnRemoved),
    sort(ReturnRemoved, Return).

%append
myAppend([], L2, L2).
myAppend([H|T], L2, [H|ReturnR]):-
    myAppend(T, L2, ReturnR).
myAppend(H, L2, [H|L2]).

%appendAll
appendAll([H], [H]).
appendAll([H1, H2], Return):-
    number(H2),
    myAppend(H1, [H2], Return).
appendAll([H1, H2], Return):-
    is_list(H2),
    myAppend(H1, H2, Return).
appendAll([H1, H2|T], Return):-
    number(H2),
    myAppend(H1, [H2], ReturnAppend),
    appendAll([ReturnAppend|T], Return).
appendAll([H1, H2|T], Return):-
    is_list(H2),
    myAppend(H1, H2, ReturnAppend),
    appendAll([ReturnAppend|T], Return).

%ex3b
ex3b([], []).
ex3b([H], [H]).
ex3b(L, Return):-
    appendAll(L, ReturnAll),
    removeDuplicates(ReturnAll, ReturnRemoved),
    mySort(ReturnRemoved, Return).

%removeDuplicates
removeDuplicates([], []).
removeDuplicates([H|T], [H|ReturnR]):-
    removeOcc([H|T], H, ReturnRemoved),
    removeDuplicates(ReturnRemoved, ReturnR).

%minOfList
minOfList([H], H).
minOfList([H1, H2|T], Return):-
    H1 < H2,
    minOfList([H1|T], ReturnR),
    Return is ReturnR.
minOfList([H1, H2|T], Return):-
    (H1 > H2;
    H1 = H2),
    minOfList([H2|T], ReturnR),
    Return is ReturnR.

%sort
mySort([H], H).

mySort([H|T], [ReturnMin|ReturnSorted]):-
    minOfList([H|T], ReturnMin),
    deleteFirstOcc([H|T], ReturnMin, 0, ReturnRemoved),
    mySort(ReturnRemoved, ReturnSorted).

%deleteFirstOcc
deleteFirstOcc([], _, _, []).
deleteFirstOcc(L, _, Found, L):-
    Found =:= 1.
deleteFirstOcc([H|T], El, Found, [H|Return]):-
    El =\= H,
    Found =:= 0,
    deleteFirstOcc(T, El, Found, Return).
deleteFirstOcc([H|T], El, Found, Return):-
    El =:= H,
    Found =:= 0,
    deleteFirstOcc(T, El, Found + 1, Return).

%min
min(N1, N2, Return):-
   N1 =:= N2,
   Return is N1.

min(N1, N2, Return):-
   N1 < N2,
   Return is N1.

min(N1, N2, Return):-
   N1 > N2,
   Return is N2.

%removeOcc
removeOcc([], _, []).
removeOcc([H|T], El, [H|Return]):-
    El =\= H,
    removeOcc(T, El, Return).
removeOcc([H|T], El, Return):-
    El =:= H,
    removeOcc(T, El, Return).

/*
6.(a) Scrieți un predicat care calculează produsul unui număr (reprezentat ca lista) cu 
      o constanta (fără a transforma lista în număr)
  Eg.: [1 9 3 5 9 9] * 2 => [3 8 7 1 9 8]
  (b) Pentru o listă Eterogenă, formată din numere întregi și liste de numere,
      scrieți un predicat care înlocuiește fiecare sublistă cu poziția elementului maxim al acelei sublistei.
  [1, [2, 3], [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] => [1, [2], [1, 3], 3, 6, [2], 5, [1, 2, 3], 7]

    multiplyNr([l1, l2... ln], c, isFirst){
        l1 * c % 10 ,[l1]
        1 U (l1 * c + l2 * c div 10) mod 10 U multiplyNr([l2... ln], c), isFirst = 1 and l1 * c + l2 * c div 10 > 9
        (l1 * c + l2 * c div 10) mod 10 U multiplyNr([l2... ln], c), isFirst = 1 and l1 * c + l2 * c div 10 <= 9
        (l1 * c + l2 * c div 10) mod 10 U multiplyNr([l2... ln], c), isFirst = 0
    }

    maxOfList([l1, l2, ...ln]){
        l1, [l1]
        minOfList([l1, l3, l4... ln]), l1 > l2
        minOfList([l2, l3, l4... ln]), l1 < l2
   }

    posOfMax([l1, l2... ln], max, i){
        [], []
        i U posOfMax([l2... ln], max, i + 1), l1 = max
        posOfMax([l2... ln], max, i + 1), l1 =\= max
    }

    ex6a(L, c){
        multiplyNr(L, c, 1)
    }

    ex6b([l1, l2... ln]){
        l1 U ex4b([l2, l3... ln]), l1 numar
        posOfMax([l1, l2... ln], maxOfList([l1, l2... ln]), 1) U ex6b([l2, l3... ln]), l1 list
        [], []
    }


    Cazuri de testare:
    ex6a([3, 1, 9], 2, 1, R) => R = [6, 3, 8]
    ex6a([3, 4, 4, 5], 3, R) => R = [1, 0, 3, 3, 5]
    ex6a([2, 3, 9, 2], 4, R) => R = [9, 5, 6, 8]

    ex6b([1, [2, 3]], R). => R = [1, [2]]
    ex6b([1, [2, 3], [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7], R). 
    => R = [1, [2], [1, 3], 3, 6, [2], 5, [1, 2, 3], 7]
    ex6b([[6, 7, 8, 9, 10, 11], [2, 2, 1, 16, 6], 4, 17, [14]], R) => R = [[6], [4], 4, 17, [1]]
*/

%ex6a
ex6a(L, C, R):-
    multiplyNr(L, C, 1, R).

%multiplyNr
multiplyNr([H], C, IsFirst, [Return]):-
    IsFirst =:= 0,
    H * C > 9,
    Return is H * C mod 10.
multiplyNr([H], C, IsFirst, [1, Return]):-
    IsFirst =:= 1,
    H * C > 9,
    Return is H * C mod 10.
multiplyNr([H], C, _, [Return]):-
    H * C < 9,
    Return is H * C mod 10.
multiplyNr([H1, H2|T], C, IsFirst, [1, Digit| ReturnR]):-
    IsFirst =:= 1,
    H1 * C + H2 * C div 10 > 9,
    multiplyNr([H2|T], C, 0, ReturnR),
    Digit is (H1 * C + H2 * C div 10) mod 10.
multiplyNr([H1, H2|T], C, IsFirst, [Digit| ReturnR]):-
    IsFirst =:= 1,
    (H1 * C + H2 * C div 10 < 9;
    H1 * C + (H2 * C div 10) =:= 9),
    multiplyNr([H2|T], C, 0, ReturnR),
    Digit is (H1 * C + H2 * C div 10) mod 10.
multiplyNr([H1, H2|T], C, IsFirst, [Digit| ReturnR]):-
    IsFirst =:= 0,
    multiplyNr([H2|T], C, 0, ReturnR),
    Digit is (H1 * C + H2 * C div 10) mod 10.

%maxOfList
maxOfList([H], H).
maxOfList([H1, H2|T], Return):-
    H1 > H2,
    maxOfList([H1|T], ReturnR),
    Return is ReturnR.
maxOfList([H1, H2|T], Return):-
    (H1 < H2;
    H1 = H2),
    maxOfList([H2|T], ReturnR),
    Return is ReturnR.

%posOfMax
posOfMax([], _, _, []).
posOfMax([H|T], Max, Index, [Poz|ReturnR]):-
    H =:= Max,
    posOfMax(T, Max, Index + 1, ReturnR),
    Poz is Index.
posOfMax([H|T], Max, Index, ReturnR):-
    H =\= Max,
    posOfMax(T, Max, Index + 1, ReturnR).

%ex6b
ex6b([], []).
ex6b([H|T], [H|ReturnR]):-
    number(H),
    ex6b(T, ReturnR).
ex6b([H|T], [ReturnPos|ReturnR]):-
    is_list(H),
    maxOfList(H, Max),
    posOfMax(H, Max, 1, ReturnPos),
    ex6b(T, ReturnR).
%

/*
10.(a) Scrieți un predicat care scrie de două ori valorile prime.
   (b) Pentru o listă Eterogenă, formată din numere întregi și liste de numere, 
       scrieți un predicat care scrie de două ori valorile prime din subliste.
    Eg.: [1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5] =>
    [1, [2, 2, 3, 3], 4, 5, [1, 4, 6], 3, [1, 3, 3, 7, 7, 9, 10], 5]

    isPrime(nr, p){
        1, nr = p
        0, nr mod p = 0 and nr > p or nr < 2
        isPrime(nr, p + 1), nr > p and nr mod p =\= 0
    }

    ex10a([l1, l2... ln]){
        [], []
        l1 U ex10a([l2... ln]) , isPrime(l1, 2) = 0 
        l1 U l1 U ex10a([l2... ln]) , isPrime(l1, 2) = 1 
    }

    ex10b([l1, l2... ln]){
        [], []
        l1 U ex10b([l2... ln]), l1 number
        ex10a(l1) U ex10b([l2... ln]), l1 list
    }

    Cazuri de testare:
    ex10a([2, 3, 9, 2], R) => R = [2, 2, 3, 3, 9, 2, 2]
    ex10a([1, 2, 3, 4, 5, 6, 7], R) => R = [1, 2, 2, 3, 3, 4, 5, 5, 6, 7, 7]
    ex10a([47, 53, 41, 53, 87, 38, 76], R) => R = [47, 47, 53, 53, 41, 41, 53, 53, 87, 38, 76]

    ex10b([1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5], R) =>
    R = [1, [2, 2, 3, 3], 4, 5, [1, 4, 6], 3, [1, 3, 3, 7, 7, 9, 10], 5]
    ex10b([7, 2, 6, [8, 2], 4, 3, [9, 8, 1], [3, 9], [2, 1], 11], R) =>
    R = [7, 2, 6, [8, 2, 2], 4, 3, [9, 8, 1], [3, 3, 9], [2, 2, 1], 11]
    ex10b([[19, 20, 8], [19, 9], 9, [6, 13]], R) =>
    R = [[19, 19, 20, 8], [19, 19, 9], 9, [6, 13, 13]]
*/

%isPrime
isPrime(Nr, P, 1):-
    Nr =:= P.
isPrime(Nr, P, 0):-
    Nr mod P =:= 0,
    Nr > P;
    Nr < 2.
isPrime(Nr, P, Return):-
    Nr > P,
    Nr mod P =\= 0,
    isPrime(Nr, P + 1, ReturnR),
    Return is ReturnR.

%ex10a
ex10a([], []).
ex10a([H|T], [H|ReturnR]):-
    isPrime(H, 2, ReturnPrime),
    ReturnPrime =:= 0,
    ex10a(T, ReturnR).
ex10a([H|T], [H,H|ReturnR]):-
    isPrime(H, 2, ReturnPrime),
    ReturnPrime =:= 1,
    ex10a(T, ReturnR).

%ex10b
ex10b([], []).
ex10b([H|T], [H|ReturnR]):-
    number(H),
    ex10b(T, ReturnR).
ex10b([H|T], [ReturnList|ReturnR]):-
    is_list(H),
    ex10a(H, ReturnList),
    ex10b(T, ReturnR).
