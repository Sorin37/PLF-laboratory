/*
    Nume: Antal-Cionta Ioan Sorin
    Grupa: 10LF301
    2. Fiind date puncte n puncte în plan (reprezentate ca perechi de coordonatele), 
     scrieți un predicat care să determine toate subseturile de puncte coliniare.

    isCol([[x1, y1], [x2, y2], [x3, y3]]){
        1, x1*(y2 - y3) + x2*(y3 - y1) + x3*(y1 - y2) = 0
        0, x1*(y2 - y3) + x2*(y3 - y1) + x3*(y1 - y2) =\= 0
    }

    colls([L1, L2...Ln]){
        L1 U colls([L2, L3... Ln]), isCol(L1) = 1
        colls([L2, L3... Ln]), isCol(L1) = 0
        [], []
    }

    Cazuri de testare:
    ex2([[0,0], [0,0], [-5,2]], R). => R = [[[0, 0], [0, 0], [-5, 2]]]
    ex2([[1,2], [2,3], [3,4], [0,0], [0,0], [-5,2]], R). =>
    R = [
            [[1, 2], [2, 3], [3, 4]],
            [[1, 2], [0, 0], [0, 0]],
            [[2, 3], [0, 0], [0, 0]],
            [[3, 4], [0, 0], [0, 0]],
            [[0, 0], [0, 0], [-5, 2]]
        ]

    ex2([[1,2], [2,3], [3,4], [4,5], [0,0], [-5,2]], R). =>
    R = [
            [[1, 2], [2, 3], [3, 4]],
            [[1, 2], [2, 3], [4, 5]],
            [[1, 2], [3, 4], [4, 5]],
            [[2, 3], [3, 4], [4, 5]]
        ]

*/
c(_, 0, []).

c([H|T], K, [H|Return]):-
    K > 0,
    KR is K - 1,
    c(T, KR, Return).

c([_|T], K, Return):-
    K > 0,
    c(T, K, Return).

combinations(L, K, Return):-
    findall(ROS, c(L, K, ROS), Return).

isCol([[X1, Y1], [X2, Y2], [X3, Y3]], 1):-
    X1*(Y2 - Y3) + X2*(Y3 - Y1) + X3*(Y1 - Y2) =:= 0.
isCol([[X1, Y1], [X2, Y2], [X3, Y3]], 0):-
    X1*(Y2 - Y3) + X2*(Y3 - Y1) + X3*(Y1 - Y2) =\= 0.

colls([], []).
colls([H|T], [H|ReturnR]):-
    isCol(H, ReturnCol),
    ReturnCol =:= 1,
    colls(T, ReturnR).
colls([H|T], ReturnR):-
    isCol(H, ReturnCol),
    ReturnCol =:= 0,
    colls(T, ReturnR).

ex2(L, ReturnColls):-
    combinations(L, 3, ReturnCombinations),
    colls(ReturnCombinations, ReturnColls).


/*
    8. Pentru o lista cu n elemente, determinati toate subseturile care au suma elementelor divizibila cu n.

    getLength([l1, l2... ln]){
        0, []
        1 + getLength([l2... ln]), altfel
    }

    sum([l1, l2... ln]){
        0, []
        l1 + sum([l2... ln]), altfel
    }

    filterSdbn([L1, L2...Ln], N){
        L1 U filterSdbn([L2, L3... Ln], N), sum(L1) mod N = 0
        filterSdbn([L2, L3... Ln], N), sum(L1) mod N =\= 0
        [], []
    }

    Cazuri de testare:
    ex8([1,2,3,4], R). => R = [[4], [1, 3], [1, 3, 4]]
    ex8([7, 1, 9, 3, 5], R). => R = [[5], [7, 3], [1, 9], [7, 3, 5], [1, 9, 5], [7, 1, 9, 3], [7, 1, 9, 3, 5]]
    ex8([4, 8, 9, 7], R). => R = [[4], [8], [4, 8], [9, 7], [4, 9, 7], [8, 9, 7], [4, 8, 9, 7]]
*/

getLength([], 0).
getLength([_|T], Return):-
    getLength(T, ReturnR),
    Return is 1 + ReturnR.

sum([], 0).
sum([H|T], Return):-
    sum(T, ReturnR),
    Return is H + ReturnR.

filterSdbn([], _, []).
filterSdbn([H|T], N, [H|ReturnR]):-
    sum(H, ReturnSum),
    ReturnSum mod N =:= 0,
    filterSdbn(T, N, ReturnR).
filterSdbn([H|T], N, ReturnR):-
    sum(H, ReturnSum),
    ReturnSum mod N =\= 0,
    filterSdbn(T, N, ReturnR).

ex8(L, ReturnFilterSdbn):-
    getLength(L, ReturnLength),
    allKCombinations(L, 1, ReturnLength, ReturnAllKCombinations),
    filterSdbn(ReturnAllKCombinations, ReturnLength, ReturnFilterSdbn).

myAppend([], L2, L2).
myAppend([H|T], L2, [H|ReturnR]):-
    myAppend(T, L2, ReturnR).
myAppend(H, L2, [H|L2]).

allKCombinations(L, I, N, [L]):-
    I =:= N.
allKCombinations(L, I, N, Return):-
    I < N,
    combinations(L, I, ReturnCombinations),
    allKCombinations(L, I + 1, N, ReturnR),
    myAppend(ReturnCombinations, ReturnR, ReturnFinal),
    Return = ReturnFinal.
