;;;; Exercise 1.8

;;; Implement cbrt (cube root) using Newton's method for cube roots.

(define (cbrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (cbrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (/ (+ (/ x (square guess))
        (* 2 guess)) 
     3))

(define (good-enough? guess x)
  (< (abs (- (improve guess x) guess))
     (abs (* guess 0.00001))))

(define (cbrt x)
  (if (< x 0)
      (* -1 (cbrt-iter 1.0 (* -1 x)))
      (cbrt-iter 1.0 x)))

(cbrt 27)
(cbrt -27)
(cbrt 100)
(cbrt 101)
(cbrt 102)
(cbrt 150)
(cbrt 100000000000000)
(cbrt 0.00000000000001)

;;; The good-enough? in 1-07 doesn't work at here. So the good-enough? here
;;; checks if the difference between the currect guess and next guess is 
;;; smaller than 0.001% of guess. If so, it is a good enough guess; otherwise
;;; the program keeps finding a more precise one.
