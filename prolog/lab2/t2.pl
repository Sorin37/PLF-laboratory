
/* Nume: Antal-Cionta Ioan Sorin
   Grupa: 10LF301 
2. Scrieți un predicat care  calculează minimul dintre suma elementelor de pe poziții pare 
   și suma elementelor de pe poziții impare.

   ex2([l1, l2... ln]){
      min(sumOdd([l1, l2... ln]), sumEven([l1, l2... ln]))
   }

   sumOdd([l1,l2... ln], Flipper){
      [], []
      l1 + sumOdd([l2, l3... ln], Flipper + 1)  , Flipper mod 2 = 1
      sumOdd([l2, l3... ln], Flipper + 1)  , Flipper mod 2 = 0
   }

   sumEven([l1,l2... ln], Flipper){
      [], []
      l1 + sumOdd([l2, l3... ln], Flipper + 1)  , Flipper mod 2 = 0
      sumOdd([l2, l3... ln], Flipper + 1)  , Flipper mod 2 = 1
   }

   min(n1, n2){
      n1 , n1 < n2
      n2 , n1 >= n2
   }

   Cazuri de testare:
   ex2([1,5,3], Return). => Return = 4
   ex2([1,2,3], Return). => Return = 2
   ex2([], Return). => Return = 0
*/

%ex2
ex2(List, Return):-
   sumOdd(List, 1, ReturnOdd),
   sumEven(List, 1, ReturnEven),
   min(ReturnOdd, ReturnEven, ReturnR),
   Return is ReturnR.

%sumOdd
sumOdd([], Flipper, 0).

sumOdd([H|T], Flipper, Return):-
   Flipper mod 2 =:= 1,
   sumOdd(T, Flipper + 1, ReturnR),
   Return is H + ReturnR.

sumOdd([H|T], Flipper, Return):-
   Flipper mod 2 =:= 0,
   sumOdd(T, Flipper + 1, ReturnR),
   Return is ReturnR.

%sumEven
sumEven([], Flipper, 0).

sumEven([H|T], Flipper, Return):-
   Flipper mod 2 =:= 0,
   sumEven(T, Flipper + 1, ReturnR),
   Return is H + ReturnR.

sumEven([H|T], Flipper, Return):-
   Flipper mod 2 =:= 1,
   sumEven(T, Flipper + 1, ReturnR),
   Return is ReturnR.

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

/*5.      Scrieți un predicat care calculează c.m.m.m.c dintre dintre suma elementelor de pe poziții pare 
          și diferența elementelor de pe poziții impare.
   ex5(L){
      cmmmc(sumOdd(L), sumEven(L), max(sumOdd(L), sumEven(L)) + 1)
   }

   max(n1, n2){
      n1 , n1 > n2
      n2 , n1 <= n2
   }

   diffOdd([l1, l2... ln], flipper){
      0, []
      l1 + diffOdd([l2, l3... ln], flipper + 1), flipper = 1
      -l1 + diffOdd([l2, l3... ln], flipper + 1), flipper mod 2 = 1 si flipper > 1
      diffOdd([l2, l3... ln], flipper + 1), flipper mod 2 = 0

   cmmmc(nr1, nr2, c){
      c , c mod nr1 = 0 si c mod nr2 = 0
      cmmmc(nr1, nr2, c + 1), altfel
   }

   Cazuri de testare:
   ex5([1, 2, 3, 4], R) => R = 12
   ex5([37, 23, 32, 41, 42], R) => R = 2368
   ex5([13, 9, 18, 24, 31], R) => R = 396
*/
ex5(L, Return):-
   sumEven(L, 1, ReturnSumEven),
   diffOdd(L, 1, ReturnDiffOdd),
   max(ReturnSumEven, ReturnDiffOdd, ReturnMax),
   cmmmc(ReturnSumEven, ReturnDiffOdd, ReturnMax + 1, ReturnC),
   Return is ReturnC.

%max
max(N1, N2, Return):-
   N1 =:= N2,
   Return is N1.

max(N1, N2, Return):-
   N1 > N2,
   Return is N1.

max(N1, N2, Return):-
   N1 < N2,
   Return is N2.

%diffOdd
diffOdd([], _, 0).
diffOdd([H|T], Flipper, Return):-
   Flipper =:= 1,
   diffOdd(T, Flipper + 1, ReturnR),
   Return is H + ReturnR.

diffOdd([H|T], Flipper, Return):-
   Flipper > 1,
   Flipper mod 2 =:= 1,
   diffOdd(T, Flipper + 1, ReturnR),
   Return is -H + ReturnR.

diffOdd([H|T], Flipper, Return):-
   Flipper mod 2 =:= 0,
   diffOdd(T, Flipper + 1, ReturnR),
   Return is ReturnR.

%cmmmc
cmmmc(Nr1, Nr2, C, Return):-
   C mod Nr1 =:= 0,
   C mod Nr2 =:= 0,
   Return is C.

cmmmc(Nr1, Nr2, C, Return):-
   (C mod Nr1 =\= 0; 
   C mod Nr2 =\= 0),
   cmmmc(Nr1, Nr2, C + 1, ReturnR),
   Return is ReturnR.

/*8.      Scrieți un predicat care transformă o listă într-una de forma: [(element, număr_de_apariții_element)].
   ex8([l1, l2... ln]){
      [], []
      makePair([l1, l2, ln], l1) U ex8(removeEl([l1, l2... ln], l1)) altfel
   }

   makePair([l1, l2... ln], el){
      el U getOcc([l1, l2... ln], el)
   }

   getOcc([l1, l2... ln], el){
      0, []
      1 + getOcc([l2, l3... ln], el) , el = l1
      getOcc([l2, l3... ln], el) , el =\= l1
   }

   removeEl([l1, l2... ln], el){
      [], []
      removeEl([l2, l3... ln]) , el = l1
      l1 U removeEl([l2, l3... ln]) , el =\= l1
   }

   Cazuri de testare:
   ex8([1, 1, 2, 3], R) => [[1, 2], [2, 1], [3, 1]]
   ex8([7, 5, 9, 4, 8, 8, 6, 0], R) => [[7, 1], [5, 1], [9, 1], [4, 1], [8, 2], [6, 1], [0, 1]]
   ex8([1, 1, 2], R) => [[1, 2], [2, 1]]
*/
ex8([], []).
ex8([H|T], [Pair|Return]):-
   makePair([H|T], H, Pair),
   removeEl([H|T], H, ListRemoved),
   ex8(ListRemoved, Return).

%getOcc
getOcc([], _, 0).
getOcc([H|T], El, Return):-
   El =:= H,
   getOcc(T, El, ReturnR),
   Return is 1 + ReturnR.

getOcc([H|T], El, Return):-
   El =\= H,
   getOcc(T, El, ReturnR),
   Return is ReturnR.

%removeEl
removeEl([], _, []).
removeEl([H|T], El, Return):-
   El =:= H,
   removeEl(T, El, Return).
removeEl([H|T], El, [H|Return]):-
   El =\= H,
   removeEl(T, El, Return).

remover([],_, []).
remover([H|T],El, Return) :-
   El =:= H,
   remover(T, El, ReturnR),
   Return is ReturnR.
remover([H|T],El, Return) :-
   El =\= H,
   remover(T, El, ReturnR),
   Return is [H|ReturnR].

%makePair
makePair(L, El, [El, ReturnOcc]):-
   getOcc(L, El, ReturnOcc).

