(define (repeated n f x)
  (if (= n 0) x
      (f (repeated (- n 1) f x))))

(define (c n)
  (lambda (f)
    (lambda (x)
      (repeated n f x))))

(define (1+ x) (+ x 1))

(define (printn cn)
  ((cn 1+) 0))

(define c0 (c 0))
(define c1 (c 1))
(define c5 (c 5))
(define c3 (c 3))

(define cs
  (lambda (n)
    (lambda (f)
      (lambda (x)
        (f ((n f) x))))))

(define cs1
  (lambda (n)
    (lambda (f)
      (lambda (x)
        ((n f) (f x))))))

(define c+
  (lambda (m)
    (lambda (n)
      (lambda (f)
        (lambda (x)
          ((m f) ((n f) x)))))))

(define c+1
  (lambda (m)
    (lambda (n)
      (lambda (f)
        (lambda (x)
          ((n f) ((m f) x)))))))

(define c+2
  (lambda (m)
    (lambda (n)
      ((m cs) n))))


(define c*
  (lambda (m)
    (lambda (n)
      (lambda (f)
        (m (n f))))))

(define c*1
  (lambda (m)
    (lambda (n)
      ((m (c+ n)) c0))))

(define cexp
  (lambda (m)
    (lambda (n)
      ((n (c* m)) c1))))
  
(define cexp1
  (lambda (m)
    (lambda (n)
      (n m))))

(define cexp1
  (lambda (m)
    (lambda (n)
      (m))))

(define I
  (lambda (x) x))

(define K
  (lambda (x) (lambda (y) x)))

(define K*
  (lambda (x) (lambda (y) y)))

(define ctrue K)
(define cfalse K*)

(define (printbool cb)
  ((cb #t) #f))

(define cneg
  (lambda (b)
    ((b cfalse) ctrue)))

(define cneg1
  (lambda (b)
    (lambda (x)
      (lambda (y)
        ((b y) x)))))

(define cand
  (lambda (p)
    (lambda (q)
      ((p q) p))))

(define cor
  (lambda (p)
    (p p)))

(define c=0
  (lambda (n)
    ((n (lambda (m) cfalse))
     ctrue)))

(define c/2
  (lambda (n)
    ((n cneg) ctrue)))

(define ccons
  (lambda (x)
    (lambda (y)
      (lambda (z)
        ((z x) y)))))

(define cl
  (lambda (u) (u ctrue)))

(define cr
  (lambda (u) (u cfalse)))

(define (printpairn cu)
  (cu (lambda (x)
        (lambda (y)
          (cons (printn x)
                (printn y))))))


(define cp
  (lambda (n)
    (cr
     ((n (lambda (u)
           ((ccons (cs (cl u)))
            (cl u))))
      ((ccons c0) c0)))))

(define c!
  (lambda (n)
    (cr
     ((n (lambda (u)
           ((ccons (cs (cl u)))
            ((c* (cs (cl u)))
             (cr u)))))
      ((ccons c0) c1)))))
    
