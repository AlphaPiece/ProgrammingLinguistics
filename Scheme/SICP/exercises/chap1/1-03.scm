;;;; Exercise 1.3

;;; Define a procedure that takes three numbers as arguments and returns
;;; the sum of the squares of the two larger numbers.

(define (max a b)
  (if (> a b) a b))

(define (min a b)
  (if (< a b) a b))

(define (sum_sq_2_max a b c)
  (+ (square (max a b))
     (square (max (min a b) c))))

(sum_sq_2_max 1 2 3)
(sum_sq_2_max 3 2 1)
(sum_sq_2_max 1 2 1)
(sum_sq_2_max 3 3 3)
