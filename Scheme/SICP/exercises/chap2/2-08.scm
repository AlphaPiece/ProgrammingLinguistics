;;;; Exercise 2.8

;;; Using reasoning analogous to Alyssa’s, describe how the difference
;;; of two intervals may be computed. Define a corresponding subtraction
;;; procedure, called sub-interval.

(define (make-interval a b) (cons a b))
(define (lower-bound z) (min (car z) (cdr z)))
(define (upper-bound z) (max (car z) (cdr z)))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (print-interval z)
  (newline)
  (display "[")
  (display (lower-bound z))
  (display ",")
  (display (upper-bound z))
  (display "]"))

(define x (make-interval 2 7))
(print-interval x)
(define y (make-interval -7 9))
(print-interval y)

(print-interval (sub-interval x y))
(print-interval (sub-interval y x))
