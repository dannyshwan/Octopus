; Main lowest-exponent function
(define (lowest-exponent base target) (lowest-exp-recursion base target 0))

; Recursive function
(define (lowest-exp-recursion base target current) (
  if (>= (expt base current) target) ; Check if base to the power of the current exponent is greater than or equal to the target
    current ; Return current exponent
    (lowest-exp-recursion base target (+ current 1)) ; Call recursive function and increment current component
))