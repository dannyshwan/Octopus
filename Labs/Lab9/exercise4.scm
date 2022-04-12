; Define a global function that finds both roots of a quadratic equation ax^2+bx+c = 0 with a,b,c as arguments.
(define quad (lambda (a b c) (list (quadraticPos a b c) (quadraticNeg a b c))))

; helper functions for finding the roots
(define quadraticPos (lambda (a b c) (/ (+ (* b -1) (sqrt (- (* b b) (* 4 a c)))) (* 2 a))))

(define quadraticNeg (lambda (a b c) (/ (- (* b -1) (sqrt (- (* b b) (* 4 a c)))) (* 2 a))))