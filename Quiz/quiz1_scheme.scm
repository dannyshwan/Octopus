(define (sum elList)
  (if (null? elList)
    0
    (+ (car elList) (sum (cdr elList)))
))

(* 4 (sum `(3 7 2 8 1)))