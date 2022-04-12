; Main make-string-list function
(define (make-string-list num) (count-down num `()))

; Recursive function for the make-string-list function
(define (count-down num countList) 
  (cond
    ((= num 0) (append countList (list "Finished"))) ; If num = 0, then add "Finished" to the list
    ((= num 1) (count-down (- num 1) (append countList (list (string-append (number->string num) " second"))))) ; If num = 1, append "1 second" to list

    ; If num > 0, we call the recursive function again, decrement num, and append "num seconds" to the list
    (else (count-down (- num 1) (append countList (list (string-append (number->string num) " seconds")))))
  )
)