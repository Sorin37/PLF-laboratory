allSums([], _, 0, 0).
allSums([H|T], Flipper, ReturnOdd, ReturnEven):-
    Flipper mod 2 =:= 0,
    allSums(T, Flipper + 1, ReturnOddR, ReturnEvenR),
    ReturnOdd is ReturnOddR,
    ReturnEven is H + ReturnEvenR.
allSums([H|T], Flipper, ReturnOdd, ReturnEven):-
    Flipper mod 2 =:= 1,
    allSums(T, Flipper + 1, ReturnOddR, ReturnEvenR),
    ReturnOdd is H + ReturnOddR,
    ReturnEven is ReturnEvenR.

