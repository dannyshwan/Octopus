; assuming that the user's input low < high
(define (range l h)
  (if (> l h)
    `()
    (cons l (range (+ l 1) h)) 
  )
)