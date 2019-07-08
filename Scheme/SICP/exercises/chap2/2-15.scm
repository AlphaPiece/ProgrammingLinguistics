;;;; Exercise 2.15

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

;;; Eva Lu Ator, another user, has also noticed the different intervals
;;; computed by different but algebraically equivalent expressions. She
;;; says that a formula to compute with intervals using Alyssa’s system
;;; will produce tighter error bounds if it can be written in such a
;;; form that no variable that represents an uncertain number is repeated.
;;; Thus, she says, par2 is a "better" program for parallel resistances
;;; than par1. Is she right? Why?

(define r1 (make-interval 997 1003))
(define r2 (make-interval 997 1003))

(print-interval (par1 r1 r2))       ; [495.5179461615154,504.5180541624875]
(print-interval (par2 r1 r2))       ; [498.5,501.50000000000006]

;;; par2 does produce a tighter error bounds.
;;; But I am not sure if par2 is better or not.
