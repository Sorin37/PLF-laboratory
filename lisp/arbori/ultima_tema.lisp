#|
    Nume: Antal-Cionta Ioan Sorin
    Grupa: 10LF301
    5. Returnați nivelul (adâncimea) pe care se află un nod dat într-un arbore de tipul (1). 
       Nivelul nodului rădăcină este 0.

    ex5([l1, l2... ln], nod, remaining, onNextLayer){
        0, []
        0, l1 = nod
        1 + ex5([l3... ln], nod, onNextLayer + l2, 0), remaining = 1
        ex5([l3... ln], nod, remaining - 1, onNextLayer + l2), remaining > 1
    }

    Exemplu de testare:
    (print (ex5 '("A" 2 "Z" 0 "B" 2 "C" 0 "D" 1 "E" 0) "B")) => 1
    (print (ex5 '("A" 2 "Z" 0 "B" 2 "C" 0 "D" 1 "E" 0) "X")) => -1
    (print (ex5 '("A" 2 "Z" 0 "B" 2 "C" 0 "D" 1 "E" 0) "E")) => 3
|#

(defun myDepth (tree node remaining onNextLayer layer)
  (cond 
        (
         (null tree) -1
        )
        (
         (string= (car tree) node)
         layer
        )
        (
         (= remaining 1)
         (myDepth (cdr (cdr tree)) node (+ onNextLayer (car (cdr tree))) 0 (+ layer 1))
        )
        (
         (> remaining 1) 
         (myDepth (cdr (cdr tree)) node (- remaining 1) (+ onNextLayer (car (cdr tree))) layer)
        )
  )
)
(defun ex5(tree node)
    (myDepth tree node 1 0 0)
)

(print (ex5 '("A" 2 "Z" 0 "B" 2 "C" 0 "D" 1 "E" 0) "B"))



#|
    12. Parcurgeți în preordine un arbore de tipul (1).
|#