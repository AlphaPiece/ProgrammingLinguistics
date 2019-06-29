;;;; Exercise 2.13

;;; Show that under the assumption of small percentage tolerances
;;; there is a simple formula for the approximate percentage tolerance
;;; of the product of two intervals in terms of the tolerances of
;;; the factors. You may simplify the problem by assuming that all
;;; numbers are positive.

;;; A = (a - ap, a + ap) 
;;; B = (b - bq, b + bq)
;;;
;;; C = A * B
;;;   = ((a - ap)(b - bq), (a + ap)(b + bq))
;;;   = ((ab - abp - abq + abpq), (ab + abp + abq + abpq))
;;;   = (c_1, c_2)
;;; 
;;; c = (c_1 + c_2) / 2
;;;   = ((ab - abp - abq + abpq) + (ab + abp + abq + abpq)) / 2
;;;   = (2ab + 2abpq) / 2
;;;   = ab + abpq
;;;
;;; r = (c_2 - c) / c
;;;   = (ab + abp + abq + abpq - ab - abpq) / (ab + abpq)
;;;   = (abp + abq) / (ab + abpq)
;;;   = (ab(p + q)) / (ab(1 + pq))
;;;   = (p + q) / (1 + pq)
;;;
;;; C = (c - cr, c + cr)

(define (make-interval a b)
  (if (< a b)
      (cons a b)
      (cons b a)))
(define (lower-bound i) (car i))
(define (upper-bound i) (cdr i))

(define (print-interval z)
  (newline)
  (display "[")
  (display (lower-bound z))
  (display ",")
  (display (upper-bound z))
  (display "]"))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (make-center-percent c p)
  (let ((w (* c p)))
    (make-interval (- c w) (+ c w))))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (percent i)
  (/ (/ (- (upper-bound i) (lower-bound i)) 2)
     (center i)))

(define (print-center-width z)
  (let ((c (center z)))
    (newline)
    (display c)
    (display " ± ")
    (display (* c (percent z)))))

(define a 20)
(define p 0.1)
(define b 30)
(define q 0.1)
(define x (make-center-percent a p))
(define y (make-center-percent b q))
(print-interval (mul-interval x y))

(define c (+ (* a b) (* a b p q)))
(define r (/ (+ p q) (+ 1 (* p q))))
(define z (make-center-percent c r))
(print-interval z)
