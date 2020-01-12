;;;; Exercise 2.14

(define (make-interval a b)
  (if (< a b)
      (cons a b)
      (cons b a)))
(define (lower-bound i) (car i))
(define (upper-bound i) (cdr i))

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
(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))
(define (print-interval z)
  (newline)
  (display "[")
  (display (lower-bound z))
  (display ",")
  (display (upper-bound z))
  (display "]"))

;;; Parallel-resistors formula 1:
;;;
;;;  R_1 * R_2
;;; -----------
;;;  R_1 + R_2

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

;;; Parallel-resistors formula 2:
;;;
;;;          1
;;; -------------------
;;;  1 / R_1 + 1 / R_2

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

;;; Lem complains that Alyssa’s program gives different answers for
;;; the two ways of computing. This is a serious complaint.
;;;
;;; Demonstrate that Lem is right. Investigate the behavior of the
;;; system on a variety of arithmetic expressions. Make some intervals
;;; A and B, and use them in computing the expressions A/A and A/B.
;;; You will get the most insight by using intervals whose width is
;;; a small percentage of the center value. Examine the results of
;;; the computation in center-percent form (see exercise 2.12).

(define r1 (make-interval 2 6))
(define r2 (make-interval 4 9))

(print-interval (par1 r1 r2))       ; [.5333333333333333,9.]
(print-interval (par2 r1 r2))       ; [1.3333333333333333,3.5999999999999996]

;;; The two algebraically equivalent formulas yield different result.

(define a (make-interval 997 1003))
(define b (make-interval 997 1003))

(print-interval (div-interval a a)) ; [.9940179461615154,1.0060180541624875]
(print-interval (div-interval a b)) ; [.9940179461615154,1.0060180541624875]

;;; Since we haven't define what the identity is in interval arithmetic,
;;; a/a and a/b yields the same result.
