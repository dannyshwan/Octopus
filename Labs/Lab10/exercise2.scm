(define L '(1 2 3 4 5))
(define LL '(1 (2 3 4) (5)))

; Part 1: Combine calls car and cdr to get the element 2, 3, 4 and 5 from the list L (4 solutions).
; -----------------------------
; Get 2
(car (cdr L))

; Get 3
(car (cddr L)) ; cddr L = (cdr (cdr L))

; Get 4
(car (cdddr L)) ; cdddr L = (cdr (cdr (cdr L)))

; Get 5
(car (cddddr L)) ; cddddr L = (cdr (cdr (cdr (cdr L))))

; Part 2: Combine calls car and cdr to get the element 2 and 5 from the list LL (2 solutions).
; -----------------------------
; Get 2
(car (car (cdr LL)))

; Get 5
(car (car (cddr LL))) ; cddr LL = (cdr (cdr LL))
