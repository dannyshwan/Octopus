; Without Lambda Function
; ---------------------
; Part 1: Calculate the sum of the squares for the numbers 1 to 4. Hint: Your result should be 30.
(+ (* 1 1) (* 2 2) (* 3 3) (* 4 4))

; Part 2: Calculate both solutions to 2x^2 + 5x - 3 = 0.
(/ (+ -5 (sqrt (- (* 5 5) (* 4 2 -3)))) (* 2 2))
(/ (- -5 (sqrt (- (* 5 5) (* 4 2 -3)))) (* 2 2))

; Part 3: Calculate the result of the sin(pi/4) cos(pi/3) + cos(pi/4) sin(pi/3)
(+ (* (sin (/ pi 4)) (cos (/ pi 3))) (* (cos (/ pi 4)) (sin (/ pi 3))))

; With Lambda Function
; ---------------------
; Part 1: Calculate the sum of the squares for the numbers 1 to 4. Hint: Your result should be 30.
(let ((f (lambda (x) (* x x)))) (+ (f 1) (f 2) (f 3) (f 4)))

; Part 2: Calculate both solutions to 2x^2 + 5x - 3 = 0.
(let ((f (lambda (x y z) 
  (list 
    (/ (+ (* y -1) (sqrt (- (* y y) (* 4 x z)))) (* 2 x))
    (/ (- (* y -1) (sqrt (- (* y y) (* 4 x z)))) (* 2 x))
  ))))
  (f 2 5 -3))

; Part 3: Calculate the result of the sin(pi/4) cos(pi/3) + cos(pi/4) sin(pi/3)
(let ((f (lambda (a b) 
  (+ (* (sin a) (cos b)) (* (cos a) (sin b)))))) 
  (f (/ pi 4) (/ pi 3)))