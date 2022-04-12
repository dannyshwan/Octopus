; '(3 4)
(cons 3 `(4))

; '(1 2 3)
(cons 1 `(2 3))

; '(a (b c))
(cons `a (cons (cons `b `(c)) `()))

; '(1)
(cons 1 `())

; '(2 (3 (4)))
(cons 2 (cons (cons 3 (cons `(4) `())) `()))