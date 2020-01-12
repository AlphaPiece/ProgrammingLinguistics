;;;; Exercise 2.9

;;; The width of an interval is half of the difference between
;;; its upper and lower bounds. The width is a measure of the
;;; uncertainty of the number specified by the interval. For
;;; some arithmetic operations the width of the result of combining
;;; two intervals is a function only of the widths of the argument
;;; intervals, whereas for others the width of the combination is
;;; not a function of the widths of the argument intervals. Show
;;; that the width of the sum (or difference) of two intervals
;;; is a function only of the widths of the intervals being added
;;; (or subtracted). Give examples to show that this is not true
;;; for multiplication or division.

(define (make-interval a b) (cons a b))
(define (lower-bound z) (min (car z) (cdr z)))
(define (upper-bound z) (max (car z) (cdr z)))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (width-interval z)
  (/ (- (upper-bound z) (lower-bound z)) 2))

(define x (make-interval 2 7))
(define y (make-interval 3 10))
(define z (make-interval -6 1))

(width-interval x)      ; 5/2
(width-interval y)      ; 7/2
(width-interval z)      ; 7/2

(width-interval (add-interval x y))     ; 6
(width-interval (add-interval x z))     ; 6

(width-interval (mul-interval x y))     ; 32
(width-interval (mul-interval x z))     ; 49/2

;;; Since y and z have the same width, adding x and y and adding x and z
;;; both produces the same result show that the width of the result of
;;; adding two intervals is a function only of the widths of the argument
;;; intervals, whereas for multiplication the width of the result is not
;;; a function fo the widths of the argument intervals.
