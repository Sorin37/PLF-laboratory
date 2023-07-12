#|
    Nume: Antal-Cionta Ioan Sorin
    Grupa: 10LF301
    17. Definiți o listă care să returneze numărul maxim de elemente numerice, 
        de la nivel superior.

    ex17([l1, l2... ln]){
        0, []
        1 + ex17([l2... ln]), l1 numar
        ex17([l2... ln]), l1 altceva
    }

    Exemplu de testare:
    countTopLevelNumbers '(5 (2 3) 3 1 (3 4) 6) => 4
    countTopLevelNumbers '((2 3) (2 3) (3 1) (3 4) (6)) => 0
    countTopLevelNumbers '(1 1 1 1 1 1 1) => 7
|#

(defun countTopLevelNumbers (L)
  (cond ((null L) 0)
        ((numberp (car L))
         (+ 1 (countTopLevelNumbers (cdr L)))
        )
        (t
         (countTopLevelNumbers (cdr L))
        )
  )
)
        
#|
    18. Scrieți de două ori al n-lea element dintr-o listă liniară.

    Exemplu: (10 20 30 40 50) și n = 3, se va obține: (10 20 30 30 40 50)

    ex18([l1, l2... ln], p, n){
        l1 U ex18([l2, l3... ln], n), p =\= n
        l1 U [l1, l2, l3... ln], p == n
    }

    Caz de testare:
    ex18 '(1 2 3 4 5) 5) => (1 2 3 4 5 5)
    ex18 '(1 2 3 4 5) 1) => (1 1 2 3 4 5)
    ex18 '(1 2 3 4 5) 3) => (1 2 3 3 4 5)

|#

(defun myDouble (L p n)
  (cond ((null L) nil)
        ((/= p n)
         (append (list (car L)) (myDouble (cdr L) (+ 1 p) n))
        )
        ((= p n)
         (append (list (car L)) L)
        )
  )
)

(defun ex18(L n)
 (cond (t
        (myDouble L 1 n)
       )
 )
)
        
#|
    19. Scrieți o funcție care să returneze o lista de perechi din două liste liniare date.

    Exemplu: (A B C) (X Y Z) --> ((A.X) (B.Y) (C.Z))

    ex19([a1, a2... an], [b1, b2... bn]){
        [], []
        [a1.b1] U ex19([a2, a3... an], [b1, b2... bn]), atlfel
    }

    (print (pairs '(1 2 3) '(1 2 0))) => ((1 . 1) (2 . 2) (3 . 0))
    (print (pairs '(1 2 3) '(0))) => ((1 . 0)) 
    (print (pairs '(2 3) '(0 41231 231))) => ((2 . 0) (3 . 41231)) 
|#

(defun pairs (A B)
  (cond ((null A) nil)
        ((null B) nil)
        (t
         (append 
          (list (cons (car A) (car B)))
          (pairs (cdr A) (cdr B))
         )
        )
  )
)

#|
    20. Scrieți o funcție care să returneze o listă cu toate sublistele ale unei 
    liste neliniare date ca parametru. O sublistă reprezintă fie lista originală, 
    fie orice alt element al acelei liste.

    Exemplu: (1 2(3 (4 5) (6 7) ) 8 (9 10)) => 
    5 subliste: ( (1 2 (3 (4 5) (6 7)) 8 (9 10)) ; (3 (4 5) (6 7)) ; (4 5) ; (6 7) și (9 10)

    allSublists([l1, l2... ln]){
        afiseaza l1 si allSublists([l2, l3... ln]), l1 este lista
        allSublists([l2, l3... ln]), l1 nu este lista
    }

    Cazuri de testare:
    (print (ex20 '((1)(2)(3)(4)))) => (((1) (2) (3) (4)) (1) (2) (3) (4)) 
    (print (ex20 '((1 2)(2 2)(3 2)(4 (2))))) => (((1 2) (2 2) (3 2) (4 (2))) (1 2) (2 2) (3 2) (4 (2)) (2)) 
    (print (ex20 '(1 (2 (3))))) => ((1 (2 (3))) (2 (3)) (3)) 
|#

(defun allSublists (A)
  (cond 
        (
         (numberp (car A))
         (allSublists (cdr A))
        )
        (
         (and 
          (listp (car A)) 
          (not (null (car A)))
         )
         (append
         (append (list(car A)) (allSublists (car A))
         )
         (allSublists (cdr A))
         )
        )
        (t nil)
  )
)

(defun ex20 (A)
    (append (list A) (allSublists A))
)

(print (ex20 '(1 2(3 (4 5) (6 7) ) 8 (9 10))))
