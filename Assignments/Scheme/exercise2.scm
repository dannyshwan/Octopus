; Main find-abundant function
(define (find-abundant num) (find-abundant-rec num `()))

; Recursive function for the find-abundant function
(define (find-abundant-rec num L) 
  (cond
    ((= num 0) L) ; Checks if num has been decremented to 0
    ((> (sum (find-divisors num num `())) (* 2 num)) ; Checks for if the sum of all divisors > 2n
      (find-abundant-rec (- num 1) (append L (list num)))) ; If so, add abundant number to return list, decrement num
    (else (find-abundant-rec (- num 1) L)) ; Otherwise, continue and decrement num
  )
)

; helper function for finding all divisors to a number
(define (find-divisors num currNum divisors) 
  (cond
    ((= currNum 0) divisors) ; Check if currNum has been decremented to 0
    ((equal? 0 (remainder num currNum)) (find-divisors num (- currNum 1) (append divisors (list currNum)))) ; Checks if currNum is a divisor
    (else (find-divisors num (- currNum 1) divisors)) ; If currNum is not a divisor, continue
  )
)

; helper function to get the sum of the divisors
(define (sum list)
  (if (null? list)
    0
    (+ (car list) (sum (cdr list)))
))