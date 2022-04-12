; Part 1: Use a lambda with the angles as arguments to calculate sin(pi/4) cos(pi/3) + cos(pi/4) sin(pi/3) again.
((lambda (x y) (+ (* (sin x) (cos y)) (* (cos x) (sin y)))) (/ pi 4) (/ pi 3))

; Part 2: Define a global function to calculate sin(alpha) cos(beta) + cos(alpha) sin(beta) with alpha and beta as parameters.
(define calculateSinCos (lambda (alpha beta) 
  (+ (* (sin alpha) (cos beta)) (* (cos alpha) (sin beta)))))