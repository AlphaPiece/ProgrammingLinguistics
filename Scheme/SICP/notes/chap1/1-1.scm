;;; 1.1.4

(define (square x)
  (* x x))

;;; 1.1.7

(define (average x y)
  (/ (+ x y) 2))

;;; 1.1.8

(define (sqrt x)
  (define (good-enough? guess)
    (= (improve guess) guess))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))
