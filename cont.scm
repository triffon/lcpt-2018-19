(define (fact n)
  (if (= n 0) 1
      (* n (fact (- n 1)))))

(define (fact-c n return)
  (if (= n 0)
      (return 1)
      (fact-c (- n 1) (lambda (m) (return (* m n))))))

(define (f return)
  (* (return 2) 3))
