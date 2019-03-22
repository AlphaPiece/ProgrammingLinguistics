(define (abs x)
  (if (< x 0)
      (- x)
      x))

(define (max x y)
  (if (> x y)
      x
      y))

(define (min x y)
  (if (< x y)
      x
      y))

(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (average x y)
  (/ (+ x y) 2))

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
