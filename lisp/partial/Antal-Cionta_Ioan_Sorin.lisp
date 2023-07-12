#|
    Antal-Cionta Ioan Sorin
    Grupa: 10LF301

    pr5([l1, l2... ln], nr){
        [], []
        l1 U pr5([l2... ln]), nr != l1
        pr5([l2... ln]), nr = l1
    }
|#
(defun pr5(lista nr)
    (cond
        (
         (null lista) 
         nill
        )
        (
         (/= nr (car lista))
         (append (car lista) (pr5 (cdr lista) nr))
        )
        (
         (= nr (car lista))
         (pr5 (cdr lista) nr)
        )
    )
)
(print (pr5 '(1 2 3 2 4 6) 2))