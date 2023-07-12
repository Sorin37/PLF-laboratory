permutari([],[]).
permutari(Lista, Rezultat):-
    select(Element, Lista, Rest),
    permutari(Rest, Lista_permutare),
    Rezultat = [Element|Lista_permutare].
all_solutions(L, RALL):-
    findall(ROS, permutari(L,ROS), RALL).

/*2. Fiind date puncte n puncte în plan (reprezentate ca perechi de coordonatele), 
     scrieți un predicat care să determine toate subseturile de puncte coliniare.

    
*/


