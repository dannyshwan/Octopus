(define (removeNegative L)
 (cond
  ((null? L) '())
  ((< (car L) 0) (removeNegative (cdr L)))
  (else (append (list (car L))
       (removeNegative (cdr L))))
  ) )