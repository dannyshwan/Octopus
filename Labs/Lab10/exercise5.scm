(define (drop numList k)
  (dropHelper numList k 1)
)

(define (dropHelper numList k c)
  (cond 
    ((null? numList) `())
    ((= c k) (dropHelper (cdr numList) k 1))
    (else (cons (car numList) (dropHelper (cdr numList) k (+ c 1))))
  )
)