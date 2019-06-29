;;;; Exercise 2.7

;;; Alyssa’s program is incomplete because she has not specified
;;; the implementation of the interval abstraction. Here is a
;;; definition of the interval constructor:

(define (make-interval a b) (cons a b))

;;; Define selectors upper-bound and lower-bound to complete the
;;; implementation.

(define (lower-bound z)
  (min (car z) (cdr z)))
(define (upper-bound z)
  (max (car z) (cdr z)))

(define x (make-interval 40 81))
(lower-bound x)
(upper-bound x)
(define y (make-interval 10 -1))
(lower-bound y)
(upper-bound y)
